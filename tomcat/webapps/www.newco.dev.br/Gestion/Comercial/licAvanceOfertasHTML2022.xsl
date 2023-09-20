<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Avance de las ofertas de la licitacion
	Ultima revision ET 31mar22 12:36 licAvanceOfertas2022_310322.js
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

	<!--	11ene22 nuevos estilos -->
	<!--<link rel="stylesheet" href="http://www.newco.dev.br/General/basicMVM2022.css"/>-->
	<link href='http://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'/>
	<!--	11ene22 nuevos estilos -->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>		<!-- Para descargas excel	-->
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/licAvanceOfertas2022_310322.js"></script>
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
		<xsl:if test="/AvanceOfertas/LICITACION/LIC_AGREGADA = 'S'">
			<p class="TituloPagina">
				&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/AvanceOfertas/LICITACION/CENTROSCOMPRAS/field"/>
					<xsl:with-param name="onChange">javascript:document.forms[0].submit();</xsl:with-param>
					<xsl:with-param name="claSel">w300px;</xsl:with-param>
				</xsl:call-template>
			</p>
		</xsl:if>
		<p class="TituloPagina">
			<a id="botonLicitacion" href="javascript:AbrirLicitacion({/AvanceOfertas/LICITACION/LIC_ID});"><xsl:value-of select="/AvanceOfertas/LICITACION/LIC_CODIGO"/>:&nbsp;<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_TITULO"/></a>
			<span class="CompletarTitulo" style="width:400px;">
				<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/licOfertasSeleccionadas2022.xsql?LIC_ID={/AvanceOfertas/LIC_ID}"><xsl:value-of select="document($doc)/translation/texts/item[@name='Vencedores']/node()"/></a>
				&nbsp;
				<a class="btnNormal" href="javascript:window.print();"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
				&nbsp;
				<a class="btnNormal" href="javascript:DescargarExcel();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/>
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
	<table cellspacing="6px" cellpadding="6px">
		<tr>
			<td class="labelRight" style="width:25%;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_informe']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<xsl:value-of select="/AvanceOfertas/LICITACION/FECHAACTUAL"/>
			</td>
		</tr>
		<tr>
			<td class="labelRight" style="width:25%;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_FECHADECISIONPREVISTA"/>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_DESCRIPCION"/>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_entrega']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_CONDICIONESENTREGA"/>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_pago']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_CONDICIONESPAGO"/>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_otras']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_OTRASCONDICIONES"/>
			</td>
		</tr>
		<xsl:if test="/AvanceOfertas/LICITACION/LIC_MESESDURACION>0">
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='meses_duracion']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_MESESDURACION"/>
			</td>
		</tr>
		</xsl:if>
		<xsl:if test="/AvanceOfertas/LICITACION/TOTAL_ALAVISTA">
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_alavista']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/AvanceOfertas/LICITACION/TOTAL_ALAVISTA"/><xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/SUFIJO"/>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_aplazado']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/AvanceOfertas/LICITACION/TOTAL_APLAZADO"/><xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/SUFIJO"/>
			</td>
		</tr>
		</xsl:if>
		<xsl:if test="/AvanceOfertas/LICITACION/TOTAL_PEDIDOS">
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_pedidos']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/AvanceOfertas/LICITACION/TOTAL_PEDIDOS"/><xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/SUFIJO"/>
			</td>
		</tr>
		</xsl:if>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_adjudicado']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/AvanceOfertas/LICITACION/LIC_CONSUMOADJUDICADO"/><xsl:value-of select="/AvanceOfertas/LICITACION/DIVISA/SUFIJO"/>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<xsl:value-of select="/AvanceOfertas/LICITACION/PRODUCTOSADJUDICADOS"/>/<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_NUMEROLINEAS"/>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_PROVEEDORESADJUDICADOS"/>/<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_NUMEROPROVEEDORES"/>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro']/node()"/> (%):&nbsp;
			</td>
			<td class="textLeft">
				<xsl:value-of select="/AvanceOfertas/LICITACION/LIC_AHORROADJUDICADO"/>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
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
	<div class="tabela tabela_redonda">
	<table cellspacing="6px" cellpadding="6px">
	<thead class="cabecalho_tabela">
		<tr>
			<th class="w1px">&nbsp;</th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
			<th class="textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='marcas']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='num_ofertas']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ref']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_medio']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='mejor_precio']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/></th>
			<th class="textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='embalaje']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></th>
			<th class="w1px">&nbsp;</th>
		</tr>
	</thead>
	<tbody class="corpo_tabela">
		<xsl:for-each select="/AvanceOfertas/LICITACION/PRODUCTOS/PRODUCTO">
			<tr>
				<xsl:attribute name="class">
				<xsl:choose>
				<xsl:when test="OFERTA/COLOR='Rojo'">
					conhover fondoRojo
				</xsl:when>
				<xsl:when test="OFERTA/COLOR='Ambar'">
					conhover fondoNaranja
				</xsl:when>
				<xsl:otherwise>
					conhover verde
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
					<a href="javascript:chFichaProductoLicitacion({/AvanceOfertas/LICITACION/LIC_ID},{LIC_PROD_ID});"><xsl:value-of select="LIC_PROD_NOMBRE"/></a>
				</td>
				<td><xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>
				<td><xsl:value-of select="LIC_PROD_MARCASACEPTABLES"/></td>
				<td class="textRight"><xsl:value-of select="LIC_PROD_CANTIDAD"/>&nbsp;</td>
				<td class="textRight"><xsl:value-of select="LIC_PROD_CONSUMOHISTORICO"/>&nbsp;</td>
				<td class="textRight"><xsl:value-of select="LIC_PROD_NUMEROOFERTAS"/>&nbsp;</td>
				<td class="textRight"><xsl:value-of select="LIC_PROD_PRECIOREFERENCIA"/>&nbsp;</td>
				<td class="textRight"><xsl:value-of select="OFERTA/PRECIOMEDIO"/>&nbsp;</td>
				<td class="textRight"><xsl:value-of select="OFERTA/LIC_OFE_PRECIO"/>&nbsp;</td>
				<td class="textRight"><xsl:value-of select="OFERTA/AHORRO"/>%&nbsp;</td>
				<td class="textLeft">
					<a href="javascript:FichaEmpresa('{OFERTA/IDPROVEEDOR}&amp;ESTADO=CABECERA');">
					<xsl:value-of select="OFERTA/PROVEEDOR"/></a>
				</td>
				<td class="textRight"><xsl:value-of select="OFERTA/LIC_OFE_UNIDADESPORLOTE"/></td>
				<td><xsl:value-of select="OFERTA/LIC_OFE_MARCA"/></td>
				<td>&nbsp;</td>
			</tr>
		</xsl:for-each>
	</tbody>
	<tfoot class="rodape_tabela">
		<tr><td colspan="16">&nbsp;</td></tr>
	</tfoot>
	</table>
	</div>
	<br/>
	<br/>
	<xsl:if test="/AvanceOfertas/LICITACION/PRODUCTOS_SIN_OFERTA/PRODUCTO">
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
			<xsl:if test="/AvanceOfertas/LICITACION/IDPAIS = 34">
				<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></th>
			</xsl:if>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></th>
			<th>&nbsp;</th>
		</tr>
	</thead>
	<tbody class="corpo_tabela">
	<xsl:for-each select="/AvanceOfertas/LICITACION/PRODUCTOS_SIN_OFERTA/PRODUCTO">
		<tr class="conhover">
			<td class="color_status"><xsl:value-of select="CONTADOR"/></td>
			<td><xsl:value-of select="REFERENCIA"/></td>
			<td class="textLeft">
				<a href="javascript:chFichaProductoLicitacion({/AvanceOfertas/LICITACION/LIC_ID},{LIC_PROD_ID});"><xsl:value-of select="LIC_PROD_NOMBRE"/></a>
			</td>
			<td><xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>
			<td class="textRight">
			<xsl:if test="/AvanceOfertas/LICITACION/IDPAIS = 55 and LIC_PROD_PRECIO>0">R$&nbsp;</xsl:if>
			<xsl:value-of select="LIC_PROD_PRECIO"/>
			<xsl:if test="/AvanceOfertas/LICITACION/IDPAIS = 34 and LIC_PROD_PRECIO>0">&nbsp;&#128;</xsl:if>&nbsp;
			</td>
			<xsl:if test="/AvanceOfertas/LICITACION/IDPAIS = 34">
				<td><xsl:value-of select="LIC_PROD_TIPOIVA"/>%</td>
			</xsl:if>
			<td class="textRight"><xsl:value-of select="LIC_PROD_CANTIDAD"/></td>&nbsp;
			<td class="textRight">
			<xsl:if test="/AvanceOfertas/LICITACION/IDPAIS = 55 and LIC_PROD_CONSUMO>0">R$&nbsp;</xsl:if>
			<xsl:value-of select="LIC_PROD_CONSUMO"/>
			<xsl:if test="/AvanceOfertas/LICITACION/IDPAIS = 34 and LIC_PROD_CONSUMO>0">&nbsp;&#128;</xsl:if>&nbsp;
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
	<xsl:if test="/AvanceOfertas/LICITACION/PRODUCTOS_JUSTIFICADOS/PRODUCTO">
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
	<xsl:for-each select="/AvanceOfertas/LICITACION/PRODUCTOS_JUSTIFICADOS/PRODUCTO">
		<tr class="conhover">
			<td class="color_status"><xsl:value-of select="CONTADOR"/></td>
			<td><xsl:value-of select="REFERENCIA"/></td>
			<td class="textLeft">
				<a href="javascript:chFichaProductoLicitacion({/AvanceOfertas/LICITACION/LIC_ID},{LIC_PROD_ID});"><xsl:value-of select="LIC_PROD_NOMBRE"/></a>
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
	<xsl:if test="/AvanceOfertas/LICITACION/OFERTAS_DESCARTADAS/OFERTA">
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
	<xsl:for-each select="/AvanceOfertas/LICITACION/OFERTAS_DESCARTADAS/OFERTA">
		<tr class="conhover">
			<td class="color_status"><xsl:value-of select="CONTADOR"/></td>
			<td><xsl:value-of select="REFERENCIA"/></td>
			<td class="textLeft"><xsl:value-of select="PROVEEDOR"/></td>
			<td class="textLeft">
				<a href="javascript:chFichaProductoLicitacion({/AvanceOfertas/LICITACION/LIC_ID},{LIC_PROD_ID});"><xsl:value-of select="LIC_PROD_NOMBRE"/></a>
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
	<xsl:if test="/AvanceOfertas/LICITACION/ADJUDICADOS_ELIMINADOS/OFERTA">
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
	<xsl:for-each select="/AvanceOfertas/LICITACION/ADJUDICADOS_ELIMINADOS/OFERTA">
		<tr class="conhover">
			<td><xsl:value-of select="CONTADOR"/></td>
			<td class="textLeft"><xsl:value-of select="PROVEEDOR"/></td>
			<td><xsl:value-of select="REFERENCIA"/></td>
			<td class="textLeft">
				<a href="javascript:chFichaProductoLicitacion({/AvanceOfertas/LICITACION/LIC_ID},{LIC_PROD_ID});"><xsl:value-of select="LIC_PROD_NOMBRE"/></a>
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
</div><!--fin de divLeft-->

</xsl:template>

</xsl:stylesheet>
