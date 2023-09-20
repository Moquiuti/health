<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |
 |		templates para la ficha de multioferta
 |		incluimos:
 |			los templates comunes (cabecera, negociacion, ...)
 |			los templates propios de la propia pagina (formulario y javascript por separado)
 |
 |
 |
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <!--
  						T E M P L A T E S   C O M U N E S
  -->

  <xsl:template name="el-nombre">

  </xsl:template>


  <xsl:template name="cabecera">

  	<table width="100%" border="0" cellpadding="3" cellspacing="1">
    	<tr>
      	<td align="center">
        	<table width="95%" border="0" class="muyoscuro" cellpadding="3" cellspacing="1">
          	<tr class="oscuro">
            	<td valign="top" colspan="2">
              	<table width="100%" border="0" cellpadding="0" cellspacing="0" height="100%">
                	<tr>
                  	<td colspan="2" align="left">

                    	<xsl:if test="DATOSCLIENTE/EMP_NOMBRE!=CENTRO/CEN_NOMBRE">
                      	Centro: <b><xsl:value-of select="CENTRO/CEN_NOMBRE"/></b>
                      	<br/>
                      </xsl:if>

                      Cliente: <b><xsl:value-of select="DATOSCLIENTE/EMP_NOMBRE"/></b>

                    </td>
                    <td colspan="2" align="right">

                      Nif:

                      <xsl:choose>
                      	<xsl:when test="DATOSCLIENTE/EMP_NIF!=CENTRO/CEN_NIF and CENTRO/CEN_NIF!=''">

                        	<b><xsl:value-of select="CENTRO/CEN_NIF"/></b>
                          <xsl:if test="DATOSCLIENTE/EMP_NOMBRE!=CENTRO/CEN_NOMBRE">
                          	<br/>
                            <br/>
                          </xsl:if>

                        </xsl:when>
                        <xsl:otherwise>

                          <b><xsl:value-of select="DATOSCLIENTE/EMP_NIF"/></b>
                          <xsl:if test="DATOSCLIENTE/EMP_NOMBRE!=CENTRO/CEN_NOMBRE">
                            <br/>
                            <br/>
                          </xsl:if>

                        </xsl:otherwise>
                      </xsl:choose>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr class="blanco">
            	<td class="claro" colspan="2">
              	<b><xsl:value-of select="ENTREGA/MO_LUGARENTREGA"/></b>&nbsp;Direcci�n:
              </td>
            </tr>
            <tr class="blanco">
            	<td colspan="2">
              	<table align="left">
                	<tr>
                  	<td>
                    	&nbsp;&nbsp;
                    </td>
                    <td>
                    	<xsl:choose>
                      	<xsl:when test="DATOSCLIENTE/EMP_NOMBRE!=CENTRO/CEN_NOMBRE">
                        	<xsl:call-template name="direccionCentro">
                          	<!-- <xsl:with-param name="path" select="CENTRO"/>-->
                            <xsl:with-param name="path" select="ENTREGA"/>
                          </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                        	<xsl:call-template name="direccion">
                          	<xsl:with-param name="path" select="DATOSCLIENTE"/>
                          </xsl:call-template>
                        </xsl:otherwise>
                      </xsl:choose>
                    </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr class="blanco">
                <td align="center" class="claro">
                  Comprador:
                </td>
                <td align="center" class="blanco">
                  <xsl:value-of select="COMPRADOR"/>
                </td>
              </tr>
            </table>
          </td>
          <td align="center">
            <table width="95%" border="0" class="muyoscuro" cellpadding="3" cellspacing="1">
              <tr class="oscuro">
                <td colspan="2">
                <table width="100%" cellpadding="0" cellspacing="0" height="100%">
                  <tr>
                    <td align="left">
                     Proveedor: <b><xsl:value-of select="DATOSPROVEEDOR/EMP_NOMBRE"/></b>
                     <xsl:if test="DATOSCLIENTE/EMP_NOMBRE!=CENTRO/CEN_NOMBRE">
                      <br/>
                      <br/>
                      </xsl:if>
                    </td>
                    <td align="right">
                      Nif: <b><xsl:value-of select="DATOSPROVEEDOR/EMP_NIF"/></b>
                      <xsl:if test="DATOSCLIENTE/EMP_NOMBRE!=CENTRO/CEN_NOMBRE">
                      <br/>
                      <br/>
                      </xsl:if>
                    </td>
                  </tr>
                </table>
                </td>
              </tr>
              <tr class="blanco">
                <td class="claro" colspan="2">
                  Direcci�n:
                </td>
              </tr>
              <tr class="blanco">
                <td colspan="2">
                  <table align="left">
                    <tr>
                      <td>
                        &nbsp;&nbsp;
                      </td>
                      <td>
                        <xsl:call-template name="direccion">
                          <xsl:with-param name="path" select="DATOSPROVEEDOR"/>
                        </xsl:call-template>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr class="blanco">
                <td align="center" class="claro">
                  Comercial:
                </td>
                <td align="center" class="blanco">
                  <xsl:value-of select="VENDEDOR"/>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>

	</xsl:template>






  <!--
  						TEMPLATES JAVASCTIPT (por orden de estado: 6, 7, 8,...)
  -->

  <!--  js 6 -->

  <xsl:template name="javascript-6">

  	<script type="text/javascript">
  		<!--

				var estado = ]]></xsl:text><xsl:value-of select="Multioferta/MULTIOFERTA/MO_STATUS"/><xsl:text disable-output-escaping="yes"><![CDATA[;
				var divisaIni = ]]></xsl:text><xsl:value-of select="//@current"/><xsl:text disable-output-escaping="yes"><![CDATA[;

				var msg_ImporteVacio = ']]></xsl:text><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0405' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes"><![CDATA[';
				var msgNoExplicacion="Rogamos comunique a su cliente el motivo del rechazo.";
				var msg_ImporteVacio = ']]></xsl:text><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0405' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes"><![CDATA[';
        var msgGeneraIncidencia="El rechazo de un pedido en este estado generar� una incidencia en su contra. �Desea continuar?";
				var msgFaltaComentario = ']]></xsl:text><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0400' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes"><![CDATA[';

				function MensajeAyudaComentarioCliente () {
	 				alert("Por favor, introduzca un comentario para el proveedor.\n\n * Preparar pedido: Para dar por finalizado el proceso de negociaci�n. \n * Responder: Para continuar con la negociaci�n.  \n * Terminar petici�n de oferta: Para dar por terminada la oferta. \n * Pendiente: Para dejar esta oferta pendiente.\n");
				}

				function MensajeAyudaComentarioClienteGen () {
	 				alert("Por favor, introduzca un comentario para el proveedor.");
				}

				function MensajeAyudaComentarioProveedor () {
	 				alert("Por favor, introduzca un comentario para el cliente.\n\n * Enviar: Para continuar con la negociaci�n.  \n * Terminar petici�n de oferta: Para dar por terminada la oferta. \n * Pendiente: Para dejar esta oferta pendiente.\n");
				}

				function MensajeAyudaComentarioProveedorGen () {
	 				alert("Por favor, introduzca un comentario para el cliente.");
				}

        var msgError='', msgErrorStd=' \n\nPor favor, corrija el error antes de enviar el formulario.';



	   		function obtenerIdDivisa(form,nombre){
	     		if(form.elements[nombre].type=='select-one'){
	       		return obtenerIdDesplegable(form, nombre);
          }
	     		else{
	       		return form.elements[nombre].value;
	     		}
	   		}

        function Reseteando(descuento,transporte){
        	//document.form1.elements['MO_DESCUENTOGENERAL'].value=FormateaVis(descuento);
          //document.form1.elements['MO_COSTELOGISTICA'].value=FormateaVis(transporte);

          document.form1.elements['MO_DESCUENTOGENERAL'].value=descuento;
          document.form1.elements['MO_COSTELOGISTICA'].value=transporte;
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
	      		linea : C�digo del producto
	      		nuevoValor: Nuevo importe IVA.
        **/
        function actualizaIVA(linea,nuevoValor){
	  			document.forms['form1'].elements['IVA'+linea].value=nuevoValor;
          calculoConDescuento();

        }

				function calculoConDescuento(){
	  			porDefinir=0;
	  			descuento=AntiformateaVis(document.form1.elements['MO_DESCUENTOGENERAL'].value,document.form1.elements['MO_DESCUENTOGENERAL']);
	  			if (isNaN(descuento) || descuento<0 || descuento>100 || ! esEntero(descuento)){
	    			alert('Introduzca un valor de descuento correcto en %');
	  			}
	  			else{
	    			var subtotal=0;
	    			var importeiva=0;
	    			var iva=0;

	    			for(k=0;k<document.form1.elements.length;k++){

	      			if (document.form1.elements[k].name.substr(0,7)=='IMPORTE' && document.form1.elements[k].name!='IMPORTE_FINAL_PEDIDO'){
	         			if (document.form1.elements[k].value!='' && document.form1.elements[k].value!='Por definir'){
	           			//alert('k: '+k+' '+document.form1.elements[k].name+' '+document.form1.elements[k].type+' '+document.form1.elements[k].value);
	           			importe=parseFloat(reemplazaComaPorPunto(document.form1.elements[k].value));
	           			//alert(importe);
	         			}
	         			else{
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
	    			subtotal*=(1-descuento/100);
	    			transporte=desformateaDivisa(document.form1.elements['MO_COSTELOGISTICA'].value);

	    			importeiva=importeiva*(1-descuento/100)+transporte*16/100;
	    			//document.form1.elements['MO_IMPORTEIVA'].value=FormateaVis(Decimales_con_punto(importeiva, 0, 0));
	    			//document.form1.elements['IMPORTE_FINAL_PEDIDO'].value=FormateaVis(Decimales_con_punto(subtotal+transporte+importeiva, 0, 0));
	    			importeiva=Round(importeiva,Divisas[obtenerIdDivisa(document.form1,'IDDIVISA')][3]);

	    			if(!porDefinir){
	      			document.form1.elements['MO_IMPORTEIVA'].value=anyadirCerosDecimales(FormateaNumeroNacho(Round(importeiva,2)),2);
	      			var finalTotal=Round(subtotal+transporte+importeiva,Divisas[obtenerIdDivisa(document.form1,'IDDIVISA')][3]);
	      			//alert(finalTotal);
	      			document.form1.elements['IMPORTE_FINAL_PEDIDO'].value=anyadirCerosDecimales(FormateaNumeroNacho(Round(finalTotal,2)),2);
	    			}
	    			else{
	      			document.form1.elements['MO_IMPORTEIVA'].value='Por definir';
	      			document.form1.elements['IMPORTE_FINAL_PEDIDO'].value='Por definir';
	    			}
	  			}
				}

				function calculoConImporte(){
	  			porDefinir=0;
	  			importefinal=AntiformateaVis(document.form1.elements['IMPORTE_FINAL_PEDIDO'].value,document.form1.elements['IMPORTE_FINAL_PEDIDO']);
	  			if (isNaN(importe)){
	    			alert('Introduzca un valor de importe correcto');
	  			}
	  			else{
	    			var subtotal=0;
	    			var importeiva=0;
	    			for(k=0;k<document.form1.elements.length;k++){
	      			if (document.form1.elements[k].name.substr(0,7)=='IMPORTE' && document.form1.elements[k].name!='IMPORTE_FINAL_PEDIDO'){
	         			if (document.form1.elements[k].value!=""){
	           			importe=parseFloat(document.form1.elements[k].value);
	        	 		}
	        	 		else{
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
	    			}
	    			else{
	      			alert('El descuento aplicado es menor de 0 o mayor de 100');
	      			return false;
	    			}
	  			}
	  			else{
	    			return false;
	  			}
				}

				function Valida(formu){
	 				//alert('voy a someter');
	 				if (formu.elements['LPP_IMPORTE'].value <= 0) {
	   				alert(msg_ImporteVacio);
	 				}
	 				else{
	   				if (checkNumber(formu.elements['LPP_IMPORTE'].value,formu.elements['LPP_IMPORTE'])){
	     				formu.elements['LPP_IMPORTE'].value=quitaPuntos(formu.elements['LPP_IMPORTE'].value);
	     				formu.elements['LPP_IMPORTE'].value=AntiformateaVis(formu.elements['LPP_IMPORTE'].value);
	     				if (test(formu)){
	      				//DeshabilitarBotones(document);
	      				SubmitForm(formu,document);
	     				}
	   				}
         	}
        }

				function HayComent(formu){

	  			if(formu.elements['NMU_COMENTARIOS'].value==''){
	    			return false;
	  			}
	  			else {
	    			return true;
	  			}
				}

				function ValidarStringCantidades (formu) {
	     		var cadena="";
	     		var cant;
	     		for (i=0;i<formu.length;i++){
	        	if (formu.elements[i].name.substring(0,14)=="NuevaCantidad_"){
		        	if (formu.elements[i].value=='') {
		          	alert("Por favor, introduzca una cantidad. Gracias.");
		            formu.elements[i].focus();
		            return false;
		          }
		          else{
		          	// Validamos el numero con checkNumber. Este ya devuelve el mensaje de error.
		            if (!checkNumber(formu.elements[i].value,formu.elements[i]))
		            	return false;
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
	     		for (i=0;i<formu.length;i++){
	        	if (formu.elements[i].name.substring(0,lg)==aBuscar){

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
	  			AsignarAccion(formu,accion);
	  			//DeshabilitarBotones(document);
	  			SubmitForm(formu,document);
       	}


       /*
        Copiada de general se ha a�adido la posibilidad de que acepte numeros negativos,
        esto es necesario para las ofertas / pedidos tipo "ABONO"
       */

       function AntiformateaVisConSigno(Numero,objeto){
       	Numero=String(Numero);
	    	newNumber = "";    // REVISED/CORRECTED STRING
	    	coma=0;
	    	punto=0;
	    	for (var l = 0; l < Numero.length; l++) {
	      	ch = Numero.substring(l, l+1);
	        if ((ch >= "0" && ch <= "9")|| ch=='-') {
	        	newNumber += ch;
	        }
	        else{
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
	              }
	              else{
	                alert('Error en el dato '+Numero+', ha introducido m�s de una coma');
	                objeto.focus();
	                return Number(Numero);
	              }
	            }
	            else {
	              //Si encontramos otro caracter mostramos alert.
	              alert('Ha introducido el valor '+Numero+' . Por favor, reemplacelo por un n�mero correcto');
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
	      	}
	      	else {
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


      /*
      	Copiada de general se ha a�adido la posibilidad de que acepte numeros negativos,
        esto es necesario para las ofertas / pedidos tipo "ABONO"
      */


      function checkNumberconSigno(checkString,objeto){

	    	checkString=String(checkString);
	    	newString = "";
	    	coma=0;
	    	punto=0;

	    	for (var i = 0; i < checkString.length; i++){
	      	ch = checkString.substring(i, i+1);
	      	if ((ch >= "0" && ch <= "9")|| ch=='-'){
	        	newString += ch;
	      	}
	      	else{
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
	            	}
	            	else{
	              	alert('Error en el dato '+checkString+', ha introducido m�s de una coma');
	              	objeto.focus();
	              	return false;
	            	}
	          	}
	          	else{
	            	alert('Error en el dato '+checkString+', ha introducido un valor num�rico incorrecto');
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
	      	}
	      	else {
	        	// RETURN ORIGINAL STRING
	        	objeto.focus();
	        	return false;
	      	}
	    	}
	    	else{
	      	return true;
	    	}
			}



			/*
	    	funcion copiada de general.js checkNumber
	    	esta funcion no admite nulos  '' or '0'
			*/

			function checkNumberNulo(checkString,objeto){

	    	var valorDeRetormo;

	    	checkString=String(checkString);
	    	newString = "";
	    	coma=0;
	    	punto=0;


	    	if(checkString==''){
	      	valorDeRetormo=false;

	      	return false;
	    	}

	    	for (var i = 0; i < checkString.length; i++){
	      	ch = checkString.substring(i, i+1);
	      	if (ch >= "0" && ch <= "9"){
	        	newString += ch;
	      	}
	      	else{
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
	            	}
	            	else{
	              	alert('Error en el dato '+checkString+', ha introducido m�s de una coma');
	              	objeto.focus();
	              	valorDeRetormo=false;

	              	return valorDeRetormo;
	            	}
	          	}
	          	else{
	            	alert('Error en el dato '+checkString+', ha introducido un valor num�rico incorrecto');
	            	objeto.focus();
	            	valorDeRetormo=false;

	            	return valorDeRetormo;
	          	}
	        	}
	      	}
	    	}

	    	if(parseFloat(reemplazaComaPorPunto(checkString))==0){
	      	alert('Error en el dato, ha introducido un valor nulo');
	      	objeto.focus();
	      	valorDeRetormo=false;

	      	return valorDeRetormo;
	    	}


	    	if (punto>0){
	      	// VERIFY WITH USER THAT IT IS OKAY TO REMOVE INVALID CHARACTERS
	      	newStringFormateado=FormateaVis(newString);
	      	if (confirm("El valor numerico "+checkString+" que ha introducido\ncontiene puntuacion en los miles.\nEste formato no es correcto,\ndesea cambiarlo por "+newStringFormateado+"?")) {
	        	objeto.value=newStringFormateado;
	        	valorDeRetormo=true;

	          return valorDeRetormo;
	      	}
	      	else {
	        	// RETURN ORIGINAL STRING
	        	objeto.focus();
            valorDeRetormo=false;
	        	return valorDeRetormo;
	      	}
	    	}
	    	else{
	      	valorDeRetormo=true;
	      	return valorDeRetormo;
	    	}
			}




			function Actua_Check_Number(formu,accion){

	  		if (porDefinir==1){
	      	alert(']]></xsl:text><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0670' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes"><![CDATA[');
	  		}
	  		else{
	    		formu.elements['MO_DESCUENTOGENERAL'].value=quitaPuntos(formu.elements['MO_DESCUENTOGENERAL'].value);
	    		formu.elements['MO_COSTELOGISTICA'].value=quitaPuntos(formu.elements['MO_COSTELOGISTICA'].value);
	    		formu.elements['MO_IMPORTEIVA'].value=quitaPuntos(formu.elements['MO_IMPORTEIVA'].value);
	    		formu.elements['IMPORTE_FINAL_PEDIDO'].value=quitaPuntos(formu.elements['IMPORTE_FINAL_PEDIDO'].value);

	    		if (checkNumber(formu.elements['MO_DESCUENTOGENERAL'].value,formu.elements['MO_DESCUENTOGENERAL']) && checkNumber(formu.elements['MO_COSTELOGISTICA'].value,formu.elements['MO_COSTELOGISTICA']) && checkNumberconSigno(formu.elements['MO_IMPORTEIVA'].value,formu.elements['MO_IMPORTEIVA']) && checkNumberconSigno(formu.elements['IMPORTE_FINAL_PEDIDO'].value,formu.elements['IMPORTE_FINAL_PEDIDO'])){
	      		if (ValidaDescuento()==true){
	        		agrupaArrayIVA(formu,'IVA','LISTAIVAPRODUCTOS');

							// #sustituye#
	        		formu.elements['MO_DESCUENTOGENERAL'].value = AntiformateaVis(formu.elements['MO_DESCUENTOGENERAL'].value);
	        		formu.elements['MO_COSTELOGISTICA'].value = AntiformateaVis(formu.elements['MO_COSTELOGISTICA'].value);
	        		formu.elements['MO_IMPORTEIVA'].value = AntiformateaVisConSigno(formu.elements['MO_IMPORTEIVA'].value);
	        		formu.elements['IMPORTE_FINAL_PEDIDO'].value = AntiformateaVisConSigno(formu.elements['IMPORTE_FINAL_PEDIDO'].value);

	        		formu.elements['STRING_PRECIOS'].value = ConstruirString(formu,'NuevoPrecio_');

	        		AsignarAccion(formu,accion);
	        		formu.elements['MO_IMPORTEIVA'].disabled=false;
	        		//mostrarCamposForm(formu);
	        		//DeshabilitarBotones(document);
	        		SubmitForm(formu,document);
	      		}
	    		}
	  		}
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



      ///////// Nuevas funciones. autor Olivier JEAN 06/2001 //////////////
      ///////////////////////////////////////////////////////////////////

      //Copiar la zona de texto NMU_COMENTARIOS del form comentarios en el campo hidden NMU_COMENTARIOS del form1
      function comentariosToForm1(formOrigen, formDestino,elemento) {
      	formDestino.elements[elemento].value=formOrigen.elements[elemento].value;
      }

      //
      // Se llama desde el estado 10 en el cual se puede introducir una nueva FECHANO_ENTREGA
      //


      //
      // estas 2 funciones se llaman desde el estado 7 en el cual podemos cambiar CANTIDADES.
      // Recalculo el importe, el subtotal y al final llamo a calculoConDescuento()
      //
      function Cantidad2Importe(formu,lmo_id,lmo_idproducto){

      	var cant,precio,resultado;

	      /*
	      	nacho
	        28/11/2001
	        validacion de que los campos cant y precio no sean null
	        si no se produce un error de NaN

	      */

	      if(tieneComa(formu.elements['NuevoPrecio_'+lmo_id].value))
	      	precio=desformateaDivisa(formu.elements['NuevoPrecio_'+lmo_id].value);
	      else
	      	if(tienePunto(formu.elements['NuevoPrecio_'+lmo_id].value))
	        	precio='';
	        else
	        	precio=formu.elements['NuevoPrecio_'+lmo_id].value;


	     	if(isNaN(precio) || precio=='' || precio==0){
	      	formu.elements['NuevoPrecio_'+lmo_id].value='Por definir';
	       	formu.elements['IMPORTE'+lmo_idproducto].value='';
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


	      formu.elements['NuevoImporte_'+lmo_id].value=anyadirCerosDecimales(formateaDivisa(Round(resultado,Divisas[obtenerIdDivisa(formu,'IDDIVISA')][3])),4);

	      formu.elements['IMPORTE'+lmo_idproducto].value=resultado;


	      CalculaSubtotal(formu);

	      calculoConDescuento();
	      formu.elements['MO_DESCUENTOGENERAL'].value=Antiformatea(formu.elements['MO_DESCUENTOGENERAL'].value);

      }


			function realizarCalculos(valor,obj,form,LMO_ID,LMO_IDPRODUCTO,posicionesDecimales){
      	valor=anyadirCerosDecimales(reemplazaPuntoPorComa(Round(desformateaDivisa(valor),posicionesDecimales)),posicionesDecimales);
        Cantidad2Importe(form,LMO_ID,LMO_IDPRODUCTO);
        quitaPuntosObj(obj);

        return valor;
      }

      function  realizarCalculosPorDefinir(valor,LMO_ID,LMO_IDPRODUCTO,form){
      	form.elements['NuevoImporte_'+LMO_ID].value='Por definir';
        Cantidad2Importe(form,LMO_ID,LMO_IDPRODUCTO);
        CalculaSubtotal(form);
        calculoConDescuento();

        return valor;
      }

      function realizarCalculosCosteLogistica(valor, decimalesRedondeo, decimalesPresentacion,form,nombreObj){

      	valor=anyadirCerosDecimales(reemplazaPuntoPorComa(Round(desformateaDivisa(valor),decimalesRedondeo)),decimalesPresentacion);
        calculoConDescuento(form,nombreObj);

        return valor;
      }

      function inicializarImportes(form){
      	form.elements['MO_SUBTOTAL'].value=anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(form.elements['MO_SUBTOTAL'].value),2)),2);
        form.elements['MO_COSTELOGISTICA'].value=anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(form.elements['MO_COSTELOGISTICA'].value),2)),2);
        form.elements['MO_IMPORTEIVA'].value=anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(form.elements['MO_IMPORTEIVA'].value),2)),2);
        form.elements['IMPORTE_FINAL_PEDIDO'].value=anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(form.elements['IMPORTE_FINAL_PEDIDO'].value),2)),2);
      }

      function esEnteroPositivo(valor,obj){
      	var msgValorEntero='Introduzca un valor de descuento correcto en %';
        if(esEntero(valor)){
        	if(valor>=0 && valor<=100 && !esNulo(valor)){
          	return true;
          }
          else{
          	alert(msgValorEntero);
          	obj.focus();
          	return false;
          }
        }
        else{
        	alert(msgValorEntero);
          obj.focus();
          return false;
        }
      }

      function CalculaSubtotal(formu){

      	var sum=parseFloat(0);
        var cantidadSinFormato;
        var estaPorDefinir=0;

        for(i=0;i<formu.length;i++){
        	if (formu.elements[i].name.substring(0,13)=='NuevoImporte_'){
          	if(formu.elements[i].value!='Por definir'){
            	cantidadSinFormato=desformateaDivisa(formu.elements[i].value);
              sum=sum+parseFloat(cantidadSinFormato);
            }
            else{
            	estaPorDefinir=1;
            }
          }
        }

        if(!estaPorDefinir)
        	formu.elements['MO_SUBTOTAL'].value=anyadirCerosDecimales(formateaDivisa(Round(sum,2)),2);
        else
        	formu.elements['MO_SUBTOTAL'].value='Por definir';
        }


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

            if(estado==10)
            	Actua(document.forms['anadir'],'MultiofertaSave.xsql?BOTON=ENVIAR');
          }
        }


				// Asignamos la funci�n handleKeyPress al evento
				if(navigator.appName.match('Microsoft')==false)
	  			document.captureEvents();
				document.onkeypress = handleKeyPress;



				function ultimosComentarios(nombreObjeto,nombreForm,tipoComentario){

      		var accion='CONSULTAR';
      		MostrarPagPersonalizada('http://www.newco.dev.br/Compras/NuevaMultioferta/UltimosComentarios.xsql?NOMBRE_OBJETO='+nombreObjeto+'&NOMBRE_FORM='+nombreForm+'&ACCION='+accion+'&TIPO='+tipoComentario+'&COMENTARIO='+document.forms[nombreForm].elements[nombreObjeto].value.replace(/\n/g,'\\\\n'),'comentarios',45,50,-80,-55);
    		}

    		function copiarComentarios(nombreForm,nombreObjeto,texto){
      		if(quitarEspacios(document.forms[nombreForm].elements[nombreObjeto].value)!=''){
        		document.forms[nombreForm].elements[nombreObjeto].value+='\n\n';
      		}
      		document.forms[nombreForm].elements[nombreObjeto].value+=texto;
      		comentariosToForm1(document.forms['comentarios'], document.forms['form1'],'NMU_COMENTARIOS');
    		}



    		//function ultimosComentarios(mo_id,nombreObjeto,nombreForm){
    		//  MostrarPag('http://www.newco.dev.br/Compras/NuevaMultioferta/UltimosComentarios.xsql?MO_ID='+mo_id+'&NOMBRE_OBJETO='+nombreObjeto+'&NOMBRE_FORM='+nombreForm,'comentarios');
    		//}

    		//function copiarComentarios(nombreForm,mo_id,nombreObjeto,texto){
    		//  document.forms[nombreForm].elements[nombreObjeto].value=texto;
    		//  comentariosToForm1(document.forms['comentarios'], document.forms['form1'],'NMU_COMENTARIOS');
    		//}



			//-->
		</script>

  </xsl:template>


  <!-- T E M P L A T E S   O N L O A D -->


  <!-- onload 6 -->

  <xsl:template name="onload-6">

  	<xsl:attribute name="onLoad">inicializarImportes(document.forms['form1']);initPorDefinir();CalculaSubtotal(document.forms['form1']);calculoConDescuento();</xsl:attribute>

  </xsl:template>


  <!-- T E M P L A T E S   B O D Y -->

  <!-- body 6 -->

  <xsl:template name="body-6">



	</xsl:template>

</xsl:stylesheet>
