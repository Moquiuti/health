<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<!--
<LINEA>1</LINEA>
<LIC_PROD_ID>17381</LIC_PROD_ID>
<LIC_PROD_IDPRODESTANDAR>292270</LIC_PROD_IDPRODESTANDAR>
<LIC_PROD_REFESTANDAR>I0050000</LIC_PROD_REFESTANDAR>
<LIC_PROD_REFCLIENTE/>
<LIC_PROD_NOMBRE>LUVA CIRURG DESCART ESTERIL N.6,5</LIC_PROD_NOMBRE>
<PROD_NOMBRENORM>LUVA CIRURG DESCART ESTERIL NZZ46ZZ6ZZ44ZZ5
</PROD_NOMBRENORM><LIC_PROD_UNIDADBASICA>1</LIC_PROD_UNIDADBASICA><LIC_PROD_FECHAALTA>12/08/16</LIC_PROD_FECHAALTA
><LIC_PROD_FECHAMODIFICACION>12/08/16</LIC_PROD_FECHAMODIFICACION><LIC_PROD_CONSUMO>0,00</LIC_PROD_CONSUMO
><LIC_PROD_CONSUMOIVA>0,00</LIC_PROD_CONSUMOIVA><LIC_PROD_CANTIDAD>0</LIC_PROD_CANTIDAD><LIC_PROD_PRECIOREFERENCIA
>1,0000</LIC_PROD_PRECIOREFERENCIA><LIC_PROD_PRECIOOBJETIVO>0,9000</LIC_PROD_PRECIOOBJETIVO><LIC_PROD_TIPOIVA
>0</LIC_PROD_TIPOIVA><LIC_PROD_INFOAMPLIADA/><LIC_PROD_INFOAMPLIADA_JS/>
<CENTRO>
<NOMBRE>Renalduc</NOMBRE>
<LIC_CC_IDCENTRO>23044</LIC_CC_IDCENTRO>
<LIC_CC_IDPRODUCTOLIC>17381</LIC_CC_IDPRODUCTOLIC>
<LIC_CC_PROVEEDOR/>
<LIC_CC_REFCLIENTE/>
<LIC_CC_PROVEEDOR/>
<LIC_CC_NOMBREPRODUCTO/>
<LIC_CC_UNIDADESPORLOTE/>
<LIC_CC_CANTIDAD>3</LIC_CC_CANTIDAD>
<UNIDADESPORLOTE_SINFORMATO/>
<CANTIDADANUAL_SINFORMATO>3</CANTIDADANUAL_SINFORMATO>
<LIC_CC_PRECIO/>
<PRECIO_SINFORMATO/>
<LIC_CC_COMPRA/>
<COMPRA_SINFORMATO/
>
-->
<xsl:template match="/Productos">

	<xsl:param name="pPattern">"</xsl:param>
	<xsl:param name="pReplacement">\"</xsl:param>

	<xsl:text>{"ListaProductos":[</xsl:text>
		<xsl:for-each select="COMPRAPORCENTRO/PRODUCTO">
			<xsl:text>{"LIC_PROD_ID":"</xsl:text>
				<xsl:value-of select="LIC_PROD_ID"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Linea":"</xsl:text>
				<xsl:value-of select="LINEA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"IDProdEstandar":"</xsl:text>
				<xsl:value-of select="LIC_PROD_IDPRODESTANDAR"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ProdRefEstandar":"</xsl:text>
				<xsl:value-of select="LIC_PROD_REFESTANDAR"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ProdRefCliente":"</xsl:text>
				<xsl:value-of select="LIC_PROD_REFCLIENTE"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ProdRefCentro":"</xsl:text>
				<xsl:value-of select="CENTRO/REFCENTRO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ProdUdBasica":"</xsl:text>
				<xsl:value-of select="LIC_PROD_UNIDADBASICA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Cantidad":"</xsl:text>
				<xsl:value-of select="CENTRO/CANTIDAD_SINFORMATO"/>
			<xsl:text>"}</xsl:text>
			<xsl:if test="position() != last()">
				<xsl:text>,</xsl:text>
			</xsl:if>
		</xsl:for-each>
	<xsl:text>]}</xsl:text>
</xsl:template>

</xsl:stylesheet>
