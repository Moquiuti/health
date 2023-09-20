<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Cabecera del buscador del Catalogo Privado
 	Ultima revision: ET 29may23 10:00 Buscador2022_030523.js
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
		<xsl:when test="/Buscador/LANG"><xsl:value-of select="/Buscador/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="TITULO" disable-output-escaping="yes"/><xsl:value-of select="$doc"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/Buscador2022_030523.js"></script>

	<script>var IDCliente		= "<xsl:value-of select="Buscador/BUSCADOR/IDEMPRESA"/>";</script>
	<script>var origen		= "<xsl:value-of select="/Buscador/ORIGEN"/>";</script>
	<script>var mostrarCategoria	= "<xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/@MostrarCategoria"/>";</script>
	<script>var mostrarGrupo	= "<xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/@MostrarGrupo"/>";</script>
	<script>var TotalRegistros	= "<xsl:value-of select="Buscador/BUSCADOR/TOTAL_REGISTROS"/>";</script>
	<script>var confirmFullSearch	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='confirmar_busqueda_listado_completo']/node()"/>";</script>
	<script>var seleccionarDespl	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='seleccionar_desplegable_o_cliente']/node()"/>";</script>
	<script>var seleccionarDesplCatPriv	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='seleccionar_desplegable_cat_priv']/node()"/>";</script>
	<script>var seleccionarConConsumoAnt	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='seleccionar_con_consumo_ant']/node()"/>";</script>
	<script>var txtTodos		= "<xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/>";</script>
	<script>var txtTodas		= "<xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/>";</script>
</head>

<body>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Buscador/LANG"><xsl:value-of select="/Buscador/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
	
	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo_privado']/node()"/></title>

	<xsl:choose>
	<!-- ET Desactivado control errores: Habra que reactivarlo
		<xsl:when test="ListaDerechosUsuarios/xsql-error">
		<xsl:apply-templates select="ListaDerechosUsuarios/xsql-error"/>
		</xsl:when>
	-->
	<xsl:when test="Buscador/SESION_CADUCADA"><xsl:apply-templates select="Buscador/SESION_CADUCADA"/></xsl:when>
	<xsl:when test="Buscador/ROWSET/ROW/Sorry"><xsl:apply-templates select="Buscador/ROWSET/ROW/Sorry"/></xsl:when>
	<xsl:otherwise>
			<div class="divLeft">
            <!--DIVERSIFICAMOS 2 BUSCADORES, UNO PARA CATALOGO CLIENTES Y UNO PARA CATALOGO PRIVADO-->
			<xsl:choose>
                <xsl:when test="/Buscador/ORIGEN = 'CATCLIENTES'"><xsl:call-template name="buscadorCatClientes"/></xsl:when>
                <xsl:when test="/Buscador/ORIGEN = 'CATCLIENTES_S'"><xsl:call-template name="buscadorCatClientesSimple"/></xsl:when>
                <xsl:otherwise><xsl:call-template name="buscadorNormal"/></xsl:otherwise>
			</xsl:choose>
			</div><!--fin de divLeft-->
	</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>

<xsl:template name="buscadorNormal">
<form name="Busqueda" method="POST" target="Resultados">
    <input type="hidden" name="VENTANA" value="{Buscador/VENTANA}"/>
    <input type="hidden" name="IDPAIS" value="{Buscador/BUSCADOR/IDPAIS}"/>
	<!--	11jul16	-->
    <input type="hidden" name="IDCLIENTE" value="{Buscador/BUSCADOR/IDEMPRESA}"/>


	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Buscador/LANG"><xsl:value-of select="/Buscador/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<table cellspacing="6px" cellpadding="6px">		
	<tr class="filtros sinLinea">
			<td class="w10px textLeft">&nbsp;</td>
			<td class="textLeft w140px">
			<xsl:choose>
			<xsl:when test="Buscador/BUSCADOR/LISTACATEGORIAS">
				<p id="desplCategoria" class="fuentePeq">
					<label><xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/NIVEL1"/>:&nbsp;</label>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTACATEGORIAS/field"/>
						<xsl:with-param name="onChange">javascript:SeleccionaFamilia(this.value);</xsl:with-param>
						<xsl:with-param name="claSel">select140 catalogo</xsl:with-param>
						<xsl:with-param name="nombre">IDCATEGORIA</xsl:with-param>
						<xsl:with-param name="id">IDCATEGORIA</xsl:with-param>
					</xsl:call-template>
				</p>
				<p id="desplFamilia" style="color:000;font-size:12px;display:none;">
					<label><xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/NIVEL2"/>:&nbsp;</label>
					<select name="IDFAMILIA" id="IDFAMILIA" class="select140 catalogo" onchange="javascript:SeleccionaSubFamilia(this.value);"/>
                </p>
			</xsl:when>
			<xsl:when test="Buscador/BUSCADOR/LISTAFAMILIAS">
				<p id="desplFamilia" class="fuentePeq">
					<label><xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/NIVEL2"/>:&nbsp;</label>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTAFAMILIAS/field"/>
						<xsl:with-param name="onChange">javascript:SeleccionaSubFamilia(this.value);</xsl:with-param>
						<xsl:with-param name="claSel">select140 catalogo</xsl:with-param>
						<xsl:with-param name="id">IDFAMILIA</xsl:with-param>
					</xsl:call-template>
				</p>
			</xsl:when>
			</xsl:choose>
				<p id="desplSubFamilia" style="color:000;font-size:12px;display:none;">
					<label><xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/NIVEL3"/>:&nbsp;</label>
					<select name="IDSUBFAMILIA" id="IDSUBFAMILIA" class="select140 catalogo">
						<xsl:if test="Buscador/BUSCADOR/LISTACATEGORIAS">
							<xsl:attribute name="onchange">javascript:SeleccionaGrupo(this.value);</xsl:attribute>
						</xsl:if>
                    </select>
				</p>

			<xsl:if test="Buscador/BUSCADOR/LISTACATEGORIAS">
				<p id="desplGrupo" style="color:000;font-size:12px;display:none;">
					<label><xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/NIVEL4"/>:&nbsp;</label>
					<select name="IDGRUPO" id="IDGRUPO" class="select140 catalogo"/>
                </p>
			</xsl:if>
			</td>

			<td style="width:220px;text-align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:</label><br/>
				<input type="text" class="campopesquisa w200px" name="PRODUCTO" maxlength="100" size="15" id="PRODUCTO">
					<xsl:attribute name="VALUE">
						<xsl:value-of select="Buscador/BUSCADOR/PRODUCTO"/>
					</xsl:attribute>
				</input>
			</td>

			<td class="textLeft w140px">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label><br/>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTAPROVEEDORES/field"/>
					<xsl:with-param name="claSel">select100</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="Buscador/BUSCADOR/GRUPODESTOCK">
					<br/>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Grupo_de_stock']/node()"/>:</label><br/>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Buscador/BUSCADOR/GRUPODESTOCK/field"/>
						<xsl:with-param name="claSel">select100</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</td>

			<td class="textLeft w140px">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='mes_y_anyo']/node()"/>:</label><br/>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTAMESES/field"/>
					<xsl:with-param name="claSel">w60px</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTAANNOS/field"/>
					<xsl:with-param name="claSel">w80px</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="Buscador/BUSCADOR/TIPOFILTRO/field"/>
					<xsl:with-param name="claSel">w140px</xsl:with-param>
				</xsl:call-template>
			</td>

			<td class="textLeft w140px">
				<input type="checkbox" class="muypeq" name="SINUSAR" id="SINUSAR"/>&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='vacio']/node()"/></label><br/>
				<xsl:choose>
				<xsl:when test="/Buscador/BUSCADOR/PORDEFECTO_ADJUDICADOS">
					<input type="checkbox" class="muypeq" name="ADJUDICADO" id="ADJUDICADO" checked="checked"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="checkbox" class="muypeq" name="ADJUDICADO" id="ADJUDICADO"/>
				</xsl:otherwise>
				</xsl:choose>&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado']/node()"/></label><br/>
				<input type="checkbox" class="muypeq" name="CON_CONTRATO" id="CON_CONTRATO"/>&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Con_contrato']/node()"/></label>
			</td>

			<td style="width:200px;text-align:left;">
				<input type="checkbox" class="muypeq" name="SOLO_PROD_ESTANDAR" id="SOLO_PROD_ESTANDAR"/>&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_prod_estandar']/node()"/></label><br/>
				<input type="checkbox" class="muypeq" name="PRIMEROSPEDIDOS" id="PRIMEROSPEDIDOS"/>&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='primeros_pedidos']/node()"/></label><br/>
				<input type="checkbox" class="muypeq" name="TRASPASADOS" id="TRASPASADOS"/>&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Traspasados']/node()"/></label>
			</td>

			<td class="textLeft w70px">
				<br/>
				<a class="btnDestacado" href="javascript:Busqueda(document.forms[0],'','');">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
				</a>
			</td>
			<xsl:choose>
			<xsl:when test="/Buscador/BUSCADOR/BUSCADOR_AVANZADO">
				<td class="textLeft w90px">
				<br/>
       			<a href="javascript:VerBuscadorAvanzado();" title="Buscador avanzado"  class="btnNormal">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='AVANZADO']/node()"/>
        		</a>
				</td>
			</xsl:when>
			<xsl:otherwise>
				<td class="textLeft w1px">&nbsp;</td>
			</xsl:otherwise>
			</xsl:choose>
			<td class="textRight w50px">
				<br/>
				&nbsp;<a class="btnNormal" href="javascript:DescargarExcel();"><xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/><!--<img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel"/>--></a>
			</td>
			<td>&nbsp;</td>
		</tr>
	</table>

	<xsl:choose>
	<xsl:when test="/Buscador/BUSCADOR/BUSCADOR_AVANZADO">
		<table id="auxToogle" cellspacing="6px" cellpadding="6px" style="display:none;">		
			<tr class="auxToogleClass filtros sinLinea">
				<td class="w10px textLeft">&nbsp;</td>
				<!-- Licitaciones y centros los pasamos del buscador principal al avanzado paraa aprovechar espacio	-->
				<xsl:choose>
				<xsl:when test="/Buscador/BUSCADOR/TIENE_LICITACIONES_ADJUDICADAS">
					<!-- Desplegable de licitaciones -->
					<td class="textLeft w140px">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones']/node()"/>:</label><br/>
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTALICITACIONES/field"/>
							<xsl:with-param name="claSel">w140px</xsl:with-param>
							<xsl:with-param name="id">IDLICITACION</xsl:with-param>
						</xsl:call-template>
					</td>
				</xsl:when>
				<xsl:otherwise>
						<input type="hidden" name="IDLICITACION" id="IDLICITACION" VALUE="-1"/>
				</xsl:otherwise>
				</xsl:choose>

				<xsl:choose>
				<xsl:when test="/Buscador/BUSCADOR/INCLUIR_CENTROS">
					<!-- 8oct21 Para usuario CDC ponemos el desplegable de centros cliente en la parte superior -->
					<td class="textLeft w140px" id="desplCentros">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centros']/node()"/>:</label><br/>
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTACENTROS/field"/>
							<xsl:with-param name="claSel">w140px</xsl:with-param>
							<xsl:with-param name="id">IDCENTROCLIENTE</xsl:with-param>
						</xsl:call-template>
					</td>
				</xsl:when>
				<xsl:otherwise>
						<input type="hidden" name="IDCENTROCLIENTE" id="IDCENTROCLIENTE" value=""/>
				</xsl:otherwise>
				</xsl:choose>

				<!--	filtros avanzados		-->
				<td class="textLeft w160px">
					<input type="checkbox" class="muypeq" name="CON_CONSUMO" id="CON_CONSUMO"/>&nbsp;
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='con_consumo_ultimo_anyo']/node()"/>:</label><br/>
					<select name="CONSUMO_MINIMO" id="CONSUMO_MINIMO" class="w160px">
					<option value="0">0</option>
    					<option value="500">500</option>
    					<option value="1000">1.000</option>
    					<option value="3000">3.000</option>
    					<option value="5000">5.000</option>
					</select>
				</td>
				<!--
				<td style="width:180px;text-align:left;">
                    <input type="checkbox" class="muypeq" name="PRIMEROSPEDIDOS" id="PRIMEROSPEDIDOS"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='primeros_pedidos']/node()"/>
                </td>
				-->
                <td class="textLeft w140px">
                    <input type="checkbox" class="muypeq" name="SIN_CONSUMO" id="SIN_CONSUMO"/>&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='sin_consumo_reciente']/node()"/></label>
                </td>
				<!--
                <td style="width:180px;text-align:left;">
                    <input type="checkbox" class="muypeq" name="SOLO_PROD_ESTANDAR" id="SOLO_PROD_ESTANDAR"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='solo_prod_estandar']/node()"/>
                </td>
				-->
                <td class="textLeft w140px">
                    <input type="checkbox" class="muypeq" name="INFORMAR_X_CENTRO" id="INFORMAR_X_CENTRO"/>&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='informar_por_centro']/node()"/></label>
                </td>
                <td class="textLeft w110px">
                    <input type="checkbox" class="muypeq" name="REGULADOS" id="REGULADOS"/>&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Regulados']/node()"/></label>
                </td>
                <td class="textLeft w110px">
                    <input type="checkbox" class="muypeq" name="ORDEN1" id="ORDEN1"/>&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='orden']/node()"/>&nbsp;1</label>
                </td>
                <td class="textLeft w110px">
                    <input type="checkbox" class="muypeq" name="SIN_STOCK" id="SIN_STOCK"/>&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='sin_stock']/node()"/></label>
                </td>
                <td class="textLeft w140px">
                    <input type="checkbox" class="muypeq" name="PROV_BLOQUEADO" id="PROV_BLOQUEADO"/>&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Prov_bloqueado']/node()"/></label>
                </td>
                <td>&nbsp;</td>
			</tr>
		</table>
	</xsl:when>
	<xsl:otherwise>
		<input type="hidden" name="IDCENTROCLIENTE" id="IDCENTROCLIENTE" VALUE="-1"/>
		<input type="hidden" name="CONSUMO_MINIMO" id="CONSUMO_MINIMO" VALUE="0"/>
	</xsl:otherwise>
	</xsl:choose>
	<input type="hidden" name="IDINFORME" VALUE="Comisiones" id="IDINFORME"/>
</form>
</xsl:template><!--fin de buscadorNormal-->

<xsl:template name="buscadorCatClientes">
<form name="Busqueda" method="POST" target="Resultados">
	<input type="hidden" name="VENTANA" value="{Buscador/VENTANA}"/>
	<input type="hidden" name="IDINFORME" VALUE="Comisiones" id="IDINFORME"/>
        <input type="hidden" name="IDPAIS" value="{Buscador/BUSCADOR/IDPAIS}"/>

	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Buscador/LANG"><xsl:value-of select="/Buscador/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!--<table class="busca" border="0">-->
	<table class="buscador">		
		<!--<tr class="subTituloTabla">-->
		<tr class="filtros">
			<!--<td class="diecisiete labelRight">-->
			<td class="textLeft w140px">
				<p id="desplCliente" class="fuentePeq">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/>:&nbsp;</label>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTACLIENTES/field"/>
						<xsl:with-param name="onChange">javascript:NivelesEmpresa(this.value);SeleccionaProveedor(this.value);</xsl:with-param>
						<xsl:with-param name="claSel">select140</xsl:with-param>
						<xsl:with-param name="id">IDCLIENTE</xsl:with-param>
					</xsl:call-template>
				</p>

				<xsl:choose>
				<xsl:when test="/Buscador/BUSCADOR/BUSCADOR_AVANZADO and /Buscador/BUSCADOR/LISTACLIENTES">
					<p id="desplCentros" class="fuentePeq">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;</label>
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTACENTROS/field"/>
							<xsl:with-param name="claSel">select140</xsl:with-param>
							<xsl:with-param name="id">IDCENTROCLIENTE</xsl:with-param>
						</xsl:call-template>
					</p>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="IDCENTROCLIENTE" value="-1"/>
				</xsl:otherwise>
				</xsl:choose>
			</td>

			<td class="textLeft w160px">
				<p id="desplCategoria" class="peq">
					<label><xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/NIVEL1"/>:&nbsp;</label>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTACATEGORIAS/field"/>
						<xsl:with-param name="onChange">javascript:SeleccionaFamilia(this.value);</xsl:with-param>
						<xsl:with-param name="claSel">select140 catalogo</xsl:with-param>
						<xsl:with-param name="nombre">IDCATEGORIA</xsl:with-param>
						<xsl:with-param name="id">IDCATEGORIA</xsl:with-param>
					</xsl:call-template>
				</p>
				<p id="desplFamilia" class="peq" style="display:none;">
					<label><xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/NIVEL2"/>:&nbsp;</label>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTAFAMILIAS/field"/>
						<xsl:with-param name="onChange">javascript:SeleccionaSubFamilia(this.value);</xsl:with-param>
						<xsl:with-param name="claSel">select140 catalogo</xsl:with-param>
						<xsl:with-param name="id">IDFAMILIA</xsl:with-param>
					</xsl:call-template>
				</p>
				<p id="desplSubFamilia" class="peq" style="display:none;">
					<label><xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/NIVEL3"/>:&nbsp;</label>
					<select name="IDSUBFAMILIA" id="IDSUBFAMILIA" class="select140 catalogo"/>
				</p>
				<p id="desplGrupo" class="peq" style="display:none;">
					<label><xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/NIVEL4"/>:&nbsp;</label>
					<select name="IDGRUPO" id="IDGRUPO" class="select140 catalogo"/>
				</p>
			</td>

			<td class="textLeft w160px">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:</label><br/>
				<input type="text" name="PRODUCTO" maxlength="100" size="11" id="PRODUCTO">
					<xsl:attribute name="VALUE"><xsl:value-of select="Buscador/BUSCADOR/PRODUCTO"/></xsl:attribute>
				</input>

                <xsl:if test="/Buscador/BUSCADOR/BUSCADOR_AVANZADO">
                    <br /><label><xsl:value-of select="document($doc)/translation/texts/item[@name='id']/node()"/>:</label>
                    <input type="text" name="IDPRODUCTO" maxlength="10" size="8" id="IDPRODUCTO">
                            <xsl:attribute name="VALUE"><xsl:value-of select="Buscador/BUSCADOR/IDPRODUCTO"/></xsl:attribute>
                    </input>
                </xsl:if>
			</td>
			<td class="textLeft w160px">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label><br/>
				<select name="IDPROVEEDOR" id="IDPROVEEDOR" class="select100">
				<xsl:for-each select="Buscador/BUSCADOR/LISTAPROVEEDORES/field/dropDownList/listElem">
					<!--  seleccionamos el primer elemento   -->
					<xsl:choose>
					<xsl:when test="position()=1">
						<option>
							<xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>
							<xsl:attribute name="selected">yes</xsl:attribute>
							<xsl:value-of select="listItem"/>
						</option>
					</xsl:when>
					<xsl:otherwise>
						<option>
							<xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>
							<xsl:value-of select="listItem"/>
						</option>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
				</select>
			</td>

			<td class="textLeft w160px">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='mes_y_anyo']/node()"/>:</label><br/>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTAMESES/field"/>
				</xsl:call-template>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTAANNOS/field"/>
				</xsl:call-template>
			</td>

			<xsl:if test="Buscador/BUSCADOR/EDICION">
				<td class="textLeft w160px">
				<input type="checkbox" class="muypeq" name="SINUSAR" id="SINUSAR"/>&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='vacio']/node()"/></label><br/>
					<xsl:choose>
					<xsl:when test="/Buscador/BUSCADOR/ROL = 'VENDEDOR'">
						<input type="checkbox" class="muypeq" name="ADJUDICADO" id="ADJUDICADO" style="display:none;"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="checkbox" class="muypeq" name="ADJUDICADO" id="ADJUDICADO" checked="checked"/>&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado']/node()"/></label>

					</xsl:otherwise>
					</xsl:choose>
				</td>
			</xsl:if>

			<xsl:choose>
			<xsl:when test="/Buscador/BUSCADOR/BUSCADOR_AVANZADO">
				<td class="textLeft w300px">
					<input type="checkbox" class="muypeq" name="PRIMEROSPEDIDOS" id="PRIMEROSPEDIDOS"/>&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='primeros_pedidos']/node()"/></label><br/>
					<input type="checkbox" class="muypeq" name="CON_CONSUMO" id="CON_CONSUMO"/>&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='con_consumo_ultimo_anyo']/node()"/>:&nbsp;</label>
					<select name="CONSUMO_MINIMO" id="CONSUMO_MINIMO" style="width:100px;font-size:11px;">
					<option value="0">0</option>
    					<option value="500">500</option>
    					<option value="1000">1.000</option>
    					<option value="3000">3.000</option>
    					<option value="5000">5.000</option>
					</select>
					<br/>
					<input type="checkbox" class="muypeq" name="SIN_CONSUMO" id="SIN_CONSUMO"/>&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='sin_consumo_reciente']/node()"/></label><br />
				</td>
				<td class="textLeft w240px">
					<input type="checkbox" class="muypeq" name="INFORMAR_X_CENTRO" id="INFORMAR_X_CENTRO"/>&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='informar_por_centro']/node()"/></label><br/>
					<input type="checkbox" class="muypeq" name="SOLO_PROD_ESTANDAR" id="SOLO_PROD_ESTANDAR"/>&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_prod_estandar']/node()"/></label><br/>
					<input type="checkbox" class="muypeq" name="CLASIF_PROVISIONAL" id="CLASIF_PROVISIONAL"/>&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='clasif_provisional']/node()"/></label>
				</td>
			</xsl:when>
			<xsl:otherwise>
				<input type="hidden" name="CONSUMO_MINIMO" id="CONSUMO_MINIMO" VALUE="0"/>
				<input type="hidden" name="SIN_CONSUMO" id="SIN_CONSUMO" VALUE=""/>
				<input type="hidden" name="INFORMAR_X_CENTRO" id="INFORMAR_X_CENTRO" VALUE=""/>
                <input type="hidden" name="SOLO_PROD_ESTANDAR" id="SOLO_PROD_ESTANDAR"/>
			</xsl:otherwise>
			</xsl:choose>
            <input type="hidden" name="TRASPASADOS" id="TRASPASADOS"/>

            
			<td class="textLeft w140px">
				<br/>
				<input type="hidden" name="CON_CONTRATO" id="CON_CONTRATO" value=""/>
				<a class="btnDestacado" style="text-decoration:none;">
					<xsl:attribute name="href">
					<xsl:choose>
					<xsl:when test="Buscador/TYPE ='MVM'">javascript:Busqueda(document.forms[0],'CATCLIENTES','MVM');</xsl:when>
					<xsl:otherwise>javascript:Busqueda(document.forms[0],'CATCLIENTES','');</xsl:otherwise>
					</xsl:choose>
					</xsl:attribute>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
				</a>
				<a class="btnNormal" href="javascript:DescargarExcel();"><img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel"/></a>
			</td>
			<td>&nbsp;</td>
			</tr>
            <xsl:if test="/Buscador/ORIGEN != 'CATCLIENTES'">
            <tr>
                <td class="buscaLeftCorto">&nbsp;</td>
                <td colspan="9">&nbsp;</td>
                <td class="buscaRightCorto">&nbsp;</td>
            </tr>
            </xsl:if>
	</table>
</form>
</xsl:template>

<xsl:template name="buscadorCatClientesSimple">
<form name="Busqueda" method="POST" target="Resultados">
	<input type="hidden" name="VENTANA" value="{Buscador/VENTANA}"/>
	<input type="hidden" name="IDINFORME" VALUE="Comisiones" id="IDINFORME"/>
  <input type="hidden" name="IDPAIS" value="{Buscador/BUSCADOR/IDPAIS}"/>

	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Buscador/LANG"><xsl:value-of select="/Buscador/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<table class="busca" border="0">
		<tr>
			<td class="diecisiete labelRight">
				<p id="desplCliente" class="fuentePeq">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/>:&nbsp;
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTACLIENTES/field"/>
						<xsl:with-param name="claSel">select140</xsl:with-param>
						<xsl:with-param name="id">IDCLIENTE</xsl:with-param>
					</xsl:call-template>
				</p>

					<input type="hidden" name="IDCENTROCLIENTE" value="-1"/>
			</td>

			<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:<br/>
				<input type="text" name="PRODUCTO" maxlength="100" size="11" id="PRODUCTO">
					<xsl:attribute name="VALUE"><xsl:value-of select="Buscador/BUSCADOR/PRODUCTO"/></xsl:attribute>
				</input>

        		<xsl:if test="/Buscador/BUSCADOR/BUSCADOR_AVANZADO">
              		<br /><xsl:value-of select="document($doc)/translation/texts/item[@name='id']/node()"/>:
              		<input type="text" name="IDPRODUCTO" maxlength="10" size="8" id="IDPRODUCTO">
                  		<xsl:attribute name="VALUE"><xsl:value-of select="Buscador/BUSCADOR/IDPRODUCTO"/></xsl:attribute>
              		</input>
        		</xsl:if>
			</td>

			<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:<br/>
				<select name="IDPROVEEDOR" id="IDPROVEEDOR" class="select100">
				<xsl:for-each select="Buscador/BUSCADOR/LISTAPROVEEDORES/field/dropDownList/listElem">
					<!--  seleccionamos el primer elemento   -->
					<xsl:choose>
					<xsl:when test="position()=1">
						<option>
							<xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>
							<xsl:attribute name="selected">yes</xsl:attribute>
							<xsl:value-of select="listItem"/>
						</option>
					</xsl:when>
					<xsl:otherwise>
						<option>
							<xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>
							<xsl:value-of select="listItem"/>
						</option>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
				</select>
			</td>
			<input type="hidden" name="CONSUMO_MINIMO" id="CONSUMO_MINIMO" VALUE="0"/>
			<input type="hidden" name="SIN_CONSUMO" id="SIN_CONSUMO" VALUE=""/>
			<input type="hidden" name="INFORMAR_X_CENTRO" id="INFORMAR_X_CENTRO" VALUE=""/>
			<input type="hidden" name="SOLO_PROD_ESTANDAR" id="SOLO_PROD_ESTANDAR"/>

			<td>
				<a style="text-decoration:none;">
					<xsl:attribute name="href">
					<xsl:choose>
					<xsl:when test="Buscador/TYPE ='MVM'">javascript:Busqueda(document.forms[0],'CATCLIENTES','MVM');</xsl:when>
					<xsl:otherwise>javascript:Busqueda(document.forms[0],'CATCLIENTES','');</xsl:otherwise>
					</xsl:choose>
					</xsl:attribute>
					<img src="http://www.newco.dev.br/images/buttonBuscar.gif" alt="Bot�n Buscar" title="Buscar en MedicalVM" style="margin:5px 0;"/>
				</a>
			</td>
			<td>&nbsp;</td>
		</tr>
        <xsl:if test="/Buscador/ORIGEN != 'CATCLIENTES'">
        <tr>
            <td class="buscaLeftCorto">&nbsp;</td>
            <td colspan="9">&nbsp;</td>
            <td class="buscaRightCorto">&nbsp;</td>
        </tr>
        </xsl:if>
	</table>
</form>
</xsl:template>
</xsl:stylesheet>
