<?xml version="1.0" encoding="iso-8859-1" ?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1" 
doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" 
doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes" omit-xml-declaration="yes" /> 
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/ActualizarComentarios">
	<xsl:text>{"Estado":"</xsl:text>
	<xsl:if test="OK">
		<xsl:text>OK</xsl:text>
	</xsl:if>
	<xsl:if test="ERROR">
		<xsl:text>ERROR</xsl:text>
	</xsl:if>
	<xsl:text>"}</xsl:text>
</xsl:template>
</xsl:stylesheet>
