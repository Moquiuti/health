<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Listado/buscador de lineas de licitación, incluyendo info de las lineas de pedido generadas
	Última revisión: ET 7mar17	09:20
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
		<xsl:when test="/AnalisisProveedores/LANG"><xsl:value-of select="/AnalisisProveedores/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<meta http-equiv="Cache-Control" Content="no-cache"/>

        <title><xsl:value-of select="document($doc)/translation/texts/item[@name='analisis_proveedores_licitacion']/node()"/></title>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/analisisProveedoresLic_6mar17.js"></script>
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


	<form  method="post" name="Form1" action="AnalisisProveedores.xsql">

	<xsl:choose>
	<!-- Error en alguna sentencia del XSQL -->
	<xsl:when test="AnalisisProveedores/INICIO/xsql-error">
		<xsl:apply-templates select="AnalisisProveedores/INICIO/xsql-error"/>
	</xsl:when>
	<xsl:when test="AnalisisProveedores/INICIO/SESION_CADUCADA">
		<xsl:for-each select="AnalisisProveedores/INICIO/SESION_CADUCADA">
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
		<xsl:when test="/AnalisisProveedores/LANG"><xsl:value-of select="/AnalisisProveedores/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->


    <div class="divLeft boxInicio" id="pedidosBox" style="border:1px solid #939494;border-top:0;">

        <input type="hidden" name="IDPRODUCTO" value="{/AnalisisProveedores/IDPRODUCTO}"/>

		<xsl:for-each select="/AnalisisProveedores/LINEASPROVEEDORES/COMPRADOR">
			<input type="hidden" name="ORDEN" value="{./ORDEN}"/>
			<input type="hidden" name="SENTIDO" value="{./SENTIDO}"/>
			<input type="hidden" name="IDEMPRESAUSUARIO" value="{./IDEMPRESAUSUARIO}"/>

			<!--	Titulo de la página		-->
			<div class="ZonaTituloPagina">
				<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eis']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Analisis_proveedores_licitacion']/node()"/></span></p>
				<p class="TituloPagina">
					<xsl:if test="NOMBREPRODUCTO != ''">
						<xsl:value-of select="substring(NOMBREPRODUCTO,0,50)" />:&nbsp;
					</xsl:if>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Analisis_proveedores_licitacion']/node()"/>&nbsp;
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
                		<xsl:value-of select="document($doc)/translation/texts/item[@name='lineas_de_proveedores']/node()"/>&nbsp;&nbsp;&nbsp;
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
			<table class="buscador">
            <input type="hidden" name="PAGINA" id="PAGINA" value="{PAGINA}"/>

			<tr class="filtros">
				<td colspan="20">
					<xsl:call-template name="buscador"/>
            	</td>
			</tr>

			<tr class="subTituloTabla">
				<th class="uno">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
				<th class="uno">
					<a href="javascript:OrdenarPor('NUMERO_LICITACION');"><xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion']/node()"/></a>
				</th>
				<th class="cinco">
					<a href="javascript:OrdenarPor('FECHA_LICITACION');"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></a>
				</th>
				<xsl:if test="/AnalisisProveedores/LINEASPROVEEDORES/COMPRADOR/MOSTRAREMPRESA">
				<th class="quince" align="left">
					&nbsp;<a href="javascript:OrdenarPor('EMPRESA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></a>
				</th>
				</xsl:if>
				<th class="quince" align="left">
					&nbsp;<a href="javascript:OrdenarPor('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a>
				</th>
				<th class="cinco">
					&nbsp;<a href="javascript:OrdenarPor('OFERTASADJUDICADAS');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='Ofertas_adjudicadas']/node()"/></a>
				</th>
				<th class="cinco">
					&nbsp;<a href="javascript:OrdenarPor('OFERTASPRESENTADAS');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='Ofertas_presentadas']/node()"/></a>
				</th>
				<th class="cinco">
					&nbsp;<a href="javascript:OrdenarPor('LINEASLICITACION');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='Lineas_licitacion']/node()"/></a>
				</th>
				<th class="cinco">
					&nbsp;<a href="javascript:OrdenarPor('CONSUMOADJUDICADO');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='Consumo_adjudicado']/node()"/></a>
				</th>
				<th class="cinco">
					&nbsp;<a href="javascript:OrdenarPor('PORC_CONSUMO');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='Porc_consumo']/node()"/></a>
				</th>
				<th class="cinco">
					&nbsp;<a href="javascript:OrdenarPor('PORC_AHORRO');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='Porc_ahorro']/node()"/></a>
				</th>
			</tr>

		<!--SI NO HAY PEDIDOS ENSEï¿½O UN MENSAJE Y SIGO ENSEï¿½ANDO CABECERA-->
		<xsl:choose>
		<xsl:when test="/AnalisisProveedores/LINEASPROVEEDORES/TOTAL = '0'">
			<tr class="lejenda"><th colspan="17"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_pedidos_para_busqueda']/node()"/></th></tr>
		</xsl:when>
		<xsl:otherwise>
    		<tbody>
			<xsl:for-each select="LINEAPROVEEDOR">
				<tr>
					<td><xsl:value-of select="POSICION"/></td>
                	<td>
						<a>
							<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/MantLicitacion.xsql?LIC_ID=<xsl:value-of select="LIC_ID"/>','Licitacion',100,100,0,0)</xsl:attribute>
							<xsl:value-of select="LIC_CODIGO"/>
						</a>
					</td>
					<td class="textCenter">
                    	<xsl:value-of select="LIC_FECHAALTA"/>
                	</td>
					<xsl:if test="/AnalisisProveedores/LINEASPROVEEDORES/COMPRADOR/MOSTRAREMPRESA">
					<td class="textLeft">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDCLIENTE}&amp;VENTANA=NUEVA','Empresa',100,80,0,-20);">
							<xsl:value-of select="CLIENTE"/>
						</a>
					</td>
					</xsl:if>
					<td class="textLeft">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDPROVEEDOR}&amp;VENTANA=NUEVA','Centro',100,80,0,-20);">
							<xsl:value-of select="PROVEEDOR"/>
						</a>
					</td>
					<td class="textRight">
                    	<xsl:value-of select="LIC_PROV_OFERTASADJUDICADAS"/>
                    	&nbsp;
                	</td>
					<td class="textRight">
                    	<xsl:value-of select="LIC_PROV_NUMEROLINEAS"/>
                    	&nbsp;
                	</td>
					<td class="textRight">
                    	<xsl:value-of select="LIC_NUMEROLINEAS"/>
                    	&nbsp;
                	</td>
					<td class="textRight">
                    	<xsl:value-of select="LIC_PROV_CONSUMOADJUDICADO"/>
                    	&nbsp;
                	</td>
					<td class="textRight">
                    	<xsl:value-of select="PORC_CONSUMO"/>%
                    	&nbsp;
                	</td>
					<td class="textRight">
                    	<xsl:value-of select="LIC_PROV_AHORRO"/>%
                    	&nbsp;
                	</td>
				</tr>

			</xsl:for-each>  <!--fin de pedidos-->
   			</tbody>
		</xsl:otherwise>
		</xsl:choose><!--fin de choose si hay pedidos-->

        	<tfoot>
            	<xsl:if test="/AnalisisProveedores/LINEASPROVEEDORES/TOTAL != '0'">
            	<tr style="height:30px; font-weight:bold;">
                	<td colspan="4">&nbsp;</td>
                	<td class="textRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:</td>
                	<td style="text-align:right;"><xsl:value-of select="TOTAL_OFERTASADJ"/>&nbsp;</td>
                	<td style="text-align:right;"><xsl:value-of select="TOTAL_OFERTAS"/>&nbsp;</td>
                	<td style="text-align:right;"><xsl:value-of select="TOTAL_LINEAS"/>&nbsp;</td>
                	<td style="text-align:right;"><xsl:value-of select="TOTAL_CONSUMOADJ"/>&nbsp;</td>
                	<td style="text-align:right;">&nbsp;</td>
                	<td style="text-align:right;"><xsl:value-of select="PORC_AHORRO"/>&nbsp;</td>
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
		<xsl:value-of select="/AnalisisProveedores/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>

	<!--table select-->
	<table class="buscador" border="0">
	<!--<tr class="select">-->
	<tr class="filtros">
	<th class="zerouno">&nbsp;</th>
	<th width="140px" style="text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion']/node()"/>:</label><br />
			<input type="text" name="CODIGOLICITACION" size="9" maxlength="15" value="{CODIGOLICITACION}"/>
		</th>
	<xsl:choose>
		<xsl:when test="FILTROS/IDEMPRESA">
			<th width="140px" style="text-align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:</label><br />
				<xsl:call-template name="desplegable"><xsl:with-param name="path" select="FILTROS/IDEMPRESA/field"/></xsl:call-template>
			</th>
		</xsl:when>
		<xsl:otherwise>
			<th class="zerouno">
			  <input type="hidden" name="IDEMPRESA" value="{IDEMPRESA}"/>
			</th>
		</xsl:otherwise>
	</xsl:choose>

	<xsl:if test="FILTROS/IDCENTRO">
		<th width="140px" style="text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</label><br />
			<xsl:call-template name="desplegable"><xsl:with-param name="path" select="FILTROS/IDCENTRO/field"/></xsl:call-template>
		</th>
	</xsl:if>
	<th width="140px" style="text-align:left;">
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label><br />
		<xsl:call-template name="desplegable"><xsl:with-param name="path" select="FILTROS/IDPROVEEDOR/field"/></xsl:call-template>
	</th>
	<th  width="140px" style="text-align:left;background:#E4E3E3;">
	<!--fecha inicio-->
	<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_inicio']/node()"/>:</label><br />
	<input type="text" name="FECHA_INICIO" value="{FECHAINICIO}" size="9" style="background:#FFFF99;border:1px solid #ccc;" />
	</th>
	<th width="140px" style="text-align:left;background:#E4E3E3;">
	<!--fecha final-->
	<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_final']/node()"/>:</label><br />
	<input type="text" name="FECHA_FINAL" value="{FECHAFINAL}"  size="9"  />
	</th>
	<th width="140px">
		<select name="LINEA_POR_PAGINA" id="LINEA_POR_PAGINA"><!-- onchange="AplicarFiltro();"-->
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
