<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |  This stylesheet implements multi-language at the UI level
 |  It is based on the parameter 'lang' that is 'english' by default.
 |  It can be also 'french' or 'spanish' or 'german'.
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" /> 
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  <xsl:template match="/">
 
    <html> 
      <head> 
	 <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  	
  
      <body>
        <xsl:apply-templates select="MantenimientoBorrar/Status"/>
      </body>
    </html>
  </xsl:template>
    
</xsl:stylesheet>