<?xml version="1.0" encoding="iso-8859-1"?>
<!--	
	Cambio de grupo, incluye tambien cambio de referencia estandar
	ultima revision: ET 08nov22 09:30
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/EnvioLineaFichero">
	<xsl:text>{"EnviarLinea":</xsl:text>
		<xsl:text>{"estado":"</xsl:text>
		<xsl:if test="OK">
			<xsl:text>OK",</xsl:text>
			<xsl:text>"idproducto":"</xsl:text>
			<xsl:value-of select="OK/IDPRODUCTO"/>
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