<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>  
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">

  
  <html>
    <xsl:choose>
       <xsl:when test="//xsql-error">
         <head></head>
         <body bgcolor="#EEFFFF">
         <xsl:apply-templates select="//xsql-error"/>        
         </body>
       </xsl:when>
       <xsl:when test="//Status/OK">
              <head>
                <!--
                 |   Lo hacemos saltar a la pagina de lista de productos.
                 |
                 +-->
                 
                <meta http-equiv="Refresh">
                <xsl:attribute name="content">
                  0; URL=<xsl:value-of select="/Tarifas/Status/ACTUALIZAR/SALTAR"/>
                </xsl:attribute>
                </meta>
              </head>
              <body bgcolor="#EEFFFF">     
                <table>
                  <tr>
                    <td width="80%">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>
                      <a>
                        <xsl:attribute name="href"><xsl:value-of select="/Tarifas/Status/ACTUALIZAR/SALTAR"/></xsl:attribute>
                        Cargando pagina...
                      </a>
                    </td>
                  </tr>
                </table>
              </body>
            </xsl:when>

      <xsl:otherwise>
        <body>
             <xsl:apply-templates select="//Status"/>             
         </body>
      </xsl:otherwise>
    </xsl:choose>
  </html>    
</xsl:template>
 
</xsl:stylesheet>
