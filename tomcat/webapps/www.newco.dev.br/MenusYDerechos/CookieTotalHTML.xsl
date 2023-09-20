<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  <xsl:template match="/">
    <html>
      <head><TITLE>Cookie Total</TITLE></head>
      <body>       
        <xsl:choose>
          <xsl:when test="//xsql-error">
            <!-- Mostrar los errores -->
            <xsl:apply-templates select="//xsql-error"/>          
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="//Correcto">
          	    La cookie ha sido activada correctamente.
              </xsl:when>
	          <xsl:otherwise>
	            ERROR en la activacion de la cookie.
	          </xsl:otherwise>                                  	
          	</xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  

</xsl:stylesheet>
