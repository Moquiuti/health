<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Ofertas de un producto de la licitacion
	Ultima revision: ET 10feb23 12:22
+-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/OfertasProductosLic">
	<xsl:text>{"OfertasProductosLic":[</xsl:text>
		<xsl:for-each select="LISTAPRODUCTOS/PRODUCTOLICITACION">
	
		<xsl:text>{"posicion":"</xsl:text>
		<xsl:value-of select="POSICION"/>
		<xsl:text>", "curvaABC":"</xsl:text>
		<xsl:value-of select="CP_PRO_CURVAABC"/>
		<xsl:text>","UltCompra":{"FECHA":"</xsl:text>
		<xsl:value-of select="ULTIMACOMPRA/FECHA"/>
		<xsl:text>","MO_ID":"</xsl:text>
		<xsl:value-of select="ULTIMACOMPRA/MO_ID"/>
		<xsl:text>","IDPROVEEDOR":"</xsl:text>
		<xsl:value-of select="ULTIMACOMPRA/IDPROVEEDOR"/>
		<xsl:text>","PROVEEDOR":"</xsl:text>
		<xsl:value-of select="ULTIMACOMPRA/PROVEEDOR"/>
		<xsl:text>","MARCA":"</xsl:text>
		<xsl:value-of select="ULTIMACOMPRA/MARCA"/>
		<xsl:text>","PRECIO":"</xsl:text>
		<xsl:value-of select="ULTIMACOMPRA/PRECIO"/>
		<xsl:text>","CANTIDAD":"</xsl:text>
		<xsl:value-of select="ULTIMACOMPRA/CANTIDAD"/>
		<xsl:text>"},"CompraMedia":{"NUMERO_PEDIDOS":"</xsl:text>
		<xsl:value-of select="COMPRAMEDIA/NUMERO_PEDIDOS"/>
		<xsl:text>","CANTIDAD_TOTAL":"</xsl:text>
		<xsl:value-of select="COMPRAMEDIA/CANTIDAD_TOTAL"/>
		<xsl:text>","PRECIO_MIN":"</xsl:text>
		<xsl:value-of select="COMPRAMEDIA/PRECIO_MIN"/>
		<xsl:text>","PRECIO_MAX":"</xsl:text>
		<xsl:value-of select="COMPRAMEDIA/PRECIO_MAX"/>
		<xsl:text>","PRECIO_MEDIO":"</xsl:text>
		<xsl:value-of select="COMPRAMEDIA/PRECIO_MEDIO"/>
		<xsl:text>"},"ofertas": [</xsl:text>		
		<xsl:for-each select="OFERTAS/OFERTA">
			<xsl:text>{"contador":"</xsl:text>
			<xsl:value-of select="CONTADOR"/>
			<xsl:text>", "LIC_OFE_ID":"</xsl:text>
			<xsl:value-of select="LIC_OFE_ID"/>
			<xsl:text>", "LIC_OFE_IDPROVEEDORLIC":"</xsl:text>
			<xsl:value-of select="LIC_OFE_IDPROVEEDORLIC"/>
			<xsl:text>", "IDPROVEEDOR":"</xsl:text>
			<xsl:value-of select="IDPROVEEDOR"/>
			<xsl:text>", "PROVEEDOR":"</xsl:text>
			<xsl:value-of select="PROVEEDOR"/>
			<xsl:text>", "VENDEDOR":"</xsl:text>					<!--11ago22-->
			<xsl:value-of select="VENDEDOR"/>
			<xsl:text>", "LIC_PROV_IDESTADO":"</xsl:text>
			<xsl:value-of select="LIC_PROV_IDESTADO"/>
			<xsl:text>", "EMP_NIVELDOCUMENTACION":"</xsl:text>
			<xsl:value-of select="EMP_NIVELDOCUMENTACION"/>
			<xsl:text>", "LIC_PROV_PEDIDOMINIMO":"</xsl:text>
			<xsl:value-of select="LIC_PROV_PEDIDOMINIMO"/>
			<xsl:text>", "LIC_PROV_PLAZOENTREGA":"</xsl:text>
			<xsl:value-of select="LIC_PROV_PLAZOENTREGA"/>
			<xsl:text>", "LIC_PROV_CONSUMOADJUDICADO":"</xsl:text>
			<xsl:value-of select="LIC_PROV_CONSUMOADJUDICADO"/>
			<xsl:text>", "LIC_OFE_REFERENCIA":"</xsl:text>
			<xsl:value-of select="LIC_OFE_REFERENCIA"/>
			<xsl:text>", "LIC_OFE_NOMBRE":"</xsl:text>
			<xsl:value-of select="LIC_OFE_NOMBRE"/>
			<xsl:text>", "LIC_OFE_MARCA":"</xsl:text>
			<xsl:value-of select="LIC_OFE_MARCA"/>
			<xsl:text>", "LIC_OFE_FECHAALTA":"</xsl:text>
			<xsl:value-of select="LIC_OFE_FECHAALTA"/>
			<xsl:text>", "LIC_OFE_FECHAMODIFICACION":"</xsl:text>
			<xsl:value-of select="LIC_OFE_FECHAMODIFICACION"/>
			<xsl:text>", "LIC_OFE_UNIDADESPORLOTE":"</xsl:text>
			<xsl:value-of select="LIC_OFE_UNIDADESPORLOTE"/>
			<xsl:text>", "LIC_OFE_CANTIDAD":"</xsl:text>
			<xsl:value-of select="LIC_OFE_CANTIDAD"/>
			<xsl:text>", "LIC_OFE_PRECIO":"</xsl:text>
			<xsl:value-of select="LIC_OFE_PRECIO"/>
			<xsl:text>", "LIC_OFE_TIPOIVA":"</xsl:text>
			<xsl:value-of select="LIC_OFE_TIPOIVA"/>
			<xsl:text>", "LIC_OFE_CONSUMO":"</xsl:text>
			<xsl:value-of select="LIC_OFE_CONSUMO"/>
			<xsl:text>", "LIC_OFE_CONSUMOIVA":"</xsl:text>
			<xsl:value-of select="LIC_OFE_CONSUMOIVA"/>
			<xsl:text>", "LIC_OFE_IDESTADOEVALUACION":"</xsl:text>
			<xsl:value-of select="LIC_OFE_IDESTADOEVALUACION"/>
			<xsl:text>", "ESTADOEVALUACION":"</xsl:text>
			<xsl:value-of select="ESTADOEVALUACION"/>
			<xsl:text>", "LIC_OFE_AHORRO":"</xsl:text>
			<xsl:value-of select="LIC_OFE_AHORRO"/>
			<xsl:text>", "LIC_OFE_ADJUDICADA":"</xsl:text>
			<xsl:value-of select="LIC_OFE_ADJUDICADA"/>
			<xsl:text>", "LIC_OFE_ANOTACIONES":"</xsl:text>
			<xsl:value-of select="LIC_OFE_ANOTACIONES_JS"/>
			<xsl:text>", "LIC_OFE_INFOAMPLIADA":"</xsl:text>
			<xsl:value-of select="LIC_OFE_INFOAMPLIADA_JS"/>
			<xsl:text>", "LIC_OFE_ORDEN":"</xsl:text>
			<xsl:value-of select="LIC_OFE_ORDEN"/>
			<xsl:text>", "LIC_OFE_IDMOTIVOCAMBIO":"</xsl:text>
			<xsl:value-of select="LIC_OFE_IDMOTIVOCAMBIO"/>
			<xsl:text>", "LIC_OFE_MOTIVOCAMBIO":"</xsl:text>
			<xsl:value-of select="LIC_OFE_MOTIVOCAMBIO"/>
			<xsl:text>", "LIC_OFE_CANTIDADADJUDICADA":"</xsl:text>
			<xsl:value-of select="LIC_OFE_CANTIDADADJUDICADA"/>
			<xsl:text>", "LIC_OFE_PRECIOIVA":"</xsl:text>
			<xsl:value-of select="LIC_OFE_PRECIOIVA"/>
			<xsl:text>", "LIC_OFE_PORPRODUCTOADJUDICADO":"</xsl:text>
			<xsl:value-of select="LIC_OFE_PORPRODUCTOADJUDICADO"/>
			<xsl:text>", "LIC_OFE_REGISTROSANITARIO":"</xsl:text><!--	Nuevos campos 2feb23	-->
			<xsl:value-of select="LIC_OFE_REGISTROSANITARIO"/>
			<xsl:text>", "LIC_OFE_CODEXPEDIENTE":"</xsl:text>
			<xsl:value-of select="LIC_OFE_CODEXPEDIENTE"/>
			<xsl:text>", "LIC_OFE_CODCUM":"</xsl:text>
			<xsl:value-of select="LIC_OFE_CODCUM"/>
			<xsl:text>", "LIC_OFE_CODIUM":"</xsl:text>
			<xsl:value-of select="LIC_OFE_CODIUM"/>
			<xsl:text>", "LIC_OFE_CODINVIMA":"</xsl:text>
			<xsl:value-of select="LIC_OFE_CODINVIMA"/>
			<xsl:text>", "LIC_OFE_FECHACADINVIMA":"</xsl:text>
			<xsl:value-of select="LIC_OFE_FECHACADINVIMA"/>
			<xsl:text>", "LIC_OFE_CLASIFICACIONRIESGO":"</xsl:text>
			<xsl:value-of select="LIC_OFE_CLASIFICACIONRIESGO"/><!--	Nuevos campos 2feb23	-->
			<xsl:text>", "COLOR":"</xsl:text>
			<xsl:value-of select="COLOR"/>
			<xsl:text>", "MO_ID":"</xsl:text>
			<xsl:value-of select="MULTIOFERTAS/MULTIOFERTA/MO_ID"/>
			<xsl:text>", "MO_IDCENTROCLIENTE":"</xsl:text>
			<xsl:value-of select="MULTIOFERTAS/MULTIOFERTA/MO_IDCENTROCLIENTE"/>
			<xsl:text>", "MO_STATUS":"</xsl:text>
			<xsl:value-of select="MULTIOFERTAS/MULTIOFERTA/MO_STATUS"/>
			<xsl:text>", "CODPEDIDO":"</xsl:text>
			<xsl:value-of select="MULTIOFERTAS/MULTIOFERTA/CODPEDIDO"/>
			<xsl:text>", "LMO_ID":"</xsl:text>
			<xsl:value-of select="MULTIOFERTAS/MULTIOFERTA/LMO_ID"/>
			<xsl:text>", "INCLUIDO_EN_PEDIDO":"</xsl:text>
			<xsl:choose><xsl:when test="INCLUIDO_EN_PEDIDO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>
			<xsl:text>", "MARCA_ACEPTABLE":"</xsl:text>
			<xsl:choose><xsl:when test="MARCA_ACEPTABLE">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>
			<xsl:text>", "NO_CUMPLE_PEDIDO_MINIMO":"</xsl:text>
			<xsl:choose><xsl:when test="NO_CUMPLE_PEDIDO_MINIMO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>
			<xsl:text>", "MUY_SOSPECHOSO":"</xsl:text>
			<xsl:choose><xsl:when test="MUY_SOSPECHOSO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>
			<xsl:text>", "SOSPECHOSO":"</xsl:text>
			<xsl:choose><xsl:when test="SOSPECHOSO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>
			<xsl:text>", "EMPAQUETAMIENTO_SOSPECHOSO":"</xsl:text>
			<xsl:choose><xsl:when test="EMPAQUETAMIENTO_SOSPECHOSO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>
			<xsl:text>", "IGUAL":"</xsl:text>
			<xsl:choose><xsl:when test="IGUAL">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>
			<xsl:text>", "SUPERIOR":"</xsl:text>
			<xsl:choose><xsl:when test="SUPERIOR">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>
			<xsl:text>", "DOC_ID":"</xsl:text>
			<xsl:value-of select="DOCUMENTO/ID"/>
			<xsl:text>", "DOC_URL":"</xsl:text>
			<xsl:value-of select="DOCUMENTO/URL"/>
			<xsl:text>", "FT_ID":"</xsl:text>
			<xsl:value-of select="FICHA_TECNICA/ID"/>
			<xsl:text>", "FT_URL":"</xsl:text>
			<xsl:value-of select="FICHA_TECNICA/URL"/>
			<xsl:text>", "RS_ID":"</xsl:text>
			<xsl:value-of select="REGISTRO_SANITARIO/ID"/>
			<xsl:text>", "RS_URL":"</xsl:text>
			<xsl:value-of select="REGISTRO_SANITARIO/URL"/>
			<xsl:text>", "CE_ID":"</xsl:text>
			<xsl:value-of select="CERTIFICADO_EXPERIENCIA/ID"/>
			<xsl:text>", "CE_URL":"</xsl:text>
			<xsl:value-of select="CERTIFICADO_EXPERIENCIA/URL"/>
			<xsl:text>", "FS_ID":"</xsl:text>
			<xsl:value-of select="FICHA_SEGURIDAD/ID"/>
			<xsl:text>", "FS_URL":"</xsl:text>
			<xsl:value-of select="FICHA_SEGURIDAD/URL"/>
			<xsl:text>"}</xsl:text>
			<xsl:if test="position() != last()">
				<xsl:text>,</xsl:text>
			</xsl:if>
		</xsl:for-each>
		<xsl:text>]}</xsl:text>
	<!--<xsl:text>}</xsl:text>-->
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
	<!--	Cierre de bucle	-->
	</xsl:for-each>
	<xsl:text>]}</xsl:text>
</xsl:template>
</xsl:stylesheet>
