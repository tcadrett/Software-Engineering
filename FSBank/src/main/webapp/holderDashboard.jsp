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
        <%@ include file="header.jsp" %>
    </head>
    <body id="myPage">
        
        <%
            dbConnect dbconnect = new dbConnect();
            
            int acct = Integer.parseInt(request.getParameter("Account"));
            
            

        %>
        
        <div class="w3-contaixner w3-padding 32">
            
        </div>
        
        <jsp:include page="widgetLedgerCard.jsp">
            <jsp:param name="Test" value= "TESTTEXT"/>
        </jsp:include>
        
    </body>
</html>
