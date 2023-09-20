//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 //
 //	FUNCIONES DE SUBMIT
 //
 //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

     //
     // Función para submit de formulario.
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
     	
      for (j=0;j<formu.elements.length;j++){
      	// No preguntamos al usuario...
      	if ((formu.elements[j].type=="text" || formu.elements[j].type=="textarea") && formu.elements[j].value!=""){
          formu.elements[j].value=checkForQuotesSin(formu.elements[j].value);
        }
        if (formu.elements[j].type=="hidden" && formu.elements[j].value!=""){	
          formu.elements[j].value=checkForQuotesSin(formu.elements[j].value);               
        }
      }      
      if (hayComillasSimples=="false" && test(formu)){
      	formu.submit();
      }
    }
    

  //
  // Como checkForQuotesSin(checkString), pero con confirmación.
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
            if (confirm("El valor "+checkString+" que ha introducido\ncontiene comillas simples,\nla base de datos requiere que sean dobles.\n¿Le parece bien que las cambiemos por "+newString+" ?")) {
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
	  Se muestra un mensaje de confirmación
	  
	  Autor: Montse Pans
	  Fecha: 30/Agosto/2000
	  Parametros:
	     formu: Objeto Form que se desea enviar
	*/
        function ConfirmarBorrado(formu){        
	  var contestacion = confirm("¿Esta seguro de borrar el registro?");
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
	  //formu.action='mailto:comercial@medicalvm.com';
	  //alert(formu.name+' '+accion);
	  AsignarAccion(formu,accion);
	  SubmitForm(formu);
	}


	  function Navega(formu,pagina){
            formu.elements['ULTIMAPAGINA'].value=pagina;
	    SubmitForm(formu);	    
	  }

	