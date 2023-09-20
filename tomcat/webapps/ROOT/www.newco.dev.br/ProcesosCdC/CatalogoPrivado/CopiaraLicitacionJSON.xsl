<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/CopiaraLicitacion">

	<xsl:text>{"CopiaraLicitacion":</xsl:text>
		<xsl:text>{"estado":"</xsl:text>
		<xsl:if test="OK">
			<xsl:text>OK",</xsl:text>
			<xsl:text>"IDProd":"</xsl:text>
			<xsl:value-of select="OK"/>
		</xsl:if>
		<xsl:if test="ERROR">
			<xsl:text>ERROR</xsl:text>
		</xsl:if>
                <xsl:if test="NO_ENCONTRADA">
			<xsl:text>NO_ENCONTRADA</xsl:text>
		</xsl:if>
		<xsl:text>"}</xsl:text>
	<xsl:text>}</xsl:text>
</xsl:template>
</xsl:stylesheet>