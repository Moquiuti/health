<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Listado con las ofertas NO seleccionadas
	Ultima revision ET 24abr23 11:45 licProductosNoSeleccionados2022_210423.js
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
			<xsl:when test="/OfertasSeleccionadas/LANG"><xsl:value-of select="/OfertasSeleccionadas/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<meta http-equiv="Cache-Control" content="no-cache"/>

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Informe_productos_no_seleccionados']/node()"/>:&nbsp;<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_CODIGO"/>&nbsp;-&nbsp;<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_TITULO"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->
	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>		<!-- Para descargas excel	-->
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/licProductosNoSeleccionados2022_210423.js"></script>
	<script type="text/javascript">
	//	25jun20 "Adjudicar" y "Generar pedidos" desde Vencedores
	var IDLicitacion=<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_ID"/>;
	var IDCentroSel='<xsl:value-of select="/OfertasSeleccionadas/IDCENTROCOMPRAS"/>';
	var mesesSelected	= '<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_MESESDURACION"/>';
	var isLicAgregada	= '<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_AGREGADA"/>';
	var NumCentrosPendientes= '<xsl:value-of select="/OfertasSeleccionadas/LICITACION/CENTROS_PENDIENTES_INFORMAR"/>';
	var totalProductos= '<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_NUMEROLINEAS"/>';
	var numProdsSeleccion	= '<xsl:value-of select="/OfertasSeleccionadas/LICITACION/TOTAL_SELECCIONADAS"/>';
	var numProvsNoCumplen	= '<xsl:value-of select="/OfertasSeleccionadas/LICITACION/TOTAL_NO_CUMPLEN_PEDMINIMO"/>';
	var numProdsRevisarUdesLote	= '<xsl:value-of select="/OfertasSeleccionadas/LICITACION/TOTAL_REVISAR_UNIDADESPORLOTE"/>';
	var conCircuitoAprobacion = '<xsl:value-of select="/OfertasSeleccionadas/LICITACION/CON_CIRCUITO_APROBACION"/>';
	var saltarPedMinimo = '<xsl:value-of select="/OfertasSeleccionadas/LICITACION/SALTARPEDIDOMINIMO"/>';
	var fechaEntregaPedidoVencida = '<xsl:choose><xsl:when test="/OfertasSeleccionadas/LICITACION/FECHA_PEDIDO_VENCIDA">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';

	// Mensajes y avisos
	var	strConfirmarPedido='<xsl:value-of select="document($doc)/translation/texts/item[@name='Seguro_enviar_pedido']/node()"/>';
	var	strConfirmarPedidoConCircuito='<xsl:value-of select="document($doc)/translation/texts/item[@name='Seguro_enviar_pedido_con_circuito']/node()"/>';
	var	strConfirmarPedidoConCambioUdes='<xsl:value-of select="document($doc)/translation/texts/item[@name='Seguro_enviar_pedido_con_cambio_udes']/node()"/>';
	var alrt_GenerarPedidoOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='success_generar_pedido']/node()"/>';
	var alrt_sinProductosSeleccionados	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_productos_seleccionados']/node()"/>';
	var conf_CentrosPendientesInformar	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='centros_pendientes_informar']/node()"/>';
	var alrt_avisoSaltarPedidoMinimo= '<xsl:value-of select="document($doc)/translation/texts/item[@name='aviso_saltar_pedido_minimo']/node()"/>';
	var conf_autoeditar_uds_x_lote	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='autoeditar_uds_x_lote']/node()"/>';
	var strAvisoCambioUnidades = '<xsl:value-of select="document($doc)/translation/texts/item[@name='aviso_cambio_uds_x_lote']/node()"/>';
	var conf_adjudicar1	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='confirm_boton_adjudicar_1']/node()"/>';
	var conf_adjudicar2	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='confirm_boton_adjudicar_2']/node()"/>';
	var alrt_ErrorPedido= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_enviar_pedido']/node()"/>';
	var alrt_FechaEntregaVencida= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Aviso_fecha_entrega_vencida']/node()"/>';
	var alrt_faltaSeleccProductos	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='revisa_seleccion_productos']/node()"/>';	

	// 29dic22 mensajes para la firma de la licitacion
	var alrt_FirmaCorrecta		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Firma_correcta']/node()"/>';
	var alrt_LicitacionFirmada	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion_firmada']/node()"/>';
	var alrt_LicitacionRechazada= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion_rechazada']/node()"/>';
	var alrt_errorFirmando		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Error_al_firmar_licitacion']/node()"/>';
	var alrt_RechazoRequiereMotivo= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Rechazo_requiere_motivo']/node()"/>';
	
	var arrProductos			= new Array();
	<xsl:for-each select="/OfertasSeleccionadas/LICITACION/PRODUCTOS_SIN_OFERTA/PRODUCTO">
		var producto		= [];
		producto['Nombre']		= '<xsl:value-of select="LIC_PROD_NOMBRE"/>';						//9mar22 Version JS, evitar problemas con comilla simple
		producto['IDProducto']	= '<xsl:value-of select="LIC_PROD_ID"/>';
		producto['IDProdEstandar']	= '<xsl:value-of select="LIC_PROD_IDPRODESTANDAR"/>';
		producto['Referencia']	= '<xsl:value-of select="PRO_REFERENCIA"/>';
		producto['Refestandar']	= '<xsl:value-of select="LIC_PROD_REFESTANDAR"/>';
		producto['RefCliente']	= '<xsl:value-of select="LIC_PROD_REFCLIENTE"/>';
		producto['RefCentro']	= '<xsl:value-of select="REFCENTRO"/>';
		producto['UdBasica']	= '<xsl:value-of select="LIC_PROD_UNIDADBASICA"/>';
		producto['Cantidad']	= '<xsl:value-of select="LIC_PROD_CANTIDAD"/>';
		producto['PrecioRef']	= '<xsl:value-of select="LIC_PROD_PRECIOREFERENCIA"/>';
		producto['TotalLinea']	= '<xsl:value-of select="LIC_PROD_CONSUMOHISTORICO"/>';
		arrProductos.push(producto);
	</xsl:for-each>
	
	//	Cadenas para el CSV
	var strTitulo='<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_TITULO"/>';

	var strFechaInforme='<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_informe']/node()"/>';
	var FechaInforme='<xsl:value-of select="/OfertasSeleccionadas/LICITACION/FECHAACTUAL"/>';

	var strFechaDecision='<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/>';
	var FechaDecision='<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_FECHADECISIONPREVISTA"/>';

	var strDescripcion='<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>';
	var Descripcion='<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_DESCRIPCION"/>';
	
	var strCondEntrega='<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_entrega']/node()"/>';
	var CondEntrega='<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_CONDICIONESENTREGA"/>';
	
	var strCondPago='<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_pago']/node()"/>';
	var CondPago='<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_CONDICIONESPAGO"/>';
	
	var strCondOtras='<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_otras']/node()"/>';
	var CondOtras='<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_OTRASCONDICIONES"/>';
	
	var strMesesDuracion='<xsl:value-of select="document($doc)/translation/texts/item[@name='meses_duracion']/node()"/>';
	var MesesDuracion=<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_MESESDURACION"/>;
	
	var strResponsable='<xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/>';
	var Responsable='<xsl:value-of select="/OfertasSeleccionadas/LICITACION/RESPONSABLE/USUARIO/USUARIO"/>';

	var strEmail='<xsl:value-of select="document($doc)/translation/texts/item[@name='email']/node()"/>';
	var Email='<xsl:value-of select="/OfertasSeleccionadas/LICITACION/RESPONSABLE/USUARIO/US_EMAIL"/>';

	var strTelefono='<xsl:value-of select="document($doc)/translation/texts/item[@name='telefono']/node()"/>';
	var Telefono='<xsl:value-of select="/OfertasSeleccionadas/LICITACION/RESPONSABLE/USUARIO/US_TF_FIJO"/>';
	
	var strRefMVM='<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_mvm']/node()"/>';
	var strRefCliente='<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>';
	var strNombre='<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>';
	var strUdBasica='<xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/>';
	var strCantidad='<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/>';
	var strTotalLinea='<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_linea']/node()"/>';
	var strPrecioRef='<xsl:value-of select="document($doc)/translation/texts/item[@name='precio historico']/node()"/>';	
	
	</script>
</head>
<body>
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

	<xsl:call-template name="Productos_no_seleccionados"/>

	</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>

<!-- Template para los clientes -->
<xsl:template name="Productos_no_seleccionados">
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
    <div class="divLeft textLeft marginTop20 fondoGris">
		&nbsp;<img src="{/OfertasSeleccionadas/LICITACION/EMPRESA_MVM/URL_LOGOTIPO}" height="60px" width="350px" class="valignM"/>
		<span class="tituloTabla marginLeft100 valignM "><xsl:value-of select="document($doc)/translation/texts/item[@name='Informe_productos_no_seleccionados']/node()"/></span>
		<span class="CompletarTitulo200 valignM">
		<br/>
			<a class="btnNormal valignM" href="javascript:DescargarExcel();">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/>
			</a>
		</span>
	</div>
    <div class="divLeft marginTop20">
		<table cellspacing="6px" cellpadding="6px" class="w600px marginLeft200">
		<tr>
			<td class="labelLeft w200px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion']/node()"/>:</td>
			<td><a href="javascript:AbrirLicitacion()"><strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_CODIGO"/>:&nbsp;<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_TITULO"/></strong></a></td>
		</tr>
		<tr>
			<td class="labelLeft w200px"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</td>
			<td><strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_DESCRIPCION"/></strong></td>
		</tr>
		<tr>
			<td class="labelLeft w200px"><xsl:value-of select="document($doc)/translation/texts/item[@name='otras_condiciones']/node()"/>:</td>
			<td><strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_OTRASCONDICIONES"/></strong></td>
		</tr>
		<tr>
			<td class="labelLeft w200px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_informe']/node()"/>:</td>
			<td><strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/FECHAACTUAL"/></strong></td>
		</tr>
		<tr>
			<td class="labelLeft w200px"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/>:</td>
			<td><strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/RESPONSABLE/USUARIO/USUARIO"/></strong></td>
		</tr>
		<tr>
			<td class="labelLeft w200px"><xsl:value-of select="document($doc)/translation/texts/item[@name='email']/node()"/>:</td>
			<td><strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/RESPONSABLE/USUARIO/US_EMAIL"/></strong></td>
		</tr>
		<tr>
			<td class="labelLeft w200px"><xsl:value-of select="document($doc)/translation/texts/item[@name='telefono']/node()"/>:</td>
			<td><strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/RESPONSABLE/USUARIO/US_TF_FIJO"/></strong></td>
		</tr>
		</table>
	</div>


</div>

<div class="divLeft">
	<div class="tabela tabela_redonda">
	<table cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
		<tr>
			<th class="w1px">&nbsp;</th>
			<th class="w80px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
			<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></th>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio historico']/node()"/></th>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34">
				<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></th>
			</xsl:if>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Total_linea']/node()"/></th>
			<th>&nbsp;</th>
		</tr>
	</thead>
	<tbody class="corpo_tabela">
	<xsl:for-each select="/OfertasSeleccionadas/LICITACION/PRODUCTOS_SIN_OFERTA/PRODUCTO">
		<tr class="conhover">
			<td class="color_status"><xsl:value-of select="CONTADOR"/></td>
			<td><xsl:value-of select="REFERENCIA"/></td>
			<td class="textLeft">
				<a href="javascript:chFichaProductoLicitacion({/OfertasSeleccionadas/LICITACION/LIC_ID},{LIC_PROD_ID},'VENCEDORES');"><xsl:value-of select="LIC_PROD_NOMBRE"/></a>
			</td>
			<td><xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>
			<td class="textRight">
			<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/>&nbsp;<xsl:value-of select="LIC_PROD_PRECIOREFERENCIA"/>&nbsp;<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
			</td>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34">
				<td><xsl:value-of select="LIC_PROD_TIPOIVA"/>%</td>
			</xsl:if>
			<td class="textRight"><xsl:value-of select="LIC_PROD_CANTIDAD"/></td>&nbsp;
			<td class="textRight">
			<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/>&nbsp;<xsl:value-of select="LIC_PROD_CONSUMOHISTORICO"/>&nbsp;<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
			</td>
			<td>&nbsp;</td>
		</tr>
	</xsl:for-each>
	</tbody>
	<tfoot class="rodape_tabela">
		<tr><td colspan="9">&nbsp;</td></tr>
	</tfoot>
	</table>
	</div>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
</div><!--fin de divLeft-->

</xsl:template>

</xsl:stylesheet>
