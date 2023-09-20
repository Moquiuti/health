<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/Etiquetas">

	<xsl:text>{"Titulos":{</xsl:text>
		<xsl:text>"IDEmpresaUsu":"</xsl:text>
			<xsl:value-of select="ETIQUETAS/TITULOS/IDEMPRESAUSUARIO"/>
		<xsl:text>","IDRegistro":"</xsl:text>
			<xsl:value-of select="ETIQUETAS/TITULOS/IDREGISTRO"/>
		<xsl:text>","IDIdioma":"</xsl:text>
			<xsl:value-of select="ETIQUETAS/TITULOS/IDIDIOMA"/>
		<xsl:text>","NombreEmpresa":"</xsl:text>
			<xsl:value-of select="ETIQUETAS/TITULOS/EMPRESA"/>
		<xsl:text>","Rol":"</xsl:text>
			<xsl:value-of select="ETIQUETAS/TITULOS/ROL"/>
		<xsl:text>","IDTipo":"</xsl:text>
			<xsl:value-of select="ETIQUETAS/TITULOS/IDTIPO"/>
		<xsl:text>","Tipo":"</xsl:text>
			<xsl:value-of select="ETIQUETAS/TITULOS/TIPO"/>
		<xsl:text>","IDPais":"</xsl:text>
			<xsl:value-of select="ETIQUETAS/TITULOS/IDPAIS"/>
		<xsl:text>"},</xsl:text>
		<xsl:text>"Etiquetas":[</xsl:text>

			<xsl:for-each select="ETIQUETAS/ETIQUETA">

				<xsl:text>{"ID":"</xsl:text>
					<xsl:value-of select="ID"/>
				<xsl:text>","IDAutor":"</xsl:text>
					<xsl:value-of select="IDAUTOR"/>
				<xsl:text>","Autor":"</xsl:text>
					<xsl:value-of select="AUTOR"/>
				<xsl:text>","Fecha":"</xsl:text>
					<xsl:value-of select="FECHA"/>
				<xsl:text>","IDEmpresa":"</xsl:text>
					<xsl:value-of select="IDEMPRESA"/>
				<xsl:text>","Empresa":"</xsl:text>
					<xsl:value-of select="EMPRESA"/>
				<xsl:text>","IDCentro":"</xsl:text>
					<xsl:value-of select="IDCENTRO"/>
				<xsl:text>","Centro":"</xsl:text>
					<xsl:value-of select="CENTRO"/>
				<xsl:text>","Rol":"</xsl:text>
					<xsl:value-of select="ROL"/>
				<xsl:text>","Texto":"</xsl:text>
					<xsl:value-of select="TEXTO"/>
				<xsl:text>","IDEstado":"</xsl:text>
					<xsl:value-of select="ESTADO"/>
				<xsl:text>","Visibilidad":"</xsl:text>
					<xsl:value-of select="VISIBILIDAD"/>
				<xsl:text>"}</xsl:text>
				<xsl:if test="position() != last()">
					<xsl:text>,</xsl:text>
				</xsl:if>

			</xsl:for-each>
	<xsl:text>]}</xsl:text>

</xsl:template>
</xsl:stylesheet>
