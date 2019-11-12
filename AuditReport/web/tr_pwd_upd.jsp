
<%-- 
    Document   : tr_pwd_upd.jsp
    Created on : 9 Aug, 2017, 9:49:01 AM
    Author     : 6157637
--%>

<%@page language="java" import="java.sql.*"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.*"%>

<jsp:useBean class="db.dbcon" id="con" scope="page"> </jsp:useBean>

    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
            <title>Password Changed</title>
        </head>

        <body>

        <%! String sessionID;%>
        <% if (session.getAttribute("sessionID") == session.getId()) {

        %>

        <% String STNO = session.getAttribute("STAFF_NO").toString(); %>
        <%
            String PASSWORD = request.getParameter("PASSWORD");
            String NPASSWORD = request.getParameter("NPASSWORD");
            int iz = 0;
        %>

        <%    try {

                Connection conn = con.getcon();
                Statement stmt = con.getSt();
                iz = stmt.executeUpdate("update Audit_Login set password = '" + NPASSWORD + "' where STAFF_NO = '" + STNO + "'  and password = '" + PASSWORD + "'");
        %>

        <%    if (iz > 0) {
        %>
        <script>
            alert(" Password updated.");
            window.location = 'login.jsp';
        </script> 
        <% } else { %>

        <script>
            alert("Please try again.");
            window.location = 'login.jsp';
        </script>   <% }%>


        <%
            con.Conclose();
        } catch (Exception e) {%>
        <jsp:forward page="errorpage.jsp"></jsp:forward>
        <%}
        %>
        <%} else {%>
        <h1> Session Expired </h1>
        <a href="logout.jsp">click here</a>

        <%}%>
    </body>
</html>
