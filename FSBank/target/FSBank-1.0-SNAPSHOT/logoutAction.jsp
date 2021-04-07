<%-- 
    Document   : logoutAction
    Created on : Mar 14, 2021, 11:30:24 PM
    Author     : guada
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
  </head>
  <body>
    <%
      session.setAttribute("logged", "index");
      response.sendRedirect("index.jsp");
    %>
  </body>
</html>
