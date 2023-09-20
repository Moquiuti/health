<?xml version="1.0" encoding="iso-8859-1"?>
<!-- 
	Mantenimiento del seguimiento de empresas
	Ultima revision: ET 4jun19 17:48
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/Seguimiento">

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="LANG != ''"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--fin idioma-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='seguimiento_titulo']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->
  <link href="http://www.newco.dev.br/General/Tabla-popup.150715.css" rel="stylesheet" type="text/css"/>

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/Seguimiento_230819.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/CargaDocumentosSeg_030619.js"></script><!--	3jun19 Incluir documentos en seguimiento	-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/Tabla-popup.150715.js"></script>
	<script type="text/javascript">
		var crearCentro	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='crear_centro']/node()"/>';
		var textoObli	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_obli']/node()"/>';
		var alrt_BorrarDocumentoKO	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_borrar_documento']/node()"/>';	
		var alrt_FaltaGestion	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_informar_gestion_borrar']/node()"/>';
		var alrt_FaltaDescripcion	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_informar_descripcion']/node()"/>';
	</script>
</head>

<body onLoad="javascript:Inicio();">
<xsl:choose>
<!-- Error en alguna sentencia del XSQL -->
<xsl:when test="//xsql-error">
	<xsl:apply-templates select="//xsql-error"/>
</xsl:when>
<xsl:when test="//SESION_CADUCADA">
	<xsl:for-each select="//SESION_CADUCADA">
		<xsl:if test="position()=last()">
			<xsl:apply-templates select="."/>
		</xsl:if>
	</xsl:for-each>
</xsl:when>
<xsl:otherwise>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="LANG != ''"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--fin idioma-->

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='seguimiento']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>&nbsp;</span></p>
		<p class="TituloPagina">
			<xsl:value-of select="ENTRADAS_SEGUIMIENTO/TITULOS/EMPRESA" disable-output-escaping="yes"/>
			<span class="CompletarTitulo">
			<!--23ago19 <xsl:if test="ENTRADAS_SEGUIMIENTO/COMERCIAL and ENTRADAS_SEGUIMIENTO/EMPRESAS/field/@current != ''">-->
			<xsl:if test="ENTRADAS_SEGUIMIENTO/COMERCIAL">
				<a class="btnDestacado" href="javascript:AbrirNuevo();"><xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/></a>
				&nbsp;
			</xsl:if>
			<a class="btnNormal" href="javascript:window.print();" style="text-decoration:none;" title="Imprimir">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
			</a>
			&nbsp;
			<a class="btnNormal" id="btnTareas" href="http://www.newco.dev.br/Gestion/Comercial/Tareas.xsql">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Tareas']/node()"/>
			</a>
			&nbsp;
			</span>
		</p>
	</div>
	<br/>

	<form name="frmSeg" action="Seguimiento.xsql" method="post">
		<input type="hidden" name="IDPAIS" value="{ENTRADAS_SEGUIMIENTO/TITULOS/IDPAIS}"/>
		<input type="hidden" name="IDEMPRESAUSUARIO" value="{ENTRADAS_SEGUIMIENTO/IDEMPRESAUSUARIO}"/>
		<input type="hidden" name="IDEMPRESA" value="{ENTRADAS_SEGUIMIENTO/TITULOS/IDEMPRESA}"/>
		<input type="hidden" name="EMPRESA" id="EMPRESA" value="{ENTRADAS_SEGUIMIENTO/TITULOS/EMPRESA}"/>
		<input type="hidden" name="FECHA" id="FECHA" value="{ENTRADAS_SEGUIMIENTO/TITULOS/FECHA}"/>
		<input type="hidden" name="IDDOCUMENTO" id="IDDOCUMENTO" value=""/>
		<input type="hidden" name="FIDEMPRESA" value="{ENTRADAS_SEGUIMIENTO/EMPRESAS/field/@current}"/>
		<input type="hidden" name="FIDCENTRO" value="{ENTRADAS_SEGUIMIENTO/LISTACENTROS/field/@current}"/>
		<input type="hidden" name="SOLO_CLIENTES"/>
		<input type="hidden" name="SOLO_PROVEE"/>
		<input type="hidden" name="ACCION" id="ACCION"/>
		<input type="hidden" name="PARAMETROS" id="PARAMETROS"/>

		<!--	para subir documentos	-->
    	<input type="hidden" name="CADENA_DOCUMENTOS" />
    	<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
    	<input type="hidden" name="BORRAR_ANTERIORES"/>
    	<input type="hidden" name="ID_USUARIO" value="" />
    	<input type="hidden" name="TIPO_DOC" value="DOC_SEGUIMIENTO"/>

    	<div id="uploadFrameBox" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>
    	<div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>

		<div class="divLeft">

			<!-- Pop-up para editar las entradas de seguimiento -->
			<div class="overlay-container" id="EditarSeguimientoWrap">
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
						<xsl:value-of select="document($doc)/translation/texts/item[@name='modificar']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='seguimiento']/node()"/>&nbsp;
						<xsl:value-of select="document($doc)/translation/texts/item[@name='para']/node()"/>&nbsp;
						<span id="NombreEmpresa"></span>,&nbsp;
						<xsl:value-of select="document($doc)/translation/texts/item[@name='dia']/node()"/>&nbsp;
						<span id="FechaSeguimiento"></span>
					</p>

					<div id="mensError" class="divLeft" style="display:none;">
						<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></strong></p>
					</div>

					<!--<form name="EditarSeguimientoForm" method="post" id="EditarSeguimientoForm">-->
					<input type="hidden" name="ES_IDEntrada" id="ES_IDEntrada"/>
					<input type="hidden" name="ES_IDEmpresa" id="ES_IDEmpresa"/>

					<table id="EditarSeguimiento" class="buscador" style="width:100%;">
					<thead>
						<th colspan="3">&nbsp;</th>
					</thead>

					<tbody>
						<xsl:if test="ENTRADAS_SEGUIMIENTO/MVM">
						<tr class="subTituloTabla">
							<td class="quince"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:</strong></td>
								<td colspan="3" style="text-align:left;">
		              			<xsl:call-template name="desplegable">
									<xsl:with-param name="path" select="ENTRADAS_SEGUIMIENTO/USUARIOS/field"/>
									<xsl:with-param name="claSel">select200</xsl:with-param>
									<xsl:with-param name="nombre">ES_IDUSUARIO</xsl:with-param>
									<xsl:with-param name="id">ES_IDUSUARIO</xsl:with-param>
								</xsl:call-template>
							</td>
						</tr>
						</xsl:if>
						<tr class="sinLinea">
							<td class="quince"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</strong></td>
							<!--<td class="trenta" style="text-align:left; padding-left:3px;" id="ES_Centro">-->
							<td class="trenta" style="text-align:left;">
		            			 <!--
								  <select name="NS_IDCENTRO" id="NS_IDCENTRO" class="select200">
		                			<xsl:for-each select="ENTRADAS_SEGUIMIENTO/LISTACENTROS/field/dropDownList/listElem">
		                			  <option value="{ID}"><xsl:value-of select="listItem" /></option>
		                			</xsl:for-each>
		            			  </select>
								 -->
								<xsl:call-template name="desplegable">
									<xsl:with-param name="path" select="ENTRADAS_SEGUIMIENTO/LISTACENTROS/field"/>
									<xsl:with-param name="nombre">ES_IDCentro</xsl:with-param>
									<xsl:with-param name="id">ES_IDCentro</xsl:with-param>
								</xsl:call-template>
							</td>
							<td class="quince"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/>:</strong></td>
							<td style="text-align:left; padding-left:3px;">
								<xsl:call-template name="desplegable">
									<xsl:with-param name="path" select="ENTRADAS_SEGUIMIENTO/TIPO/field"/>
									<xsl:with-param name="nombre">ES_IDTipo</xsl:with-param>
									<xsl:with-param name="id">ES_IDTipo</xsl:with-param>
								</xsl:call-template>
								<!--<select name="ES_IDTipo" id="ES_IDTipo" class="select200"/>-->
							</td>
						</tr>

						<tr class="sinLinea">
							<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='visibilidad']/node()"/>:</strong></td>
							<td colspan="3" style="text-align:left; padding-left:3px;">
								<input type="radio" class="muypeq" name="ES_IDVisibilidad" id="ES_VIS_PRIVADA" value="P"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='priv']/node()"/>&nbsp;&nbsp;
								<input type="radio" class="muypeq" name="ES_IDVisibilidad" id="ES_VIS_CENTRO" value="C"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cen']/node()"/>&nbsp;&nbsp;
								<input type="radio" class="muypeq" name="ES_IDVisibilidad" id="ES_VIS_EMPRESA" value="E"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='emp']/node()"/>&nbsp;&nbsp;
							</td>
						</tr>

						<tr class="sinLinea">
							<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</strong></td>
							<td colspan="3" style="text-align:left; padding-left:3px;">
								<textarea name="ES_TEXTO" id="ES_TEXTO" cols="80" rows="10" style="float:left;margin-right:10px;"/>&nbsp;
							</td>
						</tr>

        				<!--	3jun19	Añadir documento al seguimiento		-->
						<tr class="sinLinea">
							<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/>:</strong></td>
							<td colspan="3" style="text-align:left; padding-left:3px;">
								<input style="width:500px;" id="inputFileDoc" name="inputFileDoc" type="file" onchange="javascript:addDocFile(document.forms['frmSeg']);cargaDoc(document.forms['frmSeg'], 'DOC_SEGUIMIENTO');"/>
								<div id="divDatosDocumento" style="display:none;">
            						<a id="docSubido">
                    					&nbsp;
                					</a>
									<a href="javascript:borrarDoc('DOC_SEGUIMIENTO')" style="width:20px;margin-top:4px;vertical-align:middle;"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>
								</div>
            					<div id="waitBoxDoc" style="display:none;"><img src="http://www.newco.dev.br/images/descarga.gif" alt="Descarga" /></div>
            					<div id="confirmBox" style="display:none;" align="center">
                					<span class="cargado" style="font-size:10px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/>!</span>
            					</div>
							</td>
        				</tr>
        				<!--	3jun19	Añadir documento al seguimiento		-->



					</tbody>

					<tfoot>
						<tr class="sinLinea">
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td style="text-align:left;">
								<!--<div class="boton" id="botonGuardar">-->
									<a class="btnDestacado" href="javascript:guardarSeguimiento();">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
									</a>
								<!--</div>-->
							</td>
							<td id="Respuesta" style="text-align:left;"></td>
						</tr>
					</tfoot>
					</table>
					<!--</form>-->
				</div>
			</div>
      <!-- FIN Pop-up para editar las entradas de seguimiento -->




		<table id="ListaSeguimiento" class="buscador">
		<!--<table id="ListaSeguimiento" class="infoTable" border="0">-->
			<thead>
        	<!--buscador-->
        	<!--<tr class="subTituloTablaNoB">-->
			<tr class="filtros">
				<td style="width:160px;text-align:left;" colspan="2">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/>:&nbsp;</label><br/>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="ENTRADAS_SEGUIMIENTO/FTIPO/field"/>
						<xsl:with-param name="nombre">FTIPO</xsl:with-param>
						<xsl:with-param name="id">FTIPO</xsl:with-param>
    					<!--<xsl:with-param name="claSel">peq</xsl:with-param>-->
					</xsl:call-template>
				</td>
				<td style="width:160px;text-align:left;">
					<xsl:if test="ENTRADAS_SEGUIMIENTO/EMPRESAS/field/@current != ''">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;</label><br/>
						<select name="FIDCENTRO" id="FIDCENTRO"><!-- class="peq"-->
							<xsl:for-each select="ENTRADAS_SEGUIMIENTO/LISTACENTROS/field/dropDownList/listElem">
						  	<option value="{ID}"><xsl:value-of select="listItem"/></option>
							</xsl:for-each>
						</select>
					</xsl:if>
				</td>
				<td style="width:160px;text-align:left;">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/>:&nbsp;</label><br/>
					<input type="text" name="FTEXTO" size="30" value="{TEXTO}" style="float:left;width:160px;"/>
				</td>
				<td style="width:160px;text-align:left;">
					<a class="btnDestacado" href="javascript:Buscador();">	<!--	18may16	GuardarEntrada	-->
						<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
					</a>
				</td>
				<td></td>
				<td style="width:160px;text-align:left;">
					<select name="NumLineas" id="NumLineas" onchange="mostrarLineas(this.value);"> <!--	se aplica en el javascript-->
						<option value="10">
							10 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
						</option>
						<option value="20" selected="selected">
							20 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
						</option>
						<option value="50">
							50 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
						</option>
						<option value="todas">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/>
						</option>
					</select>
				</td>
			</tr>
        	<tr class="subTituloTabla">
				<td class="uno">&nbsp;</td>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></td>
				<td class="datosLeft ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/></td>
				<td class="datosLeft dies">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>
				</td>
        	  	<td class="datosLeft dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/></td>
        	  	<td class="datosLeft quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/></td>
				<td class="datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/></td>
				<td>&nbsp;</td>
				<td class="uno">&nbsp;</td>
				<td class="tres">&nbsp;</td>
			</tr>
        	<!--fin buscador-->

				<!--	<tr class="subTituloTablaNoB line5"><td colspan="9" height="5px"></td></tr>-->
				</thead>

			<tbody>
    	  	<xsl:choose>
    	  	<xsl:when test="/Seguimiento/ENTRADAS_SEGUIMIENTO/SEGUIMIENTO/ENTRADA">
				<xsl:for-each select="ENTRADAS_SEGUIMIENTO/SEGUIMIENTO/ENTRADA">
					<xsl:variable name="id" select="ID"/>
					<xsl:choose>
					<xsl:when test="/Seguimiento/ENTRADAS_SEGUIMIENTO/IDUSUARIO=IDAUTOR or /Seguimiento/ENTRADAS_SEGUIMIENTO/SUPERUSUARIO">
        	  			<tr>
            			<xsl:choose>
            			<xsl:when test="MODIFICADO_1HORA">
            			  <xsl:attribute name="style">background:#ff9900;</xsl:attribute>
            			</xsl:when>
            			<xsl:when test="MODIFICADO_24HORAS">
            			  <xsl:attribute name="style">background:FFFF99;</xsl:attribute>
            			</xsl:when>
            			</xsl:choose>

            			<td>&nbsp;</td>
            			<td class="datosCenter"><strong><a href="javascript:Editar({ID});"><xsl:value-of select="FECHA"/></a></strong></td>
						<td style="text-align:left;">
							<xsl:value-of select="TIPO"/>
						</td>
            			<!--<td style="text-align:left;">
										<a href="javascript:CambiarEmpresaID({IDEMPRESA});">
												<xsl:value-of select="EMPRESA"/>
										</a>
                                                			</td>-->
            			<td style="text-align:left;font-weight:bold;" colspan="2">
            			  <xsl:value-of select="CENTRO" />&nbsp;(<a href="javascript:CambiarEmpresaID({IDEMPRESA});"><xsl:value-of select="EMPRESA"/></a>)
            			</td>
						<td style="text-align:left;">
            			  <span style="font-weight:bold;">
                			  <!--visibilidad-->
                    			<xsl:choose>
                        			<xsl:when test="VISIBILIDAD = 'P'"><img src="http://www.newco.dev.br/images/iconPrivada.gif" alt="Privada" style="vertical-align:top;" /></xsl:when>
                        			<xsl:when test="VISIBILIDAD = 'C'"><img src="http://www.newco.dev.br/images/iconCentro.gif" alt="Centro"  style="vertical-align:top;"/></xsl:when>
                        			<xsl:when test="VISIBILIDAD = 'E'"><img src="http://www.newco.dev.br/images/iconEmpresa.gif" alt="Empresa"  style="vertical-align:top;"/></xsl:when>
                    			</xsl:choose>&nbsp;
                			  <xsl:value-of select="AUTOR"/>
            			  </span>&nbsp;&nbsp;
            			  (<xsl:value-of select="CENTROAUTOR"/>)
            			</td>
						<td style="text-align:left;">
							<a href="http://www.newco.dev.br/Documentos/{DOC_SEGUIMIENTO/URL}" target="_blank"><xsl:value-of select="DOC_SEGUIMIENTO/NOMBRE"/></a>
            			</td>
						<td>&nbsp;</td>
						<td style="padding-left:50px;text-align:left;">
							<!--<a href="javascript:Editar({ID});" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/modificar.gif"/>
							</a>-->
							<a href="javascript:Borrar({ID});" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/2017/trash.png"/>
							</a>
						</td>
						<td>&nbsp;</td>
        			  </tr>
        			  <tr class="subTareasTot">
							<td colspan="2">&nbsp;</td>
							<td colspan="5" style="text-align:left;padding:5px 0px;"><xsl:copy-of select="TEXTO" /></td>
            			<td colspan="2">&nbsp;</td>
        			  </tr>
					</xsl:when>
					<xsl:otherwise>
        				  <tr>
            				<td>&nbsp;</td>
										<td class="datosCenter"><strong><xsl:value-of select="FECHA"/></strong></td>
										<td style="text-align:left;font-weight:bold;">
            	  							<xsl:value-of select="TIPO"/>
										</td>
            				<td style="text-align:left;font-weight:bold;" colspan="2">
            				  <xsl:value-of select="CENTRO" />
            				</td>
            				<td colspan="2" style="text-align:left;font-weight:bold;">
            				  <span style="font-weight:bold;">
                				  <!--visibilidad-->
                    				<xsl:choose>
                        				<xsl:when test="VISIBILIDAD = 'P'"><img src="http://www.newco.dev.br/images/iconPrivada.gif" alt="Privada" style="vertical-align:top;" /></xsl:when>
                        				<xsl:when test="VISIBILIDAD = 'C'"><img src="http://www.newco.dev.br/images/iconCentro.gif" alt="Centro"  style="vertical-align:top;"/></xsl:when>
                        				<xsl:when test="VISIBILIDAD = 'E'"><img src="http://www.newco.dev.br/images/iconEmpresa.gif" alt="Empresa"  style="vertical-align:top;"/></xsl:when>
                    				</xsl:choose>&nbsp;
                				  <xsl:value-of select="AUTOR"/>
            				  </span>&nbsp;&nbsp;&nbsp;
            				  <!--empresa, la oculto si hay una seleccionada arriba-->
            				  <xsl:if test="/Seguimiento/ENTRADAS_SEGUIMIENTO/EMPRESAS/field/@current = ''">
                				<a href="javascript:CambiarEmpresaID({IDEMPRESA});"><xsl:value-of select="EMPRESA"/></a>
            				  </xsl:if>
            				</td>
            				<td colspan="2">&nbsp;</td>
        				  </tr>
        				  <tr class="subTareasTot">
            				<td colspan="2">&nbsp;</td>
							<td colspan="5" style="text-align:left;padding:5px 0px;"><xsl:copy-of select="TEXTO"/></td>
            				<td colspan="2">&nbsp;</td>
        				  </tr>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
    		</xsl:when>
			<xsl:otherwise>
        		<tr style="border-bottom:2px solid #D7D8D7;"><td colspan="6" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='seguimiento_sin_resultados']/node()"/></strong></td></tr>
    	  	</xsl:otherwise>
    	  	</xsl:choose>
			</tbody>

    	</table>

      <br /><br />
		</div>

	</form>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
