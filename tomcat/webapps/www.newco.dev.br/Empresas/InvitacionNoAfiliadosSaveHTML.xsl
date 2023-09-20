<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |	
 |
 |	
 |	
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
        <title>Invitación a proveedorees</title>
              
        <xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css"/>
        <script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
        </script>
	<SCRIPT type="text/javascript">
	<!--
	           			
	-->
	</SCRIPT>
	]]></xsl:text>
 
        

      </head>  
        <xsl:choose>
          <xsl:when test="//xsql-error"> 
          <P class="tituloform">     
            <xsl:apply-templates select="//xsql-error"/>
          </P>
          </xsl:when>
          <xsl:otherwise>

<!-- Cuerpo de la pagina HTML si no se ha producido ningun error -->
          
<body bgColor="#ffffff" leftMargin="0" topMargin="0" marginheight="0" marginwidth="0">
  <br/><br/><br/><br/><br/><br/><br/>
  <table width="70%" border="0" align="center">
    <tr>
      <td>
        <p class="tituloform" align="center">La invitación ha sido correctamente enviada a los proveedores
		seleccionados</p>
        <p class="tituloform" align="center">MedicalVM le agradece su confianza.</p>
      </td>
    </tr>
    <tr align="center">
      <td>
        &nbsp;
      </td>
    </tr>
    <tr align="center">
      <td>
        <!--<xsl:apply-templates select="Invitacion/jumpTo"/>-->
        <xsl:call-template name="boton">
          <xsl:with-param name="path" select="Invitacion/button[@label='Volver']"/>
        </xsl:call-template>
      </td>
    </tr>
  </table>
</body>
  

 </xsl:otherwise>
 </xsl:choose>
 </html>
 </xsl:template>
 
 </xsl:stylesheet>