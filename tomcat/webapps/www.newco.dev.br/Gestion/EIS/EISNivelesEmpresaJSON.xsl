<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/NivelesEmpresa">


	<xsl:text>{"NivelesEmpresa":</xsl:text>
		<xsl:text>{"IDEmpresa":"</xsl:text>
		<xsl:value-of select="EMPRESA/IDEMPRESA"/>
		<xsl:text>",</xsl:text>
		<xsl:text>"rol":"</xsl:text>
		<xsl:value-of select="EMPRESA/ROL"/>
		<xsl:text>",</xsl:text>
		<xsl:text>"IDPais":"</xsl:text>
		<xsl:value-of select="EMPRESA/IDPAIS"/>
		<xsl:text>",</xsl:text>
		<xsl:text>"MostrarCategorias":"</xsl:text>
		<xsl:value-of select="EMPRESA/MOSTRARCATEGORIAS"/>
		<xsl:text>",</xsl:text>
		<xsl:text>"MostrarGrupos":"</xsl:text>
		<xsl:value-of select="EMPRESA/MOSTRARGRUPOS"/>
		<xsl:text>"}</xsl:text>
	<xsl:text>}</xsl:text>
</xsl:template>
</xsl:stylesheet>