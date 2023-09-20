<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:param name="lang" select="@lang"/>
 
<xsl:template match="/datosCentro/CENTRO">
{"ID": "<xsl:value-of select="ID"/>",
"Nombre": "<xsl:value-of select="NOMBRE"/>",
"Direccion": "<xsl:value-of select="DIRECCION"/>",
"Poblacion": "<xsl:value-of select="POBLACION"/>",
"Provincia": "<xsl:value-of select="PROVINCIA"/>",
"CodPostal": "<xsl:value-of select="CPOSTAL"/>"}
</xsl:template>
</xsl:stylesheet>
	
