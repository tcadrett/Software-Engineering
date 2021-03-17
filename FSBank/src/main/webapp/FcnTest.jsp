<%-- 
    Document   : FcnTest
    Created on : Mar 17, 2021, 9:20:04 AM
    Author     : Terri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="myBeans.dbConnect, java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <%@include file="header.jsp" %>
  </head>
  <body>
    <h1>Function Testing for dbConnect.java!</h1>
    <h2>
    <%
      dbConnect dbconnect = new dbConnect();
      
      //out.print(dbconnect.cleanPhone("555-666-9999"));
      out.print(dbconnect.decodeAccountType("2"));

      %>
    </h2>
  </body>
</html>
