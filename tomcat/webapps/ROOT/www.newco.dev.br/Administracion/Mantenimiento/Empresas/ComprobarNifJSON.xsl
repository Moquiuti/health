<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Fuerza el cambio de clave para un usuario
	Ultima revision ET 18oct21 10:35
+-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/ComprobarNif">

	<xsl:text>{"Estado":"</xsl:text>
	<xsl:if test="EXISTE">
		<xsl:text>EXISTE</xsl:text>
	</xsl:if>
	<xsl:if test="NO_EXISTE">
		<xsl:text>NO_EXISTE</xsl:text>
	</xsl:if>
	<xsl:text>"}</xsl:text>
</xsl:template>
</xsl:stylesheet>
