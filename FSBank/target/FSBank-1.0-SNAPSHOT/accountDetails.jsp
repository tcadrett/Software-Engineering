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
            //  "A#=HolderAccount"
            //      DEBUG.jsp
            String AcctID = "";
            char source = selection.charAt(0);
            switch (source) {
                case 'M': // Entering from "View Accounts" page
                    AcctID = selection.substring(1, selection.length() - 8);
                    break;
                case 'R': // Entering from "Modify Account Info Action" page
                    AcctID = selection.substring(1, selection.length() - 26);
                    break;
                case 'A': // Entering from debug page
                    AcctID = session.getAttribute("acctID").toString();
                    break;
            }

            String sql = "SELECT FName, LName, Email, Phone, AcctType, AcctStatus, Username FROM accounts WHERE AcctID = ?;";
            String viewer = session.getAttribute("acctID").toString();
            String[] result = dbConnect.queryDB(sql, AcctID);
            String[] viewerType = dbConnect.queryDB("SELECT AcctType FROM accounts WHERE AcctID = ?", viewer);

        %>

        <div class="w3-container w3-padding-32">

            <!-- Error Output -->
            <% if (result[0] == "Error: No records found") {%>

            <h2> Error: No accounts found!</h2>
            <!-- Error Output -->

            <% } else {
                //<!-- Display Information -->
                if (viewerType[0].equals("0") || viewerType[0].equals("1")) {   // if a user %> 

            <div class="w3-container">
                <h1>Welcome <%out.print(result[0]);%>!</h1>
                <form class="w3-container" action="modifyAccountInfo.jsp">
                    <input type='submit' value='Edit' class='w3-button w3-teal' name='<% out.print("E" + AcctID); %>'/>
                </form>
            </div>

            <%} else if (viewerType[0].equals("2") || viewerType[0].equals("3")) { // if faculty%>  
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
            <%}%>

            <div class="w3-margin"> </div>

            <!-- Account Tables-->
            <div class="w3-container">
                <%                    
                    String CheckingSQL = "SELECT CheckingID FROM checking WHERE AcctID = " + AcctID + ";";
                    String SavingsSQL = "SELECT SavingsID FROM savings WHERE AcctID = " + AcctID + ";";
                    String CreditSQL = "SELECT CreditID FROM credit WHERE AcctID = " + AcctID + ";";
                    String LoanSQL = "SELECT LoanID FROM loans WHERE AcctID = " + AcctID + ";";

                    String[] ledgers;
                %>



                <div class="w3-container">
                    <h2>Ledger Widget</h2>
                    <%
                        ledgers = dbConnect.queryDB(CheckingSQL);
                        for (int i = 0; i < ledgers.length; i++) {
                            out.print(dbConnect.ledgerWidget(ledgers[i], "checking"));
                        }
                    %>
                    <div class="w3-margin"></div>
                    <%
                        ledgers = dbConnect.queryDB(SavingsSQL);
                        for (int i = 0; i < ledgers.length; i++) {
                            out.print(dbConnect.ledgerWidget(ledgers[i], "savings"));
                        }
                    %>
                    <div class="w3-margin"></div>
                    <%
                        ledgers = dbConnect.queryDB(CreditSQL);
                        for (int i = 0; i < ledgers.length; i++) {
                            out.print(dbConnect.ledgerWidget(ledgers[i], "credit"));
                        }
                    %>
                    <div class="w3-margin"></div>
                    <%
                        ledgers = dbConnect.queryDB(LoanSQL);
                        for (int i = 0; i < ledgers.length; i++) {
                            out.print(dbConnect.ledgerWidget(ledgers[i], "loan"));
                        }
                    %>
                    <div class="w3-margin"></div>
                </div>


            </div>

            <% } // END Info Display%>

            <div class="w3-margin"></div>
            <div class="w3-container">
                <a href="adminViewAccounts.jsp" class="w3-button w3-teal">Return to Accounts</a>
            </div>
        </div>
    </body>
</html>
