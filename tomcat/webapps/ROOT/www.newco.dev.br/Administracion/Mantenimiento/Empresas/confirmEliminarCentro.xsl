<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:param name="lang" select="@lang"/>
 
<xsl:template match="/confirmEliminarCentro">
	
    <xsl:text>{"confirmEliminarCentro":</xsl:text>
		<xsl:text>{"estado":"</xsl:text>
		<xsl:if test="CENTRO_PEDIDOS">
			<xsl:text>S</xsl:text>
		</xsl:if>
		<xsl:if test="CENTRO_SIN_PEDIDOS">
			<xsl:text>N</xsl:text>
		</xsl:if>
		<xsl:text>"}</xsl:text>
	<xsl:text>}</xsl:text>
    
</xsl:template>
</xsl:stylesheet>
