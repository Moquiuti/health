<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Ultima revision: ET 24mar20 09:09
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/EIS_XML">
	<xsl:variable name="quot">"</xsl:variable>
	<xsl:variable name="apos">'</xsl:variable>
    
	<xsl:text>{"DatosEIS":[</xsl:text>

		<xsl:text>{"NombreCuadro":"</xsl:text><xsl:value-of select="EISANALISIS/VALORES/CUADRO"/>
			<xsl:text>","ListaMeses":[</xsl:text>
			<xsl:for-each select = "EISANALISIS/DATOSEIS/LISTAMESES/MES">
				<xsl:text>{"posicion":"</xsl:text>
				<xsl:value-of select="POS"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"mes":"</xsl:text>
				<xsl:value-of select="MES"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"nombre":"</xsl:text>
				<xsl:value-of select="NOMBRE"/>
				<xsl:text>"}</xsl:text>
					<xsl:if test="position() != last()">
						<xsl:text>,</xsl:text>
					</xsl:if>
			</xsl:for-each>
		<xsl:text>]},</xsl:text>

		<xsl:text>{"Indicador":[</xsl:text>
			<xsl:text>{"nombre":"</xsl:text>
			<xsl:value-of select="EISANALISIS/DATOSEIS/CUADRODEMANDO/INDICADOR/NOMBREINDICADOR"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ConvPorcent":"</xsl:text>
				<xsl:choose>
					<xsl:when test="EISANALISIS/CONVERTIR_PORCENTAJE">S</xsl:when>
					<xsl:otherwise>N</xsl:otherwise>
				</xsl:choose>
			<xsl:text>",</xsl:text>
			<xsl:text>"FilaTotales":"</xsl:text>
				<xsl:choose>
					<xsl:when test="EISANALISIS/UTILIZAR_FILA_TOTALES_XML">S</xsl:when>
					<xsl:otherwise>N</xsl:otherwise>
				</xsl:choose>
			<xsl:text>",</xsl:text>
			<xsl:text>"id":"</xsl:text>
			<xsl:value-of select="EISANALISIS/DATOSEIS/CUADRODEMANDO/INDICADOR/IDINDICADOR"/>
			<xsl:text>"}</xsl:text>
		<xsl:text>]},</xsl:text>

		<xsl:text>{"Filas":[</xsl:text>
			<xsl:for-each select = "EISANALISIS/DATOSEIS/CUADRODEMANDO/INDICADOR/GRUPO">
				<xsl:text>{"NombreGrupo":"</xsl:text>
				<xsl:value-of select="translate(NOMBREGRUPO,$quot,$apos)" disable-output-escaping="yes"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"IDGrupo":"</xsl:text>
				<xsl:value-of select="IDGRUPO" disable-output-escaping="yes"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"Linea":"</xsl:text>
				<xsl:value-of select="LINEA"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"Columnas":[</xsl:text>
					<xsl:for-each select = "ROW">
						<xsl:text>{"Columna":"</xsl:text>
						<xsl:value-of select="COLUMNA"/>
						<xsl:text>",</xsl:text>
						<xsl:text>"Anno":"</xsl:text>
						<xsl:value-of select="ANNO"/>
						<xsl:text>",</xsl:text>
						<xsl:text>"Mes":"</xsl:text>
						<xsl:value-of select="MES"/>
						<xsl:text>",</xsl:text>
						<xsl:text>"Color":"</xsl:text>
							<xsl:choose>
							<xsl:when test="VERDE">VERDE</xsl:when>
							<xsl:when test="ROJO">ROJO</xsl:when>
							<xsl:otherwise>NEGRO</xsl:otherwise>
                                                        </xsl:choose>
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
		<xsl:value-of select="EISANALISIS/DATOSEIS/CUADRODEMANDO/INDICADOR/MAXLINEAS"/>
		<xsl:text>"}</xsl:text>
	<xsl:text>]}</xsl:text>

</xsl:template>
</xsl:stylesheet>
