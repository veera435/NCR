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
        String AUDITOR_AUDITEE_COORD = session.getAttribute("AUDITOR_AUDITEE_COORD").toString();
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
        FileItem fileItem = null;
        int maxFileSize = 50000 * 1024;
        int maxMemSize = 50000 * 1024;
        System.out.println("1");
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
                fileItem = fi;
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
                } else if (name1.equalsIgnoreCase("ISO_CLAUSE")) {
                    objNcr.setISO_CLAUSE(value);
                } else if (name1.equalsIgnoreCase("DOC_REF")) {
                    objNcr.setDOC_REF(value);
                } else if (name1.equalsIgnoreCase("EMAIL")) {
                    objNcr.setEMAIL(value);
                } else if (name1.equalsIgnoreCase("chkEmail")) {
                    isEmailChecked = value;
                } else if (name1.equalsIgnoreCase("NCR_ACTUAL_CLS_DATE")) {
                    objNcr.setNCR_ACTUAL_CLS_DATE(value);
                } else if (name1.equalsIgnoreCase("AUDITOR_ACTION")) {
                    objNcr.setAUDITOR_ACTION(value);
                } else if (name1.equalsIgnoreCase("ISO_COORD_REMARKS")) {
                    objNcr.setISO_COORD_REMARKS(value);
                } else if (name1.equalsIgnoreCase("AUDITEE_REMARKS_CLS")) {
                    objNcr.setAUDITEE_REMARKS_CLS(value);
                } else if (name1.equalsIgnoreCase("CORRECTION")) {
                    objNcr.setCORRECTION(value);
                } else if (name1.equalsIgnoreCase("CORR_DT")) {
                    objNcr.setCORR_DT(value);
                } else if (name1.equalsIgnoreCase("CORRECTION_NAME")) {
                    objNcr.setCORRECTION_NAME(value);
                } else if (name1.equalsIgnoreCase("RCA")) {
                    objNcr.setRCA(value);
                } else if (name1.equalsIgnoreCase("RCA_DT")) {
                    objNcr.setRCA_DT(value);
                } else if (name1.equalsIgnoreCase("RCA_NAME")) {
                    objNcr.setRCA_NAME(value);
                } else if (name1.equalsIgnoreCase("CORR_ACTION")) {
                    objNcr.setCORR_ACTION(value);
                } else if (name1.equalsIgnoreCase("CORR_ACTION_DT")) {
                    objNcr.setCORR_ACTION_DT(value);
                } else if (name1.equalsIgnoreCase("CORR_ACTION_NAME")) {
                    objNcr.setCORR_ACTION_NAME(value);
                } else if (name1.equalsIgnoreCase("AUDITOR_REV_DT")) {
                    objNcr.setAUDITOR_REV_DT(value);
                } else if (name1.equalsIgnoreCase("ATTACHMENT")) {
                    objNcr.setATTACHMENT(fi.getName());
                    fileName = fi.getName();
                    if (fileName.contains("\\")) {
                        fileName = fileName.replace("\\", "/");
                    }
                    if (fileName.contains("/")) {
                        fileName = fileName.substring(fileName.lastIndexOf("/") + 1);
                    }
                } else if (name1.equalsIgnoreCase("NCR_CLS_CONF")) {
                    objNcr.setNCR_CLS_CONF(value);
                } else if (name1.equalsIgnoreCase("NCR_CLS_CONF_DT")) {
                    objNcr.setNCR_CLS_CONF_DT(value);
                } else if (name1.equalsIgnoreCase("AUDITOR_REMARKS")) {
                    objNcr.setAUDITOR_REMARKS(value);
                }else if (name1.equalsIgnoreCase("HOS_ACTION")) {
                    objNcr.setHOS_ACTION(value);
                }else if (name1.equalsIgnoreCase("HOS_REMARKS")) {
                    objNcr.setHOS_REMARKS(value);
                }else if (name1.equalsIgnoreCase("COLEAD_AUDITOR_ACTION")) {
                    objNcr.setCOLEAD_AUDITOR_ACTION(value);
                }else if (name1.equalsIgnoreCase("COLEAD_AUDITOR_REMARKS")) {
                    objNcr.setCOLEAD_AUDITOR_REMARKS(value);
                }else if (name1.equalsIgnoreCase("HOS_NAME")) {
                    objNcr.setHOS_NAME(value);
                } else if (name1.equalsIgnoreCase("HOS_STFNO")) {
                    objNcr.setHOS_STFNO(value);
                }else if (name1.equalsIgnoreCase("COLEAD_NAME")) {
                    objNcr.setCOLEAD_NAME(value);
                } else if (name1.equalsIgnoreCase("COLEAD_STFNO")) {
                    objNcr.setCOLEAD_STFNO(value);
                }
                
            }
        }

        try {

            if (session.getAttribute("refresh") != null && session.getAttribute("refresh").toString() == "false") {

                Connection conn = con.getcon();
                Statement stmt = con.getSt();
                CallableStatement cstmt = null;
                int i = 0;

                if (NCR_NO.isEmpty() != true && Integer.parseInt(NCR_NO) > 0) {
                    cstmt = conn.prepareCall("{call usp_20_Update_AUDIT_INT_EXT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
                    cstmt.setInt(1, Integer.parseInt(NCR_NO));
                    cstmt.setInt(2, Integer.parseInt(STAFF_NO));
                    cstmt.setString(3, objNcr.getISO_CLAUSE());
                    cstmt.setString(4, objNcr.getDOC_REF());
                    cstmt.setString(5, objNcr.getEMAIL());
                    cstmt.setString(6, objNcr.getNCR_ACTUAL_CLS_DATE());
                    cstmt.setString(7, objNcr.getAUDITOR_ACTION());
                    cstmt.setString(8, objNcr.getISO_COORD_REMARKS());
                    cstmt.setString(9, objNcr.getAUDITEE_REMARKS_CLS());
                    cstmt.setString(10, objNcr.getCORRECTION());
                    cstmt.setString(11, objNcr.getCORR_DT());
                    cstmt.setString(12, objNcr.getCORRECTION_NAME());
                    cstmt.setString(13, objNcr.getRCA());
                    cstmt.setString(14, objNcr.getRCA_DT());
                    cstmt.setString(15, objNcr.getRCA_NAME());
                    cstmt.setString(16, objNcr.getCORR_ACTION());
                    cstmt.setString(17, objNcr.getCORR_ACTION_DT());
                    cstmt.setString(18, objNcr.getCORR_ACTION_NAME());
                    cstmt.setString(19, objNcr.getAUDITOR_REV_DT());
                    cstmt.setString(20, objNcr.getATTACHMENT());
                    cstmt.setString(21, objNcr.getNCR_CLS_CONF());
                    cstmt.setString(22, objNcr.getNCR_CLS_CONF_DT());
                    cstmt.setString(23, objNcr.getAUDIT_OBSERVATION());
                    cstmt.setString(24, objNcr.getFY_YEAR());
                    cstmt.setString(25, objNcr.getAUDIT_DATE());
                    cstmt.setString(26, objNcr.getAUDIT_AREA());
                    cstmt.setString(27, objNcr.getAUDITEE_NAME());
                    cstmt.setString(28, objNcr.getAUDITEE_STFNO());

                    cstmt.setString(29, objNcr.getAUDITOR_EXT_NAME());
                    cstmt.setString(30, objNcr.getNCR_TYPE());
                    cstmt.setString(31, objNcr.getNCR_DETAILS());
                    cstmt.setString(32, objNcr.getNCR_PLAN_CLS_DATE());
                    cstmt.setString(33, objNcr.getAUDITOR_REMARKS());
                    cstmt.setString(34, objNcr.getHOS_ACTION());
                    cstmt.setString(35, objNcr.getHOS_REMARKS());
                    cstmt.setString(36, objNcr.getCOLEAD_AUDITOR_ACTION());
                    cstmt.setString(37, objNcr.getCOLEAD_AUDITOR_REMARKS());
                    cstmt.setString(38, objNcr.getHOS_NAME());
                    cstmt.setString(39, objNcr.getHOS_STFNO());
                    cstmt.setString(40, objNcr.getCOLEAD_NAME());
                    cstmt.setString(41, objNcr.getCOLEAD_STFNO());

                    cstmt.executeUpdate();
                    cstmt.close();
                    if (!fileName.isEmpty()) {

                        file = new File(path + "/files/" + NCR_NO + "_" + fileName);
                        try {
                            fileItem.write(file);
                        } catch (Exception ex) {
                            System.out.println(ex.toString());
                        }
                    }
                } else {
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
                    System.out.println("PRINT I VALUE :" + NCR_NO);
                    
                }

                session.setAttribute("refresh", "true");
                //AditeeEmail objAditeeEmail = new AditeeEmail();
                // if (isEmailChecked.isEmpty() == false) {
                //  objAditeeEmail.SendEmail1(objNcr.getEMAIL(), NCR_NO, NCR_NO);
                // }
            }
    %>

    <body>
        <p><b><font color="#008000" size="5"> NCR Created Successfully </font></b></p>
        <form id="subForm" name="subForm" method="post" >
            <p>
                <font color="#008000" size="5"  <%= AUDITOR_AUDITEE_COORD.equalsIgnoreCase("0") ? "" : "style=display:none;"%>>
                <INPUT TYPE=BUTTON VALUE="HOME" ONCLICK="javascript:window.location = 'auditorform.jsp';" NAME="BUTTON" />
                </font>
                <font color="#008000" size="5">
                <INPUT TYPE=BUTTON VALUE="Edit" onclick="getDetails('<%=NCR_NO%>');" NAME="Edit">
                </font>
                <font color="#008000" size="5">
                <input type="submit" name="Submit" onclick="getNcrList();" value="My NCR List" style="width: 100px; height: 25px;  font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px;"  />
                </font>
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
                    <td width="50%"><%out.println(objNcr.getFY_YEAR() != null ? objNcr.getFY_YEAR() : "");%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">AUDIT_DATE</td>
                    <td width="50%"><%out.println(objNcr.getAUDIT_DATE() != null ? objNcr.getAUDIT_DATE() : "");%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">AUDIT_AREA</td>
                    <td width="50%"><%out.println(objNcr.getAUDIT_AREA() != null ? objNcr.getAUDIT_AREA() : "");%>&nbsp;</td>
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
                    <td width="50%"><%out.println(objNcr.getNCR_PLAN_CLS_DATE() != null ? objNcr.getNCR_PLAN_CLS_DATE() : "");    %>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">ISO_CLAUSE</td>
                    <td width="50%"><%out.println(objNcr.getISO_CLAUSE() != null ? objNcr.getISO_CLAUSE() : "");%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">DOC_REF</td>
                    <td width="50%"><%out.println(objNcr.getDOC_REF() != null ? objNcr.getDOC_REF() : "");%>&nbsp;</td>
                </tr>
                <tr>
                    <td width="50%">NCR_CLS_CONF</td>
                    <td width="50%"><%out.println(objNcr.getNCR_CLS_CONF() != null ? objNcr.getNCR_CLS_CONF() : "");%>&nbsp;</td>
                </tr>
                <tr>
                    <td width="50%">AUDITOR_REV_DT</td>
                    <td width="50%"><%out.println(objNcr.getAUDITOR_REV_DT() != null ? objNcr.getAUDITOR_REV_DT() : "");%>&nbsp;</td>
                </tr>
                <tr>
                    <td width="50%">AUDITOR_REMARKS</td>
                    <td width="50%"><%out.println(objNcr.getAUDITOR_REMARKS() != null ? objNcr.getAUDITOR_REMARKS() : "");%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">EMAIL</td>
                    <td width="50%"><%out.println(objNcr.getEMAIL() != null ? objNcr.getEMAIL() : "");%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">NCR_ACTUAL_CLS_DATE</td>
                    <td width="50%"><%out.println(objNcr.getNCR_ACTUAL_CLS_DATE() != null ? objNcr.getNCR_ACTUAL_CLS_DATE() : "");%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">AUDITOR_ACTION</td>
                    <td width="50%"><%out.println(objNcr.getAUDITOR_ACTION() != null ? objNcr.getAUDITOR_ACTION() : "");%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">ISO_COORD_REMARKS</td>
                    <td width="50%"><%out.println(objNcr.getISO_COORD_REMARKS() != null ? objNcr.getISO_COORD_REMARKS() : "");%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">AUDITEE_REMARKS_CLS</td>
                    <td width="50%"><%out.println(objNcr.getAUDITEE_REMARKS_CLS() != null ? objNcr.getAUDITEE_REMARKS_CLS() : "");%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">CORRECTION</td>
                    <td width="50%"><%out.println(objNcr.getCORRECTION() != null ? objNcr.getCORRECTION() : "");%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">CORR_DT</td>
                    <td width="50%"><%out.println(objNcr.getCORR_DT() != null ? objNcr.getCORR_DT() : "");%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">CORRECTION_NAME</td>
                    <td width="50%"><%out.println(objNcr.getCORRECTION_NAME() != null ? objNcr.getCORRECTION_NAME() : "");%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">RCA</td>
                    <td width="50%"><%out.println(objNcr.getRCA() != null ? objNcr.getRCA() : "");%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">RCA_DT</td>
                    <td width="50%"><%out.println(objNcr.getRCA_DT() != null ? objNcr.getRCA_DT() : "");%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">RCA_NAME</td>
                    <td width="50%"><%out.println(objNcr.getRCA_NAME() != null ? objNcr.getRCA_NAME() : "");%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">CORR_ACTION</td>
                    <td width="50%"><%out.println(objNcr.getCORR_ACTION() != null ? objNcr.getCORR_ACTION() : "");%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">CORR_ACTION_DT</td>
                    <td width="50%"><%out.println(objNcr.getCORR_ACTION_DT() != null ? objNcr.getCORR_ACTION_DT() : "");%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">CORR_ACTION_NAME</td>
                    <td width="50%"><%out.println(objNcr.getCORR_ACTION_NAME() != null ? objNcr.getCORR_ACTION_NAME() : "");%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">ATTACHMENT</td>
                    <td width="50%"><%out.println(objNcr.getATTACHMENT() != null ? objNcr.getATTACHMENT() : ""); %>&nbsp;</td>
                </tr>
                <tr>
                    <td width="50%">HOS_NAME</td>
                    <td width="50%"><%out.println(objNcr.getHOS_NAME());%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">HOS_STFNO</td>
                    <td width="50%"><%out.println(objNcr.getHOS_STFNO());%>&nbsp;</td>
                </tr>
                <tr>
                    <td width="50%">HOS_ACTION</td>
                    <td width="50%"><%out.println(objNcr.getHOS_ACTION() != null ? objNcr.getHOS_ACTION() : "");%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">HOS_REMARKS</td>
                    <td width="50%"><%out.println(objNcr.getHOS_REMARKS()!= null ? objNcr.getHOS_REMARKS(): "");%>&nbsp;</td>
                </tr>
                <tr>
                    <td width="50%">COLEAD_NAME</td>
                    <td width="50%"><%out.println(objNcr.getCOLEAD_NAME());%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">COLEAD_STFNO</td>
                    <td width="50%"><%out.println(objNcr.getCOLEAD_STFNO());%>&nbsp;</td>
                </tr>
                <tr>
                    <td width="50%">COLEAD_AUDITOR_ACTION</td>
                    <td width="50%"><%out.println(objNcr.getCOLEAD_AUDITOR_ACTION() != null ? objNcr.getCOLEAD_AUDITOR_ACTION() : "");%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">COLEAD_AUDITOR_REMARKS</td>
                    <td width="50%"><%out.println(objNcr.getCOLEAD_AUDITOR_REMARKS()!= null ? objNcr.getCOLEAD_AUDITOR_REMARKS(): "");%>&nbsp;</td>
                </tr>

                <tr>
                    <td width="50%">NCR_CLS_CONF_DT</td>
                    <td width="50%"><%out.println(objNcr.getNCR_CLS_CONF_DT() != null ? objNcr.getNCR_CLS_CONF_DT() : "");%>&nbsp;</td>
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
        document.subForm.action = "NcrEdit.jsp?ncr_no=" + ncr_no;
        document.subForm.submit();
    }
    function getNcrList()
    {
        document.subForm.action = "ncrlist.jsp";
        document.subForm.submit();
    }
</script>