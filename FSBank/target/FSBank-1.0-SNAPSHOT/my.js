/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function validatepassword() {
  var pwd = document.register.password.value;
  var pwd2 = document.register.password2.value;

  if (!pwd.equals(pwd2)) {
    document.getElementById("password2").setCustomValidity("Passwords do not match");
  } else {
    document.getElementById("password2").setCustomValidity("");
  }
}

function validate() {
  var pwd = document.register.password.value;
  if((pwd.length >= 8) && (pwd.search(/(@|#|$)/) >= 0)){
    document.password.submit();}
  else if(pwd.search(/[a-z]/) < 0){
      alert("Your password needs a lower case letter");
  }
  else if(pwd.search(/[A-Z]/) < 0){
      alert("Your password needs a upper case letter");
  }
  else if(pwd.search(/[0-9]/) <0){
      alert("Your password needs a number");
  }
  else {
    alert("");

    document.getElementById("password").innerHTML = "Your password is missing special chars and atleast 8 letters ";
    return;
  }
}