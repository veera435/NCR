<%--
    Document   : allotmentOrder
    Created on : May 14, 2018, 1:27:31 PM
    Author     : 6058515
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="oracle.jdbc.OraclePreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="incdb.jsp"%>
<%--<jsp:useBean class="db.connect" id="con" scope="session"> </jsp:useBean>--%>
<!DOCTYPE html>
<html>
    <head>
        <!--        <style>
                    table, th, td {
                        border: 1px solid black;
                    }
                </style>-->

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kalyanamandapam Allotment Order</title>
        <script>
            function printForm()
            {
//                alert("print");
//                window.print();
                var printContents = document.getElementById("order").innerHTML;
                var originalContents = document.body.innerHTML;
                document.body.innerHTML = printContents;
                window.print();
                document.body.innerHTML = originalContents;

            }
        </script>

    </head>


    <body>
        <%
//            try {
            String ctrlNo = request.getParameter("regno");//"M18190002";
            String sSql = "";
            String username = (String) session.getAttribute("username");
            String username1 = (String) session.getAttribute("name");
            System.out.println("username:" + username + username1);

//            Connection conn = con.getConnection();
            OraclePreparedStatement stmt = null;
            ResultSet rs = null;
            ResultSet rs1 = null;

//            Connection conn = con.getConnection();

            sSql = " select a.REG_NO,a.STAFFNO,a.PHNO_OFFICE,a.MOBILE_NO,a.RES_ADDR,"
                    + "a.FUNC_NATURE ,a.FUNC_NATURE_DESC,a.RELATION,A.RELATION_NAME,to_char(a.FROM_DT,'DD/MM/YYYY') as from_dt,"
                    + "nvl(to_char((a.FROM_DT + 1),'DD/MM/YYYY'),'') as to_dt,a.TIMINGS,a.SD_RECPT_NO, "
                    + "decode(a.FUNC_HALL,'M','Mangala','Sowbhagya') as fhall,to_char(a.CR_DT,'DD/MM/YYYY') as CR_DT,A.RENT_RECPT_NO,to_char(A.RENT_RECPT_DT,'DD/MM/YYYY') as RENT_RECPT_DT,"
                    + "A.SD_AMT,to_char(a.SD_RECPT_DT,'DD/MM/YYYY') as SD_RECPT_DT,nvl(a.remarks,'') as remarks,"
                    + " b.name,b.dept_code,b.dept_name,b.grade,b.designation,DECODE(b.REASON,'0','In Service','10','Deceased','3','Retired','Others') as STATUS"
                    + " from TA_MHALL_BOOKING a, APPSOFT.PERS_PR_EMP_INFO B where a.staffno = b.staffno and "
                    + " a.reg_no = ? ";
            System.out.println(sSql);
            stmt = (OraclePreparedStatement) conn.prepareStatement(sSql);
            stmt.setString(1, ctrlNo);
            rs = stmt.executeQuery();

            sSql = "SELECT NAME,DESIGNATION FROM APPSOFT.PERS_PR_EMP_INFO WHERE STAFFNO = ?";
            stmt = (OraclePreparedStatement) conn.prepareStatement(sSql);
            stmt.setString(1, username);
            rs1 = stmt.executeQuery();
            rs1.next();


            while (rs.next()) {
                String ftime = "";
                String ttime = "";
                String todate = "";
                String fnature = "";
                String relation = "";
                String fyear = "20" + rs.getString("REG_NO").substring(1, 3) + "-" + rs.getString("REG_NO").substring(3, 5);
                System.out.println(fyear);
                if (rs.getString("RELATION").equalsIgnoreCase("S")) {
                    relation = "Son";
                } else if (rs.getString("RELATION").equalsIgnoreCase("D")) {
                    relation = "Daughter";
                } else {
                    relation = "Self";
                }
                if (rs.getString("FUNC_NATURE").equalsIgnoreCase("M")) {
                    fnature = "Marriage";
                } else {
                    fnature = rs.getString("FUNC_NATURE_DESC");
                }
                System.out.println(rs.getString("TIMINGS"));
                if (rs.getString("TIMINGS").equalsIgnoreCase("M")) {
                    ftime = "9:00 AM";
                    ttime = "8:00 AM";
                } else {
                    ftime = "4:00 PM";
                    ttime = "3:00 PM";
                }


        %>
        <div  id="order">
            <table width="100%" cellpadding="3"  >
                <!--style="border-color: #00f"-->
                <tr >
                    <td  style="width: 15%; text-align: center; vertical-align: middle;">
                        <img src="images/BHEL_logo_original.jpg" style="width: 70%; padding-top: 4px; padding-bottom: 4px;">
                    </td>
                    <td colspan="5"  >
                <center>
                    <div><font style="font: bold 11pt/125% Tahoma, Arial, Helvetica, Times, Times New Roman, times-roman, georgia, sans-serif; color: #0d396a; text-shadow: 2px 3px 2px rgba(0,0,0,0.16); text-align: center;">BHARAT HEAVY ELECTRICALS LIMITED </font><br></div>
                    <div><font style="font: normal 10pt/125% Tahoma, Arial, Helvetica, Times, Times New Roman, times-roman, georgia, sans-serif; text-align: center;"> HPEP, Ramachandrapuram, Hyderabad -502 032
                        <br>TOWNSHIP ADMINISTRATION <br><u>ESTATE OFFICE </u>
                        </font></div>
                    <!--<br><h3>TOWNSHIP ADMINISTRATION</h3>    <br>         <h4><u>ESTATE OFFICE </u></h4>-->
                </center>
                </td>
                </tr>
                <tr>
                    <td colspan="6"> <h4><u>Ref No.HY/TA/EO/<%=fyear%> </u></h4></td>
                </tr>

                <tr>
                    <td colspan="6" style="font-family: sans-serif; font-size: larger; alignment-adjust: central">
                <center>
                    <b>KALYANAMANDAPAM ALLOTMENT ORDER</b>
                    <br>
                </center>
                </td>
                </tr>

            </table>

            <table width ="100%" border="1" style="border-collapse: collapse" >
                <tr>
                    <td width ="25%">
                        Control No:
                    </td>
                    <td width ="30%" colspan="2">
                        <%=rs.getString("REG_NO")%>
                    </td>
                    <td width ="20%">
                        Date
                    </td>
                    <td colspan="2" width ="30%">
                        <%=rs.getString("CR_DT")%>
                    </td>
                </tr>
                <tr>
                    <td >
                        Name
                    </td>
                    <td colspan="5">
                        <%=rs.getString("NAME")%>
                    </td>
                </tr>

                <tr>
                    <td colspan="1">
                        Staff No.
                    </td>
                    <td colspan="5">
                        <%=rs.getString("STAFFNO")%>
                    </td>
                </tr>

                <tr>
                    <td colspan="1">
                        Designation
                    </td>
                    <td colspan="5">
                        <%=rs.getString("DESIGNATION")%>
                    </td>
                </tr>

                <tr>
                    <td colspan="1">
                        Grade
                    </td>
                    <td colspan="5">
                        <%=rs.getString("GRADE")%>
                    </td>
                </tr>


                <tr>
                    <td colspan="1">
                        Internal No
                    </td>
                    <td colspan="5">
                        <%=rs.getString("PHNO_OFFICE")%>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">Mobile No.</td>
                    <td colspan="5"><%=rs.getString("MOBILE_NO")%></td>
                </tr>
                <tr>
                    <td colspan="1">
                        Applicant Status
                    </td>
                    <td colspan="5"><%=rs.getString("STATUS")%></td>
                </tr>

                <tr>
                    <td rowspan="2" colspan="1">Date of booking</td>
                    <td>From</td>
                    <td> <%=rs.getString("FROM_DT")%></td>
                    <td>Time</td>
                    <td colspan="2"><%=ftime%> </td>
                </tr>

                <tr>
                    <td>To</td>
                    <td><%=rs.getString("TO_DT")%> </td>
                    <td>Time</td>
                    <td colspan="2"><%=ttime%> </td>
                </tr>

                <tr>
                    <td colspan="1">
                        Function Hall
                    </td>
                    <td colspan="5"><%=rs.getString("FHALL")%></td>
                </tr>

                <tr>
                    <td colspan="1">
                        Reason for Booking
                    </td>
                    <td colspan="5">
                        <%=fnature%>
                    </td>
                </tr>

                <% if (rs.getString("STATUS").equalsIgnoreCase("RETIRED")) {%>
                <tr><td colspan="1">Security Deposit Amount paid</td>
                    <td ><%=rs.getString("SD_AMT")%></td>
                    <td > SD Receipt No.</td>
                    <td ><%=rs.getString("SD_RECPT_NO")%></td>
                    <td > SD Receipt Dt.</td>
                    <td ><%=rs.getString("SD_RECPT_DT")%></td>
                </tr>
                <% }%>
                <tr><td colspan="1">Rent Receipt No.</td>
                    <td colspan="5"><%=rs.getString("RENT_RECPT_NO")%></td>
                </tr>

                <tr>
                    <td colspan="1">Rent Receipt date</td>
                    <td colspan="5"><%=rs.getString("RENT_RECPT_DT")%></td>
                </tr>

                <tr>
                    <td colspan="1">Remarks</td>
                    <td colspan="5"><%=rs.getString("REMARKS")%></td>
                </tr>

            </table>

            <br>
            <br>
            <b><%=rs.getString("FHALL")%></b> Kalyana Mandapam is hereby allotted to Sh./Smt. <b><%=rs.getString("NAME")%></b> Staff No.<b><%=rs.getString("STAFFNO")%></b> with effective from <b><%=rs.getString("FROM_DT")%> <%=ftime%> </b> to <b><%=rs.getString("TO_DT")%> <%=ttime%></b>
            for <b><%=fnature%> of <%=relation%></b> <% if (rs.getString("RELATION_NAME") != null) {%>i.e. <b><%=rs.getString("RELATION_NAME")%> </b><% }%>.
            <br> <br>
            &emsp; - He/She shall abide by the Rules of Estate Policy during occupation.<br>
            &emsp; - Any damages caused to the Estate property is noticed,same shall be recovered at penal rates from salary.<br>
            &emsp; - Initial Electrical Meter reading shall be recorded by the Estate officials before occupation and after<br>
            &emsp;  vacation.Presence of occupant while taking reading is at his/her sole responsibility.<br>
            &emsp; - Electrical charges shall be based on actual consumption and charges shall be recovered from salary.<br>
            &emsp; - Kalyana Mandapam should be handed over to Estate in same condition as it was prior to occupation.<br><br><br>

            <table width="100%">
                <tr>
                    <td>Signature of the Allottee</td>
                    <!--<td style="text-align: right">NAME OF THE AUTHORISED OFFICER</td>-->
                    <!--<td style="text-align: right">Estate Office </td>-->
                </tr>
                <tr><td>Name        : <%=rs.getString("NAME")%> </td>
                    <td style="text-align: right"> <%=username1%> </td></tr>

                <tr><td>Staff No    : <%=rs.getString("STAFFNO")%></td>
                    <td style="text-align: right"><%=rs1.getString("DESIGNATION")%></td></tr>
                <tr><td>Date        : <%=rs.getString("CR_DT")%></td>
                    <td style="text-align: right">Estate Office </td></tr>

                <br>
                <br>

            </table>
        </div>
    <center>
        <input type="submit" name ="print" id="add" value=" Print  " onclick="printForm();">
    </center>

    <%        }

    %>

</body>


</html>