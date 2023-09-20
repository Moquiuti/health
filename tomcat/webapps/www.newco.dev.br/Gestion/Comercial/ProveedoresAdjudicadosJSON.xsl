<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Recupera los proveedores adjudicados para un producto de una licitacion
	Ultima revision: ET 13abr21 17:18
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/CompraPorCentro">
	<xsl:text>{"Centros":[</xsl:text>
	<xsl:for-each select="COMPRAPORCENTRO/PRODUCTO/CENTRO">
		<xsl:text>{"IDCentro":"</xsl:text>
			<xsl:value-of select="CEN_ID"/>
		<xsl:text>","Centro":"</xsl:text>
			<xsl:value-of select="NOMBRE"/>
		<xsl:text>","Marcas":"</xsl:text>
			<xsl:value-of select="LIC_CC_MARCASACEPTABLES"/>
		<xsl:text>","Cantidad":"</xsl:text>
			<xsl:value-of select="LIC_CC_CANTIDAD"/>
		<xsl:text>","CantidadSF":"</xsl:text>
		<xsl:value-of select="CANTIDAD_SINFORMATO"/>
		<xsl:text>","Proveedores":[</xsl:text>
			<xsl:for-each select="PROVEEDORES/PROVEEDOR">
				<xsl:text>{"IDProveedorLic":"</xsl:text>
					<xsl:value-of select="LIC_PROV_ID"/>
				<xsl:text>","IDOfertaLic":"</xsl:text>
					<xsl:value-of select="LIC_OFE_ID"/>
				<xsl:text>","UnidadesPorLote":"</xsl:text>
					<xsl:value-of select="LIC_OFE_UNIDADESPORLOTE"/>
				<xsl:text>","IDProveedor":"</xsl:text>
					<xsl:value-of select="IDPROVEEDOR"/>
				<xsl:text>","Proveedor":"</xsl:text>
					<xsl:value-of select="PROVEEDOR"/>
				<xsl:text>","Cantidad":"</xsl:text>
					<xsl:value-of select="CANTIDAD"/>
				<xsl:text>","CantidadSF":"</xsl:text>
					<xsl:value-of select="CANTIDAD_SINFORMATO"/>
				<xsl:text>"}</xsl:text>
				<xsl:if test="position() != last()">
					<xsl:text>,</xsl:text>
				</xsl:if>
			</xsl:for-each>
		<xsl:text>]}</xsl:text>
			<xsl:if test="position() != last()">
				<xsl:text>,</xsl:text>
			</xsl:if>
		</xsl:for-each>
	<xsl:text>]}</xsl:text>
</xsl:template>
</xsl:stylesheet>
