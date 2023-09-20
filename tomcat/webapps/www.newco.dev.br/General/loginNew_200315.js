// JavaScript Document

jQuery.noConflict();
// GLOBAL VARS
var arroba = '@';
//aceptacion de los cookie
var aceptoCookie = GetCookie('ACEPTO_COOKIE');

//----------------------------------------------------------

jQuery(document).ready(globalEvents);

function globalEvents(){
	//usuario acepta cookie y creo cookie de aceptacion
	jQuery('#aceptaCookie').mouseover (function() { this.style.cursor="pointer"; });
	jQuery('#aceptaCookie').click(function(){  jQuery(".avisoCookieBox").css('display','none');
		SetCookieAcepta('ACEPTO_COOKIE','S','365');
		aceptoCookie = GetCookie('ACEPTO_COOKIE');  
	});
}

function SetCookieAcepta(name, value,expires) {
  var fecha = new Date();
  fecha.setTime(fecha.getTime() + (expires*24*60*60*1000));
  document.cookie = name + "=" + escape(value) + 
  ((expires == null) ? "" : "; expires=" + fecha.toGMTString()) + ";host=www.mvmnucleo.com;path=/";	
  /*((path == null) ? "" : "; path=" + path) +
  ((domain == null) ? "" : "; domain=" + domain) +
  ((secure == null) ? "" : "; secure")*/
}


function esPar(numero){
if(numero%2==0)
  return true;
else
  return false;
}



function devolverCaracterPosicion(cadena,n){
return cadena.charAt(n);
}


function montarCadena(cadena){

var variable='';
var i=0;
var j=1;

  for(var n=0;n<cadena.length;n++){
    if(esPar(n)){  
      variable+=devolverCaracterPosicion(cadena,i);
       i++;
    }
    else{ 
      variable+=devolverCaracterPosicion(cadena,cadena.length-j);
       j++;
    }
  }

return variable;
}

function modificar(cadena){
var variable='';
var valor;
for(var n=0;n<cadena.length;n++){
valor=cadena.charCodeAt(n);
  if(valor>=65 && valor<=90){
    //mayusculas
    if(valor<=77){
      variable+=String.fromCharCode(valor+13);
    }
    else{ 
      variable+=String.fromCharCode(valor-13); 
    }
  }
  else{
    if(valor>=97 && valor<=122){
      // minusculas
      if(valor<=109){ 
        variable+=String.fromCharCode(valor+13);
      }
      else{ 
        variable+=String.fromCharCode(valor-13); 
      }
    }
    else{
      if(valor>=48 && valor<=57){
        //numeros
        if(valor<=52){   
          variable+=String.fromCharCode(valor+5);  
        }
        else{  
          variable+=String.fromCharCode(valor-5);  
        }
      }else{
        // se queda igual
        variable+=String.fromCharCode(valor); 
      }
    }
  }
}
return variable;
}

//	Preparar parámetro para login
function PrepararLogin(form)
{
     
	var variableOrigen1;
	var variableOrigen2;
	var variableDestino;
             
        form.elements['USER'].value = quitarEspaciosIzquierda(form.elements['USER'].value);
        form.elements['PASS'].value = quitarEspaciosIzquierda(form.elements['PASS'].value);
        
        form.elements['USER'].value = quitarEspaciosDerecha(form.elements['USER'].value);
        form.elements['PASS'].value = quitarEspaciosDerecha(form.elements['PASS'].value);
        
            variableOrigen1=montarCadena(form.elements['USER'].value);
            variableOrigen2=montarCadena(form.elements['PASS'].value);

            variableDestino=variableOrigen1+'_'+variableOrigen2;
            variableDestino=montarCadena(variableDestino);

            variableDestino=modificar(variableDestino);

            document.forms[0].elements['PARAMETRO'].value=variableDestino;

            SetCookieAcepta('ACEPTO_COOKIE','S','365');
       
            location.reload();
      
}
      
//
//	Esta funciï¿½n abrirï¿½ la ventana de trabajo de MedicalVM maximizada
//	enviando los datos de usuario y clave vï¿½a GET
//

function AbrirVentana(form){
	var user = form.elements['USER'].value;
        var pass = form.elements['PASS'].value;
        //alert(user+' lenght '+user.length);
        //alert(pass+' lenght '+pass.length);
        
        if (user.length >= 3 && pass.length >= 3){
            
            PrepararLogin(form);

            // DC - 08/05/14 - Hacemos caducar las cookies de session, usuario e idioma antes de hacer el login
            if(getCookie2('SES_ID')!='')
                    document.cookie = 'SES_ID=; path=/; host=' + location.hostname + ';expires=Thu, 01 Jan 1970 00:00:01 GMT';
            //if(getCookie2('US_ID')!='')
                    //document.cookie = 'US_ID=; path=/; host=' + location.hostname + ';expires=Thu, 01 Jan 1970 00:00:01 GMT';
            if(getCookie2('LANG')!='')
                    document.cookie = 'LANG=; path=/; host=' + location.hostname + ';expires=Thu, 01 Jan 1970 00:00:01 GMT';
            if(getCookie2('STYLE')!='')
                    document.cookie = 'STYLE=; path=/; host=' + location.hostname + ';expires=Thu, 01 Jan 1970 00:00:01 GMT';

            SetCookie('PARAMETRO', form.elements['PARAMETRO'].value);
            //SetCookie('RESOLUCION', form.elements['RESOLUCION'].value);
            SetCookie('LANG', form.elements['LANG'].value);
            SetCookie('STYLE', form.elements['STYLE'].value);


            var host='http://www.newco.dev.br/MenusYDerechos/Main.xsql';

            var newMain=window.open(host,'newMain','titlebar=no,resizable=yes,status=yes,width=' + window.screen.availWidth+',height='+window.screen.availHeight+',left=0,top=0,pageXOffset=0,pageYOffset=0');
	
        }
        else{ alert(form.elements['ERROR_LOGIN'].value); }
	
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

function handleKeyPress(e) {
    var keyASCII;
	  
    if(navigator.appName.match('Microsoft')) var keyASCII=event.keyCode;
    else keyASCII = (e.which);
	  
    if (keyASCII == 13) AbrirVentana(document.forms['Login']);
		 
 }

        

	
if(navigator.appName.match('Microsoft')==false) 
	  document.captureEvents(Event.KEYPRESS); 
	document.onkeypress = handleKeyPress;


function AbrirVentanaConPulsacion(pag,titulo){  
       
         
          if(titulo==null)
            var titulo='defecto';
            
          
          if (is_nav){
            if(top.name=='newMain'){
              ample = top.screen.availWidth-100;
              alcada = top.screen.availHeight-100;
            
              esquerra = (top.screen.availWidth-ample) / 2;
              alt = (top.screen.availHeight-alcada) / 2;
            }else{
              var anchoVentanaPadre;
              var altoVentanaPadre;
              
              anchoVentanaPadre=obtenerAnchoVentanaPadre(window);
              altoVentanaPadre=obtenerAltoVentanaPadre(window);
              
              ample = anchoVentanaPadre-50;
              alcada = altoVentanaPadre-50;
              
            
              esquerra = (parent.screen.availWidth-ample) / 2;
              alt = (parent.screen.availHeight-alcada) / 2;
            }
            
            if (ventana && ventana.open){
              ventana.close();            
            }
            titulo=window.open('http://www.newco.dev.br/Empresas/PulsacionesBanners.xsql?LA_URL='+pag+'&EL_BANNER='+titulo,titulo);
            titulo.focus();
          }else{
            if(top.name=='newMain' ||top.name=='mainMVM'){
              ample = top.screen.availWidth-100;
              alcada = top.screen.availHeight-100;
            
              esquerra = (top.screen.availWidth-ample) / 2;
              alt = (top.screen.availHeight-alcada) / 2;
            }else{
              var anchoVentanaPadre;
              var altoVentanaPadre;
              anchoVentanaPadre=obtenerAnchoVentanaPadre(window);
              altoVentanaPadre=obtenerAltoVentanaPadre(window);
              
              ample = anchoVentanaPadre-50;
              alcada = altoVentanaPadre-50;
              
            
              esquerra = (parent.screen.availWidth-ample) / 2;
              alt = (parent.screen.availHeight-alcada) / 2;
            }
            if (ventana &&  ventana.open && !ventana.closed){
            	 ventana.close();
            }
	    titulo=window.open('http://www.newco.dev.br/Empresas/PulsacionesBanners.xsql?LA_URL='+pag+'&EL_BANNER='+titulo,titulo);
	    titulo.focus();
          }
        }

/*        
function EnviaMail(formu)
{
	AsignarAccion(formu,"mailto:comercial@medicalvm.com");
	SubmitForm(formu);
	document.location.href='http://www.newco.dev.br';
}
*/

    function MenuExplorerPublic(){
            
                         var browserName=navigator.appName; 
                       // alert('mi '+browserName);
                        if (browserName=="Microsoft Internet Explorer") { 
                            jQuery(".menuBox a").css('font-size','18px');
                            jQuery(".menuBox a").css('font-family','Arial');
                            jQuery(".menuBox a").css('font-weight','bold');
                            jQuery(".menuBox a").css('padding-left','15px');
                            jQuery(".menuBox a").css('padding-right','15px');
                            jQuery(".menuBox a").css('padding-top','6px');
                            jQuery(".menuBox a").css('padding-bottom','11px');
                            
                            jQuery(".menu").css('height','29px');
                            jQuery(".menu").css('padding-top','6px');
                            jQuery(".menu").css('padding-left','0px');
                        }//fin de if browsername
                        else if (/MSIE (\d+\.\d+);/.test(navigator.userAgent)){ //test for MSIE x.x;
                            var ieversion=new Number(RegExp.$1) // capture x.x portion and store as a number
                            if (ieversion>=5){
                                    jQuery(".menuBox a").css('font-size','18px');
                                    jQuery(".menuBox a").css('font-family','Arial');
                                    jQuery(".menuBox a").css('font-weight','bold');
                                    jQuery(".menuBox a").css('padding-left','15px');
                                    jQuery(".menuBox a").css('padding-right','15px');
                                    jQuery(".menuBox a").css('padding-top','6px');
                                    jQuery(".menuBox a").css('padding-bottom','11px');

                                    jQuery(".menu").css('height','29px');
                                    jQuery(".menu").css('padding-top','6px');
                                    jQuery(".menu").css('padding-left','0px');
                            }                          
                       }//fin else if ieversion
		}