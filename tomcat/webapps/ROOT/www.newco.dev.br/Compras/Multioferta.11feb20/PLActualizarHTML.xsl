<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>  
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
 
  <html>
      <head>   
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
        <script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
        </script>        
        ]]></xsl:text>	
      </head>
      <body bgcolor="#EEFFFF">  
    <xsl:choose>
       <xsl:when test="//xsql-error">
         <xsl:apply-templates select="//xsql-error"/>                        
       </xsl:when>
       <xsl:when test="//Status">         
         <xsl:choose>
           <xsl:when test="//OK">
             <script>
             
             <!-- Pendiente de unificar en el mismo proceso. -->
             
               <xsl:choose>
                 <xsl:when test="//BUSQUEDA[.='RAPIDA']">
                   document.location='http://www.newco.dev.br/Compras/NuevaMultioferta/PLLista.xsql';
		 </xsl:when>
		 <xsl:otherwise>
                document.location='http://www.newco.dev.br/Compras/Multioferta/PLLista.xsql';
                </xsl:otherwise>
               </xsl:choose>
              </script>
              <a>
                <xsl:choose>
                 <xsl:when test="//BUSQUEDA[.='RAPIDA']">
                   <xsl:attribute name="href">'http://www.newco.dev.br/Compras/NuevaMultioferta/PLLista.xsql'</xsl:attribute>
		 </xsl:when>
		 <xsl:otherwise>
                <xsl:attribute name="href">'http://www.newco.dev.br/Compras/Multioferta/PLLista.xsql'</xsl:attribute>
                </xsl:otherwise>
               </xsl:choose>
                Cargando pagina...
              </a> 
           </xsl:when>
           <xsl:otherwise>
             <xsl:apply-templates select="//Status"/>
           </xsl:otherwise>               
         </xsl:choose>                  
       </xsl:when>              
      </xsl:choose> 
     </body>   
   </html>      
</xsl:template>

</xsl:stylesheet>
