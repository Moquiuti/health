<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Guarda los datos de seguimiento para una linea de multioferta
	Ultima revision: ET 5jul21 15:00
+-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/GuardarSeguimiento">

	<xsl:text>{"SeguimientoActualizado":</xsl:text>
		<xsl:text>{"estado":"</xsl:text>
			<xsl:choose>
			<xsl:when test="OK">
				<xsl:text>OK</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>ERROR</xsl:text>
			</xsl:otherwise>
			</xsl:choose>
		<xsl:text>"}</xsl:text>
	<xsl:text>}</xsl:text>
</xsl:template>
</xsl:stylesheet>
