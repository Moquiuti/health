<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	agosto 2011, nueva versi?n simplificada
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<!-- template principal -->
<xsl:template match="/HistoricosCentros">

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

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_historico_por_centro']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='medicalVM']/node()"/>&nbsp;-&nbsp;<xsl:value-of select="PRODUCTOESTANDAR/CP_PRO_NOMBRE"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<link href="http://www.newco.dev.br/General/Tabla-popup.150715.css" rel="stylesheet" type="text/css"/>

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/HistoricosCentros.150316.js"></script>
	<!--codigo etiquetas-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/Tabla-popup.150715.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/etiquetas.js"></script>

	<script type="text/javascript">
		var val_faltaCentro	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_centro']/node()"/>';
		var val_faltaNombre	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_nombre']/node()"/>';
		var val_faltaUdBasica	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_udbasica']/node()"/>';
		var val_faltaPrecio	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_precio2']/node()"/>';
		var val_malPrecio	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_precio2']/node()"/>';
		var val_faltaCantAnual	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_cantidad_anual']/node()"/>';
		var val_malCantAnual	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_cantidad_anual']/node()"/>';
		var val_faltaUdsLote	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_uds_lote']/node()"/>';
		var val_malUdsLote	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_uds_lote']/node()"/>';

		var str_guardarDatosOK		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='datos_info_historico_guardado']/node()"/>';
		var str_guardarDatosKO		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='datos_info_historico_error']/node()"/>';

		var val_faltaPrecioMVM		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_precioMVM']/node()"/>';
		var val_malPrecioMVM		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_precioMVM']/node()"/>';

		<!-- Variables y Strings JS para las etiquetas -->
		var IDRegistro = '<xsl:value-of select="PRODUCTOESTANDAR/CP_PRO_ID"/>';
		var IDTipo = 'PROD_HC';
		var str_NuevaEtiquetaGuardada = '<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta_guardada']/node()"/>';
		var str_NuevaEtiquetaError    = '<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta_error']/node()"/>';
		var str_autor    = '<xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/>';
		var str_fecha    = '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>';
		var str_etiqueta = '<xsl:value-of select="document($doc)/translation/texts/item[@name='etiqueta']/node()"/>';
		var str_borrar   = '<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>';
		<!-- FIN Variables y Strings JS para las etiquetas -->
	</script>
</head>

<!--  cuerpo -->
<body>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!-- gestion de errores -->
<xsl:choose>
<xsl:when test="ERROR">
	<xsl:apply-templates match="ERROR"/>
</xsl:when>
<xsl:otherwise>

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>
		&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo_privado']/node()"/>
		&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ficha_de_producto']/node()"/></span></p>
		<p class="TituloPagina">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='ref_estandar']/node()"/>:&nbsp;
            <xsl:value-of select="PRODUCTOESTANDAR/CP_PRO_REFERENCIA"/>&nbsp;-&nbsp;
            <span id="NOMBRE_BASE"><xsl:value-of select="PRODUCTOESTANDAR/CP_PRO_NOMBRE"/></span>
			<span class="CompletarTitulo">
            	<a class="btnNormal" href="http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/HistoricosCentros.xsql?ID_EMP={/HistoricosCentros/PRODUCTOESTANDAR/IDEMPRESA}&amp;ID_PROD_ESTANDAR={/HistoricosCentros/PRODUCTOESTANDAR/CP_PRO_ID_ANTERIOR}" title="Anterior producto" target="_self" style="text-decoration:none;">
                	<xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/>
            	</a>
				&nbsp;
				<xsl:if test="PRODUCTOESTANDAR/ADMIN">
					<a class="btnDestacado" id="GuardarDatosBasicos"  href="javascript:guardarDatosBasicos();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
					</a>&nbsp;
				</xsl:if>
            	<a class="btnNormal" href="http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/HistoricosCentros.xsql?ID_EMP={/HistoricosCentros/PRODUCTOESTANDAR/IDEMPRESA}&amp;ID_PROD_ESTANDAR={/HistoricosCentros/PRODUCTOESTANDAR/CP_PRO_ID_SIGUIENTE}" title="Siguiente producto" target="_self" style="text-decoration:none;">
                	<xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/>
            	</a>
				&nbsp;
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>
	<br/>
	<!--
        <h1 class="titlePage" style="width:10%;float:left;text-align:left;">
            &nbsp;
            <a href="http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/HistoricosCentros.xsql?ID_EMP={/HistoricosCentros/PRODUCTOESTANDAR/IDEMPRESA}&amp;ID_PROD_ESTANDAR={/HistoricosCentros/PRODUCTOESTANDAR/CP_PRO_ID_ANTERIOR}" title="Anterior producto" target="_self" style="text-decoration:none;">
                <img src="http://www.newco.dev.br/images/anterior.gif" alt="Producto anterior" />
            </a>
            <a href="http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/HistoricosCentros.xsql?ID_EMP={/HistoricosCentros/PRODUCTOESTANDAR/IDEMPRESA}&amp;ID_PROD_ESTANDAR={/HistoricosCentros/PRODUCTOESTANDAR/CP_PRO_ID_ANTERIOR}" title="Anterior producto" target="_self" style="text-decoration:none;">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/>
             </a>
        </h1>
        <h1 class="titlePage" style="width:80%; float:left;">

					<a id="conEtiquetas" href="javascript:abrirEtiqueta(true);" style="text-decoration:none;display:none;">
						<img src="http://www.newco.dev.br/images/tagsAma.png" width="20px">
							<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_mas_nueva_etiqueta']/node()"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_mas_nueva_etiqueta']/node()"/></xsl:attribute>
						</img>
					</a>&nbsp;

					<a id="sinEtiquetas" href="javascript:abrirEtiqueta(false);" style="text-decoration:none;display:none;">
						<img src="http://www.newco.dev.br/images/tags.png" width="20px">
							<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta']/node()"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta']/node()"/></xsl:attribute>
						</img>
					</a>&nbsp;

            <xsl:value-of select="document($doc)/translation/texts/item[@name='ref_estandar']/node()"/>:&nbsp;
            <xsl:value-of select="PRODUCTOESTANDAR/CP_PRO_REFERENCIA"/>&nbsp;-&nbsp;
            <span id="NOMBRE_BASE"><xsl:value-of select="PRODUCTOESTANDAR/CP_PRO_NOMBRE"/></span>

						<xsl:if test="PRODUCTOESTANDAR/ADMIN">
								<!- -&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoPrivadoProductoEmpresa.xsql?IDEMPRESA=1&amp;ORIGEN=EVALUACION','Cat?logo Privado',50,80,90,20);" style="text-decoration:none;">- ->
								<!- -&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoPrivadoProductoEmpresa.xsql?ORIGEN=EVALUACION','Cat?logo Privado',50,80,90,20);" style="text-decoration:none;">- ->
								&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/CatalogosClientes.xsql?TYPE=MVM&amp;VS=SIMPLE','Cat?logo Clientes',50,80,90,20);" style="text-decoration:none;">
										<img>
												<xsl:attribute name="src">
													<xsl:choose>
													<xsl:when test="LANG = 'spanish'">http://www.newco.dev.br/images/buscaCli.gif</xsl:when>
													<xsl:otherwise>http://www.newco.dev.br/images/buscaCli.gif</xsl:otherwise>
													</xsl:choose>
												</xsl:attribute>
												<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscador_catalogo_clientes']/node()"/></xsl:attribute>
												<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscador_catalogo_clientes']/node()"/></xsl:attribute>
										</img>
								</a>
								&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/BuscarProveedoresEval.xsql?ORIGEN=EVAL','Cat?logo Proveedores',50,80,90,20);" style="text-decoration:none;">
										<img>
												<xsl:attribute name="src">
													<xsl:choose>
													<xsl:when test="LANG = 'spanish'">http://www.newco.dev.br/images/buscaPro.gif</xsl:when>
													<xsl:otherwise>http://www.newco.dev.br/images/buscaPro-BR.gif</xsl:otherwise>
													</xsl:choose>
												</xsl:attribute>
												<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscador_catalogo_proveedores']/node()"/></xsl:attribute>
												<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscador_catalogo_proveedores']/node()"/></xsl:attribute>
										</img>
								</a>
						</xsl:if>
        </h1>

        <h1 class="titlePage" style="width:10%; float:left;text-align:right;">
            <a href="http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/HistoricosCentros.xsql?ID_EMP={/HistoricosCentros/PRODUCTOESTANDAR/IDEMPRESA}&amp;ID_PROD_ESTANDAR={/HistoricosCentros/PRODUCTOESTANDAR/CP_PRO_ID_SIGUIENTE}" title="Siguiente producto" target="_self" style="text-decoration:none;">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/>
            </a>&nbsp;
            <a href="http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/HistoricosCentros.xsql?ID_EMP={/HistoricosCentros/PRODUCTOESTANDAR/IDEMPRESA}&amp;ID_PROD_ESTANDAR={/HistoricosCentros/PRODUCTOESTANDAR/CP_PRO_ID_SIGUIENTE}" title="Siguiente producto" target="_self" style="text-decoration:none;">
                <img src="http://www.newco.dev.br/images/siguiente.gif" alt="Producto siguiente" />
            </a>
            &nbsp;
        </h1>
		-->

	<!--tabla precios historicos por centro-->
	<div class="divLeft">
		<!--table class="grandeInicio" border="1">-->
		<table class="buscador">

			<tr class="sinLinea">
				<!-- Ref. Cliente -->
				<td class="dies label textRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:&nbsp;
				</td>
				<td class="dies textLeft">
					<xsl:value-of select="PRODUCTOESTANDAR/CP_PRO_REFCLIENTE"/>
				</td>
				<!-- Precio medio -->
				<td class="dies label textRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_medio']/node()"/>:&nbsp;
				</td>
				<td class="dies textLeft">
					<xsl:value-of select="PRODUCTOESTANDAR/CP_HCE_PRECIOMEDIO"/>
				</td>
				<!-- Precio MVM -->
				<td class="dies label textRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_mvm']/node()"/>:&nbsp;
				</td>
				<td class="dies textLeft">
					<xsl:choose>
					<xsl:when test="PRODUCTOESTANDAR/ADMIN">
						<input type="text" name="PRECIO_MVM" id="PRECIO_MVM" value="{PRODUCTOESTANDAR/CP_HCE_PRECIOMVM}"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
						<xsl:when test="PRODUCTOESTANDAR/CP_HCE_AHORRO >= 0">
								<xsl:value-of select="PRODUCTOESTANDAR/CP_HCE_PRECIOMVM"/>
						</xsl:when>
						</xsl:choose>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>

			<tr class="sinLinea">
				<!-- Consumo anual -->
				<td class="label textRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_anual']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:value-of select="PRODUCTOESTANDAR/CP_HCE_CONSUMOANUAL"/>
				</td>
				<!-- Ahorro -->
				<td class="label textRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="PRODUCTOESTANDAR/ADMIN or PRODUCTOESTANDAR/CP_HCE_AHORRO >= 0">
							<xsl:value-of select="PRODUCTOESTANDAR/CP_HCE_AHORRO"/>
						<xsl:if test="PRODUCTOESTANDAR/CP_HCE_AHORROPORC != ''">
							&nbsp;-&nbsp;<xsl:value-of select="PRODUCTOESTANDAR/CP_HCE_AHORROPORC"/>%
						</xsl:if>
					</xsl:when>
					</xsl:choose>

				</td>
				<!-- Unidad basica -->
				<td class="label textRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="PRODUCTOESTANDAR/ADMIN">
						<input type="text" name="UDBASICA_BASE" id="UDBASICA_BASE" value="{PRODUCTOESTANDAR/CP_HCE_UNIDADBASICA}"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="PRODUCTOESTANDAR/CP_HCE_UNIDADBASICA"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>
				<!--<xsl:if test="PRODUCTOESTANDAR/ADMIN">
					<div class="boton" id="GuardarDatosBasicos" style="margin-left:10px;">
						<a href="javascript:guardarDatosBasicos();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
						</a>
					</div>
				</xsl:if>-->
				</td>
			</tr>
		</table>

		<!--<table class="grandeInicio">-->
		<table class="buscador">
			<tr class="subTituloTabla">
				<th class="zerouno">&nbsp;</th>
				<th class="cinco textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
				<th class="veintecinco textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
				<th class="veintedos textLeft">
					<span style="line-height:40px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></span>
					<xsl:if test="PRODUCTOESTANDAR/ADMIN">
					<div class="boton" id="NuevaEntrada" style="float:right;margin:7px 10px;">
						<a href="javascript:abrirBoxEntradaDatos(null);">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_entrada']/node()"/>
						</a>
					</div>
					</xsl:if>
				</th>
				<th class="seis textRight" style="padding-right:2px;"><xsl:copy-of select="document($doc)/translation/texts/item[@name='unidad_basica_2line']/node()"/></th>
				<th class="seis textRight" style="padding-right:2px;"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ud_por_lote_2line']/node()"/></th>
				<th class="seis textRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></th>
				<th class="seis textRight"><xsl:copy-of select="document($doc)/translation/texts/item[@name='cantidad_anual_2line']/node()"/></th>
				<th class="seis textRight"><xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_anual_2line']/node()"/></th>
				<th class="cinco textRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/></th>
				<th class="seis textRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro_porc']/node()"/></th>
				<th>&nbsp;</th>
				<th class="zerouno">&nbsp;</th>
			</tr>

		<xsl:choose>
		<xsl:when test="PRODUCTOESTANDAR">
			<xsl:for-each select="PRODUCTOESTANDAR/CENTRO">
			<tr class="gris" style="border-top:2px solid #999;">
				<td>&nbsp;</td>
				<td class="label textLeft" colspan="2"><xsl:value-of select="NOMBRE"/></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td class="textRight"><xsl:value-of select="CP_HCC_PRECIOMEDIO"/></td>
				<td class="textRight"><xsl:value-of select="CP_HCC_CANTIDADANUAL"/></td>
				<td class="textRight"><xsl:value-of select="CP_HCC_CONSUMOANUAL"/></td>
				<td class="textRight">
				<xsl:choose>
				<xsl:when test="/HistoricosCentros/PRODUCTOESTANDAR/ADMIN or /HistoricosCentros/PRODUCTOESTANDAR/CP_HCE_AHORRO >= 0">
						<xsl:value-of select="CP_HCC_AHORRO"/>
				</xsl:when>
				</xsl:choose>
				</td>
				<td class="textRight">
				<xsl:choose>
				<xsl:when test="/HistoricosCentros/PRODUCTOESTANDAR/ADMIN or /HistoricosCentros/PRODUCTOESTANDAR/CP_HCE_AHORRO >= 0">
						<xsl:value-of select="CP_HCC_AHORROPORC"/>
				</xsl:when>
				</xsl:choose>
				</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
				<xsl:for-each select="PRECIO_HISTORICO">
				<tr id="ID_{CP_HC_ID}">
					<td>&nbsp;</td>
					<td>
						<span id="CEN_{CP_HC_ID}" style="display:none;"><xsl:value-of select="../NOMBRE"/></span>
						<span id="IDCEN_{CP_HC_ID}" style="display:none;"><xsl:value-of select="../ID"/></span>
					</td>
					<td class="textLeft" id="PROV_{CP_HC_ID}"><xsl:value-of select="PROVEEDOR"/></td>
					<td class="textLeft">
						<span id="NOM_{CP_HC_ID}"><xsl:value-of select="PRODUCTO"/></span>
						<xsl:if test="REFPROVEEDOR != ''">
							<xsl:text>&nbsp;[</xsl:text><span id="REFP_{CP_HC_ID}"><xsl:value-of select="REFPROVEEDOR"/></span><xsl:text>]</xsl:text>
						</xsl:if>
						<span id="REFC_{CP_HC_ID}" style="display:none;"><xsl:value-of select="REFCLIENTE"/></span>
					</td>
					<td class="textRight" id="UDB_{CP_HC_ID}"><xsl:value-of select="UNIDADBASICA"/></td>
					<td class="textRight" id="UDL_{CP_HC_ID}"><xsl:value-of select="UNIDADESPORLOTE"/></td>
					<td class="textRight" id="PR_{CP_HC_ID}"><xsl:value-of select="PRECIO"/></td>
					<td class="textRight" id="CANT_{CP_HC_ID}"><xsl:value-of select="CANTIDADANUAL"/></td>
					<td class="textRight"><xsl:value-of select="CONSUMOANUAL"/></td>
					<td class="textRight">
					<xsl:choose>
					<xsl:when test="/HistoricosCentros/PRODUCTOESTANDAR/ADMIN or /HistoricosCentros/PRODUCTOESTANDAR/CP_HCE_AHORRO >= 0">
							<xsl:value-of select="AHORRO"/>
					</xsl:when>
					</xsl:choose>
					</td>
					<td class="textRight">
					<xsl:choose>
					<xsl:when test="/HistoricosCentros/PRODUCTOESTANDAR/ADMIN or /HistoricosCentros/PRODUCTOESTANDAR/CP_HCE_AHORRO >= 0">
							<xsl:value-of select="AHORROPORC"/>
					</xsl:when>
					</xsl:choose>
					</td>
					<td>
                                        <xsl:choose>
					<xsl:when test="ANOTACIONES != ''">
						<a href="#" class="tooltip">
							<img src="http://www.newco.dev.br/images/info.gif" class="static"/>
							<span class="classic spanEIS" id="ANOT_{CP_HC_ID}"><xsl:copy-of select="ANOTACIONES/node()"/></span>
						</a>
                                        </xsl:when>
                                        <xsl:otherwise>
                                                <a href="#" class="tooltip">
							<span class="classic spanEIS" id="ANOT_{CP_HC_ID}"><xsl:copy-of select="ANOTACIONES/node()"/></span>
						</a>
                                        </xsl:otherwise>
                                        </xsl:choose>
					<xsl:if test="/HistoricosCentros/PRODUCTOESTANDAR/ADMIN">
						<a href="javascript:abrirBoxEntradaDatos({CP_HC_ID});"><img src="http://www.newco.dev.br/images/boliIcon.gif"/></a>
					</xsl:if>
					</td>
					<td>&nbsp;</td>
				</tr>
				</xsl:for-each>
			</xsl:for-each>
		</xsl:when>
		<xsl:otherwise>
			<tr style="border-bottom:1px solid #A7A8A9;">
				<td align="center" colspan="13">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='no_datos_disponibles']/node()"/>
				</td>
			</tr>
		</xsl:otherwise>
		</xsl:choose>
		</table>

	<xsl:if test="PRODUCTOESTANDAR/ADMIN">
		<!-- DIV Conversacion Proveedor -->
		<div class="overlay-container" id="InfoHistorica">
			<div class="window-container zoomout">
				<p style="text-align:right;">
                                    <a href="javascript:showTabla(false);" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/cerrar.gif" /></a>&nbsp;
                                   <!-- <a href="javascript:showTabla(false);">
                                        <xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
                                    </a>-->
                                </p>

				<p id="tableTitle">

					<span id="modDatos" style="display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='modifica_datos_para_centro']/node()"/>&nbsp;"<span id="NombreCentro"></span>"</span>
					<span id="newDatos" style="display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='entrada_datos_para_centro']/node()"/></span>
				</p>

				<div id="mensError" class="divLeft" style="display:none;">
					<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></strong></p>
				</div>

				<form name="entradaDatosForm" method="post" id="entradaDatosForm">
				<input type="hidden" name="ID" id="ID"/>
				<input type="hidden" name="IDEMPRESA" id="IDEMPRESA" value="{PRODUCTOESTANDAR/IDEMPRESA}"/>
				<input type="hidden" name="IDPRODESTANDAR" id="IDPRODESTANDAR" value="{PRODUCTOESTANDAR/CP_PRO_ID}"/>

				<table style="width:100%;">
				<thead>
					<tr><th colspan="6">&nbsp;</th></tr>
				</thead>

				<tbody>
					<tr id="trIDCentro" style="display:none;">
						<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/><span class="rojoNormal">*</span>:</strong></td>
						<td colspan="4">
							<select name="IDCENTRO" id="IDCENTRO" style="width:70%;float:left;">
								<option value=""><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciona']/node()"/></option>
								<xsl:for-each select="PRODUCTOESTANDAR/LISTACENTROS/field/dropDownList/listElem">
									<option value="{ID}"><xsl:value-of select="listItem"/></option>
								</xsl:for-each>
							</select>
						</td>
						<td>&nbsp;</td>
					</tr>

					<tr>
						<td colspan="6">
						<table style="width:100%;">
							<tr>
								<td class="quince"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:</strong></td>
								<td class="sesanta"><input type="text" name="NOMBRE" id="NOMBRE" style="width:100%;float:left;"/></td>
								<td>&nbsp;</td>
								<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:</strong></td>
								<td><input type="text" name="REFCLI" id="REFCLI" style="width:100%;float:left;"/></td>
								<td class="uno">&nbsp;</td>
							</tr>
						</table>
						</td>
					</tr>

					<tr>
						<td class="quince"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</strong></td>
						<td><input type="text" name="PROVEEDOR" id="PROVEEDOR" style="width:100%;float:left;"/></td>
						<td>&nbsp;</td>
						<td class="quince"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/>:</strong></td>
						<td><input type="text" name="REFPROV" id="REFPROV" style="width:100%;float:left;"/></td>
						<td class="uno">&nbsp;</td>
					</tr>

					<tr>
						<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica_abr']/node()"/><span class="rojoNormal">*</span>:</strong></td>
						<td><input type="text" name="UDBASICA" id="UDBASICA" style="width:100%;float:left;"/></td>
						<td>&nbsp;</td>
						<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_por_lote']/node()"/>:</strong></td>
						<td><input type="text" name="UDSLOTE" id="UDSLOTE" style="width:100%;float:left;"/></td>
						<td>&nbsp;</td>
					</tr>

					<tr>
						<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>:</strong></td>
						<td><input type="text" name="PRECIO" id="PRECIO" style="width:100%;float:left;"/></td>
						<td>&nbsp;</td>
						<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_anual']/node()"/><span class="rojoNormal">*</span>:</strong></td>
						<td><input type="text" name="CANTIDAD" id="CANTIDAD" style="width:100%;float:left;"/></td>
						<td>&nbsp;</td>
					</tr>

					<tr>
						<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='anotaciones']/node()"/>:</strong></td>
						<td colspan="4"><textarea name="ANOTACIONES" id="ANOTACIONES" rows="4" style="width:100%;float:left;"/></td>
						<td>&nbsp;</td>
					</tr>
				</tbody>

				<tfoot>
					<tr>
						<td>&nbsp;</td>
						<td>
							<div class="boton" id="GuardarDatos">
								<a href="javascript:validarForm();">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
								</a>
							</div>
						</td>
						<td id="Respuesta" colspan="4" style="text-align:left;"></td>
					</tr>
				</tfoot>
				</table>
				</form>
			</div>
		</div>
	<!-- FIN DIV Conversacion Proveedor -->
	</xsl:if>

	</div><!--fin div tabla precios historicos por centro-->

	<!-- DIV Nueva etiqueta -->
	<div class="overlay-container" id="verEtiquetas">
	    <div class="window-container zoomout">
                <p style="text-align:right;">
                                    <a href="javascript:showTabla(false);" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/cerrar.gif" /></a>&nbsp;
                                   <!-- <a href="javascript:showTabla(false);">
                                        <xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
                                    </a>-->
                                </p>

	        <p id="tableTitle">
	            <xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta']/node()"/>
	            <xsl:choose>
	            <xsl:when test="PRODUCTOESTANDAR/CP_PRO_NOMBRE">
	                &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='para']/node()"/>&nbsp;
	                <xsl:choose>
	                <xsl:when test="string-length(PRODUCTOESTANDAR/CP_PRO_NOMBRE) > 75">
	                    "<xsl:value-of select="substring(PRODUCTOESTANDAR/CP_PRO_NOMBRE, 1, 75)"/>..."
	                </xsl:when>
	                <xsl:otherwise>
	                    "<xsl:value-of select="PRODUCTOESTANDAR/CP_PRO_NOMBRE"/>"
	                </xsl:otherwise>
	                </xsl:choose>
	            </xsl:when>
							<xsl:otherwise>
									&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='para']/node()"/>&nbsp;
									<xsl:value-of select="document($doc)/translation/texts/item[@name='no_disponible']/node()"/>
							</xsl:otherwise>
	            </xsl:choose>
	        </p>

	        <div id="mensError" class="divLeft" style="display:none;">
	            <p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></strong></p>
	        </div>

	        <table id="viejasEtiquetas" border="0" style="width:100%;display:none;">
	        <thead>
	            <th colspan="5">&nbsp;</th>
	        </thead>

	        <tbody></tbody>

	        </table>

	        <form name="nuevaEtiquetaForm" method="post" id="nuevaEtiquetaForm">

	        <table id="nuevaEtiqueta" style="width:100%;">
	        <thead>
	            <th colspan="3">&nbsp;</th>
	        </thead>

	        <tbody>
	            <tr>
	                <td class="dies"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='etiqueta']/node()"/>:</strong></td>
	                <td colspan="2"><textarea name="TEXTO" id="TEXTO" rows="4" cols="70" style="float:left;"/></td>
	            </tr>
	        </tbody>

	        <tfoot>
	            <tr>
	                <td>&nbsp;</td>
	                <td>
	                    <div class="boton" id="botonGuardar">
	                        <a href="javascript:guardarEtiqueta();">
	                            <xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
	                        </a>
	                    </div>
	                </td>
	                <td id="Respuesta" style="text-align:left;"></td>
	            </tr>
	        </tfoot>
	        </table>
	        </form>
	    </div>
	</div>
	<!-- FIN DIV Nueva etiqueta -->

</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
