<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Contenido del fichero de integración
	Ultima revision: ET 19dic19 11:56
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/FicheroIntegracion">
<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/FicheroIntegracion/LANG"><xsl:value-of select="/FicheroIntegracion/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='integracion']/node()"/>:&nbsp;<xsl:value-of select="/FicheroIntegracion/FICHERO/NOMBRE"/></title>
	<xsl:call-template name="estiloIndip"/>
</head>

<body>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/Administracion/LANG"><xsl:value-of select="/Administracion/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:choose>
	<xsl:when test="/Administracion/ERROR">
		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='integracion']/node()"/></h1>
		<h2 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></h2>
	</xsl:when>
	<xsl:otherwise>

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='integracion']/node()"/></span>
			<span class="CompletarTitulo">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:<xsl:value-of select="/FicheroIntegracion/FICHERO/FECHA"/>
				&nbsp;&nbsp;ID:<xsl:value-of select="/FicheroIntegracion/FICHERO/ID"/>
			</span>
		</p>
		<p class="TituloPagina">
        	<xsl:value-of select="/FicheroIntegracion/FICHERO/NOMBRE"/>
       		&nbsp;&nbsp;
			<span class="CompletarTitulo">
				<!--	Botones	-->
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>

	<table  align="center" class="buscador">
	<xsl:for-each select="/FicheroIntegracion/FICHERO/LINEA">
	<tr class="sinLinea">
        <td style="width:100px;text-align:right;font-size:18px;">
			<strong><xsl:value-of select="NUMERO"/></strong>:
        </td>
        <td style="width:1000px;text-align:left;font-size:18px;">
			&nbsp;<xsl:value-of select="TEXTO"/>
        </td>
	</tr>
	</xsl:for-each>
	</table>
	</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
