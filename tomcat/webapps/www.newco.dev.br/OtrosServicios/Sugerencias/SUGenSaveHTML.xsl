<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |   Almacenar una Alta de Sugerencia
 |  
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
          <xsl:when test="SugerenciaRecibida/xsql-error">
            <!-- Mostrar los errores -->
            <xsl:apply-templates select="SugerenciaRecibida/xsql-error"/>          
          </xsl:when>
          <xsl:when test="SugerenciaRecibida/Status">
            <!-- Mostrar los errores -->
            <xsl:apply-templates select="SugerenciaRecibida/Status"/>          
          </xsl:when>
          <xsl:otherwise>
          <!-- No hay error, Damos las gracias -->
          <p class="tituloPag">
            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0100' and @lang=$lang]"/>
          </p>
          <hr/>
          <p  class="tituloCamp">
            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0105' and @lang=$lang]"/>
          </p>
          <center><xsl:apply-templates select="SugerenciaRecibida/jumpTo"/></center>                 
          </xsl:otherwise>
      </xsl:choose>
                    
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
