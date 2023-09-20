<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/DescripcionesAnteriores">

	<xsl:text>{"DescripcionesAnteriores":</xsl:text>
		<xsl:text>{"length":"</xsl:text>
			<xsl:value-of select="count(DESCRIPCIONESANTIGUAS/DESCRIPCION)"/>
		<xsl:text>",</xsl:text>
		<xsl:text>"ListaDescripciones":[</xsl:text>
		<xsl:for-each select="DESCRIPCIONESANTIGUAS/DESCRIPCION">
			<xsl:text>{"Nombre":"</xsl:text>
				<xsl:value-of select="TEXTO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"NombreDump":"</xsl:text>
				<xsl:value-of select="ID"/>
			<xsl:text>",</xsl:text>                        
			<xsl:text>"Num":"</xsl:text>
				<xsl:value-of select="@num"/>
			<xsl:text>"}</xsl:text>
			<xsl:if test="position() != last()">
				<xsl:text>,</xsl:text>
			</xsl:if>
		</xsl:for-each>
		<xsl:text>]}</xsl:text>
	<xsl:text>}</xsl:text>

</xsl:template>
</xsl:stylesheet>