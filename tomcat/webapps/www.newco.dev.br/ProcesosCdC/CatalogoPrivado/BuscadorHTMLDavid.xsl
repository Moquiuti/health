<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 |	Estadisticas de acceso de los usuarios en MedicalVM
 |
 |	(c) 12/1/2001 ET
 |
+-->
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

	<title><xsl:value-of select="TITULO" disable-output-escaping="yes"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/ajax.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/Buscador190314.js"></script>

	<script>var IDCliente		= "<xsl:value-of select="Buscador/BUSCADOR/IDEMPRESA"/>";</script>
	<script>var mostrarCategoria	= "<xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/@MostrarCategoria"/>";</script>
	<script>var mostrarGrupo	= "<xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/@MostrarGrupo"/>";</script>
	<script>var TotalRegistros	= "<xsl:value-of select="Buscador/BUSCADOR/TOTAL_REGISTROS"/>";</script>
	<script>var confirmFullSearch	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='confirmar_busqueda_listado_completo']/node()"/>";</script>
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
			<xsl:attribute name="action">
				<xsl:choose>
				<xsl:when test="Buscador/BUSCADOR/MODO='D'">./Buscador.xsql</xsl:when>
				<xsl:when test="Buscador/BUSCADOR/MODO='P'">./FamiliasYPrecios.xsql</xsl:when>
				<xsl:when test="Buscador/BUSCADOR/MODO='PP'">./ProveedoresPorProducto.xsql</xsl:when>
				<xsl:otherwise>./ModeloPedidos.xsql</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<input type="hidden" name="VENTANA" value="{Buscador/VENTANA}"/>
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
			<td class="buscaLeft">&nbsp;</td>

			<td>
			<xsl:choose>
			<xsl:when test="Buscador/BUSCADOR/LISTACATEGORIAS">
				<p id="desplCategoria" style="float:none;margin-bottom:5px;">
					<label style="float:left;width:100px;text-align:right;color:#000;"><xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/NIVEL1"/>:</label>&nbsp;
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTACATEGORIAS/field"/>
						<xsl:with-param name="onChange">javascript:SeleccionaFamilia(this.value);</xsl:with-param>
						<xsl:with-param name="claSel">select140 catalogo</xsl:with-param>
						<xsl:with-param name="id">IDCATEGORIA</xsl:with-param>
					</xsl:call-template>
				</p>
				<p id="desplFamilia" style="float:none;display:none;margin-bottom:5px;">
					<label style="float:left;width:100px;text-align:right;color:#000;"><xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/NIVEL2"/>:</label>&nbsp;
					<select name="IDFAMILIA" id="IDFAMILIA" class="select140 catalogo" onChange="javascript:SeleccionaSubFamilia(this.value);"/>
                                </p>
			</xsl:when>
			<xsl:when test="Buscador/BUSCADOR/LISTAFAMILIAS">
				<p id="desplFamilia" style="float:none;margin-bottom:5px;">
					<label style="float:left;width:100px;text-align:right;color:#000;"><xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/NIVEL2"/>:</label>&nbsp;
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTAFAMILIAS/field"/>
						<xsl:with-param name="onChange">javascript:SeleccionaSubFamilia(this.value);</xsl:with-param>
						<xsl:with-param name="claSel">select140 catalogo</xsl:with-param>
						<xsl:with-param name="id">IDFAMILIA</xsl:with-param>
					</xsl:call-template>
				</p>
			</xsl:when>
			</xsl:choose>
				<p id="desplSubFamilia" style="float:none;display:none;">
					<label style="float:left;width:100px;text-align:right;color:#000;"><xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/NIVEL3"/>:</label>&nbsp;
					<select name="IDSUBFAMILIA" id="IDSUBFAMILIA" class="select140 catalogo"/>
				</p>
			</td>
<!--
			<xsl:choose>
			<xsl:when test="Buscador/BUSCADOR/LISTACATEGORIAS">
				<td class="doce"><span id="labelCategoria">
					<xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/NIVEL1"/>:</span><br/>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTACATEGORIAS/field"/>
						<xsl:with-param name="onChange">javascript:SeleccionaDesplFamilia(this.value);</xsl:with-param>
						<xsl:with-param name="claSel">select140</xsl:with-param>
						<xsl:with-param name="id">IDCATEGORIA</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="doce"><span id="labelFamilia" style="display:none;">
					<xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/NIVEL2"/>:</span><br/>
					<select name="IDFAMILIA" id="IDFAMILIA" class="select140" style="display:none;" onchange="SeleccionaSubFamilia(this.value);"/>
				</td>
			</xsl:when>
			<xsl:otherwise>
				<td class="doce"><span id="labelFamilia">
					<xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/NIVEL2"/>:</span><br/>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTAFAMILIAS/field"/>
						<xsl:with-param name="onChange">javascript:SeleccionaSubFamilia(this.value);</xsl:with-param>
						<xsl:with-param name="claSel">select140</xsl:with-param>
                        <xsl:with-param name="id">IDFAMILIA</xsl:with-param>
					</xsl:call-template>
				</td>
			</xsl:otherwise>
			</xsl:choose>

			<td class="doce"><span id="labelSubFamilia" style="display:none;">
				<xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/NIVEL3"/>:</span><br/>
				<select name="IDSUBFAMILIA" id="IDSUBFAMILIA" class="select140" style="display:none;"/>
			</td>
-->
			<td class="quince"> <xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:<br/>
				<input type="text" name="PRODUCTO" maxlength="100" size="15" id="PRODUCTO">
					<xsl:attribute name="VALUE">
						<xsl:value-of select="Buscador/BUSCADOR/PRODUCTO"/>
					</xsl:attribute>
				</input>
			</td>

			<td class="doce"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:<br/>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTAPROVEEDORES/field"/>
					<xsl:with-param name="claSel">select100</xsl:with-param>
				</xsl:call-template>
			</td>

			<td class="doce"><xsl:value-of select="document($doc)/translation/texts/item[@name='mes_y_anyo']/node()"/>:<br/>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTAMESES/field"/>
				</xsl:call-template>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTAANNOS/field"/>
				</xsl:call-template>
			</td>

			<td class="datosLeft">
				<input type="checkbox" name="SINUSAR" id="SINUSAR"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='vacio']/node()"/><br/>
				<input type="checkbox" name="ADJUDICADO" id="ADJUDICADO" checked="checked"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado']/node()"/>
			</td>

			<td class="datosLeft">
				<input type="checkbox" name="PRIMEROSPEDIDOS" id="PRIMEROSPEDIDOS"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='primeros_pedidos']/node()"/><br/>
				<input type="checkbox" name="CON_CONSUMO" id="CON_CONSUMO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='con_consumo_ultimo_anyo']/node()"/><br/>
				<input type="checkbox" name="SIN_CONSUMO" id="SIN_CONSUMO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_consumo_reciente']/node()"/><br/>
			</td>
<!--
			<xsl:if test="Buscador/BUSCADOR/EDICION">
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='vacio']/node()"/><br/>
					<input type="checkbox" name="SINUSAR" id="SINUSAR"/>
				</td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado']/node()"/><br/>
					<input type="checkbox" name="ADJUDICADO" id="ADJUDICADO" checked="checked"/>
				</td>
			</xsl:if>
-->
			<td>
				<p><a href="javascript:DescargarExcel();"><img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel" style="margin-top:5px;"/></a></p>
				<a href="javascript:Busqueda(document.forms[0],'','');" style="text-decoration:none;">
					<img src="http://www.newco.dev.br/images/buttonBuscar.gif" alt="Botón Buscar" title="Buscar en MedicalVM" style="margin:5px 0;"/>
				</a>
<!--
				<a href="javascript:Busqueda(document.forms[0],'','');" style="text-decoration:none;">
					<img src="http://www.newco.dev.br/images/buttonBuscar.gif" alt="Boton Buscar" title="Buscar en MedicalVM"/>
				</a>&nbsp;
				<a href="javascript:DescargarExcel();"><img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel" /></a>
-->
			</td>
			<td class="buscaRight">&nbsp;</td>
		</tr>
		<!-- Si reactivamos los checks de ver "con precio" o "sin precio" deberemos quitar las dos siguientes lineas -->
		<input type="hidden" name="IDCENTRO" value="-1" id="IDCENTRO"/>
		<input type="hidden" name="CONPRECIO" value="on" id="CONPRECIO"/>
		<input type="hidden" name="SINPRECIO" value="on" id="SINPRECIO"/>
		<input type="hidden" name="IDINFORME" VALUE="Comisiones" id="IDINFORME"/>
	</table>
</form>
</xsl:template><!--fin de buscadorNormal-->

<xsl:template name="buscadorCatClientes">
<form name="Busqueda" method="POST" target="Resultados">
	<xsl:attribute name="action">
		<xsl:choose>
		<xsl:when test="Buscador/BUSCADOR/MODO='D'">./Buscador.xsql?ORIGEN=CATCLIENTES</xsl:when>
		<xsl:when test="Buscador/BUSCADOR/MODO='P'">./FamiliasYPrecios.xsql?ORIGEN=CATCLIENTES</xsl:when>
		<xsl:when test="Buscador/BUSCADOR/MODO='PP'">./ProveedoresPorProducto.xsql?ORIGEN=CATCLIENTES</xsl:when>
		<xsl:otherwise>./ModeloPedidos.xsql?ORIGEN=CATCLIENTES</xsl:otherwise>
		</xsl:choose>
	</xsl:attribute>

	<input type="hidden" name="VENTANA" value="{Buscador/VENTANA}"/>
	<input type="hidden" name="IDINFORME" VALUE="Comisiones" id="IDINFORME"/>

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

		<xsl:choose>
		<xsl:when test="Buscador/TYPE = 'MVM'">
			<td class="buscaLeft">&nbsp;</td>
			<td class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='id_producto']/node()"/>:<br/>
				<input type="text" name="IDPRODUCTO" maxlength="10" size="8" id="IDPRODUCTO">
					<xsl:attribute name="VALUE"><xsl:value-of select="Buscador/BUSCADOR/IDPRODUCTO"/></xsl:attribute>
				</input>
                        </td>
		</xsl:when>
		<xsl:otherwise>
			<td class="buscaLeft" colspan="2">&nbsp;</td>
		</xsl:otherwise>
		</xsl:choose>

			<td class="catorce">
				<p id="desplCliente" style="float:none;margin-bottom:5px;">
					<label style="float:left;width:60px;text-align:right;color:#000;"><xsl:value-of select="document($doc)/translation/texts/item[@name='clientes']/node()"/>:</label>&nbsp;
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTACLIENTES/field"/>
						<xsl:with-param name="onChange">javascript:NivelesEmpresa(this.value);SeleccionaProveedor(this.value);</xsl:with-param>
						<xsl:with-param name="claSel">select100 catalogo</xsl:with-param>
						<xsl:with-param name="id">IDCLIENTE</xsl:with-param>
					</xsl:call-template>
                                </p>
				<xsl:choose>
				<xsl:when test="Buscador/TYPE = 'MVM'">
					<p id="desplCentros" style="float:none">					
						<label style="float:left;width:60px;text-align:right;color:#000;"><xsl:value-of select="document($doc)/translation/texts/item[@name='centros']/node()"/>:</label>&nbsp;
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTACENTROS/field"/>
							<xsl:with-param name="claSel">select100 catalogo</xsl:with-param>
							<xsl:with-param name="id">IDCENTROCLIENTE</xsl:with-param>
						</xsl:call-template>
                                        </p>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="IDCENTROCLIENTE" value="-1"/>
				</xsl:otherwise>
				</xsl:choose>

			</td>
<!--
			<td class="doce" id="labelCategoria" style="display:none;"><xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/NIVEL1"/>:<br/>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTACATEGORIAS/field"/>
					<xsl:with-param name="onChange">javascript:SeleccionaFamilia(this.value);</xsl:with-param>
					<xsl:with-param name="claSel">select140</xsl:with-param>
					<xsl:with-param name="id">IDCATEGORIA</xsl:with-param>
				</xsl:call-template>
			</td>
-->
			<td>
				<p id="desplCategoria" style="float:none;display:none;margin-bottom:5px;">
					<label style="float:left;width:100px;text-align:right;color:#000;"><xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/NIVEL1"/>:</label>&nbsp;
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTACATEGORIAS/field"/>
						<xsl:with-param name="onChange">javascript:SeleccionaFamilia(this.value);</xsl:with-param>
						<xsl:with-param name="claSel">select140 catalogo</xsl:with-param>
						<xsl:with-param name="id">IDCATEGORIA</xsl:with-param>
					</xsl:call-template>
                                </p>
				<p id="desplFamilia" style="float:none;display:none;margin-bottom:5px;">
					<label style="float:left;width:100px;text-align:right;color:#000;"><xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/NIVEL2"/>:</label>&nbsp;
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTAFAMILIAS/field"/>
						<xsl:with-param name="onChange">javascript:SeleccionaSubFamilia(this.value);</xsl:with-param>
						<xsl:with-param name="claSel">select140 catalogo</xsl:with-param>
						<xsl:with-param name="id">IDFAMILIA</xsl:with-param>
					</xsl:call-template>
                                </p>
				<p id="desplSubFamilia" style="float:none;display:none;">
					<label style="float:left;width:100px;text-align:right;color:#000;"><xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/NIVEL3"/>:</label>&nbsp;
					<select name="IDSUBFAMILIA" id="IDSUBFAMILIA" class="select140 catalogo"/>
				</p>
<!--
                            <xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/NIVEL2"/>:<br/>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTAFAMILIAS/field"/>
					<xsl:with-param name="onChange">javascript:SeleccionaSubFamilia(this.value);</xsl:with-param>
					<xsl:with-param name="claSel">select140</xsl:with-param>
					<xsl:with-param name="id">IDFAMILIA</xsl:with-param>
				</xsl:call-template>
-->
			</td>
<!--
			<td class="doce" id="labelSubFamilia" style="display:none;">
				<xsl:value-of select="Buscador/BUSCADOR/NOMBRESNIVELES/NIVEL3"/>:<br/>
				<select name="IDSUBFAMILIA" id="IDSUBFAMILIA" class="select140" style="display:none;"/>
			</td>
-->
			<td class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:<br/>
				<input type="text" name="PRODUCTO" maxlength="100" size="11" id="PRODUCTO">
					<xsl:attribute name="VALUE"><xsl:value-of select="Buscador/BUSCADOR/PRODUCTO"/></xsl:attribute>
				</input>
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

			<td class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='mes_y_anyo']/node()"/>:<br/>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTAMESES/field"/>
				</xsl:call-template>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="Buscador/BUSCADOR/LISTAANNOS/field"/>
				</xsl:call-template>
			</td>

			<xsl:if test="Buscador/BUSCADOR/EDICION">
				<td class="datosLeft ocho"><input type="checkbox" name="SINUSAR" id="SINUSAR"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='vacio']/node()"/><br/>
					<xsl:choose>
					<xsl:when test="/Buscador/BUSCADOR/ROL = 'VENDEDOR'">
						<input type="checkbox" name="ADJUDICADO" id="ADJUDICADO" style="display:none;"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="checkbox" name="ADJUDICADO" id="ADJUDICADO" checked="checked"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado']/node()"/>
						
					</xsl:otherwise>
					</xsl:choose>
				</td>
			</xsl:if>

			<xsl:if test="Buscador/TYPE = 'MVM'">
				<td class="datosLeft catorce">
					<input type="checkbox" name="PRIMEROSPEDIDOS" id="PRIMEROSPEDIDOS"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='primeros_pedidos']/node()"/><br/>
					<input type="checkbox" name="CON_CONSUMO" id="CON_CONSUMO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='con_consumo_ultimo_anyo']/node()"/><br/>
					<input type="checkbox" name="SIN_CONSUMO" id="SIN_CONSUMO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_consumo_reciente']/node()"/><br/>
				</td>
			</xsl:if>

			<td>
				<p><a href="javascript:DescargarExcel();"><img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel" style="margin-top:5px;"/></a></p>
				<a style="text-decoration:none;">
					<xsl:attribute name="href">
					<xsl:choose>
					<xsl:when test="Buscador/TYPE ='MVM'">javascript:Busqueda(document.forms[0],'CATCLIENTES','MVM');</xsl:when>
					<xsl:otherwise>javascript:Busqueda(document.forms[0],'CATCLIENTES','');</xsl:otherwise>
					</xsl:choose>
					</xsl:attribute>
					<img src="http://www.newco.dev.br/images/buttonBuscar.gif" alt="Botón Buscar" title="Buscar en MedicalVM" style="margin:5px 0;"/>
				</a>
			</td>
			<td class="buscaRight">&nbsp;</td>
		</tr>
	</table>
</form>
</xsl:template>
</xsl:stylesheet>