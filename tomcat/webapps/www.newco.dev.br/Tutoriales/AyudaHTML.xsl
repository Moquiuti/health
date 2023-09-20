<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Página de soporte para los usuarios
	ultima revision: ET 28ene20
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
		<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Ayuda']/node()"/></title>
		<!--style-->
		<xsl:call-template name="estiloIndip"/>
		<!--fin de style -->
		<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
		<link href="./simpleGridTemplate.css" rel="stylesheet" type="text/css"/> 
		<script type="text/javascript">
			function AbrirSoporte()
			{
				PosX= (window.screen.availWidth)-600;
				PosY= 0;
				
				var Config="toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width=600,height=700,screenX="+PosX+",screenY="+PosY;
				window.open("http://www.newco.dev.br/Tutoriales/Chat.xsql" , "Soporte" , Config)
			}
		</script>
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
				<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ayuda']/node()"/></span></p>
				<p class="TituloPagina">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Ayuda']/node()"/>&nbsp;&nbsp;
					&nbsp;&nbsp;
					<span class="CompletarTitulo">
						<a class="btnNormal" href="javascript:AbrirSoporte();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='Soporte']/node()"/>
						</a>
						&nbsp;
					</span>
				</p>
			</div>

			  <!-- Stats Gallery Section -->
			  <div class="thumbnail"> <a href="#">
    			<iframe src="http://player.vimeo.com/video/386225666" width="640" height="360" frameborder="0" allow="autoplay; fullscreen" allowfullscreen="allowfullscreen"></iframe>
    			</a>
    			<h4>Cotação de Compras</h4>
    			<p class="tag">Treinamento de cotação</p>
    			<p class="text_column">Descrição do Video (Editar)</p>
				</div>
			  <div class="gallery"> <!-- Videos de treinamento -->
    			<!--  Fim Videos de treinamento -->
			  </div>
			  <!-- Footer Section -->
			  <footer id="contact">
    			<p class="hero_header">Educational VM</p>
    			<div class="button">EMAIL ME </div>
			  </footer>
			  <!-- Copyrights Section -->
		</xsl:otherwise>
      </xsl:choose>
      </body>
    </html>
  </xsl:template>  
  

</xsl:stylesheet>
