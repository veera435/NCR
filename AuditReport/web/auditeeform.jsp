<%--
    Document   : tr1
    Created on : 5 Aug, 2017, 1:08:58 PM
    Author     : 6157637
--%>


<%@page import="Audit.AuditInfo"%>
<%@page import="Audit.NcrAudit"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="java.io.File"%>
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
<% if (session.getAttribute("sessionID") == session.getId()) {

%>

<%    int qncr_no = request.getParameter("ncr_no") == null ? 0 : Integer.parseInt(request.getParameter("ncr_no"));
    System.out.println("query string" + qncr_no);
    String STAFF_NO = session.getAttribute("STAFF_NO").toString();
    String UserName = session.getAttribute("UserName").toString();
    String NCR_NO = request.getParameter("ncr_no") == null ? "0" : request.getParameter("ncr_no");
    String BUTTON = "SAVE";
    String FileName = "";
    String name1;
    String value;
    String AUDITOR_AUDITEE_COORD = session.getAttribute("AUDITOR_AUDITEE_COORD").toString();
    NcrAudit objNcr = new NcrAudit();
    // Used for page refresh when ncr edits
    session.setAttribute("refresh", "false");
%>

<%    try {
        if (qncr_no > 0) {
            int maxFileSize = 50000 * 1024;
            int maxMemSize = 50000 * 1024;
            ServletContext context = pageContext.getServletContext();
            String contentType = request.getContentType();
            String path = application.getRealPath("/");
            if (path.contains(
                    "\\")) {
                path = path.replace("\\", "/");
            }
            if ((contentType.indexOf("multipart/form-data") >= 0)) {
                DiskFileItemFactory factory = new DiskFileItemFactory();
                factory.setSizeThreshold(maxMemSize);
                factory.setRepository(new File(path + "/files/"));
                ServletFileUpload upload = new ServletFileUpload(factory);
                upload.setSizeMax(maxFileSize);
                List fileItems = upload.parseRequest(request);
                Iterator ii = fileItems.iterator();
                FileItem fileItem = null;
                while (ii.hasNext()) {
                    FileItem fi = (FileItem) ii.next();
                    fileItem = fi;

                    name1 = fi.getFieldName();
                    value = fi.getString();

                    if (name1.equalsIgnoreCase("fileupload")) {
                        FileName = value;
                        break;
                    }
                }
            }

            if (!FileName.isEmpty()) {
                String filepath = "/Users/pillive1/Documents/AuditReport/build/web/files/";
                File f = new File(filepath + qncr_no + "_" + FileName);
                if (f.exists()) {
                    if (f.delete()) {
                        out.println("Sucessfully deleted file");
                    } else {
                        out.println("Error in deleting file");
                    }

                    Statement stmt = con.getSt();
                    String dt = "update  AUDIT_INT_EXT set ATTACHMENT = '' where NCR_NO = " + qncr_no;
                    int i = stmt.executeUpdate(dt);
                }
            }
        }

        if (qncr_no > 0) {
            BUTTON = "UPDATE";
            AuditInfo objAuditInfo = new AuditInfo();
            objNcr = objAuditInfo.GetAuditInfoByNCRNo(NCR_NO);
            System.out.println(objNcr.getAUDITOR_STFNO());
            System.out.println(objNcr.getAUDIT_DATE());
        }
%>
<%      con.Conclose();
} catch (Exception e) {
    System.out.println("Exception " + e.toString());%>
<jsp:forward page="errorpage.jsp"></jsp:forward>
<%}
%>

<style type="text/css">
    .mytable {
        border-collapse: collapse;
        width: 100%;
        background-color: white;
    }
    .mytable-head {
        border: 1px solid black;
        margin-bottom: 0;
        padding-bottom: 0;
    }
    .mytable-head td {
        border: 1px solid black;
    }
    .mytable-body {
        border: 1px solid black;
        border-top: 0;
        margin-top: 0;
        padding-top: 0;
        margin-bottom: 0;
        padding-bottom: 0;
    }
    .mytable-body td {
        border: 1px solid black;
        border-top: 0;
    }

</style>

<style>
    .table, th{
        border: 1px solid black;
        border-collapse: collapse;
    }
    .th, td {
        padding: 5px;
        text-align: left;    
    }
    .th{ border:none; background-color:#CCC;}
</style>


<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <title>Tour Report</title>

        <SCRIPT LANGUAGE="JavaScript">
            function validlogin()
            {

                // alert("I am an alert box!");
                var NCR_NO = document.main.NCR_NO.value;
                var FY_YEAR = document.main.FY_YEAR.value;
                var AUDIT_DATE = document.main.AUDIT_DATE.value;
                var AUDIT_AREA = document.main.AUDIT_AREA.value;
                var AUDITEE_NAME = document.main.AUDITEE_NAME.value;
                var AUDITOR_NAME = document.main.AUDITOR_NAME.value;
                var ATTACHMENT = document.main.ATTACHMENT.value;
                var AUDIT_OBSERVATION = document.main.AUDIT_OBSERVATION.value;
                var NCR_TYPE = document.main.NCR_TYPE.value;
                var NCR_DETAILS = document.main.NCR_DETAILS.value;
                var NCR_PLAN_CLS_DATE = document.main.NCR_PLAN_CLS_DATE.value;
                var NCR_ACTUAL_CLS_DATE = document.main.NCR_ACTUAL_CLS_DATE.value;
                var AUDITOR_ACTION = document.main.AUDITOR_ACTION.value;
                var ISO_COORD_REMARKS = document.main.ISO_COORD_REMARKS.value;
                var AUDITEE_REMARKS_CLS = document.main.AUDITEE_REMARKS_CLS.value;
                var CORRECTION = document.main.CORRECTION.value;
                var CORR_DT = document.main.CORR_DT.value;
                var CORRECTION_NAME = document.main.CORRECTION_NAME.value;
                var RCA = document.main.RCA.value;
                var RCA_DT = document.main.RCA_DT.value;
                var RCA_NAME = document.main.RCA_NAME.value;
                var CORR_ACTION = document.main.CORR_ACTION.value;
                var CORR_ACTION_DT = document.main.CORR_ACTION_DT.value;
                var CORR_ACTION_NAME = document.main.CORR_ACTION_NAME.value;
                var AUDITOR_REV_DT = document.main.AUDITOR_REV_DT.value;
                var ISO_CLAUSE = document.main.ISO_CLAUSE.value;
                var DOC_REF = document.main.DOC_REF.value;
                var NCR_CLS_CONF = document.main.NCR_CLS_CONF.value;
                var NCR_CLS_CONF_DT = document.main.NCR_CLS_CONF_DT.value;
                //if (NCR_NO.length === 0)
                // {
                // alert("* Marked fields are mandatory.");
                //document.main.NCR_NO.focus();
                //return false;
                //}

                if (FY_YEAR.length === 0)
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

                if (AUDIT_AREA.length === 0)

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


                if (AUDITOR_NAME.length === 0)

                {
                    alert("* Marked fields are mandatory.");
                    document.main.AUDITOR_NAME.focus();
                    return false;
                }
                if (AUDIT_OBSERVATION.length === 0)

                {
                    alert("* Marked fields are mandatory.");
                    document.main.AUDIT_OBSERVATION.focus();
                    return false;
                }
                if (NCR_TYPE.length === 0)

                {
                    alert("* Marked fields are mandatory.");
                    document.main.NCR_TYPE.focus();
                    return false;
                }
                if (NCR_DETAILS.length === 0)

                {
                    alert("* Marked fields are mandatory.");
                    document.main.NCR_DETAILS.focus();
                    return false;
                }
                if (NCR_PLAN_CLS_DATE.length === 0)

                {
                    alert("* Marked fields are mandatory.");
                    document.main.NCR_PLAN_CLS_DATE.focus();
                    return false;
                }
                if (NCR_ACTUAL_CLS_DATE.length === 0)

                {
                    alert("* Marked fields are mandatory.");
                    document.main.NCR_ACTUAL_CLS_DATE.focus();
                    return false;
                }
                if (AUDITOR_ACTION.length === 0)

                {
                    alert("* Marked fields are mandatory.");
                    document.main.AUDITOR_ACTION.focus();
                    return false;
                }
                if (ISO_COORD_REMARKS.length === 0)

                {
                    alert("* Marked fields are mandatory.");
                    document.main.ISO_COORD_REMARKS.focus();
                    return false;
                }
                if (AUDITEE_REMARKS_CLS.length === 0)

                {
                    alert("* Marked fields are mandatory.");
                    document.main.AUDITEE_REMARKS_CLS.focus();
                    return false;
                }
                if (CORRECTION.length === 0)

                {
                    alert("* Marked fields are mandatory.");
                    document.main.CORRECTION.focus();
                    return false;
                }
                if (CORRECTION_NAME.length === 0)

                {
                    alert("* Marked fields are mandatory.");
                    document.main.CORRECTION_NAME.focus();
                    return false;
                }
                if (RCA.length === 0)

                {
                    alert("* Marked fields are mandatory.");
                    document.main.RCA.focus();
                    return false;
                }
                if (RCA_DT.length === 0)

                {
                    alert("* Marked fields are mandatory.");
                    document.main.RCA_DT.focus();
                    return false;
                }
                if (RCA_NAME.length === 0)

                {
                    alert("* Marked fields are mandatory.");
                    document.main.RCA_NAME.focus();
                    return false;
                }
                if (CORR_ACTION_DT.length === 0)

                {
                    alert("* Marked fields are mandatory.");
                    document.main.CORR_ACTION_DT.focus();
                    return false;
                }
                if (CORR_ACTION_NAME.length === 0)

                {
                    alert("* Marked fields are mandatory.");
                    document.main.CORR_ACTION_NAME.focus();
                    return false;
                }
                if (AUDITOR_REV_DT.length === 0)

                {
                    alert("* Marked fields are mandatory.");
                    document.main.AUDITOR_REV_DT.focus();
                    return false;
                }
                if (ISO_CLAUSE.length === 0)

                {
                    alert("* Marked fields are mandatory.");
                    document.main.ISO_CLAUSE.focus();
                    return false;
                }
                if (DOC_REF.length === 0)

                {
                    alert("* Marked fields are mandatory.");
                    document.main.DOC_REF.focus();
                    return false;
                }
                if (NCR_CLS_CONF.length === 0)

                {
                    alert("* Marked fields are mandatory.");
                    document.main.NCR_CLS_CONF.focus();
                    return false;
                }
                if (NCR_CLS_CONF_DT.length === 0)

                {
                    alert("* Marked fields are mandatory.");
                    document.main.NCR_CLS_CONF_DT.focus();
                    return false;
                }



            }

        </script>

        <SCRIPT LANGUAGE="JavaScript">

            function deleteattachment12(attachment)
            {
                if (attachment !== null && attachment !== '')
                {
                    var result = confirm("Are you sure want to delete?????");
                    if (result) {
                        var frm = document.getElementById('ncrform') || null;
                        if (frm) {
                            var element1 = document.createElement("input");
                            element1.value = attachment;
                            element1.name = "fileupload";
                            frm.appendChild(element1);
                            frm.action = 'NcrEdit.jsp?ncr_no=' + <%=NCR_NO%>;
                            frm.submit();
                        }
                    }
                }
                return false;
            }

            function openChild(file, window) {
                childWindow = open(file, window, 'resizable=no,top=200, left=100,width=600,height=300');
                if (childWindow.opener === null)
                    childWindow.opener = self;
            }

            function printForm()
            {
                var printContents = document.getElementById("order1").innerHTML;
                var originalContents = document.body.innerHTML;
                document.body.innerHTML = printContents;
                window.print();
                document.body.innerHTML = originalContents;
            }

            function printForm2()
            {
                var printContents = document.getElementById("order2").innerHTML;
                var originalContents = document.body.innerHTML;
                document.body.innerHTML = printContents;
                window.print();
                document.body.innerHTML = originalContents;
            }

        </SCRIPT>
        <script type="text/javascript"  LANGUAGE="JavaScript" src="js/datetimepicker.js"></script>
        <script src="js/jquery-3.3.1.min.js" type="text/javascript"></script>
    </head>
    <body bgcolor="#EAF2F8  ">
        <p>&nbsp;</p>
        <br>

        <form method="POST" action="ncrlist.jsp" name="My NCR List" >
            <table width="60%" border="0" cellspacing="1" cellpadding="1" align="center">
                <tr bgcolor="#EAF2F8">
                    <td colspan="3" align="right">
                        <div id="Username"  align="right" >
                            Logged In as... <%=UserName%> !!!
                        </div>
                        <div id="top"  align="right" >
                            <INPUT TYPE=BUTTON VALUE="HOME" ONCLICK="javascript:window.location = 'auditorform.jsp';" NAME="BUTTON" <%= AUDITOR_AUDITEE_COORD.equalsIgnoreCase("0") ? "" : "style=display:none;"%> /></font></b>
                            <input type="button" name="button" value="Change Password" style="width: 155px; height: 25px;  font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px;" onClick="document.location.href = 'tr_pwd.jsp'"/>
                            <input type="submit" name="Submit" value="My NCR List" style="width: 100px; height: 25px;  font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px;"  />
                            <INPUT TYPE=BUTTON VALUE="Logout" ONCLICK="document.location.href = 'logout.jsp';" NAME="BUTTON" style="width: 100px; height: 25px;  font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px;">
                        </div>
                    </td>
                </tr>
            </table>
        </form>
        <form method="POST" action="saveDetails.jsp" name="main" enctype="multipart/form-data" id="ncrform">
            <div  id="order">
                <table border="0" width="60%" align="center" bgcolor="#1B4F72">
                    <tr bgcolor="#1B4F72">
                        <td  height="42" colspan="3">
                            <p align="center"><font color="#999999"><b><font face="Arial, Helvetica" size="2"><font size="4"> my form </font><font size="5"><br>
                                    </font>INDIA<br>
                                    </font><font face="Arial, Helvetica" size="3">Audit Reports </font></b></font></p>  
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td>
                            <font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>User Name </strong></font>
                        </td>
                        <td>
                            <input name="UserName" type="text" id="UserName" size="25" value="<%=UserName%>" readonly />       
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>NCR_NO </strong></font></td>
                        <td>
                            <input name="NCR_NO" type="text" id="NCR_NO" size="25" value="<%=objNcr.getNCR_NO()%>" readonly /> 
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>FY_YEAR</strong></font></td>
                        <td>
                            <input name="FY_YEAR" type="text" id="FY_YEAR" size="25" value="<%=objNcr.getFY_YEAR()%>" readonly />
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDIT_DATE</strong></font></td>

                        <td>
                            <input name="AUDIT_DATE" type="text" id="AUDIT_DATE" size="25" value="<%=objNcr.getAUDIT_DATE()%>" readonly />
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDIT_AREA </strong></font></td>
                        <td>
                            <input name="AUDIT_AREA" type="text" id="AUDIT_AREA" size="25" value="<%=objNcr.getAUDIT_AREA_NAME() != null ? objNcr.getAUDIT_AREA_NAME() : ""%>" readonly  />
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDITEE_NAME </strong></font></td>
                        <td>
                            <input name="AUDITEE_NAME" type="text" id="AUDITEE_NAME" size="25" value="<%=objNcr.getAUDITEE_NAME()%>" readonly /> 
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDITEE_STFNO </strong></font></td>
                        <td>
                            <input name="AUDITEE_STFNO" type="text" id="AUDITEE_STFNO" size="25" value="<%=objNcr.getAUDITEE_STFNO()%>" readonly  />
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDITOR_STFNO </strong></font></td>
                        <td>
                            <input name="AUDITOR_STFNO" type="text" id="AUDITOR_STFNO" size="25" value="<%=objNcr.getAUDITOR_STFNO()%>" readonly  />
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDITOR_INT_NAME </strong></font></td>
                        <td>
                            <input name="AUDITOR_INT_NAME" type="text" id="AUDITOR_INT_NAME" size="25" value="<%=objNcr.getAUDITOR_INT_NAME()%>" readonly  />
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDITOR_EXT_NAME </strong></font></td>
                        <td>
                            <input name="AUDITOR_EXT_NAME" type="text" id="AUDITOR_EXT_NAME" size="25" value="<%=objNcr.getAUDITOR_EXT_NAME()%>" readonly  />
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDIT_OBSERVATION </strong></font></td>
                        <td>
                            <textarea name="AUDIT_OBSERVATION" id="AUDIT_OBSERVATION" size="25" style="margin: 0px; width: 600px; height: 100px;" readonly><%=objNcr.getAUDIT_OBSERVATION()%> </textarea>   
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>NCR_TYPE </strong></font></td>
                        <td>
                            <select name="NCR_TYPE" id="NCR_TYPE" disabled >
                                <option value="">Please Select</option>
                                <option value="Major" <%= objNcr.getNCR_TYPE() != null && objNcr.getNCR_TYPE().equalsIgnoreCase("Major") ? "selected=selected" : ""%> >Major</option>
                                <option value="Minor" <%= objNcr.getNCR_TYPE() != null && objNcr.getNCR_TYPE().equalsIgnoreCase("Minor") ? "selected=selected" : ""%> >Minor</option>
                                <option value="OFI" <%= objNcr.getNCR_TYPE() != null && objNcr.getNCR_TYPE().equalsIgnoreCase("OFI") ? "selected=selected" : "c"%> >OFI</option>
                            </select>
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>NCR_DETAILS  </strong></font></td>
                        <td>
                            <textarea name="NCR_DETAILS" id="NCR_DETAILS" size="25" style="margin: 0px; width: 600px; height: 100px;" readonly><%=objNcr.getNCR_DETAILS()%> </textarea>
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td>
                            <font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>NCR_PLAN_CLS_DATE</strong></font>
                        </td>
                        <td>
                            <input name="NCR_PLAN_CLS_DATE" type="text" id="NCR_PLAN_CLS_DATE" size="25" value="<%=objNcr.getNCR_PLAN_CLS_DATE()%>" readonly/>
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>ISO_CLAUSE  </strong></font></td>
                        <td>
                            <input name="ISO_CLAUSE" type="text" id="I
                                   SO_CLAUSE" size="25" value="<%= objNcr.getISO_CLAUSE() != null ? objNcr.getISO_CLAUSE() : ""%>"readonly/>  
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>DOC_REF  </strong></font></td>
                        <td>
                            <input name="DOC_REF" type="text" id="DOC_REF" size="25" value="<%= objNcr.getDOC_REF() != null ? objNcr.getDOC_REF() : ""%>" readonly/>         
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>EMAIL  </strong></font></td>
                        <td>
                            <input name="EMAIL" type="text" id="EMAIL" size="25" value="<%= objNcr.getEMAIL() != null ? objNcr.getEMAIL() : ""%>" >     
                            <input name="chkEmail" type="checkbox" id="chkEmail" />
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td ><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>NCR_ACTUAL_CLS_DATE</strong></font></td>
                        <td>
                            <input name="NCR_ACTUAL_CLS_DATE" type="text" id="NCR_ACTUAL_CLS_DATE" size="25" value="<%= objNcr.getNCR_ACTUAL_CLS_DATE() != null ? objNcr.getNCR_ACTUAL_CLS_DATE() : ""%>" readonly>
                            <a href="javascript:NewCal('NCR_ACTUAL_CLS_DATE','ddmmmyyyy')" class="isolog">
                                <img src="images/calendar.jpg" width="20" height="20" border="0" alt="Pick a date" style="vertical-align: bottom;"/></a>
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDITEE_REMARKS_CLS  </strong></font></td>
                        <td>
                            <textarea name="AUDITEE_REMARKS_CLS" id="AUDITEE_REMARKS_CLS" size="25" style="margin: 0px; width: 600px; height: 100px;" ><%=objNcr.getAUDITEE_REMARKS_CLS()%> </textarea> 
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>CORRECTION  </strong></font></td>
                        <td>
                            <textarea name="CORRECTION" id="CORRECTION" size="25" style="margin: 0px; width: 600px; height: 100px;" ><%=objNcr.getCORRECTION()%> </textarea>
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>CORR_DT</strong></font></td>
                        <td><input name="CORR_DT" type="text" id="CORR_DT" size="25" value="<%= objNcr.getCORR_DT() != null ? objNcr.getCORR_DT() : ""%>" readonly>
                            <a href="javascript:NewCal('CORR_DT','ddmmmyyyy')" class="isolog">
                                <img src="images/calendar.jpg" width="20" height="20" border="0" alt="Pick a date" style="vertical-align: bottom;"/></a>
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>CORRECTION_NAME  </strong></font></td>
                        <td>
                            <input name="CORRECTION_NAME" type="text" id="CORRECTION_NAME" value="<%= objNcr.getCORRECTION_NAME() != null ? objNcr.getCORRECTION_NAME() : ""%>" > 
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>RCA  </strong></font></td>
                        <td>
                            <textarea name="RCA" id="RCA" size="25" style="margin: 0px; width: 600px; height: 100px;" ><%=objNcr.getRCA()%> </textarea> 
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td ><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>RCA_DT</strong></font></td>

                        <td><input name="RCA_DT" type="text" id="RCA_DT" size="25" value="<%= objNcr.getRCA_DT() != null ? objNcr.getRCA_DT() : ""%>"readonly />
                            <a href="javascript:NewCal('RCA_DT','ddmmmyyyy')" class="isolog">
                                <img src="images/calendar.jpg" width="20" height="20" border="0" alt="Pick a date" style="vertical-align: bottom;"/></a>
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>RCA_NAME  </strong></font></td>
                        <td>
                            <input name="RCA_NAME" type="text" id="RCA_NAME" size="25" value="<%= objNcr.getRCA_NAME() != null ? objNcr.getRCA_NAME() : ""%>" />         
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>CORR_ACTION  </strong></font></td>
                        <td>
                            <textarea name="CORR_ACTION" id="CORR_ACTION" size="25" style="margin: 0px; width: 600px; height: 100px;" ><%=objNcr.getCORR_ACTION()%> </textarea>  
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>CORR_ACTION_DT</strong></font></td>

                        <td><input name="CORR_ACTION_DT" type="text" id="CORR_ACTION_DT" size="25" value="<%= objNcr.getCORR_ACTION_DT() != null ? objNcr.getCORR_ACTION_DT() : ""%>" readonly />
                            <a href="javascript:NewCal('CORR_ACTION_DT','ddmmmyyyy')" class="isolog">
                                <img src="images/calendar.jpg" width="20" height="20" border="0" alt="Pick a date" style="vertical-align: bottom;"/></a>
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>CORR_ACTION_NAME  </strong></font></td>
                        <td>
                            <input name="CORR_ACTION_NAME" type="text" id="CORR_ACTION_NAME" size="25" value="<%= objNcr.getCORR_ACTION_NAME() != null ? objNcr.getCORR_ACTION_NAME() : ""%>" />
                        </td>
                    </tr>


                    <tr bgcolor="#AED6F1">

                        <td ><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>ATTACHMENT</strong></font></td>
                        <td>
                            <font size="2" face="Verdana, Arial, Helvetica, sans-serif" <%= objNcr.getATTACHMENT().isEmpty() ? "" : "style=display:none;"%>>
                            <input type="file" id="files" name="ATTACHMENT" value="<%= objNcr.getATTACHMENT()%>" />
                            (Upload Audit observation )</font>
                            <a href="download.jsp?filename=<%=objNcr.getATTACHMENT().trim()%>"><%= objNcr.getATTACHMENT().trim()%></a>
                            <img src="images/delete.jpg" id="imageAttach" alt="Delete" style="cursor:pointer;" height="20" onClick="return deleteattachment('<%=objNcr.getATTACHMENT().trim()%>')" <%= objNcr.getATTACHMENT().isEmpty() ? "style=display:none;" : ""%> />
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>NCR_CLS_CONF  </strong></font></td>
                        <td>
                            <select name="NCR_CLS_CONF" id="NCR_CLS_CONF" >
                                <option value="">Please Select</option>
                                <option value="Accepted" <%= objNcr.getNCR_CLS_CONF() != null && objNcr.getNCR_CLS_CONF().equalsIgnoreCase("Accepted") ? "selected=selected" : "a"%> >Accepted</option>
                                <option value="Rejected" <%= objNcr.getNCR_CLS_CONF() != null && objNcr.getNCR_CLS_CONF().equalsIgnoreCase("Rejected") ? "selected=selected" : "b"%> >Rejected</option>
                                <option value="TBD" <%= objNcr.getNCR_CLS_CONF() != null && objNcr.getNCR_CLS_CONF().equalsIgnoreCase("TBD") ? "selected=selected" : "c"%> >TBD</option>
                            </select>
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDITOR_ACTION  </strong></font></td>
                        <td>
                            <select name="AUDITOR_ACTION" id="AUDITOR_ACTION" >
                                <option value="">Please Select</option>
                                <option value="Accepted" <%= objNcr.getAUDITOR_ACTION() != null && objNcr.getAUDITOR_ACTION().equalsIgnoreCase("Accepted") ? "selected=selected" : "a"%> >Accepted</option>
                                <option value="Rejected" <%= objNcr.getAUDITOR_ACTION() != null && objNcr.getAUDITOR_ACTION().equalsIgnoreCase("Rejected") ? "selected=selected" : "b"%> >Rejected</option>
                                <option value="TBD" <%= objNcr.getAUDITOR_ACTION() != null && objNcr.getAUDITOR_ACTION().equalsIgnoreCase("TBD") ? "selected=selected" : "c"%> >TBD</option>
                            </select>
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>ISO_COORD_REMARKS  </strong></font></td>
                        <td>
                            <textarea name="ISO_COORD_REMARKS" id="ISO_COORD_REMARKS" size="25" style="margin: 0px; width: 600px; height: 100px;" readonly><%=objNcr.getISO_COORD_REMARKS()%> </textarea>  
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td ><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDITOR_REV_DT</strong></font></td>

                        <td  ><input name="AUDITOR_REV_DT" type="text" id="AUDITOR_REV_DT" size="25" value="<%= objNcr.getAUDITOR_REV_DT() != null ? objNcr.getAUDITOR_REV_DT() : ""%>"readonly >
                            <a href="javascript:NewCal('AUDITOR_REV_DT','ddmmmyyyy')" id="A_AUDITOR_REV_DT">
                                <img src="images/calendar.jpg" width="20" height="20" border="0" alt="Pick a date" style="vertical-align: bottom;"/></a>
                        </td>
                    </tr>



                    <tr bgcolor="#AED6F1">
                        <td ><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>NCR_CLS_CONF_DT</strong></font></td>

                        <td  ><input name="NCR_CLS_CONF_DT" type="text" id="NCR_CLS_CONF_DT" size="25" value="<%= objNcr.getNCR_CLS_CONF_DT() != null ? objNcr.getNCR_CLS_CONF_DT() : ""%>"readonly />
                            <a href="javascript:NewCal('NCR_CLS_CONF_DT','ddmmmyyyy')"id="A_NCR_CLS_CONF_DT" >
                                <img src="images/calendar.jpg" width="20" height="20" border="0" alt="Pick a date" style="vertical-align: bottom;"/></a>
                            <input type="hidden" name="AUDITOR_AUDITEE_COORD" value="<%=AUDITOR_AUDITEE_COORD%>" id="AUDITOR_AUDITEE_COORD"/>
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">

                        <td >&nbsp;</td>
                        <td>
                            <input type="submit" value="<%=BUTTON%>" name="B1" onClick="return validlogin()" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px; color: #FF0000"/>
                            <input type="reset" value="Clear" name="B2"/>  
                            <input type="button" name ="History" id="add" value=" History   " onclick="getHistory();">
                            <input type="submit" name ="GENERATE NCR REPORT" id="add" value=" GENERATE NCR REPORT   " onclick="printForm();"/>
                            <input type="submit" name ="GENERATE AUDIT REPORT " id="addd" value=" GENERATE AUDIT REPORT " onclick="printForm2();"/>
                        </td>
                    </tr>
                    <tr bgcolor="#AED6F1">
                    </tr>
                </table>   
                <br/>

                <br/>
                <div id="dialog" title="History Log">
                    <div id="dvHistory"></div>
                </div>
            </div>
        </form>
        <%--Copy the forms form note pad print form and replace with objNCR.get --%>
        <form>
            <div id="order1" style=" display:none;" >

                </head>

                <body>
                    <table class="mytable mytable-head" width="800">
                        <tr>
                            <td width="20%" rowspan="3"></td>
                            <td align="center" colspan="3">
                                <table style="border:0 !important;">
                                    <tr align="center">
                                        <td style="border:0 !important;" ><strong>xxxxx</td>
                                    </tr>
                                    <tr align="center">
                                        <td style="border:0 !important;">yyyyy</td>
                                    </tr>
                                </table>
                            </td>
                        </tr>

                        <tr>
                            <td align="center" colspan="3">
                                <table style="border:0 !important;">
                                    <tr align="center">
                                        <td style="border:0 !important;"><strong>zzzz(Based on ISO xxx:xxxx)</td>
                                    </tr>
                                    <tr align="center">
                                        <td style="border:0 !important;"><strong>NON CONFORMANCE Report</td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>

                    <table class="mytable mytable-head">

                        <tr>
                            <td><strong>DEPARTMENT/ FUNCTIONAL AREA</td>
                            <td><strong>DATE</td>
                            <td><strong>NATURE OF OBSERVATION</td>
                            <td><strong>NCR No.</td>
                        </tr>
                        <tr>
                            <td><%=objNcr.getAUDIT_AREA()%></td>
                            <td><%=objNcr.getAUDIT_DATE()%></td>
                            <td><strong>MAJOR NCR/MINOR NCR/OFFICE:</strong><%=objNcr.getNCR_TYPE()%></td>
                            <td><%=NCR_NO%></td>
                        </tr>
                    </table>
                    <table class="mytable mytable-head">
                        <tr>
                            <td><strong>SL NO.</td>
                            <td><strong>ISO CLAUSE REF</td>
                            <td><strong>DOCUMENT REF</td>
                            <td><strong>Description of Non Conformance</td>
                        </tr>

                        <tr>
                            <td></td>
                            <td><%=objNcr.getISO_CLAUSE()%></td>
                            <td><%=objNcr.getDOC_REF()%></td>
                            <td><%=objNcr.getNCR_DETAILS()%></td>
                        </tr>
                    </table>

                    <table class="mytable mytable-head">  
                        <tr>
                            <td style= "height: 90px" colspan="2"><strong>PROPOSED COMPLETION DATE<br><br><br></strong><%=objNcr.getNCR_PLAN_CLS_DATE()%></td>
                            <td><strong>AUDITOR SIGN<br><br><br>NAME:</strong><%=objNcr.getAUDITOR_INT_NAME()%></td>
                            <td><strong>AUDITEE SIGN<br><br><br>NAME:</strong><%=objNcr.getAUDITEE_NAME()%></td>
                        </tr>
                        <tr>
                            <td style= "height: 90px" colspan="4"><strong>CORRECTION TO BE FILLED BY AUDITEE</strong>:<%=objNcr.getAUDIT_OBSERVATION()%><br><br><br><br></td>
                        </tr>

                    </table>
                    <table class="mytable mytable-head">
                        <tr>
                            <td style= "height: 90px" colspan="4"><strong>ROOT CAUSE ANALYSIS TO BE FILLED BY AUDITEE</strong><%=objNcr.getRCA()%><br><br><br><br></</td>
                        </tr>
                        <tr>
                    </table>
                    <table class="mytable mytable-head">
                        <td style= "height: 90px" colspan="4"><strong>CORRECTIVE ACTION TO BE FILLED BY AUDITEE :</strong><br><br><>
                            <%=objNcr.getCORR_ACTION()%>
                            <br>
                            <br>
                            <br>
                            <strong>DATE:</strong><%=objNcr.getNCR_ACTUAL_CLS_DATE()%> <strong>AUDITEE: </strong>> <%=objNcr.getAUDITEE_NAME()%> <strong>            HOS(Audit area) : </strong><%=objNcr.getAUDIT_AREA()%>
                        </td>
                        </tr>
                    </table>
                    <table class="mytable mytable-head">
                        <tr>
                            <td style= "height: 90px" colspan="2"><strong>REVIEW OF CORRECTIVE ACTION:</strong><br><br><%=objNcr.getISO_COORD_REMARKS()%><br><br><br><strong>DATE:  </strong><%=objNcr.getAUDITOR_REV_DT()%> AUDITOR</td>
                            <td style= "height: 90px" colspan="2"><strong>NCR CLOSED:</strong><%=objNcr.getAUDITOR_ACTION()%><br><br><br><br><br><strong>DATE:</strong>  <%=objNcr.getNCR_CLS_CONF_DT()%>   Head Quality</td>
                        </tr>
                    </table> 
            </div> 
        </form>
        <form>
            <div id="order2" style=" display:none;" >
                <style type="text/css">
                    .mytable {
                        border-collapse: collapse;
                        width: 100%;
                        background-color: white;
                    }
                    .mytable-head {
                        border: 1px solid black;
                        margin-bottom: 0;
                        padding-bottom: 0;
                    }
                    .mytable-head td {
                        border: 1px solid black;
                    }
                    .mytable-body {
                        border: 1px solid black;
                        border-top: 0;
                        margin-top: 0;
                        padding-top: 0;
                        margin-bottom: 0;
                        padding-bottom: 0;
                    }
                    .mytable-body td {
                        border: 1px solid black;
                        border-top: 0;
                    }

                </style>
                </head>

                <body>


                    <table class="mytable mytable-head" width="800">
                        <tr>
                            <td width="20%"rowspan="2"></td>
                            <td align="center" colspan="2">
                                <table style="border:0 !important;">
                                    <tr align="center">
                                        <td style="border:0 !important;">xxxxx</td>
                                    </tr>
                                    <tr align="center">
                                        <td style="border:0 !important;">yyyyy</td>
                                    </tr>
                                </table>
                            </td>     
                        </tr>

                        <tr>
                            <td align="center" colspan="2">
                                <table style="border:0 !important;">
                                    <tr align="center">
                                        <td style="border:0 !important;">Quality System Audit(based on ISO bbbbb)</td>
                                    </tr>
                                    <tr align="center">
                                        <td style="border:0 !important;">zzzz Report</td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <table class="mytable mytable-head" width="800">
                            <tr>
                                <td width="35%">DEPARTMENT/ FUNCTIONAL AREA</td>
                                <td>AUDITEE NAME</td>
                                <td>AUDITOR NAME</td>
                            </tr>
                            <tr>
                                <td><%=objNcr.getAUDIT_AREA()%></td>
                                <td><%=objNcr.getAUDITEE_NAME()%></td>
                                <td style="padding: 0 !important">
                                    <table style="border:0 !important;width:100%">
                                        <tr>
                                            <td style="border:0 !important;"><%=objNcr.getAUDITOR_INT_NAME()%></td>
                                        </tr>

                                        <tr>
                                            <td style="    border: 0 !important;
                                                border-top: 1px solid black !important;">&nbsp;&nbsp;</td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>

                            <tr>
                                <td style= "height: 350px" colspan="3">&nbsp;<br /><br /><br /><br /></td>
                            </tr>

                            <tr>
                                <td>DATE: <%=objNcr.getAUDIT_DATE()%></td>
                                <td style= "height: 40px"colspan="2">AUDITOR'S SIGN</td>
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
</html>
<script src="js/jquery-3.3.1.min.js" type="text/javascript"></script>
<script src="js/jquery-ui.js" type="text/javascript"></script>
<link href="jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="js/ncrHistory.js" type="text/javascript"></script>

<script type="text/javascript">
    $(document).ready(function () {
        setPageAccess();
    });
</script>