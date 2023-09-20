<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/Observaciones">
	<xsl:text>{"Observaciones":"</xsl:text>
		<xsl:value-of select="CEN_LIC_COMENTARIOSPEDIDO"/>
	<xsl:text>"}</xsl:text>
</xsl:template>
</xsl:stylesheet>
