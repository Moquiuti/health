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
        <title>Nuevo anuncio</title>
              
        <xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css"/>
        <script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
        </script>
	<SCRIPT type="text/javascript">
	<!--
	           			
	-->
	</SCRIPT>
	]]></xsl:text>
 
        
        <STYLE>.tituloPagForm {
	COLOR: #015e4b; FONT-FAMILY: Arial, Helvetica, Swiss, Geneva, Sans; FONT-SIZE: 14pt; FONT-WEIGHT: bold
}
.tituloForm {
	COLOR: #015e4b; FONT-SIZE: 10pt; FONT-WEIGHT: bold
}
.subTituloForm {
	COLOR: #018167; FONT-SIZE: 9pt; FONT-WEIGHT: bold
}
.textoForm {
	COLOR: #000000; FONT-SIZE: 10pt; FONT-WEIGHT: bold
}
.textoLegal {
	COLOR: #000000; FONT-SIZE: 8pt
}
.camposObligatorios { COLOR: #FF0000; FONT-SIZE: 10pt; FONT-WEIGHT: bold }
</STYLE>
      </head>  
        <xsl:choose>
          <xsl:when test="//xsql-error"> 
          <P class="tituloform">     
            <xsl:apply-templates select="//xsql-error"/>
          </P>
          </xsl:when>
          <xsl:otherwise>

<!-- Cuerpo de la pagina HTML si no se ha producido ningun error -->
          
<body bgColor="#eeffff" leftMargin="0" topMargin="0" marginheight="0" marginwidth="0">
  <br/><br/><br/><br/><br/><br/><br/>
  <table width="70%" border="0" align="center">
    <tr>
      <td>
        <p align="center">El nuevo sinónimo ha sido actualizado correctamente en MedicalVM</p>
      </td>
    </tr>
    <tr align="center">
      <td>
        &nbsp;
      </td>
    </tr>
    <tr align="center">
      <td>
        <xsl:apply-templates select="NuevoSinonimo/jumpTo"/>
      </td>
    </tr>
  </table>
</body>
  

 </xsl:otherwise>
 </xsl:choose>
 </html>
 </xsl:template>
 
 </xsl:stylesheet>