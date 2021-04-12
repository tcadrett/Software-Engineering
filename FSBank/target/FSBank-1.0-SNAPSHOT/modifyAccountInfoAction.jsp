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
                <%
                    dbConnect dbconnect = new dbConnect();
                    String FName = request.getParameter("FirstName");
                    String LName = request.getParameter("LastName");
                    String Email = request.getParameter("Email");
                    String Phone = dbconnect.cleanPhone(request.getParameter("Phone"));
                    // Default value for AccountType is "";
                    String AccountType = "";
                    AccountType = request.getParameter("AccountType");

                    String AccountStatus = "";
                    AccountStatus = request.getParameter("AccountStatus");
                    String Username = request.getParameter("Username");
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
                    if (AccountType.equals("")) {
                        sql = "UPDATE accounts SET FName = ?, LName = ?, Email = ?, Phone = ?, Username = ? WHERE AcctID = '?';";

                        result = dbconnect.updateDB(sql, FName, LName, Email, Phone, Username, AcctID);

                    } else {
                        sql = "UPDATE accounts SET FName = ?, LName = ?, Email = ?, Phone = ?, Username = ?, AcctType = ?, AcctStatus = ? WHERE AcctID = ? ;";
                        result = dbconnect.updateDB(sql, FName, LName, Email, Phone, Username, AccountType, AccountStatus, AcctID);
                    }
                    // Print confirmation

                    if (result.equals("CLOSED")) {
                        out.print("<h2>Account for " + FName + " " + LName + " has been updated.</h2>");
                        out.print("<p>First Name: " + FName + "</p>");
                        out.print("<p>Last Name: " + LName + "</p>");
                        out.print("<p>Email: " + Email + "</p>");
                        out.print("<p>Phone: " + Phone + "</p>");
                        out.print("<p>Username: " + Username + "</p>");
                    } else {
                        out.print(result);

                    }
                %>
            </div>
            <div class="w3-margin"></div>
            <form class='w3-section' action="accountDetails.jsp">
                <input type='submit' value='Return to Account Details' class='w3-button w3-teal' name="<%out.print("R" + AcctID);%>"/>
            </form>

        </div>
    </div>
</body>
</html>
