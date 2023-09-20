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
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
        ]]></xsl:text>
      </head>

      <body bgcolor="#EEFFFF">
        <xsl:choose>
          <xsl:when test="not(MantenimientoBorrar/Status/OK)">       
            <xsl:apply-templates select="MantenimientoBorrar/Status"/>          
          </xsl:when>
          <xsl:when test="MantenimientoBorrar/xsql-error">
              <xsl:apply-templates select="MantenimientoBorrar/xsql-error"/>
          </xsl:when>
          <xsl:otherwise>
          
	        <xsl:choose>
	          <xsl:when test="BUSQUEDA[.='RAPIDA']">       
	            <script>document.location.href="javascript:history.go(-2)";</script>	          
	          </xsl:when>
	          <xsl:otherwise>
	            <script>document.location.href="javascript:history.go(-1)";</script>	          
	          </xsl:otherwise>
	        </xsl:choose>            
          </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>
    
</xsl:stylesheet>