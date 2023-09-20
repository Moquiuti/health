<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	COmprueba si la sesion esta activa. Se lanza desde la Cabecera cada 15 minutos
	ultima revision ET 03set21 12:30
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/CompruebaSesion">

	<xsl:text>{"Sesion":"</xsl:text>
	<xsl:choose><xsl:when test="/CompruebaSesion/OK">OK</xsl:when><xsl:otherwise>SIN_SESION</xsl:otherwise></xsl:choose>
	<xsl:text>"}</xsl:text>
</xsl:template>

</xsl:stylesheet>
