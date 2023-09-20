<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Buscador y Listado de Incidencias de Productos. Nuevo disenno.  
	ultima revision: 10may22 17:01 IncidenciasProductos2022_100522.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:param name="usuario" select="@US_ID"/>

<xsl:template match="/IncidenciasProd">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="//LANG"><xsl:value-of select="//LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<META Http-Equiv="Cache-Control" Content="no-cache" />

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='incidencias']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/IncidenciasProductos2022_100522.js"></script>

	<script type="text/javascript">
	</script>
</head>
<body>
	<xsl:attribute name="onload">
    	<xsl:if test="/IncidenciasProd/PROVEEDOR != ''">javascript:BuscarIncidenciasProductos(document.forms['Buscador']);</xsl:if>
    </xsl:attribute>
<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="//LANG"><xsl:value-of select="//LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->
<xsl:choose>
	<xsl:when test="//SESION_CADUCADA">
		<xsl:apply-templates select="//SESION_CADUCADA"/>
	</xsl:when>
	<xsl:when test="//Sorry">
		<xsl:apply-templates select="//Sorry"/>
	</xsl:when>
	<xsl:otherwise>

		<xsl:variable name="usuario">
		<xsl:choose>
			<xsl:when test="not(INCIDENCIASPRODUCTOS/OBSERVADOR) and INCIDENCIASPRODUCTOS/CDC">CDC</xsl:when>
			<xsl:otherwise>NORMAL</xsl:otherwise>
		</xsl:choose>
		</xsl:variable>
	
		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='incidencias']/node()"/>&nbsp;&nbsp;
				&nbsp;&nbsp;
				<span class="CompletarTitulo">
					<xsl:if test="INCIDENCIASPRODUCTOS/INCIDENCIA">
						&nbsp;&nbsp;<a class="btnNormal" href="javascript:DescargarExcel();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/>
						</a>
					</xsl:if>
				</span>
			</p>
		</div>
		<br/>
		<br/>
		<br/>

		<form name="Buscador" method="post" action="IncidenciasProductos2022.xsql">
		<table cellspacing="6px" cellpadding="6px">
			<tr class="h40px">
				<th class="w80px">
                    <br />
                    <a href="javascript:Reset(document.forms['Buscador']);">
                        <xsl:choose>
                            <xsl:when test="/IncidenciasProd/LANG='spanish'"><img src="http://www.newco.dev.br/images/sinFiltros.gif" alt="Sin filtros" /></xsl:when>
                            <xsl:otherwise><img src="http://www.newco.dev.br/images/sinFiltros-BR.gif" alt="Nao filtrada" /></xsl:otherwise>
                        </xsl:choose>
                    </a>
                </th>
				<xsl:choose>
				<xsl:when test="INCIDENCIASPRODUCTOS/MVM or INCIDENCIASPRODUCTOS/MVMB or INCIDENCIASPRODUCTOS/ROL = 'VENDEDOR'">
					<th class="w140px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="INCIDENCIASPRODUCTOS/FIDEMPRESA/field"/>
						<xsl:with-param name="claSel">w140px</xsl:with-param>
					</xsl:call-template>
					</th>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="FIDEMPRESA" value="-1" id="FIDEMPRESA"/>
				</xsl:otherwise>
				</xsl:choose>

				<th class="w140px textLeft">
				<xsl:choose>
				<xsl:when test="INCIDENCIASPRODUCTOS/ROL = 'COMPRADOR' and INCIDENCIASPRODUCTOS/CDC">
					<input type="hidden" name="FIDRESPONSABLE" value="-1" id="FIDRESPONSABLE"/>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="INCIDENCIASPRODUCTOS/FIDCENTRO/field"/>
						<xsl:with-param name="claSel">w140px</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="INCIDENCIASPRODUCTOS/ROL != 'VENDEDOR'">
					<input type="hidden" name="FIDCENTRO" value="-1" id="FIDCENTRO"/>
					<input type="hidden" name="FIDRESPONSABLE" value="-1" id="FIDRESPONSABLE"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="FIDRESPONSABLE" value="-1" id="FIDRESPONSABLE"/>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="INCIDENCIASPRODUCTOS/FIDCENTRO/field"/>
						<xsl:with-param name="claSel">w140px</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
				</xsl:choose>
				</th>
                <th class="w140px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="INCIDENCIASPRODUCTOS/FPRODUCTO/field"/>
						<xsl:with-param name="claSel">w140px</xsl:with-param>
					</xsl:call-template>
				</th>
				<th class="w140px textLeft">
				<xsl:choose>
				<xsl:when test="INCIDENCIASPRODUCTOS/ROL != 'VENDEDOR'">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></label><br />
					<xsl:call-template name="desplegable">
                    	<xsl:with-param name="path" select="INCIDENCIASPRODUCTOS/FPROVEEDOR/field"/>
                        <xsl:with-param name="defecto" select="/IncidenciasProd/PROVEEDOR"/>
						<xsl:with-param name="claSel">w140px</xsl:with-param>
                    </xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="FPROVEEDOR" value="-1" id="FPROVEEDOR"/>
				</xsl:otherwise>
				</xsl:choose>
				</th>

				<th class="w200px textLeft"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/></label><br />
					<input type="text" class="campopesquisa w200px" name="FTEXTO" id="FTEXTO">
						<xsl:attribute name="value"><xsl:value-of select="INCIDENCIASPRODUCTOS/FTEXTO"/></xsl:attribute>
					</input>
				</th>

				<th class="w140px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="INCIDENCIASPRODUCTOS/FESTADO/field"/>
						<xsl:with-param name="claSel">w140px</xsl:with-param>
					</xsl:call-template>
				</th>

				<th class="w140px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo']/node()"/></label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="INCIDENCIASPRODUCTOS/FPLAZO/field"/>
						<xsl:with-param name="claSel">w140px</xsl:with-param>
					</xsl:call-template>
				</th>

				<th class="w140px textLeft">
					<br/>
					<a class="btnDestacado"  href="javascript:BuscarIncidenciasProductos(document.forms['Buscador']);">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
					</a>
				</th>
				<th>&nbsp;</th>
			</tr>
		</table>
		</form>

		<div id="IncBorradaOK" style="display:none;background:#CEF6CE;padding:5px;width:400px;color:#01DF01;text-align:center;border:1px solid #01DF01;margin:10px auto;"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_incidencia_OK']/node()"/></div>
		<div id="IncBorradaKO" style="display:none;background:#F8E0E6;padding:5px;width:400px;color:red;text-align:center;border:1px solid red;margin:10px auto;"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_incidencia_KO']/node()"/></div>

		<div class="tabela tabela_redonda">
		<table cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
			<tr>
				<th class="w1px"></th>
				<th class="w40px"><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_abbr']/node()"/></th>
				<th class="w60px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
                <th class="w60px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ultimo_cambio']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_cliente']/node()"/></th>
				<th class="w100px textLeft"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ref_cliente_2line']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
				<th class="w100px textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
                <th><xsl:copy-of select="document($doc)/translation/texts/item[@name='seguir_utilizando_2line']/node()"/></th>
				<th>&nbsp;</th>
			</tr>
		</thead>
		<!--	Cuerpo de la tabla	-->
		<tbody class="corpo_tabela">
        <xsl:choose>
		<xsl:when test="INCIDENCIASPRODUCTOS/INCIDENCIA">
			<xsl:for-each select="INCIDENCIASPRODUCTOS/INCIDENCIA">
				<xsl:variable name="IncID"><xsl:value-of select="ID"/></xsl:variable>
				<tr id="INC_{PROD_INC_ID}" style="border-bottom:1px solid #A7A8A9;">
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
                        <a href="javascript:chIncidencia('{PROD_INC_ID}','{PROD_INC_IDPRODUCTO}','{PROD_INC_IDOFERTA_LIC}')">
                            <xsl:value-of select="PROD_INC_CODIGO"/>
                        </a>
                    </td>
					<td><xsl:value-of select="PROD_INC_FECHA"/></td>
                    <td><xsl:value-of select="FECHA_ULTIMO_CAMBIO"/></td>
					<td class="textLeft">
						<a href="javascript:FichaCentro('{IDCENTROCLIENTE}'">
							<xsl:value-of select="CENTROCLIENTE"/>
                                                </a>
					</td>
					<td class="textLeft">
                        <a href="javascript:chIncidencia('{PROD_INC_ID}','{PROD_INC_IDPRODUCTO}','{PROD_INC_IDOFERTA_LIC}')">
							<xsl:value-of select="REFERENCIA"/>
						</a>
					</td>
					<td class="textLeft">
						<strong>
                        <a href="javascript:chIncidencia('{PROD_INC_ID}','{PROD_INC_IDPRODUCTO}','{PROD_INC_IDOFERTA_LIC}')">
							<xsl:value-of select="PROD_INC_DESCESTANDAR"/>
                        </a>
                        </strong>
					</td>
					<td class="textLeft">
						<a href="javascript:FichaEmpresa('{IDPROVEEDOR}');">
							<xsl:value-of select="PROVEEDOR"/>
                        </a>
					</td>
					<td class="textLeft"><xsl:value-of select="ESTADO"/></td>
                        <!--seguir utilizando-->
                        <xsl:variable name="seguirUtilizando">
                            <xsl:choose>
                                <xsl:when test="PROD_INC_SEGUIRUTILIZANDO_CDC != ''"><xsl:value-of select="PROD_INC_SEGUIRUTILIZANDO_CDC" /></xsl:when>
                                <xsl:otherwise><xsl:value-of select="PROD_INC_SEGUIRUTILIZANDO" /></xsl:otherwise>
                            </xsl:choose>
                            </xsl:variable>
                        <td>
                            <xsl:attribute name="style">
                                <xsl:choose>
                                    <xsl:when test="$seguirUtilizando = 'S'"></xsl:when>
                                    <xsl:otherwise>background:#FE4162;</xsl:otherwise>
                                </xsl:choose>
                            </xsl:attribute>

                            <xsl:choose>
                                <xsl:when test="$seguirUtilizando = 'S'"><span class="verde"><xsl:value-of select="document($doc)/translation/texts/item[@name='si']/node()"/></span></xsl:when>
                                <xsl:otherwise><span style="font-weight:bold;"><xsl:value-of select="document($doc)/translation/texts/item[@name='no']/node()"/></span></xsl:otherwise>
                            </xsl:choose>
                        </td>
					<td>
					<xsl:if test="$usuario = 'CDC'">
						<a href="javascript:BorrarIncidenciaProducto('{PROD_INC_ID}');"><img src="http://www.newco.dev.br/images/2022/icones/del.svg"/></a>
					</xsl:if>
					</td>
				</tr>
			</xsl:for-each>
        </xsl:when>
		<xsl:otherwise>
			<tr><td colspan="11" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='incidencias_sin_resultados']/node()"/></strong></td></tr>
		</xsl:otherwise>
		</xsl:choose>
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="11">&nbsp;</td></tr>
		</tfoot>
	</table><!--fin de infoTableAma-->
 	</div>
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  
	</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
