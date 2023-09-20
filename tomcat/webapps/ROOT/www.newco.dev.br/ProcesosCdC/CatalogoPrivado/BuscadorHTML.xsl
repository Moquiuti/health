<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Cabecera del buscador del Catalogo Privado
 	Ultima revision: ET 8oct21 17:30 Buscador_081021.js
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>

<xsl:template match="/">
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

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/ajax.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/Buscador_081021.js"></script>

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

	<!--<table class="busca" border="0">-->
	<table class="buscador">		
	<!--<tr class="subTituloTabla">-->
	<tr class="filtros sinLinea">
		<td class="cinco" style="text-align:left;">
			<!-- Condicion para mostrar el buscador avanzado -->
			<xsl:choose>
			<xsl:when test="/Buscador/BUSCADOR/BUSCADOR_AVANZADO">

				<img id="toogleBuscador" src="http://www.newco.dev.br/images/anadir.gif" style="margin:20px 0 0 2px;">
					<xsl:attribute name="src">
						<xsl:choose>
						<xsl:when test="$lang = 'spanish'">http://www.newco.dev.br/images/avanzado.gif</xsl:when>
						<xsl:otherwise>http://www.newco.dev.br/images/avanzado-BR.gif</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
        	  </img>
			</xsl:when>
			<xsl:otherwise>
							&nbsp;
			</xsl:otherwise>
			</xsl:choose>

			<!-- Condicion para mostrar el buscador licitaciones - ->
			<xsl:choose>
			<xsl:when test="/Buscador/BUSCADOR/TIENE_LICITACIONES_ADJUDICADAS">
				<br /><img id="toogleBuscadorLic" src="http://www.newco.dev.br/images/anadir.gif" style="margin:5px 0 0 2px;">
					<xsl:attribute name="src">
						<xsl:choose>
						<xsl:when test="$lang = 'spanish'">http://www.newco.dev.br/images/licitaciones.gif</xsl:when>
						<xsl:otherwise>http://www.newco.dev.br/images/licitaciones-BR.gif</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
        	   </img>
			</xsl:when>
			<xsl:otherwise>
							&nbsp;
			</xsl:otherwise>
			</xsl:choose>
			-->
			</td>

			<td style="width:140px;text-align:left;">
			<xsl:choose>
			<xsl:when test="Buscador/BUSCADOR/LISTACATEGORIAS">
				<p id="desplCategoria" style="color:000;font-size:12px;">
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
				<p id="desplFamilia" style="color:000;font-size:12px;">
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

			<td style="width:250px;text-align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:</label><br/>
				<input type="text" style="width:200px;" name="PRODUCTO" maxlength="100" size="15" id="PRODUCTO">
					<xsl:attribute name="VALUE">
						<xsl:value-of select="Buscador/BUSCADOR/PRODUCTO"/>
					</xsl:attribute>
				</input>
			</td>

			<td style="width:140px;text-align:left;">
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
			<xsl:choose>
			<xsl:when test="/Buscador/BUSCADOR/TIENE_LICITACIONES_ADJUDICADAS">
				<!-- Desplegable de licitaciones -->
				<td style="width:140px;text-align:left;">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones']/node()"/>:</label><br/>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTALICITACIONES/field"/>
						<xsl:with-param name="claSel">select140</xsl:with-param>
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
				<td style="width:140px;text-align:left;">
					<p id="desplCentros" style="color:000;font-size:12px;">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='centros']/node()"/>:&nbsp;
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTACENTROS/field"/>
							<xsl:with-param name="claSel">select140</xsl:with-param>
							<xsl:with-param name="id">IDCENTROCLIENTE</xsl:with-param>
						</xsl:call-template>
					</p>
				</td>
			</xsl:when>
			<xsl:otherwise>
					<input type="hidden" name="IDCENTROCLIENTE" id="IDCENTROCLIENTE" value=""/>
			</xsl:otherwise>
			</xsl:choose>

			<td style="width:140px;text-align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='mes_y_anyo']/node()"/>:</label><br/>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTAMESES/field"/>
				</xsl:call-template>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTAANNOS/field"/>
				</xsl:call-template>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="Buscador/BUSCADOR/TIPOFILTRO/field"/>
				</xsl:call-template>
			</td>

			<td style="width:140px;text-align:left;">
				<input type="checkbox" class="muypeq" name="SINUSAR" id="SINUSAR"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='vacio']/node()"/><br/>
				<xsl:choose>
				<xsl:when test="/Buscador/BUSCADOR/PORDEFECTO_ADJUDICADOS">
					<input type="checkbox" class="muypeq" name="ADJUDICADO" id="ADJUDICADO" checked="checked"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="checkbox" class="muypeq" name="ADJUDICADO" id="ADJUDICADO"/>
				</xsl:otherwise>
				</xsl:choose>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado']/node()"/><br/>
				<input type="checkbox" class="muypeq" name="CON_CONTRATO" id="CON_CONTRATO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Con_contrato']/node()"/>
			</td>

			<td style="width:200px;text-align:left;">
				<input type="checkbox" class="muypeq" name="SOLO_PROD_ESTANDAR" id="SOLO_PROD_ESTANDAR"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='solo_prod_estandar']/node()"/><br/>
				<input type="checkbox" class="muypeq" name="PRIMEROSPEDIDOS" id="PRIMEROSPEDIDOS"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='primeros_pedidos']/node()"/><br/>
				<input type="checkbox" class="muypeq" name="TRASPASADOS" id="TRASPASADOS"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Traspasados']/node()"/>
			</td>

			<td style="width:140px;text-align:left;">
				<p><a href="javascript:DescargarExcel();"><img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel" style="margin-top:2px;margin-bottom:6px;"/></a></p>
				<a class="btnDestacadoPeq" href="javascript:Busqueda(document.forms[0],'','');">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
				</a>
			</td>
			<td>&nbsp;</td>
		</tr>

		<xsl:choose>
		<xsl:when test="/Buscador/BUSCADOR/BUSCADOR_AVANZADO">
				<tr id="auxToogle" class="auxToogleClass filtros sinLinea" style="display:none;">
					<td>&nbsp;</td>
					<td style="width:180px;text-align:left;">
						<input type="checkbox" class="muypeq" name="CON_CONSUMO" id="CON_CONSUMO"/>&nbsp;
						<xsl:value-of select="document($doc)/translation/texts/item[@name='con_consumo_ultimo_anyo']/node()"/>:&nbsp;
						<select name="CONSUMO_MINIMO" id="CONSUMO_MINIMO" style="width:40px;font-size:11px;">
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
                    <td style="width:180px;text-align:left;">
                        <input type="checkbox" class="muypeq" name="SIN_CONSUMO" id="SIN_CONSUMO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_consumo_reciente']/node()"/>
                    </td>
					<!--
                    <td style="width:180px;text-align:left;">
                        <input type="checkbox" class="muypeq" name="SOLO_PROD_ESTANDAR" id="SOLO_PROD_ESTANDAR"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='solo_prod_estandar']/node()"/>
                    </td>
					-->
                    <td style="width:140px;text-align:left;">
                        <input type="checkbox" class="muypeq" name="INFORMAR_X_CENTRO" id="INFORMAR_X_CENTRO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='informar_por_centro']/node()"/>
                    </td>
                    <td style="width:110px;text-align:left;">
                        <input type="checkbox" class="muypeq" name="REGULADOS" id="REGULADOS"/>&nbsp;Regulados
                    </td>
                    <td style="width:110px;text-align:left;">
                        <input type="checkbox" class="muypeq" name="ORDEN1" id="ORDEN1"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='orden']/node()"/>&nbsp;1
                    </td>
                    <td style="width:110px;text-align:left;">
                        <input type="checkbox" class="muypeq" name="SIN_STOCK" id="SIN_STOCK"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_stock']/node()"/>
                    </td>
                    <td style="width:140px;text-align:left;">
                        <input type="checkbox" class="muypeq" name="PROV_BLOQUEADO" id="PROV_BLOQUEADO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Prov_bloqueado']/node()"/>
                    </td>
                    <td >
                        &nbsp;
                    </td>
				</tr>
		</xsl:when>
		<xsl:otherwise>
				<input type="hidden" name="IDCENTROCLIENTE" id="IDCENTROCLIENTE" VALUE="-1"/>
				<input type="hidden" name="CONSUMO_MINIMO" id="CONSUMO_MINIMO" VALUE="0"/>
		</xsl:otherwise>
		</xsl:choose>
		<!--
		<xsl:choose>
		<xsl:when test="/Buscador/BUSCADOR/TIENE_LICITACIONES_ADJUDICADAS">
				<tr id="auxToogleLic" class="filtros sinLinea" style="display:none;">
					<td>&nbsp;</td>
					<!- - Desplegable de licitaciones - ->
					<td colspan="2" class="labelRight">
						<p id="desplLic" style="color:000;font-size:12px;float:left;margin-left:40px;">
							<label><xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones']/node()"/></label>:&nbsp;
							<xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTALICITACIONES/field"/>
								<xsl:with-param name="claSel">select140</xsl:with-param>
								<xsl:with-param name="id">IDLICITACION</xsl:with-param>
							</xsl:call-template>
						</p>
					</td>
					<td colspan="5">&nbsp;</td>
				</tr>
		</xsl:when>
		<xsl:otherwise>
				<input type="hidden" name="IDLICITACION" id="IDLICITACION" VALUE="-1"/>
		</xsl:otherwise>
		</xsl:choose>
		-->

		<input type="hidden" name="IDINFORME" VALUE="Comisiones" id="IDINFORME"/>
	</table>
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
			<td style="width:140px;text-align:left;">
				<p id="desplCliente" style="color:000;font-size:12px;">
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
					<p id="desplCentros" style="color:000;font-size:12px;">
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

			<td style="width:160px;text-align:left;">
				<p id="desplCategoria" style="color:000;font-size:12px;display:none;">
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
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTAFAMILIAS/field"/>
						<xsl:with-param name="onChange">javascript:SeleccionaSubFamilia(this.value);</xsl:with-param>
						<xsl:with-param name="claSel">select140 catalogo</xsl:with-param>
						<xsl:with-param name="id">IDFAMILIA</xsl:with-param>
					</xsl:call-template>
				</p>
				<p id="desplSubFamilia" style="color:000;font-size:12px;display:none;">
					<label><xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/NIVEL3"/>:&nbsp;</label>
					<select name="IDSUBFAMILIA" id="IDSUBFAMILIA" class="select140 catalogo"/>
				</p>
				<p id="desplGrupo" style="color:000;font-size:12px;display:none;">
					<label><xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/NIVEL4"/>:&nbsp;</label>
					<select name="IDGRUPO" id="IDGRUPO" class="select140 catalogo"/>
				</p>
			</td>

			<td style="width:160px;text-align:left;">
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
			<td style="width:160px;text-align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label><br/>
				<select name="IDPROVEEDOR" id="IDPROVEEDOR" class="select100">
				<xsl:for-each select="Buscador/BUSCADOR/LISTAPROVEEDORES/field/dropDownList/listElem">
					<!--  seleccionamos el primer elemento   -->
					<xsl:choose>
					<xsl:when test="position()=1">
						<option>
							<xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>
							<xsl:attribute name="selected">yes</xsl:attribute>
							[<xsl:value-of select="listItem"/>]
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

			<td style="width:160px;text-align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='mes_y_anyo']/node()"/>:</label><br/>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTAMESES/field"/>
				</xsl:call-template>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTAANNOS/field"/>
				</xsl:call-template>
			</td>

			<xsl:if test="Buscador/BUSCADOR/EDICION">
				<td style="width:160px;text-align:left;">
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
				<td style="width:300px;text-align:left;">
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
				<td style="width:240px;text-align:left;">
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

            
			<td style="width:140px;text-align:left;">
				<input type="hidden" name="CON_CONTRATO" id="CON_CONTRATO" value=""/>
				<p><a class="btnNormal" href="javascript:DescargarExcel();"><img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel" style="margin-top:5px;"/></a></p><br/>
				<!--<a style="text-decoration:none;">-->
				<a class="btnDestacado" style="text-decoration:none;">
					<xsl:attribute name="href">
					<xsl:choose>
					<xsl:when test="Buscador/TYPE ='MVM'">javascript:Busqueda(document.forms[0],'CATCLIENTES','MVM');</xsl:when>
					<xsl:otherwise>javascript:Busqueda(document.forms[0],'CATCLIENTES','');</xsl:otherwise>
					</xsl:choose>
					</xsl:attribute>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
					<!--<img src="http://www.newco.dev.br/images/buttonBuscar.gif" alt="Bot�n Buscar" title="Buscar en MedicalVM" style="margin:5px 0;"/>-->
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
				<p id="desplCliente" style="color:000;font-size:12px;">
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
							[<xsl:value-of select="listItem"/>]
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
<!--
			<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='mes_y_anyo']/node()"/>:<br/>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTAMESES/field"/>
				</xsl:call-template>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTAANNOS/field"/>
				</xsl:call-template>
			</td>

			<xsl:if test="Buscador/BUSCADOR/EDICION">
				<td class="datosLeft ocho"><input type="checkbox" class="muypeq" name="SINUSAR" id="SINUSAR"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='vacio']/node()"/><br/>
					<xsl:choose>
					<xsl:when test="/Buscador/BUSCADOR/ROL = 'VENDEDOR'">
						<input type="checkbox" class="muypeq" name="ADJUDICADO" id="ADJUDICADO" style="display:none;"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="checkbox" class="muypeq" name="ADJUDICADO" id="ADJUDICADO" checked="checked"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado']/node()"/>

					</xsl:otherwise>
					</xsl:choose>
				</td>
			</xsl:if>
-->
<!--
			<xsl:choose>
			<xsl:when test="/Buscador/BUSCADOR/BUSCADOR_AVANZADO">
				<td class="datosLeft diecisiete">
					<input type="checkbox" class="muypeq" name="PRIMEROSPEDIDOS" id="PRIMEROSPEDIDOS"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='primeros_pedidos']/node()"/><br/>
					<input type="checkbox" class="muypeq" name="CON_CONSUMO" id="CON_CONSUMO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='con_consumo_ultimo_anyo']/node()"/>:&nbsp;
                                        <select name="CONSUMO_MINIMO" id="CONSUMO_MINIMO" style="width:40px;font-size:11px;">
						<option value="0">0</option>
                                                <option value="500">500</option>
                                                <option value="1000">1.000</option>
                                                <option value="3000">3.000</option>
                                                <option value="5000">5.000</option>
					</select>
                                        <br/>
					<input type="checkbox" class="muypeq" name="SIN_CONSUMO" id="SIN_CONSUMO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_consumo_reciente']/node()"/><br />
                                        <input type="checkbox" class="muypeq" name="INFORMAR_X_CENTRO" id="INFORMAR_X_CENTRO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='informar_por_centro']/node()"/><br/>
                                        <input type="checkbox" class="muypeq" name="SOLO_PROD_ESTANDAR" id="SOLO_PROD_ESTANDAR"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='solo_prod_estandar']/node()"/>
				</td>
			</xsl:when>
			<xsl:otherwise>
				<input type="hidden" name="CONSUMO_MINIMO" id="CONSUMO_MINIMO" VALUE="0"/>
				<input type="hidden" name="SIN_CONSUMO" id="SIN_CONSUMO" VALUE=""/>
				<input type="hidden" name="INFORMAR_X_CENTRO" id="INFORMAR_X_CENTRO" VALUE=""/>
        <input type="hidden" name="SOLO_PROD_ESTANDAR" id="SOLO_PROD_ESTANDAR"/>
			</xsl:otherwise>
			</xsl:choose>
-->
			<input type="hidden" name="CONSUMO_MINIMO" id="CONSUMO_MINIMO" VALUE="0"/>
			<input type="hidden" name="SIN_CONSUMO" id="SIN_CONSUMO" VALUE=""/>
			<input type="hidden" name="INFORMAR_X_CENTRO" id="INFORMAR_X_CENTRO" VALUE=""/>
			<input type="hidden" name="SOLO_PROD_ESTANDAR" id="SOLO_PROD_ESTANDAR"/>

			<td>
<!--
				<p><a href="javascript:DescargarExcel();"><img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel" style="margin-top:5px;"/></a></p>
-->
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
