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
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.io.InputStream"%>

<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.http.HttpServlet"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>

<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>

<jsp:useBean class="db.dbcon" id="con" scope="page"> </jsp:useBean>


<%
    String UserName = session.getAttribute("UserName").toString();
    String AUDITOR_AUDITEE_COORD = session.getAttribute("AUDITOR_AUDITEE_COORD").toString();
    String STAFF_NO = session.getAttribute("STAFF_NO").toString();
    String AACName = session.getAttribute("AACName").toString();
%>

<%
    String path = application.getRealPath("/");
    if (path.contains(
            "\\")) {
        path = path.replace("\\", "/");
    }
    File file;
    FileItem fileItem = null;
    int maxFileSize = 500000 * 1024;
    int maxMemSize = 1024 * 1024 * 50;
    System.out.println("1");
    //String filePath = "F:/NetBeansProjects/Test1/src/java/Documents/";
    String contentType = request.getContentType();
    String fy_year = "";
    String fileName1 = new String("");
    String fileName2 = new String("");
    String fileName3 = new String("");
    String fileName4 = new String("");
    InputStream inputStream1 = null;
    InputStream inputStream2 = null;
    InputStream inputStream3 = null;
    InputStream inputStream4 = null;
    String name1;
    String value;

    try {

        if ((contentType != null && contentType.indexOf("multipart/form-data") >= 0)) {

            Connection conn = con.getcon();
            CallableStatement statement = null;

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
                if (name1.equalsIgnoreCase("FY_YEAR")) {
                    fy_year = value;
                } else if (name1.equalsIgnoreCase("ATTACHMENT1")) {
                    fileName1 = fi.getName();
                    if (fileName1.contains("\\")) {
                        fileName1 = fileName1.replace("\\", "/");
                    }
                    if (fileName1.contains("/")) {
                        fileName1 = fileName1.substring(fileName1.lastIndexOf("/") + 1);
                    }
                    if (fileName1 != "") {
                        inputStream1 = fi.getInputStream();
                    }
                } else if (name1.equalsIgnoreCase("ATTACHMENT2")) {
                    fileName2 = fi.getName();
                    if (fileName2.contains("\\")) {
                        fileName2 = fileName2.replace("\\", "/");
                    }
                    if (fileName2.contains("/")) {
                        fileName2 = fileName2.substring(fileName2.lastIndexOf("/") + 1);
                    }
                    if (fileName2 != "") {
                        inputStream2 = fi.getInputStream();
                    }
                } else if (name1.equalsIgnoreCase("ATTACHMENT3")) {
                    fileName3 = fi.getName();
                    if (fileName3.contains("\\")) {
                        fileName3 = fileName1.replace("\\", "/");
                    }
                    if (fileName3.contains("/")) {
                        fileName3 = fileName3.substring(fileName3.lastIndexOf("/") + 1);
                    }
                    if (fileName3 != "") {
                        inputStream3 = fi.getInputStream();
                    }
                } else if (name1.equalsIgnoreCase("ATTACHMENT4")) {
                    fileName4 = fi.getName();
                    if (fileName4.contains("\\")) {
                        fileName4 = fileName4.replace("\\", "/");
                    }
                    if (fileName4.contains("/")) {
                        fileName4 = fileName4.substring(fileName4.lastIndexOf("/") + 1);
                    }
                    if (fileName4 != "") {
                        inputStream4 = fi.getInputStream();
                    }
                }
            }
            if (session.getAttribute("fileUpload") != null && session.getAttribute("fileUpload").toString() == "false") {
                if (fileName1 != "" || fileName2 != "" || fileName3 != "" || fileName4 != "") {
                    // constructs SQL statement
                    //String sql = "INSERT INTO Schedule(FY_YEAR, INT_SCH_1_FileName, INT_SCH_1_Image, INT_SCH_2_FileName, INT_SCH_2_Image, INT_SCH_3_FileName, INT_SCH_3_Image, INT_SCH_4_FileName, INT_SCH_4_Image) values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    statement = conn.prepareCall("{call usp_60_Insert_Schedule_Files(?,?,?,?,?,?,?,?,?)}");
                    //PreparedStatement statement = conn.prepareStatement(sql);

                    statement.setString(1, fy_year);

                    statement.setString(2, fileName1);
                    statement.setBlob(3, inputStream1);

                    statement.setString(4, fileName2);
                    statement.setBlob(5, inputStream2);

                    statement.setString(6, fileName3);
                    statement.setBlob(7, inputStream3);

                    statement.setString(8, fileName4);
                    statement.setBlob(9, inputStream4);

                    // sends the statement to the database server
                    int row = statement.executeUpdate();

                    if (row > 0) {

                        System.out.println("File uploaded and saved into database");

                    }
                    statement.close();
                }
                session.setAttribute("fileUpload", "true");
                {%>
                    <script>
                        alert("File upload successfully!");
                    </script>
                <%}
        }
    }

} catch (Exception e) {
    System.out.println("Exception " + e.toString());%>
<jsp:forward page="errorpage.jsp"></jsp:forward>
<%}%>


<html>
    <head>
        <title>View REPORTS</title>
        <script src="js/jquery-3.3.1.min.js" type="text/javascript"></script>
        <script src="js/ncrHistory.js" type="text/javascript"></script>

    </head>
    <body bgcolor="#EAF2F8">

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
        <h1>Upload Audit Schedules Docs </h1>
        <form method="post" action="UploadAuditSchedules.jsp" enctype="multipart/form-data" id="ncrupload">

            <table>
                <tr bgcolor="#AED6F1">
                    <td>
                        <font size="2" face="Verdana, Arial, Helvetica, sans-serif, Agency FB"><strong>FY_YEAR: </strong></font></td>
                    <td>
                        <select name="FY_YEAR" id="FY_YEAR" >
                            <option value="">Please Select</option>
                            <option value="2018-2019"  >2018-2019</option>
                            <option value="2019-2020"  >2019-2020</option>
                            <option value="2020-2021"  >2020-2021</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <br />
                    </td>
                </tr>
            </table>

            <table border="1" id="tbFile" style="display:none;">
                <tr>
                    <td>
                        Upload internal Audit Schedule  1  : 
                    </td>
                    <td>
                        <input type="file" id="file1" size="50" name="ATTACHMENT1"/> 
                        <a id="aFile1" href="download.jsp?filename="></a>
                        <img src="images/delete.jpg" id="imgFile1" alt="Delete" style="cursor:pointer;" height="20" onClick="return deleteFileupload('aFile1', '1')" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Upload internal Audit Schedule  2  : 
                    </td>
                    <td>
                        <input type="file" id="file2" size="50" name="ATTACHMENT2"/> 
                        <a id="aFile2" href="download.jsp?filename="></a>
                        <img src="images/delete.jpg" id="imgFile2" alt="Delete" style="cursor:pointer;" height="20" onClick="return deleteFileupload('aFile2', '2')" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Upload External Audit Schedule 1 : 
                    </td>
                    <td>
                        <input type="file" id="file3" size="50" name="ATTACHMENT3"/> 
                        <a id="aFile3" href="download.jsp?filename="></a>
                        <img src="images/delete.jpg" id="imgFile3" alt="Delete" style="cursor:pointer;" height="20" onClick="return deleteFileupload('aFile3', '3')" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Upload External Audit Schedule 2 : 
                    </td>
                    <td>
                        <input type="file" id="file4" size="50" name="ATTACHMENT4"/> 
                        <a id="aFile4" href="download.jsp?filename="></a>
                        <img src="images/delete.jpg" id="imgFile4" alt="Delete" style="cursor:pointer;" height="20" onClick="return deleteFileupload('aFile4', '4')" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <br />   <br />
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="submit" value="Upload" id="btnUpload" onclick="return validateForm();" style="width: 100px; height: 25px;  font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px;"/> 
                    </td>
                    <td>
                        <INPUT TYPE=BUTTON VALUE="Done" ONCLICK="document.location.href = 'ncrlist.jsp';" NAME="BUTTON" style="width: 100px; height: 25px;  font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px;">
                    </td>
                </tr>
            </table>

        </form>
    </body>

    <br/>
</div>
</body>                          
</HTML>


<script type="text/javascript">
    function validateForm()
    {
        if ($('#file1').val() === '' && $('#file2').val() === '' && $('#file3').val() === '' && $('#file4').val() === '')
        {
            alert('Select Files');
            return false;
        }


    }

    $(document).ready(function () {

        $("#FY_YEAR").change(function () {
            if ($("#FY_YEAR").val() !== "" && $("#FY_YEAR").val() !== "")
            {
                getImages($("#FY_YEAR").val());
            } else
            {
                $('#tbFile').hide();
                resetImageTable();
            }
        });
    });

</script>



