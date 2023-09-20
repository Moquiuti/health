<?xml version="1.0" encoding="iso-8859-1"?>
<!-- 
	Pagina con datos de la oferta de un proveedor para imprimir
	Ultima revision: ET 7feb23 15:31 lic2022_060423.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:param name="usuario" select="@US_ID"/>

<xsl:template match="/">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/ImprimirOferta/LANG"><xsl:value-of select="/ImprimirOferta/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<meta http-equiv="Cache-Control" content="no-cache"/>

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='ofertas']/node()"/>:&nbsp;<xsl:value-of select="/ImprimirOferta/LICITACION/LIC_TITULO"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/lic2022_060423.js"></script>
</head>
<body class="gris">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/ImprimirOferta/LANG"><xsl:value-of select="/ImprimirOferta/LANG"/></xsl:when>
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

	<!--<div class="cabeceraBox" style="background:#FFF; margin:0px;">
		<!- -idioma- ->
		<xsl:variable name="lang">
			<xsl:choose>
				<xsl:when test="/ImprimirOferta/LANG"><xsl:value-of select="/ImprimirOferta/LANG"/></xsl:when>
				<xsl:otherwise>spanish</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
		<!- -idioma fin- ->

		<div id="logoPage">
			<div style="float:left;display:inline;">
				<img src="http://www.newco.dev.br/images/logoMVM2016.gif" />
			</div><!- -fin de logo- ->
			<div style="float:right;display:inline;">
			<br/>
			<a class="btnNormal" href="javascript:window.print()" style="margin-right:30px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
			</div>
		</div><!- -fin de logoPage- ->
	</div><!- -fin de cabeceraBox-->
	<xsl:call-template name="Imprimir_Oferta_para_Proveedor"/>
	</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>

<!-- Template para los clientes -->
<xsl:template name="Imprimir_Oferta_para_Cliente">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/ImprimirOferta/LANG"><xsl:value-of select="/ImprimirOferta/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<div class="ZonaTituloPagina">
	<p class="TituloPagina">
		<xsl:value-of select="/ImprimirOferta/LICITACION/LIC_TITULO"/>
		<xsl:for-each select="/ImprimirOferta/LICITACION/PROVEEDORESLICITACION/PROVEEDOR">
			<xsl:if test="/ImprimirOferta/LIC_PROV_ID = IDPROVEEDOR_LIC">
				<xsl:choose>
				<xsl:when test="OFERTA">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='oferta']/node()"/>
				</xsl:when>
				<xsl:when test="OFERTA_RECHAZADA">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_rechazada']/node()"/>
				</xsl:when>
				<xsl:when test="ADJUDICADO">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado']/node()"/>
				</xsl:when>
				</xsl:choose>
			</xsl:if>
		</xsl:for-each>
		<span class="CompletarTitulo">
			<!--	Botones	-->
			<a id="botonProdAnterior" class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/ImprimirOferta2022.xsql?LIC_PROV_ID={/ImprimirOferta/LICITACION/ANTERIOR}&amp;LIC_ID={/ImprimirOferta/LIC_ID}">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='boton_oferta_anterior']/node()"/>
			</a>&nbsp;
			<a class="btnNormal" href="javascript:window.print()" style="margin-right:30px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>&nbsp;
			<a id="botonProdSiguiente" class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/ImprimirOferta2022.xsql?LIC_PROV_ID={/ImprimirOferta/LICITACION/SIGUIENTE}&amp;LIC_ID={/ImprimirOferta/LIC_ID}">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='boton_oferta_siguiente']/node()"/>
			</a>
		</span>
	</p>
</div>
<br/>

<div class="divLeft">
	<!--<h1 class="titlePage">
		<xsl:value-of select="/ImprimirOferta/LICITACION/LIC_TITULO"/>&nbsp;&nbsp;&nbsp;
		<span style="font-size:12px;padding:4px 8px;background:#F3F781;border:1px solid red;text-align:center;">
			<xsl:for-each select="/ImprimirOferta/LICITACION/PROVEEDORESLICITACION/PROVEEDOR">
				<xsl:if test="/ImprimirOferta/LIC_PROV_ID = IDPROVEEDOR_LIC">
					<xsl:choose>
					<xsl:when test="OFERTA">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='oferta']/node()"/>
					</xsl:when>
					<xsl:when test="OFERTA_RECHAZADA">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_rechazada']/node()"/>
					</xsl:when>
					<xsl:when test="ADJUDICADO">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado']/node()"/>
					</xsl:when>
					</xsl:choose>
				</xsl:if>
			</xsl:for-each>
		</span>
	</h1>-->

	<br/><br/>
	<table class="buscador">
		<tr class="subTituloTabla">
			<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='datos_generales']/node()"/>
				&nbsp;(<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:&nbsp;<xsl:value-of select="USUARIO/NOMBRE"/>)</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td class="labelRight veintecinco">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/ImprimirOferta/LICITACION/PROVEEDORESLICITACION/PROVEEDOR"/>
			</td>
		</tr>
		<tr>
			<td class="labelRight veintecinco">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/ImprimirOferta/LICITACION/LIC_TITULO"/>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/ImprimirOferta/LICITACION/LIC_FECHADECISIONPREVISTA"/>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/ImprimirOferta/LICITACION/LIC_DESCRIPCION"/>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_entrega']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/ImprimirOferta/LICITACION/LIC_CONDICIONESENTREGA"/>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_pago']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/ImprimirOferta/LICITACION/LIC_CONDICIONESPAGO"/>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_otras']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/ImprimirOferta/LICITACION/LIC_OTRASCONDICIONES"/>
			</td>
		</tr>
		<xsl:if test="/ImprimirOferta/LICITACION/LIC_MESESDURACION>0">
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='meses_duracion']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/ImprimirOferta/LICITACION/LIC_MESESDURACION"/>
			</td>
		</tr>
		</xsl:if>
	</table><!--fin de tala datos generales-->
</div><!--fin de divLeft-->

<div class="divLeft gris">
	<br/><br/>
	<table class="buscador">
	<thead>
		<tr class="subTituloTabla">
			<td colspan="2"><xsl:value-of select="document($doc)/translation/texts/item[@name='datos_oferta']/node()"/></td>
			<td colspan="7">&nbsp;</td>
		</tr>
		<tr class="gris">
			<td class="cinco">&nbsp;</td>
			<td class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></td>
			<td class="trenta" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></td>
			<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></td>
			<td class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/></td>
			<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></td>
			<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/></td>
		<xsl:if test="/ImprimirOferta/LICITACION/IDPAIS = 34">
			<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></td>
		</xsl:if>
			<td>&nbsp;</td>
		</tr>
	</thead>
	<tbody>
	<xsl:for-each select="/ImprimirOferta/LICITACION/PRODUCTOSLICITACION/PRODUCTO">
			<tr>
				<td><xsl:value-of select="LINEA"/></td>
				<td><xsl:value-of select="LIC_PROD_REFESTANDAR"/></td>
				<td class="datosLeft">
					<xsl:value-of select="LIC_PROD_NOMBRE"/>
					<xsl:if test="OFERTA_ADJUDICADA">&nbsp;<img src="http://www.newco.dev.br/images/check.gif"/></xsl:if>
				</td>
				<td><xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>
			<xsl:for-each select="OFERTA">
			<xsl:if test="LIC_OFE_IDPROVEEDORLIC = //ImprimirOferta/LIC_PROV_ID">
				<td><xsl:value-of select="LIC_OFE_REFERENCIA"/></td>
				<td><xsl:value-of select="LIC_OFE_MARCA"/></td>
				<td>
				<xsl:if test="/ImprimirOferta/LICITACION/IDPAIS = 55">R$&nbsp;</xsl:if>
					<xsl:value-of select="LIC_OFE_PRECIO"/>
				<xsl:if test="/ImprimirOferta/LICITACION/IDPAIS = 34">&nbsp;&#128;</xsl:if>
				</td>
				<xsl:if test="/ImprimirOferta/LICITACION/IDPAIS = 34">
				<td><xsl:value-of select="LIC_OFE_TIPOIVA"/>%</td>
				</xsl:if>
				<td>&nbsp;</td>
			</xsl:if>
			</xsl:for-each>
			</tr>
	</xsl:for-each>
	</tbody>
	</table>
</div><!--fin de divLeft-->

<div class="divLeft gris">
	<br/><br/>
	<table class="buscador">
	<xsl:for-each select="/ImprimirOferta/LICITACION/PROVEEDORESLICITACION/PROVEEDOR">
	<xsl:if test="IDPROVEEDOR_LIC = //ImprimirOferta/LIC_PROV_ID">
		<tr class="sinLInea">
			<td class="labelRight veintecinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:&nbsp;</td>
			<td class="datosLeft"><xsl:value-of select="NOMBRE"/></td>
		</tr>
		<tr class="sinLInea">
			<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:&nbsp;</td>
			<td class="datosLeft"><xsl:value-of select="USUARIO/NOMBRE"/></td>
		</tr>
	</xsl:if>
	</xsl:for-each>
	</table>
</div><!--fin de divLeft-->
</xsl:template>

<!-- Template para los proveedores -->
<xsl:template name="Imprimir_Oferta_para_Proveedor">
    <!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/ImprimirOferta/LANG"><xsl:value-of select="/ImprimirOferta/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<div class="ZonaTituloPagina">
	<p class="TituloPagina">
		<!--<xsl:value-of select="/ImprimirOferta/LICITACION/LIC_TITULO"/>-->
		<xsl:value-of select="/ImprimirOferta/LICITACION/PROVEEDOR"/>:&nbsp;
		<xsl:choose>
		<xsl:when test="/ImprimirOferta/LICITACION/PRODUCTOSLICITACION/OFERTA">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='oferta']/node()"/>
		</xsl:when>
		<xsl:when test="/ImprimirOferta/LICITACION/PRODUCTOSLICITACION/OFERTA_RECHAZADA">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_rechazada']/node()"/>
		</xsl:when>
		<xsl:when test="/ImprimirOferta/LICITACION/PRODUCTOSLICITACION/ADJUDICADO">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado']/node()"/>
		</xsl:when>
		</xsl:choose>
		&nbsp;<span class="fuentePeq">(<xsl:value-of select="/ImprimirOferta/LICITACION/USUARIO_PROVEEDOR"/>)</span>
		<span class="CompletarTitulo">
			<a class="btnNormal" href="javascript:window.print()" style="margin-right:30px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>&nbsp;
		</span>
	</p>
</div>
<br/>

<!--
<div class="divLeft">

	<h1 class="titlePage" style="float:left;width:20%;height:40px;">
	<xsl:if test="/ImprimirOferta/LICITACION/ANTERIOR">
		<div id="botonProdAnterior" style="margin-left:20px;">
			<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/ImprimirOferta.xsql?LIC_PROV_ID={/ImprimirOferta/LICITACION/ANTERIOR}&amp;LIC_ID={/ImprimirOferta/LIC_ID}"><xsl:value-of select="document($doc)/translation/texts/item[@name='boton_oferta_anterior']/node()"/></a>
		</div>
	</xsl:if>
	</h1>
	<h1 class="titlePage" style="float:left;width:60%;height:40px;">
		<xsl:value-of select="/ImprimirOferta/LICITACION/LIC_TITULO"/>&nbsp;&nbsp;&nbsp;
		<span style="font-size:12px;padding:4px 8px;background:#F3F781;border:1px solid red;text-align:center;">
			<xsl:choose>
			<xsl:when test="/ImprimirOferta/LICITACION/PRODUCTOSLICITACION/OFERTA">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='oferta']/node()"/>
			</xsl:when>
			<xsl:when test="/ImprimirOferta/LICITACION/PRODUCTOSLICITACION/OFERTA_RECHAZADA">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_rechazada']/node()"/>
			</xsl:when>
			<xsl:when test="/ImprimirOferta/LICITACION/PRODUCTOSLICITACION/ADJUDICADO">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado']/node()"/>
			</xsl:when>
			</xsl:choose>
                </span>
	</h1>
	<h1 class="titlePage" style="float:left;width:20%;height:40px;">
	<xsl:if test="/ImprimirOferta/LICITACION/SIGUIENTE">
		<div id="botonProdSiguiente" style="float:right;margin-right:20px;">
			<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/ImprimirOferta.xsql?LIC_PROV_ID={/ImprimirOferta/LICITACION/SIGUIENTE}&amp;LIC_ID={/ImprimirOferta/LIC_ID}"><xsl:value-of select="document($doc)/translation/texts/item[@name='boton_oferta_siguiente']/node()"/></a>
		</div>
	</xsl:if>&nbsp;
	</h1>
-->
<div class="divLeft">
	<br/><br/>
	<br/><br/>
	<table cellspacing="6px" cellpadding="6px">
		<tr>
			<td class="labelRight w200px">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/ImprimirOferta/LICITACION/LIC_TITULO"/>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/ImprimirOferta/LICITACION/LIC_FECHADECISIONPREVISTA"/>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/ImprimirOferta/LICITACION/LIC_DESCRIPCION"/>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_entrega']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/ImprimirOferta/LICITACION/LIC_CONDICIONESENTREGA"/>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_pago']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/ImprimirOferta/LICITACION/LIC_CONDICIONESPAGO"/>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_otras']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/ImprimirOferta/LICITACION/LIC_OTRASCONDICIONES"/>
			</td>
		</tr>
		<xsl:if test="/ImprimirOferta/LICITACION/LIC_MESESDURACION>0">
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='meses_duracion']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/ImprimirOferta/LICITACION/LIC_MESESDURACION"/>
			</td>
		</tr>
		</xsl:if>
	</table><!--fin de tala datos generales-->
	<br/>
	<br/>
</div><!--fin de divLeft-->
<div class="tabela tabela_redonda">
<table cellspacing="6px" cellpadding="6px">
	<thead class="cabecalho_tabela">
	<tr>
		<th class="w1x"></th>
		<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
		<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></th>
		<th class="w1x"><xsl:value-of select="document($doc)/translation/texts/item[@name='adj']/node()"/>&nbsp;</th>
		<xsl:if test="/ImprimirOferta/LICITACION/IDPAIS != 55">
			<th class="textLeft w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/></th>
		</xsl:if>
		<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/></th>
		<th class="textLeft w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='lic_marca']/node()"/></th>
		<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></th>
		<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
		<th class="w50px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ud_por_lote_2line']/node()"/></th>
		<th class="w50px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_objetivo_sIVA_2line']/node()"/></th>
		<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></th>
		<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></th>
		<xsl:choose>
		<xsl:when test="/ImprimirOferta/LICITACION/IDPAIS = 34">
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></th>
		</xsl:when>
		<xsl:otherwise>
			<th class="w1x">&nbsp;</th>
		</xsl:otherwise>
		</xsl:choose>
			<th class="w1x">&nbsp;</th>
		</tr>
	</thead>
	<tbody class="corpo_tabela">
	<xsl:choose>
	<xsl:when test="not(/ImprimirOferta/LICITACION/PRODUCTOSLICITACION/NINGUNO_INFORMADO)">
	<xsl:for-each select="/ImprimirOferta/LICITACION/PRODUCTOSLICITACION/PRODUCTO">
		<!--<xsl:choose>
		<xsl:when test="/ImprimirOferta/LICITACION/LIC_IDESTADO = 'CURS' or /ImprimirOferta/LICITACION/LIC_IDESTADO = 'INF'">-->
			<xsl:if test="INFORMADA">
			<tr>
				<td class="color_status"><xsl:value-of select="LINEAINFORMADA"/></td>
				<td><xsl:value-of select="LIC_PROD_REFESTANDAR"/></td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="/ImprimirOferta/LICITACION/ROL = 'COMPRADOR'">
						<a href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion2022.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/ImprimirOferta/LICITACION/LIC_ID}">
						<xsl:value-of select="LIC_PROD_NOMBRE"/>
						</a>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="LIC_PROD_NOMBRE"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>
					<xsl:if test="OFERTA_ADJUDICADA">&nbsp;<img src="http://www.newco.dev.br/images/check.gif" style="vertical-align:top;"/></xsl:if>
				</td>
				<xsl:if test="/ImprimirOferta/LICITACION/IDPAIS != 55">
					<td class="textLeft"><xsl:value-of select="LIC_OFE_REFERENCIA"/></td>
				</xsl:if>
				<td class="textLeft"><xsl:value-of select="LIC_OFE_NOMBRE"/></td>
				<td class="textLeft"><xsl:value-of select="LIC_OFE_MARCA"/></td>
				<td><xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>
				<td><xsl:value-of select="LIC_PROD_CANTIDAD"/></td>
				<td><xsl:value-of select="LIC_OFE_UNIDADESPORLOTE"/></td>
				<td><xsl:value-of select="LIC_PROD_PRECIOOBJETIVO"/></td>
				<td>
				<xsl:if test="/ImprimirOferta/LICITACION/IDPAIS = 55">R$&nbsp;</xsl:if>
					<xsl:value-of select="LIC_OFE_PRECIO"/>
				<xsl:if test="/ImprimirOferta/LICITACION/IDPAIS = 34">&nbsp;&#128;</xsl:if>
				</td>
				<td><xsl:value-of select="LIC_OFE_CONSUMO"/></td>
			<xsl:choose>
			<xsl:when test="/ImprimirOferta/LICITACION/IDPAIS = 34">
				<td><xsl:value-of select="LIC_OFE_TIPOIVA"/>%</td>
			</xsl:when>
			<xsl:otherwise>
				<td>&nbsp;</td>
			</xsl:otherwise>
			</xsl:choose>
				<td>&nbsp;</td>
			</tr>
			</xsl:if>
	</xsl:for-each>
	</xsl:when>
	<xsl:otherwise>
		<tr><td colspan="14"><xsl:value-of select="document($doc)/translation/texts/item[@name='sin_ofertas_proveedor']/node()"/></td></tr>
	</xsl:otherwise>
	</xsl:choose>
	</tbody>
	<tfoot class="rodape_tabela">
		<tr><td colspan="15">&nbsp;</td></tr>
	</tfoot>
	</table>
</div><!--fin de divLeft-->
</xsl:template>
</xsl:stylesheet>
