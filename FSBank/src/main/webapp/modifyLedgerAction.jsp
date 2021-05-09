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
        <div class="w3-container w3-padding 32">
            <div class="w3-container">

                <%
                    dbConnect dbconnect = new dbConnect();
                    String acctID = request.getParameter("acctID");
                    char editor = request.getParameter("editor").charAt(0);
                    char ledgerType = request.getParameter("ledgerType").charAt(0);
                    String ledgerID = request.getParameter("ledgerID");
                    String balance = request.getParameter("Balance");
                    String interest = request.getParameter("Interest");
                    String ledgerStatus = request.getParameter("Status");
                    String cardNumber = request.getParameter("CardNumber");
                    String creditLimit = request.getParameter("CreditLimit");
                    String dueDate = request.getParameter("DueDate");
                    String principal = request.getParameter("Principal");
                    String output;

                    String newStatus = dbconnect.decodeLedgerStatus(ledgerStatus);

                    switch (ledgerType) {
                        case 'c':
                            output = dbconnect.updateDB("UPDATE checking SET Interest = ?, Status = ? WHERE CheckingID = ?;", interest, ledgerStatus, ledgerID);
                            out.print("<p>Checking: #" + ledgerID + "</p>");
                            out.print("<p>Balance: $" + balance + "</p>");
                            out.print("<p>Interest: " + interest + "%</p>");
                            out.print("<p>Status: " + newStatus + "</p>");
                            break;
                        case 's':
                            output = dbconnect.updateDB("UPDATE savings SET Interest = ?, Status = ? WHERE SavingsID = ?;", interest, ledgerStatus, ledgerID);
                            out.print("<p>Savings: #" + ledgerID + "</p>");
                            out.print("<p>Balance: $" + balance + "</p>");
                            out.print("<p>Interest: " + interest + "%</p>");
                            out.print("<p>Status: " + newStatus + "</p>");
                            break;
                        case 'r':
                            cardNumber = request.getParameter("CardNumber");
                            creditLimit = request.getParameter("CreditLimit");
                            output = dbconnect.updateDB("UPDATE credit SET APR = ?, Status = ?, CardNumber = ?, CreditLimit = ? WHERE CreditID = ?;", interest, ledgerStatus, cardNumber, creditLimit, ledgerID);
                            out.print("<p>Credit: %" + ledgerID + "</p>");
                            out.print("<p>Balance: $" + balance + "</p>");
                            out.print("<p>APR " + interest + "%</p>");
                            out.print("<p>Status: " + newStatus + "</p>");
                            out.print("<p>Card Number: " + cardNumber + "</p>");
                            out.print("<p>Credit Limit: $" + creditLimit + "</p>");
                            out.print("<p>Payment Due Date: " + dueDate + "</p>");
                            break;
                        case 'l':
                            principal = request.getParameter("Principal");
                            output = dbconnect.updateDB("UPDATE loans SET APR = ?, Status = ?, Principal = ? WHERE CreditID = ?;", interest, ledgerStatus, principal, ledgerID);
                            out.print("<p>Loan #" + ledgerID + "</p>");
                            out.print("<p>Balance: $" + balance + "</p>");
                            out.print("<p>APR " + interest + "%</p>");
                            out.print("<p>Status: " + newStatus + "</p>");
                            out.print("<p>Principal: $" + principal + "</p>");
                            out.print("<p>Payment Due Date: " + dueDate + "</p>");
                            break;
                        default:
                            break;
                    }

                %>


            </div>
            <div class="w3-margin"></div>
            <form class='w3-section' action="accountDetails.jsp">
                <input type='submit' value='Return to Account Details' class='w3-button w3-teal' name="<%out.print("R" + acctID);%>"/>
            </form>
        </div>
    </body>
</html>
