<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Catalogación rápida
	UltimaRevisión: ET 20feb23 18:30 CatalogacionRapida2022_200223.js
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
		<xsl:choose>
		<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Catalogacion_rapida']/node()"/>:&nbsp;<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFERENCIA"/>&nbsp;<xsl:value-of select="substring(Mantenimiento/PRODUCTOESTANDAR/NOMBRE,1,70)"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/parsley_2.8.1.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/parsley.es.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/CatalogacionRapida2022_200223.js"></script>
</head>

<body onload="javascript:onloadEvents();">
<xsl:choose>
<xsl:when test="//SESION_CADUCADA">
	<xsl:apply-templates select="//SESION_CADUCADA"/>
</xsl:when>
<xsl:when test="//Sorry">
	<xsl:apply-templates select="//Sorry"/>
</xsl:when>
<xsl:otherwise>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p>
			<xsl:attribute name="class">
			<xsl:choose>
				<!--23abr19	Para productos traspasados-->
				<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">TituloPagina rojo</xsl:when>
				<xsl:otherwise>TituloPagina</xsl:otherwise>							
			</xsl:choose>
			</xsl:attribute>
			<!--	Nombre del producto -->
			<xsl:choose>
				<!--23abr19	Para productos traspasados-->
				<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/TRASPASADO">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Traspasado']/node()"/>:&nbsp;<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFCLIENTE"/>&nbsp;<xsl:value-of select="substring(Mantenimiento/PRODUCTOESTANDAR/NOMBRE,1,20)"/>
					-><xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/TRASPASADO/REFCLIENTE"/>&nbsp;<xsl:value-of select="substring(Mantenimiento/PRODUCTOESTANDAR/TRASPASADO/NOMBRE,1,20)"/>
                </xsl:when>
				<xsl:when test="/Mantenimiento/PRODUCTOESTANDAR/REFCLIENTE != ''">
					<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFCLIENTE"/>&nbsp;(<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFERENCIA"/>)&nbsp;<xsl:value-of select="substring(Mantenimiento/PRODUCTOESTANDAR/NOMBRE,1,70)"/>
                </xsl:when>
				<xsl:when test="/Mantenimiento/PRODUCTOESTANDAR/REFERENCIA != ''">
					<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFERENCIA"/>&nbsp;<xsl:value-of select="substring(Mantenimiento/PRODUCTOESTANDAR/NOMBRE,1,70)"/>
                </xsl:when>
				<xsl:otherwise>							
					<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBRE"/>
				</xsl:otherwise>							
			</xsl:choose>
			<xsl:if test="/Mantenimiento/PRODUCTOESTANDAR/CONCONTRATO = 'S'">
				&nbsp;&nbsp;&nbsp;<span class="verde"><xsl:value-of select="document($doc)/translation/texts/item[@name='CON_CONTRATO']/node()"/></span>
			</xsl:if>
			<xsl:if test="/Mantenimiento/PRODUCTOESTANDAR/CONCONTRATO = 'C'">
				&nbsp;&nbsp;&nbsp;<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='CONTRATO_CADUCADO']/node()"/></span>
			</xsl:if>

			<span class="CompletarTitulo" style="width:500px;font-size:13px;">
				<xsl:if test="Mantenimiento/PRODUCTOESTANDAR/BOTON_ADJUDICAR">
					<!--	Botón "adjudicar" -->
					<a class="btnDestacado" id="btnAdjudicar" href="javascript:AdjudicarProducto();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
					</a>
                </xsl:if>
				<xsl:if test="Mantenimiento/PRODUCTOESTANDAR/BOTON_ACTUALIZAR">
					<!--	Botón "adjudicar" -->
					<a class="btnDestacado" id="btnActualizar" href="javascript:ActualizarProducto();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar']/node()"/>
					</a>
					&nbsp;
					<!--	Botón "desadjudicar" -->
					<a class="btnDestacado" id="btnQuitar" href="javascript:DesadjudicarProducto();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='quitar']/node()"/>
					</a>
					&nbsp;
					<!--	Botón "ficha de adjudicacion" -->
					<a class="btnNormal" href="javascript:FichaAdjudicacion({Mantenimiento/PRODUCTOESTANDAR/PRODUCTO/ID},{Mantenimiento/PRODUCTOESTANDAR/IDEMPRESA});">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo']/node()"/>
                	</a>
				</xsl:if>
				&nbsp;
				<a class="btnNormal" id="btnMantenimiento" href="javascript:chMantenProdEstandar({Mantenimiento/PRODUCTOESTANDAR/ID});">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento']/node()"/>
				</a>
			</span>
		</p>
	</div>
	<br/>
	<br/>		
	<div class="divLeft">
	<form name="frmProducto" id="frmProducto" data-parsley-validate="" action="./CatalogacionRapida2022.xsql" method="post">
		
		<input type="hidden" name="IDPRODESTANDAR" id="IDPRODESTANDAR" value="{Mantenimiento/PRODUCTOESTANDAR/ID}"/>
		<input type="hidden" name="IDEMPRESA" id="IDEMPRESA" value="{Mantenimiento/PRODUCTOESTANDAR/IDEMPRESA}"/>
		<input type="hidden" name="ACTION" id="ACTION" value=""/>
		<input type="hidden" name="CREARVARIANTE" id="CREARVARIANTE" value=""/>
		

		<table cellspacing="6px" cellpadding="6px">
			<tr class="sinLinea">
				<td colspan="2">&nbsp;</td>
				<td class="textLeft" colspan="2"><span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='los_siguientes_caracteres_no_deben_sin_barra']/node()"/></span></td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<strong><xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFERENCIA"/></strong>
					<input type="checkbox" class="muypeq" name="chkCREARVARIANTE" id="chkCREARVARIANTE" unchecked="" onclick="javascript:CambioCrearVariante();"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Crear_variante']/node()"/>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:&nbsp;
				</td>
				<td class="textLeft"><strong><xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/REFCLIENTE"/></strong></td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/NOMBRE"/>
				</td>
				<td>&nbsp;</td>
			</tr>
            <!--marcas aceptadas-->
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='marcas']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/MARCASACEPTABLES"/>
				</td>
				<td>&nbsp;</td>
			</tr>
            <!--28cot16	unidad básica-->
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/UNIDADBASICA"/>
				</td>
				<td>&nbsp;</td>
			</tr>
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ref']/node()"/><xsl:if test="Mantenimiento/PRODUCTOESTANDAR/DIVISA/PREFIJO != ''">(<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/DIVISA/PREFIJO"/>)</xsl:if>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/PRECIOREFERENCIA" />&nbsp;<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/DIVISA/SUFIJO"/>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td colspan="2">&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td colspan="2">&nbsp;</td>
				<td class="labelLeft tituloTabla"><xsl:value-of select="document($doc)/translation/texts/item[@name='Datos_catalogo_proveedor']/node()"/></td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight w300px">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:
					<span class="camposObligatorios">*</span>
					<input type="hidden" name="IDPRODUCTO" id="IDPRODUCTO" value="{Mantenimiento/PRODUCTOESTANDAR/PRODUCTO/ID}"/>
				</td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/BOTON_ADJUDICAR">
						<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Mantenimiento/PRODUCTOESTANDAR/PROVEEDORES/field"></xsl:with-param>
						<xsl:with-param name="claSel">form-control w300px</xsl:with-param>
						<xsl:with-param name="required">required</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Mantenimiento/PRODUCTOESTANDAR/PROVEEDORES/field"></xsl:with-param>
						<xsl:with-param name="claSel">form-control w300px</xsl:with-param>
						<xsl:with-param name="required">required</xsl:with-param>
						<xsl:with-param name="deshabilitado">disabled</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/>:
					<span class="camposObligatorios">*</span>
				</td>
				<td class="textLeft">
					<input type="text" name="REFERENCIA" id="REFERENCIA" class="form-control campopesquisa" data-parsley-trigger="change" required="" value="{Mantenimiento/PRODUCTOESTANDAR/PRODUCTO/REFERENCIA}"/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="btnNormal" id="btnLimpiar" href="javascript:Limpiar();" style="display:none();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Limpiar']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" id="btnCatalogo" href="javascript:AbrirCatalogoProveedor();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo']/node()"/>
					</a>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:
					<span class="camposObligatorios">*</span>
				</td>
				<td class="textLeft">
					<input type="text" name="NOMBRE" id="NOMBRE" class="form-control w300px campopesquisa" data-parsley-trigger="change" required="" value="{Mantenimiento/PRODUCTOESTANDAR/PRODUCTO/NOMBRE}"/>
				</td>
				<td>&nbsp;</td>
			</tr>
            <!--marca (OPCIONAL)-->
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='marcas']/node()"/>:
					<span class="camposObligatorios">*</span>
				</td>
				<td class="textLeft">
					<input type="text" name="MARCA" id="MARCA" class="form-control w300px campopesquisa" data-parsley-trigger="change" required="" value="{Mantenimiento/PRODUCTOESTANDAR/PRODUCTO/MARCA}"/>
				</td>
				<td>&nbsp;</td>
			</tr>
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/>:
					<span class="camposObligatorios">*</span>
				</td>
				<td class="textLeft">
					<input type="text" name="UNIDADBASICA" id="UNIDADBASICA" class="form-control campopesquisa" data-parsley-trigger="change" required="" value="{Mantenimiento/PRODUCTOESTANDAR/PRODUCTO/UNIDADBASICA}"/>
				</td>
				<td>&nbsp;</td>
			</tr>
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_por_lote']/node()"/>:
					<span class="camposObligatorios">*</span>
				</td>
				<td class="textLeft">
					<input type="text" name="UNIDADESLOTE" id="UNIDADESLOTE" class="form-control campopesquisa" data-parsley-trigger="change" data-parsley-type="number" required="" value="{Mantenimiento/PRODUCTOESTANDAR/PRODUCTO/UNIDADESPORLOTE}"/>
				</td>
				<td>&nbsp;</td>
			</tr>
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/><xsl:if test="Mantenimiento/PRODUCTOESTANDAR/DIVISA/PREFIJO != ''">(<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/DIVISA/PREFIJO"/>)</xsl:if>:
					<span class="camposObligatorios">*</span>
				</td>
				<td class="textLeft">
					<input type="text" name="PRECIO" id="PRECIO" class="form-control campopesquisa" data-parsley-trigger="change" data-parsley-pattern="^\d+(,\d+)?$" value="{Mantenimiento/PRODUCTOESTANDAR/PRODUCTO/TRF_IMPORTE}" />&nbsp;<xsl:value-of select="Mantenimiento/PRODUCTOESTANDAR/DIVISA/SUFIJO"/>
				</td>
				<td>&nbsp;</td>
			</tr>
			<xsl:choose>
			<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/IDPAIS=55">
				<input type="hidden" name="IDTIPOIVA" value="3"/>
			</xsl:when>
			<xsl:otherwise>
            	<tr class="sinLinea">
					<td>&nbsp;</td>
					<td class="labelRight trentacinco">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/>:
						<span class="camposObligatorios">*</span>
					</td>
					<td class="textLeft">
						<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Mantenimiento/PRODUCTOESTANDAR/IDTIPOIVA/field"></xsl:with-param>
						<xsl:with-param name="claSel">form-control</xsl:with-param>
						<xsl:with-param name="required">required</xsl:with-param>
						</xsl:call-template>
						<!--
						<xsl:choose>
						<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/BOTON_ADJUDICAR">
							<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="Mantenimiento/PRODUCTOESTANDAR/IDTIPOIVA/field"></xsl:with-param>
							<xsl:with-param name="claSel">form-control</xsl:with-param>
							<xsl:with-param name="required">required</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="Mantenimiento/PRODUCTOESTANDAR/IDTIPOIVA/field"></xsl:with-param>
							<xsl:with-param name="claSel">form-control</xsl:with-param>
							<xsl:with-param name="required">required</xsl:with-param>
							<xsl:with-param name="deshabilitado">disabled</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
						</xsl:choose>
						-->
					</td>
					<td>&nbsp;</td>
				</tr>
			</xsl:otherwise>
			</xsl:choose>
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_inicio_tarifa']/node()"/>:
				</td>
				<td class="textLeft">
					<input type="text" name="TRF_FECHAINICIO" id="TRF_FECHAINICIO" class="form-control campopesquisa" data-parsley-trigger="change" placeholder="DD/MM/YYYY" data-date-format="DD/MM/YYYY" value="{Mantenimiento/PRODUCTOESTANDAR/PRODUCTO/TRF_FECHAINICIO}"/>
				</td>
				<td>&nbsp;</td>
			</tr>
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_final_tarifa']/node()"/>:
				</td>
				<td class="textLeft">
					<input type="text" name="TRF_FECHALIMITE" id="TRF_FECHALIMITE" class="form-control campopesquisa" data-parsley-trigger="change" placeholder="DD/MM/YYYY" data-date-format="DD/MM/YYYY" value="{Mantenimiento/PRODUCTOESTANDAR/PRODUCTO/TRF_FECHALIMITE}"/>
				</td>
				<td>&nbsp;</td>
			</tr>
            <tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight trentacinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Documento_tarifa']/node()"/>:
				</td>
				<td class="textLeft">
					<input type="text" name="TRF_NOMBREDOCUMENTO" id="TRF_NOMBREDOCUMENTO" class="form-control campopesquisa" data-parsley-trigger="change" value="{Mantenimiento/PRODUCTOESTANDAR/PRODUCTO/TRF_NOMBREDOCUMENTO}"/>
				</td>
				<td>&nbsp;</td>
			</tr>
			<xsl:choose>
			<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/PRODUCTO/IDTIPONEGOCIACION/field/dropDownList/listElem">
            	<tr class="sinLinea">
					<td>&nbsp;</td>
					<td class="labelRight trentacinco">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_negociacion']/node()"/>:
					</td>
					<td class="textLeft">
						<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Mantenimiento/PRODUCTOESTANDAR/PRODUCTO/IDTIPONEGOCIACION/field"></xsl:with-param>
						<xsl:with-param name="claSel">form-control</xsl:with-param>
						</xsl:call-template>
					</td>
					<td>&nbsp;</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
				<xsl:when test="Mantenimiento/PRODUCTOESTANDAR/IDTIPONEGOCIACION/field/dropDownList/listElem">
            		<tr class="sinLinea">
						<td>&nbsp;</td>
						<td class="labelRight trentacinco">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_negociacion']/node()"/>:
						</td>
						<td class="textLeft">
							<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="Mantenimiento/PRODUCTOESTANDAR/IDTIPONEGOCIACION/field"></xsl:with-param>
							<xsl:with-param name="claSel">form-control</xsl:with-param>
							</xsl:call-template>
						</td>
						<td>&nbsp;</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<input type="text" name="IDTIPONEGOCIACION" value=""/>
				</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
			</xsl:choose>
			<tr class="sinLinea">
				<!--<td>&nbsp;</td>-->
                <td>&nbsp;</td>
				<td>&nbsp;
				</td>
				<td class="textLeft">
                    &nbsp;&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='los_campos_marcados_con']/node()"/>
					&nbsp;(<span class="camposObligatorios">*</span>)&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='son_obligatorios']/node()"/>.
				</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		<br/>
		<br/>		
		<br/>
		<br/>		
		<br/>
		<br/>		
		<br/>
		<br/>		
		<br/>
		<br/>		
	</form>
	</div>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
