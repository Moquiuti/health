//	JS para la cabecera
//	Ultima revisión: 3feb20 10:15 cabecera_030220.js

	
var SubmenuActual;
var DominioMVM='http://www.newco.dev.br/';

//3feb20	var colActivo='#E6E6E6', colInactivo='#3b569b', colGris='#555555';

function globalEvents()
{

	//	Marcamos la primera opción de menú
	/*
	jQuery("#MENU_1 a").css('background',colInactivo);
	jQuery("#MENU_1 a").css('color',colActivo);
	*/

	jQuery("#MENU_1 a").attr('class', 'MenuActivo');

	//	Cambios de color al pulsar una opción de menú
 	jQuery(".MenuInicial a").click(function()
	{
		/*jQuery(".MenuInicial a").css('background',colActivo);
		jQuery(".MenuInicial a").css('color',colGris);
		jQuery(this).css('background',colInactivo);
		jQuery(this).css('color',colActivo);*/
		
		jQuery(".MenuInicial a").attr('class', 'MenuInactivo');
		jQuery(this).attr('class', 'MenuActivo');
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
	/*jQuery("#MENU_1 a").css('background',colInactivo);
	jQuery("#MENU_1 a").css('color',colActivo);*/

	jQuery("#MENU_1 a").attr('class', 'activo');

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
    	document.cookie = 'SES_ID=; path=/;sameSite=Lax; host=' + location.hostname + ';expires=Thu, 01 Jan 1970 00:00:01 GMT';
    if(getCookie2('US_ID')!='')
    	document.cookie = 'US_ID=; path=/;sameSite=Lax; host=' + location.hostname + ';expires=Thu, 01 Jan 1970 00:00:01 GMT';

    //	19dic16	Volvemos a la página de inicio
    VuelveAInicio();
       
}

//	Cuidado, la página de inicio puede depender del portal
function VuelveAInicio()
{
	if (jQuery("#URLSALIDA").val()!='')
	    window.parent.location.href=jQuery("#URLSALIDA").val();
	else
	    window.parent.location.href=DominioMVM;
    //document.location.href=jQuery("#URLSALIDA").val();
}
