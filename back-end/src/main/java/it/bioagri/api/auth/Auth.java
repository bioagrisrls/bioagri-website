/*
 * MIT License
 *
 * Copyright (c) 2020 BioAgri S.r.l.s.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 */

package it.bioagri.api.auth;

import ch.qos.logback.classic.Logger;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import it.bioagri.api.ApiPermissionPublic;
import it.bioagri.api.ApiResponseStatus;
import it.bioagri.models.User;
import it.bioagri.models.UserRole;
import it.bioagri.models.UserStatus;
import it.bioagri.persistence.DataSource;
import it.bioagri.utils.Mail;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.Instant;


@RestController
@RequestMapping("/api/auth")
public final class Auth {

    private final static Logger logger = (Logger) LoggerFactory.getLogger(Auth.class);

    private final AuthToken authToken;
    private final AuthService authService;
    private final DataSource dataSource;
    private final ServletContext servletContext;

    @Autowired
    public Auth(AuthToken authToken, AuthService authService, DataSource dataSource, ServletContext servletContext) {
        this.authToken = authToken;
        this.authService= authService;
        this.dataSource = dataSource;
        this.servletContext = servletContext;
    }


    @Operation(description = "Authenticate an user with email and password.")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Authentication successful"),
        @ApiResponse(responseCode = "400", description = "Username/password empty or invalid"),
        @ApiResponse(responseCode = "404", description = "Username/password wrong"),
    })
    @PostMapping("authenticate")
    @ApiPermissionPublic
    public ResponseEntity<AuthToken> authenticate(@RequestBody AuthLogin authLogin) {

        logger.debug("Authentication attempt with {}", authLogin);

        if(authLogin.getUsername().isEmpty())
            return ResponseEntity.badRequest().build();

        if(authLogin.getPassword().isEmpty())
            return ResponseEntity.badRequest().build();

        if(dataSource.getUserDao().findByMail(authLogin.getUsername()).isEmpty())
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();


        User user;
        if ((user = dataSource.authenticate(authLogin.getUsername(), authLogin.getPassword())) == null)
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();

        if(user.getAuth().equals(AuthServiceType.AUTH_SERVICE_EXTERNAL) && !authService.verify(authLogin))
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();


        return ResponseEntity.ok(authToken.generateToken(user.getId(), user.getRole()));

    }


    @Operation(description = "Check wheather a user is authenticated.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "User authenticated"),
            @ApiResponse(responseCode = "401", description = "User not authenticated"),
            @ApiResponse(responseCode = "403", description = "User has invalid/expired token"),
    })
    @GetMapping("verify")
    public ResponseEntity<String> verify() {
        return ResponseEntity.ok().build();
    }


    @Operation(description = "Log-out an authenticated user and invalidate current session.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "User disconnected"),
    })
    @PostMapping("disconnect")
    public void disconnect(HttpSession session) {

        logger.debug("Authentication closed from {}", authToken);

        authToken.setUserId(null);
        authToken.setUserRole(null);
        authToken.setToken(null);
        authToken.setTimestamp(null);

        session.invalidate();

    }


    @Operation(description = "Register a new user from a user client.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "User created"),
            @ApiResponse(responseCode = "400", description = "User has invalid or empty required data"),
            @ApiResponse(responseCode = "403", description = "User has invalid role/status"),
            @ApiResponse(responseCode = "406", description = "User mail already registered"),
    })
    @PostMapping("signup")
    @ApiPermissionPublic
    public void register(HttpServletRequest request, HttpServletResponse response, @RequestBody User user) {

        logger.debug("Registration attempt from {} {} <{}>", user.getName(), user.getSurname(), user.getMail());


        if (user.getName().isBlank())
            throw new ApiResponseStatus(400);

        if (user.getSurname().isBlank())
            throw new ApiResponseStatus(400);

        if (user.getMail().isBlank())
            throw new ApiResponseStatus(400);

        if (user.getPassword().isBlank())
            throw new ApiResponseStatus(400);


        if (!user.getRole().equals(UserRole.CUSTOMER))
            throw new ApiResponseStatus(403);

        if (!user.getStatus().equals(UserStatus.WAIT_FOR_MAIL))
            throw new ApiResponseStatus(403);

        if (dataSource.getUserDao().findByMail(user.getMail()).isPresent())
            throw new ApiResponseStatus(406);



        try {

            request.setAttribute("John", "Doe");

            servletContext.getRequestDispatcher("/api/users")
                    .forward(request, response);

        } catch (IOException | ServletException e) {
            logger.error(e.getMessage(), e);
            throw new ApiResponseStatus(500);
        }


    }




    @PostMapping("/active")
    @ApiPermissionPublic
    public ResponseEntity<String> active(@RequestBody AuthActiveRequest request) {

        // TODO: check auth code...

        var user = dataSource.getUserDao()
                .findByPrimaryKey(request.getId())
                .orElseThrow(() -> new ApiResponseStatus(404));

        dataSource.getUserDao().update(user, new User(
                user.getId(),
                user.getMail(),
                user.getPassword(),
                UserStatus.ACTIVE,
                user.getRole(),
                user.getName(),
                user.getSurname(),
                user.getGender(),
                user.getPhone(),
                user.getBirth(),
                user.getAuth(),
                user.getCreatedAt(),
                Timestamp.from(Instant.now()),
                null,
                null,
                null
        ));


        return ResponseEntity.ok().build();

    }


}
