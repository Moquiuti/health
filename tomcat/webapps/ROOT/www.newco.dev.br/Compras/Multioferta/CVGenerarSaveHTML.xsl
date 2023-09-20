<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Pedidos generados, presentamos resumen en pantalla
	Ultima revision: ET 10feb20
-->
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

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

	<script type="text/javascript">
	<xsl:text disable-output-escaping="yes"><![CDATA[
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
		var ventana='NUEVA';

	<xsl:text disable-output-escaping="yes"><![CDATA[
			
			//console.log('ET! entrando en MostrarPag');
			MostrarPag('http://www.newco.dev.br/Compras/PedidosProgramados/MantPedidosProgramados.xsql?PEDP_ID='+idpedido+'&IDOFERTAMODELO='+idofertamodelo+'&US_ID='+idusuario+'&LISTAPEDIDOS='+listaProveedores+'&LISTAUSUARIOSCENTRO='+listaUsuarios+'&VENTANA='+ventana,'ProgramacionPedidos');


			//console.log('ET! entrando en document.location.href');
			document.location.href='http://www.newco.dev.br/Compras/NuevaMultioferta/AreaTrabajo.html';

			//console.log('ET! fin de la función');

		}

		function CerrarVentana(){
			window.close();
		}
		
		//	21dic16	Volver al área de trabajo principal
		function PaginaPrincipal()
		{
			document.location.href='http://www.newco.dev.br/Compras/NuevaMultioferta/AreaTrabajo.html';
		}

	//-->
	]]></xsl:text>
	</script>
</head>
<!--<body class="gris">-->
<body>
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

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Pedido_enviado']/node()"/></span></p>
			<p class="TituloPagina">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Pedido_enviado']/node()"/>
				<span class="CompletarTitulo">
					<!--	Incluir los botones	-->
					<a class="btnNormal" href="javascript:PaginaPrincipal();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/>
					</a>&nbsp;
				</span>
			</p>
		</div>
		<br/><br/><br/>
		<!--estado del pedido, da general.xsl template match ya traducido	-->
		<!--<xsl:apply-templates select="//Status"/> -->                 

		<xsl:variable name="vMSGT">
			<xsl:value-of select="//Status/OK/@MSGT"/>
		</xsl:variable>

		<!--<h1 style="margin-left:100px;"><xsl:value-of select="document($doc)/translation/texts/item[@name=$vMSGT]/node()"/></h1>-->

		<br/><br/><br/>

		<xsl:if test="/Generar/MULTIOFERTA/PEDIDOS/ROWSET/ROW">

			<!--<table class="encuesta">-->
			<table class="buscador" style="width:100%;align:center;">
			<thead>
				<tr class="subTituloTabla">
				<!--<tr class="tituloTabla center">-->
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='num_pedido']/node()"/></th>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_pedido']/node()"/></th>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
				</tr>
			</thead>
			<tbody>
			<xsl:for-each select="/Generar/MULTIOFERTA/PEDIDOS/ROWSET/ROW">
				<tr class="center">
					<td><xsl:apply-templates select="PED_NUMERO"/></td>
					<td><xsl:value-of select="MO_FECHA"/></td>
					<td><xsl:apply-templates select="PROVEEDOR"/></td>
					<td>
						<xsl:choose> 
						<xsl:when test="MO_STATUS=40">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_pendiente_aprobacion_resp']/node()"/>
						</xsl:when>
						<xsl:otherwise> 
							<xsl:value-of select="document($doc)/translation/texts/item[@name='MOF_11_RO']/node()"/>
						</xsl:otherwise> 
						</xsl:choose> 
					</td>
				</tr>
			</xsl:for-each>
			</tbody>
			</table>
		</xsl:if>

		<xsl:if test="/Generar/MULTIOFERTA/ABONOS/ROWSET/ROW">

			<!--<table class="encuesta">-->
			<table class="buscador" style="width:90%;align:center;">
				<tr class="titulos">
					<th colspan="3"><xsl:value-of select="document($doc)/translation/texts/item[@name='abonos_enviados']/node()"/></th>
				</tr>
				<tr class="subTituloTabla">
				<!--<tr class="tituloTabla center">-->
					<th>
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='num_pedido']/node()"/>
                    </th>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_pedido']/node()"/></th>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
				</tr>

			<xsl:for-each select="/Generar/MULTIOFERTA/ABONOS/ROWSET/ROW">
				<tr>
					<td><xsl:apply-templates select="PED_NUMERO"/></td>
					<td><xsl:value-of select="MO_FECHA"/></td>
					<td><xsl:apply-templates select="PROVEEDOR"/></td>
				</tr>
			</xsl:for-each>
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
	( <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID={../MO_ID}','Pedido',100,100,0,0);">  <xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/> - <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a> )
</xsl:template>

<xsl:template match="PROVEEDOR">
	<!--<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={../ID_PROVEEDOR}&amp;VENTANA=NUEVA','empresa',100,100,0,0);">-->
		<xsl:value-of select="."/>
	<!--</a>-->
</xsl:template>
</xsl:stylesheet>
