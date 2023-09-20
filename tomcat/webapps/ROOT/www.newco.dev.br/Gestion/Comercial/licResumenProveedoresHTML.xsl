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

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedores']/node()"/>:&nbsp;<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_TITULO"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->
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

	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/OfertasSeleccionadas/LANG"><xsl:value-of select="/OfertasSeleccionadas/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div>
		<!--<table class="infoTable">-->
		<table class="buscador">
		<thead>
			<tr class="subTituloTabla">
				<td class="dos">&nbsp;</td>
				<td class="uno">&nbsp;</td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></td>
				<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/></td>
				<xsl:choose>
					<xsl:when test="/OfertasSeleccionadas/LICITACION/LISTA_CENTROS">
						<xsl:for-each select="/OfertasSeleccionadas/LICITACION/LISTA_CENTROS/CENTRO">
							<td class="dies"><xsl:value-of select="NOMBRE"/></td>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></td>
					</xsl:otherwise>
				</xsl:choose>
				<td class="cinco">&nbsp;</td>
			</tr>
		</thead>
		<tbody>
		<xsl:choose>
		<xsl:when test="not (/OfertasSeleccionadas/LICITACION/PROVEEDORES/PROVEEDOR)">
			<tr class="gris">
				<td colspan="4">
				&nbsp;<br/>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_proveedores_con_ofertas_seleccionadas']/node()"/>.
				<br/>&nbsp;
				</td>
			</tr>
		</xsl:when>
		<xsl:otherwise>
			<xsl:for-each select="/OfertasSeleccionadas/LICITACION/PROVEEDORES/PROVEEDOR">
				<tr class="gris">
					<td>
						<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS=55">
						<xsl:attribute name="style">
							<xsl:choose>
								<xsl:when test="EMP_NIVELDOCUMENTACION='R'">background:#CC0000;</xsl:when>	
								<xsl:when test="EMP_NIVELDOCUMENTACION='A'">background:#F57900;</xsl:when>	
								<xsl:when test="EMP_NIVELDOCUMENTACION='V'">background:#4E9A06;</xsl:when>	
							</xsl:choose>
						</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="CONTADOR"/>
					</td>
					<td>
					<xsl:if test="NO_CUMPLE_PEDIDO_MINIMO">
						<img src="http://www.newco.dev.br/images/urgente.gif"/>
					</xsl:if>
					</td>
					<td style="text-align:left;"><xsl:value-of select="NOMBRECORTO"/></td>
					<td style="text-align:right;"><xsl:value-of select="LIC_PROV_PEDIDOMINIMO"/></td>
					<xsl:choose>
						<xsl:when test="/OfertasSeleccionadas/LICITACION/LISTA_CENTROS">
							<xsl:for-each select="CONSUMO_POR_CENTRO/CENTRO">
								<td class="dies" style="text-align:right;">
								<xsl:if test="NO_CUMPLE_PEDIDO_MINIMO">
									<img src="http://www.newco.dev.br/images/urgente.gif"/>
								</xsl:if>
								<xsl:value-of select="CONSUMO"/>&nbsp;
								</td>
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
							<td style="text-align:right;"><xsl:value-of select="LIC_PROV_CONSUMOADJUDICADO"/>&nbsp;</td>
						</xsl:otherwise>
					</xsl:choose>
					<!--<td><xsl:value-of select="LIC_OFE_REFERENCIA"/></td>-->
					<td>&nbsp;</td>
				</tr>
			</xsl:for-each>
		</xsl:otherwise>
		</xsl:choose>
		</tbody>
		</table>
	</div><!--fin de divLeft-->

	</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>

</xsl:stylesheet>
