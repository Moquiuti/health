<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Ficha con las ofertas seleccionadas, "Vencedores"	
	Ultima revision ET 4oct21 10:00 licAvanceOfertas_031021
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
			<xsl:when test="/AvanceOfertas/LANG"><xsl:value-of select="/AvanceOfertas/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<meta http-equiv="Cache-Control" content="no-cache"/>

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='AvanceOfertas']/node()"/>:&nbsp;<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_TITULO"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>		<!-- Para descargas excel	-->
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/licAvanceOfertas_031021.js"></script>
	<script type="text/javascript">
	var strCabeceraExcel='<xsl:value-of select="document($doc)/translation/texts/item[@name='Cabecera_Princ_CSV_avanceofertas']/node()"/>';
	<!--	Ofertas vencedoras y alternativas. Listado Excel		-->

	var numColumnas=0;
	var arrProductos			= new Array();
	
	<xsl:for-each select="/AvanceOfertas/LICITACION/PRODUCTOS/PRODUCTO">
		var producto		= [];
		producto['Contador']	= '<xsl:value-of select="CONTADOR"/>';
		producto['Nombre']		= '<xsl:value-of select="LIC_PROD_NOMBRE"/>';
		producto['Refestandar']	= '<xsl:value-of select="LIC_PROD_REFESTANDAR"/>';
		producto['RefCliente']	= '<xsl:value-of select="LIC_PROD_REFCLIENTE"/>';
		producto['UdBasica']	= '<xsl:value-of select="LIC_PROD_UNIDADBASICA"/>';
		producto['MarcasAceptables']	= '<xsl:value-of select="LIC_PROD_MARCASACEPTABLES"/>';
		producto['Cantidad']	= '<xsl:value-of select="LIC_PROD_CANTIDAD"/>';
		producto['Consumo']	= '<xsl:value-of select="LIC_PROD_CONSUMOHISTORICO"/>';
		producto['NumOfertas']	= '<xsl:value-of select="LIC_PROD_NUMEROOFERTAS"/>';
		producto['PrecioRef']	= '<xsl:value-of select="LIC_PROD_PRECIOREFERENCIA"/>';
		producto['PrecioMedio']	= '<xsl:value-of select="OFERTA/PRECIOMEDIO"/>';
		producto['MejorPrecio']	= '<xsl:value-of select="OFERTA/LIC_OFE_PRECIO"/>';
		producto['Ahorro']	= '<xsl:value-of select="OFERTA/AHORRO"/>';
		producto['UdsXLote']	= '<xsl:value-of select="OFERTA/LIC_OFE_UNIDADESPORLOTE"/>';
		producto['Marca']	= '<xsl:value-of select="OFERTA/LIC_OFE_MARCA"/>';
		producto['Proveedor']	= '<xsl:value-of select="OFERTA/PROVEEDOR"/>';

		arrProductos.push(producto);
	</xsl:for-each>
	
	//	Cadenas para el CSV
	var strInforme='<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores_y_ofertas']/node()"/>';

	var strFechaInforme='<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_informe']/node()"/>';
	var FechaInforme='<xsl:value-of select="/AvanceOfertas/LICITACION/FECHAACTUAL"/>';

	//var strEmpresa='<xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>';
	//var strEmpresaLic='<xsl:value-of select="/AvanceOfertas/LICITACION/EMPRESA_MVM/NOMBRE"/>';

	var strTitulo='<xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>';
	var strTituloLic='<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_TITULO"/>';

	var strCodigo='<xsl:value-of select="document($doc)/translation/texts/item[@name='codigo']/node()"/>';
	var strCodigoLic='<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_CODIGO"/>';

	var strFechaDecision='<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/>';
	var FechaDecision='<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_FECHADECISIONPREVISTA"/>';

	var strDescripcion='<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>';
	var Descripcion='<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_DESCRIPCION"/>';
	
	var strCondEntrega='<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_entrega']/node()"/>';
	var CondEntrega='<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_CONDICIONESENTREGA"/>';
	
	var strCondPago='<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_pago']/node()"/>';
	var CondPago='<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_CONDICIONESPAGO"/>';
	
	var strCondOtras='<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_otras']/node()"/>';
	var CondOtras='<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_OTRASCONDICIONES"/>';
	
	var strMesesDuracion='<xsl:value-of select="document($doc)/translation/texts/item[@name='meses_duracion']/node()"/>';
	var MesesDuracion=<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_MESESDURACION"/>;
	
	var chkTotal='<xsl:value-of select="/AvanceOfertas/LICITACION/TOTAL_ALAVISTA"/>';
	
	var strTotalALaVista='<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_alavista']/node()"/>';
	var TotalALaVista='<xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/AvanceOfertas/LICITACION/TOTAL_ALAVISTA"/><xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/SUFIJO"/>';
	
	var strTotalAplazado='<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_aplazado']/node()"/>';
	var TotalAplazado='<xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/AvanceOfertas/LICITACION/TOTAL_APLAZADO"/><xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/SUFIJO"/>';

	var chkTotalPedidos='<xsl:value-of select="/AvanceOfertas/LICITACION/TOTAL_PEDIDOS"/>';

	var strTotalPedidos='<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_pedidos']/node()"/>';
	var TotalPedidos='<xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/AvanceOfertas/LICITACION/TOTAL_PEDIDOS"/><xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/SUFIJO"/>';
	
	var strTotalAdjudicado='<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_adjudicado']/node()"/>';
	var TotalAdjudicado='<xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/AvanceOfertas/LICITACION/LIC_CONSUMOADJUDICADO"/><xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/SUFIJO"/>';
	
	var strProductos='<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>';
	var Productos='<xsl:value-of select="/AvanceOfertas/LICITACION/PRODUCTOSADJUDICADOS"/>/<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_NUMEROLINEAS"/>';

	var strProveedores='<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>';
	var Proveedores='<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_PROVEEDORESADJUDICADOS"/>/<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_NUMEROPROVEEDORES"/>';
	
	var strAhorroPorc='<xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro']/node()"/> (%)';
	var AhorroPorc='<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_AHORROADJUDICADO"/>%';
	
	var strAhorro='<xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro']/node()"/>';
	var Ahorro='<xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/AvanceOfertas/LICITACION/LIC_AHORROADJUDICADO_TOT"/><xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/SUFIJO"/>';

	var strProveedor='<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>';

	</script>
</head>
<body class="gris">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/AvanceOfertas/LANG"><xsl:value-of select="/AvanceOfertas/LANG"/></xsl:when>
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
			<xsl:when test="/AvanceOfertas/LANG"><xsl:value-of select="/AvanceOfertas/LANG"/></xsl:when>
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
		<xsl:when test="/AvanceOfertas/LANG"><xsl:value-of select="/AvanceOfertas/LANG"/></xsl:when>
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
		&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='AvanceOfertas']/node()"/></span>
		
		<span class="CompletarTitulo">
			<xsl:if test="/AvanceOfertas/LICITACION/LIC_AGREGADA = 'S'">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/AvanceOfertas/LICITACION/CENTROSCOMPRAS/field"/>
				<xsl:with-param name="onChange">javascript:document.forms[0].submit();</xsl:with-param>
				<xsl:with-param name="style">width:200px;</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
		</span>

		
		</p>
		<p class="TituloPagina">
			<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_CODIGO"/>:&nbsp;<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_TITULO"/>
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
				<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/licOfertasSeleccionadas.xsql?LIC_ID={/AvanceOfertas/LIC_ID}"><xsl:value-of select="document($doc)/translation/texts/item[@name='Vencedores']/node()"/></a>
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
				<xsl:when test="/AvanceOfertas/LIC_PROD_ID != ''">
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
	<br/>
	<br/>
	<br/>
	<table class="buscador">
		<tr class="sinLinea">
			<td class="labelRight" style="width:25%;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_informe']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/AvanceOfertas/LICITACION/FECHAACTUAL"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight" style="width:25%;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/AvanceOfertas/LICITACION/LIC_FECHADECISIONPREVISTA"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/AvanceOfertas/LICITACION/LIC_DESCRIPCION"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_entrega']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_CONDICIONESENTREGA"/>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_pago']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_CONDICIONESPAGO"/>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_otras']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_OTRASCONDICIONES"/>
			</td>
		</tr>
		<xsl:if test="/AvanceOfertas/LICITACION/LIC_MESESDURACION>0">
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='meses_duracion']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_MESESDURACION"/>
			</td>
		</tr>
		</xsl:if>
		<xsl:if test="/AvanceOfertas/LICITACION/TOTAL_ALAVISTA">
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_alavista']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/AvanceOfertas/LICITACION/TOTAL_ALAVISTA"/><xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/SUFIJO"/>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_aplazado']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/AvanceOfertas/LICITACION/TOTAL_APLAZADO"/><xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/SUFIJO"/>
			</td>
		</tr>
		</xsl:if>
		<xsl:if test="/AvanceOfertas/LICITACION/TOTAL_PEDIDOS">
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_pedidos']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/AvanceOfertas/LICITACION/TOTAL_PEDIDOS"/><xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/SUFIJO"/></strong>
			</td>
		</tr>
		</xsl:if>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_adjudicado']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/AvanceOfertas/LICITACION/LIC_CONSUMOADJUDICADO"/><xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/SUFIJO"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/AvanceOfertas/LICITACION/PRODUCTOSADJUDICADOS"/>/<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_NUMEROLINEAS"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/AvanceOfertas/LICITACION/LIC_PROVEEDORESADJUDICADOS"/>/<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_NUMEROPROVEEDORES"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro']/node()"/> (%):&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_AHORROADJUDICADO"/>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/AvanceOfertas/LICITACION/LIC_AHORROADJUDICADO_TOT"/><xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/SUFIJO"/>
				&nbsp;(<xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/AvanceOfertas/LICITACION/LIC_CONSUMOHISTADJUDICADO"/><xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/SUFIJO"/>)
			</td>
		</tr>
	</table><!--fin de tala datos generales-->
	<br/>
	<br/>
	<br/>
</div><!--fin de divLeft-->
<div class="divLeft">
	<input type="hidden" name="IDLicitacion" value="{/AvanceOfertas/LICITACION/LIC_ID}"/>		<!--	para el JS	-->
	<input type="hidden" name="LIC_ID" value="{/AvanceOfertas/LICITACION/LIC_ID}"/>				<!--	se utiliza en el XSQL		-->
	<input type="hidden" name="IDCentro" value="{/AvanceOfertas/LICITACION/IDCENTRO}"/>
	<input type="hidden" name="ACCION" value=""/>
	<input type="hidden" name="PARAMETROS" value=""/>
	<table class="buscador">
	<thead>
		<tr class="subTituloTabla">
			<td class="uno">&nbsp;</td>
			<td class="tres"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></strong></td>
			<td class="*" style="text-align:left;">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></strong></td>
			<td class="tres"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></strong></td>
			<td class="tres"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='marcas']/node()"/></strong></td>
			<td class="tres"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></strong></td>
			<td class="tres"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></strong></td>
			<td class="tres"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='num_ofertas']/node()"/></strong></td>
			<td class="tres"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ref']/node()"/></strong></td>
			<td class="tres"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_medio']/node()"/></strong></td>
			<td class="tres"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='mejor_precio']/node()"/></strong></td>
			<td class="tres"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/></strong></td>
			<td class="*" style="text-align:left;">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></strong></td>
			<td class="cinco"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='embalaje']/node()"/></strong></td>
			<td class="cinco"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></strong></td>
			<td class="uno">&nbsp;</td>
		</tr>
	</thead>
	<tbody>
		<xsl:for-each select="/AvanceOfertas/LICITACION/PRODUCTOS/PRODUCTO">
			<tr>
				<xsl:attribute name="class">
				<xsl:choose>
				<xsl:when test="OFERTA/COLOR='Rojo'">
					fondoRojo
				</xsl:when>
				<xsl:when test="OFERTA/COLOR='Ambar'">
					fondoAmbar
				</xsl:when>
				<xsl:otherwise>
					verde
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
					<strong><a href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/AvanceOfertas/LICITACION/LIC_ID}">
					<xsl:value-of select="LIC_PROD_NOMBRE"/></a></strong>
				</td>
				<td><xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>
				<td><xsl:value-of select="LIC_PROD_MARCASACEPTABLES"/></td>
				<td class="datosRight"><xsl:value-of select="LIC_PROD_CANTIDAD"/>&nbsp;</td>
				<td class="datosRight"><strong><xsl:value-of select="LIC_PROD_CONSUMOHISTORICO"/>&nbsp;</strong></td>
				<td class="datosRight"><strong><xsl:value-of select="LIC_PROD_NUMEROOFERTAS"/>&nbsp;</strong></td>
				<td class="datosRight"><xsl:value-of select="LIC_PROD_PRECIOREFERENCIA"/>&nbsp;</td>
				<td class="datosRight"><xsl:value-of select="OFERTA/PRECIOMEDIO"/>&nbsp;</td>
				<td class="datosRight"><xsl:value-of select="OFERTA/LIC_OFE_PRECIO"/>&nbsp;</td>
				<td class="datosRight"><xsl:value-of select="OFERTA/AHORRO"/>%&nbsp;</td>
				<td class="datosLeft">
					<strong><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={OFERTA/IDPROVEEDOR}&amp;ESTADO=CABECERA','Detalle Empresa',100,80,0,0);">
					<xsl:value-of select="OFERTA/PROVEEDOR"/></a></strong>
				</td>
				<td class="datosRight"><xsl:value-of select="OFERTA/LIC_OFE_UNIDADESPORLOTE"/></td>
				<td><xsl:value-of select="OFERTA/LIC_OFE_MARCA"/></td>
				<td>&nbsp;</td>
			</tr>
		</xsl:for-each>
	</tbody>
	</table>
	<br/>
	<br/>
	<xsl:if test="/AvanceOfertas/LICITACION/PRODUCTOS_SIN_OFERTA/PRODUCTO">
	<br/>
	<br/>
	<table class="buscador">
	<thead>
		<tr class="subTituloTabla">
			<td colspan="10" align="center">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='productos_sin_ofertas']/node()"/>
			</td>
		</tr>
		<tr class="gris">
			<td class="cinco">&nbsp;</td>
			<td class="siete"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></strong></td>
			<td class="trenta" style="text-align:left;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></strong></td>
			<td class="quince"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></strong></td>
			<td class="dies"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/></strong></td>
			<xsl:if test="/AvanceOfertas/LICITACION/IDPAIS = 34">
				<td class="cinco"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></strong></td>
			</xsl:if>
			<td class="dies"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></strong></td>
			<td class="dies"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></strong></td>
			<td class="quince">&nbsp;</td>
		</tr>
	</thead>
	<tbody>
	<xsl:for-each select="/AvanceOfertas/LICITACION/PRODUCTOS_SIN_OFERTA/PRODUCTO">
		<tr class="gris">
			<td><xsl:value-of select="CONTADOR"/></td>
			<td><xsl:value-of select="REFERENCIA"/></td>
			<td class="datosLeft">
				<a href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/AvanceOfertas/LICITACION/LIC_ID}">
				<xsl:value-of select="LIC_PROD_NOMBRE"/></a>
			</td>
			<td><xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>
			<td class="datosRight">
			<xsl:if test="/AvanceOfertas/LICITACION/IDPAIS = 55 and LIC_PROD_PRECIO>0">R$&nbsp;</xsl:if>
			<xsl:value-of select="LIC_PROD_PRECIO"/>
			<xsl:if test="/AvanceOfertas/LICITACION/IDPAIS = 34 and LIC_PROD_PRECIO>0">&nbsp;&#128;</xsl:if>&nbsp;
			</td>
			<xsl:if test="/AvanceOfertas/LICITACION/IDPAIS = 34">
				<td><xsl:value-of select="LIC_PROD_TIPOIVA"/>%</td>
			</xsl:if>
			<td class="datosRight"><xsl:value-of select="LIC_PROD_CANTIDAD"/></td>&nbsp;
			<td class="datosRight">
			<xsl:if test="/AvanceOfertas/LICITACION/IDPAIS = 55 and LIC_PROD_CONSUMO>0">R$&nbsp;</xsl:if>
			<xsl:value-of select="LIC_PROD_CONSUMO"/>
			<xsl:if test="/AvanceOfertas/LICITACION/IDPAIS = 34 and LIC_PROD_CONSUMO>0">&nbsp;&#128;</xsl:if>&nbsp;
			</td>
			<td>&nbsp;</td>
		</tr>
	</xsl:for-each>
	</tbody>
	</table>
	</xsl:if>
	<xsl:if test="/AvanceOfertas/LICITACION/PRODUCTOS_JUSTIFICADOS/PRODUCTO">
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
	<xsl:for-each select="/AvanceOfertas/LICITACION/PRODUCTOS_JUSTIFICADOS/PRODUCTO">
		<tr class="gris">
			<td><xsl:value-of select="CONTADOR"/></td>
			<td><xsl:value-of select="REFERENCIA"/></td>
			<td class="datosLeft">
				<a href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/AvanceOfertas/LICITACION/LIC_ID}">
				<xsl:value-of select="LIC_PROD_NOMBRE"/></a>
			</td>
			<td class="datosLeft"><xsl:value-of select="JUSTIFICACION"/><xsl:value-of select="LIC_PROD_MOTIVOSELECCION"/></td>
			<td>&nbsp;</td>
		</tr>
	</xsl:for-each>
	</tbody>
	</table>
	</xsl:if>
	<xsl:if test="/AvanceOfertas/LICITACION/OFERTAS_DESCARTADAS/OFERTA">
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
	<xsl:for-each select="/AvanceOfertas/LICITACION/OFERTAS_DESCARTADAS/OFERTA">
		<tr class="gris">
			<td><xsl:value-of select="CONTADOR"/></td>
			<td class="datosLeft"><xsl:value-of select="PROVEEDOR"/></td>
			<td><xsl:value-of select="REFERENCIA"/></td>
			<td class="datosLeft">
				<a href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/AvanceOfertas/LICITACION/LIC_ID}">
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
	<xsl:if test="/AvanceOfertas/LICITACION/ADJUDICADOS_ELIMINADOS/OFERTA">
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
	<xsl:for-each select="/AvanceOfertas/LICITACION/ADJUDICADOS_ELIMINADOS/OFERTA">
		<tr class="gris">
			<td><xsl:value-of select="CONTADOR"/></td>
			<td class="datosLeft"><xsl:value-of select="PROVEEDOR"/></td>
			<td><xsl:value-of select="REFERENCIA"/></td>
			<td class="datosLeft">
				<a href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/AvanceOfertas/LICITACION/LIC_ID}">
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
</div><!--fin de divLeft-->

</xsl:template>

</xsl:stylesheet>
