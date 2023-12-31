<?xml version="1.0" encoding="iso-8859-1" ?>
<!--   --> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
  <xsl:import href="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/Comentarios_lib.xsl"/>

  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>

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

        <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->

	<meta http-equiv="Cache-Control" Content="no-cache"/>

  <script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/ajax.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CargaDocumentos110614.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPManten27may16.js"></script>


	<script type="text/javascript">
		var ActivaEmpEspecialTXT	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='empresa_especial_activa']/node()"/>';
		var InactivaEmpEspecialTXT	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='empresa_especial_inactiva']/node()"/>';
		var ActivarTXT			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='mostrar']/node()"/>';
		var DesactivarTXT		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='ocultar']/node()"/>';

		function seleccionaMeses(){
			var mesesSelected = '<xsl:value-of select="/MantenimientoEmpresas/form/EMPRESA/EMP_LIC_PLAZONEGOCIACION"/>';
			jQuery("#EMP_LIC_PLAZO_NEG").val(parseInt(mesesSelected.replace(',','.')));
		}
	</script>
      </head>
      <body onload="seleccionaMeses();">
        <xsl:choose>
           <xsl:when test="//SESION_CADUCADA">
            <xsl:for-each select="//SESION_CADUCADA">
              <xsl:if test="position()=last()">
                <xsl:apply-templates select="."/>
              </xsl:if>
            </xsl:for-each>
          </xsl:when>
           <xsl:when test="Lista/xsql-error">
             <xsl:apply-templates select="//xsql-error"/>
           </xsl:when>
           <!--
            |
            +-->
          <xsl:when test="MantenimientoEmpresas/form/Status">
             <xsl:apply-templates select="MantenimientoEmpresas/form/Status"/>
          </xsl:when>
          <xsl:otherwise>
	        <xsl:choose>
	          <xsl:when test="MantenimientoEmpresas/form/EMPRESA/EMP_ID != 0 and MantenimientoEmpresas/form/EMPRESA/EMP_IDTIPO = 0">
	          <xsl:value-of select="document($doc)/translation/texts/item[@name='no_se_han_encontrado_datos_empresa']/node()"/>
	             <xsl:value-of select="/MantenimientoEmpresas/form/EMPRESA/EMP_ID" />
	          </xsl:when>
	          <xsl:otherwise>
	            <xsl:apply-templates select="MantenimientoEmpresas/form"/>
	          </xsl:otherwise>
	        </xsl:choose>
	  </xsl:otherwise>
	</xsl:choose>

   <div id="uploadFrame" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>
   <div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>

      </body>
    </html>
  </xsl:template>

<!--
 |  Templates
 +-->

<xsl:template match="form">

         <!--idioma-->
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/MantenimientoEmpresas/LANG"><xsl:value-of select="/MantenimientoEmpresas/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->

  <form>
    <xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
    <xsl:attribute name="id"><xsl:value-of select="@name"/></xsl:attribute>
    <xsl:attribute name="action"><xsl:value-of select="@action"/></xsl:attribute>
    <xsl:attribute name="method"><xsl:value-of select="@method"/></xsl:attribute><!---->
	<input type="hidden" name="ADMINISTRADORMVM" value="{/MantenimientoEmpresas/ADMINISTRADORMVM}"/>
    <input type="hidden" name="EMP_PROVINCIA"/>
    <input type="hidden" name="CADENA_IMAGENES"/>
	<input type="hidden" name="IMAGENES_BORRADAS"/>
    <input type="hidden" name="TIENEPEDIDOS">
    <xsl:attribute name="value">
    	<xsl:choose><xsl:when test="/MantenimientoEmpresas/form/EMPRESA/TIENEPEDIDOS">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>
    </xsl:attribute>
    </input>
    <xsl:apply-templates select="EMPRESA"/>
  </form>


   <!--form para mensajes js-->
    <form name="MensajeJS">
  	<input type="hidden" name="PEDIDO_MINIMO_ACTIVO" value="{document($doc)/translation/texts/item[@name='pedido_minimo_activo']/node()}"/>

    <input type="hidden" name="NO_ACEPTAR_OFERTAS" value="{document($doc)/translation/texts/item[@name='no_aceptar_ofertas']/node()}"/>
    <input type="hidden" name="OBLI_NOMBRE_EMPRESA" value="{document($doc)/translation/texts/item[@name='obli_nombre_empresa']/node()}"/>
    <input type="hidden" name="OBLI_NOMBRECORTOPUBLICO" value="{document($doc)/translation/texts/item[@name='obli_nombre_corto_publico']/node()}"/>
    <input type="hidden" name="FORMATO_NOMBRECORTOPUBLICO" value="{document($doc)/translation/texts/item[@name='formato_nombre_corto_publico']/node()}"/>
    <input type="hidden" name="YA_EXISTE_NOMBRECORTOPUBLICO" value="{document($doc)/translation/texts/item[@name='ya_existe_nombre_corto_publico']/node()}"/>

    <input type="hidden" name="OBLI_NIF" value="{document($doc)/translation/texts/item[@name='obli_nif']/node()}"/>
    <input type="hidden" name="OBLI_DIRECCION" value="{document($doc)/translation/texts/item[@name='obli_direccion']/node()}"/>
    <input type="hidden" name="OBLI_COD_POSTAL" value="{document($doc)/translation/texts/item[@name='obli_cod_poostal']/node()}"/>
    <input type="hidden" name="OBLI_POBLACION" value="{document($doc)/translation/texts/item[@name='obli_poblacion']/node()}"/>
    <input type="hidden" name="OBLI_TELEFONO" value="{document($doc)/translation/texts/item[@name='obli_telefono']/node()}"/>
    <input type="hidden" name="OBLI_COMERCIAL" value="{document($doc)/translation/texts/item[@name='obli_comercial']/node()}"/>
    <input type="hidden" name="OBLI_USUARIO_CATALOGO" value="{document($doc)/translation/texts/item[@name='obli_usuario_catalogo']/node()}"/>
    <input type="hidden" name="OBLI_USUARIO_EVALUAZ" value="{document($doc)/translation/texts/item[@name='obli_usuario_evaluaz']/node()}"/>
    <input type="hidden" name="OBLI_USUARIO_INCIDEN" value="{document($doc)/translation/texts/item[@name='obli_usuario_inciden']/node()}"/>

    <input type="hidden" name="OBLI_USUARIO_NEGOCIA" value="{document($doc)/translation/texts/item[@name='obli_usuario_negocia']/node()}"/>
    <input type="hidden" name="OBLI_US_RECLAMACIONES" value="{document($doc)/translation/texts/item[@name='obli_us_reclamaciones']/node()}"/>

     <input type="hidden" name="COSTE_TRASPORTE_ACTIVO_ALERT" value="{document($doc)/translation/texts/item[@name='coste_trasporte_activo_alert']/node()}"/>
     <input type="hidden" name="FORMATO_NUM_GUION_PARENT" value="{document($doc)/translation/texts/item[@name='formato_num_guion_parent']/node()}"/>
     <input type="hidden" name="FORMATO_NUMERO" value="{document($doc)/translation/texts/item[@name='formato_numero']/node()}"/>
     <input type="hidden" name="NOMBRE_LOGO_OBLI" value="{document($doc)/translation/texts/item[@name='nombre_logo_obli']/node()}"/>
     <input type="hidden" name="LOGO_OBLI" value="{document($doc)/translation/texts/item[@name='logo_obli']/node()}"/>
     <input type="hidden" name="TIENE_PEDIDOS_AVISO" value="{document($doc)/translation/texts/item[@name='tiene_pedidos_aviso']/node()}"/>
     <input type="hidden" name="CAR_RAROS" value="{document($doc)/translation/texts/item[@name='caracteres_raros_sin_barra']/node()}"/>
     <input type="hidden" name="OBLI_USUARIO_LICITACION_AUTO" value="{document($doc)/translation/texts/item[@name='obli_usuario_licitacion_auto']/node()}"/>
     <input type="hidden" name="RELLENAR_NOMBRE_CORTO" value="{document($doc)/translation/texts/item[@name='rellenar_nombre_corto']/node()}"/>

     </form>
    <!--fin form para mensajes js-->

</xsl:template>

<xsl:template match="EMPRESA">
  <input type="hidden" name="DESDE" value="{@DESDE}"/>
  <input type="hidden" name="TIPO_EMP" value="{/MantenimientoEmpresas/form/EMPRESA/ROL}"/>
  <input type="hidden" name="EMP_IDUSUARIORECLAMACIONES" />

 	  <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/MantenimientoEmpresas/LANG"><xsl:value-of select="/MantenimientoEmpresas/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->


  <h1 class="titlePage" style="float:left;width:70%;padding-left:10%;">
  	<xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:&nbsp;<xsl:value-of select="substring(/MantenimientoEmpresas/form/EMPRESA/EMP_NOMBRE,0,30)" />
    <xsl:if test="/MantenimientoEmpresas/form/EMPRESA/MVM or /MantenimientoEmpresas/form/EMPRESA/MVMB">
		<xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
		<a title="Ficha Empresa" style="text-decoration:none;">
			<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="EMP_ID"/>&amp;VENTANA=NUEVA','DetalleEmpresa',100,58,0,-50)</xsl:attribute>
			<img src="http://www.newco.dev.br/images/verFichaIcon.gif" />
			<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='ver_ficha']/node()"/>-->
		</a>
       <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
		<a href="javascript:window.print();" title="Imprimir" style="text-decoration:none;">
			<img src="http://www.newco.dev.br/images/imprimir.gif"/>
			<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>-->
		</a>
	</xsl:if>
  </h1>
  <h1 class="titlePage" style="float:left;width:20%">
  	 <span style="float:right; padding:5px; font-weight:bold;" class="amarillo">EMP_ID=<xsl:value-of select="EMP_ID"/></span>
  </h1>

<div class="divLeft">
<table class="infoTable" border="0">
    <xsl:choose>
        <xsl:when test="/MantenimientoEmpresas/form/EMPRESA/ROL='VENDEDOR' and /MantenimientoEmpresas/form/EMPRESA/EMP_ENVIARPDF = 'S'">
             <tr><td colspan="5">
                    <span class="cargado"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_se_enviaran_vendedor_pdf']/node()"/></span>
            </td></tr>
        </xsl:when>
        <xsl:when test="/MantenimientoEmpresas/form/EMPRESA/ROL='COMPRADOR' and /MantenimientoEmpresas/form/EMPRESA/EMP_ENVIARPDF = 'S'">
            <tr><td colspan="5">
            <xsl:choose>
                <xsl:when test="/MantenimientoEmpresas/form/EMPRESA/SIN_USUARIO_INTEGRACION">
                    <span class="cargado"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_se_enviaran_comprador_pdf']/node()"/></span>
                </xsl:when>
                <xsl:otherwise><span class="cargado"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_se_enviaran_usuario_integrado_pdf']/node()"/></span></xsl:otherwise>
            </xsl:choose>
            </td></tr>
        </xsl:when>

    </xsl:choose>

	<tr>
		<td colspan="5"><span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='los_siguientes_caracteres_no_deben_sin_barra']/node()"/></span></td>
	</tr>

    <input type="hidden" name="EMP_ID" id="EMP_ID" value="{EMP_ID}"/>&nbsp;&nbsp;
	<input type="hidden" name="IDEMPRESA" id="IDEMPRESA" value="{EMP_ID}"/>

	<tr>
        <td class="quince" rowspan="3">
            <img src="http://www.newco.dev.br/Documentos/{/MantenimientoEmpresas/form/EMPRESA/URL_LOGOTIPO}" height="80px" width="160px"/>
		</td>
		<td class="labelRight dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="datosLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			<xsl:value-of select="EMP_NOMBRE"/>
		</xsl:when>
		<xsl:otherwise>
        	<input type="hidden" name="EMP_NOMBRE_OLD" maxlength="100" size="50" value="{EMP_NOMBRE}"/>
			<input type="text" name="EMP_NOMBRE" maxlength="100" size="50" value="{EMP_NOMBRE}" />
		</xsl:otherwise>
		</xsl:choose>
		</td>
		<input type="hidden" id="EMP_IDPAIS" name="EMP_IDPAIS" value="{/MantenimientoEmpresas/form/EMPRESA/EMP_IDPAIS}" />

		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='portal']/node()"/>:</td>
		<td class="datosLeft">
        <xsl:call-template name="desplegable">
            <xsl:with-param name="path" select="/MantenimientoEmpresas/form/EMPRESA/PORTALES/field"/>
            <xsl:with-param name="defecto" select="/MantenimientoEmpresas/form/EMPRESA/PORTALES/field/@current"/>
        </xsl:call-template>
		</td>
	</tr>

        <tr>
		<td class="labelRight">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_corto_publico']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="datosLeft">
        <xsl:choose>
        <xsl:when test="NOEDICION">
        <!--si es mvm, o viamed o asisa...que tienen ofertas no se puede cambiar el nombre corto porqu� va en empresasespeciales y lo coge para crear OMVM, OVIAM...-->
                <xsl:value-of select="EMP_NOMBRECORTOPUBLICO"/>
                <input type="hidden" name="EMP_NOMBRECORTOPUBLICO" value="{EMP_NOMBRECORTOPUBLICO}"/>
                <input type="hidden" name="EMP_NOMBRECORTOPUBLICO_OLD" value="{EMP_NOMBRECORTOPUBLICO}"/>
        </xsl:when>
        <xsl:otherwise>
                <input type="text" name="EMP_NOMBRECORTOPUBLICO" maxlength="40" size="23" value="{EMP_NOMBRECORTOPUBLICO}"/>
                <input type="hidden" name="EMP_NOMBRECORTOPUBLICO_OLD" value="{EMP_NOMBRECORTOPUBLICO}"/>
        </xsl:otherwise>
        </xsl:choose>
		</td>
               <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_corto_interno']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="datosLeft">
        <xsl:choose>
        <xsl:when test="(NOEDICION or EMPRESA_ESPECIAL_VISIBLE or EMPRESA_ESPECIAL_OCULTA) and EMP_NOMBRECORTOPUBLICO != ''">
                <xsl:value-of select="EMP_NOMBRE_CORTO"/>
                <input type="hidden" name="EMP_NOMBRE_CORTO_OLD" value="{EMP_NOMBRE_CORTO}"/>
                <input type="hidden" name="EMP_NOMBRE_CORTO" value="{EMP_NOMBRE_CORTO}"/>
        </xsl:when>
        <xsl:otherwise>
                <input type="hidden" name="EMP_NOMBRE_CORTO_OLD" value="{EMP_NOMBRE_CORTO}"/>
                <input type="text" name="EMP_NOMBRE_CORTO" maxlength="20" size="15" value="{EMP_NOMBRE_CORTO}"/>
        </xsl:otherwise>
        </xsl:choose>
		</td>
	</tr>

	<tr>
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="datosLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			<xsl:for-each select="//field[@name='EMP_IDTIPO']/dropDownList/listElem">
				<xsl:if test="/MantenimientoEmpresas/form/EMPRESA/EMP_IDTIPO=ID">
					<xsl:value-of select="listItem"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="field_funcion">
				<xsl:with-param name="path" select="//field[@name='EMP_IDTIPO']"/>
				<xsl:with-param name="IDAct" select="EMP_IDTIPO"/>
			</xsl:call-template>
		</xsl:otherwise>
		</xsl:choose>
		</td>
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='nif']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="datosLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			<xsl:value-of select="EMP_NIF"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="text" name="EMP_NIF" maxlength="20" size="20" value="{EMP_NIF}"/>
		</xsl:otherwise>
		</xsl:choose>
			<br />
			<span class="textoComentario">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='formato_recomendado']/node()"/>
			</span>
		</td>
	</tr>

	<tr>
		<td colspan="2" class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='direccion']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td colspan="3" class="datosLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			<xsl:value-of select="EMP_DIRECCION"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="text" name="EMP_DIRECCION" maxlength="100" size="50" value="{EMP_DIRECCION}"/>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>

	<tr>
		<td colspan="2" class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_postal']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="datosLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			<xsl:value-of select="EMP_CPOSTAL"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="text" name="EMP_CPOSTAL" maxlength="20" size="15" value="{EMP_CPOSTAL}"/>
		</xsl:otherwise>
		</xsl:choose>
		</td>
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='poblacion']/node()"/>:<span class="camposObligatorios">*</span></td>
		<td class="datosLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			<xsl:value-of select="EMP_POBLACION"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="text" name="EMP_POBLACION" maxlength="200" size="30" value="{EMP_POBLACION}"/>
		</xsl:otherwise>
		</xsl:choose>
		</td>
	</tr>

	<tr>
    <!--provincia-->
      <td colspan="2" class="labelRight">
        <xsl:value-of select="document($doc)/translation/texts/item[@name='provincia']/node()"/>:<span class="camposObligatorios">*</span>
        </td>
      <td class="datosLeft">
        <xsl:choose>
          <xsl:when test="NOEDICION">
		  	<!--
			<xsl:for-each select="//field[@name='EMP_PROVINCIA']/dropDownList/listElem">
			<xsl:if test="/MantenimientoEmpresas/form/EMPRESA/EMP_PROVINCIA=ID">
			<xsl:value-of select="listItem"/>
			</xsl:if>
			</xsl:for-each>
			-->
          <xsl:value-of select="/MantenimientoEmpresas/form/EMPRESA/EMP_PROVINCIA"/>
          </xsl:when>
          <xsl:otherwise>
          <!--provincias espa�a-->
          	<div id="provincia_34" class="provincias">
            	<xsl:attribute name="style">
                	<xsl:choose>
                	<xsl:when test="PAISES/field/@current = '34'">display:block;</xsl:when>
                    <xsl:otherwise>display:none;</xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
				<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/MantenimientoEmpresas/form/EMPRESA/PROVINCIAS/PROVINCIA_34/field"></xsl:with-param>
                <xsl:with-param name="defecto" select="/MantenimientoEmpresas/form/EMPRESA/EMP_PROVINCIA"/>
				</xsl:call-template>
            </div><!--fin div provincia_34-->

          <!--provincias brasil-->
            <div id="provincia_55" class="provincias">
            	<xsl:attribute name="style">
                	<xsl:choose>
                	<xsl:when test="PAISES/field/@current = '55'">display:block;</xsl:when>
                    <xsl:otherwise>display:none;</xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
				<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/MantenimientoEmpresas/form/EMPRESA/PROVINCIAS/PROVINCIA_55/field"></xsl:with-param>
                <xsl:with-param name="defecto" select="/MantenimientoEmpresas/form/EMPRESA/EMP_PROVINCIA"/>
				</xsl:call-template>
            </div>
           <!--
			<xsl:call-template name="field_funcion">
			<xsl:with-param name="path" select="//field[@name='EMP_PROVINCIA']"/>
			<xsl:with-param name="IDAct" select="EMP_PROVINCIA"/>
			</xsl:call-template>
            -->
          </xsl:otherwise>
        </xsl:choose>
        </td>
        <xsl:choose>
        <xsl:when test="IDPAIS=34">
	        <td colspan="2">&nbsp;<input type="hidden" name="EMP_BARRIO" value="{EMP_BARRIO}"/></td>
		</xsl:when>
		<xsl:otherwise>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='barrio']/node()"/>:
			</td>
			<td class="datosLeft">
				<xsl:choose>
				<xsl:when test="NOEDICION">
					<xsl:value-of select="EMP_BARRIO"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="text" name="EMP_BARRIO" maxlength="50" size="24" value="{EMP_BARRIO}"/>
				</xsl:otherwise>
				</xsl:choose>
			</td>
		</xsl:otherwise>
        </xsl:choose>
    </tr>
    <tr>
      <td colspan="2" class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='telefono']/node()"/>:<span class="camposObligatorios">*</span>
        </td>
      <td class="datosLeft">
        <xsl:choose>
          <xsl:when test="NOEDICION">
            <xsl:value-of select="EMP_TELEFONO"/>
          </xsl:when>
          <xsl:otherwise>
        	<input type="text" name="EMP_TELEFONO" maxlength="50" size="24" value="{EMP_TELEFONO}"/>
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <td class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='fax']/node()"/>:
        </td>
      <td class="datosLeft">
         <xsl:choose>
          <xsl:when test="NOEDICION">
            <xsl:value-of select="EMP_FAX"/>
          </xsl:when>
          <xsl:otherwise>
        <input type="text" name="EMP_FAX" maxlength="50" size="11" value="{EMP_FAX}"/>
          </xsl:otherwise>
        </xsl:choose>

        </td>
    </tr>
    <tr>
    	<td colspan="2" class="labelRight">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='enlace']/node()"/>:
       </td>
       <td class="datosLeft">
        	<input type="text" name="EMP_ENLACE" maxlength="200" size="30">
            	<xsl:attribute name="value">
                	<xsl:choose>
                	<xsl:when test="EMP_ENLACE != ''"><xsl:value-of select="EMP_ENLACE"/></xsl:when>
                    <xsl:otherwise>http://</xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
            </input>
        </td>

        <td class="labelRight">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='estilos']/node()"/>:
		</td>
    	 <td class="datosLeft">
       	<xsl:choose>
        		<xsl:when test="NOEDICION">
					<xsl:for-each select="ESTILOS/field/dropDownList/listElem">
						<xsl:if test="../../@current=ID">
							<xsl:value-of select="listItem"/>
						</xsl:if>
					</xsl:for-each>
        		</xsl:when>
        		<xsl:otherwise>
	   				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="ESTILOS/field"></xsl:with-param>
        			 <xsl:with-param name="defecto" select="ESTILOS/field/@current"></xsl:with-param>
					</xsl:call-template>
    			</xsl:otherwise>
	       	</xsl:choose>
        </td>
    </tr>

	<tr>
		<td colspan="2" class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='logotipo']/node()"/>:</td>
		<td class="datosLeft">
		<xsl:choose>
		<xsl:when test="NOEDICION">
			<xsl:for-each select="LOGOTIPOS/field/dropDownList/listElem">
				<xsl:value-of select="listItem"/>
			<xsl:if test="../../@current = ID"></xsl:if>
			</xsl:for-each>
		</xsl:when>
		<xsl:otherwise>
			<xsl:choose>
			<xsl:when test="LOGOTIPOS/field/dropDownList/listElem">
				<select name="IDLOGOTIPO" id="IDLOGOTIPO">
				<xsl:for-each select="LOGOTIPOS/field/dropDownList/listElem">
					<xsl:choose>
					<xsl:when test="../../@current = ID">
						<option value="{ID}" selected="selected">[<xsl:value-of select="listItem"/>]</option>
					</xsl:when>
					<xsl:otherwise>
						<option value="{ID}"><xsl:value-of select="listItem"/></option>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
				</select>
			</xsl:when>
			<xsl:otherwise>
				<select name="IDLOGOTIPO" id="IDLOGOTIPO"></select>
			</xsl:otherwise>
			</xsl:choose>
		</xsl:otherwise>
		</xsl:choose>
		</td>
		<td colspan="2">&nbsp;</td>
	</tr>

	<!--<tr>
		<td colspan="2" class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='logo']/node()"/>:</td>
		<td class="datosLeft"><input id="DOC_NOMBRE" name="DOC_NOMBRE" type="text"/></td>
		<td colspan="2">&nbsp;</td>
	</tr>-->

	<tr id="cargaLogo">
		<td colspan="2">&nbsp;</td>
		<!--<td class="datosLeft" colspan="2">-->
		<td class="datosLeft">
        	<input type="hidden" name="CADENA_DOCUMENTOS" />
        	<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
            <input type="hidden" name="BORRAR_ANTERIORES"/>
            <input type="hidden" name="ID_USUARIO" value="15886" />
            <input type="hidden" name="TIPO_DOC" value="LOGO"/>
            <input type="hidden" name="DOC_DESCRI" />
            <input type="hidden" name="REMOVE" value="{document($doc)/translation/texts/item[@name='remove']/node()}"/>
			<input type="hidden" name="CHANGE_PROV" />
            <input type="hidden" name="IDPROVEEDOR" value="{EMP_ID}" />
			<!--<xsl:call-template name="image"><xsl:with-param name="num">1</xsl:with-param></xsl:call-template>-->
            <xsl:call-template name="documentos">
            	<xsl:with-param name="num" select="number(1)" />
                <xsl:with-param name="type">LOGO</xsl:with-param>
            </xsl:call-template>
		</td>
		<td colspan="2">&nbsp;</td>
	</tr>
</table>

     <!--otra tabla nuovo modelo negocio-->
     <table class="infoTable">
     <xsl:if test="//MantenimientoEmpresas/ADMINISTRADORMVM='ADMINISTRADORMVM' or EMP_SERVICIOSCDC='S'">
     <xsl:if test="//MantenimientoEmpresas/ADMINISTRADORMVM='ADMINISTRADORMVM'">
     <tr>
      <td class="labelRight veintecinco">
          <xsl:value-of select="document($doc)/translation/texts/item[@name='empresa_externa']/node()"/>:
      </td>
      <td class="cinco">
              <input type="checkbox" name="EMP_EXTERNA_CHK">
                <xsl:choose>
                  <xsl:when test="EMP_EXTERNA='S'">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                  </xsl:otherwise>
                </xsl:choose>
              </input>
            <td class="datosLeft">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='la_empresa_no_esta_afiliada']/node()"/>
            </td>
      </td>
    </tr>
    </xsl:if>
    </xsl:if>
     <!-- hidden con los valores de SERVICIOSCDC, EXTERNA, EMP_PROVNONAVEGAR-->
       <input type="hidden" name="EMP_SERVICIOSCDC">
      <xsl:choose>
        <xsl:when test="EMP_SERVICIOSCDC='S'">
          <xsl:attribute name="value">on</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="value"></xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </input>

    <input type="hidden" name="EMP_EXTERNA">
      <xsl:choose>
        <xsl:when test="EMP_STATUS='E'">
          <xsl:attribute name="value">on</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="value"></xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </input>

    <input type="hidden" name="EMP_OCULTARPRECIOREF">
      <xsl:choose>
        <xsl:when test="EMP_OCULTARPRECIOREF='S'">
          <xsl:attribute name="value">on</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="value"></xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </input>

    <input type="hidden" name="EMP_PRECIOSCONIVA">
      <xsl:choose>
        <xsl:when test="EMP_PRECIOSCONIVA='S'">
          <xsl:attribute name="value">on</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="value"></xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </input>

    <input type="hidden" name="EMP_MOSTRARCOMISIONES_NM">
      <xsl:choose>
        <xsl:when test="EMP_MOSTRARCOMISIONES_NM='S'">
          <xsl:attribute name="value">on</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="value"></xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </input>

    <input type="hidden" name="EMP_BLOQUEARBANDEJA">
      <xsl:choose>
        <xsl:when test="EMP_BLOQUEARBANDEJA='S'">
          <xsl:attribute name="value">on</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="value"></xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </input>

    <input type="hidden" name="EMP_BLOQUEARMUESTRAS">
      <xsl:choose>
        <xsl:when test="EMP_BLOQUEARMUESTRAS='S'">
          <xsl:attribute name="value">on</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="value"></xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </input>

    <input type="hidden" name="EMP_PRECIOSHISTINFORMADOS">
      <xsl:choose>
        <xsl:when test="EMP_PRECIOSHISTINFORMADOS='S'">
          <xsl:attribute name="value">on</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="value"></xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </input>

    <input type="hidden" name="EMP_PRECIOSHISTPORCENTRO">
      <xsl:choose>
        <xsl:when test="EMP_PRECIOSHISTPORCENTRO='S'">
          <xsl:attribute name="value">on</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="value"></xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </input>


    <input type="hidden" name="EMP_PEDIDO_SINCATEGORIAS">
      <xsl:choose>
        <xsl:when test="EMP_PEDIDO_SINCATEGORIAS='S'">
          <xsl:attribute name="value">on</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="value"></xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </input>

    <input type="hidden" name="EMP_SINSEPARARFARMACIA">
      <xsl:choose>
        <xsl:when test="EMP_SINSEPARARFARMACIA='S'">
          <xsl:attribute name="value">on</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="value"></xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </input>

    <input type="hidden" name="EMP_PROVNONAVEGARPORDEFECTO">
      <xsl:choose>
        <xsl:when test="EMP_PROVNONAVEGARPORDEFECTO='S'">
          <xsl:attribute name="value">on</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="value"></xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </input>

    <input type="hidden" name="EMP_PROVNONAVEGAR">
      <xsl:choose>
        <xsl:when test="EMP_PROVNONAVEGAR='S'">
          <xsl:attribute name="value">on</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="value"></xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </input>
      <tr>
      <td class="labelRight" valign="top">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_comercial_empresa']/node()"/>:
      </td>
      <td colspan="2" class="datosLeft">

        <xsl:choose>
          <xsl:when test="NOEDICION">
            <xsl:copy-of select="EMP_REFERENCIAS/node()"/>
          </xsl:when>
          <xsl:otherwise>
        <textarea name="EMP_REFERENCIAS" rows="5" cols="60"><xsl:copy-of select="EMP_REFERENCIAS/node()"/></textarea>
          </xsl:otherwise>
        </xsl:choose>

        </td>
    </tr>

    <input type="hidden" name="EMP_PERMITIRCONTROLPEDIDOS">
      <xsl:choose>
        <xsl:when test="EMP_PERMITIRCONTROLPEDIDOS='S'">
          <xsl:attribute name="value">on</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="value"></xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </input>

    <input type="hidden" name="EMP_LICITACIONESAGREGADAS">
      <xsl:choose>
        <xsl:when test="EMP_LICITACIONESAGREGADAS='S'">
          <xsl:attribute name="value">on</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="value"></xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </input>

    <tr><td colspan="3">&nbsp;</td></tr>
    </table>



   <!--solo para el cliente-->
    <div id="soloCliente">
      <xsl:attribute name="style">
            	<xsl:choose>
                <xsl:when test="/MantenimientoEmpresas/form/EMPRESA/ROL='VENDEDOR'">display:none;</xsl:when>
                <xsl:when test="/MantenimientoEmpresas/form/EMPRESA/ROL='COMPRADOR'">display:;</xsl:when>
                </xsl:choose>
      </xsl:attribute>
    <table class="infoTable">
           <tr class="tituloTabla">
                  <th colspan="4">
                   <xsl:value-of select="document($doc)/translation/texts/item[@name='opciones_especificas_clientes']/node()"/>
                  </th>
          </tr>
    	 <tr>
      <td class="labelRight veintecinco">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='comision_ahorro']/node()"/>:
       </td>
       <td class="datosLeft veinte">
        	<xsl:choose>
        	  <xsl:when test="NOEDICION">
            	<xsl:value-of select="EMP_COMISION_AHORRO"/>
        	  </xsl:when>
        	  <xsl:otherwise>
        	<input type="text" name="EMP_COMISION_AHORRO" maxlength="5" size="5" value="{EMP_COMISION_AHORRO}"/>
        	  </xsl:otherwise>
        	</xsl:choose>
        </td>
          <td class="labelRight veinte">
          <xsl:value-of select="document($doc)/translation/texts/item[@name='comision_transacciones']/node()"/>:
       </td>
        <td class="datosLeft">
        	<xsl:choose>
        	  <xsl:when test="NOEDICION">
            	<xsl:value-of select="EMP_COMISION_TRANSACCIONES"/>
        	  </xsl:when>
        	  <xsl:otherwise>
        	<input type="text" name="EMP_COMISION_TRANSACCIONES" maxlength="5" size="5" value="{EMP_COMISION_TRANSACCIONES}"/>
        	  </xsl:otherwise>
        	</xsl:choose>
        </td>
    </tr>
     <!--<tr>
	    <td class="labelRight">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='responsable_muestras']/node()"/>:
        </td>
        <td class="datosLeft">
			<xsl:choose>
				<xsl:when test="NOEDICION">
					<xsl:for-each select="//field[@name='EMP_IDUSUARIOMUESTRAS']/dropDownList/listElem">
						<xsl:if test="../../../field[@name='EMP_IDUSUARIOMUESTRAS']/SelectedElement=ID">
							<xsl:value-of select="listItem"/>
						</xsl:if>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="field[@name='EMP_IDUSUARIOMUESTRAS']"/>
					<xsl:with-param name="defecto" select="field[@name='EMP_IDUSUARIOMUESTRAS']/SelectedElement"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</td>
        <td colspan="2">&nbsp;</td>
    </tr>  -->
    </table>

    <!--otra tabla nuovo modelo negocio-->
   <table class="infoTable" border="0" >
     <xsl:if test="//MantenimientoEmpresas/ADMINISTRADORMVM='ADMINISTRADORMVM' or EMP_SERVICIOSCDC='S'">
    <xsl:if test="//MantenimientoEmpresas/ADMINISTRADORMVM='ADMINISTRADORMVM'">
<!-- DC - 15/05/14 - Se oculta las siguientes 3 filas para Brasil -->
<xsl:if test="/MantenimientoEmpresas/form/EMPRESA/EMP_IDPAIS = '34'">
      <tr>
      <td class="labelRight veintecinco">
          <xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_modelo_negocio']/node()"/>:
          </td>
      <td class="cinco">
              <input type="checkbox" id="OcultarPrecioRef_Chk" name="EMP_OCULTARPRECIOREF_CHK" onclick="javascript:OcultarPrecioReferencia_Click();">
                <xsl:choose>
                  <xsl:when test="EMP_OCULTARPRECIOREF='S'">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                  </xsl:otherwise>
                </xsl:choose>
              </input>
      </td>
      <td class="datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='ocultar_precios_referencia']/node()"/>
      </td>
    </tr>

      <tr>
      <td class="labelRight veinte">
          <xsl:value-of select="document($doc)/translation/texts/item[@name='mostrar_precios_conIVA']/node()"/>:
          </td>
      <td class="cinco">
              <input type="checkbox" name="EMP_PRECIOSCONIVA_CHK" id="PreciosConIVA_Chk">
                <xsl:choose>
                  <xsl:when test="EMP_PRECIOSCONIVA='S'">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                  </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="EMP_OCULTARPRECIOREF='S'">
                    <xsl:attribute name="disabled">disabled</xsl:attribute>
                </xsl:if>
              </input>
      </td>
      <td class="datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='IVA_en_pedidos_y_buscadores']/node()"/>
      </td>
    </tr>

    <tr>
      <td class="labelRight">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir_pedido_ampliado']/node()"/>
      </td>
      <td class="cinco">
              <input type="checkbox" name="EMP_MOSTRARCOMISIONES_NM_CHK">
                <xsl:choose>
                  <xsl:when test="EMP_MOSTRARCOMISIONES_NM='S'">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                  </xsl:otherwise>
                </xsl:choose>
              </input>

      </td>
       <td class="datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='mostrar_iva_y_comisiones']/node()"/>
      </td>
    </tr>
</xsl:if>
    <tr>
      <td class="labelRight">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='central_de_compras']/node()"/>
      </td>
      <td>
              <input type="checkbox" name="EMP_SERVICIOSCDC_CHK" onClick="habilitarDeshabiliarDesplegables(this,document.forms['MantenEmpresa'],new Array('ID_RESP_CAT','ID_RESP_EVAL','ID_RESP_INC','ID_RESP_NEG'));">
                <xsl:choose>
                  <xsl:when test="EMP_SERVICIOSCDC='S'">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                  </xsl:otherwise>
                </xsl:choose>
              </input>
        </td>
         <td class="datosLeft">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='la_empresa_costituye_una_central']/node()"/>
      </td>
    </tr>
    <tr>
      <td class="labelRight">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='cat_priv_utilizar_categorias']/node()"/>
      </td>
      <td class="cinco">
              <input type="checkbox" name="EMP_CATPRIV_CATEGORIAS">
                <xsl:choose>
                  <xsl:when test="EMP_CATPRIV_CATEGORIAS='S'">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                  </xsl:otherwise>
                </xsl:choose>
              </input>

      </td>
       <td class="datosLeft">
       	<xsl:value-of select="document($doc)/translation/texts/item[@name='cat_priv_utilizar_categorias_expli']/node()"/>
      </td>
    </tr>
    <tr>
      <td class="labelRight">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='cat_priv_utilizar_grupos']/node()"/>
      </td>
      <td class="cinco">
              <input type="checkbox" name="EMP_CATPRIV_GRUPOS">
                <xsl:choose>
                  <xsl:when test="EMP_CATPRIV_GRUPOS='S'">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                  </xsl:otherwise>
                </xsl:choose>
              </input>
      </td>
       <td class="datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='cat_priv_utilizar_grupos_expli']/node()"/>
      </td>
    </tr>
     <tr>
      <td class="labelRight">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='cat_priv_catalogovisible']/node()"/>
      </td>
      <td class="cinco">
              <input type="checkbox" name="EMP_CATALOGOVISIBLE">
                <xsl:choose>
                  <xsl:when test="EMP_CATALOGOVISIBLE='S'">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                  </xsl:otherwise>
                </xsl:choose>
              </input>
      </td>
       <td class="datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='cat_priv_catalogovisible_expli']/node()"/>
      </td>
    </tr>
     <tr>
      <td class="labelRight">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='cat_priv_ref_prov_pedidosfarmacia']/node()"/>
      </td>
      <td class="cinco">
              <input type="checkbox" name="EMP_FARMACIA_REFPROV">
                <xsl:choose>
                  <xsl:when test="EMP_FARMACIA_REFPROV='S'">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                  </xsl:otherwise>
                </xsl:choose>
              </input>
      </td>
		<td class="datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='cat_priv_ref_prov_pedidosfarmacia_expli']/node()"/>
      </td>
    </tr>
    <tr>
           <td class="labelRight">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='se_permite_muestras']/node()"/>:
           </td>
            <td class="cinco">
               	   <xsl:choose>
                      <xsl:when test="EMP_BLOQUEARMUESTRAS='S'">
                       <input type="checkbox" checked="checked" name="EMP_BLOQUEARMUESTRAS_CHK_CL" />
                     </xsl:when>
                     <xsl:otherwise>
                       <input type="checkbox" name="EMP_BLOQUEARMUESTRAS_CHK_CL" />
                     </xsl:otherwise>
                   </xsl:choose>
            </td>
        	<td class="datosLeft">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='el_cliente_puede_pedir_muestras']/node()"/>.
           </td>
     </tr>
     <tr>
           <td class="labelRight">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ref_informado']/node()"/>:
           </td>
            <td class="cinco">
               	   <xsl:choose>
                      <xsl:when test="EMP_PRECIOSHISTINFORMADOS='S'">
                       <input type="checkbox" checked="checked" name="EMP_PRECIOSHISTINFORMADOS_CHK" />
                     </xsl:when>
                     <xsl:otherwise>
                       <input type="checkbox" name="EMP_PRECIOSHISTINFORMADOS_CHK" />
                     </xsl:otherwise>
                   </xsl:choose>
            </td>
        	<td class="datosLeft">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ref_informado_expli']/node()"/>.
           </td>
     </tr>
     <tr>
           <td class="labelRight">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='precio_historico_por_centro']/node()"/>:
           </td>
            <td class="cinco">
               	   <xsl:choose>
                      <xsl:when test="EMP_PRECIOSHISTPORCENTRO='S'">
                       <input type="checkbox" checked="checked" name="EMP_PRECIOSHISTPORCENTRO_CHK" />
                     </xsl:when>
                     <xsl:otherwise>
                       <input type="checkbox" name="EMP_PRECIOSHISTPORCENTRO_CHK" />
                     </xsl:otherwise>
                   </xsl:choose>
            </td>
        	<td class="datosLeft">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_historico_por_centro_expli']/node()"/>.
           </td>
     </tr>
     <tr>
           <td class="labelRight">
           <!-- Pedido sin categor�as:--><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_sin_categorias']/node()"/>:
           </td>
            <td class="cinco">
               	   <xsl:choose>
                      <xsl:when test="EMP_PEDIDO_SINCATEGORIAS='S'">
                       <input type="checkbox" checked="checked" name="EMP_PEDIDO_SINCATEGORIAS_CHK" />
                     </xsl:when>
                     <xsl:otherwise>
                       <input type="checkbox" name="EMP_PEDIDO_SINCATEGORIAS_CHK" />
                     </xsl:otherwise>
                   </xsl:choose>
            </td>
        	<td class="datosLeft">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_sin_categorias_expli']/node()"/>.
			<!--En el primer paso del pedido las l�neas no se mostrar�n ordenadas segun subfamilia-->
           </td>
     </tr>
     <tr>
           <td class="labelRight">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='sin_pestanna_farmacia']/node()"/>:
			<!--Sin pesta�as de Farmacia/Fungible:-->
           </td>
            <td class="cinco">
               	   <xsl:choose>
                      <xsl:when test="EMP_SINSEPARARFARMACIA='S'">
                       <input type="checkbox" checked="checked" name="EMP_SINSEPARARFARMACIA_CHK" />
                     </xsl:when>
                     <xsl:otherwise>
                       <input type="checkbox" name="EMP_SINSEPARARFARMACIA_CHK" />
                     </xsl:otherwise>
                   </xsl:choose>
            </td>
        	<td class="datosLeft">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_pestanna_farmacia_expli']/node()"/>.
			<!--En "Enviar pedidos" las plantillas/proveedores no se separar�n por farmacia o fungible-->
           </td>
     </tr>
     <tr>
           <td class="labelRight">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_agregadas']/node()"/>:
			<!--Permitir licitaciones agregadas a los centros que forman parte de la empresa-->
           </td>
            <td class="cinco">
               	   <xsl:choose>
                      <xsl:when test="EMP_LICITACIONESAGREGADAS='S'">
                       <input type="checkbox" checked="checked" name="EMP_LICITACIONESAGREGADAS_CHK" />
                     </xsl:when>
                     <xsl:otherwise>
                       <input type="checkbox" name="EMP_LICITACIONESAGREGADAS_CHK" />
                     </xsl:otherwise>
                   </xsl:choose>
            </td>
        	<td class="datosLeft">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_agregadas_expli']/node()"/>.
			<!--En "Enviar pedidos" las plantillas/proveedores no se separar�n por farmacia o fungible-->
           </td>
     </tr>
     <tr>
           <td class="labelRight">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='permitir_control_pedidos']/node()"/>:
			<!--Sin pesta�as de Farmacia/Fungible:-->
           </td>
            <td class="cinco">
               	   <xsl:choose>
                      <xsl:when test="EMP_PERMITIRCONTROLPEDIDOS='S'">
                       <input type="checkbox" checked="checked" name="EMP_PERMITIRCONTROLPEDIDOS_CHK" />
                     </xsl:when>
                     <xsl:otherwise>
                       <input type="checkbox" name="EMP_PERMITIRCONTROLPEDIDOS_CHK" />
                     </xsl:otherwise>
                   </xsl:choose>
            </td>
        	<td class="datosLeft">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='permitir_control_pedidos_expli']/node()"/>.
			<!--En "Enviar pedidos" las plantillas/proveedores no se separar�n por farmacia o fungible-->
           </td>
     </tr>
     <tr>
           <td class="labelRight">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_catalogacion']/node()"/>:
           </td>
            <td class="cinco">
               	   <xsl:choose>
                      <xsl:when test="EMP_SOLICITUDCATALOGACION='S'">
                       <input type="checkbox" checked="checked" name="EMP_SOLICITUDCATALOGACION" />
                     </xsl:when>
                     <xsl:otherwise>
                       <input type="checkbox" name="EMP_SOLICITUDCATALOGACION" />
                     </xsl:otherwise>
                   </xsl:choose>
            </td>
        	<td class="datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitudes_catalogacion_expli']/node()"/>.</td>
     </tr>
     <xsl:if test="/MantenimientoEmpresas/form/EMPRESA/ROL='COMPRADOR'"><!--enviar pdf solo para clientes porqu� tb en lado proveedores hay-->
      <tr style="background:#F3F781;">
           <td class="labelRight">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_pdf']/node()"/>:
           </td>
            <td class="cinco">
               	   <xsl:choose>
                      <xsl:when test="EMP_ENVIARPDF='S'">
                       <input type="checkbox" checked="checked" name="EMP_ENVIARPDF" />
                     </xsl:when>
                     <xsl:otherwise>
                       <input type="checkbox" name="EMP_ENVIARPDF" />
                     </xsl:otherwise>
                   </xsl:choose>
            </td>
        	<td class="datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_pdf_expli_cliente']/node()"/></td>
     </tr>
     </xsl:if>

     <tr>
           <td class="labelRight">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='seguimiento']/node()"/>:
           </td>
            <td class="cinco">
               	   <xsl:choose>
                      <xsl:when test="EMP_SEGUIMIENTO='S'">
                       <input type="checkbox" checked="checked" name="EMP_SEGUIMIENTO" />
                     </xsl:when>
                     <xsl:otherwise>
                       <input type="checkbox" name="EMP_SEGUIMIENTO" />
                     </xsl:otherwise>
                   </xsl:choose>
            </td>
        	<td class="datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='seguimiento_expli']/node()"/></td>
     </tr>
     <tr>
           <td style="font-weight:bold;text-align:left;color:#6D6E6F;" colspan="3">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <xsl:value-of select="document($doc)/translation/texts/item[@name='potencial_compra_mensual']/node()"/>:&nbsp;
                <input type="text" name="EMP_POTENCIAL_COMPRAS" maxlength="8" size="7" value="{EMP_POTENCIAL_COMPRASMENSUALES}"/>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <xsl:value-of select="document($doc)/translation/texts/item[@name='potencial_catalogo']/node()"/>:&nbsp;
                <input type="text" name="EMP_POTENCIAL_CATALOGO" maxlength="8" size="7" value="{EMP_POTENCIAL_CATALOGO}"/>
           </td>
     </tr>

    <tr>
        <td class="labelRight">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='empresa_especial']/node()"/>:
        </td>
        <td class="datosLeft" colspan="2" style="padding-left:25px;">
            <xsl:choose>
            <xsl:when test="EMPRESA_ESPECIAL_VISIBLE">
        	<span style="float:left;padding-top:5px;" id="TextoEmpEspecial"><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa_especial_activa']/node()"/>&nbsp;</span>
                <div class="boton">
                    <a href="javascript:DesactivarEmpresaEspecial({EMP_ID});" id="AccionEmpEspecial">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='ocultar']/node()"/>
                    </a>
                </div>
            </xsl:when>
            <xsl:when test="EMPRESA_ESPECIAL_OCULTA">
        	<span style="float:left;padding-top:5px;" id="TextoEmpEspecial"><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa_especial_inactiva']/node()"/>&nbsp;</span>
                <div class="boton">
                    <a href="javascript:ActivarEmpresaEspecial({EMP_ID});" id="AccionEmpEspecial">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='mostrar']/node()"/>
                    </a>
                </div>
            </xsl:when>
            <xsl:otherwise>
        	<span style="float:left;padding-top:5px;" id="TextoEmpEspecial"><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa_especial_insertar']/node()"/>&nbsp;</span>
                <div class="boton">
                    <a href="javascript:IncluirEmpresaEspecial({EMP_ID});" id="AccionEmpEspecial">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir']/node()"/>
                    </a>
                </div>
            </xsl:otherwise>
            </xsl:choose>
        </td>
     </tr>
      <tr>
            <td class="labelRight">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='responsable_incidencias']/node()"/>:<span class="camposObligatorios">*</span>
            </td>
            <td class="datosLeft" colspan="2">
      		<xsl:choose>
				<xsl:when test="NOEDICION">
					<xsl:for-each select="//field[@name='EMP_IDUSUARIORECLAMACIONES']/dropDownList/listElem">
						<xsl:if test="../../../field[@name='EMP_IDUSUARIORECLAMACIONES']/SelectedElement=ID">
							<xsl:value-of select="listItem"/>
						</xsl:if>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
                                    <select name="EMP_IDUSUARIORECLAMACIONES_CLIENTE" id="EMP_IDUSUARIORECLAMACIONES_CLIENTE">
                                        <xsl:for-each select="//field[@name='EMP_IDUSUARIORECLAMACIONES']/dropDownList/listElem">
                                            <xsl:choose>
                                            <xsl:when test="../../../field[@name='EMP_IDUSUARIORECLAMACIONES']/SelectedElement=ID">
                                                <option value="{ID}" selected="selected"><xsl:value-of select="listItem" /></option>
                                            </xsl:when>
                                            <xsl:otherwise><option value="{ID}"><xsl:value-of select="listItem" /></option></xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:for-each>
                                    </select>
				</xsl:otherwise>
			</xsl:choose>
                        &nbsp;
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='responsable_incidencias_cliente']/node()"/>
            </td>
        </tr>


    </xsl:if>
       <!--
    <tr>
      <td class="labelRight" colspan="2">
          <xsl:choose>
          <xsl:when test="NOEDICION">
            <xsl:for-each select="//field[@name='ID_RESP_CAT']/dropDownList/listElem">
              <xsl:if test="../../@current=ID">
                <xsl:value-of select="listItem"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
          <xsl:variable name="vDeshabilitado"><xsl:if test="EMP_SERVICIOSCDC!='S'">deshabilitado</xsl:if></xsl:variable>
              <xsl:call-template name="field_funcion">
                <xsl:with-param name="path" select="field[@name='ID_RESP_CAT']"/>
                <xsl:with-param name="IDAct" select="field[@name='ID_RESP_CAT']/@current"/>
                <xsl:with-param name="deshabilitado" select="$vDeshabilitado"/>
              </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>

      </td>
      <td class="datosLeft">
        Responsable de la Comisi�n del Cat�logo de la CdC
      </td>
    </tr>
    <tr>
      <td class="labelRight" colspan="2">
          <xsl:choose>
          <xsl:when test="NOEDICION">
            <xsl:for-each select="//field[@name='ID_RESP_EVAL']/dropDownList/listElem">
              <xsl:if test="../../@current=ID">
                <xsl:value-of select="listItem"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
          <xsl:variable name="vDeshabilitado"><xsl:if test="EMP_SERVICIOSCDC!='S'">deshabilitado</xsl:if></xsl:variable>
              <xsl:call-template name="field_funcion">
                <xsl:with-param name="path" select="field[@name='ID_RESP_EVAL']"/>
                <xsl:with-param name="IDAct" select="field[@name='ID_RESP_EVAL']/@current"/>
                <xsl:with-param name="deshabilitado" select="$vDeshabilitado"/>
              </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <td class="datosLeft">
         Responsable de la Comisi�n de Evaluaci�n de la CdC
      </td>
    </tr>
    <tr>
      <td class="labelRight" colspan="2">
         <xsl:choose>
          <xsl:when test="NOEDICION">
            <xsl:for-each select="//field[@name='ID_RESP_INC']/dropDownList/listElem">
              <xsl:if test="../../@current=ID">
                <xsl:value-of select="listItem"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
         <xsl:variable name="vDeshabilitado"><xsl:if test="EMP_SERVICIOSCDC!='S'">deshabilitado</xsl:if></xsl:variable>
              <xsl:call-template name="field_funcion">
                <xsl:with-param name="path" select="field[@name='ID_RESP_INC']"/>
                <xsl:with-param name="IDAct" select="field[@name='ID_RESP_INC']/@current"/>
                <xsl:with-param name="deshabilitado" select="$vDeshabilitado"/>
              </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <td class="datosLeft">
          Responsable de la Comisi�n de Incidencias de la CdC
      </td>
    </tr>
    <tr>
      <td class="labelRight" colspan="2">
          <xsl:choose>
          <xsl:when test="NOEDICION">
            <xsl:for-each select="//field[@name='ID_RESP_NEG']/dropDownList/listElem">
              <xsl:if test="../../@current=ID">
                <xsl:value-of select="listItem"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
              <xsl:variable name="vDeshabilitado"><xsl:if test="EMP_SERVICIOSCDC!='S'">deshabilitado</xsl:if></xsl:variable>
              <xsl:call-template name="field_funcion">
                <xsl:with-param name="path" select="field[@name='ID_RESP_NEG']"/>
                <xsl:with-param name="IDAct" select="field[@name='ID_RESP_NEG']/@current"/>
                <xsl:with-param name="deshabilitado" select="$vDeshabilitado"/>
              </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <td class="datosLeft">
        Responsable del Comisi�n de Negociaci�n de la CdC
      </td>
    </tr>
    -->
    </xsl:if>

     <tr><td colspan="3">&nbsp;</td></tr>
     </table><!--fin de infoTable datos empresa-->

     <!-- Tabla CLiente para las licitaciones -->
        <table class="infoTable">
        <thead>
          <tr class="tituloTabla">
                  <th colspan="4">
                   <xsl:value-of select="document($doc)/translation/texts/item[@name='datos_por_defecto_licitaciones']/node()"/>
                  </th>
          </tr>
          </thead>

          <tbody>
              <xsl:choose>
                <xsl:when test="/MantenimientoEmpresas/form/EMPRESA/ROL='COMPRADOR'">

               <tr>
                   <td>&nbsp;</td>
                   <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:<span class="camposObligatorios">*</span>
                    </td>
                    <td class="datosLeft">
                                    <xsl:choose>
                                            <xsl:when test="NOEDICION">
                                                    <xsl:for-each select="//field[@name='EMP_IDUSUARIOLICITACIONESAUT']/dropDownList/listElem">
                                                            <xsl:if test="../../../field[@name='EMP_IDUSUARIOLICITACIONESAUT']/SelectedElement=ID">
                                                                    <xsl:value-of select="listItem"/>
                                                            </xsl:if>
                                                    </xsl:for-each>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                    <xsl:call-template name="desplegable">
                                                    <xsl:with-param name="path" select="field[@name='EMP_IDUSUARIOLICITACIONESAUT']"/>
                                                    <xsl:with-param name="defecto" select="field[@name='EMP_IDUSUARIOLICITACIONESAUT']/SelectedElement"/>
                                                    </xsl:call-template>
                                            </xsl:otherwise>
                                    </xsl:choose>

                    </td>
                    <td>&nbsp;</td>
              </tr>
                </xsl:when>
              <xsl:when test="/MantenimientoEmpresas/form/EMPRESA/ROL='VENDEDOR'">
                  <input type="text" name="EMP_IDUSUARIOLICITACIONESAUT" id="EMP_IDUSUARIOLICITACIONESAUT" value="" />
              </xsl:when>
              </xsl:choose>
              <tr>
                <td>&nbsp;</td>
                <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>:</td>
                <td class="datosLeft"><input type="text" name="EMP_LIC_TITULO" value="{EMP_LIC_TITULO}" size="63"/></td>
                <td>&nbsp;</td>
              </tr>
               <tr>
                <td>&nbsp;</td>
                <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</td>
                <td class="datosLeft"><textarea name="EMP_LIC_DESCRIPCION" rows="3" cols="60"><xsl:value-of select="EMP_LIC_DESCRIPCION"/></textarea></td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_entrega']/node()"/>:</td>
                <td class="datosLeft"><textarea name="EMP_LIC_COND_ENTREGA" rows="3" cols="60"><xsl:value-of select="EMP_LIC_CONDICIONESENTREGA"/></textarea></td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_pago']/node()"/>:</td>
                <td class="datosLeft"><textarea name="EMP_LIC_COND_PAGO" rows="3" cols="60"><xsl:value-of select="EMP_LIC_CONDICIONESPAGO"/></textarea></td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_otras']/node()"/>:</td>
                <td class="datosLeft"><textarea name="EMP_LIC_OTRAS_COND" rows="3" cols="60"><xsl:value-of select="EMP_LIC_OTRASCONDICIONES"/></textarea></td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='meses_duracion']/node()"/>:</td>
                <td class="datosLeft">
                    <xsl:call-template name="desplegable">
                    <xsl:with-param name="path" select="EMP_LIC_PLAZO_NEG/field"/>
                    <xsl:with-param name="defecto" select="EMP_LIC_PLAZO_NEG/field/@current"/>
                    <!--<xsl:with-param name="claSel">select200</xsl:with-param>-->
                    </xsl:call-template>
				<!--
				<select name="EMP_LIC_PLAZO_NEG" id="EMP_LIC_PLAZO_NEG">
					<option value="0"><xsl:value-of select="document($doc)/translation/texts/item[@name='lic_pedido_puntual']/node()"/></option>
					<option value="1">1 <xsl:value-of select="document($doc)/translation/texts/item[@name='mes']/node()"/></option>
					<option value="2">2 <xsl:value-of select="document($doc)/translation/texts/item[@name='meses']/node()"/></option>
					<option value="3">3 <xsl:value-of select="document($doc)/translation/texts/item[@name='meses']/node()"/></option>
					<option value="4">4 <xsl:value-of select="document($doc)/translation/texts/item[@name='meses']/node()"/></option>
					<option value="5">5 <xsl:value-of select="document($doc)/translation/texts/item[@name='meses']/node()"/></option>
					<option value="6">6 <xsl:value-of select="document($doc)/translation/texts/item[@name='meses']/node()"/></option>
					<option value="12">12 <xsl:value-of select="document($doc)/translation/texts/item[@name='meses']/node()"/></option>
					<option value="18">18 <xsl:value-of select="document($doc)/translation/texts/item[@name='meses']/node()"/></option>
					<option value="24">24 <xsl:value-of select="document($doc)/translation/texts/item[@name='meses']/node()"/></option>
				</select>
				-->
                </td>
                <td>&nbsp;</td>
              </tr>

          </tbody>
          <tr><td colspan="4">&nbsp;</td></tr>
       </table>
   </div><!--fin div cliente-->


    <!--solo para el proveedor-->
    <div id="soloProveedor">
     <xsl:attribute name="style">
            	<xsl:choose>
                <xsl:when test="/MantenimientoEmpresas/form/EMPRESA/ROL='VENDEDOR'">display:;</xsl:when>
                <xsl:when test="/MantenimientoEmpresas/form/EMPRESA/ROL='COMPRADOR'">display:none;</xsl:when>
                </xsl:choose>
      </xsl:attribute>
    <table class="infoTable">
        <tr class="tituloTabla">
                  <th colspan="4">
                   <xsl:value-of select="document($doc)/translation/texts/item[@name='opciones_especificas_proveedores']/node()"/>
                  </th>
          </tr>
     <tr>
        <td class="labelRight veintecinco">
        <xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/>:
       </td>
         <td class="datosLeft veinte">
        	<xsl:choose>
        	  <xsl:when test="NOEDICION">
            	<xsl:value-of select="EMP_PLAZOENTREGA"/>
        	  </xsl:when>
        	  <xsl:otherwise>
        	<input type="text" name="EMP_PLAZOENTREGA" maxlength="2" size="2" value="{EMP_PLAZOENTREGA}"/>
        	  </xsl:otherwise>
        	</xsl:choose>
        </td>
       <td class="labelRight veinte">
       <xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_envio']/node()"/>:
       </td>
         <td class="datosLeft">
        	<xsl:choose>
        	  <xsl:when test="NOEDICION">
            	<xsl:value-of select="EMP_PLAZOENVIO"/>
        	  </xsl:when>
        	  <xsl:otherwise>
        	<input type="text" name="EMP_PLAZOENVIO" maxlength="2" size="2" value="{EMP_PLAZOENVIO}"/>
        	  </xsl:otherwise>
        	</xsl:choose>
        </td>
    </tr>
	<tr>
	    <td class="labelRight">
        <xsl:value-of select="document($doc)/translation/texts/item[@name='comercial_principal']/node()"/>:<span class="camposObligatorios">*</span>
        </td>
        <td class="datosLeft">

			<xsl:choose>
				<xsl:when test="NOEDICION">
					<xsl:for-each select="//field[@name='EMP_COMERCIAL_DEFECTO']/dropDownList/listElem">
						<xsl:if test="../../../field[@name='EMP_COMERCIAL_DEFECTO']/SelectedElement=ID">
							<xsl:value-of select="listItem"/>
						</xsl:if>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="field[@name='EMP_COMERCIAL_DEFECTO']"/>
					<xsl:with-param name="defecto" select="field[@name='EMP_COMERCIAL_DEFECTO']/SelectedElement"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>

	</td>
        <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
	    <td class="labelRight">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='responsable_muestras']/node()"/>:
        </td>
        <td class="datosLeft">
			<xsl:choose>
				<xsl:when test="NOEDICION">
					<xsl:for-each select="//field[@name='EMP_IDUSUARIOMUESTRAS']/dropDownList/listElem">
						<xsl:if test="../../../field[@name='EMP_IDUSUARIOMUESTRAS']/SelectedElement=ID">
							<xsl:value-of select="listItem"/>
						</xsl:if>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="field[@name='EMP_IDUSUARIOMUESTRAS']"/>
					<xsl:with-param name="defecto" select="field[@name='EMP_IDUSUARIOMUESTRAS']/SelectedElement"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</td>
        <td colspan="2">&nbsp;</td>
    </tr>
     <tr>
      <td class="labelRight">
          <xsl:value-of select="document($doc)/translation/texts/item[@name='responsable_incidencias']/node()"/>:<span class="camposObligatorios">*</span>
      </td>
      <td class="datosLeft" colspan="2">
      		<xsl:choose>
				<xsl:when test="NOEDICION">
					<xsl:for-each select="//field[@name='EMP_IDUSUARIORECLAMACIONES']/dropDownList/listElem">
						<xsl:if test="../../../field[@name='EMP_IDUSUARIORECLAMACIONES']/SelectedElement=ID">
							<xsl:value-of select="listItem"/>
						</xsl:if>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					 <select name="EMP_IDUSUARIORECLAMACIONES_PROVE" id="EMP_IDUSUARIORECLAMACIONES_PROVE">
                                        <xsl:for-each select="//field[@name='EMP_IDUSUARIORECLAMACIONES']/dropDownList/listElem">
                                            <xsl:choose>
                                            <xsl:when test="../../../field[@name='EMP_IDUSUARIORECLAMACIONES']/SelectedElement=ID">
                                                <option value="{ID}" selected="selected"><xsl:value-of select="listItem" /></option>
                                            </xsl:when>
                                            <xsl:otherwise><option value="{ID}"><xsl:value-of select="listItem" /></option></xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:for-each>
                                    </select>
				</xsl:otherwise>
			</xsl:choose>

      </td>
    </tr>
    </table>


    <table class="infoTable">
      <xsl:if test="//MantenimientoEmpresas/ADMINISTRADORMVM='ADMINISTRADORMVM' or EMP_SERVICIOSCDC='S'">
    <xsl:if test="//MantenimientoEmpresas/ADMINISTRADORMVM='ADMINISTRADORMVM'">
    <tr>
      <td class="labelRight veintecinco">
      	 <xsl:value-of select="document($doc)/translation/texts/item[@name='bloquear_bandeja']/node()"/>:
         </td>
      <td class="cinco">

              <input type="checkbox" name="EMP_BLOQUEARBANDEJA_CHK">
                <xsl:choose>
                  <xsl:when test="EMP_BLOQUEARBANDEJA='S'">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                  </xsl:otherwise>
                </xsl:choose>
              </input>
         </td>
         <td class="datosLeft">
         <xsl:value-of select="document($doc)/translation/texts/item[@name='la_empresa_es_proveedor']/node()"/>

      </td>
    </tr>
<!--
    <tr>
      <td class="labelRight">
         Central de Compras:
      </td>
      <td>
               <input type="checkbox" name="EMP_SERVICIOSCDC_CHK" onClick="habilitarDeshabiliarDesplegables(this,document.forms['MantenEmpresa'],new Array('ID_RESP_CAT','ID_RESP_EVAL','ID_RESP_INC','ID_RESP_NEG'));">
                <xsl:choose>
                  <xsl:when test="EMP_SERVICIOSCDC='S'">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                  </xsl:otherwise>
                </xsl:choose>
              </input>
              </td>
              <td class="datosLeft">
              La empresa constituye una Central de Compras y sus usuarios tienen acceso a los men�s avanzados: Cat�logo Privado, Evaluaci�n de Productos, etc.

      </td>
    </tr>-->
    </xsl:if>

   <!--
    <tr>
      <td class="labelRight" colspan="2">
          <xsl:choose>
          <xsl:when test="NOEDICION">
            <xsl:for-each select="//field[@name='ID_RESP_CAT']/dropDownList/listElem">
              <xsl:if test="../../@current=ID">
                <xsl:value-of select="listItem"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
          <xsl:variable name="vDeshabilitado"><xsl:if test="EMP_SERVICIOSCDC!='S'">deshabilitado</xsl:if></xsl:variable>
              <xsl:call-template name="field_funcion">
                <xsl:with-param name="path" select="field[@name='ID_RESP_CAT']"/>
                <xsl:with-param name="IDAct" select="field[@name='ID_RESP_CAT']/@current"/>
                <xsl:with-param name="deshabilitado" select="$vDeshabilitado"/>
              </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>

      </td>
      <td class="datosLeft">
        Responsable de la Comisi�n del Cat�logo de la CdC
      </td>
    </tr>
    <tr>
      <td class="labelRight" colspan="2">
          <xsl:choose>
          <xsl:when test="NOEDICION">
            <xsl:for-each select="//field[@name='ID_RESP_EVAL']/dropDownList/listElem">
              <xsl:if test="../../@current=ID">
                <xsl:value-of select="listItem"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
          <xsl:variable name="vDeshabilitado"><xsl:if test="EMP_SERVICIOSCDC!='S'">deshabilitado</xsl:if></xsl:variable>
              <xsl:call-template name="field_funcion">
                <xsl:with-param name="path" select="field[@name='ID_RESP_EVAL']"/>
                <xsl:with-param name="IDAct" select="field[@name='ID_RESP_EVAL']/@current"/>
                <xsl:with-param name="deshabilitado" select="$vDeshabilitado"/>
              </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <td class="datosLeft">
         Responsable de la Comisi�n de Evaluaci�n de la CdC
      </td>
    </tr>
    <tr>
      <td class="labelRight" colspan="2">
         <xsl:choose>
          <xsl:when test="NOEDICION">
            <xsl:for-each select="//field[@name='ID_RESP_INC']/dropDownList/listElem">
              <xsl:if test="../../@current=ID">
                <xsl:value-of select="listItem"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
         <xsl:variable name="vDeshabilitado"><xsl:if test="EMP_SERVICIOSCDC!='S'">deshabilitado</xsl:if></xsl:variable>
              <xsl:call-template name="field_funcion">
                <xsl:with-param name="path" select="field[@name='ID_RESP_INC']"/>
                <xsl:with-param name="IDAct" select="field[@name='ID_RESP_INC']/@current"/>
                <xsl:with-param name="deshabilitado" select="$vDeshabilitado"/>
              </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <td class="datosLeft">
          Responsable de la Comisi�n de Incidencias de la CdC
      </td>
    </tr>
    <tr>
      <td class="labelRight" colspan="2">
          <xsl:choose>
          <xsl:when test="NOEDICION">
            <xsl:for-each select="//field[@name='ID_RESP_NEG']/dropDownList/listElem">
              <xsl:if test="../../@current=ID">
                <xsl:value-of select="listItem"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
              <xsl:variable name="vDeshabilitado"><xsl:if test="EMP_SERVICIOSCDC!='S'">deshabilitado</xsl:if></xsl:variable>
              <xsl:call-template name="field_funcion">
                <xsl:with-param name="path" select="field[@name='ID_RESP_NEG']"/>
                <xsl:with-param name="IDAct" select="field[@name='ID_RESP_NEG']/@current"/>
                <xsl:with-param name="deshabilitado" select="$vDeshabilitado"/>
              </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <td class="datosLeft">
        Responsable del Comisi�n de Negociaci�n de la CdC
      </td>
    </tr>
    -->
    </xsl:if>
    <xsl:if test="//MantenimientoEmpresas/ADMINISTRADORMVM='ADMINISTRADORMVM'">
    <!--quitado por errores-->
    <tr>
    <td class="labelRight">
       <xsl:value-of select="document($doc)/translation/texts/item[@name='no_navegar']/node()"/>:
      </td>
      <td>
              <input type="checkbox" name="EMP_PROVNONAVEGAR_CHK" disabled="disabled">
                <xsl:choose>
                  <xsl:when test="EMP_PROVNONAVEGAR='S'">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                  </xsl:otherwise>
                </xsl:choose>
              </input>
            <td class="datosLeft">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='esta_empresa_proveedor_no_debe_aparecer']/node()"/>.
            </td>
      </td>
    </tr>
    <tr>
    <td class="labelRight">
    	<xsl:value-of select="document($doc)/translation/texts/item[@name='no_navegar_por_defecto']/node()"/>:
      </td>
      <td >
              <input type="checkbox" name="EMP_PROVNONAVEGARPORDEFECTO_CHK">
                <xsl:choose>
                  <xsl:when test="EMP_PROVNONAVEGARPORDEFECTO='S'">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                  </xsl:otherwise>
                </xsl:choose>
              </input>
            <td class="datosLeft">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='esta_empresa_proveedor_no_aparecer_en_navegacion_clientes']/node()"/>.
            </td>
      </td>
    </tr>
    </xsl:if>
     <xsl:if test="/MantenimientoEmpresas/form/EMPRESA/ROL='VENDEDOR'"><!--enviar pdf solo para PROVEEDORES porqu� tb en lado CLIENTE hay-->
     <tr style="background:#F3F781;">
           <td class="labelRight">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_pdf']/node()"/>:
           </td>
            <td class="cinco">
               	   <xsl:choose>
                      <xsl:when test="EMP_ENVIARPDF='S'">
                       <input type="checkbox" checked="checked" name="EMP_ENVIARPDF" />
                     </xsl:when>
                     <xsl:otherwise>
                       <input type="checkbox" name="EMP_ENVIARPDF" />
                     </xsl:otherwise>
                   </xsl:choose>
            </td>
        	<td class="datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_pdf_expli_provee']/node()"/></td>
     </tr>
     </xsl:if>
    </table>
    <!--pedido minimo table-->
  	<table class="infoTable" border="0">
         <tr class="tituloTabla">
                  <th colspan="3">
                  <xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/>
                  </th>
          </tr>
          <tr>
          	<td colspan="2" class="datosLeft">
            <br />
             &nbsp;&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='puede_estabelecer_pedido_minimo_defecto']/node()"/>.
             <br />
             </td>
             <td>
             <xsl:choose>
              <xsl:when test="NOEDICION">&nbsp;</xsl:when>
              <xsl:otherwise>
              	<div class="boton">
                	<a href="javascript:PedidoMinimoPorCliente();">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='por_cliente']/node()"/>
                    </a>
                </div>

              </xsl:otherwise>
            </xsl:choose>


            </td>
          </tr>
         <xsl:if test="/MantenimientoEmpresas/PEDIDOSMINIMOS/CLIENTES_CON_PEDIDO_MINIMO/EMPRESA">
         <tr><td colspan="3">&nbsp;</td></tr>
          <tr>
          <td colspan="3">
          <!--pedido minimo listado ofertas-->
          <table class="infoTable" border="0">
            <tr class="subTituloTabla">
            	<td class="veinte">&nbsp;</td>
            	<td class="veinte" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></td>
                <td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='importe']/node()"/></td>
                <td class="dies">&nbsp;</td>
                <td><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/></td>
            </tr>
          	<xsl:for-each select="/MantenimientoEmpresas/PEDIDOSMINIMOS/CLIENTES_CON_PEDIDO_MINIMO/EMPRESA">
            <tr>
            	<td>&nbsp;</td>
            	<td class="datosLeft"><xsl:value-of select="NOMBRE"/></td>
                <td><xsl:value-of select="IMPORTE"/></td>
                <td>
                   <xsl:choose>
                      <xsl:when test="ACTIVO='N'">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='no_activo']/node()"/>
                      </xsl:when>
                      <xsl:when test="ACTIVO='S'">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/>
                      </xsl:when>
                      <xsl:when test="ACTIVO='E'">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/>
                      </xsl:when>
                      <xsl:when test="ACTIVO='I'">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='integrado']/node()"/>
                      </xsl:when>
                    </xsl:choose>
                </td>
                <td><xsl:value-of select="DESCRIPCION_HTML"/></td>
            </tr>
            <!--ense�amos los centros tb si hay-->
            <xsl:if test="CENTROS_CON_PEDIDO_MINIMO != ''">
            	<xsl:for-each select="CENTROS_CON_PEDIDO_MINIMO/CENTRO">
                	 <tr>
            	<td>&nbsp;</td>
            	<td class="datosLeft">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;<xsl:value-of select="NOMBRE"/></td>
                <td><xsl:value-of select="IMPORTE"/></td>
                <td>
                   <xsl:choose>
                      <xsl:when test="ACTIVO='N'">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='no_activo']/node()"/>
                      </xsl:when>
                      <xsl:when test="ACTIVO='S'">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/>
                      </xsl:when>
                      <xsl:when test="ACTIVO='E'">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/>
                      </xsl:when>
                      <xsl:when test="ACTIVO='I'">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='integrado']/node()"/>
                      </xsl:when>
                    </xsl:choose>
                </td>
                <td><xsl:value-of select="DESCRIPCION_HTML"/></td>
            </tr>
                </xsl:for-each>
            </xsl:if>
            </xsl:for-each>
          </table>

          </td>
          </tr>
          </xsl:if>
          <!--fin de pedidos minimos para empresas-->
          <tr><td colspan="3">&nbsp;</td></tr>

          <tr class="subTituloTabla">
            <td colspan="2"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/></td>
            <td class="trenta" style="text-align:left;">
			<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='importe_minimo_eur']/node()"/>-->
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ped_min']/node()"/><br/><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_prov']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_final']/node()"/></td>
          </tr>
          <tr>
            <td class="labelRight veinte">
               <xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/>:
             </td>
            <td class="datosLeft">
                <xsl:choose>
                  <xsl:when test="NOEDICION">
                   <xsl:choose>
                         <xsl:when test="EMP_PEDMINIMO_ACTIVO='S' or EMP_PEDMINIMO_ACTIVO='E'">
                           &nbsp;&nbsp; <xsl:value-of select="document($doc)/translation/texts/item[@name='si']/node()"/>&nbsp;&nbsp;&nbsp;&nbsp;
                         </xsl:when>
                         <xsl:when test="EMP_PEDMINIMO_ACTIVO='I'">
                          &nbsp;&nbsp;--&nbsp;&nbsp;&nbsp;&nbsp;
                         </xsl:when>
                         <xsl:otherwise>
                           &nbsp;&nbsp;No&nbsp;&nbsp;&nbsp;&nbsp;
                         </xsl:otherwise>
                       </xsl:choose>
                  </xsl:when>
                  <xsl:otherwise>
                   <xsl:choose>
                             <xsl:when test="EMP_PEDMINIMO_ACTIVO='S' or EMP_PEDMINIMO_ACTIVO='E'">
                               <input type="checkbox" name="EMP_PEDMINIMOACTIVO_CHECK"  checked="checked" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
                             </xsl:when>
                             <xsl:when test="EMP_PEDMINIMO_ACTIVO='I'">
                               <input type="checkbox" name="EMP_PEDMINIMOACTIVO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
                             </xsl:when>
                             <xsl:otherwise>
                               <input type="checkbox" name="EMP_PEDMINIMOACTIVO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
                             </xsl:otherwise>
                           </xsl:choose>
                      </xsl:otherwise>
                    </xsl:choose>
           <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
            <xsl:value-of select="document($doc)/translation/texts/item[@name='activar_control_de_pedido_minimo']/node()"/>.
           </td>
            <td class="datosLeft">
            <input type="hidden" name="EMP_PEDMINIMOACTIVO" value="{EMP_PEDMINIMO_ACTIVO}"/>
           <!--input area-->
             <xsl:choose>
                <xsl:when test="NOEDICION">
                    <xsl:value-of select="EMP_PEDMINIMO_IMPORTE"/>
                </xsl:when>
              <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="EMP_PEDMINIMO_ACTIVO='S' or EMP_PEDMINIMO_ACTIVO='E' or EMP_PEDMINIMO_ACTIVO='I'">
                    	<input type="text" name="EMP_PEDIDOMINIMO" onBlur="ValidarNumero(this,2);" value="{EMP_PEDMINIMO_IMPORTE}" size="7" align="right"/>&nbsp;&nbsp;/&nbsp;
                    	<input type="text" name="EMP_PEDIDOMINIMO_NM" onBlur="ValidarNumero(this,2);" value="{EMP_PEDMINIMO_IMPORTE_NM}" size="7" align="right"/>
                    </xsl:when>
                    <xsl:otherwise>
                    	<input type="text" name="EMP_PEDIDOMINIMO" onBlur="ValidarNumero(this,2);" size="7" align="right"/>
                        &nbsp;/&nbsp;
                    	<input type="text" name="EMP_PEDIDOMINIMO_NM" onBlur="ValidarNumero(this,2);" size="7" align="right"/>
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
           <td class="datosLeft">
            <xsl:choose>
              <xsl:when test="NOEDICION">
             <xsl:choose>
                     <xsl:when test="EMP_PEDMINIMO_ACTIVO='S'">
                   &nbsp;&nbsp; <xsl:value-of select="document($doc)/translation/texts/item[@name='si']/node()"/>&nbsp;&nbsp;&nbsp;&nbsp;
                 </xsl:when>
                 <xsl:when test="EMP_PEDMINIMO_ACTIVO='E'">
                   &nbsp;&nbsp; <xsl:value-of select="document($doc)/translation/texts/item[@name='si']/node()"/>&nbsp;&nbsp;&nbsp;&nbsp;
                 </xsl:when>
                 <xsl:when test="EMP_PEDMINIMO_ACTIVO='I'">
                  &nbsp;&nbsp;--&nbsp;&nbsp;&nbsp;&nbsp;
                 </xsl:when>
                 <xsl:otherwise>
                  &nbsp;&nbsp;--&nbsp;&nbsp;&nbsp;&nbsp;
                 </xsl:otherwise>
               </xsl:choose>
              </xsl:when>
          	<xsl:otherwise>
      		<xsl:choose>
                 <xsl:when test="EMP_PEDMINIMO_ACTIVO='S'">
   	           <input type="checkbox" name="EMP_PEDMINIMOESTRICTO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	         </xsl:when>
   	         <xsl:when test="EMP_PEDMINIMO_ACTIVO='E'">
   	           <input type="checkbox" name="EMP_PEDMINIMOESTRICTO_CHECK" checked="checked" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	         </xsl:when>
   	         <xsl:when test="EMP_PEDMINIMO_ACTIVO='I'">
   	           <input type="checkbox" name="EMP_PEDMINIMOESTRICTO_CHECK" disabled="disabled" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	         </xsl:when>
   	         <xsl:otherwise>
   	           <input type="checkbox" disabled="disabled" name="EMP_PEDMINIMOESTRICTO_CHECK" onClick="pedidoMinimo(this.name,document.forms[0]);"/>
   	         </xsl:otherwise>
   	       </xsl:choose>


          </xsl:otherwise>
        </xsl:choose>

          <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
          <xsl:value-of select="document($doc)/translation/texts/item[@name='no_permitir_pedidos_por_debajo_minimo']/node()"/>.
        </td>
        <td>&nbsp;</td>
   	 </tr>
   	 <tr>
           <td class="labelRight">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='no_aceptar_muestras']/node()"/>:
           </td>
           <td class="datosLeft">

               	   <xsl:choose>
                      <xsl:when test="EMP_BLOQUEARMUESTRAS='S'">
                       <input type="checkbox" checked="checked" name="EMP_BLOQUEARMUESTRAS_CHK_PR" />
                     </xsl:when>
                     <xsl:otherwise>
                       <input type="checkbox" name="EMP_BLOQUEARMUESTRAS_CHK_PR" />
                     </xsl:otherwise>
                   </xsl:choose>

   	  	<xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='permitir_unicamente_envio_pedidos']/node()"/>.
           </td>

            <td class="datosLeft">
             <!--input area-->
             <xsl:choose>
                <xsl:when test="NOEDICION">
                    <xsl:value-of select="EMP_PEDMINIMO_LOGISTICA"/>
                </xsl:when>
              <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="EMP_PEDMINIMO_ACTIVO='S' or EMP_PEDMINIMO_ACTIVO='E' or EMP_PEDMINIMO_ACTIVO='I'">
                       		<input type="text" name="EMP_PEDMINIMO_LOGISTICA" onBlur="ValidarNumero(this,2);" value="{EMP_PEDMINIMO_LOGISTICA}"/>
                    </xsl:when>
                    <xsl:otherwise>
                            <input type="text" name="EMP_PEDMINIMO_LOGISTICA" disabled="disabled" onBlur="ValidarNumero(this,2);"/>
                     </xsl:otherwise>
                 </xsl:choose>
              </xsl:otherwise>
            </xsl:choose>
           </td>
   	 </tr>
     <tr>
       <td class="labelRight">
       <xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_pedido_minimo']/node()"/>:
      </td>
      <td colspan="2" class="datosLeft">
       <xsl:choose>
          <xsl:when test="NOEDICION">
             <xsl:copy-of select="EMP_PEDMINIMO_DETALLE"/>
          </xsl:when>
          <xsl:otherwise>
           <xsl:choose>
           <xsl:when test="EMP_PEDMINIMO_ACTIVO=''">
                 <textarea name="EMP_DESCRIPCIONPEDIDOMINIMO" cols="60" rows="3" disabled="disabled"></textarea>
               </xsl:when>
               <xsl:otherwise>
                 <textarea name="EMP_DESCRIPCIONPEDIDOMINIMO" cols="60" rows="3"><xsl:value-of select="EMP_PEDMINIMO_DETALLE"/></textarea>
               </xsl:otherwise>
           </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>

      </td>
      </tr>
      <tr><td colspan="3">&nbsp;</td></tr>
   </table>
   <!--fin tabla pedido minimo-->


    <!--coste de trasporte table-->
  	<table class="infoTable" border="0">
         <tr class="tituloTabla">
                  <th colspan="3">
                  <xsl:value-of select="document($doc)/translation/texts/item[@name='coste_trasporte']/node()"/>
                  </th>
          </tr>
          <tr>
          	<td colspan="2" class="datosLeft">
            <br />
             &nbsp;&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='puede_estabelecer_coste_trasporte_defecto']/node()"/>.
             <br />
             </td>
             <td>
             <xsl:choose>
              <xsl:when test="NOEDICION">&nbsp;</xsl:when>
              <xsl:otherwise>
              	<div class="boton">
                	<a href="javascript:CosteTransportePorCliente();">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='por_cliente']/node()"/>
                    </a>
                </div>

              </xsl:otherwise>
            </xsl:choose>


            </td>
          </tr>
         <xsl:if test="/MantenimientoEmpresas/COSTESTRANSPORTES/CLIENTES_CON_COSTE_TRASPORTE/EMPRESA">
         <tr><td colspan="3">&nbsp;</td></tr>
          <tr>
          <td colspan="3">
          <!--coste trasporte listado ofertas-->
          <table class="infoTable">
            <tr class="subTituloTabla">
            	<td class="veinte">&nbsp;</td>
            	<td class="veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></td>
                <td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='importe']/node()"/></td>
                <td class="dies">&nbsp;</td>
                <td><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/></td>
            </tr>
          	<xsl:for-each select="/MantenimientoEmpresas/COSTESTRANSPORTES/CLIENTES_CON_COSTE_TRASPORTE/EMPRESA">
            <tr>
            	<td>&nbsp;</td>
            	<td class="datosLeft veinte"><xsl:value-of select="NOMBRE"/></td>
                <td><xsl:value-of select="IMPORTE"/></td>
                <td>
                   <xsl:choose>
                      <xsl:when test="ACTIVO='N'">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='no_activo']/node()"/>
                      </xsl:when>
                      <xsl:when test="ACTIVO='S'">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/>
                      </xsl:when>
                      <xsl:when test="ACTIVO='E'">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/>
                      </xsl:when>
                      <xsl:when test="ACTIVO='I'">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='integrado']/node()"/>
                      </xsl:when>
                    </xsl:choose>
                </td>
                <td><xsl:value-of select="DESCRIPCION_HTML"/></td>
            </tr>
            <!--ense�amos los centros tb si hay-->
            <xsl:if test="CENTROS_CON_COSTETRASPORTE != ''">
            	<xsl:for-each select="CENTROS_CON_COSTE_TRASPORTE/CENTRO">
                	 <tr>
            	<td>&nbsp;</td>
            	<td class="datosLeft">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;<xsl:value-of select="NOMBRE"/></td>
                <td><xsl:value-of select="IMPORTE"/></td>
                <td>
                   <xsl:choose>
                      <xsl:when test="ACTIVO='N'">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='no_activo']/node()"/>
                      </xsl:when>
                      <xsl:when test="ACTIVO='S'">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/>
                      </xsl:when>
                      <xsl:when test="ACTIVO='E'">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/>
                      </xsl:when>
                      <xsl:when test="ACTIVO='I'">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='integrado']/node()"/>
                      </xsl:when>
                    </xsl:choose>
                </td>
                <td><xsl:value-of select="DESCRIPCION_HTML"/></td>
            </tr>
                </xsl:for-each>
            </xsl:if>
            </xsl:for-each>
          </table>

          </td>
          </tr>
          </xsl:if>
          <!--fin de coste trasporte para empresas-->

          <tr><td colspan="3">&nbsp;</td></tr>

          <tr class="subTituloTabla">
            <td colspan="2"><xsl:value-of select="document($doc)/translation/texts/item[@name='coste_trasporte']/node()"/></td>
            <td class="veinte" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='coste_trasporte_eur']/node()"/>&nbsp;</td>
          </tr>
          <tr>
            <td class="labelRight veinte">
               <xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/>:
             </td>
            <td class="datosLeft trenta">
                <xsl:choose>
                  <xsl:when test="NOEDICION">
                   <xsl:choose>
                         <xsl:when test="EMP_COSTETRANSP_ACTIVO='S' or EMP_COSTETRANSP_ACTIVO='E'">
                           &nbsp;&nbsp; <xsl:value-of select="document($doc)/translation/texts/item[@name='si']/node()"/>&nbsp;&nbsp;&nbsp;&nbsp;
                         </xsl:when>
                         <xsl:when test="EMP_COSTETRANSP_ACTIVO='I'">
                          &nbsp;&nbsp;--&nbsp;&nbsp;&nbsp;&nbsp;
                         </xsl:when>
                         <xsl:otherwise>
                           &nbsp;&nbsp;No&nbsp;&nbsp;&nbsp;&nbsp;
                         </xsl:otherwise>
                       </xsl:choose>
                  </xsl:when>
                  <xsl:otherwise>
                   <xsl:choose>
                             <xsl:when test="EMP_COSTETRANSP_ACTIVO='S' or EMP_COSTETRANSP_ACTIVO='E'">
                               <input type="checkbox" name="EMP_COSTETRANSPORTEACTIVO_CHECK"  checked="checked" onClick="costeTransporte(this.name,document.forms[0]);"/>
                             </xsl:when>
                             <xsl:when test="EMP_COSTETRANSP_ACTIVO='I'">
                               <input type="checkbox" name="EMP_COSTETRANSPORTEACTIVO_CHECK" onClick="costeTransporte(this.name,document.forms[0]);"/>
                             </xsl:when>
                             <xsl:otherwise>
                               <input type="checkbox" name="EMP_COSTETRANSPORTEACTIVO_CHECK" onClick="costeTransporte(this.name,document.forms[0]);"/>
                             </xsl:otherwise>
                           </xsl:choose>
                      </xsl:otherwise>
                    </xsl:choose>
           <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
            <xsl:value-of select="document($doc)/translation/texts/item[@name='coste_trasporte_activo']/node()"/>.
           </td>
            <td class="datosLeft">
            <input type="hidden" name="EMP_COSTETRANSPORTEACTIVO" value="{EMP_COSTETRANSP_ACTIVO}"/>
           <!--input area-->
             <xsl:choose>
                <xsl:when test="NOEDICION">
                    <xsl:value-of select="EMP_COSTETRANSPORTE_IMPORTE"/>

                </xsl:when>
              <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="EMP_COSTETRANSP_ACTIVO='S' or EMP_COSTETRANSP_ACTIVO='E' or EMP_COSTETRANSP_ACTIVO='I'">
                                <input type="text" name="EMP_COSTETRANSPORTE" onBlur="ValidarNumero(this,2);" value="{EMP_COSTETRANSP_IMPORTE}"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <input type="text" name="EMP_COSTETRANSPORTE" onBlur="ValidarNumero(this,2);"/>
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
           <td class="datosLeft">
            <xsl:choose>
              <xsl:when test="NOEDICION">
             <xsl:choose>
                     <xsl:when test="EMP_COSTETRANSP_ACTIVO='S'">
                   &nbsp;&nbsp; <xsl:value-of select="document($doc)/translation/texts/item[@name='si']/node()"/>&nbsp;&nbsp;&nbsp;&nbsp;
                 </xsl:when>
                 <xsl:when test="EMP_COSTETRANSP_ACTIVO='E'">
                   &nbsp;&nbsp; <xsl:value-of select="document($doc)/translation/texts/item[@name='si']/node()"/>&nbsp;&nbsp;&nbsp;&nbsp;
                 </xsl:when>
                 <xsl:when test="EMP_COSTETRANSP_ACTIVO='I'">
                  &nbsp;&nbsp;--&nbsp;&nbsp;&nbsp;&nbsp;
                 </xsl:when>
                 <xsl:otherwise>
                  &nbsp;&nbsp;--&nbsp;&nbsp;&nbsp;&nbsp;
                 </xsl:otherwise>
               </xsl:choose>
              </xsl:when>
          	<xsl:otherwise>
      		<xsl:choose>
                 <xsl:when test="EMP_COSTETRANSP_ACTIVO='S'">
   	           <input type="checkbox" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	         </xsl:when>
   	         <xsl:when test="EMP_COSTETRANSP_ACTIVO='E'">
   	           <input type="checkbox" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" checked="checked" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	         </xsl:when>
   	         <xsl:when test="EMP_COSTETRANSP_ACTIVO='I'">
   	           <input type="checkbox" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" disabled="disabled" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	         </xsl:when>
   	         <xsl:otherwise>
   	           <input type="checkbox" disabled="disabled" name="EMP_COSTETRANSPORTEESTRICTO_CHECK" onClick="costeTransporte(this.name,document.forms[0]);"/>
   	         </xsl:otherwise>
   	       </xsl:choose>


          </xsl:otherwise>
        </xsl:choose>

          <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
          <xsl:value-of select="document($doc)/translation/texts/item[@name='no_permitir_pedidos_sin_coste_trasporte']/node()"/>.
        </td>
        <td>&nbsp;</td>
   	 </tr>
   	<!-- <tr>
           <td class="labelRight">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='no_aceptar_muestras']/node()"/>:
           </td>
           <td class="datosLeft">

               	   <xsl:choose>
                      <xsl:when test="EMP_BLOQUEARMUESTRAS='S'">
                       <input type="checkbox" checked="checked" name="EMP_BLOQUEARMUESTRAS_CHK" />
                     </xsl:when>
                     <xsl:otherwise>
                       <input type="checkbox" name="EMP_BLOQUEARMUESTRAS_CHK" />
                     </xsl:otherwise>
                   </xsl:choose>

   	  	<xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='permitir_unicamente_envio_pedidos']/node()"/>.
           </td>
        </tr>

            <td class="datosLeft">

             <xsl:choose>
                <xsl:when test="NOEDICION">
                    <xsl:value-of select="EMP_PEDMINIMO_LOGISTICA"/>
                </xsl:when>
              <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="EMP_PEDMINIMO_ACTIVO='S' or EMP_COSTETRANSPORTE_ACTIVO='E' or EMP_COSTETRANSPORTE_ACTIVO='I'">
                       		<input type="text" name="EMP_COSTETRANSPORTE_LOGISTICA" onBlur="ValidarNumero(this,2);" value="{EMP_COSTETRANSPORTE_LOGISTICA}"/>
                    </xsl:when>
                    <xsl:otherwise>
                            <input type="text" name="EMP_COSTETRANSPORTE_LOGISTICA" disabled="disabled" onBlur="ValidarNumero(this,2);"/>
                     </xsl:otherwise>
                 </xsl:choose>
              </xsl:otherwise>
            </xsl:choose>
           </td>
   	 </tr>-->
     <tr>
       <td class="labelRight">
       <xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_coste_trasporte']/node()"/>:
      </td>
      <td colspan="2" class="datosLeft">
       <xsl:choose>
          <xsl:when test="NOEDICION">
             <xsl:copy-of select="EMP_COSTETRANSP_DETALLE"/>
          </xsl:when>
          <xsl:otherwise>
           <xsl:choose>
           <xsl:when test="EMP_COSTETRANSPORTE_ACTIVO=''">
                 <textarea name="EMP_DESCRIPCIONCOSTETRANSPORTE" cols="60" rows="3" disabled="disabled"></textarea>
               </xsl:when>
               <xsl:otherwise>
                 <textarea name="EMP_DESCRIPCIONCOSTETRANSPORTE" cols="60" rows="3"><xsl:value-of select="EMP_COSTETRANSP_DETALLE"/></textarea>
               </xsl:otherwise>
           </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>

      </td>
      </tr>
      <tr><td colspan="3">&nbsp;</td></tr>
   </table>
   <!--fin tabla coste de trasporte-->

   <!--inicio otra tabla, if -->
    <xsl:if test="//MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA">
        <table class="infoTable">
        <thead>
          <tr class="tituloTabla">
                  <th colspan="4">
                   <xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo_por_cliente']/node()"/>
                  </th>
          </tr>
           <tr class="gris">
                  <td colspan="4">
                   <xsl:value-of select="document($doc)/translation/texts/item[@name='listado_clientes_pedido_minimo']/node()"/>
                  </td>
          </tr>
          <tr class="subTituloTabla">
            <td><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></td>
            <td><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/></td>
            <td><xsl:value-of select="document($doc)/translation/texts/item[@name='importe_minimo_eur']/node()"/></td>
            <td><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_pedido_minimo']/node()"/></td>
          </tr>
          </thead>
          <tbody>
          <xsl:for-each select="//MantenimientoEmpresas/EMPRESAS_CON_PEDIDO_MINIMO/EMPRESA">
          <tr>
            <td>
              <xsl:choose>
                <xsl:when test="/MantenimientoEmpresas/form/EMPRESA/NOEDICION">
                 <li type="disk">
                    <xsl:value-of select="NOMBRE"/>
                 </li>
          		</xsl:when>
          		<xsl:otherwise>
                 <li type="disk">
                  <a href="javascript:ModificarMinimoPorCliente({ID},'','MODIFICARCLIENTE');">
                	<xsl:value-of select="NOMBRE"/>
                  </a>
                  </li>
              </xsl:otherwise>
       		 </xsl:choose>
            </td>
            <td>
             <input type="hidden" name="EMP_PEDMINIMO_ACTIVO_{ID}" value="{ACTIVO}"/>
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
               <xsl:otherwise>
                 <b><xsl:value-of select="document($doc)/translation/texts/item[@name='integrado']/node()"/></b>
               </xsl:otherwise>
             </xsl:choose>
            </td>
            <td>
              <xsl:value-of select="IMPORTE"/>
            </td>
            <td>
                  <xsl:copy-of select="DESCRIPCION_HTML"/>
            </td>
          </tr>
          <xsl:for-each select="CENTROS_CON_PEDIDO_MINIMO/CENTRO">
                 <tr>
                   <td>
                      <xsl:choose>
                        <xsl:when test="/MantenimientoEmpresas/form/EMPRESA/NOEDICION">
                      			<li type="circle">
                                   <xsl:value-of select="NOMBRE"/>
                               </li>
                      </xsl:when>
                      <xsl:otherwise>
                         <li type="circle">
                                     <a href="javascript:ModificarMinimoPorCliente('{../../ID}','{ID}','MODIFICARCENTRO');">
                                       <xsl:value-of select="NOMBRE"/>
                                     </a>
                         </li>
                      </xsl:otherwise>
        			</xsl:choose>
                   </td>
                   <td>
                    <input type="hidden" name="EMP_PEDMINIMO_ACTIVO_{ID}" value="{ACTIVO}"/>
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
                      <xsl:otherwise>
                        <b><xsl:value-of select="document($doc)/translation/texts/item[@name='integrado']/node()"/></b>
                      </xsl:otherwise>
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
          </tbody>
          <tr><td colspan="4">&nbsp;</td></tr>
       </table>
     </xsl:if> 	 <!-- fin if -->

  	</div><!--fin de div solo proveedor-->

	<div class="divLeft" style="border-top:2px solid #3b5998;">
     <br /><br />
      <!--botoness-->
     <table class="infoTable">
            <xsl:choose>
                <xsl:when test="NOEDICION">
                  <tr>
                   <td class="trenta">&nbsp;</td>
                    <td class="trenta">
                   <div class="boton">
                    <a href="javascript:document.location='about:blank'">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
                    </a>
                    </div>
                    </td>
                    <td>&nbsp;</td>
                  </tr>
          </xsl:when>
          <xsl:otherwise>
              <tr>
                <td class="veinte">&nbsp;</td>
                <td class="veinte">
                	<div class="boton">
                    <a href="javascript:document.location='about:blank'">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
                    </a>
                    </div>
                </td>
                <td class="veinte">
                	<div class="boton">
                    <a href="javascript:ActualizarDatos(document.forms['MantenEmpresa']);">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
                    </div>

                </td>
                <td>&nbsp;</td>
              </tr>
          </xsl:otherwise>
        </xsl:choose>
        </table>
     <br /><br />
    </div><!--fin divBotones-->

 </div><!--fin divLeft-->

</xsl:template>

<xsl:template match="DP_NOMBRE">
    <a>
     <xsl:attribute name="href">javascript:MostrarPagPersonalizada('DPManten.xsql?DP_ID=<xsl:value-of select="../DP_ID"/>&amp;EMP_ID=<xsl:value-of select="../EMP_ID"/>','MantenimientoEmpresas',65,45,0,-50);
     </xsl:attribute>
     <xsl:value-of select="."/>
    </a>
  </xsl:template>


<xsl:template match="EMP_PUBLICAR">
    <xsl:choose>
       <xsl:when test=". ='S' ">
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="EMP_PUBLICAR" checked>]]></xsl:text>
       </xsl:when>
       <xsl:otherwise>
	  <xsl:text disable-output-escaping="yes"><![CDATA[<input type="checkbox" name="EMP_PUBLICAR">]]></xsl:text>
       </xsl:otherwise>
    </xsl:choose>
  <xsl:text disable-output-escaping="yes"><![CDATA[
  </input>
  ]]></xsl:text>
</xsl:template>

<xsl:template match="ExtraButtons">
    <!-- Cada button corresponde a un form con campos ocultos /field y un submit /button -->
    <xsl:for-each select="formu">
    <xsl:choose>
    <xsl:when test="@name='dummy'">
      <!-- Colocamos form chorra porque el javascript tiene problemas con el primer formulario
           anidado -->
      <form method="post">
        <xsl:attribute name="name">
          <xsl:value-of select="@name"/>
        </xsl:attribute>
        <xsl:attribute name="action">
          <xsl:value-of select="@action"/>
        </xsl:attribute>
      </form>
    </xsl:when>
    <xsl:otherwise>

      <form method="post">
        <xsl:attribute name="name">
          <xsl:value-of select="@name"/>
        </xsl:attribute>
        <xsl:attribute name="action">
          <xsl:value-of select="@action"/>
        </xsl:attribute>
        <div class="boton">
        	<a>
            <xsl:attribute name="href">javascript:MostrarPagPersonalizada('DPManten.xsql?DP_ID=0&amp;EMP_ID=<xsl:value-of select="//form/EMPRESA/EMP_ID"/>','MantenimientoEmpresas',65,45,0,-50);</xsl:attribute>
            <xsl:value-of select="document($doc)/translation/texts/item[@name='insertar_departamento']/node()"/>
            </a>

        </div>

        <!-- Ponemos los campos input ocultos -->
        <xsl:for-each select="field">
           <input>
           <!-- Anyade las opciones comunes al campo input -->
                <xsl:attribute name="type">
                  <xsl:value-of select="@type"/>
                </xsl:attribute>
                <xsl:attribute name="name">
                  <xsl:value-of select="@name"/>
                </xsl:attribute>
           <!-- Anyadimos los valores, que son diferentes para cada field -->
           <xsl:choose>
            <!-- Campo EMP_ID -->
             <xsl:when test="EMP_ID">
               <xsl:attribute name="value">
               <xsl:value-of select="//form/EMPRESA/EMP_ID"/>
               </xsl:attribute>
             </xsl:when>
             <!-- Campo DP_ID -->
             <xsl:when test="DP_ID">
               <xsl:attribute name="value">
               <xsl:value-of select="DP_ID"/>
               </xsl:attribute>
             </xsl:when>
           </xsl:choose>
           </input>
        </xsl:for-each>
        <!-- Anyadimos el boton de submit -->
      </form>
    </xsl:otherwise>
    </xsl:choose>
    </xsl:for-each>
</xsl:template>

<xsl:template match="dropDownList">
    <xsl:variable name="IDAct"/>
    <select>
      <xsl:attribute name="name"><xsl:value-of select="../@name"/></xsl:attribute>
      <!-- <xsl:copy> -->

      <xsl:for-each select="listElem">
        <xsl:choose>
          <xsl:when test="$IDAct = ID">
            <option selected="selected">
    	      <xsl:attribute name="value">
     	        <xsl:value-of select="ID"/>
  	      </xsl:attribute>
   	      [<xsl:value-of select="listItem" disable-output-escaping="yes"/>]
            </option>
          </xsl:when>
          <xsl:otherwise>
            <option>
    	      <xsl:attribute name="value">
     	        <xsl:value-of select="ID"/>
  	      </xsl:attribute>
              <xsl:value-of select="listItem" disable-output-escaping="yes"/>
            </option>
            </xsl:otherwise>
          </xsl:choose>
      </xsl:for-each>
    </select>
  </xsl:template>


  <xsl:template name="desplegable">
    <xsl:param name="path"/>
    <xsl:param name="defecto"/>
    <select>
      <xsl:attribute name="name"><xsl:value-of select="$path/@name"/></xsl:attribute>
      <!-- <xsl:copy> -->

      <xsl:for-each select="$path/dropDownList/listElem">
        <xsl:choose>
          <xsl:when test="$defecto = ID">
            <option selected="selected">
    	      <xsl:attribute name="value">
     	        <xsl:value-of select="ID"/>
  	      </xsl:attribute>
   	      [<xsl:value-of select="listItem" disable-output-escaping="yes"/>]
            </option>
          </xsl:when>
          <xsl:otherwise>
            <option>
    	      <xsl:attribute name="value">
     	        <xsl:value-of select="ID"/>
  	      </xsl:attribute>
              <xsl:value-of select="listItem" disable-output-escaping="yes"/>
            </option>
            </xsl:otherwise>
          </xsl:choose>
      </xsl:for-each>
    </select>
  </xsl:template>

<!--INICIO TEMPLATE IMAGE-->
 <xsl:template name="image">
	<xsl:param name="num" />

    	<!--idioma-->
        <xsl:variable name="lang">
        	<xsl:value-of select="//LANG" />
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->

	<div class="imageLineEmp" id="imageLine_{$num}">

			<label class="medium" for="inputFile_{$num}" style="display:none;">&nbsp;</label>
			<input id="inputFile_{$num}" name="inputFile" type="file" onchange="addFile({$num});" />
	</div>
    &nbsp;&nbsp;&nbsp;
    <div class="boton">
        <a href="javascript:CargarImagen(document.forms['MantenEmpresa']);">
          <xsl:value-of select="document($doc)/translation/texts/item[@name='subir_logo']/node()"/>
        </a>
    </div>
    <div id="waitBox">&nbsp;</div>
    <div id="confirmBox">&nbsp;</div>
</xsl:template>

<!--documentos-->
<xsl:template name="documentos">
	<xsl:param name="num" />
    <xsl:param name="type" />

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
		<xsl:when test="$num &lt; number(5)">
			<div class="docLine" id="docLine_{$type}">
				<!--<xsl:if test="number($num) &gt; number(1)">
						<xsl:attribute name="style">display: none;</xsl:attribute>
				</xsl:if>-->
				<div class="docLongEspec" id="docLongEspec_{$type}">
					<!--<label class="medium" for="inputDoc_{$num}">Documento&nbsp;<xsl:value-of select="$num"/>:</label>-->
					<input id="inputFileDoc_{$type}" name="inputFileDoc" type="file" onChange="addDocFile('{$type}','MantenEmpresa');" />
				</div>
                <div id="waitBoxDocLOGO" style="display:none;">&nbsp;</div>
                <div id="confirmBoxLOGO" style="display:none;">&nbsp;</div>
                <div class="boton" style="clear:both;">
                    <a href="javascript:cargaDoc(document.forms['MantenEmpresa'],'{$type}');">
                      <xsl:value-of select="document($doc)/translation/texts/item[@name='subir_logo']/node()"/>
                    </a>
                </div>
			</div>
		</xsl:when>

	</xsl:choose>
    </xsl:template>
<!--fin de documentos-->
</xsl:stylesheet>
