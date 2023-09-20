<?xml version="1.0" encoding="iso-8859-1"?>
<!-- 
	Ficha de un producto de la licitacion
	Ultima revision ET 10feb22 20:40 FichaProductoLicitacion_111022.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:param name="usuario" select="@US_ID"/>

<xsl:template match="/FichaProductoLic">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>


<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<meta http-equiv="Cache-Control" content="no-cache"/>

	<title>
		<xsl:value-of select="document($doc)/translation/texts/item[@name='ficha_producto_licitaciones']/node()"/>&nbsp;
		<xsl:choose>
		<xsl:when test="PRODUCTOLICITACION/REFCENTRO != ''">
			<xsl:value-of select="PRODUCTOLICITACION/REFCENTRO" disable-output-escaping="yes"/>:&nbsp;
		</xsl:when>
		<xsl:when test="PRODUCTOLICITACION/LIC_PROD_REFCLIENTE != ''">
			<xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_REFCLIENTE" disable-output-escaping="yes"/>:&nbsp;
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_REFESTANDAR" disable-output-escaping="yes"/>:&nbsp;
		</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="substring(PRODUCTOLICITACION/LIC_PROD_NOMBRE,0,40)" disable-output-escaping="yes"/>
	</title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<link href="http://www.newco.dev.br/General/Tabla-popup.css" rel="stylesheet" type="text/css"/>

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion_111022.js"></script>
	
	<script type="text/javascript" src="http://www.newco.dev.br/General/Tabla-popup.150715.js"></script>

	<script type="text/javascript">
		var lang			= '<xsl:value-of select="LANG"/>';
		var IDPais			= '<xsl:value-of select="PRODUCTOLICITACION/IDPAIS"/>';
		var IDLicitacion	= '<xsl:value-of select="LIC_ID"/>';
		var IDProdLic		= '<xsl:value-of select="LIC_PROD_ID"/>';
		var NumLineas		= '<xsl:value-of select="PRODUCTOLICITACION/LIC_NUMEROLINEAS"/>';
		var nombreProducto	= '<xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_NOMBRE" disable-output-escaping="yes"/>';
		<xsl:choose>
		<xsl:when test="PRODUCTOLICITACION/LIC_PROD_REFCLIENTE != ''">
			var RefCliente	= '<xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_REFCLIENTE" disable-output-escaping="yes"/>';
		</xsl:when>
		<xsl:otherwise>
			var RefCliente	= '<xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_REFESTANDAR" disable-output-escaping="yes"/>';
		</xsl:otherwise>
		</xsl:choose>		
		var IDEstadoLicitacion	= '<xsl:value-of select="PRODUCTOLICITACION/LIC_IDESTADOLICITACION"/>';
		var MesesDuracion		= '<xsl:value-of select="PRODUCTOLICITACION/LIC_MESESDURACION"/>';
		var PorProducto			= '<xsl:value-of select="PRODUCTOLICITACION/LIC_PORPRODUCTO"/>';
		var MostrarPrecioIVA	= '<xsl:choose><xsl:when test="PRODUCTOLICITACION/MOSTRAR_PRECIO_IVA">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		var LicAgregada			= '<xsl:value-of select="PRODUCTOLICITACION/LIC_AGREGADA"/>';
		var LicMultipedido		= '<xsl:value-of select="PRODUCTOLICITACION/LIC_MULTIPEDIDO"/>';
		var LicMultiOpcion		= '<xsl:value-of select="PRODUCTOLICITACION/LIC_MULTIOPCION"/>';
		var MostrarMotivoSeleccion= '<xsl:choose><xsl:when test="PRODUCTOLICITACION/MOSTRARMOTIVOSELECCION">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		var CreaOfertas			= '<xsl:choose><xsl:when test="PRODUCTOLICITACION/COMPRADOR_CREA_OFERTAS">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		var saltarPedMinimo	= '<xsl:value-of select="PRODUCTOLICITACION/SALTARPEDIDOMINIMO"/>';		

    	<xsl:choose>
    	<xsl:when test="PRODUCTOLICITACION/MOSTRAR_PRECIO_IVA">var precioHist = '<xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_PRECIOREFERENCIAIVA"/>';</xsl:when>
    	<xsl:otherwise>var precioHist = '<xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_PRECIOREFERENCIA"/>';</xsl:otherwise>
    	</xsl:choose>
		
		var CantidadTotal		= '<xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_CANTIDAD"/>';
		var CantidadPendiente	= 0;
		
		var datosPorProveedor	='N';	//	Se inicializara al preparar el cuadro
		
		var CambiosProveedores	='N';	//	informar si se cambian adjudicaciones


		//	Cadenas de texto multiidioma
		var estadoOfertaActualizado	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='estado_oferta_actualizado']/node()"/>';
		var errorNuevoEstadoOferta	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_nuevo_estado_oferta']/node()"/>';
		var sinSeleccion		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_oferta_no_seleccionada']/node()"/>';
		var guardar_selecc_adjudica_ok	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_selecc_adjudica_ok']/node()"/>';
		var guardar_selecc_adjudica_ko	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_selecc_adjudica_ko']/node()"/>';

		var val_malPrecioRef	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_precio_referencia2']/node()"/>';
		var val_malPrecioObj	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_precio_objetivo2']/node()"/>';
		var val_faltaUdBasica	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_unidad_basica2']/node()"/>';
		var val_faltaCantidad	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_cantidad2']/node()"/>';
		var val_ceroCantidad	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cero_cantidad2']/node()"/>';
		var val_malCantidad	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_cantidad2']/node()"/>';

		var val_malPrecioOfe	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_precio']/node()"/>';
		val_faltaUnidades	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_unidades']/node()"/>';

		var alrt_ProdActualizadoOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='success_producto_actualizado']/node()"/>';
		var alrt_ProdActualizadoKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_producto_actualizado']/node()"/>';
		var alrt_OfertasOK		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='success_ofertas_actualizadas']/node()"/>';
		var alrt_OfertasKO		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_ofertas_actualizadas']/node()"/>';
		var alrt_CamposAvanzadosOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='success_guardar_campos_avanzados']/node()"/>';
		var alrt_CamposAvanzadosKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_guardar_campos_avanzados']/node()"/>';
		var alrt_BorrarDocumentoOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='success_borrar_documento']/node()"/>';
		var alrt_BorrarDocumentoKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_borrar_documento']/node()"/>';
		var alrt_RequiereMotivo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_requiere_motivo']/node()"/>';
		var alrt_RequiereMotivoPrecio	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_requiere_motivo_precio']/node()"/>';
		var alrt_CatalogarOfertaKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_al_catalogar_oferta']/node()"/>';
		var alrt_ConfirmCatalogarOferta	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='confirm_catalogar_oferta']/node()"/>';
		var alrt_DescartarOfertaKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_al_descartar_oferta']/node()"/>';
		var alrt_ConfirmDescartarOferta	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='confirm_descartar_oferta']/node()"/>';
		var alrt_RequiereOpcion1	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='req_opcion_1']/node()"/>';
		var alrt_NoHaSeleccionadoOferta	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='no_ha_seleccionado_oferta']/node()"/>';
		<!--var alrt_SoloUnaOpcion1	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='solo_una_opcion_1']/node()"/>';-->
		var alrt_CantidadInfTotal	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_inferior_total']/node()"/>';
		var alrt_CantidadSupTotal	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_superior_total']/node()"/>';
		var alrt_TotalAsignadoNoCoincide	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='total_asignado_no_coincide']/node()"/>';
		var strPedido	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>';

		<!-- Textos para la info. cliente (Hist?ricos por centro) -->
		var val_faltaCentro	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_centro']/node()"/>';
		var val_faltaNombre	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_nombre']/node()"/>';
		var val_faltaUdBasica	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_udbasica']/node()"/>';
		var val_faltaPrecio	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_precio2']/node()"/>';
		var val_malPrecio	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_precio2']/node()"/>';
		var val_faltaCantAnual	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_cantidad_anual']/node()"/>';
		var val_malCantAnual	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_cantidad_anual']/node()"/>';
		var val_faltaUdsLote	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_uds_lote']/node()"/>';
		var val_malUdsLote	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_uds_lote']/node()"/>';

		var str_guardarDatosOK		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='datos_info_historico_guardado']/node()"/>';
		var str_guardarDatosKO		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='datos_info_historico_error']/node()"/>';

		var val_faltaPrecioMVM		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_precioMVM']/node()"/>';
		var val_malPrecioMVM		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_precioMVM']/node()"/>';
		
		<!--	Cadenas necesarias para editar ofertas		-->
		var str_SinOfertar	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_ofertar']/node()"/>';
		var val_malEnteroUnidades	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_entero_unidades']/node()"/>';

		<!--	Textos para la creaci�n de pedidos desde oferta -->
		var str_CrearNuevoProd	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='crear_nuevo_pedido']/node()"/>';
		var str_AnnadirProdAPedido	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='annadir_producto_a_pedido']/node()"/>';
		var str_RevisarCantProd	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='revisar_cantidad_producto_por_pedminimo']/node()"/>';
		var str_PedAceptAnnadirProd	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_confirmado_annadir_producto']/node()"/>';
		var str_ProdIncluidoOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='producto_incluido_correctamente']/node()"/>';
		var alert_GuardarPedidoKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_incluir_oferta_en_pedido']/node()"/>';
		var alrt_avisoCambioUnidades= '<xsl:value-of select="document($doc)/translation/texts/item[@name='revisar_cantidad_producto_por_unidadeslote']/node()"/>';
		var alrt_avisoCentroNoSeleccionado= '<xsl:value-of select="document($doc)/translation/texts/item[@name='centro_no_seleccionado']/node()"/>';
		var val_faltaRefProv		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_ref_proveedor']/node()"/>';
		
		var str_Guardar='<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>';
		
		<xsl:if test="PRODUCTOLICITACION/LIC_AGREGADA='S'">
			var arrOfertas	= new Array();
			<xsl:for-each select="PRODUCTOLICITACION/OFERTAS/OFERTA">
				var items		= [];
				items['linea']		= '<xsl:value-of select="CONTADOR"/>';
				items['IDOferta']	= '<xsl:value-of select="LIC_OFE_ID"/>';
				items['IDProvLic']	= '<xsl:value-of select="LIC_OFE_IDPROVEEDORLIC"/>';
				items['IDProveedor']= '<xsl:value-of select="IDPROVEEDOR"/>';
				items['Proveedor']	= '<xsl:value-of select="PROVEEDOR"/>';
				items['UdesLote']	= <xsl:value-of select="LIC_OFE_UNIDADESPORLOTE"/>;
				items['Multiofertas']	= [];
				<xsl:if test="MULTIOFERTAS/MULTIOFERTA">
					<xsl:for-each select="MULTIOFERTAS/MULTIOFERTA">
						var multioferta	= [];
						multioferta['MO_ID']	= '<xsl:value-of select="MO_ID"/>';
						multioferta['LMO_ID']	= '<xsl:value-of select="LMO_ID"/>';
						multioferta['CodPedido']= '<xsl:value-of select="CODPEDIDO"/>';
						multioferta['Estado']	= '<xsl:value-of select="MO_STATUS"/>';
						multioferta['IDCentro']	= '<xsl:value-of select="MO_IDCENTROCLIENTE"/>';
						multioferta['Incluido']	= '<xsl:choose><xsl:when test="INCLUIDO_EN_PEDIDO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
						items['Multiofertas'].push(multioferta);
					</xsl:for-each>
				</xsl:if>
				arrOfertas.push(items);
			</xsl:for-each>
		</xsl:if>

		<!--29mar21 Guardamos las cantidades por centro en un array para construir la tabla de forma dinamica	-->
		<xsl:if test="PRODUCTOLICITACION/LIC_AGREGADA='S'">
			var arrCentros	= new Array();
			<xsl:for-each select="/FichaProductoLic/PRODUCTOLICITACION/COMPRAPORCENTRO/PRODUCTO/CENTRO">
				var centro		= [];
				centro['linea']= '<xsl:value-of select="CONTADOR"/>'
				centro['IDCentro']	= '<xsl:value-of select="CEN_ID"/>';
				centro['Centro']= '<xsl:value-of select="NOMBRE"/>';
				centro['Marcas']= '<xsl:value-of select="LIC_CC_MARCASACEPTABLES"/>';
				centro['Cantidad']= '<xsl:value-of select="LIC_CC_CANTIDAD"/>';
				centro['CantidadSF']= <xsl:value-of select="CANTIDAD_SINFORMATO"/>;
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
				arrCentros.push(centro);
			</xsl:for-each>
		</xsl:if>
	</script>

	<style type="text/css">
		td.mejorPrecio { background-color: #FFFF99;}
	</style>
</head>
<body onload="javascript:CambioCentro();">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
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

	<!--	Titulo de la p�gina		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>
		<xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/MVM">
		&nbsp;/&nbsp;<xsl:value-of select="PRODUCTOLICITACION/EMPRESA" disable-output-escaping="yes"/>
		</xsl:if>
		&nbsp;/&nbsp;<xsl:value-of select="PRODUCTOLICITACION/TITULO" disable-output-escaping="yes"/>		<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion']/node()"/>-->
		&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ficha_de_producto']/node()"/></span>
		<span class="CompletarTitulo" style="width:200px;">
			<xsl:if test="PRODUCTOLICITACION/MVM">
				&nbsp;&nbsp;&nbsp;<span class="amarillo">CP_PRO_ID:&nbsp;<xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_IDPRODESTANDAR"/></span>
			</xsl:if>
		</span>
		</p>
		<p class="TituloPagina">
			<strong><xsl:value-of select="PRODUCTOLICITACION/POSICION"/>/<xsl:value-of select="PRODUCTOLICITACION/LIC_NUMEROLINEAS"/></strong>
			&nbsp;&nbsp;(<xsl:choose>
			<xsl:when test="PRODUCTOLICITACION/REFCENTRO != ''">
				<xsl:value-of select="PRODUCTOLICITACION/REFCENTRO" disable-output-escaping="yes"/>
			</xsl:when>
			<xsl:when test="PRODUCTOLICITACION/LIC_PROD_REFCLIENTE != ''">
				<xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_REFCLIENTE" disable-output-escaping="yes"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_REFESTANDAR" disable-output-escaping="yes"/>
			</xsl:otherwise>
			</xsl:choose>)&nbsp;
			<xsl:value-of select="substring(PRODUCTOLICITACION/LIC_PROD_NOMBRE,0,28)" disable-output-escaping="yes"/>
		<span class="CompletarTitulo" style="width:820px;">
			<xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/IDPRODUCTOLIC_ANTERIOR">
				&nbsp;<a id="botonProdAnterior" class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={/FichaProductoLic/PRODUCTOLICITACION/IDPRODUCTOLIC_ANTERIOR}&amp;LIC_ID={//LIC_ID}"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
			</xsl:if>
			&nbsp;<a id="botonLicitacion" class="btnNormal" href="javascript:AbrirLicitacion();"><xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion']/node()"/></a>
			<xsl:if test="PRODUCTOLICITACION/PRODUCTOS_SELECCIONADOS > 0">
				&nbsp;<a id="botonVerOC" class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/licOfertasSeleccionadas.xsql?LIC_ID={//LIC_ID}&amp;LIC_PROD_ID={/FichaProductoLic/PRODUCTOLICITACION/LIC_PROD_ID}"><xsl:value-of select="document($doc)/translation/texts/item[@name='Vencedores']/node()"/></a>
				&nbsp;<a id="botonVerProv" class="btnNormal" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/licResumenProveedores.xsql?LIC_ID={//LIC_ID}',30,60,30,30);"><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/></a>
			</xsl:if>
			<xsl:if test="PRODUCTOLICITACION/AUTOR and PRODUCTOLICITACION/TOTAL_OFERTAS > 0 and not (PRODUCTOLICITACION/PRODUCTO_BLOQUEADO_POR_PEDIDOS) and (PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'CURS' or PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'INF') ">
				&nbsp;<a class="btnDestacado" id="botonGuardarSelec" href="javascript:GuardarProductoSel({//LIC_PROD_ID},'SIGUIENTE')"><xsl:value-of select="document($doc)/translation/texts/item[@name='seleccionar_y_continuar']/node()"/></a>
			</xsl:if>
			<xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/IDPRODUCTOLIC_SIGUIENTE">
				&nbsp;<a id="botonProdSiguiente" class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={/FichaProductoLic/PRODUCTOLICITACION/IDPRODUCTOLIC_SIGUIENTE}&amp;LIC_ID={//LIC_ID}"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
			</xsl:if>
		</span>
		</p>
	</div>

	<form name="ProdLici" action="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql" method="post">
	<input type="hidden" name="IDEMPRESA" id="IDEMPRESA" value="{PRODUCTOLICITACION/IDEMPRESA}"/>
	<input type="hidden" name="IDCENTRO" id="IDCENTRO" value="{PRODUCTOLICITACION/IDCENTROPEDIDO}"/>
	<input type="hidden" name="LIC_ID" id="LIC_ID" value="{PRODUCTOLICITACION/LIC_ID}"/>
	<input type="hidden" name="LIC_PROD_ID" id="LIC_PROD_ID" value="{PRODUCTOLICITACION/LIC_PROD_ID}"/>
	<input type="hidden" name="LIC_PROD_IDPRODESTANDAR" id="LIC_PROD_IDPRODESTANDAR" value="{PRODUCTOLICITACION/LIC_PROD_IDPRODESTANDAR}"/>
	<input type="hidden" name="ACCION" id="ACCION" value=""/>
	<input type="hidden" name="PARAMETROS" id="PARAMETROS" value=""/>
	<!-- Tabla Datos Cliente -->
	<div class="divLeft">
	
		<div class="formComplejo" style="margin-top:10px;margin-left:auto;margin-right:auto;width:1200px;padding:10px 0;border: 1px solid grey;">
		<ul>
			<li class="sinSeparador">
				<div style="min-width:120px;display:inline-block;margin-left:50px;"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:</label></div>
				&nbsp;
				<strong>
				<a href="javascript:VerHistorico();">
				<xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_NOMBRE" disable-output-escaping="yes"/>
				</a>
				<xsl:if test="PRODUCTOLICITACION/LIC_PROD_INFOAMPLIADA != ''">
					&nbsp;&nbsp;
					<div class="tooltip">
					<!--14dic16	Cambioamops a nuevas clases tooltip	-->
					<!--<a href="#" class="tooltip">-->
						<img class="static" src="http://www.newco.dev.br/images/infoAmpliadaIconO.gif"/>
						<!--<span class="classic spanEIS">-->
						<span class="tooltiptext">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='info_ampliada']/node()"/>:<br /><br />
							<xsl:copy-of select="PRODUCTOLICITACION/LIC_PROD_INFOAMPLIADA/node()"/>
						</span>
                	<!--</a>-->
					</div>
				</xsl:if>
				<!--	17dic21 mostramos boton FT
				<xsl:if test="PRODUCTOLICITACION/DOCUMENTO/ID">
					&nbsp;&nbsp;<a target="_blank" href="http://www.newco.dev.br/Documentos/{PRODUCTOLICITACION/DOCUMENTO/URL}" style="text-decoration:none;">
						<img class="static" src="http://www.newco.dev.br/images/clipIconO.gif">
							<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/></xsl:attribute>
						</img>
					</a>
				</xsl:if>
				-->
				<xsl:if test="PRODUCTOLICITACION/LIC_PROD_ANOTACIONES != ''">
					&nbsp;&nbsp;<a class="tooltip" href="#">
						<img class="static" src="http://www.newco.dev.br/images/infoAmpliadaIconNaraO.gif"/>
						<span class="classic spanEIS">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='anotaciones']/node()"/>:<br /><br />
							<xsl:copy-of select="PRODUCTOLICITACION/LIC_PROD_ANOTACIONES/node()"/>
						</span>
					</a>
				</xsl:if>
				</strong>
				<xsl:if test="PRODUCTOLICITACION/PERMITIR_CAMBIAR_PRODUCTO">
					<a class="btnNormal" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoPrivadoProductoEmpresa.xsql?IDEMPRESA={PRODUCTOLICITACION/IDEMPRESA}&amp;ORIGEN=PRODUCTOLIC','Cat�logo Privado',50,80,90,20);">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo']/node()"/>
					</a>
				</xsl:if>
				<div style="float:right;">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<xsl:if test="PRODUCTOLICITACION/AUTOR and (PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'EST' or PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'COMP' or PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'CURS' or PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'INF')" >
					<a class="btnDestacado" id="botonGuardarDatosProd" href="javascript:GuardarDatosProducto()"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
				</xsl:if>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</div>
			</li>
			<li class="sinSeparador">
				<div style="min-width:120px;display:inline-block;margin-left:50px;"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='marcas']/node()"/>:</label></div>
				&nbsp;
				<strong>
				<xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_MARCASACEPTABLES" disable-output-escaping="yes"/>
				</strong>
				<div style="min-width:120px;display:inline-block;margin-left:50px;"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='Principio_activo']/node()"/>:</label></div>
				&nbsp;
				<strong>
				<xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_PRINCIPIOACTIVO" disable-output-escaping="yes"/>
				</strong>
			</li>
			<li class="sinSeparador">
				<xsl:choose>
				<xsl:when test="PRODUCTOLICITACION/MOSTRAR_PRECIO_IVA">
					<div style="min-width:140px;display:inline-block;"><label style="min-width:200px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_historico_cIVA']/node()"/>:</label></div>
					<xsl:choose>
					<!--<xsl:when test="PRODUCTOLICITACION/AUTOR and (PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'CURS' or PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'INF')">-->
					<xsl:when test="PRODUCTOLICITACION/AUTOR and PRODUCTOLICITACION/PERMITIR_MODIFICAR_CANTIDADES">
						<input class="corto" type="text" size="10" name="PrecioRefIVA" id="PrecioRefIVA" value="{PRODUCTOLICITACION/LIC_PROD_PRECIOREFERENCIAIVA}"/>
						<input type="hidden" name="PrecioRef" id="PrecioRef" value="{PRODUCTOLICITACION/LIC_PROD_PRECIOREFERENCIA}"/>
						<input type="hidden" name="TipoIVA" id="TipoIVA" value="{PRODUCTOLICITACION/LIC_PROD_TIPOIVA}"/>
					</xsl:when>
					<xsl:otherwise>
						<strong><xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_PRECIOREFERENCIAIVA" disable-output-escaping="yes"/></strong>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<div style="min-width:140px;display:inline-block;margin-left:50px;"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_historico_sIVA']/node()"/>:</label></div>
					<xsl:choose>
					<!--<xsl:when test="PRODUCTOLICITACION/AUTOR and (PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'CURS' or PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'INF')">-->
					<xsl:when test="PRODUCTOLICITACION/AUTOR and PRODUCTOLICITACION/PERMITIR_MODIFICAR_CANTIDADES">
						<input class="corto"  type="text" size="10" name="PrecioRef" id="PrecioRef" value="{PRODUCTOLICITACION/LIC_PROD_PRECIOREFERENCIA}"/>
					</xsl:when>
					<xsl:otherwise>
						<strong><xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_PRECIOREFERENCIA" disable-output-escaping="yes"/></strong>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
				</xsl:choose>
				<div style="min-width:140px;display:inline-block;margin-left:50px;"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/>:</label></div>
				<xsl:choose>
				<!--<xsl:when test="PRODUCTOLICITACION/AUTOR and (PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'CURS' or PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'INF')">-->
				<xsl:when test="PRODUCTOLICITACION/AUTOR and PRODUCTOLICITACION/PERMITIR_MODIFICAR_CANTIDADES">
					<input class="corto"  type="text" name="UdBasica" id="UdBasica" value="{PRODUCTOLICITACION/LIC_PROD_UNIDADBASICA}"/>
				</xsl:when>
				<xsl:otherwise>
					&nbsp;<xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_UNIDADBASICA" disable-output-escaping="yes"/>
				</xsl:otherwise>
				</xsl:choose>
				<div style="min-width:140px;display:inline-block;margin-left:50px;"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/>:</label></div>
				<xsl:choose>
				<!--<xsl:when test="PRODUCTOLICITACION/AUTOR and (not (PRODUCTOLICITACION/LICITACION_AGREGADA)) and (PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'CURS' or PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'INF')">-->
				<xsl:when test="PRODUCTOLICITACION/AUTOR and (not (PRODUCTOLICITACION/LICITACION_AGREGADA))  and (not (PRODUCTOLICITACION/LICITACION_MULTIPEDIDO)) and PRODUCTOLICITACION/PERMITIR_MODIFICAR_CANTIDADES">
					<input class="corto"  type="text" size="5" name="Cantidad" id="Cantidad" value="{PRODUCTOLICITACION/LIC_PROD_CANTIDAD}"/>
				</xsl:when>
				<xsl:otherwise>
					&nbsp;<xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_CANTIDAD" disable-output-escaping="yes"/>
					<input type="hidden" name="Cantidad" id="Cantidad" value="{PRODUCTOLICITACION/LIC_PROD_CANTIDAD}"/>
				</xsl:otherwise>
				</xsl:choose>
			</li>
			<li class="sinSeparador">
				<xsl:choose>
				<xsl:when test="PRODUCTOLICITACION/MOSTRAR_PRECIO_IVA">
					<div style="min-width:140px;display:inline-block;margin-left:50px;"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_objetivo_cIVA']/node()"/>:</label></div>
					<xsl:choose>
					<!--<xsl:when test="PRODUCTOLICITACION/AUTOR and (PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'CURS' or PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'INF')">-->
					<xsl:when test="PRODUCTOLICITACION/AUTOR and PRODUCTOLICITACION/PERMITIR_MODIFICAR_CANTIDADES">
						<input class="corto"  type="text" size="5" name="PrecioObjIVA" id="PrecioObjIVA" value="{PRODUCTOLICITACION/LIC_PROD_PRECIOOBJETIVOIVA}"/>
						<input type="hidden" name="PrecioObj" id="PrecioObj" value="{PRODUCTOLICITACION/LIC_PROD_PRECIOOBJETIVO}"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_PRECIOOBJETIVOIVA" disable-output-escaping="yes"/>&nbsp;&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<div style="min-width:140px;display:inline-block;margin-left:50px;"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_objetivo_sIVA']/node()"/>:</label></div>
					<xsl:choose>
					<!--<xsl:when test="PRODUCTOLICITACION/AUTOR and (PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'CURS' or PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'INF')">-->
					<xsl:when test="PRODUCTOLICITACION/AUTOR and PRODUCTOLICITACION/PERMITIR_MODIFICAR_CANTIDADES">
						<input class="corto"  type="text" size="10" name="PrecioObj" id="PrecioObj" value="{PRODUCTOLICITACION/LIC_PROD_PRECIOOBJETIVO}"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_PRECIOOBJETIVO" disable-output-escaping="yes"/>&nbsp;&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
				<xsl:when test="PRODUCTOLICITACION/MOSTRAR_PRECIO_IVA">
					<div style="min-width:140px;display:inline-block;margin-left:50px;"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_cIVA']/node()"/>:</label></div>
					<input class="corto"  type="text" size="10" disabled="disabled" value="{PRODUCTOLICITACION/LIC_PROD_CONSUMOHISTORICOIVA}"/>
				</xsl:when>
				<xsl:otherwise>
					<div style="min-width:140px;display:inline-block;margin-left:50px;"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_sIVA']/node()"/>:</label></div>
					<input class="corto"  type="text" size="10" disabled="disabled" value="{PRODUCTOLICITACION/LIC_PROD_CONSUMOHISTORICO}"/>
				</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="PRODUCTOLICITACION/CP_PRO_COMPRAMENSUALMEDIA_UD != ''">
				<div style="min-width:140px;display:inline-block;margin-left:50px;">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Compramensualmedia_uds']/node()"/>:</label>&nbsp;
					<input class="corto"  type="text" size="10" disabled="disabled" value="{PRODUCTOLICITACION/CP_PRO_COMPRAMENSUALMEDIA_UD}"/>
				</div>
				</xsl:if>
			</li>
			<!--	Datos ultima compra	-->
			<li class="sinSeparador fondoDest">
				<xsl:if test="PRODUCTOLICITACION/CP_PRO_CURVAABC != ''">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Curva_ABC']/node()"/>:&nbsp;
					<strong><xsl:value-of select="PRODUCTOLICITACION/CP_PRO_CURVAABC" disable-output-escaping="yes"/></strong>
					&nbsp;&nbsp;&nbsp;&nbsp;
				</xsl:if>
				<xsl:choose>
				<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/ULTIMACOMPRA">
					<strong><a href="javascript:VerPedido({/FichaProductoLic/PRODUCTOLICITACION/ULTIMACOMPRA/MO_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ultimo_pedido']/node()"/></a>:</strong>&nbsp;&nbsp;&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:
					<strong><xsl:value-of select="/FichaProductoLic/PRODUCTOLICITACION/ULTIMACOMPRA/FECHA" disable-output-escaping="yes"/></strong>&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:
					<strong><xsl:value-of select="/FichaProductoLic/PRODUCTOLICITACION/ULTIMACOMPRA/PROVEEDOR" disable-output-escaping="yes"/></strong>&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>:
					<strong><xsl:value-of select="/FichaProductoLic/PRODUCTOLICITACION/ULTIMACOMPRA/PRECIO" disable-output-escaping="yes"/></strong>&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/>:
					<strong><xsl:value-of select="/FichaProductoLic/PRODUCTOLICITACION/ULTIMACOMPRA/CANTIDAD" disable-output-escaping="yes"/></strong>&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>:
					<strong><xsl:value-of select="/FichaProductoLic/PRODUCTOLICITACION/ULTIMACOMPRA/MARCA" disable-output-escaping="yes"/></strong>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Producto_sin_pedidos_anteriores']/node()"/>
				</xsl:otherwise>
				</xsl:choose>
			</li>
			<br/>
			<li class="sinSeparador fondoDest">
				<xsl:choose>
				<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/COMPRAMEDIA">
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_3meses']/node()"/>:</strong>&nbsp;&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='eis_numero_pedidos']/node()"/>:
					<strong><xsl:value-of select="/FichaProductoLic/PRODUCTOLICITACION/COMPRAMEDIA/NUMERO_PEDIDOS" disable-output-escaping="yes"/></strong>&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/>:
					<strong><xsl:value-of select="/FichaProductoLic/PRODUCTOLICITACION/COMPRAMEDIA/CANTIDAD_TOTAL" disable-output-escaping="yes"/></strong>&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Min']/node()"/>:
					<strong><xsl:value-of select="/FichaProductoLic/PRODUCTOLICITACION/COMPRAMEDIA/PRECIO_MIN" disable-output-escaping="yes"/></strong>&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Medio']/node()"/>:
					<strong><xsl:value-of select="/FichaProductoLic/PRODUCTOLICITACION/COMPRAMEDIA/PRECIO_MEDIO" disable-output-escaping="yes"/></strong>&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Max']/node()"/>:
					<strong><xsl:value-of select="/FichaProductoLic/PRODUCTOLICITACION/COMPRAMEDIA/PRECIO_MAX" disable-output-escaping="yes"/></strong>&nbsp;
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Producto_sin_pedidos_trimestre']/node()"/>
				</xsl:otherwise>
				</xsl:choose>
			</li>
			<!--</xsl:if>	-->
		</ul>	
		</div>
		<br/>
		
	</div><!-- FIN divLeft Tabla Datos Clientes -->

	<xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/MUY_SOSPECHOSO">
		<div class="problematicos" style="text-align:center;margin-top:20px;padding:10px 10;margin-right:40%;margin-bottom:50px;margin-top:20px;">
		<!--El producto incluye ofertas con precio muy sospechoso de tener un error-->
		<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_muy_sospechoso']/node()"/>
		</div>
	</xsl:if>

	<xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/SOSPECHOSO">
		<!-- PS 8jul16
		<div class="divLeft40" style="text-align: center;margin-top:20px;padding:10px 0;margin:auto;border: 1px solid black;">-->
		<div class="problematicos" style="text-align:center;margin-top:20px;padding:10px 10;margin-left:40%;margin-bottom:50px;margin-top:20px;">	
		<!--El producto incluye ofertas con precio sospechoso de tener un error-->
		<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_sospechoso']/node()"/>
		</div>
	</xsl:if>

	<xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/TOTAL_OFERTAS=0">
	<!-- PS 12jul17
		<div class="divLeft40" style="text-align: center;margin-top:20px;padding:10px 0;margin:auto;border: 1px solid black;">
		Producto sin ofertas
		</div>-->
		<div class="problematicos" style="text-align: center;margin-top:20px;padding:10px 10;margin-left:40%;margin-bottom:50px;margin-top:20px;">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='producto_sin_ofertas']/node()"/>
		</div>	
	</xsl:if>	
	
	<!-- Pestanyas -->
	<xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/LICITACION_MULTIPEDIDO">
	<div id="pestanas" class="divLeft" style="height:28px;">
		<ul class="Pestannas" style="height:28px;">
			<li style="height:28px;">
				<a href="#" id="pes_lInfoProv" style="text-decoration:none;" class="MenuFicha"><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/></a>&nbsp;
			</li>
			<li style="height:28px;">
				<a href="#" id="pes_lInfoPedidos" style="text-decoration:none;" class="MenuFicha"><xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos']/node()"/></a>&nbsp;
			</li>
		</ul>
	</div>
	</xsl:if>
	<!-- FIN Pestanyas -->
	<!-- Pestanyas -->
	<xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/LICITACION_AGREGADA"><!-- and (not /FichaProductoLic/PRODUCTOLICITACION/LICITACION_MULTIPEDIDO)-->
	<div id="pestanas" class="divLeft" style="border-bottom:0px solid #3B5998;margin-top:10px;">
		<ul class="Pestannas" style="height:28px;">
			<li style="height:28px;">
				<a href="#" id="pes_lInfoProv" style="text-decoration:none;" class="MenuFicha"><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/></a>&nbsp;
			</li>
			<li style="height:28px;">
				<a href="#" id="pes_lInfoCli" style="text-decoration:none;" class="MenuFicha"><xsl:value-of select="document($doc)/translation/texts/item[@name='centros']/node()"/></a>&nbsp;
			</li>
		</ul>
	</div>
	</xsl:if>
	<!-- FIN Pestanyas -->
	<!-- Tabla Datos Ofertas Proveedores -->
	<div class="divLeft" id="lInfoProv" style="margin-top:29px">
		<xsl:call-template name="ProdLiciSinIva"/>
		<!--
        <xsl:choose>
           <xsl:when test="not(/FichaProductoLic/PRODUCTOLICITACION/MOSTRAR_PRECIO_IVA)"><xsl:call-template name="ProdLiciSinIva"/></xsl:when>
            <xsl:otherwise><xsl:call-template name="ProdLiciConIva"/></xsl:otherwise>
        </xsl:choose>
		-->
        <div class="divLeft" style="margin-top:20px">
		<!--<table class="infoTable">-->
		<table class="buscador">
			<tr id="lMotivo" name="lMotivo">
				<!--
				<xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/IDMOTIVOSELECCION != ''">
				<xsl:attribute name="style">visibility:hidden</xsl:attribute>
				</xsl:if>
				-->
				<td colspan="7">&nbsp;
					<!--	24oct16	Motivo por el que se selecciona un producto que no es el m�s barato		-->
					<xsl:choose>
					<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/IDMOTIVOSELECCION">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='motivo']/node()"/>:
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="/FichaProductoLic/PRODUCTOLICITACION/IDMOTIVOSELECCION/field"/>
						</xsl:call-template>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<xsl:value-of select="document($doc)/translation/texts/item[@name='explicacion']/node()"/>:&nbsp;
						<input type="inputext" size="60" name="MOTIVOSELECCION" id="MOTIVOSELECCION" value="{/FichaProductoLic/PRODUCTOLICITACION/LIC_PROD_MOTIVOSELECCION}"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="hidden" name="IDMOTIVOSELECCION" value=""/>
						<input type="hidden" name="MOTIVOSELECCION" value=""/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
		</table>
		</div><!--fin de divLeft-->
        <div class="divLeft" style="margin-top:20px">
		<!--<table class="infoTable" border="0">-->
		<table class="buscador">
		<tfoot>
			<tr class="lejenda lineBorderBottom3" style="background:#E4E4E5;padding-top:3px;font-weight:bold;">
				<td colspan="4" class="datosLeft" style="padding:3px 0px 0px 20px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda']/node()"/>:</td>
			</tr>

            <tr class="lineBorderBottom5">
				<td class="tres">&nbsp;</td>
            <td class="trenta datosLeft">
				<p>
					&nbsp;&nbsp;&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/actualizarFlecha.gif" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar_evaluacion_producto']/node()"/><br/>
					&nbsp;&nbsp;&nbsp;&nbsp;<span style="background-color:#FFFF99;height:3px;width:10px;">&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='mejor_precio']/node()"/><br/>
					&nbsp;&nbsp;&nbsp;&nbsp;<span class="rojo2">&nbsp;?&nbsp;</span>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_oferta_sospechoso']/node()"/><br/>
               </p>
			</td>
			<td class="trenta datosLeft">
				<p>
					&nbsp;<span style="color:orange;font-weight:bold;height:3px;">1,0000</span>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_igual']/node()"/><br/>
					&nbsp;<span style="color:red;font-weight:bold;height:3px;">1,0000</span>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_superior']/node()"/><br/>
					&nbsp;<span style="color:green;font-weight:bold;height:3px;">1,0000</span>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_inferior']/node()"/><br/>
				</p>
			</td>
			<td>&nbsp;</td>
            </tr>
		</tfoot>
		</table>
        </div>
        <br/><br/>
  </div>
  </form>

	<!-- Tabla Datos Cliente (compras por centro) -->
	<xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/LICITACION_AGREGADA">
	<div class="divLeft" id="lInfoCli" style="display:none;margin-top:29px">
	<xsl:choose>
	<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/COMPRAPORCENTRO/VER_PRECIOS">
		<form name="cantidadPorCentro">
		<table class="buscador" id="tblCentros">
			<tr class="subTituloTabla" id="cabTablaCentros">
				<th class="tres">&nbsp;</th>
				<th class="trenta textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
				<th class="trenta textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='marcas']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
				<xsl:choose>
					<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/PERMITIR_MODIFICAR_CANTIDADES">
						<th class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ud_por_lote']/node()"/></th>
						<th class="textLeft" colspan="3"><xsl:copy-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
					</xsl:when>
					<xsl:otherwise>
						<th class="textLeft"><xsl:copy-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
					</xsl:otherwise>
				</xsl:choose>
				<th>&nbsp;</th>
			</tr>
		<xsl:choose>
		<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/COMPRAPORCENTRO/PRODUCTO">
			<xsl:for-each select="/FichaProductoLic/PRODUCTOLICITACION/COMPRAPORCENTRO/PRODUCTO/CENTRO">
				<tr class="gris">
					<td><xsl:value-of select="LINEA"/>&nbsp;</td>
					<td class="textLeft"><xsl:value-of select="NOMBRE"/>&nbsp;</td>
					<td class="textLeft"><xsl:value-of select="LIC_CC_MARCASACEPTABLES"/>&nbsp;</td>
					<xsl:choose>
						<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/PERMITIR_MODIFICAR_CANTIDADES">
							<td style="align:left;"><input name="Cantidad_{CEN_ID}" id="Cantidad_{CEN_ID}" value="{CANTIDAD_SINFORMATO}" class="cantidad" size="8" maxlength="8" type="text"/></td><td class="acciones"><a href="javascript:guardarDatosCompraCentro({CEN_ID})" class="btnDestacado guardarOferta" style="text-decoration:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/><!--<img src="http://www.newco.dev.br/images/guardar.gif" class="" title="Guardar" alt="Guardar"/>--></a></td><td id="Resultado_{CEN_ID}" class="resultado">&nbsp;</td>
						</xsl:when>
						<xsl:otherwise>
							<td style="align:right;"><input name="Cantidad_{CEN_ID}" id="Cantidad_{CEN_ID}" value="{CANTIDAD_SINFORMATO}" type="hidden"/><xsl:value-of select="LIC_CC_CANTIDAD"/>&nbsp;</td><!--class="textRight"  -->
						</xsl:otherwise>
					</xsl:choose>
					<td>&nbsp;</td>
				</tr>
			</xsl:for-each>
		</xsl:when>
		<xsl:otherwise>
			<tr style="border-bottom:1px solid #A7A8A9;">
				<td align="center" colspan="4">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='no_datos_disponibles']/node()"/>
				</td>
			</tr>
		</xsl:otherwise>
		</xsl:choose>
		</table>
		</form>
	</xsl:when>
	<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/COMPRAPORCENTRO/VER_PROVEEDORES">
		<form name="cantidadPorCentro">
		<table class="grandeInicio">
			<tr class="tituloTabla">
				<th class="quince">&nbsp;</th>
				<th class="trenta textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
				<xsl:choose>
					<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/PERMITIR_MODIFICAR_CANTIDADES">
						<th class="dies textLeft" colspan="3"><xsl:copy-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
					</xsl:when>
					<xsl:otherwise>
						<th class="seis textLeft"><xsl:copy-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
					</xsl:otherwise>
				</xsl:choose>
				<th>&nbsp;</th>
			</tr>

		<xsl:choose>
		<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/COMPRAPORCENTRO/PRODUCTO">
			<xsl:for-each select="/FichaProductoLic/PRODUCTOLICITACION/COMPRAPORCENTRO/PRODUCTO/CENTRO">
				<tr class="gris">
					<td>&nbsp;</td>
					<td class="label textLeft"><xsl:value-of select="NOMBRE"/>&nbsp;</td>
					<xsl:choose>
						<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/PERMITIR_MODIFICAR_CANTIDADES">
							<td style="align:left;"><input name="Cantidad_{CEN_ID}" id="Cantidad_{CEN_ID}" value="{LIC_CC_CANTIDAD}" class="cantidad" size="8" maxlength="8" type="text"/></td><td class="acciones"><a href="javascript:guardarDatosCompraCentro({CEN_ID})" class="guardarOferta" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/guardar.gif" class="" title="Guardar" alt="Guardar"/></a></td><td id="Resultado_{CEN_ID}" class="resultado">&nbsp;</td>
						</xsl:when>
						<xsl:otherwise>
							<td style="align:right;"><xsl:value-of select="LIC_CC_CANTIDAD"/>&nbsp;</td><!--class="textRight"  -->
						</xsl:otherwise>
					</xsl:choose>
					<td>&nbsp;</td>
				</tr>
			</xsl:for-each>
		</xsl:when>
		<xsl:otherwise>
			<tr style="border-bottom:1px solid #A7A8A9;">
				<td align="center" colspan="4">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='no_datos_disponibles']/node()"/>
				</td>
			</tr>
		</xsl:otherwise>
		</xsl:choose>
		</table>
		</form>
		</xsl:when>
		</xsl:choose>

	</div>
	
	<xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/PRODUCTOESTANDAR/ADMIN or (/FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION='EST' and /FichaProductoLic/PRODUCTOLICITACION/RESPONSABLE_CENTRO)">
		<!-- DIV Info Historica -->
		<div class="overlay-container" id="InfoHistorica">
			<div class="window-container zoomout">
			<p style="text-align:right;">
				<a href="javascript:showTabla(false);" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/cerrar.gif" /></a>&nbsp;
				<!-- <a href="javascript:showTabla(false);">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
				</a>-->
			</p>

			<p id="tableTitle">

				<span id="modDatos" style="display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='modifica_datos_para_centro']/node()"/>&nbsp;"<span id="NombreCentro"></span>"</span>
				<span id="newDatos" style="display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='entrada_datos_para_centro']/node()"/></span>
			</p>

			<div id="mensError" class="divLeft" style="display:none;">
				<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></strong></p>
			</div>

			<form name="entradaDatosForm" method="post" id="entradaDatosForm">
			<input type="hidden" name="ID" id="ID"/>
			<input type="hidden" name="IDEMPRESA" id="IDEMPRESA" value="{/FichaProductoLic/PRODUCTOLICITACION/PRODUCTOESTANDAR/IDEMPRESA}"/>
			<input type="hidden" name="IDPRODESTANDAR" id="IDPRODESTANDAR" value="{/FichaProductoLic/PRODUCTOLICITACION/PRODUCTOESTANDAR/CP_PRO_ID}"/>

			<table style="width:100%;">
			<thead>
				<tr><th colspan="6">&nbsp;</th></tr>
			</thead>

			<tbody>
				<tr id="trIDCentro" style="display:none;">
					<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/><span class="rojoNormal">*</span>:</strong></td>
					<td colspan="4">
						<select name="IDCENTRO" id="IDCENTRO" style="width:70%;float:left;">
							<option value=""><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciona']/node()"/></option>
							<xsl:for-each select="/FichaProductoLic/PRODUCTOLICITACION/PRODUCTOESTANDAR/LISTACENTROS/field/dropDownList/listElem">
								<option value="{ID}"><xsl:value-of select="listItem"/></option>
							</xsl:for-each>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>

				<tr>
					<td colspan="6">
					<table style="width:100%;">
						<tr>
							<td class="quince"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:</strong></td>
							<td class="sesanta"><input type="text" name="NOMBRE" id="NOMBRE" style="width:100%;float:left;"/></td>
							<td>&nbsp;</td>
							<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:</strong></td>
							<td><input type="text" name="REFCLI" id="REFCLI" style="width:100%;float:left;"/></td>
							<td class="uno">&nbsp;</td>
						</tr>
					</table>
					</td>
				</tr>

				<tr>
					<td class="quince"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</strong></td>
					<td><input type="text" name="PROVEEDOR" id="PROVEEDOR" style="width:100%;float:left;"/></td>
					<td>&nbsp;</td>
					<td class="quince"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/>:</strong></td>
					<td><input type="text" name="REFPROV" id="REFPROV" style="width:100%;float:left;"/></td>
					<td class="uno">&nbsp;</td>
				</tr>

				<tr>
					<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica_abr']/node()"/><span class="rojoNormal">*</span>:</strong></td>
					<td><input type="text" name="UDBASICA" id="UDBASICA" style="width:100%;float:left;"/></td>
					<td>&nbsp;</td>
					<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_por_lote']/node()"/>:</strong></td>
					<td><input type="text" name="UDSLOTE" id="UDSLOTE" style="width:100%;float:left;"/></td>
					<td>&nbsp;</td>
				</tr>

				<tr>
					<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>:</strong></td>
					<td><input type="text" name="PRECIO" id="PRECIO" style="width:100%;float:left;"/></td>
					<td>&nbsp;</td>
					<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_anual']/node()"/><span class="rojoNormal">*</span>:</strong></td>
					<td><input type="text" name="CANTIDAD" id="CANTIDAD" style="width:100%;float:left;"/></td>
					<td>&nbsp;</td>
				</tr>

				<tr>
					<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='anotaciones']/node()"/>:</strong></td>
					<td colspan="4"><textarea name="ANOTACIONES" id="ANOTACIONES" rows="4" style="width:100%;float:left;"/></td>
					<td>&nbsp;</td>
				</tr>
			</tbody>

			<tfoot>
				<tr>
					<td>&nbsp;</td>
					<td>
						<div class="boton" id="GuardarDatos">
							<a href="javascript:validarForm();">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
							</a>
						</div>
					</td>
					<td id="Respuesta" colspan="4" style="text-align:left;"></td>
				</tr>
			</tfoot>
			</table>
			</form>
		</div>
	</div>
	<!-- FIN DIV Info Historica -->
	</xsl:if>

	</xsl:if>


	<!-- Tabla Datos pedidos (compras por centro) -->
	<xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/LICITACION_MULTIPEDIDO">
	<div class="divLeft" id="lInfoPed" style="display:none;">
	<xsl:choose>
	<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/PEDIDOSPORCENTRO/VER_PRECIOS">
		<form name="cantidadPorPedido">
		<table class="buscador">
			<tr class="subTituloTabla">
				<th class="quince">&nbsp;</th>
				<th class="trenta textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
				<xsl:choose>
					<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/PERMITIR_MODIFICAR_CANTIDADES">
						<th class="dies textLeft"><xsl:copy-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
						<th class="dies textLeft"><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha_entrega']/node()"/></th>
						<th class="dies textLeft">&nbsp;</th>
					</xsl:when>
					<xsl:otherwise>
						<th class="seis textLeft"><xsl:copy-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
						<th class="seis textLeft"><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha_entrega']/node()"/></th>
					</xsl:otherwise>
				</xsl:choose>
				<th>&nbsp;</th>
			</tr>
		<xsl:choose>
		<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/PEDIDOSPORCENTRO/PRODUCTO">
			<xsl:for-each select="/FichaProductoLic/PRODUCTOLICITACION/PEDIDOSPORCENTRO/PRODUCTO/CENTRO">
				<xsl:for-each select="PEDIDO">
					<tr class="gris">
						<td>&nbsp;</td>
						<td class="label textLeft"><xsl:value-of select="../NOMBRE"/>&nbsp;</td>
						<xsl:choose>
							<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/PERMITIR_MODIFICAR_CANTIDADES">
								<td style="align:left;"><input name="Cantidad_{../CEN_ID}_{LIC_PP_ID}" id="Cantidad_{../CEN_ID}_{LIC_PP_ID}" value="{CANTIDAD_SINFORMATO}" class="cantidad peq" size="8" maxlength="8" type="text"/></td>
								<td style="align:right;"><xsl:value-of select="FECHA_ENTREGA"/><input type="hidden" name="FechaEntrega_{../CEN_ID}_{LIC_PP_ID}" id="FechaEntrega_{../CEN_ID}_{LIC_PP_ID}" value="{FECHA_ENTREGA}"/>&nbsp;</td><!--class="textRight"  -->
								<td class="acciones">
								<a href="javascript:guardarDatosPedidoCentro('{../CEN_ID}', '{LIC_PP_ID}');" class="guardarPedido" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/guardar.gif" class="" title="Guardar" alt="Guardar"/></a>
								<a href="javascript:borrarPedidoCentro('{../CEN_ID}', '{LIC_PP_ID}');" class="borrarPedido" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/2017/trash.png" alt="Eliminar" title="Eliminar"/></a>
								</td>
								<td id="Resultado_{../CEN_ID}" class="resultado">&nbsp;</td>
							</xsl:when>
							<xsl:otherwise>
								<td style="align:right;"><xsl:value-of select="LIC_PP_CANTIDAD"/>&nbsp;</td><!--class="textRight"  -->
								<td style="align:right;"><xsl:value-of select="FECHA_ENTREGA"/>&nbsp;</td><!--class="textRight"  -->
							</xsl:otherwise>
						</xsl:choose>
						<!--<td>&nbsp;</td>-->
					</tr>
				</xsl:for-each>
			</xsl:for-each>
		</xsl:when>
		<xsl:otherwise>
			<tr style="border-bottom:1px solid #A7A8A9;">
				<td align="center" colspan="4">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='no_datos_disponibles']/node()"/>
				</td>
			</tr>
		</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/PERMITIR_MODIFICAR_CANTIDADES">
			<td>&nbsp;</td>
			<td class="label textLeft">				
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/FichaProductoLic/PRODUCTOLICITACION/PEDIDOSPORCENTRO/LISTACENTROS/field"/>
				</xsl:call-template>
			</td>
			<td style="align:left;"><input name="Cantidad_Nuevo" id="Cantidad_Nuevo" value="{CANTIDAD_SINFORMATO}" class="cantidad peq" size="8" maxlength="8" type="text"/></td>
			<td style="align:right;"><input class="peq" size="8" maxlength="8" type="text" name="FechaEntrega_Nuevo" id="FechaEntrega_Nuevo" value="{FECHA_ENTREGA}"/>&nbsp;</td><!--class="textRight"  -->
			<td class="acciones">
				<a href="javascript:guardarDatosNuevoPedido();" class="guardarPedido" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/guardar.gif" class="" title="Guardar" alt="Guardar"/>				</a>
			</td>
			<td id="Resultado_{../CEN_ID}" class="resultado">&nbsp;</td>
		</xsl:if>
		</table>
		</form>
	</xsl:when>
	<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/COMPRAPORCENTRO/VER_PROVEEDORES">
		<form name="cantidadPorCentro">
		<table class="grandeInicio">
			<tr class="tituloTabla">
				<th class="quince">&nbsp;</th>
				<th class="trenta textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
				<xsl:choose>
					<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/PERMITIR_MODIFICAR_CANTIDADES">
						<th class="dies textLeft" colspan="3"><xsl:copy-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
					</xsl:when>
					<xsl:otherwise>
						<th class="seis textLeft"><xsl:copy-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
					</xsl:otherwise>
				</xsl:choose>
				<th>&nbsp;</th>
			</tr>
		<xsl:choose>
		<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/COMPRAPORCENTRO/PRODUCTO">
			<xsl:for-each select="/FichaProductoLic/PRODUCTOLICITACION/COMPRAPORCENTRO/PRODUCTO/CENTRO">
				<tr class="gris">
					<td>&nbsp;</td>
					<td class="label textLeft"><xsl:value-of select="NOMBRE"/>&nbsp;</td>
					<xsl:choose>
						<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/PERMITIR_MODIFICAR_CANTIDADES">
							<td style="align:left;"><input name="Cantidad_{CEN_ID}" id="Cantidad_{CEN_ID}" value="{LIC_CC_CANTIDAD}" class="cantidad" size="8" maxlength="8" type="text"/></td><td class="acciones"><a href="javascript:guardarDatosCompraCentro({CEN_ID})" class="guardarOferta" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/guardar.gif" class="" title="Guardar" alt="Guardar"/></a></td><td id="Resultado_{CEN_ID}" class="resultado">&nbsp;</td>
						</xsl:when>
						<xsl:otherwise>
							<td style="align:right;"><xsl:value-of select="LIC_CC_CANTIDAD"/>&nbsp;</td><!--class="textRight"  -->
						</xsl:otherwise>
					</xsl:choose>
					<td>&nbsp;</td>
				</tr>
			</xsl:for-each>
		</xsl:when>
		<xsl:otherwise>
			<tr style="border-bottom:1px solid #A7A8A9;">
				<td align="center" colspan="4">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='no_datos_disponibles']/node()"/>
				</td>
			</tr>
		</xsl:otherwise>
		</xsl:choose>
		</table>
		</form>
		</xsl:when>
		</xsl:choose>

	</div>
	</xsl:if>


<xsl:if test="PRODUCTOLICITACION/AUTOR">
	<!-- DIV CamposAvanzados -->
	<div class="overlay-container" id="CamposAvanzados">
		<div class="window-container zoomout">
			<p><a href="javascript:showTabla(false);"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a></p>
			<form name="CamposAvanzadosForm" method="post" id="CamposAvanzadosForm">
			<input type="hidden" name="CADENA_DOCUMENTOS"/>
			<table>
			<thead>
				<th colspan="3">&nbsp;</th>
			</thead>

			<tbody>
				<tr>
					<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='info_ampliada']/node()"/>:</strong></td>
					<td colspan="2"><textarea name="txtInfoAmpliada" id="txtInfoAmpliada" rows="4" cols="70" style="float:left;"/></td>
				</tr>

				<tr style="height:80px;">
					<td class="veinte"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/>:</strong></td>
					<td class="">
						<input type="file" name="inputFileDoc" id="inputFileDoc_CA" onchange="subirDoc('LIC_OFERTA_FT');" style="float:left;"/>
						<span id="DocCargado" style="float:left;display:none;"><span id="NombreDoc"></span>&nbsp;<a href="javascript:borrarDoc2('LIC_OFERTA_FT');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></span>
						<input type="hidden" name="IDDOC" id="IDDOC"/>
					</td>
					<td class="trenta">
						<div id="waitBoxDoc_CA" align="center">&nbsp;</div>
						<div id="confirmBox_CA" style="display:none;" align="center">
							<span class="cargado" style="font-size:10px;">?<xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/>!</span>
						</div>
					</td>
				</tr>
			</tbody>

			<tfoot>
				<tr>
					<td>&nbsp;</td>
					<td colspan="2">
						<input type="hidden" name="IDOferta" id="IDOferta"/>
						<div class="boton">
							<a href="javascript:guardarCamposAvanzadosOfe2();">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
							</a>
						</div>
					</td>
				</tr>
			</tfoot>
			</table>
			</form>
		</div>
	</div>
	<!-- FIN DIV CamposAvanzados -->

	<div id="uploadFrameBox" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>
	<div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>
</xsl:if>
	</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>

<xsl:template name="ProdLiciSinIva">
    <!--idioma-->
    <xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
    </xsl:variable>
    <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
    <!--idioma fin-->
    
    <!--<table class="infoTable" id="lDatosOfertas">-->
    <table class="buscador" id="lDatosOfertas">
    	<thead>
			<tr class="subtituloTabla">
				<td class="uno"></td>
				<td class="seis"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_oferta']/node()"/></td>
				<td class="quince" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></td>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/></td>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/></td>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></td>
				<xsl:if test="PRODUCTOLICITACION/INCLUIR_COLUMNA_DOCUMENTOS">
					<td style="width:100px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ver_doc']/node()"/></td>
				</xsl:if>
			<xsl:choose>
			<xsl:when test="PRODUCTOLICITACION/IDPAIS = '55'">
				<td class="zerouno">&nbsp;</td>
			</xsl:when>
			<xsl:otherwise>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/></td>
			</xsl:otherwise>
			</xsl:choose>
				<td class="zerouno">&nbsp;</td><!-- columna icono anyadir campos avanzados -->
				<td class="cinco" ><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></td>
				<td ><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></td>
				<td>&nbsp;</td><!-- columna iconos FT y campos avanzados informados -->
				<td style="width:80px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='lic_marca']/node()"/></td>
				<xsl:if test="PRODUCTOLICITACION/CDC"><td style="width:20px;">&nbsp;<a href="javascript:IncluirMarcas();"><xsl:value-of select="document($doc)/translation/texts/item[@name='Incluir_marcas']/node()"/></a></td></xsl:if>
				<td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ud_por_lote']/node()"/></td>
				<td style="width:100px;" colspan="2"><a href="javascript:ordenAutomatico();"><xsl:copy-of select="document($doc)/translation/texts/item[@name='seleccionar']/node()"/></a></td>
				<td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_2line']/node()"/></td>
				<td class="uno">&nbsp;</td>
				<!--20may19	<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></td>-->
				<td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_sIVA_2line']/node()"/></td>
				<xsl:if test="PRODUCTOLICITACION/IDPAIS != '55'">
					<td class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></td>
				</xsl:if>
                <xsl:if test="PRODUCTOLICITACION/CDC and PRODUCTOLICITACION/IDPAIS != '55'">
					<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado_evaluacion']/node()"/></td>
					<td class="tres">&nbsp;</td>
				</xsl:if>
				<td class="uno">&nbsp;</td>
				<td class="uno">&nbsp;</td>
				<td class="dos">&nbsp;</td>
			</tr>
			<xsl:if test="PRODUCTOLICITACION/BOTON_PEDIDO">
				<tr class="subtituloTabla">
					<td colspan="23" align="right"><xsl:value-of select="document($doc)/translation/texts/item[@name='Centro_pedido']/node()"/>:&nbsp;
						<!-- desplegable de centros a los que se les puede enviasr el pedido	-->
						<select name="IDCentroPedido" id="IDCentroPedido" onchange="javascript:CambioCentro();">
							<xsl:for-each select="PRODUCTOLICITACION/COMPRAPORCENTRO/PRODUCTO/CENTRO">
								<xsl:if test="CANTIDAD_SINFORMATO>0">
									<option value="{CEN_ID}"><xsl:value-of select="NOMBRE"/>:&nbsp;<xsl:value-of select="LIC_CC_CANTIDAD"/></option>
								</xsl:if>
							</xsl:for-each>
						</select>
						&nbsp;
					</td>
				</tr>
			</xsl:if>
		</thead>
		<tbody>
		<!--<br/>
		<br/>-->
		<xsl:choose>
		<xsl:when test="PRODUCTOLICITACION/OFERTAS/OFERTA">
		<xsl:for-each select="PRODUCTOLICITACION/OFERTAS/OFERTA">
			<tr id="OFE_{LIC_OFE_ID}" class="filaOferta">
				<!-- 21oct20 Equipo Brasil solicita quitar los colores para la demo en Brasil, habr� que revisar como indicar estos estados de forma m�s discreta
				<xsl:attribute name="style">
				<xsl:choose>
					<xsl:when test="LIC_OFE_PORPRODUCTOADJUDICADO='S'">background:#75B4EE;</xsl:when>
					<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/PRODUCTO_BLOQUEADO_POR_PEDIDOS and PROVEEDOR_BLOQUEADO_POR_PEDIDOS">background:#4E9A06;</xsl:when>
					<xsl:when test="not(/FichaProductoLic/PRODUCTOLICITACION/PRODUCTO_BLOQUEADO_POR_PEDIDOS) and PROVEEDOR_BLOQUEADO_POR_PEDIDOS">background:#CC0000;</xsl:when>
				</xsl:choose>
				</xsl:attribute>
				-->
				<!--	31ago16	Incluimos un contador, y un fonde de color seg�n la valoraci�n de la documentaci�n	-->
				<td>
					<xsl:if test="../../IDPAIS = '55'">
					<xsl:attribute name="style">
						<xsl:choose>
							<xsl:when test="EMP_NIVELDOCUMENTACION='R'">background:#CC0000;</xsl:when>	
							<xsl:when test="EMP_NIVELDOCUMENTACION='A'">background:#F57900;</xsl:when>	
							<xsl:when test="EMP_NIVELDOCUMENTACION='V'">background:#4E9A06;</xsl:when>	
						</xsl:choose>
					</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="PRODUCTOLICITACION/IDPAIS"/><xsl:value-of select="CONTADOR"/>
				</td>

			
				<!-- Fecha Oferta -->
				<td>
					<a href="http://www.newco.dev.br/Gestion/Comercial/ImprimirOferta.xsql?LIC_ID={/FichaProductoLic/LIC_ID}&amp;LIC_PROV_ID={LIC_OFE_IDPROVEEDORLIC}">
						<xsl:choose>
						<xsl:when test="LIC_OFE_FECHAMODIFICACION != ''">
							<xsl:value-of select="LIC_OFE_FECHAMODIFICACION"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="LIC_OFE_FECHAALTA"/>
						</xsl:otherwise>
						</xsl:choose>
					</a>
                </td>
				<!-- Nombre Proveedor + indicacion pedido minimo-->
				<td style="text-align:left;">
					<xsl:if test="NO_CUMPLE_PEDIDO_MINIMO">
						<img src="http://www.newco.dev.br/images/urgente.gif"/>
					</xsl:if>
					
					<xsl:if test="../../BOTON_CATALOGO">
						<xsl:choose>
						<xsl:when test="PRODUCTOESTANDAR">
							<a class="btnDestacado" id="btnVerProdEstandar_{LIC_OFE_ID}" href="javascript:VerProductoEstandar({/FichaProductoLic/PRODUCTOLICITACION/IDEMPRESA},{LIC_OFE_IDPRODUCTO});"><xsl:value-of select="PRODUCTOESTANDAR/CP_PRO_REFERENCIA"/></a>
							&nbsp;
						</xsl:when>
						<xsl:otherwise>
							<a class="btnDestacado" id="btnCatalogo_{LIC_OFE_ID}" href="javascript:CatalogarOferta({LIC_OFE_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='incluir']/node()"/></a>
							&nbsp;
						</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					
					<a href="javascript:FichaEmpresa({IDPROVEEDOR},'DOCUMENTOS');">
					<xsl:value-of select="PROVEEDOR"/>
					</a>
					<input type="hidden" name="Proveedor_{LIC_OFE_ID}" id="Proveedor_{LIC_OFE_ID}" value="{PROVEEDOR}"/>
				</td>
				<!--	31ago16	nuevas columnas de pedido minimo y consumo adjudicado	-->
				<td><input type="hidden" name="PEDMINIMO_{LIC_OFE_ID}" id="PEDMINIMO_{LIC_OFE_ID}" value="{LIC_PROV_PEDIDOMINIMO}"/><xsl:value-of select="LIC_PROV_PEDIDOMINIMO"/></td>
				<td><xsl:value-of select="LIC_PROV_PLAZOENTREGA"/></td>
				<td><xsl:value-of select="LIC_PROV_CONSUMOADJUDICADO"/></td>
				<xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/INCLUIR_COLUMNA_DOCUMENTOS">
					<td>
						&nbsp;
						<xsl:if test="FICHA_TECNICA/ID">
							<a href="http://www.newco.dev.br/Documentos/{FICHA_TECNICA/URL}" target="_blank" style="text-decoration:none;">
								<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='ficha_tecnica']/node()"/></xsl:attribute>
								<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='ficha_tecnica']/node()"/></xsl:attribute>
								FT
							</a>
						&nbsp;
						</xsl:if>
						<xsl:if test="REGISTRO_SANITARIO/ID">
							<a href="http://www.newco.dev.br/Documentos/{REGISTRO_SANITARIO/URL}" target="_blank" style="text-decoration:none;">
								<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='registro_sanitario']/node()"/></xsl:attribute>
								<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='registro_sanitario']/node()"/></xsl:attribute>
								RS
							</a>
						&nbsp;
						</xsl:if>
						<xsl:if test="CERTIFICADO_EXPERIENCIA/ID">
							<a href="http://www.newco.dev.br/Documentos/{CERTIFICADO_EXPERIENCIA/URL}" target="_blank" style="text-decoration:none;">
								<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='cert_experiencia']/node()"/></xsl:attribute>
								<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='cert_experiencia']/node()"/></xsl:attribute>
								CE
							</a>
						</xsl:if>
					</td>
				</xsl:if>
			<xsl:choose>
			<xsl:when test="LIC_OFE_PRECIOIVA = '0,0000' and LIC_OFE_UNIDADESPORLOTE = '0'">
				<td style="text-align:center;">
					<xsl:attribute name="colspan">
						<xsl:choose>
						<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/IDPAIS != '55'">14</xsl:when>
						<xsl:otherwise>13</xsl:otherwise>
						</xsl:choose>
                    </xsl:attribute>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_no_ofertada']/node()"/>
				</td>
			</xsl:when>
			<xsl:otherwise>
				<!-- Ref.Proveedor -->
				<td>
				<input type="hidden" name="IDProveedorLic_{LIC_OFE_ID}" id="IDProveedorLic_{LIC_OFE_ID}" value="{LIC_OFE_IDPROVEEDORLIC}"/>
				<input type="hidden" name="Cant_{LIC_OFE_ID}" id="Cant_{LIC_OFE_ID}" value="{LIC_OFE_CANTIDAD}"/>
				<input type="hidden" name="TIVA_{LIC_OFE_ID}" id="TIVA_{LIC_OFE_ID}" value="{LIC_OFE_TIPOIVA}"/>
				<input type="hidden" name="FT_{LIC_OFE_ID}" id="FT_{LIC_OFE_ID}" value="{FICHA_TECNICA}"/>

				<xsl:choose>
				<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/IDPAIS = '55'">
					&nbsp;
				</xsl:when>
				<xsl:otherwise>
					<!--<a href="javascript:FichaProductoOfe('{/FichaProductoLic/PRODUCTOLICITACION/LIC_PROD_ID}','{LIC_OFE_ID}');" id="RefProv_{LIC_OFE_ID}"><xsl:value-of select="LIC_OFE_REFERENCIA"/></a>-->
					<a href="javascript:FichaProductoOfe('{/FichaProductoLic/PRODUCTOLICITACION/LIC_PROD_ID}','{LIC_OFE_ID}');"><xsl:value-of select="LIC_OFE_REFERENCIA"/></a>
				</xsl:otherwise>
				</xsl:choose>
				</td>
<!--				<td><a href="javascript:FichaProductoOfe('{/FichaProductoLic/PRODUCTOLICITACION/LIC_PROD_ID}','{LIC_OFE_ID}');" id="RefProv_{LIC_OFE_ID}"><xsl:value-of select="LIC_OFE_REFERENCIA"/></a></td>-->

				<!-- Icono anyadir campos avanzados -->
				<td>
				<xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/AUTOR">
					<a href="javascript:abrirCamposAvanzadosOfe2({LIC_OFE_ID});">
						<img src="http://www.newco.dev.br/images/anadir.gif">
							<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='anyadir_info_ampliada']/node()"/></xsl:attribute>
							<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='anyadir_info_ampliada']/node()"/></xsl:attribute>
						</img>
					</a>
<!--					<input type="hidden" name="INFOAMPLIADA_{LIC_OFE_ID}" id="INFOAMPLIADA_{LIC_OFE_ID}" value="{LIC_OFE_INFOAMPLIADA}"/>-->
					<textarea name="INFOAMPLIADA_{LIC_OFE_ID}" id="INFOAMPLIADA_{LIC_OFE_ID}" style="display:none;">
						<xsl:copy-of select="LIC_OFE_INFOAMPLIADA/node()"/>
					</textarea>
					<input type="hidden" name="IDDOC_{LIC_OFE_ID}" id="IDDOC_{LIC_OFE_ID}" value="{DOCUMENTO/ID}"/>
					<input type="hidden" name="NOMBREDOC_{LIC_OFE_ID}" id="NOMBREDOC_{LIC_OFE_ID}" value="{DOCUMENTO/NOMBRE}"/>
				</xsl:if>
				</td>
				<!-- Referencia proveedor -->
				<td class="datosLeft">
					<xsl:choose>
					<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/AUTOR and (/FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'CURS' or /FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'INF')">
						<input type="text" class="peq" name="RefProv_{LIC_OFE_ID}" id="RefProv_{LIC_OFE_ID}" value="{LIC_OFE_REFERENCIA}" oninput="ActivarBotonGuardar({LIC_OFE_ID});"><!-- disabled="disabled"-->
							<xsl:if test="not (/FichaProductoLic/PRODUCTOLICITACION/MVM)">
								<xsl:attribute name="disabled">disabled</xsl:attribute>
							</xsl:if>
						</input>
					</xsl:when>
					<xsl:otherwise>
						<strong><xsl:value-of select="LIC_OFE_REFERENCIA"/></strong>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<!-- Nombre producto -->
				<td class="datosLeft">
					<xsl:choose>
					<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/AUTOR and (/FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'CURS' or /FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'INF')">
						<input type="text" class="muygrande" name="Desc_{LIC_OFE_ID}" id="Desc_{LIC_OFE_ID}" value="{LIC_OFE_NOMBRE}" oninput="ActivarBotonGuardar({LIC_OFE_ID});"><!-- disabled="disabled"-->
							<xsl:if test="not (/FichaProductoLic/PRODUCTOLICITACION/MVM)">
								<xsl:attribute name="disabled">disabled</xsl:attribute>
							</xsl:if>
						</input>
					</xsl:when>
					<xsl:otherwise>
						<strong><xsl:value-of select="LIC_OFE_NOMBRE"/></strong>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<!-- Iconos FT y campos avanzados -->
				<td  style="display:table-cell;">
				<!--
				<xsl:if test="FICHA_TECNICA/ID">
					<a href="http://www.newco.dev.br/Documentos/{FICHA_TECNICA/URL}" target="_blank" style="text-decoration:none;">
						<img src="http://www.newco.dev.br/images/fichaChange.gif">
							<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='ficha_tecnica']/node()"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='ficha_tecnica']/node()"/></xsl:attribute>
						</img>
					</a>
				</xsl:if>
				-->

				<xsl:if test="LIC_OFE_INFOAMPLIADA != ''">
					<a class="tooltip" href="#">
						<img class="static" src="http://www.newco.dev.br/images/infoAmpliadaIcon.gif"/>
						<span class="classic spanEIS">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='info_ampliada']/node()"/><br /><br />
							<xsl:copy-of select="LIC_OFE_INFOAMPLIADA/node()"/>
						</span>
					</a>
				</xsl:if>

				<xsl:if test="DOCUMENTO/ID">
					<a target="_blank" href="http://www.newco.dev.br/Documentos/{DOCUMENTO/URL}">
						<img class="static" src="http://www.newco.dev.br/images/clipIcon.gif">
							<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/></xsl:attribute>
						</img>
					</a>
				</xsl:if>
				</td>
				<td>
					<xsl:choose>
					<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/AUTOR and (/FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'CURS' or /FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'INF')">
						<input type="text" class="peq" name="Marca_{LIC_OFE_ID}" id="Marca_{LIC_OFE_ID}" value="{LIC_OFE_MARCA}" oninput="ActivarBotonGuardar({LIC_OFE_ID});"><!-- disabled="disabled"-->
							<xsl:if test="not (/FichaProductoLic/PRODUCTOLICITACION/MVM)">
								<xsl:attribute name="disabled">disabled</xsl:attribute>
							</xsl:if>
						</input>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="LIC_OFE_MARCA"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/CDC">
					<td>
						<input type="checkbox" class="muypeq chkmarca" name="chkMarca_{LIC_OFE_ID}" id="chkMarca_{LIC_OFE_ID}">
							<xsl:if test="MARCA_ACEPTABLE">
								<xsl:attribute name="disabled">disabled</xsl:attribute>
							</xsl:if>
						</input>
					</td>
				</xsl:if>

				<td>
				<xsl:choose>
				<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/AUTOR and (/FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'CURS' or /FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'INF')">
					<input type="text" class="peq" size="4" name="UdsLote_{LIC_OFE_ID}" id="UdsLote_{LIC_OFE_ID}" value="{LIC_OFE_UNIDADESPORLOTE}" oninput="ActivarBotonGuardar({LIC_OFE_ID});"><!-- disabled="disabled"-->
						<xsl:if test="not (/FichaProductoLic/PRODUCTOLICITACION/MVM or /FichaProductoLic/PRODUCTOLICITACION/MODIFICAR_PRECIO_OFERTA)">
							<xsl:attribute name="disabled">disabled</xsl:attribute>
						</xsl:if>
					</input>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="LIC_OFE_UNIDADESPORLOTE"/>
					<input type="hidden" name="UdsLote_{LIC_OFE_ID}" id="UdsLote_{LIC_OFE_ID}" value="{LIC_OFE_UNIDADESPORLOTE}"/>
				</xsl:otherwise>
				</xsl:choose>
					<xsl:if test="EMPAQUETAMIENTO_SOSPECHOSO">
						<span class="rojo2">&nbsp;?</span>
					</xsl:if>
				</td>

				<!-- checkbox o marca adjudicacion -->
					<xsl:choose>
					<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/LIC_MULTIOPCION = 'S'">
					<!--
					
					
						CUIDADO! LLEVAR LOS CAMBIOS AL BLOQUE "CON IVA"
					
					
					-->
						<td>
							<input type="hidden" id="CONT_{LIC_OFE_ID}" value="{CONTADOR}"/>
		            		<xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="ORDEN/field"/>
								<xsl:with-param name="nombre">ORDEN_<xsl:value-of select="LIC_OFE_ID"/></xsl:with-param>
								<xsl:with-param name="id">ORDEN_<xsl:value-of select="LIC_OFE_ID"/></xsl:with-param>
								<xsl:with-param name="style">width:50px;</xsl:with-param>
								<xsl:with-param name="onChange">javascript:cambioOrden(<xsl:value-of select="LIC_OFE_ID"/>);</xsl:with-param>
							</xsl:call-template>
						</td>
					</xsl:when>
					<!--29mar21	<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/LIC_AGREGADA != 'S'">-->
					
					<xsl:otherwise>
					
					
						<xsl:choose>
						<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/LIC_PORPRODUCTO = ''">
						<td>
							<xsl:if test="LIC_OFE_ADJUDICADA = 'S' and /FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION != 'CURS' and /FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION != 'INF'">
								<img src="http://www.newco.dev.br/images/check.gif">
									<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()"/></xsl:attribute>
									<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()"/></xsl:attribute>
								</img>
							</xsl:if>
						</td>
                    	</xsl:when>
						<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/LIC_PORPRODUCTO = 'S' and not(/FichaProductoLic/PRODUCTOLICITACION/AUTOR)">
						<td>
							<xsl:if test="LIC_OFE_ADJUDICADA = 'S' and /FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION != 'CURS' and /FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION != 'INF'">
								<img src="http://www.newco.dev.br/images/check.gif">
									<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()"/></xsl:attribute>
									<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()"/></xsl:attribute>
								</img>
							</xsl:if>
						</td>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
							<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'CURS' or /FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'INF'">
								<td>
									<input type="checkbox" name="ADJUD_{LIC_OFE_ID}" id="ADJUD_{LIC_OFE_ID}" class="muypeq" value="{LIC_OFE_ID}" onChange="javascript:SeleccionadaOferta({LIC_OFE_ID});">
										<xsl:if test="LIC_OFE_ADJUDICADA = 'S'">
											<xsl:attribute name="checked">checked</xsl:attribute>
										</xsl:if>
										<xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/PRODUCTO_BLOQUEADO_POR_PEDIDOS and PROVEEDOR_BLOQUEADO_POR_PEDIDOS">
											<xsl:attribute name="checked">checked</xsl:attribute>
											<xsl:attribute name="disabled">disabled</xsl:attribute>
										</xsl:if>
										<!--14set21 <xsl:if test="not(/FichaProductoLic/PRODUCTOLICITACION/PRODUCTO_BLOQUEADO_POR_PEDIDOS) and PROVEEDOR_BLOQUEADO_POR_PEDIDOS">
											<xsl:attribute name="style">display:none</xsl:attribute>
										</xsl:if>-->
										<!--14set21 <xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/PRODUCTO_BLOQUEADO_POR_PEDIDOS and not(PROVEEDOR_BLOQUEADO_POR_PEDIDOS)">
											<xsl:attribute name="style">display:none</xsl:attribute>
										</xsl:if>-->
									</input>
								</td>
								<td>
								<input type="textbox" name="CANTADJUD_{LIC_OFE_ID}" id="CANTADJUD_{LIC_OFE_ID}" class="peq" onChange="javascript:chCantidadAdjudicada({LIC_OFE_ID});">
									<xsl:if test="LIC_OFE_ADJUDICADA = 'S'">
										<xsl:attribute name="value"><xsl:value-of select="LIC_OFE_CANTIDADADJUDICADA"/></xsl:attribute>
									</xsl:if>
									<xsl:choose>
									<xsl:when test="LIC_OFE_ADJUDICADA = 'S' and(/FichaProductoLic/PRODUCTOLICITACION/PRODUCTO_BLOQUEADO_POR_PEDIDOS or PROVEEDOR_BLOQUEADO_POR_PEDIDOS)">
										<xsl:attribute name="disabled">disabled</xsl:attribute>
									</xsl:when>
									<xsl:when test="LIC_OFE_ADJUDICADA = 'N' and(/FichaProductoLic/PRODUCTOLICITACION/PRODUCTO_BLOQUEADO_POR_PEDIDOS or PROVEEDOR_BLOQUEADO_POR_PEDIDOS)">
										<xsl:attribute name="style">display:none</xsl:attribute>
									</xsl:when>	
									</xsl:choose>
								</input>
								</td>
							</xsl:when>
							<xsl:otherwise>
								<td>
								<xsl:if test="LIC_OFE_ADJUDICADA = 'S'">
									<img src="http://www.newco.dev.br/images/check.gif">
										<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()"/></xsl:attribute>
										<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()"/></xsl:attribute>
									</img>
								</xsl:if>
								</td>
							</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
                    	</xsl:choose>
					
					
					<!--29mar21		-->
					
					</xsl:otherwise>
					
					<!--29mar21	
					
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
						<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/LIC_PORPRODUCTO = ''">
							<xsl:if test="LIC_OFE_ADJUDICADA = 'S' and /FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION != 'CURS' and /FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION != 'INF'">
								<img src="http://www.newco.dev.br/images/check.gif">
									<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()"/></xsl:attribute>
									<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()"/></xsl:attribute>
								</img>
							</xsl:if>
                    	</xsl:when>
						<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/LIC_PORPRODUCTO = 'S' and not(/FichaProductoLic/PRODUCTOLICITACION/AUTOR)">
							<xsl:if test="LIC_OFE_ADJUDICADA = 'S' and /FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION != 'CURS' and /FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION != 'INF'">
								<img src="http://www.newco.dev.br/images/check.gif">
									<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()"/></xsl:attribute>
									<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()"/></xsl:attribute>
								</img>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
							<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'CURS' or /FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'INF'">
								<input type="radio" name="ADJUD_{LIC_OFE_ID}"  id="ADJUD_{LIC_OFE_ID}" class="ADJUD muypeq" value="{LIC_OFE_ID}" onChange="javascript:SeleccionadaOferta({LIC_OFE_ID});">
									<xsl:if test="LIC_OFE_ADJUDICADA = 'S'">
										<xsl:attribute name="checked">checked</xsl:attribute>
									</xsl:if>
								</input>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="LIC_OFE_ADJUDICADA = 'S'">
									<img src="http://www.newco.dev.br/images/check.gif">
										<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()"/></xsl:attribute>
										<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()"/></xsl:attribute>
									</img>
								</xsl:if>
							</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
                    	</xsl:choose>
					</xsl:otherwise>
					-->
				    </xsl:choose>
				<!--valor de precio-->
				<td id="PrOf_{LIC_OFE_ID}" class="PrecioOferta">
				<input type="hidden" name="PrecioOriginal_{LIC_OFE_ID}" id="PrecioOriginal_{LIC_OFE_ID}" value="{LIC_OFE_PRECIO}"/>
				<xsl:choose>
				<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'CURS' or /FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'INF'">
					<input type="text" class="peq" size="8" name="Precio_{LIC_OFE_ID}" id="Precio_{LIC_OFE_ID}" value="{LIC_OFE_PRECIO}" oninput="ActivarBotonGuardar({LIC_OFE_ID});"><!-- disabled="disabled"-->
						<xsl:attribute name="style">
							<xsl:choose>
							<xsl:when test="IGUAL">color:orange;font-weight:bold;</xsl:when>
							<xsl:when test="SUPERIOR">color:red;font-weight:bold;</xsl:when>
							<xsl:otherwise>color:green;font-weight:bold;</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
						<xsl:if test="not (/FichaProductoLic/PRODUCTOLICITACION/MVM or /FichaProductoLic/PRODUCTOLICITACION/MODIFICAR_PRECIO_OFERTA)">
							<xsl:attribute name="disabled">disabled</xsl:attribute>
						</xsl:if>
					</input>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
					<xsl:when test="IGUAL"><span class="precio" style="color:orange;font-weight:bold;"><xsl:value-of select="LIC_OFE_PRECIO"/></span>&nbsp;</xsl:when>
					<xsl:when test="SUPERIOR"><span class="precio" style="color:red;font-weight:bold;"><xsl:value-of select="LIC_OFE_PRECIO"/></span>&nbsp;</xsl:when>
					<xsl:otherwise><span class="precio" style="color:green;font-weight:bold;"><xsl:value-of select="LIC_OFE_PRECIO"/></span>&nbsp;</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
				</xsl:choose>
				</td>
				
				<td><!--6jul16	<span id="mas80_{LIC_OFE_ID}" style="display:none;" class="rojo2">?&nbsp;</span>-->
					<xsl:if test="SOSPECHOSO">
						<span class="naranja">&nbsp;?</span>
					</xsl:if>
					<xsl:if test="MUY_SOSPECHOSO">
						<span class="rojo2">&nbsp;?</span>
					</xsl:if>
				</td>
				
				<td>
					<!--	3jun19	Guardamos el consumo en un parrafo con id y nombre  para poderlo recalcular		-->
					<input type="hidden" name="CONSUMO_{LIC_OFE_ID}" id="CONSUMO_{LIC_OFE_ID}" value="{LIC_OFE_CONSUMO}"/>
					<p name="Consumo_{LIC_OFE_ID}" id="Consumo_{LIC_OFE_ID}"><xsl:value-of select="LIC_OFE_CONSUMO"/></p>
				</td>
                <xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/IDPAIS != '55'">
                    <td><xsl:value-of select="LIC_OFE_TIPOIVA"/>%</td>
                </xsl:if>

                <xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/CDC and /FichaProductoLic/PRODUCTOLICITACION/IDPAIS != '55'">
                	<xsl:choose>
                	<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION ='CURS' or /FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION ='INF'">
                    	<td>
                        	<select name="LIC_OFE_IDESTADOEVALUACION_{LIC_OFE_ID}" id="IDESTADO_{LIC_OFE_ID}" style="width:50px"><!-- class="select100"-->
                        	<xsl:for-each select="ESTADOSEVALUACION/field/dropDownList/listElem">
                                	<option value="{ID}">
                                        	<xsl:if test="ID = ../../@current">
                                                	<xsl:attribute name="selected">selected</xsl:attribute>
                                        	</xsl:if>
                                        	<xsl:value-of select="listItem"/>
                                	</option>
                        	</xsl:for-each>
                        	</select>&nbsp;
                        	<a href="javascript:CambiarEstadoOferta({LIC_OFE_ID});"><img src="http://www.newco.dev.br/images/actualizarFlecha.gif"/></a>
                    	</td>
                	</xsl:when>
                	<xsl:otherwise>
                        	<td><xsl:value-of select="ESTADOEVALUACION"/></td>
                	</xsl:otherwise>
                	</xsl:choose>

					<td><!--solicitar evaluacion-->
					<xsl:if test="LIC_OFE_PRECIOIVA != '0,0000' and LIC_OFE_UNIDADESPORLOTE != '0,00'">
    					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/NuevaEvaluacionProducto.xsql?PRO_ID_ESTANDAR={../../LIC_PROD_IDPRODESTANDAR}&amp;PRO_ID={../../LIC_OFE_IDPRODUCTO}&amp;LIC_OFE_ID={LIC_OFE_ID}','Evaluaci?n producto',100,80,0,-10);">
        					<xsl:choose>
        					<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/IDPAIS != '55'"><img src="http://www.newco.dev.br/images/evaluar.gif" alt="Evaluar"/></xsl:when>
        					<xsl:otherwise><img src="http://www.newco.dev.br/images/evaluar-BR.gif" alt="Avalia�ao"/></xsl:otherwise>
        					</xsl:choose>
    					</a>
					</xsl:if>
					</td>
					
                </xsl:if>
				<!-- Sem�foro asociado al pedido	-->
				<td>
					<xsl:if test="../../BOTON_PEDIDO and LIC_OFE_ADJUDICADA!='S'">
						<!-- Semaforo verde si existe pedido en estado 11, ambar en estado 13	-->
						<xsl:choose>
						<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/LIC_AGREGADA!='S'">
							<xsl:if test="MO_ID">
								<xsl:choose>
								<xsl:when test="MO_STATUS='11'"><img src="http://www.newco.dev.br/images/SemaforoVerde.gif"/></xsl:when>
								<xsl:otherwise><img src="http://www.newco.dev.br/images/SemaforoAmbar.gif"/></xsl:otherwise>
								</xsl:choose>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<img id="imgSemVerde_{LIC_OFE_ID}" src="http://www.newco.dev.br/images/SemaforoVerde.gif"/>
							<img id="imgSemAmbar_{LIC_OFE_ID}" src="http://www.newco.dev.br/images/SemaforoAmbar.gif"/>
						</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<xsl:if test="../../BOTON_PEDIDO">
						<input type="hidden" id="MO_ID_{LIC_OFE_ID}" value="{MO_ID}"/>
						<input type="hidden" id="MO_STATUS_{LIC_OFE_ID}" value="{MO_STATUS}"/>
						<input type="hidden" id="CODPEDIDO_{LIC_OFE_ID}" value="{CODPEDIDO}"/>
					</xsl:if>
				</td>
				<!-- Bot�n de pedido (cuando corresponda)	-->
				<td id="tdPedido_{LIC_OFE_ID}">
					<xsl:if test="../../BOTON_PEDIDO"><!-- and LIC_OFE_ADJUDICADA!='S'-->
						<xsl:choose>
						<xsl:when test="INCLUIDO_EN_PEDIDO">
							<a id="btnVerPedido_{LIC_OFE_ID}" href="javascript:VerPedido({MO_ID});"><xsl:value-of select="CODPEDIDO"/></a>
							<xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/LIC_AGREGADA='S'">
								<a class="btnDestacado" id="btnPedido_{LIC_OFE_ID}" href="javascript:Pedido({LIC_OFE_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/></a>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/LIC_AGREGADA='S'">
								<a id="btnVerPedido_{LIC_OFE_ID}" href="javascript:VerPedido({MO_ID});">SINPEDIDO</a>
							</xsl:if>
							<a class="btnDestacado" id="btnPedido_{LIC_OFE_ID}" href="javascript:Pedido({LIC_OFE_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/></a>
						</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
				</td>
				<td>
					<xsl:if test="not (../../BOTON_PEDIDO)">
						<a id="btnDescartar_{LIC_OFE_ID}" href="javascript:DescartarOferta({LIC_OFE_ID});"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>
					</xsl:if>
					<!--
					<a class="btnDestacadoPeq" id="btnGuardar_{LIC_OFE_ID}" href="javascript:guardarOferta({LIC_OFE_ID});" style="display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
					-->
				</td>

			</xsl:otherwise>
			</xsl:choose>
			</tr>

			<!--	Motivo por el que se descarta una oferta	-->
			<tr id="lMotivo_{LIC_OFE_ID}" name="lMotivo_{LIC_OFE_ID}" style="display:none;">
				<td colspan="6">AQUI&nbsp;</td>
				<td colspan="6">&nbsp;
					<xsl:choose>
					<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/IDMOTIVOSELECCION">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='motivo']/node()"/>:
						<xsl:call-template name="desplegable">
							<xsl:with-param name="nombre">IDMOTIVOSELECCION_<xsl:value-of select="LIC_OFE_ID"/></xsl:with-param>
							<xsl:with-param name="id">IDMOTIVOSELECCION_<xsl:value-of select="LIC_OFE_ID"/></xsl:with-param>
							<xsl:with-param name="path" select="/FichaProductoLic/PRODUCTOLICITACION/IDMOTIVOSELECCION/field"/>
						</xsl:call-template>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<xsl:value-of select="document($doc)/translation/texts/item[@name='explicacion']/node()"/>:&nbsp;
						<input type="inputext" size="60" name="MOTIVOSELECCION_{LIC_OFE_ID}" id="MOTIVOSELECCION_{LIC_OFE_ID}" value="{/FichaProductoLic/PRODUCTOLICITACION/LIC_PROD_MOTIVOSELECCION}"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="hidden" name="IDMOTIVOSELECCION_{LIC_OFE_ID}" value=""/>
						<input type="hidden" name="MOTIVOSELECCION_{LIC_OFE_ID}" value=""/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td colspan="4">&nbsp;
					<a class="btnDestacado" href="javascript:EjecDescartarOferta({LIC_OFE_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
					<a class="btnNormal" href="javascript:CancDescartarOferta({LIC_OFE_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/></a>
				</td>
			</tr>

			<!--	Motivo por el que se modifica un precio	-->
			<tr id="lMotivoPrecio_{LIC_OFE_ID}" name="lMotivoPrecio_{LIC_OFE_ID}" style="display:none;">
				<td colspan="6">AQUI2&nbsp;</td>
				<td colspan="6">&nbsp;
					<xsl:choose>
					<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/IDMOTIVOCAMBIOPRECIO">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='motivo']/node()"/>:
						<xsl:call-template name="desplegable">
							<xsl:with-param name="nombre">IDMOTIVOCAMBIOPRECIO_<xsl:value-of select="LIC_OFE_ID"/></xsl:with-param>
							<xsl:with-param name="id">IDMOTIVOCAMBIOPRECIO_<xsl:value-of select="LIC_OFE_ID"/></xsl:with-param>
							<xsl:with-param name="path" select="/FichaProductoLic/PRODUCTOLICITACION/IDMOTIVOCAMBIOPRECIO/field"/>
						</xsl:call-template>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<xsl:value-of select="document($doc)/translation/texts/item[@name='explicacion']/node()"/>:&nbsp;
						<input type="inputext" size="60" name="MOTIVOCAMBIOPRECIO_{LIC_OFE_ID}" id="MOTIVOCAMBIOPRECIO_{LIC_OFE_ID}" value="{LIC_OFE_MOTIVOCAMBIOPRECIO}"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="hidden" name="IDMOTIVOCAMBIOPRECIO_{LIC_OFE_ID}" value=""/>
						<input type="hidden" name="MOTIVOCAMBIOPRECIO_{LIC_OFE_ID}" value=""/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td colspan="4">&nbsp;
					<a class="btnDestacado" href="javascript:guardarOferta({LIC_OFE_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
					<a class="btnNormal" href="javascript:CancGuardarOferta({LIC_OFE_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/></a>
				</td>
			</tr>

		</xsl:for-each>
		</xsl:when>
		<xsl:otherwise>
			<tr>
				<td align="center">
					<xsl:attribute name="colspan">
						<xsl:choose>
						<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/IDPAIS != '55'">15</xsl:when>
						<xsl:otherwise>14</xsl:otherwise>
						</xsl:choose>
                    </xsl:attribute>
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion_sin_ofertas']/node()"/></strong>
				</td>
            </tr>
		</xsl:otherwise>
		</xsl:choose>
		
		
		<!--
		
		
		FILA ADICIONAL PARA ENTRADA DE OFERTAS MANUALES
		
		
		-->
		<xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/COMPRADOR_CREA_OFERTAS">
			<tr><td>&nbsp;</td></tr>
		
			<tr id="OFE_NUEVA" class="filaOferta">
				<!--	31ago16	Incluimos un contador, y un fonde de color seg�n la valoraci�n de la documentaci�n	-->
				<td>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/>:
				</td>

			
				<!-- Fecha Oferta -->
				<td>
					<xsl:value-of select="/FichaProductoLic/PRODUCTOLICITACION/FECHAACTUAL"/>
                </td>
				<!-- Nombre Proveedor + indicacion pedido minimo-->
				<td style="text-align:left;">
		            <xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/FichaProductoLic/PRODUCTOLICITACION/PROVEEDORES_SIN_OFERTA/field"/>
						<xsl:with-param name="style">width:300px;</xsl:with-param>
						<xsl:with-param name="onChange">javascript:ActivarBotonGuardarNuevaOferta();</xsl:with-param>
					</xsl:call-template>
				</td>
				<!--	nuevas columnas de pedido minimo, plazo de entrega y consumo adjudicado	-->
				<td>-</td>
				<td>-</td>
				<td>-</td>
				<!-- Ref.Proveedor -->
				<td>
				<input type="hidden" name="IDProveedorLic_NUEVA" id="IDProveedorLic_NUEVA" value="{LIC_OFE_IDPROVEEDORLIC}"/>
				<input type="hidden" name="Cant_NUEVA" id="Cant_NUEVA" value="{LIC_OFE_CANTIDAD}"/>
				<input type="hidden" name="TIVA_NUEVA" id="TIVA_NUEVA" value="{LIC_OFE_TIPOIVA}"/>
				<input type="hidden" name="FT_NUEVA" id="FT_NUEVA" value="{FICHA_TECNICA}"/>

				<xsl:choose>
				<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/IDPAIS = '55'">
					&nbsp;
				</xsl:when>
				<xsl:otherwise>
					<!--<a href="javascript:FichaProductoOfe('{/FichaProductoLic/PRODUCTOLICITACION/LIC_PROD_ID}','NUEVA');" id="RefProv_NUEVA"><xsl:value-of select="LIC_OFE_REFERENCIA"/></a>-->
					<a href="javascript:FichaProductoOfe('{/FichaProductoLic/PRODUCTOLICITACION/LIC_PROD_ID}','NUEVA');"><xsl:value-of select="LIC_OFE_REFERENCIA"/></a>
				</xsl:otherwise>
				</xsl:choose>
				</td>
				<!-- Icono anyadir campos avanzados -->
				<td>&nbsp;</td>
				<xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/INCLUIR_COLUMNA_DOCUMENTOS">
					<td>&nbsp;</td>
				</xsl:if>
				<!-- Referencia proveedor -->
				<td class="datosLeft">
					<xsl:choose>
					<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/AUTOR and (/FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'CURS' or /FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'INF')">
						<input type="text" class="peq" name="RefProv_NUEVA" id="RefProv_NUEVA" value="{LIC_OFE_REFERENCIA}" oninput="ActivarBotonGuardarNuevaOferta();"><!-- disabled="disabled"-->
							<xsl:if test="not (/FichaProductoLic/PRODUCTOLICITACION/MVM) and not (/FichaProductoLic/PRODUCTOLICITACION/AUTOR)">
								<xsl:attribute name="disabled">disabled</xsl:attribute>
							</xsl:if>
						</input>
					</xsl:when>
					<xsl:otherwise>
						<strong><xsl:value-of select="LIC_OFE_REFERENCIA"/></strong>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<!-- Nombre producto -->
				<td class="datosLeft">
					<xsl:choose>
					<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/AUTOR and (/FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'CURS' or /FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'INF')">
						<input type="text" class="muygrande" name="Desc_NUEVA" id="Desc_NUEVA" value="{LIC_OFE_NOMBRE}" oninput="ActivarBotonGuardarNuevaOferta();"><!-- disabled="disabled"-->
							<xsl:if test="not (/FichaProductoLic/PRODUCTOLICITACION/MVM) and not (/FichaProductoLic/PRODUCTOLICITACION/AUTOR)">
								<xsl:attribute name="disabled">disabled</xsl:attribute>
							</xsl:if>
						</input>
					</xsl:when>
					<xsl:otherwise>
						<strong><xsl:value-of select="LIC_OFE_NOMBRE"/></strong>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<!-- Iconos FT y campos avanzados -->
				<td  style="display:table-cell;">
				<xsl:if test="FICHA_TECNICA/ID">
					<a href="http://www.newco.dev.br/Documentos/{FICHA_TECNICA/URL}" target="_blank" style="text-decoration:none;">
						<img src="http://www.newco.dev.br/images/fichaChange.gif">
							<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='ficha_tecnica']/node()"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='ficha_tecnica']/node()"/></xsl:attribute>
						</img>
					</a>
				</xsl:if>

				<xsl:if test="LIC_OFE_INFOAMPLIADA != ''">
					<a class="tooltip" href="#">
						<img class="static" src="http://www.newco.dev.br/images/infoAmpliadaIcon.gif"/>
						<span class="classic spanEIS">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='info_ampliada']/node()"/><br /><br />
							<xsl:copy-of select="LIC_OFE_INFOAMPLIADA/node()"/>
						</span>
					</a>
				</xsl:if>

				<xsl:if test="DOCUMENTO/ID">
					<a target="_blank" href="http://www.newco.dev.br/Documentos/{DOCUMENTO/URL}">
						<img class="static" src="http://www.newco.dev.br/images/clipIcon.gif">
							<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/></xsl:attribute>
						</img>
					</a>
				</xsl:if>
				</td>
				<td>
					<xsl:choose>
					<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/AUTOR and (/FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'CURS' or /FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'INF')">
						<input type="text" class="peq" name="Marca_NUEVA" id="Marca_NUEVA" value="{LIC_OFE_MARCA}" oninput="ActivarBotonGuardarNuevaOferta();"><!-- disabled="disabled"-->
							<xsl:if test="not (/FichaProductoLic/PRODUCTOLICITACION/MVM) and not (/FichaProductoLic/PRODUCTOLICITACION/AUTOR)">
								<xsl:attribute name="disabled">disabled</xsl:attribute>
							</xsl:if>
						</input>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="LIC_OFE_MARCA"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/CDC">
					<td>&nbsp;</td>
				</xsl:if>

				<td>
				<xsl:choose>
				<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/AUTOR and (/FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'CURS' or /FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'INF')">
					<input type="text" class="peq" size="4" name="UdsLote_NUEVA" id="UdsLote_NUEVA" value="{LIC_OFE_UNIDADESPORLOTE}" oninput="ActivarBotonGuardarNuevaOferta();"><!-- disabled="disabled"-->
						<xsl:if test="not (/FichaProductoLic/PRODUCTOLICITACION/MVM or /FichaProductoLic/PRODUCTOLICITACION/AUTOR or /FichaProductoLic/PRODUCTOLICITACION/MODIFICAR_PRECIO_OFERTA)">
							<xsl:attribute name="disabled">disabled</xsl:attribute>
						</xsl:if>
					</input>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="LIC_OFE_UNIDADESPORLOTE"/>
					<input type="hidden" name="UdsLote_NUEVA" id="UdsLote_NUEVA" value="{LIC_OFE_UNIDADESPORLOTE}"/>
				</xsl:otherwise>
				</xsl:choose>
					<xsl:if test="EMPAQUETAMIENTO_SOSPECHOSO">
						<span class="rojo2">&nbsp;?</span>
					</xsl:if>
				</td>

				<!-- checkbox o marca adjudicacion -->
				<td>&nbsp;</td>
				<!--valor de precio-->
				<td id="PrOf_NUEVA" class="PrecioOferta">
				<input type="hidden" name="PrecioOriginal_NUEVA" id="PrecioOriginal_NUEVA" value="{LIC_OFE_PRECIO}"/>
				<xsl:choose>
				<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'CURS' or /FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'INF'">
					<input type="text" class="peq" size="8" name="Precio_NUEVA" id="Precio_NUEVA" value="{LIC_OFE_PRECIO}" oninput="ActivarBotonGuardarNuevaOferta();"><!-- disabled="disabled"-->
						<xsl:attribute name="style">
							<xsl:choose>
							<xsl:when test="IGUAL">color:orange;font-weight:bold;</xsl:when>
							<xsl:when test="SUPERIOR">color:red;font-weight:bold;</xsl:when>
							<xsl:otherwise>color:green;font-weight:bold;</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
						<xsl:if test="not (/FichaProductoLic/PRODUCTOLICITACION/MVM or /FichaProductoLic/PRODUCTOLICITACION/AUTOR or /FichaProductoLic/PRODUCTOLICITACION/MODIFICAR_PRECIO_OFERTA)">
							<xsl:attribute name="disabled">disabled</xsl:attribute>
						</xsl:if>
					</input>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
					<xsl:when test="IGUAL"><span class="precio" style="color:orange;font-weight:bold;"><xsl:value-of select="LIC_OFE_PRECIO"/></span>&nbsp;</xsl:when>
					<xsl:when test="SUPERIOR"><span class="precio" style="color:red;font-weight:bold;"><xsl:value-of select="LIC_OFE_PRECIO"/></span>&nbsp;</xsl:when>
					<xsl:otherwise><span class="precio" style="color:green;font-weight:bold;"><xsl:value-of select="LIC_OFE_PRECIO"/></span>&nbsp;</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
				</xsl:choose>
				</td>
				
				<td><!--6jul16	<span id="mas80_NUEVA" style="display:none;" class="rojo2">?&nbsp;</span>-->
					<xsl:if test="SOSPECHOSO">
						<span class="naranja">&nbsp;?</span>
					</xsl:if>
					<xsl:if test="MUY_SOSPECHOSO">
						<span class="rojo2">&nbsp;?</span>
					</xsl:if>
				</td>
				
				<td>
					<!--	3jun19	Guardamos el consumo en un parrafo con id y nombre  para poderlo recalcular		-->
					<input type="hidden" name="CONSUMO_NUEVA" id="CONSUMO_NUEVA" value="{LIC_OFE_CONSUMO}"/>
					<p name="Consumo_NUEVA" id="Consumo_NUEVA"><xsl:value-of select="LIC_OFE_CONSUMO"/></p>
				</td>
                <xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/IDPAIS != '55'">
                    <td><xsl:value-of select="LIC_OFE_TIPOIVA"/>%</td>
                </xsl:if>

                <xsl:if test="/FichaProductoLic/PRODUCTOLICITACION/CDC and /FichaProductoLic/PRODUCTOLICITACION/IDPAIS != '55'">
                	<xsl:choose>
                	<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION ='CURS' or /FichaProductoLic/PRODUCTOLICITACION/LIC_IDESTADOLICITACION ='INF'">
                    	<td>
                        	<select name="LIC_OFE_IDESTADOEVALUACION_NUEVA" id="IDESTADO_NUEVA" style="width:50px"><!-- class="select100"-->
                        	<xsl:for-each select="ESTADOSEVALUACION/field/dropDownList/listElem">
                                	<option value="{ID}">
                                        	<xsl:if test="ID = ../../@current">
                                                	<xsl:attribute name="selected">selected</xsl:attribute>
                                        	</xsl:if>
                                        	<xsl:value-of select="listItem"/>
                                	</option>
                        	</xsl:for-each>
                        	</select>&nbsp;
                        	<a href="javascript:CambiarEstadoOferta(NUEVA);"><img src="http://www.newco.dev.br/images/actualizarFlecha.gif"/></a>
                    	</td>
                	</xsl:when>
                	<xsl:otherwise>
                        	<td><xsl:value-of select="ESTADOEVALUACION"/></td>
                	</xsl:otherwise>
                	</xsl:choose>

					<td><!--solicitar evaluacion-->
					<xsl:if test="LIC_OFE_PRECIOIVA != '0,0000' and LIC_OFE_UNIDADESPORLOTE != '0,00'">
    					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/NuevaEvaluacionProducto.xsql?PRO_ID_ESTANDAR={../../LIC_PROD_IDPRODESTANDAR}&amp;PRO_ID={../../LIC_OFE_IDPRODUCTO}&amp;LIC_OFE_ID=NUEVA','Evaluaci?n producto',100,80,0,-10);">
        					<xsl:choose>
        					<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/IDPAIS != '55'"><img src="http://www.newco.dev.br/images/evaluar.gif" alt="Evaluar"/></xsl:when>
        					<xsl:otherwise><img src="http://www.newco.dev.br/images/evaluar-BR.gif" alt="Avalia�ao"/></xsl:otherwise>
        					</xsl:choose>
    					</a>
					</xsl:if>
					</td>
					
                </xsl:if>
				<!-- Sem�foro asociado al pedido	-->
				<td>
					&nbsp;
				</td>
				<!-- Zona Bot�n de pedido (no activo)	-->
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
			</tr>
			<!--	Motivo por el que se modifica un precio	-->
			<tr id="lMotivoPrecio_NUEVA" name="lMotivoPrecio_NUEVA" style="display:none;">
				<td colspan="5">&nbsp;</td>
				<td colspan="6">&nbsp;
					<xsl:choose>
					<xsl:when test="/FichaProductoLic/PRODUCTOLICITACION/IDMOTIVOCAMBIOPRECIO">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='motivo']/node()"/>:
						<xsl:call-template name="desplegable">
							<xsl:with-param name="nombre">IDMOTIVOCAMBIOPRECIO_NUEVA</xsl:with-param>
							<xsl:with-param name="id">IDMOTIVOCAMBIOPRECIO_NUEVA<xsl:value-of select="LIC_OFE_ID"/></xsl:with-param>
							<xsl:with-param name="path" select="/FichaProductoLic/PRODUCTOLICITACION/IDMOTIVOCAMBIOPRECIO/field"/>
						</xsl:call-template>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<xsl:value-of select="document($doc)/translation/texts/item[@name='explicacion']/node()"/>:&nbsp;
						<input type="inputext" size="60" name="MOTIVOCAMBIOPRECIO_NUEVA" id="MOTIVOCAMBIOPRECIO_NUEVA" value="{LIC_OFE_MOTIVOCAMBIOPRECIO}"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="hidden" name="IDMOTIVOCAMBIOPRECIO_NUEVA" value=""/>
						<input type="hidden" name="MOTIVOCAMBIOPRECIO_NUEVA" value=""/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td colspan="4">&nbsp;
					<a class="btnDestacado" href="javascript:guardarNuevaOferta();"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
				</td>
			</tr>
		
		</xsl:if><!-- COMPRADOR_CREA_OFERTAS. FIN fila annadir oferta -->
		</tbody>
		</table><!-- FIN Tabla Datos Ofertas -->
</xsl:template><!--fin de template sin iva-->

</xsl:stylesheet>
