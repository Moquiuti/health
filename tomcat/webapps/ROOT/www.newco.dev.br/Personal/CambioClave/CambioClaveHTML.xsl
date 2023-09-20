<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	6nov16	Cambio diseño
	Ultima revision 9nov16 12:00
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>  
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  <xsl:template match="/">
    <html>
      <head>
	
		<!--style-->
		<xsl:call-template name="estiloIndip"/>
		<!--fin de style-->  	
		<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/Personal/CambioClave/CambioClave1.js"></script>
	
      </head>

      <body>      
            <!--<xsl:apply-templates select="CambioClave/form"/>-->
<!--  </xsl:template> 


<xsl:template match="form" method="post" action="CambioClaveSave.xsql">-->
	 <!--idioma-->
        <xsl:variable name="lang">
        	<xsl:choose>
            <xsl:when test="/CambioClave/LANG"><xsl:value-of select="/CambioClave/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin--> 
      <!--
    <xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
    <xsl:attribute name="method"><xsl:value-of select="@method"/></xsl:attribute>    
    <xsl:attribute name="action"><xsl:value-of select="@action"/></xsl:attribute>
 -->
	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Gestion']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='cambio_de_clave']/node()"/></span></p>
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='cambio_de_clave']/node()"/>&nbsp;&nbsp;
			<span class="CompletarTitulo">
				<a href="javascript:javascript:ValidaClave();" class="btnDestacado">
    				<xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar_minu']/node()"/>
				</a>
			</span>
		</p>
	</div>
    
	<form class="formEstandar" method="post" action="CambioClaveSave.xsql">
    <div>
        <ul style="width:1000px;">
            <li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='introduzca_clave_antigua']/node()"/>:</label>
				<input type="password" name="fClaveAntigua"/>
            </li>
            <li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='introduzca_clave_nueva']/node()"/>:</label>
				<input type="password" name="fClaveNueva"/>
            </li>
            <li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='repita_clave_nueva']/node()"/>:</label> 
				<input type="password" name="fClaveNuevaRep"/>
            </li>
            <li class="sinSeparador">
				<label class="leyenda"><xsl:value-of select="document($doc)/translation/texts/item[@name='clave_minimo_6_caracteres']/node()"/></label>
            </li>
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
