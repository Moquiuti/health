<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/Productos">

    	<xsl:param name="pPattern">"</xsl:param>
	<xsl:param name="pReplacement">\"</xsl:param>

	<xsl:text>{"IDPais":"</xsl:text>
		<xsl:value-of select="PRODUCTOSLICITACION/IDPAIS"/>
	<xsl:text>",</xsl:text>
	<xsl:text>"TotalAdjudicado":"</xsl:text>
		<xsl:value-of select="PRODUCTOSLICITACION/TOTAL_ADJUDICADO"/>
	<xsl:text>",</xsl:text>
	<xsl:text>"TotalAdjudicadoIVA":"</xsl:text>
		<xsl:value-of select="PRODUCTOSLICITACION/TOTAL_ADJUDICADOIVA"/>
	<xsl:text>",</xsl:text>
	<xsl:text>"TotalProductos":"</xsl:text>
		<xsl:value-of select="PRODUCTOSLICITACION/TOTAL_PRODUCTOS"/>
	<xsl:text>",</xsl:text>
	<xsl:text>"TotalSeleccionados":"</xsl:text>
		<xsl:value-of select="PRODUCTOSLICITACION/TOTAL_SELECCIONADAS"/>
	<xsl:text>",</xsl:text>
	<xsl:text>"Ahorro":"</xsl:text>
		<xsl:value-of select="PRODUCTOSLICITACION/AHORRO"/>
	<xsl:text>",</xsl:text>

	<xsl:text>"ListaProveedores":[</xsl:text>
		<xsl:for-each select="PRODUCTOSLICITACION/PROVEEDORESLICITACION/PROVEEDOR">
			<!-- Evitamos la doble comilla (") en el nombre de proveedor -->
			<xsl:variable name="NombreProveedor">
				<xsl:call-template name="string-replace-all">
					<xsl:with-param name="text" select="NOMBRE"/>
					<xsl:with-param name="replace" select="$pPattern"/>
					<xsl:with-param name="by" select="$pReplacement"/>
				</xsl:call-template>
			</xsl:variable>
			<!-- Evitamos la doble comilla (") en el nombre corto de proveedor -->
			<xsl:variable name="NombreCortoProv">
				<xsl:call-template name="string-replace-all">
					<xsl:with-param name="text" select="NOMBRECORTO"/>
					<xsl:with-param name="replace" select="$pPattern"/>
					<xsl:with-param name="by" select="$pReplacement"/>
				</xsl:call-template>
			</xsl:variable>
			<!-- Evitamos la doble comilla (") en los comentarios del proveedor -->
			<xsl:variable name="CommsProv">
				<xsl:call-template name="string-replace-all">
					<xsl:with-param name="text" select="LIC_PROV_COMENTARIOSPROV"/>
					<xsl:with-param name="replace" select="$pPattern"/>
					<xsl:with-param name="by" select="$pReplacement"/>
				</xsl:call-template>
			</xsl:variable>
			<!-- Evitamos la doble comilla (") en los comentarios de la CdC -->
			<xsl:variable name="CommsCdC">
				<xsl:call-template name="string-replace-all">
					<xsl:with-param name="text" select="LIC_PROV_COMENTARIOSCDC"/>
					<xsl:with-param name="replace" select="$pPattern"/>
					<xsl:with-param name="by" select="$pReplacement"/>
				</xsl:call-template>
			</xsl:variable>


			<xsl:text>{"IDPROVEEDOR_LIC":"</xsl:text>
				<xsl:value-of select="IDPROVEEDOR_LIC"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Columna":"</xsl:text>
				<xsl:value-of select="COLUMNA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"IDProveedor":"</xsl:text>
				<xsl:value-of select="IDPROVEEDOR"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Nombre":"</xsl:text>
				<xsl:value-of select="$NombreProveedor"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"NombreCorto":"</xsl:text>
				<xsl:value-of select="$NombreCortoProv"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"FechaAlta":"</xsl:text>
				<xsl:value-of select="LIC_PROV_FECHAALTA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"FechaOferta":"</xsl:text>
				<xsl:value-of select="LIC_PROV_FECHAOFERTA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"IDEstadoProv":"</xsl:text>
				<xsl:value-of select="LIC_PROV_IDESTADO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"EstadoEval":"</xsl:text>
				<xsl:value-of select="ESTADOEVALUACION"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ComentariosProv":"</xsl:text>
				<xsl:value-of select="$CommsProv"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ComentariosCDC":"</xsl:text>
				<xsl:value-of select="$CommsCdC"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"IDEstadoEval":"</xsl:text>
				<xsl:value-of select="LIC_PROV_IDESTADOEVALUACION"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"PedidoMinimo":"</xsl:text>
				<xsl:value-of select="LIC_PROV_PEDIDOMINIMO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Consumo":"</xsl:text>
				<xsl:value-of select="LIC_PROV_CONSUMO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ConsumoIVA":"</xsl:text>
				<xsl:value-of select="LIC_PROV_CONSUMOIVA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ConsumoPotencial":"</xsl:text>
				<xsl:value-of select="LIC_PROV_CONSUMOPOTENCIAL"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ConsumoPotencialIVA":"</xsl:text>
				<xsl:value-of select="LIC_PROV_CONSUMOPOTENCIALIVA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ConsumoAdjudicado":"</xsl:text>
				<xsl:value-of select="LIC_PROV_CONSUMOADJUDICADO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ConsumoAdjudicadoIVA":"</xsl:text>
				<xsl:value-of select="LIC_PROV_CONSUMOADJUDICADOIVA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Ahorro":"</xsl:text>
				<xsl:value-of select="LIC_PROV_AHORRO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"AhorroIVA":"</xsl:text>
				<xsl:value-of select="LIC_PROV_AHORROIVA"/>
			<xsl:text>"}</xsl:text>
			<xsl:if test="position() != last()">
				<xsl:text>,</xsl:text>
			</xsl:if>
		</xsl:for-each>
	<xsl:text>],</xsl:text>
	<xsl:text>"ListaProductos":[</xsl:text>
		<xsl:for-each select="PRODUCTOSLICITACION/PRODUCTO">
			<!-- Evitamos la doble comilla (") en el nombre de producto -->
			<xsl:variable name="NombreProducto">
				<xsl:call-template name="string-replace-all">
					<xsl:with-param name="text" select="LIC_PROD_NOMBRE"/>
					<xsl:with-param name="replace" select="$pPattern"/>
					<xsl:with-param name="by" select="$pReplacement"/>
				</xsl:call-template>
			</xsl:variable>


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
			<xsl:text>"ProdNombre":"</xsl:text>
				<xsl:value-of select="$NombreProducto"/>
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
			<xsl:text>"ConsumoHist":"</xsl:text>
				<xsl:value-of select="LIC_PROD_CONSUMOHISTORICO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ConsumoHistIVA":"</xsl:text>
				<xsl:value-of select="LIC_PROD_CONSUMOHISTORICOIVA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Cantidad":"</xsl:text>
				<xsl:value-of select="LIC_PROD_CANTIDAD"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"PrecioReferencia":"</xsl:text>
				<xsl:value-of select="LIC_PROD_PRECIOREFERENCIA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"PrecioReferenciaIVA":"</xsl:text>
				<xsl:value-of select="LIC_PROD_PRECIOREFERENCIAIVA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"PrecioObjetivo":"</xsl:text>
				<xsl:value-of select="LIC_PROD_PRECIOOBJETIVO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"PrecioObjetivoIVA":"</xsl:text>
				<xsl:value-of select="LIC_PROD_PRECIOOBJETIVOIVA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"TipoIVA":"</xsl:text>
				<xsl:value-of select="LIC_PROD_TIPOIVA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"NumOfertas":"</xsl:text>
				<xsl:value-of select="NUMERO_OFERTAS"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"TieneSeleccion":"</xsl:text>
				<xsl:value-of select="TIENE_SELECCION"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Validado":"</xsl:text>
				<xsl:choose><xsl:when test="VALIDADO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>
			<xsl:text>",</xsl:text>
			<xsl:text>"NoAdjudicado":"</xsl:text>
				<xsl:choose><xsl:when test="NO_ADJUDICADO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>
			<xsl:text>",</xsl:text>

			<xsl:text>"Ofertas":[</xsl:text>
				<xsl:for-each select="OFERTA">
					<!-- Evitamos la doble comilla (") en el nombre de producto de la oferta -->
					<xsl:variable name="NombreProductoOferta">
						<xsl:call-template name="string-replace-all">
							<xsl:with-param name="text" select="LIC_OFE_NOMBRE"/>
							<xsl:with-param name="replace" select="$pPattern"/>
							<xsl:with-param name="by" select="$pReplacement"/>
						</xsl:call-template>
					</xsl:variable>
					<!-- Evitamos la doble comilla (") en la marca -->
					<xsl:variable name="MarcaProducto">
						<xsl:call-template name="string-replace-all">
							<xsl:with-param name="text" select="LIC_OFE_MARCA"/>
							<xsl:with-param name="replace" select="$pPattern"/>
							<xsl:with-param name="by" select="$pReplacement"/>
						</xsl:call-template>
					</xsl:variable>

					<xsl:text>{"NoInformada":"</xsl:text>
						<xsl:choose>
						<xsl:when test="NO_INFORMADA">
							<xsl:text>S</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>N</xsl:text>
						</xsl:otherwise>
						</xsl:choose>
					<xsl:text>",</xsl:text>

					<xsl:text>"Columna":"</xsl:text>
						<xsl:value-of select="COLUMNA"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"LIC_OFE_ID":"</xsl:text>
						<xsl:value-of select="LIC_OFE_ID"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"LIC_OFE_IDPROVEEDORLIC":"</xsl:text>
						<xsl:value-of select="LIC_OFE_IDPROVEEDORLIC"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"LIC_OFE_IDPRODUCTO":"</xsl:text>
						<xsl:value-of select="LIC_OFE_IDPRODUCTO"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"Referencia":"</xsl:text>
						<xsl:value-of select="LIC_OFE_REFERENCIA"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"Nombre":"</xsl:text>
						<xsl:value-of select="$NombreProductoOferta"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"Marca":"</xsl:text>
						<xsl:value-of select="$MarcaProducto"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"FechaAlta":"</xsl:text>
						<xsl:value-of select="LIC_OFE_FECHAALTA"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"FechaModificacion":"</xsl:text>
						<xsl:value-of select="LIC_OFE_FECHAMODIFICACION"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"UnidadesLote":"</xsl:text>
						<xsl:value-of select="LIC_OFE_UNIDADESPORLOTE"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"Cantidad":"</xsl:text>
						<xsl:value-of select="LIC_OFE_CANTIDAD"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"Precio":"</xsl:text>
						<xsl:value-of select="LIC_OFE_PRECIO"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"PrecioIVA":"</xsl:text>
						<xsl:value-of select="LIC_OFE_PRECIOIVA"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"ColorPrecio":"</xsl:text>
						<xsl:choose>
						<xsl:when test="IGUAL">
							<xsl:text>Naranja</xsl:text>
						</xsl:when>
						<xsl:when test="SUPERIOR">
							<xsl:text>Rojo</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>Verde</xsl:text>
						</xsl:otherwise>
						</xsl:choose>
					<xsl:text>",</xsl:text>
					<xsl:text>"TipoIVA":"</xsl:text>
						<xsl:value-of select="LIC_OFE_TIPOIVA"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"Consumo":"</xsl:text>
						<xsl:value-of select="LIC_OFE_CONSUMO"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"ConsumoIVA":"</xsl:text>
						<xsl:value-of select="LIC_OFE_CONSUMOIVA"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"IDEstadoEvaluacion":"</xsl:text>
						<xsl:value-of select="LIC_OFE_IDESTADOEVALUACION"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"EstadoEvaluacion":"</xsl:text>
						<xsl:value-of select="ESTADOEVALUACION"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"Ahorro":"</xsl:text>
						<xsl:value-of select="LIC_OFE_AHORRO"/>
					<xsl:text>",</xsl:text>
					<xsl:text>"OfertaAdjudicada":"</xsl:text>
						<xsl:choose>
						<xsl:when test="OFERTA_ADJUDICADA">S</xsl:when>
						<xsl:otherwise>N</xsl:otherwise>
						</xsl:choose>
					<xsl:text>",</xsl:text>
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
					<xsl:text>}}</xsl:text>
					<xsl:if test="position() != last()">
						<xsl:text>,</xsl:text>
					</xsl:if>
				</xsl:for-each>
			<xsl:text>]}</xsl:text>
			<xsl:if test="position() != last()">
				<xsl:text>,</xsl:text>
			</xsl:if>
		</xsl:for-each>
	<xsl:text>]}</xsl:text>
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
		<xsl:value-of select="$text"/>
	</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>