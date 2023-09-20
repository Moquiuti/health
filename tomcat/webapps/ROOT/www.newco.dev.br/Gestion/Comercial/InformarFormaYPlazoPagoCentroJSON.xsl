<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/InformaDatosPagoProv">

	<xsl:text>{"DatosActualizados":</xsl:text>
		<xsl:text>{"IDLicitacion":"</xsl:text>
			<xsl:value-of select="FORMAYPLAZOPAGO/LIC_ID"/>
		<xsl:text>","IDCentroLic":"</xsl:text>
			<xsl:value-of select="FORMAYPLAZOPAGO/LIC_AGR_IDCENTROLIC"/>
		<xsl:text>","IDProveedorLic":"</xsl:text>
			<xsl:value-of select="FORMAYPLAZOPAGO/LIC_AGR_IDPROVEEDORLIC"/>
		<xsl:text>","Resultado":"</xsl:text>
			<xsl:value-of select="FORMAYPLAZOPAGO/@msg"/>
		<xsl:text>"}</xsl:text>
	<xsl:text>}</xsl:text>
</xsl:template>
</xsl:stylesheet>
