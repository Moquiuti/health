<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Página para imprimir la ficha con las ofertas seleccionadas, "Vencedores"	
	Ultima revision ET 1oct20 16:00 licOfertasSeleccionadas_011020.js
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

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Vencedores']/node()"/>:&nbsp;<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_TITULO"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/licOfertasSeleccionadas_011020.js"></script>
</head>
<body>
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

	<div class="cabeceraBox" style="background:#FFF; margin:0px;">
		<!--idioma-->
		<xsl:variable name="lang">
			<xsl:choose>
				<xsl:when test="/OfertasSeleccionadas/LANG"><xsl:value-of select="/OfertasSeleccionadas/LANG"/></xsl:when>
				<xsl:otherwise>spanish</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
		<!--idioma fin-->

		<div class="logoPage" id="logoPage">
			<div class="logoPageInside">
				<img src="http://www.newco.dev.br/images/logoMVM2016.gif" />
			</div><!--fin de logo-->
		</div><!--fin de logoPage-->
		<br/>
		<!--<div class="boton">-->
			<a class="btnNormal" style="margin-left:700px;" href="javascript:window.print()"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
		<!--</div>-->

		<a class="btnNormal" style="text-decoration:none;"  href="javascript:window.close()"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>

		<!--<div class="boton">
			<a href="javascript:history.go(-1)"><xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/></a>
		</div>-->

	</div><!--fin de cabeceraBox-->

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

	<form method="post">
	<h1 align="center">
		<strong>
		<xsl:if test="/OfertasSeleccionadas/LICITACION/CENTRO">
			<xsl:value-of select="/OfertasSeleccionadas/LICITACION/CENTRO"/>:&nbsp;
		</xsl:if>
		(<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_CODIGO"/>)&nbsp;
		<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_TITULO"/>
		</strong>
	</h1>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	</form>

	<!--<table cellspacing="0" cellpadding="20" border="1" width="50%" align="center">-->
	<table width="100%" align="center">
		<tr>
			<!--<td class="labelRight veintecinco">-->
			<td width="250px">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/>:&nbsp;
			</td>
			<!--<td class="datosLeft">-->
			<td>
				<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_FECHADECISIONPREVISTA"/>
			</td>
		</tr>
		<tr>
			<!--<td class="labelRight">-->
			<td>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:&nbsp;
			</td>
			<!--<td class="datosLeft">-->
			<td>
				<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_DESCRIPCION"/>
			</td>
		</tr>
		<tr>
			<!--<td class="labelRight">-->
			<td>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_entrega']/node()"/>:&nbsp;
			</td>
			<!--<td class="datosLeft">-->
			<td>
				<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_CONDICIONESENTREGA"/>
			</td>
		</tr>
		<tr>
			<!--<td class="labelRight">-->
			<td>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_pago']/node()"/>:&nbsp;
			</td>
			<!--<td class="datosLeft">-->
			<td>
				<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_CONDICIONESPAGO"/>
			</td>
		</tr>
		<tr>
			<!--<td class="labelRight">-->
			<td>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_otras']/node()"/>:&nbsp;
			</td>
			<!--<td class="datosLeft">-->
			<td>
				<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_OTRASCONDICIONES"/>
			</td>
		</tr>
		<xsl:if test="/OfertasSeleccionadas/LICITACION/LIC_MESESDURACION>0">
		<tr>
			<!--<td class="labelRight">-->
			<td>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='meses_duracion']/node()"/>:&nbsp;
			</td>
			<!--<td class="datosLeft">-->
			<td>
				<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_MESESDURACION"/>
			</td>
		</tr>
		</xsl:if>
		<xsl:if test="/OfertasSeleccionadas/LICITACION/TOTAL_ALAVISTA">
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_alavista']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/OfertasSeleccionadas/LICITACION/TOTAL_ALAVISTA"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_aplazado']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/OfertasSeleccionadas/LICITACION/TOTAL_APLAZADO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
			</td>
		</tr>
		</xsl:if>
		<!--<tr class="gris">-->
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_adjudicado']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_CONSUMOADJUDICADO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
			</td>
		</tr>
		<tr>
			<!--<td class="labelRight">-->
			<td>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>:&nbsp;
			</td>
			<!--<td class="datosLeft">-->
			<td>
				<xsl:value-of select="/OfertasSeleccionadas/LICITACION/PRODUCTOSADJUDICADOS"/>/<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_NUMEROLINEAS"/>
			</td>
		</tr>
		<tr>
			<!--<td class="labelRight">-->
			<td>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>:&nbsp;
			</td>
			<!--<td class="datosLeft">-->
			<td>
				<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_PROVEEDORESADJUDICADOS"/>/<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_PROVEEDORESADJUDICADOS"/>
			</td>
		</tr>
		<tr>
			<!--<td class="labelRight">-->
			<td>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro']/node()"/>:&nbsp;
			</td>
			<!--<td class="datosLeft">-->
			<td>
				<xsl:value-of select="/OfertasSeleccionadas/LICITACION/LIC_AHORROADJUDICADO"/>
			</td>
		</tr>
	</table><!--fin de tala datos generales-->
	<br></br>
</div><!--fin de divLeft-->

<div class="divLeft">
	<form id="Proveedores" name="Proveedores" method="POST">
	<input type="hidden" name="IDLicitacion" value="{/OfertasSeleccionadas/LICITACION/LIC_ID}"/>
	<xsl:for-each select="/OfertasSeleccionadas/LICITACION/PROVEEDORES/PROVEEDOR">
	<table style="width:100%" border="0">
	<!--<thead style="font-weight:bold;">-->
		<tr align="left">
			<td colspan="8">
			<br/>	
			<xsl:if test="NO_CUMPLE_PEDIDO_MINIMO">
				<img src="http://www.newco.dev.br/images/urgente.gif"/>
			</xsl:if>
			<xsl:value-of select="EMP_NIF"/>&nbsp;-&nbsp;
			<!--<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalle.xsql?EMP_ID={IDPROVEEDOR}&amp;ESTADO=CABECERA','Detalle Empresa',100,80,0,0);">-->
			<xsl:if test="/OfertasSeleccionadas/LICITACION/LIC_AGREGADA='S' and /OfertasSeleccionadas/LICITACION/IDCENTROACTUAL=''">
				&nbsp;<xsl:value-of select="CENTRO"/>:&nbsp;
			</xsl:if>
			<xsl:if test="DATOSPRIVADOS/COP_CODIGO  != '' ">
				&nbsp;(<xsl:value-of select="DATOSPRIVADOS/COP_CODIGO"/>)&nbsp;
			</xsl:if>
			<xsl:value-of select="NOMBRECORTO"/>
			<!--</a>-->
			&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/>:&nbsp;<xsl:value-of select="LIC_PROV_PEDIDOMINIMO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
			&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='total_consumo']/node()"/>:&nbsp;<xsl:value-of select="LIC_PROV_CONSUMOADJUDICADO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>
			<br/>
			<xsl:if test="LIC_PROV_FRETE  != '' ">			
				<xsl:value-of select="document($doc)/translation/texts/item[@name='frete']/node()"/>:&nbsp;<xsl:value-of select="LIC_PROV_FRETE"/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</xsl:if>
			<xsl:if test="LIC_PROV_PLAZOENTREGA  != '' ">  
				<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/>:&nbsp;<xsl:value-of select="LIC_PROV_PLAZOENTREGA"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='dias']/node()"/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
			</xsl:if>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/LIC_AGREGADA = 'N'">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='forma_pago']/node()"/>:&nbsp;<xsl:value-of select="FORMAPAGO"/>,&nbsp;
				<xsl:value-of select="PLAZOPAGO"/>
			</xsl:if>
			<xsl:if test="DATOSPRIVADOS/COP_NOMBREBANCO  != '' ">
				&nbsp;(<xsl:value-of select="document($doc)/translation/texts/item[@name='Cuenta_bancaria']/node()"/>:&nbsp;
					<xsl:value-of select="DATOSPRIVADOS/COP_NOMBREBANCO"/>&nbsp;<xsl:value-of select="DATOSPRIVADOS/COP_CODBANCO"/>&nbsp;<xsl:value-of select="DATOSPRIVADOS/COP_CODOFICINA"/>&nbsp;<xsl:value-of select="DATOSPRIVADOS/COP_CODCUENTA"/>)&nbsp;
			</xsl:if>
			<!--<br>&nbsp;</br>-->
			</td>
		</tr>
	<!--</thead>-->
	</table>
	<!--<br></br> PS -->
	<table cellspacing="0" cellpadding="20" border="1" width="100%" align="center">
	<!--<table style="width:100%" border="1">-->
		<!--<thead align="center">-->
		<tr align="center">
			<td class="uno">&nbsp;</td>
			<td width="5%"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></td>
			<!--<td style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></td>-->
			<td width="*%"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></td>
			<td width="10%"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></td>
			<td width="5%"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></td>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS != 55">
				<td width="5%"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/></td>
			</xsl:if>
			<td width="5%"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/></td>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34">
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></td>
			</xsl:if>
			<td width="5%"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></td>
			<td width="5%"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></td>
		</tr>
	<!--</thead>-->
		<br>&nbsp;</br>
	<!--<tbody align="left">-->
	<tbody>	
	<xsl:for-each select="OFERTA">
		<tr>
			<td><xsl:value-of select="CONTADOR"/></td>
			<td align="right"><xsl:value-of select="LIC_PROD_REFCLIENTE"/>&nbsp;</td>
			<td align="left">
				<!--<a href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/OfertasSeleccionadas/LICITACION/LIC_ID}">-->
				&nbsp;<xsl:value-of select="LIC_PROD_NOMBRE"/><!--</a>-->
			</td>
			<td align="center"><xsl:value-of select="LIC_OFE_MARCA"/></td>
			<td align="center"><xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS != 55">
				<td align="center"><xsl:value-of select="LIC_OFE_REFERENCIA"/></td>
			</xsl:if>
			<td align="right">
			<xsl:value-of select="LIC_OFE_PRECIO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>&nbsp;
			</td>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34">
				<td><xsl:value-of select="LIC_OFE_TIPOIVA"/>%</td>
			</xsl:if>
			<td align="right"><xsl:value-of select="CANTIDAD"/>&nbsp;</td>
			<td align="right">
			<xsl:value-of select="CONSUMO"/><xsl:value-of select="/OfertasSeleccionadas/LICITACION/DIVISA/SUFIJO"/>&nbsp;
			</td>
		</tr>
	</xsl:for-each>
	</tbody>
	</table>
	<br></br>
	</xsl:for-each>
	<xsl:if test="/OfertasSeleccionadas/LICITACION/PRODUCTOS_SIN_OFERTA/PRODUCTO">
	<table style="width:100%" border="1">
	<!--<thead align="left">-->
		<tr>
			<td colspan="8" align="center">
			<br/>&nbsp;
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_no_seleccionados']/node()"/>
			<br/>&nbsp;
			</td>
		</tr>
		<tr>
			<td class="cinco">&nbsp;</td>
			<td align="left" width="5%"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></td>
			<td align="left" width="15%"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></td>
			<td align="center" width="5%"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></td>
			<td align="center" width="5%"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/></td>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34">
			<td align="center" width="25"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></td>
			</xsl:if>
			<td align="right" width="5%"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></td>
			<td align="right" width="5%"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></td>
		</tr>
	<!--</thead>-->

	<tbody>
	<xsl:for-each select="/OfertasSeleccionadas/LICITACION/PRODUCTOS_SIN_OFERTA/PRODUCTO">
		<tr>
			<td><xsl:value-of select="CONTADOR"/></td>
			<td align="left" width="5%"><xsl:value-of select="LIC_PROD_REFCLIENTE"/></td>
			<td align="left" width="15%">
				<!--<a href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/OfertasSeleccionadas/LICITACION/LIC_ID}">-->
				<xsl:value-of select="LIC_PROD_NOMBRE"/><!--</a>-->
			</td>
			<td align="left" width="5%"><xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>
			<td align="left" width="5%">
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 55 and LIC_PROD_PRECIO>0">R$&nbsp;</xsl:if>
			<xsl:value-of select="LIC_PROD_PRECIO"/>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34 and LIC_PROD_PRECIO>0">&nbsp;&#128;</xsl:if>&nbsp;
			</td>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34">
				<td align="right" width="5%"><xsl:value-of select="LIC_PROD_TIPOIVA"/>%</td>
			</xsl:if>
			<td align="right" width="5%"><xsl:value-of select="LIC_PROD_CANTIDAD"/></td>&nbsp;
			<td align="right" width="5%">
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 55 and LIC_PROD_CONSUMO>0">R$&nbsp;</xsl:if>
			<xsl:value-of select="CANTIDAD"/>
			<xsl:if test="/OfertasSeleccionadas/LICITACION/IDPAIS = 34 and LIC_PROD_CONSUMO>0">&nbsp;&#128;</xsl:if>&nbsp;
			</td>
		</tr>
	</xsl:for-each>
	</tbody>
	</table>
	<br></br>
	</xsl:if>
	
	<xsl:if test="/OfertasSeleccionadas/LICITACION/PRODUCTOS_JUSTIFICADOS/PRODUCTO">
	<!--<table class="infoTable">-->
	<br/>
	<br/>
	<br/>
	<br/>
	<table style="width:100%" border="1">
	<thead>
		<tr>
			<td colspan="3" align="center">
			<br/>&nbsp;
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_con_justificacion']/node()"/>
			<br/>&nbsp;
			</td>
		</tr>
		<tr>
			<td class="cinco">&nbsp;</td>
			<td class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></td>
			<td class="trenta" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></td>
			<td class="datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='justificacion']/node()"/></td>
		</tr>
	</thead>
	<tbody>
	<xsl:for-each select="/OfertasSeleccionadas/LICITACION/PRODUCTOS_JUSTIFICADOS/PRODUCTO">
		<tr>
			<td><xsl:value-of select="CONTADOR"/></td>
			<td><xsl:value-of select="REFERENCIA"/></td>
			<td class="datosLeft"><xsl:value-of select="LIC_PROD_NOMBRE"/></td>
			<td class="datosLeft"><xsl:value-of select="JUSTIFICACION"/><xsl:value-of select="LIC_PROD_MOTIVOSELECCION"/></td>
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
	<table style="width:100%" border="1">
	<thead>
		<tr>
			<td colspan="8" align="center">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Ofertas_descartadas']/node()"/>
			</td>
		</tr>
		<tr>
			<td class="cinco">&nbsp;</td>
			<td class="siete"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></strong></td>
			<td class="trenta" style="text-align:left;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></strong></td>
			<td class="trenta" style="text-align:left;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></strong></td>
			<td class="diez" style="text-align:left;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></strong></td>
			<td class="cinco" style="text-align:left;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></strong></td>
			<td class="datosLeft"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='justificacion']/node()"/></strong></td>
			<td class="cinco">&nbsp;</td>
		</tr>
	</thead>
	<tbody>
	<xsl:for-each select="/OfertasSeleccionadas/LICITACION/OFERTAS_DESCARTADAS/OFERTA">
		<tr>
			<td><xsl:value-of select="CONTADOR"/></td>
			<td><xsl:value-of select="PROVEEDOR"/></td>
			<td><xsl:value-of select="REFERENCIA"/></td>
			<td class="datosLeft">
				<a href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/OfertasSeleccionadas/LICITACION/LIC_ID}">
				<xsl:value-of select="LIC_PROD_NOMBRE"/></a>
			</td>
			<td><xsl:value-of select="LIC_OFE_MARCA"/></td>
			<td><xsl:value-of select="LIC_OFE_PRECIO"/></td>
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
	<table style="width:100%" border="1">
	<thead>
		<tr>
			<td colspan="8" align="center">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Ofertas_adjudicadas_eliminadas']/node()"/>
			</td>
		</tr>
		<tr>
			<td class="cinco">&nbsp;</td>
			<td class="siete"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></strong></td>
			<td class="trenta" style="text-align:left;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></strong></td>
			<td class="trenta" style="text-align:left;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></strong></td>
			<td class="diez" style="text-align:left;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></strong></td>
			<td class="cinco" style="text-align:left;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></strong></td>
			<td class="datosLeft"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='justificacion']/node()"/></strong></td>
			<td class="cinco">&nbsp;</td>
		</tr>
	</thead>
	<tbody>
	<xsl:for-each select="/OfertasSeleccionadas/LICITACION/ADJUDICADOS_ELIMINADOS/OFERTA">
		<tr>
			<td><xsl:value-of select="CONTADOR"/></td>
			<td><xsl:value-of select="PROVEEDOR"/></td>
			<td><xsl:value-of select="REFERENCIA"/></td>
			<td class="datosLeft">
				<a href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/OfertasSeleccionadas/LICITACION/LIC_ID}">
				<xsl:value-of select="LIC_PROD_NOMBRE"/></a>
			</td>
			<td><xsl:value-of select="LIC_OFE_MARCA"/></td>
			<td><xsl:value-of select="LIC_OFE_PRECIO"/></td>
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
