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
            <h1>Ledger Request</h1>

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
            %>
        </div>
    </body>
</html>
