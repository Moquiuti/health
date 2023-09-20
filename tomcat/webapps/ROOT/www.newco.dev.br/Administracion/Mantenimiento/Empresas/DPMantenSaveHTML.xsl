<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |   Almacenar una Alta de Sugerencia
 |  
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>      
        <title><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0150' and @lang=$lang]"/></title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
        <script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
        </script>
        <script type="text/javascript">
        <!--
        function tienePadre(){
             if(top.name=='MantenimientoEmpresas'){
               top.window.close();
               Refresh(top.opener.document);
               return false;
             }
             else{
                 return true; 
             }
           }
           
           //-->
         </script>
        
        ]]></xsl:text>	
      </head>
      <body>
      <xsl:choose>
           <xsl:when test="//SESION_CADUCADA">
            <xsl:for-each select="//SESION_CADUCADA">
              <xsl:if test="position()=last()">
                <xsl:apply-templates select="."/>
              </xsl:if>
            </xsl:for-each>        
          </xsl:when>
           <xsl:when test="//xsql-error">
             <xsl:apply-templates select="//xsql-error"/>        
           </xsl:when>
           <xsl:otherwise>
	        <xsl:apply-templates select="MantenimientoSave/Status"/> 
                <xsl:apply-templates select="MantenimientoSave/xsql-error"/>   
          </xsl:otherwise>
          </xsl:choose>       
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
