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

        <% // pseudo session control - for feature appearance
            String viewerID = "-1";
            String viewerPermiss = "";

            try {
                viewerID = session.getAttribute("acctID").toString();
                viewerPermiss = dbconnect.queryDB("SELECT AcctType FROM accounts WHERE AcctID = ?;", viewerID)[0];
            } catch (Exception e) {
                // do nothing. viewerID and permiss is already -1
            }
        %>

        <%// Fetch account information from the database
            //                     0      1      2      3       4          5          6
            String sql = "SELECT FName, LName, Email, Phone, AcctType, AcctStatus, Username FROM accounts WHERE AcctID = ?;";
            String[] result = dbconnect.queryDB(sql, viewerID);
        %>

        <div class="w3-container w3-padding-32">
            <div class="w3-section">
                <h1>Welcome <% out.print(result[0]);%></h1>
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
                <%
                    if (!viewerID.equals("-1")) {
                %>
                <div class="w3-container">
                    <form action="accountDetails.jsp">
                        <input type='submit' value='My Account' class='w3-button' name="D"/>
                    </form>
                </div>
                <%
                    }
                %>
            </div>
        </div>


    </body>

</html>
