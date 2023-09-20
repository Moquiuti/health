<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Recupera las ofertas de un proveedor en JSON
	Ultima revision ET 6feb23 16:33
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/ProductosOfertas">
<!--
	<xsl:param name="pPattern">"</xsl:param>
	<xsl:param name="pReplacement">\"</xsl:param>
-->
	<xsl:text>{"IDPais":"</xsl:text>
		<xsl:value-of select="PRODUCTOSLICITACION/IDPAIS"/>
	<xsl:text>",</xsl:text>
	<xsl:text>"ProductosLicitacion":</xsl:text>
	        <xsl:text>{"LIC_PROV_ID":"</xsl:text>
			<xsl:value-of select="PRODUCTOSLICITACION/LIC_PROV_ID"/>
		<xsl:text>",</xsl:text>
		<xsl:text>"LIC_PROV_IDProveedor":"</xsl:text>
			<xsl:value-of select="PRODUCTOSLICITACION/LIC_PROV_IDPROVEEDOR"/>
		<xsl:text>",</xsl:text>
		<xsl:text>"LIC_PROV_IDEstado":"</xsl:text>
			<xsl:value-of select="PRODUCTOSLICITACION/LIC_PROV_IDESTADO"/>
		<xsl:text>",</xsl:text>
		<xsl:text>"ListaProductosOfertas":[</xsl:text>
			<xsl:for-each select="PRODUCTOSLICITACION/PRODUCTO">
				<xsl:text>{"LIC_PROD_ID":"</xsl:text>
					<xsl:value-of select="LIC_PROD_ID"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"Linea":"</xsl:text>
					<xsl:value-of select="LINEA"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"Alternativa":"</xsl:text>
					<xsl:value-of select="LIC_OFE_ALTERNATIVA"/>
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
				<xsl:text>"ProdNombre":"</xsl:text>
					<xsl:value-of select="LIC_PROD_NOMBRE_JS"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"ProdNombreNorm":"</xsl:text>
					<xsl:value-of select="PROD_NOMBRENORM"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"ProdUdBasica":"</xsl:text>
					<xsl:value-of select="LIC_PROD_UNIDADBASICA"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"FechaAlta":"</xsl:text>
					<xsl:value-of select="LIC_PROD_FECHAALTA"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"FechaModificacion":"</xsl:text>
					<xsl:value-of select="LIC_PROD_FECHAMODIFICACION"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"Consumo":"</xsl:text>
					<xsl:value-of select="LIC_PROD_CONSUMO"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"ConsumoIVA":"</xsl:text>
					<xsl:value-of select="LIC_PROD_CONSUMOIVA"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"Cantidad":"</xsl:text>
					<xsl:value-of select="LIC_PROD_CANTIDAD"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"PrecioReferencia":"</xsl:text>
					<xsl:value-of select="LIC_PROD_PRECIOREFERENCIA"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"PrecioObjetivo":"</xsl:text>
					<xsl:value-of select="LIC_PROD_PRECIOOBJETIVO"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"TipoIVA":"</xsl:text>
					<xsl:value-of select="LIC_PROD_TIPOIVA"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"PrecioMin":"</xsl:text>
					<xsl:value-of select="PRECIOMIN"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"PrecioMax":"</xsl:text>
					<xsl:value-of select="PRECIOMAX"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"NumAlternativas":"</xsl:text>
					<xsl:value-of select="NUMALTERNATIVAS"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"NumOfertas":"</xsl:text>
					<xsl:value-of select="LIC_PROD_NUMEROOFERTAS"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"Marcas":"</xsl:text>
					<xsl:value-of select="LIC_PROD_MARCASACEPTABLES"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"PrincActivo":"</xsl:text>
					<xsl:value-of select="LIC_PROD_PRINCIPIOACTIVO"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"OfertaAnterior":"</xsl:text>
					<xsl:choose><xsl:when test="OFERTA_ANTERIOR">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>
				<xsl:text>",</xsl:text>
				<xsl:text>"ForzarCaja":"</xsl:text>
					<xsl:choose><xsl:when test="FORZAR_CAJA">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>
				<xsl:text>",</xsl:text>

				<!-- Campos avanzados producto -->
				<xsl:text>"InfoAmpliada":"</xsl:text>
					<xsl:value-of select="LIC_PROD_INFOAMPLIADA_JS"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"Documento":{</xsl:text>
					<xsl:text>"ID":"</xsl:text>
						<xsl:value-of select="DOCUMENTOPRODUCTO/ID"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"Nombre":"</xsl:text>
						<xsl:value-of select="DOCUMENTOPRODUCTO/NOMBRE"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"Descripcion":"</xsl:text>
						<xsl:value-of select="DOCUMENTOPRODUCTO/DESCRIPCION"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"Url":"</xsl:text>
						<xsl:value-of select="DOCUMENTOPRODUCTO/URL"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"Fecha":"</xsl:text>
						<xsl:value-of select="DOCUMENTOPRODUCTO/FECHA"/>
					<xsl:text>"</xsl:text>
				<xsl:text>},</xsl:text>
				<!-- FIN Campos avanzados producto -->

				<!-- Ofertas Proveedor -->
				<xsl:text>"IDOferta":"</xsl:text>
					<xsl:value-of select="LIC_OFE_ID"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"LIC_PROV_ID":"</xsl:text>
					<xsl:value-of select="LIC_OFE_IDPROVEEDORLIC"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"IDProductoOfe":"</xsl:text>
					<xsl:value-of select="LIC_OFE_IDPRODUCTO"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"RefOfe":"</xsl:text>
					<xsl:value-of select="LIC_OFE_REFERENCIA"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"NombreOfe":"</xsl:text>
					<xsl:value-of select="LIC_OFE_NOMBRE_JS"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"MarcaOfe":"</xsl:text>
					<xsl:value-of select="LIC_OFE_MARCA_JS"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"FechaAltaOfe":"</xsl:text>
					<xsl:value-of select="LIC_OFE_FECHAALTA"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"FechaModificacionOfe":"</xsl:text>
					<xsl:value-of select="LIC_OFE_FECHAMODIFICACION"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"UdsXLoteOfe":"</xsl:text>
					<xsl:value-of select="LIC_OFE_UNIDADESPORLOTE"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"CantidadOfe":"</xsl:text>
					<xsl:value-of select="LIC_OFE_CANTIDAD"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"PrecioOfe":"</xsl:text>
					<xsl:value-of select="LIC_OFE_PRECIO"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"Color":"</xsl:text>
					<xsl:value-of select="COLOR"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"TipoIVAOfe":"</xsl:text>
					<xsl:value-of select="LIC_OFE_TIPOIVA"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"ConsumoOfe":"</xsl:text>
					<xsl:value-of select="LIC_OFE_CONSUMO"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"ConsumoIVAOfe":"</xsl:text>
					<xsl:value-of select="LIC_OFE_CONSUMOIVA"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"Adjudicada":"</xsl:text>
					<xsl:value-of select="LIC_OFE_ADJUDICADA"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"CantidadAdjudicada":"</xsl:text>
					<xsl:value-of select="LIC_OFE_CANTIDADADJUDICADA"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"Orden":"</xsl:text>
					<xsl:value-of select="LIC_OFE_ORDEN"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"IDEstadoEvaluacionOfe":"</xsl:text>
					<xsl:value-of select="LIC_OFE_IDESTADOEVALUACION"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"EstadoEvaluacionOfe":"</xsl:text>
					<xsl:value-of select="ESTADOEVALUACION"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"RegistroSanitario":"</xsl:text>
					<xsl:value-of select="LIC_OFE_REGISTROSANITARIO"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"Informada":"</xsl:text>
					<xsl:choose><xsl:when test="INFORMADA">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>
				<xsl:text>", "REGISTROSANITARIO":"</xsl:text>					<!--	Nuevos campos 6feb23	-->
					<xsl:value-of select="LIC_OFE_REGISTROSANITARIO"/>
				<xsl:text>", "CODEXPEDIENTE":"</xsl:text>
					<xsl:value-of select="LIC_OFE_CODEXPEDIENTE"/>
				<xsl:text>", "CODCUM":"</xsl:text>
					<xsl:value-of select="LIC_OFE_CODCUM"/>
				<xsl:text>", "CODIUM":"</xsl:text>
					<xsl:value-of select="LIC_OFE_CODIUM"/>
				<xsl:text>", "CODINVIMA":"</xsl:text>
					<xsl:value-of select="LIC_OFE_CODINVIMA"/>
				<xsl:text>", "FECHACADINVIMA":"</xsl:text>
					<xsl:value-of select="LIC_OFE_FECHACADINVIMA"/>
				<xsl:text>", "CLASIFICACIONRIESGO":"</xsl:text>
					<xsl:value-of select="LIC_OFE_CLASIFICACIONRIESGO"/>				<!--	Nuevos campos 6feb23	-->
				<!-- Campos avanzados ofertas -->
				<xsl:text>", "InfoAmpliadaOferta":"</xsl:text>
					<xsl:value-of select="LIC_OFE_INFOAMPLIADA_JS"/>
				<xsl:text>",</xsl:text>

				<xsl:text>"DocumentoOferta":{</xsl:text>
					<xsl:text>"ID":"</xsl:text>
						<xsl:value-of select="DOCUMENTOOFERTA/ID"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"Nombre":"</xsl:text>
						<xsl:value-of select="DOCUMENTOOFERTA/NOMBRE"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"Descripcion":"</xsl:text>
						<xsl:value-of select="DOCUMENTOOFERTA/DESCRIPCION"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"Url":"</xsl:text>
						<xsl:value-of select="DOCUMENTOOFERTA/URL"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"Fecha":"</xsl:text>
						<xsl:value-of select="DOCUMENTOOFERTA/FECHA"/>
					<xsl:text>"</xsl:text>
				<xsl:text>},</xsl:text>
				<!-- FIN Campos avanzados ofertas -->

				<xsl:text>"FichaTecnica":{</xsl:text>
					<xsl:text>"ID":"</xsl:text>
						<xsl:value-of select="FICHA_TECNICA/ID"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"Nombre":"</xsl:text>
						<xsl:value-of select="FICHA_TECNICA/NOMBRE"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"Descripcion":"</xsl:text>
						<xsl:value-of select="FICHA_TECNICA/DESCRIPCION"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"Fichero":"</xsl:text>
						<xsl:value-of select="FICHA_TECNICA/URL"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"Fecha":"</xsl:text>
						<xsl:value-of select="FICHA_TECNICA/FECHA"/>
					<xsl:text>"</xsl:text>
				<xsl:text>},</xsl:text>

				<xsl:text>"RegSanitario":{</xsl:text>
					<xsl:text>"ID":"</xsl:text>
						<xsl:value-of select="REGISTRO_SANITARIO/ID"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"Nombre":"</xsl:text>
						<xsl:value-of select="REGISTRO_SANITARIO/NOMBRE"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"Descripcion":"</xsl:text>
						<xsl:value-of select="REGISTRO_SANITARIO/DESCRIPCION"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"Fichero":"</xsl:text>
						<xsl:value-of select="REGISTRO_SANITARIO/URL"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"Fecha":"</xsl:text>
						<xsl:value-of select="REGISTRO_SANITARIO/FECHA"/>
					<xsl:text>"</xsl:text>
				<xsl:text>},</xsl:text>
				<xsl:text>"CertExperiencia":{</xsl:text>
					<xsl:text>"ID":"</xsl:text>
						<xsl:value-of select="CERTIFICADO_EXPERIENCIA/ID"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"Nombre":"</xsl:text>
						<xsl:value-of select="CERTIFICADO_EXPERIENCIA/NOMBRE"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"Descripcion":"</xsl:text>
						<xsl:value-of select="CERTIFICADO_EXPERIENCIA/DESCRIPCION"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"Fichero":"</xsl:text>
						<xsl:value-of select="CERTIFICADO_EXPERIENCIA/URL"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"Fecha":"</xsl:text>
						<xsl:value-of select="CERTIFICADO_EXPERIENCIA/FECHA"/>
					<xsl:text>"</xsl:text>
				<xsl:text>}}</xsl:text>

				<xsl:if test="position() != last()">
					<xsl:text>,</xsl:text>
				</xsl:if>
			</xsl:for-each>
		<xsl:text>]}</xsl:text>
	<xsl:text>}</xsl:text>
</xsl:template>

<xsl:template name="string-replace-all">
	<xsl:param name="text"/>
	<xsl:param name="replace"/>
	<xsl:param name="by"/>

	<xsl:choose>
	<xsl:when test="contains($text, $replace)">
		<xsl:value-of select="substring-before($text,$replace)"/>
		<xsl:value-of select="$by"/>
                
		<xsl:call-template name="string-replace-all">
			<xsl:with-param name="text" select="substring-after($text,$replace)"/>
			<xsl:with-param name="replace" select="$replace"/>
			<xsl:with-param name="by" select="$by"/>
		</xsl:call-template>
	</xsl:when>
	<xsl:otherwise>
		<xsl:copy-of select="$text"/>
	</xsl:otherwise>
	</xsl:choose>

</xsl:template>

</xsl:stylesheet>
