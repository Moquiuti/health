<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Matriz de resumen de datos por empresa/centro
	Ultima revisión: ET 27feb20 11:45 EISMatriz_270220.js
+-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:template match="/">

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/EIS_XML/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title>
		<xsl:value-of select="document($doc)/translation/texts/item[@name='eis']/node()"/>&nbsp;-&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='matriz_eis']/node()"/>
	</title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"/>

	<script type="text/javascript">
		var sepCSV			=';';		//27feb20
		var sepTextoCSV		='';		//27feb20
		var saltoLineaCSV	='\r\n';	//27feb20
		var lang		= '<xsl:value-of select="/EIS_XML/LANG"/>';
		var FiltroSQL		= '<xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/SQL"/>';
		var IDEmpresaDelUsuario	= '<xsl:value-of select="/EIS_XML/RESULTADOS/IDEMPRESA"/>';
		var userDerechos	= '<xsl:value-of select="/EIS_XML/RESULTADOS/DERECHOS"/>';
		var userRol		= '<xsl:value-of select="/EIS_XML/RESULTADOS/ROL"/>';

		<!-- Lista Parametros para construir desplegables de catalogo -->
		var Parametros		= [];
		<xsl:if test="/EIS_XML/request/parameters/IDCATEGORIA">
			Parametros['IDCATEGORIA'] = '<xsl:value-of select="/EIS_XML/request/parameters/IDCATEGORIA"/>';
		</xsl:if>
		<xsl:if test="/EIS_XML/request/parameters/IDFAMILIA">
			Parametros['IDFAMILIA'] = '<xsl:value-of select="/EIS_XML/request/parameters/IDFAMILIA"/>';
		</xsl:if>
		<xsl:if test="/EIS_XML/request/parameters/IDSUBFAMILIA">
			Parametros['IDSUBFAMILIA'] = '<xsl:value-of select="/EIS_XML/request/parameters/IDSUBFAMILIA"/>';
		</xsl:if>
		<xsl:if test="/EIS_XML/request/parameters/IDGRUPO">
			Parametros['IDGRUPO'] = '<xsl:value-of select="/EIS_XML/request/parameters/IDGRUPO"/>';
		</xsl:if>
		<xsl:if test="/EIS_XML/request/parameters/IDPRODUCTOESTANDAR">
			Parametros['IDPRODUCTOESTANDAR'] = '<xsl:value-of select="/EIS_XML/request/parameters/IDPRODUCTOESTANDAR"/>';
		</xsl:if>
		<!-- FIN Lista Parametros para construir desplegables de catalogo -->

		<!-- Lista Meses de la tabla -->
		var ListaCabeceraH		= [];
		<xsl:for-each select="/EIS_XML/RESULTADOS/CENTROS/CENTRO">
			items= [];
			items['nombre']		= '<xsl:value-of select="NOMBRE"/>';
			items['id']		= '<xsl:value-of select="ID"/>';
			items['pos']		= '<xsl:value-of select="@Actual"/>';
			ListaCabeceraH.push(items);
		</xsl:for-each>
		var NumCabeceraH		= ListaCabeceraH.length;
		<!-- FIN Lista Meses de la tabla -->

		<!-- Resultados de la consulta para mostrar tabla, grafico, etc. -->
		var IDIndicador		= '<xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/IDINDICADOR"/>';
		var Indicador		= '<xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/INDICADOR"/>';
		var Color, ComColor;
		var ResultadosTabla	= {};
		var NombreFila		= [];
		ResultadosTabla['INDICADOR|' + IDIndicador]	= '<xsl:for-each select="/EIS_XML/RESULTADOS/FILTROS/field/dropDownList/listElem">
				<xsl:if test="/EIS_XML/RESULTADOS/VALORES/IDINDICADOR = ID"><xsl:value-of select="listItem"/></xsl:if>
		</xsl:for-each>';
		ResultadosTabla['MAX_LINEAS_' + IDIndicador]= '<xsl:value-of select="count(/EIS_XML/RESULTADOS/FILA)"/>';

		<xsl:for-each select="/EIS_XML/RESULTADOS/FILA">
			NombreFila.push('<xsl:value-of select="NOMBRE"/>');
			ResultadosTabla['GRUPO|' + IDIndicador + '|<xsl:value-of select="ID"/>|<xsl:value-of select="@Actual"/>'] = '<xsl:value-of select="NOMBRE"/>';

			<xsl:for-each select="COLUMNA">
				ResultadosTabla['COLUMNA|' + IDIndicador + '|<xsl:value-of select="IDCOLUMNA"/>|<xsl:value-of select="@Actual"/>'] = ListaCabeceraH[<xsl:value-of select="@Actual"/> - 1].nombre;
				ResultadosTabla['RES|' + IDIndicador + '|<xsl:value-of select="IDFILA"/>|<xsl:value-of select="../@Actual"/>|<xsl:value-of select="@Actual"/>'] = '<xsl:value-of select="TOTAL"/>';
				<!--ResultadosTabla['RES|' + IDIndicador + '|<xsl:value-of select="IDFILA"/>|<xsl:value-of select="IDCOLUMNA"/>|<xsl:value-of select="@Actual"/>'] = '<xsl:value-of select="TOTAL"/>';-->
				ResultadosTabla['COMENTARIO|' + IDIndicador + '|<xsl:value-of select="IDFILA"/>|<xsl:value-of select="../@Actual"/>|<xsl:value-of select="@Actual"/>'] = '<xsl:value-of select="COMENTARIO"/>';

				<xsl:choose>
				<xsl:when test="COMENTARIO_COLOR != ''">
					ComColor	= '<xsl:value-of select="COMENTARIO_COLOR"/>';
				</xsl:when>
				<xsl:when test="./NUEVO">
					ComColor	= 'NARANJA';
				</xsl:when>
				<xsl:otherwise>
					ComColor	= 'NORMAL';
				</xsl:otherwise>
				</xsl:choose>

				ResultadosTabla['COMENTARIO_COLOR|' + IDIndicador + '|<xsl:value-of select="IDFILA"/>|<xsl:value-of select="../@Actual"/>|<xsl:value-of select="@Actual"/>'] = ComColor;

				<xsl:choose>
				<xsl:when test="ROJO">
					Color = 'Rojo';
				</xsl:when>
				<xsl:when test="GRAVE">
					Color = 'Grave';
				</xsl:when>
				<xsl:when test="VERDE">
					Color = 'Verde';
				</xsl:when>
				<xsl:when test="NUEVO">
					Color = 'Nuevo';
				</xsl:when>
				<xsl:otherwise>
					Color = '';
				</xsl:otherwise>
				</xsl:choose>
				ResultadosTabla['COLOR|' + IDIndicador + '|<xsl:value-of select="IDFILA"/>|<xsl:value-of select="../@Actual"/>|<xsl:value-of select="@Actual"/>'] = Color;


<!--
				<xsl:for-each select="ROW">
					<xsl:variable name="COLOR">
						<xsl:choose>
						<xsl:when test='./ROJO'>ROJO</xsl:when>
						<xsl:when test='./VERDE'>VERDE</xsl:when> 
						<xsl:otherwise>NEGRO</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>

					ResultadosTabla['ROW|<xsl:value-of select="../../IDINDICADOR"/>|<xsl:value-of select="../IDGRUPO"/>|<xsl:value-of select="../LINEA"/>|<xsl:value-of select="COLUMNA"/>'] = '<xsl:value-of select="TOTAL"/>';
					ResultadosTabla['ROW|<xsl:value-of select="../../IDINDICADOR"/>|<xsl:value-of select="../IDGRUPO"/>|<xsl:value-of select="../LINEA"/>|<xsl:value-of select="COLUMNA"/>|COLOR'] = '<xsl:value-of select="$COLOR"/>';
				</xsl:for-each>
-->
			</xsl:for-each>
		</xsl:for-each>

		<xsl:if test="not(/EIS_XML/RESULTADOS/PRECALCULADA)">
			var ComentariosGen = new Array();

			<xsl:for-each select="/EIS_XML/RESULTADOS/COMENTARIOS_MATRIZ/COMENTARIO">
				ComentariosGen['<xsl:value-of select="EIS_MPC_IDHOR"/>|<xsl:value-of select="EIS_MPC_IDVER"/>'] = '<xsl:value-of select="COMENTARIO"/>|<xsl:value-of select="COMENTARIO_COLOR"/>';
			</xsl:for-each>
		</xsl:if>

		var txtSinResultados	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='la_consulta_no_ha_devuelto_datos']/node()"/>';
		var txtConcepto		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='concepto']/node()"/>';

		var matrizPrecalculada;
		<xsl:choose>
		<xsl:when test="/EIS_XML/RESULTADOS/PRECALCULADA">
			matrizPrecalculada = 'S';
		</xsl:when>
		<xsl:otherwise>
			matrizPrecalculada = 'N';
		</xsl:otherwise>
		</xsl:choose>

		var filtrosComentarios;
		<xsl:choose>
		<xsl:when test="/EIS_XML/RESULTADOS/VALORES/FILTROCOMENTARIOS">
			filtrosComentarios = '<xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/FILTROCOMENTARIOS"/>';
		</xsl:when>
		<xsl:otherwise>
			filtrosComentarios = '';
		</xsl:otherwise>
		</xsl:choose>

        </script>

	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/EIS/EISMatriz_270220.js"></script>

</head>

<body onload="TodasLineasActivas();">
<!--<body onload="alert(ResultadosTabla['COLOR|CO_PED_EUR|SUTURAS|2|16']);">-->
	<!--	Comprueba si la sesión ha caducado	-->
	<xsl:choose>
	<xsl:when test="//SESION_CADUCADA">
		<xsl:apply-templates select="//SESION_CADUCADA"/>
	</xsl:when>
	<xsl:otherwise>
		<!-- Cabecera -->
		<form method="post" action="EISMatriz.xsql" name="formEISMatriz">
			<!--parametros para comentario-->
			<input type="hidden" name="IDPREDEFINIDA" value="{//IDPRECALCULADA}"/>
			<input type="hidden" name="US_ID" value="{//US_ID}"/>
			<input type="hidden" name="IDHOR"/>
			<input type="hidden" name="IDVER"/>
			<input type="hidden" name="LINEA"/>
			<input type="hidden" name="COLUMNA"/>
			<input type="hidden" name="IDEMPRESA_USU" value="{/EIS_XML/RESULTADOS/IDEMPRESA}"/>
			<input type="hidden" name="IDAGRUPARPOR_VER" value="{/EIS_XML/RESULTADOS/AGRUPARPOR_VER/field/@current}"/>
			<input type="hidden" name="IDAGRUPARPOR_HOR" value="{/EIS_XML/RESULTADOS/AGRUPARPOR_HOR/field/@current}"/>
			<!--	Guardamos los valores originales en campos ocultos	-->
			<input type="hidden" name="Indicadores"/>
			<input type="hidden" name="OR_ANNOINICIO">
				<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/ANNOINICIO"/></xsl:attribute>
			</input>
			<input type="hidden" name="OR_MESINICIO">
				<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/MESINICIO"/></xsl:attribute>
			</input>
			<input type="hidden" name="OR_ANNOFINAL">
				<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/ANNOFINAL"/></xsl:attribute>
			</input>
			<input type="hidden" name="OR_MESFINAL">
				<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/MESFINAL"/></xsl:attribute>
			</input>
			<input type="hidden" name="OR_IDINDICADOR">
				<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/IDINDICADOR"/></xsl:attribute>
			</input>
			<input type="hidden" name="OR_IDEMPRESA">
				<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/IDEMPRESA"/></xsl:attribute>
			</input>
			<input type="hidden" name="OR_IDCENTRO">
				<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/IDCENTRO"/></xsl:attribute>
			</input>
			<input type="hidden" name="OR_IDEMPRESA2">
				<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/IDEMPRESA2"/></xsl:attribute>
			</input>
			<input type="hidden" name="OR_IDPRODUCTO">
				<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/IDPRODUCTO"/></xsl:attribute>
			</input>
			<input type="hidden" name="OR_IDFAMILIA">
				<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/IDFAMILIA"/></xsl:attribute>
			</input>
			<input type="hidden" name="OR_REFERENCIA">
				<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/REFERENCIA"/></xsl:attribute>
			</input>
			<input type="hidden" name="OR_IDRESULTADOS">
				<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/IDRESULTADOS"/></xsl:attribute>
			</input>
			<input type="hidden" name="OR_AGRUPARPOR_HOR">
				<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/AGRUPARPOR_HOR"/></xsl:attribute>
			</input>
			<input type="hidden" name="OR_AGRUPARPOR_VER">
				<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/AGRUPARPOR_VER"/></xsl:attribute>
			</input>

			<!--	Comprueba si no hay datos	-->
			<!--idioma-->
			<xsl:variable name="lang">
				<xsl:value-of select="/EIS_XML/LANG"/>
			</xsl:variable>
			<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
			<!--idioma fin-->

			<!--	Titulo de la página		-->
			<div class="ZonaTituloPagina">
				<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eis']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='matriz_eis']/node()"/></span></p>
				<p class="TituloPagina">
					<xsl:for-each select="/EIS_XML/RESULTADOS/FILTROS/field[@name='INDICADOR']/dropDownList/listElem">
						<xsl:if test="../../@current = ID"><span id="NombreIndicador"><xsl:value-of select="listItem"/></span></xsl:if>
					</xsl:for-each>					
					<span class="CompletarTitulo">
						<a class="btnNormal" href="javascript:listadoExcel();" style="text-decoration:none;" title="Descargar Fichero Excel">
							<img id="botonExcel" alt="Descargar Excel" src="http://www.newco.dev.br/images/iconoExcel.gif"/>
						</a>&nbsp;
						<a class="btnNormal" href="javascript:Imprimir();">Imprimir</a>
					</span>
				</p>
			</div>
			<br/>

			<xsl:choose>
			<xsl:when test=" not (/EIS_XML/RESULTADOS/FILA/COLUMNA/TOTAL)">
				<br/>
				<center><xsl:value-of select="document($doc)/translation/texts/item[@name='consulta_no_ha_devuelto_datos']/node()"/>.</center>
				<br/>

				<table class="tablaEIS">
					<tr>
						<td align="center">
							<xsl:call-template name="botonPersonalizado">
								<xsl:with-param name="funcion">history.go(-1);</xsl:with-param>
								<xsl:with-param name="status">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='volver_pagina_anterior']/node()"/>
								</xsl:with-param>
								<xsl:with-param name="ancho">120px</xsl:with-param>
								<xsl:with-param name="label">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/>
								</xsl:with-param>
							</xsl:call-template>
						</td>
						<td>
							<xsl:call-template name="botonPersonalizado">
								<xsl:with-param name="funcion">window.close();</xsl:with-param>
								<xsl:with-param name="status">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar_pagina']/node()"/>
								</xsl:with-param>
								<xsl:with-param name="ancho">120px</xsl:with-param>
								<xsl:with-param name="label">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
								</xsl:with-param>
							</xsl:call-template>
						</td>
						<td>
							<xsl:call-template name="botonPersonalizado">
								<xsl:with-param name="funcion">MostrarEISMatriz();</xsl:with-param>
								<xsl:with-param name="status">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='inicio']/node()"/>
								</xsl:with-param>
								<xsl:with-param name="ancho">120px</xsl:with-param>
								<xsl:with-param name="label">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='matriz_eis']/node()"/>
								</xsl:with-param>
							</xsl:call-template>
						</td>
					</tr>
				</table>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
				<xsl:when test="/EIS_XML/RESULTADOS/EISSIMPLIFICADO">
					<h1 class="titlePage"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/CUADRO"/></h1>
				</xsl:when>
				<xsl:otherwise>
					<!--div para lightbox effect-->
					<div id="fade" class="fadebox">&nbsp;</div>
					<!--fin div para lightbox effect-->

					<table class="buscador">
					<!--
					<table class="infoTable selectEis celeste">
					<thead>
						<tr>
							<th colspan="9">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='eis']/node()"/>&nbsp;-&nbsp;<xsl:value-of select="/EIS_XML/RESULTADOS/CENTRO"/>&nbsp;(<xsl:value-of select="/EIS_XML/RESULTADOS/USUARIO"/>)&nbsp;-
							<xsl:for-each select="/EIS_XML/RESULTADOS/FILTROS/field[@name='INDICADOR']/dropDownList/listElem">
								<xsl:if test="../../@current = ID"><span id="NombreIndicador"><xsl:value-of select="listItem"/></span>&nbsp;-&nbsp;</xsl:if>
							</xsl:for-each>
								<xsl:value-of select="document($doc)/translation/texts/item[@name='matriz_resultados']/node()"/>
							</th>
						</tr>
					</thead>
					-->

					<!-- Cargamos la plantilla del formulario dependiendo de los derechos del usuario -->
					<xsl:choose>
					<xsl:when test="/EIS_XML/RESULTADOS/DERECHOS = 'MVM' or /EIS_XML/RESULTADOS/IDCONTROLSELECCION!='' or /EIS_XML/RESULTADOS/PRECALCULADA">
						<xsl:call-template name="EISMatriz_Form_Administrador"/>
					</xsl:when>
					<xsl:when test="/EIS_XML/RESULTADOS/DERECHOS = 'EMPRESA'">
						<xsl:call-template name="EISMatriz_Form_Empresa"/>
					</xsl:when>
					</xsl:choose>

					</table>


					<div class="divLeft">
						<div class="divLeft40nopa">&nbsp;</div>
						<div class="divLeft20 textCenter">
							<!--<p>&nbsp;</p>-->
<!--							<div class="botonLargo">-->
							<!--<div class="botonLargoAma" id="MostrarCuadro">-->
								<a class="btnDestacado" id="MostrarCuadro" href="javascript:TablaEISMatrizAjax();">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='presentar_cuadro_mando']/node()"/>
								</a>
							<!--</div>-->
							<div id="waitBox" style="display:none;"><img src="http://www.newco.dev.br/images/loading.gif"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cargando']/node()"/>...</div>
							<!--<p>&nbsp;</p>-->
						</div>
					</div>
					<div class="divLeft">&nbsp;</div>
				</xsl:otherwise>
				</xsl:choose>

				<xsl:if test="not(/EIS_XML/RESULTADOS/PRECALCULADA)">
					<div style="background:#fff;float:left;">
					<table class="verMatriz" style="margin:-2; padding:0;">
						<tr>
							<td>
								<a href="javascript:generarTabla('A');" style="text-decoration:none;" id="ACUM">
									<img>
									<xsl:choose>
									<xsl:when test="$lang = 'spanish'">
										<xsl:attribute name="src">http://www.newco.dev.br/images/botonAcumulado1.gif</xsl:attribute>
										<xsl:attribute name="alt">Acumulado</xsl:attribute>
										<xsl:attribute name="title">Acumulado</xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="src">http://www.newco.dev.br/images/botonAcumulado1-BR.gif</xsl:attribute>
										<xsl:attribute name="alt">Acumulado</xsl:attribute>
										<xsl:attribute name="title">Acumulado</xsl:attribute>
									</xsl:otherwise>
									</xsl:choose>
									</img>
								</a>
							</td>
							<td>
								<a href="javascript:generarTabla('V');" style="text-decoration:none;" id="POR_VERTICAL">
									<img>
									<xsl:choose>
									<xsl:when test="$lang = 'spanish'">
										<xsl:attribute name="src">http://www.newco.dev.br/images/botonPerVertical.gif</xsl:attribute>
										<xsl:attribute name="alt">Porcentaje Vertical</xsl:attribute>
										<xsl:attribute name="title">Porcentaje Vertical</xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="src">http://www.newco.dev.br/images/botonPerVertical-BR.gif</xsl:attribute>
										<xsl:attribute name="alt">Percentagem Vertical</xsl:attribute>
										<xsl:attribute name="title">Percentagem Vertical</xsl:attribute>
									</xsl:otherwise>
									</xsl:choose>
									</img>
								</a>
							</td>
							<td>
								<a href="javascript:generarTabla('H');" style="text-decoration:none;" id="POR_HORIZONTAL">
									<img>
									<xsl:choose>
									<xsl:when test="$lang = 'spanish'">
										<xsl:attribute name="src">http://www.newco.dev.br/images/botonPerHorizontal.gif</xsl:attribute>
										<xsl:attribute name="alt">Porcentaje Horizontal</xsl:attribute>
										<xsl:attribute name="title">Porcentaje Horizontal</xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="src">http://www.newco.dev.br/images/botonPerHorizontal-BR.gif</xsl:attribute>
										<xsl:attribute name="alt">Percentagem Horizontal</xsl:attribute>
										<xsl:attribute name="title">Percentagem Horizontal</xsl:attribute>
									</xsl:otherwise>
									</xsl:choose>
									</img>
								</a>
							</td>
						</tr>
					</table>
					</div>

					<!-- Desplegable Tolerancia -->
					<div style="background:#fff;float:left;display:inline;padding:5px 10px 0 20px;">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='tolerancia']/node()"/>:</label>&nbsp;
						<select id="tolerancia">
							<option value="0">0%</option>
							<option value="0.05">5%</option>
							<option value="0.1">10%</option>
							<option value="0.2">20%</option>
							<option value="0.3">30%</option>
						</select>
					</div>

				<xsl:if test="/EIS_XML/RESULTADOS/DERECHOS = 'MVM' or /EIS_XML/RESULTADOS/DERECHOS = 'MVMB'">
					<!-- Desplegable TOP Vertical -->
					<div style="background:#fff;float:left;display:inline;padding:5px 10px;">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='TOP_Vertical']/node()"/>:</label>&nbsp;
						<select name="TOP_V" id="TOP_V">
						<xsl:for-each select="/EIS_XML/SELECT[@name='TOP_V']/option">
							<option>
								<xsl:attribute name="value"><xsl:value-of select="@value"/></xsl:attribute>

								<xsl:if test="/EIS_XML/TOP_V = @value">
									<xsl:attribute name="selected">yes</xsl:attribute>
								</xsl:if>

								<xsl:choose>
								<xsl:when test="@name='todos'">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="@value"/>
								</xsl:otherwise>
								</xsl:choose>
                        				</option>
						</xsl:for-each>
						</select>
					</div>

					<!-- Desplegable TOP Horizontal -->
					<div style="background:#fff;float:left;display:inline;padding:5px 10px;">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='TOP_Horizontal']/node()"/>:</label>&nbsp;
						<select name="TOP_H" id="TOP_H">
						<xsl:for-each select="/EIS_XML/SELECT[@name='TOP_H']/option">
							<option>
								<xsl:attribute name="value"><xsl:value-of select="@value"/></xsl:attribute>

								<xsl:if test="/EIS_XML/TOP_H = @value">
									<xsl:attribute name="selected">yes</xsl:attribute>
								</xsl:if>

								<xsl:choose>
								<xsl:when test="@name='todos'">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/>
								</xsl:when>
								<xsl:when test="@name='con_resultados'">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='con_resultados']/node()"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="@value"/>
								</xsl:otherwise>
								</xsl:choose>
                        				</option>
						</xsl:for-each>
						</select>
					</div>
				</xsl:if>

					<!-- Link 'Periodo Anterior' -->
					<div style="background:#fff;float:right;margin-right:20px;">
						<a href="javascript:periodoAnterior();" style="text-decoration:none;">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='periodo_anterior']/node()"/>
						</a>
					</div>
				</xsl:if>

					<table id="TablaDatos" class="tablaEIS" border="0" >
						<!--	Esta tabla se crea dinámicamente desde el javascript	-->
					</table>

						<!--insertar un nuevo comentario     id="cerrar"-->
						<div class="insertCome" id="insertCome" style="display:none;">
							<!--idioma-->
							<xsl:variable name="lang">
								<xsl:value-of select="//LANG"/>
							</xsl:variable>
							<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
							<!-- fin idioma-->

							<input type="hidden" id="comeLinea" name="comeLinea"/>
							<input type="hidden" id="comeCol" name="comeCol"/>

							<p class="cerrarInsertCome" id="cerrar">
								<a><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>
							</p>

							<p align="left" style="padding-left:20px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='fila']/node()"/>: <strong><span id="filaComen"></span></strong></p>
							<p align="left" style="padding-left:20px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='columna']/node()"/>: <strong><span id="colComen"></span></strong></p>
							<p align="left" style="padding-left:20px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='valor']/node()"/>: <strong><span id="valComen"></span></strong></p>

							<textarea name="TEXT">
								<xsl:value-of select="COMENTARIO"/>
							</textarea><br />

							<select name="COLOR">
								<option value="">Color</option>
								<option value="ROJO">Rojo</option>
								<option value="NEGRO">Negro</option>
								<option value="VERDE">Verde</option>
								<option value="AZUL">Azul</option>
								<option value="AMARILLO">Amarillo</option>
								<option value="NARANJA">Naranja</option>
							</select><br />

							<img src="http://www.newco.dev.br/images/enviar.gif" class="envioCome" id="envioCome"/>

							<div id="waitBox">&nbsp;</div>
							<div id="confirmBox"></div>
						</div>
						<br/><br/>
					</xsl:otherwise>
				</xsl:choose>
			</form>
		</xsl:otherwise>
	</xsl:choose>
	<!--
	<br /><br />
	<div class="divLeft">
		<div class="divLeft40nopa">&nbsp;</div>
		<div class="divLeft20">
			<div class="boton">
				<a href="javascript:Imprimir();">Imprimir</a>
			</div><!- -fin de boton- ->
		</div>
		<br /><br />
	</div>-->
	<!--fin de divLeft-->
</body>
</html>
</xsl:template>

<!-- Formulario MatrizEIS - Desplegables Administrador (MVM o MVMB) -->
<xsl:template name="EISMatriz_Form_Administrador">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:value-of select="/EIS_XML/LANG"/>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<tr class="sinLinea">
	<!-- Desplegable Cuadro de Mando (IDCUADROMANDO) -->
	<td class="labelRight quince">
		<xsl:value-of select="/EIS_XML/RESULTADOS/FILTROS/field[@name='INDICADOR']/@label"/>:&nbsp;
	</td>
	<td class="datosLeft">
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/FILTROS/field[@name='INDICADOR']/."/>
		</xsl:call-template>
	</td>
	<td class="cinco">&nbsp;</td>

	<!-- Desplegable Inicio (MESINICIO y ANNOINICIO) -->
	<td class="labelRight veinte">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='inicio']/node()"/>:&nbsp;
	</td>
	<td class="datosLeft veinte">
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/MESINICIO/field[@name='MESINICIO']/."/>
			<!--<xsl:with-param name="claSel">select110i</xsl:with-param>-->
			<xsl:with-param name="claSel">medio</xsl:with-param>
		</xsl:call-template>&nbsp;
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/ANNOINICIO/field[@name='ANNOINICIO']/."/>
			<!--<xsl:with-param name="claSel">select80i</xsl:with-param>-->
			<xsl:with-param name="claSel">medio</xsl:with-param>
		</xsl:call-template>&nbsp;
	</td>
	<td class="cinco">&nbsp;</td>

	<!-- Desplegable Nivel Categorias (IDCATEGORIA) -->
	<td class="labelRight veinte">
		<xsl:value-of select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDCATEGORIA']/@label"/>:&nbsp;
	</td>
	<td class="datosLeft">
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDCATEGORIA']/."/>
			<xsl:with-param name="deshabilitado">
				<xsl:if test="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDCATEGORIA']/@disabled = 'disabled'">disabled</xsl:if>
			</xsl:with-param>
			<xsl:with-param name="claSel">largo</xsl:with-param>
		</xsl:call-template>
	</td>
	<td class="cinco">&nbsp;</td>
</tr>

<tr class="sinLinea">
	<!-- Desplegable Empresas Cliente (IDEMPRESA) -->
	<td class="labelRight veinte">
		<xsl:value-of select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDEMPRESA']/@label"/>:&nbsp;
	</td>
	<td class="datosLeft">
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDEMPRESA']/."/>
			<xsl:with-param name="onChange">ListaCentrosDeEmpresa(this.id,this.value);</xsl:with-param>
		</xsl:call-template>
	</td>
	<td class="cinco">&nbsp;</td>

	<!-- Desplegable Final (MESFINAL y ANNOFINAL) -->
	<td class="labelRight veinte">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='final']/node()"/>:&nbsp;
	</td>
	<td class="datosLeft">
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/MESFINAL/field[@name='MESFINAL']/."/>
			<!--<xsl:with-param name="claSel">select110i</xsl:with-param>-->
			<xsl:with-param name="claSel">medio</xsl:with-param>
		</xsl:call-template>&nbsp;
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/ANNOFINAL/field[@name='ANNOFINAL']/."/>
			<!--<xsl:with-param name="claSel">select80i</xsl:with-param>-->
			<xsl:with-param name="claSel">medio</xsl:with-param>
		</xsl:call-template>
	</td>
	<td class="cinco">&nbsp;</td>

	<!-- Desplegable Nivel Familias (IDFAMILIA) -->
	<td class="labelRight veinte">
		<xsl:value-of select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDFAMILIA']/@label"/>:&nbsp;
	</td>
	<td class="datosLeft">
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDFAMILIA']/."/>
			<xsl:with-param name="deshabilitado">
				<xsl:if test="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDFAMILIA']/@disabled = 'disabled'">disabled</xsl:if>
			</xsl:with-param>
			<xsl:with-param name="claSel">largo</xsl:with-param>
		</xsl:call-template>
	</td>
	<td class="cinco">&nbsp;</td>
</tr>

<tr class="sinLinea">
	<!-- Celda vacia -->
	<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='centros_cliente']/node()"/>:&nbsp;</td>
	<td class="datosLeft"><select id="IDCENTRO" name="IDCENTRO" disabled="disabled" class="seleccion"/></td>
	<td>&nbsp;</td>

	<!-- Desplegable Proveedores (IDEMPRESA2) -->
	<td class="labelRight">
		<xsl:value-of select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDEMPRESA2']/@label"/>:&nbsp;
	</td>
	<td class="datosLeft">
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDEMPRESA2']/."/>
		</xsl:call-template>
	</td>
	<td class="cinco">&nbsp;</td>

	<!-- Desplegable Nivel Subfamilias (IDSUBFAMILIA) -->
	<td class="labelRight veinte">
		<xsl:value-of select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDSUBFAMILIA']/@label"/>:&nbsp;
	</td>
	<td class="datosLeft">
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDSUBFAMILIA']/."/>
			<xsl:with-param name="deshabilitado">
				<xsl:if test="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDSUBFAMILIA']/@disabled = 'disabled'">disabled</xsl:if>
			</xsl:with-param>
			<xsl:with-param name="claSel">largo</xsl:with-param>
		</xsl:call-template>
	</td>
	<td class="cinco">&nbsp;</td>
</tr>

<tr class="sinLinea">
	<!-- Buscador por texto -->
	<td class="labelRight veinte">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>:&nbsp;
	</td>
	<td class="datosLeft">
		<input type="text" name="TEXTO" id="TEXTO">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/TEXTO"/></xsl:attribute>
		</input>
	</td>
	<td class="cinco">&nbsp;</td>

	<!-- Celda vacia -->
	<td class="labelRight">&nbsp;</td>
	<td class="datosLeft">&nbsp;</td>
	<td>&nbsp;</td>

	<!-- Desplegable Nivel Grupos (IDGRUPO) -->
	<td class="labelRight veinte">
		<xsl:value-of select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDGRUPO']/@label"/>:&nbsp;
	</td>
	<td class="datosLeft">
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDGRUPO']/."/>
			<xsl:with-param name="deshabilitado">
				<xsl:if test="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDGRUPO']/@disabled = 'disabled'">disabled</xsl:if>
			</xsl:with-param>
			<xsl:with-param name="claSel">largo</xsl:with-param>
		</xsl:call-template>
	</td>
	<td class="cinco">&nbsp;</td>
</tr>

<tr class="sinLinea">
	<!-- Desplegable Agrupacion Horizontal (AGRUPARPOR_HOR) -->
	<td class="labelRight veinte">
		<xsl:value-of select="/EIS_XML/RESULTADOS/AGRUPARPOR_HOR/field/@label"/>:&nbsp;
	</td>
	<td class="datosLeft">
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/AGRUPARPOR_HOR/field[@name='AGRUPARPOR_HOR']/."/>
		</xsl:call-template>
	</td>
	<td class="cinco">&nbsp;</td>

	<!-- Desplegable Agrupacion Vertical (AGRUPARPOR_VER) -->
	<td class="labelRight veinte">
		<xsl:value-of select="/EIS_XML/RESULTADOS/AGRUPARPOR_VER/field/@label"/>:&nbsp;
	</td>
	<td class="datosLeft">
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/AGRUPARPOR_VER/field[@name='AGRUPARPOR_VER']/."/>
		</xsl:call-template>
	</td>
	<td class="cinco">&nbsp;</td>

	<!-- Desplegable Nivel ProdEstandar (IDPRODUCTOESTANDAR) -->
	<td class="labelRight veinte">
		<xsl:value-of select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDPRODUCTOESTANDAR']/@label"/>:&nbsp;
	</td>
	<td class="datosLeft">
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDPRODUCTOESTANDAR']/."/>
			<xsl:with-param name="deshabilitado">
				<xsl:if test="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDPRODUCTOESTANDAR']/@disabled = 'disabled'">disabled</xsl:if>
			</xsl:with-param>
			<xsl:with-param name="claSel">largo</xsl:with-param>
		</xsl:call-template>
	</td>
	<td class="cinco">&nbsp;</td>
</tr>
</xsl:template>

<!-- Formulario MatrizEIS - Desplegables Empresa (CdC) -->
<xsl:template name="EISMatriz_Form_Empresa">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:value-of select="/EIS_XML/LANG"/>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<tr class="sinLinea">
	<!-- Desplegable Cuadro de Mando (IDCUADROMANDO) -->
	<td class="labelRight veinte">
		<xsl:value-of select="/EIS_XML/RESULTADOS/FILTROS/field[@name='INDICADOR']/@label"/>:
	</td>
	<td class="datosLeft">
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/FILTROS/field[@name='INDICADOR']/."/>
		</xsl:call-template>
	</td>
	<td class="cinco">&nbsp;</td>

	<!-- Desplegable Inicio (MESINICIO y ANNOINICIO) -->
	<td class="labelRight veinte">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='inicio']/node()"/>:&nbsp;
	</td>
	<td class="datosLeft veinte">
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/MESINICIO/field[@name='MESINICIO']/."/>
			<xsl:with-param name="claSel">select110i</xsl:with-param>
		</xsl:call-template>&nbsp;
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/ANNOINICIO/field[@name='ANNOINICIO']/."/>
			<xsl:with-param name="claSel">select80i</xsl:with-param>
		</xsl:call-template>&nbsp;
	</td>
	<td class="cinco">&nbsp;</td>

	<!-- Desplegable Nivel Categoria (IDCATEGORIA en 5 niveles) o Familia (IDFAMILIA en 3 niveles) -->
	<xsl:choose>
	<xsl:when test="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDCATEGORIA']">
		<td class="labelRight veinte">
			<xsl:value-of select="/EIS_XML/RESULTADOS/FILTROS/NOMBRESNIVELES/NIVEL1"/>:&nbsp;
		</td>
		<td class="datosLeft">
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDCATEGORIA']/."/>
				<xsl:with-param name="deshabilitado">
					<xsl:if test="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDCATEGORIA']/@disabled = 'disabled'">disabled</xsl:if>
				</xsl:with-param>
<!--
				<xsl:with-param name="onChange">
					ListaNivel(this.value,'FAM');
				</xsl:with-param>
-->
				<xsl:with-param name="claSel">largo</xsl:with-param>
			</xsl:call-template>
		</td>
		<td class="cinco">&nbsp;</td>
        </xsl:when>
	<xsl:when test="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDFAMILIA']">
		<td class="labelRight veinte">
			<xsl:value-of select="/EIS_XML/RESULTADOS/FILTROS/NOMBRESNIVELES/NIVEL2"/>:&nbsp;
		</td>
		<td class="datosLeft">
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDFAMILIA']/."/>
				<xsl:with-param name="deshabilitado">
					<xsl:if test="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDFAMILIA']/@disabled = 'disabled'">disabled</xsl:if>
				</xsl:with-param>
<!--
				<xsl:with-param name="onChange">
					ListaNivel(this.value,'SF');
				</xsl:with-param>
-->
				<xsl:with-param name="claSel">largo</xsl:with-param>
			</xsl:call-template>
		</td>
		<td class="cinco">&nbsp;</td>
	</xsl:when>
	</xsl:choose>
</tr>

<tr class="sinLinea">
	<td class="labelRight">
		<xsl:value-of select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDCENTRO']/@label"/>:&nbsp;
	</td>
	<td class="datosLeft">
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDCENTRO']/."/>
		</xsl:call-template>
	</td>
	<td class="cinco">&nbsp;</td>

	<!-- Desplegable Final (MESFINAL y ANNOFINAL) -->
	<td class="labelRight">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='final']/node()"/>:&nbsp;
	</td>
	<td class="datosLeft">
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/MESFINAL/field[@name='MESFINAL']/."/>
			<xsl:with-param name="claSel">select110i</xsl:with-param>
		</xsl:call-template>&nbsp;
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/ANNOFINAL/field[@name='ANNOFINAL']/."/>
			<xsl:with-param name="claSel">select80i</xsl:with-param>
		</xsl:call-template>
	</td>
	<td>&nbsp;</td>

	<!-- Desplegable Nivel Familias (IDFAMILIA en 5 niveles) o Subfamilia (IDSUBFAMILIA en 3 niveles) -->
	<xsl:choose>
	<xsl:when test="/EIS_XML/RESULTADOS/FILTROS/field/@name='IDCATEGORIA' and /EIS_XML/RESULTADOS/FILTROS/field[@name='IDFAMILIA']">
		<td class="labelRight">
			<xsl:value-of select="/EIS_XML/RESULTADOS/FILTROS/NOMBRESNIVELES/NIVEL2"/>:&nbsp;
		</td>
		<td class="datosLeft">
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDFAMILIA']/."/>
				<xsl:with-param name="deshabilitado">
					<xsl:if test="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDFAMILIA']/@disabled = 'disabled'">disabled</xsl:if>
				</xsl:with-param>
				<xsl:with-param name="claSel">largo</xsl:with-param>
			</xsl:call-template>
		</td>
		<td>&nbsp;</td>
	</xsl:when>
	<xsl:when test="not(/EIS_XML/RESULTADOS/FILTROS/field/@name='IDCATEGORIA') and /EIS_XML/RESULTADOS/FILTROS/field[@name='IDSUBFAMILIA']">
		<td class="labelRight">
			<xsl:value-of select="/EIS_XML/RESULTADOS/FILTROS/NOMBRESNIVELES/NIVEL3"/>:&nbsp;
		</td>
		<td class="datosLeft">
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDSUBFAMILIA']/."/>
				<xsl:with-param name="deshabilitado">
					<xsl:if test="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDSUBFAMILIA']/@disabled = 'disabled'">disabled</xsl:if>
				</xsl:with-param>
				<xsl:with-param name="claSel">largo</xsl:with-param>
			</xsl:call-template>
		</td>
		<td>&nbsp;</td>
	</xsl:when>
	</xsl:choose>
</tr>

<tr class="sinLinea">
	<!-- Desplegable Proveedores (IDEMPRESA2) -->
	<td class="labelRight">
		<xsl:value-of select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDEMPRESA2']/@label"/>:&nbsp;
	</td>
	<td class="datosLeft">
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDEMPRESA2']/."/>
		</xsl:call-template>
	</td>
	<td>&nbsp;</td>

	<!-- Buscador por texto -->
	<td class="labelRight">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>:&nbsp;
	</td>
	<td class="datosLeft">
		<input type="text" name="TEXTO" id="TEXTO">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/RESULTADOS/VALORES/TEXTO"/></xsl:attribute>
		</input>
	</td>
	<td>&nbsp;</td>

	<!-- Desplegable Subfamilia (IDSUBFAMILIA en 5 niveles) o Producto Estandar (IDPRODUCTOESTANDAR en 3 niveles) -->
	<xsl:choose>
	<xsl:when test="/EIS_XML/RESULTADOS/FILTROS/field/@name='IDCATEGORIA' and /EIS_XML/RESULTADOS/FILTROS/field[@name='IDSUBFAMILIA']">
		<td class="labelRight">
			<xsl:value-of select="/EIS_XML/RESULTADOS/FILTROS/NOMBRESNIVELES/NIVEL3"/>:&nbsp;
		</td>
		<td class="datosLeft">
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDSUBFAMILIA']/."/>
				<xsl:with-param name="deshabilitado">
					<xsl:if test="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDSUBFAMILIA']/@disabled = 'disabled'">disabled</xsl:if>
				</xsl:with-param>
				<xsl:with-param name="claSel">largo</xsl:with-param>
			</xsl:call-template>
		</td>
		<td>&nbsp;</td>
	</xsl:when>
	<xsl:when test="not(/EIS_XML/RESULTADOS/FILTROS/field/@name='IDCATEGORIA') and /EIS_XML/RESULTADOS/FILTROS/field/@name='IDPRODUCTOESTANDAR'">
		<td class="labelRight">
			<xsl:value-of select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDPRODUCTOESTANDAR']/@label"/>:&nbsp;
		</td>
		<td class="datosLeft">
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDPRODUCTOESTANDAR']/."/>
				<xsl:with-param name="deshabilitado">
					<xsl:if test="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDPRODUCTOESTANDAR']/@disabled = 'disabled'">disabled</xsl:if>
				</xsl:with-param>
				<xsl:with-param name="claSel">largo</xsl:with-param>
			</xsl:call-template>
		</td>
		<td>&nbsp;</td>	
	</xsl:when>
	</xsl:choose>
</tr>

<tr class="sinLinea">
	<!-- Desplegable Agrupacion Horizontal (AGRUPARPOR_HOR) -->
	<td class="labelRight">
		<xsl:value-of select="/EIS_XML/RESULTADOS/AGRUPARPOR_HOR/field/@label"/>:&nbsp;
	</td>
	<td class="datosLeft">
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/AGRUPARPOR_HOR/field[@name='AGRUPARPOR_HOR']/."/>
		</xsl:call-template>
	</td>
	<td>&nbsp;</td>

	<!-- Desplegable Agrupacion Vertical (AGRUPARPOR_VER) -->
	<td class="labelRight">
		<xsl:value-of select="/EIS_XML/RESULTADOS/AGRUPARPOR_VER/field/@label"/>:&nbsp;
	</td>
	<td class="datosLeft">
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/AGRUPARPOR_VER/field[@name='AGRUPARPOR_VER']/."/>
		</xsl:call-template>
	</td>
	<td>&nbsp;</td>

	<!-- Desplegable Nivel Grupos (IDGRUPO en 5 niveles), si existe -->
	<xsl:choose>
	<xsl:when test="/EIS_XML/RESULTADOS/FILTROS/field/@name='IDCATEGORIA' and /EIS_XML/RESULTADOS/FILTROS/field/@name='IDGRUPO'">
		<td class="labelRight">
			<xsl:value-of select="/EIS_XML/RESULTADOS/FILTROS/NOMBRESNIVELES/NIVEL4"/>:&nbsp;
		</td>
		<td class="datosLeft">
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDGRUPO']/."/>
				<xsl:with-param name="deshabilitado">
					<xsl:if test="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDGRUPO']/@disabled = 'disabled'">disabled</xsl:if>
				</xsl:with-param>
				<xsl:with-param name="claSel">largo</xsl:with-param>
			</xsl:call-template>
		</td>
		<td>&nbsp;</td>
	</xsl:when>
	<xsl:otherwise>
		<td colspan="3">&nbsp;</td>
	</xsl:otherwise>
	</xsl:choose>
</tr>

<xsl:if test="/EIS_XML/RESULTADOS/FILTROS/field/@name='IDCATEGORIA' and /EIS_XML/RESULTADOS/FILTROS/field/@name='IDPRODUCTOESTANDAR'">
<tr class="sinLinea">
	<td colspan="3">&nbsp;</td>
	<td colspan="3">&nbsp;</td>

	<!-- Desplegable Nivel ProdEstandar (IDPRODUCTOESTANDAR en 5 niveles), si existe -->
	<td class="labelRight veinte">
		<xsl:value-of select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDPRODUCTOESTANDAR']/@label"/>:&nbsp;
	</td>
	<td class="datosLeft">
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDPRODUCTOESTANDAR']/."/>
			<xsl:with-param name="deshabilitado">
				<xsl:if test="/EIS_XML/RESULTADOS/FILTROS/field[@name='IDPRODUCTOESTANDAR']/@disabled = 'disabled'">disabled</xsl:if>
			</xsl:with-param>
			<xsl:with-param name="claSel">largo</xsl:with-param>
		</xsl:call-template>
	</td>
	<td class="cinco">&nbsp;</td>
</tr>
</xsl:if>
</xsl:template>
</xsl:stylesheet>
