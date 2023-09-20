<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>  
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
<xsl:template match="/">
<html>
   <head>
      <title>MedicalVM</title>
    </head>
<frameset rows="*,1px" border="0">
  <xsl:element name="frame">
    <xsl:attribute name="name">frameListas</xsl:attribute>
    <xsl:attribute name="src">nomenclatorLista.xsql?LLP_ID=<xsl:value-of select="//LLP_ID"/>&amp;LP_ID=<xsl:value-of select="//LP_ID"/>&amp;OP=<xsl:value-of select="//OP"/>&amp;US_ID=<xsl:value-of select="//US_ID"/>&amp;HISTORY=<xsl:value-of select="//HISTORY"/></xsl:attribute>
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
