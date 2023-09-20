<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Analisis de pedidos, agregados por proveedor y centro
	Ultima revision: ET 7jun22 12:00 ResumenPedidosPorProveedor2022_180322.js
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
		<xsl:when test="/ResumenPedidosPorProveedor/LANG"><xsl:value-of select="/ResumenPedidosPorProveedor/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<meta http-equiv="Cache-Control" Content="no-cache"/>
        <title><xsl:value-of select="document($doc)/translation/texts/item[@name='Resumen_pedidos_por_proveedor']/node()"/>:&nbsp;<xsl:value-of select="/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/TITULO" /></title>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<!--	11ene22 nuevos estilos -->
	<!--<link rel="stylesheet" href="http://www.newco.dev.br/General/basicMVM2022.css"/>-->
	<link href='http://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'/>
	<!--	11ene22 nuevos estilos -->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.base64.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>		<!-- Para descargas excel	-->
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/EIS/ResumenPedidosPorProveedor2022_180322.js"></script>
	<script type="text/javascript">
	var strCabeceraExcelPrinc='<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>;<xsl:value-of select="document($doc)/translation/texts/item[@name='nif']/node()"/>;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>;<xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>;<xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>(<xsl:value-of select="/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/DIVISA/PREFIJO"/><xsl:value-of select="/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/DIVISA/SUFIJO"/>)';

	var numColumnas=0;
	var arrProveedores			= new Array();
	<xsl:for-each select="/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/PROVEEDOR">
		var Proveedor			= [];
		
		Proveedor['ID']	= '<xsl:value-of select="ID"/>';
		Proveedor['Nombre']	= '<xsl:value-of select="NOMBRE"/>';
		Proveedor['NIF']	= '<xsl:value-of select="NIF"/>';
		Proveedor['Pedidos']	= '<xsl:value-of select="NUMERO_PEDIDOS"/>';
		Proveedor['Lineas']	= '<xsl:value-of select="NUMERO_LINEAS"/>';
		Proveedor['Total']	= '<xsl:value-of select="TOTAL_PEDIDOS"/>';

		arrProveedores.push(Proveedor);
	</xsl:for-each>
	
	//	Cadenas para el CSV
	var strInforme='<xsl:value-of select="document($doc)/translation/texts/item[@name='Resumen_pedidos_por_proveedor']/node()"/>';

	var strTitulo='<xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>';
	var Titulo='<xsl:value-of select="/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/TITULO"/>';

	var strFechaInforme='<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_informe']/node()"/>';
	var FechaInforme='<xsl:value-of select="/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/FECHAACTUAL"/>';

	var strFechaInicio='<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_inicio']/node()"/>';
	var FechaInicio='<xsl:value-of select="/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/FECHAINICIO"/>';

	var strFechaFinal='<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_final']/node()"/>';
	var FechaFinal='<xsl:value-of select="/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/FECHAFINAL"/>';

	var strCentro='<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>';
	var Centro='<xsl:value-of select="/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/NOMBRECENTRO"/>';

	var strProveedor='<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>';
	var Proveedor='<xsl:value-of select="/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/NOMBREPROVEEDOR"/>';

	var strProveedores='<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>';
	var Proveedores='<xsl:value-of select="/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/NUMERO_PROVEEDORES"/>';

	var strPedidos='<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>';
	var Pedidos='<xsl:value-of select="/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/NUMERO_PEDIDOS"/>';

	var Lineas='<xsl:value-of select="/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/NUMERO_LINEAS"/>';

	var strTotal='<xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>';
	var Total='<xsl:value-of select="/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/TOTAL_PEDIDOS"/>';
	
	var strDiv='<xsl:value-of select="/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/DIVISA/PREFIJO"/><xsl:value-of select="/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/DIVISA/SUFIJO"/>';
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


	<form  method="post" name="Form1" action="ResumenPedidosPorProveedor2022.xsql">

	<xsl:choose>
	<!-- Error en alguna sentencia del XSQL -->
	<xsl:when test="/ResumenPedidosPorProveedor/INICIO/xsql-error">
		<xsl:apply-templates select="PedidosPorProveedor/INICIO/xsql-error"/>
	</xsl:when>
	<xsl:when test="/ResumenPedidosPorProveedor/INICIO/SESION_CADUCADA">
		<xsl:for-each select="/ResumenPedidosPorProveedor/INICIO/SESION_CADUCADA">
			<xsl:if test="position()=last()">
				<xsl:apply-templates select="."/>
			</xsl:if>
		</xsl:for-each>
	</xsl:when>
	<xsl:otherwise>
		<div class="divLeft">
             <xsl:call-template name="PROVEEDORES"/>
		</div>
	</xsl:otherwise>
	</xsl:choose>
	</form>

</body>
</html>
</xsl:template>


<!--ADMIN DE MVM-->
<xsl:template name="PROVEEDORES">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/ResumenPedidosPorProveedor/LANG"><xsl:value-of select="/ResumenPedidosPorProveedor/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->


	<div class="divLeft boxInicio" id="pedidosBox" style="border:1px solid #939494;border-top:0;">

	<input type="hidden" name="IDPRODUCTO" value="{/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/IDPRODUCTO}"/>
	<input type="hidden" name="IDPRODESTANDAR" value="{/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/IDPRODESTANDAR}"/>
	<input type="hidden" name="IDLICITACION" value="{/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/IDLICITACION}"/>

	<xsl:for-each select="/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR">
	<input type="hidden" name="ORDEN" value="{/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/ORDEN}"/>
	<input type="hidden" name="IDEMPRESAUSUARIO" value="{/ResumenPedidosPorProveedor/PROVEEDORES/IDEMPRESAUSUARIO}"/>


	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:value-of select="/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/TITULO" />&nbsp;
			<span class="fuentePeq">(<xsl:value-of select="../FECHAACTUAL"/>)</span>
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

	<input type="hidden" name="PAGINA" id="PAGINA" value="{PAGINA}"/>
	<xsl:call-template name="buscador"/>
	<br/>
	<div class="tabela tabela_redonda">
	<table class="tableCenter w1000px" cellspacing="6px" cellpadding="6px">
		<xsl:choose>
		<xsl:when test="/ResumenPedidosPorProveedor/PROVEEDORES/TOTAL = '0'">
			<tr><th colspan="17"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_pedidos_para_busqueda']/node()"/></th></tr>
		</xsl:when>
		<xsl:otherwise>
			<thead class="cabecalho_tabela">
			<tr class="conhover" style="border-bottom:1px solid #A7A8A9;">
				<th class="w1px">&nbsp;</th>
				<th class="textLeft"><a href="javascript:OrdenarPor('PROVEEDOR','ASC')"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a></th>
				<th class="w150px"><a href="javascript:OrdenarPor('NIFPROVEEDOR','ASC')"><xsl:value-of select="document($doc)/translation/texts/item[@name='nif']/node()"/></a></th>
				<th class="w150px"><a href="javascript:OrdenarPor('NUMPEDIDOS','DESC')"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/></a></th>
				<th class="w150px"><a href="javascript:OrdenarPor('NUMLINEAS','DESC')"><xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/></a></th>
				<th class="w150px"><a href="javascript:OrdenarPor('TOTAL','DESC')"><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/></a></th>
				<th class="w1px">&nbsp;</th>
			</tr>
			</thead>
			<!--	Cuerpo de la tabla	-->
			<tbody class="corpo_tabela">
			<xsl:for-each select="PROVEEDOR">
				<tr class="conhover">
					<td class="textCenter color_status"><xsl:value-of select="CONTADOR"/></td>
					<td class="textLeft"><xsl:value-of select="NOMBRE"/></td>
					<td class="textLeft"><xsl:value-of select="NIF"/></td>
					<td class="textRight"><xsl:value-of select="NUMERO_PEDIDOS"/>&nbsp;</td>
					<td class="textRight"><xsl:value-of select="NUMERO_LINEAS"/>&nbsp;</td>
					<td class="textRight"><xsl:value-of select="/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/DIVISA/PREFIJO"/><xsl:value-of select="TOTAL_PEDIDOS"/><xsl:value-of select="/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/DIVISA/SUFIJO"/>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</xsl:for-each>
            </tbody>
			<tfoot class="rodape_tabela">
			<tr>
				<td class="textLeft">&nbsp;</td>
				<td class="textCenter">&nbsp;</td>
				<td class="textLeft">&nbsp;</td>
				<td class="textRight"><strong><xsl:value-of select="/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/NUMERO_PEDIDOS"/></strong>&nbsp;</td>
				<td class="textRight"><strong><xsl:value-of select="/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/NUMERO_LINEAS"/></strong>&nbsp;</td>
				<td class="textRight"><strong><xsl:value-of select="/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/DIVISA/PREFIJO"/><xsl:value-of select="/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/TOTAL_PEDIDOS"/><xsl:value-of select="/ResumenPedidosPorProveedor/PROVEEDORES/COMPRADOR/DIVISA/SUFIJO"/></strong>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			</tfoot>
	</xsl:otherwise>
	</xsl:choose><!--fin de choose si hay pedidos-->
	</table>
	</div>
	<br/>
	<br/>
	<br/>
    </xsl:for-each>
	<br/><br/><br/><br/><br/><br/><br/>
    </div>

</xsl:template><!--FIN DE TEMPLATE analisis-->

<!--buscador para admin mvm en analisis-->
<xsl:template name="buscador">
	<xsl:variable name="lang">
		<xsl:value-of select="/ResumenPedidosPorProveedor/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>

	<table class="buscador" border="0">
		<tr class="filtros">
		<th class="w50px">&nbsp;</th>
      	<xsl:choose>
			<xsl:when test="FILTROS/IDEMPRESA">
        		<th width="180px" style="text-align:left;">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:</label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="FILTROS/IDEMPRESA/field"/>
						<xsl:with-param name="claSel">w170px</xsl:with-param>
					</xsl:call-template>
        		</th>
			</xsl:when>
			<xsl:otherwise>
       			<th class="zerouno">
          		<input type="hidden" name="IDEMPRESA" value="{IDEMPRESA}"/>
        		</th>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="FILTROS/IDCENTRO">
			<th width="180px" style="text-align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</label><br />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="FILTROS/IDCENTRO/field"/>
					<xsl:with-param name="claSel">w170px</xsl:with-param>
				</xsl:call-template>
			</th>
		</xsl:if>
		<th  width="180px" style="text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label><br />
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="FILTROS/IDPROVEEDOR/field"/>
				<xsl:with-param name="claSel">w170px</xsl:with-param>
			</xsl:call-template>
		</th>
		<th class="w160px textLeft">
			<input class="muypeq" type="checkbox" name="FINALIZADOS_CHECK" id="FINALIZADOS_CHECK" onChange="javascript:chkPendienteOFinalizadoChange('FINALIZADOS');">
			<xsl:if test="FINALIZADOS = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>	
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Finalizados']/node()"/></label>
			<input type="hidden" name="FINALIZADOS" id="FINALIZADOS" value="{FINALIZADOS}"/>
		</th>
		<th class="w160px textLeft">
			<input class="muypeq" type="checkbox" name="PENDIENTES_CHECK" id="PENDIENTES_CHECK" onChange="javascript:chkPendienteOFinalizadoChange('PENDIENTES');">
			<xsl:if test="PENDIENTES = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>	
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Pendientes']/node()"/></label>
			<input type="hidden" name="PENDIENTES" id="PENDIENTES" value="{PENDIENTES}"/>
		</th>
		<th class="w160px textLeft">
			<input class="muypeq" type="checkbox" name="URGENTES_CHECK" id="URGENTES_CHECK">
			<xsl:if test="URGENTES = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Urgentes']/node()"/></label>
			<input type="hidden" name="URGENTES" id="URGENTES" value="{URGENTES}"/>
		</th>
		<th class="w140px fondoGris">
			<!--fecha inicio-->
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_inicio']/node()"/>:</label><br />
			<input type="text" class="campopesquisa w100px fondoGris" name="FECHA_INICIO" value="{FECHAINICIO}" size="9" />
		</th>
		<th class="w140px fondoGris">
			<!--fecha final-->
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_final']/node()"/>:</label><br />
			<input type="text" class="campopesquisa w100px" name="FECHA_FINAL" value="{FECHAFINAL}"  size="9"  />
		</th>
		<th class="w160px textLeft fondoGris">
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
     	<th width="100px">
			<a href="javascript:AplicarFiltro();" title="Buscar" class="btnDestacado">
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
