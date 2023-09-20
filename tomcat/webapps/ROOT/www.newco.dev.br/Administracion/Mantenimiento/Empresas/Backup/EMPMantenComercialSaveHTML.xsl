<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	 <link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">	
         <script type="text/javascript" src="http://www.newco.dev.br/General/general.js"></script>	
        ]]></xsl:text>      
        <!--
         |   Lo hacemos saltar a la pagina del detalle de Empresa
         |
         +-->
        <xsl:choose>
          <xsl:when test="MantenimientoEmpresas/xsql-error">
          	<null/>
          </xsl:when>
          <xsl:otherwise>
            <meta http-equiv="Refresh">
              <xsl:attribute name="content">0; URL=http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPManten.xsql?<xsl:value-of select="MantenimientoEmpresas/ID"/></xsl:attribute></meta>
          </xsl:otherwise>
        </xsl:choose>
              
      </head>
      <body>
        <xsl:choose>
          <xsl:when test="MantenimientoEmpresas/xsql-error">
            <xsl:apply-templates select="MantenimientoEmpresas/xsql-error"/>                   
          </xsl:when>
          <xsl:otherwise>
	          <a>
	            <xsl:attribute name="href">
	              http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPManten.xsql?<xsl:value-of select="MantenimientoEmpresas/ID"/>
	            </xsl:attribute>
	            Cargando datos...
	          </a>
          </xsl:otherwise>
        </xsl:choose>       
      </body>
    </html>    
  </xsl:template>
  
</xsl:stylesheet>
