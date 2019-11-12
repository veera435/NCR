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
    NcrAudit objNcr = new NcrAudit();
    // Used for page refresh when ncr edits
    session.setAttribute("refresh", "false");
    String qstring = "";
    String AUDITER_TYPE = session.getAttribute("AUDITER_TYPE").toString();
%>

<%    class AuditType {

        private int id;
        private String name;

        public AuditType(int id, String name) {

            this.id = id;
            this.name = name;
        }

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }
    }
    List<AuditType> arrAuditTypes = new ArrayList<AuditType>();

    try {
        String query = (String) request.getParameter("name");
        Connection conn = con.getcon();
        qstring = " select * from Audit_Area_Types";
        Statement stmt = con.getSt();
        ResultSet rs = stmt.executeQuery(qstring);

        while (rs.next()) {
            arrAuditTypes.add(new AuditType(rs.getInt("Audit_ID"), rs.getString("Audit_Name")));
        }
    } catch (Exception e) {
        System.out.println("Exception " + e.toString());%>
<jsp:forward page="errorpage.jsp"></jsp:forward>
<%}%>

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

            }

        </script>

        <SCRIPT LANGUAGE="JavaScript">

            function deleteattachment(attachment)
            {
                if (attachment !== null && attachment !== '')
                {
                    var result = confirm("Are you sure want to delete?");
                    if (result) {
                        var frm = document.getElementById('ncrform') || null;
                        if (frm) {
                            var element1 = document.createElement("input");
                            element1.value = attachment;
                            element1.name = "fileupload";
                            frm.appendChild(element1);
                            frm.action = 'auditeeform.jsp?ncr_no=' + <%=NCR_NO%>;
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

        </SCRIPT>
        <script type="text/javascript"  LANGUAGE="JavaScript" src="js/datetimepicker.js"></script>
        <script src="js/jquery-3.3.1.min.js" type="text/javascript"></script>
        <script src="js/jquery-ui.js" type="text/javascript"></script>
        <link href="jquery-ui.css" rel="stylesheet" type="text/css"/>
        <script src="js/ncrHistory.js" type="text/javascript"></script>
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
                            <INPUT TYPE=BUTTON VALUE="HOME" ONCLICK="javascript:window.location = 'auditorform.jsp';" NAME="BUTTON"></font></b>
                            <input type="button" name="button" value="Change Password" style="width: 155px; height: 25px;  font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px;" onClick="document.location.href = 'tr_pwd.jsp'"/>
                            <input type="submit" name="Submit" value="My NCR List" style="width: 100px; height: 25px;  font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px;"  />
                            <INPUT TYPE=BUTTON VALUE="Logout" ONCLICK="document.location.href = 'logout.jsp';" NAME="BUTTON" style="width: 100px; height: 25px;  font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px;"></td>
                        </div>
                </tr>
            </table>
        </form>
        <form method="POST" action="auditorsaveDetails.jsp" name="main" enctype="multipart/form-data" id="ncrform">
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
                            <select name="FY_YEAR" id="FY_YEAR" >
                                <option value="">Please Select</option>
                                <option value="2018-2019" <%= objNcr.getFY_YEAR() != null && objNcr.getFY_YEAR().equalsIgnoreCase("2018-2019") ? "selected=selected" : ""%> >2018-2019</option>
                                <option value="2019-2020" <%= objNcr.getFY_YEAR() != null && objNcr.getFY_YEAR().equalsIgnoreCase("2019-2020") ? "selected=selected" : ""%> >2019-2020</option>
                                <option value="2020-2021" <%= objNcr.getFY_YEAR() != null && objNcr.getFY_YEAR().equalsIgnoreCase("2020-2021") ? "selected=selected" : ""%> >2020-2021</option>  
                            </select>
                        </td>

                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDIT_DATE</strong></font></td>

                        <td>
                            <input name="AUDIT_DATE" type="text" id="AUDIT_DATE" size="25" value="<%=objNcr.getAUDIT_DATE()%>"  />
                            <a href="javascript:NewCal('AUDIT_DATE','ddmmmyyyy')" class="isolog">
                                <img src="images/calendar.jpg" width="20" height="20" border="0" alt="Pick a date" style="
                                     vertical-align: bottom;"></a>
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDIT_AREA </strong></font></td>
                        <td>
                            <select name="AUDIT_AREA" id="AUDIT_AREA" <%=AUDITER_TYPE.equalsIgnoreCase("1") ? "disabled" : ""%>>
                                <option value="">Please Select</option>   
                                <% for (int i = 0; i < arrAuditTypes.size(); i++) {
                                        if (objNcr.getAUDIT_AREA().isEmpty() == false && Integer.parseInt(objNcr.getAUDIT_AREA()) == arrAuditTypes.get(i).id) {%>
                                <option value="<%= arrAuditTypes.get(i).id%>" selected><%=arrAuditTypes.get(i).name%></option>
                                <% } else {%>
                                    <option value="<%= arrAuditTypes.get(i).id%>"><%=arrAuditTypes.get(i).name%></option>
                                <%}}%>
                            </select>
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDITEE_NAME </strong></font></td>
                        <td>
                            <input name="AUDITEE_NAME" type="text" id="AUDITEE_NAME" size="25" value="<%=objNcr.getAUDITEE_NAME()%>" <%=AUDITER_TYPE.equalsIgnoreCase("1") ? "disabled" : ""%>/> 
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDITEE_STFNO </strong></font></td>
                        <td>
                            <input name="AUDITEE_STFNO" type="text" id="AUDITEE_STFNO" size="25" value="<%=objNcr.getAUDITEE_STFNO()%>" <%=AUDITER_TYPE.equalsIgnoreCase("1") ? "disabled" : ""%> />
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDITOR_STFNO </strong></font></td>
                        <td>
                            <input name="AUDITOR_STFNO" type="text" id="AUDITOR_STFNO" size="25" value="<%=objNcr.getAUDITOR_STFNO()%>"  readonly />
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDITOR_INT_NAME </strong></font></td>
                        <td>
                            <input name="AUDITOR_INT_NAME" type="text" id="AUDITOR_INT_NAME" size="25" value="<%=objNcr.getAUDITOR_INT_NAME()%>"  readonly />
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDITOR_EXT_NAME </strong></font></td>
                        <td>
                            <input name="AUDITOR_EXT_NAME" type="text" id="AUDITOR_EXT_NAME" size="25" value="<%=objNcr.getAUDITOR_EXT_NAME()%>"  <%=AUDITER_TYPE.equalsIgnoreCase("0") ? "disabled" : ""%> />
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDIT_OBSERVATION </strong></font></td>
                        <td>
                            <textarea name="AUDIT_OBSERVATION" id="AUDIT_OBSERVATION" size="25" style="margin: 0px; width: 600px; height: 100px;" ><%=objNcr.getAUDIT_OBSERVATION()%> </textarea>   
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>NCR_TYPE </strong></font></td>
                        <td>
                            <select name="NCR_TYPE" id="NCR_TYPE" >
                                <option value="">Please Select</option>
                                <option value="Major" <%= objNcr.getNCR_TYPE() != null && objNcr.getNCR_TYPE().equalsIgnoreCase("Major") ? "selected=selected" : ""%> >Major</option>
                                <option value="Minor" <%= objNcr.getNCR_TYPE() != null && objNcr.getNCR_TYPE().equalsIgnoreCase("Minor") ? "selected=selected" : ""%> >Minor</option>
                                <option value="OFI" <%= objNcr.getNCR_TYPE() != null && objNcr.getNCR_TYPE().equalsIgnoreCase("OFI") ? "selected=selected" : ""%> >OFI</option>
                            </select>
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>NCR_DETAILS  </strong></font></td>
                        <td>
                            <textarea name="NCR_DETAILS" id="NCR_DETAILS" size="25" style="margin: 0px; width: 600px; height: 100px;" ><%=objNcr.getNCR_DETAILS()%> </textarea>
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td>
                            <font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>NCR_PLAN_CLS_DATE</strong></font>
                        </td>
                        <td>
                            <input name="NCR_PLAN_CLS_DATE" type="text" id="NCR_PLAN_CLS_DATE" size="25" value="<%=objNcr.getNCR_PLAN_CLS_DATE()%>" />
                            <a href="javascript:NewCal('NCR_PLAN_CLS_DATE','ddmmmyyyy')" class="isolog">
                                <img src="images/calendar.jpg" width="20" height="20" border="0" alt="Pick a date" style="
                                     vertical-align: bottom;"></a>
                        </td>
                    </tr>
                    <tr bgcolor="#AED6F1">

                        <td >&nbsp;</td>
                        <td>
                            <input type="submit" value="<%=BUTTON%>" name="B1" onClick="return validlogin()" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px; color: #FF0000">
                            <input type="reset" value="Clear" name="B2">  
                            <input type="button" name ="History" id="add" value=" History   " onclick="getHistory();">
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

        <%} else {%>
        <h1> Session Expired </h1>
        <a href="logout.jsp">click here</a>
        <%}%>


    </body>
</html>

<SCRIPT LANGUAGE="JavaScript">

    $(document).ready(function () {
        initAutoComplete("<%=session.getAttribute("AUDITER_TYPE").toString()%>");

        $("#AUDIT_AREA").change(function () {
            $('#AUDITEE_NAME_HIDDEN').val("");
            $('#AUDITEE_NAME').val("");
            $('#AUDITEE_STFNO').val();
        });
    });

</SCRIPT>