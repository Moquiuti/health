<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Listado/buscador de lineas de licitación, incluyendo info de las lineas de pedido generadas
	Ultima revisión: ET 16set22 09:32 LicAnalisisLineas2022_200223.js
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
		<xsl:when test="/AnalisisLicitaciones/LANG"><xsl:value-of select="/AnalisisLicitaciones/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<meta http-equiv="Cache-Control" Content="no-cache"/>

        <title><xsl:value-of select="document($doc)/translation/texts/item[@name='analisis_lineas_licitacion']/node()"/></title>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/LicAnalisisLineas2022_200223.js"></script>

	<script type="text/javascript">
	var Rol='<xsl:value-of select="/AnalisisLicitaciones/LINEASLICITACION/ROL"/>';
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


	<form  method="post" name="Form1" action="LicAnalisisLineas2022.xsql">

	<xsl:choose>
	<!-- Error en alguna sentencia del XSQL -->
	<xsl:when test="AnalisisLicitaciones/INICIO/xsql-error">
		<xsl:apply-templates select="AnalisisLicitaciones/INICIO/xsql-error"/>
	</xsl:when>
	<xsl:when test="AnalisisLicitaciones/INICIO/SESION_CADUCADA">
		<xsl:for-each select="AnalisisLicitaciones/INICIO/SESION_CADUCADA">
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


<!--todos los usuarios-->
<xsl:template name="ANALISIS">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/AnalisisLicitaciones/LANG"><xsl:value-of select="/AnalisisLicitaciones/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->


    <div class="divLeft boxInicio" id="pedidosBox">

        <input type="hidden" name="IDPRODUCTO" value="{/AnalisisLicitaciones/IDPRODUCTO}"/>

		<!--<xsl:for-each select="/AnalisisLicitaciones/LINEASLICITACION/COMPRADOR">-->
			<input type="hidden" name="ORDEN" value="{/AnalisisLicitaciones/LINEASLICITACION/ORDEN}"/>
			<input type="hidden" name="SENTIDO" value="{/AnalisisLicitaciones/LINEASLICITACION/SENTIDO}"/>
			<input type="hidden" name="IDEMPRESAUSUARIO" value="{/AnalisisLicitaciones/LINEASLICITACION/IDEMPRESAUSUARIO}"/>

			<!--	Titulo de la página		-->
			<div class="ZonaTituloPagina">
				<p class="TituloPagina">
					<xsl:if test="NOMBREPRODUCTO != ''">
						<xsl:value-of select="substring(NOMBREPRODUCTO,0,50)" />:&nbsp;
					</xsl:if>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Analisis_lineas_licitaciones']/node()"/>&nbsp;
					<span class="fuentePeq">
					(
                		<xsl:value-of select="document($doc)/translation/texts/item[@name='pagina']/node()"/>&nbsp;
                		<xsl:variable name="pagina">
                    		<xsl:choose>
                        		<xsl:when test="/AnalisisLicitaciones/LINEASLICITACION/PAGINA != ''">
                            		<xsl:value-of select="number(/AnalisisLicitaciones/LINEASLICITACION/PAGINA)+number(1)"/>
                        		</xsl:when>
                        		<xsl:otherwise>1</xsl:otherwise>
                    		</xsl:choose>
                		</xsl:variable>
                		<xsl:value-of select="$pagina" />&nbsp;
                		<xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
                		<xsl:value-of select="//BOTONES/NUMERO_PAGINAS" />&nbsp;
                		<xsl:value-of select="document($doc)/translation/texts/item[@name='con']/node()"/>&nbsp;
                		<xsl:value-of select="/AnalisisLicitaciones/LINEASLICITACION/TOTAL_LINEAS"/>&nbsp;
                		<xsl:value-of select="document($doc)/translation/texts/item[@name='lineas_en_total']/node()"/>,&nbsp;
						<xsl:value-of select="/AnalisisLicitaciones/LINEASLICITACION/FECHAACTUAL"/>
					)</span>
					<span class="CompletarTitulo">
						<xsl:if test="//ANTERIOR">
							<a class="btnNormal" href="javascript:AplicarFiltroPagina({//ANTERIOR/@Pagina});"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
						&nbsp;
						</xsl:if>
						<a class="btnNormal" href="javascript:DescargarExcel();"><xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/></a>
						&nbsp;
						<xsl:if test="//SIGUIENTE">
							<a class="btnNormal" href="javascript:AplicarFiltroPagina({//SIGUIENTE/@Pagina});">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>&nbsp;
						&nbsp;
						</xsl:if>
						<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/Licitaciones2022.xsql"><xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones']/node()"/></a>
						&nbsp;
					</span>
				</p>
			</div>
			<br/>
			<br/>

			<xsl:call-template name="buscador"/>
	        <input type="hidden" name="PAGINA" id="PAGINA" value="{PAGINA}"/>

			<div class="tabela tabela_redonda conScroll">
			<table cellspacing="6px" cellpadding="6px">
				<thead class="cabecalho_tabela">
				<tr>
					<th class="w1px">&nbsp;</th>
					<th class="w50px">
						<xsl:copy-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>
					</th>
					<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/ROL='VENDEDOR'">
					<th align="left">
						&nbsp;<a href="javascript:OrdenarPor('EMPRESA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></a>
					</th>
					</xsl:if>
            		<th class="textLeft">
						&nbsp;<a href="javascript:OrdenarPor('PRODUCTO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a>
					</th>
					<th class="w50px">
						<a href="javascript:OrdenarPor('NUMERO_LICITACION');"><xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion']/node()"/></a>
					</th>
					<th class="w50px">
						<a href="javascript:OrdenarPor('FECHA_LICITACION');"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_licitacion']/node()"/></a>
					</th>
					<th class="w50px">
						<a href="javascript:OrdenarPor('FECHA_VENCIMIENTO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/></a>
					</th>
					<th class="w50px">
						<a href="javascript:OrdenarPor('ESTADO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></a>
					</th>
					<th class="w50px">
						<a href="javascript:OrdenarPor('NUMERO_PEDIDO');">
							<xsl:copy-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>
						</a>
					</th>
            		<th class="w50px">
						<a href="javascript:OrdenarPor('FECHA_EMISION');"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_emis']/node()"/></a>
					</th>
            		<!--<th class="cinco">
						<a href="javascript:OrdenarPor('FECHA_CONFIRMACION');"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_conf']/node()"/></a>
					</th>-->
					<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/MOSTRAREMPRESA">
					<th class="textLeft">
						&nbsp;<a href="javascript:OrdenarPor('EMPRESA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></a>
					</th>
					</xsl:if>
					<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/ROL='COMPRADOR'">
					<th class="textLeft">
						&nbsp;<a href="javascript:OrdenarPor('CENTRO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></a>
					</th>
					<th class="w100px textLeft">
						&nbsp;<a href="javascript:OrdenarPor('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a>
					</th>
					</xsl:if>
					<th class="w50px textLeft">
						&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>
					</th>
					<th class="w50px textLeft">
						&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>
					</th>
					<!--
					<th class="cinco" align="right">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_lote']/node()"/>&nbsp;
					</th>
					-->
					<th class="w50px textRight">
                    		<xsl:value-of select="document($doc)/translation/texts/item[@name='cant']/node()"/>&nbsp;
            		</th>
					<th class="w50px textRight">
                		<xsl:choose>
                    		<xsl:when test="/AnalisisLicitaciones/LINEASLICITACION/ROL='COMPRADOR'"> <xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></xsl:when>
                    		<xsl:otherwise><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta']/node()"/></xsl:otherwise>
                		</xsl:choose>
                		&nbsp;
            		</th>
					<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/ROL='COMPRADOR'">
					<xsl:choose>
            			<xsl:when test="/AnalisisLicitaciones/LINEASLICITACION/AHORRONEGOCIACION='N'">
            			<th>
                			<xsl:attribute name="class">
                    			<xsl:choose>
                        			<xsl:when test="/AnalisisLicitaciones/LINEASLICITACION/MOSTRAR_PRECIO_HISTORICO">w50px</xsl:when>
                        			<xsl:otherwise>w1px</xsl:otherwise>
                    			</xsl:choose>
                			</xsl:attribute>
                			<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/MOSTRAR_PRECIO_HISTORICO"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ref']/node()"/></xsl:if>
            			</th>
            			<th class="w50px textRight">
                			<xsl:choose>
                    			<xsl:when test="/AnalisisLicitaciones/LINEASLICITACION/MOSTRAR_PRECIOS_CON_IVA"><a href="javascript:OrdenarPor('TOTALLINEACONIVA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/></a></xsl:when>
                    			<xsl:otherwise><a href="javascript:OrdenarPor('TOTALLINEA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/></a></xsl:otherwise>
                			</xsl:choose>&nbsp;
            			</th>
            			<xsl:choose>
                			<xsl:when test="/AnalisisLicitaciones/LINEASLICITACION/MOSTRAR_PRECIO_HISTORICO">
                    			<th class="w50px">
                        			 <a href="javascript:OrdenarPor('PORCAHORRO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/></a>&nbsp;
                    			</th>
                    			<th class="w50px">
                        			 <a href="javascript:OrdenarPor('PORCAHORRO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='perc_ahorro']/node()"/></a>
                    			</th>
                			</xsl:when>
                			<xsl:otherwise>
                    			<th colspan="2" class="zerouno">&nbsp;</th>
                			</xsl:otherwise>
            			</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
            			<th class="w50px">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_cambio']/node()"/>
            			</th>
            			<th class="w50px textRight">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='Precio_inicial']/node()"/>
            			</th>
            			<th class="w50px textRight">
							<xsl:copy-of select="document($doc)/translation/texts/item[@name='ahorro_negociacion_2l']/node()"/>
            			</th>
            			<th class="w50px textRight">
							<xsl:copy-of select="document($doc)/translation/texts/item[@name='perc_ahorro_negociacion_2l']/node()"/>
            			</th>
					</xsl:otherwise>
					</xsl:choose>
					</xsl:if>

					<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/ROL='COMPRADOR'">
            			<th class="w1px textRight">
                			 <a href="javascript:OrdenarPor('ADJUDICADA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='adj']/node()"/></a>&nbsp;
            			</th>
						<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/MOSTRARCOLUMNAORDEN">
            				<th class="w1px textRight">
                				 <a href="javascript:OrdenarPor('ORDEN');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ord']/node()"/></a>&nbsp;
            				</th>
						</xsl:if>
					</xsl:if>
				</tr>
				</thead>

			<xsl:choose>
			<xsl:when test="/AnalisisLicitaciones/LINEASLICITACION/TOTAL = '0'">
				<!--SI NO HAY RESULTADOS mensaje-->
				<tbody>
					<tr><td class="color_status">&nbsp;</td><td colspan="20"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_se_han_encontrado_resultados']/node()"/></td></tr>
				</tbody>
				<tfoot class="rodape_tabela">
            		<tr>
						<td colspan="21">&nbsp;</td>
            		</tr>
				</tfoot>
			</xsl:when>
			<xsl:otherwise>
				<tbody class="corpo_tabela">
				<xsl:for-each select="/AnalisisLicitaciones/LINEASLICITACION/LINEALICITACION">
					<tr class="conhover h20px">
						<td class="color_status"><xsl:value-of select="POSICION"/></td>
                		<!--ref cliente o ref estandar-->
						<td class="textRight">
                    		<xsl:choose>
                        		<xsl:when test="LIC_PROD_REFCLIENTE != ''"><xsl:value-of select="LIC_PROD_REFCLIENTE"/></xsl:when>
                        		<xsl:otherwise><xsl:value-of select="LIC_PROD_REFESTANDAR"/></xsl:otherwise>
                    		</xsl:choose>
                    		&nbsp;
                		</td>
                		<!--ref prove
						<td class="textRight">
                    		<xsl:value-of select="REFPROVEEDOR"/>&nbsp;
                		</td>
						-->
						<!-- cliente: solo para proveedores	-->
						<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/ROL='VENDEDOR'">
						<td class="textLeft">
							<a href="javascript:FichaEmpresa('{IDCLIENTE}');">
								<xsl:value-of select="CLIENTE"/>
							</a>
						</td>
						</xsl:if>
                		<!--producto-->
                		<td class="textLeft">
                    		<xsl:choose>
                        		<xsl:when test="/AnalisisLicitaciones/LINEASLICITACION/ROL='COMPRADOR'">
									<a href="javascript:FichaProductoLicitacion('{LIC_ID}','{LIC_PROD_ID}');">
										<xsl:value-of select="LIC_PROD_NOMBRE"/>
									</a>
								</xsl:when>
                        		<xsl:otherwise><xsl:value-of select="LIC_PROD_NOMBRE"/></xsl:otherwise>
                    		</xsl:choose>

							&nbsp;
							<xsl:if test="LIC_PROD_MARCASACEPTABLES != '' or LIC_PROD_PRINCIPIOACTIVO != ''">
								<img src="http://www.newco.dev.br/images/2017/info.png" title="Marcas:{LIC_PROD_MARCASACEPTABLES}&#13;Princ.Activo:{LIC_PROD_PRINCIPIOACTIVO}" class="static"/>&nbsp;
							</xsl:if>
						</td>
                		<td>
							<a href="javascript:AbrirLicitacion('{LIC_ID}');">
								<xsl:value-of select="LIC_CODIGO"/>
							</a>
						</td>
                		<td class="fuentePeq"><xsl:value-of select="LIC_FECHAALTA"/></td>
               			<td class="fuentePeq">
			   				<xsl:value-of select="LIC_FECHADECISIONPREVISTA"/>&nbsp;<xsl:value-of select="LIC_HORADECISION"/>:<xsl:value-of select="LIC_MINUTODECISION"/>
						</td>
                		<td>
							<xsl:choose>
               				<xsl:when test="/AnalisisLicitaciones/LINEASLICITACION/CONTROLPEDIDOS and PED_ID">
								<a href="javascript:ControlPedido('{PED_ID}');">
									<xsl:value-of select="ESTADO"/>
								</a>
               				</xsl:when>
                			<xsl:otherwise>
								<xsl:value-of select="ESTADO"/>
                			</xsl:otherwise>
            				</xsl:choose>
						</td>
						<td>
							<a href="javascript:FichaPedido('{MO_ID}');">
								<xsl:value-of select="NUMERO_PEDIDO"/>
							</a>
						</td>
                		<td class="fuentePeq"><xsl:value-of select="FECHA_PEDIDO"/></td>
            		   <!-- <td><xsl:value-of select="FECHA_CONFIRMACION"/></td>-->
						<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/MOSTRAREMPRESA">
						<td class="textLeft">
							<a href="javascript:FichaEmpresa('{IDCLIENTE}');">
								<xsl:value-of select="CLIENTE"/>
							</a>
						</td>
						</xsl:if>
						<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/ROL='COMPRADOR'">
						<td class="textLeft">
							<a href="javascript:FichaCentro('{IDCENTROCLIENTE}');">
								<xsl:value-of select="NOMBRE_CENTRO"/>
							</a>
						</td>
						<td class="textLeft">
							<a href="javascript:FichaEmpresa('{IDPROVEEDOR}');">
								<xsl:value-of select="PROVEEDOR"/>
							</a>
						</td>
						</xsl:if>
                		<!--marca-->
						<td class="textLeft"><xsl:value-of select="LIC_OFE_MARCA"/>&nbsp;</td>
                		<!--un basica-->
						<td class="textLeft"><xsl:value-of select="LIC_PROD_UNIDADBASICA"/>&nbsp;</td>
                		<!--un lote
						<td class="textRight"><xsl:value-of select="LMO_UNIDADESPORLOTE"/>&nbsp;</td>
						-->
                		<!--cantidad-->
						<td class="textRight">
						<xsl:choose>
    						<xsl:when test="CANTIDAD"><xsl:value-of select="CANTIDAD"/></xsl:when>
    						<xsl:otherwise><xsl:value-of select="LIC_PROD_CANTIDAD"/></xsl:otherwise>
						</xsl:choose>&nbsp;
						&nbsp;
						</td>
                		<!--precio. 11ene23: fondo azul para oferta desde contrato-->
						<td class="textRight">
							<xsl:attribute name="class">
							<xsl:choose>
    							<xsl:when test="LIC_PROD_DESDEINTEGRACION='S'">textRight fondoAzul</xsl:when>
    							<xsl:otherwise>textRight</xsl:otherwise>
							</xsl:choose>
							</xsl:attribute>
							<xsl:value-of select="PRECIO"/>
						</td>
                		<!--precio referencia-->
						<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/ROL='COMPRADOR'">
							<xsl:choose>
            					<xsl:when test="/AnalisisLicitaciones/LINEASLICITACION/AHORRONEGOCIACION='N'">
								<td class="textRight">
									<xsl:if test="../MOSTRAR_PRECIO_HISTORICO">
									<xsl:choose>
		            					<xsl:when test="/AnalisisLicitaciones/LINEASLICITACION/PRECIOREFERENCIA"><xsl:value-of select="PRECIOREFERENCIA"/>&nbsp;</xsl:when>
										<xsl:otherwise><xsl:value-of select="LIC_PROD_PRECIOREFERENCIA"/>&nbsp;</xsl:otherwise>
									</xsl:choose>
									</xsl:if>
								</td>
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
							</xsl:when>
							<xsl:otherwise>
            					<th>
									<xsl:value-of select="LIC_OFE_FECHACAMBIOPRECIO"/>
            					</th>
            					<th class="textRight">
									<xsl:value-of select="LIC_OFE_PRECIOORIGINAL"/>
            					</th>
            					<th class="textRight">
									<xsl:value-of select="LIC_OFE_AHORRONEGOCIACION"/>
            					</th>
            					<th class="textRight">
									<xsl:value-of select="LIC_OFE_AHORRONEGOCIACION_PORC"/>
            					</th>
							</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
						<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/ROL='COMPRADOR'">
							<td class="textRight"><xsl:value-of select="LIC_OFE_ADJUDICADA"/>&nbsp;</td>
							<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/MOSTRARCOLUMNAORDEN">
								<td class="textRight"><xsl:value-of select="LIC_OFE_ORDEN"/>&nbsp;</td>
							</xsl:if>
						</xsl:if>
					</tr>

				</xsl:for-each>  <!--fin de pedidos-->
   				</tbody>
			</xsl:otherwise>
			</xsl:choose><!--fin de choose si hay pedidos-->
   			<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/ROL='COMPRADOR' and /AnalisisLicitaciones/LINEASLICITACION/TOTAL != '0'">
				<tfoot class="rodape_tabela">
            		<tr>
						<td colspan="15">&nbsp;</td>
						<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/MOSTRAREMPRESA">
							<td>&nbsp;</td>
						</xsl:if>          
                		<td class="textRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:</td>
                		<td class="textRight">
                    		<xsl:choose>
                        		<xsl:when test="/AnalisisLicitaciones/LINEASLICITACION/MOSTRAR_PRECIOS_CON_IVA">
                            		<xsl:value-of select="/AnalisisLicitaciones/LINEASLICITACION/TOTAL_PEDIDOS_CONIVA"/>
                        		</xsl:when>
                        		<xsl:otherwise>
                            		<xsl:value-of select="/AnalisisLicitaciones/LINEASLICITACION/TOTAL_PEDIDOS"/>
                        		</xsl:otherwise>
                    		</xsl:choose>&nbsp;
                		</td>
                		<td class="textRight"><xsl:value-of select="TOTAL_AHORRO"/>&nbsp;</td>
                		<td class="textRight"><xsl:value-of select="PORC_AHORRO"/>&nbsp;</td>
						<td colspan="2">&nbsp;</td>
            		</tr>
				</tfoot>
			</xsl:if>
			</table>
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

<!--buscador para todos los usuarios en analisis-->
<xsl:template name="buscador">
	<xsl:variable name="lang">
		<xsl:value-of select="/AnalisisLicitaciones/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--8jun22 Separamos los desplegables de empresa y centro-->
	<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/FILTROS/IDEMPRESA or /AnalisisLicitaciones/LINEASLICITACION/FILTROS/IDCENTRO">
		<table cellspacing="6px" cellpadding="6px">
		<tr>
			<xsl:choose>
				<xsl:when test="/AnalisisLicitaciones/LINEASLICITACION/FILTROS/IDEMPRESA">
					<td class="w100px labelRight">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:&nbsp;<br />
					</td>
					<td class="w300px textLeft">
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="/AnalisisLicitaciones/LINEASLICITACION/FILTROS/IDEMPRESA/field"/>
							<xsl:with-param name="claSel">w300px</xsl:with-param>
						</xsl:call-template>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td class="w1px">
					  <input type="hidden" name="IDEMPRESA" value="{IDEMPRESA}"/>
					</td>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/FILTROS/IDCENTRO">
				<td class="w100px labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;<br />
				</td>
				<td class="w300px textLeft">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/AnalisisLicitaciones/LINEASLICITACION/FILTROS/IDCENTRO/field"/>
						<xsl:with-param name="claSel">w300px</xsl:with-param>
					</xsl:call-template>
				</td>
			</xsl:if>
			<td>&nbsp;</td>
		</tr>
		</table>
		<br/>
	</xsl:if>
	<table cellspacing="6px" cellpadding="6px">
	<tr>
	<td class="w20px">&nbsp;</td>
	<td class="w100px textLeft">
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion']/node()"/>:</label><br />
		<input type="text" class="campopesquisa w100px" name="CODIGOLICITACION" maxlength="15" value="{/AnalisisLicitaciones/LINEASLICITACION/CODIGOLICITACION}"/>
	</td>
	<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/ROL='COMPRADOR'">
	<td class="w170px textLeft">
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label><br />
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/AnalisisLicitaciones/LINEASLICITACION/FILTROS/IDPROVEEDOR/field"/>
			<xsl:with-param name="claSel">w170px</xsl:with-param>
		</xsl:call-template>
	</td>
	</xsl:if>
	<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/MOSTRAR_REF_MVM"><!-- 5ene22 ocultamos para proveedores de Brasil	-->
		<td class="w100px textLeft">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Ref']/node()"/>:</label><br />
			<input type="text" class="campopesquisa w100px" name="REFMVM" maxlength="20" value="{/AnalisisLicitaciones/LINEASLICITACION/REFMVM}"/>
		</td>
	</xsl:if>
	<td class="w100px textLeft">
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:</label><br />
		<input type="text" class="campopesquisa w100px" name="PRODUCTO" maxlength="40" value="{/AnalisisLicitaciones/LINEASLICITACION/PRODUCTO}"/>
	</td>
	<td class="w100px textLeft">
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>:</label><br />
		<input type="text" class="campopesquisa w100px" name="MARCA" maxlength="20" value="{/AnalisisLicitaciones/LINEASLICITACION/MARCA}"/>
	</td>
	<td class="w80px textLeft fondoGris">
		<!--fecha inicio-->
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_inicio']/node()"/>:</label><br />
		<input type="text" class="campopesquisa w80px" name="FECHA_INICIO" value="{/AnalisisLicitaciones/LINEASLICITACION/FECHAINICIO}" maxlength="10" />
	</td>
	<td class="w80px textLeft fondoGris">
		<!--fecha final-->
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_final']/node()"/>:</label><br />
		<input type="text" class="campopesquisa w80px" name="FECHA_FINAL" value="{/AnalisisLicitaciones/LINEASLICITACION/FECHAFINAL}" maxlength="10" />
	</td>
	<td class="w140px textLeft">
		<input type="checkbox" class="muypeq" name="INCLUIROFERTAS" onclick="javascript:IncluirOfertasClick();">
		<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/INCLUIROFERTAS = 'S'">
			<xsl:attribute name="checked" value="checked"/>
		</xsl:if>
		</input>
		<xsl:choose>
		<xsl:when test="/AnalisisLicitaciones/LINEASLICITACION/ROL='COMPRADOR'">
			<label>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ofertas']/node()"/></label>
		</xsl:when>
		<xsl:otherwise>
			<label>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='datos_historicos2']/node()"/></label>
		</xsl:otherwise>
		</xsl:choose>
		<br/>
		<input type="checkbox" class="muypeq" name="SOLOACTIVAS">
			<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/SOLOACTIVAS = 'S'">
				<xsl:attribute name="checked" value="checked"/>
			</xsl:if>
		</input>
		<label>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_activas']/node()"/></label>
	</td>
	<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/ROL='COMPRADOR'">
		<td class="w200px textLeft">
			<input type="checkbox" class="muypeq" name="BORRADOSENPEDIDOS" onclick="javascript:BorradosEnPedidosClick();">
				<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/BORRADOSENPEDIDOS = 'S'">
					<xsl:attribute name="checked" value="checked"/>
				</xsl:if>
			</input>
			<label>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Borrados_en_pedidos']/node()"/></label>
			<br/>
			<input type="checkbox" class="muypeq" name="AHORRONEGOCIACION">
				<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/AHORRONEGOCIACION = 'S'">
					<xsl:attribute name="checked" value="checked"/>
				</xsl:if>
			</input>
			<label>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro_negociacion']/node()"/></label>
			<br/>
			<input type="checkbox" class="muypeq" name="DESDECONTRATO">
				<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/DESDECONTRATO = 'S'">
					<xsl:attribute name="checked" value="checked"/>
				</xsl:if>
			</input>
			<label>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Desde_contrato']/node()"/></label>
		</td>
	</xsl:if>
	<td class="w100px textLeft">
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
	<td class="w120px textLeft">
		<a href="javascript:AplicarFiltro();" title="Buscar" class="btnDestacado">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
		</a>
	</td>
    <td>&nbsp;</td><!--	para completar espacio hasta el final de linea	-->
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
