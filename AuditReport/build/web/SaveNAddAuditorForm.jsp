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
        
        int maxFileSize = 50000 * 1024;
        int maxMemSize = 50000 * 1024;
        //String filePath = "F:/NetBeansProjects/Test1/src/java/Documents/";
        String contentType = request.getContentType();
        String isEmailChecked = "";
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

                } 
                else if (name1.equalsIgnoreCase("AUDITOR_REMARKS")) {
                    objNcr.setAUDITOR_REMARKS(value);
                }else if (name1.equalsIgnoreCase("AUDIT_OBSERVATION")) {
                    objNcr.setAUDIT_OBSERVATION(value);
                } else if (name1.equalsIgnoreCase("NCR_TYPE")) {
                    objNcr.setNCR_TYPE(value);
                } else if (name1.equalsIgnoreCase("NCR_DETAILS")) {
                    objNcr.setNCR_DETAILS(value);
                } else if (name1.equalsIgnoreCase("NCR_PLAN_CLS_DATE")) {
                    objNcr.setNCR_PLAN_CLS_DATE(value);
                } else if (name1.equalsIgnoreCase("ISO_CLAUSE")) {
                    objNcr.setISO_CLAUSE(value);
                } else if (name1.equalsIgnoreCase("DOC_REF")) {
                    objNcr.setDOC_REF(value);
                } else if (name1.equalsIgnoreCase("EMAIL")) {
                    objNcr.setEMAIL(value);
                } else if (name1.equalsIgnoreCase("chkEmail")) {
                    isEmailChecked = value;
                }
            }
        }

        try {

            if (session.getAttribute("refresh") != null && session.getAttribute("refresh").toString() == "false") {

                Connection conn = con.getcon();
                Statement stmt = con.getSt();
                CallableStatement cstmt = null;
                cstmt = conn.prepareCall("{call usp_10_Insert_AUDIT_INT_EXT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
                cstmt.setString(1, objNcr.getSTAFF_NO());
                cstmt.setString(2, objNcr.getFY_YEAR());
                cstmt.setString(3, objNcr.getAUDIT_DATE());
                cstmt.setString(4, objNcr.getAUDIT_AREA());
                cstmt.setString(5, objNcr.getAUDITEE_NAME());
                cstmt.setString(6, objNcr.getAUDITEE_STFNO());
                cstmt.setString(7, objNcr.getAUDITOR_STFNO());
                cstmt.setString(8, objNcr.getAUDITOR_INT_NAME());
                cstmt.setString(9, objNcr.getAUDITOR_EXT_NAME());
                cstmt.setString(10, objNcr.getAUDIT_OBSERVATION());
                cstmt.setString(11, objNcr.getNCR_TYPE());
                cstmt.setString(12, objNcr.getNCR_DETAILS());
                cstmt.setString(13, objNcr.getNCR_PLAN_CLS_DATE());
                cstmt.setString(14, objNcr.getISO_CLAUSE());
                cstmt.setString(15, objNcr.getDOC_REF());
                cstmt.setString(16, objNcr.getEMAIL());
                cstmt.setString(17, objNcr.getAUDITOR_REMARKS());
                cstmt.registerOutParameter(18, Types.INTEGER);
                cstmt.executeUpdate();
                NCR_NO = cstmt.getString(18);
                cstmt.close();
                objNcr.setNCR_No(NCR_NO);
                session.setAttribute("refresh", "true");
            }
    %>

    <body>
        <p><b><font color="#008000" size="5"> NCR Created Successfully </font></b></p>
       

        <%

            con.Conclose();
            session.setAttribute("ncrobj", objNcr);
            response.sendRedirect("auditorform.jsp");

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