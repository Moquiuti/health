<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	LICITACION POR PRODUCTO. Creado desde licOfertasSeleccionadasHTML2022.	
	Ultima revision ET 21jun22 10:30 LicitacionV2_2022_130422.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<!--20jun22 Incluimos los templates para las tablas internas	-->
<xsl:import href="http://www.newco.dev.br/Gestion/Comercial/LicV2GeneralTemplates2022.xsl.xsl"/>
<xsl:import href="http://www.newco.dev.br/Gestion/Comercial/LicProductosTemplates2022.xsl"/>
<xsl:import href="http://www.newco.dev.br/Gestion/Comercial/LicProveedoresTemplates2022.xsl"/>
<xsl:import href="http://www.newco.dev.br/Gestion/Comercial/LicCentrosTemplates2022.xsl"/>
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

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>		<!-- Para descargas excel	-->
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/LicitacionV2_2022_130422.js"></script>
	<script type="text/javascript">
	var IDUsuario		=<xsl:value-of select="/Mantenimiento/LICITACION/IDUSUARIO"/>;
	var IDLicitacion	=<xsl:value-of select="/Mantenimiento/LICITACION/LIC_ID"/>;
	var IDPais			=<xsl:value-of select="/Mantenimiento/LICITACION/IDPAIS"/>;
	var IDIdioma		= '<xsl:value-of select="/Mantenimiento/LICITACION/IDIDIOMA"/>';
	var EstadoLic		='<xsl:value-of select="/Mantenimiento/LICITACION/LIC_IDESTADO"/>';
	var	liciFirmada = '';		//	24jun22
	var IDCentroSel		='<xsl:value-of select="/Mantenimiento/IDCENTROCOMPRAS"/>';
	var MesesDuracion	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_MESESDURACION"/>';
	var isLicAgregada	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_AGREGADA"/>';
	var isLicMultiopcion	=  '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_MULTIOPCION"/>';
	var NumCentrosPendientes= '<xsl:value-of select="/Mantenimiento/LICITACION/CENTROS_PENDIENTES_INFORMAR"/>';
	var totalProductos		= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_NUMEROLINEAS"/>';
	var numProdsSeleccion	= '<xsl:value-of select="/Mantenimiento/LICITACION/TOTAL_SELECCIONADAS"/>';
	var numProvsNoCumplen	= '<xsl:value-of select="/Mantenimiento/LICITACION/TOTAL_NO_CUMPLEN_PEDMINIMO"/>';
	var numProdsRevisarUdesLote	= '<xsl:value-of select="/Mantenimiento/LICITACION/TOTAL_REVISAR_UNIDADESPORLOTE"/>';
	var conCircuitoAprobacion = '<xsl:value-of select="/Mantenimiento/LICITACION/CON_CIRCUITO_APROBACION"/>';
	var saltarPedMinimo = '<xsl:value-of select="/Mantenimiento/LICITACION/SALTARPEDIDOMINIMO"/>';
	var fechaEntregaPedidoVencida = '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/FECHA_PEDIDO_VENCIDA">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
	var esCdC = '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/CDC">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
	var esAutor = '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/AUTOR">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
	var editarCant = '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/PERMITIR_MODIFICAR_CANTIDADES">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
	var incluirDocs = '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/INCLUIR_COLUMNA_DOCUMENTOS">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
	var botonPedido = '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/BOTON_PEDIDO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
	var multiOpcion = '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_MULTIOPCION"/>';
	var porProducto = '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/LIC_PORPRODUCTO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
	var MostrarMotivoSeleccion= '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/MOSTRARMOTIVOSELECCION">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
	var fechaDecisionLic = '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_FECHADECISIONPREVISTA"/>';		//	25abr17	

	//	Textos para construir tablas de datos
	var strTipoIva	='<xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/>';
	var strEstaEval	='<xsl:value-of select="document($doc)/translation/texts/item[@name='estado_evaluacion']/node()"/>';
	var strFecOferta='<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_oferta']/node()"/>';
	var strFecha	='<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>';
	var strProveedor='<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>';
	var strPedMin	='<xsl:value-of select="document($doc)/translation/texts/item[@name='Ped_minimo']/node()"/>';
	var strPlEntrega='<xsl:value-of select="document($doc)/translation/texts/item[@name='Pl_entrega']/node()"/>';
	var strConsumo	='<xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/>';
	var strVerDoc	='<xsl:value-of select="document($doc)/translation/texts/item[@name='Ver_doc']/node()"/>';
	var strRefProv	='<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>';

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

	var alrt_GuardarSelOk	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_selecc_adjudica_ok']/node()"/>';
	var alrt_GuardarSelKo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_selecc_adjudica_ko']/node()"/>';
	var alrt_CambiosPendientes	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cambios_pendientes']/node()"/>';
	var alrt_CantidadInfTotal	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_inferior_total']/node()"/>';
	var alrt_CantidadSupTotal	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_superior_total']/node()"/>';
	var alrt_TotalAsignadoNoCoincide= '<xsl:value-of select="document($doc)/translation/texts/item[@name='total_asignado_no_coincide']/node()"/>';
	var alrt_CantidadNoCorresponde= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cantidad_no_corresponde_empaq']/node()"/>';
	var alrt_SuperadaCantidad= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Superada_cantidad']/node()"/>';
	var alrt_GuardarFechaDecisionKO= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Guardar_fecha_decision_ko']/node()"/>';

	var alrt_ExistenProdSel= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Existen_productos_no_selecc']/node()"/>';
	var alrt_ExistenProdModif= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Existen_productos_modif']/node()"/>';
	var alrt_DeseaContinuar= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Desea_continuar']/node()"/>';

	<!-- Textos y avisos para tabla usuarios -->
	var str_Autor	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/>';
	var alrt_UsuarioYaExiste	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_usuario_ya_existe']/node()"/>';
	var alrt_NuevoUsuarioKO		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_nuevo_usuario']/node()"/>';
	var alrt_EliminarUsuarioKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_eliminar_usuario']/node()"/>';
	var alrt_licitacionFirmada	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cliente_firma_licitacion']/node()"/>';


	//13jun22 Avisos de error en Fechas
	var val_faltaFechaDecision	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_fecha_decision']/node()"/>';
	var val_malFechaDecision	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_fecha_decision']/node()"/>';
	var val_malFechaPedidoLic	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_fecha_pedido_lic']/node()"/>';
	var val_FechaDecisionAntigua= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision_antigua']/node()"/>';
	var val_FechaPedidoAntigua	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_pedido_antigua']/node()"/>';
	var val_faltaDescripcion	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_descripcion']/node()"/>';
	var val_malFechaAdjudic		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_fecha_adjudicacion']/node()"/>';
	var val_malFechaAdjudic2	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_adjudicacion_posterior_fecha_decision_obli']/node()"/>';


	
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

	<xsl:for-each select="/Mantenimiento/LICITACION/PROVEEDORESLICITACION/PROVEEDOR">
		var items		= [];
		items['Orden']	= '<xsl:value-of select="ORDEN"/>';
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
		<!--
		En principio, no trabajaremos con los consumos con IVA
		items['ConsumoIVA']	= '<xsl:value-of select="LIC_PROV_CONSUMOIVA"/>';
		items['ConsumoPotIVA']	= '<xsl:value-of select="LIC_PROV_CONSUMOPOTENCIALIVA"/>';
		items['ConsumoAdjIVA']	= '<xsl:value-of select="LIC_PROV_CONSUMOADJUDICADOIVA"/>';
		items['AhorroIVA']	= '<xsl:value-of select="LIC_PROV_AHORROIVA"/>';
		-->

		items['OfertasAdj']	= '<xsl:value-of select="LIC_PROV_OFERTASADJUDICADAS"/>';
		<!-- Variable auxiliar que nos permite modificar su valor al vuelo cuando se hacen cambios en el DOM sin perder el valor guardado en la BBDD -->
		<!--items['OfertasAdjAux']	= '<xsl:value-of select="LIC_PROV_OFERTASADJUDICADAS"/>';-->
		items['CumplePedMinimo']	= 'S';					//	22jul18

		arrConsumoProvs.push(items);
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

		items['Centros']= [];
		var DatosCentros	= [];
		<xsl:if test="DATOS_PRIVADOS/CENTRO">
			var Centro	= [];
			<xsl:for-each select="DATOS_PRIVADOS/CENTRO">
			Centro['IDCentro']		= '<xsl:value-of select="IDCENTRO"/>';
			Centro['RefCentro']		= '<xsl:value-of select="REFCENTRO"/>';
			DatosCentros.push(Centro);
			</xsl:for-each>
			items[Centros].push(DatosCentros);
		</xsl:if>

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
</head>
<!--<body class="gris" >-->
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
			<xsl:value-of select="/Mantenimiento/LICITACION/EMPRESALICITACION/NOMBRE" disable-output-escaping="yes"/>
			<span class="CompletarTitulo300">
				<a href="javascript:MejoresPrecios(0);" style="margin-top:1%;"><img src="http://www.newco.dev.br/images/2022/icones/medalha.svg"/></a>
				<a href="javascript:Vencedores();" style="margin-left:20px; margin-top:1%;"><img src="http://www.newco.dev.br/images/2022/icones/car2.svg"/></a>
				<a href="" id="aContador" class="contador_carrinho"></a>

				<!-- 15jun22 Boton Licitacion	
				<a id="btnLic" class="btnNormal" href="javascript:chFichaLicitacion({/Mantenimiento/LICITACION/LIC_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion']/node()"/></a>
				&nbsp;
				<!- - Boton Vencedores	- ->
				<a id="btnVencedores" class="btnNormal" href="javascript:chVencedores({/Mantenimiento/LICITACION/LIC_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='Vencedores']/node()"/></a>
				-->
				<!--
					<a class="btnNormal" href="javascript:DescargarVencedores();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='boton_descargarVencedores']/node()"/>
                   	</a>&nbsp;
				<xsl:if test="/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_PORPRODUCTO = 'S' and (/Mantenimiento/LICITACION/LIC_IDESTADO = 'INF' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'CURS')"><!- - and not BLOQUEARADJUDICACION- ->
					<xsl:choose>
					<xsl:when test="/Mantenimiento/LICITACION/LIC_MULTIOPCION='S'">
						<a class="btnDestacado" id="botonAdjudicarSelec" href="javascript:AdjudicarOfertasMultiples();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicar']/node()"/>
						</a>
						<span id="idAvanceAdjudicar" style="display:none;" class="clear"><!- -<img src="http://www.newco.dev.br/images/loading.gif"/>- ->0/0</span>
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
						<xsl:when test="/Mantenimiento/LICITACION/LIC_PEDIDOSPENDIENTES>0">
							<a class="btnDestacado" id="botonAdjudicarSelec" href="javascript:PreparaLanzarTodosPedidos();"><xsl:value-of select="document($doc)/translation/texts/item[@name='boton_generar_pedido']/node()"/></a>
							<span id="waitBotonAdjudicar" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></span>
							<span id="txtPrepPedido">&nbsp;</span>
						</xsl:when>
						<xsl:otherwise>
							<!- -14feb20 NO mostramos el botón de adjudicar si es licitacion SPOTy no hay pedidos pendientes- ->
						</xsl:otherwise>
						</xsl:choose>								
						<span id="waitBotonAdjudicar" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></span>
					</xsl:otherwise>
					</xsl:choose>	
					-->							
					<!--	11mar20	Botón contrato	-->
					<xsl:if test="/Mantenimiento/LICITACION/BOTON_CONTRATO">
					&nbsp;
						<a class="btnDestacado" id="botonEstContrato" href="javascript:PasarAEstadoContrato();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar_lic']/node()"/>
						</a>
					</xsl:if>
					&nbsp;
			</span>
			</p>
		</div>
		<div class="cabecalho_cotacao_linha_2">
			<p>
				<a id="botonLicitacion" href="javascript:AbrirLicitacion({/Mantenimiento/LICITACION/LIC_ID});"><xsl:value-of select="/Mantenimiento/LICITACION/TITULO" disable-output-escaping="yes"/></a>
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
					<option value="pes_lProductos" selected="selected"><xsl:value-of select="document($doc)/translation/texts/item[@name='PRODUCTOS']/node()"/></option>
					<option value="pes_lMatriz" selected="selected"><xsl:value-of select="document($doc)/translation/texts/item[@name='MATRIZ']/node()"/></option>
					<option value="pes_lProveedores"><xsl:value-of select="document($doc)/translation/texts/item[@name='PROVEEDORES']/node()"/></option>
					<xsl:if test="/Mantenimiento/LICITACION/AUTOR">
						<option value="pes_lUsuarios"><xsl:value-of select="document($doc)/translation/texts/item[@name='USUARIOS']/node()"/></option>
						<xsl:if test="/Mantenimiento/LICITACION/LICITACION_AGREGADA">
							<option value="2"><xsl:value-of select="document($doc)/translation/texts/item[@name='CENTROS']/node()"/> </option>
						</xsl:if>
					</xsl:if>
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

<div class="divLeft Vista" id="lDatosGenerales" style="display:none">
	<xsl:choose>
	<xsl:when test="/Mantenimiento/NUEVALICITACION">
		<xsl:call-template name="Tabla_Datos_Generales_Nuevo"/>
	</xsl:when>
	<xsl:when test="/Mantenimiento/LICITACION/LIC_IDESTADO = 'EST' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'COMP'">
		<xsl:call-template name="Tabla_Datos_Generales_Estudio_Previo"/>
	</xsl:when>
	<xsl:when test="(/Mantenimiento/LICITACION/LIC_IDESTADO = 'CURS' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'INF') and /Mantenimiento/LICITACION/AUTOR">
		<xsl:call-template name="Tabla_Datos_Generales_Autor"/>
	</xsl:when>
	<xsl:otherwise>
		<xsl:call-template name="Tabla_Datos_Generales"/>
	</xsl:otherwise>
	</xsl:choose>
</div>

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
	</div>

</div>


<div class="divLeft Vista" id="lProveedores" style="display:none">
	PROVEEDORES
</div>

<div class="tabela tabela_redonda tablaUsuarios Vista" id="lUsuarios" style="display:none">
	<!-- PESTANA USUARIOS -->
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

<div class="divLeft Vista" id="lMatriz" style="display:none">
MATRIZ
</div>


</xsl:template>

</xsl:stylesheet>
