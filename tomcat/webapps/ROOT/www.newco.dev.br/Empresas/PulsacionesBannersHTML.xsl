<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  
  <xsl:template match="/">
    <html>
      <head>
        <meta http-equiv="Refresh">
          <xsl:attribute name="content">0; URL=<xsl:value-of select="//LA_URL"/></xsl:attribute>
        </meta>
      </head>
      <body bgcolor="#FFFFFF">
      </body>
    </html>    
  </xsl:template>
  
  

</xsl:stylesheet>
