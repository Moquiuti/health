<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Recupera los productos para el primer paso del pedido en JSON
	Ultima revision ET 16ago21 15:00
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/Analizar">
	<xsl:param name="pPattern">"</xsl:param>
	<xsl:param name="pReplacement">\"</xsl:param>

	<xsl:text>{"Lineas":[</xsl:text>
		<xsl:for-each select="/Analizar/ANALISIS/LINEAS/LINEA_ROW">
			<!-- Evitamos la doble comilla (") en el nombre del producto
			<xsl:variable name="DescripcionLinea">
				<xsl:call-template name="string-replace-all">
					<xsl:with-param name="text" select="LLP_DESCRIPCION_LINEA"/>
					<xsl:with-param name="replace" select="$pPattern"/>
					<xsl:with-param name="by" select="$pReplacement"/>
				</xsl:call-template>
			</xsl:variable> -->

			<xsl:text>{"Contador":"</xsl:text>
				<xsl:value-of select="CONTADOR"/>
			<xsl:text>","LLP_ID":"</xsl:text>
				<xsl:value-of select="LLP_ID"/>
			<xsl:text>","DescripcionLinea":"</xsl:text>
				<xsl:value-of select="LLP_DESCRIPCION_LINEA_JS"/>
			<xsl:text>","ReferenciaLinea":"</xsl:text>
				<xsl:value-of select="PRODUCTOS/PRODUCTOS_ROW/REFERENCIACLIENTE"/><xsl:value-of select="PRODUCTOS/PRODUCTOS_ROW/REFERENCIAPRIVADA"/>
			<xsl:text>","ContieneFiltroTXT":"S"</xsl:text>
			<xsl:text>,"ContieneSeleccion":"S"</xsl:text>
			<xsl:text>,"Mostrar":"S"</xsl:text>
			<xsl:text>,"Productos":[</xsl:text>
	
			<xsl:for-each select="PRODUCTOS/PRODUCTOS_ROW">
				<xsl:text>{"PLL_ID":"</xsl:text>
					<xsl:value-of select="PLL_ID"/>
				<xsl:text>","PedidoMinimo":"</xsl:text>
					<xsl:value-of select="PEDIDO_MINIMO"/>
				<xsl:text>","Nombre":"</xsl:text>
					<xsl:value-of select="NOMBRE_JS"/>
				<xsl:text>","IDProducto":"</xsl:text>
					<xsl:value-of select="PRO_ID"/>
				<xsl:text>","Referencia":"</xsl:text>
					<xsl:value-of select="PRO_REFERENCIA"/>
				<xsl:text>","RefPrivada":"</xsl:text>
					<xsl:value-of select="REFERENCIAPRIVADA"/>
				<xsl:text>","RefCliente":"</xsl:text>
					<xsl:value-of select="REFERENCIACLIENTE"/>
				<xsl:text>","Subfamilia":"</xsl:text>
					<xsl:value-of select="SUBFAMILIA"/>
				<xsl:text>","Grupo":"</xsl:text>
					<xsl:value-of select="GRUPO"/>
				<xsl:text>","NombrePrivado":"</xsl:text>
					<xsl:value-of select="NOMBREPRIVADO_JS"/>
				<xsl:text>","Marca":"</xsl:text>
					<xsl:value-of select="MARCA_JS"/>
				<xsl:text>","UdsXLote_SinFormato":"</xsl:text>
					<xsl:value-of select="PRO_UNIDADESPORLOTE_SINFORMATO"/>
				<xsl:text>","UdsXLote":"</xsl:text>
					<xsl:value-of select="PRO_UNIDADESPORLOTE"/>
				<xsl:text>","UdBasica":"</xsl:text>
					<xsl:value-of select="PRO_UNIDADBASICA"/>
				<xsl:text>","Categoria":"</xsl:text>
					<xsl:value-of select="PRO_CATEGORIA"/>
				<xsl:text>","TipoIVA":"</xsl:text>
					<xsl:value-of select="PLL_TIPOIVA"/>
				<xsl:text>","CosteTransporte":"</xsl:text>
					<xsl:value-of select="COSTE_TRANSPORTE"/>
				<xsl:text>","IDProveedor":"</xsl:text>
					<xsl:value-of select="IDPROVEEDOR"/>
				<xsl:text>","Proveedor":"</xsl:text>
					<xsl:value-of select="PROVEEDOR"/>
				<xsl:text>","IDCentroProv":"</xsl:text>
					<xsl:value-of select="IDCENTROPROVEEDOR"/>
				<xsl:text>","CentroProv":"</xsl:text>
					<xsl:value-of select="CENTROPROVEEDOR"/>
				<xsl:text>","Cantidad":"</xsl:text>
					<xsl:value-of select="CANTIDAD"/>
				<xsl:text>","Cantidad_SinFormato":"</xsl:text>
					<xsl:value-of select="CANTIDAD_SINFORMATO"/>
				<xsl:text>","Tarifa_SinFormat":"</xsl:text>
					<xsl:value-of select="TARIFA_SINFORMATO"/>
				<xsl:text>","Tarifa":"</xsl:text>
					<xsl:value-of select="TARIFA"/>
				<xsl:text>","TarifaIVA":"</xsl:text>
					<xsl:value-of select="TARIFA_CONIVA"/>
				<xsl:text>","TarifaIVA_SinFormat":"</xsl:text>
					<xsl:value-of select="TARIFA_CONIVA_SINFORMATO"/>
				<xsl:text>","PrecioReferencia":"</xsl:text>
					<xsl:value-of select="PRECIO_REFERENCIA"/>
				<xsl:text>","DivisaPrefijo":"</xsl:text>
					<xsl:value-of select="DIV_PREFIJO"/>
				<xsl:text>","DivisaSufijo":"</xsl:text>
					<xsl:value-of select="DIV_SUFIJO"/>
				<xsl:text>","ImporteIVA":"</xsl:text>
					<xsl:value-of select="IMPORTEIVA"/>
				<xsl:text>","ImporteIVA_SinFormat":"</xsl:text>
					<xsl:value-of select="IMPORTEIVA_SINFORMATO"/>
				<xsl:text>","ComisionMVM":"</xsl:text>
					<xsl:value-of select="COMISIONMVM_CONIVA"/>
				<xsl:text>","ComisionMVM_SinFormat":"</xsl:text>
					<xsl:value-of select="COMISIONMVM_CONIVA_SINFORMATO"/>
				<xsl:text>","IDImage":"</xsl:text>
					<xsl:value-of select="IMAGENES/IMAGEN/@id"/>
				<xsl:text>","Image":"</xsl:text>
					<xsl:value-of select="IMAGENES/IMAGEN/@peq"/>
				<xsl:text>","Regulado":"</xsl:text>
					<xsl:choose><xsl:when test="REGULADO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>
				<xsl:text>","Pack":"</xsl:text>
					<xsl:choose><xsl:when test="PACK">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>
				<xsl:text>","VariacionPrecio":"</xsl:text>
					<xsl:choose><xsl:when test="CARO">Caro</xsl:when><xsl:when test="BARATO">Barato</xsl:when></xsl:choose>
				<xsl:text>","VariacionPrecioFinal":"</xsl:text>
					<xsl:choose><xsl:when test="PRECIOFINAL_CARO">Caro</xsl:when><xsl:when test="PRECIOFINAL_BARATO">Barato</xsl:when></xsl:choose>
				<xsl:text>","stringBuscador":"</xsl:text>
					<xsl:value-of select="PRO_REFERENCIA"/>,<xsl:value-of select="REFERENCIAPRIVADA"/>,<xsl:value-of select="REFERENCIACLIENTE"/>,<xsl:value-of select="NOMBREPRIVADO_JS"/>,<xsl:value-of select="MARCA_JS"/>
				<xsl:text>","IDTipoNeg":"</xsl:text>
					<xsl:value-of select="IDTIPONEGOCIACION"/>
				<xsl:text>","Bonificado":"</xsl:text>
					<xsl:choose><xsl:when test="BONIFICACION">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>
				<xsl:text>","CantBonif":"</xsl:text>
					<xsl:value-of select="BONIFICACION/TRF_BONIF_CANTIDADDECOMPRA"/>
				<xsl:text>","CantGratis":"</xsl:text>
					<xsl:value-of select="BONIFICACION/TRF_BONIF_CANTIDADGRATUITA"/>
				<xsl:text>","Orden":"</xsl:text>
					<xsl:value-of select="CP_PRO_ORDEN"/>
				<xsl:text>","Convenio":"</xsl:text>
					<xsl:choose><xsl:when test="CONVENIO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>
				<xsl:text>","Deposito":"</xsl:text>
					<xsl:choose><xsl:when test="DEPOSITO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>
				<xsl:text>"</xsl:text>

				<xsl:if test="TIPO_SIN_STOCK">
					<xsl:text>,"TipoSinStock":"</xsl:text>
						<xsl:value-of select="TIPO_SIN_STOCK"/>
					<xsl:text>","TextSinStock":"</xsl:text>
						<xsl:value-of select="TEXTO_SIN_STOCK"/>
					<xsl:text>","RefAlternativa":"</xsl:text>
						<xsl:value-of select="REFERENCIAALTERNATIVA"/>
					<xsl:text>","DescAlternativa":"</xsl:text>
						<xsl:value-of select="DESCRIPCIONALTERNATIVA"/>
					<xsl:text>"</xsl:text>
				</xsl:if>

				<xsl:choose>
				<xsl:when test="DIVISA">
					<xsl:text>,"IDDivisa":"</xsl:text>
						<xsl:value-of select="DIVISA/ID"/>
					<xsl:text>","Nombre":"</xsl:text>
						<xsl:value-of select="DIVISA/NOMBRE"/>
					<xsl:text>","PrefijoDiv":"</xsl:text>
						<xsl:value-of select="DIVISA/PREFIJO"/>
					<xsl:text>","SufijoDiv":"</xsl:text>
						<xsl:value-of select="DIVISA/SUFIJO"/>
					<xsl:text>"</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>,"IDDivisa":"0"</xsl:text>
					<xsl:text>,"PrefijoDiv":""</xsl:text>
					<xsl:text>,"SufijoDiv":""</xsl:text>
				</xsl:otherwise>
				</xsl:choose>
				
				<xsl:text>,"Mostrar":"S"</xsl:text>
				<xsl:text>,"Seleccionado":"N"</xsl:text>
				<xsl:text>,"filtroTxtBuscador":""</xsl:text>
				<xsl:text>}</xsl:text>
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
		<xsl:copy-of select="$text"/>
	</xsl:otherwise>
	</xsl:choose>

</xsl:template>

</xsl:stylesheet>
