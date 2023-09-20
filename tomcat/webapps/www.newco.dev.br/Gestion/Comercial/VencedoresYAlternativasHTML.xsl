<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Ficha con las ofertas seleccionadas, "Vencedores"	
	Ultima revision ET 20ene21 13:30 VencedoresYAlternativas_200121.js
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

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='VencedoresYAlternativas']/node()"/>:&nbsp;<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_TITULO"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>		<!-- Para descargas excel	-->
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/VencedoresYAlternativas_200121.js"></script>
	<script type="text/javascript">
	var strCabeceraExcelPrinc='<xsl:value-of select="document($doc)/translation/texts/item[@name='Cabecera_Princ_CSV_ofertasyalternativas']/node()"/>';
	var strCabeceraExcelAlt='<xsl:value-of select="document($doc)/translation/texts/item[@name='Cabecera_Alt_CSV_ofertasyalternativas']/node()"/>';
	var strCabeceraExcelJust='<xsl:value-of select="document($doc)/translation/texts/item[@name='Cabecera_Just_CSV_ofertasyalternativas']/node()"/>';
	<!--	Ofertas vencedoras y alternativas. Listado Excel		-->

	var numColumnas=0;
	var arrProveedores			= new Array();
	<xsl:for-each select="/OfertasSeleccionadas/LICITACION/PROVEEDORES/PROVEEDOR">
		var Proveedor			= [];
		
		Proveedor['ID']	= '<xsl:value-of select="IDPROVEEDOR"/>';
		Proveedor['IDCentro']	= '<xsl:value-of select="IDCENTRO"/>';					//	IMPORTANTE para multicentro
		Proveedor['IDProvLic']	= '<xsl:value-of select="IDPROVEEDOR_LIC"/>';
		Proveedor['Nombre']	= '<xsl:value-of select="NOMBRECORTO"/>';
		Proveedor['LicProvPedMin']	= '<xsl:value-of select="LIC_PROV_PEDIDOMINIMO"/>';
		Proveedor['Total']	= '<xsl:value-of select="LIC_PROV_CONSUMO"/>';
		Proveedor['IDMultioferta']	= '<xsl:value-of select="PEDIDOS/PEDIDO/MO_ID"/>';
		
		Proveedor['PedidoMinimo']	= '<xsl:value-of select="LIC_PROV_PEDIDOMINIMO"/>';
		Proveedor['PlazoPago']	= '<xsl:value-of select="PLAZOPAGO"/>';
		Proveedor['FormaPago']	= '<xsl:value-of select="FORMAPAGO"/>';
		Proveedor['PlazoEntrega']	= '<xsl:value-of select="LIC_PROV_PLAZOENTREGA"/>';
		Proveedor['Frete']	= '<xsl:value-of select="LIC_PROV_FRETE"/>';

		Proveedor['Productos']	= new Array();
		<xsl:for-each select="OFERTA">
			var producto		= [];
			producto['Contador']	= '<xsl:value-of select="CONTADOR"/>';
			producto['Nombre']		= '<xsl:value-of select="LIC_PROD_NOMBRE"/>';
			producto['IDProducto']	= '<xsl:value-of select="LIC_PROD_ID"/>';
			producto['IDProdEstandar']	= '<xsl:value-of select="LIC_PROD_IDPRODESTANDAR"/>';
			producto['Referencia']	= '<xsl:value-of select="PRO_REFERENCIA"/>';
			producto['Refestandar']	= '<xsl:value-of select="LIC_PROD_REFESTANDAR"/>';
			producto['RefCliente']	= '<xsl:value-of select="LIC_PROD_REFCLIENTE"/>';
			producto['UdsXLote']	= '<xsl:value-of select="LIC_OFE_UNIDADESPORLOTE"/>';
			producto['UdBasica']	= '<xsl:value-of select="LIC_PROD_UNIDADBASICA"/>';
			producto['MarcasAceptables']	= '<xsl:value-of select="LIC_PROD_MARCASACEPTABLES"/>';
			producto['Marca']	= '<xsl:value-of select="LIC_OFE_MARCA"/>';
			producto['PrecioRef']	= '<xsl:value-of select="LIC_PROD_PRECIOREFERENCIA"/>';

			producto['IDCentroProv']= '<xsl:value-of select="IDCENTROPROVEEDOR"/>';
			producto['CentroProv']	= '<xsl:value-of select="CENTROPROVEEDOR"/>';

			producto['Cantidad']	= '<xsl:value-of select="CANTIDAD"/>';
			producto['Tarifa']		= '<xsl:value-of select="LIC_OFE_PRECIO"/>';
			producto['TotalLinea']	= '<xsl:value-of select="CONSUMO"/>';
			producto['Ahorro']	= '<xsl:value-of select="LIC_OFE_AHORRO"/>';
			producto['Justificacion']	= '<xsl:value-of select="JUSTIFICACION"/>';
			
			producto['Ofertas']	= new Array();
			var oferta=[];
			<xsl:if test="OFERTA_1">
				if (numColumnas==0) numColumnas=1;
				oferta['ID'] = '<xsl:value-of select="OFERTA_1/LIC_OFE_ID"/>';
				oferta['Proveedor'] = '<xsl:value-of select="OFERTA_1/PROVEEDOR/NOMBRE"/>';
				oferta['Marca'] = '<xsl:value-of select="OFERTA_1/LIC_OFE_MARCA"/>';
				oferta['UdsXLote'] = '<xsl:value-of select="OFERTA_1/LIC_OFE_UNIDADESPORLOTE"/>';
				oferta['Precio'] = '<xsl:value-of select="OFERTA_1/LIC_OFE_PRECIO"/>';
				producto['Ofertas'].push(oferta);
			</xsl:if>
			var oferta=[];
			<xsl:if test="OFERTA_2">
				if (numColumnas&lt;2) numColumnas=2;
				oferta['ID'] = '<xsl:value-of select="OFERTA_2/LIC_OFE_ID"/>';
				oferta['Proveedor'] = '<xsl:value-of select="OFERTA_2/PROVEEDOR/NOMBRE"/>';
				oferta['Marca'] = '<xsl:value-of select="OFERTA_2/LIC_OFE_MARCA"/>';
				oferta['UdsXLote'] = '<xsl:value-of select="OFERTA_2/LIC_OFE_UNIDADESPORLOTE"/>';
				oferta['Precio'] = '<xsl:value-of select="OFERTA_2/LIC_OFE_PRECIO"/>';
				producto['Ofertas'].push(oferta);
			</xsl:if>
			var oferta=[];
			<xsl:if test="OFERTA_3">
				if (numColumnas&lt;3) numColumnas=3;
				oferta['ID'] = '<xsl:value-of select="OFERTA_3/LIC_OFE_ID"/>';
				oferta['Proveedor'] = '<xsl:value-of select="OFERTA_3/PROVEEDOR/NOMBRE"/>';
				oferta['Marca'] = '<xsl:value-of select="OFERTA_3/LIC_OFE_MARCA"/>';
				oferta['UdsXLote'] = '<xsl:value-of select="OFERTA_3/LIC_OFE_UNIDADESPORLOTE"/>';
				oferta['Precio'] = '<xsl:value-of select="OFERTA_3/LIC_OFE_PRECIO"/>';
				producto['Ofertas'].push(oferta);
			</xsl:if>
			var oferta=[];
			<xsl:if test="OFERTA_4">
				if (numColumnas&lt;4) numColumnas=4;
				oferta['ID'] = '<xsl:value-of select="OFERTA_4/LIC_OFE_ID"/>';
				oferta['Proveedor'] = '<xsl:value-of select="OFERTA_4/PROVEEDOR/NOMBRE"/>';
				oferta['Marca'] = '<xsl:value-of select="OFERTA_4/LIC_OFE_MARCA"/>';
				oferta['UdsXLote'] = '<xsl:value-of select="OFERTA_4/LIC_OFE_UNIDADESPORLOTE"/>';
				oferta['Precio'] = '<xsl:value-of select="OFERTA_4/LIC_OFE_PRECIO"/>';
				producto['Ofertas'].push(oferta);
			</xsl:if>
		
		Proveedor['Productos'].push(producto);
		</xsl:for-each>
		arrProveedores.push(Proveedor);
	</xsl:for-each>
	
	//	Cadenas para el CSV
	var strInforme='<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores_y_ofertas']/node()"/>';

	var strFechaInforme='<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_informe']/node()"/>';
	var FechaInforme='<xsl:value-of select="/OfertasSeleccionadas/LICITACION/FECHAACTUAL"/>';

	//var strEmpresa='<xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>';
	//var strEmpresaLic='<xsl:value-of select="/OfertasSeleccionadas/LICITACION/EMPRESA_MVM/NOMBRE"/>';

	var strTitulo='<xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>';
	var strTituloLic='<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_TITULO"/>';

	var strCodigo='<xsl:value-of select="document($doc)/translation/texts/item[@name='codigo']/node()"/>';
	var strCodigoLic='<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_CODIGO"/>';


	</script>
</head>
<body class="gris">
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

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>
		&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion']/node()"/>
		&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='VencedoresYAlternativas']/node()"/></span>
		
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
			<span class="CompletarTitulo" style="width:400px;">
				<!--
				<a class="btnNormal" style="text-decoration:none;">
					<xsl:attribute name="href">javascript:listadoExcel();</xsl:attribute>
					<img src="http://www.newco.dev.br/images/iconoExcel.gif">
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_excel']/node()"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_excel']/node()"/></xsl:attribute>
					</img>
				</a>
				&nbsp;
				-->
				<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/licOfertasSeleccionadas.xsql?LIC_ID={/OfertasSeleccionadas/LIC_ID}"><xsl:value-of select="document($doc)/translation/texts/item[@name='Vencedores']/node()"/></a>
				&nbsp;
				<a class="btnNormal" href="javascript:window.print();"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
				&nbsp;
				<a class="btnNormal" style="text-decoration:none;">
					<xsl:attribute name="href">javascript:DescargarExcel();</xsl:attribute>
					<img src="http://www.newco.dev.br/images/iconoExcel.gif">
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_excel']/node()"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_excel']/node()"/></xsl:attribute>
					</img>
				</a>
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
	<xsl:for-each select="/OfertasSeleccionadas/LICITACION/PROVEEDORES/PROVEEDOR">
	<!--<table class="infoTable">-->
	<table class="buscador">
	<thead>
		<tr class="subTituloTabla">
			<td colspan="6" align="center">
			</td>
			<td colspan="3" align="center" class="fondogris">
				<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDPROVEEDOR}&amp;ESTADO=CABECERA','Detalle Empresa',100,80,0,0);">
				<xsl:value-of select="NOMBRECORTO"/>
				</a>
			</td>
			<td colspan="4" align="center">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Alternativa']/node()"/>&nbsp;1
			</td>
			<td colspan="4" align="center" class="fondogris">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Alternativa']/node()"/>&nbsp;2
			</td>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/ALTERNATIVAS>2">
			<td colspan="4" align="center">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Alternativa']/node()"/>&nbsp;3
			</td>
			</xsl:if>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/ALTERNATIVAS>3">
			<td colspan="4" align="center" class="fondogris">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Alternativa']/node()"/>&nbsp;4
			</td>
			</xsl:if>
			<!--<td colspan="2">
				<!- -<xsl:value-of select="document($doc)/translation/texts/item[@name='Ultimo_pedido']/node()"/>- ->
				&nbsp;
			</td>-->
		</tr>
		<tr class="subTituloTabla">
			<td class="uno">&nbsp;</td>
			<td class="tres"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></strong></td>
			<td class="siete" style="text-align:left;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></strong></td>
			<td class="tres"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></strong></td>
			<td class="tres"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></strong></td>
			<td class="tres"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></strong></td>

			<td class="tres fondoGris"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/>(<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>)</strong></td>
			<td class="tres fondoGris"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='embalaje']/node()"/></strong></td>
			<td class="tres fondoGris"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='marcas']/node()"/></strong></td>

			<td class="siete"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></strong></td>
			<td class="tres"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/>(<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>)</strong></td>
			<td class="tres"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='embalaje']/node()"/></strong></td>
			<td class="tres"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></strong></td>

			<td class="siete fondoGris"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></strong></td>
			<td class="tres fondoGris"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/>(<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>)</strong></td>
			<td class="tres fondoGris"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='embalaje']/node()"/></strong></td>
			<td class="tres fondoGris"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></strong></td>

			<xsl:if test="/OfertasSeleccionadas/LICITACION/ALTERNATIVAS>2">
			<td class="siete"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></strong></td>
			<td class="tres"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/>(<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>)</strong></td>
			<td class="tres"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='embalaje']/node()"/></strong></td>
			<td class="tres"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></strong></td>
			</xsl:if>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/ALTERNATIVAS>3">
			<td class="siete fondoGris"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></strong></td>
			<td class="tres fondoGris"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/>(<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>)</strong></td>
			<td class="tres fondoGris"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='embalaje']/node()"/></strong></td>
			<td class="tres fondoGris"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></strong></td>
			</xsl:if>
			
			<!--<td class="tres"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></strong></td>
			<td class="siete"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></strong></td>
			<td class="tres"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/>(<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>)</strong></td>
			<td class="tres"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></strong></td>
			<td class="tres"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></strong></td>-->

			<td class="siete"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='justificacion']/node()"/></strong></td>

			<td class="uno">&nbsp;</td>
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
					<td><xsl:value-of select="CONTADOR"/></td>
					<td>
						<xsl:choose>
						<!-- para liciatciones no agregadas o si no está seleccionado un centro	-->
						<xsl:when test="LIC_PROD_REFCLIENTE != ''"><xsl:value-of select="LIC_PROD_REFCLIENTE"/></xsl:when>
						<xsl:otherwise><xsl:value-of select="LIC_PROD_REFESTANDAR"/></xsl:otherwise>
						</xsl:choose>
					</td>
					<td class="datosLeft">
						<a href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/OfertasSeleccionadas/LICITACION/LIC_ID}">
						<xsl:value-of select="LIC_PROD_NOMBRE"/></a>
					</td>
					<td><xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>
					<td><xsl:value-of select="LIC_PROD_MARCASACEPTABLES"/></td>

					<td class="datosRight fondoGris">
					<xsl:value-of select="LIC_OFE_PRECIO"/>
					</td>
					<td><strong><xsl:value-of select="LIC_OFE_CANTIDAD"/></strong></td>
					<td class="fondoGris"><xsl:value-of select="LIC_OFE_UNIDADESPORLOTE"/></td>
					<td class="fondoGris"><xsl:value-of select="LIC_OFE_MARCA"/></td>

					<td class="datosLeft">&nbsp;<xsl:value-of select="OFERTA_1/PROVEEDOR/NOMBRE"/></td>
					<td class="datosRight">
					<xsl:value-of select="OFERTA_1/LIC_OFE_PRECIO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
					</td>
					<td><xsl:value-of select="OFERTA_1/LIC_OFE_UNIDADESPORLOTE"/></td>
					<td><xsl:value-of select="OFERTA_1/LIC_OFE_MARCA"/></td>

					<td class="datosLeft fondoGris">&nbsp;<xsl:value-of select="OFERTA_2/PROVEEDOR/NOMBRE"/></td>
					<td class="datosRight fondoGris">
					<xsl:value-of select="OFERTA_2/LIC_OFE_PRECIO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
					</td>
					<td class="fondoGris"><xsl:value-of select="OFERTA_2/LIC_OFE_UNIDADESPORLOTE"/></td>
					<td class="fondoGris"><xsl:value-of select="OFERTA_2/LIC_OFE_MARCA"/></td>

					<!--<td><xsl:value-of select="ULTIMOPEDIDO/FECHA"/></td>
					<td class="datosLeft">&nbsp;<xsl:value-of select="ULTIMOPEDIDO/PROVEEDOR"/></td>
					<td class="datosRight">
					<xsl:value-of select="ULTIMOPEDIDO/PRECIO"/>
					</td>
					<td><xsl:value-of select="ULTIMOPEDIDO/CANTIDAD"/></td>
					<td><xsl:value-of select="ULTIMOPEDIDO/MARCA"/></td>-->
					
					<td>
						<xsl:value-of select="JUSTIFICACION"/>
						<xsl:if test="LIC_PROD_MOTIVOSELECCION!=''">:&nbsp;<xsl:value-of select="LIC_PROD_MOTIVOSELECCION"/></xsl:if>
					</td>

					<td>AQUI2&nbsp;</td>
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
				<td>
					<xsl:choose>
					<!-- para liciatciones no agregadas o si no está seleccionado un centro	-->
					<xsl:when test="LIC_PROD_REFCLIENTE != ''"><xsl:value-of select="LIC_PROD_REFCLIENTE"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="LIC_PROD_REFESTANDAR"/></xsl:otherwise>
					</xsl:choose>
				</td>
				<td class="datosLeft">
					<a href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/OfertasSeleccionadas/LICITACION/LIC_ID}">
					<xsl:value-of select="LIC_PROD_NOMBRE"/></a>
				</td>
				<td><xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>
				<td><xsl:value-of select="LIC_PROD_MARCASACEPTABLES"/></td>

				<!--	Oferta ganadora	-->
				<td><strong><xsl:value-of select="LIC_OFE_CANTIDAD"/></strong></td>
				<td class="datosRight fondoGris">
				<xsl:value-of select="LIC_OFE_PRECIO"/>
				</td>
				<td class="fondoGris"><xsl:value-of select="LIC_OFE_UNIDADESPORLOTE"/></td>
				<td class="fondoGris"><xsl:value-of select="LIC_OFE_MARCA"/></td>
			
				<!--	Alternativa 1	-->
				<td class="datosLeft">&nbsp;<xsl:value-of select="OFERTA_1/PROVEEDOR/NOMBRE"/></td>
				<td class="datosRight">
				<xsl:value-of select="OFERTA_1/LIC_OFE_PRECIO"/>
				</td>
				<td><xsl:value-of select="OFERTA_1/LIC_OFE_UNIDADESPORLOTE"/></td>
				<td><xsl:value-of select="OFERTA_1/LIC_OFE_MARCA"/></td>

				<!--	Alternativa 2	-->
				<td class="datosLeft fondoGris">&nbsp;<xsl:value-of select="OFERTA_2/PROVEEDOR/NOMBRE"/></td>
				<td class="datosRight fondoGris">
				<xsl:value-of select="OFERTA_2/LIC_OFE_PRECIO"/>
				</td>
				<td class="fondoGris"><xsl:value-of select="OFERTA_2/LIC_OFE_UNIDADESPORLOTE"/></td>
				<td class="fondoGris"><xsl:value-of select="OFERTA_2/LIC_OFE_MARCA"/></td>

				<!--	Alternativa 3	-->
				<xsl:if test="/OfertasSeleccionadas/LICITACION/ALTERNATIVAS>2">
					<td class="datosLeft fondoGris">&nbsp;<xsl:value-of select="OFERTA_3/PROVEEDOR/NOMBRE"/></td>
					<td class="datosRight fondoGris">
						<xsl:value-of select="OFERTA_3/LIC_OFE_PRECIO"/>
					</td>
					<td class="fondoGris"><xsl:value-of select="OFERTA_3/LIC_OFE_UNIDADESPORLOTE"/></td>
					<td class="fondoGris"><xsl:value-of select="OFERTA_3/LIC_OFE_MARCA"/></td>
				</xsl:if>
				<!--	Alternativa 4	-->
				<xsl:if test="/OfertasSeleccionadas/LICITACION/ALTERNATIVAS>3">
					<td class="datosLeft fondoGris">&nbsp;<xsl:value-of select="OFERTA_4/PROVEEDOR/NOMBRE"/></td>
					<td class="datosRight fondoGris">
						<xsl:value-of select="OFERTA_4/LIC_OFE_PRECIO"/>
					</td>
					<td class="fondoGris"><xsl:value-of select="OFERTA_4/LIC_OFE_UNIDADESPORLOTE"/></td>
					<td class="fondoGris"><xsl:value-of select="OFERTA_4/LIC_OFE_MARCA"/></td>
				</xsl:if>

				<!--	Último pedido	
				<td><xsl:value-of select="ULTIMOPEDIDO/FECHA"/></td>
				<td class="datosLeft">&nbsp;<xsl:value-of select="ULTIMOPEDIDO/PROVEEDOR"/></td>
				<td class="datosRight">
				<xsl:value-of select="ULTIMOPEDIDO/PRECIO"/>
				</td>
				<td><xsl:value-of select="ULTIMOPEDIDO/CANTIDAD"/></td>
				<td><xsl:value-of select="ULTIMOPEDIDO/MARCA"/></td>
				-->
				<td class="datosLeft">
					&nbsp;<xsl:value-of select="JUSTIFICACION"/>
					<xsl:if test="LIC_PROD_MOTIVOSELECCION!=''">:&nbsp;<xsl:value-of select="LIC_PROD_MOTIVOSELECCION"/></xsl:if>
				</td>

				<td>&nbsp;</td>
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
			<td class="dies"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/></strong></td>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34">
				<td class="cinco"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></strong></td>
			</xsl:if>
			<td class="dies"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></strong></td>
			<td class="dies"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></strong></td>
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
