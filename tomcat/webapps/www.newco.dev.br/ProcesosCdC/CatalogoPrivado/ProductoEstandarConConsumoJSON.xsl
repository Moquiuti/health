<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/ProductoEstandarConConsumo">

		<xsl:text>{"consumo":"</xsl:text>

		<xsl:if test="SIN_CONSUMO">
			<xsl:text>No</xsl:text>
		</xsl:if>

		<xsl:if test="CON_CONSUMO">
			<xsl:text>Si</xsl:text>
		</xsl:if>

		<xsl:if test="ERROR">
			<xsl:text>ERROR</xsl:text>
		</xsl:if>
		<xsl:text>"}</xsl:text>
</xsl:template>
</xsl:stylesheet>