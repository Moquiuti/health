<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>  
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  <xsl:template match="/">  
    <html>
      <head> <title>Imagen del producto.</title>
      </head>

      <body bgcolor="#EEFFFF">      
        <img>
           <xsl:choose>
           <xsl:when test="MostrarImagen/IMAGEN">
                <xsl:attribute name="src">	        
                <xsl:value-of select="MostrarImagen/IMAGEN"/>
                </xsl:attribute>
           </xsl:when>
           <xsl:otherwise>     
                <xsl:attribute name="src">	        
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='DB-100' and @lang=$lang]" disable-output-escaping="yes"/>
                </xsl:attribute>	        
           </xsl:otherwise>     
           </xsl:choose>
        </img>         
        <form>
        <input type="button" value="Cerrar" onClick="javascript:history.go(-1);"/>
        </form>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
