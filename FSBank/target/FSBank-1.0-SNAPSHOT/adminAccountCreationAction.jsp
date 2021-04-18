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

                    // Update account listing with new status
                    //sql = "UPDATE accounts(FName, LName, Email, Phone, AcctType, Username, Pwd, AcctStatus) WHERE AcctID = ? VALUES (0,?,?,?,?,?,?,?,1);";
                    String sql = "UPDATE accounts "
                            + "SET FName = ?, LName = ?, Email = ?, Phone = ?, AcctType = ?, Username = ?, Pwd = ?, AcctStatus = 1 "
                            + "WHERE AcctID = ?;";
                    result = dbconnect.updateDB(sql, FName, LName, Email, Phone, AccountType, defaultUsername, defaultPWD, AcctID);

                    if (result.equals("CLOSED")) {
                %>
                <div class="w3-section">
                    <h1>Account Created for <% out.print(FName + " " + LName);%>.</h1>
                </div>
                <%
                        // test for existing accounts and add if needed
                        String[] noChecking = dbconnect.queryDB("SELECT COUNT(AcctID) FROM checking WHERE AcctID = " + AcctID + ";");
                        String[] noSaving = dbconnect.queryDB("SELECT COUNT(AcctID) FROM checking WHERE AcctID = " + AcctID + ";");
                        
                        String[] defaultCheckingInt = dbconnect.queryDB("SELECT VarFloatValue FROM defaultValues WHERE VarName = 'FL_CheckingInterest';");
                        String[] defaultSavingInt = dbconnect.queryDB("SELECT VarFloatValue FROM defaultValues WHERE VarName = 'FL_SavingInterest';");

                        if (noChecking[0].equals("0")) { // add checking account if 0 checking accounts are found
                            result = dbconnect.updateDB("INSERT INTO checking (AcctID, Interest) VALUES (?, ?);", AcctID, defaultCheckingInt[0]);
                        }
                        if (noSaving[0].equals("0")) { // add savings account if 0 savings accounts are found
                            result = dbconnect.updateDB("INSERT INTO savings (AcctID, Interest) VALUES (?, ?);", AcctID, defaultSavingInt[0]);

                        }


                    }

                %>

                <h1>Account Details</h1>
                <table class="w3-table w3-striped w3-container">
                    <tr>
                        <td>First Name:</td>
                        <td><% out.print(FName); %></td>
                    </tr>
                    <tr>
                        <td>Last Name:</td>
                        <td><% out.print(LName); %></td>
                    </tr>
                    <tr>
                        <td>Username:</td>
                        <td><% out.print(defaultUsername);%></td>
                    </tr>
                    <tr>
                        <td>Password:</td>
                        <td><% out.print(defaultPWD); %></td>
                    </tr>
                    <tr>
                        <td>Email:</td>
                        <td><% out.print(Email); %></td>
                    </tr>
                    <tr>
                        <td>Phone:</td>
                        <td><% out.print(Phone); %></td>
                    </tr>
                    <tr>
                        <td>Account Type:</td>
                        <td><% out.print(dbconnect.decodeAccountType(AccountType));  %></td>
                    </tr>
                    <tr>
                        <td>Account Status:</td>
                        <td><% out.print(dbconnect.decodeAccountStatus("1"));%></td>
                    </tr>
                </table>
            </div>
            <div class="w3-margin"></div>

            <!-- Account Tables-->
            <div class="w3-container">
                <%
                    String CheckingSQL = "SELECT CheckingID, Balance, Interest FROM checking WHERE AcctID = " + AcctID + ";";
                    String SavingSQL = "SELECT SavingsID, Balance, Interest FROM savings WHERE AcctID = " + AcctID + ";";
                    String CreditSQL = "SELECT CreditID, CardNumber, Balance, CreditLimit, APR, DueDate FROM credit WHERE AcctID = " + AcctID + ";";
                    String LoanSQL = "SELECT LoanID, Principal, Balance, APR, DueDate FROM loans WHERE AcctID = " + AcctID + ";";


                %>

                <!-- List Checking Accounts -->
                <div class="w3-container">
                    <h3>Checking Accounts:</h3>
                </div>
                <table class="w3-container w3-table w3-striped">
                    <tr class="w3-teal">
                        <th>Account Number</th>
                        <th>Balance</th>
                        <th>Interest Rate</th>
                    </tr>
                    <% out.print(dbconnect.htmlTableQuery(CheckingSQL, "Headless", "", "", "", "", "", ""));%>
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

                    <% out.print(dbconnect.htmlTableQuery(SavingSQL, "Headless", "", "", "", "", "", ""));%>

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
                        <th>APR</th>
                        <th>Payment Due Date</th>
                    </tr>

                    <% out.print(dbconnect.htmlTableQuery(CreditSQL, "Headless", "", "", "", "", "", ""));%>

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

                    <% out.print(dbconnect.htmlTableQuery(LoanSQL, "Headless", "", "", "", "", "", ""));%>

                </table>                
            </div>


            <div class="w3-margin"></div>
            <div class="w3-section"><a href="adminViewRequest.jsp" class="w3-button w3-teal">Return to Requests</a></div>

        </div>
    </div>
</body>
</html>
