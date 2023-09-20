<?xml version="1.0" encoding="iso-8859-1" ?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1" 
doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" 
doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes" omit-xml-declaration="yes" /> 
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/DatosProducto">

		<xsl:text>{"DatosProducto":</xsl:text>
			
				<xsl:text>{"REF":"</xsl:text>
					<xsl:value-of select="PRODUCTO/REFERENCIA"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"PRO_ID":"</xsl:text>
					<xsl:value-of select="PRODUCTO/PRO_ID"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"PRO_NOMBRE":"</xsl:text>
					<xsl:value-of select="PRODUCTO/PRO_NOMBRE"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"REF_PRIVADA":"</xsl:text>
					<xsl:value-of select="PRODUCTO/REF_PRIVADA"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"REF_CLIENTE":"</xsl:text>
					<xsl:value-of select="PRODUCTO/CP_PRO_REFCLIENTE"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"UN_BASICA":"</xsl:text>
					<xsl:value-of select="PRODUCTO/UNIDADBASICA"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"UN_LOTE":"</xsl:text>
					<xsl:value-of select="PRODUCTO/UNIDADESPORLOTE"/>
                <xsl:text>",</xsl:text>
				<xsl:text>"TARIFA":"</xsl:text>
					<xsl:value-of select="PRODUCTO/TARIFA"/>
				<xsl:text>"}</xsl:text>
				<xsl:if test="position() != last()">
					<xsl:text>,</xsl:text>
				</xsl:if>
		<xsl:text>}</xsl:text>
</xsl:template>
</xsl:stylesheet>
