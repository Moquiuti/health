<?xml version="1.0" encoding="iso-8859-1"?>
<!-- 
	Listado de productos para excel
	Actualizacion javascript lic_150621.js
	ultima revision: ET 15jun21 09:30
-->
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
			<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<meta http-equiv="Cache-Control" content="no-cache"/>

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_licitaciones']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/lic_150621.js"></script>
</head>

<body onload="onloadEvents();">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG"/></xsl:when>
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
            <div class="divLeft">

		<h1 class="titlePage" style="height:50px;float:left;width:60%;background:#FFF;border:0;">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion']/node()"/>:&nbsp;<xsl:value-of select="/Mantenimiento/LICITACION/LIC_TITULO"/>

			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/IDPAIS = '34' and not(/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA)">
				<br /><span style="font-size:12px;margin:5px 0px;">(<xsl:value-of select="document($doc)/translation/texts/item[@name='precios_sin_iva']/node()"/>)</span>
			</xsl:when>
			<xsl:when test="/Mantenimiento/LICITACION/IDPAIS = '34' and /Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA">
				<br /><span style="font-size:12px;margin:5px 0px;">(<xsl:value-of select="document($doc)/translation/texts/item[@name='precios_con_iva']/node()"/>)</span>
			</xsl:when>
			</xsl:choose>

			<xsl:if test="/Mantenimiento/LICITACION/LIC_IDESTADO != 'EST'">
				<xsl:if test="/Mantenimiento/LICITACION/IDPAIS = '34'">
				<p style="margin-top:5px;">
                    <span style="font-size:12px;padding:4px 8px;background:#F3F781;border:1px solid red;text-align:center;">
					<xsl:choose>
					<xsl:when test="/Mantenimiento/LICITACION/LIC_PORPRODUCTO = 'S'">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion_por_producto_expli']/node()"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion_por_paquete_expli']/node()"/>
					</xsl:otherwise>
					</xsl:choose>
				</span></p>
				</xsl:if>
			</xsl:if>
		</h1>

			<h1 class="titlePage" style="height:45px;float:left;width:19%;padding-right:1%;background:#FFF;border:0;">
			&nbsp;
			</h1>
            </div><!--fin de divLeft-->
            <div class="divLeft">

		<!-- INFO CABECERA -->
		<xsl:call-template name="Info_Datos_Generales"/>
		<!-- FIN INFO CABECERA -->

		<!-- INFO PRODUCTOS -->
		<xsl:call-template name="Info_Productos_Ofertas_Cliente"/>
		<!-- FIN INFO PRODUCTOS -->

            </div><!--fin de divleft bajo h1-->
	</xsl:otherwise>
</xsl:choose>

</body>
</html>
</xsl:template>



<!-- Info Datos Generales -->
<xsl:template name="Info_Datos_Generales">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:value-of select="/Mantenimiento/LANG"/>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<table class="infoTable" border="0">

	<tr>
		<td colspan="6">&nbsp;</td>
	</tr>

	<tr>
		<td class="doce labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_alta']/node()"/>:</td>
		<td class="quince datosLeft"><strong><xsl:value-of select="Mantenimiento/LICITACION/LIC_FECHAALTA"/></strong></td>
		<td class="doce labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/>:</td>
		<td class="quince datosLeft"><strong><xsl:value-of select="/Mantenimiento/LICITACION/LIC_FECHADECISIONPREVISTA"/></strong></td>
		<td class="doce labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>:</td>
		<td class="doce datosLeft"><strong><xsl:value-of select="/Mantenimiento/LICITACION/ESTADO"/></strong></td>
        </tr>

	<xsl:if test="/Mantenimiento/LICITACION/LIC_IDESTADO = 'ADJ' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'FIRM' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'CONT'">
	<tr>
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_real_adj']/node()"/>:</td>
		<td class="datosLeft"><strong><xsl:value-of select="/Mantenimiento/LICITACION/LIC_FECHAREALADJUDICACION"/></strong></td>
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_real_cad']/node()"/>:</td>
		<td class="datosLeft"><strong><xsl:value-of select="/Mantenimiento/LICITACION/LIC_FECHAREALCADUCIDAD"/></strong></td>
		<td colspan="2">&nbsp;</td>
	</tr>
	</xsl:if>

	<tr><td colspan="6">&nbsp;</td></tr>
</table>

</xsl:template>
<!-- FIN Info Datos Generales -->



<!-- Info Productos y Ofertas Cliente -->
<xsl:template name="Info_Productos_Ofertas_Cliente">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:value-of select="/Mantenimiento/LANG"/>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

	<table class=" divLeft infoTable" style="border-bottom:1px solid #999999;" border="0">
	<thead>

		<tr class="subTituloTabla">
			<!-- Info Productos por parte del Cliente -->
			<td rowspan="2" class="borderLeft">&nbsp;</td>
			<td rowspan="2" class="borderLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>&nbsp;</td>
			<td rowspan="2" class="borderLeft" style="text-align:left;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>&nbsp;</td>
			<td rowspan="2" class="borderLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='num_ofertas']/node()"/>&nbsp;</td>
			<td rowspan="2" class="borderLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica_abr']/node()"/>&nbsp;</td>

			<xsl:choose>
			<xsl:when test="not(/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA)">
				<td rowspan="2" class="borderLeft">&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_historico_sIVA_abr_2line']/node()"/>&nbsp;</td>
				<td rowspan="2" class="borderLeft">&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_objetivo_sIVA_abr_2line']/node()"/>&nbsp;</td>
			</xsl:when>
			<xsl:otherwise>
				<td rowspan="2" class="borderLeft">&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_historico_cIVA_abr_2line']/node()"/>&nbsp;</td>
				<td rowspan="2" class="borderLeft">&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_objetivo_cIVA_abr_2line']/node()"/>&nbsp;</td>
			</xsl:otherwise>
			</xsl:choose>

				<td rowspan="2" class="borderLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/>&nbsp;</td>

			<xsl:choose>
			<xsl:when test="not(/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA)">
				<td rowspan="2" class="borderLeft">&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_sIVA_2line']/node()"/>&nbsp;</td>
			</xsl:when>
			<xsl:otherwise>
				<td rowspan="2" class="borderLeft">&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_cIVA_2line']/node()"/>&nbsp;</td>
			</xsl:otherwise>
			</xsl:choose>

			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/IDPAIS != '55'">
				<td rowspan="2" class="borderleft">
                    <xsl:attribute name="class"><xsl:if test="/Mantenimiento/LICITACION/IDPAIS != '55'">borderleft</xsl:if></xsl:attribute>
                    &nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='iva']/node()"/>&nbsp;
                </td>
			</xsl:when>
			<xsl:otherwise>
				<td rowspan="2" class="borderleft">&nbsp;</td>
			</xsl:otherwise>
			</xsl:choose>
				<!-- FIN Info Productos por parte del Cliente -->

			<!-- Nombres de Proveedores -->
			<xsl:for-each select="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PROVEEDORESLICITACION/PROVEEDOR">
				<xsl:if test="TIENE_OFERTAS">
				<td colspan="6" style="text-align:center; border-left:1px solid #999999;"><xsl:value-of select="NOMBRECORTO"/></td>
				</xsl:if>
			</xsl:for-each>
        	</tr>

			<tr class="subTituloTabla">
			<!-- Info Ofertas por parte del Proveedor -->
			<xsl:for-each select="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PROVEEDORESLICITACION/PROVEEDOR">
				<xsl:if test="TIENE_OFERTAS">
					<td class="zerouno" style="border-left:1px solid #999999;">&nbsp;</td>
					<xsl:choose>
					<xsl:when test="not(/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA)">
						<td class="dos"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_2line']/node()"/>&nbsp;</td>
						<td class="dos borderleft"><xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_sIVA_2line']/node()"/>&nbsp;</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="dos"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_cIVA_2line']/node()"/>&nbsp;</td>
						<td class="dos borderleft"><xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_cIVA_2line']/node()"/>&nbsp;</td>
					</xsl:otherwise>
					</xsl:choose>
					<td class="dos borderleft"><xsl:copy-of select="document($doc)/translation/texts/item[@name='porcentaje_ahorro']/node()"/>&nbsp;</td>
					<td class="uno borderleft"><xsl:copy-of select="document($doc)/translation/texts/item[@name='evaluacion_abr']/node()"/></td>
					<td class="zerouno">&nbsp;</td>
				</xsl:if>
			</xsl:for-each>
		<!-- FIN Info Ofertas por parte del Proveedor -->
		</tr>
	</thead>

	<tbody>
	<xsl:for-each select="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PRODUCTO">
		<tr id="{LIC_PROD_ID}" style="background:#FFF;border-bottom:1px solid #999;">
			<td class="dos" style="border-left:1px solid #999;"><xsl:value-of select="LINEA"/>&nbsp;</td>
			<td class="cuatro" style="border-left:1px solid #999;">&nbsp;
				<xsl:choose>
				<xsl:when test="LIC_PROD_REFCLIENTE != ''">
					<xsl:value-of select="LIC_PROD_REFCLIENTE"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="LIC_PROD_REFESTANDAR"/>
				</xsl:otherwise>
				</xsl:choose>
                        </td>
                        <td style="text-align:left;padding:2px 0px 2px 4px;" class="doce borderLeft">
                            <strong>
                                <xsl:value-of select="LIC_PROD_NOMBRE"/>
                            </strong>&nbsp;
                        </td>
			<td class="tres borderLeft">
				<xsl:attribute name="class">
					<xsl:choose>
					<xsl:when test="NUMERO_OFERTAS = 0">tres borderLeft fondoRojo</xsl:when>
					<xsl:otherwise>tres borderLeft</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<xsl:value-of select="NUMERO_OFERTAS"/>
			</td>
			<td class="ocho borderLeft"><xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>

		<xsl:choose>
		<xsl:when test="not(/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA)">
			<td class="cuatro borderLeft precioRef textRight" style="text-align:right;"><xsl:value-of select="LIC_PROD_PRECIOREFERENCIA"/></td>
			<td class="cuatro borderLeft textRight" style="text-align:right;"><xsl:value-of select="LIC_PROD_PRECIOOBJETIVO"/></td>
		</xsl:when>
		<xsl:otherwise>
			<td class="cuatro borderLeft precioRef textRight" style="text-align:right;"><xsl:value-of select="LIC_PROD_PRECIOREFERENCIAIVA"/></td>
			<td class="cuatro borderLeft textRight" style="text-align:right;"><xsl:value-of select="LIC_PROD_PRECIOOBJETIVOIVA"/></td>
		</xsl:otherwise>
		</xsl:choose>

			<td class="cuatro borderLeft cantidad textRight" style="text-align:right;"><xsl:value-of select="LIC_PROD_CANTIDAD"/></td>

		<xsl:choose>
		<xsl:when test="not(/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA)">
			<td class="cuatro borderLeft textRight" style="text-align:right;"><xsl:value-of select="LIC_PROD_CONSUMO"/></td>
		</xsl:when>
		<xsl:otherwise>
			<td class="cuatro borderLeft textRight" style="text-align:right;"><xsl:value-of select="LIC_PROD_CONSUMOIVA"/></td>
		</xsl:otherwise>
		</xsl:choose>

		<xsl:choose>
		<xsl:when test="/Mantenimiento/LICITACION/IDPAIS != '55'">
			<td class="dos borderLeft textRight" style="text-align:right;"><xsl:value-of select="LIC_PROD_TIPOIVA"/>%</td>
		</xsl:when>
		<xsl:otherwise>
			<td class="zerouno borderLeft">&nbsp;</td>
		</xsl:otherwise>
		</xsl:choose>

		<!-- Datos de las Ofertas -->
		<xsl:for-each select="OFERTA">

		<xsl:choose>
		<xsl:when test="NO_INFORMADA">
			<td colspan="6" style="text-align:center; border-left:1px solid #999999;"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_no_informada']/node()"/></td>
		</xsl:when>
		<xsl:when test="LIC_OFE_PRECIOIVA = '0,0000' and LIC_OFE_UNIDADESPORLOTE = '0,00'">
			<td colspan="6" style="text-align:center; border-left:1px solid #999999;"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_no_ofertada']/node()"/></td>
		</xsl:when>
		<xsl:otherwise>
			<td style="border-left:1px solid #999999;padding:0 1px;">
				<xsl:choose>
				<xsl:when test="/Mantenimiento/LICITACION/LIC_PORPRODUCTO = 'S' and (/Mantenimiento/LICITACION/LIC_IDESTADO = 'ADJ' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'FIRM' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'CONT')">
					<xsl:if test="OFERTA_ADJUDICADA">
						<img src="http://www.newco.dev.br/images/check.gif">
							<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()"/></xsl:attribute>
                        </img>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					&nbsp;
				</xsl:otherwise>
				</xsl:choose>
			</td>

			<xsl:choose>
			<xsl:when test="not(/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA)">
				<td id="{../LIC_PROD_ID}_{LIC_OFE_ID}" style="text-align:right;">
					<xsl:choose>
					<xsl:when test="IGUAL">
						<xsl:attribute name="class"><xsl:value-of select="../LIC_PROD_ID"/>_PrecioOferta</xsl:attribute><!--amarillo-->
					</xsl:when>
					<xsl:when test="SUPERIOR">
						<xsl:attribute name="class"><xsl:value-of select="../LIC_PROD_ID"/>_PrecioOferta</xsl:attribute><!--fondoRojo-->
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="class"><xsl:value-of select="../LIC_PROD_ID"/>_PrecioOferta</xsl:attribute>
					</xsl:otherwise>
					</xsl:choose>
                                        <!--valor de precio-->
                                        <xsl:choose>
					<xsl:when test="IGUAL"><span style="color:orange;font-weight:bold;"><xsl:value-of select="LIC_OFE_PRECIO"/></span>&nbsp;</xsl:when>
					<xsl:when test="SUPERIOR"><span style="color:red;font-weight:bold;"><xsl:value-of select="LIC_OFE_PRECIO"/></span>&nbsp;</xsl:when>
					<xsl:otherwise><span style="color:green;font-weight:bold;"><xsl:value-of select="LIC_OFE_PRECIO"/></span>&nbsp;</xsl:otherwise>
					</xsl:choose>

				</td>
				<td class="borderLeft" style="text-align:right;">
					<xsl:value-of select="LIC_OFE_CONSUMO"/>&nbsp;
				</td>
			</xsl:when>
			<xsl:otherwise>
				<td id="{../LIC_PROD_ID}_{LIC_OFE_ID}" class="borderLeft" style="text-align:right;">
					<xsl:choose>
					<xsl:when test="IGUAL">
						<xsl:attribute name="class"><xsl:value-of select="../LIC_PROD_ID"/>_PrecioOferta</xsl:attribute>
					</xsl:when>
					<xsl:when test="SUPERIOR">
						<xsl:attribute name="class"><xsl:value-of select="../LIC_PROD_ID"/>_PrecioOferta</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="class"><xsl:value-of select="../LIC_PROD_ID"/>_PrecioOferta</xsl:attribute>
					</xsl:otherwise>
					</xsl:choose>
					<!--valor de precio-->
                                        <xsl:choose>
					<xsl:when test="IGUAL"><span style="color:orange;font-weight:bold;"><xsl:value-of select="LIC_OFE_PRECIOIVA"/></span>&nbsp;</xsl:when>
					<xsl:when test="SUPERIOR"><span style="color:red;font-weight:bold;"><xsl:value-of select="LIC_OFE_PRECIOIVA"/></span>&nbsp;</xsl:when>
					<xsl:otherwise><span style="color:green;font-weight:bold;"><xsl:value-of select="LIC_OFE_PRECIOIVA"/></span>&nbsp;</xsl:otherwise>
					</xsl:choose>

				</td>
				<td class="borderLeft" style="text-align:right;"><xsl:value-of select="LIC_OFE_CONSUMOIVA"/>&nbsp;</td>
			</xsl:otherwise>
			</xsl:choose>

			<td class="borderLeft" style="text-align:right;"><xsl:value-of select="LIC_OFE_AHORRO"/>%&nbsp;</td>

			<td class="borderLeft">
			<xsl:choose>
			<xsl:when test="LIC_OFE_IDESTADOEVALUACION = 'NOAPTO'">
				<img src="http://www.newco.dev.br/images/bolaRoja.gif"/>
			</xsl:when>
			<xsl:when test="LIC_OFE_IDESTADOEVALUACION = 'PEND'">
				<img src="http://www.newco.dev.br/images/bolaAmbar.gif"/>
			</xsl:when>
			<xsl:otherwise>
				<img src="http://www.newco.dev.br/images/bolaVerde.gif"/>
			</xsl:otherwise>
			</xsl:choose>
                        </td>

			<td style="padding:0 2px;">
			<xsl:if test="FICHA_TECNICA/ID">
				<a href="http://www.newco.dev.br/Documentos/{FICHA_TECNICA/URL}" target="_blank">
					<img src="http://www.newco.dev.br/images/fichaChange.gif">
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='ficha_tecnica']/node()"/></xsl:attribute>
					</img>
				</a>
			</xsl:if>
			</td>
		</xsl:otherwise>
		</xsl:choose>

		</xsl:for-each>
		<!-- FIN Datos de las Ofertas -->

		</tr>
	</xsl:for-each>
	</tbody>

	<tfoot>

		<tr>
			<td colspan="4">&nbsp;</td>
			<td style="text-align:right;padding:5px 0px;">
				<strong>
					<xsl:choose>
					<xsl:when test="/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='total_cIVA']/node()"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='total_sIVA']/node()"/>
					</xsl:otherwise>
					</xsl:choose>
				:&nbsp;</strong>
			</td>
			<td style="text-align:right;">
				<strong>
				<xsl:choose>
				<xsl:when test="/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA">
					<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CONSUMOHISTORICOIVA"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CONSUMOHISTORICO"/>
				</xsl:otherwise>
				</xsl:choose>&nbsp;
				</strong>
                        </td>
			<td style="text-align:right;">
				<strong>
				<xsl:choose>
				<xsl:when test="/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA">
					<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CONSUMOIVA"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CONSUMO"/>
				</xsl:otherwise>
				</xsl:choose>&nbsp;
				</strong>
                        </td>
			<td colspan="3">&nbsp;</td>

		<xsl:for-each select="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PROVEEDORESLICITACION/PROVEEDOR">
                    <td colspan="2" style="border-left:1px solid #999999;">&nbsp;</td>

			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA">
				<xsl:choose>
				<xsl:when test="LIC_PROV_CONSUMOIVA != '0,00'">
					<td style="text-align:right;">
						<strong>
							<xsl:choose>
							<xsl:when test="/Mantenimiento/LICITACION/IDESTADO = 'INF'">
								<xsl:value-of select="LIC_PROV_CONSUMOIVA"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="LIC_PROV_CONSUMOADJUDICADOIVA"/>
							</xsl:otherwise>
							</xsl:choose>
						</strong>&nbsp;
					</td>
					<td class="borderLeft" style="text-align:right;">
						<strong>
							<xsl:choose>
							<xsl:when test="LIC_PROV_CONSUMOPOTENCIALIVA != ''">
								<xsl:value-of select="LIC_PROV_AHORROIVA"/>%&nbsp;
							</xsl:when>
							<xsl:otherwise>&nbsp;</xsl:otherwise>
							</xsl:choose>
						</strong>
					</td>
				</xsl:when>
				<xsl:otherwise><td colspan="2">&nbsp;</td></xsl:otherwise>
				</xsl:choose>
			</xsl:when>

			<xsl:otherwise>
				<xsl:choose>
				<xsl:when test="LIC_PROV_CONSUMO != '0,00'">
					<td style="text-align:right;">
						<strong>
							<xsl:choose>
							<xsl:when test="/Mantenimiento/LICITACION/IDESTADO = 'INF'">
								<xsl:value-of select="LIC_PROV_CONSUMO"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="LIC_PROV_CONSUMOADJUDICADO"/>
							</xsl:otherwise>
							</xsl:choose>
						</strong>&nbsp;
					</td>
					<td class="borderLeft" style="text-align:right;">
						<strong>
							<xsl:choose>
							<xsl:when test="LIC_PROV_CONSUMOPOTENCIAL != ''">
								<xsl:value-of select="LIC_PROV_AHORRO"/>%&nbsp;
							</xsl:when>
							<xsl:otherwise>&nbsp;</xsl:otherwise>
							</xsl:choose>
						</strong>
					</td>
				</xsl:when>
				<xsl:otherwise><td colspan="2">&nbsp;</td></xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
			</xsl:choose>
				<td colspan="2">&nbsp;</td>
		</xsl:for-each>
		</tr>
	</tfoot>
	</table>

</xsl:template>
<!-- FIN Info Productos y Ofertas Cliente -->


</xsl:stylesheet>
