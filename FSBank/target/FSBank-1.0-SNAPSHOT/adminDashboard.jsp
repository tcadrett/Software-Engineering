<%-- 
    Document   : accountRequest
    Created on : Mar 10, 2021, 12:03:01 PM
    Author     : Terri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="myBeans.dbConnect, java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FSBank</title>
        <%@include file="header.jsp" %>
    </head>
    <body id="myPage">

        <%
            dbConnect dbconnect = new dbConnect();
        %>

        <!-- To be added when login functionality is implemented
        <% /* // session control
          if (session.getAttribute("logged") == null || !session.getAttribute("logged").equals("admin")) {
            response.sendRedirect("staffLogin.jsp");
          }
         */%>
        -->

        <div class="w3-container w3-padding-32">
            <div class="w3-section">
                <h1>Welcome <%
            // To be added when login functionality is implemented
%></h1>
            </div>
            <div class="w3-section">
                <div class="w3-container">
                    <a class="w3-button" href="adminViewRequest.jsp">View Account Requests</a>
                </div>
                <div class="w3-container">
                    <a class="w3-button" href="adminViewAccounts.jsp">View Current Accounts</a>
                </div>
                <div class="w3-container">
                    <a class="w3-button" href="adminViewGlobalInterest.jsp">View Default Interest Rates</a>
                </div>
            </div>
        </div>


    </body>

</html>
