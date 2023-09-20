<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
 
<xsl:template match="/confirmCargaDocumento">
[
	<xsl:choose>
		<xsl:when test="DOCUMENTOS/DOCUMENTO/@estado='OK'">
        	<xsl:for-each select="DOCUMENTOS/DOCUMENTO">
				{
				"id_doc": "<xsl:value-of select="DOC_ID" />",
				}
            </xsl:for-each>
		</xsl:when>
        <xsl:when test="DOCUMENTOS/DOCUMENTO/@estado='ERROR'">
        	<xsl:for-each select="DOCUMENTOS/DOCUMENTO">
				{
				"id_doc": "<xsl:value-of select="DOC_ID" />",
				}
            </xsl:for-each>
		</xsl:when>
</xsl:choose>

]
</xsl:template>
</xsl:stylesheet>
	<!---->
