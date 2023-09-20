<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 |
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>

<xsl:template name="productosEquivalentes">
	<xsl:param name="pro_id"/>

	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Productos/LANG"><xsl:value-of select="/Productos/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:variable name="usuario">
		<xsl:choose>
		<xsl:when test="/Productos/PRODUCTO/PRODUCTO/OBSERVADOR">OBSERVADOR</xsl:when>
		<xsl:when test="/Productos/PRODUCTO/PRODUCTO/MVM or /Productos/PRODUCTO/PRODUCTO/MVMB or /Productos/PRODUCTO/PRODUCTO/CDC">CDC</xsl:when>
		<xsl:otherwise>NORMAL</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<!--nuevo producto -->
	<form name="form1" id="form1" method="post">
		<input type="hidden" name="IDPROD" id="IDPROD" value="{$pro_id}"/>
		<input type="hidden" name="ACCION" id="ACCION" value="NUEVO"/>
		<input type="hidden" name="REMOVE" value="{document($doc)/translation/texts/item[@name='remove']/node()}"/>
		<input type="hidden" name="CHANGE_PROV" value="N"/>
		<input type="hidden" name="TIPO_DOC" value="FT"/>
		<input type="hidden" name="ID_USUARIO" value="{/*/US_ID}"/>
		<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
		<input type="hidden" name="BORRAR_ANTERIORES"/>
		<input type="hidden" name="IDPROVEEDOR" id="IDPROVEEDOR"/>
		<input type="hidden" name="CADENA_DOCUMENTOS"/>
		

	<xsl:if test="/Productos/PRODUCTO/PRODUCTO/EQUIVALENTES/EQUIVALENTES_LICITACIONES/OFERTA">
		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='productos_equivalentes_licitacion']/node()"/></h1>

		<table id="ProdEquivLic" class="infoTable" cellspacing="0" cellpadding="0">
		<thead>
			<tr class="subTituloTabla">
				<th class="zerouno">&nbsp;</th>
				<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></th>
				<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
				<th class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></th>
				<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion']/node()"/></th>
				<th class="zerouno">&nbsp;</th>
			</tr>
                </thead>
		<tbody>
		<xsl:for-each select="/Productos/PRODUCTO/PRODUCTO/EQUIVALENTES/EQUIVALENTES_LICITACIONES/OFERTA">
			<tr id="ID_{LIC_OFE_ID}">
				<td>&nbsp;</td>
				<td class="datosLeft"><xsl:value-of select="LIC_OFE_REFERENCIA"/></td>
				<td class="datosLeft"><xsl:value-of select="PROVEEDOR"/></td>
				<td class="datosLeft"><xsl:value-of select="LIC_OFE_NOMBRE"/></td>
				<td class="datosLeft"><xsl:value-of select="LIC_OFE_MARCA"/></td>
				<td>
				<xsl:if test="LIC_OFE_IDESTADOEVALUACION = 'NOAPTO'">
					<xsl:attribute name="class">celdaconrojo</xsl:attribute>
				</xsl:if>
					<xsl:value-of select="ESTADOEVALUACION"/>
				</td>
				<td>&nbsp;</td>
			</tr>
		</xsl:for-each>
		</tbody>
		</table>
		<br />
		<br />
	</xsl:if>

	<xsl:choose>
	<xsl:when test="/Productos/PRODUCTO/PRODUCTO/EQUIVALENTES/EQUIVALENTES_LICITACIONES/OFERTA">
		<h1 class="titlePage">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='productos_equivalentes_manual']/node()"/>
			<xsl:value-of select="/Productos/PRODUCTO/PRODUCTO/EQUIVALENTES/CLIENTE"/>
		</h1>
	</xsl:when>
	<xsl:otherwise>
		<h1 class="titlePage">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='productos_equivalentes_para']/node()"/>
			<xsl:value-of select="/Productos/PRODUCTO/PRODUCTO/EQUIVALENTES/CLIENTE"/>
		</h1>
	</xsl:otherwise>
	</xsl:choose>

		<table id="ProdEquivManual" class="infoTable" cellspacing="0" cellpadding="0">
		<thead>
			<tr class="subTituloTabla">
				<th class="zerouno">&nbsp;</th>
<!--				<th class="cinco"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/></strong></th>-->
				<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></th>
				<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
				<th class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></th>
				<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion']/node()"/></th>
				<th class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='ficha_tecnica']/node()"/></th>
				<th class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/></th>
				<th class="uno">&nbsp;</th>
				<th class="zerouno">&nbsp;</th>
			</tr>
                </thead>
		<tbody>
		<xsl:choose>
		<xsl:when test="/Productos/PRODUCTO/PRODUCTO/EQUIVALENTES/EQUIVALENTES_MANUALES/PRODUCTO">
			<xsl:for-each select="/Productos/PRODUCTO/PRODUCTO/EQUIVALENTES/EQUIVALENTES_MANUALES/PRODUCTO">
			<tr id="ID_{PRO_EQ_ID}">
				<td>&nbsp;</td>
				<td class="datosLeft Referencia"><xsl:value-of select="PRO_EQ_REFERENCIA"/></td>
				<td class="datosLeft Proveedor"><xsl:value-of select="PRO_EQ_PROVEEDOR"/></td>
				<td class="datosLeft Nombre"><a href="javascript:llenarFormEquiv({PRO_EQ_ID})"><xsl:value-of select="PRO_EQ_NOMBRE"/></a></td>
				<td class="datosLeft Marca"><xsl:value-of select="PRO_EQ_MARCA"/></td>
				<td>
				<xsl:choose>
				<xsl:when test="PRO_EQ_IDESTADOEVALUACION = 'NOAPTO'">
					<xsl:attribute name="class">celdaconrojo Evaluacion</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="class">Evaluacion</xsl:attribute>
				</xsl:otherwise>
				</xsl:choose>
					<xsl:value-of select="ESTADOEVALUACION"/>
				</td>
				<td class="FichaTecnica">
				<xsl:choose>
				<xsl:when test="FICHA_TECNICA/ID">
					<a href="http://www.newco.dev.br/Documentos/{FICHA_TECNICA/URL}" id="{FICHA_TECNICA/ID}">
						<xsl:value-of select="FICHA_TECNICA/NOMBRE"/>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_ficha']/node()"/>
				</xsl:otherwise>
				</xsl:choose>
                                </td>
				<td class="datosLeft Comentarios"><xsl:value-of select="PRO_EQ_COMENTARIOS"/></td>
				<td class="Accion">
				<xsl:if test="$usuario != 'OBSERVADOR'">
					<a href="javascript:borrarProdEquiv({PRO_EQ_ID});">
						<img src="http://www.newco.dev.br/images/2017/trash.png">
							<xsl:attribute name="title">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>
							</xsl:attribute>
                                                </img>
                                        </a>
				</xsl:if>
				</td>
				<td>&nbsp;</td>
			</tr>
			</xsl:for-each>
		</xsl:when>
		<xsl:otherwise>
			<tr><td colspan="10"><xsl:value-of select="document($doc)/translation/texts/item[@name='sin_productos_equiv_manuales']/node()"/></td></tr>
		</xsl:otherwise>
		</xsl:choose>
		</tbody>
		</table>
		<br /><br /><br /><br />

	<xsl:if test="$usuario != 'OBSERVADOR'">
		<table class="infoTable">
		<thead>
			<tr class="subTituloTabla"><th colspan="7"><xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_prod_equiv']/node()"/></th></tr>
                </thead>

			<tr>
				<td>&nbsp;</td>
				<td class="labelRight veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/>:</td>
				<td class="datosLeft"><input type="text" name="REF_EQUI" id="REF_EQUI"/></td>
				<td class="uno">&nbsp;</td>
				<td class="labelRight quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</td>
				<td class="datosLeft">
					<select name="PROV_EQUI_DESPLE" id="PROV_EQUI_DESPLE" onchange="proveedorManual(this.value);">
						<option value=""><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciona']/node()"/></option>
						<option value="PROV_MANUAL"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor_manual']/node()"/></option>
						<xsl:for-each select="/Productos/PRODUCTO/PRODUCTO/EQUIVALENTES/PROVEEDORES/PROVEEDOR">
							<option value="{ID}"><xsl:value-of select="NOMBRE"/></option>
						</xsl:for-each>
					</select>
					<span style="display:none;" id="PROV_EQUI_SPAN">
						<input type="text" name="PROV_EQUI_MANUAL" id="PROV_EQUI_MANUAL"/>&nbsp;
						<img src="http://www.newco.dev.br/images/2017/reload.png" onclick="proveedorManual('desplegable');">
							<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/></xsl:attribute>
                                                </img>
                                        </span>
				</td>
				<td>&nbsp;</td>
			</tr>

			<tr>
				<td>&nbsp;</td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:</td>
				<td class="datosLeft"><input type="text" name="NOMBRE_EQUI" id="NOMBRE_EQUI"/></td>
				<td>&nbsp;</td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>:</td>
				<td class="datosLeft"><input type="text" name="MARCA_EQUI" id="MARCA_EQUI"/></td>
				<td>&nbsp;</td>
			</tr>

			<tr>
				<td>&nbsp;</td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado_evaluacion']/node()"/>:</td>
				<td class="datosLeft">
					<select name="IDESTADOEVAL" id="IDESTADOEVAL">
						<option value=""><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciona']/node()"/></option>
						<xsl:for-each select="/Productos/PRODUCTO/PRODUCTO/EQUIVALENTES/ESTADOSEVALUACION/field/dropDownList/listElem">
							<option value="{ID}"><xsl:value-of select="listItem"/></option>
						</xsl:for-each>
					</select>
				</td>
				<td>&nbsp;</td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentario']/node()"/>:</td>
				<td class="datosLeft"><textarea type="text" name="COMENTARIO_EQUI" id="COMENTARIO_EQUI"/></td>
				<td>&nbsp;</td>
			</tr>

			<tr>
				<td>&nbsp;</td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='ficha_tecnica']/node()"/>:</td>
				<td class="datosLeft" colspan="4">
					<select name="IDFICHA" id="IDFICHA" style="width:200px;">
						<option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='seleccionar_documento']/node()"/></option>
					</select>&nbsp;
					<a href="javascript:verCargaDoc('FT');" id="verFichaDoc" style="text-decoration:none;">
					<xsl:choose>
					<xsl:when test="/Productos/PRODUCTO/PRODUCTO/IDPAIS = '55'">
						<img src="http://www.newco.dev.br/images/subirFicheiro.gif" alt="Subir Ficheiro Tecnico"/>
					</xsl:when>
					<xsl:otherwise>
						<img src="http://www.newco.dev.br/images/subirFicha.gif" alt="Subir Ficha Técnica"/>
					</xsl:otherwise>
					</xsl:choose>
					</a>&nbsp;
					<a id="comprobarFT" style="display:none; float:left;" target="_blank"><img src="http://www.newco.dev.br/images/comprobar.gif" alt="Comprobar"/></a>
				</td>
				<td>&nbsp;</td>
			</tr>

			<tr id="cargaFT" class="cargas" style="display:none;">
				<td colspan="2">&nbsp;</td>
				<td colspan="4">
					<xsl:call-template name="CargaFT"/>
				</td>
				<td>&nbsp;</td>
			</tr>
                </table>

		<table>
			<tr><td colspan="3">&nbsp;</td></tr>
			<tr>
				<td class="cuarentacinco">&nbsp;</td>
				<td>
					<div class="boton">
						<a href="javascript:validarFormEquiv(document.forms['form1']);"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
					</div>
				</td>
				<td class="cuarentacinco">&nbsp;</td>
			</tr>

			<tr>
				<td>&nbsp;</td>
				<td colspan="2" id="FormEquivError" class="celdaconrojo bold" style="float:left;margin-top:10px;text-align:left;">&nbsp;</td>
			</tr>
		</table>
	</xsl:if>

	</form><!--fin de form prod equival-->

	<form name="mensajeJS">
		<!--carga documentos-->
		<input type="hidden" name="ERROR_SIN_DEFINIR" value="{document($doc)/translation/texts/item[@name='error_sin_definir']/node()}"/>
		<input type="hidden" name="HEMOS_ESPERADO" value="{document($doc)/translation/texts/item[@name='hemos_esperado']/node()}"/>
		<input type="hidden" name="LA_CARGA_NO_TERMINO" value="{document($doc)/translation/texts/item[@name='la_carga_no_termino']/node()}"/>
		<input type="hidden" name="CARGANDO_IMAGEN" value="{document($doc)/translation/texts/item[@name='cargando_imagen']/node()}"/>
		<input type="hidden" name="FICHA_OBLIGATORIA" value="{document($doc)/translation/texts/item[@name='ficha_obligatoria']/node()}"/>
		<input type="hidden" name="FECHA_LIMITE_OBLI" id="FECHA_LIMITE_OBLI" value="{document($doc)/translation/texts/item[@name='fecha_limite_obli']/node()}" />
		<input type="hidden" name="ERROR_GUARDAR_FECHA" id="ERROR_GUARDAR_FECHA" value="{document($doc)/translation/texts/item[@name='error_guardar_fecha']/node()}" />
	</form>
</xsl:template><!--fin de datosCliente-->

<xsl:template name="CargaFT">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/*/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="divLeft" id="cargaDocFT">
		<div id="confirmBoxFT" style="display:none;" align="center">
			<span class="cargado">¡<xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/>!</span>
		</div>

		<!--tabla imagenes y documentos-->
		<table class="infoTable" border="0" style="margin-top:15px;">
			<tr>
				<!--documentos-->
				<td class="labelRight dies">
					<span class="textFT"><xsl:value-of select="document($doc)/translation/texts/item[@name='subir_ficha']/node()"/>:</span>
				</td>
				<td class="datosLeft quince">
					<div class="altaDocumento">
						<span class="anadirDoc">
							<xsl:call-template name="documentos">
								<xsl:with-param name="num" select="number(1)"/>
								<xsl:with-param name="type" select="'FT'"/>
							</xsl:call-template>
						</span>
					</div>
				</td>
				<td class="dies">
					<div class="boton">
						<a href="javascript:validateIDProvFT();">
							<span class="textFT"><xsl:value-of select="document($doc)/translation/texts/item[@name='subir_ficha']/node()"/></span>
						</a>
					</div>
				</td>
				<td><div id="messageBoxFT" style="display:none;float:left;" align="center" class="celdaconrojo bold"></div></td>
			</tr>
		</table><!--fin de tabla imagenes doc-->

		<div id="waitBoxDocFT" align="center">&nbsp;</div>
	</div><!--fin de divleft-->

	<div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>
</xsl:template><!--fin de template carga documentos-->

<!--documentos-->
<xsl:template name="documentos">
<xsl:param name="num"/>
<xsl:param name="type"/>
<xsl:choose>
<!--imagenes de la tienda-->
<xsl:when test="$num &lt; number(5)">
	<div class="docLine" id="docLine_{$type}">
		<div class="docLongEspec" id="docLongEspec_{$type}">
			<input id="inputFileDoc_{$type}" name="inputFileDoc" type="file" onChange="addDocFile('{$type}');"/>
		</div>
	</div>
</xsl:when>	
</xsl:choose>
</xsl:template><!--fin de documentos-->
</xsl:stylesheet>