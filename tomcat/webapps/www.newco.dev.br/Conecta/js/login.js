var attempt = 3; // Variable to count number of attempts.
// Below function Executes on click of login button.
function validate(){
var username = document.getElementById("USER").value;
var password = document.getElementById("PASS").value;
if ( username == "Formget" && password == "formget#123"){
alert ("Login successfully");
window.location = "http://www.newco.dev.br/MenusYDerechos/Main2017.xsql"; // Redirecting to other page.
return false;
}
else{
attempt --;// Decrementing by one.
alert("You have left "+attempt+" attempt;");
// Disabling fields after 3 attempts.
if( attempt == 0){
document.getElementById("USER").disabled = true;
document.getElementById("PASS").disabled = true;
document.getElementById("submit").disabled = true;
return false;
}
}
}
