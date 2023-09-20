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
        <script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
        </script>
        ]]></xsl:text>	
      </head>
      <body bgcolor="#EEFFFF">
        
        <center>
        <p class="tituloPag"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CVG-0260' and @lang=$lang]" disable-output-escaping="yes"/></p>
        <hr/>
        <xsl:apply-templates select="Pendiente/jumpTo"/>      
        </center>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>