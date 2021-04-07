<%-- 
    Document   : registerAction
    Created on : Mar 14, 2021, 8:10:39 PM
    Author     : odogbe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="myBeans.DBConnect"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
  </head>
  <body>
    <%
      String firstname = request.getParameter("firstname");
      String lastname = request.getParameter("lastname");
      String email= request.getParameter("email");
      String password = request.getParameter("password");
      String address = request.getParameter("address");
      String city = request.getParameter("city");
      String state = request.getParameter("state");
      String phone = request.getParameter("phone");
      String security = request.getParameter("security");
      String answer = request.getParameter("answer");
      String accounttype = request.getParameter("accounttype");
      String sql = "insert into customer values (0, '" + firstname + "', '" + lastname + "', '"
              + email + "', '" + password + "', '" + address + "', '" + city + "', '" + state + "', '" 
              + phone + "', '" + security + "','" + answer + "', '" + accounttype + "')";
      dbConnect dbConnect = new dbConnect();
      String err = dbConnect.insertData(sql);
      if (err.equals("Closed"))
        response.sendRedirect("index.jsp");
      else       
    %>
    <script>alert("<%= err %>")</script>
    </form>
  </body>
</html>
