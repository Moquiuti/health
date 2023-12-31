<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<!--
	COnsulta de Contrato
	Ultima revisi�n:ET 12set18 11:33
-->

<xsl:template match="/Contrato">
<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Contrato']/node()"/>:&nbsp;<xsl:value-of select="/Contrato/CONTRATO/TITULO"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript">
		var lineas = new Array;

		<xsl:for-each select="/Contrato/CONTRATO/LINEA">
			lineas[<xsl:value-of select="NUMERO"/>]='<xsl:value-of select="TEXTO" disable-output-escaping="yes"/>';<!--<xsl:copy-of select="TEXTO" disable-output-escaping="yes"/>-->
		</xsl:for-each>

		<xsl:text disable-output-escaping="yes"><![CDATA[
		
		function MostrarContrato()
		{
			
			console.log('MostrarContrato Lineas:'+lineas.length);
			
			var documento='';
			for (i=0;i<lineas.length;++i)
			{
				//solodebug	console.log('MostrarContrato Linea['+i+']:'+lineas[i]);
				documento+=lineas[i]+'<BR/>';
			}
			document.getElementById("Contenido").innerHTML+=documento;
		}
		]]></xsl:text>
		
	</script>
	
	
	
</head>
<body onLoad="javascript:MostrarContrato();">
<xsl:choose>
<xsl:when test="SESION_CADUCADA">
	<xsl:for-each select="SESION_CADUCADA">
		<xsl:if test="position()=last()">
			<xsl:apply-templates select="."/>
		</xsl:if>
	</xsl:for-each>
</xsl:when>
<xsl:when test="//xsql-error">
	<xsl:apply-templates select="//xsql-error"/>
</xsl:when>
<xsl:otherwise>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:choose>
	<xsl:when test="ERROR">
		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='error_Contrato']/node()"/></h1>
	</xsl:when>
	<xsl:otherwise>


		<!--	Espacio para incluir el documento	-->
    	<div id="Contenido">
    	</div>
	</xsl:otherwise>
	</xsl:choose><!--fin choose si contrato guardado con exito-->
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
