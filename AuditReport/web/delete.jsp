<%-- 
    Document   : download
    Created on : Oct 26, 2018, 5:10:47 PM
    Author     : pillive1
--%>

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
<%
    String filename = request.getParameter("fn").toString();
    String ncr_no = request.getParameter("ncrno").toString();
    String filepath = "/Users/pillive1/Documents/AuditReport/build/web/files/";
    File f = new File(filepath + filename);
    f.delete();

    Connection conn = con.getcon();
    String qstring = "UPDATE AUDIT_INT_EXT SET ATTACHMENT = '' where NCR_NO = " + ncr_no;
    Statement stmt = con.getSt();
    stmt.execute(qstring);
    out.println(true);
%> 
