
function InicializarCookies(){
	// Inicializamos cookie SESS_ID
	setCookie('SES_ID',cookieSESSID);
	// Inicializamos cookie US_ID
	setCookie('US_ID',cookieUSID);
	// Inicializamos cookie IDIOMA
	setCookie('LANG',cookieIdioma);
}

//function setCookie(nombre,valor,time){
function setCookie(nombre,valor){
	// Asignamos la cookie... Caducidad de la cookie 'At end of session'
	document.cookie = nombre+ "=" + encodeURIComponent(valor) + '; path=/; host=' + location.hostname + ';';
}