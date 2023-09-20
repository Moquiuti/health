<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/TipoIVA">

		<xsl:text>{"estado":"</xsl:text>
			<xsl:choose>
			<xsl:when test="ERROR">
				<xsl:text>ERROR</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>OK</xsl:text>
				<xsl:text>","TipoIVA":"</xsl:text>
					<xsl:value-of select="TIPOIVA"/>
			</xsl:otherwise>
			</xsl:choose>
		<xsl:text>"}</xsl:text>
</xsl:template>
</xsl:stylesheet>
