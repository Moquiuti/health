<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Ficha con las ofertas seleccionadas, "Vencedores"	
	Ultima revision ET 18jul23 23:00 licOfertasSeleccionadas2022_010623.js
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

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Vencedores']/node()"/>:&nbsp;<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_TITULO"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>		<!-- Para descargas excel	-->
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/licOfertasSeleccionadas2022_010623.js"></script>
	<script type="text/javascript">
	//	25jun20 "Adjudicar" y "Generar pedidos" desde Vencedores
	var IDLicitacion=<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_ID"/>;
	var IDCentroSel='<xsl:value-of select="/OfertasSeleccionadas/IDCENTROCOMPRAS"/>';
	var IDProdLicActivo	='<xsl:value-of select="/OfertasSeleccionadas/LIC_PROD_ID"/>';					//1jun23 Para activar el producto correspondiente
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
	<!--var incluirRefCentro = '<xsl:choose><xsl:when test="/OfertasSeleccionadas/LICITACION/INCLUIRREFCENTRO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';-->

	<!-- Mensajes y avisos	-->
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

	<!-- 29dic22 mensajes para la firma de la licitacion	-->
	var alrt_FirmaCorrecta		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Firma_correcta']/node()"/>';
	var alrt_LicitacionFirmada	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion_firmada']/node()"/>';
	var alrt_LicitacionRechazada= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion_rechazada']/node()"/>';
	var alrt_errorFirmando		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Error_al_firmar_licitacion']/node()"/>';
	var alrt_RechazoRequiereMotivo= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Rechazo_requiere_motivo']/node()"/>';
	
	var arrProveedores			= new Array();
	<xsl:for-each select="/OfertasSeleccionadas/LICITACION/PROVEEDORES/PROVEEDOR">
		var Proveedor			= [];
		
		Proveedor['ID']	= '<xsl:value-of select="IDPROVEEDOR"/>';
		Proveedor['IDCentro']	= '<xsl:value-of select="IDCENTRO"/>';					//	IMPORTANTE para multicentro
		Proveedor['IDProvLic']	= '<xsl:value-of select="IDPROVEEDOR_LIC"/>';
		Proveedor['Nombre']	= '<xsl:value-of select="NOMBRECORTO"/>';
		Proveedor['LicProvPedMin']	= '<xsl:value-of select="LIC_PROV_PEDIDOMINIMO"/>';
		Proveedor['Total']	= '<xsl:value-of select="LIC_PROV_CONSUMOADJUDICADO"/>';
		Proveedor['IDMultioferta']	= '<xsl:value-of select="PEDIDOS/PEDIDO/MO_ID"/>';
		
		Proveedor['PedidoMinimo']	= '<xsl:value-of select="LIC_PROV_PEDIDOMINIMO"/>';
		Proveedor['PlazoPago']	= '<xsl:value-of select="PLAZOPAGO"/>';
		Proveedor['FormaPago']	= '<xsl:value-of select="FORMAPAGO"/>';
		Proveedor['PlazoEntrega']	= '<xsl:value-of select="LIC_PROV_PLAZOENTREGA"/>';
		Proveedor['Frete']	= '<xsl:value-of select="LIC_PROV_FRETE"/>';

		Proveedor['Productos']	= new Array();
		<xsl:for-each select="OFERTA">
			var producto		= [];
			producto['Nombre']		= '<xsl:value-of select="LIC_PROD_NOMBRE_JS"/>';						//9mar22 Version JS, evitar problemas con comilla simple
			producto['IDProducto']	= '<xsl:value-of select="LIC_PROD_ID"/>';
			producto['IDProdEstandar']	= '<xsl:value-of select="LIC_PROD_IDPRODESTANDAR"/>';
			producto['Referencia']	= '<xsl:value-of select="PRO_REFERENCIA"/>';
			producto['Refestandar']	= '<xsl:value-of select="LIC_PROD_REFESTANDAR"/>';
			producto['RefCliente']	= '<xsl:value-of select="LIC_PROD_REFCLIENTE"/>';
			producto['RefCentro']	= '<xsl:value-of select="REFCENTRO"/>';
			producto['UdsXLote']	= '<xsl:value-of select="LIC_OFE_UNIDADESPORLOTE"/>';
			producto['UdBasica']	= '<xsl:value-of select="LIC_PROD_UNIDADBASICA"/>';
			producto['Marca']	= '<xsl:value-of select="LIC_OFE_MARCA"/>';
			producto['PrecioRef']	= '<xsl:value-of select="LIC_PROD_PRECIOREFERENCIA"/>';
			producto['MarcasAceptables']	= "<xsl:value-of select="LIC_PROD_MARCASACEPTABLES"/>";			//18jul23 cambiamos a " por que la marca puede contener '
			producto['PrincActivo']	= '<xsl:value-of select="LIC_PROD_PRINCIPIOACTIVO"/>';					//23nov21
			
			producto['IDCentroProv']= '<xsl:value-of select="IDCENTROPROVEEDOR"/>';
			producto['CentroProv']	= '<xsl:value-of select="CENTROPROVEEDOR"/>';

			producto['Cantidad']	= '<xsl:value-of select="CANTIDAD"/>';
			producto['Tarifa']		= '<xsl:value-of select="LIC_OFE_PRECIO"/>';
			producto['TotalLinea']	= '<xsl:value-of select="CONSUMO"/>';
			producto['Ahorro']	= '<xsl:value-of select="LIC_OFE_AHORRO"/>';
			
			producto['ErrorUnidades']	= '<xsl:choose><xsl:when test="NO_CUADRAN_UNIDADES">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		
		Proveedor['Productos'].push(producto);
		</xsl:for-each>
		arrProveedores.push(Proveedor);
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
	
	var chkTotal='<xsl:value-of select="/OfertasSeleccionadas/LICITACION/TOTAL_ALAVISTA"/>';
	
	var strTotalALaVista='<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_alavista']/node()"/>';
	var TotalALaVista='<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/TOTAL_ALAVISTA"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>';
	
	var strTotalAplazado='<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_aplazado']/node()"/>';
	var TotalAplazado='<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/TOTAL_APLAZADO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>';

	var chkTotalPedidos='<xsl:value-of select="/OfertasSeleccionadas/LICITACION/TOTAL_PEDIDOS"/>';

	var strTotalPedidos='<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_pedidos']/node()"/>';
	var TotalPedidos='<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/TOTAL_PEDIDOS"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>';
	
	var strTotalAdjudicado='<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_adjudicado']/node()"/>';
	var TotalAdjudicado='<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_CONSUMOADJUDICADO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>';
	
	var strProductos='<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>';
	var Productos='<xsl:value-of select="/OfertasSeleccionadas/LICITACION/PRODUCTOSADJUDICADOS"/>/<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_NUMEROLINEAS"/>';

	var strProveedores='<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>';
	var Proveedores='<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_PROVEEDORESADJUDICADOS"/>/<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_NUMEROPROVEEDORES"/>';
	
	var strAhorroPorc='<xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro']/node()"/> (%)';
	var AhorroPorc='<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_AHORROADJUDICADO"/>%';
	
	var strAhorro='<xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro']/node()"/>';
	var Ahorro='<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_AHORROADJUDICADO_TOT"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>';

	var strProveedor='<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>';
	var strCabeceraExcel='<xsl:value-of select="document($doc)/translation/texts/item[@name='Cabecera_CSV_vencedores']/node()"/>';


	var strPedidoMinimo='<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/>';
	var strPlazoPago='<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_pago']/node()"/>';
	var strFormaPago='<xsl:value-of select="document($doc)/translation/texts/item[@name='forma_pago']/node()"/>';
	var strPlazoEntrega='<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/>';
	var strFrete='<xsl:value-of select="document($doc)/translation/texts/item[@name='frete']/node()"/>';
	
	var strCentro='<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>';
	</script>
</head>
<!--<body class="gris" >-->
<body onload="javascript:onLoad();">
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
	<br/>
	<div class="informacao_geral_cotacao">
		<div class="informacao_geral_cotacao_1">
			<div class="informacao_geral_cotacao_1_titulo">
				<div class="informacao_geral_cotacao_empresa">
					<p class="informacao_geral_cotacao_empresa">
						<a id="botonLicitacion" href="javascript:chLicV2({/OfertasSeleccionadas/LICITACION/LIC_ID});"><xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_CODIGO"/>:&nbsp;<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_TITULO"/></a>
					</p>
					<p><span>
						<xsl:attribute name="class">
							<xsl:choose>
								<xsl:when test="/OfertasSeleccionadas/LICITACION/LIC_AGREGADA='S'">CompletarTitulo1200 marginRight50</xsl:when>
								<xsl:otherwise>CompletarTitulo800 marginRight50</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
						<!--10ene23 Ponemos el filtro junto al titulo-->
						<xsl:if test="/OfertasSeleccionadas/LICITACION/LIC_AGREGADA='S'">
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="/OfertasSeleccionadas/LICITACION/CENTROSCOMPRAS/field"/>
							<xsl:with-param name="onChange">javascript:document.forms[0].submit();</xsl:with-param>
							<xsl:with-param name="claSel">w300px</xsl:with-param>
						</xsl:call-template>
						<br/><br/><br/>
						</xsl:if>
						<!-- Boton para la descarga de vencedores	-->
						<xsl:if test="/OfertasSeleccionadas/LICITACION/DESCARGA_VENCEDORES">
							<a class="btnDestacado" id="btnAjustarCantidad" href="javascript:AjustarCantidades();">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='boton_ajustarCantidades']/node()"/>
                   			</a>&nbsp;
							<a class="btnNormal" href="javascript:DescargarVencedores();">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='boton_descargarVencedores']/node()"/>
                   			</a>&nbsp;
						</xsl:if>
						<a class="btnNormal" id="btnPorProducto" href="javascript:chLicV2({/OfertasSeleccionadas/LICITACION/LIC_ID});">
							<!--27abr23 Desde MVMB piden ver Productos, no Itens<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>-->
							<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_no_itens']/node()"/>
                		</a>&nbsp;
						<!--3ene23 boton para SOLICITAR FIRMAS-->
						<xsl:if test="((/OfertasSeleccionadas/LICITACION/LIC_MESESDURACION>0) or (/OfertasSeleccionadas/LICITACION/LIC_PEDIDOSPENDIENTES>0)) and (/OfertasSeleccionadas/LICITACION/LIC_REQUIEREFIRMAS='S' and /OfertasSeleccionadas/LICITACION/LIC_IDESTADO!='FIRM' and not(/OfertasSeleccionadas/LICITACION/LICITACION_FIRMADA))">
							<a class="btnDestacado"  id="botonSolicitarFirmas" href="javascript:SolicitarFirmas();"><xsl:value-of select="document($doc)/translation/texts/item[@name='Sol_firmas']/node()"/></a>&nbsp;
						</xsl:if>
						<!--3ene23 boton para FIRMAR-->
						<xsl:if test="/OfertasSeleccionadas/LICITACION/LIC_IDESTADO='FIRM' and /OfertasSeleccionadas/LICITACION/BOTON_FIRMA">
							<a class="btnDestacado"  id="botonFirmar" href="javascript:FirmaORechazo('FIRMA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='firma']/node()"/></a>&nbsp;
							<a class="btnDestacado"  id="botonRechazar" href="javascript:PrepararRechazo();"><xsl:value-of select="document($doc)/translation/texts/item[@name='rechazar']/node()"/></a>&nbsp;
							<span  id="txtMotivoRechazo" style="display:none"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='motivo']/node()"/>:&nbsp;</label></span>
							<input type="text" class="campopesquisa w300px" id="motivoRechazo" style="display:none"/>&nbsp;
							<a class="btnDestacado"  id="botonEnviarRechazo" href="javascript:FirmaORechazo('RECHAZO');" style="display:none"><xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/></a>&nbsp;
						</xsl:if>
						<xsl:if test="/OfertasSeleccionadas/LICITACION/AUTOR and /OfertasSeleccionadas/LICITACION/LIC_PORPRODUCTO = 'S' and (/OfertasSeleccionadas/LICITACION/LIC_IDESTADO = 'INF' or /OfertasSeleccionadas/LICITACION/LIC_IDESTADO = 'CURS')"><!-- and not BLOQUEARADJUDICACION-->
							<xsl:choose>
							<xsl:when test="/OfertasSeleccionadas/LICITACION/LIC_MULTIOPCION='S'">
								<a class="btnDestacado" id="botonAdjudicarSelec" href="javascript:AdjudicarOfertasMultiples();">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicar']/node()"/>
								</a>
								<span id="idAvanceAdjudicar" style="display:none;" class="clear"><!--<img src="http://www.newco.dev.br/images/loading.gif"/>-->0/0</span>
							</xsl:when>
							<xsl:otherwise>
								<!--m:<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_MESESDURACION"/> p:<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_PEDIDOSPENDIENTES"/> f:<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_REQUIEREFIRMAS"/>&nbsp;-->
								<xsl:choose>
								<xsl:when test="/OfertasSeleccionadas/LICITACION/PRODUCTOSLICITACION/PRODUCTOS_OLVIDADOS and LIC_REQUIEREFIRMAS='N'">
									<a class="btnDeshabilitado" id="botonAdjudicarSelec" href="javascript:AdjudicarOfertas();">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicar']/node()"/></a>
								</xsl:when>
								<!--10ene23 Solicitan presentar el boton de "Aprovar" en este estado. Traido desde LICITACION.INICIO- ->
								<xsl:when test="/Mantenimiento/LICITACION/LIC_MESESDURACION=0 and /Mantenimiento/LICITACION/LIC_PEDIDOSPENDIENTES>0">
									<a class="btnDestacado" id="botonAdjudicarSelec" style="position:relative;top:7px;" href="javascript:AdjudicarOfertas();"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicar']/node()"/></a>
									<span id="waitBotonAdjudicar" style="display:none;position:relative;top:7px;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></span>
									<span id="txtPrepPedido">&nbsp;</span>
								</xsl:when>
								<!- -10ene23 Solicitan presentar el boton de "Aprovar" en este estado. Traido desde LICITACION.FIN-->
								<xsl:when test="/OfertasSeleccionadas/LICITACION/LIC_MESESDURACION>0 and /OfertasSeleccionadas/LICITACION/LIC_REQUIEREFIRMAS='N'">
									<a class="btnDestacado" id="botonAdjudicarSelec" href="javascript:AdjudicarOfertas();"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicar']/node()"/></a>
									<span id="waitBotonAdjudicar" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></span>
									<span id="txtPrepPedido">&nbsp;</span>
								</xsl:when>
								<xsl:when test="/OfertasSeleccionadas/LICITACION/LIC_PEDIDOSPENDIENTES>0 and /OfertasSeleccionadas/LICITACION/LIC_REQUIEREFIRMAS='N'">
									<a class="btnDestacado" id="botonAdjudicarSelec" href="javascript:PreparaLanzarTodosPedidos();"><xsl:value-of select="document($doc)/translation/texts/item[@name='boton_generar_pedido']/node()"/></a>
									<span id="waitBotonAdjudicar" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></span>
									<span id="txtPrepPedido">&nbsp;</span>
								</xsl:when>
								<xsl:otherwise>
									<!--14feb20 NO mostramos el botón de adjudicar si es licitacion SPOT y no hay pedidos pendientes-->
								</xsl:otherwise>
								</xsl:choose>								
								<span id="waitBotonAdjudicar" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></span>
							</xsl:otherwise>
							</xsl:choose>								
							<!--	11mar20	Botón contrato	-->
							<xsl:if test="/OfertasSeleccionadas/LICITACION/BOTON_CONTRATO">
								<a class="btnDestacado" id="botonEstContrato" href="javascript:PasarAEstadoContrato();">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar_lic']/node()"/>
								</a>
								&nbsp;
							</xsl:if>
						</xsl:if>
						<a class="btnNormal" href="javascript:DescargarExcel();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/>
						</a>
						&nbsp;
						<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/licOfertasSeleccionadasImpr.xsql?US_ID={/OfertasSeleccionadas/US_ID}&amp;LIC_ID={/OfertasSeleccionadas/LIC_ID}&amp;IDCENTROCOMPRAS={/OfertasSeleccionadas/IDCENTROCOMPRAS}"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
						&nbsp;
						<xsl:choose>
						<xsl:when test="/OfertasSeleccionadas/LIC_PROD_ID != ''">
							<a class="btnNormal" href="javascript:history.go(-1)"><xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/></a>
							&nbsp;
						</xsl:when>
						<xsl:otherwise>
							<!--<a class="btnNormal" style="text-decoration:none;"  href="javascript:window.close()"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>
							&nbsp;-->
						</xsl:otherwise>
						</xsl:choose>
						&nbsp;&nbsp;
					</span></p>
				</div>
			</div>
			<div class="div_coluna_1_vencedores_detalhes">
				<div class="historico_cotacao_detalhes">
					<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_informe']/node()"/>:&nbsp;</label><strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/FECHAACTUAL"/></strong></p> 
					<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/>:&nbsp;</label><strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_FECHADECISIONPREVISTA"/></strong></p> 
					<xsl:if test="/OfertasSeleccionadas/LICITACION/TOTAL_PEDIDOS">
						<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='Total_pedidos']/node()"/>:&nbsp;</label><strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/TOTAL_PEDIDOS"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/></strong></p> 
					</xsl:if>
					<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='Total_adjudicado']/node()"/>:&nbsp;</label><strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_CONSUMOADJUDICADO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/></strong></p> 			
					<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>:&nbsp;</label><strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/PRODUCTOSADJUDICADOS"/>/<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_NUMEROLINEAS"/></strong></p> 
					<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>:&nbsp;</label><strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_PROVEEDORESADJUDICADOS"/>/<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_NUMEROPROVEEDORES"/></strong></p> 
				</div>
				<div class="historico_cotacao_detalhes">
					<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro']/node()"/>(%):&nbsp;</label><strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_AHORROADJUDICADO"/></strong></p> 
					<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro']/node()"/>:&nbsp;</label><strong> <xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_AHORROADJUDICADO_TOT"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
					<xsl:if test="/OfertasSeleccionadas/LICITACION/LIC_CONSUMOHISTADJUDICADO">
						&nbsp;(<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_CONSUMOHISTADJUDICADO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>)
					</xsl:if>
					</strong></p> 
					<xsl:if test="/OfertasSeleccionadas/LICITACION/LIC_MESESDURACION>0 or /OfertasSeleccionadas/LICITACION/TOTAL_ALAVISTA">
						<xsl:if test="/OfertasSeleccionadas/LICITACION/LIC_MESESDURACION>0">
							<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='meses_duracion']/node()"/>:&nbsp;</label><strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_MESESDURACION"/></strong></p> 
						</xsl:if>
						<xsl:if test="/OfertasSeleccionadas/LICITACION/TOTAL_ALAVISTA">
							<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='Total_alavista']/node()"/>:&nbsp;</label><strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/TOTAL_ALAVISTA"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/></strong></p> 
							<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='Total_aplazado']/node()"/>:&nbsp;</label><strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/TOTAL_APLAZADO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/></strong></p> 
						</xsl:if>
					</xsl:if>
				</div>
				<div class="historico_cotacao_detalhes">
					<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:&nbsp;</label><strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_DESCRIPCION"/></strong></p> 
				</div>
				<xsl:if test="/OfertasSeleccionadas/LICITACION/LIC_CONDICIONESENTREGA!='' or /OfertasSeleccionadas/LICITACION/LIC_CONDICIONESPAGO!=''">
					<div class="historico_cotacao_detalhes">
						<xsl:if test="/OfertasSeleccionadas/LICITACION/LIC_CONDICIONESENTREGA!=''">
							<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_entrega']/node()"/>:&nbsp;</label><strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_CONDICIONESENTREGA"/></strong></p> 
						</xsl:if>
						<xsl:if test="/OfertasSeleccionadas/LICITACION/LIC_CONDICIONESPAGO!=''">
							<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_pago']/node()"/>:&nbsp;</label><strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_CONDICIONESPAGO"/></strong></p> 
						</xsl:if>
					</div>
				</xsl:if>
				<xsl:if test="/OfertasSeleccionadas/LICITACION/LIC_OTRASCONDICIONES!=''">
					<div class="historico_cotacao_detalhes">
						<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_otras']/node()"/>:&nbsp;</label><strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_OTRASCONDICIONES"/></strong></p> 
					</div>
				</xsl:if>
			</div>
		</div>
	</div>
</div>

<div class="divLeft">
	<form id="Proveedores" name="Proveedores" action="http://www.newco.dev.br/Gestion/Comercial/licOfertasSeleccionadas2022.xsql" method="POST">
	<input type="hidden" name="IDLicitacion" value="{/OfertasSeleccionadas/LICITACION/LIC_ID}"/>		<!--	para el JS	-->
	<input type="hidden" name="LIC_ID" value="{/OfertasSeleccionadas/LICITACION/LIC_ID}"/>				<!--	se utiliza en el XSQL		-->
	<input type="hidden" name="IDCentro" value="{/OfertasSeleccionadas/LICITACION/IDCENTRO}"/>
	<input type="hidden" name="ACCION" value=""/>
	<input type="hidden" name="PARAMETROS" value=""/>
	<input type="hidden" name="CODPEDIDO" value=""/>
	<input type="hidden" name="IDCENTROPEDIDO" value=""/>
	<xsl:for-each select="/OfertasSeleccionadas/LICITACION/PROVEEDORES/PROVEEDOR">
	
		<div class="divLeft">
			<div class="div_coluna_tabela_cotacao">
				<div class="div_coluna_1_vencedores">
					<div class="div_coluna_1_cotacao_titulo">
						<div class="qtd_produto_cotacao">
							<p><!-- class="quantidade_cotacao">-->
								<xsl:attribute name="class">
								<xsl:choose>
									<xsl:when test="NO_CUMPLE_PEDIDO_MINIMO">quantidade_cotacao fondoRojo</xsl:when>
									<xsl:otherwise>quantidade_cotacao</xsl:otherwise>
								</xsl:choose>
								</xsl:attribute>	
								<xsl:if test="/OfertasSeleccionadas/LICITACION/LIC_AGREGADA='S' and /OfertasSeleccionadas/LICITACION/IDCENTROACTUAL=''">
									&nbsp;<xsl:value-of select="CENTRO"/>:&nbsp;
								</xsl:if>
								<xsl:if test="DATOSPRIVADOS/COP_CODIGO  != '' ">
									&nbsp;(<xsl:value-of select="DATOSPRIVADOS/COP_CODIGO"/>)&nbsp;
								</xsl:if>
								<a href="javascript:FichaEmpresa('{IDPROVEEDOR}&amp;ESTADO=CABECERA'">
									<xsl:value-of select="EMP_NIF"/>&nbsp;
									<xsl:value-of select="NOMBRECORTO"/>
								</a>
								&nbsp;
								<xsl:if test="/OfertasSeleccionadas/LICITACION/AUTOR">
								<a href="javascript:conversacionProveedor({IDPROVEEDOR});" style="text-decoration:none;"><img>
									<xsl:attribute name="src">
									<xsl:choose>
									<xsl:when test="EXISTE_CONVERSACION">http://www.newco.dev.br/images/bocadillo.gif</xsl:when>
									<xsl:otherwise>http://www.newco.dev.br/images/bocadilloPlus.gif</xsl:otherwise>
									</xsl:choose>
									</xsl:attribute>
								</img>
								</a>
								</xsl:if>
							</p>
							<!--<p><a class="btnNormal" href="javascript:OfertaProveedorLicitacion({/OfertasSeleccionadas/LICITACION/LIC_ID},{IDPROVEEDOR_LIC});"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_ofertas']/node()"/></a></p> -->
							<xsl:choose>
								<xsl:when test="PEDIDOS/TOTAL>0">
									<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>:</label>
									<xsl:for-each select="PEDIDOS/PEDIDO">
										&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame2022.xsql?MO_ID={MO_ID}','Multioferta',100,80,0,0)"><xsl:value-of select="MO_NUMEROCLINICA"/>&nbsp;(<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="MO_IMPORTETOTAL"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>)</a>
									</xsl:for-each></p> 
								</xsl:when>
								<xsl:when test="PEDIDOS/TOTAL=0 and PEDIDOS/BOTON_PEDIDO and /OfertasSeleccionadas/LICITACION/LIC_REQUIEREFIRMAS='N' and ( not(/OfertasSeleccionadas/LICITACION/IDCENTRO) or (/OfertasSeleccionadas/LICITACION/IDCENTRO != '-1'))">
									<span class="floatRight">
										<xsl:if test="/OfertasSeleccionadas/LICITACION/INCLUIRCODIGOPEDIDO='S'">&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>:&nbsp;<input type="text" class="campopesquisa w100px" id="CODPEDIDO_{IDPROVEEDOR_LIC}_{IDCENTRO}"/></xsl:if>
										&nbsp;&nbsp;&nbsp;<a class="btnDestacado" id="btnCrearPedido_{IDPROVEEDOR_LIC}" href="javascript:crearPedido({IDPROVEEDOR_LIC},'{IDCENTRO}');"><xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_pedido']/node()"/></a>&nbsp;&nbsp;&nbsp;
									</span>
								</xsl:when>
							</xsl:choose>
						</div>
					</div>
					<div class="div_coluna_1_vencedores_detalhes">
						<div class="historico_cotacao_detalhes">
							<br/>
							<xsl:if test="DATOSPRIVADOS/COP_NOMBREBANCO  != '' ">
								<p>(<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Cuenta_bancaria']/node()"/>:</label>&nbsp;
									<xsl:value-of select="DATOSPRIVADOS/COP_NOMBREBANCO"/>&nbsp;<xsl:value-of select="DATOSPRIVADOS/COP_CODBANCO"/>
									&nbsp;<xsl:value-of select="DATOSPRIVADOS/COP_CODOFICINA"/>
									&nbsp;<xsl:value-of select="DATOSPRIVADOS/COP_CODCUENTA"/>)
								</p> 
								<br/>
							</xsl:if>
							<p>
								<label><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/>:</label>&nbsp;<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="LIC_PROV_PEDIDOMINIMO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
							</p> 
							<p>
								<xsl:attribute name="class">
								<xsl:choose>
									<xsl:when test="NO_CUMPLE_PEDIDO_MINIMO">rojo</xsl:when>
									<xsl:otherwise>rojo</xsl:otherwise>
								</xsl:choose>
								</xsl:attribute>	
								<label><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:</label>&nbsp;<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="LIC_PROV_CONSUMOADJUDICADO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
							</p> 
							<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>:</label>&nbsp;<xsl:value-of select="NUMERO_PRODUCTOS"/></p> 
							<xsl:if test="LIC_PROV_FRETE  != '' ">			
								<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='frete']/node()"/>:</label>&nbsp;<xsl:value-of select="LIC_PROV_FRETE"/></p> 
							</xsl:if>
							<!--21oct22 incluir plazo de entrega	-->
							<xsl:if test="LIC_PROV_PLAZOENTREGA  != '' ">  
								<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/>:</label>&nbsp;<strong><xsl:value-of select="LIC_PROV_PLAZOENTREGA"/></strong>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='dias']/node()"/></p>
							</xsl:if>
							<xsl:if test="LIC_PROV_COMENTARIOSPROV!=''">
								<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones']/node()"/>:&nbsp;</label>
								<xsl:choose>
									<xsl:when test="string-length(LIC_PROV_COMENTARIOSPROV)&lt;31"><xsl:value-of select="LIC_PROV_COMENTARIOSPROV"/></xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="substring (LIC_PROV_COMENTARIOSPROV,0,30)"/>
										<img src="http://www.newco.dev.br/images/2017/info.png" class="static">
										<xsl:attribute name="title"><xsl:value-of select="LIC_PROV_COMENTARIOSPROV"/></xsl:attribute>
										</img>
									</xsl:otherwise>
								</xsl:choose>
								</p> 
							</xsl:if>
							<p class="marginLeft100"><a class="btnNormal" href="javascript:OfertaProveedorLicitacion({/OfertasSeleccionadas/LICITACION/LIC_ID},{IDPROVEEDOR_LIC});"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_ofertas']/node()"/></a></p> 
							<!--
							<xsl:choose>
								<xsl:when test="PEDIDOS/TOTAL>0">
									<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>:</label>
									<xsl:for-each select="PEDIDOS/PEDIDO">
										&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID={MO_ID}','Multioferta',100,80,0,0)"><xsl:value-of select="MO_NUMEROCLINICA"/>&nbsp;(<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="MO_IMPORTETOTAL"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>)</a>
									</xsl:for-each></p> 
								</xsl:when>
								<xsl:when test="PEDIDOS/TOTAL=0 and PEDIDOS/BOTON_PEDIDO and ( not(/OfertasSeleccionadas/LICITACION/IDCENTRO) or (/OfertasSeleccionadas/LICITACION/IDCENTRO != '-1'))">
									<span class="floatRight">
										<xsl:if test="/OfertasSeleccionadas/LICITACION/INCLUIRCODIGOPEDIDO='S'">&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>:&nbsp;<input type="text" class="campopesquisa w100px" id="CODPEDIDO_{IDPROVEEDOR_LIC}_{IDCENTRO}"/></xsl:if>
										&nbsp;&nbsp;&nbsp;<a class="btnDestacado" id="btnCrearPedido_{IDPROVEEDOR_LIC}" href="javascript:crearPedido({IDPROVEEDOR_LIC},'{IDCENTRO}');"><xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_pedido']/node()"/></a>&nbsp;&nbsp;&nbsp;
									</span>
								</xsl:when>
							</xsl:choose>-->
							<br/>
							<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='forma_pago']/node()"/>:</label>&nbsp;
							<xsl:choose>
							<xsl:when test="/OfertasSeleccionadas/LICITACION/LIC_AGREGADA='S' and /OfertasSeleccionadas/LICITACION/IDCENTROACTUAL='-1'">
								<xsl:value-of select="FORMAPAGO"/>.&nbsp;<xsl:value-of select="PLAZOPAGO"/>.
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="desplegable">
									<xsl:with-param name="path" select="FORMASPAGO/field"/>
									<xsl:with-param name="id">FORMASPAGO_<xsl:value-of select="IDPROVEEDOR_LIC"/><xsl:value-of select="IDCENTRO"/></xsl:with-param>
									<xsl:with-param name="onChange">javascript:ActivarCambio(<xsl:value-of select="IDPROVEEDOR_LIC"/>,'<xsl:value-of select="IDCENTRO"/>')</xsl:with-param>
									<xsl:with-param name="claSel">w200px</xsl:with-param>
								</xsl:call-template>&nbsp;
								<xsl:call-template name="desplegable">
									<xsl:with-param name="path" select="PLAZOSPAGO/field"/>
									<xsl:with-param name="id">PLAZOSPAGO_<xsl:value-of select="IDPROVEEDOR_LIC"/><xsl:value-of select="IDCENTRO"/></xsl:with-param>
									<xsl:with-param name="onChange">javascript:ActivarCambio(<xsl:value-of select="IDPROVEEDOR_LIC"/>,'<xsl:value-of select="IDCENTRO"/>')</xsl:with-param>
									<xsl:with-param name="claSel">w300px</xsl:with-param>
								</xsl:call-template>
								&nbsp;
								<a class="guardarOferta btnDestacado" style="display:none;" id="BOTONGUARDAR_{IDPROVEEDOR_LIC}{IDCENTRO}">
								<xsl:attribute name="href">
									<xsl:choose>
									<!-- para liciatciones no agregadas o si no está seleccionado un centro	-->
									<xsl:when test="/OfertasSeleccionadas/LICITACION/LIC_AGREGADA = 'N' or (/OfertasSeleccionadas/LICITACION/IDCENTRO = '-1')">javascript:GuardarFormaYPlazoPago(<xsl:value-of select="IDPROVEEDOR_LIC"/>);</xsl:when>
									<xsl:otherwise>javascript:GuardarFormaYPlazoPagoCentro(<xsl:value-of select="IDPROVEEDOR_LIC"/>,'<xsl:value-of select="IDCENTRO"/>');</xsl:otherwise>
									</xsl:choose>
									</xsl:attribute>
									<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
								</a>
								<span id="AVISOACCION_{IDPROVEEDOR_LIC}{IDCENTRO}"/>
							</xsl:otherwise>
							</xsl:choose>
							</p> 
						</div>
					</div>
				</div>
				<div class="tabela tabela_cotacao">
					<table cellspacing="10px" cellpadding="10px">
						<thead class="cabecalho_tabela">
							<tr>
								<th class="w1px">&nbsp;</th>
								<th class="w50px"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></strong></th>
								<xsl:if test="/OfertasSeleccionadas/LICITACION/INCLUIRREFCENTRO">
									<th class="w50px"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_centro']/node()"/></strong></th>
								</xsl:if>
								<th class="trenta" style="text-align:left;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></strong></th>
								<th class="w50px"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></strong></th>
								<th class="quince"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></strong></th>
								<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS != 55">
									<th class="siete"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/></strong></th>
								</xsl:if>
								<th class="diez"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/></strong></th>
								<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34">
									<th class="cinco"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></strong></th>
								</xsl:if>
								<th class="w50px"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='embalaje']/node()"/></strong></th>
								<th class="w50px"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></strong></th>
								<th class="w50px"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></strong></th>
								<th class="w70px fondoGris"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ref']/node()"/></strong></th>
								<th class="w50px fondoGris"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/></strong></th>
							</tr>
						</thead>
						<tbody class="corpo_tabela">
							<xsl:choose>
							<!-- para licitaciones multipedido	-->
							<xsl:when test="/OfertasSeleccionadas/LICITACION/LIC_MULTIPEDIDO = 'S'">
								<xsl:for-each select="PEDIDO">
									<xsl:for-each select="OFERTA">
										<tr class="conhover">
											<xsl:attribute name="class">
											<xsl:choose>
											<xsl:when test="NO_CUADRAN_UNIDADES">
												fondoRojo
											</xsl:when>
											<xsl:otherwise>
											<!--	gris-->
											</xsl:otherwise>
											</xsl:choose>
											</xsl:attribute>
											<td id="IDPRODLIC_{LIC_PROD_ID}" class="color_status"><xsl:value-of select="LINEA"/></td>
											<td>
												<xsl:choose>
												<xsl:when test="LIC_PROD_REFCLIENTE!=''">
													<xsl:value-of select="LIC_PROD_REFCLIENTE"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="LIC_PROD_REFESTANDAR"/>
												</xsl:otherwise>
												</xsl:choose>
											</td>
											<xsl:if test="/OfertasSeleccionadas/LICITACION/INCLUIRREFCENTRO">
												<td><xsl:value-of select="REFCENTRO"/></td>
											</xsl:if>
											<td class="textLeft">
												<a href="javascript:chFichaProductoLicitacion({/OfertasSeleccionadas/LICITACION/LIC_ID},{LIC_PROD_ID},'VENCEDORES');">
													<xsl:value-of select="LIC_PROD_NOMBRE"/><xsl:if test="LIC_PROD_MARCASACEPTABLES != ''">&nbsp;[<xsl:value-of select="LIC_PROD_MARCASACEPTABLES"/>]</xsl:if>
												</a>
												<xsl:if test="LIC_PROD_PRINCIPIOACTIVO != ''">
													<img src="http://www.newco.dev.br/images/2017/info.png" class="static">
													<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='Princ_activo']/node()"/>: <xsl:value-of select="LIC_PROD_PRINCIPIOACTIVO"/></xsl:attribute>
													</img>
												</xsl:if>
											</td>
											<td><xsl:value-of select="LIC_OFE_MARCA"/></td>
											<td><xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>
											<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS != 55">
												<td><xsl:value-of select="LIC_OFE_REFERENCIA"/></td>
											</xsl:if>
											<td class="textRight">
												<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="LIC_OFE_PRECIO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
											</td>
											<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS != 55">
												<td><xsl:value-of select="LIC_OFE_TIPOIVA"/>%</td>
											</xsl:if>
											<td><xsl:value-of select="LIC_OFE_UNIDADESPORLOTE"/></td>
											<td class="textRight">
												<xsl:if test="CAMBIO_CANTIDAD">
													(<xsl:value-of select="CANTIDADORIGINAL"/>-><xsl:value-of select="CANTIDAD"/>)&nbsp;
												</xsl:if>
												<strong><xsl:value-of select="CANTIDAD"/></strong>&nbsp;
											</td>
											<td class="textRight">
												<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="CONSUMO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
											</td>
											<td class="textRight fondogris">
												<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="LIC_PROD_PRECIOREFERENCIA"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
											</td>
											<td class="textRight fondogris">
												<xsl:value-of select="LIC_OFE_AHORRO"/>%
											</td>
										</tr>
									</xsl:for-each>
								</xsl:for-each>
							</xsl:when>
							<xsl:otherwise>
								<xsl:for-each select="OFERTA">
									<tr class="conhover">
										<xsl:attribute name="class">
										<xsl:choose>
										<xsl:when test="NO_CUADRAN_UNIDADES">
											fondoRojo
										</xsl:when>
										<xsl:otherwise>
										<!--	gris-->
										</xsl:otherwise>
										</xsl:choose>
										</xsl:attribute>
										<td id="IDPRODLIC_{LIC_PROD_ID}" class="color_status"><xsl:value-of select="CONTADOR"/></td>
										<td>
											<xsl:choose>
											<xsl:when test="LIC_PROD_REFCLIENTE!=''">
												<xsl:value-of select="LIC_PROD_REFCLIENTE"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="LIC_PROD_REFESTANDAR"/>
											</xsl:otherwise>
											</xsl:choose>
										</td>
										<xsl:if test="/OfertasSeleccionadas/LICITACION/INCLUIRREFCENTRO">
											<td><xsl:value-of select="REFCENTRO"/></td>
										</xsl:if>
										<td class="textLeft">
											<a href="javascript:chFichaProductoLicitacion({/OfertasSeleccionadas/LICITACION/LIC_ID},{LIC_PROD_ID},'VENCEDORES');">
												<xsl:value-of select="LIC_PROD_NOMBRE"/><xsl:if test="LIC_PROD_MARCASACEPTABLES != ''">&nbsp;[<xsl:value-of select="LIC_PROD_MARCASACEPTABLES"/>]</xsl:if>
											</a>
											<xsl:if test="LIC_PROD_PRINCIPIOACTIVO != ''">
												<img src="http://www.newco.dev.br/images/2017/info.png" class="static">
												<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='Princ_activo']/node()"/>: <xsl:value-of select="LIC_PROD_PRINCIPIOACTIVO"/></xsl:attribute>
												</img>
											</xsl:if>
										</td>
										<td><xsl:value-of select="LIC_OFE_MARCA"/></td>
										<td><xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>
										<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS != 55">
											<td><xsl:value-of select="LIC_OFE_REFERENCIA"/></td>
										</xsl:if>
										<td class="textRight">
											<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="LIC_OFE_PRECIO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
										</td>
										<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS != 55">
											<td><xsl:value-of select="LIC_OFE_TIPOIVA"/>%</td>
										</xsl:if>
										<td><xsl:value-of select="LIC_OFE_UNIDADESPORLOTE"/></td>
										<td>
											<xsl:if test="CAMBIO_CANTIDAD">
												(<xsl:value-of select="CAMBIO_CANTIDAD/CANTIDADORIGINAL"/>-><xsl:value-of select="CAMBIO_CANTIDAD/CANTIDAD"/>)&nbsp;
											</xsl:if>
											<strong><xsl:value-of select="CANTIDAD"/></strong>&nbsp;
										</td>
										<td class="textRight">
											<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="CONSUMO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
										</td>
										<td class="textRight fondogris">
											<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="LIC_PROD_PRECIOREFERENCIA"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
										</td>
										<td class="textRight fondogris">
											<xsl:value-of select="LIC_OFE_AHORRO"/>%
										</td>
									</tr>
								</xsl:for-each>
							</xsl:otherwise>
							</xsl:choose>
						</tbody>
						<tfoot class="rodape_cotacao">
							<tr><td colspan="12">&nbsp;</td></tr>
						</tfoot>
					</table>
				</div>
			</div>
		<br/>
		<br/>
		<br/>
		<br/>
		</div>
	</xsl:for-each>
	<xsl:if test="/OfertasSeleccionadas/LICITACION/PRODUCTOS_SIN_OFERTA/PRODUCTO">
    <div class="divLeft textCenter marginTop50">
		<span class="tituloTabla"><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_no_seleccionados']/node()"/></span>
	</div>
	<div class="tabela tabela_redonda marginTop50">
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
			<td class="color_status" id="IDPRODLIC_{LIC_PROD_ID}"><xsl:value-of select="CONTADOR"/></td>
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
	<br/>
	<br/>
	<br/>
	<br/>
	</div>
	</xsl:if>
	<xsl:if test="/OfertasSeleccionadas/LICITACION/PRODUCTOS_JUSTIFICADOS/PRODUCTO">
    	<div class="divLeft textCenter">
			<span class="tituloTabla"><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_con_justificacion']/node()"/></span>
			<br/>
			<br/>
		</div>
		<div class="tabela tabela_redonda">
		<table cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
			<tr>
				<th class="w1px">&nbsp;</th>
				<th class="w80px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='justificacion']/node()"/></th>
				<th>&nbsp;</th>
			</tr>
		</thead>
		<tbody class="corpo_tabela">
		<xsl:for-each select="/OfertasSeleccionadas/LICITACION/PRODUCTOS_JUSTIFICADOS/PRODUCTO">
			<tr class="conhover">
				<td class="color_status" id="IDPRODLIC_{LIC_PROD_ID}"><xsl:value-of select="CONTADOR"/></td>
				<td><xsl:value-of select="REFERENCIA"/></td>
				<td class="textLeft">
					<a href="javascript:chFichaProductoLicitacion({/OfertasSeleccionadas/LICITACION/LIC_ID},{LIC_PROD_ID},'VENCEDORES');"><xsl:value-of select="LIC_PROD_NOMBRE"/></a>
				</td>
				<td class="textLeft"><xsl:value-of select="JUSTIFICACION"/>.&nbsp;<xsl:value-of select="LIC_PROD_MOTIVOSELECCION"/></td>
				<td>&nbsp;</td>
			</tr>
		</xsl:for-each>
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="9">&nbsp;</td></tr>
		</tfoot>
		</table>
		<br/>
		<br/>
		<br/>
		<br/>
		</div>
	</xsl:if>
	<xsl:if test="/OfertasSeleccionadas/LICITACION/OFERTAS_DESCARTADAS/OFERTA">
    	<div class="divLeft textCenter">
			<span class="tituloTabla"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ofertas_descartadas']/node()"/></span>
			<br/>
			<br/>
		</div>
		<div class="tabela tabela_redonda">
		<table cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
			<tr>
				<th class="w1px">&nbsp;</th>
				<th class="w80px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
				<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></th>
				<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='justificacion']/node()"/></th>
				<th>&nbsp;</th>
			</tr>
		</thead>
		<tbody class="corpo_tabela">
		<xsl:for-each select="/OfertasSeleccionadas/LICITACION/OFERTAS_DESCARTADAS/OFERTA">
			<tr class="conhover">
				<td class="color_status" id="IDPRODLIC_{LIC_PROD_ID}"><xsl:value-of select="CONTADOR"/></td>
				<td><xsl:value-of select="REFERENCIA"/></td>
				<td class="textLeft"><xsl:value-of select="PROVEEDOR"/></td>
				<td class="textLeft">
					<a href="javascript:chFichaProductoLicitacion({/OfertasSeleccionadas/LICITACION/LIC_ID},{LIC_PROD_ID},'VENCEDORES');"><xsl:value-of select="LIC_PROD_NOMBRE"/></a>
				</td>
				<td><xsl:value-of select="MARCA"/></td>
				<td><xsl:value-of select="PRECIO"/></td>
				<td class="textLeft"><xsl:value-of select="JUSTIFICACION"/><xsl:value-of select="LIC_PROD_MOTIVOSELECCION"/></td>
				<td>&nbsp;</td>
			</tr>
		</xsl:for-each>
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="9">&nbsp;</td></tr>
		</tfoot>
		</table>
		<br/>
		<br/>
		<br/>
		<br/>
		</div>
	</xsl:if>
	<xsl:if test="/OfertasSeleccionadas/LICITACION/ADJUDICADOS_ELIMINADOS/OFERTA">
    	<div class="divLeft textCenter">
			<span class="tituloTabla"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ofertas_adjudicadas_eliminadas']/node()"/></span>
			<br/>
			<br/>
		</div>
		<div class="tabela tabela_redonda">
		<table cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
			<tr>
				<th class="w1px">&nbsp;</th>
				<th class="w80px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
				<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></th>
				<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></th>
				<th>&nbsp;</th>
			</tr>
		</thead>
		<tbody class="corpo_tabela">
		<xsl:for-each select="/OfertasSeleccionadas/LICITACION/ADJUDICADOS_ELIMINADOS/OFERTA">
			<tr class="conhover">
				<td id="IDPRODLIC_{LIC_PROD_ID}"><xsl:value-of select="CONTADOR"/></td>
				<td><xsl:value-of select="REFERENCIA"/></td>
				<td class="textLeft"><xsl:value-of select="PROVEEDOR"/></td>
				<td class="textLeft">
					<a href="javascript:chFichaProductoLicitacion({/OfertasSeleccionadas/LICITACION/LIC_ID},{LIC_PROD_ID},'VENCEDORES');"><xsl:value-of select="LIC_PROD_NOMBRE"/></a>
				</td>
				<td><xsl:value-of select="MARCA"/></td>
				<td><xsl:value-of select="PRECIO"/></td>
				<td>&nbsp;</td>
			</tr>
		</xsl:for-each>
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="9">&nbsp;</td></tr>
		</tfoot>
		</table>
		<br/>
		<br/>
		<br/>
		<br/>
		</div>
	</xsl:if>
   	<div class="divLeft">
	<!-- ZONA INFORMES, adaptada desde la licitacion -->
	<div class="divLeft">
    	<div class="divLeft textCenter">
			<span class="tituloTabla"><xsl:value-of select="document($doc)/translation/texts/item[@name='informes']/node()"/></span>
		</div>
		<br/>
		<br/>
		<table cellspacing="10px" cellpadding="10px">
		<tbody>
			<tr>
				<td>&nbsp;</td>
				<td class="textLeft">
					<strong><a class="btnNormal btn300px" href="javascript:Informe('licAvanceOfertas2022.xsql?','Informe Licitacion');"><xsl:value-of select="document($doc)/translation/texts/item[@name='AvanceOfertas']/node()"/></a></strong>
				</td>
				<td class="textLeft">
					<strong><a class="btnNormal btn300px" href="javascript:Informe('licOfertasSeleccionadas2022.xsql?','Informe Licitacion');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Vencedores']/node()"/></a></strong>
				</td>
				<td class="textLeft">
					<strong><a class="btnNormal btn300px" href="javascript:Informe('VencedoresYAlternativas2022.xsql?OFERTAS=2&amp;','Informe vencedores y 2 alternativas de la licitacion');"><xsl:value-of select="document($doc)/translation/texts/item[@name='VencedoresY2Alternativas']/node()"/></a></strong>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td class="textLeft">
					<strong><a class="btnNormal btn300px" href="javascript:Informe('VencedoresYAlternativas2022.xsql?OFERTAS=4&amp;','Informe vencedores y 4 alternativas de la licitacion');"><xsl:value-of select="document($doc)/translation/texts/item[@name='VencedoresY4Alternativas']/node()"/></a></strong>
				</td>
				<td class="textLeft">
					<strong><a class="btnNormal btn300px" href="javascript:Informe('licInformePorProveedor2022.xsql?','Informe productos adjudicados de la licitacion');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_adjudicados_por_proveedor']/node()"/></a></strong>
				</td>
				<td class="textLeft">
					<strong><a class="btnNormal btn300px" href="javascript:Informe('licInformeProveedoresYOfertas2022.xsql?','Informe proveedores y ofertas de la licitacion');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores_y_ofertas']/node()"/></a></strong>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td class="textLeft">
					<strong><a class="btnNormal btn300px" href="javascript:Informe('licProductosNoSeleccionados2022.xsql?','Informe productos no seleccionados');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_no_seleccionados']/node()"/></a></strong>
				</td>
				<td class="textLeft">
					<strong><a class="btnNormal btn300px" href="javascript:Informe('licInformeResumen2022.xsql?','Informe resumen de la licitacion');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Informe_resumen_licitacion']/node()"/></a></strong>
				</td>
				<td class="textLeft">
					<strong><a class="btnNormal btn300px" href="javascript:Informe('licInformePedidos2022.xsql?','Informe pedidos de la licitacion');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Informe_pedidos_licitacion']/node()"/></a></strong>
				</td>
				<td>&nbsp;</td>
			</tr>
		</tbody>
		</table>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
	</div>
	</div>
	</form>
</div><!--fin de divLeft-->

</xsl:template>

</xsl:stylesheet>
