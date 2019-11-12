

<%--
    Document   : login.jsp
    Created on : 9 Aug, 2017, 9:49:01 AM
    Author     : 6157637
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@page import="Audit.AuditInfo"%>
<%@page import="Audit.NcrAudit"%>


<jsp:useBean class="db.dbcon" id="con" scope="page"> </jsp:useBean>

<%

    String qstring = "";
    String sessionID;
    String STAFF_NO = request.getParameter("STAFF_NO");
    String password = request.getParameter("password");
    String AUDITER_TYPE = request.getParameter("AUDITER_TYPE");
    System.out.println("111111");
    System.out.println(AUDITER_TYPE);
    System.out.println("1");
    String AUDITOR_AUDITEE_COORD = request.getParameter("AUDITOR_AUDITEE_COORD");
    String AACName = request.getParameter("AACName");
    String AUDITEE = "";
    String ISO_COORD = "";
    String HOS = "";
    String CoLeadAuditor = "";
    try {

        Connection conn = con.getcon();
        Statement st = con.getSt();

        st = conn.createStatement();

        /*Statement st=con.getSt();*/
        //PreparedStatement st=null;
        ResultSet rs = null;
        qstring = "select UserName,STAFF_NO,password,IsAdmin from Audit_Login where upper(STAFF_NO) = upper('" + STAFF_NO + "')and  upper(password) = upper('" + password + "')";
        //st = conn.prepareStatement(qstring);
        rs = st.executeQuery(qstring);
        /*rs = pst.executeQuery(); */
        if (rs.next()) {

            System.out.println("2");
            session.setAttribute("UserName", rs.getString(1));
            session.setAttribute("IsAdmin", rs.getBoolean(4));
            session.setAttribute("STAFF_NO", STAFF_NO);
            session.setAttribute("AUDITER_TYPE", AUDITER_TYPE);
            session.setAttribute("AUDITOR_AUDITEE_COORD", AUDITOR_AUDITEE_COORD);
            session.setAttribute("AACName", AACName);
            sessionID = session.getId();
            session.setAttribute("sessionID", sessionID);

            if (AUDITOR_AUDITEE_COORD.equals("1") || AUDITOR_AUDITEE_COORD.equals("2") || AUDITOR_AUDITEE_COORD.equals("3") || AUDITOR_AUDITEE_COORD.equals("4")) {%>
<script>
    window.location = 'ncrlist.jsp';
</script>
<%} else if (rs.getString(2).equals(rs.getString(3))) {%>

<script>
    alert("Please change your Password.");
    window.location = 'auditorform.jsp';
</script>
<%} else {
        response.sendRedirect("auditorform.jsp");
    }
} else if (STAFF_NO != null) {%>

<script>
    alert("Incorrect Password");
</script>
<%}%>
<%          conn.close();
} catch (Exception e) {
    System.out.println(e.toString());
%>
<jsp:forward page="errorpage.jsp"></jsp:forward>
<% }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>login</title>
    </head>

    <body bgcolor="#EAF2F8">
        <form name="CMLOGINFORM" method="post" action="" >
            <td><div align="center" class="style5"><span class="style10"><font size="5" color="red">This tool works best in Chrome Browser!!!</font> </span></div></td>
            <table width="40%" border="0" align="center" bgcolor="#AED6F1">
                <tr bgcolor="#1B4F72">
                    <td colspan="2"><div align="center">
                            <div align="center"><span class="style7">Audit Reports </span></div>
                    </td>
                </tr>
                <tr bgcolor="#AED6F1">
                </tr>
                <td colspan="2"><div align="center"> &nbsp</td>
                </tr>
                <tr bgcolor="#AED6F1">
                    <td>
                        <div align="right" class="style5"><span class="style10">STAFF_NO  <font color="#FF0000">*</font> </span></div>
                    </td>
                    <td>
                        <span class="style8">
                            <label>
                                <input name="STAFF_NO" type="text" id="STAFF_NO" />
                            </label>
                        </span>
                    </td>
                </tr>
                <tr bgcolor="#AED6F1">
                    <td><div align="right" class="style5"><span class="style10">password  <font color="#FF0000">*</font></span></div></td>
                    <td>
                        <label>
                            <input name="password" type="password" id="PASSWORD"  />
                        </label>
                    </td>
                </tr>

                <tr bgcolor="#AED6F1">
                    <td>
                        <div align="right" class="style5"><span class="style10">AUDITOR/AUDITEE/COORD/HOS/CoLeadAuditor <font color="#FF0000">*</font></span></div>
                    </td>
                    <td>
                        <select name="AUDITOR_AUDITEE_COORD" id="AUDITOR_AUDITEE_COORD" >
                            <option value="">Please Select</option>
                            <option value="0" <%= AUDITEE.equalsIgnoreCase("AUDITOR") ? "selected=selected" : "a"%> >AUDITOR</option>
                            <option value="1" <%= AUDITEE.equalsIgnoreCase("AUDITEE") ? "selected=selected" : "b"%> >AUDITEE  </option>
                            <option value="2" <%= ISO_COORD.equalsIgnoreCase("ISO-COORD") ? "selected=selected" : "b"%> >ISO_COORD  </option>
                            <option value="3" <%= HOS.equalsIgnoreCase("HOS") ? "selected=selected" : "b"%> >HOS  </option>
                            <option value="4" <%= CoLeadAuditor.equalsIgnoreCase("HOS") ? "selected=selected" : "b"%> >Co-Lead Auditor  </option>
                        </select>
                        <input type="hidden" value="" name="AACName" id="AACName"/>
                    </td>
                </tr>

                <tr bgcolor="#AED6F1">
                    <td><div align="right" class="style5"><span class="style10">AUDITER_TYPE</span></div></td>
                    <td><span class="style12">
                            <label>
                                <select name="AUDITER_TYPE" id="AUDITER_TYPE" >
                                    <option value="-1">Please Select</option>
                                </select>
                            </label>
                    </td>
                </tr>

                <tr bgcolor="#AED6F1">
                    <td colspan="1">
                        <div align="left"></div></td>
                    <td colspan="1">
                        <div align="left">
                            <input type="submit" value="Login" onClick="return validlogin();"/>
                        </div></td>
                </tr>

                <tr bgcolor="#AED6F1">
                    <td colspan="1">
                        <div align="left"></div></td>
                    <td colspan="1">
                        <div align="left">
                            <input type="button" value="forgot password" onClick="window.location = 'forgotpwd.jsp';" />
                        </div>
                    </td>
                </tr>
                <tr bgcolor="#AED6F1">
                    <td colspan="2">&nbsp;</td>
                </tr>
            </table>
                        
        </form>
    </body>
</html>

<style type="text/css">
    .style5 {font-size: 12px}
    .style7 {
        font-family: Verdana, Arial, Helvetica, sans-serif, "Agency FB";
        font-weight: bold;
        color: #cccccc;
        font-size: 10px;
    }
    .style8 {font-family: Verdana, Arial, Helvetica, sans-serif; font-weight: bold; font-size: 12px; }
    .style10 {font-family: Verdana, Arial, Helvetica, sans-serif; font-weight: bold; color: #336699; }
    .style12 {
        font-family: Verdana, Arial, Helvetica, sans-serif;
        font-weight: bold;
        font-size: 10px;
        color: #336699;
    }
    .style13 {font-family: Verdana, Arial, Helvetica, sans-serif; font-weight: bold; font-size: 12px; color: #336699; }
</style>


<script src="js/jquery-3.3.1.min.js" type="text/javascript"></script>

<script LANGUAGE="JavaScript">

                                $(document).ready()(function () {
                                    var auditor_tyeps = {
                                        "0": "Internal",
                                        "1": "External"
                                    };

                                    var ddl_AUDITER_TYPE = $('#AUDITER_TYPE');
                                    $('#AUDITOR_AUDITEE_COORD').change(function () {
                                        var selectedValue = $(this).val();
                                        if (selectedValue === "0")
                                        {
                                            var html = $.map(auditor_tyeps, function (lcn, lcn1) {
                                                return '<option value="' + lcn1 + '">' + lcn + '</option>';
                                            }).join('');
                                            ddl_AUDITER_TYPE.html(html);
                                        } else
                                        {
                                            ddl_AUDITER_TYPE.html("<option value='-1'>Please Select</option>");
                                        }
                                    });
                                });

                                function validlogin()
                                {
                                    var StaffNo = $("#STAFF_NO").val();
                                    var Password = $("#PASSWORD").val();
                                    var User_Type = $("#AUDITOR_AUDITEE_COORD").val();

                                    if (StaffNo === "" || Password === "" || User_Type === "")
                                    {
                                        alert("* Marked fields are mandatory.");
                                        return false;
                                    }
                                    $('#AACName').val($('#AUDITOR_AUDITEE_COORD option:selected').text());
                                }
</script>