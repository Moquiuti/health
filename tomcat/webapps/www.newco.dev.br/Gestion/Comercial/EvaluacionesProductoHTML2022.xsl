<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Buscador/listado de Evaluaciones de producto. Nuevo disenno 2022.
	Ultima revision ET 11may22 11:50 EvaluacionesProducto2022_110522.js
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
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/EvaluacionProductos/LANG"><xsl:value-of select="/EvaluacionProductos/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion_productos']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/EvaluacionesProducto2022_110522.js"></script>
	<script type="text/javascript">
		var errorEliminarEvaluacion	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_eliminar_evaluacion']/node()"/>';
	</script>
</head>

<body class="gris">
<xsl:choose>
<xsl:when test="/EvaluacionProductos/SESION_CADUCADA">
	<xsl:for-each select="/EvaluacionProductos/SESION_CADUCADA">
		<xsl:if test="position()=last()">
			<xsl:apply-templates select="."/>
		</xsl:if>
	</xsl:for-each>
</xsl:when>
<xsl:when test="//xsql-error">
	<xsl:apply-templates select="//xsql-error"/>
</xsl:when>
<xsl:otherwise>
	<xsl:choose>
	<xsl:when test="//SESION_CADUCADA">
		<xsl:apply-templates select="//SESION_CADUCADA"/>
	</xsl:when>
	<xsl:when test="//Sorry">
		<xsl:apply-templates select="//Sorry"/>
	</xsl:when>
	<xsl:otherwise>

    <!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/EvaluacionProductos/LANG"><xsl:value-of select="/EvaluacionProductos/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
    <!--idioma fin-->

	<xsl:variable name="usuario">
		<xsl:choose>
		<xsl:when test="EVALUACIONESPRODUCTOS/OBSERVADOR and EVALUACIONESPRODUCTOS/CDC">CDC</xsl:when>
		<xsl:otherwise>NORMAL</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion_productos']/node()"/>&nbsp;&nbsp;
			&nbsp;&nbsp;
			<span class="CompletarTitulo">
				<xsl:if test="/EvaluacionProductos/EVALUACIONESPRODUCTOS/MVM or /EvaluacionProductos/EVALUACIONESPRODUCTOS/CDC">
				<a class="btnDestacado" href="javascript:NuevaEvaluacion();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/>
				</a>
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>
	<div class="divLeft">
		<form name="Buscador" method="post" action="http://www.newco.dev.br/Gestion/Comercial/EvaluacionesProducto2022.xsql">
		<table cellspacing="6px" cellpadding="6px">
			<tr class="filtros h50px">
			<th class="w80px">
			<br />
				<a href="javascript:Reset(document.forms['Buscador']);">
    				<xsl:choose>
        				<xsl:when test="EvaluacionProductos/LANG='spanish'"><img src="http://www.newco.dev.br/images/sinFiltros.gif" alt="Sin filtros" /></xsl:when>
        				<xsl:otherwise><img src="http://www.newco.dev.br/images/sinFiltros-BR.gif" alt="Nao filtrada" /></xsl:otherwise>
    				</xsl:choose>
				</a>
			</th>
			<!-- CLIENTE-->
			<xsl:choose>
    			<xsl:when test="/EvaluacionProductos/EVALUACIONESPRODUCTOS/MVM or /EvaluacionProductos/EVALUACIONESPRODUCTOS/MVMB or /EvaluacionProductos/EVALUACIONESPRODUCTOS/ROL = 'VENDEDOR'">
					<th class="w140px textLeft">
        			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></label><br />
        			<xsl:call-template name="desplegable">
            			<xsl:with-param name="path" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FIDEMPRESA/field"/>
            			<xsl:with-param name="defecto" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FIDEMPRESA/field/@current"/>
        				<xsl:with-param name="claSel">w140px</xsl:with-param>
        			</xsl:call-template>
					</th>
    			</xsl:when>
    			<xsl:when test="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FIDEMPRESA/field/@current != '' and /EvaluacionProductos/EVALUACIONESPRODUCTOS/FIDEMPRESA/field/@current != '-1'">
        			<input type="hidden" name="FIDEMPRESA" id="FIDEMPRESA" value="{/EvaluacionProductos/EVALUACIONESPRODUCTOS/FIDEMPRESA/field/@current}"/>
    			</xsl:when>
			</xsl:choose>
			<!--CENTRO CLIENTE-->
			<th class="w140px textLeft">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></label><br />
				<xsl:call-template name="desplegable">
        			<xsl:with-param name="path" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FIDCENTRO/field"/>
        			<xsl:with-param name="defecto" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FIDCENTRO/field/@current"/>
        			<xsl:with-param name="claSel">w140px</xsl:with-param>
    			</xsl:call-template>
			</th>
			<!-- 11may22 quitamos filtro producto-->
			<th class="w140px textLeft"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></label><br />
				<xsl:call-template name="desplegable">
        			<xsl:with-param name="path" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FPRODUCTO/field"/>
        			<xsl:with-param name="defecto" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FPRODUCTO/field/@current"/>
					<xsl:with-param name="claSel">w140px</xsl:with-param>
    			</xsl:call-template>
			</th>
			<!--proveedor-->
            <th class="w140px textLeft">
				<xsl:choose>
				<xsl:when test="/EvaluacionProductos/EVALUACIONESPRODUCTOS/ROL != 'VENDEDOR'">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></label><br />
					<xsl:call-template name="desplegable">
    					<xsl:with-param name="path" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FPROVEEDOR/field"/>
    					<xsl:with-param name="defecto" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FPROVEEDOR/field/@current"/>
						<xsl:with-param name="claSel">w140px</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="FPROVEEDOR" value="-1" id="FPROVEEDOR"/>
				</xsl:otherwise>
				</xsl:choose>
			</th>
			<th class="w140px textLeft">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/></label><br />
				<input type="text" class="campopesquisa w150px" name="FTEXTO" id="FTEXTO">
					<xsl:attribute name="value"><xsl:value-of select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FTEXTO"/></xsl:attribute>
				</input>
			</th>

			<th class="w140px textLeft">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></label><br />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FESTADO/field"/>
					<xsl:with-param name="claSel">w140px</xsl:with-param>
				</xsl:call-template>
			</th>

            <th class="w140px textLeft">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='diagnostico']/node()"/></label><br />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FDIAGNOSTICO/field"/>
					<xsl:with-param name="claSel">w140px</xsl:with-param>
				</xsl:call-template>
			</th>

			<th class="w140px textLeft">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo']/node()"/></label><br />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FPLAZO/field"/>
					<xsl:with-param name="claSel">w140px</xsl:with-param>
				</xsl:call-template>
			</th>

			<th class="w140px textLeft">
				<br/>
				<a class="btnDestacado" href="javascript:BuscarEvaluacionesProductos(document.forms['Buscador']);">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
				</a>
			</th>

			<th>&nbsp;</th>
			</tr>
		</table>
		</form>

		<div id="EvalBorradaOK" style="display:none;background:#CEF6CE;padding:5px;width:400px;color:#333;text-align:center;border:1px solid #01DF01;margin:10px auto;"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_evaluacion_OK']/node()"/></div>
		<div id="EvalBorradaKO" style="display:none;background:#F8E0E6;padding:5px;width:400px;color:#333;text-align:center;border:1px solid red;margin:10px auto;"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_evaluacion_KO']/node()"/></div>

		<div class="tabela tabela_redonda">
		<table cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
			<tr>
				<th class="w1px">&nbsp;</th>
				<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_abbr']/node()"/></th>
				<th class="w50px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_cliente']/node()"/></th>
				<th class="textLeft w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
				<th class="textLeft w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='diagn']/node()"/></th>
				<th>&nbsp;</th>
			</tr>
		</thead>
		<!--	Cuerpo de la tabla	-->
		<tbody class="corpo_tabela">
        <xsl:choose>
		<xsl:when test="/EvaluacionProductos/EVALUACIONESPRODUCTOS/EVALUACION">
			<xsl:for-each select="EvaluacionProductos/EVALUACIONESPRODUCTOS/EVALUACION">
				<xsl:variable name="IncID"><xsl:value-of select="ID"/></xsl:variable>
				<tr id="EVAL_{PROD_EV_ID}" style="border-bottom:1px solid #A7A8A9;">
					<xsl:choose>
					<xsl:when test="MODIFICADO_1HORA">
						<xsl:attribute name="class">fondoNaranja</xsl:attribute>
					</xsl:when>
					<xsl:when test="MODIFICADO_24HORAS">
						<xsl:attribute name="class">fondoAmarillo</xsl:attribute>
					</xsl:when>
					</xsl:choose>

                    <td class="color_status"><xsl:value-of select="position()"/></td>
					<td>
						<a href="javascript:chEvaluacionProd('{PROD_EV_ID}');">
                    		<xsl:value-of select="PROD_EV_CODIGO"/>
                    	</a>
                    </td>
					<td><xsl:value-of select="PROD_EV_FECHA"/></td>
					<td class="textLeft">
						<a href="javascript:FichaCentro('{IDCENTROEVALUACION}');">
							<xsl:value-of select="CENTROEVALUACION"/>
                        </a>
					</td>
                   <td class="textLeft">
						<a href="javascript:FichaAdjudicacion('{PROD_EV_IDPRODUCTO}');">
							<xsl:value-of select="REFERENCIA"/>
                        </a>
					</td>
                    <td class="textLeft">
						<a href="javascript:FichaProducto('{PROD_EV_IDPRODUCTO}');">
							<xsl:value-of select="PROD_EV_REFPROVEEDOR"/>
						</a>
					</td>
					<td class="textLeft">
						<strong><a href="javascript:chEvaluacionProd('{PROD_EV_ID}');">
							<xsl:value-of select="PROD_EV_NOMBRE"/>
						</a></strong>
					</td>
					<td class="textLeft">
						<a href="javascript:FichaEmpresa('{IDPROVEEDOR}');">
							<xsl:value-of select="PROVEEDOR"/>
                        </a>
					</td>
					<td><xsl:value-of select="ESTADO"/></td>
                        <td>
                            <xsl:choose>
                                <xsl:when test="PROD_EV_DIAGNOSTICO = 'Apto'"><span class="verde"><xsl:value-of select="PROD_EV_DIAGNOSTICO" /></span></xsl:when>
                                <xsl:otherwise><span class="rojo"><xsl:value-of select="PROD_EV_DIAGNOSTICO" /></span></xsl:otherwise>
                            </xsl:choose>
                        </td>
					<td>
					<xsl:if test="/EvaluacionProductos/EVALUACIONESPRODUCTOS/CDC">
						<a href="javascript:BorrarEvaluacionProducto('{PROD_EV_ID}');"><img src="http://www.newco.dev.br/images/2022/icones/del.svg"/></a>
					</xsl:if>
					</td>
				</tr>
			</xsl:for-each>
                </xsl:when>
		<xsl:otherwise>
			<tr><td colspan="15" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='evaluaciones_sin_resultados']/node()"/></strong></td></tr>
		</xsl:otherwise>
		</xsl:choose>
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="11">&nbsp;</td></tr>
		</tfoot>
	</table>
 	</div>
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  
	</div><!--fin de divLeft-->
	</xsl:otherwise>
    </xsl:choose>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
