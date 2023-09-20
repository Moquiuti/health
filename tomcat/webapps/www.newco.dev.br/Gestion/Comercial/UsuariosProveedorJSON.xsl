<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/Usuarios">


	<xsl:text>{"ListaUsuarios":[</xsl:text>
		<xsl:for-each select = "USUARIOS/USUARIO">
			<xsl:text>{"nombre":"</xsl:text>
			<xsl:value-of select="NOMBRE"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"id":"</xsl:text>
			<xsl:value-of select="ID"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"centro":"</xsl:text>
			<xsl:value-of select="CENTRO"/>
			<xsl:text>"}</xsl:text>
				<xsl:if test="position() != last()">
					<xsl:text>,</xsl:text>
				</xsl:if>
		</xsl:for-each>
	<xsl:text>]}</xsl:text>
</xsl:template>
</xsl:stylesheet>
