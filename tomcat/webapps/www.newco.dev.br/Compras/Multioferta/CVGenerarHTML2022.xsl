<?xml version="1.0" encoding="iso-8859-1"?>
<!--	
	Segundo paso de la creación del pedido: condiciones particulares. Nuevo disenno 2022
	Ultima revision: ET 17may23 11:00 CVGenerar2022_170523.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>

	<!--idioma-->
	<xsl:variable name="lang"><xsl:value-of select="/Generar/LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:variable name="preparar">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente_de_confirmacion']/node()"/>
	</xsl:variable>

<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>

<xsl:template match="/Generar">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>
  
<html>
<head>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->
	
	<title><xsl:value-of select="MULTIOFERTAS/TIPODOCUMENTO"/><xsl:text>&nbsp;a&nbsp;</xsl:text><xsl:value-of select="MULTIOFERTAS/MULTIOFERTAS_ROW/CENTROPROVEEDOR"/></title>

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Compras/Multioferta/CVGenerar2022_170523.js"></script>
	<script type="text/javascript">

		//	Revision: 28dic20 15:25
		var IDLPa	= '<xsl:value-of select="/Generar/MULTIOFERTAS/LP_ID"/>';
		var IDMultioferta	= '<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW[1]/MO_ID"/>';
		var isCdC			= '<xsl:choose><xsl:when test="/Generar/MULTIOFERTAS/CENTRALCOMPRAS">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		var IDEmpresa		= '<xsl:value-of select="/Generar/MULTIOFERTAS/IDCLIENTE"/>';
		var IDCentro		= '<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW[1]/MO_IDCENTROCLIENTE"/>';
		var IDUsuario		= '<xsl:value-of select="/Generar/MULTIOFERTAS/IDUSUARIO"/>';
		var IDLugarEntrega		= '<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW[1]/MO_IDLUGARENTREGA"/>';
		var IDCentroConsumo		= '<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW[1]/MO_IDCENTROCONSUMO"/>';
		var PlazoEntregaInicial	= '<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW[1]/MO_PLAZOENTREGA"/>';
		var NumMultiofertas		= '<xsl:value-of select="/Generar/MULTIOFERTAS/NUMERO_MULTIOFERTAS"/>';
		var reqDatosPaciente	= '<xsl:choose><xsl:when test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/REQUIERE_DATOS_PACIENTE">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		var clausulasLegales	= '<xsl:choose><xsl:when test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/CLAUSULAS_LEGALES/CLAUSULA">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';

		console.log('clausulasLegales:'+clausulasLegales);

		var costeTransporte=parseFloat(desformateaDivisa('<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW[1]/MO_COSTELOGISTICA"/>'));
		var IvaCoste=parseFloat(desformateaDivisa('<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW[1]/MO_COSTELOGISTICA_IVA"/>'));
		
/*
		var ComentarioPorDefecto	= '<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW[1]/COMENTARIOPORDEFECTO/COMENTARIO"/>';
*/		
		
		var ComentarioPorDefecto	= '<xsl:copy-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW[1]/COMENTARIOPORDEFECTO/COMENTARIO_JS"/>';
		var sepComentario='';
		var ComentarioDeParametros='';
		
		var Param1	= '<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW[1]/PARAMETRO1"/>';
		var Param2	= '<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW[1]/PARAMETRO2"/>';
		var Param3	= '<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW[1]/PARAMETRO3"/>';
		var Param4	= '<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW[1]/PARAMETRO4"/>';
		
		console.log('Parametros:'+Param1+','+Param2+','+Param3+','+Param4);
		
		
		var conMotivoPorOrdenNo1 = '<xsl:choose><xsl:when test="MULTIOFERTAS/MOTIVOORDENNO1">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		var historia=0;

		var msgFechaMinimaIncorrecta			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgFechaMinimaIncorrecta']/node()"/>';
		var msgProgramacionPedidosEstrictos		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgProgramacionPedidosEstrictos']/node()"/>';
		var msgProgramacionPedidosFexiblesInferior	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgProgramacionPedidosFexiblesInferior']/node()"/>';
		var msgProgramacionAbonos			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgProgramacionAbonos']/node()"/>';
		var msgAvisoProgramacion			= '';

		//	Mensajes para ofertas
		var msgSinOferta			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgSinOferta']/node()"/>';
		var msgSinOfertasRedireccion		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgSinOfertasRedireccion']/node()"/>';
		var msgProveedorSoloPedidos_C1_Semaforo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgProveedorSoloPedidos_C1_Semaforo']/node()"/>';
		var msgProveedorSoloPedidos_C2_Semaforo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgProveedorSoloPedidos_C2_Semaforo']/node()"/>';
		var msgOfertaMinimoEstricto_C1_Semaforo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgOfertaMinimoEstricto_C2_Semaforo']/node()"/>';
		var msgOfertaMinimoEstricto_C2_Semaforo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgOfertaMinimoEstricto_C1_Semaforo']/node()"/>';
		var msgOfertaMinimoEstricto_C3_Semaforo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgOfertaMinimoEstricto_C3_Semaforo']/node()"/>';
		var msgOfertaMinimoEstricto_C3_ComprobacionFinal_excluir= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgOfertaMinimoEstricto_C3_ComprobacionFinal_excluir']/node()"/>';
		var msgOfertaMinimoEstricto_C4_ComprobacionFinal	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgOfertaMinimoEstricto_C4_ComprobacionFinal']/node()"/>';
		var msgOfertaMinimoEstricto_C4_ComprobacionFinal_excluir= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgOfertaMinimoEstricto_C4_ComprobacionFinal_excluir']/node()"/>';
		var msgOfertaMinimoFlexible_C1_Semaforo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgOfertaMinimoFlexible_C1_Semaforo']/node()"/>';
		var msgOfertaMinimoFlexible_C2_Semaforo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgOfertaMinimoFlexible_C2_Semaforo']/node()"/>';
		var msgOfertaMinimoFlexible_C3_Semaforo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgOfertaMinimoFlexible_C3_Semaforo']/node()"/>';
		var msgOfertaMinimoFlexible_C3_ComprobacionFinal	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgOfertaMinimoFlexible_C3_ComprobacionFinal']/node()"/>';
		var msgOfertaMinimoFlexible_C4_ComprobacionFinal	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgOfertaMinimoFlexible_C4_ComprobacionFinal']/node()"/>';
		var msgCambioEstadoOferta_ENVIAR_Semaforo		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgCambioEstadoOferta_ENVIAR_Semaforo']/node()"/>';
		var msgCambioEstadoOferta_NOENVIAR_Semaforo		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgCambioEstadoOferta_NOENVIAR_Semaforo']/node()"/>';
		var msgComentariosObligatoriosParaUrgencias		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgComentariosObligatoriosParaUrgencias']/node()"/>';
		var msgSinClausulasMarcadas		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgSinClausulasMarcadas']/node()"/>';

		//	Mensajes para pedidos
		var msgSinPedido			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgSinPedido']/node()"/>';
		var msgSinPedidosRedireccion		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgSinPedidosRedireccion']/node()"/>';
		var msgPrograma_C3_Semaforo		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgPrograma_C3_Semaforo']/node()"/>';
		var msgPedidoMinimoEstricto_C1_Semaforo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgPedidoMinimoEstricto_C1_Semaforo']/node()"/>';
		var msgPedidoMinimoEstricto_C2_Semaforo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgPedidoMinimoEstricto_C2_Semaforo']/node()"/>';
		var msgPedidoMinimoEstricto_C3_Semaforo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgPedidoMinimoEstricto_C3_Semaforo']/node()"/>';
		var msgPedidoMinimoEstricto_C3_ComprobacionFinal_excluir= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgPedidoMinimoEstricto_C3_ComprobacionFinal_excluir']/node()"/>';
		var msgPedidoMinimoEstricto_C4_ComprobacionFinal	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgPedidoMinimoEstricto_C4_ComprobacionFinal']/node()"/>';
		var msgPedidoMinimoEstricto_C4_ComprobacionFinal_excluir= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgPedidoMinimoEstricto_C4_ComprobacionFinal_excluir']/node()"/>';
		var msgPedidoMinimoFlexible_C1_Semaforo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgPedidoMinimoFlexible_C1_Semaforo']/node()"/>';
		var msgPedidoMinimoFlexible_C2_Semaforo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgPedidoMinimoFlexible_C2_Semaforo']/node()"/>';
		var msgPedidoMinimoFlexible_C3_Semaforo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgPedidoMinimoFlexible_C3_Semaforo']/node()"/>';
		var msgPedidoMinimoFlexible_C3_ComprobacionFinal	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgPedidoMinimoFlexible_C3_ComprobacionFinal']/node()"/>';
		var msgPedidoMinimoFlexible_C4_ComprobacionFinal	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgPedidoMinimoFlexible_C4_ComprobacionFinal']/node()"/>';
		var msgCambioEstadoPedido_ENVIAR_Semaforo		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgCambioEstadoPedido_ENVIAR_Semaforo']/node()"/>';
		var msgCambioEstadoPedido_NOENVIAR_Semaforo		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgCambioEstadoPedido_NOENVIAR_Semaforo']/node()"/>';

		var msgPedidosUrgentasProgramacion	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgPedidosUrgentasProgramacion']/node()"/>';
		var msgNumeroPedidoClinicaParaPrograma	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgNumeroPedidoClinicaParaPrograma']/node()"/>';
		var msgCampoNoInformado	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgCampoNoInformado']/node()"/>';

		var msgDatosPacienteObligatorios	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgDatosPacienteObligatorios']/node()"/>';
		var msgDocumentoCirugiaObligatorio	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgDocumentoCirugiaObligatorio']/node()"/>';
		var msgFaltaMotivo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_motivo_orden_no1']/node()"/>';

		var suPedidoEs		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='su_pedido_es_de']/node()"/>';
		var ivaNoIncluida	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='iva_no_incluida_inferior']/node()"/>';

		var msgMinimoFlexible_C1_Semaforo	= msgPedidoMinimoFlexible_C1_Semaforo;
		var msgMinimoFlexible_C2_Semaforo	= msgPedidoMinimoFlexible_C2_Semaforo;
		var msgMinimoFlexible_C3_Semaforo	= msgPedidoMinimoFlexible_C3_Semaforo;
		var msgMinimoFlexible_C3_ComprobacionFinal=msgPedidoMinimoFlexible_C3_ComprobacionFinal;
		var msgMinimoFlexible_C4_ComprobacionFinal=msgPedidoMinimoFlexible_C4_ComprobacionFinal;
		var msgMinimoEstricto_C1_Semaforo=msgPedidoMinimoEstricto_C1_Semaforo;
		var msgMinimoEstricto_C2_Semaforo=msgPedidoMinimoEstricto_C2_Semaforo;
		var msgMinimoEstricto_C3_Semaforo=msgPedidoMinimoEstricto_C3_Semaforo;
		var msgMinimoEstricto_C3_ComprobacionFinal_excluir=msgPedidoMinimoEstricto_C3_ComprobacionFinal_excluir;
		var msgMinimoEstricto_C4_ComprobacionFinal=msgPedidoMinimoEstricto_C4_ComprobacionFinal;
		var msgMinimoEstricto_C4_ComprobacionFinal_excluir=msgPedidoMinimoEstricto_C4_ComprobacionFinal_excluir;
		var msgCambioEstadoElemento_ENVIAR_Semaforo=msgCambioEstadoPedido_ENVIAR_Semaforo;
		var msgCambioEstadoElemento_NOENVIAR_Semaforo=msgCambioEstadoPedido_NOENVIAR_Semaforo;
		var msgSinElemento=msgSinPedido;
		var msgSinElementosRedireccion=msgSinPedidosRedireccion;

	<xsl:choose>
	<xsl:when test="MULTIOFERTAS/NUMERO_MULTIOFERTAS>1">
		msgAvisoProgramacion+='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgAvisoProgramacion1']/node()"/> <xsl:value-of select="//MULTIOFERTAS/NUMERO_MULTIOFERTAS"/> <xsl:value-of select="document($doc)/translation/texts/item[@name='msgAvisoProgramacion2']/node()"/>';
	</xsl:when>
	<xsl:otherwise>
		msgAvisoProgramacion+='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgAvisoProgramacion']/node()"/>';
	</xsl:otherwise>
	</xsl:choose>

	var fechaEntregaMinima;
	var arrayCentros	= new Array();
	var arrayLugaresEntrega	= new Array();
	var arrayCentrosConsumo	= new Array();

	<xsl:for-each select="MULTIOFERTAS/TODOSLUGARESENTREGA[1]/CENTRO">
		arrayCentros[arrayCentros.length]	= new Array(
			<xsl:value-of select="@ID"/>,
			'<xsl:value-of select="@nombre"/>',
			'<xsl:value-of select="PEDIDO_MINIMO/IMPORTE"/>',
			'<xsl:value-of select="COSTE_TRANSPORTE/IMPORTE"/>'
		);

		<xsl:for-each select="LUGARESENTREGA/LUGARENTREGA">
			arrayLugaresEntrega[arrayLugaresEntrega.length]	= new Array(
				<xsl:value-of select="ID"/>,
				<xsl:value-of select="IDCENTRO"/>,
				'<xsl:value-of select="REFERENCIA"/>',
				'<xsl:value-of select="NOMBRE"/>',
				'<xsl:value-of select="DIRECCION"/>',
				'<xsl:value-of select="CPOSTAL"/>',
				'<xsl:value-of select="POBLACION"/>',
				'<xsl:value-of select="PROVINCIA"/>',
				'<xsl:value-of select="PORDEFECTO"/>'
			);
		</xsl:for-each>
	</xsl:for-each>
	
	<xsl:for-each select="MULTIOFERTAS/TODOSCENTROSCONSUMO[1]/CENTRO">
		<xsl:for-each select="CENTROSCONSUMO/CENTROCONSUMO">
			arrayCentrosConsumo[arrayCentrosConsumo.length]	= new Array(
				<xsl:value-of select="ID"/>,
				<xsl:value-of select="IDCENTRO"/>,
				'<xsl:value-of select="REFERENCIA"/>',
				'<xsl:value-of select="NOMBRE_CORTO"/>',
				'<xsl:value-of select="PORDEFECTO"/>'
			);
		</xsl:for-each>
	</xsl:for-each>

	var arrTiposPedidos	= new Array();
	<xsl:for-each select="MULTIOFERTAS/TIPOS_PEDIDOS/TIPO">
		var TipoPedido		= [];
		TipoPedido['ID']= '<xsl:value-of select="PED_TIP_ID"/>';
		TipoPedido['Nombre']	= '<xsl:value-of select="PED_TIP_NOMBRE"/>';
		TipoPedido['Titulos']	= [];
		<xsl:if test="TITULOS_TIPOS_PEDIDOS/TITULO">
			<xsl:for-each select="TITULOS_TIPOS_PEDIDOS/TITULO">
				var Titulo	= [];
				Titulo['ID']= '<xsl:value-of select="PED_TIT_ID"/>';
				Titulo['Nombre']	= '<xsl:value-of select="PED_TIT_NOMBRE"/>';
				Titulo['Actual']	= '';
				Titulo['Valores']	= [];
				<xsl:if test="VALORES_TIPOS_PEDIDOS/VALOR">
					<xsl:for-each select="VALORES_TIPOS_PEDIDOS/VALOR">
						var Valor	= [];
						Valor['ID']= '<xsl:value-of select="PED_TIV_ID"/>';
						Valor['Nombre']	= '<xsl:value-of select="PED_TIV_NOMBRE"/>';
						Titulo['Valores'].push(Valor);
					</xsl:for-each>
				</xsl:if>
				TipoPedido['Titulos'].push(Titulo);
			</xsl:for-each>
		</xsl:if>
		arrTiposPedidos.push(TipoPedido);
	</xsl:for-each>

	</script>        
</head>

<!--<body class="gris">-->
<body>
	<xsl:choose><!-- error -->
	<xsl:when test="//xsql-error">
		<xsl:apply-templates select="//xsql-error"/>
	</xsl:when>
	<xsl:when test="//SESION_CADUCADA">
		<xsl:apply-templates select="//SESION_CADUCADA"/>
	</xsl:when>
	<xsl:otherwise>
	<a name="inicio"/>
	<!--
	<div id="spiffycalendar" class="text"></div>
	<script type="text/javascript">
		var calFechaEntrega = new ctlSpiffyCalendarBox("calFechaEntrega", "Principal", "FECHA_ENTREGA","btnDateFechaEntrega",'<xsl:value-of select="/Generar/FECHA_ENTREGA"/>',scBTNMODE_CLASSIC,'ONCHANGE|actualizarPlazo(document.forms[\'Principal\'],\'ENTREGA\',new Date());#CHANGEDAY|actualizarPlazo(document.forms[\'Principal\'],\'ENTREGA\',new Date());');
	</script>
	-->
	<form name="PedidoMinimo">

	<xsl:for-each select="MULTIOFERTAS/MULTIOFERTAS_ROW">
		<input type="hidden" name="Total_{MO_ID}" value="{MO_IMPORTETOTAL_SINFORM}"/>
		<input type="hidden" name="Minimo_{MO_ID}" value="{EMP_PEDMINIMO_IMPORTE_SINFORM}"/>
		<input type="hidden" name="Estricto_{MO_ID}" value="{EMP_PEDMINIMO_ACTIVO}"/>
		<input type="hidden" name="Status_{MO_ID}" value="void"/>
		<input type="hidden" name="PED_PROGRAMABLE_{MO_ID}"/>
		<input type="hidden" name="Nombre_{MO_ID}" value="{PROVEEDOR}"/>
		<input type="hidden" name="Divisa_{MO_ID}" value="{EMP_PEDMINIMO_DIVISA}"/>
	</xsl:for-each>
	</form>

	<form name="Principal" method="POST">
		<input type="hidden" name="MO_ID" value="{MULTIOFERTAS/MULTIOFERTAS_ROW/MO_ID}"/>
		<input type="hidden" name="ENVIAR_OFERTAS"/> <!-- String con las ofertas que hay que mandar y las que no -->
		<input type="hidden" name="COMENTARIOS_PROVEEDORES"/> <!-- String para los comentarios de los proveedores -->
		<input type="hidden" name="LP_ID" value="{/Generar/MULTIOFERTAS/LP_ID}"/>
		<input type="hidden" name="BOTON"/>
		<input type="hidden" name="MO_IDPROGRAMAR"/>
		<input type="hidden" name="ESTADOPROGRAMAR"/>
		<input type="hidden" name="COSTE_LOGISTICA"/>
		<input type="hidden" name="COSTE_LOGISTICA_IVA"/>
		<input type="hidden" name="LISTAMOTIVOS" id="LISTAMOTIVOS"/>

	<xsl:choose>
	<xsl:when test="//xsql-error">
		<xsl:apply-templates select="//xsql-error"/>
	</xsl:when>
	<xsl:when test="//Status">
		<xsl:apply-templates select="//Status"/>
	</xsl:when>
	<xsl:otherwise>
		<div class="divleft">
			<!--	Titulo de la página		-->
			<div class="ZonaTituloPagina">
				<p class="TituloPagina">
					<xsl:value-of select="MULTIOFERTAS/TIPODOCUMENTO"/><xsl:text>&nbsp;a&nbsp;</xsl:text>
                   	<xsl:value-of select="MULTIOFERTAS/MULTIOFERTAS_ROW/CENTROPROVEEDOR"/>
					<span class="CompletarTitulo" style="width:500px;">
						<!--	Incluir los botones	-->
						<a class="btnNormal" href="javascript:window.print();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
						</a>&nbsp;
						<xsl:if test="MULTIOFERTAS/NUMERO_MULTIOFERTAS=1 and not(MULTIOFERTAS/MINIMALISTA)">
							<a class="btnDestacado" >
								<xsl:attribute name="href">javascript:ProgramarPedido(document.forms['Principal'],'CVGenerarSave2022.xsql',document.forms['PedidoMinimo'],'<xsl:value-of select="MULTIOFERTAS/MULTIOFERTAS_ROW[1]/MO_ID"/>','PED_PROGRAMABLE_<xsl:value-of select="MULTIOFERTAS/MULTIOFERTAS_ROW[1]/MO_ID"/>');</xsl:attribute>
								<xsl:value-of select="document($doc)/translation/texts/item[@name='programar']/node()"/>
							</a>&nbsp;
						</xsl:if>
						<a class="btnDestacado" id="botonEnviarPedido" href="javascript:EnviarPedidos(document.forms['Principal'],'CVGenerarSave2022.xsql',document.forms['PedidoMinimo']);">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/>
						</a>
					</span>
				</p>
			</div>
			<br/>
			<table class="buscador">
				<tr class="sinLinea">
					<td class="veinte labelRight">
					<xsl:choose>
					<xsl:when test="MULTIOFERTAS/CENTRALCOMPRAS">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_entrega']/node()"/>:&nbsp;
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='entregar_en']/node()"/>:&nbsp;
					</xsl:otherwise>
					</xsl:choose>
					</td>

					<td class="treinta">
						<p class="textleft">
							<xsl:choose>
							<xsl:when test="MULTIOFERTAS/CENTRALCOMPRAS">
								<select name="IDCENTRO" class="w400px" onChange="inicializarDesplegableCentros(this.value);"/>
							</xsl:when>
							<xsl:otherwise>
								<input type="hidden" name="IDCENTRO" value="{/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW[1]/MO_IDCENTROCLIENTE}"/>
							</xsl:otherwise>
							</xsl:choose>
							<select name="IDLUGARENTREGA" onChange="ActualizarTextoLugarEntrega(this.value);"/>
						</p>
					</td>

					<td class="labelRight treinta">
					<xsl:if test="MULTIOFERTAS/MOSTRARCENTROSCONSUMO">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_consumo']/node()"/>:&nbsp;
					</xsl:if>
					</td>

					<td colspan="3">
						<p class="textleft">
							<select name="IDCENTROCONSUMO">
								<xsl:attribute name="style">
									<xsl:choose>
									<xsl:when test="MULTIOFERTAS/MOSTRARCENTROSCONSUMO">display:;</xsl:when>
									<xsl:otherwise>display:none;</xsl:otherwise>
									</xsl:choose>
								</xsl:attribute>
							</select>
						</p>
					</td>
				</tr>

				<tr class="sinLinea">
					<td class="labelRight">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='entregar_en']/node()"/>:
					</td>

					<td>
						<xsl:call-template name="direccion"><xsl:with-param name="path" select="MULTIOFERTAS/MULTIOFERTAS_ROW[1]/CENTRO"/></xsl:call-template>
					</td>

					<td class="textLeft">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='entrega']/node()"/></label>:&nbsp;<strong><xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW[1]/MO_FECHAENTREGA"/></strong>
					</td>

					<td>&nbsp;
						<input type="hidden" name="sum"/>
					</td>
				</tr>

				<!--<input type="hidden" name="IDFORMAPAGO" value="0"/>-->
				<input type="hidden" name="FECHA_PAGO" value="{FECHA_PAGO}"/>
			</table>
		</div><!--fin divLeft gris-->

		<!--	2jun10	-->
		<xsl:variable name="OcultarPrecioReferencia">
			<xsl:choose>
			<xsl:when test="MULTIOFERTAS/OCULTAR_PRECIO_REFERENCIA">S</xsl:when><!-- cuidado con no dejar espacios! -->
			<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<div class="divLeft" style="border-bottom:2px solid silver;">&nbsp;</div>
		<div class="divleft">
			<xsl:apply-templates select="MULTIOFERTAS">
				<xsl:with-param name="OcultarPrecioReferencia" select="$OcultarPrecioReferencia"/>
			</xsl:apply-templates>
		</div>
		<br/>
		<br/>
		<xsl:if test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/CLAUSULAS_LEGALES/CLAUSULA">
			<table width="100%">
			<xsl:for-each select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/CLAUSULAS_LEGALES/CLAUSULA">
				<tr>
				<td width="100px">&nbsp;</td>
				<td width="20px"><input type="checkbox" class="muypeq" name="claus_{ID}" id="claus_{ID}"><xsl:if test="POR_DEFECTO='S'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if></input></td>
				<td><xsl:value-of select="CODIGO"/></td>
				<td><xsl:value-of select="COMENTARIO"/></td>
				<td>&nbsp;</td>
				</tr>
			</xsl:for-each>
			</table>
		</xsl:if>
	</xsl:otherwise>
	</xsl:choose>
	</form>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>

<xsl:template match="MULTIOFERTAS">
	<xsl:param name="OcultarPrecioReferencia"/>

	<!--idioma- - >
	<xsl:variable name="lang"><xsl:value-of select="LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	< ! - - idioma fin-->

	<xsl:variable name="nuevoModeloNegocio">
	<xsl:choose>
	<xsl:when test="MOSTRAR_PRECIO_REFERENCIA/@NuevoModeloNegocio != ''">
		<xsl:value-of select="MOSTRAR_PRECIO_REFERENCIA/@NuevoModeloNegocio"/>
	</xsl:when>
	<xsl:when test="OCULTAR_PRECIO_REFERENCIA/@NuevoModeloNegocio != ''">
		<xsl:value-of select="OCULTAR_PRECIO_REFERENCIA/@NuevoModeloNegocio"/>
	</xsl:when>
	</xsl:choose>
	</xsl:variable>

	<xsl:variable name="pedidoAntiguo">
	<xsl:choose>
	<xsl:when test="MOSTRAR_PRECIO_REFERENCIA/@PedidoAntiguo != ''">
		<xsl:value-of select="MOSTRAR_PRECIO_REFERENCIA/@PedidoAntiguo"/>
	</xsl:when>
	<xsl:when test="OCULTAR_PRECIO_REFERENCIA/@PedidoAntiguo != ''">
		<xsl:value-of select="OCULTAR_PRECIO_REFERENCIA/@PedidoAntiguo"/>
	</xsl:when>
	</xsl:choose>
	</xsl:variable>

	<!--nuevo modelo = <xsl:value-of select="$nuevoModeloNegocio"/>+++
	pedido antiguo = <xsl:value-of select="$pedidoAntiguo"/>+++
	ocultar precio ref <xsl:value-of select="$OcultarPrecioReferencia"/>-->

<xsl:for-each select="MULTIOFERTAS_ROW">
	<a name="multioferta_{MO_ID}"/>
	<br/>
	<div class="divLeft textCenter">
	<span class="fuentePeq">
		<xsl:value-of select="$preparar"/>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<xsl:value-of select="document($doc)/translation/texts/item[@name='vendedor']/node()"/>:&nbsp;
		<xsl:choose>
		<xsl:when test="/Generar/MULTIOFERTAS/CAMBIARVENDEDOR">
			<xsl:call-template name="desplegable">
        		<xsl:with-param name="path" select="VENDEDORES/field"/>
        		<xsl:with-param name="nombre">IDVENDEDOR_<xsl:value-of select="MO_ID"/></xsl:with-param>
        		<xsl:with-param name="onChange">javascript:CambioVendedor(<xsl:value-of select="MO_ID"/>);</xsl:with-param>
        		<xsl:with-param name="style">width:300px;</xsl:with-param>
    		</xsl:call-template>&nbsp;			
			<span id="spDatosVendedor_{MO_ID}"  style="display:none;">
				<input type="checkbox" class="muypeq" name="cbTodos"/><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/>&nbsp;
        		<a class="btnDestacadoPeq" id="btnGuardarVendedor" href="javascript:GuardarVendedor({MO_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
    		</span>
    		<img id="imgVendedorOK_{MO_ID}" src="http://www.newco.dev.br/images/check.gif" style="display:none;"/>
			<img id="imgVendedorKO_{MO_ID}" src="http://www.newco.dev.br/images/error.gif" style="display:none;"/>
		</xsl:when>
		<xsl:otherwise>
			<strong><xsl:value-of select="VENDEDOR"/></strong>
		</xsl:otherwise>
		</xsl:choose>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<xsl:value-of select="document($doc)/translation/texts/item[@name='forma_pago']/node()"/>:&nbsp;
		<xsl:choose>
		<xsl:when test="/Generar/MULTIOFERTAS/CAMBIARFORMAPAGO">
			<xsl:call-template name="desplegable">
        		<xsl:with-param name="path" select="FORMASPAGO/field"/>
        		<xsl:with-param name="nombre">IDFORMAPAGO_<xsl:value-of select="MO_ID"/></xsl:with-param>
        		<xsl:with-param name="onChange">javascript:CambioFormaPago(<xsl:value-of select="MO_ID"/>);</xsl:with-param>
    		</xsl:call-template>&nbsp;
			<xsl:call-template name="desplegable">
        		<xsl:with-param name="path" select="PLAZOSPAGO/field"/>
        		<xsl:with-param name="nombre">IDPLAZOPAGO_<xsl:value-of select="MO_ID"/></xsl:with-param>
        		<xsl:with-param name="onChange">javascript:CambioFormaPago(<xsl:value-of select="MO_ID"/>);</xsl:with-param>
        		<xsl:with-param name="style">width:300px;</xsl:with-param>
    		</xsl:call-template>&nbsp;
			<span id="spFormaPago_{MO_ID}"  style="display:none;">
			<!--<input type="checkbox" class="muypeq" name="cbFormaPagoTodos"/><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/>&nbsp;-->
    		<a class="btnDestacadoPeq" id="btnGuardarFormaPago{MO_ID}" href="javascript:GuardarFormaPago({MO_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
    		</span>
			<img id="imgFormaPagoOK_{MO_ID}" src="http://www.newco.dev.br/images/check.gif" style="vertical-align:text-bottom;display:none;"/>
			<img id="imgFormaPagoKO_{MO_ID}" src="http://www.newco.dev.br/images/error.gif" style="vertical-align:text-bottom;display:none;"/>
			</xsl:when>
		<xsl:otherwise>
			<strong><xsl:value-of select="FORMAPAGO"/>.</strong>&nbsp;
			<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_pago']/node()"/>:&nbsp;
			<strong><xsl:value-of select="PLAZOPAGO"/></strong>
		</xsl:otherwise>
		</xsl:choose>
	</span>
	</div>
	<input type="hidden" name="IDFORMAPAGO" value="{CEN_IDFORMAPAGO}"/>
	<input type="hidden" name="IDPLAZOPAGO" value="{CEN_IDPLAZOPAGO}"/>
	<br/>
	<br/>

	<div class="linha_separacao_cotacao_y"></div>
	<div class="tabela tabela_redonda">
		<table cellspacing="10px" cellpadding="10px">
		<thead class="cabecalho_tabela">
		<tr>
			<!-- ref mvm + cod nacional si es farmacia -->
			<th align="left" class="ocho">
			<xsl:choose>
			<xsl:when test="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW[1]/LMO_CATEGORIA = 'F' and /Generar/MULTIOFERTAS/UTILIZAR_REFERENCIA_PROVEEDOR">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_nacional']/node()"/>
			</xsl:when>
			<xsl:otherwise>
				&nbsp;<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>.-->
				<xsl:choose>
				<xsl:when test="/Generar/MULTIOFERTAS/NOMBREREFCLIENTE">
					<xsl:value-of select="/Generar/MULTIOFERTAS/NOMBREREFCLIENTE"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>
				</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
			</xsl:choose>
			</th>

			<!-- producto -->
			<th class="textLeft">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>
			</th>

			<xsl:if test="not(/Generar/MULTIOFERTAS/OCULTAR_REFERENCIA_PROVEEDOR)">
				<!-- ref provee si es normal-->
				<th>
					<xsl:attribute name="class">
					<xsl:choose>
					<xsl:when test="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW[1]/LMO_CATEGORIA = 'F' and not(/Generar/MULTIOFERTAS/UTILIZAR_REFERENCIA_PROVEEDOR)">dies</xsl:when>
					<xsl:when test="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW[1]/LMO_CATEGORIA = 'F'  and /Generar/MULTIOFERTAS/UTILIZAR_REFERENCIA_PROVEEDOR">uno</xsl:when>
					<xsl:when test="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW[1]/LMO_CATEGORIA = 'N'">dies</xsl:when>
					</xsl:choose>
					</xsl:attribute>

				<xsl:choose>
				<!--si es farmacia no veo ref prov, solo si es viamed5 veo ref prov-->
				<xsl:when test="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW[1]/LMO_CATEGORIA = 'F' and not(/Generar/MULTIOFERTAS/UTILIZAR_REFERENCIA_PROVEEDOR)">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>
				</xsl:when>
				<!--si no es viamed5 no veo ref prov-->
				<xsl:when test="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW[1]/LMO_CATEGORIA = 'F'  and /Generar/MULTIOFERTAS/UTILIZAR_REFERENCIA_PROVEEDOR">
				</xsl:when>
				<xsl:when test="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW[1]/LMO_CATEGORIA = 'N'">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>
				</xsl:when>
				</xsl:choose>
				</th>
			</xsl:if>

			<!--marca solo si es farmacia o asisa, para todos 26/06/12 mi-->
			<th>
				<xsl:attribute name="class">
				<xsl:choose>
				<xsl:when test="/Generar/MULTIOFERTAS/SIN_MARCA">uno</xsl:when>
				<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'F'">veinte</xsl:when>
				<xsl:when test="LINEA_ROW/PRODUCTOS/PRODUCTOS_ROW[1]/PRO_CATEGORIA = 'N'">ocho</xsl:when>
				</xsl:choose>
				</xsl:attribute>

			<xsl:choose>
			<xsl:when test="/Generar/MULTIOFERTAS/SIN_MARCA"></xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>
			</xsl:otherwise>
			</xsl:choose>
			</th>

			<!-- ud base -->
			<th class="quince textLeft">
				&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>
			</th>

			<!-- precio ud base -->
			<th class="cuatro">
			<xsl:choose>
			<!--ASISA Y BRASIL VIEJO MODELO PRECIO PROV SIN IVA-->
			<xsl:when test="($nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N' and not(/Generar/MULTIOFERTAS/MOSTRAR_PRECIO_CON_IVA)) or /Generar/MULTIOFERTAS/IDPAIS = '55'">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_s_iva']/node()"/>
			</xsl:when>
			<!--VIAMED NUEVO VIEJO MODELO PERO VEO PRECIO PROV CON IVA-->
			<xsl:when test="$nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N' and /Generar/MULTIOFERTAS/MOSTRAR_PRECIO_CON_IVA">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_c_iva']/node()"/>
			</xsl:when>
			<!--NUEVO MODELO VIEJO PEDIDO - SOLO ALICANTE...PRECIO FINAL-->
			<xsl:when test="$nuevoModeloNegocio = 'S' and $pedidoAntiguo = 'S'">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_final']/node()"/>
			</xsl:when>
			<!--NUEVO MODELO NUEVO PEDIDO - PARA VIAMED VIEJO, VENDRELL...VEO PRECIO FINAL--> 
			<xsl:when test="$nuevoModeloNegocio = 'S' and $pedidoAntiguo = 'N'">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_final_iva']/node()"/>
			</xsl:when>
			</xsl:choose>
			&nbsp;(<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DIVISA/PREFIJO"/><xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DIVISA/SUFIJO"/>)
			</th>

			<!-- cantidad -->
			<th class="cinco">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='unidades']/node()"/>
			</th>

			<!-- importe -->
			<th class="cinco">
			<xsl:choose>
			<!--ASISA Y BRASIL VIEJO MODELO PRECIO PROV SIN IVA-->
			<xsl:when test="($nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N' and not(/Generar/MULTIOFERTAS/MOSTRAR_PRECIO_CON_IVA)) or /Generar/MULTIOFERTAS/IDPAIS = '55'">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='importe_s_iva']/node()"/>
			</xsl:when>
			<!--VIAMED NUEVO VIEJO MODELO PERO VEO PRECIO PROV CON IVA-->
			<xsl:when test="$nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N' and /Generar/MULTIOFERTAS/MOSTRAR_PRECIO_CON_IVA">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='total_c_iva_2line']/node()"/>
			</xsl:when>
			<!--NUEVO MODELO VIEJO PEDIDO - SOLO ALICANTE...PRECIO FINAL-->
			<xsl:when test="$nuevoModeloNegocio = 'S' and $pedidoAntiguo = 'S'">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='total']/node()"/>
			</xsl:when>
			<!--NUEVO MODELO NUEVO PEDIDO - PARA VIAMED VIEJO, VENDRELL...VEO PRECIO FINAL--> 
			<xsl:when test="$nuevoModeloNegocio = 'S' and $pedidoAntiguo = 'N'">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='total']/node()"/>
			</xsl:when>
			</xsl:choose>
			&nbsp;(<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DIVISA/PREFIJO"/><xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DIVISA/SUFIJO"/>)
			</th>
		</tr>
	</thead>

	<tbody class="corpo_tabela">
	<xsl:for-each select="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW">
	<xsl:variable name="usarGrupo">
		<xsl:choose>
		<xsl:when test="/Generar/MULTIOFERTAS/UTILIZAR_GRUPO">S</xsl:when>
		<xsl:otherwise>N</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

		<xsl:choose>
		<xsl:when test="position()=1">
			<tr class="subCategorias">
				<th>&nbsp;</th>
				<!--<th align="left" colspan="11">-->
				<th class="encabezadoBloque" colspan="11">
					<!--<strong>
						<span class="subfamilia">-->
						<xsl:choose>
						<xsl:when test="$usarGrupo = 'S' and GRUPO !=''">
							<xsl:value-of select="SUBFAMILIA"/>&nbsp;>&nbsp;<xsl:value-of select="GRUPO"/>
						</xsl:when>
						<xsl:when test="$usarGrupo = 'N' and SUBFAMILIA !=''">
							<xsl:value-of select="SUBFAMILIA"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="$usarGrupo = 'S'">
								<!--es viamed5 enseño sin grupo-->
								<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_grupo']/node()"/>
							</xsl:if>
							<xsl:if test="$usarGrupo = 'N'">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_subfamilia']/node()"/>
							</xsl:if>
						</xsl:otherwise>
						</xsl:choose>
					<!--	</span>
					</strong>-->
				</th>
			</tr>
		</xsl:when>
		<xsl:otherwise>
			<xsl:choose>
			<xsl:when test="$usarGrupo = 'S' and GRUPO/ancestor::*[1]/ancestor::*[1]/ancestor::*[1]/preceding::*[2]/ancestor::*[1]/GRUPO!=GRUPO">
				<tr class="subCategorias">
					<th>&nbsp;</th>
						<!--<th align="left" colspan="11">-->
						<th class="encabezadoBloque" colspan="11">
						<!--<strong>
							<span class="subfamilia">-->
							<xsl:choose>
							<xsl:when test="GRUPO !=''">
								<xsl:value-of select="SUBFAMILIA"/>&nbsp;>&nbsp;<xsl:value-of select="GRUPO"/>
							</xsl:when>
							<xsl:otherwise>
								<!--es viamed nuevo enseño sin familia-->
								<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_grupo']/node()"/>
							</xsl:otherwise>
							</xsl:choose>
						<!--	</span>
						</strong>-->
					</th>
				</tr>
			</xsl:when>
			<xsl:when test="$usarGrupo = 'N' and CAMBIO_SUBFAMILIA ">
				<tr class="subCategorias">
					<th>&nbsp;</th>
						<!--<th align="left" colspan="11">-->
						<th class="encabezadoBloque" colspan="11">
						<!--<strong>
							<span class="subfamilia">-->
							<xsl:choose>
							<xsl:when test="SUBFAMILIA !=''">
								<xsl:value-of select="SUBFAMILIA"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_subfamilia']/node()"/>
							</xsl:otherwise>
							</xsl:choose>
						<!--	</span>
						</strong>-->
					</th>
				</tr>
			</xsl:when>
			</xsl:choose>
		</xsl:otherwise>
		</xsl:choose>

		<!-- mostramos las lineas template LINEASMULTIOFERTA_ROW-->
		<xsl:apply-templates select=".">
			<xsl:with-param name="OcultarPrecioReferencia" select="$OcultarPrecioReferencia"/>
			<xsl:with-param name="nuevoModeloNegocio" select="$nuevoModeloNegocio"/>
			<xsl:with-param name="pedidoAntiguo" select="$pedidoAntiguo"/>
		</xsl:apply-templates>

	</xsl:for-each>
	</tbody>
	<tfoot class="rodape_tabela">
		<tr><td colspan="12">&nbsp;</td></tr>
	</tfoot>
	</table><!--fin tabla productos-->

	<!--PARTE DE ABAJO-->
	<xsl:if test="$OcultarPrecioReferencia='S' or ($OcultarPrecioReferencia='N' and $nuevoModeloNegocio = 'S')">
		<div class="divleft sombra">
			<p>&nbsp;</p>
			<p style="text-align:right; margin-right:15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='comision_mvm_iva']/node()"/></p>
		</div><!--fin di divleft-->
	</xsl:if>
	<!--4ago22	<p>&nbsp;</p>-->

	<!--AÑADIMOS PRODUCTOS MANUALES, NO EN PLANTILLA-->
	<xsl:if test="/Generar/MULTIOFERTAS/MANTENIMIENTO_MANUAL_PRODUCTOS">
		<div class="divleft">
			<div class="divLeft20" style="margin-left:25px">
				<div class="botonLargo">
					<a href="javascript:VerProductosManuales();"><xsl:value-of select="document($doc)/translation/texts/item[@name='anadir_productos_manuales']/node()"/></a>
				</div>
			</div>
		</div>
	</xsl:if>

	<div class="divleft" id="divProductosManuales" style="display:none;">
		<!--AÑADIMOS TABLA DE PRODUCTOS MANUALES, NO EN PLANTILLA-->
		<table class="encuesta" id="productosManuales" style="display:none;">
		<thead>
			<tr class="titulosNaranja">
				<!-- ref prove -->
				<td align="left" class="quince">
					&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>
				</td>
				<!-- producto descripcion-->
				<td class="textLeft">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>
				</td>
				<!-- ud base -->
				<td class="quince">
					&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>
				</td>
				<!-- cantidad -->
				<td class="quince">
					&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/>
				</td>
				<!-- eliminar -->
				<td class="dies">&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</thead>

		<tbody></tbody>
		</table><!--fin de tabla añadir prod no en plantilla-->

		<!--añadir nuevo producto no en plantilla-->
		<table class="infoTableNara" border="0">
			<tr>
				<th colspan="8" class="textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir_productos_manuales']/node()"/></th>
			</tr>

		<tbody>
		<input type="hidden" name="MOID" id="MOID" value="{/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/MO_ID}"/>
			<tr>
				<td class="labelRight quince">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>:&nbsp;
					<input type="text" name="REFPROVEEDOR" id="REFPROVEEDOR" size="10" />
				</td>
				<td class="labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:&nbsp;
					<input type="text" name="DESCRIPCION" id="DESCRIPCION" size="40"/>
				</td>
				<td class="labelRight quince">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>:&nbsp;
					<input type="text" name="UNIDADBASICA" id="UNIDADBASICA" size="10"/>
				</td>
				<td class="labelRight quince">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/>:&nbsp;
					<input type="text" name="CANTIDAD" id="CANTIDAD" size="10"/>
				</td>
				<td class="dies"><a href="javascript:AnadirProductosManuales();"><img src="http://www.newco.dev.br/images/botonAnadir.gif" alt="Añadir" /></a></td>
				<td>&nbsp;</td>
			</tr>

			<!--mensajeJS-->
			<input type="hidden" name="ERROR_INSERTAR_DATOS" value="{document($doc)/translation/texts/item[@name='error_insertar_datos']/node()}"/>
			<input type="hidden" name="ERROR_ELIMINAR_DATOS" value="{document($doc)/translation/texts/item[@name='error_eliminar_datos']/node()}"/>
			<input type="hidden" name="TODOS_CAMPOS_OBLI" value="{document($doc)/translation/texts/item[@name='todos_campos_obli']/node()}"/>
		</tbody>
		</table><!--fin de añadir nuevo producto no en plantilla-->
	</div><!--fin de divProductosManuales-->

	<xsl:if test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/REQUIERE_DATOS_PACIENTE">
		<table style="margin-top:40px;">
		<tr class="sinLinea">
			<td class="veinte labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Datos_paciente_obligatorios']/node()"/>:&nbsp;</td>
			<td class="veinte textLeft">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Nif_paciente']/node()"/>:&nbsp;<input type="text" name="NIFPACIENTE" id="NIFPACIENTE" size="15"/>
			</td>
			<td class="cuarenta textLeft">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Nombre_paciente']/node()"/>:&nbsp;<input type="text" name="PACIENTE" id="PACIENTE" class="grande" size="100"/>
			</td>
			<td>&nbsp;</td>
		</tr>
		</table>
	</xsl:if>


	<!--tabla totales y comentarios normales-->
	<table border="0" style="margin-top:40px;">
	<!-- Comentarios y Totales -->
	<tbody>
	<xsl:if test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/MO_OBSERVACIONES != ''">
		<tr class="sinLinea">
			<td class="dos">&nbsp;</td>
			<td colspan="6">
				<p style="margin-bottom:5px;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones_pedidos']/node()"/>:</strong></p>
				<p style="margin-bottom:10px;border:1px solid #666;padding:2px;"><xsl:copy-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/MO_OBSERVACIONES" /></p>
			</td>
			<td>&nbsp;</td>
		</tr>
	</xsl:if>

		<tr class="sinLinea">
			<td rowspan="4" class="dos">&nbsp;</td>
			<td rowspan="4" colspan="3" class="trenta textLeft">
			<xsl:choose>
			<xsl:when test="/Generar/MULTIOFERTAS/MINIMALISTA">
				<!--si usuario minimalista no veo comentarios-->
				<textarea name="COMENTARIO_{MO_ID}" class="COMENTARIO" cols="60" rows="5" style="display:none;">
					<xsl:if test="PARAMETRO1!='' or PARAMETRO2!='' or PARAMETRO3!=''">
						<xsl:attribute name="disabled">disabled</xsl:attribute>
					</xsl:if>
					<!-- Se actualiza desde JS
					<xsl:copy-of select="COMENTARIOPORDEFECTO/COMENTARIO"/>
					<xsl:if test="PARAMETRO1!=''">
						<xsl:text disable-output-escaping="yes"><![CDATA[	
						
]]></xsl:text>Hoja de gastos:&nbsp;<xsl:value-of select="PARAMETRO1"/>
					</xsl:if>
					<xsl:if test="PARAMETRO2!=''">
						<xsl:text disable-output-escaping="yes"><![CDATA[	
]]></xsl:text>NombrePaciente:&nbsp;<xsl:value-of select="PARAMETRO2"/>
					</xsl:if>
					<xsl:if test="PARAMETRO3!=''">
						<xsl:text disable-output-escaping="yes"><![CDATA[	
]]></xsl:text>Num.Cedula:&nbsp;<xsl:value-of select="PARAMETRO3"/>
					</xsl:if>
					-->
				</textarea>
			</xsl:when>
			<xsl:otherwise>
				<!--comentarios-->
				<p id="comentParametros"></p>
				<BR/>
				<strong><xsl:copy-of select="document($doc)/translation/texts/item[@name='puede_anadir_sus_comentarios']/node()"/></strong><br/>
				(<xsl:call-template name="botonPersonalizado">
					<xsl:with-param name="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_comentarios']/node()"/></xsl:with-param>
					<xsl:with-param name="status">Comentarios</xsl:with-param>
					<xsl:with-param name="funcion">ultimosComentarios('COMENTARIO_<xsl:value-of select="MO_ID"/>','Principal','MULTIOFERTAS');</xsl:with-param>
				</xsl:call-template>)
				<br/>
				<textarea name="COMENTARIO_{MO_ID}" class="COMENTARIO" cols="70" rows="10">
				</textarea>
			</xsl:otherwise>
			</xsl:choose>
			<br/>
			<a href="http://www.newco.dev.br/Compras/Multioferta/CVGenerar_MO2022.xsql?LP_ID={/Generar/MULTIOFERTAS/LP_ID}">Recarga</a>
			</td>
			<td rowspan="4" class="dos">&nbsp;</td>
			<td rowspan="3" class="cuarenta">&nbsp;
				<!--Comprobar si la empresa requiere desplegable de tipo de pedido-->
				<xsl:choose>
				<xsl:when test="not(/Generar/MULTIOFERTAS/TIPOS_PEDIDOS/TIPO)">
					<input type="hidden" name="IDTIPOPEDIDO" value=""/>
				</xsl:when>
				<xsl:otherwise>
					<table>
					<tr>
						<td class="labelRight">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_pedido']/node()"/>:&nbsp;
						</td>
						<td>
						<select name="IDTIPOPEDIDO" id="IDTIPOPEDIDO" onChange="javascript:chTipoPedido();">
							<option value="" selected="selected"><xsl:value-of select="document($doc)/translation/texts/item[@name='seleccionar']/node()"/></option>
							<xsl:for-each select="/Generar/MULTIOFERTAS/TIPOS_PEDIDOS/TIPO">
								<option value="{PED_TIP_ID}"><xsl:value-of select="PED_TIP_NOMBRE"/></option>
							</xsl:for-each>
						</select>
						</td>
					</tr>
					<xsl:for-each select="/Generar/MULTIOFERTAS/TIPOS_PEDIDOS/TIPO">
					<!--<p class="textLeft p_TipoPedido" id="p_Tipo_{PED_TIP_ID}" style="display:none">-->
						<xsl:for-each select="TITULOS_TIPOS_PEDIDOS/TITULO">
							<tr class="tr_TiposPedido tr_{../../PED_TIP_ID}" id="tr_{PED_TIT_ID}" style="display:none">
							<td class="labelRight">
								<xsl:value-of select="PED_TIT_NOMBRE"/>:&nbsp;
							</td>
							<td>
								<select name="IDTIPOPEDIDO_{PED_TIT_ID}" id="IDTIPOPEDIDO_{PED_TIT_ID}" onChange="javascript:chValorPedido('{PED_TIT_ID}');">
									<option value="" selected="selected"><xsl:value-of select="document($doc)/translation/texts/item[@name='seleccionar']/node()"/></option>
									<xsl:for-each select="VALORES_TIPOS_PEDIDOS/VALOR">
										<option value="{PED_TIV_ID}"><xsl:value-of select="PED_TIV_NOMBRE"/></option>
									</xsl:for-each>
								</select>
							</td>
							</tr>
						</xsl:for-each>
					</xsl:for-each>
					</table>
				</xsl:otherwise>
				</xsl:choose>
				<!--Comprobar si la empresa requiere separar pedidos de deposito-->
				<xsl:choose>
				<xsl:when test="not(/Generar/MULTIOFERTAS/MARCARDEPOSITO) or (MO_DEPOSITO='N')">
					<input type="hidden" name="DEPOSITO_{MO_ID}"/>
				</xsl:when>
				<xsl:otherwise>
					<p class="textLeft">
					<input type="checkbox" class="muypeq" name="DEPOSITO_{MO_ID}" disabled="disabled" checked="checked"/>
					<!--<xsl:if test="MO_DEPOSITO='S'">
						<xsl:attribute name="checked">checked</xsl:attribute>
					</xsl:if>
					</input>-->&nbsp;
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='deposito']/node()"/></strong>
					</p>
				</xsl:otherwise>
				</xsl:choose>
				<!--Comprobar si la empresa requiere separar pedidos de deposito-->
				<xsl:if test="/Generar/MULTIOFERTAS/MARCARCONVENIO and MO_CONCONVENIO='S'">
					<p class="textLeft">
					<input type="checkbox" class="muypeq" name="CONVENIO_{MO_ID}" disabled="disabled" checked="checked">
					</input>&nbsp;
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='Convenio']/node()"/></strong>
					</p>
				</xsl:if>
				<p class="textLeft">
				<!--si usuario minimalista no pedido urgente-->
				<xsl:choose>
				<xsl:when test="/Generar/MULTIOFERTAS/MINIMALISTA">
					<input type="hidden" name="URGENTE_{MO_ID}"/>
					<input type="hidden" name="BAJAPRIORIDAD_{MO_ID}"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="checkbox" class="muypeq" name="URGENTE_{MO_ID}" id="URGENTE_{MO_ID}" onclick="javacript:clickPrioridad('URGENTE','{MO_ID}');"/>&nbsp;
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_muy_urgente']/node()"/></strong>
					<xsl:choose>
					<xsl:when test="/Generar/MULTIOFERTAS/INCLUIR_BAJA_PRIORIDAD">
						<br/><input type="checkbox" class="muypeq" name="BAJAPRIORIDAD_{MO_ID}" id="BAJAPRIORIDAD_{MO_ID}" onclick="javacript:clickPrioridad('BAJAPRIORIDAD','{MO_ID}');"/>&nbsp;
						<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='baja_prioridad']/node()"/></strong>
					</xsl:when>
					<xsl:otherwise>
						<input type="hidden" name="BAJAPRIORIDAD_{MO_ID}"/>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
				</xsl:choose>
				</p>
				<p>&nbsp;</p>
				<xsl:choose>
				<xsl:when test="/Generar/MULTIOFERTAS/OCULTAR_CODIGO_PEDIDO">
					<input type="hidden" name="NUMERO_OFERT_PED_{MO_ID}" value="{MO_NUMEROCLINICA}"/>
				</xsl:when>
				<xsl:otherwise>
					<p class="textLeft">
						<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='numero_pedido_interno']/node()"/>:&nbsp;</span>
						<input type="text" class="campopesquisa w100px" maxlength="100" name="NUMERO_OFERT_PED_{MO_ID}" value="{MO_NUMEROCLINICA}"/>
					</p>
				</xsl:otherwise>
				</xsl:choose>
				
				<input type="hidden" name="SolicitaComercial{MO_ID}" value="no"/>
				<input type="hidden" name="SolicitaMuestra{MO_ID}" value="no"/>
				
				
				<!--
				<input type="hidden" name="NoComercial{MO_ID}" value="no"/>
				<p class="textLeft">
					<input type="hidden" name="CADENA_DOCUMENTOS"/>
					<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
					<input type="hidden" name="BORRAR_ANTERIORES"/>
					<input type="hidden" name="ID_USUARIO" value="{SOLICITUD/IDUSUARIO}"/>
					<input type="hidden" name="IDEMPRESA" id="IDEMPRESA" value="{SOLICITUD/IDEMPRESAUSUARIO}"/>
					<input type="hidden" name="TIPO_DOC_DB" id="TIPO_DOC_DB" value="DOCPEDIDO"/>
					<input type="hidden" name="TIPO_DOC_HTML" id="TIPO_DOC_HTML" value="DOCPEDIDO"/>
					<br/><xsl:value-of select="document($doc)/translation/texts/item[@name='Adjuntar_documento']/node()"/>:&nbsp;<br/>
					<input id="inputFileDoc" name="inputFileDoc" type="file" style="width:400px;" onChange="javascript:cargaDoc();"/>
					<span id="docBox" style="display:none;" align="center"></span>&nbsp;
					<span id="borraDoc" style="display:none;" align="center"></span>
					<!- -frame para los documentos- ->
					<div id="uploadFrameBox" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>
					<div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>
				</p>
				<div id="waitBoxDoc" align="center">&nbsp;</div>
				<input type="hidden" name="IDDOCUMENTO" id="IDDOCUMENTO" value=""/>
				-->
				<p class="textLeft">
					<br/>
					<strong><a class="btnNormal" href="javascript:AbrirGestionDocumentos();"><xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/></a></strong><br/><br/>
					<xsl:choose>
					<xsl:when test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DOCUMENTOS/DOCUMENTOS_COMPRADOR/DOCUMENTO">
						<input type="hidden" name="IDDOCUMENTO" id="IDDOCUMENTO" value="{/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DOCUMENTOS/DOCUMENTOS_COMPRADOR/DOCUMENTO[1]/ID}"/>
						<xsl:for-each select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DOCUMENTOS/DOCUMENTOS_COMPRADOR/DOCUMENTO">
							&nbsp;<a>
								<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Documentos/<xsl:value-of select="URL"/>','Documentos',100,80,0,0);</xsl:attribute>
								<xsl:value-of select="NOMBRETIPO"/>:&nbsp;<xsl:value-of select="NOMBRE"/>
							</a><br/>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<input type="hidden" name="IDDOCUMENTO" id="IDDOCUMENTO" value=""/>
					</xsl:otherwise>
					</xsl:choose>
					<!-- Esto solo para la multioferta ya enviada al proveedor
					<xsl:if test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DOCUMENTOS/DOCUMENTOS_VENDEDOR/DOCUMENTO">
						DocsVendedor<br/>
					</xsl:if>
					-->
				</p>
			</td>
			<td colspan="2">&nbsp;</td>
		</tr>
			
	<!--	Creamos tabla dentro de Ãla columna para ajustar los datos de totales		-->
	<tr rowspan="10"><td>
	<table>

	<!--	2jun10	para el nuevo modelo de negocio no mostramos subtotal, para el viejo si (asisa si que ve)	-->
	<xsl:choose>
	<xsl:when test="$nuevoModeloNegocio = 'N'">
		<tr class="sinLinea">
			<td class="textRight">
				<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='subtotal']/node()"/>:</strong>&nbsp;
			</td>

			<td class="textRight">
			<xsl:choose>
			<xsl:when test="MO_IMPORTETOTAL[.='']">
				<input type="text" size="12" maxlength="12" class="noinput" style="text-align:right;" name="MO_IMPORTETOTAL_{MO_ID}" value="Por definir" onFocus="this.blur();"/>&nbsp;&nbsp;&nbsp;&nbsp;
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DIVISA/PREFIJO"/><input type="text" size="12" maxlength="12" class="noinput" style="text-align:right;" name="MO_IMPORTETOTAL_{MO_ID}" value="{MO_IMPORTETOTAL}" onFocus="this.blur();"/>&nbsp;<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DIVISA/SUFIJO"/>&nbsp;&nbsp;&nbsp;&nbsp;
				<br />
			</xsl:otherwise>
			</xsl:choose>
			</td>
			<!--
			<td class="tres">
			<xsl:choose>
			<xsl:when test="MO_IMPORTETOTAL[.='']">
				&nbsp;
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DIVISA/SUFIJO"/>
			</xsl:otherwise>
			</xsl:choose>
			</td>
			-->
		</tr>
	</xsl:when>
	<!--si es nuevo modelo-->
	<xsl:otherwise>
		<input type="hidden" name="MO_IMPORTEIVA_{MO_ID}" value="{MO_IMPORTEIVA}"/>
		<input type="hidden" name="MO_IMPORTETOTAL_{MO_ID}" value="{MO_IMPORTETOTAL}"/>
	</xsl:otherwise>
	</xsl:choose>

	<!--	2jun10	para el nuevo modelo de negocio, no mostramos IVA, ya está incluido en el total-->
	<xsl:choose>
	<xsl:when test="$nuevoModeloNegocio = 'N'"><!--modelo viejo-->
		<!--choose si es brasil no enseño, solo modelo nuevo en brasil-->
		<xsl:choose>
		<xsl:when test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/IDPAIS = '55'">
			<!--input hidden si es brasil-->
			<xsl:choose>
			<xsl:when test="MO_IMPORTEIVA[.='']">
				<input type="hidden" name="MO_IMPORTEIVA_{MO_ID}" value="Por definir"/>
			</xsl:when>
			<xsl:otherwise>
				<input type="hidden" name="MO_IMPORTEIVA_{MO_ID}" value="{MO_IMPORTEIVA}"/>
			</xsl:otherwise>
			</xsl:choose>

			<tr class="sinLinea">
				<td class="textRight">
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='trasporte']/node()"/>:</strong>&nbsp;
				</td>
				<td class="textRight">
					<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DIVISA/PREFIJO"/><input type="text" class="noinput" name="COSTE_LOGISTICA_{MO_ID}" size="8" maxlength="12" style="text-align:right;" value="{/Generar/COSTE_LOGISTICA}" onFocus="this.blur();"/>&nbsp;<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DIVISA/SUFIJO"/>&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="hidden" name="COSTE_LOGISTICA_IVA_{MO_ID}" value="0"/>
				</td>
				<!--
				<td class="tres">
					<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DIVISA/SUFIJO"/>
				</td>
				-->
			</tr>
			<!--fin de input hidden si es brasil-->
		</xsl:when>

		<!--si es asisa-->
		<xsl:otherwise>

			<tr class="sinLinea">
				<td class="textRight">
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='importe_iva']/node()"/>:</strong>&nbsp;
				</td>
				<td class="textRight">
				<xsl:choose>
				<xsl:when test="MO_IMPORTEIVA[.='']">
					<input type="text" size="12" maxlength="12" class="noinput" style="text-align:right;" name="MO_IMPORTEIVA_{MO_ID}" value="Por definir" onFocus="this.blur();"/>&nbsp;&nbsp;&nbsp;&nbsp;
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DIVISA/PREFIJO"/><input type="text" size="12" maxlength="12" class="noinput" style="text-align:right;" name="MO_IMPORTEIVA_{MO_ID}" value="{MO_IMPORTEIVA}" onFocus="this.blur();"/>&nbsp;<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DIVISA/SUFIJO"/>&nbsp;&nbsp;&nbsp;&nbsp;
				</xsl:otherwise>
				</xsl:choose>
				</td>
			</tr>
			<!--	28dic20 Datos de coste de transporte					-->
			<xsl:choose>
			<xsl:when test="/Generar/MULTIOFERTAS/EDITAR_COSTE_TRANSPORTE">
				<tr class="sinLinea">
					<td class="textRight">
						<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='coste_trasporte']/node()"/>:</strong>&nbsp;
					</td>

					<td class="textRight">
						<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DIVISA/PREFIJO"/><input type="text" size="12" maxlength="12" style="text-align:right;" name="COSTE_LOGISTICA_{MO_ID}" value="{MO_COSTELOGISTICA}" onChange="javascript:CambioCosteLogistica({MO_ID});"/>&nbsp;<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DIVISA/SUFIJO"/>&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
				<tr class="sinLinea">
					<td class="textRight">
						<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='IVA_coste_transporte']/node()"/>:</strong>&nbsp;
					</td>
					<td class="textRight">
						<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DIVISA/PREFIJO"/><input type="text" size="12" maxlength="12" style="text-align:right;" name="COSTE_LOGISTICA_IVA_{MO_ID}" value="{MO_COSTELOGISTICA_IVA}" onChange="javascript:CambioIVACosteLogistica({MO_ID});"/>&nbsp;<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DIVISA/SUFIJO"/>&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<input type="hidden" name="COSTE_LOGISTICA_{MO_ID}" value="0"/>
				<input type="hidden" name="COSTE_LOGISTICA_IVA_{MO_ID}" value="0"/>
			</xsl:otherwise>
			</xsl:choose>
			
		</xsl:otherwise>
		</xsl:choose>
	</xsl:when>
	<xsl:otherwise>
		<!--todos los demas-->
		<input type="hidden" name="COSTE_LOGISTICA_{MO_ID}" value="0"/>
		<input type="hidden" name="MO_IMPORTEIVA_{MO_ID}" value="{MO_IMPORTEIVA}"/>
	</xsl:otherwise>
	</xsl:choose>

		<!--importe final lo ven todos-->
		<tr class="sinLinea">
			<!--<td>
				&nbsp;
			</td>-->
			<td class="textRight">
				<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='importe_total']/node()"/>:</strong>&nbsp;
			</td>

			<!--	6jul10 Este codigo reemplaza al comentado a continuación	-->
			<td class="textRight">
			<xsl:choose>
			<!--ASISA Y BRASIL VIEJO MODELO PRECIO PROV SIN IVA-->
			<xsl:when test="($nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N' and not(/Generar/MULTIOFERTAS/MOSTRAR_PRECIO_CON_IVA)) or /Generar/MULTIOFERTAS/IDPAIS = '55'">
				<xsl:choose>
				<xsl:when test="MO_IMPORTETOTAL[.='']">
					<input type="text" size="12" maxlength="12" class="noinput" style="text-align:right; color:#000000;" name="MO_IMPORTEFINAL_{MO_ID}" value="Por definir" onFocus="this.blur();"/>&nbsp;&nbsp;&nbsp;&nbsp;
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DIVISA/PREFIJO"/><input type="text" size="12" maxlength="12" class="noinput" style="text-align:right; color:#000000;" name="MO_IMPORTEFINAL_{MO_ID}" value="{MO_IMPORTETOTAL}" onFocus="this.blur();"/>&nbsp;<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DIVISA/SUFIJO"/>&nbsp;&nbsp;&nbsp;&nbsp;
				</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!--VIAMED NUEVO VIEJO MODELO PERO VEO PRECIO PROV CON IVA-->
			<xsl:when test="$nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N' and /Generar/MULTIOFERTAS/MOSTRAR_PRECIO_CON_IVA">
				<xsl:choose>
				<xsl:when test="MO_IMPORTETOTAL[.='']">
					<input type="text" size="12" maxlength="12" class="noinput" style="text-align:right; color:#000000;" name="MO_IMPORTEFINAL_{MO_ID}" value="Por definir" onFocus="this.blur();"/>&nbsp;&nbsp;&nbsp;&nbsp;
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DIVISA/PREFIJO"/><input type="text" size="12" maxlength="12" class="noinput" style="text-align:right; color:#000000;" name="MO_IMPORTEFINAL_{MO_ID}" value="{MO_IMPORTETOTAL}" onFocus="this.blur();"/>&nbsp;<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DIVISA/SUFIJO"/>&nbsp;&nbsp;&nbsp;&nbsp;
				</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!--NUEVO MODELO VIEJO PEDIDO alicante...PRECIO FINAL-->
			<xsl:when test="$nuevoModeloNegocio = 'S' and $pedidoAntiguo = 'S'">
				<xsl:choose>
				<xsl:when test="MO_IMPORTEFINAL[.='']">
					<input type="text" size="12" maxlength="12" class="noinput" style="text-align:right; color:#000000;" name="MO_IMPORTEFINAL_{MO_ID}" value="Por definir" onFocus="this.blur();"/>&nbsp;&nbsp;&nbsp;&nbsp;
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DIVISA/PREFIJO"/><input type="text" size="12" maxlength="12" class="noinput" style="text-align:right; color:#000000;" name="MO_IMPORTEFINAL_{MO_ID}" value="{MO_IMPORTEFINAL}" onFocus="this.blur();"/>&nbsp;<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DIVISA/SUFIJO"/>&nbsp;&nbsp;&nbsp;&nbsp;
				</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!--NUEVO MODELO NUEVO PEDIDO - PARA VIAMED VIEJO, VENDRELL...VEO PRECIO FINAL-->
			<xsl:when test="$nuevoModeloNegocio = 'S' and $pedidoAntiguo = 'N'">
				<xsl:choose>
				<xsl:when test="MO_IMPORTEFINAL[.='']">
					<input type="text" size="12" maxlength="12" class="noinput" style="text-align:right; color:#000000;" name="MO_IMPORTEFINAL_{MO_ID}" value="Por definir" onFocus="this.blur();"/>&nbsp;&nbsp;&nbsp;&nbsp;
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DIVISA/PREFIJO"/><input type="text" size="12" maxlength="12" class="noinput" style="text-align:right; color:#000000;" name="MO_IMPORTEFINAL_{MO_ID}" value="{MO_IMPORTEFINAL}" onFocus="this.blur();"/>&nbsp;<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DIVISA/SUFIJO"/>&nbsp;&nbsp;&nbsp;&nbsp;
				</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			</xsl:choose>
				<input type="hidden" name="OCULTO_PRECIO_REF_{MO_ID}" value="{$OcultarPrecioReferencia}"/>
				<input type="hidden" name="NUEVO_MODELO_NEGOCIO_{MO_ID}" value="{$nuevoModeloNegocio}"/>
				<input type="hidden" name="IVA_{MO_ID}" value="{MO_IMPORTEIVA}"/>
			</td>
			<!--
			<td class="tres">
				<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DIVISA/SUFIJO"/>
			</td>
			-->
		</tr>
	</table>
	</td>
	</tr>
	
	<xsl:choose>
	<xsl:when test="$OcultarPrecioReferencia='N'"></xsl:when>
	<xsl:otherwise>
		<tr class="sinLinea"><td colspan="4">&nbsp;</td></tr>
		<tr class="sinLinea"><td colspan="4">&nbsp;</td></tr>
	</xsl:otherwise>
	</xsl:choose>

		<tr class="sinLinea"><td colspan="4">&nbsp;</td></tr>
		<tr class="sinLinea"><td colspan="4">&nbsp;</td></tr>
	</tbody>
	</table>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	</div>
</xsl:for-each>
</xsl:template>

<!--lineas de productos-->
<xsl:template match="LINEASMULTIOFERTA_ROW">
	<xsl:param name="OcultarPrecioReferencia"/>
	<xsl:param name="nuevoModeloNegocio"/>
	<xsl:param name="pedidoAntiguo"/>

	<xsl:variable name="lang"><xsl:value-of select="/Generar/LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>

	<tr class="conhover">
		<!-- ref mvm-->
		<td align="left">
			&nbsp;
			<xsl:value-of select="REFERENCIAPRIVADA"/>
			<input type="hidden" name="REF_{LMO_ID}" id="REF_{LMO_ID}" value="{REFERENCIAPRIVADA}"/>
		</td>

		<!-- nombre producto link -->
		<td class="textLeft" style="padding-left:5px;">
			<xsl:if test="LMO_ORDEN>1">
				<xsl:call-template name="desplegable">
   					<xsl:with-param name="path" select="/Generar/MULTIOFERTAS/MOTIVOORDENNO1/field"/>
					<xsl:with-param name="nombre">IDMOTIVO_<xsl:value-of select="LMO_ID"/></xsl:with-param>
				</xsl:call-template>&nbsp;
			</xsl:if>
			<xsl:if test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/MO_ESPECIAL='REGULADO'">
				<span class="amarillo"><b>[REG]</b></span>&nbsp;
			</xsl:if>
			<xsl:choose>
			<xsl:when test="NOMBREPRIVADO!=''">
				<a style="text-decoration:none;">
					<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle2022.xsql?PRO_ID=<xsl:value-of select="LMO_IDPRODUCTO"/>&amp;SES_ID=<xsl:value-of select="//SES_ID"/>','producto',100,80,0,0)</xsl:attribute>
					<!--<span class="strongAzul"><xsl:value-of select="NOMBREPRIVADO"/></span>-->
					<xsl:value-of select="NOMBREPRIVADO"/>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<a style="text-decoration:none;">
					<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle2022.xsql?PRO_ID=<xsl:value-of select="LMO_IDPRODUCTO"/>&amp;SES_ID=<xsl:value-of select="//SES_ID"/>','producto',100,80,0,0)</xsl:attribute>
					<!--<span class="strongAzul"><xsl:value-of select="PRO_NOMBRE"/></span>-->
					<xsl:value-of select="PRO_NOMBRE"/>
				</a>
			</xsl:otherwise>
			</xsl:choose>
		</td>

		<!--ref provee si normal, marca si farmacia-->
		<xsl:if test="not(/Generar/MULTIOFERTAS/OCULTAR_REFERENCIA_PROVEEDOR)">
			<td align="center">
			<xsl:choose>
			<!--si es farmacia no veo ref prov, solo si es viamed5 veo ref prov-->
			<xsl:when test="LMO_CATEGORIA = 'F' and not(/Generar/MULTIOFERTAS/UTILIZAR_REFERENCIA_PROVEEDOR)">
				<xsl:value-of select="PRO_REFERENCIA"/>
			</xsl:when>
			<!--si no es viamed5 no veo ref prov-->
			<xsl:when test="LMO_CATEGORIA = 'F'  and /Generar/MULTIOFERTAS/UTILIZAR_REFERENCIA_PROVEEDOR">
			</xsl:when>
			<xsl:when test="LMO_CATEGORIA = 'N'">
				<xsl:value-of select="PRO_REFERENCIA"/>
			</xsl:when>
			</xsl:choose>
			</td>
		</xsl:if>

		<!--marca siempre, antes solo si es asisa-->
		<td class="center" style="font-size:11px;">
			<xsl:value-of select="PRO_MARCA"/>
		</td>

		<!-- ud base -->
		<td>
			<xsl:value-of select="PRO_UNIDADBASICA" disable-output-escaping="yes"/>
		</td>

		<!-- precio -->
		<td align="center">
		<xsl:choose>
		<!--ASISA Y BRASIL VIEJO MODELO PRECIO PROV SIN IVA-->
		<xsl:when test="($nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N' and not(/Generar/MULTIOFERTAS/MOSTRAR_PRECIO_CON_IVA)) or /Generar/MULTIOFERTAS/IDPAIS = '55'">
			<xsl:value-of select="LMO_PRECIO"/>
		</xsl:when>
		<!--VIAMED NUEVO VIEJO MODELO PERO VEO PRECIO PROV CON IVA-->
		<xsl:when test="$nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N' and /Generar/MULTIOFERTAS/MOSTRAR_PRECIO_CON_IVA">
			<xsl:value-of select="TARIFA_CONIVA"/>
		</xsl:when>
		<!--NUEVO MODELO VIEJO PEDIDO alicante...PRECIO FINAL-->
		<xsl:when test="$nuevoModeloNegocio = 'S' and $pedidoAntiguo = 'S'">
			<xsl:value-of select="TARIFA_TOTAL"/>
		</xsl:when>
		<!--NUEVO MODELO NUEVO PEDIDO - PARA VIAMED VIEJO, VENDRELL...VEO PRECIO FINAL-->
		<xsl:when test="$nuevoModeloNegocio = 'S' and $pedidoAntiguo = 'N'">
			<xsl:value-of select="TARIFA_TOTAL"/>
		</xsl:when>
		</xsl:choose>
		</td>

		<!-- cantidad -->
		<td class="center">
			<xsl:value-of select="LMO_CANTIDAD"/>
		</td>

		<!--importe-->
		<td align="center">
		<xsl:choose>
		<!--ASISA Y BRASIL VIEJO MODELO PRECIO PROV SIN IVA-->
		<xsl:when test="($nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N' and not(/Generar/MULTIOFERTAS/MOSTRAR_PRECIO_CON_IVA)) or /Generar/MULTIOFERTAS/IDPAIS = '55'">
			<xsl:choose>
			<xsl:when test="IMPORTE=''">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='pedir_oferta']/node()"/>&nbsp;
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="IMPORTE"/>&nbsp;
			</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<!--VIAMED NUEVO VIEJO MODELO PERO VEO PRECIO PROV CON IVA-->
		<xsl:when test="$nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N' and /Generar/MULTIOFERTAS/MOSTRAR_PRECIO_CON_IVA">
			<xsl:choose>
			<xsl:when test="TARIFA_TOTAL_CONIVA=''"> 
				<xsl:value-of select="document($doc)/translation/texts/item[@name='pedir_oferta']/node()"/>&nbsp;
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="TARIFA_TOTAL_CONIVA"/>&nbsp;
			</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<!--NUEVO MODELO VIEJO PEDIDO alicante...PRECIO FINAL AQUI-->
		<xsl:when test="$nuevoModeloNegocio = 'S' and $pedidoAntiguo = 'S'">
			<xsl:choose>
			<xsl:when test="LINEASUMAFINAL_FORMATO=''">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='pedir_oferta']/node()"/>&nbsp;
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="LINEASUMAFINAL_FORMATO"/>&nbsp;
			</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<!--NUEVO MODELO NUEVO PEDIDO - PARA VIAMED VIEJO, VENDRELL...VEO PRECIO FINAL-->
		<xsl:when test="$nuevoModeloNegocio = 'S' and $pedidoAntiguo = 'N'">
			<xsl:choose>
			<xsl:when test="LINEASUMAFINAL_FORMATO=''">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='pedir_oferta']/node()"/>&nbsp;
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="LINEASUMAFINAL_FORMATO"/>&nbsp;
			</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		</xsl:choose>
		</td>
		<!--
		<td align="center">
			<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DIVISA/SUFIJO"/>
		</td>
		-->
	</tr>
</xsl:template>

<xsl:template match="PROVEEDOR">
	<a>
		<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="../MO_IDPROVEEDOR"/>&amp;VENTANA=NUEVA','empresa',100,80,0,0)</xsl:attribute>
		<xsl:attribute name="onMouseOver">window.status='Información sobre la empresa.';return true;</xsl:attribute>
		<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>

		<xsl:value-of select="." disable-output-escaping="yes"/>
	</a>
</xsl:template>

<!--  templates de la nueva version  -->
<xsl:template name="direccion">
	<xsl:param name="path"/>

	<p class="textLeft">
		<input type="text" name="CEN_DIRECCION" size="50" value="{$path/CEN_DIRECCION}" style="text-align:left; margin-top:10px;" class="noinput" onFocus="this.blur();"/>
		<br />

	<!--spain-->
	<xsl:choose>
	<xsl:when test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/IDPAIS != '55'">
		<input type="text" name="CEN_CPOSTAL" size="5" value="{$path/CEN_CPOSTAL}" style="text-align:left;" class="noinput peq" onFocus="this.blur();"/>
	</xsl:when>
	<xsl:when test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/IDPAIS = '55'">
		<input type="text" name="CEN_CPOSTAL" size="10" value="{$path/CEN_CPOSTAL}" style="text-align:left;" class="noinput" onFocus="this.blur();"/>
	</xsl:when>
	</xsl:choose>
		&nbsp;-&nbsp;
		<input type="text" name="CEN_POBLACION" size="20" value="{$path/CEN_POBLACION}" style="text-align:left;" class="noinput" onFocus="this.blur();"/>
		<input type="hidden" name="CEN_PROVINCIA" value="{$path/CEN_PROVINCIA}"/>
	</p>
</xsl:template>
<!--
<xsl:template name="FORMASPAGO">
	<xsl:call-template name="desplegable">
    		<xsl:with-param name="path" select="//MULTIOFERTAS/MULTIOFERTAS_ROW[1]/FORMASPAGO/field"/>
		<xsl:with-param name="defecto" select="//Generar/IDFORMAPAGO"/>
	</xsl:call-template>
</xsl:template>

<xsl:template name="PLAZOSPAGO">
	<xsl:param name="onChange"/>

	<xsl:call-template name="desplegable">
		<xsl:with-param name="path" select="//MULTIOFERTAS/MULTIOFERTAS_ROW[1]/PLAZOSPAGO/field"/>
		<xsl:with-param name="defecto" select="//Generar/IDPLAZOPAGO"/>
		<xsl:with-param name="onChange"><xsl:value-of select="$onChange"/></xsl:with-param>
	</xsl:call-template>
</xsl:template>
-->



<!-- fin templates de la nueva version-->
</xsl:stylesheet>
