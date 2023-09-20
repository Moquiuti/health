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
            <xsl:when test="/Usuarios/LANG"><xsl:value-of select="/Usuarios/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      	        <!--idioma fin-->
       
	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='estadisticas_de_busqueda']/node()"/>&nbsp;-&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='accesos_de_usuarios']/node()"/></title>
 	  <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

      <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	  <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
      
      </head>
      <body class="gris">      
        <xsl:choose>
      	<!-- ET Desactivado control errores: Habra que reactivarlo
          <xsl:when test="ListaDerechosUsuarios/xsql-error">
            <xsl:apply-templates select="ListaDerechosUsuarios/xsql-error"/>          
          </xsl:when>
	-->
        <xsl:when test="Usuarios/ROWSET/ROW/Sorry">
          <xsl:apply-templates select="Usuarios/ROWSET/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
          <!--idioma-->
        <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Usuarios/LANG"><xsl:value-of select="/Usuarios/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      	        <!--idioma fin-->
        
       <!-- Titulo
	    <h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='accesos_de_usuarios']/node()"/></h1>  -->
        <div class="divleft">
            <div class="divleft35">&nbsp;</div>
            <div class="divleft30">
                <br /><br />
                <p><strong>1. <a href="./AccesosUsuarios.xsql"><xsl:value-of select="document($doc)/translation/texts/item[@name='accesos_de_usuarios_ultimas_48_horas']/node()"/></a></strong></p>
                <br /><br />
                <p><strong>2. <a href="./IncidenciasAccesos.xsql"><xsl:value-of select="document($doc)/translation/texts/item[@name='incidencias_accesos_usuarios']/node()"/></a></strong></p>
                <br /><br />
            </div>
         </div><!-- fin de divleft-->
        <br/><br/>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  
  
  

</xsl:stylesheet>
