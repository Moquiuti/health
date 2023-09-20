<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Página de inicio
	Ultima revisión ET: 3ago22 12:15 WFStatus2022_110122.js EISConsultas2022_240522.js cargaDocAlbaran_251019.js-> deberia ser opcional, mantenemos durante un tiempo
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="usuario" select="@US_ID"/>

<xsl:template match="/WorkFlowPendientes">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>


<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when> 
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<meta http-equiv="Cache-Control" Content="no-cache"/>
	
	<title><xsl:value-of select="/WorkFlowPendientes/INICIO/PORTAL/PMVM_ID"/>:&nbsp;<xsl:value-of select="/WorkFlowPendientes/INICIO/EMPRESA"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<link rel="stylesheet" href="http://www.newco.dev.br/General/owl.carousel.min.css"/>
	<link rel="stylesheet" href="http://www.newco.dev.br/General/owl.theme.default.min.css"/>
	<script type="text/javascript" src="http://www.newco.dev.br/General/owl.carousel.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/Chart.bundle.min.2.9.3.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>


	<script type="text/javascript">
		var Empresa ='<xsl:value-of select="/WorkFlowPendientes/INICIO/EMPRESA"/>';
		var IDPortal ='<xsl:value-of select="/WorkFlowPendientes/INICIO/PORTAL/PMVM_ID"/>';
		var MailDestino ='<xsl:value-of select="/WorkFlowPendientes/INICIO/PORTAL/PMVM_MAIL_CDC"/>';
		var AlbaranOpcional='<xsl:choose><xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/ALBARAN_OPCIONAL">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';

		var mantLicitaciones = '<xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_licitaciones']/node()"/>';
		var InicioBuscadorConfirm = '<xsl:value-of select="document($doc)/translation/texts/item[@name='inicio_buscador_confirm']/node()"/>';

		var str_licitaciones= '<xsl:value-of select="document($doc)/translation/texts/item[@name='negociacion']/node()"/>';
		var str_evaluaciones= '<xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion']/node()"/>';
		var str_incidencias= '<xsl:value-of select="document($doc)/translation/texts/item[@name='incidencias']/node()"/>';
		var str_solicitudes= '<xsl:value-of select="document($doc)/translation/texts/item[@name='catalogacion']/node()"/>';
		var str_SOLICITUDESOFERTA= '<xsl:value-of select="document($doc)/translation/texts/item[@name='ofertas']/node()"/>';
		var str_gestion_actividad  = '<xsl:value-of select="document($doc)/translation/texts/item[@name='actividad']/node()"/>';
		var remove  = '<xsl:value-of select="document($doc)/translation/texts/item[@name='remove']/node()"/>';
		
		var str_DocsObligatorios  = '<xsl:value-of select="document($doc)/translation/texts/item[@name='Documentos_obligatorios']/node()"/>';
		
		var inicioGrafico='<xsl:choose><xsl:when test="INICIO/INICIO_GRAFICO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';

		//	31may22 Presentamos "alert" con noticias
		var NoticiasDestacadas='<xsl:choose><xsl:when test="/WorkFlowPendientes/INICIO/NOTICIAS/DESTACAR_NOTICIAS">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';

		var Noticias=new Array();
		<xsl:for-each select="/WorkFlowPendientes/INICIO/NOTICIAS/NOTICIA">
			var Noticia=[];

			Noticia['Titulo']= '<xsl:value-of select="TITULO"/>';
			Noticia['Cuerpo']= '<xsl:value-of select="CUERPO"/>';
			Noticia['Url']= '<xsl:value-of select="DOC_NOTICIA/URL"/>';
			Noticia['Destacada']= '<xsl:value-of select="DESTACADA"/>';

			Noticias.push(Noticia);
		</xsl:for-each>
	</script>

	<xsl:if test="/WorkFlowPendientes/INICIO/INICIO_GRAFICO">
	<script type="text/javascript">

		var IDPais	= '<xsl:value-of select="/WorkFlowPendientes/INICIO/IDPAIS"/>';
		var IDIdioma	= '<xsl:value-of select="/WorkFlowPendientes/INICIO/IDIDIOMA"/>';

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
		var NumGruposDiario		= <xsl:value-of select="count(/WorkFlowPendientes/INICIO/RESUMENES_DIARIOS/RESUMEN_DIARIO[@IncluirGrafico='S'])"/>;
		var NumDias			= (<xsl:value-of select="count(/WorkFlowPendientes/INICIO/RESUMENES_DIARIOS/RESUMEN_DIARIO[@IncluirGrafico='S']/COLUMNA)"/> / NumGruposDiario);
		var NumGruposMensual		= <xsl:value-of select="count(/WorkFlowPendientes/INICIO/RESUMENES_MENSUALES/RESUMEN_MENSUAL[@IncluirGrafico='S'])"/>;
		var NumMeses			= (<xsl:value-of select="count(/WorkFlowPendientes/INICIO/RESUMENES_MENSUALES/RESUMEN_MENSUAL[@IncluirGrafico='S']/COLUMNA)"/> / NumGruposMensual);
		var NombresDias			= [];
		var NombresMeses		= [];
		
	var DatasetsDiario=[];
	<xsl:for-each select="/WorkFlowPendientes/INICIO/RESUMENES_DIARIOS/RESUMEN_DIARIO[@IncluirGrafico='S']">
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
		<xsl:for-each select="/WorkFlowPendientes/INICIO/RESUMENES_DIARIOS/RESUMEN_DIARIO[@IncluirGrafico='S']">
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
	<xsl:for-each select="/WorkFlowPendientes/INICIO/RESUMENES_MENSUALES/RESUMEN_MENSUAL[@IncluirGrafico='S']">
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
		<xsl:for-each select="/WorkFlowPendientes/INICIO/RESUMENES_MENSUALES/RESUMEN_MENSUAL[@IncluirGrafico='S']">
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

	</script>
	</xsl:if>

 	<script type="text/javascript" src="http://www.newco.dev.br/Personal/BandejaTrabajo/WFStatus2022_110122.js"></script>
 	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/EIS/EISConsultas2022_240522.js"></script>	<!--para el grafico de compras	-->
    <script type="text/javascript" src="http://www.newco.dev.br/Personal/BandejaTrabajo/cargaDocAlbaran_251019.js"></script>	<!--deberia ser opcional, mantenemos durante un tiempo-->
  
</head>
<body>
	<!--onLoad="javascript:EliminaCookies();"-->
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<form  method="post" name="Form1" id="Form1" action="WFStatusSave2022.xsql">
	<input type="hidden" name="IDPAIS" value="{/WorkFlowPendientes/INICIO/IDPAIS}"/>
	<input type="hidden" name="IDOFERTA"/>
	<input type="hidden" name="IDMOTIVO"/>
	<input type="hidden" name="FECHAPEDIDO"/>
	<input type="hidden" name="NUEVAFECHAENTREGA"/>
	<input type="hidden" name="FECHAACTUAL" value="{INICIO/PEDIDOSPROBLEMATICOS/FECHAACTUAL}"/>
	<input type="hidden" name="COMENTARIOS"/>
	<input type="hidden" name="BLOQUEADO"/>
	<input type="hidden" name="NOCUMPLEPEDMIN"/>
	<input type="hidden" name="FARMACIA"/>
	<input type="hidden" name="MATERIAL"/>
	<input type="hidden" name="SINSTOCKS"/>
    <input type="hidden" name="TODOS12MESES"/>
    <input type="hidden" name="INCFUERAPLAZO"/>
    <input type="hidden" name="PED_ENTREGADOOK"/>
    <input type="hidden" name="PED_PEDIDONOCOINCIDE"/>
    <input type="hidden" name="BUSCAR_PACKS"/>
    <input type="hidden" name="PED_RETRASADO"/>
    <input type="hidden" name="PED_ENTREGADOPARCIAL"/>
    <input type="hidden" name="PED_NOINFORMADOENPLATAFORMA"/>
    <input type="hidden" name="PED_PRODUCTOSANYADIDOS"/>
    <input type="hidden" name="PED_PRODUCTOSRETIRADO"/>
    <input type="hidden" name="PED_MALAATENCIONPROV"/>
    <input type="hidden" name="PED_URGENTE"/>
    <input type="hidden" name="PED_RETRASODOCTECNICA"/>
    <input type="hidden" name="ALBARAN"/>
    <input type="hidden" name="IDALBARAN"/>
    <!--subir documentos-->
    <input type="hidden" name="CADENA_DOCUMENTOS" />
    <input type="hidden" name="DOCUMENTOS_BORRADOS"/>
    <input type="hidden" name="BORRAR_ANTERIORES"/>
    <input type="hidden" name="ID_USUARIO" value="{/WorkFlowPendientes/INICIO/IDUSUARIO}" />
    <input type="hidden" name="TIPO_DOC" value="ALBARAN"/>
    <input type="hidden" name="DOC_DESCRI" />
    <input type="hidden" name="REMOVE" value="{document($doc)/translation/texts/item[@name='remove']/node()}"/>
    <input type="hidden" name="CHANGE_PROV" />
    <input type="hidden" name="IDPROVEEDOR_ALB" value="{/WorkFlowPendientes/INICIO/IDEMPRESA}" />
    <input type="hidden" name="SOLOPEDIDOS" id="SOLOPEDIDOS" value="{/WorkFlowPendientes/INICIO/SOLOPEDIDOS}" />
    <input type="hidden" name="BUSQUEDASESPECIALES" id="BUSQUEDASESPECIALES" value="{/WorkFlowPendientes/INICIO/BUSQUEDASESPECIALES}"/>
            
	<xsl:choose>
	<!-- Error en alguna sentencia del XSQL -->
	<xsl:when test="INICIO/xsql-error">
		<xsl:apply-templates select="INICIO/xsql-error"/>
	</xsl:when>
	<xsl:when test="INICIO/SESION_CADUCADA">
		<xsl:for-each select="INICIO/SESION_CADUCADA">
			<xsl:if test="position()=last()">
				<xsl:apply-templates select="."/>
			</xsl:if>
		</xsl:for-each>
	</xsl:when>
	<xsl:otherwise>
		<!--
        <xsl:call-template name="estiloIndip"/>		
		-->
		
		<!--	9ene20 No parece necesario
		<xsl:apply-templates select="INICIO/CABECERAS"/>
		-->
		
		<div class="divLeft">
			<!-- 26may16	<xsl:if test="INICIO/CUADRO_AVANZADO or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN = 'MVM' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN = 'MVMB'">-->
			<xsl:choose>
				<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR and (INICIO/CUADRO_AVANZADO or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PERMITIR_CONTROL_PEDIDOS)">
					<xsl:call-template name="ADMIN"/>
				</xsl:when>

				<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR and not(INICIO/CUADRO_AVANZADO) and not (INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PERMITIR_CONTROL_PEDIDOS)">
					<xsl:call-template name="CLIENTE"/>
				</xsl:when>

				<!--proveedor-->
				<xsl:otherwise>
					<xsl:apply-templates select="INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR"/>
				</xsl:otherwise>
			</xsl:choose>
		</div>
	</xsl:otherwise>
	</xsl:choose>
	</form>

	<!--FORM DE MENSAJES DE JS-->
	<form name="MensajeJS">
		<input type="hidden" name="ANADIR_COMENTARIO_SITUACION" value="{document($doc)/translation/texts/item[@name='anadir_comentario_situacion']/node()}"/>
		<input type="hidden" name="INFORMAR_ALBARAN" value="{document($doc)/translation/texts/item[@name='informar_albaran']/node()}"/>
		<input type="hidden" name="FECHA_SALIDA_INFORMADA" value="{document($doc)/translation/texts/item[@name='fecha_salida_informada']/node()}"/>
		<input type="hidden" name="FECHA_SALIDA_DEBE_SER" value="{document($doc)/translation/texts/item[@name='fecha_salida_debe_ser']/node()}"/>
		<input type="hidden" name="PEDIDO_PROB" value="{document($doc)/translation/texts/item[@name='pedidos_problematicos']/node()}"/>
		<input type="hidden" name="PEDIDO_PROB1" value="{document($doc)/translation/texts/item[@name='pedidos_problematicos1']/node()}"/>
		<input type="hidden" name="PEDIDO_PROB2" value="{document($doc)/translation/texts/item[@name='pedidos_problematicos2']/node()}"/>
		<input type="hidden" name="INFORMAR_ESTADO_PEDIDO" value="{document($doc)/translation/texts/item[@name='informar_estado_pedido']/node()}"/>
		<input type="hidden" name="FECHA_ENTRGA_MENOR" value="{document($doc)/translation/texts/item[@name='fecha_entrega_menor']/node()}"/>
	</form>
	<!--FIN DE FORM DE MENSAJES DE JS-->
        
    <div id="uploadFrame" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>
    <div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>
</body>
</html>
</xsl:template>

<!--ADMIN DE MVM-->
<xsl:template name="ADMIN">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!--<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN='MVM'">-->
	
	
	<div class="divLeft">
	<xsl:if test="/WorkFlowPendientes/INICIO/SOLOPEDIDOS='N'">
	<div class="coluna_esquerda">
		<div class="coluna_logo_empresa">
			<div class="logo_empresa">
				<img src="{INICIO/URLLOGOTIPO}" />
			</div>
			<div class="coluna_empresa">	
				<xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:<br/>	
				<xsl:choose>
				<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDEMPRESA">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDEMPRESA/field"/>
						<xsl:with-param name="onChange">javascript:cbEmpresaChange();</xsl:with-param>
						<xsl:with-param name="claSel">w225px</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<input type="textbox" class="fondoAzul w225px" value="{INICIO/EMPRESA}" disabled="disabled"/>
					<input type="hidden" name="IDEMPRESA" value="{IDEMPRESA}" />
				</xsl:otherwise>
				</xsl:choose>
			</div>
			<xsl:choose>
			<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDCENTRO">
				<div class="coluna_empresa">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:<br/>				
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDCENTRO/field"/>
						<xsl:with-param name="onChange">javascript:cbEmpresaChange();</xsl:with-param>
						<xsl:with-param name="claSel">w225px</xsl:with-param>
					</xsl:call-template>
				</div>
			</xsl:when>
			<xsl:otherwise>
					<input type="hidden" name="IDCENTRO" value="" />
			</xsl:otherwise>
			</xsl:choose>
		</div>
	</div>
	<div class="coluna_direita">
		<div class="owl-carousel owl-theme">
			<xsl:choose>
			<xsl:when test="INICIO/IDPAIS=55 and INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/PEDIDOS">
				<!--	31may22 Cambiamos el orden para Brasil, dando mas relevancia a las licitaciones	
					Pend. Forn. Aceitar
					Cotação Expiram Hoje
					Cot. não iniciadas
					Cotações Ativas
					Cot. pedidos pendentes
					Entregas Hoje
					Ped. Parc. 30d.
					Pedidos 12h
					Cotações 12h
					Pedidos 30d.
					Cotações 30d.
					Ped. Emerg. 30d.
					Cot. emergencias
					Pedidos Pendentes
					Controle de Equipe (12h)
				-->
				<div class="indicadores"  onclick="javascript:IndicadorPedidos('PEDIDOSACEPTAR');">
					<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_pend_aceptar']/node()"/>&nbsp;</div>
					<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_PEND_ACEPTAR"/></div>
					<div class="rodape_indicadores positivo"><xsl:value-of select="INICIO/DIVISA/PREFIJO"/><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_PEND_ACEPTAR_IMPORTE"/><xsl:value-of select="INICIO/DIVISA/SUFIJO"/></div>
				</div>
				<div class="indicadores"  onclick="javascript:IndicadorLicitaciones('CERRARHOY');">
					<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_vencen_hoy']/node()"/>&nbsp;</div>
					<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/LICITACIONES_VENCENHOY"/></div>
				</div>
				<div class="indicadores"  onclick="javascript:IndicadorLicitaciones('NOINICIADAS');">
					<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_no_iniciadas']/node()"/>&nbsp;</div>
					<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/LICITACIONES_NOINICIADAS"/></div>
				</div>
				<div class="indicadores"  onclick="javascript:IndicadorLicitaciones('ACTIVAS');">
					<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_activas']/node()"/>&nbsp;</div>
					<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/LICITACIONES_ACTIVAS"/></div>
				</div>
				<div class="indicadores"  onclick="javascript:IndicadorLicitaciones('PEDIDOSPENDIENTES');">
					<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_pedidos_pendientes']/node()"/>&nbsp;</div>
					<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/LICITACIONES_PEDIDOSPEND"/></div>
				</div>
				<div class="indicadores"  onclick="javascript:IndicadorPedidos('ENTREGASHOY');">
					<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='entregas_hoy']/node()"/>&nbsp;</div>
					<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/ENTREGAS_HOY"/></div>
					<div class="rodape_indicadores positivo"><xsl:value-of select="INICIO/DIVISA/PREFIJO"/><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/ENTREGAS_HOY_IMPORTE"/><xsl:value-of select="INICIO/DIVISA/SUFIJO"/></div>
				</div>
				<div class="indicadores"  onclick="javascript:IndicadorPedidos('PEDIDOSPARCIALES');">
					<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_parc_30d']/node()"/>&nbsp;</div>
					<div class="meio_indicadores negativo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_PARCIALES"/></div>
					<div class="rodape_indicadores negativo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_PARCIALES_PORC"/>%</div>
				</div>
				<div class="indicadores"  onclick="javascript:IndicadorPedidos('PEDIDOSHOY');">
					<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_12h']/node()"/>&nbsp;</div>
					<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/PEDIDOS"/></div>
					<div class="rodape_indicadores positivo"><xsl:value-of select="INICIO/DIVISA/PREFIJO"/><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/PEDIDOS_IMPORTE"/><xsl:value-of select="INICIO/DIVISA/SUFIJO"/></div>
				</div>
				<div class="indicadores"  onclick="javascript:IndicadorLicitaciones('1DIA');">
					<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_12h']/node()"/>&nbsp;</div>
					<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/LICITACIONES"/></div>
				</div>
				<div class="indicadores"  onclick="javascript:IndicadorPedidos('PEDIDOS30DIAS');">
					<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_30d']/node()"/>&nbsp;</div>
					<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS"/></div>
					<div class="rodape_indicadores positivo"><xsl:value-of select="INICIO/DIVISA/PREFIJO"/><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_IMPORTE"/><xsl:value-of select="INICIO/DIVISA/SUFIJO"/></div>
				</div>
				<div class="indicadores"  onclick="javascript:IndicadorLicitaciones('30DIAS');">
					<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_30d']/node()"/>&nbsp;</div>
					<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/LICITACIONES"/></div>
				</div>
				<div class="indicadores"  onclick="javascript:IndicadorPedidos('PEDIDOSURGENTES');">
					<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_urg_30d']/node()"/>&nbsp;</div>
					<div class="meio_indicadores negativo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_URGENTES"/></div>
					<div class="rodape_indicadores negativo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_URGENTES_PORC"/>%</div>
				</div>
				<div class="indicadores"  onclick="javascript:IndicadorLicitaciones('URGENTES');">
					<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_urgentes']/node()"/>&nbsp;</div>
					<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/LICITACIONES_URGENTES"/></div>
				</div>
				<div class="indicadores"  onclick="javascript:IndicadorPedidos('PEDIDOSPENDIENTES');">
					<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_pendientes']/node()"/>&nbsp;</div>
					<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_PENDIENTES"/></div>
					<div class="rodape_indicadores positivo"><xsl:value-of select="INICIO/DIVISA/PREFIJO"/><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_PEND_IMPORTE"/><xsl:value-of select="INICIO/DIVISA/SUFIJO"/></div>
				</div>
				<xsl:if test="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/CONTROLPEDIDOS_USUARIO>0">
					<div class="indicadores"  onclick="javascript:IndicadorPedidos('CONTROLESUSUARIOHOY');">
						<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='gestiones_usuario_12h']/node()"/>&nbsp;</div>
						<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/CONTROLPEDIDOS_USUARIO"/></div>
						<div class="rodape_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/CONTROLPEDIDOS_USUARIO_PORC"/>% (<xsl:value-of select="document($doc)/translation/texts/item[@name='del_equipo']/node()"/>)</div>
					</div>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/PEDIDOS">
					<div class="indicadores"  onclick="javascript:IndicadorPedidos('ENTREGASHOY');">
						<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='entregas_hoy']/node()"/>&nbsp;</div>
						<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/ENTREGAS_HOY"/></div>
						<div class="rodape_indicadores positivo"><xsl:value-of select="INICIO/DIVISA/PREFIJO"/><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/ENTREGAS_HOY_IMPORTE"/><xsl:value-of select="INICIO/DIVISA/SUFIJO"/></div>
					</div>
					<div class="indicadores"  onclick="javascript:IndicadorPedidos('PEDIDOSACEPTAR');">
						<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_pend_aceptar']/node()"/>&nbsp;</div>
						<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_PEND_ACEPTAR"/></div>
						<div class="rodape_indicadores positivo"><xsl:value-of select="INICIO/DIVISA/PREFIJO"/><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_PEND_ACEPTAR_IMPORTE"/><xsl:value-of select="INICIO/DIVISA/SUFIJO"/></div>
					</div>
					<div class="indicadores"  onclick="javascript:IndicadorPedidos('PEDIDOSHOY');">
						<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_12h']/node()"/>&nbsp;</div>
						<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/PEDIDOS"/></div>
						<div class="rodape_indicadores positivo"><xsl:value-of select="INICIO/DIVISA/PREFIJO"/><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/PEDIDOS_IMPORTE"/><xsl:value-of select="INICIO/DIVISA/SUFIJO"/></div>
					</div>
					<div class="indicadores"  onclick="javascript:IndicadorPedidos('PEDIDOSPENDIENTES');">
						<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_pendientes']/node()"/>&nbsp;</div>
						<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_PENDIENTES"/></div>
						<div class="rodape_indicadores positivo"><xsl:value-of select="INICIO/DIVISA/PREFIJO"/><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_PEND_IMPORTE"/><xsl:value-of select="INICIO/DIVISA/SUFIJO"/></div>
					</div>
					<xsl:if test="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_PREPAGO>0">
						<div class="indicadores"  onclick="javascript:IndicadorPedidos('PEDIDOSPREPAGO');">
							<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_prepago']/node()"/>&nbsp;</div>
							<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_PREPAGO"/></div>
							<div class="rodape_indicadores positivo"><xsl:value-of select="INICIO/DIVISA/PREFIJO"/><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_PREP_IMPORTE"/><xsl:value-of select="INICIO/DIVISA/SUFIJO"/></div>
						</div>
					</xsl:if>
					<div class="indicadores"  onclick="javascript:IndicadorPedidos('PEDIDOS30DIAS');">
						<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_30d']/node()"/>&nbsp;</div>
						<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS"/></div>
						<div class="rodape_indicadores positivo"><xsl:value-of select="INICIO/DIVISA/PREFIJO"/><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_IMPORTE"/><xsl:value-of select="INICIO/DIVISA/SUFIJO"/></div>
					</div>
					<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN='MVM' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN='EMPRESA'">
						<div class="indicadores"  onclick="javascript:IndicadorPedidos('PEDIDOSRETRASADOS');">
							<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_retr_30d']/node()"/>&nbsp;</div>
							<div class="meio_indicadores negativo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_RETRASADOS"/></div>
							<div class="rodape_indicadores negativo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_RETRASADOS_PORC"/>%</div>
						</div>
					</xsl:if>
					<div class="indicadores"  onclick="javascript:IndicadorPedidos('PEDIDOSURGENTES');">
						<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_urg_30d']/node()"/>&nbsp;</div>
						<div class="meio_indicadores negativo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_URGENTES"/></div>
						<div class="rodape_indicadores negativo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_URGENTES_PORC"/>%</div>
					</div>
					<div class="indicadores"  onclick="javascript:IndicadorPedidos('PEDIDOSPARCIALES');">
						<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_parc_30d']/node()"/>&nbsp;</div>
						<div class="meio_indicadores negativo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_PARCIALES"/></div>
						<div class="rodape_indicadores negativo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_PARCIALES_PORC"/>%</div>
					</div>
					<xsl:if test="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/CONTROLPEDIDOS_USUARIO>0">
						<div class="indicadores"  onclick="javascript:IndicadorPedidos('CONTROLESUSUARIOHOY');">
							<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='gestiones_usuario_12h']/node()"/>&nbsp;</div>
							<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/CONTROLPEDIDOS_USUARIO"/></div>
							<div class="rodape_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/CONTROLPEDIDOS_USUARIO_PORC"/>% (<xsl:value-of select="document($doc)/translation/texts/item[@name='del_equipo']/node()"/>)</div>
						</div>
					</xsl:if>
					<xsl:if test="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/LICITACIONES_ACTIVAS=0">
						<div class="indicadores"  onclick="javascript:IndicadorPedidos('CONTROLESEQUIPOHOY');">
							<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='gestiones_equipo_12h']/node()"/>&nbsp;</div>
							<div class="rodape_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/CONTROLPEDIDOS_EQUIPO"/></div>
						</div>
					</xsl:if>
				</xsl:if>
				<xsl:if test="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/LICITACIONES_ACTIVAS>0">
					<div class="indicadores"  onclick="javascript:IndicadorLicitaciones('ACTIVAS');">
						<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_activas']/node()"/>&nbsp;</div>
						<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/LICITACIONES_ACTIVAS"/></div>
					</div>
					<div class="indicadores"  onclick="javascript:IndicadorLicitaciones('CERRARHOY');">
						<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_vencen_hoy']/node()"/>&nbsp;</div>
						<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/LICITACIONES_VENCENHOY"/></div>
					</div>
					<div class="indicadores"  onclick="javascript:IndicadorLicitaciones('NOINICIADAS');">
						<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_no_iniciadas']/node()"/>&nbsp;</div>
						<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/LICITACIONES_NOINICIADAS"/></div>
					</div>
					<div class="indicadores"  onclick="javascript:IndicadorLicitaciones('PEDIDOSPENDIENTES');">
						<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_pedidos_pendientes']/node()"/>&nbsp;</div>
						<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/LICITACIONES_PEDIDOSPEND"/></div>
					</div>
					<div class="indicadores"  onclick="javascript:IndicadorLicitaciones('URGENTES');">
						<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_urgentes']/node()"/>&nbsp;</div>
						<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/LICITACIONES_URGENTES"/></div>
					</div>
					<div class="indicadores"  onclick="javascript:IndicadorLicitaciones('1DIA');">
						<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_12h']/node()"/>&nbsp;</div>
						<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/LICITACIONES"/></div>
					</div>
					<div class="indicadores"  onclick="javascript:IndicadorLicitaciones('30DIAS');">
						<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_30d']/node()"/>&nbsp;</div>
						<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/LICITACIONES"/></div>
					</div>
					<div class="indicadores"  onclick="javascript:IndicadorPedidos('CONTROLESEQUIPOHOY');">
						<div class="titulo_indicadores">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='gestiones_equipo_12h']/node()"/>&nbsp;</div>
						<div class="meio_indicadores positivo"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/CONTROLPEDIDOS_EQUIPO"/></div>
					</div>
				</xsl:if>
			</xsl:otherwise>
			</xsl:choose>
		</div><!--owl-carousel owl-theme-->
	</div><!--coluna_direita-->
	</xsl:if>
	
	<div class="divLeft boxInicio" id="pedidosBox">
	<xsl:if test="INICIO/NOTICIAS/NOTICIA">
		<xsl:choose>
		<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/BLOQUEARBANDEJA">
			<div class="divLeft68 marginTop20">
				<xsl:apply-templates select="INICIO/NOTICIAS"/>
			</div>
		</xsl:when>
		<xsl:otherwise>
			<div class="divLeft95m5 marginTop20">
				<xsl:apply-templates select="INICIO/NOTICIAS"/>
			</div>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:if>


	<!--abonos y pedidos pendientes de confirmacion-->
    <!--LLAMO LA TABLA CORESPONDIENTE BANDEJA DE ENTRADA-->
    <xsl:apply-templates select="INICIO/BANDEJA/COMPRAS/ABONOS/BANDEJA"/>
    <xsl:apply-templates select="INICIO/BANDEJA/COMPRAS/PEDIDOS_APROBAR/BANDEJA"/>
    <xsl:apply-templates select="INICIO/BANDEJA/COMPRAS/PEDIDOSPROGRAMADOS_APROBAR/BANDEJA"/>
    <xsl:apply-templates select="INICIO/BANDEJA/VENTAS/ABONOS/BANDEJA"/>

	<xsl:if test="INICIO/INICIO_GRAFICO">
     	<div id="actividadMensualBox" class="eisBox w1000px tableCenter marginTop50">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='indicador']/node()"/>:</label>&nbsp;<select class="w300px" id="IDINDICADORMENSUAL" name="IDINDICADORMENSUAL" onchange="javascript:CambioIndicador('MENSUAL');"/><br/>
			<canvas id="actMensual" width="1000" height="400"></canvas>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
       	</div><!--fin de actividadMensualBox-->
	</xsl:if>

  <xsl:if test="(INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR) and not (INICIO/INICIO_GRAFICO)">
	<input type="hidden" name="ORDEN" value="{./ORDEN}"/>
	<input type="hidden" name="SENTIDO" value="{./SENTIDO}"/>

	<input type="hidden" name="PAGINA" id="PAGINA" value="{INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PAGINA}"/>
	<table>
		<!--	Filtros Desplegables - 18feb19 Se los quitamos a los usuarios básicos "ocultar proveedor", por ejemplo CG, excepto que sean usuarios EMPRESA 	-->
		<xsl:if test="(INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN='EMPRESA') or not(INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/OCULTAR_PROVEEDOR)">
			<tr class="filtros">
			<td colspan="20">
				<xsl:call-template name="buscadorInicioAdmin"/>
        	</td>
			</tr>
		</xsl:if>
	</table>

	<div class="linha_separacao_cotacao_y"></div>
	<div class="tabela tabela_redonda">
		<table cellspacing="10px" cellpadding="10px">
		<thead class="cabecalho_tabela">

		<tr>
			<th class="uno">&nbsp;</th>
			<th class="zerouno">&nbsp;</th>
			<th class="w160px textLeft">
				<a href="javascript:OrdenarPor('NUMERO_PEDIDO');">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>
				</a>
			</th>
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MOSTRARCENTRO">
				<th class="quince textLeft">
					&nbsp;<a href="javascript:OrdenarPor('CENTRO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></a>
				</th>
			</xsl:if>
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MOSTRARCENTROCONSUMO">
				<th class="quince textLeft">
					&nbsp;<a href="javascript:OrdenarPor('CENTROCONSUMO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_consumo']/node()"/></a>
				</th>
			</xsl:if>
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/INCLUIR_COMPRADOR">
				<th class="ocho textLeft">
					&nbsp;<a href="javascript:OrdenarPor('COMPRADOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='comprador']/node()"/></a>
				</th>
			</xsl:if>
			<xsl:if test="not(INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/OCULTAR_PROVEEDOR)">
				<th class="quince textLeft">
					&nbsp;<a href="javascript:OrdenarPor('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a>
				</th>
			</xsl:if>
			<th class="cinco textLeft">
				<a href="javascript:OrdenarPor('FECHA_EMISION');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></a>
			</th>
			<th class="cinco textLeft">
				<a href="javascript:OrdenarPor('FECHA_ENVIADO_DIA');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='entrega']/node()"/></a>
			</th>
			<th class="cuatro textLeft">
				<a href="javascript:OrdenarPor('ESTADO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></a>
			</th>
			<!--<th class="dos">
				<a href="javascript:OrdenarPor('SITUACION');">Sit</a>
			</th>
			<th class="cinco">
				<a href="javascript:OrdenarPor('ALBARAN');"><xsl:value-of select="document($doc)/translation/texts/item[@name='alb']/node()"/></a>
			</th>-->
			<th class="cinco textRight;">
				<xsl:choose>
				<xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MOSTRAR_PRECIOS_CON_IVA"><xsl:value-of select="document($doc)/translation/texts/item[@name='total_cIVA']/node()"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/></xsl:otherwise>
				</xsl:choose>
				<!--&nbsp;(<xsl:value-of select="INICIO/DIVISA/PREFIJO"/><xsl:value-of select="INICIO/DIVISA/SUFIJO"/>)-->
			</th>
			<th class="tres textLeft">
				&nbsp;<a href="javascript:OrdenarPor('CONTROL_MVM');"><xsl:value-of select="document($doc)/translation/texts/item[@name='control']/node()"/></a>
			</th>
			<th class="seis textLeft">
				&nbsp;<a href="javascript:OrdenarPor('FECHA_ENVIADO_DIA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='enviado']/node()"/></a>
			</th>
			<th class="w300px textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios_clinica']/node()"/></th>

			<xsl:choose>
			<!--26may16	<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN = 'MVM' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN = 'MVMB'">	-->
			<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PERMITIR_CONTROL_PEDIDOS">
			<th class="w300px nocompacto" style="display:none;text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios_internos']/node()"/></th>
			<th class="dos">
			<a href="javascript:OrdenarPor('CLINICA_AGUANTA');"> <xsl:value-of select="document($doc)/translation/texts/item[@name='ok']/node()"/></a>
			</th>
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/MVM">
				<th class="dos textLeft">
				<a href="javascript:OrdenarPor('RIESGO');"> <xsl:value-of select="document($doc)/translation/texts/item[@name='rie']/node()"/></a>
				</th>
			</xsl:if>
			<th class="dos textLeft">
			<a href="javascript:OrdenarPor('RECLAMACIONES');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Recl']/node()"/></a>
			</th>
			<th class="dos textLeft">
			<a href="javascript:OrdenarPor('FECHA_RECLAMACION');"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></a>
			</th>
			<th class="tres textLeft">
			&nbsp;<a href="javascript:OrdenarPor('RESPONSABLE_MVM');"> <xsl:value-of select="document($doc)/translation/texts/item[@name='FollowUp']/node()"/></a>
			</th>
			<th class="tres textLeft">
			&nbsp;<a href="javascript:OrdenarPor('FECHA_MVM');"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></a>
			</th>
			<th class="uno">&nbsp;</th><!--29dic17	Reclamar	-->
			</xsl:when>
			<xsl:otherwise>
			<th class="uno">&nbsp;</th><!--29dic17	Reclamar también para usuarios con control	-->
			<th colspan="5 textLeft">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='reclamar']/node()"/></th>
			</xsl:otherwise>
			</xsl:choose>
		</tr>
		</thead>

		<!--SI NO HAY PEDIDOS ENSENO UN MENSAJE Y SIGO ENSENaNDO CABECERA-->
		<xsl:choose>
		<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/TOTAL = '0'">
			<tr class="lejenda"><th colspan="17"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_pedidos_para_busqueda']/node()"/></th></tr>
		</xsl:when>
		<xsl:otherwise>

		<!--el buscador hace innecesario este separador <tr class="medio" height="3px"><td class="medio" colspan="7"></td></tr>-->
		<tbody class="corpo_tabela_oculto">
		<xsl:for-each select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PEDIDO">
			<tr>
        	<xsl:attribute name="class">
        	  <xsl:choose>
        	  <xsl:when test="MO_STATUS=12">conhover fondoRojo</xsl:when>
        	  <xsl:when test="CAMBIOSMVM and CAMBIOSPROVEEDOR='S'">conhover fondoAmarillo</xsl:when>
        	  <xsl:when test="CAMBIOSMVM or CAMBIOSPROVEEDOR='S'">conhover fondoAmarillo</xsl:when>
        	  <xsl:otherwise>conhover</xsl:otherwise>
        	  </xsl:choose>
        	</xsl:attribute>

			<td class="color_status">
				<xsl:attribute name="style">
					<xsl:choose>
					<xsl:when test="RECLAMACION ='S' and BLOQUEAR ='N'">background:#FF9900;</xsl:when>
					<xsl:when test="RECLAMACION ='S' and BLOQUEAR ='S'">background:#FF9900;</xsl:when>
					<xsl:when test="RECLAMACION!='S' and BLOQUEAR='S' and (/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PERMITIR_CONTROL_PEDIDOS)">background:#FE4162;</xsl:when>
           			</xsl:choose>
				</xsl:attribute>
				<xsl:if test="RECLAMACION!='S' and BLOQUEAR='S' and (/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PERMITIR_CONTROL_PEDIDOS)">
					<xsl:attribute name="title">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_bloqueado']/node()"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="POSICION"/>
			</td>
			<td align="center" valign="middle">
				<xsl:choose>
				<xsl:when test="URGENTE = 'S'">
					<img src="http://www.newco.dev.br/images/2017/warning-red.png">
						<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_urgente']/node()"/></xsl:attribute>
					</img>&nbsp;</xsl:when>
				<xsl:otherwise>&nbsp;</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
				<xsl:when test="PREPAGOPENDIENTE">
					<img src="http://www.newco.dev.br/images/2017/icono-pago.png">
						<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='Requiere_prepago']/node()"/></xsl:attribute>
					</img>&nbsp;
				</xsl:when>
				<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
			</td>
			<td class="textLeft">
				&nbsp;<strong><a href="javascript:AbrirMultioferta({MO_ID});">
					<xsl:value-of select="NUMERO_PEDIDO"/>
				</a></strong>
			</td>

			<xsl:if test="../MOSTRARCENTRO">
				<td class="textLeft">
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTROCLIENTE}','Centro',100,80,0,-20);">
						<xsl:value-of select="NOMBRE_CENTRO"/>
					</a>
					<xsl:if test="LUGAR_ENTREGA">
						<br/><span class="fuentePeq"><xsl:value-of select="LUGAR_ENTREGA/NOMBRE"/></span>
					</xsl:if>
				</td>
			</xsl:if>

			<xsl:if test="../INCLUIR_COMPRADOR">
				<td class="textLeft">
					<span class="fuentePeq"><xsl:value-of select="USUARIOCOMPRADOR"/></span>
				</td>
			</xsl:if>

			<xsl:if test="../MOSTRARCENTROCONSUMO">
				<td class="textLeft">
					<xsl:value-of select="CENTROCONSUMO"/>
				</td>
			</xsl:if>

			<xsl:if test="not(../OCULTAR_PROVEEDOR)">
				<td class="textLeft">
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame2022.xsql?EMP_ID={IDPROVEEDOR}&amp;VENTANA=NUEVA','Centro',100,80,0,-20);">
						<xsl:value-of select="PROVEEDOR"/>
					</a>
					<xsl:if test="CAMBIOSPROVEEDOR='S'">&nbsp;<img src="http://www.newco.dev.br/images/bolaAmbar.gif"/></xsl:if>
				</td>
			</xsl:if>
			<td>
				<xsl:value-of select="FECHA_PEDIDO"/>
			</td>
			<td>
				<xsl:choose>
				<xsl:when test="FECHA_ENTREGA_CORREGIDA != ''">
					<xsl:value-of select="FECHA_ENTREGA_CORREGIDA"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="FECHA_ENTREGA"/>
				</xsl:otherwise>
				</xsl:choose>
			</td>
			<td>
				<strong><a href="javascript:AbrirMultioferta({MO_ID});">
				<xsl:attribute name="title">
				<xsl:choose>
					<xsl:when test="contains(ESTADO,'PARCIAL')">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='PED_PARC_expli']/node()"/>
					</xsl:when>
					<xsl:when test="contains(ESTADO,'ACEPTAR')">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='PED_ACEP_expli']/node()"/>
					</xsl:when>
					<xsl:when test="contains(ESTADO,'Pend')">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='PED_PEND_expli']/node()"/>
					</xsl:when>
					<xsl:when test="contains(ESTADO,'RECH')">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='rechazado']/node()"/>
					</xsl:when>
					<xsl:when test="contains(ESTADO,'RETR')">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='PED_RETR_expli']/node()"/>
					</xsl:when>
					<xsl:when test="contains(ESTADO,'REQ.ENVIO')">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='PED_REQ_ENVIO_expli']/node()"/>
					</xsl:when>
					<xsl:when test="contains(ESTADO,'ENVIADO')">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='enviado']/node()"/>
					</xsl:when>
					<xsl:when test="contains(ESTADO,'AP.SUP.')">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='PED_AP_SUP_expli']/node()"/>
					</xsl:when>
					<xsl:when test="contains(ESTADO,'RECH.SUP.')">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='rechazado_superior']/node()"/>
					</xsl:when>
					<xsl:when test="contains(ESTADO,'FINAL')">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='final_maiu']/node()"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="ESTADO"/>
					</xsl:otherwise>
				</xsl:choose>
				</xsl:attribute>
				<xsl:choose>
					<xsl:when test="contains(ESTADO,'PARCIAL')">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='entr_parcial']/node()"/>
					</xsl:when>
					<xsl:when test="contains(ESTADO,'ACEPTAR')">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar']/node()"/>
					</xsl:when>
					<xsl:when test="contains(ESTADO,'Pend')">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente_maiu']/node()"/>
					</xsl:when>
					<xsl:when test="contains(ESTADO,'RECH')">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='rechazado']/node()"/>
					</xsl:when>
					<xsl:when test="contains(ESTADO,'RETR')">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='retrasado']/node()"/>
					</xsl:when>
					<xsl:when test="contains(ESTADO,'REQ.ENVIO')">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='req_envio']/node()"/>
					</xsl:when>
					<xsl:when test="contains(ESTADO,'ENVIADO')">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='enviado']/node()"/>
					</xsl:when>
					<xsl:when test="contains(ESTADO,'AP.SUP.')"><!-- 18feb19 Usuario aprobador	-->
						<xsl:value-of select="document($doc)/translation/texts/item[@name='aprobar_superior']/node()"/><br/><span class="fuentePeq"><xsl:value-of select="USUARIOAPROBADOR"/></span>
					</xsl:when>
					<xsl:when test="contains(ESTADO,'RECH.SUP.')">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='rechazado_superior']/node()"/>
					</xsl:when>
					<xsl:when test="contains(ESTADO,'FINAL')">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='final_maiu']/node()"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="ESTADO"/>
					</xsl:otherwise>
				</xsl:choose>
				<!--muestra-->
				<xsl:if test="contains(ESTADO,'Muestras')">
					&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='muestras']/node()"/>
				</xsl:if>
				</a></strong>
			</td>
        	<!--total es con iva, subtotal sin iva-->
        	<td>
		  		<xsl:value-of select="DIVISA/PREFIJO"/>
				<xsl:choose>
				<xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MOSTRAR_PRECIOS_CON_IVA"><xsl:value-of select="PED_TOTAL"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="PED_SUBTOTAL"/></xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="DIVISA/SUFIJO"/>
        	</td>
        	<!--control-->
        	<td>
        	  <!--retraso-->
        	  <xsl:choose>
        	  <xsl:when test="RETRASO &gt; 1">
			  	<img src="http://www.newco.dev.br/images/2017/clock-red.png">
			  		<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_retrasado']/node()"/></xsl:attribute>
				</img>&nbsp;&nbsp;</xsl:when>
			  <xsl:otherwise><img src="http://www.newco.dev.br/images/2017/clock-blue.png"/>&nbsp;&nbsp;</xsl:otherwise>
        	  </xsl:choose>
        	  <!--situacion-->
				<xsl:choose>
				<!--8ene19 <xsl:when test="SITUACION != '' and not(contains(ESTADO,'FINAL'))">-->
				<xsl:when test="SITUACION != ''">
					<xsl:choose>	<!-- para simplificar, los clientes ver?n la situaci?n 2 en lugar de la 1	-->
					<xsl:when test="SITUACION='-1'">
						<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
							no se ver? m?s 3 ambar, se ver? pendiente-->
					</xsl:when>
					<xsl:when test="SITUACION='1'">
						<img src="../../images/Situacion{SITUACION}de3.gif"><xsl:apply-templates select="SITUACION"/>
							<xsl:attribute name="title"><xsl:apply-templates select="SITUACION"/></xsl:attribute>
						</img>
					</xsl:when>
					<xsl:when test="SITUACION!='1' and SITUACION!='-1'">
						<img src="../../images/Situacion{SITUACION}de3.gif">
							<xsl:attribute name="title"><xsl:apply-templates select="SITUACION"/></xsl:attribute>
						</img>
					</xsl:when>
					<xsl:otherwise>
						<img src="../../images/Situacion2de3.gif">
							<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='Situacion{SITUACION}']/node()"/></xsl:attribute>
						</img>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				</xsl:choose><!--8ene20 para pruebas <xsl:value-of select="SITUACION"/>:<xsl:value-of select="ESTADO"/>-->
			</td>
			<td><xsl:value-of select="FECHAENVIOPROVEEDOR"/></td>
			<td class="textLeft">
				<xsl:if test="COMENTARIOSPARACLINICA!=''">
					<xsl:variable name="len" select="string-length(COMENTARIOSPARACLINICA)"/>
					<span class="fuentePeq">
						<xsl:value-of select="substring(COMENTARIOSPARACLINICA,1,58)"/>
						<xsl:if test="$len &gt; 58">...</xsl:if>

						<xsl:if test="COMENTARIOSPARACLINICA!=''">
							<xsl:variable name="len" select="string-length(COMENTARIOSPARACLINICA)"/>
							<xsl:if test="$len &gt; 58">
								&nbsp;<img src="http://www.newco.dev.br/images/info.gif">
									<xsl:attribute name="title"><xsl:value-of select="COMENTARIOSPARACLINICA"/></xsl:attribute>
								</img>
							</xsl:if>
						</xsl:if>
					</span>
				</xsl:if>
			</td>

    	  <!--si es admin mvm ense?o todo, si es cdc quito columnas-->
    	  <xsl:choose>
    	  <xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PERMITIR_CONTROL_PEDIDOS">
			<td style="display:none;">
				<xsl:if test="COMENTARIOSINTERNOS!=''">
					<xsl:variable name="len" select="string-length(COMENTARIOSINTERNOS)"/>
					<xsl:value-of select="substring(COMENTARIOSINTERNOS,1,58)"/>
					<xsl:if test="$len &gt; 58">...</xsl:if>

					<xsl:if test="COMENTARIOSINTERNOS!=''">
						<xsl:variable name="len" select="string-length(COMENTARIOSINTERNOS)"/>
						<xsl:if test="$len &gt; 58">
							&nbsp;<img src="http://www.newco.dev.br/images/info.gif">
								<xsl:attribute name="title"><xsl:value-of select="COMENTARIOSINTERNOS"/></xsl:attribute>
							</img>
						</xsl:if>
					</xsl:if>
				</xsl:if>
        	</td>
        	<td>
        	  <xsl:choose>
        	  <xsl:when test="ACEPTASOLUCION='N'"><img src="http://www.newco.dev.br/images/bolaRoja.gif"/></xsl:when>
        	  <xsl:when test="ACEPTASOLUCION='S'"><img src="http://www.newco.dev.br/images/bolaVerde.gif"/></xsl:when>
        	  <xsl:when test="ACEPTASOLUCION='Z'"><img src="http://www.newco.dev.br/images/bolaAmbar.gif"/></xsl:when>
        	  </xsl:choose>
        	</td>
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/MVM">
        		<td>
        		  <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Personal/BandejaTrabajo/ControlRiesgo.xsql?PED_ID={PED_ID}&amp;SES_ID={//SES_ID}','ControlRiesgo',100,80,0,0);">
            		<xsl:value-of select="VALORACIONRIESGO"/>
        		  </a>
        		</td>
			</xsl:if>
        	<td>
             	<xsl:value-of select="PED_RECLAMACIONES"/>
        	</td>
        	<td>
             	<xsl:value-of select="PED_ULTIMARECLAMACION"/>
        	</td>

    	  <xsl:if test="CONTROL">
        	<xsl:choose>
        	<xsl:when test="NUMENTRADASCONTROL>0">
        	  <td class="textLeft">
            	<strong><a href="javascript:AbrirControl({PED_ID});">
            	  <xsl:value-of select="USUARIOCONTROL"/>
            	</a></strong>
            	<xsl:if test="CAMBIOSMVM">&nbsp;<img src="http://www.newco.dev.br/images/bolaAmbar.gif"/></xsl:if>
        	  </td>
        	  <td>
            	<xsl:choose>
            	<xsl:when test="PROXIMAACCIONCADUCADA='S'">
            	  <b><font color="red"><xsl:value-of select="PROXIMAACCION"/></font></b>
            	</xsl:when>
            	<xsl:otherwise>
            	  <xsl:value-of select="PROXIMAACCION"/>
            	</xsl:otherwise>
            	</xsl:choose>
        	  </td>
        	</xsl:when>
        	<xsl:otherwise>
        	  <td class="textLeft">
            	<strong><a href="javascript:AbrirControl({PED_ID});">
            	  <xsl:value-of select="document($doc)/translation/texts/item[@name='pend']/node()"/>
            	</a></strong>
        	  </td>
        	  <td>&nbsp;</td>
        	</xsl:otherwise>
        	</xsl:choose>
    	  </xsl:if>
    		</xsl:when>
    	  <xsl:otherwise>
			<td colspan="5" class="uno">&nbsp;</td>
    	  </xsl:otherwise>
    	  </xsl:choose>
        	<!--aunque tenga derechos de usuario de control permitir-->
        	<td class="uno">
        	  	<a class="reclamarLink" id="reclamar_{PED_ID}">
					<img height="20px" width="20px" src="http://www.newco.dev.br/images/2022/icones/comente.png">
						<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='Consulta']/node()"/>/<xsl:value-of select="document($doc)/translation/texts/item[@name='Reclamacion']/node()"/></xsl:attribute>
					</img>
				</a>
			</td>
		</tr>

      <!--reclamar-->
			<tr class="reclamarBox" style="display:none;" id="reclamarBox_{PED_ID}">
				<td colspan="12">
					<div class="reclamarCaja" align="right"> 
						<input type="hidden" name="RECLAMAR_TEXT"/>
						<textarea rows="3" cols="60" name="RECLAMAR_TEXT_{PED_ID}"/>
						<br />
						<br />
						<a class="botao_comentario" href="javascript:enviarConsulta({PED_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='Consulta']/node()"/></a>
						&nbsp;
						<a class="botao_reclamar" href="javascript:enviarReclamacion({PED_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='Reclamacion']/node()"/></a>
						<div style="display:none" id="waitBox_{PED_ID}">
						&nbsp;</div>
						<div class="confirmReclamacion" style="display:none;" id="confirmBox_{PED_ID}">
							<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='reclamacion_enviada']/node()"/></span>&nbsp;
						</div>
						<div class="confirmReclamacion" style="display:none;" id="confirmComBox_{PED_ID}">
							<span class="amarillo"><xsl:value-of select="document($doc)/translation/texts/item[@name='consulta_enviada']/node()"/></span>&nbsp;
						</div>
						<br /><br />
					</div>
				</td>
        		<td>&nbsp;</td>
			</tr>
		</xsl:for-each><!--fin de pedidos-->
		</tbody>

      <!--total pedidos-->
		<tfoot class="rodape_tabela">
    	  <tr class="conhover">
        	<td colspan="{INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/COLSPAN_TOTALES}">
        	</td>
        	<td class="textRight" colspan="3">
        	  <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:&nbsp;<xsl:value-of select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/TOTAL_PEDIDOS"/>
        	  <!--	Center Group quiere ver el importe con y sin IVA -->
			  <xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MOSTRAR_PRECIOS_CON_IVA">
		  		<br/><xsl:value-of select="document($doc)/translation/texts/item[@name='total_cIVA']/node()"/>:&nbsp;<xsl:value-of select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/TOTAL_PEDIDOS_CONIVA"/>
			  </xsl:if>
			  </strong>
        	</td>
        	<!--pedidos retrasados-->
        	<td class="textRight">
	        	<img src="http://www.newco.dev.br/images/2017/clock-red.png"><xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_retrasado']/node()"/></xsl:attribute></img>
        	</td>
        	<td class="textLeft" colspan="2">
        		<strong><xsl:value-of select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PEDIDOS_RETRASADOS"/> / <xsl:value-of select="INICIO/PEDIDOSPROBLEMATICOS/TOTAL" /> : <xsl:value-of select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PORC_PED_RETRASADOS"/></strong>
        	</td>
        	<td colspan="7">&nbsp;</td>
    	  </tr>
		</tfoot>
		</xsl:otherwise>
		</xsl:choose><!--fin de choose si hay pedidos-->
		</table>	
		<BR/>
		<BR/>
		<BR/>
		<BR/>
		</div>	<!-- fin tabela_redonda	-->	

		<!--PEDIDOS PROBLEMATICOS-->
		<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR">
			<div class="problematicos">
				<p>
            	<xsl:choose>
            	<xsl:when test="/WorkFlowPendientes/INICIO/TXT_INFORMARPEDIDOS"><xsl:value-of select="/WorkFlowPendientes/INICIO/TXT_INFORMARPEDIDOS" /></xsl:when>
            	<xsl:otherwise><xsl:copy-of select="document($doc)/translation/texts/item[@name='ayudanos_detectar']/node()"/></xsl:otherwise>
            	</xsl:choose>
				</p>
              <!--boton para marcar como entregados los pedidos enviados con albaran mas viejos de 5-10-15 dias, solo mvm,mvmb-->
              <xsl:variable name="filtroSemaforo" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDFILTROSEMAFORO/field/@current"/>
              <xsl:if test="(INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PERMITIR_CONTROL_PEDIDOS) and ($filtroSemaforo = 'ENV7' or $filtroSemaforo = 'ENV14' or $filtroSemaforo = 'ENV21')">
                <p><xsl:value-of select="document($doc)/translation/texts/item[@name='marcar_entregados']/node()"/>&nbsp;
                  <xsl:choose>
                  <xsl:when test="$filtroSemaforo = 'ENV7'">1 semana<xsl:variable name="dias">5</xsl:variable></xsl:when>
                  <xsl:when test="$filtroSemaforo = 'ENV14'">2 semanas<xsl:variable name="dias">10</xsl:variable></xsl:when>
                  <xsl:when test="$filtroSemaforo = 'ENV21'">3 semanas<xsl:variable name="dias">15</xsl:variable></xsl:when>
                  </xsl:choose>
                  <xsl:variable name="dias">
                    <xsl:choose>
                    <xsl:when test="$filtroSemaforo = 'ENV7'">5</xsl:when>
                    <xsl:when test="$filtroSemaforo = 'ENV14'">10</xsl:when>
                    <xsl:when test="$filtroSemaforo = 'ENV21'">15</xsl:when>
                    </xsl:choose>
                  </xsl:variable>
                  &nbsp;<a class="btnDiscreto" href="javascript:MarcarEntregados({$dias});"><xsl:value-of select="document($doc)/translation/texts/item[@name='Marcar']/node()"/></a>
                  <div id="waitBoxEntregados" style="display:none;">&nbsp;</div>
                  <div id="confirmBoxEntregados" style="display:none;"><p><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_marcados_entregados']/node()"/></p></div>
                </p>
              </xsl:if>
			</div>
		</xsl:if>
	  <br/>
	  <br/>
	  <br/>
	  <br/>
	  <br/>
	  <br/>
	  <br/>
	  <br/>
	  <br/>
	  <br/>
	  <br/>
	  <br/>
	  <br/>
	  <br/>
	  <br/>
	  <br/>
	  <br/>
	  <br/>
	  <br/>
	  <br/>
	  <br/>
	  <br/>
	  <br/>
	  <br/>
  </xsl:if>

	</div>
	</div>
</xsl:template><!--FIN DE TEMPLATE ADMIN-->

<!--CLIENTE NORMAL O ADMIN DE CLIENTE-->
<xsl:template name="CLIENTE">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
	
	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/><xsl:if test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/BUSQUEDASESPECIALES != ''">:&nbsp;<xsl:variable name="nombreestado">ST_<xsl:value-of select="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/BUSQUEDASESPECIALES"/></xsl:variable><xsl:value-of select="document($doc)/translation/texts/item[@name=$nombreestado]/node()"/></xsl:if>&nbsp;&nbsp;&nbsp;&nbsp;
			<span class="CompletarTitulo">
				<xsl:value-of select="INICIO/PEDIDOSPROBLEMATICOS/TOTAL" />&nbsp;
				<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>.&nbsp;
				<xsl:value-of select="document($doc)/translation/texts/item[@name='pagina']/node()"/>&nbsp;
				<xsl:variable name="pagina">
				<xsl:choose>
				<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PAGINA != ''">
				  <xsl:value-of select="number(INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PAGINA)+number(1)"/>
				</xsl:when>
				<xsl:otherwise>1</xsl:otherwise>
				</xsl:choose>
				</xsl:variable>
				<xsl:value-of select="$pagina" />&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
				<xsl:value-of select="//BOTONES/NUMERO_PAGINAS" />.&nbsp;
				<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BOTONES/ANTERIOR">
					<a class="btnNormal" href="javascript:AplicarFiltroPagina({INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BOTONES/ANTERIOR/@Pagina});">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/>
					</a>&nbsp;
				</xsl:if>
				<a class="btnNormal" href="javascript:DescargarExcel();"><xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/></a>&nbsp;
				<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BOTONES/SIGUIENTE">
					<a class="btnNormal" href="javascript:AplicarFiltroPagina({INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BOTONES/SIGUIENTE/@Pagina});">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/>
					</a>&nbsp;
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	<br/>


	<div class="divleft">
		<!--PEDIDOS PROBLEMATICOS-->
		<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BLOQUEARBANDEJA">
			<div class="evidenciado">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='pedidos_pendientes_de_informar']/node()"/>
			</div>
		</xsl:if>
		<!--FIN DE PEDIDOS PROBLEMATICOS-->
    <xsl:if test="INICIO/NOTICIAS/NOTICIA">
      <xsl:choose>
      <xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BLOQUEARBANDEJA">
        <div class="divLeft68">
          <xsl:apply-templates select="INICIO/NOTICIAS"/>
        </div>
      </xsl:when>
      <xsl:otherwise>
        <div class="divLeft95m5">
          <xsl:apply-templates select="INICIO/NOTICIAS"/>
        </div>
      </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </div><!--fin de divLeft-->

	<!--abonos y pedidos pendientes de confirmacion-->
	<!--LLAMO LA TABLA CORESPONDIENTE BANDEJA DE ENTRADA-->
	<xsl:apply-templates select="INICIO/BANDEJA/COMPRAS/ABONOS/BANDEJA"/>
	<xsl:apply-templates select="INICIO/BANDEJA/COMPRAS/PEDIDOS_APROBAR/BANDEJA"/>
	<xsl:if test="INICIO/INICIO_GRAFICO">
    	<div id="actividadMensualBox" class="eisBox w1000px tableCenter marginTop50">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='indicador']/node()"/>:</label>&nbsp;<select class="w300px" id="IDINDICADORMENSUAL" name="IDINDICADORMENSUAL" onchange="javascript:CambioIndicador('MENSUAL');"/><br/>
			<canvas id="actMensual" width="1000" height="400"></canvas>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
    	</div><!--fin de actividadMensualBox-->
	</xsl:if>

  <div class="divLeft">
    <xsl:call-template name="SOLICITUDES"/>

    <xsl:if test="INICIO/GESTIONCOMERCIAL">
			<div class="divLeft">
				<xsl:apply-templates select="INICIO/GESTIONCOMERCIAL"/>
			</div>
	</xsl:if>
  </div><!--fin de divLeft-->

	<xsl:if test="not(INICIO/INICIO_GRAFICO)">
	<div class="divLeft">
	<xsl:for-each select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR">
		<input type="hidden" name="ORDEN" value="{./ORDEN}"/>
		<input type="hidden" name="SENTIDO" value="{./SENTIDO}"/>
		<table class="buscador">
			<xsl:if test="not(../../MINIMALISTA)">
				<tr><td bgcolor="#f5f5f5" colspan="13"><xsl:call-template name="buscadorInicioAdmin"/></td></tr>
			</xsl:if>
			<tr>
				<xsl:choose>
				<xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN='EMPRESA'">
					<th class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
				</xsl:when>
				<xsl:otherwise>
					<th>&nbsp;</th>
				</xsl:otherwise>
				</xsl:choose>
				<!--tipo pedido
				<th class="dos">&nbsp;</th>-->
				<th class="diez">
					<a href="javascript:OrdenarPor('NUMERO_PEDIDO');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/></a>
				</th>
				<xsl:if test="MOSTRARCENTRO">
					<th class="quince" style="text-align:left;">
						<a href="javascript:OrdenarPor('CENTRO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></a>
					</th>
				</xsl:if>
				<th class="quince" style="text-align:left;">
					<a href="javascript:OrdenarPor('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a>
				</th>
				<th class="cinco"><!--aï¿½adido de nuevo 13-11-13-->
					<a href="javascript:OrdenarPor('FECHA_EMISION');"><xsl:value-of select="document($doc)/translation/texts/item[@name='emision']/node()"/></a>
				</th>
				<th class="cinco">
					<a href="javascript:OrdenarPor('FECHA_ENVIADO_DIA');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='entrega_prevista']/node()"/></a>
				</th>
				<th class="diez">
					<a href="javascript:OrdenarPor('ESTADO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></a>
				</th>
       			<th class="seis">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>
				</th>
				<th class="tres">
					<a href="javascript:OrdenarPor('CONTROL_MVM');"><xsl:value-of select="document($doc)/translation/texts/item[@name='control']/node()"/></a>
				</th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/></th>
				<th class="cinco">
					<xsl:if test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN='EMPRESA'">
						<xsl:copy-of select="document($doc)/translation/texts/item[@name='aguanta']/node()"/>
					</xsl:if>
				</th>
				<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='reclamar']/node()"/></th>
			</tr>

		<!--SI NO HAY PEDIDOS ENSEï¿½O UN MENSAJE Y SIGO ENSEï¿½ANDO CABECERA cliente-->
		<xsl:choose>
		<xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/TOTAL = '0'">
			<tr class="lejenda"><th colspan="13">&nbsp;</th></tr>
			<tr class="lejenda"><th colspan="13"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_pedidos_para_busqueda']/node()"/></th></tr>
			<tr class="lejenda"><th colspan="13">&nbsp;</th></tr>
		</xsl:when>
		<xsl:otherwise>
			<!--el buscador hace innecesario este separador <tr class="medio" height="3px"><td class="medio" colspan="7"></td></tr>-->
			<xsl:for-each select="PEDIDO">
			<tbody>
				<tr class="conhover" style="border-bottom:1px solid #A7A8A9;">
					<xsl:choose>
					<xsl:when test="../ADMIN='EMPRESA'"><td><xsl:value-of select="POSICION"/></td></xsl:when>
					<xsl:otherwise><td>&nbsp;</td></xsl:otherwise>
					</xsl:choose>

					<!--4nov16	tipo de pedido
					<td>
						<xsl:choose>
						<xsl:when test="CATEGORIA = 'F'"><img src="http://www.newco.dev.br/images/farmacia-icon.gif" alt="Farmacia"/></xsl:when>
						</xsl:choose>
					</td>-->

					<td>
						<strong><a>
							<!--<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/<xsl:value-of select="ENLACETAREA"/>','Multioferta',100,100,0,0)</xsl:attribute>-->
							<xsl:attribute name="href">javascript:AbrirMultioferta(<xsl:value-of select="MO_ID"/>)</xsl:attribute>
							<xsl:value-of select="NUMERO_PEDIDO"/>
						</a></strong>
					</td>

				<xsl:if test="../MOSTRARCENTRO">
					<td style="text-align:left;">
						&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTROCLIENTE}','Centro',100,80,0,-20);">
							<xsl:value-of select="NOMBRE_CENTRO"/>
						</a>
					</td>
				</xsl:if>

					<td style="text-align:left;">
						&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame2022.xsql?EMP_ID={IDPROVEEDOR}&amp;VENTANA=NUEVA','Centro',100,80,0,-20);">
							<xsl:value-of select="PROVEEDOR"/>
						</a>
					</td>

					<td><xsl:value-of select="FECHA_PEDIDO"/></td>

					<td>
						<xsl:choose>
						<xsl:when test="FECHA_ENTREGA_CORREGIDA != ''">
							<xsl:value-of select="FECHA_ENTREGA_CORREGIDA"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="FECHA_ENTREGA"/>
						</xsl:otherwise>
						</xsl:choose>
					</td>

					<td class="seis" style="font-size:12px;">
            <xsl:choose>
            <xsl:when test="contains(ESTADO,'PARCIAL')">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='entr_parcial']/node()"/>
            </xsl:when>
            <xsl:when test="contains(ESTADO,'ACEPTAR')">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar']/node()"/>
            </xsl:when>
            <xsl:when test="contains(ESTADO,'Pend')">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente_maiu']/node()"/>
            </xsl:when>
            <xsl:when test="contains(ESTADO,'RECH')">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='rechazado']/node()"/>
            </xsl:when>
            <xsl:when test="contains(ESTADO,'RETR')">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='retrasado']/node()"/>
            </xsl:when>
            <xsl:when test="contains(ESTADO,'FINAL')">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='final_maiu']/node()"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="document($doc)/translation/texts/item[@name='retrasado']/node()"/>
            </xsl:otherwise>
            </xsl:choose>

            <!--si es muestra ense?o muestra-->
            <xsl:if test="contains(ESTADO,'Muestras')">
              &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='muestras']/node()"/>
            </xsl:if>
					</td>

          <!--total es con iva, subtotal sin iva-->
          <td style="text-align:right;">
		  	<xsl:value-of select="DIVISA/PREFIJO"/>
            <xsl:choose>
            <xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MOSTRAR_PRECIOS_CON_IVA"><xsl:value-of select="PED_TOTAL"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="PED_SUBTOTAL"/></xsl:otherwise>
            </xsl:choose>
            <!--<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>-->
			<xsl:value-of select="DIVISA/SUFIJO"/>
          </td>

          <!--control-->
					<td>
						<xsl:choose>
						<xsl:when test="SITUACION='-1' or SITUACION=''">
							<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
							quitado 21-12 estado ambar y en esta columna no ense?o nada-->
						</xsl:when>
						<xsl:when test="SITUACION!='' and SITUACION != '-1'">
							<img src="../../images/Situacion{SITUACION}de3.gif"><xsl:apply-templates select="SITUACION"/><xsl:attribute name="title"><xsl:apply-templates select="SITUACION"/></xsl:attribute></img>
						</xsl:when>
						<xsl:otherwise>
							<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='reclamar']/node()"/>-->
						</xsl:otherwise>
						</xsl:choose>
					</td>

					<td class="textLeft">&nbsp;<xsl:value-of select="COMENTARIOSPARACLINICA"/></td>

					<td>
						<xsl:choose>
						<xsl:when test="../ADMIN='EMPRESA'">
							<xsl:choose>
							<xsl:when test="ACEPTASOLUCION='N'">
								<img src="http://www.newco.dev.br/images/bolaRoja.gif"/>
							</xsl:when>
							<xsl:when test="ACEPTASOLUCION='S'">
								<img src="http://www.newco.dev.br/images/bolaVerde.gif"/>
							</xsl:when>
							<xsl:when test="ACEPTASOLUCION='Z'">
								<img src="http://www.newco.dev.br/images/bolaAmbar.gif"/>
							</xsl:when>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>&nbsp;</xsl:otherwise>
						</xsl:choose>
					</td>

					<td>
            			<xsl:if test="not(/WorkFlowPendientes/INICIO/OBSERVADOR)">
							<a class="reclamarLink">
								<xsl:attribute name="id">reclamar_<xsl:value-of select="PED_ID"/></xsl:attribute>
								<img src="http://www.newco.dev.br/images/reclamar.gif" alt="reclamar"/>
							</a>
            			</xsl:if>
					</td>
				</tr>

				<!--reclamar-->
				<tr class="reclamarBox" style="display:none;">
					<xsl:attribute name="id">reclamarBox_<xsl:value-of select="PED_ID"/></xsl:attribute>
					<td colspan="12">
						<div class="reclamarCaja" align="right">
							<input type="hidden" name="RECLAMAR_TEXT"/>
							<textarea rows="3" cols="60">
								<xsl:attribute name="name">RECLAMAR_TEXT_<xsl:value-of select="PED_ID"/></xsl:attribute>
							</textarea>
							<br />
							<a>
								<xsl:attribute name="href">javascript:enviarReclamacion(<xsl:value-of select="PED_ID"/>);</xsl:attribute>
								<img src="http://www.newco.dev.br/images/enviarReclamacion.gif" alt="enviar"/>
							</a>
							<div style="display:none">
								<xsl:attribute name="id">waitBox_<xsl:value-of select="PED_ID"/></xsl:attribute>
							&nbsp;</div>
							<div class="confirmReclamacion" style="display:none;">
								<xsl:attribute name="id">confirmBox_<xsl:value-of select="PED_ID"/></xsl:attribute>
								<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='reclamacion_enviada']/node()"/></span>&nbsp;
							</div>
						</div>
					</td>
          			<td>&nbsp;</td>
				</tr>
			</tbody>
			</xsl:for-each>  <!--fin de pedidos-->

        <!--total pedidos-->
      	<tr>

          <td>
			<xsl:attribute name="colspan">
				<xsl:choose>
				<xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MOSTRARCENTRO">7</xsl:when>
				<xsl:otherwise>6</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			&nbsp;
		</td>
          <td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:</strong></td>
          <td style="text-align:right;">
			<xsl:value-of select="DIVISA/PREFIJO"/>
            <xsl:choose>
            <xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MOSTRAR_PRECIOS_CON_IVA"><xsl:value-of select="TOTAL_PEDIDOS_CONIVA" /></xsl:when>
            <xsl:otherwise><xsl:value-of select="TOTAL_PEDIDOS" /></xsl:otherwise>
            </xsl:choose>
          	<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>-->
			<xsl:value-of select="DIVISA/SUFIJO"/>
          </td>
          <td colspan="4">&nbsp;</td>
        </tr>
		</xsl:otherwise>
		</xsl:choose><!--fin de choose si hay pedidos-->
			<tfoot>
				<tr class="separator"><td colspan="13"></td></tr>
			</tfoot>
		</table>

		<table class="infoTable" bgcolor="#f5f5f5">
		<tfoot>
			<tr class="lejenda lineBorderBottom3">
				<td colspan="3" class="datosLeft">&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda']/node()"/>:</td>
			</tr>
			<tr class="lejenda lineBorderBottom5">
				<td class="cuarenta">
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;<img src="../../images/Situacion0de3.gif" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='no_enviado']/node()"/><br/>
						&nbsp;&nbsp;&nbsp;&nbsp;<img src="../../images/Situacion1de3.gif" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='enviado_segun_proveedor']/node()"/><br/>
						&nbsp;&nbsp;&nbsp;&nbsp;<img src="../../images/Situacion2de3.gif" border="0"/>&nbsp;&nbsp;
            				<xsl:choose>
            				<xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/TXT_SEMAFOROENVIADO"><xsl:value-of select="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/TXT_SEMAFOROENVIADO" /></xsl:when>
            				<xsl:otherwise><xsl:value-of select="document($doc)/translation/texts/item[@name='enviado_albaran']/node()"/></xsl:otherwise>
            				</xsl:choose>
						<br/>
						&nbsp;&nbsp;&nbsp;&nbsp;<img src="../../images/Situacion4de3.gif" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='recibido_segun_cliente']/node()"/><br/>
						<!-- &nbsp;&nbsp;&nbsp;&nbsp;<img src="../../images/Situacion-1de3.gif" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='informado']/node()"/><br/>-->
					</p>
				</td>
				<td class="veinte datosLeft" valign="top">
        		  <xsl:variable name="farmacia" select="count(PEDIDO[CATEGORIA = 'F'])"/>
        		  <xsl:choose>
        		  <xsl:when test="/WorkFlowPendientes/INICIO/PORTAL/PMVM_ID = 'MVM' and $farmacia != '0'">
								<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="../../images/farmacia-icon.gif" border="0"/>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_farmacia']/node()"/></p>
        		  </xsl:when>
        		  </xsl:choose>
				</td>
				<td>
					<!--PEDIDOS PROBLEMATICOS-->
					<xsl:if test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR">
						<div class="problematicos">
            				<p><xsl:choose>
            				<xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/TXT_INFORMARPEDIDOS"><xsl:value-of select="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/TXT_INFORMARPEDIDOS" /></xsl:when>
            				<xsl:otherwise><xsl:copy-of select="document($doc)/translation/texts/item[@name='ayudanos_detectar']/node()"/></xsl:otherwise>
            				</xsl:choose>
							</p>
						</div>
					</xsl:if>
				</td>
			</tr>
		</tfoot>
		</table>
	</xsl:for-each>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	</div><!--fin divCenter90-->
	</xsl:if>
	
	

  <div class="divLeft40nopa">&nbsp;</div>

	<!--boton si hay-->
	<xsl:choose>
	<xsl:when test="INICIO/BANDEJA/CDC and not(INICIO/MINIMALISTA)">
		<div class="divLeft20">
			<br /><br />
			<div class="botonLargo">
				<a href="http://www.newco.dev.br/Compras/PedidosProgramados/PedidosProgramados.xsql">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='programacion_de_pedidos']/node()"/>
				</a>
			</div>
			<br /><br />
		</div>
	</xsl:when>
	</xsl:choose>
</xsl:template>
<!--fin de template cliente-->

<!--proveedor-->
<xsl:template match="VENDEDOR">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="//LANG"><xsl:value-of select="//LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/><xsl:if test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/BUSQUEDASESPECIALES != ''">:&nbsp;<xsl:variable name="nombreestado">ST_<xsl:value-of select="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/BUSQUEDASESPECIALES"/></xsl:variable><xsl:value-of select="document($doc)/translation/texts/item[@name=$nombreestado]/node()"/></xsl:if>&nbsp;&nbsp;&nbsp;&nbsp;
			<span class="CompletarTitulo">
				<span class="fuentePeq">
					<xsl:value-of select="INICIO/PEDIDOSPROBLEMATICOS/TOTAL" />&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>.&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='pagina']/node()"/>&nbsp;
					<xsl:variable name="pagina">
					<xsl:choose>
					<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PAGINA != ''">
					  <xsl:value-of select="number(INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PAGINA)+number(1)"/>
					</xsl:when>
					<xsl:otherwise>1</xsl:otherwise>
					</xsl:choose>
					</xsl:variable>
					<xsl:value-of select="$pagina" />&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
					<xsl:value-of select="//BOTONES/NUMERO_PAGINAS" />.
				</span>&nbsp;
				<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BOTONES/ANTERIOR">
					<a class="btnNormal" href="javascript:AplicarFiltroPagina({INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BOTONES/ANTERIOR/@Pagina});">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/>
					</a>&nbsp;
				</xsl:if>
				<a class="btnNormal" href="javascript:DescargarExcel();"><xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/></a>&nbsp;
				<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BOTONES/SIGUIENTE">
					<a class="btnNormal" href="javascript:AplicarFiltroPagina({INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BOTONES/SIGUIENTE/@Pagina});">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/>
					</a>&nbsp;
				</xsl:if>
				<!--	Oferta stock: desactivado provisionalmente para Brasil	-->
				<xsl:if test="/WorkFlowPendientes/INICIO/IDPAIS!=55">
				<a class="btnDestacado" href="javascript:NuevoStockOferta();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_oferta_stock']/node()"/>
				</a>&nbsp;
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	<br/>

	<!--	25oct19	Faltaba guardar el ID de empresa			-->
	<!--	Conflcito con el desplegable	<input type="hidden" name="IDEMPRESA" value="{IDEMPRESA}" />-->

	<!-- 14jul21 Aviso documentacion pendiente	-->	
	<div class="divLeft">
	<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='documentacion']/node()"/>****<xsl:value-of select="/WorkFlowPendientes/INICIO/NIVEL_DOCUMENTACION"/>****-->
	<xsl:if test="/WorkFlowPendientes/INICIO/MENSAJE_FALTA_DOCUMENTACION">
		<div style="padding:10px;background-color:#FBD373;border:1px solid #488214;margin-left:auto;margin-right:auto;width:700px;text-align:center">
		<xsl:copy-of select="document($doc)/translation/texts/item[@name='Documentos_pendientes']/node()"/>
		</div>
		<br/>
		<br/>
		<br/>
	</xsl:if>
	</div>


	<div class="divleft">
	<!--PEDIDOS PROBLEMATICOS-->
	<xsl:if test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/BLOQUEARBANDEJA">
		<div class="divLeft marginTop50 marginBottom50 textCenter">
			<span class="urgente inline w500px">
				<!--Pedidos pendientes de informar-->
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='pedidos_pendientes_de_informar']/node()"/>
			</span>
		</div>
	</xsl:if>

	<!--FIN DE PEDIDOS PROBLEMATICOS-->
    <xsl:if test="/WorkFlowPendientes/INICIO/NOTICIAS/NOTICIA">
      <xsl:choose>
      <xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/BLOQUEARBANDEJA">
        <div class="divLeft68">
          <xsl:apply-templates select="/WorkFlowPendientes/INICIO/NOTICIAS"/>
        </div>
      </xsl:when>
      <xsl:otherwise>
        <div class="divLeft95m5">
          <xsl:apply-templates select="/WorkFlowPendientes/INICIO/NOTICIAS"/>
        </div>
      </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </div><!--fin de divLeft-->

  <!--abonos y pedidos pendientes de confirmacion-->
  <xsl:choose>
  <xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/BLOQUEARBANDEJA"></xsl:when>
  <xsl:otherwise>

    <!--LLAMO LA TABLA CORRESPONDIENTE BANDEJA DE ENTRADA-->
  	<!--	No vale la pena llamar a procesos de COMPRAS
	<xsl:apply-templates select="/WorkFlowPendientes/INICIO/BANDEJA/COMPRAS/ABONOS/BANDEJA"/>
    <xsl:apply-templates select="/WorkFlowPendientes/INICIO/BANDEJA/COMPRAS/PEDIDOS_APROBAR/BANDEJA"/>
    <xsl:apply-templates select="/WorkFlowPendientes/INICIO/BANDEJA/COMPRAS/PEDIDOS/BANDEJA"/>
    <xsl:apply-templates select="/WorkFlowPendientes/INICIO/BANDEJA/COMPRAS/PEDIDOSPROGRAMADOS_APROBAR/BANDEJA"/>
	-->
    <xsl:apply-templates select="/WorkFlowPendientes/INICIO/BANDEJA/VENTAS/PEDIDOS/BANDEJA"/>
    <xsl:apply-templates select="/WorkFlowPendientes/INICIO/BANDEJA/VENTAS/PEDIDOSPROGRAMADOS_APROBAR/BANDEJA"/>
    <xsl:apply-templates select="/WorkFlowPendientes/INICIO/BANDEJA/VENTAS/ABONOS/BANDEJA"/>
	<xsl:if test="/WorkFlowPendientes/INICIO/SOLOPEDIDOS='N'">
    	<xsl:apply-templates select="/WorkFlowPendientes/INICIO/BANDEJA/INCIDENCIAS/ENVIADAS/BANDEJA"/>
    	<xsl:apply-templates select="/WorkFlowPendientes/INICIO/BANDEJA/INCIDENCIAS/RECIBIDAS/BANDEJA"/>
    	<xsl:apply-templates select="/WorkFlowPendientes/INICIO/BANDEJA/EVALUACIONACTAS/INFORMANDO/BANDEJA"/>
    	<xsl:apply-templates select="/WorkFlowPendientes/INICIO/BANDEJA/EVALUACIONACTAS/CIERRE/BANDEJA"/>
    	<xsl:apply-templates select="/WorkFlowPendientes/INICIO/BANDEJA/EVALUACIONINFORMES/INFORMANDO/BANDEJA"/>
    	<xsl:apply-templates select="/WorkFlowPendientes/INICIO/BANDEJA/EVALUACIONINFORMES/CIERRE/BANDEJA"/>
    	<xsl:apply-templates select="/WorkFlowPendientes/INICIO/BANDEJA/NOCONFORMIDADINFORMES/INFORMANDO/BANDEJA"/>
    	<xsl:apply-templates select="/WorkFlowPendientes/INICIO/BANDEJA/NOCONFORMIDADINFORMES/CIERRE/BANDEJA"/>
    	<xsl:apply-templates select="/WorkFlowPendientes/INICIO/BANDEJA/SOLICITUDMUESTRAS/INFORMANDO/BANDEJA"/>
    	<xsl:apply-templates select="/WorkFlowPendientes/INICIO/BANDEJA/SOLICITUDMUESTRAS/CIERRE/BANDEJA"/>
    	<xsl:apply-templates select="/WorkFlowPendientes/INICIO/BANDEJA/NEGOCIACIONES/INFORMANDO/BANDEJA"/>
    	<xsl:apply-templates select="/WorkFlowPendientes/INICIO/BANDEJA/NEGOCIACIONES/CIERRE/BANDEJA"/>
	</xsl:if>
  </xsl:otherwise>
  </xsl:choose>

  <div class="divleft">
	<xsl:if test="/WorkFlowPendientes/INICIO/SOLOPEDIDOS='N'">
    	<xsl:call-template name="INCIDENCIAS"/>
    	<xsl:call-template name="EVALUACIONES"/>
    	<xsl:call-template name="LICITACIONES"/>
    	<xsl:call-template name="SOLICITUDES"/>
    	<xsl:call-template name="SOLICITUDESOFERTA"/>

    	<xsl:if test="/WorkFlowPendientes/INICIO/GESTIONCOMERCIAL">
				<div class="divLeft">
					<xsl:apply-templates select="/WorkFlowPendientes/INICIO/GESTIONCOMERCIAL"/>
				</div>
		</xsl:if>
	</xsl:if>
  </div><!--fin de divleft-->

	<div class="divLeft">
		<xsl:variable name="BLOQUEARBANDEJA">
			<xsl:choose>
			<xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/BLOQUEARBANDEJA">S</xsl:when>
			<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!--<xsl:variable name="COLSPAN_TABLA">
			<xsl:choose>
			<xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/PERMITIR_CONTROL_PEDIDOS">17</xsl:when>
			<xsl:otherwise>15</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>-->

		<xsl:if test="/WorkFlowPendientes/INICIO/SOLOPEDIDOS='S'">
			<xsl:call-template name="buscadorInicioProv"/>
		</xsl:if>

		<div class="textLeft marginTop40">
			<table class="tableCenter w1000px">
				<tr class="tituloTabla">
					<td>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_en_curso']/node()"/>&nbsp;
					<a href="javascript:SoloPedidos();">
						<xsl:choose>
							<xsl:when test="/WorkFlowPendientes/INICIO/SOLOPEDIDOS='N'">[<xsl:value-of select="document($doc)/translation/texts/item[@name='Solo_pedidos']/node()"/>]</xsl:when>
							<xsl:otherwise></xsl:otherwise>
						</xsl:choose>
					</a>
					</td>
				</tr>
			</table>
		</div>

		<div class="tabela tabela_redonda">
			<table cellspacing="6px" cellpadding="6px">
				<thead class="cabecalho_tabela">
				<tr>
					<th class="w1px">&nbsp;</th>
					<th class="w1px">&nbsp;</th>
					<th class="textLeft w50px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='codigo']/node()"/></th>
					<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
					<th class="textLeft w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Emision']/node()"/></th>
					<xsl:if test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/OCULTAR_FECHA_ENTREGA='N'">
						<th class="textLeft w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='entrega']/node()"/></th>
					</xsl:if>
					<th class="textLeft w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
        			<th class="textRight w30px" style="text-align:right;"><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/></th>
					<th class="w30px">&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha_salida_completo']/node()"/></th>
					<th class="textLeft w30px"><xsl:value-of select="document($doc)/translation/texts/item[@name='situacion']/node()"/></th>
					<th class="textLeft w50px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='numero_albaran']/node()"/></th>
                	<th class="textLeft w20px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='fichero_albaran']/node()"/></th>
                	<th class="textLeft w30px"><!--boton documentos--></th>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/></th>
					<th class="textLeft w30px" ><xsl:value-of select="document($doc)/translation/texts/item[@name='retraso_acumulado']/node()"/></th>
					<th class="textLeft w30px">&nbsp;</th>
					<xsl:if test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/PERMITIR_CONTROL_PEDIDOS">
						<th class="textLeft w30px"><xsl:value-of select="document($doc)/translation/texts/item[@name='res']/node()"/></th>
						<th class="textLeft w30px"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
					</xsl:if>
				</tr>
				</thead>
				<xsl:choose>
				<xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/TOTAL = '0'">
					<tbody class="corpo_tabela">
					<!--SI NO HAY PEDIDOS ENSEï¿½O UN MENSAJE Y SIGO ENSEï¿½ANDO CABECERA-->
					<tr>
						<td class="color_status">&nbsp;</td>
						<td colspan="17"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_pedidos_para_busqueda']/node()"/></td>
					</tr>
					</tbody>
					<tfoot class="rodape_tabela">
						<tr><td colspan="18">&nbsp;</td></tr>
					</tfoot>
				</xsl:when>
				<xsl:otherwise>
					<tbody class="corpo_tabela">
					<xsl:for-each select="PEDIDO">
					<tr class="conhover">
						<!--	1jul22 el estilo por defecto para corpo_tabela.tr manda sobre fondoRojo-->
						<xsl:attribute name="class">
							<xsl:choose>
							<xsl:when test="OBLIGATORIO and RECLAMACION != 'S'">conhover fondoRojo</xsl:when>
							<xsl:when test="RECLAMACION = 'S'">conhover fondoNaranja</xsl:when>
							<xsl:otherwise>conhover</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
						<!---->
						<td class="color_status">&nbsp;</td>
						<td class="textLeft">
							<xsl:choose>
							<xsl:when test="ESPROBLEMATICO='S'">
								<xsl:choose>
								<xsl:when test="PENDIENTEINFORMAR">
									<img src="../../images/SemaforoRojo.gif"/>&nbsp;
									<xsl:variable name="SEMAFORO">ROJO</xsl:variable>
								</xsl:when>
								<xsl:otherwise>
									<img src="../../images/SemaforoAmbar.gif"/>&nbsp;
									<xsl:variable name="SEMAFORO">AMBAR</xsl:variable>
								</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<img src="../../images/SemaforoVerde.gif"/>&nbsp;
								<xsl:variable name="SEMAFORO">VERDE</xsl:variable>
							</xsl:otherwise>
							</xsl:choose>
						</td>
						<td>
							<xsl:attribute name="class">
								<xsl:choose>
								<xsl:when test="OBLIGATORIO and RECLAMACION != 'S'">textLeft fondoRojo</xsl:when>
								<xsl:when test="RECLAMACION = 'S'">textLeft fondoNaranja</xsl:when>
								<xsl:otherwise>textLeft</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
							<xsl:choose>
							<xsl:when test="$BLOQUEARBANDEJA='N' or OBLIGATORIO">
								<strong><a>
									<xsl:attribute name="href">javascript:AbrirMultioferta(<xsl:value-of select="MO_ID"/>)</xsl:attribute>
									<xsl:value-of select="NUMERO_PEDIDO"/>
								</a></strong>
							</xsl:when>
							<xsl:otherwise>
								<a href="javascript:AvisoPedidoBloqueado();"><xsl:value-of select="NUMERO_PEDIDO"/></a>
							</xsl:otherwise>
							</xsl:choose>
						</td>

						<td class="textLeft">
							&nbsp;
							<xsl:if test="FEDERASSANTAS"><img src="http://www.newco.dev.br/Conecta/img/logo_conecta.png" height="24px" width="67px"/>&nbsp;</xsl:if>
							<a href="javascript:FichaCentro({IDCENTROCLIENTE});">
								<xsl:value-of select="NOMBRE_CENTRO"/>
							</a>
						</td>

						<td class="textLeft"><xsl:value-of select="FECHA_PEDIDO"/></td>
						<xsl:if test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/OCULTAR_FECHA_ENTREGA='N'">
							<td class="textLeft"><xsl:value-of select="FECHA_ENTREGA"/></td>
						</xsl:if>

						<td class="textLeft">
						<xsl:choose>
						<xsl:when test="$BLOQUEARBANDEJA='N' or OBLIGATORIO">
         					 <xsl:choose>
							<xsl:when test="contains(ESTADO,'PARCIAL')">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='entr_parcial']/node()"/>
							</xsl:when>
							<xsl:when test="contains(ESTADO,'ACEPTAR')">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar']/node()"/>
							</xsl:when>
							<xsl:when test="contains(ESTADO,'Pend')">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente_maiu']/node()"/>
							</xsl:when>
							<xsl:when test="contains(ESTADO,'RECH')">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='rechazado']/node()"/>
							</xsl:when>
							<xsl:when test="contains(ESTADO,'RETR')">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='retrasado']/node()"/>
							</xsl:when>
							<xsl:when test="contains(ESTADO,'FINAL')">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='final_maiu']/node()"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="document($doc)/translation/texts/item[@name='retrasado']/node()"/>
							</xsl:otherwise>
							</xsl:choose>

         					 <!--si es muestra ense?o muestra-->
			        		<xsl:if test="contains(ESTADO,'Muestras')">
								&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='muestras']/node()"/>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
          					<a href="javascript:AvisoPedidoBloqueado();">
           						 <!--<xsl:value-of select="ESTADO"/>-->
								<xsl:choose>
								<xsl:when test="contains(ESTADO,'PARCIAL')">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='entr_parcial']/node()"/>
								</xsl:when>
								<xsl:when test="contains(ESTADO,'ACEPTAR')">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar']/node()"/>
								</xsl:when>
								<xsl:when test="contains(ESTADO,'Pend.')">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente_maiu']/node()"/>
								</xsl:when>
								<xsl:when test="contains(ESTADO,'RECH')">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='rechazado']/node()"/>
								</xsl:when>
								<xsl:when test="contains(ESTADO,'FINAL')">
	            					<xsl:value-of select="document($doc)/translation/texts/item[@name='final_maiu']/node()"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="document($doc)/translation/texts/item[@name='retrasado']/node()"/>
								</xsl:otherwise>
								</xsl:choose>

            					<!--si es muestra ense?o muestra-->
            					<xsl:if test="contains(ESTADO,'Muestras')">
								&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='muestras']/node()"/>
								</xsl:if>
          					</a>
						</xsl:otherwise>
						</xsl:choose>
						</td>

        				<!--subtotal sin iva porque es proveedor-->
        				<td style="text-align:right;">
        					<xsl:value-of select="DIVISA/PREFIJO"/><xsl:value-of select="PED_SUBTOTAL"/><xsl:value-of select="DIVISA/SUFIJO"/>
        				</td>

						<td class="textLeft">
							<input type="hidden" name="FECHAPEDIDO_{MO_ID}" value="{FECHA_PEDIDO}"/>
							<xsl:choose>
							<xsl:when test="not(TERMINADO)">
								<input type="text" class="campopesquisa w80px" name="NUEVAFECHAENTREGA_{MO_ID}" maxlength="10" value="{FECHAENVIOPROVEEDOR}" oninput="javascript:ActivarBotonEnviar({MO_ID});"/>
							</xsl:when>
							<xsl:otherwise>
								&nbsp;<xsl:value-of select="FECHAENVIOPROVEEDOR"/>
							</xsl:otherwise>
							</xsl:choose>
						</td>

						<td class="textLeft">
							<xsl:choose>
							<xsl:when test="not(TERMINADO)">
								<xsl:call-template name="desplegable">
									<xsl:with-param name="path" select="IDMOTIVO/field"/>
									<xsl:with-param name="claSel">w90px</xsl:with-param>
									<xsl:with-param name="onChange">javascript:ActivarBotonEnviar(<xsl:value-of select="MO_ID"/>);</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								&nbsp;<xsl:value-of select="IDMOTIVOPROVEEDOR"/>
							</xsl:otherwise>
							</xsl:choose>
						</td>
						<td class="textLeft">
							<xsl:choose>
							<xsl:when test="not(TERMINADO)">
								<input type="text" class="campopesquisa w100px" name="ALBARAN_{MO_ID}" maxlength="50" value="{ALBARAN}" oninput="javascript:ActivarBotonEnviar({MO_ID});"/>
							</xsl:when>
							<xsl:otherwise>
								&nbsp;<xsl:value-of select="ALBARAN"/>
							</xsl:otherwise>
							</xsl:choose>
						</td>
                		<td class="textLeft">
							<xsl:choose>
							<xsl:when test="not(TERMINADO)">
								<!-- desactivado desde hace mucho tiempo	-->
							</xsl:when>
							<xsl:otherwise>
								<!--si ya hay un fichero cargado-->
                    			<xsl:if test="ALBARANENVIO/URL != ''">
                        			<a href="http://www.newco.dev.br/Documentos/{ALBARANENVIO/URL}" title="{ALBARANENVIO/NOMBRE} - {ALBARANENVIO/FECHA}" id="ficheroAlbaranOld_ALBARAN_{MO_ID}" style="width:80px;margin-top:4px;float:left;vertical-align:middle;">
                            			<xsl:value-of select="ALBARANENVIO/NOMBRE"/>
                        			</a>
                    			</xsl:if>
							</xsl:otherwise>
							</xsl:choose>
                		</td>
                		<td class="textLeft">
							&nbsp;<a class="btnDiscreto" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Compras/Multioferta/MODocs.xsql?MO_ID={MO_ID}','Multioferta',100,100,0,0)"><xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/></a>&nbsp;
                		</td>

						<td class="textLeft">
							<xsl:choose>
							<xsl:when test="not(TERMINADO)">
								<xsl:choose>
								<xsl:when test="RECLAMACION = 'S'">
									<input type="text" class="campopesquisa w300px" name="COMENTARIOS_{MO_ID}" maxlength="200" onchange="javascript:ActivarBotonEnviar({MO_ID});"/>
								</xsl:when>
								<xsl:otherwise>
									<input type="text" class="campopesquisa w300px" name="COMENTARIOS_{MO_ID}" maxlength="200" value="{COMENTARIOSPROVEEDOR}" onkeypress="javascript:ActivarBotonEnviar({MO_ID});"/>
								</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								&nbsp;<xsl:value-of select="COMENTARIOSPROVEEDOR"/>
							</xsl:otherwise>
							</xsl:choose>
						</td>

						<td><strong><xsl:value-of select="RETRASO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='dias']/node()"/></strong></td>

						<td class="textLeft">
						<xsl:choose>
						<xsl:when test="ESTADO='ACEPTAR'">
							<a class="btnDestacado">
							<xsl:choose>
							<xsl:when test="$BLOQUEARBANDEJA='S'">
								<xsl:attribute name="href">javascript:AvisoPedidoBloqueado();</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<!--<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/<xsl:value-of select="ENLACETAREA"/>','Multioferta',100,100,0,0)</xsl:attribute>-->
								<xsl:attribute name="href">javascript:AbrirMultioferta(<xsl:value-of select="MO_ID"/>)</xsl:attribute>
							</xsl:otherwise>
							</xsl:choose>
								<xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar']/node()"/>
							</a>
						</xsl:when>
						<xsl:otherwise>
							<!--<div class="botonLargoVerdadNara"><strong>-->
							<a class="btnDestacado" id="EnviarDatosProveedor_{MO_ID}" href="javascript:EnviarInfoProveedor({MO_ID});" style="display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
							<!--</strong></div>-->
						</xsl:otherwise>
						</xsl:choose>
						</td>
						<!-- 26may16 Nueva funcionalidad para algunos proveedores: poder informar directamente el seguimiento de pedidos	-->
						<xsl:if test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/PERMITIR_CONTROL_PEDIDOS">
        					<xsl:choose>
        					<xsl:when test="NUMENTRADASCONTROL>0">
        					  <td class="textLeft">
            					<strong><a>
            					  <xsl:attribute name="href">javascript:AbrirControl(<xsl:value-of select="PED_ID"/>)</xsl:attribute>
            					  <xsl:value-of select="USUARIOCONTROL"/>
            					</a></strong>
            					<xsl:if test="CAMBIOSMVM">&nbsp;<img src="http://www.newco.dev.br/images/bolaAmbar.gif"/></xsl:if>
        					  </td>
        					  <td>
            					<xsl:choose>
            					<xsl:when test="PROXIMAACCIONCADUCADA='S'">
            					  <b><font color="red"><xsl:value-of select="PROXIMAACCION"/></font></b>
            					</xsl:when>
            					<xsl:otherwise>
            					  <xsl:value-of select="PROXIMAACCION"/>
            					</xsl:otherwise>
            					</xsl:choose>
        					  </td>
        					</xsl:when>
        					<xsl:otherwise>
        					  <td class="textLeft">
            					<strong><a>
            					  <xsl:attribute name="href">javascript:AbrirControl(<xsl:value-of select="PED_ID"/>)</xsl:attribute>
            					  <xsl:value-of select="document($doc)/translation/texts/item[@name='pend']/node()"/>
            					</a></strong>
        					  </td>
        					  <td>&nbsp;</td>
        					</xsl:otherwise>
        					</xsl:choose>
						</xsl:if>
					</tr>

				<!--reclamar-->
				<xsl:if test="RECLAMACION = 'S'">
					<tr class="reclamarBox fondoNaranja" style="display:; border:none;">
						<xsl:attribute name="id">reclamarBox_<xsl:value-of select="PED_ID"/></xsl:attribute>
						<td colspan="9" class="textRight">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='retraso_acumulado_act']/node()"/> [<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/> <xsl:value-of select="NUMERO_PEDIDO" />]:</td>
						<td colspan="5" class="textLeft">
							<xsl:value-of select="COMENTARIOSPROVEEDOR"/>
						</td>
					</tr>
				</xsl:if>
				</xsl:for-each>

			</tbody>
			<tfoot class="rodape_tabela">
    			<tr>
					<td class="color_status">&nbsp;</td>
        			<td colspan="5">&nbsp;</td>
        			<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:</strong></td>
        			<td style="text-align:right;">
					  <xsl:value-of select="DIVISA/PREFIJO"/>
        			  <xsl:choose>
        			  <xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MOSTRAR_PRECIOS_CON_IVA"><xsl:value-of select="TOTAL_PEDIDOS_CONIVA" /></xsl:when>
        			  <xsl:otherwise><xsl:value-of select="TOTAL_PEDIDOS" /></xsl:otherwise>
        			  </xsl:choose>
					  <xsl:value-of select="DIVISA/SUFIJO"/>
        			</td>
        			<td colspan="4">&nbsp;</td>
					<td colspan="5" class="textLeft">
						<strong>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='retraso_acumulado_act']/node()"/>:
							<xsl:value-of select="RETRASO_TOTAL"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='dias']/node()"/><br/>
							&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='retraso_acumulado']/node()"/>: <xsl:value-of select="MES_ACTUAL"/>: 
							<xsl:value-of select="RETRASO_TOTAL_MES"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='dias']/node()"/>
						</strong>
					</td>
    			</tr>
			</tfoot>
		</xsl:otherwise>
		</xsl:choose><!-- fin de choose si hay pedidos-->
		</table>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		</div><!--fin de tabela tabela_redonda-->
	</div><!--fin de divleft90-->
	<br /><br />
</xsl:template>

<xsl:template match="MENSAJE">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="NOTICIAS">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/WorkFlowPendientes/LANG"><xsl:value-of select="/WorkFlowPendientes/LANG"/></xsl:when>
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

	<div class="marginLeft100">
	<span class="titulo_negrito"><xsl:value-of select="document($doc)/translation/texts/item[@name='noticias_de']/node()"/><xsl:value-of select="/WorkFlowPendientes/INICIO/PORTAL/PMVM_NOMBRE"/></span>

	<xsl:for-each select="NOTICIA">
		<div class="linha_separacao_noticias"></div>
		<div class="circulo_noticia importante"></div><span class="texto_padrao"><xsl:copy-of select="FECHA"/> | </span><span class="texto_negrito">
			<xsl:choose>
			<xsl:when test="not(ENLACE)">
				<xsl:value-of select="TITULO"/>
			</xsl:when>
			<xsl:otherwise>
				<a href="{ENLACE/NOT_ENLACE_URL}" title="{ENLACE/NOT_ENLACE_URL}" target="_blank"><xsl:copy-of select="TITULO"/></a>
			</xsl:otherwise>
			</xsl:choose>
		</span>
		<div class="conteudo_noticias">
			<xsl:copy-of select="CUERPO"/>
			<xsl:if test="$destacar='N'">
			&nbsp;<a class="btnDestacadoPeq" href="javascript:NoticiaLeida('{ID}');"><xsl:value-of select="document($doc)/translation/texts/item[@name='leida']/node()"/></a>
			</xsl:if>
		</div>
	</xsl:for-each>
	</div>
	<br/><br/>
</xsl:template>

<xsl:template name="INCIDENCIAS">
    <!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
  <!--idioma fin-->

<!-- Incidencias de Productos en curso -->
<xsl:choose>
<xsl:when test="/WorkFlowPendientes/INICIO/INCIDENCIASPRODUCTOS/INCIDENCIA and not(/WorkFlowPendientes/INICIO/INCIDENCIASPRODUCTOS/MVM)">
  <div class="divLeft95m5 boxInicio" id="incidenciasBox" style="border:1px solid #939494;border-top:0;margin-bottom:15px;">
		<table class="buscador">
			<tr class="tituloTabla">
				<th colspan="9"><xsl:value-of select="document($doc)/translation/texts/item[@name='incidencias']/node()"/></th>
			</tr>
			<tr class="subTituloTabla">
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_abbr']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
				<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
				<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
				<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='res']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>
				<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_cliente']/node()"/></th>
				<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
			</tr>

		<tbody>
		<xsl:for-each select="/WorkFlowPendientes/INICIO/INCIDENCIASPRODUCTOS/INCIDENCIA">
			<tr class="conhover" style="border-bottom:1px solid #C3D2E9;">
				<td><xsl:value-of select="PROD_INC_CODIGO"/></td>
				<td><xsl:value-of select="PROD_INC_FECHA"/></td>
				<td style="text-align:left;">&nbsp;
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencia.xsql?ID_INC={PROD_INC_ID}&amp;PRO_ID={PROD_INC_IDPRODUCTO}&amp;LIC_OFE_ID={PROD_INC_IDOFERTA_LIC}','incidencia',100,80,0,-10);">
                		<!--15jun18     -->
                		<xsl:choose>
                		<xsl:when test="REFERENCIA=''"><xsl:value-of select="REFERENCIA"/></xsl:when>
                		<xsl:otherwise><xsl:value-of select="PROD_INC_REFPROVEEDOR"/></xsl:otherwise>
                		</xsl:choose>
					</a>
				</td>
				<td style="text-align:left;">&nbsp;
					<strong>
            <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencia.xsql?ID_INC={PROD_INC_ID}&amp;PRO_ID={PROD_INC_IDPRODUCTO}&amp;LIC_OFE_ID={PROD_INC_IDOFERTA_LIC}','incidencia',100,80,0,-10);">
                <!--15jun18     -->
                <xsl:choose>
                <xsl:when test="PROD_INC_DESCESTANDAR!=''"><xsl:value-of select="PROD_INC_DESCESTANDAR"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="NOMBREPRODUCTOPROV"/></xsl:otherwise>
                </xsl:choose>
            </a>
          </strong>
				</td>
				<td style="text-align:left;"><xsl:value-of select="USUARIO"/></td>
				<td>
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame2022.xsql?EMP_ID={IDCLIENTE}&amp;VENTANA=NUEVA','Cliente',100,80,0,-20);">
						<xsl:value-of select="CLIENTE"/>
					</a>
				</td>
				<td style="text-align:left;">
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTROCLIENTE}','Centro Cliente',100,80,0,-20);">
						<xsl:value-of select="CENTROCLIENTE"/>
          </a>
        </td>
				<td style="text-align:left;">
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame2022.xsql?EMP_ID={IDPROVEEDOR}&amp;VENTANA=NUEVA','Vendedor',100,80,0,-20);">
						<xsl:value-of select="PROVEEDOR"/>
					</a>
				</td>
				<td><xsl:value-of select="ESTADO"/></td>
			</tr>
		</xsl:for-each>
		</tbody>
		</table>
  </div>
</xsl:when>
<xsl:otherwise>
<!--<p style="text-align:center;font-weight:bold;margin:15px 0;"><xsl:value-of select="document($doc)/translation/texts/item[@name='incidencias_sin_resultados']/node()"/></p>-->
</xsl:otherwise>
</xsl:choose>
</xsl:template><!-- FIN Incidencias de Productos -->

<xsl:template name="EVALUACIONES">
  <!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
  <!--idioma fin-->

<!-- Evaluacion de Productos en curso -->
<xsl:choose>
<xsl:when test="/WorkFlowPendientes/INICIO/EVALUACIONESPRODUCTOS/EVALUACION">
  <div class="divLeft95m5 boxInicio" id="evaluacionesBox" style="border:1px solid #939494;border-top:0;margin-bottom:15px;">
		<table class="buscador">
		<!--<table class="grandeInicio">
			<tr class="tituloTablaPeq">-->
			<tr class="tituloTabla">
				<th colspan="9"><xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion_productos']/node()"/></th>
			</tr>
			<tr class="subTituloTabla">
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_abbr']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
				<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
				<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
        <th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
				<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/></th>
				<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_evaluacion']/node()"/></th>
				<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
			</tr>

		<tbody>
		<xsl:for-each select="/WorkFlowPendientes/INICIO/EVALUACIONESPRODUCTOS/EVALUACION">
      <tr class="conhover" style="border-bottom:1px solid #C3D2E9;">
				<td><xsl:value-of select="PROD_EV_CODIGO"/></td>
				<td><xsl:value-of select="PROD_EV_FECHA"/></td>
				<td style="text-align:left;">&nbsp;
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/EvaluacionProducto.xsql?ID_EVAL={PROD_EV_ID}','Evaluaci?n producto',100,80,0,-10);">
						<xsl:value-of select="REFERENCIA"/>
					</a>
				</td>
				<td style="text-align:left;">&nbsp;
					<strong>
            <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/EvaluacionProducto.xsql?ID_EVAL={PROD_EV_ID}','Evaluaci?n producto',100,80,0,-10);">
							<xsl:value-of select="PROD_EV_NOMBRE"/>
            </a>
          </strong>
				</td>
        <td style="text-align:left;">
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame2022.xsql?EMP_ID={PROVEEDOR}&amp;VENTANA=NUEVA','Vendedor',100,80,0,-20);">
						<xsl:value-of select="PROVEEDOR"/>
					</a>
				</td>
				<td style="text-align:left;"><xsl:value-of select="AUTOR"/></td>
				<td style="text-align:left;">
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTROEVALUACION}','Centro Evaluaci?n',100,80,0,-20);">
						<xsl:value-of select="CENTROEVALUACION"/>
          </a>
        </td>
				<td style="text-align:left;"><xsl:value-of select="ESTADO"/></td>
			</tr>
		</xsl:for-each>
		</tbody>
		</table>
	</div>
  <br />
  <br/>
</xsl:when>
<xsl:otherwise>
<!--<p style="text-align:center;font-weight:bold;margin:15px 0;"><xsl:value-of select="document($doc)/translation/texts/item[@name='evaluaciones_sin_resultados']/node()"/></p>-->
</xsl:otherwise>
</xsl:choose>
</xsl:template><!-- FIN evaluacion de Productos -->

<xsl:template name="LICITACIONES">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="//LANG"><xsl:value-of select="//LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
  <!--idioma fin-->

<!-- Licitaciones en curso -->
<xsl:choose>
<xsl:when test="/WorkFlowPendientes/INICIO/LICITACIONES/LICITACION and not(/WorkFlowPendientes/INICIO/LICITACIONES/MVM)">
  <!--<div class="divLeft95m5 boxInicio" id="licitacionesBox" style="border:1px solid #939494;border-top:0;margin-bottom:15px;">-->
  <div>
		<!--<table class="grandeInicio">-->
		<table class="buscador">
		<thead>
			<!--<tr class="tituloTablaPeq">-->
			<tr class="tituloTabla">
				<th align="left" colspan="10"><xsl:value-of select="document($doc)/translation/texts/item[@name='LICITACIONES']/node()"/>&nbsp;<a href="http://www.newco.dev.br/Gestion/Comercial/Licitaciones.xsql">[<xsl:value-of select="document($doc)/translation/texts/item[@name='Busqueda_avanzada']/node()"/>]</a></th>
			</tr>
			<tr class="subTituloTabla">
				<th style="width:60px;text-align:left;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='codigo']/node()"/></th>
				<th style="width:250px;text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></th>
				<xsl:if test="/WorkFlowPendientes/INICIO/LICITACIONES/FIDAREAGEOGRAFICA/field">
					<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='Area_geografica']/node()"/></th>
				</xsl:if>
				<th style="text-align:left;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/></th>
				<th style="width:170px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
				<th style="width:200px;text-align:left;">
					<xsl:choose>
					<xsl:when test="/WorkFlowPendientes/INICIO/IDPAIS=55"><xsl:value-of select="document($doc)/translation/texts/item[@name='Comprador']/node()"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="document($doc)/translation/texts/item[@name='Responsable']/node()"/></xsl:otherwise>
					</xsl:choose>
				</th>
				<th style="width:100px;text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/></th>
			<!-- 3set19
			<xsl:choose>
			<xsl:when test="/WorkFlowPendientes/INICIO/LICITACIONES/MOSTRAR_PRECIO_IVA">
				<th style="width:100px;"><xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_cIVA_2line']/node()"/></th>
			</xsl:when>
			<xsl:otherwise>
				<th style="width:100px;"><xsl:value-of select="/WorkFlowPendientes/INICIO/DIVISA/PREFIJO"/><xsl:value-of select="/WorkFlowPendientes/INICIO/DIVISA/SUFIJO"/></th>
			</xsl:otherwise>
			</xsl:choose>
			-->
				<th style="width:130px;text-align:left;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_inicio']/node()"/></th>
				<th style="width:130px;text-align:left;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/></th>
				<th style="width:130px;text-align:left;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_oferta']/node()"/></th>
			</tr>
		</thead>

		<tbody>
		<xsl:for-each select="/WorkFlowPendientes/INICIO/LICITACIONES/LICITACION">
			<tr class="conhover">
			<td style="text-align:left;">
          		<strong>
            	&nbsp;<a href="javascript:Licitacion({ID});">
					<xsl:value-of select="LIC_CODIGO"/>
            	</a>
          		</strong>
       		</td>
			<td style="text-align:left;">
				<xsl:if test="FEDERASSANTAS"><img src="http://www.newco.dev.br/Conecta/img/logo_conecta.png" height="24px" width="67px"/>&nbsp;</xsl:if>
				<xsl:choose>
				<xsl:when test="/WorkFlowPendientes/INICIO/LICITACIONES/INCLUIR_CENTRO_PEDIDO">
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={CENTROPEDIDO/ID}','centro',100,80,0,-20);" class="noDecor">
						<xsl:value-of select="CENTROPEDIDO/NOMBRE"/>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame2022.xsql?EMP_ID={IDEMPRESA}&amp;VENTANA=NUEVA','Empresa',100,80,0,-20);">
						<xsl:value-of select="EMPRESA"/>
        			</a>
				</xsl:otherwise>
				</xsl:choose>
			</td>
			<xsl:if test="/WorkFlowPendientes/INICIO/LICITACIONES/FIDAREAGEOGRAFICA/field">
				<td><xsl:value-of select="CENTROPEDIDO/AREAGEOGRAFICA"/></td>
			</xsl:if>
			<td align="center" valign="middle">&nbsp;
				<xsl:if test="LIC_URGENTE = 'S' or VENCE_24HORAS"><img src="http://www.newco.dev.br/images/2017/warning-red.png"><xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_urgente']/node()"/></xsl:attribute></img>&nbsp;</xsl:if>
          		<strong>
            	<a href="javascript:Licitacion({ID});">
            		<xsl:value-of select="substring(LIC_TITULO,1,60)"/>
            	</a>
          		</strong>
        	</td>
			<td><xsl:value-of select="ESTADO"/>
				<xsl:if test="ESTADO_AYUDA!=''">
					&nbsp;<xsl:choose>
					<xsl:when test="SEMAFORO='AMBAR'"><img src="http://www.newco.dev.br/images/bolaAmbar.gif" class="static" title="{ESTADO_AYUDA}"/></xsl:when>
					<xsl:otherwise><img src="http://www.newco.dev.br/images/2017/info.png" class="static" title="{ESTADO_AYUDA}"/></xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</td>
			<td style="text-align:left;"><xsl:value-of select="RESPONSABLE"/></td>
			<td style="text-align:left;"><xsl:value-of select="LINEASOFERTADAS"/>&nbsp;/&nbsp;<xsl:value-of select="LIC_NUMEROLINEAS"/></td>
			<!--
			<xsl:choose>
			<xsl:when test="/WorkFlowPendientes/INICIO/LICITACIONES/MOSTRAR_PRECIO_IVA">
				<td style="text-align:right;"><xsl:value-of select="LIC_CONSUMOIVA"/>&nbsp;</td>
			</xsl:when>
			<xsl:otherwise>
				<td style="text-align:right;"><xsl:value-of select="LIC_CONSUMO"/>&nbsp;</td>
			</xsl:otherwise>
			</xsl:choose>
			-->
			<td style="text-align:left;">&nbsp;<xsl:value-of select="LIC_FECHAALTA"/></td>
			<td style="text-align:left;">&nbsp;<xsl:value-of select="LIC_FECHADECISIONPREVISTA"/></td>
			<td>
				<xsl:attribute name="style">
					<xsl:choose>
					<xsl:when test="SEMAFORO='AMBAR'">text-align:left;color:red;</xsl:when>
					<xsl:otherwise>text-align:left;</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				&nbsp;<strong><xsl:value-of select="FECHAOFERTA"/></strong>
				<xsl:if test="FECHAOFERTA!='' and ESTADO_AYUDA!='' and SEMAFORO='AMBAR'">
					&nbsp;<img src="http://www.newco.dev.br/images/bolaAmbar.gif" class="static" title="{ESTADO_AYUDA}"/>
				</xsl:if>
			</td>
			</tr>
		</xsl:for-each>
		</tbody>
		</table>
  </div>
  <br/>
  <br/>
</xsl:when>
<xsl:otherwise>
<!--<p style="text-align:center;font-weight:bold;margin:15px 0;"><xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_sin_resultados']/node()"/></p>-->
</xsl:otherwise>
</xsl:choose>
</xsl:template><!-- FIN Licitaciones en curso -->

<xsl:template name="SOLICITUDES">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="//LANG"><xsl:value-of select="//LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
  <!--idioma fin-->

<!-- Solicitudes de Catalogacion en curso -->
<xsl:choose>
<xsl:when test="/WorkFlowPendientes/INICIO/SOLICITUDESCATALOGACION/SOLICITUD and not(/WorkFlowPendientes/INICIO/SOLICITUDESCATALOGACION/MVM)">
  <div class="divLeft95m5 boxInicio" id="solicitudesBox" style="border:1px solid #939494;border-top:0;margin-bottom:15px;">
		<!--<table class="grandeInicio">-->
		<table class="buscador">
		<thead>
			<!--<tr class="tituloTablaPeq">-->
			<tr class="tituloTabla">
				<th colspan="10"><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitudes_catalogacion']/node()"/></th>
			</tr>
			<tr class="subTituloTabla">
				<th class="uno">&nbsp;</th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_abbr']/node()"/></th>
				<th><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
				<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/></th>
				<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_cliente']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
				<th>&nbsp;</th>
			</tr>
		</thead>

		<tbody>
		<xsl:for-each select="/WorkFlowPendientes/INICIO/SOLICITUDESCATALOGACION/SOLICITUD">
			<tr class="conhover" id="SOLIC_{SC_ID}" style="border-bottom:1px solid #C3D2E9;">
				<td>&nbsp;</td>
				<td><xsl:value-of select="SC_CODIGO"/></td>
				<td><xsl:value-of select="SC_FECHA"/></td>
				<td style="text-align:left;">&nbsp;
					<strong>
            <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/SolicitudCatalogacion.xsql?SC_ID={SC_ID}','solicitud catalogacion',100,80,0,-10)">
							<xsl:value-of select="SC_TITULO"/>
            </a>
          </strong>
				</td>
				<td style="text-align:left;">&nbsp;
					<xsl:choose>
					<!-- Texto largo => mostramos pop-up -->
					<xsl:when test="string-length(SC_DESCRIPCION) > 75">
						<a href="#" class="tooltip">
							<xsl:value-of select="substring(SC_DESCRIPCION,0,75)"/><xsl:text>...</xsl:text>
							<span class="classic"><xsl:value-of select="SC_DESCRIPCION"/></span>
						</a>
					</xsl:when>
					<!-- Texto cortio => no hace falta pop-up -->
					<xsl:otherwise>
						<xsl:value-of select="SC_DESCRIPCION"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td><xsl:value-of select="USUARIO"/></td>
				<td>
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame2022.xsql?EMP_ID={IDCLIENTE}','DetalleEmpresa',100,80,0,0)">
						<xsl:value-of select="CLIENTE"/>
					</a>
				</td>
				<td>
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTROCLIENTE}','DetalleCentro',100,80,0,0)">
						<xsl:value-of select="CENTROCLIENTE"/>
					</a>
				</td>
				<td><xsl:value-of select="ESTADO"/></td>
				<td>&nbsp;</td>
			</tr>
		</xsl:for-each>
		</tbody>
		</table>
  </div><!--fin de divLeft95m5-->
</xsl:when>
<xsl:otherwise>
<!--<p style="text-align:center;font-weight:bold;margin:15px 0;"><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_catalogacion_sin_resultados']/node()"/></p>-->
</xsl:otherwise>
</xsl:choose>
<!-- FIN Solicitudes de Catalogacion en curso -->

<!--boton solicitud catalogacion-->
<xsl:if test="/WorkFlowPendientes/INICIO/SOLICITUDCATALOGACION or /WorkFlowPendientes/INICIO/CONTROLPRECIOS">
	<div class="divCenter90" style="text-align:right;margin-top:10px;">
	<a class="btnDestacado" href="http://www.newco.dev.br/Gestion/Comercial/NuevaSolicitudCatalogacion.xsql" target="_self">
	<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitar_catalogacion_productos']/node()"/>
	</a>&nbsp;&nbsp;&nbsp;
	<br/>
	<br/>
	<br/>
	</div>
</xsl:if>
<!--fin de boton solicitud catalogacion-->
</xsl:template><!-- FIN DE SOLICITUDES-->

<xsl:template name="SOLICITUDESOFERTA">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="//LANG"><xsl:value-of select="//LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
  <!--idioma fin-->

<!-- Solicitudes de oferta en curso -->
<xsl:choose>
<xsl:when test="/WorkFlowPendientes/INICIO/SOLICITUDESOFERTA/SOLICITUD and not(/WorkFlowPendientes/INICIO/SOLICITUDESOFERTA/MVM)">
  <div class="divLeft95m5 boxInicio" id="solicitudesBox" style="border:1px solid #939494;border-top:0;margin-bottom:15px;">
		<!--<table class="grandeInicio">-->
		<table class="buscador">
		<thead>
			<!--<tr class="tituloTablaPeq">-->
			<tr class="tituloTabla">
				<th colspan="10"><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitudes_oferta']/node()"/></th>
			</tr>
			<tr class="subTituloTabla">
				<th class="uno">&nbsp;</th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_abbr']/node()"/></th>
				<th><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
				<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/></th>
				<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
				<th>&nbsp;</th>
			</tr>
		</thead>

		<tbody>
		<xsl:for-each select="/WorkFlowPendientes/INICIO/SOLICITUDESOFERTA/SOLICITUD">
			<tr class="conhover" id="SOLIC_{SO_ID}" style="border-bottom:1px solid #C3D2E9;">
				<td>&nbsp;</td>
				<td>
            		<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/SolicitudOferta.xsql?SO_ID={SO_ID}','solicitud oferta',100,80,0,-10)">
						<xsl:value-of select="SO_CODIGO"/>
					</a>
				</td>
				<td><xsl:value-of select="SO_FECHA"/></td>
				<td style="text-align:left;">&nbsp;
					<strong>
            		<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/SolicitudOferta.xsql?SO_ID={SO_ID}','solicitud oferta',100,80,0,-10)">
						<xsl:value-of select="SO_TITULO"/>
            		</a>
        		  </strong>
				</td>
				<td style="text-align:left;">&nbsp;
					<xsl:choose>
					<!-- Texto largo => mostramos pop-up -->
					<xsl:when test="string-length(SO_DESCRIPCION) > 75">
						<a href="#" class="tooltip">
							<xsl:value-of select="substring(SO_DESCRIPCION,0,75)"/><xsl:text>...</xsl:text>
							<span class="classic"><xsl:value-of select="SO_DESCRIPCION"/></span>
						</a>
					</xsl:when>
					<!-- Texto cortio => no hace falta pop-up -->
					<xsl:otherwise>
						<xsl:value-of select="SO_DESCRIPCION"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame2022.xsql?EMP_ID={IDCLIENTE}','DetalleEmpresa',100,80,0,0)">
						<xsl:value-of select="CLIENTE"/>
					</a>
				</td>
				<td><xsl:value-of select="USUARIO"/></td>
				<td><xsl:value-of select="ESTADO"/></td>
				<td>&nbsp;</td>
			</tr>
		</xsl:for-each>
		</tbody>
		</table>
  </div><!--fin de divLeft95m5-->
</xsl:when>
<xsl:otherwise>
<!--<p style="text-align:center;font-weight:bold;margin:15px 0;"><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_catalogacion_sin_resultados']/node()"/></p>-->
</xsl:otherwise>
</xsl:choose>
<!-- FIN Solicitudes de oferta en curso -->
</xsl:template><!-- FIN DE SOLICITUDES-->


<xsl:template match="GESTIONCOMERCIAL">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="//LANG"><xsl:value-of select="//LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

  <div class="divLeft95m5 boxInicio" style="border:1px solid #939494;border-top:0;display:;">
	<!--<table class="grandeInicio" id="gestionComercialBox">-->
	<table class="buscador" id="gestionComercialBox">
	<tr class="tituloTabla">
	<!--<tr class="tituloTablaPeq">-->
		<th colspan="3">&nbsp;</th>
		<th colspan="4"><xsl:value-of select="document($doc)/translation/texts/item[@name='tareas_pendientes']/node()"/></th>
		<th colspan="4" align="right">
		<xsl:if test="INICIO/GESTIONCOMERCIAL/GESTION[position() &gt; 6]">
			<a href="http://www.newco.dev.br/Gestion/Comercial/Tareas.xsql">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='ver_mas_tareas']/node()"/>
			</a>&nbsp;
        	<span style="color:#333;">(<xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>&nbsp;
        	<xsl:value-of select="INICIO/GESTIONCOMERCIAL/TOTAL"/>)</span>&nbsp;&nbsp;
		</xsl:if>
		</th>
		</tr>
		<tr class="subTituloTabla">
			<th>&nbsp;</th>
			<th class="seis"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
			<th class="doce" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/></th>
			<th class="catorce" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/></th>
			<th class="quince" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></th>
			<th class="trenta" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_tarea']/node()"/></th>
			<th class="seis"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_limite']/node()"/></th>
			<th class="siete" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
			<th class="siete" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='prioridad']/node()"/></th>
			<th>&nbsp;</th>
			<th>&nbsp;</th>
		</tr>

	<xsl:for-each select="INICIO/GESTIONCOMERCIAL/GESTION">
    <xsl:if test="position() &lt; 6"><!--ense?o solo 5 tareas-->
      <xsl:if test="ID = IDPADRE"><!-- si id = idpadre significa que es la tarea no tearea hijo-->
				<tr class="conhover" style="border-bottom:1px solid #C3D2E9;">
					<td>&nbsp;</td>
					<td>
						<xsl:if test="RECIENTE"><xsl:attribute name="class">amarillo</xsl:attribute></xsl:if>
						<input type="hidden" name="IDPADRE_{ID}" value="{IDPADRE}"/>
						<xsl:value-of select="FECHA"/>
					</td>
					<td style="text-align:left;"><xsl:value-of select="AUTOR"/></td>
					<td style="text-align:left;">
		      	<xsl:value-of select="IDRESPONSABLE/field/dropDownList/listElem[ID = ../../@current]/listItem"/>
					</td>
					<td style="text-align:left;">
		        <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame2022.xsql?EMP_ID={IDEMPRESA/field/dropDownList/listElem[ID = ../../@current]/ID}&amp;VENTANA=NUEVA','Vendedor',100,80,0,-20);">
							<xsl:value-of select="IDEMPRESA/field/dropDownList/listElem[ID = ../../@current]/listItem"/>
		        </a>
					</td>
					<td class="textLeft">
		        <strong><a href="http://www.newco.dev.br/Gestion/Comercial/Tareas.xsql"><xsl:value-of select="TEXTO"/></a></strong>
		      </td>
					<td><xsl:value-of select="FECHALIMITE"/></td>
					<td style="text-align:left;">
						<xsl:value-of select="ESTADO/field/dropDownList/listElem[ID = ../../@current]/listItem"/>
					</td>
					<td style="text-align:left;">
						<xsl:value-of select="PRIORIDAD/field/dropDownList/listElem[ID = ../../@current]/listItem"/>
					</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
      </xsl:if>
    </xsl:if><!--fin if enseï¿½o solo 5 tareas-->
	</xsl:for-each>
	</table>
  </div>
	<br/><br/>
</xsl:template>

<xsl:template match="BANDEJA">
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
	<xsl:when test="TOTAL=0">
			<!--	24 mar 03 ET    No presentamos la bandeja si no hay datos	-->
	</xsl:when>
	<xsl:otherwise>
		<div class="divLeft textCenter" style="margin-bottom:20px;">
			<span class="tituloTabla"><xsl:value-of select="LISTATAREAS/TITULO"/></span>
			<br/>
			<div class="linha_separacao_cotacao_y"></div>
			<div class="tabela tabela_redonda">
				<table cellspacing="10px" cellpadding="10px">
				<thead class="cabecalho_tabela">
				<tr>
         			<!-- pos -->
					<th class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
					<th class="uno">&nbsp;</th>	<!--	icono urgente		-->
         			 <!-- numero -->
					<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='numero']/node()"/></th>
					<!-- centro (para usuarios admin o multicentro -->
					<xsl:if test="/WorkFlowPendientes/INICIO/BANDEJA/MULTICENTROS or /WorkFlowPendientes/INICIO/BANDEJA/DERECHOS_ADMIN='EMPRESA'">
						<th class="quince textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
					</xsl:if>
					<!-- fecha -->
					<th class="cinco textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
					<!-- empresa -->
					<th class="veinte textLeft">&nbsp;<xsl:value-of select="LISTATAREAS/TITULOEMPRESA"/></th>
					<!-- Estado -->
					<th class="veinte textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>

					<xsl:if test="INCLUIR_RESPONSABLE">
						<th class="dos textLeft"></th>
						<th class="quince textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/></th>
					</xsl:if>

					<xsl:choose><!-- no error / no sorry / comprador -->
					<xsl:when test="../../ROL[.='C']">
						<!-- plantilla -->
						<th class="quince textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='plantilla']/node()"/></th>
					</xsl:when>
					</xsl:choose>
						<!-- Fecha decision o entrega -->
						<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_entrega']/node()"/></th>
					<!-- Importe -->
					<xsl:choose>
					<!--<xsl:when test="LISTATAREAS/ROL='C' or LISTATAREAS/ROL='V'">-->
					<!--<xsl:when test="LISTATAREAS/TIPO_TAREA='PENDIENTES_APROBACION'">-->
					<xsl:when test="TIPO='MULTIOFERTAS'">
						<th class="diez">
							<xsl:choose>
								<xsl:when test="/WorkFlowPendientes/INICIO/MOSTRAR_PRECIOS_CON_IVA"><xsl:value-of select="document($doc)/translation/texts/item[@name='total_cIVA']/node()"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="document($doc)/translation/texts/item[@name='total_sin_iva']/node()"/></xsl:otherwise>
							</xsl:choose>
						</th>
					</xsl:when>
					<xsl:when test="LISTATAREAS/ROL='E' or LISTATAREAS/ROL='R'">
						<th class="diez"><xsl:value-of select="document($doc)/translation/texts/item[@name='coste']/node()"/></th>
					</xsl:when>
					<xsl:otherwise>
						<!--	Para informes de evaluacion no utilizamos esta columna	-->
					</xsl:otherwise>
					</xsl:choose>
					<th class="uno">&nbsp;</th>
				</tr>
				</thead>

				<tbody class="corpo_tabela">
					<xsl:for-each select="LISTATAREAS/TAREA">

						<tr class="conhover">
							<xsl:choose>
							<xsl:when test="IDINCIDENCIA!=''">
								<xsl:attribute name="class">rojo</xsl:attribute>
							</xsl:when>
							</xsl:choose>

							<xsl:apply-templates select="MO_ID"/>
                    		<td class="color_status"><xsl:value-of select="position()"/></td>

							<td align="center" valign="middle">
								<xsl:choose>
								<xsl:when test="URGENTE"><img src="http://www.newco.dev.br/images/2017/warning-red.png"/></xsl:when>
								<xsl:otherwise>&nbsp;</xsl:otherwise>
								</xsl:choose>
							</td>


							<td class="textLeft">
							<xsl:choose>
							<xsl:when test="STATUS_COLOR[.='OPONENT_SIDE']">
								&nbsp;<strong><a>
									<!--<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/<xsl:value-of select="../../ENLACETAREA"/><xsl:value-of select="ID"/>','Multioferta',100,100,0,0);</xsl:attribute>-->
									<xsl:attribute name="href">javascript:AbrirMultioferta(<xsl:value-of select="MO_ID"/>)</xsl:attribute>
									<xsl:attribute name="class">
										<xsl:if test="IDINCIDENCIA!=''">alerta</xsl:if>
									</xsl:attribute>
									<xsl:value-of select="NUMERO"/>
								</a></strong>
							</xsl:when>
							<xsl:when test="STATUS_COLOR[.='DEAD_PROCESS']">
								<strong><a>
									<!--<xsl:attribute name="href">javascript:MostrarPagPersonalizada('<xsl:value-of select="../../ENLACETAREA"/><xsl:value-of select="ID"/>&amp;ORIGEN=WFStatusHTML.xsl_6&amp;SES_ID=<xsl:value-of select="//SES_ID"/>&amp;READ_ONLY=S<xsl:choose><xsl:when test="../../TIPO='MULTIOFERTAS'">&amp;xml-stylesheet=MultiofertaFrame-<xsl:value-of select="MO_STATUS"/>-RO-HTML.xsl</xsl:when></xsl:choose>','Multioferta',100,100,0,0);</xsl:attribute>-->
                            		<!--<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/<xsl:value-of select="../../ENLACETAREA"/><xsl:value-of select="ID"/>','Multioferta',100,100,0,0);</xsl:attribute>-->
									<xsl:attribute name="href">javascript:AbrirMultioferta(<xsl:value-of select="MO_ID"/>)</xsl:attribute>
									<xsl:attribute name="class">
										<xsl:if test="IDINCIDENCIA!=''">alerta</xsl:if>
									</xsl:attribute>
									<xsl:value-of select="NUMERO"/>
								</a></strong>
							</xsl:when>
							<xsl:when test="STATUS_COLOR[.='ACTION_REQUIRED']">
								<b>
									<strong><a>
										<!--<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/<xsl:value-of select="../../ENLACETAREA"/><xsl:value-of select="ID"/>','Multioferta',100,100,0,0);</xsl:attribute>-->
										<xsl:attribute name="href">javascript:AbrirMultioferta(<xsl:value-of select="MO_ID"/>)</xsl:attribute>
										<xsl:attribute name="class">
											<xsl:if test="IDINCIDENCIA!=''">alerta</xsl:if>
										</xsl:attribute>
										<xsl:value-of select="NUMERO"/>
									</a></strong>
								</b>
							</xsl:when>
							</xsl:choose>
							</td>
							<xsl:if test="/WorkFlowPendientes/INICIO/BANDEJA/MULTICENTROS or /WorkFlowPendientes/INICIO/BANDEJA/DERECHOS_ADMIN='EMPRESA'">
								<td class="textLeft">
									<!-- centro (para usuarios admin o multicentro -->
									<xsl:value-of select="CENTRO"/>
								</td>
							</xsl:if>

							<td align="center">
								<xsl:apply-templates select="FECHA"/>
							</td>
							<td class="textLeft">
							<xsl:choose>
							<xsl:when test="../ROL='V' or ../ROL='R' or ../ROL='E'">	<!-- 	Ventas	-->
								<xsl:apply-templates select="CENTRO2"/>
							</xsl:when>
							<xsl:when test="PRODUCTO"><!--	Para informes de evaluacion de productos	-->
								<xsl:apply-templates select="PRODUCTO"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="EMPRESA2"/><!--	Compras	-->
							</xsl:otherwise>
							</xsl:choose>
							</td>
							<td style="text-align:left;">
								<!--<xsl:apply-templates select="ERW_DESCRIPCION_BANDEJA"/>-->
								<xsl:apply-templates select="./SEMAFORO"/>
							<xsl:choose>
							<xsl:when test="STATUS_COLOR[.='OPONENT_SIDE']">
								<strong><a>
									<!--<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/<xsl:value-of select="../../ENLACETAREA"/><xsl:value-of select="ID"/>','Multioferta',100,100,0,0);</xsl:attribute>-->
									<xsl:attribute name="href">javascript:AbrirMultioferta(<xsl:value-of select="MO_ID"/>)</xsl:attribute>
									<xsl:attribute name="class">
										<xsl:if test="IDINCIDENCIA!=''">alerta</xsl:if>
									</xsl:attribute>
									<xsl:value-of select="ERW_DESCRIPCION_BANDEJA"/>
								</a></strong>
							</xsl:when>
							<xsl:when test="STATUS_COLOR[.='DEAD_PROCESS']">
								<strong><a>
									<!--<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/<xsl:value-of select="../../ENLACETAREA"/><xsl:value-of select="ID"/>','Multioferta',100,100,0,0);</xsl:attribute>-->
									<xsl:attribute name="href">javascript:AbrirMultioferta(<xsl:value-of select="MO_ID"/>)</xsl:attribute>
									<xsl:attribute name="class">
										<xsl:if test="IDINCIDENCIA!=''">alerta</xsl:if>
									</xsl:attribute>
									<xsl:value-of select="ERW_DESCRIPCION_BANDEJA"/>
								</a></strong>
							</xsl:when>
							<xsl:when test="STATUS_COLOR[.='ACTION_REQUIRED']">
								<strong>
									<a>
										<!--<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/<xsl:value-of select="../../ENLACETAREA"/><xsl:value-of select="ID"/>','Multioferta',100,100,0,0)</xsl:attribute>-->
										<xsl:attribute name="href">javascript:AbrirMultioferta(<xsl:value-of select="MO_ID"/>)</xsl:attribute>
										<xsl:attribute name="class">
											<xsl:if test="IDINCIDENCIA!=''">rojo</xsl:if>
										</xsl:attribute>
										<xsl:value-of select="ERW_DESCRIPCION_BANDEJA"/>
									</a>
								</strong>
							</xsl:when>
							</xsl:choose>
							</td>

							<xsl:if test="../../INCLUIR_RESPONSABLE">
								<td class="textLeft">
									<!-- 5mar20 Cuando esté informado, incluiremos el flujo anterior de aprobaciones	-->
									<xsl:if test="APROBACIONES/APROBACION">
										<img  id="imgAPROB_{ID}" name="imgAPROB_{ID}" src="http://www.newco.dev.br/images/recibido.gif" width="16px" height="16px"/>
										<!--	campo oculto para guardar la cadena de aprobaciones-->
										<input class="APROB" type="hidden" id="APROB_{ID}" name="APROB_{ID}">
											<xsl:attribute name="value">
												<xsl:for-each select="APROBACIONES/APROBACION"><xsl:value-of select="MOA_FECHA"/>:&nbsp;<xsl:value-of select="USUARIO"/>[SALTO]</xsl:for-each>
											</xsl:attribute>
										</input>
									&nbsp;
									</xsl:if>
								</td>
								<td class="textLeft">
									<strong><xsl:value-of select="USUARIOAPROBADOR"/></strong>
								</td>
							</xsl:if>
						<xsl:choose>
						<xsl:when test="../../../../LISTATAREAS/ROL[.='C']">
							<td class="textLeft"><xsl:apply-templates select="LP_NOMBRE"/> <!-- presentamos el nombre de la plant. --></td>
						</xsl:when>
						</xsl:choose>
							<td align="center"><xsl:value-of select="FECHA2"/></td>
						<xsl:choose>
						<!--<xsl:when test="../../LISTATAREAS/ROL='C' or ../../LISTATAREAS/ROL='V'">-->
						<!--<xsl:when test="LISTATAREAS/TIPO_TAREA='PENDIENTES_APROBACION'">-->
						<xsl:when test="../../TIPO='MULTIOFERTAS'">
							<td align="right">
								<xsl:choose>
								<xsl:when test="../../LISTATAREAS/TIPO_TAREA='PENDIENTES_APROBACION' and INCUMPLE_PEDIDO_MINIMO"><img src="http://www.newco.dev.br/images/nocheck.gif"/>&nbsp;</xsl:when>
								<xsl:otherwise>&nbsp;</xsl:otherwise>
								</xsl:choose>
								<strong>
								<xsl:value-of select="INICIO/DIVISA/PREFIJO"/>
								<xsl:choose>
									<xsl:when test="/WorkFlowPendientes/INICIO/MOSTRAR_PRECIOS_CON_IVA"><xsl:value-of select="TOTAL"/></xsl:when>
									<xsl:otherwise><xsl:value-of select="SUBTOTAL"/></xsl:otherwise>
								</xsl:choose>
								<xsl:value-of select="INICIO/DIVISA/SUFIJO"/></strong>
							</td>
						</xsl:when>
						<xsl:when test="../../LISTATAREAS/ROL='E' or ../../LISTATAREAS/ROL='R'">
							<td align="right">
								<xsl:choose>
								<xsl:when test="INCUMPLE_PEDIDO_MINIMO"><img src="http://www.newco.dev.br/images/nocheck.gif"/>&nbsp;</xsl:when>
								<xsl:otherwise>&nbsp;</xsl:otherwise>
								</xsl:choose>
								<strong><xsl:value-of select="INICIO/PEDIDOSPROBLEMATICOS/DIVISA/PREFIJO"/><xsl:value-of select="TOTAL"/><xsl:value-of select="INICIO/PEDIDOSPROBLEMATICOS/DIVISA/SUFIJO"/></strong>
							</td>
						</xsl:when>
						<xsl:otherwise>
							<!--	Para informes de evaluacion no utilizamos la columna de total		-->
						</xsl:otherwise>
						</xsl:choose>
						<td align="center">&nbsp;</td>
						</tr>
					</xsl:for-each>
				</tbody>
				<tfoot class="rodape_tabela">
					<tr><td colspan="12">&nbsp;</td></tr>
				</tfoot>
			</table>
			<br /><br /><br /><br />
			</div>
		</div><!--fin de divLeft-->
	</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!--buscador para admin mvm en el medio de tabla pedidos-->
<xsl:template name="buscadorInicioAdmin">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="//LANG"><xsl:value-of select="//LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
	
	<!--	Tabla resumen de actividad		-->
	<xsl:if test="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS">

	<table class="buscador" id="ResumenActividad" style="width:600px;border:1px;display:none;">
	<tr class="subTituloTabla">
		<td><xsl:value-of select="document($doc)/translation/texts/item[@name='ResumenActividad']/node()"/></td>
		<td><xsl:value-of select="document($doc)/translation/texts/item[@name='Recientes']/node()"/></td>
		<td><xsl:value-of select="document($doc)/translation/texts/item[@name='1dia']/node()"/></td>
		<td><xsl:value-of select="document($doc)/translation/texts/item[@name='Activas']/node()"/></td>
	</tr>
	<tr>
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='SolCatalogacion']/node()"/>:</td>
		<td><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_RECIENTES/SOLICITUDES"/></td>
		<td><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/SOLICITUDES"/></td>
		<td><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/SOLICITUDES"/></td>
	</tr>
	<tr>
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Evaluaciones']/node()"/>:</td>
		<td><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_RECIENTES/EVALUACIONES"/></td>
		<td><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/EVALUACIONES"/></td>
		<td><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/EVALUACIONES"/></td>
	</tr>
	<tr>
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Licitaciones']/node()"/>:</td>
		<td><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_RECIENTES/LICITACIONES"/></td>
		<td><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/LICITACIONES"/></td>
		<td><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/LICITACIONES"/></td>
	</tr>
	<tr>
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos']/node()"/>:</td>
		<td><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_RECIENTES/PEDIDOS"/></td>
		<td><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/PEDIDOS"/></td>
		<td><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS"/></td>
	</tr>
	<tr>
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Incidencias']/node()"/>:</td>
		<td><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_RECIENTES/INCIDENCIAS"/></td>
		<td><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/INCIDENCIAS"/></td>
		<td><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/INCIDENCIAS"/></td>
	</tr>
	</table>
	</xsl:if>
	
	<br/>
	
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
		<xsl:if test="/WorkFlowPendientes/INICIO/SOLOPEDIDOS='S'">
			<xsl:choose>
			<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDEMPRESA/field">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:</label>&nbsp;
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDEMPRESA/field"/>
					<xsl:with-param name="claSel">w300px</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<input type="hidden" name="IDEMPRESA" value="{IDEMPRESA}" />
			</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<span class="CompletarTitulo">
			<xsl:value-of select="INICIO/PEDIDOSPROBLEMATICOS/TOTAL" />&nbsp;
			<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>.&nbsp;
			<xsl:value-of select="document($doc)/translation/texts/item[@name='pagina']/node()"/>&nbsp;
			<xsl:variable name="pagina">
			<xsl:choose>
			<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PAGINA != ''">
			  <xsl:value-of select="number(INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PAGINA)+number(1)"/>
			</xsl:when>
			<xsl:otherwise>1</xsl:otherwise>
			</xsl:choose>
			</xsl:variable>
			<xsl:value-of select="$pagina" />&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
			<xsl:value-of select="//BOTONES/NUMERO_PAGINAS" />.&nbsp;
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BOTONES/ANTERIOR">
				<a class="btnNormal" href="javascript:AplicarFiltroPagina({INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BOTONES/ANTERIOR/@Pagina});">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/>
				</a>&nbsp;
			</xsl:if>
			<a class="btnNormal" href="javascript:DescargarExcel();"><xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/></a>&nbsp;
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BOTONES/SIGUIENTE">
				<a class="btnNormal" href="javascript:AplicarFiltroPagina({INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BOTONES/SIGUIENTE/@Pagina});">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/>
				</a>&nbsp;
			</xsl:if>
		</span>
		</p>
	</div>
	<xsl:if test="/WorkFlowPendientes/INICIO/SOLOPEDIDOS='S' and INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDEMPRESA/field">
		<br/>
	</xsl:if>	
	<br/>
	<!--table select-->
	<table cellspacing="6px" cellpadding="6px">
		<xsl:variable name="BuscAvanzStyle">
			<xsl:choose>
			<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/URGENTE = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BLOQUEADO = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FARMACIA = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MATERIALSANITARIO = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/SINSTOCKS = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/TODOS12MESES = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/INCFUERAPLAZO = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PEDIDOOK = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ENTR_RETRASADO = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PEDIDONOCOINCIDE = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ENTR_PARCIAL = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/RETRASODOCUMTEC = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/NOINFORMADOPLAT = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PROD_ANYADIDOS = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PROD_RETIRADOS = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MALAATENCIONPROV = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FECHAINICIO != '' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FECHAFINAL != ''"></xsl:when>
			<xsl:otherwise>display:none;</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<tr class="filtrosgrandes">
		<th class="w10px">&nbsp;</th>
		<xsl:if test="/WorkFlowPendientes/INICIO/SOLOPEDIDOS='S'">
			<!--<xsl:choose>
			<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDEMPRESA/field">
				<th class="w160px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:</label><br />
						<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDEMPRESA/field"/>
						<xsl:with-param name="claSel">w160px</xsl:with-param>
					</xsl:call-template>
				</th>
			</xsl:when>
			<xsl:otherwise>
				<input type="hidden" name="IDEMPRESA" value="{IDEMPRESA}" />
			</xsl:otherwise>
			</xsl:choose>-->
			<xsl:choose>
			<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDCENTRO/field">
				<th class="w160px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDCENTRO/field"/>
						<xsl:with-param name="claSel">w160px</xsl:with-param>
					</xsl:call-template>
				</th>
			</xsl:when>
			<xsl:otherwise>
				<!-- no hace falta incluir nada	-->
			</xsl:otherwise>
			</xsl:choose>		
		</xsl:if>
		
		<xsl:choose>
		<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/CENTROSCONSUMO">
			<th class="w150px textLeft">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_consumo']/node()"/>:</label><br />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/CENTROSCONSUMO/field"/>
					<xsl:with-param name="claSel">w150px</xsl:with-param>
				</xsl:call-template>
			</th>
		</xsl:when>
		<xsl:otherwise>
			<input type="hidden" name="IDCENTROCONSUMO" value=""/>
		</xsl:otherwise>
		</xsl:choose>
		
		<xsl:if test="not(INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/OCULTAR_PROVEEDOR)">
			<th class="w160px textLeft">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label><br />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDPROVEEDOR/field"/>
					<xsl:with-param name="claSel">w160px</xsl:with-param>
				</xsl:call-template>
			</th>
		</xsl:if>
		<!--
		21dic21 Desactivamos filtro motivo
		<th width="160px"  style="text-align:left;">
			<label>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='motivo']/node()"/>:</label><br />
			&nbsp;<xsl:call-template name="desplegable"><xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDFILTROMOTIVO/field"/></xsl:call-template>&nbsp;
		</th>
		-->
		<input type="hidden" name="IDFILTROMOTIVO" value=""/>
		<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/INCLUIR_COMPRADOR">
		<th class="w140px textLeft">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='comprador']/node()"/>:</label><br />
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDFILTROCOMPRADOR/field"/>
				<xsl:with-param name="claSel">w140px</xsl:with-param>
			</xsl:call-template>
		</th>
		</xsl:if>
		<th class="w140px textLeft">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/>:</label><br />
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDFILTRORESPONSABLE/field"/>
				<xsl:with-param name="claSel">w140px</xsl:with-param>
			</xsl:call-template>
		</th>
		<th class="w140px textLeft">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='situacion']/node()"/>:</label><br />
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDFILTROSEMAFORO/field"/>
				<xsl:with-param name="claSel">w140px</xsl:with-param>
			</xsl:call-template>
		</th>
		<!--
		<th class="w160px textLeft">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_pedido']/node()"/>:</label><br />
			<xsl:call-template name="desplegable"><xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDFILTROTIPOPEDIDO/field"/></xsl:call-template>&nbsp;
		</th>
		-->
		<th class="w100px textLeft">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='numero_pedido']/node()"/>:</label><br />
			<input class="campopesquisa w100px" type="text" name="CODIGOPEDIDO" maxlength="20" value="{INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/CODIGOPEDIDO}"/>
		</th>
		<th class="w120px textLeft">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:</label><br />
			<input class="campopesquisa w120px" type="text" name="PRODUCTO" maxlength="50" value="{INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PRODUCTO}"/>
		</th>

		<!--	Nuevo filtro de periodo		-->
		<th class="w100px textLeft">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo']/node()"/></label><br />
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/FPLAZO/field"/>
				<xsl:with-param name="claSel">w100px</xsl:with-param>
			</xsl:call-template>
		</th>
		<!--	25mar22 para descargar el buscador, quitamos el desplegable de numero de lineas, ampliado a 500 por solicitud de Brasil. lo dejamos en 300, se produce XDK error con 500	-->
		<input type="hidden" name="LINEA_POR_PAGINA" id="LINEA_POR_PAGINA" value="500"/>
		<!--
		<th width="120px" style="text-align:left;">
			<select name="LINEA_POR_PAGINA" id="LINEA_POR_PAGINA" onchange="AplicarFiltro();">
			<option value="30">
    			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/LINEASPORPAGINA = '30'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
			  30 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
			</option>
			<option value="50">
			  <xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/LINEASPORPAGINA = '50'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
			  50 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
			</option>
			<option value="100">
			  <xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/LINEASPORPAGINA = '100'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
			  100 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
			</option>
			<option value="500">
			  <xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/LINEASPORPAGINA = '500'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
			  500 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
			</option>
			<option value="1000">
			  <xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/LINEASPORPAGINA = '1000'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
			  1000 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
			</option>
			</select>
		</th>
		-->
		<th class="w60px textLeft">
			<br/>
			<a href="javascript:FiltrarBusqueda();" title="Buscar" class="btnDestacado">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
			</a>&nbsp;
		</th>
		<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BOTON_RESUMEN">
		<th class="w70px textLeft">
			<br/>
			<a href="javascript:ResumenPedidos();" title="Buscar" class="btnDestacado">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Resumen']/node()"/>
			</a>&nbsp;
		</th>
		</xsl:if>
		<th class="w50px textLeft">
			<br/>
       		<a href="javascript:VerBuscadorAvanzado();" title="Buscador avanzado"  class="btnDiscreto">
				[<xsl:value-of select="document($doc)/translation/texts/item[@name='AVANZADO']/node()"/>]
        	</a>
		</th>
		<th width="*">
			&nbsp;
		</th>
	</tr>
	<tr>
	<td colspan="11" border="1" class="buscadorAvanzado" style="display:none"> 
		<table class="tbBuscAvanzado">
    	<tr id="buscadorAvanzadoOne" class="selectAva buscadorAvanzado sinLinea" height="40">
    	  <th>&nbsp;</th>
    	  <th style="text-align:left;">
        	<!--fecha inicio-->
        	<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_inicio']/node()"/>:</label>&nbsp;
        	<input type="text" name="FECHA_INICIO" value="{INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FECHAINICIO}" size="9" />
    	  </th>
    		<th style="text-align:left;">
        	<!--fecha final-->
        	<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_final']/node()"/>:</label>&nbsp;
        	<input type="text" name="FECHA_FINAL" value="{INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FECHAFINAL}"  size="9"  />
    	  </th>
    	  <th style="text-align:left;">
	  		&nbsp;
    	  </th>
    	  <th style="text-align:left;">
			<!--pedido entregado ok-->
			<input class="muypeq" type="checkbox" name="PED_ENTREGADOOK_CHECK">
				<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PEDIDOOK = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>&nbsp;
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='entrega_ok']/node()"/></label>
    	  </th>
    	  <th style="text-align:left;">
			<!--pedido retrasado-->
			<input class="muypeq" type="checkbox" name="PED_RETRASADO_CHECK">
				<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ENTR_RETRASADO = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>&nbsp;
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ped_retrasado']/node()"/></label>
    	  </th>
    	  <th style="text-align:left;">
			<!--pedido parcial-->
			<input class="muypeq" type="checkbox" name="PED_ENTREGADOPARCIAL_CHECK">
				<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ENTR_PARCIAL = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>&nbsp;
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ped_parcial']/node()"/></label>
    	  </th>
    	  <th>&nbsp;</th>
    	</tr>

    	<tr id="buscadorAvanzadoTwo" class="selectAva buscadorAvanzado sinLinea" height="40">
    	  <!--<xsl:attribute name="style"><xsl:value-of select="$BuscAvanzStyle"/></xsl:attribute>-->
    	  <th>&nbsp;</th>
    		<th style="text-align:left;">
			<!--pedido no informado en la plataforma mvm-->
			<input class="muypeq" type="checkbox" name="PED_NOINFORMADOENPLATAFORMA_CHECK">
				<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/NOINFORMADOPLAT = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>&nbsp;
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='no_info_sistema']/node()"/></label>
    	  </th>
    	  <th style="text-align:left;">
        	<!--ped no coincide-->
			<input class="muypeq" type="checkbox" name="PED_PEDIDONOCOINCIDE_CHECK">
				<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PEDIDONOCOINCIDE = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>&nbsp;
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ped_no_coincide']/node()"/></label>
    	  </th>
    	  <th style="text-align:left;">
        	<!--pedido con productos a?adidos-->
			<input class="muypeq" type="checkbox" name="PED_PRODUCTOSANYADIDOS_CHECK">
				<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PROD_ANYADIDOS = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>&nbsp;
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='prod_anadidos']/node()"/></label>
    	  </th>
    	  <th style="text-align:left;">
        	<!--pedido con productos retirados-->
			<input class="muypeq" type="checkbox" name="PED_PRODUCTOSRETIRADO_CHECK">
				<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PROD_RETIRADOS = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>&nbsp;
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='prod_retirados']/node()"/></label>
    	  </th>
    	  <th style="text-align:left;">
			<!--pedido con problemas en la documentacion tecnica-->
			<input class="muypeq" type="checkbox" name="PED_RETRASODOCTECNICA_CHECK">
				<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/RETRASODOCUMTEC = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>&nbsp;
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='prob_doc_tecnica']/node()"/></label>
    	  </th>
    	  <th style="text-align:left;">
			<!--incidencia fuera de plazo-->
			<input class="muypeq" type="checkbox" name="INCFUERAPLAZO_CHECK">
				<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/INCFUERAPLAZO = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>&nbsp;
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='inc_ped_cerrado']/node()"/></label>
    	  </th>
    	  <th>&nbsp;</th>
    	</tr>

    	<tr id="buscadorAvanzadoThree" class="selectAva buscadorAvanzado" height="40">
    	  <!--<xsl:attribute name="style"><xsl:value-of select="$BuscAvanzStyle"/></xsl:attribute>-->
		  <th>&nbsp;</th>
    	  <th style="text-align:left;">
			<!--pedido no informado en la plataforma mvm-->
			<input class="muypeq" type="checkbox" name="PED_URGENTE_CHECK">
				<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/URGENTE = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>&nbsp;
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='urgente']/node()"/></label>
    	  </th>
    	  <th style="text-align:left;">
			<!--bloqueado check-->
			<input class="muypeq" type="checkbox" name="BLOQUEADO_CHECK">
				<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BLOQUEADO = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>&nbsp;
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='bloqueados']/node()"/></label>
    	  </th>
    	  <th style="text-align:left;">
			<!--material check-->
			<input class="muypeq" type="checkbox" name="NOCUMPLEPEDMIN_CHECK">
				<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/NOCUMPLEPEDMIN = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>&nbsp;
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='no_cumple_ped_min']/node()"/></label>
    	  </th>
    	  <th style="text-align:left;">
			<!--sin stock check-->
			<input class="muypeq" type="checkbox" name="SINSTOCKS_CHECK">
				<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/SINSTOCKS = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>&nbsp;
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='sin_stock']/node()"/></label>
			</th>
    	  <th style="text-align:left;">
			<!--proveedor no atiende bien-->
			<input class="muypeq" type="checkbox" name="PED_MALAATENCIONPROV_CHECK">
				<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MALAATENCIONPROV = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>&nbsp;
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='mala_atencion_prov']/node()"/></label>
    	  </th>
    	  <th style="text-align:left;">
			<!--proveedor no atiende bien-->
			<input class="muypeq" type="checkbox" name="BUSCAR_PACKS_CHECK">
				<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BUSCAR_PACKS = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>&nbsp;
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='busca_packs']/node()"/></label>
    	  </th>
    	  <th>&nbsp;</th>
    	</tr>
		</table>
    </td>
    </tr>
	</table>
</xsl:template>
<!--fin de buscador admin tabla pedidos comprador-->

<!--	buscador para proveedor en tabla pedidos-->
<xsl:template name="buscadorInicioProv">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="//LANG"><xsl:value-of select="//LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<table cellspacing="6px" cellpadding="6px">
		<xsl:variable name="BuscAvanzStyle">
			<xsl:choose>
			<xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/URGENTE = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/BLOQUEADO = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FARMACIA = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/MATERIALSANITARIO = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/SINSTOCKS = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/TODOS12MESES = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/INCFUERAPLAZO = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/PEDIDOOK = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/ENTR_RETRASADO = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/PEDIDONOCOINCIDE = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/ENTR_PARCIAL = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/RETRASODOCUMTEC = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/NOINFORMADOPLAT = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/PROD_ANYADIDOS = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/PROD_RETIRADOS = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/MALAATENCIONPROV = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FECHAINICIO != '' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FECHAFINAL != ''"></xsl:when>
			<xsl:otherwise>display:none;</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<tr>
			<!--	10ene22	Area Geografica		-->
			<th class="w50px">&nbsp;</th>
			<xsl:choose>
			<xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FILTROS/FIDAREAGEOGRAFICA/field">
				<th class="textLeft w170px">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Area_geografica']/node()"/></label><br />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FILTROS/FIDAREAGEOGRAFICA/field"/>
					<xsl:with-param name="claSel">w170px</xsl:with-param>
				</xsl:call-template>
				</th>
			</xsl:when>
			<xsl:otherwise>
				<input type="hidden" name="FIDAREAGEOGRAFICA" value="-1"/>
			</xsl:otherwise>
			</xsl:choose>

			<xsl:choose>
			<xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FILTROS/IDEMPRESA/field">
				<th class="textLeft w200px">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:</label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FILTROS/IDEMPRESA/field"/>
						<xsl:with-param name="claSel">w200px</xsl:with-param>
					</xsl:call-template>
				</th>
			</xsl:when>
			<xsl:otherwise>
				<input type="hidden" name="IDEMPRESA" value="-1" />
			</xsl:otherwise>
			</xsl:choose>

			<!--
			21dic21 Desactivamos filtro motivo
			<th width="160px"  style="text-align:left;">
				<label>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='motivo']/node()"/>:</label><br />
				&nbsp;<xsl:call-template name="desplegable"><xsl:with-param name="path" select="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FILTROS/IDFILTROMOTIVO/field"/></xsl:call-template>&nbsp;
			</th>
			-->
			<input type="hidden" name="IDFILTROMOTIVO" value=""/>
			<xsl:choose>
			<xsl:when test="/WorkFlowPendientes/INICIO/IDPAIS=55">
				<!--	10ene22 Para brasil, campo grande para buscar por nif, nombre, etc	-->
				<th class="textLeft w300px">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>/<xsl:value-of select="document($doc)/translation/texts/item[@name='nif']/node()"/></label><br />
					<input type="text" name="FTEXTO" class="campopesquisa w300px">
						<xsl:attribute name="value"><xsl:value-of select="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FILTROS/FTEXTOCLIENTE"/></xsl:attribute>
					</input>
				</th>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
				<xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FILTROS/IDCENTRO/field">
					<th class="textLeft w200px">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</label><br />
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FILTROS/IDCENTRO/field"/>
							<xsl:with-param name="claSel">w200px</xsl:with-param>
						</xsl:call-template>
					</th>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="IDCENTRO" value="-1" />
				</xsl:otherwise>
				</xsl:choose>
				<th class="w160px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/>:</label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FILTROS/IDFILTRORESPONSABLE/field"/>
						<xsl:with-param name="claSel">w160px</xsl:with-param>
					</xsl:call-template>
				</th>
				<th class="w100px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:</label><br />
					<input class="campopesquisa w100px" type="text" name="PRODUCTO" maxlength="20" value="{/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/PRODUCTO}"/>
				</th>
			</xsl:otherwise>
			</xsl:choose>
			<th class="w100px textLeft">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='numero_pedido']/node()"/>:</label><br />
				<input class="campopesquisa w100px" type="text" name="CODIGOPEDIDO" maxlength="100" value="{/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/CODIGOPEDIDO}"/>
			</th>
			<th class="w160px textLeft">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='situacion']/node()"/>:</label><br />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FILTROS/IDFILTROSEMAFORO/field"/>
					<xsl:with-param name="claSel">w160px</xsl:with-param>
				</xsl:call-template>
			</th>
			<th class="w160px textLeft">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='vendedor']/node()"/>:</label><br />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FILTROS/IDFILTROVENDEDOR/field"/>
					<xsl:with-param name="claSel">w160px</xsl:with-param>
				</xsl:call-template>
			</th>
			<!--	Nuevo filtro de periodo		-->
			<th class="w100px textLeft">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo']/node()"/></label><br />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FILTROS/FPLAZO/field"/>
					<xsl:with-param name="claSel">w100px</xsl:with-param>
				</xsl:call-template>
			</th>
			<input type="hidden" name="LINEA_POR_PAGINA" id="LINEA_POR_PAGINA" value="100"/>
			<th class="w70px textLeft">
				<br/>
				<a href="javascript:FiltrarBusqueda();" title="Buscar" class="btnDestacado">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
				</a>&nbsp;
			</th>
			<th>&nbsp;</th>
	    </tr>
	</table>
</xsl:template>
<!-- Fin buscador inicio proveedor	-->


<xsl:template match="MO_ID">
</xsl:template>

<xsl:template match="EMPRESA2">
	<a>
    <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame2022.xsql?EMP_ID=<xsl:value-of select="../EMP_ID2"/>&amp;VENTANA=NUEVA','Empresa',100,80,0,-20)</xsl:attribute>
		<xsl:attribute name="onMouseOver">window.status='Informaci? sobre la empresa.';return true;</xsl:attribute>
		<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
		<xsl:attribute name="class">
 			<xsl:if test="../IDINCIDENCIA!=''">alerta</xsl:if>
  		</xsl:attribute>
		<xsl:value-of select="."/>
	</a>
</xsl:template>

<xsl:template match="CENTRO">
	<a>
    <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID=<xsl:value-of select="../CEN_ID"/>&amp;VENTANA=NUEVA','Centro',100,80,0,-20,,window.parent.frames[0].document.styleSheets[0].href)</xsl:attribute>
		<xsl:attribute name="onMouseOver">window.status='Informaci? sobre el centro.';return true;</xsl:attribute>
		<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
		<xsl:attribute name="class">
 			<xsl:if test="../IDINCIDENCIA!=''">alerta</xsl:if>
  	</xsl:attribute>
		<xsl:value-of select="."/>
	</a>
</xsl:template>

<xsl:template match="CENTRO2">
	<a>
		<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID=<xsl:value-of select="../CEN_ID2"/>&amp;VENTANA=NUEVA','Centro',100,80,0,-20,window.parent.frames[0].document.styleSheets[0].href)</xsl:attribute>
		<xsl:attribute name="onMouseOver">window.status='Informaci? sobre el centro.';return true;</xsl:attribute>
		<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
		<xsl:attribute name="class">
 			<xsl:if test="../IDINCIDENCIA!=''">alerta</xsl:if>
  	</xsl:attribute>
		<xsl:value-of select="."/>
	</a>
</xsl:template>

<xsl:template match="PRODUCTO">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="MO_USUARIO">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="LP_NOMBRE">
  <xsl:value-of select="."/>
</xsl:template>

<xsl:template match="FECHA_ENTRADA">
  <xsl:value-of select="."/>
</xsl:template>

<xsl:template match="Sorry">
  <p class="tituloCamp"><font color="#EEFFFF">
    <xsl:value-of select="document($doc)/translation/texts/item[@name='no_elementos_pendientes']/node()"/>
	</font></p>
</xsl:template>

<xsl:template match="SEMAFORO">
	<xsl:choose>
	<xsl:when test=".='VERDE'">
		&nbsp;<img src="http://www.newco.dev.br/images/SemaforoVerde.gif"/>&nbsp;
	</xsl:when>
	<xsl:when test=".='ROJO'">
		&nbsp;<img src="http://www.newco.dev.br/images/SemaforoRojo.gif"/>&nbsp;
	</xsl:when>
	<xsl:when test=".='AMBAR'">
		&nbsp;<img src="http://www.newco.dev.br/images/SemaforoAmbar.gif"/>&nbsp;
	</xsl:when>
	</xsl:choose>
</xsl:template>



<!--documentos-->
<xsl:template name="albaran">
    <xsl:param name="idmultioferta" />
    <xsl:param name="type" />
    <xsl:param name="id" />
    <xsl:param name="name" />
    <xsl:param name="url" />

     <!--idioma-->
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="//WorkFlowPendientes/LANG"><xsl:value-of select="//WorkFlowPendientes/LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->

		<input id="inputFileDoc_{$idmultioferta}" name="inputFileDoc_{$idmultioferta}" type="file" onChange="javascript:cargaDocPed('ALBARAN', 'Form1', {$idmultioferta});">
			<xsl:attribute name="style">
         		<xsl:choose>
          		<xsl:when test="$id!=''">width:250px;display:none;</xsl:when>
            	<xsl:otherwise>width:250px;</xsl:otherwise>
            	</xsl:choose>
			</xsl:attribute>
		</input>
        <xsl:choose>
        <xsl:when test="$id!=''">
			<span id="docBox_{$idmultioferta}" align="center">&nbsp;<a href="http://www.newco.dev.br/Documentos/{$url}"><xsl:value-of select="$name"/></a><a href="javascript:borrarDoc('ALBARAN',{$id}, {$idmultioferta});"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></span>&nbsp;
		</xsl:when>
        <xsl:otherwise>
			<span id="docBox_{$idmultioferta}" style="display:none;" align="center"></span>&nbsp;
        </xsl:otherwise>
        </xsl:choose>
		<div id="waitBoxDoc_{$idmultioferta}" align="center" style="display:none;"><img src="http://www.newco.dev.br/images/loading.gif"/></div>
</xsl:template>
<!--fin de documentos-->


<!--30may22 Devuelve el texto de ayuda correspondiente a la situacion-->
<xsl:template match="SITUACION">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/WorkFlowPendientes/LANG"><xsl:value-of select="/WorkFlowPendientes/LANG"/></xsl:when> 
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<xsl:choose>
	<xsl:when test=".='0'">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='Situacion0']/node()"/>
	</xsl:when>
	<xsl:when test=".='1'">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='Situacion1']/node()"/>
	</xsl:when>
	<xsl:when test=".='2'">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='Situacion2']/node()"/>
	</xsl:when>
	<xsl:when test=".='3'">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='Situacion3']/node()"/>
	</xsl:when>
	</xsl:choose>
</xsl:template>


</xsl:stylesheet>
