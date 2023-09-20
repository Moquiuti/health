// JavaScript Document
//	ET	16dic16
//	Ultima revision: 18dic16 09:47

function procesarLogin(){
	//solodebug	alert('SendForm');
	DeleteCookie('PARAMETRO');
    SetCookie('SES_ID', '');
	PrepararLogin(document.forms['frmLogin']);
	document.forms['frmLogin'].submit();
}

// Creacion de una cookie con nombre sName y valor sValue
function SetCookie(sName, sValue)
{ 
	var dominio=document.forms['frmLogin'].elements['DOMINIO'].value;
	document.cookie = sName + "=" + escape(sValue) + ";host='+dominio+';path=/";	
}

// Elimina una cookie, importante para reset de la cookie PARAMETRO
function DeleteCookie(sName)
{ 
	document.cookie = sName + '=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
}

//Retorna el valor de la cookie
function GetCookie(sName)
{ 
	if (document.cookie.length > 0) 
	{   
		// cookies are separated by semicolons
		var aCookie = document.cookie.split("; ");
		for (var i=0; i < aCookie.length; i++)
		{
		  // a name/value pair (a crumb) is separated by an equal sign
		  var aCrumb = aCookie[i].split("=");
		  if (sName == aCrumb[0]) 
	    	return unescape(aCrumb[1]);
		}
		// a cookie with the requested name does not exist
		return null;
	}
	return null;
}



function devolverCaracterPosicion(cadena,n){
return cadena.charAt(n);
}

function esPar(numero){
	if(numero%2==0)
		return true;
	else
		return false;
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
	
	variableOrigen1=montarCadena(form.elements['USER'].value.trim());
	variableOrigen2=montarCadena(form.elements['PASS'].value.trim());

	variableDestino=variableOrigen1+'_'+variableOrigen2;
	variableDestino=montarCadena(variableDestino);

	variableDestino=modificar(variableDestino);

	document.forms['frmLogin'].elements['PARAMETRO'].value=variableDestino;
      
}
     
	 
//	Enviar formulario de contacto
function EnviaContacto(formu){
	var msg='';
	
	if(formu.elements['CONTACTO_NOMBRE'].value == ''){ msg += document.forms['mensajeJS'].elements['CNTC_NOMBRE_OBL'].value+'\n';}
	if(formu.elements['CONTACTO_MAIL'].value == ''){ msg += document.forms['mensajeJS'].elements['CNTC_EMAIL_OBL'].value+'\n';}
	if(formu.elements['CONTACTO_TEL'].value == ''){ msg += document.forms['mensajeJS'].elements['CNTC_TLFN_OBL'].value+'\n';}
	if(formu.elements['CONTACTO_EMPRESA'].value == ''){ msg += document.forms['mensajeJS'].elements['CNTC_NOM_EMPRESA_OBL'].value+'\n';}
	if(formu.elements['CONTACTO_TIPO_EMP'].value == ''){ msg += document.forms['mensajeJS'].elements['CNTC_TIPO_EMPRESA_OBL'].value+'\n';}
	//if(formu.elements['CONTACTO_CARGO'].value == ''){ msg += document.forms['mensajeJS'].elements['CNTC_CARGO_OBL'].value+'\n';}
	//if(formu.elements['CONTACTO_TEXT'].value == ''){ msg += document.forms['mensajeJS'].elements['CNTC_INFO_OBL'].value+'\n';}
	
	if (msg == ''){
	
		var nombre	= codificacionAjax(formu.elements['CONTACTO_NOMBRE'].value);
		var mail	= codificacionAjax(formu.elements['CONTACTO_MAIL'].value);
		var tel		= codificacionAjax(formu.elements['CONTACTO_TEL'].value);
		var empresa	= codificacionAjax(formu.elements['CONTACTO_EMPRESA'].value);
		var tipo	= codificacionAjax(formu.elements['CONTACTO_TIPO_EMP'].value);
		var cargo	= codificacionAjax(formu.elements['CONTACTO_CARGO'].value);
		var text	= codificacionAjax(formu.elements['CONTACTO_TEXT'].value);
		var pais	= codificacionAjax(formu.elements['PAIS'].value);


		jQuery.ajax({
			url:"ContactoSave.xsql",
			data: "CONTACTO_MAIL="+mail+"&CONTACTO_NOMBRE="+nombre+"&CONTACTO_CARGO="+cargo+"&CONTACTO_TIPO_EMP="+tipo+"&CONTACTO_EMPRESA="+empresa+"&CONTACTO_TEL="+tel+"&CONTACTO_TEXT="+text+"&PAIS="+pais,
			type: "GET",
			contentType: "application/xhtml+xml",
			beforeSend:function(){
				var dominio=document.forms['frmLogin'].elements['DOMINIO'].value;
				document.getElementById('waitBox').src = 'http://'+dominio+'/images/loading.gif';

			},
			error:function(objeto, quepaso, otroobj){
				alert("objeto:"+objeto);
				alert("otroobj:"+otroobj);
				alert("quepaso:"+quepaso);
			},
			success:function(data){

				var doc=eval("(" + data + ")");
                document.getElementById('botonContacto').style.display = 'none';
				document.getElementById('confirmBox').style.display = 'block';

			}
		}); 
		
	}//fin de if si msg ==''
	else
	{
		alert(msg);
	}
}//fin de EnviaContacto


//	Codifica la cadena para ser enviada vía Ajax. A nivel de servidor habrá que quitar esta codificación
function codificacionAjax(string){
	var cod_string = '', ch;

	if(string.length > 0){
		for(var i=0; i<string.length; i++){
			ch = string.substr(i,1);

			if((ch.charCodeAt()>='0'.charCodeAt() && ch.charCodeAt()<='9'.charCodeAt()) 
				|| (ch.charCodeAt()>='a'.charCodeAt() && ch.charCodeAt()<='z'.charCodeAt()) 
				|| (ch.charCodeAt()>='A'.charCodeAt() && ch.charCodeAt()<='Z'.charCodeAt())){

				cod_string = cod_string + ch;
			}else{
				cod_string = cod_string + 'ZZ' + ch.charCodeAt() + 'ZZ';
			}
		}
	}
	return cod_string;
}

//	Abre una página en pop-up 
function MostrarPagPersonalizada(pag,titulo,p_ancho,p_alto,p_desfaseLeft,p_desfaseTop){  

	if(titulo==null) 
		var titulo='MedicalVM';

    ample = (window.screen.availWidth*p_ancho)/100;
    alcada = (window.screen.availHeight*p_alto)/100;

    esquerra = parseInt(((window.screen.availWidth-ample) / 2)+((((window.screen.availWidth-ample) / 2)*p_desfaseLeft)/100));
    alt = parseInt(((window.screen.availHeight-alcada) / 2)+((((window.screen.availHeight-alcada) / 2)*p_desfaseTop)/100));  

    if(titulo && titulo.open){
      titulo.close();            
    }

    titulo=window.open(pag,titulo,'toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',screenX='+esquerra+',screenY='+alt);
    titulo.focus();

}
	  

/*	Tecla return para enviar el formulario de Login	*/
function handleKeyPress(e) {
    var keyASCII;
	  
    if(navigator.appName.match('Microsoft')) var keyASCII=event.keyCode;
    else keyASCII = (e.which);
	  
    if (keyASCII == 13) AbrirVentana(document.forms['Login']);
		 
}
	
if(navigator.appName.match('Microsoft')==false) 
	  document.captureEvents(Event.KEYPRESS); 

document.onkeypress = handleKeyPress;
