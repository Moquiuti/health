<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Mantenimiento de Contrato. Nuevo disenno 2022.
	Ultima revisión: ET 13feb23 09:40 Contrato2022_120522.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/Contrato">

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

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Contrato']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/parsley_2.8.1.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/parsley.es.js"></script>

	<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/Contratos/Contrato2022_120522.js"></script>
	<script type="text/javascript">
		strErrorDescarga='<xsl:value-of select="document($doc)/translation/texts/item[@name='error_descarga_fichero']/node()"/>';
	</script>
</head>
<body>
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
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="divLeft">
	<xsl:choose>
	<xsl:when test="ERROR">
		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='error_Contrato']/node()"/></h1>
	</xsl:when>
	<xsl:otherwise>

		<xsl:variable name="usuario">
		<xsl:choose>
			<xsl:when test="not(CONTRATO/OBSERVADOR) and CONTRATO/CDC and CONTRATO/IDEMPRESAUSUARIO = CONTRATO/CON_IDCLIENTE">CDC</xsl:when>
			<xsl:otherwise>NORMAL</xsl:otherwise>
		</xsl:choose>
		</xsl:variable>
                <xsl:variable name="adminCliente">
		<xsl:choose>
			<xsl:when test="CONTRATO/ADMIN">ADMIN</xsl:when>
			<xsl:otherwise>NOADMIN</xsl:otherwise>
		</xsl:choose>
		</xsl:variable>
                <xsl:variable name="usuarioMVM">
		<xsl:choose>
			<xsl:when test="CONTRATO/MVM">MVM</xsl:when>
			<xsl:otherwise>NOMVM</xsl:otherwise>
		</xsl:choose>
		</xsl:variable>

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
				<xsl:choose>
					<xsl:when test="CONTRATO/NUEVO">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Nuevo_contrato']/node()"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="CONTRATO/CON_CODIGO"/>&nbsp;
						<xsl:value-of select="CONTRATO/CON_TITULO"/>
					</xsl:otherwise>
					</xsl:choose>
				<span class="CompletarTitulo" style="width:400px;">
					<a class="btnNormal" href="http://www.newco.dev.br/ProcesosCdC/Contratos/Contratos2022.xsql">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/>
					</a>
					&nbsp;
					<xsl:choose>
					<xsl:when test="CONTRATO/NUEVO or CONTRATO/SIN_MODELO">
					</xsl:when>
					<xsl:otherwise>
						<a class="btnNormal" href="javascript:ProcesarContrato();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='Procesar_contrato']/node()"/>
						</a>
						&nbsp;
					</xsl:otherwise>
					</xsl:choose>

					<xsl:if test="CONTRATO/CDC or CONTRATO/ADMIN">
						<a class="btnDestacado" href="javascript:ValidarYEnviar();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
						</a>
						&nbsp;
					</xsl:if>
				</span>
			</p>
		</div>
		
		<!--	Nuevo formulario	-->
    	<div>
        	<ul class="w1000px">
				<form class="formEstandar" name="Contrato" id="Contrato" method="post" action="Contrato2022.xsql">
				<input type="hidden" name="ACCION" id="ACCION" value=""/>
				<input type="hidden" name="CON_ID" id="CON_ID" value="{CONTRATO/CON_ID}"/>
				<input type="hidden" name="CON_IDESTADO" id="CON_IDESTADO"/>
				<input type="hidden" name="ID_USUARIO" value="{CONTRATO/IDUSUARIO}"/>
				<input type="hidden" name="IDEMPRESA" id="IDEMPRESA" value="{CONTRATO/IDEMPRESAUSUARIO}"/>
				<input type="hidden" name="CON_IDDOCUMENTO" id="CON_IDDOCUMENTO" value="{CONTRATO/CON_IDDOCUMENTO}"/>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='modelo']/node()"/>(<span class="camposObligatorios">*</span>):</label>
					<xsl:choose>
					<xsl:when test="NOEDICION">
						<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="CONTRATO/MODELOS/field"></xsl:with-param>
						<xsl:with-param name="claSel">form-control w300px</xsl:with-param>
						<xsl:with-param name="required">required</xsl:with-param>
						<xsl:with-param name="deshabilitado">disabled</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="CONTRATO/MODELOS/field"></xsl:with-param>
						<xsl:with-param name="claSel">form-control w300px</xsl:with-param>
						<xsl:with-param name="required">required</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
					</xsl:choose>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='codigo']/node()"/>(<span class="camposObligatorios">*</span>):</label>
        			<xsl:choose>
        			  <xsl:when test="NOEDICION">
            			&nbsp;<xsl:value-of select="CONTRATO/CON_CODIGO"/>
        			  </xsl:when>
        			  <xsl:otherwise>
        				<input type="text" name="CON_CODIGO" class="form-control campopesquisa w100px" data-parsley-trigger="change" required="" maxlength="50" value="{CONTRATO/CON_CODIGO}"/>
        			  </xsl:otherwise>
        			</xsl:choose>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>(<span class="camposObligatorios">*</span>):</label>
        			<xsl:choose>
        			  <xsl:when test="NOEDICION">
            			&nbsp;<xsl:value-of select="CONTRATO/CON_TITULO"/>
        			  </xsl:when>
        			  <xsl:otherwise>
        				<input type="text" name="CON_TITULO" class="form-control campopesquisa w300px" data-parsley-trigger="change" required="" maxlength="50" value="{CONTRATO/CON_TITULO}"/>
        			  </xsl:otherwise>
        			</xsl:choose>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>(<span class="camposObligatorios">*</span>):</label>
					<xsl:choose>
					<xsl:when test="NOEDICION">
						<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="CONTRATO/PROVEEDORES/field"></xsl:with-param>
						<xsl:with-param name="claSel">form-control w300px</xsl:with-param>
						<xsl:with-param name="required">required</xsl:with-param>
						<xsl:with-param name="deshabilitado">disabled</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="CONTRATO/PROVEEDORES/field"></xsl:with-param>
						<xsl:with-param name="claSel">form-control w300px</xsl:with-param>
						<xsl:with-param name="required">required</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
					</xsl:choose>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_firma']/node()"/>(<span class="camposObligatorios">*</span>):</label>
        			<xsl:choose>
        			  <xsl:when test="NOEDICION">
            			&nbsp;<xsl:value-of select="CONTRATO/CON_FECHAFIRMA"/>
        			  </xsl:when>
        			  <xsl:otherwise>
        				<input type="text" name="CON_FECHAFIRMA" class="form-control campopesquisa w80px" placeholder="DD/MM/YY" style="width:100px;" data-parsley-trigger="change" required="" maxlength="10" value="{CONTRATO/CON_FECHAFIRMA}"/>&nbsp;(dd/mm/aa)
        			  </xsl:otherwise>
        			</xsl:choose>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_inicio']/node()"/>(<span class="camposObligatorios">*</span>):</label>
        			<xsl:choose>
        			  <xsl:when test="NOEDICION">
            			&nbsp;<xsl:value-of select="CONTRATO/CON_FECHAINICIO"/>
        			  </xsl:when>
        			  <xsl:otherwise>
        				<input type="text" name="CON_FECHAINICIO" class="form-control campopesquisa w80px" placeholder="DD/MM/YY" style="width:100px;" data-parsley-trigger="change" required="" maxlength="10" value="{CONTRATO/CON_FECHAINICIO}"/>&nbsp;(dd/mm/aa)
        			  </xsl:otherwise>
        			</xsl:choose>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_final']/node()"/>(<span class="camposObligatorios">*</span>):</label>
        			<xsl:choose>
        			  <xsl:when test="NOEDICION">
            			&nbsp;<xsl:value-of select="CONTRATO/CON_FECHAFINAL"/>
        			  </xsl:when>
        			  <xsl:otherwise>
        				<input type="text" name="CON_FECHAFINAL" class="form-control campopesquisa w80px" placeholder="DD/MM/YY" style="width:100px;" data-parsley-trigger="change" required="" maxlength="10" value="{CONTRATO/CON_FECHAFINAL}"/>&nbsp;(dd/mm/aa)
        			  </xsl:otherwise>
        			</xsl:choose>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Duracion_contrato']/node()"/>(<span class="camposObligatorios">*</span>):</label>
        			<xsl:choose>
        			  <xsl:when test="NOEDICION">
            			&nbsp;<xsl:value-of select="CONTRATO/CON_DURACIONCONTRATO"/>
        			  </xsl:when>
        			  <xsl:otherwise>
        				<input type="text" name="CON_DURACIONCONTRATO" class="form-control  campopesquisa w300px" data-parsley-trigger="change" required="" maxlength="50" value="{CONTRATO/CON_DURACIONCONTRATO}"/>
        			  </xsl:otherwise>
        			</xsl:choose>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</label>
        			<xsl:choose>
        			  <xsl:when test="NOEDICION">
            			&nbsp;<xsl:value-of select="CONTRATO/CON_DESCRIPCION"/>
        			  </xsl:when>
        			  <xsl:otherwise>
        				<input type="text" name="CON_DESCRIPCION" class="form-control campopesquisa w500px" data-parsley-trigger="change" maxlength="50" value="{CONTRATO/CON_DESCRIPCION}"/>
        			  </xsl:otherwise>
        			</xsl:choose>
				</li>
				</form>
				<form class="formEstandar" name="Documentos" method="post">
					<xsl:choose>
					<xsl:when test="CONTRATO/DOCUMENTO/NOMBRE">
					<li>
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Contrato']/node()"/>:</label>
            			<a href="javascript:VerDocumento('{CONTRATO/DOCUMENTO/NOMBRE}','http://www.newco.dev.br/Documentos/{CONTRATO/DOCUMENTO/URL}')"><xsl:value-of select="CONTRATO/DOCUMENTO/NOMBRE"/></a>&nbsp;&nbsp;&nbsp;
						<a href="javascript:EliminarDocumento();">
							<img src="http://www.newco.dev.br/images/2017/trash.png"/><!--<xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/>-->
						</a>
					</li>
    				</xsl:when>
        			<xsl:otherwise>
					<li>
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='subir_contrato']/node()"/>:</label>
						<div class="docLine" id="docLine">
						<div class="docLongEspec" id="docLongEspec">
						<input id="inputFileDoc" name="inputFileDoc" type="file" style="width:500px;" onChange="javascript:addDocFile();cargaDoc();" />
						</div>
						</div>
		  				<div id="waitBoxDoc" align="center" style="display:none;">&nbsp;</div>
  		  				<div id="confirmBoxDocEmpresa" align="center" style="display:none;"><span class="cargado">¡<xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/>!</span></div>
					</li>
        			</xsl:otherwise>
        			</xsl:choose>

					<!--	campos necesarios para subir/borrar documentos	-->
        			<input type="hidden" name="CADENA_DOCUMENTOS" id="CADENA_DOCUMENTOS"/>
        			<input type="hidden" name="DOCUMENTOS_BORRADOS"  id="DOCUMENTOS_BORRADOS"/>
        			<input type="hidden" name="BORRAR_ANTERIORES"  id="BORRAR_ANTERIORES"/>
        			<input type="hidden" name="REMOVE" id="REMOVE" value="{document($doc)/translation/texts/item[@name='remove']/node()}"/>
					<input type="hidden" name="TIPO_DOC" id="TIPO_DOC" value="CONTRATO"/>
				</form>
			</ul>

			<div id="uploadFrameBox" style="display:none;"><iframe id="uploadFrame" name="uploadFrame" style="width:100%;"></iframe></div>
			<div id="uploadFrameBoxDoc" style="display:none;"><iframe id="uploadFrameDoc" name="uploadFrameDoc" style="width:100%;"></iframe></div>
    	</div>
		<!--	FIN nuevo formulario	-->

		<!--mensajes js -->
		<form name="MensajeJS">
			<input type="hidden" name="SEGURO_ELIMINAR_OFERTA" value="{document($doc)/translation/texts/item[@name='seguro_eliminar_oferta']/node()}"/>
			<input type="hidden" name="SEGURO_ELIMINAR_OFERTA_ANE" value="{document($doc)/translation/texts/item[@name='seguro_eliminar_anexo']/node()}"/>
			<input type="hidden" name="SEGURO_ELIMINAR_FICHA" value="{document($doc)/translation/texts/item[@name='seguro_eliminar_ficha']/node()}"/>
			<input type="hidden" name="SEGURO_ASOCIAR_OFERTA" value="{document($doc)/translation/texts/item[@name='seguro_asociar_oferta']/node()}"/>
			<input type="hidden" name="SEGURO_MODIFICAR_FECHA" value="{document($doc)/translation/texts/item[@name='seguro_modificar_fecha']/node()}"/>
			<!--carga documentos-->
			<input type="hidden" name="ERROR_SIN_DEFINIR" value="{document($doc)/translation/texts/item[@name='error_sin_definir']/node()}"/>
			<input type="hidden" name="HEMOS_ESPERADO" value="{document($doc)/translation/texts/item[@name='hemos_esperado']/node()}"/>
			<input type="hidden" name="LA_CARGA_NO_TERMINO" value="{document($doc)/translation/texts/item[@name='la_carga_no_termino']/node()}"/>
			<input type="hidden" name="CARGANDO_IMAGEN" value="{document($doc)/translation/texts/item[@name='cargando_imagen']/node()}"/>
			<input type="hidden" name="FICHA_OBLIGATORIA" value="{document($doc)/translation/texts/item[@name='ficha_obligatoria']/node()}"/>
			<input type="hidden" name="TIPO_OBLIGATORIO" value="{document($doc)/translation/texts/item[@name='Tipo_doc_obligatorio']/node()}"/>
		</form>
		<!--fin de mensajes js -->
		
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
	</xsl:otherwise>
	</xsl:choose><!--fin choose si contrato guardado con exito-->
	</div><!--fin de divLeft-->
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
