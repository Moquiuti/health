<?xml version="1.0" encoding="iso-8859-1" ?>
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
        <!--
         |   Lo hacemos saltar a la pagina de lista de productos.
         |
         +-->
        <xsl:choose>
          <xsl:when test="Multioferta/Status/SALTA">
            <meta http-equiv="Refresh">
            <xsl:attribute name="content">
              0; URL=http://www.newco.dev.br/Compras/Multioferta/Multioferta.xsql?MO_ID=<xsl:value-of select="Multioferta/Status/MO_ID"/>
            </xsl:attribute>
            </meta>
          </xsl:when>
        </xsl:choose>
      </head>
      <body bgcolor="#EEFFFF">
        <xsl:choose>
          <xsl:when test="Incidencia/xsql-error">
            <xsl:apply-templates select="Incidencia/xsql-error"/>          
          </xsl:when>
          <xsl:when test="not(Incidencia/Status/SALTA)">     
            <xsl:apply-templates select="Incidencia/Status"/>             
          </xsl:when>
          <xsl:when test="Incidencia/Status/SALTA">
	    <table>
	      <tr>
	       <td width="80%">&nbsp;</td>
	      </tr>
	      <tr>
	        <td>
	          <a>
	            <xsl:attribute name="href">
	              http://www.newco.dev.br/Compras/Incidencia/Incidencia.xsql?INC_ID=<xsl:value-of select="Incidencia/Status/INC_ID"/>
	            </xsl:attribute>
	            Cargando pagina...
	          </a>
	        </td>
	      </tr>    
	    </table>
	  </xsl:when>
        </xsl:choose>       
      </body>
    </html>
    
  </xsl:template>
  
  
</xsl:stylesheet>
