<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Página de soporte para los usuarios
	ultima revision: ET 24ene20
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
		<!--idioma-->
		<xsl:variable name="lang">
			<xsl:choose>
			<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <head>
		<!--idioma fin-->
		<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Soporte']/node()"/></title>
		<!--style-->
		<xsl:call-template name="estiloIndip"/>
		<!--fin de style -->
		<script src="http://code.jivosite.com/widget/UaqzE25VYz" async="async"/> <!-- Script JivoChat-->
      </head>
      <body class="gris">
		<xsl:choose>
		<!-- Error en alguna sentencia del XSQL -->
		<xsl:when test="/Ayuda/ERROR">
		<xsl:apply-templates select="Tutoriales/xsql-error"/>        
		</xsl:when>
		<xsl:otherwise>
			<!--	Titulo de la página		-->
			<div class="ZonaTituloPagina">
				<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Soporte']/node()"/></span></p>
				<p class="TituloPagina">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Soporte']/node()"/>&nbsp;&nbsp;
				</p>
			</div>
		</xsl:otherwise>
      </xsl:choose>
      </body>
    </html>
  </xsl:template>  
  

</xsl:stylesheet>
