<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Cuadro mensual del EIS
	Ultima revision: ET 20dic21 09:00 EISDatos_201221.js
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
		<xsl:value-of select="/EIS_XML/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='eis']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->
	<link rel="stylesheet" href="http://www.newco.dev.br/General/estiloEISPrint.css" type="text/css" media="print" />
	<meta Http-Equiv="Cache-Control" Content="no-cache"/>

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"/>
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"/>
	<script type="text/javascript" src="http://www.newco.dev.br/General/Chart.bundle.min.2.9.3.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/EIS/EISDatos_201221.js"/>
	<!--
	<script type="text/javascript" src="http://www.google.com/jsapi"/>

	<script type="text/javascript">
		google.load("visualization", "1", {packages:["corechart"]});
	</script>
	-->

	<script type="text/javascript">
		var sepCSV			=';';		//27feb20
		var sepTextoCSV		='';		//27feb20
		var saltoLineaCSV	='\r\n';	//27feb20

		var FiltroSQL		= "<xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/SQL"/>";
		var IDEmpresaDelUsuario	= '<xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDEMPRESADELUSUARIO"/>';
		var userRol		= '<xsl:value-of select="/EIS_XML/EISANALISIS/ROL"/>';
		var userDerechos	= '<xsl:value-of select="/EIS_XML/EISANALISIS/DERECHOS"/>';
		var txtConcepto		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='concepto']/node()"/>';
		var txtValidacionAnnos	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='eis_validacion_annos']/node()"/>';

		<!-- Valores de formulario para obtener resultados -->
		var IDUsuario		= '<xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/US_ID"/>';
		var IDSesion		= '<xsl:value-of select="/EIS_XML/SES_ID"/>';
		var IDCuadro		= '<xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDCUADRO"/>';
		var Cuadro		= '<xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/CUADRO"/>';
		var Anno		= '<xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/ANNO"/>';
		var IDControlSeleccion	= '<xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDCONTROLSELECCION"/>';
		var IDEmpresa		= '<xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDEMPRESA"/>';
		var IDCentro		= '<xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDCENTRO"/>';
		var IDUsuarioSel	= '<xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDUSUARIOSEL"/>';
		var IDEmpresa2		= '<xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDEMPRESA2"/>';
		var IDCentro2		= '<xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDCENTRO2"/>';
		var IDProducto		= '<xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDPRODUCTO"/>';
		var IDGrupo		= '<xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDGRUPO"/>';
		var IDSubfamilia	= '<xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDSUBFAMILIA"/>';
		var IDFamilia		= '<xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDFAMILIA"/>';
		var IDCategoria		= '<xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDCATEGORIA"/>';
		var IDEstado		= '<xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDESTADO"/>';
		var Referencia		= '<xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/REFERENCIA"/>';
		var Codigo		= '<xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/CODIGO"/>';
		var IDResultados	= '<xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDRESULTADOS"/>';
		var AgruparPor		= '<xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/AGRUPARPOR"/>';
		var IDRatio		= '<xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDRATIO"/>';
		<!-- FIN Valores de formulario -->

		<!-- Lista Meses de la tabla -->
		var ListaMeses		= [];
		<xsl:for-each select="/EIS_XML/EISANALISIS/DATOSEIS/LISTAMESES/MES">
			items			= [];
			items['nombreMes']	= '<xsl:value-of select="NOMBRE"/>';
			items['mes']		= '<xsl:value-of select="MES"/>';
			ListaMeses.push(items);
		</xsl:for-each>
		<!-- FIN Lista Meses de la tabla -->

		<!-- Resultados de la consulta para mostrar tabla, grafico, etc. -->
		var ResultadosTabla	= {};
		var IDIndicador		= '<xsl:value-of select="/EIS_XML/EISANALISIS/DATOSEIS/CUADRODEMANDO/INDICADOR/IDINDICADOR"/>';

		var ConvertirPorcentaje;
		<xsl:choose>
			<xsl:when test="/EIS_XML/EISANALISIS/CONVERTIR_PORCENTAJE">ConvertirPorcentaje = 'S';</xsl:when>
			<xsl:otherwise>ConvertirPorcentaje = 'N';</xsl:otherwise>
		</xsl:choose>

		var mostrarFilaTotal;
		<xsl:choose>
			<xsl:when test="/EIS_XML/EISANALISIS/UTILIZAR_FILA_TOTALES_XML">mostrarFilaTotal = 'S';</xsl:when>
			<xsl:otherwise>mostrarFilaTotal = 'N';</xsl:otherwise>
		</xsl:choose>

		<xsl:for-each select="/EIS_XML/EISANALISIS/DATOSEIS/CUADRODEMANDO/INDICADOR">
			ResultadosTabla['INDICADOR|<xsl:value-of select="IDINDICADOR"/>']= '<xsl:value-of select="NOMBREINDICADOR"/>';
			ResultadosTabla['MAX_LINEAS_<xsl:value-of select="IDINDICADOR"/>']= '<xsl:value-of select="MAXLINEAS"/>';

			<xsl:for-each select="GRUPO">
				ResultadosTabla['GRUPO|<xsl:value-of select="../IDINDICADOR"/>|<xsl:value-of select="IDGRUPO"/>|<xsl:value-of select="LINEA"/>'] = '<xsl:value-of select="NOMBREGRUPO"/>';

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
			</xsl:for-each>
		</xsl:for-each>
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
</head>
<body>
	<xsl:attribute name="onload">
    	<xsl:choose>
        <xsl:when test="/EIS_XML/CP_EMPRESA2 != ''">TodasLineasActivas(); TablaEISAjax();</xsl:when>
        <xsl:otherwise>TodasLineasActivas();</xsl:otherwise>
        </xsl:choose>
    </xsl:attribute>

	<!--	Comprueba si la sesion ha caducado	-->
	<xsl:choose>
	<xsl:when test="//SESION_CADUCADA">
		<xsl:apply-templates select="//SESION_CADUCADA"/>
	</xsl:when>
	<xsl:otherwise>
		<!-- Cabecera -->
		<!--idioma-->
		<xsl:variable name="lang">
			<xsl:value-of select="/EIS_XML/LANG"/>
		</xsl:variable>
		<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
		<!--idioma fin-->

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eis']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='totales_mensuales']/node()"/></span>
				<span class="CompletarTitulo">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizado']/node()"/>: <xsl:value-of select="/EIS_XML/EISANALISIS/ACTUALIZACION"/>
				</span>
			</p>
			<p class="TituloPagina">
				<span id="NombreIndicador"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/CUADRO"/></span>&nbsp;
				<span class="CompletarTitulo" style="width:300px;">
					<!--27feb20	<a class="btnNormal" href="javascript:TablaEISAjaxExcel();" style="text-decoration:none;" title="Descargar Fichero Excel">-->
					<a class="btnNormal" href="javascript:listadoExcel();" style="text-decoration:none;" title="Descargar Fichero Excel">
						<img id="botonExcel" alt="Descargar Excel" src="http://www.newco.dev.br/images/iconoExcel.gif"/>
					</a>&nbsp;
					<a class="btnNormal" href="javascript:Imprimir();"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
				</span>
			</p>
		</div>
		<br/>

		<form method="post" action="EISDatos.xsql" name="formEIS"><!--?xml-stylesheet=none-->
			<!--	Objetos ocultos con los datos necesarios para la matriz javascript	-->
			<xsl:choose>
			<xsl:when test="/EIS_XML/EISANALISIS/EISSIMPLIFICADO">
				<p class="titlePage" align="center"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/CUADRO"/></p>
			</xsl:when>
			<xsl:otherwise>

				<xsl:choose>
				<xsl:when test="/EIS_XML/EISANALISIS/DERECHOS = 'MVM' or /EIS_XML/EISANALISIS/VALORES/IDCONTROLSELECCION!=''">
					<xsl:call-template name="EIS_Form_Administrador"/>
				</xsl:when>
				<xsl:when test="/EIS_XML/EISANALISIS/ROL = 'COMPRADOR'">
					<xsl:call-template name="EIS_Form_Cliente"/>
				</xsl:when>
				<xsl:when test="/EIS_XML/EISANALISIS/ROL = 'VENDEDOR'">
					<xsl:call-template name="EIS_Form_Proveedor"/>
				</xsl:when>
				</xsl:choose>


				<!-- Botones Tabla Datos -->
            	<div style="background:#fff;float:left;">
				<!--
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
                <xsl:when test="not (/EIS_XML/EISANALISIS/DATOSEIS/CUADRODEMANDO/INDICADOR/GRUPO/ROW/TOTAL)"></xsl:when>
                <xsl:otherwise>
                	<td>
                    <a href="javascript:VerDatos();" style="text-decoration:none;display:none;" title="Ver datos EIS" id="datosEIS">
                        <img id="botonEIS" src="http://www.newco.dev.br/images/botonEIS1.gif" alt="Ver datos EIS"/>
                    </a>
                    </td>
                    <td>
                    <a href="javascript:VerGrafico();" style="text-decoration:none;" title="Ver GrÃ¡fico" id="graficoEIS">
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
                </td>
				<td>&nbsp;</td>
				</tr>
				</table>
            	</div>
				-->
				
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

				<xsl:if test="/EIS_XML/EISANALISIS/DERECHOS = 'MVM' or /EIS_XML/EISANALISIS/DERECHOS = 'MVMB'">
					<!-- Desplegable TOP -->
					<div style="background:#fff;padding:5px 10px 0 20px;float:left;">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='TOP']/node()"/>:</label>&nbsp;
						<select name="TOP" id="TOP">
							<option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></option>
							<option value="5">5</option>
							<option value="10">10</option>
							<option value="15">15</option>
							<option value="20">20</option>
						</select>
					</div>
				</xsl:if>

				<!-- Formulario que guarda la seleccion escogida -->
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
			</div><!--fin de botones-->
			</xsl:otherwise><!--fin de choose inicial-->
			</xsl:choose>

			<br/>
			<br/>
			<xsl:choose>
			<xsl:when test="not(/EIS_XML/EISANALISIS/DATOSEIS/CUADRODEMANDO/INDICADOR/GRUPO/ROW/TOTAL)">
				<br/>
				<center><xsl:value-of select="document($doc)/translation/texts/item[@name='la_consulta_no_ha_devuelto_datos']/node()"/></center>
			</xsl:when>
			<xsl:otherwise>
			<div class="divLeft">
				<table id="TablaDatos" class="tablaEIS" border="0" >
					<!--	Esta tabla se crea dinamicamente desde el javascript	-->
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
							<!--<div id="graficoGoogle" style="width:100%; height:550px; border:0px solid red;"></div>-->
    						<div class="container" style="width:1400px;height:600px;">
        						<canvas id="cvGrafico"></canvas>
    						</div>
						</td>
					</tr>
				</table>
			</div><!--fin divLeft-->

			<br /><br /><br />
<!--
			<div class="divLeft">
				<div class="divLeft40nopa">&nbsp;</div>
				<div class="divLeft20">
					<div class="boton">
						<a href="javascript:Imprimir();"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>
					</div><!- -fin de boton- ->
				</div>
				<br /><br />
			</div><!- -fin de divLeft-->
			</xsl:otherwise>
			</xsl:choose>
		</form>

	<!--form para dibujar la tabla-->
	<!--	Guardamos los valores originales en campos ocultos	-->
	<form method="post" name="hiddens" id="hiddens">

		<!--fin de botones-->
	</form>
	</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>

<!-- Formulario Desplegables Proveedores -->
<xsl:template name="EIS_Form_Proveedor">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:value-of select="/EIS_XML/LANG"/>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<table class="buscador">
<!--<table class="infoTable selectEis" border="0">-->
<!--	<thead>
	<tr>
		<th colspan="9">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='eis']/node()"/>&nbsp;-&nbsp;<xsl:value-of select="/EIS_XML/EISANALISIS/CENTRO"/>&nbsp;(<xsl:value-of select="/EIS_XML/EISANALISIS/USUARIO"/>)&nbsp;-
			<span id="NombreIndicador"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/CUADRO"/></span>
			(<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizado']/node()"/>: <xsl:value-of select="/EIS_XML/EISANALISIS/ACTUALIZACION"/>) - <xsl:value-of select="document($doc)/translation/texts/item[@name='totales_mensuales']/node()"/>
			<a href="javascript:TablaEISAjaxExcel();" style="text-decoration:none;" title="Descargar Fichero Excel">
				<img id="botonExcel" alt="Descargar Excel" src="http://www.newco.dev.br/images/iconoExcel.gif"/>
			</a>
		</th>
	</tr>
	</thead>
-->
	<tr class="sinLinea">
		<!-- Desplegable Cuadro de Mando (IDCUADROMANDO) -->
		<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field/@name='IDCUADROMANDO'">
			<td class="labelRight quince">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDCUADROMANDO']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft quince">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDCUADROMANDO']/."/>
				</xsl:call-template>
			</td>
			<td class="cinco">&nbsp;</td>
		</xsl:if>
		<!-- Desplegable Centros Proveedor (IDCENTRO) -->
		<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field/@name='IDCENTRO'">
			<td class="labelRight quince">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDCENTRO']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft quince">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDCENTRO']/."/>
					<xsl:with-param name="style">width:450px;</xsl:with-param>
				</xsl:call-template>
			</td>
			<td class="cinco">&nbsp;</td>
		</xsl:if>
		<!-- Desplegable Lista Clientes (IDEMPRESA2) -->
		<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field/@name='IDEMPRESA2'">
			<td class="labelRight quince">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDEMPRESA2']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft quince">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDEMPRESA2']/."/>
					<xsl:with-param name="onChange">
						ListaCentrosDeCliente(this.id,this.value);
					</xsl:with-param>
				</xsl:call-template>
			</td>
			<td class="cinco">&nbsp;</td>
		</xsl:if>
	</tr>

	<tr class="sinLinea">
		<!-- Desplegable Anno (ANNO) -->
		<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field/@name='ANNO'">
			<td class="labelRight quince">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/field[@name='ANNO']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft quince">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='ANNO']/."/>
				</xsl:call-template>
			</td>
			<td class="cinco">&nbsp;</td>
		</xsl:if>
		<!-- Desplegable Estado (IDESTADO) -->
		<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field/@name='IDESTADO'">
			<td class="labelRight quince">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDESTADO']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft quince">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDESTADO']/."/>
				</xsl:call-template>
			</td>
			<td class="cinco">&nbsp;</td>
		</xsl:if>
		<!-- Desplegable Centros de Cliente (IDCENTRO2). Se genera por peticion ajax una vez se elige IDEMPRESA2-->
		<td class="labelRight quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='centros_cliente']/node()"/>:&nbsp;</td>
		<td class="datosLeft quince"><select id="IDCENTRO2" name="IDCENTRO2" disabled="disabled"/></td>
		<td class="cinco">&nbsp;</td>
	</tr>

	<tr class="sinLinea">
		<td class="labelRight  ">
			<xsl:value-of select="/EIS_XML/EISANALISIS/AGRUPARPOR/field/@label"/>:&nbsp;
		</td>
		<td class="datosLeft">
			<xsl:call-template name="desplegable"><xsl:with-param name="path" select="/EIS_XML/EISANALISIS/AGRUPARPOR/field"/></xsl:call-template>
		</td>
		<td class="cinco">&nbsp;</td>
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/>:&nbsp;</td>
		<td class="datosLeft">
			<input type="text" name="CODIGO" id="CODIGO">
				<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/CODIGO"/></xsl:attribute>
			</input>
		</td>
		<td class="cinco">&nbsp;</td>
		<td class="labelRight  "><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:&nbsp;</td>
		<td class="datosLeft">
			<input type="text" name="REFERENCIA" id="REFERENCIA">
				<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/REFERENCIA"/></xsl:attribute>
			</input>
		</td>
		<td class="cinco">&nbsp;</td>
	</tr>

	<tr class="sinLinea">
		<td class="labelRight">
			<xsl:value-of select="/EIS_XML/EISANALISIS/IDRESULTADOS/field/@label"/>:&nbsp;
		</td>
		<td class="datosLeft">
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/IDRESULTADOS/field"/>
				<xsl:with-param name="onChange">HabilitarRatios(document.forms[0],'RATIO','<xsl:value-of select="/EIS_XML/EISANALISIS/IDRESULTADOS/field/@name"/>','<xsl:value-of select="/EIS_XML/EISANALISIS/IDRATIO/field/@name"/>');</xsl:with-param>
			</xsl:call-template>
		</td>
		<td class="cinco">&nbsp;</td>
		<td class="labelRight">
			<xsl:value-of select="/EIS_XML/EISANALISIS/IDRATIO/field/@label"/>:&nbsp;
		</td>
		<td class="datosLeft">
			<xsl:variable name="vDeshabilitado">
				<xsl:if test="/EIS_XML/EISANALISIS/IDRESULTADOS/field/@current!='RATIO'">
					disabled
				</xsl:if>
			</xsl:variable>
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/IDRATIO/field"/>
				<xsl:with-param name="deshabilitado"><xsl:value-of select="$vDeshabilitado"/></xsl:with-param>
			</xsl:call-template>
		</td>
		<td class="cinco">&nbsp;</td>
		<td class="labelRight veinte">&nbsp;</td>
		<td class="datosLeft">&nbsp;</td>
		<td class="cinco">&nbsp;</td>
	</tr>

	<tr class="sinLinea">
		<!-- Boton Envio Formulario Via Ajax -->
		<td colspan="6">&nbsp;</td>
		<td>
			<!--<div class="botonLargoAma" id="MostrarCuadro">-->
				<a class="btnDestacado" id="MostrarCuadro" href="javascript:TablaEISAjax();"><xsl:value-of select="document($doc)/translation/texts/item[@name='mostrar']/node()"/></a>
			<!--</div>-->
			<div id="waitBox" style="display:none;"><img src="http://www.newco.dev.br/images/loading.gif"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cargando']/node()"/>...</div>
		</td>
		 <!-- Fin Boton Envio Formulario Via Ajax -->
		<td colspan="2">&nbsp;</td>
	</tr>
</table>
</xsl:template>

<!-- Formulario Desplegables Clientes -->
<xsl:template name="EIS_Form_Cliente">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:value-of select="/EIS_XML/LANG"/>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>

<!--idioma fin-->
<table class="buscador">
<!--<table class="infoTable selectEis" border="0">-->
<!--	<thead>
	<tr>
		<th colspan="9">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='eis']/node()"/>&nbsp;-&nbsp;<xsl:value-of select="/EIS_XML/EISANALISIS/CENTRO"/>&nbsp;(<xsl:value-of select="/EIS_XML/EISANALISIS/USUARIO"/>)&nbsp;-
			<span id="NombreIndicador"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/CUADRO"/></span>
			(<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizado']/node()"/>: <xsl:value-of select="/EIS_XML/EISANALISIS/ACTUALIZACION"/>) - <xsl:value-of select="document($doc)/translation/texts/item[@name='totales_mensuales']/node()"/>
			<a href="javascript:TablaEISAjaxExcel();" style="text-decoration:none;" title="Descargar Fichero Excel">
				<img id="botonExcel" alt="Descargar Excel" src="http://www.newco.dev.br/images/iconoExcel.gif"/>
			</a>
		</th>
	</tr>
	</thead>-->

	<tr class="sinLinea">
		<!-- Desplegable Cuadro de Mando (IDCUADROMANDO) -->
		<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field/@name='IDCUADROMANDO'">
			<td class="labelRight quince">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDCUADROMANDO']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft quince">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDCUADROMANDO']/."/>
				</xsl:call-template>
			</td>
			<td>&nbsp;</td>
		</xsl:if>
		<!-- Desplegable Lista Clientes (IDEMPRESA2) -->
		<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field/@name='IDEMPRESA2'">
			<td class="labelRight quince">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDEMPRESA2']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft quince">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDEMPRESA2']/."/>
					<xsl:with-param name="onChange">
						ListaCentrosDeCliente(this.id,this.value);
					</xsl:with-param>
					<xsl:with-param name="claSel">seleccion</xsl:with-param>
				</xsl:call-template>
				<!--<span id="borrarSEL_IDEMPRESA2" style="display:none;">&nbsp;<a href="javascript:borrarSeleccion('IDEMPRESA2');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></span>-->
			</td>
			<td>&nbsp;</td>
		</xsl:if>
		<!-- Desplegable Nivel Categoria (5 niveles) o Familia (3 niveles) -->
		<xsl:choose>
		<xsl:when test="/EIS_XML/EISANALISIS/FILTROS/field/@name='IDCATEGORIA'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/NOMBRESNIVELES/NIVEL1"/>:&nbsp;
			</td>
			<td class="datosLeft quince">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDCATEGORIA']/."/>
					<xsl:with-param name="deshabilitado">
						<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDCATEGORIA']/@disabled = 'disabled'">disabled</xsl:if>
					</xsl:with-param>
					<xsl:with-param name="claSel">largo seleccion</xsl:with-param>
				</xsl:call-template>
				<!--<span id="borrarSEL_IDCATEGORIA" style="display:none;">&nbsp;<a href="javascript:borrarSeleccion('IDCATEGORIA');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></span>-->
			</td>
			<td class="cinco">&nbsp;</td>
		</xsl:when>
		<xsl:when test="/EIS_XML/EISANALISIS/FILTROS/field/@name='IDFAMILIA'">
			<td class="labelRight quince">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/NOMBRESNIVELES/NIVEL2"/>:&nbsp;
			</td>
			<td class="datosLeft quince">

				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDFAMILIA']/."/>
					<xsl:with-param name="deshabilitado">
						<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDFAMILIA']/@disabled = 'disabled'">disabled</xsl:if>
					</xsl:with-param>
					<xsl:with-param name="onChange">
						ListaNivel(this.value,'SF');
					</xsl:with-param>
					<xsl:with-param name="claSel">largo seleccion</xsl:with-param>
				</xsl:call-template>
				<!--<span id="borrarSEL_IDFAMILIA" style="display:none;">&nbsp;<a href="javascript:borrarSeleccion('IDFAMILIA');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></span>-->
			</td>
			<td class="cinco">&nbsp;</td>
		</xsl:when>
		</xsl:choose>
	</tr>

	<tr class="sinLinea">
		<!-- Desplegable Centros Proveedor (IDCENTRO) -->
		<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field/@name='IDCENTRO'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDCENTRO']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDCENTRO']/."/>
					<xsl:with-param name="deshabilitado">
						<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDCENTRO']/@disabled = 'disabled'">disabled</xsl:if>
					</xsl:with-param>
					<xsl:with-param name="claSel">seleccion</xsl:with-param>
					<xsl:with-param name="style">width:450px;</xsl:with-param>
				</xsl:call-template>
				<!--<span id="borrarSEL_IDCENTRO" style="display:none;">&nbsp;<a href="javascript:borrarSeleccion('IDCENTRO');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></span>-->
			</td>
			<td>&nbsp;</td>
		</xsl:if>
		<!-- Desplegable Centros de Cliente (IDCENTRO2). Se genera por peticion ajax una vez se elige IDEMPRESA2-->
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='centros_proveedor']/node()"/>:&nbsp;</td>
		<td class="datosLeft">
			<select id="IDCENTRO2" name="IDCENTRO2" disabled="disabled" class="seleccion"/>
			<!--<span id="borrarSEL_IDCENTRO2" style="display:none;">&nbsp;<a href="javascript:borrarSeleccion('IDCENTRO2');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></span>-->
		</td>
		<td>&nbsp;</td>
		<!-- Desplegable Familia  (5 niveles) o Subfamilia (3 niveles) -->
		<xsl:choose>
		<xsl:when test="/EIS_XML/EISANALISIS/FILTROS/field/@name='IDCATEGORIA' and /EIS_XML/EISANALISIS/FILTROS/field/@name='IDFAMILIA'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/NOMBRESNIVELES/NIVEL2"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDFAMILIA']/."/>
					<xsl:with-param name="deshabilitado">
						<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDFAMILIA']/@disabled = 'disabled'">disabled</xsl:if>
					</xsl:with-param>
					<xsl:with-param name="claSel">largo seleccion</xsl:with-param>
				</xsl:call-template>
				<!--<span id="borrarSEL_IDFAMILIA" style="display:none;">&nbsp;<a href="javascript:borrarSeleccion('IDFAMILIA');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></span>-->
			</td>
			<td>&nbsp;</td>
		</xsl:when>
		<xsl:when test="not(/EIS_XML/EISANALISIS/FILTROS/field/@name='IDCATEGORIA') and /EIS_XML/EISANALISIS/FILTROS/field/@name='IDSUBFAMILIA'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/NOMBRESNIVELES/NIVEL3"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDSUBFAMILIA']/."/>
					<xsl:with-param name="deshabilitado">
						<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDSUBFAMILIA']/@disabled = 'disabled'">disabled</xsl:if>
					</xsl:with-param>
					<xsl:with-param name="claSel">largo seleccion</xsl:with-param>
				</xsl:call-template>
				<!--<span id="borrarSEL_IDSUBFAMILIA" style="display:none;">&nbsp;<a href="javascript:borrarSeleccion('IDSUBFAMILIA');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></span>-->
			</td>
			<td>&nbsp;</td>
		</xsl:when>
		</xsl:choose>
	</tr>

	<tr class="sinLinea">
		<!-- Desplegable Anno (ANNO) -->
		<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field/@name='ANNO'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/field[@name='ANNO']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='ANNO']/."/>
				</xsl:call-template>
			</td>
			<td>&nbsp;</td>
		</xsl:if>
		<!-- Desplegable Estado (IDESTADO) -->
		<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field/@name='IDESTADO'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDESTADO']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDESTADO']/."/>
				</xsl:call-template>
			</td>
			<td>&nbsp;</td>
		</xsl:if>
		<!-- Desplegable Subfamilia (5 niveles) o Producto Estandar (3 niveles) -->
		<xsl:choose>
		<xsl:when test="/EIS_XML/EISANALISIS/FILTROS/field/@name='IDCATEGORIA' and /EIS_XML/EISANALISIS/FILTROS/field/@name='IDSUBFAMILIA'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/NOMBRESNIVELES/NIVEL3"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDSUBFAMILIA']/."/>
					<xsl:with-param name="deshabilitado">
						<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDSUBFAMILIA']/@disabled = 'disabled'">disabled</xsl:if>
					</xsl:with-param>
					<xsl:with-param name="claSel">largo seleccion</xsl:with-param>
				</xsl:call-template>
				<!--<span id="borrarSEL_IDSUBFAMILIA" style="display:none;">&nbsp;<a href="javascript:borrarSeleccion('IDSUBFAMILIA');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></span>-->
			</td>
			<td>&nbsp;</td>
		</xsl:when>
		<xsl:when test="not(/EIS_XML/EISANALISIS/FILTROS/field/@name='IDCATEGORIA') and /EIS_XML/EISANALISIS/FILTROS/field/@name='IDPRODUCTOESTANDAR'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDPRODUCTOESTANDAR']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDPRODUCTOESTANDAR']/."/>
					<xsl:with-param name="deshabilitado">
						<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDPRODUCTOESTANDAR']/@disabled = 'disabled'">disabled</xsl:if>
					</xsl:with-param>
					<xsl:with-param name="claSel">largo</xsl:with-param>
				</xsl:call-template>
			</td>
			<td>&nbsp;</td>
		</xsl:when>
		</xsl:choose>
	</tr>

	<tr class="sinLinea">
		<td class="labelRight">
			<xsl:value-of select="/EIS_XML/EISANALISIS/AGRUPARPOR/field/@label"/>:&nbsp;
		</td>
		<td class="datosLeft">
			<xsl:call-template name="desplegable"><xsl:with-param name="path" select="/EIS_XML/EISANALISIS/AGRUPARPOR/field"/></xsl:call-template>
		</td>
		<td>&nbsp;</td>
		<td class="labelRight">
			<xsl:value-of select="/EIS_XML/EISANALISIS/IDRESULTADOS/field/@label"/>:&nbsp;
		</td>
		<td class="datosLeft">
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/IDRESULTADOS/field"/>
				<xsl:with-param name="onChange">HabilitarRatios(document.forms[0],'RATIO','<xsl:value-of select="/EIS_XML/EISANALISIS/IDRESULTADOS/field/@name"/>','<xsl:value-of select="/EIS_XML/EISANALISIS/IDRATIO/field/@name"/>');</xsl:with-param>
			</xsl:call-template>
		</td>
		<td>&nbsp;</td>
		<!-- Desplegable Grupo (5 niveles), si existe -->
		<xsl:choose>
		<xsl:when test="/EIS_XML/EISANALISIS/FILTROS/field/@name='IDCATEGORIA' and /EIS_XML/EISANALISIS/FILTROS/field/@name='IDGRUPO'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/NOMBRESNIVELES/NIVEL4"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDGRUPO']/."/>
					<xsl:with-param name="deshabilitado">
						<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDGRUPO']/@disabled = 'disabled'">disabled</xsl:if>
					</xsl:with-param>
					<xsl:with-param name="claSel">largo seleccion</xsl:with-param>
				</xsl:call-template>
				<!--<span id="borrarSEL_IDGRUPO" style="display:none;">&nbsp;<a href="javascript:borrarSeleccion('IDGRUPO');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></span>-->
			</td>
			<td>&nbsp;</td>
		</xsl:when>
		<xsl:otherwise>
			<td colspan="3">&nbsp;</td>
		</xsl:otherwise>
		</xsl:choose>
	</tr>

	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/>:&nbsp;</td>
		<td class="datosLeft">
			<input type="text" name="CODIGO" id="CODIGO">
				<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/CODIGO"/></xsl:attribute>
			</input>
		</td>
		<td>&nbsp;</td>
		<td class="labelRight">
			<xsl:value-of select="/EIS_XML/EISANALISIS/IDRATIO/field/@label"/>:&nbsp;
		</td>
		<td class="datosLeft">
			<xsl:variable name="vDeshabilitado">
				<xsl:if test="/EIS_XML/EISANALISIS/IDRESULTADOS/field/@current!='RATIO'">
					disabled
				</xsl:if>
			</xsl:variable>
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/IDRATIO/field"/>
				<xsl:with-param name="deshabilitado"><xsl:value-of select="$vDeshabilitado"/></xsl:with-param>
			</xsl:call-template>
		</td>
		<td>&nbsp;</td>
		<!-- Desplegable Producto Estandar (5 niveles), si existe -->
		<xsl:choose>
		<xsl:when test="/EIS_XML/EISANALISIS/FILTROS/field/@name='IDCATEGORIA' and /EIS_XML/EISANALISIS/FILTROS/field/@name='IDPRODUCTOESTANDAR'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDPRODUCTOESTANDAR']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDPRODUCTOESTANDAR']/."/>
					<xsl:with-param name="deshabilitado">
						<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDPRODUCTOESTANDAR']/@disabled = 'disabled'">disabled</xsl:if>
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

	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:&nbsp;</td>
		<td class="datosLeft">
			<input type="text" name="REFERENCIA" id="REFERENCIA">
				<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/REFERENCIA"/></xsl:attribute>
			</input>
		</td>
		<td colspan="7">&nbsp;</td>
	</tr>

	<tr class="sinLinea">
		<!-- Boton Envio Formulario Via Ajax -->
		<td colspan="6">&nbsp;</td>
		<td>
			<!--<div class="botonLargoAma" id="MostrarCuadro">-->
				<a class="btnDestacado" id="MostrarCuadro" href="javascript:TablaEISAjax();"><xsl:value-of select="document($doc)/translation/texts/item[@name='mostrar']/node()"/></a>
			<!--</div>-->
			<div id="waitBox" style="display:none;"><img src="http://www.newco.dev.br/images/loading.gif"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cargando']/node()"/>...</div>
		</td>
		 <!-- Fin Boton Envio Formulario Via Ajax -->
		<td colspan="2">&nbsp;</td>
	</tr>
</table>
</xsl:template>

<!-- Formulario Desplegables Administrador -->
<xsl:template name="EIS_Form_Administrador">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:value-of select="/EIS_XML/LANG"/>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<table class="buscador">
<!--<table class="infoTable selectEis" border="0">-->
<!--
	<thead>
	<tr>
		<th colspan="9">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='eis']/node()"/>&nbsp;-&nbsp;<xsl:value-of select="/EIS_XML/EISANALISIS/CENTRO"/>&nbsp;(<xsl:value-of select="/EIS_XML/EISANALISIS/USUARIO"/>)&nbsp;-
			<span id="NombreIndicador"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/CUADRO"/></span>
			(<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizado']/node()"/>: <xsl:value-of select="/EIS_XML/EISANALISIS/ACTUALIZACION"/>) - <xsl:value-of select="document($doc)/translation/texts/item[@name='totales_mensuales']/node()"/>&nbsp;
			<a href="javascript:TablaEISAjaxExcel();" style="text-decoration:none;" title="Descargar Fichero Excel">
				<img id="botonExcel" alt="Descargar Excel" src="http://www.newco.dev.br/images/iconoExcel.gif"/>
			</a>
		</th>
	</tr>
	</thead>
-->
	<tr class="sinLinea">
		<!-- Desplegable Cuadro de Mando (IDCUADROMANDO) -->
		<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field/@name='IDCUADROMANDO'">
			<td class="labelRight quince">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDCUADROMANDO']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft quince">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDCUADROMANDO']/."/>
					<xsl:with-param name="claSel">gran</xsl:with-param>
				</xsl:call-template>
			</td>
			<td>&nbsp;</td>
		</xsl:if>
		<!-- Desplegable Anno (ANNO) -->
		<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field/@name='ANNO'">
			<td class="labelRight quince">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/field[@name='ANNO']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft quince">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='ANNO']/."/>
				</xsl:call-template>
			</td>
			<td>&nbsp;</td>
		</xsl:if>
		<!-- Desplegable Nivel Categorias (IDCATEGORIA) -->
		<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field/@name='IDCATEGORIA'">
			<td class="labelRight quince">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/NOMBRESNIVELES/NIVEL1"/>:&nbsp;
			</td>
			<td class="datosLeft quince">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDCATEGORIA']/."/>
					<xsl:with-param name="deshabilitado">
						<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDCATEGORIA']/@disabled = 'disabled'">disabled</xsl:if>
					</xsl:with-param>
					<!--<xsl:with-param name="claSel">largo seleccion</xsl:with-param>-->
					<xsl:with-param name="claSel">gran</xsl:with-param>
				</xsl:call-template>
				<span id="borrarSEL_IDCATEGORIA" style="display:none;">&nbsp;<a href="javascript:borrarSeleccion('IDCATEGORIA');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></span>
			</td>
			<td class="cinco">&nbsp;</td>
		</xsl:if>
	</tr>

	<tr class="sinLinea">
		<!-- Desplegable Empresas Cliente (IDEMPRESA) -->
		<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field/@name='IDEMPRESA'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDEMPRESA']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDEMPRESA']/."/>
					<xsl:with-param name="onChange">ListaCentrosDeEmpresa(this.id,this.value);</xsl:with-param>
					<!--<xsl:with-param name="claSel">seleccion</xsl:with-param>-->
					<xsl:with-param name="claSel">gran</xsl:with-param>
				</xsl:call-template>
				<span id="borrarSEL_IDEMPRESA" style="display:none;">&nbsp;<a href="javascript:borrarSeleccion('IDEMPRESA');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></span>
			</td>
			<td>&nbsp;</td>
		</xsl:if>
		<!-- Desplegable Empresas Proveedor (IDEMPRESA2) -->
		<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field/@name='IDEMPRESA2'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDEMPRESA2']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDEMPRESA2']/."/>
					<xsl:with-param name="onChange">ListaCentrosDeCliente(this.id,this.value);</xsl:with-param>
					<!--<xsl:with-param name="claSel">seleccion</xsl:with-param>-->
					<xsl:with-param name="claSel">gran</xsl:with-param>
					<xsl:with-param name="defecto"><xsl:value-of select="/EIS_XML/CP_EMPRESA2"/></xsl:with-param>
				</xsl:call-template>

				<span id="borrarSEL_IDEMPRESA2" style="display:none;">&nbsp;<a href="javascript:borrarSeleccion('IDEMPRESA2');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></span>
			</td>
			<td>&nbsp;</td>
		</xsl:if>
		<!-- Desplegable Nivel Familias (IDFAMILIA) -->
		<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field/@name='IDFAMILIA'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/NOMBRESNIVELES/NIVEL2"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDFAMILIA']/."/>
					<xsl:with-param name="deshabilitado">
						<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDFAMILIA']/@disabled = 'disabled'">disabled</xsl:if>
					</xsl:with-param>
					<!--<xsl:with-param name="claSel">largo seleccion</xsl:with-param>-->
					<xsl:with-param name="claSel">gran</xsl:with-param>
				</xsl:call-template>
				<span id="borrarSEL_IDFAMILIA" style="display:none;">&nbsp;<a href="javascript:borrarSeleccion('IDFAMILIA');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></span>
			</td>
			<td>&nbsp;</td>
		</xsl:if>
	</tr>

	<tr class="sinLinea">
		<!-- Desplegable Centros de Cliente (IDCENTRO). Se genera por peticion ajax una vez se elige IDEMPRESA -->
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='centros_cliente']/node()"/>:&nbsp;</td>
		<td class="datosLeft">
			<!--<select id="IDCENTRO" name="IDCENTRO" disabled="disabled" class="seleccion"/>-->
			<select id="IDCENTRO" name="IDCENTRO" disabled="disabled" class="gran"/>
			<span id="borrarSEL_IDCENTRO" style="display:none;">&nbsp;<a href="javascript:borrarSeleccion('IDCENTRO');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></span>
		</td>
		<td>&nbsp;</td>
		<!-- Desplegable Centros de Proveedor (IDCENTRO2). Se genera por peticion ajax una vez se elige IDEMPRESA2 -->
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='centros_proveedor']/node()"/>:&nbsp;</td>
		<td class="datosLeft">
			<select id="IDCENTRO2" name="IDCENTRO2" disabled="disabled" class="seleccion"/>
			<span id="borrarSEL_IDCENTRO2" style="display:none;">&nbsp;<a href="javascript:borrarSeleccion('IDCENTRO2');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></span>
		</td>
		<td>&nbsp;</td>
		<!-- Desplegable Nivel Subfamilias (IDSUBFAMILIA) -->
		<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field/@name='IDSUBFAMILIA'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/NOMBRESNIVELES/NIVEL3"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDSUBFAMILIA']/."/>
					<xsl:with-param name="deshabilitado">
						<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDSUBFAMILIA']/@disabled = 'disabled'">disabled</xsl:if>
					</xsl:with-param>
					<!--xsl:with-param name="claSel">largo seleccion</xsl:with-param>-->
					<xsl:with-param name="claSel">gran</xsl:with-param>
				</xsl:call-template>
				<span id="borrarSEL_IDSUBFAMILIA" style="display:none;">&nbsp;<a href="javascript:borrarSeleccion('IDSUBFAMILIA');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></span>
			</td>
			<td>&nbsp;</td>
		</xsl:if>
	</tr>

	<tr class="sinLinea">
		<!-- Desplegable Estado (IDESTADO) -->
		<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field/@name='IDESTADO'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDESTADO']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDESTADO']/."/>
				</xsl:call-template>
			</td>
			<td>&nbsp;</td>
		</xsl:if>
		<!-- Desplegable AgruparPor (AGRUPARPOR) -->
		<td class="labelRight">
			<xsl:value-of select="/EIS_XML/EISANALISIS/AGRUPARPOR/field/@label"/>:&nbsp;
		</td>
		<td class="datosLeft">
			<xsl:call-template name="desplegable">
            	<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/AGRUPARPOR/field"/>
                <xsl:with-param name="defecto"><xsl:value-of select="/EIS_XML/CP_AGRUPAR" /></xsl:with-param>
            </xsl:call-template>
		</td>
		<td>&nbsp;</td>
		<!-- Desplegable Nivel Grupos (IDGRUPO) -->
		<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field/@name='IDGRUPO'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/NOMBRESNIVELES/NIVEL4"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDGRUPO']/."/>
					<xsl:with-param name="deshabilitado">
						<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDGRUPO']/@disabled = 'disabled'">disabled</xsl:if>
					</xsl:with-param>
					<!--<xsl:with-param name="claSel">largo seleccion</xsl:with-param>-->
					<xsl:with-param name="claSel">gran</xsl:with-param>
				</xsl:call-template>
				<span id="borrarSEL_IDGRUPO" style="display:none;">&nbsp;<a href="javascript:borrarSeleccion('IDGRUPO');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></span>
			</td>
			<td>&nbsp;</td>
		</xsl:if>
	</tr>

	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:&nbsp;</td>
		<td class="datosLeft">
			<input type="text" name="REFERENCIA" id="REFERENCIA">
				<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/REFERENCIA"/></xsl:attribute>
			</input>
		</td>
		<td>&nbsp;</td>
		<td class="labelRight">
			<xsl:value-of select="/EIS_XML/EISANALISIS/IDRESULTADOS/field/@label"/>:&nbsp;
		</td>
		<td class="datosLeft">
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/IDRESULTADOS/field"/>
				<xsl:with-param name="onChange">HabilitarRatios(document.forms[0],'RATIO','<xsl:value-of select="/EIS_XML/EISANALISIS/IDRESULTADOS/field/@name"/>','<xsl:value-of select="/EIS_XML/EISANALISIS/IDRATIO/field/@name"/>');</xsl:with-param>
				<xsl:with-param name="claSel">gran</xsl:with-param>
			</xsl:call-template>
		</td>
		<td>&nbsp;</td>
		<!-- Desplegable Nivel Productos Estandar (IDPRODUCTOESTANDAR) -->
		<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field/@name='IDPRODUCTOESTANDAR'">
			<td class="labelRight">
				<xsl:value-of select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDPRODUCTOESTANDAR']/@label"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDPRODUCTOESTANDAR']/."/>
					<xsl:with-param name="deshabilitado">
						<xsl:if test="/EIS_XML/EISANALISIS/FILTROS/field[@name='IDPRODUCTOESTANDAR']/@disabled = 'disabled'">disabled</xsl:if>
					</xsl:with-param>
					<!--<xsl:with-param name="claSel">largo</xsl:with-param>-->
					<xsl:with-param name="claSel">gran</xsl:with-param>
				</xsl:call-template>
			</td>
			<td>&nbsp;</td>
		</xsl:if>
	</tr>

	<tr class="sinLinea">
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/>:&nbsp;</td>
		<td class="datosLeft">
			<input type="text" name="CODIGO" id="CODIGO">
				<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/CODIGO"/></xsl:attribute>
			</input>
		</td>
		<td>&nbsp;</td>
		<td class="labelRight">
			<xsl:value-of select="/EIS_XML/EISANALISIS/IDRATIO/field/@label"/>:&nbsp;
		</td>
		<td class="datosLeft">
			<xsl:variable name="vDeshabilitado">
				<xsl:if test="/EIS_XML/EISANALISIS/IDRESULTADOS/field/@current!='RATIO'">
					disabled
				</xsl:if>
			</xsl:variable>
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/IDRATIO/field"/>
				<xsl:with-param name="deshabilitado"><xsl:value-of select="$vDeshabilitado"/></xsl:with-param>
				<xsl:with-param name="claSel">gran</xsl:with-param>
			</xsl:call-template>
		</td>
		<td colspan="4">&nbsp;</td>
	</tr>

	<tr class="sinLinea">
		<!-- Boton Envio Formulario Via Ajax -->
		<td colspan="6">&nbsp;</td>
		<td>
			<!--<div class="botonLargoAma" id="MostrarCuadro">-->
				<a class="btnDestacado" id="MostrarCuadro" href="javascript:TablaEISAjax();"><xsl:value-of select="document($doc)/translation/texts/item[@name='mostrar']/node()"/></a>
			<!--</div>-->
			<div id="waitBox" style="display:none;"><img src="http://www.newco.dev.br/images/loading.gif"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cargando']/node()"/>...</div>
		</td>
		 <!-- Fin Boton Envio Formulario Via Ajax -->
		<td colspan="2">&nbsp;</td>
	</tr>
</table>
</xsl:template>

</xsl:stylesheet>
