<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Ficha de empresa, montada como Frame
	Ultima revision: ET 19dic19 09:54
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/Empresa">

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

	<title><xsl:value-of select="/Empresas/EMPRESA/EMP_NOMBRECORTOPUBLICO"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='detalle_empresa']/node()"/></title> 
</head>

<xsl:choose>
<xsl:when test="//xsql-error">
	<xsl:apply-templates select="//xsql-error"/>
	<body>
		<br/><br/>
		<center><xsl:apply-templates select="//jumpTo"/></center>
	</body>
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
 
	<frameset rows="100%,*" frameborder="NO" border="0" framespacing="0">
		<frame src="UntitledFrame-1" name="CABECERA" frameborder="0" scrolling="auto" noresize="noresize">
			<xsl:attribute name="src">EMPDetalle.xsql?EMP_ID=<xsl:value-of select="EMP_ID"/>&amp;ESTADO=CABECERA&amp;VENTANA=<xsl:value-of select="VENTANA"/></xsl:attribute>
		</frame>
		<frame src="UntitledFrame-2"></frame>
	</frameset>

	<noframes>
		<body>
			<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar_navegador']/node()"/>
		</body>
	</noframes>
</xsl:otherwise>
</xsl:choose>
</html>
</xsl:template>
</xsl:stylesheet>
