<?xml version="1.0" encoding="iso-8859-1"?>
<!-- 
	Template para la pestaña de proveedores de la licitación
	ultima revision: ET 21dic21 15:35
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>

<!-- Tabla Proveedores Antes de Adjudicar -->
<xsl:template name="Tabla_Proveedores_Previo">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:value-of select="/Mantenimiento/LANG"/>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<div id="lProveedores" class="posContenedorLic" style="display:none;"> <!--style="border:1px solid black"> -->
	<!--<table class="divLeft infoTable" id="lProveedores_EST" style="border:1px solid black">-->
	<table class="buscador" id="lProveedores_EST" style="border:1px solid black">
		<!--"border-bottom:1px solid #999999;" border="1">-->
		<thead>
		<tr class="subTituloTabla">
			<td class="uno">&nbsp;</td>
			<td class="zerouno">&nbsp;</td>
			<td class="quince" style="text-align:left;">
				<!-- Permitimos ordenacion -->
				&nbsp;<a href="javascript:OrdenarProvsPorColumna('NombreCorto');" style="text-decoration:none;" id="anchorNombreProv">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>
				</a>
			</td>
			<td class="dies" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></td>
			<!-- conversaciones -->
			<td class="dos">&nbsp;</td>
			<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_oferta']/node()"/></td>
			<td class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion_abr']/node()"/></td>
			<td class="cinco">
				<input type="checkbox" onchange="javascript:SoloProvInformados=(this.checked)?'S':'N';dibujaTablaProveedores();"><!-- checked="checked"/>-->
					<xsl:choose>
					<xsl:when test="/Mantenimiento/LICITACION/LIC_IDESTADO = 'EST' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'COMP'">
						<xsl:attribute name="unchecked">unchecked</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="checked">checked</xsl:attribute>
					</xsl:otherwise>
					</xsl:choose>
				</input>
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='estado_oferta']/node()"/>
			</td>
			<!--	30ago16	Quitamos comentarios para simplificar la tabla
			<td class="tres"><xsl:copy-of select="document($doc)/translation/texts/item[@name='comentarios_cdc_abbr']/node()"/></td>
			<td class="tres"><xsl:copy-of select="document($doc)/translation/texts/item[@name='comentarios_prov_abbr']/node()"/></td>
			-->
			<td class="cuatro">
				<!-- Permitimos ordenacion -->
				<a href="javascript:OrdenarProvsPorColumna('OfeMejPrecio');" style="text-decoration:none;" id="anchorNumOfeMejorPrecio">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='num_prods_mejor_precio']/node()"/>
				</a>
			</td>
			<td class="cuatro">
				<!-- Permitimos ordenacion -->
				<a href="javascript:OrdenarProvsPorColumna('OfeConAhorro');" style="text-decoration:none;" id="anchorNumOfeConAhorro">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='num_prods_oferta_ahorro']/node()"/>
				</a>
			</td>
			<td class="cuatro">
				<!-- Permitimos ordenacion -->
				<a href="javascript:OrdenarProvsPorColumna('NumeroLineas');" style="text-decoration:none;" id="anchorNumOfertasProv">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='num_prods']/node()"/>
                </a>
			</td>
			<!--	6jul16	Quitamos las columnas de consumo mejor precio y consumo con ahorro, son poco informativas
			<td class="seis" style="text-align:right;">
				< ! - - Permitimos ordenacion - - >
				<a style="text-decoration:none;" id="anchorConsMejorPrecio">
					<xsl:choose>
					<xsl:when test="not(/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA)">
						<xsl:attribute name="href">javascript:OrdenarProvsPorColumna('ConsMejPrecio');</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="href">javascript:OrdenarProvsPorColumna('ConsMejPrecIVA');</xsl:attribute>
					</xsl:otherwise>
					</xsl:choose>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_mejor_precio']/node()"/>
				</a>
			</td>
			<td class="seis" style="text-align:right;">
				< ! - - Permitimos ordenacion - - >
				<a style="text-decoration:none;" id="anchorConsConAhorro">
					<xsl:choose>
					<xsl:when test="not(/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA)">
						<xsl:attribute name="href">javascript:OrdenarProvsPorColumna('ConsConAhorro');</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="href">javascript:OrdenarProvsPorColumna('ConsConAhorIVA');</xsl:attribute>
					</xsl:otherwise>
					</xsl:choose>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_oferta_ahorro']/node()"/>
				</a>
			</td>
			-->
			<!--	6jul16	nueva columna frete, solo para Brasil	-->
			<xsl:if test="/Mantenimiento/LICITACION/IDPAIS = 55">
			<td class="cuatro">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='frete']/node()"/>
			</td>
			</xsl:if>
			<!--	6jul16	nueva columna plazo de entrega	-->
			<td class="cuatro">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/>
			</td>
		<xsl:choose>
		<xsl:when test="not(/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA)">
			<td class="seis" style="text-align:right;">
				<!-- Permitimos ordenacion -->
				<a href="javascript:OrdenarProvsPorColumna('ConsumoProv');" style="text-decoration:none;" id="anchorConsumoProv">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_sIVA']/node()"/>&nbsp;
				</a>
			</td>
		</xsl:when>
		<xsl:otherwise>
			<td class="seis" style="text-align:right;">
				<!-- Permitimos ordenacion -->
				<a href="javascript:OrdenarProvsPorColumna('ConsumoProvIVA');" style="text-decoration:none;" id="anchorConsumoIVAProv">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_cIVA_2line']/node()"/>&nbsp;
				</a>
			</td>
		</xsl:otherwise>
		</xsl:choose>

			<td class="cuatro">
				<!-- Permitimos ordenacion -->
				<a href="javascript:OrdenarProvsPorColumna('AhorMejPrecio');" style="text-decoration:none;" id="anchorAhorroMejorPrecio">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro_mejor_precio']/node()"/>
				</a>
			</td>
			<td class="cuatro">
				<!-- Permitimos ordenacion -->
				<a href="javascript:OrdenarProvsPorColumna('AhorOfeConAhor');" style="text-decoration:none;" id="anchorAhorroOfeConAhorro">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro_oferta_ahorro']/node()"/>
				</a>
			</td>
			<td class="cuatro">
				<!-- Permitimos ordenacion -->
				<a href="javascript:OrdenarProvsPorColumna('Ahorro');" style="text-decoration:none;" id="anchorAhorroProv">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='porcentaje_ahorro']/node()"/>
				</a>
			</td>

			<td class="cinco">
				<!-- Permitimos ordenacion -->
				<a href="javascript:OrdenarProvsPorColumna('PedidoMin');" style="text-decoration:none;" id="anchorPedMinProv">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='pedido_minimo_sIVA_2line']/node()"/>
				</a>
			</td>
			<td class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='acciones']/node()"/></td>
		</tr>
	</thead>

	<!-- Aqui dentro se informara el cuerpo de la tabla via javascript -->
	<tbody></tbody>

	</table>


	<xsl:if test="/Mantenimiento/LICITACION/AUTOR">
	<br/>
	<div id="pestanasProv">
		<ul class="pestannas">
			<li>
				<a id="pes_lpSelecciones" class="MenuProv"><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciones']/node()"/></a>
			</li>
			<li>
				<a id="pes_lpProveedores" class="MenuProv"><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/></a>
			</li>
		</ul>
	</div>
	<br/>
	<br/>

	<form id="Proveedores" name="Proveedores" method="post">
		<div id="lpSelecciones">
		<table class="buscador" id="tSelecciones" cellspacing="5">
			<xsl:for-each select="/Mantenimiento/LICITACION/PROVEEDORES/PROVEEDOR">
				<xsl:if test="substring(ID,1,4)='SEL_'">
					<tr class="sinLinea">
						<td class="veinte">&nbsp;</td>
						<td class="cincuenta datosLeft">
							<input type="checkbox" name="PROV_{ID}" id="PROV_{ID}" class="muypeq"><xsl:value-of select="substring(NOMBRE,2)"/></input>
						</td>
						<td>&nbsp;</td>
					</tr>
				</xsl:if >
			</xsl:for-each>
			<!--	10dic21 Las selecciones que aparecen no son editables por el comprador
			<xsl:if test="/Mantenimiento/LICITACION/EDITAR_SELECCIONES">
			<tr class="sinLinea">
				<td class="diez">&nbsp;</td>
				<td class="veinte datosLeft">
					&nbsp;
					<a href="javascript:MostrarSelecciones();"><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciones']/node()"/></a>
					<xsl:text disable-output-escaping="yes">
					<![CDATA[
						<script type="text/javascript">
							//	Presenta la pagina con las selecciones
							function MostrarSelecciones(){
								var Enlace	= 'http://www.newco.dev.br/Gestion/EIS/EISSelecciones.xsql';

								MostrarPagPersonalizada(Enlace, '_blank', 100, 80, 0, 10);
							}
						</script>
					]]>
					</xsl:text>
				</td>
				<td>&nbsp;</td>
			</tr>
			</xsl:if>-->
			<tr class="sinLinea">
				<td class="diez">&nbsp;</td>
				<td class="veinte datosLeft">
					<a class="btnDestacado" id="btnAnadirSelecciones" href="javascript:ValidarFormulario(document.forms['Proveedores'],'selecciones');">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir']/node()"/>
					</a>
					&nbsp;&nbsp;
					<span id="spAnSel">&nbsp;</span>
				</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		</div>
		<div id="lpProveedores">
		<table class="buscador" id="tProveedores" cellspacing="5">
			<tr class="sinLinea">
				<td class="diez">&nbsp;</td>
				<td class="labelRight veinte grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:&nbsp;</td>
				<td class="veinte datosLeft">
					<select name="LIC_IDPROVEEDOR" id="LIC_IDPROVEEDOR" onChange="usuariosProveedor(this.value);" style="width:600px;">
						<option value=""><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciona']/node()"/></option>
						<xsl:for-each select="/Mantenimiento/LICITACION/PROVEEDORES/PROVEEDOR">
							<xsl:if test="substring(ID,1,4)!='SEL_'">
								<option value="{ID}"><xsl:value-of select="NOMBRE"/></option>
							</xsl:if >
						</xsl:for-each>
					</select>
				</td>
				<td>&nbsp;</td>
			</tr>

			<tr class="sinLinea" id="filaUsuarioProveedor" style="display:none;">
				<td>&nbsp;</td>
				<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:&nbsp;</td>
				<td class="datosLeft">
					<select name="LIC_IDUSUARIOPROVEEDOR" id="LIC_IDUSUARIOPROVEEDOR"/>
				</td>
				<td>&nbsp;</td>
			</tr>

			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='bloquear_avisos_email']/node()"/>:&nbsp;</td>
				<td class="datosLeft">
					<input type="checkbox" class="muypeq" name="BLOQUEARAVISOS" id="BLOQUEARAVISOS" value="S"/>
				</td>
				<td>&nbsp;</td>
			</tr>

			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado_evaluacion']/node()"/>:&nbsp;</td>
				<td class="datosLeft">
					<select name="LIC_IDESTADOEVALUACION" id="LIC_IDESTADOEVALUACION">
						<xsl:for-each select="/Mantenimiento/LICITACION/ESTADOSEVALUACION/field/dropDownList/listElem">
							<option value="{ID}">
								<xsl:if test="ID = 'APTOHIST'">
									<xsl:attribute name="selected">selected</xsl:attribute>
								</xsl:if>
								<xsl:value-of select="listItem"/>
							</option>
						</xsl:for-each>
					</select>
				</td>
				<td>&nbsp;</td>
			</tr>

			<tr class="sinLinea">
				<td>&nbsp;</td>
				<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/>:&nbsp;</td>
				<td class="datosLeft">
					<textarea name="LIC_COMENTARIOS" rows="4" cols="100"/>
				</td>
				<td>&nbsp;</td>
			</tr>

			<tr class="sinLinea"><td colspan="4">&nbsp;</td></tr>
			<tr class="sinLinea">
				<td colspan="2">&nbsp;</td>
				<td>
					<!--<div class="boton">-->
						<a class="btnDestacado" id="btnAnadirProveedores" href="javascript:ValidarFormulario(document.forms['Proveedores'],'proveedores');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir']/node()"/>
						</a>
					<!--</div>-->
				</td>
				<td>
				&nbsp;
					<!--	27feb19	Borrar proveedores-->
					<xsl:if test="(/Mantenimiento/LICITACION/LIC_IDESTADO = 'EST') or (/Mantenimiento/LICITACION/LIC_IDESTADO = 'COMP')">
						<a class="btnDestacado" id="botonBorrarProveedores" href="javascript:BorrarTodosProveedores();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_proveedores']/node()"/>
						</a>&nbsp;
					</xsl:if>
				</td>
			</tr>
		</table>
		</div>
	</form>
	</xsl:if>

	<xsl:if test="/Mantenimiento/LICITACION/LIC_IDESTADO != 'EST'">
	<div class="divLeft" style="margin-top:30px;">
		<table class="infoTable">
		<tfoot>
			<tr class="lejenda lineBorderBottom3" style="background:#E4E4E5;font-weight:bold;">
				<td colspan="5" class="datosLeft" style="padding:3px 0px 0px 20px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda']/node()"/>:</td>
			</tr>
			<tr class="lineBorderBottom5">
				<td class="trenta datosLeft">
					<p style="line-height:20px;">
						&nbsp;&nbsp;&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/edit.png" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='abrir_comentarios']/node()"/><br/>
						&nbsp;&nbsp;&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/2017/print.png" border="0"/>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='abrir_pagina_imprimir']/node()"/><br/>
						&nbsp;&nbsp;&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/2017/reload.png" border="0"/>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitar_nueva_oferta']/node()"/><br/>
						&nbsp;&nbsp;&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/rollbackVerde.gif" border="0"/>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='activar_proveedor']/node()"/><br/>
					</p>
				</td>
				<td class="trenta datosLeft">
					<p style="line-height:20px;">
						&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/suspender.gif" border="0"/>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='suspender_oferta']/node()"/><br/>
						&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/change.png" border="0"/>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='productos_sin_ofertas']/node()"/><br/>
						&nbsp;<img src="http://www.newco.dev.br/images/2017/message.png" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='crear_conversacion']/node()"/><br/>
						&nbsp;<img src="http://www.newco.dev.br/images/2017/mail-blue.png" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='abrir_conversacion']/node()"/><br/>
					</p>
				</td>
				<td class="veinte datosLeft">
					<p style="line-height:25px;">
						&nbsp;<img src="http://www.newco.dev.br/images/bolaVerde.gif" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ev_apto']/node()"/><br/>
						&nbsp;<img src="http://www.newco.dev.br/images/bolaAmbar.gif" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ev_pendiente']/node()"/><br/>
						&nbsp;<img src="http://www.newco.dev.br/images/bolaRoja.gif" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ev_no_apto']/node()"/><br/>
					</p>
				</td>
				<td class="veinte datosLeft">
					<p>
						&nbsp;<span style="background-color:#A8FFA8;height:3px;width:5px;">&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor_adjudicado']/node()"/><br/>
						&nbsp;<span style="background-color:orange;height:3px;width:5px;">&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro_nulo']/node()"/><br/>
						&nbsp;<span style="background-color:red;height:3px;width:5px;">&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro_negativo']/node()"/><br/>
						&nbsp;<span style="background-color:green;height:3px;width:5px;">&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro_positivo']/node()"/>
					</p>
				</td>
				<td>&nbsp;</td>
			</tr>
		</tfoot>
		</table>
		<br /><br />
	</div>

	<!-- DIV Conversacion Proveedor -->
	<div class="overlay-container" id="convProveedor">
		<div class="window-container zoomout">
			<p><a class="btnNormal" href="javascript:showTabla(false);"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a></p>

			<p id="tableTitle">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='conversacion_con']/node()"/>&nbsp;<span id="NombreProv"></span>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='para']/node()"/>&nbsp;"<xsl:value-of select="/Mantenimiento/LICITACION/LIC_TITULO"/>"

				&nbsp;<a href="javascript:window.print();" style="text-decoration:none;">
					<img src="http://www.newco.dev.br/images/imprimir.gif">
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></xsl:attribute>
					</img>
				</a>
			</p>

			<div id="mensError" class="divLeft" style="display:none;">
				<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></strong></p>
			</div>

			<table id="viejosComentarios" border="0" style="width:100%;display:none;">
			<thead>
				<th colspan="5">&nbsp;</th>
			</thead>

			<tbody></tbody>

			</table>

			<form name="convProveedorForm" method="post" id="convProveedorForm">
			<input type="hidden" name="IDPROVEEDOR" id="IDPROVEEDOR"/>
			<input type="hidden" name="IDUSUARIOCLIENTE" id="IDUSUARIOCLIENTE"/>
			<input type="hidden" name="IDUSUARIOPROV" id="IDUSUARIOPROV"/>

			<table id="nuevoComentario" style="width:100%;display:none;">
			<thead>
				<th colspan="3">&nbsp;</th>
			</thead>

			<tbody>
				<tr>
					<td class="dies"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='comentario']/node()"/>:</strong></td>
					<td colspan="2"><textarea name="LIC_MENSAJE" id="LIC_MENSAJE" rows="4" cols="70" style="float:left;"/></td>
				</tr>
			</tbody>

			<tfoot>
				<tr>
					<td>&nbsp;</td>
					<td>
						<br/>
						<!--<div class="boton">-->
							<a id="btnGuardarConv" class="btnDestacado" href="javascript:guardarConversProv();">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
							</a>
						<!--</div>-->
					</td>
					<td id="Respuesta" style="text-align:left;"></td>
				</tr>
			</tfoot>
			</table>
			</form>
		</div>
	</div>
	<!-- FIN DIV Conversacion Proveedor -->
	</xsl:if><!-- no estado EST	-->

	<!--<xsl:if test="/Mantenimiento/LICITACION/AUTOR">"-->
	<!-- DIV  Cambio usuario proveedor -->
	<div class="overlay-container" id="cambioUsuProv">
		<div class="window-container zoomout">
			<p><a href="javascript:showTabla(false);"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a></p>

			<p id="tableTitle">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='cambiar_usuario']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;<span id="NombreProv"></span>
			</p>

			<div id="mensError" class="divLeft" style="display:none;">
				<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></strong></p>
			</div>

			<form name="nuevoUsuProvForm" method="post" id="nuevoUsuProvForm">
			<input type="hidden" name="posArray" id="posArray"/>

			<table id="nuevoUsuProv" style="width:100%;">
			<thead>
				<th colspan="3">&nbsp;</th>
			</thead>

			<tbody>
				<tr style="height:50px;">
					<td class="quince"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:</strong></td>
					<td colspan="2"><select name="IDUSUARIOPROV_NUEVO" id="IDUSUARIOPROV_NUEVO" style="float:left;"/></td>
				</tr>
			</tbody>

			<tfoot>
				<tr>
					<td>&nbsp;</td>
					<td>
						<!--<div class="boton" id="BotonNuevoUsu">-->
							<a class="btnDestacado" id="BotonNuevoUsu" href="javascript:guardarNuevoUsuProv();">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
							</a>
						<!--</div>-->
					</td>
					<td id="Respuesta" style="text-align:left;"></td>
				</tr>
			</tfoot>
			</table>
			</form>
		</div>
	</div>
	<!-- FIN DIV Cambio usuario proveedor -->
	<!--</xsl:if>-->

</div>
</xsl:template><!-- FIN Tabla Proveedores Antes de Adjudicar -->

<!-- Tabla Proveedores Despues de Adjudicar -->
<xsl:template name="Tabla_Proveedores_Adjudicado">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:value-of select="/Mantenimiento/LANG"/>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<div id="lProveedores" class="posContenedorLic" style="display:none;"> <!--style="border:1px solid black">-->
	<!--<table class="divLeft infoTable" id="lProveedores_ADJ" style="border:1px solid black">-->
	<table class="buscador" id="lProveedores_ADJ" style="border:1px solid black">
		<!--"border:1px solid black">-->
	<thead>
		<tr class="subTituloTabla">
			<td class="uno" style="border-bottom:1px solid #999999;" border="1">&nbsp;</td>
			<td class="zerouno">&nbsp;</td>
			<td class="quince" style="text-align:left;">
				<!-- Permitimos ordenacion -->
				&nbsp;<a href="javascript:OrdenarProvsPorColumna('NombreCorto');" style="text-decoration:none;" id="anchorNombreProv">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>
				</a>
            </td>
			<td class="dies" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></td>
			<!-- conversaciones -->
			<td class="dos">&nbsp;</td>
			<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_oferta']/node()"/></td>
			<td class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion_abr']/node()"/></td>
			<td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='estado_oferta']/node()"/></td>
			<!--
			<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios_cdc']/node()"/></td>
			<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios_prov']/node()"/></td>
			-->
		<xsl:choose>
		<xsl:when test="not(/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA)">
			<td class="siete" style="text-align:right;">
				<!-- Permitimos ordenacion -->
				<a href="javascript:OrdenarProvsPorColumna('ConsumoProv');" style="text-decoration:none;" id="anchorConsumoProv">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_sIVA']/node()"/>&nbsp;
				</a>
                        </td>
			<td class="siete" style="text-align:right;">
				<!-- Permitimos ordenacion -->
				<a href="javascript:OrdenarProvsPorColumna('ConsumoAdj');" style="text-decoration:none;" id="anchorConsumoAdjProv">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='adjudicado_sIVA']/node()"/>&nbsp;
				</a>
                        </td>
		</xsl:when>
		<xsl:otherwise>
			<td class="siete" style="text-align:right;">
				<!-- Permitimos ordenacion -->
				<a href="javascript:OrdenarProvsPorColumna('ConsumoProvIVA');" style="text-decoration:none;" id="anchorConsumoIVAProv">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_cIVA_2line']/node()"/>&nbsp;
				</a>
                        </td>
			<td class="siete" style="text-align:right;">
				<!-- Permitimos ordenacion -->
				<a href="javascript:OrdenarProvsPorColumna('ConsumoAdjIVA');" style="text-decoration:none;" id="anchorConsumoAdjIVAProv">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='adjudicado_cIVA_2line']/node()"/>&nbsp;
				</a>
                        </td>
		</xsl:otherwise>
		</xsl:choose>
			<td class="cinco">
				<!-- Permitimos ordenacion -->
				<a href="javascript:OrdenarProvsPorColumna('Ahorro');" style="text-decoration:none;" id="anchorAhorroProv">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='porcentaje_ahorro']/node()"/>
				</a>
                        </td>
			<td class="cinco">
				<!-- Permitimos ordenacion -->
				<a href="javascript:OrdenarProvsPorColumna('PedidoMin');" style="text-decoration:none;" id="anchorPedMinProv">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='pedido_minimo_sIVA_2line']/node()"/>
				</a>
                        </td>
			<td class="cinco">
				<!-- Permitimos ordenacion -->
				<a href="javascript:OrdenarProvsPorColumna('NumeroLineas');" style="text-decoration:none;" id="anchorNumOfertasProv">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='num_prod']/node()"/>
				</a>
                        </td>
			<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='acciones']/node()"/></td>
		</tr>
	</thead>

	<!-- Aqui dentro se informara el cuerpo de la tabla via javascript -->
	<tbody></tbody>

	</table>

	<div class="divLeft" style="margin-top:30px;">
		<table class="infoTable">
		<tfoot>
			<tr class="lejenda lineBorderBottom3" style="background:#E4E4E5;font-weight:bold;">
				<td colspan="5" class="datosLeft" style="padding:3px 0px 0px 20px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda']/node()"/>:</td>
			</tr>
			<tr class="lineBorderBottom5">
				<td class="trenta datosLeft">
					<p style="line-height:20px;">
						<!--
						&nbsp;&nbsp;&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/edit.png" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='abrir_comentarios']/node()"/><br/>
						&nbsp;&nbsp;&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/imprimir.gif" border="0"/>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='abrir_pagina_imprimir']/node()"/><br/>
						&nbsp;&nbsp;&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/2017/reload.png" border="0"/>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitar_nueva_oferta']/node()"/><br/>
						&nbsp;&nbsp;&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/rollbackVerde.gif" border="0"/>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='activar_proveedor']/node()"/><br/>
						-->
						&nbsp;&nbsp;&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/edit.png" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='abrir_comentarios']/node()"/><br/>
						&nbsp;&nbsp;&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/2017/print.png" border="0"/>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='abrir_pagina_imprimir']/node()"/><br/>
						&nbsp;&nbsp;&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/2017/reload.png" border="0"/>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitar_nueva_oferta']/node()"/><br/>
						&nbsp;&nbsp;&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/rollbackVerde.gif" border="0"/>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='activar_proveedor']/node()"/><br/>
					</p>
				</td>
				<td class="trenta datosLeft">
					<p style="line-height:20px;">
						&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/suspender.gif" border="0"/>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='suspender_oferta']/node()"/><br/>
						&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/change.png" border="0"/>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='productos_sin_ofertas']/node()"/><br/>
						<!--
						&nbsp;<img src="http://www.newco.dev.br/images/bocadilloPlus.gif" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='crear_conversacion']/node()"/><br/>
						&nbsp;<img src="http://www.newco.dev.br/images/bocadillo.gif" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='abrir_conversacion']/node()"/><br/>
						-->
						&nbsp;<img src="http://www.newco.dev.br/images/2017/message.png" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='crear_conversacion']/node()"/><br/>
						&nbsp;<img src="http://www.newco.dev.br/images/2017/mail-blue.png" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='abrir_conversacion']/node()"/><br/>
					</p>
				</td>
				<td class="veinte datosLeft">
					<p style="line-height:25px;">
						&nbsp;<img src="http://www.newco.dev.br/images/bolaVerde.gif" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ev_apto']/node()"/><br/>
						&nbsp;<img src="http://www.newco.dev.br/images/bolaAmbar.gif" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ev_pendiente']/node()"/><br/>
						&nbsp;<img src="http://www.newco.dev.br/images/bolaRoja.gif" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ev_no_apto']/node()"/><br/>
					</p>
				</td>
				<td class="veinte datosLeft">
					<p>
						&nbsp;<span style="background-color:#A8FFA8;height:3px;width:5px;">&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor_adjudicado']/node()"/><br/>
						&nbsp;<span style="background-color:orange;height:3px;width:5px;">&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro_nulo']/node()"/><br/>
						&nbsp;<span style="background-color:red;height:3px;width:5px;">&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro_negativo']/node()"/><br/>
						&nbsp;<span style="background-color:green;height:3px;width:5px;">&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro_positivo']/node()"/>
					</p>
				</td>
				<td>&nbsp;</td>
			</tr>
		</tfoot>
		</table>
		<br /><br />
	</div>


	<!-- DIV Conversacion Proveedor -->
	<div class="overlay-container" id="convProveedor">
		<div class="window-container zoomout">
			<p><a href="javascript:showTabla(false);"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a></p>

			<p id="tableTitle">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='conversacion_con']/node()"/>&nbsp;<span id="NombreProv"></span>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='para']/node()"/>&nbsp;"<xsl:value-of select="/Mantenimiento/LICITACION/LIC_TITULO"/>"

				&nbsp;<a href="javascript:window.print();" style="text-decoration:none;">
					<img src="http://www.newco.dev.br/images/imprimir.gif">
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></xsl:attribute>
					</img>
				</a>
			</p>

			<div id="mensError" class="divLeft" style="display:none;">
				<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></strong></p>
			</div>

			<table id="viejosComentarios" border="0" style="width:100%;display:none;">
			<thead>
				<th colspan="5">&nbsp;</th>
			</thead>

			<tbody></tbody>

			</table>

			<form name="convProveedorForm" method="post" id="convProveedorForm">
			<input type="hidden" name="IDPROVEEDOR" id="IDPROVEEDOR"/>
			<input type="hidden" name="IDUSUARIOCLIENTE" id="IDUSUARIOCLIENTE"/>
			<input type="hidden" name="IDUSUARIOPROV" id="IDUSUARIOPROV"/>

			<table id="nuevoComentario" style="width:100%;display:none;">
			<thead>
				<th colspan="3">&nbsp;</th>
			</thead>

			<tbody>
				<tr>
					<td class="dies"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='comentario']/node()"/>:</strong></td>
					<td colspan="2"><textarea name="LIC_MENSAJE" id="LIC_MENSAJE" rows="4" cols="70" style="float:left;"/></td>
				</tr>
			</tbody>

			<tfoot>
				<tr>
					<td>&nbsp;</td>
					<td>
						<div class="boton">
							<a href="javascript:guardarConversProv();">
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
	<!-- FIN DIV Conversacion Proveedor -->


	<!-- DIV Subir Contrato -->
	<xsl:if test="/Mantenimiento/LICITACION/AUTOR">
	<div class="overlay-container" id="subirContrato">
		<div class="window-container zoomout">
			<p><a href="javascript:showTabla(false);"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a></p>

			<p id="tableTitle">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_contrato']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;<span id="NombreProv"></span>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='para']/node()"/>&nbsp;<br />
				"<xsl:value-of select="/Mantenimiento/LICITACION/LIC_TITULO"/>"
			</p>



			<form name="SubirContratoForm" method="post" id="SubirContratoForm">
			<input type="hidden" name="CADENA_DOCUMENTOS"/>
			<table style="width:100%;">
			<thead>
				<th colspan="3">&nbsp;</th>
			</thead>

			<tbody>

				<tr style="height:80px;">
					<td class="veinte"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='contrato']/node()"/>:</strong></td>
					<td class="">
						<input type="file" name="inputFileDoc" id="inputFileDoc_SC" onchange="cargaDoc(document.forms['SubirContratoForm'], '{/Mantenimiento/LICITACION/MARCADOCUMENTO}', 'SC');" style="float:left;"/>
						<span id="DocCargado" style="float:left;display:none;">
							<span id="NombreDoc"></span>&nbsp;
<!--
							<a href="javascript:borrarDoc('{/Mantenimiento/LICITACION/MARCADOCUMENTO}');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>
-->
						</span>
						<input type="hidden" name="IDDOC" id="IDDOC"/>
						<input type="hidden" name="UrlDoc" id="UrlDoc"/>
					</td>
					<td class="trenta">
						<div id="waitBoxDoc_SC" align="center">&nbsp;</div>
						<div id="confirmBox_SC" style="display:none;" align="center">
							<span class="cargado" style="font-size:10px;">¡<xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/>!</span>
						</div>
					</td>
				</tr>

			</tbody>

			<tfoot>
				<tr>
					<td>&nbsp;</td>
					<td colspan="2">
						<input type="hidden" name="posArray" id="posArray"/>
						<div class="boton">
							<a href="javascript:guardarContrato();">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
							</a>
						</div>
					</td>
				</tr>
			</tfoot>
			</table>
			</form>
		</div>
	</div>
	</xsl:if>
	<!-- FIN DIV Subir Contrato -->

</div>
</xsl:template>
<!-- FIN Tabla Proveedores Despues de Adjudicar -->

</xsl:stylesheet>
