<%-- 
    Document   : errorpage
    Created on : 
    Author     : 6157637
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Error occured</h1>
        <%
              if(request.getParameter("s_msg") != null ){%>
              
              <h1><%= request.getParameter("s_msg") %> </h1>
                  
                       
                      <% }else{%>
                     <h1>Error occured </h1>   
                      <% }%>
    </body>
</html>
