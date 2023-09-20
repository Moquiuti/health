<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Recupera lista de centros de una licitacion
	Ultima revision: ET 27jun22
+-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/Centros">
	<xsl:text>{"ListaCentros":[</xsl:text>
		<xsl:for-each select="CENTROSLICITACION/CENTRO">
			<xsl:text>{"IDCentro":"</xsl:text>
				<xsl:value-of select="CEN_ID"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Licc_ID":"</xsl:text>
				<xsl:value-of select="LICC_ID"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"NombreCorto":"</xsl:text>
				<xsl:value-of select="NOMBRECORTO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Nombre":"</xsl:text>
				<xsl:value-of select="NOMBRE"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Estado":"</xsl:text>
				<xsl:value-of select="ESTADOCOMPRA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"RefPropias":"</xsl:text>
				<xsl:value-of select="REFERENCIASPROPIAS"/>
			<xsl:text>"}</xsl:text>
			<xsl:if test="position() != last()">
				<xsl:text>,</xsl:text>
			</xsl:if>
		</xsl:for-each>
	<xsl:text>]}</xsl:text>
</xsl:template>
</xsl:stylesheet>
