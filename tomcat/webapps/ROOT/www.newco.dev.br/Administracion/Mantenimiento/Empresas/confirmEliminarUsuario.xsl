<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:param name="lang" select="@lang"/>
 
<xsl:template match="/confirmEliminarUsuario">
	
    <xsl:text>{"confirmEliminarUsuario":</xsl:text>
		<xsl:text>{"estado":"</xsl:text>
		<xsl:if test="USUARIO_PEDIDOS">
			<xsl:text>S</xsl:text>
		</xsl:if>
		<xsl:if test="USUARIO_SIN_PEDIDOS">
			<xsl:text>N</xsl:text>
		</xsl:if>
		<xsl:text>"}</xsl:text>
	<xsl:text>}</xsl:text>
    
</xsl:template>
</xsl:stylesheet>
	