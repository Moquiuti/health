<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/ProductosPorUsuario">

	<xsl:text>{"ProductosPorUsuario":[</xsl:text>
		
		<xsl:if test="PRODUCTOSENPLANTILLAS/VISIBLES">
			<xsl:text>{"prodVis":"</xsl:text><xsl:value-of select="PRODUCTOSENPLANTILLAS/VISIBLES"/><xsl:text>"},</xsl:text>
            <xsl:text>{"prodOcu":"</xsl:text><xsl:value-of select="PRODUCTOSENPLANTILLAS/OCULTAS"/><xsl:text>"}</xsl:text>
		</xsl:if>
		<xsl:if test="ERROR">
			<xsl:text>{"error":"ERROR</xsl:text><xsl:text>"}</xsl:text>
		</xsl:if>
        <xsl:if test="xsql-error">
			<xsl:text>{"error":"ERROR</xsl:text><xsl:text>"}</xsl:text>
		</xsl:if>
        
		
	<xsl:text>]}</xsl:text>
</xsl:template>
</xsl:stylesheet>

