<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 	Adjudica múltiples ofertas en la ficha de producto de la licitacion (FichaProductoLicitacionHTML.xsl)
	Ultima revision ET 6jul18 11:13
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/SeleccionarProducto">

	<xsl:text>{"Resultado":</xsl:text>
		<xsl:text>{"Estado":"</xsl:text>
		<xsl:if test="OK">
			<xsl:text>OK</xsl:text>
		</xsl:if>
		<xsl:if test="ERROR">
			<xsl:text>ERROR</xsl:text>
		</xsl:if>
		<xsl:text>"}</xsl:text>
	<xsl:text>}</xsl:text>
</xsl:template>
</xsl:stylesheet>
