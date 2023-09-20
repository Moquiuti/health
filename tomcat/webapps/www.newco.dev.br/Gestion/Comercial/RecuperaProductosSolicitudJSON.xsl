<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/RecuperaProductosSolicitud">

	<xsl:param name="pPattern">"</xsl:param>
	<xsl:param name="pReplacement">\"</xsl:param>

	<xsl:text>{"ListaProductos":[</xsl:text>
		<xsl:for-each select="PRODUCTOS/PRODUCTO">
			<!-- Evitamos la doble comilla (") en el nombre de producto -->
			<xsl:variable name="NombreProducto">
				<xsl:call-template name="string-replace-all">
					<xsl:with-param name="text" select="SC_PROD_PRODUCTO"/>
					<xsl:with-param name="replace" select="$pPattern"/>
					<xsl:with-param name="by" select="$pReplacement"/>
				</xsl:call-template>
			</xsl:variable>

			<xsl:text>{"SC_PROD_ID":"</xsl:text>
				<xsl:value-of select="SC_PROD_ID"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"IDUsuario":"</xsl:text>
				<xsl:value-of select="IDUSUARIO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"NombreUsuario":"</xsl:text>
				<xsl:value-of select="USUARIO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"RefCliente":"</xsl:text>
				<xsl:value-of select="SC_PROD_REFCLIENTE"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Producto":"</xsl:text>
				<xsl:value-of select="$NombreProducto"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Fecha":"</xsl:text>
				<xsl:value-of select="SC_PROD_FECHA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Proveedor":"</xsl:text>
				<xsl:value-of select="SC_PROD_PROVEEDOR"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Precio":"</xsl:text>
				<xsl:value-of select="SC_PROD_PRECIO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Consumo":"</xsl:text>
				<xsl:value-of select="SC_PROD_CONSUMO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"RefProveedor":"</xsl:text>
				<xsl:value-of select="SC_PROD_REFPROVEEDOR"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"IDEstado":"</xsl:text>
				<xsl:value-of select="SC_PROD_IDESTADO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Estado":"</xsl:text>
				<xsl:value-of select="ESTADO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"FechaCatalogacion":"</xsl:text>
				<xsl:value-of select="SC_PROD_FECHACATALOGACION"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"IDProdEstandar":"</xsl:text>
				<xsl:value-of select="SC_PROD_IDPRODUCTOESTANDAR"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"IDProducto":"</xsl:text>
				<xsl:value-of select="SC_PROD_IDPRODUCTO"/>
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
