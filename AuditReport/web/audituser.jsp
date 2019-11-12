<%-- 
    Document   : AuditUsers
    Created on : Oct 31, 2018, 5:54:25 PM
    Author     : pillive1
--%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="org.json.JSONArray"%>

<%@page import = "java.sql.*,org.json.JSONArray,org.json.JSONObject,org.json.JSONException,java.util.*" %>

<jsp:useBean class="db.dbcon" id="con" scope="page"> </jsp:useBean>


<%
    JSONArray arrayObj = new JSONArray();
    JSONObject mUser = new JSONObject();

    try {
        String query = (String) request.getParameter("name");
        int auditVal = Integer.parseInt(request.getParameter("val"));
        Connection conn = con.getcon();
        String qstring = " select * from Audit_Login where UserName like '%" + query + "%' AND Auditor_Id = " + auditVal;
        System.out.println("query " + qstring);
        Statement stmt = con.getSt();
        ResultSet rs = stmt.executeQuery(qstring);

        while (rs.next()) {
            mUser = new JSONObject();
            mUser.put("Id", rs.getInt("STAFF_NO"));
            mUser.put("label", rs.getString("UserName"));
            arrayObj.put(mUser);
        }
        out.println(arrayObj);
    } catch (Exception e) {
        System.out.println("Exception " + e.toString());%>
<jsp:forward page="errorpage.jsp"></jsp:forward>
<%}

%>