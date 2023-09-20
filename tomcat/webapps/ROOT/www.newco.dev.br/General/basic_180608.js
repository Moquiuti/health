//	JS librerias básicas de MVM: en caso de cambios, renombrar y propagar nombre a todas las páginas XSL
//	Ultima revision: 26oct20

jQuery.noConflict();


// GLOBAL VARS
var arroba = '@';

// convert all characters to lowercase to simplify testing 
//alert(navigator.userAgent.toLowerCase());
var agt=navigator.userAgent.toLowerCase(); 

// *** BROWSER VERSION *** 
// Note: On IE5, these return 4, so use is_ie5up to detect IE5. 
var is_major = parseInt(navigator.appVersion); 
var is_minor = parseFloat(navigator.appVersion); 
// Note: Opera and WebTV spoof Navigator.  We do strict client detection. 
// If you want to allow spoofing, take out the tests for opera and webtv. 

var is_nav  = ((agt.indexOf('mozilla')!=-1) && (agt.indexOf('spoofer')==-1) 
            && (agt.indexOf('compatible') == -1) && (agt.indexOf('opera')==-1) 
            && (agt.indexOf('webtv')==-1)); 

var is_nav5 = (is_nav && (is_major == 5)); 
var is_nav5up = (is_nav && (is_major >= 5));
var is_nav47down = (is_nav && (is_minor < 4.7));    


var is_ie   = (agt.indexOf("msie") != -1);
var is_ie3  = (is_ie && (is_major < 4)); 
var is_ie4  = (is_ie && (is_major == 4) && (agt.indexOf("msie 5.")==-1) );    
var is_ie5  = (is_ie && (is_major == 4) && (agt.indexOf("msie 5.")!=-1) ); 
var is_ie5up  = (is_ie  && !is_ie3 && !is_ie4); 

var TOLERANCIA_IMPORTE_MINIMO=20;

//
//	Depuracion 
//
function MostrarCampos(formu)    
{
	var msg;
	for  (var i=0; i < formu.elements.length; i++)
	{
		msg=msg+formu.elements[i].name+":"+formu.elements[i].value+"\n\r";
	}
	alert(msg);
}



//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//	FUNCIONES DE COOKIES
//
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    
// Creacion de una cookie con nombre sName y valor sValue
function SetCookie(sName, sValue)
{ 
//estilo ke enseï¿½a - alert(sValue);
  document.cookie = sName + "=" + escape(sValue) + ";host=www.nucleo-medicalvm.com;path=/";	
}

//Retorna el valor de la cookie
function GetCookie(sName){ 
      if (document.cookie.length > 0) {   
	// cookies are separated by semicolons
	var aCookie = document.cookie.split("; ");
	for (var i=0; i < aCookie.length; i++)
	{
	  // a name/value pair (a crumb) is separated by an equal sign
	  var aCrumb = aCookie[i].split("=");
	  //alert('Cookie:Name='+aCrumb[0]+'. Value='+aCrumb[1]+'.');
	  if (sName == aCrumb[0]) 
	    return unescape(aCrumb[1]);
	}
	// a cookie with the requested name does not exist*/
	return null;
  }
  return null;
}

// Mira si existe la cookie.
// Si no existe la crea.
// Si existe y su valor es 'E' recargamos.
//
// Estados de la cookie:
// Iniciar
//   E - End.    Ya se ha recargado.
//   R - Reload. Se esta recargando. No volver a recargar.
//
// Terminar
//
function Actualitza_Cookie (nombre_cookie,estado){

    if (estado == 'Iniciar') {
  // Si no existe cookie la creamos con valor 'E' 
  if (GetCookie(nombre_cookie)==null) {
	SetCookie(nombre_cookie,'E');
	//document.location.href=document.location.href;
  } else {	    
	if (GetCookie(nombre_cookie)=='R') { //Si existe con valor 'R' la actualizamos y recargamos pagina.
	  SetCookie(nombre_cookie,'E');
	  document.location.href=document.location.href; // La ultima instruccion que se ejecuta
	}
  }
} else {
	if (estado == 'Terminar') {
		SetCookie(nombre_cookie,'R');	
	}
  }
//alert('sortim de la funcio nombre= '+nombre_cookie+' estado= '+estado+' valor= '+GetCookie(nombre_cookie));
}

	
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 //
 //	FUNCIONES DE SUBMIT
 //
 //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

     //
     // Funci?n para submit de formulario.
     //    Se valida que los datos sean validos para la Base de Datos.
     //
     var hayComillasSimples="false";  
   
     /*
     
     -- nacho -- modificaciones 16/10/2001
     
     modificaciones necesarias para integrar la funcion submit con las nuevas funciones de validaCamps.js
     
     SubmitForm()  - general.js -
     hace un barrido de todos los campos del formulario valida que no sea nulo y 
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
      if (hayComillasSimples=="false" && test(formu)){
        if(arguments.length>1){
      	  DeshabilitarBotones(arguments[1]);
      	}
      	formu.submit();
      }
    }
    

//
// Como checkForQuotesSin(checkString), pero con confirmaci?n.
//
//
// CHECK FIELDS - REPLACE ALL SINGLE QUOTES (') WITH A PAIR OF SINGLE QUOTES
//  (SQL SYNTAX REQUIREMENT).
function checkForQuotes(checkString){

    newString = "";    // REVISED/CORRECTED STRING
    count = 0;         // COUNTER FOR LOOPING THROUGH STRING

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
            if (ch >= " " && ch <= "~") {
                newString += ch;
            }
        }
      }
      if (checkString != newString) {
      // VERIFY WITH USER THAT IT IS OKAY TO REMOVE INVALID CHARACTERS
        if (confirm("El valor "+checkString+" que ha introducido\ncontiene comillas simples,\nla base de datos requiere que sean dobles.\n?Le parece bien que las cambiemos por "+newString+" ?")) {
          // RETURN REVISED STRING
          return newString;
        } else {
          // RETURN ORIGINAL STRING
          hayComillasSimples="true";
          return checkString;
        }
      }else{
        return checkString;
      }
      return newString;
    }
    else{
        return checkString;
    }        
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

		
/*
	Funcion de confirmacion de borrado.
	Se muestra un mensaje de confirmaci?n

	Montse Pans	30/Agosto/2000
*/
function ConfirmarBorrado(formu){        
  var contestacion = confirm("¿Está seguro de borrar el registro?");
  if (contestacion) {
	return true;
  }
  else return false;
}


function Linka(direccion){        	  
	document.location.href=direccion;
}

function AsignarAccion(formu,accion){
  formu.action=accion;
}

function Envia(formu,accion){
	formu.action='mailto:comercial@medicalvm.com';
	AsignarAccion(formu,accion);
	SubmitForm(formu);
}


function Navega(formu,pagina){
    formu.elements['ULTIMAPAGINA'].value=pagina;
	SubmitForm(formu);	    
}

	
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 //
 //	FUNCIONES DE FECHAS
 //
 //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

//TEST FECHA TEST FECHA TEST FECHA TEST FECHA TEST FECHA TEST FECHA TEST FECHA TEST FECHA TEST FECHA		  	  	
//
//  FechaD entre 1 i 31
//  FechaM entre 1 i 12
//  FechaA entre 2000 i 3000  
//
function test2(Fecha){ 
	return CheckDate(Fecha.value)};

//	24ene07	ET	Permitimos el formato con solo 2 cifras para el año
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

	
//
//  Funci?n de validaci?n de fechas.
//
//  Se validan los campos que empiezan por FECHA (excepto los que empiezan por FECHANO )
//  
//  Si hay algun error se devuelve false y se muestra un alert con los errores hallados.
//	
function test(Formu){
      errores="";
      ultima=0;
      // FECHANO = Fecha No Obligatoria          
      for(i=0;i<Formu.elements.length && errores=="";i++){ 
        if (Formu.elements[i].type == 'text') {
		if (Formu.elements[i].name.substr(0,7)=="FECHANO" && Formu.elements[i].value!=""){	          

		  errores=errores+test2(Formu.elements[i]);
		  ultima=i;
		}	  	
		else {

		  if (Formu.elements[i].name.substr(0,5)=="FECHA" && Formu.elements[i].name.substr(0,7)!="FECHANO"){     		    
		    errores=errores+test2(Formu.elements[i]);

		    ultima=i;
		  }
		}
         }	    
  }	  			    
  if (errores!=""){
	alert(errores);
	Formu.elements[ultima].focus();
	return (false);
  }else{
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


//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//	FUNCIONES DE SELECCION Y AGRUPACION DE CAMPOS
//
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


// Funcion que agrupa en un array los valores de diferentes checkbox que se llaman 
// con el mismo nombre: NombreCampoCheck.
//
// Ademas valida que, si estos campos estan seleccionados, tambien los campos adjuntos
// NombreCampoText tengan un valor num?rico mayor que cero. Si esto no ocurre
// damos el mensaje contenido en la variable Error1.
//
// Construimos un string con los valores (a,b),(a2,b2),
//  
//  El resultado se almacena en el campo 'NombreCampoCheck'+'TOTAL'
//
function productosSeleccionados(formu,NombreCampoCheck,NombreCampoText,Error1,Error2){         
  seleccion = new Array;
  var primeraVez = 0;
  if (validaCheckyCantidad(formu,NombreCampoCheck,NombreCampoText,Error1,Error2)==true){
	for(i=1; i<=formu.elements.length; i++){  
	  if (formu.elements[i-1].name==NombreCampoCheck && formu.elements[i-1].checked && primeraVez==0){
            seleccion='('+formu.elements[i-1].value+','+formu.elements[NombreCampoText+formu.elements[i-1].value].value+')';
            primeraVez=1;
          }
          else if (formu.elements[i-1].name==NombreCampoCheck && formu.elements[i-1].checked && primeraVez>0){          
            seleccion=seleccion+',('+formu.elements[i-1].value+','+formu.elements[NombreCampoText+formu.elements[i-1].value].value+')';
          }
        }
        formu.elements[NombreCampoCheck+'TOTAL'].value=seleccion;
      }
    }

//
//  Buscamos los elementos "ckecked" con el NombreCampoCheck
//
//    Si el campo Cantidad asociado (se llama NombreCampoText+valor dels check)
//      esta vacio mostramos el error1
//
//    Si la cantidad es <=0 ? no numerica mostramos el error2
//
//
function validaCheckyCantidad(formu,NombreCampoCheck,NombreCampoText,Error1,Error2){  	
	for(i=1; i<=formu.elements.length; i++) 
	if (formu.elements[i-1].name==NombreCampoCheck && formu.elements[i-1].checked)
	  if (formu.elements[NombreCampoText+formu.elements[i-1].value].value=="") {
		alert(Error1);
		formu.elements[NombreCampoText+formu.elements[i-1].value].focus();
		return false;
	  }
	  else if (formu.elements[NombreCampoText+formu.elements[i-1].value].value <= 0 ||
	    	 isNaN(formu.elements[NombreCampoText+formu.elements[i-1].value].value)) {
	    	 alert(Error2);
	    	 return false;
		   }
	return true;
}
        
//
//  Alguno de los elementos esta seleccionado ??
// 
//  Si no hay ninguno devuelve false y muestra error 
//
function valida_alguna_seleccion(formu,NombreCampoCheck,Error){
	var alguna_seleccion=0;
	for(i=1; i<=formu.elements.length; i++){
	if (formu.elements[i-1].name.substr(0,NombreCampoCheck.length)==NombreCampoCheck && 
		formu.elements[i-1].checked)
	{
    	  alguna_seleccion=1;
    	  break;
    	}
	  }
	  if (alguna_seleccion==0){
    	alert(Error);
    	return false;
	  }
	  else{
	return true;
	}
}        

//
//  Buscamos los elementos "ckecked" con el NombreCampoCheck
//    Si el campo Cantidad asociado (se llama NombreCampoText+valor dels check)
//      esta vacio mostramos el error1
//    Si la cantidad es <=0 ? no numerica mostramos el error2        
//        	
//  Como validaCheckyCantidad pero sin mostrar el alert del campo de text
//  Se utiliza si ya se valida antes, para que no salgan dos alerts.
//
function validaCheckyCantidadSin(formu,NombreCampoCheck,NombreCampoText,Error1){
	  for(i=1; i<=formu.elements.length; i++) {
	    //Encuentro campo asociado al check
	    if (formu.elements[i-1].name==NombreCampoCheck && formu.elements[i-1].checked){
	      //Si campo vacio aviso que se rellene
	      if (formu.elements[NombreCampoText+formu.elements[i-1].value].value=="" || formu.elements[NombreCampoText+formu.elements[i-1].value].value==0) {
	        alert(Error1);
	        formu.elements[NombreCampoText+formu.elements[i-1].value].focus();
	        return false;
	      }
	      //Si campo no vacio, miro que tenga un valor correcto: numero mayor que cero
	      else if (formu.elements[NombreCampoText+formu.elements[i-1].value].value < 0 ||
	             isNaN(formu.elements[NombreCampoText+formu.elements[i-1].value].value)) {
	             return false;
	           }
	    }
	  }
	  return true;
}              
         
// BorrarSeleccionados BorrarSeleccionados BorrarSeleccionados BorrarSeleccionados BorrarSeleccionados 

// Se pide permiso al usuario para borrar las lineas seleccionadas (checkbox)
// Si dice que si se envia un array con los valores de las lineas seleccionadas
function BorrarSeleccionados(formu,nombre_campo,accion,msg_sel_alguna){
  if(HaySeleccion(formu,nombre_campo,msg_sel_alguna)){
    agrupaArray(formu,nombre_campo);
    Envia(formu,accion);
  }
}

//
// Crea una lista con todos los campos hidden (nombre,valor),(nombre2,valor2)
//	de todos los formularios de la pagina.
//
//
//  El campo nombreCampo no se copia en el resultado.
//
// Esto permite pasar todos los parametros codificados a otra pagina para poder volver posteriormente.
//
function agrupaArrayHiddens(nombreCampo){
      seleccion = new Array;
      var primeraVez = 0;
  for (i=0; i<document.forms.length;i++) {
        for (j=0; j<document.forms[i].elements.length;j++) {
          if (document.forms[i].elements[j].type=='hidden' && document.forms[i].elements[j].name!=nombreCampo) {	    
	    if (primeraVez==0){
              seleccion='('+document.forms[i].elements[j].name+','+document.forms[i].elements[j].value+')';
              primeraVez=1;
            } else {
              seleccion=seleccion+','+'('+document.forms[i].elements[j].name+','+document.forms[i].elements[j].value+')';
            }
          }
        }
      }

      return seleccion;
    }


// HaySeleccion HaySeleccion HaySeleccion HaySeleccion HaySeleccion HaySeleccion HaySeleccion 

//
//Mira si hay algun campo nombre_campo (tipo checkbox) seleccionado
//
//
//Si es el caso confirma el borrado
//Si no es el caso devuelve un mensaje de error Error1 para que se seleccione alguna.
//
function HaySeleccion(formu,nombre_campo,msg_sel_alguna){
  var AlgunaSeleccionada=0;  
  for (i=0;i<formu.elements.length;i++){
    if ((formu.elements[i].type=="checkbox") && (formu.elements[i].name.substring(0,nombre_campo.length)==nombre_campo) &&
       (formu.elements[i].checked)){
        AlgunaSeleccionada++;
        break;
    }
  }

  if (AlgunaSeleccionada>=1){
    return(ConfirmarBorrado(formu));
  }
  else {
    alert(msg_sel_alguna);
    return false;
  }
}
        
        
        
// AGRUPA ARRAY AGRUPA ARRAY AGRUPA ARRAY AGRUPA ARRAY AGRUPA ARRAY AGRUPA ARRAY AGRUPA ARRAY
//
// Funcion que agrupa en un array los valores de diferentes checkbox que se llaman 
// con el mismo nombre: NombreCampoCheck si se cumple Condicion y devuelve true.
// Si la condicion no se cumple devuelve false
//
function agrupaArray(formu,NombreCampoCheck){

  longitud=NombreCampoCheck.length;
  seleccion = new Array;
  var primeraVez = 0;
	for(i=0; i<formu.elements.length; i++){
	if (formu.elements[i].name.substr(0,longitud)==NombreCampoCheck && formu.elements[i].name.substr(longitud,5)!='TOTAL' && formu.elements[i].checked){
	  if (primeraVez==0){
        	seleccion=formu.elements[i].value;
        	primeraVez=1;
    	  }
    	  else {
        	seleccion=seleccion+','+formu.elements[i].value;
    	  }
    	}
	  }
  formu.elements[NombreCampoCheck+'TOTAL'].value=seleccion;
}

//Lo mismo que agrupaArray pero ahora con los no seleccionados
function notAgrupaArray(formu,NombreCampoCheck){
      longitud=NombreCampoCheck.length;          
      notseleccion = new Array;
      var firstTime = 0;
  for(i=0; i<formu.elements.length; i++){
	if (formu.elements[i].name.substr(0,longitud)==NombreCampoCheck && formu.elements[i].name.substr(longitud,5)!='TOTAL' && !formu.elements[i].checked){
          if(firstTime==0){ 
            notseleccion=formu.elements[i].value;
            firstTime=1;
          }else{  
            notseleccion=notseleccion+','+formu.elements[i].value;
          }                
        }
      }
      formu.elements['NO'+NombreCampoCheck+'TOTAL'].value=notseleccion;
    }               


function ValidarStringCantidades(formu) { // Olivier:se llama desde las paginas que permiten modificar cantidades durante el proceso de compras.
	 var cadena="";
	 var cant;
	 for (i=0;i<formu.length;i++)
	    {
	    if (formu.elements[i].name.substring(0,14)=="NuevaCantidad_")
	        {
		        if (formu.elements[i].value =='') {
		          alert("Por favor, introduzca una cantidad. Gracias");
		          formu.elements[i].focus();
		          return false;
		        } else {
		           // Validamos el numero con checkNumber. Este ya devuelve el mensaje de error.
		           if (!checkNumber(formu.elements[i].value,formu.elements[i])) return false;
		        }

	        }
	    }

	    return true;
}



 //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 //
 //	FUNCIONES DE FORMATEO DE NUMEROS
 //
 //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
   
//FormateaVis FormateaVis FormateaVis FormateaVis FormateaVis FormateaVis FormateaVis 

//  EL PUNTO DE LOS DECIMALES LO CONVIERTE EN COMA

function FormateaVis(Numero){
	Numero=String(Numero);
	vector = Numero.split(".");
	if (vector.length==2) return ((vector[0])+','+(vector[1]));
	else return Number(vector[0]);
}
	  
//
//
//
//
//
//

// Antiformatea Antiformatea Antiformatea
function Antiformatea(numero) 
{	
	n=numero.indexOf(".");
	while(n>=0)
	{
		if (n>=0) numero=numero.substring(0,n)+numero.substring(n+1,numero.length);
		n=numero.indexOf(".");
	}
	n2=numero.indexOf(",");
	if (n2>=0) numero=numero.substring(0,n2)+"."+numero.substring(n2+1,numero.length);
	
	return numero;		
}


//AntiformateaVis AntiformateaVis AntiformateaVis AntiformateaVis AntiformateaVis AntiformateaVis

//  Entradas: Valor del numero a chequear y objeto que contiene el numero para guardar cambios
//  Salidas: El mismo numero o el corregido.
//  Mira si checkString es un numero correcto:
//    valores:[0,9]
//    posibilidad de una coma para separar los decimales 
//    no puntos
//  LA COMA DE LOS DECIMALES LA CONVIERTE EN PUNTO
//  Si hay puntos pide permiso para sacarlos.
//  Mira si hay mas de dos comas y si las hay muestra un mensaje de error.
//  Si el numero continua sin ser correcto muestra un error.

function AntiformateaVis(Numero,objeto){
	Numero=String(Numero);
	newNumber = "";    // REVISED/CORRECTED STRING
	coma=0;
	punto=0;	    
	for (var l = 0; l < Numero.length; l++) {
	    ch = Numero.substring(l, l+1);

	    if (ch >= "0" && ch <= "9") {
	      newNumber += ch;
	    }else{
	      //Si encontramos un punto, la primera vez lo conservamos 
	      //las siguientes las quitamos.
	      if (ch == ".") {
	        punto++;
	        if (punto==1){
	          newNumber += '.';
	        }	          
	      }
	      else{
	        //Si encontramos una coma, la primera vez la convertimos a punto
	        //las otras mostramos alert.
	        if (ch == ",") {
	          if(coma==0){
	            newNumber += '.';
	            coma=1;
	          }else{
	            alert('Error en el dato '+Numero+', ha introducido m?s de una coma');
	            objeto.focus();
	            return Number(Numero);
	          }
	        }	             
	        else {
	          //Si encontramos otro caracter mostramos alert.
	          alert('Ha introducido el valor '+Numero+' . Por favor, reemplacelo por un n?mero correcto');
	          objeto.focus();
	          return Number(Numero);
	        }
	      }
	    }                
	}
	if (punto>0) {
	  // Aqui tenemos en Newnumber el numero sin puntos con una coma en los decimales
	  // Pero hemos tenido que hacer una conversion y le pedimos confirmacion al
	  // usuario
	  newNumberFormateado=FormateaVis(newNumber);
	  if (confirm("El valor numerico "+Numero+" que ha introducido\ncontiene puntuacion en los miles.\nEste formato no es correcto, \ndesea cambiarlo por "+newNumberFormateado+"?")) {
	    // RETURN REVISED STRING
	    objeto.value=newNumberFormateado; 
	    return Number(newNumber);
	  } else {
	    // RETURN ORIGINAL STRING
	    objeto.focus();	        
	    return Number(Numero);	        
	  }
	}
	else{	    
	  newNumber=Number(newNumber);
	  return newNumber;
	}
}  


function FormateaNumero(Numero){
    	//alert('Numero: '+Numero);
	Numero=String(Numero);
	if(tienePunto(Numero))
	  Numero=reemplazaPuntoPorComa(Numero);
	var nuevoNumero = "";    // REVISED/CORRECTED STRING
	var nuevaParteEntera;
	var coma=0;
	var punto=0;
	// Aqui falta comprobar el numero.	    
	var vect = Numero.split(",");
	parteEntera = vect[0];
	//alert('parteEntera :'+parteEntera);
	parteDecimal = vect[1];
	//alert('parteDecimal: '+parteDecimal);
	count=0;
	for (var l = parteEntera.length-1; l >= 0; l--) {
		ch = Numero.substring(l-1, l);	        
		if (count%3==0){	          
        	  if (ch!='.'){
            	nuevaParteEntera=ch+'.'+nuevaParteEntera;count++;
        	  }else{
            	nuevaParteEntera=ch+nuevaParteEntera;                  
        	  }
        	}else{
        	  nuevaParteEntera=ch+nuevaParteEntera;count++;
        	}
	}
	nuevoNumero=nuevaParteEntera+','+parteDecimal;

	return nuevoNumero;
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
                   
function checkNumber(checkString,objeto){
	    
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

//checkRegEx checkRegEx checkRegEx checkRegEx checkRegEx checkRegEx checkRegEx
//
//  Entradas: Valor del string a chequear y expresion regular a chequear
//  Salidas: False o true segun si se cumple la expresion regular o no
function checkRegEx(checkString,regex){
	var res = regex.test(checkString);
	return res;
}

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
	

//
//	La siguiente funci?n comprueba si una cadena contiene un numero decimal correcto
//	separado por coma (opcionalmente con puntos decimales).
//
//	Cuidado! Por ahora no controla que los puntos decimales est?n correctamente situados
//
function checkDecimal(Cad){
	checkString=String(Cad);
	coma=0;
	for (var i = 0; i < checkString.length; i++) 
	{
	    ch = checkString.substring(i, i+1);

	    if (ch < "0" || ch > "9") 
		{
	      if (ch == ".") 
		  {
			//	No controlamos los puntos
	      }
	      else
		  { 
	        if ((ch == ",") && (coma==0))//	Si solo hay una coma, aceptamos la cadena como v?lida
			{
	          coma=1;
	        }
	        else
	          return false;	            
	      }
	    }                
	}	     	
	return true;
}         




// CHECK STRING - ENSURE ALL CHARACTERS ARE DIGITS
function toInteger(checkString)
{
    newString = "";    // REVISED/CORRECTED STRING
    count = 0;         // COUNTER FOR LOOPING THROUGH STRING

    // LOOP THROUGH STRING CHARACTER BY CHARACTER
    for (i = 0; i < checkString.length; i++) {
        ch = checkString.substring(i, i+1);

        // ENSURE CHARACTER IS A DIGIT
        if (ch >= "0" && ch <= "9") {
            newString += ch;
        }
    }

    if (checkString != newString) {
      // VERIFY WITH USER THAT IT IS OKAY TO REMOVE INVALID CHARACTERS
      if (confirm("El valor que ha introducido contiene caracteres invalidos, ?desea borrarlos?")) {
        // RETURN REVISED STRING
        return newString;
      } else {
        // RETURN ORIGINAL STRING
        return checkString;
      }
    }
    return checkString;
}

function Integer(checkString)
{
    oldString = checkString.value;
    newString = "";    // REVISED/CORRECTED STRING
    count = 0;         // COUNTER FOR LOOPING THROUGH STRING

    // LOOP THROUGH STRING CHARACTER BY CHARACTER
    for (i = 0; i < oldString.length; i++) {
        ch = oldString.substring(i, i+1);

        // ENSURE CHARACTER IS A DIGIT
        if (ch >= "0" && ch <= "9") {
            newString += ch;
        }
    }
    if (oldString != newString) {
      alert('Introduzca un valor numerico correcto');
      checkString.value=0;
      checkString.focus;
      return false;
    }else{
      return true;
    }
}


// REDONDEO DECIMALES REDONDEO DECIMALES REDONDEO DECIMALES REDONDEO DECIMALES REDONDEO DECIMALES

// Nombre: Decimales
function Decimales(num, decimales, corte)
{
  var aux, valor="";
  var puntoDecimal, resultado, decimalesAux;
  //Miro si le decimos que no ponga decimales
  if (decimales==0){
    resultado=Math.round(num);
  }else{

  // Miro si es del tipo '0.xxxx' ? '-0.xxxx'
  aux= Math.abs(num);
  if (((aux < 0) || (aux >= 1)))
  {

    // Multiplico por 10 elevado a la precisi?n
    
    valor+= Math.round(num * Math.pow(10, (decimales + corte))); 
    
    // Busco donde deber?a estar el punto
    puntoDecimal = valor.length - (decimales + corte);
  
    if(puntoDecimal != 0)
    {
      // Recoloco el punto decimal en la posici?n adecuada
      resultado = valor.substring(0, puntoDecimal);
      resultado += ",";
      resultado += valor.substring(puntoDecimal, (valor.length - corte));
    }
    else
    {
      resultado = valor;
    }
  }
  else
  {
    // N?mero en valor absoluto entre 0 y 1, del tipo 0.xxxxx
    // Copio el numero.
    valor+= num;
    // Si es cero, le pongo el punto decimal.
    if (num == 0)
    {
      valor+=",";
    }
    
    // El numero de caracteres que compondr?n la cifra es de 'decimales+2' (por el '0.') en
    //  el caso de n?meros positivos, o de 'decimales+3' (por el '-0.') en el de negativos.
    if (num >= 0)
    {
      decimalesAux= decimales + 2;
    }
    else
    {
      decimalesAux= decimales + 3;
    }
    
    // Verifico si la cadena tiene un tama?o igual o superior al pedido.
    aux=valor.length;
    if (aux >= decimalesAux)
    {
      // Corto la cadena como resultado
      resultado= valor.substring(0, decimalesAux);
      
      // Verifico que no se de el caso '-0.0000'
      aux= parseFloat(resultado);
      if ((num !=0) && (aux ==0))
      {
        // Lo normalizo
        resultado= 0;
      }
        
    }
    else
    {
      // Le tengo que a?adir ceros hasta complementar el valor
      resultado= valor;
      for (;aux < decimalesAux; aux++)
      {
        resultado += "0";
      }
    } 
  }
  }
  
  // Devuelve el valor
  return resultado;
  
}


//  como Decimales pero en vez de coma se coloca punto
function Decimales_con_punto(num, decimales, corte)
{
  var aux, valor="", parte_entera;
  var puntoDecimal, resultado, decimalesAux;
  //Miro si le decimos que no ponga decimales
  if (decimales==0){
    resultado=Math.round(num);
  }else{

  // Miro si es del tipo '0.xxxx' ? '-0.xxxx'
  aux= Math.abs(num);
  if (((aux < 0) || (aux >= 1)))
  {
    // Multiplico por 10 elevado a la precisi?n            
    valor+= String(Math.round(num * Math.pow(10, (decimales + corte)))); 
    // Busco donde deber?a estar el punto
    
    puntoDecimal = valor.length - (decimales + corte);
  
    if (puntoDecimal != 0)
    {
      // Recoloco el punto decimal en la posici?n adecuada
      resultado = valor.substring(0, puntoDecimal);
      resultado += ".";
      resultado += valor.substring(puntoDecimal, (valor.length - corte));
    }
    else
    {
      resultado = valor;
    }
  }
  else
  {
    // N?mero en valor absoluto entre 0 y 1, del tipo 0.xxxxx
    // Copio el numero.
    valor+= num;
    // Si es cero, le pongo el punto decimal.
    if (num == 0)
    {
      valor+=".";
    }
    
    // El numero de caracteres que compondr?n la cifra es de 'decimales+2' (por el '0.') en
    //  el caso de n?meros positivos, o de 'decimales+3' (por el '-0.') en el de negativos.
    if (num >= 0)
    {
      decimalesAux= decimales + 2;
    }
    else
    {
      decimalesAux= decimales + 3;
    }
    
    // Verifico si la cadena tiene un tama?o igual o superior al pedido.
    aux=valor.length;
    if (aux >= decimalesAux)
    {
      // Corto la cadena como resultado
      resultado= valor.substring(0, decimalesAux);
      // Verifico que no se de el caso '-0.0000'
      aux= parseFloat(resultado);
      if ((num !=0) && (aux ==0))
      {
        // Lo normalizo
        resultado= 0;
      }
        
    }
    else
    {
      // Le tengo que a?adir ceros hasta complementar el valor
      resultado= valor;
      for (;aux < decimalesAux; aux++)
      {
        resultado += "0";
      }
    } 
  }
  }
  
  // Devuelve el valor
  return resultado;
  
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//	MISC FUNCTIONS
//
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
//	Comprueba si un CheckBox est? activado o desactivado
function CompruebaCheck(form, NombreCheck)
{
	if (form.elements[NombreCheck].checked==true)
		return 'S';
	else
		return 'N';
}


//
//  Abre una nueva ventana. Controla si existe otra ventana abierta.
//
// 
var producto = null;
        
function MostrarPag(pag,titulo)
{  
	var	ample, alcada, esquerra, alt;

	if(titulo==null)
		var titulo='MedicalVM';

	try		//	Error accediendo desde Purchasing
	{
		if(top.name=='newMain')
		{
			ample = top.screen.availWidth-100;
			alcada = top.screen.availHeight-100;

			esquerra = (top.screen.availWidth-ample) / 2;
			alt = (top.screen.availHeight-alcada) / 2;
		}
	}
	catch(e)
	{
		ample=-1;
	}

	if (ample==-1)
	{
		var anchoVentanaPadre;
		var altoVentanaPadre;

		anchoVentanaPadre=obtenerAnchoVentanaPadre(window);
		altoVentanaPadre=obtenerAltoVentanaPadre(window);

		ample = anchoVentanaPadre;
		alcada = altoVentanaPadre-50;

		esquerra = (parent.screen.availWidth-ample) / 2;
		alt = (parent.screen.availHeight-alcada) / 2;
	}

	if (ventana && ventana.open)
	{
		ventana.close();            
	}
	titulo=window.open(pag,titulo,'toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',screenX='+esquerra+',screenY='+alt);
	titulo.focus();
}
        
        
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




/* la funcion de alerta */
function MostrarAlerta(titulo,codigo){  

  var ventanaAlerta='alerta';  
  var pag='http://www.newco.dev.br/General/Alerta.xsql?TITULO='+titulo+'&CODIGO_MENSAJE='+codigo;

  // si es navigator
  if (is_nav){
    // es main
    if(top.name=='newMain'){

      ample = 80;
      alcada = 50;

      esquerra = 0;
      alt = 0;
    }
    // no es main
    else{

      ample = 80;
      alcada = 50;


      esquerra = 0;
      alt = 0;
    }
  }
  // estamos en explorer
  else{
    // es main
    if(top.name=='newMain' ||top.name=='mainMVM'){
      ample = 80;
      alcada = 50;

      esquerra = 0;
      alt = 0;
    }
    // no es main
    else{

      ample = 80;
      alcada = 50;


      esquerra = 0;
      alt = 0;
    }
  }

  // llamamos a alerta personalizada
  MostrarAlertaPersonalizada(titulo,codigo,ample,alcada,esquerra,alt);

}

/* fin de la funcion de alerta  */


/* mostrar alerta personalizada */

function MostrarAlertaPersonalizada(titulo,codigo,p_ancho,p_alto,p_desfaseLeft,p_desfaseTop){  

  // el titulo
  var ventanaAlerta='alerta';  
  var pag='http://www.newco.dev.br/General/Alerta.xsql?TITULO='+titulo+'&CODIGO_MENSAJE='+codigo;

  //es navigator  
  if(is_nav){

    ample = (top.screen.availWidth*p_ancho)/100;
    alcada = (top.screen.availHeight*p_alto)/100;

    esquerra = parseInt(((top.screen.availWidth-ample) / 2)+((((top.screen.availWidth-ample) / 2)*p_desfaseLeft)/100));
    alt = parseInt(((top.screen.availHeight-alcada) / 2)+((((top.screen.availHeight-alcada) / 2)*p_desfaseTop)/100));  

    // cerramos la ventana si esta abierta
    if(ventanaAlerta && ventanaAlerta.open){
      ventanaAlerta.close();            
    }

    // mostramos la ventana
    ventanaAlerta=window.open(pag,ventanaAlerta,'toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',screenX='+esquerra+',screenY='+alt);
    ventanaAlerta.focus();


  }
  // es explorer
  else{

    ample = (top.screen.availWidth*p_ancho)/100;
    alcada = (top.screen.availHeight*p_alto)/100;

    esquerra = parseInt(((top.screen.availWidth-ample) / 2)+((((top.screen.availWidth-ample) / 2)*p_desfaseLeft)/100));
    alt = parseInt(((top.screen.availHeight-alcada) / 2)+((((top.screen.availHeight-alcada) / 2)*p_desfaseTop)/100));  

    // cerramos la ventana si esta abierta
    if (ventanaAlerta &&  ventanaAlerta.open && !ventanaAlerta.closed){
         ventanaAlerta.close();
    }

				// mostramos la pagina
	  ventanaAlerta=window.open(pag,ventanaAlerta,'toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',top='+alt+',left='+esquerra);
	  ventanaAlerta.focus();

  }
}
        

        
function AbrirVentana(pag,titulo){
//alert('mi'+pag);

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
    titulo=window.open(pag,titulo);
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
	titulo=window.open(pag,titulo);
	titulo.focus();
  }
}
        
        
        
function obtenerAnchoVentanaPadre(ventana){
  if (is_nav)
    return(window.innerWidth);
  else
    return(screen.availWidth-(window.screenLeft*2));
}

function obtenerAltoVentanaPadre(ventana){
  if (is_nav)
    return(window.innerHeight);
  else
    return(screen.availHeight-(window.screenTop*2));
}	  		  	  	
 
 
	
// Muestra una capa  (!! Sustituir por jQuery)
function show(capa) {
    if (is_nav){
      if (is_nav5up){
        document.getElementById(capa).style.visibility = 'visible';
      }
      else{	
        document.layers[capa].visibility = 'show';
      }
    }      
    else{
        document.all[capa].style.visibility = 'visible';
    }
}


// Oculta una capa (!! Sustituir por jQuery)
function hide(capa) {
    if (is_nav){
      if (is_nav5up){     
        document.getElementById(capa).style.visibility = 'hidden';          
      }
      else{	
        document.layers[capa].visibility = 'hide';
      }
    }      
    else{
        document.all[capa].style.visibility = 'hidden';
    }       
}

// Alinea texto a la derecha en input text
function alineaCelda(celda){
  if (navigator.appName=="Microsoft Internet Explorer") celda.style.textAlign="right";
}

//
// Cambia imagen dinamicamente teniendo en cuenta el caso de que haya dos imagenes
// con el mismo nombre.
//
// Parametros:
//		nombre: Nombre del img
//		direccion: URL de la imagen
function cambiaImagen(nombre,direccion){
  if (nombre!=""){
    for(var i=0;i<document.images.length;i++){
      if (document.images[i].name==nombre){
        document.images[i].src=direccion;
      }
    }
  }
}

// Nos abre una ventana desde un ancla llamada 'name' con la 'url' especificada 
// pensada para contener una definicion.
// Si ya hay abierta una cierra la anterior.
var ventana=null;
function showDefinition(e,url,name) {
    var x=y=0;
    
    if (e != '') {
        x = e.screenX;
        y = e.screenY;
    }
    ancho=window.screen.availWidth*0.75;
    alto=window.screen.availHeight*0.75;    
    if (ventana && ventana.open) ventana.close();            
    ventana=window.open(url,name,'toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ancho+',height='+alto+',screenX=' + x + ',screenY=' + y + ',left=' + x + ',top=' + y);
}

	
// permite imprimir el frame principal
function ImprimirPag(){
	parent.frames['mainFrame'].focus();
	parent.frames['mainFrame'].print();
}

function Imprimir(){
	window.print();
}


//
//Pone en el array args los argumentos de una pagina html
//
//
function getArgs() {  
    var args = new Object(); 
    var query = location.search.substring(1);  
    var pairs = query.split("&");//alert(pairs);  
    for (var i = 0; i < pairs.length; i++) {  
      var pos = pairs[i].indexOf('=');
      if (pos == -1) continue;  
      var argname = pairs[i].substring(0,pos);  
      var value = pairs[i].substring(pos+1);  
      args[argname]=value;
    } 
    return args;
} 	
 

// Permite detectar la resolucion de la pantalla para todos los tipos de navegadores
function DetectaResolucion()
{
   
    var res;
    if (self.screen) {     // para NN4 y IE4
            width = screen.width
            height = screen.height
    // Testing this first prevents firing the slow Java of NN4
    }
    else if (self.java) {   // para NN3 con Java activado
           var jkit = java.awt.Toolkit.getDefaultToolkit();
           var scrsize = jkit.getScreenSize();       
           width = scrsize.width; 
           height = scrsize.height; 
    }
    else{
    	width = height = '?' // N2, E3, N3 w/Java off, probably Opera and WebTV
    }

    res=[width,height];
    return res;
}

function itemOver(obj)
{
	obj.style.cursor="hand";
}


//
//	Algunas funciones ?tiles
//


//	Redondea un numero con una precision dada
function Round(numero, decimales)
{
	var i;
	var Precision=Math.pow(10,decimales);
	return (Math.round(numero*Precision))/Precision;
}

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

/*
	Comprueba si existe una subcadena
	la funcion original de javascript daba problemas en el uso de nulos y con algunos caracteres ('?', '|')
*/
function existeSubCadena(cadenaRecipiente, cadenaBuscada)
{

  if(cadenaBuscada.length==0 ||cadenaRecipiente.length==0)
  {
    return false;
  }
  else{
    if(cadenaBuscada.length>cadenaRecipiente.length)
	{
      return false;
    }
    else
	{
      for(var n=0;n<=cadenaRecipiente.length-cadenaBuscada.length;n++)
	  {

        var subCadenaTemp=cadenaRecipiente.substring(n,n+cadenaBuscada.length);

        if(subCadenaTemp==cadenaBuscada)
		{
          return true;
        }
      }
      return false;
    }
  }
}




/*

devuleve el identificador de una cadena con el siguiente formato

        unNombre_1234      -->    1234
        
              ?
              
        otroNombre1234     -->    1234

*/
function obtenerId(nombre){
  var id;
  for(var n=0;n<nombre.length;n++){
    if(nombre.substring(n,n+1)=='_'){
      id=nombre.substring(n+1,nombre.length);
      n=nombre.length;
    }
    else{
      if(nombre.substring(n,n+1)=='0' ||
         nombre.substring(n,n+1)=='1' ||
         nombre.substring(n,n+1)=='2' ||
         nombre.substring(n,n+1)=='3' ||
         nombre.substring(n,n+1)=='4' ||
         nombre.substring(n,n+1)=='5' ||
         nombre.substring(n,n+1)=='6' ||
         nombre.substring(n,n+1)=='7' ||
         nombre.substring(n,n+1)=='8' ||
         nombre.substring(n,n+1)=='9'){
         id=nombre.substring(n,nombre.length);
         n=nombre.length;  	
      }
    }
  }
  return id	
}


// FormateaVisNacho
//recibe un numero con puntos decimales si la puntuacion en con coma lo pasa a punto si es con punto a coma
function FormateaVisNacho(Numero){
	
  Numero=String(Numero);
  
  var vector = Numero.split(".");
  if (vector.length==2) 
    return ((vector[0])+','+(vector[1]));
  else 
    vector = Numero.split(",");
    if (vector.length==2) 
      return ((vector[0])+'.'+(vector[1]));
    else
      return Number(vector[0]);
}
	
//
function reemplazaPuntoPorComa(Numero){
	
  Numero=String(Numero);
  
  var vector = Numero.split(".");
  if (vector.length==2) 
    return ((vector[0])+','+(vector[1]));
  else 
    return Number(vector[0]);
}

function reemplazaSeparadorDecimal(Numero, separador){
	
  Numero=String(Numero);
  
  var vector = Numero.split(',');
  if (vector.length==2) 
    return ((vector[0])+separador+(vector[1]));
  else 
    return Number(vector[0]);
}

//
function reemplazaComaPorPunto(Numero){
 
  sNumero=String(quitaPuntos(Numero));
 
  var vector = Numero.split(",");
  if (vector.length==2) 
    return ((vector[0])+'.'+(vector[1]));
  else 
    return Number(vector[0]);
}

	//
	//
	//
	//
	//
	    /*
    Nacho 4/12/2001
    funcion que recibe un obj tipo texto
    si el numero (con o sin decimales) no tiene formato se lo da si lo tiene no hace nada
    (los puntos han de ser correctos)
    1000000,10 --> 1.000.000,10 
    1000000.10 --> 1000000,10 -->1.000.000,10
    
	18dic16	!!	Se utiliza todavía en licitaciones y varias páginas, cambiar nombre
	
    */
    
function FormateaNumeroNacho(valor){

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
	//alert('parteEntera :'+parteEntera);
	if(vectorValores.length==2){
	  parteDecimal = vectorValores[1];
	  //alert('parteDecimal: '+parteDecimal);
	}
	nuevaParteEntera='';
	contador=0;
	for (var n = parteEntera.length; n > 0; n--) {
	    ch = valor.substring(n-1, n);
	    //alert(ch);

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
	
	
//
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
	
	

/*
        recibe:   100000.10
                  100000,12

*/
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
        
/*
       recibe 10.000,12
              '.', ','  (parametro opcional)
                         si no se informa toma por defecto '.'
*/
function desformateaDivisa(valor){
	valor=String(valor);
	var separadorDecimal;

	if(arguments.length>1)
		separadorDecimal=arguments[arguments.length-1];
	else
		separadorDecimal='.';
		valor=quitaPuntos(valor);
		valor=reemplazaSeparadorDecimal(valor,separadorDecimal);
		valor=parseFloat(valor);
	return valor;
}
        
//
	
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
	
//	
function quitaPuntosObj(obj){
  var numero=obj.value;
  var strNumero=String(numero)
  var arrayNum=strNumero.split('.');
  if(arrayNum.length==1)
	return strNumero=arrayNum;
  else{
	strNumero='';
	for(var n=0;n<arrayNum.length;n++)
	  strNumero+=arrayNum[n];
  }
  obj.value=strNumero; 	
}

//
function tienePunto(numero){
      var tiene=0;
  var num=String(numero);
  for(var n=0;n<num.length;n++)
	if(num.substring(n,n+1)=='.')
          tiene=1;
      return tiene;
}
	
//
function tieneComa(numero){
      var tiene=0;
  var num=String(numero);
  for(var n=0;n<num.length;n++)
	if(num.substring(n,n+1)==',')
          tiene=1;
      return tiene;
}
	
//
function obtenerIdDesplegable(form, nombre){         
 return form.elements[nombre].options[form.elements[nombre].selectedIndex].value;        
}

function obtenerIdDivisa(form,nombre){
 if(form.elements[nombre].type=='select-one'){

   return obtenerIdDesplegable(form, nombre);
     }        
 else{
   return form.elements[nombre].value;
 }
}

///////////////////////////////fin funciones para las divisas////////////////////



//
//
//
//	Depuracion
//
//
//
	
function PresentaForms(document){
  var Msg='Mostrando los forms del documento '+document.name+'\n';
  for (j=0;j<document.forms.length;j++){
        Msg=Msg+'Form '+j+':'+document.forms[j].name+'\n';			
  }  
  alert (Msg);    
}

function PresentaCampos(formu){
  var Msg='Mostrando contenido de los campos del form '+formu.name+'\n';
  for (j=0;j<formu.elements.length;j++){
    if(formu.elements[j].type!='checkbox')
      Msg=Msg+'Campo '+j+':'+formu.elements[j].name 
      + '('+formu.elements[j].type+') = '
      +formu.elements[j].value+'\n';
    else
      if (formu.elements[j].checked)
        Msg=Msg+'Campo '+j+':'+formu.elements[j].name 
        + ' = <Checked>'+'\n';			
  }  
  alert (Msg);    
}

//
//
//
//
//
//

/*
  funcion para recarga de pagina
  recibe el documento que se quiere recargar
  
  para la llamada:
     si queremos recargar un documento cualquiera (no popUp window)
     
       Refresh(this.document);
     
     si es un popUp Window
       Refresh(window.opener.document);
     
*/


function Refresh(doc){
  var url=String(doc.location);
  doc.location=url;
}


function CerrarVentanaAndRefresh(doc){
    window.close();
    Refresh(doc);	
}

  function quitarEspaciosIzquierda(palabra){
    if(palabra.substring(0,1)==' '){
      palabra=palabra.substring(1,palabra.length);
      palabra=quitarEspaciosIzquierda(palabra);
    }
    return palabra;  
  }
  
  
    
  function quitarEspaciosDerecha(palabra){
    if(palabra.substring(palabra.length-1,palabra.length)==' '){
      palabra=palabra.substring(0,palabra.length-1);
      palabra=quitarEspaciosDerecha(palabra);
    } 
    return palabra; 
  }
        

        
  function quitarEspacios(palabra){
    palabra=quitarEspaciosIzquierda(palabra);
    palabra=quitarEspaciosDerecha(palabra);
    palabra=quitarEspaciosIntermedios(palabra);
          
    return palabra;
  }
  
  function quitarEspaciosYSaltosDeLinea(palabra){
    palabra=quitarEspaciosIzquierda(palabra);
    palabra=quitarEspaciosDerecha(palabra);
    palabra=quitarEspaciosIntermedios(palabra);
    palabra=quitarSaltosDeLinea(palabra);
    
    
    var arrayDumped=new Array();
    for(var n=0;n<palabra.length;n++){
      if(palabra.charCodeAt(n)!=0){
        arrayDumped[arrayDumped.length]=palabra.substring(n,n+1);	
      }
    }
    palabra='';
    
    for(var n=0;n<arrayDumped.length;n++){
      palabra=palabra+String.fromCharCode(arrayDumped[n]);
    }
    
    return palabra;
  }


        
  function quitarEspaciosIntermedios(palabra){   
    for(var n=0;n<palabra.length;n++){
      if(palabra.substring(n,n+2)=='  '){
        palabra=palabra.substring(0,n+1)+palabra.substring(n+2,palabra.length);
        n--;
      }
    } 
    return palabra;
  }
  
  function quitarSaltosDeLinea(palabra){   
   
    var arrayDumped=new Array();
    for(var n=0;n<palabra.length;n++){
      if(palabra.charCodeAt(n)!=13 && palabra.charCodeAt(n)!=10 && palabra.charCodeAt(n)!=0 && palabra.charCodeAt(n)!=32){
        arrayDumped[arrayDumped.length]=palabra.charCodeAt(n);	
      }
    }
    

    palabra='';
    
    for(var n=0;n<arrayDumped.length;n++){
      palabra=palabra+String.fromCharCode(arrayDumped[n]);
    }
        
    return palabra;
  }
  
  function quitarSaltosDeLinea_2(palabra){   
   
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
  
  function esNulo(valor){
        	  if(valor==''||valor=='NULL'||valor=='Null'||valor=='null')
        	    return true;
        	  else
        	    return false;
        	}
        	
  function esLetraMinuscula(caracter){
    if(caracter!=' ' && (caracter<'a' || caracter>'z'))
      return false;
    else
      return true;	
  }



  function esLetraMayuscula(caracter){
    if(caracter!=' ' && (caracter<'A' || caracter>'Z'))
      return false;
    else
      return true;	
  }



  function esLetra(caracter){
    if(esLetraMayuscula(caracter) || esLetraMinuscula(caracter))
      return true;
    else
      return false;    
  }
  
  function esNumero(caracter){
    if(caracter<'0' || caracter>'9')
      return false;
    else
      return true;  	
  }
        	
        	
 function esNif(cadena){
   
   if(!esLetra(cadena.substring(0,1)))
     return false;
   
   if(cadena.substring(1,2)!='-')
     return false;  
    
   for(var n=2;n<cadena.length;n++){
      if(!esNumero(cadena.substring(n,n+1)))
        return false;
    }
    return true;
  }
  
  function esCodPostal(cadena){
    
    var esCorrecto=true;
  
  
    for(var n=0;n<cadena.length && esCorrecto;n++)
      esCorrecto=esNumero(cadena.substring(n,n+1));
  
    return esCorrecto;	
  }
  
  function esTelefono(cadena){
   
    var esCorrecto=true;
 
  
    for(var n=0;n<cadena.length && esCorrecto;n++)
      esCorrecto=esNumero(cadena.substring(n,n+1));
    return esCorrecto;	
  }
  
  /*
  funcion para reemplazar las comillas simples por acento agudo
  en los campos de tipo text, textarea, hidden
  para ser usada antes del envio del formulario
  
  recibe el formul?ario a analizar
  
  */
  
  function reemplazarComillaSimplePorAcento(form){
    for(var n=0;n<form.length;n++){
      if(form.elements[n].type=='text' || form.elements[n].type=='textarea' || form.elements[n].type=='hidden'){
        form.elements[n].value=reemplazarCaracter(form.elements[n].value,'\'','?');
      }
    }
  }
  
  /*
    funcion que reemplaza caracteres
      recibe la cadena a parsear
      el caracter a ser reemplazado "caracterOriginal"
      el caractar que reemplaza     "nuevoCaracter"
      
      devuelve la cadena con los carcteres reemplados
  
  */
	
  function reemplazarCaracter(cadena, caracterOriginal, nuevoCaracter){
    var cadenaTemp=cadena;	  
    for(var n=0;n<cadena.length;n++){
      if(cadenaTemp.substring(n,n+1)==caracterOriginal){
        cadenaTemp=cadenaTemp.substring(0,n)+nuevoCaracter+cadenaTemp.substring(n+1,cadenaTemp.length);
      }
    }
    return cadenaTemp;
  }
  
  /*
      funcion para sumar fechas
      
      recibe las fechas en formato xx/xx/xxxx, las convierte a entero 
      y las suma 
      
      devuelve la fecha resultado en formato cadena 
  
  */

  function sumaFechas(fecha1,fecha2){
    var fFecha1=new Date(fecha1); 
    var fFecha2=new Date(fecha2); 
    var Resultado=parseInt(fFecha1.getTime()+fFecha2.getTime()); 
    var fResultado=new Date(Resultado); 
    
    return fResultado;
  }

   /*
     suma dias a una fecha
     recibe la fecha en formato xx/xx/xxxx y los dias
     
     devuelve la fecha en formato
   
   */

  function sumaDiasAFecha(fechainicio,incremento){ 
    return sumaFechas(fechainicio,incremento*24*60*60*1000);
  }
    /*
      funcion que suma dias habiles a una fecha 
      recibe la fecha en formato xx/xx/xxxx y los dias habiles  
    
    */
    
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
 
 /*
   funcion que a?ade de ceros decimales hasta completar las posicionesDecimales
   
   ej:
   
      posicionesDecimales = 2
   
      12,1  ==> 12,01
      12    ==> 12,00
      
 */
 
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
        
        
function esEntero(valor){

  valor+='';
  for(var n=0;n<valor.length;n++){
    if(valor.substring(n,n+1)<'0' || valor.substring(n,n+1)>'9')
      return false;	
  }
  return true;
}

function esEnteroConSigno(valor){

  valor+='';
  for(var n=0;n<valor.length;n++){
    if((valor.substring(n,n+1)<'0' || valor.substring(n,n+1)>'9') &&  valor.substring(n,n+1)!='-')
      return false;	
  }
  return true;
}


/*
	funcion que devuelve el frame buscado
	recibe el nombre del frame y el frame 'TOP'
	hace una busqueda recursiva por todos los frames desde el frame padre

	util para llamar a frames cuya estructura (jerarquia) es dinamica

	ej:

    obtenerFrame(top,'nombre_del_frame')

*/
/*
function obtenerFrame(framePadre,frameBuscado){
    //solodebug	
	
	alert('Function obtenerFrame!!'+window.frames['framePadre']+ window.frames['frameBuscado']);
	alert('framePadre:'+framePadre+'frameBuscado'+frameBuscado);
	
	
	var objeto=new Object();

	if(framePadre.name==frameBuscado){
		
    	//solodebug	
		alert('framepadre '+framePadre.name);
		
		
		return framePadre;

	}
	else{
    	//solodebug	
		alert('else '+ framePadre.name +' '+framePadre);

		if(framePadre.length>0){
			for(var n=0;n<framePadre.length;n++){
    			objeto=obtenerFrame(framePadre.frames[n],frameBuscado);
    			if(objeto!=null){

    		  		return objeto;

    			}
			}
		}
	}
	if(objeto==undefined){
	return null;
	}
}
*/

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

           
/*
  recorre todos los links del documeno y deshabilita la URL
  es necesario que el link tenga un id unico

*/
function DeshabilitarBotones(doc){
  for(var n=0;n<doc.links.length;n++){
    if(doc.links[n].id.substring(0,4)=='BTN_'){
      doc.links[n].onclick=doNothing;
      doc.links[n].style.color='#CCCCCC';
      doc.links[n].style.cursor='default';
    }
  }
}


/*
  funcion que no hace nada

*/

function doNothing(){
  return false;
}


/*
  devuelve el dia mes anyo de una fecha 
  util para convertir a formato ingles 

*/

function formatoFecha(fecha, formatoEntrada,formatoSalida){


  var nuevaFecha;


  if(formatoEntrada==formatoSalida){
    nuevaFecha=fecha;  
  }
  else{
      nuevaFecha=obtenerSubCadena(fecha, 2)+'/'+obtenerSubCadena(fecha, 1)+'/'+obtenerSubCadena(fecha, 3);
  }
  return nuevaFecha;  
}



function obtenerSubCadena(fecha, posicion){

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

function diferenciaDias(fFechaOrigen,fFechaDestino,tipo){

	var diferenciaDias=0;
	var fFechaOrigenTmp;
	var fFechaDestinoTmp;
	var signo='';


	// si son iguales no hacemos nada
      
      
      if(fFechaOrigen==fFechaDestino){
diferenciaDias=0;
}
else{


if(fFechaOrigen<fFechaDestino){
  fFechaOrigenTmp=new Date((Number(fFechaOrigen.getMonth())+1)+'/'+fFechaOrigen.getDate()+'/'+fFechaOrigen.getFullYear());
  fFechaDestinoTmp=new Date((Number(fFechaDestino.getMonth())+1)+'/'+fFechaDestino.getDate()+'/'+fFechaDestino.getFullYear());
}
else{
  fFechaOrigenTmp=new Date((Number(fFechaDestino.getMonth())+1)+'/'+fFechaDestino.getDate()+'/'+fFechaDestino.getFullYear());
  fFechaDestinoTmp=new Date((Number(fFechaOrigen.getMonth())+1)+'/'+fFechaOrigen.getDate()+'/'+fFechaOrigen.getFullYear());
  signo='-';
}

     //  para los naturales
if(tipo=='NATURALES'){
  while(fFechaOrigenTmp<fFechaDestinoTmp){
    fFechaOrigenTmp=sumaDiasAFecha(fFechaOrigenTmp,1);
    diferenciaDias+=1;
  }
}
else{
  if(tipo=='HABILES'){
    while(fFechaOrigenTmp<fFechaDestinoTmp){
      fFechaOrigenTmp=sumaDiasAFecha(fFechaOrigenTmp,1);
      if(fFechaOrigenTmp.getDay()!=0 && fFechaOrigenTmp.getDay()!=6){
        diferenciaDias+=1;
      }
    }
  }
}
}
diferenciaDias=parseInt(signo+diferenciaDias);
return diferenciaDias;
}

function compararFechas(fechaOrigen, tipo,fechaDestino ){
  var fechaOrigenFormatoIngles=formatoFecha(fechaOrigen,'E','I');
  var fechaDetinoFormatoIngles=formatoFecha(fechaDestino,'E','I');

  fechaOrigenFormatoIngles=new Date(fechaOrigenFormatoIngles);
  fechaDetinoFormatoIngles=new Date(fechaDetinoFormatoIngles);

  fechaOrigenFormatoIngles=parseInt(fechaOrigenFormatoIngles.getTime());
  fechaDetinoFormatoIngles=parseInt(fechaDetinoFormatoIngles.getTime());

  if(tipo=='MAYOR'){
    if(fechaOrigenFormatoIngles>fechaDetinoFormatoIngles)
      return 1;
    else
      return 0;
  }
  else{
    if(tipo=='MENOR'){
      if(fechaOrigenFormatoIngles<fechaDetinoFormatoIngles)
        return 1;
      else 
        return 0;
    }
    else{
      if(tipo=='MENORIGUAL'){
        if(fechaOrigenFormatoIngles<=fechaDetinoFormatoIngles)
          return 1;
        else 
          return 0;
      }
      else{
        if(tipo=='MAYORIGUAL'){
          if(fechaOrigenFormatoIngles>=fechaDetinoFormatoIngles)
            return 1;
          else 
            return 0;
        }
        else{
          if(tipo=='IGUAL'){
            if(fechaOrigenFormatoIngles==fechaDetinoFormatoIngles)
              return 1;
            else 
              return 0;
          }
        }
      }
    }
  }
}

/*
   funcion que devuelve una fecha con el formato DD/MM/YYYY

   entrada:   D/M/YYYY , DD/M/YYYY ? D/MM/YYYY
   salida:    DD/MM/YYYY
*/

function normalizarFecha(fecha){


  var dia=obtenerSubCadena(fecha, 1);
  var mes=obtenerSubCadena(fecha, 2);
  var annyo=obtenerSubCadena(fecha, 3);

  if(Number(dia)<10){
    dia='0'+String(Number(dia));
  }

  if(Number(mes)<10){
    mes='0'+String(Number(mes));
  }

  var fechaTmp=dia+'/'+mes+'/'+annyo;
  return fechaTmp;

}

function convertirFechaATexto(fFecha){
  var fecha=fFecha.getDate()+'/'+(Number(fFecha.getMonth())+1)+'/'+fFecha.getFullYear();
	return fecha;
}
 
 
/* funciones que permiten que un texto parpadee * /
 
/ * crear el parpadeo* /
function doBlink() {
	var blink = document.all.tags("BLINK")


	for (var i=0; i < blink.length; i++)
		blink[i].style.visibility = blink[i].style.visibility == "" ? "hidden" : "" 
}


/ *  empezar el proceso de parpadeo* /
function startBlink() {
	if (document.all)
  		setInterval("doBlink()",500)
}
*/


function esLaborable(fecha){

	fFecha=new Date(formatoFecha(fecha,'E','I'));

	if(fFecha.getDay()==0 || fFecha.getDay()==6){
	  return 0; 
	}
	else{
	  return 1;
	}
}
  
  
  
function calculaSiguienteDiaLaborable(fFecha){

fFechaTmp=fFecha;

if(fFechaTmp.getDay()==0 || fFechaTmp.getDay()==6){
  if(fFechaTmp.getDay()==0){
    fFechaTmp=sumaDiasAFecha(fFechaTmp,1);
  }
  else{
    if(fFechaTmp.getDay()==6){
      fFechaTmp=sumaDiasAFecha(fFechaTmp,2);
    }
  }
}

return fFechaTmp;
}  

function esFechaIndeterminada(textoFecha){
	if(textoFecha.replace(' ','')==''){
	  return 1; 
	}
	else{
	  return 0;
	}  
}

function dump(cadena){
	var cadRetorno='';

	for(var n=0;n<cadena.length;n++){
	  if(cadRetorno==''){
    	cadRetorno=cadena.charCodeAt(n);
	  }
	  else{
    	cadRetorno+=','+cadena.charCodeAt(n)
	  }
	}
	return cadRetorno;
}

function eliminarCaracterAscii(cadena, carAscii){
	var cadenaTmp;

	cadenaTmp=dump(cadena);
	var arrAscii=cadenaTmp.split(',');
	cadenaTmp='';
	for(var n=0;n<arrAscii.length;n++){
	  if(arrAscii[n]!=carAscii){
    	cadenaTmp+=String.fromCharCode(arrAscii[n]);
	  }
	}
	return cadenaTmp;
}

function isObject(o) {
  	return (typeof(o)=="object");
}
//fin de copia general.js

  //Ver las fotos en el listado con div absoluto 20/02/2011
function verFoto(id){
	var foto1 = "verFotoPro_";
	var foto2 = id;
	var divFoto = foto1.concat(foto2);
	if (document.getElementById(divFoto).style.display == 'none'){
		document.getElementById(divFoto).style.display = 'block';
		document.getElementById(divFoto).style.position = 'absolute';
	}
	else if(document.getElementById(divFoto).style.display == 'block'){
		document.getElementById(divFoto).style.display = 'none';
	}
}
	

		
//	En el EIS y buscadores no permitimos cadenas de menos de long		
function ComprobarCadenasLargas(Cadena, Long)
{
	var Res='S', Bloque;
	
	for (i=0;((i<=PieceCount(Cadena, ' '))&&(Res=='S'));++i)
	{
		Bloque=Piece(Cadena, ' ',i);
		if (Bloque.length<Long) Res='N';
	}
	return Res;
}
/*
function CheckFormEmail(){
	var sEmail	= jQuery('#email').val();
	jQuery('#emailError').html('').hide();

	// Si no hay datos o no cumple formato email
	if(sEmail == ''){
		jQuery('#emailError').html(noEmail).show();
	}else{
		sendPwd(sEmail);
	}
}
*/

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



//
//	22feb18	Funciones para convertir del formato JS al formato ISO. Necesarias para exportación a Excel
//
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
/*
function CharToISO(Char)
{
    var Res;

    if (Char=='á') Res=String.fromCharCode(225);      		//'a';
    else if (Char=='é') Res=String.fromCharCode(233);       //'e';
    else if (Char=='í') Res=String.fromCharCode(237);       //'i';
    else if (Char=='ó') Res=String.fromCharCode(243);       //'o';
    else if (Char=='ú') Res=String.fromCharCode(250);       //'u';
    else if (Char=='Á') Res=String.fromCharCode(193);       //'A';
    else if (Char=='É') Res=String.fromCharCode(201);       //'E';
    else if (Char=='Í') Res=String.fromCharCode(205);       //'I';
    else if (Char=='Ó') Res=String.fromCharCode(211);       //'O';
    else if (Char=='Ú') Res=String.fromCharCode(218);       //'U';
    else if (Char=='ã') Res=String.fromCharCode(227);      	//'a';
    else if (Char=='Ã') Res=String.fromCharCode(195);       //'A';
    else if (Char=='õ') Res=String.fromCharCode(245);       //'o';
    else if (Char=='Ö') Res=String.fromCharCode(213);       //'O';
    else if (Char=='ñ') Res=String.fromCharCode(241);		//'n';
    else if (Char=='Ñ') Res=String.fromCharCode(209);       //'N';
    else if (Char=='ç') Res=String.fromCharCode(347);       //'N';
    else if (Char=='Ç') Res=String.fromCharCode(199);       //'N';
    else Res=Char;

	console.log('CharToISO:'+Char+'->'+Res);
    return(Res);
}
*/




//	29may18	Convertimos cadenas a formato HTML para ser luego convertidas a ISO en la base de datos
function ScapeHTMLChar(ch)
{
    var ret=ch;

	if (ch == '&' )
		ret = '&amp;';
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







