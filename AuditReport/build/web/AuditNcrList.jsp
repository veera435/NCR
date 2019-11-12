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
    JSONObject ncrObj = new JSONObject();

    try {
        String audit_area = request.getParameter("audit_area").toString();
        String staff_no = request.getParameter("staff_no").toString();
        String aac_no = request.getParameter("aac_no").toString();
        String fy_year = request.getParameter("fyyear").toString();

        String qstring = "SELECT A.NCR_NO, A.NCR_TYPE, ISNULL(A.NCR_CLS_CONF,''), ISNULL(A.AUDITOR_ACTION,''), A.AUDITOR_STAFF_NO, A.NCR_DETAILS, A.ISO_CLAUSE, B.Audit_Name FROM [dbo].[AUDIT_INT_EXT] A INNER JOIN  [dbo].[Audit_Area_Types] B ON A.AUDIT_AREA = B.Audit_ID";
        qstring = qstring + " WHERE FY_YEAR = '" + fy_year + "'";
        if (!aac_no.equalsIgnoreCase("2")) {
            qstring = qstring + " AND (STAFF_NO = " + staff_no + " OR AUDITEE_STAFF_NO = '" + staff_no + "'" + " OR HOS_STFNO = '" + staff_no + "'" + " OR COLEAD_STFNO = '" + staff_no + "')";
            if (!audit_area.equalsIgnoreCase("0")) {
                qstring = qstring + " AND AUDIT_AREA = " + audit_area + "";
            }
        }
        else
        {
            if (!audit_area.equalsIgnoreCase("0")) {
                qstring = qstring + " AND AUDIT_AREA = " + audit_area + "";
            }
        }

        qstring = qstring + " ORDER BY NCR_NO";

        System.out.println("query " + qstring);
        Statement stmt = con.getSt();
        ResultSet rs = stmt.executeQuery(qstring);

        while (rs.next()) {
            ncrObj = new JSONObject();
            ncrObj.put("NCRNO", rs.getString(1));
            ncrObj.put("NCR_TYPE", rs.getString(2));
            ncrObj.put("NCR_CLS_CONF", rs.getString(3));
            ncrObj.put("AUDITOR_ACTION", rs.getString(4));
            ncrObj.put("AUDITOR_STAFF_NO", rs.getString(5));
            ncrObj.put("NCR_DETAILS", rs.getString(6));
            ncrObj.put("ISO_CLAUSE", rs.getString(7));
            ncrObj.put("Audit_Name", rs.getString(8));
            arrayObj.put(ncrObj);
        }
        out.println(arrayObj);
    } catch (Exception e) {
        System.out.println("Exception " + e.toString());%>
<jsp:forward page="errorpage.jsp"></jsp:forward>
<%}

%>