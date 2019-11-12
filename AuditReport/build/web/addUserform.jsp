<%--
    Document   : tr1
    Created on : 5 Aug, 2017, 1:08:58 PM
    Author     : 6157637
--%>
<%@page import="Audit.AuditType"%>
<%@page import="Audit.AuditInfo"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="javax.servlet.*"%>
<%@ page import="java.util.Date"%>

<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<jsp:useBean class="db.dbcon" id="con" scope="page"> </jsp:useBean>
<%! String sessionID;%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="org.json.JSONArray"%>
<%@page import = "java.sql.*,org.json.JSONArray,org.json.JSONObject,org.json.JSONException,java.util.*" %>

<% if (session.getAttribute("sessionID") == session.getId()) {

%>

<%    String qstring = "";
    String UserName = request.getParameter("UserName");
    String Password = request.getParameter("Password");
    String Staff_NO = request.getParameter("StaffNumber");
    String AUDIT_AREA = request.getParameter("AUDIT_AREA");
    AuditInfo objAuditInfo = new AuditInfo();
    List<AuditType> arrAuditTypes = null;
    String dbUserName = "";
    String LoginUserName = session.getAttribute("UserName").toString();

    try {

        Connection conn = con.getcon();
        Statement st = con.getSt();

        st = conn.createStatement();

        ResultSet rs = null;
        qstring = "select UserName from Audit_Login where upper(STAFF_NO) = upper('" + Staff_NO + "') or upper(UserName) = upper('" + UserName + "')";

        if (UserName != null && UserName.trim().isEmpty() == false && Password != null && Password.trim().isEmpty() == false
                && Staff_NO != null && Staff_NO.trim().isEmpty() == false && AUDIT_AREA != null && AUDIT_AREA.trim().isEmpty() == false) {
            //st = conn.prepareStatement(qstring);
            rs = st.executeQuery(qstring);
            if (rs.next()) {

                System.out.println("User Name");
                dbUserName = rs.getString(1);
            }

            if (dbUserName.isEmpty() == false) {%>
<script>
    alert('Record alreay exits');
</script>
<%} else {
            rs = null;
           
            qstring = "INSERT INTO Audit_Login(STAFF_NO, password,UserName, Auditor_Id, IsAdmin) VALUES ( '" + Staff_NO + "','" + Password + "','" + UserName + "','" + AUDIT_AREA + "', 0)";
             int i = st.executeUpdate(qstring);          
             System.out.println(i);
        }
    }

    arrAuditTypes = objAuditInfo.GetAuditTypes();

} catch (Exception e) {
    System.out.println("Exception " + e.toString());%>
<jsp:forward page="errorpage.jsp"></jsp:forward>
<%}%>


<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <meta name="GENERATOR" content="Microsoft FrontPage 4.0">
        <meta name="ProgId" content="FrontPage.Editor.Document">
        <title>Audit Report</title>
        <script src="js/jquery-3.3.1.js" type="text/javascript"></script>
        <script src="js/jquery-ui.js" type="text/javascript"></script>
        <link href="jquery-ui.css" rel="stylesheet" type="text/css"/>
        <script src="js/ncrHistory.js" type="text/javascript"></script>
        <script type="text/javascript"  LANGUAGE="JavaScript" src="js/datetimepicker.js"></script>
    </head>
    <body bgcolor="#EAF2F8">
        <p>&nbsp;</p>
        <br>


        <table width="60%" border="0" cellspacing="1" cellpadding="1" align="center">
            <tr bgcolor="#EAF2F8">
                <td colspan="3" align="right">
                    <div id="Username"  align="right" >
                        Welcome <%=LoginUserName%> !!!
                    </div>
                    <INPUT TYPE=BUTTON VALUE="HOME" ONCLICK="javascript:window.location = 'auditorform.jsp';" NAME="BUTTON" /></font></b>
                    <input type="button" name="button" value="Change Password" style="width: 155px; height: 25px;  font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px;" onClick="document.location.href = 'Change_Password.jsp'"/>
                    <input type="submit" name="Submit" value="My NCR List" style="width: 100px; height: 25px;  font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px;"  />
                    <INPUT TYPE=BUTTON VALUE="Add User" style="width: 100px; height: 25px;  font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px;" ONCLICK="javascript:window.location = 'addUserform.jsp';" NAME="AddUser" /></font></b>
                    <INPUT TYPE=BUTTON VALUE="List Users" style="width: 100px; height: 25px;  font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px;" ONCLICK="javascript:window.location = 'listUsers.jsp';" NAME="List Users" /></font></b>
                    <INPUT TYPE=BUTTON VALUE="Logout" ONCLICK="document.location.href = 'logout.jsp';" NAME="BUTTON" style="width: 100px; height: 25px;  font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px;">
                </td>
            </tr>
        </table>

        <form name="addUserform" method="post" action="" >
            <table width="40%" border="0" align="center" bgcolor="#AED6F1">
                <tr bgcolor="#1B4F72">
                    <td colspan="2"><div align="center">
                            <div align="center"><span class="style7">Add New User </span></div>
                    </td>
                </tr>
                <tr bgcolor="#AED6F1">
                </tr>
                <td colspan="2"><div align="center"> &nbsp</td>
                </tr>
                <tr bgcolor="#AED6F1">
                    <td>
                        <div align="right" class="style5"><span class="style10">User Name  <font color="#FF0000">*</font> </span></div>
                    </td>
                    <td>
                        <span class="style8">
                            <label>
                                <input name="UserName" type="text" id="UserName" />
                            </label>
                        </span>
                    </td>
                </tr>
                <tr bgcolor="#AED6F1">
                    <td>
                        <div align="right" class="style5"><span class="style10">Staff Number  <font color="#FF0000">*</font> </span></div>
                    </td>
                    <td>
                        <span class="style8">
                            <label>
                                <input name="StaffNumber" type="text" id="StaffNumber" />
                            </label>
                        </span>
                    </td>
                </tr>
                <tr bgcolor="#AED6F1">
                    <td>
                        <div align="right" class="style5"><span class="style10">User Type  <font color="#FF0000">*</font> </span></div>
                    </td>
                    <td>
                        <select name="AUDIT_AREA" id="AUDIT_AREA" >
                            <option value="">Please Select</option>   
                            <% for (int i = 0; i < arrAuditTypes.size(); i++) {
                                    AuditType at = arrAuditTypes.get(i);%>
                            <option value="<%=at.getId()%>"><%=at.getName()%></option>
                            <% }%>
                        </select>
                    </td>
                </tr>
                <tr bgcolor="#AED6F1">
                    <td><div align="right" class="style5"><span class="style10">password  <font color="#FF0000">*</font></span></div></td>
                    <td>
                        <label>
                            <input name="Password" type="Password" id="PASSWORD"  />
                        </label>
                    </td>
                </tr>



                <tr bgcolor="#AED6F1">
                    <td colspan="1">
                        <div align="left"></div></td>
                    <td colspan="1">
                        <div align="left">
                            <input type="submit" value="Add" onClick="return validlogin();"/>
                        </div></td>
                </tr>


                <tr bgcolor="#AED6F1">
                    <td colspan="2">&nbsp;</td>
                </tr>
            </table>
        </form> 
        <FORM NAME="parentForm">
            &nbsp;
        </FORM>
        <%} else {%>
        <h1> Session Expired </h1>
        <a href="logout.jsp">click here</a>
        <%}%>
    </body>
    <script src="js/jquery-3.3.1.min.js" type="text/javascript"></script>
    <script LANGUAGE="JavaScript">
                                function validlogin()
                                {
                                    var UserName = $("#UserName").val();
                                    var StaffNumber = $("#StaffNumber").val();
                                    var Password = $("#PASSWORD").val();
                                    var AUDIT_AREA = $("#AUDIT_AREA").val();

                                    if (UserName === "" || StaffNumber === "" || Password === "" || AUDIT_AREA === "")
                                    {
                                        alert("* Marked fields are mandatory.");
                                        return false;
                                    }
                                }
    </script>







