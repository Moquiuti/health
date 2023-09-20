<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.newco.dev.br/General/General.xsl" />
<xsl:output media-type="text/html" method="html"/>
<xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
	<head>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">	
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
	<script type="text/javascript">
	<!--        
        function MostrarPag(pag){
          document.location.href=pag;
        }       
        //-->
        </script>
        ]]></xsl:text>        	
	</head>
	<body bgcolor="#015E4B">
	      <SCRIPT>MostrarPag('<xsl:value-of select="Ayuda/DIRECCION"/>');</SCRIPT>
	</body>
    </html>
  </xsl:template>
  
  </xsl:stylesheet>