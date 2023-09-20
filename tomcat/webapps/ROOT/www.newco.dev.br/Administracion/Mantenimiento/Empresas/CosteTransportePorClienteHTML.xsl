<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Coste transporte por cliente
	Ultima revision: ET 04jul21	09:30
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/> 
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  
  <xsl:template match="/">
    <html>
      <head>
        <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/MantenimientoEmpresas/LANG"><xsl:value-of select="/MantenimientoEmpresas/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
           
      <title><xsl:value-of select="document($doc)/translation/texts/item[@name='mant_coste_trasporte_cliente']/node()"/></title>
       <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

      
	<xsl:text disable-output-escaping="yes"><![CDATA[
	

        <script type="text/javascript">
        <!--
	  
      	function CambiarCentro(idCliente,idCentro,accion){
         //alert('cliente '+idCliente);
         document.forms[0].elements['ACCION'].value=accion; 
         document.forms[0].elements['NUEVO_CLIENTE'].value=idCliente;
         document.forms[0].elements['NUEVO_CENTRO'].value=idCentro;

         SubmitForm(document.forms[0]);
       }
          
      function ValidarNumero(obj,decimales){

        if(checkNumber(obj.value,obj)){
          if(parseFloat(reemplazaComaPorPunto(obj.value))!=0){
            obj.value=anyadirCerosDecimales(reemplazaPuntoPorComa(Round(reemplazaComaPorPunto(obj.value),decimales)),decimales);
          }
          //alert('obj '+obj.value);
        return true;
        }
        return false;
       }


      function CerrarVentana(){
       window.close();
       Refresh(top.opener.document);
      }

          
        
        
	/*var msgCosteTrasporteActivo='Ha marcado el campo \"Pedido Mínimo\" como \'Activo\'. Por favor, rogamos rellene el campo \"Importe Mínimo\" antes de enviar el formulario.';
	var msgNoAceptarOfertas='Ha marcado el campo \"Pedido Mínimo\" como \'No Aceptar Ofertas\'. Por favor, rogamos rellene el campo \"Importe Mínimo\" antes de enviar el formulario.';
	var msgSimEmpresaParaCosteTrasporte='Seleccione una empresa a la que asignar el pedido mínimo, antes de enviar el formulario.';
	var msgSimCentroParaCosteTrasporte='Seleccione un centro al que asignar el pedido mínimo, antes de enviar el formulario.';
	var msgBorrarCosteTrasporteBorrarCliente='¿Borrar el pedido mínimo para la empresa y todos sus centros?';
	var msgBorrarCosteTrasporteBorrarCentro='¿Borrar el pedido mínimo para el centro?';*/
        	
        	
       function BorrarCosteTrasporte(idCliente,idCentro,accion,desdeDonde){
         var msgBorrarCosteTrasporte;

         if(accion=='BORRARCLIENTE'){
           msgBorrarCosteTrasporte=document.forms['MensajeJS'].elements['BORRAR_COSTE_TRANSPORTE_EMPRESA'].value;
         }
         else{
           if(accion=='BORRARCENTRO'){
             msgBorrarCosteTrasporte=document.forms['MensajeJS'].elements['BORRAR_COSTE_TRANSPORTE_CENTRO'].value;
           }
         }
         if(confirm(msgBorrarCosteTrasporte)){
           document.forms[0].elements['ACCION'].value=accion;    
           document.forms[0].elements['NUEVO_CLIENTE'].value=idCliente;
           document.forms[0].elements['NUEVO_CENTRO'].value=idCentro;
           document.forms[0].elements['DESDE'].value=desdeDonde;
           document.forms[0].elements['EMP_COSTETRANSPORTE'].value=reemplazaComaPorPunto(document.forms[0].elements['EMP_COSTETRANSPORTE'].value);

           SubmitForm(document.forms[0]);
         }
       }

       function ModificarCosteTransporte(idCliente,idCentro,accion){
         alert(accion);
         document.forms[0].elements['ACCION'].value=accion; 
         document.forms[0].elements['NUEVO_CLIENTE'].value=idCliente;
         document.forms[0].elements['NUEVO_CENTRO'].value=idCentro;
         document.forms[0].elements['EMP_COSTETRANSPORTE'].value=reemplazaComaPorPunto(document.forms[0].elements['EMP_COSTETRANSPORTE'].value);

         SubmitForm(document.forms[0]);
       }

       function NuevoCosteTrasportePorCliente(form){
/*

<!--
         ]]></xsl:text>

           var costeTrasporte='<xsl:value-of select="/MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO"/>';
           var importeCosteTrasporte='<xsl:value-of select="/MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_IMPORTE"/>';
           var descripcionCosteTrasporte='<xsl:value-of select="/MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_DETALLE"/>';

         <xsl:text disable-output-escaping="yes"><![CDATA[
         */
         
          var costeTrasporte= form.elements['EMP_COSTETRANSPORTE_ACTIVO'].value;
          var importeCosteTrasporte=form.elements['EMP_COSTETRANSPORTE_IMPORTE'].value;
          var descripcionCosteTrasporte=form.elements['EMP_COSTETRANSPORTE_DETALLE'].value;
        
           
         var opciones='?IDPROVEEDOR='                      + form.elements['IDPROVEEDOR'].value               +
                      '&EMP_COSTETRANSPORTE_ACTIVO='             + costeTrasporte                                +
                      '&EMP_COSTETRANSPORTE_IMPORTE='            + importeCosteTrasporte                         +
                      '&EMP_COSTETRANSPORTE_DETALLE='            + descripcionCosteTrasporte;




         var opciones='?IDPROVEEDOR='                      + form.elements['IDPROVEEDOR'].value 
                      +'&EMP_COSTETRANSPORTE_ACTIVO='             + form.elements['EMP_COSTETRANSPORTE_ACTIVO'].value 
                      +'&EMP_COSTETRANSPORTE_IMPORTE='            + form.elements['EMP_COSTETRANSPORTE_IMPORTE'].value 
                      +'&EMP_COSTETRANSPORTE_DETALLE='            + form.elements['EMP_COSTETRANSPORTE_DETALLE'].value

         document.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CosteTransportePorCliente.xsql'+opciones;      
//-->

    }	




    function ActualizarDatos(form, accion){
      if(validarFormulario(form)){
        form.elements['NUEVO_CLIENTE'].value=form.elements['IDEMPRESACLIENTE'].value;
        if(form.elements['IDCENTROCLIENTE']){
          form.elements['NUEVO_CENTRO'].value=form.elements['IDCENTROCLIENTE'].value;
        }
		
        form.elements['ACCION'].value=accion;
        SubmitForm(form);
      }
    }

    function validarFormulario(form){
      var errores=0;
      //alert(document.forms[0].elements['IDEMPRESACLIENTE'].value);

      if((!errores) && (document.forms[0].elements['IDEMPRESACLIENTE'].value<=0) && (document.forms[0].elements['IDCENTROCLIENTE'].value<=0))
	  {
        errores=1;
        document.forms[0].elements['IDEMPRESACLIENTE'].focus();
        alert(document.forms['MensajeJS'].elements['SEL_EMPRESA_COSTE_TRANSPORTE'].value);
      }

      if((!errores) && (document.forms[0].elements['EMP_COSTETRANSPORTEACTIVO_CHECK'].checked==true || document.forms[0].elements['EMP_INTEGRADO_CHECK'].checked==true)){
        var queMensaje;
        if(document.forms[0].elements['EMP_COSTETRANSPORTEACTIVO_CHECK'].checked==true){
          document.forms[0].elements['EMP_COSTETRANSPORTEACTIVO'].value='S';
          queMensaje='MINIMO_ACTIVO';
          if(document.forms[0].elements['EMP_COSTETRANSPORTEESTRICTO_CHECK'].checked==true)
        	document.forms[0].elements['EMP_COSTETRANSPORTEACTIVO'].value='E';
        }
        else{
          document.forms[0].elements['EMP_COSTETRANSPORTEACTIVO'].value='I';
          queMensaje='INTEGRADO';
        }

        if(esNulo(document.forms[0].elements['EMP_COSTETRANSPORTE'].value)){
          errores=1;
          if(queMensaje=='MINIMO_ACTIVO'){
        	alert(document.forms['MensajeJS'].elements['COSTE_TRANSPORTE_ACTIVO_ALERT'].value);
          }
          else{
        	alert(document.forms['MensajeJS'].elements['RELLENE_COSTE_TRANSPORTE_NO_ACEPTAR'].value);
          }
          form.elements['EMP_COSTETRANSPORTE'].focus();
          return false;
        }
        /*else{
         document.forms[0].elements['EMP_COSTETRANSPORTE'].value=reemplazaComaPorPunto(document.forms[0].elements['EMP_COSTETRANSPORTE'].value);
        }*/
      }
      else{
        if((!errores) && (document.forms[0].elements['EMP_COSTETRANSPORTEACTIVO_CHECK'].checked==false)){
          document.forms[0].elements['EMP_COSTETRANSPORTEACTIVO'].value='N';
        }
      }

      if(!errores)
        return true;  
    }
        	
    function costeTransporte(nombre,form)
	{
      if(nombre=="EMP_COSTETRANSPORTEACTIVO_CHECK")
	  {
        if(form.elements[nombre].checked==true){
          form.elements['EMP_COSTETRANSPORTEESTRICTO_CHECK'].disabled=false;
          form.elements['EMP_COSTETRANSPORTE'].disabled=false;
          form.elements['EMP_DESCRIPCIONCOSTETRANSPORTE'].disabled=false;
        }
        else{
          form.elements['EMP_COSTETRANSPORTEESTRICTO_CHECK'].checked=false;
          form.elements['EMP_COSTETRANSPORTEESTRICTO_CHECK'].disabled=true;

          form.elements['EMP_COSTETRANSPORTE'].value='';
          form.elements['EMP_COSTETRANSPORTE'].disabled=true;

          form.elements['EMP_DESCRIPCIONCOSTETRANSPORTE'].value='';
          form.elements['EMP_DESCRIPCIONCOSTETRANSPORTE'].disabled=true;
        }
      }
	  /*
      else
	  {
        if(nombre=="EMP_INTEGRADO_CHECK")
		{
          if(form.elements['EMP_INTEGRADO_CHECK'].checked==true){
            form.elements['EMP_COSTETRANSPORTEACTIVO_CHECK'].checked=false;
            form.elements['EMP_COSTETRANSPORTEACTIVO_CHECK'].disabled=true;
            form.elements['EMP_COSTETRANSPORTEESTRICTO_CHECK'].checked=false;
            form.elements['EMP_COSTETRANSPORTEESTRICTO_CHECK'].disabled=true;
            form.elements['EMP_COSTETRANSPORTE'].disabled=false;
            form.elements['EMP_DESCRIPCIONCOSTETRANSPORTE'].disabled=false;
          }
          else{
            form.elements['EMP_COSTETRANSPORTEACTIVO_CHECK'].disabled=false;
            form.elements['EMP_COSTETRANSPORTEESTRICTO_CHECK'].disabled=true;
            form.elements['EMP_COSTETRANSPORTE'].value='';
            form.elements['EMP_COSTETRANSPORTE'].disabled=true;

            form.elements['EMP_DESCRIPCIONCOSTETRANSPORTE'].value='';
            form.elements['EMP_DESCRIPCIONCOSTETRANSPORTE'].disabled=true;
          }
        }
      }
	  */
    }


    function cargarValoresDescripcionCosteTrasporte(textoConBR,nombreObjeto){

      var cadenaTmp='';  

      for(var i=0;i<textoConBR.length;i++){
        if(textoConBR.charCodeAt(i)==60 && textoConBR.charCodeAt(i+1)==98 && textoConBR.charCodeAt(i+2)==114 && textoConBR.charCodeAt(i+3)==47 && textoConBR.charCodeAt(i+4)==62){
          cadenaTmp+='\n';
          i=i+4;
        }
        else{
          cadenaTmp+=String.fromCharCode(textoConBR.charCodeAt(i));
        }
      }
      document.forms[0].elements[nombreObjeto].value=cadenaTmp;        
   }

        
                   
	//-->        
        </script>
        ]]></xsl:text> 
        
        
      </head>
      <body>
      	  <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/MantenimientoEmpresas/LANG"><xsl:value-of select="/MantenimientoEmpresas/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
           
     
        <xsl:choose>
          <!-- Error en alguna sentencia del XSQL -->
          <xsl:when test="//xsql-error">
            <xsl:apply-templates select="//xsql-error"/>        
          </xsl:when>
          <xsl:when test="//SESION_CADUCADA">
            <xsl:for-each select="//SESION_CADUCADA">
              <xsl:if test="position()=last()">
                <xsl:apply-templates select="."/>
              </xsl:if>
            </xsl:for-each>        
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='MODIFICARCLIENTE' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='INSERTARCENTRO' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='MODIFICARCENTRO' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='GUARDARCENTRO'">
                <xsl:attribute name="onLoad">
                  cargarValoresDescripcionCosteTrasporte('<xsl:value-of select="/MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_DETALLE"/>','EMP_DESCRIPCIONCOSTETRANSPORTE');
                </xsl:attribute>
              </xsl:when>
            </xsl:choose>


		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='mant_coste_trasporte_cliente']/node()"/></span></p>
			<p class="TituloPagina">
				<xsl:value-of select="/MantenimientoEmpresas/COSTESTRANSPORTE/PROVEEDOR/NOMBRE"/>
				<span class="CompletarTitulo">
					<a class="btnNormal" href="javascript:window.close();"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>&nbsp;
				</span>
			</p>
		</div>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>

	<!--
          <h1 class="titlePage">
            <xsl:value-of select="/MantenimientoEmpresas/COSTESTRANSPORTE/PROVEEDOR/NOMBRE"/>&nbsp;-&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='mant_coste_trasporte_cliente']/node()"/>
	  	  </h1>
        -->  
        <form name="form1" action="CosteTransportePorCliente.xsql" method="post">
          <input type="hidden" name="IDPROVEEDOR" value="{MantenimientoEmpresas/COSTESTRANSPORTE/PROVEEDOR/ID}"/>
          <input type="hidden" name="ACCION"/>
          <input type="hidden" name="DESDE"/>
          <input type="hidden" name="NUEVO_CLIENTE"/>
          <input type="hidden" name="NUEVO_CENTRO"/>
          
          
           <input type="hidden" name="EMP_COSTETRANSPORTE_ACTIVO" value="{MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO}"/>
           <input type="hidden" name="EMP_COSTETRANSPORTE_IMPORTE"  value="{MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_IMPORTE}"/>
           <input type="hidden" name="EMP_COSTETRANSPORTE_DETALLE"  value="{MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_DETALLE}"/>
         <table class="buscador">
          <tr class="subTituloTabla">
            <th class="tres">&nbsp;</th>
            <th class="veinte" align="left">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>
            </th>
            <th class="dies">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='coste_trasporte']/node()"/>
            </th>
            <th class="dies">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='coste_trasporte_eur']/node()"/>
            </th>
            <th>
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='descr_coste_trasporte']/node()"/>
            </th>
          </tr>
          <!-- si hay empresas las listamos con sus centros indentados (si los hay) -->
          <xsl:choose>
            <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA">
              <!-- mostramos cada empresa -->
              <xsl:for-each select="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA">
              
              <tr>
                <td>
                	<a href="javascript:BorrarCosteTrasporte('{ID}','','BORRARCLIENTE','');">
                    	<img src="http://www.newco.dev.br/images/2017/trash.png" />
                    </a>
	          </td>
	          <td class="textLeft">
	            <a href="javascript:ModificarCosteTransporte({ID},'','MODIFICARCLIENTE');">
	              <xsl:value-of select="NOMBRE"/>
	            </a>
	          </td>
                <td>
                 <input type="hidden" name="EMP_COSTETRANSPORTE_ACTIVO_{ID}" value="{ACTIVO}"/>
                 <xsl:choose>
                   <xsl:when test="ACTIVO='N'">
                     <b><xsl:value-of select="document($doc)/translation/texts/item[@name='no_activo']/node()"/></b>
                   </xsl:when>
                   <xsl:when test="ACTIVO='S'">
                     <b><xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/></b>
                   </xsl:when>
                   <xsl:when test="ACTIVO='E'">
                     <b><xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/></b>
                   </xsl:when>
                   <xsl:when test="ACTIVO='I'">
                     <b><xsl:value-of select="document($doc)/translation/texts/item[@name='integrado']/node()"/></b>
                   </xsl:when>
                 </xsl:choose>
                </td>
                <td>
                  <xsl:value-of select="IMPORTE"/>
                </td>
                <td align="left">
                      <xsl:copy-of select="DESCRIPCION_HTML"/>
                </td>
              </tr>
              <!-- si tiene centros con pedidos minimos los listamos tambien -->
                 <xsl:for-each select="CENTROS_CON_COSTE_TRANSPORTE/CENTRO">
                 <tr class="gris">
                   <td>
                   		<a href="javascript:BorrarCosteTrasporte('{../../ID}','{ID}','BORRARCENTRO','');">
                    		<img src="http://www.newco.dev.br/images/2017/trash.png" />
                    	</a>
	                 </td>
	                 <td class="textLeft">
	                   &nbsp;&nbsp;&nbsp;&nbsp;&gt;&nbsp;<a href="javascript:ModificarCosteTransporte('{../../ID}','{ID}','MODIFICARCENTRO');">
	                    <xsl:value-of select="NOMBRE"/>
	                   </a>
	                 </td>
                   <td>
                    <input type="hidden" name="EMP_COSTETRANSPORTE_ACTIVO_{ID}" value="{ACTIVO}"/>
                    <xsl:choose>
                      <xsl:when test="ACTIVO='N'">
                        <b><xsl:value-of select="document($doc)/translation/texts/item[@name='no_activo']/node()"/></b>
                      </xsl:when>
                      <xsl:when test="ACTIVO='S'">
                        <b><xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/></b>
                      </xsl:when>
                      <xsl:when test="ACTIVO='E'">
                        <b><xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/></b>
                      </xsl:when>
                      <xsl:when test="ACTIVO='I'">
                        <b><xsl:value-of select="document($doc)/translation/texts/item[@name='integrado']/node()"/></b>
                      </xsl:when>
                    </xsl:choose>
                   </td>
                   <td>
                     <xsl:value-of select="IMPORTE"/>
                   </td>
                   <td>
                         <xsl:copy-of select="DESCRIPCION_HTML"/>
                   </td>
                 </tr>
                   
                 </xsl:for-each>
              
              </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
              <tr>
                <td colspan="5">
                	<xsl:value-of select="document($doc)/translation/texts/item[@name='ninguna_empresa_coste_trasporte']/node()"/>
                </td>
              </tr>
            </xsl:otherwise>
          </xsl:choose>
        </table> 
       <br /><br />
     <!--tabla abajo mantenimiento-->
        <table class="infoTable" border="0">
          <tr>
              <th align="right" class="veinte">
                <xsl:choose>
                    <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCLIENTE' or MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='INSERTARCENTRO' or MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCENTRO' or MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='GUARDARCENTRO'">
                      <xsl:choose>
                        <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCLIENTE' or MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='INSERTARCENTRO' or MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='GUARDARCENTRO' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCENTRO'">
                         <xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>
                        </xsl:when>
                      <!--  <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCENTRO'">
                         Añadir/Modificar Centro
                        </xsl:when>-->
                      </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>
                    </xsl:otherwise>
                  </xsl:choose>
               </th>
               <th colspan="2" align="left">
                  &nbsp;&nbsp;&nbsp;&nbsp;>>&nbsp;&nbsp;
                  <xsl:choose>
                   <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='INICIO' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='BORRARCENTRO' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCLIENTE' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='INSERTARCENTRO' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCENTRO' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='BORRARCLIENTE' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='BORRARCENTRO' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='INSERTARCLIENTE' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='CENTRO' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='GUARDARCLIENTE'">
 						<xsl:call-template name="desplegable"> 
						<xsl:with-param name="id" value="IDEMPRESACLIENTE"/>
						<xsl:with-param name="path" select="/MantenimientoEmpresas/COSTESTRANSPORTE/EMPRESAS/field" />
						</xsl:call-template> 
                  </xsl:when>
                  <xsl:otherwise>
                      <input type="hidden" name="IDEMPRESACLIENTE" value=""/>
                  </xsl:otherwise>
                 </xsl:choose>
				 
				<!-- &nbsp;&nbsp; [<xsl:value-of select="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION"/>] SOLO PRUEBAS!&nbsp;&nbsp;-->
				 
              </th>
        
              <th colspan="2">&nbsp;</th>
              </tr>
          
           
           <!-- si hay alguna empresa seleccionada mostramos el desplegable de centros o el centro seleccionado -->
           
           <!--<xsl:if test="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA">-->
			<xsl:choose>
			<xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='INICIO' and /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='BORRARCLIENTE' and /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION !='MODIFICARCLIENTE'">
			<!--
            	 <xsl:choose>
            	   <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCENTRO'">
                	 <tr>
                	   <td class="labelRight cuarenta">
                    	 Centro:
                	   </td>
                	   <td colspan="3">
                    	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    	 <b><xsl:value-of select="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/CENTROS_CON_COSTE_TRANSPORTE/CENTRO_SELECCIONADO/NOMBRE"/></b>
                    	 <input type="hidden" name="IDCENTROCLIENTE" value="{/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/CENTROS_CON_COSTE_TRANSPORTE/CENTRO_SELECCIONADO/ID}"/>
                	   </td>
                	 </tr>

            	   </xsl:when>
            	   <xsl:otherwise>-->
                	  <tr>
                    	<th align="right">
                    	  <xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>
                    	</th>
                        <th colspan="2" align="left">
                    	  &nbsp;&nbsp;&nbsp;&nbsp;>>&nbsp;&nbsp;
							<xsl:call-template name="desplegable"> 
							<xsl:with-param name="id" value="IDCENTROCLIENTE"/>
							<xsl:with-param name="path" select="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/LISTACENTROS/field" />
							</xsl:call-template>

                    	</th>
                        <th colspan="2">&nbsp;</th>
                	  </tr>
            	 <!--  </xsl:otherwise>
            	 </xsl:choose>-->
			</xsl:when>
			<xsl:otherwise>
                 <input type="hidden" name="IDCENTROCLIENTE" value=""/>
			</xsl:otherwise>
			</xsl:choose>
            </table>   
          
           
          <table class="infoTable" border="0"> 
               <tr class="subTituloTabla">
                  <td colspan="3">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='coste_trasporte']/node()"/>
                  </td>
                </tr>
			<tr>
             <td class="labelRight">
               <xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/>:
             </td>
             <td class="tres">
               <xsl:choose>
                  <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='MODIFICARCLIENTE' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='INSERTARCENTRO' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='MODIFICARCENTRO' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='GUARDARCENTRO'">
                    <xsl:choose>
                      <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO='S' or MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO='E'">
                        <input type="checkbox" name="EMP_COSTETRANSPORTEACTIVO_CHECK"  checked="checked" onClick="costeTransporte(this.name,document.forms[0]);"/>
                      </xsl:when>
                      <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO='I'">
                        <input type="checkbox" name="EMP_COSTETRANSPORTEACTIVO_CHECK"  disabled="disabled" onClick="costeTransporte(this.name,document.forms[0]);"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <input type="checkbox" name="EMP_COSTETRANSPORTEACTIVO_CHECK" onClick="costeTransporte(this.name,document.forms[0]);"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:when>
                  <!--modificar, insertar centro-->
                  <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCENTRO' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='INSERTARCENTRO'">
                    <xsl:choose>
                      <xsl:when test="//CENTRO_SELECCIONADO/ACTIVO='S' or //CENTRO_SELECCIONADO/ACTIVO='E'">
                        <input type="checkbox" name="EMP_COSTETRANSPORTEACTIVO_CHECK" checked="checked" onClick="costeTransporte(this.name,document.forms[0]);"/>
                      </xsl:when>
                      <xsl:when test="//CENTRO_SELECCIONADO/ACTIVO='I'">
                        <input type="checkbox" name="EMP_COSTETRANSPORTEACTIVO_CHECK"  disabled="disabled" onClick="costeTransporte(this.name,document.forms[0]);"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <input type="checkbox" name="EMP_COSTETRANSPORTEACTIVO_CHECK" onClick="costeTransporte(this.name,document.forms[0]);"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:choose>
                      <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/ACTIVO='S' or MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/ACTIVO='E'">
                        <input type="checkbox" name="EMP_COSTETRANSPORTEACTIVO_CHECK"  checked="checked" onClick="costeTransporte(this.name,document.forms[0]);"/>
                      </xsl:when>
                      <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/ACTIVO='I'">
                        <input type="checkbox" name="EMP_COSTETRANSPORTEACTIVO_CHECK"  disabled="disabled" onClick="costeTransporte(this.name,document.forms[0]);"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <input type="checkbox" name="EMP_COSTETRANSPORTEACTIVO_CHECK" onClick="costeTransporte(this.name,document.forms[0]);"/>
                      </xsl:otherwise>
                    </xsl:choose>   
                  </xsl:otherwise>
                </xsl:choose>
             </td>
           <td class="datosLeft" >
             <xsl:value-of select="document($doc)/translation/texts/item[@name='activar_coste_trasporte']/node()"/>.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           		<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='importe']/node()"/>:</strong>&nbsp;<input type="hidden" name="EMP_COSTETRANSPORTEACTIVO" value="{MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO}"/>
 
        <xsl:choose>
          <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='MODIFICARCLIENTE' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='INSERTARCENTRO' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='MODIFICARCENTRO' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='GUARDARCENTRO'">
            <xsl:choose>
              <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO='S' or MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO='E' or MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO='I'">
	        <!--<input type="text" name="EMP_COSTETRANSPORTE" onBlur="ValidarNumero(this,2);" value="{MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_IMPORTE}"/>-->
             <input type="text" name="EMP_COSTETRANSPORTE" onBlur="ValidarNumero(this,2);" value="{MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_IMPORTE}"/>
	      </xsl:when>
	      <xsl:otherwise>
	        <input type="text" name="EMP_COSTETRANSPORTE" disabled="disabled" onBlur="ValidarNumero(this,2);"/>
	      </xsl:otherwise>
   	    </xsl:choose>  
   	  </xsl:when>
   	  <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCENTRO' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='INSERTARCENTRO'">
   	    <xsl:choose>
              <xsl:when test="//CENTRO_SELECCIONADO/ACTIVO='S' or //CENTRO_SELECCIONADO/ACTIVO='E' or //CENTRO_SELECCIONADO/ACTIVO='I'">
	        <input type="text" name="EMP_COSTETRANSPORTE" onBlur="ValidarNumero(this,2);" value="{//CENTRO_SELECCIONADO/IMPORTE}"/>
	      </xsl:when>
	      <xsl:otherwise>
	        <input type="text" name="EMP_COSTETRANSPORTE" disabled="disabled" onBlur="ValidarNumero(this,2);"/>
	      </xsl:otherwise>
   	    </xsl:choose>
   	  </xsl:when>
   	  <xsl:otherwise>
   	    <xsl:choose>
              <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/ACTIVO='S' or MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/ACTIVO='E' or MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/ACTIVO='I'">
              
	        <input type="text" name="EMP_COSTETRANSPORTE" onBlur="ValidarNumero(this,2);" value="{MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/IMPORTE}"/>
	      </xsl:when>
	      <xsl:otherwise>
	        <input type="text" name="EMP_COSTETRANSPORTE" disabled="disabled" onBlur="ValidarNumero(this,2);"/>
	      </xsl:otherwise>
   	    </xsl:choose>
   	  </xsl:otherwise>
   	  </xsl:choose>
      </td>
         </tr>
         <tr>
           <td class="labelRight">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/>:
           </td>
           <td>
             <xsl:choose>
               <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='MODIFICARCLIENTE' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='INSERTARCENTRO' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='MODIFICARCENTRO' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='GUARDARCENTRO'">
                    <xsl:choose>
                      <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO='S'">
   	                <input type="checkbox" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO='E'">
   	                <input type="checkbox" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" checked="checked" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO='I'">
   	                <input type="checkbox" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" disabled="disabled" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:otherwise>
   	                <input type="checkbox" disabled="disabled" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	              </xsl:otherwise>
   	            </xsl:choose> 
   	          </xsl:when>
   	          <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCENTRO' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='INSERTARCENTRO'">
                    <xsl:choose>
                      <xsl:when test="//CENTRO_SELECCIONADO/ACTIVO='S'">
   	                <input type="checkbox" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:when test="//CENTRO_SELECCIONADO/ACTIVO='E'">
   	                <input type="checkbox" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" checked="checked" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:when test="//CENTRO_SELECCIONADO/ACTIVO='I'">
   	                <input type="checkbox" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" disabled="disabled" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:otherwise>
   	                <input type="checkbox" disabled="disabled" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	              </xsl:otherwise>
   	            </xsl:choose> 
   	          </xsl:when>
   	          <xsl:otherwise>
   	            <xsl:choose>
                      <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/ACTIVO='S'">
   	                <input type="checkbox" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/ACTIVO='E'">
   	                <input type="checkbox" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" checked="checked" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/ACTIVO='I'">
   	                <input type="checkbox" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" disabled="disabled" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	              </xsl:when>
   	              <xsl:otherwise>
   	                <input type="checkbox" disabled="disabled" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	              </xsl:otherwise>
   	            </xsl:choose> 
   	          </xsl:otherwise>
   	        </xsl:choose>
   	   </td>
   	   <td class="datosLeft">
       		<xsl:value-of select="document($doc)/translation/texts/item[@name='no_permitir_pedidos_sin_coste_trasporte']/node()"/>.
           </td>
   	 </tr>
   	 <tr>
           <td class="labelRight">
           	<xsl:value-of select="document($doc)/translation/texts/item[@name='no_aceptar_ofertas']/node()"/>:
           </td>
           <td>
             <xsl:choose>
               <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='MODIFICARCLIENTE' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='INSERTARCENTRO' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='MODIFICARCENTRO' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='GUARDARCENTRO'">
                 <xsl:choose>
                   <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO='I'">
   	             <input type="checkbox" checked="checked" name="EMP_INTEGRADO_CHECK" />
   	           </xsl:when>
   	           <xsl:otherwise>
   	             <input type="checkbox" name="EMP_INTEGRADO_CHECK" />
   	           </xsl:otherwise>
   	         </xsl:choose>
   	       </xsl:when>
   	       <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCENTRO'">
   	         <xsl:choose>
                   <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/CENTROS_CON_COSTE_TRANSPORTE/CENTRO_SELECCIONADO/ACTIVO='I'">
	             <input type="checkbox" checked="checked" name="EMP_INTEGRADO_CHECK" />
   	           </xsl:when>
   	           <xsl:otherwise>
   	             <input type="checkbox" name="EMP_INTEGRADO_CHECK" />
   	           </xsl:otherwise>
   	         </xsl:choose>
   	       </xsl:when>
   	       <xsl:otherwise>
   	         <xsl:choose>
                   <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/ACTIVO='I'">
   	             <input type="checkbox" checked="checked" name="EMP_INTEGRADO_CHECK" />
   	           </xsl:when>
   	           <xsl:otherwise>
   	             <input type="checkbox" name="EMP_INTEGRADO_CHECK" />
   	           </xsl:otherwise>
   	         </xsl:choose>
   	       </xsl:otherwise>
   	     </xsl:choose>
   	   </td>
   	   <td class="datosLeft">
       		<xsl:value-of select="document($doc)/translation/texts/item[@name='permitir_unicamente_envio_pedidos']/node()"/>.
       </td>
      </tr>
      <tr>
     <td class="labelRight">
     	<xsl:value-of select="document($doc)/translation/texts/item[@name='descr_coste_trasporte']/node()"/>
      </td>
      <td colspan="2" class="datosLeft">
        <xsl:choose>
          <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='MODIFICARCLIENTE' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='INSERTARCENTRO' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='MODIFICARCENTRO' and MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='GUARDARCENTRO'">
            <xsl:choose> 
              <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO='' or MantenimientoEmpresas/COSTESTRANSPORTE/EMP_COSTETRANSPORTE_ACTIVO='N'">
   	        <textarea name="EMP_DESCRIPCIONCOSTETRANSPORTE" cols="60" rows="5" disabled="disabled"></textarea>
   	      </xsl:when>
   	      <xsl:otherwise>
   	        <textarea name="EMP_DESCRIPCIONCOSTETRANSPORTE" cols="60" rows="5">
   	        </textarea> 
   	      </xsl:otherwise>
   	    </xsl:choose>    
   	  </xsl:when>
   	  <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCENTRO'">
            <xsl:choose> 
              <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/CENTROS_CON_COSTE_TRANSPORTE/CENTRO_SELECCIONADO/EMP_COSTETRANSPORTE_ACTIVO='' or MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/CENTROS_CON_COSTE_TRANSPORTE/CENTRO_SELECCIONADO/EMP_COSTETRANSPORTE_ACTIVO='N'">
   	        <textarea name="EMP_DESCRIPCIONCOSTETRANSPORTE" cols="60" rows="5" disabled="disabled">
   	        </textarea>
   	      </xsl:when>
   	      <xsl:otherwise>
   	        <textarea name="EMP_DESCRIPCIONCOSTETRANSPORTE" cols="60" rows="5">
   	          <xsl:value-of select="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/CENTROS_CON_COSTE_TRANSPORTE/CENTRO_SELECCIONADO/DESCRIPCION"/>
   	        </textarea> 
   	      </xsl:otherwise>
   	    </xsl:choose>
   	  </xsl:when>
   	  <xsl:otherwise>
   	    <xsl:choose> 
              <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/EMP_COSTETRANSPORTE_ACTIVO='' or MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/EMP_COSTETRANSPORTE_ACTIVO='N'">
   	        <textarea name="EMP_DESCRIPCIONCOSTETRANSPORTE" cols="60" rows="5" disabled="disabled">
   	        </textarea>
   	      </xsl:when>
   	      <xsl:otherwise>
   	        <textarea name="EMP_DESCRIPCIONCOSTETRANSPORTE" cols="60" rows="5">
   	          <xsl:value-of select="/MantenimientoEmpresas/COSTESTRANSPORTE/CLIENTES_CON_COSTE_TRANSPORTE/EMPRESA_SELECCIONADA/DESCRIPCION"/>
   	        </textarea> 
   	      </xsl:otherwise>
   	    </xsl:choose>
   	  </xsl:otherwise>
   	</xsl:choose>
      </td>
    </tr>
	</table>
      <br/>
      <br />
      <table width="100%">
		<tr align="center">
        	<td class="dies">&nbsp;</td>
              <td>
                <xsl:call-template name="boton">
                  <xsl:with-param name="path" select="/MantenimientoEmpresas/button[@label='Cerrar']"/>
                </xsl:call-template>
              </td>
              <xsl:choose>
                <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='INSERTARCLIENTE' or MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='INSERTARCENTRO' or MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCENTRO' or MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='GUARDARCENTRO' or MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='GUARDARCLIENTE' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='BORRARCENTRO' or /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION ='MODIFICARCLIENTE'">
                  <td> 
                  	<div class="boton">
                    	<a href="javascript:NuevoCosteTrasportePorCliente(document.forms[0]);"><xsl:value-of select="document($doc)/translation/texts/item[@name='volver_a_empresas']/node()"/></a>
                    </div>
                    </td>
                   
                  <xsl:choose>
                  <xsl:when test="(/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='INSERTARCLIENTE' or MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='INSERTARCENTRO' or MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='GUARDARCENTRO' or MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='GUARDARCLIENTE' or MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCENTRO') and /MantenimientoEmpresas/COSTESTRANSPORTE/ACCION!='MODIFICARCLIENTE'">
                      <td>
                      	<div class="boton">
                        	<a href="javascript:ActualizarDatos(document.forms[0],'INSERTARCENTRO');">
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='insertar_centro']/node()"/>
                            </a>
                        </div>
                      </td>
                    </xsl:when>
                    <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='BORRARCENTRO'">
                       <td>
                       	<div class="boton">
                        	<a href="javascript:ActualizarDatos(document.forms[0],'INSERTARCENTRO');">
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='insertar_centro']/node()"/>
                            </a>
                        </div>
                      </td>
                      <!-- <td  align="center">
                        <xsl:call-template name="boton">
                          <xsl:with-param name="path" select="/MantenimientoEmpresas/button[@label='InsertarEmpresa']"/>
                        </xsl:call-template>
                  	   </td>
                      <td align="center">
                          <xsl:call-template name="boton">
                            <xsl:with-param name="path" select="/MantenimientoEmpresas/button[@label='GuardarCentro']"/>
                          </xsl:call-template>
                      </td>-->
                    </xsl:when>
                    <xsl:when test="/MantenimientoEmpresas/COSTESTRANSPORTE/ACCION='MODIFICARCLIENTE'">
                    	 <td> 
                         <div class="boton">
                        	<a href="javascript:ActualizarDatos(document.forms[0],'INSERTARCLIENTE');">
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='insertar_empresa']/node()"/>
                            </a>
                         </div>
                         </td>
                    </xsl:when>
                  </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                  <td  align="center">
                    <div class="boton">
                        	<a href="javascript:ActualizarDatos(document.forms[0],'INSERTARCLIENTE');">
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='insertar_empresa']/node()"/>
                            </a>
                    </div>
                  </td>
                </xsl:otherwise>
              </xsl:choose>
            </tr>
          </table>
        </form>
        
        <form name="MensajeJS">
        	<input type="hidden" name="COSTE_TRANSPORTE_ACTIVO_ALERT" value="{document($doc)/translation/texts/item[@name='coste_trasporte_activo_alert']/node()}"/>
            
            <input type="hidden" name="RELLENE_COSTE_TRANSPORTE_NO_ACEPTAR" value="{document($doc)/translation/texts/item[@name='rellene_coste_trasporte_no_aceptar']/node()}"/>
            
            <input type="hidden" name="SEL_EMPRESA_COSTE_TRANSPORTE" value="{document($doc)/translation/texts/item[@name='seleccione_empresa_coste_trasporte']/node()}"/>
            
            <input type="hidden" name="SEL_CENTRO_COSTE_TRANSPORTE" value="{document($doc)/translation/texts/item[@name='seleccione_centro_coste_trasporte']/node()}"/>
            
            <input type="hidden" name="BORRAR_COSTE_TRANSPORTE_EMPRESA" value="{document($doc)/translation/texts/item[@name='borrar_coste_trasporte_empresa']/node()}"/>
            
            <input type="hidden" name="BORRAR_COSTE_TRANSPORTE_CENTRO" value="{document($doc)/translation/texts/item[@name='borrar_coste_trasporte_centro']/node()}"/>
            
        </form>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
