<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 |
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/ConversacionLicitacionSave">

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="LANG != ''"><xsl:value-of select="LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--fin idioma-->

	<title>
		<xsl:choose>
		<xsl:when test="not(RESPUESTA/EMPRESA)">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='comentario']/node()"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="document($doc)/translation/texts/item[@name='conversacion_con']/node()"/>&nbsp;<xsl:value-of select="RESPUESTA/EMPRESA"/>
		</xsl:otherwise>
		</xsl:choose>
        </title>

	<xsl:call-template name="estiloIndip"/>
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
</head>

<body>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/LANG != ''"><xsl:value-of select="/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--fin idioma-->

	<h1 class="titlePage">
	<xsl:choose>
	<xsl:when test="not(RESPUESTA/EMPRESA)">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='comentario']/node()"/>
	</xsl:when>
	<xsl:otherwise>
		<xsl:value-of select="document($doc)/translation/texts/item[@name='conversacion_con']/node()"/>&nbsp;<xsl:value-of select="RESPUESTA/EMPRESA"/>
	</xsl:otherwise>
	</xsl:choose>
	</h1>
<!--
	<xsl:choose>
		<xsl:when test="ERROR">
			<div class="divLeft">
				<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></strong></p>
			</div>
		</xsl:when>
		<xsl:otherwise>
-->
			<div class="middle" style="padding-top:20px;">
				<xsl:choose>
				<xsl:when test="RESPUESTA/OK">
					<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='comentario_licitacion_guardado']/node()"/></strong></p>
				</xsl:when>
				<xsl:otherwise>
					<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='comentario_licitacion_error']/node()"/></strong></p>
				</xsl:otherwise>
				</xsl:choose>
			</div>
<!--
		</xsl:otherwise>
	</xsl:choose>
-->
</body>
</html>
</xsl:template>
</xsl:stylesheet>