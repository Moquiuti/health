<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/FirmarComunicado">

	<xsl:text>{"Estado":"</xsl:text>
			<xsl:choose>
			<xsl:when test="OK">
				<xsl:text>OK</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>ERROR</xsl:text>
			</xsl:otherwise>
			</xsl:choose>
	<xsl:text>"}</xsl:text>
</xsl:template>
</xsl:stylesheet>
