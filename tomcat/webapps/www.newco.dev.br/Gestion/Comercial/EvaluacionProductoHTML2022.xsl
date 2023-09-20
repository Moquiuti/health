<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Evaluacion de producto. Nuevo disenno 2022.
	Ultima revision ET 11may22 11:50 EvaluacionesProducto2022_110522.js
-->
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

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/EvaluacionesProducto2022_110522.js"></script>

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
	<xsl:when test="/EvaluacionProducto/ERROR">
		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='error_evaluacion']/node()"/></h1>
	</xsl:when>
	<xsl:otherwise>
		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion_producto']/node()"/>&nbsp;
           		<xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_CODIGO"/>&nbsp;-&nbsp;
            	<xsl:value-of select="substring(/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBRE,0,50)"/>
				<xsl:if test="/EvaluacionProducto/OK">
                    :&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion_guardada_exito']/node()"/>
                </xsl:if>				
				<span class="CompletarTitulo">
                    <!--	11may22 Desactivado hasta poder probar este proceso de copia
					<xsl:if test="$usuario = 'CDC'">
						<a class="btnDestacado" href="javascript:CopiaEvaluacion('{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_ID}')">
                    		<xsl:value-of select="document($doc)/translation/texts/item[@name='Copiar']/node()"/>
                    	</a>
						&nbsp;
                    </xsl:if>-->
					<a class="btnNormal" href="javascript:Evaluaciones();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="javascript:window.print();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
					</a>
				</span>
			</p>
		</div>

		<form class="formEstandar" name="EvaluacionProducto" method="post">
		<input type="hidden" name="EVA_ID" id="EVA_ID" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_ID}"/>
		<input type="hidden" name="DOC_EVAL" id="DOC_EVAL"/>
		<input type="hidden" name="ESTADO" id="ESTADO" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO}"/>
		<input type="hidden" name="ACCION" id="ACCION" value=""/>

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
        	<ul class="w1000px">
             	<li>
					<label>&nbsp;</label>
                    <xsl:choose>
                    <xsl:when test="/EvaluacionProducto/LANG = 'spanish'">
                        <xsl:choose>
                            <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'N'">
                                <img src="http://www.newco.dev.br/images/step2eva.gif" alt="Paso 2 - Muestras" />
                            </xsl:when>
                            <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'P'">
                                <img src="http://www.newco.dev.br/images/step3eva.gif" alt="Paso 3 - Evaluación" />
                            </xsl:when>
                            <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'I'">
                                <img src="http://www.newco.dev.br/images/step4eva.gif" alt="Paso 4 - Resultado evaluación" />
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
                                <img src="http://www.newco.dev.br/images/step3eva-BR.gif" alt="Paso 3 - Avaliação" />
                            </xsl:when>
                            <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'I'">
                                <img src="http://www.newco.dev.br/images/step4eva-BR.gif" alt="Paso 4 - Avaliação de resultados" />
                            </xsl:when>
                            <xsl:when test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDESTADO = 'C'">
                                <img src="http://www.newco.dev.br/images/step5eva-BR.gif" alt="Paso 5 - Terminado" />
                            </xsl:when>
                        </xsl:choose>
                    </xsl:otherwise>
                    </xsl:choose>
            	</li>
				<br/>
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
                    <a href="javascript:FichaProducto('{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDPRODUCTO}');">
                        <xsl:copy-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBRE"/>
                    </a>
				</li>
				<li class="datosProductoEstandard">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>:</label>
                    <a href="javascript:FichaProducto('{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDPRODUCTO}');">
                        <xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_REFPROVEEDOR"/>
                    </a>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label>
					<a href="javascript:FichaEmpresa('{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDPROVEEDOR}');">
						<xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROVEEDOR"/>
					</a>
				</li>
				<li class="datosProducto">
					<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label>
					<xsl:copy-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBREPROVEEDOR"/>
				</li>
				<br/>
				<li>
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_evaluacion']/node()"/></strong>
				</li>
				<li>
					<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</label>
                    <a href="javascript:FichaCentro('{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDCENTROEVALUACION}');">
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
				<br/>
				<li>
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='datos_proveedor']/node()"/></strong>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label>
                    <a href="javascriptFichaEmpresa('{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDPROVEEDOR}');">
                        <xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROVEEDOR" />
                    </a>
				</li>
				<li class="usuarioMuestras">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_muestras']/node()"/>:</label>
                    <xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/USUARIOMUESTRAS"/>&nbsp;
                    <a href="mailto:{/EvaluacionProducto/EVALUACIONPRODUCTO/MAILUSUARIOMUESTRAS}?subject=Evaluacion producto {/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBRE}" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/mail.gif" alt="e-mail"/></a>
				</li>
				<br/>
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
					<br/>
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
					<br/>
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
					<br/>
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
