<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
        ]]></xsl:text>
      </head>
      <body bgcolor="#EEFFFF">
    <xsl:choose>
       <xsl:when test="//xsql-error">
         <xsl:apply-templates select="//xsql-error"/>       
       </xsl:when>
       <xsl:when test="//Status">
         <xsl:apply-templates select="//Status"/>
       </xsl:when>
      </xsl:choose>      
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
