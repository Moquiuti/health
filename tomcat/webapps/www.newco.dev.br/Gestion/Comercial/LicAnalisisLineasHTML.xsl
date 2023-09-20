<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Listado/buscador de lineas de licitación, incluyendo info de las lineas de pedido generadas
	Ultima revisión: ET 08jun22 12:40  LicAnalisisLineas_161221.js
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

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/LicAnalisisLineas_161221.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.base64.js"></script>

	<script type="text/javascript">

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


	<form  method="post" name="Form1" action="LicAnalisisLineas.xsql">

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


    <div class="divLeft boxInicio" id="pedidosBox" style="border:1px solid #939494;border-top:0;">

        <input type="hidden" name="IDPRODUCTO" value="{/AnalisisLicitaciones/IDPRODUCTO}"/>

		<!--<xsl:for-each select="/AnalisisLicitaciones/LINEASLICITACION/COMPRADOR">-->
			<input type="hidden" name="ORDEN" value="{/AnalisisLicitaciones/LINEASLICITACION/ORDEN}"/>
			<input type="hidden" name="SENTIDO" value="{/AnalisisLicitaciones/LINEASLICITACION/SENTIDO}"/>
			<input type="hidden" name="IDEMPRESAUSUARIO" value="{/AnalisisLicitaciones/LINEASLICITACION/IDEMPRESAUSUARIO}"/>

			<!--	Titulo de la página		-->
			<div class="ZonaTituloPagina">
				<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eis']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Analisis_lineas_licitaciones']/node()"/></span></p>
				<p class="TituloPagina">
					<xsl:if test="NOMBREPRODUCTO != ''">
						<xsl:value-of select="substring(NOMBREPRODUCTO,0,50)" />:&nbsp;
					</xsl:if>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Analisis_lineas_licitaciones']/node()"/>&nbsp;
					<span class="fuentePequenna">(<xsl:value-of select="/AnalisisLicitaciones/LINEASLICITACION/FECHAACTUAL"/>)</span>
					<span class="CompletarTitulo">
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
						&nbsp;
						</xsl:if>
						<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/Licitaciones.xsql"><xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones']/node()"/></a>
						&nbsp;
					</span>
				</p>
			</div>
			<br/>
			<br/>

		<table class="buscador">
        <input type="hidden" name="PAGINA" id="PAGINA" value="{PAGINA}"/>
		<tr>
			<td bgcolor="#E3E2E2" colspan="20">
				<xsl:call-template name="buscador"/>
            </td>
		</tr>

		<tr class="subTituloTabla">
			<th class="uno">&nbsp;</th>
			<th class="cinco">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>
			</th>
			<!--
			<th class="cinco" align="right">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>&nbsp;
			</th>
			-->
			<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/ROL='VENDEDOR'">
			<th align="left">
				&nbsp;<a href="javascript:OrdenarPor('EMPRESA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></a>
			</th>
			</xsl:if>
            <th style="text-align:left;">
				&nbsp;<a href="javascript:OrdenarPor('PRODUCTO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a>
			</th>
			<th class="tres">
				<a href="javascript:OrdenarPor('NUMERO_LICITACION');"><xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion']/node()"/></a>
			</th>
			<th style="width:120px">
				<a href="javascript:OrdenarPor('FECHA_LICITACION');"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_licitacion']/node()"/></a>
			</th>
			<th style="width:120px">
				<a href="javascript:OrdenarPor('FECHA_VENCIMIENTO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/></a>
			</th>
			<th class="tres">
				<a href="javascript:OrdenarPor('ESTADO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></a>
			</th>
			<th class="tres">
				<a href="javascript:OrdenarPor('NUMERO_PEDIDO');">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>
				</a>
			</th>
            <th class="tres">
				<a href="javascript:OrdenarPor('FECHA_EMISION');"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_emis']/node()"/></a>
			</th>
            <!--<th class="cinco">
				<a href="javascript:OrdenarPor('FECHA_CONFIRMACION');"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_conf']/node()"/></a>
			</th>-->
			<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/MOSTRAREMPRESA">
			<th align="left">
				&nbsp;<a href="javascript:OrdenarPor('EMPRESA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></a>
			</th>
			</xsl:if>
			<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/ROL='COMPRADOR'">
			<th align="left">
				&nbsp;<a href="javascript:OrdenarPor('CENTRO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></a>
			</th>
			<th class="diez" align="left">
				&nbsp;<a href="javascript:OrdenarPor('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a>
			</th>
			</xsl:if>
			<th class="cinco" align="left">
				&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>
			</th>
			<th class="tres" align="left">
				&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>
			</th>
			<!--
			<th class="cinco" align="right">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_lote']/node()"/>&nbsp;
			</th>
			-->
            <th class="tres" align="right">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='cant']/node()"/>&nbsp;
            </th>
            <th class="cinco" align="right">
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
                        	<xsl:when test="/AnalisisLicitaciones/LINEASLICITACION/MOSTRAR_PRECIO_HISTORICO">cinco</xsl:when>
                        	<xsl:otherwise>zerouno</xsl:otherwise>
                    	</xsl:choose>
                	</xsl:attribute>
                	<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/MOSTRAR_PRECIO_HISTORICO"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ref']/node()"/></xsl:if>
            	</th>
            	<th class="cinco" align="right">
                	<xsl:choose>
                    	<xsl:when test="/AnalisisLicitaciones/LINEASLICITACION/MOSTRAR_PRECIOS_CON_IVA"><a href="javascript:OrdenarPor('TOTALLINEACONIVA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/></a></xsl:when>
                    	<xsl:otherwise><a href="javascript:OrdenarPor('TOTALLINEA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/></a></xsl:otherwise>
                	</xsl:choose>&nbsp;
            	</th>
            	<xsl:choose>
                	<xsl:when test="/AnalisisLicitaciones/LINEASLICITACION/MOSTRAR_PRECIO_HISTORICO">
                    	<th class="cinco">
                        	 <a href="javascript:OrdenarPor('PORCAHORRO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/></a>&nbsp;
                    	</th>
                    	<th class="cinco">
                        	 <a href="javascript:OrdenarPor('PORCAHORRO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='perc_ahorro']/node()"/></a>
                    	</th>
                	</xsl:when>
                	<xsl:otherwise>
                    	<th colspan="2" class="zerouno">&nbsp;</th>
                	</xsl:otherwise>
            	</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
            	<th class="cinco">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_cambio']/node()"/>
            	</th>
            	<th class="cinco" align="right">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Precio_inicial']/node()"/>
            	</th>
            	<th class="cinco" align="right">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='ahorro_negociacion_2l']/node()"/>
            	</th>
            	<th class="cinco" align="right">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='perc_ahorro_negociacion_2l']/node()"/>
            	</th>
			</xsl:otherwise>
			</xsl:choose>
			</xsl:if>
			
			<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/ROL='COMPRADOR'">
            <th class="dos" align="right">
                 <a href="javascript:OrdenarPor('ADJUDICADA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='adj']/node()"/></a>&nbsp;
            </th>
            <th class="dos" align="right">
                 <a href="javascript:OrdenarPor('ORDEN');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ord']/node()"/></a>&nbsp;
            </th>
			</xsl:if>
		</tr>

	<xsl:choose>
	<xsl:when test="/AnalisisLicitaciones/LINEASLICITACION/TOTAL = '0'">
		<!--SI NO HAY PEDIDOS: mensaje-->
		<tr class="lejenda"><th colspan="17"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_pedidos_para_busqueda']/node()"/></th></tr>
	</xsl:when>
	<xsl:otherwise>
    	<tbody>
		<xsl:for-each select="/AnalisisLicitaciones/LINEASLICITACION/LINEALICITACION">
			<tr class="conhover" style="border-bottom:1px solid #A7A8A9;">
				<td><xsl:value-of select="POSICION"/></td>
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
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDCLIENTE}&amp;VENTANA=NUEVA','Empresa',100,80,0,-20);">
						<xsl:value-of select="CLIENTE"/>
					</a>
				</td>
				</xsl:if>
                <!--producto-->
                <td class="textLeft">
                    <xsl:choose>
                        <xsl:when test="/AnalisisLicitaciones/LINEASLICITACION/ROL='COMPRADOR'">
							<a href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={LIC_ID}" target="FichaProductoLic">
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
					<a>
						<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/MantLicitacion.xsql?LIC_ID=<xsl:value-of select="LIC_ID"/>','Licitacion',100,100,0,0)</xsl:attribute>
						<xsl:value-of select="LIC_CODIGO"/>
					</a>
				</td>
                <td class="textLeft"><xsl:value-of select="LIC_FECHAALTA"/></td>
               	<td class="textLeft">
			   		<xsl:value-of select="LIC_FECHADECISIONPREVISTA"/>&nbsp;<xsl:value-of select="LIC_HORADECISION"/>:<xsl:value-of select="LIC_MINUTODECISION"/>
				</td>
                <td>
					<xsl:choose>
               		<xsl:when test="/AnalisisLicitaciones/LINEASLICITACION/CONTROLPEDIDOS and PED_ID">
					<a>
						<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Personal/BandejaTrabajo/ControlPedidos.xsql?IDPEDIDO=<xsl:value-of select="PED_ID"/>','ControlPedidos',100,100,0,0)</xsl:attribute>
						<xsl:value-of select="ESTADO"/>
					</a>
               		</xsl:when>
                	<xsl:otherwise>
						<xsl:value-of select="ESTADO"/>
                	</xsl:otherwise>
            		</xsl:choose>
				</td>
				<td>
					<a>
						<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="MO_ID"/>','Multioferta',100,100,0,0)</xsl:attribute>
						<xsl:value-of select="NUMERO_PEDIDO"/>
					</a>
				</td>
                <td><xsl:value-of select="FECHA_PEDIDO"/></td>
               <!-- <td><xsl:value-of select="FECHA_CONFIRMACION"/></td>-->
				<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/MOSTRAREMPRESA">
				<td class="textLeft">
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDCLIENTE}&amp;VENTANA=NUEVA','Empresa',100,80,0,-20);">
						<xsl:value-of select="CLIENTE"/>
					</a>
				</td>
				</xsl:if>
				<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/ROL='COMPRADOR'">
				<td class="textLeft">
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTROCLIENTE}','Centro',100,80,0,-20);">
						<xsl:value-of select="NOMBRE_CENTRO"/>
					</a>
				</td>
				<td class="textLeft">
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDPROVEEDOR}&amp;VENTANA=NUEVA','Centro',100,80,0,-20);">
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
                <!--precio-->
				<td class="textRight"><xsl:value-of select="PRECIO"/>&nbsp;</td>
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
            			<th class="cinco">
							<xsl:value-of select="LIC_OFE_FECHACAMBIOPRECIO"/>
            			</th>
            			<th class="cinco" align="right">
							<xsl:value-of select="LIC_OFE_PRECIOORIGINAL"/>
            			</th>
            			<th class="cinco" align="right">
							<xsl:value-of select="LIC_OFE_AHORRONEGOCIACION"/>
            			</th>
            			<th class="cinco" align="right">
							<xsl:value-of select="LIC_OFE_AHORRONEGOCIACION_PORC"/>
            			</th>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/ROL='COMPRADOR'">
					<td class="textRight"><xsl:value-of select="LIC_OFE_ADJUDICADA"/>&nbsp;</td>
					<td class="textRight"><xsl:value-of select="LIC_OFE_ORDEN"/>&nbsp;</td>
				</xsl:if>
			</tr>
			
		</xsl:for-each>  <!--fin de pedidos-->
   		</tbody>
	</xsl:otherwise>
	</xsl:choose><!--fin de choose si hay pedidos-->
   	<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/ROL='COMPRADOR' and /AnalisisLicitaciones/LINEASLICITACION/TOTAL != '0'">
       <tfoot>
            <tr style="height:30px; font-weight:bold;">
				<td colspan="13">&nbsp;</td>
				<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/MOSTRAREMPRESA">
					<td>&nbsp;</td>
				</xsl:if>          
                <td class="textRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:</td>
                <td style="text-align:right;">
                    <xsl:choose>
                        <xsl:when test="/AnalisisLicitaciones/LINEASLICITACION/MOSTRAR_PRECIOS_CON_IVA">
                            <xsl:value-of select="/AnalisisLicitaciones/LINEASLICITACION/TOTAL_PEDIDOS_CONIVA"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="/AnalisisLicitaciones/LINEASLICITACION/TOTAL_PEDIDOS"/>
                        </xsl:otherwise>
                    </xsl:choose>&nbsp;
                </td>
                <td style="text-align:right;"><xsl:value-of select="TOTAL_AHORRO"/>&nbsp;</td>
                <td style="text-align:right;"><xsl:value-of select="PORC_AHORRO"/>&nbsp;</td>
            </tr>
            <!--<tr><td colspan="16"></td></tr>-->
		</tfoot>
	</xsl:if>
	</table>
    <!--</xsl:for-each>-->
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
		<table class="buscador" border="0">
		<tr class="filtrosgrandes sinlinea">
			<xsl:choose>
				<xsl:when test="/AnalisisLicitaciones/LINEASLICITACION/FILTROS/IDEMPRESA">
					<th width="100px" style="text-align:right;">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:&nbsp;</label><br />
					</th>
					<th width="180px" style="text-align:left;">
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="/AnalisisLicitaciones/LINEASLICITACION/FILTROS/IDEMPRESA/field"/>
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

			<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/FILTROS/IDCENTRO">
				<th width="180px" style="text-align:right;">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;</label><br />
				</th>
				<th width="180px" style="text-align:left;">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/AnalisisLicitaciones/LINEASLICITACION/FILTROS/IDCENTRO/field"/>
						<xsl:with-param name="style">width:170px;</xsl:with-param>
					</xsl:call-template>
				</th>
			</xsl:if>
		    <th></th><!--	para completar espacio hasta el final de linea	-->
		</tr>
		<tr class="filtrosgrandes sinlinea" style="height:20px;"><th>&nbsp;</th></tr>
		</table>
	</xsl:if>

	<table class="buscador" border="0">
	<tr class="filtrosgrandes">
	<th class="zerouno">&nbsp;</th>
	<th width="90px" style="text-align:left;">
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion']/node()"/>:</label><br />
		<input type="text" style="width:80px;" name="CODIGOLICITACION" size="9" maxlength="15" value="{/AnalisisLicitaciones/LINEASLICITACION/CODIGOLICITACION}"/>
	</th>
	<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/ROL='COMPRADOR'">
	<th width="180px" style="text-align:left;">
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label><br />
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/AnalisisLicitaciones/LINEASLICITACION/FILTROS/IDPROVEEDOR/field"/>
			<xsl:with-param name="style">width:170px;</xsl:with-param>
		</xsl:call-template>
	</th>
	</xsl:if>
	<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/MOSTRAR_REF_MVM"><!-- 5ene22 ocultamos para proveedores de Brasil	-->
	<th width="110px" style="text-align:left;">
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Ref']/node()"/>:</label><br />
		<input type="text" name="REFMVM" style="width:100px;" size="30" maxlength="20" value="{/AnalisisLicitaciones/LINEASLICITACION/REFMVM}"/>
	</th>
	</xsl:if>
	<th width="110px" style="text-align:left;">
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:</label><br />
		<input type="text" name="PRODUCTO" style="width:100px;" size="30" maxlength="20" value="{/AnalisisLicitaciones/LINEASLICITACION/PRODUCTO}"/>
	</th>
	<th width="110px" style="text-align:left;">
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>:</label><br />
		<input type="text" name="MARCA" style="width:100px;" size="30" maxlength="20" value="{/AnalisisLicitaciones/LINEASLICITACION/MARCA}"/>
	</th>
	<th  width="100px" style="text-align:left;background:#E4E3E3;">
		<!--fecha inicio-->
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_inicio']/node()"/>:</label><br />
		<input type="text" name="FECHA_INICIO" value="{/AnalisisLicitaciones/LINEASLICITACION/FECHAINICIO}" size="9" style="width:90px;background:#FFFF99;border:1px solid #ccc;" />
	</th>
	<th width="100px" style="text-align:left;background:#E4E3E3;">
		<!--fecha final-->
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_final']/node()"/>:</label><br />
		<input type="text" name="FECHA_FINAL" value="{/AnalisisLicitaciones/LINEASLICITACION/FECHAFINAL}"  size="9"  style="width:90px;background:#FFFF99;border:1px solid #ccc;" />
	</th>
	<th width="160px" style="text-align:left;">
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
	</th>
	<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/ROL='COMPRADOR'">
		<th width="210px" style="text-align:left;">
			<input type="checkbox" class="muypeq" name="BORRADOSENPEDIDOS" onclick="javascript:BorradosEnPedidosClick();">
			<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/BORRADOSENPEDIDOS = 'S'">
				<xsl:attribute name="checked" value="checked"/>
			</xsl:if>
			</input>
			<label>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Borrados_en_pedidos']/node()"/></label><br />
			<input type="checkbox" class="muypeq" name="AHORRONEGOCIACION">
			<xsl:if test="/AnalisisLicitaciones/LINEASLICITACION/AHORRONEGOCIACION = 'S'">
				<xsl:attribute name="checked" value="checked"/>
			</xsl:if>
			</input>
			<label>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Ahorro_negociacion']/node()"/></label>
		</th>
	</xsl:if>
	<th width="110px">
		<select name="LINEA_POR_PAGINA" id="LINEA_POR_PAGINA" style="width:100px;"><!-- onchange="AplicarFiltro();"-->
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
	<th class="uno">&nbsp;</th>
	<th  width="140px" style="text-align:left;">
	<!--<a href="javascript:DescargarExcel();"><img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel"/></a><br />
	<a href="javascript:AplicarFiltro();" title="Buscar">
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
