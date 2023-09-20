<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">

<html>
  <head>
    <title>Informe de no conformidad de producto</title>
  </head>
    <frameset rows="99%,*" frameborder="no" border="0" framespacing="0">
      <frame name="NoConformidad" src="NoConformidadProducto.xsql?IDINFORME={Mantenimiento/IDINFORME}&amp;READ_ONLY={Mantenimiento/READ_ONLY}" scrolling="auto" noresize="yes"/>
        <frame name="xml" scrolling="no" noresize="yes"/>           
      </frameset>
    </html>
  
  
</xsl:template>

</xsl:stylesheet>
