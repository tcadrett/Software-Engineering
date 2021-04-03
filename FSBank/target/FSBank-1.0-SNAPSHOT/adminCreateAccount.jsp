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

    <div class="w3-container w3-padding-32">


      <div class="w3-section">
        <%
          dbConnect dbconnect = new dbConnect();
          String selection = request.getQueryString(); // get query
          // remove "=Accept" and "=Reject" leftover from form
          selection = selection.substring(0, selection.length() - 7);

          String stat = selection.substring(0, 1); // Status ('A' or 'R')
          String id = selection.substring(1); // Request ID #

          String sql = "SELECT * FROM accounts WHERE AcctID = ?;";
          String[] result = dbconnect.queryDB(sql, id);

        %>


        <%// If rejected, send update statement and redirect to adminRequestResult.jsp
          //  with "Account Deleted" statement
          if (stat.equals("R")) {
        %>
        <div class="w3-container">
          <h1>Create Account</h1>
        </div>
        <div class="w3-section">
          <%
            String sqlREJECT = "DELETE FROM `accounts` WHERE AcctID = " + id + ";";
            try {
              out.print("<p>Request for " + result[1] + " " + result[2]
                      + " has been rejected. Deleting request...");
              dbconnect.updateDB(sqlREJECT);
              out.print("<p>Request Deleted</p>");
              out.print("<p><a href='adminViewRequest.jsp'>Return to requests</a></p>");
            } catch (Exception e) {
              out.print("<p>ERROR: " + e.getMessage() + "</p>");
            }

          %>
        </div>
        <%              }
        %>

        <%// If accepted, display form to create account
          if (stat.equals("A")) {
        %>
        <div class="w3-row">
          <div class="w3-col m3"><p></p></div>
          <div class="w3-col m6">
            <h1>Create Account</h1>
          </div></div>
        <div class="w3-row">

          <div class="w3-col m3"><p></p></div>
          <div class=" w3-col m6 w3-card">
            <div class='w3-container'>
              <div class='w3-margin'></div>

              <form action='adminAccountCreationAction.jsp' class=''>

                <label>First Name</label>

                <input class='w3-input' type='text' name='FirstName' 
                       value='<%out.print(result[1]);%>' required/>
                <label>Last Name</label>

                <input class='w3-input' type='text' name='LastName' 
                       value='<%out.print(result[2]);%>' required/>
                <label>Email</label>

                <input class='w3-input' type='text' name='Email' 
                       value='<%out.print(result[3]);%>' required/>
                <label>Phone</label>

                <input class='w3-input' type='text' name='Phone' 
                       value='<%out.print(result[4]);%>' required/>
                <hr>
                <label>Account Type</label>
                <select class='w3-select' name='AccountType' size='1' >
                  <option 

                    <%
                      if (result[5].equals("0")) {
                        out.print(" selected ");
                      }
                    %>
                    value="0">Suspended</option>
                  <option 

                    <%
                      if (result[5].equals("1")) {
                        out.print(" selected ");
                      }
                    %>
                    value="1">Account Holder</option>
                  <option 
                    <%
                      if (result[5].equals("2")) {
                        out.print(" selected ");
                      }
                    %>
                    value="2">Clerk</option>
                  <option 
                    <%
                      if (result[5].equals("3")) {
                        out.print(" selected ");
                      }
                    %>
                    value="3">Administrator</option>
                </select>

                <hr>
                <input type='hidden' name='acctID' value='<%out.print(id);%>'>
                <input class="w3-button w3-teal" type='submit' value='Submit' name='Submit' />
                <div class='w3-margin'></div>
              </form>
            </div>
          </div>
        </div>
        <%
          }
        %>
      </div>

    </div>

  </body>
</html>
