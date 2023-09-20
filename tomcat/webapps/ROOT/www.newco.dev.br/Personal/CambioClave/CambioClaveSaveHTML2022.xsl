<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Cambio de clave del usuario
	Ultima revision: ET 10mar22 11:15 CambioClave2022_100322.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>  
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:template match="/">  

	<!--	Todos los documentos HTML deben empezar con esto	-->
	<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

    <html>
      <head> 
		<!--style-->
		<xsl:call-template name="estiloIndip"/>
		<!--fin de style-->  	

		<!--	11ene22 nuevos estilos -->
		<!--<link rel="stylesheet" href="http://www.newco.dev.br/General/basicMVM2022.css"/>-->
		<link href='http://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'/>
		<!--	11ene22 nuevos estilos -->

		<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
		<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
		<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
      </head>

      <body>
		<!--idioma-->
		<xsl:variable name="lang">
			<xsl:value-of select="/CambioClave/LANG" />
		</xsl:variable>
		<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
		<!--idioma fin--> 

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path">&nbsp;</p>
			<p class="TituloPagina">
        		<xsl:value-of select="document($doc)/translation/texts/item[@name='cambio_de_clave']/node()"/>
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
