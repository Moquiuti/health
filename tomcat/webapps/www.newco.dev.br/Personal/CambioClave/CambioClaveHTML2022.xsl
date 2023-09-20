<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Cambio de clave del usuario
	Ultima revision: ET 10mar22 11:15 CambioClave2022_100322.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>  
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
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
		<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/Personal/CambioClave/CambioClave2022_100322.js"></script>
	
      </head>

      <body>      
	 <!--idioma-->
        <xsl:variable name="lang">
        	<xsl:choose>
            <xsl:when test="/CambioClave/LANG"><xsl:value-of select="/CambioClave/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin--> 

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='cambio_de_clave']/node()"/>&nbsp;&nbsp;
			<span class="CompletarTitulo">
				<a href="javascript:javascript:ValidaClave();" class="btnDestacado">
    				<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
				</a>
			</span>
		</p>
	</div>
    
	<form class="formEstandar" method="post" action="CambioClaveSave2022.xsql">
    <div>
        <ul class="w1000px">
            <li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='introduzca_clave_antigua']/node()"/>:</label>
				<input type="password" class="campopesquisa" name="fClaveAntigua"/>
            </li>
            <li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='introduzca_clave_nueva']/node()"/>:</label>
				<input type="password" class="campopesquisa" name="fClaveNueva"/>
            </li>
            <li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='repita_clave_nueva']/node()"/>:</label> 
				<input type="password" class="campopesquisa" name="fClaveNuevaRep"/>
            </li>
            <!--<li class="sinSeparador">
				<label class="leyenda"><xsl:value-of select="document($doc)/translation/texts/item[@name='clave_minimo_6_caracteres']/node()"/></label>
            </li>-->
            <li class="sinSeparador">
				<label>&nbsp;</label>
            </li>
        </ul>
    </div>
	</form>

      </body>
    </html>

</xsl:template>

</xsl:stylesheet>
