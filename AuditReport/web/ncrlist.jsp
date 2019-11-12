<%--
    Document   : saveDetails
    Created on : Sep 5, 2018, 8:20:58 AM
    Author     : 6146252
--%>

<%@page import="Audit.AuditType"%>
<%@page import="Audit.AuditInfo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>

<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page language="java" import="java.sql.*,java.io.*" import="java.sql.*" import="java.lang.*" import="java.util.Date" %>


<jsp:useBean class="db.dbcon" id="con" scope="page"> </jsp:useBean>

<%
    String UserName = session.getAttribute("UserName").toString();
    String AUDITOR_AUDITEE_COORD = session.getAttribute("AUDITOR_AUDITEE_COORD").toString();
    String STAFF_NO = session.getAttribute("STAFF_NO").toString();
    String AACName = session.getAttribute("AACName").toString();
%>

<%
    AuditInfo objAuditInfo = new AuditInfo();
    List<AuditType> arrAuditTypes = null;

    try {
        arrAuditTypes = objAuditInfo.GetAuditTypes();
    } catch (Exception e) {
        System.out.println("Exception " + e.toString());%>
<jsp:forward page="errorpage.jsp"></jsp:forward>
<%}%>


<html>
    <head>
        <title>View REPORTS</title>
        <script src="js/jquery-3.3.1.min.js" type="text/javascript"></script>
        <script src="js/jquery-ui.js" type="text/javascript"></script>
        <script src="js/jquery-ui.js" type="text/javascript"></script>
        <link href="jquery-ui.css" rel="stylesheet" type="text/css"/>
        <script src="js/ncrHistory.js" type="text/javascript"></script>
        <style>
            table th{
                color:#fff;
            }


        </style>
    </head>
    <body bgcolor="#EAF2F8">

        <p <%= AUDITOR_AUDITEE_COORD.equalsIgnoreCase("1") ? "" : "style=display:none;"%>>
        <form method="POST" action="ncrlist.jsp" name="My NCR List" >
            <table width="60%" border="0" cellspacing="1" cellpadding="1" align="center">
                <tr bgcolor="#EAF2F8">
                    <td colspan="3" align="right">
                        <div id="Username"  align="right" >
                            Welcome <%=UserName%>[<%=AACName%>] !!!
                        </div>
                        <input type="button" name="button" value="Change Password" style="width: 155px; height: 25px;  font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px;" onClick="document.location.href = 'tr_pwd.jsp'"/>
                        <INPUT TYPE=BUTTON VALUE="HOME" ONCLICK="javascript:window.location = 'auditorform.jsp';" NAME="BUTTON" <%= AUDITOR_AUDITEE_COORD.equalsIgnoreCase("0") ? "" : "style=display:none;"%> />
                        <INPUT TYPE=BUTTON VALUE="Logout" ONCLICK="document.location.href = 'logout.jsp';" NAME="BUTTON" style="width: 100px; height: 25px;  font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px;">
                    </td>
                </tr>
            </table>
        </form>
    </p>
    <p>
        <select name="FY_YEAR" id="FY_YEAR" >
            <option value="">Please Select</option>
            <option value="2018-2019"  >2018-2019</option>
            <option value="2019-2020"  >2019-2020</option>
            <option value="2020-2021"  >2020-2021</option>
        </select>
        <select name="AUDIT_AREA" id="AUDIT_AREA" >
            <option value="">Please Select</option>
            <option value="0">All</option>
            <% for (int i = 0; i < arrAuditTypes.size(); i++) {
                    AuditType at = arrAuditTypes.get(i);%>
            <option value="<%=at.getId()%>"><%=at.getName()%></option>
            <% }%>
        </select>
        <INPUT TYPE=BUTTON VALUE="Search" NAME="BUTTON" id="btnsearch" />

    </p>
    <form id="subForm" name="subForm" method="post" >
        <table border="2" id="tblNcr">
            <thead>
            <th bgcolor="#1B4F72" width="10% ">
                ASSIGNED BY
            </th>
            <th bgcolor="#1B4F72" width="10% ">
                NCR NO
            </th>
            <th bgcolor="#1B4F72" width="10% ">
                Audit_Name  
            </th>
            <th bgcolor="#1B4F72" width="10% ">
                NCR_DETAILS 
            </th>
            <th bgcolor="#1B4F72" width="10% ">
                ISO_CLAUSE  
            </th>
            <th bgcolor="#1B4F72" width="10% ">
                NCR_TYPE
            </th>
            <th bgcolor="#1B4F72" width="10% ">
                NCR_CLS_CONF
            </th>
            <th bgcolor="#1B4F72" width="20% ">
                AUDITOR_ACTION
            </th>
            <th bgcolor="#1B4F72" width="10% ">
                History
            </th>
            </thead>   
            <tbody>
            </tbody>
        </table>
    </form>
    <br/>
    <div id="dialog" title="History Log">
        <div id="dvHistory"></div>
    </div>
</body>                          
</HTML>


<script type="text/javascript">
    function getDetails(ncr_no)
    {
        document.subForm.action = "NcrEdit.jsp?ncr_no=" + ncr_no;
        document.subForm.submit();
    }

    $(document).ready(function () {
        $("#btnsearch").click(function () {
            if ($("#AUDIT_AREA").val() !== "" && $("#FY_YEAR").val() !== "")
            {
                getNCRList(<%= AUDITOR_AUDITEE_COORD%>, <%= STAFF_NO%>);
            } else
            {
                alert(1);
            }
        });
    });

</script>










