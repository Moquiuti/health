<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/">
<html>
<head>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<xsl:text disable-output-escaping="yes"><![CDATA[
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

	<script type="text/javascript">
	<!--
		function ContinuarProgramacionPedido(mo_id,estado,sesion){
	]]></xsl:text>

			var v_mo_id='<xsl:value-of select="//MO_IDPROGRAMAR"/>';
			var v_estado='<xsl:value-of select="//ESTADOPROGRAMAR"/>';
			var v_sesion='<xsl:value-of select="//SES_ID"/>';
			var idofertamodelo=v_mo_id;
			var idpedido='';
			var idusuario='<xsl:value-of select="//US_ID"/>';
			var listaUsuarios='S';
			var listaProveedores='N';

	<xsl:text disable-output-escaping="yes"><![CDATA[

			var ventana='NUEVA';

			MostrarPag('http://www.newco.dev.br/Compras/PedidosProgramados/MantPedidosProgramados.xsql?PEDP_ID='+idpedido+'&IDOFERTAMODELO='+idofertamodelo+'&US_ID='+idusuario+'&LISTAPEDIDOS='+listaProveedores+'&LISTAUSUARIOSCENTRO='+listaUsuarios+'&VENTANA='+ventana,'ProgramacionPedidos');
			document.location.href='http://www.newco.dev.br/Compras/NuevaMultioferta/AreaTrabajo.html';
		}

		function CerrarVentana(){
			window.close();
		}

	//-->
	</script>
	]]></xsl:text>
</head>
<body class="gris">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Generar/LANG"><xsl:value-of select="/Generar/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:if test="//BOTON='PROGRAMAR'">
		<xsl:attribute name="onload">ContinuarProgramacionPedido();</xsl:attribute>
	</xsl:if>

	<div class="divLeft">
	<xsl:choose>
	<xsl:when test="//SESION_CADUCADA">
		<xsl:apply-templates select="//SESION_CADUCADA"/>
	</xsl:when>
	<xsl:when test="//xsql-error">
		<xsl:apply-templates select="//xsql-error"/>
	</xsl:when>
	<xsl:when test="//Status and //BOTON!='PROGRAMAR'">
		<!--estado del peido, da general.xsl template match ya traducido-->
		<xsl:apply-templates select="//Status"/>

		<xsl:if test="/Generar/PEDIDOS/ROWSET/ROW">

			<br/><br/><br/>
			<table class="encuesta">
			<thead>
				<tr class="titulos">
					<th colspan="3"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_enviados']/node()"/></th>
				</tr>
				<tr class="tituloTabla center">
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='num_pedido']/node()"/></th>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_pedido']/node()"/></th>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
				</tr>
			</thead>
			<tbody>
			<xsl:for-each select="/Generar/PEDIDOS/ROWSET/ROW">
				<tr class="center">
					<td><xsl:apply-templates select="PED_NUMERO"/></td>
					<td><xsl:value-of select="MO_FECHA"/></td>
					<td><xsl:apply-templates select="PROVEEDOR"/></td>
				</tr>
			</xsl:for-each>
			</tbody>
			<tfoot><tr><td colspan="3">&nbsp;</td></tr></tfoot>
			</table>
		</xsl:if>

		<xsl:if test="/Generar/ABONOS/ROWSET/ROW">

			<br/><br/><br/>
			<table class="encuesta">
				<tr class="titulos">
					<th colspan="3"><xsl:value-of select="document($doc)/translation/texts/item[@name='abonos_enviados']/node()"/></th>
				</tr>
				<tr class="tituloTabla center">
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='num_pedido']/node()"/></th>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_pedido']/node()"/></th>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
				</tr>

			<xsl:for-each select="/Generar/ABONOS/ROWSET/ROW">
				<tr>
					<td><xsl:apply-templates select="PED_NUMERO"/></td>
					<td><xsl:value-of select="MO_FECHA"/></td>
					<td><xsl:apply-templates select="PROVEEDOR"/></td>
				</tr>
			</xsl:for-each>

				<tr><td colspan="3">&nbsp;</td></tr>
			</table>
		</xsl:if>
	</xsl:when>
	</xsl:choose>
	</div><!--fin de div inicio-->
</body>
</html>
</xsl:template>

<xsl:template match="PED_NUMERO">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Generar/LANG"><xsl:value-of select="/Generar/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<strong><xsl:value-of select="."/></strong>&nbsp;
	( <a href="javascript:MostrarPag('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID={../MO_ID}','Multioferta');">  <xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/> - <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a> )
</xsl:template>

<xsl:template match="PROVEEDOR">
	<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={../ID_PROVEEDOR}&amp;VENTANA=NUEVA','empresa',65,58,0,-50);">
		<xsl:value-of select="."/>
	</a>
</xsl:template>
</xsl:stylesheet>