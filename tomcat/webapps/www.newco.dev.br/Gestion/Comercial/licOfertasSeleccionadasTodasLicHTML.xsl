<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Ficha con las ofertas seleccionadas, "Vencedores" para todas las licitaciones activas
	Ultima revision ET 24jul18
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
			<xsl:when test="/OfertasSeleccionadas/LANG"><xsl:value-of select="/OfertasSeleccionadas/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<meta http-equiv="Cache-Control" content="no-cache"/>

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='ofertas']/node()"/>:&nbsp;<xsl:value-of select="/OfertasSeleccionadas/LICITACIONES/LIC_TITULO"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->
<!--
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	-->
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

	<!--
	<div class="cabeceraBox" style="background:#FFF; margin:0px;">
		<!- -
		<div class="logoPage" id="logoPage">
			<div class="logoPageInside">
				<img src="http://www.newco.dev.br/images/logoMVM2016.gif" />
			</div><!- -fin de logo- ->
		</div><!- -fin de logoPage
		<br/>
	</div><!- -fin de cabeceraBox-->

	<xsl:call-template name="Ofertas_Seleccionadas"/>

	</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>

<!-- Template para los clientes -->
<xsl:template name="Ofertas_Seleccionadas">
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

	<form method="post">

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>
		&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion']/node()"/>
		&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Vencedores']/node()"/></span>
		</p>
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatoria']/node()"/>:&nbsp;
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/OfertasSeleccionadas/LICITACIONES/FIDCONVOCATORIA/field"/>
				<xsl:with-param name="onChange">javascript:document.forms[0].submit();</xsl:with-param>
				<xsl:with-param name="style">width:200px;height:25px;font-size:16px;</xsl:with-param>
			</xsl:call-template>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:&nbsp;
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/OfertasSeleccionadas/LICITACIONES/FIDPROVEEDOR/field"/>
				<xsl:with-param name="onChange">javascript:document.forms[0].submit();</xsl:with-param>
				<xsl:with-param name="style">width:300px;height:25px;font-size:16px;</xsl:with-param>
			</xsl:call-template>
			
			
			<span class="CompletarTitulo" style="width:300px;">
				<!--
				<a class="btnNormal" style="text-decoration:none;">
					<xsl:attribute name="href">javascript:listadoExcel();</xsl:attribute>
					<img src="http://www.newco.dev.br/images/iconoExcel.gif">
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_excel']/node()"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_excel']/node()"/></xsl:attribute>
					</img>
				</a>
				&nbsp;
				<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/licOfertasSeleccionadasImpr.xsql?US_ID={/OfertasSeleccionadas/US_ID}&amp;LIC_ID={/OfertasSeleccionadas/LIC_ID}&amp;IDCENTROCOMPRAS={/OfertasSeleccionadas/IDCENTROCOMPRAS}"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
				&nbsp;
				-->
				
				<a class="btnNormal" style="text-decoration:none;"  href="javascript:window.close()"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>
			</span>
		</p>
	</div>
	<!--
	<h1 class="titlePage">
		<xsl:value-of select="/OfertasSeleccionadas/LICITACIONES/LIC_TITULO"/>&nbsp;&nbsp;&nbsp;&nbsp;
		
		<xsl:if test="/OfertasSeleccionadas/LICITACIONES/LIC_AGREGADA = 'S'">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/OfertasSeleccionadas/LICITACIONES/CENTROSCOMPRAS/field"/>
			<xsl:with-param name="onChange">javascript:document.forms[0].submit();</xsl:with-param>
		</xsl:call-template>
		</xsl:if>
		
	</h1>
	-->
	</form>

	<!--<table class="infoTable">-->
	<br/>
	<br/>
	<br/>
	<!--
	<table class="buscador">
		<tr class="sinLinea">
			<td class="labelRight" style="width:25%;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/OfertasSeleccionadas/LICITACIONES/LIC_FECHADECISIONPREVISTA"/></strong>
			</td>
		</tr>
	</table>-->
	<!--fin de tala datos generales-->
	<br/>
	<br/>
	<br/>
</div><!--fin de divLeft-->

<div class="divLeft">
	<form id="Proveedores" name="Proveedores" method="POST">
	<xsl:for-each select="/OfertasSeleccionadas/LICITACIONES/PROVEEDORES/PROVEEDOR">
	<!--<table class="infoTable">-->
	<table class="buscador">
	<thead>
		<tr class="subTituloTabla">
			<td colspan="11" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;		
			<xsl:if test="NO_CUMPLE_PEDIDO_MINIMO">
				<img src="http://www.newco.dev.br/images/urgente.gif"/>
			</xsl:if>
			<xsl:value-of select="EMP_NIF"/>&nbsp;&nbsp;
			<xsl:if test="DATOSPRIVADOS/COP_CODIGO  != '' ">
				&nbsp;(<xsl:value-of select="DATOSPRIVADOS/COP_CODIGO"/>)&nbsp;
			</xsl:if>
			<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDPROVEEDOR}&amp;ESTADO=CABECERA','Detalle Empresa',100,80,0,0);">
			<xsl:value-of select="NOMBRECORTO"/>
			</a>
			&nbsp;
			<xsl:if test="DATOSPRIVADOS/COP_NOMBREBANCO  != '' ">
				&nbsp;(<xsl:value-of select="document($doc)/translation/texts/item[@name='Cuenta_bancaria']/node()"/>:&nbsp;
					<xsl:value-of select="DATOSPRIVADOS/COP_NOMBREBANCO"/>&nbsp;<xsl:value-of select="DATOSPRIVADOS/COP_CODBANCO"/>&nbsp;<xsl:value-of select="DATOSPRIVADOS/COP_CODOFICINA"/>&nbsp;<xsl:value-of select="DATOSPRIVADOS/COP_CODCUENTA"/>)&nbsp;
			</xsl:if>
			&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/>:&nbsp;<xsl:value-of select="PEDMINIMO_IMPORTE"/><xsl:value-of select="/OfertasSeleccionadas/LICITACIONES/DIVISA/SUFIJO"/>
			&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:&nbsp;<xsl:value-of select="CONSUMOADJUDICADO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACIONES/DIVISA/SUFIJO"/>
			</td>
		</tr>
		<!--
		<tr class="subTituloTabla">
			<td colspan="11" align="center">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/>:&nbsp;<xsl:value-of select="LIC_PROV_PLAZOENTREGA"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='dias']/node()"/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='forma_pago']/node()"/>:&nbsp;
				<xsl:value-of select="FORMAPAGO"/>,&nbsp;<xsl:value-of select="PLAZOPAGO"/>
			</td>
		</tr>
		-->
		<tr class="gris">
			<td class="uno">&nbsp;</td>
			<td class="siete"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></strong></td>
			<td class="trenta" style="text-align:left;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></strong></td>
			<td class="cinco"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></strong></td>
			<td class="quince"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></strong></td>
			<xsl:if test="/OfertasSeleccionadas/LICITACIONES/IDPAIS != 55">
				<td class="siete"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/></strong></td>
			</xsl:if>
			<td class="cinco"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/></strong></td>
			<xsl:if test="/OfertasSeleccionadas/LICITACIONES/IDPAIS != 55">
				<td class="cinco"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></strong></td>
			</xsl:if>
			<td class="cinco"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></strong></td>
			<td class="cinco"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></strong></td>
			<td class="cinco">&nbsp;</td>
		</tr>
	</thead>
	<tbody>
	<xsl:for-each select="OFERTA">
		<tr class="gris">
			<td><xsl:value-of select="CONTADOR"/></td>
			<td>
				<xsl:choose>
				<!-- para liciatciones no agregadas o si no está seleccionado un centro	-->
				<xsl:when test="LIC_PROD_REFCLIENTE != ''"><xsl:value-of select="LIC_PROD_REFCLIENTE"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="LIC_PROD_REFESTANDAR"/></xsl:otherwise>
				</xsl:choose>
			</td>
			<td class="datosLeft">
				<a href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/OfertasSeleccionadas/LICITACIONES/LIC_ID}">
				<xsl:value-of select="LIC_PROD_NOMBRE"/></a>
			</td>
			<td><xsl:value-of select="LIC_OFE_MARCA"/></td>
			<td><xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>
			<xsl:if test="/OfertasSeleccionadas/LICITACIONES/IDPAIS != 55">
				<td><xsl:value-of select="LIC_OFE_REFERENCIA"/></td>
			</xsl:if>
			<td class="datosRight">
			<xsl:value-of select="LIC_OFE_PRECIO"/>
			</td>
			<xsl:if test="/OfertasSeleccionadas/LICITACIONES/IDPAIS != 55">
				<td><xsl:value-of select="LIC_OFE_TIPOIVA"/>%</td>
			</xsl:if>
			<td class="datosRight"><xsl:value-of select="CANTIDAD"/>&nbsp;</td>
			<td class="datosRight">
			<xsl:value-of select="CONSUMO"/>
			</td>
			<td>&nbsp;</td>
		</tr>
	</xsl:for-each>
	</tbody>
	</table>
	<br/>
	<br/>
	</xsl:for-each>
	</form>
</div><!--fin de divLeft-->

</xsl:template>

</xsl:stylesheet>
