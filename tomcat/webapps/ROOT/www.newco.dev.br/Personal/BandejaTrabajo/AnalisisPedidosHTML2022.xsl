<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Analisis de pedidos, línea a línea
	Ultima revision ET 11may23 11:00 AnalisisPedidos2022_190922.js
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

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Personal/BandejaTrabajo/AnalisisPedidos2022_190922.js"></script>

	<script type="text/javascript">
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


	<form  method="post" name="Form1" action="AnalisisPedidos2022.xsql">

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


	<!--14nov22<div class="divLeft boxInicio" id="pedidosBox" style="border:1px solid #939494;border-top:0;overflow-y: scroll;">-->
	<div class="divLeft boxInicio" id="pedidosBox" style="overflow-y: scroll;">

	<input type="hidden" name="IDPRODUCTO" value="{/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/IDPRODUCTO}"/>
	<input type="hidden" name="IDPRODESTANDAR" value="{/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/IDPRODESTANDAR}"/>
	<input type="hidden" name="IDLICITACION" value="{/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/IDLICITACION}"/>

	<xsl:for-each select="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR"><!--	Solo para no tener que utilizar el path completo	-->
	<input type="hidden" name="ORDEN" value="{./ORDEN}"/>
	<input type="hidden" name="SENTIDO" value="{./SENTIDO}"/>
	<input type="hidden" name="IDEMPRESAUSUARIO" value="{./IDEMPRESAUSUARIO}"/>


	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='analisis_pedidos']/node()"/>:&nbsp;<xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/TITULO" />&nbsp;
			<span class="fuentePeq">(
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
                <xsl:value-of select="//BOTONES/NUMERO_PAGINAS"/>
                <xsl:value-of select="document($doc)/translation/texts/item[@name='con']/node()"/>&nbsp;
                <xsl:value-of select="TOTAL_LINEAS"/>&nbsp;
                <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas_en_total']/node()"/>,&nbsp;
			<xsl:value-of select="../FECHAACTUAL"/>)</span>
			<span class="CompletarTitulo300">
				<xsl:if test="//ANTERIOR">
					<a class="btnNormal" href="javascript:AplicarFiltroPagina({//ANTERIOR/@Pagina});"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>&nbsp;
				</xsl:if>
				<a class="btnNormal" href="javascript:DescargarExcel();"><xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/></a>
				&nbsp;
				<xsl:if test="//SIGUIENTE">
					<a class="btnNormal" href="javascript:AplicarFiltroPagina({//SIGUIENTE/@Pagina});"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>&nbsp;
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	<br/>

	<input type="hidden" name="PAGINA" id="PAGINA" value="{PAGINA}"/>

	<xsl:call-template name="buscador"/>

	<div class="tabela tabela_redonda marginTop20">
	<table class="w100" cellspacing="6px" cellpadding="6px">
	<thead class="cabecalho_tabela">
		<tr class="subTituloTabla">
			<th class="w1px"></th>
			<th class="w1px"></th>
			<th class="w50px">
				<a href="javascript:OrdenarPor('NUMERO_PEDIDO');">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>
				</a>
			</th>
            <th class="w50px">
				<a href="javascript:OrdenarPor('FECHA_EMISION');"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_emis']/node()"/></a>
			</th>
            <th class="w50px">
				<a href="javascript:OrdenarPor('FECHA_CONFIRMACION');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_final']/node()"/></a>
			</th>
			<th class="textLeft">
				&nbsp;<a href="javascript:OrdenarPor('CENTRO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></a>
			</th>
			<th class="textLeft">
				&nbsp;<a href="javascript:OrdenarPor('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a>
			</th>
			<th class="textLeft w50px">
				&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>
			</th>
			<xsl:if test="/AnalisisPedidos/LINEASPEDIDOS/MOSTRAR_REF_PROVEEDOR"><!--4ene23-->
				<th class="textLeft w50px">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>&nbsp;
				</th>
			</xsl:if>
			<th class="textLeft">
				&nbsp;<a href="javascript:OrdenarPor('PRODUCTO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a>
			</th>
			<th class="textLeft">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>
			</th>
			<th class="textLeft w60px">
				&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>
			</th>
			<th class="textLeft w50px">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_lote']/node()"/>&nbsp;
			</th>
			<th class="textLeft w50px">
             	<xsl:value-of select="document($doc)/translation/texts/item[@name='cant']/node()"/>&nbsp;
            </th>
			<xsl:if test="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/PENDIENTES='S'">
				<th class="textLeft w50px">
             		<xsl:value-of select="document($doc)/translation/texts/item[@name='entr']/node()"/>&nbsp;
            	</th>
			</xsl:if>
			<th class="w100px">
            	<a href="javascript:OrdenarPor('PRECIO');">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>(<xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/DIVISA/PREFIJO"/><xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/DIVISA/SUFIJO"/>)
				</a>&nbsp;
            </th>
			<xsl:if test="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/MOSTRAR_PRECIO_HISTORICO">
				<th class="w100px">
                	<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ref']/node()"/>
            	</th>
			</xsl:if>
			<th class="w100px">
                <xsl:choose>
                    <xsl:when test="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/MOSTRAR_PRECIOS_CON_IVA">
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
                <xsl:when test="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/MOSTRAR_PRECIO_HISTORICO">
					<th class="w50px">
                        <a href="javascript:OrdenarPor('PORCAHORRO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/></a>&nbsp;
                    </th>
					<th class="w50px">
                        <a href="javascript:OrdenarPor('PORCAHORRO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='perc_ahorro']/node()"/></a>
                    </th>
                </xsl:when>
                <xsl:otherwise>
                    <th colspan="2" class="w1px">&nbsp;</th>
                </xsl:otherwise>
            </xsl:choose>
			<xsl:if test="/AnalisisPedidos/LINEASPEDIDOS/INCLUIR_MANTENIMIENTO='S'"><!--4ene23-->
				<th class="textLeft">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='motivo']/node()"/>&nbsp;
				</th>
			</xsl:if>
		</tr>
    	</thead>

		<!--SI NO HAY PEDIDOS ENSEÑO UN MENSAJE Y SIGO ENSEÑANDO CABECERA-->
		<xsl:choose>
		<xsl:when test="/AnalisisPedidos/LINEASPEDIDOS/TOTAL = '0'">
			<tbody>
				<tr><td class="color_status">&nbsp;</td><td colspan="16"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_se_han_encontrado_resultados']/node()"/></td></tr>
			</tbody>
			<tfoot class="rodape_tabela">
           		<tr>
					<td colspan="21">&nbsp;</td>
           		</tr>
			</tfoot>
		</xsl:when>
		<xsl:otherwise>
			<tbody class="corpo_tabela">
			<xsl:for-each select="LINEAPEDIDO">
				<tr class="conhover">
					<td class="color_status textRight"><xsl:value-of select="POSICION"/></td>
					<td>
						<xsl:if test="IDLICITACION != ''">
						<a href="javascript:FichaLicitacion('{IDLICITACION}');">
							<img src="http://www.newco.dev.br/images/info.gif" title="{CODIGO_LICITACION}: {TITULO_LICITACION}" />
							<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='lic']/node()"/>-->
						</a>
						</xsl:if>
					</td>
					<td><xsl:if test="URGENTE = 'S'"><img src="http://www.newco.dev.br/images/2017/warning-red.png"/></xsl:if>
						<a>
							<xsl:attribute name="href">javascript:FichaPedido('<xsl:value-of select="MO_ID"/>');</xsl:attribute>
							<xsl:value-of select="NUMERO_PEDIDO"/>
						</a>
					</td>
                    <td><xsl:value-of select="FECHA_PEDIDO"/></td>
                    <td><xsl:value-of select="FECHA_CONFIRMACION"/></td>
					<td class="textLeft">
						<a href="javascript:FichaCentro('{IDCENTROCLIENTE}');">
							<xsl:value-of select="NOMBRE_CENTRO"/>
						</a><xsl:if test="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/MOSTRAR_CENTRO_CONSUMO">:&nbsp;<xsl:value-of select="CENTRO_CONSUMO"/></xsl:if>
					</td>
					<td class="textLeft">
						<a href="javascript:FichaEmpresa('{IDPROVEEDOR}');">
							<xsl:value-of select="PROVEEDOR"/>
						</a>
					</td>
                   <!--ref cliente o ref estandar-->
					<td class="textLeft">
                        <xsl:choose>
                            <xsl:when test="REFCLIENTE != ''"><xsl:value-of select="REFCLIENTE"/></xsl:when>
                            <xsl:otherwise><xsl:value-of select="REFESTANDAR"/></xsl:otherwise>
                        </xsl:choose>
                    </td>
                    <!--ref prove-->
					<xsl:if test="/AnalisisPedidos/LINEASPEDIDOS/MOSTRAR_REF_PROVEEDOR">
						<td class="textLeft">
                        	<xsl:value-of select="REFPROVEEDOR"/>
                    	</td>
					</xsl:if>
                    <!--producto-->
                    <td class="textLeft"><xsl:value-of select="PRODUCTO"/></td>
					<!--27set17	marca	-->
                    <td class="textLeft"><xsl:value-of select="MARCA"/></td>
                    <!--un basica-->
					<td><xsl:value-of select="LMO_UNIDADBASICA"/></td>
                    <!--un lote-->
					<td class="textRight"><xsl:value-of select="LMO_UNIDADESPORLOTE"/></td>
                    <!--cantidad-->
					<td class="textRight"><xsl:value-of select="CANTIDAD"/></td>
					<xsl:if test="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/PENDIENTES='S'">
						<td class="textRight"><xsl:value-of select="CANTIDADENTREGADA"/></td>
					</xsl:if>
                    <!--precio-->
					<td class="textRight"><xsl:value-of select="PRECIO"/></td>
                    <!--precio referencia-->
                    <xsl:if test="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/MOSTRAR_PRECIO_HISTORICO"><td class="textRight"><xsl:value-of select="PRECIOREFERENCIA"/></td></xsl:if>
                    <!--total linea-->
					<td class="textRight">
                        <xsl:choose>
                            <xsl:when test="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/MOSTRAR_PRECIOS_CON_IVA"><xsl:value-of select="TOTALLINEACONIVA"/></xsl:when>
                            <xsl:otherwise><xsl:value-of select="TOTALLINEA"/></xsl:otherwise>
                        </xsl:choose>
                    </td>
                    <xsl:choose>
                        <xsl:when test="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/MOSTRAR_PRECIO_HISTORICO">
                            <td class="textRight"><xsl:value-of select="AHORRO"/></td>
                            <td class="textRight"><xsl:value-of select="PORCAHORRO"/></td>
                        </xsl:when>
                        <xsl:otherwise>
                            <td colspan="2">&nbsp;</td>
                        </xsl:otherwise>
                    </xsl:choose>
					<xsl:if test="/AnalisisPedidos/LINEASPEDIDOS/INCLUIR_MANTENIMIENTO='S'"><!--4ene23-->
						<td class="textLeft">
						<span class="fuentePeq">
                    	<xsl:choose>
                        	<xsl:when test="INFO_MANTENIMIENTO_CORTO">
								<xsl:value-of select="INFO_MANTENIMIENTO_CORTO"/>...
							&nbsp;<img src="http://www.newco.dev.br/images/info.gif" title="{INFO_MANTENIMIENTO}"/>
                         	</xsl:when>
                        	<xsl:otherwise>
								<xsl:value-of select="INFO_MANTENIMIENTO"/>
                        	</xsl:otherwise>
                    	</xsl:choose>
						</span>
						</td>
					</xsl:if>
				</tr>
			
				</xsl:for-each>  <!--fin de pedidos-->
            </tbody>
	</xsl:otherwise>
	</xsl:choose><!--fin de choose si hay pedidos-->
	<tfoot class="rodape_tabela">
        <xsl:if test="/AnalisisPedidos/LINEASPEDIDOS/TOTAL != '0'">
        <tr>
			<xsl:if test="/AnalisisPedidos/LINEASPEDIDOS/MOSTRAR_REF_PROVEEDOR"><td>&nbsp;</td></xsl:if>
			<xsl:if test="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/PENDIENTES='S'"><td>&nbsp;</td></xsl:if>
			<xsl:if test="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/MOSTRAR_PRECIO_HISTORICO"><td>&nbsp;</td></xsl:if>
            <td colspan="13">&nbsp;</td>
            <td class="textRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:</td>
            <td class="textRight">
                <xsl:choose>
                    <xsl:when test="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/MOSTRAR_PRECIOS_CON_IVA">
                        <xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/TOTAL_PEDIDOS_CONIVA"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/TOTAL_PEDIDOS"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td class="textRight"><xsl:value-of select="TOTAL_AHORRO"/></td>
            <td class="textRight"><xsl:value-of select="PORC_AHORRO"/></td>
			<xsl:if test="/AnalisisPedidos/LINEASPEDIDOS/INCLUIR_MANTENIMIENTO='S'"><td>&nbsp;</td></xsl:if>
        </tr>
        <tr>
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
            <td colspan="6">&nbsp;</td>
        </tr>
        </xsl:if>
	</tfoot>
	</table>
    </div>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
    </xsl:for-each>
    </div>

</xsl:template><!--FIN DE TEMPLATE analisis-->

<!--buscador para admin mvm en analisis-->
<xsl:template name="buscador">
	<xsl:variable name="lang">
		<xsl:value-of select="/AnalisisPedidos/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>

	<table>
		<tr>
			<td class="w50px">&nbsp;</td>
			<td class="w90px" style="text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>:</label><br />
				<input type="text" class="campopesquisa w80px" name="CODIGOPEDIDO" size="9" maxlength="15" value="{CODIGOPEDIDO}"/>
			</td>
      		<!--th idempresa-->
      		<xsl:choose>
				<xsl:when test="FILTROS/IDEMPRESA">
					<td class="textLeft w180px">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:</label><br />
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="FILTROS/IDEMPRESA/field"/>
							<xsl:with-param name="claSel">w170px</xsl:with-param>
						</xsl:call-template>
        			</td>
				</xsl:when>
				<xsl:otherwise>
       				<td class="zerouno">
          			<input type="hidden" name="IDEMPRESA" value="{IDEMPRESA}"/>
        			</td>
				</xsl:otherwise>
			</xsl:choose>

			<xsl:if test="FILTROS/IDCENTROCONSUMO">
				<td class="textLeft w180px">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_consumo']/node()"/>:</label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="FILTROS/IDCENTROCONSUMO/field"/>
						<xsl:with-param name="claSel">w170px</xsl:with-param>
					</xsl:call-template>
				</td>
			</xsl:if>

			<xsl:if test="FILTROS/IDCENTRO and not (FILTROS/IDCENTROCONSUMO)">
				<td class="textLeft w180px">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="FILTROS/IDCENTRO/field"/>
						<xsl:with-param name="claSel">w170px</xsl:with-param>
					</xsl:call-template>
				</td>
			</xsl:if>

			<td class="textLeft w180px">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label><br />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="FILTROS/IDPROVEEDOR/field"/>
					<xsl:with-param name="style">width:170px;</xsl:with-param>
				</xsl:call-template>
			</td>
			<xsl:if test="/AnalisisPedidos/LINEASPEDIDOS/COMPRADOR/IDPRODESTANDAR=''">
			<td class="textLeft w110px">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>/<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>:</label><br />
				<input type="text" class="campopesquisa w100px amarillo" name="PRODUCTO" maxlength="100" value="{PRODUCTO}"/>
			</td>
			</xsl:if>
			<td class="textLeft w140px">
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
			</td>
			<td class="textLeft w140px">
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
			</td>
			<td class="textLeft w110px fondoGris">
				<!--fecha inicio-->
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_inicio']/node()"/>:</label><br />
				<input type="text" class="campopesquisa w100px amarillo" name="FECHA_INICIO" id="FECHA_INICIO" value="{FECHAINICIO}" />
			</td>
			<td class="textLeft w110px fondoGris">
				<!--fecha final-->
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_final']/node()"/>:</label><br />
				<input type="text" class="campopesquisa w100px" name="FECHA_FINAL" id="FECHA_FINAL" value="{FECHAFINAL}"/>
			</td>
			<td class="textLeft w140px fondoGris">
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
			</td>
			<td class="w100px">
				<select name="LINEA_POR_PAGINA" id="LINEA_POR_PAGINA" class="w100px">
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
			</td>
     		<td class="w80px">
				<a href="javascript:AplicarFiltro();" title="Buscar" class="btnDestacado">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
				</a>
			</td>
    		<td></td><!--	para completar espacio hasta el final de linea	-->
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
