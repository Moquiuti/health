<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Mantenimiento de productos desde fichero
	ultima revision:ET 30jun23 09:40 MantenProductos2022_300623.js CargaRegulados_171022.js CargaCambioGrupo_081122.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/MantenProductos">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/MantenProductos/LANG"><xsl:value-of select="/MantenProductos/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Mant_cat_fichero']/node()"/>:&nbsp;<xsl:value-of select="/MantenProductos/INICIO/EMPRESA"/></title>
	<xsl:call-template name="estiloIndip"/>

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>
	<!--	Nuevas librerias para manejo desde JS de ficheros XML	-->
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/MantenProductos2022_300623.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CargaRegulados_171022.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CargaCambioGrupo_081122.js"></script>
	<script type="text/javascript">
	var IDUsuario= '<xsl:value-of select="/MantenProductos/INICIO/IDUSUARIO"/>';
	var IDPais= '<xsl:value-of select="/MantenProductos/INICIO/IDPAIS"/>';
	var IDEmpresa= '<xsl:value-of select="/MantenProductos/INICIO/IDEMPRESA"/>';
	var Rol= '<xsl:value-of select="/MantenProductos/INICIO/ROL"/>';
	var esMVM= '<xsl:choose><xsl:when test="/MantenProductos/INICIO/MVM">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';	
	var conPrecioFab= '<xsl:choose><xsl:when test="/MantenProductos/INICIO/MOSTRAR_PRECIO_FABRICA">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';	

	var ncRefCat= '<xsl:value-of select="document($doc)/translation/texts/item[@name='RefCat']/node()"/>';
	var ncRefCliCat= '<xsl:value-of select="document($doc)/translation/texts/item[@name='RefCliCat']/node()"/>';
	var ncNombreCat= '<xsl:value-of select="document($doc)/translation/texts/item[@name='NombreCat']/node()"/>';
	var ncRefFam= '<xsl:value-of select="document($doc)/translation/texts/item[@name='RefFam']/node()"/>';
	var ncRefCliFam= '<xsl:value-of select="document($doc)/translation/texts/item[@name='RefCliFam']/node()"/>';
	var ncNombreFam= '<xsl:value-of select="document($doc)/translation/texts/item[@name='NombreFam']/node()"/>';
	var ncRefSubFam= '<xsl:value-of select="document($doc)/translation/texts/item[@name='RefSubFam']/node()"/>';
	var ncRefCliSubFam= '<xsl:value-of select="document($doc)/translation/texts/item[@name='RefCliSubFam']/node()"/>';
	var ncNombreSubFam= '<xsl:value-of select="document($doc)/translation/texts/item[@name='NombreSubFam']/node()"/>';
	var ncRefGru= '<xsl:value-of select="document($doc)/translation/texts/item[@name='RefGru']/node()"/>';
	var ncRefCliGru= '<xsl:value-of select="document($doc)/translation/texts/item[@name='RefCliGru']/node()"/>';
	var ncNombreGru= '<xsl:value-of select="document($doc)/translation/texts/item[@name='NombreGru']/node()"/>';
	
	var ncNifProveedor= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cod_Nif_Proveedor']/node()"/>';
	var ncNifCentro= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cod_Nif_Centro']/node()"/>';
	var ncNombre= '<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>';
	var ncMarca= '<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>';
	var ncUdBasica= '<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>';
	var ncUdesLote= '<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_lote']/node()"/>';
	var ncPrecio= '<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ud_basica']/node()"/>';
	var ncIVA= '<xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/>';

	var ncRefEstandar= '<xsl:value-of select="document($doc)/translation/texts/item[@name='RefEstandar']/node()"/>';
	var ncRefCliente= '<xsl:value-of select="document($doc)/translation/texts/item[@name='RefCliente']/node()"/>';
	var ncRefGrupo= '<xsl:value-of select="document($doc)/translation/texts/item[@name='RefGrupo']/node()"/>';
	var ncRefCentro= '<xsl:value-of select="document($doc)/translation/texts/item[@name='RefCentro']/node()"/>';
	var ncRefProveedor= '<xsl:value-of select="document($doc)/translation/texts/item[@name='RefProveedor']/node()"/>';

	var ncMarcas= '<xsl:value-of select="document($doc)/translation/texts/item[@name='marcas']/node()"/>';
	var ncRegulado= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Regulado']/node()"/>';
	var ncCurvaABC= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Curva_ABC']/node()"/>';
	var ncPrecioRef= '<xsl:value-of select="document($doc)/translation/texts/item[@name='PrecioRef']/node()"/>';

	var ncCodExpediente= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cod_Expediente']/node()"/>';
	var ncCodIum= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cod_IUM']/node()"/>';
	var ncCodCum= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cod_CUM']/node()"/>';
	var ncInvima= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cod_Invima']/node()"/>';
	var ncFechaInvima= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_Limite']/node()"/>';
	var ncClasRiesgo= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Clas_Riesgo']/node()"/>';

	var ncRefPack= '<xsl:value-of select="document($doc)/translation/texts/item[@name='RefPack']/node()"/>';
	var ncCantidad= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/>';
	
	var ncFechaInicioTarifa= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Fec_inic_tarifa']/node()"/>';
	var ncFechaFinalTarifa= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Fec_fin_tarifa']/node()"/>';
	var ncNombreDocumento= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Doc_tarifa']/node()"/>';
	var ncTipoNegociacion= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_negociacion']/node()"/>';

	var ncOrden= '<xsl:value-of select="document($doc)/translation/texts/item[@name='orden']/node()"/>';
	var ncAutorizado= '<xsl:value-of select="document($doc)/translation/texts/item[@name='autorizado']/node()"/>';
	var ncUnidadBasica= '<xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/>';
	
	var ncRegistroMS= '<xsl:value-of select="document($doc)/translation/texts/item[@name='RegistroMS']/node()"/>';
	var ncCaducidadMS= '<xsl:value-of select="document($doc)/translation/texts/item[@name='CaducidadMS']/node()"/>';
	var ncOncologico= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Oncologico']/node()"/>';
	var ncPrincipioActivo= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Principio_activo']/node()"/>';
	var ncGrupoDeStock= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Grupo_stock']/node()"/>';
	
	var ncNombreEstandar= '<xsl:value-of select="document($doc)/translation/texts/item[@name='DescEstandar']/node()"/>';
	var ncPrecioCliente= '<xsl:value-of select="document($doc)/translation/texts/item[@name='PrecioCliente']/node()"/>';
	var ncPrecioCentral= '<xsl:value-of select="document($doc)/translation/texts/item[@name='PrecioCentral']/node()"/>';
	var ncAhorro= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro']/node()"/>';
	var ncAhorroPorc= '<xsl:value-of select="document($doc)/translation/texts/item[@name='AhorroPorc']/node()"/>';
	var ncOrigen= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Origen']/node()"/>';
	
	var ncProveedor= '<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>';
	var ncNombreCorto= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_corto']/node()"/>';
	var ncDireccion= '<xsl:value-of select="document($doc)/translation/texts/item[@name='direccion']/node()"/>';
	var ncPoblacion= '<xsl:value-of select="document($doc)/translation/texts/item[@name='poblacion']/node()"/>';
	var ncProvincia= '<xsl:value-of select="document($doc)/translation/texts/item[@name='provincia']/node()"/>';
	var ncBarrio= '<xsl:value-of select="document($doc)/translation/texts/item[@name='barrio']/node()"/>';
	var ncCodPostal= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cod_postal_proveedor']/node()"/>';
	var ncTelefono= '<xsl:value-of select="document($doc)/translation/texts/item[@name='telefono']/node()"/>';
	var ncPlazoEntrNormal= '<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/>';
	var ncPlazoEnvio= '<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_envio']/node()"/>';
	var ncUsuario= '<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>';
	var ncTelfUsuario= '<xsl:value-of select="document($doc)/translation/texts/item[@name='telefono']/node()"/>';
	var ncEmailUsuario= '<xsl:value-of select="document($doc)/translation/texts/item[@name='e_mail']/node()"/>';

	var ncNombreProdCli= '<xsl:value-of select="document($doc)/translation/texts/item[@name='NombreProdCli']/node()"/>';
	var ncNombreProdMaest= '<xsl:value-of select="document($doc)/translation/texts/item[@name='NombreProdMaestro']/node()"/>';
	var ncIDMaestro= '<xsl:value-of select="document($doc)/translation/texts/item[@name='IDMaestro']/node()"/>';
	var ncRefMaestro= '<xsl:value-of select="document($doc)/translation/texts/item[@name='RefMaestro']/node()"/>';
	var ncIDCliente= '<xsl:value-of select="document($doc)/translation/texts/item[@name='IDCliente']/node()"/>';

	var ncAreaGeo= '<xsl:value-of select="document($doc)/translation/texts/item[@name='AreaGeo']/node()"/>';
	var ncCodDivisa= '<xsl:value-of select="document($doc)/translation/texts/item[@name='CodDivisa']/node()"/>';
	var ncCantBonif= '<xsl:value-of select="document($doc)/translation/texts/item[@name='CantBonif']/node()"/>';
	var ncCantGratis= '<xsl:value-of select="document($doc)/translation/texts/item[@name='CantGratis']/node()"/>';
	
	var ncCodComprador='Cod.<xsl:value-of select="document($doc)/translation/texts/item[@name='comprador']/node()"/>';
	var ncNumeroPedido= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cod_abbr']/node()"/><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>';
	var ncEstadoPedido= '<xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>';
	var ncDivisa= 'DIV';
	var ncCantidadPendiente= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/> <xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>';
	var ncImportePendiente= '<xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/> <xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>';
	var ncFechaPrevistaEntrega= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_entrega']/node()"/>';
	var ncFechaPedido= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_emis']/node()"/>';
	var ncLugarEntrega= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cod_lug_entrega']/node()"/>';
	var ncCodCentroCoste= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cod_cen_consumo']/node()"/>';
	var ncNombreCentroCoste= '<xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_consumo']/node()"/>';
	var ncPorDefecto= '<xsl:value-of select="document($doc)/translation/texts/item[@name='por_defecto']/node()"/>';

	var ncPrecioMax= '<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_max']/node()"/>';
	var ncComentarios= '<xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/>';

	var ncPrecioFab= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Precio_fabrica']/node()"/>';
	var ncDescuento= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Descuento']/node()"/>';

	var strRefCatObligatoria= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Ref_cat_obligatoria']/node()"/>';
	var strCatObligatoria= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Nombre_cat_obligatorio']/node()"/>';
	var strRefFamObligatoria= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Ref_fam_obligatoria']/node()"/>';
	var strFamObligatoria= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Nombre_fam_obligatorio']/node()"/>';
	var strRefSFObligatoria= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Ref_sf_obligatoria']/node()"/>';
	var strSFObligatoria= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Nombre_sf_obligatorio']/node()"/>';
	var strRefGruObligatoria= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Ref_cat_obligatoria']/node()"/>';
	var strGruObligatorio= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Nombre_gru_obligatorio']/node()"/>';
	
	var strIDMaestroObligatorio= '<xsl:value-of select="document($doc)/translation/texts/item[@name='ID_Maestro_obli']/node()"/>';
	var strCodCentroObligatorio= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cod_centro_obli']/node()"/>';
	var strRefCentroObligatorio= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Ref_centro_obli']/node()"/>';
	var strCodProveedorObligatorio= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cod_proveedor_obli']/node()"/>';
	var strReferenciaObligatoria= '<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia_obli']/node()"/>';
	var strNombreObligatorio= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_obli']/node()"/>';
	var strMarcaObligatoria= '<xsl:value-of select="document($doc)/translation/texts/item[@name='marca_obli']/node()"/>';
	var strUdBasica= '<xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica_obli']/node()"/>';
	var strPrecioObligatorio= '<xsl:value-of select="document($doc)/translation/texts/item[@name='precios_vacios']/node()"/>';
	var strUdesLoteNoNumerico= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_un_lote_no_numero']/node()"/>';
	var strPrecioNoNumerico= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_precio_no_numero']/node()"/>';
	var strTipoIVAObligatorio= '<xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva_no_numero']/node()"/>';
	var strCantidadObligatoria= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_obli']/node()"/>';
	var strFechaIncorrecta= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_incorrecta']/node()"/>';
	var strGrupoStockIncorrecto= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Grupo_stock_incorrecto']/node()"/>';
	var strDescuentoNoNumerico= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_descuento_no_numero']/node()"/>';

	var strCantBonifNoNumerico= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_cant_bonif_no_numero']/node()"/>';
	var strCantGratisNoNumerico= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_cant_gratis_no_numero']/node()"/>';
	var strCodDivisaIncorrecto= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_cod_divisa_incorrecto']/node()"/>';

	var strAutorizadoSoN= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Autorizado_S_N']/node()"/>';

	var str_NoPodidoIncluirProducto= '<xsl:value-of select="document($doc)/translation/texts/item[@name='No_podido_incluir_producto']/node()"/>';
	var str_ErrSubirProductos= '<xsl:value-of select="document($doc)/translation/texts/item[@name='err_subir_productos_solicitud_catalogacion']/node()"/>';
	var str_FicheroProcesado= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Fichero_Procesado']/node()"/>';
	var str_FicheroYaEnviado= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Fichero_ya_enviado']/node()"/>';	
	var str_ErrorDesconocidoCreandoFichero= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Error_desconocido_creando_fichero']/node()"/>';	
	var str_NoPodidoIncluirLinea= '<xsl:value-of select="document($doc)/translation/texts/item[@name='No_podido_incluir_producto']/node()"/>';
	
	//	Carga de proveedores
	var strProveedorObligatorio= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Nombre_proveedor_obligatorio']/node()"/>';
	var strDireccionObligatoria= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Direccion_obligatoria']/node()"/>';
	var strPoblacionObligatoria= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Poblacion_obligatoria']/node()"/>';
	var strProvinciaObligatoria= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Provincia_obligatoria']/node()"/>';
	var strCodPostalObligatorio= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Codpostal_obligatorio']/node()"/>';
	var strUsuarioObligatorio= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Usuario_obligatorio']/node()"/>';
	var strEmailObligatorio= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Email_obligatorio']/node()"/>';
	
	var strNombreProdCliObligatorio= '<xsl:value-of select="document($doc)/translation/texts/item[@name='NombreProdCli_Obligatorio']/node()"/>';
	var strNombreProdMaestroObligatorio= '<xsl:value-of select="document($doc)/translation/texts/item[@name='NombreProdMaestro_Obligatorio']/node()"/>';

	var strCampoObligatorio= '<xsl:value-of select="document($doc)/translation/texts/item[@name='campo_obligatorio']/node()"/>';
	var strReguladoSoN= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Regulado_S_N']/node()"/>';

	//	Carga de centros de coste
	var strPorDefectoNoCorrecto= '<xsl:value-of select="document($doc)/translation/texts/item[@name='PorDefecto_no_correcto']/node()"/>';

	</script>
</head>

<body onLoad="javascript:Inicializar();">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/MantenProductos/LANG"><xsl:value-of select="/MantenProductos/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
	
	<xsl:choose>
	<xsl:when test="/MantenProductos/ERROR">
		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_de_productos']/node()"/></h1>
		<h2 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></h2>
	</xsl:when>
	<xsl:otherwise>

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
 			<xsl:choose>
			<xsl:when test="/MantenProductos/INICIO/OPCION">
				<xsl:value-of select="/MantenProductos/INICIO/OPCION"/>
			</xsl:when>
			<xsl:otherwise>
				<!--6set22	<xsl:value-of select="/MantenProductos/INICIO/EMPRESA"/>-->
			</xsl:otherwise>
			</xsl:choose>
       		&nbsp;&nbsp;
			<span class="CompletarTitulo">
			</span>
		</p>
	</div>
	<br/>
	<form name="frmProductos" method="post">
	<table cellspacing="6px" cellpadding="6px">		
	<xsl:choose>
		<xsl:when test="/MantenProductos/INICIO/OPCIONES/field">
			<tr>
				<td class="labelRight" colspan="3">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_tarea']/node()"/>:&nbsp;
				</td>
				<td class="textLeft" colspan="3">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/MantenProductos/INICIO/OPCIONES/field"/>
						<xsl:with-param name="claSel">w400px</xsl:with-param>
						<xsl:with-param name="onChange">javascript:MostrarEstructuraDatos();</xsl:with-param>
					</xsl:call-template>
					<span id="Forzar">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" class="muypeq" name="chkForzar" id="chkForzar"/><xsl:value-of select="document($doc)/translation/texts/item[@name='Forzar_nombre']/node()"/></span>
				</td>
			</tr>
		</xsl:when>
		<xsl:otherwise>
			<input type="hidden" name="FIDOPCION" value="{/MantenProductos/INICIO/IDOPCION}"/>
		</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
		<xsl:when test="/MantenProductos/INICIO/EMPRESAS/field">
			<tr id="trCliente">
				<td class="labelRight" colspan="3">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/>:&nbsp;
				</td>
				<td class="textLeft" colspan="3">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/MantenProductos/INICIO/EMPRESAS/field"/>
						<xsl:with-param name="claSel">w300px</xsl:with-param>
					</xsl:call-template>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(<xsl:value-of select="document($doc)/translation/texts/item[@name='cond_part_aplic_este_cliente']/node()"/>)
				</td>
			</tr>
		</xsl:when>
		<xsl:otherwise>
			<input type="hidden" name="FIDEMPRESA" value="{/MantenProductos/INICIO/IDCLIENTE}"/>
		</xsl:otherwise>
		</xsl:choose>
		<tr>
			<td class="labelRight" colspan="3">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='fichero']/node()"/>:&nbsp;
			</td>
			<td class="textLeft" colspan="3">
				<input type="hidden" name="IDPROVEEDOR" id="IDPROVEEDOR" value="1"/>
				<input type="hidden" name="CADENA_DOCUMENTOS"/>
				<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
				<input type="hidden" name="BORRAR_ANTERIORES"/>
				<input type="hidden" name="REMOVE" value="Eliminar"/>
				<input class="muygrande" id="inputFile" name="inputFile" type="file" onChange="EnviarFichero(this.files);"/>
			</td>
		</tr>
	</table>
	<br/>
	<br/>

	<table cellspacing="6px" cellpadding="6px" class="marginLeft20">		
	<tr>
		<td class="textLeft" colspan="3">
			&nbsp;&nbsp;&nbsp;&nbsp;<span id="formatoCarga" class="labelLeft">********* pendiente **********</span>&nbsp;&nbsp;&nbsp;&nbsp;<a class="btnNormal" href="javascript:DescargarModelo();"><xsl:value-of select="document($doc)/translation/texts/item[@name='descargar_modelo']/node()"/></a>
			<br/><br/>
		</td>
	</tr>
	<tr>
        <td class="w1100px">
			<div class="divLeft">
				<table class="buscador">
					<tr>
						<td class="textLeft">
							&nbsp;&nbsp;&nbsp;<textarea name="TXT_PRODUCTOS" id="TXT_PRODUCTOS" cols="150" rows="40" wrap="off"/>
						</td>
						<td class="textLeft">
 							&nbsp;&nbsp;&nbsp;<a id="btnMantenProductos" class="btnDestacado" href="javascript:MantenCatalogosTXT();"><xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/></a>
						</td>
					</tr>
				</table>
        	</div>
        </td>
        <td style="width:20px;">
            &nbsp;
        </td>
        <td style="width:*;">
			<div style="text-align:left;"><p id="infoProgreso"></p></div>
			<div id="infoErrores" style="text-align:left;color:red;display:none;"></div>
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
	</table>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	</form>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
