<%-- 
    Document   : accountRequest
    Created on : Mar 10, 2021, 12:03:01 PM
    Author     : Terri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>FSBank</title>
    <%@include file="header.jsp" %>
  </head>
  <body>

    <!-- To be added when login functionality is implemented
    <% /* // session control
      if (session.getAttribute("logged") == null || !session.getAttribute("logged").equals("admin")) {
        response.sendRedirect("staffLogin.jsp");
      }
       */%>
    -->
    <div id="w3-container">
      <h1>Administrator Dashboard</h1>

      <p>
        <a href="adminViewRequest.jsp">View account Requests</a>
      </p>

    </div>
  </body>

</html>
