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
            dbConnect dbconnect = new dbConnect();
            String query = request.getQueryString();
            char editor = query.charAt(1);
            char ledgerType = query.charAt(0);
            String ledgerID = query.substring(2, query.length() - 5);
            String legName;
            String[] titles = {" ", " ", " ", " ", " ", " "};
            String[] values = new String[6];
            switch (ledgerType) {
                case 'c':
                    legName = "Checking";
                    values = dbconnect.queryDB("SELECT Balance, Interest, Status FROM checking WHERE CheckingID = ?;", ledgerID);
                    titles[0] = "Balance";
                    titles[1] = "Interest";
                    titles[2] = "Status";
                    break;
                case 's':
                    legName = "Savings";
                    values = dbconnect.queryDB("SELECT Balance, Interest, Status FROM savings WHERE SavingsID = ?;", ledgerID);
                    titles[0] = "Balance";
                    titles[1] = "Interest";
                    titles[2] = "Status";
                    break;
                case 'r':
                    legName = "Credit";
                    values = dbconnect.queryDB("SELECT Balance, APR, Status, CardNumber, CreditLimit, DueDate FROM credit WHERE CreditID = ?;", ledgerID);
                    titles[0] = "Balance";
                    titles[1] = "APR";
                    titles[2] = "Status";
                    titles[3] = "Card Number";
                    titles[4] = "Credit Limit";
                    titles[5] = "Payment Due Date";
                    break;
                case 'l':
                    legName = "Loan";
                    values = dbconnect.queryDB("SELECT Balance, APR, Status, Principal, DueDate FROM loans WHERE LoanID = ?;", ledgerID);
                    titles[0] = "Balance";
                    titles[1] = "APR";
                    titles[2] = "Status";
                    titles[3] = "Principal";
                    titles[4] = "Payment Due Date";
                    break;
                default:
                    legName = "ERROR: No ledger type specified.";
                    break;
            }
        %>


        <div class="w3-container w3-padding 32">
            <div class="w3-row">
                <div class="w3-col m3"><div class="w3-margin"></div></div>


                <div class="w3-col m6">
                    <h1>Modify <%out.print(legName);%> Ledger #<%out.print(ledgerID);%></h1>
                    <div class="w3-margin"></div>
                    <div class="w3-card w3-container">
                        <div class="w3-margin"></div>
                        <form class="w3-form w3-container" action="modifyLedgerAction.jsp">
                            <label>Balance</label>
                            <input class="w3-input" type="text" name="Balance" value="<%out.print(values[0]);%>" readonly="readonly" />

                            <label><%out.print(titles[1]);%></label>
                            <input class="w3-input" type="text" name="Interest" value="<%out.print(values[1]);%>" />

                            <label>Status</label>
                            <select class="w3-select" name="Select">
                                <option></option>
                                <option></option>
                            </select>

                            <label>Card Number</label>
                            <input class="w3-input" type="text" name="Card" value="" />

                            <label>Credit Limit</label>
                            <input class="w3-input" type="text" name="Limit" value="" />

                            <label>Payment Due Date</label>
                            <input class="w3-input" type="text" name="DueDate" value="" />
                            
                            <div class="w3-margin"></div>
                            <input class="w3-button w3-teal" type="submit" name="submit" value="Submit"/>

                        </form>

                        <div class="w3-margin"></div>
                    </div>


                </div>
            </div>
        </div>
    </body>
</html>
