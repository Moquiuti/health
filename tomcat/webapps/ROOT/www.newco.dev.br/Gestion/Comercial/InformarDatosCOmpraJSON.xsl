<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/InformaDatosCompra">

	<xsl:text>{"OfertaActualizada":</xsl:text>
		<xsl:text>{"IDOferta":"</xsl:text>
			<xsl:value-of select="COMPRACENTRO/ID"/>
		<xsl:text>","TodosInformados":"</xsl:text>
			<xsl:choose>
			<xsl:when test="COMPRACENTRO/TODOS_INFORMADOS">
				<xsl:text>Si</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>No</xsl:text>
			</xsl:otherwise>
			</xsl:choose>
		<xsl:text>"}</xsl:text>
	<xsl:text>}</xsl:text>
</xsl:template>
</xsl:stylesheet>
