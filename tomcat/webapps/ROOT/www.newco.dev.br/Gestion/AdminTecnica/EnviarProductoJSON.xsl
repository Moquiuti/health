<?xml version="1.0" encoding="iso-8859-1"?>
<!--	
	ultima revision 31dic16 19:05
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/EnviarProducto">
	<xsl:text>{"Producto":</xsl:text>
		<xsl:text>{"estado":"</xsl:text>
		<xsl:choose>
		<xsl:when test="OK">
			<xsl:text>OK",</xsl:text>
			<xsl:text>"IDProductoLic":"</xsl:text><xsl:value-of select="OK/LIC_PROD_ID"/>
			<xsl:text>", "IDProductoEstandar":"</xsl:text><xsl:value-of select="OK/CP_PRO_ID"/>
			<xsl:text>", "IDSeleccion":"</xsl:text><xsl:value-of select="OK/LIC_IDSELECCION"/>
		</xsl:when>
		<xsl:when test="ERROR">
			<xsl:text>ERROR:</xsl:text><xsl:value-of select="ERROR/@msg"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>DESCONOCIDO</xsl:text>
		</xsl:otherwise>
		</xsl:choose>
		<xsl:text>"}</xsl:text>
	<xsl:text>}</xsl:text>
</xsl:template>
</xsl:stylesheet>
