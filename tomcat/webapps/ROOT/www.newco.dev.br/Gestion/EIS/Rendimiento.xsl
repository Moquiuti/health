<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
     <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Rendimiento/LANG"><xsl:value-of select="/Rendimiento/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>         <!--idioma fin-->
        
	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='indicadores_de_rendimiento']/node()"/></title>
	 <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

      </head>
      <body class="gris">  
     <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Rendimiento/LANG"><xsl:value-of select="/Rendimiento/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>         <!--idioma fin-->    
	    <!-- Titulo -->
	      <h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='indicadores_de_rendimiento']/node()"/></h1>
	      
          <table class="grandeInicio">
          
          <thead>
          <tr class="titulos">
          	 <td class="cinco">&nbsp;</td>
             <td class="veintecinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='etapa']/node()"/></td>
             <td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='repeticiones']/node()"/></td>
             <td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='maximo']/node()"/></td>
             <td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='medio']/node()"/></td>
             <td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='minimo']/node()"/></td>
             <td class="dies"><img src="/images/anterior.gif" />&nbsp;&nbsp;<a href="Rendimiento.html"><xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/></a></td>
          </tr>
          </thead>
          <tbody>
          <xsl:for-each select="/Rendimiento/LINEAESTADISTICA">
              <tr>
                <td>&nbsp;</td>
                <td class="textLeft"><xsl:value-of select="ETAPA"/></td>
                <td><xsl:value-of select="REPETICIONES"/></td>
                <td><xsl:value-of select="MAX"/></td>
                <td><xsl:value-of select="AVG"/></td>
                <td><xsl:value-of select="MIN"/></td>	
                <td>&nbsp;</td>
              </tr>
			</xsl:for-each>	    
          </tbody>
          <tfoot>
          <tr>
          <td colspan="6">&nbsp;</td> 
          <td><img src="/images/anterior.gif" />&nbsp;&nbsp;<strong><a href="Rendimiento.html"><xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/></a></strong></td>
          </tr>
          </tfoot>
          </table> 
          <br/><br/>
      </body>
    </html>
  </xsl:template>  
  
  

</xsl:stylesheet>
