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

    JSONObject mUser = null;

    try {
        String fy_year = request.getParameter("fyyear").toString();
        String fileNumber = request.getParameter("fileNumber").toString();
        String qstring = "";
        session.setAttribute("fileUpload", "false");
        if (fy_year != null && fy_year != "" && fileNumber == "") {
            qstring = "SELECT INT_SCH_1_FileName, INT_SCH_2_FileName, INT_SCH_3_FileName, INT_SCH_4_FileName FROM [dbo].[Schedule] where FY_YEAR = '" + fy_year + "'";
            System.out.println("query " + qstring);
            Statement stmt = con.getSt();
            ResultSet rs = stmt.executeQuery(qstring);

            while (rs.next()) {
                mUser = new JSONObject();
                mUser.put("FileName1", rs.getString("INT_SCH_1_FileName"));
                mUser.put("FileName2", rs.getString("INT_SCH_2_FileName"));
                mUser.put("FileName3", rs.getString("INT_SCH_3_FileName"));
                mUser.put("FileName4", rs.getString("INT_SCH_4_FileName"));
            }
        }

        if (fy_year != "" && fy_year != null && fy_year != "" && fileNumber != null && fileNumber != "") {
            qstring = "UPDATE [dbo].[Schedule] SET ";
            if (fileNumber.equals("1")) {
                qstring = qstring + "INT_SCH_1_FileName = '', INT_SCH_1_Image = NULL";
            } else if (fileNumber.equals("2")) {
                qstring = qstring + "INT_SCH_2_FileName = '', INT_SCH_2_Image = NULL";
            } else if (fileNumber.equals("3") ) {
                qstring = qstring + "INT_SCH_3_FileName = '', INT_SCH_3_Image = NULL";
            } else if (fileNumber.equals("4")) {
                qstring = qstring + "INT_SCH_4_FileName = '', INT_SCH_4_Image = NULL";
            }
            qstring = qstring + " WHERE FY_YEAR = '" + fy_year + "'";
            Statement stmt = con.getSt();
            int row = stmt.executeUpdate(qstring);
            if (row > 0) {
                mUser = new JSONObject();
                mUser.put("Success", true);
            }
        }

        out.println(mUser);
    } catch (Exception e) {
        System.out.println("Exception " + e.toString());%>
<jsp:forward page="errorpage.jsp"></jsp:forward>
<%}

%>