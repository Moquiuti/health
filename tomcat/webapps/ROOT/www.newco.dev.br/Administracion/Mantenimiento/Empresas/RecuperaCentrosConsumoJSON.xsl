<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Recupera lista de centros de coste de un centro
	Ultima revision: ET 5ago22
+-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/CentrosConsumo">
	<xsl:text>{"CentrosConsumo":[</xsl:text>
		<xsl:for-each select="CENTROSCONSUMO/field/dropDownList/listElem">
			<xsl:text>{"ID":"</xsl:text>
				<xsl:value-of select="ID"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Nombre":"</xsl:text>
				<xsl:value-of select="listItem"/>
			<xsl:text>"}</xsl:text>
			<xsl:if test="position() != last()">
				<xsl:text>,</xsl:text>
			</xsl:if>
		</xsl:for-each>
	<xsl:text>]}</xsl:text>
</xsl:template>
</xsl:stylesheet>
