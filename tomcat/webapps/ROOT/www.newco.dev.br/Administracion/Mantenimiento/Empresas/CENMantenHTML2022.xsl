<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Mantenimiento de centro
	Ultima revision: ET 27feb23 16:20 CENManten2022_270223.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>

<xsl:template match="/">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/Mantenimiento/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title>
		<xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_de_centros']/node()"/>:&nbsp;
		<xsl:choose>
		<xsl:when test="/Mantenimiento/form/CENTRO/CEN_ID !=''">
			<xsl:value-of select="/Mantenimiento/form/CENTRO/CEN_NOMBRECORTO"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_centro']/node()"/>
		</xsl:otherwise>
		</xsl:choose>
	</title>

	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
	<meta name="description" content="insert brief description here"/>
	<meta name="keywords" content="insert, keywords, here"/>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CargaDocumentos_260419.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENManten2022_270223.js"></script>
	<!--Calendario no deberia ser necesario <script type="text/javascript" src="http://www.newco.dev.br/General/calendario/spiffyCal_v2_1.js"></script>-->
</head>

<body onload="recargaDesplegables();">
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

<!--27feb23
<div id="spiffycalendar" class="text"></div>
<script type="text/javascript">
	var calFechaPrimeraCuota	= new ctlSpiffyCalendarBox("calFechaPrimeraCuota", "<xsl:value-of select="@name"/>", "CEN_FECHAPRIMERACUOTA","btnDateFechaPrimeraCuota",'<xsl:value-of select="/Mantenimiento/form/CENTRO/CEN_FECHAPRIMERACUOTA"/>',scBTNMODE_CLASSIC,'');
	var calFechaCuotaActiva		= new ctlSpiffyCalendarBox("calFechaCuotaActiva", "<xsl:value-of select="@name"/>", "CEN_FECHACUOTAACTIVA","btnDateFechaCuotaActiva",'<xsl:value-of select="/Mantenimiento/form/CENTRO/CEN_FECHACUOTAACTIVA"/>',scBTNMODE_CLASSIC,'');
</script>
-->
<form name="Oculto" method="post">
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
    <input type="hidden" name="CEN_NUEVO"/>
	<input type="hidden" name="ACCION" value="MODIFICAR"/>

    <input type="hidden" name="ACTUALIZADO">
    <xsl:attribute name="value">
    	<xsl:choose><xsl:when test="/Mantenimiento/ACTUALIZADO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>
    </xsl:attribute>
    </input>

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
	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:choose>
			<xsl:when test="CEN_ID !=''">
				<xsl:value-of select="/Mantenimiento/form/CENTRO/CEN_NOMBRECORTO"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_centro']/node()"/>
			</xsl:otherwise>
			</xsl:choose>
            <xsl:if test="CEN_ID !=''">
				&nbsp;<span class="amarillo">CEN_ID=<xsl:value-of select="CEN_ID"/></span>&nbsp;
				<span class="fuentePeq">(<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_modificacion']/node()"/>:&nbsp;<xsl:value-of select="/Mantenimiento/form/CENTRO/CEN_FECHAULTIMOCAMBIO" />)
			</span>
			</xsl:if>
			<span class="CompletarTitulo">
				<!--	Botones		-->
                <xsl:choose>
                    <xsl:when test="CEN_ID !=''">
                        <a class="btnDestacado" href="javascript:ActualizarDatos(document.forms['frmManten']);">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
                        </a>
                    </xsl:when>
                    <xsl:otherwise><!--si es nuevo centro envio a otra página para recargar bien	-->
                        <a class="btnDestacado" href="javascript:ActualizarNuevoCentro(document.forms['frmManten']);">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
                        </a>
                    </xsl:otherwise>
                </xsl:choose>
				&nbsp;
				<a class="btnNormal" href="javascript:document.location='about:blank'">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
				</a>
				&nbsp;
					<a class="btnNormal" style="text-decoration:none;" title="Ficha centro">
						<xsl:attribute name="href">javascript:FichaCentro(<xsl:value-of select="CEN_ID"/>);</xsl:attribute>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='ver_ficha']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="javascript:window.print();" style="text-decoration:none;" title="Imprimir">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
					</a>
					&nbsp;
				<!--</xsl:if>-->
				<xsl:if test="CEN_ID !=''">
					<a class="btnNormal">
						<xsl:attribute name="href">javascript:verLogs();</xsl:attribute>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Ver_logs']/node()"/>
					</a>
					&nbsp;
				</xsl:if>
			</span>
		</p>
	</div>

	<div class="divLeft">
		<!--<xsl:apply-templates select="CEN_ID"/>-->
		<!--<xsl:apply-templates select="EMP_ID"/>-->
		<input type="hidden" name="CEN_ID" value="{CEN_ID}"/>
		<input type="hidden" name="EMP_ID" value="{EMP_ID}"/>

            <input type="hidden" name="REMOVE" value="{document($doc)/translation/texts/item[@name='remove']/node()}"/>
                
			<table class="w90 tableCenter" cellspacing="6px" cellpadding="6px">
			<tr class="sinLinea">
				<td colspan="5" class="textCenter">
					<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='los_siguientes_caracteres_no_deben_sin_barra']/node()"/></span>
				</td>
			</tr>

			<tr class="sinLinea">
				<td class="quince" rowspan="3">
					<img src="{/Mantenimiento/form/CENTRO/URL_LOGOTIPO}" height="80px" width="160px"/>
				</td>
				<td class="labelRight dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:<span class="camposObligatorios">*</span></td>
				<td class="datosLeft veinte">
					<xsl:choose>
					<xsl:when test="CEN_ID !=''"><xsl:apply-templates select="CEN_NOMBRE"/></xsl:when>
					<xsl:otherwise>
						<input type="hidden" name="CEN_NOMBRE_OLD" value="{EMP_NOMBRE}"/>
						<input type="text" class="campopesquisa" name="CEN_NOMBRE" size="50" maxlength="100" value="{EMP_NOMBRE}"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td class="labelRight doce"><xsl:value-of select="document($doc)/translation/texts/item[@name='nif']/node()"/>:<span class="camposObligatorios">*</span></td>
				<td class="datosLeft">
					<xsl:choose>
					<xsl:when test="CEN_ID !=''"><xsl:apply-templates select="CEN_NIF"/></xsl:when>
					<xsl:otherwise>
						<input type="text" class="campopesquisa w200px" name="CEN_NIF" maxlength="20" value="{EMP_NIF}"/>&nbsp;
						<span class="textoComentario"><xsl:value-of select="document($doc)/translation/texts/item[@name='formato_recomendado']/node()"/></span>
					</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>

			<tr class="sinLinea">
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_corto']/node()"/>:<span class="camposObligatorios">*</span></td>
				<td colspan="3" class="datosLeft">
					<xsl:choose>
					<xsl:when test="CEN_ID !=''"><xsl:apply-templates select="CEN_NOMBRECORTO"/></xsl:when>
					<xsl:otherwise>
						<input type="hidden" name="CEN_NOMBRECORTO_OLD" value="{EMP_NOMBRECORTOPUBLICO}"/>
						<input type="text" class="campopesquisa w300px"  name="CEN_NOMBRECORTO" size="20" maxlength="40" value="{EMP_NOMBRECORTOPUBLICO}"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			<tr class="sinLinea">
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='direccion']/node()"/>:<span class="camposObligatorios">*</span></td>
				<!--<td colspan="3" class="datosLeft">-->
				<td class="datosLeft">
					<xsl:choose>
					<xsl:when test="CEN_ID !=''"><xsl:apply-templates select="CEN_DIRECCION"/></xsl:when>
					<xsl:otherwise>
						<input type="text" class="campopesquisa" name="CEN_DIRECCION" size="50" maxlength="100" value="{EMP_DIRECCION}"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
        		<xsl:choose>
        		<xsl:when test="/Mantenimiento/form/CENTRO/EMP_IDPAIS!=55">
	        		<td colspan="2">&nbsp;<input type="hidden" name="CEN_BARRIO" value="{CEN_BARRIO}"/></td>
				</xsl:when>
				<xsl:otherwise>
					<td class="labelRight">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='barrio']/node()"/>:
					</td>
					<td class="datosLeft">
						<xsl:choose>
						<xsl:when test="NOEDICION">
							<xsl:value-of select="CEN_BARRIO"/>
						</xsl:when>
						<xsl:otherwise>
							<input type="text" class="campopesquisa" name="CEN_BARRIO" maxlength="50" size="24" value="{CEN_BARRIO}"/>
						</xsl:otherwise>
						</xsl:choose>
					</td>
				</xsl:otherwise>
        		</xsl:choose>
			</tr>

			<tr class="sinLinea">
				<td colspan="2" class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='provincia']/node()"/>:<span class="camposObligatorios">*</span></td>
				<td class="datosLeft">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="PROVINCIAS/PROVINCIA/field"/>
                   		<xsl:with-param name="claSel">w200px</xsl:with-param>
					</xsl:call-template>
				</td>
				<!--	8nov22 EMail publico	-->
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Email_publico']/node()"/>:</td>
				<td class="datosLeft">
					<input type="text" class="campopesquisa w300px" name="CEN_EMAILPUBLICO" maxlength="100" value="{CEN_EMAILPUBLICO}"/>
				</td>
			</tr>

			<tr class="sinLinea">
				<td colspan="2" class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='poblacion']/node()"/>:<span class="camposObligatorios">*</span></td>
				<td class="datosLeft">
					<xsl:choose>
					<xsl:when test="CEN_ID !=''"><xsl:apply-templates select="CEN_POBLACION"/></xsl:when>
					<xsl:otherwise>
						<input type="text" class="campopesquisa w150px" name="CEN_POBLACION" maxlength="200" value="{EMP_POBLACION}" size="25"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_postal']/node()"/>:</td>
				<td class="datosLeft">
					<xsl:choose>
					<xsl:when test="CEN_ID !=''"><xsl:apply-templates select="CEN_CPOSTAL"/></xsl:when>
					<xsl:otherwise>
						<input type="text" class="campopesquisa w150px" name="CEN_CPOSTAL" maxlength="15" value="{EMP_CPOSTAL}"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>

			<tr class="sinLinea">
				<td colspan="2" class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='telefono']/node()"/>:<span class="camposObligatorios">*</span></td>
				<td class="datosLeft">
					<xsl:apply-templates select="CEN_TELEFONO"/>
				</td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='fax']/node()"/>:</td>
				<td class="datosLeft">
					<xsl:choose>
					<xsl:when test="CEN_ID !=''"><xsl:apply-templates select="CEN_FAX"/></xsl:when>
					<xsl:otherwise>
						<input type="text" class="campopesquisa w150px" name="CEN_FAX" maxlength="50" value="{EMP_FAX}"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
    		<tr class="sinLinea">
        		<xsl:attribute name="style">
            		<xsl:if test="CEN_BLOQUEADO = 'S'">background:#FB6666;</xsl:if>
        		</xsl:attribute>
				<!--bloquear usuario-->
				<td colspan="2" class="labelRight">
                	<span>
                    	<xsl:attribute name="style">
                        	<xsl:if test="CEN_BLOQUEADO = 'S'">color:#000;</xsl:if>
                    	</xsl:attribute>
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='bloquear']/node()"/>:
                	</span>
            	</td>
				<td colspan="3" class="datosLeft">
					<input type="checkbox" class="muypeq" name="CEN_BLOQUEADO">
					<xsl:choose>
						<xsl:when test="CEN_BLOQUEADO ='S' ">
							<xsl:attribute name="checked">checked</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="unchecked">unchecked</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
					</input>
					<xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='bloquear_centro_expli']/node()"/>
				</td>
			</tr>
                <!--logo-->
                <tr class="sinLinea">
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
    <tr id="cargaLogo" class="sinLinea">
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
			<tr class="sinLinea">
				<td colspan="2" class="labelRight" valign="top"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_comercial_centro']/node()"/>:</td>
				<td colspan="3" class="datosLeft">
					<textarea name="CEN_DESCRIPCIONCOMERCIAL" id="CEN_DESCRIPCIONCOMERCIAL" rows="5" cols="60">
						<xsl:copy-of select="CEN_DESCRIPCIONCOMERCIAL/node()" disable-output-escaping="yes"/>
					</textarea>
				</td>
			</tr>

			<tr class="sinLinea"><td colspan="5">&nbsp;</td></tr>
		</table>

		<!--solo para el cliente-->
		<div id="soloCliente">
			<xsl:attribute name="style">
				<xsl:choose>
				<xsl:when test="/Mantenimiento/form/CENTRO/ROL = 'VENDEDOR'">display:none;</xsl:when>
				<xsl:when test="/Mantenimiento/form/CENTRO/ROL = 'COMPRADOR'">display:block;</xsl:when>
				</xsl:choose>
			</xsl:attribute>

			<table class="w90 tableCenter" cellspacing="6px" cellpadding="6px">
				<tr class="subTituloTabla">
					<td colspan="4"><xsl:value-of select="document($doc)/translation/texts/item[@name='opciones_especificas_clientes']/node()"/></td>
				</tr>

                <!-- códgo identificador del centro-->
                <tr class="sinLinea">
                    <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_centro']/node()"/>:</td>
                    <td colspan="3" class="datosLeft">
                        <input type="text" class="campopesquisa w100px" name="CEN_CODIGO" id="CEN_CODIGO" maxlength="50" value="{CEN_CODIGO}"/>
                        &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_centro_expli']/node()"/>
                    </td>
                </tr>

				<tr class="sinLinea">
      				<td class="labelRight veinte">
        			  <xsl:value-of select="document($doc)/translation/texts/item[@name='Area_geografica']/node()"/>:
        			</td>
      				<td colspan="2" align="left">
            			<xsl:call-template name="desplegable">
                			<xsl:with-param name="path" select="CEN_IDSELAREAGEOGRAFICA/field"/>
                   		    <xsl:with-param name="claSel">w200px</xsl:with-param>
            			</xsl:call-template>
						&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Area_geografica_expli']/node()"/>
    			  </td>
    			</tr>

                <!-- codificación de pedidos-->
                <tr class="sinLinea">
                    <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='codificacion_pedidos']/node()"/>:</td>
                    <td colspan="3" class="datosLeft">
                        <input type="text" class="campopesquisa w100px" name="CEN_CODIFICACIONPEDIDOS" id="CEN_CODIFICACIONPEDIDOS" maxlength="50" size="25" value="{CEN_CODIFICACIONPEDIDOS}"/>
                        &nbsp;<span class="fuentePeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='codificacion_pedidos_expli']/node()"/></span>
                    </td>
                </tr>

                <!-- último código utilizado de pedidos-->
                <tr class="sinLinea">
                    <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='ultimo_pedido']/node()"/>:</td>
                    <td colspan="3" class="datosLeft">
						&nbsp;<strong><xsl:value-of select="CEN_ULTIMOPEDIDOANNO"/></strong>
                        &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ultimo_pedido_expli']/node()"/>&nbsp;:
                        <input type="text" class="campopesquisa w80px" name="CEN_ULTIMOPEDIDOANNO" id="CEN_ULTIMOPEDIDOANNO" maxlength="6" value=""/>
                    </td>
                </tr>

				<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='forma_de_pago']/node()"/>:<span class="camposObligatorios">*</span></td>
					<td class="datosLeft">
						<xsl:call-template name="FORMASPAGO"/>
					</td>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_de_pago']/node()"/>:<span class="camposObligatorios">*</span></td>
					<td class="datosLeft">
						<xsl:call-template name="PLAZOSPAGO"/>
					</td>
				</tr>

				<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_objetivo_mensual']/node()"/>:</td>
					<td class="datosLeft">
						<xsl:apply-templates select="CEN_PEDIDOSPREVISTOSMES"/>
					</td>
					<td colspan="2">&nbsp;</td>
				</tr>

				<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='numero_de_camas']/node()"/>:</td>
					<td class="datosLeft">
						<xsl:apply-templates select="CEN_CAMAS"/>
					</td>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='quirofanos']/node()"/>:</td>
					<td class="datosLeft">
						<xsl:apply-templates select="CEN_QUIROFANOS"/>
					</td>
				</tr>

				<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_cdc']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
						<xsl:apply-templates select="CEN_CDC"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='opcion_cdc']/node()"/>
					</td>
				</tr>

			<!-- 1dic17 Ningun cliente utiliza ya la opción de compromiso
			<xsl:if test="/Mantenimiento/form/CENTRO/EMP_IDPAIS = '34'">
				<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='requiere_compromiso']/node()"/>:<span class="camposObligatorios">*</span></td>
					<td colspan="3" class="datosLeft">
						<xsl:apply-templates select="CEN_COMPROMISO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='firmar_compromiso_para_ver']/node()"/>
					</td>
				</tr>
			</xsl:if>-->

				<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='sin_comisiones']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
						<xsl:apply-templates select="CEN_SINCOMISIONES"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='centro_no_comisiones']/node()"/>
					</td>
				</tr>

				<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='mostrar_centro_consumo']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
						<xsl:apply-templates select="CEN_MOSTRARCENTROSCONSUMO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='mostrar_centro_consumo_expli']/node()"/>
					</td>
				</tr>

				<!--comprador por defecto-->
				<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='comprador_por_defecto']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
						<xsl:call-template name="desplegable">
                            <xsl:with-param name="path" select="CEN_IDCOMPRADORPORDEFECTO/field"/>
                            <xsl:with-param name="claSel">w200px</xsl:with-param>
                        </xsl:call-template>
						&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='comprador_por_defecto_expli']/node()"/>
					</td>
				</tr>

			
			<!-- separador	-->
			<tr class="sinLinea"><td>&nbsp;</td></tr>
            <tr class="subTituloTabla">
				<td colspan="4"><xsl:value-of select="document($doc)/translation/texts/item[@name='integracion']/node()"/></td>
			</tr>
			<!--usuarios integración 14-5-15 para clientes y proveedores-->
			<tr class="sinLinea">
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_integracion_pdf']/node()"/>:</td>
				<td colspan="3" class="datosLeft">
					<xsl:call-template name="desplegable">
                        <xsl:with-param name="path" select="CEN_IDUSUARIOINTEGRACION_PDF/field"/>
                        <xsl:with-param name="claSel">w200px</xsl:with-param>
                    </xsl:call-template>
					&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_integracion_pdf_expli']/node()"/>
				</td>
			</tr>

			<tr class="sinLinea">
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_integracion_xml']/node()"/>:</td>
				<td colspan="3" class="datosLeft">
					<xsl:call-template name="desplegable">
                        <xsl:with-param name="path" select="CEN_IDUSUARIOINTEGRACION_XML/field"/>
                        <xsl:with-param name="claSel">w200px</xsl:with-param>
                    </xsl:call-template>
					&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_integracion_xml_expli']/node()"/>
				</td>
			</tr>
			<xsl:if test="/Mantenimiento/form/CENTRO/ROL='COMPRADOR'">

                <!-- código identificador del centro para integración-->
                <tr class="sinLinea">
                    <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_erp']/node()"/>:</td>
                    <td colspan="3" class="datosLeft">
                        <input type="text" class="campopesquisa w100px" name="CEN_NOMBREERP" id="CEN_NOMBREERP" maxlength="100" value="{CEN_NOMBREERP}"/>
                        &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_erp_expli']/node()"/>
                    </td>
                </tr>
                <!-- código identificador del centro para integración-->
                <tr class="sinLinea">
                    <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='url_webservice']/node()"/>:</td>
                    <td colspan="3" class="datosLeft">
                        <input type="text" class="campopesquisa w300px" name="CEN_URLWEBSERVICE" id="CEN_URLWEBSERVICE" maxlength="200" value="{CEN_URLWEBSERVICE}"/>
                        &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='url_webservice_expli']/node()"/>
                    </td>
                </tr>
                <!-- código identificador del centro para integración-->
                <tr class="sinLinea">
                    <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_centro_integracion']/node()"/>:</td>
                    <td colspan="3" class="datosLeft">
                        <input type="text" class="campopesquisa w100px" name="CEN_REFERENCIAINTEGRACION" id="CEN_REFERENCIAINTEGRACION" maxlength="50"  value="{CEN_REFERENCIAINTEGRACION}"/>
                        &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_centro_integracion_expli']/node()"/>
                    </td>
                </tr>
                <!-- modelo de integración utilizado para descarga de OC-->
                <tr class="sinLinea">
                    <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='modelo_integracion']/node()"/>:</td>
                    <td colspan="3" class="datosLeft">
                        <xsl:call-template name="desplegable">
                        <xsl:with-param name="path" select="CEN_IDMODELOOCINTEGRACION/field"/>
                        <xsl:with-param name="claSel">w200px</xsl:with-param>
                        </xsl:call-template>
                        &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='modelo_integracion_expli']/node()"/>
                    </td>
                </tr>
                <!-- modelo de integración utilizado para descarga de Vencedores-->
                <tr class="sinLinea">
                    <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='modelo_integracion_vencedores']/node()"/>:</td>
                    <td colspan="3" class="datosLeft">
                        <xsl:call-template name="desplegable">
                        <xsl:with-param name="path" select="CEN_IDMODELOWININTEGRACION/field"/>
                        <xsl:with-param name="claSel">w200px</xsl:with-param>
                        </xsl:call-template>
                        &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='modelo_integracion_vencedores_expli']/node()"/>
                    </td>
                </tr>
    			 <tr class="sinLinea">
					<td class="labelRight">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='sep_fich_carga_pedidos']/node()"/>:
					</td>
					<td class="datosLeft" colspan="2">
						&nbsp;&nbsp;<input type="text" class="campopesquisa w50px" name="CEN_SEPFICCARGAPEDIDOS" value="{CEN_SEPFICCARGAPEDIDOS}"/>&nbsp;
						<span class="fuentePeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='sep_fich_carga_pedidos_expli']/node()"/></span>
					</td>
    			 </tr>
    			 <tr class="sinLinea">
					<td class="labelRight">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='cabec_fich_carga_pedidos']/node()"/>:
					</td>
					<td class="datosLeft" colspan="2">
					  &nbsp;&nbsp;<input type="text" class="campopesquisa w300px" name="CEN_CABFICCARGAPEDIDOS" value="{CEN_CABFICCARGAPEDIDOS}"/><br/>
						<span class="fuentePeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='cabec_fich_carga_pedidos_expli']/node()"/></span>
					</td>
    			 </tr>
    			 <tr class="sinLinea">
					<td class="labelRight">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='columnas_fich_carga_pedidos']/node()"/>:
					</td>
					<td class="datosLeft" colspan="2">
					  &nbsp;&nbsp;<input type="text" class="campopesquisa w300px" name="CEN_MODELOFICCARGAPEDIDOS" value="{CEN_MODELOFICCARGAPEDIDOS}"/>&nbsp;
						<img src="http://www.newco.dev.br/images/info.gif">
							<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='columnas_fich_carga_pedidos_expli']/node()"/></xsl:attribute>
						</img>
					</td>
    			 </tr>
                <!-- categoría para informar productos provisionalmente en caso de errores en integración-->
                <tr class="sinLinea">
                    <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='categoria_provisional_integracion']/node()"/>:</td>
                    <td colspan="3" class="datosLeft">
                        <xsl:call-template name="desplegable">
                            <xsl:with-param name="path" select="LISTACATEGORIAS/field"/>
                            <xsl:with-param name="claSel">w200px</xsl:with-param>
                        </xsl:call-template>
						&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='categoria_provisional_integracion_expli']/node()"/>
                    </td>
                </tr>

				<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='retener_descarga_OC']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
						<xsl:apply-templates select="CEN_INT_RETENERDESCARGAOC"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='retener_descarga_OC_expli']/node()"/>
					</td>
				</tr>

				<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_envio_int']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
                        <xsl:call-template name="desplegable">
                            <xsl:with-param name="path" select="TIPO_ENVIO_SOAP/field"/>
                            <xsl:with-param name="claSel">w200px</xsl:with-param>
                        </xsl:call-template>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_envio_int_expli']/node()"/>
					</td>
				</tr>
				
				<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Cabecera_SOAP_OC']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
						<xsl:apply-templates select="CEN_INT_SOAP_HEADER"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Cabecera_SOAP_OC_expli']/node()"/>
					</td>
				</tr>

				<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='SOAP_Action_OC']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
						<xsl:apply-templates select="CEN_INT_SOAP_ACTION"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='SOAP_Action_OC_expli']/node()"/>
					</td>
				</tr>

				<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='SOAP_xmlns_OC']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
						<xsl:apply-templates select="CEN_INT_SOAP_XMLNS"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='SOAP_xmlns_OC_expli']/node()"/>
					</td>
				</tr>

				<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Envio_int_pre_XML']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
						<xsl:apply-templates select="CEN_INT_SOAP_PREXML"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Envio_int_pre_XML_expli']/node()"/>
					</td>
				</tr>

				<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Envio_int_post_XML']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
						<xsl:apply-templates select="CEN_INT_SOAP_POSTXML"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Envio_int_post_XML_expli']/node()"/>
					</td>
				</tr>				
				
			</xsl:if>



 			<!-- separador	-->
			<tr class="sinLinea"><td>&nbsp;</td></tr>
  				<!--campos para facturación centro 18-12-15-->
                <tr class="subTituloTabla">
					<td colspan="4"><xsl:value-of select="document($doc)/translation/texts/item[@name='modelo_de_negocio']/node()"/></td>
				</tr>
				<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='modelo_de_negocio']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="IDMODELONEGOCIO/field"/>
						<xsl:with-param name="onChange">javascript:verComisiones(document.forms['frmManten']);</xsl:with-param>
						<xsl:with-param name="claSel">w200px</xsl:with-param>
					</xsl:call-template>
							&nbsp;&nbsp;&nbsp;
							<input type="checkbox" class="muypeq" name="CEN_INCLUIRENFACTURACION">
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
						<input type="text" class="campopesquisa w50px" name="CEN_COMISIONAHORRO_INPUT" id="CEN_COMISIONAHORRO_INPUT" maxlength="2" value="{CEN_COMISIONAHORRO}"/>&nbsp;%
						&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='comision_ahorro_expli']/node()"/>
					</td>
                </tr>
                <tr id="comisionTransicciones" class="comisiones" style="display:none;">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='comision_transacciones']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
						<input type="text" class="campopesquisa w50px" name="CEN_COMISIONTRANSACCIONES_INPUT" id="CEN_COMISIONTRANSACCIONES_INPUT" maxlength="2" value="{CEN_COMISIONTRANSACCIONES}"/>&nbsp;%
						&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='comision_transaciones_expli']/node()"/>
					</td>
                </tr>
                <tr class="sinLinea">
                    <td class="labelRight" valign="top"><xsl:value-of select="document($doc)/translation/texts/item[@name='modelo_de_negocio_expli']/node()"/>:</td>
                    <td colspan="3" class="datosLeft">
                            <textarea name="CEN_MODELODENEGOCIO_EXPLIC" id="CEN_MODELODENEGOCIO_EXPLIC" rows="3" cols="60">
                                    <xsl:copy-of select="CEN_MODELODENEGOCIO_EXPLIC/node()" disable-output-escaping="yes"/>
                            </textarea>
                    </td>
                </tr>
                <tr class="sinLinea">
                    <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='prescriptor']/node()"/>:</td>
                    <td colspan="3" class="datosLeft">
                            <input type="text" class="campopesquisa" name="CEN_PRESCRIPTOR" id="CEN_PRESCRIPTOR" maxlength="50" size="26" value="{CEN_PRESCRIPTOR}"/>
                            &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='prescriptor_expli']/node()"/>
                    </td>
                </tr>
                <!--forma de pago-->
                <tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='forma_de_pago']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
                        <xsl:call-template name="desplegable">
                            <xsl:with-param name="path" select="FORMASPAGOMVM/field"/>
                            <xsl:with-param name="claSel">w200px</xsl:with-param>
                        </xsl:call-template>
					</td>
				</tr>
                                <tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_de_pago']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
                        <xsl:call-template name="desplegable">
                            <xsl:with-param name="path" select="PLAZOSPAGOMVM/field"/>
                            <xsl:with-param name="claSel">w200px</xsl:with-param>
                        </xsl:call-template>
					</td>
				</tr>
               	<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_facturacion']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
                        <xsl:call-template name="desplegable">
                            <xsl:with-param name="path" select="CEN_IDUSUARIOFACTURACION/field"/>
                            <xsl:with-param name="claSel">w200px</xsl:with-param>
                        </xsl:call-template>
					</td>
				</tr>

                <tr class="sinLinea">
                    <td class="labelRight" valign="top"><xsl:value-of select="document($doc)/translation/texts/item[@name='detalle_forma_de_pago']/node()"/>:</td>
                    <td colspan="3" class="datosLeft">
                        <textarea name="CEN_DETALLEFORMAPAGOAMVM" id="CEN_DETALLEFORMAPAGOAMVM" rows="3" cols="60">
                                <xsl:copy-of select="CEN_DETALLEFORMAPAGOAMVM/node()" disable-output-escaping="yes"/>
                        </textarea>
                    </td>
                </tr>
                <!-- cuenta corriente de pago y texto factura-->
                <tr class="sinLinea">
                    <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='cuenta_corriente']/node()"/>:</td>
                    <td colspan="3" class="datosLeft">
                        <input type="text" class="campopesquisa" name="CUENTAPAGOAMVM" id="CUENTAPAGOAMVM" maxlength="50" size="25" value="{CEN_CUENTAPAGOAMVM}"/>
                        &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cuenta_corriente_expli']/node()"/>
                    </td>
                </tr>
                <tr class="sinLinea">
                    <td class="labelRight" valign="top"><xsl:value-of select="document($doc)/translation/texts/item[@name='texto_factura']/node()"/>:</td>
                    <td colspan="3" class="datosLeft">
                        <textarea name="TEXTOFACTURAMVM" id="TEXTOFACTURAMVM" rows="5" cols="60">
                                <xsl:copy-of select="CEN_TEXTOFACTURAMVM/node()" disable-output-escaping="yes"/>
                        </textarea>
                    </td>
                </tr>

				<!--campos para club de compras 18-05-15
				<tr style="background:#C3D2E9;">
                    <td>&nbsp;</td>
					<td style="text-align:left; font-weight:bold;color:#000;"><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_para_club_privados']/node()"/></td>
					<td colspan="2">&nbsp;</td>
				</tr>

				<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='limite_compras_mensuales']/node()"/>:</td>
					<td colspan="3" class="datosLeft">
						<input type="text" class="campopesquisa" name="CEN_LIMITECOMPRASMENSUALES" id="CEN_LIMITECOMPRASMENSUALES" maxlength="15" size="10" value="{CEN_LIMITECOMPRASMENSUALES}"/>
						&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='limite_compras_mensuales_expli']/node()"/>
					</td>
				</tr>

				<tr class="sinLinea">
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
						<span style="float:left;margin-top:8px;">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_primera_cuota_expli']/node()"/></span>
					</td>
				</tr>

				<tr class="sinLinea">
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
						<span style="float:left;margin-top:8px;">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_cuota_activa_expli']/node()"/></span>
					</td>
				</tr>
				-->
			</table>
		
			<!-- separador	-->
			<tr class="sinLinea"><td>&nbsp;</td></tr>
	    	 <!-- Tabla CLiente para las licitaciones -->
			<table class="w90 tableCenter" cellspacing="6px" cellpadding="6px">
        	<thead>
        	  <tr class="subTituloTabla">
              	<td colspan="4">
                  	<xsl:value-of select="document($doc)/translation/texts/item[@name='datos_por_defecto_licitaciones']/node()"/>
              	</td>
        	  </tr>
        	  </thead>

        	  <tbody>
            	  <xsl:choose>
                	<xsl:when test="/Mantenimiento/form/CENTRO/ROL='COMPRADOR'">
            	   <tr class="sinLinea">
                	   <td>&nbsp;</td>
                	   <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:<span class="camposObligatorios">*</span>
                    	</td>
                    	<td class="datosLeft">
                        	<xsl:choose>
                                	<xsl:when test="NOEDICION">
                                        	<xsl:for-each select="CEN_IDUSUARIOLICITACIONESAUT/field/dropDownList/listElem">
                                                	<xsl:if test="../../../SelectedElement=ID">
                                                        	<xsl:value-of select="listItem"/>
                                                	</xsl:if>
                                        	</xsl:for-each>
                                	</xsl:when>
                                	<xsl:otherwise>
                                        <xsl:call-template name="desplegable">
                                        <xsl:with-param name="path" select="CEN_IDUSUARIOLICITACIONESAUT/field"/>
                                        <xsl:with-param name="claSel">w200px</xsl:with-param>
                                        </xsl:call-template>
                                	</xsl:otherwise>
                        	</xsl:choose>
                    	</td>
                    	<td>&nbsp;</td>
            	  </tr>
            	  </xsl:when>
            	  <xsl:when test="/Mantenimiento/form/CENTRO/ROL='VENDEDOR'">
                	  <input type="text" class="campopesquisa" name="CEN_IDUSUARIOLICITACIONESAUT" id="CEN_IDUSUARIOLICITACIONESAUT" value="" />
            	  </xsl:when>
            	  </xsl:choose>
            	  <tr class="sinLinea">
                	<td>&nbsp;</td>
                	<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>:</td>
                	<td class="datosLeft"><input type="text" class="campopesquisa" name="CEN_LIC_TITULO" value="{CEN_LIC_TITULO}" size="63"/></td>
                	<td>&nbsp;</td>
            	  </tr>
            	   <tr class="sinLinea">
                	<td>&nbsp;</td>
                	<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</td>
                	<td class="datosLeft"><textarea name="CEN_LIC_DESCRIPCION" rows="3" cols="60"><xsl:value-of select="CEN_LIC_DESCRIPCION"/></textarea></td>
                	<td>&nbsp;</td>
            	  </tr>
            	  <tr class="sinLinea">
                	<td>&nbsp;</td>
                	<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_entrega']/node()"/>:</td>
                	<td class="datosLeft"><textarea name="CEN_LIC_COND_ENTREGA" rows="3" cols="60"><xsl:value-of select="CEN_LIC_CONDICIONESENTREGA"/></textarea></td>
                	<td>&nbsp;</td>
            	  </tr>
            	  <tr class="sinLinea">
                	<td>&nbsp;</td>
                	<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_pago']/node()"/>:</td>
                	<td class="datosLeft"><textarea name="CEN_LIC_COND_PAGO" rows="3" cols="60"><xsl:value-of select="CEN_LIC_CONDICIONESPAGO"/></textarea></td>
                	<td>&nbsp;</td>
            	  </tr>
            	  <tr class="sinLinea">
                	<td>&nbsp;</td>
                	<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_otras']/node()"/>:</td>
                	<td class="datosLeft"><textarea name="CEN_LIC_OTRAS_COND" rows="3" cols="60"><xsl:value-of select="CEN_LIC_OTRASCONDICIONES"/></textarea></td>
                	<td>&nbsp;</td>
            	  </tr>
            	  <tr class="sinLinea">
                	<td>&nbsp;</td>
                	<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones_pedido']/node()"/>:</td>
                	<td class="datosLeft"><textarea name="CEN_LIC_COMEN_PEDIDOS" rows="3" cols="60"><xsl:value-of select="CEN_LIC_COMENTARIOSPEDIDO"/></textarea></td>
                	<td>&nbsp;</td>
            	  </tr>
            	  <tr class="sinLinea">
                	<td>&nbsp;</td>
                	<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='meses_duracion']/node()"/>:</td>
                	<td class="datosLeft">
                            <xsl:call-template name="desplegable">
                            <xsl:with-param name="path" select="CEN_LIC_PLAZO_NEG/field"/>
                            <xsl:with-param name="claSel">w200px</xsl:with-param>
                            </xsl:call-template>

					<!--
					<select name="CEN_LIC_PLAZO_NEG" id="CEN_LIC_PLAZO_NEG">
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
        	  <tr class="sinLinea"><td colspan="4">&nbsp;</td></tr>
    	   </table>


		<!--lugares de entrega-->
		<xsl:if test="/Mantenimiento/form/CENTRO/CEN_ID>0"><!-- Solo si el centro ya existia -->
			<xsl:call-template name="LUGARENTREGA"/>
		</xsl:if><!-- Solo si el centro ya existia -->

		<!--centro de consumo-->
		<xsl:if test="/Mantenimiento/form/CENTRO/CEN_ID>0"><!-- Solo si el centro ya existia -->
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

			<table class="w90 tableCenter" cellspacing="6px" cellpadding="6px">
				<tr class="subTituloTabla">
					<td colspan="4"><xsl:value-of select="document($doc)/translation/texts/item[@name='opciones_especificas_proveedores']/node()"/></td>
				</tr>

				<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_distribuidor']/node()"/>:<span class="camposObligatorios">*</span></td>
					<td colspan="3" class="datosLeft">
						<xsl:apply-templates select="CEN_DISTRIBUIDOR"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='opcion_distribuidor']/node()"/>
					</td>
				</tr>

			<xsl:if test="./MVM"><!-- Estado: solo para MVM -->
				<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>:<span class="camposObligatorios">*</span></td>
					<td colspan="3" class="datosLeft">
						<xsl:apply-templates select="ESTADO"/>
					</td>
				</tr>
			</xsl:if><!-- Estado: solo para MVM -->
			</table>
		</div><!--fin de parte proveedor-->
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	</div>
</xsl:template>
<!--
<xsl:template match="ExtraButtons_nuevo">
<!- - Cada button corresponde a un form con campos ocultos /field y un submit /button - ->
<xsl:for-each select="formu">
	<xsl:choose>
	<xsl:when test="@name='dummy'">
		<!- - Colocamos form chorra porque el javascript tiene problemas con el primer formulario anidado - ->
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

				<!- - Ponemos los campos input ocultos - ->
				<xsl:for-each select="field">
					<input>
						<!- - Anyade las opciones comunes al campo input - ->
						<xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
						<xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
						<!- - Anyadimos los valores, que son diferentes para cada field - ->
						<xsl:choose>
						<!- - Campo CEN_ID - ->
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
-->

<xsl:template match="Sorry">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="sendRequest">
	<input type="submit">
		<xsl:attribute name="value"><xsl:value-of select="@label"/></xsl:attribute>
	</input>
</xsl:template>
<!--
<xsl:template match="CEN_ID">
	<input type="hidden" name="CEN_ID" size="59" maxlength="70">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>
-->
<xsl:template match="ESTADO">
	<xsl:call-template name="desplegable"><xsl:with-param name="path" select="./field"/></xsl:call-template>
</xsl:template>

<!--
<xsl:template match="EMP_ID">
	<input type="hidden" name="EMP_ID">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>
-->
<xsl:template match="CEN_NOMBRE">
	<input type="hidden" name="CEN_NOMBRE_OLD" value="{.}"/>
	<input type="text" class="campopesquisa w300px" name="CEN_NOMBRE" maxlength="100">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="CEN_NOMBRECORTO">
	<input type="hidden" name="CEN_NOMBRECORTO_OLD" value="{.}"/>
	<input type="text" class="campopesquisa w300px" name="CEN_NOMBRECORTO" maxlength="50">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="CEN_DIRECCION">
	<input type="text" class="campopesquisa w300px" name="CEN_DIRECCION"  maxlength="300">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="CEN_CPOSTAL">
	<input type="text" class="campopesquisa w150px" name="CEN_CPOSTAL" maxlength="15">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="CEN_NIF">
	<!--idioma-->
	<xsl:variable name="lang"><xsl:value-of select="/Mantenimiento/LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<input type="text" class="campopesquisa w200px" name="CEN_NIF" maxlength="20" value="{.}"/>
	&nbsp;<span class="textoComentario"><xsl:value-of select="document($doc)/translation/texts/item[@name='formato_recomendado']/node()"/></span>
</xsl:template>

<xsl:template match="CEN_POBLACION">
	<input type="text" class="campopesquisa w200px" name="CEN_POBLACION" maxlength="200">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>
<!--
<xsl:template match="CEN_PROVINCIA">
	<input type="text" class="campopesquisa" name="CEN_PROVINCIA" maxlength="100">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>
-->
<xsl:template match="CEN_TELEFONO">
	<input type="text" class="campopesquisa w150px" name="CEN_TELEFONO" maxlength="50">
		<xsl:attribute name="value">
			<xsl:choose>
			<xsl:when test=".!=''"><xsl:value-of select="."/></xsl:when>
			<xsl:otherwise><xsl:value-of select="../EMP_TELEFONO"/></xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="CEN_FAX">
	<input type="text" class="campopesquisa w150px" name="CEN_FAX" maxlength="50">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template name="FORMASPAGO">
	<xsl:call-template name="desplegable">
            <xsl:with-param name="path" select="/Mantenimiento/form/CENTRO/FORMASPAGO/field"/>
            <xsl:with-param name="claSel">w200px</xsl:with-param>
        </xsl:call-template>
</xsl:template>

<xsl:template name="PLAZOSPAGO">
	<xsl:call-template name="desplegable">
            <xsl:with-param name="path" select="/Mantenimiento/form/CENTRO/PLAZOSPAGO/field"/>
            <xsl:with-param name="claSel">w200px</xsl:with-param>
        </xsl:call-template>
</xsl:template>

<xsl:template name="PLAZOSENTREGA">
	<xsl:call-template name="desplegable">
            <xsl:with-param name="path" select="/Mantenimiento/form/CENTRO/PLAZOSENTREGA/field"/>
            <xsl:with-param name="claSel">w200px</xsl:with-param>
        </xsl:call-template>
</xsl:template>

<xsl:template match="CEN_CAMAS">
	<input type="text" class="campopesquisa w100px" name="CEN_CAMAS" maxlength="10">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="CEN_QUIROFANOS">
	<input type="text" class="campopesquisa w100px" name="CEN_QUIROFANOS" maxlength="10">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="CEN_PEDIDOSPREVISTOSMES">
	<input type="text" class="campopesquisa w100px" name="CEN_PEDIDOSPREVISTOSMES" maxlength="10">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="CEN_CDC">
	<input type="checkbox" class="muypeq" name="CEN_CDC">
		<xsl:choose>
		<xsl:when test=".='S'"><xsl:attribute name="checked">S</xsl:attribute></xsl:when>
		<xsl:otherwise><xsl:attribute name="unchecked">N</xsl:attribute></xsl:otherwise>
		</xsl:choose>
	</input>
</xsl:template>

<xsl:template match="CEN_COMPROMISO">
	<input type="checkbox" class="muypeq" name="CEN_COMPROMISO">
		<xsl:choose>
		<xsl:when test=".='S'"><xsl:attribute name="checked">S</xsl:attribute></xsl:when>
		<xsl:otherwise><xsl:attribute name="unchecked">N</xsl:attribute></xsl:otherwise>
		</xsl:choose>
	</input>
</xsl:template>

<xsl:template match="CEN_SINCOMISIONES">
	<input type="checkbox" class="muypeq" name="CEN_SINCOMISIONES">
		<xsl:choose>
		<xsl:when test=".='S'"><xsl:attribute name="checked">S</xsl:attribute></xsl:when>
		<xsl:otherwise><xsl:attribute name="unchecked">N</xsl:attribute></xsl:otherwise>
		</xsl:choose>
	</input>
</xsl:template>

<xsl:template match="CEN_MOSTRARCENTROSCONSUMO">
	<input type="checkbox" class="muypeq" name="CEN_MOSTRARCENTROSCONSUMO">
		<xsl:choose>
		<xsl:when test=".='S'"><xsl:attribute name="checked">S</xsl:attribute></xsl:when>
		<xsl:otherwise><xsl:attribute name="unchecked">N</xsl:attribute></xsl:otherwise>
		</xsl:choose>
	</input>
</xsl:template>

<xsl:template match="CEN_INT_RETENERDESCARGAOC">
	<input type="checkbox" class="muypeq" name="CEN_INT_RETENERDESCARGAOC">
		<xsl:choose>
		<xsl:when test=".='S'"><xsl:attribute name="checked">S</xsl:attribute></xsl:when>
		<xsl:otherwise><xsl:attribute name="unchecked">N</xsl:attribute></xsl:otherwise>
		</xsl:choose>
	</input>
</xsl:template>

<xsl:template match="CEN_INT_SOAP_PREXML">
	<input type="text" class="campopesquisa w400px" name="CEN_INT_SOAP_PREXML" maxlength="3000">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="CEN_INT_SOAP_POSTXML">
	<input type="text" class="campopesquisa w400px" name="CEN_INT_SOAP_POSTXML" maxlength="3000">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="CEN_INT_SOAP_HEADER">
	<input type="text" class="campopesquisa w400px" name="CEN_INT_SOAP_HEADER" maxlength="3000">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="CEN_INT_SOAP_ACTION">
	<input type="text" class="campopesquisa w400px" name="CEN_INT_SOAP_ACTION" maxlength="3000">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="CEN_INT_SOAP_XMLNS">
	<input type="text" class="campopesquisa w400px" name="CEN_INT_SOAP_XMLNS" maxlength="3000">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="CEN_DISTRIBUIDOR">
	<input type="checkbox" class="muypeq" name="CEN_DISTRIBUIDOR">
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

	<div class="divLeft marginTop50 textCenter">
		<span class="w90 inline fondoGris textLeft pad10px">
				&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='lugares_de_entrega']/node()"/></strong>
				<span class="camposObligatorios">*</span>&nbsp;&nbsp;&nbsp;[&nbsp;
				<a href="javascript:NuevoLugarEntrega();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir_lugar']/node()"/>
				</a>&nbsp;]
		</span>
		<div class="tabela tabela_redonda marginTop30">
		<table class="w1000px tableCenter" cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
			<tr>
				<th class="w1px">&nbsp;</th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='lugar_de_entrega']/node()"/></th>
				<th class="w150px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='por_defecto_materialsanitario']/node()"/></th>
				<th class="w150px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='por_defecto_farmacia']/node()"/></th>
			</tr>
			</thead>
			<!--	Cuerpo de la tabla	-->
			<tbody class="corpo_tabela">
			<xsl:for-each select="/Mantenimiento/form/CENTRO/LUGARESENTREGA/LUGARENTREGA">
				<tr class="conhover">
					<td class="color_status">&nbsp;</td>
					<td class="textLeft">
						<a>
							<xsl:attribute name="href">javascript:EditarLugarEntrega('<xsl:value-of select="IDCENTRO"/>','<xsl:value-of select="ID"/>');</xsl:attribute>
							<xsl:value-of select="REFERENCIA"/>
						</a>
					</td>
					<td class="textLeft">
						<a>
							<xsl:attribute name="href">javascript:EditarLugarEntrega('<xsl:value-of select="IDCENTRO"/>','<xsl:value-of select="ID"/>');</xsl:attribute>
							<xsl:value-of select="NOMBRE"/>
						</a>
					</td>
					<td class="textLeft"><xsl:value-of select="DIRECCION"/></td>
					<td>
						<xsl:choose>
						<xsl:when test="PORDEFECTO='S'">X</xsl:when>
						<xsl:otherwise>&nbsp;</xsl:otherwise>
						</xsl:choose>
					</td>
					<td>
						<xsl:choose>
						<xsl:when test="PORDEFECTO_FARMACIA='S'">X</xsl:when>
						<xsl:otherwise>&nbsp;</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
			</xsl:for-each>
			</tbody>
			<tfoot class="rodape_tabela">
				<tr><td colspan="12">&nbsp;</td></tr>
			</tfoot>
		</table>
		</div>
 	</div>
</xsl:template>

<xsl:template name="CENTROCONSUMO">
	<!--idioma-->
	<xsl:variable name="lang"><xsl:value-of select="../../LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="divLeft marginTop50 textCenter">
		<span class="w90 inline fondoGris pad10px textLeft">
				&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='centros_de_consumo']/node()"/></strong>
				<span class="camposObligatorios">*</span>&nbsp;&nbsp;&nbsp;[&nbsp;
				<a href="javascript:NuevoCentroConsumo();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir_centro']/node()"/>
				</a>&nbsp;]
		</span>
		<div class="tabela tabela_redonda marginTop30">
		<table class="w1000px tableCenter" cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
			<tr>
				<th class="w1px">&nbsp;</th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_consumo']/node()"/></th>
				<th class="150px"><xsl:value-of select="document($doc)/translation/texts/item[@name='por_defecto']/node()"/></th>
			</tr>
			</thead>
			<!--	Cuerpo de la tabla	-->
			<tbody class="corpo_tabela">
			<xsl:for-each select="/Mantenimiento/form/CENTRO/CENTROSCONSUMO/CENTROCONSUMO">
				<tr class="conhover">
					<td class="color_status">&nbsp;</td>
					<td class="textLeft">
						<a>
							<xsl:attribute name="href">javascript:EditarCentroConsumo('<xsl:value-of select="IDCENTRO"/>','<xsl:value-of select="ID"/>');</xsl:attribute>
							<xsl:value-of select="REFERENCIA"/>
						</a>
					</td>
					<td class="textLeft">
						<a>
							<xsl:attribute name="href">javascript:EditarCentroConsumo('<xsl:value-of select="IDCENTRO"/>','<xsl:value-of select="ID"/>');</xsl:attribute>
							<xsl:value-of select="NOMBRE"/>
						</a>
					</td>
					<td>
						<xsl:choose>
						<xsl:when test="PORDEFECTO='S'">X</xsl:when>
						<xsl:otherwise>&nbsp;</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
			</xsl:for-each>
			</tbody>
			<tfoot class="rodape_tabela">
				<tr><td colspan="12">&nbsp;</td></tr>
			</tfoot>
		</table>
 		</div>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
	</div>
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
				<div class="docLongEspec" id="docLongEspec_{$type}">
					<!--27feb23	<input id="inputFileDoc_{$type}" name="inputFileDoc" type="file" onChange="addDocFile('{$type}','frmManten');" />	-->
					<input id="inputFileDoc_{$type}" name="inputFileDoc" type="file" onChange="addDocFile('{$type}','frmManten');cargaDoc(document.forms['frmManten'],'{$type}');" />
				</div>
                <div id="waitBoxDocLOGO" style="display:none;">&nbsp;</div>
                <div id="confirmBoxLOGO" style="display:none;">&nbsp;</div>
                 <!--27feb23 boton input carga logo, lanmzamos la carga automaticamente
				 <div class="boton" style="clear:both;">
                    <a href="javascript:cargaDoc(document.forms['frmManten'],'{$type}');">
                      <xsl:value-of select="document($doc)/translation/texts/item[@name='subir_logo']/node()"/>
                    </a>
                </div>-->
			</div>
		</xsl:when>

	</xsl:choose>
    </xsl:template>
	
<!--fin de documentos-->

</xsl:stylesheet>
