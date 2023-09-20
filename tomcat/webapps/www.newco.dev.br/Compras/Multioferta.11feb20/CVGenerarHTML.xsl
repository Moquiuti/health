<?xml version="1.0" encoding="iso-8859-1"?>
<!--	
	Segundo paso de la creaci�n del pedido: condiciones particulares
	ultima revision: ET 18dic19 09:45 CVGenerar_181219.js
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
  
<html>
<head>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<link rel="stylesheet" href="http://www.newco.dev.br/General/calendario/spiffyCal_v2_1.css" type="text/css"/>
<!--	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/calendario/spiffyCal_v2_1.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/ajax.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Compras/Multioferta/CVGenerar_181219.js"></script>
	<script type="text/javascript">

		var isCdC			= '<xsl:choose><xsl:when test="MULTIOFERTAS/CENTRALCOMPRAS">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		var IDEmpresa		= '<xsl:value-of select="MULTIOFERTAS/IDCLIENTE"/>';
		var IDCentro		= '<xsl:value-of select="IDCENTRO"/>';
		var IDUsuario		= '<xsl:value-of select="MULTIOFERTAS/IDUSUARIO"/>';
		var IDLugarEntrega		= '<xsl:value-of select="IDLUGARENTREGA"/>';
		var IDCentroConsumo		= '<xsl:value-of select="IDCENTROCONSUMO"/>';
		var PlazoEntregaInicial	= '<xsl:value-of select="MULTIOFERTAS/MULTIOFERTAS_ROW/LP_PLAZOENTREGA"/>';
		var NumMultiofertas		= '<xsl:value-of select="MULTIOFERTAS/NUMERO_MULTIOFERTAS"/>';
		var reqDatosPaciente	= '<xsl:choose><xsl:when test="MULTIOFERTAS/MULTIOFERTAS_ROW/REQUIERE_DATOS_PACIENTE">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';

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

		var msgDatosPacienteObligatorios	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgDatosPacienteObligatorios']/node()"/>';
		var msgDocumentoCirugiaObligatorio	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='msgDocumentoCirugiaObligatorio']/node()"/>';

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
	<div id="spiffycalendar" class="text"></div>
	<script type="text/javascript">
		var calFechaEntrega = new ctlSpiffyCalendarBox("calFechaEntrega", "Principal", "FECHA_ENTREGA","btnDateFechaEntrega",'<xsl:value-of select="/Generar/FECHA_ENTREGA"/>',scBTNMODE_CLASSIC,'ONCHANGE|actualizarPlazo(document.forms[\'Principal\'],\'ENTREGA\',new Date());#CHANGEDAY|actualizarPlazo(document.forms[\'Principal\'],\'ENTREGA\',new Date());');
	</script>

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
		<input type="hidden" name="LP_ID" value="{/Generar/LP_ID}"/>
		<input type="hidden" name="BOTON"/>
		<input type="hidden" name="MO_IDPROGRAMAR"/>
		<input type="hidden" name="ESTADOPROGRAMAR"/>
		<input type="hidden" name="COSTE_LOGISTICA"/>

	<xsl:choose>
	<xsl:when test="//xsql-error">
		<xsl:apply-templates select="//xsql-error"/>
	</xsl:when>
	<xsl:when test="//Status">
		<xsl:apply-templates select="//Status"/>
	</xsl:when>
	<xsl:otherwise>
		<!--idioma- - >
		<xsl:variable name="lang"><xsl:value-of select="LANG"/></xsl:variable>
		<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
		< ! - -idioma fin-->

		<div class="divleft">
			<!--	Titulo de la p�gina		-->
			<div class="ZonaTituloPagina">
				<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_pedido']/node()"/></span></p>
				<p class="TituloPagina">
					<xsl:value-of select="MULTIOFERTAS/TIPODOCUMENTO"/><xsl:text>&nbsp;a&nbsp;</xsl:text>
                   	<xsl:value-of select="MULTIOFERTAS/MULTIOFERTAS_ROW/CENTROPROVEEDOR"/>
					<span class="CompletarTitulo" style="width:500px;">
						<!--	Incluir los botones	-->
						<a class="btnNormal" href="javascript:volverAtras();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/>
						</a>&nbsp;
						<a class="btnNormal" href="javascript:window.print();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
						</a>&nbsp;
						<xsl:if test="MULTIOFERTAS/NUMERO_MULTIOFERTAS=1 and not(MULTIOFERTAS/MINIMALISTA)">
							<a class="btnDestacado" >
								<xsl:attribute name="href">javascript:ProgramarPedido(document.forms['Principal'],'CVGenerarSave.xsql',document.forms['PedidoMinimo'],'<xsl:value-of select="MULTIOFERTAS/MULTIOFERTAS_ROW[1]/MO_ID"/>','PED_PROGRAMABLE_<xsl:value-of select="MULTIOFERTAS/MULTIOFERTAS_ROW[1]/MO_ID"/>');</xsl:attribute>
								<xsl:value-of select="document($doc)/translation/texts/item[@name='programar']/node()"/>
							</a>&nbsp;
						</xsl:if>
						<!--<a class="btnDestacado" id="botonEnviarPedido" href="javascript:GuardarComentarios(document.forms['Principal'],'CVGenerarSave.xsql',document.forms['PedidoMinimo']);">-->
						<a class="btnDestacado" id="botonEnviarPedido" href="javascript:EnviarPedidos(document.forms['Principal'],'CVGenerarSave.xsql',document.forms['PedidoMinimo']);">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/>
						</a>
					</span>
				</p>
			</div>
			<!--
			<h1 class="titlePage">
				<xsl:value-of select="MULTIOFERTAS/TIPODOCUMENTO"/><xsl:text>&nbsp;a&nbsp;</xsl:text>

				<xsl:choose>
				<xsl:when test="MULTIOFERTAS/MULTIOFERTAS_ROW/CENTROPROVEEDOR != ''">
                    <xsl:value-of select="MULTIOFERTAS/MULTIOFERTAS_ROW/CENTROPROVEEDOR"/>
                    <xsl:if test="MULTIOFERTAS/MULTIOFERTAS_ROW/VENDEDOR != ''">
                        &nbsp;(<xsl:value-of select="MULTIOFERTAS/MULTIOFERTAS_ROW/VENDEDOR"/>)
                    </xsl:if>
                </xsl:when>
				<xsl:otherwise><xsl:value-of select="MULTIOFERTAS/LP_NOMBRE"/></xsl:otherwise>
				</xsl:choose>
			</h1>
			-->
			<br/>
			<!--<table class="infoTable" border="0">-->
			<table class="buscador">
				<tr class="sinLinea">
					<td class="labelRight">
					<xsl:choose>
					<xsl:when test="MULTIOFERTAS/CENTRALCOMPRAS">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_entrega']/node()"/>:&nbsp;
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='entregar_en']/node()"/>:&nbsp;
					</xsl:otherwise>
					</xsl:choose>
					</td>

					<td class="cuarenta">
						<p class="textleft">
						<xsl:choose>
						<xsl:when test="MULTIOFERTAS/CENTRALCOMPRAS">
							<select name="IDCENTRO" onChange="inicializarDesplegableCentros(this.value);"/>
						</xsl:when>
						<xsl:otherwise>
							<input type="hidden" name="IDCENTRO" value="{/Generar/IDCENTRO}"/>
						</xsl:otherwise>
						</xsl:choose>
							<select name="IDLUGARENTREGA" onChange="ActualizarTextoLugarEntrega(this.value);"/>
						</p>
					</td>

					<td class="labelRight">
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

					<td class="labelRight">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='entrega']/node()"/>:
					</td>

					<td>
						<p style="width:70px; float:left; margin-top:5px;">
							<xsl:call-template name="field_funcion">
								<xsl:with-param name="path" select="field[@name='COMBO_ENTREGA']"/>
								<xsl:with-param name="IDAct" select="COMBO_ENTREGA"/>
								<xsl:with-param name="cambio">calculaFecha('ENTREGA',this.options[this.selectedIndex].value);/*habilitarDeshabilitarCampo(this);*/</xsl:with-param>
								<xsl:with-param name="valorMinimo" select="MULTIOFERTAS/MULTIOFERTAS_ROW/LP_PLAZOENTREGA"/>
								<xsl:with-param name="claSel">peq</xsl:with-param>
							</xsl:call-template>
						</p>
						<p style="width:100px; float:left; font-size:12px;">
							<script type="text/javascript">
								calFechaEntrega.dateFormat="d/M/yyyy";
								calFechaEntrega.labelCalendario='fecha de entrega';
								calFechaEntrega.minDate=new Date(formatoFecha(calculaFechaCalendarios('<xsl:value-of select="MULTIOFERTAS/MULTIOFERTAS_ROW/LP_PLAZOENTREGA"/>'),'E','I'));
								calFechaEntrega.writeControl();
							</script>
						</p>
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
			<!--	Quitamos el pie de p�gina con los datos de contacto de MVM
			<table class="encuesta" border="0">
			<table class="buscador" border="0">
			<tfoot>
				<tr class="sinLinea">
					<td colspan="5">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='para_dudas_contactar_tel']/node()"/>
					</td>
				</tr>
			</tfoot>
			</table>-->
		</div>
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
	<!--
	<table border="0" class="infoTable">
	<thead>
		<tr>
			<td class="paddingLeft datosLeft">
				<label><xsl:value-of select="$preparar"/></label>
			</td>
			<td rowspan="2">&nbsp;</td>
			<td><a href="javascript:window.print();"><img src="http://www.newco.dev.br/images/imprimir.gif" alt="Imprimir" title="Imprimir" /><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		</tr>
	</thead>
	</table>
	-->
	
	<br/>
	<label><xsl:value-of select="$preparar"/></label>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<label><xsl:value-of select="document($doc)/translation/texts/item[@name='vendedor']/node()"/>:&nbsp;</label>
	<xsl:choose>
	<xsl:when test="/Generar/MULTIOFERTAS/CAMBIARVENDEDOR">
		<xsl:call-template name="desplegable">
        	<xsl:with-param name="path" select="VENDEDORES/field"/>
        	<xsl:with-param name="nombre">IDVENDEDOR_<xsl:value-of select="MO_ID"/></xsl:with-param>
        	<xsl:with-param name="onChange">javascript:CambioVendedor(<xsl:value-of select="MO_ID"/>);</xsl:with-param>
    	</xsl:call-template>&nbsp;			
		<span id="spDatosVendedor_{MO_ID}"  style="display:none;">
			<input type="checkbox" class="muypeq" name="cbTodos"/><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/>&nbsp;
        	<a class="btnDestacadoPeq" id="btnGuardarVendedor" href="javascript:GuardarVendedor({MO_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
    	</span>
    	<img id="imgVendedorOK_{MO_ID}" src="http://www.newco.dev.br/images/check.gif" style="display:none;"/>
		<img id="imgVendedorKO_{MO_ID}" src="http://www.newco.dev.br/images/error.gif" style="display:none;"/>
	</xsl:when>
	<xsl:otherwise>
		<xsl:value-of select="VENDEDOR"/>
	</xsl:otherwise>
	</xsl:choose>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<label><xsl:value-of select="document($doc)/translation/texts/item[@name='forma_pago']/node()"/>:&nbsp;</label>
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
    	</xsl:call-template>&nbsp;
		<span id="spFormaPago_{MO_ID}"  style="display:none;">
		<!--<input type="checkbox" class="muypeq" name="cbFormaPagoTodos"/><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/>&nbsp;-->
    	<a class="btnDestacadoPeq" id="btnGuardarFormaPago{MO_ID}" href="javascript:GuardarFormaPago({MO_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
    	</span>
		<img id="imgFormaPagoOK_{MO_ID}" src="http://www.newco.dev.br/images/check.gif" style="vertical-align:text-bottom;display:none;"/>
		<img id="imgFormaPagoKO_{MO_ID}" src="http://www.newco.dev.br/images/error.gif" style="vertical-align:text-bottom;display:none;"/>
		</xsl:when>
	<xsl:otherwise>
		<xsl:value-of select="FORMAPAGO"/>.&nbsp;
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_pago']/node()"/>:&nbsp;</label>
		<xsl:value-of select="PLAZOPAGO"/>
	</xsl:otherwise>
	</xsl:choose>
	<input type="hidden" name="IDFORMAPAGO" value="{CEN_IDFORMAPAGO}"/>
	<input type="hidden" name="IDPLAZOPAGO" value="{CEN_IDPLAZOPAGO}"/>
	<br/>
	<br/>

	<!--tabla pedido rows-->
	<!--<table class="encuesta">-->
	<table class="buscador">
	<thead>
		<!--<tr class="titulosNoAlto">-->
		<tr class="subTituloTabla">
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
							<!--es viamed5 ense�o sin grupo-->
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
							<!--es viamed nuevo ense�o sin familia-->
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
	</table><!--fin tabla productos-->

	<!--PARTE DE ABAJO-->
	<xsl:if test="$OcultarPrecioReferencia='S' or ($OcultarPrecioReferencia='N' and $nuevoModeloNegocio = 'S')">
		<div class="divleft sombra">
			<p>&nbsp;</p>
			<p style="text-align:right; margin-right:15px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='comision_mvm_iva']/node()"/></p>
		</div><!--fin di divleft-->
	</xsl:if>
		<p>&nbsp;</p>

	<!--A�ADIMOS PRODUCTOS MANUALES, NO EN PLANTILLA-->
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
		<!--A�ADIMOS TABLA DE PRODUCTOS MANUALES, NO EN PLANTILLA-->
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
		</table><!--fin de tabla a�adir prod no en plantilla-->

		<!--a�adir nuevo producto no en plantilla-->
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
				<td class="dies"><a href="javascript:AnadirProductosManuales();"><img src="http://www.newco.dev.br/images/botonAnadir.gif" alt="A�adir" /></a></td>
				<td>&nbsp;</td>
			</tr>

			<!--mensajeJS-->
			<input type="hidden" name="ERROR_INSERTAR_DATOS" value="{document($doc)/translation/texts/item[@name='error_insertar_datos']/node()}"/>
			<input type="hidden" name="ERROR_ELIMINAR_DATOS" value="{document($doc)/translation/texts/item[@name='error_eliminar_datos']/node()}"/>
			<input type="hidden" name="TODOS_CAMPOS_OBLI" value="{document($doc)/translation/texts/item[@name='todos_campos_obli']/node()}"/>
		</tbody>
		</table><!--fin de a�adir nuevo producto no en plantilla-->
	</div><!--fin de divProductosManuales-->

	<xsl:if test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/REQUIERE_DATOS_PACIENTE">
		<table class="buscador" style="margin-top:40px;">
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
	<table class="encuesta gris" border="0" style="margin-top:40px;">
	<!-- Comentarios y Totales -->
	<tfoot>
	<xsl:if test="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/MO_OBSERVACIONES != ''">
		<tr>
			<td class="dos">&nbsp;</td>
			<td colspan="6">
				<p style="margin-bottom:5px;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones_pedidos']/node()"/>:</strong></p>
				<p style="margin-bottom:10px;border:1px solid #666;padding:2px;"><xsl:copy-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/MO_OBSERVACIONES" /></p>
			</td>
			<td>&nbsp;</td>
		</tr>
	</xsl:if>

		<tr>
			<td rowspan="4" class="dos">&nbsp;</td>
			<td rowspan="4" colspan="2" class="trenta">
			<xsl:choose>
			<xsl:when test="/Generar/MULTIOFERTAS/MINIMALISTA">
				<!--si usuario minimalista no veo comentarios-->
				<textarea name="COMENTARIO_{MO_ID}" cols="60" rows="5" style="display:none;"><xsl:value-of select="COMENTARIOPORDEFECTO/COMENTARIO"/></textarea>
			</xsl:when>
			<xsl:otherwise>
				<!--comentarios-->
				<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='puede_anadir_sus_comentarios']/node()"/></strong><br/>
				(<xsl:call-template name="botonPersonalizado">
					<xsl:with-param name="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_comentarios']/node()"/></xsl:with-param>
					<xsl:with-param name="status">Comentarios</xsl:with-param>
					<xsl:with-param name="funcion">ultimosComentarios('COMENTARIO_<xsl:value-of select="MO_ID"/>','Principal','MULTIOFERTAS');</xsl:with-param>
				</xsl:call-template>)
				<br/>
				<textarea name="COMENTARIO_{MO_ID}" cols="60" rows="5"><xsl:value-of select="COMENTARIOPORDEFECTO/COMENTARIO"/></textarea>
			</xsl:otherwise>
			</xsl:choose>
			</td>
			<td rowspan="4" class="dos">&nbsp;</td>
			<td rowspan="4" class="cuarenta">&nbsp;
				<p>
				<!--si usuario minimalista no pedido urgente-->
				<xsl:choose>
				<xsl:when test="/Generar/MULTIOFERTAS/MINIMALISTA">
					<input type="hidden" name="URGENTE_{MO_ID}"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="checkbox" name="URGENTE_{MO_ID}"/>&nbsp;
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_muy_urgente']/node()"/></strong>
				</xsl:otherwise>
				</xsl:choose>
				</p>
				<p>&nbsp;</p>
				<xsl:choose>
				<xsl:when test="/Generar/MULTIOFERTAS/OCULTAR_CODIGO_PEDIDO">
					<input type="hidden" name="NUMERO_OFERT_PED_{MO_ID}" value="{MO_NUMEROCLINICA}"/>
				</xsl:when>
				<xsl:otherwise>
					<p>
						<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='numero_pedido_interno']/node()"/>:&nbsp;</span>
						<input type="text" size="20" maxlength="100" name="NUMERO_OFERT_PED_{MO_ID}" value="{MO_NUMEROCLINICA}"/>
					</p>
				</xsl:otherwise>
				</xsl:choose>
				
				<input type="hidden" name="SolicitaComercial{MO_ID}" value="no"/>
				<input type="hidden" name="SolicitaMuestra{MO_ID}" value="no"/>
				<input type="hidden" name="NoComercial{MO_ID}" value="no"/>
				<p>
					<input type="hidden" name="CADENA_DOCUMENTOS"/>
					<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
					<input type="hidden" name="BORRAR_ANTERIORES"/>
					<input type="hidden" name="ID_USUARIO" value="{SOLICITUD/IDUSUARIO}"/>
					<input type="hidden" name="IDEMPRESA" id="IDEMPRESA" value="{SOLICITUD/IDEMPRESAUSUARIO}"/>
					<input type="hidden" name="TIPO_DOC_DB" id="TIPO_DOC_DB" value="DOCPEDIDO"/>
					<input type="hidden" name="TIPO_DOC_HTML" id="TIPO_DOC_HTML" value="DOCPEDIDO"/>
					<br/><xsl:value-of select="document($doc)/translation/texts/item[@name='Adjuntar_documento']/node()"/>:&nbsp;<br/>
					<input id="inputFileDoc" name="inputFileDoc" type="file" onChange="javascript:cargaDoc();"/>
					<span id="docBox" style="display:none;" align="center"></span>&nbsp;
					<span id="borraDoc" style="display:none;" align="center"></span>
					<!--frame para los documentos-->
					<div id="uploadFrameBox" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>
					<div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>
				</p>
				<div id="waitBoxDoc" align="center">&nbsp;</div>
				<input type="hidden" name="IDDOCUMENTO" id="IDDOCUMENTO" value=""/>
			</td>
			<td colspan="2">&nbsp;</td>
		</tr>
			

	<!--	2jun10	para el nuevo modelo de negocio no mostramos subtotal, para el viejo si (asisa si que ve)	-->
	<xsl:choose>
	<xsl:when test="$nuevoModeloNegocio = 'N'">
		<tr>
			<td class="dies" align="right">
				<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='subtotal']/node()"/>:</strong>&nbsp;
			</td>

			<td align="right">
			<xsl:choose>
			<xsl:when test="MO_IMPORTETOTAL[.='']">
				<input type="text" size="12" maxlength="12" class="noinput" style="text-align:right;" name="MO_IMPORTETOTAL_{MO_ID}" value="Por definir" onFocus="this.blur();"/>&nbsp;
			</xsl:when>
			<xsl:otherwise>
				<input type="text" size="12" maxlength="12" class="noinput" style="text-align:right;" name="MO_IMPORTETOTAL_{MO_ID}" value="{MO_IMPORTETOTAL}" onFocus="this.blur();"/>&nbsp;
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

	<!--	2jun10	para el nuevo modelo de negocio, no mostramos IVA, ya est� incluido en el total-->
	<xsl:choose>
	<xsl:when test="$nuevoModeloNegocio = 'N'"><!--modelo viejo-->
		<!--choose si es brasil no ense�o, solo modelo nuevo en brasil-->
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

			<tr>
				<td class="dies" align="right">
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='trasporte']/node()"/>:</strong>&nbsp;
				</td>
				<td align="right">
					<input type="text" class="noinput" name="COSTE_LOGISTICA_{MO_ID}" size="8" maxlength="12" style="text-align:right;" value="{/Generar/COSTE_LOGISTICA}"/>&nbsp;
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
			<input type="hidden" name="COSTE_LOGISTICA_{MO_ID}" value="0"/>

			<tr>
				<td class="dies" align="right">
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='importe_iva']/node()"/>:</strong>&nbsp;
				</td>

				<td align="right">
				<xsl:choose>
				<xsl:when test="MO_IMPORTEIVA[.='']">
					<input type="text" size="12" maxlength="12" class="noinput" style="text-align:right;" name="MO_IMPORTEIVA_{MO_ID}" value="Por definir" onFocus="this.blur();"/>&nbsp;
				</xsl:when>
				<xsl:otherwise>
					<input type="text" size="12" maxlength="12" class="noinput" style="text-align:right;" name="MO_IMPORTEIVA_{MO_ID}" value="{MO_IMPORTEIVA}" onFocus="this.blur();"/>&nbsp;
				</xsl:otherwise>
				</xsl:choose>
				</td>
				<!--
				<td class="tres">
				<xsl:choose>
				<xsl:when test="MO_IMPORTEIVA[.='']">
					&nbsp;
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/Generar/MULTIOFERTAS/MULTIOFERTAS_ROW/DIVISA/SUFIJO"/>
				</xsl:otherwise>
				</xsl:choose>
				</td>
				-->
			</tr>
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
		<tr>
			<td class="dies" align="right">
				<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='importe_total']/node()"/>:</strong>&nbsp;
			</td>

			<!--	6jul10 Este codigo reemplaza al comentado a continuaci�n	-->
			<td align="right">
			<xsl:choose>
			<!--ASISA Y BRASIL VIEJO MODELO PRECIO PROV SIN IVA-->
			<xsl:when test="($nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N' and not(/Generar/MULTIOFERTAS/MOSTRAR_PRECIO_CON_IVA)) or /Generar/MULTIOFERTAS/IDPAIS = '55'">
				<xsl:choose>
				<xsl:when test="MO_IMPORTETOTAL[.='']">
					<input type="text" size="12" maxlength="12" class="noinput" style="text-align:right; color:#000000;" name="MO_IMPORTEFINAL_{MO_ID}" value="Por definir" onFocus="this.blur();"/>&nbsp;
				</xsl:when>
				<xsl:otherwise>
					<input type="text" size="12" maxlength="12" class="noinput" style="text-align:right; color:#000000;" name="MO_IMPORTEFINAL_{MO_ID}" value="{MO_IMPORTETOTAL}" onFocus="this.blur();"/>&nbsp;
				</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!--VIAMED NUEVO VIEJO MODELO PERO VEO PRECIO PROV CON IVA-->
			<xsl:when test="$nuevoModeloNegocio = 'N' and $pedidoAntiguo = 'N' and /Generar/MULTIOFERTAS/MOSTRAR_PRECIO_CON_IVA">
				<xsl:choose>
				<xsl:when test="MO_IMPORTETOTAL[.='']">
					<input type="text" size="12" maxlength="12" class="noinput" style="text-align:right; color:#000000;" name="MO_IMPORTEFINAL_{MO_ID}" value="Por definir" onFocus="this.blur();"/>&nbsp;
				</xsl:when>
				<xsl:otherwise>
					<input type="text" size="12" maxlength="12" class="noinput" style="text-align:right; color:#000000;" name="MO_IMPORTEFINAL_{MO_ID}" value="{MO_IMPORTETOTAL}" onFocus="this.blur();"/>&nbsp;
				</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!--NUEVO MODELO VIEJO PEDIDO alicante...PRECIO FINAL-->
			<xsl:when test="$nuevoModeloNegocio = 'S' and $pedidoAntiguo = 'S'">
				<xsl:choose>
				<xsl:when test="MO_IMPORTEFINAL[.='']">
					<input type="text" size="12" maxlength="12" class="noinput" style="text-align:right; color:#000000;" name="MO_IMPORTEFINAL_{MO_ID}" value="Por definir" onFocus="this.blur();"/>&nbsp;
				</xsl:when>
				<xsl:otherwise>
					<input type="text" size="12" maxlength="12" class="noinput" style="text-align:right; color:#000000;" name="MO_IMPORTEFINAL_{MO_ID}" value="{MO_IMPORTEFINAL}" onFocus="this.blur();"/>&nbsp;
				</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!--NUEVO MODELO NUEVO PEDIDO - PARA VIAMED VIEJO, VENDRELL...VEO PRECIO FINAL-->
			<xsl:when test="$nuevoModeloNegocio = 'S' and $pedidoAntiguo = 'N'">
				<xsl:choose>
				<xsl:when test="MO_IMPORTEFINAL[.='']">
					<input type="text" size="12" maxlength="12" class="noinput" style="text-align:right; color:#000000;" name="MO_IMPORTEFINAL_{MO_ID}" value="Por definir" onFocus="this.blur();"/>&nbsp;
				</xsl:when>
				<xsl:otherwise>
					<input type="text" size="12" maxlength="12" class="noinput" style="text-align:right; color:#000000;" name="MO_IMPORTEFINAL_{MO_ID}" value="{MO_IMPORTEFINAL}" onFocus="this.blur();"/>&nbsp;
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

	<xsl:choose>
	<xsl:when test="$OcultarPrecioReferencia='N'"></xsl:when>
	<xsl:otherwise>
		<tr><td colspan="4">&nbsp;</td></tr>
		<tr><td colspan="4">&nbsp;</td></tr>
	</xsl:otherwise>
	</xsl:choose>

		<tr><td colspan="4">&nbsp;</td></tr>
		<tr><td colspan="4">&nbsp;</td></tr>
	</tfoot>
	</table>
</xsl:for-each>
</xsl:template>

<!--lineas de productos-->
<xsl:template match="LINEASMULTIOFERTA_ROW">
	<xsl:param name="OcultarPrecioReferencia"/>
	<xsl:param name="nuevoModeloNegocio"/>
	<xsl:param name="pedidoAntiguo"/>

	<xsl:variable name="lang"><xsl:value-of select="/Generar/LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>

	<tr>
		<!-- ref mvm-->
		<td align="left">
			&nbsp;
		<xsl:choose>
		<xsl:when test="LMO_CATEGORIA = 'F'">
			<xsl:choose>
			<xsl:when test="REFERENCIACLIENTE != ''">
				<xsl:value-of select="REFERENCIACLIENTE"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="PRO_REFERENCIA"/>
			</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:when test="LMO_CATEGORIA = 'N'">
			<xsl:choose>
			<xsl:when test="REFERENCIACLIENTE != ''">
				<xsl:value-of select="REFERENCIACLIENTE"/>
			</xsl:when>
			<xsl:when test="REFERENCIAPRIVADA!=''">
				<xsl:value-of select="REFERENCIAPRIVADA"/>
			</xsl:when>
			</xsl:choose>
		</xsl:when>
		</xsl:choose>
		</td>

		<!-- nombre producto link -->
		<td class="textLeft" style="padding-left:5px;">
		<xsl:choose>
		<xsl:when test="NOMBREPRIVADO!=''">
			<a style="text-decoration:none;">
				<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="LMO_IDPRODUCTO"/>&amp;SES_ID=<xsl:value-of select="//SES_ID"/>','producto',100,80,0,0)</xsl:attribute>
				<!--<span class="strongAzul"><xsl:value-of select="NOMBREPRIVADO"/></span>-->
				<xsl:value-of select="NOMBREPRIVADO"/>
			</a>
		</xsl:when>
		<xsl:otherwise>
			<a style="text-decoration:none;">
				<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="LMO_IDPRODUCTO"/>&amp;SES_ID=<xsl:value-of select="//SES_ID"/>','producto',100,80,0,0)</xsl:attribute>
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
		<!--
		<xsl:choose>
		<xsl:when test="/Generar/MULTIOFERTAS/SIN_MARCA"></xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="PRO_MARCA"/>
		</xsl:otherwise>
		</xsl:choose>
		-->
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
		<xsl:attribute name="onMouseOver">window.status='Informaci�n sobre la empresa.';return true;</xsl:attribute>
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
