<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:import href="http://www.newco.dev.br/Noticias/Noticias.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:param name="usuario" select="@US_ID"/>

<xsl:template match="/">
<html>
<head>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->
 
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript">
		function globalEvents(){
						
			jQuery(".oneMenuGestion").click(function(){
				jQuery(".oneMenuGestion").removeClass('selectGestion');
				jQuery(this).addClass('selectGestion');
			});
			
		/*
			jQuery(".oneMenuGestion").mouseover(function(){
				jQuery(this).css('background','#ffff66');
			});
			jQuery(".oneMenuGestion").mouseout(function(){
				jQuery(this).css('background','#FED136');
			});*/
			
		}
	</script> 
</head>

<body onload="globalEvents();">
	<xsl:choose>
	<xsl:when test="MenusGestion/SESION_CADUCADA">
		<xsl:apply-templates select="MenusGestion/SESION_CADUCADA"/>
	</xsl:when>
	<xsl:otherwise>
		<!--idioma-->
		<xsl:variable name="lang">
			<xsl:value-of select="/MenusGestion/LANG"/>
		</xsl:variable>
		<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
		<!--idioma fin-->
                
                
		<table class="menuGestion">
		<tr>
		<xsl:for-each select="/MenusGestion/MENUSGESTION/MENU">
			<th class="siete oneMenuGestion">
				<xsl:choose>
				<xsl:when test="ME_NOMBRE = 'Catalogos Clientes'">
					<a target="Trabajo">
						<xsl:attribute name="href">../<xsl:value-of select="ME_ENLACE"/>?TYPE=MVM</xsl:attribute>
						<xsl:value-of select="ME_NOMBRE"/>
					</a>
				</xsl:when>
				<xsl:when test="ME_ENLACE = 'Administracion/Mantenimiento/Empresas/EMPNueva.xsql'">
					<a target="Trabajo">		
						<xsl:attribute name="href">../<xsl:value-of select="ME_ENLACE"/>?IDUSUARIO=<xsl:value-of select="/MenusGestion/US_ID"/></xsl:attribute>
						<xsl:value-of select="ME_NOMBRE" />
					</a>
				</xsl:when>
				<xsl:otherwise>
					<a target="Trabajo">		
						<xsl:attribute name="href">../<xsl:value-of select="ME_ENLACE"/></xsl:attribute>
						<xsl:value-of select="ME_NOMBRE"/>
					</a>
				</xsl:otherwise>
				</xsl:choose>
			</th>
		</xsl:for-each>
		</tr>
		</table>
	</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>

<xsl:template match="Sorry">
	<xsl:apply-templates select="Noticias/ROW/Sorry"/>
</xsl:template>
</xsl:stylesheet>