<?xml version="1.0" encoding="iso-8859-1"?>
<!-- 
	Recupera los datos de una entrada de seguimiento
	Ultima revision: ET 4jun19 17:48
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/Licitacion">
	<xsl:text>{"Licitacion":</xsl:text>
			<xsl:choose>
			<xsl:when test="OK">{"Estado":"OK"}</xsl:when>
			<xsl:otherwise>{"Estado":"ERROR"}</xsl:otherwise>
			</xsl:choose>
	<xsl:text>}</xsl:text>
</xsl:template>
</xsl:stylesheet>
