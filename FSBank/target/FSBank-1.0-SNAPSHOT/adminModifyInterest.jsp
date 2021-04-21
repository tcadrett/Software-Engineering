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

                // decode query type and contents
                String query = request.getQueryString();
                String legType = query.substring(1, 3); // 2-character ledger type code
                String legID = ""; // ledgerID (or global variable) to update

                String table = ""; // table affected
                String column = ""; // column affected
                String tableIDCol = ""; // column to select by
                String priorRate = ""; // previous rate

                String titleType = "";
                String originPage = query.substring(0, 1);
                String sql = "";

                // ID scope of interest change
                char scope = query.charAt(0);
                switch (scope) {
                    case 'g':
                        // TODO: FIX THIS
                        // had to hardcode sql statement...
                        //table = "defaultvalues";
                        //column = "VarFloatValue";
                        //tableIDCol = "VarName";

                        table = "defaultvalues";
                        column = "VarFloatValue";
                        tableIDCol = "VarName";
                        // fetch prior interest rate from appropriate table and unique entry.
                        sql = "SELECT VarFloatValue FROM defaultvalues WHERE VarName = ?;";
                        if (legType.equals("Ch")) {
                            legID = "FL_CheckingInterest";
                            priorRate = dbconnect.queryDB(sql, legID)[0];
                            titleType = "Default Checking Interest";
                        } else if (legType.equals("Sa")) {
                            legID = "FL_SavingInterest";
                            priorRate = dbconnect.queryDB(sql, legID)[0];
                            titleType = "Default Savings Interest";
                        } else if (legType.equals("Cr")) {
                            legID = "FL_CreditAPR";
                            priorRate = dbconnect.queryDB(sql, legID)[0];
                            titleType = "Default Credit APR";
                        } else if (legType.equals("Lo")) {
                            legID = "FL_LoanAPR";
                            priorRate = dbconnect.queryDB(sql, legID)[0];
                            titleType = "Default Loan APR";
                        }
                        break;
                    case 'a':
                        legID = query.substring(7, query.length() - 7);
                        // insert form for account-based change
                        if (legType.equals("Ch")) {
                            table = "checking";
                            column = "interest";
                            tableIDCol = "CheckingID";
                            titleType = "Checking Interest for Ledger " + legID;
                        } else if (legType.equals("Sa")) {
                            table = "savings";
                            column = "interest";
                            tableIDCol = "SavingsID";
                            titleType = "Savings Interest for Ledger " + legID;
                        } else if (legType.equals("Cr")) {
                            table = "credit";
                            column = "APR";
                            tableIDCol = "CreditID";
                            titleType = "Credit APR for Ledger " + legID;
                        } else if (legType.equals("Lo")) {
                            table = "loans";
                            column = "APR";
                            tableIDCol = "LoanID";
                            titleType = "Loan APR for Ledger " + legID;
                        } else {

                        }
                        // fetch prior interest rate from appropriate table and unique entry.
                        sql = "SELECT " + column + " FROM " + table + " WHERE " + tableIDCol + " = ?;";
                        priorRate = dbconnect.queryDB(sql, legID)[0];
                        break;
                    default:
                        break;
                }

            %>


            <%  /*
                //DEBUG
                out.print("<h1>DEBUG: <br />" + query + "</h1>");
                out.print("<p>Table: " + table + "</p>");
                out.print("<p>Column: " + column + "</p>");
                out.print("<p>ID Column:" + tableIDCol + "</p>");
                out.print("<p>LedgerType:" + legType + "</p>");
                out.print("<p>ID:" + legID + "</p>");
                out.print("<p>Prior Rate:" + priorRate + "</p>");
                out.print("<p>SQL: " + "SELECT '" + column + "' FROM '" + table + "' WHERE '" + tableIDCol + "' = '" + legID + "';</p>");
                 */
            %>

            <div class="w3-row">
                <div class="w3-col m3"><p></p></div>
                <div class="w3-col m6">
                    <div class="w3-margin"></div>
                    <div class="w3-container w3-card">
                        <h1>Modify <% out.print(titleType);%> Rate</h1>
                        <form action="adminModifyInterestAction.jsp">
                            <label>Value (%)</label>
                            <input class="w3-input" type="text" required name="interest" value="<% out.print(Float.parseFloat(priorRate) * 100);%>">
                            <hr />
                            <input type="submit" value="Submit" class="w3-button w3-teal" name="interSubmit">
                            <input type="hidden" name="column" value="<%out.print(column);%>">
                            <input type="hidden" name="table" value="<%out.print(table);%>">
                            <input type="hidden" name="tableIDCol" value="<%out.print(tableIDCol);%>">
                            <input type="hidden" name="legID" value="<%out.print(legID);%>">
                            <input type="hidden" name="titleType" value="<%out.print(titleType);%>">
                            <input type="hidden" name="originPage" value="<%out.print(originPage);%>">

                            <div class="w3-margin"></div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="w3-margin"></div>
            <div class="w3-container"><a href="adminDashboard.jsp" class="w3-button w3-teal">Return to Dashboard</a></div>




        </div>
    </body>
</html>




<!--  Form Template
            <div class="w3-col m3"><p></p></div>
            <div class="w3-col m6">
                <div class="w3-container w3-card">
                    <h1>Modify Interest Rate</h1>
                    <form action="adminModifyInterestAction.jsp">
                        <label>Value</label>
                        <input class="w3-input" type="text" required name="in">
                        <hr />
                        <input type="submit" value="Submit" class="w3-button w3-teal" name="interSubmit">
                        <div class="w3-margin"></div>
                    </form>
                </div>
            </div>
-->