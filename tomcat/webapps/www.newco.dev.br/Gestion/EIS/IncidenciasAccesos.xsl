<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"> 
<xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>

  
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
   
	<title><xsl:value-of select="TITULO" disable-output-escaping="yes"/></title>
	
     <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

         <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
      </head>
      <body>      
        <xsl:choose>
      
        <xsl:when test="PedidoGPP/ROWSET/ROW/Sorry">
          <xsl:apply-templates select="PedidoGPP/ROWSET/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
        
          <!--idioma-->
        <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/AccesosUsuarios/LANG"><xsl:value-of select="/AccesosUsuarios/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      		        <!--idioma fin-->
        
        <h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='incidencias_accesos_ultimo_7_dias']/node()"/></h1>
        <div class="divLeft">
        <table class="grandeInicio">
        <thead>
	    <!-- Titulos -->
          <tr class="titulos">
	      	<td class="veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></td>
	      	<td class="veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></td>
	      	<td class="trenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='direccion_ip']/node()"/></td>
	      	<td class="trenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></td>
		  </tr>
        </thead>
        <tbody>
          <xsl:for-each select="AccesosUsuarios/ROW">
            <tr>
                <td><xsl:value-of select="FECHA"/>&nbsp;</td>
                <td><xsl:value-of select="USUARIO"/>&nbsp;</td>
                <td><xsl:value-of select="DIRECCIONIP"/>&nbsp;</td>
                <td><xsl:value-of select="ESTADO"/>&nbsp;</td>
			</tr>
		  </xsl:for-each>	  
        </tbody>
        </table> 
        </div>
        <br/><br/>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  
  
  

</xsl:stylesheet>
