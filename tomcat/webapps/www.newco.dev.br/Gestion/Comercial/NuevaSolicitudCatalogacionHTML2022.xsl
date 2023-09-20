<?xml version="1.0" encoding="iso-8859-1"?>
<!-- 
	Nueva Solicitud de Catalogacion. Nuevo disenno 2022.
	Ultima revision: ET 16may22 10:20 SolicitudCatalogacion2022_130522.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/NuevaSolicitud">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

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

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_solicitud_catalogacion']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->

	<script type="text/javascript">
	var titulo_obligatorio		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_titulo_solicitud_catalogacion']/node()"/>';
	var descripcion_obligatoria	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_desc_solicitud_catalogacion']/node()"/>';
	var producto_obligatorio	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_producto_solicitud_catalogacion']/node()"/>';
	var precio_mal_formato = '<xsl:value-of select="document($doc)/translation/texts/item[@name='mal_formato_precio_solicitud_catalogacion']/node()"/>';
	var cantidad_mal_formato = '<xsl:value-of select="document($doc)/translation/texts/item[@name='mal_formato_cantidad_solicitud_catalogacion']/node()"/>';

	var consumo_obligatorio		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_consumo_solicitud_catalogacion']/node()"/>';
	var consumo_contiene_punto	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_contiene_punto_solicitud_catalogacion']/node()"/>';
	var consumo_no_numerico		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_no_numerico_solicitud_catalogacion']/node()"/>';

	</script>

	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/SolicitudCatalogacion2022_130522.js"></script>
</head>
<body>
    <xsl:attribute name="onload">
            <xsl:if test="/NuevaSolicitud/SOLICITUD/SC_ID != ''">abrirSolicitud(<xsl:value-of select="/NuevaSolicitud/SOLICITUD/SC_ID" />);</xsl:if>
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

    <xsl:when test="/NuevaSolicitud/SOLICITUD/SC_ID != ''">
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
		<p class="TituloPagina">
           <xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_catalogacion_guardada_exito']/node()"/>:
               (<xsl:value-of select="SOLICITUD/SC_CODIGO"/>)&nbsp;<xsl:value-of select="/NuevaSolicitud/SOLICITUD/SC_TITULO"/>
			&nbsp;&nbsp;
			<span class="CompletarTitulo">
				<a class="btnDestacado" href="javascript:anadirProducto();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir']/node()"/>
				</a>&nbsp;
				<a class="btnNormal" href="javascript:window.close();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
				</a>
			</span>
		</p>
	</div>
	<br/>
	<!--
        <h1 class="titlePage">
           <xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_catalogacion_guardada_exito']/node()"/>:
                                        (<xsl:value-of select="SOLICITUD/SC_CODIGO"/>)&nbsp;<xsl:value-of select="/NuevaSolicitud/SOLICITUD/SC_TITULO"/>
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
        		<ul class="w1000px">
            		<li>
						<label>
							<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud']/node()"/>-->
							<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;
							<span style="float:right;padding-right:30px;">
								<xsl:value-of select="/NuevaSolicitud/SOLICITUD/SC_FECHA"/>
							</span>
						</label>&nbsp;
            		</li>
            		<li>
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:</label>
						<xsl:value-of select="/NuevaSolicitud/SOLICITUD/USUARIO"/>&nbsp;
            		</li>
            		<li>
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>:</label>
						<input type="hidden" name="SC_TITULO" id="SC_TITULO" value="{/NuevaSolicitud/SOLICITUD/SC_TITULO}"/>
						<xsl:value-of select="/NuevaSolicitud/SOLICITUD/SC_TITULO" disable-output-escaping="yes"/>&nbsp;
            		</li>
            		<li>
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</label>
						<input type="hidden" name="SC_DESCRIPCION" id="SC_DESCRIPCION" value="{/NuevaSolicitud/SOLICITUD/SC_DESCRIPCION}"/>
						<xsl:value-of select="/NuevaSolicitud/SOLICITUD/SC_DESCRIPCION" disable-output-escaping="yes"/>&nbsp;
            		</li>
					<xsl:if test="/NuevaSolicitud/SOLICITUD/DOCUMENTO_Solicitud/ID">
            		<li>
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_solicitud']/node()"/>:</label>
						<a href="http://www.newco.dev.br/Documentos/{SOLICITUD/DOCUMENTO_Solicitud/URL}" target="_blank">
							<xsl:value-of select="SOLICITUD/DOCUMENTO_Solicitud/NOMBRE"/>&nbsp;
						</a>
            		</li>
					</xsl:if>
        		</ul>
    		</div>
			</form>
		
		<div class="tabela tabela_redonda">
		<table cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
			<tr>
				<th class="w1x">&nbsp;</th>
    			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
    			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
    			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/></th>
    			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
    			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></th>
    			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></th>
			</tr>
			</thead>
			<!--	Cuerpo de la tabla	-->
			<tbody class="corpo_tabela">
			<xsl:for-each select="/NuevaSolicitud/SOLICITUD/PRODUCTOS/PRODUCTO">
    			<tr class="conhover">
					<td class="color_status">&nbsp;</td>
        			<td><xsl:value-of select="SC_PROD_PRODUCTO" /></td>
        			<td><xsl:value-of select="SC_PROD_REFCLIENTE" /></td>
        			<td><xsl:value-of select="SC_PROD_REFPROVEEDOR" /></td>
        			<td><xsl:value-of select="SC_PROD_PROVEEDOR" /></td>
        			<td><xsl:value-of select="SC_PROD_PRECIO" /></td>
        			<td><xsl:value-of select="SC_PROD_CONSUMO" /></td>
    			</tr>
			</xsl:for-each>
			</tbody>
			<tfoot class="rodape_tabela">
				<tr><td colspan="7">&nbsp;</td></tr>
			</tfoot>
		</table><!--FIN DE PRODUCTOS-->
 		</div>
		
		<br /><br /><br />
						
         <form name="SolicitudCatalogacion" id="SolicitudCatalogacion" method="post">

            <table class="buscador" cellspacing="5" style="border-bottom:2px solid #D7D8D7;border-top:2px solid #D7D8D7;">
                <input type="text" name="IDSOLICITUD" id="IDSOLICITUD" value="{/NuevaSolicitud/SOLICITUD/SC_ID}" />
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
                    <tr class="sinLinea">
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
                <tr class="sinLinea">
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
						<a class="btnDestacado" id="BotonSubmit" href="javascript:anadirProducto(document.forms['SolicitudCatalogacion']);">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir']/node()"/>
						</a>
					</td>
                    <td class="datosLeft">
						<a class="btnNormal" href="http://www.newco.dev.br/Personal/BandejaTrabajo/WFStatus2022.xsql" target="_self">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
						</a>
					</td>
				</tr>
			</table>
            </form>

            </div>

        </xsl:when>
	<xsl:when test="ERROR">
		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_solicitud_catalogacion']/node()"/></h1>
	</xsl:when>
	<xsl:otherwise>
	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
           <xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_solicitud_catalogacion']/node()"/>
			<span class="CompletarTitulo">
				<a class="btnDestacado" id="BotonSubmit" href="javascript:ValidarFormulario(document.forms['SolicitudCatalogacion'],'NUEVA');">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/>
				</a>&nbsp;
				<a class="btnNormal" href="javascript:window.close();" target="_self">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
				</a>
			</span>
		</p>
	</div>

	<form class="formEstandar" name="SolicitudCatalogacion" id="SolicitudCatalogacion" method="post">
	<input type="hidden" name="TIPO_DOC_DB" id="TIPO_DOC_DB"/>
	<input type="hidden" name="TIPO_DOC_HTML" id="TIPO_DOC_HTML"/>
	<input type="hidden" name="CADENA_DOCUMENTOS"/>
	<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
	<input type="hidden" name="BORRAR_ANTERIORES"/>
	<input type="hidden" name="SC_IDDOCSOLICITUD" id="DOC_SOLCAT"/>

	<input type="hidden" name="ID_USUARIO" value="{DATOS_USUARIO/IDUSUARIO}"/>
	<input type="hidden" name="IDEMPRESA" value="{DATOS_USUARIO/IDEMPRESA}"/>

    <div>
        <ul class="w1000px">
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
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>:<span class="camposObligatorios">*</span></label>
				<input type="text" name="SC_TITULO" id="SC_TITULO" class="campopesquisa w300px" maxlength="200"/>
				&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='titulo_explicacion_sol_cat']/node()"/>
            </li>
            <li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:<span class="camposObligatorios">*</span></label>
				<textarea name="SC_DESCRIPCION" id="SC_DESCRIPCION" rows="4" cols="60" maxlength="3000"/><br/>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_explicacion_sol_cat']/node()"/>
            </li>
            <li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:<span class="camposObligatorios">*</span></label>
				<input type="text" name="SC_PRODUCTO" id="SC_PRODUCTO" class="campopesquisa w300px" maxlength="200" size="62"/>
            </li>
            <li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:</label>
				<input type="text" name="SC_REFCLIENTE" id="SC_REFCLIENTE" class="campopesquisa w100px" maxlength="100"/>
            </li>
            <li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/>:</label>
				<input type="text" name="SC_REFPROVEEDOR" id="SC_REFPROVEEDOR" class="campopesquisa w100px" maxlength="100"/>
            </li>
            <li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label>
				<input type="text" name="SC_PROVEEDOR" id="SC_PROVEEDOR" class="campopesquisa w300px" maxlength="100"/>
            </li>
            <li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>:</label>
				<input name="SC_PRECIO" id="SC_PRECIO" size="" class="campopesquisa w100px" maxlength="10"/>
            </li>
            <li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_anual']/node()"/>:</label>
				<input type="text" name="SC_CANTIDAD" id="SC_CANTIDAD" class="campopesquisa w100px" maxlength="10"/>
				&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_explicacion_sol_cat']/node()"/>
            </li>
            <li>
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_solicitud_catalogacion']/node()"/>:</label>
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
				<input id="inputFileDoc_{$type}" name="inputFileDoc" type="file" onChange="cargaDoc(document.forms['SolicitudCatalogacion'],'{$type}');"/>
			</div>
		</div>
	</xsl:when>
	</xsl:choose>
</xsl:template><!--fin de documentos-->
</xsl:stylesheet>
