<%-- 
    Document   : tr_pwd.jsp
    Created on : 9 Aug, 2017, 9:49:01 AM
    Author     : 6157637
--%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean class="db.dbcon" id="con" scope="page"> </jsp:useBean>

    <!--    
    1. From logged in staff number, password is retrived and set to a hidden field HIDDENPASSWORD
    2. On submission following checks made
            2a. if Current password entered is same as it is  password saved in database
            2b. If new Password choosen is same as old Password
            2c. if new Password and re-type password are matching
    -->

    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
            <title>Change Password</title>
            <style type="text/css">
                <!--
                .style1 {
                    font-family: Verdana, Arial, Helvetica, sans-serif, "Agency FB";
                    font-weight: bold;
                }
                .style3 {font-family: Verdana, Arial, Helvetica, sans-serif, "Agency FB"; font-weight: bold; font-size: 12px; }
                .style4 {color: #999999}
                .style5 {color: #FF0000}
                -->
            </style>
        </head>
        <body bgcolor="#EAF2F8">
        <%! String sessionID;%>
        <% if (session.getAttribute("sessionID") == session.getId()) {
        %>

        <%
            String qstring = "";
            String PWD = "";
        %>

        <% String STAFF_NO = session.getAttribute("STAFF_NO").toString(); %>
        <% session.setAttribute("STAFF_NO", STAFF_NO); %>

        <%
            try {
                Connection conn = con.getcon();
                Statement stmt = con.getSt();
                ResultSet rs = null;
                qstring = "select password from Audit_Login where upper(STAFF_NO)=upper('" + STAFF_NO + "')";
                rs = stmt.executeQuery(qstring);
                if (rs.next()) {
                    PWD = rs.getString(1);
                }
        %>
        <%      con.Conclose();
        } catch (Exception e) {%>
        <jsp:forward page="errorpage.jsp"></jsp:forward>
        <% }
        %>

        <form method="POST" action="tr_pwd_upd.jsp" id="mail" name="main" onsubmit="return validateForm()">
            <table width="50%" border="0" cellspacing="1" cellpadding="1" align="center" bgcolor="#1B4F72" >

                <tr bgcolor="#1B4F72">
                    <td colspan="2" align="right"><div align="center" class="style1 style4">Change Password</div></td>
                </tr>

                <tr bgcolor="#AED6F1">
                    <td colspan="2" align="right"> 
                        <INPUT TYPE=BUTTON VALUE="HOME" ONCLICK="javascript:window.location = 'auditorform.jsp';" NAME="BUTTON">
                    </td>
                </tr>

                <tr bgcolor="#AED6F1">
                    <td><div align="right"><span class="style3">Current Password</span></div></td>
                    <td><input name="PASSWORD" type="password" id="PASSWORD" />
                        <span class="style5">*</span></td>
                </tr>
                
                <tr bgcolor="#AED6F1">
                    <td><div align="right"><span class="style3">New Password</span></div></td>
                    <td><input name="NPASSWORD" type="password" id="NPASSWORD" />
                        <span class="style5">*</span></td>
                </tr>
                
                <tr bgcolor="#AED6F1">
                    <td><div align="right"><span class="style3">Re-type New Password</span></div></td>
                    <td><input name="RPASSWORD" type="password" id="RPASSWORD" />
                        <span class="style5">*</span></td>
                </tr>

                <tr bgcolor="#AED6F1">
                    <td><div align="right"><span class="style3"></span></div></td>
                    <td><input name="HIDDENPASSWORD" type="hidden" id="HIDDENPASSWORD"  value="<%=PWD%>"/>
                        <span class="style5"></span></td>
                </tr>

                <tr>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td bgcolor="#AED6F1">
                        <div align="right">
                            <input type="reset" name="button" value="Clear" style="width: 150px; height: 25px;  font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px;" />
                        </div></td>
                    <td bgcolor="#AED6F1">
                        <div align="left">
                            <input type="submit" name="submit" value="Submit" style="width: 150px; height: 25px;  font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px;" />
                        </div></td>
                </tr>
            </table>

        </form>
        <%} else {%>
        <h1> Session Expired </h1>
        <a href="logout.jsp">click here</a>

        <%}%>
    </body>
</html>

<script language="javascript">

    function validateForm() {
        var PASSWORD = document.forms["main"]["PASSWORD"].value;
        var NPASSWORD = document.forms["main"]["NPASSWORD"].value;
        var RPASSWORD = document.forms["main"]["RPASSWORD"].value;
        var HIDDENPASSWORD = document.forms["main"]["HIDDENPASSWORD"].value;


        if ((PASSWORD === null || PASSWORD === "") || (NPASSWORD === null || NPASSWORD ==="") || (RPASSWORD === null || RPASSWORD === "")) {

            alert(" *  Marked Fields are mandatory");
            return false;
        } else if (!(PASSWORD === HIDDENPASSWORD)) {

            alert("Current Password entered wrong");
            return false;
        } else if ((PASSWORD === NPASSWORD)) {

            alert("Current password and New Password can not be same");
            return false;
        } else if (!(NPASSWORD ===RPASSWORD)) {

            alert("New password and Re-Typed password are not matching");
            return false;
        }
    }<!--validateform-->
</script>