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
            <div class="w3-row">
                <h1>Default Rates:</h1>

                <div class="w3-col m3"><p></p></div>
                <div class="w3-col m6">
                    <%
                        dbConnect dbconnect = new dbConnect();
                        String checkInt = dbconnect.queryDB("SELECT VarFloatValue FROM defaultvalues WHERE VarName = ?;", "FL_CheckingInterest")[0];
                        String saveInt = dbconnect.queryDB("SELECT VarFloatValue FROM defaultvalues WHERE VarName = ?;", "FL_SavingInterest")[0];
                        String creditInt = dbconnect.queryDB("SELECT VarFloatValue FROM defaultvalues WHERE VarName = ?", "FL_CreditAPR")[0];
                        String loanInt = dbconnect.queryDB("SELECT VarFloatValue FROM defaultvalues WHERE VarName = ?", "FL_LoanAPR")[0];
                        try {
                    %>

                    <form action="adminModifyInterest.jsp">
                        <table class="w3-table">
                            <tr>
                                <td>Default Checking Account Interest Rate:</td>
                                <td><% out.print(Float.parseFloat(checkInt) * 100); %>%</td>
                                <td><input type="submit" class="w3-button w3-teal" value="Modify" name="gChIntr"></td>
                            </tr>
                            <tr>
                                <td>Default Savings Account Interest Rate:</td>
                                <td><% out.print(Float.parseFloat(saveInt) * 100);%>%</td>
                                <td><input type="submit" class="w3-button w3-teal" value="Modify" name="gSaIntr"></td>
                            </tr>
                            <tr>
                                <td>Default Credit Account APR:</td>
                                <td><% out.print(Float.parseFloat(creditInt) * 100);%>%</td>
                                <td><input type="submit" class="w3-button w3-teal" value="Modify" name="gCrIntr"></td>
                            </tr>
                            <tr>
                                <td>Default Loan APR:</td>
                                <td><% out.print(Float.parseFloat(loanInt) * 100);%>%</td>
                                <td><input type="submit" class="w3-button w3-teal" value="Modify" name="gLoIntr"></td>
                            </tr>
                        </table> 

                    </form>

                    <%
                    } catch (Exception e) { %>
                    <div class="w3-container">
                        <%
                            out.print("<h2>ERROR:" + checkInt + " -- " + saveInt + " -- " + creditInt + " -- " + loanInt + "</h2>");
                            out.print("<p>" + e.getMessage() + "</p>");
                        %>
                    </div>
                    <%
                        }
                    %>
                </div>

            </div>
            <div class="w3-margin"></div>
            <div class="w3-container"><a href="adminDashboard.jsp" class="w3-button w3-teal">Return to Dashboard</a></div>

        </div>
    </body>
</html>
