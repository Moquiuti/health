//	JS para la cabecera. Version disenno 2022:
//	JQuery 3.
//	Cambia la gestion de menus.
//	Ultima revisi�n: 12ene22 11:00 Cabecera2022_120122.js

	
var SubmenuActual;
var DominioMVM='http://www.newco.dev.br/';

function bodyLoad()
{
	//solodebug	console.log('bodyLoad. Inicio');

	/*
	//	Marcamos la primera opci�n de men�
	if (Accion=='NUEVOPEDIDO')
		jQuery("#MENU_1006 a").attr('class', 'MenuActivo');
	else if (Accion=='EIS')
		jQuery("#MENU_6999 a").attr('class', 'MenuActivo');
	else
		jQuery("#MENU_1 a").attr('class', 'MenuActivo');

	//	Cambios de color al pulsar una opci�n de men�
 	jQuery(".MenuInicial a").click(function()
	{
		jQuery(".MenuInicial a").attr('class', 'MenuInactivo');
		jQuery(this).attr('class', 'MenuActivo');
     });
	 */


	//	Comprobaremos la cookie al entrar
	CompruebaCookie();
		
	//	y cada 1 minuto
	//3set21 setInterval('CompruebaCookie()',60000);
	setInterval('CompruebaSesion()',900000);					//	comprobar cada 15 minutos

	//solodebug	console.log('bodyLoad. Final.');
}

//	Muestra las opciones de un submenu
function SubMenu(ID)
{

	SubmenuActual=ID;

	//jQuery("#MENU_INICIAL").hide();
	//jQuery("#SUBMENU_"+ID).show();
	jQuery(".principal").hide();
	jQuery(".submenu_"+ID).show();

}

//	Sale del submenu volviendo al men� principal
function SalirSubmenu()
{
	//jQuery("#SUBMENU_"+SubmenuActual).hide();
	//jQuery("#MENU_INICIAL").show();
	jQuery(".submenu_"+SubmenuActual).hide();
	jQuery(".principal").show();

	//	Marcamos la primera opci�n de men�
	//jQuery("#MENU_1 a").attr('class', 'activo');

	window.open(DominioMVM+"Personal/BandejaTrabajo/WFStatus2022.xsql",'mainFrame');
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

//	Comprueba que todav�a existe la cookie, si no, sale de la p�gina
function CompruebaCookie()
{
	var IDSesion=getCookie2('SES_ID');
	//console.log('SES_ID:'+IDSesion);
	
	if (IDSesion=='') VuelveAInicio();
}

//	Comprueba que todav�a existe la cookie, si no, sale de la p�gina
function CompruebaSesion()
{
	var IDSesion=getCookie2('SES_ID');
	
	console.log('CompruebaSesion:'+IDSesion);	
	
    jQuery.ajax({
            url: DominioMVM+"MenusYDerechos/CompruebaSesionAJAX.xsql",
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
                    console.log('CompruebaSesion:'+IDSesion+' res:'+objeto);	

                    if(data.Sesion !== 'OK')
                    	CerrarSesion();
                    //else
                    //	console.log('CompruebaSesion:'+IDSesion+' Sesion OK');	
            }
    });


}


//	Cierra la sesi�n, vuelve a la p�gina de inicio
function CerrarSesion(){
    	
    //caduco cookie cuando cierro sesion
    if(getCookie2('SES_ID')!='')
    	document.cookie = 'SES_ID=; path=/;sameSite=Lax; host=' + location.hostname + ';expires=Thu, 01 Jan 1970 00:00:01 GMT';
    if(getCookie2('US_ID')!='')
    	document.cookie = 'US_ID=; path=/;sameSite=Lax; host=' + location.hostname + ';expires=Thu, 01 Jan 1970 00:00:01 GMT';

    //	19dic16	Volvemos a la p�gina de inicio
    VuelveAInicio();
       
}

//	Cuidado, la p�gina de inicio puede depender del portal
function VuelveAInicio()
{
	if (jQuery("#URLSALIDA").val()!='')
	    window.parent.location.href=jQuery("#URLSALIDA").val();
	else
	    window.parent.location.href=DominioMVM;
    //document.location.href=jQuery("#URLSALIDA").val();
}


//	Cambiar la clave del usuario
function CambiarClave()
{
	window.open(DominioMVM+"Personal/CambioClave/CambioClave2022.xsql",'mainFrame');
}


