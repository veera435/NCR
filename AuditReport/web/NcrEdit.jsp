<%--
    Document   : tr1
    Created on : 5 Aug, 2017, 1:08:58 PM
    Author     : 6157637
--%>


<%@page import="Audit.AuditType"%>
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
    String UserName = session.getAttribute("UserName").toString();
    String NCR_NO = request.getParameter("ncr_no") == null ? "0" : request.getParameter("ncr_no");
    String FileName = "";
    String name1;
    String value;
    String AUDITOR_AUDITEE_COORD = session.getAttribute("AUDITOR_AUDITEE_COORD").toString();
    String AACName = session.getAttribute("AACName").toString();
    String AUDITER_TYPE = session.getAttribute("AUDITER_TYPE").toString();
    NcrAudit objNcr = new NcrAudit();
    // Used for page refresh when ncr edits
    session.setAttribute("refresh", "false");
%>

<%
    AuditInfo objAuditInfo = new AuditInfo();
    List<AuditType> arrAuditTypes = null;
    arrAuditTypes = objAuditInfo.GetAuditTypes();

    try {
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

    .table, th{
        border: 1px solid black;
        border-collapse: collapse;
    }
    .th, td {
        padding: 5px;
        text-align: left;    
    }
    .th{ border:none; background-color:#CCC;}
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

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <title>Tour Report</title>
    </head>
    <body bgcolor="#EAF2F8  ">
        <table width="60%" border="0" cellspacing="1" cellpadding="1" align="center">
            <tr bgcolor="#EAF2F8">
                <td colspan="3" align="right">
                    <div id="Username"  align="right" >
                        Logged in as...<%=UserName%>[<%=AACName%>]
                    </div>
                    <div id="top"  align="right" >
                        <INPUT TYPE=BUTTON VALUE="HOME" ONCLICK="javascript:window.location = 'auditorform.jsp';" NAME="BUTTON" <%= AUDITOR_AUDITEE_COORD.equalsIgnoreCase("0") ? "" : "style=display:none;"%> /></font></b>
                        <input type="button" name="button" onClick="document.location.href = 'Change_Password.jsp'" value="Change Password" style="width: 155px; height: 25px;  font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px;" />
                        <input type="submit" name="Submit" onClick="document.location.href = 'ncrlist.jsp'" value="My NCR List" style="width: 100px; height: 25px;  font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px;"  />
                        <INPUT TYPE=BUTTON VALUE="Logout" ONCLICK="document.location.href = 'logout.jsp';" NAME="BUTTON" style="width: 100px; height: 25px;  font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px;">
                    </div>
                </td>
            </tr>
        </table>
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
                            <input name="AUDIT_DATE" type="text" id="AUDIT_DATE" size="25" value="<%= objNcr.getAUDIT_DATE() != null ? objNcr.getAUDIT_DATE() : ""%>" readonly />
                            <a href="javascript:NewCal('AUDIT_DATE','ddmmmyyyy')" class="isolog" id="A_AUDIT_DATE">
                                <img src="images/calendar.jpg" width="20" height="20" border="0" alt="Pick a date" style="
                                     vertical-align: bottom;"></a>
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDIT_AREA </strong></font></td>
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
                            <textarea name="AUDIT_OBSERVATION" id="AUDIT_OBSERVATION" size="25" style="margin: 0px; width: 600px; height: 100px;" ><%=objNcr.getAUDIT_OBSERVATION()%> </textarea>   
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>NCR_TYPE </strong></font></td>
                        <td>
                            <select name="NCR_TYPE" id="NCR_TYPE"  >
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
                            <textarea name="NCR_DETAILS" id="NCR_DETAILS" size="25" style="margin: 0px; width: 600px; height: 100px;" ><%=objNcr.getNCR_DETAILS()%> </textarea>
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td>
                            <font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>NCR_PLAN_CLS_DATE</strong></font>
                        </td>
                        <td>
                            <input name="NCR_PLAN_CLS_DATE" type="text" id="NCR_PLAN_CLS_DATE" size="25" value="<%=objNcr.getNCR_PLAN_CLS_DATE() != null ? objNcr.getNCR_PLAN_CLS_DATE() : ""%>" readonly />
                            <a href="javascript:NewCal('NCR_PLAN_CLS_DATE','ddmmmyyyy')" class="isolog" id="A_NCR_PLAN_CLS_DATE">
                                <img src="images/calendar.jpg" width="20" height="20" border="0" alt="Pick a date" style="
                                     vertical-align: bottom;"></a>
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>ISO_CLAUSE  </strong></font></td>
                        <td>
                            <input name="ISO_CLAUSE" type="text" id="ISO_CLAUSE" size="25" value="<%= objNcr.getISO_CLAUSE() != null ? objNcr.getISO_CLAUSE() : ""%>"/>  
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>DOC_REF  </strong></font></td>
                        <td>
                            <input name="DOC_REF" type="text" id="DOC_REF" size="25" value="<%= objNcr.getDOC_REF() != null ? objNcr.getDOC_REF() : ""%>" />         
                        </td>
                    </tr>


                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDITOR_REMARKS  </strong></font></td>
                        <td>
                            <textarea name="AUDITOR_REMARKS" id="AUDITOR_REMARKS" size="25" style="margin: 0px; width: 600px; height: 100px;" ><%= objNcr.getAUDITOR_REMARKS() != null ? objNcr.getAUDITOR_REMARKS() : ""%> </textarea>  
                        </td>
                    </tr>
                    <tr bgcolor="#AED6F1">
                        <td ><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>NCR_ACTUAL_CLS_DATE</strong></font></td>
                        <td>
                            <input name="NCR_ACTUAL_CLS_DATE" type="text" id="NCR_ACTUAL_CLS_DATE" size="25" value="<%= objNcr.getNCR_ACTUAL_CLS_DATE() != null ? objNcr.getNCR_ACTUAL_CLS_DATE() : ""%>" readonly>
                            <a href="javascript:NewCal('NCR_ACTUAL_CLS_DATE','ddmmmyyyy')" class="isolog" id="A_NCR_ACTUAL_CLS_DATE">
                                <img src="images/calendar.jpg" width="20" height="20" border="0" alt="Pick a date" style="vertical-align: bottom;"/></a>
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDITEE_REMARKS_CLS  </strong></font></td>
                        <td>
                            <textarea name="AUDITEE_REMARKS_CLS" id="AUDITEE_REMARKS_CLS" size="25" style="margin: 0px; width: 600px; height: 100px;"><%= objNcr.getAUDITEE_REMARKS_CLS() != null ? objNcr.getAUDITEE_REMARKS_CLS() : ""%> </textarea> 
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>CORRECTION  </strong></font></td>
                        <td>
                            <textarea name="CORRECTION" id="CORRECTION" size="25" style="margin: 0px; width: 600px; height: 100px;" ><%= objNcr.getCORRECTION() != null ? objNcr.getCORRECTION() : ""%> </textarea>
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>CORR_DATE</strong></font></td>
                        <td><input name="CORR_DT" type="text" id="CORR_DT" size="25" value="<%= objNcr.getCORR_DT() != null ? objNcr.getCORR_DT() : ""%>" readonly>
                            <a href="javascript:NewCal('CORR_DT','ddmmmyyyy')" class="isolog" id="A_CORR_DT">
                                <img src="images/calendar.jpg" width="20" height="20" border="0" alt="Pick a date" style="vertical-align: bottom;"/></a>
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>CORRECTION BY  </strong></font></td>
                        <td>
                            <input name="CORRECTION_NAME" type="text" id="CORRECTION_NAME" value="<%= objNcr.getCORRECTION_NAME() != null ? objNcr.getCORRECTION_NAME() : ""%>" > 
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>ROOT CAUSE ANALYSIS  </strong></font></td>
                        <td>
                            <textarea name="RCA" id="RCA" size="25" style="margin: 0px; width: 600px; height: 100px;" ><%= objNcr.getRCA() != null ? objNcr.getRCA() : ""%> </textarea> 
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td ><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>RCA_DATE</strong></font></td>

                        <td><input name="RCA_DT" type="text" id="RCA_DT" size="25" value="<%= objNcr.getRCA_DT() != null ? objNcr.getRCA_DT() : ""%>"readonly />
                            <a href="javascript:NewCal('RCA_DT','ddmmmyyyy')" class="isolog" ID="A_RCA_DT">
                                <img src="images/calendar.jpg" width="20" height="20" border="0" alt="Pick a date" style="vertical-align: bottom;"/></a>
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>RCA BY  </strong></font></td>
                        <td>
                            <input name="RCA_NAME" type="text" id="RCA_NAME" size="25" value="<%= objNcr.getRCA_NAME() != null ? objNcr.getRCA_NAME() : ""%>" />         
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>CORR_ACTION  </strong></font></td>
                        <td>
                            <textarea name="CORR_ACTION" id="CORR_ACTION" size="25" style="margin: 0px; width: 600px; height: 100px;" ><%= objNcr.getCORR_ACTION() != null ? objNcr.getCORR_ACTION() : ""%> </textarea>  
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>CORRECTIVE ACTION BY</strong></font></td>

                        <td><input name="CORR_ACTION_DT" type="text" id="CORR_ACTION_DT" size="25" value="<%= objNcr.getCORR_ACTION_DT() != null ? objNcr.getCORR_ACTION_DT() : ""%>" readonly />
                            <a href="javascript:NewCal('CORR_ACTION_DT','ddmmmyyyy')" class="isolog"ID="A_CORR_ACTION_DT">
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

                        <td ><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>ATTACHMENT</strong></font>
                        </td>
                        <td>
                            <% if (objNcr.getATTACHMENT() == null || objNcr.getATTACHMENT().isEmpty()) {%>
                            <font size="2" face="Verdana, Arial, Helvetica, sans-serif">
                            <input type="file" id="files" name="ATTACHMENT" value="<%= objNcr.getATTACHMENT()%>" />
                            (Upload Audit observation )
                            </font>
                            <% } else {%>
                            <a href="download.jsp?filename=<%=objNcr.getATTACHMENT().trim()%>&ncrno=<%=objNcr.getNCR_NO()%>"><%= objNcr.getATTACHMENT().trim()%></a>
                            <img src="images/delete.jpg" id="imageAttach" alt="Delete" style="cursor:pointer;" height="20" onClick="return deleteattachment('<%=objNcr.getATTACHMENT().trim()%>', '<%=objNcr.getNCR_NO()%>')" />
                            <% }%>
                        </td>
                    </tr>
                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>HOS_NAME </strong></font></td>
                        <td>
                            <input name="HOS_NAME" type="text" id="HOS_NAME" size="25" value="<%=objNcr.getHOS_NAME()%>" readonly /> 
                        </td>
                    </tr>

                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>HOS_STFNO </strong></font></td>
                        <td>
                            <input name="HOS_STFNO" type="text" id="HOS_STFNO" size="25" value="<%=objNcr.getHOS_STFNO()%>" readonly  />
                        </td>
                    </tr>
                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>HOS_ACTION  </strong></font></td>
                        <td>
                            <select name="HOS_ACTION" id="HOS_ACTION" >
                                <option value="">Please Select</option>
                                <option value="Acceptance" <%= objNcr.getHOS_ACTION() != null && objNcr.getHOS_ACTION().equalsIgnoreCase("Acceptance") ? "selected=selected" : "a"%> >Acceptance</option>
                                <option value="Rejection" <%= objNcr.getHOS_ACTION() != null && objNcr.getHOS_ACTION().equalsIgnoreCase("Rejection") ? "selected=selected" : "b"%> >Rejection</option>
                                <option value="To Be Discussed" <%= objNcr.getHOS_ACTION() != null && objNcr.getHOS_ACTION().equalsIgnoreCase("To Be Discussed") ? "selected=selected" : "c"%> >To Be Discussed</option>
                            </select>   
                        </td>
                    </tr>
                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>HOS_REMARKS </strong></font></td>
                        <td>
                            <textarea name="HOS_REMARKS" id="HOS_REMARKS" size="25" style="margin: 0px; width: 600px; height: 100px;" ><%=objNcr.getHOS_REMARKS()%> </textarea>   
                        </td>
                    </tr>
                    
                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>COLEAD_AUDITOR_REMARKS </strong></font></td>
                        <td>
                            <textarea name="COLEAD_AUDITOR_REMARKS" id="COLEAD_AUDITOR_REMARKS" size="25" style="margin: 0px; width: 600px; height: 100px;" ><%=objNcr.getCOLEAD_AUDITOR_REMARKS()%> </textarea>   
                        </td>
                    </tr>
                    <tr bgcolor="#AED6F1">
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>NCR_CLS_CONF</strong></font></td>
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
                        <td ><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>AUDITOR_REV_DATE</strong></font></td>

                        <td  ><input name="AUDITOR_REV_DT" type="text" id="AUDITOR_REV_DT" size="25" value="<%= objNcr.getAUDITOR_REV_DT() != null ? objNcr.getAUDITOR_REV_DT() : ""%>"readonly >
                            <a href="javascript:NewCal('AUDITOR_REV_DT','ddmmmyyyy')" id="A_AUDITOR_REV_DT">
                                <img src="images/calendar.jpg" width="20" height="20" border="0" alt="Pick a date" style="vertical-align: bottom;"/></a>
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
                            <textarea name="ISO_COORD_REMARKS" id="ISO_COORD_REMARKS" size="25" style="margin: 0px; width: 600px; height: 100px;" readonly><%=objNcr.getISO_COORD_REMARKS() != null ? objNcr.getISO_COORD_REMARKS() : ""%> </textarea>  
                        </td>
                    </tr>





                    <tr bgcolor="#AED6F1">
                        <td ><font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>NCR_CLS_CONF_DATE</strong></font></td>

                        <td  ><input name="NCR_CLS_CONF_DT" type="text" id="NCR_CLS_CONF_DT" size="25" value="<%= objNcr.getNCR_CLS_CONF_DT() != null ? objNcr.getNCR_CLS_CONF_DT() : ""%>"readonly />
                            <a href="javascript:NewCal('NCR_CLS_CONF_DT','ddmmmyyyy')"id="A_NCR_CLS_CONF_DT" />
                            <img src="images/calendar.jpg" width="20" height="20" border="0" alt="Pick a date" style="vertical-align: bottom;"/></a>
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

                        <td >&nbsp;</td>
                        <td>
                            <input type="hidden" name="AUDITOR_AUDITEE_COORD" value="<%=AUDITOR_AUDITEE_COORD%>" id="AUDITOR_AUDITEE_COORD"/>
                            <% if (objNcr.getAUDITOR_ACTION() == null || !objNcr.getAUDITOR_ACTION().equalsIgnoreCase("Accepted")) { %>
                            <input  type = "submit" value = "UPDATE" name = "B1" onClick = "return validlogin()" style = "font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px; color: #FF0000" / >
                                    <% }%>
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
                            <td width="20%" rowspan="3">
                                <img src="images/BHEL logo.jpg">
                            </td>
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
                            <td><%=objNcr.getNCR_NO()%></td>
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
                            <td style= "height: 90px" colspan="2"><strong>REVIEW OF CORRECTIVE ACTION:</strong><%=objNcr.getNCR_CLS_CONF()%><br><br><strong>AUDITOR_REMARKS:</strong><br><br><%=objNcr.getAUDITOR_REMARKS()%><br><br><br><strong>DATE:  </strong><%=objNcr.getAUDITOR_REV_DT()%> AUDITOR</td>
                            <td style= "height: 90px" colspan="2"><strong>NCR CLOSED:</strong><%=objNcr.getAUDITOR_ACTION()%><br><br><strong>ISO_COORD_REMARKS:</strong><br><br><%=objNcr.getISO_COORD_REMARKS()%><br><br><br><br><br><br><br><br><strong>DATE:</strong>  <%=objNcr.getNCR_CLS_CONF_DT()%>   Head Quality</td>
                        </tr>
                    </table> 
            </div> 
        </form>
        <form>
            <div id="order2" style=" display:none;" >

                </head>

                <body>


                    <table class="mytable mytable-head" width="800">
                        <tr>
                            <td width="20%"rowspan="2">
                                <img src="images/BHEL logo.jpg">
                            </td>
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
                                <td style= "height: 350px" colspan="3"><%=objNcr.getAUDIT_OBSERVATION()%></td>
                            </tr>

                            <tr>
                                <td>DATE: <%=objNcr.getAUDIT_DATE()%></td>
                                <td style= "height: 40px"colspan="2">AUDITOR'S SIGN</td>
                            </tr>
                        </table>  
            </div>
        </form>
    </body>
</html>
<%} else {%>
<h1> Session Expired </h1>
<a href="logout.jsp">click here</a>
<%}%>


<script type="text/javascript"  LANGUAGE="JavaScript" src="js/datetimepicker.js"></script>
<script src="js/jquery-3.3.1.min.js" type="text/javascript"></script>
<script src="js/jquery-3.3.1.min.js" type="text/javascript"></script>
<script src="js/jquery-ui.js" type="text/javascript"></script>
<link href="jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="js/ncrHistory.js" type="text/javascript"></script>

<script type="text/javascript">
                                $(document).ready(function () {
                                    setPageAccess();
                                    initAutoComplete("<%=session.getAttribute("AUDITER_TYPE").toString()%>");
                                    inihostAutoComplete();
                                    inicoleadtAutoComplete();
                                    $("#AUDIT_AREA").change(function () {
                                        $('#AUDITEE_NAME_HIDDEN').val("");
                                        $('#AUDITEE_NAME').val("");
                                        $('#AUDITEE_STFNO').val();
                                    });
                                });

</script>
