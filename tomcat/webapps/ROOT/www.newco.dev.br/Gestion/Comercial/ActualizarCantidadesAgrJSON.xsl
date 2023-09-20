<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/CantidadesActualizadas">

	<xsl:text>{"CantidadesActualizadas":</xsl:text>
		<xsl:text>{"estado":"</xsl:text>
		<xsl:if test="OK">
			<xsl:text>OK",</xsl:text>
			<xsl:text>"resultados":"</xsl:text>
			<xsl:value-of select="OK"/>
		</xsl:if>
		<xsl:if test="ERROR">
			<xsl:text>ERROR</xsl:text>
		</xsl:if>
		<xsl:text>"}</xsl:text>
	<xsl:text>}</xsl:text>
</xsl:template>
</xsl:stylesheet>

<!--
http://www.newco.dev.br/Gestion/Comercial/ActualizarCantidades.xsql?LIC_ID=1281&LISTA_PRODUCTOS=9045|6#9042|24#9047|12#9041|250#9046|400&xml-stylesheet=none
-->