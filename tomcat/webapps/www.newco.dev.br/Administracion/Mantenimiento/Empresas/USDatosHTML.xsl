<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" /> 
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  <xsl:template match="/">  
    <html> 
      <head> 
        <title>Mantenimiento</title>
         <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
        

        </head>
 

<body class="gris">
   <xsl:choose>
     <xsl:when test="//ERROR">
       <xsl:apply-templates select="."/>
     </xsl:when>
     <xsl:otherwise>
     
     <h1 class="titlePage">Clave:&nbsp;<xsl:value-of select="//CLAVE"/>
     </h1>
     <br /><br />
      <div class="divCenter20">
              <xsl:call-template name="boton">
                <xsl:with-param name="path" select="//boton[@label='Cerrar']"/>
              </xsl:call-template>
       </div>
     </xsl:otherwise>
   </xsl:choose>
  </body>
</html>

</xsl:template>
  
<xsl:template match="ERROR">
   <h1 class="titlePage">
        <xsl:value-of select="."/>
    </h1>
    <br /><br />
      <div class="divCenter20">
          <xsl:call-template name="boton">
            <xsl:with-param name="path" select="//boton[@label='Cerrar']"/>
          </xsl:call-template>
      </div>

</xsl:template>

</xsl:stylesheet>