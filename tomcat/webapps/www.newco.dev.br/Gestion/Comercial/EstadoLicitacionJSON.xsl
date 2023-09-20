<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/EstadoLic">

	<xsl:text>{"LicID":"</xsl:text>
		<xsl:value-of select="LICITACION/LIC_ID"/>
	<xsl:text>","IDEstado":"</xsl:text>
		<xsl:value-of select="LICITACION/LIC_IDESTADO"/>
	<xsl:text>","Estado":"</xsl:text>
		<xsl:value-of select="LICITACION/ESTADO"/>
	<xsl:text>"}</xsl:text>
</xsl:template>
</xsl:stylesheet>