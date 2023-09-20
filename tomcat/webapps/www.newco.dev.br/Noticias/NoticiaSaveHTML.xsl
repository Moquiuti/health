<?xml version="1.0" encoding="iso-8859-1" ?>
<!---->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
        <title>Mantenimiento de Noticias</title>
              
      <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

         <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	
 
        
     
      </head>  
        <xsl:choose>
          <xsl:when test="//xsql-error"> 
          <P class="tituloform">     
            <xsl:apply-templates select="//xsql-error"/>
          </P>
          </xsl:when>
          <xsl:otherwise>

<!-- Cuerpo de la pagina HTML si no se ha producido ningun error -->
          
<body>
  <br/><br/><br/><br/><br/>
  <table class="infoTable">
    <tr class="tituloTabla">
      <th>
       La noticia ha sido actualizada correctamente en MedicalVM
      </th>
    </tr>
    <tr>
      <td>
        <xsl:apply-templates select="Noticia/jumpTo"/>
      </td>
    </tr>
  </table>
</body>
  

 </xsl:otherwise>
 </xsl:choose>
 </html>
 </xsl:template>
 
 </xsl:stylesheet>