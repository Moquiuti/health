<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Recupera en formato JSON la info de los proveedores de la licitacion
	Ultima revision: ET 13ene20 14:30
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/Proveedores">

	<xsl:param name="pPattern">"</xsl:param>
	<xsl:param name="pReplacement">\"</xsl:param>

	<xsl:text>{"US_ID":"</xsl:text>
		<xsl:value-of select="US_ID"/>
	<xsl:text>",</xsl:text>
	<xsl:text>"mejorPrecio":"</xsl:text>
		<xsl:value-of select="PROVEEDORESLICITACION/MEJORPRECIO"/>
	<xsl:text>","ListaProveedores":[</xsl:text>
		<xsl:for-each select="PROVEEDORESLICITACION/PROVEEDOR">
			<!-- Evitamos la doble comilla (") en el nombre de proveedor -->
			<xsl:variable name="NombreProv">
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

			<xsl:text>{"Linea":"</xsl:text>
				<xsl:value-of select="ORDEN"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ID":"</xsl:text>
				<xsl:value-of select="IDPROVEEDOR"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"IDPROVEEDOR_LIC":"</xsl:text>
				<xsl:value-of select="IDPROVEEDOR_LIC"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Nombre":"</xsl:text>
				<xsl:value-of select="$NombreProv"/>
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
			<xsl:text>"EstadoProv":"</xsl:text>
				<xsl:value-of select="ESTADOLICITACION"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"EstadoEvaluacion":"</xsl:text>
				<xsl:value-of select="ESTADOEVALUACION"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ComentariosProv":"</xsl:text>
				<xsl:copy-of select="LIC_PROV_COMENTARIOSPROV_JS/node()"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ComentariosCdC":"</xsl:text>
				<xsl:copy-of select="LIC_PROV_COMENTARIOSCDC_JS/node()"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"IDEstadoEvaluacion":"</xsl:text>
				<xsl:value-of select="LIC_PROV_IDESTADOEVALUACION"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ConsumoProv":"</xsl:text>
				<xsl:value-of select="LIC_PROV_CONSUMO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ConsumoProvIVA":"</xsl:text>
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
			<xsl:text>",</xsl:text>
			<xsl:text>"OfertasVacias":"</xsl:text>
				<xsl:value-of select="LIC_PROV_OFERTASVACIAS"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"PedidoMin":"</xsl:text>
				<xsl:value-of select="LIC_PROV_PEDIDOMINIMO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"NumeroLineas":"</xsl:text>
				<xsl:value-of select="LIC_PROV_NUMEROLINEAS"/>
			<xsl:text>",</xsl:text>

			<xsl:text>"Frete":"</xsl:text>
				<xsl:value-of select="LIC_PROV_FRETE"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"PlazoEntrega":"</xsl:text>
				<xsl:value-of select="LIC_PROV_PLAZOENTREGA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"OfertasConAhorro":"</xsl:text>
				<xsl:value-of select="LIC_PROV_OFERTASCONAHORRO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"OfertasConMejorPrecio":"</xsl:text>
				<xsl:value-of select="LIC_PROV_OFERTASCONMEJORPRECIO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ConsConMejorPrecio":"</xsl:text>
				<xsl:value-of select="LIC_PROV_CONSUMOCONMEJORPRECIO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ConsConMejorPrecioIVA":"</xsl:text>
				<xsl:value-of select="LIC_PROV_CONSCONMEJORPRECIOIVA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"AhorroEnMejorPrecio":"</xsl:text>
				<xsl:value-of select="LIC_PROV_AHORROENMEJORPRECIO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ConsConAhorro":"</xsl:text>
				<xsl:value-of select="LIC_PROV_CONSUMOCONAHORRO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ConsConAhorroIVA":"</xsl:text>
				<xsl:value-of select="LIC_PROV_CONSUMOCONAHORROIVA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"AhorroOfeConAhorro":"</xsl:text>
				<xsl:value-of select="LIC_PROV_AHORROOFECONAHORRO"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"OfertasAdjudicadas":"</xsl:text>
				<xsl:value-of select="LIC_PROV_OFERTASADJUDICADAS"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Estrellas":"</xsl:text>
				<xsl:value-of select="ESTRELLAS"/>
			<xsl:text>",</xsl:text>

			<xsl:text>"UsuarioProve":"</xsl:text>
				<xsl:value-of select="USUARIO/ID"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"HayConversacion":"</xsl:text>
				<xsl:choose>
				<xsl:when test="CONVERSACION">
					<xsl:text>S</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>N</xsl:text>
				</xsl:otherwise>
				</xsl:choose>
			<xsl:text>",</xsl:text>
			<xsl:text>"UltMensaje":"</xsl:text>
				<xsl:value-of select="CONVERSACION/ULTIMOMENSAJE"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ConsumoColor":"</xsl:text>
				<xsl:choose>
				<xsl:when test="SUPERIOR">
					<xsl:text>Superior</xsl:text>
				</xsl:when>
				<xsl:when test="IGUAL">
					<xsl:text>Igual</xsl:text>
				</xsl:when>
				</xsl:choose>
			<xsl:text>",</xsl:text>
			<xsl:text>"BloqPedidos":"</xsl:text>
				<xsl:choose>
				<xsl:when test="PROVEEDOR_BLOQUEADO_POR_PEDIDOS">
					<xsl:text>S</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>N</xsl:text>
				</xsl:otherwise>
				</xsl:choose>
			<xsl:text>",</xsl:text>
			<xsl:text>"NombreUsuario":"</xsl:text>
				<xsl:value-of select="USUARIO/NOMBRE"/>
			<xsl:text>","IDDocumento":"</xsl:text>
				<xsl:value-of select="LIC_PROV_IDDOCUMENTO"/>
			<xsl:text>"}</xsl:text>
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
