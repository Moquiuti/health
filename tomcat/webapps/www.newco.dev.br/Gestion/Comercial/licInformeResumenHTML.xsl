<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Informe de resumen de la licitación
	Ultima revision: ET 15jun20 08:30
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

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
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

<div class="divLeft">

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>
		&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion']/node()"/>
		&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_adjudicados_por_proveedor']/node()"/></span>
		
		<span class="CompletarTitulo">
			<xsl:if test="/InformeProveedor/LICITACION/LIC_AGREGADA = 'S'">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/InformeProveedor/LICITACION/CENTROSCOMPRAS/field"/>
				<xsl:with-param name="onChange">javascript:document.forms[0].submit();</xsl:with-param>
				<xsl:with-param name="style">width:200px;</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
		</span>

		
		</p>
		<p class="TituloPagina">
			<xsl:value-of select="/InformeProveedor/LICITACION/LIC_CODIGO"/>:&nbsp;<xsl:value-of select="/InformeProveedor/LICITACION/LIC_TITULO"/>
			<span class="CompletarTitulo" style="width:700px;">
				<!--<a class="btnNormal" style="text-decoration:none;">
					<xsl:attribute name="href">javascript:listadoExcel();</xsl:attribute>
					<img src="http://www.newco.dev.br/images/iconoExcel.gif">
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_excel']/node()"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_excel']/node()"/></xsl:attribute>
					</img>
				</a>-->
				&nbsp;
				<!--<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/VencedoresYAlternativas.xsql?LIC_ID={/InformeProveedor/LIC_ID}"><xsl:value-of select="document($doc)/translation/texts/item[@name='VencedoresYAlternativas']/node()"/></a>
				&nbsp;
				<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/licOfertasSeleccionadas.xsql?LIC_ID={/InformeProveedor/LIC_ID}"><xsl:value-of select="document($doc)/translation/texts/item[@name='Vencedores']/node()"/></a>
				&nbsp;
				<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/licInformeProveedoresYOfertas.xsql?LIC_ID={/InformeProveedor/LIC_ID}"><xsl:value-of select="document($doc)/translation/texts/item[@name='Todas_Ofertas']/node()"/></a>
				&nbsp;-->
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
	<table class="buscador">
		<tr class="sinLinea">
			<td align="center">
				<img src="{/InformeProveedor/LICITACION/EMPRESA_MVM/URL_LOGOTIPO}"/><BR/>
				<xsl:value-of select="/InformeProveedor/LICITACION/EMPRESA_MVM/NOMBRE"/>
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='Informe_resumen_licitacion']/node()"/></strong>
			</td>
		</tr>
		<tr class="sinLinea"><td colspan="2">&nbsp;</td></tr>
		<tr class="sinLinea">
			<td class="labelRight" style="width:25%;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_informe']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/FECHAACTUAL"/></strong>
			</td>
		</tr>
		<xsl:if test="/InformeProveedor/LICITACION/CENTROPEDIDO">
		<tr class="sinLinea">
			<td class="labelRight" style="width:25%;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Comprador']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/CENTROPEDIDO/NOMBRE"/></strong>&nbsp;(<xsl:value-of select="/InformeProveedor/LICITACION/CENTROPEDIDO/NIF"/>)
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight" style="width:25%;">
				&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/CENTROPEDIDO/DIRECCION"/></strong>
			</td>
		</tr>
		</xsl:if>
		<tr class="sinLinea">
			<td class="labelRight" style="width:25%;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/LIC_CODIGO"/>&nbsp;-&nbsp;<xsl:value-of select="/InformeProveedor/LICITACION/LIC_TITULO"/></strong>
			</td>
		</tr>		
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='contacto']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/USUARIO"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_inicio']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/LIC_FECHAINICIO"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Vencimiento']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/LIC_FECHADECISIONPREVISTA"/>&nbsp;<xsl:value-of select="/InformeProveedor/LICITACION/LIC_HORADECISION"/>:<xsl:value-of select="/InformeProveedor/LICITACION/LIC_MINUTODECISION"/>:00</strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/LIC_DESCRIPCION"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/LIC_CONDICIONESENTREGA"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='forma_pago']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/LIC_CONDICIONESPAGO"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Terminos_y_condiciones']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/LIC_OTRASCONDICIONES"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_licitacion']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/TIPOLICITACION"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Numero_productos']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/LIC_NUMEROLINEAS"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores_visto_licitacion']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/LIC_NUMEROPROVEEDORESINF"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores_respondidos']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/PROVEEDORESCONOFERTAS"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_con_respuesta']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/PRODUCTOSCONOFERTA"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_1_respuesta']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/LIC_PRODUCTOSCON1OFERTA"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_2_respuestas']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/LIC_PRODUCTOSCON2OFERTAS"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_3_respuestas_o_mas']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/LIC_PRODUCTOSCON3OMASOFERTAS"/></strong>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_sin_respuesta']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<strong><xsl:value-of select="/InformeProveedor/LICITACION/LIC_PRODUCTOSSINOFERTA"/></strong>
			</td>
		</tr>
	</table><!--fin de tala datos generales-->
	<br/>
	<br/>
	<br/>
</div><!--fin de divLeft-->

</xsl:template>

</xsl:stylesheet>
