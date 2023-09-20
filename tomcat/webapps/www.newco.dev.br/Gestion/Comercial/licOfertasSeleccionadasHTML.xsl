<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Ficha con las ofertas seleccionadas, "Vencedores"	
	Ultima revision ET 23nov21 15:45 licOfertasSeleccionadas_231121.js
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

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Vencedores']/node()"/>:&nbsp;<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_TITULO"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>		<!-- Para descargas excel	-->
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/licOfertasSeleccionadas_231121.js"></script>
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
	<!--var incluirRefCentro = '<xsl:choose><xsl:when test="/OfertasSeleccionadas/LICITACION/INCLUIRREFCENTRO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';-->

	//	Mensajes y avisos
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
			producto['MarcasAceptables']	= '<xsl:value-of select="LIC_PROD_MARCASACEPTABLES"/>';			//23nov21
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

	<form method="post">

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>
		&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion']/node()"/>
		&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Vencedores']/node()"/></span>
		
		<span class="CompletarTitulo">
			<xsl:if test="/OfertasSeleccionadas/LICITACION/LIC_AGREGADA = 'S'">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/OfertasSeleccionadas/LICITACION/CENTROSCOMPRAS/field"/>
				<xsl:with-param name="onChange">javascript:document.forms[0].submit();</xsl:with-param>
				<xsl:with-param name="style">width:200px;</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
		</span>

		
		</p>
		<p class="TituloPagina">
			<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_CODIGO"/>:&nbsp;<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_TITULO"/>
			<span class="CompletarTitulo" style="width:870px;">
				<!-- Boton para la descarga de vencedores	-->
				<xsl:if test="/OfertasSeleccionadas/LICITACION/DESCARGA_VENCEDORES">
					<a class="btnDestacado" id="btnAjustarCantidad" href="javascript:AjustarCantidades();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='boton_ajustarCantidades']/node()"/>
                   	</a>&nbsp;
					<a class="btnNormal" href="javascript:DescargarVencedores();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='boton_descargarVencedores']/node()"/>
                   	</a>&nbsp;
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
						<xsl:choose>
						<xsl:when test="/OfertasSeleccionadas/LICITACION/PRODUCTOSLICITACION/PRODUCTOS_OLVIDADOS">
							<a class="btnDeshabilitado" id="botonAdjudicarSelec" href="javascript:AdjudicarOfertas();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicar']/node()"/></a>
						</xsl:when>
						<xsl:when test="/OfertasSeleccionadas/LICITACION/LIC_MESESDURACION>0">
							<a class="btnDestacado" id="botonAdjudicarSelec" href="javascript:AdjudicarOfertas();"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicar']/node()"/></a>
							<span id="waitBotonAdjudicar" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></span>
							<span id="txtPrepPedido">&nbsp;</span>
						</xsl:when>
						<xsl:when test="/OfertasSeleccionadas/LICITACION/LIC_PEDIDOSPENDIENTES>0">
							<a class="btnDestacado" id="botonAdjudicarSelec" href="javascript:PreparaLanzarTodosPedidos();"><xsl:value-of select="document($doc)/translation/texts/item[@name='boton_generar_pedido']/node()"/></a>
							<span id="waitBotonAdjudicar" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></span>
							<span id="txtPrepPedido">&nbsp;</span>
						</xsl:when>
						<xsl:otherwise>
							<!--14feb20 NO mostramos el botón de adjudicar si es licitacion SPOTy no hay pedidos pendientes-->
						</xsl:otherwise>
						</xsl:choose>								
						<span id="waitBotonAdjudicar" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></span>
					</xsl:otherwise>
					</xsl:choose>								
					<!--	11mar20	Botón contrato	-->
					<xsl:if test="/OfertasSeleccionadas/LICITACION/BOTON_CONTRATO">
					&nbsp;
						<a class="btnDestacado" id="botonEstContrato" href="javascript:PasarAEstadoContrato();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar_lic']/node()"/>
						</a>
					</xsl:if>
					&nbsp;
				</xsl:if>
<!--	4nov21
				<xsl:if test="/OfertasSeleccionadas/LICITACION/AUTOR and /OfertasSeleccionadas/LICITACION/BOTON_PEDIDO">
					<a class="btnDestacado" id="botonGenerarPedido" href="javascript:GenerarPedido();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='boton_generar_pedido']/node()"/>
                    </a>
					<span id="txtPrepPedido">&nbsp;</span>
					<span id="waitBotonGenPedido" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></span>
					&nbsp;
				</xsl:if>
-->
				<a class="btnNormal" style="text-decoration:none;">
					<xsl:attribute name="href">javascript:DescargarExcel();</xsl:attribute>
					<img src="http://www.newco.dev.br/images/iconoExcel.gif">
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_excel']/node()"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_excel']/node()"/></xsl:attribute>
					</img>
				</a>
				&nbsp;
				<!--<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/VencedoresYAlternativas.xsql?LIC_ID={/OfertasSeleccionadas/LIC_ID}"><xsl:value-of select="document($doc)/translation/texts/item[@name='VencedoresYAlternativas']/node()"/></a>
				&nbsp;
				<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/licInformePorProveedor.xsql?LIC_ID={/OfertasSeleccionadas/LIC_ID}"><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/></a>
				&nbsp;
				<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/licInformeProveedoresYOfertas.xsql?LIC_ID={/OfertasSeleccionadas/LIC_ID}"><xsl:value-of select="document($doc)/translation/texts/item[@name='Todas_Ofertas']/node()"/></a>
				&nbsp;
				<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/licInformeResumen.xsql?LIC_ID={/OfertasSeleccionadas/LIC_ID}"><xsl:value-of select="document($doc)/translation/texts/item[@name='Resumen_licitaciones']/node()"/></a>
				&nbsp;-->
				<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/licOfertasSeleccionadasImpr.xsql?US_ID={/OfertasSeleccionadas/US_ID}&amp;LIC_ID={/OfertasSeleccionadas/LIC_ID}&amp;IDCENTROCOMPRAS={/OfertasSeleccionadas/IDCENTROCOMPRAS}"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
				&nbsp;
				<xsl:choose>
				<xsl:when test="/OfertasSeleccionadas/LIC_PROD_ID != ''">
					<a class="btnNormal" href="javascript:history.go(-1)"><xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/></a>
					&nbsp;
				</xsl:when>
				<xsl:otherwise>
					<a class="btnNormal" style="text-decoration:none;"  href="javascript:window.close()"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>
					&nbsp;
				</xsl:otherwise>
				</xsl:choose>
			</span>
		</p>
	</div>
	<!--
	<h1 class="titlePage">
		<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_TITULO"/>&nbsp;&nbsp;&nbsp;&nbsp;
		
		<xsl:if test="/OfertasSeleccionadas/LICITACION/LIC_AGREGADA = 'S'">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/OfertasSeleccionadas/LICITACION/CENTROSCOMPRAS/field"/>
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
				<strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/FECHAACTUAL"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight" style="width:25%;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_FECHADECISIONPREVISTA"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_DESCRIPCION"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_entrega']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_CONDICIONESENTREGA"/>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_pago']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_CONDICIONESPAGO"/>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_otras']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_OTRASCONDICIONES"/>
			</td>
		</tr>
		<xsl:if test="/OfertasSeleccionadas/LICITACION/LIC_MESESDURACION>0">
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='meses_duracion']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_MESESDURACION"/>
			</td>
		</tr>
		</xsl:if>
		<xsl:if test="/OfertasSeleccionadas/LICITACION/TOTAL_ALAVISTA">
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_alavista']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/TOTAL_ALAVISTA"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_aplazado']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/TOTAL_APLAZADO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
			</td>
		</tr>
		</xsl:if>
		<xsl:if test="/OfertasSeleccionadas/LICITACION/TOTAL_PEDIDOS">
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_pedidos']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/TOTAL_PEDIDOS"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/></strong>
			</td>
		</tr>
		</xsl:if>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_adjudicado']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_CONSUMOADJUDICADO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/PRODUCTOSADJUDICADOS"/>/<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_NUMEROLINEAS"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_PROVEEDORESADJUDICADOS"/>/<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_NUMEROPROVEEDORES"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro']/node()"/> (%):&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_AHORROADJUDICADO"/>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_AHORROADJUDICADO_TOT"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
				&nbsp;(<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_CONSUMOHISTADJUDICADO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>)
			</td>
		</tr>
	</table><!--fin de tala datos generales-->
	<br/>
	<br/>
	<br/>
</div><!--fin de divLeft-->

<div class="divLeft">
	<form id="Proveedores" name="Proveedores" action="http://www.newco.dev.br/Gestion/Comercial/licOfertasSeleccionadas.xsql" method="POST">
	<input type="hidden" name="IDLicitacion" value="{/OfertasSeleccionadas/LICITACION/LIC_ID}"/>		<!--	para el JS	-->
	<input type="hidden" name="LIC_ID" value="{/OfertasSeleccionadas/LICITACION/LIC_ID}"/>				<!--	se utiliza en el XSQL		-->
	<input type="hidden" name="IDCentro" value="{/OfertasSeleccionadas/LICITACION/IDCENTRO}"/>
	<input type="hidden" name="ACCION" value=""/>
	<input type="hidden" name="PARAMETROS" value=""/>
	<input type="hidden" name="CODPEDIDO" value=""/>
	<input type="hidden" name="IDCENTROPEDIDO" value=""/>
	<xsl:for-each select="/OfertasSeleccionadas/LICITACION/PROVEEDORES/PROVEEDOR">
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
			
			<td colspan="12" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;		
			<!--
			<xsl:if test="NO_CUMPLE_PEDIDO_MINIMO">
				<img src="http://www.newco.dev.br/images/urgente.gif"/>
			</xsl:if>
			-->
			<xsl:if test="/OfertasSeleccionadas/LICITACION/LIC_AGREGADA='S' and /OfertasSeleccionadas/LICITACION/IDCENTROACTUAL=''">
				&nbsp;<xsl:value-of select="CENTRO"/>:&nbsp;
			</xsl:if>
			<xsl:value-of select="EMP_NIF"/>&nbsp;&nbsp;
			<xsl:if test="DATOSPRIVADOS/COP_CODIGO  != '' ">
				&nbsp;(<xsl:value-of select="DATOSPRIVADOS/COP_CODIGO"/>)&nbsp;
			</xsl:if>
			<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDPROVEEDOR}&amp;ESTADO=CABECERA','Detalle Empresa',100,80,0,0);">
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
			&nbsp;
			</xsl:if>
			<xsl:if test="DATOSPRIVADOS/COP_NOMBREBANCO  != '' ">
				&nbsp;(<xsl:value-of select="document($doc)/translation/texts/item[@name='Cuenta_bancaria']/node()"/>:&nbsp;
					<xsl:value-of select="DATOSPRIVADOS/COP_NOMBREBANCO"/>&nbsp;<xsl:value-of select="DATOSPRIVADOS/COP_CODBANCO"/>&nbsp;<xsl:value-of select="DATOSPRIVADOS/COP_CODOFICINA"/>&nbsp;<xsl:value-of select="DATOSPRIVADOS/COP_CODCUENTA"/>)&nbsp;
			</xsl:if>
			&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/>:&nbsp;<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="LIC_PROV_PEDIDOMINIMO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
			&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:&nbsp;<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="LIC_PROV_CONSUMOADJUDICADO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
			&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>:&nbsp;<xsl:value-of select="NUMERO_PRODUCTOS"/>
			<xsl:choose>
				<xsl:when test="PEDIDOS/TOTAL>0">
					&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>:
					<xsl:for-each select="PEDIDOS/PEDIDO">
						&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID={MO_ID}','Multioferta',100,80,0,0)"><xsl:value-of select="MO_NUMEROCLINICA"/>&nbsp;(<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="MO_IMPORTETOTAL"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>)</a>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="PEDIDOS/TOTAL=0 and PEDIDOS/BOTON_PEDIDO and ( not(/OfertasSeleccionadas/LICITACION/IDCENTRO) or (/OfertasSeleccionadas/LICITACION/IDCENTRO != '-1'))">
					<xsl:if test="/OfertasSeleccionadas/LICITACION/INCLUIRCODIGOPEDIDO='S'">&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>:<input type="text" class="medio" id="CODPEDIDO_{IDPROVEEDOR_LIC}_{IDCENTRO}"/></xsl:if>
					&nbsp;&nbsp;&nbsp;<a class="btnDestacado" id="btnCrearPedido_{IDPROVEEDOR_LIC}" href="javascript:crearPedido({IDPROVEEDOR_LIC},'{IDCENTRO}');"><xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_pedido']/node()"/></a>
				</xsl:when>
			</xsl:choose>
			</td>
		</tr>
		<!--14may19	<tr class="subTituloTabla">-->
		<xsl:if test="LIC_PROV_COMENTARIOSPROV!=''">
			<tr>
				<td colspan="12" align="center">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones']/node()"/>:&nbsp;<xsl:value-of select="LIC_PROV_COMENTARIOSPROV"/>
				</td>
			</tr>
		</xsl:if>
		<tr>
			<td colspan="9" align="center">
				<xsl:if test="LIC_PROV_FRETE  != '' ">			
					<xsl:value-of select="document($doc)/translation/texts/item[@name='frete']/node()"/>:&nbsp;<strong><xsl:value-of select="LIC_PROV_FRETE"/></strong>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</xsl:if>
				<xsl:if test="LIC_PROV_PLAZOENTREGA  != '' ">  
					<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/>:&nbsp;<strong><xsl:value-of select="LIC_PROV_PLAZOENTREGA"/></strong>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='dias']/node()"/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</xsl:if>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='forma_pago']/node()"/>:&nbsp;
				<xsl:choose>
				<xsl:when test="/OfertasSeleccionadas/LICITACION/LIC_AGREGADA='S' and /OfertasSeleccionadas/LICITACION/IDCENTROACTUAL='-1'">
					<xsl:value-of select="FORMAPAGO"/>.&nbsp;<xsl:value-of select="PLAZOPAGO"/>.
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="FORMASPAGO/field"/>
					<xsl:with-param name="id">FORMASPAGO_<xsl:value-of select="IDPROVEEDOR_LIC"/><xsl:value-of select="IDCENTRO"/></xsl:with-param>
					<xsl:with-param name="onChange">javascript:ActivarCambio(<xsl:value-of select="IDPROVEEDOR_LIC"/>,'<xsl:value-of select="IDCENTRO"/>')</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="PLAZOSPAGO/field"/>
					<xsl:with-param name="id">PLAZOSPAGO_<xsl:value-of select="IDPROVEEDOR_LIC"/><xsl:value-of select="IDCENTRO"/></xsl:with-param>
					<xsl:with-param name="onChange">javascript:ActivarCambio(<xsl:value-of select="IDPROVEEDOR_LIC"/>,'<xsl:value-of select="IDCENTRO"/>')</xsl:with-param>
					</xsl:call-template>
					<a class="guardarOferta btnDestacado" style="display:none;" id="BOTONGUARDAR_{IDPROVEEDOR_LIC}{IDCENTRO}">
					<xsl:attribute name="href">
					<xsl:choose>
					<!-- para liciatciones no agregadas o si no está seleccionado un centro	-->
					<xsl:when test="/OfertasSeleccionadas/LICITACION/LIC_AGREGADA = 'N' or (/OfertasSeleccionadas/LICITACION/IDCENTRO = '-1')">javascript:GuardarFormaYPlazoPago(<xsl:value-of select="IDPROVEEDOR_LIC"/>);</xsl:when>
					<xsl:otherwise>javascript:GuardarFormaYPlazoPagoCentro(<xsl:value-of select="IDPROVEEDOR_LIC"/>,'<xsl:value-of select="IDCENTRO"/>');</xsl:otherwise>
					</xsl:choose>
					</xsl:attribute>
					<!--<img id="BOTONGUARDAR_{IDPROVEEDOR_LIC}" src="http://www.newco.dev.br/images/guardar.gif" class="" style="display:none;" title="{document($doc)/translation/texts/item[@name='guardar']/node()}" alt="{document($doc)/translation/texts/item[@name='guardar']/node()}"/>-->
					<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
					</a>
					<span id="AVISOACCION_{IDPROVEEDOR_LIC}{IDCENTRO}"/>
				</xsl:otherwise>
				</xsl:choose>
			</td>
			<td align="left">
				<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/ImprimirOferta.xsql?LIC_ID={/OfertasSeleccionadas/LICITACION/LIC_ID}&amp;LIC_PROV_ID={IDPROVEEDOR_LIC}','Oferta',100,80,0,0);"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_ofertas']/node()"/></a>
			</td>
		</tr>
		<tr class="gris">
			<td class="uno">&nbsp;</td>
			<!--<td class="cinco"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_mvm']/node()"/></strong></td>-->
			<td class="cinco"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></strong></td>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/INCLUIRREFCENTRO">
				<td class="cinco"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_centro']/node()"/></strong></td>
			</xsl:if>
			<td class="trenta" style="text-align:left;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></strong></td>
			<td class="cinco"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></strong></td>
			<td class="quince"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></strong></td>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS != 55">
				<td class="siete"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/></strong></td>
			</xsl:if>
			<td class="diez"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/></strong></td>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34">
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
	<xsl:choose>
	<!-- para licitaciones multipedido	-->
	<xsl:when test="/OfertasSeleccionadas/LICITACION/LIC_MULTIPEDIDO = 'S'">
		<xsl:for-each select="PEDIDO">
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
					<td><xsl:value-of select="LINEA"/></td>
					<!--<td><xsl:value-of select="LIC_PROD_REFESTANDAR"/></td>-->
					<td><xsl:value-of select="LIC_PROD_REFCLIENTE"/></td>
<!--					<td>
						<xsl:choose>
						<!- - para liciatciones no agregadas o si no está seleccionado un centro	- ->
						<xsl:when test="LIC_PROD_REFCLIENTE != ''"><xsl:value-of select="LIC_PROD_REFCLIENTE"/></xsl:when>
						<xsl:otherwise><xsl:value-of select="LIC_PROD_REFESTANDAR"/></xsl:otherwise>
						</xsl:choose>
					</td>
					-->
					<xsl:if test="/OfertasSeleccionadas/LICITACION/INCLUIRREFCENTRO">
						<td><xsl:value-of select="REFCENTRO"/></td>
					</xsl:if>
					<td class="datosLeft">
						<a href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/OfertasSeleccionadas/LICITACION/LIC_ID}">
							<xsl:value-of select="LIC_PROD_NOMBRE"/><xsl:if test="LIC_PROD_MARCASACEPTABLES != ''">&nbsp;[<xsl:value-of select="LIC_PROD_MARCASACEPTABLES"/>]</xsl:if>
						</a>
						<!--	Solo el producto activo en (i)
						<xsl:if test="LIC_PROD_MARCASACEPTABLES != '' or LIC_PROD_PRINCIPIOACTIVO != ''">
							<img src="http://www.newco.dev.br/images/2017/info.png" title="Marcas:{LIC_PROD_MARCASACEPTABLES}&#13;Princ.Activo:{LIC_PROD_PRINCIPIOACTIVO}" class="static"/>
						</xsl:if>
						-->
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
					<td class="datosRight">
						<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="LIC_OFE_PRECIO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
					</td>
					<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS != 55">
						<td><xsl:value-of select="LIC_OFE_TIPOIVA"/>%</td>
					</xsl:if>
					<td><xsl:value-of select="LIC_OFE_UNIDADESPORLOTE"/></td>
					<td class="datosRight">
						<xsl:if test="CAMBIO_CANTIDAD">
							(<xsl:value-of select="CANTIDADORIGINAL"/>-><xsl:value-of select="CANTIDAD"/>)&nbsp;
						</xsl:if>
						<strong><xsl:value-of select="CANTIDAD"/></strong>&nbsp;
					</td>
					<td class="datosRight">
						<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="CONSUMO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
					</td>
					<td class="datosRight fondogris">
						<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="LIC_PROD_PRECIOREFERENCIA"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
					</td>
					<td class="datosRight fondogris">
						<xsl:value-of select="LIC_OFE_AHORRO"/>%
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:when>
	<xsl:otherwise>
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
				<!--<td><xsl:value-of select="LIC_PROD_REFESTANDAR"/></td>-->
				<td><xsl:value-of select="LIC_PROD_REFCLIENTE"/></td>
				<xsl:if test="/OfertasSeleccionadas/LICITACION/INCLUIRREFCENTRO">
					<td><xsl:value-of select="REFCENTRO"/></td>
				</xsl:if>
				<!--
				<td>
					<xsl:choose>
					<!- - para liciatciones no agregadas o si no está seleccionado un centro	- ->
					<xsl:when test="LIC_PROD_REFCLIENTE != ''"><xsl:value-of select="LIC_PROD_REFCLIENTE"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="LIC_PROD_REFESTANDAR"/></xsl:otherwise>
					</xsl:choose>
				</td>
				-->
				<td class="datosLeft">
					<a href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/OfertasSeleccionadas/LICITACION/LIC_ID}">
						<xsl:value-of select="LIC_PROD_NOMBRE"/><xsl:if test="LIC_PROD_MARCASACEPTABLES != ''">&nbsp;[<xsl:value-of select="LIC_PROD_MARCASACEPTABLES"/>]</xsl:if>
					</a>
					<!--	Solo el producto activo en (i)
					<xsl:if test="LIC_PROD_MARCASACEPTABLES != '' or LIC_PROD_PRINCIPIOACTIVO != ''">
						<img src="http://www.newco.dev.br/images/2017/info.png" title="Marcas:{LIC_PROD_MARCASACEPTABLES}&#13;Princ.Activo:{LIC_PROD_PRINCIPIOACTIVO}" class="static"/>
					</xsl:if>
					-->
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
				<td class="datosRight">
					<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="LIC_OFE_PRECIO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
				<!--
				<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 55">R$&nbsp;</xsl:if>
				<xsl:value-of select="LIC_OFE_PRECIO"/>
				<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34">&nbsp;&#128;</xsl:if>&nbsp;
				-->
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
				<td class="datosRight">
					<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="CONSUMO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
					<!--
				<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 55">R$&nbsp;</xsl:if>
				<xsl:value-of select="CONSUMO"/>
				<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34">&nbsp;&#128;</xsl:if>&nbsp;
				-->
				</td>
				<td class="datosRight fondogris">
					<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="LIC_PROD_PRECIOREFERENCIA"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
				</td>
				<td class="datosRight fondogris">
					<xsl:value-of select="LIC_OFE_AHORRO"/>%
				</td>
			</tr>
		</xsl:for-each>
	</xsl:otherwise>
	</xsl:choose>
	</tbody>
	</table>
	<br/>
	<br/>
	</xsl:for-each>
	<xsl:if test="/OfertasSeleccionadas/LICITACION/PRODUCTOS_SIN_OFERTA/PRODUCTO">
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
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34">
				<td class="cinco"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></strong></td>
			</xsl:if>
			<td class="diez"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></strong></td>
			<td class="diez"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></strong></td>
			<td class="quince">&nbsp;</td>
		</tr>
	</thead>
	<tbody>
	<xsl:for-each select="/OfertasSeleccionadas/LICITACION/PRODUCTOS_SIN_OFERTA/PRODUCTO">
		<tr class="gris">
			<td><xsl:value-of select="CONTADOR"/></td>
			<td><xsl:value-of select="REFERENCIA"/></td>
			<td class="datosLeft">
				<a href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/OfertasSeleccionadas/LICITACION/LIC_ID}">
				<xsl:value-of select="LIC_PROD_NOMBRE"/></a>
			</td>
			<td><xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>
			<td class="datosRight">
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 55 and LIC_PROD_PRECIO>0">R$&nbsp;</xsl:if>
			<xsl:value-of select="LIC_PROD_PRECIO"/>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34 and LIC_PROD_PRECIO>0">&nbsp;&#128;</xsl:if>&nbsp;
			</td>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34">
				<td><xsl:value-of select="LIC_PROD_TIPOIVA"/>%</td>
			</xsl:if>
			<td class="datosRight"><xsl:value-of select="LIC_PROD_CANTIDAD"/></td>&nbsp;
			<td class="datosRight">
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 55 and LIC_PROD_CONSUMO>0">R$&nbsp;</xsl:if>
			<xsl:value-of select="LIC_PROD_CONSUMO"/>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34 and LIC_PROD_CONSUMO>0">&nbsp;&#128;</xsl:if>&nbsp;
			</td>
			<td>&nbsp;</td>
		</tr>
	</xsl:for-each>
	</tbody>
	</table>
	</xsl:if>
	<xsl:if test="/OfertasSeleccionadas/LICITACION/PRODUCTOS_JUSTIFICADOS/PRODUCTO">
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
			<td class="cinco">&nbsp;</td>
			<td class="siete"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></strong></td>
			<td class="trenta" style="text-align:left;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></strong></td>
			<td class="datosLeft"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='justificacion']/node()"/></strong></td>
			<td class="cinco">&nbsp;</td>
		</tr>
	</thead>
	<tbody>
	<xsl:for-each select="/OfertasSeleccionadas/LICITACION/PRODUCTOS_JUSTIFICADOS/PRODUCTO">
		<tr class="gris">
			<td><xsl:value-of select="CONTADOR"/></td>
			<td><xsl:value-of select="REFERENCIA"/></td>
			<td class="datosLeft">
				<a href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/OfertasSeleccionadas/LICITACION/LIC_ID}">
				<xsl:value-of select="LIC_PROD_NOMBRE"/></a>
			</td>
			<td class="datosLeft"><xsl:value-of select="JUSTIFICACION"/><xsl:value-of select="LIC_PROD_MOTIVOSELECCION"/></td>
			<td>&nbsp;</td>
		</tr>
	</xsl:for-each>
	</tbody>
	</table>
	</xsl:if>
	<xsl:if test="/OfertasSeleccionadas/LICITACION/OFERTAS_DESCARTADAS/OFERTA">
	<!--<table class="infoTable">-->
	<br/>
	<br/>
	<br/>
	<table class="buscador">
	<thead>
		<tr class="subTituloTabla">
			<td colspan="10" align="center">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Ofertas_descartadas']/node()"/>
			</td>
		</tr>
		<tr class="gris">
			<td class="cinco">&nbsp;</td>
			<td class="trenta datosLeft" style="text-align:left;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></strong></td>
			<td class="siete"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></strong></td>
			<td class="trenta" style="text-align:left;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></strong></td>
			<td class="diez" style="text-align:left;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></strong></td>
			<td class="cinco" style="text-align:left;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></strong></td>
			<td class="datosLeft"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='justificacion']/node()"/></strong></td>
			<td class="cinco">&nbsp;</td>
		</tr>
	</thead>
	<tbody>
	<xsl:for-each select="/OfertasSeleccionadas/LICITACION/OFERTAS_DESCARTADAS/OFERTA">
		<tr class="gris">
			<td><xsl:value-of select="CONTADOR"/></td>
			<td class="datosLeft"><xsl:value-of select="PROVEEDOR"/></td>
			<td><xsl:value-of select="REFERENCIA"/></td>
			<td class="datosLeft">
				<a href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/OfertasSeleccionadas/LICITACION/LIC_ID}">
				<xsl:value-of select="LIC_PROD_NOMBRE"/></a>
			</td>
			<td><xsl:value-of select="MARCA"/></td>
			<td><xsl:value-of select="PRECIO"/></td>
			<td class="datosLeft"><xsl:value-of select="JUSTIFICACION"/><xsl:value-of select="LIC_PROD_MOTIVOSELECCION"/></td>
			<td>&nbsp;</td>
		</tr>
	</xsl:for-each>
	</tbody>
	</table>
	</xsl:if>
	<xsl:if test="/OfertasSeleccionadas/LICITACION/ADJUDICADOS_ELIMINADOS/OFERTA">
	<!--<table class="infoTable">-->
	<br/>
	<br/>
	<br/>
	<table class="buscador">
	<thead>
		<tr class="subTituloTabla">
			<td colspan="10" align="center">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Ofertas_adjudicadas_eliminadas']/node()"/>
			</td>
		</tr>
		<tr class="gris">
			<td class="cinco">&nbsp;</td>
			<td class="trenta datosLeft" style="text-align:left;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></strong></td>
			<td class="siete"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></strong></td>
			<td class="trenta" style="text-align:left;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></strong></td>
			<td class="diez" style="text-align:left;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></strong></td>
			<td class="cinco" style="text-align:left;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></strong></td>
			<td class="cinco">&nbsp;</td>
		</tr>
	</thead>
	<tbody>
	<xsl:for-each select="/OfertasSeleccionadas/LICITACION/ADJUDICADOS_ELIMINADOS/OFERTA">
		<tr class="gris">
			<td><xsl:value-of select="CONTADOR"/></td>
			<td class="datosLeft"><xsl:value-of select="PROVEEDOR"/></td>
			<td><xsl:value-of select="REFERENCIA"/></td>
			<td class="datosLeft">
				<a href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/OfertasSeleccionadas/LICITACION/LIC_ID}">
				<xsl:value-of select="LIC_PROD_NOMBRE"/></a>
			</td>
			<td><xsl:value-of select="MARCA"/></td>
			<td><xsl:value-of select="PRECIO"/></td>
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
