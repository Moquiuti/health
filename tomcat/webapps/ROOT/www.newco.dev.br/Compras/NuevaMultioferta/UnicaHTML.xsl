<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	ET 2dic16 Pagina principal para "Enviar pedidos", incluye título y frameset
	ultima revisión 2dic16 12:41
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>  
	<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>


	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/Main/USUARIO/LANG"/>
	</xsl:variable>   
	<xsl:value-of select="$lang"/>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:template match="/">     
	<html>
	<head>
		<title><xsl:value-of select="document($doc)/translation/texts/item[@name='main_title']/node()"/></title>

		<!--style-->
		<xsl:call-template name="estiloIndip"/> 
		<!--fin de style--> 

	</head> 
	<body>
	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Enviar_pedidos']/node()"/></span></p>
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Enviar_pedidos']/node()"/>&nbsp;&nbsp;
			<!--
			<span class="CompletarTitulo">
				<a href="javascript:javascript:ValidaClave();" class="btnDestacado">
    				<xsl:value-of select="document($doc)/translation/texts/item[@name='Enviar_pedidos']/node()"/>
				</a>
			</span>
			-->
		</p>
	</div>
	<frameset cols="200px,*" frameborder="no" border="0" framespacing="1">
		<!--	Frame que contiene la informacion de plantillas	-->
		<frameset rows="280px,*" frameborder="no" border="0" framespacing="0">
			<!--	Frame que contiene la informacion de plantillas	-->
			 <frame name="zonaPlantilla" src="ZonaPlantilla.xsql" scrolling="auto" />
			 <frame name="zonaProducto" src="about:blank" scrolling="auto" noresize="yes"/>
			</frameset>
		<frame name="areaTrabajo" src="AreaTrabajo.html" scrolling="auto" noresize="yes"/>
	</frameset>
	</body>
	</html>
	</xsl:template>
</xsl:stylesheet>
