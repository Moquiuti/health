<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Presentacion de datos estadisticos de utilizacion de la plataforma MedicalVM
	Ultima revision: ET 7jul23 12:00 EISConsultas2022_240522.js
+-->
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
	<xsl:variable name="lang"><xsl:value-of select="/EIS_CONSULTAS/LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='sistema_info_direccion']/node()"/>&nbsp;(
	<xsl:value-of select="document($doc)/translation/texts/item[@name='eis']/node()"/>)</title>

	<!-- para pruebas del grafico	-->
	<style>
    	.container {
        	width: 1000px;
        	height: 600px;
    	}
	</style>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/Chart.bundle.min.2.9.3.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/EIS/EISConsultas2022_240522.js"></script>
	<link rel="stylesheet" type="text/css" href="http://www.newco.dev.br/General/TablaResumen-popup.css"/>
	<script type="text/javascript" src="http://www.newco.dev.br/General/TablaResumen-popup.js"></script>
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
		
	var DatasetsDiario=[];
	<xsl:for-each select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/RESUMENES_DIARIOS/RESUMEN_DIARIO[@IncluirGrafico='S']">
		var Dataset= [];
		
		var Columnas=[];
		<xsl:for-each select="COLUMNA">
			Columnas.push(<xsl:value-of select="VALOR_SINFORMATO"/>);
		</xsl:for-each>	
		Dataset["data"]=Columnas;
		Dataset["label"]='<xsl:value-of select="@Nombre"/>';
        Dataset["borderColor"]="#46d5f1";
        Dataset["backgroundColor"]="#EEEEEE";
        Dataset["fill"]=false;
		DatasetsDiario.push(Dataset);
	</xsl:for-each>

		cont = 0;
		<xsl:for-each select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/RESUMENES_DIARIOS/RESUMEN_DIARIO[@IncluirGrafico='S']">
			GruposDiario[cont]		= '<xsl:value-of select="@ID"/>';
			NombresGruposDiario[cont]	= '<xsl:value-of select="@Nombre"/>';

			cont2 = 0;
			<xsl:for-each select="COLUMNA">
				<!--ValoresGraficoDiario[cont][cont2] = <xsl:value-of select="VALOR_SINFORMATO"/>;-->
				if (cont==0) 
					NombresDias[cont2] = '<xsl:value-of select="DIA"/>/<xsl:value-of select="MES"/>';

                cont2++;
			</xsl:for-each>
            cont++;
		</xsl:for-each>

	var DatasetsMensual=[];
	<xsl:for-each select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/RESUMENES_MENSUALES/RESUMEN_MENSUAL[@IncluirGrafico='S']">
		var Dataset= [];
		
		var Columnas=[];
		<xsl:for-each select="COLUMNA">
			Columnas.push(<xsl:value-of select="VALOR_SINFORMATO"/>);
		</xsl:for-each>	
		Dataset["data"]=Columnas;
		Dataset["label"]='<xsl:value-of select="@Nombre"/>';
        Dataset["borderColor"]="#46d5f1";
        Dataset["backgroundColor"]="#EEEEEE";
        Dataset["fill"]=false;
		DatasetsMensual.push(Dataset);
	</xsl:for-each>

		cont = 0;
		<xsl:for-each select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/RESUMENES_MENSUALES/RESUMEN_MENSUAL[@IncluirGrafico='S']">
			GruposMensual[cont]		= '<xsl:value-of select="@ID"/>';
			NombresGruposMensual[cont]	= '<xsl:value-of select="@Nombre"/>';

			cont2 = 0;
			<xsl:for-each select="COLUMNA">
				<!--ValoresGraficoMensual[cont][cont2] = <xsl:value-of select="VALOR_SINFORMATO"/>;-->
				if (cont==0) 
					NombresMeses[cont2] = '<xsl:value-of select="MES"/>/<xsl:value-of select="ANYO"/>';

                cont2++;
			</xsl:for-each>
           cont++;
		</xsl:for-each>



		//	31may22 Presentamos "alert" con noticias
		var NoticiasDestacadas='<xsl:choose><xsl:when test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/NOTICIAS/DESTACAR_NOTICIAS">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';

		var Noticias=new Array();
		<xsl:for-each select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/NOTICIAS/NOTICIA">
			var Noticia=[];

			Noticia['Titulo']= '<xsl:value-of select="TITULO"/>';
			Noticia['Cuerpo']= '<xsl:value-of select="CUERPO"/>';
			Noticia['Url']= '<xsl:value-of select="DOC_NOTICIA/URL"/>';
			Noticia['Destacada']= '<xsl:value-of select="DESTACADA"/>';

			Noticias.push(Noticia);
		</xsl:for-each>

	</script>
</head>
<body onload="javascript:Inicio();">
<xsl:choose>
<xsl:when test="EIS_CONSULTAS/ROWSET/ROW/Sorry"><xsl:apply-templates select="EIS_CONSULTAS/ROWSET/ROW/Sorry"/></xsl:when>
<xsl:when test="EIS_CONSULTAS/SESION_CADUCADA"><xsl:apply-templates select="EIS_CONSULTAS/SESION_CADUCADA"/></xsl:when>
<xsl:otherwise>
	<!--idioma-->
	<xsl:variable name="lang"><xsl:value-of select="/EIS_CONSULTAS/LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

    <!--si es cuadro principal ensenno eis completo-->
    <xsl:choose>
    <xsl:when test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/CUADRO_AVANZADO and /EIS_CONSULTAS/CUADROPRINCIPALEIS/ROL != 'VENDEDOR'">
		<xsl:call-template name="Pagina_principal_completa">
			<xsl:with-param name="doc"><xsl:value-of select="$doc"/></xsl:with-param>		
		</xsl:call-template>
    </xsl:when>
    <!--otros usuarios-->
	<xsl:otherwise>
			<xsl:call-template name="Pagina_principal_reducida">
				<xsl:with-param name="doc"><xsl:value-of select="$doc"/></xsl:with-param>		
			</xsl:call-template>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:otherwise>
	</xsl:choose><!--fin de choose si es admin-->
</body>
</html>
</xsl:template>
<xsl:template name="Pagina_principal_completa">
	<xsl:param name="doc"/>
		<div id="pestanas">
			<ul class="pestannas w100">
				<li>
					<a id="actividadMensual" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='actividad_mensual']/node()"/></a>
				</li>
				<li>
					<a id="actividadDiaria" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='actividad_diaria']/node()"/></a>
				</li>
				<li>
					<a id="alarmas" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='alarmas']/node()"/></a>
				</li>
			</ul>
		</div>


		<!--	18ago16	Creamos una tabla para organizar mejor los elementos de la página	-->
		<div class="divLeft marginTop20">
		<table class="marginTop50">
		<tr class="sinLinea">
		<td>
			<div class="divLeft w180px marginTop20">
				&nbsp;&nbsp;&nbsp;<a class="btnNormal btn120px" href="javascript:MostrarConsultaPedidos();"><span class="w150px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Mensual']/node()"/></span></a>
				<xsl:choose>
				<xsl:when test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/MVM or /EIS_CONSULTAS/CUADROPRINCIPALEIS/MVMB or /EIS_CONSULTAS/CUADROPRINCIPALEIS/EMPRESA">
					<br/>
					<br/>
					<br/>
					&nbsp;&nbsp;&nbsp;<a class="btnNormal btn120px" href="javascript:MostrarMatriz();"><span class="w200px" style="display:inline-block;min-width:200px"><xsl:value-of select="document($doc)/translation/texts/item[@name='analisi_matricial']/node()"/></span></a>
					<br/>
					<br/>
					<br/>
					&nbsp;&nbsp;&nbsp;<a class="btnNormal btn120px" href="javascript:Proveedores();"><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/></a>
					<br/>
					<br/>
					<br/>
					&nbsp;&nbsp;&nbsp;<a class="btnNormal btn120px" href="javascript:MostrarConsultaAnual();"><xsl:value-of select="document($doc)/translation/texts/item[@name='datos_historicos2']/node()"/></a>
					<br/>
					<br/>
					<br/>
					&nbsp;&nbsp;&nbsp;<a class="btnNormal btn120px" href="javascript:showTablaResumen(true);"><xsl:value-of select="document($doc)/translation/texts/item[@name='tabla_resumen']/node()"/></a>
					<br/>
					<br/>
					<br/>
					<!--	18ago16	El botón de selecciones, junto al resto de botones		-->
					&nbsp;&nbsp;&nbsp;<a class="btnNormal btn120px" href="javascript:chSelecciones();"><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciones']/node()"/></a>
				</xsl:when>
				<xsl:otherwise>
					<!--	Para compradores con derechos a nivel de centro, botón proveedores para condiciones proveedores	y resumen historico-->
					<br/>
					<br/>
					<br/>
					&nbsp;&nbsp;&nbsp;<a class="btnNormal btn120px" href="javascript:MostrarConsultaAnual();"><xsl:value-of select="document($doc)/translation/texts/item[@name='datos_historicos2']/node()"/></a>&nbsp;
					<br/>
					<br/>
					<br/>
					&nbsp;&nbsp;&nbsp;<a class="btnNormal btn120px" href="javascript:CondicionesProveedores({/EIS_CONSULTAS/CUADROPRINCIPALEIS/IDEMPRESA});"><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/></a>
				</xsl:otherwise>
				</xsl:choose>
			</div>
		</td>
		<td style="width:1000px">
        	<div id="actividadMensualBox" class="eisBox" style="float:left;width:100%;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='indicador']/node()"/>:</label>&nbsp;<select class="w300px" id="IDINDICADORMENSUAL" name="IDINDICADORMENSUAL" onchange="javascript:CambioIndicador('MENSUAL');"/><br/>
				<canvas id="actMensual" width="1000" height="600"></canvas>
        	</div><!--fin de actividadMensualBox-->
			
        	<div id="actividadDiariaBox" class="eisBox" style="float:left;width:100%;display:none;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='indicador']/node()"/>:</label>&nbsp;<select class="w300px" id="IDINDICADORDIARIO" name="IDINDICADORDIARIO" onchange="javascript:CambioIndicador('DIARIO');"/><br/>
				<canvas id="actDiaria" width="1000" height="600"></canvas>
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
			<!--	6oct16	análisis de líneas de pedidos y análisis de lineas de licitaciones	-->
			&nbsp;&nbsp;&nbsp;*&nbsp;<a class="enlaceResaltado" href="http://www.newco.dev.br/Personal/BandejaTrabajo/AnalisisPedidos2022.xsql"><xsl:value-of select="document($doc)/translation/texts/item[@name='Analisis_pedidos']/node()"/></a><br/>
			&nbsp;&nbsp;&nbsp;*&nbsp;<a class="enlaceResaltado" href="http://www.newco.dev.br/Personal/BandejaTrabajo/AnalisisPedidosContrato2022.xsql"><xsl:value-of select="document($doc)/translation/texts/item[@name='Analisis_pedidos_contrato']/node()"/></a><br/>
			&nbsp;&nbsp;&nbsp;*&nbsp;<a class="enlaceResaltado" href="http://www.newco.dev.br/Gestion/EIS/AnalisisABCPedidos2022.xsql"><xsl:value-of select="document($doc)/translation/texts/item[@name='Analisis_pedidos_ABC']/node()"/></a><br/>
			&nbsp;&nbsp;&nbsp;*&nbsp;<a class="enlaceResaltado" href="http://www.newco.dev.br/Personal/BandejaTrabajo/PedidosPorProveedor2022.xsql"><xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_por_proveedor_y_centro']/node()"/></a><br/>
			&nbsp;&nbsp;&nbsp;*&nbsp;<a class="enlaceResaltado" href="http://www.newco.dev.br/Gestion/EIS/ResumenPedidosPorProveedor2022.xsql"><xsl:value-of select="document($doc)/translation/texts/item[@name='Resumen_pedidos_por_proveedor']/node()"/></a><br/>
			&nbsp;&nbsp;&nbsp;*&nbsp;<a class="enlaceResaltado" href="http://www.newco.dev.br/Gestion/EIS/PedidosPorProducto2022.xsql"><xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos_por_producto']/node()"/></a><br/>
			&nbsp;&nbsp;&nbsp;*&nbsp;<a class="enlaceResaltado" href="http://www.newco.dev.br/Gestion/Comercial/LicAnalisisLineas2022.xsql"><xsl:value-of select="document($doc)/translation/texts/item[@name='Analisis_licitaciones']/node()"/></a><br/>
			<xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/MVM or /EIS_CONSULTAS/CUADROPRINCIPALEIS/MVMB">
			&nbsp;&nbsp;&nbsp;*&nbsp;<a class="enlaceResaltado" href="http://www.newco.dev.br/Gestion/Comercial/LicAnalisisProveedores2022.xsql"><xsl:value-of select="document($doc)/translation/texts/item[@name='Analisis_proveedores_licitacion']/node()"/></a><br/>
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
		</div>

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
</xsl:template>
<xsl:template name="Pagina_principal_reducida">
	<xsl:param name="doc"/>
	<div class="divLeft margin25">
		<br/>
		<br/>
		<xsl:choose>
		<xsl:when test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/NOTICIAS/NOTICIA">
			<div class="boxInicio" id="pedidosBox" style="border:0px solid #939494;border-top:0;width:90%;margin: auto;">
				<xsl:apply-templates select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/NOTICIAS"/>
			</div>
		</xsl:when>
		<xsl:otherwise>
			<br/>
			<br/>
		</xsl:otherwise>
		</xsl:choose>
		<br/>
		<br/>
		<div style="float:left; width:10%;">&nbsp;</div>
		<div class="divLeft40nopa">
			<p>&nbsp;</p>
			<xsl:variable name="PRIMERACONSULTA"><xsl:value-of select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/LISTACONSULTAS/GRUPO/CONSULTA/ID"/></xsl:variable>
			<table class="buscador" style="font-size:14px;">
				<tr class="subtituloTabla">
					<th>&nbsp;</th>
					<th><p style="font-size:20px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='alarmas_control_automatico']/node()"/></p></th>
					<th>&nbsp;</th>
				</tr>
				<xsl:if test="not(/EIS_CONSULTAS/CUADROPRINCIPALEIS/ALARMAS/ALARMA)">
				<tr class="sinLinea">
					<td>&nbsp;</td>
					<td class="subTitle">
						<p style="font-size:20px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='ninguna_alarma_activa']/node()"/>.</p>
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
						<a class="fuenteDest">
							<xsl:attribute name="href"><xsl:value-of select="ENLACE2022"/></xsl:attribute>
							<xsl:value-of select="NOMBRE"/>
						</a>&nbsp;
						<!--enseño image solo si es mvm o mvmb-->
						<xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/PRESENTARENLACEALTERNATIVO">
							<a target="_blank">
								<xsl:attribute name="href"><xsl:value-of select="ENLACE2022"/></xsl:attribute>
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
		</div><!--fin de divLeft40-->

		<!--28ene22	<div class="divLeft40nopa">-->
		<div>
			<xsl:attribute name="class">
        	<xsl:choose>
            	<xsl:when test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/INFORMES_PRECALCULADOS/INFORMES/INFORME">divLeft30nopa</xsl:when>
            	<xsl:otherwise>divLeft40nopa</xsl:otherwise>
        	</xsl:choose>
			</xsl:attribute>
			<p>&nbsp;</p>
			<xsl:for-each select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/LISTACONSULTAS/GRUPO">
			<table class="buscador">
			<thead>
				<tr class="subtituloTabla">
					<th>&nbsp;</th>
					<th><p style="font-size:20px;"><xsl:value-of select="NOMBRE"/></p></th>
					<th>&nbsp;</th>
				</tr>
			</thead>

			<tbody>
			<xsl:for-each select="./CONSULTA">
				<tr class="sinLinea">
					<td><p><img src="http://www.newco.dev.br/images/listNaranja.gif"/></p></td>
					<td class="textLeft"><p><a style="font-size:18px;">
						<xsl:attribute name="href">javascript:MostrarConsulta('<xsl:value-of select="ID"/>');</xsl:attribute>
						<xsl:value-of select="NOMBRE"/></a>&nbsp;
						<!--enseño image solo si es mvm o mvmb-->
						<xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/PRESENTARENLACEALTERNATIVO">
							<a target="_blank">
								<xsl:attribute name="href">http://www.newco.dev.br/Gestion/EIS/EISBasico2022.xsql?IDCONSULTA=<xsl:value-of select="ID"/></xsl:attribute>
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
		<xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/INFORMES_PRECALCULADOS/INFORMES/INFORME">
		<div class="divLeft30nopa">
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
							<p><strong><a style="text-decoration:none;" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/EIS/ClasificacionProveedoresEIS2022.xsql','Clasificación proveedores',100,80,0,-50);">
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
							<xsl:attribute name="href">javascript:MostrarPagPersonalizada('EISMatrizPrecalculada2022.xsql?IDPRECALCULADA=<xsl:value-of select="ID"/>&amp;PERIODO=A','_blank', 100, 80, 0, 10);</xsl:attribute>
							<xsl:value-of select="VARIACION"/>%
						</a>&nbsp;
						<!--enseño image solo si es mvm o mvmb-->
						<xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/PRESENTARENLACEALTERNATIVO">
							<a target="_blank">
								<xsl:attribute name="href">http://www.newco.dev.br/Gestion/EIS/EISMatrizPrecalculada2022.xsql?IDPRECALCULADA=<xsl:value-of select="ID"/>&amp;PERIODO=A</xsl:attribute>
								<img src="http://www.newco.dev.br/images/newPage.gif" alt="Nueva pag" class="newPage" style="display:none;"/>
							</a>
						</xsl:if>
					</td>
					<td align="right">
						<a style="text-decoration:none;">
							<xsl:attribute name="href">javascript:MostrarPagPersonalizada('EISMatrizPrecalculada2022.xsql?IDPRECALCULADA=<xsl:value-of select="ID"/>&amp;PERIODO=H','_blank', 100, 80, 0, 10);</xsl:attribute>
						(Hist)</a>&nbsp;
						<!--enseño image solo si es mvm o mvmb-->
						<xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/PRESENTARENLACEALTERNATIVO">
							<a target="_blank">
								<xsl:attribute name="href">http://www.newco.dev.br/Gestion/EIS/EISMatrizPrecalculada2022.xsql?IDPRECALCULADA=<xsl:value-of select="ID"/>&amp;PERIODO=H</xsl:attribute>
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
		</xsl:if><!--/EIS_CONSULTAS/CUADROPRINCIPALEIS/INFORMES_PRECALCULADOS-->

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
					<td class="textLeft" >
						<a style="text-decoration:none;font-size:16px;">
							<xsl:attribute name="href"><xsl:value-of select="ENLACE"/></xsl:attribute>
							<xsl:value-of select="NOMBRE"/>
						</a>&nbsp;
						<!--enseño image solo si es mvm o mvmb-->
						<xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/PRESENTARENLACEALTERNATIVO">
							<a><!-- 21dic21 Abrimos en la misma pagina target="_blank"-->
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
	<table class="buscador" style="width:100%;" border="0">
		<!--
		<tr class="subtituloTabla">
			<th class="cinco">&nbsp;</th>
			<th	class="textLeft" colspan="2">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='alarmas_control_automatico']/node()"/></th>
			<th class="cinco">&nbsp;</th>
		</tr>
		-->
		<xsl:if test="not(/EIS_CONSULTAS/CUADROPRINCIPALEIS/ALARMAS/ALARMA)">
		<tr class="sinLinea">
			<td>&nbsp;</td>
			<td class="textLeft" colspan="2">
				<p><xsl:value-of select="document($doc)/translation/texts/item[@name='ninguna_alarma_activa']/node()"/>.</p>
			</td>
			<td>&nbsp;</td>
		</tr>
		</xsl:if>
		<tbody>
		<xsl:for-each select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/ALARMAS/ALARMA">
			<tr class="sinLinea">
            	<td>&nbsp;</td>
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
					<a style="text-decoration:none;font-size:16px;">
						<xsl:attribute name="href"><xsl:value-of select="ENLACE"/></xsl:attribute>
						<strong><xsl:value-of select="NOMBRE"/></strong>
					</a>&nbsp;
					<!--enseño image solo si es mvm o mvmb-->
					<xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/PRESENTARENLACEALTERNATIVO">
						<a><!-- 21dic21 Abrimos en la misma pagina target="_blank"-->
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
                <!--enseño image solo si es mvm o mvmb-->
                <xsl:if test="/EIS_CONSULTAS/CUADROPRINCIPALEIS/PRESENTARENLACEALTERNATIVO">
				<a target="_blank">
                	<xsl:attribute name="href">http://www.newco.dev.br/Gestion/EIS/EISBasico2022.xsql?IDCONSULTA=<xsl:value-of select="ID"/></xsl:attribute>
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

<!--	28ene22 Nuevo template de NOTICIAS	-->
<xsl:template match="NOTICIAS">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/EIS_CONSULTAS/LANG"><xsl:value-of select="/EIS_CONSULTAS/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!--30may22 Destacar noticias-->
	<xsl:variable name="destacar">
		<xsl:choose>
		<xsl:when test="DESTACAR_NOTICIAS">S</xsl:when>
		<xsl:otherwise>N</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<table class="noticiasMvm" border="0">
		<tr class="tituloTabla">
			<th colspan="3">
				<p><xsl:value-of select="document($doc)/translation/texts/item[@name='noticias_de']/node()"/>&nbsp;<xsl:value-of select="/EIS_CONSULTAS/CUADROPRINCIPALEIS/PORTAL/PMVM_NOMBRE"/></p>
			</th>
			<th class="plegado">&nbsp;</th>
		</tr>

		<xsl:for-each select="NOTICIA">
			<tr class="conhover">
				<td>
					<img src="http://www.newco.dev.br/images/listAzul.gif" alt="cuadrado"/>
					<xsl:copy-of select="FECHA"/>
				</td>
				<td>
					<xsl:choose>
					<xsl:when test="not(ENLACE)">
						<xsl:value-of select="TITULO"/>
					</xsl:when>
					<xsl:otherwise>
						<a href="{ENLACE/NOT_ENLACE_URL}" title="{ENLACE/NOT_ENLACE_URL}" target="_blank"><xsl:copy-of select="TITULO"/></a>
					</xsl:otherwise>
					</xsl:choose>
					
					<xsl:if test="DOC_NOTICIA">
						&nbsp;&nbsp;&nbsp;Doc:<a href="http://www.newco.dev.br/Documentos/{DOC_NOTICIA/URL}" target="_blank"><xsl:value-of select="DOC_NOTICIA/NOMBRE"/></a>
					</xsl:if>
					
				</td>
				<td><xsl:copy-of select="CUERPO"/></td>
				<td class="cinco">
					<xsl:if test="$destacar='N'">
        				<a class="btnDestacadoPeq" href="javascript:NoticiaLeida('{ID}');"><xsl:value-of select="document($doc)/translation/texts/item[@name='leida']/node()"/></a>
					</xsl:if>
    			</td>
			</tr>
		</xsl:for-each>

		<tr>
			<td colspan="3">&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
	<br/><br/>
</xsl:template>


</xsl:stylesheet>
