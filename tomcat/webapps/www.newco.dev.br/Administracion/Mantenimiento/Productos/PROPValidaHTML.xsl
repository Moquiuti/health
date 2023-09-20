<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
        <title><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PL-0110' and @lang=$lang]" disable-output-escaping="yes"/></title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
        ]]></xsl:text>
      </head>
      <body bgcolor="#EEFFFF">  
        <form name="{BusquedaProductos/BuscForm/@name}" method="{BusquedaProductos/BuscForm/@method}" action="{BusquedaProductos/BuscForm/@action}">
        <table align="center" valign="center" width="50%" cellpadding="0" cellspacing="0"> 
          <tr>
            <td colspan="3"><p class="tituloCamp"><xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PROP-0030' and @lang=$lang]"/></p></td></tr>
      	  <tr><td colspan="3">&nbsp;</td></tr>
      	  <tr align="center">
      	    <td><xsl:apply-templates select="BusquedaProductos/BuscForm/button"/></td>
            <td width="50%">&nbsp;</td>
            <td><xsl:apply-templates select="BusquedaProductos/BuscForm/jumpTo"/></td></tr></table></form>
      </body>
    </html>
  </xsl:template>  


</xsl:stylesheet>
