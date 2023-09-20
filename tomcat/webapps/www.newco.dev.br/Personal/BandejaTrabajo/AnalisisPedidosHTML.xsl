<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Analisis de pedidos, línea a línea
	Ultima revision 20set22 10:05 AnalisisPedidos_200922.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="usuario" select="@US_ID"/>

<xsl:template match="/">
<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/AnalisisPedidos/LANG"><xsl:value-of select="/AnalisisPedidos/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<meta http-equiv="Cache-Control" Content="no-cache"/>

        <title><xsl:value-of select="document($doc)/translation/texts/item[@name='analisis_pedidos']/node()"/>:&nbsp;<xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/TITULO" /></title>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Personal/BandejaTrabajo/AnalisisPedidos_200922.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.base64.js"></script>

	<script type="text/javascript">
		<!--20set22 var limite6Meses='<xsl:choose><xsl:when test="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/LIMITAR_CONSULTAS">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		var strInforme6mesesmaximo="<xsl:value-of select="document($doc)/translation/texts/item[@name='Maximo6Meses']/node()"/>";-->
		var limiteMeses='<xsl:choose><xsl:when test="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/LIMITAR_CONSULTAS">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		var plazoMaximo=12;		// antes 6 meses
		var strInformeMesesMaximo="<xsl:value-of select="document($doc)/translation/texts/item[@name='Informe_maximo_meses']/node()"/>";
	</script>
</head>
<body>
	<!--onLoad="javascript:EliminaCookies();"-->
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/WorkFlowPendientes/LANG"><xsl:value-of select="/WorkFlowPendientes/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->


	<form  method="post" name="Form1" action="AnalisisPedidos.xsql">

	<xsl:choose>
	<!-- Error en alguna sentencia del XSQL -->
	<xsl:when test="AnalisisPedidos/xsql-error">
		<xsl:apply-templates select="AnalisisPedidos/xsql-error"/>
	</xsl:when>
	<xsl:when test="AnalisisPedidos/SESION_CADUCADA">
		<xsl:for-each select="AnalisisPedidos/SESION_CADUCADA">
			<xsl:if test="position()=last()">
				<xsl:apply-templates select="."/>
			</xsl:if>
		</xsl:for-each>
	</xsl:when>
	<xsl:otherwise>
		<div class="divLeft">
             <xsl:call-template name="ANALISIS"/>
		</div>
	</xsl:otherwise>
	</xsl:choose>
	</form>

</body>
</html>
</xsl:template>


<!--ADMIN DE MVM-->
<xsl:template name="ANALISIS">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/AnalisisPedidos/LANG"><xsl:value-of select="/AnalisisPedidos/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->


	<div class="divLeft boxInicio" id="pedidosBox" style="border:1px solid #939494;border-top:0;">

	<input type="hidden" name="IDPRODUCTO" value="{/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/IDPRODUCTO}"/>
	<input type="hidden" name="IDPRODESTANDAR" value="{/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/IDPRODESTANDAR}"/>
	<input type="hidden" name="IDLICITACION" value="{/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/IDLICITACION}"/>

	<xsl:for-each select="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR">
	<input type="hidden" name="ORDEN" value="{./ORDEN}"/>
	<input type="hidden" name="SENTIDO" value="{./SENTIDO}"/>
	<input type="hidden" name="IDEMPRESAUSUARIO" value="{./IDEMPRESAUSUARIO}"/>


	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eis']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='analisis_pedidos']/node()"/></span></p>
		<p class="TituloPagina">
			<!--<xsl:if test="NOMBREPRODUCTO != ''">
				<xsl:value-of select="substring(NOMBREPRODUCTO,0,50)" />:&nbsp;
			</xsl:if>-->
			<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='analisis_pedidos']/node()"/>&nbsp;-->
			<xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/TITULO" />&nbsp;
			<span class="fuentePequenna">(<xsl:value-of select="../FECHAACTUAL"/>)</span>
			<span class="CompletarTitulo">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='pagina']/node()"/>&nbsp;
                <xsl:variable name="pagina">
                    <xsl:choose>
                        <xsl:when test="PAGINA != ''">
                            <xsl:value-of select="number(PAGINA)+number(1)"/>
                        </xsl:when>
                        <xsl:otherwise>1</xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:value-of select="$pagina" />&nbsp;
                <xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
                <xsl:value-of select="//BOTONES/NUMERO_PAGINAS" />&nbsp;
                <xsl:value-of select="document($doc)/translation/texts/item[@name='con']/node()"/>&nbsp;
                <xsl:value-of select="TOTAL_LINEAS"/>&nbsp;
                <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas_en_total']/node()"/>&nbsp;&nbsp;&nbsp;
				<xsl:if test="//ANTERIOR">
					<a class="btnNormal" href="javascript:AplicarFiltroPagina({//ANTERIOR/@Pagina});"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
				&nbsp;
				</xsl:if>
				<a class="btnNormal" href="javascript:DescargarExcel();"><img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel"/></a>
				&nbsp;
				<xsl:if test="//SIGUIENTE">
					<a class="btnNormal" href="javascript:AplicarFiltroPagina({//SIGUIENTE/@Pagina});">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>&nbsp;
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	<br/>

	<!--<table class="grandeInicio" border="0">-->
	<table class="buscador" border="0">
		<input type="hidden" name="PAGINA" id="PAGINA" value="{PAGINA}"/>
		<tr class="sinLinea">
			<td bgcolor="#E3E2E2" colspan="20">
				<!--	18dic18 Innecesario
                <xsl:choose>
                <xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN = 'MVM' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN = 'MVMB'">
                     <xsl:call-template name="buscador"/>
                </xsl:when>
                <xsl:otherwise><xsl:call-template name="buscador"/></xsl:otherwise>
                </xsl:choose>
				-->
				<xsl:call-template name="buscador"/>
            </td>
		</tr>

		<tr class="subTituloTabla">
			<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/></th>
			<th class="cerouno"></th>
			<th class="cerouno"></th>
			<th class="cinco">
				<a href="javascript:OrdenarPor('NUMERO_PEDIDO');">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>
				</a>
			</th>
            <th class="cinco">
				<a href="javascript:OrdenarPor('FECHA_EMISION');"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_emis']/node()"/></a>
			</th>
            <th class="cinco">
				<a href="javascript:OrdenarPor('FECHA_CONFIRMACION');"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_final']/node()"/></a>
			</th>
			<th class="diez" style="text-align:left;">
				&nbsp;<a href="javascript:OrdenarPor('CENTRO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></a>
			</th>
			<th class="diez" style="text-align:left;">
				&nbsp;<a href="javascript:OrdenarPor('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a>
			</th>
			<th class="cinco" style="text-align:left;">
				&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>
			</th>
			<th class="cinco" style="text-align:left;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>&nbsp;
			</th>
            <th class="veinte" style="text-align:left;">
				&nbsp;<a href="javascript:OrdenarPor('PRODUCTO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a>
			</th>
			<th style="width:120px;text-align:left;">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>
			</th>
			<th style="width:110px;text-align:left;">
				&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>
			</th>
			<th class="tres" align="right">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_lote']/node()"/>&nbsp;
			</th>
            <th class="tres" align="right">
             	<xsl:value-of select="document($doc)/translation/texts/item[@name='cant']/node()"/>&nbsp;
            </th>
			<xsl:if test="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/PENDIENTES='S'">
            <th class="tres" align="right">
             	<xsl:value-of select="document($doc)/translation/texts/item[@name='entr']/node()"/>&nbsp;
            </th>
			</xsl:if>
            	<th style="width:180px;">
            	<a href="javascript:OrdenarPor('PRECIO');">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>(<xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/DIVISA/PREFIJO"/><xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/DIVISA/SUFIJO"/>)
				</a>&nbsp;
            </th>
			<xsl:if test="MOSTRAR_PRECIO_HISTORICO">
            	<th style="width:180px;">
                	<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ref']/node()"/>
            	</th>
			</xsl:if>
            <th style="width:180px;">
                <xsl:choose>
                    <xsl:when test="../MOSTRAR_PRECIOS_CON_IVA">
						<a href="javascript:OrdenarPor('TOTALLINEACONIVA');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>(<xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/DIVISA/PREFIJO"/><xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/DIVISA/SUFIJO"/>)
						</a>
					</xsl:when>
                    <xsl:otherwise>
						<a href="javascript:OrdenarPor('TOTALLINEA');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>(<xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/DIVISA/PREFIJO"/><xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/DIVISA/SUFIJO"/>)
						</a>
					</xsl:otherwise>
                </xsl:choose>&nbsp;
            </th>
            <xsl:choose>
                <xsl:when test="MOSTRAR_PRECIO_HISTORICO">
                    <th style="width:120px;">
                        <a href="javascript:OrdenarPor('PORCAHORRO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/></a>&nbsp;
                    </th>
                    <th style="width:140px;">
                        <a href="javascript:OrdenarPor('PORCAHORRO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='perc_ahorro']/node()"/></a>
                    </th>
                </xsl:when>
                <xsl:otherwise>
                    <th colspan="2" class="zerouno">&nbsp;</th>
                </xsl:otherwise>
            </xsl:choose>
		</tr>

	<!--SI NO HAY PEDIDOS ENSEÑO UN MENSAJE Y SIGO ENSEÑANDO CABECERA-->
	<xsl:choose>
	<xsl:when test="/AnalisisPedidos/LINEASPEDIDOS/TOTAL = '0'">
		<tr class="lejenda"><th colspan="17"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_pedidos_para_busqueda']/node()"/></th></tr>
	</xsl:when>
	<xsl:otherwise>
    	<tbody>
			<xsl:for-each select="LINEAPEDIDO">
			
				<tr class="conhover" style="border-bottom:1px solid #A7A8A9;">
					<td><xsl:value-of select="POSICION"/></td>
					<td><xsl:if test="URGENTE = 'S'"><img src="http://www.newco.dev.br/images/2017/warning-red.png"/></xsl:if></td>
					<td>
						<xsl:if test="IDLICITACION != ''">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/MantLicitacion.xsql?LIC_ID={IDLICITACION}','Centro',100,80,0,-20);">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='lic']/node()"/>
						</a>
						</xsl:if>
					</td>
					<td>
						<a>
							<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="MO_ID"/>','Multioferta',100,100,0,0)</xsl:attribute>
							<xsl:value-of select="NUMERO_PEDIDO"/>
						</a>
					</td>
                    <td><xsl:value-of select="FECHA_PEDIDO"/></td>
                    <td><xsl:value-of select="FECHA_CONFIRMACION"/></td>
					<td class="textLeft">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTROCLIENTE}','Centro',100,80,0,-20);">
							<xsl:value-of select="NOMBRE_CENTRO"/>
						</a><xsl:if test="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/MOSTRAR_CENTRO_CONSUMO">:&nbsp;<xsl:value-of select="CENTRO_CONSUMO"/></xsl:if>
					</td>
					<td class="textLeft">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDPROVEEDOR}&amp;VENTANA=NUEVA','Centro',100,80,0,-20);">
							<xsl:value-of select="PROVEEDOR"/>
						</a>
					</td>
                   <!--ref cliente o ref estandar-->
					<td class="textLeft">
                        <xsl:choose>
                            &nbsp;<xsl:when test="REFCLIENTE != ''"><xsl:value-of select="REFCLIENTE"/></xsl:when>
                            <xsl:otherwise><xsl:value-of select="REFESTANDAR"/></xsl:otherwise>
                        </xsl:choose>
                        &nbsp;
                    </td>
                    <!--ref prove-->
					<td class="textLeft">
                        <xsl:value-of select="REFPROVEEDOR"/>&nbsp;
                    </td>
                    <!--producto-->
                    <td class="textLeft"><xsl:value-of select="PRODUCTO"/></td>
					<!--27set17	marca	-->
                    <td class="textLeft"><xsl:value-of select="MARCA"/></td>
                    <!--un basica-->
					<td><xsl:value-of select="LMO_UNIDADBASICA"/>&nbsp;</td>
                    <!--un lote-->
					<td class="textRight"><xsl:value-of select="LMO_UNIDADESPORLOTE"/>&nbsp;</td>
                    <!--cantidad-->
					<td class="textRight"><xsl:value-of select="CANTIDAD"/>&nbsp;</td>
					<xsl:if test="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/PENDIENTES='S'">
						<td class="textRight"><xsl:value-of select="CANTIDADENTREGADA"/>&nbsp;</td>
					</xsl:if>
                    <!--precio-->
					<td class="textRight"><xsl:value-of select="PRECIO"/>&nbsp;</td>
                    <!--precio referencia-->
                    <xsl:if test="../MOSTRAR_PRECIO_HISTORICO"><td class="textRight"><xsl:value-of select="PRECIOREFERENCIA"/>&nbsp;</td></xsl:if>
                    <!--total linea-->
					<td class="textRight">
                        <xsl:choose>
                            <xsl:when test="../MOSTRAR_PRECIOS_CON_IVA"><xsl:value-of select="TOTALLINEACONIVA"/></xsl:when>
                            <xsl:otherwise><xsl:value-of select="TOTALLINEA"/></xsl:otherwise>
                        </xsl:choose>&nbsp;
                    </td>
                    <xsl:choose>
                        <xsl:when test="../MOSTRAR_PRECIO_HISTORICO">
                            <td class="textRight"><xsl:value-of select="AHORRO"/>&nbsp;</td>
                            <td class="textRight"><xsl:value-of select="PORCAHORRO"/>&nbsp;</td>
                        </xsl:when>
                        <xsl:otherwise>
                            <td colspan="2">&nbsp;</td>
                        </xsl:otherwise>
                    </xsl:choose>
				</tr>
			
		</xsl:for-each>  <!--fin de pedidos-->
            </tbody>
	</xsl:otherwise>
	</xsl:choose><!--fin de choose si hay pedidos-->
    <tfoot>
        <xsl:if test="/AnalisisPedidos/LINEASPEDIDOS/TOTAL != '0'">
        <tr style="height:30px; font-weight:bold;">
            <td colspan="16">&nbsp;</td>
            <td class="textRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:</td>
            <td style="text-align:right;">
                <xsl:choose>
                    <xsl:when test="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/MOSTRAR_PRECIOS_CON_IVA">
                        <xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/TOTAL_PEDIDOS_CONIVA"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/TOTAL_PEDIDOS"/>
                    </xsl:otherwise>
                </xsl:choose>&nbsp;
            </td>
            <td style="text-align:right;"><xsl:value-of select="TOTAL_AHORRO"/>&nbsp;</td>
            <td style="text-align:right;"><xsl:value-of select="PORC_AHORRO"/>&nbsp;</td>
        </tr>
        <tr style="height:30px; font-weight:bold;">
            <td colspan="2">&nbsp;</td>
            <td colspan="11"><xsl:value-of select="document($doc)/translation/texts/item[@name='resumen']/node()"/>. <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>:&nbsp;<xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/TOTAL_LINEAS"/>.
					&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Cant_ud_minima']/node()"/>:&nbsp;<xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/TOTAL_UDESMINIMAS"/>.
					&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_medio']/node()"/>:
                		<xsl:choose>
                    		<xsl:when test="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/MOSTRAR_PRECIOS_CON_IVA">
                        		<xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/PRECIOMEDIO_CONIVA"/>
                    		</xsl:when>
                    		<xsl:otherwise>
                        		<xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/PRECIOMEDIO"/>
                    		</xsl:otherwise>
                		</xsl:choose>&nbsp;
					</td>
            <td colspan="4">&nbsp;</td>
        </tr>
        </xsl:if>
            <!--<tr><td colspan="16"></td></tr>-->
	</tfoot>
	</table>
    </xsl:for-each>
    </div>

</xsl:template><!--FIN DE TEMPLATE analisis-->

<!--buscador para admin mvm en analisis-->
<xsl:template name="buscador">
	<xsl:variable name="lang">
		<xsl:value-of select="/AnalisisPedidos/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>

	<!--table select-->
	<table class="buscador" border="0">
		<!--<tr class="select">-->
		<tr class="filtrosgrandes">
		<th class="zerouno">&nbsp;</th>
		<th width="110px" style="text-align:left;">
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>:</label><br />
			<input type="text"  style="width:100px;" name="CODIGOPEDIDO" size="9" maxlength="15" value="{CODIGOPEDIDO}"/>
		</th>
      	<!--th idempresa-->
      	<xsl:choose>
			<xsl:when test="FILTROS/IDEMPRESA">
        		<th style="width:180px;text-align:left;">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:</label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="FILTROS/IDEMPRESA/field"/>
						<xsl:with-param name="style">width:170px;</xsl:with-param>
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
       		<th style="width:180px;text-align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_consumo']/node()"/>:</label><br />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="FILTROS/IDCENTROCONSUMO/field"/>
					<xsl:with-param name="style">width:170px;</xsl:with-param>
				</xsl:call-template>
			</th>
		</xsl:if>

		<xsl:if test="FILTROS/IDCENTRO and not (FILTROS/IDCENTROCONSUMO)">
       		<th style="width:180px;text-align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</label><br />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="FILTROS/IDCENTRO/field"/>
					<xsl:with-param name="style">width:170px;</xsl:with-param>
				</xsl:call-template>
			</th>
		</xsl:if>
		
     	<th style="width:180px;text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label><br />
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="FILTROS/IDPROVEEDOR/field"/>
				<xsl:with-param name="style">width:170px;</xsl:with-param>
			</xsl:call-template>
		</th>
		<xsl:if test="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/IDPRODESTANDAR=''">
        <th style="width:200px;text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>/<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>:</label><br />
			<input type="text" style="width:190px;" name="PRODUCTO" size="30" maxlength="20" value="{PRODUCTO}"/>
		</th>
		</xsl:if>
   		<th style="width:160px;text-align:left;">
			<input class="muypeq" type="checkbox" name="FINALIZADOS_CHECK" id="FINALIZADOS_CHECK" onChange="javascript:chkPendienteOFinalizadoChange('FINALIZADOS');">
			<xsl:if test="FINALIZADOS = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>	
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Finalizados']/node()"/></label>
			<input type="hidden" name="FINALIZADOS" id="FINALIZADOS" value="{FINALIZADOS}"/>
			<br />
			<input class="muypeq" type="checkbox" name="PENDIENTES_CHECK" id="PENDIENTES_CHECK" onChange="javascript:chkPendienteOFinalizadoChange('PENDIENTES');">
			<xsl:if test="PENDIENTES = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>	
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Pendientes']/node()"/></label>
			<input type="hidden" name="PENDIENTES" id="PENDIENTES" value="{PENDIENTES}"/>
			<br />
		</th>
   		<th style="width:160px;text-align:left;">
			<input class="muypeq" type="checkbox" name="URGENTES_CHECK" id="URGENTES_CHECK">
			<xsl:if test="URGENTES = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Urgentes']/node()"/></label>
			<input type="hidden" name="URGENTES" id="URGENTES" value="{URGENTES}"/>
			<br />
			<input class="muypeq" type="checkbox" name="INVERTIRABONOS_CHECK" id="INVERTIRABONOS_CHECK">
			<xsl:if test="INVERTIRABONOS = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Invertir_abonos']/node()"/></label>
			<input type="hidden" name="INVERTIRABONOS" id="INVERTIRABONOS" value="{INVERTIRABONOS}"/>
		</th>
		<th style="width:130px;text-align:left;background:#F0F0F0;">
			<!--fecha inicio-->
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_inicio']/node()"/>:</label><br />
			<input type="text" name="FECHA_INICIO" id="FECHA_INICIO" value="{FECHAINICIO}" size="9" style="width:120px;background:#FFFF99;border:1px solid #ccc;" />
		</th>
		<th style="width:130px;text-align:left;background:#F0F0F0;">
			<!--fecha final-->
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_final']/node()"/>:</label><br />
			<input type="text" name="FECHA_FINAL" id="FECHA_FINAL" value="{FECHAFINAL}"  size="9" style="width:120px;background:#FFFF99;border:1px solid #ccc;" />
		</th>
		<th style="width:170px;text-align:left;background:#F0F0F0;">
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
		<th width="120px">
			<select name="LINEA_POR_PAGINA" id="LINEA_POR_PAGINA" style="width:110px;"><!-- onchange="AplicarFiltro();"-->
                <option value="30">
                    <xsl:if test="LINEASPORPAGINA = '30'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
                    30 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
                </option>
                <option value="50">
                    <xsl:if test="LINEASPORPAGINA = '50'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
                    50 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
                </option>
                <option value="100">
                    <xsl:if test="LINEASPORPAGINA = '100'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
                    100 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
                </option>
                <option value="500">
                    <xsl:if test="LINEASPORPAGINA = '500'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
                    500 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
                </option>
                <option value="1000">
                    <xsl:if test="LINEASPORPAGINA = '1000'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
                    1000 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
                </option>
            </select>
		</th>
      <!--<th class="cinco" style="background:#E4E3E3;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='conf']/node()"/></label><br />
                                <input type="checkbox" name="UTILFECHAENTREGA" id="UTILFECHAENTREGA">
					<xsl:if test="UTILIZARFECHACONFIRMACION = 'S'">
						<xsl:attribute name="checked">checked</xsl:attribute>
					</xsl:if>
				</input>
			</th>-->
     	<th width="100px">
       		<!--<a href="javascript:DescargarExcel();"><img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel"/></a><br />-->
			<!--<a href="javascript:AplicarFiltro();" title="Buscar">
				<img src="http://www.newco.dev.br/images/buttonBuscar.gif" alt="Buscar" />
			</a>-->
			<a href="javascript:AplicarFiltro();" title="Buscar" class="btnDestacado">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
			</a>
		</th>
    	<th></th><!--	para completar espacio hasta el final de linea	-->
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
