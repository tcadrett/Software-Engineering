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
  </head>
  <body>
    <div class="w3-container">
      <h1>Hello World!</h1>
    </div>

    <div class="w3-container">
      <%
        dbConnect dbconnect = new dbConnect();
        String selection = request.getQueryString(); // get query
        // remove "=Accept" and "=Reject" leftover from form
        selection = selection.substring(0, selection.length() - 7);

        String stat = selection.substring(0, 1); // Status ('A' or 'R')
        String id = selection.substring(1); // Request ID #

        String sql = "SELECT * FROM accountreq WHERE ReqID = ?;";
        String[] result = dbconnect.queryDB(sql, id);

      %>


      <%// If rejected, send update statement and redirect to adminRequestResult.jsp
        //  with "Account Deleted" statement
        if (stat.equals("R")) {
          String sqlREJECT = "DELETE FROM `accountreq` WHERE `accountreq`.`ReqID` = " + id + ";";
          try {
            out.print("<p>Request for " + result[1] + " " + result[2]
                    + " has been rejected. Deleting request...");
            dbconnect.updateDB(sqlREJECT);
            out.print("<p>Request Deleted</p>");
            out.print("<p><a href='adminViewRequest.jsp'>Return to requests</a></p>");
          } catch (Exception e) {
            out.print("<p>ERROR: " + e.getMessage() + "</p>");
          }
        }
      %>

      <%// If accepted, display form to create account
        if (stat.equals("A")) {
          //out.print("<p>ACCEPTED</p>");

          String formHtml = "";
          out.print(formHtml);
        }
      %>
    </div>

    <form action="adminRequestResult"



          </body>
</html>
