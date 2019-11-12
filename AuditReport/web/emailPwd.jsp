<%--
    Document   : index
    Created on :
    Author     : 6157637
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*, java.sql.* " %>
<%@ page import="javax.servlet.http.*" %>
<%@ page language="java" %>


<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.BodyPart"%>
<%@page import="javax.mail.internet.MimeMultipart"%>
<%@page import="javax.activation.DataHandler"%>
<%@page import="javax.activation.FileDataSource"%>
<%@page import="javax.activation.DataSource"%>
<%@page import="javax.mail.internet.MimeBodyPart"%>
<%@page import="javax.mail.MessagingException"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>

<jsp:useBean class="db.dbcon" id="con" scope="page"> </jsp:useBean>


    <html>
        <head>

            <title>Tour reports</title>
        </head>
        <body>
            <div id="container">

            <%@page import="java.util.Calendar"%>

            <div id="content" style="background-color:#F1F1F1;height:700px"><br/><br/><br/>
                <br/>
                <%!
                    ResultSet rs = null, rs2 = null;
                    String qstring = "", qstring2 = "";
                    int d = 0;
                    String STNO = "";
                    String Password = "";
                    String forwardemail = "";
                    Session sess;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        %>
                <%
                    STNO = request.getParameter("STNO");
                    Connection conn = con.getcon();
                    Statement st = con.getSt();

                    qstring = "select PASSWORD from pesd_tr_login where STNO='" + STNO + "' ";
                    qstring2 = "select EMAIL_ID from pers.pr_emp_info where STAFFNO='" + STNO + "' ";

                    rs = st.executeQuery(qstring);

                    if (rs.next()) {
                        Password = rs.getString("PASSWORD");

                    } else {%>

                <script>
                    alert("Invalid Staff Number..");
                    window.location = 'http://10.5.4.224/newtr1/tr0.jsp';
                </script>

                <%  }

                    rs2 = st.executeQuery(qstring2);
                    if (rs2.next()) {
                        forwardemail = rs2.getString("EMAIL_ID");
                    }

                    try {

                        // e-mailing part
                        if (!(forwardemail.equals(null) || forwardemail.equals(""))) {
                            String extn = "@bhel.in";
                            forwardemail = forwardemail + extn;
//                            String to = forwardemail;
                            //                            String to = forwardemail;
                            String from = "pesd_sysadmin@bhel.in";

                            boolean debug = true;
//                            Local props
//                            int smtpPort = 465;
//                            Properties props = System.getProperties();
//                            props.put("mail.transport.protocol", "smtp");
//                            props.put("mail.smtp.socketFactory.port", "465");
//                            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
//                            props.put("mail.smtp.port", "465");
//                            props.put("mail.smtp.host", "mail.bhel.in");
//                            props.put("mail.smtp.port", "25");
//                            props.put("mail.smtp.host", "mail.bhel.in");
//                            props.put("mail.smtp.auth", "true");
//
//                            Session session1 = Session.getInstance(props,
//                                    new javax.mail.Authenticator() {
//                                        protected PasswordAuthentication getPasswordAuthentication() {
//                                            return new PasswordAuthentication("ravid", "Duvvuri@123");
//                                        }
//                                    });

//                            end local props
                            int smtpPort = 25;
                            java.util.Properties props = new java.util.Properties();//System.getProperties();
                            props.put("mail.transport.protocol", "smtp");
                            props.put("mail.smtp.host", "10.5.5.76");
                            props.put("mail.smtp.port", "" + smtpPort);
                            props.put("mail.smtp.auth", "false");
                            props.put("mail.smtp.starttls.enable", "false");
                            props.put("mail.smtp.ssl.trust", "*");
                            Session session1 = Session.getInstance(props);
                            try {
//                                message.setFrom(new InternetAddress(from, "pesd_tour_reports@bhel.in"));
                                MimeMessage message = new MimeMessage(session1);
                                message.setFrom(new InternetAddress(from, "pesd_sysadmin@bhel.in"));
                                message.addRecipient(Message.RecipientType.TO, new InternetAddress(forwardemail));
//                                message.setRecipients(Message.RecipientType.TO, forwardemail);
                                // message.setRecipients(Message.RecipientType.CC, to);
                                //message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                                message.setSubject("Password for PE&SD Tour Report system");
                                MimeMultipart multipart = new MimeMultipart("related");
                                BodyPart messageBodyPart = new MimeBodyPart();
                                String htmlText1 = "<table>"
                                        + "<tr>"
                                        + "<td >"
                                        + "Dear Sir/Madam,"
                                        + "<br/>"
                                        + "<br/>"
                                        + "</td>"
                                        + "</tr>   "
                                        + "<tr>"
                                        + "<td style=\"padding-left: 50px; color: #0066cc;\">"
                                        + " Staffnumber: " + STNO + ", Password: " + Password + "</a>"
                                        + "</td>"
                                        + "</tr>"
                                        + "<tr>"
                                        + "</tr>"
                                        + "<tr>"
                                        + "<td>"
                                        + "<br/>"
                                        + "<br/>"
                                        + "</td>"
                                        //+ "</tr><tr><td>Regards,<br/>" +empName+ ",<br/>" + "Auto generated mail from GM-I Dashboard System, please do not reply to this mail." +  "</td></tr></table>";
                                        + "</tr><tr><td>Regards,<br/>" + "PE&SD Tour Reports system" + ",<br/>" + "Auto generated mail from  PE&SD Tour Reports system, please do not reply to this mail." + "</td></tr></table>";
                                messageBodyPart.setContent(htmlText1, "text/html");
                                // add it
                                multipart.addBodyPart(messageBodyPart);
                                       // second part (the image)

                                // put everything together
                                message.setContent(multipart);
                                Transport.send(message);
                            } catch (MessagingException mex) {
                                out.println("Exception:" + mex);
                                mex.printStackTrace();
                            }
                            // end of emailing part

                %>

                <script>
                    alert("Email sent..");
                    window.location = 'http://10.5.4.224/newtr1/tr0.jsp';
                </script>

                <!--  <h2 align="center"> Email sent. <a href="http://10.5.4.224/ILTR/index.jsp">Login</a> </h2>-->
                <% }
                        if (con != null) {
                            try {
                                con.Conclose();
                                rs.close();
                            } catch (Exception ignored) { // ignore
                            }
                        }
                    } catch (Exception e) {
                        out.println("Exception:" + e);
                        e.printStackTrace();
                    }

                %>
            </div>

        </div>
    </body>
</html>
