<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/> 
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  
  <xsl:template match="/">
    <html>
      <head>
        <title>
          Mantenimiento de Centros del Catálogo Privado
        </title>
      </head>
      <frameset rows="*,1px" border="0">
        <xsl:element name="frame">
          <xsl:attribute name="name">frameMantenimientoCentros</xsl:attribute>
          <xsl:choose>
            <xsl:when test="//ACCION='NUEVOCENTRO'"> 
              <xsl:attribute name="src">http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantCentrosCatalogo.xsql?IDNUEVOCENTRO=<xsl:value-of select="//IDNUEVOCENTRO"/>&amp;ACCION=<xsl:value-of select="//ACCION"/>&amp;IDPRODUCTOESTANDAR=<xsl:value-of select="//IDPRODUCTOESTANDAR"/></xsl:attribute>
            </xsl:when>
            <xsl:when test="//ACCION='MODIFICARCENTRO'"> 
              <xsl:attribute name="src">http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantCentrosCatalogo.xsql?CENTROPRODUCTO_ID=<xsl:value-of select="//CENTROPRODUCTO_ID"/>&amp;IDPRODUCTOESTANDAR=<xsl:value-of select="//IDPRODUCTOESTANDAR"/>&amp;ACCION=<xsl:value-of select="//ACCION"/></xsl:attribute>
            </xsl:when>
          </xsl:choose>
          <xsl:attribute name="scrolling">auto</xsl:attribute>
          <xsl:attribute name="marginwidth">0</xsl:attribute> 
          <xsl:attribute name="marginheight">0</xsl:attribute>
        </xsl:element>
        
        <xsl:element name="frame">
          <xsl:attribute name="name">frameXML</xsl:attribute>
          <xsl:attribute name="src"></xsl:attribute>
          <xsl:attribute name="scrolling">no</xsl:attribute>
          <xsl:attribute name="marginwidth">0</xsl:attribute> 
          <xsl:attribute name="marginheight">0</xsl:attribute>
        </xsl:element>
      </frameset>
    </html>
      
</xsl:template>

</xsl:stylesheet>
