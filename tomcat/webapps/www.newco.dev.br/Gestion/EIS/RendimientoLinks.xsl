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
            <xsl:when test="/Rendimiento/LANG"><xsl:value-of select="/Rendimiento/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>         <!--idioma fin-->
      
	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='estadisticas_de_busquedas']/node()"/></title>
	 <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

      </head>
      <body class="gris">      
	    <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Rendimiento/LANG"><xsl:value-of select="/Rendimiento/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>         <!--idioma fin-->
         <!-- Titulo -->
	    <h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='informes_de_rendimiento']/node()"/></h1> 
	     
		 <div class="divleft">
            <div class="divleft35">&nbsp;</div>
            <div class="divleft30">
                <br /><br />
                <p><strong>1. <a href="Rendimiento.xsql?PERIODO=0.00064"><xsl:value-of select="document($doc)/translation/texts/item[@name='rendimiento_procesos']/node()"/> (<xsl:value-of select="document($doc)/translation/texts/item[@name='ultimo_minuto']/node()"/>)</a></strong></p>
                <br /><br />
                <p><strong>2. <a href="Rendimiento.xsql?PERIODO=0.041"><xsl:value-of select="document($doc)/translation/texts/item[@name='rendimiento_procesos']/node()"/> (<xsl:value-of select="document($doc)/translation/texts/item[@name='ultima_hora']/node()"/>)</a></strong></p>
                <br /><br />
                <p><strong>3. <a href="Rendimiento.xsql?PERIODO=1"><xsl:value-of select="document($doc)/translation/texts/item[@name='rendimiento_procesos']/node()"/> (<xsl:value-of select="document($doc)/translation/texts/item[@name='ultimo_dia']/node()"/>)</a></strong></p>
                <br /><br />
                <p><strong>4. <a href="Rendimiento.xsql?PERIODO=7"><xsl:value-of select="document($doc)/translation/texts/item[@name='rendimiento_procesos']/node()"/> (<xsl:value-of select="document($doc)/translation/texts/item[@name='ultima_semana']/node()"/>)</a></strong></p>
                <br /><br />
                <p><strong>5. <a href="Rendimiento.xsql?PERIODO=30"><xsl:value-of select="document($doc)/translation/texts/item[@name='rendimiento_procesos']/node()"/> (<xsl:value-of select="document($doc)/translation/texts/item[@name='ultimo_mes']/node()"/>)</a></strong></p>
                <br /><br />
			 </div>
         </div><!-- fin de divleft-->
         
      </body>
    </html>
  </xsl:template>  
  
  

</xsl:stylesheet>
