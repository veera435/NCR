<%-- 
    Document   : tr11
    Created on : 9 Sep, 2017, 11:09:17 AM
    Author     : 6157637
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>

<jsp:useBean class="db.dbcon" id="con" scope="page"> </jsp:useBean>

<%

    String qstring = "",qstring2 = "";
    String STNO="2195623";
     String [ ] AC1 = new String [2000];
      int ArrayCount=0;
      int aCount=0;
    
   try {
   
        Connection conn = con.getcon();
        
       /*Statement st=con.getSt();*/
        
        PreparedStatement st=null;
        PreparedStatement st2=null;
        
    
        ResultSet rs = null;
        ResultSet rs2 = null;
        qstring = "select STNO from telephone where upper(COFFICER)=upper('" + STNO + "')";
        st = conn.prepareStatement(qstring);
        rs=st.executeQuery();
        /*rs = pst.executeQuery(); */
        while (rs.next()) {
            
            AC1[ArrayCount] = rs.getString("STNO"); 
	    aCount=aCount+1;
            ArrayCount=ArrayCount+1;
            
            qstring2 = "select STNO from telephone where upper(COFFICER)=upper('" + STNO + "')";
            st2 = conn.prepareStatement(qstring2);
            rs2=st2.executeQuery();
            while (rs2.next()) {
                
                AC1[ArrayCount] = rs2.getString("STNO"); 
                aCount=aCount+1;
                 ArrayCount=ArrayCount+1;
            }

    }


%>
<%          conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }


%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1></h1>
        
        <select name="PROJECT"    id="PROJECT"  >
			  <option value=""></option>
			  
                  
                <%
            for( ArrayCount=0; ArrayCount<aCount; ArrayCount++ ) 
			{ %>
                <option value="<%=AC1[ArrayCount]%>"><%=AC1[ArrayCount]%></option>
                  
            <% } %>
        </select>
        
    </body>
</html>
