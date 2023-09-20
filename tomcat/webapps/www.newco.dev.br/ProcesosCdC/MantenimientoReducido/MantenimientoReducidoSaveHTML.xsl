<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  
  <!-- template principal -->
  <xsl:template match="/">
		
		<html>
			<head>
              <!--idioma-->
             <xsl:variable name="lang">
            <xsl:choose>
                <xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
                </xsl:choose>  
            </xsl:variable>
            <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>          <!--idioma fin-->
            
				<title><xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo_privado']/node()"/></title>
      <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/mantenimientoReducido.js"></script>
			</head>
			
			<!--  cuerpo -->
			<body>
            	
				<!-- gestion de errores -->
				<xsl:choose>
					<xsl:when test="/Mantenimiento/ERROR">
						<xsl:apply-templates match="/Mantenimiento/ERROR"/>
					</xsl:when>
					<!-- todo ha ido ok, mostramos un mensaje al usuario -->
					<xsl:when test="/Mantenimiento/OK">
						<xsl:apply-templates match="/Mantenimiento/OK"/>
					</xsl:when>
				</xsl:choose>	
			</body>
		</html>
		
	</xsl:template>
	
	<!-- template error -->
	<xsl:template match="/Mantenimiento/ERROR">
      <!--idioma-->
             <xsl:variable name="lang">
            <xsl:choose>
                <xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
                </xsl:choose>  
            </xsl:variable>
            <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>          <!--idioma fin-->
            
				<div class="divLeft">
					<h1 class="titlePage">
						<xsl:value-of select="./@titulo"/>
					</h1>
                    <br /><br />
					<p align="center">
						<xsl:value-of select="./@msg"/>
					</p>
                     <br /><br />
                    <p align="center">
					<div class="botonCenter">
                        <a href="javascript:window.close();">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
                        </a>
                     </div>
					</p>
				</div><!--fin divLeft-->
	</xsl:template>
	
	<!-- template ok -->
	<xsl:template match="/Mantenimiento/OK">
    
      <!--idioma-->
             <xsl:variable name="lang">
            	<xsl:choose>
                <xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
                </xsl:choose>  
            </xsl:variable>
            <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>          <!--idioma fin-->
            
			<div class="divLeft">
					<h1 class="titlePage">
						<xsl:value-of select="./@titulo"/>
					</h1>
                    <br /><br />
					<p align="center">
						<xsl:value-of select="./@msg"/>
					</p>
                    <br /><br />
					<p align="center">
					<div class="botonCenter">
                        <a href="javascript:window.close();">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
                        </a>
                     </div>
					</p>
			</div><!--fin divLeft-->
	</xsl:template>

</xsl:stylesheet>
