<%-- 
    Document   : Template
    Created on : Apr 6, 2021, 6:29:40 PM
    Author     : tcadrett
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="myBeans.dbConnect, java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <title>FSBank</title>
        <%@include file="header.jsp" %>
    </head>
    <body id="myPage">
        <%
            dbConnect dbConnect = new dbConnect();
            String selection = request.getQueryString(); // get query

            // Extract AcctID from ID String based on previous page:
            //  "M#=Modify"
            //      viewAccountDetails.jsp
            //  "R#=Return to Account Details"
            //      modifyAccountInfoAction.jsp
            String AcctID = "";
            char source = selection.charAt(0);
            switch (source) {
                case 'M': // Entering from "View Accounts" page
                    AcctID = selection.substring(1, selection.length() - 8);
                    break;
                case 'R': // Entering from "Modify Account Info Action" page
                    AcctID = selection.substring(1, selection.length() - 26);
                    break;
            }

            String sql = "SELECT FName, LName, Email, Phone, AcctType, AcctStatus, Username FROM accounts WHERE AcctID = ?;";

            String[] result = dbConnect.queryDB(sql, AcctID);


        %>

        <div class="w3-container w3-padding-32">

            <!-- Error Output -->
            <% if (result[0] == "Error: No records found") {%>

            <h2> Error: No accounts found!</h2>
            <!-- Error Output -->

            <% } else {%>            <!-- Display Information -->


            <!-- Basic Info -->
            <div class="w3-container">
                <h1>Account Details</h1>
                <table class="w3-table w3-striped w3-container">
                    <tr>
                        <td>First Name:</td>
                        <td><% out.print(result[0]); %></td>
                    </tr>
                    <tr>
                        <td>Last Name:</td>
                        <td><% out.print(result[1]); %></td>
                    </tr>
                    <tr>
                        <td>Username:</td>
                        <td><% out.print(result[6]);%></td>
                    </tr>
                    <tr>
                        <td>Email:</td>
                        <td><% out.print(result[2]); %></td>
                    </tr>
                    <tr>
                        <td>Phone:</td>
                        <td><% out.print(result[3]); %></td>
                    </tr>
                    <tr>
                        <td>Account Type:</td>
                        <td><% out.print(dbConnect.decodeAccountType(result[4]));  %></td>
                    </tr>
                    <tr>
                        <td>Account Status:</td>
                        <td><% out.print(dbConnect.decodeAccountStatus(result[5])); %></td>
                    </tr>
                </table>
                <form class="w3-container" action="modifyAccountInfo.jsp">
                    <input type='submit' value='Edit' class='w3-button w3-teal' name='<% out.print("E" + AcctID); %>'/>
                </form>
            </div>
            <div class="w3-margin"> </div>

            <!-- Account Tables-->
            <div class="w3-container">
                <%
                    String CheckingSQL = "SELECT CheckingID, Balance, Interest FROM checking WHERE AcctID = " + AcctID + ";";
                    String SavingSQL = "SELECT SavingsID, Balance, Interest FROM savings WHERE AcctID = " + AcctID + ";";
                    String CreditSQL = "SELECT CreditID, CardNumber, Balance, CreditLimit, DueDate FROM credit WHERE AcctID = " + AcctID + ";";
                    String LoanSQL = "SELECT LoanID, Principal, Balance, APR, DueDate FROM loans WHERE AcctID = " + AcctID + ";";
                %>

                <!-- List Checking Accounts -->
                <div class="w3-container">
                    <h2>Checking Accounts:</h2>
                </div>
                <table class="w3-container w3-table w3-striped">
                    <tr class="w3-teal">
                        <th>Account Number</th>
                        <th>Balance</th>
                        <th>Interest Rate</th>
                    </tr>
                    <% out.print(dbConnect.htmlTableQuery(CheckingSQL, "Headless", "", "", "", "", "", ""));%>
                </table>

                <!-- List Savings Accounts -->
                <div class="w3-container">
                    <h3>Savings Accounts:</h3>
                </div>
                <table class="w3-container w3-table w3-striped">
                    <tr class="w3-teal">

                        <th>Account Number</th>
                        <th>Balance</th>
                        <th>Interest Rate</th>
                    </tr>

                    <% out.print(dbConnect.htmlTableQuery(SavingSQL, "Headless", "", "", "", "", "", ""));%>

                </table>

                <!-- List Credit Card Accounts -->
                <div class="w3-container">
                    <h3>Credit Accounts:</h3>
                </div>
                <table class="w3-container w3-table w3-striped">
                    <tr class="w3-teal">
                        <th>Account Number</th>
                        <th>Card Number</th>
                        <th>Balance</th>
                        <th>Credit Limit</th>
                        <th>Payment Due Date</th>
                    </tr>

                    <% out.print(dbConnect.htmlTableQuery(CreditSQL, "Headless", "", "", "", "", "", ""));%>

                </table>

                <!-- List Loans -->
                <div class="w3-container">
                    <h3>Loans</h3>
                </div>
                <table class="w3-container w3-table w3-striped">
                    <tr class="w3-teal">
                        <th>Account Number</th>
                        <th>Principal</th>
                        <th>Balance</th>
                        <th>APR</th>
                        <th>Payment Due Date</th>
                    </tr>

                    <% out.print(dbConnect.htmlTableQuery(LoanSQL, "Headless", "", "", "", "", "", ""));%>

                </table>                
            </div>

            <% } // END Info Display%>

            <div class="w3-margin"></div>
            <div class="w3-container">
                <a href="adminViewAccounts.jsp" class="w3-button w3-teal">Return to Accounts</a>
            </div>
        </div>
    </body>
</html>
