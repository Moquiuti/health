<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/ConversacionLicitacionSave">

	<xsl:choose>
	<xsl:when test="RESPUESTA/OK">

		<xsl:text>{"Estado":"OK",</xsl:text>
		<xsl:text>"Empresa":"</xsl:text>
			<xsl:value-of select="RESPUESTA/EMPRESA"/>
		<xsl:text>","IDConv":"</xsl:text>
			<xsl:value-of select="RESPUESTA/OK"/>
		<xsl:text>"}</xsl:text>

	</xsl:when>

	<xsl:when test="RESPUESTA/ERROR">

		<xsl:text>{"Estado":"ERROR",</xsl:text>
		<xsl:text>"Empresa":"</xsl:text>
			<xsl:value-of select="RESPUESTA/EMPRESA"/>
		<xsl:text>"}</xsl:text>

	</xsl:when>

	<xsl:otherwise>

		<xsl:text>{"Estado":"ERROR",</xsl:text>
		<xsl:text>"mensaje":"</xsl:text>
			<xsl:value-of select="ERROR/@msg"/>
		<xsl:text>"}</xsl:text>

	</xsl:otherwise>
	</xsl:choose>

</xsl:template>
</xsl:stylesheet>