/*
	JS librerias básicas de MVM: en caso de cambios, renombrar y propagar nombre a todas las páginas XSL. Creadas a partir de basic_180608.js
	Requiere jQuery 3

	Ultima revision: 12jul22 12:06 basic2022_010822.js

	Lanzar script si se cambia el nombre del fichero PRODUCCION:
	/home/mvm/scripts/changefilename.sh [Origen] [Destino]
	
*/
/*
	Devuelve una subcadena de p_Texto comprendida entre
	la p_Rep y p_Rep+1 apariciones del separador p_Sep
	
	Cuidado! El separador solo puede tener longitud 1!
*/
function Piece(p_Texto,p_Sep,p_Rep)
{
	var v_Resultado=String('');
	var v_Rep=parseInt(p_Rep);
	var v_Actual=0;
	var v_Inicio=1;
	//	Busca la aparicion p_Rep-esima del separador
	while ((v_Rep>0)&&(v_Actual<p_Texto.length))
	{
		if (p_Texto.charAt(v_Actual)==p_Sep)
		{
			v_Rep=v_Rep-1;
		}
		v_Actual=v_Actual+1;
	}
	if (v_Actual<=p_Texto.length)
	{
		v_Inicio=v_Actual;
		//	Busca la siguiente aparici?n del separador o el final de la cadena
		while ((p_Texto.charAt(v_Actual)!=p_Sep)&&(v_Actual<p_Texto.length))
		{
			v_Actual=v_Actual+1;
		}
		v_Resultado=p_Texto.substr(v_Inicio, v_Actual-v_Inicio);
	}
	else
	{
		v_Resultado='';
	}
	return v_Resultado;
}

//	Cuenta el número de separadores en una cadena
function PieceCount(p_Texto, p_Sep)
{
	var	Count=0,v_Actual=0;

	while (v_Actual<p_Texto.length)
	{
		if (p_Texto.charAt(v_Actual)==p_Sep)
		{
			Count=Count+1;
		}
		v_Actual=v_Actual+1;
	}
	return Count;
}


//	12jul22	Busca un valor ID en un campo Campo de un ARRAY miArray
function BuscaEnArray(miArray, Campo, ID)
{
	var Pos=-1;

	//solodebug	debug('BuscaEnArray. length:'+miArray.length+' Campo:'+Campo+' ID:'+ID);
	for (i=0;(i<miArray.length)&&(Pos==-1);++i)
	{
		//solodebug	debug('BuscaEnArray.Campo:'+Campo+' ID:'+ID+' Check:'+miArray[i][Campo]);
		if (miArray[i][Campo]==ID) Pos=i;
	}
	//solodebug	debug('BuscaEnArray.Campo:'+Campo+' ID:'+ID+' Pos:'+Pos);
	return Pos;
}


//	2may22 copia una estructura a otra
function copiaArray(arrOrig)
{
	return(arrOrig.map(a => {return {...a}}));
}


//28mar22	Recuperamos MostrarPag, utilizada en el EIS, como llamada a MostrarPagPersonalizada
function MostrarPag(pag,titulo)
{
	MostrarPagPersonalizada(pag,titulo,100,80,0,0);
}

//	Abre una ventana fijando el tamanno y posicion        
function MostrarPagPersonalizada(pag,titulo,p_ancho,p_alto,p_desfaseLeft,p_desfaseTop){  

  if(titulo==null) var titulo='MedicalVM';

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

//	Abre una url en la pagina actual (sustituye a MostrarPag)  
function CambiarAPagina(url)
{  
	location.href = url;
}


// 5may22 Creacion de una cookie con nombre sName y valor sValue. Incluir SameSite!
function SetCookie(sName, sValue)
{ 
//estilo ke enseï¿½a - alert(sValue);
  document.cookie = sName + "=" + escape(sValue) + ";host=www.nucleo-medicalvm.com;path=/; SameSite=Strict;";	
}



/*
	Hace un barrido de todos los campos del formulario valida que no sea nulo y 
	reemplaza las comillas simples por dobles.

	Valida()  - validaCamps.js - 

	hace un barrido del array camps y para cada elemento valida en funcion del tipo de datos
	devuelve true si todos son correctos

	modificaciones necesarias:

   		crear para todos los objetos del formulario un objeto 'Campo' asociado con el objeto del formulario cambiar las funciones de validacion 
  		de tipos de ValidaCamps() por las de MVM.

*/        
function SubmitForm(formu){
  for(j=0;j<formu.elements.length;j++){
    // quitamos los saltos de linea de los tipo text
    if(formu.elements[j].type=='text'){
      	formu.elements[j].value=quitarSaltosDeLinea_2(formu.elements[j].value);
    }
    // No preguntamos al usuario...
    if ((formu.elements[j].type=="text" || formu.elements[j].type=="textarea") && formu.elements[j].value!=""){
      formu.elements[j].value=checkForQuotesSin(formu.elements[j].value);
    }
    if (formu.elements[j].type=="hidden" && formu.elements[j].value!=""){	
      formu.elements[j].value=checkForQuotesSin(formu.elements[j].value);               
    }
  } 
  //12ene22 Los botones los desactivamos al pulsarlos, el chequeo de campos se hace en cada formulario
  //if (hayComillasSimples=="false" && test(formu)){
    //if(arguments.length>1){
    //  DeshabilitarBotones(arguments[1]);
    //}
    formu.submit();
  //}
}

// CHECK FIELDS - REPLACE ALL SINGLE QUOTES (') WITH A PAIR OF SINGLE QUOTES
//  (SQL SYNTAX REQUIREMENT).
//
// Modificaciones:
//		Ferran Foz - Permitimos todos los caracteres $ffp$1$
//
//
function checkForQuotesSin(checkString){

    newString = "";    // REVISED/CORRECTED STRING
    count = 0;         // COUNTER FOR LOOPING THROUGH STRING
    hayComillasSimples="false"; // Modificamos la variable global.

    // ENSURE THAT AT LEAST ONE SINGLE-QUOTE EXISTS
    if (checkString.indexOf("'")>=0) {
      for (i = 0; i < checkString.length; i++) {
        ch = checkString.substring(i, i+1);
        if (ch == "'") {
            // ADD A SECOND ' CHARACTER
            newString += ch + "'";                
        }
        // CHARACTER IS NOT A ' CHARACTER
        else {
            // ALLOW ALL PRINTABLE CHARACTERS
            //$ffp$1$// if (ch >= " " && ch <= "~") {
                newString += ch;
            //$ffp$1$//}
        }
      }
      if (checkString != newString) {
          return newString;
      }else{
        return checkString;
      }
    }
    else{
        return checkString;
    }        
}

//	Quita lo saltos de linea de una cadena
function quitarSaltosDeLinea_2(palabra)
{   

	var arrayDumped=new Array();
	for(var n=0;n<palabra.length;n++){
	  if(palabra.charCodeAt(n)!=13 && palabra.charCodeAt(n)!=10 && palabra.charCodeAt(n)!=0){
    	arrayDumped[arrayDumped.length]=palabra.charCodeAt(n);	
	  }
	}


	palabra='';

	for(var n=0;n<arrayDumped.length;n++){
	  palabra=palabra+String.fromCharCode(arrayDumped[n]);
	}

	return palabra;
}


//	22feb18	Funciones para convertir del formato JS al formato ISO. Necesarias para exportación a Excel
function StringToISO(Cadena)
{
	var Res='';

	for(i=0; i<Cadena.length; i++)
	{
		if (Cadena.charCodeAt(i)<=127)
		{
			Res+=Cadena.charAt(i);
		}
		else
		{
			Res+=CharToISO(Cadena.charAt(i));
			//console.log(i + ': ' + Cadena.charAt(i) + ':' + Cadena.charCodeAt(i) +' -> '+ encodeURIComponent(Cadena.charAt(i))+' <-'+ unescape(encodeURIComponent(Cadena.charAt(i))) + ':' + CharToISO(Cadena.charAt(i)) );
		}
	}
	
	//solodebug	console.log('StringToISO:'+Cadena+'->'+Res);
	
	return Res;
}

function CharToISO(Char)
{
    var Res;

    if (Char=='á') Res='a';
    else if (Char=='é') Res='e';
    else if (Char=='í') Res='i';
    else if (Char=='ó') Res='o';
    else if (Char=='ú') Res='u';
    else if (Char=='Á') Res='A';
    else if (Char=='É') Res='E';
    else if (Char=='Í') Res='I';
    else if (Char=='Ó') Res='O';
    else if (Char=='Ú') Res='U';
    else if (Char=='ã') Res='a';
    else if (Char=='Ã') Res='A';
    else if (Char=='õ') Res='o';
    else if (Char=='Ö') Res='O';
    else if (Char=='ñ') Res='n';
    else if (Char=='Ñ') Res='N';
    else if (Char=='ç') Res='c';
    else if (Char=='Ç') Res='C';
    else Res=Char;

	//console.log('CharToISO:'+Char+'->'+Res);
    return(Res);
}

//	29may18	Convertimos cadenas a formato HTML para ser luego convertidas a ISO en la base de datos
function ScapeHTMLChar(ch)
{
    var ret=ch;

	if (ch == '&' )
		ret = '&';
	else if ( ch == '<' )
		ret = '&lt;';
	else if ( ch == '>' )
		ret = '&gt;';
	else if ( ch == 'ç' )
		ret = '&ccedil;';
	else if ( ch == 'Ç' )
		ret = '&Ccedil;';
	else if ( ch == 'á' )	
		ret = '&aacute;';
	else if ( ch == 'à' )
		ret = '&agrave;';
	else if ( ch == 'ã' )
		ret = '&atilde;';
	else if ( ch == 'é' )
		ret = '&eacute;';
	else if ( ch == 'è' )
		ret = '&egrave;';
	else if ( ch == 'ê' )
		ret = '&ecirc;';
	else if ( ch == 'í' )
		ret = '&iacute;';
	else if ( ch == 'ì' )
		ret = '&igrave;';
	else if ( ch == 'ó' )
		ret = '&oacute;';
	else if ( ch == 'ò' )
		ret = '&ograve;';
	else if ( ch == 'ö' )
		ret = '&ouml;';
	else if ( ch == 'ú' )
		ret = '&uacute;';
	else if ( ch == 'ù' )
		ret = '&ugrave;';
	else if ( ch == 'Á' )
		ret = '&Aacute;';
	else if ( ch == 'À' )
		ret = '&Agrave;';
	else if ( ch == 'Ã' )
		ret = '&Atilde;';
	else if ( ch == 'É' )
		ret = '&Eacute;';
	else if ( ch == 'È' )
		ret = '&Egrave;';
	else if ( ch == 'Ê' )
		ret = '&Ecirc;';
	else if ( ch == 'Í' )
		ret = '&Iacute;';
	else if ( ch == 'Ì' )
		ret = '&Igrave;';
	else if ( ch == 'Ó' )
		ret = '&Oacute;';
	else if ( ch == 'Ò' )
		ret = '&Ograve;';
	else if ( ch == 'Ú' )
		ret = '&Uacute;';
	else if ( ch == 'Ù' )
		ret = '&Ugrave;';
	else if ( ch == 'ñ' )
		ret = '&ntilde;';
	else if ( ch == 'Ñ' )
		ret = '&Ntilde;';	//	'&#209;'
	else if ( ch == 'ü' )
		ret = '&uuml;';
	else if ( ch == 'Ö' )
		ret = '&Ouml;';
	else if ( ch == 'õ' )
        ret = '&otilde;';
	else if ( ch == '\n' )		//	18feb20
        ret = '<br/>';
	else if ( ch == '\r' )		//	18feb20
        ret = '';
	else if ( ch == '\u20ac' )		//	18feb20
        ret = '&euro;';
	else if ( ch == "'" )		//	Comilla simple
        ret = '&#39;';
	else if ( (ch.charCodeAt(0)<32) || (ch.charCodeAt(0)>127 ))	//	Para caracteres especiales no escapeables devolvemos un espacio (puede ser tabulador, salto de línea, etc)
		ret =' ';
	
	return ret;
}

function ScapeHTMLString (str)
{
    var Res='',
		CaracterHTML,
		i;


	for (i=0;i<str.length;++i)
	{
	 	CaracterHTML=ScapeHTMLChar(str.charAt(i));
		Res = Res + CaracterHTML;
	}
	
	return Res;
}



//	Extrae una cadena a través de console.log, incluyendo la fecha
function debug(txt)
{
	var f=new Date();
	console.log(f.getHours()+":"+f.getMinutes()+":"+f.getSeconds()+ ": " + txt);
}





//	Comprueba si una cadena contiene un punto. Optimizado por ET 26ene22
function tienePunto(numero){
  var num=String(numero);
  
  return (num.indexOf('.')>0?1:0);
}


//	Reemplaza el "." decimal por ","
function reemplazaPuntoPorComa(Numero){
	
  Numero=String(Numero);
  
  var vector = Numero.split(".");
  if (vector.length==2) 
    return ((vector[0])+','+(vector[1]));
  else 
    return Number(vector[0]);
}


/*
    Antes se llamaba "FormateaNumeroNacho", tambiÃ©n "formateaDivisa" debe sustituirse por esta

    funcion que recibe un obj tipo texto
    si el numero (con o sin decimales) no tiene formato se lo da, si lo tiene no hace nada
    (los puntos han de ser correctos)
    1000000,10 --> 1.000.000,10 
    1000000.10 --> 1000000,10 -->1.000.000,10
*/    
function FormatoNumero(valor){

    var signo='';

    valor=String(valor);
    if(valor.search('-')!=-1){
      signo='-';
      valor=valor.substring(1,valor.length);
    }
	    
	if(tienePunto(valor)==true){
	  valor=reemplazaPuntoPorComa(valor);
	}
	var nuevoValor;
	var nuevaParteEntera;
	var coma=0;
	var punto=0;
	var vectorValores;

	vectorValores = valor.split(",");

	var parteEntera;
	var parteDecimal;

	parteEntera = vectorValores[0];
	if(vectorValores.length==2){
		parteDecimal = vectorValores[1];
	}
	nuevaParteEntera='';
	contador=0;
	for (var n = parteEntera.length; n > 0; n--) {
	    ch = valor.substring(n-1, n);
	    if (contador!=0 && contador%3==0){	          
              if (ch!='.'){
                nuevaParteEntera+='.'+ch;  
              }
              else{
                contador--;
              }
            }
            else{
              nuevaParteEntera+=ch;
            }
              contador++;      
	}
	nuevoValor=nuevaParteEntera;

	var valorCorrecto='';
	for (var n=nuevaParteEntera.length;n>0;n--){
	    ch=nuevaParteEntera.substring(n-1,n);
	    valorCorrecto+=ch;
	}
	if(vectorValores.length==2){
		valorCorrecto+=','+parteDecimal;
	}
	valor=valorCorrecto;
	valor=signo+valor;
	return valor;
} 


//	Comprueba si existe el frame hijo
function obtenerFrame(framePadre, frameBuscado){

	var done=false;
	
	//solodebug  alert('Function obtenerFrame. frameBuscado:'+ frameBuscado);
  
	var objFrame=new Object();

    try {
      objFrame=parent.frames[frameBuscado];
      var name=objFrame.name;   //forzamos error si no está definido

    }
    catch(err) {
      objFrame=parent.parent.frames[frameBuscado];
      //solodebug alert(parent.parent.frames[frameBuscado].name);

    }

	//	En el caso de que la llamada se haga desde un pop-up hay que cambiar la estrategia
    try {
      var name=objFrame.name;   //forzamos error si no está definido
  
    }
    catch(err) {
		//	27feb17
  
		if(framePadre.length>0){
		
			if (framePadre.name==frameBuscado) objFrame=framePadre;
			else
			{
				//solodebug	var nombres='';
				for(var n=0;(n<framePadre.length) && (!done);n++){
    				//solodebug	nombres+=framePadre.frames[n].name+'\n\r';
					//solodebug	console.log('Function obtenerFrame. frameBuscado:'+ frameBuscado+' comprobando:'+framePadre.frames[n].name);
					if (framePadre.frames[n].name==frameBuscado) 
					{
						objFrame=framePadre.frames[n];
						done=true;
					}
				}
				//solodebug	alert(nombres);
			}
		}
      //solodebug alert(parent.parent.frames[frameBuscado].name);
    }
	
	//solodebug	
    /*try {
		console.log('Function obtenerFrame. frameBuscado:'+ frameBuscado+' res:'+objFrame.name);
    }
    catch(err) {
		console.log('Function obtenerFrame. frameBuscado:'+ frameBuscado+' ERROR: no se ha encontrado frame');
	}*/
	
	return objFrame;
}


//	16feb22	Calcula fecha final, solo utilizando dias habiles. Utilizado en LPAnalizarFrame
function calcularDiasHabiles(hoy,incremento){
   var fechaResultado=hoy;
   var incrementoDiasHabiles=0;

   if(incremento>=0){
     while(incrementoDiasHabiles<incremento){
       fechaResultado=sumaDiasAFecha(fechaResultado,1);  
       if(fechaResultado.getDay()!=0 && fechaResultado.getDay()!=6)
         incrementoDiasHabiles++;
     }
   }
   else{
     while(incrementoDiasHabiles>incremento){
       fechaResultado=sumaDiasAFecha(fechaResultado,-1);  
       if(fechaResultado.getDay()!=0 && fechaResultado.getDay()!=6)
         incrementoDiasHabiles--;
     }
   }
   
   return(fechaResultado);
}


//	16feb22	Suma dos fechas
function sumaFechas(fecha1,fecha2)
{
	var fFecha1=new Date(fecha1); 
	var fFecha2=new Date(fecha2); 
	var Resultado=parseInt(fFecha1.getTime()+fFecha2.getTime()); 
	var fResultado=new Date(Resultado); 

	return fResultado;
}


//	16feb22	suma dias a una fecha	recibe la fecha en formato dd/mm/yyyy y los dias. Utilizado en LPAnalizarFrame
function sumaDiasAFecha(fechainicio,incremento)
{ 
	return sumaFechas(fechainicio,incremento*24*60*60*1000);
}


//  16feb22	devuelve el dia mes anyo de una fecha. util para convertir a formato ingles. Utilizado en LPAnalizarFrame
function formatoFecha(fecha, formatoEntrada, formatoSalida){

  var nuevaFecha;


  if(formatoEntrada==formatoSalida){
    nuevaFecha=fecha;  
  }
  else{
      nuevaFecha=obtenerSubCadena(fecha, 2)+'/'+obtenerSubCadena(fecha, 1)+'/'+obtenerSubCadena(fecha, 3);
  }
  return nuevaFecha;  
}


//	16feb22 Reemplaza el separador decimal de un numero (en una cadena)
function reemplazaSeparadorDecimal(Numero, separador){
	
  Numero=String(Numero);
  
  var vector = Numero.split(',');
  if (vector.length==2) 
    return ((vector[0])+separador+(vector[1]));
  else 
    return Number(vector[0]);
}


//	16feb22Reemplaza la coma (separador decimal) por un punto. Utilizado en CVGenerar
function reemplazaComaPorPunto(Numero){
 
  sNumero=String(quitaPuntos(Numero));
 
  var vector = Numero.split(",");
  if (vector.length==2) 
    return ((vector[0])+'.'+(vector[1]));
  else 
    return Number(vector[0]);
}




//	16feb22 Quita los puntos (separador de miles) de un numero (en una cadena)
function quitaPuntos(numero){
  var strNumero=String(numero)
  var arrayNum=strNumero.split('.');
  if(arrayNum.length==1)
	return strNumero=arrayNum;
  else{
	strNumero='';
	for(var n=0;n<arrayNum.length;n++)
	  strNumero+=arrayNum[n];
  }

  return strNumero;	
}


//  16feb22 funcion que a?ade de ceros decimales hasta completar las posicionesDecimales
function anyadirCerosDecimales(valor,posicionesDecimales){
          
   var tieneComa=0;
          
   if(valor=='')
     valor='0';
          
   for(var n=0;n<valor.length;n++){
     if(valor.substring(n,n+1)==','){
       tieneComa=n;    
     }
   }
            
   if(tieneComa==0 && posicionesDecimales>0){
     valor+=',';
   }

   for(var n=0;n<valor.length;n++){
      if(valor.substring(n,n+1)==','){
        tieneComa=n;    
      }
    }

    if(posicionesDecimales>0){

      while(tieneComa>valor.length-1-posicionesDecimales){
        valor+='0';
        for(var n=0;n<valor.length;n++){
          if(valor.substring(n,n+1)==','){
            tieneComa=n;    
          }
        }
      }
    }


  return valor;
}

        
//	16feb22 Comprueba si es un entero
function esEntero(valor){

  valor+='';
  for(var n=0;n<valor.length;n++){
    if(valor.substring(n,n+1)<'0' || valor.substring(n,n+1)>'9')
      return false;	
  }
  return true;
}

//	16feb22 Comprueba si es un entero con signo inicial
function esEnteroConSigno(valor){

  valor+='';
  for(var n=0;n<valor.length;n++){
    if((valor.substring(n,n+1)<'0' || valor.substring(n,n+1)>'9') &&  valor.substring(n,n+1)!='-')
      return false;	
  }
  return true;
}


//	16feb22 Asignar accion a un formulario
function AsignarAccion(formu,accion){
  formu.action=accion;
}


//
//  Funci?n de validaci?n de fechas. ANtes llamada solo "test". Utilizado en LPAnalizarFrame
//
//  Se validan los campos que empiezan por FECHA (excepto los que empiezan por FECHANO )
//  
//  Si hay algun error se devuelve false y se muestra un alert con los errores hallados.
//	
function testFechas(Formu)
{
	errores="";
	ultima=0;
	// FECHANO = Fecha No Obligatoria          
	for(i=0;i<Formu.elements.length && errores=="";i++)
	{ 
		if (Formu.elements[i].type == 'text') 
		{
			if (Formu.elements[i].name.substr(0,5)=="FECHA" && Formu.elements[i].name.substr(0,7)=="FECHANO" && Formu.elements[i].value!="")
			{	          
				errores=errores+CheckDate(Formu.elements[i].value);
				console.log("testFechas. Revisando:"+Formu.elements[i].name+' val:'+Formu.elements[i].value+' errores:'+errores);
				ultima=i;
			}	  	
			else 
			{
				if (Formu.elements[i].name.substr(0,5)=="FECHA" && Formu.elements[i].name.substr(0,7)!="FECHANO")
				{
					errores=errores+CheckDate(Formu.elements[i].value);
					console.log("testFechas. Revisando:"+Formu.elements[i].name+' val:'+Formu.elements[i].value+' errores:'+errores);
					ultima=i;
				}
			}
		}	    
	}	  			    
	if (errores!="")
	{
		alert(errores);
		Formu.elements[ultima].focus();
		return (false);
	}
	else
	{
		return (true);
	}
}
	
//Compara fecha1 con fecha2 con formato dd/mm/aaaa o d/m/aaaa o d/mm/aaaa 0 dd/m/aaaa
//
//Si fecha1>fecha2 return '>'
//Si fecha1=fecha2 return '='
//Si fecha1<fecha2 return '<'
//
function comparaFechas(fecha1,fecha2)
{
	vector1 = fecha1.split("/");	/////
	dia1=Number(vector1[0]);
	mes1=Number(vector1[1]);
	anyo1=Number(vector1[2]);
	if (anyo1<1000) anyo1=anyo1+2000;
	vector2 = fecha2.split("/");
	dia2=Number(vector2[0]);
	mes2=Number(vector2[1]);
	anyo2=Number(vector2[2]);
	if (anyo2<1000) anyo2=anyo2+2000;
	if (anyo1>anyo2 || (anyo1==anyo2 && mes1>mes2) || (anyo1==anyo2 && mes1==mes2 && dia1>dia2)){
	    return ('>');
	}else{
	  if(anyo1==anyo2 && mes1==mes2 && dia1==dia2){
	    return ('=');
	  }
	  else{
	    return ('<');
	  }
	}    	        
}	


//	19feb20	Convierte una cadena de fecha en formato dd/mm/yy o dd/mm/yyyy a un entero en formato yyyymmdd
function dateToInteger(fechaStr)
{
	var fechaInt;
	fechaInt=parseInt(Piece(fechaStr,'/',2))*10000+parseInt(Piece(fechaStr,'/',1))*100+parseInt(Piece(fechaStr,'/',0));
	if (fechaInt<100000000) fechaInt=20000000+fechaInt;
	return(fechaInt);
}

//	Antes llamada tambien test2
//	Permitimos el formato con solo 2 cifras para el año
function CheckDate(Fecha)
{ 
	errores="";
	if (Fecha == '')
		return (errores);
	else
	{
		//alert('en CheckDate()'+ Fecha);
		vector = new String(Fecha).split("/");
		dia=vector[0];
		mes=vector[1];
		anyo=vector[2];

		var formato='dd/mm/aaaa';

		  //modificado por nacho 13/12/2001

		  if (String(anyo).length==2) 
		  {
	  		anyo='20'+anyo;
			formato='dd/mm/aa';
			Fecha=dia+'/'+mes+'/'+anyo;
		  }
		  //alert(dia.length);                  alert(mes.length);                  alert(anyo.length);
                  //alert(Fecha);
		  //	Los 3 componentes deben estar informado
		  if (isNaN(dia) || isNaN(mes) || isNaN(anyo) || dia.length<1 || dia == '0' || mes.length<1 || mes == '0')
                    errores='La fecha '+dia+'/'+mes+'/'+anyo+' no respeta el formato correcto '+formato;
                
		  if (anyo<2020)
		  {    
            	//fechas, formato dd/mm/aaaa o d/m/aa

	    	var er_mes31dias = /^([1-3]0|[0-2][1-9]|31|[0-9])\/(1|01|3|03|5|05|7|07|8|08|10|12)\/(1999|20[0-1][0-9]|2020)$/;
	    	var er_mes30dias = /^([1-3]0|[0-2][1-9]|[0-9])\/(4|04|6|06|9|09|11)\/(1999|20[0-1][0-9]|2020)$/;
        	var er_mes28dias = /^([1-2]0|[0-2][1-8]|[0-1]9|[0-9])\/(02|2)\/(1999|200[1-3]|200[5-7]|2009|201[0-1]|201[3-5]|201[7-9])$/;
	    	var er_mes29dias = /^([1-2]0|[0-2][1-9]|[0-9])\/(02|2)\/(2000|2004|2008|2012|2016|2020)$/;
	    	//comprueba la fecha segun calendario (hasta el 2020, ojo)


	    	if (!(er_mes31dias.test(Fecha) || 
	    	  er_mes30dias.test(Fecha) ||
	    	  er_mes29dias.test(Fecha) ||
	    	  er_mes28dias.test(Fecha))) 
		    	  errores='::::: La fecha '+dia+'/'+mes+'/'+anyo+' no respeta el formato correcto '+formato;

	    	  return (errores);
		  }
		  else
		  { 
	    	//para anyo>2020 tenemos comprobacion menos efectiva
	    	if ((dia <1) || (dia>31)) 
	    	  //errores='Error dia incorrecto en ';
	    	  errores='La fecha '+dia+'/'+mes+'/'+anyo+' no respeta el formato correcto '+formato;
	    	else 
			{
	    	  if ((mes <1) || (mes>12)) 
			  {
	        	//errores='Error mes incorrecto en ';
	        	errores='La fecha '+dia+'/'+mes+'/'+anyo+' no respeta el formato correcto '+formato;
           	  }
           	  else
               	if ((anyo<2000) || (anyo>3000)) 
			  //errores='Error a\xF1o incorrecto en ';
					  errores='La fecha '+dia+'/'+mes+'/'+anyo+' no respeta el formato correcto '+formato;
			}
		  	return (errores);
		}//fin else si fecha != ''
	}
}	



/*
	formateaDivisa, desformateaDivisa se mantienen por compatibilidad en MOFJS, sustituir en cuanto sea posible
*/
//   recibe:   100000.10
//             100000,12
function formateaDivisa(valor){

	var signo='';

    	valor=String(valor);
    	if(valor.search('-')!=-1){
    	  signo='-';
    	  valor=valor.substring(1,valor.length);
    	}

	if(tienePunto(valor)){
	  valor=reemplazaPuntoPorComa(valor);
	}
	var nuevoValor;
	var nuevaParteEntera;
	var coma=0;
	var punto=0;
	var vectorValores;


	  vectorValores = valor.split(",");


	var parteEntera;
	var parteDecimal;


	parteEntera = vectorValores[0];
	if(vectorValores.length==2){
	  parteDecimal = vectorValores[1];
	}
	nuevaParteEntera='';
	contador=0;
	for (var n = parteEntera.length; n > 0; n--) {
		ch = valor.substring(n-1, n);

		if (contador!=0 && contador%3==0){	          
        	  if (ch!='.'){
            	nuevaParteEntera+='.'+ch;  
        	  }
        	  else{
            	contador--;
        	  }
        	}
        	else{
        	  nuevaParteEntera+=ch;
        	}
        	  contador++;      
	}
	nuevoValor=nuevaParteEntera;

	var valorCorrecto='';
	for (var n=nuevaParteEntera.length;n>0;n--){
		ch=nuevaParteEntera.substring(n-1,n);
		valorCorrecto+=ch;
	}
	if(vectorValores.length==2){
	  //if(parteDecimal.length>2)
		//parteDecimal=parteDecimal.substring(0,2);
	  valorCorrecto+=','+parteDecimal;
	}
	valor=valorCorrecto;
	valor=signo+valor;
	return valor;
}
        

//	Cadena con numero en formato espannol -> float
//	9may22 CUIDADO: forzar el paso a String antes del replace
function desformateaDivisa(valor){
/*	2may22
	valor=String(valor);
	var separadorDecimal;

	if(arguments.length>1)
		separadorDecimal=arguments[arguments.length-1];
	else
		separadorDecimal='.';

	valor=quitaPuntos(valor);
	valor=reemplazaSeparadorDecimal(valor,separadorDecimal);
	valor=parseFloat(valor);*/
	
	return parseFloat(valor.toString().replaceAll('.','').replace(',','.'));	//	8jul22 replace -> replaceAll, o quedaban puntos por medio
}


// Redondeo con dec decimales
function Round(numero, decimales)
{
	var Precision=Math.pow(10,decimales);
	var Res;
	
	if ((Precision!=null)&&(Precision>0))
		Res=(Math.round(numero*Precision))/Precision;
	else
		Res=numero;
	
	//console.log('Round('+numero+','+decimales+'). Res:'+Res);
	
	return Res;
}


// Redondeo con dec decimales
function RoundString(cad, decimales)
{
	var Precision=Math.pow(10,decimales);
	var Res;
	var numero=desformateaDivisa(cad);
	
	
	if ((Precision!=null)&&(Precision>0))
		Res=(Math.round(numero*Precision))/Precision;
	else
		Res=numero;
	
	//console.log('Round('+numero+','+decimales+'). Res:'+Res);
	
	return formateaDivisa(Res);
}


// 2jun22 Da formato a un numero decimal
// Calculamos los decimales a mostrar segun el valor de number
// number = 0	=> 0 decimales
// number < 10	=> 2 decimales
// number < 100	=> 1 decimal
// number > 100	=> 0 decimales
function AdjustNumber(number){

	var decimals;
	
    if(number == 0)			decimals = 0;
	else if(Math.abs(number) < 1)	decimals = 4;			//	23mar17
	else if(Math.abs(number) < 10)	decimals = 2;
    else if(Math.abs(number) < 100)	decimals = 1;
    else decimals = 0;

	var Res=formateaDivisa(Round(number,decimals));
	//console.log('AdjustNumber. num:'+number+' dec:'+ decimals+ ' res:'+Res);

	return(Res);
}


//	Comprueba si es nulo el valor de un campo  
function esNulo(valor)
{
	if(valor==''||valor=='NULL'||valor=='Null'||valor=='null')
		return true;
	else
		return false;
}

//	Comprueba una expresion regular
//  Entradas: Valor del string a chequear y expresion regular a chequear
//  Salidas: False o true segun si se cumple la expresion regular o no
function checkRegEx(checkString,regex){
	return regex.test(checkString);
}


//checkNumber checkNumber checkNumber checkNumber checkNumber checkNumber checkNumber 

//  Entradas: Valor del numero a chequear y objeto que contiene el numero para guardar cambios
//  Salidas: False o true segun si el formato es correcto o no.
//
//  Mira si checkString es un numero correcto:
//    valores:[0,9]
//    posibilidad de una coma para separar los decimales 
//    no puntos
//  Si lo es envia true si no envia false excepto que se corrija en el caso siguiente:
//    si hay puntos pide permiso para sacarlos. Si se confirma devuelve true.
//  Mira si hay mas de dos comas y si las hay muestra un mensaje de error y devuelve false.
                   
function checkNumber(checkString,objeto){			//	Utilizado en el mantenimiento de usuario, CVGenerar
	    
	checkString=String(checkString);
	newString = "";
	coma=0;
	punto=0;	    


	/*if(checkString==''){
	  alert('Error en el dato, ha introducido un valor nulo');
	  objeto.focus();	              
	  return false;
	}*/

	for (var i = 0; i < checkString.length; i++){
	  ch = checkString.substring(i, i+1);
	  if (ch >= "0" && ch <= "9"){
	    newString += ch;
	  }else{
	    if(ch == "."){
	      punto++;
	      if(punto==1){
	        newString += '.';
	      }	            
	    }
	    else{ 
	      if(ch == ","){
	        if(coma==0){
	          newString += '.';
	          coma=1;
	        }else{
	          alert('Error en el dato "'+checkString+'", ha introducido mas de una coma');
	          objeto.focus();	              
	          return false;
	        }
	      }
	      else{
	        alert('Error en el dato "'+checkString+'", ha introducido un valor numerico incorrecto');
	        objeto.focus();	              
	        return false;	            
	      }
	    }
	  }                
	}	     	
	if (punto>0){
	  // VERIFY WITH USER THAT IT IS OKAY TO REMOVE INVALID CHARACTERS
	  newStringFormateado=FormateaVis(newString);
	  if (confirm("El valor numerico "+checkString+" que ha introducido\ncontiene puntuacion en los miles.\nEste formato no es correcto,\ndesea cambiarlo por "+newStringFormateado+"?")) {
	    objeto.value=newStringFormateado;      	        	        
	    return true;
	  } else {
	    // RETURN ORIGINAL STRING
	    objeto.focus();	        
	    return false;
	  }
	}
	else{	    
	  return true;
	}

}


//Comprueba si un numero es nulo. Utilizando en MantenimientoReducido
function checkNumberNulo(checkString,objeto){

	checkString=String(checkString);
	newString = "";
	coma=0;
	punto=0;	    


  if(checkString==''){            
	return true;
  }
  else{

	for (var i = 0; i < checkString.length; i++){
	  ch = checkString.substring(i, i+1);
	  if (ch >= "0" && ch <= "9"){
	    newString += ch;
	  }else{
	    if(ch == "."){
	      punto++;
	      if(punto==1){
	        newString += '.';
	      }	            
	    }
	    else{ 
	      if(ch == ","){
	        if(coma==0){
	          newString += '.';
	          coma=1;
	        }else{
	          alert('Error en el dato '+checkString+', ha introducido mas de una coma');
	          objeto.focus();	              
	          return false;
	        }
	      }
	      else{
			  alert(ch);
	        alert('Error en el dato '+checkString+', ha introducido un valor numerico incorrecto');
	        objeto.focus();	              
	        return false;	            
	      }
	    }
	  }                
	}	     	
	if (punto>0){
	  // VERIFY WITH USER THAT IT IS OKAY TO REMOVE INVALID CHARACTERS
	  newStringFormateado=FormateaVis(newString);
	  if (confirm("El valor numerico "+checkString+" que ha introducido\ncontiene puntuacion en los miles.\nEste formato no es correcto,\ndesea cambiarlo por "+newStringFormateado+"?")) {
	    objeto.value=newStringFormateado;      	        	        
	    return true;
	  } else {
	    // RETURN ORIGINAL STRING
	    objeto.focus();	        
	    return false;
	  }
	}
	else{	    
	  return true;
	}
  }

}


/*
	Devuelve el identificador de una cadena con el siguiente formato:
		unNombre_1234      -->    1234
		otroNombre1234     -->    1234
	Utilizado en multiples pasos del pedido
*/
function obtenerId(nombre){
	var id='';
	for(var n=0;(n<nombre.length)&&(id=='');n++)
	{
		var car=nombre.substring(n,n+1);
		if(car=='_')
		{
			id=nombre.substring(n+1,nombre.length);
			n=nombre.length;
		}
		else
		{
    		if(car>='0'&&car<='9')
			{
        		id=nombre.substring(n,nombre.length);
        		n=nombre.length;  	
    		}
		}
  	}
  	return id	
}



//	Recupera parte de una cadena. Utilizado en multiples pasos del pedido
function obtenerSubCadena(fecha, posicion)
{

 var separador_1;
 var separador_2;

 var separadores=0;

 for(var n=0;n<fecha.length;n++){
   if(fecha.substring(n,n+1)=='/'){
     separadores++;
     if(separadores==1){
       separador_1=n;
     }
     else
       if(separadores==2)
         separador_2=n;
   }
 }
 if(posicion==1){
   return fecha.substring(0,separador_1);
 }
 else
   if(posicion==2){
     return fecha.substring(separador_1+1,separador_2);
   }
   else{
     return fecha.substring(separador_2+1,fecha.length);
   }

}


//	4may22 Busca en cadena varias palabras. Debe ser normalizado por la funcion que llame aqui. Devuelve posicion de la ultima cadena para SI o -1 para NO
function BuscaEnCadena(cad, busc)
{
	if (cad=='') return -1;
	if (busc=='') return 0;
	
	//	Solo se busca una palabra
	if (cad.indexOf(' ')==-1)
	{
		//solodebug	debug('BuscaEnCadena. Cad:'+cad+' busc:'+busc+' res:'+cad.indexOf(busc));		
		return cad.indexOf(busc);
	}
	
	var Existe=0;	
	for (var i=0;(Existe>=0)&&(i<=PieceCount(busc,' '));++i)
	{
		var str=Piece(busc,' ',i);
		//solodebug	debug('BuscaEnCadena['+i+']. Cad:'+cad+' str:'+str+' existe:'+cad.indexOf(str));
		Existe=cad.indexOf(str);
	}

	//solodebug	debug('BuscaEnCadena. Cad:'+cad+' busc:'+busc+' res:'+Existe);
	return Existe;
}


// 30jun22 Pluguin que permite desmarcar un radio button seleccionado previamente
(function(jQuery){
	jQuery.fn.uncheckableRadio = function() {

		return this.each(function(){
			jQuery(this).mousedown(function() 
			{
				jQuery(this).data('wasChecked', this.checked);
			});

			jQuery(this).click(function() {
				if (jQuery(this).data('wasChecked'))
				{
					this.checked = false;
                }
			});
		});
	};
})( jQuery );






//
//
//
//	Depuracion
//
//
//
	
function PresentaForms(document){
  var Msg=+'\n';
  for (j=0;j<document.forms.length;j++){
        Msg+='Form '+j+':'+document.forms[j].name+'\n';
		Msg+=Campos(document.forms[j])+'\n';
  }  
  return Msg;    
}

function Campos(formu){
  var Msg='';
  for (j=0;j<formu.elements.length;j++){
    if(formu.elements[j].type!='checkbox')
      Msg=Msg+'Campo '+j+':'+formu.elements[j].name 
      + '('+formu.elements[j].type+') = '
      +formu.elements[j].value+'\n';
    else
		if (formu.elements[j].checked)
			Msg=Msg+'Campo '+j+':'+formu.elements[j].name+' = Checked'+'\n';
		else		
			Msg=Msg+'Campo '+j+':'+formu.elements[j].name+' = NotChecked'+'\n';
  }  
  return Msg;    
}



//	LLamadas a paginas habituales

// Abre la ficha de producto
function FichaProducto(IDProducto, Busqueda, IDCliente)
{
	MostrarPagPersonalizada("http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle2022.xsql?PRO_ID="+IDProducto,'Ficha Producto',100,80,0,0);
}

// Abre la ficha de empresa
function FichaEmpresa(IDEmpresa)
{
	MostrarPagPersonalizada("http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame2022.xsql?EMP_ID="+IDEmpresa+"&VENTANA=NUEVA",'DetalleEmpresa',100,80,0,0);
}

// Abre la ficha de empresa
function FichaCentro(IDCentro)
{
	MostrarPagPersonalizada("http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle2022.xsql?ID="+IDCentro,'Centro',100,80,0,-20);
}

// Abre la ficha de producto
function MantenProducto(IDProducto, Busqueda, IDCliente)
{
	MostrarPagPersonalizada("http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROManten2022.xsql?PRO_ID="+IDProducto+"&TIPO=M&PRO_BUSQUEDA="+Busqueda+"&IDCLIENTE="+IDCliente/*+"&HISTORY="+obtenerHistoria()*/,'Mantenimiento Producto',100,80,0,0);
}

// Abre el catalogo privado (sin filtros)
function CatalogoPrivadoProducto(RefProducto, NombreProducto)
{
	MostrarPagPersonalizada("http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoPrivadoProducto2022.xsql?REFERENCIA="+RefProducto+"&DESCRIPCION="+encodeURIComponent(NombreProducto),'CatalogoPrivadoProducto',100,80,0,0);
}

// Abre la ficha de adjudicacion
function FichaAdjudicacion(IDProducto)
{
	MostrarPagPersonalizada("http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducido2022.xsql?PRO_ID="+IDProducto,'FichaAdjudicacion',100,80,0,0);
}

// Abre la ficha del pedido
function FichaPedido(IDMultioferta)
{
	MostrarPagPersonalizada("http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame2022.xsql?MO_ID="+IDMultioferta,'Pedido',100,80,0,0);
}

// 18may22 Abre la pagina de documentos del pedido
function DocumentosPedido(IDMultioferta)
{
	MostrarPagPersonalizada("http://www.newco.dev.br/Compras/Multioferta/MODocs2022.xsql?MO_ID="+IDMultioferta,'Pedido',100,80,0,0);
}

// 18may22 Abre un documento
function Documento(Fichero)
{
	MostrarPagPersonalizada("http://www.newco.dev.br/Documentos/"+Fichero,'Documento',100,80,0,0);
}

// Abre el catalogo privado (sin filtros)
function ControlPedido(IDPedido)
{
	MostrarPagPersonalizada("http://www.newco.dev.br/Personal/BandejaTrabajo/ControlPedidos.xsql?IDPEDIDO="+IDPedido,'ControlPedidos',100,100,0,0)
}

// Abre el catalogo privado (sin filtros)
function FichaLicitacion(IDLicitacion)
{
	MostrarPagPersonalizada("http://www.newco.dev.br/Gestion/Comercial/MantLicitacion2022.xsql?LIC_ID="+IDLicitacion,'Licitacion',100,80,0,0);
}

// Abre la ficha de producto de la licitacion
function FichaProductoLicitacion(IDLicitacion, IDProductoLic)
{
	MostrarPagPersonalizada("http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion2022.xsql?LIC_PROD_ID="+IDProductoLic+"&LIC_ID="+IDLicitacion,'Licitacion',100,80,0,0);
}

// cambia a la ficha de producto de la licitacion
function chFichaProductoLicitacion(IDLicitacion, IDProductoLic, Param)
{
	document.location="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion2022.xsql?LIC_PROD_ID="+IDProductoLic+"&LIC_ID="+IDLicitacion+Param;
}


//	1abr22 Abrir la pagina con la oferta completa de un proveedor
function OfertaProveedorLicitacion(IDLicitacion, IDProveedorLic)
{

	MostrarPagPersonalizada("http://www.newco.dev.br/Gestion/Comercial/ImprimirOferta.xsql?LIC_ID="+IDLicitacion+"&LIC_PROV_ID="+IDProveedorLic,'Oferta',100,80,0,0);
}

//	1abr22 Abrir la pagina con la oferta completa de un proveedor
function FicheroIntegracion(IDFichero)
{
	MostrarPagPersonalizada("http://www.newco.dev.br/Gestion/AdminTecnica/FicheroIntegracion.xsql?ID="+IDFichero,'FicheroIntegracion',100,100,0,0);
}	
	
//	Cambia a la convocatoria
function chConvocatoria(IDConvocatoria)
{
	document.location="http://www.newco.dev.br/ProcesosCdC/Convocatorias/Convocatoria2022.xsql?LIC_CONV_ID="+IDConvocatoria;
}
	
//	Cambia al buscador de licitaciones
function chLicitaciones()
{
	document.location="http://www.newco.dev.br/Gestion/Comercial/Licitaciones2022.xsql";
}
	
//	Cambia al mantenimiento de centro
function chFichaCentro(IDCentro)
{
	document.location="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENManten2022.xsql?CEN_ID="+IDCentro;
}

//	Cambia al mantenimiento de empresa
function chMantenEmpresa(IDEmpresa)
{
	document.location="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPManten2022.xsql?IDEMPRESA="+IDEmpresa;
}

//	Cambia al buscador de licitaciones
function chVencedores(IDLicitacion)
{
	document.location="http://www.newco.dev.br/Gestion/Comercial/licOfertasSeleccionadas2022.xsql?LIC_ID="+IDLicitacion;
}

//	3may22 Presenta la pagina con las selecciones
function MostrarSelecciones()
{
    MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/EIS/EISSelecciones2022.xsql', '_blank', 100, 80, 0, 10);
}

//	3may22 Presenta la pagina con las selecciones
function chSelecciones()
{
   document.location='http://www.newco.dev.br/Gestion/EIS/EISSelecciones2022.xsql';
}

// Abre el catalogo privado (sin filtros)
function chFichaLicitacion(IDLicitacion)
{
	document.location="http://www.newco.dev.br/Gestion/Comercial/MantLicitacion2022.xsql?LIC_ID="+IDLicitacion;
}

// Abre el catalogo privado (sin filtros)
function chLicPorProducto(IDLicitacion)
{
	document.location="http://www.newco.dev.br/Gestion/Comercial/Licitacion_V2_2022.xsql?LIC_ID="+IDLicitacion;
}

//	10may22 cambia a la pagina de incidencia
function chIncidencia(IDIncidencia, IDProducto, IDOferta)
{
	document.location="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencia2022.xsql?ID_INC="+IDIncidencia+"&PRO_ID="+IDProducto+"&LIC_OFE_ID="+IDOferta;
}

//	11may22 Nueva incidencia de producto
function NuevaIncidencia(IDProducto)
{
	MostrarPagPersonalizada("http://www.newco.dev.br/Administracion/Mantenimiento/Productos/NuevaIncidencia2022.xsql?PRO_ID="+IDProducto,'Evaluación producto',100,80,0,-10);
}

//	11may22 cambia a la pagina de evaluacion de producto
function chEvaluacionProd(ID)
{ 
	document.location="http://www.newco.dev.br/Gestion/Comercial/EvaluacionProducto2022.xsql?ID_EVAL="+ID;
}

//	11may22 mostrar catalogo privado producto empresa
function CatalogoPrivadoProductoEmpresa(idEmpresa, RefProd)
{
	MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoPrivadoProductoEmpresa2022.xsql?IDEMPRESA='+idEmpresa+'&REFERENCIA='+RefProd,'producto',60,50,-30,800);
}

//	11may22 Nueva incidencia de producto
function NuevaEvaluacion(IDProducto, IDProveedor)
{
	MostrarPagPersonalizada("http://www.newco.dev.br/Gestion/Comercial/NuevaEvaluacionProducto2022.xsql?PRO_ID="+IDProducto+"&EMP_ID="+IDProveedor,'Evaluación producto',100,80,0,-10);
}

//	16may22 Nueva solicitud de catalogacion
function NuevaSolicitudCat()
{
	document.location="http://www.newco.dev.br/Gestion/Comercial/NuevaSolicitudCatalogacion2022.xsql";
}
