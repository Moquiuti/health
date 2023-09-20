//	JS para la cabecera. Version disenno 2022:
//	JQuery 3.6
//	Cambia la gestion de menus.
//	Ultima revisi�n: 12dic22 16:00 Cabecera2022_121222.js

	
var SubmenuActual;
var DominioMVM='http://www.newco.dev.br/';

function bodyLoad()
{

	//	Comprobaremos la cookie al entrar
	//12dic22 CompruebaCookie();
		
	//	y cada 1 minuto
	//3set21 setInterval('CompruebaCookie()',60000);
	setInterval('CompruebaSesion()',900000);					//	comprobar cada 15 minutos

	//solodebug	console.log('bodyLoad. Final.');
}

//	Muestra las opciones de un submenu
function SubMenu(ID)
{

	SubmenuActual=ID;

	jQuery(".principal").hide();
	jQuery(".submenu_"+ID).show();

}

//	Sale del submenu volviendo al men� principal
function SalirSubmenu()
{
	jQuery(".submenu_"+SubmenuActual).hide();
	jQuery(".principal").show();

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


