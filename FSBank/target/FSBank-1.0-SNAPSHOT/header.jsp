<%-- 
    Document   : public header
    Created on : Mar 10, 2021, 12:03:01 PM
    Author     : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>FS BANK</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="FSBank.css">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-black.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

  </head>
  <body>

    <div class="w3-top">
      <div class="w3-bar w3-theme-d2 w3-left-align">
        <a class="w3-bar-item w3-button w3-hide-medium w3-hide-large w3-right w3-hover-white w3-theme-d2" href="javascript:void(0);" onclick="openNav()"><i class="fa fa-bars"></i></a>
        <a href="index.jsp" class="w3-bar-item w3-button w3-teal"><i class="fa fa-home w3-margin-right"></i>FSB</a>
        <a href="#team" class="w3-bar-item w3-button w3-hide-small w3-hover-white">Team</a>
        <a href="#work" class="w3-bar-item w3-button w3-hide-small w3-hover-white">Work</a>
        <a href="#account" class="w3-bar-item w3-button w3-hide-small w3-hover-white">Account</a>
        <a href="#contact" class="w3-bar-item w3-button w3-hide-small w3-hover-white">Contact</a>
        <div class="w3-dropdown-hover w3-hide-small">
          <button class="w3-button" title="Notifications">Sign UP <i class="fa fa-caret-down"></i></button>     
          <div class="w3-dropdown-content w3-card-4 w3-bar-block">
            <a href="accountRequest.jsp" class="w3-bar-item w3-button">Apply for Account!</a>
          </div>
        </div>
        <a href="adminDashboard.jsp" class="w3-bar-item w3-button w3-hide-small w3-hover-white">Admin Home</a>
        <a href="#" class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-teal" title="Search"><i class="fa fa-search"></i></a>
        <a href="login.jsp" class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-teal" title="Login">Log in</a>
      </div>

      <!-- Navbar on small screens -->
      <div id="navDemo" class="w3-bar-block w3-theme-d2 w3-hide w3-hide-large w3-hide-medium">
        <a href="#team" class="w3-bar-item w3-button">Team</a>
        <a href="#work" class="w3-bar-item w3-button">Work</a>
        <a href="#account" class="w3-bar-item w3-button">account</a>
        <a href="#contact" class="w3-bar-item w3-button">Contact</a>
        <a href="#" class="w3-bar-item w3-button">Search</a>
      </div>
    </div>
    
    <div class="w3-panel "></div>
    
  </body>
</html>
