<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
 
<xsl:template match="/confirmPROImageSave">
[
	<xsl:choose>
		<xsl:when test="IMAGENES/IMAGEN">
				<xsl:for-each select="IMAGENES/IMAGEN">
				{
				"producto": "<xsl:value-of select="IMG_IDPRODUCTO" />",				
				"estado": "<xsl:value-of select="@estado" />",			
				"grande": "<xsl:value-of select="IMG_GRANDE" />",
				"peq": "<xsl:value-of select="IMG_PEQ" />",
				"id": "<xsl:value-of select="IMG_ID" />"
				}
			</xsl:for-each>	
		</xsl:when>
</xsl:choose>
]
</xsl:template>
</xsl:stylesheet>