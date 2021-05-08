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
            String acctID = request.getParameter("acctID");
            String viewerID = "-1";
            int viewerPermiss = -1;
            try {
                viewerID = session.getAttribute("acctID").toString();
                viewerPermiss = Integer.parseInt(dbconnect.queryDB("SELECT AcctType FROM accounts WHERE AcctID = ?;", viewerID)[0]);
            } catch (Exception e) {
                // do nothing. viewerID is already -1
            }

            String[] result = dbconnect.queryDB("SELECT FName, LName, AcctType, AcctStatus FROM accounts WHERE AcctID = ?;", acctID);
            if (viewerPermiss <= 0) {
                response.sendRedirect("accountDetails.jsp");
            }
            char ledgerType = request.getParameter("ledgerType").charAt(0);
            String output;
            String defaultCheckingInt = "";
            String defaultSavingInt = "";
            String defaultCardAPR = "";
            String defaultLoanAPR = "";
            String ledgerID = "";
        %>


        <div class="w3-container w3-padding 32">
            <%
                switch (ledgerType) {
                    case 'c': // checking ledger
                        defaultCheckingInt = dbconnect.queryDB("SELECT VarFloatValue FROM defaultValues WHERE VarName = 'FL_CheckingInterest';")[0];
                        output = dbconnect.updateDB("INSERT INTO checking (AcctID, Balance, Interest) VALUES (?, ?, ?);", acctID, "0", defaultCheckingInt);
                        break;
                    case 's': // savings ledger
                        defaultSavingInt = dbconnect.queryDB("SELECT VarFloatValue FROM defaultValues WHERE VarName = 'FL_SavingInterest';")[0];
                        output = dbconnect.updateDB("INSERT INTO savings (AcctID, Balance, Interest) VALUES (?,?,?);", acctID, "0", defaultSavingInt);
                        break;
                    case 'r': // credit ledger
                        defaultCardAPR = dbconnect.queryDB("SELECT VarFloatValue FROM defaultValues WHERE VarName = 'FL_CreditAPR';")[0];
                        output = dbconnect.updateDB("INSERT INTO credit (AcctID, APR, Balance) VALUES (?,?,?);", acctID, defaultCardAPR, "0");
                        break;
                    case 'l': // loan ledger
                        defaultLoanAPR = dbconnect.queryDB("SELECT VarFloatValue FROM defaultValues WHERE VarName = 'FL_LoanAPR';")[0];
                        output = dbconnect.updateDB("INSERT INTO loans (AcctID, APR, Balance, Principal) VALUES (?,?,?,?);", acctID, defaultLoanAPR, "0", "0");
                        break;
                    default:
                        output = "ERROR: Invalid ledger type.";
                        break;
                }
            %>

            <%
                if (output.equals("CLOSED")) {
                    // success
            %>
            <h1>Ledger Request Submitted:</h1>
            <div class="w3-container">
                <table class="w3-table">
                    <tr><td>Type:</td><td><%
                        switch (ledgerType) {
                            case 'c':
                                out.print("Checking");
                                break;
                            case 's':
                                out.print("Savings");
                                break;
                            case 'r':
                                out.print("Credit");
                                break;
                            case 'l':
                                out.print("Loan");
                                break;
                        }
                            %></td></tr>
                    <tr><td>For:</td><td><%out.print(result[0] + " " + result[1]);%></td></tr>
                </table>
            </div>

            <%
                } else { // failure to create ledger
                    out.print("<p>" + output + "</p>");
                }
            %>


            <form class='w3-section' action="accountDetails.jsp">
                <input type='submit' value='Return to Account Details' class='w3-button w3-teal' name="<%out.print("R" + acctID);%>"/>
            </form>

        </div>
    </body>
</html>
