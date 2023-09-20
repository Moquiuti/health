<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Login. Devuelve codigo de sesion. Para solicitar mediante AJAX
	Ultima revision: ET 5ene22 18:12
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<!--<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>-->
<xsl:output media-type="json" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/Login">
	<xsl:text>{"sesion":</xsl:text><xsl:choose><xsl:when test="SES_ID">"<xsl:value-of select="SES_ID"/>"</xsl:when><xsl:otherwise>"<xsl:text>ERROR</xsl:text>"</xsl:otherwise></xsl:choose><xsl:text>}</xsl:text>
</xsl:template>
</xsl:stylesheet>
