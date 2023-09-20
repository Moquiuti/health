<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:param name="lang" select="@lang"/>
 
<xsl:template match="/confirmEliminaOferta">
[
	
		<xsl:if test="OK">
        	{
			"ok": "ok"
			}
		</xsl:if>
        <xsl:if test="ERROR">
        	{
			"error": "<xsl:value-of select="ERROR/@msg"/>"
			}
		</xsl:if>

]
</xsl:template>
</xsl:stylesheet>
	
