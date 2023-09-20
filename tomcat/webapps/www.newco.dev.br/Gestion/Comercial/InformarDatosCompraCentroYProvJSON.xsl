<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Guarda la cantidad de compra de un centro y un proveedor para un producto de la licitacion
	Ultima revision: ET 7abr21 12:00
+-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/InformaDatosCompra">

	<xsl:text>{"OfertaActualizada":</xsl:text>
		<xsl:text>{"Estado":"</xsl:text>
			<xsl:value-of select="COMPRACENTRO/ESTADO"/>
		<xsl:text>"}</xsl:text>
	<xsl:text>}</xsl:text>
</xsl:template>
</xsl:stylesheet>
