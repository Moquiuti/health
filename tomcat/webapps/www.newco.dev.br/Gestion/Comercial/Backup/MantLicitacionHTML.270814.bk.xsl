<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:import href="http://www.newco.dev.br/Gestion/Comercial/LicGeneralTemplates.xsl"/>
<xsl:import href="http://www.newco.dev.br/Gestion/Comercial/LicProductosTemplates.xsl"/>

<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:param name="usuario" select="@US_ID"/>

<xsl:template match="/">

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

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_licitaciones']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript">
		<xsl:if test='/Mantenimiento/NUEVALICITACION'>
			var mesesSelected=<xsl:value-of select="/Mantenimiento/NUEVALICITACION/LIC_MESESDURACION"/>;
		</xsl:if>
		<xsl:if test='/Mantenimiento/LICITACION'>
			var mesesSelected		= <xsl:value-of select="/Mantenimiento/LICITACION/LIC_MESESDURACION"/>;
			var IDIdioma			= '<xsl:value-of select="/Mantenimiento/LICITACION/IDIDIOMA"/>';
			var rol				= '<xsl:value-of select="/Mantenimiento/LICITACION/ROL"/>';
			var digitosRefMinima		= <xsl:value-of select="/Mantenimiento/LICITACION/DIGITOSREFERENCIAMINIMA"/>;
			var preciosConIVA		= <xsl:choose><xsl:when test="/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA">1</xsl:when><xsl:otherwise>0</xsl:otherwise></xsl:choose>;
			var proveedoresInformados 	= '<xsl:if test="/Mantenimiento/LICITACION/PROVEEDORESLICITACION/PROVEEDOR">S</xsl:if>';
			var productosInformados		= '<xsl:if test="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PRODUCTO/LIC_PROD_CANTIDAD != ''">S</xsl:if>';
			var ofertaProvInformada		= '<xsl:if test="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PRODUCTO/LIC_OFE_IDPROVEEDORLIC != ''">S</xsl:if>';
			var pedidoMinimoInform		= '<xsl:if test="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_PEDIDOMINIMO != ''">S</xsl:if>';
		</xsl:if>
		var lang	= '<xsl:value-of select="/Mantenimiento/LANG"/>';
		<!--para cambiar estado lici de CURS a INF todos prove informados-->
<!--
		var numPro	= '<xsl:value-of select="count(/Mantenimiento/LICITACION/PROVEEDORESLICITACION/PROVEEDOR)"/>';
		var proveInf	= '<xsl:value-of select="count(/Mantenimiento/LICITACION/PROVEEDORESLICITACION/PROVEEDOR[LIC_PROV_IDESTADO='INF'])"/>';
		var idLicTot	= '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_ID"/>';
		var idProv	= '<xsl:value-of select="/Mantenimiento/LICITACION/EMPRESALICITACION/ID"/>';
-->
		var thisUSID		= '<xsl:value-of select="/Mantenimiento/US_ID"/>';
		var mostrarCategorias	= '<xsl:value-of select="/Mantenimiento/LICITACION/NOMBRESNIVELES/@MostrarCategoria"/>';
		var mostrarGrupos	= '<xsl:value-of select="/Mantenimiento/LICITACION/NOMBRESNIVELES/@MostrarGrupo"/>';
		var txtTodas		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/>';
		var txtSelecciona	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='selecciona']/node()"/>';
		var txtActDatos		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar_datos']/node()"/>';
		var txtDatosObl		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='datos_obligatorios_form']/node()"/>';
		var txtTotalCons	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='total_consumo']/node()"/>';
		var faltaTitulo		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_titulo']/node()"/>';
		var faltaDescripcion	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_descripcion']/node()"/>';
		var faltaCondEntr	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_condiciones_entrega']/node()"/>';
		var faltaCondPago	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_condiciones_pago']/node()"/>';
		var faltaConsumo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_consumo']/node()"/>';
		var malConsumo		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_consumo']/node()"/>';
		var faltaFechaDecision	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_fecha_decision']/node()"/>';
		var malFechaDecision	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_fecha_decision']/node()"/>';
		var faltaReferencia	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_referencia']/node()"/>';
		var digitosReferencia	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='min_digitos_referencia']/node()"/>';
		var faltaTipoIVA	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_tipoIVA']/node()"/>';
		var faltaSelecDespl	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_seleccionar_desplegable_cat_priv']/node()"/>';
		var txtNivel3		= '<xsl:value-of select="/Mantenimiento/LICITACION/NOMBRESNIVELES/NIVEL3"/>';
		var faltaProveedor	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_proveedor']/node()"/>';
		var faltaUsuarioProv	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_usuario_proveedor']/node()"/>';
		var faltaUsuario	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_usuario']/node()"/>';
		var errorNuevosProductos= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_nuevos_productos']/node()"/>';
		var errorNuevoProveedor	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_nuevo_proveedor']/node()"/>';
		var errorNuevoUsuario	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_nuevo_usuario']/node()"/>';
		var errorUsuarioYaExiste= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_usuario_ya_existe']/node()"/>';
		var errorEliminarProduct= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_eliminar_producto']/node()"/>';
		var errorEliminarUsuario= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_eliminar_usuario']/node()"/>';
		var errorEliminarProveedor	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_eliminar_proveedor']/node()"/>';
		var errorNuevasOfertas	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_nuevas_ofertas']/node()"/>';
		var errorProductosActualizados		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_productos_actualizados']/node()"/>';
		var successProductosActualizados	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='success_productos_actualizados']/node()"/>';
		var sinProductos	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion_sin_productos']/node()"/>';
		var sinProveedores	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion_sin_proveedores']/node()"/>';
		var sinUsuarios		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion_sin_usuarios']/node()"/>';
		var faltaPrecio		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_precio']/node()"/>';
		var malPrecio		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_precio']/node()"/>';
		var faltaUnidades	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_unidades']/node()"/>';
		var malUnidades		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_unidades']/node()"/>';
		var faltaPrecioRef	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_precio_referencia']/node()"/>';
		var malPrecioRef	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_precio_referencia']/node()"/>';
		var faltaPrecioObj	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_precio_objetivo']/node()"/>';
		var malPrecioObj	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_precio_objetivo']/node()"/>';
		var faltaCantidad	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_cantidad']/node()"/>';
		var malCantidad		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_cantidad']/node()"/>';
		var faltaRefProv	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_ref_proveedor']/node()"/>';
		var faltaDescripcionOfer= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_descripcion_oferta']/node()"/>';
		var faltaMarcaOfer	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_marca_oferta']/node()"/>';
		var faltaUdBasica	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_unidad_basica']/node()"/>';
		var errorNuevoEstadoProveedor	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_nuevo_estado_proveedor']/node()"/>';
		var errorNuevoEstadoLicitacion	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_nuevo_estado_licitacion']/node()"/>';
		var errorNoIniciarLicitacion	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_no_iniciar_licitacion']/node()"/>';
		var seguroSalirDatosGenLicitacion	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='seguro_salir_datos_gen_licitacion']/node()"/>';
		var autor		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/>';
		var errorAdjudicarProveedor	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_adjudicar_proveedor']/node()"/>';
		var errorRollBackProveedor	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_rollback_proveedor']/node()"/>';
		var en_curso		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='en_curso']/node()"/>';
		var informada		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='informada']/node()"/>';
		var adjudicada		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicada']/node()"/>';
		var firmada		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='firmada']/node()"/>';
		var contrato		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='contrato']/node()"/>';
		var faltaPedidoMinimo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_pedido_minimo']/node()"/>';
		var malPedidoMinimo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_pedido_minimo']/node()"/>';
		var faltaInformarOfertas= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_informar_ofertas']/node()"/>';
		var confirmInsertarCatalogoProv= '<xsl:value-of select="document($doc)/translation/texts/item[@name='confirm_insertar_en_catalogo_proveedores']/node()"/>';
		var confirmInsCatProvCat= '<xsl:value-of select="document($doc)/translation/texts/item[@name='confirm_insertar_en_catalogo_proveedores_categoria']/node()"/>';
		var errorInsertarCatProv= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_insertar_en_catalogo_proveedores']/node()"/>';
		var errorActPreciosConsumos= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_actualizar_precios_consumos']/node()"/>';
		var confirmInsertarEnPlantilla= '<xsl:value-of select="document($doc)/translation/texts/item[@name='confirm_insertar_en_plantilla']/node()"/>';
		var errorInsertarEnPlantilla= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_insertar_en_plantilla']/node()"/>';
		var confirmRenovarLicitacion= '<xsl:value-of select="document($doc)/translation/texts/item[@name='confirm_renovar_licitacion']/node()"/>';
		var errorRenovarLicitacion= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_renovar_licitacion']/node()"/>';
		var altImprimirOferta	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir_oferta']/node()"/>';
		var maxReferencias	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='num_max_referencias']/node()"/>';
		var errAdjudicarProds	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_seleccion_adjudicar_productos']/node()"/>';
		var firmaProveedorOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='firma_proveedor_ok']/node()"/>';
		var guardar_selecc_adjudica_ok	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_selecc_adjudica_ok']/node()"/>';
		var guardar_selecc_adjudica_ko	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_selecc_adjudica_ko']/node()"/>';
		var sin_ofertar_txt	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_ofertar']/node()"/>';
		var okModificarFechaDecision = '<xsl:value-of select="document($doc)/translation/texts/item[@name='modificar_fecha_decision_ok']/node()"/>';
		var errorModificarFechaDecision = '<xsl:value-of select="document($doc)/translation/texts/item[@name='modificar_fecha_decision_error']/node()"/>';

		jQuery(document).ready(globalEvents2);

		function globalEvents2(){
			jQuery('span.cambiarNivel').each(function(){
				jQuery(this).html(jQuery(this).text().replace('[[SUBFAMILIAS]]',txtNivel3));
			});
		}
	</script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/lic_220814.js"></script>
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
		<h1 class="titlePage" style="height:auto;padding-bottom:10px;">
			<xsl:choose>
			<xsl:when test="not(/Mantenimiento/NUEVALICITACION)">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion']/node()"/>:&nbsp;<xsl:value-of select="/Mantenimiento/LICITACION/LIC_TITULO"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_licitacion']/node()"/>
			</xsl:otherwise>
			</xsl:choose>

<!-- Solo mostramos el link en caso de usuario autor o en caso de usuario admin -->
			<xsl:if test="/Mantenimiento/LICITACION/AUTOR or (/Mantenimiento/LICITACION/COMENTARIOS_PRIVADOS and /Mantenimiento/LICITACION/ADMIN)">
				&nbsp;<a href="javascript:comentarioInterno({/Mantenimiento/LICITACION/LIC_ID},{/Mantenimiento/US_ID});" style="text-decoration:none;">
					<img src="http://www.newco.dev.br/images/edit.png">
						<xsl:attribute name="alt">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='leer_comentario']/node()"/>
						</xsl:attribute>
						<xsl:attribute name="title">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='leer_comentario']/node()"/>
						</xsl:attribute>
					</img>
				</a>
			</xsl:if>

			<xsl:if test="/Mantenimiento/LICITACION/MENSAJE">
				<br />
				<xsl:choose>
					<xsl:when test="/Mantenimiento/LICITACION/MENSAJE='OK'"><xsl:value-of select="document($doc)/translation/texts/item[@name='cambios_guardados']/node()"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="/Mantenimiento/LICITACION/MENSAJE"/></xsl:otherwise>
				</xsl:choose>
				&nbsp;(<xsl:value-of select="/Mantenimiento/LICITACION/LIC_FECHAALTA"/>)
			</xsl:if>

			<xsl:if test="/Mantenimiento/LICITACION/LIC_IDESTADO != 'EST'">
				<br />
				<br />
				<span style="font-size:12px;padding:5px;background:#F3F781;border:1px solid red;">
					<xsl:choose>
					<xsl:when test="/Mantenimiento/LICITACION/LIC_PORPRODUCTO = 'S'">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion_por_producto_expli']/node()"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion_por_paquete_expli']/node()"/>
					</xsl:otherwise>
					</xsl:choose>
				</span>
			</xsl:if>
		</h1>



		<xsl:choose>
		<xsl:when test="/Mantenimiento/NUEVALICITACION">
			<xsl:call-template name="Tabla_Datos_Generales_Nuevo"/>
		</xsl:when>
		<xsl:when test="/Mantenimiento/LICITACION/LIC_IDESTADO = 'EST'">
			<xsl:call-template name="Tabla_Datos_Generales_Estudio_Previo"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="Tabla_Datos_Generales"/>
		</xsl:otherwise>
		</xsl:choose>

<!--
		<form id="form1" name="form1" action="MantLicitacionSave.xsql" method="post">
		<input type="hidden" name="LIC_IDUSUARIO" value="{Mantenimiento/US_ID}"/>
		<input type="hidden" name="LIC_IDEMPRESA">
			<xsl:attribute name="value">
				<xsl:choose>
				<xsl:when test="/Mantenimiento/NUEVALICITACION"><xsl:value-of select="/Mantenimiento/NUEVALICITACION/IDEMPRESA"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="/Mantenimiento/LICITACION/LIC_IDEMPRESA"/></xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
                </input>
		<input type="hidden" name="LIC_ID" value="{/Mantenimiento/LICITACION/LIC_ID}"/>
		<input type="hidden" name="ACCION">
			<xsl:attribute name="value">
				<xsl:choose>
				<xsl:when test="Mantenimiento/NUEVALICITACION">NUEVO</xsl:when>
				<xsl:otherwise>MODIFICAR</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
                </input>

			<table class="infoTable" border="0">
				<tr>
					<td class="veinte labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>:</td>
					<td class="datosLeft">
						<xsl:choose>
						<xsl:when test="/Mantenimiento/NUEVALICITACION or (/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_IDESTADO ='EST')">
							<input type="text" name="LIC_TITULO" value="{Mantenimiento/LICITACION/LIC_TITULO}" size="50" maxlength="100"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="/Mantenimiento/LICITACION/LIC_TITULO"/>
						</xsl:otherwise>
						</xsl:choose>
					</td>
					<td class="dies labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/>:</td>
					<td class="veinte datosLeft">
						<xsl:choose>
						<xsl:when test="/Mantenimiento/NUEVALICITACION or (/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_IDESTADO ='EST')">
							<input type="text" name="LIC_FECHADECISION" value="{Mantenimiento/LICITACION/LIC_FECHADECISIONPREVISTA}" size="15" maxlength="10"/>
							&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='formato_fecha']/node()"/>
						</xsl:when>
						<xsl:when test="/Mantenimiento/LICITACION/AUTOR">
							<input type="text" id="LIC_FECHADECISION" name="LIC_FECHADECISION" value="{Mantenimiento/LICITACION/LIC_FECHADECISIONPREVISTA}" size="8" maxlength="8"/>
							&nbsp;<a href="javascript:ActualizarFechaDecision({/Mantenimiento/LICITACION/LIC_ID});" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/modificar.gif">
									<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar_fecha']/node()"/></xsl:attribute>
									<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar_fecha']/node()"/></xsl:attribute>
								</img>
							</a>
							&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='formato_fecha']/node()"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="/Mantenimiento/LICITACION/LIC_FECHADECISIONPREVISTA"/>
						</xsl:otherwise>
						</xsl:choose>
					</td>
					<td class="veinte">&nbsp;</td>
				</tr>

				<tr>
				<xsl:choose>
				<xsl:when test="/Mantenimiento/NUEVALICITACION or (/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_IDESTADO ='EST')">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion_por_producto']/node()"/>:</td>
					<td class="datosLeft">
						<input type="checkbox" name="LIC_PORPRODUCTO" id="LIC_PORPRODUCTO" value="S">
							<xsl:if test="/Mantenimiento/LICITACION/LIC_PORPRODUCTO = 'S'">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:if>
						</input>
                                        </td>
				</xsl:when>
				<xsl:otherwise>
					<td>&nbsp;</td>
					<td class="datosLeft"><span style="padding:5px;background:#F3F781;">
						<xsl:choose>
						<xsl:when test="/Mantenimiento/LICITACION/LIC_PORPRODUCTO = 'S'">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion_por_producto_expli']/node()"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion_por_paquete_expli']/node()"/>
						</xsl:otherwise>
						</xsl:choose>
                                        </span></td>
-->
<!--
							<input type="checkbox" name="LIC_PORPRODUCTO" id="LIC_PORPRODUCTO" value="S" disabled="disabled">
								<xsl:if test="/Mantenimiento/LICITACION/LIC_PORPRODUCTO = 'S'">
									<xsl:attribute name="checked">checked</xsl:attribute>
								</xsl:if>
                                                        </input>
-->
<!--
				</xsl:otherwise>
				</xsl:choose>
					<td colspan="3">&nbsp;</td>
				</tr>

                <xsl:if test="not(/Mantenimiento/NUEVALICITACION)">
				<tr>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_alta']/node()"/>:</td>
					<td class="datosLeft"><strong><xsl:value-of select="Mantenimiento/LICITACION/LIC_FECHAALTA"/></strong></td>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>:</td>
					<td class="datosLeft">
						<strong><span id="idEstadoLic"><xsl:value-of select="Mantenimiento/LICITACION/ESTADO"/></span></strong>
					</td>
					<td class="datosLeft botonesLic" style="padding-right:10px;">

		<xsl:if test="/Mantenimiento/LICITACION/ROL = 'VENDEDOR' and /Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_IDESTADO != 'CURS'">
			<div class="botonLargo clear" id="botonImprimirOferta">
				<a href="javascript:imprimirOferta({/Mantenimiento/LICITACION/LIC_ID},{/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_ID});">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir_oferta']/node()"/>
				</a>
			</div>
		</xsl:if>

		<xsl:if test="/Mantenimiento/LICITACION/ROL = 'VENDEDOR' and /Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_IDESTADO = 'CURS'">
			<div class="botonLargoVerdadNara clear" id="botonPublicarOferta">
				<a class="grey" href="javascript:ValidarFormulario(document.forms['PublicarOfertas'],'provPublicarOferta');">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='publicar_oferta']/node()"/>
				</a>
			</div>
		</xsl:if>

		<xsl:if test="/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_IDESTADO != 'EST'">
			<div class="botonLargo clear" id="botonActPreciosCatPriv">
				<a href="javascript:ActualizarPreciosYConsumos({/Mantenimiento/LICITACION/LIC_ID});">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='boton_actualizar_precios_consumos']/node()"/>
				</a>
			</div>
		</xsl:if>

		<xsl:choose>  
		<xsl:when test="/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_IDESTADO = 'EST'">
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/USUARIOSLICITACION/USUARIO and /Mantenimiento/LICITACION/PROVEEDORESLICITACION/PROVEEDOR and /Mantenimiento/LICITACION/PRODUCTOSLICITACION/PRODUCTO and /Mantenimiento/LICITACION/LIC_DESCRIPCION != '' and /Mantenimiento/LICITACION/LIC_CONDICIONESENTREGA != '' and /Mantenimiento/LICITACION/LIC_CONDICIONESPAGO != '' and /Mantenimiento/LICITACION/LIC_OTRASCONDICIONES != '' and /Mantenimiento/LICITACION/LIC_MESESDURACION != ''">
				//paso id lic, estado, proveedor conectado
				<div class="botonLargoVerdadNara clear" id="botonIniciarLici">
					<a href="javascript:IniciarLicitacion({/Mantenimiento/LICITACION/LIC_ID},'CURS',{/Mantenimiento/LICITACION/EMPRESALICITACION/ID});">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='iniciar_licitacion']/node()"/>
					</a>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div class="botonLargoVerdadNara clear" id="botonIniciarLici">
					<a href="javascript:NoIniciarLicitacion({/Mantenimiento/LICITACION/LIC_ID},'CURS',{/Mantenimiento/LICITACION/EMPRESALICITACION/ID});">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='iniciar_licitacion']/node()"/>
					</a>
				</div>
			</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		//cuando lici esta adjudicada, boton para el proveedor para firmarla

		<xsl:when test="/Mantenimiento/LICITACION/ROL = 'VENDEDOR' and /Mantenimiento/LICITACION/BOTON_FIRMA">
			<div class="botonLargoVerdadNara clear" id="botonFirmarLici">
				<xsl:attribute name="style">
					<xsl:choose>
					<xsl:when test="/Mantenimiento/LICITACION/LIC_IDESTADO = 'ADJ'">display:block;</xsl:when>
					<xsl:otherwise>display:none;</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>

				<a href="javascript:CambiarEstadoProveedor({/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_ID},'FIRM');">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='firmar_licitacion']/node()"/>
				</a>
			</div>
		</xsl:when>
		//cuando lici esta contratada, boton para el autor para firmarla
		<xsl:when test="/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_IDESTADO = 'CONT'">
				<div class="botonLargoVerdadNara clear" id="botonInsCatProv" style="margin-bottom:10px;">
					<a href="javascript:ComprobarCatalogoProveedor({/Mantenimiento/LICITACION/LIC_ID});">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='boton_insertar_catalogo_proveedor']/node()"/>
					</a>
				</div><div id="waitBotonInsCatProv" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></div>
				<div class="botonLargoVerdadNara clear" id="botonInsEnPlant" style="display:none;margin-bottom:10px;">
					<a href="javascript:ComprobarCatalogoCliente({/Mantenimiento/LICITACION/LIC_ID});">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='boton_insertar_en_plantillas']/node()"/>
					</a>
				</div><div id="waitBotonInsEnPlant" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></div>
				<div class="botonLargo clear" id="botonRenovarLic">
					<a href="javascript:RenovarLicitacion({/Mantenimiento/LICITACION/LIC_ID});">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='boton_renovar_licitacion']/node()"/>
					</a>
				</div>
		</xsl:when>
		//cuando lici esta contratada, boton para el autor para firmarla
		<xsl:when test="/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_IDESTADO = 'CAD'">
				<div class="botonLargo" id="botonRenovarLic">
					<a href="#">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='boton_renovar_licitacion']/node()"/>
					</a>
				</div>
		</xsl:when>
		</xsl:choose>

		<xsl:if test="/Mantenimiento/LICITACION/ROL = 'COMPRADOR' and /Mantenimiento/LICITACION/PROVEEDORESLICITACION/PROVEEDOR/CONVERSACION">
				<div class="botonLargo clear">
					<a href="#" id="ConversacionProv">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='existe_conversacion_proveedor']/node()"/>
					</a>
				</div>
		</xsl:if>

		<xsl:if test="/Mantenimiento/LICITACION/ROL = 'VENDEDOR'">
				<div class="botonLargo clear" style="margin:10px 0 0 0;">
					<a href="javascript:conversacionProveedor({/Mantenimiento/LIC_ID},{/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_IDPROVEEDOR},{/Mantenimiento/LICITACION/LIC_IDUSUARIO},{/Mantenimiento/LICITACION/IDUSUARIO_PROVEEDOR},'{/Mantenimiento/LICITACION/EMPRESALICITACION/NOMBRE}');">
						<xsl:choose>
						<xsl:when test="/Mantenimiento/LICITACION/CONVERSACION">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='ver_conversacion']/node()"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='escribe_mensaje_cliente']/node()"/>
						</xsl:otherwise>
						</xsl:choose>
					</a>
				</div>
		</xsl:if>

					</td>
				</tr>



				<tr><td colspan="5">&nbsp;</td></tr>
		</xsl:if>
			</table>

		<xsl:if test="not(/Mantenimiento/NUEVALICITACION)">
			<div id="pestanas" class="divLeft" style="border-bottom:2px solid #3B5998;">
				&nbsp;&nbsp;
				<xsl:choose>
				<xsl:when test="/Mantenimiento/LANG = 'spanish'">
					<a href="#" id="pes_lDatosGenerales" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/botonDatosGenerales1.gif" alt="Datos Generales" title=""/></a>&nbsp;
					<a href="#" id="pes_lProductos" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/botonProductos.gif" alt="Productos" title=""/></a>&nbsp;
					<xsl:if test="/Mantenimiento/LICITACION/ROL != 'VENDEDOR'">
						<a href="#" id="pes_lProveedores" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/botonProveedores.gif" alt="Proveedores" title=""/></a>&nbsp;
						<a href="#" id="pes_lUsuarios" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/botonUsuarios.gif" alt="Usuarios" title=""/></a>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<a href="#" id="pes_lDatosGenerales" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/botonDatosGenerales1-BR.gif" alt="Datos Generales" title=""/></a>&nbsp;
					<a href="#" id="pes_lProductos" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/botonProductos-BR.gif" alt="Productos" title=""/></a>&nbsp;
					<xsl:if test="/Mantenimiento/LICITACION/ROL != 'VENDEDOR'">					
						<a href="#" id="pes_lProveedores" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/botonProveedores-BR.gif" alt="Proveedores" title=""/></a>&nbsp;
						<a href="#" id="pes_lUsuarios" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/botonUsuarios-BR.gif" alt="Usuarios" title=""/></a>
					</xsl:if>
				</xsl:otherwise>
				</xsl:choose>
			</div>
		</xsl:if>

			<table class="infoTable divLeft" id="lDatosGenerales" style="margin-top:10px;display:block;" border="0">

			//Si es proveedor y el estado de la licitacion es 'en curso' mostramos explicacion para que sepan informar ofertas
			<xsl:if test="/Mantenimiento/LICITACION/ROL = 'VENDEDOR' and /Mantenimiento/LICITACION/LIC_IDESTADO = 'CURS'">
				<tr>
					<td colspan="3"><span style="padding:10px;background-color:#BCF5A9;border:1px solid #00FF00"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='lic_proveedores_expli']/node()"/></strong></span></td>
				</tr>
				<tr>
					<td colspan="3">&nbsp;</td>
				</tr>
			</xsl:if>

				<tr>
					<td class="veinte labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</td>
					<xsl:choose>
					<xsl:when test="/Mantenimiento/NUEVALICITACION or (/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_IDESTADO ='EST')">
						<td class="trenta datosLeft">
							<textarea name="LIC_DESCRIPCION" rows="4" cols="120"><xsl:value-of select="/Mantenimiento/LICITACION/LIC_DESCRIPCION"/></textarea>
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="trenta datosLeft borderGris" style="padding:15px 10px;">
							<xsl:value-of select="/Mantenimiento/LICITACION/LIC_DESCRIPCION"/>
						</td>
					</xsl:otherwise>
					</xsl:choose>
					<td>&nbsp;</td>
				</tr>

				<tr>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_entrega']/node()"/>:</td>

					<xsl:choose>
					<xsl:when test="/Mantenimiento/NUEVALICITACION or (/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_IDESTADO ='EST')">
						<td class="datosLeft">
							<textarea name="LIC_CONDENTREGA" rows="4" cols="120">
								<xsl:choose>
								<xsl:when test="Mantenimiento/NUEVALICITACION">
                                        	        		<xsl:value-of select="/Mantenimiento/NUEVALICITACION/LIC_CONDICIONESENTREGA"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CONDICIONESENTREGA"/>
								</xsl:otherwise>
								</xsl:choose>
							</textarea>
                                                </td>
					</xsl:when>
					<xsl:otherwise>
						<td class="datosLeft borderGris" style="padding:15px 10px;">
							<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CONDICIONESENTREGA"/>
                                                </td>
					</xsl:otherwise>
					</xsl:choose>

					<td>&nbsp;</td>
				</tr>

				<tr>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_pago']/node()"/>:</td>

					<xsl:choose>
					<xsl:when test="/Mantenimiento/NUEVALICITACION or (/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_IDESTADO ='EST')">
						<td class="datosLeft">
							<textarea name="LIC_CONDPAGO" rows="4" cols="120">
								<xsl:choose>
								<xsl:when test="Mantenimiento/NUEVALICITACION">
                                        	        		<xsl:value-of select="/Mantenimiento/NUEVALICITACION/LIC_CONDICIONESPAGO"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CONDICIONESPAGO"/>
								</xsl:otherwise>
								</xsl:choose>
							</textarea>
                                                </td>
					</xsl:when>
					<xsl:otherwise>
						<td class="datosLeft borderGris" style="padding:15px 10px;">
							<xsl:value-of select="/Mantenimiento/LICITACION/LIC_CONDICIONESPAGO"/>
                                                </td>
					</xsl:otherwise>
					</xsl:choose>

					<td>&nbsp;</td>
				</tr>

				<tr>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_otras']/node()"/>:</td>

					<xsl:choose>
					<xsl:when test="/Mantenimiento/NUEVALICITACION or (/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_IDESTADO ='EST')">
						<td class="datosLeft">
							<textarea name="LIC_CONDOTRAS" rows="4" cols="120">
								<xsl:choose>
								<xsl:when test="Mantenimiento/NUEVALICITACION">
                                        	        		<xsl:value-of select="/Mantenimiento/NUEVALICITACION/LIC_OTRASCONDICIONES"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="/Mantenimiento/LICITACION/LIC_OTRASCONDICIONES"/>
								</xsl:otherwise>
								</xsl:choose>
							</textarea>
                                                </td>
					</xsl:when>
					<xsl:otherwise>
						<td class="datosLeft borderGris" style="padding:15px 10px;">
							<xsl:value-of select="/Mantenimiento/LICITACION/LIC_OTRASCONDICIONES"/>
                                                </td>
					</xsl:otherwise>
					</xsl:choose>

					<td>&nbsp;</td>
				</tr>
				<tr>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='meses_duracion']/node()"/>:</td>

					<xsl:choose>
					<xsl:when test="/Mantenimiento/NUEVALICITACION or (/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_IDESTADO ='EST')">
						<td class="datosLeft">
							<select name="LIC_MESES" id="LIC_MESES">
								<option value="1">1 <xsl:value-of select="document($doc)/translation/texts/item[@name='mes']/node()"/></option>
								<option value="2">2 <xsl:value-of select="document($doc)/translation/texts/item[@name='meses']/node()"/></option>
								<option value="3">3 <xsl:value-of select="document($doc)/translation/texts/item[@name='meses']/node()"/></option>
								<option value="4">4 <xsl:value-of select="document($doc)/translation/texts/item[@name='meses']/node()"/></option>
								<option value="5">5 <xsl:value-of select="document($doc)/translation/texts/item[@name='meses']/node()"/></option>
								<option value="6">6 <xsl:value-of select="document($doc)/translation/texts/item[@name='meses']/node()"/></option>
								<option value="12">12 <xsl:value-of select="document($doc)/translation/texts/item[@name='meses']/node()"/></option>
								<option value="18">18 <xsl:value-of select="document($doc)/translation/texts/item[@name='meses']/node()"/></option>
								<option value="24">24 <xsl:value-of select="document($doc)/translation/texts/item[@name='meses']/node()"/></option>
							</select>
                                                </td>
					</xsl:when>
					<xsl:otherwise>
						<td class="datosLeft borderGris" style="padding:15px 10px;">
							<xsl:value-of select="/Mantenimiento/LICITACION/LIC_MESESDURACION"/>&nbsp;
							<xsl:choose>
							<xsl:when test="/Mantenimiento/LICITACION/LIC_MESESDURACION = 1">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='mes']/node()"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="document($doc)/translation/texts/item[@name='meses']/node()"/>
							</xsl:otherwise>
							</xsl:choose>
                                                </td>
					</xsl:otherwise>
					</xsl:choose>

					<td>&nbsp;</td>
				</tr>

				<tr>
                                    <td colspan="3">
                                        <table class="infoTable">
                                        <tr>
					<td class="veinte labelRight">&nbsp;</td>
					
                                        <xsl:if test="/Mantenimiento/NUEVALICITACION or (/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_IDESTADO ='EST')">
                                            <td class="veinte">
						<div class="boton">
							<a href="javascript:ValidarFormulario(document.forms['form1'],'datosGenerales');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
							</a>
						</div>
                                            </td>
                                            <td class="veinte">
                                               <div class="boton">
							<a href="javascript:ComprobarDatosGenerales(document.forms['form1'],'datosGenerales');" title="Volver">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
							</a>
						</div>
                                            </td>
                                                <input type="hidden" name="LIC_DESCRIPCION_OLD">
                                                        <xsl:attribute name="value">
                                                                <xsl:choose>
                                                                                        <xsl:when test="Mantenimiento/NUEVALICITACION"><xsl:value-of select="/Mantenimiento/NUEVALICITACION/LIC_DESCRIPCION"/></xsl:when>
                                                                                        <xsl:otherwise><xsl:value-of select="/Mantenimiento/LICITACION/LIC_DESCRIPCION"/></xsl:otherwise>
                                                                                        </xsl:choose>
                                                    </xsl:attribute>
                                                </input>
                                                 <input type="hidden" name="LIC_CONDENTREGA_OLD">
                                                        <xsl:attribute name="value">
                                                                <xsl:choose>
                                                                                        <xsl:when test="Mantenimiento/NUEVALICITACION"><xsl:value-of select="/Mantenimiento/NUEVALICITACION/LIC_CONDICIONESENTREGA"/></xsl:when>
                                                                                        <xsl:otherwise><xsl:value-of select="/Mantenimiento/LICITACION/LIC_CONDICIONESENTREGA"/></xsl:otherwise>
                                                                                        </xsl:choose>
                                                    </xsl:attribute>
                                                </input>
                                                 <input type="hidden" name="LIC_CONDPAGO_OLD">
                                                        <xsl:attribute name="value">
                                                                <xsl:choose>
                                                                                        <xsl:when test="Mantenimiento/NUEVALICITACION"><xsl:value-of select="/Mantenimiento/NUEVALICITACION/LIC_CONDICIONESPAGO"/></xsl:when>
                                                                                        <xsl:otherwise><xsl:value-of select="/Mantenimiento/LICITACION/LIC_CONDICIONESPAGO"/></xsl:otherwise>
                                                                                        </xsl:choose>
                                                    </xsl:attribute>
                                                </input>
                                                 <input type="hidden" name="LIC_CONDOTRAS_OLD">
                                                        <xsl:attribute name="value">
                                                                <xsl:choose>
                                                                                        <xsl:when test="Mantenimiento/NUEVALICITACION"><xsl:value-of select="/Mantenimiento/NUEVALICITACION/LIC_OTRASCONDICIONES"/></xsl:when>
                                                                                        <xsl:otherwise><xsl:value-of select="/Mantenimiento/LICITACION/LIC_OTRASCONDICIONES"/></xsl:otherwise>
                                                                                        </xsl:choose>
                                                    </xsl:attribute>
                                                </input>
                                                  <input type="hidden" name="LIC_MESES_OLD">
                                                        <xsl:attribute name="value">
                                                                <xsl:choose>
                                                                                        <xsl:when test="Mantenimiento/NUEVALICITACION">1</xsl:when>
                                                                                        <xsl:otherwise><xsl:value-of select="/Mantenimiento/LICITACION/LIC_MESESDURACION"/></xsl:otherwise>
                                                                                        </xsl:choose>
                                                    </xsl:attribute>
                                                </input>
						
					</xsl:if>
                                        <td>&nbsp;</td>
				</tr>
                               </table>
                                    
                            </td>
                           </tr>
			</table>
		</form>
-->

		<xsl:if test="not(/Mantenimiento/NUEVALICITACION)">
			<!-- PESTANA PRODUCTOS -->
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/ROL = 'VENDEDOR'">
				<xsl:call-template name="Tabla_Productos_Proveedor"/>
			</xsl:when>
			<xsl:when test="/Mantenimiento/LICITACION/ROL = 'COMPRADOR' and /Mantenimiento/LICITACION/LIC_IDESTADO = 'EST'">
				<xsl:call-template name="Tabla_Productos_Cliente_Estudio_Previo"/>
			</xsl:when>
			<xsl:when test="/Mantenimiento/LICITACION/ROL = 'COMPRADOR' and /Mantenimiento/LICITACION/LIC_IDESTADO != 'EST'">
				<xsl:call-template name="Tabla_Productos_Ofertas_Cliente"/>
			</xsl:when>
			<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
			<!-- FIN PESTANA PRODUCTOS -->

			<!-- PESTANA PROVEEDORES -->
			<table class="divLeft tablaProveedores infoTable" id="lProveedores" style="display:none;">
			<thead>
				<tr class="subTituloTabla">
					<td class="zerouno">&nbsp;</td>
					<td><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></td>
					<td class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></td>
					<!-- conversaciones -->
					<td class="dos">&nbsp;</td>
					<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_alta']/node()"/></td>
					<td class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion_abr']/node()"/></td>
					<td class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado_licitacion']/node()"/></td>
					<td class="veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios_cdc']/node()"/></td>
					<td class="veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios_prov']/node()"/></td>
				<xsl:choose>
				<xsl:when test="not(/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA)">
					<td class="siete"><xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_sIVA_2line']/node()"/></td>
				</xsl:when>
				<xsl:otherwise>
					<td class="siete"><xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_cIVA_2line']/node()"/></td>
				</xsl:otherwise>
				</xsl:choose>
					<td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='porcentaje_ahorro']/node()"/></td>
					<td class="siete"><xsl:copy-of select="document($doc)/translation/texts/item[@name='pedido_minimo_sIVA_2line']/node()"/></td>
					<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='acciones']/node()"/></td>
				</tr>
			</thead>

			<tbody>
           
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/PROVEEDORESLICITACION/PROVEEDOR">
				<xsl:for-each select="/Mantenimiento/LICITACION/PROVEEDORESLICITACION/PROVEEDOR">
				<tr style="background:#FFF;border-bottom:1px solid #999;">
					<xsl:if test="LIC_PROV_IDESTADO = 'ADJ' or LIC_PROV_IDESTADO = 'FIRM'">
						<xsl:attribute name="class">fondoVerde</xsl:attribute>
					</xsl:if>
					<td>
						<xsl:if test="LIC_PROV_OFERTASVACIAS = 'S'">
							<img src="http://www.newco.dev.br/images/change.png">
								<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='productos_sin_ofertas']/node()"/></xsl:attribute>
								<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='productos_sin_ofertas']/node()"/></xsl:attribute>
                                                        </img>
						</xsl:if>
                                        </td>
					<td><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalle.xsql?EMP_ID={IDPROVEEDOR}&amp;ESTADO=CABECERA','DetalleEmpresa',100,80,0,0)"><xsl:value-of select="NOMBRECORTO"/></a></td>
					<td><xsl:value-of select="USUARIO/NOMBRE"/></td>
					<!-- conversaciones -->
					<td>
						<xsl:choose>
						<xsl:when test="/Mantenimiento/LICITACION/LIC_IDESTADO != 'EST' and /Mantenimiento/LICITACION/LIC_IDESTADO != 'CONT'">
							<xsl:choose>
							<xsl:when test="/Mantenimiento/LICITACION/AUTOR">
								<a href="javascript:conversacionProveedor({/Mantenimiento/LICITACION/LIC_ID},{IDPROVEEDOR},{/Mantenimiento/US_ID},{USUARIO/ID},'{NOMBRE}');" style="text-decoration:none;">
									<img>
										<xsl:choose>
										<xsl:when test="CONVERSACION">
											<xsl:attribute name="src">http://www.newco.dev.br/images/bocadillo.gif</xsl:attribute>
											<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='leer_conversacion']/node()"/></xsl:attribute>
											<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='leer_conversacion']/node()"/></xsl:attribute>
										</xsl:when>
										<xsl:otherwise>
											<xsl:attribute name="src">http://www.newco.dev.br/images/bocadilloPlus.gif</xsl:attribute>
											<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='iniciar_conversacion']/node()"/></xsl:attribute>
											<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='iniciar_conversacion']/node()"/></xsl:attribute>
										</xsl:otherwise>
										</xsl:choose>
									</img>
								</a>
							</xsl:when>
<!--
							<xsl:when test="CONVERSACION and /Mantenimiento/LICITACION/ROL = 'COMPRADOR'">
-->
							<xsl:when test="CONVERSACION and /Mantenimiento/LICITACION/ADMIN">
								<a href="javascript:conversacionProveedor({/Mantenimiento/LICITACION/LIC_ID},{IDPROVEEDOR},{/Mantenimiento/US_ID},{USUARIO/ID},'{NOMBRE}');" style="text-decoration:none;">
									<img src="http://www.newco.dev.br/images/bocadillo.gif">
										<xsl:attribute name="alt">
											<xsl:value-of select="document($doc)/translation/texts/item[@name='leer_conversacion']/node()"/>
										</xsl:attribute>
										<xsl:attribute name="title">
											<xsl:value-of select="document($doc)/translation/texts/item[@name='leer_conversacion']/node()"/>
										</xsl:attribute>
									</img>
                                                                </a>
							</xsl:when>
							<xsl:otherwise>
								&nbsp;
							</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							&nbsp;
						</xsl:otherwise>
						</xsl:choose>
					</td>
					<td><xsl:value-of select="LIC_PROV_FECHAALTA"/></td>
					<td>
						<xsl:choose>
						<xsl:when test="LIC_PROV_IDESTADOEVALUACION = 'NOAPTO'">
							<img src="http://www.newco.dev.br/images/bolaRoja.gif"/>
						</xsl:when>
						<xsl:when test="LIC_PROV_IDESTADOEVALUACION = 'PEND'">
							<img src="http://www.newco.dev.br/images/bolaAmbar.gif"/>
						</xsl:when>
						<xsl:otherwise>
							<img src="http://www.newco.dev.br/images/bolaVerde.gif"/>
						</xsl:otherwise>
						</xsl:choose>
					</td>
					<td><xsl:value-of select="ESTADOLICITACION"/></td>
					<td>
						<xsl:choose>
						<!-- Texto largo => mostramos pop-up -->
						<xsl:when test="string-length(LIC_PROV_COMENTARIOSCDC) > 75">
							<a href="#" class="tooltip">
								<xsl:value-of select="substring(LIC_PROV_COMENTARIOSCDC,0,75)"/><xsl:text>...</xsl:text>
								<span class="classic"><xsl:value-of select="LIC_PROV_COMENTARIOSCDC"/></span>
							</a>
						</xsl:when>
						<!-- Texto corto => no hace falta pop-up -->
						<xsl:otherwise>
							<xsl:value-of select="LIC_PROV_COMENTARIOSCDC"/>
						</xsl:otherwise>
						</xsl:choose>
					</td>
					<td>
						<xsl:choose>
						<!-- Texto largo => mostramos pop-up -->
						<xsl:when test="string-length(LIC_PROV_COMENTARIOSPROV) > 75">
							<a href="#" class="tooltip">
								<xsl:value-of select="substring(LIC_PROV_COMENTARIOSPROV,0,75)"/><xsl:text>...</xsl:text>
								<span class="classic"><xsl:value-of select="LIC_PROV_COMENTARIOSPROV"/></span>
							</a>
						</xsl:when>
						<!-- Texto corto => no hace falta pop-up -->
						<xsl:otherwise>
							<xsl:value-of select="LIC_PROV_COMENTARIOSPROV"/>
						</xsl:otherwise>
						</xsl:choose>
					</td>
					<td>
						<xsl:choose>
						<xsl:when test="not(/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA)">
							<xsl:value-of select="LIC_PROV_CONSUMOPOTENCIAL"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="LIC_PROV_CONSUMOPOTENCIALIVA"/>
						</xsl:otherwise>
						</xsl:choose>
					</td>
					<td>
						<xsl:choose>
						<xsl:when test="not(/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA)">
							<xsl:if test="LIC_PROV_CONSUMO != ''">
								<xsl:choose>
								<xsl:when test="translate(LIC_PROV_AHORRO,',','.') = 0">
									<xsl:attribute name="class">amarillo</xsl:attribute>
								</xsl:when>
								<xsl:when test="translate(LIC_PROV_AHORRO,',','.') &lt; 0">
									<xsl:attribute name="class">fondoRojo</xsl:attribute>
								</xsl:when>
								<xsl:when test="translate(LIC_PROV_AHORRO,',','.') &gt; 0">
									<xsl:attribute name="class">fondoVerde</xsl:attribute>
								</xsl:when>
								</xsl:choose>

								<xsl:value-of select="LIC_PROV_AHORRO"/>%
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="LIC_PROV_CONSUMOPOTENCIALIVA != ''">
								<xsl:choose>
								<xsl:when test="translate(LIC_PROV_AHORROIVA,',','.') = 0">
									<xsl:attribute name="class">amarillo</xsl:attribute>
								</xsl:when>
								<xsl:when test="translate(LIC_PROV_AHORROIVA,',','.') &lt; 0">
									<xsl:attribute name="class">fondoRojo</xsl:attribute>
								</xsl:when>
								<xsl:when test="translate(LIC_PROV_AHORROIVA,',','.') &gt; 0">
									<xsl:attribute name="class">fondoVerde</xsl:attribute>
								</xsl:when>
								</xsl:choose>

								<xsl:value-of select="LIC_PROV_AHORROIVA"/>%
							</xsl:if>
						</xsl:otherwise>
						</xsl:choose>

<!--
						<xsl:variable name="ConsProv"><xsl:value-of select="translate(translate(LIC_PROV_CONSUMO,'.',''),',','.')"/></xsl:variable>
						<xsl:variable name="ConsObj"><xsl:value-of select="translate(translate(/Mantenimiento/LICITACION/LIC_CONSUMO,'.',''),',','.')"/></xsl:variable>
						<xsl:variable name="Ahorro"><xsl:value-of select="format-number(($ConsObj - $ConsProv) div $ConsObj,'##.##%')"/></xsl:variable>

						<xsl:if test="LIC_PROV_CONSUMO != '' and LIC_PROV_CONSUMO != '0,00'">
							<xsl:value-of select="translate($Ahorro,'.',',')"/>
						</xsl:if>
-->
					</td>
					<td><xsl:value-of select="LIC_PROV_PEDIDOMINIMO"/></td>

			<td>
				<!-- Boton para volver atras en el estado del proveedor -->
				<xsl:if test="/Mantenimiento/LICITACION/AUTOR and LIC_PROV_IDESTADO = 'INF' and (/Mantenimiento/LICITACION/LIC_IDESTADO = 'INF' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'CURS')">
					<a class="accRollBack" href="javascript:modificaEstadoProveedor({IDPROVEEDOR_LIC},'CURS','{LIC_PROV_COMENTARIOSPROV}',{/Mantenimiento/LICITACION/LIC_ID});">
						<img src="http://www.newco.dev.br/images/2017/reload.png">
							<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='lic_rollback_estado']/node()"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='lic_rollback_estado']/node()"/></xsl:attribute>
                                                </img>
					</a>&nbsp;
				</xsl:if>
				<!-- Boton para adjudicar proveedor -->
				<xsl:if test="/Mantenimiento/LICITACION/LIC_IDESTADO = 'INF' and /Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_PORPRODUCTO != 'S'">
					<a class="accAdjud" href="javascript:modificaEstadoProveedor({IDPROVEEDOR_LIC},'ADJ','{LIC_PROV_COMENTARIOSPROV}',{/Mantenimiento/LICITACION/LIC_ID});">
					<xsl:choose>
					<xsl:when test="/Mantenimiento/LICITACION/IDPAIS = '55'">
						<img src="http://www.newco.dev.br/images/adjudicadoProve-BR.gif"/>
					</xsl:when>
					<xsl:otherwise>
						<img src="http://www.newco.dev.br/images/adjudicadoProveL.gif"/>
					</xsl:otherwise>
					</xsl:choose>
					</a>&nbsp;
				</xsl:if>
				<!-- Boton para imprimir oferta (si como minimo esta informada) -->
				<xsl:if test="LIC_PROV_IDESTADO != 'CURS'">
					<a class="accImprimir" href="javascript:imprimirOferta({/Mantenimiento/LICITACION/LIC_ID},{IDPROVEEDOR_LIC});">
						<img src="http://www.newco.dev.br/images/imprimir.gif">
							<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir_oferta']/node()"/></xsl:attribute>
							<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir_oferta']/node()"/></xsl:attribute>
                                                </img>
					</a>
				</xsl:if>

				<xsl:choose>
				<xsl:when test="/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_IDESTADO='EST'">
					<a class="accBorrar" href="javascript:eliminarProveedor({IDPROVEEDOR_LIC},{USUARIO/ID},{/Mantenimiento/LICITACION/LIC_ID});"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>
                                </xsl:when>
				<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
                    </td>

				</tr>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<tr><td colspan="13" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion_sin_proveedores']/node()"/></strong></td></tr>
			</xsl:otherwise>
			</xsl:choose>
			</tbody>

		<xsl:if test="/Mantenimiento/LICITACION/LIC_IDESTADO='CURS' or /Mantenimiento/LICITACION/LIC_IDESTADO='INF' or /Mantenimiento/LICITACION/LIC_IDESTADO='ADJ' or /Mantenimiento/LICITACION/LIC_IDESTADO='CONT'">
			<tfoot>
				<tr><td colspan="13">&nbsp;</td></tr>

				<tr>
					<td colspan="8">&nbsp;</td>
				<xsl:choose>
				<xsl:when test="/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA">
					<td style="text-align:right;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_objetivo_cIVA']/node()"/>:</strong></td>
					<td><strong><xsl:value-of select="/Mantenimiento/LICITACION/LIC_CONSUMOIVA"/></strong></td>
				</xsl:when>
				<xsl:otherwise>
					<td style="text-align:right;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_objetivo_sIVA']/node()"/>:</strong></td>
					<td><strong><xsl:value-of select="/Mantenimiento/LICITACION/LIC_CONSUMO"/></strong></td>
				</xsl:otherwise>
				</xsl:choose>
					<td colspan="3">&nbsp;</td>

				</tr>
			</tfoot>
		</xsl:if>
			</table>

			<xsl:if test="/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_IDESTADO='EST'">
			<form id="Proveedores" name="Proveedores" method="post">
			<input type="hidden" name="LIC_ID" VALUE="{Mantenimiento/LICITACION/LIC_ID}"/>
			<table class="divLeft tablaProveedores infoTable" id="lProveedoresForm" style="display:none;">
				<tr style="border-top:2px solid #66667B;">
					<td class="veinte">&nbsp;</td>
					<td class="labelRight quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</td>
					<td class="veinte datosLeft">
						<select name="LIC_IDPROVEEDOR" id="LIC_IDPROVEEDOR">
							<option value=""><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciona']/node()"/></option>
							<xsl:for-each select="/Mantenimiento/LICITACION/PROVEEDORES/PROVEEDOR">
								<option value="{ID}"><xsl:value-of select="NOMBRE"/></option>
							</xsl:for-each>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr id="filaUsuarioProveedor" style="display:none;">
					<td>&nbsp;</td>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:</td>
					<td class="datosLeft">
						<select name="LIC_IDUSUARIOPROVEEDOR" id="LIC_IDUSUARIOPROVEEDOR"/>
					</td>
					<td>&nbsp;</td>
				</tr>

				<tr>
					<td>&nbsp;</td>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado_evaluacion']/node()"/>:</td>
					<td class="datosLeft">
						<select name="LIC_IDESTADOEVALUACION" id="LIC_IDESTADOEVALUACION">
							<xsl:for-each select="/Mantenimiento/LICITACION/ESTADOSEVALUACION/field/dropDownList/listElem">
								<option value="{ID}">
									<xsl:if test="ID = 'PEND'">
										<xsl:attribute name="selected">selected</xsl:attribute>
									</xsl:if>
									<xsl:value-of select="listItem"/>
								</option>
							</xsl:for-each>
                                                </select>
					</td>
					<td>&nbsp;</td>
				</tr>

				<tr>
					<td>&nbsp;</td>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/>:</td>
					<td class="datosLeft">
						<textarea name="LIC_COMENTARIOS" rows="4" cols="120"/>
					</td>
					<td>&nbsp;</td>
				</tr>

				<tr>
					<td colspan="2">&nbsp;</td>
					<td>
						<div class="boton">
							<a href="javascript:ValidarFormulario(document.forms['Proveedores'],'proveedores');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir']/node()"/>
							</a>
						</div>
					</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			</form>
			</xsl:if>

			<xsl:if test="/Mantenimiento/LICITACION/LIC_IDESTADO != 'EST' and /Mantenimiento/LICITACION/ROL = 'COMPRADOR'">
			<div class="tablaProveedores" style="clear:both;margin-left:80px;padding-top:50px;width:800px;display:none;">
			<table class="infoTable">
			<tfoot>
				<tr class="lejenda lineBorderBottom3">
					<td colspan="5" class="datosLeft" style="padding-left:20px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda']/node()"/>:</td>
				</tr>
				<tr class="lejenda" style="line-height:30px;">
					<td class="cinco" style="padding-left:20px;">
						<p><img src="http://www.newco.dev.br/images/edit.png" border="0"/></p>
					</td>
					<td style="padding-left:10px;">
						<p><xsl:value-of select="document($doc)/translation/texts/item[@name='abrir_comentarios']/node()"/></p>
					</td>
					<td class="uno">&nbsp;</td>
					<td class="dies" style="padding-left:20px;">
						<p style="background-color:#A8FFA8;">&nbsp;</p>
					</td>
					<td style="padding-left:10px;">
						<p><xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro_positivo']/node()"/></p>
					</td>
				</tr>
				<tr class="lejenda" style="line-height:30px;">
					<td style="padding-left:22px;">
						<p><img src="http://www.newco.dev.br/images/imprimir.gif" border="0"/></p>
					</td>
					<td style="padding-left:10px;">
						<p><xsl:value-of select="document($doc)/translation/texts/item[@name='abrir_pagina_imprimir']/node()"/></p>
					</td>
					<td>&nbsp;</td>
					<td style="padding-left:20px;">
						<p style="background-color:#FE9090;">&nbsp;</p>
					</td>
					<td style="padding-left:10px;">
						<p><xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro_negativo']/node()"/></p>
					</td>
				</tr>
				<tr class="lejenda" style="line-height:30px;">
					<td style="padding-left:22px;">
						<p><img src="http://www.newco.dev.br/images/2017/reload.png" border="0"/></p>
					</td>
					<td style="padding-left:10px;">
						<p><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitar_nueva_oferta']/node()"/></p>
					</td>
					<td>&nbsp;</td>
					<td style="padding-left:20px;">
						<p style="background-color:#FFFF99;">&nbsp;</p>
					</td>
					<td style="padding-left:10px;">
						<p><xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro_nulo']/node()"/></p>
					</td>
				</tr>
				<tr class="lejenda" style="line-height:30px;">
					<td style="padding-left:20px;">
						<p><img src="http://www.newco.dev.br/images/bocadilloPlus.gif" border="0"/></p>
					</td>
					<td style="padding-left:10px;">
						<p><xsl:value-of select="document($doc)/translation/texts/item[@name='crear_conversacion']/node()"/></p>
					</td>
					<td>&nbsp;</td>
					<td style="padding-left:20px;">
						<p style="background-color:#A8FFA8;">&nbsp;</p>
					</td>
					<td style="padding-left:10px;">
						<p><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor_adjudicado']/node()"/></p>
					</td>
				</tr>
				<tr class="lejenda" style="line-height:30px;">
					<td class="dies" style="padding-left:20px;">
						<p><img src="http://www.newco.dev.br/images/bocadillo.gif" border="0"/></p>
					</td>
					<td style="padding-left:10px;">
						<p><xsl:value-of select="document($doc)/translation/texts/item[@name='abrir_conversacion']/node()"/></p>
					</td>
					<td>&nbsp;</td>
					<td style="padding-left:20px;">
						<p style="padding-left:20px;"><img src="http://www.newco.dev.br/images/change.png" border="0"/></p>
					</td>
					<td style="padding-left:10px;">
						<p><xsl:value-of select="document($doc)/translation/texts/item[@name='productos_sin_ofertas']/node()"/></p>
					</td>

				</tr>
				<tr class="lejenda" style="line-height:30px;">
					<td class="dies" style="padding-left:27px;">
						<p><img src="http://www.newco.dev.br/images/bolaVerde.gif" border="0"/></p>
					</td>
					<td style="padding-left:10px;">
						<p><xsl:value-of select="document($doc)/translation/texts/item[@name='ev_apto']/node()"/></p>
					</td>
					<td colspan="3">&nbsp;</td>
				</tr>
				<tr class="lejenda" style="line-height:30px;">
					<td class="dies" style="padding-left:27px;">
						<p><img src="http://www.newco.dev.br/images/bolaAmbar.gif" border="0"/></p>
					</td>
					<td style="padding-left:10px;">
						<p><xsl:value-of select="document($doc)/translation/texts/item[@name='ev_pendiente']/node()"/></p>
					</td>
					<td colspan="3">&nbsp;</td>
				</tr>
				<tr class="lejenda lineBorderBottom5" style="line-height:30px;">
					<td class="dies" style="padding-left:27px;">
						<p><img src="http://www.newco.dev.br/images/bolaRoja.gif" border="0"/></p>
					</td>
					<td style="padding-left:10px;">
						<p><xsl:value-of select="document($doc)/translation/texts/item[@name='ev_no_apto']/node()"/></p>
					</td>
					<td colspan="3">&nbsp;</td>
				</tr>
			</tfoot>
			</table>
			</div>
			</xsl:if>
			<!-- FIN PESTANA PROVEEDORES -->

			<!-- PESTANA USUARIOS -->
			<table class="divLeft tablaUsuarios infoTable" id="lUsuarios" style="display:none;">
			<thead>
				<tr class="subTituloTabla">
					<td style="text-align:left;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></td>
					<td><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_alta']/node()"/></td>
					<td><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></td>
					<td><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_firma']/node()"/></td>
					<td><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/></td>
					<td><xsl:value-of select="document($doc)/translation/texts/item[@name='acciones']/node()"/></td>
				</tr>
			</thead>

			<tbody>
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/USUARIOSLICITACION/USUARIO">
				<xsl:for-each select="/Mantenimiento/LICITACION/USUARIOSLICITACION/USUARIO">
				<tr>
					<td class="datosLeft">&nbsp;
						<xsl:if test="AUTOR"><span class="amarillo"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/>:</strong></span>&nbsp;</xsl:if>
						<xsl:value-of select="NOMBRE"/>
					</td>
					<td><xsl:value-of select="LIC_USU_FECHAALTA"/></td>
					<td><xsl:value-of select="ESTADOLICITACION"/></td>
					<td><xsl:value-of select="LIC_USU_FECHAMODIFICACION"/></td>
					<td><xsl:value-of select="LIC_USU_COMENTARIOS"/></td>
					<td>
						<xsl:if test="/Mantenimiento/LICITACION/LIC_IDESTADO = 'FIRM' and ID = /Mantenimiento/US_ID and LIC_USU_IDESTADO != 'FIRM'">
							<a class="accFirma" href="javascript:modificaUsuario({IDUSUARIO_LIC},'FIRM',{/Mantenimiento/LICITACION/LIC_ID});"><img src="http://www.newco.dev.br/images/firmar.gif"/></a>&nbsp;
						</xsl:if>
						<xsl:if test="not(AUTOR) and /Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_IDESTADO='EST'">
							<a class="accBorrar" href="javascript:modificaUsuario({IDUSUARIO_LIC},'B',{/Mantenimiento/LICITACION/LIC_ID});">
								<img src="http://www.newco.dev.br/images/2017/trash.png"/>
							</a>
						</xsl:if>
					</td>
				</tr>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<tr><td colspan="6" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion_sin_usuarios']/node()"/></strong></td></tr>
			</xsl:otherwise>
			</xsl:choose>
			</tbody>
			</table>

			<xsl:if test="/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_IDESTADO='EST'">
			<form id="Usuarios" name="Usuarios" method="post">
			<input type="hidden" name="LIC_ID" VALUE="{/Mantenimiento/LICITACION/LIC_ID}"/>
            <input type="hidden" name="ROL" VALUE="{Mantenimiento/LICITACION/ROL}"/>
            <input type="hidden" name="IDIOMA" VALUE="{Mantenimiento/LICITACION/IDIDIOMA}"/>
            
			<table class="divLeft tablaUsuarios infoTable" id="lUsuariosForm" style="display:none;">
				<tr style="border-top:2px solid #66667B;">
					<td class="trenta">&nbsp;</td>
					<td class="labelRight quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuarios']/node()"/>:</td>
					<td class="quince datosLeft">
						<xsl:choose>
						<xsl:when test="/Mantenimiento/LICITACION/AUTOR">
							<select name="LIC_IDUSUARIO">
								<option value=""><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciona']/node()"/></option>
								<xsl:for-each select="/Mantenimiento/LICITACION/USUARIOS/USUARIO">
									<option value="{ID}"><xsl:value-of select="NOMBRE"/></option>
								</xsl:for-each>
							</select>
						</xsl:when>
						<xsl:otherwise></xsl:otherwise>
						</xsl:choose>
					</td>
					<td>&nbsp;</td>
				</tr>

				<tr>
					<td colspan="2">&nbsp;</td>
					<td>
						<div class="boton">
							<a href="javascript:ValidarFormulario(document.forms['Usuarios'],'usuarios');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir']/node()"/>
							</a>
						</div>
					</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			</form>
			</xsl:if>
			<!-- FIN PESTANA USUARIOS -->
		</xsl:if>


	</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>

<!--template carga documentos-->
<xsl:template name="CargaDocumentos">
	<xsl:param name="tipo"/>
	<xsl:param name="LicProdID"/>
	<xsl:param name="nombre_corto"/>

	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/Mantenimiento/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="divLeft80" id="cargaDoc{$tipo}"> 
		<!--tabla imagenes y documentos-->
		<table class="infoTable" border="0">
			<tr>
				<!--documentos-->
				<td class="labelRight quince">
					<span class="text{$tipo}_{$LicProdID}">
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
				<td class="datosLeft trenta">
					<div class="altaDocumento">
						<span class="anadirDoc">
							<xsl:call-template name="documentos">
								<xsl:with-param name="num" select="number(1)"/>
								<xsl:with-param name="LicProdID" select="$LicProdID"/>
								<xsl:with-param name="type" select="$tipo"/>
							</xsl:call-template>
						</span>
					</div>
				</td>
				<td class="dies">
					<div class="boton">
						<a href="javascript:cargaDoc(document.forms['ProductosProveedor'],'{$tipo}','{$LicProdID}');">
							<span class="text{$tipo}">
								<xsl:choose>
								<xsl:when test="$nombre_corto != ''">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_oferta']/node()"/>&nbsp;<xsl:value-of select="$nombre_corto"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_ficha']/node()"/>
								</xsl:otherwise>
								</xsl:choose>
                                                        </span>
						</a>
					</div>
				</td>
				<td>
                                    <div id="waitBoxDoc_{$LicProdID}" align="center">&nbsp;</div>

                                    <div id="confirmBox_{$LicProdID}" style="display:none;" align="center">
                                            <span class="cargado">¡<xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/>!</span>
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

	<xsl:choose>
	<xsl:when test="$num &lt; number(5)">
		<div class="docLine" id="docLine_{$LicProdID}">
			<div class="docLongEspec" id="docLongEspec_{$LicProdID}">
				<input id="inputFileDoc_{$LicProdID}" name="inputFileDoc" type="file" onChange="addDocFile('{$LicProdID}');" />
			</div>
		</div>
	</xsl:when>
	</xsl:choose>
</xsl:template>
<!--fin de documentos-->

</xsl:stylesheet>