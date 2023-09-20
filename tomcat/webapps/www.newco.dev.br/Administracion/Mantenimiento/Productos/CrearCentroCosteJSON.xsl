<?xml version="1.0" encoding="iso-8859-1"?>
<!--	
	Crear un centro de coste via Ajax
	ultima revision ET 5set22 18:00
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/EnvioLineaFichero">
	<xsl:text>{"EnviarLinea":</xsl:text>
		<xsl:text>{"estado":"</xsl:text>
		<xsl:if test="OK">
			<xsl:text>OK",</xsl:text>
			<xsl:text>"idcentrocoste":"</xsl:text>
			<xsl:value-of select="OK/IDEMPRESA"/>
			<xsl:text>","numlinea":"</xsl:text>
			<xsl:value-of select="OK/NUMLINEA"/>
		</xsl:if>
		<xsl:if test="ERROR">
			<xsl:text>ERROR:</xsl:text>
			<xsl:value-of select="ERROR/@msg"/>
		</xsl:if>
		<xsl:text>"}</xsl:text>
	<xsl:text>}</xsl:text>
</xsl:template>
</xsl:stylesheet>
