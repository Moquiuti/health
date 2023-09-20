<?xml version="1.0" encoding="iso-8859-1"?>
<!--incidencias de producto-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/">
<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/EvaluacionProducto/LANG"><xsl:value-of select="/EvaluacionProducto/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion_producto']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

        <link rel="stylesheet" href="http://www.newco.dev.br/General/estiloPrintComercial.css" type="text/css" media="print"/>

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/evaluacionProductos220116.js"></script>

        <!--codigo etiquetas-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/Tabla-popup.150715.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/etiquetas.js"></script>

	<link rel="stylesheet" href="http://www.newco.dev.br/General/lightbox.css" type="text/css" media="screen"/>
	<link href="http://www.newco.dev.br/General/Tabla-popup.150715.css" rel="stylesheet" type="text/css"/>
        <!--fin codigo etiquetas-->

    <script type="text/javascript">
	var fechaMuestrasObli       = '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_muestras_obli']/node()"/>';
    var usEvalObli              = '<xsl:value-of select="document($doc)/translation/texts/item[@name='us_eval_obli']/node()"/>';
    var evaluacionObli          = '<xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion_obli']/node()"/>'
    var muestrasProbadasObli    = '<xsl:value-of select="document($doc)/translation/texts/item[@name='muestras_probadas_obli']/node()"/>';
    var diagnosticoObli         = '<xsl:value-of select="document($doc)/translation/texts/item[@name='diagnostico_obli']/node()"/>';
    var expliNoAptoObli         = '<xsl:value-of select="document($doc)/translation/texts/item[@name='expli_no_apto_obli']/node()"/>';
    var usEvaluadorObli	    = '<xsl:value-of select="document($doc)/translation/texts/item[@name='us_evaluador_muestras_obli']/node()"/>';
    var soloNumeros    	    = '<xsl:value-of select="document($doc)/translation/texts/item[@name='solo_numeros']/node()"/>';
    var numMuestras             = '<xsl:value-of select="document($doc)/translation/texts/item[@name='num_muestras']/node()"/>';
    var soloNumerosBarras       = '<xsl:value-of select="document($doc)/translation/texts/item[@name='solo_numeros_barras']/node()"/>';
    var fechaEnvio              = '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_envio_muestras']/node()"/>';
    var numMuestrasProbadas     = '<xsl:value-of select="document($doc)/translation/texts/item[@name='numero_muestras_probadas']/node()"/>';
	<!-- Variables y Strings JS para las etiquetas -->
	var IDRegistro = '<xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_ID"/>';
	var IDTipo = 'EVAL';
	var str_NuevaEtiquetaGuardada	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta_guardada']/node()"/>';
	var str_NuevaEtiquetaError		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta_error']/node()"/>';
	var str_autor			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/>';
	var str_fecha			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>';
	var str_etiqueta	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='etiqueta']/node()"/>';
	var str_borrar		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>';
	<!-- FIN Variables y Strings JS para las etiquetas -->
	</script>
</head>
<body>
<xsl:choose>
<xsl:when test="EvaluacionProducto/SESION_CADUCADA">
	<xsl:for-each select="Incidencia/SESION_CADUCADA">
		<xsl:if test="position()=last()">
			<xsl:apply-templates select="."/>
		</xsl:if>
	</xsl:for-each>
</xsl:when>
<xsl:when test="//xsql-error">
	<xsl:apply-templates select="//xsql-error"/>
</xsl:when>
<xsl:otherwise>
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/EvaluacionProducto/LANG"><xsl:value-of select="/EvaluacionProducto/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:variable name="usuario">
	<xsl:choose>
		<xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/OBSERVADOR">OBSERVADOR</xsl:when>
		<xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/CDC">CDC</xsl:when>
		<xsl:otherwise>NORMAL</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>


	<div class="divLeft">
	<xsl:choose>
	<!--<xsl:when test="EvaluacionProducto/OK">
		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion_guardada_exito']/node()"/></h1>
		<div class="divLeft40">&nbsp;</div>

		<div class="boton">
			<a href="http://www.newco.dev.br/Gestion/Comercial/EvaluacionProductos.xsql">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='evaluaciones']/node()"/>
			</a>
		</div>
                <xsl:if test="/EvaluacionProducto/EVALUACIONPRODUCTO/ROL = 'COMPRADOR' or /EvaluacionProducto/EVALUACIONPRODUCTO/CDC"></xsl:if>
	</xsl:when>-->
	<xsl:when test="/EvaluacionProducto/ERROR">
		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='error_evaluacion']/node()"/></h1>
	</xsl:when>
	<xsl:otherwise>
		<!--	Titulo de la p�gina		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_evaluacion_producto']/node()"/></span></p>
			<p class="TituloPagina">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion_producto']/node()"/>&nbsp;
           		<xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_CODIGO"/>&nbsp;-&nbsp;
            	<xsl:value-of select="substring(/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBRE,0,50)"/>
				<xsl:if test="/EvaluacionProducto/OK">
                    :&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion_guardada_exito']/node()"/>
                </xsl:if>				
				<span class="CompletarTitulo">
					<!--
					<a class="btnDestacado" href="http://www.newco.dev.br/Gestion/Comercial/EvaluacionProductos.xsql">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='evaluaciones']/node()"/>
                    </a>
					&nbsp;
					-->
                    <xsl:if test="$usuario = 'CDC'"><!--solo usuarios cdc pueden copiar evaluacion 24-8-15mc-->
					<a class="btnDestacado" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/EvaluacionProductoCopia.xsql?ID_EVAL={/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_ID}','evaluacion',100,80,0,0)" title="C�pia" style="text-decoration:none;">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='Copiar']/node()"/>
                    </a>
					&nbsp;
                    </xsl:if>
					<a class="btnNormal" href="javascript:window.close();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="javascript:window.print();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
					</a>
				</span>
			</p>
		</div>
		<!--
		<h1 class="titlePage" style="float:left;width:70%;padding-left:10%;padding-bottom:5px;">
                    <a id="conEtiquetas" href="javascript:abrirEtiqueta(true);" style="text-decoration:none;display:none;">
					<img src="http://www.newco.dev.br/images/tagsAma.png" width="20px">
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_mas_nueva_etiqueta']/node()"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_mas_nueva_etiqueta']/node()"/></xsl:attribute>
					</img>
				</a>&nbsp;

				<a id="sinEtiquetas" href="javascript:abrirEtiqueta(false);" style="text-decoration:none;display:none;">
					<img src="http://www.newco.dev.br/images/tags.png" width="20px">
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta']/node()"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta']/node()"/></xsl:attribute>
					</img>
				</a>&nbsp;

                    <xsl:if test="/EvaluacionProducto/OK">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion_guardada_exito']/node()"/>&nbsp;&nbsp;
                    </xsl:if>
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion_producto']/node()"/>&nbsp;
                    <xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_CODIGO"/>:&nbsp;
                        <xsl:value-of select="substring(/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBRE,0,50)"/>&nbsp;

                        <xsl:if test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_REFCLIENTE != ''">
                            &nbsp;-&nbsp;
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:&nbsp;
                            <xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_REFCLIENTE"/>
                        </xsl:if>
                        &nbsp;&nbsp;<a href="javascript:window.print();" title="Imprimir" style="text-decoration:none;">
					<img src="http://www.newco.dev.br/images/imprimir.gif" style="margin-top:-5px;" alt="Imprimir" />
				</a>
                        &nbsp;&nbsp;
                        <xsl:if test="$usuario = 'CDC'"><!- -solo usuarios cdc pueden copiar evaluacion 24-8-15mc- ->
						<xsl:choose>
                                    <xsl:when test="EvaluacionProducto/LANG != 'spanish'">
                                                <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/EvaluacionProductoCopia.xsql?ID_EVAL={/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_ID}','evaluacion',100,80,0,0)" title="C�pia" style="text-decoration:none;">
                                                    <img src="http://www.newco.dev.br/images/copiar-BR.gif" style="margin-top:-5px;" alt="C�pia" />
                                                </a>
                                    </xsl:when>
                                    <xsl:otherwise>
                                                <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/EvaluacionProductoCopia.xsql?ID_EVAL={/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_ID}','evaluacion',100,80,0,0)" title="Copiar" style="text-decoration:none;">
                                                    <img src="http://www.newco.dev.br/images/copiar.gif" style="margin-top:-5px;" alt="Copiar" />
                                                </a>
                                    </xsl:otherwise>
                                </xsl:choose>
                        </xsl:if>

                </h1>
                <h1 class="titlePage" style="float:left;width:20%;padding-bottom:5px;">
				<xsl:if test="/EvaluacionProducto/EVALUACIONPRODUCTO/MVMB or /EvaluacionProducto/EVALUACIONPRODUCTO/MVM or /EvaluacionProducto/EVALUACIONPRODUCTO/ADMIN"><span style="float:right; padding:5px; font-weight:bold;" class="amarillo">EV_ID: <xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_ID"/></span></xsl:if>
		</h1>
		-->


		<form class="formEstandar" name="EvaluacionProducto" method="post">
		<input type="hidden" name="EVA_ID" id="EVA_ID" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_ID}"/>
		<input type="hidden" name="DOC_EVAL" id="DOC_EVAL"/>
		<input type="hidden" name="ESTADO" id="ESTADO" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO}"/>

		<xsl:if test="ESTADO='N'">
    		<input type="hidden" name="MUESTRAS_PROBADAS" id="MUESTRAS_PROBADAS"/>
    		<input type="hidden" name="DIAGNOSTICO" id="DIAGNOSTICO"/>
    		<input type="hidden" name="DOC_EVAL" id="DOC_EVAL"/>
    		<input type="hidden" name="FICHA_TECNICA" id="FICHA_TECNICA"/>
		</xsl:if>

		<!-- Inputs Carga Documentos -->
		<input type="hidden" name="ID_USUARIO" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO}"/>
		<input type="hidden" name="IDPROVEEDOR" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDPROVEEDOR}"/>
		<input type="hidden" name="REMOVE" value="{document($doc)/translation/texts/item[@name='remove']/node()}"/>
		<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
		<input type="hidden" name="BORRAR_ANTERIORES"/>
		<input type="hidden" name="CADENA_DOCUMENTOS"/>
		<input type="hidden" name="TIPO_DOC_DB" id="TIPO_DOC_DB"/>
		<input type="hidden" name="TIPO_DOC_HTML" id="TIPO_DOC_HTML"/>
		<input type="hidden" name="PROD_INC_IDDOCINCIDENCIA" id="DOC_INC" value="{EvaluacionProducto/EVALUACIONPRODUCTO/DOCUMENTO_INCIDENCIA/ID}"/>
		<input type="hidden" name="PROD_INC_IDDOCDIAGNOSTICO" id="DOC_DIAG" value="{EvaluacionProducto/EVALUACIONPRODUCTO/DOCUMENTO_DIAGNOSTICO/ID}"/>
		<input type="hidden" name="PROD_INC_IDDOCSOLUCION" id="DOC_SOL" value="{EvaluacionProducto/EVALUACIONPRODUCTO/DOCUMENTO_SOLUCION/ID}"/>
    	<div>
        	<ul style="width:1000px;">
             	<li>
					<label>&nbsp;</label>
                    <xsl:choose>
                    <xsl:when test="/EvaluacionProducto/LANG = 'spanish'">
                        <xsl:choose>
                            <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'N'">
                                <img src="http://www.newco.dev.br/images/step2eva.gif" alt="Paso 2 - Muestras" />
                            </xsl:when>
                            <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'P'">
                                <img src="http://www.newco.dev.br/images/step3eva.gif" alt="Paso 3 - Evaluaci�n" />
                            </xsl:when>
                            <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'I'">
                                <img src="http://www.newco.dev.br/images/step4eva.gif" alt="Paso 4 - Resultado evaluaci�n" />
                            </xsl:when>
                            <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'C'">
                                <img src="http://www.newco.dev.br/images/step5eva.gif" alt="Paso 5 - Finalizada" />
                            </xsl:when>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'N'">
                                <img src="http://www.newco.dev.br/images/step2eva-BR.gif" alt="Paso 2 - Amostras" />
                            </xsl:when>
                            <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'P'">
                                <img src="http://www.newco.dev.br/images/step3eva-BR.gif" alt="Paso 3 - Avalia��o" />
                            </xsl:when>
                            <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'I'">
                                <img src="http://www.newco.dev.br/images/step4eva-BR.gif" alt="Paso 4 - Avalia��o de resultados" />
                            </xsl:when>
                            <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'C'">
                                <img src="http://www.newco.dev.br/images/step5eva-BR.gif" alt="Paso 5 - Terminado" />
                            </xsl:when>
                        </xsl:choose>
                    </xsl:otherwise>
                    </xsl:choose>
            	</li>
            	<li>
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='datos_producto']/node()"/></strong>
            	</li>
				<xsl:if test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_REFCLIENTE != ''">
					<li class="datosProductoEstandard">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:</label>
						<xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_REFCLIENTE"/>
					</li>
				</xsl:if>
				<li class="datosProductoEstandard">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_mvm']/node()"/>:</label>
					<xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_REFERENCIA"/>
				</li>
				<li class="datosProductoEstandard">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</label>
                    <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID={/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDPRODUCTO}','Detalle producto',100,80,0,0);">
                        <xsl:copy-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBRE"/>
                    </a>
				</li>
				<li class="datosProductoEstandard">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>:</label>
                    <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID={/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDPRODUCTO}','Detalle producto',100,80,0,0);">
                        <xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_REFPROVEEDOR"/>
                    </a>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label>
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDPROVEEDOR}','DetalleEmpresa',100,80,0,0);">
						<xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROVEEDOR"/>
					</a>
				</li>
				<li class="datosProducto">
					<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label>
					<xsl:copy-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBREPROVEEDOR"/>
				</li>
				<li>
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_evaluacion']/node()"/></strong>
				</li>
				<li>
					<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</label>
                    <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDCENTROEVALUACION}','Centro',100,80,0,-20);">
                    <xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/CENTROEVALUACION"/>
                    </a>
				</li>
				<li class="usuarioCoordinador">
					<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='usuario_coordinador']/node()"/>:</label>
					<xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/USUARIOCOORDINADOR"/>&nbsp;
					<a href="mailto:{/EvaluacionProducto/EVALUACIONPRODUCTO/MAILUSUARIOCOORDINADOR}?subject=Evaluacion producto {/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBRE}" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/mail.gif" alt="e-mail" /></a>
				</li>
				<xsl:if test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOEVALUADOR != ''">
                    <input type="hidden" name="ID_USUARIO_EVALUADOR" id="ID_USUARIO_EVALUADOR" value="{EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOEVALUADOR}"/>
					<li>
						<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='usuario_evaluador_muestras']/node()"/>:</label>
						<xsl:copy-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/USUARIOEVALUADOR"/>&nbsp;
						<a href="mailto:{/EvaluacionProducto/EVALUACIONPRODUCTO/MAILUSUARIOEVALUADOR}?subject=Evaluacion producto {/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBRE}" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/mail.gif" alt="e-mail"/></a>
					</li>
				</xsl:if>
				<li>
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='datos_proveedor']/node()"/></strong>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label>
                    <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDPROVEEDOR}','DetalleEmpresa',100,80,0,0);">
                        <xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROVEEDOR" />
                    </a>
				</li>
				<li class="usuarioMuestras">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_muestras']/node()"/>:</label>
                    <xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/USUARIOMUESTRAS"/>&nbsp;
                    <a href="mailto:{/EvaluacionProducto/EVALUACIONPRODUCTO/MAILUSUARIOMUESTRAS}?subject=Evaluacion producto {/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBRE}" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/mail.gif" alt="e-mail"/></a>
				</li>
				<li>
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='motivo_evaluacion']/node()"/></strong>
				</li>
				<li>
					<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='motivo']/node()"/>:</label>
					<xsl:choose>
						<xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDMOTIVO = 'NUEVO'"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto_nueva_introduccion']/node()"/></xsl:when>
						<xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDMOTIVO = 'SUST'"><xsl:value-of select="document($doc)/translation/texts/item[@name='sostitucion_producto_existente']/node()"/></xsl:when>
						<xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDMOTIVO = 'REEV'"><xsl:value-of select="document($doc)/translation/texts/item[@name='reevaluacion_incidencias']/node()"/></xsl:when>
					</xsl:choose>&nbsp;
				</li>
				<li>
					<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='instrucciones_coordinador']/node()"/>:</label>
					<!--<xsl:copy-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_INSTRUCCIONES"/>&nbsp;-->
					<xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_INSTRUCCIONES"/>&nbsp;
				</li>
				<li>
					<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha_limite']/node()"/>:</label>
					<xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_FECHALIMITE"/>&nbsp;
				</li>
				<li>
					<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='num_muestras']/node()"/>:</label>
					<xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NUMEROMUESTRAS"/>
				</li>
                <xsl:choose>
                <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'N' and /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOMUESTRAS = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO">
					<li>
						<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha_envio_muestras']/node()"/>:<span class="camposObligatorios">*</span></label>
						<input type="text" name="FECHA_MUESTRAS" id="FECHA_MUESTRAS"/>&nbsp;dd/mm/aaaa
					</li>
				</xsl:when>
				<xsl:when test="(/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'P' and /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOMUESTRAS = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO) or /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'P' and (/EvaluacionProducto/EVALUACIONPRODUCTO/CDC or /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOCOORDINADOR = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO or /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOEVALUADOR = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO)">
					<xsl:if test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NUMEROMUESTRAS != '0'">
					<li>
						<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha_envio_muestras']/node()"/>:</label>
						<xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_FECHAENVIOMUESTRAS"/>
                        &nbsp;&nbsp;&nbsp;<span style="font-size:12px;padding:3px 8px;background:#F3F781;border:1px solid red;font-weight:bold;text-align:center;border-radius:5px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='muestras_enviadas']/node()"/></span>
					</li>
					</xsl:if>
				</xsl:when>
				</xsl:choose>
                <!--si provee ya ha enviado muestras y si es usuario coordinador o usuario que evalua muestras elegido de desplegable-->
                <xsl:if test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'P' and (/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOCOORDINADOR = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO or /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOEVALUADOR = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO)">
                    <input type="hidden" name="FECHA_MUESTRAS" id="FECHA_MUESTRAS" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_FECHAENVIOMUESTRAS}"/>
                    <input type="hidden" name="FICHA_TECNICA" id="FICHA_TECNICA"/>
                    <input type="hidden" name="DOC_EVAL" id="DOC_EVAL"/>
					<li>
                    	<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_pruebas_efectuadas']/node()"/></strong>
					</li>
					<xsl:if test="not(/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOEVALUADOR)">
						<li>
							<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='usuario_evaluador_muestras']/node()"/>:<span class="camposObligatorios">*</span></label>
							<input type="text" name="USUARIO_EVALUADOR" id="USUARIO_EVALUADOR"/>
						</li>
					</xsl:if>
					<li>
						<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='evaluacion']/node()"/>:<span class="camposObligatorios">*</span></label>
						<textarea name="EVALUACION" id="EVALUACION" rows="4" cols="60"></textarea>
					</li>
					<li>
						<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='numero_muestras_probadas']/node()"/>:<span class="camposObligatorios">*</span></label>
                        <input type="text" name="MUESTRAS_PROBADAS" id="MUESTRAS_PROBADAS">
                            <xsl:attribute name="value">
                                <xsl:if test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NUMEROMUESTRAS = '0'">0</xsl:if>
                            </xsl:attribute>
                        </input>
					</li>
					<li>
                        <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='resultado_evaluacion']/node()"/></strong>
					</li>
					<li>
						<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='diagnostico']/node()"/>:<span class="camposObligatorios">*</span></label>
                        <input name="DIAGNOSTICO" id="DIAGNOSTICO" type="hidden"/>
                        <input type="radio" name="DIAGNOSTICO_VALUES" id="DIAGNOSTICO_APTO" value="APTO">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='apto']/node()"/></input>&nbsp;&nbsp;
                        <input type="radio" name="DIAGNOSTICO_VALUES" id="DIAGNOSTICO_NO_APTO" value="NOAPTO">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='no_apto']/node()"/></input>&nbsp;&nbsp;
                        <input type="radio" name="DIAGNOSTICO_VALUES" id="DIAGNOSTICO_NO_PROCEDE" value="NOPROCEDE">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='no_procede']/node()"/></input>
					</li>
					<li class="expliNoApto" style="display:none;">
						<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='expli_no_apto']/node()"/>:<span class="camposObligatorios">*</span></label>
						<textarea name="EXPLI_NO_APTO" id="EXPLI_NO_APTO" rows="4" cols="60"></textarea>
					</li>
					<li class="expliNoApto" style="display:none;">
						<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='documento_incidencia']/node()"/>:</label>
						<span id="newDocEVAL" align="center">
							<a href="javascript:verCargaDoc('EVAL');" title="Subir documento" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/subirDocumento.gif" alt="Subir Documento" title="Subir Documento"/>
							</a>
						</span>&nbsp;
						<span id="docBoxEVAL" style="display:none;" align="center"></span>&nbsp;
						<span id="borraDocEVAL" style="display:none;" align="center"></span>
					</li>
					<li id="cargaEVAL" class="cargas" style="display:none;">
						<xsl:call-template name="CargaDocumentos"><xsl:with-param name="tipo">EVAL</xsl:with-param></xsl:call-template>
					</li>
				</xsl:if>
				<xsl:if test="(/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'I' or /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'C') and (/EvaluacionProducto/EVALUACIONPRODUCTO/CDC or /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOCOORDINADOR = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO or /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOEVALUADOR = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO)">
					<input type="hidden" name="MUESTRAS_PROBADAS" id="MUESTRAS_PROBADAS" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_MUESTRASPROBADAS}"/>
					<input type="hidden" name="EVALUACION" id="EVALUACION" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_INSTRUCCIONES}"/>
					<input type="hidden" name="DIAGNOSTICO" id="DIAGNOSTICO" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_EVALUACION}"/>
					<input type="hidden" name="FECHA_MUESTRAS" id="FECHA_MUESTRAS" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_FECHAENVIOMUESTRAS}"/>
					<input type="hidden" name="US_EVAL" id="US_EVAL" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_USUARIOEVALUACION}"/>
					<input type="hidden" name="FICHA_TECNICA" id="FICHA_TECNICA"/>
					<input type="hidden" name="DOC_EVAL" id="DOC_EVAL"/>
					<li>
						<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha_envio_muestras']/node()"/>:</label>
						<xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_FECHAENVIOMUESTRAS"/>>
					</li>
					<li>
                        <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='resultado_evaluacion']/node()"/></strong>
					</li>
                    <xsl:if test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_USUARIOEVALUACION != ''">
						<li>
							<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='usuario_evaluador_muestras']/node()"/>:</label>
							<xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_USUARIOEVALUACION"/>
						</li>
					</xsl:if>
					<li>
						<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='evaluacion']/node()"/>:</label>
						<xsl:copy-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_EVALUACION"/>
					</li>
					<li>
						<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='numero_muestras_probadas']/node()"/>:</label>
                        <xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_MUESTRASPROBADAS"/>
					</li>
					<li>
						<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='diagnostico']/node()"/>:</label>
                        <span style="font-size:12px;padding:3px 8px;background:#F3F781;border:1px solid red;font-weight:bold;text-align:center;border-radius:5px;">
                            <xsl:choose>
                                <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_DIAGNOSTICO = 'NOAPTO'">
                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='no_apto_maiu']/node()"/>
                                </xsl:when>
                                <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_DIAGNOSTICO = 'APTO'">
                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='apto_maiu']/node()"/>
                                 </xsl:when>
                                 <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_DIAGNOSTICO = 'NOPROCEDE'">
                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='no_procede_maiu']/node()"/>
                                 </xsl:when>
                            </xsl:choose>
                        </span>
					</li>
					<xsl:if test="(/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_DIAGNOSTICO = 'NOAPTO' or /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_DIAGNOSTICO = 'NOPROCEDE') and /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_EXPLICACION_NOAPTO != '' ">
					<li><label>
                        <xsl:choose>
                            <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_DIAGNOSTICO = 'APTO'">
                                <xsl:value-of select="document($doc)/translation/texts/item[@name='apto_maiu']/node()"/>
                             </xsl:when>
                             <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_DIAGNOSTICO = 'NOPROCEDE'">
                                <xsl:value-of select="document($doc)/translation/texts/item[@name='no_procede_maiu']/node()"/>
                             </xsl:when>
							 <xsl:otherwise>
                                <xsl:value-of select="document($doc)/translation/texts/item[@name='explicacion']/node()"/>
							 </xsl:otherwise>
                        </xsl:choose>:&nbsp;</label>
						<xsl:copy-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_EXPLICACION_NOAPTO"/>
					</li>
					</xsl:if>
					<xsl:if test="/EvaluacionProducto/EVALUACIONPRODUCTO/DOCUMENTO_EVALUACION/NOMBRE != ''">
						<li>
							<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='documento']/node()"/>:</label>
							<a href="http://www.newco.dev.br/Documentos/{/EvaluacionProducto/EVALUACIONPRODUCTO/DOCUMENTO_EVALUACION/URL}" target="_blank">
								<xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/DOCUMENTO_EVALUACION/NOMBRE"/>
							</a>
						</li>
                    </xsl:if>
                </xsl:if>
				<xsl:if test="(/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'N' and /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOMUESTRAS= /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO) or (/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'I' and /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIO = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO) or (/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'P' and (/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOCOORDINADOR = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO or /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOEVALUADOR = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO))">
					<li>
					<xsl:choose>
					<xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'N' and /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOMUESTRAS= /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO">
					<div class="boton">
					<a href="javascript:errorCheck(document.forms['EvaluacionProducto']);">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='muestras_enviadas']/node()"/>
					</a>
					</div>
					</xsl:when>
					<xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'P' and (/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOCOORDINADOR = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO or /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOEVALUADOR = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO)">
					<div class="boton">
					<a href="javascript:errorCheck(document.forms['EvaluacionProducto']);">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/>
					</a>
					</div>
					</xsl:when>
					<xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'I' and /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIO = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO">
					<div class="boton">
					<a href="javascript:FinalizarEvaluacion(document.forms['EvaluacionProducto']);">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='finalizar']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion']/node()"/>
					</a>
					</div>
					</xsl:when>
					</xsl:choose>
					</li>
				</xsl:if>
    	   	</ul>
		</div>
 	</form>


			
<!--
		<form name="EvaluacionProducto" method="post">

			<input type="hidden" name="EVA_ID" id="EVA_ID" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_ID}"/>
                        <input type="hidden" name="DOC_EVAL" id="DOC_EVAL"/>
                        <input type="hidden" name="ESTADO" id="ESTADO" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO}"/>

                        <xsl:if test="ESTADO='N'">
                            <input type="hidden" name="MUESTRAS_PROBADAS" id="MUESTRAS_PROBADAS"/>
                            <input type="hidden" name="DIAGNOSTICO" id="DIAGNOSTICO"/>
                            <input type="hidden" name="DOC_EVAL" id="DOC_EVAL"/>
                            <input type="hidden" name="FICHA_TECNICA" id="FICHA_TECNICA"/>
                        </xsl:if>
			<!- - Inputs Carga Documentos - ->
			<input type="hidden" name="ID_USUARIO" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO}"/>
			<input type="hidden" name="IDPROVEEDOR" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDPROVEEDOR}"/>
			<input type="hidden" name="REMOVE" value="{document($doc)/translation/texts/item[@name='remove']/node()}"/>
			<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
			<input type="hidden" name="BORRAR_ANTERIORES"/>
			<input type="hidden" name="CADENA_DOCUMENTOS"/>
			<input type="hidden" name="TIPO_DOC_DB" id="TIPO_DOC_DB"/>
			<input type="hidden" name="TIPO_DOC_HTML" id="TIPO_DOC_HTML"/>
			<input type="hidden" name="PROD_INC_IDDOCINCIDENCIA" id="DOC_INC" value="{EvaluacionProducto/EVALUACIONPRODUCTO/DOCUMENTO_INCIDENCIA/ID}"/>
			<input type="hidden" name="PROD_INC_IDDOCDIAGNOSTICO" id="DOC_DIAG" value="{EvaluacionProducto/EVALUACIONPRODUCTO/DOCUMENTO_DIAGNOSTICO/ID}"/>
			<input type="hidden" name="PROD_INC_IDDOCSOLUCION" id="DOC_SOL" value="{EvaluacionProducto/EVALUACIONPRODUCTO/DOCUMENTO_SOLUCION/ID}"/>

                       <div class="divLeft5">&nbsp;</div>
                        <div class="divLeft90">

                        <table class="infoTable incidencias" cellspacing="5" border="0">
                                <tr>
                                        <td class="labelRight trenta">&nbsp;</td>
					<td class="datosLeft">
                                            <xsl:choose>
                                            <xsl:when test="/EvaluacionProducto/LANG = 'spanish'">
                                                <xsl:choose>
                                                    <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'N'">
                                                        <img src="http://www.newco.dev.br/images/step2eva.gif" alt="Paso 2 - Muestras" />
                                                    </xsl:when>
                                                    <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'P'">
                                                        <img src="http://www.newco.dev.br/images/step3eva.gif" alt="Paso 3 - Evaluaci�n" />
                                                    </xsl:when>
                                                    <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'I'">
                                                        <img src="http://www.newco.dev.br/images/step4eva.gif" alt="Paso 4 - Resultado evaluaci�n" />
                                                    </xsl:when>
                                                    <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'C'">
                                                        <img src="http://www.newco.dev.br/images/step5eva.gif" alt="Paso 5 - Finalizada" />
                                                    </xsl:when>
                                                </xsl:choose>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:choose>
                                                    <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'N'">
                                                        <img src="http://www.newco.dev.br/images/step2eva-BR.gif" alt="Paso 2 - Amostras" />
                                                    </xsl:when>
                                                    <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'P'">
                                                        <img src="http://www.newco.dev.br/images/step3eva-BR.gif" alt="Paso 3 - Avalia��o" />
                                                    </xsl:when>
                                                    <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'I'">
                                                        <img src="http://www.newco.dev.br/images/step4eva-BR.gif" alt="Paso 4 - Avalia��o de resultados" />
                                                    </xsl:when>
                                                    <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'C'">
                                                        <img src="http://www.newco.dev.br/images/step5eva-BR.gif" alt="Paso 5 - Terminado" />
                                                    </xsl:when>
                                                </xsl:choose>
                                            </xsl:otherwise>
                                            </xsl:choose>
					</td>
				</tr>
                                <tr>
                                        <td class="labelRight trenta">&nbsp;</td>
					<td class="title">
                                                <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='datos_producto']/node()"/></strong>
					</td>
				</tr>
                                <!- -datos producto que recupero con ajax desde la ref y id empresa o id prod- ->
                                <xsl:if test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_REFCLIENTE != ''">
                                    <tr class="datosProductoEstandard">
                                            <td class="labelRight grisMed">
                                                        <xsl:copy-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>
                                            </td>
                                            <td class="datosLeft"><xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_REFCLIENTE"/></td>

                                    </tr>
                                </xsl:if>
                                <tr class="datosProductoEstandard">
                                            <td class="labelRight grisMed">
                                                        <xsl:copy-of select="document($doc)/translation/texts/item[@name='ref_mvm']/node()"/>
                                            </td>
                                            <td class="datosLeft"><xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_REFERENCIA"/></td>
                                </tr>
                                 <tr class="datosProductoEstandard">
                                             <td class="labelRight grisMed">
                                                        <xsl:copy-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>
                                            </td>
                                            <td class="datosLeft">
                                                <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID={/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDPRODUCTO}','Detalle producto',100,80,0,0);">
                                                    <xsl:copy-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBRE"/>
                                                </a>
                                            </td>
                                </tr>

                                <tr class="datosProducto">
                                            <td class="labelRight grisMed">
                                                        <xsl:copy-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>
                                            </td>
                                            <td class="datosLeft">
                                                <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID={/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDPRODUCTO}','Detalle producto',100,80,0,0);">
                                                    <xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_REFPROVEEDOR"/>
                                                </a>
                                            </td>
                                </tr>
                                <!- - proveedor que envia las muestras- ->
				<tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:&nbsp;
					</td>
					<td class="datosLeft">
                                           <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDPROVEEDOR}','DetalleEmpresa',100,80,0,0);">
                                            <xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROVEEDOR"/>
                                           </a>
                                        </td>
				</tr>
                                <tr class="datosProducto">
                                            <td class="labelRight grisMed">
                                                        <xsl:copy-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:
                                            </td>
                                            <td class="datosLeft">
                                                <xsl:copy-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBREPROVEEDOR"/>
                                            </td>
                                </tr>
                        </table>

                      <!- -centro evaluaci�n- ->

                        <table class="infoTable incidencias" cellspacing="5" border="0">
                                <!- - centro evaluacion - ->
                                <tr class="line"><td colspan="2">&nbsp;</td></tr>
                                <tr>
                                        <td class="labelRight trenta">&nbsp;</td>
					<td class="title">
                                                <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_evaluacion']/node()"/></strong>
					</td>
				</tr>
				<tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;
					</td>
					<td class="datosLeft">
                                            <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDCENTROEVALUACION}','Centro',100,80,0,-20);">
                                            <xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/CENTROEVALUACION"/>
                                            </a>
                                        </td>
				</tr>
                                <!- - usuarios del centro, COORDINADOR - ->
				<tr class="usuarioCoordinador">
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_coordinador']/node()"/>:&nbsp;
					</td>
					<td class="datosLeft">
                                           <xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/USUARIOCOORDINADOR"/>&nbsp;
                                           <a href="mailto:{/EvaluacionProducto/EVALUACIONPRODUCTO/MAILUSUARIOCOORDINADOR}?subject=Evaluacion producto {/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBRE}" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/mail.gif" alt="e-mail" /></a>
                                        </td>
				</tr>
                                <!- - usuario evaluador con id elegido por desplegable- ->
                                <xsl:if test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOEVALUADOR != ''">
                                <input type="hidden" name="ID_USUARIO_EVALUADOR" id="ID_USUARIO_EVALUADOR" value="{EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOEVALUADOR}"/>
				<tr>
					<td class="veinte labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_evaluador_muestras']/node()"/>:&nbsp;
					</td>
					<td class="datosLeft"><xsl:copy-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/USUARIOEVALUADOR"/>&nbsp;
                                            <a href="mailto:{/EvaluacionProducto/EVALUACIONPRODUCTO/MAILUSUARIOEVALUADOR}?subject=Evaluacion producto {/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBRE}" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/mail.gif" alt="e-mail"/></a>
                                        </td>
				</tr>
                                </xsl:if>
                                <!- - usuarios del proveedor que envia las muestras- ->
                                <tr class="line"><td colspan="2">&nbsp;</td></tr>
                                <tr>
                                        <td class="labelRight trenta">&nbsp;</td>
					<td class="title">
                                                <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='datos_proveedor']/node()"/></strong>
					</td>
				</tr>
                                <tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:&nbsp;
					</td>
					<td class="datosLeft" >
                                            <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDPROVEEDOR}','DetalleEmpresa',100,80,0,0);">
                                                <xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROVEEDOR" />
                                            </a>
                                        </td>
				</tr>
				<tr class="usuarioMuestras">
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_muestras']/node()"/>:&nbsp;
					</td>
					<td class="datosLeft" >
                                            <xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/USUARIOMUESTRAS"/>&nbsp;
                                            <a href="mailto:{/EvaluacionProducto/EVALUACIONPRODUCTO/MAILUSUARIOMUESTRAS}?subject=Evaluacion producto {/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBRE}" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/mail.gif" alt="e-mail"/></a>
                                        </td>
				</tr>
                            </table>
                     <!- -motivo evaluaci�n- ->
                            <table class="infoTable incidencias" cellspacing="5" style="border-bottom:2px solid #D7D8D7;">
				<!- - motivo evaluacion - ->
                                <tr class="line"><td colspan="2">&nbsp;</td></tr>
                                <tr>
                                        <td class="labelRight trenta">&nbsp;</td>
					<td class="title">
                                                <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='motivo_evaluacion']/node()"/></strong>
					</td>
				</tr>

				<tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='motivo']/node()"/>:&nbsp;
					</td>
					<td class="datosLeft">
                                            <xsl:choose>
                                                <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDMOTIVO = 'NUEVO'"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto_nueva_introduccion']/node()"/></xsl:when>
                                                <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDMOTIVO = 'SUST'"><xsl:value-of select="document($doc)/translation/texts/item[@name='sostitucion_producto_existente']/node()"/></xsl:when>
                                                <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDMOTIVO = 'REEV'"><xsl:value-of select="document($doc)/translation/texts/item[@name='reevaluacion_incidencias']/node()"/></xsl:when>
                                             </xsl:choose>
                                        </td>
				</tr>
                                <!- - INSTRUCCIONES evaluacion - ->
				<tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='instrucciones_coordinador']/node()"/>:&nbsp;
					</td>
					<td class="datosLeft"><xsl:copy-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_INSTRUCCIONES"/>
                                        </td>
				</tr>

                                <!- - fecha limite evaluacion - ->
				<tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_limite']/node()"/>:&nbsp;
					</td>
					<td class="datosLeft"><xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_FECHALIMITE"/></td>
				</tr>
                                <!- - num muestras evaluacion - ->
				<tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='num_muestras']/node()"/>:&nbsp;
					</td>
					<td class="datosLeft"><xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NUMEROMUESTRAS"/>
                                        </td>
				</tr>

                                <!- -si es proveedor informa fecha envio muestras- ->
                                <xsl:choose>
                                <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'N' and /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOMUESTRAS = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO">

				<tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_envio_muestras']/node()"/>:&nbsp;
                                                <span class="camposObligatorios">*</span>
					</td>
					<td class="datosLeft">
                                            <input type="text" name="FECHA_MUESTRAS" id="FECHA_MUESTRAS"/>&nbsp;dd/mm/aaaa
                                        </td>
				</tr>
                                </xsl:when>
                                <!- -si es cdc o usuario evaluador o us coordinador ense�o fecha envio muestras o si es proveedor desp que guarda fecha envio muestras 24-08-15mc- ->

                                <xsl:when test="(/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'P' and /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOMUESTRAS = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO) or /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'P' and (/EvaluacionProducto/EVALUACIONPRODUCTO/CDC or /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOCOORDINADOR = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO or /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOEVALUADOR = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO)">
                                    <xsl:if test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NUMEROMUESTRAS != '0'">
                                    <tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_envio_muestras']/node()"/>:&nbsp;
                                                <xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NUMEROMUESTRAS"/>
					</td>
					<td class="datosLeft"><xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_FECHAENVIOMUESTRAS"/>
                                        &nbsp;&nbsp;&nbsp;<span style="font-size:12px;padding:3px 8px;background:#F3F781;border:1px solid red;font-weight:bold;text-align:center;border-radius:5px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='muestras_enviadas']/node()"/></span></td>
                                    </tr>
                                    </xsl:if>
                                </xsl:when>
                                </xsl:choose>


                            <!- -si provee ya ha enviado muestras y si es usuario coordinador o usuario que evalua muestras elegido de desplegable- ->
                            <xsl:if test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'P' and (/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOCOORDINADOR = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO or /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOEVALUADOR = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO)">

                                <input type="hidden" name="FECHA_MUESTRAS" id="FECHA_MUESTRAS" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_FECHAENVIOMUESTRAS}"/>
                                <input type="hidden" name="FICHA_TECNICA" id="FICHA_TECNICA"/>
                                <input type="hidden" name="DOC_EVAL" id="DOC_EVAL"/>

                                <tr><td colspan="2">&nbsp;</td></tr>
                                <tr>
                                        <td class="labelRight grisMed">
					</td>
					<td class="datosLeft">
                                            <span style="padding:3px 12px; background:#D3D3D3;border-radius:5px;">
                                                <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_pruebas_efectuadas']/node()"/></strong>
                                            </span>
					</td>
				</tr>
                                <xsl:if test="not(/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOEVALUADOR)">
                                <tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_evaluador_muestras']/node()"/>:&nbsp;
						<span class="camposObligatorios">*</span>
					</td>
					<td class="datosLeft">
                                            <input type="text" name="USUARIO_EVALUADOR" id="USUARIO_EVALUADOR"/>
                                        </td>
				</tr>
                                </xsl:if>
                                <tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion']/node()"/>:&nbsp;
						<span class="camposObligatorios">*</span>
					</td>
					<td class="datosLeft"><textarea name="EVALUACION" id="EVALUACION" rows="4" cols="60"></textarea></td>
				</tr>
                                 <tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='numero_muestras_probadas']/node()"/>:&nbsp;
						<span class="camposObligatorios">*</span>
					</td>
					<td class="datosLeft">
                                            <input type="text" name="MUESTRAS_PROBADAS" id="MUESTRAS_PROBADAS">
                                                <xsl:attribute name="value">
                                                    <xsl:if test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NUMEROMUESTRAS = '0'">0</xsl:if>
                                                </xsl:attribute>
                                            </input>
                                        </td>
				</tr>
                                <tr class="line"><td colspan="2">&nbsp;</td></tr>
                                <tr>
                                        <td class="labelRight">&nbsp;</td>
					<td class="datosLeft">
                                                <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='resultado_evaluacion']/node()"/></strong>
					</td>
				</tr>
                                <tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='diagnostico']/node()"/>:&nbsp;
						<span class="camposObligatorios">*</span>
					</td>
					<td class="datosLeft">
                                            <input name="DIAGNOSTICO" id="DIAGNOSTICO" type="hidden"/>
                                            <input type="radio" name="DIAGNOSTICO_VALUES" id="DIAGNOSTICO_APTO" value="APTO">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='apto']/node()"/></input>&nbsp;&nbsp;
                                            <input type="radio" name="DIAGNOSTICO_VALUES" id="DIAGNOSTICO_NO_APTO" value="NOAPTO">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='no_apto']/node()"/></input>&nbsp;&nbsp;
                                            <input type="radio" name="DIAGNOSTICO_VALUES" id="DIAGNOSTICO_NO_PROCEDE" value="NOPROCEDE">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='no_procede']/node()"/></input>
                                        </td>
				</tr>
                                 <tr class="expliNoApto" style="display:none;">
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='expli_no_apto']/node()"/>:&nbsp;
						<span class="camposObligatorios">*</span>
					</td>
					<td class="datosLeft"><textarea name="EXPLI_NO_APTO" id="EXPLI_NO_APTO" rows="4" cols="60"></textarea></td>
				</tr>
				<tr>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_incidencia']/node()"/>:</td>
					<td class="datosLeft">
						<span id="newDocEVAL" align="center">
							<a href="javascript:verCargaDoc('EVAL');" title="Subir documento" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/subirDocumento.gif" alt="Subir Documento" title="Subir Documento"/>
							</a>
						</span>&nbsp;
						<span id="docBoxEVAL" style="display:none;" align="center"></span>&nbsp;
						<span id="borraDocEVAL" style="display:none;" align="center"></span>
					</td>
				</tr>
				<tr id="cargaEVAL" class="cargas" style="display:none;">
					<td colspan="2"><xsl:call-template name="CargaDocumentos"><xsl:with-param name="tipo">EVAL</xsl:with-param></xsl:call-template></td>
				</tr>
                            </xsl:if>

                             <!- -si usuario coordinador ha insertado evaluacion de muestras  estado = I  o estado C = cerrada- ->
                            <xsl:if test="(/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'I' or /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'C') and (/EvaluacionProducto/EVALUACIONPRODUCTO/CDC or /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOCOORDINADOR = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO or /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOEVALUADOR = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO)">

                                <input type="hidden" name="MUESTRAS_PROBADAS" id="MUESTRAS_PROBADAS" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_MUESTRASPROBADAS}"/>
                                <input type="hidden" name="EVALUACION" id="EVALUACION" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_INSTRUCCIONES}"/>
                                <input type="hidden" name="DIAGNOSTICO" id="DIAGNOSTICO" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_EVALUACION}"/>
                                <input type="hidden" name="FECHA_MUESTRAS" id="FECHA_MUESTRAS" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_FECHAENVIOMUESTRAS}"/>
                                <input type="hidden" name="US_EVAL" id="US_EVAL" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_USUARIOEVALUACION}"/>
                                <input type="hidden" name="FICHA_TECNICA" id="FICHA_TECNICA"/>
                                <input type="hidden" name="DOC_EVAL" id="DOC_EVAL"/>

                                 <!- - fecha envio muestras  - ->
				<tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_envio_muestras']/node()"/>:&nbsp;
					</td>
					<td class="datosLeft"><xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_FECHAENVIOMUESTRAS"/></td>
				</tr>

                                <tr class="line"><td colspan="2">&nbsp;</td></tr>
                                <tr>
                                        <td>&nbsp;</td>
					<td class="title">
                                                <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='resultado_evaluacion']/node()"/></strong>
					</td>
                                        <td>&nbsp;</td>
				</tr>
                                <xsl:if test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_USUARIOEVALUACION != ''">
                                <tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_evaluador_muestras']/node()"/>:&nbsp;
					</td>
					<td class="datosLeft">
                                            <xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_USUARIOEVALUACION"/>
                                        </td>
				</tr>
                                </xsl:if>
                                <tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion']/node()"/>:&nbsp;
					</td>
					<td class="datosLeft"><xsl:copy-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_EVALUACION"/></td>
				</tr>
                                 <tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='muestras_probadas']/node()"/>:&nbsp;
					</td>
					<td class="datosLeft">
                                            <xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_MUESTRASPROBADAS"/>
                                        </td>
				</tr>
                                <tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='diagnostico']/node()"/>:&nbsp;
					</td>
					<td class="datosLeft">
                                            <span style="font-size:12px;padding:3px 8px;background:#F3F781;border:1px solid red;font-weight:bold;text-align:center;border-radius:5px;">
                                                <xsl:choose>
                                                    <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_DIAGNOSTICO = 'NOAPTO'">
                                                        <xsl:value-of select="document($doc)/translation/texts/item[@name='no_apto_maiu']/node()"/>
                                                    </xsl:when>
                                                    <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_DIAGNOSTICO = 'APTO'">
                                                        <xsl:value-of select="document($doc)/translation/texts/item[@name='apto_maiu']/node()"/>
                                                     </xsl:when>
                                                     <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_DIAGNOSTICO = 'NOPROCEDE'">
                                                        <xsl:value-of select="document($doc)/translation/texts/item[@name='no_procede_maiu']/node()"/>
                                                     </xsl:when>
                                                </xsl:choose>
                                            </span>
                                        </td>
				</tr>
                                <xsl:if test="(/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_DIAGNOSTICO = 'NOAPTO' or /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_DIAGNOSTICO = 'NOPROCEDE') and /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_EXPLICACION_NOAPTO != '' ">
                                <tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='justificacion']/node()"/>&nbsp;
                                                <xsl:choose>
                                                    <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_DIAGNOSTICO = 'APTO'">
                                                        <xsl:value-of select="document($doc)/translation/texts/item[@name='apto_maiu']/node()"/>
                                                     </xsl:when>
                                                     <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_DIAGNOSTICO = 'NOPROCEDE'">
                                                        <xsl:value-of select="document($doc)/translation/texts/item[@name='no_procede_maiu']/node()"/>
                                                     </xsl:when>
                                                </xsl:choose>:&nbsp;
					</td>
					<td class="datosLeft"><xsl:copy-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_EXPLICACION_NOAPTO"/></td>
				</tr>
                                </xsl:if>

                                <xsl:if test="/EvaluacionProducto/EVALUACIONPRODUCTO/DOCUMENTO_EVALUACION/NOMBRE != ''">
                                <tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/>:&nbsp;
					</td>
					<td class="datosLeft">
                                            <a href="http://www.newco.dev.br/Documentos/{/EvaluacionProducto/EVALUACIONPRODUCTO/DOCUMENTO_EVALUACION/URL}" target="_blank">
						<xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/DOCUMENTO_EVALUACION/NOMBRE"/>
                                            </a>
                                        </td>
				</tr>
                                </xsl:if>
                            </xsl:if>
                            <xsl:if test="(/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'N' and /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOMUESTRAS= /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO) or (/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'I' and /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIO = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO) or (/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'P' and (/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOCOORDINADOR = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO or /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOEVALUADOR = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO))">
                            <tr>
                                <td colspan="2">&nbsp;</td>
			    </tr>
                            <!- -botones de la evaluaci�n- ->
				<tr>
					<td>&nbsp;</td>
					<td class="datosLeft">
                                            <xsl:choose>
                                            <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'N' and /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOMUESTRAS= /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO">
						<div class="boton">
							<a href="javascript:errorCheck(document.forms['EvaluacionProducto']);">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='muestras_enviadas']/node()"/>
							</a>
						</div>
                                            </xsl:when>
                                            <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'P' and (/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOCOORDINADOR = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO or /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOEVALUADOR = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO)">
						<div class="boton">
							<a href="javascript:errorCheck(document.forms['EvaluacionProducto']);">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/>
							</a>
						</div>
                                            </xsl:when>
                                            <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'I' and /EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIO = /EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO">
						<div class="boton">
							<a href="javascript:FinalizarEvaluacion(document.forms['EvaluacionProducto']);">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='finalizar']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion']/node()"/>
							</a>
						</div>
                                            </xsl:when>
                                            </xsl:choose>
					</td>
				</tr>
                            </xsl:if>
			</table>
                        <br /><br />
                    </div><!- -fin de divLeft- ->
		</form>
-->
		<!--frame para las imagenes-->
		<!--<div id="uploadFrameBox" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>-->
		<div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>

		<!--form de mensaje de error de js-->
		<form name="mensajeJS">
			<!--carga documentos-->
			<input type="hidden" name="ERROR_SIN_DEFINIR" value="{document($doc)/translation/texts/item[@name='error_sin_definir']/node()}"/>
			<input type="hidden" name="HEMOS_ESPERADO" value="{document($doc)/translation/texts/item[@name='hemos_esperado']/node()}"/>
			<input type="hidden" name="LA_CARGA_NO_TERMINO" value="{document($doc)/translation/texts/item[@name='la_carga_no_termino']/node()}"/>
		</form>

                <!-- DIV Nueva etiqueta -->
<div class="overlay-container" id="verEtiquetas">
	<div class="window-container zoomout">
		<p style="text-align:right;">
                    <a href="javascript:showTabla(false);" style="text-decoration:none;">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
                    </a>&nbsp;
                    <a href="javascript:showTabla(false);" style="text-decoration:none;">
                        <img src="http://www.newco.dev.br/images/cerrar.gif" alt="Cerrar" />
                    </a>
                </p>

		<p id="tableTitle">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='para']/node()"/>&nbsp;
			<xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_CODIGO"/>&nbsp;-&nbsp;
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion_producto']/node()"/>:&nbsp;
                        <xsl:value-of select="substring(/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBRE,0,50)"/>&nbsp;
<!--
			&nbsp;<a href="javascript:window.print();" style="text-decoration:none;">
				<img src="http://www.newco.dev.br/images/imprimir.gif">
					<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></xsl:attribute>
					<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></xsl:attribute>
				</img>
			</a>
-->
		</p>

		<div id="mensError" class="divLeft" style="display:none;">
			<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></strong></p>
		</div>

		<table id="viejasEtiquetas" border="0" style="width:100%;display:none;">
		<thead>
			<th colspan="5">&nbsp;</th>
		</thead>

		<tbody></tbody>

		</table>

		<form name="nuevaEtiquetaForm" method="post" id="nuevaEtiquetaForm">

		<table id="nuevaEtiqueta" style="width:100%;">
		<thead>
			<th colspan="3">&nbsp;</th>
		</thead>

		<tbody>
			<tr>
				<td class="quince"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='etiqueta']/node()"/>:</strong></td>
				<td colspan="2" style="text-align:left;"><textarea name="TEXTO" id="TEXTO" rows="4" cols="70" /></td>
			</tr>
		</tbody>

		<tfoot>
			<tr>
				<td>&nbsp;</td>
				<td>
					<div class="boton" id="botonGuardar">
						<a href="javascript:guardarEtiqueta();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
						</a>
					</div>
				</td>
				<td id="Respuesta" style="text-align:left;"></td>
			</tr>
		</tfoot>
		</table>
		</form>
	</div>
</div>
<!-- FIN DIV Nueva etiqueta -->
	</xsl:otherwise>
	</xsl:choose><!--fin choose si incidencia guardada con exito-->
	</div><!--fin de divLeft-->
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>

<!--template carga documentos-->
<xsl:template name="CargaDocumentos">
	<xsl:param name="tipo" />

	<!--idioma-->
	<xsl:variable name="lang"><xsl:value-of select="/EvaluacionProducto/LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="divLeft" id="cargaDoc{$tipo}">
		<!--tabla imagenes y documentos-->
		<table class="infoTable" border="0">
			<tr>
				<!--documentos-->
				<td class="labelRight quince">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='elige_documento']/node()"/>
				</td>
				<td class="datosLeft quince">
					<div class="altaDocumento">
						<span class="anadirDoc">
							<xsl:call-template name="documentos">
								<xsl:with-param name="num" select="number(1)"/>
								<xsl:with-param name="type" select="$tipo"/>
							</xsl:call-template>
						</span>
					</div>
				</td>
				<td>&nbsp;</td>
			</tr>
		</table><!--fin de tabla imagenes doc-->

		<div id="waitBoxDoc{$tipo}" align="center">&nbsp;</div>
	</div><!--fin de divleft-->
</xsl:template><!--fin de template carga documentos-->

<!--documentos-->
<xsl:template name="documentos">
	<xsl:param name="num"/>
	<xsl:param name="type"/>

	<xsl:choose>
	<xsl:when test="$num &lt; number(5)">
		<div class="docLine" id="docLine_{$type}">
			<div class="docLongEspec" id="docLongEspec_{$type}">
				<input id="inputFileDoc_{$type}" name="inputFileDoc" type="file" onChange="cargaDoc(document.forms['EvaluacionProducto'],'{$type}');"/>
			</div>
		</div>
	</xsl:when>
	</xsl:choose>
</xsl:template><!--fin de documentos-->
</xsl:stylesheet>
