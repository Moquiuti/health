<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	EIS: Analisis Anual
	Ultima revisión: ET 2jun22 11:30 EISAnual2022_310522.js
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
		<xsl:value-of select="/EIS_ANUAL_XML/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_anual']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<meta Http-Equiv="Cache-Control" Content="no-cache"/>

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/Chart.bundle.min.2.9.3.js"></script>
	<script type="text/javascript">
		var AnyoInicio		= <xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/ANYO_INICIO"/>;
		var AnyoInicio_sel	= AnyoInicio;
		var AnyoFinal		= <xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/ANYO_FINAL"/>;
		var AnyoFinal_sel	= AnyoFinal;
		var NumColumnas		= AnyoFinal - AnyoInicio + 1;
		var NombreIndicador	= '<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/INDICADOR"/>';
		var IDIndicador		= '<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/IDINDICADOR"/>';
		var IDCuadro		= '<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/IDCUADRO"/>';

		var ResultadosTabla	= {};
		<xsl:for-each select="/EIS_ANUAL_XML/EIS_ANUAL/FILA">
			<xsl:if test="ID != 'TOTAL'">
			ResultadosTabla['FILA|<xsl:value-of select="ID"/>'] = '<xsl:value-of select="NOMBRE"/>';

			<xsl:for-each select="COLUMNA">
				ResultadosTabla['COLUMNA|<xsl:value-of select="ID"/>|<xsl:value-of select="POS"/>'] = '<xsl:value-of select="TOTAL"/>';
			</xsl:for-each>
			</xsl:if>
		</xsl:for-each>
	</script>

	<script type="text/javascript">
		var txtConcepto		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='concepto']/node()"/>';
		var FiltroSQL		= "<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/SQL"/>";
		var IDEmpresaDelUsuario	= '<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/IDEMPRESADELUSUARIO"/>';
		var userRol		= '<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/ROL"/>';
		var userDerechos;
		<xsl:choose>
                <xsl:when test="/EIS_ANUAL_XML/EIS_ANUAL/MVM">
			userDerechos	= 'S';
		</xsl:when>
                <xsl:otherwise>
			userDerechos	= 'N';
		</xsl:otherwise>
		</xsl:choose>
		<!-- FIN Resultados de la consulta -->

		<!-- Texto botones -->
		var txtResultados	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='resultados']/node()"/>';
		var txtTodos		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/>';
		var txtVolver		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/>';
		var txtSinResultados	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='la_consulta_no_ha_devuelto_datos']/node()"/>';
		<!-- FIN texto botones -->

		var txtValNombreSel	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_obli_seleccion']/node()"/>';
		var txtSelGuardarOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='seleccion_ok']/node()"/>';
		var txtSelGuardarNO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='seleccion_no']/node()"/>';
		var txtSelBorrarOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='seleccion_borrar_ok']/node()"/>';
		var txtSelBorrarKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='seleccion_borrar_ko']/node()"/>';
	</script>

	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/EIS/EISAnual2022_310522.js"/>
</head>

<body onload="TodasLineasActivas();">

	<!--	Comprueba si la sesión ha caducado	-->
	<xsl:choose>
	<xsl:when test="//SESION_CADUCADA">
		<xsl:apply-templates select="//SESION_CADUCADA"/>
	</xsl:when>
	<xsl:otherwise>
		<!-- Cabecera -->
		<!--idioma-->
		<xsl:variable name="lang">
			<xsl:value-of select="/EIS_ANUAL_XML/LANG"/>
		</xsl:variable>
		<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
		<!--idioma fin-->

		<form method="post" action="EISAnual_ajax.xsql" name="formEISAnual">

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
				<span id="NombreIndicador"><xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/INDICADOR"/></span>
				<span class="CompletarTitulo300">
					<!--	botones	-->
					<a class="btnNormal" href="javascript:Imprimir();"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
				</span>
			</p>
		</div>
		<br/>



			<xsl:choose>
			<xsl:when test="/EIS_ANUAL_XML/EIS_ANUAL/MVM or /EIS_ANUAL_XML/EIS_ANUAL/IDCONTROLSELECCION!=''">
				<xsl:call-template name="EIS_Anual_Form_Administrador"/>
			</xsl:when>
			<xsl:when test="/EIS_ANUAL_XML/EIS_ANUAL/ROL = 'COMPRADOR'">
				<xsl:call-template name="EIS_Anual_Form_Cliente"/>
			</xsl:when>
			<xsl:when test="/EIS_ANUAL_XML/EIS_ANUAL/ROL = 'VENDEDOR'">
				<xsl:call-template name="EIS_Anual_Form_Proveedor"/>
			</xsl:when>
			</xsl:choose>
			<br/>
				&nbsp;<label><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='TOP']/node()"/>:</strong></label>&nbsp;
				<select name="TOP" id="TOP">
					<option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></option>
					<option value="5">5</option>
					<option value="10">10</option>
					<option value="15">15</option>
					<option value="20">20</option>
				</select>&nbsp;&nbsp;&nbsp;&nbsp;
				<label><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='inicio']/node()"/>:</strong></label>&nbsp;
				<select id="anyo_inicial"/>&nbsp;&nbsp;&nbsp;&nbsp;
				<label><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='final']/node()"/>:</strong></label>&nbsp;
				<select id="anyo_final"/>&nbsp;&nbsp;&nbsp;&nbsp;
				<label><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='tolerancia']/node()"/>:</strong></label>&nbsp;
				<select id="tolerancia">
					<option value="0">0%</option>
					<option value="0.05">5%</option>
					<option value="0.1">10%</option>
					<option value="0.2">20%</option>
					<option value="0.3">30%</option>
				</select>
			<br/>
			<br/>
		 	<div class="divLeft">
				<ul class="pestannas">
					<li>
						<a class="Menu" id="pes_TablaDatos"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ver_tabla_datos']/node()"/></a>
					</li>
					<li>
						<a class="Menu" id="pes_Grafico"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ver_grafico']/node()"/></a>
					</li>
                    <xsl:if test="//US_ID=1">
						<li>
							<a class="Menu" id="pes_SQL"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ver_SQL']/node()"/></a>
						</li>
					</xsl:if>
				</ul>
			</div>
			<br/>
			<br/>


			<xsl:choose>
			<xsl:when test="not(/EIS_ANUAL_XML/EIS_ANUAL/FILA/COLUMNA)">
				<br/>
				<center><xsl:value-of select="document($doc)/translation/texts/item[@name='la_consulta_no_ha_devuelto_datos']/node()"/></center>
			</xsl:when>
			<xsl:otherwise>
			<div class="divLeft">
				<div class="tabela tabela_redonda">
				<table id="TablaDatos" class="tablaEIS" cellspacing="2px" cellpadding="2px">
					<!--	Esta tabla se crea dinámicamente desde el javascript	-->
				</table>
				</div>

				<table id="SQL" style="display:none">
					<tr>
						<td align="center">
							<textarea cols="100" rows="10"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/SQL"/></textarea>
						</td>
					</tr>
				</table>

				<table id="Grafico" width="100%" cellspacing="6" cellpadding="6" style="display:none">
					<tr>
						<td align="center">
   							<div class="container" style="width:1000px;height:400px;">
        						<canvas id="cvGrafico"></canvas>
    						</div>
						</td>
					</tr>
				</table>	
			<br /><br /><br />
			<br /><br /><br />
			</div><!--fin divLeft-->
			</xsl:otherwise>
			</xsl:choose>
		</form>
	</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>

<!-- Formulario Desplegables Proveedores -->
<xsl:template name="EIS_Anual_Form_Proveedor">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:value-of select="/EIS_ANUAL_XML/LANG"/>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->
<table class="buscador">
	<tr>
		<!-- Desplegable Centros Proveedor (IDCENTRO) -->
		<xsl:if test="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field/@name='IDCENTRO'">
			<td class="labelRight veinte">
				<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDCENTRO']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDCENTRO']/."/>
					<xsl:with-param name="claSel">w300px</xsl:with-param>
				</xsl:call-template>
			</td>
			<td class="cinco">&nbsp;</td>
		</xsl:if>

		<!-- Desplegable Lista Clientes (IDEMPRESA2) -->
		<xsl:if test="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field/@name='IDEMPRESA2'">
			<td class="labelRight veinte">
				<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDEMPRESA2']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDEMPRESA2']/."/>
					<xsl:with-param name="onChange">ListaCentrosDeCliente(this.id,this.value);</xsl:with-param>
					<xsl:with-param name="claSel">w300px</xsl:with-param>
				</xsl:call-template>
			</td>
			<td class="cinco">&nbsp;</td>
		</xsl:if>

		<!-- Desplegable Centros de Cliente (IDCENTRO2). Se genera por peticion ajax una vez se elige IDEMPRESA2-->
		<td class="labelRight veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='centros_cliente']/node()"/>:&nbsp;</td>
		<td class="datosLeft">
			<select id="IDCENTRO2" class="w300px" name="IDCENTRO2" disabled="disabled"/>
		</td>
		<td class="cinco">&nbsp;</td>
	</tr>

	<tr>
		<td class="labelRight  ">
			<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/AGRUPARPOR/field/@label"/>:&nbsp;
		</td>
		<td class="datosLeft">
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/EIS_ANUAL_XML/EIS_ANUAL/AGRUPARPOR/field"/>
				<xsl:with-param name="claSel">w300px</xsl:with-param>
			</xsl:call-template>
		</td>
		<td class="cinco">&nbsp;</td>

		<td colspan="6">&nbsp;</td>
	</tr>

	<tr>
		<!-- Boton Envio Formulario Via Ajax -->
		<td colspan="6">&nbsp;</td>
		<td>
			<a class="btnDestacado" id="MostrarCuadro" href="javascript:TablaEISAnualAjax();"><xsl:value-of select="document($doc)/translation/texts/item[@name='mostrar']/node()"/></a>
			<div id="waitBox" style="display:none;"><img src="http://www.newco.dev.br/images/loading.gif"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cargando']/node()"/>...</div>
		</td>
		 <!-- Fin Boton Envio Formulario Via Ajax -->
		<td colspan="2">&nbsp;</td>
	</tr>
</table>
</xsl:template>

<!-- Formulario Desplegables Clientes -->
<xsl:template name="EIS_Anual_Form_Cliente">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:value-of select="/EIS_ANUAL_XML/LANG"/>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->
<table class="buscador">
	<tr>
		<!-- Desplegable Centros Cliente (IDCENTRO) -->
		<xsl:if test="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field/@name='IDCENTRO'">
			<td class="labelRight veinte">
				<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDCENTRO']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDCENTRO']/."/>
					<xsl:with-param name="deshabilitado">
						<xsl:if test="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDCENTRO']/@disabled = 'disabled'">disabled</xsl:if>
					</xsl:with-param>
					<xsl:with-param name="claSel">w300px seleccion</xsl:with-param>
				</xsl:call-template>
			</td>
			<td class="cinco">&nbsp;</td>
		</xsl:if>

		<td colspan="3">&nbsp;</td>

		<!-- Desplegable Nivel Categoria (5 niveles) o Familia (3 niveles) -->
		<xsl:choose>
		<xsl:when test="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field/@name='IDCATEGORIA'">
			<td class="labelRight veinte">
				<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/NOMBRESNIVELES/NIVEL1"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDCATEGORIA']/."/>
					<xsl:with-param name="deshabilitado">
						<xsl:if test="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDCATEGORIA']/@disabled = 'disabled'">disabled</xsl:if>
					</xsl:with-param>
					<xsl:with-param name="onChange">ListaNivel(this.value,'FAM');</xsl:with-param>
					<xsl:with-param name="claSel">w300px seleccion</xsl:with-param>
				</xsl:call-template>
			</td>
			<td class="cinco">&nbsp;</td>
		</xsl:when>
		<xsl:when test="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field/@name='IDFAMILIA'">
			<td class="labelRight veinte">
				<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/NOMBRESNIVELES/NIVEL2"/>:&nbsp;
			</td>
			<td class="datosLeft">
            
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDFAMILIA']/."/>
					<xsl:with-param name="deshabilitado">
						<xsl:if test="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDFAMILIA']/@disabled = 'disabled'">disabled</xsl:if>
					</xsl:with-param>
					<xsl:with-param name="onChange">ListaNivel(this.value,'SF');</xsl:with-param>
					<xsl:with-param name="claSel">w300px seleccion</xsl:with-param>
				</xsl:call-template>
			</td>
			<td class="cinco">&nbsp;</td>
		</xsl:when>
		</xsl:choose>
	</tr>

	<tr>
		<!-- Desplegable Empresas Proveedor (IDEMPRESA2) -->
		<xsl:if test="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field/@name='IDEMPRESA2'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDEMPRESA2']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDEMPRESA2']/."/>
					<xsl:with-param name="onChange">ListaCentrosDeCliente(this.id,this.value);</xsl:with-param>
					<xsl:with-param name="claSel">w300px seleccion</xsl:with-param>
				</xsl:call-template>
			</td>
			<td>&nbsp;</td>
		</xsl:if>
		<!-- Desplegable Centros de Cliente (IDCENTRO2). Se genera por peticion ajax una vez se elige IDEMPRESA2-->
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='centros_proveedor']/node()"/>:&nbsp;</td>
		<td class="datosLeft">
			<select id="IDCENTRO2" name="IDCENTRO2" disabled="disabled" class="w300px seleccion"/>
		</td>
		<td>&nbsp;</td>
		<!-- Desplegable Familia  (5 niveles) o Subfamilia (3 niveles) -->
		<xsl:choose>
		<xsl:when test="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field/@name='IDCATEGORIA'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/NOMBRESNIVELES/NIVEL2"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<select name="IDFAMILIA" id="IDFAMILIA" class="w300px seleccion" disabled="disabled">
					<option value="-1"> [Todos] </option>
				</select>
			</td>
			<td class="cinco">&nbsp;</td>
		</xsl:when>
		<xsl:when test="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field/@name='IDFAMILIA'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/NOMBRESNIVELES/NIVEL3"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<select name="IDSUBFAMILIA" id="IDSUBFAMILIA" class="w300px seleccion" disabled="disabled">
					<option value="-1"> [Todos] </option>
				</select>
			</td>
			<td class="cinco">&nbsp;</td>
		</xsl:when>
		</xsl:choose>
	</tr>

	<tr>
		<td class="labelRight">
			<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/AGRUPARPOR/field/@label"/>:&nbsp;
		</td>
		<td class="datosLeft">
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/EIS_ANUAL_XML/EIS_ANUAL/AGRUPARPOR/field"/>
				<xsl:with-param name="claSel">w300px</xsl:with-param>
			</xsl:call-template>
		</td>
		<td class="cinco">&nbsp;</td>

		<td colspan="3">&nbsp;</td>

		<!-- Desplegable Subfamilia (5 niveles) -->
		<xsl:choose>
		<xsl:when test="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field/@name='IDCATEGORIA'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/NOMBRESNIVELES/NIVEL3"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<select name="IDSUBFAMILIA" id="IDSUBFAMILIA" class="w300px seleccion" disabled="disabled">
					<option value="-1"> [Todos] </option>
				</select>
			</td>
			<td class="cinco">&nbsp;</td>
		</xsl:when>
		</xsl:choose>
	</tr>

	<tr>
		<!-- Boton Envio Formulario Via Ajax -->
		<td colspan="6">&nbsp;</td>
		<td>
			<a class="btnDestacado" id="MostrarCuadro"  href="javascript:TablaEISAnualAjax();"><xsl:value-of select="document($doc)/translation/texts/item[@name='mostrar']/node()"/></a>
			<div id="waitBox" style="display:none;"><img src="http://www.newco.dev.br/images/loading.gif"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cargando']/node()"/>...</div>
		</td>
		 <!-- Fin Boton Envio Formulario Via Ajax -->
		<td colspan="2">&nbsp;</td>
	</tr>
</table>
</xsl:template>

<!-- Formulario Desplegables Administrador -->
<xsl:template name="EIS_Anual_Form_Administrador">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:value-of select="/EIS_ANUAL_XML/LANG"/>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->
<table cellspacing="6px" cellpadding="6px">
	<tr>
		<!-- Desplegable Empresas Cliente (IDEMPRESA) -->
		<xsl:if test="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field/@name='IDEMPRESA'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDEMPRESA']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDEMPRESA']/."/>
					<xsl:with-param name="onChange">ListaCentrosDeEmpresa(this.id,this.value);</xsl:with-param>
					<xsl:with-param name="claSel">w300px seleccion</xsl:with-param>
				</xsl:call-template>
			</td>
			<td>&nbsp;</td>
		</xsl:if>
		<!-- Desplegable Centros de Cliente (IDCENTRO). Se genera por peticion ajax una vez se elige IDEMPRESA -->
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='centros_cliente']/node()"/>:&nbsp;</td>
		<td class="datosLeft">
			<select id="IDCENTRO" name="IDCENTRO" disabled="disabled" class="w300px seleccion"/>
		</td>
		<td>&nbsp;</td>
		<!-- Desplegable Nivel Categorias (IDCATEGORIA) -->
			<td class="labelRight">
				<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/NOMBRESNIVELES/NIVEL1"/>:&nbsp;
			</td>
			<td class="datosLeft veinte">
				<select id="IDCATEGORIA" class="w300px seleccion" disabled="" name="IDCATEGORIA"></select>
			</td>
			<td class="cinco">&nbsp;</td>
	</tr>

	<tr>
		<!-- Desplegable Empresas Proveedor (IDEMPRESA2) -->
		<xsl:if test="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field/@name='IDEMPRESA2'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDEMPRESA2']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDEMPRESA2']/."/>
					<xsl:with-param name="onChange">ListaCentrosDeCliente(this.id,this.value);</xsl:with-param>
					<xsl:with-param name="claSel">w300px seleccion</xsl:with-param>
				</xsl:call-template>
			</td>
			<td>&nbsp;</td>
		</xsl:if>

		<!-- Desplegable Centros de Proveedor (IDCENTRO2). Se genera por peticion ajax una vez se elige IDEMPRESA2 -->
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='centros_proveedor']/node()"/>:&nbsp;</td>
		<td class="datosLeft">
			<select id="IDCENTRO2" name="IDCENTRO2" disabled="disabled" class="w300px seleccion"/>
		</td>
		<td>&nbsp;</td>

		<!-- Desplegable Nivel Familias (IDFAMILIA) -->
		<td class="labelRight">
			<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/NOMBRESNIVELES/NIVEL2"/>:&nbsp;
		</td>
		<td class="datosLeft">
			<select id="IDFAMILIA" class="w300px seleccion" disabled="" name="IDFAMILIA"></select>
		</td>
		<td class="cinco">&nbsp;</td>
	</tr>

	<tr>
		<!-- Desplegable AgruparPor (AGRUPARPOR) -->
		<td class="labelRight">
			<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/AGRUPARPOR/field/@label"/>:&nbsp;
		</td>
		<td class="datosLeft">
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/EIS_ANUAL_XML/EIS_ANUAL/AGRUPARPOR/field"/>
				<xsl:with-param name="claSel">w300px seleccion</xsl:with-param>
			</xsl:call-template>
		</td>
		<td>&nbsp;</td>
		<td colspan="3">&nbsp;</td>

		<!-- Desplegable Nivel Subfamilias (IDSUBFAMILIA) -->
		<td class="labelRight">
			<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/NOMBRESNIVELES/NIVEL3"/>:&nbsp;
		</td>
		<td class="datosLeft">
			<select id="IDSUBFAMILIA" class="w300px seleccion" disabled="" name="IDSUBFAMILIA"></select>
		</td>
		<td class="cinco">&nbsp;</td>
	</tr>

	<tr>
		<!-- Boton Envio Formulario Via Ajax -->
		<td colspan="6">&nbsp;</td>
		<td>
			<a class="btnDestacado" id="MostrarCuadro"  href="javascript:TablaEISAnualAjax();"><xsl:value-of select="document($doc)/translation/texts/item[@name='mostrar']/node()"/></a>
			<div id="waitBox" style="display:none;"><img src="http://www.newco.dev.br/images/loading.gif"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cargando']/node()"/>...</div>
		</td>
		 <!-- Fin Boton Envio Formulario Via Ajax -->
		<td colspan="2">&nbsp;</td>
	</tr>
</table>
</xsl:template>

</xsl:stylesheet>
