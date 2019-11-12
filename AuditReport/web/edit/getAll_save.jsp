<%@page language="java" import="java.sql.*"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.*"%>
<jsp:useBean class="db.dbcon" id="con" scope="page"> </jsp:useBean>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>

<script>
function update() {
    document.getElementById("mliHome").action = "getAll_save2.jsp";
                document.mliHome.submit();
}


</script>

<script>
function delete_row() {
    document.getElementById("mliHome").action = "getAll_del.jsp";
                document.mliHome.submit();
}


</script>


</head>

<body>

<%

String STNO=request.getParameter("STNO");
String NAME=request.getParameter("NAME");
String COFFICER=request.getParameter("COFFICER");
String COFFICERNAME=request.getParameter("COFFICERNAME");

String ADR=request.getParameter("ADR");
String FROMDT=request.getParameter("FROMDT");
String TODT=request.getParameter("TODT");

String ROWID=request.getParameter("ROWID");
int iz=0;



%>



<table>
<form method="post" name="mliHome" id="mliHome" >
<tr> 

<td colspan="2"><input type="button" value="delete " onclick="delete_row()">
</tr>

<tr> 
<td>stno</td>
<td><input type="text" name="STNO" id="STNO" value="<%=STNO%>" size="100px"></td>
</tr>
<tr> 
<td>NAME</td>
<td><input type="text" name="NAME" id="NAME" value="<%=NAME%>" size="100px"></td>
</tr>

<tr> 
<td>COFFICER</td>
<td><input type="text" name="COFFICER" id="COFFICER" value="<%=COFFICER%>" size="100px"></td>
</tr>
<tr> 
<td>COFFICER NAME</td>
<td><input type="text" name="COFFICERNAME" id="COFFICERNAMR" value="<%=COFFICERNAME%>" size="100px"></td>
</tr>



<tr> 
<td>ADR</td>
<td><input type="text" name="ADR" id="ADR" value="<%=ADR%>" size="100px"></td>
</tr>

<tr> 
<td>MONTH</td>
<td><input type="text" name="FROMDT" id="FROMDT" value="<%=FROMDT%>" size="100px"></td>
</tr>

<tr> 
<td>MONTH</td>
<td><input type="text" name="TODT" id="TODT" value="<%=TODT%>" size="100px"></td>
</tr>


<tr> 
<td>rowid</td>
<td><input type="text" name="ROWID" id="ROWID" value="<%=ROWID%>" size="100px"></td>
</tr>





<tr> 
<td></td>
<td></td>
</tr>

<tr> 
<td></td>
<td></td>
</tr>

<tr> 
<td></td>
<td></td>
</tr>

<tr> 
<td></td>
<td></td>
</tr>

<tr> 
<td></td>
<td></td>
</tr>

<tr> 
<td></td>
<td></td>
</tr>

<tr> 

<td colspan="2"><input type="button" value="update" onclick="update()">
</td>
</tr>

</form>

</table>

</body>
</html>
