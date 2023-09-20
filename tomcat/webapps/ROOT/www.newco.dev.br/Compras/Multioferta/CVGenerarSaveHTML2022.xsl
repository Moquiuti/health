<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Pedidos generados, presentamos resumen en pantalla. Disenno 2022
	Ultima revision: ET 22ago22 09:41
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
	<xsl:when test="/Generar/LANG"><xsl:value-of select="/Generar/LANG"/></xsl:when>
	<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose> 
</xsl:variable> 

<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable> 
<!--idioma fin--> 
  
<html>
<head>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<title>
		<xsl:choose> 
		<xsl:when test="/Generar/MULTIOFERTA/PEDIDOS/ROWSET">
			<xsl:value-of select="/Generar/MULTIOFERTA/PEDIDOS/ROWSET/ROW[1]/PED_NUMERO"/>&nbsp;-&nbsp;<xsl:value-of select="/Generar/MULTIOFERTA/PEDIDOS/ROWSET/ROW[1]/PROVEEDOR"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="/Generar/MULTIOFERTA/ABONOS/ROWSET/ROW[1]/PED_NUMERO"/>&nbsp;-&nbsp;<xsl:value-of select="/Generar/MULTIOFERTA/ABONOS/ROWSET/ROW[1]/PROVEEDOR"/>
		</xsl:otherwise>
		</xsl:choose> 
		:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Pedido_enviado']/node()"/>
	</title>

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>

	<script type="text/javascript">

	var v_mo_id='<xsl:value-of select="/Generar/MO_IDPROGRAMAR"/>';
	var v_estado='<xsl:value-of select="/Generar/ESTADOPROGRAMAR"/>';
	var idofertamodelo=v_mo_id;
	var idpedido='';
	var idusuario='<xsl:value-of select="//US_ID"/>';

	function ContinuarProgramacionPedido(){

/*	23ago22
		var Enlace='http://www.newco.dev.br/Compras/PedidosProgramados/MantPedidosProgramados2022.xsql?PEDP_ID='+idpedido+'&amp;IDOFERTAMODELO='+v_mo_id+'&amp;LISTAPEDIDOS=N&amp;LISTAUSUARIOSCENTRO=S&amp;VENTANA=NUEVA';
		console.log('ET! entrando en MostrarPag:'+Enlace);
		MostrarPag(Enlace,'ProgramacionPedidos');

		console.log('ET! entrando en document.location.href');
		document.location.href='http://www.newco.dev.br/Compras/NuevaMultioferta/AreaTrabajo2022.html';

		//console.log('ET! fin de la función');*/
		
		var Enlace='http://www.newco.dev.br/Compras/PedidosProgramados/MantPedidosProgramados2022.xsql?PEDP_ID='+idpedido+'&amp;IDOFERTAMODELO='+v_mo_id+'&amp;LISTAPEDIDOS=N&amp;LISTAUSUARIOSCENTRO=S&amp;VENTANA=NUEVA';
		document.location.href=Enlace;
		

	}

	function CerrarVentana(){
		window.close();
	}

	//	21dic16	Volver al área de trabajo principal
	function PaginaPrincipal()
	{
		document.location.href='http://www.newco.dev.br/Compras/NuevaMultioferta/AreaTrabajo2022.html';
	}

	</script>
</head>
<body>
	<xsl:choose> 
	<xsl:when test="/Generar/BOTON='PROGRAMAR'">
		<xsl:attribute name="onload">javascript:ContinuarProgramacionPedido();</xsl:attribute>  
	</xsl:when>  
	<xsl:when test="//SESION_CADUCADA">
		<xsl:apply-templates select="//SESION_CADUCADA"/>
	</xsl:when>
	<xsl:when test="//xsql-error">
		<xsl:apply-templates select="//xsql-error"/>
	</xsl:when>
	<xsl:otherwise>
	<div class="divLeft"> 
		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
				<xsl:choose> 
				<xsl:when test="/Generar/MULTIOFERTA/PEDIDOS/ROWSET">
					<xsl:value-of select="/Generar/MULTIOFERTA/PEDIDOS/ROWSET/ROW[1]/PED_NUMERO"/>&nbsp;-&nbsp;<xsl:value-of select="/Generar/MULTIOFERTA/PEDIDOS/ROWSET/ROW[1]/PROVEEDOR"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/Generar/MULTIOFERTA/ABONOS/ROWSET/ROW[1]/PED_NUMERO"/>&nbsp;-&nbsp;<xsl:value-of select="/Generar/MULTIOFERTA/ABONOS/ROWSET/ROW[1]/PROVEEDOR"/>
				</xsl:otherwise>
				</xsl:choose> 
				:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Pedido_enviado']/node()"/>
				<span class="CompletarTitulo">
					<!--	Incluir los botones	-->
					<a class="btnNormal" href="javascript:PaginaPrincipal();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/>
					</a>&nbsp;
				</span>
			</p>
		</div>
		<br/><br/><br/>

		<xsl:variable name="vMSGT">
			<xsl:value-of select="//Status/OK/@MSGT"/>
		</xsl:variable>

		<br/><br/><br/>


		<div class="linha_separacao_cotacao_y"></div>
		<div class="tabela tabela_redonda">
		<xsl:if test="/Generar/MULTIOFERTA/PEDIDOS/ROWSET/ROW">
			<table class="w80 tableCenter">
			<thead class="cabecalho_tabela">
				<tr class="subTituloTabla">
					<th class="color_status w1px">&nbsp;</th>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='num_pedido']/node()"/></th>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_pedido']/node()"/></th>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
				</tr>
			</thead>
			<tbody class="corpo_tabela">
			<xsl:for-each select="/Generar/MULTIOFERTA/PEDIDOS/ROWSET/ROW">
				<tr class="conhover">
					<td class="color_status">&nbsp;</td>
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
			<tfoot class="rodape_tabela">
				<tr class="center">
					<td colspan="5">&nbsp;</td>
				</tr>
			</tfoot>
			</table>
		</xsl:if>

		<xsl:if test="/Generar/MULTIOFERTA/ABONOS/ROWSET/ROW">
			<table class="w80">
			<thead class="cabecalho_tabela">
				<tr class="titulos">
					<th colspan="4"><xsl:value-of select="document($doc)/translation/texts/item[@name='abonos_enviados']/node()"/></th>
				</tr>
				<tr class="subTituloTabla">
					<th class="w1px color_status">&nbsp;</th>
					<th>
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='num_pedido']/node()"/>
                    </th>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_pedido']/node()"/></th>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
				</tr>
			</thead>
			<tbody class="corpo_tabela">
			<xsl:for-each select="/Generar/MULTIOFERTA/ABONOS/ROWSET/ROW">
				<tr class="conhover">
					<td class="color_status">&nbsp;</td>
					<td><xsl:apply-templates select="PED_NUMERO"/></td>
					<td><xsl:value-of select="MO_FECHA"/></td>
					<td><xsl:apply-templates select="PROVEEDOR"/></td>
				</tr>
			</xsl:for-each>
			</tbody>
			<tfoot class="rodape_tabela">
				<tr class="center">
					<td colspan="4">&nbsp;</td>
				</tr>
			</tfoot>
			</table>
		</xsl:if>
		</div>
		</div><!--fin de div inicio-->
	</xsl:otherwise>
	</xsl:choose>
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

	<strong><a href="javascript:FichaPedido({../MO_ID});"><xsl:value-of select="."/></a></strong>&nbsp;
</xsl:template>

<xsl:template match="PROVEEDOR">
	<xsl:value-of select="."/>
</xsl:template>
</xsl:stylesheet>
