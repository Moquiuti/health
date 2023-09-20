<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Informe de proveedores que han ofertado, y todas las ofertas
	Ultima revision: ET 20ene21 12:30 licInformeProveedoresYOfertas_200121.js
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

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>		<!-- Para descargas excel	-->
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/licInformeProveedoresYOfertas_200121.js"></script>
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

<form id="Proveedores" name="Proveedores" action="http://www.newco.dev.br/Gestion/Comercial/licInformePorProveedor.xsql" method="POST">
<div class="divLeft">

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>
		&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion']/node()"/>
		&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores_y_ofertas']/node()"/></span>
		
		<span class="CompletarTitulo">
			<xsl:if test="/InformeProveedores/LICITACION/LIC_AGREGADA = 'S'">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/InformeProveedores/LICITACION/CENTROSCOMPRAS/field"/>
				<xsl:with-param name="onChange">javascript:document.forms[0].submit();</xsl:with-param>
				<xsl:with-param name="style">width:200px;</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
		</span>

		
		</p>
		<p class="TituloPagina">
			<xsl:value-of select="/InformeProveedores/LICITACION/LIC_CODIGO"/>:&nbsp;<xsl:value-of select="/InformeProveedores/LICITACION/LIC_TITULO"/>
			<span class="CompletarTitulo" style="width:700px;">
				<!--<a class="btnNormal" style="text-decoration:none;">
					<xsl:attribute name="href">javascript:listadoExcel();</xsl:attribute>
					<img src="http://www.newco.dev.br/images/iconoExcel.gif">
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_excel']/node()"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_excel']/node()"/></xsl:attribute>
					</img>
				</a>
				&nbsp;-->
				<!--<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/VencedoresYAlternativas.xsql?LIC_ID={/InformeProveedores/LIC_ID}"><xsl:value-of select="document($doc)/translation/texts/item[@name='VencedoresYAlternativas']/node()"/></a>
				&nbsp;
				<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/licOfertasSeleccionadas.xsql?LIC_ID={/InformeProveedores/LIC_ID}&amp;IDCENTROCOMPRAS={/InformeProveedores/IDCENTROCOMPRAS}"><xsl:value-of select="document($doc)/translation/texts/item[@name='Vencedores']/node()"/></a>
				&nbsp;
				<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/licInformePorProveedor.xsql?LIC_ID={/InformeProveedores/LIC_ID}"><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/></a>
				&nbsp;
				<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/licInformeResumen.xsql?LIC_ID={/InformeProveedores/LIC_ID}"><xsl:value-of select="document($doc)/translation/texts/item[@name='Resumen_licitaciones']/node()"/></a>
				&nbsp;-->
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
	<table class="buscador">
		<tr class="sinLinea">
			<td align="center">
				<img src="{/InformeProveedores/LICITACION/EMPRESA_MVM/URL_LOGOTIPO}"/><BR/>
				<xsl:value-of select="/InformeProveedores/LICITACION/EMPRESA_MVM/NOMBRE"/>
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores_y_ofertas']/node()"/></strong>
			</td>
		</tr>
		<tr class="sinLinea"><td colspan="2">&nbsp;</td></tr>
		<tr class="sinLinea">
			<td class="labelRight" style="width:25%;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_informe']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformeProveedores/LICITACION/FECHAACTUAL"/></strong>
			</td>
		</tr>
		<xsl:if test="/InformeProveedores/LICITACION/CENTROPEDIDO">
		<tr class="sinLinea">
			<td class="labelRight" style="width:25%;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Comprador']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformeProveedores/LICITACION/CENTROPEDIDO/NOMBRE"/></strong>&nbsp;(<xsl:value-of select="/InformeProveedores/LICITACION/CENTROPEDIDO/NIF"/>)
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight" style="width:25%;">
				&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformeProveedores/LICITACION/CENTROPEDIDO/DIRECCION"/></strong>
			</td>
		</tr>
		</xsl:if>
		<tr class="sinLinea">
			<td class="labelRight" style="width:25%;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='codigo']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformeProveedores/LICITACION/LIC_CODIGO"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight" style="width:25%;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformeProveedores/LICITACION/LIC_TITULO"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_licitacion']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
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
	
	<table class="buscador">
	<thead>
		<tr>
			<td class="uno">&nbsp;</td>
			<td class="uno">&nbsp;</td>
			<td class="cuarenta" align="left">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></strong></td>
			<td align="left">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/></strong></td>
			<td align="left">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/></strong></td>
			<td align="left">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='forma_pago']/node()"/></strong></td>
			<td align="left">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='frete']/node()"/></strong></td>
			<td align="left">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones']/node()"/></strong></td>
			<td class="uno">&nbsp;</td>
		</tr>
	</thead>
	<tbody>
		<xsl:for-each select="/InformeProveedores/LICITACION/PROVEEDORES/PROVEEDOR">
		<tr>
			<td class="uno">&nbsp;</td>
			<td class="uno">&nbsp;<xsl:value-of select="CONTADOR"/></td>
			<td align="left">
				<BR/>&nbsp;<strong><xsl:value-of select="NOMBRE"/></strong><BR/>&nbsp;<xsl:value-of select="PROVINCIA"/><BR/>&nbsp;<xsl:value-of select="VENDEDOR/NOMBRE"/>:&nbsp;<xsl:value-of select="VENDEDOR/TELEFONO"/><BR/>
				&nbsp;<xsl:value-of select="VENDEDOR/EMAIL"/><BR/>
				&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDPROVEEDOR}&amp;ESTADO=CABECERA','Detalle Empresa',100,80,0,0);"><xsl:value-of select="document($doc)/translation/texts/item[@name='Mas_informacion']/node()"/></a><BR/>
				<BR/>
			</td>
			<td align="left">&nbsp;<xsl:value-of select="/InformeProveedores/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="LIC_PROV_PEDIDOMINIMO"/><xsl:value-of select="/InformeProveedores/LICITACION/DIVISA/SUFIJO"/></td>
			<td align="left">&nbsp;<xsl:value-of select="LIC_PROV_PLAZOENTREGA"/></td>
			<td align="left">&nbsp;<xsl:value-of select="FORMAPAGO"/>.&nbsp;<xsl:value-of select="PLAZOPAGO"/></td>
			<td align="left">&nbsp;<xsl:value-of select="LIC_PROV_FRETE"/></td>
			<td align="left">&nbsp;<xsl:copy-of select="LIC_PROV_COMENTARIOSPROV"/></td>
			<td class="uno">&nbsp;</td>
		</tr>
		</xsl:for-each>		
	</tbody>
	</table>
	<br/>	
	<br/>	
	<br/>	
	<br/>	
	<br/>	
	<table class="buscador">
	<thead>
		<tr class="gris">
			<td class="tres">&nbsp;</td>
			<td class="treinta" style="text-align:left;">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></strong></td>
			<td class="cinco">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></strong></td>
			<td class="diez">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='Fabricante']/node()"/></strong></td>
			<td class="cinco">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='embalaje']/node()"/></strong></td>
			<xsl:if test="/InformeProveedores/LICITACION/IDPAIS != 55">
				<td class="siete"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/></strong></td>
			</xsl:if>
			<td class="veinte">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></strong></td>
			<td class="cinco">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/></strong></td>
			<!--<td class="diez">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='justificacion']/node()"/></strong></td>-->
			<td class="cinco">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></strong></td>
			<td class="cinco">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/></strong></td>
			<xsl:if test="/InformeProveedores/LICITACION/IDPAIS = 34">
				<td class="cinco">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></strong></td>
			</xsl:if>
			<td class="cinco">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='Total_linea']/node()"/></strong></td>
			<!--<td class="diez">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></strong></td>-->
			<td class="uno">&nbsp;</td>
		</tr>
	</thead>
	<tbody>
		<xsl:for-each select="/InformeProveedores/LICITACION/OFERTAS/OFERTA">
			<tr class="gris">
				<xsl:attribute name="class">
				<xsl:choose>
				<xsl:when test="LIC_OFE_ADJUDICADA='S'">
					fondoAmarillo
				</xsl:when>
				<xsl:otherwise>
					gris
				</xsl:otherwise>
				</xsl:choose>
				</xsl:attribute>
				<xsl:if test="NUEVO">
				<xsl:attribute name="style">
					border-top:3px solid #000000;border-bottom:1px solid #A7A8A9;
				</xsl:attribute>
				</xsl:if>
				<td><xsl:value-of select="CONTADOR"/></td>
				<td class="datosLeft">
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
				<td class="datosLeft">
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
	<tr>
		<td colspan="4">&nbsp;</td>
		<td colspan="4">
			<strong>
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Numero_productos_licitacion']/node()"/>:&nbsp;<xsl:value-of select="/InformeProveedores/LICITACION/LIC_NUMEROLINEAS"/>
			&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Numero_productos_adjudicados']/node()"/>:&nbsp;<xsl:value-of select="/InformeProveedores/LICITACION/OFERTAS/OFERTAS_ADJUDICADAS"/>
			</strong>
		</td>
		<td>&nbsp;</td>
	</tr>
	</tbody>
	</table>
</div><!--fin de divLeft-->
</form>

</xsl:template>

</xsl:stylesheet>
