<?xml version="1.0" encoding="iso-8859-1"?>
<!-- Área pública de MedicalVM -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html" encoding="iso-8859-1" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" indent="yes"/>

<xsl:template match="/">
<html xmlns="http://www.w3.org/1999/xhtml">

<!--
	Política Protección Datos (RGPD)
	20180710
	Ultima revision: 10jul18 15:43
-->

<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
	<xsl:when test="/AreaPublica/INDEXLANG != ''"><xsl:value-of select="/AreaPublica/INDEXLANG"/></xsl:when>
	<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts443_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--fin idioma-->

<!--portal-->
<xsl:variable name="portal">
	<xsl:choose>
	<xsl:when test="/AreaPublica/PORTAL != ''"><xsl:value-of select="/AreaPublica/PORTAL"/></xsl:when>
	<xsl:otherwise>MVM</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<!--portal-->

<!--login minimo-->
<xsl:variable name="reducido">
	<xsl:choose>
	<xsl:when test="/AreaPublica/REDUCIDO != ''"><xsl:value-of select="/AreaPublica/REDUCIDO"/></xsl:when>
	<xsl:otherwise>N</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<!--portal-->

<xsl:variable name="AP_Titulo">AP_<xsl:value-of select="$portal"/>_titulo</xsl:variable>
<xsl:variable name="AP_metadescr">AP_<xsl:value-of select="$portal"/>_metadescr</xsl:variable>
<xsl:variable name="AP_Portal">AP_<xsl:value-of select="$portal"/>_Portal</xsl:variable>

<xsl:variable name="AP_textocookie1">AP_<xsl:value-of select="$portal"/>_textocookie1</xsl:variable>
<xsl:variable name="AP_textocookie2">AP_<xsl:value-of select="$portal"/>_textocookie2</xsl:variable>
<xsl:variable name="AP_textocookie3">AP_<xsl:value-of select="$portal"/>_textocookie3</xsl:variable>

<xsl:variable name="AP_URL">AP_<xsl:value-of select="$portal"/>_URL</xsl:variable>
<xsl:variable name="AP_Logo">AP_<xsl:value-of select="$portal"/>_Logo</xsl:variable>
<xsl:variable name="AP_PortalLargo">AP_<xsl:value-of select="$portal"/>_PortalLargo</xsl:variable>
<xsl:variable name="AP_Dominio">AP_<xsl:value-of select="$portal"/>_Dominio</xsl:variable>

<xsl:variable name="AP_Mision">AP_<xsl:value-of select="$portal"/>_Mision</xsl:variable>
<xsl:variable name="AP_MisionTexto">AP_<xsl:value-of select="$portal"/>_MisionTexto</xsl:variable>
<xsl:variable name="AP_Vision">AP_<xsl:value-of select="$portal"/>_Vision</xsl:variable>
<xsl:variable name="AP_VisionTexto">AP_<xsl:value-of select="$portal"/>_VisionTexto</xsl:variable>
<xsl:variable name="AP_Valores">AP_<xsl:value-of select="$portal"/>_Valores</xsl:variable>
<xsl:variable name="AP_ValoresTexto">AP_<xsl:value-of select="$portal"/>_ValoresTexto</xsl:variable>


<head>

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_Titulo]/node()"/></title>
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/login_18may17.js"></script>
	<link rel="shortcut icon" href="http://www.newco.dev.br/images/MedicalVM.ico"/>
	<meta name="description" content="Medical VM es la primera plataforma para crear centrales de compras a medida.">
		<xsl:attribute name="content"><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_metadescr]/node()"/></xsl:attribute>
	</meta>
	<link rel="stylesheet" href="http://www.newco.dev.br/General/areapublica443.css" type="text/css"/>
</head>

<body>

	<div class="cabecera">
    		<div class="logo">
		<a>
			<a href="http://www.newco.dev.br/">
			<img src="http://www.newco.dev.br/images/login2017/medical-vm-logo.png" title="MedicalVM"></img>
			</a>
	<!-- 20180712
	<xsl:attribute name="href"><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_URL]/node()"/></xsl:attribute>
	<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_Portal]/node()"/></xsl:attribute>
	<img>
		<xsl:attribute name="src"><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_Logo]/node()"/></xsl:attribute>
		<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name=$AP_Portal]/node()"/></xsl:attribute>
	</img>-->
		</a>
		</div>
	</div>
    	<div class="separador" id="separador" style="display:none;"></div>


	<div class="protecion">

			<xsl:value-of select="document($doc)/translation/texts/item[@name='proteccion_datos_titulo']/node()" />

        		<!--<h1 style="float:left;margin-left:10px;clear:both;font-size:18px;"><xsl:call-template name="translate"><xsl:with-param name="text" select="'proteccion_datos_titulo'" /></xsl:call-template></h1>-->

			<xsl:copy-of select="document($doc)/translation/texts/item[@name='proteccion_datos_text']/node()" />

                	<!--<xsl:call-template name="translate"><xsl:with-param name="text" select="'proteccion_datos_text'" /></xsl:call-template>-->

    	</div>	

	<div class="pie">
		<p><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Pie1']/node()"/></p>
		<p><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_Pie2']/node()"/></p>
		<xsl:if test="$reducido != 'S'">
			<p><xsl:value-of select="document($doc)/translation/texts/item[@name='AP_DatosLegales']/node()"/></p>
		</xsl:if>
	</div>

</body>

</html>

</xsl:template>

</xsl:stylesheet>

