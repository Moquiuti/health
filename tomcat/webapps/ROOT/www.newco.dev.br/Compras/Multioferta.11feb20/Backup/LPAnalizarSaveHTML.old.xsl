<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/">
<html>
	<head>
		<!--style-->
		<xsl:call-template name="estiloIndip"/>
		<!--fin de style-->

		<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	</head>

<xsl:choose>
<xsl:when test="//SESION_CADUCADA">
	<body bgcolor="#FFFFFF">
		<xsl:apply-templates select="//SESION_CADUCADA"/>
	</body>
</xsl:when>
<xsl:when test="//xsql-error">
	<body bgcolor="#FFFFFF">
		<xsl:apply-templates select="//xsql-error"/>
	</body>
</xsl:when>
<xsl:when test="//Status">
	<body bgcolor="#FFFFFF">
		<xsl:apply-templates select="//Status"/>
	</body>
</xsl:when>
<xsl:otherwise>
	<!--
	 |	Lo hacemos saltar a la pagina de lista de productos.
	 |
	+-->
	<body bgcolor="#FFFFFF" onLoad="document.forms[0].submit(); return true;">
		<form method="POST" action="CVGenerar.xsql">
			<input type="hidden" name="LP_ID" value="{AutoSubmit/MULTIOFERTA/LP_ID}"/>
			<input type="hidden" name="FECHA_PAGO" value="{AutoSubmit/MULTIOFERTA/FECHA_PAGO}"/>
			<input type="hidden" name="FORMA_PAGO" value="{AutoSubmit/MULTIOFERTA/FORMA_PAGO}"/>
			<input type="hidden" name="COMBO_ENTREGA" value="{AutoSubmit/COMBO_ENTREGA}"/>
			<input type="hidden" name="LP_PLAZOENTREGA" value="{AutoSubmit/LP_PLAZOENTREGA}"/>
			<input type="hidden" name="FECHA_ENTREGA" value="{AutoSubmit/FECHA_ENTREGA}"/>
			<input type="hidden" name="IDPLAZOPAGO" value="{AutoSubmit/LP_IDPLAZOPAGO}"/>
			<input type="hidden" name="IDFORMAPAGO" value="{AutoSubmit/LP_IDFORMAPAGO}"/>
			<input type="hidden" name="IDCENTRO" value="{AutoSubmit/IDCENTRO}"/>
			<input type="hidden" name="IDLUGARENTREGA" value="{AutoSubmit/IDLUGARENTREGA}"/>
			<input type="hidden" name="IDCENTROCONSUMO" value="{AutoSubmit/IDCENTROCONSUMO}"/>
			<input type="hidden" name="COSTE_LOGISTICA" value="{AutoSubmit/COSTE_LOGISTICA}"/>
			<!--<input type="hidden" name="IDALMACENINTERNO" value="{AutoSubmit/IDALMACENINTERNO}"/>-->
			<input type="hidden" name="IDDIVISA"   value="{AutoSubmit/MULTIOFERTA/IDDIVISA}"/>
		</form>

		<!--idioma-->
		<xsl:variable name="lang">
			<xsl:choose>
			<xsl:when test="/AutoSubmit/LANG"><xsl:value-of select="/AutoSubmit/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
		<!--idioma fin-->

		<xsl:value-of select="document($doc)/translation/texts/item[@name='cargando_pagina']/node()"/>
	</body>
</xsl:otherwise>
</xsl:choose>
</html>
</xsl:template>
</xsl:stylesheet>