<%-- 
    Document   : download
    Created on : Oct 26, 2018, 5:10:47 PM
    Author     : pillive1
--%>

<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="javax.servlet.*"%>
<%@ page import="java.util.Date"%>

<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<jsp:useBean class="db.dbcon" id="con" scope="page"> </jsp:useBean>
<%
    System.out.println(".......filedownload");
    System.out.println(request.getParameter("filename"));
    String filename = request.getParameter("filename").toString();
    String ncrno = request.getParameter("ncrno").toString();
    String filenumber = request.getParameter("filenumber").toString();
    String fy_year = request.getParameter("fyyear").toString();
    if (ncrno != "") {
        //filename = ncrno + "_"+ filename; 
        String filepath = "/Users/pillive1/Documents/AuditReport/build/web/files/";
        response.setContentType("APPLICATION/OCTET-STREAM");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
        filename = ncrno + "_" + filename;
        java.io.FileInputStream fileInputStream = new java.io.FileInputStream(filepath + filename);

        int i;
        while ((i = fileInputStream.read()) != -1) {
            out.write(i);
        }
        fileInputStream.close();
    } else {
        Connection conn = con.getcon();
        CallableStatement statement = null;
        String qstring = "SELECT INT_SCH_1_FileName, INT_SCH_2_FileName, INT_SCH_3_FileName, INT_SCH_4_FileName FROM [dbo].[Schedule] where FY_YEAR = '" + fy_year + "'";
        //statement = conn.prepareStatement(qstring);
        //statement.setInt(1, uploadId);
    }
%> 
