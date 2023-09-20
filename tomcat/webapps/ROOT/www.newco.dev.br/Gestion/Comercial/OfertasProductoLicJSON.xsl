<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/OfertasProductoLic">
	<xsl:text>{"OfertasProductoLic":</xsl:text>
		<xsl:text>{"posicion":"</xsl:text>
		<xsl:value-of select="PRODUCTOLICITACION/POSICION"/>
		<xsl:text>"}</xsl:text>
	<xsl:text>}</xsl:text>
</xsl:template>
</xsl:stylesheet>
