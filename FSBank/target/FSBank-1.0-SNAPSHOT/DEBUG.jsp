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

            <div class="w3-row">
                <div class="w3-col m4">
                    <form class="w3-form" action="holderDashboard.jsp">
                        <label>Account Holder dashboard to View:</label>
                        <input class="w3-input" type="text" name="Account" value="0" size="20" />
                        <input type="submit" value="Go" class="w3-button w3-teal w3-margin"/>
                    </form>
                </div>
            </div>
        </div>


    </body>
</html>
