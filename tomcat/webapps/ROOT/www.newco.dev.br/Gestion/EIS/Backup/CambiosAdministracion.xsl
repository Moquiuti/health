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
            <xsl:when test="/ListadoAdministracion/LANG"><xsl:value-of select="/ListadoAdministracion/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>    <!--idioma fin-->
      
	<title><xsl:value-of select="TITULO" disable-output-escaping="yes"/> <xsl:value-of select="document($doc)/translation/texts/item[@name='cambios_administrativos']/node()"/></title>
	 <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  
	  <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	  <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	</head>
      <body>     
        <xsl:choose>
      	
        <xsl:when test="ListadoErrores/ROWSET/ROW/Sorry">
          <xsl:apply-templates select="ListadoErrores/ROWSET/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
         <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/ListadoAdministracion/LANG"><xsl:value-of select="/ListadoAdministracion/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>    <!--idioma fin-->
        
	    <!-- Titulo -->
	      <h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='cambios_administrativos']/node()"/></h1>
		  
          <table class="grandeInicio">
           <thead>
          <tr class="titulos">
	      	<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></td>
	      	<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></td>
	      	<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='tabla']/node()"/></td>
	      	<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_cambio']/node()"/></td>
	      	<td class="cinquenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='cambio']/node()"/></td>
	      	<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='registro']/node()"/></td>
		  </tr>
          </thead>
          <tbody>
           <xsl:for-each select="ListadoAdministracion/CAMBIOS/ROW">
              <tr class="blanco">
                <td><xsl:value-of select="FECHAFORMATO"/>&nbsp;</td>
                <td><xsl:value-of select="USUARIO"/>&nbsp;</td>
                <td><xsl:value-of select="TABLA"/>&nbsp;</td>
                <td><xsl:value-of select="TIPOCAMBIO"/>&nbsp;</td>
                <td><xsl:value-of select="CAMBIO"/>&nbsp;</td>
                <td><xsl:value-of select="REGISTRO"/>&nbsp;</td>
				</tr>
			</xsl:for-each>	    
          </tbody>
          </table> 
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  
  
  

</xsl:stylesheet>
