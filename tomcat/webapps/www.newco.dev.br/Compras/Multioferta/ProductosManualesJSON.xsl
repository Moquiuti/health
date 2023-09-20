<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/ProductosManuales">

		<xsl:text>{"ProductosManuales":[</xsl:text>
			<xsl:for-each select="PRODUCTOSMANUALES/PRODUCTOMANUAL">
				<xsl:text>{"PMId":"</xsl:text>
					<xsl:value-of select="MOP_ID"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"PMRefProv":"</xsl:text>
					<xsl:value-of select="MOP_REFPROVEEDOR"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"PMDescripcion":"</xsl:text>
					<xsl:value-of select="MOP_DESCRIPCION"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"PMUnBasica":"</xsl:text>
					<xsl:value-of select="MOP_UNIDADBASICA"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"PMCantidad":"</xsl:text>
					<xsl:value-of select="MOP_CANTIDAD"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"PMIva":"</xsl:text>
					<xsl:value-of select="MOP_PCTGE_IVA"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"PMPrecio":"</xsl:text>
					<xsl:value-of select="MOP_PRECIOUNITARIO"/>
				<xsl:text>"}</xsl:text>
				<xsl:if test="position() != last()">
					<xsl:text>,</xsl:text>
				</xsl:if>
			</xsl:for-each>
		<xsl:text>]}</xsl:text>
</xsl:template>
</xsl:stylesheet>