<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Analisis ABC de pedidos
	Ultima revision 14dic21 12:30 AnalisisABCPedidos_151221.js
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

        <title><xsl:value-of select="document($doc)/translation/texts/item[@name='Analisis_pedidos_ABC']/node()"/>:&nbsp;<xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/TITULO" /></title>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/EIS/AnalisisABCPedidos_151221.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.base64.js"></script>

	<script type="text/javascript">
		var strInforme12mesesmaximo="<xsl:value-of select="document($doc)/translation/texts/item[@name='Maximo12Meses']/node()"/>";
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


	<form  method="post" name="Form1" action="AnalisisABCPedidos.xsql">

	<xsl:choose>
	<!-- Error en alguna sentencia del XSQL -->
	<xsl:when test="AnalisisPedidos/INICIO/xsql-error">
		<xsl:apply-templates select="AnalisisPedidos/INICIO/xsql-error"/>
	</xsl:when>
	<xsl:when test="AnalisisPedidos/INICIO/SESION_CADUCADA">
		<xsl:for-each select="AnalisisPedidos/INICIO/SESION_CADUCADA">
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

	<input type="hidden" name="IDPRODUCTO" value="{/AnalisisPedidos/LINEASPEDIDOS/IDPRODUCTO}"/>
	<input type="hidden" name="IDPRODESTANDAR" value="{/AnalisisPedidos/LINEASPEDIDOS/IDPRODESTANDAR}"/>
	<input type="hidden" name="IDLICITACION" value="{/AnalisisPedidos/LINEASPEDIDOS/IDLICITACION}"/>

	<xsl:for-each select="/AnalisisPedidos/LINEASPEDIDOS">
	<input type="hidden" name="ORDEN" value="{./ORDEN}"/>
	<input type="hidden" name="SENTIDO" value="{./SENTIDO}"/>
	<input type="hidden" name="IDEMPRESAUSUARIO" value="{./IDEMPRESAUSUARIO}"/>


	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eis']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Analisis_pedidos_ABC']/node()"/></span></p>
		<p class="TituloPagina">
			<!--<xsl:if test="NOMBREPRODUCTO != ''">
				<xsl:value-of select="substring(NOMBREPRODUCTO,0,50)" />:&nbsp;
			</xsl:if>-->
			<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='analisis_pedidos']/node()"/>&nbsp;-->
			<xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/TITULO" />&nbsp;
			<span class="fuentePequenna">(<xsl:value-of select="FECHAACTUAL"/>)</span>
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
                <xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/TOTAL_PRODUCTOS"/>&nbsp;
                <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas_en_total']/node()"/>&nbsp;&nbsp;&nbsp;
				<xsl:if test="//ANTERIOR">
					<a class="btnNormal" href="javascript:AplicarFiltroPagina({//ANTERIOR/@Pagina});"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
				&nbsp;
				</xsl:if>
				<a class="btnNormal" id="btnExcel" href="javascript:DescargarExcel();"><img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel"/></a>
				&nbsp;
				<a class="btnNormal" href="javascript:window.print();"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
				&nbsp;
				<span id="waitExcel" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></span>
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
                <xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/ADMIN = 'MVM' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/ADMIN = 'MVMB'">
                     <xsl:call-template name="buscador"/>
                </xsl:when>
                <xsl:otherwise><xsl:call-template name="buscador"/></xsl:otherwise>
                </xsl:choose>
				-->
				<xsl:call-template name="buscador"/>
            </td>
		</tr>

		<tr class="subTituloTabla">
			<th style="width:50px;">ABC</th>
			<th style="width:50px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Pos']/node()"/></th>
			<th class="diez" style="text-align:left;">
				&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>
			</th>
            <th class="treinta" style="text-align:left;">
				&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>
			</th>
			<th class="diez" style="text-align:left;">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>
			</th>
			<th style="width:150px;">
				&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>
			</th>
            <th style="width:150px;" align="right">
             	<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_medio']/node()"/>&nbsp;
            </th>
            <th style="width:150px;" align="right">
             	<xsl:value-of select="document($doc)/translation/texts/item[@name='cant']/node()"/>&nbsp;
            </th>
            <th style="width:150px;" align="right">
             	<xsl:value-of select="document($doc)/translation/texts/item[@name='cant']/node()"/>%&nbsp;
            </th>
            <th style="width:150px;" align="right">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>(<xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/DIVISA/PREFIJO"/><xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/DIVISA/SUFIJO"/>)
            </th>
            <th style="width:150px;" align="right">
             	<xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>%&nbsp;
            </th>
            <th style="width:70px;" align="right">
             	&nbsp;
            </th>
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
					<td><xsl:value-of select="ABC"/></td>
					<td><xsl:value-of select="POSICION"/></td>
                   <!--ref cliente o ref estandar-->
					<td class="textLeft">
                        <xsl:choose>
                            &nbsp;<xsl:when test="REFCLIENTE != ''"><xsl:value-of select="REFCLIENTE"/></xsl:when>
                            <xsl:otherwise><xsl:value-of select="REFESTANDAR"/></xsl:otherwise>
                        </xsl:choose>
                        &nbsp;
                    </td>
                    <!--producto-->
                    <td class="textLeft"><xsl:value-of select="PRODUCTO"/></td>
                    <td class="textLeft"><xsl:value-of select="MARCA"/></td>
                    <!--un basica-->
					<td><xsl:value-of select="UNIDADBASICA"/>&nbsp;</td>
                    <!--precio medio-->
					<td class="textRight"><xsl:value-of select="PRECIOMEDIO"/>&nbsp;</td>
                    <!--cantidad-->
					<td class="textRight"><xsl:value-of select="CANTIDAD"/>&nbsp;</td>
					<td class="textRight"><xsl:value-of select="CANTIDAD_PORC"/>%&nbsp;</td>
                    <!--total linea-->
					<td class="textRight">
                        <xsl:value-of select="TOTALLINEA"/>&nbsp;
                    </td>
					<td class="textRight">
                        <xsl:value-of select="TOTALLINEA_PORC"/>%&nbsp;
                    </td>
					<td class="textRight">
                        (<xsl:value-of select="PORC_ACUMULADO"/>%)&nbsp;
                    </td>
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
                    <xsl:when test="/AnalisisPedidos/LINEASPEDIDOS/MOSTRAR_PRECIOS_CON_IVA">
                        <xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/TOTAL_PEDIDOS_CONIVA"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/TOTAL_PEDIDOS"/>
                    </xsl:otherwise>
                </xsl:choose>&nbsp;
            </td>
            <td style="text-align:right;"><xsl:value-of select="TOTAL_AHORRO"/>&nbsp;</td>
            <td style="text-align:right;"><xsl:value-of select="PORC_AHORRO"/>&nbsp;</td>
        </tr>
        <tr style="height:30px; font-weight:bold;">
            <td colspan="2">&nbsp;</td>
            <td colspan="11"><xsl:value-of select="document($doc)/translation/texts/item[@name='resumen']/node()"/>. <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>:&nbsp;<xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/TOTAL_LINEAS"/>.
					&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Cant_ud_minima']/node()"/>:&nbsp;<xsl:value-of select="/AnalisisPedidos/LINEASPEDIDOS/TOTAL_UDESMINIMAS"/>.
					&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_medio']/node()"/>:
                		<xsl:choose>
                    		<xsl:when test="/AnalisisPedidos/LINEASPEDIDOS/MOSTRAR_PRECIOS_CON_IVA">
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
      	<!--th idempresa-->
      	<xsl:choose>
			<xsl:when test="FILTROS/IDEMPRESA">
        		<th width="180px" style="text-align:left;">
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
			<th width="180px" style="text-align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_consumo']/node()"/>:</label><br />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="FILTROS/IDCENTROCONSUMO/field"/>
					<xsl:with-param name="style">width:170px;</xsl:with-param>
				</xsl:call-template>
			</th>
		</xsl:if>

		<xsl:if test="FILTROS/IDCENTRO and not (FILTROS/IDCENTROCONSUMO)">
			<th width="180px" style="text-align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</label><br />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="FILTROS/IDCENTRO/field"/>
					<xsl:with-param name="style">width:170px;</xsl:with-param>
				</xsl:call-template>
			</th>
		</xsl:if>
		
		<th  width="180px" style="text-align:left;">
			<label><xsl:value-of select="NOMBRESNIVELES/NIVEL2"/>:</label><br />
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="FILTROS/LISTAFAMILIAS/field"/>
				<xsl:with-param name="style">width:170px;</xsl:with-param>
			</xsl:call-template>
		</th>
		<th  width="180px" style="text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Grupo_stock']/node()"/>:</label><br />
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="FILTROS/GRUPODESTOCK/field"/>
				<xsl:with-param name="style">width:170px;</xsl:with-param>
			</xsl:call-template>
		</th>
		<th width="160px" style="text-align:left;">
			<input class="muypeq" type="checkbox" name="ONCOLOGICO_CHECK" id="ONCOLOGICO_CHECK">
			<xsl:if test="ONCOLOGICO = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Oncologico']/node()"/></label>
		</th>
		<th  width="180px" style="text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label><br />
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="FILTROS/IDPROVEEDOR/field"/>
				<xsl:with-param name="style">width:170px;</xsl:with-param>
			</xsl:call-template>
		</th>
        <th style="width:200px;text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>/<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>:</label><br />
			<input type="text" style="width:190px;" name="PRODUCTO" size="30" maxlength="20" value="{PRODUCTO}"/>
		</th>
		<th width="140px" style="text-align:left;background:#F0F0F0;">
			<!--fecha inicio-->
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_inicio']/node()"/>:</label><br />
			<input type="text" name="FECHA_INICIO"  id="FECHA_INICIO" value="{FECHAINICIO}" size="9" style="width:120px;background:#FFFF99;border:1px solid #ccc;" />
		</th>
		<th width="140px" style="text-align:left;background:#F0F0F0;">
			<!--fecha final-->
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_final']/node()"/>:</label><br />
			<input type="text" name="FECHA_FINAL" id="FECHA_FINAL" value="{FECHAFINAL}"  size="9"  style="width:120px;background:#FFFF99;border:1px solid #ccc;" />
		</th>
		<th  width="100px" style="text-align:right;">
			<label>A:</label>
			<select name="PORCENTAJE_A" id="PORCENTAJE_A" style="width:70px"><!-- onchange="AplicarFiltro();"-->
                <option value="5">
                    <xsl:if test="PORCENTAJE_A = '5'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>5%
                </option>
                <option value="10">
                    <xsl:if test="PORCENTAJE_A = '10'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>10%
                </option>
                <option value="15">
                    <xsl:if test="PORCENTAJE_A = '15'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>15%
                </option>
                <option value="20">
                    <xsl:if test="PORCENTAJE_A = '20'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>20%
                </option>
            </select>
			<br />
			<label>B:</label>
			<select name="PORCENTAJE_B" id="PORCENTAJE_B" style="width:70px"><!-- onchange="AplicarFiltro();"-->
                <option value="75">
                    <xsl:if test="PORCENTAJE_A = '75'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>75%
                </option>
                <option value="80">
                    <xsl:if test="PORCENTAJE_A = '80'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>80%
                </option>
                <option value="85">
                    <xsl:if test="PORCENTAJE_A = '85'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>85%
                </option>
                <option value="90">
                    <xsl:if test="PORCENTAJE_A = '90'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>90%
                </option>
                <option value="95">
                    <xsl:if test="PORCENTAJE_A = '95'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>95%
                </option>
            </select>
		</th>
		<th width="110px">
			<select name="LINEA_POR_PAGINA" id="LINEA_POR_PAGINA"  style="width:100px;"><!-- onchange="AplicarFiltro();"-->
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
