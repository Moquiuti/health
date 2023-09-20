<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Ficha con las ofertas seleccionadas, "Vencedores"	
	Ultima revision: ET 19oct20 10:00 licInformePedidos_250620.js
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
			<xsl:when test="/InformePedidos/LANG"><xsl:value-of select="/InformePedidos/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<meta http-equiv="Cache-Control" content="no-cache"/>

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Informe_pedidos_licitacion']/node()"/>:&nbsp;<xsl:value-of select="/InformePedidos/LICITACION/LIC_TITULO"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/licInformePedidos_250620.js"></script>
	<script type="text/javascript">
	//	25jun20 "Adjudicar" y "Generar pedidos" desde Vencedores
	var IDLicitacion=<xsl:value-of select="/InformePedidos/LICITACION/LIC_ID"/>;
	var mesesSelected	= '<xsl:value-of select="/InformePedidos/LICITACION/LIC_MESESDURACION"/>';
	var isLicAgregada	= '<xsl:value-of select="/InformePedidos/LICITACION/LIC_AGREGADA"/>';
	var NumCentrosPendientes= '<xsl:value-of select="/InformePedidos/LICITACION/CENTROS_PENDIENTES_INFORMAR"/>';
	var totalProductos= '<xsl:value-of select="/InformePedidos/LICITACION/LIC_NUMEROLINEAS"/>';
	var numProdsSeleccion	= '<xsl:value-of select="/InformePedidos/LICITACION/TOTAL_SELECCIONADAS"/>';
	var numProvsNoCumplen	= '<xsl:value-of select="/InformePedidos/LICITACION/TOTAL_NO_CUMPLEN_PEDMINIMO"/>';
	var numProdsRevisarUdesLote	= '<xsl:value-of select="/InformePedidos/LICITACION/TOTAL_REVISAR_UNIDADESPORLOTE"/>';
	var conCircuitoAprobacion = '<xsl:value-of select="/InformePedidos/LICITACION/CON_CIRCUITO_APROBACION"/>';

	//	Mensajes y avisos
	var	strConfirmarPedido='<xsl:value-of select="document($doc)/translation/texts/item[@name='Seguro_enviar_pedido']/node()"/>';
	var	strConfirmarPedidoConCircuito='<xsl:value-of select="document($doc)/translation/texts/item[@name='Seguro_enviar_pedido_con_circuito']/node()"/>';
	var	strConfirmarPedidoConCambioUdes='<xsl:value-of select="document($doc)/translation/texts/item[@name='Seguro_enviar_pedido_con_cambio_udes']/node()"/>';
	var alrt_GenerarPedidoOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='success_generar_pedido']/node()"/>';
	var alrt_sinProductosSeleccionados	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_productos_seleccionados']/node()"/>';
	var conf_CentrosPendientesInformar	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='centros_pendientes_informar']/node()"/>';
	var alrt_avisoSaltarPedidoMinimo= '<xsl:value-of select="document($doc)/translation/texts/item[@name='aviso_saltar_pedido_minimo']/node()"/>';
	var conf_autoeditar_uds_x_lote	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='autoeditar_uds_x_lote']/node()"/>';
	var conf_adjudicar1	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='confirm_boton_adjudicar_1']/node()"/>';
	var conf_adjudicar2	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='confirm_boton_adjudicar_2']/node()"/>';
	</script>
</head>
<body class="gris">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/InformePedidos/LANG"><xsl:value-of select="/InformePedidos/LANG"/></xsl:when>
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
			<xsl:when test="/InformePedidos/LANG"><xsl:value-of select="/InformePedidos/LANG"/></xsl:when>
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
		<xsl:when test="/InformePedidos/LANG"><xsl:value-of select="/InformePedidos/LANG"/></xsl:when>
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
		&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Informe_pedidos_licitacion']/node()"/></span>
		
		</p>
		<p class="TituloPagina">
			<xsl:value-of select="/InformePedidos/LICITACION/LIC_CODIGO"/>:&nbsp;<xsl:value-of select="/InformePedidos/LICITACION/LIC_TITULO"/>
			<span class="CompletarTitulo" style="width:870px;">
				<a class="btnNormal" href="javascript:window.print();"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
				&nbsp;
				<a class="btnNormal" style="text-decoration:none;"  href="javascript:window.close()"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>
				&nbsp;
			</span>
		</p>
	</div>
	<!--
	<h1 class="titlePage">
		<xsl:value-of select="/InformePedidos/LICITACION/LIC_TITULO"/>&nbsp;&nbsp;&nbsp;&nbsp;
		
		<xsl:if test="/InformePedidos/LICITACION/LIC_AGREGADA = 'S'">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/InformePedidos/LICITACION/CENTROSCOMPRAS/field"/>
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
	<table class="buscador">
		<tr class="sinLinea">
			<td class="labelRight" style="width:25%;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_informe']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformePedidos/LICITACION/FECHAACTUAL"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight" style="width:25%;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformePedidos/LICITACION/LIC_FECHADECISIONPREVISTA"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformePedidos/LICITACION/LIC_DESCRIPCION"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_entrega']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/InformePedidos/LICITACION/LIC_CONDICIONESENTREGA"/>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_pago']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/InformePedidos/LICITACION/LIC_CONDICIONESPAGO"/>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_otras']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/InformePedidos/LICITACION/LIC_OTRASCONDICIONES"/>
			</td>
		</tr>
		<xsl:if test="/InformePedidos/LICITACION/LIC_MESESDURACION>0">
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='meses_duracion']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/InformePedidos/LICITACION/LIC_MESESDURACION"/>
			</td>
		</tr>
		</xsl:if>
		<xsl:if test="/InformePedidos/LICITACION/TOTAL_ALAVISTA">
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_alavista']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/InformePedidos/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/InformePedidos/LICITACION/TOTAL_ALAVISTA"/><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/SUFIJO"/>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_aplazado']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/InformePedidos/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/InformePedidos/LICITACION/TOTAL_APLAZADO"/><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/SUFIJO"/>
			</td>
		</tr>
		</xsl:if>
		<xsl:if test="/InformePedidos/LICITACION/TOTAL_PEDIDOS">
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_pedidos']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/InformePedidos/LICITACION/TOTAL_PEDIDOS"/><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/SUFIJO"/></strong>
			</td>
		</tr>
		</xsl:if>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_adjudicado']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/InformePedidos/LICITACION/LIC_CONSUMOADJUDICADO"/><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/SUFIJO"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformePedidos/LICITACION/PRODUCTOSADJUDICADOS"/>/<xsl:value-of select="/InformePedidos/LICITACION/LIC_NUMEROLINEAS"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformePedidos/LICITACION/LIC_PROVEEDORESADJUDICADOS"/>/<xsl:value-of select="/InformePedidos/LICITACION/LIC_NUMEROPROVEEDORES"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro']/node()"/> (%):&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/InformePedidos/LICITACION/LIC_AHORROADJUDICADO"/>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/InformePedidos/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/InformePedidos/LICITACION/LIC_AHORROADJUDICADO_TOT"/><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/SUFIJO"/>
			</td>
		</tr>
	</table><!--fin de tala datos generales-->
	<br/>
	<br/>
	<br/>
</div><!--fin de divLeft-->

<div class="divLeft">
	<form id="Proveedores" name="Proveedores" action="http://www.newco.dev.br/Gestion/Comercial/licInformePedidos.xsql" method="POST">
	<input type="hidden" name="IDLicitacion" value="{/InformePedidos/LICITACION/LIC_ID}"/>		<!--	para el JS	-->
	<input type="hidden" name="LIC_ID" value="{/InformePedidos/LICITACION/LIC_ID}"/>				<!--	se utiliza en el XSQL		-->
	<input type="hidden" name="IDCentro" value="{/InformePedidos/LICITACION/IDCENTRO}"/>
	<input type="hidden" name="ACCION" value=""/>
	<input type="hidden" name="PARAMETROS" value=""/>
	<xsl:for-each select="/InformePedidos/LICITACION/PROVEEDORES/PROVEEDOR/PEDIDOS/PEDIDO">
	<!--<table class="infoTable">-->
	<table class="buscador">
	<thead>
		<!--<tr class="subTituloTabla">-->
		<tr>
			<xsl:choose>
			<xsl:when test="NO_CUMPLE_PEDIDO_MINIMO">
				<xsl:attribute name="class">subTituloFondoRojo</xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="class">subTituloTabla</xsl:attribute>
			</xsl:otherwise>
			</xsl:choose>
			
			<td colspan="11" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;		
			<!--
			<xsl:if test="NO_CUMPLE_PEDIDO_MINIMO">
				<img src="http://www.newco.dev.br/images/urgente.gif"/>
			</xsl:if>
			-->
			<xsl:if test="/InformePedidos/LICITACION/LIC_AGREGADA='S'">
				&nbsp;<xsl:value-of select="CENTROCLIENTE"/>:&nbsp;
			</xsl:if>
			<xsl:value-of select="../../EMP_NIF"/>&nbsp;&nbsp;
			<xsl:if test="../../DATOSPRIVADOS/COP_CODIGO  != '' ">
				&nbsp;(<xsl:value-of select="../../DATOSPRIVADOS/COP_CODIGO"/>)&nbsp;
			</xsl:if>
			<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={../../IDPROVEEDOR}&amp;ESTADO=CABECERA','Detalle Empresa',100,80,0,0);">
			<xsl:value-of select="../../NOMBRECORTO"/>
			</a>
			&nbsp;
			<xsl:if test="/InformePedidos/LICITACION/AUTOR">
			<a href="javascript:conversacionProveedor({IDPROVEEDOR});" style="text-decoration:none;"><img>
				<xsl:attribute name="src">
				<xsl:choose>
				<xsl:when test="EXISTE_CONVERSACION">http://www.newco.dev.br/images/bocadillo.gif</xsl:when>
				<xsl:otherwise>http://www.newco.dev.br/images/bocadilloPlus.gif</xsl:otherwise>
				</xsl:choose>
				</xsl:attribute>
			</img>
			</a>
			&nbsp;
			</xsl:if>
			<xsl:if test="../../DATOSPRIVADOS/COP_NOMBREBANCO  != '' ">
				&nbsp;(<xsl:value-of select="document($doc)/translation/texts/item[@name='Cuenta_bancaria']/node()"/>:&nbsp;
					<xsl:value-of select="../../DATOSPRIVADOS/COP_NOMBREBANCO"/>&nbsp;<xsl:value-of select="../../DATOSPRIVADOS/COP_CODBANCO"/>&nbsp;<xsl:value-of select="../../DATOSPRIVADOS/COP_CODOFICINA"/>&nbsp;<xsl:value-of select="../../DATOSPRIVADOS/COP_CODCUENTA"/>)&nbsp;
			</xsl:if>
			&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/>:&nbsp;<xsl:value-of select="/InformePedidos/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="../../LIC_PROV_PEDIDOMINIMO"/><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/SUFIJO"/>
			&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:&nbsp;<xsl:value-of select="/InformePedidos/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="../../LIC_PROV_CONSUMOADJUDICADO"/><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/SUFIJO"/>
			&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>:&nbsp;<xsl:value-of select="NUMERO_PRODUCTOS"/>
			&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>:
			&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID={MO_ID}','Multioferta',100,80,0,0)"><xsl:value-of select="MO_NUMEROCLINICA"/>&nbsp;(<xsl:value-of select="/InformePedidos/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="MO_IMPORTETOTAL"/><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/SUFIJO"/>)</a>
			</td>
		</tr>
		<!--14may19	<tr class="subTituloTabla">-->
		<xsl:if test="../../LIC_PROV_COMENTARIOSPROV!=''">
			<tr>
				<td colspan="9" align="center">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones']/node()"/>:&nbsp;<xsl:value-of select="../../LIC_PROV_COMENTARIOSPROV"/>
				</td>
			</tr>
		</xsl:if>
		<tr>
			<td colspan="9" align="center">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/>:&nbsp;<xsl:value-of select="../../LIC_PROV_PLAZOENTREGA"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='dias']/node()"/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='forma_pago']/node()"/>:&nbsp;
				<xsl:value-of select="../FORMAPAGO"/>.&nbsp;<xsl:value-of select="../PLAZOPAGO"/>.
				<!--<xsl:choose>
				<xsl:when test="/InformePedidos/LICITACION/LIC_AGREGADA='S' and /InformePedidos/LICITACION/IDCENTROACTUAL=''">
					<xsl:value-of select="../../FORMAPAGO"/>.&nbsp;<xsl:value-of select="../../PLAZOPAGO"/>.
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="../../FORMASPAGO/field"/>
					<xsl:with-param name="id">FORMASPAGO_<xsl:value-of select="../../IDPROVEEDOR_LIC"/></xsl:with-param>
					<xsl:with-param name="onChange">javascript:ActivarCambio(<xsl:value-of select="../../IDPROVEEDOR_LIC"/>)</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="../../PLAZOSPAGO/field"/>
					<xsl:with-param name="id">PLAZOSPAGO_<xsl:value-of select="../../IDPROVEEDOR_LIC"/></xsl:with-param>
					<xsl:with-param name="onChange">javascript:ActivarCambio(<xsl:value-of select="../../IDPROVEEDOR_LIC"/>)</xsl:with-param>
					</xsl:call-template>
					<a class="guardarOferta btnDestacado" style="display:none;" id="BOTONGUARDAR_{../../IDPROVEEDOR_LIC}">
					<xsl:attribute name="href">
					<xsl:choose>
					<!- - para liciatciones no agregadas o si no está seleccionado un centro	- ->
					<xsl:when test="/InformePedidos/LICITACION/LIC_AGREGADA = 'N' or not (/InformePedidos/LICITACION/IDCENTRO != '')">javascript:GuardarFormaYPlazoPago(<xsl:value-of select="../../IDPROVEEDOR_LIC"/>);</xsl:when>
					<xsl:otherwise>javascript:GuardarFormaYPlazoPagoCentro(<xsl:value-of select="../../IDPROVEEDOR_LIC"/>);</xsl:otherwise>
					</xsl:choose>
					</xsl:attribute>
					<! - -<img id="BOTONGUARDAR_{IDPROVEEDOR_LIC}" src="http://www.newco.dev.br/images/guardar.gif" class="" style="display:none;" title="{document($doc)/translation/texts/item[@name='guardar']/node()}" alt="{document($doc)/translation/texts/item[@name='guardar']/node()}"/>- ->
					<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
					</a>
					<span id="AVISOACCION_{../../IDPROVEEDOR_LIC}"/>
				</xsl:otherwise>
				</xsl:choose>-->
			</td>
			<td align="left">
				<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/ImprimirOferta.xsql?LIC_ID={/InformePedidos/LICITACION/LIC_ID}&amp;LIC_PROV_ID={IDPROVEEDOR_LIC}','Oferta',100,80,0,0);"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_ofertas']/node()"/></a>
			</td>
		</tr>
		<tr class="gris">
			<td class="uno">&nbsp;</td>
			<td class="cinco"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></strong></td>
			<td class="trenta" style="text-align:left;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></strong></td>
			<td class="cinco"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></strong></td>
			<td class="quince"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></strong></td>
			<xsl:if test="/InformePedidos/LICITACION/IDPAIS != 55">
				<td class="siete"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/></strong></td>
			</xsl:if>
			<td class="diez"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/></strong></td>
			<xsl:if test="/InformePedidos/LICITACION/IDPAIS = 34">
				<td class="cinco"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></strong></td>
			</xsl:if>
			<td class="cinco"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='embalaje']/node()"/></strong></td>
			<td class="cinco"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></strong></td>
			<td class="cinco"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></strong></td>
			<td class="cinco fondogris"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ref']/node()"/></strong></td>
			<td class="cinco fondogris"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/></strong></td>
		</tr>
	</thead>
	<tbody>
		<xsl:for-each select="OFERTA">
			<tr>
				<xsl:attribute name="class">
				<xsl:choose>
				<xsl:when test="NO_CUADRAN_UNIDADES">
					fondoRojo
				</xsl:when>
				<xsl:otherwise>
					gris
				</xsl:otherwise>
				</xsl:choose>
				</xsl:attribute>
				<td><xsl:value-of select="CONTADOR"/></td>
				<td>
					<xsl:choose>
					<!-- para liciatciones no agregadas o si no está seleccionado un centro	-->
					<xsl:when test="LIC_PROD_REFCLIENTE != ''"><xsl:value-of select="LIC_PROD_REFCLIENTE"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="LIC_PROD_REFESTANDAR"/></xsl:otherwise>
					</xsl:choose>
				</td>
				<td class="datosLeft">
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/InformePedidos/LICITACION/LIC_ID}');">
					<xsl:value-of select="LIC_PROD_NOMBRE"/><xsl:if test="LIC_PROD_MARCASACEPTABLES != ''">&nbsp;[<xsl:value-of select="LIC_PROD_MARCASACEPTABLES"/>]</xsl:if></a>
				</td>
				<td><xsl:value-of select="LIC_OFE_MARCA"/></td>
				<td><xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>
				<xsl:if test="/InformePedidos/LICITACION/IDPAIS != 55">
					<td><xsl:value-of select="LIC_OFE_REFERENCIA"/></td>
				</xsl:if>
				<td class="datosRight">
					<xsl:value-of select="/InformePedidos/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="LMO_PRECIO"/><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/SUFIJO"/>
				<!--
				<xsl:if test="/InformePedidos/LICITACION/IDPAIS = 55">R$&nbsp;</xsl:if>
				<xsl:value-of select="LIC_OFE_PRECIO"/>
				<xsl:if test="/InformePedidos/LICITACION/IDPAIS = 34">&nbsp;&#128;</xsl:if>&nbsp;
				-->
				</td>
				<xsl:if test="/InformePedidos/LICITACION/IDPAIS != 55">
					<td><xsl:value-of select="LIC_OFE_TIPOIVA"/>%</td>
				</xsl:if>
				<td><xsl:value-of select="LMO_UNIDADESPORLOTE"/></td>
				<td>
					<xsl:if test="CAMBIO_CANTIDAD">
						(<xsl:value-of select="CAMBIO_CANTIDAD/CANTIDADORIGINAL"/>-><xsl:value-of select="CAMBIO_CANTIDAD/CANTIDAD"/>)&nbsp;
					</xsl:if>
					<strong><xsl:value-of select="CANTIDAD"/></strong>&nbsp;
				</td>
				<td class="datosRight">
					<xsl:value-of select="/InformePedidos/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="CONSUMO"/><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/SUFIJO"/>
				</td>
				<td class="datosRight fondogris">
					<xsl:value-of select="/InformePedidos/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="LIC_PROD_PRECIOREFERENCIA"/><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/SUFIJO"/>
				</td>
				<td class="datosRight fondogris">
					<xsl:value-of select="LIC_OFE_AHORRO"/>%
				</td>
			</tr>
		</xsl:for-each>
	</tbody>
	</table>
	<br/>
	<br/>
	</xsl:for-each>
	<xsl:if test="/InformePedidos/LICITACION/PRODUCTOS_SIN_OFERTA/PRODUCTO">
	<!--<table class="infoTable">-->
	<br/>
	<br/>
	<table class="buscador">
	<thead>
		<tr class="subTituloTabla">
			<td colspan="10" align="center">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_no_seleccionados']/node()"/>
			</td>
		</tr>
		<tr class="gris">
			<td class="cinco">&nbsp;</td>
			<td class="siete"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></strong></td>
			<td class="trenta" style="text-align:left;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></strong></td>
			<td class="quince"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></strong></td>
			<td class="diez"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/></strong></td>
			<xsl:if test="/InformePedidos/LICITACION/IDPAIS = 34">
				<td class="cinco"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></strong></td>
			</xsl:if>
			<td class="diez"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></strong></td>
			<td class="diez"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></strong></td>
			<td class="quince">&nbsp;</td>
		</tr>
	</thead>
	<tbody>
	<xsl:for-each select="/InformePedidos/LICITACION/PRODUCTOS_SIN_OFERTA/PRODUCTO">
		<tr class="gris">
			<td><xsl:value-of select="CONTADOR"/></td>
			<td><xsl:value-of select="REFERENCIA"/></td>
			<td class="datosLeft">
				<a href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/InformePedidos/LICITACION/LIC_ID}">
				<xsl:value-of select="LIC_PROD_NOMBRE"/></a>
			</td>
			<td><xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>
			<td class="datosRight">
			<xsl:if test="/InformePedidos/LICITACION/IDPAIS = 55 and LIC_PROD_PRECIO>0">R$&nbsp;</xsl:if>
			<xsl:value-of select="LIC_PROD_PRECIO"/>
			<xsl:if test="/InformePedidos/LICITACION/IDPAIS = 34 and LIC_PROD_PRECIO>0">&nbsp;&#128;</xsl:if>&nbsp;
			</td>
			<xsl:if test="/InformePedidos/LICITACION/IDPAIS = 34">
				<td><xsl:value-of select="LIC_PROD_TIPOIVA"/>%</td>
			</xsl:if>
			<td class="datosRight"><xsl:value-of select="LIC_PROD_CANTIDAD"/></td>&nbsp;
			<td class="datosRight">
			<xsl:if test="/InformePedidos/LICITACION/IDPAIS = 55 and LIC_PROD_CONSUMO>0">R$&nbsp;</xsl:if>
			<xsl:value-of select="LIC_PROD_CONSUMO"/>
			<xsl:if test="/InformePedidos/LICITACION/IDPAIS = 34 and LIC_PROD_CONSUMO>0">&nbsp;&#128;</xsl:if>&nbsp;
			</td>
			<td>&nbsp;</td>
		</tr>
	</xsl:for-each>
	</tbody>
	</table>
	</xsl:if>
	<xsl:if test="/InformePedidos/LICITACION/LOGPEDIDOS/ENTRADA">
	<!--<table class="infoTable">-->
	<br/>
	<br/>
	<br/>
	<table class="buscador">
	<thead>
		<tr class="subTituloTabla">
			<td colspan="10" align="center">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_con_justificacion']/node()"/>
			</td>
		</tr>
		<tr class="gris">
			<td class="uno">&nbsp;</td>
			<td class="cinco datosLeft">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></strong></td>
			<td class="diez datosLeft">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></strong></td>
			<td class="cinco datosLeft">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/></strong></td>
			<td class="cinco datosLeft">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></strong></td>
			<td class="datosLeft">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='justificacion']/node()"/></strong></td>
			<td class="uno">&nbsp;</td>
		</tr>
	</thead>
	<tbody>
	<xsl:for-each select="/InformePedidos/LICITACION/LOGPEDIDOS/ENTRADA">
		<tr class="gris">
			<td class="datosLeft">&nbsp;<xsl:value-of select="CONTADOR"/></td>
			<td class="datosLeft">&nbsp;<xsl:value-of select="FECHA"/></td>
			<td class="datosLeft">&nbsp;<xsl:value-of select="PROVEEDOR"/></td>
			<td class="datosLeft">&nbsp;&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID={MO_ID}','Multioferta',100,80,0,0)"><xsl:value-of select="CODPEDIDO"/></a></td>
			<td class="datosLeft">&nbsp;<xsl:value-of select="USUARIO"/></td>
			<td class="datosLeft">&nbsp;<xsl:value-of select="TEXTO"/></td>
			<td>&nbsp;</td>
		</tr>
	</xsl:for-each>
	</tbody>
	</table>
	</xsl:if>
	<br/>
	<br/>
	<br/>
	</form>
</div><!--fin de divLeft-->

</xsl:template>

</xsl:stylesheet>
