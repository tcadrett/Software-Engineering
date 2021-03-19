<%-- 
    Document   : admin account creation result page
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
    <div class="w3-container">
      <h1>AccountCreationAction</h1>

      <%
        dbConnect dbconnect = new dbConnect();
        String FName = request.getParameter("FirstName");
        String LName = request.getParameter("LastName");
        String Email = request.getParameter("Email");
        String Phone = dbconnect.cleanPhone(request.getParameter("Phone"));
        String AccountType = request.getParameter("AccountType");
        String defaultUsername = FName.substring(0, 1) + LName;
        String defaultPWD = FName.substring(0, 1).toLowerCase() + LName.substring(0, 1) + Phone + "!";

        /*
          // DEBUG: getParameter
          out.print("<p>" + FName + "</p>");
          out.print("<p>" + LName + "</p>");
          out.print("<p>" + Email + "</p>");
          out.print("<p>" + Phone + "</p>");
          out.print("<p>" + AccountType + "</p>");
          out.print("<p>" + defaultUsername + "</p>");
          out.print("<p>" + defaultPWD + "</p>");
         */
 /*
          // Variables for creating usernames when defaultUsername is taken.
          String backupUsername = defaultUsername;
          int backupCount = 1;
          String[] QueryResult = {};
          if (AccountType.equals("0") || AccountType.equals("1")) {
            QueryResult = dbconnect.queryDB("Select Username FROM accounts WHERE Username = ?;", backupUsername);
          }
         */
        String result = "";
        String sql = "";
        // Create New Account
        if (AccountType.equals("0") || AccountType.equals("1")) {
          sql = "INSERT INTO accounts(AcctID, FName, LName, Email, Phone, "
                  + "accountType, Username, Password) VALUES (0,?,?,?,?,?,?,?);";
          result = dbconnect.updateDB(sql, FName, LName, Email, Phone, AccountType, defaultUsername, defaultPWD);
          if (result.equals("CLOSED")) {
            out.print("<h2>Account for " + FName + " " + LName + " has been created.</h2>");
            out.print("<p>First Name: " + FName + "</p>");
            out.print("<p>Last Name: " + LName + "</p>");
            out.print("<p>Email: " + Email + "</p>");
            out.print("<p>Phone: " + Phone + "</p>");
            out.print("<p>Username: " + defaultUsername + "</p>");
            out.print("<p>Password: " + defaultPWD + "</p>");
            out.print("<p>Account Type: " + dbconnect.decodeAccountType(AccountType) + "</p>");
          }
        } else if (AccountType.equals("2") || AccountType.equals("3")) {

          sql = "INSERT INTO clerk (ClerkID, FName, LName, Email, Password) VALUES (0, ?, ?, ?, ?);";
          result = dbconnect.updateDB(sql, FName, LName, Email, defaultPWD);
          if (result.equals("CLOSED")) {
            out.print("<h2>Account for " + FName + " " + LName + " has been created.</h2>");
            out.print("<p>First Name: " + FName + "</p>");
            out.print("<p>Last Name: " + LName + "</p>");
            out.print("<p>Email: " + Email + "</p>");
            out.print("<p>Password: " + defaultPWD + "</p>");
            out.print("<p>Account Type: " + dbconnect.decodeAccountType(AccountType) + "</p>");
          }
        }

      %>
      <div class="w3-margin"></div>
      <p><a href="adminViewRequest.jsp">Return to Requests</a></p>

    </div>
  </div>
</body>
</html>
