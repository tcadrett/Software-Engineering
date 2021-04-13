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

                // new interest rate
                float newInterestFL = Float.parseFloat(request.getParameter("interest")) / 100;
                String newInterest = String.valueOf(newInterestFL);
                // parameters for updating database value
                String table = request.getParameter("table");
                String column = request.getParameter("column");
                String condColumn = request.getParameter("tableIDCol");
                String condTest = request.getParameter("legID");
                String titleType = request.getParameter("titleType");
                String originPage = request.getParameter("originPage");

                String sql = "UPDATE " + table + " SET " + column + " = ? WHERE " + condColumn + " = ?;";
                String output = dbconnect.updateDB(sql, newInterest, condTest);

                if (output.equals("CLOSED")) { %>
            <h1><%out.print(titleType);%> Modified:</h1>
            <p>New value: <%out.print(Float.parseFloat(newInterest) * 100);%>%</p>

            <%} else {%>
            <h1>Unable to update database:</h1>
            <p><%out.print(output);%></p>

            <%}

            %>


            <%                /*
                //DEBUG: Print working values
                out.print("<p>newInterest: " + newInterest + "</p>");
                out.print("<p>table: " + table + "</p>");
                out.print("<p>column: " + column + "</p>");
                out.print("<p>condColumn: " + condColumn + "</p>");
                out.print("<p>condTest: " + condTest + "</p>");
                out.print("<p>TitleType: " + titleType + "</p>");
                out.print("<p>OriginPage: " + originPage + "</p>");
                 */
            %>



            <!-- return button based on route to adminModifyInterest.jsp -->
            <div class="w3-margin"></div>
            <%                if (originPage.equals("g")) {
            %>
            <div class="w3-container"><a href="adminViewGlobalInterest.jsp" class="w3-button w3-teal">Return to Global interest</a></div>
            <%
            } else if (originPage.equals("a")) { // TODO: implement path from accountDetails
            %>
            <div class="w3-container"><a href="adminViewAccounts.jsp" class="w3-button w3-teal">Return to Account Information</a></div>
            <%
            } else {
            %>
            <div class="w3-container"><a href="adminDashboard.jsp" class="w3-button w3-teal">Return to Dashboard</a></div>
            <%
                }
            %>

        </div>
    </body>
</html>
