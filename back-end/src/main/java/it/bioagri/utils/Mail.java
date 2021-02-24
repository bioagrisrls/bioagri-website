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

package it.bioagri.utils;

import ch.qos.logback.classic.Logger;
import it.bioagri.api.auth.Auth;
import it.bioagri.web.Locale;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Scope;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

@Component
@Scope("singleton")
public class Mail {

    private final static Logger logger = (Logger) LoggerFactory.getLogger(Auth.class);

    private final String sender;
    private final Locale locale;
    private final JavaMailSender service;

    @Autowired
    public Mail(JavaMailSender service, Locale locale,
                @Value("${info.mail.sender}") String sender) {

        this.sender = sender;
        this.locale = locale;
        this.service = service;

    }


    public void send(String to, String subject, String content, Object... args) {

        logger.trace("Sending e-mail to <%s>:\nSubject: '%s'\nContent:\n'%s'"
                .formatted(to, subject, content.formatted(args)));

        service.send(new SimpleMailMessage() {{
            setFrom(sender);
            setTo(to);
            setSubject(subject);
            setText(content.formatted(args));
        }});

    }


    public void sendUserRegistration(ServletRequest request, HttpSession session, Long userId, String to) {

        String uri = """
                {
                    "id"   : "%s",
                    "auth" : "%s",
                    "type" : "REDIRECT_TYPE_USER_ACTIVATE"
                }
                """.formatted(userId, "");  // TODO: Generate auth code

        send(
                to,
                locale.getCurrentLocale(request, session).get("mail_user_registration_subject"),
                locale.getCurrentLocale(request, session).get("mail_user_registration_content"),
                Base64.getEncoder().encodeToString(uri.getBytes(StandardCharsets.UTF_8))
        );

    }


    public void sendUserPayment(ServletRequest request, HttpSession session, String to, Long orderId) {

        send(
                to,
                locale.getCurrentLocale(request, session).get("mail_user_payment_subject"),
                locale.getCurrentLocale(request, session).get("mail_user_payment_content"),
                orderId, request.getRemoteHost()
        );

    }

    public void sendBankTransferInstructions(ServletRequest request, HttpSession session, String to, Long orderId) {

        send(
                to,
                locale.getCurrentLocale(request, session).get("mail_bank_transfer_subject"),
                locale.getCurrentLocale(request, session).get("mail_bank_transfer_content"),
                orderId, request.getRemoteHost()
        );

    }

    public void sendPickupInStoreInstructions(ServletRequest request, HttpSession session, String to, Long orderId) {

        send(
                to,
                locale.getCurrentLocale(request, session).get("mail_pickup_in_store_subject"),
                locale.getCurrentLocale(request, session).get("mail_pickup_in_store_content"),
                orderId, request.getRemoteHost()
        );

    }


}
