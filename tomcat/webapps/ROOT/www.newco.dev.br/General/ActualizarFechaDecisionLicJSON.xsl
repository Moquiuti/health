<?xml version="1.0" encoding="iso-8859-1"?>
<!-- 
	Recupera los datos de una entrada de seguimiento
	Ultima revision: ET 4jun19 17:48
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/Seguimiento">

	<xsl:param name="pPattern">"</xsl:param>
	<xsl:param name="pReplacement">\"</xsl:param>

	<xsl:text>{"Seguimiento":</xsl:text>

		<xsl:choose>
		<xsl:when test="SEGUIMIENTO">

			<xsl:text>{"ID":"</xsl:text>
				<xsl:value-of select="SEGUIMIENTO/ID"/>
			<xsl:text>","IDAutor":"</xsl:text>
				<xsl:value-of select="SEGUIMIENTO/IDAUTOR"/>
			<xsl:text>","Autor":"</xsl:text>
				<xsl:value-of select="SEGUIMIENTO/AUTOR"/>
			<xsl:text>","IDCentroAutor":"</xsl:text>
				<xsl:value-of select="SEGUIMIENTO/IDCENTROAUTOR"/>
			<xsl:text>","CentroAutor":"</xsl:text>
				<xsl:value-of select="SEGUIMIENTO/CENTROAUTOR"/>
			<xsl:text>","Fecha":"</xsl:text>
				<xsl:value-of select="SEGUIMIENTO/FECHA"/>
			<xsl:text>","IDEmpresa":"</xsl:text>
				<xsl:value-of select="SEGUIMIENTO/IDEMPRESA"/>
			<xsl:text>","Empresa":"</xsl:text>
				<xsl:value-of select="SEGUIMIENTO/EMPRESA"/>
			<xsl:text>","IDCentro":"</xsl:text>
				<xsl:value-of select="SEGUIMIENTO/IDCENTRO"/>
			<xsl:text>","Centro":"</xsl:text>
				<xsl:value-of select="SEGUIMIENTO/CENTRO"/>
			<xsl:text>","Rol":"</xsl:text>
				<xsl:value-of select="SEGUIMIENTO/ROL"/>
			<xsl:text>","Titulo":"</xsl:text>
				<xsl:value-of select="SEGUIMIENTO/TITULO"/>
			<xsl:text>","Texto":"</xsl:text>
				<xsl:copy-of select="SEGUIMIENTO/TEXTO_JS/node()"/>
			<xsl:text>","IDEstado":"</xsl:text>
				<xsl:value-of select="SEGUIMIENTO/IDESTADO"/>
			<xsl:text>","Estado":"</xsl:text>
				<xsl:value-of select="SEGUIMIENTO/ESTADO"/>
			<xsl:text>","Visibilidad":"</xsl:text>
				<xsl:value-of select="SEGUIMIENTO/VISIBILIDAD"/>
			<xsl:text>","IDTipo":"</xsl:text>
				<xsl:value-of select="SEGUIMIENTO/IDTIPO"/>
			<xsl:text>","IDDocumento":"</xsl:text>
				<xsl:value-of select="SEGUIMIENTO/IDDOCUMENTO"/>
			<xsl:text>","NombreDoc":"</xsl:text>
				<xsl:value-of select="SEGUIMIENTO/DOC_SEGUIMIENTO/NOMBRE"/>
			<xsl:text>","URLDoc":"</xsl:text>
				<xsl:value-of select="SEGUIMIENTO/DOC_SEGUIMIENTO/URL"/>
			<xsl:text>","FechaDoc":"</xsl:text>
				<xsl:value-of select="SEGUIMIENTO/DOC_SEGUIMIENTO/FECHA"/>
			<!--
			<xsl:text>","Tipos":[</xsl:text>
			<xsl:for-each select="SEGUIMIENTO/TIPO/field/dropDownList/listElem">
				<xsl:text>{"ID":"</xsl:text>
					<xsl:value-of select="ID"/>
					<xsl:text>","Nombre":"</xsl:text>
						<xsl:value-of select="listItem"/>
					<xsl:text>"}</xsl:text>

					<xsl:if test="position() != last()">
						<xsl:text>,</xsl:text>
					</xsl:if>
			</xsl:for-each>

			<xsl:text>]}</xsl:text>
			-->
			<xsl:text>"}</xsl:text>

		</xsl:when>
		<xsl:otherwise>
			<xsl:text>{"Error":"SINDATOS"}</xsl:text>
		</xsl:otherwise>
		</xsl:choose>

	<xsl:text>}</xsl:text>
</xsl:template>
</xsl:stylesheet>
