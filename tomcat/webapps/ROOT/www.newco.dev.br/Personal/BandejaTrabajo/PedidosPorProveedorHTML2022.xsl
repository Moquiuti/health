<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Analisis de pedidos, agregados por proveedor y centro
	Ultima revision ET 17mar22 12:00 PedidosPorProveedor2022_170322.js
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
		<xsl:when test="/PedidosPorProveedor/LANG"><xsl:value-of select="/PedidosPorProveedor/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<meta http-equiv="Cache-Control" Content="no-cache"/>

        <title><xsl:value-of select="document($doc)/translation/texts/item[@name='analisis_pedidos']/node()"/>:&nbsp;<xsl:value-of select="/PedidosPorProveedor/LINEASPEDIDOS/COMPRADOR/TITULO" /></title>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<!--	11ene22 nuevos estilos -->
	<!--<link rel="stylesheet" href="http://www.newco.dev.br/General/basicMVM2022.css"/>-->
	<link href='http://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'/>
	<!--	11ene22 nuevos estilos -->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>

	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>-->
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.base64.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>									<!-- Para descargas excel	-->
	<script type="text/javascript" src="http://www.newco.dev.br/Personal/BandejaTrabajo/PedidosPorProveedor2022_170322.js"></script>
	<script type="text/javascript">
	var strCabeceraExcelPrinc='<xsl:value-of select="document($doc)/translation/texts/item[@name='Cabecera_Princ_CSV_proveedoresypedidos']/node()"/>';

	var numColumnas=0;
	var arrProveedores			= new Array();
	<xsl:for-each select="/PedidosPorProveedor/LINEASPEDIDOS/COMPRADOR/PROVEEDOR">
		var Proveedor			= [];
		
		Proveedor['ID']	= '<xsl:value-of select="ID"/>';
		Proveedor['Nombre']	= '<xsl:value-of select="NOMBRE"/>';
		Proveedor['NIF']	= '<xsl:value-of select="NIF"/>';
		Proveedor['Total']	= '<xsl:value-of select="TOTAL_PROVEEDOR"/>';
		Proveedor['Unidades']	= '<xsl:value-of select="UNIDADES_PROVEEDOR"/>';

		Proveedor['Centros']	= new Array();

		<xsl:for-each select="CENTRO">
			var centro		= [];
			centro['ID']	= '<xsl:value-of select="ID"/>';
			centro['Nombre']	= '<xsl:value-of select="NOMBRE"/>';
			centro['Total']	= '<xsl:value-of select="TOTAL_CENTRO"/>';
			centro['Unidades']	= '<xsl:value-of select="UNIDADES_CENTRO"/>';
			
			centro['Pedidos']	= new Array();
			
			<xsl:for-each select="PEDIDO">
				var pedido		= [];
		
				pedido['ID']	= '<xsl:value-of select="MO_ID"/>';
				pedido['Fecha']	= '<xsl:value-of select="FECHA_PEDIDO"/>';
				pedido['Numero']= '<xsl:value-of select="NUMERO_PEDIDO"/>';
				pedido['IDLicitacion']	= '<xsl:value-of select="LIC_ID"/>';
				pedido['Codigo']= '<xsl:value-of select="LIC_CODIGO"/>';
				pedido['Titulo']= '<xsl:value-of select="LIC_TITULO"/>';
				pedido['Total']	= '<xsl:value-of select="TOTAL_PEDIDO"/>';

				centro['Pedidos'].push(pedido);
			</xsl:for-each>
		
			Proveedor['Centros'].push(centro);
		</xsl:for-each>
		arrProveedores.push(Proveedor);
	</xsl:for-each>
	
	//	Cadenas para el CSV
	var strInforme='<xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_por_proveedor_y_centro']/node()"/>';

	var strTitulo='<xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>';
	var Titulo='<xsl:value-of select="/OfertasSeleccionadas/LINEASPEDIDOS/COMPRADOR/TITULO"/>';

	var strFechaInforme='<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_informe']/node()"/>';
	var FechaInforme='<xsl:value-of select="/PedidosPorProveedor/LINEASPEDIDOS/COMPRADOR/FECHAACTUAL"/>';

	var strFechaInicio='<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_inicio']/node()"/>';
	var FechaInicio='<xsl:value-of select="/PedidosPorProveedor/LINEASPEDIDOS/COMPRADOR/FECHAINICIO"/>';

	var strFechaFinal='<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_final']/node()"/>';
	var FechaFinal='<xsl:value-of select="/PedidosPorProveedor/LINEASPEDIDOS/COMPRADOR/FECHAFINAL"/>';

	var strCentro='<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>';
	var Centro='<xsl:value-of select="/PedidosPorProveedor/LINEASPEDIDOS/COMPRADOR/NOMBRECENTRO"/>';

	var strProveedor='<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>';
	var Proveedor='<xsl:value-of select="/PedidosPorProveedor/LINEASPEDIDOS/COMPRADOR/NOMBREPROVEEDOR"/>';

	var strProveedores='<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>';
	var Proveedores='<xsl:value-of select="/PedidosPorProveedor/LINEASPEDIDOS/COMPRADOR/NUMERO_PROVEEDORES"/>';

	var strPedidos='<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>';
	var Pedidos='<xsl:value-of select="/PedidosPorProveedor/LINEASPEDIDOS/COMPRADOR/NUMERO_PEDIDOS"/>';

	var strTotal='<xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>';
	var Total='<xsl:value-of select="/PedidosPorProveedor/LINEASPEDIDOS/COMPRADOR/TOTAL_PEDIDOS"/>';
	
	var strDiv='<xsl:value-of select="/PedidosPorProveedor/LINEASPEDIDOS/COMPRADOR/DIVISA/PREFIJO"/><xsl:value-of select="/PedidosPorProveedor/LINEASPEDIDOS/COMPRADOR/DIVISA/SUFIJO"/>';
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


	<form  method="post" name="Form1" action="PedidosPorProveedor.xsql">

	<xsl:choose>
	<!-- Error en alguna sentencia del XSQL -->
	<xsl:when test="PedidosPorProveedor/INICIO/xsql-error">
		<xsl:apply-templates select="PedidosPorProveedor/INICIO/xsql-error"/>
	</xsl:when>
	<xsl:when test="PedidosPorProveedor/INICIO/SESION_CADUCADA">
		<xsl:for-each select="PedidosPorProveedor/INICIO/SESION_CADUCADA">
			<xsl:if test="position()=last()">
				<xsl:apply-templates select="."/>
			</xsl:if>
		</xsl:for-each>
	</xsl:when>
	<xsl:otherwise>
		<div class="divLeft">
             <xsl:call-template name="PEDIDOSPORPROVEEDOR"/>
		</div>
	</xsl:otherwise>
	</xsl:choose>
	</form>

</body>
</html>
</xsl:template>


<!--ADMIN DE MVM-->
<xsl:template name="PEDIDOSPORPROVEEDOR">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/PedidosPorProveedor/LANG"><xsl:value-of select="/PedidosPorProveedor/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->


	<div class="divLeft boxInicio" id="pedidosBox" style="border:1px solid #939494;border-top:0;">

	<input type="hidden" name="IDPRODUCTO" value="{/PedidosPorProveedor/LINEASPEDIDOS/COMPRADOR/IDPRODUCTO}"/>
	<input type="hidden" name="IDPRODESTANDAR" value="{/PedidosPorProveedor/LINEASPEDIDOS/COMPRADOR/IDPRODESTANDAR}"/>
	<input type="hidden" name="IDLICITACION" value="{/PedidosPorProveedor/LINEASPEDIDOS/COMPRADOR/IDLICITACION}"/>

	<xsl:for-each select="/PedidosPorProveedor/LINEASPEDIDOS/COMPRADOR">
	<input type="hidden" name="ORDEN" value="{./ORDEN}"/>
	<input type="hidden" name="SENTIDO" value="{./SENTIDO}"/>
	<input type="hidden" name="IDEMPRESAUSUARIO" value="{./IDEMPRESAUSUARIO}"/>


	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:value-of select="/PedidosPorProveedor/LINEASPEDIDOS/COMPRADOR/TITULO" />&nbsp;
			<span class="fuentePeq">(<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>:&nbsp;<xsl:value-of select="/PedidosPorProveedor/LINEASPEDIDOS/COMPRADOR/NUMERO_PROVEEDORES" />, &nbsp;
				<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>:&nbsp;<xsl:value-of select="/PedidosPorProveedor/LINEASPEDIDOS/COMPRADOR/NUMERO_PEDIDOS" />, &nbsp;
				<xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:&nbsp;<xsl:value-of select="/PedidosPorProveedor/LINEASPEDIDOS/COMPRADOR/DIVISA/PREFIJO"/><xsl:value-of select="/PedidosPorProveedor/LINEASPEDIDOS/COMPRADOR/TOTAL_PEDIDOS" /><xsl:value-of select="/PedidosPorProveedor/LINEASPEDIDOS/COMPRADOR/DIVISA/SUFIJO"/>, &nbsp;
				<xsl:value-of select="../FECHAACTUAL"/>)
			</span>
			<span class="CompletarTitulo300">
				<a class="btnNormal" href="javascript:DescargarExcel();"><xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/></a>
				&nbsp;
				<a class="btnNormal" href="javascript:window.print()" style="margin-right:30px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
				&nbsp;
			</span>
		</p>
	</div>
	<br/>
	<br/>

	<!--<table class="grandeInicio" border="0">-->

	<xsl:call-template name="buscador"/>
	<input type="hidden" name="PAGINA" id="PAGINA" value="{PAGINA}"/>
	<xsl:choose>
	<xsl:when test="/PedidosPorProveedor/LINEASPEDIDOS/TOTAL = '0'">
		<div class="tabela tabela_redonda">
		<table cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
			<tr><th colspan="17">&nbsp;</th></tr>
		</thead>
    	<tbody>
			<tr><td colspan="17"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_pedidos_para_busqueda']/node()"/></td></tr>
    	</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="17">&nbsp;</td></tr>
		</tfoot>
		</table>
		</div>
	</xsl:when>
	<xsl:otherwise>
		<xsl:for-each select="PROVEEDOR">
			<div class="tabela tabela_redonda marginTop20">
			<table cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
			<tr>
				<th class="textLeft w1px">&nbsp;</th>
				<th class="textCenter" colspan="6"><xsl:value-of select="NOMBRE"/>&nbsp;(<xsl:value-of select="NIF"/>)</th>
				<th class="textLeft w1px">&nbsp;</th>
			</tr>
			<tr>
				<th>&nbsp;</th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_pedido']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='Total_linea']/node()"/></th>
				<th>&nbsp;</th>
			</tr>
			</thead>
			<tbody class="corpo_tabela">
			<xsl:for-each select="CENTRO/PEDIDO">
				<tr class="conhover" style="border-bottom:1px solid #A7A8A9;">
					<td class="color_status">
						<xsl:value-of select="CONTADOR"/>
					</td>
					<td class="textLeft">&nbsp;<xsl:value-of select="../NOMBRE"/></td>
					<td>
						<a>
							<xsl:attribute name="href">javascript:FichaPedido('<xsl:value-of select="MO_ID"/>','Multioferta',100,100,0,0)</xsl:attribute>
							<xsl:value-of select="NUMERO_PEDIDO"/>
						</a>
					</td>
					<td>
						<a>
							<xsl:attribute name="href">javascript:FichaLicitacion('<xsl:value-of select="LIC_ID"/>');</xsl:attribute>
							<xsl:value-of select="LIC_CODIGO"/>
						</a>
					</td>
					<td class="textLeft">
						&nbsp;<a>
							<xsl:attribute name="href">javascript:FichaLicitacion('<xsl:value-of select="LIC_ID"/>');</xsl:attribute>
							<xsl:value-of select="LIC_TITULO"/>
						</a>
					</td>
                    <td><xsl:value-of select="FECHA_PEDIDO"/></td>
                    <td><xsl:value-of select="UNIDADES_PEDIDO"/></td>
                   	<td><xsl:value-of select="/PedidosPorProveedor/LINEASPEDIDOS/COMPRADOR/DIVISA/PREFIJO"/><xsl:value-of select="TOTAL_PEDIDO"/><xsl:value-of select="/PedidosPorProveedor/LINEASPEDIDOS/COMPRADOR/DIVISA/SUFIJO"/></td>
					<td class="uno">&nbsp;</td>
				</tr>
			</xsl:for-each>  <!--fin de pedidos-->
    		</tbody>
			<tfoot class="rodape_tabela">
				<tr>
					<td colspan="6">&nbsp;</td>
					<td colspan="1"><xsl:value-of select="UNIDADES_PROVEEDOR"/></td>
					<td colspan="1"><xsl:value-of select="/PedidosPorProveedor/LINEASPEDIDOS/COMPRADOR/DIVISA/PREFIJO"/><xsl:value-of select="TOTAL_PROVEEDOR"/><xsl:value-of select="/PedidosPorProveedor/LINEASPEDIDOS/COMPRADOR/DIVISA/SUFIJO"/></td>
					<td colspan="1">&nbsp;</td>
				</tr>
			</tfoot>
			</table>
			</div>
		</xsl:for-each>  <!--fin de proveedor>	-->
	</xsl:otherwise>
	</xsl:choose><!--fin de choose si hay pedidos-->
    </xsl:for-each>
    </div>

</xsl:template><!--FIN DE TEMPLATE analisis-->

<!--buscador para admin mvm en analisis-->
<xsl:template name="buscador">
	<xsl:variable name="lang">
		<xsl:value-of select="/PedidosPorProveedor/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>

	<div class="divleft">
	<table cellspacing="2px" cellpadding="2px">
		<tr>
		<th class="w50px">&nbsp;</th>
		<th class="w110px textLeft">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>:</label><br />
			<input type="text" class="campopesquisa w100px" name="CODIGOPEDIDO" maxlength="20" value="{CODIGOPEDIDO}"/>
		</th>
      	<!--th idempresa-->
      	<xsl:choose>
			<xsl:when test="FILTROS/IDEMPRESA">
        		<th class="w140px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:</label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="FILTROS/IDEMPRESA/field"/>
           				<xsl:with-param name="claSel">w140px</xsl:with-param>
					</xsl:call-template>
        		</th>
			</xsl:when>
			<xsl:otherwise>
       			<th class="zerouno">
          		<input type="hidden" name="IDEMPRESA" value="{IDEMPRESA}"/>
        		</th>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:if test="FILTROS/IDCENTROCONSUMO">
			<th class="w150px textLeft">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_consumo']/node()"/>:</label><br />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="FILTROS/IDCENTROCONSUMO/field"/>
           			<xsl:with-param name="claSel">w140px</xsl:with-param>
				</xsl:call-template>
			</th>
		</xsl:if>

		<xsl:if test="FILTROS/IDCENTRO and not (FILTROS/IDCENTROCONSUMO)">
			<th class="w210px textLeft">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</label><br />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="FILTROS/IDCENTRO/field"/>
           			<xsl:with-param name="claSel">w200px</xsl:with-param>
				</xsl:call-template>
			</th>
		</xsl:if>
		
		<th class="w210px textLeft">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label><br />
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="FILTROS/IDPROVEEDOR/field"/>
           		<xsl:with-param name="claSel">w200px</xsl:with-param>
			</xsl:call-template>
		</th>
		<xsl:if test="/PedidosPorProveedor/LINEASPEDIDOS/COMPRADOR/IDPRODESTANDAR=''">
		<th class="w130px textLeft">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:</label><br />
			<input type="text" class="campopesquisa w120px" name="PRODUCTO" size="30" maxlength="20" value="{PRODUCTO}"/>
		</th>
		</xsl:if>
		<th class="w140px textLeft">
			<input class="muypeq" type="checkbox" name="FINALIZADOS_CHECK" id="FINALIZADOS_CHECK" onChange="javascript:chkPendienteOFinalizadoChange('FINALIZADOS');">
			<xsl:if test="FINALIZADOS = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>	
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Finalizados']/node()"/></label>
			<input type="hidden" name="FINALIZADOS" id="FINALIZADOS" value="{FINALIZADOS}"/>
			<br/>
			<input class="muypeq" type="checkbox" name="PENDIENTES_CHECK" id="PENDIENTES_CHECK" onChange="javascript:chkPendienteOFinalizadoChange('PENDIENTES');">
			<xsl:if test="PENDIENTES = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>	
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Pendientes']/node()"/></label>
			<input type="hidden" name="PENDIENTES" id="PENDIENTES" value="{PENDIENTES}"/>
			<br/>
			<input class="muypeq" type="checkbox" name="URGENTES_CHECK" id="URGENTES_CHECK">
			<xsl:if test="URGENTES = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Urgentes']/node()"/></label>
			<input type="hidden" name="URGENTES" id="URGENTES" value="{URGENTES}"/>
		</th>
		<th class="w100px textLeft fondoGris">
			<!--fecha inicio-->
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_inicio']/node()"/>:</label><br />
			<input type="text" class="campopesquisa w80px amarillo" name="FECHA_INICIO" value="{FECHAINICIO}" size="9"/>
		</th>
		<th class="w100px textLeft fondoGris">
			<!--fecha final-->
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_final']/node()"/>:</label><br />
			<input type="text" class="campopesquisa w80px" name="FECHA_FINAL" value="{FECHAFINAL}"  size="9"  />
		</th>
		<th class="w140px textLeft fondoGris">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='utilizar_fechas']/node()"/>:</label><br />
            <input type="radio" class="peq" name="UTILFECHAENTREGA" id="UTILFECHAEMISSION" value="N">
			<xsl:if test="UTILIZARFECHACONFIRMACION != 'S'">
				<xsl:attribute name="checked">checked</xsl:attribute>
			</xsl:if>
			</input>
            &nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/></label>
			<br/>
			<input type="radio" class="peq" name="UTILFECHAENTREGA" id="UTILFECHAENTREGA" value="S">
			<xsl:if test="UTILIZARFECHACONFIRMACION = 'S'">
				<xsl:attribute name="checked">checked</xsl:attribute>
			</xsl:if>
			</input>
			&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='final']/node()"/></label>&nbsp;
		</th>
     	<th class="w100px">
			<a href="javascript:AplicarFiltro();" title="Buscar" class="btnDestacado">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
			</a>
		</th>
    	<th>&nbsp;</th>
	</tr>
	</table>
	</div>
</xsl:template>
<!--fin de buscador admin-->


  <xsl:template match="Sorry">
    <p class="tituloCamp"><font color="#EEFFFF">
    	<xsl:value-of select="document($doc)/translation/texts/item[@name='no_elementos_pendientes']/node()"/>
	</font></p>
  </xsl:template>

</xsl:stylesheet>
