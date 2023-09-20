<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html> 
      <head>
        <title>Ficha Técnica</title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
	
	
	
	
	<script type="text/javascript">
	 <!--
	  
	 -->
	</script> 
	
	]]></xsl:text>
	
	 
	
               
      </head>
      <body bgcolor="#ffffff">
      <table class="muyoscuro" border="0" cellspacing="1" cellpadding="3" align="center">
         <tr class="blanco">
            <td>
              <img name="imagen" src="{//FICHA_IMG}"/>
            </td>
         </tr>
         <tr class="blanco">
            <td align="center">
              <table border="0" cellspacing="0" cellpadding="0" align="center" width="100%">
              <tr>
            <td align="center">
              <xsl:call-template name="boton">
 	        <xsl:with-param name="path" select="//button[@label='Cerrar']"/>
 	      </xsl:call-template>
            </td>
            <td align="center">
              <xsl:call-template name="boton">
 	        <xsl:with-param name="path" select="//button[@label='Imprimir']"/>
 	      </xsl:call-template>
            </td>
         </tr>
         </table>
            </td>  
         </tr>
      </table>
   </body>
 </html>
 
</xsl:template>

</xsl:stylesheet>
