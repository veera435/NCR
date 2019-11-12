<%--
    Document   : tr4
    Created on : 5 Aug, 2017, 2:25:13 PM
    Author     : 6157637
--%>

<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page language="java" import="java.sql.*,java.io.*" import="java.sql.*" import="java.lang.*" import="java.util.Date" %>


<jsp:useBean class="db.dbcon" id="con" scope="page"> </jsp:useBean>

    <HTML> <body bgcolor="#FFF4EA">

            <title>TOUR REPORTS</title>
        <%! String sessionID;
            String STNO = "-";
            String NAME = "-";
            String FROMDT = "-";
            String TODT = "-";
            String COFFICER = "-";
            String COFFICERNAME = "-";
            String ADR = "-";
            String fieldName = new String("");
            String fileName = new String("");
            String ftype = new String("");
            String att_type = "";
            String name1;
            String value;
                                                                                %>
        <% if (session.getAttribute("sessionID") == session.getId()) {
                System.out.println("tr4");
        %>
        <%            int count = 0;
            String attachment, extension;
            String type, item, machine_no, refno = "";
            int islno;
            String dt, ndate;
            ResultSet rset;
            ResultSet rset1;
            Statement st;
            Statement st1;
            String[] cval;
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
            ServletContext context = pageContext.getServletContext();
            String contentType = request.getContentType();
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
                    if (!fi.isFormField()) {
                        fieldName = fi.getFieldName();
                        fileName = fi.getName();
                        if (fileName.contains("\\")) {
                            fileName = fileName.replace("\\", "/");
                        }
                        if (fileName.contains("/")) {
                            fileName = fileName.substring(fileName.lastIndexOf("/") + 1);
                        }
                        try {
                            if (!fileName.isEmpty()) {
                                ftype = fileName.substring(fileName.lastIndexOf("."));
                                PreparedStatement ps2 = null;
                                String qry1 = "";
                                String qry2 = "";
                                att_type = fieldName.substring(0, 1).toUpperCase(); //Issue or Resolution
                                // inserting into attachment table
                                dt = "insert into pesd_tr (stno,name,fromdt,todt,cofficer,cofficername,adr) values ('" + STNO + "','" + NAME + "','" + FROMDT + "','" + TODT + "','" + COFFICER + "','" + COFFICERNAME + "', '" + fileName + "' )";
                                Connection conn = con.getcon();
                                Statement stmt = con.getSt();
                                System.out.println(dt);
                                int i = stmt.executeUpdate(dt);

                            }
                        } catch (Exception e) {
                            out.println(e.toString());
                            return;
                        }
                        if (!fileName.isEmpty()) {
                            file = new File(path + "/files/" + fileName);
                            try {
                                fileItem.write(file);
                            } catch (Exception ex) {
                                System.out.println(ex.toString());
                            }

                        }
                        boolean isInMemory = fi.isInMemory();
                        long sizeInBytes = fi.getSize();
                    } else {
                        name1 = fi.getFieldName();
                        value = fi.getString();
                        if (name1.equalsIgnoreCase("STNO")) {
                            STNO = value;
                        }
                        if (name1.equalsIgnoreCase("NAME")) {
                            NAME = value;
                        }
                        if (name1.equalsIgnoreCase("FROMDT")) {
                            FROMDT = value;
                        }
                        if (name1.equalsIgnoreCase("TODT")) {
                            TODT = value;
                        }
                        if (name1.equalsIgnoreCase("COFFICER")) {
                            COFFICER = value;
                        }
                        if (name1.equalsIgnoreCase("COFFICERNAME")) {
                            COFFICERNAME = value;
                        }
                        if (name1.equalsIgnoreCase("ADR")) {
                            ADR = value;
                        }

                    }
                }
            }
            System.out.println("2");
            /* STNO = request.getParameter("STNO");
             NAME = request.getParameter("NAME");
             FROMDT = request.getParameter("FROMDT");
             TODT = request.getParameter("TODT");
             COFFICER = request.getParameter("COFFICER");
             COFFICERNAME = request.getParameter("COFFICERNAME");
             ADR = request.getParameter("ADR");*/
            try {

                Connection conn = con.getcon();
                Statement stmt = con.getSt();

//                dt = "insert into pesd_tr (stno,name,fromdt,todt,cofficer,cofficername,adr) values ('" + STNO + "','" + NAME + "','" + FROMDT + "','" + TODT + "','" + COFFICER + "','" + COFFICERNAME + "', '" + ADR + "' )";
//                System.out.println(dt);
//                int i = stmt.executeUpdate(dt);
        %>


        <p><b><font color="#008000" size="5">TOUR REPORT ADDED...........</font></b></p>

        <p><b><font color="#008000" size="5"><INPUT TYPE=BUTTON VALUE="HOME" ONCLICK="javascript:window.location = 'tr1.jsp';" NAME="BUTTON"></font></b></p>

        <HR>

        <b>

            <font color="#800000" size="4">



            <table border="2" width=500>

                <tr>

                    <td width="50%">Staff Number</td>

                    <td width="50%"><%out.println(STNO);    %>&nbsp;</td>

                </tr>

                <tr>

                    <td width="50%">Name</td>

                    <td width="50%"><%out.println(NAME);  %>&nbsp;</td>

                </tr>

                <tr>

                    <td width="50%">From Date</td>

                    <td width="50%"><%out.println(FROMDT);    %>&nbsp;</td>

                </tr>

                <tr>

                    <td width="50%">To Date</td>

                    <td width="50%"><%out.println(TODT);    %>&nbsp;</td>

                </tr>

                <tr>

                    <td width="50%">Co.Officer</td>

                    <td width="50%"><%out.println(COFFICER); %>&nbsp;</td>

                </tr>

                <tr>

                    <td width="50%">Co.Officer Name</td>

                    <td width="50%"><%out.println(COFFICERNAME); %>&nbsp;</td>

                </tr>

                <tr>

                    <td width="50%">File Name</td>

                    <td width="50%"><%out.println(fileName); %>&nbsp;</td>

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
    </BODY>

</HTML>









