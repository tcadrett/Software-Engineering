<%-- 
    Document   : adminViewAccounts
    Created on : Mar 27, 2021, 1:23:22 PM
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

    <!-- To be added when login functionality is implemented
    <% /* // session control
      if (session.getAttribute("logged") == null || !session.getAttribute("logged").equals("admin")) {
        response.sendRedirect("staffLogin.jsp");
      }
       */%>
    -->

    <%
      dbConnect dbconnect = new dbConnect();
    %>
    <div class="w3-container w3-padding-32">


      <h1>Active Accounts</h1>

      <div class="w3-span">
        <form action="adminModifyAccount.jsp">
          <table class="w3-table w3-striped w3-hoverable">
            <tr class="w3-teal"> 
              <th>Account ID</th>
              <th>First Name</th>
              <th>Last Name</th>
              <th>Account Type</th>
              <th>Username</th>
              <th>Creation Date</th>

            </tr>

            <%
              out.print(dbconnect.viewAccounts("", "", "w3-button w3-hover-grey w3-teal"));
            %>

          </table>
        </form>
      </div>

      <div class="w3-container">
        <a href="adminDashboard.jsp" class="w3-button w3-teal">Return to Dashboard</a>
      </div>
    </div>
  </body>
</html>
