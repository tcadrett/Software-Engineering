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

    <div class="w3-container w3-padding-32">

      <div class="w3-section">
        <h1>View Account Requests</h1>
      </div>
      <!--
        Display table with option rows at end.
      -->
      <div class="w3-section w3-responsive ">

        <form action="adminCreateAccount.jsp">
          <table class="w3-table w3-striped w3-hoverable">
            <tr class="w3-teal">
              <th>First Name</th>
              <th>Last Name</th>
              <th>Email</th>
              <th>Phone Number</th>
              <th>Account Type</th>
              <th  colspan="2">Action</th>
            </tr>
            <%
              out.print(dbconnect.viewAccountRequests("", "", "w3-button w3-hover-grey w3-teal"));

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
