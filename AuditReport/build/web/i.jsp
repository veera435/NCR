<%-- 
    Document   : i
    Created on : 4 Jun, 2018, 1:54:40 PM
    Author     : 6157637
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean class="db.dbcon" id="con" scope="page"> </jsp:useBean>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
<style type="text/css">
<!--
.style9 {font-family: Verdana, Arial, Helvetica, sans-serif; font-weight: bold; font-size: 10px; color: #1d2783; } /*0066FF*/
.style11 {font-family: Verdana, Arial, Helvetica, sans-serif; font-weight: bold; font-size: 10px; color: #A7A7A7; }
-->
</style>
</head>

<body bgcolor="#FFFFCC">

<%

ResultSet rs,rs2,rs3,rs4,rsMail;
Statement stmt,stmt2,stmt3,stmt4,stmtMail;

String Qstr3="";
int iz=0,TOTALV=0;
int today=0;
int total=0;


String Matter="test";
String Subject="Birthday Wishes";
String pesd="http://intranet.bhelpesd.co.in";

String stno="";
String design="";
String name="";
String email="";
String emailExtn="@bhel.in";
String mailarg;

%>



<% String STNO=session.getAttribute("STNO").toString(); 
   
%>

<!--1. select if a new date entry there in table
2. if there always increment by 1
3.if not there insert new date and count as 1
-->
<%String ip = request.getLocalAddr(); %>
<%  
  
        try {
            
            
            Connection conn = con.getcon();
          

 
stmt3=con.getSt();
 stmt3=conn.createStatement();
		    Qstr3="insert into pesd_t_v (dated,v,stno,ip) values(sysdate,1,'"+STNO+"','"+ip+"') ";
			iz=stmt3.executeUpdate(Qstr3);
			

 
 
 
   con.Conclose();
           }/*end try block*/
            catch(Exception e) {
                e.printStackTrace();
            }
    %>


	
</body>
</html>
   
	
	

