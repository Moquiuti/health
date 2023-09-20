//	JS para la cabecera
//	Ultima revisión: 3set21 12:00 Cabecera_030921.js

	
var SubmenuActual;
var DominioMVM='http://www.newco.dev.br/';

function globalEvents()
{

	//	Marcamos la primera opción de menú
	if (Accion=='NUEVOPEDIDO')
		jQuery("#MENU_1006 a").attr('class', 'MenuActivo');
	else
		jQuery("#MENU_1 a").attr('class', 'MenuActivo');

	//	Cambios de color al pulsar una opción de menú
 	jQuery(".MenuInicial a").click(function()
	{
		jQuery(".MenuInicial a").attr('class', 'MenuInactivo');
		jQuery(this).attr('class', 'MenuActivo');
     });


	//	Comprobaremos la cookie al entrar
	CompruebaCookie();
	
	//	y cada 1 minuto
	//3set21 setInterval('CompruebaCookie()',60000);
	setInterval('CompruebaSesion()',900000);					//	comprobar cada 15 minutos

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
	}
	else
		if (existeFrame('Trabajo'))
		{
			window.parent.mainFrame.Trabajo.print();	
		}
		else
		{
			window.parent.mainFrame.print();	
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

//	Comprueba que todavía existe la cookie, si no, sale de la página
function CompruebaSesion()
{
	var IDSesion=getCookie2('SES_ID');
	//console.log('CompruebaSesion:'+IDSesion);	
	
    jQuery.ajax({
            url: 'http://www.newco.dev.br/MenusYDerechos/CompruebaSesionAJAX.xsql',
            data: "IDSESION="+IDSesion,
            type: "POST",
            contentType: "application/xhtml+xml",
            beforeSend: function(){
                    null;
            },
            error: function(objeto, quepaso, otroobj){
                    alert('error'+quepaso+' '+otroobj+''+objeto);
            },
            success: function(objeto){
                    var data = eval("(" + objeto + ")");
                    //console.log('CompruebaSesion:'+IDSesion+' res:'+objeto);	

                    if(data.Sesion !== 'OK')
                    	CerrarSesion();
                    //else
                    //	console.log('CompruebaSesion:'+IDSesion+' Sesion OK');	
            }
    });


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
