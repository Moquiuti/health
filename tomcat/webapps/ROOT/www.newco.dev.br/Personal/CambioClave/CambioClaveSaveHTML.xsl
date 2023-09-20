<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>  
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:template match="/">  
    <html>
      <head> 
	 <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  	
   	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
      </head>

      <body>
       <!--idioma-->

        <xsl:variable name="lang">
        	<xsl:value-of select="/CambioClave/LANG" />
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin--> 

		<!--	Titulo de la p�gina		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Gestion']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='cambio_de_clave']/node()"/></span></p>
			<p class="TituloPagina">
        	  <!--<xsl:value-of select="document($doc)/translation/texts/item[@name='cambio_de_clave']/node()"/>&nbsp;&nbsp;-->
			</p>
		</div>

      
          <xsl:choose>
           <xsl:when test="/CambioClave/xsql-error">
            <!-- Mostrar los errores xsql -->
            <xsl:apply-templates select="/CambioClave/xsql-error"/>                     
           </xsl:when> 
           <xsl:when test="/CambioClave/Status">
             <xsl:apply-templates select="/CambioClave/Status"/>                                
           </xsl:when>                     
          </xsl:choose>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
