<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
        <!--
         |   Lo hacemos saltar a la página de analisis
         |	Solo cuando no hay error!
         +-->
        <xsl:choose>
         <xsl:when test="not (//xsql-error) and not (//Status)">
          <meta http-equiv="Refresh">
          <xsl:attribute name="content">
            0; URL=http://www.newco.dev.br/Compras/Multioferta/LPAnalFrameDirecto.xsql?LP_ID=<xsl:value-of select="Analizar/MAIN/LP_ID"/>
          </xsl:attribute>
          </meta>
         </xsl:when>
        </xsl:choose>
      </head>
      <body bgcolor="#EEFFFF">
    <xsl:choose>
       <xsl:when test="//xsql-error">
         <xsl:apply-templates select="//xsql-error"/>       
       </xsl:when>
       <xsl:when test="//Status">
         <xsl:apply-templates select="//Status"/>
       </xsl:when>
       <xsl:otherwise>
         <a>
         <xsl:attribute name="href">
          http://www.newco.dev.br/Compras/Multioferta/LPAnalFrameDirecto.xsql?LP_ID=<xsl:value-of select="Analizar/MAIN/LP_ID"/>
         </xsl:attribute>
         Preparando Oferta...
         </a>       
       </xsl:otherwise>
      </xsl:choose>      
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
