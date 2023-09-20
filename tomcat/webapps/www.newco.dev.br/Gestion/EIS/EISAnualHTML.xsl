<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	EIS por años de medicalvm.com
	Ultima revisión: ET 13abr20 16:37 EISAnual_260320
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
		<xsl:value-of select="/EIS_ANUAL_XML/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_anual']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<meta Http-Equiv="Cache-Control" Content="no-cache"/>

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"/>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"/>
	<!--<script type="text/javascript" src="http://www.google.com/jsapi"/>-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/Chart.bundle.min.2.9.3.js"></script>
	
	<!--
	<script type="text/javascript">
		google.load("visualization", "1", {packages:["corechart"]});
	</script>
	-->
	
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

	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/EIS/EISAnual_260320.js"/>
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
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eis']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='totales_anuales']/node()"/></span>
			</p>
			<p class="TituloPagina">
				<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='eis_anual']/node()"/>&nbsp;-&nbsp;<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/CENTRO"/>&nbsp;(<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/USUARIO"/>)&nbsp;-->
				<span id="NombreIndicador"><xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/INDICADOR"/></span>
				<span class="CompletarTitulo" style="width:100px;">
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
			<!-- Botones Tabla Datos - ->
			<div style="background:#fff;float:left;">
				<div style="float:left;">
					<table class="verEIS" style="margin:-2; padding:0;">
						<tr>
						<xsl:if test="/EIS_XML/EISANALISIS/VALORES/US_ID = '1'">
							<td>
								<a href="javascript:MostrarXML()" style="text-decoration:none;" title="Presentar XML">
									<img id="botonXML" src="http://www.newco.dev.br/images/botonXML1.gif" alt="ver XML"/>
								</a>
							</td>
						</xsl:if>

						<xsl:choose>
						<xsl:when test="not (/EIS_ANUAL_XML/EIS_ANUAL/FILA/COLUMNA/TOTAL)"></xsl:when>
						<xsl:otherwise>
							<td>
								<a href="javascript:VerDatos();" style="text-decoration:none;display:none;" title="Ver datos EIS" id="datosEIS">
									<img id="botonEIS" src="http://www.newco.dev.br/images/botonEIS1.gif" alt="Ver datos EIS"/>
								</a>
							</td>
							<td>
								<a href="javascript:VerGrafico();" style="text-decoration:none;" title="Ver Gráfico" id="graficoEIS">
									<img id="botonGrafico" src="http://www.newco.dev.br/images/botonGrafico1.gif" alt="Ver Grafico"/>
								</a>
							</td>
							<xsl:if test="//US_ID=1">
								<td>
									<a href="javascript:VerSQL();" style="text-decoration:none;" title="Ver SQL" id="sqlEIS">
										<img id="botonSQL" src="http://www.newco.dev.br/images/botonSQL1.gif" alt="Ver SQL"/>
									</a>
								</td>
							</xsl:if>
						</xsl:otherwise>
						</xsl:choose>

							<td>
							<!- -ver excel
								<a href="javascript:TablaEISAjaxExcel();" style="text-decoration:none;" title="Ver tabla Excel">
									<img id="botonExcel" alt="Descargar Excel" src="http://www.newco.dev.br/images/botonExcel1.gif"/>
								</a>- ->
							</td>
							<td>&nbsp;</td>
						</tr>
					</table>
				</div>

			<xsl:if test="/EIS_ANUAL_XML/EIS_ANUAL/MVM">
				<!- - Desplegable TOP - ->
				<div style="background:#fff;padding:5px 10px 0 20px;float:left;">
					<label><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='TOP']/node()"/>:</strong></label>&nbsp;
					<select name="TOP" id="TOP">
						<option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></option>
						<option value="5">5</option>
						<option value="10">10</option>
						<option value="15">15</option>
						<option value="20">20</option>
					</select>
				</div>
			</xsl:if>
                                
				<!- - Desplegable Tolerancia - - >
				<div style="background:#fff;float:left;display:inline;padding:5px 10px 0 20px;">
					<label><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='tolerancia']/node()"/>:</strong></label>&nbsp;
					<select id="tolerancia">
						<option value="0">0%</option>
						<option value="0.05">5%</option>
						<option value="0.1">10%</option>
						<option value="0.2">20%</option>
						<option value="0.3">30%</option>
					</select>
				</div>

				<!- - Desplegable Seleccion anyos - ->
				<div style="background:#fff;float:left;display:inline;padding:5px 10px 0 20px;">
					<label><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='inicio']/node()"/>:</strong></label>&nbsp;
					<select id="anyo_inicial"/>&nbsp;
					<label><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='final']/node()"/>:</strong></label>&nbsp;
					<select id="anyo_final"/><!- -&nbsp;&nbsp;
					<a href="javascript:recalculaColumnas();"><img src="http://www.newco.dev.br/images/actualizarFlecha.gif" alt="actualizar"/></a>- ->
				</div>
<! - -
			<xsl:if test="/EIS_XML/EISANALISIS/DERECHOS = 'MVM' or /EIS_XML/EISANALISIS/DERECHOS = 'MVMB'">
- ->
				<!- - Desplegable TOP - ->
<!- -
				<div style="background:#fff;padding:5px 10px 0 20px;float:left;">
					<label><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='TOP']/node()"/>:</strong></label>&nbsp;
					<select name="TOP" id="TOP">
						<option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></option>
						<option value="5">5</option>
						<option value="10">10</option>
						<option value="15">15</option>
						<option value="20">20</option>
					</select>
				</div>
			</xsl:if>
- ->
			<!- - Formulario que guarda la seleccion escogida - ->
<!- -
			<xsl:if test="/EIS_XML/EISANALISIS/ROL = 'COMPRADOR' and (/EIS_XML/EISANALISIS/DERECHOS = 'MVM' or /EIS_XML/EISANALISIS/DERECHOS = 'EMPRESA' or /EIS_XML/EISANALISIS/DERECHOS = 'CENTRO')">
				<div id="imgGuardarSeleccion" style="padding-top:5px;float:left;"><img src="http://www.newco.dev.br/images/sel.gif"/></div>&nbsp;
				<div id="divGuardarSeleccion" style="background:#fff;float:left;padding:5px 10px 0 10px;display:none;">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_seleccion']/node()"/>:</label>&nbsp;
					<input type="text" name="NOMBRE_SELECCION" id="NOMBRE_SELECCION"/>&nbsp;
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='mostrar_a_todos']/node()"/>:</label>&nbsp;
					<input type="checkbox" name="PARA_TODOS" id="PARA_TODOS"/>&nbsp;
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='excluir']/node()"/>:</label>&nbsp;
					<input type="checkbox" name="EXCLUIR" id="EXCLUIR"/>&nbsp;&nbsp;
					<div class="boton" style="float:right;">
						<a href="javascript:GuardarSeleccion();">Guardar</a>
					</div>
				</div>
			</xsl:if>
- ->
			</div>
			-->

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
				<table id="TablaDatos" class="tablaEIS" border="0" >
					<!--	Esta tabla se crea dinámicamente desde el javascript	-->
				</table>

				<table id="SQL" style="display:none">
					<tr>
						<td align="center">
							<textarea cols="100" rows="10"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/SQL"/></textarea>
						</td>
					</tr>
				</table>

				<table id="Grafico" width="100%" class="blanco" border="0" align="center" cellspacing="1" cellpadding="1" style="display:none">
					<tr>
						<td align="center">
   							<div class="container" style="width:1400px;height:600px;">
        						<canvas id="cvGrafico"></canvas>
    						</div>
							<!--<div id="graficoGoogle" style="width:100%; height:550px; border:0px solid red;"></div>-->
						</td>
					</tr>
				</table>	
			</div><!--fin divLeft-->

			<br /><br /><br />

			<!--<div class="divLeft">
				<div class="divLeft40nopa">&nbsp;</div>
				<div class="divLeft20">
					<div class="boton">
						<a href="javascript:Imprimir();"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
					</div>
				</div>
				<br /><br />
			</div>--><!--fin de divLeft-->
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
<!--<table class="infoTable selectEis" border="0">-->
<table class="buscador">
	<!--
	<thead>
	<tr>
		<th colspan="9">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='eis_anual']/node()"/>&nbsp;-&nbsp;<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/CENTRO"/>&nbsp;(<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/USUARIO"/>)&nbsp;-
			<span id="NombreIndicador"><xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/INDICADOR"/></span>
		</th>
	</tr>
	</thead>
	-->
	<tr class="sinLinea">
		<!-- Desplegable Centros Proveedor (IDCENTRO) -->
		<xsl:if test="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field/@name='IDCENTRO'">
			<td class="labelRight veinte">
				<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDCENTRO']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDCENTRO']/."/>
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
					<xsl:with-param name="onChange">
						ListaCentrosDeCliente(this.id,this.value);
					</xsl:with-param>
				</xsl:call-template>
			</td>
			<td class="cinco">&nbsp;</td>
		</xsl:if>

		<!-- Desplegable Centros de Cliente (IDCENTRO2). Se genera por peticion ajax una vez se elige IDEMPRESA2-->
		<td class="labelRight veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='centros_cliente']/node()"/>:&nbsp;</td>
		<td class="datosLeft"><select id="IDCENTRO2" name="IDCENTRO2" disabled="disabled"/></td>
		<td class="cinco">&nbsp;</td>
	</tr>

	<tr class="sinLinea">
		<td class="labelRight  ">
			<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/AGRUPARPOR/field/@label"/>:&nbsp;
		</td>
		<td class="datosLeft">
			<xsl:call-template name="desplegable"><xsl:with-param name="path" select="/EIS_ANUAL_XML/EIS_ANUAL/AGRUPARPOR/field"/></xsl:call-template>
		</td>
		<td class="cinco">&nbsp;</td>

		<td colspan="6">&nbsp;</td>
	</tr>

	<tr class="sinLinea">
		<!-- Boton Envio Formulario Via Ajax -->
		<td colspan="6">&nbsp;</td>
		<td>
			<!--<div class="botonLargoAma" id="MostrarCuadro">-->
				<a class="btnDestacado" id="MostrarCuadro" href="javascript:TablaEISAnualAjax();"><xsl:value-of select="document($doc)/translation/texts/item[@name='mostrar']/node()"/></a>
			<!--</div>-->
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
	<!--
	<thead>
	<tr>
		<th colspan="9">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='eis_anual']/node()"/>&nbsp;-&nbsp;<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/CENTRO"/>&nbsp;(<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/USUARIO"/>)&nbsp;-
			<span id="NombreIndicador"><xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/INDICADOR"/></span>
		</th>
	</tr>
	</thead>
	-->

	<tr class="sinLinea">
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
					<xsl:with-param name="claSel">seleccion</xsl:with-param>
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
					<xsl:with-param name="onChange">
						ListaNivel(this.value,'FAM');
					</xsl:with-param>
					<xsl:with-param name="claSel">largo seleccion</xsl:with-param>
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
					<xsl:with-param name="onChange">
						ListaNivel(this.value,'SF');
					</xsl:with-param>
					<xsl:with-param name="claSel">largo seleccion</xsl:with-param>
				</xsl:call-template>
			</td>
			<td class="cinco">&nbsp;</td>
		</xsl:when>
		</xsl:choose>
	</tr>

	<tr class="sinLinea">
		<!-- Desplegable Empresas Proveedor (IDEMPRESA2) -->
		<xsl:if test="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field/@name='IDEMPRESA2'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDEMPRESA2']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDEMPRESA2']/."/>
					<xsl:with-param name="onChange">
						ListaCentrosDeCliente(this.id,this.value);
					</xsl:with-param>
					<xsl:with-param name="claSel">seleccion</xsl:with-param>
				</xsl:call-template>
			</td>
			<td>&nbsp;</td>
		</xsl:if>
		<!-- Desplegable Centros de Cliente (IDCENTRO2). Se genera por peticion ajax una vez se elige IDEMPRESA2-->
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='centros_proveedor']/node()"/>:&nbsp;</td>
		<td class="datosLeft">
			<select id="IDCENTRO2" name="IDCENTRO2" disabled="disabled" class="seleccion"/>
		</td>
		<td>&nbsp;</td>
		<!-- Desplegable Familia  (5 niveles) o Subfamilia (3 niveles) -->
		<xsl:choose>
		<xsl:when test="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field/@name='IDCATEGORIA'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/NOMBRESNIVELES/NIVEL2"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<select name="IDFAMILIA" id="IDFAMILIA" class="largo seleccion" disabled="disabled">
					<option value="-1"> [Todos] </option>
				</select>
<!--
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDFAMILIA']/."/>
					<xsl:with-param name="deshabilitado">
						<xsl:if test="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDFAMILIA']/@disabled = 'disabled'">disabled</xsl:if>
					</xsl:with-param>
					<xsl:with-param name="claSel">largo seleccion</xsl:with-param>
				</xsl:call-template>
-->
			</td>
			<td class="cinco">&nbsp;</td>
		</xsl:when>
		<xsl:when test="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field/@name='IDFAMILIA'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/NOMBRESNIVELES/NIVEL3"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<select name="IDSUBFAMILIA" id="IDSUBFAMILIA" class="largo seleccion" disabled="disabled">
					<option value="-1"> [Todos] </option>
				</select>
<!--
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDSUBFAMILIA']/."/>
					<xsl:with-param name="deshabilitado">
						<xsl:if test="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDSUBFAMILIA']/@disabled = 'disabled'">disabled</xsl:if>
					</xsl:with-param>
					<xsl:with-param name="claSel">largo seleccion</xsl:with-param>
				</xsl:call-template>
-->
			</td>
			<td class="cinco">&nbsp;</td>
		</xsl:when>
		</xsl:choose>
	</tr>

	<tr class="sinLinea">
		<td class="labelRight">
			<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/AGRUPARPOR/field/@label"/>:&nbsp;
		</td>
		<td class="datosLeft">
			<xsl:call-template name="desplegable"><xsl:with-param name="path" select="/EIS_ANUAL_XML/EIS_ANUAL/AGRUPARPOR/field"/></xsl:call-template>
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
				<select name="IDSUBFAMILIA" id="IDSUBFAMILIA" class="largo seleccion" disabled="disabled">
					<option value="-1"> [Todos] </option>
				</select>
			</td>
			<td class="cinco">&nbsp;</td>
		</xsl:when>
		</xsl:choose>
	</tr>

	<tr class="sinLinea">
		<!-- Boton Envio Formulario Via Ajax -->
		<td colspan="6">&nbsp;</td>
		<td>
			<!--<div class="botonLargoAma" id="MostrarCuadro">-->
				<a class="btnDestacado" id="MostrarCuadro"  href="javascript:TablaEISAnualAjax();"><xsl:value-of select="document($doc)/translation/texts/item[@name='mostrar']/node()"/></a>
			<!--</div>-->
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
<table class="buscador">
	<!--
	<thead>
	<tr>
		<th colspan="9">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='eis_anual']/node()"/>&nbsp;-&nbsp;<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/CENTRO"/>&nbsp;(<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/USUARIO"/>)&nbsp;-
			<span id="NombreIndicador"><xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/INDICADOR"/></span>
		</th>
	</tr>
	</thead>
	-->

	<tr class="sinLinea">
		<!-- Desplegable Empresas Cliente (IDEMPRESA) -->
		<xsl:if test="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field/@name='IDEMPRESA'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDEMPRESA']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDEMPRESA']/."/>
					<xsl:with-param name="onChange">ListaCentrosDeEmpresa(this.id,this.value);</xsl:with-param>
					<xsl:with-param name="claSel">seleccion</xsl:with-param>
				</xsl:call-template>
			</td>
			<td>&nbsp;</td>
		</xsl:if>
		<!-- Desplegable Centros de Cliente (IDCENTRO). Se genera por peticion ajax una vez se elige IDEMPRESA -->
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='centros_cliente']/node()"/>:&nbsp;</td>
		<td class="datosLeft">
			<select id="IDCENTRO" name="IDCENTRO" disabled="disabled" class="seleccion"/>
		</td>
		<td>&nbsp;</td>
		<!-- Desplegable Nivel Categorias (IDCATEGORIA) -->
			<td class="labelRight">
				<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/NOMBRESNIVELES/NIVEL1"/>:&nbsp;
			</td>
			<td class="datosLeft veinte">
				<select id="IDCATEGORIA" class="largo seleccion" disabled="" name="IDCATEGORIA"></select>
			</td>
			<td class="cinco">&nbsp;</td>
	</tr>

	<tr class="sinLinea">
		<!-- Desplegable Empresas Proveedor (IDEMPRESA2) -->
		<xsl:if test="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field/@name='IDEMPRESA2'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDEMPRESA2']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/field[@name='IDEMPRESA2']/."/>
					<xsl:with-param name="onChange">
						ListaCentrosDeCliente(this.id,this.value);
					</xsl:with-param>
					<xsl:with-param name="claSel">seleccion</xsl:with-param>
				</xsl:call-template>
			</td>
			<td>&nbsp;</td>
		</xsl:if>

		<!-- Desplegable Centros de Proveedor (IDCENTRO2). Se genera por peticion ajax una vez se elige IDEMPRESA2 -->
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='centros_proveedor']/node()"/>:&nbsp;</td>
		<td class="datosLeft">
			<select id="IDCENTRO2" name="IDCENTRO2" disabled="disabled" class="seleccion"/>
		</td>
		<td>&nbsp;</td>

		<!-- Desplegable Nivel Familias (IDFAMILIA) -->
			<td class="labelRight">
				<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/NOMBRESNIVELES/NIVEL2"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<select id="IDFAMILIA" class="largo seleccion" disabled="" name="IDFAMILIA"></select>
			</td>
			<td class="cinco">&nbsp;</td>
	</tr>

	<tr class="sinLinea">
		<!-- Desplegable AgruparPor (AGRUPARPOR) -->
		<td class="labelRight">
			<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/AGRUPARPOR/field/@label"/>:&nbsp;
		</td>
		<td class="datosLeft">
			<xsl:call-template name="desplegable"><xsl:with-param name="path" select="/EIS_ANUAL_XML/EIS_ANUAL/AGRUPARPOR/field"/></xsl:call-template>
		</td>
		<td>&nbsp;</td>

		<td colspan="3">&nbsp;</td>

		<!-- Desplegable Nivel Subfamilias (IDSUBFAMILIA) -->
			<td class="labelRight">
				<xsl:value-of select="/EIS_ANUAL_XML/EIS_ANUAL/FILTROS/NOMBRESNIVELES/NIVEL3"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<select id="IDSUBFAMILIA" class="largo seleccion" disabled="" name="IDSUBFAMILIA"></select>
			</td>
			<td class="cinco">&nbsp;</td>
	</tr>

	<tr class="sinLinea">
		<!-- Boton Envio Formulario Via Ajax -->
		<td colspan="6">&nbsp;</td>
		<td>
			<!--<div class="botonLargoAma" id="MostrarCuadro">-->
				<a class="btnDestacado" id="MostrarCuadro"  href="javascript:TablaEISAnualAjax();"><xsl:value-of select="document($doc)/translation/texts/item[@name='mostrar']/node()"/></a>
			<!--</div>-->
			<div id="waitBox" style="display:none;"><img src="http://www.newco.dev.br/images/loading.gif"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cargando']/node()"/>...</div>
		</td>
		 <!-- Fin Boton Envio Formulario Via Ajax -->
		<td colspan="2">&nbsp;</td>
	</tr>
</table>
</xsl:template>

</xsl:stylesheet>
