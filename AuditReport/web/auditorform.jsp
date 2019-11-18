<%--
    Document   : tr1
    Created on : 5 Aug, 2017, 1:08:58 PM
    Author     : 6157637
--%>
<%@page import="Audit.NcrAudit"%>
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

<%    String UserName = session.getAttribute("UserName").toString();
    String NCR_NO = "";
    String AUDITER_TYPE = session.getAttribute("AUDITER_TYPE").toString();
    String AUDITOR_STFNO = session.getAttribute("STAFF_NO").toString();
    String AUDITOR_INT_NAME = session.getAttribute("UserName").toString();
    String NCR_DETAILS = "";
    String NCR_PLAN_CLS_DATE = "";
    String ISO_CLAUSE = "";
    String EMAIL = "";
    String DOC_REF = "";
    String AUDITOR_AUDITEE_COORD = session.getAttribute("AUDITOR_AUDITEE_COORD").toString();
    String AUDITOR_REMARKS = "";
    String isAdmin = session.getAttribute("IsAdmin").toString().toLowerCase();
    NcrAudit objNcr = new NcrAudit();
    // Used for page refresh when ncr edits
    session.setAttribute("refresh", "false");
%>

<%
    AuditInfo objAuditInfo = new AuditInfo();
    List<AuditType> arrAuditTypes = null;

    try {
        arrAuditTypes = objAuditInfo.GetAuditTypes();

        if (session.getAttribute("ncrobj") != null) {

            objNcr = (NcrAudit) session.getAttribute("ncrobj");
            
            {%>
<script>
    alert("NCR: <%= objNcr.getNCR_NO()%> created successfully!");
</script>
<%}
        session.setAttribute("ncrobj", null);
    }
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

        <form method="POST" action="ncrlist.jsp" name="My NCR List" >
            <table width="60%" border="0" cellspacing="1" cellpadding="1" align="center">
                <tr bgcolor="#EAF2F8">
                    <td colspan="3" align="right">
                        <div id="Username"  align="right" >
                            Welcome <%=UserName%> !!!
                        </div>
                        <INPUT TYPE=BUTTON VALUE="HOME" ONCLICK="javascript:window.location = 'auditorform.jsp';" NAME="BUTTON" <%= AUDITOR_AUDITEE_COORD.equalsIgnoreCase("0") ? "" : "style=display:none;"%> /></font></b>
                        <input type="button" name="button" value="Change Password" style="width: 155px; height: 25px;  font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px;" onClick="document.location.href = 'Change_Password.jsp'"/>
                        <input type="submit" name="Submit" value="My NCR List" style="width: 100px; height: 25px;  font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px;"  />
                        <INPUT TYPE=BUTTON VALUE="Add User" style="width: 100px; height: 25px;  font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px;" ONCLICK="javascript:window.location = 'addUserform.jsp';" NAME="AddUser" <%= isAdmin.equalsIgnoreCase("true") ? "" : "style=display:none;"%> /></font></b>
                        <INPUT TYPE=BUTTON VALUE="List Users" style="width: 100px; height: 25px;  font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px;" ONCLICK="javascript:window.location = 'listUsers.jsp';" NAME="List Users" <%= isAdmin.equalsIgnoreCase("true") ? "" : "style=display:none;"%> /></font></b>
                        <INPUT TYPE=BUTTON VALUE="Logout" ONCLICK="document.location.href = 'logout.jsp';" NAME="BUTTON" style="width: 100px; height: 25px;  font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px;">
                    </td>
                </tr>
            </table>
        </form>

        <form method="POST" action="saveDetails.jsp" name="main" enctype="multipart/form-data">
            <div  id="order">
                <table border="0" width="60%" align="center" bgcolor="#AED6F1">
                    <tr bgcolor="#1B4F72">
                        <td  height="42" colspan="3">
                            <p align="center"><font color="#999999"><b><font face="Arial, Helvetica" size="2"><font size="4"> my form </font><font size="5"><br>
                                    </font>INDIA<br>
                                    </font><font face="Arial, Helvetica" size="3">Audit Reports </font></b></font></p>         
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>NCR_NO </strong></font></td>
                        <td>
                            <input name="NCR_NO" type="text" id="NCR_NO" size="25" value="<%=NCR_NO%>" readonly >        
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>FY_YEAR  <font color="#FF0000">*</font></strong></font></td>

                        <td>
                            <select name="FY_YEAR" id="FY_YEAR" >
                                <option value="">Please Select</option>
                                <option value="2018-2019" <%= objNcr.getFY_YEAR() != null && objNcr.getFY_YEAR().equalsIgnoreCase("2018-2019") ? "selected=selected" : ""%> >2018-2019</option>
                                <option value="2019-2020" <%= objNcr.getFY_YEAR() != null && objNcr.getFY_YEAR().equalsIgnoreCase("2019-2020") ? "selected=selected" : ""%> >2019-2020</option>
                                <option value="2020-2021" <%= objNcr.getFY_YEAR() != null && objNcr.getFY_YEAR().equalsIgnoreCase("2020-2021") ? "selected=selected" : ""%> >2020-2021</option>  
                            </select>

                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td ><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDIT_DATE  <font color="#FF0000">*</font> </strong></font></td>

                        <td  >
                            <input name="AUDIT_DATE" type="text" id="AUDIT_DATE" size="25" value="<%= objNcr.getAUDIT_DATE() != null ? objNcr.getAUDIT_DATE() : ""%>" readonly />
                            <a href="javascript:NewCal('AUDIT_DATE','ddmmmyyyy')">
                                <img src="images/calendar.jpg" width="20" height="20"  border="0" alt="Pick a date" style="
                                     vertical-align: bottom;" </a>
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDIT_AREA <font color="#FF0000">*</font></strong></font></td>
                        <td>
                            <select name="AUDIT_AREA" id="AUDIT_AREA" >>
                                <option value="">Please Select</option>   
                                <% for (int i = 0; i < arrAuditTypes.size(); i++) {
                                        AuditType at = arrAuditTypes.get(i);%>
                                <option value="<%=at.getId()%>" <%= objNcr.getAUDIT_AREA() != null && objNcr.getAUDIT_AREA().equalsIgnoreCase(Integer.toString(at.getId())) ? "selected=selected" : ""%> ><%=at.getName()%></option>
                                <% }%>
                            </select>
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td>
                            <font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDITEE_NAME <font color="#FF0000">*</font></strong></font>
                        </td>
                        <td>
                            <input name="AUDITEE_NAME" type="text" id="AUDITEE_NAME" size="25" value="<%=objNcr.getAUDITEE_NAME() != null ? objNcr.getAUDITEE_NAME() : ""%>" />  
                            <input name="AUDITEE_NAME_HIDDEN" id="AUDITEE_NAME_HIDDEN" type="hidden" value="<%=objNcr.getAUDITEE_NAME() != null ? objNcr.getAUDITEE_NAME() : ""%>" />
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDITEE_STFNO </strong></font></td>
                        <td>
                            <input name="AUDITEE_STFNO" type="text" id="AUDITEE_STFNO" size="25" value="<%=objNcr.getAUDITEE_STFNO() != null ? objNcr.getAUDITEE_STFNO() : ""%>"   />                   
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDITOR_STFNO </strong></font></td>
                        <td>
                            <input name="AUDITOR_STFNO" type="text" id="AUDITOR_STFNO" size="25" value="<%=AUDITOR_STFNO%>" readonly  />                 
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDITOR_INT_NAME </strong></font></td>
                        <td>
                            <input name="AUDITOR_INT_NAME" type="text" id="AUDITOR_INT_NAME" size="25" value="<%=AUDITOR_INT_NAME%>" readonly="" >                   
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDITOR_EXT_NAME </strong></font></td>
                        <td>
                            <input name="AUDITOR_EXT_NAME" type="text" id="AUDITOR_EXT_NAME" size="25" value="<%=objNcr.getAUDITOR_EXT_NAME() != null ? objNcr.getAUDITOR_EXT_NAME() : ""%>" <%=AUDITER_TYPE.equalsIgnoreCase("0") ? "disabled" : ""%> >                    
                        </td>
                    </tr>


                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDIT_OBSERVATION <font color="#FF0000">*</font> </strong></font></td>
                        <td>
                            <textarea name="AUDIT_OBSERVATION"  id="AUDIT_OBSERVATION" size="25" style="margin: 0px; width: 164px; height: 43px;" ><%= objNcr.getAUDIT_OBSERVATION() != null ? objNcr.getAUDIT_OBSERVATION() : ""%></textarea>   
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>NCR_TYPE </strong></font></td>
                        <td>
                            <select name="NCR_TYPE" id="NCR_TYPE" >
                                <option value="">Please Select</option>
                                <option value="Major"  >Major</option>
                                <option value="Minor"  >Minor</option>
                                <option value="OFI"  >OFI</option>
                            </select>
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>NCR_DETAILS  </strong></font></td>
                        <td>
                            <input name="NCR_DETAILS" type="text" id="NCR_DETAILS" size="25" value="<%=NCR_DETAILS%>" >       
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td ><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>NCR_PLAN_CLS_DATE   </strong></font></td>

                        <td  ><input name="NCR_PLAN_CLS_DATE" type="text" id="NCR_PLAN_CLS_DATE" size="25" value="<%=NCR_PLAN_CLS_DATE%>" >
                            <a href="javascript:NewCal('NCR_PLAN_CLS_DATE','ddmmmyyyy')">
                                <img src="images/calendar.jpg" width="20" height="20" border="0" alt="Pick a date" style="
                                     vertical-align: bottom;"></a>
                        </td>
                    </tr>
                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>ISO_CLAUSE  </strong></font></td>
                        <td>
                            <input name="ISO_CLAUSE" type="text" id="ISO_CLAUSE" size="25" value="<%= ISO_CLAUSE%>" />  
                        </td>
                    </tr>
                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>DOC_REF  </strong></font></td>
                        <td>
                            <input name="DOC_REF" type="text" id="DOC_REF" size="25" value="<%=DOC_REF%>" />
                        </td>
                    </tr>
                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>NCR_DETAILS </strong></font></td>
                        <td>
                            <textarea name="AUDITOR_REMARKS"  id="AUDITOR_REMARKS" size="25" style="margin: 0px; width: 164px; height: 43px;" ><%=AUDITOR_REMARKS%></textarea>   
                        </td>
                    </tr>
                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>EMAIL  </strong></font></td>
                        <td>
                            <input name="EMAIL" type="text" id="EMAIL" size="25" value="<%= EMAIL%>" >     
                            <input name="chkEmail" type="checkbox" id="chkEmail" />
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td >&nbsp;</td>
                        <td>
                            <input type="submit" value="Save" name="action" onclick="return validlogin();" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px; color: #FF0000">
                            <input type="submit" value="Save & Add" name="action" onclick="return saveform();"  style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px; color: #FF0000">
                            <input type="reset" value="Clear" name="B2">  
                        </td>
                    </tr>
                </table>
            </div>
        </form>

        <FORM NAME="parentForm">
            &nbsp;
        </FORM>
        <%} else {%>
        <h1> Session Expired </h1>
        <a href="logout.jsp">click here</a>
        <%}%>
    </body>

    <SCRIPT LANGUAGE="JavaScript">
        $(document).ready(function () {
            initAutoComplete("<%=session.getAttribute("AUDITER_TYPE").toString()%>");

            $("#AUDIT_AREA").change(function () {
                $('#AUDITEE_NAME_HIDDEN').val("");
                $('#AUDITEE_NAME').val("");
                $('#AUDITEE_STFNO').val();
            });
        });
        function openChild(file, window) {
            childWindow = open(file, window, 'resizable=no,top=200, left=100,width=600,height=300');
            if (childWindow.opener === null)
                childWindow.opener = self;
        }
        function validlogin()
        {

            var FY_YEAR = document.main.FY_YEAR.value;
            var AUDIT_DATE = document.main.AUDIT_DATE.value.trim();
            var AUDIT_AREA = document.main.AUDIT_AREA.value;
            var AUDITEE_NAME = document.main.AUDITEE_NAME.value;
            var AUDIT_OBSERVATION = document.main.AUDIT_OBSERVATION.value;
            if (FY_YEAR.length === 0 || FY_YEAR === "-")
            {
                alert("* Marked fields are mandatory.");
                document.main.FY_YEAR.focus();
                return false;
            }

            if (AUDIT_DATE.length === 0)
            {
                alert("* Marked fields are mandatory.");
                document.main.AUDIT_DATE.focus();
                return false;
            }

            if (AUDIT_AREA.length === 0 || AUDIT_AREA === "-")
            {
                alert("* Marked fields are mandatory.");
                document.main.AUDIT_AREA.focus();
                return false;
            }

            if (AUDITEE_NAME.length === 0)
            {
                alert("* Marked fields are mandatory.");
                document.main.AUDITEE_NAME.focus();
                return false;
            }
            if (AUDIT_OBSERVATION.length === 0)
            {
                alert("* Marked fields are mandatory.");
                document.main.AUDIT_OBSERVATION.focus();
                return false;
            }

            return true;
        }
        function saveform() {
            if (validlogin()) {
                document.main.action = "SaveNAddAuditorForm.jsp";
                document.main.submit();
            }
            return false;
        }
    </script>





