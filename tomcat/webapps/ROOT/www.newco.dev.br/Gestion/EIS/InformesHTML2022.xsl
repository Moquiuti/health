<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Presentacion de datos estadisticos de utilizacion de la plataforma MedicalVM
	Ultima revision: ET 7jul23 12:00
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang"><xsl:value-of select="EISInformes/LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="/EISInformes/INFORMES/EMPRESA"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='informes']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript">
	//	Abre un informe segun su ID
	function abrirInformes(IDEmpresa, idInforme){
		var Enlace	= 'http://www.newco.dev.br/General/CargaPagina.html?TARGET=http://www.newco.dev.br/Gestion/EIS/EISInformes2022.xsql?IDEMPRESA=' + IDEmpresa +'&amp;IDINFORME='+idInforme;
		MostrarPagPersonalizada(Enlace, '_blank', 100, 80, 0, 10);
	}
</script>

</head>
<body>
	<xsl:choose>
	<xsl:when test="/EISInformes/ROWSET/ROW/Sorry"><xsl:apply-templates select="/EISInformes/ROWSET/ROW/Sorry"/></xsl:when>
	<xsl:when test="/EISInformes/SESION_CADUCADA"><xsl:apply-templates select="/EISInformes/SESION_CADUCADA"/></xsl:when>
	<xsl:otherwise>
		<!--idioma-->
		<xsl:variable name="lang"><xsl:value-of select="/EISInformes/LANG"/></xsl:variable>
		<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
		<!--idioma fin-->

		<xsl:call-template name="Pagina_principal_completa">
			<xsl:with-param name="doc"><xsl:value-of select="$doc"/></xsl:with-param>		
		</xsl:call-template>
	</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>

<xsl:template name="Pagina_principal_completa">
	<xsl:param name="doc"/>
	
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:value-of select="/EISInformes/INFORMES/EMPRESA"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='informes']/node()"/>
		</p>
	</div>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<div class="divLeft50nopa">
		<table class="w600px marginLeft50 fuenteDest" cellspacing="6px" cellpadding="6px">
		<tr>
			<td>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='informes']/node()"/>:</label>
			</td>
		</tr>
			<!--	6oct16	análisis de líneas de pedidos y análisis de lineas de licitaciones	-->
			<tr><td><a href="http://www.newco.dev.br/General/CargaPagina.html?TARGET=http://www.newco.dev.br/Personal/BandejaTrabajo/AnalisisPedidos2022.xsql"><xsl:value-of select="document($doc)/translation/texts/item[@name='Analisis_pedidos']/node()"/></a></td></tr>
			<tr><td><a href="http://www.newco.dev.br/General/CargaPagina.html?TARGET=http://www.newco.dev.br/Personal/BandejaTrabajo/AnalisisPedidosContrato2022.xsql"><xsl:value-of select="document($doc)/translation/texts/item[@name='Analisis_pedidos_contrato']/node()"/></a></td></tr>
			<tr><td><a href="http://www.newco.dev.br/General/CargaPagina.html?TARGET=http://www.newco.dev.br/Gestion/EIS/AnalisisABCPedidos2022.xsql"><xsl:value-of select="document($doc)/translation/texts/item[@name='Analisis_pedidos_ABC']/node()"/></a></td></tr>
			<tr><td><a href="http://www.newco.dev.br/General/CargaPagina.html?TARGET=http://www.newco.dev.br/Personal/BandejaTrabajo/PedidosPorProveedor2022.xsql"><xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_por_proveedor_y_centro']/node()"/></a></td></tr>
			<tr><td><a href="http://www.newco.dev.br/General/CargaPagina.html?TARGET=http://www.newco.dev.br/Gestion/EIS/ResumenPedidosPorProveedor2022.xsql"><xsl:value-of select="document($doc)/translation/texts/item[@name='Resumen_pedidos_por_proveedor']/node()"/></a></td></tr>
			<tr><td><a href="http://www.newco.dev.br/General/CargaPagina.html?TARGET=http://www.newco.dev.br/Gestion/EIS/PedidosPorProducto2022.xsql"><xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_por_producto']/node()"/></a></td></tr>
			<tr><td><a href="http://www.newco.dev.br/General/CargaPagina.html?TARGET=http://www.newco.dev.br/Gestion/Comercial/LicAnalisisLineas2022.xsql"><xsl:value-of select="document($doc)/translation/texts/item[@name='Analisis_licitaciones']/node()"/></a></td></tr>
			<xsl:if test="/EISInformes/INFORMES/MVM or /EISInformes/INFORMES/MVMB">
				<tr><td><a href="http://www.newco.dev.br/General/CargaPagina.html?TARGET=http://www.newco.dev.br/Gestion/Comercial/LicAnalisisProveedores2022.xsql"><xsl:value-of select="document($doc)/translation/texts/item[@name='Analisis_proveedores_licitacion']/node()"/></a></td></tr>
			</xsl:if>
			<xsl:if test="/EISInformes/INFORMES/ANALISISTARIFAS='S'">
				<tr><td><a href="http://www.newco.dev.br/General/CargaPagina.html?TARGET=http://www.newco.dev.br/Gestion/EIS/AnalisisTarifas2022.xsql"><xsl:value-of select="document($doc)/translation/texts/item[@name='Analisis_tarifas']/node()"/></a></td></tr>
			</xsl:if>
			<xsl:for-each select="/EISInformes/INFORMES/INFORMES/field/dropDownList/listElem">
				<tr><td><a href="javascript:abrirInformes({/EISInformes/INFORMES/IDEMPRESA},{ID});"><xsl:value-of select="listItem"/></a></td></tr>
			</xsl:for-each>
		</table>
	</div>
	<div class="divLeft50nopa">
		<xsl:if test="/EISInformes/INFORMES">
		<table class="w600px marginLeft50 fuenteDest" cellspacing="6px" cellpadding="6px">
			<tr>
				<td>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Informes_precalculados']/node()"/>:</label>
				</td>
			</tr>
			<xsl:for-each select="/EISInformes/INFORMES/INFORMES/INFORME">
				<tr><td><a href="http://www.newco.dev.br/Descargas/{EIS_IPC_FICHERO}"><xsl:value-of select="TIPO"/>&nbsp;[<xsl:value-of select="EIS_IPC_FECHA"/>]</a></td></tr>
			</xsl:for-each>
		</table>
		</xsl:if>
	<br /><br />
	<br /><br />
	<br /><br />
	</div>
</xsl:template>
<xsl:template name="Pagina_principal_reducida">
	<xsl:param name="doc"/>
	<div class="divLeft margin25">
		<br/>
		<br/>
		<xsl:choose>
		<xsl:when test="/EISInformes/INFORMES/NOTICIAS/NOTICIA">
			<div class="boxInicio" id="pedidosBox" style="border:0px solid #939494;border-top:0;width:90%;margin: auto;">
				<xsl:apply-templates select="/EISInformes/INFORMES/NOTICIAS"/>
			</div>
		</xsl:when>
		<xsl:otherwise>
			<br/>
			<br/>
		</xsl:otherwise>
		</xsl:choose>
		<br/>
		<br/>
		<div style="float:left; width:10%;">&nbsp;</div>
		<div class="divLeft40nopa">
			<p>&nbsp;</p>
			<xsl:variable name="PRIMERACONSULTA"><xsl:value-of select="/EISInformes/INFORMES/LISTACONSULTAS/GRUPO/CONSULTA/ID"/></xsl:variable>
			<table class="buscador" style="font-size:14px;">
				<tr class="subtituloTabla">
					<th>&nbsp;</th>
					<th><p style="font-size:20px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='alarmas_control_automatico']/node()"/></p></th>
					<th>&nbsp;</th>
				</tr>
				<xsl:if test="not(/EISInformes/INFORMES/ALARMAS/ALARMA)">
				<tr class="sinLinea">
					<td>&nbsp;</td>
					<td class="subTitle">
						<p style="font-size:20px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='ninguna_alarma_activa']/node()"/>.</p>
					</td>
					<td>&nbsp;</td>
				</tr>
				</xsl:if>

			<tbody>
			<xsl:for-each select="/EISInformes/INFORMES/ALARMAS/ALARMA">
				<tr class="sinLinea">
					<td>
                        <p>
                            <xsl:choose>
                                <xsl:when test="POSITIVO = 'S'"><img src="http://www.newco.dev.br/images/SemaforoVerde.gif"/></xsl:when>
                                <xsl:otherwise><img src="http://www.newco.dev.br/images/SemaforoRojo.gif"/></xsl:otherwise>
                            </xsl:choose>

                        </p>
                    </td>
					<td class="textLeft"><p>
						<a style="text-decoration:none;font-size:18px;">
							<!--9dic21 abrimos en la misma ventana	<xsl:attribute name="href">javascript:MostrarPag('<xsl:value-of select="ENLACE"/>');</xsl:attribute>-->
							<xsl:attribute name="href"><xsl:value-of select="ENLACE2022"/></xsl:attribute>
							<xsl:value-of select="NOMBRE"/>
						</a>&nbsp;
						<!--enseño image solo si es mvm o mvmb-->
						<xsl:if test="/EISInformes/INFORMES/PRESENTARENLACEALTERNATIVO">
							<a target="_blank">
								<xsl:attribute name="href"><xsl:value-of select="ENLACE2022"/></xsl:attribute>
								<img src="http://www.newco.dev.br/images/newPage.gif" alt="Nueva pag" class="newPage" style="display:none;"/>
							</a>
						</xsl:if>
					</p></td>
					<td>&nbsp;</td>
				</tr>
			</xsl:for-each>
			</tbody>

			<tfoot>
				<tr class="sinLinea">
					<td class="footLeft">&nbsp;</td>
					<td>&nbsp;</td>
					<td class="footRight">&nbsp;</td>
				</tr>
			</tfoot>
			</table>

			<p>&nbsp;</p>
		</div><!--fin de divLeft40-->

		<!--28ene22	<div class="divLeft40nopa">-->
		<div>
			<xsl:attribute name="class">
        	<xsl:choose>
            	<xsl:when test="/EISInformes/INFORMES/INFORMES/INFORME">divLeft30nopa</xsl:when>
            	<xsl:otherwise>divLeft40nopa</xsl:otherwise>
        	</xsl:choose>
			</xsl:attribute>
			<p>&nbsp;</p>
			<xsl:for-each select="/EISInformes/INFORMES/LISTACONSULTAS/GRUPO">
			<table class="buscador">
			<thead>
				<tr class="subtituloTabla">
					<th>&nbsp;</th>
					<th><p style="font-size:20px;"><xsl:value-of select="NOMBRE"/></p></th>
					<th>&nbsp;</th>
				</tr>
			</thead>

			<tbody>
			<xsl:for-each select="./CONSULTA">
				<tr class="sinLinea">
					<td><p><img src="http://www.newco.dev.br/images/listNaranja.gif"/></p></td>
					<td class="textLeft"><p><a style="font-size:18px;">
						<xsl:attribute name="href">javascript:MostrarConsulta('<xsl:value-of select="ID"/>');</xsl:attribute>
						<xsl:value-of select="NOMBRE"/></a>&nbsp;
						<!--enseño image solo si es mvm o mvmb-->
						<xsl:if test="/EISInformes/INFORMES/PRESENTARENLACEALTERNATIVO">
							<a target="_blank">
								<xsl:attribute name="href">http://www.newco.dev.br/Gestion/EIS/EISBasico2022.xsql?IDCONSULTA=<xsl:value-of select="ID"/></xsl:attribute>
								<img src="http://www.newco.dev.br/images/newPage.gif" alt="Nueva pag" class="newPage" style="display:none;"/>
							</a>
						</xsl:if>
					</p></td>
					<td>&nbsp;</td>
				</tr>
			</xsl:for-each>
			</tbody>

			<tfoot>
				<tr class="sinLinea">
					<td class="footLeft">&nbsp;</td>
					<td>&nbsp;</td>
					<td class="footRight">&nbsp;</td>
				</tr>
			</tfoot>
			</table>
			</xsl:for-each>
		</div><!--fin de divLeft40-->


	</div><!--fin de right-->
</xsl:template>


<xsl:template name="CONSULTAS">
    <xsl:for-each select="/EISInformes/INFORMES/LISTACONSULTAS/GRUPO">
	<table class="grandeInicio" style="border:1px solid #666;">
	<thead>
		<tr class="subtituloTabla">
			<th class="quince">&nbsp;</th>
			<th colspan="2" align="left">&nbsp;<xsl:value-of select="NOMBRE"/></th>
			<th><img src="http://www.newco.dev.br/images/cerrar.gif" alt="cerrar" id="cerrarConsultas" class="cerrarEis"/></th>
		</tr>
	</thead>
	<tbody>
	<xsl:for-each select="./CONSULTA">
		<tr class="sinLinea">
           <td>&nbsp;</td>
			<td><img src="http://www.newco.dev.br/images/listNaranja.gif"/></td>
			<td class="textLeft">
                <a>
				<xsl:attribute name="href">javascript:MostrarConsulta('<xsl:value-of select="ID"/>');</xsl:attribute>
				<xsl:value-of select="NOMBRE"/>
                </a>&nbsp;
                <!--enseño image solo si es mvm o mvmb-->
                <xsl:if test="/EISInformes/INFORMES/PRESENTARENLACEALTERNATIVO">
				<a target="_blank">
                	<xsl:attribute name="href">http://www.newco.dev.br/Gestion/EIS/EISBasico2022.xsql?IDCONSULTA=<xsl:value-of select="ID"/></xsl:attribute>
                	<img src="http://www.newco.dev.br/images/newPage.gif" alt="Nueva pag" class="newPage" style="display:none;"/>
				</a>
                </xsl:if>
			</td>
			<td>&nbsp;</td>
		</tr>
	</xsl:for-each>
	</tbody>
	</table>
	</xsl:for-each>
</xsl:template><!--FIN DE consultas-->

<!--	28ene22 Nuevo template de NOTICIAS	-->
<xsl:template match="NOTICIAS">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/EISInformes/LANG"><xsl:value-of select="/EISInformes/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!--30may22 Destacar noticias-->
	<xsl:variable name="destacar">
		<xsl:choose>
		<xsl:when test="DESTACAR_NOTICIAS">S</xsl:when>
		<xsl:otherwise>N</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<table class="noticiasMvm" border="0">
		<tr class="tituloTabla">
			<th colspan="3">
				<p><xsl:value-of select="document($doc)/translation/texts/item[@name='noticias_de']/node()"/>&nbsp;<xsl:value-of select="/EISInformes/INFORMES/PORTAL/PMVM_NOMBRE"/></p>
			</th>
			<th class="plegado">&nbsp;</th>
		</tr>

		<xsl:for-each select="NOTICIA">
			<tr class="conhover">
				<td>
					<img src="http://www.newco.dev.br/images/listAzul.gif" alt="cuadrado"/>
					<xsl:copy-of select="FECHA"/>
				</td>
				<td>
					<xsl:choose>
					<xsl:when test="not(ENLACE)">
						<xsl:value-of select="TITULO"/>
					</xsl:when>
					<xsl:otherwise>
						<a href="{ENLACE/NOT_ENLACE_URL}" title="{ENLACE/NOT_ENLACE_URL}" target="_blank"><xsl:copy-of select="TITULO"/></a>
					</xsl:otherwise>
					</xsl:choose>
					
					<xsl:if test="DOC_NOTICIA">
						&nbsp;&nbsp;&nbsp;Doc:<a href="http://www.newco.dev.br/Documentos/{DOC_NOTICIA/URL}" target="_blank"><xsl:value-of select="DOC_NOTICIA/NOMBRE"/></a>
					</xsl:if>
					
				</td>
				<td><xsl:copy-of select="CUERPO"/></td>
				<td class="cinco">
					<xsl:if test="$destacar='N'">
        				<a class="btnDestacadoPeq" href="javascript:NoticiaLeida('{ID}');"><xsl:value-of select="document($doc)/translation/texts/item[@name='leida']/node()"/></a>
					</xsl:if>
    			</td>
			</tr>
		</xsl:for-each>

		<tr>
			<td colspan="3">&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
	<br/><br/>
</xsl:template>


</xsl:stylesheet>
