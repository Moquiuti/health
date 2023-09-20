<?xml version="1.0" encoding="iso-8859-1"?>
<!--	
	ultima revision ET 27set18 16:10
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/FinEnvioFichero">
	<xsl:text>{"FinEnvio":</xsl:text>
		<xsl:text>{"estado":"</xsl:text>
		<xsl:choose>
		<xsl:when test="FICHERO/ESTADO='OK'">
			<xsl:text>OK",</xsl:text>
			<xsl:text>"idfichero":"</xsl:text>
			<xsl:value-of select="FICHERO/ID"/>
		</xsl:when>
		<xsl:when test="ERROR">
			<xsl:text>ERROR</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>DESCONOCIDO</xsl:text>
		</xsl:otherwise>
		</xsl:choose>
		<xsl:text>"}</xsl:text>
	<xsl:text>}</xsl:text>
</xsl:template>
</xsl:stylesheet>
