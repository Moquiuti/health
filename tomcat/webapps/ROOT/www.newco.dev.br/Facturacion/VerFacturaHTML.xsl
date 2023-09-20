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
        <title>Factura</title>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
        ]]></xsl:text>

        
        <STYLE>
.tituloPagForm {
	COLOR: #015e4b; FONT-FAMILY: Arial, Helvetica, Swiss, Geneva, Sans; FONT-SIZE: 14pt; FONT-WEIGHT: bold
}
.tituloForm {
	COLOR: #015e4b; FONT-SIZE: 10pt; FONT-WEIGHT: bold
}
.subTituloForm {
	COLOR: #018167; FONT-SIZE: 9pt; FONT-WEIGHT: bold
}
.textoForm {
	COLOR: #000000; FONT-SIZE: 20pt; FONT-WEIGHT: bold
}
.textoLegal {
	COLOR: #000000; FONT-SIZE: 8pt
}
.camposObligatorios { 
	COLOR: #FF0000; FONT-SIZE: 10pt; FONT-WEIGHT: bold 
}
TR {
	color: #000000; FONT-SIZE: 30pt; FONT-FAMILY: Arial, Helvetica, Swiss, Geneva, Sans; 
}
td {
	color: #000000; FONT-SIZE: 12pt; FONT-FAMILY: Arial, Helvetica, Swiss, Geneva, Sans; 
}
TR.Nombre {
	color: #015e4b; FONT-SIZE: 30pt; FONT-FAMILY: Arial, Helvetica, Swiss, Geneva, Sans; 
	FONT-WEIGHT: bold
}

</STYLE>
      </head>  
        <xsl:choose>
          <xsl:when test="//xsql-error"> 
            <xsl:apply-templates select="//xsql-error"/>
          </xsl:when>
          <xsl:otherwise>
          
           
          
	<body bgColor="#eeffff" leftMargin="0" topMargin="0" marginheight="0" marginwidth="0">
		<xsl:copy-of  select="Factura/FACTURA_HTML"/>
	</body>
  

 </xsl:otherwise>
 </xsl:choose>
 </html>
 </xsl:template>
 
 </xsl:stylesheet>