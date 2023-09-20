<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>  
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">

  
  <html>
    <xsl:choose>
       <xsl:when test="//SESION_CADUCADA">
         <head>
	 <xsl:text disable-output-escaping="yes"><![CDATA[
	 <link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
	 <script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
        </script>
         ]]></xsl:text>         
         </head>
         <body bgcolor="#FFFFFF">
         <xsl:apply-templates select="//SESION_CADUCADA"/>
         </body>
       </xsl:when>
       <xsl:when test="//xsql-error">
         <head>
	 <xsl:text disable-output-escaping="yes"><![CDATA[
	 <link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
	 <script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
        </script>
         ]]></xsl:text>         
         </head>
         <body bgcolor="#FFFFFF">
         <xsl:apply-templates select="//xsql-error"/>
         </body>
       </xsl:when>
       <xsl:when test="//Status">
         <head>
	 <xsl:text disable-output-escaping="yes"><![CDATA[
	 <link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
	 <script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
        </script>
         ]]></xsl:text>         
         </head>
         <body bgcolor="#FFFFFF">
         <xsl:apply-templates select="//Status"/>
         </body>
       </xsl:when>            
      <xsl:otherwise>
      <head>
        <!--
         |   Lo hacemos saltar a la pagina de lista de productos.
         |
         +-->
          <xsl:text disable-output-escaping="yes"><![CDATA[
	 <link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
	 <script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
        </script>
        <script type="text/javascript">
          <!--
            
            function lanzarBusqueda(){
              var objFrame=new Object();
              objFrame=obtenerFrame(top,'Cabecera');
              
              objFrame.Busqueda(objFrame.document.forms[0]);
              
            }
            
          //-->
        </script>
        
         ]]></xsl:text>    

      </head>
      <body bgcolor="#FFFFFF" onLoad="lanzarBusqueda();">     
     </body>
      </xsl:otherwise>
    </xsl:choose>
  </html>    
</xsl:template>
 
</xsl:stylesheet>
