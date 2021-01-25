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
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Scope;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

@Component
@Scope("singleton")
public class Mail {

    private final static Logger logger = (Logger) LoggerFactory.getLogger(Auth.class);

    private final String sender;
    private final JavaMailSender service;

    @Autowired
    public Mail(JavaMailSender service,
                @Value("${info.mail.sender}") String sender) {

        this.sender = sender;
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

}
