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
    <div class="w3-container w3-padding-32">
      <div class="w3-section">
        <h1>AccountCreationAction</h1>
      </div>
      <div class="w3-section">
      <%
        dbConnect dbconnect = new dbConnect();
        String FName = request.getParameter("FirstName");
        String LName = request.getParameter("LastName");
        String Email = request.getParameter("Email");
        String Phone = dbconnect.cleanPhone(request.getParameter("Phone"));
        String AccountType = request.getParameter("AccountType");
        String defaultUsername = FName.substring(0, 1) + LName;
        String defaultPWD = FName.substring(0, 1).toLowerCase() + LName.substring(0, 1) + Phone + "!";
        String AcctID = request.getParameter("acctID");

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

        // Update account listing with new status
        //sql = "UPDATE accounts(FName, LName, Email, Phone, AcctType, Username, Pwd, AcctStatus) WHERE AcctID = ? VALUES (0,?,?,?,?,?,?,?,1);";
        sql = "UPDATE accounts "
                + "SET FName = ?, LName = ?, Email = ?, Phone = ?, AcctType = ?, Username = ?, Pwd = ?, AcctStatus = 1 "
                + "WHERE AcctID = ?;";
        result = dbconnect.updateDB(sql, FName, LName, Email, Phone, AccountType, defaultUsername, defaultPWD, AcctID);
        if (result.equals("CLOSED")) {
          out.print("<h2>Account for " + FName + " " + LName + " has been created.</h2>");
          out.print("<p>First Name: " + FName + "</p>");
          out.print("<p>Last Name: " + LName + "</p>");
          out.print("<p>Email: " + Email + "</p>");
          out.print("<p>Phone: " + Phone + "</p>");
          out.print("<p>Username: " + "</p>");
          out.print("<p>Password: " + defaultPWD + "</p>");
        } else {
          out.print(result);
        }
      %>
      </div>
      <div class="w3-margin"></div>
      <div class="w3-section"><a href="adminViewRequest.jsp" class="w3-button w3-teal">Return to Requests</a></div>

    </div>
  </div>
</body>
</html>
