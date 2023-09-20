<?xml version="1.0" encoding="iso-8859-1"?>
<!-- nueva demanda control precios -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/StockDemanda">
<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_demanda_stock']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<link rel="stylesheet" href="http://www.newco.dev.br/General/calendario/spiffyCal_v2_1.css" type="text/css"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/calendario/spiffyCal_v2_1.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/StockDemanda.js"></script>

	<script type="text/javascript">
		var titulo_obligatorio			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_titulo_stck_dem']/node()"/>';
		var refcliente_obligatorio	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_ref_cliente_stck_dem']/node()"/>';
		var producto_obligatorio		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_descr_producto_stck_dem']/node()"/>';
		var precio_obligatorio			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_precio_stck_dem']/node()"/>';
		var precio_error						= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_precio_stck_dem']/node()"/>';
		var cantidad_obligatorio		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_cantidad_stck_dem']/node()"/>';
		var cantidad_error					= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_cantidad_stck_dem']/node()"/>';
		var fecha_obligatorio				= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_fecha_stck_dem']/node()"/>';
		var fecha_error							= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_fecha_stck_dem']/node()"/>';
<!--		var descripcion_obligatoria	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_desc_stock_demanda']/node()"/>';
		var infoprecio_obligatoria	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_infoprecio_stock_demanda']/node()"/>';
-->
	</script>
</head>

<body>
<xsl:choose>
<xsl:when test="SESION_CADUCADA">
	<xsl:for-each select="SESION_CADUCADA">
		<xsl:if test="position()=last()">
			<xsl:apply-templates select="."/>
		</xsl:if>
	</xsl:for-each>
</xsl:when>
<xsl:when test="//xsql-error">
	<xsl:apply-templates select="//xsql-error"/>
</xsl:when>

<xsl:otherwise>
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div id="spiffycalendar" class="text"></div>
	<script type="text/javascript">
		var calFechaCaducidad	= new ctlSpiffyCalendarBox("calFechaCaducidad", "frmStockDemanda", "SD_FECHACADUCIDAD","btnDateFechaCaducidad",'<xsl:value-of select="SD_FECHACADUCIDAD"/>',scBTNMODE_CLASSIC,'');
	</script>

	<div class="divLeft">
	<xsl:choose>
  <xsl:when test="ENTRADA_CONTROL/CT_DEM_ID != ''">

    <div class="divLeft20">&nbsp;</div>
    <div class="divLeft60nopa">

      <table class="infoTable incidencias" cellspacing="5" cellpadding="5" style="border-bottom:2px solid #D7D8D7;">
        <tr>
          <td colspan="2" style="text-transform:uppercase;text-align:center;background-color:#D3D3D3;">
						<strong>
						<xsl:choose>
						<xsl:when test="GUARDAR = 'S'">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='demanda_stock_guardada_exito']/node()"/>:
						</xsl:when>
						<xsl:otherwise>
						  <xsl:value-of select="document($doc)/translation/texts/item[@name='demanda_stock']/node()"/>:
						</xsl:otherwise>
						</xsl:choose>

            	(<xsl:value-of select="ENTRADA_CONTROL/CT_DEM_CODIGO"/>)&nbsp;<xsl:value-of select="ENTRADA_CONTROL/CT_DEM_TITULO"/>
						</strong>
          </td>
        </tr>

				<tr><td colspan="2">&nbsp;</td></tr>
				<!-- Solictud Catalogacion -->

				<tr>
					<td>&nbsp;</td>
					<td style="text-transform:uppercase;text-align:left;background-color:#D3D3D3;padding-left:10px;">
						<strong>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='demanda_stock']/node()"/>
							<span style="float:right;padding-right:30px;">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;<xsl:value-of select="ENTRADA_CONTROL/CT_DEM_FECHA"/>
							</span>
						</strong>
          </td>
				</tr>

				<tr>
					<td class="trenta labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:</td>
					<td class="datosLeft"><xsl:value-of select="ENTRADA_CONTROL/USUARIO"/></td>
				</tr>
<!--
				<tr>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</td>
					<td class="datosLeft">
						<xsl:value-of select="ENTRADA_CONTROL/CT_DEM_DESCRIPCION" disable-output-escaping="yes"/>
					</td>
				</tr>

				<tr>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='infoprecio']/node()"/>:</td>
					<td class="datosLeft"><xsl:value-of select="ENTRADA_CONTROL/CT_DEM_INFOPRECIO" disable-output-escaping="yes"/></td>
				</tr>
-->
				<tr>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:</td>
					<td class="datosLeft"><xsl:value-of select="ENTRADA_CONTROL/CT_DEM_REFCLIENTE" disable-output-escaping="yes"/></td>
				</tr>

				<tr>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:</td>
					<td class="datosLeft"><xsl:value-of select="ENTRADA_CONTROL/CT_DEM_PRODUCTO" disable-output-escaping="yes"/></td>
				</tr>

				<tr>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_unitario']/node()"/>:</td>
					<td class="datosLeft"><xsl:value-of select="ENTRADA_CONTROL/CT_DEM_PRECIO" disable-output-escaping="yes"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='euro']/node()"/></td>
				</tr>

				<tr>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/>:</td>
					<td class="datosLeft"><xsl:value-of select="ENTRADA_CONTROL/CT_DEM_CANTIDAD" disable-output-escaping="yes"/></td>
				</tr>

				<tr>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_caducidad']/node()"/>:</td>
					<td class="datosLeft"><xsl:value-of select="ENTRADA_CONTROL/CT_DEM_FECHACADUCIDAD" disable-output-escaping="yes"/></td>
				</tr>
<!--
			<xsl:if test="SOLICITUD/DOCUMENTO_Solicitud/ID">
				<tr>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_solicitud']/node()"/>:</td>
					<td class="datosLeft" colspan="2">
						<a href="http://www.newco.dev.br/Documentos/{SOLICITUD/DOCUMENTO_Solicitud/URL}" target="_blank">
							<xsl:value-of select="SOLICITUD/DOCUMENTO_Solicitud/NOMBRE"/>
						</a>
					</td>
				</tr>
			</xsl:if>
-->
				<tr>
					<td colspan="2">&nbsp;</td>
				</tr>
			</table>
    </div>
<!--
    <div class="divLeft">
      <div class="divLeft40">&nbsp;</div>
      <div class="boton" style="width:240px;margin-top:15px;">
        <a href="http://www.newco.dev.br/Gestion/Comercial/SolicitudCatalogacion.xsql?SC_ID={OK}">
          <xsl:value-of select="document($doc)/translation/texts/item[@name='ver_solicitud_catalogacion']/node()"/>
        </a>
      </div>
    </div>
-->
  </xsl:when>

	<xsl:when test="ERROR">
		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='error_demanda_stock']/node()"/></h1>
	</xsl:when>
	<xsl:otherwise>
<!--		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_solicitud_catalogacion']/node()"/></h1>-->

		<form name="frmStockDemanda" id="frmStockDemanda" method="post">
			<input type="hidden" name="GUARDAR" value="S"/>
<!--
			<input type="hidden" name="TIPO_DOC_DB" id="TIPO_DOC_DB"/>
			<input type="hidden" name="TIPO_DOC_HTML" id="TIPO_DOC_HTML"/>
			<input type="hidden" name="CADENA_DOCUMENTOS"/>
			<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
			<input type="hidden" name="BORRAR_ANTERIORES"/>
			<input type="hidden" name="SC_IDDOCSOLICITUD" id="DOC_SOLCAT"/>
			<input type="hidden" name="ID_USUARIO" value="{DATOS_USUARIO/IDUSUARIO}"/>
			<input type="hidden" name="IDEMPRESA" value="{DATOS_USUARIO/IDEMPRESA}"/>
-->
			<div class="divLeft10">&nbsp;</div>
      <div class="divLeft80">

        <table class="infoTable incidencias" cellspacing="5" style="border-bottom:2px solid #D7D8D7;border-top:2px solid #D7D8D7;">
					<!--<tr><td colspan="3">&nbsp;</td></tr>-->
					<tr>
						<td style="text-transform:uppercase;text-align:center;background-color:#D3D3D3;padding-left:10px;" colspan="3">
							<strong><xsl:copy-of select="document($doc)/translation/texts/item[@name='nueva_demanda_stock']/node()"/></strong>
						</td>
					</tr>
          <tr><td colspan="3">&nbsp;</td></tr>
					<!--Solictud Catalogacion -->
					<tr>
						<td class="diecisiete labelRight grisMed">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>:&nbsp;
							<span class="camposObligatorios">*</span>
						</td>
						<td class="cinquenta datosLeft"><input type="text" name="SD_TITULO" id="SD_TITULO" maxlength="200" size="62"/></td>
						<td class="datosLeft" style="padding-left:5px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='titulo_explicacion_stck_dem']/node()"/></td>
					</tr>
					<tr>
						<td class="labelRight grisMed">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:&nbsp;
							<span class="camposObligatorios">*</span>
						</td>
						<td class="datosLeft" colspan="2"><input type="text" name="SD_REFCLIENTE" id="SD_REFCLIENTE" maxlength="100"/></td>
					</tr>
					<tr>
						<td class="labelRight grisMed">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:&nbsp;
							<span class="camposObligatorios">*</span>
						</td>
						<td class="datosLeft"><input type="text" name="SD_PRODUCTO" id="SD_PRODUCTO" maxlength="300" size="62"/></td>
						<td class="datosLeft" style="padding-left:5px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto_explicacion_stck_dem']/node()"/></td>
					</tr>
					<tr>
						<td class="labelRight grisMed">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_unitario']/node()"/>:&nbsp;
							<span class="camposObligatorios">*</span>
						</td>
						<td class="datosLeft" colspan="2"><input type="text" name="SD_PRECIOUNITARIO" id="SD_PRECIOUNITARIO" maxlength="10"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='euro']/node()"/></td>
					</tr>
					<tr>
						<td class="labelRight grisMed">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/>:
							<span class="camposObligatorios">*</span>
						</td>
						<td class="datosLeft" colspan="2"><input type="text" name="SD_CANTIDAD" id="SD_CANTIDAD" maxlength="10"/>&nbsp;
							<xsl:value-of select="document($doc)/translation/texts/item[@name='']/node()"/>
						</td>
					</tr>
					<tr>
						<td class="labelRight grisMed">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_caducidad']/node()"/>:&nbsp;
							<span class="camposObligatorios">*</span>
						</td>
						<td class="datosLeft" colspan="2">
							<span style="float:left;">
								<script type="text/javascript">
									calFechaCaducidad.dateFormat="dd/MM/yyyy";
									calFechaCaducidad.labelCalendario='<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_caducidad']/node()"/>';
									calFechaCaducidad.minDate=new Date(new Date().setDate(new Date().getDate()+1));
									calFechaCaducidad.writeControl();
								</script>
							</span>
							<span style="float:left;margin-top:8px;">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='formato_fecha2']/node()"/></span>
<!--<input type="text" name="SD_FECHACADUCIDAD" id="SD_FECHACADUCIDAD" maxlength="100"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='formato_fecha']/node()"/>-->
						</td>
					</tr>
<!--
					<tr>
						<td class="labelRight grisMed">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:&nbsp;
							<span class="camposObligatorios">*</span>
						</td>
						<td class="datosLeft"><textarea name="SD_DESCRIPCION" id="SD_DESCRIPCION" rows="4" cols="60" maxlength="3000"></textarea></td>
						<td class="datosLeft" style="padding-left:5px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_explicacion_sol_cat']/node()"/></td>
					</tr>
					<tr>
						<td class="labelRight grisMed">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='infoprecio']/node()"/>:&nbsp;
							<span class="camposObligatorios">*</span>
						</td>
						<td class="datosLeft"><textarea name="SC_INFOPRECIO" id="SC_INFOPRECIO" rows="4" cols="60" maxlength="1000"></textarea></td>
						<td class="datosLeft" style="padding-left:5px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='infoprecio_explicacion_sol_cat']/node()"/></td>
					</tr>
-->

<!--
					<tr>
						<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_solicitud_catalogacion']/node()"/>:</td>
						<td class="datosLeft" colspan="2">
							<span id="newDocSOLCAT" align="center">
								<a href="javascript:verCargaDoc('SOLCAT');" title="Subir documento" style="text-decoration:none;">
									<img src="http://www.newco.dev.br/images/subirDocumento.gif" alt="Subir Documento" title="Subir Documento"/>
								</a>
							</span>&nbsp;
							<span id="docBoxSOLCAT" style="display:none;" align="center"></span>&nbsp;
							<span id="borraDocSOLCAT" style="display:none;" align="center"></span>
						</td>
					</tr>
					<tr id="cargaSOLCAT" class="cargas" style="display:none;">
						<td colspan="3"><xsl:call-template name="CargaDocumentos"><xsl:with-param name="tipo">SOLCAT</xsl:with-param></xsl:call-template></td>
					</tr>
-->
          <tr><td colspan="3">&nbsp;</td></tr>
					<tr>
						<td class="labelRight"></td>
						<td class="datosLeft">
							<div class="boton" id="BotonSubmit">
								<a href="javascript:ValidarFormulario(document.forms['frmStockDemanda'],'NUEVA');">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/>
								</a>
							</div>
						</td>
            <td class="datosLeft">
<!--
							<div class="boton">
								<a href="http://www.newco.dev.br/Personal/BandejaTrabajo/WFStatus.xsql" target="_self">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
								</a>
							</div>
-->
						</td>
					</tr>
				</table>
      </div><!--fin de divLeft60nopa-->
		</form>

		<!--frame para las imagenes-->
<!--
		<div id="uploadFrameBox" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>
		<div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>
-->
		<!--form de mensaje de error de js-->
		<form name="mensajeJS">
			<!--carga documentos-->
<!--
			<input type="hidden" name="ERROR_SIN_DEFINIR" value="{document($doc)/translation/texts/item[@name='error_sin_definir']/node()}"/>
			<input type="hidden" name="HEMOS_ESPERADO" value="{document($doc)/translation/texts/item[@name='hemos_esperado']/node()}"/>
			<input type="hidden" name="LA_CARGA_NO_TERMINO" value="{document($doc)/translation/texts/item[@name='la_carga_no_termino']/node()}"/>
-->
		</form>
	</xsl:otherwise>
	</xsl:choose><!--fin choose si incidencia guardada con exito-->
	</div><!--fin de divLeft-->
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>

<!--template carga documentos-->
<xsl:template name="CargaDocumentos">
	<xsl:param name="tipo" />

	<!--idioma-->
	<xsl:variable name="lang"><xsl:value-of select="LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="divLeft" id="cargaDoc{$tipo}">
		<!--tabla imagenes y documentos-->
		<table class="infoTable" border="0">
			<tr>
				<!--documentos-->
				<td class="labelRight trenta grisMed">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='elige_documento']/node()"/>
				</td>
				<td class="datosLeft">
					<div class="altaDocumento">
						<span class="anadirDoc">
							<xsl:call-template name="documentos">
								<xsl:with-param name="num" select="number(1)"/>
								<xsl:with-param name="type" select="$tipo"/>
							</xsl:call-template>
						</span>
					</div>
				</td>
				<td>&nbsp;</td>
			</tr>
		</table><!--fin de tabla imagenes doc-->

		<div id="waitBoxDoc{$tipo}" align="center">&nbsp;</div>
	</div><!--fin de divleft-->
</xsl:template><!--fin de template carga documentos-->

<!--documentos-->
<xsl:template name="documentos">
	<xsl:param name="num"/>
	<xsl:param name="type"/>

	<xsl:choose>
	<xsl:when test="$num &lt; number(5)">
		<div class="docLine" id="docLine_{$type}">
			<div class="docLongEspec" id="docLongEspec_{$type}">
				<input id="inputFileDoc_{$type}" name="inputFileDoc" type="file" onChange="cargaDoc(document.forms['SolicitudCatalogacion'],'{$type}');"/>
			</div>
		</div>
	</xsl:when>
	</xsl:choose>
</xsl:template><!--fin de documentos-->
</xsl:stylesheet>
