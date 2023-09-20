<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Ficha con las ofertas seleccionadas, "Vencedores"	
	Ultima revision: ET 01abr22 10:50 licInformePedidos2022_010422.js
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
			<xsl:when test="/InformePedidos/LANG"><xsl:value-of select="/InformePedidos/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<meta http-equiv="Cache-Control" content="no-cache"/>

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Informe_pedidos_licitacion']/node()"/>:&nbsp;<xsl:value-of select="/InformePedidos/LICITACION/LIC_TITULO"/></title>

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
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/licInformePedidos2022_010422.js"></script>
	<script type="text/javascript">
	
	var arrProveedores			= new Array();
	<xsl:for-each select="/InformePedidos/LICITACION/PROVEEDORES/PROVEEDOR">
		var Proveedor			= [];
		
		Proveedor['ID']	= '<xsl:value-of select="IDPROVEEDOR"/>';
		Proveedor['IDCentro']	= '<xsl:value-of select="IDCENTRO"/>';					//	IMPORTANTE para multicentro
		Proveedor['IDProvLic']	= '<xsl:value-of select="IDPROVEEDOR_LIC"/>';
		Proveedor['Nombre']	= '<xsl:value-of select="NOMBRECORTO"/>';
		Proveedor['LicProvPedMin']	= '<xsl:value-of select="LIC_PROV_PEDIDOMINIMO"/>';
		Proveedor['Total']	= '<xsl:value-of select="LIC_PROV_CONSUMO"/>';
		
		Proveedor['PedidoMinimo']	= '<xsl:value-of select="LIC_PROV_PEDIDOMINIMO"/>';
		Proveedor['PlazoPago']	= '<xsl:value-of select="PEDIDOS/PLAZOPAGO"/>';
		Proveedor['FormaPago']	= '<xsl:value-of select="PEDIDOS/FORMAPAGO"/>';
		Proveedor['PlazoEntrega']	= '<xsl:value-of select="LIC_PROV_PLAZOENTREGA"/>';
		Proveedor['Frete']	= '<xsl:value-of select="LIC_PROV_FRETE"/>';

		Proveedor['Pedidos']	= new Array();
		<xsl:for-each select="PEDIDOS/PEDIDO">
			var pedido		= [];
			pedido['Contador']		= '<xsl:value-of select="CONTADOR"/>';
			pedido['Numero']		= '<xsl:value-of select="MO_NUMEROCLINICA"/>';
			pedido['Total']		= '<xsl:value-of select="MO_IMPORTETOTAL"/>';
			pedido['CentroCliente']	= '<xsl:value-of select="CENTROCLIENTE"/>';

			pedido['Ofertas']	= new Array();
			<xsl:for-each select="OFERTA">
					var oferta		= [];
					oferta['Nombre']		= '<xsl:value-of select="LIC_PROD_NOMBRE"/>';
					oferta['IDoferta']		= '<xsl:value-of select="LIC_PROD_ID"/>';
					oferta['IDProdEstandar']= '<xsl:value-of select="LIC_PROD_IDPRODESTANDAR"/>';
					oferta['Referencia']	= '<xsl:value-of select="PRO_REFERENCIA"/>';
					oferta['Refestandar']	= '<xsl:value-of select="LIC_PROD_REFESTANDAR"/>';
					oferta['RefCliente']	= '<xsl:value-of select="LIC_PROD_REFCLIENTE"/>';
					oferta['UdsXLote']		= '<xsl:value-of select="LIC_OFE_UNIDADESPORLOTE"/>';
					oferta['UdBasica']		= '<xsl:value-of select="LIC_PROD_UNIDADBASICA"/>';
					oferta['Marca']			= '<xsl:value-of select="LIC_OFE_MARCA"/>';
					oferta['PrecioRef']		= '<xsl:value-of select="LIC_PROD_PRECIOREFERENCIA"/>';

					oferta['IDCentroProv']	= '<xsl:value-of select="IDCENTROPROVEEDOR"/>';
					oferta['CentroProv']	= '<xsl:value-of select="CENTROPROVEEDOR"/>';

					oferta['Cantidad']		= '<xsl:value-of select="CANTIDAD"/>';
					oferta['Tarifa']		= '<xsl:value-of select="LMO_PRECIO"/>';
					oferta['TotalLinea']	= '<xsl:value-of select="CONSUMO"/>';
					oferta['Ahorro']		= '<xsl:value-of select="AHORRO"/>';
		
				pedido['Ofertas'].push(oferta);
			</xsl:for-each>
			
		Proveedor['Pedidos'].push(pedido);
		</xsl:for-each>
		arrProveedores.push(Proveedor);
	</xsl:for-each>
	
	//	Cadenas para el CSV
	var strTitulo='<xsl:value-of select="/InformePedidos/LICITACION/LIC_TITULO"/>';

	var strFechaInforme='<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_informe']/node()"/>';
	var FechaInforme='<xsl:value-of select="/InformePedidos/LICITACION/FECHAACTUAL"/>';

	var strFechaDecision='<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/>';
	var FechaDecision='<xsl:value-of select="/InformePedidos/LICITACION/LIC_FECHADECISIONPREVISTA"/>';

	var strDescripcion='<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>';
	var Descripcion='<xsl:value-of select="/InformePedidos/LICITACION/LIC_DESCRIPCION"/>';
	
	var strCondEntrega='<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_entrega']/node()"/>';
	var CondEntrega='<xsl:value-of select="/InformePedidos/LICITACION/LIC_CONDICIONESENTREGA"/>';
	
	var strCondPago='<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_pago']/node()"/>';
	var CondPago='<xsl:value-of select="/InformePedidos/LICITACION/LIC_CONDICIONESPAGO"/>';
	
	var strCondOtras='<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_otras']/node()"/>';
	var CondOtras='<xsl:value-of select="/InformePedidos/LICITACION/LIC_OTRASCONDICIONES"/>';
	
	var strMesesDuracion='<xsl:value-of select="document($doc)/translation/texts/item[@name='meses_duracion']/node()"/>';
	var MesesDuracion=<xsl:value-of select="/InformePedidos/LICITACION/LIC_MESESDURACION"/>;
	
	var chkTotal='<xsl:value-of select="/InformePedidos/LICITACION/TOTAL_ALAVISTA"/>';
	
	var strTotalALaVista='<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_alavista']/node()"/>';
	var TotalALaVista='<xsl:value-of select="/InformePedidos/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/InformePedidos/LICITACION/TOTAL_ALAVISTA"/><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/SUFIJO"/>';
	
	var strTotalAplazado='<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_aplazado']/node()"/>';
	var TotalAplazado='<xsl:value-of select="/InformePedidos/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/InformePedidos/LICITACION/TOTAL_APLAZADO"/><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/SUFIJO"/>';

	var chkTotalPedidos='<xsl:value-of select="/InformePedidos/LICITACION/TOTAL_PEDIDOS"/>';

	var strTotalPedidos='<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_pedidos']/node()"/>';
	var TotalPedidos='<xsl:value-of select="/InformePedidos/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/InformePedidos/LICITACION/TOTAL_PEDIDOS"/><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/SUFIJO"/>';
	
	var strTotalAdjudicado='<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_adjudicado']/node()"/>';
	var TotalAdjudicado='<xsl:value-of select="/InformePedidos/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/InformePedidos/LICITACION/LIC_CONSUMOADJUDICADO"/><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/SUFIJO"/>';
	
	var strProductos='<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>';
	var Productos='<xsl:value-of select="/InformePedidos/LICITACION/PRODUCTOSADJUDICADOS"/>/<xsl:value-of select="/InformePedidos/LICITACION/LIC_NUMEROLINEAS"/>';

	var strProveedores='<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>';
	var Proveedores='<xsl:value-of select="/InformePedidos/LICITACION/LIC_PROVEEDORESADJUDICADOS"/>/<xsl:value-of select="/InformePedidos/LICITACION/LIC_NUMEROPROVEEDORES"/>';
	
	var strAhorroPorc='<xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro']/node()"/> (%)';
	var AhorroPorc='<xsl:value-of select="/InformePedidos/LICITACION/LIC_AHORROADJUDICADO"/>';
	
	var strAhorro='<xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro']/node()"/>';
	var Ahorro='<xsl:value-of select="/InformePedidos/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/InformePedidos/LICITACION/LIC_AHORROADJUDICADO_TOT"/><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/SUFIJO"/>';

	var strProveedor='<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>';
	var strCabeceraExcel='<xsl:value-of select="document($doc)/translation/texts/item[@name='Cabecera_CSV_vencedores']/node()"/>';


	var strPedidoMinimo='<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/>';
	var strPlazoPago='<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_pago']/node()"/>';
	var strFormaPago='<xsl:value-of select="document($doc)/translation/texts/item[@name='forma_pago']/node()"/>';
	var strPlazoEntrega='<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/>';
	var strFrete='<xsl:value-of select="document($doc)/translation/texts/item[@name='frete']/node()"/>';
	var strCentroCliente='<xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_cliente']/node()"/>';
	var strPedido='<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>';
	var strTotal='<xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>';
	</script>
</head>
<body class="gris">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/InformePedidos/LANG"><xsl:value-of select="/InformePedidos/LANG"/></xsl:when>
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
			<xsl:when test="/InformePedidos/LANG"><xsl:value-of select="/InformePedidos/LANG"/></xsl:when>
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
		<xsl:when test="/InformePedidos/LANG"><xsl:value-of select="/InformePedidos/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<div class="divLeft">

	<form method="post">

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:value-of select="/InformePedidos/LICITACION/LIC_CODIGO"/>:&nbsp;<xsl:value-of select="/InformePedidos/LICITACION/LIC_TITULO"/>
			<span class="CompletarTitulo">
				<a class="btnNormal" href="javascript:DescargarExcel();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/>
				</a>
				&nbsp;
				<a class="btnNormal" href="javascript:window.print();"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
				&nbsp;
				<a class="btnNormal" style="text-decoration:none;"  href="javascript:window.close()"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>
				&nbsp;
			</span>
		</p>
	</div>
	</form>
	<br/>
	<br/>
	<br/>
	<table cellspacing="6px" cellpadding="6px">
		<tr>
			<td class="labelRight w25">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_informe']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<strong><xsl:value-of select="/InformePedidos/LICITACION/FECHAACTUAL"/></strong>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<strong><xsl:value-of select="/InformePedidos/LICITACION/LIC_FECHADECISIONPREVISTA"/></strong>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<strong><xsl:value-of select="/InformePedidos/LICITACION/LIC_DESCRIPCION"/></strong>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_entrega']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<xsl:value-of select="/InformePedidos/LICITACION/LIC_CONDICIONESENTREGA"/>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_pago']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<xsl:value-of select="/InformePedidos/LICITACION/LIC_CONDICIONESPAGO"/>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_otras']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<xsl:value-of select="/InformePedidos/LICITACION/LIC_OTRASCONDICIONES"/>
			</td>
		</tr>
		<xsl:if test="/InformePedidos/LICITACION/LIC_MESESDURACION>0">
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='meses_duracion']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<xsl:value-of select="/InformePedidos/LICITACION/LIC_MESESDURACION"/>
			</td>
		</tr>
		</xsl:if>
		<xsl:if test="/InformePedidos/LICITACION/TOTAL_ALAVISTA">
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_alavista']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<xsl:value-of select="/InformePedidos/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/InformePedidos/LICITACION/TOTAL_ALAVISTA"/><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/SUFIJO"/>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_aplazado']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<xsl:value-of select="/InformePedidos/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/InformePedidos/LICITACION/TOTAL_APLAZADO"/><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/SUFIJO"/>
			</td>
		</tr>
		</xsl:if>
		<xsl:if test="/InformePedidos/LICITACION/TOTAL_PEDIDOS">
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_pedidos']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<strong><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/InformePedidos/LICITACION/TOTAL_PEDIDOS"/><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/SUFIJO"/></strong>
			</td>
		</tr>
		</xsl:if>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_adjudicado']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<strong><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/InformePedidos/LICITACION/LIC_CONSUMOADJUDICADO"/><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/SUFIJO"/></strong>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<strong><xsl:value-of select="/InformePedidos/LICITACION/PRODUCTOSADJUDICADOS"/>/<xsl:value-of select="/InformePedidos/LICITACION/LIC_NUMEROLINEAS"/></strong>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<strong><xsl:value-of select="/InformePedidos/LICITACION/LIC_PROVEEDORESADJUDICADOS"/>/<xsl:value-of select="/InformePedidos/LICITACION/LIC_NUMEROPROVEEDORES"/></strong>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro']/node()"/> (%):&nbsp;
			</td>
			<td class="textLeft">
				<xsl:value-of select="/InformePedidos/LICITACION/LIC_AHORROADJUDICADO"/>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<xsl:value-of select="/InformePedidos/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/InformePedidos/LICITACION/LIC_AHORROADJUDICADO_TOT"/><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/SUFIJO"/>
			</td>
		</tr>
	</table><!--fin de tala datos generales-->
	<br/>
	<br/>
	<br/>
</div><!--fin de divLeft-->

<div class="divLeft">
	<form id="Proveedores" name="Proveedores" action="http://www.newco.dev.br/Gestion/Comercial/licInformePedidos2022.xsql" method="POST">
	<input type="hidden" name="IDLicitacion" value="{/InformePedidos/LICITACION/LIC_ID}"/>		<!--	para el JS	-->
	<input type="hidden" name="LIC_ID" value="{/InformePedidos/LICITACION/LIC_ID}"/>				<!--	se utiliza en el XSQL		-->
	<input type="hidden" name="IDCentro" value="{/InformePedidos/LICITACION/IDCENTRO}"/>
	<input type="hidden" name="ACCION" value=""/>
	<input type="hidden" name="PARAMETROS" value=""/>
	<xsl:for-each select="/InformePedidos/LICITACION/PROVEEDORES/PROVEEDOR/PEDIDOS/PEDIDO">
	<table class="w80 fondoGris tableCenter" cellspacing="10px" cellpadding="10px">
	<tbody>
		<tr>
			<xsl:choose>
			<xsl:when test="NO_CUMPLE_PEDIDO_MINIMO">
				<xsl:attribute name="class">subTituloFondoRojo</xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="class">subTituloTabla</xsl:attribute>
			</xsl:otherwise>
			</xsl:choose>
			
			<td colspan="11" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;		
			<xsl:if test="/InformePedidos/LICITACION/LIC_AGREGADA='S'">
				&nbsp;<xsl:value-of select="CENTROCLIENTE"/>:&nbsp;
			</xsl:if>
			<xsl:value-of select="../../EMP_NIF"/>&nbsp;&nbsp;
			<xsl:if test="../../DATOSPRIVADOS/COP_CODIGO  != '' ">
				&nbsp;(<xsl:value-of select="../../DATOSPRIVADOS/COP_CODIGO"/>)&nbsp;
			</xsl:if>
			<a href="javascript:FichaEmpresa({../../IDPROVEEDOR}&amp;ESTADO=CABECERA');">
			<xsl:value-of select="../../NOMBRECORTO"/>
			</a>
			&nbsp;
			<xsl:if test="/InformePedidos/LICITACION/AUTOR">
			<a href="javascript:conversacionProveedor({IDPROVEEDOR});" style="text-decoration:none;"><img>
				<xsl:attribute name="src">
				<xsl:choose>
				<xsl:when test="EXISTE_CONVERSACION">http://www.newco.dev.br/images/bocadillo.gif</xsl:when>
				<xsl:otherwise>http://www.newco.dev.br/images/bocadilloPlus.gif</xsl:otherwise>
				</xsl:choose>
				</xsl:attribute>
			</img>
			</a>
			&nbsp;
			</xsl:if>
			<xsl:if test="../../DATOSPRIVADOS/COP_NOMBREBANCO  != '' ">
				&nbsp;(<xsl:value-of select="document($doc)/translation/texts/item[@name='Cuenta_bancaria']/node()"/>:&nbsp;
					<xsl:value-of select="../../DATOSPRIVADOS/COP_NOMBREBANCO"/>&nbsp;<xsl:value-of select="../../DATOSPRIVADOS/COP_CODBANCO"/>&nbsp;<xsl:value-of select="../../DATOSPRIVADOS/COP_CODOFICINA"/>&nbsp;<xsl:value-of select="../../DATOSPRIVADOS/COP_CODCUENTA"/>)&nbsp;
			</xsl:if>
			&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/>:&nbsp;<xsl:value-of select="/InformePedidos/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="../../LIC_PROV_PEDIDOMINIMO"/><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/SUFIJO"/>
			&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:&nbsp;<xsl:value-of select="/InformePedidos/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="../../LIC_PROV_CONSUMOADJUDICADO"/><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/SUFIJO"/>
			&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>:&nbsp;<xsl:value-of select="NUMERO_PRODUCTOS"/>
			&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>:
			&nbsp;<a href="javascript:FichaPedido({MO_ID})"><xsl:value-of select="MO_NUMEROCLINICA"/>&nbsp;(<xsl:value-of select="/InformePedidos/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="MO_IMPORTETOTAL"/><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/SUFIJO"/>)</a>
			</td>
		</tr>
		<!--14may19	<tr class="subTituloTabla">-->
		<xsl:if test="../../LIC_PROV_COMENTARIOSPROV!=''">
			<tr>
				<td colspan="9" align="center">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones']/node()"/>:&nbsp;<xsl:value-of select="../../LIC_PROV_COMENTARIOSPROV"/>
				</td>
			</tr>
		</xsl:if>
		<tr>
			<td colspan="9" align="center">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/>:&nbsp;<xsl:value-of select="../../LIC_PROV_PLAZOENTREGA"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='dias']/node()"/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='forma_pago']/node()"/>:&nbsp;
				<xsl:value-of select="../FORMAPAGO"/>.&nbsp;<xsl:value-of select="../PLAZOPAGO"/>.
			</td>
			<td align="left">
				<a class="btnNormal" href="javascript:OfertaProveedorLicitacion({/InformePedidos/LICITACION/LIC_ID},{IDPROVEEDOR_LIC});"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_ofertas']/node()"/></a>
			</td>
		</tr>
		</tbody>
	</table>
	<br/>
	<br/>
	<div class="tabela tabela_redonda">
	<table cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
		<tr>
			<th class="w1px">&nbsp;</th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
			<th class="textleft"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></th>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></th>
			<xsl:if test="/InformePedidos/LICITACION/IDPAIS != 55">
				<th class="w80px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/></th>
			</xsl:if>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/></th>
			<xsl:if test="/InformePedidos/LICITACION/IDPAIS = 34">
				<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></th>
			</xsl:if>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='embalaje']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></th>
			<th class="w50px fondogris"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ref']/node()"/></th>
			<th class="w50px fondogris"><xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/></th>
			<th class="w1px">&nbsp;</th>
		</tr>
	</thead>
	<tbody class="corpo_tabela">
		<xsl:for-each select="OFERTA">
			<tr>
				<xsl:attribute name="class">
				<xsl:choose>
				<xsl:when test="NO_CUADRAN_UNIDADES">
					fondoRojo conhover
				</xsl:when>
				<xsl:otherwise>
					conhover
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
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/InformePedidos/LICITACION/LIC_ID}');">
					<xsl:value-of select="LIC_PROD_NOMBRE"/><xsl:if test="LIC_PROD_MARCASACEPTABLES != ''">&nbsp;[<xsl:value-of select="LIC_PROD_MARCASACEPTABLES"/>]</xsl:if></a>
				</td>
				<td><xsl:value-of select="LIC_OFE_MARCA"/></td>
				<td><xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>
				<xsl:if test="/InformePedidos/LICITACION/IDPAIS != 55">
					<td><xsl:value-of select="LIC_OFE_REFERENCIA"/></td>
				</xsl:if>
				<td class="textRight">
					<xsl:value-of select="/InformePedidos/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="LMO_PRECIO"/><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/SUFIJO"/>
				<!--
				<xsl:if test="/InformePedidos/LICITACION/IDPAIS = 55">R$&nbsp;</xsl:if>
				<xsl:value-of select="LIC_OFE_PRECIO"/>
				<xsl:if test="/InformePedidos/LICITACION/IDPAIS = 34">&nbsp;&#128;</xsl:if>&nbsp;
				-->
				</td>
				<xsl:if test="/InformePedidos/LICITACION/IDPAIS != 55">
					<td><xsl:value-of select="LIC_OFE_TIPOIVA"/>%</td>
				</xsl:if>
				<td><xsl:value-of select="LMO_UNIDADESPORLOTE"/></td>
				<td>
					<xsl:if test="CAMBIO_CANTIDAD">
						(<xsl:value-of select="CAMBIO_CANTIDAD/CANTIDADORIGINAL"/>-><xsl:value-of select="CAMBIO_CANTIDAD/CANTIDAD"/>)&nbsp;
					</xsl:if>
					<strong><xsl:value-of select="CANTIDAD"/></strong>&nbsp;
				</td>
				<td class="textRight">
					<xsl:value-of select="/InformePedidos/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="CONSUMO"/><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/SUFIJO"/>
				</td>
				<td class="textRight fondogris">
					<xsl:value-of select="/InformePedidos/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="LIC_PROD_PRECIOREFERENCIA"/><xsl:value-of select="/InformePedidos/LICITACION/DIVISA/SUFIJO"/>
				</td>
				<td class="textRight fondogris">
					<xsl:value-of select="AHORRO"/>%
				</td>
				<td class="uno">&nbsp;</td>
			</tr>
		</xsl:for-each>
	</tbody>
	<tfoot class="rodape_tabela">
		<tr><td colspan="14">&nbsp;</td></tr>
	</tfoot>
	</table>
	</div>
	<br/>
	<br/>
	<br/>
	<br/>
	</xsl:for-each>
	<xsl:if test="/InformePedidos/LICITACION/PRODUCTOS_SIN_OFERTA/PRODUCTO">
	<br/>
	<br/>
    <div class="divLeft textCenter marginTop50">
		<span class="tituloTabla"><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_no_seleccionados']/node()"/></span>
	</div>
	<div class="tabela tabela_redonda">
	<table cellspacing="6px" cellpadding="6px">
	<thead>
		<tr>
			<th class="w1px">&nbsp;</th>
			<th class="w80px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
			<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></th>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/></th>
			<xsl:if test="/InformePedidos/LICITACION/IDPAIS = 34">
				<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></th>
			</xsl:if>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></th>
			<th>&nbsp;</th>
		</tr>
	</thead>
	<tbody>
	<xsl:for-each select="/InformePedidos/LICITACION/PRODUCTOS_SIN_OFERTA/PRODUCTO">
		<tr class="conhover">
			<td class="color_status"><xsl:value-of select="CONTADOR"/></td>
			<td><xsl:value-of select="REFERENCIA"/></td>
			<td class="textLeft">
				<a href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/InformePedidos/LICITACION/LIC_ID}">
				<xsl:value-of select="LIC_PROD_NOMBRE"/></a>
			</td>
			<td><xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>
			<td class="textRight">
			<xsl:if test="/InformePedidos/LICITACION/IDPAIS = 55 and LIC_PROD_PRECIO>0">R$&nbsp;</xsl:if>
			<xsl:value-of select="LIC_PROD_PRECIO"/>
			<xsl:if test="/InformePedidos/LICITACION/IDPAIS = 34 and LIC_PROD_PRECIO>0">&nbsp;&#128;</xsl:if>&nbsp;
			</td>
			<xsl:if test="/InformePedidos/LICITACION/IDPAIS = 34">
				<td><xsl:value-of select="LIC_PROD_TIPOIVA"/>%</td>
			</xsl:if>
			<td class="textRight"><xsl:value-of select="LIC_PROD_CANTIDAD"/></td>&nbsp;
			<td class="textRight">
			<xsl:if test="/InformePedidos/LICITACION/IDPAIS = 55 and LIC_PROD_CONSUMO>0">R$&nbsp;</xsl:if>
			<xsl:value-of select="LIC_PROD_CONSUMO"/>
			<xsl:if test="/InformePedidos/LICITACION/IDPAIS = 34 and LIC_PROD_CONSUMO>0">&nbsp;&#128;</xsl:if>&nbsp;
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
	<xsl:if test="/InformePedidos/LICITACION/LOGPEDIDOS/ENTRADA">
	<br/>
	<br/>
    <div class="divLeft textCenter marginTop50">
		<span class="tituloTabla"><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_con_justificacion']/node()"/></span>
	</div>
	<div class="tabela tabela_redonda">
	<table cellspacing="6px" cellpadding="6px">
	<thead>
		<tr>
			<th class="w1px">&nbsp;</th>
			<th class="cinco textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
			<th class="diez textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
			<th class="cinco textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/></th>
			<th class="cinco textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></th>
			<th class="textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='justificacion']/node()"/></th>
			<th class="uno">&nbsp;</th>
		</tr>
	</thead>
	<tbody>
	<xsl:for-each select="/InformePedidos/LICITACION/LOGPEDIDOS/ENTRADA">
		<tr class="conhover">
			<td class="color_status">&nbsp;<xsl:value-of select="CONTADOR"/></td>
			<td>&nbsp;<xsl:value-of select="FECHA"/></td>
			<td class="textLeft">&nbsp;<xsl:value-of select="PROVEEDOR"/></td>
			<td class="textLeft">&nbsp;&nbsp;<a href="javascript:FichaPedido({MO_ID})"><xsl:value-of select="CODPEDIDO"/></a></td>
			<td class="textLeft">&nbsp;<xsl:value-of select="USUARIO"/></td>
			<td class="textLeft">&nbsp;<xsl:value-of select="TEXTO"/></td>
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
	<br/>
	<br/>
	</form>
</div><!--fin de divLeft-->

</xsl:template>

</xsl:stylesheet>
