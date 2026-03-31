package util;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtil {

    private static final String FROM_EMAIL = "4431894@mitacsc.edu.in";
    private static final String PASSWORD = "vedant@555";

    public static void sendEmail(String to, String subject, String messageText) {
        if (to == null || to.trim().isEmpty()) {
            System.out.println("Email address is missing. Skipping email sending.");
            return;
        }

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {

            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
            }
        });

        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(to));
            message.setSubject(subject);

            message.setContent(messageText, "text/html; charset=utf-8");

            Transport.send(message);

            System.out.println("Email sent successfully to " + to);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}