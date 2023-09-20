

var estado = ]]></xsl:text><xsl:value-of select="Multioferta/MULTIOFERTA/MO_STATUS"/><xsl:text disable-output-escaping="yes"><![CDATA[;
	
	var msg_ImporteVacio = ']]></xsl:text><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0405' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes"><![CDATA[';
	var msgNoExplicacion="Rogamos comunique a su cliente el motivo del rechazo.";
	var msg_ImporteVacio = ']]></xsl:text><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0405' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes"><![CDATA[';
        var msgGeneraIncidencia="El rechazo de un pedido en este estado generará una incidencia en su contra. ¿Desea continuar?";
	var msgFaltaComentario = ']]></xsl:text><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0400' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes"><![CDATA[';
	
	
	function MensajeAyudaComentarioCliente () {
	 alert("Por favor, introduzca un comentario para el proveedor.\n\n * Preparar pedido: Para dar por finalizado el proceso de negociación. \n * Responder: Para continuar con la negociación.  \n * Terminar petición de oferta: Para dar por terminada la oferta. \n * Pendiente: Para dejar esta oferta pendiente.\n");
	}
	
	function MensajeAyudaComentarioClienteGen () {
	 alert("Por favor, introduzca un comentario para el proveedor.");
	}
	
	function MensajeAyudaComentarioProveedor () {
	 alert("Por favor, introduzca un comentario para el cliente.\n\n * Enviar: Para continuar con la negociación.  \n * Terminar petición de oferta: Para dar por terminada la oferta. \n * Pendiente: Para dejar esta oferta pendiente.\n");
	}
	function MensajeAyudaComentarioProveedorGen () {
	 alert("Por favor, introduzca un comentario para el cliente.");
	}
        
        
        /////////////////////////////////////inicio tratamiento divisas\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
        
        
        //variables globales
       
         var msgError='', msgErrorStd=' \n\nPor favor, corrija el error antes de enviar el formulario.';
         var ListaCampos;
         
       // fin varibles globales
      
        

///////////////

              var msgError='', msgErrorStd=' \n\nPor favor, corrija el error antes de enviar el formulario.';
       var ListaCampos;
	   
	   function obtenerIdDivisa(form,nombre){
	     if(form.elements[nombre].type=='select-one'){
	       return obtenerIdDesplegable(form, nombre);
             }        
	     else{
	       return form.elements[nombre].value;
	     }
	   }
	   
	   function actualizaHiddenDivisa(hiddenDivisa,valorDivisaMaestra){
	     hiddenDivisa.value=valorDivisaMaestra;
	   }
       
       function InicializarFormulario(){
         var ListaCreada=false;
         for(var i=0;i<document.forms.length;i++){
           var elForm=document.forms[i];
	   if(elForm.name=='form_iddivisa'){
	      ListaCampos = new MVMListaCampos(elForm);
	   }
	   else{
	     if(elForm.name!='form1'){
	       for(var n=0;n<elForm.length;n++){
                 if(elForm.elements[n].type=='text'){
                     if(elForm.elements[n].name.substring(0,12)=='NuevoPrecio_'){
                       ListaCampos.NuevoCampo(elForm.elements[n].name,'Precio Unitario',elForm.elements[n].value,'Decimal','Requerido',obtenerIdDivisa(elForm,'IDDIVISA'),'','','deUsuario');
                     }
                     else
                       if(elForm.elements[n].name.substring(0,14)=='NuevoCantidad_'){
                         ListaCampos.NuevoCampo(elForm.elements[n].name,'Cantidad',elForm.elements[n].value,'Decimal','Requerido','-1','','','');
                       }
                       else
                         if(elForm.elements[n].name.substring(0,13)=='NuevoImporte_'){
                           ListaCampos.NuevoCampo(elForm.elements[n].name,'Importe',elForm.elements[n].value,'Decimal','Requerido',obtenerIdDivisa(elForm,'IDDIVISA'),'','','');
                         }
                         else
                           if(elForm.elements[n].name=='MO_DESCUENTOGENERAL'){
                             ListaCampos.NuevoCampo(elForm.elements[n].name,'Descuento General',elForm.elements[n].value,'Decimal','Requerido','-1','','','deUsuario,admiteCeros');
                           }
                           else
                             if(elForm.elements[n].name=='MO_COSTELOGISTICA'){
                               ListaCampos.NuevoCampo(elForm.elements[n].name,'Coste Logística',elForm.elements[n].value,'Decimal','Requerido',obtenerIdDivisa(elForm,'IDDIVISA'),'','','deUsuario,admiteCeros');
                             }
                 }
	       }
	       ListaCampos.ValorOriginalDivisas(elForm, obtenerIdDivisa(elForm,'IDDIVISA'));
	       
	       calculaImportes();

	     }
	   }
         }
       }
       
       
       
       function CambioDivisa(){      
         for(var i=0;i<document.forms.length;i++){
	   var elForm=document.forms[i]; 
	   if(elForm.name!='form1' && elForm.name!='form_iddivisa'){
	     ListaCampos.RecalculaDivisas(elForm, obtenerIdDivisa(elForm,'IDDIVISA')); 
	     recalculaTotales(elForm,obtenerIdDivisa(elForm,'IDDIVISA'));     
	   }
         }
         calculaImportes()
	 return true;
       }
       
       function calculaImportes(){
         ]]></xsl:text>
           <xsl:for-each select="//LINEASMULTIOFERTA_ROW">
             Cantidad2Importe(document.forms['form1'],<xsl:value-of select="LMO_ID"/>,<xsl:value-of select="LMO_IDPRODUCTO"/>);
           </xsl:for-each>
         <xsl:text disable-output-escaping="yes"><![CDATA[ 
       }


///////////////

    
       
        function recalculaTotales(form,divisafinal){	  
	  CalculaSubtotal(form);
	  calculoConDescuento();
        }

       ///////
       
       /*
         funcion para el estado 10 (asignacion de pagos)
         en el desplegable de la divisa de las lineas de pago se selecciona el valor que admite el proveedor
       
       */       
       
       
       //////////////////////////////////////////fin tratamiento divisas\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
        
        /* Olivier: servia cuando teniamos 2 radios que permitian elegir entre: calculo a partir descuento / calculo
        a partir del importe final 
        
        function Actualizando(){
          if (document.form1.elements['seleccion'][0].checked==true){
            calculoConDescuento();
          }else{
            calculoConImporte();
            calculoConDescuento();          
          } 
        } */
       
        //
        // No es necesario el parametro: importe_total.
        //
        //
        function Reseteando(descuento,transporte){     
          document.form1.elements['MO_DESCUENTOGENERAL'].value=FormateaVis(descuento);
          document.form1.elements['MO_COSTELOGISTICA'].value=FormateaVis(transporte);         
          calculoConDescuento();          
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
            calculoConDescuento();
          //}else{
          //  calculoConImporte();           
          //}
        }
	
	
	function calculoConDescuento(){  	 
	  descuento=desformateaDivisa(document.form1.elements['MO_DESCUENTOGENERAL'].value,document.form1.elements['MO_DESCUENTOGENERAL']);
	  if (isNaN(descuento) || descuento<0 || descuento>100){
	    alert('Introduzca un valor de descuento correcto en %');
	  }else{	
	    var subtotal=0;
	    var importeiva=0;
	    var iva=0;
	   
	    for(k=0;k<document.form1.elements.length;k++){

	      if (document.form1.elements[k].name.substr(0,7)=='IMPORTE' && document.form1.elements[k].name!='IMPORTE_FINAL_PEDIDO'){
	         if (document.form1.elements[k].value!=""){
	           
	           importe=parseFloat(document.form1.elements[k].value);	       
	         }else{
	           importe=0;
	           porDefinir=1;
	         }
 
	        
	        identificador=document.form1.elements[k].name.substr(7,document.form1.elements[k].name.length);	       
	        var cadenaId='IVA'+identificador;
	        
	        iva=document.form1.elements['IVA'+identificador].value; 
	        
	            
	        importeiva+=importe*(iva/100);
	         
                subtotal+=importe;
                       
	      }
	      
	    }
	    subtotal*=(1-descuento/100);
	    
	    transporte=desformateaDivisa(document.form1.elements['MO_COSTELOGISTICA'].value);
	    
	    importeiva=importeiva*(1-descuento/100)+transporte*16/100;
	    
	    importeiva=Round(importeiva,Divisas[document.form1.elements['IDDIVISA'].options[document.form1.elements['IDDIVISA'].selectedIndex].value][3])
	    document.form1.elements['MO_IMPORTEIVA'].value=FormateaNumeroNacho(importeiva);
	    var finalTotal=Round(subtotal+transporte+importeiva,Divisas[document.form1.elements['IDDIVISA'].options[document.form1.elements['IDDIVISA'].selectedIndex].value][3]);
	    document.form1.elements['IMPORTE_FINAL_PEDIDO'].value=FormateaNumeroNacho(finalTotal);
	  
	  }
	}
	
	function actualizaValores(form, nombre){
	  ListaCampos.ActualizaValores(nombre, form);
	}
	
	function calculoConImporte(){
	  porDefinir=0;
	  importefinal=AntiformateaVis(document.form1.elements['IMPORTE_FINAL_PEDIDO'].value,document.form1.elements['IMPORTE_FINAL_PEDIDO']);
	  if (isNaN(importe)){
	    alert('Introduzca un valor de importe correcto');
	  }else{	
	    var subtotal=0;
	    var importeiva=0;
	    for(k=0;k<document.form1.elements.length;k++){
	      if (document.form1.elements[k].name.substr(0,7)=='IMPORTE' && document.form1.elements[k].name!='IMPORTE_FINAL_PEDIDO'){
	         if (document.form1.elements[k].value!=""){
	           importe=parseFloat(document.form1.elements[k].value);	        
	         }else{
	           importe=0;
	           porDefinir=1;
	         }
	        identificador=document.form1.elements[k].name.substr(7,document.form1.elements[k].name.length);
	        iva=(document.form1.elements['IVA'+identificador].value);
	        importeiva+=importe*(iva/100);
                subtotal+=importe;	      
	      }
	    }	    
	    transporte=AntiformateaVis(document.form1.elements['MO_COSTELOGISTICA'].value,document.form1.elements['MO_COSTELOGISTICA']);
	    importeiva=importeiva*(1-descuento/100)+transporte*16/100;
	    document.form1.elements['MO_IMPORTEIVA'].value=FormateaVis(Decimales_con_punto(importeiva, 0, 0));
	    document.form1.elements['MO_DESCUENTOGENERAL'].value=FormateaVis(Decimales_con_punto(100*(subtotal+importeiva-importefinal+transporte)/subtotal, 2, 0));
	  }
	}
	function ValidaDescuento(){
	  formu=document.forms['form1'];
	  descuento = parseFloat(AntiformateaVis(formu.elements['MO_DESCUENTOGENERAL'].value));
	  if (checkNumber(formu.elements['MO_DESCUENTOGENERAL'].value,formu.elements['MO_DESCUENTOGENERAL'])){
	    if (descuento>=0 && descuento<=100){
	      return true;
	    }else{
	      alert('El descuento aplicado es menor de 0 o mayor de 100');	    
	      return false;
	    }
	  }else{
	    return false;
	  }
	}
	function Valida(formu){
	 //alert('voy a someter');
	 if (formu.elements['LPP_IMPORTE'].value <= 0) {
	   alert(msg_ImporteVacio);
	 } else {
	   if (checkNumber(formu.elements['LPP_IMPORTE'].value,formu.elements['LPP_IMPORTE'])){ 
	     formu.elements['LPP_IMPORTE'].value=quitaPuntos(formu.elements['LPP_IMPORTE'].value);
	     formu.elements['LPP_IMPORTE'].value=AntiformateaVis(formu.elements['LPP_IMPORTE'].value);
	     if (test(formu)) SubmitForm(formu);
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
	
        function ConfirmarBorrado(formu){        
	  var contestacion = confirm("¿Esta seguro de borrar este pago?");
	  if (contestacion) {
	    return true;
	  }
	  else return false;
	}	
	
	function Eliminar(formu,accion){
          if (ConfirmarBorrado(formu)) {
            AsignarAccion(formu,accion);
            SubmitForm(formu);	
          }
	}
	function Anadir(formu,accion){	
	  AsignarAccion(formu,accion);
	  Valida(formu);
	}
	
	// 
	// Estado 6. Cuando el proveedor rechaza una oferta.
	//
	function NoInteresa(formu,accion){
	  
	  
	  if (HayComent(formu)) {
	        formu.elements['STRING_PRECIOS'].value = ConstruirString(formu,'NuevoPrecio_');
	  	AsignarAccion(formu,accion);
	  	SubmitForm(formu);
	  } else {
	  	MensajeAyudaComentarioProveedor();
	  }
	}
	
	function ValidarStringCantidades (formu) {
	     var cadena="";
	     var cant;
	     for (i=0;i<formu.length;i++)
	        {
	        if (formu.elements[i].name.substring(0,14)=="NuevaCantidad_")
	            {
		            if (formu.elements[i].value=='') {
		              alert("Por favor, introduzca una cantidad. Gracias.");
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
	//  
	// Obligamos a introduir la forma de pago.
	//
	
	
	
	
	if (estado==7) {
	  //nacho  13/2/2002
	  //copiamos la forma de pago (text) al forma de pago (hidden) siempre
	 
	  formu.elements['MO_FORMAPAGO'].value=formu.elements['MO_FORMADEPAGO'].value;
	
	  	// valido que si se quiere dejar pendiente no se valide forma de pago
	        if (accion.match("PENDIENTE")==null) {
		  if (!ValidarFormaPago(document.form1.MO_FORMAPAGO)){
		    return;
		  }
		}
	}
	
		
	
	//
	// Obligamos al usuario a introducir un comentario i lo copiamos en el form1.
	//
	if (estado==7 || estado==10 || estado==11 || estado==13) {
	
		if ((formu.elements['NMU_COMENTARIOS'].value=="") && (accion.match("PENDIENTE")==null && accion.match("CONFIRMAR")==null) && (estado==7)) {
		    MensajeAyudaComentarioCliente();
		    return; // Salimos
		} else {
		  // Copiamos el comentario en el form1.
		  //alert('copiando comentarios a form1');
		  comentariosToForm1(document.forms['form1'], document.forms['form1'],'NMU_COMENTARIOS');
		  //alert('he copiado los coments...');
		}	
	}
	
	//
	// Definicion de Pagos
	//
	if (estado==10 && accion.match('ENVIAR')) { 
	   
	     if (ComprobarFecha(document.forms['form1'])) {
	  	comentariosToForm1(document.forms['form1'],document.forms['form1'],'NMU_COMENTARIOS');
	  	comentariosToForm1(document.forms['form1'],document.forms['form1'],'FECHA_ENTREGA');
	  	comentariosToForm1(document.forms['form1'],document.forms['form1'],'MO_FORMAPAGO');
                formu.elements['LPP_IMPORTE'].value=desformateaDivisa(formu.elements['LPP_IMPORTE'].value);
                //formu.elements['MO_COSTELOGISTICA'].value=desformateaDivisa(formu.elements['MO_COSTELOGISTICA'].value);	        
	  	AsignarAccion(formu,accion);

	  	SubmitForm(formu);
	     }
	} else if (estado==7) {
	        //
	        // CUIDADO: Tambien hay que modificar la función Cantidad2Importe()
	        //
	        
	        if (ValidarStringCantidades(formu))
	        {
	        formu.elements['STRING_CANTIDADES'].value = ConstruirString (formu,'NuevaCantidad_');
	        
	        //nacho 8/2/2002
	        // le pasamos el string precios para poder ver si se ha cambiado la divisa y entonces actualizarla
	        
	        formu.elements['STRING_PRECIOS'].value = ConstruirString(formu,'NuevoPrecio_');
		comentariosToForm1(document.forms['form1'], document.forms['form1'],'NMU_COMENTARIOS');
	        AsignarAccion(formu,accion);
	        
	        
	        formu.elements['MO_DESCUENTOGENERAL'].value=quitaPuntos(formu.elements['MO_DESCUENTOGENERAL'].value);
	        formu.elements['MO_COSTELOGISTICA'].value=desformateaDivisa(formu.elements['MO_COSTELOGISTICA'].value);
	        formu.elements['MO_IMPORTEIVA'].value=quitaPuntos(formu.elements['MO_IMPORTEIVA'].value);
	        formu.elements['IMPORTE_FINAL_PEDIDO'].value=quitaPuntos(formu.elements['IMPORTE_FINAL_PEDIDO'].value);
	        
	        //mostrarCamposForm(formu)
	        //for(var n=0;n<formu.length;n++)
                  //alert(formu.elements[n].name+'\n'+formu.elements[n].type+'\n'+formu.elements[n].value);
	  	SubmitForm(document.forms['form1']);
	  	}
       } else {
       	  //
	  // El resto de estados...
	  //
	  AsignarAccion(formu,accion);
	  SubmitForm(formu);
       }
       
      } // f.-Actua()
	
	// +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
	//
	// 
	// Ferran Foz - nextret.net - 25.4.2001
	//    No pedimos confirmación cuando el proveedor rechaza un pedido.
	//
	function Rechazar(formu,accion){
	  if (formu.elements['NMU_COMENTARIOS'].value==""){
	    alert(msgNoExplicacion);
	    //formu.elements['NMU_COMENTARIOS'].focus();
	  }else{
	      AsignarAccion(formu,accion);
	      SubmitForm(formu);	
	  }
	}
	
	//
	// solo para el estado 6...
	//
	function Actua_Check_Number(formu,accion){
	
	 
	
	  if (porDefinir==1){
	     // alert(']]></xsl:text><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0670' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes"><![CDATA[');	   
		 
		 alert('Debe asignar todos los precios antes de enviar la oferta.');	  
	  }else{
	    //Construye lista iva
	    //Mira si todos los campos numericos son correctos. 
	    //Si es asi los antifromatea para la base de datos y hace submit. 

	    // Si el usuario no ha introducido comentario. Le recordamos que tiene que introducirlo.	        
		if ((document.forms['form1'].elements['NMU_COMENTARIOS'].value=="") && (accion.match("PENDIENTE")==null)) {
		    MensajeAyudaComentarioProveedor();
		    return;
		}
	    
	    //alert("formu.elements['MO_DESCUENTOGENERAL'].name: "+formu.elements['MO_DESCUENTOGENERAL'].value+"\nformu.elements['MO_COSTELOGISTICA'].name: "+formu.elements['MO_COSTELOGISTICA'].value+"\nformu.elements['MO_IMPORTEIVA'].name: "+formu.elements['MO_IMPORTEIVA'].value+"\nformu.elements['IMPORTE_FINAL_PEDIDO'].name: "+formu.elements['IMPORTE_FINAL_PEDIDO'].value);
	    formu.elements['MO_DESCUENTOGENERAL'].value=quitaPuntos(formu.elements['MO_DESCUENTOGENERAL'].value);
	    formu.elements['MO_COSTELOGISTICA'].value=quitaPuntos(formu.elements['MO_COSTELOGISTICA'].value);
	    formu.elements['MO_IMPORTEIVA'].value=quitaPuntos(formu.elements['MO_IMPORTEIVA'].value);
	    formu.elements['IMPORTE_FINAL_PEDIDO'].value=quitaPuntos(formu.elements['IMPORTE_FINAL_PEDIDO'].value);
	    
	    
	    if (checkNumber(formu.elements['MO_DESCUENTOGENERAL'].value,formu.elements['MO_DESCUENTOGENERAL']) && checkNumber(formu.elements['MO_COSTELOGISTICA'].value,formu.elements['MO_COSTELOGISTICA']) && checkNumber(formu.elements['MO_IMPORTEIVA'].value,formu.elements['MO_IMPORTEIVA']) && checkNumber(formu.elements['IMPORTE_FINAL_PEDIDO'].value,formu.elements['IMPORTE_FINAL_PEDIDO'])){
	      if (ValidaDescuento()==true){
	        agrupaArrayIVA(formu,'IVA','LISTAIVAPRODUCTOS');
	
		// #sustituye#
	        formu.elements['MO_DESCUENTOGENERAL'].value = AntiformateaVis(formu.elements['MO_DESCUENTOGENERAL'].value);
	        formu.elements['MO_COSTELOGISTICA'].value = AntiformateaVis(formu.elements['MO_COSTELOGISTICA'].value);
	        formu.elements['MO_IMPORTEIVA'].value = AntiformateaVis(formu.elements['MO_IMPORTEIVA'].value);
	        formu.elements['IMPORTE_FINAL_PEDIDO'].value = AntiformateaVis(formu.elements['IMPORTE_FINAL_PEDIDO'].value);
	        
	        formu.elements['STRING_PRECIOS'].value = ConstruirString(formu,'NuevoPrecio_');
		   
	        AsignarAccion(formu,accion);
	        formu.elements['MO_IMPORTEIVA'].disabled=false;
	        //alert('envio el form');
	        //mostrarCamposForm(formu);
	        SubmitForm(formu);
	      }
	    }
	  }
	}
	
	
	function mostrarCamposForm(form){
         for(var n=0;n<form.length;n++)
             alert(form.name+'\n\n'+form.elements[n].name+' '+form.elements[n].type+' '+form.elements[n].value);
       }
	
	//
        // CodigoProducto, Cliente, MO_ID, ROL, TIPO 
        //
	function SaltaTarifas(codprod,cliente,mo_id,rol,tipo){
	  var saltar = "http://www.newco.dev.br/Compras/Multioferta/Multioferta.xsql";
	  var prmextra = "(MO_ID,"+mo_id+"),(ROL,"+rol+"),(TIPO,"+tipo+")";
	  var newlocation = "http://www.newco.dev.br/Administracion/Mantenimiento/Tarifas/TRFManten.xsql"
	  newlocation=newlocation + "?EMP_ID="+cliente;
	  newlocation=newlocation +"&PRO_ID="+codprod;
	  newlocation=newlocation +"&MO_ID="+mo_id;
	  newlocation=newlocation +"&SALTAR="+saltar;
	  newlocation=newlocation +"&PRMEXTRA="+prmextra;
	 // newlocation=newlocation +"&xml-stylesheet=none";
	 // prompt(newlocation,newlocation);
          window.location = newlocation;
        }
        
        function Focaliza(){
          document.forms['form1'].elements['FECHANO_PAGO'].focus();      
        }
        

	// Construimos array (identificador1,valor1),(identificador2,valor2),(identificador3,valor3),..
	// Lo ponemos en el hidden NombreCampoLista
	function agrupaArrayIVA(formu,NombreCampoCheck,NombreCampoLista){
          longitud=NombreCampoCheck.length;
          seleccion = new Array;
          var primeraVez = 0;
	  for(i=0; i<formu.elements.length; i++){
	    if (formu.elements[i].name.substr(0,longitud)==NombreCampoCheck){
	      if (primeraVez==0){
                 seleccion='('+formu.elements[i].name.substr(longitud,formu.elements[i].name.length)+','+formu.elements[i].value+')';
                 primeraVez=1;
               }
               else {
                 seleccion=seleccion+',('+formu.elements[i].name.substr(longitud,formu.elements[i].name.length)+','+formu.elements[i].value+')';
               }
            }
          }
          
          formu.elements[NombreCampoLista].value=seleccion;
          
        }
        
        var producto = null;
        function MostrarPag(pag){
          if (is_nav){
            ample=parseInt(window.outerWidth*80/100)-50;
            alcada=parseInt(window.innerHeight-23)-50;
            alt=parseInt(window.parent.innerHeight+18)-parseInt(window.innerHeight)+25;
            esquerra = parseInt(window.outerWidth*18/100)+25;
            if (producto && producto.open){
              producto.close();            
            }
            producto=window.open(pag,'procesoVenta','toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',screenX='+esquerra+',screenY='+alt);
          }else{
            ample = window.screen.availWidth-window.screenLeft-15-50;
            alcada = document.body.offsetHeight-27-50;
            esquerra = window.screenLeft+25;
            alt = window.screenTop+25;
            if (producto && producto.open && !producto.closed) producto.close();
	    producto=window.open(pag,'procesoVenta','toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',top='+alt+',left='+esquerra);
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
        
        //
        // Se llama desde el estado 10 en el cual se puede introducir una nueva FECHA_ENTREGA
        // 
        function ComprobarFecha(formu) { 
          if  (test(formu)) {
                fechaActualTemp = new Date();
                fechaActual=fechaActualTemp.getDate()+'/'+eval(fechaActualTemp.getMonth()+1)+'/'+fechaActualTemp.getFullYear();
        	 if (comparaFechas(formu.elements['FECHA_ENTREGA'].value,fechaActual)=='<')
        	    {  
                    alert(']]></xsl:text><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0530' and @lang=$lang]"/><xsl:text disable-output-escaping="yes"><![CDATA[');
                    formu.elements['FECHA_ENTREGA'].focus();
                    return false;
                    }
                 if ( (comparaFechas(document.forms['form1'].elements['FECHANO_PAGO'].value,fechaActual)=='<') &&  !(document.forms['form1'].elements['LPP_IMPORTE'].value=='') && (document.forms['form1'].elements['LPP_IMPORTE'].value>0) )
        	    {  
                    alert(']]></xsl:text><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0550' and @lang=$lang]"/><xsl:text disable-output-escaping="yes"><![CDATA[');
                    document.forms['form1'].elements['FECHANO_PAGO'].focus();
                    return false;
                    }   
                
                else return true;
                }   
          else return false;
           }
         
         //
         // estas 2 funciones se llaman desde el estado 7 en el cual podemos cambiar CANTIDADES.
         // Recalculo el importe, el subtotal y al final llamo a calculoConDescuento()
         //
         function Cantidad2Importe(formu,lmo_id,lmo_idproducto){

           var cant,precio,resultado;
 
	     
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
                   precio='';
                   formu.elements['NuevoPrecio_'+lmo_id].value='';
                 }
	         

	         formu.elements['NuevoImporte_'+lmo_id].value=formateaDivisa(Round(resultado,Divisas[obtenerIdDivisa(formu,'IDDIVISA')][3]));

	         formu.elements['IMPORTE'+lmo_idproducto].value=resultado;

                 ListaCampos.ActualizaValores('NuevoPrecio_'+lmo_id,formu);
	         ListaCampos.ActualizaValores('NuevaCantidad_'+lmo_id,formu);
	         ListaCampos.ActualizaValores('NuevoImporte_'+lmo_id,formu);
	         
	         
	         CalculaSubtotal(formu);
	         
	         calculoConDescuento();
	         formu.elements['MO_DESCUENTOGENERAL'].value=Antiformatea(formu.elements['MO_DESCUENTOGENERAL'].value);
	         
         }
         
         function CalculaSubtotal(formu){
           
           var sum=parseFloat(0);
           var cantidadSinFormato;
           for(i=0;i<formu.length;i++){
             if (formu.elements[i].name.substring(0,13)=='NuevoImporte_' && formu.elements[i].value!='' ){ 
               cantidadSinFormato=desformateaDivisa(formu.elements[i].value);
               sum=sum+parseFloat(cantidadSinFormato);
             }
           }
           
           formu.elements['MO_SUBTOTAL'].value=formateaDivisa(Round(sum,Divisas[obtenerIdDivisa(formu,'IDDIVISA')][3]));
         }
         
          //
          // Comprueba que el numero de unidades introducidas coincide con un multiplo del
	  // numero de lotes
	  // Se pide confirmacion para redondearlo a la alza si no es asi.
	  //
	  function UnidadesALotes(unidades,unidadesporlote,objeto){
	    var identificador=objeto.name.substr(14,objeto.name.length);
            if (objeto.value == ""){
	      alert('Por favor, introduzca una cantidad');
	      objeto.focus();
	      return false;
              }	                   
            else{
	      if(objeto.value < 0 || isNaN(objeto.value)){
	        alert('Por favor, introduzca una cantidad correcta');
	        objeto.focus();
	        return false;
	      }else{	    	  	
	        var lotes;	        
	        if (unidades%unidadesporlote==0){
	          lotes=unidades/unidadesporlote;
	          	          
	          
	        }else {
	          lotes=(unidades-(unidades%unidadesporlote))/unidadesporlote+1;
	          alert(unidades+' unidad(es) no corresponde a un numero entero de cajas. \nSe han redondeado para que coincida con '+lotes+' caja(s). ('+unidadesporlote*lotes+' unidad(es))');	          
	        }
	        var nuevasUnidades=unidadesporlote*lotes;	    
	             
	        document.forms['form1'].elements['NuevaCantidad_'+identificador].value=nuevasUnidades;
                return true;
              }
            }
	  }
         
         // util para comprobar que FORMA DE PAGO no esta vacio
         function ValidarFormaPago(obj) {
         	if (obj.value=="") {
         		alert("Rogamos introduzca una forma de pago válida");
         		return false;
         	} else {
         	  	return true;
         	}
         }
                   