<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Proveedor: Entrada de oferta para licitacion
	Actualizacion javascript lic2022_060723.js LicProveedor2022_250723.js
	ET 17jul23 17:15
--> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:import href="http://www.newco.dev.br/Gestion/Comercial/LicGeneralTemplates2022.xsl"/><!--Pestanna datos generales lic-->
<xsl:import href="http://www.newco.dev.br/Gestion/Comercial/LicProductosTemplates2022.xsl"/><!--Cabecera tabla productos-->

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

	<title>
	<xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion']/node()"/>&nbsp;<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CODIGO"/>:&nbsp;<xsl:value-of select="/Mantenimiento/LICITACION/LIC_TITULO"/>
	</title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<link href="http://www.newco.dev.br/General/Tabla-popup.150715.css" rel="stylesheet" type="text/css"/>
	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script	type="text/javascript" src="http://www.newco.dev.br/General/Tabla-popup.150715.js"></script><!--	showTablaByID	-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script><!--	16nov17	para abrir fichero excel	-->
	<script type="text/javascript" src="http://www.newco.dev.br/Utilidades/Utilidades.js"></script><!--9feb23 para recuperar la funcion normalizarString	-->

	<script type="text/javascript">
		var lang		= '<xsl:value-of select="/Mantenimiento/LANG"/>';
		var IDUsuario		= '<xsl:value-of select="/Mantenimiento/US_ID"/>';
		var filtroNombre	= '';
		var sepCSV			=';';		//21feb18
		var sepTextoCSV		='';		//21feb18
		var saltoLineaCSV	='\r\n';	//21feb18

    <!-- Variables y Strings JS para las etiquetas -->
		var IDRegistro = '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_ID"/>';
		var fechaDecisionLic = '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_FECHADECISIONPREVISTA"/>';		//	25abr17	
		var IDTipo = 'LIC';
		var str_NuevaEtiquetaGuardada	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta_guardada']/node()"/>';
		var str_NuevaEtiquetaError		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta_error']/node()"/>';
		var str_autor			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/>';
		var str_fecha			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>';
		var str_etiqueta	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='etiqueta']/node()"/>';
		var str_borrar		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>';
		<!-- FIN Variables y Strings JS para las etiquetas -->

    <xsl:choose>
		<xsl:when test='/Mantenimiento/LICITACION/COMPLETAR_COMPRA_CENTRO'>
		var completarCompraCentro = 'S';
		</xsl:when>
		<xsl:otherwise>
		var completarCompraCentro = 'N';
		</xsl:otherwise>
    </xsl:choose>

    <xsl:choose>
		<xsl:when test='/Mantenimiento/NUEVALICITACION'>
			var mesesSelected	= '<xsl:value-of select="/Mantenimiento/NUEVALICITACION/LIC_MESESDURACION"/>';
			var estadoLicitacion	= 'EST';
			var rol			= 'COMPRADOR';
			var isAutor		= 'S';
			var isLicAgregada	='N';	//	15set16 Valor por defecto, sino falla el cambio de meses
			var numProveedoresActivos=0;	// 22set16 Valor por defecto
			var IDPais		= '<xsl:value-of select="/Mantenimiento/NUEVALICITACION/IDPAIS"/>';
			var listaSelecciones ='';
		</xsl:when>
		<xsl:otherwise>
		<!--
		
			LICITACION EXISTENTE
		
		-->
			var IDLicitacion	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_ID"/>';
			var mesesSelected	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_MESESDURACION"/>';
			var estadoLicitacion	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_IDESTADO"/>';
			var rol			= '<xsl:value-of select="/Mantenimiento/LICITACION/ROL"/>';
			var isAutor		= '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/AUTOR">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
			var isAdmin		= '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/ADMIN">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
			var mostrarPrecioIVA	= '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
			var mostrarResumenFlotante	= '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/MOSTRAR_RESUMEN_FLOTANTE">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
			var IDPais		= '<xsl:value-of select="/Mantenimiento/LICITACION/IDPAIS"/>';
			var IDEmpresa		= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_IDEMPRESA"/>';
			var IDIdioma		= '<xsl:value-of select="/Mantenimiento/LICITACION/IDIDIOMA"/>';
			var isLicPorProducto	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_PORPRODUCTO"/>';
			var isLicAgregada	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_AGREGADA"/>';
			var isLicContinua	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CONTINUA"/>';
			var isLicMultipedido	= '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/LICITACION_MULTIPEDIDO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';	<!--	17may17	-->
			var isLicMultiopcion	=  '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_MULTIOPCION"/>';	<!--	9jul18	-->
			var DesplegableMarcas	=  '<xsl:value-of select="/Mantenimiento/LICITACION/DESPLEGABLEMARCAS"/>';	<!--	9jul18	-->
			var SoloMarcasAutorizadas =  '<xsl:value-of select="/Mantenimiento/LICITACION/SOLOMARCASAUTORIZADAS"/>';	<!--	9jul18	-->
			var NumCentrosEnLicitacion= '<xsl:value-of select="/Mantenimiento/LICITACION/CENTROS_EN_LICITACION"/>';
			var NumCentrosPendientes= '<xsl:value-of select="/Mantenimiento/LICITACION/CENTROS_PENDIENTES_INFORMAR"/>';
			var PedidoMinimoPend	= '<xsl:value-of select="Mantenimiento/LICITACION/PRODUCTOSLICITACION/PEDIDOMINIMOPENDIENTE"/>';		//PEDIDO MINIMO PENDIENTE para mostrar lista de productos
			var saltarPedMinimo	= '<xsl:value-of select="Mantenimiento/LICITACION/SALTARPEDIDOMINIMO"/>';		
			var precioObjEstricto	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_PRECIOOBJETIVOESTRICTO"/>';
			var conCircuitoAprobacion = '<xsl:value-of select="/Mantenimiento/LICITACION/CON_CIRCUITO_APROBACION"/>';
			var listaSelecciones = '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_SELECCIONES"/>';
			var IDUsuarioCliente	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_IDUSUARIO"/>';					//24set20

			var permitirEdicionPROV	= '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/PERMITIR_EDICION">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';

			//var numProveedores	= <xsl:value-of select="/Mantenimiento/LICITACION/PROVEEDORESLICITACION/TOTAL"/>;
			var provsInformados	= '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/PROVEEDORESLICITACION/PROVEEDOR">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
			var prodsInformados	= '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/TODOS_VALIDADOS">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';

			var mostrarCategorias	= '<xsl:value-of select="/Mantenimiento/LICITACION/NOMBRESNIVELES/@MostrarCategoria"/>';
			var mostrarGrupos	= '<xsl:value-of select="/Mantenimiento/LICITACION/NOMBRESNIVELES/@MostrarGrupo"/>';

			var SoloProvInformados='<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/LIC_IDESTADO = 'EST' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'COMP'">N</xsl:when><xsl:otherwise>S</xsl:otherwise></xsl:choose>';

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

			var anyChange		= false;

			var	strTitulosColumnasCSV= sepTextoCSV+'<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/>'+sepTextoCSV+sepCSV
									+	sepTextoCSV+'<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>'+sepTextoCSV+sepCSV
									+	sepTextoCSV+'<xsl:value-of select="document($doc)/translation/texts/item[@name='num_ofertas']/node()"/>'+sepTextoCSV+sepCSV
									+	sepTextoCSV+'<xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/>'+sepTextoCSV+sepCSV
									+	sepTextoCSV+'<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_historico']/node()"/>'+sepTextoCSV+sepCSV
									+	sepTextoCSV+'<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_objetivo_sIVA']/node()"/>'+sepTextoCSV+sepCSV
									+	sepTextoCSV+'<xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/>'+sepTextoCSV+sepCSV
									+	sepTextoCSV+'<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/>'+sepTextoCSV+sepCSV
									+	sepTextoCSV+'<xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_historico']/node()"/>'+sepTextoCSV+sepCSV;
				if(IDPais != 55){
					strTitulosColumnasCSV += sepTextoCSV+'<xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/>'+sepTextoCSV+sepCSV;
				}

		</xsl:otherwise>
		</xsl:choose>


		<!-- Mensajes JS para validacion de formularios -->
		<!-- Condiciones de la licitacion -->
		var val_faltaTitulo		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_titulo']/node()"/>';
		var val_faltaFechaDecision	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_fecha_decision']/node()"/>';
		var val_malFechaDecision	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_fecha_decision']/node()"/>';
		var val_malFechaPedidoLic	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_fecha_pedido_lic']/node()"/>';
		var val_FechaDecisionAntigua= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision_antigua']/node()"/>';
		var val_FechaPedidoAntigua= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_pedido_antigua']/node()"/>';
		var val_faltaDescripcion	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_descripcion']/node()"/>';
		var val_faltaCondEntr		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_condiciones_entrega']/node()"/>';
		var val_faltaCondPago		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_condiciones_pago']/node()"/>';
		var val_faltaFechaRealAdj	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_fecha_real_adj']/node()"/>';
		var val_malFechaRealAdj		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_fecha_real_adj']/node()"/>';
		var val_faltaFechaRealCad	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_fecha_real_cad']/node()"/>';
		var val_malFechaRealCad		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_fecha_real_cad']/node()"/>';
		var conf_SalirDatosGenLic	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='seguro_salir_datos_gen_licitacion']/node()"/>';
		var val_malFechaAdjudic		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_fecha_adjudicacion']/node()"/>';
		var val_malFechaAdjudic2	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_adjudicacion_posterior_fecha_decision_obli']/node()"/>';
		<!-- Anyadir productos por referencia -->
		var val_faltaReferencia		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_referencia']/node()"/>';
		var val_maxReferencias		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='num_max_referencias']/node()"/>';
		var val_faltaTipoIVA		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_tipoIVA']/node()"/>';
		var val_faltaPorcentaje		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_porcentaje']/node()"/>';
		var val_errorPorcentaje1	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_porcentaje_1']/node()"/>';
		var val_errorPorcentaje2	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_porcentaje_2']/node()"/>';
		<!-- Anyadir productos por desplegable cat.priv. -->
		var val_faltaSelecDespl		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_seleccionar_desplegable_cat_priv']/node()"/>';
		<!-- Actualizar productos -->
		var val_faltaUdBasica		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_unidad_basica']/node()"/>';
		var val_malPrecioRef		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_precio_referencia']/node()"/>';
		var val_malPrecioObj		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_precio_objetivo']/node()"/>';
		var val_faltaCantidad		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_cantidad']/node()"/>';
		var val_ceroCantidad		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cero_cantidad']/node()"/>';
		var val_malCantidad			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_cantidad']/node()"/>';
		var val_malFechaPedido		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_fecha_pedido']/node()"/>';
		var val_malFechaPedidoAntDecision	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_pedido_ant_fecha_decision']/node()"/>';
		<!-- Anyadir proveedores -->
		var val_faltaProveedor		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_proveedor']/node()"/>';
		var val_faltaUsuarioProv	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_usuario_proveedor']/node()"/>';
		var val_faltaMensaje		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_comentario_licitacion']/node()"/>';
		<!-- Anyadir usuarios firmantes -->
		var val_faltaUsuario		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_usuario']/node()"/>';
		<!-- Anyadir centros -->
		var val_faltaCentro		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_centro']/node()"/>';
		<!-- Proveedor - Pedido minimo -->
		var val_faltaPedidoMinimo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_pedido_minimo']/node()"/>';
		var val_malPedidoMinimo		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_pedido_minimo']/node()"/>';
		var val_faltaFrete		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_frete']/node()"/>';
		var val_faltaPlazoEntrega		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_plazo_entrega']/node()"/>';
		<!-- Proveedor - Informar ofertas -->
		var val_faltaPrecio		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_precio']/node()"/>';
		var val_marcaObligatoria= '<xsl:value-of select="document($doc)/translation/texts/item[@name='marca_obligatoria']/node()"/>';
	
		var val_malPrecio		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_precio']/node()"/>';

		<!--9abr19	var val_elPrecioProd		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='el_precio_prod']/node()"/>';-->
		<!--9abr19  var val_precioProd	  = '<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_prod']/node()"/>';-->
		<!--9abr19	var val_doblePrecio		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_doble_precio']/node()"/>';-->

		var val_PrecioFueraRango= '<xsl:value-of select="document($doc)/translation/texts/item[@name='aviso_precio_fuera_rango']/node()"/>';
		var val_precioObjObligatorio= '<xsl:value-of select="document($doc)/translation/texts/item[@name='aviso_no_cumple_precio_objetivo_comp']/node()"/>';
		
		var val_faltaUnidades		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_unidades']/node()"/>';
		var val_malUnidades		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_unidades']/node()"/>';
		var val_malEnteroUnidades	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_entero_unidades']/node()"/>';
		var val_notZeroUnidades	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_no_cero_unidades']/node()"/>';
		var val_faltaRefProv		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_ref_proveedor']/node()"/>';
		var val_igualesRefProv		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='duplicada_ref_proveedor']/node()"/>';
		var conf_estaSeguro		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='esta_seguro']/node()"/>';
		var val_PrecioProvGrande	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='alert_precios_prov']/node()"/>';
		var conf_CentrosPendientesInformar	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='centros_pendientes_informar']/node()"/>';
		<!-- FIN Mensajes JS para validacion de formularios -->

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
		var str_FichaSeguridad	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='ficha_seguridad']/node()"/>';
		var str_TotalConsCIVA		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='total_cIVA']/node()"/>';
		var str_TotalConsSIVA		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='total_sIVA']/node()"/>';
		var str_PorcNegociado		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='porcentage_negociado']/node()"/>';
		var str_PorcAhorro			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='porcentage_ahorro']/node()"/>';
		var str_ProdsSinOferta	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='num_productos_sin_oferta']/node()"/>';
		var str_ProdsSinOfertaConAhorro	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='num_productos_sin_oferta_con_ahorro']/node()"/>';
		<!-- Strings para tabla productos PROVE -->
		var str_SinOfertar	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_ofertar']/node()"/>';
		var str_SubirDoc	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_documento']/node()"/>';
		<!--var str_SubirFicha	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_ficha']/node()"/>';
		var str_SubirRegSan	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_reg_sanitario']/node()"/>';-->
		var str_DocCargado	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/>';
		var str_Guardar			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>';
		var str_Alternativa		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='alternativa']/node()"/>';
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
		<!-- Strings para tabla usuarios -->
		var str_Autor			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/>';
		var str_SinUsuarios		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion_sin_usuarios']/node()"/>';
		<!-- Strings para tabla centros -->
		var str_SinCentros		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion_sin_centros']/node()"/>';
		var str_TituloTablaCentrosProv		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='titulo_tabla_centros_prov']/node()"/>';
		var str_NoAdjudicado		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='no_adjudicado']/node()"/>';
		var str_VerDoc		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Ver_doc']/node()"/>';
		<!-- 2feb23 Strings nuevos campos OHSJD-->
		var str_CodExpediente= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cod_Expediente']/node()"/>';
		var str_CodCUM		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cod_CUM']/node()"/>';
		var str_CodIUM		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cod_IUM']/node()"/>';
		<!--20feb23	-->
		var str_CodInvima	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cod_Invima']/node()"/>';
		var str_RegSanitario	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='reg_sanitario']/node()"/>';
		var str_FechaLimiteInvima= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_Limite']/node()"/>';
		var str_ClasRiesgo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Clas_Riesgo']/node()"/>';

		<!-- Alerts para tabla 'Condiciones Licitacion' -->
		var alrt_ModFechaDecisionOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='modificar_fecha_decision_ok']/node()"/>';
		var alrt_ModFechaDecisionKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='modificar_fecha_decision_error']/node()"/>';
		var alrt_ModFechasRealesOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='modificar_fechas_reales_ok']/node()"/>';
		var alrt_ModFechasRealesKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='modificar_fechas_reales_error']/node()"/>';
		var alrt_RenovarLicOK		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='confirm_renovar_licitacion']/node()"/>';
		var alrt_RenovarLicKO		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_renovar_licitacion']/node()"/>';
		var alrt_GenerarPedidoOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='success_generar_pedido']/node()"/>';
		var alrt_LicitacionHijaOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='success_crear_licitacion_hija']/node()"/>';
		var alrt_LicitacionHijaKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_crear_licitacion_hija']/node()"/>';
		<!-- Alerts para tabla productos -->
		var alrt_ProdsActualizadosOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='success_productos_actualizados']/node()"/>';
		var alrt_ProdsActualizadosKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_productos_actualizados']/node()"/>';
		var alrt_errorNuevosProductos	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_nuevos_productos']/node()"/>';
		var alrt_errorEliminarProduct	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_eliminar_producto']/node()"/>';
		var alrt_errorDescargaFichero	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_descarga_fichero']/node()"/>';
		var alrt_prodsPrecioRefVacio	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='productos_precioref_vacio']/node()"/>';
		var alrt_errSinOfertaSelec	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_sin_oferta_seleccionada']/node()"/>';
		var alrt_guardarSeleccionAdjOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_selecc_adjudica_ok']/node()"/>';
		var alrt_guardarSeleccionAdjKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_selecc_adjudica_ko']/node()"/>';
		var alrt_guardarAdjudicacionOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_adjudica_ok']/node()"/>';
		var alrt_guardarAdjudicacionKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_adjudica_ko']/node()"/>';
		var alrt_faltaSeleccProductos	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='revisa_seleccion_productos']/node()"/>';
		var alrt_sinProductosSeleccionados	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_productos_seleccionados']/node()"/>';
		var alrt_SeleccionadosYOrden1	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='seleccionados_y_orden1']/node()"/>';
		var conf_adjudicar1		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='confirm_boton_adjudicar_1']/node()"/>';
		var conf_adjudicar2		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='confirm_boton_adjudicar_2']/node()"/>';
		var conf_hayCambios		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='confirm_se_han_producido_cambios']/node()"/>';
		var alrt_pedidoMinimoKO		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_validar_pedido_minimo']/node()"/>';
		var alrt_pedidoMinimoGlobalKO= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_validar_pedido_minimo_agr']/node()"/>';
		var conf_autoeditar_uds_x_lote	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='autoeditar_uds_x_lote']/node()"/>';
		var alrt_avisoCambioUnidades	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='aviso_cambio_uds_x_lote']/node()"/>';
		var alrt_CantsActualizadasOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='success_cantidades_actualizadas']/node()"/>';
		var alrt_CantsActualizadasKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_cantidades_actualizadas']/node()"/>';
		var alrt_PreciosObjCalculadosOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='success_calculo_precios_objetivo']/node()"/>';
		var alrt_CamposAvanzadosOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='success_guardar_campos_avanzados']/node()"/>';
		var alrt_CamposAvanzadosKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_guardar_campos_avanzados']/node()"/>';
		var alrt_BorrarDocumentoOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='success_borrar_documento']/node()"/>';
		var alrt_BorrarDocumentoKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_borrar_documento']/node()"/>';
		var alrt_UdBasicaNoInformada	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_udbasicanoinformada']/node()"/>';
		var alrt_CantidadCero	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_cantidad_cero']/node()"/>';

		var alrt_avisoBorrarProducto	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='aviso_borrar_producto_lic']/node()"/>';

		<!-- Alerts para tabla productos (lado proveedor) -->
		var alrt_errorNuevasOfertas	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_nuevas_ofertas']/node()"/>';
		var alrt_publicarOfertaOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='publicar_ofertas_ok']/node()"/>';
		var alrt_cancelarOfertaOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar_ofertas_ok']/node()"/>';
		var conf_CancelarOferta 	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Conf_cancelar_ofertas']/node()"/>';
		var alrt_AvisoOfertasActualizadas	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='aviso_ofertas_procesadas']/node()"/>';
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
		<!-- Alerts para tabla usuarios -->
		var alrt_UsuarioYaExiste	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_usuario_ya_existe']/node()"/>';
		var alrt_NuevoUsuarioKO		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_nuevo_usuario']/node()"/>';
		var alrt_EliminarUsuarioKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_eliminar_usuario']/node()"/>';
		var alrt_licitacionFirmada	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cliente_firma_licitacion']/node()"/>';
		<!-- Alerts para tabla centros -->
		var alrt_CentroYaExiste	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_centro_ya_existe']/node()"/>';
		var alrt_NuevoCentroKO		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_nuevo_centro']/node()"/>';
		var alrt_EliminarCentroKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_eliminar_centro']/node()"/>';

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

		var alrt_guardarDatosInformeOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='confirm_guardar_datos_informe']/node()"/>';
		var alrt_guardarDatosInformeKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_guardar_datos_informe']/node()"/>';

		var alrt_borrarTodosProductos	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='seguro_borrar_todos_productos']/node()"/>';
		var alrt_borrarTodosProveedores	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='seguro_borrar_todos_proveedores']/node()"/>';
		var str_BorrarProductos	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_productos']/node()"/>';
		var alrt_AgregarLicitacion	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='seguro_agregar_licitacion']/node()"/>';
		var strUltimaOferta	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='datos_ultima_oferta']/node()"/>';
		var str_AyudaGuardarOferta	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='ayuda_guardar_oferta']/node()"/>';
		var str_AyudaOfertaAlternativa	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='ayuda_oferta_alternativa']/node()"/>';
		var str_AyudaBorrarOferta	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='ayuda_borrar_oferta']/node()"/>';
		
		var txtBotonPublicar	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='publicar_oferta']/node()"/>';
		var alrt_avisoSaltarPedidoMinimo= '<xsl:value-of select="document($doc)/translation/texts/item[@name='aviso_saltar_pedido_minimo']/node()"/>';
		var alrt_avisoEstadoContrato= '<xsl:value-of select="document($doc)/translation/texts/item[@name='aviso_estado_contrato']/node()"/>';
		var alrt_noSePuedeAbrirDocumento= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_no_se_ha_podido_abrir_documento']/node()"/>';
		var str_AvisoInformarPrecioCaja= '<xsl:value-of select="document($doc)/translation/texts/item[@name='aviso_informar_precio_caja']/node()"/>';
		var	strConfirmarPedido='<xsl:value-of select="document($doc)/translation/texts/item[@name='Seguro_enviar_pedido']/node()"/>';
		var	strConfirmarPedidoConCircuito='<xsl:value-of select="document($doc)/translation/texts/item[@name='Seguro_enviar_pedido_con_circuito']/node()"/>';
		var	alrt_fechaEntregaPedidoAnteriorAFechaDeHoy='<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_entrega_pedido_anterior']/node()"/>';
		var alrt_avisoDescargarOC= '<xsl:value-of select="document($doc)/translation/texts/item[@name='aviso_descargar_OC']/node()"/>';
		var	alrt_faltaDocumentoObligatorio='<xsl:value-of select="document($doc)/translation/texts/item[@name='Falta_documento_obligatorio']/node()"/>';
		var	alrt_faltaFTObligatoria='<xsl:value-of select="document($doc)/translation/texts/item[@name='Falta_FT_obligatoria']/node()"/>';
		var	alrt_faltaRSObligatorio='<xsl:value-of select="document($doc)/translation/texts/item[@name='Falta_RS_obligatorio']/node()"/>';
		var	alrt_faltaCodRSObligatorio='<xsl:value-of select="document($doc)/translation/texts/item[@name='Falta_Cod_RS_obligatorio']/node()"/>';
		var	alrt_faltaCEObligatorio='<xsl:value-of select="document($doc)/translation/texts/item[@name='Falta_CE_obligatorio']/node()"/>';
		var	alrt_faltaFSObligatoria='<xsl:value-of select="document($doc)/translation/texts/item[@name='Falta_FS_obligatoria']/node()"/>';
		var	alrt_noCumplePrecioObjetivo='<xsl:value-of select="document($doc)/translation/texts/item[@name='Aviso_no_cumple_precio_objetivo']/node()"/>';
		var	alrt_NoEsResponsable='<xsl:value-of select="document($doc)/translation/texts/item[@name='Aviso_otro_usuario_responsable']/node()"/>';
		var	alrt_faltanCamposColObligatorios='<xsl:value-of select="document($doc)/translation/texts/item[@name='Faltan_CamposCol_obligatorios']/node()"/>';
		var	alrt_fechaIncorrecta='<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_incorrecta']/node()"/>';
		var	str_IncluyendoProvs='<xsl:value-of select="document($doc)/translation/texts/item[@name='Incluyendo_proveedores']/node()"/>';
		
		var strContrato='<xsl:value-of select="document($doc)/translation/texts/item[@name='CONTRATO']/node()"/>';
		var strPrincActivo='<xsl:value-of select="document($doc)/translation/texts/item[@name='Princ_activo']/node()"/>';

		<!-- 27abr23 Programacion de entregas	-->
		var str_ProgEntregas= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Programacion_de_entregas']/node()"/>';	
		var strCantidad		='<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/>';
		var strProveedor	='<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>';
		var strMarca		='<xsl:value-of select="document($doc)/translation/texts/item[@name='lic_marca']/node()"/>';
		var strUdesLote		='<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_por_lote']/node()"/>';

		var arrProveedores	= new Array();	//	Vacio. Para evitar errores de JS
		var arrProductos	= new Array();
		<!--
		
			VENDEDOR
		
		-->
		var IDProveedorIni	= '<xsl:value-of select="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_IDPROVEEDOR"/>';
		var IDEstadoProveedor	= '<xsl:value-of select="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_IDESTADO"/>';
		var ofertaProvInformada	= '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/TODOS_INFORMADOS">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		var ofertaVacia ='<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/NINGUNO_INFORMADO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		var pedidoMinimoInform	= '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_PEDIDOMINIMO != ''">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		var IDLicProveedor	= '<xsl:value-of select="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_ID"/>';
		var IDUsuarioCliente	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_IDUSUARIO"/>';
		var NombreCliente	= '<xsl:value-of select="/Mantenimiento/LICITACION/EMPRESALICITACION/NOMBRE"/>';
		var numOfertas	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_PROV_NUMEROLINEAS"/>';
		var docObligatorio	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_DOCUMENTOOBLIGATORIO"/>';
		var incluirRS	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_INCLUIR_REGSANITARIO"/>';		//	Este sirve para indicar tambien que hay que informar CodCum, CodIum, etc
		var incluirCE	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_INCLUIR_CERTEXPER"/>';
		var incluirFS	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_INCLUIR_FICHASEGURIDAD"/>';
		var FTObligatoria	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_FT_OBLIGATORIA"/>';
		var RSObligatorio	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_RS_OBLIGATORIO"/>';
		var CEObligatorio	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CE_OBLIGATORIO"/>';
		var FSObligatoria	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_FS_OBLIGATORIA"/>';
		var NombreVendedor	= '<xsl:value-of select="/Mantenimiento/LICITACION/USUARIO_PROVEEDOR"/>';
		var ofertaBloqueada	= '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/BLOQUEADA_POR_OTRO_USUARIO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		var mostrarPrecioObj= '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/MOSTRAR_PRECIO_OBJETIVO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';		//16dic21

		debug('LicProvedor Inicio. incluirRS:'+incluirRS+' incluirCE:'+incluirCE+' incluirFS:'+incluirFS+' docObligatorio:'+docObligatorio+' FTObligatoria:'+FTObligatoria
						+' RSObligatorio:'+RSObligatorio+' CEObligatorio:'+CEObligatorio+' FSObligatoria:'+FSObligatoria
						+' NombreVendedor:'+NombreVendedor+' ofertaBloqueada:'+ofertaBloqueada
						+' mostrarPrecioObj:'+mostrarPrecioObj);
		
		var numProveedoresActivos	= 0;

		var arrTiposIva	= new Array();
		<xsl:for-each select="/Mantenimiento/LICITACION/TIPOSIVA/field/dropDownList/listElem">
			var items		= [];
			items['Tipo']		= '<xsl:value-of select="ID"/>';
			arrTiposIva.push(items);
		</xsl:for-each>


		var arrFichasTecnicas	= new Array();
		<xsl:for-each select="/Mantenimiento/LICITACION/FICHAS_TECNICAS/field/dropDownList/listElem">
			var items		= [];
			items['ID']		= '<xsl:value-of select="ID"/>';
			items['listItem']	= '<xsl:value-of select="listItem"/>';
			items['URL']	= '<xsl:value-of select="URL"/>';

			arrFichasTecnicas.push(items);
		</xsl:for-each>

		var arrRegSanitario	= new Array();
		<xsl:for-each select="/Mantenimiento/LICITACION/REGISTROS_SANITARIOS/field/dropDownList/listElem">
			var items		= [];
			items['ID']		= '<xsl:value-of select="ID"/>';
			items['listItem']	= '<xsl:value-of select="listItem"/>';
			items['URL']	= '<xsl:value-of select="URL"/>';

			arrRegSanitario.push(items);
		</xsl:for-each>

		var arrCertExperiencia	= new Array();
		<xsl:for-each select="/Mantenimiento/LICITACION/CERTIFICADOS_EXPERIENCIA/field/dropDownList/listElem">
			var items		= [];
			items['ID']		= '<xsl:value-of select="ID"/>';
			items['listItem']	= '<xsl:value-of select="listItem"/>';
			items['URL']	= '<xsl:value-of select="URL"/>';

			arrCertExperiencia.push(items);
		</xsl:for-each>

		var arrFichaSeguridad	= new Array();
		<xsl:for-each select="/Mantenimiento/LICITACION/FICHAS_SEGURIDAD/field/dropDownList/listElem">
			var items		= [];
			items['ID']		= '<xsl:value-of select="ID"/>';
			items['listItem']	= '<xsl:value-of select="listItem"/>';
			items['URL']	= '<xsl:value-of select="URL"/>';

			arrFichaSeguridad.push(items);
		</xsl:for-each>

		<xsl:for-each select="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PRODUCTO">
			var items		= [];
			items['linea']		= '<xsl:value-of select="LINEA"/>';
			items['IDProdLic']	= '<xsl:value-of select="LIC_PROD_ID"/>';
			items['IDProd']		= '<xsl:value-of select="LIC_PROD_IDPRODESTANDAR"/>';
			items['RefEstandar']= '<xsl:value-of select="LIC_PROD_REFESTANDAR"/>';
			items['RefCliente']	= '<xsl:value-of select="LIC_PROD_REFCLIENTE"/>';
			items['Nombre']		= "<xsl:value-of select="LIC_PROD_NOMBRE_JS"/>";
			items['NombreNorm']	= '<xsl:value-of select="PROD_NOMBRENORM"/>';
			items['UdBasica']	= '<xsl:value-of select="LIC_PROD_UNIDADBASICA"/>';
			items['FechaAlta']	= '<xsl:value-of select="LIC_PROD_FECHAALTA"/>';
			items['FechaMod']	= '<xsl:value-of select="LIC_PROD_FECHAMODIFICACION"/>';
			items['Consumo']	= '<xsl:value-of select="LIC_PROD_CONSUMO"/>';
			items['ConsumoIVA']	= '<xsl:value-of select="LIC_PROD_CONSUMOIVA"/>';
			items['Cantidad']	= '<xsl:value-of select="LIC_PROD_CANTIDAD"/>';
			items['PrecioHist']	= '<xsl:value-of select="LIC_PROD_PRECIOREFERENCIA"/>';
			items['PrecioObj']	= '<xsl:value-of select="LIC_PROD_PRECIOOBJETIVO"/>';
			items['TipoIVA']	= '<xsl:value-of select="LIC_PROD_TIPOIVA"/>';
			items['Ordenacion']	= '0';
			items['PrecioMin']	= '<xsl:value-of select="PRECIOMIN"/>';
			items['PrecioMax']	= '<xsl:value-of select="PRECIOMAX"/>';
			items['NumAlternativas']= '<xsl:value-of select="NUMALTERNATIVAS"/>';
			items['NumOfertas']= '<xsl:value-of select="LIC_PROD_NUMEROOFERTAS"/>';
			items['Marcas']= "<xsl:value-of select="LIC_PROD_MARCASACEPTABLES"/>";						//	17jul23 utilizamos comilla doble, dentro puede venir comilla simple
			items['PrincActivo']= '<xsl:value-of select="LIC_PROD_PRINCIPIOACTIVO"/>';
			items['OfertaAnterior']	= '<xsl:choose><xsl:when test="OFERTA_ANTERIOR">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
			items['ForzarCaja']	= '<xsl:choose><xsl:when test="FORZAR_CAJA">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
			items['Entregas']	= '<xsl:value-of select="LIC_PROD_ENTREGAS"/>';		//27abr23 Nueva funcionalidad de programacion de entregas

			<!-- Campos Avanzados producto -->
			items['InfoAmpliada']	= "<xsl:copy-of select="LIC_PROD_INFOAMPLIADA_JS/node()"/>";
			items['Documento']	= [];
			<xsl:if test="DOCUMENTOPRODUCTO">
				items['Documento']['ID']		= '<xsl:value-of select="DOCUMENTOPRODUCTO/ID"/>';
				items['Documento']['Nombre']		= '<xsl:value-of select="DOCUMENTOPRODUCTO/NOMBRE"/>';
				items['Documento']['Descripcion']	= '<xsl:value-of select="DOCUMENTOPRODUCTO/DESCRIPCION"/>';
				items['Documento']['Url']		= '<xsl:value-of select="DOCUMENTOPRODUCTO/URL"/>';
				items['Documento']['Fecha']		= '<xsl:value-of select="DOCUMENTOPRODUCTO/FECHA"/>';
			</xsl:if>
			<!-- FIN Campos Avanzados producto -->

			items['ConsumoOferta']	= '<xsl:value-of select="LIC_OFE_CONSUMO"/>';

			items['Oferta']	= [];
			items['Oferta']['ID']		= '<xsl:value-of select="LIC_OFE_ID"/>';
			items['Oferta']['Alternativa']= '<xsl:value-of select="LIC_OFE_ALTERNATIVA"/>';
			items['Oferta']['IDProvLic']	= '<xsl:value-of select="LIC_OFE_IDPROVEEDORLIC"/>';
			items['Oferta']['IDProducto']	= '<xsl:value-of select="LIC_OFE_IDPRODUCTO"/>';
			items['Oferta']['RefProv']	= '<xsl:value-of select="LIC_OFE_REFERENCIA"/>';
			items['Oferta']['Nombre']	= '<xsl:value-of select="LIC_OFE_NOMBRE"/>';
			items['Oferta']['Marca']	= '<xsl:value-of select="LIC_OFE_MARCA"/>';
			items['Oferta']['FechaAlta']	= '<xsl:value-of select="LIC_OFE_FECHAALTA"/>';
			items['Oferta']['FechaMod']	= '<xsl:value-of select="LIC_OFE_FECHAMODIFICACION"/>';
			items['Oferta']['UdsXLote']	= '<xsl:value-of select="LIC_OFE_UNIDADESPORLOTE"/>';
			items['Oferta']['Cantidad']	= '<xsl:value-of select="LIC_OFE_CANTIDAD"/>';
			items['Oferta']['Precio']	= '<xsl:value-of select="LIC_OFE_PRECIO"/>';
			items['Oferta']['TipoIVA']	= '<xsl:value-of select="LIC_OFE_TIPOIVA"/>';
			items['Oferta']['Consumo']	= '<xsl:value-of select="LIC_OFE_CONSUMO"/>';
			items['Oferta']['ConsumoIVA']	= '<xsl:value-of select="LIC_OFE_CONSUMOIVA"/>';
			items['Oferta']['IDEstadoEval']	= '<xsl:value-of select="LIC_OFE_IDESTADOEVALUACION"/>';
			items['Oferta']['EstadoEval']	= '<xsl:value-of select="ESTADOEVALUACION"/>';
			items['Oferta']['ProdAdjudicado']	= '<xsl:value-of select="LIC_OFE_PORPRODUCTOADJUDICADO"/>';

			<!-- Campos Avanzados oferta -->
			items['Oferta']['InfoAmpliada']	= "<xsl:copy-of select="LIC_OFE_INFOAMPLIADA_JS/node()"/>";
			items['Oferta']['Documento']	= [];
			<xsl:if test="DOCUMENTOOFERTA">
				items['Oferta']['Documento']['ID']		= '<xsl:value-of select="DOCUMENTOOFERTA/ID"/>';
				items['Oferta']['Documento']['Nombre']		= '<xsl:value-of select="DOCUMENTOOFERTA/NOMBRE"/>';
				items['Oferta']['Documento']['Descripcion']	= '<xsl:value-of select="DOCUMENTOOFERTA/DESCRIPCION"/>';
				items['Oferta']['Documento']['Url']		= '<xsl:value-of select="DOCUMENTOOFERTA/URL"/>';
				items['Oferta']['Documento']['Fecha']		= '<xsl:value-of select="DOCUMENTOOFERTA/FECHA"/>';
			</xsl:if>
			<!-- FIN Campos Avanzados oferta -->

			items['Oferta']['Informada']	= '<xsl:choose><xsl:when test="INFORMADA">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
			items['Oferta']['Adjudicada']	= '<xsl:choose><xsl:when test="OFERTA_ADJUDICADA">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';

			items['Oferta']['FichaTecnica']	= [];
			<xsl:if test="FICHA_TECNICA/ID">
				items['Oferta']['FichaTecnica']['ID']		= '<xsl:value-of select="FICHA_TECNICA/ID"/>';
				items['Oferta']['FichaTecnica']['Nombre']	= '<xsl:value-of select="FICHA_TECNICA/NOMBRE"/>';
				items['Oferta']['FichaTecnica']['Descripcion']	= '<xsl:value-of select="FICHA_TECNICA/DESCRIPCION"/>';
				items['Oferta']['FichaTecnica']['Url']		= '<xsl:value-of select="FICHA_TECNICA/URL"/>';
				items['Oferta']['FichaTecnica']['Fecha']	= '<xsl:value-of select="FICHA_TECNICA/FECHA"/>';
			</xsl:if>

			items['Oferta']['RegSanitario']	= [];
			<xsl:if test="REGISTRO_SANITARIO/ID">
				items['Oferta']['RegSanitario']['ID']		= '<xsl:value-of select="REGISTRO_SANITARIO/ID"/>';
				items['Oferta']['RegSanitario']['Nombre']	= '<xsl:value-of select="REGISTRO_SANITARIO/NOMBRE"/>';
				items['Oferta']['RegSanitario']['Descripcion']	= '<xsl:value-of select="REGISTRO_SANITARIO/DESCRIPCION"/>';
				items['Oferta']['RegSanitario']['Url']		= '<xsl:value-of select="REGISTRO_SANITARIO/URL"/>';
				items['Oferta']['RegSanitario']['Fecha']	= '<xsl:value-of select="REGISTRO_SANITARIO/FECHA"/>';
			</xsl:if>

			items['Oferta']['CodRegistroSanitario']	= '<xsl:value-of select="LIC_OFE_REGISTROSANITARIO"/>';
			items['Oferta']['CodExpediente']	= '<xsl:value-of select="LIC_OFE_CODEXPEDIENTE"/>';				//	INICIO Nuevos campos 2feb23
			items['Oferta']['CodCum']	= '<xsl:value-of select="LIC_OFE_CODCUM"/>';
			items['Oferta']['CodIum']	= '<xsl:value-of select="LIC_OFE_CODIUM"/>';
			items['Oferta']['CodInvima']	= '<xsl:value-of select="LIC_OFE_CODINVIMA"/>';
			items['Oferta']['FechaCadInvima']	= '<xsl:value-of select="LIC_OFE_FECHACADINVIMA"/>';
			items['Oferta']['ClasRiesgo']	= '<xsl:value-of select="LIC_OFE_CLASIFICACIONRIESGO"/>';			//	FIN Nuevos campos 2feb23

			items['Oferta']['CertExperiencia']	= [];
			<xsl:if test="CERTIFICADO_EXPERIENCIA/ID">
				items['Oferta']['CertExperiencia']['ID']		= '<xsl:value-of select="CERTIFICADO_EXPERIENCIA/ID"/>';
				items['Oferta']['CertExperiencia']['Nombre']	= '<xsl:value-of select="CERTIFICADO_EXPERIENCIA/NOMBRE"/>';
				items['Oferta']['CertExperiencia']['Descripcion']	= '<xsl:value-of select="CERTIFICADO_EXPERIENCIA/DESCRIPCION"/>';
				items['Oferta']['CertExperiencia']['Url']		= '<xsl:value-of select="CERTIFICADO_EXPERIENCIA/URL"/>';
				items['Oferta']['CertExperiencia']['Fecha']	= '<xsl:value-of select="CERTIFICADO_EXPERIENCIA/FECHA"/>';
			</xsl:if>

			items['Oferta']['FichaSeguridad']	= [];
			<xsl:if test="FICHA_SEGURIDAD/ID">
				items['Oferta']['FichaSeguridad']['ID']		= '<xsl:value-of select="FICHA_SEGURIDAD/ID"/>';
				items['Oferta']['FichaSeguridad']['Nombre']	= '<xsl:value-of select="FICHA_SEGURIDAD/NOMBRE"/>';
				items['Oferta']['FichaSeguridad']['Descripcion']	= '<xsl:value-of select="FICHA_SEGURIDAD/DESCRIPCION"/>';
				items['Oferta']['FichaSeguridad']['Url']		= '<xsl:value-of select="FICHA_SEGURIDAD/URL"/>';
				items['Oferta']['FichaSeguridad']['Fecha']	= '<xsl:value-of select="FICHA_SEGURIDAD/FECHA"/>';
			</xsl:if>

			items['Oferta']['Anterior']	= [];
			<xsl:if test="OFERTA_ANTERIOR">
				items['Oferta']['Anterior']['IDLicitacion']		= '<xsl:value-of select="OFERTA_ANTERIOR/LIC_ID"/>';
				items['Oferta']['Anterior']['Licitacion']		= '<xsl:value-of select="OFERTA_ANTERIOR/LIC_TITULO"/>';
				items['Oferta']['Anterior']['Referencia']		= '<xsl:value-of select="OFERTA_ANTERIOR/LIC_OFE_REFERENCIA"/>';
				items['Oferta']['Anterior']['Producto']		= '<xsl:value-of select="OFERTA_ANTERIOR/LIC_OFE_NOMBRE"/>';
				items['Oferta']['Anterior']['Marca']	= '<xsl:value-of select="OFERTA_ANTERIOR/LIC_OFE_MARCA"/>';
				items['Oferta']['Anterior']['UdesLote']		= '<xsl:value-of select="OFERTA_ANTERIOR/LIC_OFE_UNIDADESPORLOTE"/>';
				items['Oferta']['Anterior']['Precio']		= '<xsl:value-of select="OFERTA_ANTERIOR/LIC_OFE_PRECIO"/>';
				items['Oferta']['Anterior']['Fecha']		= '<xsl:value-of select="OFERTA_ANTERIOR/LIC_OFE_FECHAALTA"/>';
				items['Oferta']['Anterior']['Adjudicada']		= '<xsl:value-of select="OFERTA_ANTERIOR/LIC_OFE_ADJUDICADA"/>';
			</xsl:if>

			arrProductos.push(items);
		</xsl:for-each>

			var	strTitulosColumnasCSVProv= sepTextoCSV+'<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/>'+sepTextoCSV+sepCSV
									+	sepTextoCSV+'<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_mvm']/node()"/>'+sepTextoCSV+sepCSV
									+	sepTextoCSV+'<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>'+sepTextoCSV+sepCSV
									+	sepTextoCSV+'<xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/>'+sepTextoCSV+sepCSV
									+	sepTextoCSV+'<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>'+sepTextoCSV+sepCSV
									+	sepTextoCSV+'<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_por_lote']/node()"/>'+sepTextoCSV+sepCSV
									+	sepTextoCSV+'<xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>'+sepTextoCSV+sepCSV
									+	sepTextoCSV+'<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/>'+sepTextoCSV+sepCSV;

			var strComunicado='';
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/COMUNICADO">
				var IDComunicado=<xsl:value-of select="/Mantenimiento/LICITACION/COMUNICADO/ID"/>;
				var txtRechazoComunicado='<xsl:value-of select="/Mantenimiento/LICITACION/COMUNICADO/TEXTORECHAZO"/>';
				<xsl:for-each select="/Mantenimiento/LICITACION/COMUNICADO/LINEA">
					strComunicado+='<xsl:value-of select="TEXTO"/>';
				</xsl:for-each>
				strComunicado=strComunicado.replace(/\[\[BR\]\]/g,'\n');
				console.log('strComunicado:'+strComunicado);
			</xsl:when>
			<xsl:otherwise>
				var IDComunicado='';
			</xsl:otherwise>
			</xsl:choose>

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
						centro['IDCentro']	= '<xsl:value-of select="CEN_ID"/>';
						centro['Cantidad']	= '<xsl:value-of select="CANTIDAD_SINFORMATO"/>';
						centro['RefCentro']	= '<xsl:value-of select="REFCENTRO"/>';
						items['Centros'].push(centro);
					</xsl:for-each>
				</xsl:otherwise>
				</xsl:choose>
				arrProductosPorCentro.push(items);
			</xsl:for-each>
		</xsl:if>
		
	</script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/LicProveedor2022_250723.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/lic2022_060723.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Utilidades/Utilidades.js"></script>
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
		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
				<xsl:if test="/Mantenimiento/LICITACION/LIC_URGENTE = 'S'"><img src="http://www.newco.dev.br/images/2017/warning-red.png" class="urgente" title="{document($doc)/translation/texts/item[@name='urgente']/node()}"/>&nbsp;</xsl:if>
				<span class="fuentePeq inline h25px"><xsl:value-of select="/Mantenimiento/LICITACION/TITULO"/></span><br/>
				<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CODIGO"/>:&nbsp;<xsl:value-of select="substring(/Mantenimiento/LICITACION/LIC_TITULO,1,50)"/>
				<span class="CompletarTitulo" style="width:924px;">
					<!--<a class="btnNormal" href="javascript:history.go(-1);">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
					</a>
					&nbsp;-->
					<a class="btnNormal" style="text-decoration:none;">
						<xsl:attribute name="href">javascript:listadoExcelProv(<xsl:value-of select="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_ID"/>);</xsl:attribute>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/>
					</a>
					&nbsp;

					<!--	30nov16		-->
					<xsl:if test="/Mantenimiento/LICITACION/ROL = 'VENDEDOR' and /Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_IDESTADO != 'CURS'">
						<a class="btnNormal" id="botonImprimirOferta" href="javascript:imprimirOferta({/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_ID});">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir_oferta']/node()"/>
						</a>
						&nbsp;
					</xsl:if>
					<!--	12dic16		-->
					<xsl:if test="/Mantenimiento/LICITACION/ROL = 'VENDEDOR' and /Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_IDESTADO = 'CURS'">
						<a class="btnNormal" href="javascript:print();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir_oferta']/node()"/>
						</a>
						&nbsp;
					</xsl:if>
					<xsl:if test="/Mantenimiento/LICITACION/ROL = 'VENDEDOR'  and (/Mantenimiento/LICITACION/LIC_IDESTADO = 'INF' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'CURS') and (/Mantenimiento/LICITACION/LIC_PROV_NUMEROLINEAS>0)">
						<a class="btnDestacado" id="botonCancelarOferta" href="javascript:cancelarOferta();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='suspender_oferta']/node()"/>
						</a>
						&nbsp;
					</xsl:if>
					<xsl:if test="/Mantenimiento/LICITACION/BOTON_PUBLICAR">
						<a id="botonPublicarOferta" href="javascript:ValidarFormulario(document.forms['PublicarOfertas'],'provPublicarOferta');">
							<xsl:choose>
							<xsl:when test="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_PEDIDOMINIMO = '' and not(/Mantenimiento/LICITACION/PRODUCTOSLICITACION/NINGUNO_INFORMADO)">
								<xsl:attribute name="class">btnGris</xsl:attribute>
								<xsl:value-of select="document($doc)/translation/texts/item[@name='publicar_oferta']/node()"/>
							</xsl:when>
							<xsl:when test="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_PEDIDOMINIMO = '' or /Mantenimiento/LICITACION/PRODUCTOSLICITACION/NINGUNO_INFORMADO">
								<xsl:attribute name="class">btnDestacado</xsl:attribute>
								<xsl:value-of select="document($doc)/translation/texts/item[@name='publicar_sin_ofertas']/node()"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="class">btnDestacado</xsl:attribute>
								<xsl:value-of select="document($doc)/translation/texts/item[@name='publicar_oferta']/node()"/>
							</xsl:otherwise>
							</xsl:choose>
						</a>
						&nbsp;
					</xsl:if>
					<!-- cuando lici esta adjudicada, boton para el proveedor para firmarla -->
					<xsl:if test="/Mantenimiento/LICITACION/ROL = 'VENDEDOR' and /Mantenimiento/LICITACION/BOTON_FIRMA">
						<a class="btnDestacado" id="botonFirmarLici" href="javascript:modificaEstadoProveedor({/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_ID},'FIRM');">
							<xsl:attribute name="style">
								<xsl:choose>
								<xsl:when test="/Mantenimiento/LICITACION/LIC_IDESTADO = 'ADJ'">display:block;</xsl:when>
								<xsl:otherwise>display:none;</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>			
							<xsl:value-of select="document($doc)/translation/texts/item[@name='firmar_licitacion']/node()"/>
						</a>
						&nbsp;
					</xsl:if>
					<xsl:if test="/Mantenimiento/LICITACION/ROL = 'VENDEDOR'">
						<a class="btnDestacado" href="javascript:conversacionProveedor2(null);">
							<xsl:choose>
							<xsl:when test="/Mantenimiento/LICITACION/CONVERSACION">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='ver_conversacion']/node()"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="document($doc)/translation/texts/item[@name='escribe_mensaje_cliente']/node()"/>
							</xsl:otherwise>
							</xsl:choose>
						</a>
						&nbsp;
					</xsl:if>
				</span>
			</p>
		</div>
		<br/>
		<xsl:call-template name="Tabla_Datos_Generales"/>

		<xsl:if test="not(/Mantenimiento/NUEVALICITACION)">

		<!-- PESTANA PRODUCTOS -->
		<xsl:call-template name="Tabla_Productos_Proveedor"/>
		<!-- FIN PESTANA PRODUCTOS -->

	<xsl:if test="/Mantenimiento/LICITACION/ROL = 'VENDEDOR'">

	<!-- DIV Conversacion Proveedor -->
	<div class="overlay-container" id="convProveedor">
		<div class="window-container zoomout">
			<p><a href="javascript:showTabla(false);"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a></p>

			<p id="tableTitle">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='conversacion_con']/node()"/>&nbsp;<span id="NombreProv"></span>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='para']/node()"/>&nbsp;"<xsl:value-of select="/Mantenimiento/LICITACION/LIC_TITULO"/>"

				&nbsp;<a href="javascript:window.print();" style="text-decoration:none;">
					<img src="http://www.newco.dev.br/images/imprimir.gif">
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></xsl:attribute>
					</img>
				</a>
			</p>

			<div id="mensError" class="divLeft" style="display:none;">
				<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></strong></p>
			</div>

			<table id="viejosComentarios" border="0" style="width:100%;display:none;">
			<thead>
				<th colspan="5">&nbsp;</th>
			</thead>

			<tbody></tbody>

			</table>

			<form name="convProveedorForm" method="post" id="convProveedorForm">
			<input type="hidden" name="IDPROVEEDOR" id="IDPROVEEDOR"/>
			<input type="hidden" name="IDUSUARIOCLIENTE" id="/Mantenimiento/LICITACION/IDUSUARIOCLIENTE"/>
			<input type="hidden" name="IDUSUARIOPROV" id="IDUSUARIOPROV"/>

			<table id="nuevoComentario" style="width:100%;display:none;">
			<thead>
				<th colspan="3">&nbsp;</th>
			</thead>

			<tbody>
				<tr>
					<td class="dies"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='comentario']/node()"/>:</strong></td>
					<td colspan="2"><textarea name="LIC_MENSAJE" id="LIC_MENSAJE" rows="4" cols="70" style="float:left;"/></td>
				</tr>
			</tbody>

			<tfoot>
				<tr>
					<td>&nbsp;</td>
					<td>
						<div class="boton">
							<a href="javascript:guardarConversProv();">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
							</a>
						</div>
					</td>
					<td id="Respuesta" style="text-align:left;"></td>
				</tr>
			</tfoot>
			</table>
			</form>
		</div>
	</div><!-- FIN DIV Conversacion Proveedor -->

		</xsl:if>
	</xsl:if>


	<!-- 27abr23 DIV Programacion entregas -->
	<div class="overlay-container" id="progEntregas">
		<div class="window-container zoomout w1000px">
			<input type="hidden" id="progEntrPosProd" value=""/>
			<div class="divLeft h50px fondoGris textLeft">
				<br/>
					&nbsp;<span id="progEntrTitulo"></span>
					<span class="floatRight">
						<a class="btnNormal" href="javascript:showTabla(false);"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>&nbsp;
					</span>
				<br/>
			</div>

			<div class="divLeft w1000px">
				<br/>
				<p><span id="progEntrCant"></span></p>
				<br/>
			</div>

			<form name="convProveedorForm" method="post" id="convProveedorForm">
				<div class="tabela tabela_redonda">
				<table cellspacing="6px" cellpadding="6px" class="tableCenter w400px">
					<thead class="cabecalho_tabela">
					<tr>
						<th class="w1x"></th>
						<th class="textLeft w180px">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_entrega']/node()"/></th>
						<th class="textLeft w180px"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
						<th>&nbsp;</th>
					</tr>
					</thead>
					<!--	Cuerpo de la tabla	-->
					<tbody class="corpo_tabela">
						<xsl:for-each select="/Mantenimiento/LICITACION/ENTREGAS/POS">
							<tr>
								<td class="color_status"><xsl:value-of select="."/></td>
								<td class="textLeft"><input type="text" class="campopesquisa w150px fondoGrisClaro" id="dataEntr{.}" value="" disabled="disabled"/></td>
								<td class="textLeft"><input type="text" class="campopesquisa w150px fondoGrisClaro" id="cantEntr{.}" value="" disabled="disabled"/></td>
								<td>&nbsp;</td>
							</tr>
						</xsl:for-each>
					</tbody>
					<tfoot class="rodape_tabela">
						<tr><td colspan="12">&nbsp;</td></tr>
					</tfoot>
				</table><!--fin de infoTableAma-->
 				</div>
			</form>
		</div>
	</div>
	<!-- DIV Programacion entregas -->

	<div id="uploadFrameBox" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>
	<div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>

	</xsl:otherwise>
</xsl:choose>

</body>
</html>
</xsl:template>


<!-- template carga documentos (template compartido) -->
<!-- Se pueden subir fichas tecnicas (lado proveedor) => se informa campo en la tabla lic_productosofertas a partir del LIC_PROD_ID (LicProdID) -->
<!-- Tambien se pueden subir contratos/ofertas (autor de la licitacion) => se informa campo en la tabla licitaciones a partir del LIC_ID (LicID) -->
<xsl:template name="CargaDocumentos">
	<xsl:param name="tipo"/>
	<xsl:param name="LicProdID"/>
	<xsl:param name="LicID"/>
	<xsl:param name="nombre_corto"/>

	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/Mantenimiento/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:variable name="valueID">
		<xsl:choose>
		<xsl:when test="$LicProdID != ''"><xsl:value-of select="$LicProdID"/></xsl:when>
		<xsl:when test="$LicID != ''"><xsl:value-of select="$LicID"/></xsl:when>
		</xsl:choose>
	</xsl:variable>

	<div id="cargaDoc{$tipo}">
		<xsl:attribute name="class">
			<xsl:choose>
			<xsl:when test="$LicProdID != ''">divLeft80</xsl:when>
			<xsl:otherwise>divLeft99</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>

		<!--tabla imagenes y documentos-->
		<table class="infoTable" border="0">
			<tr>
				<!-- solo mostramos este tr en el caso de fichas tecnicas -->
				<xsl:if test="$LicProdID != ''">
				<!--documentos-->
				<td class="labelRight quince">
					<span class="text{$tipo}_{$valueID}">
						<xsl:choose>
						<xsl:when test="$nombre_corto != ''">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_oferta']/node()"/>&nbsp;<xsl:value-of select="$nombre_corto"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_ficha']/node()"/>
						</xsl:otherwise>
						</xsl:choose>
       	  </span>
				</td>
				</xsl:if>

				<td class="textLeft trenta">
					<div class="altaDocumento">
						<span class="anadirDoc">
							<xsl:call-template name="documentos">
								<xsl:with-param name="num" select="number(1)"/>
								<xsl:with-param name="LicProdID" select="$LicProdID"/>
								<xsl:with-param name="type" select="$tipo"/>
								<xsl:with-param name="LicID" select="$LicID"/>
							</xsl:call-template>
						</span>
					</div>
				</td>

				<td class="veinte">
					<div class="botonLargo">
						<a href="javascript:cargaDoc(document.forms['ProductosProveedor'],'{$tipo}','{$LicProdID}');">
							<xsl:choose>
							<xsl:when test="$LicProdID != ''">
								<xsl:attribute name="href">
									<xsl:text>javascript:cargaDoc(document.forms['ProductosProveedor'],'</xsl:text><xsl:value-of select="$tipo"/><xsl:text>','</xsl:text><xsl:value-of select="$LicProdID"/><xsl:text>');</xsl:text>
								</xsl:attribute>
							</xsl:when>
							<xsl:when test="$LicID != ''">
								<xsl:attribute name="href">
									<xsl:text>javascript:cargaDoc(document.forms['SubirContrato'],'</xsl:text><xsl:value-of select="$tipo"/><xsl:text>','</xsl:text><xsl:value-of select="$LicID"/><xsl:text>');</xsl:text>
								</xsl:attribute>
							</xsl:when>
							</xsl:choose>

							<span class="text{$tipo}">
								<xsl:choose>
								<xsl:when test="$LicProdID != ''">
									<xsl:choose>
									<xsl:when test="$nombre_corto != ''">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_oferta']/node()"/>&nbsp;<xsl:value-of select="$nombre_corto"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_ficha']/node()"/>
									</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:when test="$LicID != ''">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_contrato']/node()"/>
								</xsl:when>
								</xsl:choose>
                                                        </span>
						</a>
					</div>
				</td>
				<td>
                    <div id="waitBoxDoc_{$valueID}" align="center">&nbsp;</div>
                    <div id="confirmBox_{$valueID}" style="display:none;" align="center">
                    	<span class="cargado" style="font-size:10px;">¡<xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/>!</span>
                    </div>
                </td>
			</tr>
		</table><!--fin de tabla imagenes doc-->
	</div><!--fin de divleft-->

</xsl:template><!--fin de template carga documentos-->


<!--documentos-->
<xsl:template name="documentos">
	<xsl:param name="num" />
	<xsl:param name="type"/>
	<xsl:param name="LicProdID"/>
	<xsl:param name="LicID"/>

	<xsl:variable name="valueID">
		<xsl:choose>
		<xsl:when test="$LicProdID != ''"><xsl:value-of select="$LicProdID"/></xsl:when>
		<xsl:when test="$LicID != ''"><xsl:value-of select="$LicID"/></xsl:when>
		</xsl:choose>
	</xsl:variable>

	<xsl:choose>
	<xsl:when test="$num &lt; number(5)">
		<div class="docLine" id="docLine_{$valueID}">
			<div class="docLongEspec" id="docLongEspec_{$valueID}">
				<input id="inputFileDoc_{$valueID}" name="inputFileDoc" type="file" onChange="addDocFile('{$valueID}');" />
			</div>
		</div>
	</xsl:when>
	</xsl:choose>
</xsl:template>
<!--fin de documentos-->

</xsl:stylesheet>
