<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Nueva Evaluacion de producto. Nuevo disenno 2022.
	Ultima revision ET 11may22 15:30 EvaluacionesProducto2022_110522.js
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
		<xsl:when test="/NuevaEvaluacionProducto/LANG"><xsl:value-of select="/NuevaEvaluacionProducto/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_evaluacion_producto']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/EvaluacionesProducto2022_110522.js"></script>
	<script type="text/javascript">
		var centroClienteObli	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='centro_cliente_obli']/node()"/>';
        var instruccionesObli	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='instrucciones_obli']/node()"/>';
        var usuarioMuestrasObli	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_muestras_obli']/node()"/>';
        var usuarioCoorObli	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_coor_obli']/node()"/>';
        var motivoObli          = '<xsl:value-of select="document($doc)/translation/texts/item[@name='motivo_obli']/node()"/>';
        var fechaLimiteObli	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_limite_obli']/node()"/>';
        var numMuestrasObli	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='num_muestras_obli']/node()"/>';
        var usEvaluadorObli	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='us_evaluador_muestras_obli']/node()"/>';
        var codigoNoDisp	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_no_disponible']/node()"/>';
        var prodNoAdj	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='producto_no_adjudicado']/node()"/>';
        elegirInformarEvaluadorObli  = '<xsl:value-of select="document($doc)/translation/texts/item[@name='elegir_informar_evaluador_obli']/node()"/>';
        var soloNumeros    	    = '<xsl:value-of select="document($doc)/translation/texts/item[@name='solo_numeros']/node()"/>';
        var numMuestras             = '<xsl:value-of select="document($doc)/translation/texts/item[@name='num_muestras']/node()"/>';
        var numMuestrasProbadas     = '<xsl:value-of select="document($doc)/translation/texts/item[@name='numero_muestras_probadas']/node()"/>';
        var obliRecuperoDatos     = '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_recupero_datos']/node()"/>';
        var obliRecuperoDatosProveedor     = '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_recupero_datos_proveedor']/node()"/>';
	</script>
</head>
<!--<body class="gris">-->
<body>
    <xsl:attribute name="onload">
        <xsl:choose>
        <xsl:when test="NuevaEvaluacionProducto/PRO_ID != '' or NuevaEvaluacionProducto/ID_PROD_ESTANDAR != '' or NuevaEvaluacionProducto/LIC_OFE_ID != ''">RecuperarDatosProductoID();RecuperaUsuariosCentro();</xsl:when>
        <xsl:when test="NuevaEvaluacionProducto/REF_CLIENTE != ''">RecuperarDatosProducto();RecuperaUsuariosCentro();</xsl:when>
        <xsl:otherwise>RecuperaUsuariosCentro();</xsl:otherwise>
        </xsl:choose>
    </xsl:attribute>

<xsl:choose>
<xsl:when test="/NuevaEvaluacionProducto/SESION_CADUCADA">
	<xsl:for-each select="/NuevaEvaluacionProducto/SESION_CADUCADA">
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
		<xsl:when test="/NuevaEvaluacionProducto/LANG"><xsl:value-of select="/NuevaEvaluacionProducto/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:variable name="usuario">
	<xsl:choose>
		<xsl:when test="/NuevaEvaluacionProducto/PRODUCTO/PRODUCTO/INCIDENCIAS/CDC and /NuevaEvaluacionProducto/PRODUCTO/PRODUCTO/INCIDENCIAS/IDEMPRESAUSUARIO = /NuevaEvaluacionProducto/INCIDENCIA/PROD_INC_IDCLIENTE">CDC</xsl:when>
		<xsl:otherwise>NORMAL</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>

	<div class="divLeft">
	<xsl:choose>
	<xsl:when test="/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBRE != ''">
		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
           		<xsl:value-of select="/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_CODIGO"/>&nbsp;-&nbsp;
            	<xsl:value-of select="substring(/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBRE,0,50)"/>:&nbsp;
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion_guardada_exito']/node()"/>
				<span class="CompletarTitulo300">
					<a class="btnDestacado" href="javascript:Evaluaciones">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='evaluaciones']/node()"/>
                    </a>&nbsp;
				</span>
			</p>
		</div>
		<form class="formEstandar" name="EvaluacionProducto">
    	<div>
        	<ul class="w1000px">
            	<li>
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='datos_producto']/node()"/></strong>
            	</li>
                <xsl:if test="/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_REFCLIENTE != ''">
            		<li>
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:</label>
						<xsl:value-of select="/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_REFCLIENTE"/>
            		</li>
				</xsl:if>
            	<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_mvm']/node()"/>:</label>
					<xsl:value-of select="/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_REFERENCIA"/>
            	</li>
            	<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</label>
					<xsl:copy-of select="/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBRE"/>
            	</li>
            	<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</label>
					<xsl:copy-of select="/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBRE"/>
            	</li>
            	<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>:</label>
					<xsl:value-of select="/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_REFPROVEEDOR"/>
            	</li>
            	<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label>
					<xsl:value-of select="/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/PROVEEDOR"/>
            	</li>
            	<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</label>
					<xsl:copy-of select="/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBREPROVEEDOR"/>
            	</li>
				<br/>
            	<li>
 					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_evaluacion']/node()"/></strong>
				</li>
            	<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</label>
					<xsl:value-of select="/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/CENTROEVALUACION"/>
            	</li>
            	<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_coordinador']/node()"/>:</label>
					<xsl:value-of select="/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/USUARIOCOORDINADOR"/>&nbsp;
                    <a href="mailto:{/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/MAILUSUARIOCOORDINADOR}?subject=Evaluacion producto {/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBRE}" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/mail.gif" alt="e-mail" /></a>
                </li>
                <xsl:if test="/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOEVALUADOR != ''">
                	<input type="hidden" name="ID_USUARIO_EVALUADOR" id="ID_USUARIO_EVALUADOR" value="{NuevaEvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDUSUARIOEVALUADOR}"/>
             		<li>
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_evaluador_muestras']/node()"/>:</label>
						<xsl:copy-of select="/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/USUARIOEVALUADOR"/>&nbsp;
                        <a href="mailto:{/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/MAILUSUARIOEVALUADOR}?subject=Evaluacion producto {/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBRE}" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/mail.gif" alt="e-mail"/></a>
            		</li>
				</xsl:if>
				<br/>
            	<li>
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='datos_proveedor']/node()"/></strong>
				</li>
            	<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label>
					<xsl:value-of select="/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/PROVEEDOR"/>
            	</li>
            	<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_muestras']/node()"/>:</label>
					<xsl:value-of select="/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/USUARIOMUESTRAS"/>&nbsp;
                    <a href="mailto:{/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/MAILUSUARIOMUESTRAS}?subject=Evaluacion producto {/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBRE}" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/mail.gif" alt="e-mail"/></a>
            	</li>
				<br/>
            	<li>
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='motivo_evaluacion']/node()"/></strong>
				</li>
            	<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='motivo']/node()"/>:</label>
					<xsl:choose>
						<xsl:when test="/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDMOTIVO = 'NUEVO'"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto_nueva_introduccion']/node()"/></xsl:when>
						<xsl:when test="/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDMOTIVO = 'SUST'"><xsl:value-of select="document($doc)/translation/texts/item[@name='sostitucion_producto_existente']/node()"/></xsl:when>
						<xsl:when test="/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDMOTIVO = 'REEV'"><xsl:value-of select="document($doc)/translation/texts/item[@name='reevaluacion_incidencias']/node()"/></xsl:when>
					</xsl:choose>
            	</li>
            	<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='instrucciones_coordinador']/node()"/>:</label>
					<xsl:copy-of select="/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_INSTRUCCIONES"/>&nbsp;
            	</li>
            	<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_limite']/node()"/>:</label>
					<xsl:value-of select="/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_FECHALIMITE"/>&nbsp;
            	</li>
            	<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='num_muestras']/node()"/>:</label>
					<xsl:value-of select="/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NUMEROMUESTRAS"/>&nbsp;
            	</li>
			</ul>
		</div>
		</form>
	</xsl:when>
	<xsl:when test="/NuevaEvaluacionProducto/ERROR">
		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='error_evaluacion']/node()"/></h1>
	</xsl:when>
	<xsl:otherwise>

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
           		<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_evaluacion_producto']/node()"/>
				<span class="CompletarTitulo">
					<a class="btnDestacado" href="javascript:errorCheck(document.forms['EvaluacionProducto']);">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/>
					</a>&nbsp;
					<a class="btnNormal" href="javascript:Evaluaciones();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
					</a>
				</span>
			</p>
		</div>
		
		<form class="formEstandar" name="EvaluacionProducto" method="post">
        <input type="hidden" name="EMP_ID" id="EMP_ID" value="{NuevaEvaluacionProducto/EVALUACIONPRODUCTO/IDEMPRESA}" />
        <input type="hidden" name="REF_CLIENTE_LIC" id="REF_CLIENTE_LIC" value="{NuevaEvaluacionProducto/REF_CLIENTE}"/><!-- ref cliente cuando vengo de licitacion HIDDEN-->
        <input type="hidden" name="ID_PROD_ESTANDAR" id="ID_PROD_ESTANDAR" value="{NuevaEvaluacionProducto/ID_PROD_ESTANDAR}"/><!--ID PROD ESTANDAR CAT PRIV HIDDEN-->
        <input type="hidden" name="ID_PROD" id="ID_PROD" value="{NuevaEvaluacionProducto/PRO_ID}" /><!--ID PROD HIDDEN-->
        <input type="hidden" name="ID_PROVEEDOR" id="ID_PROVEEDOR"/><!--ID_PROVEEDOR-->
        <input type="hidden" name="ESTADO" id="ESTADO"/><!--estado-->
        <input type="hidden" name="LIC_ID" id="LIC_ID" value="{NuevaEvaluacionProducto/LIC_ID}"/><!--si viene de licitacion-->
        <input type="hidden" name="LIC_OFE_ID" id="LIC_OFE_ID" value="{NuevaEvaluacionProducto/LIC_OFE_ID}"/><!--si viene de licitacion-->
    	<div>
        	<ul style="width:1000px;">
            	<li>
					<xsl:choose>
					<xsl:when test="/NuevaEvaluacionProducto/LANG = 'spanish'">
						<img src="http://www.newco.dev.br/images/step1eva.gif" alt="Paso 1 - Nueva" />
					</xsl:when>
					<xsl:otherwise>
						<img src="http://www.newco.dev.br/images/step1eva-BR.gif" alt="Paso 1 - Nova" />
					</xsl:otherwise>
					</xsl:choose>
            	</li>
            	<li>
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='datos_producto']/node()"/></strong>
            	</li>
            	<li class="recuperaProd">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:</label>
                    <input type="text" class="campopesquisa w100px" name="REF_PROD" id="REF_PROD" />&nbsp;
                    <a id="botonBuscarEval" class="btnDiscreto">
                    	<xsl:attribute name="href">javascript:CatalogoPrivadoProductoEmpresa('<xsl:value-of select="NuevaEvaluacionProducto/EVALUACIONPRODUCTO/IDEMPRESA"/>&amp;ORIGEN=EVALUACION','');</xsl:attribute>
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/><!--<img src="http://www.newco.dev.br/images/botonBuscarPeque.gif" alt="buscar"/>-->
                    </a>&nbsp;
                    <span id="botonRecuperarProd" style="display:none;" class="fuentePeq">
                        &nbsp;<a href="javascript:RecuperarDatosProducto();" style="text-decoration:none;">
							<img src="http://www.newco.dev.br/images/2022/refresh-button.png" class="valignM" />
                        </a>
                    &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='recuperar_datos_producto']/node()"/>
                    </span>
            	</li>
            	<li class="datosProductoEstandard" style="display:none;">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:</label>
					<input type="text" name="REF_CLIENTE" id="REF_CLIENTE" class="noinput" readonly="readonly" />
            	</li>
            	<li class="datosProductoEstandard" style="display:none;">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_mvm']/node()"/>:</label>
					<input type="text" name="REF_ESTANDAR" id="REF_ESTANDAR" class="noinput" readonly="readonly"/>
            	</li>
            	<li class="datosProductoEstandard" style="display:none;">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</label>
					<textarea name="DESCR_ESTANDAR" id="DESCR_ESTANDAR" rows="3" cols="50" class="noinput" readonly="readonly"/><!--	REVISAR, PORQUE AREATEXT Y NO INPUT	-->
            	</li>
            	<li id="botonBuscarCatalogoProveedores" style="display:none;">
					<label></label>
					<a class="btnDiscreto" href="javascript:BuscarProveedoresEval();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='buscador_catalogo_proveedores']/node()"/><!--<img src="http://www.newco.dev.br/images/buscarCatalogoProveedores.gif" alt="Buscar catalogo proveedores" />-->
					</a>
            	</li>
            	<li class="datosProducto" id="provee" style="display:none;">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label>
					<input type="text" name="PROVEEDOR" id="PROVEEDOR" class="noinput" readonly="readonly" />
            	</li>
            	<li class="datosProducto" id="refProv" style="display:none;">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>:</label>
					<input type="text" name="REF_PROV" id="REF_PROV" class="noinput" readonly="readonly" />
            	</li>
            	<li class="datosProducto" id="descrProd" style="display:none;">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</label>
					<textarea name="DESCR_PROV" id="DESCR_PROV" rows="1" cols="50" class="noinput" readonly="readonly"/>
            	</li>
            	<li class="datosProducto" id="marcaProd" style="display:none;">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>:</label>
					<input type="text" name="MARCA" id="MARCA" class="noinput" readonly="readonly" />
            	</li>
            	<li>
 					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_evaluacion']/node()"/></strong>
				</li>
            	<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:<span class="camposObligatorios">*</span></label>
                    <xsl:call-template name="desplegable">
                        <xsl:with-param name="path" select="/NuevaEvaluacionProducto/EVALUACIONPRODUCTO/LISTACENTROS/field"/>
                        <xsl:with-param name="onChange">RecuperaUsuariosCentro();</xsl:with-param>
                        <xsl:with-param name="claSel">w300px</xsl:with-param>
                    </xsl:call-template>
            	</li>
            	<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_coordinador']/node()"/>:<span class="camposObligatorios">*</span></label>
					<select name="ID_USUARIO_COOR" id="ID_USUARIO_COOR" class="w300px"></select>
				</li>
            	<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='desea_elegir_usuario_evaluador_muestras']/node()"/>:</label>
                    <input type="radio" name="US_EVAL" id="US_EVAL_SI" value="SI" style="width:10px;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='si']/node()"/></input>&nbsp;&nbsp;
                    <input type="radio" name="US_EVAL" id="US_EVAL_NO" value="NO" style="width:10px;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='no']/node()"/></input>
				</li>
				<input type="hidden" name="ID_USUARIO_EVALUADOR" id="ID_USUARIO_EVALUADOR" />
            	<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='evaluador_muestras']/node()"/>:<span class="camposObligatorios">*</span></label>
					<select name="USUARIO_EVALUADOR" id="USUARIO_EVALUADOR" class="w300px"></select>
				</li>
            	<li>
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='motivo_evaluacion']/node()"/></strong>
				</li>
            	<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='instrucciones_coordinador']/node()"/>:</label>
					<textarea name="INSTRUCCIONES" id="INSTRUCCIONES" rows="8" cols="60"></textarea>
            	</li>
            	<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_limite']/node()"/>:</label>
					<input name="FECHA_LIMITE" id="FECHA_LIMITE" class="campopesquisa w80px" value="{NuevaEvaluacionProducto/EVALUACIONPRODUCTO/FECHA_A_15}"/>
            	</li>
            	<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='num_muestras']/node()"/>:</label>
					<input name="NUM_MUESTRAS" id="NUM_MUESTRAS" class="campopesquisa w80px"/>&nbsp;
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='num_muestras_0']/node()"/>
            	</li>
			</ul>
		</div>
		</form>


		<!--frame para las imagenes-->
		<div id="uploadFrameBox" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>
		<div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>

		<!--form de mensaje de error de js-->
		<form name="mensajeJS">
			<input type="hidden" name="NO_PRODUCTO_ENCONTRADO" value="{document($doc)/translation/texts/item[@name='no_producto_encontrado']/node()}"/>
		</form>
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
	<xsl:variable name="lang"><xsl:value-of select="/Incidencia/LANG"/></xsl:variable>
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
				<td colspan="2">&nbsp;</td>
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
				<input id="inputFileDoc_{$type}" name="inputFileDoc" type="file" onChange="cargaDoc(document.forms['Incidencia'],'{$type}');"/>
			</div>
		</div>
	</xsl:when>
	</xsl:choose>
</xsl:template><!--fin de documentos-->
</xsl:stylesheet>
