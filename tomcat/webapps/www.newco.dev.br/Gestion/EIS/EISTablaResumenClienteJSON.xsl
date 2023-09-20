<?xml version="1.0" encoding="iso-8859-1" ?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1" 
doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" 
doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes" omit-xml-declaration="yes" /> 
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/TablaResumenCliente">

	<xsl:text>{"Cabecera":[</xsl:text>
		<xsl:for-each select="RESUMENES_MENSUALES/CABECERA/COLUMNA">
			<xsl:text>{"Orden":"</xsl:text>
				<xsl:value-of select="ORDEN"/>
			<xsl:text>","Anyo":"</xsl:text>
				<xsl:value-of select="ANYO"/>
			<xsl:text>","Mes":"</xsl:text>
				<xsl:value-of select="MES"/>
			<xsl:text>"}</xsl:text>
		<xsl:if test="position() != last()">
			<xsl:text>,</xsl:text>
		</xsl:if>
		</xsl:for-each>
	<xsl:text>],</xsl:text>

	<xsl:text>"Indicadores":[</xsl:text>
		<xsl:for-each select="RESUMENES_MENSUALES/RESUMEN_MENSUAL">
			<xsl:text>{"Nombre":"</xsl:text>
				<xsl:value-of select="./@Nombre"/>
			<xsl:text>","Columnas":[</xsl:text>

				<xsl:for-each select="COLUMNA">
					<xsl:text>{"Orden":"</xsl:text>
						<xsl:value-of select="ORDEN"/>
					<xsl:text>","Anyo":"</xsl:text>
						<xsl:value-of select="ANYO"/>
					<xsl:text>","Mes":"</xsl:text>
						<xsl:value-of select="MES"/>
					<xsl:text>","ValorSinFormato":"</xsl:text>
						<xsl:value-of select="VALOR_SINFORMATO"/>
					<xsl:text>","Valor":"</xsl:text>
						<xsl:value-of select="VALOR"/>
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