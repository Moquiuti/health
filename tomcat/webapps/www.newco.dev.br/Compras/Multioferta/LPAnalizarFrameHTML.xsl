<?xml version="1.0" encoding="iso-8859-1"?>
<!-- 
	Primer paso del pedido: selección de productos, asignación de cantidades
	Ultima revision:  ET 15mar22 11:10 LPAnalizar_150322a.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/">
<xsl:choose>
<xsl:when test="//xsql-error">
	<xsl:apply-templates select="//xsql-error"/>
</xsl:when>
<xsl:otherwise>

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
        <link href="http://www.newco.dev.br/General/Tabla-popup.css" rel="stylesheet" type="text/css"/>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='preparacion_pedido']/node()"/>:&nbsp;<xsl:value-of select="/Analizar/ANALISIS/LINEAS/LINEA_ROW[1]/PRODUCTOS/PRODUCTOS_ROW/CENTROPROVEEDOR"/></title>

	<link rel="stylesheet" href="http://www.newco.dev.br/General/calendario/spiffyCal_v2_1.css" type="text/css"/>

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.highlight-5.closure.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.highlight.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<!--15mar19	<script type="text/javascript" src="http://www.newco.dev.br/General/divisas.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/calendario/spiffyCal_v2_1.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>		<!-- 3may21 Para descargas excel	-->
	<script type="text/javascript" src="http://www.newco.dev.br/Compras/Multioferta/LPAnalizar_150322a.js"></script>
    <!--15mar19	<script type="text/javascript" src="http://www.newco.dev.br/General/Tabla-popup.js"></script>-->

    <script type="text/javascript">
		var nombre	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>';
        var proveedor	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>';
        var ref_estandar	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_estandar']/node()"/>';
        var ref_proveedor	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/>';
        var marca	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>';
        var iva	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/>';
        var unidad_basica	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/>';
        var unidad_lote	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_lote']/node()"/>';
        var farmacia	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='farmacia']/node()"/>';
        var homologado	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='homologado']/node()"/>';
        var precio	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>';
        var catalogo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo']/node()"/>';
        var familia	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='familia']/node()"/>';
        var subfamilia	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='subfamilia']/node()"/>';
        var grupo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='grupo']/node()"/>';
        var strPlantillaGrande	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='plantilla_grande_solo_mostraran']/node()"/>';
        var strAvisoProcesados	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='aviso_productos_procesados']/node()"/>';
		//	2set19 Tarsladamos cadenas del DOM al JS
	    var strPedidoNoLLega	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_no_llega']/node()"/>';
        var strPorFavorRevise	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='por_favor_revise']/node()"/>';
        var strAvisoSaltarPedMinimo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='aviso_saltar_un_pedido_minimo']/node()"/>';
        var strTodasNegativas	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='son_todas_negativas']/node()"/>';
        var strVerifiqueAbono	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='verifique_cantidades_abono']/node()"/>';
        var strCantidadIncorrecta	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_incorrecta_sostituye']/node()"/>';
        var strRedondeoUnidades	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='redondeo_unidades']/node()"/>';
        var strRedondeoUnidades2= '<xsl:value-of select="document($doc)/translation/texts/item[@name='redondeo_unidades_2']/node()"/>';
        var strUnidades= '<xsl:value-of select="document($doc)/translation/texts/item[@name='unidades_2']/node()"/>';
        var strCajas= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cajas']/node()"/>';
        var strCantidadesNegativas= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidades_negativas']/node()"/>';
	</script>
	<xsl:text disable-output-escaping="yes"><![CDATA[

	<script type="text/javascript">
	<!--
		var msgCantidadNegativa='';

		// Variables globales que indican que tipo de plantilla utilizar
		//var nuevoModeloNegocio='';
		//var pedidoAntiguo='';

		// Otras variables globales
		//var IDCentro;
		//var IDPlantilla;
		//var IDPais;
		//var IDIdioma;
		//var mostrarPrecioIVA;
		//var usarGrupo;
		//var plazoEntrega;
		//var tipoPlantilla;
		//var ocultarPrecioReferencia;
		//var sinMarca;
        //var minimalista;
        //var sinCategorias;

		// Variables globales para clubs privados de compra (limites de compra mensuales)
		var limiteComprasMensual, fechaCuota, comprasPrevias;


]]></xsl:text>
		var LP_ID			= '<xsl:value-of select="/Analizar/ANALISIS/LP_ID"/>';
		var IDCentro		= '<xsl:value-of select="/Analizar/ANALISIS/CABECERA/LISTA/CENTRO/CEN_ID"/>';
		var IDPlantilla		= '<xsl:value-of select="/Analizar/PL_ID"/>';
		var IDPais			= '<xsl:value-of select="/Analizar/ANALISIS/IDPAIS"/>';
		var IDIdioma		= '<xsl:value-of select="/Analizar/ANALISIS/IDIDIOMA"/>';
		var IDCentroCoste	= '<xsl:value-of select="/Analizar/ANALISIS/CABECERA/IDCENTROCOSTE"/>';
		var IDLugarEntrega	= '<xsl:value-of select="/Analizar/ANALISIS/CABECERA/IDLUGARENTREGA"/>';
		var poslugarEntrega	= 0;
		var IDCentroDefecto	= '<xsl:value-of select="/Analizar/ANALISIS/CABECERA/IDCENTRODEFECTO"/>';
		var mostrarPrecioIVA	= '<xsl:choose><xsl:when test="/Analizar/ANALISIS/MOSTRAR_PRECIO_CON_IVA">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		var usarRefProveedor	= '<xsl:choose><xsl:when test="/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		var usarGrupo		= '<xsl:choose><xsl:when test="/Analizar/ANALISIS/UTILIZAR_GRUPO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';

		var plazoEntrega		= '<xsl:value-of select="/Analizar/ANALISIS/CABECERA/LISTA/LP_PLAZOENTREGA"/>';
		var ocultarPrecioReferencia	= '<xsl:value-of select="/Analizar/ANALISIS/OCULTAR_PRECIO_REFERENCIA/@Ocultar"/>';
		var sinMarca		= '<xsl:choose><xsl:when test="/Analizar/ANALISIS/SIN_MARCA">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';

		limiteComprasMensual	= '<xsl:choose><xsl:when test="/Analizar/ANALISIS/LIMITECOMPRAS"><xsl:value-of select="/Analizar/ANALISIS/LIMITECOMPRAS"/></xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		if(limiteComprasMensual != 'N'){
			fechaCuota	= '<xsl:value-of select="/Analizar/ANALISIS/FECHACUOTA"/>';
			comprasPrevias	= '<xsl:choose><xsl:when test="/Analizar/ANALISIS/COMPRASPREVIAS != ''"><xsl:value-of select="/Analizar/ANALISIS/COMPRASPREVIAS"/></xsl:when><xsl:otherwise>0</xsl:otherwise></xsl:choose>';
		}
        var minimalista    =  '<xsl:choose><xsl:when test="/Analizar/ANALISIS/MINIMALISTA">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
        var sinCategorias    =  '<xsl:choose><xsl:when test="/Analizar/ANALISIS/SINCATEGORIAS">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		var IDDivisa = '0';	
		var preDivisaDef = '<xsl:value-of select="/Analizar/ANALISIS/DIVISA/PREFIJO"/>';	
		var sufDivisaDef = '<xsl:value-of select="/Analizar/ANALISIS/DIVISA/SUFIJO"/>';	
		var preDivisa = '<xsl:value-of select="/Analizar/ANALISIS/DIVISA/PREFIJO"/>';	
		var sufDivisa = '<xsl:value-of select="/Analizar/ANALISIS/DIVISA/SUFIJO"/>';	
		var decimalesPrecio = '<xsl:value-of select="/Analizar/ANALISIS/DECIMALES_PRECIO"/>';	
		var decimalesTotal = '<xsl:value-of select="/Analizar/ANALISIS/DECIMALES_TOTAL"/>';	
		var ocultarRefProveedor	= '<xsl:choose><xsl:when test="/Analizar/ANALISIS/OCULTAR_REFERENCIA_PROVEEDOR">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		var saltarPedMinimo = '<xsl:value-of select="/Analizar/ANALISIS/SALTARPEDIDOMINIMO"/>';	
		var prodVisibles = '<xsl:value-of select="/Analizar/ANALISIS/PRODUCTOS_VISIBLES"/>';	
		var requiereCarga = '<xsl:value-of select="/Analizar/ANALISIS/REQUIERE_CARGA"/>';	
		var lineasPorPag = '<xsl:value-of select="/Analizar/ANALISIS/LINEASPORPAGINA"/>';	

	<xsl:choose>
	<xsl:when test="/Analizar/ANALISIS/MOSTRAR_PRECIO_REFERENCIA/@NuevoModeloNegocio != ''">
		var nuevoModeloNegocio = '<xsl:value-of select="/Analizar/ANALISIS/MOSTRAR_PRECIO_REFERENCIA/@NuevoModeloNegocio"/>';
	</xsl:when>
	<xsl:when test="/Analizar/ANALISIS/OCULTAR_PRECIO_REFERENCIA/@NuevoModeloNegocio != ''">
		var nuevoModeloNegocio = '<xsl:value-of select="/Analizar/ANALISIS/OCULTAR_PRECIO_REFERENCIA/@NuevoModeloNegocio"/>';
	</xsl:when>
	</xsl:choose>

	<xsl:choose>
	<xsl:when test="/Analizar/ANALISIS/MOSTRAR_PRECIO_REFERENCIA/@PedidoAntiguo != ''">
		var pedidoAntiguo = '<xsl:value-of select="/Analizar/ANALISIS/MOSTRAR_PRECIO_REFERENCIA/@PedidoAntiguo"/>';
	</xsl:when>
	<xsl:when test="/Analizar/ANALISIS/OCULTAR_PRECIO_REFERENCIA/@PedidoAntiguo != ''">
		var pedidoAntiguo = '<xsl:value-of select="/Analizar/ANALISIS/OCULTAR_PRECIO_REFERENCIA/@PedidoAntiguo"/>';
	</xsl:when>
	</xsl:choose>
	<xsl:text disable-output-escaping="yes"><![CDATA[

		var arrayProductosProveedoresLineas=new Array();
		var arrayProveedores=new Array();
		var arrayProveedoresConDiferenteSigno=new Array();
		var arrayCentros=new Array();
		var arrayLugaresEntrega=new Array();
		var arrayCentrosConsumo=new Array();
		var arrayLineasProductos=new Array();

	]]></xsl:text>

		<!-- Strings para idiomas -->
		var str_SinGrupo		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_grupo']/node()"/>';
		var str_SinSubfamilia		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_subfamilia']/node()"/>';
		var str_PedirOferta		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='pedir_oferta']/node()"/>';
		var str_Alternativa		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Alternativa']/node()"/>';
		var str_Ref			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Ref']/node()"/>';
		var str_Prod			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Prod']/node()"/>';
		var str_NoSePuedeEnviarPedido	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='no_se_puede_enviar_pedido']/node()"/>';
		var str_FechaLimiteRespuesta	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_limite_respuesta']/node()"/>';
		var str_LimiteComprasSuperado	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='limite_compras_mensual_superado']/node()"/>';
		var str_FechaCuotaCaducada	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_cuota_activa_caducada']/node()"/>';
		var str_CentroNoSeleccionado	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='centro_no_seleccionado']/node()"/>';
		var str_NoMezclarPackYNoPack = '<xsl:value-of select="document($doc)/translation/texts/item[@name='no_mezclar_packs']/node()"/>';
		var str_NoMezclarDivisas = '<xsl:value-of select="document($doc)/translation/texts/item[@name='no_mezclar_divisas']/node()"/>';
		var str_BonifCantCompra = '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cantidad_compra']/node()"/>';
		var str_BonifCantObs = '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cantidad_obsequiada']/node()"/>';
		var str_TipoDeCambioObligatorio = '<xsl:value-of select="document($doc)/translation/texts/item[@name='Informar_tipo_cambio']/node()"/>';
		var str_TipoDeCambio1 = '<xsl:value-of select="document($doc)/translation/texts/item[@name='Confirmar_tipo_cambio_1']/node()"/>';
		var str_NoMezclarReguladoYNoRegulado = '<xsl:value-of select="document($doc)/translation/texts/item[@name='no_mezclar_regulados']/node()"/>';
		var str_NoMezclarConvenioYNoConvenio = '<xsl:value-of select="document($doc)/translation/texts/item[@name='no_mezclar_convenio']/node()"/>';
		var str_NoMezclarDepositoYNoDeposito = '<xsl:value-of select="document($doc)/translation/texts/item[@name='no_mezclar_deposito']/node()"/>';

	<xsl:for-each select="/Analizar/ANALISIS/LINEAS/LINEA_ROW">
		var lineas			= [];
		lineas['LLP_ID']		= '<xsl:value-of select="LLP_ID"/>';
		lineas['DescripcionLinea']	= '<xsl:value-of select="LLP_DESCRIPCION_LINEA"/>';
		lineas['ReferenciaLinea']	= '<xsl:value-of select="PRODUCTOS/PRODUCTOS_ROW/REFERENCIACLIENTE"/><xsl:value-of select="PRODUCTOS/PRODUCTOS_ROW/REFERENCIAPRIVADA"/>';	//	1feb17
		lineas['ContieneFiltroTXT']	= 'S';
		lineas['ContieneSeleccion']	= 'S';
		lineas['Mostrar']		= 'S';

		<xsl:if test="PRODUCTOS/PRODUCTOS_ROW">
		lineas['Productos']	= new Array();
		<xsl:for-each select="PRODUCTOS/PRODUCTOS_ROW">
			var producto		= [];
			producto['PLL_ID']		= '<xsl:value-of select="PLL_ID"/>';
			producto['PedidoMinimo']= '<xsl:value-of select="PEDIDO_MINIMO"/>';
			producto['Nombre']		= '<xsl:value-of select="NOMBRE"/>';
			producto['IDProducto']	= '<xsl:value-of select="PRO_ID"/>';
			producto['Referencia']	= '<xsl:value-of select="PRO_REFERENCIA"/>';
			producto['RefPrivada']	= '<xsl:value-of select="REFERENCIAPRIVADA"/>';
			producto['RefCliente']	= '<xsl:value-of select="REFERENCIACLIENTE"/>';
			producto['Subfamilia']	= '<xsl:value-of select="SUBFAMILIA"/>';
			producto['Grupo']		= '<xsl:value-of select="GRUPO"/>';
			producto['NombrePrivado']	= '<xsl:value-of select="NOMBREPRIVADO"/>';
			producto['Marca']		= '<xsl:value-of select="MARCA"/>';
			producto['UdsXLote_SinFormato']	= '<xsl:value-of select="PRO_UNIDADESPORLOTE_SINFORMATO"/>';
			producto['UdsXLote']	= '<xsl:value-of select="PRO_UNIDADESPORLOTE"/>';
			producto['UdBasica']	= '<xsl:value-of select="PRO_UNIDADBASICA"/>';
			//producto['Categoria']	= '<xsl:value-of select="PRO_CATEGORIA"/>';
			producto['IDCategoria']	= '<xsl:value-of select="CP_CAT_ID"/>';
			producto['Categoria']	= '<xsl:value-of select="CP_CAT_NOMBRE"/>';
			producto['TipoIVA']		= '<xsl:value-of select="PLL_TIPOIVA"/>';
			producto['CosteTransporte']	= '<xsl:value-of select="COSTE_TRANSPORTE"/>';
			producto['IDProveedor']	= '<xsl:value-of select="IDPROVEEDOR"/>';
			producto['Proveedor']	= '<xsl:value-of select="PROVEEDOR"/>';
			producto['IDCentroProv']= '<xsl:value-of select="IDCENTROPROVEEDOR"/>';
			producto['CentroProv']	= '<xsl:value-of select="CENTROPROVEEDOR"/>';
			producto['Cantidad']	= '<xsl:value-of select="CANTIDAD"/>';
			producto['Cantidad_SinFormato']	= '<xsl:value-of select="CANTIDAD_SINFORMATO"/>';
			<!-- Precio proveedor -->
			producto['Tarifa_SinFormat']	= '<xsl:value-of select="TARIFA_SINFORMATO"/>';
			producto['Tarifa']		= '<xsl:value-of select="TARIFA"/>';
			<!-- Precio proveedor con IVA-->
			producto['TarifaIVA']	= '<xsl:value-of select="TARIFA_CONIVA"/>';
			producto['TarifaIVA_SinFormat']	= '<xsl:value-of select="TARIFA_CONIVA_SINFORMATO"/>';
			<!-- Precio historico -->
			producto['PrecioReferencia']	= '<xsl:value-of select="PRECIO_REFERENCIA"/>';

			producto['DivisaPrefijo']	= '<xsl:value-of select="DIV_PREFIJO"/>';
			producto['DivisaSufijo']	= '<xsl:value-of select="DIV_SUFIJO"/>';
			<!-- Importe del IVA -->
			producto['ImporteIVA']		= '<xsl:value-of select="IMPORTEIVA"/>';
			producto['ImporteIVA_SinFormat']= '<xsl:value-of select="IMPORTEIVA_SINFORMATO"/>';
			<!-- Comision MVM (siempre se incluye el IVA) -->
			producto['ComisionMVM']		= '<xsl:value-of select="COMISIONMVM_CONIVA"/>';
			producto['ComisionMVM_SinFormat']= '<xsl:value-of select="COMISIONMVM_CONIVA_SINFORMATO"/>';
            producto['IDImage']= '<xsl:value-of select="IMAGENES/IMAGEN/@id"/>';
            producto['Image']= '<xsl:value-of select="IMAGENES/IMAGEN/@peq"/>';

			producto['Regulado'] = '<xsl:choose><xsl:when test="REGULADO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
			producto['Pack'] = '<xsl:choose><xsl:when test="PACK">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
			producto['VariacionPrecio']	= '<xsl:choose><xsl:when test="CARO">Caro</xsl:when><xsl:when test="BARATO">Barato</xsl:when></xsl:choose>';
			producto['VariacionPrecioFinal']= '<xsl:choose><xsl:when test="PRECIOFINAL_CARO">Caro</xsl:when><xsl:when test="PRECIOFINAL_BARATO">Barato</xsl:when></xsl:choose>';

			producto['stringBuscador']	= '<xsl:value-of select="PRO_REFERENCIA"/>,<xsl:value-of select="REFERENCIAPRIVADA"/>,<xsl:value-of select="REFERENCIACLIENTE"/>,<xsl:value-of select="NOMBREPRIVADO"/>,<xsl:value-of select="MARCA"/>';
            producto['IDTipoNeg']= '<xsl:value-of select="IDTIPONEGOCIACION"/>';
			
			producto['Bonificado'] = '<xsl:choose><xsl:when test="BONIFICACION">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
			producto['CantBonif']= '<xsl:value-of select="BONIFICACION/TRF_BONIF_CANTIDADDECOMPRA"/>';
			producto['CantGratis']= '<xsl:value-of select="BONIFICACION/TRF_BONIF_CANTIDADGRATUITA"/>';
			producto['Orden']= '<xsl:value-of select="CP_PRO_ORDEN"/>';

			producto['Convenio'] = '<xsl:choose><xsl:when test="CONVENIO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
			producto['Deposito'] = '<xsl:choose><xsl:when test="DEPOSITO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';


			<!-- Variables para los filtros -->
			producto['Mostrar']		= 'S';
			producto['Seleccionado']	= 'N';

			<xsl:if test="TIPO_SIN_STOCK">
				producto['TipoSinStock']	= '<xsl:value-of select="TIPO_SIN_STOCK"/>';
				producto['TextSinStock']	= '<xsl:value-of select="TEXTO_SIN_STOCK"/>';
				producto['RefAlternativa']	= '<xsl:value-of select="REFERENCIAALTERNATIVA"/>';
				producto['DescAlternativa']	= '<xsl:value-of select="DESCRIPCIONALTERNATIVA"/>';
			</xsl:if>

			<xsl:choose>
			<xsl:when test="TARIFAANTERIOR">
				producto['TarAnt_Fecha']	= '<xsl:value-of select="TARIFAANTERIOR/FECHA"/>';
				producto['TarAnt_Importe']	= '<xsl:value-of select="TARIFAANTERIOR/TARIFA"/>';
				producto['TarAnt_ImporteSF']= '<xsl:value-of select="TARIFAANTERIOR/TARIFA_SINFORMATO"/>';
				producto['TarAnt_Cambio']= '<xsl:value-of select="TARIFAANTERIOR/CAMBIO"/>';
			</xsl:when>
			<xsl:otherwise>
				producto['TarAnt_Fecha']	= '';
				producto['TarAnt_Importe']	= '';
				producto['TarAnt_ImporteSF']= '';
				producto['TarAnt_Cambio']= '';
			</xsl:otherwise>
			</xsl:choose>

			<xsl:choose>
			<xsl:when test="DIVISA">
				producto['IDDivisa']	= '<xsl:value-of select="DIVISA/ID"/>';
				producto['Nombre']		= '<xsl:value-of select="DIVISA/NOMBRE"/>';
				producto['PrefijoDiv']	= '<xsl:value-of select="DIVISA/PREFIJO"/>';
				producto['SufijoDiv']	= '<xsl:value-of select="DIVISA/SUFIJO"/>';
			</xsl:when>
			<xsl:otherwise>
				producto['IDDivisa']	= '0';
				producto['Nombre']		= '';
				producto['PrefijoDiv']	= '';
				producto['SufijoDiv']	= '';
			</xsl:otherwise>
			</xsl:choose>
			lineas['Productos'].push(producto);
		</xsl:for-each>
		</xsl:if>

		arrayLineasProductos.push(lineas);
</xsl:for-each>

<xsl:for-each select="Analizar/ANALISIS/CABECERA/TODOSLUGARESENTREGA/CENTRO">
		arrayCentros[arrayCentros.length]=new Array(<xsl:value-of select="@ID"/>,
				'<xsl:value-of select="@nombre"/>',
				'<xsl:value-of select="PEDIDO_MINIMO/IMPORTE"/>',
				'<xsl:value-of select="COSTE_TRANSPORTE/IMPORTE"/>'
		);

	<xsl:for-each select="LUGARESENTREGA/LUGARENTREGA">
		arrayLugaresEntrega[arrayLugaresEntrega.length]=new Array(<xsl:value-of select="ID"/>,
				<xsl:value-of select="IDCENTRO"/>,
				'<xsl:value-of select="REFERENCIA"/>',
				'<xsl:value-of select="NOMBRE"/>',
				'<xsl:value-of select="DIRECCION"/>',
				'<xsl:value-of select="CPOSTAL"/>',
				'<xsl:value-of select="POBLACION"/>',
				'<xsl:value-of select="PROVINCIA"/>',
				'<xsl:value-of select="PORDEFECTO"/>',
				'<xsl:value-of select="../../PEDIDO_MINIMO/IMPORTE"/>',
				'<xsl:value-of select="PORDEFECTO_FARMACIA"/>'
		);
	</xsl:for-each>
</xsl:for-each>

<xsl:for-each select="Analizar/ANALISIS/CABECERA/TODOSCENTROSCONSUMO/CENTRO">
	<xsl:for-each select="CENTROSCONSUMO/CENTROCONSUMO">
		arrayCentrosConsumo[arrayCentrosConsumo.length]=new Array(<xsl:value-of select="ID"/>,
				<xsl:value-of select="IDCENTRO"/>,
				'<xsl:value-of select="REFERENCIA"/>',
				'<xsl:value-of select="NOMBRE_CORTO"/>',
				'<xsl:value-of select="PORDEFECTO"/>'
		);
	</xsl:for-each>
</xsl:for-each>

<xsl:for-each select="//Analizar/ANALISIS/LINEAS/LINEA_ROW">
		arrayProductosProveedoresLineas[arrayProductosProveedoresLineas.length]='<xsl:value-of select="PRODUCTOS/PRODUCTOS_ROW/PROVEEDOR" disable-output-escaping="yes"/>';
</xsl:for-each>

<xsl:text disable-output-escaping="yes"><![CDATA[

		for(var n=0;n<arrayProductosProveedoresLineas.length;n++){
			var proveedor=arrayProductosProveedoresLineas[n];
			var existe=0;

			for(var i=0;i<arrayProveedores.length && existe==0;i++){
				if(arrayProveedores[i][0]==proveedor){
					existe=1;
				}
			}

			if(existe==0)
				arrayProveedores[arrayProveedores.length]=new Array(proveedor,'');
		}

	//-->
	</script>
]]></xsl:text>

	<style type="text/css">
		.highlight{background-color:yellow;}
	</style>
</head>

<xsl:variable name="num_cols"><xsl:value-of select="count(//PRODUCTOS_ROW)"/></xsl:variable>

<!--<body class="gris">-->
<body>
<xsl:choose><!-- error -->
<xsl:when test="//xsql-error">
	<xsl:apply-templates select="//xsql-error"/>
</xsl:when>
<xsl:when test="//ERROR_USUARIOVENDEDOR_NOINFORMADO">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='preparacion_pedido']/node()"/></span>
			<!--
			<span class="CompletarTitulo">
				<xsl:choose>
				<xsl:when test="/Analizar/ANALISIS/LINEAS/LINEA_ROW[1]/PRODUCTOS/PRODUCTOS_ROW/CENTROPROVEEDOR != ''">
    				<xsl:value-of select="/Analizar/ANALISIS/LINEAS/LINEA_ROW[1]/PRODUCTOS/PRODUCTOS_ROW/CENTROPROVEEDOR"/>
    				<xsl:if test="/Analizar/ANALISIS/LINEAS/LINEA_ROW[1]/PRODUCTOS/PRODUCTOS_ROW/VENDEDOR != ''">
        				&nbsp;(<xsl:value-of select="/Analizar/ANALISIS/LINEAS/LINEA_ROW[1]/PRODUCTOS/PRODUCTOS_ROW/VENDEDOR"/>)
    				</xsl:if>
				</xsl:when>
				<xsl:otherwise><xsl:value-of select="LP_NOMBRE"/></xsl:otherwise>
				</xsl:choose>
			</span>
			-->
		</p>
		<p class="TituloPagina">
			<xsl:value-of select="/Analizar/ANALISIS/CABECERA/PROVEEDOR"/>
			<span class="CompletarTitulo" style="width:300px;">				
				<a class="btnNormal" href="javascript:window.print();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
				</a>&nbsp;
				<xsl:choose>
				<xsl:when test="(/Analizar/ANALISIS/PEDIDO_MINIMO/IMPORTE != '0' and /Analizar/ANALISIS/PEDIDO_MINIMO/IMPORTE != '')">
					<a class="btnDestacado" href="javascript:enviarPedido(document.forms['formBot'],document.forms,'LPAnalizarSave.xsql',{/Analizar/ANALISIS/PEDIDO_MINIMO/IMPORTE});" title="Continuar" id="botonContinuar"><xsl:value-of select="document($doc)/translation/texts/item[@name='continuar']/node()"/></a>
				</xsl:when>
				<xsl:otherwise>
					<a class="btnDestacado" href="javascript:Actua(document.forms['formBot'],document.forms,'LPAnalizarSave.xsql');" title="Continuar" id="botonContinuar"><xsl:value-of select="document($doc)/translation/texts/item[@name='continuar']/node()"/></a>
				</xsl:otherwise>
				</xsl:choose>
			</span>
		</p>
	</div>
	<BR/>	
	<BR/>	
	<BR/>	
	<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='Usuario_vendedor_no_informado']/node()"/></strong>
	
	
</xsl:when>
<xsl:when test="//SESION_CADUCADA">
	<xsl:apply-templates select="//SESION_CADUCADA"/>
</xsl:when>
<xsl:otherwise>
	<!--Avisamos de que hemos terminado la carga del frame.	heAcabado - tipo 1=Multioferta   tipo 0=Pedido directo-->
<!--
	<xsl:attribute name="onLoad">
		<xsl:if test="not(//CENTRALCOMPRAS) and not(//MULTICENTROS)">
			inicializarDesplegableCentrosConsumo(<xsl:value-of select="//Analizar/ANALISIS/CABECERA/LISTA/CENTRO/CEN_ID"/>);
		</xsl:if>
	</xsl:attribute>
-->
	<div id="spiffycalendar" class="text"></div>
	<script type="text/javascript">
		var calFechaEntrega = new ctlSpiffyCalendarBox("calFechaEntrega", "formBot", "FECHA_ENTREGA","btnDateFechaEntrega",calculaFechaCalendarios('<xsl:value-of select="/Analizar/ANALISIS/CABECERA/LISTA/LP_PLAZOENTREGA"/>'),scBTNMODE_CLASSIC,'ONCHANGE|actualizarPlazo(document.forms[\'formBot\'],\'ENTREGA\',new Date());#CHANGEDAY|actualizarPlazo(document.forms[\'formBot\'],\'ENTREGA\',new Date());');
	</script>

<!-- 29may15 - DC - La fecha de pago se calcula en el PL/SQL
	<script type="text/javascript">
		var calFechaPago = new ctlSpiffyCalendarBox("calFechaPago", "formBot", "FECHA_PAGO","btnDateFechaPago",calculaFechaCalendarios('<xsl:value-of select="/Analizar/ANALISIS/CABECERA/LISTA/PLAZOSPAGO/field/@current"/>'),scBTNMODE_CLASSIC,'ONCHANGE|actualizarPlazo(document.forms[\'formBot\'],\'PAGO\',new Date());#CHANGEDAY|actualizarPlazo(document.forms[\'formBot\'],\'PAGO\',new Date());');
	</script>
-->
	<!--Creamos un array con los productos y los precios-->
	<script type="text/javascript">
		crearArray('<xsl:value-of select="$num_cols"/>');
		<xsl:for-each select="Analizar/ANALISIS/LINEAS/LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW">
			anadirArray('<xsl:value-of select="PLL_ID"/>','<xsl:value-of select="TOTAL"/>');
		</xsl:for-each>
	</script>

	<xsl:variable name="OcultarPrecioReferencia"><xsl:value-of select="/Analizar/ANALISIS/OCULTAR_PRECIO_REFERENCIA/@Ocultar"/></xsl:variable>

	<xsl:apply-templates select="Analizar/ANALISIS/CABECERA/LISTA"/>

	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
	
	<xsl:apply-templates select="Analizar/ANALISIS/LINEAS">
			<xsl:with-param name="OcultarPrecioReferencia" select="$OcultarPrecioReferencia"/>
	</xsl:apply-templates>

        <!-- detalle de producto -->
	<div class="overlay-container">
		<div class="window-container zoomout">
			<p style="text-align:right;margin-bottom:5px;">
                <a href="javascript:showTabla(false);" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/cerrar.gif" /></a>
                <a href="javascript:showTabla(false);"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>
            </p>
			<table class="infoTable incidencias" id="detalleProd" cellspacing="5" style="border-collapse:none; border:2px solid #7d7d7d;" >
			<tbody>
            </tbody>
			</table>
		</div>
	</div>
	<!-- detalle de producto-->

</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="LISTA">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='preparacion_pedido']/node()"/></span>
			<!--
			<span class="CompletarTitulo">
				<!- -<xsl:value-of select="document($doc)/translation/texts/item[@name='preparacion_pedido_para']/node()"/>&nbsp;- ->
				<xsl:choose>
				<xsl:when test="/Analizar/ANALISIS/LINEAS/LINEA_ROW[1]/PRODUCTOS/PRODUCTOS_ROW/CENTROPROVEEDOR != ''">
    				<xsl:value-of select="/Analizar/ANALISIS/LINEAS/LINEA_ROW[1]/PRODUCTOS/PRODUCTOS_ROW/CENTROPROVEEDOR"/>
    				<xsl:if test="/Analizar/ANALISIS/LINEAS/LINEA_ROW[1]/PRODUCTOS/PRODUCTOS_ROW/VENDEDOR != ''">
        				&nbsp;(<xsl:value-of select="/Analizar/ANALISIS/LINEAS/LINEA_ROW[1]/PRODUCTOS/PRODUCTOS_ROW/VENDEDOR"/>)
    				</xsl:if>
				</xsl:when>
				<xsl:otherwise><xsl:value-of select="LP_NOMBRE"/></xsl:otherwise>
				</xsl:choose>
			</span>
			-->
		</p>
		<p class="TituloPagina">
   			<xsl:value-of select="/Analizar/ANALISIS/CABECERA/PROVEEDOR"/>
			<span id="spBotones" class="CompletarTitulo" style="width:800px;">
				<span id="spDivisa" style="display:none">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_cambio']/node()"/>&nbsp;<span type="text" class="noinput muypeq" id="NombreDiv">NNN</span>:&nbsp;<input type="text" style="width:70px;height:25px;" id="tipoCambioDiv"/>&nbsp;<span type="text" class="noinput muypeq" id="NombreDiv2">MMM</span>&nbsp;&nbsp;&nbsp;&nbsp;
				</span>
				<!--	Incluir los botones	-->
				<a class="btnNormal" href="javascript:ExportarExcel();">
					<img src="http://www.newco.dev.br/images/iconoExcel.gif"/>
				</a>&nbsp;
				<a class="btnNormal" href="javascript:window.print();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
				</a>&nbsp;
				<xsl:choose>
				<xsl:when test="/Analizar/ANALISIS/PEDIDO_MINIMO/IMPORTE != '0' and /Analizar/ANALISIS/PEDIDO_MINIMO/IMPORTE != ''">
					<a class="btnDestacado" href="javascript:enviarPedido(document.forms['formBot'],document.forms,'LPAnalizarSave.xsql',{/Analizar/ANALISIS/PEDIDO_MINIMO/IMPORTE});" title="Continuar" id="botonContinuar"><xsl:value-of select="document($doc)/translation/texts/item[@name='continuar']/node()"/></a>
				</xsl:when>
				<xsl:otherwise>
					<a class="btnDestacado" href="javascript:Actua(document.forms['formBot'],document.forms,'LPAnalizarSave.xsql');" title="Continuar" id="botonContinuar"><xsl:value-of select="document($doc)/translation/texts/item[@name='continuar']/node()"/></a>
				</xsl:otherwise>
				</xsl:choose>
			</span>
			<span id="spAvance" class="CompletarTitulo" style="width:300px;display:none;">				
			</span>
		</p>
	</div>

	<div class="divLeft">
		<br/>
		<!--<table class="infoTable" border="0">-->
		<table class="buscador" border="0">
			<form name="formBot" method="POST">
				<input type="hidden" name="LP_PLAZOENTREGA" value="{//Analizar/ANALISIS/CABECERA/LISTA/LP_PLAZOENTREGA}"/>
				<input type="hidden" name="COSTE_LOGISTICA"/>
				<input type="hidden" name="TIPOCAMBIODIVISA" id="TIPOCAMBIODIVISA" value="1"/>
				<!--<input type="hidden" name="SELECCIONTOTAL"/>-->
				<input type="hidden" name="LP_ID" id="LP_ID" value="{/Analizar/ANALISIS/LP_ID}"/>
				<input type="hidden" name="STRING_CANTIDADES"/>
				<input type="hidden" name="IDDIVISA" id="IDDIVISA" value="0"/>	<!--	13ene21	Recuperamos la divisa como parametro de la multioferta	-->

				<tr class="sinLinea">
					<td class="labelRight">
					<xsl:choose>
					<xsl:when test="//CENTRALCOMPRAS or //MULTICENTROS">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='centro_entrega']/node()"/>:&nbsp;
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='entregar_en']/node()"/>:&nbsp;
					</xsl:otherwise>
					</xsl:choose>
					</td>

					<td class="datosLeft diez">
					<xsl:attribute name="class">
						<xsl:choose>
						<xsl:when test="//CENTRALCOMPRAS or //MULTICENTROS">datosLeft quince</xsl:when>
						<xsl:otherwise>datosLeft zerouno</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>

					<xsl:choose>
					<xsl:when test="//CENTRALCOMPRAS or //MULTICENTROS">
						<input type="hidden" name="CENTROSVISIBLES" value="S"/>
						<select name="IDCENTRO" class="select200" style="width:400px;height:20px;font-size:15px;" onChange="inicializarDesplegableCentros(this.value);"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="hidden" name="CENTROSVISIBLES" value="N"/>
						<select name="IDCENTRO" class="select200" style="display:none;">
							<option value="{//Analizar/ANALISIS/CABECERA/LISTA/CENTRO/CEN_ID}" selected="selected"></option>
						</select>
					</xsl:otherwise>
					</xsl:choose>
					</td>

					<td class="datosLeft diez">
					<xsl:for-each select="//TODOSLUGARESENTREGA/CENTRO/LUGARESENTREGA">
						<select name="IDLUGARENTREGA_{@idCentro}" class="lugarEntrega" style="height:20px;font-size:15px;display:none;" onChange="ActualizarTextoLugarEntrega(this.value);">
						<xsl:for-each select="LUGARENTREGA">
							<option value="{ID}"><xsl:value-of select="NOMBRE"/></option>
						</xsl:for-each>
						</select>
					</xsl:for-each>
					<!--	ET 2dic16 se produce un problema al no mostrarse el desplegable de lugar de entrega		-->
					<input type="hidden" name="IDLUGARENTREGA"/>
					</td>

					<td class="labelRight">
                    	<xsl:if test="/Analizar/ANALISIS/MOSTRARCENTROSCONSUMO">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_consumo']/node()"/>:&nbsp;
                    	</xsl:if>
					</td>

					<td colspan="3" class="datosLeft">
						<select name="IDCENTROCONSUMO">
                    	<xsl:attribute name="style">
                    	 <xsl:choose>
                        	 <xsl:when test="/Analizar/ANALISIS/MOSTRARCENTROSCONSUMO">display:;</xsl:when>
                        	 <xsl:otherwise>display:none;</xsl:otherwise>
                    	</xsl:choose>
                    	</xsl:attribute>
                	</select>
					</td>
				</tr>

				<tr class="sinLinea">
					<td class="labelRight" valign="top">
						<p style="margin-top:10px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='entregar_en']/node()"/>:&nbsp;</p>
					</td>

					<td class="textLeft" colspan="2">
						<!--direccion-->
						<xsl:call-template name="direccion"><xsl:with-param name="path" select="CENTRO"/></xsl:call-template>
					</td>

					<td class="labelRight">
						<p style="margin-top:0px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='entrega']/node()"/>:&nbsp;</p>
					</td>

					<td class="datosLeft">
						<p style="width:80px; float:left; margin-top:5px;">
							<xsl:call-template name="desplegable">
								<!--<xsl:with-param name="path" select="/Analizar/field[@name='COMBO_ENTREGA']"/>-->
								<xsl:with-param name="path" select="/Analizar/ANALISIS/COMBO_ENTREGA/field"/>
								<xsl:with-param name="IDAct" select="/Analizar/ANALISIS/CABECERA/LISTA/LP_PLAZOENTREGA"/>
								<xsl:with-param name="onChange">calculaFecha('ENTREGA',this.options[this.selectedIndex].value);</xsl:with-param>
								<xsl:with-param name="valorMinimo" select="/Analizar/ANALISIS/CABECERA/LISTA/LP_PLAZOENTREGA"/>
								<!--<xsl:with-param name="claSel">peq</xsl:with-param>-->
								<xsl:with-param name="style">width:80px;</xsl:with-param>
							</xsl:call-template>
						</p>
						<p style="width:100px; float:left; font-size:13px;">
							<script type="text/javascript">
								calFechaEntrega.dateFormat="d/M/yyyy";
								calFechaEntrega.labelCalendario='fecha de entrega';
								if (saltarPedMinimo=='S')			//	4feb19
									calFechaEntrega.minDate=new Date(formatoFecha(calculaFechaCalendarios(1),'E','I'));
								else
									calFechaEntrega.minDate=new Date(formatoFecha(calculaFechaCalendarios('<xsl:value-of select="/Analizar/ANALISIS/CABECERA/LISTA/LP_PLAZOENTREGA"/>'),'E','I'));
								calFechaEntrega.writeControl();
							</script>
						</p>

						<input type="hidden" name="FECHA_DECISION" size="10" maxlength="10" value="{/Analizar/ANALISIS/CABECERA/LISTA/LP_FECHADECISION}"/>
						<input type="hidden" name="sum" size="14" readonly="readonly"/>
						<input type="hidden" name="sumBrasil" size="14" readonly="readonly"/>
						<input type="hidden" name="sumanumerica" size="14" readonly="readonly"/>
					</td>
				</tr>

				<tr style="height:5px;"><td colspan="5">&nbsp;</td></tr>

				<!--<tr class="sinLinea"  style="border-top:1px solid #396BAD;">-->
				<tr class="sinLinea">

					<!--  pedido minimo -->
					<xsl:choose>
					<!--19may21 <xsl:when test="/Analizar/ANALISIS/PEDIDO_MINIMO/ACTIVO!='N' and /Analizar/ANALISIS/PEDIDO_MINIMO/IMPORTE>0">-->
					<xsl:when test="/Analizar/ANALISIS/PEDIDO_MINIMO/ACTIVO!='N'">
						<td class="datosLeft" colspan="5">
							<span style="color:#000;font-family:Verdana;font-weight:bold;margin-left:10px;">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo_de']/node()"/>&nbsp;
								<xsl:value-of select="/Analizar/ANALISIS/DIVISA/PREFIJO"/>&nbsp;<input type="text" id="CEN_PEDIDOMINIMO" name="CEN_PEDIDOMINIMO" size="10" value="{/Analizar/ANALISIS/PEDIDO_MINIMO/IMPORTE_SINFORMATO}" class="noinput" style="text-align:left;width:55px; font-weight:bold; margin-bottom:3px;" onFocus="this.blur();"/>&nbsp;
								<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='euros']/node()"/>&nbsp;-->
								<xsl:value-of select="/Analizar/ANALISIS/DIVISA/SUFIJO"/>
							</span>

							<input type="hidden" id="CEN_TIPOPEDIDOMINIMO" name="CEN_TIPOPEDIDOMINIMO" size="30" value="{/Analizar/ANALISIS/PEDIDO_MINIMO/ACTIVO}"/>

							<xsl:if test="/Analizar/ANALISIS/PEDIDO_MINIMO/DETALLE != ''">
								<span class="font11">:&nbsp;<xsl:value-of select="/Analizar/ANALISIS/PEDIDO_MINIMO/DETALLE"/></span>
							</xsl:if>
							<!--TEXTO INSERTADO SOLO PARA EL PROVEEDOR PFIZER ID_EMPRESA 7096-->
							<xsl:if test="/Analizar/ANALISIS/PEDIDO_MINIMO/ACTIVO != 'E' and /Analizar/ANALISIS/PEDIDO_MINIMO/IDPROVEEDOR = '7096'">
								<br />
								<span class="font11" style="width:160px;float:left;">&nbsp;</span>
								<span class="font11">-&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo_no_estricto_expli']/node()"/>.</span>
							</xsl:if>
							<!--texto retraso-->
							<xsl:if test="RETRASO">
								<br />
								<span class="font11" style="width:160px;float:left;">&nbsp;</span>
								<span class="font11">
									<xsl:choose>
										<xsl:when test="RETRASO[@mensaje]='15'">
											<strong><xsl:copy-of select="document($doc)/translation/texts/item[@name='pedidos_desde_quince']/node()"/></strong>
										</xsl:when>
										<xsl:otherwise>
											<strong><xsl:copy-of select="document($doc)/translation/texts/item[@name='pedidos_desde_doce']/node()"/></strong>
										</xsl:otherwise>
									</xsl:choose>
								</span>
							</xsl:if>
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="datosLeft" colspan="5">
							<input type="hidden" id="CEN_PEDIDOMINIMO" name="CEN_PEDIDOMINIMO" size="30" value="0" class="noinput"  onFocus="this.blur();"/>
							<input type="hidden" id="CEN_TIPOPEDIDOMINIMO" name="CEN_TIPOPEDIDOMINIMO" size="30" value="{/Analizar/ANALISIS/PEDIDO_MINIMO/ACTIVO}" />

							<span style="color:#000;font-weight:bold;margin-left:10px;"><xsl:value-of select="/Analizar/ANALISIS/PEDIDO_MINIMO/PROVEEDOR" /> <xsl:value-of select="document($doc)/translation/texts/item[@name='no_requiere_pedido_minimo']/node()"/></span>

							<xsl:if test="RETRASO">
								<!--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-->
								<xsl:choose>
									<xsl:when test="RETRASO[@mensaje]='15'">
										<strong><xsl:copy-of select="document($doc)/translation/texts/item[@name='pedidos_desde_quince']/node()"/></strong>
									</xsl:when>
									<xsl:otherwise>
										<strong><xsl:copy-of select="document($doc)/translation/texts/item[@name='pedidos_desde_doce']/node()"/></strong>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:if>
						</td>
					</xsl:otherwise>
					</xsl:choose>
					<!--si pueden pedir muestras-->
					<xsl:if test="/Analizar/ANALISIS/BLOQUEARMUESTRASCLIENTE != 'S'">
					<td class="labelRight">
						<span class="camposObligatorios">*</span>&nbsp;
						<xsl:variable name="textAlert"><xsl:value-of select="document($doc)/translation/texts/item[@name='mensaje_solicitud_muestras_en_pedidos']/node()"/></xsl:variable>
						<a href="javascript:alert('{$textAlert}');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitar_muestras']/node()"/>
						</a>
					</td>
					</xsl:if>
				</tr>
			</form>
		</table>
	</div><!--fin de div divLeft-->
</xsl:template>

<xsl:template match="LINEAS">
	<xsl:param name="OcultarPrecioReferencia"/>

	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

<xsl:variable name="nuevoModeloNegocio">
	<xsl:choose>
	<xsl:when test="/Analizar/ANALISIS/MOSTRAR_PRECIO_REFERENCIA/@NuevoModeloNegocio != ''">
		<xsl:value-of select="/Analizar/ANALISIS/MOSTRAR_PRECIO_REFERENCIA/@NuevoModeloNegocio"/>
	</xsl:when>
	<xsl:when test="/Analizar/ANALISIS/OCULTAR_PRECIO_REFERENCIA/@NuevoModeloNegocio != ''">
		<xsl:value-of select="/Analizar/ANALISIS/OCULTAR_PRECIO_REFERENCIA/@NuevoModeloNegocio"/>
	</xsl:when>
	</xsl:choose>
</xsl:variable>

<xsl:variable name="pedidoAntiguo">
	<xsl:choose>
	<xsl:when test="/Analizar/ANALISIS/MOSTRAR_PRECIO_REFERENCIA/@PedidoAntiguo != ''">
		<xsl:value-of select="/Analizar/ANALISIS/MOSTRAR_PRECIO_REFERENCIA/@PedidoAntiguo"/>
	</xsl:when>
	<xsl:when test="/Analizar/ANALISIS/OCULTAR_PRECIO_REFERENCIA/@PedidoAntiguo != ''">
		<xsl:value-of select="/Analizar/ANALISIS/OCULTAR_PRECIO_REFERENCIA/@PedidoAntiguo"/>
	</xsl:when>
	</xsl:choose>
</xsl:variable>

<xsl:choose>
<!--ASISA Y BRASIL VIEJO MODELO PRECIO PROV SIN IVA-->
<xsl:when test="($nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N') or /Analizar/ANALISIS/IDPAIS = '55'"><!-- and not(/Analizar/ANALISIS/MOSTRAR_PRECIO_CON_IVA)-->
	<!--asisa brasil-->
	<xsl:call-template name="asisaBrasilTablaProd"/>
</xsl:when>
<!--VIAMED NUEVO VIEJO MODELO PERO VEO PRECIO PROV CON IVA-->
<!--<xsl:when test="$nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N' and /Analizar/ANALISIS/MOSTRAR_PRECIO_CON_IVA">
	<xsl:call-template name="viamedNuevoTablaProd"/>
</xsl:when>-->
<!--NUEVO MODELO VIEJO PEDIDO alicante...PRECIO CON IVA-->
<xsl:when test="$nuevoModeloNegocio = 'S' and $pedidoAntiguo = 'S'">
	<!--nuevo modelo viejo pedido vissum alicante-->
	<xsl:call-template name="nuevoModeloViejoPedidoTablaProd"/>
</xsl:when>
<!--NUEVO MODELO NUEVO PEDIDO - PARA VIAMED VIEJO, VENDRELL...VEO PRECIO FINAL-->
<xsl:when test="$nuevoModeloNegocio = 'S' and $pedidoAntiguo = 'N'">
	<!--vendrell viamed viejo gomosa-->
	<xsl:call-template name="nuevoModeloNuevoPedidoTablaProd"/>
</xsl:when>
</xsl:choose>

<br /><br />
</xsl:template>

<!--ASISA Y BRASIL VIEJO MODELO PRECIO PROV SIN IVA-->
<xsl:template name="asisaBrasilTablaProd">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
	<xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG" /></xsl:when>
	<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<!--ocultar precio ref-->
<xsl:variable name="OcultarPrecioReferencia"><xsl:value-of select="/Analizar/ANALISIS/OCULTAR_PRECIO_REFERENCIA/@Ocultar"/></xsl:variable>

	<!--inicio tabla productos-->
	<!--table class="encuesta" border="0">-->
	<table class="buscador" id="lineas">
	<thead>
		<!--<tr class="titulosNoAlto">-->
		<tr class="subTituloTabla">
			<!-- ref mvm + provee -->
			<th class="ocho" align="left">
			<xsl:choose>
			<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and /Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">
				&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_nacional']/node()"/>
			</xsl:when>
			<xsl:otherwise>
				<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>.-->
				&nbsp;<a href="javascript:ordenarProductos('REF');">
					<xsl:choose>
					<xsl:when test="/Analizar/ANALISIS/NOMBREREFCLIENTE">
						<xsl:value-of select="/Analizar/ANALISIS/NOMBREREFCLIENTE"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>
					</xsl:otherwise>
					</xsl:choose>
				</a>
			</xsl:otherwise>
			</xsl:choose>
			</th>
            <th class="dos">&nbsp;<!--image--></th>
			<!-- producto -->
			<th align="left" style="width:300px;">
				<a href="javascript:ordenarProductos('NOMBRE');"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a><br/>
				<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>-->
				<span style="padding-left:5px;">
				<input type="text" name="strFiltro" id="strFiltro" style="width:100px" size="15"/>&nbsp;
				<xsl:choose>
					<xsl:when  test="/Analizar/ANALISIS/IDTIPONEGOCIACION">
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="/Analizar/ANALISIS/IDTIPONEGOCIACION/field"/>
							<xsl:with-param name="onChange">aplicarFiltroCompleto();</xsl:with-param>
							<xsl:with-param name="style">width:150px;</xsl:with-param>
						</xsl:call-template>&nbsp;
					</xsl:when>
				 	<xsl:otherwise><input type="hidden" name="IDTIPONEGOCIACION" id="IDTIPONEGOCIACION" value=""/></xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="/Analizar/ANALISIS/IDFILTROCATEGORIA">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Analizar/ANALISIS/IDFILTROCATEGORIA/field"/>
						<xsl:with-param name="onChange">aplicarFiltroCompleto();</xsl:with-param>
						<xsl:with-param name="style">width:150px;</xsl:with-param>
					</xsl:call-template>
					</xsl:when>
				 	<xsl:otherwise><input type="hidden" name="IDFILTROCATEGORIA" id="IDFILTROCATEGORIA" value="-1"/></xsl:otherwise>
				 </xsl:choose>
				</span>
				&nbsp;<!--<a href="javascript:ordenarProductos();"><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_productos']/node()"/></a>-->
				<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='min_3_car']/node()"/>-->
			</th>

			<!-- ref provee-->
			<xsl:if test="not(/Analizar/ANALISIS/OCULTAR_REFERENCIA_PROVEEDOR)">
				<th class="center">
				<xsl:attribute name="class">
					<xsl:choose>
					<!--si es viamed5 ve ref.prov-->
					<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and not(/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR)">ocho</xsl:when>
					<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F'  and /Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">zerouno</xsl:when>
					<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'N'">ocho</xsl:when>
					</xsl:choose>
				</xsl:attribute>
				<xsl:choose>
				<!--si es farmacia no veo ref prov, solo si es viamed5 veo ref prov-->
				<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and not(/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR)">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>
				</xsl:when>
				<!--si no es viamed5 no veo ref prov-->
				<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F'  and /Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">
				</xsl:when>
				<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'N'">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>
				</xsl:when>
				</xsl:choose>
				</th>
			</xsl:if>

			<!--marca para todos 26/06/12-->
			<th>
			<xsl:attribute name="class">
				<xsl:choose>
				<xsl:when test="/Analizar/ANALISIS/SIN_MARCA">zerouno</xsl:when>
				<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and /Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">quince</xsl:when>
				<!--si es farmacia y viamed5 mas estrecho-->
				<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and not(/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR)">dies</xsl:when>
				<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'N'">ocho</xsl:when>
				</xsl:choose>
			</xsl:attribute>

			<xsl:choose>
			<xsl:when test="/Analizar/ANALISIS/SIN_MARCA"></xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>
			</xsl:otherwise>
			</xsl:choose>
			</th>

			<!-- ud base -->
			<th>
			<xsl:attribute name="class">
				<xsl:choose>
				<!--si es farmacia mas estrecho-->
				<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and not(/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR)">ocho</xsl:when>
				<xsl:otherwise>doce</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>

				<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>
			</th>

		<!-- precio ud base, solo viejo modelo -->
		<xsl:if test="$OcultarPrecioReferencia='N' or /Analizar/ANALISIS/IDPAIS = '55'">
			<!---<th class="cuatro">-->
			<th style="width:150px;">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_s_iva']/node()"/>
				(<xsl:value-of select="/Analizar/ANALISIS/DIVISA/PREFIJO"/><xsl:value-of select="/Analizar/ANALISIS/DIVISA/SUFIJO"/>)
			</th>
		</xsl:if>

			<!-- cantidad -->
			<th class="cinco">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='unidades']/node()"/>
			</th>

			<!-- lote -->
			<th class="dos">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='embalaje']/node()"/>
			</th>

		<!-- iva enseï¿½o solo para asisa-->
		<!--si es brasil no enseï¿½o iva-->
		<xsl:choose>
		<xsl:when test="/Analizar/ANALISIS/IDPAIS = '55'">
			<th class="zerouno">&nbsp;</th>
		</xsl:when>
		<xsl:otherwise>
			<th class="uno">
				&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/>
			</th>
		</xsl:otherwise>
		</xsl:choose>

			<!-- importe -->
			<th class="dos" align="right">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='importe_s_iva_2line']/node()"/>
				(<xsl:value-of select="/Analizar/ANALISIS/DIVISA/PREFIJO"/><xsl:value-of select="/Analizar/ANALISIS/DIVISA/SUFIJO"/>)
			</th>

			<!-- importe total linea-->
			<th class="uno">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='sel']/node()"/><br />
				<input type="checkbox" class="muypeq" name="SOLO_SELECCIONADOS" id="SOLO_SELECCIONADOS" onClick="mostrarSeleccionados(this);"/>
			</th>
		</tr>
	</thead>
	<!--fin de titulos-->

	<!-- Aqui se montan dinamicamente las lineas de productos para generar el pedido -->
	<tbody></tbody>

	<tfoot>
		<tr class="sinLinea">
			<td colspan="11">&nbsp;</td>
		</tr>

		<!--form sumaTotal + coste transporte brasil-->
		<form name="sumaTotal">
		<tr class="sinLinea">
			<td class="textLeft" colspan="6">
				<!--	27may17		-->
				<xsl:if test="not(/Analizar/ANALISIS/PEDIDO_DESDE_CATALOGO)">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='prod_form_cod_cant']/node()"/><br/>
				<textarea name="LISTA_REFPRODUCTO" id="LISTA_REFPRODUCTO" cols="50" rows="5"/>&nbsp;
				<a id="EnviarProductosPorRef" class="btnDestacado" href="javascript:IncluirProductosPorReferencia();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_referencia']/node()"/>
				</a>
				<div id="idEstadoEnvio" style="display:none;"/>
				</xsl:if>
				<!--	27may17		-->
			&nbsp;
			</td>
			<!--choose pais-->
			<xsl:choose>
			<!--si es brasil pongo subtotal-->
			<xsl:when test="/Analizar/ANALISIS/IDPAIS = '55'">
				<td class="textRight" colspan="2">
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='subtotal']/node()"/>:</strong>
				</td>
				<td colspan="2" class="textRight">
					<input type="text" class="noinput" name="sumaTotal" size="10" maxlength="12" style="text-align:right;" onFocus="this.blur();" value="0,00"/>
				</td>
			</xsl:when><!--fin si es brasil-->
			<!--si es espaï¿½a-->
			<xsl:otherwise>
				<td class="textRight" colspan="2">
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:</strong>
				</td>
				<td class="textRight" colspan="2">
					<input type="text" class="noinput" name="sumaTotal" size="10" maxlength="12" style="text-align:right;" onFocus="this.blur();" value="0,00"/>
				</td>

				<input type="hidden" class="noinput" name="sumaTotalBrasil" size="10" maxlength="12" style="text-align:right;" onFocus="this.blur();"/>
				<input type="hidden" class="noinput" name="COSTE_LOGISTICA" size="8" maxlength="12" style="text-align:right;" value="0"/>
			</xsl:otherwise>
			</xsl:choose><!--fin choose pais-->

			<td>&nbsp;</td>
		</tr>

		<!--coste de transporte + suma total brasil-->
		<xsl:if test="/Analizar/ANALISIS/IDPAIS = '55'">
			<tr class="sinLinea">
				<td colspan="6">&nbsp;</td>
				<td class="textRight" colspan="2">
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='coste_trasporte']/node()"/>:</strong>
				</td>
				<td colspan="2" class="textRight">
					<input type="text" class="noinput medio" name="COSTE_LOGISTICA" size="8" maxlength="12" style="text-align:right;" value="0,00"/>
				</td>
				<td>&nbsp;</td>
			</tr>

			<tr class="sinLinea">
				<td colspan="6"></td>
				<td class="textRight" colspan="2">
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:</strong>
				</td>
				<td colspan="2" class="textRight">
					<input type="text" class="noinput" name="sumaTotalBrasil" size="10" maxlength="12" style="text-align:right;" onFocus="this.blur();" value="0,00"/>
				</td>
				<td>&nbsp;</td>
			</tr>
		</xsl:if>
		</form>

		<tr><td colspan="11">&nbsp;</td></tr>

		<!-- Botones 
		<tr>
			<td colspan="7">
			<!- -solo para no asisa, no asisa = S => != N- ->
			<xsl:if test="$OcultarPrecioReferencia!='N'">
				<span class="font11">&nbsp;<img src="http://www.newco.dev.br/images/order_d_verde.gif"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_producto_bajado_desde_ultimo_pedido']/node()"/>.</span><br />
				<span class="font11">&nbsp;<img src="http://www.newco.dev.br/images/order_a_rojo.gif"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_producto_subido_desde_ultimo_pedido']/node()"/>.</span>
			</xsl:if>
			</td>

			<td colspan="4">
			<xsl:choose>
			<xsl:when test="/Analizar/ANALISIS/PEDIDO_MINIMO/IMPORTE != '0' and /Analizar/ANALISIS/PEDIDO_MINIMO/IMPORTE != ''">
				<div class="boton" id="divContinuar">
<!- - DC - Hacemos limpieza de la funcion enviarPedido
					<a href="javascript:enviarPedido(document.forms['formBot'],document.forms,'LPAnalizarSave.xsql',{/Analizar/ANALISIS/PEDIDO_MINIMO/IMPORTE});" title="Continuar" id="botonContinuar"><xsl:value-of select="document($doc)/translation/texts/item[@name='continuar']/node()"/></a>
- ->
					<a href="javascript:enviarPedido();" title="Continuar" id="botonContinuar"><xsl:value-of select="document($doc)/translation/texts/item[@name='continuar']/node()"/></a>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div class="boton" id="divContinuar">
<!- - DC - Hacemos limpieza de la funcion enviarPedido
					<a href="javascript:Actua(document.forms['formBot'],document.forms,'LPAnalizarSave.xsql');" title="Continuar" id="botonContinuar"><xsl:value-of select="document($doc)/translation/texts/item[@name='continuar']/node()"/></a>
- ->
					<a href="javascript:Actua();" title="Continuar" id="botonContinuar"><xsl:value-of select="document($doc)/translation/texts/item[@name='continuar']/node()"/></a>
				</div>
			</xsl:otherwise>
			</xsl:choose>
			</td>
		</tr>
		-->
	</tfoot>
	</table><!--fin de encuesta tabla-->
</xsl:template>

<!--VIAMED NUEVO VIEJO MODELO PERO VEO PRECIO PROV CON IVA-->
<xsl:template name="viamedNuevoTablaProd">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!--ocultar precio ref-->
	<xsl:variable name="OcultarPrecioReferencia"><xsl:value-of select="/Analizar/ANALISIS/OCULTAR_PRECIO_REFERENCIA/@Ocultar"/></xsl:variable>

	<!--inicio tabla productos-->
	<!--<table class="encuesta" border="0">-->
	<table class="buscador">
	<thead>
		<!--<tr class="titulosNoAlto">-->
		<tr class="subTituloTabla">
			<!-- ref mvm + provee -->
			<th class="cinco" align="left">
			<xsl:choose>
			<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and /Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">
				&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_nacional']/node()"/>
			</xsl:when>
			<xsl:otherwise>
				<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>.-->
				<xsl:choose>
				<xsl:when test="/Analizar/ANALISIS/NOMBREREFCLIENTE">
					<xsl:value-of select="/Analizar/ANALISIS/NOMBREREFCLIENTE"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>
				</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
			</xsl:choose>
			</th>
            <th class="dos">&nbsp;<!--image--></th>
			<!-- producto -->
			<th align="left">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>
				<span style="padding-left:5px;">
				<input type="text" name="strFiltro" id="strFiltro" style="width:100px" size="15"/>&nbsp;
				<xsl:choose>
					<xsl:when  test="/Analizar/ANALISIS/IDTIPONEGOCIACION">
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="/Analizar/ANALISIS/IDTIPONEGOCIACION/field"/>
							<xsl:with-param name="onChange">aplicarFiltroCompleto();</xsl:with-param>
							<xsl:with-param name="style">width:150px;</xsl:with-param>
						</xsl:call-template>&nbsp;
					</xsl:when>
				 	<xsl:otherwise><input type="hidden" name="IDTIPONEGOCIACION" id="IDTIPONEGOCIACION" value=""/></xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="/Analizar/ANALISIS/IDFILTROCATEGORIA">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Analizar/ANALISIS/IDFILTROCATEGORIA/field"/>
						<xsl:with-param name="onChange">aplicarFiltroCompleto();</xsl:with-param>
						<xsl:with-param name="style">width:150px;</xsl:with-param>
					</xsl:call-template>
					</xsl:when>
				 	<xsl:otherwise><input type="hidden" name="IDFILTROCATEGORIA" id="IDFILTROCATEGORIA" value="-1"/></xsl:otherwise>
				 </xsl:choose>
				</span>
			</th>

			<!-- ref provee-->
			<xsl:if test="not(/Analizar/ANALISIS/OCULTAR_REFERENCIA_PROVEEDOR)">
				<th class="center">
				<xsl:attribute name="class">
					<xsl:choose>
					<!--si es viamed5 ve ref.prov-->
					<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and not(/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR)">quince</xsl:when>
					<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F'  and /Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">zerouno</xsl:when>
					<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'N'">quince</xsl:when>
					</xsl:choose>
				</xsl:attribute>
				<xsl:choose>
				<!--si es farmacia no veo ref prov, solo si es viamed5 veo ref prov-->
				<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and not(/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR)">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>
				</xsl:when>
				<!--si no es viamed5 no veo ref prov-->
				<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F'  and /Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">
				</xsl:when>
				<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'N'">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>
				</xsl:when>
				</xsl:choose>
				</th>
			</xsl:if>

			<!--marca solo si es asisa, para todos 26/06/12-->
			<th>
			<xsl:attribute name="class">
				<xsl:choose>
				<xsl:when test="/Analizar/ANALISIS/SIN_MARCA">zerouno</xsl:when>
				<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and /Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">quince</xsl:when>
				<!--si es farmacia y viamed5 mas estrecho-->
				<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and not(/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR)">dies</xsl:when>
				<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'N'">ocho</xsl:when>
				</xsl:choose>
			</xsl:attribute>

			<xsl:choose>
			<xsl:when test="/Analizar/ANALISIS/SIN_MARCA"></xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>
			</xsl:otherwise>
			</xsl:choose>
			</th>

			<!-- ud base -->
			<th>
			<xsl:attribute name="class">
				<xsl:choose>
				<!--si es farmacia y viamed5 mas estrecho-->
				<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and not(/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR)">ocho</xsl:when>
				<xsl:otherwise>doce</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>

				<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>
			</th>

			<!-- precio ud base con IVA -->
			<th class="cuatro">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_c_iva']/node()"/>
				(<xsl:value-of select="/Analizar/ANALISIS/DIVISA/PREFIJO"/><xsl:value-of select="/Analizar/ANALISIS/DIVISA/SUFIJO"/>)
			</th>

			<!--flechas si precio ha bajado o subido solo para no asisa-->
			<th class="zerouno">&nbsp;</th>

			<!-- cantidad -->
			<th class="cinco">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='unidades']/node()"/>
			</th>

			<!-- lote -->
			<th class="dos">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='embalaje']/node()"/>
			</th>

			<!--iva-->
			<th class="uno">&nbsp;</th>

			<!-- importe con iva-->
			<th class="dos" align="right">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='importe_c_iva_2line']/node()"/>
				(<xsl:value-of select="/Analizar/ANALISIS/DIVISA/PREFIJO"/><xsl:value-of select="/Analizar/ANALISIS/DIVISA/SUFIJO"/>)
			</th>

			<!-- seleccionado -->
			<th class="uno">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='sel']/node()"/><br />
				<input type="checkbox" class="muypeq" name="SOLO_SELECCIONADOS" id="SOLO_SELECCIONADOS" onClick="mostrarSeleccionados(this);"/>
			</th>
		</tr>
	</thead>
	<!--fin de titulos-->

	<!-- Aqui se montan dinamicamente las lineas de productos para generar el pedido -->
	<tbody></tbody>

	<tfoot>
		<tr>
			<td>
				<xsl:attribute name="colspan">
					<xsl:choose>
					<xsl:when test="$OcultarPrecioReferencia='N'">15</xsl:when>
					<xsl:otherwise>12</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
			</td>
		</tr>

	<!--form sumaTotal + coste transporte brasil-->
	<form name="sumaTotal">
		<input type="hidden" name="sumaTotalBrasil"/>
		<input type="hidden" name="COSTE_LOGISTICA" value="0"/>

		<tr class="sinLinea">
			<td class="textLeft" colspan="8">
			<!--	27may17		-->
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='prod_form_cod_cant']/node()"/><br/>
				<textarea name="LISTA_REFPRODUCTO" id="LISTA_REFPRODUCTO" cols="50" rows="5"/>&nbsp;
				<a id="EnviarProductosPorRef" class="btnDestacado" href="javascript:IncluirProductosPorReferencia();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_referencia']/node()"/>
				</a>
				<div id="idEstadoEnvio" style="display:none;"/>
			<!--	27may17		-->
			&nbsp;
			&nbsp;
			</td>
			<!--subtotal-->
			<td class="textRight" colspan="2">
				<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:</strong>
			</td>
			<td class="textRight" colspan="2">
				<input type="text" class="noinput" name="sumaTotal" size="10" maxlength="12" style="text-align:right;" onFocus="this.blur();" value="0,00"/>
			</td>
			<td colspan="2">&nbsp;</td>
		</tr>
	</form>

		<tr class="sinLinea"><td colspan="13">&nbsp;</td></tr>

		<!-- Botones - ->
		<tr class="sinLinea">
			<td colspan="9">
			<xsl:if test="$OcultarPrecioReferencia='S'">
				<span class="font11">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='comision_mvm_iva']/node()"/></span><br />
			</xsl:if>

			<!- -solo para no asisa, no asisa = S => != N- ->
			<xsl:if test="$OcultarPrecioReferencia!='N'">
				<span class="font11">&nbsp;<img src="http://www.newco.dev.br/images/order_d_verde.gif"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_producto_bajado_desde_ultimo_pedido']/node()"/>.</span><br />
				<span class="font11">&nbsp;<img src="http://www.newco.dev.br/images/order_a_rojo.gif"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_producto_subido_desde_ultimo_pedido']/node()"/>.</span>
			</xsl:if>
			</td>

			<td colspan="3">
			<!- -
			<xsl:choose>
			<xsl:when test="/Analizar/ANALISIS/PEDIDO_MINIMO/IMPORTE != '0' and /Analizar/ANALISIS/PEDIDO_MINIMO/IMPORTE != ''">
				<div class="boton" id="divContinuar">
					<a href="javascript:enviarPedido(document.forms['formBot'],document.forms,'LPAnalizarSave.xsql',{/Analizar/ANALISIS/PEDIDO_MINIMO/IMPORTE});" title="Continuar" id="botonContinuar"><xsl:value-of select="document($doc)/translation/texts/item[@name='continuar']/node()"/></a>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div class="boton" id="divContinuar">
					<a href="javascript:Actua(document.forms['formBot'],document.forms,'LPAnalizarSave.xsql');" title="Continuar" id="botonContinuar"><xsl:value-of select="document($doc)/translation/texts/item[@name='continuar']/node()"/></a>
				</div>
			</xsl:otherwise>
			</xsl:choose>
			- ->&nbsp;
			</td>
			
			<td>&nbsp;</td>
		</tr>
		-->
	</tfoot>
	</table><!--fin de encuesta tabla-->
</xsl:template>

<!--VISSUM ALICANTE - NUEVO MODELO - VIEJO PEDIDO - VEO PRECIO CON IVA Y SIN IVA-->
<xsl:template name="nuevoModeloViejoPedidoTablaProd">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
	<xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG"/></xsl:when>
	<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<!--ocultar precio ref-->
<xsl:variable name="OcultarPrecioReferencia"><xsl:value-of select="/Analizar/ANALISIS/OCULTAR_PRECIO_REFERENCIA/@Ocultar"/></xsl:variable>

	<!--inicio tabla productos-->
	<!--<table class="encuesta" border="0">-->
	<table class="buscador" id="lineas">
	<thead>
		<!--<tr class="titulosNoAlto">-->
		<tr class="subTituloTabla">
			<!-- ref mvm + provee -->
			<th class="ocho" align="left">
			<xsl:choose>
			<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and /Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">
				&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_nacional']/node()"/>
			</xsl:when>
			<xsl:otherwise>
				<!--	1feb17	PruebasET	-->
				&nbsp;<a href="javascript:ordenarProductos('REF');">
					<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>-->
					<xsl:choose>
					<xsl:when test="/Analizar/ANALISIS/NOMBREREFCLIENTE">
						<xsl:value-of select="/Analizar/ANALISIS/NOMBREREFCLIENTE"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>
					</xsl:otherwise>
					</xsl:choose>
				</a>
			</xsl:otherwise>
			</xsl:choose>
			</th>
                        <th class="dos">&nbsp;<!--image--></th>
			<!-- producto -->
			<th align="left">
				<!--	1feb17	PruebasET	-->
				<a href="javascript:ordenarProductos('NOMBRE');"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a>
				<span style="padding-left:5px;">
				<input type="text" name="strFiltro" id="strFiltro" style="width:100px" size="15"/>&nbsp;
				<xsl:choose>
					<xsl:when  test="/Analizar/ANALISIS/IDTIPONEGOCIACION">
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="/Analizar/ANALISIS/IDTIPONEGOCIACION/field"/>
							<xsl:with-param name="onChange">aplicarFiltroCompleto();</xsl:with-param>
							<xsl:with-param name="style">width:150px;</xsl:with-param>
						</xsl:call-template>&nbsp;
					</xsl:when>
				 	<xsl:otherwise><input type="hidden" name="IDTIPONEGOCIACION" id="IDTIPONEGOCIACION" value=""/></xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="/Analizar/ANALISIS/IDFILTROCATEGORIA">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Analizar/ANALISIS/IDFILTROCATEGORIA/field"/>
						<xsl:with-param name="onChange">aplicarFiltroCompleto();</xsl:with-param>
						<xsl:with-param name="style">width:150px;</xsl:with-param>
					</xsl:call-template>
					</xsl:when>
				 	<xsl:otherwise><input type="hidden" name="IDFILTROCATEGORIA" id="IDFILTROCATEGORIA" value="-1"/></xsl:otherwise>
				 </xsl:choose>
				</span>
			</th>

			<xsl:if test="not(/Analizar/ANALISIS/OCULTAR_REFERENCIA_PROVEEDOR)">
				<!-- ref provee-->
				<th class="center">
					<xsl:attribute name="class">
						<xsl:choose>
						<!--si es viamed5 ve ref.prov-->
						<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and not(/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR)">ocho</xsl:when>
						<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F'  and /Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">zerouno</xsl:when>
						<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'N'">ocho</xsl:when>
						</xsl:choose>
					</xsl:attribute>
				<xsl:choose>
				<!--si es farmacia no veo ref prov-->
				<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F'"></xsl:when>
				<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'N'">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>
				</xsl:when>
				</xsl:choose>
				</th>
			</xsl:if>

			<th>
				<xsl:attribute name="class">
					<xsl:choose>
					<xsl:when test="/Analizar/ANALISIS/SIN_MARCA">zerouno</xsl:when>
					<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F'">quince</xsl:when>
					<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'N'">ocho</xsl:when>
					</xsl:choose>
				</xsl:attribute>

			<xsl:choose>
			<xsl:when test="/Analizar/ANALISIS/SIN_MARCA"></xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>
			</xsl:otherwise>
			</xsl:choose>
			</th>

			<!-- ud base -->
			<th>
				<xsl:attribute name="class">
					<xsl:choose>
					<!--si es farmacia y viamed5 mas estrecho-->
					<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and not(/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR)">ocho</xsl:when>
					<xsl:otherwise>doce</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>

				<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>
			</th>

			<!-- precio ud base sin IVA -->
			<th class="cuatro" style="width:100px;">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_s_iva']/node()"/>
			</th>

			<!-- precio ud base con IVA -->
			<th class="cuatro" style="width:100px;">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_c_iva']/node()"/>
			</th>

			<!--flechas si precio ha bajado o subido solo para no asisa-->
			<th class="zerouno">&nbsp;</th>

			<!-- cantidad -->
			<th class="cinco">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='unidades']/node()"/>
			</th>

			<!-- lote -->
			<th class="dos">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='embalaje']/node()"/>
			</th>

			<!-- importe total linea sin iva-->
			<th align="right" style="width:110px;">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='importe_s_iva_2line']/node()"/>
			</th>

			<!-- importe total linea con iva-->
			<th align="right" style="width:110px;">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='importe_c_iva_2line']/node()"/>
			</th>

			<!-- seleccionado -->
			<th class="uno">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='sel']/node()"/><br />
				<input type="checkbox" class="muypeq" name="SOLO_SELECCIONADOS" id="SOLO_SELECCIONADOS" onClick="mostrarSeleccionados(this);"/>
			</th>
		</tr>
	</thead>
	<!--fin de titulos-->

	<!-- Aqui se montan dinamicamente las lineas de productos para generar el pedido -->
	<tbody></tbody>

	<tfoot>
		<tr class="sinLinea">
			<td colspan="11">&nbsp;</td>
		</tr>

	<!--form sumaTotal-->
	<form name="sumaTotal">
		<input type="hidden" name="sumaTotalBrasil"/>
		<input type="hidden" name="COSTE_LOGISTICA" value="0"/>

		<tr class="sinLinea">
			<td class="textLeft" colspan="9">
			<!--	27may17		-->
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='prod_form_cod_cant']/node()"/><br/>
				<textarea name="LISTA_REFPRODUCTO" id="LISTA_REFPRODUCTO" cols="50" rows="5"/>&nbsp;
				<a id="EnviarProductosPorRef" class="btnDestacado" href="javascript:IncluirProductosPorReferencia();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_referencia']/node()"/>
				</a>
				<div id="idEstadoEnvio" style="display:none;"/>
			<!--	27may17		-->
			&nbsp;
			&nbsp;
			</td>
			<!--si es espaï¿½a-->
			<td class="textRight">
				<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:</strong>
			</td>
			<td class="textRight" colspan="2">
				<input type="text" class="noinput" name="sumaTotal" size="10" maxlength="12" style="text-align:right;" onFocus="this.blur();" value="0,00"/><!--<xsl:value-of select="/Analizar/ANALISIS/DIVISA/SUFIJO"/>-->
			</td>
			<td>&nbsp;</td>
		</tr>
	</form>

		<tr class="sinLinea">
			<td colspan="13">&nbsp;</td>
		</tr>

		<!-- Botones 
		<tr>
			<td colspan="10">
			<!- -solo para no asisa, no asisa = S => != N- ->
			<xsl:if test="$OcultarPrecioReferencia!='N'">
				<span class="font11">&nbsp;<img src="http://www.newco.dev.br/images/order_d_verde.gif"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_producto_bajado_desde_ultimo_pedido']/node()"/>.</span><br />
				<span class="font11">&nbsp;<img src="http://www.newco.dev.br/images/order_a_rojo.gif"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_producto_subido_desde_ultimo_pedido']/node()"/>.</span>
			</xsl:if>
			</td>

			<td colspan="3">
			<xsl:choose>
			<xsl:when test="/Analizar/ANALISIS/PEDIDO_MINIMO/IMPORTE != '0' and /Analizar/ANALISIS/PEDIDO_MINIMO/IMPORTE != ''">
				<div class="boton" id="divContinuar">
					<a href="javascript:enviarPedido(document.forms['formBot'],document.forms,'LPAnalizarSave.xsql',{/Analizar/ANALISIS/PEDIDO_MINIMO/IMPORTE});" title="Continuar" id="botonContinuar"><xsl:value-of select="document($doc)/translation/texts/item[@name='continuar']/node()"/></a>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div class="boton" id="divContinuar">
					<a href="javascript:Actua(document.forms['formBot'],document.forms,'LPAnalizarSave.xsql');" title="Continuar" id="botonContinuar"><xsl:value-of select="document($doc)/translation/texts/item[@name='continuar']/node()"/></a>
				</div>
			</xsl:otherwise>
			</xsl:choose>
			</td>
		</tr>
		-->
	</tfoot>
	</table><!--fin de encuesta tabla-->
</xsl:template>


<!--NUEVO MODELO - NUEVO PEDIDO - PARA VIAMED VIEJO, VENDRELL... VEO PRECIO FINAL -->
<xsl:template name="nuevoModeloNuevoPedidoTablaProd">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
	<xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG"/></xsl:when>
	<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<!--ocultar precio ref-->
<xsl:variable name="OcultarPrecioReferencia"><xsl:value-of select="/Analizar/ANALISIS/OCULTAR_PRECIO_REFERENCIA/@Ocultar"/></xsl:variable>

	<!--inicio tabla productos-->
	<!--<table class="encuesta" border="0">-->
	<table class="buscador" id="lineas">
	<thead>
		<!--tr class="titulosNoAlto">-->
		<tr class="subTituloTabla">
			<!-- ref mvm + provee -->
			<th class="ocho" align="left">
			<xsl:choose>
			<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and /Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR">
				&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_nacional']/node()"/>
			</xsl:when>
			<xsl:otherwise>
				<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>-->
				<xsl:choose>
				<xsl:when test="/Analizar/ANALISIS/NOMBREREFCLIENTE">
					<xsl:value-of select="/Analizar/ANALISIS/NOMBREREFCLIENTE"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>
				</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
			</xsl:choose>
			</th>
            <th class="dos">&nbsp;<!--image--></th>
			<!-- producto -->
			<th align="left">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>
				<span style="padding-left:5px;">
				<input type="text" name="strFiltro" id="strFiltro" style="width:100px" size="15"/>&nbsp;
				<xsl:choose>
					<xsl:when  test="/Analizar/ANALISIS/IDTIPONEGOCIACION">
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="/Analizar/ANALISIS/IDTIPONEGOCIACION/field"/>
							<xsl:with-param name="onChange">aplicarFiltroCompleto();</xsl:with-param>
							<xsl:with-param name="style">width:150px;</xsl:with-param>
						</xsl:call-template>&nbsp;
					</xsl:when>
				 	<xsl:otherwise><input type="hidden" name="IDTIPONEGOCIACION" id="IDTIPONEGOCIACION" value=""/></xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="/Analizar/ANALISIS/IDFILTROCATEGORIA">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Analizar/ANALISIS/IDFILTROCATEGORIA/field"/>
						<xsl:with-param name="onChange">aplicarFiltroCompleto();</xsl:with-param>
						<xsl:with-param name="style">width:150px;</xsl:with-param>
					</xsl:call-template>
					</xsl:when>
				 	<xsl:otherwise><input type="hidden" name="IDFILTROCATEGORIA" id="IDFILTROCATEGORIA" value="-1"/></xsl:otherwise>
				 </xsl:choose>
				</span>
			</th>

			<!-- ref provee-->
			<xsl:if test="not(/Analizar/ANALISIS/OCULTAR_REFERENCIA_PROVEEDOR)">
				<th class="center">
					<xsl:attribute name="class">
						<xsl:choose>
						<!--si es farmacia no veo ref prov-->
						<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F'">zerouno</xsl:when>
						<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'N'">ocho</xsl:when>
						</xsl:choose>
					</xsl:attribute>

				<xsl:choose>
				<!--si es farmacia no veo ref prov-->
				<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F'"></xsl:when>
				<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'N'">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>
				</xsl:when>
				</xsl:choose>
				</th>
			</xsl:if>

			<!--marca-->
			<th>
				<xsl:attribute name="class">
					<xsl:choose>
					<xsl:when test="/Analizar/ANALISIS/SIN_MARCA">zerouno</xsl:when>
					<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F'">veinte</xsl:when>
					<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'N'">ocho</xsl:when>
					</xsl:choose>
				</xsl:attribute>

			<xsl:choose>
			<xsl:when test="/Analizar/ANALISIS/SIN_MARCA"></xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>
			</xsl:otherwise>
			</xsl:choose>
			</th>

			<!-- ud base -->
			<th>
				<xsl:attribute name="class">
					<xsl:choose>
					<!--si es farmacia y viamed5 mas estrecho-->
					<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F' and not(/Analizar/ANALISIS/UTILIZAR_REFERENCIA_PROVEEDOR)">ocho</xsl:when>
					<xsl:otherwise>doce</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>

				<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>
			</th>

			<!-- precio ud base con IVA -->
			<th class="cinco">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_final_iva']/node()"/>
			</th>

			<!--flechas si precio ha bajado o subido -->
			<th class="zerouno">&nbsp;</th>

			<!-- cantidad -->
			<th class="cinco">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='unidades']/node()"/>
			</th>

			<!-- lote -->
			<th class="dos">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='embalaje']/node()"/>
			</th>

			<!-- importe total linea-->
			<th class="ocho" align="right">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='total']/node()"/>
			</th>

			<!-- seleccionado -->
			<th class="uno">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='sel']/node()"/><br />
				<input type="checkbox" class="muypeq" name="SOLO_SELECCIONADOS" id="SOLO_SELECCIONADOS" onClick="mostrarSeleccionados(this);"/>
			</th>
		</tr>

	</thead>
	<!--fin de titulos-->

	<!-- Aqui se montan dinamicamente las lineas de productos para generar el pedido -->
	<tbody></tbody>

	<tfoot>
		<tr>
			<td colspan="11">&nbsp;	</td>
		</tr>

	<!--form sumaTotal-->
	<form name="sumaTotal">
		<input type="hidden" name="sumaTotalBrasil"/>
		<input type="hidden" name="COSTE_LOGISTICA" value="0"/>

		<tr>
			<td class="textLeft" colspan="6">
			<!--	27may17		-->
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='prod_form_cod_cant']/node()"/><br/>
				<textarea name="LISTA_REFPRODUCTO" id="LISTA_REFPRODUCTO" cols="50" rows="5"/>&nbsp;
				<a id="EnviarProductosPorRef" class="btnDestacado" href="javascript:IncluirProductosPorReferencia();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_referencia']/node()"/>
				</a>
				<div id="idEstadoEnvio" style="display:none;"/>
			<!--	27may17		-->
			&nbsp;
			&nbsp;
			</td>
			<!--si es espaï¿½a-->
			<td class="textRight" colspan="2">
				<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:</strong>
			</td>
			<td class="textRight" colspan="2">
				<input type="text" class="noinput" name="sumaTotal" size="10" maxlength="12" style="text-align:right;" onFocus="this.blur();" value="0,00"/>
			</td>
			<td colspan="2">&nbsp;</td>
		</tr>
	</form>

		<tr>
			<td colspan="11">&nbsp;</td>
		</tr>

		<!-- Botones -->
		<tr>
			<td colspan="8">
			<xsl:if test="$OcultarPrecioReferencia='S'">
				<span class="font11">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='comision_mvm_iva']/node()"/></span><br />
			</xsl:if>

			<!--solo para no asisa, no asisa = S => != N-->
			<xsl:if test="$OcultarPrecioReferencia!='N'">
				<span class="font11">&nbsp;<img src="http://www.newco.dev.br/images/order_d_verde.gif"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_producto_bajado_desde_ultimo_pedido']/node()"/>.</span><br />
				<span class="font11">&nbsp;<img src="http://www.newco.dev.br/images/order_a_rojo.gif"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_producto_subido_desde_ultimo_pedido']/node()"/>.</span>
			</xsl:if>
			</td>

			<td colspan="3">
			<xsl:choose>
			<xsl:when test="/Analizar/ANALISIS/PEDIDO_MINIMO/IMPORTE != '0' and /Analizar/ANALISIS/PEDIDO_MINIMO/IMPORTE != ''">
				<div class="boton" id="divContinuar">
					<a href="javascript:enviarPedido(document.forms['formBot'],document.forms,'LPAnalizarSave.xsql',{/Analizar/ANALISIS/PEDIDO_MINIMO/IMPORTE});" title="Continuar" id="botonContinuar"><xsl:value-of select="document($doc)/translation/texts/item[@name='continuar']/node()"/></a>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div class="boton" id="divContinuar">
					<a href="javascript:Actua(document.forms['formBot'],document.forms,'LPAnalizarSave.xsql');" title="Continuar" id="botonContinuar"><xsl:value-of select="document($doc)/translation/texts/item[@name='continuar']/node()"/></a>
				</div>
			</xsl:otherwise>
			</xsl:choose>
			</td>
		</tr>
	</tfoot>
	</table><!--fin de encuesta tabla-->


</xsl:template>

<!--
<xsl:template match="PROVEEDOR">
   <i><a class="suave">
    <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="../IDPROVEEDOR"/>&amp;VENTANA=NUEVA','empresa',100,80,0,0)</xsl:attribute>
    <xsl:attribute name="onMouseOver">window.status='Informaciï¿½n sobre la empresa.';return true;</xsl:attribute>
    <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>

    <xsl:value-of select="."/>
   </a></i>
</xsl:template>
-->

<!-- DC - 28may15 - Si se usa -->
<!--<xsl:template name="hiddensPedido">
	<input type="hidden" name="SELECCIONTOTAL"/>
	<input type="hidden" name="LP_ID" value="{LP_ID}"/>
	<input type="hidden" name="STRING_CANTIDADES"/>
<!- -	<input type="hidden" name="IDDIVISA" value="0"/>- ->
<!- -	<input type="hidden" name="LP_IDFORMAPAGO"/>- ->
<!- -	<input type="hidden" name="LP_IDPLAZOPAGO"/>- ->
<!- -	<input type="hidden" name="LP_FORMAPAGO"/>- ->
</xsl:template>-->

<!-- DC - 28may15 - Si se usa -->
<xsl:template name="direccion">
<xsl:param name="path"/>

	<p class="textLeft">
		<input type="text" name="CEN_DIRECCION" size="50" value="{$path/CEN_DIRECCION}" style="text-align:left; margin-top:10px;" class="noinput muygrande" onFocus="this.blur();"/>
		<br />

	<!--spain-->
	<xsl:choose>
	<xsl:when test="/Analizar/ANALISIS/IDPAIS != '55'">
		<input type="text" name="CEN_CPOSTAL" size="4" value="{$path/CEN_CPOSTAL}" style="text-align:left;" class="noinput peq" onFocus="this.blur();"/>
	</xsl:when>
	<xsl:otherwise>
		<input type="text" name="CEN_CPOSTAL" size="10" value="{$path/CEN_CPOSTAL}" style="text-align:left;" class="noinput" onFocus="this.blur();"/>
	</xsl:otherwise>
	</xsl:choose>

		<xsl:text>-&nbsp;</xsl:text>
		<input type="text" name="CEN_POBLACION" size="20" value="{$path/CEN_POBLACION}" style="text-align:left;" class="noinput" onFocus="this.blur();"/>
		<input type="hidden" name="CEN_PROVINCIA" value="{$path/CEN_PROVINCIA}"/>
	</p>
</xsl:template>
<!-- fin templates de la nueva version -->
</xsl:stylesheet>
