<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Presentacion de datos estadisticos de utilizacion de la plataforma MedicalVM
	Ultima revision: 15feb18 13:37
+-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/">
<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang"><xsl:value-of select="/EIS_CONSULTAS/LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='sistema_info_direccion']/node()"/>&nbsp;(
	<xsl:value-of select="document($doc)/translation/texts/item[@name='eis']/node()"/>)</title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/EIS/EISConsultas_060918.js"></script>
<!-- PS 5dic16 a�adido para volver al codigo antiguo antes de cambiar dise�o -->
	<script type="text/javascript" src="http://www.google.com/jsapi"/>
<!-- -->

	<!--	Desactivar para probar	carga con CORS	-->
	<!--<script type="text/javascript" src="http://www.google.com/jsapi"/>-->
	<!--	Desactivar para probar	carga con CORS	-->
	<!--<script type="text/javascript" src="http://www.gstatic.com/charts/loader.js"></script>-->


	<link rel="stylesheet" type="text/css" href="http://www.newco.dev.br/General/TablaResumen-popup.css"/>
	<script type="text/javascript" src="http://www.newco.dev.br/General/TablaResumen-popup.js"></script>

<!-- PS 5dic16 a�adido para volver al codigo antiguo antes de cambiar dise�o -->
	<script type="text/javascript">
		google.load("visualization", "1", {packages:["corechart"]});
	</script>
<!-- -->

<!-- PS 5dic16 comentado para volver al codigo antiguo antes de cambiar dise�o -->
	<!-- <script type="text/javascript">

		function createCORSRequest(method, url) {
		  var xhr = new XMLHttpRequest();
		  if ("withCredentials" in xhr) {

    		// Check if the XMLHttpRequest object has a "withCredentials" property.
    		// "withCredentials" only exists on XMLHTTPRequest2 objects.
    		xhr.open(method, url, true);

		  } else if (typeof XDomainRequest != "undefined") {

    		// Otherwise, check if XDomainRequest.
    		// XDomainRequest only exists in IE, and is IE's way of making CORS requests.
    		xhr = new XDomainRequest();
    		xhr.open(method, url);

		  } else {

    		// Otherwise, CORS is not supported by the browser.
    		xhr = null;

		  }
		  return xhr;
		}

		// Helper method to parse the title tag from the response.
		function getTitle(text) {
		  return text.match('<title>(.*)?</title>')[1];
		}

		// Make the actual CORS request.
		function makeCorsRequest() {
		  // This is a sample server that supports CORS.
		  var url = 'http://www.google.com/jsapi';

		  var xhr = createCORSRequest('GET', url);
		  if (!xhr) {
    		alert('CORS not supported');
    		return;
		  }

		  // Response handlers.
		  xhr.onload = function() {
    		var text = xhr.responseText;
    		var title = getTitle(text);
    		alert('Response from CORS request to ' + url + ': ' + title);
		  };

		  xhr.onerror = function() {
    		alert('Woops, there was an error making the request.');
		  };

		  xhr.send();
		}
		
		//solodebug
		//console.log("Inicio carga API Google");

		
		//ACTIVAR PARA PROBAR CORS
		//makeCorsRequest();
		
		
		
		
		//solodebug
		//console.log("Fin carga API Google");




		//solodebug
		console.log("Inicio carga grafico Google");
		
		//	Se produce un error al conectar a la API de Google desde un div, funcionaba correctamente en un iframe
		//	http://developer.mozilla.org/es/docs/Web/HTTP/Access_control_CORS
		
		//21nov16	google.load("visualization", "1", {packages:["corechart"]});


		google.charts.load('current', {packages: ['corechart']});
		google.charts.setOnLoadCallback(drawChart);

		//solodebug
		console.log("Fin carga grafico Google");
	</script>-->
	<!-- -->
	<script type="text/javascript">

		var IDPais	= '<xsl:value-of select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/IDPAIS"/>';
		var IDIdioma	= '<xsl:value-of select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/IDIDIOMA"/>';


		var tituloGraficoDiario		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='eis_titulo_grafico_diario']/node()"/>';
		var tituloHAxisDiario		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='eis_hor_axis_diario']/node()"/>';
		var tituloGraficoMensual	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='eis_titulo_grafico_mensual']/node()"/>';
		var tituloHAxisMensual		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='eis_hor_axis_mensual']/node()"/>';
		<!-- Valores de las consultas para mostrar graficos -->
        var cont = 0, cont2 = 0, max = 0;
		var GruposDiario		= [];
		var GruposMensual		= [];
		var NombresGruposDiario		= [];
		var NombresGruposMensual	= [];
		var NumGruposDiario		= <xsl:value-of select="count(/EIS_CONSULTAS/CUADROPRINCIPALEIS/RESUMENES_DIARIOS/RESUMEN_DIARIO[@IncluirGrafico='S'])"/>;
		var NumDias			= (<xsl:value-of select="count(/EIS_CONSULTAS/CUADROPRINCIPALEIS/RESUMENES_DIARIOS/RESUMEN_DIARIO[@IncluirGrafico='S']/COLUMNA)"/> / NumGruposDiario);
		var NumGruposMensual		= <xsl:value-of select="count(/EIS_CONSULTAS/CUADROPRINCIPALEIS/RESUMENES_MENSUALES/RESUMEN_MENSUAL[@IncluirGrafico='S'])"/>;
		var NumMeses			= (<xsl:value-of select="count(/EIS_CONSULTAS/CUADROPRINCIPALEIS/RESUMENES_MENSUALES/RESUMEN_MENSUAL[@IncluirGrafico='S']/COLUMNA)"/> / NumGruposMensual);
		var NombresDias			= [];
		var NombresMeses		= [];

		<!-- Creamos array de dos dimensiones para el grafico de resumen diario -->
		var ValoresGraficoDiario	= new Array(NumGruposDiario);
		for(var i=0; i &lt; NumGruposDiario; i++){
			ValoresGraficoDiario[i] = new Array(NumDias);
		}
		<!-- Creamos array de dos dimensiones para el grafico de resumen mensual -->
		var ValoresGraficoMensual	= new Array(NumGruposMensual);
		for(i=0; i &lt; NumGruposMensual; i++){
			ValoresGraficoMensual[i] = new Array(NumMeses);
		}

		cont = 0;
		<xsl:for-each select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/RESUMENES_DIARIOS/RESUMEN_DIARIO[@IncluirGrafico='S']">
			GruposDiario[cont]		= '<xsl:value-of select="@ID"/>';
			NombresGruposDiario[cont]	= '<xsl:value-of select="@Nombre"/>';

			cont2 = 0;
			<xsl:for-each select="COLUMNA">
				ValoresGraficoDiario[cont][cont2] = <xsl:value-of select="VALOR_SINFORMATO"/>;

				NombresDias[cont2] = '<xsl:value-of select="DIA"/>/<xsl:value-of select="MES"/>';
                cont2++;
			</xsl:for-each>
            cont++;
		</xsl:for-each>

		cont = 0;
		<xsl:for-each select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/RESUMENES_MENSUALES/RESUMEN_MENSUAL[@IncluirGrafico='S']">
			GruposMensual[cont]		= '<xsl:value-of select="@ID"/>';
			NombresGruposMensual[cont]	= '<xsl:value-of select="@Nombre"/>';

			cont2 = 0;
			<xsl:for-each select="COLUMNA">
				ValoresGraficoMensual[cont][cont2] = <xsl:value-of select="VALOR_SINFORMATO"/>;

				NombresMeses[cont2] = '<xsl:value-of select="MES"/>/<xsl:value-of select="ANYO"/>';
                                cont2++;
			</xsl:for-each>
                        cont++;
		</xsl:for-each>
	</script>
</head>
<!---->
<body>
    <xsl:attribute name="onload">
        <xsl:choose>
            <xsl:when test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/MVM or /EIS_CONSULTAS/CUADROPRINCIPALEIS/MVMB or /EIS_CONSULTAS/CUADROPRINCIPALEIS/CDC or /EIS_CONSULTAS/CUADROPRINCIPALEIS/ADMIN or /EIS_CONSULTAS/CUADROPRINCIPALEIS/ADMINCENTRO">navigador(); infoDiariaClientes();setTimeout('document.location.reload()',300000);escondeDiario();</xsl:when>
            <xsl:otherwise>navigador();setTimeout('document.location.reload()',300000);escondeDiario();</xsl:otherwise>
        </xsl:choose>
    </xsl:attribute>
<xsl:choose>
<xsl:when test="EIS_CONSULTAS/ROWSET/ROW/Sorry"><xsl:apply-templates select="EIS_CONSULTAS/ROWSET/ROW/Sorry"/></xsl:when>
<xsl:when test="EIS_CONSULTAS/SESION_CADUCADA"><xsl:apply-templates select="EIS_CONSULTAS/SESION_CADUCADA"/></xsl:when>
<xsl:otherwise>
	<!--idioma-->
	<xsl:variable name="lang"><xsl:value-of select="/EIS_CONSULTAS/LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!--<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='sistema_info_direccion_12_meses']/node()"/></h1>-->

        <!--si es cuadro principal ense�o el nuevo eis-->
        <xsl:choose>
        <xsl:when test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/CUADRO_AVANZADO and /EIS_CONSULTAS/CUADROPRINCIPALEIS/ROL != 'VENDEDOR'">

		<!--	Titulo de la p�gina		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='informes']/node()"/></span></p>
			<p class="TituloPagina">
        	  <xsl:value-of select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/NOMBRE"/>&nbsp;&nbsp;
			</p>
		</div>
		

		<div id="pestanas"><!--16nov16 class="pestannas" --><!-- 14nov16 class="divLeft" style="border-bottom:0px solid #3B5998;"-->
			<ul class="pestannas">
				<li>
					<a id="actividadMensual" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='actividad_mensual']/node()"/></a>
				</li>
				<li>
					<a id="actividadDiaria" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='actividad_diaria']/node()"/></a>
				</li>
                <xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/MVM or /EIS_CONSULTAS/CUADROPRINCIPALEIS/MVMB">
				<li>
					<a id="clientes" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='clientes']/node()"/></a>
				</li>
                </xsl:if>
				<li>
					<a id="alarmas" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='alarmas']/node()"/></a>
				</li>
			</ul>
		</div>
		<!--	18ago16	Creamos una tabla para organizar mejor los elementos de la p�gina	-->
		<table style="margin-top:50px">
		<tr class="sinLinea">
		<td>
			<div class="divLeft" style="margin-top:20px">
				<div class="btnNormal btnAnchoMedio"><!--	Estos "div" son necesarios para fijar el ancho del bot�n	-->
				<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/EIS/EISBasico.xsql?IDCONSULTA=COPedidosPorEmpEur','An�lisis',100,80,0,-50);">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Mensual']/node()"/>
				</a>
				</div>
				<xsl:choose>
				<xsl:when test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/MVM or /EIS_CONSULTAS/CUADROPRINCIPALEIS/MVMB or /EIS_CONSULTAS/CUADROPRINCIPALEIS/EMPRESA">
					<br/>
					<br/>
					<br/>
					<div class="btnNormal btnAnchoMedio">
					<a href="javascript:MostrarMatriz();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='analisi_matricial']/node()"/>
					</a>
					</div>
					<br/>
					<br/>
					<br/>
					<div class="btnNormal btnAnchoMedio">
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/EIS/ClasificacionProveedoresEIS.xsql','Clasificaci�n proveedores',100,80,0,-50);">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>
					</a>
					</div>
					<br/>
					<br/>
					<br/>
					<div class="btnNormal btnAnchoMedio">
					<a href="javascript:MostrarConsultaAnual();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='datos_historicos2']/node()"/>
					</a>&nbsp;
					</div>
					<br/>
					<br/>
					<br/>
					<xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/TIENE_HISTORICOS_POR_CENTRO">
						<div class="btnNormal btnAnchoMedio">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/HistoricosPorCentro.xsql?IDEMPRESA={/EIS_CONSULTAS/CUADROPRINCIPALEIS/IDEMPRESA}','Clasificaci�n proveedores',100,80,0,-50);">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='historicos_por_centro']/node()"/>
						</a>&nbsp;
						</div>
						<br/>
						<br/>
						<br/>
					</xsl:if>
					<div class="btnNormal btnAnchoMedio">
					<a href="javascript:showTablaResumen(true);">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='tabla_resumen']/node()"/>
					</a>
					</div>
					<br/>
					<br/>
					<br/>
					<!--	18ago16	El bot�n de selecciones, junto al resto de botones		-->
					<div class="btnNormal btnAnchoMedio">
					<a href="javascript:MostrarSelecciones();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='selecciones']/node()"/>
					</a>&nbsp;
					</div>
				</xsl:when>
				<xsl:otherwise>
					<!--	Para compradores con derechos a nivel de centro, bot�n proveedores para condiciones proveedores	y resumen historico-->
					<br/>
					<br/>
					<br/>
					<div class="btnNormal btnAnchoMedio">
					<a href="javascript:MostrarConsultaAnual();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='datos_historicos2']/node()"/>
					</a>&nbsp;
					</div>
					<br/>
					<br/>
					<br/>
					<div class="btnNormal btnAnchoMedio">
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/CondicionesProveedores.xsql?IDCLIENTE={/EIS_CONSULTAS/CUADROPRINCIPALEIS/IDEMPRESA}','Condiciones proveedores',100,80,0,-50);">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>
					</a>
					</div>
				</xsl:otherwise>
				</xsl:choose>
			</div>
		</td>
		<td width="500px">
        	<div id="actividadMensualBox" class="eisBox" style="float:left;width:100%;">
            	<div id="graficoGoogleMensual" style="float:left;"></div>
        	</div><!--fin de actividadMensualBox-->

        	<div id="actividadDiariaBox" class="eisBox" style="float:left;width:100%;display:;">
            	<div id="graficoGoogleDiario" style="float:left;;"></div>

            	<!---->
            	 <xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/MVM or /EIS_CONSULTAS/CUADROPRINCIPALEIS/MVMB or /EIS_CONSULTAS/CUADROPRINCIPALEIS/CDC or /EIS_CONSULTAS/CUADROPRINCIPALEIS/ADMIN">
                	 <div class="eisInfoDiaria divLeft25nopa" style="border-radius:5px;background:#E3E2E2;margin-top:5%;">
                    	<table style="font-size:12px;width:90%;margin-left:5%;">

                    	<thead>
                        	<tr class="sinLinea"><td colspan="3">&nbsp;</td></tr>
                            	<tr class="subTituloTabla" style="height:40px;">
                                    	<td style="text-align:left;font-weight:bold;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eis_info_diaria']/node()"/></td>
                                    	<td style="font-weight:bold;"><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_dia_actual']/node()"/></td>
                                    	<td style="font-weight:bold;"><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_dia_anterior']/node()"/></td>
                            	</tr>
                    	</thead>
                    	<tbody>
                            	<tr style="border-bottom:1px solid #999;height:40px;">
                                    	<td style="text-align:left;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eis_numero_pedidos']/node()"/></td>
                                    	<td style="text-align:center;"><span id="numPedidosDiaActual"></span><!--/INFORMACION_DIARIA/NUMERO_PEDIDOS/DIAACTUAL--></td>
                                    	<td style="text-align:center;"><span id="numPedidosDiaAnterior"></span></td>
                            	</tr>
                            	<tr style="border-bottom:1px solid #999;height:40px;">
                                    	<td style="text-align:left;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eis_importe_pedidos']/node()"/></td>
                                    	<td style="text-align:center;"><span id="importePedidosDiaActual"></span><xsl:value-of select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/INFORMACION_DIARIA/IMPORTE_PEDIDOS/DIAACTUAL"/></td>
                                    	<td style="text-align:center;"><span id="importePedidosDiaAnterior"></span></td>
                            	</tr>
                            	<tr style="border-bottom:1px solid #999;height:40px;">
                                    	<td style="text-align:left;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eis_control_pedidos']/node()"/></td>
                                    	<td style="text-align:center;"><span id="controlPedidosDiaActual"></span><xsl:value-of select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/INFORMACION_DIARIA/CONTROL_PEDIDOS/DIAACTUAL"/></td>
                                    	<td style="text-align:center;"><span id="controlPedidosDiaAnterior"></span></td>
                            	</tr>
                            	<tr style="border-bottom:1px solid #999;height:40px;">
                                    	<td style="text-align:left;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='incidencias']/node()"/></td>
                                    	<td style="text-align:center;"><span id="incidenciasDiaActual"></span><xsl:value-of select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/INFORMACION_DIARIA/INCIDENCIAS/DIAACTUAL"/></td>
                                    	<td style="text-align:center;"><span id="incidenciasDiaAnterior"></span></td>
                            	</tr>
                            	<tr style="border-bottom:1px solid #999;height:40px;">
                                    	<td style="text-align:left;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='evaluaciones']/node()"/></td>
                                    	<td style="text-align:center;"><span id="evaluacionesDiaActual"></span><xsl:value-of select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/INFORMACION_DIARIA/EVALUACIONES/DIAACTUAL"/></td>
                                    	<td style="text-align:center;"><span id="evaluacionesDiaAnterior"></span></td>
                            	</tr>
                            	<tr style="border-bottom:1px solid #999;height:40px;">
                                    	<td style="text-align:left;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones']/node()"/></td>
                                    	<td style="text-align:center;"><span id="licitacionesDiaActual"></span><xsl:value-of select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/INFORMACION_DIARIA/LICITACIONES/DIAACTUAL"/></td>
                                    	<td style="text-align:center;"><span id="licitacionesDiaAnterior"></span></td>
                            	</tr>
                    	</tbody>
                    	<tr class="sinLinea"><td colspan="3">&nbsp;</td></tr>
                    	</table>

                	 </div>


            	</xsl:if>
        	</div><!--fin de actividadDiariaBox-->

        	<div id="alarmasBox" class="eisBox" style="float:left;width:100%;display:none;">
            	<xsl:call-template name="ALARMAS_ADMIN"/>
        	</div><!--fin de alarmasBox-->

        	<div id="clientesBox" class="eisBox" style="float:left;width:100%;display:none;">
            	<xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/MVM or /EIS_CONSULTAS/CUADROPRINCIPALEIS/MVMB">
				<!--<table class="grandeInicio" id="tablaEmpresas" style="margin-top:50px;">-->
				<table class="buscador" id="tablaEmpresas">
				<thead>
					<!--<tr class="subtituloTabla">-->
					<tr class="subTituloTabla">
						<th style="border-right: 1px solid #999;">&nbsp;</th>
						<th colspan="4" style="border-right: 1px solid #999;"><p style="text-align:center;"><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_catalogo_prods_estandar']/node()"/></p></th>
						<th colspan="6" style="border-right: 1px solid #999;"><p style="text-align:center;"><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_pedidos_eur']/node()"/></p></th>
						<th colspan="2"><p style="text-align:center;"><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_incidencias_pedidos']/node()"/></p></th>
					</tr>

					<tr class="subTituloTabla">
						<td style="border-right:1px solid #999; text-align:left;padding-left:10px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_cliente']/node()"/></td>
						<td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='eis_potencial_catalogo_2line']/node()"/></td>
						<td class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_catalogados']/node()"/></td>
						<td class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_adjudicados']/node()"/></td>
						<td class="siete" style="border-right: 1px solid #999;"><xsl:copy-of select="document($doc)/translation/texts/item[@name='eis_comprados_12meses_2line']/node()"/></td>
						<td class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_doce_meses']/node()"/></td>
						<td class="seis"><xsl:copy-of select="document($doc)/translation/texts/item[@name='eis_potencial_mensual_2line']/node()"/></td>
						<td class="ocho"><xsl:copy-of select="document($doc)/translation/texts/item[@name='eis_mes_anterior']/node()"/></td>
						<td class="ocho"><xsl:copy-of select="document($doc)/translation/texts/item[@name='eis_ultimos_30_dias']/node()"/></td>
						<td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='eis_dia_anterior_2line']/node()"/></td>
						<td class="cinco" style="border-right: 1px solid #999;"><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_hoy']/node()"/></td>
						<td class="siete"><xsl:copy-of select="document($doc)/translation/texts/item[@name='eis_pendientes_aceptar_2line']/node()"/></td>
						<td class="ocho"><xsl:copy-of select="document($doc)/translation/texts/item[@name='eis_pedidos_problematicos_2line']/node()"/></td>
					</tr>
				</thead>
				<tbody>

				</tbody>
				</table>
            	</xsl:if>
       	 </div><!--fin de clientesBox-->


        	<!--si clico en resumen sale esto-->
			<div class="overlay-container">
				<div class="window-container zoomout">
					<p><a href="javascript:showTablaResumen(false);"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a></p>
					<table>
					<thead>
						<tr class="sinLinea">
							<td>&nbsp;</td>
						<xsl:for-each select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/RESUMENES_MENSUALES/CABECERA/COLUMNA">
							<td><xsl:value-of select="MES"/>/<xsl:value-of select="ANYO"/></td>
						</xsl:for-each>
						</tr>
					</thead>

					<tbody>
					<xsl:for-each select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/RESUMENES_MENSUALES/RESUMEN_MENSUAL">
						<tr class="sinLinea">
							<td class="indicador"><xsl:value-of select="@Nombre"/></td>
							<xsl:for-each select="COLUMNA">
								<td><xsl:value-of select="VALOR"/></td>
							</xsl:for-each>
                        </tr>
					</xsl:for-each>
					</tbody>
					</table>
				</div>
			</div>
		</td>
		<td class="textoResaltado">
			&nbsp;&nbsp;&nbsp;<label style="font-size:15px;font-weight:bold;"><xsl:value-of select="document($doc)/translation/texts/item[@name='informes']/node()"/>:</label><br/><br/>
			<!--	6oct16	an�lisis de l�neas de pedidos y an�lisis de lineas de licitaciones	-->
			&nbsp;&nbsp;&nbsp;*&nbsp;<a class="enlaceResaltado" href="http://www.newco.dev.br/Personal/BandejaTrabajo/AnalisisPedidos.xsql" target="_blank"><xsl:value-of select="document($doc)/translation/texts/item[@name='Analisis_pedidos']/node()"/></a><br/>
			&nbsp;&nbsp;&nbsp;*&nbsp;<a class="enlaceResaltado" href="http://www.newco.dev.br/Gestion/Comercial/LicAnalisisLineas.xsql" target="_blank"><xsl:value-of select="document($doc)/translation/texts/item[@name='Analisis_licitaciones']/node()"/></a><br/>
			<xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/MVM or /EIS_CONSULTAS/CUADROPRINCIPALEIS/MVMB">
			&nbsp;&nbsp;&nbsp;*&nbsp;<a class="enlaceResaltado" href="http://www.newco.dev.br/Gestion/Comercial/LicAnalisisProveedores.xsql" target="_blank"><xsl:value-of select="document($doc)/translation/texts/item[@name='Analisis_proveedores_licitacion']/node()"/></a><br/>
			</xsl:if>
			<xsl:for-each select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/INFORMES/field/dropDownList/listElem">
				&nbsp;&nbsp;&nbsp;*&nbsp;<a class="enlaceResaltado" href="javascript:abrirInformes({/EIS_CONSULTAS/CUADROPRINCIPALEIS/IDEMPRESA},{ID});"><xsl:value-of select="listItem"/></a><br/>
			</xsl:for-each>
			<xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/INFORMES_PRECALCULADOS">
			<br/>
			<br/>
			<br/>
			&nbsp;&nbsp;&nbsp;<label style="font-size:15px;font-weight:bold;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Informes_precalculados']/node()"/>:</label><br/><br/>
			<xsl:for-each select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/INFORMES_PRECALCULADOS/INFORMES/INFORME">
				&nbsp;&nbsp;&nbsp;*&nbsp;<a class="enlaceResaltado" href="http://www.newco.dev.br/Descargas/{EIS_IPC_FICHERO}"><xsl:value-of select="TIPO"/>&nbsp;[<xsl:value-of select="EIS_IPC_FECHA"/>]</a><br/>
			</xsl:for-each>
			</xsl:if>
		</td>
		</tr>
		</table>

    	<!--si clico en el icono tabla de clientes-->
		<div class="overlay-container-2">
			<div class="window-container zoomout">
				<p><a href="javascript:showTablaResumenEmpresa(false);"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a></p>
				<table>
				<thead></thead>

				<tbody></tbody>
				</table>
			</div>
		</div>



		  <div class="divLeft" style="margin-top:20px">

    		<div class="divLeft">

            <div class="divLeft boxEIS" id="consultasBox" style="display:none;">
                <xsl:call-template name="CONSULTAS"/>
            </div>

            <br />
            <br />
            <br />
            <br />
        </div><!--fin de divleft70-->


        </div><!--fin de divLeft-->



         <br /><br />
        </xsl:when><!--fin de admin o cdc-->

        <!--otros usuarios-->
        <xsl:otherwise>

	<div class="divLeft margin25">
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<div class="divLeft30nopa">
			<p>&nbsp;</p>
			<xsl:variable name="PRIMERACONSULTA"><xsl:value-of select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/LISTACONSULTAS/GRUPO/CONSULTA/ID"/></xsl:variable>
			<table class="buscador">
				<tr class="subtituloTabla">
					<th>&nbsp;</th>
					<th><p><xsl:value-of select="document($doc)/translation/texts/item[@name='alarmas_control_automatico']/node()"/></p></th>
					<th>&nbsp;</th>
				</tr>
				<xsl:if test="not(/EIS_CONSULTAS/CUADROPRINCIPALEIS/ALARMAS/ALARMA)">
				<tr class="sinLinea">
					<td>&nbsp;</td>
					<td class="subTitle">
						<p><xsl:value-of select="document($doc)/translation/texts/item[@name='ninguna_alarma_activa']/node()"/>.</p>
					</td>
					<td>&nbsp;</td>
				</tr>
				</xsl:if>

			<tbody>
			<xsl:for-each select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/ALARMAS/ALARMA">
				<tr class="sinLinea">
					<td>
                        <p>
                            <xsl:choose>
                                <xsl:when test="POSITIVO = 'S'"><img src="http://www.newco.dev.br/images/SemaforoVerde.gif"/></xsl:when>
                                <xsl:otherwise><img src="http://www.newco.dev.br/images/SemaforoRojo.gif"/></xsl:otherwise>
                            </xsl:choose>

                        </p>
                    </td>
					<td class="textLeft"><p>
						<a style="text-decoration:none;">
							<xsl:attribute name="href">javascript:MostrarPag('<xsl:value-of select="ENLACE"/>');</xsl:attribute>
							<xsl:value-of select="NOMBRE"/>
						</a>&nbsp;
						<!--ense�o image solo si es mvm o mvmb-->
						<xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/PRESENTARENLACEALTERNATIVO">
							<a target="_blank">
								<xsl:attribute name="href"><xsl:value-of select="ENLACE"/></xsl:attribute>
								<img src="http://www.newco.dev.br/images/newPage.gif" alt="Nueva pag" class="newPage" style="display:none;"/>
							</a>
						</xsl:if>
					</p></td>
					<td>&nbsp;</td>
				</tr>
			</xsl:for-each>
			</tbody>

			<tfoot>
				<tr class="sinLinea">
					<td class="footLeft">&nbsp;</td>
					<td>&nbsp;</td>
					<td class="footRight">&nbsp;</td>
				</tr>
			</tfoot>
			</table>

			<p>&nbsp;</p>
			<!--<p><strong>>> <a>
				<xsl:attribute name="href">javascript:MostrarInicio();</xsl:attribute>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='acceso_directo_mando']/node()"/>
			</a></strong></p>

			<xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/PRESENTARMATRIZ">
				<p>&nbsp;</p>
				<p><strong>>> <a>
					<xsl:attribute name="href">javascript:MostrarMatriz();</xsl:attribute>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='matriz_resultados_eis']/node()"/>
				</a></strong></p>
			</xsl:if>
-->
		</div><!--fin de divLeft40-->

		<div class="divLeft30nopa">
<!--
			<xsl:attribute name="class">
				<xsl:choose>
				<xsl:when test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/MVM or /EIS_CONSULTAS/CUADROPRINCIPALEIS/MVMB">divLeft30nopa</xsl:when>
				<xsl:otherwise>divLeft40</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
-->
			<p>&nbsp;</p>
			<xsl:for-each select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/LISTACONSULTAS/GRUPO">
			<table class="buscador">
			<thead>
				<tr class="subtituloTabla">
					<th>&nbsp;</th>
					<th><p><xsl:value-of select="NOMBRE"/></p></th>
					<th>&nbsp;</th>
				</tr>
			</thead>

			<tbody>
			<xsl:for-each select="./CONSULTA">
				<tr class="sinLinea">
					<td><p><img src="http://www.newco.dev.br/images/listNaranja.gif"/></p></td>
					<td class="textLeft"><p><a>
						<xsl:attribute name="href">javascript:MostrarConsulta('<xsl:value-of select="ID"/>');</xsl:attribute>
						<xsl:value-of select="NOMBRE"/></a>&nbsp;
						<!--ense�o image solo si es mvm o mvmb-->
						<xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/PRESENTARENLACEALTERNATIVO">
							<a target="_blank">
								<xsl:attribute name="href">http://www.newco.dev.br/Gestion/EIS/EISBasico.xsql?IDCONSULTA=<xsl:value-of select="ID"/></xsl:attribute>
								<img src="http://www.newco.dev.br/images/newPage.gif" alt="Nueva pag" class="newPage" style="display:none;"/>
							</a>
						</xsl:if>
					</p></td>
					<td>&nbsp;</td>
				</tr>
			</xsl:for-each>
			</tbody>

			<tfoot>
				<tr class="sinLinea">
					<td class="footLeft">&nbsp;</td>
					<td>&nbsp;</td>
					<td class="footRight">&nbsp;</td>
				</tr>
			</tfoot>
			</table>
			</xsl:for-each>
		</div><!--fin de divLeft40-->

		<!--si es mvm o mvmb veo una caja mas-->
<!--		<xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/MVM or /EIS_CONSULTAS/CUADROPRINCIPALEIS/MVMB">-->
		<div class="divLeft40nopa">
			<p>&nbsp;</p>

			<table class="buscador">
			<thead>
				<tr class="subtituloTabla">
					<th>&nbsp;</th>
					<th colspan="2"><p><xsl:value-of select="document($doc)/translation/texts/item[@name='Informes_precalculados']/node()"/></p></th>
					<th>&nbsp;</th>
					<th>&nbsp;</th>
					<th>&nbsp;</th>
				</tr>
			</thead>

			<tbody>

			<!--	22mar19 Informes precalculados	-->
			<xsl:for-each select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/INFORMES_PRECALCULADOS/INFORMES/INFORME">
			<tr class="sinLinea">
				<td><p><img src="http://www.newco.dev.br/images/listNaranja.gif"/></p></td>
				<td class="textLeft" colspan="4">
					<p><strong><a style="text-decoration:none;" href="http://www.newco.dev.br/Descargas/{EIS_IPC_FICHERO}">
						<xsl:value-of select="TIPO"/>&nbsp;[<xsl:value-of select="EIS_IPC_FECHA"/>]
					</a></strong></p>
				</td>
				<td class="uno">&nbsp;</td>
			</tr>
			</xsl:for-each>

			<xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/PRESENTARMATRIZ">
				<tr class="sinLinea">
					<td><p><img src="http://www.newco.dev.br/images/listNaranja.gif"/></p></td>
					<td colspan="4">
							<p><strong><a style="text-decoration:none;" href="javascript:MostrarMatriz();">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='matriz_resultados_eis']/node()"/>
							</a></strong></p>
					</td>
					<td class="uno">&nbsp;</td>
				</tr>
			</xsl:if>

			<!-- Link clasificacion de proveedores -->
			<xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/ROL != 'VENDEDOR'">
			<tr class="sinLinea">
					<td><p><img src="http://www.newco.dev.br/images/listNaranja.gif"/></p></td>
					<td colspan="4">
							<p><strong><a style="text-decoration:none;" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/EIS/ClasificacionProveedoresEIS.xsql','Clasificaci�n proveedores',100,80,0,-50);">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='clasificacion_proveedores']/node()"/>
							</a></strong></p>
					</td>
					<td class="uno">&nbsp;</td>
			</tr>
			</xsl:if>

			<xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/PRESENTARINFORMEANUAL">
				<tr class="sinLinea">
					<td><p><img src="http://www.newco.dev.br/images/listNaranja.gif"/></p></td>
					<td class="textLeft" colspan="4">
							<p><strong><a style="text-decoration:none;" href="javascript:MostrarConsultaAnual();">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='consultas_evolucion_anual']/node()"/>
							</a></strong></p>
					</td>
					<td class="uno">&nbsp;</td>
				</tr>
			</xsl:if>

			<xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/MVM or /EIS_CONSULTAS/CUADROPRINCIPALEIS/MVMB">
				<tr class="sinLinea">
					<td colspan="6">&nbsp;</td>
                                </tr>
				<tr class="sinLinea">
					<td>&nbsp;</td>
					<td colspan="4" id="toogleTrigger">&nbsp;
						<span id="expandir">
							<a href="javascript:expandirFilas();" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/anadir.gif"/>&nbsp;
								<xsl:value-of select="document($doc)/translation/texts/item[@name='mostrar_matrices_precalculadas']/node()"/>
                                                        </a>
                                                </span>
						<span id="contraer" style="display:none;">
							<a href="javascript:contraerFilas();" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/contraer.gif"/>&nbsp;
								<xsl:value-of select="document($doc)/translation/texts/item[@name='ocultar_matrices_precalculadas']/node()"/>
                                                        </a>
                                                </span>
                                        </td>
					<td>&nbsp;</td>
				</tr>
				<!--
				<tr class="sinLinea">
					<td colspan="6">PRUEBAS&nbsp;</td>
                </tr>
				<xsl:for-each select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/LISTACONSULTASMATRIZ/CONSULTA">
					<xsl:if test="ID = 'RESUMEN_PROV34' or ID = 'RESUMEN_PROV55'">
					<tr class="elemToogle" style="display:none;">
						<td class="uno">&nbsp;</td>
						<td colspan="4">
							<p><a style="text-decoration:none;">
								<xsl:attribute name="href">javascript:MostrarPagPersonalizada('EISMatrizPrecalculada.xsql?IDPRECALCULADA=<xsl:value-of select="ID"/>&amp;PERIODO=A','_blank', 100, 80, 0, 10);</xsl:attribute>
								<xsl:value-of select="NOMBRE"/></a>&nbsp;
								<!- -ense�o image solo si es mvm o mvmb- ->
								<xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/PRESENTARENLACEALTERNATIVO">
									<a target="_blank">
										<xsl:attribute name="href">http://www.newco.dev.br/Gestion/EIS/EISMatrizPrecalculada.xsql?IDPRECALCULADA=<xsl:value-of select="ID"/>&amp;PERIODO=A</xsl:attribute>
										<img src="http://www.newco.dev.br/images/newPage.gif" alt="Nueva pag" class="newPage" style="display:none;"/>
									</a>
								</xsl:if>
						</p></td>
						<td class="uno">&nbsp;</td>
					</tr>
					</xsl:if>
				</xsl:for-each>
				-->

				<tr style="height:5px; display:none;" class="elemToogle">
					<td class="uno">&nbsp;</td>
					<td colspan="4">&nbsp;</td>
					<td class="uno">&nbsp;</td>
				</tr>

				<tr class="subTitle elemToogle" style="display:none;">
					<td class="uno">&nbsp;</td>
					<td class="cuarenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='indicador']/node()"/></td>
					<td align="right"><xsl:value-of select="document($doc)/translation/texts/item[@name='desv']/node()"/></td>
					<td align="right"><xsl:value-of select="document($doc)/translation/texts/item[@name='hist']/node()"/></td>
					<td align="right"><xsl:value-of select="document($doc)/translation/texts/item[@name='pen']/node()"/></td>
					<td class="uno">&nbsp;</td>
				</tr>

			<xsl:for-each select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/LISTACONSULTASMATRIZ/CONSULTA">
				<xsl:if test="ID != 'RESUMEN_PROV34' and ID != 'RESUMEN_PROV55'">
				<tr class="elemToogle" style="display:none;">
					<td class="uno">&nbsp;</td>
					<td><p><xsl:value-of select="NOMBRE"/>&nbsp;(<xsl:value-of select="CASILLASUTILIZADAS"/>)</p></td>
					<td align="right">
						<a style="text-decoration:none;">
							<xsl:attribute name="class">
								<xsl:choose>
								<xsl:when test="contains(VARIACION,'-')">rojoNormal</xsl:when>
								<xsl:otherwise>verdeNormal</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
							<xsl:attribute name="href">javascript:MostrarPagPersonalizada('EISMatrizPrecalculada.xsql?IDPRECALCULADA=<xsl:value-of select="ID"/>&amp;PERIODO=A','_blank', 100, 80, 0, 10);</xsl:attribute>
							<xsl:value-of select="VARIACION"/>%
						</a>&nbsp;
						<!--ense�o image solo si es mvm o mvmb-->
						<xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/PRESENTARENLACEALTERNATIVO">
							<a target="_blank">
								<xsl:attribute name="href">http://www.newco.dev.br/Gestion/EIS/EISMatrizPrecalculada.xsql?IDPRECALCULADA=<xsl:value-of select="ID"/>&amp;PERIODO=A</xsl:attribute>
								<img src="http://www.newco.dev.br/images/newPage.gif" alt="Nueva pag" class="newPage" style="display:none;"/>
							</a>
						</xsl:if>
					</td>
					<td align="right">
						<a style="text-decoration:none;">
							<xsl:attribute name="href">javascript:MostrarPagPersonalizada('EISMatrizPrecalculada.xsql?IDPRECALCULADA=<xsl:value-of select="ID"/>&amp;PERIODO=H','_blank', 100, 80, 0, 10);</xsl:attribute>
						(Hist)</a>&nbsp;
						<!--ense�o image solo si es mvm o mvmb-->
						<xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/PRESENTARENLACEALTERNATIVO">
							<a target="_blank">
								<xsl:attribute name="href">http://www.newco.dev.br/Gestion/EIS/EISMatrizPrecalculada.xsql?IDPRECALCULADA=<xsl:value-of select="ID"/>&amp;PERIODO=H</xsl:attribute>
								<img src="http://www.newco.dev.br/images/newPage.gif" alt="Nueva pag" class="newPage" style="display:none;"/>
							</a>
						</xsl:if>
					</td>
					<td align="right">
						<span>
							<xsl:attribute name="class">
								<xsl:choose>
								<xsl:when test="PENETRACION &lt; number(30)">rojoNormal</xsl:when>
								<xsl:otherwise>azul</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
							<xsl:value-of select="PENETRACION"/>%
						</span>
					</td>
					<td class="uno">&nbsp;</td>
				</tr>
				</xsl:if>
			</xsl:for-each>
			</xsl:if>
			</tbody>

			<tfoot>
				<tr class="sinLinea">
					<td class="footLeft">&nbsp;</td>
					<td colspan="4">&nbsp;</td>
					<td class="footRight">&nbsp;</td>
				</tr>
			</tfoot>
			</table>
		</div><!--fin de divLeft40-->
<!--		</xsl:if>-->


	</div><!--fin de right-->

	<xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/MVM or /EIS_CONSULTAS/CUADROPRINCIPALEIS/MVMB">
	<div class="divLeft90" style="margin:20px 0px 0px 2.5%;">
		<table class="grandeInicio">
		<thead>
			<tr class="subtituloTabla">
				<th colspan="4"><p style="text-align:center;"><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_info_diaria']/node()"/></p></th>
			</tr>
			<tr class="subTituloTabla">
				<td>&nbsp;</td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_numero_pedidos']/node()"/></td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_importe_pedidos']/node()"/></td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_control_pedidos']/node()"/></td>
			</tr>
		</thead>

		<tbody>
			<tr style="line-height:30px;border-bottom:1px solid #999;">
				<td style="padding-left:10px;text-align:left;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_dia_actual']/node()"/></strong></td>
				<td><span id="numPedidosDiaActual"></span><!--/INFORMACION_DIARIA/NUMERO_PEDIDOS/DIAACTUAL--></td>
				<td><span id="importePedidosDiaActual"></span><xsl:value-of select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/INFORMACION_DIARIA/IMPORTE_PEDIDOS/DIAACTUAL"/></td>
				<td><span id="controlPedidosDiaActual"></span><xsl:value-of select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/INFORMACION_DIARIA/CONTROL_PEDIDOS/DIAACTUAL"/></td>
			</tr>
			<tr style="line-height:30px;border-bottom:1px solid #999;">
				<td style="padding-left:10px;text-align:left;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_dia_anterior']/node()"/></strong></td>
				<td><span id="numPedidosDiaAnterior"></span></td>
				<td><span id="importePedidosDiaAnterior"></span></td>
				<td><span id="controlPedidosDiaAnterior"></span></td>
			</tr>
		</tbody>
		</table>
        </div>

	<div class="divLeft90" style="margin:20px 0px 0px 2.5%;">
		<table class="grandeInicio" id="tablaEmpresas">
		<thead>
			<tr class="subtituloTabla">
				<th style="border-right: 1px solid #999;">&nbsp;</th>
				<th colspan="4" style="border-right: 1px solid #999;"><p style="text-align:center;"><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_catalogo_prods_estandar']/node()"/></p></th>
				<th colspan="6" style="border-right: 1px solid #999;"><p style="text-align:center;"><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_pedidos_eur']/node()"/></p></th>
				<th colspan="2"><p style="text-align:center;"><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_incidencias_pedidos']/node()"/></p></th>
			</tr>

			<tr class="subTituloTabla">
				<td style="border-right:1px solid #999; text-align:left;padding-left:10px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_cliente']/node()"/></td>
				<td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='eis_potencial_catalogo_2line']/node()"/></td>
				<td class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_catalogados']/node()"/></td>
				<td class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_adjudicados']/node()"/></td>
				<td class="siete" style="border-right: 1px solid #999;"><xsl:copy-of select="document($doc)/translation/texts/item[@name='eis_comprados_12meses_2line']/node()"/></td>
				<td class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_doce_meses']/node()"/></td>
				<td class="seis"><xsl:copy-of select="document($doc)/translation/texts/item[@name='eis_potencial_mensual_2line']/node()"/></td>
				<td class="ocho"><xsl:copy-of select="document($doc)/translation/texts/item[@name='eis_mes_anterior']/node()"/></td>
				<td class="ocho"><xsl:copy-of select="document($doc)/translation/texts/item[@name='eis_ultimos_30_dias']/node()"/></td>
				<td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='eis_dia_anterior_2line']/node()"/></td>
				<td class="cinco" style="border-right: 1px solid #999;"><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_hoy']/node()"/></td>
				<td class="siete"><xsl:copy-of select="document($doc)/translation/texts/item[@name='eis_pendientes_aceptar_2line']/node()"/></td>
				<td class="ocho"><xsl:copy-of select="document($doc)/translation/texts/item[@name='eis_pedidos_problematicos_2line']/node()"/></td>
			</tr>
		</thead>

		<tbody>

		</tbody>
		</table>
        </div>
        </xsl:if>
        </xsl:otherwise>
      </xsl:choose><!--fin de choose si es admin-->
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>

<xsl:template name="ALARMAS">
    <!--idioma-->
	<xsl:variable name="lang"><xsl:value-of select="/EIS_CONSULTAS/LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
        <xsl:variable name="PRIMERACONSULTA"><xsl:value-of select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/LISTACONSULTAS/GRUPO/CONSULTA/ID"/></xsl:variable>
			<!--<table class="grandeInicio" style="border:1px solid #666;">-->
			<table class="buscador">
				<!--<tr class="subtituloTabla">-->
				<tr class="subTituloTabla">
					<th class="quince">&nbsp;</th>
					<th colspan="2" align="left">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='alarmas_control_automatico']/node()"/></th>
					<th><img src="http://www.newco.dev.br/images/cerrar.gif" alt="cerrar" id="cerrarAlarmas" class="cerrarEis"/></th>
				</tr>
				<xsl:if test="not(/EIS_CONSULTAS/CUADROPRINCIPALEIS/ALARMAS/ALARMA)">
				<tr class="sinLinea">
					<td>&nbsp;</td>
                    <td>&nbsp;</td>
					<td class="subTitle" align="left">
						<p><xsl:value-of select="document($doc)/translation/texts/item[@name='ninguna_alarma_activa']/node()"/>.</p>
					</td>
					<td>&nbsp;</td>
				</tr>
				</xsl:if>

			<tbody>
			<xsl:for-each select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/ALARMAS/ALARMA">
				<tr class="sinLinea">
					<td>&nbsp;</td>
					<td>
        				<xsl:choose>
            				<xsl:when test="POSITIVO = 'S'"><img src="http://www.newco.dev.br/images/SemaforoVerde.gif"/></xsl:when>
            				<xsl:otherwise><img src="http://www.newco.dev.br/images/SemaforoRojo.gif"/></xsl:otherwise>
        				</xsl:choose>
					</td>
					<td style="text-align:left;">
						<a style="text-decoration:none;">
							<xsl:attribute name="href">javascript:MostrarPag('<xsl:value-of select="ENLACE"/>');</xsl:attribute>
							<xsl:value-of select="NOMBRE"/>
						</a>&nbsp;
						<!--ense�o image solo si es mvm o mvmb-->
						<xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/PRESENTARENLACEALTERNATIVO">
							<a target="_blank">
								<xsl:attribute name="href"><xsl:value-of select="ENLACE"/></xsl:attribute>
								<img src="http://www.newco.dev.br/images/newPage.gif" alt="Nueva pag" class="newPage" style="display:none;"/>
							</a>
						</xsl:if>
					</td>
					<td>&nbsp;</td>
				</tr>
			</xsl:for-each>
			</tbody>

			</table>
</xsl:template><!--FIN DE ALARMAS-->

<xsl:template name="ALARMAS_ADMIN">
    <!--idioma-->
	<xsl:variable name="lang"><xsl:value-of select="/EIS_CONSULTAS/LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
	<xsl:variable name="PRIMERACONSULTA"><xsl:value-of select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/LISTACONSULTAS/GRUPO/CONSULTA/ID"/></xsl:variable>
	<table class="font-size:12px;width:90%;margin-left:5%;" border="0">
		<tr class="subtituloTabla">
			<th class="trenta">&nbsp;</th>
			<th colspan="3" align="left">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='alarmas_control_automatico']/node()"/></th>
		</tr>
		<xsl:if test="not(/EIS_CONSULTAS/CUADROPRINCIPALEIS/ALARMAS/ALARMA)">
		<tr class="sinLinea">
			<td class="trenta">&nbsp;</td>
            <td>&nbsp;</td>
			<td class="subTitle" align="left">
				<p><xsl:value-of select="document($doc)/translation/texts/item[@name='ninguna_alarma_activa']/node()"/>.</p>
			</td>
			<td>&nbsp;</td>
		</tr>
		</xsl:if>
		<tbody>
		<xsl:for-each select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/ALARMAS/ALARMA">
			<tr class="sinLinea">
            	<td class="trenta">&nbsp;</td>
				<td class="tres">
					<p style="height:17px;text-align:right;">
                        <xsl:choose>
                            <xsl:when test="POSITIVO = 'S'"><img src="http://www.newco.dev.br/images/SemaforoVerde.gif"/></xsl:when>
                            <xsl:otherwise><img src="http://www.newco.dev.br/images/SemaforoRojo.gif"/></xsl:otherwise>
                        </xsl:choose>
                        &nbsp;
                    </p>
                </td>
				<td class="textLeft">
					<a style="text-decoration:none;">
						<xsl:attribute name="href">javascript:MostrarPag('<xsl:value-of select="ENLACE"/>');</xsl:attribute>
						<xsl:value-of select="NOMBRE"/>
					</a>&nbsp;
					<!--ense�o image solo si es mvm o mvmb-->
					<xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/PRESENTARENLACEALTERNATIVO">
						<a target="_blank">
							<xsl:attribute name="href"><xsl:value-of select="ENLACE"/></xsl:attribute>
							<img src="http://www.newco.dev.br/images/newPage.gif" alt="Nueva pag" class="newPage" style="display:none;"/>
						</a>
					</xsl:if>
				</td>
				<td>&nbsp;</td>
			</tr>
		</xsl:for-each>
		</tbody>
	</table>
</xsl:template><!--FIN DE ALARMAS-->

<xsl:template name="CONSULTAS">
    <xsl:for-each select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/LISTACONSULTAS/GRUPO">
	<table class="grandeInicio" style="border:1px solid #666;">
	<thead>
		<tr class="subtituloTabla">
			<th class="quince">&nbsp;</th>
			<th colspan="2" align="left">&nbsp;<xsl:value-of select="NOMBRE"/></th>
			<th><img src="http://www.newco.dev.br/images/cerrar.gif" alt="cerrar" id="cerrarConsultas" class="cerrarEis"/></th>
		</tr>
	</thead>
	<tbody>
	<xsl:for-each select="./CONSULTA">
		<tr class="sinLinea">
           <td>&nbsp;</td>
			<td><img src="http://www.newco.dev.br/images/listNaranja.gif"/></td>
			<td class="textLeft">
                <a>
				<xsl:attribute name="href">javascript:MostrarConsulta('<xsl:value-of select="ID"/>');</xsl:attribute>
				<xsl:value-of select="NOMBRE"/>
                </a>&nbsp;
                <!--ense�o image solo si es mvm o mvmb-->
                <xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/PRESENTARENLACEALTERNATIVO">
				<a target="_blank">
                	<xsl:attribute name="href">http://www.newco.dev.br/Gestion/EIS/EISBasico.xsql?IDCONSULTA=<xsl:value-of select="ID"/></xsl:attribute>
                	<img src="http://www.newco.dev.br/images/newPage.gif" alt="Nueva pag" class="newPage" style="display:none;"/>
				</a>
                </xsl:if>
			</td>
			<td>&nbsp;</td>
		</tr>
	</xsl:for-each>
	</tbody>
	</table>
	</xsl:for-each>

</xsl:template><!--FIN DE consultas-->
</xsl:stylesheet>
