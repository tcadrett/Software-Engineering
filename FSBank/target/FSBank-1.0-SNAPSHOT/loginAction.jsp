<%-- 
    Document   : loginAction
    Created on : Mar 14, 2021, 8:07:13 PM
    Author     : guada
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="myBeans.dbConnect, java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>loginaction</title>
  </head>
  <body>
    <%
      dbConnect dbconnect = new dbConnect();
      String id = request.getParameter("id");
      String password = request.getParameter("password");
      String sql = "select FName, LName, usertype from accounts where id = ? and password = ?";

      String[] result = dbconnect.isPwdValid(sql, id, password);

      if (result[0].length() >= 6 && result[0].substring(0, 6).equals("Error:")) {
        session.setAttribute("logged", "index");
        response.sendRedirect("index.jsp?error='" + result[0] + "'");
      } else {
        String name = " " + result[0] + " " + result[1];
        String usertype = result[2];
        session.setAttribute("logged", name);
        if (usertype.equals("staff")) {
          response.sendRedirect("staffDashboard.jsp");
        } else if (usertype.equals("admin")) {
          response.sendRedirect("adminDashboard.jsp");
        }
      }
    %>
  </body>
</html>