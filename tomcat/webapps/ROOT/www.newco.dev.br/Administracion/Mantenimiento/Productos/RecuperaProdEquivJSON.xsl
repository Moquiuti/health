<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/ProductosEquivalentes">

	<xsl:text>{"US_ID":"</xsl:text>
		<xsl:value-of select="US_ID"/>
	<xsl:text>","IDPRODESTANDAR":"</xsl:text>
		<xsl:value-of select="IDPRODUCTOESTANDAR"/>
	<xsl:text>","length":"</xsl:text>
		<xsl:value-of select="count(EQUIVALENTES_MANUALES/PRODUCTO)"/>        
	<xsl:text>","ListaProdEquiv":[</xsl:text>
		<xsl:for-each select="EQUIVALENTES_MANUALES/PRODUCTO">
			<xsl:text>{"ID":"</xsl:text>
				<xsl:value-of select="PRO_EQ_ID"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"IDPRODESTANDAR":"</xsl:text>
				<xsl:value-of select="PRO_EQ_IDPRODUCTO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"IDPROVEEDOR":"</xsl:text>
				<xsl:value-of select="PRO_EQ_IDPROVEEDOR"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"PROVEEDOR":"</xsl:text>
				<xsl:value-of select="PRO_EQ_PROVEEDOR"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Referencia":"</xsl:text>
				<xsl:value-of select="PRO_EQ_REFERENCIA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Nombre":"</xsl:text>
				<xsl:value-of select="PRO_EQ_NOMBRE"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Marca":"</xsl:text>
				<xsl:value-of select="PRO_EQ_MARCA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"IDFicha":"</xsl:text>
				<xsl:value-of select="PRO_EQ_IDFICHATECNICA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"IDEstadoEval":"</xsl:text>
				<xsl:value-of select="PRO_EQ_IDESTADOEVALUACION"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"EstadoEval":"</xsl:text>
				<xsl:value-of select="ESTADOEVALUACION"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Comentarios":"</xsl:text>
				<xsl:value-of select="PRO_EQ_COMENTARIOS"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"FichaTecnica":</xsl:text>
				<xsl:text>{"IDFICHA":"</xsl:text>
					<xsl:value-of select="FICHA_TECNICA/ID"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"NombreFicha":"</xsl:text>
					<xsl:value-of select="FICHA_TECNICA/NOMBRE"/>
				<xsl:text>",</xsl:text> 
				<xsl:text>"DescripcionFicha":"</xsl:text>
					<xsl:value-of select="FICHA_TECNICA/DESCRIPCION"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"URLFicha":"</xsl:text>
					<xsl:value-of select="FICHA_TECNICA/URL"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"Fecha":"</xsl:text>
					<xsl:value-of select="FICHA_TECNICA/FECHA"/>
				<xsl:text>"}</xsl:text>
			<xsl:text>}</xsl:text>                                
			<xsl:if test="position() != last()">
				<xsl:text>,</xsl:text>
			</xsl:if>
		</xsl:for-each>
	<xsl:text>]}</xsl:text>
</xsl:template>
</xsl:stylesheet>