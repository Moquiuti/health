<?xml version="1.0" encoding="iso-8859-1"?>
<!--nueva solicitud de oferta	-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/NuevaSolicitud">
<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="//LANG"><xsl:value-of select="//LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_solicitud_oferta']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

	<script type="text/javascript">
	var titulo_obligatorio		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_titulo_solicitud_oferta']/node()"/>';
	var descripcion_obligatoria	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_deSO_solicitud_oferta']/node()"/>';
	var producto_obligatorio	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_producto_solicitud_oferta']/node()"/>';
	var precio_mal_formato = '<xsl:value-of select="document($doc)/translation/texts/item[@name='mal_formato_precio_solicitud_oferta']/node()"/>';
	var cantidad_mal_formato = '<xsl:value-of select="document($doc)/translation/texts/item[@name='mal_formato_cantidad_solicitud_oferta']/node()"/>';

	var consumo_obligatorio		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_consumo_solicitud_oferta']/node()"/>';
	var consumo_contiene_punto	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_contiene_punto_solicitud_oferta']/node()"/>';
	var consumo_no_numerico		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_no_numerico_solicitud_oferta']/node()"/>';

	</script>

	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/SolicitudOferta_13jul17.js"></script>
</head>
<body>
    <xsl:attribute name="onload">
            <xsl:if test="/NuevaSolicitud/SOLICITUD/SO_ID != ''">abrirSolicitud(<xsl:value-of select="/NuevaSolicitud/SOLICITUD/SO_ID" />);</xsl:if>
    </xsl:attribute>
<xsl:choose>
<xsl:when test="SESION_CADUCADA">
	<xsl:for-each select="SESION_CADUCADA">
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
		<xsl:when test="//LANG"><xsl:value-of select="//LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="divLeft">
	<xsl:choose>

    <xsl:when test="/NuevaSolicitud/SOLICITUD/SO_ID != ''">
    <!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="//LANG"><xsl:value-of select="//LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_solicitud_oferta']/node()"/></span></p>
		<p class="TituloPagina">
           <xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_oferta_guardada_exito']/node()"/>:
               (<xsl:value-of select="SOLICITUD/SO_CODIGO"/>)&nbsp;<xsl:value-of select="/NuevaSolicitud/SOLICITUD/SO_TITULO"/>
			&nbsp;&nbsp;
			<span class="CompletarTitulo">
				<a class="btnDestacado" href="javascript:anadirProducto(document.forms['SolicitudOferta']);">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir']/node()"/>
				</a>
				&nbsp;
				<a class="btnNormal" href="javascript:window.close();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
				</a>
			</span>
		</p>
	</div>
	<br/>
	<!--
        <h1 class="titlePage">
           <xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_oferta_guardada_exito']/node()"/>:
                                        (<xsl:value-of select="SOLICITUD/SO_CODIGO"/>)&nbsp;<xsl:value-of select="/NuevaSolicitud/SOLICITUD/SO_TITULO"/>
        </h1>
	-->


        <div class="divLeft20">&nbsp;</div>
        <div class="divLeft60nopa">
            <xsl:choose>
            <xsl:when test="//LANG = 'spanish'">
                <img src="http://www.newco.dev.br/images/step1sol.gif" alt="Nueva" />
            </xsl:when>
            <xsl:otherwise>
                <img src="http://www.newco.dev.br/images/step1sol-BR.gif" alt="Nova" />
            </xsl:otherwise>
            </xsl:choose>


			<form class="formEstandar">
    		<div>
        		<ul style="width:1000px;">
            		<li>
						<label>
							<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud']/node()"/>-->
							<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;
							<span style="float:right;padding-right:30px;">
								<xsl:value-of select="/NuevaSolicitud/SOLICITUD/SO_FECHA"/>
							</span>
						</label>
            		</li>
            		<li>
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:</label>
						<xsl:value-of select="/NuevaSolicitud/SOLICITUD/USUARIO"/>&nbsp;
            		</li>
            		<li>
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>:</label>
						<input type="hidden" name="SO_TITULO" id="SO_TITULO" value="{/NuevaSolicitud/SOLICITUD/SO_TITULO}"/>
						<xsl:value-of select="/NuevaSolicitud/SOLICITUD/SO_TITULO" disable-output-escaping="yes"/>&nbsp;
            		</li>
            		<li>
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</label>
						<input type="hidden" name="SO_DESCRIPCION" id="SO_DESCRIPCION" value="{/NuevaSolicitud/SOLICITUD/SO_DESCRIPCION}"/>
						<xsl:value-of select="/NuevaSolicitud/SOLICITUD/SO_DESCRIPCION" disable-output-escaping="yes"/>&nbsp;
            		</li>
					<xsl:if test="/NuevaSolicitud/SOLICITUD/DOCUMENTO_SOLICITUD/ID">
            		<li>
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='DOCUMENTO_SOLICITUD']/node()"/>:</label>
						<a href="http://www.newco.dev.br/Documentos/{SOLICITUD/DOCUMENTO_SOLICITUD/URL}" target="_blank">
							<xsl:value-of select="SOLICITUD/DOCUMENTO_SOLICITUD/NOMBRE"/>&nbsp;
						</a>
            		</li>
					</xsl:if>
        		</ul>
    		</div>
			</form>
		
		<table class="buscador">
		<tr>
    		<th><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
    		<th><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
    		<th><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/></th>
    		<th><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
    		<th><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></th>
    		<th><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></th>
		</tr>
		<xsl:for-each select="/NuevaSolicitud/SOLICITUD/PRODUCTOS/PRODUCTO">
    		<tr>
        		<td><xsl:value-of select="SO_PROD_PRODUCTO" /></td>
        		<td><xsl:value-of select="SO_PROD_REFCLIENTE" /></td>
        		<td><xsl:value-of select="SO_PROD_REFPROVEEDOR" /></td>
        		<td><xsl:value-of select="SO_PROD_PROVEEDOR" /></td>
        		<td><xsl:value-of select="SO_PROD_PRECIO" /></td>
        		<td><xsl:value-of select="SO_PROD_CONSUMO" /></td>
    		</tr>
		</xsl:for-each>
		</table><!--FIN DE PRODUCTOS-->
		<br /><br />
						
         <form name="SolicitudOferta" id="SolicitudOferta" method="post">

            <table class="buscador" cellspacing="5" style="border-bottom:2px solid #D7D8D7;border-top:2px solid #D7D8D7;">
                <input type="text" name="IDSOLICITUD" id="IDSOLICITUD" value="{/NuevaSolicitud/SOLICITUD/SO_ID}" />
                <!-- Añadir producto -->
				<tr class="sinLinea">
					<td>&nbsp;</td>
					<td colspan="2" style="text-transform:uppercase;text-align:left;background-color:#D3D3D3;padding-left:10px;">
						<strong>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir']/node()"/>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/>
						</strong>
                                        </td>
				</tr>
                                <tr>
					<td class="labelRight grisMed trenta">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:
                                                <span class="camposObligatorios">*</span>
					</td>
					<td class="datosLeft" colspan="2"><input type="text" name="PRODUCTO" id="PRODUCTO" maxlength="200" size="62"/></td>
				</tr>
				<tr class="sinLinea">
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:
					</td>
					<td class="datosLeft" colspan="2"><input type="text" name="REFCLIENTE" id="REFCLIENTE" maxlength="100"/></td>
				</tr>
				<tr class="sinLinea">
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/>:
                                                <span class="camposObligatorios">*</span>
					</td>
					<td class="datosLeft" colspan="2"><input type="text" name="REFPROVEEDOR" id="REFPROVEEDOR" maxlength="100"/></td>
				</tr>
				<tr class="sinLinea">
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:
                                                <span class="camposObligatorios">*</span>
					</td>
					<td class="datosLeft" colspan="2"><input type="text" name="PROVEEDOR" id="PROVEEDOR" maxlength="100"/></td>
				</tr>
                                <tr>
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>:&nbsp;
						<span class="camposObligatorios">*</span>
					</td>
					<td class="datosLeft"><input name="PRECIO" id="PRECIO" maxlength="10"/></td>
					<td class="datosLeft"><!--<xsl:value-of select="document($doc)/translation/texts/item[@name='infoprecio_explicacion_sol_cat']/node()"/>--></td>
				</tr>
				<tr class="sinLinea">
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_anual']/node()"/>:
						<span class="camposObligatorios">*</span>
					</td>
					<td class="datosLeft" colspan="2"><input type="text" name="CONSUMO" id="CONSUMO" maxlength="10"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='euro']/node()"/>&nbsp;
					</td>
				</tr>
                <tr class="sinLinea"><td colspan="3">&nbsp;</td></tr>
				<tr class="sinLinea">
					<td class="labelRight"></td>
					<td class="datosLeft">
						<!--<div class="boton" id="BotonSubmit">-->
						<a class="btnDestacado" href="javascript:anadirProducto(document.forms['SolicitudOferta']);">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir']/node()"/>
						</a>
						<!--</div>-->
					</td>
                                        <td class="datosLeft">
						<!--<div class="boton">-->
						<a class="btnNormal" href="http://www.newco.dev.br/Personal/BandejaTrabajo/WFStatus.xsql" target="_self">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
						</a>
						<!--</div>-->
					</td>
				</tr>
			</table>
            </form>

            </div>

        </xsl:when>
	<xsl:when test="ERROR">
		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_solicitud_oferta']/node()"/></h1>
	</xsl:when>
	<xsl:otherwise>
	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_solicitud_oferta']/node()"/></span></p>
		<p class="TituloPagina">
           <xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_solicitud_oferta']/node()"/>
			<span class="CompletarTitulo">
				<a class="btnDestacado" id="BotonSubmit" href="javascript:ValidarFormulario(document.forms['SolicitudOferta'],'NUEVA');">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
				</a>
				<a class="btnNormal" href="javascript:window.close();" target="_self">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
				</a>
			</span>
		</p>
	</div>

	<form class="formEstandar" name="SolicitudOferta" id="SolicitudOferta" method="post">
	<input type="hidden" name="TIPO_DOC_DB" id="TIPO_DOC_DB"/>
	<input type="hidden" name="TIPO_DOC_HTML" id="TIPO_DOC_HTML"/>
	<input type="hidden" name="CADENA_DOCUMENTOS"/>
	<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
	<input type="hidden" name="BORRAR_ANTERIORES"/>
	<input type="hidden" name="SO_IDDOCSOLICITUD" id="DOC_SOLCAT"/>

	<input type="hidden" name="ID_USUARIO" value="{NUEVASOLICITUD/DATOS_USUARIO/IDUSUARIO}"/>
	<input type="hidden" name="IDEMPRESA" value="{NUEVASOLICITUD/DATOS_USUARIO/IDEMPRESA}"/>

    <div>
        <ul style="width:1000px;">
            <li>
                <xsl:choose>
                <xsl:when test="//LANG = 'spanish'">
                    <img src="http://www.newco.dev.br/images/step1sol.gif" alt="Nueva" />
                </xsl:when>
                <xsl:otherwise>
                    <img src="http://www.newco.dev.br/images/step1sol-BR.gif" alt="Nova" />
                </xsl:otherwise>
                </xsl:choose>
            </li>
            <li>
				<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='datos_generales']/node()"/></strong>
            </li>
            <li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/>:<span class="camposObligatorios">*</span></label>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="NUEVASOLICITUD/CLIENTES/field"/>
					<xsl:with-param name="claSel">selectFont18</xsl:with-param>
				</xsl:call-template>
            </li>
            <li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:<span class="camposObligatorios">*</span></label>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="NUEVASOLICITUD/PROVEEDORES/field"/>
					<xsl:with-param name="claSel">selectFont18</xsl:with-param>
				</xsl:call-template>
            </li>
            <li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>:<span class="camposObligatorios">*</span></label>
				<input type="text" name="SO_TITULO" id="SO_TITULO" maxlength="200" size="62"/>
				&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='titulo_explicacion_sol_cat']/node()"/>
            </li>
            <li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</label>
				<textarea name="SO_DESCRIPCION" id="SO_DESCRIPCION" rows="4" cols="60" maxlength="3000"/><br/>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_explicacion_sol_cat']/node()"/>
            </li>
            <li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:<span class="camposObligatorios">*</span></label>
				<input type="text" name="SO_PRODUCTO" id="SO_PRODUCTO" maxlength="200" size="62"/>
            </li>
            <li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:</label>
				<input type="text" name="SO_REFCLIENTE" id="SO_REFCLIENTE" maxlength="100"/>
            </li>
            <li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/>:</label>
				<input type="text" name="SO_REFPROVEEDOR" id="SO_REFPROVEEDOR" maxlength="100"/>
            </li>
            <li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label>
				<input type="text" name="SO_REFPROVEEDOR" id="SO_REFPROVEEDOR" maxlength="100"/>
            </li>
            <li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>:</label>
				<input name="SO_PRECIO" id="SO_PRECIO" size="" maxlength="10"/>
            </li>
            <li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_anual']/node()"/>:</label>
				<input type="text" name="SO_CANTIDAD" id="SO_CANTIDAD" maxlength="10"/>
				&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_explicacion_sol_cat']/node()"/>
            </li>
            <li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/>:</label>
				<span id="newDocSOLCAT" align="center">
					<a href="javascript:verCargaDoc('SOLCAT');" title="Subir documento" style="text-decoration:none;">
						<img src="http://www.newco.dev.br/images/subirDocumento.gif" alt="Subir Documento" title="Subir Documento"/>
					</a>
				</span>&nbsp;
				<span id="docBoxSOLCAT" style="display:none;" align="center"></span>&nbsp;
				<span id="borraDocSOLCAT" style="display:none;" align="center"></span>
            </li>
			<li id="cargaSOLCAT" class="cargas" style="display:none;">
				<xsl:call-template name="CargaDocumentos"><xsl:with-param name="tipo">SOLCAT</xsl:with-param></xsl:call-template>
			</li>
        </ul>
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
	<xsl:variable name="lang"><xsl:value-of select="LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="divLeft" id="cargaDoc{$tipo}">
		<!--tabla imagenes y documentos-->
		<table class="buscador" border="0">
			<tr>
				<!--documentos-->
				<td class="labelRight trenta grisMed">
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
				<input id="inputFileDoc_{$type}" name="inputFileDoc" type="file" onChange="cargaDoc(document.forms['SolicitudOferta'],'{$type}');"/>
			</div>
		</div>
	</xsl:when>
	</xsl:choose>
</xsl:template><!--fin de documentos-->
</xsl:stylesheet>
