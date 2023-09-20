<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/">
<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/Producto/LANG"><xsl:value-of select="/Producto/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>

	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
	<!--idioma fin-->

	<title>
	<xsl:choose>
	<xsl:when test="/Producto/ERROR">
		<xsl:value-of select="/Producto/ERROR/@titulo"/>
	</xsl:when>
	<xsl:otherwise>
		<xsl:value-of select="document($doc)/translation/texts/item[@name='gestion_realizada']/node()"/>
	</xsl:otherwise>
	</xsl:choose>
	</title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->  

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Compras/Multioferta/BuscaProd.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

	<script type="text/javascript">
		jQuery(document).ready(globalEvents);

		function globalEvents(){
			if(window.opener != null)
				window.opener.reloadResultados();
		}
	</script>
</head>

<body class="gris">
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/Producto/LANG"><xsl:value-of select="/Producto/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<h1 class="titlePage">
	<xsl:choose>
	<xsl:when test="/Producto/ERROR">
		<xsl:value-of select="/Producto/ERROR/@titulo"/>:&nbsp;<xsl:value-of select="/Producto/ERROR/@msg"/>
	</xsl:when>
	<xsl:otherwise>
		<xsl:value-of select="document($doc)/translation/texts/item[@name='gestion_realizada']/node()"/>
	</xsl:otherwise>
	</xsl:choose>
	</h1>
	<br /><br />

<!--
	<div class="divLeft">
		<div class="divLeft40">&nbsp;</div>

		<div class="divLeft20">
			<div class="boton">
				<a href="javascript:window.close();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
				</a>
			</div>
		</div>
	</div>
-->

<!--
	si tipo=M (mantenimiento)
	si se ha hecho una busqueda volvemos a la busqueda
	si no a la lista completa

	si tipo='' (nuevo producto)
	mostramos el producto recien creado
-->
	<xsl:choose>
	<xsl:when test="/Producto/ERROR">
		<div class="divCenter20">
			<div class="boton">
				<a href="javascript:window.close();"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>
			</div>
		</div>
	</xsl:when>
	<xsl:otherwise>
		<xsl:choose>
		<xsl:when test="/Producto/PRO_ID != ''">
			<div class="divCenter20">
				<div class="boton">
					<a href="javascript:window.close();"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>
				</div>
			</div>
		</xsl:when>
		<xsl:otherwise>
			<div class="divCenter20">
				<div class="boton">
					<!--<a href="javascript:document.location='about:blank';"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>-->
                                        <a href="javascript:document.location='http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROManten.xsql';"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>
                                        
				</div>
			</div>
		</xsl:otherwise>
		</xsl:choose>

	</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>