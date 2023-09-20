<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Página de inicio
	Ultima revisión ET: 20dic22 17:05 WFStatus_310522.js cargaDocAlbaran_251019.js-> deberia ser opcional, mantenemos durante un tiempo
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

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

 	<script type="text/javascript" src="http://www.newco.dev.br/Personal/BandejaTrabajo/WFStatus_310522.js"></script>
    <script type="text/javascript" src="http://www.newco.dev.br/Personal/BandejaTrabajo/cargaDocAlbaran_251019.js"></script><!--deberia ser opcional, mantenemos durante un tiempo-->

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

		//	30may22 Presentamos "alert" con noticias
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

	<form  method="post" name="Form1" id="Form1" action="WFStatusSave.xsql">
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
        <xsl:call-template name="estiloIndip"/>		
		
		<!--	9ene20 No parece necesario
		<xsl:apply-templates select="INICIO/CABECERAS"/>
		-->
		
		<div class="divLeft">
		<!--<xsl:choose>
		<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR">-->
			<!--cliente o admin en el when and INICIO/PEDIDOSPROBLEMATICOS/TOTAL != '0'-->
			<!-- 26may16	<xsl:if test="INICIO/CUADRO_AVANZADO or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN = 'MVM' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN = 'MVMB'">-->
			<xsl:choose>
				<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR and (INICIO/CUADRO_AVANZADO or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PERMITIR_CONTROL_PEDIDOS)">
					<xsl:call-template name="ADMIN"/>
				</xsl:when>

				<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR and not(INICIO/CUADRO_AVANZADO) and not (INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PERMITIR_CONTROL_PEDIDOS)">
				<!--<xsl:when test="not(INICIO/CUADRO_AVANZADO) and (INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN = 'EMPRESA' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN = 'MULTICENTROS' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN = '' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN = 'NORMAL' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN = 'CENTRO')">-->
					<xsl:call-template name="CLIENTE"/>
				</xsl:when>

				<!--proveedor-->
				<xsl:otherwise>
					<xsl:apply-templates select="INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR"/>
				</xsl:otherwise>
			</xsl:choose>
		<!--</xsl:when>
		</xsl:choose>-->
		</div>

    <!--<xsl:choose>
    <!- -si es proveedores no enseï¿½o footer- ->
    <xsl:when test="INICIO/PORTAL/PMVM_ID = 'ClLi'">&nbsp;</xsl:when>
    <xsl:otherwise>
		<!- -4dic18 En el pie de página de contacto únicamente dejamos el email	- ->
      <div class="divLeft contacto">
		<br/>
		<br/>
		<br/>
		<br/>
        <p class="contact">
			<br/>
			<xsl:value-of select="document($doc)/translation/texts/item[@name='para_contactar']/node()"/>:&nbsp;
			<!- -
			<xsl:value-of select="document($doc)/translation/texts/item[@name='tel_num']/node()"/>
			<xsl:if test="LANG != 'portugues'">
				&nbsp;|&nbsp;
				<xsl:value-of select="document($doc)/translation/texts/item[@name='fax_num']/node()"/>
			</xsl:if>&nbsp;|&nbsp;
			<xsl:value-of select="document($doc)/translation/texts/item[@name='email']/node()"/>:&nbsp;
			- ->
			<a>
				<xsl:attribute name="href">mailto:<xsl:value-of select="INICIO/PORTAL/PMVM_MAIL_COMERCIAL"/></xsl:attribute>
				<xsl:value-of select="INICIO/PORTAL/PMVM_MAIL_COMERCIAL"/>
			</a>
        </p>

        <!- -<p class="derechos">- ->
        <p class="contact">
          <xsl:value-of select="document($doc)/translation/texts/item[@name='marca_registrada']/node()"/>&nbsp;
          <xsl:value-of select="INICIO/PORTAL/PMVM_NOMBRE"/>&nbsp;
          <xsl:value-of select="document($doc)/translation/texts/item[@name='derechos_reservados']/node()"/>
        </p>
		- ->
      </div>
	  <!- -fin divLeft contacto- ->
    </xsl:otherwise>
    </xsl:choose>-->
	
	
	
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
	<table class="Indicadores" width="100%" style="border:0px;">
	<xsl:if test="/WorkFlowPendientes/INICIO/SOLOPEDIDOS='N' and (INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN='MVM' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN='CDC' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN='EMPRESA' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN='MULTICENTROS')">
		<tr style="height:30px;font-size: 15px;text-align:center;background-color:#white;">
			<xsl:choose>
			<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDEMPRESA">
				<th colspan="3">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:&nbsp;
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDEMPRESA/field"/>
						<xsl:with-param name="onChange">javascript:cbEmpresaChange();</xsl:with-param>
						<xsl:with-param name="style">font-size:15px;width:300px;background-color:#white;</xsl:with-param>
					</xsl:call-template>
				</th>
			</xsl:when>
			<xsl:otherwise>
				<input type="hidden" name="IDEMPRESA" value="{IDEMPRESA}" />
			</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
			<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDCENTRO">
				<th colspan="3">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDCENTRO/field"/>
						<xsl:with-param name="onChange">javascript:cbEmpresaChange();</xsl:with-param>
						<xsl:with-param name="style">font-size:15px;width:300px;background-color:#white;</xsl:with-param>
					</xsl:call-template>
				</th>
			</xsl:when>
			<xsl:otherwise>
				<th colspan="3">&nbsp;</th>
			</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="not(INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDEMPRESA)">
				<th colspan="3">&nbsp;</th>
			</xsl:if>
		</tr>
	</xsl:if>
	<xsl:if test="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/PEDIDOS">
		<tr><td>&nbsp;</td></tr>
		<tr style="height:70px;text-align:center;" class="conhover">
		<td width="10%" class="IndicadorInicio" onclick="javascript:IndicadorPedidos('ENTREGASHOY');">
			<span style="font-size: 15px;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='entregas_hoy']/node()"/>&nbsp;</span><br/>
			<span style="font-size: 25px;color:green;"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/ENTREGAS_HOY"/></span><br/>
			<span style="font-size: 20px;color:green;"><xsl:value-of select="INICIO/DIVISA/PREFIJO"/><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/ENTREGAS_HOY_IMPORTE"/><xsl:value-of select="INICIO/DIVISA/SUFIJO"/></span>
		</td>
		<td width="10%" class="IndicadorInicio" onclick="javascript:IndicadorPedidos('PEDIDOSACEPTAR');">
			<span style="font-size: 15px;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_pend_aceptar']/node()"/>&nbsp;</span><br/>
			<span style="font-size: 25px;color:green;"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_PEND_ACEPTAR"/></span><br/>
			<span style="font-size: 20px;color:green;"><xsl:value-of select="INICIO/DIVISA/PREFIJO"/><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_PEND_ACEPTAR_IMPORTE"/><xsl:value-of select="INICIO/DIVISA/SUFIJO"/></span>
		</td>
		<td width="10%" class="IndicadorInicio" onclick="javascript:IndicadorPedidos('PEDIDOSHOY');">
			<span style="font-size: 15px;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_12h']/node()"/>&nbsp;</span><br/>
			<span style="font-size: 25px;color:green;"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/PEDIDOS"/></span><br/>
			<span style="font-size: 20px;color:green;"><xsl:value-of select="INICIO/DIVISA/PREFIJO"/><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/PEDIDOS_IMPORTE"/><xsl:value-of select="INICIO/DIVISA/SUFIJO"/></span>
		</td>
		<td width="10%" class="IndicadorInicio" onclick="javascript:IndicadorPedidos('PEDIDOSPENDIENTES');">
			<span style="font-size: 15px;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_pendientes']/node()"/>&nbsp;</span><br/>
			<span style="font-size: 25px;color:green;"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_PENDIENTES"/></span><br/>
			<span style="font-size: 20px;color:green;"><xsl:value-of select="INICIO/DIVISA/PREFIJO"/><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_PEND_IMPORTE"/><xsl:value-of select="INICIO/DIVISA/SUFIJO"/></span>
		</td>
		<xsl:if test="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_PREPAGO>0">
			<td width="10%" class="IndicadorInicio" onclick="javascript:IndicadorPedidos('PEDIDOSPREPAGO');">
				<span style="font-size: 15px;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_prepago']/node()"/>&nbsp;</span><br/>
				<span style="font-size: 25px;color:green;"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_PREPAGO"/></span><br/>
				<span style="font-size: 20px;color:green;"><xsl:value-of select="INICIO/DIVISA/PREFIJO"/><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_PREP_IMPORTE"/><xsl:value-of select="INICIO/DIVISA/SUFIJO"/></span>
			</td>
		</xsl:if>
		<td width="10%" class="IndicadorInicio" onclick="javascript:IndicadorPedidos('PEDIDOS30DIAS');">
			<span style="font-size: 15px;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_30d']/node()"/>&nbsp;</span><br/>
			<span style="font-size: 25px;color:green;"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS"/></span><br/>
			<span style="font-size: 20px;color:green;"><xsl:value-of select="INICIO/DIVISA/PREFIJO"/><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_IMPORTE"/><xsl:value-of select="INICIO/DIVISA/SUFIJO"/></span>
		</td>
		<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN='MVM' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN='EMPRESA'">
			<td width="10%" class="IndicadorInicio" onclick="javascript:IndicadorPedidos('PEDIDOSRETRASADOS');">
				<span style="font-size: 15px;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_retr_30d']/node()"/>&nbsp;</span><br/>
				<span style="font-size: 25px;color:red;"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_RETRASADOS"/></span><br/>
				<span style="font-size: 20px;color:red;"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_RETRASADOS_PORC"/>%</span>
			</td>
		</xsl:if>
		<td width="10%" class="IndicadorInicio" onclick="javascript:IndicadorPedidos('PEDIDOSURGENTES');">
			<span style="font-size: 15px;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_urg_30d']/node()"/>&nbsp;</span><br/>
			<span style="font-size: 25px;color:red;"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_URGENTES"/></span><br/>
			<span style="font-size: 20px;color:red;"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_URGENTES_PORC"/>%</span>
		</td>
		<td width="10%" class="IndicadorInicio" onclick="javascript:IndicadorPedidos('PEDIDOSPARCIALES');">
			<span style="font-size: 15px;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_parc_30d']/node()"/>&nbsp;</span><br/>
			<span style="font-size: 25px;color:red;"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_PARCIALES"/></span><br/>
			<span style="font-size: 20px;color:red;"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/PEDIDOS_PARCIALES_PORC"/>%</span>
		</td>
		<xsl:if test="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/CONTROLPEDIDOS_USUARIO>0">
			<td width="10%" class="IndicadorInicio" onclick="javascript:IndicadorPedidos('CONTROLESUSUARIOHOY');">
				<span style="font-size: 15px;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='gestiones_usuario_12h']/node()"/>&nbsp;</span><br/>
				<span style="font-size: 25px;color:green;"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/CONTROLPEDIDOS_USUARIO"/></span><br/>
				<span style="font-size: 20px;color:green;"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/CONTROLPEDIDOS_USUARIO_PORC"/>% (<xsl:value-of select="document($doc)/translation/texts/item[@name='del_equipo']/node()"/>)</span>
			</td>
		</xsl:if>
		<xsl:if test="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/LICITACIONES_ACTIVAS=0">
			<td width="10%" class="IndicadorInicio" onclick="javascript:IndicadorPedidos('CONTROLESEQUIPOHOY');">
				<span style="font-size: 15px;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='gestiones_equipo_12h']/node()"/>&nbsp;</span><br/>
				<span style="font-size: 40px;color:green;"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/CONTROLPEDIDOS_EQUIPO"/></span><br/>
			</td>
		</xsl:if>
		</tr>
		<xsl:if test="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/LICITACIONES_ACTIVAS=0">
			<tr><td>&nbsp;</td></tr>
		</xsl:if>
	</xsl:if>
	<xsl:if test="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/LICITACIONES_ACTIVAS>0">
		<tr style="height:70px;text-align:center;">
		<td class="IndicadorInicio" onclick="javascript:IndicadorLicitaciones('ACTIVAS');">
			<span style="font-size: 15px;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_activas']/node()"/>&nbsp;</span><br/>
			<span style="font-size: 25px;color:green;"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/LICITACIONES_ACTIVAS"/></span><br/>
		</td>
		<td class="IndicadorInicio" onclick="javascript:IndicadorLicitaciones('CERRARHOY');">
			<span style="font-size: 15px;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_vencen_hoy']/node()"/>&nbsp;</span><br/>
			<span style="font-size: 25px;color:green;"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/LICITACIONES_VENCENHOY"/></span><br/>
		</td>
		<td class="IndicadorInicio" onclick="javascript:IndicadorLicitaciones('NOINICIADAS');">
			<span style="font-size: 15px;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_no_iniciadas']/node()"/>&nbsp;</span><br/>
			<span style="font-size: 25px;color:green;"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/LICITACIONES_NOINICIADAS"/></span><br/>
		</td>
		<td class="IndicadorInicio" onclick="javascript:IndicadorLicitaciones('PEDIDOSPENDIENTES');">
			<span style="font-size: 15px;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_pedidos_pendientes']/node()"/>&nbsp;</span><br/>
			<span style="font-size: 25px;color:green;"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/LICITACIONES_PEDIDOSPEND"/></span><br/>
		</td>
		<td class="IndicadorInicio" onclick="javascript:IndicadorLicitaciones('URGENTES');">
			<span style="font-size: 15px;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_urgentes']/node()"/>&nbsp;</span><br/>
			<span style="font-size: 25px;color:green;"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/LICITACIONES_URGENTES"/></span><br/>
		</td>
		<td class="IndicadorInicio" onclick="javascript:IndicadorLicitaciones('1DIA');">
			<span style="font-size: 15px;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_12h']/node()"/>&nbsp;</span><br/>
			<span style="font-size: 25px;color:green;"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/LICITACIONES"/></span><br/>
		</td>
		<td class="IndicadorInicio" onclick="javascript:IndicadorLicitaciones('30DIAS');">
			<span style="font-size: 15px;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_30d']/node()"/>&nbsp;</span><br/>
			<span style="font-size: 25px;color:green;"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC/LICITACIONES"/></span><br/>
		</td>
		<td class="IndicadorInicio" onclick="javascript:IndicadorPedidos('CONTROLESEQUIPOHOY');">
			<span style="font-size: 15px;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='gestiones_equipo_12h']/node()"/>&nbsp;</span><br/>
			<span style="font-size: 40px;color:green;"><xsl:value-of select="INICIO/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/CONTROLPEDIDOS_EQUIPO"/></span><br/>
		</td>
		</tr>
		<tr><td>&nbsp;</td></tr>
	</xsl:if>

	</table>
	</div>
	<div class="divLeft boxInicio" id="pedidosBox" style="border:0px solid #939494;border-top:0;">
	<xsl:if test="INICIO/NOTICIAS/NOTICIA">
		<xsl:choose>
		<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/BLOQUEARBANDEJA">
			<div class="divLeft68" style="margin-top:15px;">
				<xsl:apply-templates select="INICIO/NOTICIAS"/>
			</div>
		</xsl:when>
		<xsl:otherwise>
			<div class="divLeft95m5" style="margin-top:15px;">
				<xsl:apply-templates select="INICIO/NOTICIAS"/>
			</div>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:if>

  <!--abonos y pedidos pendientes de confirmacion-->
  <xsl:choose>
  <xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/BLOQUEARBANDEJA"></xsl:when>
  <xsl:otherwise>
    <!--LLAMO LA TABLA CORESPONDIENTE BANDEJA DE ENTRADA-->
    <xsl:apply-templates select="INICIO/BANDEJA/COMPRAS/ABONOS/BANDEJA"/>
    <xsl:apply-templates select="INICIO/BANDEJA/COMPRAS/PEDIDOS_APROBAR/BANDEJA"/>
<!-- DC - 18nov2015     <xsl:apply-templates select="INICIO/BANDEJA/COMPRAS/PEDIDOS/BANDEJA"/>-->
    <xsl:apply-templates select="INICIO/BANDEJA/COMPRAS/PEDIDOSPROGRAMADOS_APROBAR/BANDEJA"/>
<!-- DC - 18nov2015     <xsl:apply-templates select="INICIO/BANDEJA/VENTAS/PEDIDOS/BANDEJA"/>
     <xsl:apply-templates select="INICIO/BANDEJA/VENTAS/PEDIDOSPROGRAMADOS_APROBAR/BANDEJA"/>-->
    <xsl:apply-templates select="INICIO/BANDEJA/VENTAS/ABONOS/BANDEJA"/>
<!-- DC - 18nov2015
    <xsl:apply-templates select="INICIO/BANDEJA/INCIDENCIAS/ENVIADAS/BANDEJA"/>
    <xsl:apply-templates select="INICIO/BANDEJA/INCIDENCIAS/RECIBIDAS/BANDEJA"/>
    <xsl:apply-templates select="INICIO/BANDEJA/EVALUACIONACTAS/INFORMANDO/BANDEJA"/>
    <xsl:apply-templates select="INICIO/BANDEJA/EVALUACIONACTAS/CIERRE/BANDEJA"/>
    <xsl:apply-templates select="INICIO/BANDEJA/EVALUACIONINFORMES/INFORMANDO/BANDEJA"/>
    <xsl:apply-templates select="INICIO/BANDEJA/EVALUACIONINFORMES/CIERRE/BANDEJA"/>
    <xsl:apply-templates select="INICIO/BANDEJA/NOCONFORMIDADINFORMES/INFORMANDO/BANDEJA"/>
    <xsl:apply-templates select="INICIO/BANDEJA/NOCONFORMIDADINFORMES/CIERRE/BANDEJA"/>
    <xsl:apply-templates select="INICIO/BANDEJA/SOLICITUDMUESTRAS/INFORMANDO/BANDEJA"/>
    <xsl:apply-templates select="INICIO/BANDEJA/SOLICITUDMUESTRAS/CIERRE/BANDEJA"/>
    <xsl:apply-templates select="INICIO/BANDEJA/NEGOCIACIONES/INFORMANDO/BANDEJA"/>
    <xsl:apply-templates select="INICIO/BANDEJA/NEGOCIACIONES/CIERRE/BANDEJA"/>
-->
  </xsl:otherwise>
  </xsl:choose>


	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/></span></p>
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
				<a class="btnNormal" href="javascript:DescargarExcel();"><img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel"/></a>&nbsp;
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



  <xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR">
	<input type="hidden" name="ORDEN" value="{./ORDEN}"/>
	<input type="hidden" name="SENTIDO" value="{./SENTIDO}"/>

	<input type="hidden" name="PAGINA" id="PAGINA" value="{INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PAGINA}"/>
	<table class="buscador" border="0">

		<!--	Filtros Desplegables - 18feb19 Se los quitamos a los usuarios básicos "ocultar proveedor", por ejemplo CG, excepto que sean usuarios EMPRESA 	-->
		<xsl:if test="(INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN='EMPRESA') or not(INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/OCULTAR_PROVEEDOR)">
			<tr class="filtros">
			<td colspan="20">
				<xsl:call-template name="buscadorInicioAdmin"/>
        	</td>
			</tr>
		</xsl:if>

		<tr class="subTituloTabla">
			<th class="uno">&nbsp;<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.--></th>
			<th class="zerouno">&nbsp;</th>
			<th class="seis" style="text-align:left;">
				<a href="javascript:OrdenarPor('NUMERO_PEDIDO');">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>
				</a>
			</th>
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MOSTRARCENTRO">
				<th class="quince" style="text-align:left;">
					&nbsp;<a href="javascript:OrdenarPor('CENTRO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></a>
				</th>
			</xsl:if>
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MOSTRARCENTROCONSUMO">
				<th class="quince" style="text-align:left;">
					&nbsp;<a href="javascript:OrdenarPor('CENTROCONSUMO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_consumo']/node()"/></a>
				</th>
			</xsl:if>
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/INCLUIR_COMPRADOR">
				<th class="ocho" style="text-align:left;">
					&nbsp;<a href="javascript:OrdenarPor('COMPRADOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='comprador']/node()"/></a>
				</th>
			</xsl:if>
			<xsl:if test="not(INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/OCULTAR_PROVEEDOR)">
				<th class="quince" style="text-align:left;">
					&nbsp;<a href="javascript:OrdenarPor('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a>
				</th>
			</xsl:if>
			<th class="cinco" style="text-align:left;">
				<a href="javascript:OrdenarPor('FECHA_EMISION');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></a>
			</th>
			<th class="cinco" style="text-align:left;">
				<a href="javascript:OrdenarPor('FECHA_ENVIADO_DIA');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='entrega']/node()"/></a>
			</th>
			<th class="cuatro" style="text-align:left;">
				<a href="javascript:OrdenarPor('ESTADO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></a>
			</th>
			<!--<th class="dos">
				<a href="javascript:OrdenarPor('SITUACION');">Sit</a>
			</th>
			<th class="cinco">
				<a href="javascript:OrdenarPor('ALBARAN');"><xsl:value-of select="document($doc)/translation/texts/item[@name='alb']/node()"/></a>
			</th>-->
			<th class="cinco" style="text-align:right;">
				<xsl:choose>
				<xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MOSTRAR_PRECIOS_CON_IVA"><xsl:value-of select="document($doc)/translation/texts/item[@name='total_cIVA']/node()"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/></xsl:otherwise>
				</xsl:choose>
				<!--&nbsp;(<xsl:value-of select="INICIO/DIVISA/PREFIJO"/><xsl:value-of select="INICIO/DIVISA/SUFIJO"/>)-->
			</th>
			<th class="tres" style="text-align:left;">
				&nbsp;<a href="javascript:OrdenarPor('CONTROL_MVM');"><xsl:value-of select="document($doc)/translation/texts/item[@name='control']/node()"/></a>
			</th>
			<th class="seis" style="text-align:left;">
				&nbsp;<a href="javascript:OrdenarPor('FECHA_ENVIADO_DIA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='enviado']/node()"/></a>
			</th>
			<th style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios_clinica']/node()"/></th>

			<xsl:choose>
			<!--26may16	<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN = 'MVM' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN = 'MVMB'">	-->
			<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PERMITIR_CONTROL_PEDIDOS">
			<th class="nocompacto" style="display:none;text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios_internos']/node()"/></th>
			<th class="dos">
			<a href="javascript:OrdenarPor('CLINICA_AGUANTA');"> <xsl:value-of select="document($doc)/translation/texts/item[@name='ok']/node()"/></a>
			</th>
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/MVM">
				<th class="dos" style="text-align:left;">
				<a href="javascript:OrdenarPor('RIESGO');"> <xsl:value-of select="document($doc)/translation/texts/item[@name='rie']/node()"/></a>
				</th>
			</xsl:if>
			<th class="dos" style="text-align:left;">
			<a href="javascript:OrdenarPor('RECLAMACIONES');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Recl']/node()"/></a>
			</th>
			<th class="dos" style="text-align:left;">
			<a href="javascript:OrdenarPor('FECHA_RECLAMACION');"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></a>
			</th>
			<th class="tres" style="text-align:left;">
			&nbsp;<a href="javascript:OrdenarPor('RESPONSABLE_MVM');"> <xsl:value-of select="document($doc)/translation/texts/item[@name='FollowUp']/node()"/></a>
			</th>
			<th class="tres" style="text-align:left;">
			&nbsp;<a href="javascript:OrdenarPor('FECHA_MVM');"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></a>
			</th>
			<th class="uno">&nbsp;</th><!--29dic17	Reclamar	-->
			</xsl:when>
			<xsl:otherwise>
			<th class="uno">&nbsp;</th><!--29dic17	Reclamar también para usuarios con control	-->
			<th colspan="5" style="text-align:left;">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='reclamar']/node()"/></th>
			</xsl:otherwise>
			</xsl:choose>
		</tr>

		<!--SI NO HAY PEDIDOS ENSENO UN MENSAJE Y SIGO ENSENaNDO CABECERA-->
		<xsl:choose>
		<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/TOTAL = '0'">
			<tr class="lejenda"><th colspan="17"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_pedidos_para_busqueda']/node()"/></th></tr>
		</xsl:when>
		<xsl:otherwise>

		<!--el buscador hace innecesario este separador <tr class="medio" height="3px"><td class="medio" colspan="7"></td></tr>-->
		<xsl:for-each select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PEDIDO">
		<!--<tbody>-->
			<tr style="border-bottom:1px solid #A7A8A9;">
        	<xsl:attribute name="class">
        	  <xsl:choose>
        	  <xsl:when test="MO_STATUS=12">conhover fondoRojo</xsl:when>
        	  <xsl:when test="CAMBIOSMVM and CAMBIOSPROVEEDOR='S'">conhover fondoAmarillo</xsl:when>
        	  <xsl:when test="CAMBIOSMVM or CAMBIOSPROVEEDOR='S'">conhover fondoAmarillo</xsl:when>
        	  <xsl:otherwise>conhover</xsl:otherwise>
        	  </xsl:choose>
        	</xsl:attribute>

			<td>
				<xsl:attribute name="style">
					<xsl:choose>
					<xsl:when test="RECLAMACION ='S' and BLOQUEAR ='N'">background:#FF9900;</xsl:when>
					<xsl:when test="RECLAMACION ='S' and BLOQUEAR ='S'">background:#FF9900;</xsl:when>
					<xsl:when test="RECLAMACION!='S' and BLOQUEAR='S' and (/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PERMITIR_CONTROL_PEDIDOS)">background:#FE4162;</xsl:when>
					<!--<xsl:otherwise>text-align:left;</xsl:otherwise>-->
           		</xsl:choose>
				</xsl:attribute>
				<xsl:value-of select="POSICION"/>
			</td>
			<!--4nov16	tipo de pedido: ya no ponemos el icono de farmacia
			<td>
				<xsl:choose>
				<xsl:when test="CATEGORIA = 'F'"><img src="http://www.newco.dev.br/images/farmacia-icon.gif" alt="Farmacia"/></xsl:when>
				</xsl:choose>
			</td>-->
			<td>
				<xsl:choose>
				<xsl:when test="URGENTE = 'S'"><img src="http://www.newco.dev.br/images/2017/warning-red.png"/>&nbsp;</xsl:when>
				<xsl:otherwise>&nbsp;</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
				<xsl:when test="PREPAGOPENDIENTE"><img src="http://www.newco.dev.br/images/2017/icono-pago.png"/>&nbsp;</xsl:when>
				<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
			</td>
			<td class="cinco" style="text-align:left;">
				<strong><a>
					<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/<xsl:value-of select="ENLACETAREA"/>','Multioferta',100,100,0,0)</xsl:attribute>
					<xsl:value-of select="NUMERO_PEDIDO"/>
				</a></strong>
			</td>

			<xsl:if test="../MOSTRARCENTRO">
				<td class="textLeft">
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTROCLIENTE}','Centro',100,80,0,-20);">
						<xsl:value-of select="NOMBRE_CENTRO"/>
					</a>
					<xsl:if test="LUGAR_ENTREGA">
						<br/><span style="font-size:12px; color:#808080; "><xsl:value-of select="LUGAR_ENTREGA/NOMBRE"/></span>
					</xsl:if>

				</td>
			</xsl:if>

			<xsl:if test="../INCLUIR_COMPRADOR">
				<td class="textLeft">
					<xsl:value-of select="USUARIOCOMPRADOR"/>
				</td>
			</xsl:if>

			<xsl:if test="../MOSTRARCENTROCONSUMO">
				<td class="textLeft">
					<xsl:value-of select="CENTROCONSUMO"/>
				</td>
			</xsl:if>

			<xsl:if test="not(../OCULTAR_PROVEEDOR)">
				<td class="textLeft">
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDPROVEEDOR}&amp;VENTANA=NUEVA','Centro',100,80,0,-20);">
						<xsl:value-of select="PROVEEDOR"/>
					</a>
					<xsl:if test="CAMBIOSPROVEEDOR='S'">&nbsp;<img src="http://www.newco.dev.br/images/bolaAmbar.gif"/></xsl:if>
				</td>
			</xsl:if>
			<td class="tres" style="text-align:left;">
				<xsl:value-of select="FECHA_PEDIDO"/>
			</td>
			<td class="tres" style="text-align:left;">
				<xsl:choose>
				<xsl:when test="FECHA_ENTREGA_CORREGIDA != ''">
					<xsl:value-of select="FECHA_ENTREGA_CORREGIDA"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="FECHA_ENTREGA"/>
				</xsl:otherwise>
				</xsl:choose>
			</td>
			<td class="seis" style="font-style:11px;text-align:left;">
				<strong><a>
				<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/<xsl:value-of select="ENLACETAREA"/>','Multioferta',100,100,0,0)</xsl:attribute>
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
						<xsl:value-of select="document($doc)/translation/texts/item[@name='aprobar_superior']/node()"/>:<xsl:value-of select="USUARIOAPROBADOR"/>
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
        	<td style="text-align:right;">
		  		<xsl:value-of select="DIVISA/PREFIJO"/>
        	  <xsl:choose>
        	  <xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MOSTRAR_PRECIOS_CON_IVA"><xsl:value-of select="PED_TOTAL"/></xsl:when>
        	  <xsl:otherwise><xsl:value-of select="PED_SUBTOTAL"/></xsl:otherwise>
        	  </xsl:choose>
        	  <!--<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>-->
			 <!-- <xsl:value-of select="DIVISA/SUFIJO"/>-->
				<xsl:value-of select="DIVISA/SUFIJO"/>
        	</td>
        	<!--control-->
			<td class="textLeft">
        	  <!--retraso-->
        	  <xsl:choose>
        	  <xsl:when test="RETRASO &gt; 1"><img src="http://www.newco.dev.br/images/2017/clock-red.png"/>&nbsp;&nbsp;</xsl:when>
			  <xsl:otherwise><img src="http://www.newco.dev.br/images/2017/clock-blue.png"/>&nbsp;&nbsp;</xsl:otherwise>
        	  </xsl:choose>
        	  <!--situaciï¿½n-->
				<xsl:choose>
				<!--8ene19 <xsl:when test="SITUACION != '' and not(contains(ESTADO,'FINAL'))">-->
				<xsl:when test="SITUACION != ''">
					<xsl:choose>	<!-- para simplificar, los clientes ver?n la situaci?n 2 en lugar de la 1	-->
					<xsl:when test="SITUACION='-1'">
						<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>
							no se ver? m?s 3 ambar, se ver? pendiente-->
					</xsl:when>
					<xsl:when test="SITUACION='1'">
						<img src="../../images/Situacion{SITUACION}de3.gif" border="0"/>
					</xsl:when>
					<xsl:when test="SITUACION!='1' and SITUACION!='-1'">
						<img src="../../images/Situacion{SITUACION}de3.gif" border="0"/>
					</xsl:when>
					<xsl:otherwise>
						<img src="../../images/Situacion2de3.gif" border="0"/>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				</xsl:choose><!--8ene20 para pruebas <xsl:value-of select="SITUACION"/>:<xsl:value-of select="ESTADO"/>-->
			</td>
			<td><xsl:value-of select="FECHAENVIOPROVEEDOR"/></td>
			<td>
				<xsl:if test="COMENTARIOSPARACLINICA!=''">
					<xsl:variable name="len" select="string-length(COMENTARIOSPARACLINICA)"/>
					<p style="text-align:left; font-size:11px;">
						<xsl:value-of select="substring(COMENTARIOSPARACLINICA,1,58)"/>
						<xsl:if test="$len &gt; 58">...</xsl:if>

						<xsl:if test="COMENTARIOSPARACLINICA!=''">
							<xsl:variable name="len" select="string-length(COMENTARIOSPARACLINICA)"/>
							<xsl:if test="$len &gt; 58">
								&nbsp;<img src="http://www.newco.dev.br/images/info.gif">
									<xsl:attribute name="alt"><xsl:value-of select="COMENTARIOSPARACLINICA"/></xsl:attribute>
									<xsl:attribute name="title"><xsl:value-of select="COMENTARIOSPARACLINICA"/></xsl:attribute>
								</img>
							</xsl:if>
						</xsl:if>
					</p>
				</xsl:if>
			</td>

    	  <!--si es admin mvm ense?o todo, si es cdc quito columnas-->
    	  <xsl:choose>
    	  <!--26may16	<xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN = 'MVM' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN = 'MVMB'">-->
    	  <xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PERMITIR_CONTROL_PEDIDOS">
        	<td class="diez nocompacto" style="text-align:left; font-size:11px;display:none;">
				<xsl:if test="COMENTARIOSINTERNOS!=''">
					<xsl:variable name="len" select="string-length(COMENTARIOSINTERNOS)"/>
					<xsl:value-of select="substring(COMENTARIOSINTERNOS,1,58)"/>
					<xsl:if test="$len &gt; 58">...</xsl:if>

					<xsl:if test="COMENTARIOSINTERNOS!=''">
						<xsl:variable name="len" select="string-length(COMENTARIOSINTERNOS)"/>
						<xsl:if test="$len &gt; 58">
							&nbsp;<img src="http://www.newco.dev.br/images/info.gif">
								<xsl:attribute name="alt"><xsl:value-of select="COMENTARIOSINTERNOS"/></xsl:attribute>
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
        		  <a>
            		<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Personal/BandejaTrabajo/ControlRiesgo.xsql?PED_ID=<xsl:value-of select="PED_ID"/>&amp;SES_ID=<xsl:value-of select="//SES_ID"/>','ControlRiesgo',100,80,0,0)</xsl:attribute>
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
            	<strong><a>
            	  <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Personal/BandejaTrabajo/ControlPedidos.xsql?IDPEDIDO=<xsl:value-of select="PED_ID"/>','Control Pedido',100,80,0,0)</xsl:attribute>
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
            	  <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Personal/BandejaTrabajo/ControlPedidos.xsql?IDPEDIDO=<xsl:value-of select="PED_ID"/>','Control Pedido',100,80,0,0)</xsl:attribute>
            	  <xsl:value-of select="document($doc)/translation/texts/item[@name='pend']/node()"/>
            	</a></strong>
        	  </td>
        	  <td>&nbsp;</td>
        	</xsl:otherwise>
        	</xsl:choose>
    	  </xsl:if>
    		</xsl:when>
    	  <xsl:otherwise>
        	<!--si es cdc o usuario cuadro avanzado puede reclamar
        	<td colspan="6" class="uno">
        	  <a class="reclamarLink">
					<xsl:attribute name="id">reclamar_<xsl:value-of select="PED_ID"/></xsl:attribute>
					<img src="http://www.newco.dev.br/images/reclamar.gif" alt="reclamar"/>
				</a>
			</td>-->
			<td colspan="5" class="uno">&nbsp;</td>
    	  </xsl:otherwise>
    	  </xsl:choose>
        	<!--aunque tenga derechos de usuario de control permitir-->
        	<td class="uno">
        	  <a class="reclamarLink">
					<xsl:attribute name="id">reclamar_<xsl:value-of select="PED_ID"/></xsl:attribute>
					<img src="http://www.newco.dev.br/images/reclamar.gif" alt="reclamar"/>
				</a>
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
						<br />
						<!--<a>
							<xsl:attribute name="href">javascript:enviarReclamacion(<xsl:value-of select="PED_ID"/>);</xsl:attribute>
							<img src="http://www.newco.dev.br/images/enviarReclamacion.gif" alt="enviar"/>
						</a>-->
						<a class="btnDestacadoPeq" href="javascript:enviarConsulta({PED_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='Consulta']/node()"/></a>
						&nbsp;
						<a class="btnRojoPeq" href="javascript:enviarReclamacion({PED_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='Reclamacion']/node()"/></a>
						<div style="display:none">
							<xsl:attribute name="id">waitBox_<xsl:value-of select="PED_ID"/></xsl:attribute>
						&nbsp;</div>
						<div class="confirmReclamacion" style="display:none;">
							<xsl:attribute name="id">confirmBox_<xsl:value-of select="PED_ID"/></xsl:attribute>
							<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='reclamacion_enviada']/node()"/></span>&nbsp;
						</div>
						<div class="confirmReclamacion" style="display:none;">
							<xsl:attribute name="id">confirmComBox_<xsl:value-of select="PED_ID"/></xsl:attribute>
							<span class="amarillo"><xsl:value-of select="document($doc)/translation/texts/item[@name='consulta_enviada']/node()"/></span>&nbsp;
						</div>
						<br /><br />
					</div>
				</td>
        		<td>&nbsp;</td>
			</tr>
		<!--</tbody>-->
		</xsl:for-each><!--fin de pedidos-->

      <!--total pedidos-->
      <tr class="conhover">
        <td colspan="{INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/COLSPAN_TOTALES}">
			<!--3abr19	
          <xsl:attribute name="colspan">
            <xsl:choose>
    	  	<!- -26may16	<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN = 'MVM' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN = 'MVMB'">6</xsl:when>- ->
	    	  <xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PERMITIR_CONTROL_PEDIDOS">6</xsl:when>
            <xsl:otherwise>6</xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>&nbsp;-->
        </td>
        <td style="text-align:right;" colspan="3">
          <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:&nbsp;<xsl:value-of select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/TOTAL_PEDIDOS"/>
          <!--	Center Group quiere ver el importe con y sin IVA -->
		  <xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MOSTRAR_PRECIOS_CON_IVA">
		  	<br/><xsl:value-of select="document($doc)/translation/texts/item[@name='total_cIVA']/node()"/>:&nbsp;<xsl:value-of select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/TOTAL_PEDIDOS_CONIVA"/>
		  </xsl:if>
		  </strong>
		  <!--
		  <xsl:choose>
          <xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MOSTRAR_PRECIOS_CON_IVA"><xsl:value-of select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/TOTAL_PEDIDOS_CONIVA"/></xsl:when>
          <xsl:otherwise><xsl:value-of select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/TOTAL_PEDIDOS"/></xsl:otherwise>
          </xsl:choose>-->
          <!--<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>-->
		 <!-- <xsl:value-of select="INICIO/DIVISA/SUFIJO"/>-->
        </td>
        <!--pedidos retrasados-->
        <td style="text-align:left;" colspan="3">
          <img src="http://www.newco.dev.br/images/2017/clock-red.png" alt="Retrasados" />&nbsp;
          <xsl:value-of select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PEDIDOS_RETRASADOS"/> / <xsl:value-of select="INICIO/PEDIDOSPROBLEMATICOS/TOTAL" /> : <xsl:value-of select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PORC_PED_RETRASADOS"/>
        </td>
        <td colspan="5">&nbsp;</td>
      </tr>
		</xsl:otherwise>
		</xsl:choose><!--fin de choose si hay pedidos-->

		<tfoot>
			<tr class="separator"><td colspan="20"></td></tr>
		</tfoot>
		</table>

		<table class="infoTable" bgcolor="#f5f5f5" width="100%">
		<tfoot>
			<tr class="lejenda lineBorderBottom3">
				<td colspan="15" class="datosLeft">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_control']/node()"/></td>
			</tr>
			<tr class="lineBorderBottom5">
				<td class="cuarenta datosLeft">
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;<img src="../../images/Situacion0de3.gif" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='no_enviado']/node()"/><br/>
						&nbsp;&nbsp;&nbsp;&nbsp;<img src="../../images/Situacion1de3.gif" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='enviado_segun_proveedor']/node()"/><br/>
						&nbsp;&nbsp;&nbsp;&nbsp;<img src="../../images/Situacion2de3.gif" border="0"/>&nbsp;&nbsp;<xsl:choose>
            				<xsl:when test="/WorkFlowPendientes/INICIO/TXT_SEMAFOROENVIADO"><xsl:value-of select="/WorkFlowPendientes/INICIO/TXT_SEMAFOROENVIADO" /></xsl:when>
            				<xsl:otherwise><xsl:value-of select="document($doc)/translation/texts/item[@name='enviado_albaran']/node()"/></xsl:otherwise>
            				</xsl:choose><br/>
						&nbsp;&nbsp;&nbsp;&nbsp;<img src="../../images/Situacion4de3.gif" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='recibido_segun_cliente']/node()"/><br/>
						<!-- &nbsp;&nbsp;&nbsp;&nbsp;<img src="../../images/Situacion-1de3.gif" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='informado']/node()"/><br/>-->
						<br/>
            			<xsl:choose>
            			<xsl:when test="/WorkFlowPendientes/INICIO/TXT_ESTADO_APSUP">
							&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="/WorkFlowPendientes/INICIO/TXT_ESTADO_APSUP" /><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="/WorkFlowPendientes/INICIO/TXT_ESTADO_PEND"/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="/WorkFlowPendientes/INICIO/TXT_ESTADO_ACEP"/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="/WorkFlowPendientes/INICIO/TXT_ESTADO_REQENVIO"/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="/WorkFlowPendientes/INICIO/TXT_ESTADO_PARC"/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="/WorkFlowPendientes/INICIO/TXT_ESTADO_RETR"/><br/>
						</xsl:when>
						<xsl:otherwise>
							&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='PED_AP_SUP']/node()"/>:&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='PED_AP_SUP_expli']/node()"/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='PED_PEND']/node()"/>:&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='PED_PEND_expli']/node()"/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='PED_ACEP']/node()"/>:&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='PED_ACEP_expli']/node()"/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='PED_REQ_ENVIO']/node()"/>:&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='PED_REQ_ENVIO_expli']/node()"/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='PED_PARC']/node()"/>:&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='PED_PARC_expli']/node()"/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='PED_RETR']/node()"/>:&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='PED_RETR_expli']/node()"/><br/>
						</xsl:otherwise>
						</xsl:choose>
					</p>
				</td>
        		<td class="quince datosLeft">
					<p>
						&nbsp;<img src="http://www.newco.dev.br/images/2017/warning-red.png" alt="Urgente"/>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_urgente']/node()"/><br/>
						&nbsp;<img src="http://www.newco.dev.br/images/2017/icono-pago.png"/>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Requiere_prepago']/node()"/><br/>
						&nbsp;<img src="http://www.newco.dev.br/images/2017/clock-red.png" alt="Retraso"/>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_retrasado']/node()"/><br/>
            			<!--4nov16<xsl:variable name="farmacia" select="count(INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PEDIDO[CATEGORIA = 'F'])"/>
            			<xsl:choose>
            			<xsl:when test="INICIO/PORTAL/PMVM_ID = 'MVM' and $farmacia != '0'">
            			  <img src="http://www.newco.dev.br/images/farmacia-icon.gif" alt="Farmacia"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_farmacia']/node()"/><br/>
            			</xsl:when>
            			<xsl:otherwise><br /><br /></xsl:otherwise>
            			</xsl:choose>-->
						<br/>
            			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PERMITIR_CONTROL_PEDIDOS">
								&nbsp;<img src="http://www.newco.dev.br/images/cuadroRojo.gif" alt="Bloqueado"/>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_bloqueado']/node()"/><br/>
            	  &nbsp;<img src="http://www.newco.dev.br/images/cuadroAmarillo.gif" alt="Cambios proveedor"/>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cambios_proveedor_mvm']/node()"/><br/>
            			</xsl:if>
									&nbsp;<img src="http://www.newco.dev.br/images/cuadroNaranja.gif" alt="Reclamaci?"/>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_reclamacion']/node()"/><br/><br />
            			<xsl:if test="not(INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PERMITIR_CONTROL_PEDIDOS)">
            			  <br />
            			  <br />
            			</xsl:if>
					</p>
				</td>
				<!--
				<td class="quince datosLeft">
					<p>
            		<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PERMITIR_CONTROL_PEDIDOS">
							&nbsp;<img src="http://www.newco.dev.br/images/cuadroRojo.gif" alt="Bloqueado"/>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_bloqueado']/node()"/><br/>
              &nbsp;<img src="http://www.newco.dev.br/images/cuadroAmarillo.gif" alt="Cambios proveedor"/>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cambios_proveedor_mvm']/node()"/><br/>
            		</xsl:if>
								&nbsp;<img src="http://www.newco.dev.br/images/cuadroNaranja.gif" alt="Reclamaci?"/>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_reclamacion']/node()"/><br/><br />
            		<xsl:if test="not(INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PERMITIR_CONTROL_PEDIDOS)">
            		  <br />
            		  <br />
            		</xsl:if>
					</p>
				</td>
				-->
				<td>
					<!--PEDIDOS PROBLEMATICOS-->
					<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR">
						<div class="problematicos">
							<p>
            				<xsl:choose>
            				<xsl:when test="/WorkFlowPendientes/INICIO/TXT_INFORMARPEDIDOS"><xsl:value-of select="/WorkFlowPendientes/INICIO/TXT_INFORMARPEDIDOS" /></xsl:when>
            				<xsl:otherwise><xsl:copy-of select="document($doc)/translation/texts/item[@name='ayudanos_detectar']/node()"/></xsl:otherwise>
            				</xsl:choose>
							</p>
            			  <!--boton para marcar como entregados los pedidos enviados con albaran m?s viejos de 5-10-15 dias, solo mvm,mvmb :mc 20-8-14:-->
            			  <xsl:variable name="filtroSemaforo" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDFILTROSEMAFORO/field/@current"/>
            			  <!--26may16	<xsl:if test="(INICIO/BANDEJA/DERECHOS_ADMIN='MVM' or INICIO/BANDEJA/DERECHOS_ADMIN='MVMB') and ($filtroSemaforo = 'ENV7' or $filtroSemaforo = 'ENV14' or $filtroSemaforo = 'ENV21')">-->
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
                			  &nbsp;<a class="btnDestacadoPeq" href="javascript:MarcarEntregados({$dias});"><xsl:value-of select="document($doc)/translation/texts/item[@name='Marcar']/node()"/></a>
                			  <div id="waitBoxEntregados" style="display:none;">&nbsp;</div>
                			  <div id="confirmBoxEntregados" style="display:none;"><p><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_marcados_entregados']/node()"/></p></div>
                			</p>
            			  </xsl:if>
						</div>
					</xsl:if>
				</td>
			</tr>
		</tfoot>
		</table>
  </xsl:if>

	<!--	Quitamos el botón de pedidos programados
  <div class="divLeft40nopa">&nbsp;</div>
	<!- -boton si hay- ->
	<xsl:choose>
	<xsl:when test="INICIO/BANDEJA/CDC">
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
	</xsl:choose><!- -fin de divLeft pedidos-->  </div>
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

	<!--	14ene22 Copiamos la estructura del admin
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/></span></p>
		<p class="TituloPagina">
          <xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>&nbsp;&nbsp;
          &nbsp;&nbsp;
		  <span class="CompletarTitulo">
		  </span>
		</p>
	</div>
	<br/>
	<br/>
	-->
	
	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/></span></p>
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
				<a class="btnNormal" href="javascript:DescargarExcel();"><img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel"/></a>&nbsp;
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
  <xsl:choose>
  <xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BLOQUEARBANDEJA"></xsl:when>
  <xsl:otherwise>
    <!--LLAMO LA TABLA CORESPONDIENTE BANDEJA DE ENTRADA-->
  	<xsl:apply-templates select="INICIO/BANDEJA/COMPRAS/ABONOS/BANDEJA"/>
	<xsl:apply-templates select="INICIO/BANDEJA/COMPRAS/PEDIDOS_APROBAR/BANDEJA"/>
  </xsl:otherwise>
  </xsl:choose>

  <div class="divLeft">
<!-- DC - 18nov2015
    <xsl:call-template name="INCIDENCIAS"/>
    <xsl:call-template name="EVALUACIONES"/>
    <xsl:call-template name="LICITACIONES"/>
-->
    <xsl:call-template name="SOLICITUDES"/>

    <xsl:if test="INICIO/GESTIONCOMERCIAL">
			<div class="divLeft">
				<xsl:apply-templates select="INICIO/GESTIONCOMERCIAL"/>
			</div>
	</xsl:if>
  </div><!--fin de divLeft-->

	<!--<div class="divLeft95m5" style="border:1px solid #939494;">-->
	<div class="divLeft">
	<xsl:for-each select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR">
		<input type="hidden" name="ORDEN" value="{./ORDEN}"/>
		<input type="hidden" name="SENTIDO" value="{./SENTIDO}"/>

		<!--<table class="grandeInicio" border="0">-->
		<table class="buscador">
		<!--	Filtros Desplegables - 21abr08: Los ponemos en la parte superior de la tabla - 24mar10 solo admin MVM o Empresa	
			9ene20 para todos los no minimalistas
		-->
		<!--
		<xsl:choose>
		<xsl:when test="ADMIN='EMPRESA'">
			<tr><td bgcolor="#f5f5f5" colspan="13"><xsl:call-template name="buscadorInicioCdc"/></td></tr>
		</xsl:when>
		<xsl:otherwise>
		<!- -si usuario minimalista no ense?o buscador- ->
		<xsl:if test="not(../../MINIMALISTA)">
				<tr><td bgcolor="#f5f5f5" colspan="13"><xsl:call-template name="buscadorInicioCliente"/></td></tr>
		</xsl:if>
		</xsl:otherwise>
		</xsl:choose>
		-->
		<xsl:if test="not(../../MINIMALISTA)">
			<tr><td bgcolor="#f5f5f5" colspan="13"><xsl:call-template name="buscadorInicioAdmin"/></td></tr>
		</xsl:if>

			<tr class="subTituloTabla">
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
							<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/<xsl:value-of select="ENLACETAREA"/>','Multioferta',100,100,0,0)</xsl:attribute>
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
						&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDPROVEEDOR}&amp;VENTANA=NUEVA','Centro',100,80,0,-20);">
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
							<img src="../../images/Situacion{SITUACION}de3.gif" border="0"/>
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

	</div><!--fin divCenter90-->

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
	<!--idioma fin-->

	<!--	14ene22 Copiamos la estructura del admin + boton stocks
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/></span></p>
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>&nbsp;&nbsp;
			&nbsp;&nbsp;
			<span class="CompletarTitulo">
				<!- -	Oferta stock: desactivado provisionalmente para Brasil	- ->
				<xsl:if test="/WorkFlowPendientes/INICIO/IDPAIS!=55">
				<a class="btnDestacado" href="javascript:NuevoStockOferta();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_oferta_stock']/node()"/>
				</a>
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	<br/>
	-->
	
		<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/></span></p>
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
				<a class="btnNormal" href="javascript:DescargarExcel();"><img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel"/></a>&nbsp;
				<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BOTONES/SIGUIENTE">
					<a class="btnNormal" href="javascript:AplicarFiltroPagina({INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BOTONES/SIGUIENTE/@Pagina});">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/>
					</a>&nbsp;
				</xsl:if>
				<!--	Oferta stock: desactivado provisionalmente para Brasil	-->
				<xsl:if test="/WorkFlowPendientes/INICIO/IDPAIS!=55">
				<a class="btnDestacado" href="javascript:NuevoStockOferta();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_oferta_stock']/node()"/>
				</a>
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
		<!--<div class="evidenciado">-->
		<div style="padding:10px;background-color:#BCF5A9;border:1px solid #488214;">
			<xsl:copy-of select="document($doc)/translation/texts/item[@name='pedidos_pendientes_de_informar']/node()"/>
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

    <!--LLAMO LA TABLA CORESPONDIENTE BANDEJA DE ENTRADA-->
  	<xsl:apply-templates select="/WorkFlowPendientes/INICIO/BANDEJA/COMPRAS/ABONOS/BANDEJA"/>
    <xsl:apply-templates select="/WorkFlowPendientes/INICIO/BANDEJA/COMPRAS/PEDIDOS_APROBAR/BANDEJA"/>
    <xsl:apply-templates select="/WorkFlowPendientes/INICIO/BANDEJA/COMPRAS/PEDIDOS/BANDEJA"/>
    <xsl:apply-templates select="/WorkFlowPendientes/INICIO/BANDEJA/COMPRAS/PEDIDOSPROGRAMADOS_APROBAR/BANDEJA"/>
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

  <!--nueva oferta stock
  <div class="divLeft95m5">
  	<div class="divLeft70">&nbsp;</div>
    <div class="divLeft30nopa" style="margin-top:10px;">
      <div class="botonLargoVerdadNara">
        <strong><a href="javascript:NuevoStockOferta();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_oferta_stock']/node()"/>
        </a></strong>
      </div>
    </div>
  </div>
	-->
	<!--<div class="divLeft95m5" style="border:1px solid #939494;">-->
	<div>
		<xsl:variable name="BLOQUEARBANDEJA">
			<xsl:choose>
			<xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/BLOQUEARBANDEJA">S</xsl:when>
			<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="COLSPAN_TABLA">
			<xsl:choose>
			<xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/PERMITIR_CONTROL_PEDIDOS">17</xsl:when>
			<xsl:otherwise>15</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!--<xsl:if test="./PEDIDO">-->
		<!--<table class="grandeInicio">-->
		<xsl:if test="/WorkFlowPendientes/INICIO/SOLOPEDIDOS='S'">
			<xsl:call-template name="buscadorInicioProv"/>
		</xsl:if>
		<table class="buscador">
			<!--<tr class="tituloTabla">-->
			<tr class="tituloTabla">
				<th colspan="{$COLSPAN_TABLA}"><p><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_en_curso']/node()"/>&nbsp;<a href="javascript:SoloPedidos();">
				<xsl:choose>
				<xsl:when test="/WorkFlowPendientes/INICIO/SOLOPEDIDOS='N'">[<xsl:value-of select="document($doc)/translation/texts/item[@name='Solo_pedidos']/node()"/>]</xsl:when>
				<!--Que entren por Inicio: <xsl:otherwise>[<xsl:value-of select="document($doc)/translation/texts/item[@name='Ver_otras_tareas_pendientes']/node()"/>]</xsl:otherwise>-->
				<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
				</a></p></th>
			</tr>
			<!--<tr class="titulos">-->
			<tr>
				<th class="uno">&nbsp;</th>
				<!--tipo pedido
				<th class="dos">&nbsp;</th>-->
				<th class="dos" style="text-align:left;"><xsl:copy-of select="document($doc)/translation/texts/item[@name='codigo']/node()"/></th>
				<th class="quince" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
				<th class="cuatro" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Emision']/node()"/></th>
				<xsl:if test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/OCULTAR_FECHA_ENTREGA='N'">
					<th class="cuatro"><xsl:value-of select="document($doc)/translation/texts/item[@name='entrega']/node()"/></th>
				</xsl:if>
				<th class="cuatro" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
        		<th class="tres" style="text-align:right;"><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/></th>
				<th class="tres" style="text-align:left;">&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha_salida_completo']/node()"/></th>
				<th class="tres" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='situacion']/node()"/></th>
				<th class="cinco" style="text-align:left;"><xsl:copy-of select="document($doc)/translation/texts/item[@name='numero_albaran']/node()"/></th>
                <th class="diez" style="text-align:left;"><xsl:copy-of select="document($doc)/translation/texts/item[@name='fichero_albaran']/node()"/></th>
                <th class="tres" style="text-align:left;"><!--boton documentos--></th>
				<th style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/></th>
				<th class="tres" ><xsl:value-of select="document($doc)/translation/texts/item[@name='retraso_acumulado']/node()"/></th>
				<th class="tres">&nbsp;</th>
				<xsl:if test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/PERMITIR_CONTROL_PEDIDOS">
					<th class="tres" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='res']/node()"/></th>
					<th class="tres" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
				</xsl:if>
			</tr>

			<!--SI NO HAY PEDIDOS ENSEï¿½O UN MENSAJE Y SIGO ENSEï¿½ANDO CABECERA-->
		<xsl:choose>
		<xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/TOTAL = '0'">
			<tr class="sinLinea"><th colspan="13">&nbsp;</th></tr>
			<tr class="sinLinea">
				<th colspan="13"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_pedidos_para_busqueda']/node()"/></th>
			</tr>
			<tr class="lejenda"><th colspan="13">&nbsp;</th></tr>
		</xsl:when>
		<xsl:otherwise>

		<xsl:for-each select="PEDIDO">

			<!--<tr style="border-bottom:1px solid #A7A8A9;">-->
			<tr class="conhover">
				<xsl:attribute name="class">
					<xsl:choose>
					<xsl:when test="OBLIGATORIO and RECLAMACION != 'S'">fondoRojo</xsl:when>
					<xsl:when test="RECLAMACION = 'S'">fondoNaranja</xsl:when>
					</xsl:choose>
				</xsl:attribute>

				<td>
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
				<td style="text-align:left;">
					<xsl:choose>
					<xsl:when test="$BLOQUEARBANDEJA='N' or OBLIGATORIO">
						<strong><a>
							<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/<xsl:value-of select="ENLACETAREA"/>','Multioferta',100,100,0,0)</xsl:attribute>
							<xsl:value-of select="NUMERO_PEDIDO"/>
						</a></strong>
					</xsl:when>
					<xsl:otherwise>
						<a href="javascript:AvisoPedidoBloqueado();"><xsl:value-of select="NUMERO_PEDIDO"/></a>
					</xsl:otherwise>
					</xsl:choose>
				</td>

				<td style="text-align:left;">
					&nbsp;
					<xsl:if test="FEDERASSANTAS"><img src="http://www.newco.dev.br/Conecta/img/logo_conecta.png" height="24px" width="67px"/>&nbsp;</xsl:if>
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTROCLIENTE}','centro',100,80,0,-20);" class="noDecor">
						<xsl:value-of select="NOMBRE_CENTRO"/>
					</a>
				</td>

				<td style="text-align:left;"><xsl:value-of select="FECHA_PEDIDO"/></td>
				<xsl:if test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/OCULTAR_FECHA_ENTREGA='N'">
					<td style="text-align:left;"><xsl:value-of select="FECHA_ENTREGA"/></td>
				</xsl:if>

				<td style="text-align:left;">
				<xsl:choose>
				<xsl:when test="$BLOQUEARBANDEJA='N' or OBLIGATORIO">
					<!--<xsl:value-of select="ESTADO"/>-->
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

				<td style="text-align:left;">
					<input type="hidden" name="FECHAPEDIDO_{MO_ID}" value="{FECHA_PEDIDO}"/>
					<xsl:choose>
					<xsl:when test="not(TERMINADO)">
						<input type="text" class="peq" name="NUEVAFECHAENTREGA_{MO_ID}" size="10" value="{FECHAENVIOPROVEEDOR}" oninput="javascript:ActivarBotonEnviar({MO_ID});"/>
					</xsl:when>
					<xsl:otherwise>
						&nbsp;<xsl:value-of select="FECHAENVIOPROVEEDOR"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>

				<td style="text-align:left;">
					<xsl:choose>
					<xsl:when test="not(TERMINADO)">
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="IDMOTIVO/field"/>
							<xsl:with-param name="claSel">medio</xsl:with-param>
							<xsl:with-param name="onChange">javascript:ActivarBotonEnviar(<xsl:value-of select="MO_ID"/>);</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						&nbsp;<xsl:value-of select="IDMOTIVOPROVEEDOR"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td style="text-align:left;">
					<xsl:choose>
					<xsl:when test="not(TERMINADO)">
						<input type="text" class="medio" name="ALBARAN_{MO_ID}" size="10" maxlength="50" value="{ALBARAN}" oninput="javascript:ActivarBotonEnviar({MO_ID});"/>
					</xsl:when>
					<xsl:otherwise>
						&nbsp;<xsl:value-of select="ALBARAN"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
                <td class="textLeft">
					<xsl:choose>
					<xsl:when test="not(TERMINADO)">
						<!--
                    	<input type="hidden" name="IDCLIENTE_{MO_ID}" id="IDCLIENTE_{MO_ID}" value="{IDCLIENTE}"/>
                    	<input type="hidden" name="IDALBARAN_{MO_ID}" id="IDALBARAN_{MO_ID}"/>
                    	<a id="download_{MO_ID}" style="display:none;"><img src="http://www.newco.dev.br/images/descarga.gif" alt="Descarga" /></a>
                    	<xsl:call-template name="albaran">
                        	<xsl:with-param name="idmultioferta" select="MO_ID" />
                        	<xsl:with-param name="type">ALBARAN</xsl:with-param>
                        	<xsl:with-param name="id"><xsl:value-of select="ALBARANENVIO/ID"/></xsl:with-param>
                        	<xsl:with-param name="name"><xsl:value-of select="ALBARANENVIO/NOMBRE"/></xsl:with-param>
                        	<xsl:with-param name="url"><xsl:value-of select="ALBARANENVIO/URL"/></xsl:with-param>
                    	</xsl:call-template>
						-->
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
					&nbsp;<a class="btnNormal" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Compras/Multioferta/MODocs.xsql?MO_ID={MO_ID}','Multioferta',100,100,0,0)"><xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/></a>&nbsp;
                </td>

				<td style="text-align:left;">
					<xsl:choose>
					<xsl:when test="not(TERMINADO)">
						<xsl:choose>
						<xsl:when test="RECLAMACION = 'S'">
							<!--<a class="reclamarLink">
							<xsl:attribute name="id">reclamar_<xsl:value-of select="PED_ID"/></xsl:attribute>
								<img src="http://www.newco.dev.br/images/norecibido.gif" alt="Reclamaci?n"/>
							</a>
							&nbsp;<xsl:value-of select="COMENTARIOSPROVEEDOR"/>-->
							<input type="text" class="grande" name="COMENTARIOS_{MO_ID}" size="30" maxlength="200" onchange="javascript:ActivarBotonEnviar({MO_ID});"/>
						</xsl:when>
						<xsl:otherwise>
							<input type="text" class="grande" name="COMENTARIOS_{MO_ID}" size="30" maxlength="200" value="{COMENTARIOSPROVEEDOR}" onkeypress="javascript:ActivarBotonEnviar({MO_ID});"/>
						</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						&nbsp;<xsl:value-of select="COMENTARIOSPROVEEDOR"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>

				<td><strong><xsl:value-of select="RETRASO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='dias']/node()"/></strong></td>

				<td style="text-align:left;">
				<xsl:choose>
				<xsl:when test="ESTADO='ACEPTAR'">
					<a class="btnDestacado">
					<xsl:choose>
					<xsl:when test="$BLOQUEARBANDEJA='S'">
						<xsl:attribute name="href">javascript:AvisoPedidoBloqueado();</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/<xsl:value-of select="ENLACETAREA"/>','Multioferta',100,100,0,0)</xsl:attribute>
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
            			  <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Personal/BandejaTrabajo/ControlPedidos.xsql?IDPEDIDO=<xsl:value-of select="PED_ID"/>','Control Pedido',100,80,0,0)</xsl:attribute>
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
            			  <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Personal/BandejaTrabajo/ControlPedidos.xsql?IDPEDIDO=<xsl:value-of select="PED_ID"/>','Control Pedido',100,80,0,0)</xsl:attribute>
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
					<!--<input type="text" name="COMENTARIOS_{MO_ID}" size="30" maxlength="200" value="" />-->
				</td>
			</tr>
		</xsl:if>
		</xsl:for-each>

    	<!--total pedidos-->
      <tr class="subTituloTabla">
        <td colspan="6">&nbsp;</td>
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
        <td colspan="9">&nbsp;</td>
      </tr>
		</xsl:otherwise>
		</xsl:choose><!-- fin de choose si hay pedidos-->

			<tr class="sinLinea"><!--noChange-->
				<td colspan="10" class="textLeft">
          <xsl:variable name="farmacia" select="count(PEDIDO[CATEGORIA = 'F'])"/>
          <xsl:choose>
          <xsl:when test="/WorkFlowPendientes/INICIO/PORTAL/PMVM_ID = 'MVM' and $farmacia != '0'">
            <p>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda']/node()"/>:<br />&nbsp;&nbsp;<img src="../../images/farmacia-icon.gif" border="0"/>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_farmacia']/node()"/></p>
          </xsl:when>
          </xsl:choose>
				</td>
				<td colspan="4" class="textLeft">
					<strong>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='retraso_acumulado_act']/node()"/>:
						<xsl:value-of select="RETRASO_TOTAL"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='dias']/node()"/><br/>
						&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='retraso_acumulado']/node()"/>: <xsl:value-of select="MES_ACTUAL"/>: 
						<xsl:value-of select="RETRASO_TOTAL_MES"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='dias']/node()"/>
					</strong>
				</td>
			</tr>
		</table>
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

	<table>
		<xsl:attribute name="class">
			<xsl:choose>
			<xsl:when test="$destacar='S'">noticiasMvmDest</xsl:when>
			<xsl:otherwise>noticiasMvm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	
		<tr class="tituloTabla">
			<th colspan="3">
				<p><xsl:value-of select="document($doc)/translation/texts/item[@name='noticias_de']/node()"/><xsl:value-of select="/WorkFlowPendientes/INICIO/PORTAL/PMVM_NOMBRE"/></p>
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
		<!--<table class="grandeInicio">-->
		<table class="buscador">
			<!--<tr class="tituloTablaPeq">-->
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
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDCLIENTE}&amp;VENTANA=NUEVA','Cliente',100,80,0,-20);">
						<xsl:value-of select="CLIENTE"/>
					</a>
				</td>
				<td style="text-align:left;">
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTROCLIENTE}','Centro Cliente',100,80,0,-20);">
						<xsl:value-of select="CENTROCLIENTE"/>
          </a>
        </td>
				<td style="text-align:left;">
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDPROVEEDOR}&amp;VENTANA=NUEVA','Vendedor',100,80,0,-20);">
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
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={PROVEEDOR}&amp;VENTANA=NUEVA','Vendedor',100,80,0,-20);">
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
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDEMPRESA}&amp;VENTANA=NUEVA','Empresa',100,80,0,-20);">
						<xsl:value-of select="EMPRESA"/>
        			</a>
				</xsl:otherwise>
				</xsl:choose>
			</td>
			<xsl:if test="/WorkFlowPendientes/INICIO/LICITACIONES/FIDAREAGEOGRAFICA/field">
				<td><xsl:value-of select="CENTROPEDIDO/AREAGEOGRAFICA"/></td>
			</xsl:if>
			<td style="text-align:left;">&nbsp;
				<xsl:if test="LIC_URGENTE = 'S' or VENCE_24HORAS"><img src="http://www.newco.dev.br/images/2017/warning-red.png"/>&nbsp;</xsl:if>
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
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDCLIENTE}','DetalleEmpresa',100,80,0,0)">
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
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDCLIENTE}','DetalleEmpresa',100,80,0,0)">
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
		        <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDEMPRESA/field/dropDownList/listElem[ID = ../../@current]/ID}&amp;VENTANA=NUEVA','Vendedor',100,80,0,-20);">
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
		<div class="divLeft" style="border-bottom:5px solid #E4E4E5;margin-bottom:20px;">
			<!--ventas pedidos-->
			<!--<table class="grandeInicio">
				<tr class="tituloTabla">-->
			<table class="buscador">
				<tr class="tituloTabla">
					<th colspan="12"><xsl:value-of select="LISTATAREAS/TITULO"/></th>
				</tr>
				<tr class="subTituloTabla">
          <!-- pos -->
					<th class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
					<th class="uno">&nbsp;</th>	<!--	icono urgente		-->
          <!-- numero -->
					<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='numero']/node()"/></th>
					<!-- centro (para usuarios admin o multicentro -->
					<xsl:if test="/WorkFlowPendientes/INICIO/BANDEJA/MULTICENTROS or /WorkFlowPendientes/INICIO/BANDEJA/DERECHOS_ADMIN='EMPRESA'">
						<th class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
					</xsl:if>
					<!-- fecha -->
					<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
					<!-- empresa -->
					<th class="veinte"><xsl:value-of select="LISTATAREAS/TITULOEMPRESA"/></th>
					<!-- Estado -->
					<th class="veinte">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>

					<xsl:if test="INCLUIR_RESPONSABLE">
						<th class="dos"></th>
						<th class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/></th>
					</xsl:if>

					<xsl:choose><!-- no error / no sorry / comprador -->
					<xsl:when test="../../ROL[.='C']">
						<!-- plantilla -->
						<th class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='plantilla']/node()"/></th>
					</xsl:when>
					</xsl:choose>
						<!-- Fecha decision o entrega -->
						<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_entrega']/node()"/></th>
					<!-- Importe -->
					<xsl:choose>
					<!--<xsl:when test="LISTATAREAS/ROL='C' or LISTATAREAS/ROL='V'">-->
					<xsl:when test="LISTATAREAS/TIPO_TAREA='PENDIENTES_APROBACION'">
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

			<xsl:for-each select="LISTATAREAS/TAREA">

				<tr class="conhover">
					<xsl:choose>
					<xsl:when test="IDINCIDENCIA!=''">
						<xsl:attribute name="class">rojo</xsl:attribute>
					</xsl:when>
					</xsl:choose>

					<xsl:apply-templates select="MO_ID"/>
                    <td><xsl:value-of select="position()"/></td>

					<td>
						<xsl:choose>
						<xsl:when test="URGENTE"><img src="http://www.newco.dev.br/images/2017/warning-red.png"/></xsl:when>
						<xsl:otherwise>&nbsp;</xsl:otherwise>
						</xsl:choose>
					</td>


					<td>
					<xsl:choose>
					<xsl:when test="STATUS_COLOR[.='OPONENT_SIDE']">
						<strong><a>
							<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="ID"/>','Multioferta',100,100,0,0);</xsl:attribute>
							<xsl:attribute name="class">
								<xsl:if test="IDINCIDENCIA!=''">alerta</xsl:if>
							</xsl:attribute>
							<xsl:value-of select="NUMERO"/>
						</a></strong>
					</xsl:when>
					<xsl:when test="STATUS_COLOR[.='DEAD_PROCESS']">
						<strong><a>
							<!--<xsl:attribute name="href">javascript:MostrarPagPersonalizada('<xsl:value-of select="../../ENLACETAREA"/><xsl:value-of select="ID"/>&amp;ORIGEN=WFStatusHTML.xsl_6&amp;SES_ID=<xsl:value-of select="//SES_ID"/>&amp;READ_ONLY=S<xsl:choose><xsl:when test="../../TIPO='MULTIOFERTAS'">&amp;xml-stylesheet=MultiofertaFrame-<xsl:value-of select="MO_STATUS"/>-RO-HTML.xsl</xsl:when></xsl:choose>','Multioferta',100,100,0,0);</xsl:attribute>-->
                            <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="ID"/>','Multioferta',100,100,0,0);</xsl:attribute>
							<xsl:attribute name="class">
								<xsl:if test="IDINCIDENCIA!=''">alerta</xsl:if>
							</xsl:attribute>
							<xsl:value-of select="NUMERO"/>
						</a></strong>
					</xsl:when>
					<xsl:when test="STATUS_COLOR[.='ACTION_REQUIRED']">
						<b>
							<strong><a>
								<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="ID"/>','Multioferta',100,100,0,0);</xsl:attribute>
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
							<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="ID"/>','Multioferta',100,100,0,0);</xsl:attribute>
							<xsl:attribute name="class">
								<xsl:if test="IDINCIDENCIA!=''">alerta</xsl:if>
							</xsl:attribute>
							<xsl:value-of select="ERW_DESCRIPCION_BANDEJA"/>
						</a></strong>
					</xsl:when>
					<xsl:when test="STATUS_COLOR[.='DEAD_PROCESS']">
						<strong><a>
							<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="ID"/>','Multioferta',100,100,0,0);</xsl:attribute>
							<xsl:attribute name="class">
								<xsl:if test="IDINCIDENCIA!=''">alerta</xsl:if>
							</xsl:attribute>
							<xsl:value-of select="ERW_DESCRIPCION_BANDEJA"/>
						</a></strong>
					</xsl:when>
					<xsl:when test="STATUS_COLOR[.='ACTION_REQUIRED']">
						<strong>
							<a>
								<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="ID"/>','Multioferta',100,100,0,0)</xsl:attribute>
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
				<xsl:when test="../TIPO_TAREA='PENDIENTES_APROBACION'">
					<td align="right">
						<xsl:choose>
						<xsl:when test="INCUMPLE_PEDIDO_MINIMO"><img src="http://www.newco.dev.br/images/nocheck.gif"/>&nbsp;</xsl:when>
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
			</table>
		</div><!--fin de divLeft-->
	</xsl:otherwise>
	</xsl:choose>
	<br /><br />
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
	<!--	31ene20 QUitamos la tabla de resumen, ya tenemos la info en los indicadores
	<div class="divLeft" style="text-align:left;">
		<a class="btnNormal" id="MostrarTablaActividad" href="javascript:MostrarTablaActividad();"><xsl:value-of select="document($doc)/translation/texts/item[@name='ResumenActividad']/node()"/></a>
		<a class="btnNormal" style="display:none;" id="OcultarTablaActividad" href="javascript:OcultarTablaActividad();"><xsl:value-of select="document($doc)/translation/texts/item[@name='ResumenActividad']/node()"/></a>
	</div>
	<br/>-->
	<br/>
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
	<br/>
	</xsl:if>
	<!--table select-->
	<table class="buscador" border="0">
		<xsl:variable name="BuscAvanzStyle">
			<xsl:choose>
			<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/URGENTE = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BLOQUEADO = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FARMACIA = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MATERIALSANITARIO = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/SINSTOCKS = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/TODOS12MESES = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/INCFUERAPLAZO = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PEDIDOOK = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ENTR_RETRASADO = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PEDIDONOCOINCIDE = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ENTR_PARCIAL = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/RETRASODOCUMTEC = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/NOINFORMADOPLAT = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PROD_ANYADIDOS = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PROD_RETIRADOS = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MALAATENCIONPROV = 'S' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FECHAINICIO != '' or INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FECHAFINAL != ''"></xsl:when>
			<xsl:otherwise>display:none;</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<tr class="filtrosgrandes">
		<xsl:if test="/WorkFlowPendientes/INICIO/SOLOPEDIDOS='S'">
			<xsl:choose>
			<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDEMPRESA/field">
				<th width="160px"  style="text-align:left;">
					<label>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:</label><br />
					&nbsp;<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDEMPRESA/field"/>
					</xsl:call-template>
				</th>
			</xsl:when>
			<xsl:otherwise>
				<input type="hidden" name="IDEMPRESA" value="{IDEMPRESA}" />
			</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
			<xsl:when test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDCENTRO">
				<th width="160px"  style="text-align:left;">
					<label>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDCENTRO/field"/>
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
			<th width="160px"  style="text-align:left;">
				<label>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_consumo']/node()"/>:</label><br />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/CENTROSCONSUMO/field"/>
				</xsl:call-template>
			</th>
		</xsl:when>
		<xsl:otherwise>
			<input type="hidden" name="IDCENTROCONSUMO" value=""/>
		</xsl:otherwise>
		</xsl:choose>
		
		<xsl:if test="not(INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/OCULTAR_PROVEEDOR)">
			<th width="160px"  style="text-align:left;">
				<label>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label><br />
				&nbsp;<xsl:call-template name="desplegable"><xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDPROVEEDOR/field"/></xsl:call-template>&nbsp;
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
		<th width="160px" style="text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='comprador']/node()"/>:</label><br />
			<xsl:call-template name="desplegable"><xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDFILTROCOMPRADOR/field"/></xsl:call-template>&nbsp;
		</th>
		</xsl:if>
		<th width="160px" style="text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/>:</label><br />
			<xsl:call-template name="desplegable"><xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDFILTRORESPONSABLE/field"/></xsl:call-template>&nbsp;
		</th>
		<th width="160px" style="text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='situacion']/node()"/>:</label><br />
			<xsl:call-template name="desplegable"><xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDFILTROSEMAFORO/field"/></xsl:call-template>&nbsp;
		</th>
		<!--
		<th width="160px" style="text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_pedido']/node()"/>:</label><br />
			<xsl:call-template name="desplegable"><xsl:with-param name="path" select="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDFILTROTIPOPEDIDO/field"/></xsl:call-template>&nbsp;
		</th>
		-->
		<th width="160px" style="text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='numero_pedido']/node()"/>:</label><br />
			<input class="buscador" type="text" name="CODIGOPEDIDO" size="10" maxlength="20" value="{INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/CODIGOPEDIDO}"/>&nbsp;
		</th>
		<th width="160px" style="text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:</label><br />
			<input class="buscador" type="text" name="PRODUCTO" size="10" maxlength="20" value="{INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PRODUCTO}"/>&nbsp;
		</th>

		<!--	Nuevo filtro de periodo		-->
		<th width="120px" style="text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo']/node()"/></label><br />
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/FPLAZO/field"/>
				<xsl:with-param name="style">width:100px;</xsl:with-param>
			</xsl:call-template>
		</th>

		<th width="120px" style="text-align:left;">
			<!--<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Lineas_por_pagina']/node()"/>:</label>-->&nbsp;<br />
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
    	<th width="120px" style="text-align:center;">
       		<a href="javascript:VerBuscadorAvanzado();" title="Buscador avanzado"  class="btnDiscreto"><!--btnDiscreto-->
        	<!-- <img src="http://www.newco.dev.br/images/avanzado.gif" alt="Avanzado" />-->
				[<xsl:value-of select="document($doc)/translation/texts/item[@name='AVANZADO']/node()"/>]
        	</a>
		</th>
    	<th width="80px" style="text-align:left;">
			<a href="javascript:FiltrarBusqueda();" title="Buscar" class="btnDestacado">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
			</a>&nbsp;
		</th>
		<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BOTON_RESUMEN">
    	<th width="80px" style="text-align:left;">
			<a href="javascript:ResumenPedidos();" title="Buscar" class="btnDestacado">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Resumen']/node()"/>
			</a>&nbsp;
		</th>
		</xsl:if>
		<th width="*">
			&nbsp;
		</th>
	</tr>

    <tr id="buscadorAvanzadoOne" class="selectAva buscadorAvanzado sinLinea" height="40">
      <xsl:attribute name="style"><xsl:value-of select="$BuscAvanzStyle"/></xsl:attribute>

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
		<!--11ene22	pedidos ultimos 12 meses
		<input class="muypeq" type="checkbox" name="TODOS12MESES_CHECK">
			<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/TODOS12MESES = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
		</input>&nbsp;
		<label style="color:#333;"><xsl:value-of select="document($doc)/translation/texts/item[@name='24_meses']/node()"/></label>
		-->
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
      <xsl:attribute name="style"><xsl:value-of select="$BuscAvanzStyle"/></xsl:attribute>

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
      <xsl:attribute name="style"><xsl:value-of select="$BuscAvanzStyle"/></xsl:attribute>
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
</xsl:template>
<!--fin de buscador admin tabla pedidos comprador-->

<!--buscador cdc en el medio de tabla pedidos-->
<xsl:template name="buscadorInicioCdc">
	<xsl:variable name="lang">
		<xsl:value-of select="../../../LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>

	<!--table select-->
	<table class="buscador" border="0">
		<tr class="select">
			<th>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label><br />
				<xsl:call-template name="desplegable"><xsl:with-param name="path" select="FILTROS/IDPROVEEDOR/field"/></xsl:call-template>
			</th>
			<th>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='situacion']/node()"/>:</label><br />
				<xsl:call-template name="desplegable"><xsl:with-param name="path" select="FILTROS/IDFILTROSEMAFORO/field"/></xsl:call-template>
			</th>
			<th>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_pedido']/node()"/>:</label><br />
				<xsl:call-template name="desplegable"><xsl:with-param name="path" select="FILTROS/IDFILTROTIPOPEDIDO/field"/></xsl:call-template>
			</th>
			<th>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='numero_pedido']/node()"/>:</label><br />
				<input type="text" name="CODIGOPEDIDO" size="10" maxlength="20" value="{CODIGOPEDIDO}"/>
			</th>
			<th>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:</label><br />
				<input type="text" name="PRODUCTO" size="10" maxlength="20" value="{PRODUCTO}"/>
			</th>
			<th align="left">
				<input type="hidden" name="BLOQUEADO_CHECK" value="N"/>
				<!--farmacia check-->
				<input class="muypeq" type="checkbox" name="FARMACIA_CHECK">
					<xsl:if test="../COMPRADOR/FARMACIA = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
				</input>&nbsp;
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='farmacia']/node()"/></label>
				<br />
				<!--material check-->
				<input class="muypeq" type="checkbox" name="MATERIAL_CHECK">
					<xsl:if test="../COMPRADOR/MATERIALSANITARIO = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
				</input>&nbsp;
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fungible']/node()"/></label>
				<br />
				<!--sin stock check-->
				<input class="muypeq" type="checkbox" name="SINSTOCKS_CHECK">
					<xsl:if test="../COMPRADOR/SINSTOCKS = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
				</input>&nbsp;
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='sin_stock']/node()"/></label>
			</th>
			<!--	Nuevo filtro de periodo		-->
			<th width="120px" style="text-align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo']/node()"/></label><br />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/FPLAZO/field"/>
					<xsl:with-param name="style">width:100px;</xsl:with-param>
				</xsl:call-template>
			</th>
			<th>
                <a href="javascript:DescargarExcel();"><img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel"/></a><br />
				<a href="javascript:FiltrarBusqueda();" title="Buscar">
					<img src="http://www.newco.dev.br/images/buttonBuscar.gif" alt="Buscar" />
				</a>
			</th>
		</tr>
	</table>
</xsl:template>
<!--fin de buscador cdc tabla pedidos comprador-->

<!--buscador clientes normales-->
<xsl:template name="buscadorInicioCliente">
	<xsl:variable name="lang">
    <xsl:value-of select="../../../LANG" />
  </xsl:variable>
  <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>

  <!--table select-->
  <table class="buscador" border="0">
	  <tr class="select">
    	<th class="setanta">&nbsp;</th>
      <th class="diez">&nbsp;</th>
      <th>
        <!--sin stock check-->
			<input class="muypeq" type="checkbox" name="SINSTOCKS_CHECK">
          <xsl:if test="../COMPRADOR/SINSTOCKS = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
        </input>&nbsp;
        <label><xsl:value-of select="document($doc)/translation/texts/item[@name='sin_stock']/node()"/></label>
			</th>
			<th>
				<a href="javascript:FiltrarBusqueda();">
					<img src="http://www.newco.dev.br/images/buttonBuscar.gif" alt="Button Aplicar Filtro" title="Aplicar Filtro en MedicalVM"/>
        </a>
      </th>
		</tr>
  </table>
</xsl:template>
<!--fin de buscador cliente normal-->

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

	<table class="buscador" border="0">
		<xsl:variable name="BuscAvanzStyle">
			<xsl:choose>
			<xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/URGENTE = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/BLOQUEADO = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FARMACIA = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/MATERIALSANITARIO = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/SINSTOCKS = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/TODOS12MESES = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/INCFUERAPLAZO = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/PEDIDOOK = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/ENTR_RETRASADO = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/PEDIDONOCOINCIDE = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/ENTR_PARCIAL = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/RETRASODOCUMTEC = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/NOINFORMADOPLAT = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/PROD_ANYADIDOS = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/PROD_RETIRADOS = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/MALAATENCIONPROV = 'S' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FECHAINICIO != '' or /WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FECHAFINAL != ''"></xsl:when>
			<xsl:otherwise>display:none;</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<tr class="filtrosgrandes">
		<!--	10ene22	Area Geografica		-->
		<xsl:choose>
		<xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FILTROS/FIDAREAGEOGRAFICA/field">
			<th width="180px" style="text-align:left">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Area_geografica']/node()"/></label><br />
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FILTROS/FIDAREAGEOGRAFICA/field"/>
				<xsl:with-param name="style">width:170px;</xsl:with-param>
			</xsl:call-template>
			</th>
		</xsl:when>
		<xsl:otherwise>
			<input type="hidden" name="FIDAREAGEOGRAFICA" value="-1"/>
		</xsl:otherwise>
		</xsl:choose>
		
		<xsl:choose>
		<xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FILTROS/IDEMPRESA/field">
			<th width="210px"  style="text-align:left;">
				<label>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:</label><br />
				&nbsp;<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FILTROS/IDEMPRESA/field"/>
					<xsl:with-param name="style">width:200px;</xsl:with-param>
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
			<th width="310px" style="text-align:left">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>/<xsl:value-of select="document($doc)/translation/texts/item[@name='nif']/node()"/></label><br />
				<input type="text" name="FTEXTO" size="30" style="width:300px;">
					<xsl:attribute name="value"><xsl:value-of select="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FILTROS/FTEXTOCLIENTE"/></xsl:attribute>
				</input>
			</th>
		</xsl:when>
		<xsl:otherwise>
			<xsl:choose>
			<xsl:when test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FILTROS/IDCENTRO/field">
				<th width="210px" style="text-align:left;">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FILTROS/IDCENTRO/field"/>
						<xsl:with-param name="style">width:200px;</xsl:with-param>
					</xsl:call-template>&nbsp;
				</th>
			</xsl:when>
			<xsl:otherwise>
				<input type="hidden" name="IDCENTRO" value="-1" />
			</xsl:otherwise>
			</xsl:choose>
			<th width="160px" style="text-align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/>:</label><br />
				<xsl:call-template name="desplegable"><xsl:with-param name="path" select="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FILTROS/IDFILTRORESPONSABLE/field"/></xsl:call-template>&nbsp;
			</th>
			<th width="160px" style="text-align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:</label><br />
				<input class="buscador" type="text" name="PRODUCTO" size="10" maxlength="20" value="{/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/PRODUCTO}"/>&nbsp;
			</th>
		</xsl:otherwise>
		</xsl:choose>
		<th width="160px" style="text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='numero_pedido']/node()"/>:</label><br />
			<input class="buscador" type="text" name="CODIGOPEDIDO" size="10" maxlength="20" value="{/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/CODIGOPEDIDO}"/>&nbsp;
		</th>
		<th width="160px" style="text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='situacion']/node()"/>:</label><br />
			<xsl:call-template name="desplegable"><xsl:with-param name="path" select="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FILTROS/IDFILTROSEMAFORO/field"/></xsl:call-template>&nbsp;
		</th>
		<th width="160px" style="text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='vendedor']/node()"/>:</label><br />
			<xsl:call-template name="desplegable"><xsl:with-param name="path" select="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FILTROS/IDFILTROVENDEDOR/field"/></xsl:call-template>&nbsp;
		</th>
		<!--10ene22 pedidos ultimos 12/24 meses: lo activaremos al seleccionar "todos"
		<th width="170px"  style="text-align:left;">
			<input class="peq" type="checkbox" name="TODOS12MESES_CHECK">
				<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/TODOS12MESES = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
			</input>&nbsp;
			<label style="color:#333;"><xsl:value-of select="document($doc)/translation/texts/item[@name='24_meses']/node()"/></label>
		</th>
		-->
		<!--10ene22 lineas por pagina: lo forzamos a 100
		<th style="width:140px;text-align:left;">
			&nbsp;<br />
			<select name="LINEA_POR_PAGINA" id="LINEA_POR_PAGINA"  style="width:130px;" onchange="AplicarFiltro();">
			<option value="30">
    			<xsl:if test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/LINEASPORPAGINA = '30'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
			  30 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
			</option>
			<option value="50">
			  <xsl:if test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/LINEASPORPAGINA = '50'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
			  50 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
			</option>
			<option value="100">
			  <xsl:if test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/LINEASPORPAGINA = '100'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
			  100 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
			</option>
			<option value="500">
			  <xsl:if test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/LINEASPORPAGINA = '500'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
			  500 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
			</option>
			<option value="1000">
			  <xsl:if test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/LINEASPORPAGINA = '1000'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
			  1000 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
			</option>
			</select>
		</th>
		-->
		<!--	Nuevo filtro de periodo		-->
		<th width="120px" style="text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo']/node()"/></label><br />
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/VENDEDOR/FILTROS/FPLAZO/field"/>
				<xsl:with-param name="style">width:100px;</xsl:with-param>
			</xsl:call-template>
		</th>
		<input type="hidden" name="LINEA_POR_PAGINA" id="LINEA_POR_PAGINA" value="100"/>
    	<th width="80px" style="text-align:left;">
			<a href="javascript:FiltrarBusqueda();" title="Buscar" class="btnDestacado">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
			</a>&nbsp;
		</th>
		<th width="*">
			&nbsp;
		</th>
    </tr>
	</table>
</xsl:template>
<!-- Fin buscador inicio proveedor	-->


<xsl:template match="MO_ID">
</xsl:template>

<xsl:template match="EMPRESA2">
	<a>
    <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="../EMP_ID2"/>&amp;VENTANA=NUEVA','Empresa',100,80,0,-20)</xsl:attribute>
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

</xsl:stylesheet>
