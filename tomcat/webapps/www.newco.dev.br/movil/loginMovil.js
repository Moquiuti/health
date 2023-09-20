jQuery.noConflict();
// GLOBAL VARS   
var arroba = '@';

//----------------------------------------------------------

jQuery(document).ready(globalEvents);

//	Acceso a la zona privada
		  
top.name='mainMVM';


function esPar(numero){
if(numero%2==0)
  return true;
else
  return false;
}



function devolverCaracterPosicion(cadena,n)
{
	return cadena.charAt(n);
}


function montarCadena(cadena)
{

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

function modificar(cadena)
{
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
      
function guardar(form)
{

	var variableOrigen1;
	var variableOrigen2;
	var variableDestino;

	variableOrigen1=montarCadena(form.elements['USER'].value);
	variableOrigen2=montarCadena(form.elements['PASS'].value);
	variableDestino=variableOrigen1+'|'+variableOrigen2;
	variableDestino=montarCadena(variableDestino);


	variableDestino=modificar(variableDestino);

	document.forms[0].elements['PARAMETRO'].value=variableDestino;
}

	  
function setExpiration(cookieLife)
{
    var today = new Date();
    var expr = new Date(today.getTime() + cookieLife * 24 * 60 * 60 * 1000);
    return  expr.toGMTString();
}


function setCookie(name, value, expires, path, domain, secure)
{
	document.cookie = name + "=" + escape(value) + "; ";
	
	if(expires){
		expires = setExpiration(expires);
		document.cookie += "expires=" + expires + "; ";
	}
	if(path){
		document.cookie += "path=" + path + "; ";
	}
	if(domain){
		document.cookie += "domain=" + domain + "; ";
	}
	if(secure){
		document.cookie += "secure; ";
	}
}
	  
	
      
//
//	Esta funci�n abrir� la ventana de trabajo de MedicalVM maximizada
//	enviando los datos de usuario y clave v�a GET
//

function AbrirVentana(form){
    guardar(form);	
	
	setCookie('US_ID', '', -1);
	setCookie('SES_ID', '', -1);
	var host='http://www.newco.dev.br/Gestion/AdminTecnica/AdminTecnica.xsql'+'?'+'PARAMETRO='+form.elements['PARAMETRO'].value+'&'+'RESOLUCION='+form.elements['RESOLUCION'].value;
	
	form.action = host;
	form.submit();
}

function handleKeyPress(e) {
	
		  
	
	  var keyASCII;
	  
	  if(navigator.appName.match('Microsoft')) var keyASCII=event.keyCode;
	  else keyASCII = (e.which);
	  
      if (keyASCII == 13){
	  	 AbrirVentana(document.forms['Login']);
		 }
 }

        

 function handleKeyPress(e) {
 	 
	  var keyASCII;
	  
	  if(navigator.appName.match('Microsoft')) var keyASCII=event.keyCode;
	  else keyASCII = (e.which);
      
	  if (keyASCII == 13){ 
	  	if(navigator.appName.match('Microsoft'))      
              AbrirVentana(document.forms['Login']);
       }
	   
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
        
        function EnviaMail(formu)
	{
	AsignarAccion(formu,"mailto:comercial@medicalvm.com");
	SubmitForm(formu);
	document.location.href='http://www.newco.dev.br';
	
	}