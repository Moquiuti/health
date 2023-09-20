<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/Usuarios">


	<xsl:text>{"ListaUsuarios":[</xsl:text>
		<xsl:for-each select="USUARIOSLICITACION/USUARIO">
			<xsl:text>{"ID":"</xsl:text>
				<xsl:value-of select="ID"/>
			<xsl:text>",</xsl:text> 
			<xsl:text>"IDUSUARIO_LIC":"</xsl:text>
				<xsl:value-of select="IDUSUARIO_LIC"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Nombre":"</xsl:text>
				<xsl:value-of select="NOMBRE"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"FechaAlta":"</xsl:text>
				<xsl:value-of select="LIC_USU_FECHAALTA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"FechaModificacion":"</xsl:text>
				<xsl:value-of select="LIC_USU_FECHAMODIFICACION"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Estado":"</xsl:text>
				<xsl:value-of select="ESTADOLICITACION"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"IDEstado":"</xsl:text>
				<xsl:value-of select="LIC_USU_IDESTADO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Comentarios":"</xsl:text>
				<xsl:value-of select="LIC_USU_COMENTARIOS"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Autor":"</xsl:text>
				<xsl:if test="AUTOR">S</xsl:if>
			<xsl:text>"}</xsl:text>
			<xsl:if test="position() != last()">
				<xsl:text>,</xsl:text>
			</xsl:if>
		</xsl:for-each>
	<xsl:text>]}</xsl:text>
</xsl:template>
</xsl:stylesheet>