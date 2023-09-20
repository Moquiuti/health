<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:param name="usuario" select="@US_ID"/>

<xsl:template match="/">

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/OfertasSeleccionadas/LANG"><xsl:value-of select="/OfertasSeleccionadas/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<meta http-equiv="Cache-Control" content="no-cache"/>

	<title><xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_TITULO"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/lic_150716.js"></script>-->
</head>
<body class="gris">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/OfertasSeleccionadas/LANG"><xsl:value-of select="/OfertasSeleccionadas/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->
<xsl:choose>
	<xsl:when test="//SESION_CADUCADA">
		<xsl:apply-templates select="//SESION_CADUCADA"/>
	</xsl:when>
	<xsl:when test="//Sorry">
		<xsl:apply-templates select="//Sorry"/>
	</xsl:when>
	<xsl:otherwise>

	<div class="cabeceraBox" style="background:#FFF; margin:0px;">
		<!--idioma-->
		<xsl:variable name="lang">
			<xsl:choose>
				<xsl:when test="/OfertasSeleccionadas/LANG"><xsl:value-of select="/OfertasSeleccionadas/LANG"/></xsl:when>
				<xsl:otherwise>spanish</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
		<!--idioma fin-->

		<div class="logoPage" id="logoPage">
			<div class="logoPageInside">
				<img src="http://www.newco.dev.br/images/logoMVM2016.gif" />
			</div><!--fin de logo-->
		</div><!--fin de logoPage-->
		<br/>
		<div class="boton">
			<a href="javascript:window.print()"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
		</div>

	</div><!--fin de cabeceraBox-->

	<xsl:call-template name="Imprimir_Ofertas_para_Cliente"/>

	</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>

<!-- Template para los clientes -->
<xsl:template name="Imprimir_Ofertas_para_Cliente">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/OfertasSeleccionadas/LANG"><xsl:value-of select="/OfertasSeleccionadas/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<div class="divLeft">
	<h1 class="titlePage">
		<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_TITULO"/>
	</h1>

	<table class="infoTable">
		<tr class="gris">
			<td class="labelRight veintecinco">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_FECHADECISIONPREVISTA"/>
			</td>
		</tr>
		<tr class="gris">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_DESCRIPCION"/>
			</td>
		</tr>
		<tr class="gris">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_entrega']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_CONDICIONESENTREGA"/>
			</td>
		</tr>
		<tr class="gris">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_pago']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_CONDICIONESPAGO"/>
			</td>
		</tr>
		<tr class="gris">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_otras']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_OTRASCONDICIONES"/>
			</td>
		</tr>
		<tr class="gris">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='meses_duracion']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_MESESDURACION"/>
			</td>
		</tr>
	</table><!--fin de tala datos generales-->
</div><!--fin de divLeft-->

<div class="divLeft gris">
	<xsl:for-each select="/OfertasSeleccionadas/LICITACION/PROVEEDORES/PROVEEDOR">
	<table class="infoTable">
	<thead>
		<tr class="subTituloTabla">
			<td colspan="10" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;		
			<xsl:if test="NO_CUMPLE_PEDIDO_MINIMO">
				<img src="http://www.newco.dev.br/images/urgente.gif"/>
			</xsl:if>
			<xsl:value-of select="NOMBRE"/>
			&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/>:&nbsp;<xsl:value-of select="LIC_PROV_PEDIDOMINIMO"/>
			&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='total_consumo']/node()"/>:&nbsp;<xsl:value-of select="TOTALPROVEEDOR"/>
			</td>
		</tr>
		<tr class="gris">
			<td class="cinco">&nbsp;</td>
			<td class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></td>
			<td class="trenta" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></td>
			<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></td>
			<td class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/></td>
			<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></td>
			<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/></td>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34">
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></td>
			</xsl:if>
			<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></td>
			<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></td>
			<td class="quince">&nbsp;</td>
		</tr>
	</thead>
	<tbody>
	<xsl:for-each select="OFERTA">
		<tr class="gris">
			<td><xsl:value-of select="LINEA"/></td>
			<td><xsl:value-of select="LIC_PROD_REFESTANDAR"/></td>
			<td class="datosLeft">
				<a href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/OfertasSeleccionadas/LICITACION/LIC_ID}">
				<xsl:value-of select="LIC_PROD_NOMBRE"/></a>
			</td>
			<td><xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>
			<td><xsl:value-of select="LIC_OFE_REFERENCIA"/></td>
			<td><xsl:value-of select="LIC_OFE_MARCA"/></td>
			<td>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 55">R$&nbsp;</xsl:if>
			<xsl:value-of select="LIC_OFE_PRECIO"/>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34">&nbsp;&#128;</xsl:if>
			</td>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34">
				<td><xsl:value-of select="LIC_OFE_TIPOIVA"/>%</td>
			</xsl:if>
			<td><xsl:value-of select="LIC_PROD_CANTIDAD"/></td>
			<td>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 55">R$&nbsp;</xsl:if>
			<xsl:value-of select="LIC_OFE_CONSUMO"/>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34">&nbsp;&#128;</xsl:if>
			</td>
			<td>&nbsp;</td>
		</tr>
	</xsl:for-each>
	</tbody>
	</table>
	</xsl:for-each>
</div><!--fin de divLeft-->

</xsl:template>

</xsl:stylesheet>
