<%--
    Document   : saveDetails
    Created on : Sep 5, 2018, 8:20:58 AM
    Author     : 6146252
--%>



<jsp:useBean class="db.dbcon" id="con" scope="page"> </jsp:useBean>


<%
    String UserName = session.getAttribute("UserName").toString();
    String AUDITOR_AUDITEE_COORD = session.getAttribute("AUDITOR_AUDITEE_COORD").toString();
    String STAFF_NO = session.getAttribute("STAFF_NO").toString();
    String AACName = session.getAttribute("AACName").toString();
%>

<%
    
    String name1;
    String value;

    try {
        value = "1";
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
                        
                        <a id="aFile1" href="download.jsp?filenumber=1"></a>
                       
                    </td>
                </tr>
                <tr>
                    <td>
                        Upload internal Audit Schedule  2  : 
                    </td>
                    <td>
                        <a id="aFile2" href="download.jsp?filenumber=2"></a>
                       
                    </td>
                </tr>
                <tr>
                    <td>
                        Upload External Audit Schedule 1 : 
                    </td>
                    <td>
                        
                        <a id="aFile3" href="download.jsp?filenumber=3"></a>
                        
                    </td>
                </tr>
                <tr>
                    <td>
                        Upload External Audit Schedule 2 : 
                    </td>
                    <td>
                        
                        <a id="aFile4" href="download.jsp?filenumber=4"></a>
                        
                    </td>
                </tr>
                <tr>
                    <td>
                        <br />   <br />
                    </td>
                </tr>
                <tr>
                    <td>
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



