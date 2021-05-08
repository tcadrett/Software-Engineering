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

            String viewerID = "-1";
            int viewerPermiss = -1;
            try {
                viewerID = session.getAttribute("acctID").toString();
                viewerPermiss = Integer.parseInt(dbconnect.queryDB("SELECT AcctType FROM accounts WHERE AcctID = ?;", viewerID)[0]);
            } catch (Exception e) {
                // do nothing. viewerID is already -1
            }

            //** Resolve acctID based on prior page
            String selection = request.getQueryString(); // get query
            // Extract AcctID from ID String based on previous page:
            //  "M#=Modify"
            //      viewAccountDetails.jsp
            //  "R#=Return to Account Details"
            //      modifyAccountInfoAction.jsp
            //  "A#=HolderAccount"
            //      DEBUG.jsp
            String acctID = "";
            char source = ' ';
            try {
                source = selection.charAt(0);
            } catch (Exception e) {
                // nothing source is already ' '
            }
            switch (source) {
                case 'M':
                    acctID = selection.substring(1, selection.length() - 8);
                    break;
                case 'R':
                    acctID = selection.substring(1, selection.length() - 26);
                    break;
                case 'A':
                    try {
                        acctID = session.getAttribute("acctID").toString();
                        acctID.strip();
                    } catch (Exception e) {
                        acctID = "-1";
                    }
                    break;
                case 'D':
                    try {
                        acctID = session.getAttribute("acctID").toString();
                        acctID.strip();
                    } catch (Exception e) {
                        acctID = "-1";
                    }
                    break;
                default:
                    try {
                        acctID = session.getAttribute("acctID").toString();
                        acctID.strip();
                    } catch (Exception e) {
                        acctID = "-1";
                    }
                    break;
            }

        %>

        <%            //session control
            if ((viewerPermiss == 0 || viewerPermiss == 1) && !viewerID.equals(acctID)) {
                response.sendRedirect("accountDetails.jsp");
            }
        %>


        <!-- BEGIN CONTENT -->
        <div class="w3-container w3-padding-32">


            <%// Fetch account information from the database
                //                     0      1      2      3       4          5          6
                String sql = "SELECT FName, LName, Email, Phone, AcctType, AcctStatus, Username FROM accounts WHERE AcctID = ?;";
                String[] result = dbconnect.queryDB(sql, acctID);
                if (result.length != 7) {
                    out.print("ERROR: Source is " + selection);
                    for (int i = 0; i < 7; i++) {
                        result[i] = "0";
                    }
                }
            %>

            <%            // DEBUG OUTPUT
//                out.print("<div class=\"w3-container w3-card w3-margin w3-grey\">");
//                out.print("<p>DEBUG</p>");
//                out.print("<p>QueryString: ~~" + selection + "~~</p>");
//                out.print("<p>AcctID: ~~" + acctID + "~~</p>");
//                out.print("<p>AcctPermiss: ~~" + result[4] + "~~</p>");
//                out.print("<p>ViewerID: ~~" + viewerID + "~~</p>");
//                out.print("<p>ViewerPermiss: ~~" + viewerPermiss + "~~</p>");
//
//                out.print("<ul>");
//                for (int i = 0; i < result.length; i++) {
//                    out.print("<li>Index " + i + ": " + result[i] + "</li>");
//                }
//                out.print("</ul>");
//
//                out.print("</div>");
//
//            %>


            <div class="w3-container">
                <!-- Title -->
                <%                    // Title if viewer is an account holder or suspended
                    if (viewerPermiss == 0 || viewerPermiss == 1) {
                %>
                <h1>Welcome <%out.print(result[0]);%>!</h1>
                <%
                } else if (viewerPermiss == 2 || viewerPermiss == 3) {
                    if (viewerID.equals(acctID)) {%>

                <h1>Welcome <%out.print(result[0]);%>!</h1>


                <%} else {
                %>
                <h1>Account #<%out.print(acctID);%>.</h1>
                <%
                        }
                    }
                %>
            </div>



            <div class="w3-row">
                <div class="w3-col m6">

                    <%
                        if (result[4] != null && result[4].equals(
                                "0")) {
                    %>
                    <div class="w3-container w3-card w3-red">
                        <h2><strong>ALERT</strong></h2>
                        <p><strong>Account <%out.print(acctID);%> for <%out.print(result[0] + " " + result[1]);%> is currently suspended! Contact the support desk for help.</strong></p>
                    </div>
                    <%
                        }
                    %>

                    <!-- Info -->

                    <div class="w3-container">
                        <table class="w3-table">
                            <%
                                if ((viewerPermiss == 2 || viewerPermiss == 3) && !viewerID.equals(acctID)) {
                            %>
                            <tr><td>First Name:</td><td><%out.print(result[0]);%></td></tr>
                            <tr><td>Last Name:</td><td><%out.print(result[1]);%></td></tr>
                            <tr><td>Username:</td><td><%out.print(result[6]);%></td></tr>
                            <%
                                }
                            %>
                            <tr><td>Email:</td><td><%out.print(result[2]);%></td></tr>
                            <tr><td>Phone:</td><td><%out.print(result[3]);%></td></tr>
                        </table>
                        <div class="w3-margin"></div>
                        <form class="w3-container" action="modifyAccountInfo.jsp">
                               <input type='submit' value='Edit' class='w3-button w3-teal' name='<% out.print(
                                           "E" + acctID); %>'/>
                        </form>
                        <div class="w3-margin"></div>

                        <%
                            if (viewerPermiss == 3) {
                        %>
                        <div class="w3-margin">
                            <a class="w3-button w3-teal" href="adminDashboard.jsp">Admin Dashboard</a>
                        </div>
                        <%
                            }
                        %>
                    </div>




                </div>
                <div class="w3-col m6">
                    <!-- Ledgers -->
                    <!-- Account Tables-->
                    <div class="w3-container">
                        <%
                            int i = 0;
                            String[] ledgers;
                        %>

                        <!-- Checking ledgers -->
                        <%
                            ledgers = dbconnect.queryDBdump("SELECT CheckingID FROM checking WHERE AcctID = ?;", acctID);
                            for (i = 0; i < ledgers.length; i++) {
                        %>
                        <div class="w3-card">
                            <%
                                out.print(dbconnect.ledgerWidget(ledgers[i], "checking", viewerPermiss));
                            %>
                        </div>
                        <div class="w3-margin"></div>
                        <%
                            }
                        %>

                        <!-- Savings Ledgers -->
                        <%
                            ledgers = dbconnect.queryDBdump("SELECT SavingsID FROM savings WHERE AcctID = ?;", acctID);
                            for (i = 0; i < ledgers.length; i++) {
                        %>
                        <div class="w3-card"><%
                            out.print(dbconnect.ledgerWidget(ledgers[i], "savings", viewerPermiss));
                            %>
                        </div>
                        <div class="w3-margin"></div>
                        <%
                            }
                        %>

                        <!-- Credit ledgers -->
                        <%
                            ledgers = dbconnect.queryDBdump("SELECT CreditID FROM credit WHERE AcctID = ?;", acctID);
                            for (i = 0; i < ledgers.length; i++) {
                        %>
                        <div class="w3-card">
                            <%
                                out.print(dbconnect.ledgerWidget(ledgers[i], "credit", viewerPermiss));
                            %>
                        </div>
                        <div class="w3-margin"></div>

                        <%
                            }
                        %>

                        <!-- Loan Ledgers -->
                        <%
                            ledgers = dbconnect.queryDBdump("SELECT LoanID FROM loans WHERE AcctID = ?;", acctID);
                            for (i = 0; i < ledgers.length; i++) {
                        %>
                        <div class="w3-card">
                            <%
                                out.print(dbconnect.ledgerWidget(ledgers[i], "loan", viewerPermiss));
                            %>
                        </div>
                        <div class="w3-margin"></div>
                        <%
                            }
                        %>


                    </div>
                    <!-- END Account Tables -->

                    <div class="w3-margin"></div>
                    <form class="w3-container" action="ledgerRequest.jsp">
                        <input type="hidden" value="<%out.print(acctID);%>" name="acctID">
                        <input class="w3-button w3-teal" type="submit" value="Request Ledger" name="">
                    </form>
                </div>

            </div>
        </div>


    </body>
</html>