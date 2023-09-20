<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 |	Gestión de los fichero de integración 
+-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/plain" method="text" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/">
	<xsl:for-each select="/ExportacionOC/LINEAS_FICHERO/LINEA">
		<xsl:value-of select="."/><xsl:text>&#x0A;</xsl:text>
	</xsl:for-each>
</xsl:template>
</xsl:stylesheet>
