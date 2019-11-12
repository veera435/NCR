/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Audit;

import static java.lang.System.out;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

/**
 *
 * @author pillive1
 */
public class AditeeEmail {

    public void SendEmail1(String to, String sub, String msg) {
        Properties props = System.getProperties();
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.port", "25");
        props.put("mail.smtp.host", "10.5.5.76");
        props.put("mail.smtp.socketFactory.port", "25");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "false");
        props.put("mail.smtp.starttls.enable", "false");
        props.put("mail.smtp.ssl.trust", "*");
        Session session1 = Session.getInstance(props);
        try {

            MimeMessage message = new MimeMessage(session1);
            String from = "qsadmin@bhel.in";
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, to);
            //message.setRecipients(Message.RecipientType.CC, "nagesht@bhel.in");
            // message.setRecipients(Message.RecipientType.CC, "dgayatri@bhel.in");

            message.setSubject("Surveillance Details of Vendor: ");
            MimeMultipart multipart = new MimeMultipart("related");
            BodyPart messageBodyPart = new MimeBodyPart();
            String statusText = "";

            String htmlText1 = "http://localhost";
            messageBodyPart.setContent(htmlText1, "text/html");
            // add it
            multipart.addBodyPart(messageBodyPart);

            // put everything together
            message.setContent(multipart);
            Transport.send(message);
        } catch (MessagingException mex) {
            out.println("Email Exception:" + mex);
        }
    }
}
