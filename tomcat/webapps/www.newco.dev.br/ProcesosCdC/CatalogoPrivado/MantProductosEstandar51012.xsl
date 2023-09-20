<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:template match="/">
  
  
  
<html>
  <head>
   <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
      <!--idioma fin-->


    <title><xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_productos_estandar']/node()"/></title>
     <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
     
    <xsl:text disable-output-escaping="yes"><![CDATA[
    <script language="javascript">
      <!--
     
        var msgSubfamilia='Debe seleccionar una familia para el nuevo Producto Estándar';
        var msgReferenciaProductoEstandar='Debe introducir una referencia para el nuevo Producto Estándar';
        var msgNombreProductoEstandar='Debe introducir un nombre para el nuevo Producto Estándar';
        var msgUnidadBasicaProductoEstandar='Debe introducir la unidad básica para el nuevo Producto Estándar';
        var msgMismaReferencia='Debe introducir una referencia diferente para el nuevo Producto Estándar';
        var msgReferenciaEstrictaProductoEstandar='La referencia del producto estandar no es correcta. introduzca una con el formato siguiente: ';
        var msgSinDerechosParaCopiar='No tiene derechos suficientes para crear nuevos productos estandar. Por favor, pongase en contacto con MedicalVM';
        
        var msgPrecioReferenciaInventado='El precio de referencia está marcado como NO BASADO EN LOS HISTÓRICOS pero no se ha introducido ningún valor.\nPor favor, introduzca uno o desmarque la casilla correspondiente.';
        
        var msgRestaurarNombre='¿Desea restaurar el nombre del producto?';
        
        var msgMismoNombre='Debe introducir un nombre diferente para el nuevo Producto Estándar';
        
      	var msgMismaRefGuardar = 'Debe introducir una referencia diferente para el nuevo Producto Estándar\nPara cambiar la descripción estándar sin crear una nueva referencia estándar contacte con el equipo técnico de MedicalVM.';
        var msgMismaRefCopiar = 'Para crear un nuevo producto estándar por favor asigne una nueva referencia.';
 

      
      ]]></xsl:text>
				var catpriv_estricto='<xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/CATPRIV_ESTRICTO"/>';
      <xsl:text disable-output-escaping="yes"><![CDATA[
      
      
      var arrTodasSubfamilias=new Array();     
      
      
      ]]></xsl:text>
      
        <xsl:for-each select ="/Mantenimiento/PRODUCTOESTANDAR/TODASSUBFAMILIAS/FAMILIA">
          var arrayFamilia=new Array();
          arrayFamilia[arrayFamilia.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="listItem2"/>');
          <xsl:for-each select ="SUBFAMILIA">
            arrayFamilia[arrayFamilia.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="listItem"/>','<xsl:value-of select="listItem2"/>','<xsl:value-of select="SIGUIENTE"/>');
          </xsl:for-each> 
          arrTodasSubfamilias[arrTodasSubfamilias.length]=arrayFamilia;
        </xsl:for-each>  
      
      
      <xsl:text disable-output-escaping="yes"><![CDATA[
     
     
     
      function ValidarFormulario(form){
        
        var errores=0;
       
        /* quitamos los espacios sobrantes  */
        
        for(var n=0;n<form.length;n++){
          if(form.elements[n].type=='text'){
            form.elements[n].value=quitarEspacios(form.elements[n].value);
          }
        }
        
        if((!errores) && (esNulo(form.elements['CATPRIV_IDSUBFAMILIA'].value))){
          errores++;
          alert(document.forms['MensajeJS'].elements['OBLI_FAMILIA_PROD_ESTANDAR'].value);
          document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].focus();
        }
        
        if((!errores) && (esNulo(form.elements['CATPRIV_REFERENCIA'].value))){
          errores++;
          alert(document.forms['MensajeJS'].elements['OBLI_REF_PROD_ESTANDAR'].value);
          document.forms[0].elements['CATPRIV_REFERENCIA'].focus();
        }
        // miramos que si el catalogo es estricto, la referencia lo sea, esto es, ref=ref_fam+ref_subfam+2 o mas digitos
		// 9abr10 permitimos una letra
		/* 2may12 el catalogo MVM, igual que el de ASISA, ya no es "estricto"
        else{
        	if(catpriv_estricto=='S'){
        		if(!esReferenciaEstricta(document.forms[0])){
        			errores++;
        			alert(document.forms['MensajeJS'].elements['REF_NO_CORRECTA'].value + montarReferenciaEstricta(document.forms[0])+'XXL');
        			document.forms[0].elements['CATPRIV_REFERENCIA'].focus();
        		}
        	}
        }
        */
        if((!errores && esNulo(form.elements['CATPRIV_NOMBRE'].value))){
          errores++;
          alert(document.forms['MensajeJS'].elements['OBLI_NOMBRE_PROD_ESTANDAR'].value);
          document.forms[0].elements['CATPRIV_NOMBRE'].focus();
        }
        
        /*
        if((!errores) && (esNulo(form.elements['CATPRIV_UDBASE'].value))){
          errores++;
          alert(document.forms['MensajeJS'].elements['OBLI_UN_BASICA_PROD_ESTANDAR'].value);
          document.forms[0].elements['CATPRIV_UDBASE'].focus();
        }
        */
        
        /*if((!errores) && (!esNulo(form.elements['CATPRIV_PRECIOREFERENCIA'].value))){
          if(!ValidarNumero(form.elements['CATPRIV_PRECIOREFERENCIA'],4)){
            errores++;
            form.elements['CATPRIV_PRECIOREFERENCIA'].focus();
          }
          else{
            form.elements['CATPRIV_PRECIOREFERENCIA'].value=reemplazaComaPorPunto(form.elements['CATPRIV_PRECIOREFERENCIA'].value);
          }
        }*/
        
        
        
        /*if((!errores) && (form.elements['CATPRIV_PRECIOREFERENCIA_INVENTADO'].checked==true)){
          if(esNulo(form.elements['CATPRIV_PRECIOREFERENCIA'].value)){
            errores++;
            alert(document.forms['MensajeJS'].elements['OBLI_PRECIO_REF_PROD_ESTANDAR'].value +'\n'+ document.forms['MensajeJS'].elements['OBLI_PRECIO_REF_PROD_ESTANDAR1'].value);
            form.elements['CATPRIV_PRECIOREFERENCIA_INVENTADO'].focus();
          }
        }*/
        
        
        /*if((!errores) && (!esNulo(form.elements['CATPRIV_CONSUMOESTIMADO'].value))){
          if(!ValidarNumero(form.elements['CATPRIV_CONSUMOESTIMADO'],4)){
            errores++;
            form.elements['CATPRIV_CONSUMOESTIMADO'].focus();
          }
           else{
             form.elements['CATPRIV_CONSUMOESTIMADO'].value=reemplazaComaPorPunto(form.elements['CATPRIV_CONSUMOESTIMADO'].value);
           }
        }*/
        
         //31/10/11 si cambia nombre prod debe cambiar tb la referencia si no nada cambio
         //quitado control 22/11/11
         
          var nuevaReferencia=quitarEspacios(form.elements['CATPRIV_REFERENCIA'].value.toUpperCase());
          var ReferenciaOriginal=quitarEspacios(form.elements['REFERENCIAORIGINAL'].value.toUpperCase());
          
          var nuevoNombre=quitarEspacios(form.elements['CATPRIV_NOMBRE'].value.toUpperCase());
          var NombreOriginal=quitarEspacios(form.elements['NOMBREORIGINAL'].value.toUpperCase());
          
		   
           /*if ((!errores) && nuevoNombre != NombreOriginal){
			  if (nuevaReferencia == ReferenciaOriginal){
				 alert(document.forms['MensajeJS'].elements['OBLI_REF_DIFERENTE'].value +'\n'+ document.forms['MensajeJS'].elements['OBLI_REF_DIFERENTE1'].value);
                  errores++;
			  }
		   }*/
           //fin control cambio ref cambio nombre
        
        
            /* si los datos son correctos enviamos el form  */
        if(!errores){
          EnviarCambios(form)
        }
          
        
      }
        
	//9abr10	 permitimos hasta 9 caracteres
	function esReferenciaEstricta(form)
	{

		//alert('Referencia:'+form.elements['CATPRIV_REFERENCIA'].value+' length'+form.elements['CATPRIV_REFERENCIA'].value.length+ ' ref estricta:'+montarReferenciaEstricta(form));

    	if(form.elements['CATPRIV_REFERENCIA'].value.substring(0,montarReferenciaEstricta(form).length)==montarReferenciaEstricta(form) 
			&& ((form.elements['CATPRIV_REFERENCIA'].value.length==8) || (form.elements['CATPRIV_REFERENCIA'].value.length==9)))
		{
        	return 1;
    	}
    	else
		{
    		return 0;
    	}
	}
        
        function montarReferenciaEstricta(form){
        
        	// buscamos la ref de familia y de subfamilia
        	var encontrado=0;
        	var refFamilia='';
        	var refSubfamilia='';
        	for(var n=0;n<arrTodasSubfamilias.length && !encontrado;n++){
          	var arrFamilia=arrTodasSubfamilias[n][0];
            if(arrFamilia[0]==form.elements['CATPRIV_IDFAMILIA'].value){
            	refFamilia=arrFamilia[1];
            	for(var i=1;i<arrTodasSubfamilias[n].length;i++){
            		var arrSubfamilia=arrTodasSubfamilias[n][i];
            		if(arrSubfamilia[0]==form.elements['CATPRIV_IDSUBFAMILIA'].value){
            			var refSubfamilia=arrSubfamilia[2];
            			encontrado=1;
            		}
            	}
            }
          }
        	return refFamilia+refSubfamilia;

        }
        
        
        
        function EnviarCambios(form){
        		SubmitForm(form);
        }
        
        function ValidarNumero(obj,decimales){
          
          if(checkNumberNulo(obj.value,obj)){
            if(parseFloat(reemplazaComaPorPunto(obj.value))!=0){
              obj.value=anyadirCerosDecimales(reemplazaPuntoPorComa(Round(reemplazaComaPorPunto(obj.value),decimales)),decimales);
            }
          return true;
          }
          return false;
        }
        		
        function CopiarProducto(form,accion){
        	
          var nuevaReferencia=quitarEspacios(form.elements['CATPRIV_REFERENCIA'].value.toUpperCase());
          var ReferenciaOriginal=quitarEspacios(form.elements['REFERENCIAORIGINAL'].value.toUpperCase());
          
          var nuevoNombre=quitarEspacios(form.elements['CATPRIV_NOMBRE'].value.toUpperCase());
          var NombreOriginal=quitarEspacios(form.elements['NOMBREORIGINAL'].value.toUpperCase());
          
          
           //31/10/11 si cambia nombre prod debe cambiar tb la referencia si no nada cambio
		   //quitado control 22/11/11
           
           /*if (nuevoNombre != NombreOriginal){
			  if (nuevaReferencia == ReferenciaOriginal){
				 alert(document.forms['MensajeJS'].elements['NUEVO_PRODUCTO_NUEVA_REF'].value);
                 return;
			  }
		   }*/
           //fin control cambio ref cambio nombre
          
          
          if(nuevaReferencia==ReferenciaOriginal){
          
          	if(form.elements['CATPRIV_REFERENCIA'].type=='hidden'){
          		alert(document.forms['MensajeJS'].elements['NO_DERECHOS_PARA_CREAR'].value);
          	}
          	else{
          		alert(document.forms['MensajeJS'].elements['REF_DIFERENTE_PROD_ESTANDAR'].value);
          		return;
          	}
          }
          else{
          
			//	2may12	Permitimos de forma natural referencias con letras
            /*if(catpriv_estricto=='S')
			{
      			if(!esReferenciaEstricta(document.forms[0]))
					{
        				alert(document.forms['MensajeJS'].elements['REF_NO_CORRECTA'].value +montarReferenciaEstricta(document.forms[0])+'xx');
        				document.forms[0].elements['CATPRIV_REFERENCIA'].focus();
        				return;
        			}
					
        			else{
        				form.elements['ACCION'].value=accion;
            		ValidarFormulario(form);
        			}
        	}
        	else{
        		form.elements['ACCION'].value=accion;
            ValidarFormulario(form);
        	}
		  */
		  /*	14abr10	Permitimos repetir nombre
          	if(nuevoNombre==NombreOriginal){
          	alert(document.forms['MensajeJS'].elements['OBLI_NOMBRE_DIFFERENTE'].value);
          	document.forms[0].elements['CATPRIV_NOMBRE'].focus();
          	return;
          }
          else{
		  */
          	form.elements['ACCION'].value=accion;
            ValidarFormulario(form);
          //}
          }
        }
        
        function CambioFamiliaActual(valor,accion){
    			
          var objName='CATPRIV_IDSUBFAMILIA';
          var encontrado=0;
          var arrSubfamilias=new Array();
          for(var n=0;n<arrTodasSubfamilias.length && !encontrado;n++){
          	var arrFamilia=arrTodasSubfamilias[n][0];
          	//alert(arrFamilia);
            if(arrFamilia[0]==valor){
               encontrado=1;
               arrSubfamilias=arrTodasSubfamilias[n];
            }
          }
          
          document.forms['form1'].elements['IDFAMILIA'].value=document.forms['form1'].elements['CATPRIV_IDFAMILIA'].value;
          
          document.forms['form1'].elements[objName].length=0;
          
          for(var n=1;n<arrSubfamilias.length;n++){
            var id=arrSubfamilias[n][0];  
            var elemento=arrSubfamilias[n][1];  
            
            var addOption=new Option(elemento,id);
            document.forms['form1'].elements[objName]
            document.forms['form1'].elements[objName].options[document.forms['form1'].elements[objName].length]=addOption;
          }
        }
		
        
        function restaurarNombre(objTexto,valor,objPadre){
          if(confirm(document.forms['MensajeJS'].elements['RESTAURAR_NOMBRE_PRODUCTO'].value+'\n\n'+ document.forms['MensajeJS'].elements['NOMBRE_ACTUAL'].value+' : '+objTexto.value+'\n '+ document.forms['MensajeJS'].elements['NUEVO_NOMBRE'].value +': '+valor)){
            objTexto.value=valor;
            objPadre.value='S';
          }
        }
        
        function debugando(form){
        	var id_1=form.elements['CATPRIV_IDFAMILIA'].value;
        	var id_2=form.elements['CATPRIV_IDSUBFAMILIA'].value;
        	if(confirm('idfamilia: '+id_1+' idsubfamilia: '+id_2+' ¿Enviamos los datos?')){
        		return 1;
        	}
        	else{
        		return 0;
        	}
        }
        
        function CambioFamiliaActualInicio(form,valor,accion)
		{
			seleccionarValor(form.elements['CATPRIV_IDFAMILIA'],document.forms['form1'].elements['IDFAMILIA'].value);
        	if(form.elements['CATPRIV_IDSUBFAMILIA'].type=='select-one'){
        		CambioFamiliaActual(valor,accion);
        		seleccionarValor(form.elements['CATPRIV_IDSUBFAMILIA'],document.forms['form1'].elements['IDSUBFAMILIA'].value);
        	}
		  
			//	2may12	Informamos la ref. estándar por defecto
			actualizarValorPorDefectoEnElArray(valor,accion);
        }
        
        function seleccionarValor(elemento,valor){
        	
        	var valorSeleccionado=0;
        	
        	if(elemento.type=='select-one'){
        		for(var n=0;n<elemento.options.length;n++){
        			if(elemento.options[n].value==valor){
        				valorSeleccionado=n;
        			}
        		}
        		elemento.selectedIndex=valorSeleccionado;
        	}
        }
        
        
        // !!!!!! IMPORTANTE  ¡¡¡¡¡¡¡
        // Mantenemos el nombre de la funcion porque se usa en otras paginas a pesar de que no hace referencia 
        // a su nombre
        //	2may12	Para nuevos productos estándar buscamos el valor por defecto de la ref. estándar
        function actualizarValorPorDefectoEnElArray(valor,accion)
		{
			if (document.forms['form1'].elements['ACCION'].value=='NUEVOPRODUCTOESTANDAR')
			{
        		// buscamos la ref de familia y de subfamilia
        		var encontrado=0;
        		var refFamilia='';
        		var refSubfamilia='';
        		for(var n=0;n<arrTodasSubfamilias.length && !encontrado;n++)
				{
          			var arrFamilia=arrTodasSubfamilias[n][0];
            		if(arrFamilia[0]==document.forms['form1'].elements['CATPRIV_IDFAMILIA'].value)
					{
            			refFamilia=arrFamilia[1];
            			for(var i=1;i<arrTodasSubfamilias[n].length;i++)
						{
            				var arrSubfamilia=arrTodasSubfamilias[n][i];
            				if(arrSubfamilia[0]==document.forms['form1'].elements['CATPRIV_IDSUBFAMILIA'].value)
							{
								document.forms['form1'].elements['CATPRIV_REFERENCIA'].value=arrSubfamilia[3];
            					encontrado=1;
            				}
            			}
            		}
				}
			}
        }
 
 
 		
		//	25jun12	Guardar el propducto estándar completo, incluyendo hijos e históricos
        function GuardarProducto(form, accion)
		{
			form.elements['ACCION'].value=accion;
			ValidarFormulario(form);
        }
 
 		
		//	25jun12	Mueve el producto estándar completo, incluyendo hijos e históricos
        function MoverProducto(form)
		{
			form.elements['ACCION'].value='MOVER';
			
			if (form.elements['MOVERAREFESTANDAR'].value=='')
				alert(document.forms['MensajeJS'].elements['MOVER_REF_ERROR'].value);
			else
				ValidarFormulario(form);
			
        }
         

	function EjecutarFuncionDelFrame(nombreFrame,nombreFuncion)
	{
	    var objFrame=new Object();
	  	objFrame=obtenerFrame(top, nombreFrame);

		if(objFrame!=null){		

			var retorno=eval('objFrame.'+nombreFuncion);
			if(retorno!=undefined){
				return retorno;
			}
		}
	}
           
	function RecargarInfoCatalogo()
	{
		EjecutarFuncionDelFrame('zonaCatalogo','CambioProductoEstandarActual(document.forms[\'form1\'].elements[\'CATPRIV_ID\'].value,\'CAMBIOPRODUCTOESTANDAR\');');
	}
       
        
      //-->
    </script>
    ]]></xsl:text>
  </head>
  <body class="gris">
<xsl:choose>
  <xsl:when test="//SESION_CADUCADA">
    <xsl:apply-templates select="//SESION_CADUCADA"/> 
  </xsl:when>
  <xsl:when test="//Sorry">
    <xsl:apply-templates select="//Sorry"/> 
  </xsl:when>

  <xsl:otherwise>
  	<xsl:if test="Mantenimiento/TIPO!='CONSULTA'">
  		<xsl:attribute name="onLoad">CambioFamiliaActualInicio(document.forms['form1'],document.forms['form1'].elements['CATPRIV_IDFAMILIA'].value,'<xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/SUBFAMILIAS/field/@current"/>','CAMBIOFAMILIA');</xsl:attribute>
  	</xsl:if>
    <xsl:if test="Mantenimiento/PRODUCTOESTANDAR/MENSAJE = 'OK'">
  		<xsl:attribute name="onLoad">RecargarInfoCatalogo();</xsl:attribute>
    </xsl:if>
    <form name="form1" action="MantProductosEstandarSave.xsql" method="post">
    
    <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
      <!--idioma fin-->


     <h1 class="titlePage">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_productos_estandar']/node()"/>
		<xsl:if test="/Mantenimiento/PRODUCTOESTANDAR/MENSAJE">
			:&nbsp;
       		<xsl:choose>
            	<xsl:when test="/Mantenimiento/PRODUCTOESTANDAR/MENSAJE='OK'">Los cambios se han guardado correctamente.</xsl:when>
            	<xsl:otherwise><xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/MENSAJE"/></xsl:otherwise>
            </xsl:choose>&nbsp;
			(<xsl:value-of select="/Mantenimiento/PRODUCTOESTANDAR/FECHA"/>)
		</xsl:if>
     </h1>
		<input type="hidden" name="CATPRIV_IDUSUARIO" VALUE="{Mantenimiento/US_ID}"/>
      <input type="hidden" name="CATPRIV_IDEMPRESA" VALUE="{Mantenimiento/CATPRIV_IDEMPRESA}"/>
      <input type="hidden" name="CATPRIV_ID" VALUE="{Mantenimiento/PRODUCTOESTANDAR/ID}"/>
      <input type="hidden" name="CATPRIV_IDDIVISA" VALUE="{Mantenimiento/PRODUCTOESTANDAR/IDDIVISA}"/>
      <input type="hidden" name="ACCION" VALUE="{Mantenimiento/ACCION}"/>
      <input type="hidden" name="VENTANA" VALUE="{Mantenimiento/VENTANA}"/>
      <input type="hidden" name="REFERENCIAORIGINAL" VALUE="{Mantenimiento/PRODUCTOESTANDAR/REFERENCIA}"/>
      <input type="hidden" name="NOMBREORIGINAL" VALUE="{Mantenimiento/PRODUCTOESTANDAR/NOMBRE}"/>
      <input type="hidden" name="IDFAMILIA" VALUE="{Mantenimiento/PRODUCTOESTANDAR/FAMILIAS/field/@current}"/>
      <input type="hidden" name="IDSUBFAMILIA" VALUE="{Mantenimiento/PRODUCTOESTANDAR/SUBFAMILIAS/field/@current}"/>
   <table class="mediaTabla">
     <thead>
  	 <tr class="sombra">
      	 <td>&nbsp;</td>
      	 <td colspan="2">&nbsp;</td>
         <td>&nbsp;</td>
     </tr> 
     </thead>
     <tr>
      <td>&nbsp;</td>
   		<td class="label trentacinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_alta']/node()"/>:
        </td>
    	<td class="sesanta">
    	<strong><xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/FECHAALTA"/></strong>
        </td>
       <td>&nbsp;</td>
	</tr>
    <tr>
      <td>&nbsp;</td>
   		<td class="label trentacinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='familia_de_productos']/node()"/>:&nbsp;<span class="camposObligatorios">*</span>
        </td>
    	<td class="sesanta">
    	  <xsl:choose>
              <!-- SOLO CONSULTA -->
                <xsl:when test="Mantenimiento/TIPO='CONSULTA'">
                  <xsl:for-each select="Mantenimiento/PRODUCTOESTANDAR/FAMILIAS/field/dropDownList/listElem">
                    <xsl:if test="ID=../../@current">
                      <xsl:value-of select="listItem"/>
                    </xsl:if>
                  </xsl:for-each>
                </xsl:when>
                <!-- MODIFICACION -->
                <xsl:otherwise>
                  <xsl:choose>
                    <!-- USUARIO MASTER_UNICO, PUEDE HACER CUALQUIER TIPO DE EDICION -->
                    <xsl:when test="Mantenimiento/PRODUCTOESTANDAR/MASTER_UNICO">
                      <xsl:call-template name="desplegable">
                        <xsl:with-param name="path" select="Mantenimiento/PRODUCTOESTANDAR/FAMILIAS/field"></xsl:with-param>
            	      </xsl:call-template>
            	    </xsl:when>
            	    <!-- PUEDE CREAR NUEVOS O MODIFICAR EL NOMBRE Y DATOS DE CONSUMO -->
            	    <xsl:when test="Mantenimiento/PRODUCTOESTANDAR/MASTER">
                      <!-- NUEVO -->
                      <xsl:choose>
                        <xsl:when test="Mantenimiento/PRODUCTOESTANDAR/ID='0'">
                          <xsl:call-template name="desplegable">
                            <xsl:with-param name="path" select="Mantenimiento/PRODUCTOESTANDAR/FAMILIAS/field"></xsl:with-param>
            	          </xsl:call-template>
            	        </xsl:when>
            	        <!-- modificacion -->
            	        <xsl:otherwise>
            	            <xsl:call-template name="desplegable">
                            <xsl:with-param name="path" select="Mantenimiento/PRODUCTOESTANDAR/FAMILIAS/field"></xsl:with-param>
            	          </xsl:call-template>
            	          <!--<xsl:for-each select="Mantenimiento/PRODUCTOESTANDAR/FAMILIAS/field/dropDownList/listElem">
                            <xsl:if test="ID=../../@current">
                              <input type="hidden" name="CATPRIV_IDFAMILIA" value="{ID}"/>
                              <xsl:value-of select="listItem"/>
                            </xsl:if>
                          </xsl:for-each>-->
            	        </xsl:otherwise>
            	      </xsl:choose>
            	    </xsl:when>
            	    <!-- USUARIO EDICION, EDICIONES RESTRINGIDAS, SOLO EL NOMBRE Y DATOS DE CONSUMO -->
            	    <xsl:otherwise>
            	      <xsl:for-each select="Mantenimiento/PRODUCTOESTANDAR/FAMILIAS/field/dropDownList/listElem">
                        <xsl:if test="ID=../../@current">
                          <xsl:value-of select="listItem"/>
                          <input type="hidden" name="CATPRIV_IDFAMILIA" value="{ID}"/>
                        </xsl:if>
                      </xsl:for-each>
            	    </xsl:otherwise>
            	  </xsl:choose>
                </xsl:otherwise>
              </xsl:choose>
        </td>
       <td>&nbsp;</td>
	</tr>
    <tr>
    	<td>&nbsp;</td>
    	<td class="label trentacinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='subfamilia_de_productos']/node()"/>:&nbsp;<span class="camposObligatorios">*</span>
        </td>
    	<td class="sesanta">
         <xsl:choose>
            	<!-- CONSULTA -->
            	<xsl:when test="/Mantenimiento/TIPO='CONSULTA'">
            	  <xsl:for-each select="/Mantenimiento/PRODUCTOESTANDAR/SUBFAMILIAS/field/dropDownList/listElem">
                	<xsl:if test="ID=../../@current">
                	  <xsl:value-of select="listItem"/>
                	</xsl:if>
            	  </xsl:for-each>
            	</xsl:when>
            	<!-- MODIFICACION -->
            	<xsl:otherwise>
            	  <xsl:choose>
                	<!-- usuario master_unico, cualquier tipo de modificacion -->
                	<xsl:when test="/Mantenimiento/PRODUCTOESTANDAR/MASTER_UNICO">
                	  <xsl:call-template name="desplegable">
                    	<xsl:with-param name="path" select="/Mantenimiento/PRODUCTOESTANDAR/SUBFAMILIAS/field"></xsl:with-param>
                    	<!--<xsl:with-param name="sincontenido">SINCONTENIDO</xsl:with-param>-->
            		  </xsl:call-template>
            		</xsl:when>
            		<!-- usuario master, solo nuevos o modificaciones de nombre y datos de consumo -->
                	<xsl:when test="/Mantenimiento/PRODUCTOESTANDAR/MASTER">
                	  <!-- NUEVO -->
                	  <xsl:choose>
                    	<xsl:when test="/Mantenimiento/PRODUCTOESTANDAR/ID='0'">
                    	  <xsl:call-template name="desplegable">
                        	<xsl:with-param name="path" select="/Mantenimiento/PRODUCTOESTANDAR/SUBFAMILIAS/field"></xsl:with-param>
                        	<!--<xsl:with-param name="sincontenido">SINCONTENIDO</xsl:with-param>-->
            	    	  </xsl:call-template>
            	    	</xsl:when>
            	    	<!-- modificacion -->
            	    	<xsl:otherwise>
            	        	<xsl:call-template name="desplegable">
                        	<xsl:with-param name="path" select="/Mantenimiento/PRODUCTOESTANDAR/SUBFAMILIAS/field"></xsl:with-param>
                        	<!--<xsl:with-param name="sincontenido">SINCONTENIDO</xsl:with-param>-->
            	    	  </xsl:call-template>
            	    	</xsl:otherwise>
            		  </xsl:choose>
            		</xsl:when>
            		<!-- usuario edicion, modificaciones restringidas, solo nombre y datos de consumo -->
            		<xsl:otherwise>
            		  <xsl:for-each select="/Mantenimiento/PRODUCTOESTANDAR/SUBFAMILIAS/field/dropDownList/listElem">
                    	<xsl:if test="ID=../../@current">
                    	  <xsl:value-of select="listItem"/>
                    	  <input type="hidden" name="CATPRIV_IDSUBFAMILIA" value="{ID}"/>
                    	</xsl:if>
                	  </xsl:for-each>
            		</xsl:otherwise>
            	  </xsl:choose>
            	</xsl:otherwise>
        	  </xsl:choose>
        </td>
    	<td>&nbsp;</td>
    </tr>
    <tr>
    	<td>&nbsp;</td>
    	<td class="label trentacinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/>:&nbsp;<span class="camposObligatorios">*</span>
        </td>
    	<td class="sesanta">
         <xsl:choose>
                 <!--consulta -->
                <xsl:when test="Mantenimiento/TIPO='CONSULTA'">
                  <xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFERENCIA"/>
                </xsl:when>
                <!-- modificacion -->
                <xsl:otherwise>
                  <xsl:choose>
                    <!-- usuario master_unico, cualquier tipo de modificacion -->
                    <xsl:when test="Mantenimiento/PRODUCTOESTANDAR/MASTER_UNICO">
                      <input type="text" name="CATPRIV_REFERENCIA" value="{Mantenimiento/PRODUCTOESTANDAR/REFERENCIA}" size="30" maxlength="100"/>
                    </xsl:when>
                    <!-- usuario master, solo nombre y datos de consumos -->
                    <xsl:when test="Mantenimiento/PRODUCTOESTANDAR/MASTER">
                      <!-- NUEVO -->
                      <xsl:choose>
                        <xsl:when test="Mantenimiento/PRODUCTOESTANDAR/ID='0'">
                          <input type="text" name="CATPRIV_REFERENCIA" value="{Mantenimiento/PRODUCTOESTANDAR/REFERENCIA}" size="30" maxlength="100"/>
                          <xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/TODASSUBFAMILIAS/FAMILIA[@current = ID]/SUBFAMILIA[@current = ID]/SIGUIENTE"/>

            	        </xsl:when>
            	        <!-- modificacion -->
            	        <xsl:otherwise>

            	          <input type="text" name="CATPRIV_REFERENCIA" value="{Mantenimiento/PRODUCTOESTANDAR/REFERENCIA}" size="30" maxlength="100"/>
                          
            	        </xsl:otherwise>
            	      </xsl:choose>
                    </xsl:when>
                    <!-- usuario edicion, solo ediciones restringidas, nombre y datos de consumo -->
                    <xsl:otherwise>
                      <xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFERENCIA"/>
                      <input type="hidden" name="CATPRIV_REFERENCIA" value="{Mantenimiento/PRODUCTOESTANDAR/REFERENCIA}"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:otherwise>
              </xsl:choose>            
        </td>
        <td>&nbsp;</td>
    </tr>
      <tr>
    	<td>&nbsp;</td>
    	<td class="label trentacinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:&nbsp;<span class="camposObligatorios">*</span>
        </td>
    	<td class="sesanta">
         <xsl:choose>
                <!-- consulta -->
                <xsl:when test="Mantenimiento/TIPO='CONSULTA'">
                  <xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBRE"/>
                </xsl:when>
                <!-- edicion -->
                <xsl:otherwise>
                  <input type="text" name="CATPRIV_NOMBRE" value="{Mantenimiento/PRODUCTOESTANDAR/NOMBRE}" size="70" maxlength="300"/>
                  <!-- si es un producto que sigue un catpriv_de otra empresa
                       mostramos el boton de restaurtar nombre, en el caso de que se hubiera salido del catalogo -->
                  <xsl:if test="not(Mantenimiento/PRODUCTOESTANDAR/MASTER_UNICO) and not(Mantenimiento/PRODUCTOESTANDAR/MASTER)">
                    <xsl:if test="Mantenimiento/PRODUCTOESTANDAR/NOMBREPADRE='N'">

                      <input type="hidden" name="CATPRIV_PADRE" value="{Mantenimiento/PRODUCTOESTANDAR/NOMBREPADRE}"/>

                      <xsl:call-template name="botonPersonalizado">
                        <xsl:with-param name="funcion">restaurarNombre(document.forms['form1'].elements['CATPRIV_NOMBRE'],'<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBREPRODUCTO_PADRE"/>',document.forms['form1'].elements['CATPRIV_PADRE']);</xsl:with-param>
                        <xsl:with-param name="label">Restaurar Nombre</xsl:with-param>
                        <xsl:with-param name="status">Restaura el nombre del producto con el del catálogo que sigue</xsl:with-param>
                      </xsl:call-template>
                    </xsl:if>
                  </xsl:if>

                </xsl:otherwise>
              </xsl:choose>
        </td>
        <td>&nbsp;</td>
    </tr>
      <tr> 
    	<td>&nbsp;</td>
    	<td class="label trentacinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='completar_nombre']/node()"/>:&nbsp;<span class="camposObligatorios">*</span>
        </td>
    	<td class="sesanta">
         <xsl:choose>
                <!-- consulta -->
                <xsl:when test="Mantenimiento/TIPO='CONSULTA'">
                  <xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBRE_PRIVADO"/>
                </xsl:when>
                <!-- edicion -->
                <xsl:otherwise>
                  <input type="text" name="CATPRIV_NOMBRE_PRIVADO" value="{Mantenimiento/PRODUCTOESTANDAR/NOMBRE_PRIVADO}" size="70" maxlength="300"/>                          
                </xsl:otherwise>
              </xsl:choose>
			  &nbsp;(<xsl:value-of select="document($doc)/translation/texts/item[@name='particular']/node()"/>)
        </td>
        <td>&nbsp;</td>
    </tr>
     <tr>
      <td>&nbsp;</td>
      <td colspan="2">&nbsp;</td>
      <td>&nbsp;</td>
     </tr>      
     <tr>
     	<td>&nbsp;</td>
        <td colspan="2" style="text-align:center;">
          <xsl:value-of select="document($doc)/translation/texts/item[@name='los_campos_marcados_con']/node()"/> (<span class="camposObligatorios">*</span>) <xsl:value-of select="document($doc)/translation/texts/item[@name='son_obligatorios']/node()"/>.
        </td>
        <td>&nbsp;</td>
      </tr>
       <tfoot>
     <tr>
      <td>&nbsp;</td>
      <td colspan="2">&nbsp;</td>
      <td>&nbsp;</td>
     </tr>      
     </tfoot>  	
    </table>
     <table class="mediaTabla" border="0">
    
      <tr>
      <td class="quince">&nbsp;</td>
      
        <!-- edicion -->
          <td align="center" class="dies">&nbsp;</td>
          <!-- guardar cambios -->  
         <td align="center" class="veinte">
         <xsl:choose>
         <xsl:when test="Mantenimiento/ACCION= 'NUEVOPRODUCTOESTANDAR'">
            <div class="boton">
                <!--<a href="javascript:ValidarFormulario(document.forms[0]);"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>-->
                <a href="javascript:GuardarProducto(document.forms[0],'NUEVOPRODUCTOESTANDAR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
            </div>
          </xsl:when>
          <xsl:when test="Mantenimiento/ACCION= 'MODIFICARPRODUCTOESTANDAR' or Mantenimiento/ACCION= 'MODIFICAR'">
            <div class="boton">
                <!--<a href="javascript:ValidarFormulario(document.forms[0]);"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>-->
                <a href="javascript:GuardarProducto(document.forms[0],'MODIFICAR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
            </div>
          </xsl:when>
          </xsl:choose>
          </td>
          <!-- copiar producto -->
           <td align="center" class="dies">&nbsp;</td>

          <xsl:if test="Mantenimiento/ACCION='MODIFICAR' or Mantenimiento/ACCION='MOVER' or Mantenimiento/ACCION='MODIFICARPRODUCTOESTANDAR'">
          <!-- solo lo permitimos al usuario MASTER_UNICO o MASTER-->
                <td align="center">
                  <div class="boton">
                      <a href="javascript:CopiarProducto(document.forms[0],'MODIFICAR');">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='copiar']/node()"/>
                      </a>
                 </div>
                </td>

          </xsl:if>

                     
     </tr>
	 
       <!--solo si modifico veo mover-->
	 <xsl:if test="Mantenimiento/ACCION='MODIFICAR' or Mantenimiento/ACCION='MODIFICARPRODUCTOESTANDAR'">
         <xsl:if test="Mantenimiento/PRODUCTOESTANDAR/MASTER_UNICO or Mantenimiento/PRODUCTOESTANDAR/MASTER">
         <tr>
            <td colspan="7">&nbsp;</td>
         </tr>
          <tr>
            <td colspan="7">&nbsp;</td>
         </tr>
         <tr class="tituloGris">
            <td colspan="1">&nbsp;</td>
            <td colspan="2"><xsl:value-of select="document($doc)/translation/texts/item[@name='mover_ref_estandar_al_codigo']/node()"/>:</td>
            <td class="textRight"><input type="text" name="MOVERAREFESTANDAR" size="10"/>&nbsp;&nbsp;</td>
            <td colspan="3">
            <div class="boton">
              <a href="javascript:MoverProducto(document.forms[0]);">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='mover']/node()"/>
              </a>
            </div>
            </td>
         </tr>
         </xsl:if>
     </xsl:if>
    
    </table>
    
    </form>
    
    <!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>  
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>          <!--idioma fin-->
    <form name="MensajeJS">
		<input type="hidden" name="OBLI_FAMILIA_PROD_ESTANDAR" value="{document($doc)/translation/texts/item[@name='obli_familia_prod_estandar']/node()}"/>
		<input type="hidden" name="OBLI_REF_PROD_ESTANDAR" value="{document($doc)/translation/texts/item[@name='obli_ref_prod_estandar']/node()}"/>
		<input type="hidden" name="OBLI_NOMBRE_PROD_ESTANDAR" value="{document($doc)/translation/texts/item[@name='obli_nombre_prod_estandar']/node()}"/>
		<input type="hidden" name="OBLI_UN_BASICA_PROD_ESTANDAR" value="{document($doc)/translation/texts/item[@name='obli_un_basica_prod_estandar']/node()}"/>
		<input type="hidden" name="REF_DIFERENTE_PROD_ESTANDAR" value="{document($doc)/translation/texts/item[@name='ref_diferente_prod_estandar']/node()}"/>
		<input type="hidden" name="REF_NO_CORRECTA" value="{document($doc)/translation/texts/item[@name='ref_no_correcta']/node()}"/>
		<input type="hidden" name="NO_DERECHOS_PARA_CREAR" value="{document($doc)/translation/texts/item[@name='no_derechos_para_crear']/node()}"/>
		<input type="hidden" name="OBLI_PRECIO_REF_PROD_ESTANDAR" value="{document($doc)/translation/texts/item[@name='obli_precio_ref_prod_estandar']/node()}"/>
		<input type="hidden" name="OBLI_PRECIO_REF_PROD_ESTANDAR1" value="{document($doc)/translation/texts/item[@name='obli_precio_ref_prod_estandar1']/node()}"/>
		<input type="hidden" name="RESTAURAR_NOMBRE_PRODUCTO" value="{document($doc)/translation/texts/item[@name='restaurar_nombre_producto']/node()}"/>
		<input type="hidden" name="OBLI_NOMBRE_DIFFERENTE" value="{document($doc)/translation/texts/item[@name='obli_nombre_diferente']/node()}"/>
		<input type="hidden" name="OBLI_REF_DIFERENTE" value="{document($doc)/translation/texts/item[@name='obli_ref_diferente']/node()}"/>
		<input type="hidden" name="OBLI_REF_DIFERENTE1" value="{document($doc)/translation/texts/item[@name='obli_ref_diferente1']/node()}"/>
		<input type="hidden" name="NUEVO_PRODUCTO_NUEVA_REF" value="{document($doc)/translation/texts/item[@name='nuevo_producto_nueva_ref']/node()}"/>
		<input type="hidden" name="NUEVO_NOMBRE" value="{document($doc)/translation/texts/item[@name='nuevo_nombre']/node()}"/>
		<input type="hidden" name="NOMBRE_ACTUAL" value="{document($doc)/translation/texts/item[@name='nombre_actual']/node()}"/>
        
        <input type="hidden" name="MOVER_REF_ERROR" value="{document($doc)/translation/texts/item[@name='mover_ref_error']/node()}"/>
        
    </form>
    
  	</xsl:otherwise>
	</xsl:choose>
  </body>
  </html>
</xsl:template>  



</xsl:stylesheet>
