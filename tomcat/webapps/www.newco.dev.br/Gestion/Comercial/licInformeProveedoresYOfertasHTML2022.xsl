<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Informe de proveedores que han ofertado, y todas las ofertas
	Ultima revision: ET 01abr22 10:15 licInformeProveedoresYOfertas2022_010422.js
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
			<xsl:when test="/InformeProveedores/LANG"><xsl:value-of select="/InformeProveedores/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<meta http-equiv="Cache-Control" content="no-cache"/>

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores_y_ofertas']/node()"/>:&nbsp;<xsl:value-of select="/InformeProveedores/LICITACION/LIC_TITULO"/></title>

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
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/licInformeProveedoresYOfertas2022_010422.js"></script>
	<script type="text/javascript">

	var strInforme='<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores_y_ofertas']/node()"/>';

	var strFechaInforme='<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_informe']/node()"/>';
	var FechaInforme='<xsl:value-of select="/InformeProveedores/LICITACION/FECHAACTUAL"/>';

	var strEmpresa='<xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>';
	var strEmpresaLic='<xsl:value-of select="/InformeProveedores/LICITACION/EMPRESA_MVM/NOMBRE"/>';

	var strTitulo='<xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>';
	var strTituloLic='<xsl:value-of select="/InformeProveedores/LICITACION/LIC_TITULO"/>';

	var strCodigo='<xsl:value-of select="document($doc)/translation/texts/item[@name='codigo']/node()"/>';
	var strCodigoLic='<xsl:value-of select="/InformeProveedores/LICITACION/LIC_CODIGO"/>';

	var	strComprador='<xsl:value-of select="document($doc)/translation/texts/item[@name='Comprador']/node()"/>';
	var	strCompradorLic='<xsl:value-of select="/InformeProveedores/LICITACION/CENTROPEDIDO/NOMBRE"/> (<xsl:value-of select="/InformeProveedores/LICITACION/CENTROPEDIDO/NIF"/>)';
	var	strDireccionLic='<xsl:value-of select="/InformeProveedores/LICITACION/CENTROPEDIDO/DIRECCION"/>';

	var	strTipo='<xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_licitacion']/node()"/>';
	var	strTipoLic='<xsl:value-of select="/InformeProveedores/LICITACION/CENTROPEDIDO/TIPOLICITACION"/>';

	var strCabeceraProveedores='<xsl:value-of select="document($doc)/translation/texts/item[@name='Cabecera_Prov_CSV_provyofertas']/node()"/>';
	var strCabeceraProductos='<xsl:value-of select="document($doc)/translation/texts/item[@name='Cabecera_Prod_CSV_provyofertas']/node()"/>';

	var arrProveedores			= new Array();
	<xsl:for-each select="/InformeProveedores/LICITACION/PROVEEDORES/PROVEEDOR">
		var Proveedor			= [];
		
		Proveedor['ID']	= '<xsl:value-of select="IDPROVEEDOR"/>';
		Proveedor['IDCentro']	= '<xsl:value-of select="IDCENTRO"/>';					//	IMPORTANTE para multicentro
		Proveedor['IDProvLic']	= '<xsl:value-of select="IDPROVEEDOR_LIC"/>';
		Proveedor['Nombre']	= '<xsl:value-of select="NOMBRECORTO"/>';
		Proveedor['Provincia']	= '<xsl:value-of select="PROVINCIA"/>';

		Proveedor['PedidoMinimo']	= '<xsl:value-of select="LIC_PROV_PEDIDOMINIMO"/>';
		Proveedor['PlazoPago']	= '<xsl:value-of select="PLAZOPAGO"/>';
		Proveedor['FormaPago']	= '<xsl:value-of select="FORMAPAGO"/>';
		Proveedor['PlazoEntrega']	= '<xsl:value-of select="LIC_PROV_PLAZOENTREGA"/>';
		Proveedor['Frete']	= '<xsl:value-of select="LIC_PROV_FRETE"/>';
		Proveedor['Comentarios']	= '<xsl:value-of select="LIC_PROV_COMENTARIOSPROV_JS"/>';

		Proveedor['VendNombre']	= '<xsl:value-of select="VENDEDOR/NOMBRE"/>';
		Proveedor['VendTelefono']	= '<xsl:value-of select="VENDEDOR/TELEFONO"/>';
		Proveedor['VendEmail']	= '<xsl:value-of select="VENDEDOR/EMAIL"/>';
		
		arrProveedores.push(Proveedor);
	</xsl:for-each>

	arrOfertas	= new Array();
	<xsl:for-each select="/InformeProveedores/LICITACION/OFERTAS/OFERTA">
		var oferta= [];
		oferta['Linea']		= '<xsl:value-of select="CONTADOR"/>';
		oferta['Producto']		= '<xsl:value-of select="LIC_PROD_NOMBRE"/>';
		oferta['Proveedor']		= '<xsl:value-of select="PROVEEDOR"/>';
		oferta['IDoferta']	= '<xsl:value-of select="LIC_PROD_ID"/>';
		oferta['IDProdEstandar']	= '<xsl:value-of select="LIC_PROD_IDPRODESTANDAR"/>';
		oferta['Referencia']	= '<xsl:value-of select="PRO_REFERENCIA"/>';
		oferta['Refestandar']	= '<xsl:value-of select="LIC_PROD_REFESTANDAR"/>';
		oferta['RefCliente']	= '<xsl:value-of select="LIC_PROD_REFCLIENTE"/>';
		oferta['UdsXLote']	= '<xsl:value-of select="LIC_OFE_UNIDADESPORLOTE"/>';
		oferta['UdBasica']	= '<xsl:value-of select="LIC_PROD_UNIDADBASICA"/>';
		oferta['Marca']	= '<xsl:value-of select="LIC_OFE_MARCA"/>';
		oferta['PrecioRef']	= '<xsl:value-of select="LIC_PROD_PRECIOREFERENCIA"/>';

		oferta['IDCentroProv']= '<xsl:value-of select="IDCENTROPROVEEDOR"/>';
		oferta['CentroProv']	= '<xsl:value-of select="CENTROPROVEEDOR"/>';

		oferta['Cantidad']	= '<xsl:value-of select="CANTIDAD"/>';
		oferta['Tarifa']		= '<xsl:value-of select="LIC_OFE_PRECIO"/>';
		oferta['TotalLinea']	= '<xsl:value-of select="CONSUMO"/>';
		oferta['Ahorro']	= '<xsl:value-of select="LIC_OFE_AHORRO"/>';
		oferta['Adjudicada']	= '<xsl:value-of select="LIC_OFE_ADJUDICADA"/>';
		oferta['Comentarios']	= '<xsl:value-of select="LIC_OFE_COMENTARIOS"/>';

		arrOfertas.push(oferta);
	</xsl:for-each>
	
	//	Cadenas para el CSV
	var strTitulo='<xsl:value-of select="/InformeProveedores/LICITACION/LIC_TITULO"/>';

	var strFechaInforme='<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_informe']/node()"/>';
	var FechaInforme='<xsl:value-of select="/InformeProveedores/LICITACION/FECHAACTUAL"/>';

	var strFechaDecision='<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/>';
	var FechaDecision='<xsl:value-of select="/InformeProveedores/LICITACION/LIC_FECHADECISIONPREVISTA"/>';

	var strDescripcion='<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>';
	var Descripcion='<xsl:value-of select="/InformeProveedores/LICITACION/LIC_DESCRIPCION"/>';
	
	var strCondEntrega='<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_entrega']/node()"/>';
	var CondEntrega='<xsl:value-of select="/InformeProveedores/LICITACION/LIC_CONDICIONESENTREGA"/>';
	
	var strCondPago='<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_pago']/node()"/>';
	var CondPago='<xsl:value-of select="/InformeProveedores/LICITACION/LIC_CONDICIONESPAGO"/>';
	
	var strCondOtras='<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_otras']/node()"/>';
	var CondOtras='<xsl:value-of select="/InformeProveedores/LICITACION/LIC_OTRASCONDICIONES"/>';
	
	var strMesesDuracion='<xsl:value-of select="document($doc)/translation/texts/item[@name='meses_duracion']/node()"/>';
	var MesesDuracion=<xsl:value-of select="/InformeProveedores/LICITACION/LIC_MESESDURACION"/>;
	
	var chkTotal='<xsl:value-of select="/InformeProveedores/LICITACION/TOTAL_ALAVISTA"/>';
	
	var strTotalALaVista='<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_alavista']/node()"/>';
	var TotalALaVista='<xsl:value-of select="/InformeProveedores/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/InformeProveedores/LICITACION/TOTAL_ALAVISTA"/><xsl:value-of select="/InformeProveedores/LICITACION/DIVISA/SUFIJO"/>';
	
	var strTotalAplazado='<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_aplazado']/node()"/>';
	var TotalAplazado='<xsl:value-of select="/InformeProveedores/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/InformeProveedores/LICITACION/TOTAL_APLAZADO"/><xsl:value-of select="/InformeProveedores/LICITACION/DIVISA/SUFIJO"/>';

	var chkTotalPedidos='<xsl:value-of select="/InformeProveedores/LICITACION/TOTAL_PEDIDOS"/>';

	var strTotalPedidos='<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_pedidos']/node()"/>';
	var TotalPedidos='<xsl:value-of select="/InformeProveedores/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/InformeProveedores/LICITACION/TOTAL_PEDIDOS"/><xsl:value-of select="/InformeProveedores/LICITACION/DIVISA/SUFIJO"/>';
	
	var strTotalAdjudicado='<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_adjudicado']/node()"/>';
	var TotalAdjudicado='<xsl:value-of select="/InformeProveedores/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/InformeProveedores/LICITACION/LIC_CONSUMOADJUDICADO"/><xsl:value-of select="/InformeProveedores/LICITACION/DIVISA/SUFIJO"/>';
	
	var strProductos='<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>';
	var Productos='<xsl:value-of select="/InformeProveedores/LICITACION/PRODUCTOSADJUDICADOS"/>/<xsl:value-of select="/InformeProveedores/LICITACION/LIC_NUMEROLINEAS"/>';

	var strProveedores='<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>';
	var Proveedores='<xsl:value-of select="/InformeProveedores/LICITACION/LIC_PROVEEDORESADJUDICADOS"/>/<xsl:value-of select="/InformeProveedores/LICITACION/LIC_NUMEROPROVEEDORES"/>';
	
	var strAhorroPorc='<xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro']/node()"/> (%)';
	var AhorroPorc='<xsl:value-of select="/InformeProveedores/LICITACION/LIC_AHORROADJUDICADO"/>%';
	
	var strAhorro='<xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro']/node()"/>';
	var Ahorro='<xsl:value-of select="/InformeProveedores/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/InformeProveedores/LICITACION/LIC_AHORROADJUDICADO_TOT"/><xsl:value-of select="/InformeProveedores/LICITACION/DIVISA/SUFIJO"/>';

	var strProveedor='<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>';
	var strCabeceraExcel='<xsl:value-of select="document($doc)/translation/texts/item[@name='Cabecera_CSV_vencedores']/node()"/>';


	var strPedidoMinimo='<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/>';
	var strPlazoPago='<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_pago']/node()"/>';
	var strFormaPago='<xsl:value-of select="document($doc)/translation/texts/item[@name='forma_pago']/node()"/>';
	var strPlazoEntrega='<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/>';
	var strFrete='<xsl:value-of select="document($doc)/translation/texts/item[@name='frete']/node()"/>';

	</script>
</head>
<body class="gris">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/InformeProveedores/LANG"><xsl:value-of select="/InformeProveedores/LANG"/></xsl:when>
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
			<xsl:when test="/InformeProveedores/LANG"><xsl:value-of select="/InformeProveedores/LANG"/></xsl:when>
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
		<xsl:when test="/InformeProveedores/LANG"><xsl:value-of select="/InformeProveedores/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<form id="Proveedores" name="Proveedores" action="http://www.newco.dev.br/Gestion/Comercial/licInformePorProveedor2022.xsql" method="POST">
<div class="divLeft">

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<xsl:if test="/InformeProveedores/LICITACION/LIC_AGREGADA = 'S'">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/InformeProveedores/LICITACION/CENTROSCOMPRAS/field"/>
			<xsl:with-param name="onChange">javascript:document.forms[0].submit();</xsl:with-param>
			<xsl:with-param name="style">width:200px;</xsl:with-param>
		</xsl:call-template>
		</xsl:if>
		<p class="TituloPagina">
			<xsl:value-of select="/InformeProveedores/LICITACION/LIC_CODIGO"/>:&nbsp;<xsl:value-of select="/InformeProveedores/LICITACION/LIC_TITULO"/>
			<span class="CompletarTitulo" style="width:700px;">
				<a class="btnNormal" href="javascript:window.print();"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
				&nbsp;
				<a class="btnNormal" href="javascript:DescargarExcel();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/>
				</a>
				&nbsp;
				<xsl:choose>
				<xsl:when test="/InformeProveedores/LIC_PROD_ID != ''">
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
	<table cellspacing="6px" cellpadding="6px">
		<tr>
			<td align="center">
				<img src="{/InformeProveedores/LICITACION/EMPRESA_MVM/URL_LOGOTIPO}"/><BR/>
				<xsl:value-of select="/InformeProveedores/LICITACION/EMPRESA_MVM/NOMBRE"/>
			</td>
			<td class="textLeft">
				<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores_y_ofertas']/node()"/></strong>
			</td>
		</tr>
		<tr><td colspan="2">&nbsp;</td></tr>
		<tr>
			<td class="labelRight" style="width:25%;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_informe']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<strong><xsl:value-of select="/InformeProveedores/LICITACION/FECHAACTUAL"/></strong>
			</td>
		</tr>
		<xsl:if test="/InformeProveedores/LICITACION/CENTROPEDIDO">
		<tr>
			<td class="labelRight" style="width:25%;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Comprador']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<strong><xsl:value-of select="/InformeProveedores/LICITACION/CENTROPEDIDO/NOMBRE"/></strong>&nbsp;(<xsl:value-of select="/InformeProveedores/LICITACION/CENTROPEDIDO/NIF"/>)
			</td>
		</tr>
		<tr>
			<td class="labelRight" style="width:25%;">
				&nbsp;
			</td>
			<td class="textLeft">
				<strong><xsl:value-of select="/InformeProveedores/LICITACION/CENTROPEDIDO/DIRECCION"/></strong>
			</td>
		</tr>
		</xsl:if>
		<tr>
			<td class="labelRight" style="width:25%;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='codigo']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<strong><xsl:value-of select="/InformeProveedores/LICITACION/LIC_CODIGO"/></strong>
			</td>
		</tr>
		<tr>
			<td class="labelRight" style="width:25%;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<strong><xsl:value-of select="/InformeProveedores/LICITACION/LIC_TITULO"/></strong>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_licitacion']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<strong><xsl:value-of select="/InformeProveedores/LICITACION/TIPOLICITACION"/></strong>
			</td>
		</tr>
	</table><!--fin de tala datos generales-->
	<br/>
	<br/>
	<br/>
</div><!--fin de divLeft-->

<div class="divLeft">
	<input type="hidden" name="IDLicitacion" value="{/InformeProveedores/LICITACION/LIC_ID}"/>		<!--	para el JS	-->
	<input type="hidden" name="LIC_ID" value="{/InformeProveedores/LICITACION/LIC_ID}"/>				<!--	se utiliza en el XSQL		-->
	<input type="hidden" name="IDCentro" value="{/InformeProveedores/LICITACION/IDCENTRO}"/>
	<input type="hidden" name="ACCION" value=""/>
	<input type="hidden" name="PARAMETROS" value=""/>
	
	<div class="tabela tabela_redonda">
	<table cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
		<tr>
			<th class="w1px">&nbsp;</th>
			<th class="textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
			<th class="w100px textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Ped_minimo']/node()"/></th>
			<th class="w80px textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Pl_entrega']/node()"/></th>
			<th class="w150px textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='forma_pago']/node()"/></th>
			<th class="w50px textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='frete']/node()"/></th>
			<th class="textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones']/node()"/></th>
			<th class="w1px">&nbsp;</th>
		</tr>
	</thead>
	<tbody class="corpo_tabela">
		<xsl:for-each select="/InformeProveedores/LICITACION/PROVEEDORES/PROVEEDOR">
		<tr>
			<td class="color_status"><xsl:value-of select="CONTADOR"/></td>
			<td class="textLeft">
				<BR/>&nbsp;<strong><xsl:value-of select="NOMBRE"/></strong><BR/>&nbsp;<xsl:value-of select="PROVINCIA"/><BR/>&nbsp;<xsl:value-of select="VENDEDOR/NOMBRE"/>:&nbsp;<xsl:value-of select="VENDEDOR/TELEFONO"/><BR/>
				&nbsp;<xsl:value-of select="VENDEDOR/EMAIL"/><BR/>
				&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDPROVEEDOR}&amp;ESTADO=CABECERA','Detalle Empresa',100,80,0,0);"><xsl:value-of select="document($doc)/translation/texts/item[@name='Mas_informacion']/node()"/></a><BR/>
				<BR/>
			</td>
			<td class="textLeft">&nbsp;<xsl:value-of select="/InformeProveedores/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="LIC_PROV_PEDIDOMINIMO"/><xsl:value-of select="/InformeProveedores/LICITACION/DIVISA/SUFIJO"/></td>
			<td><xsl:value-of select="LIC_PROV_PLAZOENTREGA"/></td>
			<td class="textLeft">&nbsp;<xsl:value-of select="FORMAPAGO"/>.&nbsp;<xsl:value-of select="PLAZOPAGO"/></td>
			<td><xsl:value-of select="LIC_PROV_FRETE"/></td>
			<td class="textLeft">&nbsp;<xsl:copy-of select="LIC_PROV_COMENTARIOSPROV"/></td>
			<td>&nbsp;</td>
		</tr>
		</xsl:for-each>		
	</tbody>
	<tfoot class="rodape_tabela">
		<tr><td colspan="9">&nbsp;</td></tr>
	</tfoot>
	</table>
	</div>
	<br/>	
	<br/>	
	<br/>	
	<br/>	
	<br/>	
	<div class="tabela tabela_redonda">
	<table cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
		<tr>
			<th class="tres">&nbsp;</th>
			<th class="treinta" style="text-align:left;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
			<th class="cinco">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
			<th class="diez">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Fabricante']/node()"/></th>
			<th class="cinco">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='embalaje']/node()"/></th>
			<xsl:if test="/InformeProveedores/LICITACION/IDPAIS != 55">
				<th class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/></th>
			</xsl:if>
			<th class="veinte">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
			<th class="cinco">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/></th>
			<!--<th class="diez">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='justificacion']/node()"/></th>-->
			<th class="cinco">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
			<th class="cinco">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/></th>
			<xsl:if test="/InformeProveedores/LICITACION/IDPAIS = 34">
				<th class="cinco">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></th>
			</xsl:if>
			<th class="cinco">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_linea']/node()"/></th>
			<!--<th class="diez">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></th>-->
			<th class="uno">&nbsp;</th>
		</tr>
	</thead>
	<tbody class="corpo_tabela">
		<xsl:for-each select="/InformeProveedores/LICITACION/OFERTAS/OFERTA">
			<tr>
				<xsl:attribute name="class">
				<xsl:choose>
				<xsl:when test="LIC_OFE_ADJUDICADA='S'">
					fondoAmarillo conhover
				</xsl:when>
				<xsl:otherwise>
					conhover
				</xsl:otherwise>
				</xsl:choose>
				</xsl:attribute>
				<!--<xsl:if test="NUEVO">
				<xsl:attribute name="style">
					border-top:3px solid #000000;border-bottom:1px solid #A7A8A9;
				</xsl:attribute>
				</xsl:if>-->
				<td class="color_status"><xsl:value-of select="CONTADOR"/></td>
				<td class="textLeft">
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/InformeProveedores/LICITACION/LIC_ID}');">
					<xsl:choose>
					<xsl:when test="LIC_OFE_ADJUDICADA='S'">
						<strong><xsl:value-of select="LIC_PROD_NOMBRE"/></strong>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="LIC_PROD_NOMBRE"/>
					</xsl:otherwise>
					</xsl:choose>
					</a>
				</td>
				<td>
					<xsl:choose>
					<!-- para liciatciones no agregadas o si no está seleccionado un centro	-->
					<xsl:when test="LIC_PROD_REFCLIENTE != ''"><xsl:value-of select="LIC_PROD_REFCLIENTE"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="LIC_PROD_REFESTANDAR"/></xsl:otherwise>
					</xsl:choose>
				</td>
				<td><xsl:value-of select="LIC_OFE_MARCA"/></td>
				<td><xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>
				<xsl:if test="/InformeProveedores/LICITACION/IDPAIS != 55">
					<td><xsl:value-of select="LIC_OFE_REFERENCIA"/></td>
				</xsl:if>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="LIC_OFE_ADJUDICADA='S'">
						<strong><xsl:value-of select="PROVEEDOR"/></strong>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="PROVEEDOR"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td><xsl:value-of select="LIC_OFE_COMENTARIOS"/></td>
				<!--<td><xsl:value-of select="JUSTIFICACION"/><xsl:value-of select="LIC_PROD_MOTIVOSELECCION"/></td>-->
				<td class="datosRight">
					<xsl:if test="CAMBIO_CANTIDAD">
						(<xsl:value-of select="CAMBIO_CANTIDAD/CANTIDADORIGINAL"/>-><xsl:value-of select="CAMBIO_CANTIDAD/CANTIDAD"/>)&nbsp;
					</xsl:if>
					<strong><xsl:value-of select="CANTIDAD"/></strong>&nbsp;
				</td>
				<td class="datosRight">
					<xsl:value-of select="/InformeProveedores/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="LIC_OFE_PRECIO"/><xsl:value-of select="/InformeProveedores/LICITACION/DIVISA/SUFIJO"/>
				</td>
				<xsl:if test="/InformeProveedores/LICITACION/IDPAIS != 55">
					<td><xsl:value-of select="LIC_OFE_TIPOIVA"/>%</td>
				</xsl:if>
				<td class="datosRight">
					<xsl:value-of select="/InformeProveedores/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="CONSUMO"/><xsl:value-of select="/InformeProveedores/LICITACION/DIVISA/SUFIJO"/>
				</td>
				<!--<td><xsl:value-of select="USUARIO_ADJUDICACION"/><BR/><xsl:value-of select="LIC_OFE_FECHAADJUDICACION"/></td>-->
				<td>&nbsp;</td>
			</tr>
		</xsl:for-each>
	</tbody>
	<tfoot class="rodape_tabela">
	<tr>
		<td colspan="2">&nbsp;</td>
		<td colspan="4">
			<strong>
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Numero_productos_licitacion']/node()"/>:&nbsp;<xsl:value-of select="/InformeProveedores/LICITACION/LIC_NUMEROLINEAS"/>
			&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Numero_productos_adjudicados']/node()"/>:&nbsp;<xsl:value-of select="/InformeProveedores/LICITACION/OFERTAS/OFERTAS_ADJUDICADAS"/>
			</strong>
		</td>
		<td colspan="5">&nbsp;</td>
	</tr>
	</tfoot>
	</table>
	</div>
	<br/>	
	<br/>	
	<br/>	
	<br/>	
	<br/>	
</div><!--fin de divLeft-->
</form>

</xsl:template>

</xsl:stylesheet>
