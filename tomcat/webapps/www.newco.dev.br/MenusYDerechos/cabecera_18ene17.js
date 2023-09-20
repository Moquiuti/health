// JavaScript Document
// Revisado ET 18ago16 11:38
// Revisado PS 17nov16 09:26
//	Ultima revisión: 9feb17 11:03

//js de cabeceraHTML.xsl

	
var SubmenuActual;

function globalEvents()
{

	//	Marcamos la primera opción de menú
	jQuery("#MENU_1 a").css('background','#3b569b');
	jQuery("#MENU_1 a").css('color','#D6D6D6');

	//	Cambios de color al pulsar una opción de menú
 	jQuery(".MenuInicial a").click(function()
	{
		jQuery(".MenuInicial a").css('background','#d6d6d6');
		jQuery(".MenuInicial a").css('color','#555555');
		jQuery(this).css('background','#3b569b');
		jQuery(this).css('color','#D6D6D6');
     });


	//	Comprobaremos la cookie al entrar
	CompruebaCookie();
	
	//	y cada 1 minuto
	setInterval('CompruebaCookie()',60000);

}

//	Muestra las opciones de un submenu
function SubMenu(ID)
{

	SubmenuActual=ID;

	jQuery("#MENU_INICIAL").hide();
	jQuery("#SUBMENU_"+ID).show();

}

//	Sale del submenu volviendo al menú principal
function SalirSubmenu()
{
	jQuery("#SUBMENU_"+SubmenuActual).hide();
	jQuery("#MENU_INICIAL").show();

	//	Marcamos la primera opción de menú
	jQuery("#MENU_1 a").css('background','#3b569b');
	jQuery("#MENU_1 a").css('color','#D6D6D6');

	window.open('http://www.newco.dev.br/Personal/BandejaTrabajo/WFStatus.xsql','mainFrame');
}


//	Imprime el frame interno (hay que tener cuidado pues puede tener nombres diferentes
function imprimir()
{
	//PresentaFrames();
	if (existeFrame('areaTrabajo'))
	{
		window.parent.mainFrame.areaTrabajo.print();	
		//window.print();	
	}
	else
		if (existeFrame('Trabajo'))
		{
			window.parent.mainFrame.Trabajo.print();	
			//window.print();	
		}
		else
		{
			window.parent.mainFrame.print();	
			//window.print();	
		}
}

function getCookie2(name){
	var cookies = document.cookie.split(';');
	for(var i=0; i<cookies.length; i++){
		cookie = cookies[i].split('=');
		if(jQuery.trim(cookie[0]) == jQuery.trim(name)){
			if(cookie.length==2)
				return jQuery.trim(cookie[1]);
			else
				return '';
		}
	}
	return '';
}

//	Comprueba que todavía existe la cookie, si no, sale de la página
function CompruebaCookie()
{
	var IDSesion=getCookie2('SES_ID');
	//console.log('SES_ID:'+IDSesion);
	
	if (IDSesion=='') VuelveAInicio();
}


//	Cierra la sesión, vuelve a la página de inicio
function CerrarSesion(){
    	
    //caduco cookie cuando cierro sesion
    if(getCookie2('SES_ID')!='')
    	document.cookie = 'SES_ID=; path=/; host=' + location.hostname + ';expires=Thu, 01 Jan 1970 00:00:01 GMT';
    if(getCookie2('US_ID')!='')
    	document.cookie = 'US_ID=; path=/; host=' + location.hostname + ';expires=Thu, 01 Jan 1970 00:00:01 GMT';

    //	19dic16	Volvemos a la página de inicio
    VuelveAInicio();
       
}

//	Cuidado, la página de inicio puede depender del portal
function VuelveAInicio()
{
    window.parent.location.href=jQuery("#URLSALIDA").val();
}
