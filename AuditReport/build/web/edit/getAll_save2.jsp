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


try{
    
     Connection con1 =con.getcon();
           Statement st=con.getSt();
           
           st=con1.createStatement();

  

String Qstring=" update pesd_tr set"
	+" STNO='"+STNO+"',"
	+" NAME='"+NAME+"',"
	+" COFFICER='"+COFFICER+"',"
        +" COFFICERNAME='"+COFFICERNAME+"',"	
	+" ADR='"+ADR+"', "
        +" FROMDT=to_date('"+FROMDT+"','ddmmyy'), "
        +" TODT=to_date('"+TODT+"','ddmmyy') "
	+" where ROWID='"+ROWID+"' "; 


	
   
out.println(Qstring);
iz=st.executeUpdate(Qstring);

%>


<% 
    if(iz>0)
    {   
%>
     <script>
          alert("Successfully updated" );
          window.location = 'getAll.jsp';
     </script> 
<%
       }
%>


<%
    st.close();
    
    con.Conclose();
}
catch(Exception e){
System.out.println(e);
}
%>

</body>
</html>
