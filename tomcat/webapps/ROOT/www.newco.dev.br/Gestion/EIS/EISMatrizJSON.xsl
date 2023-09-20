<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/EIS_XML">
	<xsl:variable name="quot">"</xsl:variable>
	<xsl:variable name="apos">'</xsl:variable>
    
	<xsl:text>{"DatosEISMatriz":[</xsl:text>

		<xsl:text>{"ListaCabeceraH":[</xsl:text>
			<xsl:for-each select = "RESULTADOS/CENTROS/CENTRO">
				<xsl:text>{"id":"</xsl:text>
				<xsl:value-of select="ID"/>
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
			<xsl:text>{"id":"</xsl:text>
				<xsl:value-of select="RESULTADOS/VALORES/IDINDICADOR"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"nombre":"</xsl:text>
				<xsl:value-of select="RESULTADOS/VALORES/INDICADOR"/>
			<xsl:text>"}</xsl:text>
		<xsl:text>]},</xsl:text>

		<xsl:text>{"Filas":[</xsl:text>
			<xsl:for-each select = "RESULTADOS/FILA">
				<xsl:text>{"NombreGrupo":"</xsl:text>
				<xsl:value-of select="translate(NOMBRE,$quot,$apos)" disable-output-escaping="yes"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"IDGrupo":"</xsl:text>
				<xsl:value-of select="ID"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"Linea":"</xsl:text>
				<xsl:value-of select="@Actual"/>
				<xsl:text>",</xsl:text>
<!--
				<xsl:text>"Linea":"</xsl:text>
				<xsl:value-of select="LINEA"/>
				<xsl:text>",</xsl:text>
-->
				<xsl:text>"Columnas":[</xsl:text>
					<xsl:for-each select = "COLUMNA">
						<xsl:text>{"IDColumna":"</xsl:text>
						<xsl:value-of select="IDCOLUMNA"/>
						<xsl:text>",</xsl:text>
						<xsl:text>"IDFila":"</xsl:text>
						<xsl:value-of select="IDFILA"/>
						<xsl:text>",</xsl:text>
						<xsl:text>"Columna":"</xsl:text>
						<xsl:value-of select="@Actual"/>
						<xsl:text>",</xsl:text>
<!--
						<xsl:text>"Color":"</xsl:text>
							<xsl:choose>
							<xsl:when test="VERDE">VERDE</xsl:when>
							<xsl:when test="ROJO">ROJO</xsl:when>
							<xsl:otherwise>NEGRO</xsl:otherwise>
                                                        </xsl:choose>
						<xsl:text>",</xsl:text>
-->
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

		<xsl:text>{"filtrosComentario":"</xsl:text>
				<xsl:value-of select="RESULTADOS/VALORES/FILTROCOMENTARIOS"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Comentarios":[</xsl:text>
			<xsl:for-each select="RESULTADOS/COMENTARIOS_MATRIZ/COMENTARIO">
				<xsl:text>{"IDHor":"</xsl:text>
					<xsl:value-of select="EIS_MPC_IDHOR"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"IDVer":"</xsl:text>
					<xsl:value-of select="EIS_MPC_IDVER"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"Comentario":"</xsl:text>
					<xsl:value-of select="translate(COMENTARIO,$quot,$apos)" disable-output-escaping="yes"/>
<!--					<xsl:value-of select="COMENTARIO"/>-->
				<xsl:text>",</xsl:text>
				<xsl:text>"Color":"</xsl:text>
					<xsl:value-of select="COMENTARIO_COLOR"/>
				<xsl:text>"}</xsl:text>
				<xsl:if test="position() != last()">
					<xsl:text>,</xsl:text>
				</xsl:if>
			</xsl:for-each>
		<xsl:text>]},</xsl:text>
		<xsl:text>{"MaxLineas":"</xsl:text>
		<xsl:value-of select="count(RESULTADOS/FILA)"/>
		<xsl:text>"}</xsl:text>

	<xsl:text>]}</xsl:text>

</xsl:template>
</xsl:stylesheet>