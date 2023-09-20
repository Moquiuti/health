<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/EIS_ANUAL_XML">
	<xsl:variable name="quot">"</xsl:variable>
	<xsl:variable name="apos">'</xsl:variable>
    
	<xsl:text>{"DatosEIS":[</xsl:text>

		<xsl:text>{"AnnoInicio":"</xsl:text>
			<xsl:value-of select="EIS_ANUAL/ANYO_INICIO"/>
		<xsl:text>",</xsl:text>
		<xsl:text>"AnnoFinal":"</xsl:text>
			<xsl:value-of select="EIS_ANUAL/ANYO_FINAL"/>
		<xsl:text>"},</xsl:text>

		<xsl:text>{"Indicador":</xsl:text>
			<xsl:text>{"nombre":"</xsl:text>
				<xsl:value-of select="EIS_ANUAL/INDICADOR"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"idCuadro":"</xsl:text>
				<xsl:value-of select="EIS_ANUAL/IDCUADRO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"id":"</xsl:text>
				<xsl:value-of select="EIS_ANUAL/IDINDICADOR"/>
			<xsl:text>"}</xsl:text>
		<xsl:text>},</xsl:text>

		<xsl:text>{"Filas":[</xsl:text>
			<xsl:for-each select = "EIS_ANUAL/FILA">
				<xsl:text>{"NombreGrupo":"</xsl:text>
				<xsl:value-of select="translate(NOMBRE,$quot,$apos)" disable-output-escaping="yes"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"IDGrupo":"</xsl:text>
				<xsl:value-of select="ID" disable-output-escaping="yes"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"Linea":"</xsl:text>
				<xsl:value-of select="POS"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"Columnas":[</xsl:text>
					<xsl:for-each select = "COLUMNA">
						<xsl:text>{"Columna":"</xsl:text>
						<xsl:value-of select="POS"/>
						<xsl:text>",</xsl:text>
						<xsl:text>"Anno":"</xsl:text>
						<xsl:value-of select="ANNO"/>
						<xsl:text>",</xsl:text>
						<xsl:text>"Total":"</xsl:text>
						<xsl:value-of select="TOTAL"/>
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
		<xsl:text>]},</xsl:text>
		<xsl:text>{"MaxLineas":"</xsl:text>
		<xsl:value-of select="count(EIS_ANUAL/FILA)"/>
		<xsl:text>"}</xsl:text>
	<xsl:text>]}</xsl:text>

</xsl:template>
</xsl:stylesheet>