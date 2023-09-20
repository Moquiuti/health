// JavaScript Document
//js de MOF_28_RW


	
	//var msgModificarTodosPedidos='Los cambios afectan a TODOS los pedidos del programa.\nSi quiere hacerlo únicamente para el siguiente pedido o para todos excepto el siguiente pedido pulse en "cancelar" y marque la casilla adecuada.\n\n¿Quiere continuar con la modificación para TODOS los pedidos?';
    
	//var msgModificarTodosPedidosExceptoSiguiente='Los cambios afectan a TODOS los pedidos del programa EXCEPTO el siguiente pedido.\nSi quiere hacerlo para todos pedidos o únicamente para el siguiente pedido pulse en "cancelar" y marque la casilla adecuada.\n\n¿Quiere continuar con la modificación para TODOS los pedidos del programa EXCEPTO el siguiente pedido?';
    
	//var msgModificarSoloSuiguientePedido='Los cambios afectan SOLO al siguiente pedido del programa.\nSi quiere hacerlo para todos pedidos o para todos excepto el siguiente pedido pulse en "cancelar" y marque la casilla adecuada.\n\n¿Quiere continuar con la modificación para el siguiente pedido únicamente?';
	
	   function obtenerIdDivisa(form,nombre){
	     if(form.elements[nombre].type=='select-one'){
	       return obtenerIdDesplegable(form, nombre);
             }        
	     else{
	       return form.elements[nombre].value;
	     }
	   }
                    
        var porDefinir;
        
        function initPorDefinir(){
          if(estaPorDefinir()==true) porDefinir=1; else porDefinir=0;  
        }
        
        function estaPorDefinir(){
          for(var k=0;k<document.form1.elements.length;k++){
	    if (document.form1.elements[k].name.substr(0,7)=='IMPORTE' && document.form1.elements[k].name!='IMPORTE_FINAL_PEDIDO'){
	      if (document.form1.elements[k].value==""){
	        porDefinir=1;
	        return true;
	      }
	    }
	  }
	  return false;      
        } 
        
        /**
	    Cuando se produce algun cambio en el iva de un producto:
	     - Actualizamos el campo oculto del IVA para el producto.
	     - Recalculamos el total.        
	     
	    Parametros:
	      linea : Código del producto 
	      nuevoValor: Nuevo importe IVA.
        **/
        function actualizaIVA(linea,nuevoValor){
	  document.forms['form1'].elements['IVA'+linea].value=nuevoValor;         
          //if (document.form1.elements['seleccion'][0].checked==true){
           // calculoConDescuento();
          //}else{
          //  calculoConImporte();           
          //}
        }
	
	
	function calculoConDescuento(){  
	  porDefinir=0;	   
	  descuento=AntiformateaVis(document.form1.elements['MO_DESCUENTOGENERAL'].value,document.form1.elements['MO_DESCUENTOGENERAL']);
	  if (isNaN(descuento) || descuento<0 || descuento>100 || ! esEntero(descuento)){
	    alert(document.forms['MensajeJS'].elements['INTRODUZCA_DESCUENTO_CORRECTO'].value);
	  }else{	
	    var subtotal=0;
	    var importeiva=0;
	    var iva=0;
	   
	    for(k=0;k<document.form1.elements.length;k++){

	     if(document.form1.elements[k].name.substr(0,13)=='NuevoImporte_' && document.form1.elements[k].value=='Por definir'){
	       porDefinir=1;
	     }
	     else{ 
	      if (document.form1.elements[k].name.substr(0,7)=='IMPORTE' && document.form1.elements[k].name!='IMPORTE_FINAL_PEDIDO'){
	         if (document.form1.elements[k].value!='Por definir'){
	           //alert('k: '+k+' '+document.form1.elements[k].name+' '+document.form1.elements[k].type+' '+document.form1.elements[k].value);
	           importe=parseFloat(reemplazaComaPorPunto(document.form1.elements[k].value));	
	           //alert(importe);        
	         }else{ 
	           importe=0;
	           porDefinir=1;
	         }
	        //alert('importe: '+importe);  
	        
	        identificador=document.form1.elements[k].name.substr(7,document.form1.elements[k].name.length);	   
	          //alert('identificador: '+identificador);     
	        var cadenaId='IVA'+identificador;
	          //alert('cadenaId '+cadenaId);
	          //alert('IVA36800: '+document.form1.elements[8].name);
	        iva=document.form1.elements['IVA'+identificador].value; 
	          //alert('iva: '+iva); 
	            
	        importeiva+=importe*(iva/100);
	          //alert('importeiva: '+importeiva);
                subtotal+=importe;
                  //alert('subtotal: '+subtotal);	      
	      }
	     }
	    }
	    
	    
	    subtotal*=(1-descuento/100);
	    //transporte=desformateaDivisa(document.form1.elements['MO_COSTELOGISTICA'].value);
	    
	    importeiva=importeiva*(1-descuento/100)+transporte*16/100;
	    //document.form1.elements['MO_IMPORTEIVA'].value=FormateaVis(Decimales_con_punto(importeiva, 0, 0));
	    //document.form1.elements['IMPORTE_FINAL_PEDIDO'].value=FormateaVis(Decimales_con_punto(subtotal+transporte+importeiva, 0, 0));
	    importeiva=Round(importeiva,Divisas[obtenerIdDivisa(document.form1,'IDDIVISA')][3]);
	    
	    if(!porDefinir){
	      if(importeiva==0){
	        document.form1.elements['MO_IMPORTEIVA'].value='Sin Productos';
	      }
	      else{
	        document.form1.elements['MO_IMPORTEIVA'].value=anyadirCerosDecimales(FormateaNumeroNacho(Round(importeiva,2)),2);
	      }
	      var finalTotal=Round(subtotal+transporte+importeiva,Divisas[obtenerIdDivisa(document.form1,'IDDIVISA')][3]);
	      //alert(finalTotal);
	      if(finalTotal==0){
	        document.form1.elements['IMPORTE_FINAL_PEDIDO'].value='Sin Productos';
	      }
	      else{
	        document.form1.elements['IMPORTE_FINAL_PEDIDO'].value=anyadirCerosDecimales(FormateaNumeroNacho(Round(finalTotal,2)),2);
	      }
	    }
	    else{
	      document.form1.elements['MO_IMPORTEIVA'].value='Por definir';
	      document.form1.elements['IMPORTE_FINAL_PEDIDO'].value='Por definir';
	    }
	  }
	}
	

	function ValidaDescuento(){
	  formu=document.forms['form1'];
	  descuento = parseFloat(AntiformateaVis(formu.elements['MO_DESCUENTOGENERAL'].value));
	  if (checkNumber(formu.elements['MO_DESCUENTOGENERAL'].value,formu.elements['MO_DESCUENTOGENERAL'])){
	    if (descuento>=0 && descuento<=100){
	      return true;
	    }else{
	       alert(document.forms['MensajeJS'].elements['DESCUENTO_MENOR_0'].value);	    
	      return false;
	    }
	  }else{
	    return false;
	  }
	}
	function Valida(formu){
	 if (formu.elements['LPP_IMPORTE'].value <= 0) {
	   alert(document.forms['MensajeJS'].elements['INTRODUZCA_IMPORTE_VALIDO'].value);
	 } else {
	   if (checkNumber(formu.elements['LPP_IMPORTE'].value,formu.elements['LPP_IMPORTE'])){ 
	     formu.elements['LPP_IMPORTE'].value=quitaPuntos(formu.elements['LPP_IMPORTE'].value);
	     formu.elements['LPP_IMPORTE'].value=AntiformateaVis(formu.elements['LPP_IMPORTE'].value);
	     if (test(formu)) {
	       //DeshabilitarBotones(document);
	       SubmitForm(formu,document);
	     }
	   }
         }
        }
	function HayComent(formu){
	 
          
	  if(formu.elements['NMU_COMENTARIOS'].value==''){
	    return false;
	  }else {
	    return true;
	  }
	}

	function Anadir(formu,accion){	
	  AsignarAccion(formu,accion);
	  Valida(formu);
	}
	
	
	
	function ValidarStringCantidades (formu) {
	  var seEnviaAlguno=0;
	  var cadena="";
	  var cant;
	  for(i=0;i<formu.length;i++){
	    if(formu.elements[i].name.substring(0,14)=="NuevaCantidad_"){
		    // Validamos el numero con esEntero.
		    if (!esEntero(formu.elements[i].value)){ 
		      alert(document.forms['MensajeJS'].elements['INTRODUZCA_CANTIDAD_VALIDA'].value);
		      formu.elements[i].focus();
		      return false; 
		    }
		    else{
		      if(formu.elements[i].value!='' && formu.elements[i].value!=0)
		      seEnviaAlguno=1;
		    }
	    }
	  }
	  if(!seEnviaAlguno){
	    alert(document.forms['MensajeJS'].elements['NO_PROD_PARA_ENVIAR'].value);
	    return false;
	  }
	  else{
	    
	    //var vSubtotal=formu.elements['MO_SUBTOTAL'].value;
	  
	    //if(validarPedidoMinimo(vSubtotal,formu.elements['PEDIDO_MINIMO_IMPORTE_SINFORMATO'].value,formu.elements['PEDIDO_MINIMO_IMPORTE'].value,formu.elements['PEDIDO_MINIMO_ACTIVO'].value)){
	    //  return true;
	    //}
	  
	    if(validarPedidoMinimo(formu.elements['MO_SUBTOTAL'].value,formu.elements['PEDIDO_MINIMO_IMPORTE_SINFORMATO'].value,formu.elements['PEDIDO_MINIMO_IMPORTE'].value,formu.elements['PEDIDO_MINIMO_ACTIVO'].value)){
	      return true;
	    }
	    else{
	      null;
	    } 
	  }
	  
	  
	  
	}
	
	function validarPedidoMinimo(subtotal, minimo,minimoFormato, activo){
	  

	  
	  
	  
	  if(isNaN(minimo)){
	    minimo=0;
	  }
	  
	  if(activo=='N'){
	    return true;
	  }
	  else{
	    if(activo=='S'){
	      if(parseInt(Antiformatea(subtotal))<parseInt(minimo)){
	        alert(document.forms['MensajeJS'].elements['IMPORTE_INFERIOR_MINIMO'].value + minimoFormato + document.forms['MensajeJS'].elements['IMPORTE_INFERIOR_MINIMO_DESPUES'].value +'\n'+document.forms['MensajeJS'].elements['IMPORTE_INFERIOR_MINIMO_DESPUES1'].value); 
	        return false;
	      }
	      else{
	       return true;
	      }
	    }
	    else{
	      if(activo=='E' || activo=='I'){
	        if(parseInt(Antiformatea(subtotal))<parseInt(minimo)){
	          alert(document.forms['MensajeJS'].elements['IMPORTE_INFERIOR_MINIMO'].value + minimoFormato+ document.forms['MensajeJS'].elements['IMPORTE_INFERIOR_MINIMO_DESPUES'].value +'\n'+ document.forms['MensajeJS'].elements['IMPORTE_INFERIOR_MINIMO_DESPUES1'].value);
	          return false;
	        }
	        else{
	          return true;
	        }
	      }
	    }
	  }
	}
	
	//
	//  Construimos el string de cantidades/precios de las lineas de multioferta.
	//  (LMO_ID|CANTIDAD)(100|300.4)
	//
	function ConstruirString(formu,aBuscar) {
	     var cadena="";
	     var cant;
	     var lg = aBuscar.length;
	     for (i=0;i<formu.length;i++)
	        {
	        if (formu.elements[i].name.substring(0,lg)==aBuscar)
	            {
	            
	            // #sustituye#
	            cant=Antiformatea(formu.elements[i].value);
	            if(cant=='')
	              cant=0;
	            // cant=formu.elements[i].value;
	            cadena+="(" + formu.elements[i].name.substring(lg,formu.elements[i].name.length) + "|" + cant + ")";	            
	            }
	        }
	        return cadena;
	}

	// +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
	// Olivier Jean: 15 de junio 2001
	// Esta funcion envia el formu
	// Para el estado 10, hay que comprobar la fecha de entrega y copiar los datos que queremos enviar en "anadir"
	//
	//  Usamos el formulario del FrameSet para hacer actualizaciones parciales. Cuando dan OK al formulario
	//    hacemos el submit del formulario, enviando los cambios en el form actual.
	//
	
	
	
	function Actua(formu,accion){
	

	  if(!accion.match("PENDIENTE") && !accion.match("RECHAZAR")) {
      //if(!ValidarFormaPago(document.form1.IDFORMAPAGO)){
	   //   return;}
      
    }

	  //comentariosToForm1(document.forms['form1'], document.forms['form1'],'NMU_COMENTARIOS');

  
	  if(accion.match("OK")){
	    if (ValidarStringCantidades(formu)){
	      formu.elements['STRING_CANTIDADES'].value = ConstruirString(formu,'NuevaCantidad_');
	        
	      
	        
	      formu.elements['STRING_PRECIOS'].value = ConstruirString(formu,'NuevoPrecio_');
	      //comentariosToForm1(document.forms['form1'], document.forms['form1'],'NMU_COMENTARIOS');
	      
	          
	      formu.elements['MO_DESCUENTOGENERAL'].value=desformateaDivisa(formu.elements['MO_DESCUENTOGENERAL'].value);
	      formu.elements['MO_IMPORTEIVA'].value=desformateaDivisa(formu.elements['MO_IMPORTEIVA'].value);
	      formu.elements['IMPORTE_FINAL_PEDIDO'].value=desformateaDivisa(formu.elements['IMPORTE_FINAL_PEDIDO'].value);
	      
	      AsignarAccion(formu,accion);
	      
	      
			  
	/* ]]></xsl:text> 
	      <xsl:choose>
	      	<xsl:when test="/Multioferta/ESMODELO='S'">
	 <xsl:text disable-output-escaping="yes"><![CDATA[
	 */
	 
	 	if (formu.elements['ESMODELO'].value == 'S'){
	      
	      document.forms['form1'].elements['SOLO_SIGUIENTE'].value='';
	      if(document.forms['form1'].elements['CHK_TODOSPEDIDOS_TODOS'].checked==true){
			  
	      	if(confirm(document.forms['MensajeJS'].elements['MSG_MODIFICAR_TODOS_PEDIDOS'].value+'\n'+document.forms['MensajeJS'].elements['MSG_MODIFICAR_TODOS_PEDIDOS1'].value+'\n\n'+document.forms['MensajeJS'].elements['MSG_MODIFICAR_TODOS_PEDIDOS2'].value)){
				
	      		SubmitForm(document.forms['form1'],document);
	      	}
	      }
	      else if(document.forms['form1'].elements['CHK_TODOSPEDIDOS_EXCEPTO'].checked==true){
			  
	      	if(confirm(document.forms['MensajeJS'].elements['MSG_MODIFICAR_TODOS_PEDIDOS_EXCEPTO_SIG'].value+'\n'+document.forms['MensajeJS'].elements['MSG_MODIFICAR_TODOS_PEDIDOS_EXCEPTO_SIG1'].value+'\n\n'+document.forms['MensajeJS'].elements['MSG_MODIFICAR_TODOS_PEDIDOS_EXCEPTO_SIG2'].value)){
				
	      		document.forms['form1'].elements['SOLO_SIGUIENTE'].value='X';
	      		SubmitForm(document.forms['form1'],document);
	      	}
	      }
	      else if(document.forms['form1'].elements['CHK_TODOSPEDIDOS_SIGUIENTE'].checked==true){
	      	if(confirm(document.forms['MensajeJS'].elements['MSG_MODIFICAR_SOLO_SIG_PEDIDO'].value+'\n'+document.forms['MensajeJS'].elements['MSG_MODIFICAR_SOLO_SIG_PEDIDO1'].value+'\n\n'+document.forms['MensajeJS'].elements['MSG_MODIFICAR_SOLO_SIG_PEDIDO2'].value)){
	      		document.forms['form1'].elements['SOLO_SIGUIENTE'].value='S';
	      		SubmitForm(document.forms['form1'],document);
	      	}
	      }
	      else{
	      	alert(document.forms['MensajeJS'].elements['SELECCIONE_CASILLAS'].value +'\n'+ document.forms['MensajeJS'].elements['MODIFICAR_TODOS_PEDIDOS'].value  +'\n'+ document.forms['MensajeJS'].elements['MODIFICAR_TODOS_MENO_SIGUIENTE'].value  +'\n'+ document.forms['MensajeJS'].elements['MODIFICAR_SOLO_SIGUIENTE_PEDIDO'].value)
	      }
	 
		}//fin if si es modelo
	 	else{
			SubmitForm(document.forms['form1'],document);
		}
	 /*]]></xsl:text> 
	      </xsl:when>
	      <xsl:otherwise>
	 <xsl:text disable-output-escaping="yes"><![CDATA[

	      
	      
	  ]]></xsl:text> 
	      </xsl:otherwise>
	     </xsl:choose>
	 <xsl:text disable-output-escaping="yes"><![CDATA[*/
	 
	      
	    }
	  }
	  else{
	    
	    AsignarAccion(formu,accion);
	    SubmitForm(document.forms['form1'],document);
	  }  
  } 
        
        
        
        /*
        Copiada de general se ha añadido la posibilidad de que acepte numeros negativos,
        esto es necesario para las ofertas / pedidos tipo "ABONO"
        
        
        */
        
        
       function checkNumberConSigno(checkString,objeto){
	    
	    checkString=String(checkString);
	    newString = "";
	    coma=0;
	    punto=0;	    
	    
	    for (var i = 0; i < checkString.length; i++){
	      ch = checkString.substring(i, i+1);
	      if (ch >= "0" && ch <= "9" || ch=='-'){
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
	              alert(document.forms['MensajeJS'].elements['ERROR_EN_DATO'].value +checkString+', '+document.forms['MensajeJS'].elements['CANTIDAD_CORRECTA'].value);
	              objeto.focus();	              
	              return false;
	            }
	          }
	          else{
	            alert(document.forms['MensajeJS'].elements['ERROR_EN_DATO'].value +checkString+', '+document.forms['MensajeJS'].elements['INTRODUCIDO_VALOR_INCORRECTO'].value);
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

        
        
        ///////// Nuevas funciones. autor Olivier JEAN 06/2001 //////////////
        ///////////////////////////////////////////////////////////////////
        
        //Copiar la zona de texto NMU_COMENTARIOS del form comentarios en el campo hidden NMU_COMENTARIOS del form1
        function comentariosToForm1(formOrigen, formDestino,elemento) {
           
           /*
           for(var n=0;n<document.forms.length;n++){
             //alert('form: '+document.forms[n].name+' '+'longitud: '+' '+document.forms[n].length);
             for(var i=0;i<document.forms[n].length;i++){
               //alert(document.forms[n].elements[i].name+' '+document.forms[n].elements[i].value);
             }
           }
           
           //alert('nombre: '+elemento);
           //alert('origen: '+formOrigen.name+' '+formOrigen.elements[elemento].value);
           //alert('destino: '+formDestino.name+' '+formDestino.elements[elemento].value);
          */
           formDestino.elements[elemento].value=formOrigen.elements[elemento].value;
        }    
        
         function Cantidad2Importe(formu,lmo_id,lmo_idproducto){

           var cant,precio,resultado;
     
	        /*
	           nacho
	           28/11/2001
	           validacion de que los campos cant y precio no sean null
	           si no se produce un error de NaN 
	           
	        */
	       
	       if(tieneComa(formu.elements['NuevaCantidad_'+lmo_id].value))
	         cant='';
	       else
	         if(tienePunto(formu.elements['NuevaCantidad_'+lmo_id].value))
	           cant='';
	         else
	           if(!esEntero(formu.elements['NuevaCantidad_'+lmo_id].value))
	             cant='';
	           else
	             cant=formu.elements['NuevaCantidad_'+lmo_id].value;
	    
	     
	     if(isNaN(cant)){
	       return;
	     }
	     
       var cant = desformateaDivisa(formu.elements['NuevaCantidad_'+lmo_id].value);
             
	     var precio = desformateaDivisa(formu.elements['NuevoPrecio_'+lmo_id].value);    


                
                 
                
	         
	         if(cant){
	           parseFloat(cant)
	         }
	         else{
	           cant='';
	         }
	           
	         if(precio){
	           parseFloat(precio)
	         }
	         else{
	           precio='';
	         }
	           
	         if(cant!='' && precio!='')
	           var resultado = parseFloat(cant)*parseFloat(precio);
	         else
	           resultado='';

                 if(resultado==0)
                   resultado='';
                   
                 if(precio==0){
                   precio=0;
                   formu.elements['NuevoPrecio_'+lmo_id].value=0;
                 }
	         

	         if(resultado==0 || resultado==''){
	           formu.elements['NuevoImporte_'+lmo_id].value='No Solicitado';
	           formu.elements['IMPORTE'+lmo_idproducto].value=resultado;
	         }
	         else{
	           formu.elements['NuevoImporte_'+lmo_id].value=anyadirCerosDecimales(formateaDivisa(Round(resultado,Divisas[obtenerIdDivisa(formu,'IDDIVISA')][3])),4);
	           formu.elements['IMPORTE'+lmo_idproducto].value=resultado;
	         }
	         
	         CalculaSubtotal(formu);
	         
	         //calculoConDescuento();
	         //formu.elements['MO_DESCUENTOGENERAL'].value=Antiformatea(formu.elements['MO_DESCUENTOGENERAL'].value);
	         
         }
         
         function CalculaSubtotal(formu){
           
           var sum=parseFloat(0);
           var cantidadSinFormato;
           var estaPorDefinir=0;
           
           for(i=0;i<formu.length;i++){
             if (formu.elements[i].name.substring(0,13)=='NuevoImporte_'){
               if(formu.elements[i].value!='Por definir'){ 
                 if(formu.elements[i].value=='No Solicitado'){
                   cantidadSinFormato=0;
                   sum=sum+parseFloat(cantidadSinFormato);
                 }
                 else{
                   cantidadSinFormato=desformateaDivisa(formu.elements[i].value);
                   sum=sum+parseFloat(cantidadSinFormato);
                 }
               }
               else{
                 estaPorDefinir=1;
               }
             }
           }

           if(!estaPorDefinir)
             if(sum==0){
               formu.elements['MO_SUBTOTAL'].value='Sin Productos';
             }
             else{
               formu.elements['MO_SUBTOTAL'].value=anyadirCerosDecimales(formateaDivisa(Round(sum,2)),2);
             }
           else
             formu.elements['MO_SUBTOTAL'].value='Por definir';
         }
         
          function tienePuntuacion(valor){
            if(tienePunto(valor))
              return true;
            else
              if(tieneComa(valor))
                return true;
              else
                return false;
          }
          
          
          //
          // Comprueba que el numero de unidades introducidas coincide con un multiplo del
	  // numero de lotes
	  // Se pide confirmacion para redondearlo a la alza si no es asi.
	  //
	  
	  
	  
	  
	  function UnidadesALotes(unidades,unidadesporlote,objeto){
	    var identificador=objeto.name.substr(14,objeto.name.length);
      
      if (objeto.value == "" || objeto.value == 0){
	      document.images['CHKSOLICITAR_'+identificador].src='http://www.newco.dev.br/images/nosolicitar.gif';
	      document.images['CHKSOLICITAR_'+identificador].value='unchecked';
	      return true;
      }	                   
      else{
	      if(!esEntero(objeto.value)|| objeto.value<0){  //tienePuntuacion(objeto.value)
	        document.images['CHKSOLICITAR_'+identificador].src='http://www.newco.dev.br/images/nosolicitar.gif';
	        document.images['CHKSOLICITAR_'+identificador].value='unchecked';
	        alert(document.forms['MensajeJS'].elements['CANTIDAD_CORRECTA'].value);
	        objeto.focus();
	        return false;
	      }
	      else{	    	  	
	        var lotes;	        
	        if (unidades%unidadesporlote==0){
	          lotes=unidades/unidadesporlote;
	          var nuevasUnidades=unidadesporlote*lotes;	    
	             
	          document.forms['form1'].elements['NuevaCantidad_'+identificador].value=nuevasUnidades;
	          document.images['CHKSOLICITAR_'+identificador].src='http://www.newco.dev.br/images/solicitar.gif';
	          document.images['CHKSOLICITAR_'+identificador].value='checked';
            return true;	          
	          
	        }
	        else {
	          lotes=(Math.abs(unidades)-(Math.abs(unidades)%unidadesporlote))/unidadesporlote+1;
	          alert(unidades + document.forms['MensajeJS'].elements['UNIDADES_NO_ENTERO_CAJAS'].value+'\n'+ document.forms['MensajeJS'].elements['REDONDEADO_COINCIDA'].value +Math.abs(lotes)+ document.forms['MensajeJS'].elements['CAJAS'].value +' ('+Math.abs(unidadesporlote*lotes)+ document.forms['MensajeJS'].elements['UNIDADES'].value + ')');	          
	          var nuevasUnidades=unidadesporlote*lotes;	
	          document.forms['form1'].elements['NuevaCantidad_'+identificador].value=nuevasUnidades;
	          document.images['CHKSOLICITAR_'+identificador].src='http://www.newco.dev.br/images/solicitar.gif';
	          document.images['CHKSOLICITAR_'+identificador].value='checked';
            return true;
	        }
        }
      }
	  }
         
         // util para comprobar que FORMA DE PAGO no esta vacio
         /*function ValidarFormaPago(obj) {
         	if (obj.value=="") {
         		alert("Rogamos introduzca una forma de pago válida");
         		return false;
         	} else {
         	  	return true;
         	}
         }YA NO SE USA*/
             
            /* 
          capturamos el evento de pulsar el boton 'ENTER'
          
          */
              
               
         function handleKeyPress(e) {
	  var keyASCII;
	  
	  if(navigator.appName.match('Microsoft'))
	    var keyASCII=event.keyCode;
	  else
            keyASCII = (e.which);
            
          if (keyASCII == 13) {
          
              /*
              validar que si es el estado 10 se someta el pedido
              */
             if(estado==10){   
               Actua(document.forms['anadir'],'MultiofertaSave.xsql?BOTON=ENVIAR');
             }
          }
        }
         
        
	// Asignamos la función handleKeyPress al evento 
	if(navigator.appName.match('Microsoft')==false)
	  document.captureEvents();
	document.onkeypress = handleKeyPress;        
                 
                
        function inicializarImportes(form){ 
           form.elements['MO_SUBTOTAL'].value=anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(form.elements['MO_SUBTOTAL'].value),2)),2);
      form.elements['MO_IMPORTEIVA'].value=anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(form.elements['MO_IMPORTEIVA'].value),2)),2);
      form.elements['IMPORTE_FINAL_PEDIDO'].value=anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(form.elements['IMPORTE_FINAL_PEDIDO'].value),2)),2);
         }
         
         
         function realizarCalculos(valor,obj,form,LMO_ID,LMO_IDPRODUCTO){
           Cantidad2Importe(form,LMO_ID,LMO_IDPRODUCTO);
         }
         
         function  realizarCalculosPorDefinir(valor,LMO_ID,LMO_IDPRODUCTO,form){
           form.elements['NuevoImporte_'+LMO_ID].value='Por definir';
           Cantidad2Importe(form,LMO_ID,LMO_IDPRODUCTO);
           CalculaSubtotal(form);
           //calculoConDescuento();
           
         }
         
         function verVacacionesComercial(idComercial){
              var fFecha=new Date();
              
              var fecha=convertirFechaATexto(fFecha);
              
              MostrarPagPersonalizada('http://www.newco.dev.br/Agenda/CalendarioAnual.xsql?ACCION=&TITULO=D%EDas%20H%E1biles%20del%20Comercial&FECHAACTIVA='+fecha+'&IDUSUARIOAGENDA='+idComercial+'&VENTANA=NUEVA','vacacionesProveedor',80,90,0,-50);
        
            }
            
        function validarChecks(form, objName){
        	for(var n=0;n<form.length;n++){
        		if(form.elements[n].name.substring(0,17)=='CHK_TODOSPEDIDOS_' && form.elements[n].name!=objName){
        			form.elements[n].checked=false;
        		}
        	}
      	}