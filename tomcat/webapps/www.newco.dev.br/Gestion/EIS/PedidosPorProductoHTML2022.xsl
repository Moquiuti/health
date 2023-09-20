<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Analisis de pedidos, agregados por producto
	Ultima revision: ET 3oct22 15:00 PedidosPorProducto2022_031022.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="usuario" select="@US_ID"/>

<xsl:template match="/">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/PedidosPorProducto/LANG"><xsl:value-of select="/PedidosPorProducto/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<meta http-equiv="Cache-Control" Content="no-cache"/>
        <title><xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_por_producto']/node()"/>:&nbsp;<xsl:value-of select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/TITULO" /></title>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>		<!-- Para descargas excel	-->
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/EIS/PedidosPorProducto2022_031022.js"></script>
	<script type="text/javascript">
	var strCabeceraExcelPrinc='<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>;<xsl:value-of select="document($doc)/translation/texts/item[@name='nif']/node()"/>;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>;<xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>;<xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>(<xsl:value-of select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/DIVISA/PREFIJO"/><xsl:value-of select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/DIVISA/SUFIJO"/>)';

	var numColumnas=0;
	var arrProductos			= new Array();
	<xsl:for-each select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/PRODUCTO">
		var Producto			= [];
		
		Producto['ID']	= '<xsl:value-of select="ID"/>';
		Producto['RefCliente']	= '<xsl:value-of select="REF_CLIENTE"/>';
		Producto['Nombre']	= '<xsl:value-of select="NOMBRE"/>';
		Producto['UdBasica']	= '<xsl:value-of select="UNIDADBASICA"/>';
		Producto['Pedidos']	= '<xsl:value-of select="NUMERO_PEDIDOS"/>';
		<!--Producto['Lineas']	= '<xsl:value-of select="NUMERO_LINEAS"/>';-->
		Producto['TotalCantidad']	= '<xsl:value-of select="TOTAL_CANTIDAD"/>';
		Producto['TotalImporte']	= '<xsl:value-of select="TOTAL_IMPORTE"/>';

		arrProductos.push(Producto);
	</xsl:for-each>
	
	//	Cadenas para el CSV
	var strInforme='<xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_por_producto']/node()"/>';

	var strTitulo='<xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>';
	var Titulo='<xsl:value-of select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/TITULO"/>';

	var strFechaInforme='<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_informe']/node()"/>';
	var FechaInforme='<xsl:value-of select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/FECHAACTUAL"/>';

	var strFechaInicio='<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_inicio']/node()"/>';
	var FechaInicio='<xsl:value-of select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/FECHAINICIO"/>';

	var strFechaFinal='<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_final']/node()"/>';
	var FechaFinal='<xsl:value-of select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/FECHAFINAL"/>';

	var strCentro='<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>';
	var Centro='<xsl:value-of select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/NOMBRECENTRO"/>';

	var strProveedor='<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>';
	var Proveedor='<xsl:value-of select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/NOMBREPROVEEDOR"/>';

	var strRefCliente='<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>';
	var strUdBasica='<xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/>';

	var strProveedores='<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>';
	var Proveedores='<xsl:value-of select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/NUMERO_PROVEEDORES"/>';

	var strProducto='<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>';
	var Producto='<xsl:value-of select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/FPRODUCTO"/>';

	var strPedidos='<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>';
	var Pedidos='<xsl:value-of select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/NUMERO_PEDIDOS"/>';

	var Lineas='<xsl:value-of select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/NUMERO_LINEAS"/>';

	var strCantidad='<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/>';
	var Total='<xsl:value-of select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/TOTAL_CANTIDAD"/>';

	var strTotal='<xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>';
	var Total='<xsl:value-of select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/TOTAL_IMPORTE"/>';
	
	var strDiv='<xsl:value-of select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/DIVISA/PREFIJO"/><xsl:value-of select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/DIVISA/SUFIJO"/>';
	</script>
</head>
<body>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/WorkFlowPendientes/LANG"><xsl:value-of select="/WorkFlowPendientes/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->


	<form  method="post" name="Form1" action="PedidosPorProducto2022.xsql">

	<xsl:choose>
	<!-- Error en alguna sentencia del XSQL -->
	<xsl:when test="/PedidosPorProducto/INICIO/xsql-error">
		<xsl:apply-templates select="PedidosPorProveedor/INICIO/xsql-error"/>
	</xsl:when>
	<xsl:when test="/PedidosPorProducto/INICIO/SESION_CADUCADA">
		<xsl:for-each select="/PedidosPorProducto/INICIO/SESION_CADUCADA">
			<xsl:if test="position()=last()">
				<xsl:apply-templates select="."/>
			</xsl:if>
		</xsl:for-each>
	</xsl:when>
	<xsl:otherwise>
		<div class="divLeft">
             <xsl:call-template name="PRODUCTOS"/>
		</div>
	</xsl:otherwise>
	</xsl:choose>
	</form>

</body>
</html>
</xsl:template>


<!--ADMIN DE MVM-->
<xsl:template name="PRODUCTOS">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/PedidosPorProducto/LANG"><xsl:value-of select="/PedidosPorProducto/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->


	<div class="divLeft boxInicio" id="pedidosBox">

	<input type="hidden" name="IDPRODUCTO" value="{/PedidosPorProducto/PRODUCTOS/COMPRADOR/IDPRODUCTO}"/>
	<input type="hidden" name="IDPRODESTANDAR" value="{/PedidosPorProducto/PRODUCTOS/COMPRADOR/IDPRODESTANDAR}"/>
	<input type="hidden" name="IDLICITACION" value="{/PedidosPorProducto/PRODUCTOS/COMPRADOR/IDLICITACION}"/>

	<input type="hidden" name="ORDEN" value="{/PedidosPorProducto/PRODUCTOS/COMPRADOR/ORDEN}"/>
	<input type="hidden" name="SENTIDO" value="{/PedidosPorProducto/PRODUCTOS/COMPRADOR/SENTIDO}"/>
	<input type="hidden" name="IDEMPRESAUSUARIO" value="{/PedidosPorProducto/PRODUCTOS/IDEMPRESAUSUARIO}"/>


	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:value-of select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/TITULO" />&nbsp;
			<span class="fuentePeq">(<xsl:value-of select="/PedidosPorProducto/PRODUCTOS/FECHAACTUAL"/>)</span>
			<span class="CompletarTitulo">
				<a class="btnNormal" href="javascript:DescargarExcel();"><xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/></a>
				&nbsp;
				<a class="btnNormal" href="javascript:window.print()" style="margin-right:30px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
				&nbsp;
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<div class="divLeft">
		<input type="hidden" name="PAGINA" id="PAGINA" value="{PAGINA}"/>
		<xsl:call-template name="buscador"/>
		<br/>
	</div>
	<div class="tabela tabela_redonda">
	<table cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
			<th class="w1px">&nbsp;</th>
			<th class="w50px"><a href="javascript:OrdenarPor('REF_CLIENTE','ASC')"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></a></th>
			<th class="textLeft"><a href="javascript:OrdenarPor('NOMBREPRODUCTO','ASC')"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a></th>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></th>
			<th class="w100px"><a href="javascript:OrdenarPor('NUMPEDIDOS','DESC')"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/></a></th>
			<th class="w100px"><a href="javascript:OrdenarPor('CANTIDADTOTAL','DESC')"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></a></th>
			<th class="w100px"><a href="javascript:OrdenarPor('TOTAL','DESC')"><xsl:value-of select="document($doc)/translation/texts/item[@name='Total_linea']/node()"/></a></th>
		</thead>
		<tbody class="corpo_tabela">
		<xsl:choose>
		<xsl:when test="/PedidosPorProducto/PRODUCTOS/COMPRADOR/NUMERO_LINEAS = '0'">
			<tr class="lejenda">
				<td class="color_status"><xsl:value-of select="CONTADOR"/></td>
				<td colspan="6"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_pedidos_para_busqueda']/node()"/></td>
			</tr>
		</xsl:when>
		<xsl:otherwise>
			<tr class="conhover" style="border-bottom:1px solid #A7A8A9;">
			</tr>
			<xsl:for-each select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/PRODUCTO">
				<tr class="conhover">
					<td class="color_status"><xsl:value-of select="CONTADOR"/></td>
					<td class="textLeft"><xsl:value-of select="REF_CLIENTE"/></td>
					<td class="textLeft"><xsl:value-of select="NOMBRE"/></td>
					<td class="textLeft"><xsl:value-of select="UNIDADBASICA"/></td>
					<td class="textRight"><xsl:value-of select="NUMERO_PEDIDOS"/>&nbsp;</td>
					<td class="textRight"><xsl:value-of select="TOTAL_CANTIDAD"/>&nbsp;</td>
					<td class="textRight"><xsl:value-of select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/DIVISA/PREFIJO"/><xsl:value-of select="TOTAL_IMPORTE"/><xsl:value-of select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/DIVISA/SUFIJO"/>&nbsp;</td>
				</tr>
			</xsl:for-each>
			<tr class="conhover">
				<td class="color_status">&nbsp;</td>
				<td class="textCenter">&nbsp;</td>
				<td class="textLeft">&nbsp;</td>
				<td class="textRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:&nbsp;</td>
				<td class="textRight"><strong><xsl:value-of select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/NUMERO_PEDIDOS"/></strong>&nbsp;</td>
				<td class="textRight"><strong><xsl:value-of select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/TOTAL_CANTIDAD"/></strong>&nbsp;</td>
				<td class="textRight"><strong><xsl:value-of select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/DIVISA/PREFIJO"/><xsl:value-of select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/TOTAL_IMPORTE"/><xsl:value-of select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/DIVISA/SUFIJO"/></strong>&nbsp;</td>
			</tr>
		</xsl:otherwise>
		</xsl:choose><!--fin de choose si hay pedidos-->
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="7">&nbsp;</td></tr>
		</tfoot>
	</table>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
    </div>
    </div>
</xsl:template><!--FIN DE TEMPLATE analisis-->

<!--buscador para admin mvm en analisis-->
<xsl:template name="buscador">
	<xsl:variable name="lang">
		<xsl:value-of select="/PedidosPorProducto/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>

	<!--table select-->
	<table cellspacing="6px" cellpadding="6px">
	<tr>
		<th class="w10px">&nbsp;</th>
      	<xsl:choose>
			<xsl:when test="/PedidosPorProducto/PRODUCTOS/COMPRADOR/FILTROS/IDEMPRESA">
        		<th class="w140px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:</label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/FILTROS/IDEMPRESA/field"/>
						<xsl:with-param name="claSel">w140px</xsl:with-param>
					</xsl:call-template>
        		</th>
			</xsl:when>
			<xsl:otherwise>
       			<th class="zerouno">
          		<input type="hidden" name="IDEMPRESA" value="{/PedidosPorProducto/PRODUCTOS/COMPRADOR/IDEMPRESA}"/>
        		</th>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:if test="/PedidosPorProducto/PRODUCTOS/COMPRADOR/FILTROS/IDCENTRO">
       		<th class="w160px textLeft">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</label><br />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/FILTROS/IDCENTRO/field"/>
					<xsl:with-param name="claSel">w160px</xsl:with-param>
				</xsl:call-template>
			</th>
		</xsl:if>
		<th class="w160px textLeft">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label><br />
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/PedidosPorProducto/PRODUCTOS/COMPRADOR/FILTROS/IDPROVEEDOR/field"/>
				<xsl:with-param name="claSel">w160px</xsl:with-param>
			</xsl:call-template>
		</th>
		<th class="w150px textLeft">
			<!--fecha inicio-->
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:</label><br />
			<input type="text" name="FPRODUCTO" class="campopesquisa w150px" value="{/PedidosPorProducto/PRODUCTOS/COMPRADOR/FPRODUCTO}" size="20"/>
		</th>
		<th class="w120px textLeft">
			<input class="muypeq" type="checkbox" name="FINALIZADOS_CHECK" id="FINALIZADOS_CHECK" onChange="javascript:chkPendienteOFinalizadoChange('FINALIZADOS');">
			<xsl:if test="/PedidosPorProducto/PRODUCTOS/COMPRADOR/FINALIZADOS = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>	
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Finalizados']/node()"/></label>
			<input type="hidden" name="FINALIZADOS" id="FINALIZADOS" value="{/PedidosPorProducto/PRODUCTOS/COMPRADOR/FINALIZADOS}"/>
		</th>
		<th class="w120px textLeft">
			<input class="muypeq" type="checkbox" name="PENDIENTES_CHECK" id="PENDIENTES_CHECK" onChange="javascript:chkPendienteOFinalizadoChange('PENDIENTES');">
			<xsl:if test="PENDIENTES = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>	
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Pendientes']/node()"/></label>
			<input type="hidden" name="PENDIENTES" id="PENDIENTES" value="{/PedidosPorProducto/PRODUCTOS/COMPRADOR/PENDIENTES}"/>
		</th>
		<th class="w120px textLeft">
			<input class="muypeq" type="checkbox" name="URGENTES_CHECK" id="URGENTES_CHECK">
			<xsl:if test="URGENTES = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Urgentes']/node()"/></label>
			<input type="hidden" name="URGENTES" id="URGENTES" value="{/PedidosPorProducto/PRODUCTOS/COMPRADOR/URGENTES}"/>
		</th>
		<th class="w100px textLeft fondoGris">
			<!--fecha inicio-->
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_inicio']/node()"/>:</label><br />
			<input type="text" name="FECHA_INICIO" class="campopesquisa w100px" value="{/PedidosPorProducto/PRODUCTOS/COMPRADOR/FECHAINICIO}" size="9" />
		</th>
		<th class="w100px textLeft fondoGris">
			<!--fecha final-->
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_final']/node()"/>:</label><br />
			<input type="text" name="FECHA_FINAL" class="campopesquisa w100px" value="{/PedidosPorProducto/PRODUCTOS/COMPRADOR/FECHAFINAL}"  size="9"  />
		</th>
		<th class="w140px textLeft fondoGris">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='utilizar_fechas']/node()"/>:</label><br />
            <input type="radio" class="peq" name="UTILFECHAENTREGA" id="UTILFECHAEMISSION" value="N">
			<xsl:if test="/PedidosPorProducto/PRODUCTOS/COMPRADOR/UTILIZARFECHACONFIRMACION != 'S'">
				<xsl:attribute name="checked">checked</xsl:attribute>
			</xsl:if>
			</input>
            &nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/></label>
			<br/>
			<input type="radio" class="peq" name="UTILFECHAENTREGA" id="UTILFECHAENTREGA" value="S">
			<xsl:if test="/PedidosPorProducto/PRODUCTOS/COMPRADOR/UTILIZARFECHACONFIRMACION = 'S'">
				<xsl:attribute name="checked">checked</xsl:attribute>
			</xsl:if>
			</input>
			&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='final']/node()"/></label>&nbsp;
		</th>
		<th class="w100px textLeft">
			<a href="javascript:AplicarFiltro();" class="btnDestacado">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
			</a>
		</th>
    	<th>&nbsp;</th>
	</tr>
	</table>
</xsl:template>
<!--fin de buscador admin-->


  <xsl:template match="Sorry">
    <p class="tituloCamp"><font color="#EEFFFF">
    	<xsl:value-of select="document($doc)/translation/texts/item[@name='no_elementos_pendientes']/node()"/>
	</font></p>
  </xsl:template>

</xsl:stylesheet>
