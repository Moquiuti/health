<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	LICITACION POR PRODUCTO / NUEVO DISENNO V2 para la licitacion.	 
	Ultima revision:ET 07set22 12:00 LicitacionV2_2022_070922.js LicV2Prods_2022_220822.js LicV2Provs_2022_100822.js LicV2Centros_2022_100722.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<!--20jun22 Incluimos los templates para las tablas internas	-->
<xsl:import href="http://www.newco.dev.br/Gestion/Comercial/LicV2GeneralTemplates2022.xsl"/>
<xsl:import href="http://www.newco.dev.br/Gestion/Comercial/LicV2ProductosTemplates2022.xsl"/>
<xsl:import href="http://www.newco.dev.br/Gestion/Comercial/LicV2ProveedoresTemplates2022.xsl"/>
<xsl:import href="http://www.newco.dev.br/Gestion/Comercial/LicV2CentrosTemplates2022.xsl"/>
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
			<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<meta http-equiv="Cache-Control" content="no-cache"/>

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion']/node()"/>:&nbsp;<xsl:value-of select="/Mantenimiento/LICITACION/LIC_TITULO"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<link href="http://www.newco.dev.br/General/Tabla-popup.2022.css" rel="stylesheet" type="text/css"/>	<!-- Tablas pop-up	-->
	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>		<!-- Para descargas excel	-->
	<script	type="text/javascript" src="http://www.newco.dev.br/General/Tabla-popup.150715.js"></script><!--	showTabla, showTablaByID	-->
	<script type="text/javascript">
	var IDUsuario		=<xsl:value-of select="/Mantenimiento/LICITACION/IDUSUARIO"/>;
	var IDLicitacion	=<xsl:value-of select="/Mantenimiento/LICITACION/LIC_ID"/>;
	var IDEmpresa		=<xsl:value-of select="/Mantenimiento/LICITACION/LIC_IDEMPRESA"/>;
	var IDProdLicActivo	='<xsl:value-of select="/Mantenimiento/LIC_PROD_ID"/>';
	var IDPais			=<xsl:value-of select="/Mantenimiento/LICITACION/IDPAIS"/>;
	var IDIdioma		='<xsl:value-of select="/Mantenimiento/LICITACION/IDIDIOMA"/>';
	var rol				='<xsl:value-of select="/Mantenimiento/LICITACION/ROL"/>';
	var EstadoLic		='<xsl:value-of select="/Mantenimiento/LICITACION/LIC_IDESTADO"/>';
	var mesesSelected	= '<xsl:value-of select="/Mantenimiento/NUEVALICITACION/LIC_MESESDURACION"/>';
	var	liciFirmada 	='';		//	24jun22
	var IDCentroSel		='<xsl:value-of select="/Mantenimiento/IDCENTROCOMPRAS"/>';
	var MesesDuracion	='<xsl:value-of select="/Mantenimiento/LICITACION/LIC_MESESDURACION"/>';
	var isLicPorProducto='<xsl:value-of select="/Mantenimiento/LICITACION/LIC_PORPRODUCTO"/>';
	var isLicContinua	='<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CONTINUA"/>';
	var isLicAgregada	='<xsl:value-of select="/Mantenimiento/LICITACION/LIC_AGREGADA"/>';
	var isLicMultiopcion	=  '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_MULTIOPCION"/>';
	var esCdC	= '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/CDC">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
	var esAutor	= '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/AUTOR">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
	var NumCentrosEnLicitacion= '<xsl:value-of select="/Mantenimiento/LICITACION/CENTROS_EN_LICITACION"/>';
	var NumCentrosPendientes= '<xsl:value-of select="/Mantenimiento/LICITACION/CENTROS_PENDIENTES_INFORMAR"/>';
	var totalProductos		= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_NUMEROLINEAS"/>';
	var numProdsSeleccion	= '<xsl:value-of select="/Mantenimiento/LICITACION/TOTAL_SELECCIONADAS"/>';
	var numProvsNoCumplen	= '<xsl:value-of select="/Mantenimiento/LICITACION/TOTAL_NO_CUMPLEN_PEDMINIMO"/>';
	var numProdsRevisarUdesLote	= '<xsl:value-of select="/Mantenimiento/LICITACION/TOTAL_REVISAR_UNIDADESPORLOTE"/>';
	var conCircuitoAprobacion = '<xsl:value-of select="/Mantenimiento/LICITACION/CON_CIRCUITO_APROBACION"/>';
	var saltarPedMinimo = '<xsl:value-of select="/Mantenimiento/LICITACION/SALTARPEDIDOMINIMO"/>';
	var fechaEntregaPedidoVencida = '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/FECHA_PEDIDO_VENCIDA">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
	var editarCant	= '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/PERMITIR_MODIFICAR_CANTIDADES">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
	var incluirDocs = '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/INCLUIR_COLUMNA_DOCUMENTOS">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
	var botonPedido = '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/BOTON_PEDIDO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
	var MostrarMotivoSeleccion	= '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/MOSTRARMOTIVOSELECCION">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
	var fechaDecisionLic 	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_FECHADECISIONPREVISTA"/>';		//	25abr17	
	var SoloProvInformados	='<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/LIC_IDESTADO = 'EST' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'COMP'">N</xsl:when><xsl:otherwise>S</xsl:otherwise></xsl:choose>';
	var mostrarPrecioIVA	= '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
	var completarCompraCentro	= '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/COMPLETAR_COMPRA_CENTRO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
	var mostrarResumenFlotante	= '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/MOSTRAR_RESUMEN_FLOTANTE">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
	var modificarPrecioOferta	= '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/MODIFICAR_PRECIO_OFERTA">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';

	var mostrarCategorias	= '<xsl:value-of select="/Mantenimiento/LICITACION/NOMBRESNIVELES/@MostrarCategoria"/>';
	var mostrarGrupos	= '<xsl:value-of select="/Mantenimiento/LICITACION/NOMBRESNIVELES/@MostrarGrupo"/>';
	var alrt_UdBasicaNoInformada	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_udbasicanoinformada']/node()"/>';
	var alrt_CantidadCero	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_cantidad_cero']/node()"/>';

	var filtroNombre	= '';

	//	Textos para construir tablas de datos
	var str_PagAnterior		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/>';
	var str_PagSiguiente	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/>';
	var str_Paginacion		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_paginacion']/node()"/>';
	var str_TotalConsSIVA	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='total_sIVA']/node()"/>';
	var str_borrar	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>';
	var strTipoIva	='<xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/>';
	var strEstaEval	='<xsl:value-of select="document($doc)/translation/texts/item[@name='estado_evaluacion']/node()"/>';
	var strFecOferta='<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_oferta']/node()"/>';
	var strFecha	='<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>';
	var strProveedor='<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>';
	var strPedMin	='<xsl:value-of select="document($doc)/translation/texts/item[@name='Ped_minimo']/node()"/>';
	var strPlEntrega='<xsl:value-of select="document($doc)/translation/texts/item[@name='Pl_entrega']/node()"/>';
	//11ago22	var strConsumo	='<xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/>';
	var strTotPedido	='<xsl:value-of select="document($doc)/translation/texts/item[@name='Tot_pedido']/node()"/>';				//11ago22
	var strVerDoc	='<xsl:value-of select="document($doc)/translation/texts/item[@name='Ver_doc']/node()"/>';
	var strRefProv	='<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>';
	var strCentros	='<xsl:value-of select="document($doc)/translation/texts/item[@name='centros']/node()"/>';
	var	strAvanzado	='<xsl:value-of select="document($doc)/translation/texts/item[@name='Avanzado']/node()"/>';
	var strProveedor='<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>';
	var strEmpaq	='<xsl:value-of select="document($doc)/translation/texts/item[@name='embalaje']/node()"/>';
	var strCerrar	='<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>';
	var strProveedor='<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>';
	var strCentro	='<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>';
	//11ago22 var strConsumo2l='<xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_sIVA_2line']/node()"/>';
	var strTotLinea	='<xsl:value-of select="document($doc)/translation/texts/item[@name='Tot_linea']/node()"/>';			//11ago22

	var strRef		='<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/>';
	var strProducto	='<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>';
	var strMarca	='<xsl:value-of select="document($doc)/translation/texts/item[@name='lic_marca']/node()"/>';
	var strIncluir	='<xsl:value-of select="document($doc)/translation/texts/item[@name='Incluir']/node()"/>';
	var strUdesLote	='<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_por_lote']/node()"/>';
	var strSelecc	='<xsl:value-of select="document($doc)/translation/texts/item[@name='seleccionar']/node()"/>';
	var strPrecio	='<xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>';
	var strConsumo2l='<xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_sIVA_2line']/node()"/>';

	var strInfoAmp	='<xsl:value-of select="document($doc)/translation/texts/item[@name='info_ampliada']/node()"/>';
	var strPedido	='<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>';
	var strOfertaAdj='<xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()"/>';
	var strGuardar='<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>';
	var strUlt3meses='<xsl:value-of select="document($doc)/translation/texts/item[@name='ultimos_3_meses']/node()"/>';
	var strUltPedido='<xsl:value-of select="document($doc)/translation/texts/item[@name='Ultimo_pedido']/node()"/>';
	var strSinPedidosAnt='<xsl:value-of select="document($doc)/translation/texts/item[@name='Producto_sin_pedidos_anteriores']/node()"/>';
	var strSinPedidosTri='<xsl:value-of select="document($doc)/translation/texts/item[@name='Producto_sin_pedidos_trimestre']/node()"/>';
	var strMin	='<xsl:value-of select="document($doc)/translation/texts/item[@name='Min']/node()"/>';
	var strMax	='<xsl:value-of select="document($doc)/translation/texts/item[@name='Max']/node()"/>';
	var strMedio='<xsl:value-of select="document($doc)/translation/texts/item[@name='Medio']/node()"/>';
	var strNumPedidos='<xsl:value-of select="document($doc)/translation/texts/item[@name='eis_numero_pedidos']/node()"/>';
	var strCantidad='<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/>';
	var strMarcas='<xsl:value-of select="document($doc)/translation/texts/item[@name='marcas']/node()"/>';
	var strPrincActivo='<xsl:value-of select="document($doc)/translation/texts/item[@name='Principio_activo']/node()"/>';
	var strConsSinIva='<xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_sIVA']/node()"/>';
	var strCurvaABC='<xsl:value-of select="document($doc)/translation/texts/item[@name='Curva_ABC']/node()"/>';
	var strPrecioHist='<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_historico_sIVA']/node()"/>';
	var strUdBasica='<xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/>';
	var	strExpli='<xsl:value-of select="document($doc)/translation/texts/item[@name='explicacion']/node()"/>';
	var	strSeleccionar='<xsl:value-of select="document($doc)/translation/texts/item[@name='seleccionar']/node()"/>';

	<!-- Strings para tabla productos EST -->
	var str_licSinProductos		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion_sin_productos']/node()"/>';
	var txtNivel3			= '<xsl:value-of select="/Mantenimiento/LICITACION/NOMBRESNIVELES/NIVEL3"/>';
	var str_borrar			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>';
	var str_totalConsumo		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='total_consumo']/node()"/>';
	var str_ActualizarDatos		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar_datos']/node()"/>';
	var str_InsertarProductos_OK= '<xsl:value-of select="document($doc)/translation/texts/item[@name='insertar_productos_ok']/node()"/>';
	var str_PagAnterior		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/>';
	var str_PagSiguiente		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/>';
	var str_Paginacion		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_paginacion']/node()"/>';
	var str_Todas			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/>';
	var str_Selecciona		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='selecciona']/node()"/>';
	var str_AnyadirInfoAmpliada	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='anyadir_info_ampliada']/node()"/>';
	var str_InfoAmpliada		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='info_ampliada']/node()"/>';
	var str_Documento		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/>';
	var str_Anotaciones		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='anotaciones']/node()"/>';
	var alrt_malFechaObligatoria	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='alert_fecha_obligatoria']/node()"/>';
	var alrt_malFechaProhibida		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='alert_fecha_prohibida']/node()"/>';

	<!-- Strings para tabla productos OFE -->
	var str_ProductoSinSeleccion	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='producto_sin_seleccion']/node()"/>';
	var str_ProductoSinAhorro	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='producto_sin_ahorro']/node()"/>';
	var str_OfertaNoInformada	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_no_informada']/node()"/>';
	var str_SinOferta	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_oferta']/node()"/>';
	var str_OfertaNoOfertada	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_no_ofertada']/node()"/>';
	var str_OfertaAdjudicada	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()"/>';
	var str_PrecioOfertaSospechoso	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_oferta_sospechoso']/node()"/>';
	var str_PrecioOfertaMuySospechoso	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_oferta_muy_sospechoso']/node()"/>';
	var str_ofertaNoApto		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_no_apto_evaluacion']/node()"/>';
	var str_ofertaPendiente	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_pendiente_evaluacion']/node()"/>';
	var str_ofertaApto			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_apto_evaluacion']/node()"/>';
	var str_FichaTecnica		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='ficha_tecnica']/node()"/>';
	var str_RegistroSanitario	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='registro_sanitario']/node()"/>';
	var str_CertExperiencia	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cert_experiencia']/node()"/>';
	var str_PorcNegociado		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='porcentage_negociado']/node()"/>';
	var str_PorcAhorro			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='porcentage_ahorro']/node()"/>';
	var str_ProdsSinOferta	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='num_productos_sin_oferta']/node()"/>';
	var str_ProdsSinOfertaConAhorro	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='num_productos_sin_oferta_con_ahorro']/node()"/>';
	var str_InfoAmpliada		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='info_ampliada']/node()"/>';
	<!-- Strings para tabla productos PROVE -->
	var str_SinOfertar	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_ofertar']/node()"/>';
	var str_SubirFicha	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_ficha']/node()"/>';
	var str_SubirRegSan	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_reg_sanitario']/node()"/>';
	var str_DocCargado	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/>';
	var str_Alternativa		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='alternativa']/node()"/>';

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
	var alrt_NoHaSeleccionadoOferta	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='no_ha_seleccionado_oferta']/node()"/>';
	var alrt_RequiereMotivo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_requiere_motivo']/node()"/>';

	var alrt_GuardarSelOk		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_selecc_adjudica_ok']/node()"/>';
	var alrt_GuardarSelKo		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_selecc_adjudica_ko']/node()"/>';
	var alrt_CambiosPendientes	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cambios_pendientes']/node()"/>';
	var alrt_CantidadInfTotal	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_inferior_total']/node()"/>';
	var alrt_CantidadSupTotal	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_superior_total']/node()"/>';
	var alrt_TotalAsignadoNoCoincide= '<xsl:value-of select="document($doc)/translation/texts/item[@name='total_asignado_no_coincide']/node()"/>';
	var alrt_CantidadNoCorresponde= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cantidad_no_corresponde_empaq']/node()"/>';
	var alrt_SuperadaCantidad	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Superada_cantidad']/node()"/>';
	var alrt_GuardarFechaDecisionKO= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Guardar_fecha_decision_ko']/node()"/>';

	var alrt_ExistenProdSel= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Existen_productos_no_selecc']/node()"/>';
	var alrt_ExistenProdModif= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Existen_productos_modif']/node()"/>';
	var alrt_DeseaContinuar= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Desea_continuar']/node()"/>';
	var conf_PerderCambios	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='confirm_se_han_producido_cambios']/node()"/>';
	var conf_MejoresPrecios	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Esta_seguro_mejores_precios']/node()"/>';

	<!-- Otros alerts -->
	var alrt_NoIniciarLicitacion	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_no_iniciar_licitacion']/node()"/>';
	var alrt_NoIniciarLicProds	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_no_iniciar_licitacion_productos']/node()"/>';
	var alrt_NoIniciarLicProvs	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_no_iniciar_licitacion_proveedores']/node()"/>';
	var alrt_NoIniciarLicCentros	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_no_iniciar_licitacion_centros']/node()"/>';
	var alrt_NuevoEstadoLicKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_nuevo_estado_licitacion']/node()"/>';
	var alrt_faltaInformarOfertas	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_informar_ofertas']/node()"/>';
	var alrt_publicarOfertaVacia	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='publicar_oferta_vacia']/node()"/>';
	var alrt_faltaPedidoMinimo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='validacion_pedido_minimo']/node()"/>';
	var alrt_faltaCondLicitacion	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_aceptar_condiciones_licitacion']/node()"/>';
	var alrt_firmaProveedorOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='firma_proveedor_ok']/node()"/>';
	var alrt_NuevoEstadoProveedorKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_nuevo_estado_proveedor']/node()"/>';
	var conf_InsertarCatalogoProv	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='confirm_insertar_en_catalogo_proveedores']/node()"/>';
	var alrt_InsertarCatProvKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_insertar_en_catalogo_proveedores']/node()"/>';
	var conf_InsertarEnPlantilla	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='confirm_insertar_en_plantilla']/node()"/>';
	var alrt_InsertarEnPlantillaKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_insertar_en_plantilla']/node()"/>';
	var alrt_sinResultados = '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_sin_resultados']/node()"/>';
	var alrt_erroarAlActualizar = '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_actualizar']/node()"/>';
	var alrt_avisoEstadoContrato= '<xsl:value-of select="document($doc)/translation/texts/item[@name='aviso_estado_contrato']/node()"/>';


	<!-- Textos y avisos para tabla usuarios -->
	var str_Autor	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/>';
	var alrt_UsuarioYaExiste	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_usuario_ya_existe']/node()"/>';
	var alrt_NuevoUsuarioKO		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_nuevo_usuario']/node()"/>';
	var alrt_EliminarUsuarioKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_eliminar_usuario']/node()"/>';
	var alrt_licitacionFirmada	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cliente_firma_licitacion']/node()"/>';

	<!-- Textos y avisos para tabla centros -->
	var val_faltaCentro			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_centro']/node()"/>';
	var alrt_CentroYaExiste		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_centro_ya_existe']/node()"/>';
	var alrt_NuevoCentroKO		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_nuevo_centro']/node()"/>';
	var alrt_EliminarCentroKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_eliminar_centro']/node()"/>';
	var str_SinCentros			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion_sin_centros']/node()"/>';

	<!-- Strings para tabla proveedores -->
	var str_licSinProveedores	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion_sin_proveedores']/node()"/>';
	var str_provOfertasVacias	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='productos_sin_ofertas']/node()"/>';
	var str_enviarCorreo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_email']/node()"/>';
	var str_leerConversacion	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='leer_conversacion']/node()"/>';
	var str_iniciarConversacion	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='iniciar_conversacion']/node()"/>';
	var str_provNoApto		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor_no_apto_evaluacion']/node()"/>';
	var str_provPendiente	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor_pendiente_evaluacion']/node()"/>';
	var str_provApto		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor_apto_evaluacion']/node()"/>';
	var str_Activar			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='activar']/node()"/>';
	var str_SuspenderOferta		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='suspender_oferta']/node()"/>';
	var str_Rollback		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='lic_rollback_estado']/node()"/>';
	var str_Adjudicar		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicar']/node()"/>';
	var str_ImprimirOferta		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir_oferta']/node()"/>';
	var str_ListadoExcel		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='listado_excel']/node()"/>';
	var str_ConsHistIVA		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_historico_cIVA']/node()"/>';
	var str_ConsHist		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_historico_sIVA']/node()"/>';
	var str_TotalProductos		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='total_prod']/node()"/>';
	var str_EnCurso			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='en_curso']/node()"/>';
	//24jun22 ya existe str_Autor 	var str_autor			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/>';
	var str_fecha			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>';
	var str_comentario		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='comentario']/node()"/>';
	var str_guardarCommOK		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='comentario_licitacion_guardado']/node()"/>';
	var str_guardarCommKO		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='comentario_licitacion_error']/node()"/>';
	var str_Contrato		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='contrato']/node()"/>';
	var str_SubirContrato		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_contrato']/node()"/>';
	var str_cambiarUsuario		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cambiar_usuario']/node()"/>';
	var	str_IncluyendoProvs='<xsl:value-of select="document($doc)/translation/texts/item[@name='Incluyendo_proveedores']/node()"/>';
	
	<!--	Strings para cambio de precio	-->
	var	strMotivo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='motivo']/node()"/>';
	var	strExplicacion	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='explicacion']/node()"/>';
	var	strCancelar	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>';
	var alrt_RequiereMotivoPrecio	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_requiere_motivo_precio']/node()"/>';
	var val_notZeroUnidades	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_no_cero_unidades']/node()"/>';	
	var val_faltaUnidades	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_unidades']/node()"/>';	
	var val_malEnteroUnidades	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_entero_unidades']/node()"/>';


	<!--	Strings para cambio de precio ref, cantidad, unidad basica	-->
	var val_malPrecioRef	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_precio_referencia2']/node()"/>';
	var val_malPrecioObj	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_precio_objetivo2']/node()"/>';
	var val_faltaUdBasica	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_unidad_basica2']/node()"/>';
	var val_faltaCantidad	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_cantidad2']/node()"/>';
	var val_ceroCantidad	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cero_cantidad2']/node()"/>';
	var val_malCantidad	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_cantidad2']/node()"/>';
	var alrt_ProdActualizadoOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='success_producto_actualizado']/node()"/>';
	var alrt_ProdActualizadoKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_producto_actualizado']/node()"/>';
	
	<!-- Alerts para tabla proveedores -->
	var alrt_mensajeEnviado		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='mensaje_enviado']/node()"/>';
	var alrt_AdjudicarProveedorKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_adjudicar_proveedor']/node()"/>';
	var alrt_SuspenderProveedorKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_suspender_proveedor']/node()"/>';
	var alrt_RollBackProveedorKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_rollback_proveedor']/node()"/>';
	var alrt_NuevoProveedorKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_nuevo_proveedor']/node()"/>';
	var alrt_EliminarProveedorKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_eliminar_proveedor']/node()"/>';
	var alrt_SubirContratoKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_subir_contrato']/node()"/>';
	var alrt_SubirContratoOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='success_subir_contrato']/node()"/>';
	var alrt_nuevoUsuarioProvOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='success_nuevo_usuario_proveedor']/node()"/>';
	var alrt_nuevoUsuarioProvKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_nuevo_usuario_proveedor']/node()"/>';
	<!-- Anyadir proveedores -->
	var val_faltaProveedor		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_proveedor']/node()"/>';
	var val_faltaUsuarioProv	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_usuario_proveedor']/node()"/>';
	var val_faltaMensaje		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_comentario_licitacion']/node()"/>';

	<!-- Avisos de error en Fechas-->
	var val_faltaFechaDecision	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_fecha_decision']/node()"/>';
	var val_malFechaDecision	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_fecha_decision']/node()"/>';
	var val_malFechaPedidoLic	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_fecha_pedido_lic']/node()"/>';
	var val_FechaDecisionAntigua= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision_antigua']/node()"/>';
	var val_FechaPedidoAntigua	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_pedido_antigua']/node()"/>';
	var val_faltaDescripcion	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_descripcion']/node()"/>';
	var val_malFechaAdjudic		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_fecha_adjudicacion']/node()"/>';
	var val_malFechaAdjudic2	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_adjudicacion_posterior_fecha_decision_obli']/node()"/>';

	<!-- Avisos matriz de ofertas	-->
	var alrt_guardarSeleccionAdjOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_selecc_adjudica_ok']/node()"/>';
	var alrt_guardarSeleccionAdjKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_selecc_adjudica_ko']/node()"/>';
	var alrt_guardarAdjudicacionOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_adjudica_ok']/node()"/>';
	var alrt_guardarAdjudicacionKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_adjudica_ko']/node()"/>';
	var alrt_pedidoMinimoKO		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_validar_pedido_minimo']/node()"/>';
	var alrt_pedidoMinimoGlobalKO= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_validar_pedido_minimo_agr']/node()"/>';

	<!-- Avisos matriz de cantidad por proveedor y centro	-->
	var alrt_CantidadNoCorresponde= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cantidad_no_corresponde']/node()"/>';
	var alrt_CantidadSupera		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cantidad_supera']/node()"/>';
	var alrt_CantidadNoCubre	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cantidad_no_cubre']/node()"/>';
	var alrt_faltaCantidad		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_cantidad']/node()"/>';
	var alrt_ceroCantidad		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cero_cantidad']/node()"/>';
	var alrt_malCantidad		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_cantidad']/node()"/>';
	
	<!-- Avisos incluir productos	-->
	var val_maxReferencias		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='num_max_referencias']/node()"/>';
	var val_faltaTipoIVA		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_tipoIVA']/node()"/>';
	

	var objLicitacion	= [];
	objLicitacion['Empresa'] = "<xsl:value-of select="/Mantenimiento/LICITACION/EMPRESALICITACION/NOMBRE"/>";
	objLicitacion['Codigo']	= "<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CODIGO"/>";
	objLicitacion['Titulo']	= "<xsl:value-of select="/Mantenimiento/LICITACION/LIC_TITULO"/>";
	objLicitacion['ConsHist']	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CONSUMOHISTORICO"/>';
	objLicitacion['ConsHistIVA']	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CONSUMOHISTORICOIVA"/>';
	objLicitacion['Consumo']	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CONSUMO"/>';
	objLicitacion['ConsumoIVA']	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CONSUMOIVA"/>';
	<!--	2ene20	objLicitacion['ConsumoAdj']	= '<xsl:value-of select="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/TOTAL_ADJUDICADO"/>';	-->
	objLicitacion['ConsumoAdj']	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CONSUMOADJUDICADO"/>';
	<!--	2ene20	objLicitacion['ConsumoAdjIVA']	= '<xsl:value-of select="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/TOTAL_ADJUDICADOIVA"/>';	-->
	objLicitacion['Ahorro']		= '<xsl:value-of select="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/AHORRO"/>';
	objLicitacion['AhorroAdj']		= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_AHORROADJUDICADO"/>';
	objLicitacion['NumProductos']	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_NUMEROLINEAS"/>';
	objLicitacion['NumProductosAdj']	= '<xsl:value-of select="/Mantenimiento/LICITACION/PRODUCTOSADJUDICADOS"/>';		//	2ene20
	objLicitacion['PorcConsNeg']	= '<xsl:value-of select="/Mantenimiento/LICITACION/PORCCONSUMONEGOCIADO"/>';
	objLicitacion['AhorMejPrecio']	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_AHORROCONMEJORPRECIO"/>';
	objLicitacion['NumSinOferta']	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_PRODUCTOSSINOFERTA"/>';
	objLicitacion['NumSinAhorro']	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_PRODUCTOSSINAHORRO"/>';


	<!--	CUIDADO! Este array solo deberia cargarse para CLIENTES	-->
	var arrProveedores	= new Array();
	<xsl:if test="count(/Mantenimiento/LICITACION/PROVEEDORESLICITACION/PROVEEDOR) &gt; 0">
	<xsl:for-each select="/Mantenimiento/LICITACION/PROVEEDORESLICITACION/PROVEEDOR">
		var items		= [];
		items['linea']		= '<xsl:value-of select="ORDEN"/>';
		items['IDProvLic']	= '<xsl:value-of select="IDPROVEEDOR_LIC"/>';
		items['IDProveedor']	= '<xsl:value-of select="IDPROVEEDOR"/>';
		items['Nombre']		= '<xsl:value-of select="NOMBRE"/>';
		items['NombreCorto']	= '<xsl:value-of select="NOMBRECORTO"/>';
		items['FechaAlta']	= '<xsl:value-of select="LIC_PROV_FECHAALTA"/>';
		items['FechaOferta']	= '<xsl:value-of select="LIC_PROV_FECHAOFERTA"/>';
		items['IDEstadoProv']	= '<xsl:value-of select="LIC_PROV_IDESTADO"/>';
		items['EstadoProv']	= '<xsl:value-of select="ESTADOLICITACION"/>';
		items['CommsProv']	= '<xsl:copy-of select="LIC_PROV_COMENTARIOSPROV_JS/node()"/>';
		items['CommsCdC']	= '<xsl:copy-of select="LIC_PROV_COMENTARIOSCDC_JS/node()"/>';
		items['IDEstadoEval']	= '<xsl:value-of select="LIC_PROV_IDESTADOEVALUACION"/>';
		items['EstadoEval']	= '<xsl:value-of select="ESTADOEVALUACION"/>';
		items['PedidoMin']	= '<xsl:value-of select="LIC_PROV_PEDIDOMINIMO"/>';
		items['ConsumoProv']	= '<xsl:value-of select="LIC_PROV_CONSUMO"/>';
		items['ConsumoProvIVA']	= '<xsl:value-of select="LIC_PROV_CONSUMOIVA"/>';
		items['Ahorro']		= '<xsl:value-of select="LIC_PROV_AHORRO"/>';
		items['OfertasVacias']	= '<xsl:value-of select="LIC_PROV_OFERTASVACIAS"/>';
		items['ConsumoPot']	= '<xsl:value-of select="LIC_PROV_CONSUMOPOTENCIAL"/>';
		items['ConsumoPotIVA']	= '<xsl:value-of select="LIC_PROV_CONSUMOPOTENCIALIVA"/>';
		items['ConsumoAdj']	= '<xsl:value-of select="LIC_PROV_CONSUMOADJUDICADO"/>';
		items['ConsumoAdjIVA']	= '<xsl:value-of select="LIC_PROV_CONSUMOADJUDICADOIVA"/>';
		items['AhorroIVA']	= '<xsl:value-of select="LIC_PROV_AHORROIVA"/>';
		items['NumeroLineas']	= '<xsl:value-of select="LIC_PROV_NUMEROLINEAS"/>';
		items['NivelDocumentacion']	= '<xsl:value-of select="EMP_NIVELDOCUMENTACION"/>';

		items['Frete']	= '<xsl:value-of select="LIC_PROV_FRETE"/>';
		items['PlazoEntrega']	= '<xsl:value-of select="LIC_PROV_PLAZOENTREGA"/>';

		items['OfeConAhorro']	= '<xsl:value-of select="LIC_PROV_OFERTASCONAHORRO"/>';
		items['OfeMejPrecio']	= '<xsl:value-of select="LIC_PROV_OFERTASCONMEJORPRECIO"/>';
		items['ConsMejPrecio']	= '<xsl:value-of select="LIC_PROV_CONSUMOCONMEJORPRECIO"/>';
		items['ConsMejPrecIVA']	= '<xsl:value-of select="LIC_PROV_CONSCONMEJORPRECIOIVA"/>';
		items['AhorMejPrecio']	= '<xsl:value-of select="LIC_PROV_AHORROENMEJORPRECIO"/>';
		items['ConsConAhorro']	= '<xsl:value-of select="LIC_PROV_CONSUMOCONAHORRO"/>';
		items['ConsConAhorIVA']	= '<xsl:value-of select="LIC_PROV_CONSUMOCONAHORROIVA"/>';
		items['AhorOfeConAhor']	= '<xsl:value-of select="LIC_PROV_AHORROOFECONAHORRO"/>';
		items['OfertasAdj']	= '<xsl:value-of select="LIC_PROV_OFERTASADJUDICADAS"/>';

		items['IDUsuarioProv']	= '<xsl:value-of select="USUARIO/ID"/>';
		items['NombreUsuario']	= '<xsl:value-of select="USUARIO/NOMBRE"/>';

		items['HayConversa']	= '<xsl:choose><xsl:when test="CONVERSACION">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		items['UltMensaje']	= '<xsl:value-of select="CONVERSACION/ULTIMOMENSAJE"/>';
		items['TieneOfertas']	= '<xsl:choose><xsl:when test="TIENE_OFERTAS">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';	//	14set16
		items['Estrellas']	= '<xsl:value-of select="ESTRELLAS"/>';	//	27set17
		items['BloqPedidos']	= '<xsl:choose><xsl:when test="PROVEEDOR_BLOQUEADO_POR_PEDIDOS">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';

		items['IDDocumento'] = '<xsl:value-of select="LIC_PROV_IDDOCUMENTO"/>';

		items['Contrato'] = [];
		<xsl:if test="CONTRATO/ID">
			items['Contrato']['ID']		= '<xsl:value-of select="CONTRATO/ID"/>';
			items['Contrato']['Nombre']	= '<xsl:value-of select="CONTRATO/NOMBRE"/>';
			items['Contrato']['Descripcion']	= '<xsl:value-of select="CONTRATO/DESCRIPCION"/>';
			items['Contrato']['Url']		= '<xsl:value-of select="CONTRATO/URL"/>';
			items['Contrato']['Fecha']	= '<xsl:value-of select="CONTRATO/FECHA"/>';
		</xsl:if>
		arrProveedores.push(items);
	</xsl:for-each>
	</xsl:if>

	
	var arrProductos	= new Array();
	<xsl:choose>
	<xsl:when test="count(/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PRODUCTO) &gt; 0 and /Mantenimiento/LICITACION/ROL = 'COMPRADOR'">
	<!--

		COMPRADOR

	-->
	var arrConsumoProvs	= new Array();
	var NumProvsOfertas	= '<xsl:value-of select="count(/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PROVEEDORESLICITACION/PROVEEDOR)"/>';
	var productosOlvidados	= '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PRODUCTOS_OLVIDADOS">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
	var numProdsSeleccion	= '<xsl:value-of select="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/TOTAL_SELECCIONADAS"/>';
	var numProveedoresActivos	= <xsl:value-of select="/Mantenimiento/LICITACION/PROVEEDORESLICITACION/TOTALACTIVOS"/>;

	//	tabla proveedores
	var		totalProvs,			// numero total de proveedores en la licitacion
			ColumnaOrdenacionProvs='',			//	12nov19	Por defecto ordenamos por nombre corto del proveedor, antes nombrenorm
			OrdenProvs		= '',
			ColumnaOrdenadaProvs	= [],
			NumColsMatriz=0;
			

	var ColMatriz=0;
	<xsl:for-each select="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PROVEEDORESLICITACION/PROVEEDOR">
		var items		= [];
		items['Orden']	= '<xsl:value-of select="COLUMNA"/>';
		items['IDProvLic']	= '<xsl:value-of select="IDPROVEEDOR_LIC"/>';
		items['ID']	= '<xsl:value-of select="IDPROVEEDOR"/>';
		items['PedidoMin']	= '<xsl:value-of select="LIC_PROV_PEDIDOMINIMO"/>';
		items['NombreCorto']	= '<xsl:value-of select="NOMBRECORTO"/>';
		items['TieneOfertas']	= '<xsl:choose><xsl:when test="TIENE_OFERTAS">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';

		items['Consumo']	= '<xsl:value-of select="LIC_PROV_CONSUMO"/>';
		items['ConsumoPot']	= '<xsl:value-of select="LIC_PROV_CONSUMOPOTENCIAL"/>';
		items['Ahorro']		= '<xsl:value-of select="LIC_PROV_AHORRO"/>';
		items['ConsumoAdj']	= '<xsl:value-of select="LIC_PROV_CONSUMOADJUDICADO"/>';
		items['ConsumoAdj_Float']= desformateaDivisa('<xsl:value-of select="LIC_PROV_CONSUMOADJUDICADO"/>');

		items['OfertasAdj']	= '<xsl:value-of select="LIC_PROV_OFERTASADJUDICADAS"/>';
		items['CumplePedMinimo']	= 'S';
		
		items['ColMatriz']	= 0;

		arrConsumoProvs.push(items);
		
		//	5jul22
		if (items['TieneOfertas']== 'S')
		{
			items['ColMatriz']	= ColMatriz;
			ColMatriz++;
		}
	</xsl:for-each>

	<!--totAdjudicados=0;-->
	<xsl:for-each select="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PRODUCTO">
		var items = [];
		items['Linea']		= '<xsl:value-of select="LINEA"/>';
		items['IDProdLic']	= '<xsl:value-of select="LIC_PROD_ID"/>';
		items['ID']	= '<xsl:value-of select="LIC_PROD_IDPRODESTANDAR"/>';
		items['RefEstandar']	= '<xsl:value-of select="LIC_PROD_REFESTANDAR"/>';
		items['RefCliente']	= '<xsl:value-of select="LIC_PROD_REFCLIENTE"/>';
		items['RefCentro']	= '<xsl:value-of select="REFCENTRO"/>';
		items['Nombre']		= "<xsl:value-of select="LIC_PROD_NOMBRE"/>";		//	28set21 utilizamos comilla doble, dentro puede venir comilla simple
		items['NombreNorm']	= '<xsl:value-of select="PROD_NOMBRENORM"/>';
		items['UdBasica']	= '<xsl:value-of select="LIC_PROD_UNIDADBASICA"/>';
		items['FechaAlta']	= '<xsl:value-of select="LIC_PROD_FECHAALTA"/>';
		items['FechaMod']	= '<xsl:value-of select="LIC_PROD_FECHAMODIFICACION"/>';
		items['Consumo']	= '<xsl:value-of select="LIC_PROD_CONSUMO"/>';
		items['ConsumoIVA']	= '<xsl:value-of select="LIC_PROD_CONSUMOIVA"/>';
		items['ConsumoHist']	= '<xsl:value-of select="LIC_PROD_CONSUMOHISTORICO"/>';
		items['ConsumoHistIVA']	= '<xsl:value-of select="LIC_PROD_CONSUMOHISTORICOIVA"/>';
		items['Cantidad']	= '<xsl:value-of select="LIC_PROD_CANTIDAD"/>';
		items['PrecioObj']	= '<xsl:value-of select="LIC_PROD_PRECIOOBJETIVO"/>';
		items['PrecioObjIVA']	= '<xsl:value-of select="LIC_PROD_PRECIOOBJETIVOIVA"/>';
		items['PrecioHist']	= '<xsl:value-of select="LIC_PROD_PRECIOREFERENCIA"/>';
		items['PrecioHistIVA']	= '<xsl:value-of select="LIC_PROD_PRECIOREFERENCIAIVA"/>';
		items['TipoIVA']	= '<xsl:value-of select="LIC_PROD_TIPOIVA"/>';
		items['NumOfertas']	= 0; 	//30set16	Calcularemos al cargar proveedores. Antes: select="NUMERO_OFERTAS"
		<!--items['TieneSeleccion']	= '<xsl:value-of select="TIENE_SELECCION"/>';-->
		items['Validado']	= '<xsl:choose><xsl:when test="VALIDADO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		items['NoAdjudicado']	= '<xsl:choose><xsl:when test="NO_ADJUDICADO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		items['Ordenacion']	= '0';
		items['ColSeleccionada']	= '-1';
		items['VariosProv']	= 'N';
		items['BloqPedidos']	= '<xsl:choose><xsl:when test="PRODUCTO_BLOQUEADO_POR_PEDIDOS">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		items['Marcas']= '<xsl:value-of select="LIC_PROD_MARCASACEPTABLES"/>';
		items['PrincActivo']= '<xsl:value-of select="LIC_PROD_PRINCIPIOACTIVO"/>';
		items['IDMotivoSel']= '<xsl:value-of select="LIC_PROD_IDMOTIVOSELECCION"/>';
		items['MotivoSel']= '<xsl:value-of select="LIC_PROD_MOTIVOSELECCION"/>';
		

		<!-- Campos Avanzados -->
		items['Anotaciones']	= "<xsl:copy-of select="LIC_PROD_ANOTACIONES_JS/node()"/>";
		items['InfoAmpliada']	= "<xsl:copy-of select="LIC_PROD_INFOAMPLIADA_JS/node()"/>";
		items['Documento']	= [];
		<xsl:if test="DOCUMENTO">
			items['Documento']['ID']		= '<xsl:value-of select="DOCUMENTO/ID"/>';
			items['Documento']['Nombre']		= '<xsl:value-of select="DOCUMENTO/NOMBRE"/>';
			items['Documento']['Descripcion']	= '<xsl:value-of select="DOCUMENTO/DESCRIPCION"/>';
			items['Documento']['Url']		= '<xsl:value-of select="DOCUMENTO/URL"/>';
			items['Documento']['Fecha']		= '<xsl:value-of select="DOCUMENTO/FECHA"/>';
		</xsl:if>
		<!-- FIN Campos Avanzados -->

		<!--	La info de centros esta a nivel de COMPRAPORCENTRO
		items['Centros']= [];
		var DatosCentros	= [];
		<xsl:if test="CENTRO">
			var Centro	= [];
			<xsl:for-each select="CENTRO">
			Centro['IDCentro']		= '<xsl:value-of select="IDCENTRO"/>';
			Centro['RefCentro']		= '<xsl:value-of select="REFCENTRO"/>';
			Centro['Centro']		= '<xsl:value-of select="CEN_ID"/>';
			Centro['Cantidad']		= '<xsl:value-of select="LIC_CC_CANTIDAD"/>';
			Centro['CantidadSF']	= <xsl:value-of select="CANTIDAD_SINFORMATO"/>;
			DatosCentros.push(Centro);
			</xsl:for-each>
			items[Centros].push(DatosCentros);
		</xsl:if>
		-->


		items['Sospechoso']	= '<xsl:choose><xsl:when test="MUY_SOSPECHOSO">2</xsl:when><xsl:when test="SOSPECHOSO">1</xsl:when><xsl:otherwise>0</xsl:otherwise></xsl:choose>';

		items['AhorroMax']	= '<xsl:value-of select="AHORRO_MAX"/>';
		items['SinAhorro']	= '<xsl:choose><xsl:when test="AVISO_SIN_AHORRO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';

		<!--	14set16	No añadimos aquí las ofertas, lo haremos posteriormente vía ajax. Inicializamos las ofertas en blanco		-->
		items['Ofertas'] = new Array();
		items['OfertasBack'] = new Array();		//	Copia de seguridad, antes de los cambios, para recalcular totales
		items['OfCargadas'] = 'N';

		items['CompraMedia']=[];
		items['UltCompra']=[];

		items['curvaABC']='';

		items['PrecioOfertaActual']='';			//sustituye a gl_PrecioOfertaActual
		items['MejorPrecio']='';				//sustituye a gl_MejorPrecio
		items['CantidadPendiente']=parseInt('<xsl:value-of select="LIC_PROD_CANTIDAD"/>');			//evita el recalculo de la CantidadPendiente
		items['Seleccionadas']=0;				//ofertas seleccionadas
		items['Cambios']='N';					//cambios pendientes de guardar
		items['CumpleFiltro']='S';				//cumple el filtro de busqueda
		items['Ahorro']='0';					//16jun22 ahorro seleccionado o maximo
				
		arrProductos.push(items);
		
		<!--if (items['TieneSeleccion']	=='S')	++totAdjudicados;-->
	</xsl:for-each>
	</xsl:when>
	<!--	2set21 sin estas declaraciones se produce un error	-->
	<!--	COMPRADOR SIN PRODUCTOS	-->
	<xsl:when test="count(/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PRODUCTO)= 0 and /Mantenimiento/LICITACION/ROL = 'COMPRADOR'">
		var numProdsSeleccion	= 0
		var arrConsumoProvs	= new Array();
	</xsl:when>
	</xsl:choose>
	
	var arrMotivos	= new Array();
	<xsl:for-each select="/Mantenimiento/LICITACION/IDMOTIVOSELECCION/field/dropDownList/listElem">
		motivo=[];
		motivo['ID']	= '<xsl:value-of select="ID"/>';
		motivo['Texto']	= '<xsl:value-of select="listItem"/>';
		arrMotivos.push(motivo);
	</xsl:for-each>

	
	var arrMotivosPrecio	= new Array();
	<xsl:for-each select="/Mantenimiento/LICITACION/IDMOTIVOCAMBIOPRECIO/field/dropDownList/listElem">
		motivo=[];
		motivo['ID']	= '<xsl:value-of select="ID"/>';
		motivo['Texto']	= '<xsl:value-of select="listItem"/>';
		arrMotivosPrecio.push(motivo);
	</xsl:for-each>

	//	11jul22 Incluimos el array de centros
	var arrCentros	= new Array();
	<xsl:if test="/Mantenimiento/LICITACION/LICITACION_AGREGADA">
		<xsl:if test="/Mantenimiento/LICITACION/CENTROSLICITACION/CENTRO">
			var Centro	= [];
			<xsl:for-each select="CENTRO">
			Centro['LICC_ID']		= '<xsl:value-of select="LICC_ID"/>';
			Centro['IDCentro']		= '<xsl:value-of select="CEN_ID"/>';
			Centro['Centro']		= '<xsl:value-of select="NOMBRECORTO"/>';
			Centro['RefPropias']	= '<xsl:value-of select="REFERENCIASPROPIAS"/>';
			Centro['Estado']		= '<xsl:value-of select="ESTADOCOMPRA"/>';
			arrCentros.push.push(Centro);
			</xsl:for-each>
		</xsl:if>
	</xsl:if>

	//	11jul22 Incluimos el array de compra por centro y proveedor
	var arrProductosPorCentro	= new Array();
	<xsl:if test="/Mantenimiento/LICITACION/LICITACION_AGREGADA">
		<xsl:for-each select="/Mantenimiento/LICITACION/COMPRAPORCENTRO/PRODUCTO">
			var items		= [];
			items['linea']		= '<xsl:value-of select="LINEA"/>';
			items['IDProdLic']	= '<xsl:value-of select="LIC_PROD_ID"/>';
			items['IDProd']		= '<xsl:value-of select="LIC_PROD_IDPRODESTANDAR"/>';
			items['RefEstandar']= '<xsl:value-of select="LIC_PROD_REFESTANDAR"/>';
			items['RefCliente']	= '<xsl:value-of select="LIC_PROD_REFCLIENTE"/>';
			items['UdBasica']	= '<xsl:value-of select="LIC_PROD_UNIDADBASICA"/>';
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/COMPRAPORCENTRO/IDCENTRO != ''">
				items['Cantidad']	= '<xsl:value-of select="CENTRO/CANTIDAD_SINFORMATO"/>';
				items['RefCentro']	= '<xsl:value-of select="CENTRO/REFCENTRO"/>';
			</xsl:when>
			<xsl:otherwise>
				items['Centros']	= new Array();
				<xsl:for-each select="CENTRO">
					var centro	= [];
					centro['linea']= '<xsl:value-of select="CONTADOR"/>'
					centro['IDCentro']	= '<xsl:value-of select="CEN_ID"/>';
					centro['Centro']= '<xsl:value-of select="NOMBRE"/>';
					centro['Marcas']= '<xsl:value-of select="LIC_CC_MARCASACEPTABLES"/>';
					centro['Cantidad']= '<xsl:value-of select="LIC_CC_CANTIDAD"/>';
					centro['CantidadSF']= <xsl:value-of select="CANTIDAD_SINFORMATO"/>;
					centro['RefCentro']	= '<xsl:value-of select="REFCENTRO"/>';
					centro['Proveedores']	= [];
					<xsl:if test="PROVEEDORES/PROVEEDOR">
						<xsl:for-each select="PROVEEDORES/PROVEEDOR">
							var Proveedor	= [];
							Proveedor['IDOfertaLic']	= '<xsl:value-of select="LIC_OFE_ID"/>';
							Proveedor['IDProvLic']	= '<xsl:value-of select="LIC_PROV_ID"/>';
							Proveedor['IDProveedor']	= '<xsl:value-of select="IDPROVEEDOR"/>';
							Proveedor['Proveedor']= '<xsl:value-of select="PROVEEDOR"/>';
							Proveedor['UdesLote']	= <xsl:value-of select="LIC_OFE_UNIDADESPORLOTE"/>;
							Proveedor['Cantidad']	= '<xsl:value-of select="CANTIDAD"/>';
							Proveedor['CantidadSF']	= <xsl:value-of select="CANTIDAD_SINFORMATO"/>;
							Proveedor['CantidadTotal']	=0;												//	5may21 Lo informaremos al revisar totales por centro
							centro['Proveedores'].push(Proveedor);
						</xsl:for-each>
					</xsl:if>
					items['Centros'].push(centro);
				</xsl:for-each>
			</xsl:otherwise>
			</xsl:choose>
			arrProductosPorCentro.push(items);
		</xsl:for-each>
	</xsl:if>

<!--	
	
	//	Cadenas para el CSV
	var strTitulo='<xsl:value-of select="/Mantenimiento/LICITACION/LIC_TITULO"/>';

	var strFechaInforme='<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_informe']/node()"/>';
	var FechaInforme='<xsl:value-of select="/Mantenimiento/LICITACION/FECHAACTUAL"/>';

	var strFechaDecision='<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/>';
	var FechaDecision='<xsl:value-of select="/Mantenimiento/LICITACION/LIC_FECHADECISIONPREVISTA"/>';

	var strDescripcion='<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>';
	var Descripcion='<xsl:value-of select="/Mantenimiento/LICITACION/LIC_DESCRIPCION"/>';
	
	var strCondEntrega='<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_entrega']/node()"/>';
	var CondEntrega='<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CONDICIONESENTREGA"/>';
	
	var strCondPago='<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_pago']/node()"/>';
	var CondPago='<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CONDICIONESPAGO"/>';
	
	var strCondOtras='<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_otras']/node()"/>';
	var CondOtras='<xsl:value-of select="/Mantenimiento/LICITACION/LIC_OTRASCONDICIONES"/>';
	
	var strMesesDuracion='<xsl:value-of select="document($doc)/translation/texts/item[@name='meses_duracion']/node()"/>';
	var MesesDuracion=<xsl:value-of select="/Mantenimiento/LICITACION/LIC_MESESDURACION"/>;
	
	var chkTotal='<xsl:value-of select="/Mantenimiento/LICITACION/TOTAL_ALAVISTA"/>';
	
	var strTotalALaVista='<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_alavista']/node()"/>';
	var TotalALaVista='<xsl:value-of select="/Mantenimiento/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/Mantenimiento/LICITACION/TOTAL_ALAVISTA"/><xsl:value-of select="/Mantenimiento/LICITACION/DIVISA/SUFIJO"/>';
	
	var strTotalAplazado='<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_aplazado']/node()"/>';
	var TotalAplazado='<xsl:value-of select="/Mantenimiento/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/Mantenimiento/LICITACION/TOTAL_APLAZADO"/><xsl:value-of select="/Mantenimiento/LICITACION/DIVISA/SUFIJO"/>';

	var chkTotalPedidos='<xsl:value-of select="/Mantenimiento/LICITACION/TOTAL_PEDIDOS"/>';

	var strTotalPedidos='<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_pedidos']/node()"/>';
	var TotalPedidos='<xsl:value-of select="/Mantenimiento/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/Mantenimiento/LICITACION/TOTAL_PEDIDOS"/><xsl:value-of select="/Mantenimiento/LICITACION/DIVISA/SUFIJO"/>';
	
	var strTotalAdjudicado='<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_adjudicado']/node()"/>';
	var TotalAdjudicado='<xsl:value-of select="/Mantenimiento/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/Mantenimiento/LICITACION/LIC_CONSUMOADJUDICADO"/><xsl:value-of select="/Mantenimiento/LICITACION/DIVISA/SUFIJO"/>';
	
	var strProductos='<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>';
	var Productos='<xsl:value-of select="/Mantenimiento/LICITACION/PRODUCTOSADJUDICADOS"/>/<xsl:value-of select="/Mantenimiento/LICITACION/LIC_NUMEROLINEAS"/>';

	var strProveedores='<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>';
	var Proveedores='<xsl:value-of select="/Mantenimiento/LICITACION/LIC_PROVEEDORESADJUDICADOS"/>/<xsl:value-of select="/Mantenimiento/LICITACION/LIC_NUMEROPROVEEDORES"/>';
	
	var strAhorroPorc='<xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro']/node()"/> (%)';
	var AhorroPorc='<xsl:value-of select="/Mantenimiento/LICITACION/LIC_AHORROADJUDICADO"/>%';
	
	var strAhorro='<xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro']/node()"/>';
	var Ahorro='<xsl:value-of select="/Mantenimiento/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/Mantenimiento/LICITACION/LIC_AHORROADJUDICADO_TOT"/><xsl:value-of select="/Mantenimiento/LICITACION/DIVISA/SUFIJO"/>';

	var strProveedor='<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>';
	var strCabeceraExcel='<xsl:value-of select="document($doc)/translation/texts/item[@name='Cabecera_CSV_vencedores']/node()"/>';


	var strPedidoMinimo='<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/>';
	var strPlazoPago='<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_pago']/node()"/>';
	var strFormaPago='<xsl:value-of select="document($doc)/translation/texts/item[@name='forma_pago']/node()"/>';
	var strPlazoEntrega='<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/>';
	var strFrete='<xsl:value-of select="document($doc)/translation/texts/item[@name='frete']/node()"/>';
-->
	var strAhorro='<xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro']/node()"/>';
	var strOfertas='<xsl:value-of select="document($doc)/translation/texts/item[@name='ofertas']/node()"/>';

	</script>

	<!--	una vez creadas las variables y cargados los arrays, podemos cargar los paquetes JS	-->
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/LicitacionV2_2022_070922.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/LicV2Provs_2022_100822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/LicV2Prods_2022_220822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/LicV2Centros_2022_100722.js"></script>

</head>
<body onload="javascript:onLoad();">
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

	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

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
		<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<div class="divLeft">

	<!--	Titulo de la página		-->
	<div class="cabecalho_cotacao">
		<div class="cabecalho_cotacao_linha_1">
			<p><xsl:if test="/Mantenimiento/LICITACION/LIC_URGENTE = 'S'"><span class="urgente"><xsl:value-of select="document($doc)/translation/texts/item[@name='urgente']/node()"/></span>&nbsp;</xsl:if>
			<xsl:value-of select="/Mantenimiento/LICITACION/TITULO"/>
			<span class="CompletarTitulo500">

				<!--	Botón para pasar a informar cantidades de compra	-->
				<xsl:if test="/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_IDESTADO = 'EST' and /Mantenimiento/LICITACION/INFORMAR_COMPRAS">
					<a class="btnDestacado" id="botonInformarCompras" href="javascript:NoInformacionCompras();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='informar_compras']/node()"/>
					</a>
					&nbsp;
				</xsl:if>
				<!-- Botones para COMPLETAR LICITACION-->
				<xsl:if test="/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_IDESTADO = 'COMP' and /Mantenimiento/LICITACION/COMPLETAR_COMPRA_CENTRO">					
					<!--	Botón de publicación de datos de compra	-->
					<a class="btnDestacado" id="botonPublicarCompra" href="javascript:PublicarDatosCompra();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='publicar_datos_compra']/node()"/>
					</a>
					&nbsp;
				</xsl:if>

				<!-- Botones ESTUDIO PREVIO o COMPLETAR LICITACION-->
				<xsl:if test="/Mantenimiento/LICITACION/AUTOR and (/Mantenimiento/LICITACION/LIC_IDESTADO = 'EST' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'COMP')">
					<!--	Botón de publicación de inicio de la liciatción	-->
					<xsl:if test="/Mantenimiento/LICITACION/INICIAR_LICITACION">
						<a id="botonIniciarLici" href="javascript:IniciarLicitacion('CURS');">
						<xsl:attribute name="class">
						<xsl:choose>
						<xsl:when test="/Mantenimiento/LICITACION/LIC_NUMEROLINEAS='' or /Mantenimiento/LICITACION/LIC_NUMEROLINEAS=0">btnGris</xsl:when>
						<xsl:otherwise>btnDestacado</xsl:otherwise>
						</xsl:choose>							
						</xsl:attribute>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='iniciar_licitacion']/node()"/>
						</a>
						&nbsp;
					</xsl:if>
					<!--	Botón de publicación de inicio de la licitación	-->
					<xsl:if test="/Mantenimiento/LICITACION/ENVIAR_GESTOR">
						<a id="botonIniciarLici" href="javascript:EnviarGestor();">
						<xsl:attribute name="class">
						<xsl:choose>
						<xsl:when test="/Mantenimiento/LICITACION/LIC_NUMEROLINEAS='' or /Mantenimiento/LICITACION/LIC_NUMEROLINEAS=0">btnGris</xsl:when>
						<xsl:otherwise>btnDestacado</xsl:otherwise>
						</xsl:choose>							
						</xsl:attribute>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_gestor']/node()"/>
						</a>
						&nbsp;
					</xsl:if>					
				</xsl:if>					
				<!-- Botones para ESTUDIO PREVIO-->
				<xsl:if test="/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_IDESTADO = 'EST'">
					<!--	Botón para agregar otra licitación en estado EST a esta	-->
					<xsl:if test="/Mantenimiento/LICITACION/AGREGAR_LICITACION">
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="/Mantenimiento/LICITACION/LICITACIONES_EST/field"/>
							<xsl:with-param name="claSel">w200px</xsl:with-param>
						</xsl:call-template>
						&nbsp;
						<a class="btnDestacado" id="botonAgregarLici" href="javascript:AgregarLicitacion();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='agregar_licitacion']/node()"/>
						</a>
						&nbsp;
					</xsl:if>
				</xsl:if>			

				<!-- 15jun22 Boton Licitacion	
				<a id="btnLic" class="btnNormal" href="javascript:chFichaLicitacion({/Mantenimiento/LICITACION/LIC_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion']/node()"/></a>
				&nbsp;
				<!- - Boton Vencedores	- ->
				<a id="btnVencedores" class="btnNormal" href="javascript:chVencedores({/Mantenimiento/LICITACION/LIC_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='Vencedores']/node()"/></a>
				-->
				<!--
					<a class="btnNormal" href="javascript:DescargarVencedores();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='boton_descargarVencedores']/node()"/>
                   	</a>&nbsp;-->
				<!--	Botones para adjudicar la liciatcion	-->
				<xsl:if test="/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_PORPRODUCTO = 'S' and (/Mantenimiento/LICITACION/LIC_IDESTADO = 'INF' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'CURS')"><!-- and not BLOQUEARADJUDICACION-->
					<xsl:choose>
					<xsl:when test="/Mantenimiento/LICITACION/LIC_MULTIOPCION='S'">
						<a class="btnDestacado" id="botonAdjudicarSelec" href="javascript:AdjudicarOfertasMultiples();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicar']/node()"/>
						</a>
						<span id="idAvanceAdjudicar" style="display:none;" class="clear">0/0</span>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
						<xsl:when test="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PRODUCTOS_OLVIDADOS">
							<a class="btnDeshabilitado" id="botonAdjudicarSelec" href="javascript:AdjudicarOfertas();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicar']/node()"/></a>
						</xsl:when>
						<xsl:when test="/Mantenimiento/LICITACION/LIC_MESESDURACION>0">
							<a class="btnDestacado" id="botonAdjudicarSelec" href="javascript:AdjudicarOfertas();"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicar']/node()"/></a>
							<span id="waitBotonAdjudicar" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></span>
							<span id="txtPrepPedido">&nbsp;</span>
						</xsl:when>
						<!--
						<xsl:when test="/Mantenimiento/LICITACION/LIC_PEDIDOSPENDIENTES>0">
							<a class="btnDestacado" id="botonAdjudicarSelec" href="javascript:PreparaLanzarTodosPedidos();"><xsl:value-of select="document($doc)/translation/texts/item[@name='boton_generar_pedido']/node()"/></a>
							<span id="waitBotonAdjudicar" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></span>
							<span id="txtPrepPedido">&nbsp;</span>
						</xsl:when>
						-->
						<xsl:otherwise>
							<!--14feb20 NO mostramos el botón de adjudicar si es licitacion SPOTy no hay pedidos pendientes-->
						</xsl:otherwise>
						</xsl:choose>								
						<span id="waitBotonAdjudicar" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></span>
					</xsl:otherwise>
					</xsl:choose>	
					<!--	11mar20	Botón contrato	-->
					<xsl:if test="/Mantenimiento/LICITACION/BOTON_CONTRATO">
					&nbsp;
						<a class="btnDestacado" id="botonEstContrato" href="javascript:PasarAEstadoContrato();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar_lic']/node()"/>
						</a>
					</xsl:if>
					&nbsp;
				</xsl:if>
			
				
				<!--	Botones para licitaciones en estado CONT	-->
				<xsl:choose>
				<!-- cuando lici esta caducada, boton para Vencedores: mostramos igualmente el carrito-->
				<!--<xsl:when test="(/Mantenimiento/LICITACION/LIC_IDESTADO = 'CAD' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'CONT')">
					<a class="btnNormal" id="botonVencedores" href="javascript:chVencedores({/Mantenimiento/LICITACION/LIC_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='Vencedores']/node()"/></a>
					&nbsp;
				</xsl:when>-->
				<!-- cuando lici esta contratada, boton para el usuario autor para informar en catalogo proveedor -->
				<xsl:when test="/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/BOTON_CATALOGO_PROVEEDOR">
					<a class="btnDestacado" id="botonInsCatProv" href="javascript:ComprobarCatalogoProveedor();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='boton_insertar_catalogo_proveedor']/node()"/>
					</a>
					<span id="waitBotonInsCatProv" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></span>
						<a class="btnDestacado" id="botonInsEnPlant" href="javascript:ComprobarYAdjudicarCatalogoCliente({/Mantenimiento/LICITACION/LIC_ID});">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='boton_insertar_en_plantillas']/node()"/>
						</a>
					<span id="waitBotonInsEnPlant" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></span>
					&nbsp;
				</xsl:when>
				<!-- cuando lici esta contratada, y es AUTOR  boton para el usuario autor para incluir en plantillas -->
				<xsl:when test="/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/BOTON_CATALOGO_PRIVADO">
					<a class="btnDestacado" id="botonInsEnPlant" href="javascript:ComprobarYAdjudicarCatalogoCliente({/Mantenimiento/LICITACION/LIC_ID});">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='boton_insertar_en_plantillas']/node()"/>
					</a>
					<span id="waitBotonInsEnPlant" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></span>
					&nbsp;
				</xsl:when>
				<!-- cuando lici esta caducada, y es AUTOR boton para el autor para renovarla y para vencedores-->
				<xsl:when test="/Mantenimiento/LICITACION/AUTOR and (/Mantenimiento/LICITACION/LIC_IDESTADO = 'CAD' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'CONT')">
					<a class="btnDestacado" id="botonRenovarLic" href="javascript:RenovarLicitacion();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='boton_renovar_licitacion']/node()"/>
					</a>
					&nbsp;
				</xsl:when>
				</xsl:choose>

				<xsl:if test="/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/BOTON_PEDIDO">
					<a class="btnDestacado" id="botonGenerarPedido" href="javascript:GenerarPedido();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='boton_generar_pedido']/node()"/>
                    </a>
					<span id="waitBotonGenPedido" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></span>
					&nbsp;
				</xsl:if>
				<xsl:if test="/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/BOTON_LICITACIONPRODUCTOSSINOFERTA">

					<a class="btnDestacado" id="botonLicitacionHija" href="javascript:CrearLicitacionHija();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='boton_licitar_productos_no_adjudicados']/node()"/>
                    </a>
					<span id="waitBotonLicHija" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></span>
					&nbsp;
				</xsl:if>

				<xsl:if test="/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/BOTON_CONTINUARLICITACION">

					<a class="btnDestacado" id="botonContinuarLicitacion" href="javascript:ContinuarLicitacion();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='boton_continuar_licitacion']/node()"/>
                    </a>
					<span id="waitBotonContLic" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></span>
					&nbsp;
				</xsl:if>

				<!-- Botones para licitaciones ACTIVAS-->
				<xsl:if test="/Mantenimiento/LICITACION/AUTOR and (/Mantenimiento/LICITACION/LIC_IDESTADO = 'INF' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'CURS')">
					<a href="javascript:MejoresPrecios();" style="vertical-align:top;"><img src="http://www.newco.dev.br/images/2022/icones/medalha.svg"/></a>
				</xsl:if>
				<xsl:if test="(/Mantenimiento/LICITACION/LIC_IDESTADO = 'INF' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'CURS' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'CONT' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'CAD')"><!-- carrito aunque no sea autor-->
					<a href="javascript:Vencedores();" style="margin-left:20px; vertical-align:top;"><img src="http://www.newco.dev.br/images/2022/icones/car2.svg"/></a>
					<a href="" id="aContador" class="contador_carrinho"></a>
				</xsl:if>

			</span>
			</p>
		</div>
		<div class="cabecalho_cotacao_linha_2">
			<p>
				<!--29jun22 <a id="botonLicitacion" href="javascript:AbrirLicitacion({/Mantenimiento/LICITACION/LIC_ID});"><xsl:value-of select="/Mantenimiento/LICITACION/TITULO" disable-output-escaping="yes"/></a>-->
				<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CODIGO"/>:&nbsp;<xsl:value-of select="/Mantenimiento/LICITACION/LIC_TITULO" disable-output-escaping="yes"/>
			</p>
		</div>
		<div class="cabecalho_cotacao_linha_3">
			<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_alta_abbr']/node()"/>:&nbsp;</label><xsl:value-of select="/Mantenimiento/LICITACION/LIC_FECHAALTA"/></p> 
			<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='Estado']/node()"/>:&nbsp;</label><xsl:value-of select="/Mantenimiento/LICITACION/ESTADO"/>&nbsp;(<xsl:value-of select="/Mantenimiento/LICITACION/LIC_NUMEROLINEAS"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/>,&nbsp;<xsl:value-of select="Mantenimiento/LICITACION/LIC_NUMEROPROVEEDORES"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedores']/node()"/>) </p>
			<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/>:&nbsp;</label>
				<input class="campopesquisa" type="date" id="FECHADECISION" name="FECHADECISION"/>
				<input class="campopesquisa" type="time" id="HORAMINUTODECISION" name="HORAMINUTODECISION" value="{/Mantenimiento/LICITACION/LIC_HORADECISION}:{/Mantenimiento/LICITACION/LIC_MINUTODECISION}"/>
				<a id="btnGuardarFechaDecision" class="btnDestacado marginLeft50" href="javascript:GuardarVencimiento()"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>			
			</p>
			<p id="pCargaProductos"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='cargando']/node()"/>:&nbsp;</label><span id="spCargaProductos"></span></p>
			<p style="float:Right">
				<select id="selVista" class="w200px" onChange="javascript:CambiaVista();">
					<option value="pes_lDatosGenerales"><xsl:value-of select="document($doc)/translation/texts/item[@name='CONDICIONES']/node()"/></option>
					<xsl:if test="/Mantenimiento/LICITACION/AUTOR and (/Mantenimiento/LICITACION/LIC_IDESTADO='EST' or /Mantenimiento/LICITACION/LIC_IDESTADO='COMP' or /Mantenimiento/LICITACION/LIC_IDESTADO='CURS' or /Mantenimiento/LICITACION/LIC_IDESTADO='INF')">
						<option value="pes_lIncluirProductos"><xsl:value-of select="document($doc)/translation/texts/item[@name='INCLUIRPRODUCTOS']/node()"/></option>
					</xsl:if>
					<option value="pes_lProveedores"><xsl:value-of select="document($doc)/translation/texts/item[@name='PROVEEDORES']/node()"/></option>
					<xsl:if test="/Mantenimiento/LICITACION/AUTOR">
						<option value="pes_lUsuarios"><xsl:value-of select="document($doc)/translation/texts/item[@name='USUARIOS']/node()"/></option>
						<xsl:if test="/Mantenimiento/LICITACION/LICITACION_AGREGADA">
							<option value="pes_lCentros"><xsl:value-of select="document($doc)/translation/texts/item[@name='CENTROS']/node()"/> </option>
						</xsl:if>
					</xsl:if>
					<option value="pes_lProductos"><xsl:value-of select="document($doc)/translation/texts/item[@name='PRODUCTOS']/node()"/></option>
					<option value="pes_lMatriz"><xsl:value-of select="document($doc)/translation/texts/item[@name='MATRIZ']/node()"/></option>
					<option value="pes_lResumen"><xsl:value-of select="document($doc)/translation/texts/item[@name='RESUMEN']/node()"/></option>
					<option value="pes_lInformes"><xsl:value-of select="document($doc)/translation/texts/item[@name='INFORMES']/node()"/></option>
				</select>
			</p>
		</div>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	</div>
</div><!--fin de divLeft-->

<!--	Datos generales	-->
<div class="divLeft Vista" id="lDatosGenerales" style="display:none">
	<xsl:choose>
	<xsl:when test="/Mantenimiento/NUEVALICITACION">
		<xsl:call-template name="Tabla_Datos_Generales_Nuevo"/>
	</xsl:when>
	<xsl:when test="/Mantenimiento/LICITACION/LIC_IDESTADO = 'EST' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'COMP'">
		<!--<xsl:call-template name="Tabla_Datos_Generales_Estudio_Previo"/>-->
		<xsl:call-template name="Tabla_Datos_Generales_Autor"/>
	</xsl:when>
	<xsl:when test="(/Mantenimiento/LICITACION/LIC_IDESTADO = 'CURS' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'INF') and /Mantenimiento/LICITACION/AUTOR">
		<xsl:call-template name="Tabla_Datos_Generales_Autor"/>
	</xsl:when>
	<xsl:otherwise>
		<xsl:call-template name="Tabla_Datos_Generales"/>
	</xsl:otherwise>
	</xsl:choose>
</div>

<!--	Incluir productos	-->
<xsl:choose>
<xsl:when test="Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_IDESTADO='COMP'">
	<!-- COmpras por centro	-->
	<xsl:call-template name="Tabla_Productos_Centro_Estudio_Previo"/>
</xsl:when>
<xsl:when test="/Mantenimiento/LICITACION/AUTOR and (/Mantenimiento/LICITACION/LIC_IDESTADO='EST' or /Mantenimiento/LICITACION/LIC_IDESTADO='CURS' or /Mantenimiento/LICITACION/LIC_IDESTADO='INF')">
	<div class="divLeft Vista" id="lIncluirProductos" style="display:none">
		<br/>
		<div id="pestanasProd">
			<ul class="pestannas textCenter">
				<li>
					<a id="pes_lpPorReferencia" class="MenuProd"><xsl:value-of select="document($doc)/translation/texts/item[@name='Por_Referencia']/node()"/></a>
				</li>
				<li>
					<a id="pes_lpPorCatalogo" class="MenuProd"><xsl:value-of select="document($doc)/translation/texts/item[@name='Por_Catalogo']/node()"/></a>
				</li>
			</ul>
		</div>
		<br/>
		<br/>
		<form id="frmIncluirProductos" name="frmIncluirProductos" method="post">
		<div id="lpCatPrivProductos">
			<br/>
			<br/>
			<table class="infoTable divLeft incidencias" border="0" cellspacing="5">
				<tr>
					<td class="quince">&nbsp;</td>
					<td colspan="2" class="textRight fuentePeq"><br/><xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_nuevo_poducto_X_cat_priv']/node()"/><br/><br/></td>
					<td>&nbsp;</td>
				</tr>
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/NOMBRESNIVELES/@MostrarCategoria = 'S'">
				<tr id="nivel1">
					<td>&nbsp;</td>
					<td class="quince labelRight grisMed"><xsl:value-of select="/Mantenimiento/LICITACION/NOMBRESNIVELES/NIVEL1"/>:</td>
					<td class="quince datosLeft">
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="/Mantenimiento/LICITACION/LISTACATEGORIAS/field"/>
							<xsl:with-param name="onChange">SeleccionaFamilia(this.value);</xsl:with-param>
							<xsl:with-param name="claSel">w400px</xsl:with-param>
						</xsl:call-template>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr id="nivel2">
					<td>&nbsp;</td>
					<td class="labelRight grisMed"><xsl:value-of select="/Mantenimiento/LICITACION/NOMBRESNIVELES/NIVEL2"/>:</td>
					<td class="datosLeft">
						<select name="IDFAMILIA" id="IDFAMILIA" class="w400px" onchange="SeleccionaSubFamilia(this.value);" disabled="disabled">
							<option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/></option>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr id="nivel3">
					<td>&nbsp;</td>
					<td class="labelRight grisMed"><xsl:value-of select="/Mantenimiento/LICITACION/NOMBRESNIVELES/NIVEL3"/>:</td>
					<td class="datosLeft">
						<select name="IDSUBFAMILIA" id="IDSUBFAMILIA" class="w400px" onchange="SeleccionaGrupo(this.value);" disabled="disabled">
							<option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/></option>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr id="nivel4">
					<td>&nbsp;</td>
					<td class="labelRight grisMed"><xsl:value-of select="/Mantenimiento/LICITACION/NOMBRESNIVELES/NIVEL4"/>:</td>
					<td class="datosLeft">
						<select name="IDGRUPO" id="IDGRUPO" class="w400px" onchange="SeleccionaProducto(this.value);" disabled="disabled">
							<option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/></option>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr id="nivel5">
					<td>&nbsp;</td>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto_estandar']/node()"/>:</td>
					<td class="datosLeft">
						<select name="IDPRODUCTOESTANDAR" id="IDPRODUCTOESTANDAR" class="w400px" disabled="disabled">
							<option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/></option>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr id="nivel2">
					<td>&nbsp;</td>
					<td class="veinte labelRight grisMed"><xsl:value-of select="/Mantenimiento/LICITACION/NOMBRESNIVELES/NIVEL2"/>:</td>
					<td class="quince datosLeft">
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="/Mantenimiento/LICITACION/LISTAFAMILIAS/field"/>
							<xsl:with-param name="onChange">SeleccionaSubFamilia(this.value);</xsl:with-param>
							<xsl:with-param name="claSel">w400px</xsl:with-param>
						</xsl:call-template>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr id="nivel3">
					<td>&nbsp;</td>
					<td class="labelRight grisMed"><xsl:value-of select="/Mantenimiento/LICITACION/NOMBRESNIVELES/NIVEL3"/>:</td>
					<td class="datosLeft">
						<select name="IDSUBFAMILIA" id="IDSUBFAMILIA" class="w400px" onchange="SeleccionaGrupo(this.value);" disabled="disabled">
							<option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/></option>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr id="nivel5">
					<td>&nbsp;</td>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto_estandar']/node()"/>:</td>
					<td class="datosLeft">
						<select name="IDPRODUCTOESTANDAR" id="IDPRODUCTOESTANDAR" class="w400px" disabled="disabled">
							<option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/></option>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
			</xsl:otherwise>
			</xsl:choose>

			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/IDPAIS ='55' or /Mantenimiento/LICITACION/IDPAIS ='57'">
				<input type="hidden" name="LIC_TIPOIVA" value="0"/>
			</xsl:when>
			<xsl:otherwise>
				<tr>
					<td>&nbsp;</td>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/>:</td>
					<td class="datosLeft">
						<select name="LIC_TIPOIVA" id="LIC_TIPOIVA">
							<xsl:for-each select="/Mantenimiento/LICITACION/TIPOSIVA/field/dropDownList/listElem">
								<option value="{ID}">
									<xsl:if test="ID = ../../@current">
										<xsl:attribute name="selected">selected</xsl:attribute>
									</xsl:if>
									<xsl:value-of select="listItem"/>
								</option>
							</xsl:for-each>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
			</xsl:otherwise>
			</xsl:choose>
				<tr><td colspan="4">&nbsp;</td></tr>
				<tr>
					<td colspan="2">&nbsp;</td>
					<td>
						<a class="btnDestacado" href="javascript:IncluirProductosPorCat();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir']/node()"/>
						</a>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr><td colspan="4">&nbsp;</td></tr>
			</table>
		</div>
		<div id="lpRefProductos">
			<table class="infoTable divLeft incidencias" border="0" cellspacing="5">
			<form id="RefProductos" name="RefProductos" method="post">
				<tr><td colspan="4">&nbsp;</td></tr>
				<tr>
					<td class="veinte">&nbsp;</td>
					<td colspan="3" class="fuentePeq">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_nuevo_poducto_X_ref_licitaciones']/node()"/>:&nbsp;
						<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/>[:<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/>[:<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ref']/node()"/>[:<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_obj']/node()"/>]]]
						<br/><br/>
					</td>
				</tr>
				<xsl:if test="/Mantenimiento/LICITACION/CENTROSREFPARTICULARES">
				<tr>
					<xsl:if test="/Mantenimiento/LICITACION/LIC_CENTROSCODIFPARTICULAR>1">
						<xsl:attribute name="style">display:none</xsl:attribute>
					</xsl:if>
					<td class="veinte">&nbsp;</td>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Utilizar_codificacion']/node()"/>:&nbsp;</td>
					<td class="datosLeft">
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="/Mantenimiento/LICITACION/CENTROSREFPARTICULARES/field"/>
							<xsl:with-param name="claSel">w400px</xsl:with-param>
						</xsl:call-template>
						<br/>
						<br/>
					</td>
				</tr>
				</xsl:if>
				<tr>
					<td>&nbsp;</td>
					<td class="labelRight quince grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencias']/node()"/>:</td>
					<td class="quince datosLeft">
						<textarea name="LIC_LISTA_REFPRODUCTO" id="LIC_LISTA_REFPRODUCTO" cols="50" rows="10"/>
					</td>
					<td class="datosLeft">
						<a class="btnNormal" href="javascript:CatalogoPrivadoProductoEmpresa('{/Mantenimiento/LICITACION/IDEMPRESACATALOGO}&amp;ORIGEN=LICITACION','');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo']/node()"/>
						</a>
					</td>
				</tr>

			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/IDPAIS ='55'">
				<input type="hidden" name="LIC_TIPOIVA" value="0"/>
			</xsl:when>
			<xsl:when test="/Mantenimiento/LICITACION/IDPAIS ='57'">
				<input type="hidden" name="LIC_TIPOIVA" value="0"/>
			</xsl:when>
			<xsl:when test="/Mantenimiento/LICITACION/IDPAIS = '34'">
				<tr>
					<td>&nbsp;</td>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/>:</td>
					<td class="datosLeft">
						<select name="LIC_TIPOIVA" id="LIC_TIPOIVA">
							<xsl:for-each select="/Mantenimiento/LICITACION/TIPOSIVA/field/dropDownList/listElem">
								<option value="{ID}">
									<xsl:if test="ID = ../../@current">
										<xsl:attribute name="selected">selected</xsl:attribute>
									</xsl:if>
									<xsl:value-of select="listItem"/>
								</option>
							</xsl:for-each>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
			</xsl:when>
			</xsl:choose>
				<tr>
					<td colspan="2">&nbsp;</td>
					<td>
						<br/>
						<a id="EnviarProductosPorRef" class="btnDestacado" href="javascript:IncluirProductosPorRef();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_referencia']/node()"/>
						</a>
						<div id="idEstadoEnvio" style="display:none;"/>
					</td>
					<td>&nbsp;</td>
				</tr>
			</form>
			</table>
		</div>
		</form>
	</div>
</xsl:when>
</xsl:choose>


<!--	Buscador:oculto hasta que se acabe la carga	-->
<div id="lProductos" class="divLeft Vista">

	<div id="divBuscador" class="divLeft" style="display:none">
		<table cellspacing="6px" cellpadding="6px">
		<tr>
			<th class="w50px">&nbsp;</th>
			<!--	Proveedor		-->
			<th class="w200px textLeft">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></label><br />
			<select id="IDPROVEEDOR" class="w200px"/>
			</th>
			<!--	Producto		-->
			<th class="w200px textLeft">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></label><br />
				<input type="text" id="FTEXTO" class="campopesquisa w200px" value=""/>
			</th>
			<!--	Tipo de consulta		-->
			<th class="w200px textLeft">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Filtros']/node()"/></label><br />
				<select id="IDTIPOCONSULTA" class="w200px">
					<option value="TODOS"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></option>			
					<option value="SIN_OFERTA"><xsl:value-of select="document($doc)/translation/texts/item[@name='Sin_oferta']/node()"/></option>			
					<option value="NO_ADJUDICADOS"><xsl:value-of select="document($doc)/translation/texts/item[@name='No_adjudicados']/node()"/></option>			
					<option value="SIN_AHORRO"><xsl:value-of select="document($doc)/translation/texts/item[@name='Sin_ahorro']/node()"/></option>			
				</select>
			</th>
			<!--	Buscar		-->
			<th width="140px" class="textLeft">
				<br/>
				<a class="btnDestacado" href="javascript:Buscar();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
				</a>
			</th>
			<th>&nbsp;</th>
		</tr>
		</table>
	</div>

	<div class="divLeft" id="TablaProductos">
		<input type="hidden" name="IDLicitacion" value="{/Mantenimiento/LICITACION/LIC_ID}"/>		<!--	para el JS	-->
		<input type="hidden" name="LIC_ID" value="{/Mantenimiento/LICITACION/LIC_ID}"/>				<!--	se utiliza en el XSQL		-->
		<input type="hidden" name="IDCentro" value="{/Mantenimiento/LICITACION/IDCENTRO}"/>
		<input type="hidden" name="ACCION" value=""/>
		<input type="hidden" name="PARAMETROS" value=""/>
		<input type="hidden" name="CODPEDIDO" value=""/>
		<input type="hidden" name="IDCENTROPEDIDO" value=""/>
		<form name="frmProductos" id="frmProductos">
		<div id="listaProductos">
		</div>
		</form>
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

<xsl:if test="/Mantenimiento/LICITACION/ROL = 'COMPRADOR'">

	<!-- PESTANA PROVEEDORES -->
	<div class="tabela tabela_redonda Vista" id="lProveedores" style="display:none">
		<xsl:choose>
		<xsl:when test="/Mantenimiento/LICITACION/LIC_IDESTADO = 'EST' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'COMP' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'CURS' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'INF'">
			<xsl:call-template name="Tabla_Proveedores_Previo"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="Tabla_Proveedores_Adjudicado"/>
		</xsl:otherwise>
		</xsl:choose>
	</div>
	<!-- FIN PESTANA PROVEEDORES -->

	<!-- PESTANA CENTROS -->
	<div class="tabela tabela_redonda Vista" id="lCentros" style="display:none">
		<xsl:if test="/Mantenimiento/LICITACION/LICITACION_AGREGADA">
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/ROL = 'COMPRADOR' and (/Mantenimiento/LICITACION/LIC_IDESTADO = 'EST' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'COMP' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'CURS' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'INF')">
				<xsl:call-template name="Tabla_Centros_Editable"/>
			</xsl:when>
			<xsl:when test="/Mantenimiento/LICITACION/ROL = 'COMPRADOR'">
				<xsl:call-template name="Tabla_Centros_Estatica"/>
			</xsl:when>
			<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</div>

	<!-- PESTANA USUARIOS -->
	<div class="tabela tabela_redonda tablaUsuarios Vista" id="lUsuarios" style="display:none">
		<table id="tbUsuarios" cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
			<tr>
				<th class="w1px">&nbsp;</th>
				<th class="textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></th>
				<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_alta']/node()"/></th>
				<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
				<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_firma']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/></th>
				<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='acciones']/node()"/></th>
				<th>&nbsp;</th>
			</tr>
			</thead>

			<tbody class="corpo_tabela">
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/USUARIOSLICITACION/USUARIO">
				<xsl:for-each select="/Mantenimiento/LICITACION/USUARIOSLICITACION/USUARIO">
				<tr class="conhover">
					<td class="color_status"></td>
					<td class="textLeft">
						<xsl:if test="AUTOR"><span class="amarillo"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/>:</strong></span>&nbsp;</xsl:if>
						<xsl:value-of select="NOMBRE"/>
					</td>
					<td><xsl:value-of select="LIC_USU_FECHAALTA"/></td>
					<td><xsl:value-of select="ESTADOLICITACION"/></td>
					<td><xsl:value-of select="LIC_USU_FECHAMODIFICACION"/></td>
					<td><xsl:value-of select="LIC_USU_COMENTARIOS"/></td>
					<td>
						<xsl:if test="/Mantenimiento/LICITACION/LIC_IDESTADO = 'FIRM' and ID = /Mantenimiento/US_ID and LIC_USU_IDESTADO != 'FIRM' and LIC_USU_FIRMA = 'S'">
							<a class="accFirma" href="javascript:modificaUsuario({IDUSUARIO_LIC},'FIRM');"><img src="http://www.newco.dev.br/images/firmar.gif"/></a>&nbsp;
						</xsl:if>
						<xsl:if test="(not(AUTOR) or SE_PUEDE_BORRAR) and /Mantenimiento/LICITACION/AUTOR and (/Mantenimiento/LICITACION/LIC_IDESTADO='EST' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'COMP' or /Mantenimiento/LICITACION/LIC_IDESTADO='CURS' or /Mantenimiento/LICITACION/LIC_IDESTADO='INF')">
							<a class="accBorrar" href="javascript:modificaUsuario({IDUSUARIO_LIC},'B');">
								<img src="http://www.newco.dev.br/images/2022/icones/del.svg"/>
							</a>
						</xsl:if>
					</td>
					<td>&nbsp;</td>
				</tr>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<tr><td class="color_status"></td><td colspan="7" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion_sin_usuarios']/node()"/></strong></td></tr>
			</xsl:otherwise>
			</xsl:choose>
			</tbody>
			<tfoot class="rodape_tabela">
				<tr><td colspan="8">&nbsp;</td></tr>
			</tfoot>
		</table>

		<xsl:if test="/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/USUARIOS/USUARIO and (/Mantenimiento/LICITACION/LIC_IDESTADO='EST' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'COMP' or /Mantenimiento/LICITACION/LIC_IDESTADO='CURS' or /Mantenimiento/LICITACION/LIC_IDESTADO='INF')">
		<form id="frmUsuarios" name="frmUsuarios" method="post">
		<table class="buscador tablaUsuarios" id="lUsuariosForm" cellspacing="6px" cellpadding="6px">
			<tr><td colspan="4">&nbsp;</td></tr>
			<tr>
				<td class="trenta">&nbsp;</td>
				<td class="labelRight w200px grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuarios']/node()"/>:</td>
				<td class="w400px textLeft">
					<select name="LIC_IDUSUARIO" class="w400px">
						<option value=""><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciona']/node()"/></option>
						<xsl:for-each select="/Mantenimiento/LICITACION/USUARIOS/USUARIO">
							<option value="{ID}"><xsl:value-of select="NOMBRE"/></option>
						</xsl:for-each>
					</select>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='firma']/node()"/>:</td>
				<td class="textLeft" colspan="2">
					<input type="checkbox" name="LIC_USU_FIRMA" id="LIC_USU_FIRMA" value="S"/>&nbsp;
					<span class="fuentePeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='expli_firma']/node()"/></span>
				</td>
			</tr>
			<tr>
    			<td>&nbsp;</td>
    			<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='coautor']/node()"/>:</td>
    			<td class="textLeft" colspan="2">
					<input type="checkbox" name="LIC_USU_COAUTOR" id="LIC_USU_COAUTOR" value="N" unchecked="unchecked"/>&nbsp;
					<span class="fuentePeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='expli_coautor']/node()"/></span>
    			</td>
			</tr>
			<tr><td colspan="4">&nbsp;</td></tr>
			<tr>
				<td colspan="2">&nbsp;</td>
				<td>
					<a class="btnDestacado" href="javascript:AnadirUsuario();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir']/node()"/>
					</a>
				</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		</form>
		</xsl:if>
		<!-- FIN PESTANA USUARIOS -->
	</div>

	<!-- PESTANA RESUMEN -->
	<div class="divLeft Vista" id="lResumen" style="display:none">
		<div class="formEstandar">
    	<ul class="w1000px">
        	<li class="sinSeparador">
			<!--	3oct16	Añadimos un breve resumen cuantitativo		-->
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>:&nbsp;</label>
				<xsl:value-of select="/Mantenimiento/LICITACION/PRODUCTOSADJUDICADOS"/>/<xsl:value-of select="/Mantenimiento/LICITACION/LIC_NUMEROLINEAS"/>
			</li>
			<li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>:&nbsp;</label>
				<xsl:value-of select="/Mantenimiento/LICITACION/LIC_PROVEEDORESADJUDICADOS"/>/<xsl:value-of select="/Mantenimiento/LICITACION/LIC_NUMEROPROVEEDORES"/>
			</li>
			<li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Total_adjudicado']/node()"/>:&nbsp;</label>
				<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CONSUMOADJUDICADO"/><!--/<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CONSUMOHISTADJUDICADO"/>-->
			</li>
			<li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro']/node()"/>:&nbsp;</label>
				<xsl:value-of select="/Mantenimiento/LICITACION/LIC_AHORROADJUDICADO"/>
			</li>

			<li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='situacion']/node()"/>:&nbsp;</label>
				<xsl:choose>
				<xsl:when test="/Mantenimiento/LICITACION/AUTOR">
					<input type="textbox" id="LIC_INF_SITUACION" name="LIC_INF_SITUACION" class="campopesquisa w600px" value="{/Mantenimiento/LICITACION/INFORME/LIC_INF_SITUACION_SINFORMATO}"/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="btnDestacado" href="javascript:guardarDatosInforme();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="/Mantenimiento/LICITACION/INFORME/LIC_INF_SITUACION" disable-output-escaping="yes"/>
				</xsl:otherwise>
				</xsl:choose>
			</li>
			<li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='presentacion']/node()"/>:&nbsp;</label>
				<xsl:choose>
				<xsl:when test="/Mantenimiento/LICITACION/AUTOR">
					<textarea id="LIC_INF_PRESENTACION" name="LIC_INF_PRESENTACION" rows="10" cols="80">
						<xsl:value-of select="/Mantenimiento/LICITACION/INFORME/LIC_INF_PRESENTACION_SINFORMATO"/>
					</textarea>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="/Mantenimiento/LICITACION/INFORME/LIC_INF_PRESENTACION" disable-output-escaping="yes"/>
				</xsl:otherwise>
				</xsl:choose>
			</li>
			<li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='analisis']/node()"/>:&nbsp;</label>
				<xsl:choose>
				<xsl:when test="/Mantenimiento/LICITACION/AUTOR">
					<textarea id="LIC_INF_ANALISIS" name="LIC_INF_ANALISIS" rows="10" cols="80">
						<xsl:value-of select="/Mantenimiento/LICITACION/INFORME/LIC_INF_ANALISIS_SINFORMATO"/>
					</textarea>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="/Mantenimiento/LICITACION/INFORME/LIC_INF_ANALISIS" disable-output-escaping="yes"/>
				</xsl:otherwise>
				</xsl:choose>
			</li>
			<li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='conclusiones']/node()"/>:&nbsp;</label>
				<xsl:choose>
				<xsl:when test="/Mantenimiento/LICITACION/AUTOR">
					<textarea id="LIC_INF_CONCLUSIONES" name="LIC_INF_CONCLUSIONES" rows="10" cols="80">
						<xsl:value-of select="/Mantenimiento/LICITACION/INFORME/LIC_INF_CONCLUSIONES_SINFORMATO"/>
					</textarea>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="/Mantenimiento/LICITACION/INFORME/LIC_INF_CONCLUSIONES" disable-output-escaping="yes"/>
				</xsl:otherwise>
				</xsl:choose>
			</li>
		</ul>
		</div>
		<br/>
		<br/>
		<br/>
	</div>

	<!-- PESTANA INFORMES -->
	<div class="divLeft Vista" id="lInformes" style="display:none">
		<table cellspacing="10px" cellpadding="10px">
		<tbody>
			<tr>
				<td class="textLeft w100px">&nbsp;</td>
				<td class="textLeft">
					<strong><a href="javascript:Informe('licAvanceOfertas2022.xsql?','Informe Licitacion');"><xsl:value-of select="document($doc)/translation/texts/item[@name='AvanceOfertas']/node()"/></a></strong>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td class="textLeft">
					<strong><a href="javascript:Informe('licOfertasSeleccionadas2022.xsql?','Informe Licitacion');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Vencedores']/node()"/></a></strong>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td class="textLeft">
					<strong><a href="javascript:Informe('VencedoresYAlternativas2022.xsql?OFERTAS=2&amp;','Informe vencedores y 2 alternativas de la licitacion');"><xsl:value-of select="document($doc)/translation/texts/item[@name='VencedoresY2Alternativas']/node()"/></a></strong>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td class="textLeft">
					<strong><a href="javascript:Informe('VencedoresYAlternativas2022.xsql?OFERTAS=4&amp;','Informe vencedores y 4 alternativas de la licitacion');"><xsl:value-of select="document($doc)/translation/texts/item[@name='VencedoresY4Alternativas']/node()"/></a></strong>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td class="textLeft">
					<strong><a href="javascript:Informe('licInformePorProveedor2022.xsql?','Informe productos adjudicados de la licitacion');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_adjudicados_por_proveedor']/node()"/></a></strong>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td class="textLeft">
					<strong><a href="javascript:Informe('licInformeProveedoresYOfertas2022.xsql?','Informe proveedores y ofertas de la licitacion');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores_y_ofertas']/node()"/></a></strong>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td class="textLeft">
					<strong><a href="javascript:Informe('licInformeResumen2022.xsql?','Informe resumen de la licitacion');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Informe_resumen_licitacion']/node()"/></a></strong>
				</td>
			</tr>

			<xsl:if test="/Mantenimiento/LICITACION/LIC_PEDIDOSENVIADOS>0">
			<tr>
				<td>&nbsp;</td>
				<td class="textLeft">
					<strong><a href="javascript:Informe('licInformePedidos2022.xsql?','Informe pedidos de la licitacion');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Informe_pedidos_licitacion']/node()"/></a></strong>
				</td>
			</tr>
			</xsl:if>
		</tbody>
		</table>
		<br/>
		<br/>
		<br/>
	</div>

	<!-- Matriz de ofertas, solo para COMPRADOR en estado CURS, INF, FIRM, CONT	-->
	<xsl:if test="/Mantenimiento/LICITACION/ROL = 'COMPRADOR' and (/Mantenimiento/LICITACION/LIC_IDESTADO='CURS' or /Mantenimiento/LICITACION/LIC_IDESTADO='INF' or /Mantenimiento/LICITACION/LIC_IDESTADO='FIRM' or /Mantenimiento/LICITACION/LIC_IDESTADO='CONT')">
		<div class="divLeft Vista" id="lMatriz" style="display:none">
			<xsl:call-template name="Tabla_Productos_Ofertas_Cliente"/>
		</div>
	</xsl:if>

</xsl:if>

</xsl:template>

</xsl:stylesheet>
