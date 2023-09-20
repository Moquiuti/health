<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 |	This stylesheet implements multi-language at the UI level
 |	It is based on the parameter 'lang' that is 'english' by default.
 |	It can be also 'french' or 'spanish' or 'german'.
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>

<xsl:template match="/">
<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/Mantenimiento/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_de_centros']/node()"/></title>

	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
	<meta name="description" content="insert brief description here"/>
	<meta name="keywords" content="insert, keywords, here"/>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<link rel="stylesheet" href="http://www.newco.dev.br/General/calendario/spiffyCal_v2_1.css" type="text/css"/>
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
        <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
        <script type="text/javascript" src="http://www.newco.dev.br/General/ajax.js"></script>
        <script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CargaDocumentos110614.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENManten030316.js"></script>
	
	<script type="text/javascript" src="http://www.newco.dev.br/General/calendario/spiffyCal_v2_1.js"></script>
</head>

<body>
<xsl:choose>
<xsl:when test="//SESION_CADUCADA">
	<xsl:for-each select="//SESION_CADUCADA">
	<xsl:if test="position()=last()">
		<xsl:apply-templates select="."/>
	</xsl:if>
	</xsl:for-each>
</xsl:when>
<xsl:when test="//xsql-error">
	<xsl:apply-templates select="//xsql-error"/>
</xsl:when>
<xsl:otherwise>
	<xsl:apply-templates select="Mantenimiento/form"/>
</xsl:otherwise>
</xsl:choose>
<div id="uploadFrame" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>
   <div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>
</body>
</html>
</xsl:template>

<!--
 |	Templates
 +-->
<xsl:template match="form">
<!--idioma-->
<xsl:variable name="lang"><xsl:value-of select="/Mantenimiento/LANG"/></xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<div id="spiffycalendar" class="text"></div>
<script type="text/javascript">
	var calFechaPrimeraCuota	= new ctlSpiffyCalendarBox("calFechaPrimeraCuota", "<xsl:value-of select="@name"/>", "CEN_FECHAPRIMERACUOTA","btnDateFechaPrimeraCuota",'<xsl:value-of select="/Mantenimiento/form/CENTRO/CEN_FECHAPRIMERACUOTA"/>',scBTNMODE_CLASSIC,'');
	var calFechaCuotaActiva		= new ctlSpiffyCalendarBox("calFechaCuotaActiva", "<xsl:value-of select="@name"/>", "CEN_FECHACUOTAACTIVA","btnDateFechaCuotaActiva",'<xsl:value-of select="/Mantenimiento/form/CENTRO/CEN_FECHACUOTAACTIVA"/>',scBTNMODE_CLASSIC,'');
</script>

<form method="post">
	<xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
        <xsl:attribute name="id"><xsl:value-of select="@name"/></xsl:attribute>
	<xsl:attribute name="action"><xsl:value-of select="@action"/></xsl:attribute>

	<input type="hidden" name="CEN_PROVINCIA" value="{/Mantenimiento/form/CENTRO/CEN_PROVINCIA}"/>
	<input type="hidden" name="CEN_IDPAIS" value="{/Mantenimiento/form/CENTRO/EMP_IDPAIS}"/>
	<input type="hidden" name="TIENEPEDIDOS">
		<xsl:attribute name="value">
			<xsl:choose><xsl:when test="/Mantenimiento/form/CENTRO/TIENEPEDIDOS">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>
		</xsl:attribute>
	</input>
        <input type="hidden" name="CEN_COMISIONAHORRO"/>
        <input type="hidden" name="CEN_COMISIONTRANSACCIONES"/>
        <input type="hidden" name="CEN_IDLOGOTIPO"/>

	<xsl:apply-templates select="CENTRO"/>
</form>

<!--form para mensajes js-->
<form name="MensajeJS">
	<input type="hidden" name="OBLI_NOMBRE_EMPRESA" value="{document($doc)/translation/texts/item[@name='obli_nombre_empresa']/node()}"/>
	<input type="hidden" name="OBLI_DIRECCION" value="{document($doc)/translation/texts/item[@name='obli_direccion']/node()}"/>
	<input type="hidden" name="OBLI_COD_POSTAL" value="{document($doc)/translation/texts/item[@name='obli_cod_poostal']/node()}"/>
	<input type="hidden" name="OBLI_POBLACION" value="{document($doc)/translation/texts/item[@name='obli_poblacion']/node()}"/>
	<input type="hidden" name="OBLI_TELEFONO" value="{document($doc)/translation/texts/item[@name='obli_telefono']/node()}"/>
	<input type="hidden" name="OBLI_COMERCIAL" value="{document($doc)/translation/texts/item[@name='obli_comercial']/node()}"/>
	<input type="hidden" name="OBLI_USUARIO_CATALOGO" value="{document($doc)/translation/texts/item[@name='obli_usuario_catalogo']/node()}"/>
	<input type="hidden" name="OBLI_USUARIO_EVALUAZ" value="{document($doc)/translation/texts/item[@name='obli_usuario_evaluaz']/node()}"/>
	<input type="hidden" name="OBLI_USUARIO_INCIDEN" value="{document($doc)/translation/texts/item[@name='obli_usuario_inciden']/node()}"/>
	<input type="hidden" name="OBLI_USUARIO_NEGOCIA" value="{document($doc)/translation/texts/item[@name='obli_usuario_negocia']/node()}"/>
	<input type="hidden" name="FORMATO_NUM_GUION_PARENT" value="{document($doc)/translation/texts/item[@name='formato_num_guion_parent']/node()}"/>
	<input type="hidden" name="TIENE_PEDIDOS_AVISO" value="{document($doc)/translation/texts/item[@name='tiene_pedidos_aviso']/node()}"/>
	<input type="hidden" name="CAR_RAROS" value="{document($doc)/translation/texts/item[@name='caracteres_raros_sin_barra']/node()}"/>
	<input type="hidden" name="VACIO_CEN_LIMITECOMPRASMENSUALES" value="{document($doc)/translation/texts/item[@name='vacio_limite_compras_mensuales']/node()}"/>
	<input type="hidden" name="ERROR_CEN_LIMITECOMPRASMENSUALES" value="{document($doc)/translation/texts/item[@name='error_limite_compras_mensuales']/node()}"/>
	<input type="hidden" name="VACIO_CEN_FECHAPRIMERACUOTA" value="{document($doc)/translation/texts/item[@name='vacio_fecha_primera_cuota']/node()}"/>
	<input type="hidden" name="ERROR_CEN_FECHAPRIMERACUOTA" value="{document($doc)/translation/texts/item[@name='error_fecha_primera_cuota']/node()}"/>
	<input type="hidden" name="VACIO_CEN_FECHACUOTAACTIVA" value="{document($doc)/translation/texts/item[@name='vacio_fecha_cuota_activa']/node()}"/>
	<input type="hidden" name="ERROR_CEN_FECHACUOTAACTIVA" value="{document($doc)/translation/texts/item[@name='error_fecha_cuota_activa']/node()}"/>
	<input type="hidden" name="ERROR_FECHACUOTAACTIVA_MINOR" value="{document($doc)/translation/texts/item[@name='error_fecha_cuota_activa_minor']/node()}"/>
        <input type="hidden" name="ERROR_CEN_COMISIONTRANSACCIONES" value="{document($doc)/translation/texts/item[@name='error_comision_transacciones']/node()}"/>
        <input type="hidden" name="ERROR_CEN_COMISIONAHORRO" value="{document($doc)/translation/texts/item[@name='error_comision_ahorro']/node()}"/>
        
</form>
<!--fin form para mensajes js-->
</xsl:template>

<xsl:template match="CENTRO">
<!--idioma-->
<xsl:variable name="lang"><xsl:value-of select="../../LANG"/></xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<xsl:choose>
<xsl:when test="CEN_ID !=''">
	<h1 class="titlePage" style="float:left;width:70%;padding-left:10%;">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;

		<xsl:choose>
		<xsl:when test="/Mantenimiento/form/CENTRO/CEN_NOMBRECORTO != ''"><xsl:value-of select="/Mantenimiento/form/CENTRO/CEN_NOMBRECORTO"/></xsl:when>
		<xsl:otherwise><xsl:value-of select="substring(/Mantenimiento/form/CENTRO/CEN_NOMBRE,0,30)"/></xsl:otherwise>
		</xsl:choose>

		<xsl:if test="/Mantenimiento/form/CENTRO/MVM or /Mantenimiento/form/CENTRO/MVMB">
			<xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
			<a style="text-decoration:none;" title="Ficha Empresa">
				<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID=<xsl:value-of select="CEN_ID"/>','Ficha centro',100,80,0,0);</xsl:attribute>
				<img src="http://www.newco.dev.br/images/verFichaIcon.gif" alt="Ficha Empresa"/>&nbsp;
			</a>
			<xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
			<a href="javascript:window.print();" style="text-decoration:none;" title="Imprimir">
				<img src="http://www.newco.dev.br/images/imprimir.gif" alt="Imprimir"/>&nbsp;
			</a>
		</xsl:if>
	</h1>
	<h1 class="titlePage" style="float:left;width:20%">
		<span style="float:right; padding:5px; font-weight:bold;" class="amarillo">CEN_ID=<xsl:value-of select="CEN_ID"/></span>
	</h1>
</xsl:when>
<xsl:otherwise>
	<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_centro']/node()"/></h1>
</xsl:otherwise>
</xsl:choose>

	<div class="divLeft">
		<xsl:apply-templates select="CEN_ID"/>
		<xsl:apply-templates select="EMP_ID"/>

                <input type="hidden" name="REMOVE" value="{document($doc)/translation/texts/item[@name='remove']/node()}"/>
                
                <table class="infoTable">
			<tr>
				<td colspan="5">
					<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='los_siguientes_caracteres_no_deben_sin_barra']/node()"/></span>
				</td>
			</tr>

			<tr>
				<td class="quince" rowspan="3">
					<img src="{/Mantenimiento/form/CENTRO/URL_LOGOTIPO}" height="80px" width="160px"/>
				</td>
				<td class="labelRight dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:<span class="camposObligatorios">*</span></td>
				<td class="datosLeft veinte">
					<xsl:choose>
					<xsl:when test="CEN_ID !=''"><xsl:apply-templates select="CEN_NOMBRE"/></xsl:when>
					<xsl:otherwise>
						<input type="hidden" name="CEN_NOMBRE_OLD" value="{EMP_NOMBRE}"/>
						<input type="text" name="CEN_NOMBRE" size="50" maxlength="100" value="{EMP_NOMBRE}"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td class="labelRight doce"><xsl:value-of select="document($doc)/translation/texts/item[@name='nif']/node()"/>:<span class="camposObligatorios">*</span></td>
				<td class="datosLeft">
					<xsl:choose>
					<xsl:when test="CEN_ID !=''"><xsl:apply-templates select="CEN_NIF"/></xsl:when>
					<xsl:otherwise>
						<input type="text" name="CEN_NIF" maxlength="20" size="20" value="{EMP_NIF}"/>&nbsp;
						<span class="textoComentario"><xsl:value-of select="document($doc)/translation/texts/item[@name='formato_recomendado']/node()"/></span>
					</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>

			<tr>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_corto']/node()"/>:<span class="camposObligatorios">*</span></td>
				<td colspan="3" class="datosLeft">
					<xsl:choose>
					<xsl:when test="CEN_ID !=''"><xsl:apply-templates select="CEN_NOMBRECORTO"/></xsl:when>
					<xsl:otherwise>
						<input type="hidden" name="CEN_NOMBRECORTO_OLD" value="{EMP_NOMBRECORTOPUBLICO}"/>
						<input type="text" name="CEN_NOMBRECORTO" size="20" maxlength="40" value="{EMP_NOMBRECORTOPUBLICO}"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>

			<tr>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='direccion']/node()"/>:<span class="camposObligatorios">*</span></td>
				<td colspan="3" class="datosLeft">
					<xsl:choose>
					<xsl:when test="CEN_ID !=''"><xsl:apply-templates select="CEN_DIRECCION"/></xsl:when>
					<xsl:otherwise>
						<input type="text" name="CEN_DIRECCION" size="50" maxlength="100" value="{EMP_DIRECCION}"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>

			<tr>
				<td colspan="2" class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='provincia']/node()"/>:<span class="camposObligatorios">*</span></td>
				<td class="datosLeft" colspan="3">
					<xsl:choose>
					<xsl:when test="EMP_IDPAIS = '34'">
						<xsl:call-template name="desplegable"><xsl:with-param name="path" select="PROVINCIAS/PROVINCIA_34/field"/></xsl:call-template>
					</xsl:when>
					<xsl:when test="EMP_IDPAIS = '55'">
						<xsl:call-template name="desplegable"><xsl:with-param name="path" select="PROVINCIAS/PROVINCIA_55/field"/></xsl:call-template>
					</xsl:when>
					</xsl:choose>
				</td>
			</tr>

			<tr>
				<td colspan="2" class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='poblacion']/node()"/>:<span class="camposObligatorios">*</span></td>
				<td class="datosLeft">
					<xsl:choose>
					<xsl:when test="CEN_ID !=''"><xsl:apply-templates select="CEN_POBLACION"/></xsl:when>
					<xsl:otherwise>
						<input type="text" name="CEN_POBLACION" maxlength="200" value="{EMP_POBLACION}" size="25"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_postal']/node()"/>:<span class="camposObligatorios">*</span></td>
				<td class="datosLeft">
					<xsl:choose>
					<xsl:when test="CEN_ID !=''"><xsl:apply-templates select="CEN_CPOSTAL"/></xsl:when>
					<xsl:otherwise>
						<input type="text" name="CEN_CPOSTAL" maxlength="15" value="{EMP_CPOSTAL}"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>

			<tr>
				<td colspan="2" class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='telefono']/node()"/>:<span class="camposObligatorios">*</span></td>
				<td class="datosLeft">
					<xsl:apply-templates select="CEN_TELEFONO"/>
				</td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='fax']/node()"/>:</td>
				<td class="datosLeft">
					<xsl:choose>
					<xsl:when test="CEN_ID !=''"><xsl:apply-templates select="CEN_FAX"/></xsl:when>
					<xsl:otherwise>
						<input type="text" name="CEN_FAX" maxlength="50" value="{EMP_FAX}"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
                <!--logo-->
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
        <tr id="cargaLogo">
		<td colspan="2">&nbsp;</td>
		<td class="datosLeft" colspan="3">
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
	</tr>
        <!--fin de logo-->
			<tr>
				<td colspan="2" class="labelRight" valign="top"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_comercial_centro']/node()"/>:</td>
				<td colspan="3" class="datosLeft">
					<textarea name="CEN_DESCRIPCIONCOMERCIAL" id="CEN_DESCRIPCIONCOMERCIAL" rows="5" cols="60">
						<xsl:copy-of select="CEN_DESCRIPCIONCOMERCIAL/node()" disable-output-escaping="yes"/>
					</textarea>
				</td>
			</tr>

			<tr><td colspan="5">&nbsp;</td></tr>
		</table>

		<!--solo para el cliente-->
		<div id="soloCliente">
			<xsl:attribute name="style">
				<xsl:choose>
				<xsl:when test="/Mantenimiento/form/CENTRO/ROL = 'VENDEDOR'">display:none;</xsl:when>
				<xsl:when test="/Mantenimiento/form/CENTRO/ROL = 'COMPRADOR'">display:block;</xsl:when>
				</xsl:choose>
			</xsl:attribute>

			<table class="infoTable">
				<tr class="tituloTabla">
					<th colspan="4"><xsl:value-of select="document($doc)/translation/texts/item[@name='opciones_especificas_clientes']/node()"/></th>
				</tr>

				<tr>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='forma_de_pago']/node()"/>:<span class="camposObligatorios">*</span></td>
					<td class="datosLeft">
						<xsl:call-template name="FORMASPAGO"/>
					</td>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_de_pago']/node()"/>:<span class="camposObligatorios">*</span></td>
					<td class="datosLeft">
						<xsl:call-template name="PLAZOSPAGO"/>
					</td>
				</tr>

				<tr>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_objetivo_mensual']/node()"/>:</td>
					<td class="datosLeft">
						<xsl:apply-templates select="CEN_PEDIDOSPREVISTOSMES"/>
					</td>
					<td colspan="2">&nbsp;</td>
				</tr>

				<tr>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='numero_de_camas']/node()"/>:<span class="camposObligatorios">*</span></td>
					<td class="datosLeft">
						<xsl:apply-templates select="CEN_CAMAS"/>
					</td>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='quirofanos']/node()"/>:</td>
					<td class="datosLeft">
						<xsl:apply-templates select="CEN_QUIROFANOS"/>
					</td>
				</tr>

				<tr>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_cdc']/node()"/>:<span class="camposObligatorios">*</span></td>
					<td colspan="3" class="datosLeft">
						<xsl:apply-templates select="CEN_CDC"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='opcion_cdc']/node()"/>
					</td>
				</tr>

			<!-- DC - 15/05/14 - Se oculta las siguientes 3 filas para Brasil -->
			<xsl:if test="/Mantenimiento/form/CENTRO/EMP_IDPAIS = '34'">
				<tr>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='requiere_compromiso']/node()"/>:<span class="camposObligatorios">*</span></td>
					<td colspan="3" class="datosLeft">
						<xsl:apply-templates select="CEN_COMPROMISO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='firmar_compromiso_para_ver']/node()"/>
					</td>
				</tr>
			</xsl:if>

				<tr>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='sin_comisiones']/node()"/>:<span class="camposObligatorios">*</span></td>
					<td colspan="3" class="datosLeft">
						<xsl:apply-templates select="CEN_SINCOMISIONES"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='centro_no_comisiones']/node()"/>
					</td>
				</tr>

				<tr>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='mostrar_centro_consumo']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
						<xsl:apply-templates select="CEN_MOSTRARCENTROSCONSUMO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='mostrar_centro_consumo_expli']/node()"/>
					</td>
				</tr>

				<!--usuarios integración 14-5-15 para clientes y proveedores-->
				<tr>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_integracion_pdf']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
						<xsl:call-template name="desplegable">
                                                    <xsl:with-param name="path" select="CEN_IDUSUARIOINTEGRACION_PDF/field"/>
                                                    <xsl:with-param name="claSel">select200</xsl:with-param>
                                                </xsl:call-template>
						&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_integracion_pdf_expli']/node()"/>
					</td>
				</tr>

				<tr>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_integracion_xml']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
						<xsl:call-template name="desplegable">
                                                    <xsl:with-param name="path" select="CEN_IDUSUARIOINTEGRACION_XML/field"/>
                                                    <xsl:with-param name="claSel">select200</xsl:with-param>
                                                </xsl:call-template>
						&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_integracion_xml_expli']/node()"/>
					</td>
				</tr>

                                <!--campos para facturación centro 18-12-15-->
                                <tr class="tituloTabla">
					<th colspan="4"><xsl:value-of select="document($doc)/translation/texts/item[@name='modelo_de_negocio']/node()"/></th>
				</tr>
                                <tr>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='modelo_de_negocio']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
              <xsl:call-template name="desplegable">
                <xsl:with-param name="path" select="IDMODELONEGOCIO/field"/>
                <xsl:with-param name="onChange">javascript:verComisiones(document.forms['frmManten']);</xsl:with-param>
                <xsl:with-param name="claSel">select200</xsl:with-param>
              </xsl:call-template>
							&nbsp;&nbsp;&nbsp;
							<input type="checkbox" name="CEN_INCLUIRENFACTURACION">
								<xsl:choose>
								<xsl:when test="CEN_INCLUIRENFACTURACION='S'"><xsl:attribute name="checked">S</xsl:attribute></xsl:when>
								<xsl:otherwise><xsl:attribute name="unchecked">N</xsl:attribute></xsl:otherwise>
								</xsl:choose>
							</input>
							&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='incluir_en_listado_facturación']/node()"/>
					</td>
				</tr>
                                <tr id="comisionAhorro" class="comisiones" style="display:none;">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='comision_ahorro']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
						<input type="text" name="CEN_COMISIONAHORRO_INPUT" id="CEN_COMISIONAHORRO_INPUT" maxlength="2" size="2" value="{CEN_COMISIONAHORRO}"/>&nbsp;%
						&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='comision_ahorro_expli']/node()"/>
					</td>
                                </tr>
                                <tr id="comisionTransicciones" class="comisiones" style="display:none;">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='comision_transacciones']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
						<input type="text" name="CEN_COMISIONTRANSACCIONES_INPUT" id="CEN_COMISIONTRANSACCIONES_INPUT" maxlength="2" size="2" value="{CEN_COMISIONTRANSACCIONES}"/>&nbsp;%
						&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='comision_transaciones_expli']/node()"/>
					</td>
                                </tr>
                                <tr>
                                    <td class="labelRight" valign="top"><xsl:value-of select="document($doc)/translation/texts/item[@name='modelo_de_negocio_expli']/node()"/>:</td>
                                    <td colspan="3" class="datosLeft">
                                            <textarea name="CEN_MODELODENEGOCIO_EXPLIC" id="CEN_MODELODENEGOCIO_EXPLIC" rows="3" cols="60">
                                                    <xsl:copy-of select="CEN_MODELODENEGOCIO_EXPLIC/node()" disable-output-escaping="yes"/>
                                            </textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='prescriptor']/node()"/>:</td>
                                    <td colspan="3" class="datosLeft">
                                            <input type="text" name="CEN_PRESCRIPTOR" id="CEN_PRESCRIPTOR" maxlength="50" size="26" value="{CEN_PRESCRIPTOR}"/>
                                            &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='prescriptor_expli']/node()"/>
                                    </td>
                                </tr>
                                <!--forma de pago-->
                                <tr>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='forma_de_pago']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
                                                <xsl:call-template name="desplegable">
                                                    <xsl:with-param name="path" select="FORMASPAGOMVM/field"/>
                                                    <xsl:with-param name="claSel">select200</xsl:with-param>
                                                </xsl:call-template>
					</td>
				</tr>
                                <tr>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_de_pago']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
                                                <xsl:call-template name="desplegable">
                                                    <xsl:with-param name="path" select="PLAZOSPAGOMVM/field"/>
                                                    <xsl:with-param name="claSel">select200</xsl:with-param>
                                                </xsl:call-template>
					</td>
				</tr>
                                <tr>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_facturacion']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
                                                <xsl:call-template name="desplegable">
                                                    <xsl:with-param name="path" select="CEN_IDUSUARIOFACTURACION/field"/>
                                                    <xsl:with-param name="claSel">select200</xsl:with-param>
                                                </xsl:call-template>
					</td>
				</tr>

                                <tr>
                                    <td class="labelRight" valign="top"><xsl:value-of select="document($doc)/translation/texts/item[@name='detalle_forma_de_pago']/node()"/>:</td>
                                    <td colspan="3" class="datosLeft">
                                            <textarea name="CEN_DETALLEFORMAPAGOAMVM" id="CEN_DETALLEFORMAPAGOAMVM" rows="3" cols="60">
                                                    <xsl:copy-of select="CEN_DETALLEFORMAPAGOAMVM/node()" disable-output-escaping="yes"/>
                                            </textarea>
                                    </td>
                                </tr>
                                <!-- cuenta corriente de pago y texto factura-->
                                <tr>
                                    <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='cuenta_corriente']/node()"/>:</td>
                                    <td colspan="3" class="datosLeft">
                                            <input type="text" name="CUENTAPAGOAMVM" id="CUENTAPAGOAMVM" maxlength="50" size="25" value="{CEN_CUENTAPAGOAMVM}"/>
                                            &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cuenta_corriente_expli']/node()"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelRight" valign="top"><xsl:value-of select="document($doc)/translation/texts/item[@name='texto_factura']/node()"/>:</td>
                                    <td colspan="3" class="datosLeft">
                                            <textarea name="TEXTOFACTURAMVM" id="TEXTOFACTURAMVM" rows="5" cols="60">
                                                    <xsl:copy-of select="CEN_TEXTOFACTURAMVM/node()" disable-output-escaping="yes"/>
                                            </textarea>
                                    </td>
                                </tr>

				<!--campos para club de compras 18-05-15-->
				<tr style="background:#C3D2E9;">
                                        <td>&nbsp;</td>
					<td style="text-align:left; font-weight:bold;color:#000;"><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_para_club_privados']/node()"/></td>
					<td colspan="2">&nbsp;</td>
				</tr>

				<tr>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='limite_compras_mensuales']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
						<input type="text" name="CEN_LIMITECOMPRASMENSUALES" id="CEN_LIMITECOMPRASMENSUALES" maxlength="15" size="10" value="{CEN_LIMITECOMPRASMENSUALES}"/>
						&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='limite_compras_mensuales_expli']/node()"/>
					</td>
				</tr>

				<tr>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_primera_cuota']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
						<span style="float:left;">
							<script type="text/javascript">
								calFechaPrimeraCuota.dateFormat="dd/MM/yyyy";
								calFechaPrimeraCuota.labelCalendario='fecha primera cuota';
								calFechaPrimeraCuota.minDate=new Date(new Date().setDate(new Date().getDate()- (30*2)));
								calFechaPrimeraCuota.writeControl();
							</script>
						</span>
						<!--<input type="text" name="CEN_FECHAPRIMERACUOTA" id="CEN_FECHAPRIMERACUOTA" maxlength="10" size="10" value="{CEN_FECHAPRIMERACUOTA}"/>-->
						<span style="float:left;margin-top:8px;">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_primera_cuota_expli']/node()"/></span>
					</td>
				</tr>

				<tr>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_cuota_activa']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
						<span style="float:left;">
							<script type="text/javascript">
								calFechaCuotaActiva.dateFormat="dd/MM/yyyy";
								calFechaCuotaActiva.labelCalendario='fecha cuota activa';
								calFechaCuotaActiva.minDate=new Date(new Date().setDate(new Date().getDate()- (30*2)));
								calFechaCuotaActiva.writeControl();
							</script>
						</span>
						<!--<input type="text" name="CEN_FECHACUOTAACTIVA" id="CEN_FECHACUOTAACTIVA" maxlength="10" size="10" value="{CEN_FECHACUOTAACTIVA}"/>-->
						<span style="float:left;margin-top:8px;">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_cuota_activa_expli']/node()"/></span>
					</td>
				</tr>
			</table>

		<!--lugares de entrega-->
		<xsl:if test="//ID>0"><!-- Solo si el centro ya existia -->
			<xsl:call-template name="LUGARENTREGA"/>
		</xsl:if><!-- Solo si el centro ya existia -->

		<!--centro de consumo-->
		<xsl:if test="//ID>0"><!-- Solo si el centro ya existia -->
			<xsl:call-template name="CENTROCONSUMO"/>
		</xsl:if><!-- Solo si el centro ya existia -->
		</div><!--fin div cliente-->

		<!--solo para el proveedor-->
		<div id="soloProveedor">
			<xsl:attribute name="style">
				<xsl:choose>
				<xsl:when test="/Mantenimiento/form/CENTRO/ROL = 'VENDEDOR'">display:block;</xsl:when>
				<xsl:when test="/Mantenimiento/form/CENTRO/ROL = 'COMPRADOR'">display:none;</xsl:when>
				</xsl:choose>
			</xsl:attribute>

			<table class="infoTable">
				<tr class="tituloTabla">
					<th colspan="4"><xsl:value-of select="document($doc)/translation/texts/item[@name='opciones_especificas_proveedores']/node()"/></th>
				</tr>

				<tr>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_distribuidor']/node()"/>:<span class="camposObligatorios">*</span></td>
					<td colspan="3" class="datosLeft">
						<xsl:apply-templates select="CEN_DISTRIBUIDOR"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='opcion_distribuidor']/node()"/>
					</td>
				</tr>

			<xsl:if test="./MVM"><!-- Estado: solo para MVM -->
				<tr>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>:<span class="camposObligatorios">*</span></td>
					<td colspan="3" class="datosLeft">
						<xsl:apply-templates select="ESTADO"/>
					</td>
				</tr>
			</xsl:if><!-- Estado: solo para MVM -->
			</table>
		</div><!--fin de parte proveedor-->

		<br /><br />

		<table class="infoTable">
			<tr>
				<td class="veinte">&nbsp;</td>
				<td>
					<div class="boton">
						<a href="javascript:document.location='about:blank'">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
						</a>
					</div>
				</td>
				<td>
					<div class="boton">
						<a href="javascript:ActualizarDatos(document.forms['frmManten']);">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
						</a>
					</div>
				</td>

			<xsl:choose>
			<xsl:when test="CEN_ID[. != 0]">
				<xsl:apply-templates select="//botones_nuevo/ExtraButtons_nuevo"/>
			</xsl:when>
			<xsl:otherwise>
				<td>&nbsp;</td>
			</xsl:otherwise>
			</xsl:choose>
			</tr>

			<tr><td colspan="3">&nbsp;</td></tr>
		</table>
	</div>
</xsl:template>

<xsl:template match="ExtraButtons_nuevo">
<!-- Cada button corresponde a un form con campos ocultos /field y un submit /button -->
<xsl:for-each select="formu">
	<xsl:choose>
	<xsl:when test="@name='dummy'">
		<!-- Colocamos form chorra porque el javascript tiene problemas con el primer formulario anidado -->
		<form method="post">
			<xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
			<xsl:attribute name="action"><xsl:value-of select="@action"/></xsl:attribute>
		</form>
	</xsl:when>
	<xsl:otherwise>
		<td>
			<form method="post">
				<xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
				<xsl:attribute name="action"><xsl:value-of select="@action"/></xsl:attribute>

				<!-- Ponemos los campos input ocultos -->
				<xsl:for-each select="field">
					<input>
						<!-- Anyade las opciones comunes al campo input -->
						<xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
						<xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
						<!-- Anyadimos los valores, que son diferentes para cada field -->
						<xsl:choose>
						<!-- Campo CEN_ID -->
						<xsl:when test="ID">
							<xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>
						</xsl:when>
						</xsl:choose>
					</input>
				</xsl:for-each>
			</form>
		</td>
	</xsl:otherwise>
	</xsl:choose>
</xsl:for-each>
</xsl:template>

<xsl:template match="Sorry">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="sendRequest">
	<input type="submit">
		<xsl:attribute name="value"><xsl:value-of select="@label"/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="CEN_ID">
	<input type="hidden" name="CEN_ID" size="59" maxlength="70">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="ESTADO">
	<xsl:call-template name="desplegable"><xsl:with-param name="path" select="./field"/></xsl:call-template>
</xsl:template>

<xsl:template match="EMP_ID">
	<input type="hidden" name="EMP_ID">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="CEN_NOMBRE">
	<input type="hidden" name="CEN_NOMBRE_OLD" value="{.}"/>
	<input type="text" name="CEN_NOMBRE" size="50" maxlength="100">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="CEN_NOMBRECORTO">
	<input type="hidden" name="CEN_NOMBRECORTO_OLD" value="{.}"/>
	<input type="text" name="CEN_NOMBRECORTO" size="20" maxlength="40">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="CEN_DIRECCION">
	<input type="text" name="CEN_DIRECCION" size="50" maxlength="300">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="CEN_CPOSTAL">
	<input type="text" name="CEN_CPOSTAL" maxlength="15">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="CEN_NIF">
	<!--idioma-->
	<xsl:variable name="lang"><xsl:value-of select="/Mantenimiento/LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<input type="text" name="CEN_NIF" maxlength="20" size="20" value="{.}"/>
	&nbsp;<span class="textoComentario"><xsl:value-of select="document($doc)/translation/texts/item[@name='formato_recomendado']/node()"/></span>
</xsl:template>

<xsl:template match="CEN_POBLACION">
	<input type="text" name="CEN_POBLACION" maxlength="200">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="CEN_PROVINCIA">
	<input type="text" name="CEN_PROVINCIA" maxlength="100">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="CEN_TELEFONO">
	<input type="text" name="CEN_TELEFONO" maxlength="50" size="25">
		<xsl:attribute name="value">
			<xsl:choose>
			<xsl:when test=".!=''"><xsl:value-of select="."/></xsl:when>
			<xsl:otherwise><xsl:value-of select="../EMP_TELEFONO"/></xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="CEN_FAX">
	<input type="text" name="CEN_FAX" maxlength="50">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template name="FORMASPAGO">
	<xsl:call-template name="desplegable">
            <xsl:with-param name="path" select="/Mantenimiento/form/CENTRO/FORMASPAGO/field"/>
            <xsl:with-param name="claSel">select200</xsl:with-param>
        </xsl:call-template>
</xsl:template>

<xsl:template name="PLAZOSPAGO">
	<xsl:call-template name="desplegable">
            <xsl:with-param name="path" select="/Mantenimiento/form/CENTRO/PLAZOSPAGO/field"/>
            <xsl:with-param name="claSel">select200</xsl:with-param>
        </xsl:call-template>
</xsl:template>

<xsl:template name="PLAZOSENTREGA">
	<xsl:call-template name="desplegable">
            <xsl:with-param name="path" select="/Mantenimiento/form/CENTRO/PLAZOSENTREGA/field"/>
            <xsl:with-param name="claSel">select200</xsl:with-param>
        </xsl:call-template>
</xsl:template>

<xsl:template match="CEN_CAMAS">
	<input type="text" name="CEN_CAMAS" maxlength="10" size="26">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="CEN_QUIROFANOS">
	<input type="text" name="CEN_QUIROFANOS" maxlength="10" size="26">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="CEN_PEDIDOSPREVISTOSMES">
	<input type="text" name="CEN_PEDIDOSPREVISTOSMES" maxlength="10" size="26">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="CEN_CDC">
	<input type="checkbox" name="CEN_CDC">
		<xsl:choose>
		<xsl:when test=".='S'"><xsl:attribute name="checked">S</xsl:attribute></xsl:when>
		<xsl:otherwise><xsl:attribute name="unchecked">N</xsl:attribute></xsl:otherwise>
		</xsl:choose>
	</input>
</xsl:template>

<xsl:template match="CEN_COMPROMISO">
	<input type="checkbox" name="CEN_COMPROMISO">
		<xsl:choose>
		<xsl:when test=".='S'"><xsl:attribute name="checked">S</xsl:attribute></xsl:when>
		<xsl:otherwise><xsl:attribute name="unchecked">N</xsl:attribute></xsl:otherwise>
		</xsl:choose>
	</input>
</xsl:template>

<xsl:template match="CEN_SINCOMISIONES">
	<input type="checkbox" name="CEN_SINCOMISIONES">
		<xsl:choose>
		<xsl:when test=".='S'"><xsl:attribute name="checked">S</xsl:attribute></xsl:when>
		<xsl:otherwise><xsl:attribute name="unchecked">N</xsl:attribute></xsl:otherwise>
		</xsl:choose>
	</input>
</xsl:template>

<xsl:template match="CEN_MOSTRARCENTROSCONSUMO">
	<input type="checkbox" name="CEN_MOSTRARCENTROSCONSUMO">
		<xsl:choose>
		<xsl:when test=".='S'"><xsl:attribute name="checked">S</xsl:attribute></xsl:when>
		<xsl:otherwise><xsl:attribute name="unchecked">N</xsl:attribute></xsl:otherwise>
		</xsl:choose>
	</input>
</xsl:template>

<xsl:template match="CEN_DISTRIBUIDOR">
	<input type="checkbox" name="CEN_DISTRIBUIDOR">
		<xsl:choose>
		<xsl:when test=".='S'"><xsl:attribute name="checked">S</xsl:attribute></xsl:when>
		<xsl:otherwise><xsl:attribute name="unchecked">N</xsl:attribute></xsl:otherwise>
		</xsl:choose>
	</input>
</xsl:template>

<xsl:template name="LUGARENTREGA">
	<!--idioma-->
	<xsl:variable name="lang"><xsl:value-of select="../../LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<table class="infoTable">
		<tr class="tituloTabla">
			<th colspan="5">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='lugares_de_entrega']/node()"/>
				<span class="camposObligatorios">*</span>&nbsp;&nbsp;&nbsp;[&nbsp;
				<a href="javascript:NuevoLugarEntrega();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir_lugar']/node()"/>
				</a>&nbsp;]
			</th>
		</tr>

		<tr class="subTituloTabla">
			<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></td>
			<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></td>
			<td><xsl:value-of select="document($doc)/translation/texts/item[@name='lugar_de_entrega']/node()"/></td>
			<td class="dies"><xsl:copy-of select="document($doc)/translation/texts/item[@name='por_defecto_materialsanitario']/node()"/></td>
			<td class="dies"><xsl:copy-of select="document($doc)/translation/texts/item[@name='por_defecto_farmacia']/node()"/></td>
		</tr>

	<xsl:for-each select="/Mantenimiento/form/CENTRO/LUGARESENTREGA/LUGARENTREGA">
		<tr>
			<td>
				<a>
					<xsl:attribute name="href">javascript:EditarLugarEntrega('<xsl:value-of select="IDCENTRO"/>','<xsl:value-of select="ID"/>');</xsl:attribute>
					<xsl:value-of select="REFERENCIA"/>
				</a>
			</td>
			<td>
				<a>
					<xsl:attribute name="href">javascript:EditarLugarEntrega('<xsl:value-of select="IDCENTRO"/>','<xsl:value-of select="ID"/>');</xsl:attribute>
					<xsl:value-of select="NOMBRE"/>
				</a>
			</td>
			<td align="datosLeft"><xsl:copy-of select="DIRECCION"/></td>
			<td>
				<xsl:choose>
				<xsl:when test="PORDEFECTO='S'"><li/></xsl:when>
				<xsl:otherwise>&nbsp;</xsl:otherwise>
				</xsl:choose>
			</td>
			<td>
				<xsl:choose>
				<xsl:when test="PORDEFECTO_FARMACIA='S'"><li/></xsl:when>
				<xsl:otherwise>&nbsp;</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
	</xsl:for-each>
	</table>
</xsl:template>

<xsl:template name="CENTROCONSUMO">
	<!--idioma-->
	<xsl:variable name="lang"><xsl:value-of select="../../LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<table class="infoTable">
		<tr class="tituloTabla">
			<th colspan="4">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='centros_de_consumo']/node()"/>
				<span class="camposObligatorios">*</span>&nbsp;&nbsp;&nbsp;[&nbsp;
				<a href="javascript:NuevoCentroConsumo();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir_centro']/node()"/>
				</a>&nbsp;]
			</th>
		</tr>

		<tr class="subTituloTabla">
			<td class="cuarenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></td>
			<td class="veintecinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_consumo']/node()"/></td>
			<td><xsl:value-of select="document($doc)/translation/texts/item[@name='por_defecto']/node()"/></td>
		</tr>

	<xsl:for-each select="/Mantenimiento/form/CENTRO/CENTROSCONSUMO/CENTROCONSUMO">
		<tr>
			<td>
				<a>
					<xsl:attribute name="href">javascript:EditarCentroConsumo('<xsl:value-of select="IDCENTRO"/>','<xsl:value-of select="ID"/>');</xsl:attribute>
					<xsl:value-of select="REFERENCIA"/>
				</a>
			</td>
			<td>
				<a>
					<xsl:attribute name="href">javascript:EditarCentroConsumo('<xsl:value-of select="IDCENTRO"/>','<xsl:value-of select="ID"/>');</xsl:attribute>
					<xsl:value-of select="NOMBRE"/>
				</a>
			</td>
			<td>
				<xsl:choose>
				<xsl:when test="PORDEFECTO='S'"><li/></xsl:when>
				<xsl:otherwise>&nbsp;</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
	</xsl:for-each>
	</table>
</xsl:template>

<!--documentos-->
<xsl:template name="documentos">
	<xsl:param name="num" />
    <xsl:param name="type" />

     <!--idioma-->
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
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
					<input id="inputFileDoc_{$type}" name="inputFileDoc" type="file" onChange="addDocFile('{$type}','frmManten');" />
				</div>
                <div id="waitBoxDocLOGO" style="display:none;">&nbsp;</div>
                <div id="confirmBoxLOGO" style="display:none;">&nbsp;</div>
                <div class="boton" style="clear:both;">
                    <!--boton input carga logo-->
                    <a href="javascript:cargaDoc(document.forms['frmManten'],'{$type}');">
                      <xsl:value-of select="document($doc)/translation/texts/item[@name='subir_logo']/node()"/>
                    </a>
                </div>
			</div>
		</xsl:when>

	</xsl:choose>
    </xsl:template>
<!--fin de documentos-->
</xsl:stylesheet>
