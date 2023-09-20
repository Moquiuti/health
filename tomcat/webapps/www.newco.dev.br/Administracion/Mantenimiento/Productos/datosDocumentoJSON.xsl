<?xml version="1.0" encoding="iso-8859-1"?>
<!-- 
	Recupera los datos de un documento desde la base de datos
	Ultima revision: ET 12feb20
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/datosDocumento">
{
"id": "<xsl:value-of select="DOCUMENTO/ID" />",
"url": "<xsl:value-of select="DOCUMENTO/URL" />",
"nombre": "<xsl:value-of select="DOCUMENTO/NOMBRE" />",
"fecha": "<xsl:value-of select="DOCUMENTO/FECHA" />",
"descripcion": "<xsl:value-of select="DOCUMENTO/DESCRIPCION" />"
}
</xsl:template>
</xsl:stylesheet>
