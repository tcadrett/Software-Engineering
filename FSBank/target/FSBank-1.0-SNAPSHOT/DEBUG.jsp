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
            <h1>Debug Page</h1>

            <%
                dbConnect dbconnect = new dbConnect();
                String acctID = "";
                String newAcctID = "";
                if (session.getAttribute("acctID") == null) {
                    out.print("<p>AcctID is null. No user is signed in.</p>");
                    acctID = "NULL";
                    session.setAttribute("acctID", "-1");
                } else {
                    acctID = session.getAttribute("acctID").toString();
                }

                if (!acctID.equals("NULL") && !acctID.equals(newAcctID)) {
                    acctID = newAcctID;
                    session.setAttribute("acctID", acctID);
                }

                String acctType = dbconnect.queryDB("SELECT AcctType FROM accounts WHERE AcctID = ?;", "1")[0];
//                String acctType[] = {""};
//                if(!acctID.equals("NULL")){
//                    acctType = dbconnect.queryDB("");
//                }
//                String acctType[] = {""};
//                if (!acctID.equals(null)) {
//                    acctType = dbconnect.queryDB("SELECT AcctType FROM accounts WHERE AcctID = ?;", acctID);
//                }
//                
//                String userAcct = "";
//                userAcct = request.getParameter("AcctID");
//                if (!userAcct.isEmpty()) {
//                    session.setAttribute("acctID", userAcct);
//            %>


            <div class="w3-row">
                <div class="w3-col m4">
                    <%
                        switch (acctType[0].charAt(0)) {
                            case '1':
                    %>
                    <form action="accountDetails.jsp">
                        <input type="submit" class="w3-button w3-teal" value="Holder Dashboard" name="A<%out.print(acctID);%>"/>
                    </form>
                    <%
                            break;
                        case '2':
                    %>
                    <%
                            break;
                        case '3':
                    %>
                    <a href="adminDashboard.jsp" class="w3-button w3-teal">Admin Dashboard</a>
                    <%
                                break;
                            default:
                                out.print("<p>Invalid account type</p>");
                                break;
                        }
                    %>
                </div>
            </div>


            <div class="w3-row">

                <div class="w3-col-m4">
                    <h2>Current signed in account is <%out.print(acctID);%>.</h2>
                </div>

                <div class="w3-col m4">
                    <form class="w3-form" action="DEBUG.jsp">
                        <label>Sign is as account #</label>
                        <input class="w3-input" type ="text" name="AcctID" value="<%out.print(acctID);%>" size="20" />
                        <input type="submit" value="Go" class="w3-button w3-teal w3-margin"/>
                    </form>
                </div>
            </div>

    </body>
</html>
