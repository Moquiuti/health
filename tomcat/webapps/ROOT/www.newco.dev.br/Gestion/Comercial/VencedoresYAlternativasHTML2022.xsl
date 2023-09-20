<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Ficha con las ofertas seleccionadas, "Vencedores"	
	Ultima revision ET 31mar22 11:33 VencedoresYAlternativas2022_310322.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
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

	<!--	11ene22 nuevos estilos -->
	<!--<link rel="stylesheet" href="http://www.newco.dev.br/General/basicMVM2022.css"/>-->
	<link href='http://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'/>
	<!--	11ene22 nuevos estilos -->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>		<!-- Para descargas excel	-->
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/VencedoresYAlternativas2022_310322.js"></script>
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
		<!--<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>
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
		</p>-->
		<xsl:if test="/OfertasSeleccionadas/LICITACION/LIC_AGREGADA = 'S'">
			<p class="TituloPagina">
				&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/OfertasSeleccionadas/LICITACION/CENTROSCOMPRAS/field"/>
					<xsl:with-param name="onChange">javascript:document.forms[0].submit();</xsl:with-param>
					<xsl:with-param name="claSel">w300px;</xsl:with-param>
				</xsl:call-template>
			</p>
		</xsl:if>
		<p class="TituloPagina">
			<a id="botonLicitacion" href="javascript:AbrirLicitacion({/OfertasSeleccionadas/LICITACION/LIC_ID});"><xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_CODIGO"/>:&nbsp;<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_TITULO"/></a>
			<span class="CompletarTitulo500">
				<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/licOfertasSeleccionadas2022.xsql?LIC_ID={/OfertasSeleccionadas/LIC_ID}"><xsl:value-of select="document($doc)/translation/texts/item[@name='Vencedores']/node()"/></a>
				&nbsp;
				<a class="btnNormal" href="javascript:window.print();"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
				&nbsp;
				<a class="btnNormal" href="javascript:DescargarExcel()"><xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/></a>
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
	<form id="Proveedores" name="Proveedores" action="http://www.newco.dev.br/Gestion/Comercial/licOfertasSeleccionadas2022.xsql" method="POST">
	<input type="hidden" name="IDLicitacion" value="{/OfertasSeleccionadas/LICITACION/LIC_ID}"/>		<!--	para el JS	-->
	<input type="hidden" name="LIC_ID" value="{/OfertasSeleccionadas/LICITACION/LIC_ID}"/>				<!--	se utiliza en el XSQL		-->
	<input type="hidden" name="IDCentro" value="{/OfertasSeleccionadas/LICITACION/IDCENTRO}"/>
	<input type="hidden" name="ACCION" value=""/>
	<input type="hidden" name="PARAMETROS" value=""/>
	<xsl:for-each select="/OfertasSeleccionadas/LICITACION/PROVEEDORES/PROVEEDOR">
	<div class="tabela tabela_redonda">
	<table cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
		<tr>
			<th colspan="6" align="center">
			</th>
			<th colspan="3" align="center">
				<a href="javascript:FichaEmpresa('{IDPROVEEDOR}&amp;ESTADO=CABECERA');">
				<xsl:value-of select="NOMBRECORTO"/>
				</a>
			</th>
			<th colspan="4" align="center">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Alternativa']/node()"/>&nbsp;1
			</th>
			<th colspan="4" align="center" class="fondogris">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Alternativa']/node()"/>&nbsp;2
			</th>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/ALTERNATIVAS>2">
			<th colspan="4" align="center">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Alternativa']/node()"/>&nbsp;3
			</th>
			</xsl:if>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/ALTERNATIVAS>3">
			<th colspan="4" align="center" class="fondogris">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Alternativa']/node()"/>&nbsp;4
			</th>
			</xsl:if>
			<th class="w70px">&nbsp;</th><!-- Justificacion	-->
			<th class="w1px">&nbsp;</th>
		</tr>
		<tr class="subTituloTabla">
			<th class="w1px">&nbsp;</th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
			<th class="w70px" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>

			<th class="w50px fondoGris"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/>(<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>)</th>
			<th class="w50px fondoGris"><xsl:value-of select="document($doc)/translation/texts/item[@name='embalaje']/node()"/></th>
			<th class="w50px fondoGris"><xsl:value-of select="document($doc)/translation/texts/item[@name='marcas']/node()"/></th>

			<th class="w70px"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/>(<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>)</th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='embalaje']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></th>

			<th class="w70px fondoGris"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
			<th class="w50px fondoGris"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/>(<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>)</th>
			<th class="w50px fondoGris"><xsl:value-of select="document($doc)/translation/texts/item[@name='embalaje']/node()"/></th>
			<th class="w50px fondoGris"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></th>

			<xsl:if test="/OfertasSeleccionadas/LICITACION/ALTERNATIVAS>2">
			<th class="w70px"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/>(<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>)</th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='embalaje']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></th>
			</xsl:if>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/ALTERNATIVAS>3">
			<th class="w70px fondoGris"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
			<th class="w50px fondoGris"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/>(<xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>)</th>
			<th class="w50px fondoGris"><xsl:value-of select="document($doc)/translation/texts/item[@name='embalaje']/node()"/></th>
			<th class="w50px fondoGris"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></th>
			</xsl:if>
			<th class="w70px"><xsl:value-of select="document($doc)/translation/texts/item[@name='justificacion']/node()"/></th>
			<th class="w1px">&nbsp;</th>
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
					<td class="color_status"><xsl:value-of select="CONTADOR"/></td>
					<td>
						<xsl:choose>
						<!-- para liciatciones no agregadas o si no está seleccionado un centro	-->
						<xsl:when test="LIC_PROD_REFCLIENTE != ''"><xsl:value-of select="LIC_PROD_REFCLIENTE"/></xsl:when>
						<xsl:otherwise><xsl:value-of select="LIC_PROD_REFESTANDAR"/></xsl:otherwise>
						</xsl:choose>
					</td>
					<td class="textLeft">
						<a href="javascript:FichaProductoLicitacion({/OfertasSeleccionadas/LICITACION/LIC_ID},{LIC_PROD_ID});">
						<xsl:value-of select="LIC_PROD_NOMBRE"/></a>
					</td>
					<td><xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>
					<td><xsl:value-of select="LIC_PROD_MARCASACEPTABLES"/></td>

					<td class="textRight fondoGris">
					<xsl:value-of select="LIC_OFE_PRECIO"/>
					</td>
					<td><strong><xsl:value-of select="LIC_OFE_CANTIDAD"/></strong></td>
					<td class="fondoGris"><xsl:value-of select="LIC_OFE_UNIDADESPORLOTE"/></td>
					<td class="fondoGris"><xsl:value-of select="LIC_OFE_MARCA"/></td>

					<td class="textLeft">&nbsp;<xsl:value-of select="OFERTA_1/PROVEEDOR/NOMBRE"/></td>
					<td class="textRight">
					<xsl:value-of select="OFERTA_1/LIC_OFE_PRECIO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
					</td>
					<td><xsl:value-of select="OFERTA_1/LIC_OFE_UNIDADESPORLOTE"/></td>
					<td><xsl:value-of select="OFERTA_1/LIC_OFE_MARCA"/></td>

					<td class="textLeft fondoGris">&nbsp;<xsl:value-of select="OFERTA_2/PROVEEDOR/NOMBRE"/></td>
					<td class="textRight fondoGris">
					<xsl:value-of select="OFERTA_2/LIC_OFE_PRECIO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
					</td>
					<td class="fondoGris"><xsl:value-of select="OFERTA_2/LIC_OFE_UNIDADESPORLOTE"/></td>
					<td class="fondoGris"><xsl:value-of select="OFERTA_2/LIC_OFE_MARCA"/></td>

					<!--<td><xsl:value-of select="ULTIMOPEDIDO/FECHA"/></td>
					<td class="textLeft">&nbsp;<xsl:value-of select="ULTIMOPEDIDO/PROVEEDOR"/></td>
					<td class="textRight">
					<xsl:value-of select="ULTIMOPEDIDO/PRECIO"/>
					</td>
					<td><xsl:value-of select="ULTIMOPEDIDO/CANTIDAD"/></td>
					<td><xsl:value-of select="ULTIMOPEDIDO/MARCA"/></td>-->
					
					<td class="textLeft">
						<xsl:value-of select="JUSTIFICACION"/>
						<xsl:if test="LIC_PROD_MOTIVOSELECCION!=''">:&nbsp;<xsl:value-of select="LIC_PROD_MOTIVOSELECCION"/></xsl:if>
					</td>

					<td class="color_status">&nbsp;</td>
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
				<td class="color_status"><xsl:value-of select="CONTADOR"/></td>
				<td>
					<xsl:choose>
					<!-- para liciatciones no agregadas o si no está seleccionado un centro	-->
					<xsl:when test="LIC_PROD_REFCLIENTE != ''"><xsl:value-of select="LIC_PROD_REFCLIENTE"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="LIC_PROD_REFESTANDAR"/></xsl:otherwise>
					</xsl:choose>
				</td>
				<td class="textLeft">
					<a href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/OfertasSeleccionadas/LICITACION/LIC_ID}">
					<xsl:value-of select="LIC_PROD_NOMBRE"/></a>
				</td>
				<td><xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>
				<td><xsl:value-of select="LIC_PROD_MARCASACEPTABLES"/></td>

				<!--	Oferta ganadora	-->
				<td><strong><xsl:value-of select="LIC_OFE_CANTIDAD"/></strong></td>
				<td class="textRight fondoGris">
				<xsl:value-of select="LIC_OFE_PRECIO"/>
				</td>
				<td class="fondoGris"><xsl:value-of select="LIC_OFE_UNIDADESPORLOTE"/></td>
				<td class="fondoGris"><xsl:value-of select="LIC_OFE_MARCA"/></td>
			
				<!--	Alternativa 1	-->
				<td class="textLeft">&nbsp;<xsl:value-of select="OFERTA_1/PROVEEDOR/NOMBRE"/></td>
				<td class="textRight">
				<xsl:value-of select="OFERTA_1/LIC_OFE_PRECIO"/>
				</td>
				<td><xsl:value-of select="OFERTA_1/LIC_OFE_UNIDADESPORLOTE"/></td>
				<td><xsl:value-of select="OFERTA_1/LIC_OFE_MARCA"/></td>

				<!--	Alternativa 2	-->
				<td class="textLeft fondoGris">&nbsp;<xsl:value-of select="OFERTA_2/PROVEEDOR/NOMBRE"/></td>
				<td class="textRight fondoGris">
				<xsl:value-of select="OFERTA_2/LIC_OFE_PRECIO"/>
				</td>
				<td class="fondoGris"><xsl:value-of select="OFERTA_2/LIC_OFE_UNIDADESPORLOTE"/></td>
				<td class="fondoGris"><xsl:value-of select="OFERTA_2/LIC_OFE_MARCA"/></td>

				<!--	Alternativa 3	-->
				<xsl:if test="/OfertasSeleccionadas/LICITACION/ALTERNATIVAS>2">
					<td class="textLeft fondoGris">&nbsp;<xsl:value-of select="OFERTA_3/PROVEEDOR/NOMBRE"/></td>
					<td class="textRight fondoGris">
						<xsl:value-of select="OFERTA_3/LIC_OFE_PRECIO"/>
					</td>
					<td class="fondoGris"><xsl:value-of select="OFERTA_3/LIC_OFE_UNIDADESPORLOTE"/></td>
					<td class="fondoGris"><xsl:value-of select="OFERTA_3/LIC_OFE_MARCA"/></td>
				</xsl:if>
				<!--	Alternativa 4	-->
				<xsl:if test="/OfertasSeleccionadas/LICITACION/ALTERNATIVAS>3">
					<td class="textLeft fondoGris">&nbsp;<xsl:value-of select="OFERTA_4/PROVEEDOR/NOMBRE"/></td>
					<td class="textRight fondoGris">
						<xsl:value-of select="OFERTA_4/LIC_OFE_PRECIO"/>
					</td>
					<td class="fondoGris"><xsl:value-of select="OFERTA_4/LIC_OFE_UNIDADESPORLOTE"/></td>
					<td class="fondoGris"><xsl:value-of select="OFERTA_4/LIC_OFE_MARCA"/></td>
				</xsl:if>

				<!--	Último pedido	
				<td><xsl:value-of select="ULTIMOPEDIDO/FECHA"/></td>
				<td class="textLeft">&nbsp;<xsl:value-of select="ULTIMOPEDIDO/PROVEEDOR"/></td>
				<td class="textRight">
				<xsl:value-of select="ULTIMOPEDIDO/PRECIO"/>
				</td>
				<td><xsl:value-of select="ULTIMOPEDIDO/CANTIDAD"/></td>
				<td><xsl:value-of select="ULTIMOPEDIDO/MARCA"/></td>
				-->
				<td class="textLeft fondoGrisClaro">
					&nbsp;<xsl:value-of select="JUSTIFICACION"/>
					<xsl:if test="LIC_PROD_MOTIVOSELECCION!=''">:&nbsp;<xsl:value-of select="LIC_PROD_MOTIVOSELECCION"/></xsl:if>
				</td>

				<td class="color_status">&nbsp;</td>
			</tr>
		</xsl:for-each>
	</xsl:otherwise>
	</xsl:choose>
	</tbody>
	<tfoot class="rodape_tabela">
		<tr>
			<td>
				<xsl:attribute name="colspan">
					<xsl:choose>
					<xsl:when test="/OfertasSeleccionadas/LICITACION/ALTERNATIVAS=3">23</xsl:when>
					<xsl:when test="/OfertasSeleccionadas/LICITACION/ALTERNATIVAS=4">27</xsl:when>
					<xsl:otherwise>19</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				&nbsp;
			</td>
		</tr>
	</tfoot>
	</table>
	</div>
	<br/>
	<br/>
	</xsl:for-each>
	<xsl:if test="/OfertasSeleccionadas/LICITACION/PRODUCTOS_SIN_OFERTA/PRODUCTO">
	<br/>
	<br/>
    <div class="divLeft textCenter marginTop50">
		<span class="tituloTabla"><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_no_seleccionados']/node()"/></span>
	</div>
	<div class="tabela tabela_redonda">
	<table cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
		<tr class="gris">
			<th class="w1px">&nbsp;</th>
			<th class="w70px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
			<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
			<th class="w150px"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></th>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/></th>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34">
				<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></th>
			</xsl:if>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></th>
			<th class="w1px">&nbsp;</th>
		</tr>
	</thead>
	<tbody>
	<xsl:for-each select="/OfertasSeleccionadas/LICITACION/PRODUCTOS_SIN_OFERTA/PRODUCTO">
		<tr class="conhover">
			<td class="color_status"><xsl:value-of select="CONTADOR"/></td>
			<td><xsl:value-of select="REFERENCIA"/></td>
			<td class="textLeft">
				<a href="javascript:chFichaProductoLicitacion({/OfertasSeleccionadas/LICITACION/LIC_ID},{LIC_PROD_ID});"><xsl:value-of select="LIC_PROD_NOMBRE"/></a>
			</td>
			<td><xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>
			<td class="textRight">
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 55 and LIC_PROD_PRECIO>0">R$&nbsp;</xsl:if>
			<xsl:value-of select="LIC_PROD_PRECIO"/>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34 and LIC_PROD_PRECIO>0">&nbsp;&#128;</xsl:if>&nbsp;
			</td>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34">
				<td><xsl:value-of select="LIC_PROD_TIPOIVA"/>%</td>
			</xsl:if>
			<td class="textRight"><xsl:value-of select="LIC_PROD_CANTIDAD"/></td>&nbsp;
			<td class="textRight">
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 55 and LIC_PROD_CONSUMO>0">R$&nbsp;</xsl:if>
			<xsl:value-of select="LIC_PROD_CONSUMO"/>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34 and LIC_PROD_CONSUMO>0">&nbsp;&#128;</xsl:if>&nbsp;
			</td>
			<td>&nbsp;</td>
		</tr>
	</xsl:for-each>
	</tbody>
	<tfoot class="rodape_tabela">
		<tr><td colspan="9">&nbsp;</td></tr>
	</tfoot>
	</table>
	</div>
	</xsl:if>
	<xsl:if test="/OfertasSeleccionadas/LICITACION/PRODUCTOS_SIN_OFERTA/PRODUCTO">
    <div class="divLeft textCenter marginTop50">
		<span class="tituloTabla"><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_no_seleccionados']/node()"/></span>
	</div>
	<div class="tabela tabela_redonda">
	<table cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
		<tr>
			<th class="w1px">&nbsp;</th>
			<th class="w80px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
			<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></th>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/></th>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34">
				<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></th>
			</xsl:if>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></th>
			<th>&nbsp;</th>
		</tr>
	</thead>
	<tbody class="corpo_tabela">
	<xsl:for-each select="/OfertasSeleccionadas/LICITACION/PRODUCTOS_SIN_OFERTA/PRODUCTO">
		<tr class="conhover">
			<td class="color_status"><xsl:value-of select="CONTADOR"/></td>
			<td><xsl:value-of select="REFERENCIA"/></td>
			<td class="textLeft">
				<a href="javascript:chFichaProductoLicitacion({/OfertasSeleccionadas/LICITACION/LIC_ID},{LIC_PROD_ID});"><xsl:value-of select="LIC_PROD_NOMBRE"/></a>
			</td>
			<td><xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>
			<td class="textRight">
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 55 and LIC_PROD_PRECIO>0">R$&nbsp;</xsl:if>
			<xsl:value-of select="LIC_PROD_PRECIO"/>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34 and LIC_PROD_PRECIO>0">&nbsp;&#128;</xsl:if>&nbsp;
			</td>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34">
				<td><xsl:value-of select="LIC_PROD_TIPOIVA"/>%</td>
			</xsl:if>
			<td class="textRight"><xsl:value-of select="LIC_PROD_CANTIDAD"/></td>&nbsp;
			<td class="textRight">
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 55 and LIC_PROD_CONSUMO>0">R$&nbsp;</xsl:if>
			<xsl:value-of select="LIC_PROD_CONSUMO"/>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34 and LIC_PROD_CONSUMO>0">&nbsp;&#128;</xsl:if>&nbsp;
			</td>
			<td>&nbsp;</td>
		</tr>
	</xsl:for-each>
	</tbody>
	<tfoot class="rodape_tabela">
		<tr><td colspan="9">&nbsp;</td></tr>
	</tfoot>
	</table>
	</div>
	</xsl:if>
	<xsl:if test="/OfertasSeleccionadas/LICITACION/PRODUCTOS_JUSTIFICADOS/PRODUCTO">
    <div class="divLeft textCenter marginTop50">
		<span class="tituloTabla"><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_con_justificacion']/node()"/></span>
	</div>
	<div class="tabela tabela_redonda">
	<table cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
		<tr>
			<th class="w1px">&nbsp;</th>
			<th class="w80px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
			<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
			<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='justificacion']/node()"/></th>
			<th>&nbsp;</th>
		</tr>
	</thead>
	<tbody class="corpo_tabela">
	<xsl:for-each select="/OfertasSeleccionadas/LICITACION/PRODUCTOS_JUSTIFICADOS/PRODUCTO">
		<tr class="conhover">
			<td class="color_status"><xsl:value-of select="CONTADOR"/></td>
			<td><xsl:value-of select="REFERENCIA"/></td>
			<td class="textLeft">
				<a href="javascript:chFichaProductoLicitacion({/OfertasSeleccionadas/LICITACION/LIC_ID},{LIC_PROD_ID});"><xsl:value-of select="LIC_PROD_NOMBRE"/></a>
			</td>
			<td class="textLeft"><xsl:value-of select="JUSTIFICACION"/><xsl:value-of select="LIC_PROD_MOTIVOSELECCION"/></td>
			<td>&nbsp;</td>
		</tr>
	</xsl:for-each>
	</tbody>
	<tfoot class="rodape_tabela">
		<tr><td colspan="9">&nbsp;</td></tr>
	</tfoot>
	</table>
	</div>
	</xsl:if>
	<xsl:if test="/OfertasSeleccionadas/LICITACION/OFERTAS_DESCARTADAS/OFERTA">
    <div class="divLeft textCenter marginTop50">
		<span class="tituloTabla"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ofertas_descartadas']/node()"/></span>
	</div>
	<div class="tabela tabela_redonda">
	<table cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
		<tr>
			<th class="w1px">&nbsp;</th>
			<th class="w80px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
			<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
			<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></th>
			<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='justificacion']/node()"/></th>
			<th>&nbsp;</th>
		</tr>
	</thead>
	<tbody class="corpo_tabela">
	<xsl:for-each select="/OfertasSeleccionadas/LICITACION/OFERTAS_DESCARTADAS/OFERTA">
		<tr class="conhover">
			<td class="color_status"><xsl:value-of select="CONTADOR"/></td>
			<td><xsl:value-of select="REFERENCIA"/></td>
			<td class="textLeft"><xsl:value-of select="PROVEEDOR"/></td>
			<td class="textLeft">
				<a href="javascript:chFichaProductoLicitacion({/OfertasSeleccionadas/LICITACION/LIC_ID},{LIC_PROD_ID});"><xsl:value-of select="LIC_PROD_NOMBRE"/></a>
			</td>
			<td><xsl:value-of select="MARCA"/></td>
			<td><xsl:value-of select="PRECIO"/></td>
			<td class="textLeft"><xsl:value-of select="JUSTIFICACION"/><xsl:value-of select="LIC_PROD_MOTIVOSELECCION"/></td>
			<td>&nbsp;</td>
		</tr>
	</xsl:for-each>
	</tbody>
	<tfoot class="rodape_tabela">
		<tr><td colspan="9">&nbsp;</td></tr>
	</tfoot>
	</table>
	</div>
	</xsl:if>
	<xsl:if test="/OfertasSeleccionadas/LICITACION/ADJUDICADOS_ELIMINADOS/OFERTA">
    <div class="divLeft textCenter marginTop50">
		<span class="tituloTabla"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ofertas_adjudicadas_eliminadas']/node()"/></span>
	</div>
	<div class="tabela tabela_redonda">
	<table cellspacing="6px" cellpadding="6px">
	<thead>
		<tr>
			<th class="w1px">&nbsp;</th>
			<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
			<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
			<th class="w100px textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></th>
			<th class="w50px textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></th>
			<th class="w1px">&nbsp;</th>
		</tr>
	</thead>
	<tbody>
	<xsl:for-each select="/OfertasSeleccionadas/LICITACION/ADJUDICADOS_ELIMINADOS/OFERTA">
		<tr class="conhover">
			<td><xsl:value-of select="CONTADOR"/></td>
			<td class="textLeft"><xsl:value-of select="PROVEEDOR"/></td>
			<td><xsl:value-of select="REFERENCIA"/></td>
			<td class="textLeft">
				<a href="javascript:chFichaProductoLicitacion({/OfertasSeleccionadas/LICITACION/LIC_ID},{LIC_PROD_ID});"><xsl:value-of select="LIC_PROD_NOMBRE"/></a>
			</td>
			<td><xsl:value-of select="MARCA"/></td>
			<td><xsl:value-of select="PRECIO"/></td>
			<td>&nbsp;</td>
		</tr>
	</xsl:for-each>
	</tbody>
	<tfoot class="rodape_tabela">
		<tr><td colspan="7">&nbsp;</td></tr>
	</tfoot>
	</table>
	</div>
	</xsl:if>
	<br/>
	<br/>
	<br/>
	</form>
</div><!--fin de divLeft-->

</xsl:template>

</xsl:stylesheet>
