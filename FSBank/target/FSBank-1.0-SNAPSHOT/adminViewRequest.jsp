<%-- 
    Document   : accountRequest
    Created on : Mar 10, 2021, 12:03:01 PM
    Author     : Terri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="myBeans.dbConnect, java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <%@include file="header.jsp" %>

  </head>
  <body>

    <%
      dbConnect dbconnect = new dbConnect();
      //String formValue = request.getParameter("type");
      //String sql = ";
      //String args[] = dbconnect.queryDB(sql, name, type);
      //out.print("Finish added!");
      //session.getAttribute("logged").equals("Admin")
    %>



    <h1>Hello World!</h1>
    
    <div class="w3-container w3-half">
        <table class="w3-table w3-striped">
          <%
            String sql = "SELECT * FROM `accountreq`;";
            out.print(dbconnect.htmlTableQuery(sql, "Head", "", "", "", "","<th>Button</th>","<th>TEST</th>"));
          %>
        </table>
    </div>
        
        
        
  </body>
</html>
