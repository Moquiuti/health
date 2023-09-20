<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Lista de documentos de una empresa, se devuelve en formato JSON
 	Ultima revision: ET 13set21 16:20
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/Docs">
	<xsl:text>{"Categorias":[</xsl:text>
	<xsl:for-each select="EMPRESA/DOCUMENTOS">
		{"Nombre":"<xsl:value-of select="NOMBRE_CORTO"/>",
		"Tipo":"<xsl:value-of select="TIPO"/>",
		"Documentos":[
		<xsl:for-each select="DOCUMENTO">
			<xsl:text>{"Cont":"</xsl:text>
				<xsl:value-of select="CONTADOR"/>
			<xsl:text>","ID":"</xsl:text>
				<xsl:value-of select="ID"/>
			<xsl:text>","Nombre":"</xsl:text>
				<xsl:value-of select="NOMBRE"/>
			<xsl:text>","Url":"</xsl:text>
				<xsl:value-of select="URL"/>
			<xsl:text>","Tipo":"</xsl:text>
				<xsl:value-of select="TIPO"/>
			<xsl:text>","NombreTipo":"</xsl:text>
				<xsl:value-of select="NOMBRETIPO"/>
			<xsl:text>","NifEmpresa":"</xsl:text>
				<xsl:value-of select="EMP_NIF"/>
			<xsl:text>","Empresa":"</xsl:text>
				<xsl:value-of select="EMPRESA"/>
			<xsl:text>","NifCentro":"</xsl:text>
				<xsl:value-of select="CEN_NIF"/>
			<xsl:text>","Centro":"</xsl:text>
				<xsl:value-of select="CENTRO"/>
			<xsl:text>","Usuario":"</xsl:text>
				<xsl:value-of select="USUARIO"/>
			<xsl:text>","FechaAlta":"</xsl:text>
				<xsl:value-of select="FECHA"/>
			<xsl:text>","FechaCad":"</xsl:text>
				<xsl:value-of select="FECHACADUCIDAD"/>
			<xsl:text>","IDEmpresa":"</xsl:text>
				<xsl:value-of select="DOC_IDPROVEEDOR"/>
			<xsl:text>","CentroOEmpresa":"</xsl:text>
				<xsl:choose><xsl:when test="CENTRO!=''"><xsl:value-of select="CENTRO"/></xsl:when><xsl:otherwise><xsl:value-of select="EMPRESA"/></xsl:otherwise></xsl:choose>
			<xsl:text>","Caducado":"</xsl:text>
				<xsl:choose><xsl:when test="CADUCADO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>
			<xsl:text>","Color":"</xsl:text>
				<xsl:value-of select="COLOR"/>
			<xsl:text>","UsuarioRev":"</xsl:text>
				<xsl:value-of select="USUARIO_REVISION"/>
			<xsl:text>","FechaRev":"</xsl:text>
				<xsl:value-of select="FECHA_REVISION"/>
			<xsl:text>","FechaUltLic":"</xsl:text>
				<xsl:value-of select="FECHAULTLICITACION"/>
			<xsl:text>","FechaUltPed":"</xsl:text>
				<xsl:value-of select="FECHAULTPEDIDO"/>
			<xsl:text>","Comercial_Nombre":"</xsl:text>
				<xsl:value-of select="COMERCIAL_POR_DEFECTO/NOMBRE"/>
			<xsl:text>","Comercial_Mail":"</xsl:text>
				<xsl:value-of select="COMERCIAL_POR_DEFECTO/US_EMAIL"/>
			<xsl:text>","Comercial_Telf":"</xsl:text>
				<xsl:value-of select="COMERCIAL_POR_DEFECTO/TELEFONO"/>
			<xsl:text>","Comercial_Prov":"</xsl:text>
				<xsl:value-of select="COMERCIAL_POR_DEFECTO/PROVINCIA"/>
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
