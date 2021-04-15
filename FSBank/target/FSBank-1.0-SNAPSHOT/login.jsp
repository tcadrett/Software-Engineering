<%-- 
    Document   : login
    Created on : Mar 14, 2021, 8:17:10 PM
    Author     : guada
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %> 
<!DOCTYPE html>
<html>
  <title>Login</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <script src="my.js">Please enable JavaScript in your browser</script>

   <% // session control
        String logged = (String) session.getAttribute("logged");
        String name = (String) session.getAttribute("name");
     %>  
  
  <body>
    <div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:600px">

      <div class="w3-center"><br>
        <span onclick="document.getElementById('id01').style.display = 'none'" class="w3-button w3-xlarge w3-transparent w3-display-topright" title="Close Modal">×</span>
        <img src="image/login.png" alt="Avatar" style="width:30%" class="w3-circle w3-margin-top">
      </div>

      <form class="w3-container" name="login" action="loginAction.jsp" method="post">
        <div class="w3-section">
          <label><b>ID</b></label>
          <input class="w3-input w3-border w3-margin-bottom" type="text" placeholder="Enter ID" name="id" required>
          <label><b>Password</b></label>
          <input class="w3-input w3-border" type="password" placeholder="Enter Password" name="password" required size="40">
          <div id="pwd"></div><br>
          <button class="w3-button w3-block w3-green w3-section w3-padding" type="submit">Login</button>
          <input class="w3-check w3-margin-top" type="checkbox" checked="checked"> Remember me

        </div>

      </form>

      <div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
        <button onclick="validate()" type="button" class="w3-button w3-red"
                name="cancel" action="index.jsp"  method="post">Cancel</button>
        <span class="w3-right w3-padding w3-hide-small">Forgot <a href="password">password?</a></span>
      </div>

    </div>
  </div>
</div>

</body>
</html>

