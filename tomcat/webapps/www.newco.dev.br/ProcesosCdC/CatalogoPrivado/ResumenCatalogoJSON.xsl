<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/ResumenCatalogo">

	<xsl:text>{"</xsl:text>
		<xsl:if test="RESUMEN/CATEGORIAS">
			<xsl:text>Categorias":{</xsl:text>
				<xsl:text>"ReferenciaMVM":"</xsl:text>
					<xsl:value-of select="RESUMEN/CATEGORIAS/REFERENCIA_MVM"/>
				<xsl:text>","ReferenciaCliente":"</xsl:text>
					<xsl:value-of select="RESUMEN/CATEGORIAS/REFERENCIA_CLIENTE"/>
				<xsl:text>","Total":"</xsl:text>
					<xsl:value-of select="RESUMEN/CATEGORIAS/TOTAL"/>
				<xsl:text>"},"</xsl:text>
		</xsl:if>

		<xsl:if test="RESUMEN/FAMILIAS">
			<xsl:text>Familias":{</xsl:text>
				<xsl:text>"ReferenciaMVM":"</xsl:text>
					<xsl:value-of select="RESUMEN/FAMILIAS/REFERENCIA_MVM"/>
				<xsl:text>","ReferenciaCliente":"</xsl:text>
					<xsl:value-of select="RESUMEN/FAMILIAS/REFERENCIA_CLIENTE"/>
				<xsl:text>","Total":"</xsl:text>
					<xsl:value-of select="RESUMEN/FAMILIAS/TOTAL"/>
				<xsl:text>"},"</xsl:text>
		</xsl:if>

		<xsl:if test="RESUMEN/SUBFAMILIAS">
			<xsl:text>Subfamilias":{</xsl:text>
				<xsl:text>"ReferenciaMVM":"</xsl:text>
					<xsl:value-of select="RESUMEN/SUBFAMILIAS/REFERENCIA_MVM"/>
				<xsl:text>","ReferenciaCliente":"</xsl:text>
					<xsl:value-of select="RESUMEN/SUBFAMILIAS/REFERENCIA_CLIENTE"/>
				<xsl:text>","Total":"</xsl:text>
					<xsl:value-of select="RESUMEN/SUBFAMILIAS/TOTAL"/>
				<xsl:text>"},"</xsl:text>
		</xsl:if>

		<xsl:if test="RESUMEN/GRUPOS">
			<xsl:text>Grupos":{</xsl:text>
				<xsl:text>"ReferenciaMVM":"</xsl:text>
					<xsl:value-of select="RESUMEN/GRUPOS/REFERENCIA_MVM"/>
				<xsl:text>","ReferenciaCliente":"</xsl:text>
					<xsl:value-of select="RESUMEN/GRUPOS/REFERENCIA_CLIENTE"/>
				<xsl:text>","Total":"</xsl:text>
					<xsl:value-of select="RESUMEN/GRUPOS/TOTAL"/>
				<xsl:text>"},"</xsl:text>
		</xsl:if>

		<xsl:if test="RESUMEN/PRODUCTOSESTANDAR">
			<xsl:text>ProductosEstandar":{</xsl:text>
				<xsl:text>"ReferenciaMVM":"</xsl:text>
					<xsl:value-of select="RESUMEN/PRODUCTOSESTANDAR/REFERENCIA_MVM"/>
				<xsl:text>","ReferenciaCliente":"</xsl:text>
					<xsl:value-of select="RESUMEN/PRODUCTOSESTANDAR/REFERENCIA_CLIENTE"/>
				<xsl:text>","Total":"</xsl:text>
					<xsl:value-of select="RESUMEN/PRODUCTOSESTANDAR/TOTAL"/>
				<xsl:text>"}</xsl:text>
		</xsl:if>
	<xsl:text>}</xsl:text>

</xsl:template>
</xsl:stylesheet>