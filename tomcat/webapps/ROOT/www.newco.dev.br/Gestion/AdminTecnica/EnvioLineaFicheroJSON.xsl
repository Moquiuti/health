<?xml version="1.0" encoding="iso-8859-1"?>
<!--	
	ultima revision 31dic16 19:05
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/EnvioLineaFichero">
	<xsl:text>{"EnviarLinea":</xsl:text>
		<xsl:text>{"estado":"</xsl:text>
		<xsl:if test="FICHERO/ESTADO='OK'">
			<xsl:text>OK",</xsl:text>
			<xsl:text>"idlinea":"</xsl:text>
			<xsl:value-of select="FICHERO/IDLINEA"/>
			<xsl:text>","numlinea":"</xsl:text>
			<xsl:value-of select="FICHERO/NUMERO_LINEA"/>
		</xsl:if>
		<xsl:if test="ERROR">
			<xsl:text>ERROR</xsl:text>
		</xsl:if>
		<xsl:text>"}</xsl:text>
	<xsl:text>}</xsl:text>
</xsl:template>
</xsl:stylesheet>
