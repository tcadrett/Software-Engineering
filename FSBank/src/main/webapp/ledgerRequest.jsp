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

            %>


            <div class="w3-row">


                <div class="w3-col m3"><div class="w3-margin"></div></div>
                <div class="w3-col m6">

                    <h1>Apply for new ledger
                        <%                            if ((viewerPermiss == 2 || viewerPermiss == 3) && !viewerID.equals(acctID)) {
                                out.print(" for " + result[0] + " " + result[1]);
                            }
                        %>
                    </h1>


                    <div class="w3-card">
                        <div class="w3-container">

                            <div class="w3-margin"></div>
                            <form class="w3-form" action="ledgerRequestAction.jsp">
                                <label>Ledger Type</label>
                                <select class="w3-select" name="ledgerType">
                                    <option value="c">Checking Account</option>
                                    <option value="s">Savings Account</option>
                                    <option value="r">Credit Card</option>
                                    <option value="l">Loan</option>
                                </select>
                                <input type="hidden" name="acctID" value="<%out.print(acctID);%>"/>
                                <div class="w3-margin"></div>
                                <input type="submit" class="w3-button w3-teal" value="Apply" name="Apply" />
                            </form>
                            <div class="w3-margin"></div>

                        </div>
                    </div>
                </div>
            </div>

        </div>
    </body>
</html>
