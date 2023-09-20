<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
 
<xsl:template match="/confirmAsociaAProducto">
[
	<xsl:choose>
		<xsl:when test="DOCUMENTOS_COMERCIALES_PROV/@estado='OK'">
        	<xsl:for-each select="DOCUMENTOS_COMERCIALES_PROV">
				{
				"id_doc": "<xsl:value-of select="DOC_ID" />",
                "file": "<xsl:value-of select="DOC_FILE" />",                				
				"nombre": "<xsl:value-of select="DOC_NOMBRE" />",			
				"size": "<xsl:value-of select="DOC_SIZE" />",
				"descripcion": "<xsl:value-of select="DOC_DESCRIPCION" />",
				"id_prove": "<xsl:value-of select="DOC_IDPROVEEDOR" />",
                "id_usuario": "<xsl:value-of select="DOC_IDUSUARIO" />"
				}
            </xsl:for-each>
		</xsl:when>
        <xsl:when test="DOCUMENTOS_COMERCIALES_PROV/@estado='ERROR'">
        	<xsl:for-each select="DOCUMENTOS_COMERCIALES_PROV">
				{
				"id_doc": "<xsl:value-of select="DOC_ID" />",
                "file": "<xsl:value-of select="DOC_FILE" />",                				
				"nombre": "<xsl:value-of select="DOC_NOMBRE" />",			
				"size": "<xsl:value-of select="DOC_SIZE" />",
				"descripcion": "<xsl:value-of select="DOC_DESCRIPCION" />",
				"id_prove": "<xsl:value-of select="DOC_IDPROVEEDOR" />",
                "id_usuario": "<xsl:value-of select="DOC_IDUSUARIO" />"
				}
            </xsl:for-each>
		</xsl:when>
</xsl:choose>

]
</xsl:template>
</xsl:stylesheet>
	<!---->