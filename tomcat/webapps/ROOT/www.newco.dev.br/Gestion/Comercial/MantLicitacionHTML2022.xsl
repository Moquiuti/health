<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Página principal de la licitación
	Actualizacion javascript lic2022_060423.js lic_proveedor2022_031022.js
	Ultima revisión: ET 03oct22 15:40
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:import href="http://www.newco.dev.br/Gestion/Comercial/LicGeneralTemplates2022.xsl"/>
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
		var val_precioObjObligatorio= '<xsl:value-of select="document($doc)/translation/texts/item[@name='aviso_no_cumple_precio_objetivo']/node()"/>';
		
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
		var str_TotalConsCIVA		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='total_cIVA']/node()"/>';
		var str_TotalConsSIVA		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='total_sIVA']/node()"/>';
		var str_PorcNegociado		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='porcentage_negociado']/node()"/>';
		var str_PorcAhorro			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='porcentage_ahorro']/node()"/>';
		var str_ProdsSinOferta	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='num_productos_sin_oferta']/node()"/>';
		var str_ProdsSinOfertaConAhorro	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='num_productos_sin_oferta_con_ahorro']/node()"/>';
		<!-- Strings para tabla productos PROVE -->
		var str_SinOfertar	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_ofertar']/node()"/>';
		var str_SubirFicha	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_ficha']/node()"/>';
		var str_SubirRegSan	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_reg_sanitario']/node()"/>';
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
		var alrt_AvisoOfertasActualizadas	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='aviso_ofertas_procesadas']/node()"/>';
		var conf_CancelarOferta 	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Conf_cancelar_ofertas']/node()"/>';
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
		var	alrt_noCumplePrecioObjetivo='<xsl:value-of select="document($doc)/translation/texts/item[@name='Aviso_no_cumple_precio_objetivo']/node()"/>';
		var	alrt_NoEsResponsable='<xsl:value-of select="document($doc)/translation/texts/item[@name='Aviso_otro_usuario_responsable']/node()"/>';
		var	str_IncluyendoProvs='<xsl:value-of select="document($doc)/translation/texts/item[@name='Incluyendo_proveedores']/node()"/>';
		
		var strContrato='<xsl:value-of select="document($doc)/translation/texts/item[@name='CONTRATO']/node()"/>';
		var strPrincActivo='<xsl:value-of select="document($doc)/translation/texts/item[@name='Princ_activo']/node()"/>';

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
				ColumnaOrdenadaProvs	= [];
		


		<xsl:for-each select="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PROVEEDORESLICITACION/PROVEEDOR">
			var items		= [];
			items['columna']	= '<xsl:value-of select="COLUMNA"/>';
			items['IDProvLic']	= '<xsl:value-of select="IDPROVEEDOR_LIC"/>';
			items['IDProveedor']	= '<xsl:value-of select="IDPROVEEDOR"/>';
			items['PedidoMin']	= '<xsl:value-of select="LIC_PROV_PEDIDOMINIMO"/>';
			items['NombreCorto']	= '<xsl:value-of select="NOMBRECORTO"/>';
			items['TieneOfertas']	= '<xsl:choose><xsl:when test="TIENE_OFERTAS">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';

			items['Consumo']	= '<xsl:value-of select="LIC_PROV_CONSUMO"/>';
			items['ConsumoIVA']	= '<xsl:value-of select="LIC_PROV_CONSUMOIVA"/>';
			items['ConsumoPot']	= '<xsl:value-of select="LIC_PROV_CONSUMOPOTENCIAL"/>';
			items['ConsumoPotIVA']	= '<xsl:value-of select="LIC_PROV_CONSUMOPOTENCIALIVA"/>';
			items['ConsumoAdj']	= '<xsl:value-of select="LIC_PROV_CONSUMOADJUDICADO"/>';
			items['ConsumoAdjIVA']	= '<xsl:value-of select="LIC_PROV_CONSUMOADJUDICADOIVA"/>';

			items['Ahorro']		= '<xsl:value-of select="LIC_PROV_AHORRO"/>';
			items['AhorroIVA']	= '<xsl:value-of select="LIC_PROV_AHORROIVA"/>';

			items['OfertasAdj']	= '<xsl:value-of select="LIC_PROV_OFERTASADJUDICADAS"/>';
			<!-- Variable auxiliar que nos permite modificar su valor al vuelo cuando se hacen cambios en el DOM sin perder el valor guardado en la BBDD -->
			<!--items['OfertasAdjAux']	= '<xsl:value-of select="LIC_PROV_OFERTASADJUDICADAS"/>';-->
			items['CumplePedMinimo']	= 'S';					//	22jul18

			arrConsumoProvs.push(items);
		</xsl:for-each>

		<xsl:for-each select="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PRODUCTO">
			var items = [];
			items['linea']		= '<xsl:value-of select="LINEA"/>';
			items['IDProdLic']	= '<xsl:value-of select="LIC_PROD_ID"/>';
			items['IDProd']		= '<xsl:value-of select="LIC_PROD_IDPRODESTANDAR"/>';
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
			items['TieneSeleccion']	= '<xsl:value-of select="TIENE_SELECCION"/>';
			items['Validado']	= '<xsl:choose><xsl:when test="VALIDADO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
			items['NoAdjudicado']	= '<xsl:choose><xsl:when test="NO_ADJUDICADO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
			items['Ordenacion']	= '0';
			items['ColSeleccionada']	= '-1';
			items['VariosProv']	= 'N';
			items['BloqPedidos']	= '<xsl:choose><xsl:when test="PRODUCTO_BLOQUEADO_POR_PEDIDOS">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
			items['Marcas']= '<xsl:value-of select="LIC_PROD_MARCASACEPTABLES"/>';
			items['PrincActivo']= '<xsl:value-of select="LIC_PROD_PRINCIPIOACTIVO"/>';

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
			
			arrProductos.push(items);
		</xsl:for-each>
		</xsl:when>
		<!--	2set21 sin estas declaraciones se produce un error	-->
		<!--	COMPRADOR SIN PRODUCTOS	-->
		<xsl:when test="count(/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PRODUCTO)= 0 and /Mantenimiento/LICITACION/ROL = 'COMPRADOR'">
			var numProdsSeleccion	= 0
			var arrConsumoProvs	= new Array();
		</xsl:when>
		<xsl:when test="/Mantenimiento/LICITACION/ROL = 'VENDEDOR'">
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
		var incluirRS	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_INCLUIR_REGSANITARIO"/>';
		var incluirCE	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_INCLUIR_CERTEXPER"/>';
		var FTObligatoria	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_FT_OBLIGATORIA"/>';
		var RSObligatorio	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_RS_OBLIGATORIO"/>';
		var CEObligatorio	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CE_OBLIGATORIO"/>';
		var NombreVendedor	= '<xsl:value-of select="/Mantenimiento/LICITACION/USUARIO_PROVEEDOR"/>';
		var ofertaBloqueada	= '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/BLOQUEADA_POR_OTRO_USUARIO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		var mostrarPrecioObj= '<xsl:choose><xsl:when test="/Mantenimiento/LICITACION/MOSTRAR_PRECIO_OBJETIVO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';							//16dic21

		debug('MantLicitacion. Inicio. incluirRS:'+incluirRS+' incluirCE:'+incluirCE+' docObligatorio:'+docObligatorio+' FTObligatoria:'+FTObligatoria
						+' RSObligatorio:'+RSObligatorio+' CEObligatorio:'+CEObligatorio+' NombreVendedor:'+NombreVendedor+' ofertaBloqueada:'+ofertaBloqueada
						+' mostrarPrecioObj:'+mostrarPrecioObj);
		
		var numProveedoresActivos	= 0;

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
			items['Marcas']= '<xsl:value-of select="LIC_PROD_MARCASACEPTABLES"/>';
			items['PrincActivo']= '<xsl:value-of select="LIC_PROD_PRINCIPIOACTIVO"/>';
			items['OfertaAnterior']	= '<xsl:choose><xsl:when test="OFERTA_ANTERIOR">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
			items['ForzarCaja']	= '<xsl:choose><xsl:when test="FORZAR_CAJA">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';

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

			items['Oferta']['CertExperiencia']	= [];
			<xsl:if test="CERTIFICADO_EXPERIENCIA/ID">
				items['Oferta']['CertExperiencia']['ID']		= '<xsl:value-of select="CERTIFICADO_EXPERIENCIA/ID"/>';
				items['Oferta']['CertExperiencia']['Nombre']	= '<xsl:value-of select="CERTIFICADO_EXPERIENCIA/NOMBRE"/>';
				items['Oferta']['CertExperiencia']['Descripcion']	= '<xsl:value-of select="CERTIFICADO_EXPERIENCIA/DESCRIPCION"/>';
				items['Oferta']['CertExperiencia']['Url']		= '<xsl:value-of select="CERTIFICADO_EXPERIENCIA/URL"/>';
				items['Oferta']['CertExperiencia']['Fecha']	= '<xsl:value-of select="CERTIFICADO_EXPERIENCIA/FECHA"/>';
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

		</xsl:when>
		</xsl:choose>

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
<!--			
			var arrPedMinProvCentro	= new Array();
			<xsl:for-each select="/Mantenimiento/LICITACION/PEDIDOSMINIMOS_CENTROYPROV/PEDIDOMINIMO">
				var items		= [];
				items['linea']		= '<xsl:value-of select="CONTADOR"/>';
				items['IDCentroLic']	= '<xsl:value-of select="LIC_PMC_IDCENTROLIC"/>';
				items['IDCentro']		= '<xsl:value-of select="LICC_IDCENTRO"/>';
				items['IDProveedorLic']= '<xsl:value-of select="LIC_PMC_IDPROVEEDORLIC"/>';
				items['IDProveedor']	= '<xsl:value-of select="LIC_PROV_IDPROVEEDOR"/>';
				items['PedMinTxt']	= '<xsl:value-of select="LIC_PMC_PEDIDOMINIMO"/>';
				items['PedMin']	= parseFloat(items['PedMinTxt'].replace(',','.'));
				
				console.log("Pedidos minimos IDCentro:"+items['IDCentro']+" IDProveedor:"+items['IDProveedor']+" PedMin:"+items['PedMin']);
				
				arrPedMinProvCentro.push(items);
			</xsl:for-each>
-->			
		</xsl:if>
		
	</script>
	<xsl:if test="/Mantenimiento/LICITACION/ROL = 'VENDEDOR'">
		<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/lic_proveedor2022_031022.js"></script>
	</xsl:if>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/lic2022_060423.js"></script>
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
			<xsl:choose>
			<xsl:when test="not(/Mantenimiento/NUEVALICITACION)">
				<p class="TituloPagina">
					<xsl:if test="/Mantenimiento/LICITACION/LIC_URGENTE = 'S'"><img src="http://www.newco.dev.br/images/2017/warning-red.png" class="urgente" title="{document($doc)/translation/texts/item[@name='urgente']/node()}"/>&nbsp;</xsl:if>
					<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CODIGO"/>:&nbsp;<xsl:value-of select="substring(/Mantenimiento/LICITACION/LIC_TITULO,1,50)"/>&nbsp;
					<span class="CompletarTitulo" style="width:924px;">
						<a class="btnNormal" href="javascript:window.close();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
						</a>
						&nbsp;
						<a class="btnNormal" style="text-decoration:none;">
							<xsl:choose>
							<xsl:when test="/Mantenimiento/LICITACION/ROL='VENDEDOR'">
								<xsl:attribute name="href">javascript:listadoExcelProv(<xsl:value-of select="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_ID"/>);</xsl:attribute>
							</xsl:when>
							<!--	24mar22 Unimed lo solicita tambien para licitaciones suspendidas	-->
							<xsl:when test="/Mantenimiento/LICITACION/LIC_IDESTADO = 'CURS' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'INF' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'SUS'">
								<xsl:attribute name="href">javascript:listadoExcelCompleto();</xsl:attribute><!--	16nov17	-->
							</xsl:when>
							<xsl:otherwise>
								<!--23mar22 Descargamos desde JS directamente	-->
								<xsl:attribute name="href">javascript:listadoExcel();</xsl:attribute>
							</xsl:otherwise>
							</xsl:choose>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/>
						</a>
						&nbsp;
						<xsl:if test="/Mantenimiento/LICITACION/ROL='COMPRADOR' and /Mantenimiento/LICITACION/LIC_IDESTADO != 'EST' and /Mantenimiento/LICITACION/LIC_IDESTADO != 'COMP'">	
							<a class="btnNormal" id="botonVencedores" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/licOfertasSeleccionadas2022.xsql?LIC_ID={/Mantenimiento/LICITACION/LIC_ID}',10,90,90,10);"><xsl:value-of select="document($doc)/translation/texts/item[@name='Vencedores']/node()"/></a>
							&nbsp;
						</xsl:if>
						<xsl:if test="/Mantenimiento/LICITACION/ROL='COMPRADOR' and /Mantenimiento/LICITACION/LIC_IDESTADO != 'EST' and /Mantenimiento/LICITACION/LIC_IDESTADO != 'COMP' and /Mantenimiento/LICITACION/LIC_IDESTADO != 'CONT' and /Mantenimiento/LICITACION/LIC_IDESTADO != 'CAD'">	
							<a class="btnNormal" id="botonProveedores" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/licResumenProveedores2022.xsql?LIC_ID={//LIC_ID}',10,90,30,30);"><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/></a>
							&nbsp;
						</xsl:if>
						<!--	16nov16	Botón de publicación de datos de compra	-->
						<xsl:if test="/Mantenimiento/LICITACION/ROL = 'COMPRADOR' and /Mantenimiento/LICITACION/COMPLETAR_COMPRA_CENTRO">
							<a class="btnDestacado" id="botonPublicarCompra" href="javascript:PublicarDatosCompra();">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='publicar_datos_compra']/node()"/>
							</a>
							&nbsp;
						</xsl:if>
						<!--	Botón de publicación de información de compras	-->
						<xsl:if test="/Mantenimiento/LICITACION/INFORMAR_COMPRAS">
							<a class="btnDestacado" id="botonInformarCompras" href="javascript:NoInformacionCompras();">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='informar_compras']/node()"/>
							</a>
							&nbsp;
						</xsl:if>
						<!--	Botón de publicación de inicio de la liciatción	-->
						<xsl:if test="/Mantenimiento/LICITACION/INICIAR_LICITACION">
							<!--<a class="btnDestacado" id="botonIniciarLici" href="javascript:IniciarLicitacion('CURS');">-->
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
						<!--	Botón de publicación de inicio de la liciatción	-->
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
						<!--	Botón para agregar otra licitación en estado EST a esta	-->
						<xsl:if test="/Mantenimiento/LICITACION/AGREGAR_LICITACION">
							<xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="/Mantenimiento/LICITACION/LICITACIONES_EST/field"/>
								<xsl:with-param name="claSel">w150px</xsl:with-param>
							</xsl:call-template>
							&nbsp;
							<a class="btnDestacado" id="botonAgregarLici" href="javascript:AgregarLicitacion();">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='agregar_licitacion']/node()"/>
							</a>
							&nbsp;
						</xsl:if>
						<!--	16nov16	Botón de adjudicación	-->
						<xsl:if test="/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_PORPRODUCTO = 'S' and (/Mantenimiento/LICITACION/LIC_IDESTADO = 'INF' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'CURS')"><!-- and not BLOQUEARADJUDICACION-->
							<xsl:choose>
							<xsl:when test="/Mantenimiento/LICITACION/LIC_MULTIOPCION='S'">
								<a class="btnDestacado" id="botonAdjudicarSelec" href="javascript:AdjudicarOfertasMultiples();">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicar']/node()"/>
								</a>
								<span id="idAvanceAdjudicar" style="display:none;" class="clear"><!--<img src="http://www.newco.dev.br/images/loading.gif"/>-->0/0</span>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
								<xsl:when test="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PRODUCTOS_OLVIDADOS">
									<a class="btnDeshabilitado" id="botonAdjudicarSelec" href="javascript:AdjudicarOfertas();">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicar']/node()"/></a>
								</xsl:when>
								<xsl:when test="/Mantenimiento/LICITACION/LIC_MESESDURACION>0 or /Mantenimiento/LICITACION/LIC_PEDIDOSPENDIENTES>0">
									<a class="btnDestacado" id="botonAdjudicarSelec" href="javascript:AdjudicarOfertas();"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicar']/node()"/></a>
									<span id="waitBotonAdjudicar" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></span>
								</xsl:when>
								<xsl:otherwise>
									<!--14feb20 NO mostramos el botón de adjudicar si es licitacion SPOTy no hay pedidos pendientes-->
								</xsl:otherwise>
								</xsl:choose>								
								<span id="waitBotonAdjudicar" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></span>
							</xsl:otherwise>
							</xsl:choose>								
							<!--	11mar20	<xsl:if test="/Mantenimiento/LICITACION/IDPAIS!='55' or (/Mantenimiento/LICITACION/LIC_MESESDURACION=0 and /Mantenimiento/LICITACION/LIC_PEDIDOSPENDIENTES=0 and /Mantenimiento/LICITACION/LIC_PEDIDOSENVIADOS>0)">-->
							<xsl:if test="/Mantenimiento/LICITACION/BOTON_CONTRATO">
							&nbsp;
								<a class="btnDestacado" id="botonEstContrato" href="javascript:PasarAEstadoContrato();">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar_lic']/node()"/>
								</a>
							</xsl:if>
						</xsl:if>
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
						<!--<xsl:if test="/Mantenimiento/LICITACION/ROL = 'VENDEDOR' and (/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_IDESTADO = 'CURS' or /Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_IDESTADO = 'INF')">-->
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

						<xsl:choose>
						<!-- cuando lici esta adjudicada, boton para el proveedor para firmarla -->
						<xsl:when test="/Mantenimiento/LICITACION/ROL = 'VENDEDOR' and /Mantenimiento/LICITACION/BOTON_FIRMA">
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
						</xsl:when>
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
						<!-- cuando lici esta contratada, boton para el usuario autor para incluir en plantillas -->
						<xsl:when test="/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/BOTON_CATALOGO_PRIVADO">
							<a class="btnDestacado" id="botonInsEnPlant" href="javascript:ComprobarYAdjudicarCatalogoCliente({/Mantenimiento/LICITACION/LIC_ID});">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='boton_insertar_en_plantillas']/node()"/>
							</a>
							<span id="waitBotonInsEnPlant" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></span>
							&nbsp;
						</xsl:when>
						<!-- cuando lici esta caducada, boton para el autor para renovarla -->
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
			</xsl:when>
			<xsl:otherwise>
				<!--<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_licitacion']/node()"/></span></p>-->
				<p class="TituloPagina">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_licitacion']/node()"/>
					&nbsp;&nbsp;
					<span class="CompletarTitulo">
						<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/Licitaciones2022.xsql" title="Volver a las licitaciones">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/>
						</a>
					</span>
				</p>			
				</xsl:otherwise>
			</xsl:choose>
		</div>
		<br/>
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

		<xsl:if test="not(/Mantenimiento/NUEVALICITACION)">

			<!-- PESTANA INFO PEDIDO -->
			<xsl:if test="/Mantenimiento/LICITACION/ROL = 'COMPRADOR' and /Mantenimiento/LICITACION/LIC_IDESTADO != 'EST' and /Mantenimiento/LICITACION/LIC_MESESDURACION = 0">
				<!--<form name="infoPedido" id="infoPedido" method="POST" action="http://www.newco.dev.br/Gestion/Comercial/MantLicitacionSave.xsql">-->
				<form name="infoPedido" id="infoPedido" method="POST" action="http://www.newco.dev.br/Gestion/Comercial/MantLicitacion2022.xsql">
				<input type="hidden" name="LIC_IDUSUARIO" value="{Mantenimiento/US_ID}"/>
				<input type="hidden" name="LIC_IDEMPRESA" value="{/Mantenimiento/LICITACION/LIC_IDEMPRESA}"/>
				<input type="hidden" name="LIC_ID" value="{/Mantenimiento/LICITACION/LIC_ID}"/>
				<input type="hidden" name="ACCION" value="INFOPEDIDO"/>
                <input type="hidden" name="lici" id="lici" value="NUEVA"/>
				<table class="infoTable divLeft tablaInfoPedido incidencias" id="lInfoPedido" style="display:none;border-top:1px solid #999;" cellspacing="5">
				<tbody>
					<tr style="height:5px;"><td colspan="3">&nbsp;</td></tr>

					<tr>
						<td class="trenta labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:</td>
						<td class="cuarenta textLeft borderGris" style="padding:15px 10px;">
						<xsl:choose>
						<xsl:when test="/Mantenimiento/LICITACION/AUTOR">
							<select name="LIC_IDUSUARIOPEDIDO" id="LIC_IDUSUARIOPEDIDO">
								<option value=""><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciona']/node()"/></option>
								<xsl:for-each select="/Mantenimiento/LICITACION/field[@name='IDUSUARIOPEDIDO']/dropDownList/listElem">
									<option value="{ID}">
										<xsl:if test="ID = ../../SelectedElement"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
										<xsl:value-of select="listItem"/>
									</option>
								</xsl:for-each>
							</select>
						</xsl:when>
						<xsl:otherwise>
							<xsl:for-each select="/Mantenimiento/LICITACION/field[@name='IDUSUARIOPEDIDO']/dropDownList/listElem">
								<xsl:if test="ID = ../../SelectedElement">
									<xsl:value-of select="listItem"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:otherwise>
						</xsl:choose>
						</td>
						<td>&nbsp;</td>
					</tr>

					<tr>
						<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='lugar_entrega']/node()"/>:</td>
						<td class="textLeft borderGris" style="padding:15px 10px;">
						<xsl:choose>
						<xsl:when test="/Mantenimiento/LICITACION/AUTOR">
							<select name="LIC_IDLUGARENTREGA" id="LIC_IDLUGARENTREGA">
								<option value=""><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciona']/node()"/></option>
								<xsl:for-each select="/Mantenimiento/LICITACION/field[@name='IDLUGARENTREGA']/dropDownList/listElem">
									<option value="{ID}">
										<xsl:if test="ID = ../../SelectedElement"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
										<xsl:value-of select="listItem"/>
									</option>
								</xsl:for-each>
							</select>
						</xsl:when>
						<xsl:otherwise>
							<xsl:for-each select="/Mantenimiento/LICITACION/field[@name='IDLUGARENTREGA']/dropDownList/listElem">
								<xsl:if test="ID = ../../SelectedElement">
									<xsl:value-of select="listItem"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:otherwise>
						</xsl:choose>
						</td>
						<td>&nbsp;</td>
					</tr>

					<tr>
						<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='forma_pago']/node()"/>:</td>
						<td class="textLeft borderGris" style="padding:15px 10px;">
						<xsl:choose>
						<xsl:when test="/Mantenimiento/LICITACION/AUTOR">
							<select name="LIC_IDFORMAPAGO" id="LIC_IDFORMAPAGO">
								<option value=""><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciona']/node()"/></option>
								<xsl:for-each select="/Mantenimiento/LICITACION/FORMASPAGO/field[@name='IDFORMAPAGO']/dropDownList/listElem">
									<option value="{ID}">
										<xsl:if test="ID = ../../../field/@current"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
										<xsl:value-of select="listItem"/>
									</option>
								</xsl:for-each>
							</select>
						</xsl:when>
						<xsl:otherwise>
							<xsl:for-each select="/Mantenimiento/LICITACION/FORMASPAGO/field[@name='IDFORMAPAGO']/dropDownList/listElem">
								<xsl:if test="ID = ../../../field/@current">
									<xsl:value-of select="listItem"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:otherwise>
						</xsl:choose>
						</td>
						<td>&nbsp;</td>
					</tr>

					<tr>
						<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_pago']/node()"/>:</td>
						<td class="textLeft borderGris" style="padding:15px 10px;">
						<xsl:choose>
						<xsl:when test="/Mantenimiento/LICITACION/AUTOR">
							<select name="LIC_IDPLAZOPAGO" id="LIC_IDPLAZOPAGO">
								<option value=""><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciona']/node()"/></option>
								<xsl:for-each select="/Mantenimiento/LICITACION/PLAZOSPAGO/field[@name='IDPLAZOPAGO']/dropDownList/listElem">
									<option value="{ID}">
										<xsl:if test="ID = ../../../field/@current"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
										<xsl:value-of select="listItem"/>
									</option>
								</xsl:for-each>
							</select>
						</xsl:when>
						<xsl:otherwise>
							<xsl:for-each select="/Mantenimiento/LICITACION/PLAZOSPAGO/field[@name='IDPLAZOPAGO']/dropDownList/listElem">
								<xsl:if test="ID = ../../../field/@current">
									<xsl:value-of select="listItem"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:otherwise>
						</xsl:choose>
						</td>
						<td>&nbsp;</td>
					</tr>

					<tr>
						<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_pedido']/node()"/>:</td>
						<td class="textLeft borderGris" style="padding:15px 10px;">
						<xsl:choose>
						<xsl:when test="/Mantenimiento/LICITACION/AUTOR">
							<input type="text" id="LIC_CODIGOPEDIDO" name="LIC_CODIGOPEDIDO" value="{/Mantenimiento/LICITACION/LIC_CODIGOPEDIDO}"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CODIGOPEDIDO"/>
						</xsl:otherwise>
						</xsl:choose>
						</td>
						<td>&nbsp;</td>
					</tr>

					<tr>
						<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones_pedido']/node()"/>:</td>
						<td class="textLeft borderGris" style="padding:15px 10px;">
						<xsl:choose>
						<xsl:when test="/Mantenimiento/LICITACION/AUTOR">
							<textarea id="LIC_OBSPEDIDO" name="LIC_OBSPEDIDO" rows="4" cols="70">
								<xsl:copy-of select="/Mantenimiento/LICITACION/LIC_COMENTARIOSPEDIDO/node()"/>
							</textarea>
						</xsl:when>
						<xsl:otherwise>
							<xsl:copy-of select="/Mantenimiento/LICITACION/LIC_COMENTARIOSPEDIDO/node()"/>
						</xsl:otherwise>
						</xsl:choose>
						</td>
						<td>&nbsp;</td>
					</tr>

				<xsl:if test="/Mantenimiento/LICITACION/AUTOR">
					<tr><td colspan="3">&nbsp;</td></tr>
					<tr>
						<td colspan="3">
							<table class="infoTable">
								<tr>
									<td class="trenta labelRight">&nbsp;</td>
									<td class="veinte">
										<div class="boton">
											<a href="javascript:SubmitForm(document.forms['infoPedido']);">
												<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
											</a>
										</div>
									</td>
									<td class="veinte">&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
							</table>
						</td>
					</tr>
				</xsl:if>
				</tbody>
				</table>
				</form>
			</xsl:if>
			<!-- FIN PESTANA INFO PEDIDO -->

			<!-- PESTANA PRODUCTOS -->
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/ROL = 'VENDEDOR'">
				<xsl:call-template name="Tabla_Productos_Proveedor"/>
			</xsl:when>
			<xsl:when test="/Mantenimiento/LICITACION/ROL = 'COMPRADOR' and /Mantenimiento/LICITACION/COMPLETAR_COMPRA_CENTRO">
				<xsl:call-template name="Tabla_Productos_Centro_Estudio_Previo"/>
			</xsl:when>
			<xsl:when test="/Mantenimiento/LICITACION/ROL = 'COMPRADOR' and /Mantenimiento/LICITACION/LIC_IDESTADO = 'EST'">
				<xsl:call-template name="Tabla_Productos_Cliente_Estudio_Previo"/>
			</xsl:when>
			<xsl:when test="/Mantenimiento/LICITACION/ROL = 'COMPRADOR'">
				<xsl:call-template name="Tabla_Productos_Ofertas_Cliente"/>
			</xsl:when>
			<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
			<!-- FIN PESTANA PRODUCTOS -->

			<!-- PESTANA PRODUCTOS COMPACTO (ANALISIS) -->
<!--
			<xsl:if test="/Mantenimiento/LICITACION/ROL = 'COMPRADOR' and /Mantenimiento/LICITACION/LIC_IDESTADO != 'EST'">
				<xsl:call-template name="Tabla_Productos_Compacto"/>
			</xsl:if>
-->
			<!-- FIN PESTANA PRODUCTOS COMPACTO (ANALISIS) -->

			<xsl:if test="/Mantenimiento/LICITACION/ROL = 'COMPRADOR'">
			<!-- PESTANA PROVEEDORES -->
				<xsl:choose>
				<xsl:when test="/Mantenimiento/LICITACION/LIC_IDESTADO = 'EST' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'COMP' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'CURS' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'INF'">
					<xsl:call-template name="Tabla_Proveedores_Previo"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="Tabla_Proveedores_Adjudicado"/>
				</xsl:otherwise>
				</xsl:choose>
			<!-- FIN PESTANA PROVEEDORES -->

			<!-- PESTANA USUARIOS -->
			<!--<table class="buscador tablaUsuarios" id="lUsuarios" style="display:none;margin-top:30px;">-->
			<div class="tabela tabela_redonda tablaUsuarios marginTop80" id="lUsuarios" style="display:none;">
			<table cellspacing="6px" cellpadding="6px">
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
						<td class="textLeft">&nbsp;
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
							<xsl:if test="(not(AUTOR) or SE_PUEDE_BORRAR) and /Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_IDESTADO='EST'">
								<a class="accBorrar" href="javascript:modificaUsuario({IDUSUARIO_LIC},'B');">
									<img src="http://www.newco.dev.br/images/2017/trash.png"/>
								</a>
							</xsl:if>
						</td>
						<td>&nbsp;</td>
					</tr>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<tr><td colspan="6" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion_sin_usuarios']/node()"/></strong></td></tr>
				</xsl:otherwise>
				</xsl:choose>
				</tbody>
				<tfoot class="rodape_tabela">
					<tr><td colspan="7">&nbsp;</td></tr>
				</tfoot>
			</table>
			</div>

			<xsl:if test="/Mantenimiento/LICITACION/AUTOR and (/Mantenimiento/LICITACION/LIC_IDESTADO='EST' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'COMP' or /Mantenimiento/LICITACION/LIC_IDESTADO='CURS')">
			<form id="Usuarios" name="Usuarios" method="post">
<!--
			<input type="hidden" name="LIC_ID" VALUE="{/Mantenimiento/LICITACION/LIC_ID}"/>
			<input type="hidden" name="ROL" VALUE="{Mantenimiento/LICITACION/ROL}"/>
			<input type="hidden" name="IDIOMA" VALUE="{Mantenimiento/LICITACION/IDIDIOMA}"/>
-->
			<!--<table class="divLeft tablaUsuarios infoTable incidencias" id="lUsuariosForm" style="display:none;" cellspacing="5">-->
			<table class="buscador tablaUsuarios" id="lUsuariosForm" style="display:none;" cellspacing="6px" cellpadding="6px">
				<tr class="sinLinea"><td colspan="4">&nbsp;</td></tr>

				<tr class="sinLinea">
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

				<tr class="sinLinea">
					<td>&nbsp;</td>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='firma']/node()"/>:</td>
					<td class="textLeft" colspan="2">
						<input type="checkbox" name="LIC_USU_FIRMA" id="LIC_USU_FIRMA" value="S"/>&nbsp;
						<xsl:value-of select="document($doc)/translation/texts/item[@name='expli_firma']/node()"/>
					</td>
				</tr>

				<tr class="sinLinea">
    				<td>&nbsp;</td>
    				<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='coautor']/node()"/>:</td>
    				<td class="textLeft" colspan="2">
						<input type="checkbox" name="LIC_USU_COAUTOR" id="LIC_USU_COAUTOR" value="N" unchecked="unchecked"/>&nbsp;
						<xsl:value-of select="document($doc)/translation/texts/item[@name='expli_coautor']/node()"/>
    				</td>
				</tr>


				<tr class="sinLinea"><td colspan="4">&nbsp;</td></tr>

				<tr class="sinLinea">
					<td colspan="2">&nbsp;</td>
					<td>
						<!--<div class="boton">-->
							<a class="btnDestacado" href="javascript:ValidarFormulario(document.forms['Usuarios'],'usuarios');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir']/node()"/>
							</a>
						<!--</div>-->
					</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			</form>
			</xsl:if>
			<!-- FIN PESTANA USUARIOS -->

			<!-- PESTANA CENTROS -->
			<!--xsl:if test="/Mantenimiento/LICITACION/LICITACIONES_AGREGADAS">-->
			<xsl:if test="/Mantenimiento/LICITACION/LICITACION_AGREGADA">
				<xsl:choose>
				<xsl:when test="/Mantenimiento/LICITACION/ROL = 'COMPRADOR' and (/Mantenimiento/LICITACION/LIC_IDESTADO = 'EST' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'COMP' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'CURS')">
					<xsl:call-template name="Tabla_Centros_Estudio_Previo"/>
				</xsl:when>
				<xsl:when test="/Mantenimiento/LICITACION/ROL = 'COMPRADOR'">
					<xsl:call-template name="Tabla_Centros"/>
				</xsl:when>
				<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<!-- FIN PESTANA CENTROS -->


			<!-- PESTANA INFORME: convertida en RESUMEN -->
			<div id="lResumen" class="divLeft marginTop50" style="display:none;">
			<table cellspacing="10px" cellpadding="10px">
			<tbody>
				<!--	3oct16	Añadimos un breve resumen cuantitativo		-->
				<tr class="sinLinea">
					<td class="diez labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>:&nbsp;</td>
					<td class="textLeft"><xsl:value-of select="/Mantenimiento/LICITACION/PRODUCTOSADJUDICADOS"/>/<xsl:value-of select="/Mantenimiento/LICITACION/LIC_NUMEROLINEAS"/></td>
				</tr>
				<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>:&nbsp;</td>
					<td class="textLeft"><xsl:value-of select="/Mantenimiento/LICITACION/LIC_PROVEEDORESADJUDICADOS"/>/<xsl:value-of select="/Mantenimiento/LICITACION/LIC_NUMEROPROVEEDORES"/></td>
				</tr>
				<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Total_adjudicado']/node()"/>:&nbsp;</td>
					<td class="textLeft"><xsl:value-of select="/Mantenimiento/LICITACION/LIC_CONSUMOADJUDICADO"/><!--/<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CONSUMOHISTADJUDICADO"/>--></td>
				</tr>
				<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro']/node()"/>:&nbsp;</td>
					<td class="textLeft"><xsl:value-of select="/Mantenimiento/LICITACION/LIC_AHORROADJUDICADO"/></td>
				</tr>

				<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='situacion']/node()"/>:&nbsp;</td>
					<td class="textLeft">
					<xsl:choose>
					<xsl:when test="/Mantenimiento/LICITACION/AUTOR">
						<input type="textbox" id="LIC_INF_SITUACION" name="LIC_INF_SITUACION" class="muygrande" value="{/Mantenimiento/LICITACION/INFORME/LIC_INF_SITUACION_SINFORMATO}"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="/Mantenimiento/LICITACION/INFORME/LIC_INF_SITUACION" disable-output-escaping="yes"/>
					</xsl:otherwise>
					</xsl:choose>
					</td>
					<td>&nbsp;</td>
				</tr>

				<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='presentacion']/node()"/>:&nbsp;</td>
					<td class="textLeft">
					<xsl:choose>
					<xsl:when test="/Mantenimiento/LICITACION/AUTOR">
						<textarea id="LIC_INF_PRESENTACION" name="LIC_INF_PRESENTACION" rows="10" cols="120">
							<xsl:value-of select="/Mantenimiento/LICITACION/INFORME/LIC_INF_PRESENTACION_SINFORMATO"/>
						</textarea>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="/Mantenimiento/LICITACION/INFORME/LIC_INF_PRESENTACION" disable-output-escaping="yes"/>
					</xsl:otherwise>
					</xsl:choose>
					</td>
					<td>&nbsp;</td>
				</tr>

				<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='analisis']/node()"/>:&nbsp;</td>
					<td class="textLeft">
					<xsl:choose>
					<xsl:when test="/Mantenimiento/LICITACION/AUTOR">
						<textarea id="LIC_INF_ANALISIS" name="LIC_INF_ANALISIS" rows="10" cols="120">
							<xsl:value-of select="/Mantenimiento/LICITACION/INFORME/LIC_INF_ANALISIS_SINFORMATO"/>
						</textarea>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="/Mantenimiento/LICITACION/INFORME/LIC_INF_ANALISIS" disable-output-escaping="yes"/>
					</xsl:otherwise>
					</xsl:choose>
					</td>
					<td>&nbsp;</td>
				</tr>

				<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='conclusiones']/node()"/>:&nbsp;</td>
					<td class="textLeft">
					<xsl:choose>
					<xsl:when test="/Mantenimiento/LICITACION/AUTOR">
						<textarea id="LIC_INF_CONCLUSIONES" name="LIC_INF_CONCLUSIONES" rows="10" cols="120">
							<xsl:value-of select="/Mantenimiento/LICITACION/INFORME/LIC_INF_CONCLUSIONES_SINFORMATO"/>
						</textarea>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="/Mantenimiento/LICITACION/INFORME/LIC_INF_CONCLUSIONES" disable-output-escaping="yes"/>
					</xsl:otherwise>
					</xsl:choose>
					</td>
					<td>&nbsp;</td>
				</tr>

			<xsl:if test="/Mantenimiento/LICITACION/AUTOR">
				<!--<tr><td colspan="3">&nbsp;</td></tr>-->

				<tr class="sinLinea">
					<td>&nbsp;</td>
					<td colspan="2" class="textLeft">
						<!--<table class="infoTable" >
							<tr>
								<td class="trenta labelRight">&nbsp;</td>
								<td class="veinte">
									<<div class="boton">-->
										<a class="btnDestacado" href="javascript:guardarDatosInforme();">
											<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
										</a>
									<!--/div>
								</td>
								<td class="veinte">&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
						</table>-->
					</td>
				</tr>
			</xsl:if>
			</tbody>
			</table>
			<br/>
			<br/>
			<br/>
			</div>
			<!-- PESTANA INFORMES -->
			<div id="lInformes" class="divLeft marginTop50" style="display:none;">
			<table cellspacing="10px" cellpadding="10px">
			<tbody>
				<tr class="sinLinea">
					<td class="textLeft" style="width:100px">&nbsp;</td>
					<td class="textLeft">
						<strong><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/licAvanceOfertas2022.xsql?LIC_ID={/Mantenimiento/LIC_ID}','Informe Licitacion',70,70,0,0);"><xsl:value-of select="document($doc)/translation/texts/item[@name='AvanceOfertas']/node()"/></a></strong>
					</td>
				</tr>
				<tr class="sinLinea">
					<td class="textLeft" style="width:100px">&nbsp;</td>
					<td class="textLeft">
						<strong><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/licOfertasSeleccionadas2022.xsql?LIC_ID={/Mantenimiento/LIC_ID}','Informe Licitacion',70,70,0,0);"><xsl:value-of select="document($doc)/translation/texts/item[@name='Vencedores']/node()"/></a></strong>
					</td>
				</tr>
				<tr class="sinLinea">
					<td class="textLeft" style="width:100px">&nbsp;</td>
					<td class="textLeft">
						<strong><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/VencedoresYAlternativas2022.xsql?LIC_ID={/Mantenimiento/LIC_ID}&amp;OFERTAS=2','Informe vencedores y 2 alternativas de la licitacion',70,70,0,0);"><xsl:value-of select="document($doc)/translation/texts/item[@name='VencedoresY2Alternativas']/node()"/></a></strong>
					</td>
				</tr>
				<tr class="sinLinea">
					<td class="textLeft" style="width:100px">&nbsp;</td>
					<td class="textLeft">
						<strong><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/VencedoresYAlternativas2022.xsql?LIC_ID={/Mantenimiento/LIC_ID}&amp;OFERTAS=4','Informe vencedores y 4 alternativas de la licitacion',70,70,0,0);"><xsl:value-of select="document($doc)/translation/texts/item[@name='VencedoresY4Alternativas']/node()"/></a></strong>
					</td>
				</tr>
				<tr class="sinLinea">
					<td class="textLeft" style="width:100px">&nbsp;</td>
					<td class="textLeft">
						<strong><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/licInformePorProveedor2022.xsql?LIC_ID={/Mantenimiento/LIC_ID}','Informe productos adjudicados de la licitacion',70,70,0,0);"><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_adjudicados_por_proveedor']/node()"/></a></strong>
					</td>
				</tr>
				<tr class="sinLinea">
					<td class="textLeft" style="width:100px">&nbsp;</td>
					<td class="textLeft">
						<strong><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/licInformeProveedoresYOfertas2022.xsql?LIC_ID={/Mantenimiento/LIC_ID}','Informe proveedores y ofertas de la licitacion',70,70,0,0);"><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores_y_ofertas']/node()"/></a></strong>
					</td>
				</tr>
				<tr class="sinLinea">
					<td class="textLeft" style="width:100px">&nbsp;</td>
					<td class="textLeft">
						<strong><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/licInformeResumen2022.xsql?LIC_ID={/Mantenimiento/LIC_ID}','Informe resumen de la licitacion',70,70,0,0);"><xsl:value-of select="document($doc)/translation/texts/item[@name='Informe_resumen_licitacion']/node()"/></a></strong>
					</td>
				</tr>
				
				<xsl:if test="/Mantenimiento/LICITACION/LIC_PEDIDOSENVIADOS>0">
				<tr class="sinLinea">
					<td class="textLeft" style="width:100px">&nbsp;</td>
					<td class="textLeft">
						<strong><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/licInformePedidos2022.xsql?LIC_ID={/Mantenimiento/LIC_ID}','Informe pedidos de la licitacion',70,70,0,0);"><xsl:value-of select="document($doc)/translation/texts/item[@name='Informe_pedidos_licitacion']/node()"/></a></strong>
					</td>
				</tr>
				</xsl:if>
			</tbody>
			</table>
			<br/>
			<br/>
			<br/>
			</div>
			<!-- FIN PESTANA INFORME> -->
			</xsl:if>
			

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
	</div>
	<!-- FIN DIV Conversacion Proveedor -->

		</xsl:if>
	</xsl:if>

   <!--ET15nov16 </div>--><!--fin de divleft bajo h1-->

                <!-- DIV Nueva etiqueta -->
<div class="overlay-container" id="verEtiquetas">
	<div class="window-container zoomout">
		<p style="text-align:right;">
                    <a href="javascript:showTabla(false);" style="text-decoration:none;">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
                    </a>&nbsp;
                    <a href="javascript:showTabla(false);" style="text-decoration:none;">
                        <img src="http://www.newco.dev.br/images/cerrar.gif" alt="Cerrar" />
                    </a>
                </p>

		<p id="tableTitle">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='para']/node()"/>&nbsp;
			<xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion']/node()"/>&nbsp;<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CODIGO"/>:&nbsp;<xsl:value-of select="/Mantenimiento/LICITACION/LIC_TITULO"/>&nbsp;

<!--
			&nbsp;<a href="javascript:window.print();" style="text-decoration:none;">
				<img src="http://www.newco.dev.br/images/imprimir.gif">
					<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></xsl:attribute>
					<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></xsl:attribute>
				</img>
			</a>
-->
		</p>

		<div id="mensError" class="divLeft" style="display:none;">
			<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></strong></p>
		</div>

		<table id="viejasEtiquetas" border="0" style="width:100%;display:none;">
		<thead>
			<th colspan="5">&nbsp;</th>
		</thead>

		<tbody></tbody>

		</table>

		<form name="nuevaEtiquetaForm" method="post" id="nuevaEtiquetaForm">

		<table id="nuevaEtiqueta" style="width:100%;">
		<thead>
			<th colspan="3">&nbsp;</th>
		</thead>

		<tbody>
			<tr>
				<td class="quince"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='etiqueta']/node()"/>:</strong></td>
				<td colspan="2" style="text-align:left;"><textarea name="TEXTO" id="TEXTO" rows="4" cols="70" /></td>
			</tr>
		</tbody>

		<tfoot>
			<tr>
				<td>&nbsp;</td>
				<td>
					<div class="boton" id="botonGuardar">
						<a href="javascript:guardarEtiqueta();">
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
</div>
<!-- FIN DIV Nueva etiqueta -->

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
