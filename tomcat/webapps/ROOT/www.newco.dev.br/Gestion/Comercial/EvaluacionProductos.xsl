<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Evaluacion de producto
	Ultima revision ET 30dic16 08:51
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/">
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

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/evaluacionProductos220116.js"></script>
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
	
	<!--	Titulo de la p�gina		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion_productos']/node()"/></span></p>
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion_productos']/node()"/>&nbsp;&nbsp;
			&nbsp;&nbsp;
			<span class="CompletarTitulo">
				<xsl:if test="/EvaluacionProductos/EVALUACIONESPRODUCTOS/MVM or /EvaluacionProductos/EVALUACIONESPRODUCTOS/CDC">
				<a class="btnDestacado" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/NuevaEvaluacionProducto.xsql','Nueva evaluacion',100,100,0,0)">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/>
				</a>
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>
	<!--	Cambio CSS
		<h1 class="titlePage" style="float:left;width:60%;padding-left:20%;">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion_productos']/node()"/>
			<xsl:if test="/EvaluacionProductos/EVALUACIONESPRODUCTOS/EVALUACION">
				&nbsp;&nbsp;<a href="javascript:DescargarExcel();">
					<img alt="Descargar Excel" src="http://www.newco.dev.br/images/iconoExcel.gif" title="Descargar Excel"/>
				</a>
			</xsl:if>
		</h1>
                <h1 class="titlePage" style="float:left;width:20%;">
			<xsl:if test="/EvaluacionProductos/EVALUACIONESPRODUCTOS/MVM or /EvaluacionProductos/EVALUACIONESPRODUCTOS/CDC">
			<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/NuevaEvaluacionProducto.xsql','Nueva evaluacion',100,100,0,0)">
                            <div class="botonNara">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/>
						
                            </div></a>
                        </xsl:if>
		</h1>
	-->
	
	
	<div class="divLeft">
		<form name="Buscador" method="post" action="http://www.newco.dev.br/Gestion/Comercial/EvaluacionProductos.xsql">
		<!--<table class="buscador" border="0">-->
		<table class="buscador" border="0">
			<!--<tr class="select" height="50px">-->
			<tr class="filtros" height="50px">
			<th width="80px">
			<br />
			<a href="javascript:Reset(document.forms['Buscador']);">
    			<xsl:choose>
        			<xsl:when test="EvaluacionProductos/LANG='spanish'"><img src="http://www.newco.dev.br/images/sinFiltros.gif" alt="Sin filtros" /></xsl:when>
        			<xsl:otherwise><img src="http://www.newco.dev.br/images/sinFiltros-BR.gif" alt="Nao filtrada" /></xsl:otherwise>
    			</xsl:choose>
			</a>
			</th>
			<!--CLIENTE-->
			<xsl:choose>
    			<xsl:when test="/EvaluacionProductos/EVALUACIONESPRODUCTOS/MVM or /EvaluacionProductos/EVALUACIONESPRODUCTOS/MVMB or /EvaluacionProductos/EVALUACIONESPRODUCTOS/ROL = 'VENDEDOR'">
					<th width="140px" style="text-align:left;">
        			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></label><br />
        			<xsl:call-template name="desplegable">
            			<xsl:with-param name="path" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FIDEMPRESA/field"/>
            			<xsl:with-param name="defecto" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FIDEMPRESA/field/@current"/>
        			</xsl:call-template>
					</th>
    			</xsl:when>
    			<xsl:when test="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FIDEMPRESA/field/@current != '' and /EvaluacionProductos/EVALUACIONESPRODUCTOS/FIDEMPRESA/field/@current != '-1'">
        			<input type="hidden" name="FIDEMPRESA" id="FIDEMPRESA" value="{/EvaluacionProductos/EVALUACIONESPRODUCTOS/FIDEMPRESA/field/@current}"/>
    			</xsl:when>
			</xsl:choose>
			<!--CENTRO CLIENTE-->
			<th width="140px" style="text-align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_cliente']/node()"/></label><br />
				<xsl:call-template name="desplegable">
        			<xsl:with-param name="path" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FIDCENTRO/field"/>
        			<xsl:with-param name="defecto" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FIDCENTRO/field/@current"/>
        			<xsl:with-param name="claSel">select200</xsl:with-param>
    			</xsl:call-template>
			</th>
			<!--RESPONSABLE
			<th>
			<xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/><br />
			<xsl:call-template name="desplegable">
        			<xsl:with-param name="path" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FIDRESPONSABLE/field"/>
        			<xsl:with-param name="defecto" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FIDRESPONSABLE/field/@current"/>
    			</xsl:call-template>

			</th>-->
			<!--producto-->
			<th width="140px" style="text-align:left;"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></label><br />
				<xsl:call-template name="desplegable">
        			<xsl:with-param name="path" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FPRODUCTO/field"/>
        			<xsl:with-param name="defecto" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FPRODUCTO/field/@current"/>
    			</xsl:call-template>
			</th>
			<!--coordinador
			<th>
			<xsl:value-of select="document($doc)/translation/texts/item[@name='coordinador']/node()"/><br />
			<xsl:call-template name="desplegable">
        			<xsl:with-param name="path" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FIDAUTOR/field[@label='Coordinador']"/>
        			<xsl:with-param name="defecto" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FIDCENTRO/field[@label='Coordinador']/@current"/>
    			</xsl:call-template>
			</th>-->
				<!--proveedor-->
            <th width="140px" style="text-align:left;">
				<xsl:choose>
				<xsl:when test="/EvaluacionProductos/EVALUACIONESPRODUCTOS/ROL != 'VENDEDOR'">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></label><br />
					<xsl:call-template name="desplegable">
    					<xsl:with-param name="path" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FPROVEEDOR/field"/>
    					<xsl:with-param name="defecto" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FPROVEEDOR/field/@current"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="FPROVEEDOR" value="-1" id="FPROVEEDOR"/>
				</xsl:otherwise>
				</xsl:choose>
			</th>
                                <!--usuario muestras
				<th>
                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_muestras']/node()"/><br />
					<xsl:call-template name="desplegable">
                                            <xsl:with-param name="path" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FIDAUTOR/field[@label='Autor']"/>
                                            <xsl:with-param name="defecto" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FIDCENTRO/field[@label='Autor']/@current"/>
                                            <xsl:with-param name="nombre">FIDMUESTRAS</xsl:with-param>
                                        </xsl:call-template>

				</th>-->

			<th width="140px" style="text-align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/></label><br />
				<input type="text" name="FTEXTO" size="10" id="FTEXTO">
					<xsl:attribute name="value"><xsl:value-of select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FTEXTO"/></xsl:attribute>
				</input>
			</th>

			<th width="140px" style="text-align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></label><br />
				<xsl:call-template name="desplegable"><xsl:with-param name="path" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FESTADO/field"/></xsl:call-template>
			</th>

            <th width="140px" style="text-align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='diagnostico']/node()"/></label><br />
				<xsl:call-template name="desplegable"><xsl:with-param name="path" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FDIAGNOSTICO/field"/></xsl:call-template>
			</th>

			<th width="140px" style="text-align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo']/node()"/></label><br />
				<xsl:call-template name="desplegable"><xsl:with-param name="path" select="/EvaluacionProductos/EVALUACIONESPRODUCTOS/FPLAZO/field"/></xsl:call-template>
			</th>

			<th width="140px" style="text-align:left;">
			
				<!--<br /><div class="botonLargo">
				<strong>-->
					<a class="btnDestacadoPeq" href="javascript:BuscarEvaluacionesProductos(document.forms['Buscador']);">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
					</a>
				<!--</strong>
				</div>-->
			</th>

			<th>&nbsp;</th>
			</tr>
		</table>
		</form>

		<div id="EvalBorradaOK" style="display:none;background:#CEF6CE;padding:5px;width:400px;color:#333;text-align:center;border:1px solid #01DF01;margin:10px auto;"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_evaluacion_OK']/node()"/></div>
		<div id="EvalBorradaKO" style="display:none;background:#F8E0E6;padding:5px;width:400px;color:#333;text-align:center;border:1px solid red;margin:10px auto;"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_evaluacion_KO']/node()"/></div>

		<!--<table class="grandeInicio" border="0">-->
		<table class="buscador" border="0">
		<thead>
			<tr class="subTituloTabla">
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
				<th class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_abbr']/node()"/></th>
				<th><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
				<!--<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>-->
				<th align="left" class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_cliente']/node()"/></th>
				<!--<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='respon']/node()"/></th>-->
				<th align="left" class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
				<th align="left" class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/></th>
				<th align="left" class="trenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
				<!--<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='coordinador']/node()"/></th>-->
				<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
				<!--<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_prov']/node()"/></th>-->
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='diagn']/node()"/></th>
				<th>&nbsp;</th>
			</tr>
		</thead>
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

                                        <td><xsl:value-of select="position()"/></td>
					<td><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/EvaluacionProducto.xsql?ID_EVAL={PROD_EV_ID}','evaluacion',100,80,0,-10)">
                                            <xsl:value-of select="PROD_EV_CODIGO"/>
                                            </a>
                                        </td>
					<td><xsl:value-of select="PROD_EV_FECHA"/></td>
					<!--<td style="text-align:left;">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDCLIENTE}&amp;VENTANA=NUEVA','DetalleEmpresa',100,80,0,0)">
							<xsl:value-of select="CLIENTE"/>
						</a>&nbsp;
					</td>-->
					<td style="text-align:left;">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTROEVALUACION}','Detalle Centro',100,80,0,-20);">
							<xsl:value-of select="CENTROEVALUACION"/>
                                                </a>

					</td>
                                        <!--<td style="text-align:left;"><xsl:value-of select="AUTOR"/></td>-->
                                        <td style="text-align:left;">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducido.xsql?PRO_ID={PROD_EV_IDPRODUCTO}','Catalogo privado',100,80,0,0)">
							<xsl:value-of select="REFERENCIA"/>
                                                </a>
					</td>
                                        <td style="text-align:left;">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID={PROD_EV_IDPRODUCTO}','Detalle producto',100,80,0,0)">
							<xsl:value-of select="PROD_EV_REFPROVEEDOR"/>
						</a>
					</td>
					<td style="text-align:left;">
						<strong><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/EvaluacionProducto.xsql?ID_EVAL={PROD_EV_ID}','evaluacion',100,80,0,-10)">
							<xsl:value-of select="PROD_EV_NOMBRE"/>
						</a></strong>
					</td>
                                        <!--<td style="text-align:left;">
							<xsl:value-of select="COORDINADOR"/>
					</td>-->
					<td style="text-align:left;">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDPROVEEDOR}&amp;VENTANA=NUEVA','DetalleEmpresa',100,80,0,0)">
							<xsl:value-of select="PROVEEDOR"/>
                                                </a>
					</td>
                                        <!--<td style="text-align:left;">&nbsp;<xsl:value-of select="USUARIOMUESTRAS"/></td>-->
					<td><xsl:value-of select="ESTADO"/></td>
                                        <td>
                                            <xsl:choose>
                                                <xsl:when test="PROD_EV_DIAGNOSTICO = 'Apto'"><span class="verde"><xsl:value-of select="PROD_EV_DIAGNOSTICO" /></span></xsl:when>
                                                <xsl:otherwise><span class="rojo"><xsl:value-of select="PROD_EV_DIAGNOSTICO" /></span></xsl:otherwise>
                                            </xsl:choose>

                                        </td>
					<td>
					<xsl:if test="/EvaluacionProductos/EVALUACIONESPRODUCTOS/CDC">
						<a href="javascript:BorrarEvaluacionProducto('{PROD_EV_ID}');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>
					</xsl:if>
					</td>
				</tr>
			</xsl:for-each>
                </xsl:when>
		<xsl:otherwise>
			<tr><td colspan="15" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='evaluaciones_sin_resultados']/node()"/></strong></td></tr>
		</xsl:otherwise>
		</xsl:choose>
		</table>
                </div><!--fin de divLeft-->
	</xsl:otherwise>
        </xsl:choose>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
