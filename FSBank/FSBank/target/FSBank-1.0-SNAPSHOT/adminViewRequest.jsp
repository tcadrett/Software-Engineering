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
  <body>

    <!-- To be added when login functionality is implemented
    <% /* // session control
      if (session.getAttribute("logged") == null || !session.getAttribute("logged").equals("admin")) {
        response.sendRedirect("staffLogin.jsp");
      }
       */%>
    -->

    <%
      dbConnect dbconnect = new dbConnect();
      //String formValue = request.getParameter("type");
      //String sql = ";
      //String args[] = dbconnect.queryDB(sql, name, type);
      //out.print("Finish added!");
      //session.getAttribute("logged").equals("Admin")
    %>


    <div class="w3-container">
      <h1>View Account Requests</h1>
    </div>
    <!--
      Display table with option rows at end.
    -->
    <div class="w3-container w3-half">

      <form action="adminCreateAccount.jsp">
        <table class="w3-table w3-striped ">
          <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Email</th>
            <th>Phone Number</th>
            <th>Account Type</th>
            <th>Action</th>
          </tr>
          <%
            out.print(dbconnect.viewAccountRequests("", "'"));

          %>

        </table>

      </form>


    </div>

    <div class="w3-container">
      <p><a href="adminDashboard.jsp">Return to Dashboard</a></p>
    </div>



    <!--
    <div class="w3-container w3-half">
      <table class="w3-table w3-striped">
    <%      String sql = "SELECT * FROM `accountreq`;";
      //out.print(dbconnect.htmlTableQuery(sql, "Head", "", "", "", "", "<th>Accept</th>", "<th>Reject</th>"));
      out.print(dbconnect.htmlTableQuery(sql, "Head", "", "", "", "", "<th>Action</th>", "<td>Accept/Reject</td>"));
    %>
  </table>
</div>
    -->





  </body>
</html>
