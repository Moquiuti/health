<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/Productos">

	<xsl:param name="pPattern">"</xsl:param>
	<xsl:param name="pReplacement">\"</xsl:param>

	<xsl:text>{"IDPais":"</xsl:text>
		<xsl:value-of select="PRODUCTOSLICITACION/IDPAIS"/>
	<xsl:text>",</xsl:text>
	<xsl:text>"ListaProductos":[</xsl:text>
		<xsl:for-each select="PRODUCTOSLICITACION/PRODUCTO">
			<!-- Evitamos la doble comilla (") en el nombre de producto -->
			<xsl:variable name="NombreProducto">
				<xsl:call-template name="string-replace-all">
					<xsl:with-param name="text" select="LIC_PROD_NOMBRE"/>
					<xsl:with-param name="replace" select="$pPattern"/>
					<xsl:with-param name="by" select="$pReplacement"/>
				</xsl:call-template>
			</xsl:variable>

			<xsl:text>{"LIC_PROD_ID":"</xsl:text>
				<xsl:value-of select="LIC_PROD_ID"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Linea":"</xsl:text>
				<xsl:value-of select="LINEA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"IDProdEstandar":"</xsl:text>
				<xsl:value-of select="LIC_PROD_IDPRODESTANDAR"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ProdRefEstandar":"</xsl:text>
				<xsl:value-of select="LIC_PROD_REFESTANDAR"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ProdRefCliente":"</xsl:text>
				<xsl:value-of select="LIC_PROD_REFCLIENTE"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ProdRefCentro":"</xsl:text>
				<xsl:value-of select="REFCENTRO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ProdNombre":"</xsl:text>
				<xsl:value-of select="$NombreProducto"/>
			<xsl:text>","ProdNombreNorm":"</xsl:text>
				<xsl:value-of select="PROD_NOMBRENORM"/>
			<xsl:text>","ProdUdBasica":"</xsl:text>
				<xsl:value-of select="LIC_PROD_UNIDADBASICA"/>
			<xsl:text>","FechaAlta":"</xsl:text>
				<xsl:value-of select="LIC_PROD_FECHAALTA"/>
			<xsl:text>","FechaModificacion":"</xsl:text>
				<xsl:value-of select="LIC_PROD_FECHAMODIFICACION"/>
			<xsl:text>","Consumo":"</xsl:text>
				<xsl:value-of select="LIC_PROD_CONSUMO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ConsumoIVA":"</xsl:text>
				<xsl:value-of select="LIC_PROD_CONSUMOIVA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ConsumoHist":"</xsl:text>
				<xsl:value-of select="LIC_PROD_CONSUMOHISTORICO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ConsumoHistIVA":"</xsl:text>
				<xsl:value-of select="LIC_PROD_CONSUMOHISTORICOIVA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Cantidad":"</xsl:text>
				<xsl:value-of select="LIC_PROD_CANTIDAD"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"PrecioReferencia":"</xsl:text>
				<xsl:value-of select="LIC_PROD_PRECIOREFERENCIA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"PrecioReferenciaIVA":"</xsl:text>
				<xsl:value-of select="LIC_PROD_PRECIOREFERENCIAIVA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"PrecioObjetivo":"</xsl:text>
				<xsl:value-of select="LIC_PROD_PRECIOOBJETIVO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"PrecioObjetivoIVA":"</xsl:text>
				<xsl:value-of select="LIC_PROD_PRECIOOBJETIVOIVA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"TipoIVA":"</xsl:text>
				<xsl:value-of select="LIC_PROD_TIPOIVA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"InfoAmpliada":"</xsl:text>
				<xsl:copy-of select="LIC_PROD_INFOAMPLIADA_JS/node()"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Anotaciones":"</xsl:text>
				<xsl:copy-of select="LIC_PROD_ANOTACIONES_JS/node()"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Marcas":"</xsl:text>
				<xsl:value-of select="LIC_PROD_MARCASACEPTABLES"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"PrincActivo":"</xsl:text>
				<xsl:value-of select="LIC_PROD_PRINCIPIOACTIVO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Documento":{</xsl:text>
				<xsl:text>"ID":"</xsl:text>
					<xsl:value-of select="DOCUMENTO/ID"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"Nombre":"</xsl:text>
					<xsl:value-of select="DOCUMENTO/NOMBRE"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"Descripcion":"</xsl:text>
					<xsl:value-of select="DOCUMENTO/DESCRIPCION"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"Url":"</xsl:text>
					<xsl:value-of select="DOCUMENTO/URL"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"Fecha":"</xsl:text>
					<xsl:value-of select="DOCUMENTO/FECHA"/>
				<xsl:text>"</xsl:text>
			<xsl:text>},</xsl:text>
			<xsl:text>"Validado":"</xsl:text>
				<xsl:choose>
				<xsl:when test="VALIDADO">
					<xsl:text>S</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>N</xsl:text>
				</xsl:otherwise>
				</xsl:choose>
			<xsl:text>"}</xsl:text>
			<xsl:if test="position() != last()">
				<xsl:text>,</xsl:text>
			</xsl:if>
		</xsl:for-each>
	<xsl:text>]}</xsl:text>
</xsl:template>

<xsl:template name="string-replace-all">
	<xsl:param name="text"/>
	<xsl:param name="replace"/>
	<xsl:param name="by"/>

	<xsl:choose>
	<xsl:when test="contains($text, $replace)">
		<xsl:value-of select="substring-before($text,$replace)"/>
		<xsl:value-of select="$by"/>
                
		<xsl:call-template name="string-replace-all">
			<xsl:with-param name="text" select="substring-after($text,$replace)"/>
			<xsl:with-param name="replace" select="$replace"/>
			<xsl:with-param name="by" select="$by"/>
		</xsl:call-template>
	</xsl:when>
	<xsl:otherwise>
		<xsl:copy-of select="$text"/>
	</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
