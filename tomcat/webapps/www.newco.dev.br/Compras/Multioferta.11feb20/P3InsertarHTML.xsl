<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>    
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/Plantilla">
    <html>
      <head>
        <!--
         |   Lo hacemos saltar a la pagina de lista de productos.
         |
         +-->
        <xsl:choose>
          <xsl:when test="not(//xsql-error)">
            <meta http-equiv="Refresh">
              <xsl:attribute name="content">0; URL=http://www.newco.dev.br/Compras/Multioferta/LPLista.xsql?LP_ID=<xsl:value-of select="Transaccion/LP_ID"/></xsl:attribute>
            </meta>
          </xsl:when>
        </xsl:choose>
	<xsl:text disable-output-escaping="yes"><![CDATA[
        <link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
        ]]></xsl:text>
      </head>
      <body bgcolor="#EEFFFF">
        <xsl:choose>
          <xsl:when test="//xsql-error">
             <xsl:apply-templates select="//xsql-error"/>
          </xsl:when>
          <xsl:otherwise>      
	    <table>
	      <tr><td width="80%">&nbsp;</td></tr>
	      <tr>
	        <td>
	          <a>
	            <xsl:attribute name="href">http://www.newco.dev.br/Compras/Multioferta/LPLista.xsql?LP_ID=<xsl:value-of select="Transaccion/LP_ID"/></xsl:attribute>
	            Guardando datos...
	          </a>
	        </td>
	      </tr>
	    </table>
	  </xsl:otherwise>
	</xsl:choose>
      </body>
    </html> 
  </xsl:template>
  

</xsl:stylesheet>
