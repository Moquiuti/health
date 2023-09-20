<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Analisis de pedidos, línea a línea
	Ultima revision ET 7jun23 12:15 AnalisisTarifas2022_070623.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>

<xsl:template match="/">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/AnalisisTarifas/LANG"><xsl:value-of select="/AnalisisTarifas/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<meta http-equiv="Cache-Control" Content="no-cache"/>

    <title><xsl:value-of select="document($doc)/translation/texts/item[@name='Analisis_tarifas']/node()"/>:&nbsp;<xsl:value-of select="/AnalisisTarifas/LINEASTARIFAS/COMPRADOR/TITULO" /></title>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/EIS/AnalisisTarifas2022_070623.js"></script>

	<script type="text/javascript">
		var limiteMeses='<xsl:choose><xsl:when test="/AnalisisTarifas/LINEASTARIFAS/COMPRADOR/LIMITAR_CONSULTAS">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		var plazoMaximo=12;		// antes 6 meses
		var strInformeMesesMaximo="<xsl:value-of select="document($doc)/translation/texts/item[@name='Informe_maximo_meses']/node()"/>";
	</script>
</head>
<body>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/AnalisisTarifas/LANG"><xsl:value-of select="/AnalisisTarifas/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->


	<form  method="post" name="Form1" action="AnalisisTarifas2022.xsql">

	<xsl:choose>
	<!-- Error en alguna sentencia del XSQL -->
	<xsl:when test="/AnalisisTarifas/xsql-error">
		<xsl:apply-templates select="/AnalisisTarifas/xsql-error"/>
	</xsl:when>
	<xsl:when test="/AnalisisTarifas/SESION_CADUCADA">
		<xsl:for-each select="/AnalisisTarifas/SESION_CADUCADA">
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
		<xsl:when test="/AnalisisTarifas/LANG"><xsl:value-of select="/AnalisisTarifas/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->


	<!--14nov22<div class="divLeft boxInicio" id="pedidosBox" style="border:1px solid #939494;border-top:0;overflow-y: scroll;">-->
	<div class="divLeft boxInicio" id="pedidosBox" style="overflow-y: scroll;">

	<input type="hidden" name="IDPRODUCTO" value="{/AnalisisTarifas/LINEASTARIFAS/COMPRADOR/IDPRODUCTO}"/>
	<input type="hidden" name="IDPRODESTANDAR" value="{/AnalisisTarifas/LINEASTARIFAS/COMPRADOR/IDPRODESTANDAR}"/>
	<input type="hidden" name="IDLICITACION" value="{/AnalisisTarifas/LINEASTARIFAS/COMPRADOR/IDLICITACION}"/>

	<xsl:for-each select="/AnalisisTarifas/LINEASTARIFAS/COMPRADOR"><!--	Solo para no tener que utilizar el path completo	-->
	<input type="hidden" name="ORDEN" value="{./ORDEN}"/>
	<input type="hidden" name="SENTIDO" value="{./SENTIDO}"/>
	<input type="hidden" name="IDEMPRESAUSUARIO" value="{./IDEMPRESAUSUARIO}"/>


	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Analisis_tarifas']/node()"/>:&nbsp;<xsl:value-of select="/AnalisisTarifas/LINEASTARIFAS/COMPRADOR/TITULO" />&nbsp;
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
			<th class="textLeft">
				<a href="javascript:OrdenarPor('CENTRO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></a>
			</th>
			<th class="textLeft w50px">
				<a href="javascript:OrdenarPor('REFCENTRO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_centro']/node()"/></a>
			</th>
			<th class="textLeft w20px">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Ord']/node()"/>
			</th>
			<th class="textLeft w50px">
				<a href="javascript:OrdenarPor('REFMVM');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ref_mvm']/node()"/></a>
			</th>
			<th class="textLeft w50px">
				<a href="javascript:OrdenarPor('REFCLIENTE');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></a>
			</th>
			<th class="textLeft w20px">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Ord']/node()"/>
			</th>
			<th class="textLeft">
				<a href="javascript:OrdenarPor('PRODUCTO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a>
			</th>
			<th class="textLeft w50px">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='NIF_proveedor']/node()"/>
			</th>
			<th class="textLeft">
				<a href="javascript:OrdenarPor('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a>
			</th>
			<xsl:if test="/AnalisisTarifas/LINEASTARIFAS/COMPRADOR/MOSTRAR_REF_PROVEEDOR">
				<th class="textLeft w50px">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>
				</th>
			</xsl:if>
			<th class="textLeft w60px">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>
			</th>
			<th class="textLeft">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>
			</th>
			<th class="w100px">
            	<a href="javascript:OrdenarPor('PRECIO');">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>(<xsl:value-of select="/AnalisisTarifas/LINEASTARIFAS/COMPRADOR/DIVISA/PREFIJO"/><xsl:value-of select="/AnalisisTarifas/LINEASTARIFAS/COMPRADOR/DIVISA/SUFIJO"/>)
				</a>
            </th>
			<th class="textLeft w50px">
             	<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_inicio_tarifa']/node()"/>
            </th>
			<th class="textLeft w50px">
             	<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_final_tarifa']/node()"/>
            </th>
			<th class="textLeft w50px">
             	<xsl:value-of select="document($doc)/translation/texts/item[@name='cant']/node()"/>
            </th>
		</tr>
    	</thead>

		<!--SI NO HAY PEDIDOS ENSEÑO UN MENSAJE Y SIGO ENSEÑANDO CABECERA-->
		<xsl:choose>
		<xsl:when test="/AnalisisTarifas/LINEASTARIFAS/TOTAL = '0'">
			<tbody>
				<tr><td class="color_status">&nbsp;</td><td colspan="16"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_se_han_encontrado_resultados']/node()"/></td></tr>
			</tbody>
		</xsl:when>
		<xsl:otherwise>
			<tbody class="corpo_tabela">
			<xsl:for-each select="LINEATARIFA">
				<tr class="conhover">
					<td class="color_status textRight"><xsl:value-of select="POSICION"/></td>
					<td class="textLeft">
						<a href="javascript:FichaCentro('{IDCENTROCLIENTE}');"><xsl:value-of select="NOMBRE_CENTRO"/></a>
					</td>
					<td class="textLeft">
                    	<xsl:value-of select="REFCENTRO"/>
                    </td>
					<td class="textLeft">
                    	<xsl:value-of select="ORDENCENTRO"/>
                    </td>
					<td class="textLeft">
                    	<a href="javascript:FichaAdjudicacion('{IDPRODUCTO}','{/AnalisisTarifas/LINEASTARIFAS/COMPRADOR/IDEMPRESA}');"><xsl:value-of select="REFESTANDAR"/></a>
                    </td>
					<td class="textLeft">
                    	<a href="javascript:FichaAdjudicacion('{IDPRODUCTO}','{/AnalisisTarifas/LINEASTARIFAS/COMPRADOR/IDEMPRESA}');"><xsl:value-of select="REFCLIENTE"/></a>
                    </td>
					<td class="textLeft">
                    	<xsl:value-of select="ORDENCLIENTE"/>
                    </td>
					<td class="textLeft">
                    	<a href="javascript:FichaAdjudicacion('{IDPRODUCTO}','{/AnalisisTarifas/LINEASTARIFAS/COMPRADOR/IDEMPRESA}');"><xsl:value-of select="PRODUCTO"/></a>
                    </td>
					<td class="textLeft">
						<a href="javascript:FichaEmpresa('{IDPROVEEDOR}');"><xsl:value-of select="NIFPROVEEDOR"/></a>
					</td>
					<td class="textLeft">
						<a href="javascript:FichaEmpresa('{IDPROVEEDOR}');"><xsl:value-of select="PROVEEDOR"/></a>
					</td>
                    <!--	ref proveedor	-->
					<xsl:if test="/AnalisisTarifas/LINEASTARIFAS/COMPRADOR/MOSTRAR_REF_PROVEEDOR">
						<td class="textLeft">
                        	<a href="javascript:FichaProducto('{IDPRODUCTO}','','');"><xsl:value-of select="REFPROVEEDOR"/></a>
                    	</td>
					</xsl:if>
                    <!--	un basica-->
					<td><xsl:value-of select="UNIDADBASICA"/></td>
					<!--	marca	-->
                    <td class="textLeft"><xsl:value-of select="MARCA"/></td>
					<!--	tarifa	-->
                    <td class="textLeft"><xsl:value-of select="PRECIO"/></td>
					<!--	fecha inicio tarifa	-->
                    <td class="textLeft"><xsl:value-of select="FECHAINICIO"/></td>
					<!--	fecha final tarifa	-->
                    <td class="textLeft"><xsl:value-of select="FECHAFINAL"/></td>
                    <!--	cantidad	-->
					<td class="textRight"><xsl:value-of select="CANTIDAD"/></td>
				</tr>
			
				</xsl:for-each>  <!--fin de pedidos-->
            </tbody>
	</xsl:otherwise>
	</xsl:choose><!--fin de choose si hay pedidos-->
	<tfoot class="rodape_tabela">
        <tr>
            <td colspan="18">&nbsp;</td>
        </tr>
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
		<xsl:value-of select="/AnalisisTarifas/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>

	<table cellspacing="6px" cellpadding="6px">
		<tr>
			<td class="w50px">&nbsp;</td>
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
			<xsl:if test="FILTROS/IDCENTRO">
				<td class="textLeft w200px">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="FILTROS/IDCENTRO/field"/>
						<xsl:with-param name="claSel">w200px</xsl:with-param>
					</xsl:call-template>
				</td>
			</xsl:if>

			<td class="textLeft w300px">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label><br />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="FILTROS/IDPROVEEDOR/field"/>
					<xsl:with-param name="claSel">w300px</xsl:with-param>
				</xsl:call-template>
			</td>
			<td class="textLeft w150px">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:</label><br />
				<input type="text" class="campopesquisa w150px amarillo" name="PRODUCTO" maxlength="100" value="{PRODUCTO}"/>
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
