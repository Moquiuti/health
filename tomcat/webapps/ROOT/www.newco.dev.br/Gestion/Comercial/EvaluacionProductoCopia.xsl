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

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/evaluacionProductos240815.js"></script>
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
                var motivoObli          = '<xsl:value-of select="document($doc)/translation/texts/item[@name='motivo_obli']/node()"/>';
                var fechaLimiteObli	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_limite_obli']/node()"/>';
                var numMuestrasObli	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='num_muestras_obli']/node()"/>';
                elegirInformarEvaluadorObli  = '<xsl:value-of select="document($doc)/translation/texts/item[@name='elegir_informar_evaluador_obli']/node()"/>';
		
	</script>
</head>
<body>
    <xsl:attribute name="onload">RecuperaUsuariosCentro();</xsl:attribute>
    
    
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
		<xsl:when test="/EvaluacionProducto/INCIDENCIA/OBSERVADOR">OBSERVADOR</xsl:when>
		<xsl:when test="/EvaluacionProducto/INCIDENCIA/CDC and /Incidencia/INCIDENCIA/IDEMPRESAUSUARIO = /Incidencia/INCIDENCIA/PROD_INC_IDCLIENTE">CDC</xsl:when>
		<xsl:otherwise>NORMAL</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	

	<div class="divLeft">
	<xsl:choose>
	<xsl:when test="EvaluacionProducto/OK">
		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion_guardada_exito']/node()"/></h1>
		<div class="divLeft40">&nbsp;</div>
                
		<div class="boton">
			<a href="http://www.newco.dev.br/Gestion/Comercial/EvaluacionProductos.xsql">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='evaluaciones']/node()"/>
			</a>
		</div>
                <xsl:if test="/EvaluacionProducto/EVALUACIONPRODUCTO/ROL = 'COMPRADOR' or /EvaluacionProducto/EVALUACIONPRODUCTO/CDC"></xsl:if>
	</xsl:when>
	<xsl:when test="EvaluacionProducto/ERROR">
		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='error_evaluacion']/node()"/></h1>
	</xsl:when>
	<xsl:otherwise>
		<h1 class="titlePage">
                    <xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_CODIGO"/>&nbsp;-&nbsp;
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion_producto']/node()"/>:&nbsp;
                        <xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBRE"/>&nbsp;
                        
                        <xsl:if test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_REFCLIENTE != ''">
                            &nbsp;-&nbsp;
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:&nbsp;
                            <xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_REFCLIENTE"/>
                        </xsl:if>
                        &nbsp;&nbsp;<a href="javascript:window.print();" title="Imprimir" style="text-decoration:none;">
					<img src="http://www.newco.dev.br/images/imprimir.gif" style="margin-top:-5px;" alt="Imprimir" />
				</a>
                      
                </h1>
                
		<form name="EvaluacionProducto" method="post">
                        <input type="hidden" name="EMP_ID" id="EMP_ID" value="{NuevaEvaluacionProducto/EVALUACIONPRODUCTO/IDEMPRESA}" />
                        <input type="hidden" name="REF_CLIENTE_LIC" id="REF_CLIENTE_LIC" value="{NuevaEvaluacionProducto/REF_CLIENTE}"/><!-- ref cliente cuando vengo de licitacion HIDDEN-->                    
                        <input type="hidden" name="LIC_ID" id="LIC_ID" value="{NuevaEvaluacionProducto/LIC_ID}"/><!--si viene de licitacion-->
                        <input type="hidden" name="LIC_OFE_ID" id="LIC_OFE_ID" value="{NuevaEvaluacionProducto/LIC_OFE_ID}"/>
                
			<input type="hidden" name="EVA_ID" id="EVA_ID" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_ID}"/>
                        <input type="hidden" name="DOC_EVAL" id="DOC_EVAL"/>
                       
			<!-- Inputs -->
                        <input type="hidden" name="ESTADO" id="ESTADO"/><!--estado-->
                        <input type="hidden" name="ID_PROD_ESTANDAR" id="ID_PROD_ESTANDAR" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDPRODUCTO}"/>
                        <input type="hidden" name="ID_PROD" id="ID_PROD" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDPRODUCTO}" />
			<input type="hidden" name="ID_USUARIO" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/IDUSUARIO}"/>
			<input type="hidden" name="ID_PROVEEDOR" id="ID_PROVEEDOR" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_IDPROVEEDOR}"/><!--ID_PROVEEDOR-->
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
					<td class="title">
                                                <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='datos_producto']/node()"/></strong>
					</td>
				</tr>
                                <!--datos producto que recupero con ajax desde la ref y id empresa o id prod-->
                                <xsl:if test="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_REFCLIENTE != ''">
                                    <tr class="datosProductoEstandard">
                                            <td class="labelRight grisMed">
                                                        <xsl:copy-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>
                                            </td>
                                            <td class="datosLeft">
                                                <xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_REFCLIENTE"/>
                                                <input type="hidden" name="REF_CLIENTE" id="REF_CLIENTE" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_REFCLIENTE}" /></td>
                                           
                                    </tr>
                                </xsl:if>
                                <tr class="datosProductoEstandard">
                                            <td class="labelRight grisMed">
                                                        <xsl:copy-of select="document($doc)/translation/texts/item[@name='ref_mvm']/node()"/>
                                            </td>
                                            <td class="datosLeft">
                                                <xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_REFERENCIA"/>
                                                <input type="hidden" name="REF_ESTANDAR" id="REF_ESTANDAR" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_REFERENCIA}" />
                                            </td>
                                </tr>
                                 <tr class="datosProductoEstandard">
                                             <td class="labelRight grisMed">
                                                        <xsl:copy-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>
                                            </td>
                                            <td class="datosLeft">
                                                <xsl:copy-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBRE"/>
                                                <textarea name="DESCR_ESTANDAR" id="DESCR_ESTANDAR" rows="1" cols="50" style="display:none;">
                                                    <xsl:copy-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBRE/node()" />
                                                </textarea>
                                            </td>
                                </tr>
                                
                                <tr class="datosProducto">
                                            <td class="labelRight grisMed">
                                                        <xsl:copy-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>
                                            </td>
                                            <td class="datosLeft">
                                                <xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_REFPROVEEDOR"/>
                                                <input type="hidden" name="REF_PROV" id="REF_PROV" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_REFPROVEEDOR}" />
                                            </td>
                                </tr>
                                <!-- proveedor que envia las muestras-->
				<tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:&nbsp;
					</td>
					<td class="datosLeft">
                                           <xsl:value-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROVEEDOR"/>
                                            <input type="hidden" name="PROVEEDOR" id="PROVEEDOR" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/PROVEEDOR}" />
                                        </td>
				</tr>
                                <tr class="datosProducto">
                                            <td class="labelRight grisMed">
                                                        <xsl:copy-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:
                                            </td>
                                            <td class="datosLeft">
                                                <xsl:copy-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBREPROVEEDOR"/>
                                                <textarea name="DESCR_PROV" id="DESCR_PROV" rows="1" cols="50" style="display:none;">
                                                    <xsl:copy-of select="/EvaluacionProducto/EVALUACIONPRODUCTO/PROD_EV_NOMBREPROVEEDOR/node()" />
                                                </textarea>
                                            </td>
                                </tr>
                                
                        </table>
                    
                      <!--tabla centro de evaluación-->
                        
                        <table class="infoTable incidencias" border="0" cellspacing="5">
                            <tr><td colspan="2">&nbsp;</td></tr>	
                                <!-- centro evaluacion -->
                                 <tr>
                                        <td class="labelRight trenta">&nbsp;</td>
					<td style="text-transform:uppercase;text-align:left;background-color:#D3D3D3;padding-left:10px;">
                                            <span style="padding:3px 12px; background:#D3D3D3;border-radius:5px;">
                                                <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_evaluacion']/node()"/></strong>
                                            </span>
					</td>
				</tr>
				<tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;
						<span class="camposObligatorios">*</span>
					</td>
					<td class="datosLeft">
                                            <xsl:call-template name="desplegable">
                                                <xsl:with-param name="path" select="/EvaluacionProducto/EVALUACIONPRODUCTO/LISTACENTROS/field"/>
                                                <xsl:with-param name="onChange">RecuperaUsuariosCentro();</xsl:with-param>
                                            </xsl:call-template>
                                        </td>
				</tr>
                                <!-- usuarios del centro, COORDINADOR -->
				<tr class="usuarioCoordinador" style="display:none;">
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_coordinador']/node()"/>:&nbsp;
						<span class="camposObligatorios">*</span>
					</td>
					<td class="datosLeft">
                                            <select name="ID_USUARIO_COOR" id="ID_USUARIO_COOR">
                                            </select>
                                        </td>
				</tr>
                                <!-- elegir usuario evaluador-->
				<tr>
					<td class="labelRight grisMed">
                                                <xsl:value-of select="document($doc)/translation/texts/item[@name='desea_elegir_usuario_evaluador_muestras']/node()"/>&nbsp;
					</td>
                                        <td class="datosLeft">
                                            <input type="radio" name="US_EVAL" id="US_EVAL_SI" value="SI">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='si']/node()"/></input>&nbsp;&nbsp;
                                            <input type="radio" name="US_EVAL" id="US_EVAL_NO" value="NO">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='no']/node()"/></input>

                                        </td>
				</tr>
                                <!-- usuarios que evalua las muestras-->
                                <input type="hidden" name="ID_USUARIO_EVALUADOR" id="ID_USUARIO_EVALUADOR" />
				<tr id="usuarioEvaluador" style="display:none;">
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='evaluador_muestras']/node()"/>:&nbsp;
						<span class="camposObligatorios">*</span>
					</td>
					<td class="datosLeft">
                                            <select name="USUARIO_EVALUADOR" id="USUARIO_EVALUADOR">
                                            </select>
                                        </td>
				</tr>
                        </table>
                     <!--motivo evaluación-->
                            <table class="infoTable incidencias" cellspacing="5" border="0"> 
				<tr><td colspan="2">&nbsp;</td></tr>	
                                <!-- motivo evaluacion -->
                                <tr>
                                        <td class="labelRight trenta">&nbsp;</td>
					<td style="text-transform:uppercase;text-align:left;background-color:#D3D3D3;padding-left:10px;">
                                                <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='motivo_evaluacion']/node()"/></strong>
					</td>
				</tr>
				<tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='motivo']/node()"/>:&nbsp;
						<span class="camposObligatorios">*</span>
					</td>
					<td class="datosLeft">
                                            <input name="MOTIVO" id="MOTIVO" type="hidden"/>
                                            <input type="radio" name="MOTIVO_VALUES" value="NUEVO">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto_nueva_introduccion']/node()"/></input>&nbsp;&nbsp;
                                            <input type="radio" name="MOTIVO_VALUES" value="SUST">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='sostitucion_producto_existente']/node()"/></input>&nbsp;&nbsp;
                                            <input type="radio" name="MOTIVO_VALUES" value="REEV">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='reevaluacion_incidencias']/node()"/></input>

                                        </td>
				</tr>
                                <!-- INSTRUCCIONES evaluacion -->
				<tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='instrucciones_coordinador']/node()"/>:&nbsp;
						<span class="camposObligatorios">*</span>
					</td>
					<td class="datosLeft"><textarea name="INSTRUCCIONES" id="INSTRUCCIONES" rows="4" cols="60"></textarea></td>
				</tr>
                                <!-- fecha limite evaluacion -->
				<tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_limite']/node()"/>:&nbsp;
						<span class="camposObligatorios">*</span>
					</td>
					<td class="datosLeft"><input name="FECHA_LIMITE" id="FECHA_LIMITE" size="12" value="{/EvaluacionProducto/EVALUACIONPRODUCTO/FECHA_A_15}"/></td>
				</tr>
                                 <!-- num muestras evaluacion -->
				<tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='num_muestras']/node()"/>:&nbsp;
						<span class="camposObligatorios">*</span>
					</td>
					<td class="datosLeft"><input name="NUM_MUESTRAS" id="NUM_MUESTRAS" size="4"/></td>
				</tr>
                                <tr><td colspan="2">&nbsp;</td></tr>	
				<tr>
					<td>&nbsp;</td>
					<td class="datosLeft">
						<div class="boton">
							<a href="javascript:errorCheck(document.forms['EvaluacionProducto']);">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/>
							</a>
						</div>
					</td>
				</tr>
                                
			</table>
                        <br /><br />
                    </div><!--fin de divLeft-->
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