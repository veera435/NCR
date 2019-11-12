<%--
    Document   : saveDetails
    Created on : Sep 5, 2018, 8:20:58 AM
    Author     : 6146252
--%>

<%@page import="Audit.AditeeEmail"%>
<%@page import="Audit.AuditInfo"%>
<%@page import="Audit.NcrAudit"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>

<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page language="java" import="java.sql.*,java.io.*" import="java.sql.*" import="java.lang.*" import="java.util.Date" %>


<jsp:useBean class="db.dbcon" id="con" scope="page"> </jsp:useBean>

    <HTML> 
        <title>----- REPORTS</title>

    <%
        String STAFF_NO = session.getAttribute("STAFF_NO").toString();
        String NCR_NO = "-";
        String fileName = new String("");
        String name1;
        String value;

    %>
    <% if (session.getAttribute("sessionID") == session.getId()) {
            System.out.println("session.getId()");
    %>
    <%
        String path = application.getRealPath("/");
        if (path.contains(
                "\\")) {
            path = path.replace("\\", "/");
        }
        File file;
        int maxFileSize = 50000 * 1024;
        int maxMemSize = 50000 * 1024;
        System.out.println("1");
        //String filePath = "F:/NetBeansProjects/Test1/src/java/Documents/";
        String contentType = request.getContentType();
        NcrAudit objNcr = new NcrAudit();
        objNcr.setSTAFF_NO(STAFF_NO);
        if ((contentType.indexOf("multipart/form-data") >= 0)) {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setSizeThreshold(maxMemSize);
            factory.setRepository(new File(path + "/files/"));
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setSizeMax(maxFileSize);
            List fileItems = upload.parseRequest(request);
            Iterator ii = fileItems.iterator();

            while (ii.hasNext()) {
                FileItem fi = (FileItem) ii.next();

                name1 = fi.getFieldName();
                value = fi.getString();

                if (name1.equalsIgnoreCase("NCR_NO")) {
                    NCR_NO = value;
                    objNcr.setNCR_No(value);
                } else if (name1.equalsIgnoreCase("FY_YEAR")) {
                    objNcr.setFY_YEAR(value);
                } else if (name1.equalsIgnoreCase("AUDIT_DATE")) {
                    objNcr.setAUDIT_DATE(value);
                } else if (name1.equalsIgnoreCase("AUDIT_AREA")) {
                    objNcr.setAUDIT_AREA(value);
                } else if (name1.equalsIgnoreCase("AUDITEE_NAME")) {
                    objNcr.setAUDITEE_NAME(value);
                } else if (name1.equalsIgnoreCase("AUDITEE_STFNO")) {
                    objNcr.setAUDITEE_STFNO(value);
                } else if (name1.equalsIgnoreCase("AUDITOR_STFNO")) {
                    objNcr.setAUDITOR_STFNO(value);
                } else if (name1.equalsIgnoreCase("AUDITOR_INT_NAME")) {
                    objNcr.setAUDITOR_INT_NAME(value);
                } else if (name1.equalsIgnoreCase("AUDITOR_EXT_NAME")) {
                    objNcr.setAUDITOR_EXT_NAME(value);

                } else if (name1.equalsIgnoreCase("AUDIT_OBSERVATION")) {
                    objNcr.setAUDIT_OBSERVATION(value);
                } else if (name1.equalsIgnoreCase("NCR_TYPE")) {
                    objNcr.setNCR_TYPE(value);
                } else if (name1.equalsIgnoreCase("NCR_DETAILS")) {
                    objNcr.setNCR_DETAILS(value);
                } else if (name1.equalsIgnoreCase("NCR_PLAN_CLS_DATE")) {
                    objNcr.setNCR_PLAN_CLS_DATE(value);
                }
            }
        }

        try {

            if (session.getAttribute("refresh") != null && session.getAttribute("refresh").toString() == "false") {

                Connection conn = con.getcon();
                Statement stmt = con.getSt();
                CallableStatement cstmt = null;
                cstmt = conn.prepareCall("{call usp_30_UPDATE_AUDIT_INT_EXT(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
                cstmt.setString(1, NCR_NO);
                cstmt.setString(2, objNcr.getSTAFF_NO());
                cstmt.setString(3, objNcr.getFY_YEAR());
                cstmt.setString(4, objNcr.getAUDIT_DATE());
                cstmt.setString(5, objNcr.getAUDIT_AREA());
                cstmt.setString(6, objNcr.getAUDITEE_NAME());
                cstmt.setString(7, objNcr.getAUDITEE_STFNO());
                cstmt.setString(8, objNcr.getAUDITOR_STFNO());
                cstmt.setString(9, objNcr.getAUDITOR_INT_NAME());
                cstmt.setString(10, objNcr.getAUDITOR_EXT_NAME());
                cstmt.setString(11, objNcr.getAUDIT_OBSERVATION());
                cstmt.setString(12, objNcr.getNCR_TYPE());
                cstmt.setString(13, objNcr.getNCR_DETAILS());
                cstmt.setString(14, objNcr.getNCR_PLAN_CLS_DATE());
                cstmt.executeUpdate();
                cstmt.close();
                session.setAttribute("refresh", "true");
            }
    %>

    <bod>
        <p><b><font color="#008000" size="5"> NCR Created Successfully </font></b></p>
        <form id="subForm" name="subForm" method="post" >
            <p>
                <b>
                    <font color="#008000" size="5">
                    <INPUT TYPE=BUTTON VALUE="HOME" ONCLICK="javascript:window.location = 'auditorform.jsp';" NAME="BUTTON">
                    </font>
                </b>

                <b>
                    <font color="#008000" size="5">
                    <INPUT TYPE=BUTTON VALUE="Edit" onclick="getDetails('<%=NCR_NO%>');" NAME="Edit">
                    </font>
                </b>
            </p>
        </form>

        <HR>

        <b>
            <font color="#800000" size="4">

            <table border="2" width=500>

                <tr>
                    <td width="50%"> NCR_NO</td>
                    <td width="50%"><%out.println(NCR_NO);%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">FY_YEAR</td>
                    <td width="50%"><%out.println(objNcr.getFY_YEAR());%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">AUDIT_DATE</td>
                    <td width="50%"><%out.println(objNcr.getAUDIT_DATE());%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">AUDIT_AREA</td>
                    <td width="50%"><%out.println(objNcr.getAUDIT_AREA());%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">AUDITEE_NAME</td>
                    <td width="50%"><%out.println(objNcr.getAUDITEE_NAME());%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">AUDITEE_STFNO</td>
                    <td width="50%"><%out.println(objNcr.getAUDITEE_STFNO());%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">AUDITOR_STFNO</td>
                    <td width="50%"><%out.println(objNcr.getAUDITOR_STFNO());%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">AUDITOR_INT_NAME</td>
                    <td width="50%"><%out.println(objNcr.getAUDITOR_INT_NAME());%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">AUDITOR_EXT_NAME</td>
                    <td width="50%"><%out.println(objNcr.getAUDITOR_EXT_NAME() != null ? objNcr.getAUDITOR_EXT_NAME() : "");%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">AUDIT_OBSERVATION</td>
                    <td width="50%"><%out.println(objNcr.getAUDIT_OBSERVATION());    %>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">NCR_TYPE</td>
                    <td width="50%"><%out.println(objNcr.getNCR_TYPE());    %>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">NCR_DETAILS</td>
                    <td width="50%"><%out.println(objNcr.getNCR_DETAILS());    %>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">NCR_PLAN_CLS_DATE</td>
                    <td width="50%"><%out.println(objNcr.getNCR_PLAN_CLS_DATE());    %>&nbsp;</td>
                </tr>
            </table>
            </font>
        </b>

        <%

            con.Conclose();

        } catch (Exception e2) {

            System.out.println("Excpetion is " + e2.toString());
        %>
        <jsp:forward page="errorpage.jsp"></jsp:forward>

        <%  }

        %>
        <%} else {%>
        <h1> Session Expired </h1>
        <a href="logout.jsp">click here</a>
        <%}%>
    </body>
</HTML>

<script type="text/javascript">
    function getDetails(ncr_no)
    {
        document.subForm.action = "auditoreditform.jsp?ncr_no=" + ncr_no;
        document.subForm.submit();
    }
</script>