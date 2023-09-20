<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Informe de proveedores adjudicados, proveedor a proveedor	
	Ultima revision: ET 22jun22 11:30
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
			<xsl:when test="/InformeProveedor/LANG"><xsl:value-of select="/InformeProveedor/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<meta http-equiv="Cache-Control" content="no-cache"/>

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_adjudicados_por_proveedor']/node()"/>:&nbsp;<xsl:value-of select="/InformeProveedor/LICITACION/LIC_TITULO"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript">
	function CambioProveedor()
	{
		var frmProv=document.forms['Proveedores'];
		SubmitForm(frmProv);
		
	}
	</script>
</head>
<body class="gris">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/InformeProveedor/LANG"><xsl:value-of select="/InformeProveedor/LANG"/></xsl:when>
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
			<xsl:when test="/InformeProveedor/LANG"><xsl:value-of select="/InformeProveedor/LANG"/></xsl:when>
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
		<xsl:when test="/InformeProveedor/LANG"><xsl:value-of select="/InformeProveedor/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<form id="Proveedores" name="Proveedores" action="http://www.newco.dev.br/Gestion/Comercial/licInformePorProveedor2022.xsql" method="POST">
<div class="divLeft">

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<xsl:if test="/InformeProveedor/LICITACION/LIC_AGREGADA = 'S'">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/InformeProveedor/LICITACION/CENTROSCOMPRAS/field"/>
			<xsl:with-param name="onChange">javascript:document.forms[0].submit();</xsl:with-param>
			<xsl:with-param name="style">width:200px;</xsl:with-param>
		</xsl:call-template>
		</xsl:if>
		<p class="TituloPagina">
			<a id="botonLicitacion" href="javascript:AbrirLicitacion({/AvanceOfertas/LICITACION/LIC_ID});"><xsl:value-of select="/InformeProveedor/LICITACION/LIC_CODIGO"/>:&nbsp;<xsl:value-of select="/InformeProveedor/LICITACION/LIC_TITULO"/></a>
			<span class="CompletarTitulo">
				<a class="btnNormal" href="javascript:window.print();"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
				&nbsp;
				<xsl:choose>
				<xsl:when test="/InformeProveedor/LIC_PROD_ID != ''">
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
				<img src="{/InformeProveedor/LICITACION/EMPRESA_MVM/URL_LOGOTIPO}"/><BR/>
				<xsl:value-of select="/InformeProveedor/LICITACION/EMPRESA_MVM/NOMBRE"/>
			</td>
			<td class="textLeft">
				<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_adjudicados_por_proveedor']/node()"/></strong>
			</td>
		</tr>
		<tr><td colspan="2">&nbsp;</td></tr>
		<tr>
			<td class="labelRight" style="width:25%;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_informe']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/FECHAACTUAL"/></strong>
			</td>
		</tr>
		<xsl:if test="/InformeProveedor/LICITACION/CENTROPEDIDO">
		<tr>
			<td class="labelRight" style="width:25%;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Comprador']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/CENTROPEDIDO/NOMBRE"/></strong>&nbsp;(<xsl:value-of select="/InformeProveedor/LICITACION/CENTROPEDIDO/NIF"/>)
			</td>
		</tr>
		<tr>
			<td class="labelRight" style="width:25%;">
				&nbsp;
			</td>
			<td class="textLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/CENTROPEDIDO/DIRECCION"/></strong>
			</td>
		</tr>
		</xsl:if>
		<tr>
			<td class="labelRight" style="width:25%;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='codigo']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/LIC_CODIGO"/></strong>
			</td>
		</tr>
		<tr>
			<td class="labelRight" style="width:25%;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/LIC_TITULO"/></strong>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/LIC_DESCRIPCION"/></strong>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/LIC_CONDICIONESENTREGA"/></strong>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				&nbsp;
			</td>
			<td class="textLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/LIC_CONDICIONESPAGO"/></strong>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				&nbsp;
			</td>
			<td class="textLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/LIC_OTRASCONDICIONES"/></strong>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_licitacion']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/TIPOLICITACION"/></strong>
			</td>
		</tr>
		<tr>
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/InformeProveedor/LICITACION/FIDPROVEEDOR/field"/>
				<xsl:with-param name="onChange">javascript:CambioProveedor();</xsl:with-param>
				<xsl:with-param name="style">height:25px;width:600px;font-size:15px;</xsl:with-param>
				</xsl:call-template>
			</td>
		</tr>
	</table><!--fin de tala datos generales-->
	<br/>
	<br/>
	<br/>
</div><!--fin de divLeft-->

<div class="divLeft">
	<input type="hidden" name="IDLicitacion" value="{/InformeProveedor/LICITACION/LIC_ID}"/>		<!--	para el JS	-->
	<input type="hidden" name="LIC_ID" value="{/InformeProveedor/LICITACION/LIC_ID}"/>				<!--	se utiliza en el XSQL		-->
	<input type="hidden" name="IDCentro" value="{/InformeProveedor/LICITACION/IDCENTRO}"/>
	<input type="hidden" name="ACCION" value=""/>
	<input type="hidden" name="PARAMETROS" value=""/>
	
	<xsl:for-each select="/InformeProveedor/LICITACION/PROVEEDORES/PROVEEDOR">
	<table class="w80 fondoGris tableCenter" cellspacing="10px" cellpadding="10px">
	<tbody>
		<tr>
			<td class="uno">&nbsp;</td>
			<td align="left">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></strong></td>
			<td align="left">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/></strong></td>
			<td align="left">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/></strong></td>
			<td align="left">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='forma_pago']/node()"/></strong></td>
			<td align="left">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='frete']/node()"/></strong></td>
			<td align="left">&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones']/node()"/></strong></td>
			<td class="uno">&nbsp;</td>
		</tr>
		<tr>
			<td class="uno">&nbsp;</td>
			<td align="left">
				<BR/>&nbsp;<strong><xsl:value-of select="NOMBRE"/></strong><BR/>&nbsp;<xsl:value-of select="PROVINCIA"/><BR/><span class="fuentePeq">&nbsp;<xsl:value-of select="VENDEDOR/NOMBRE"/>:<BR/>
				&nbsp;<xsl:value-of select="VENDEDOR/TELEFONO"/><BR/>
				&nbsp;<xsl:value-of select="VENDEDOR/EMAIL"/><BR/>
				</span>
				&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDPROVEEDOR}&amp;ESTADO=CABECERA','Detalle Empresa',100,80,0,0);"><xsl:value-of select="document($doc)/translation/texts/item[@name='Mas_informacion']/node()"/></a><BR/>
				<BR/>
			</td>
			<td align="left">&nbsp;<xsl:value-of select="/InformeProveedor/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="LIC_PROV_PEDIDOMINIMO"/><xsl:value-of select="/InformeProveedor/LICITACION/DIVISA/SUFIJO"/></td>
			<td align="left">&nbsp;<xsl:value-of select="LIC_PROV_PLAZOENTREGA"/></td>
			<td align="left">&nbsp;<xsl:value-of select="FORMAPAGO"/>.&nbsp;<xsl:value-of select="PLAZOPAGO"/></td>
			<td align="left">&nbsp;<xsl:value-of select="LIC_PROV_FRETE"/></td>
			<td align="left">&nbsp;<xsl:copy-of select="LIC_PROV_COMENTARIOSPROV"/></td>
			<td class="uno">&nbsp;</td>
		</tr>
	</tbody>
	</table>
	<br/>		
	<br/>		
	<br/>		
	<div class="tabela tabela_redonda">
	<table cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
		<tr>
			<th class="w1px">&nbsp;</th>
			<th class="textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
			<th class="w50px">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
			<th class="textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Fabricante']/node()"/></th>
			<th class="w50px">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='embalaje']/node()"/></th>
			<xsl:if test="/InformeProveedor/LICITACION/IDPAIS != 55">
				<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/></th>
			</xsl:if>
			<th class="w100px">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/></th>
			<th class="w100px">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='justificacion']/node()"/></th>
			<th class="cinco">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/></th>
			<xsl:if test="/InformeProveedor/LICITACION/IDPAIS = 34">
				<th class="w50px">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></th>
			</xsl:if>
			<th class="w50px">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
			<th class="w50px">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_linea']/node()"/></th>
			<th class="w100px">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></th>
			<th class="w1px">&nbsp;</th>
		</tr>
	</thead>
	<!--	Cuerpo de la tabla	-->
	<tbody class="corpo_tabela">
	<xsl:choose>
	<!-- para licitaciones multipedido	-->
	<xsl:when test="/InformeProveedor/LICITACION/LIC_MULTIPEDIDO = 'S'">
		<xsl:for-each select="PEDIDO">
			<xsl:for-each select="OFERTA">
				<tr class="conhover">
					<td class="color_status"><xsl:value-of select="LINEA"/></td>
					<td>
						<xsl:choose>
						<!-- para liciatciones no agregadas o si no está seleccionado un centro	-->
						<xsl:when test="LIC_PROD_REFCLIENTE != ''"><xsl:value-of select="LIC_PROD_REFCLIENTE"/></xsl:when>
						<xsl:otherwise><xsl:value-of select="LIC_PROD_REFESTANDAR"/></xsl:otherwise>
						</xsl:choose>
					</td>
					<td class="textLeft">
						<a href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/InformeProveedor/LICITACION/LIC_ID}">
						<xsl:value-of select="LIC_PROD_NOMBRE"/></a>
					</td>
					<td><xsl:value-of select="LIC_OFE_MARCA"/></td>
					<td><xsl:value-of select="LIC_PROD_UNIDADBASICA"/></td>
					<xsl:if test="/InformeProveedor/LICITACION/IDPAIS != 55">
						<td><xsl:value-of select="LIC_OFE_REFERENCIA"/></td>
					</xsl:if>
					<td><xsl:value-of select="LIC_OFE_COMENTARIOS"/></td>
					<td><xsl:value-of select="JUSTIFICACION"/><xsl:value-of select="LIC_PROD_MOTIVOSELECCION"/></td>
					<td class="textRight">
						<xsl:value-of select="/InformeProveedor/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="LIC_OFE_PRECIO"/><xsl:value-of select="/InformeProveedor/LICITACION/DIVISA/SUFIJO"/>
					</td>
					<xsl:if test="/InformeProveedor/LICITACION/IDPAIS != 55">
						<td><xsl:value-of select="LIC_OFE_TIPOIVA"/>%</td>
					</xsl:if>
					<td class="textRight">
						<xsl:if test="CAMBIO_CANTIDAD">
							(<xsl:value-of select="CANTIDADORIGINAL"/>-><xsl:value-of select="CANTIDAD"/>)&nbsp;
						</xsl:if>
						<strong><xsl:value-of select="CANTIDAD"/></strong>&nbsp;
					</td>
					<td class="textRight">
						<xsl:value-of select="/InformeProveedor/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="CONSUMO"/><xsl:value-of select="/InformeProveedor/LICITACION/DIVISA/SUFIJO"/>
					</td>
					<td>&nbsp;<strong><xsl:value-of select="USUARIO_ADJUDICACION"/></strong><BR/><xsl:value-of select="LIC_OFE_FECHAADJUDICACION"/></td>
					<td>&nbsp;</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:when>
	<xsl:otherwise>
		<xsl:for-each select="OFERTA">
			<tr class="gris">
				<td class="color_status"><xsl:value-of select="CONTADOR"/></td>
				<td class="textLeft">
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={/InformeProveedor/LICITACION/LIC_ID}');">
					<xsl:value-of select="LIC_PROD_NOMBRE"/></a>
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
				<xsl:if test="/InformeProveedor/LICITACION/IDPAIS != 55">
					<td><xsl:value-of select="LIC_OFE_REFERENCIA"/></td>
				</xsl:if>
				<td><xsl:value-of select="LIC_OFE_COMENTARIOS"/></td>
				<td><xsl:value-of select="JUSTIFICACION"/><xsl:value-of select="LIC_PROD_MOTIVOSELECCION"/></td>
				<td class="textRight">
					<xsl:value-of select="/InformeProveedor/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="LIC_OFE_PRECIO"/><xsl:value-of select="/InformeProveedor/LICITACION/DIVISA/SUFIJO"/>
				</td>
				<xsl:if test="/InformeProveedor/LICITACION/IDPAIS != 55">
					<td><xsl:value-of select="LIC_OFE_TIPOIVA"/>%</td>
				</xsl:if>
				<td class="textRight">
					<xsl:if test="CAMBIO_CANTIDAD">
						(<xsl:value-of select="CAMBIO_CANTIDAD/CANTIDADORIGINAL"/>-><xsl:value-of select="CAMBIO_CANTIDAD/CANTIDAD"/>)&nbsp;
					</xsl:if>
					<strong><xsl:value-of select="CANTIDAD"/></strong>&nbsp;
				</td>
				<td class="textRight">
					<xsl:value-of select="/InformeProveedor/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="CONSUMO"/><xsl:value-of select="/InformeProveedor/LICITACION/DIVISA/SUFIJO"/>
				</td>
				<td><xsl:value-of select="USUARIO_ADJUDICACION"/><BR/><xsl:value-of select="LIC_OFE_FECHAADJUDICACION"/></td>
				<td>&nbsp;</td>
			</tr>
		</xsl:for-each>
	</xsl:otherwise>
	</xsl:choose>
	</tbody>
	<tfoot class="rodape_tabela">
	<tr>
		<td colspan="5">
			<strong>
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Numero_productos_licitacion']/node()"/>:&nbsp;<xsl:value-of select="/InformeProveedor/LICITACION/LIC_NUMEROLINEAS"/>
			&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Numero_productos_proveedor']/node()"/>:&nbsp;<xsl:value-of select="LIC_PROV_OFERTASADJUDICADAS"/>
			</strong>
		</td>
		<td colspan="2">&nbsp;</td>
		<td class="textRight"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='Total_general']/node()"/>:</strong></td>
		<td class="textRight"><strong><xsl:value-of select="/InformeProveedor/LICITACION/PROVEEDORES/PROVEEDOR/NUMERO_PRODUCTOS"/></strong></td>
		<td class="textRight"><strong><xsl:value-of select="/InformeProveedor/LICITACION/DIVISA/PREFIJO"/><xsl:value-of select="/InformeProveedor/LICITACION/PROVEEDORES/PROVEEDOR/LIC_PROV_CONSUMOADJUDICADO"/><xsl:value-of select="/InformeProveedor/LICITACION/DIVISA/SUFIJO"/></strong></td>
		<td colspan="2">&nbsp;</td>
	</tr>
	</tfoot>
	</table>
	</div>
	<br/>
	<br/>
	</xsl:for-each>

</div><!--fin de divLeft-->
</form>

</xsl:template>

</xsl:stylesheet>
