<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Nueva incidencia de producto. Nuevo disenno 2022.
	Ultima revision: ET 11may22 08:45
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
		<xsl:when test="NuevaIncidencia/LANG"><xsl:value-of select="NuevaIncidencia/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_incidencia']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencia2022_100522.js"></script>

	<script type="text/javascript">
		var textoIncidenciaObli	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='texto_incidencia_obli']/node()"/>';
	</script>
</head>
<body>
<xsl:choose>
<xsl:when test="NuevaIncidencia/SESION_CADUCADA">
	<xsl:for-each select="NuevaIncidencia/SESION_CADUCADA">
		<xsl:if test="position()=last()">
			<xsl:apply-templates select="."/>
		</xsl:if>
	</xsl:for-each>
</xsl:when>
<xsl:when test="//xsql-error">
	<xsl:apply-templates select="//xsql-error"/>
</xsl:when>

<xsl:when test="/NuevaIncidencia/INCIDENCIA/PROD_INC_ID != ''">
    <!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/NuevaIncidencia/LANG"><xsl:value-of select="/NuevaIncidencia/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
        
        <h1 class="titlePage">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='incidencia_guardada']/node()"/>:&nbsp;
			(<xsl:value-of select="/NuevaIncidencia/INCIDENCIA/PROD_INC_CODIGO"/>)&nbsp;
		<xsl:choose>
		<xsl:when test="string-length(/NuevaIncidencia/INCIDENCIA/PROD_INC_NOMBRE) > 75">
			<xsl:value-of select="substring(/NuevaIncidencia/INCIDENCIA/PROD_INC_DESCESTANDAR, 1, 75)"/>...
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="/NuevaIncidencia/INCIDENCIA/PROD_INC_DESCESTANDAR"/>
		</xsl:otherwise>
		</xsl:choose>
			&nbsp;-&nbsp;
			<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:&nbsp;
			<xsl:choose>
			<xsl:when test="/NuevaIncidencia/INCIDENCIA/PROD_INC_REFCLIENTE != ''">
				<xsl:value-of select="/NuevaIncidencia/INCIDENCIA/PROD_INC_REFCLIENTE"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="/NuevaIncidencia/INCIDENCIA/PROD_INC_REFERENCIA"/>
			</xsl:otherwise>
			</xsl:choose>
                        &nbsp;&nbsp;<a href="javascript:window.print();" title="Imprimir" style="text-decoration:none;">
					<img src="http://www.newco.dev.br/images/imprimir.gif" style="margin-top:-5px;" alt="Imprimir" />
				</a>
                </h1>
                
                
	<xsl:variable name="usuario">
	<xsl:choose>
		<xsl:when test="/NuevaIncidencia/PRODUCTO/PRODUCTO/INCIDENCIAS/CDC and /NuevaIncidencia/PRODUCTO/PRODUCTO/INCIDENCIAS/IDEMPRESAUSUARIO = /NuevaIncidencia/INCIDENCIA/PROD_INC_IDCLIENTE">CDC</xsl:when>
		<xsl:otherwise>NORMAL</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>

    <div class="divLeft5">&nbsp;</div>
		<div class="divLeft90">
                            
            <table class="buscador" cellspacing="5" style="border-bottom:2px solid #D7D8D7;">
			<!-- Incidencia -->
			<tr>
				<td>&nbsp;</td>
				<td class="title">
                    <strong>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='incidencia']/node()"/>
						<xsl:if test="/NuevaIncidencia/INCIDENCIA/PROD_INC_FECHA != ''">
							<span style="float:right;padding-right:30px;">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;<xsl:value-of select="/NuevaIncidencia/INCIDENCIA/PROD_INC_FECHA"/>
                            </span>
                        </xsl:if>
                    </strong>
                </td>
			</tr>
			<tr>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable_incidencia']/node()"/>:</td>
				<td class="datosLeft"><xsl:value-of select="/NuevaIncidencia/INCIDENCIA/CENTROCLIENTE"/>:&nbsp;<xsl:value-of select="/NuevaIncidencia/INCIDENCIA/USUARIO"/></td>
			</tr>
			<tr>
				<td class="labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='incidencia']/node()"/>:
				</td>
				<td class="datosLeft">
                    <textarea name="INCIDENCIA" id="INCIDENCIA" cols="40" rows="7" style="display:none;">
                        <xsl:copy-of select="/NuevaIncidencia/INCIDENCIA/PROD_INC_DESCRIPCION/node()" />
                    </textarea>
                    <xsl:copy-of select="/NuevaIncidencia/INCIDENCIA/PROD_INC_DESCRIPCION" disable-output-escaping="yes"/>
				</td>
			</tr>
            <tr>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='num_lote']/node()"/>:</td>
				<td class="datosLeft">
						<xsl:value-of select="/NuevaIncidencia/INCIDENCIA/PROD_INC_INFOLOTE"/>
				</td>
			</tr>
			<tr>
				<td class="labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_quiere_seguir_utilizando']/node()"/>:&nbsp;
				</td>
                <td class="datosLeft">
                    <xsl:choose>
                        <xsl:when test="/NuevaIncidencia/INCIDENCIA/PROD_INC_SEGUIRUTILIZANDO = 'S'">
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='si']/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='no']/node()"/>
                        </xsl:otherwise>
                    </xsl:choose>
				</td>
			</tr>
			<xsl:if test="/NuevaIncidencia/INCIDENCIA/DOCUMENTO_INCIDENCIA/ID">
				<tr>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_incidencia']/node()"/>:</td>
					<td class="datosLeft" colspan="2">
						<a href="http://www.newco.dev.br/Documentos/{/NuevaIncidencia/INCIDENCIA/DOCUMENTO_INCIDENCIA/URL}" target="_blank">
							<xsl:value-of select="/NuevaIncidencia/INCIDENCIA/DOCUMENTO_INCIDENCIA/NOMBRE"/>
						</a>
					</td>
				</tr>
			</xsl:if>
			</table>
        </div>
</xsl:when>
<xsl:otherwise>
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/NuevaIncidencia/LANG"><xsl:value-of select="/NuevaIncidencia/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:variable name="usuario">
	<xsl:choose>
		<xsl:when test="/NuevaIncidencia/PRODUCTO/PRODUCTO/INCIDENCIAS/CDC and /NuevaIncidencia/PRODUCTO/PRODUCTO/INCIDENCIAS/IDEMPRESAUSUARIO = /NuevaIncidencia/INCIDENCIA/PROD_INC_IDCLIENTE">CDC</xsl:when>
		<xsl:otherwise>NORMAL</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>

	<div class="divLeft">
	<xsl:choose>
	<xsl:when test="NuevaIncidencia/OK">
		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='incidencia_guardada_exito']/node()"/></h1>
		<div class="divLeft40">&nbsp;</div>
		<div class="boton">
			<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencias.xsql?PRO_ID={/NuevaIncidencia/PRO_ID}&amp;LIC_OFE_ID={/NuevaIncidencia/LIC_OFE_ID}&amp;LIC_PROD_ID={/NuevaIncidencia/LIC_PROD_ID}">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='incidencias']/node()"/>
			</a>
		</div>
	</xsl:when>
	<xsl:when test="NuevaIncidencia/ERROR">
		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='error_incidencia']/node()"/></h1>
	</xsl:when>
	<xsl:otherwise>
			<!--	Titulo de la p�gina		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
				<xsl:choose>
				<xsl:when test="string-length(/NuevaIncidencia/PRODUCTO/PRODUCTO/PRO_NOMBRE) > 75">
					<xsl:value-of select="substring(/NuevaIncidencia/PRODUCTO/PRODUCTO/PRO_NOMBRE, 1, 75)"/>...
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/NuevaIncidencia/PRODUCTO/PRODUCTO/PRO_NOMBRE"/>
				</xsl:otherwise>
				</xsl:choose>
				<span class="CompletarTitulo300">
					<a href="javascript:GuardarNuevaIncidencia(document.forms['Incidencia']);" class="btnDestacado">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/>
					</a>&nbsp;
					<a href="javascript:window.close();" class="btnNormal">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='salir']/node()"/>
					</a>&nbsp;
				</span>
			</p>
		</div>
		<br/>
		<form name="Incidencia" method="post">
			<input type="hidden" name="PRO_ID" id="PRO_ID" value="{/NuevaIncidencia/PRO_ID}"/>
			<input type="hidden" name="ID_OFERTA_LIC" id="ID_OFERTA_LIC" value=""/>
			<input type="hidden" name="REF_CLIENTE" id="REF_CLIENTE" value="{/NuevaIncidencia/PRODUCTO/PRODUCTO/REFERENCIA_CLIENTE}"/>
			<input type="hidden" name="REF_PROVE" id="REF_PROVE" value="{/NuevaIncidencia/PRODUCTO/PRODUCTO/REFERENCIA_PROVEEDOR}"/>
			<input type="hidden" name="REF_ESTANDAR" id="REF_ESTANDAR" value="{/NuevaIncidencia/PRODUCTO/PRODUCTO/REFERENCIA_PRIVADA}"/>
			<input type="hidden" name="DESC_ESTANDAR" id="DESC_ESTANDAR" value="{/NuevaIncidencia/PRODUCTO/PRODUCTO/NOMBRE_PRIVADO}"/>
			<input type="hidden" name="NOMBRE" id="NOMBRE" value="{/NuevaIncidencia/PRODUCTO/PRODUCTO/PRO_NOMBRE}"/>
			<input type="hidden" name="LIC_OFE_ID" id="LIC_OFE_ID" value="{/NuevaIncidencia/LIC_OFE_ID}"/>
			<input type="hidden" name="LIC_PROD_ID" id="LIC_PROD_ID" value="{/NuevaIncidencia/LIC_PROD_ID}"/>
			<input type="hidden" name="USER" id="USER" value="{/NuevaIncidencia/USER}"/>
			<input type="hidden" name="ACCION" id="ACCION" value=""/><!--11may22-->
			<!-- Inputs Carga Documentos -->
			<input type="hidden" name="ID_USUARIO" value="{/NuevaIncidencia/INCIDENCIA/IDUSUARIO}"/>
			<input type="hidden" name="IDPROVEEDOR" value="{/NuevaIncidencia/PRODUCTO/PRODUCTO/IDPROVEEDOR}"/>
			<input type="hidden" name="REMOVE" value="{document($doc)/translation/texts/item[@name='remove']/node()}"/>
			<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
			<input type="hidden" name="BORRAR_ANTERIORES"/>
			<input type="hidden" name="CADENA_DOCUMENTOS"/>
			<input type="hidden" name="TIPO_DOC_DB" id="TIPO_DOC_DB"/>
			<input type="hidden" name="TIPO_DOC_HTML" id="TIPO_DOC_HTML"/>
			<input type="hidden" name="PROD_INC_IDDOCINCIDENCIA" id="DOC_INC"/>
			<input type="hidden" name="PROD_INC_IDDOCDIAGNOSTICO" id="DOC_DIAG"/>
			<input type="hidden" name="PROD_INC_IDDOCSOLUCION" id="DOC_SOL"/>
                        
            <div class="divLeft5">&nbsp;</div>
            <div class="divLeft90">

            <table class="buscador"  cellspacing="6px" cellpadding="6px">
				<tr class="sinLinea">
                    <td class="w300px">&nbsp;</td>
					<td class="datosLeft w300px">
                        <xsl:choose>
                            <xsl:when test="//LANG = 'spanish'">
                                <img src="http://www.newco.dev.br/images/step1inc.gif" alt="Nueva" />
                            </xsl:when>
                            <xsl:otherwise>
                                <img src="http://www.newco.dev.br/images/step1inc-BR.gif" alt="Nova" />
                            </xsl:otherwise>
                        </xsl:choose>
					</td>
                    <td>&nbsp;</td>
				</tr>
                <tr class="sinLinea">
                    <td>&nbsp;</td>
					<td class="datosLeft">
						<p class="urgente"><xsl:copy-of select="document($doc)/translation/texts/item[@name='expli_incidencias']/node()"/></p>
					</td>
                    <td>&nbsp;</td>
				</tr>
				<!-- Incidencia -->
				<tr class="sinLinea">
					<td class="labelRight">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='incidencia']/node()"/>:&nbsp;
						<span class="camposObligatorios">*</span>
					</td>
					<td class="datosLeft"><textarea name="INCIDENCIA" id="INCIDENCIA" rows="8" cols="60"></textarea></td>
				</tr>
                <tr class="sinLinea">
					<td class="labelRight">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='num_lote']/node()"/>:&nbsp;
					</td>
					<td class="datosLeft"><input class="campopesquisa w200px" name="NUM_LOTE" id="NUM_LOTE" size="60" /></td>
                    <td>&nbsp;</td>
				</tr>
                                
				<tr class="sinLinea">
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_incidencia']/node()"/>:</td>
					<td class="datosLeft">
						<span id="newDocINC" align="center">
						<a class="btnDiscreto" href="javascript:verCargaDoc('INC');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_documento']/node()"/>
						</a>
						</span>&nbsp;
						<span id="docBoxINC" style="display:none;" align="center"></span>&nbsp;
						<span id="borraDocINC" style="display:none;" align="center"></span>
					</td>
                    <td>&nbsp;</td>
				</tr>
                               
				<tr id="cargaINC" class="cargas sinLinea" style="display:none;">
					<td colspan="2"><xsl:call-template name="CargaDocumentos"><xsl:with-param name="tipo">INC</xsl:with-param></xsl:call-template></td>
				</tr>
                <tr class="sinLinea">
					<td class="labelRight">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='seguir_utilizando']/node()"/>:&nbsp;
					</td>
					<td class="datosLeft">
                        <input type="hidden" name="SEGUIR_UTILIZANDO" />
                       <input type="radio" class="muypeq" name="SEGUIR_UTILIZANDO_VALUES" value="S">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='si']/node()"/></input>&nbsp;&nbsp;
                       <input type="radio" class="muypeq" name="SEGUIR_UTILIZANDO_VALUES" value="N">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='no']/node()"/></input>
                   	</td>
                    <td>&nbsp;</td>
				</tr>
			</table>
            </div>
		</form>

		<!--frame para las imagenes-->
		<div id="uploadFrameBox" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>
		<div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>

		<!--form de mensaje de error de js-->
		<form name="mensajeJS">
			<!--carga documentos-->
			<input type="hidden" name="ERROR_SIN_DEFINIR" value="{document($doc)/translation/texts/item[@name='error_sin_definir']/node()}"/>
			<input type="hidden" name="HEMOS_ESPERADO" value="{document($doc)/translation/texts/item[@name='hemos_esperado']/node()}"/>
			<input type="hidden" name="LA_CARGA_NO_TERMINO" value="{document($doc)/translation/texts/item[@name='la_carga_no_termino']/node()}"/>
            <input type="hidden" name="SEGUIR_UTILIZANDO_CDC_OBLI" value="{document($doc)/translation/texts/item[@name='seguir_utilizando_cdc_obli']/node()}"/>
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
	<xsl:variable name="lang"><xsl:value-of select="/NuevaIncidencia/LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="divLeft" id="cargaDoc{$tipo}">
		<!--tabla imagenes y documentos-->
		<table class="infoTable" border="0">
			<tr>
				<!--documentos-->
				<td class="labelRight trenta">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='elige_documento']/node()"/>
				</td>
				<td class="datosLeft">
					<div class="altaDocumento">
						<span class="anadirDoc">
							<xsl:call-template name="documentos">
								<xsl:with-param name="num" select="number(1)"/>
								<xsl:with-param name="type" select="$tipo"/>
							</xsl:call-template>
						</span>
					</div>
				</td>
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
