<%-- 
    Document   : AuditUsers
    Created on : Oct 31, 2018, 5:54:25 PM
    Author     : pillive1
--%>

<%@page import="org.json.JSONObject"%>
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
        int ncrNo = Integer.parseInt(request.getParameter("ncrnor"));
        Connection conn = con.getcon();
        String qstring = "SELECT * FROM [dbo].[AUDIT_HISTORY] A INNER JOIN Audit_Login B ON A.USER_ID = B.STAFF_NO where NCR_NO = " + ncrNo + " order by MODIFIED_DATE";
        System.out.println("query " + qstring);
        Statement stmt = con.getSt();
        ResultSet rs = stmt.executeQuery(qstring);

        while (rs.next()) {
            mUser = new JSONObject();
            mUser.put("Id", rs.getInt("Id"));
            mUser.put("UserName", rs.getString("UserName"));
            mUser.put("FIELD_NAME", rs.getString("FIELD_NAME"));
            mUser.put("FIELD_OLD_VALUE", rs.getString("FIELD_OLD_VALUE"));
            mUser.put("FIELD_NEW_VALUE", rs.getString("FIELD_NEW_VALUE"));
            mUser.put("MODIFIED_DATE", rs.getTimestamp("MODIFIED_DATE"));
            arrayObj.put(mUser);
        }
        out.println(arrayObj);
    } catch (Exception e) {
        System.out.println("Exception " + e.toString());%>
<jsp:forward page="errorpage.jsp"></jsp:forward>
<%}

%>