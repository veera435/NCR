<%-- 
    Document   : mp
    Created on : 9 Aug, 2017, 9:49:01 AM
    Author     : 6157637
--%>



<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.io.*" errorPage="" %>
 <%@page import="oracle.jdbc.OraclePreparedStatement"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Untitled Document</title>
        <style type="text/css">
            <!--
.style17 {font-family: Verdana, Arial, Helvetica, sans-serif, "Agency FB"; font-size: 12px; }
.style20 {color: #000000}
.style21 {font-weight: bold; font-family: Verdana, Arial, Helvetica, sans-serif, "Agency FB";}
.style22 {font-family: Verdana, Arial, Helvetica, sans-serif, "Agency FB"; font-weight: bold; color: #000000; }
            -->
        </style>



<script language="javascript">

        function UpdateRow(recnum){

            if (document.mliHome.STNO.length){

                if (document.mliHome.STNO(recnum).length<=0){

                    alert("STNO is blank.");

                    return false;

                }
	 document.HiddenForm.STNO.value=document.mliHome.STNO(recnum).value;
         document.HiddenForm.NAME.value=document.mliHome.NAME(recnum).value;
         document.HiddenForm.COFFICER.value=document.mliHome.COFFICER(recnum).value;
         document.HiddenForm.COFFICERNAME.value=document.mliHome.COFFICERNAME(recnum).value;
	 
         document.HiddenForm.ADR.value=document.mliHome.ADR(recnum).value;
         document.HiddenForm.FROMDT.value=document.mliHome.FROMDT(recnum).value;
         document.HiddenForm.TODT.value=document.mliHome.TODT(recnum).value;
         document.HiddenForm.ROWID.value=document.mliHome.ROWID(recnum).value;
				
				
                
				

            }else{

                if (document.mliHome.STNO.length<=0){

                    alert("STNO blank.");

                    return false;

                }

        document.HiddenForm.STNO.value=document.mliHome.STNO.value;
        document.HiddenForm.NAME.value=document.mliHome.NAME.value;
	document.HiddenForm.COFFICER.value=document.mliHome.COFFICER.value;
        document.HiddenForm.COFFICERNAME.value=document.mliHome.COFFICERNAME.value;
	
        document.HiddenForm.ADR.value=document.mliHome.ADR.value;
        document.HiddenForm.FROMDT.value=document.mliHome.FROMDT.value;
        document.HiddenForm.TODT.value=document.mliHome.TODT.value;
	document.HiddenForm.ROWID.value=document.mliHome.ROWID.value;
  			

            }

            document.HiddenForm.submit();

            return true;

        }

    </script>



    </head>

    <body>
       
 <jsp:useBean class="db.dbcon" id="con" scope="page"> </jsp:useBean>
    
    

            <%
                
                

                ResultSet rs =null;

               
                int sumcount = 0;
				
		String STNO = "";
                String query="";
                int cnt=0;
                
                
           Connection con1 =con.getcon();
           Statement st=con.getSt();
           
           st=con1.createStatement();

            %>
    


<form method="post" action="getAll_save.jsp" name="HiddenForm">

<input type="hidden" name="STNO" size=3>
<input type="hidden" name="NAME" size=3>
<input type="hidden" name="COFFICER" size=20>
<input type="hidden" name="COFFICERNAME" size=3>

<input type="hidden" name="ADR" size=3>
<input type="hidden" name="FROMDT" size=3>
<input type="hidden" name="TODT" size=3>
<input type="hidden" name="ROWID" size=3>

</form>


<form action="" method="post" name="mliHome">
			

<table width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="#555555">

<tr bgcolor="ffffff"><td colspan="10"><div align="center" class="style20"><span class="style21">Tour reports</span></div></td>

  </tr>
 
 <tr bgcolor="ffffff">
 <td><span class="style22"></span></td>
 <td><span class="style22">STNO</span></td>
 <td><span class="style22">NAME</span></td>
 <td><span class="style22">COFFICER</span></td>
 <td><span class="style22">COFFICER NAME</span></td>
 
 <td><span class="style22">adr </span></td>
 <td><span class="style22">FromDT</span></td>
 <td><span class="style22">TODT</span></td>
 <td><span class="style22"></span></td>
              
              
 </tr>
    
   


 <%    
 try {
query="select STNO,NAME,COFFICER,COFFICERNAME,adr,to_char(fromdt,'ddmmyy'),to_char(todt,'ddmmyy'),rowid from pesd_tr order by fromdt";
rs = st.executeQuery(query);
while (rs.next()) {%>

           
<tr bgcolor="ffffff" >

        <td align="left" ><span class="style17"><%=cnt%></span></td>
	<td align="left" ><span class="style17"><input type="text" name="STNO" id="STNO" value="<%=rs.getString(1)%>" style="width:50px"></span></td>
	<td align="left" ><span class="style17"><input type="text" name="NAME" id="NAME" value="<%=rs.getString(2)%>"style="width:150px"></span></td>
	<td align="left" ><span class="style17"><input type="text" name="COFFICER" id="COFFICER" value="<%=rs.getString(3)%>" style="width:50px"></span></td>
	<td align="left" ><span class="style17"><input type="text" name="COFFICERNAME" id="COFFICERNAME" value="<%=rs.getString(4)%>"style="width:150px" ></span></td>
	<td align="left" ><span class="style17"><input type="text" name="ADR" id="ADR" value="<%=rs.getString(5)%>" style="width:150px"></span></td>
	<td align="left" ><span class="style17"><input type="text" name="FROMDT" id="FROMDT" value="<%=rs.getString(6)%>" style="width:100px"></span></td>
        <td align="left" ><span class="style17"><input type="text" name="TODT" id="TODT" value="<%=rs.getString(7)%>" style="width:100px"></span></td>

	<input type="hidden" name="ROWID" id="ROWID" value="<%=rs.getString(8)%>" >
	<td><input name="Edit" type="button"  value="Edit Status"  onclick="UpdateRow(<%=cnt%>);" /></td>
	</tr>
                    
					
	<%cnt=cnt+1;}%>          
            <%

                } catch (Exception e) {
                    e.printStackTrace();
                }

               con.Conclose();
                
            %>
    </table>
</form>
    </body>
</html>
