<?xml version="1.0" encoding="iso-8859-1"?>
<!-- 
	Template para la pestaña de productos de la licitación
	Ultima revisión ET 17nov21 11:00
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>

<!-- Tabla Productos Ofertas Cliente -->
<xsl:template name="Tabla_Productos_Ofertas_Cliente">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:value-of select="/Mantenimiento/LANG"/>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<div id="lProductos" class="posContenedorLic" style="display:none;">
	<form id="ActualizarProductos" name="ActualizarProductos" method="POST">
	<!-- div superior para paginacion y otros -->
	<div id="topPesProds">
		<!-- Link a pagina anterior -->
		<div id="pagAnterior" style="float:left;width:110px;text-align:left;padding-left:20px;line-height:30px;background:#F0F0F0;">&nbsp;</div>
		<!-- Desplegable para numProductos en pagina, leyenda paginacion y desplegable tipo vista -->
		<div id="pagTamanyo" style="float:left;width:800px;text-align:left;padding-left:20px;font-size:11px;line-height:30px;background:#F0F0F0;">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='tamanyo_pagina']/node()"/>:&nbsp;
			<select name="numRegistros" id="numRegistros" style="font-size:11px;">
				<option value="10">10 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
				<option value="20">20 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
				<option value="50">50 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
				<option value="100" selected="selected">100 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option><!--21may20 Por defecto, 100	-->
				<option value="200">200 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
				<option value="500">500 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
				<option value="1000">1000 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
				<option value="2000">2000 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
			</select>
			<!-- Leyenda paginacion -->
			<span id="paginacion" style="margin-left:20px;"></span>
			<!-- 19set16 Desactivamos esta funcionalidad, no se ha actualizado con los avances de la licitacion	
				Link a pagina para importar la tabla productos a excel 
			<span id="prodsAExcel">
				&nbsp;&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/ProductosParaExcel.xsql?LIC_ID={/Mantenimiento/LIC_ID}','Catálogo Privado',100,80,0,-20);" style="text-decoration:none;">
					<img src="http://www.newco.dev.br/images/tabla.gif" width="20" />
				</a>
			</span>
			-->
			<!-- Desplegable para seleccionar el tipo de vista -->
			<span id="vistaTabla" style="margin-left:20px;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_de_vista']/node()"/>:&nbsp;
			<select name="tipoVista" id="tipoVista" style="font-size:11px;">
				<option value="SP" selected="selected"><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_precio']/node()"/></option>
				<option value="SC"><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_consumo']/node()"/></option>
				<option value="SA"><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_ahorro']/node()"/></option>
				<option value="PC"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_y_consumo']/node()"/></option>
				<option value="PCA"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_consumo_y_ahorro']/node()"/></option>
				<option value="PCAE"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_consumo_y_mas']/node()"/></option>
				<option value="PIC"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_e_info_compl']/node()"/></option>
			</select>
			</span>

		</div>
		<!-- Link a pagina siguiente -->
		<div id="pagSiguiente" style="float:left;width:80px;text-align:right;padding-right:20px;line-height:30px;background:#F0F0F0;">&nbsp;</div>
	</div>

	<!--	16nov16	Incluimos los botones de ayuda en la parte superior de la tabla de productos, excepto el boton adjudicar que ira en la cabecera
	<xsl:if test="/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_PORPRODUCTO = 'S' and (/Mantenimiento/LICITACION/LIC_IDESTADO = 'INF' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'CURS')">
	<div>
			<a class="btnDestacado" id="botonAdjudicarSelec" href="javascript:AdjudicarOfertas();">
				<xsl:if test="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PRODUCTOS_OLVIDADOS">
					<xsl:attribute name="class">grey</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicar']/node()"/>
			</a>
	</div>
	</xsl:if>
	-->
	<xsl:if test="/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_PORPRODUCTO = 'S' and (/Mantenimiento/LICITACION/LIC_IDESTADO = 'INF' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'CURS')">
		<span class="CompletarTitulo" style="width:480px;">
		<xsl:if test="/Mantenimiento/LICITACION/LIC_IDESTADO != 'CONT'">
			<a class="btnDestacado" id="botonActualizar2" href="javascript:ValidarFormulario(document.forms['ActualizarProductos'],'actualizarProductos', 1);">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar_datos']/node()"/>
			</a>&nbsp;
		</xsl:if>
		<xsl:if test="/Mantenimiento/LICITACION/LIC_MULTIOPCION!='S'">
			<a class="btnDestacado" id="botonSelecMejPrecios" href="javascript:SeleccionarMejoresPrecios();">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='seleccionar_mejores_precios']/node()"/>
			</a>&nbsp;
			<a class="btnDestacado" id="botonGuardarSelec" href="javascript:GuardarSeleccion();"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_seleccion']/node()"/></a>
		</xsl:if>
		</span>
	</xsl:if>

	<!--<table class="divLeft infoTable" id="lProductos_OFE" style="border-bottom:1px solid #999999;" border="0">-->
	<table class="buscador" id="lProductos_OFE" width="100%">
	<thead>
		<tr class="subTituloTabla">
			<!-- Info Productos por parte del Cliente -->
			<td rowspan="2" class="borderLeft">
			<xsl:if test="/Mantenimiento/LICITACION/LIC_IDESTADO = 'CURS' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'INF'">
				<!-- Permitimos ordenacion por productos no informados-->
				<a href="javascript:ordenacionInformado('OFE');" style="text-decoration:none;" id="anchorInformOFE">
					<img src="http://www.newco.dev.br/images/atencion.gif">
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='ordenar_por_productos_sin_seleccion']/node()"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='ordenar_por_productos_sin_seleccion']/node()"/></xsl:attribute>
					</img>
				</a>
			</xsl:if>
				<span style="width:30px;height:1px;float:left;">&nbsp;</span>
			</td>
			<td rowspan="2" class="borderLeft">
				<!-- Permitimos ordenacion -->
				<a href="javascript:OrdenarProdsPorColumna('RefCliente');" style="text-decoration:none;" id="anchorRefCliente">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>
				</a>
				<span style="width:90px;height:1px;float:left;">&nbsp;</span>
			</td>
			<td rowspan="2" class="borderLeft" style="text-align:left;">
				<!-- Permitimos ordenacion -->
				&nbsp;<a href="javascript:OrdenarProdsPorColumna('NombreNorm');" style="text-decoration:none;margin-top:1px;" id="anchorNombre">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>
				</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="text" name="filtroProductos" id="filtroProductos" style="font-size:11px;width:100px;"/>&nbsp;
				<a href="javascript:filtrarProductosBeforeAjax();" style="font-size:11px;text-decoration:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/></a>
				<span style="width:250px;height:1px;float:left;">&nbsp;</span>
			</td>
			<td rowspan="2" class="uno">&nbsp;</td><!-- iconos para los campos avanzados -->
			<td rowspan="2" class="borderLeft">
				<!-- Permitimos ordenacion -->
				<a href="javascript:OrdenarProdsPorColumna('NumOfertas');" style="text-decoration:none;" id="anchorNumOfertas">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='num_ofertas']/node()"/>
				</a>
				<span style="width:30px;height:1px;float:left;">&nbsp;</span>
			</td>
			<td rowspan="2" class="borderLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica_abr']/node()"/>&nbsp;</td>

			<td rowspan="2" class="borderLeft">
			<xsl:choose>
			<xsl:when test="not(/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA)">
				&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_historico_sIVA_abr_2line']/node()"/>&nbsp;
			</xsl:when>
			<xsl:otherwise>
				&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_historico_cIVA_abr_2line']/node()"/>&nbsp;
			</xsl:otherwise>
			</xsl:choose>
			</td>

			<td rowspan="2" class="borderLeft">
			<xsl:choose>
			<xsl:when test="not(/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA)">
				&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_objetivo_sIVA_abr_2line']/node()"/>&nbsp;
			</xsl:when>
			<xsl:otherwise>
				&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_objetivo_cIVA_abr_2line']/node()"/>&nbsp;
			</xsl:otherwise>
			</xsl:choose>

			<!-- DC - 07may15 - Calculo automatico de precios objetivo tambien para estado 'En Curso' -->
			<xsl:if test="/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_IDESTADO = 'CURS'">
				<a href="javascript:formPreciosObj();"><img src="http://www.newco.dev.br/images/calcula.gif"/></a>
			</xsl:if>

			</td>

			<td rowspan="2" class="borderLeft">
				<!-- Permitimos ordenacion -->
				&nbsp;<a href="javascript:OrdenarProdsPorColumna('AhorroMax');" style="text-decoration:none;" id="anchorAhorro">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/>
				</a>&nbsp;
				<span style="width:70px;height:1px;float:left;">&nbsp;</span>
			</td>
<!--
		<xsl:choose>
		<xsl:when test="not(/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA)">
			<td rowspan="2" class="borderLeft">&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_historico_sIVA_abr_2line']/node()"/>&nbsp;</td>
			<td rowspan="2" class="borderLeft">&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_objetivo_sIVA_abr_2line']/node()"/>&nbsp;</td>
		</xsl:when>
		<xsl:otherwise>
			<td rowspan="2" class="borderLeft">&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_historico_cIVA_abr_2line']/node()"/>&nbsp;</td>
			<td rowspan="2" class="borderLeft">&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_objetivo_cIVA_abr_2line']/node()"/>&nbsp;</td>
		</xsl:otherwise>
		</xsl:choose>
-->
			<td rowspan="2" class="borderLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/>&nbsp;</td>

		<xsl:choose>
		<xsl:when test="not(/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA)">
			<td rowspan="2" class="borderLeft">
				<!-- Permitimos ordenacion -->
				<a href="javascript:OrdenarProdsPorColumna('ConsumoHist');" style="text-decoration:none;" id="anchorConsumo">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_sIVA_2line']/node()"/>
				</a>
                        </td>
		</xsl:when>
		<xsl:otherwise>
			<td rowspan="2" class="borderLeft">
				<!-- Permitimos ordenacion -->
				<a href="javascript:OrdenarProdsPorColumna('ConsumoHistIVA');" style="text-decoration:none;" id="anchorConsumoIVA">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_cIVA_2line']/node()"/>
				</a>
                        </td>
		</xsl:otherwise>
		</xsl:choose>

		<xsl:choose>
		<xsl:when test="/Mantenimiento/LICITACION/IDPAIS != '55'">
			<td rowspan="2" class="borderleft">
                <xsl:attribute name="class"><xsl:if test="/Mantenimiento/LICITACION/IDPAIS != '55'">borderleft</xsl:if></xsl:attribute>
                &nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='iva']/node()"/>&nbsp;
            </td>
		</xsl:when>
		<xsl:otherwise>
			<td rowspan="2" class="borderleft">&nbsp;</td>
		</xsl:otherwise>
		</xsl:choose>
			<!-- FIN Info Productos por parte del Cliente -->

		<!-- Nombres de Proveedores -->
		<xsl:for-each select="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PROVEEDORESLICITACION/PROVEEDOR">
			<xsl:if test="TIENE_OFERTAS">	<!--	9set16	solo proveedores con ofertas		-->
				<td class="colNomProv" colspan="4" style="min-width:120px;text-align:center; border-left:1px solid #999999;">
				<xsl:choose>
				<xsl:when test="/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_PORPRODUCTO = 'S' and (/Mantenimiento/LICITACION/LIC_IDESTADO = 'CURS' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'INF')">
					<a href="javascript:seleccionarPreciosProveedor({COLUMNA});" style="text-decoration:none;">
						<xsl:value-of select="NOMBRECORTO"/>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="NOMBRECORTO"/>
				</xsl:otherwise>
				</xsl:choose>
					&nbsp;<span id="avisoProv_{COLUMNA}" style="display:none;">
						<img src="http://www.newco.dev.br/images/atencion.gif" style="vertical-align:text-bottom;">
							<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor_no_cumple_ped_minimo']/node()"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor_no_cumple_ped_minimo']/node()"/></xsl:attribute>
                    	</img>
					</span>
					<input type="hidden" class="PedidoMin" name="PedMin_{IDPROVEEDOR_LIC}" id="PedMin_{IDPROVEEDOR_LIC}" value="{LIC_PROV_PEDIDOMINIMO}"/>
					<input type="hidden" class="ProvNombre" name="ProvNom_{IDPROVEEDOR_LIC}" id="ProvNom_{IDPROVEEDOR_LIC}" value="{NOMBRECORTO}"/>

				</td>
			</xsl:if>
		</xsl:for-each>
		</tr>

		<tr class="subTituloTabla">
		<!-- Info Ofertas por parte del Proveedor -->
		<xsl:for-each select="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PROVEEDORESLICITACION/PROVEEDOR">
			<xsl:if test="TIENE_OFERTAS">	<!--	9set16	solo proveedores con ofertas		-->
				<!-- Columna para el radio button de la selección de oferta -->
				<td class="zerouno" style="border-left:1px solid #999999;">&nbsp;</td>
				<xsl:choose>
				<xsl:when test="not(/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA)">
					<!-- Columna para el precio S/IVA -->
					<td class="colPrecio">
						<a href="javascript:OrdenarProdsPorColumna('PrecioProv_{COLUMNA}');" style="text-decoration:none;">
							<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_2line']/node()"/>
						</a>&nbsp;
					</td>
					<!-- Columna para el consumo S/IVA -->
					<td class="colConsumo borderLeft">
						<a href="javascript:OrdenarProdsPorColumna('ConsProv_{COLUMNA}');" style="text-decoration:none;">
							<xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_sIVA_2line']/node()"/>
                                		</a>&nbsp;
					</td>
				</xsl:when>
				<xsl:otherwise>
					<!-- Columna para el precio C/IVA -->
					<td class="colPrecio">
						<a href="javascript:OrdenarProdsPorColumna('PrecioProvIVA_{COLUMNA}');" style="text-decoration:none;">
							<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_cIVA_2line']/node()"/>
						</a>&nbsp;
					</td>
					<!-- Columna para el consumo C/IVA -->
					<td class="colConsumo borderLeft">
						<a href="javascript:OrdenarProdsPorColumna('ConsProvIVA_{COLUMNA}');" style="text-decoration:none;">
							<xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_cIVA_2line']/node()"/>
						</a>&nbsp;
					</td>
				</xsl:otherwise>
				</xsl:choose>

				<!-- Columna para el ahorro -->
				<td class="colAhorro borderLeft">
					<a href="javascript:OrdenarProdsPorColumna('AhorProv_{COLUMNA}');" style="text-decoration:none;">
						<xsl:copy-of select="document($doc)/translation/texts/item[@name='porcentaje_ahorro']/node()"/>
					</a>&nbsp;
				</td>
				<!-- Columna para la imagen de la evaluaciond e la oferta -->
				<td class="colEval" style="display:none;"><xsl:copy-of select="document($doc)/translation/texts/item[@name='evaluacion_abr']/node()"/></td>
				<!-- Columna para la imagen si existe ficha tecnica y imagenes si existen campos avanzados -->
				<td class="colInfo" style="display:none;">&nbsp;</td>
			</xsl:if>
		</xsl:for-each>
		<!-- FIN Info Ofertas por parte del Proveedor -->
		</tr>
	</thead>

	<!-- Aqui dentro se informara el cuerpo de la tabla via javascript -->
	<tbody></tbody>

	</table>

	<!-- div superior para paginacion y otros 
	<div id="botPesProds">
		<!- - Link a pagina anterior - ->
		<div id="pagAnterior" style="float:left;width:110px;text-align:left;padding-left:20px;line-height:30px;">&nbsp;</div>
		<!- - Desplegable para numProductos en pagina, leyenda paginacion y desplegable tipo vista - ->
		<div id="pagTamanyo" style="float:left;width:800px;text-align:left;padding-left:20px;font-size:11px;line-height:30px;">
			&nbsp;
		</div>
		<!- - Link a pagina siguiente - ->
		<div id="pagSiguiente" style="float:left;width:80px;text-align:right;padding-right:20px;line-height:30px;">&nbsp;</div>
	</div>
	-->
	<xsl:if test="/Mantenimiento/LICITACION/AUTOR"><!-- 1set16	No para licitaciones agregadas	-->
		<!--<div id="botonActualizar" class="boton botonAccion">
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/LIC_IDESTADO = 'CONT'">
				<xsl:attribute name="style">margin:10px 0 0 400px;display:none;</xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="style">margin:10px 0 0 400px;</xsl:attribute>
			</xsl:otherwise>
			</xsl:choose>

			<a href="javascript:ValidarFormulario(document.forms['ActualizarProductos'],'actualizarProductos', 1);">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar_datos']/node()"/>
			</a>
		</div>-->
		<div style="margin-top: 20px;"><!--Boton actualizar bajo la tabla	-->
			<a class="btnDestacado" id="botonActualizar" href="javascript:ValidarFormulario(document.forms['ActualizarProductos'],'actualizarProductos', 1);">
				<xsl:attribute name="style">
				<xsl:choose>
				<xsl:when test="/Mantenimiento/LICITACION/LIC_IDESTADO = 'CONT'">
					margin:10px 0 0 200px;display:none;
				</xsl:when>
				<xsl:otherwise>
					margin:10px 0 0 200px;
				</xsl:otherwise>
				</xsl:choose>
				</xsl:attribute>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar_datos']/node()"/>
			</a>&nbsp;
			<xsl:if test="(/Mantenimiento/LICITACION/LIC_IDESTADO = 'EST') or (/Mantenimiento/LICITACION/LIC_IDESTADO = 'COMP')">
				<a class="btnDestacado" id="botonBorrarProductos" href="javascript:BorrarTodosProductos();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_productos']/node()"/>
				</a>&nbsp;
			</xsl:if>
		</div>
		
	</xsl:if>

   </form>


<!-- DIV Flotante -->
<xsl:if test="/Mantenimiento/LICITACION/LIC_PORPRODUCTO = 'S'">
	<div class="FBox" id="floatingBox" style="display:none;clear:both;margin-top:5px;">
		<table id="TableFB" class="TablaFBox" >
		<thead>
			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_potencial']/node()"/></th>
			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_previsto']/node()"/></th>
			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/></th>
			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='num_ofertas']/node()"/></th>
			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedores_abbr']/node()"/></th>
			<th>&nbsp;</th>
		</thead>
		<tbody>
			<tr><td id="FBConsPot"></td><td id="FBConsPrev"></td><td id="FBAhorro"></td><td id="FBNumOfertas"></td><td id="FBProvs"></td><td id="FBAviso"></td></tr>
		</tbody>
		</table>
	</div>
</xsl:if>
<!-- FIN DIV Flotante-->

<xsl:if test="/Mantenimiento/LICITACION/AUTOR">
	<!-- DIV CamposAvanzados -->
	<div class="overlay-container" id="camposAvanzados">
		<div class="window-container zoomout">
			<p><a href="javascript:showTabla(false);"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a></p>
			<form name="CamposAvanzadosForm" method="post" id="CamposAvanzadosForm">
			<input type="hidden" name="CADENA_DOCUMENTOS"/>
			<table>
			<thead>
				<th colspan="3">&nbsp;</th>
			</thead>

			<tbody>
				<tr>
					<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='info_ampliada']/node()"/>:</strong></td>
					<td colspan="2"><textarea name="txtInfoAmpliada" id="txtInfoAmpliada" rows="4" cols="70" style="float:left;"/></td>
				</tr>

				<tr style="height:80px;">
					<td class="veinte"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/>:</strong></td>
					<td class="">
						<input type="file" name="inputFileDoc" id="inputFileDoc_CA" onchange="subirDoc('LIC_PRODUCTO_FT');" style="float:left;"/>
						<span id="DocCargado" style="float:left;display:none;"><span id="NombreDoc"></span>&nbsp;<a href="javascript:borrarDoc('LIC_PRODUCTO_FT');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></span>
						<input type="hidden" name="IDDOC" id="IDDOC"/>
						<input type="hidden" name="NombreDoc" id="NombreDoc"/>
						<input type="hidden" name="UrlDoc" id="UrlDoc"/>
					</td>
					<td class="trenta">
						<div id="waitBoxDoc_CA" align="center">&nbsp;</div>
						<div id="confirmBox_CA" style="display:none;" align="center">
							<span class="cargado" style="font-size:10px;">¡<xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/>!</span>
						</div>
					</td>
				</tr>

				<tr>
					<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='anotaciones']/node()"/>:</strong></td>
					<td colspan="2"><textarea name="txtAnotaciones" id="txtAnotaciones" rows="4" cols="70" style="float:left;"/></td>
				</tr>
			</tbody>

			<tfoot>
				<tr>
					<td>&nbsp;</td>
					<td colspan="2">
						<input type="hidden" name="posArray" id="posArray"/>
						<!--<div class="boton">-->
							<a class="btnDestacado" href="javascript:guardarCamposAvanzadosProd();">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
							</a>
							<!--&nbsp;<a href="javascript:showTabla(false);" class="btnNormal"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>-->
							&nbsp;<a href="javascript:cerrarCamposAvanzados();" class="btnNormal"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>
						<!--</div>-->
					</td>
				</tr>
			</tfoot>
			</table>
			</form>
		</div>
	</div>
	<!-- FIN DIV CamposAvanzados -->
</xsl:if>

<!-- DIV Flotante para boton calculo precios objetivos (sólo en estado 'En Curso') -->
<xsl:if test="/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_IDESTADO = 'CURS'">
	<div id="floatingBoxOBJ" style="display:none;clear:both;">
		<!--<table id="TableFB" style="border:2px solid black;">-->
		<table id="TableFB" class="TableFB">
		<thead>
			<tr>
				<th colspan="2" class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='escribe_porcentaje_precio_objetivo']/node()"/></th>
				<th><a href="javascript:cerrarPreciosObj();"><img src="http://www.newco.dev.br/images/cerrar.gif"/></a></th>
            </tr>
		</thead>
		<tbody>
			<tr style="height:40px;">
				<td class=""><label><xsl:value-of select="document($doc)/translation/texts/item[@name='porcentage']/node()"/></label></td>
				<td style="text-align:left;"><input type="text" name="valPorc" id="valPorc" value="10" size="2" style="vertical-align:bottom;"/>%</td>
				<td>&nbsp;</td>
			</tr>
			<tr style="height:40px;">
				<td>&nbsp;</td>
				<td>
					<div class="boton">
						<a href="javascript:calcularPreciosObj();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='seleccionar']/node()"/>
						</a>
					</div>
				</td>
				<td>&nbsp;</td>
			</tr>
		</tbody>
		</table>
	</div>
</xsl:if>
<!-- FIN DIV Flotante -->

	<div class="divLeft">
	<!--
	<xsl:if test="/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_PORPRODUCTO = 'S' and (/Mantenimiento/LICITACION/LIC_IDESTADO = 'INF' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'CURS')">
		<div class="divLeft" style="margin-top:20px">
			<table class="infoTable">
				<tr>
					<td class="veinte">&nbsp;</td>
					<td class="quince">
						<div id="botonSelecMejPrecios" class="botonLargo botonAccion">
							<a href="javascript:SeleccionarMejoresPrecios();">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='seleccionar_mejores_precios']/node()"/>
							</a>
						</div>
					</td>
					<td class="cinco">&nbsp;</td>
					<td class="quince">
						<div id="botonGuardarSelec" class="botonLargo botonAccion">
							<a href="javascript:GuardarSeleccion();"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_seleccion']/node()"/></a>
						</div>
					</td>
					<td class="cinco">&nbsp;</td>
					<td class="quince">
							<a class="btnDestacado" id="botonAdjudicarSelec" ref="javascript:AdjudicarOfertas();">
								<xsl:if test="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PRODUCTOS_OLVIDADOS">
									<xsl:attribute name="class">grey</xsl:attribute>
								</xsl:if>
								<xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicar']/node()"/>
							</a>
					</td>
					<td>&nbsp;</td>
				</tr>
			</table>
		</div>
	</xsl:if>
	-->
		<div class="divLeft" style="margin-top:20px">
			<table class="infoTable" border="0">
			<tfoot>
				<tr class="lejenda lineBorderBottom3" style="background:#E4E4E5;padding-top:3px;font-weight:bold;">
					<td colspan="4" class="datosLeft" style="padding:3px 0px 0px 20px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda']/node()"/>:</td>
				</tr>

				<tr class="lineBorderBottom5">
					<td class="veinte datosLeft">
						<p>
							&nbsp;&nbsp;&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/edit.png" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='abrir_comentarios']/node()"/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/check.gif" border="0"/>&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()"/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/fichaChange.gif" border="0"/>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ficha_tecnica']/node()"/>
						</p>
					</td>
					<td class="veinte datosLeft">
						<p>
							&nbsp;&nbsp;&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/bolaVerde.gif" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ev_apto']/node()"/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/bolaAmbar.gif" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ev_pendiente']/node()"/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/bolaRoja.gif" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ev_no_apto']/node()"/><br/>
						</p>
					</td>
					<td class="veinte datosLeft">
						<p>
							&nbsp;<span class="orange" style="height:3px;">1,0000</span>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_igual']/node()"/><br/>
							&nbsp;<span class="rojo" style="height:3px;">1,0000</span>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_superior']/node()"/><br/>
							&nbsp;<span class="verde" style="height:3px;">1,0000</span>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_inferior']/node()"/><br/>
						</p>
					</td>
					<td class="veinte datosLeft">
						<p>
							&nbsp;<span style="background-color:#FFFF99;height:3px;width:10px;">&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='mejor_precio']/node()"/><br/>
							&nbsp;<img src="http://www.newco.dev.br/images/atencion.gif" border="0"/>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto_sin_seleccion']/node()"/><br />
							&nbsp;&nbsp;<span class="rojo2">?</span>&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_oferta_sospechoso']/node()"/><br />
						</p>
					</td>
				</tr>
			</tfoot>
			</table>
			<br /><br />
		</div>


	<!--	18abr17	Permitimos añadir productos en el estado "En Curso"	-->
	<!--	Bloque de entrada de referencias	-->
	<xsl:if test="/Mantenimiento/LICITACION/AUTOR and /Mantenimiento/LICITACION/LIC_IDESTADO = 'CURS'">
	<div id="subpestanas" class="divLeft" style="border-bottom:2px solid #3B5998;margin-top:30px;">

	<xsl:choose>
	<xsl:when test="/Mantenimiento/LANG = 'spanish'">
		&nbsp;&nbsp;
		<a href="#" id="subpes_RefProductos" style="text-decoration:none;">
			<img src="http://www.newco.dev.br/images/botonAnadirProdRef1.gif">
				<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='anyadir_producto_x_referencia']/node()"/></xsl:attribute>
				<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='anyadir_producto_x_referencia']/node()"/></xsl:attribute>
			</img>
		</a>&nbsp;
		<a href="#" id="subpes_CatPrivProductos" style="text-decoration:none;">
			<img src="http://www.newco.dev.br/images/botonAnadirProdCatalogo.gif">
				<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='anyadir_producto_x_catalogo']/node()"/></xsl:attribute>
				<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='anyadir_producto_x_catalogo']/node()"/></xsl:attribute>
			</img>
		</a>
	</xsl:when>
	<xsl:otherwise>
		&nbsp;&nbsp;
		<a href="#" id="subpes_RefProductos" style="text-decoration:none;">
			<img src="http://www.newco.dev.br/images/botonAnadirProdRef1-BR.gif">
				<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='anyadir_producto_x_referencia']/node()"/></xsl:attribute>
				<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='anyadir_producto_x_referencia']/node()"/></xsl:attribute>
			</img>
		</a>&nbsp;
		<a href="#" id="subpes_CatPrivProductos" style="text-decoration:none;">
			<img src="http://www.newco.dev.br/images/botonAnadirProdCatalogo-BR.gif">
				<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='anyadir_producto_x_catalogo']/node()"/></xsl:attribute>
				<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='anyadir_producto_x_catalogo']/node()"/></xsl:attribute>
			</img>
		</a>
	</xsl:otherwise>
	</xsl:choose>
	</div>
	<div id="productos">
	<table class="infoTable divLeft" id="lProductosForm" style="margin-top:10px;" border="0">
		<tr id="TblCatPrivProductos" style="display:none;"><td colspan="4">
			<table class="infoTable divLeft incidencias" border="0" cellspacing="5">
			<form id="CatPrivProductos" name="CatPrivProductos" method="post">
				<tr>
					<td class="quince">&nbsp;</td>
					<td colspan="3" class="datosLeft"><span class="cambiarNivel"><xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_nuevo_poducto_X_cat_priv']/node()"/></span></td>
				</tr>

			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/NOMBRESNIVELES/@MostrarCategoria = 'S'">
				<tr id="nivel1">
					<td>&nbsp;</td>
					<td class="quince labelRight grisMed"><xsl:value-of select="/Mantenimiento/LICITACION/NOMBRESNIVELES/NIVEL1"/>:</td>
					<td class="quince datosLeft">
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="/Mantenimiento/LICITACION/LISTACATEGORIAS/field"/>
							<xsl:with-param name="onChange">SeleccionaFamilia(this.value);</xsl:with-param>
						</xsl:call-template>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr id="nivel2">
					<td>&nbsp;</td>
					<td class="labelRight grisMed"><xsl:value-of select="/Mantenimiento/LICITACION/NOMBRESNIVELES/NIVEL2"/>:</td>
					<td class="datosLeft">
						<select name="IDFAMILIA" id="IDFAMILIA" onchange="SeleccionaSubFamilia(this.value);" disabled="disabled">
							<option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/></option>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr id="nivel3">
					<td>&nbsp;</td>
					<td class="labelRight grisMed"><xsl:value-of select="/Mantenimiento/LICITACION/NOMBRESNIVELES/NIVEL3"/>:</td>
					<td class="datosLeft">
						<select name="IDSUBFAMILIA" id="IDSUBFAMILIA" onchange="SeleccionaGrupo(this.value);" disabled="disabled">
							<option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/></option>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr id="nivel4">
					<td>&nbsp;</td>
					<td class="labelRight grisMed"><xsl:value-of select="/Mantenimiento/LICITACION/NOMBRESNIVELES/NIVEL4"/>:</td>
					<td class="datosLeft">
						<select name="IDGRUPO" id="IDGRUPO" onchange="SeleccionaProducto(this.value);" disabled="disabled">
							<option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/></option>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr id="nivel5">
					<td>&nbsp;</td>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto_estandar']/node()"/>:</td>
					<td class="datosLeft">
						<select name="IDPRODUCTOESTANDAR" id="IDPRODUCTOESTANDAR" disabled="disabled">
							<option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/></option>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr id="nivel2">
					<td>&nbsp;</td>
					<td class="veinte labelRight grisMed"><xsl:value-of select="/Mantenimiento/LICITACION/NOMBRESNIVELES/NIVEL2"/>:</td>
					<td class="quince datosLeft">
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="/Mantenimiento/LICITACION/LISTAFAMILIAS/field"/>
							<xsl:with-param name="onChange">SeleccionaSubFamilia(this.value);</xsl:with-param>
						</xsl:call-template>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr id="nivel3">
					<td>&nbsp;</td>
					<td class="labelRight grisMed"><xsl:value-of select="/Mantenimiento/LICITACION/NOMBRESNIVELES/NIVEL3"/>:</td>
					<td class="datosLeft">
						<select name="IDSUBFAMILIA" id="IDSUBFAMILIA" onchange="SeleccionaGrupo(this.value);" disabled="disabled">
							<option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/></option>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr id="nivel5">
					<td>&nbsp;</td>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto_estandar']/node()"/>:</td>
					<td class="datosLeft">
						<select name="IDPRODUCTOESTANDAR" id="IDPRODUCTOESTANDAR" disabled="disabled">
							<option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/></option>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
			</xsl:otherwise>
			</xsl:choose>

			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/IDPAIS ='55' or /Mantenimiento/LICITACION/IDPAIS ='57'">
				<input type="hidden" name="LIC_TIPOIVA" value="0"/>
			</xsl:when>
			<xsl:otherwise>
				<tr>
					<td>&nbsp;</td>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/>:</td>
					<td class="datosLeft">
						<select name="LIC_TIPOIVA" id="LIC_TIPOIVA">
							<xsl:for-each select="/Mantenimiento/LICITACION/TIPOSIVA/field/dropDownList/listElem">
<!--								<xsl:sort select="number(translate(listItem,'%',''))"/>-->
								<option value="{ID}">
									<xsl:if test="ID = ../../@current">
										<xsl:attribute name="selected">selected</xsl:attribute>
									</xsl:if>
									<xsl:value-of select="listItem"/>
								</option>
							</xsl:for-each>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
			</xsl:otherwise>
			</xsl:choose>

				<tr>
					<td colspan="2">&nbsp;</td>
					<td>
						<!--<div class="boton">-->
							<a class="btnDestacado" href="javascript:ValidarFormulario(document.forms['CatPrivProductos'],'productos_2');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir']/node()"/>
							</a>
						<!--</div>-->
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr><td colspan="4">&nbsp;</td></tr>
			</form>
			</table>
		</td></tr>

		<tr id="TblRefProductos"><td colspan="4">
			<table class="infoTable divLeft incidencias" border="0" cellspacing="5">
			<form id="RefProductos" name="RefProductos" method="post">
				<tr>
					<td class="veinte">&nbsp;</td>
					<td colspan="3" class="datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_nuevo_poducto_X_ref_licitaciones']/node()"/>:&nbsp;
						<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/>[:<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/>[:<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ref']/node()"/>[:<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_obj']/node()"/>]]]
					</td>
				</tr>
				<xsl:if test="/Mantenimiento/LICITACION/CENTROSREFPARTICULARES">
				<tr>
					<xsl:if test="/Mantenimiento/LICITACION/LIC_CENTROSCODIFPARTICULAR>1">
						<xsl:attribute name="style">display:none</xsl:attribute>
					</xsl:if>
					<td class="veinte">&nbsp;</td>
					<td class="labelLeft" colspan="2"><xsl:value-of select="document($doc)/translation/texts/item[@name='Utilizar_codificacion']/node()"/>:&nbsp;
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="/Mantenimiento/LICITACION/CENTROSREFPARTICULARES/field"/>
							<xsl:with-param name="style">width:auto</xsl:with-param>
						</xsl:call-template>
						<br/>
					</td>
				</tr>
				</xsl:if>
				<tr>
					<td>&nbsp;</td>
					<td class="labelRight quince grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencias']/node()"/>:</td>
					<td class="quince datosLeft">
						<textarea name="LIC_LISTA_REFPRODUCTO" id="LIC_LISTA_REFPRODUCTO" cols="50" rows="5"/>
					</td>
					<td class="datosLeft">
						<a class="btnNormal" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoPrivadoProductoEmpresa.xsql?IDEMPRESA={/Mantenimiento/LICITACION/IDEMPRESACATALOGO}&amp;ORIGEN=LICITACION','Catálogo Privado',50,80,90,20);">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo']/node()"/>
						</a>
					</td>
				</tr>

			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/IDPAIS ='55'">
				<input type="hidden" name="LIC_TIPOIVA" value="0"/>
			</xsl:when>
			<xsl:when test="/Mantenimiento/LICITACION/IDPAIS ='57'">
				<input type="hidden" name="LIC_TIPOIVA" value="0"/>
			</xsl:when>
			<xsl:when test="/Mantenimiento/LICITACION/IDPAIS = '34'">
				<tr>
					<td>&nbsp;</td>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/>:</td>
					<td class="datosLeft">
						<select name="LIC_TIPOIVA" id="LIC_TIPOIVA">
							<xsl:for-each select="/Mantenimiento/LICITACION/TIPOSIVA/field/dropDownList/listElem">
<!--								<xsl:sort select="number(translate(listItem,'%',''))"/>-->
								<option value="{ID}">
									<xsl:if test="ID = ../../@current">
										<xsl:attribute name="selected">selected</xsl:attribute>
									</xsl:if>
									<xsl:value-of select="listItem"/>
								</option>
							</xsl:for-each>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
			</xsl:when>
			</xsl:choose>

				<tr>
					<td colspan="2">&nbsp;</td>
					<td>
						<!--<div class="boton">-->
						<a id="EnviarProductosPorRef" class="btnDestacado" href="javascript:ValidarFormulario(document.forms['RefProductos'],'productos');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_referencia']/node()"/>
						</a>
						<div id="idEstadoEnvio" style="display:none;"/>
						<!--</div>-->
					</td>
					<td>&nbsp;</td>
				</tr>
			</form>
			</table>
		</td></tr>
	</table>
	</div>
	</xsl:if>
	<!--	FIN Bloque de entrada de referencias	-->



	</div>
</div>

</xsl:template><!-- FIN Tabla Productos Ofertas Cliente -->

<!-- Tabla Productos Cliente Estudio Previo -->
<xsl:template name="Tabla_Productos_Cliente_Estudio_Previo">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:value-of select="/Mantenimiento/LANG"/>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<div id="lProductos" class="posContenedorLic" style="display:none;">
	<form id="ActualizarProductos" name="ActualizarProductos" method="POST">

	<!-- div superior para paginación y otros -->
	<div id="topPesProds" class="posCabTablaProd">
		<!-- Link a pagina anterior -->
		<div id="pagAnterior"  style="float:left;width:110px;">&nbsp;</div>
		<!-- Desplegable para numProductos en pagina, leyenda paginacion y desplegable tipo vista -->
		<div id="pagTamanyo" style="float:left;width:800px;">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='tamanyo_pagina']/node()"/>:&nbsp;
			<select name="numRegistros" id="numRegistros" style="font-size:11px;">
				<option value="10">10 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
				<option value="20" selected="selected">20 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
				<option value="50">50 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
				<option value="100">100 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
				<option value="200">200 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
				<option value="500">500 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
				<option value="1000">1000 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
				<option value="2000">2000 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
			</select>
			<!-- Leyenda paginacion -->
			<span id="paginacion" style="margin-left:20px;"></span>
		</div>
		<!-- Link a pagina siguiente -->
		<div id="pagSiguiente" style="float:left;width:80px;">&nbsp;</div>
	</div>

	<!--<table class="divLeft infoTable" id="lProductos_EST" border="0">-->
	<table class="buscador" id="lProductos_EST" border="0">
	<thead>
		<tr class="subTituloTabla">
			<td class="dos">
				<!-- Permitimos ordenacion por productos no informados-->
				<a href="javascript:ordenacionInformado('EST');" style="text-decoration:none;" id="anchorInformEST">
					<img src="http://www.newco.dev.br/images/atencion.gif">
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='ordenar_por_productos_sin_informar']/node()"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='ordenar_por_productos_sin_informar']/node()"/></xsl:attribute>
                    </img>
				</a>
			</td>
			<td class="siete">
				<!-- Permitimos ordenacion -->
				<a href="javascript:OrdenarProdsPorColumna('RefCliente');" style="text-decoration:none;" id="anchorRefCliente">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>
				</a>
			</td>
			<td style="text-align:left;">
				<!-- Permitimos ordenacion -->
				<a href="javascript:OrdenarProdsPorColumna('NombreNorm');" style="text-decoration:none;" id="anchorNombre">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>
				</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="text" name="filtroProductos" id="filtroProductos" style="font-size:11px;width:100px;"/>&nbsp;
                                <a href="javascript:filtrarProductosBeforeAjax();" style="font-size:11px;text-decoration:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/></a>
			</td>
			<td class="uno">&nbsp;</td><!-- iconos para los campos avanzados -->
			<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_alta']/node()"/></td>
			<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_modificacion']/node()"/></td>
			<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></td>
			<td class="siete">
			<xsl:choose>
			<xsl:when test="not(/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA)">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_historico_sIVA_2line']/node()"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_historico_cIVA_2line']/node()"/>
			</xsl:otherwise>
			</xsl:choose>
			</td>
			<td class="ocho">
			<xsl:choose>
			<xsl:when test="not(/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA)">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_objetivo_sIVA_2line']/node()"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_objetivo_cIVA_2line']/node()"/>
			</xsl:otherwise>
			</xsl:choose>

			<!-- DC - 30abr15 - Calculo automatico de precios objetivo -->
			<xsl:if test="/Mantenimiento/LICITACION/AUTOR">
				&nbsp;<a href="javascript:formPreciosObj();"><img src="http://www.newco.dev.br/images/calcula.gif"/></a>
			</xsl:if>

			</td>
			<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></td>
			<xsl:if test="not(/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA)">
				<td class="cinco">
					<!-- Permitimos ordenacion -->
					<a href="javascript:OrdenarProdsPorColumna('ConsumoHist');" style="text-decoration:none;" id="anchorConsumo">
						<xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_sIVA_2line']/node()"/>
					</a>
				</td>
			</xsl:if>

			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/IDPAIS = '34'">
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/></td>
			</xsl:when>
			<xsl:otherwise>
				<td class="zerouno">&nbsp;</td>
			</xsl:otherwise>
			</xsl:choose>

			<xsl:if test="/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA">
				<td class="cinco">
					<!-- Permitimos ordenacion -->
					<a href="javascript:OrdenarProdsPorColumna('ConsumoHistIVA');" style="text-decoration:none;" id="anchorConsumoIVA">
						<xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_cIVA_2line']/node()"/>
					</a>
				</td>
			</xsl:if>
			<td class="cinco">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='acciones']/node()"/>
			</td>
		</tr>
	</thead>

	<!-- Aqui dentro van las lineas de productos que se construyen via javascript -->
	<tbody></tbody>

	</table>
	</form>

<xsl:if test="/Mantenimiento/LICITACION/AUTOR">

	<!-- DIV Flotante -->
	<div class="FBox" id="floatingBox" style="display:none;clear:both;">
		<table id="TableFB" class="TablaFBox" style="border:1px solid black; width:100%;">
		<thead>
			<tr>
			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='num_prods_inform']/node()"/></th>
			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_historico']/node()"/></th>
			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_objetivo']/node()"/></th>
			<th>&nbsp;</th>
			</tr>
		</thead>
		<tbody>
			<tr><td id="FBNumInform"></td><td id="FBConsHist"></td><td id="FBConsObj"></td><td id="FBAviso"></td></tr>
		</tbody>
		</table>
	</div>
	<!-- FIN DIV Flotante -->

	<!-- DIV CamposAvanzados -->
	<div class="overlay-container" id="camposAvanzados">
		<div class="window-container zoomout">
			<!--<p><a href="javascript:showTabla(false);"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a></p>-->
			<form name="CamposAvanzadosForm" method="post" id="CamposAvanzadosForm">
			<input type="hidden" name="CADENA_DOCUMENTOS"/>
			<table>
			<thead>
				<th colspan="3">&nbsp;</th>
			</thead>

			<tbody>
				<tr>
					<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='info_ampliada']/node()"/>:</strong></td>
					<td colspan="2"><textarea name="txtInfoAmpliada" id="txtInfoAmpliada" rows="4" cols="70" style="float:left;"/></td>
				</tr>

				<tr style="height:80px;">
					<td class="veinte"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/>:</strong></td>
					<td class="">
						<input type="file" name="inputFileDoc" id="inputFileDoc_CA" onchange="subirDoc('LIC_PRODUCTO_FT');" style="float:left;"/>
						<span id="DocCargado" style="float:left;display:none;"><span id="NombreDoc"></span>&nbsp;<a href="javascript:borrarDoc('LIC_PRODUCTO_FT');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></span>
						<input type="hidden" name="IDDOC" id="IDDOC"/>
						<input type="hidden" name="NombreDoc" id="NombreDoc"/>
						<input type="hidden" name="UrlDoc" id="UrlDoc"/>
					</td>
					<td class="trenta">
						<div id="waitBoxDoc_CA" align="center">&nbsp;</div>
						<div id="confirmBox_CA" style="display:none;" align="center">
							<span class="cargado" style="font-size:10px;">¡<xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/>!</span>
						</div>
					</td>
				</tr>

				<tr>
					<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='anotaciones']/node()"/>:</strong></td>
					<td colspan="2"><textarea name="txtAnotaciones" id="txtAnotaciones" rows="4" cols="70" style="float:left;"/></td>
				</tr>
			</tbody>

			<tfoot>
				<tr>
					<td>&nbsp;</td>
					<td colspan="2">
						<input type="hidden" name="posArray" id="posArray"/>
						<div class="boton">
							<a href="javascript:guardarCamposAvanzadosProd();">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
							</a>
							<!--&nbsp;<a href="javascript:showTabla(false);" class="btnNormal"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>-->
							&nbsp;<a href="javascript:cerrarCamposAvanzados();" class="btnNormal"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>
						</div>
					</td>
				</tr>
			</tfoot>
			</table>
			</form>
		</div>
	</div>
	<!-- FIN DIV CamposAvanzados -->

	<!-- DIV Flotante para boton calculo precios objetivos -->
	<div id="floatingBoxOBJ" style="display:none;clear:both;">
		<!--<table id="TableFB" style="border:2px solid black;">-->
		<table id="TableFB" class="TablaFBox" >
		<thead>
			<tr>
				<th colspan="2" class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='escribe_porcentaje_precio_objetivo']/node()"/></th>
				<th><a href="javascript:cerrarPreciosObj();"><img src="http://www.newco.dev.br/images/cerrar.gif"/></a></th>
             </tr>
		</thead>
		<tbody>
			<tr style="height:40px;">
				<td class=""><label><xsl:value-of select="document($doc)/translation/texts/item[@name='porcentage']/node()"/></label></td>
				<td style="text-align:left;"><input type="text" name="valPorc" id="valPorc" value="10" size="2" style="vertical-align:bottom;"/>%</td>
				<td>&nbsp;</td>
			</tr>
			<tr style="height:40px;">
				<td>&nbsp;</td>
				<td>
					<div class="boton">
						<a href="javascript:calcularPreciosObj();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='seleccionar']/node()"/>
						</a>
					</div>
				</td>
				<td>&nbsp;</td>
			</tr>
		</tbody>
		</table>
	</div>
	<!-- FIN DIV Flotante -->
	<div id="subpestanas" class="divLeft" style="border-bottom:2px solid #3B5998;margin-top:30px;">

	<xsl:choose>
	<xsl:when test="/Mantenimiento/LANG = 'spanish'">
		&nbsp;&nbsp;
		<a href="#" id="subpes_RefProductos" style="text-decoration:none;">
			<img src="http://www.newco.dev.br/images/botonAnadirProdRef1.gif">
				<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='anyadir_producto_x_referencia']/node()"/></xsl:attribute>
				<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='anyadir_producto_x_referencia']/node()"/></xsl:attribute>
			</img>
		</a>&nbsp;
		<a href="#" id="subpes_CatPrivProductos" style="text-decoration:none;">
			<img src="http://www.newco.dev.br/images/botonAnadirProdCatalogo.gif">
				<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='anyadir_producto_x_catalogo']/node()"/></xsl:attribute>
				<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='anyadir_producto_x_catalogo']/node()"/></xsl:attribute>
			</img>
		</a>
	</xsl:when>
	<xsl:otherwise>
		&nbsp;&nbsp;
		<a href="#" id="subpes_RefProductos" style="text-decoration:none;">
			<img src="http://www.newco.dev.br/images/botonAnadirProdRef1-BR.gif">
				<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='anyadir_producto_x_referencia']/node()"/></xsl:attribute>
				<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='anyadir_producto_x_referencia']/node()"/></xsl:attribute>
			</img>
		</a>&nbsp;
		<a href="#" id="subpes_CatPrivProductos" style="text-decoration:none;">
			<img src="http://www.newco.dev.br/images/botonAnadirProdCatalogo-BR.gif">
				<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='anyadir_producto_x_catalogo']/node()"/></xsl:attribute>
				<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='anyadir_producto_x_catalogo']/node()"/></xsl:attribute>
			</img>
		</a>
	</xsl:otherwise>
	</xsl:choose>
	</div>
	<div id="productos">
	<table class="infoTable divLeft" id="lProductosForm" style="margin-top:10px;" border="0">
		<tr id="TblCatPrivProductos" style="display:none;"><td colspan="4">
			<table class="infoTable divLeft incidencias" border="0" cellspacing="5">
			<form id="CatPrivProductos" name="CatPrivProductos" method="post">
				<tr>
					<td class="quince">&nbsp;</td>
					<td colspan="3" class="datosLeft"><span class="cambiarNivel"><xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_nuevo_poducto_X_cat_priv']/node()"/></span></td>
				</tr>

			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/NOMBRESNIVELES/@MostrarCategoria = 'S'">
				<tr id="nivel1">
					<td>&nbsp;</td>
					<td class="quince labelRight grisMed"><xsl:value-of select="/Mantenimiento/LICITACION/NOMBRESNIVELES/NIVEL1"/>:</td>
					<td class="quince datosLeft">
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="/Mantenimiento/LICITACION/LISTACATEGORIAS/field"/>
							<xsl:with-param name="onChange">SeleccionaFamilia(this.value);</xsl:with-param>
						</xsl:call-template>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr id="nivel2">
					<td>&nbsp;</td>
					<td class="labelRight grisMed"><xsl:value-of select="/Mantenimiento/LICITACION/NOMBRESNIVELES/NIVEL2"/>:</td>
					<td class="datosLeft">
						<select name="IDFAMILIA" id="IDFAMILIA" onchange="SeleccionaSubFamilia(this.value);" disabled="disabled">
							<option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/></option>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr id="nivel3">
					<td>&nbsp;</td>
					<td class="labelRight grisMed"><xsl:value-of select="/Mantenimiento/LICITACION/NOMBRESNIVELES/NIVEL3"/>:</td>
					<td class="datosLeft">
						<select name="IDSUBFAMILIA" id="IDSUBFAMILIA" onchange="SeleccionaGrupo(this.value);" disabled="disabled">
							<option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/></option>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr id="nivel4">
					<td>&nbsp;</td>
					<td class="labelRight grisMed"><xsl:value-of select="/Mantenimiento/LICITACION/NOMBRESNIVELES/NIVEL4"/>:</td>
					<td class="datosLeft">
						<select name="IDGRUPO" id="IDGRUPO" onchange="SeleccionaProducto(this.value);" disabled="disabled">
							<option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/></option>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr id="nivel5">
					<td>&nbsp;</td>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto_estandar']/node()"/>:</td>
					<td class="datosLeft">
						<select name="IDPRODUCTOESTANDAR" id="IDPRODUCTOESTANDAR" disabled="disabled">
							<option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/></option>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr id="nivel2">
					<td>&nbsp;</td>
					<td class="veinte labelRight grisMed"><xsl:value-of select="/Mantenimiento/LICITACION/NOMBRESNIVELES/NIVEL2"/>:</td>
					<td class="quince datosLeft">
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="/Mantenimiento/LICITACION/LISTAFAMILIAS/field"/>
							<xsl:with-param name="onChange">SeleccionaSubFamilia(this.value);</xsl:with-param>
						</xsl:call-template>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr id="nivel3">
					<td>&nbsp;</td>
					<td class="labelRight grisMed"><xsl:value-of select="/Mantenimiento/LICITACION/NOMBRESNIVELES/NIVEL3"/>:</td>
					<td class="datosLeft">
						<select name="IDSUBFAMILIA" id="IDSUBFAMILIA" onchange="SeleccionaGrupo(this.value);" disabled="disabled">
							<option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/></option>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr id="nivel5">
					<td>&nbsp;</td>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto_estandar']/node()"/>:</td>
					<td class="datosLeft">
						<select name="IDPRODUCTOESTANDAR" id="IDPRODUCTOESTANDAR" disabled="disabled">
							<option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/></option>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
			</xsl:otherwise>
			</xsl:choose>

			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/IDPAIS ='55' or /Mantenimiento/LICITACION/IDPAIS ='57'">
				<input type="hidden" name="LIC_TIPOIVA" value="0"/>
			</xsl:when>
			<xsl:when test="/Mantenimiento/LICITACION/IDPAIS = '34'">
				<tr>
					<td>&nbsp;</td>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/>:</td>
					<td class="datosLeft">
						<select name="LIC_TIPOIVA" id="LIC_TIPOIVA">
							<xsl:for-each select="/Mantenimiento/LICITACION/TIPOSIVA/field/dropDownList/listElem">
<!--								<xsl:sort select="number(translate(listItem,'%',''))"/>-->
								<option value="{ID}">
									<xsl:if test="ID = ../../@current">
										<xsl:attribute name="selected">selected</xsl:attribute>
									</xsl:if>
									<xsl:value-of select="listItem"/>
								</option>
							</xsl:for-each>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
			</xsl:when>
			</xsl:choose>

				<tr>
					<td colspan="2">&nbsp;</td>
					<td>
						<!--<div class="boton">-->
							<a class="btnDestacado" href="javascript:ValidarFormulario(document.forms['CatPrivProductos'],'productos_2');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir']/node()"/>
							</a>
						<!--</div>-->
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr><td colspan="4">&nbsp;</td></tr>
			</form>
			</table>
		</td></tr>

		<tr id="TblRefProductos"><td colspan="4">
			<table class="infoTable divLeft incidencias" border="0" cellspacing="5">
			<form id="RefProductos" name="RefProductos" method="post">
				<tr>
					<td class="veinte">&nbsp;</td>
					<td colspan="3" class="datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_nuevo_poducto_X_ref_licitaciones']/node()"/>:&nbsp;
						<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/>:<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/>
						<!--:<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ref']/node()"/>-->
					</td>
				</tr>
				<xsl:if test="/Mantenimiento/LICITACION/CENTROSREFPARTICULARES">
					<tr>
						<td class="veinte">&nbsp;</td>
						<td class="labelLeft" colspan="2"><xsl:value-of select="document($doc)/translation/texts/item[@name='Utilizar_codificacion']/node()"/>:&nbsp;
							<xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="/Mantenimiento/LICITACION/CENTROSREFPARTICULARES/field"/>
								<xsl:with-param name="style">width:auto</xsl:with-param>
							</xsl:call-template>
							<br/>
						</td>
					</tr>
				</xsl:if>
				<tr>
					<td>&nbsp;</td>
					<td class="labelRight quince grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencias']/node()"/>:</td>
					<td class="quince datosLeft">
						<textarea name="LIC_LISTA_REFPRODUCTO" id="LIC_LISTA_REFPRODUCTO" cols="50" rows="15"/>
					</td>
					<td class="datosLeft" style="padding-left:5px;">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoPrivadoProductoEmpresa.xsql?IDEMPRESA={/Mantenimiento/LICITACION/IDEMPRESACATALOGO}&amp;ORIGEN=LICITACION','Catálogo Privado',50,80,90,20);">
						<xsl:choose>
						<xsl:when test="Mantenimiento/LICITACION/IDPAIS = '34'">
							<img src="http://www.newco.dev.br/images/abrirCatalogo.gif" alt="Abrir catálogo"/>
						</xsl:when>
						<xsl:otherwise>
							<img src="http://www.newco.dev.br/images/abrirCatalogo-BR.gif" alt="Catálogo aberto"/>
						</xsl:otherwise>
						</xsl:choose>
						</a>
					</td>
				</tr>

			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/IDPAIS ='55' or /Mantenimiento/LICITACION/IDPAIS ='57'">
				<input type="hidden" name="LIC_TIPOIVA" value="0"/>
			</xsl:when>
			<xsl:when test="/Mantenimiento/LICITACION/IDPAIS = '34'">
				<tr>
					<td>&nbsp;</td>
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/>:</td>
					<td class="datosLeft">
						<select name="LIC_TIPOIVA" id="LIC_TIPOIVA">
							<xsl:for-each select="/Mantenimiento/LICITACION/TIPOSIVA/field/dropDownList/listElem">
<!--								<xsl:sort select="number(translate(listItem,'%',''))"/>-->
								<option value="{ID}">
									<xsl:if test="ID = ../../@current">
										<xsl:attribute name="selected">selected</xsl:attribute>
									</xsl:if>
									<xsl:value-of select="listItem"/>
								</option>
							</xsl:for-each>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
			</xsl:when>
			</xsl:choose>

				<tr>
					<td colspan="2">&nbsp;</td>
					<td>
						<!--<div class="boton">-->
						<a id="EnviarProductosPorRef" class="btnDestacado" href="javascript:ValidarFormulario(document.forms['RefProductos'],'productos');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_referencia']/node()"/>
						</a>
						<div id="idEstadoEnvio" style="display:none;"/>
						<!--</div>-->
					</td>
					<td>&nbsp;</td>
				</tr>
			</form>
			</table>
		</td></tr>
	</table>
	</div>
<!--
	<div id="uploadFrameBox" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>
	<div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>
-->
	</xsl:if>
</div>
</xsl:template>
<!-- FIN Tabla Productos Cliente Estudio Previo -->

<!-- Tabla Productos Proveedor -->
<xsl:template name="Tabla_Productos_Proveedor">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:value-of select="/Mantenimiento/LANG"/>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<div id="lProductos" class="posContenedorLic" style="display:none;">
	<xsl:choose>
<!--	<xsl:when test="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PRODUCTO and (/Mantenimiento/LICITACION/LIC_IDESTADO = 'CURS' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'INF') and (/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_IDESTADO = 'CURS' or /Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_IDESTADO = 'INF')">-->
	<xsl:when test="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PRODUCTO and /Mantenimiento/LICITACION/PERMITIR_EDICION">

		<form name="PublicarOfertas" id="PublicarOfertas" method="post">
			<input type="hidden" name="LIC_ID" VALUE="{Mantenimiento/LICITACION/LIC_ID}"/>
			<input type="hidden" name="LIC_PROV_ID" VALUE="{Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_ID}"/>
			<input type="hidden" name="LIC_PROV_IDPROVEEDOR" VALUE="{Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_IDPROVEEDOR}"/>
			<input type="hidden" name="LIC_PROV_IDESTADO" VALUE="INF"/>
		</form>

		<!--<table class="divLeft infoTable incidencias" id="lPedidoMinimo" style="border-top:1px solid #999;" cellspacing="5">-->
		<table class="divLeft" id="lPedidoMinimo" cellspacing="5">
		<form class="formEstandar" name="PedidoMinimo" method="post" id="PedidoMinimo">
		<input type="hidden" name="LIC_PROV_ID" VALUE="{Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_ID}"/>
		<input type="hidden" name="LIC_PROV_IDPROVEEDOR" VALUE="{Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_IDPROVEEDOR}"/>
		<input type="hidden" name="LIC_PROV_IDESTADO" VALUE="INF"/>
		<thead>
			<tr class="subTituloTabla">
				<td colspan="2">
					<div style="margin:20px 0;width:90%;text-align:center;clear:both;font-size:12px;">
						<div style="width:1000px;margin:0 auto;background-color:#BCF5A9;border:2px solid #488214;height:55px;padding:10px;">
							<xsl:copy-of select="document($doc)/translation/texts/item[@name='intro_pedido_minimo']/node()"/>
						</div>
					</div>
				</td>
			</tr>
        	</thead>
			<!--	6jul16	ET	Nuevos campos, solo para Brasil	-->
			<xsl:choose>
			<xsl:when test="Mantenimiento/LICITACION/IDPAIS = 55">
				<tr class="sinLinea">
					<!--<td class="labelRight">-->
					<td class="textRight">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='frete']/node()"/>:</label>
					</td>
					<td class="datosLeft">
							[<xsl:value-of select="/Mantenimiento/LICITACION/LIC_FRETECIFOBLIGATORIO"/>]
						<xsl:choose>
						<xsl:when test="/Mantenimiento/LICITACION/LIC_FRETECIFOBLIGATORIO='S'">
							<input type="hidden" name="LIC_PROV_FRETE" id="frete" value="CIF"/>
						</xsl:when>
						<xsl:otherwise>
							<input type="hidden" name="LIC_PROV_FRETE" id="frete" value="{Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_FRETE}"/>
						</xsl:otherwise>
						</xsl:choose>						<input type="checkbox" name="frete_tipo_cif" id="frete_tipo_cif" onchange="cambiofrete(document.forms['PedidoMinimo'],'cif');">
							<xsl:if test="Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_FRETE='CIF' or Mantenimiento/LICITACION/LIC_FRETECIFOBLIGATORIO='S'">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:if>
							<xsl:if test="Mantenimiento/LICITACION/LIC_FRETECIFOBLIGATORIO='S'">
								<xsl:attribute name="disabled">disabled</xsl:attribute>
							</xsl:if>
						</input>
						&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cif_precio']/node()"/>
						&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="frete_tipo_fob" id="frete_tipo_fob" onchange="cambiofrete(document.forms['PedidoMinimo'],'fob');">
							<xsl:if test="Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_FRETE='FOB' and Mantenimiento/LICITACION/LIC_FRETECIFOBLIGATORIO!='S'">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:if>
							<xsl:if test="Mantenimiento/LICITACION/LIC_FRETECIFOBLIGATORIO='S'">
								<xsl:attribute name="disabled">disabled</xsl:attribute>
							</xsl:if>
						</input>
						&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fob_precio']/node()"/>
					</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<input type="hidden" name="LIC_PROV_FRETE" id="frete" value=""/>
			</xsl:otherwise>
			</xsl:choose>
			<tr class="sinLinea">
				<!--<td class="labelRight grisMed">-->
				<td class="textRight">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/>:</label>
				</td>
				<td class="datosLeft">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_PLAZOENTREGA/field"/>
						<xsl:with-param name="style">width:80px</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
			<!--<xsl:choose>
			<xsl:when test="Mantenimiento/LICITACION/LIC_AGREGADA='N'">-->
				<tr class="sinLinea">
					<!--<td class="labelRight grisMed">-->
					<td class="textRight">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo_sIVA']/node()"/>:</label>
					</td>
					<td class="datosLeft">
						<input type="text" name="LIC_PROV_PEDIDOMINIMO" id="pedido_minimo" value="{Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_PEDIDOMINIMO}"/>
					</td>
				</tr>
			
			<!--	18jun20	Para Brasil, permitimos al proveedor seleccionar la forma y plazo de pago	-->
			<xsl:if test="Mantenimiento/LICITACION/IDPAIS = 55">
			<tr class="sinLinea">
				<!--<td class="labelRight grisMed">-->
				<td class="textRight">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='forma_pago']/node()"/>:</label>
				</td>
				<td class="datosLeft">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Mantenimiento/LICITACION/FORMASPAGO/field"/>
						<xsl:with-param name="style">width:180px</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
			<tr class="sinLinea">
				<!--<td class="labelRight grisMed">-->
				<td class="textRight">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_pago']/node()"/>:</label>
				</td>
				<td class="datosLeft">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Mantenimiento/LICITACION/PLAZOSPAGO/field"/>
						<xsl:with-param name="style">width:300px</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
			</xsl:if>
			<!--	18jun20	Para Brasil, permitimos al proveedor seleccionar la forma y plazo de pago	-->
			
			<!--</xsl:when>
			<xsl:otherwise>
				<tr class="sinLinea">
					<td class="textRight">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo_por_centro_sIVA']/node()"/>:</label>
						<input type="hidden" name="LIC_PROV_PEDIDOMINIMO" id="pedido_minimo" value="{Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_PEDIDOMINIMO}"/>
					</td>
					<td class="datosLeft">
						&nbsp;
					</td>
				</tr>
				<xsl:for-each select="Mantenimiento/LICITACION/CENTROSLICITACION/CENTRO">
				<tr class="sinLinea">
					<td class="textRight">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={CEN_ID}','centro',100,80,0,-20);"><xsl:value-of select="NOMBRECORTO"/></a>:
					</td>
					<td class="datosLeft">
						<input type="text" class="chkpedmin" name="pedminimocen_{LICC_ID}" id="pedminimocen_{LICC_ID}" value="{PEDIDOMINIMO}"/>&nbsp;<xsl:value-of select="/Mantenimiento/LICITACION/DIVISA/SUFIJO"/>
					</td>
				</tr>
				</xsl:for-each>
			</xsl:otherwise>
			</xsl:choose>-->
			<tr class="sinLinea">
				<!--<td class="labelRight grisMed" valign="top" style="padding-top:5px">-->
				<td class="textRight">
					<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='Condiciones_y_Observaciones']/node()"/>:</label>
				</td>
				<td class="datosLeft">
					<textarea name="LIC_PROV_COMENTARIOSPROV" id="comentarios_prov" rows="4" cols="100"><xsl:copy-of select="Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_COMENTARIOSPROV/node()"/></textarea>
				</td>
			</tr>
			<!--	27ene20	Documento oferta proveedor		-->
			<tr class="sinLinea">
        		<input type="hidden" name="CADENA_DOCUMENTOS" />
        		<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
        		<input type="hidden" name="BORRAR_ANTERIORES"/>
        		<input type="hidden" name="ID_USUARIO" value="" />
        		<input type="hidden" name="TIPO_DOC" value="DOC_PROV_LICITACION"/>
            	<input type="hidden" name="LIC_PROV_IDDOCUMENTO" id="LIC_PROV_IDDOCUMENTO" value="{/Mantenimiento/LICITACION/PRODUCTOSLICITACION/DOC_PROV_LICITACION/ID}"/>
				<td class="textRight">
				<label>
					<xsl:choose>
					<xsl:when test="/Mantenimiento/LICITACION/LIC_DOCUMENTOOBLIGATORIO='S'">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Carta_autorizacion_obligatoria']/node()"/>
					</xsl:when>
					<xsl:otherwise>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/>
					</xsl:otherwise>
					</xsl:choose>:&nbsp;
				</label>
				
				
				
				</td>
				<td class="datosLeft">
					<xsl:choose>
					<xsl:when test="not (/Mantenimiento/LICITACION/PRODUCTOSLICITACION/DOC_PROV_LICITACION/URL)">
						<input id="inputFileDoc_Proveedor_{/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_ID}" name="inputFileDoc_Proveedor" type="file" style="width:500px;" onchange="javascript:addDocFile(document.forms['PedidoMinimo'],'Proveedor_'+{/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_ID});cargaDoc(document.forms['PedidoMinimo'], 'DOC_PROV_LICITACION','Proveedor_'+{/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_ID});"/>
						<!--<input id="inputFileDoc_Proveedor_{/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_ID}" name="inputFileDoc_Proveedor" type="file" style="width:500px;" onchange="javascript:addDocFileAndLoad(document.forms['PedidoMinimo'],'Proveedor_'+{/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_ID}, 'DOC_PROV_LICITACION');"/>-->
						<div id="divDatosDocumento" style="display:none;">
            				<a id="docProvLicitacion">
                    			&nbsp;
                			</a>
							<a href="javascript:borrarDoc('DOC_PROV_LICITACION')" style="width:20px;margin-top:4px;vertical-align:middle;"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>
						</div>
					</xsl:when>
					<xsl:otherwise>
						<input style="display:none;width:500px;" id="inputFileDoc_Proveedor_{/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_ID}" name="inputFileDoc_Proveedor" type="file" onchange="javascript:addDocFile(document.forms['PedidoMinimo'],'Proveedor_'+{/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_ID});cargaDoc(document.forms['PedidoMinimo'], 'DOC_PROV_LICITACION','Proveedor_'+{/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_ID});"/>
						<!--<input style="display:none;width:500px;" id="inputFileDoc_Proveedor_{/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_ID}" name="inputFileDoc_Proveedor" type="file" onchange="javascript:addDocFileAndLoad(document.forms['PedidoMinimo'],'Proveedor_'+{/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_ID}, 'DOC_PROV_LICITACION');"/>-->
 						<div id="divDatosDocumento">
            				<a href="http://www.newco.dev.br/Documentos/{/Mantenimiento/LICITACION/PRODUCTOSLICITACION/DOC_PROV_LICITACION/URL}" title="{/Mantenimiento/LICITACION/PRODUCTOSLICITACION/DOC_PROV_LICITACION/NOMBRE}" id="docProvLicitacion">
                    			<xsl:value-of select="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/DOC_PROV_LICITACION/NOMBRE"/>
                			</a>
							<a href="javascript:borrarDoc('DOC_PROV_LICITACION')" style="width:20px;margin-top:4px;vertical-align:middle;"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>
						</div>
					</xsl:otherwise>
					</xsl:choose>
            		<div id="waitBoxDoc_Proveedor_{/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_ID}" style="display:none;"><img src="http://www.newco.dev.br/images/descarga.gif" alt="Descarga" /></div>
            		<div id="confirmBox_Proveedor_{/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_ID}" style="display:none;" align="center">
                	<span class="cargado" style="font-size:10px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/>!</span>
            		</div>
				</td>
			</tr>
			<tr id="botonesFormPedidoMinimo">
				<td>&nbsp;</td>
				<td>
					<!--<div class="botonLargo divLeft20" id="InformarPedidoMinimo">-->
						<a class="btnDestacado" id="InformarPedidoMinimo" href="javascript:ValidarFormulario(document.forms['PedidoMinimo'],'provPedidoMinimo');">
							<!--7jul16	<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar_pedido_minimo']/node()"/>-->
							<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
						</a>
					<!--</div>&nbsp;-->
					<p id="MensPedidoMinimo" style="display:none;"><br/><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo_ok']/node()"/></p>
				</td>
			</tr>
			<tr><td colspan="2">&nbsp;</td></tr>
        	</form>
		</table>
		
		<div id="lTablaProductosProv">

		<xsl:choose>
		<xsl:when test="/Mantenimiento/LICITACION/LIC_PORPRODUCTO = 'S'">
			<div style="margin:20px 0;width:90%;text-align:center;clear:both;">
				<div style="width:1000px;margin:0 auto;padding:10px 10px 3px;background-color:#BCF5A9;border:2px solid #488214; border-bottom:0px;">
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='productos_sin_ofertar_expli']/node()"/></strong>
				</div>
				<div style="width:1000px;margin:0 auto;padding:3px 10px 10px;background-color:#BCF5A9;border:2px solid #488214; border-top:0px;">
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='informar_precio_cero_expli']/node()"/></strong>
				</div>
			</div>
		</xsl:when>
		<xsl:otherwise>
			<div style="margin:20px 0;width:90%;text-align:center;clear:both;">
				<div style="width:40%;margin:0 auto;padding:10px;background-color:#BCF5A9;border:2px solid #488214;">
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='informar_precio_cero_expli']/node()"/></strong>
				</div>
			</div>
		</xsl:otherwise>
		</xsl:choose>

		<form name="ProductosProveedor" method="post" id="ProductosProveedor">
		<input type="hidden" name="LIC_PROV_IDPROVEEDOR" VALUE="{Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_IDPROVEEDOR}"/>
		<input type="hidden" name="LIC_PROV_ID" VALUE="{Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_ID}"/>
		<input type="hidden" name="TIPO_DOC" VALUE="FT"/>
		<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
		<input type="hidden" name="BORRAR_ANTERIORES"/>
		<input type="hidden" name="CADENA_DOCUMENTOS"/>

		<!-- div superior para paginación y otros -->
		<div id="topPesProds">
			<!-- Link a pagina anterior -->
			<div id="pagAnterior" style="float:left;width:110px;text-align:left;padding-left:20px;line-height:30px;">&nbsp;</div>
			<!-- Desplegable para numProductos en pagina, leyenda paginacion y desplegable tipo vista -->
			<div id="pagTamanyo" style="float:left;width:800px;text-align:left;padding-left:20px;font-size:11px;line-height:30px;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='tamanyo_pagina']/node()"/>:&nbsp;
				<select name="numRegistros" id="numRegistros" style="font-size:11px;">
					<option value="10">10 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
					<option value="20">20 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
					<option value="50">50 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
					<option value="100">100 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
					<option value="200">200 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
					<option value="9999" selected="selected"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos_productos']/node()"/></option>
				</select>
				<!-- Leyenda paginacion -->
				<span id="paginacion" style="margin-left:20px;"></span>
				<span id="pagSiguiente" style="margin-left:60px;"></span>
			</div>
		</div>



		<!--<table class="divLeft infoTable" id="lProductos_PROVE" style="border-top:1px solid #999;" border="0">-->
		<table class="buscador" id="lProductos_PROVE">
		<thead>
			<tr class="subTituloTabla">
				<td class="uno">
					<!-- Permitimos ordenacion por productos no informados-->
					<a href="javascript:ordenacionInformado('PROV');" style="text-decoration:none;" id="anchorInformPROV">
						<img src="http://www.newco.dev.br/images/atencion.gif">
							<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='ordenar_por_productos_sin_oferta']/node()"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='ordenar_por_productos_sin_oferta']/node()"/></xsl:attribute>
						</img>
					</a>
				</td>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></td>
				<td class="uno">&nbsp;</td>
				<td style="width:100px;">&nbsp;</td><!-- columna iconos campos avanzados producto informados -->
				<td style="text-align:left;">
					<!-- Permitimos ordenacion -->
					<a href="javascript:OrdenarProdsPorColumna('NombreNorm');" style="text-decoration:none;" id="anchorNombre">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>
					</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="text" name="filtroProductos" id="filtroProductos" style="font-size:11px;width:100px;"/>&nbsp;
                    <a href="javascript:filtrarProductosBeforeAjax();" style="font-size:11px;text-decoration:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/></a>
				</td>
				<td>&nbsp;</td><!-- columna anyadir campos avanzados + iconos campos avanzados informados -->
				<xsl:choose>
				<xsl:when test="/Mantenimiento/LICITACION/IDPAIS = '55'">
					<td class="zerouno">&nbsp;</td>
				</xsl:when>
				<xsl:otherwise>
					<td class="seis"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/></td>
				</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
				<xsl:when test="/Mantenimiento/LICITACION/LIC_INCLUIR_REGSANITARIO='S'">
					<td class="seis"><xsl:value-of select="document($doc)/translation/texts/item[@name='reg_sanitario']/node()"/></td>
				</xsl:when>
				<xsl:otherwise>
					<td class="zerouno">&nbsp;</td>
				</xsl:otherwise>
				</xsl:choose>
				<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/></td>
				<td class="seis"><xsl:value-of select="document($doc)/translation/texts/item[@name='lic_marca']/node()"/></td>
				<td class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></td>
				<td class="cuatro"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></td>
				<xsl:if test="/Mantenimiento/LICITACION/MOSTRAR_PRECIO_OBJETIVO">
					<td class="siete"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_objetivo_sIVA_2line']/node()"/></td>
					<td class="cinco">
						<!-- Permitimos ordenacion -->
						<a href="javascript:OrdenarProdsPorColumna('Consumo');" style="text-decoration:none;" id="anchorConsumo">
							<xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_sIVA_2line']/node()"/>
                    	</a>
					</td>
				</xsl:if>
				<td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ud_por_lote_2line']/node()"/></td>
				<td class="seis"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_2line']/node()"/></td>
				<xsl:choose>
				<xsl:when test="/Mantenimiento/LICITACION/IDPAIS != '55'">
					<td class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/></td>
				</xsl:when>
				<xsl:otherwise>
					<td class="zerouno">&nbsp;</td>
				</xsl:otherwise>
				</xsl:choose>
				<td>&nbsp;</td><!-- Celda para el boton para guardar los datos de la oferta fila a fila -->
				<td class="zerouno">&nbsp;</td><!-- Celda para mostrar la imagen con el resultado de la operacion de la celda anterior -->
				<td class="zerouno">&nbsp;</td><!-- Celda para mostrar la imagen con el resultado de la operacion de la celda anterior -->
				<td class="zerouno">&nbsp;</td><!-- Celda para mostrar la imagen con el resultado de la operacion de la celda anterior -->
			</tr>
		</thead>

		<tbody></tbody>

		<tfoot>
			<tr class="sinLinea"><td colspan="18">&nbsp;</td></tr>
			<tr class="sinLinea">
				<td colspan="4">&nbsp;</td>
				<td colspan="14">
					<input type="checkbox" name="COMPLETAROFERTA" id="COMPLETAROFERTA" class="muypeq"/>&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='expli_completaroferta']/node()"/>
					<br/><br/>
				</td>
			</tr>
			<tr class="sinLinea">
				<td colspan="16">&nbsp;</td>
				<td colspan="2">
					<a class="btnDestacado"  id="idGuardarTodasOfertas" style="display:none;" href="javascript:guardarTodasOfertasAjax(0);">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/>
					</a>
				</td>
			</tr>
			<tr class="sinLinea">
				<td colspan="6" class="labelright">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='fichero']/node()"/>:&nbsp;
				</td>
				<td  colspan="12" class="textLeft" style="width:*;">
					<input class="muygrande" id="inputFile" name="inputFile" type="file" onChange="EnviarFicheroOfertas(this.files);"/>
				</td>
			</tr>
			<tr class="sinLinea"><td colspan="18">&nbsp;</td></tr>
			<tr class="sinLinea">
				<td colspan="18">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Enviar_referencias_para_proveedor']/node()"/> <xsl:if test="/Mantenimiento/LICITACION/LIC_INCLUIR_REGSANITARIO='S'">[:<xsl:value-of select="document($doc)/translation/texts/item[@name='reg_sanitario']/node()"/>]</xsl:if><br/>
					<textarea name="LIC_LISTA_OFERTAS" id="LIC_LISTA_OFERTAS" cols="150" rows="8"/><br/><br/>
					<!--<input type="checkbox" name="COMPLETAROFERTA" id="COMPLETAROFERTA" class="muypeq"/>&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='expli_completaroferta']/node()"/><br/><br/>
					-->
					<a id="EnviarOfertasPorRef" class="btnDestacado" href="javascript:ValidarFormulario(document.forms['ProductosProveedor'],'provEnviarOfertas');">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_referencia']/node()"/>
					</a>
				</td>
			</tr>
			<tr class="sinLinea"><td colspan="18">&nbsp;</td></tr>
		</tfoot>

		</table>
		</form>
		</div>
<!--
	<div id="uploadFrameBox" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>
	<div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>
-->
	</xsl:when>
	<xsl:when test="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PRODUCTO">
		<table class="buscador" id="lPedidoMinimo">
			<tr class="sinLinea"><td colspan="4">&nbsp;</td></tr>
			<!--	2jul19	ET	Nuevos campos, solo para Brasil, faltaba incluirlos en el aso de licitacion no editable	-->
			<xsl:if test="Mantenimiento/LICITACION/IDPAIS = 55">
				<tr class="sinLinea">
					<!--<td class="labelRight">-->
					<td class="textRight">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='frete']/node()"/>:</label>
					</td>
					<td class="datosLeft">
						<xsl:choose>
						<xsl:when test="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_FRETECIFOBLIGATORIO='S'">
							<input type="hidden" name="LIC_PROV_FRETE" id="frete" value="CIF"/>
						</xsl:when>
						<xsl:otherwise>
							<input type="hidden" name="LIC_PROV_FRETE" id="frete" value="{Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_FRETE}"/>
						</xsl:otherwise>
						</xsl:choose>
						<input type="checkbox" class="muypeq" name="frete_tipo_cif" id="frete_tipo_cif" onchange="cambiofrete(document.forms['PedidoMinimo'],'cif');">
							<xsl:if test="Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_FRETE='CIF'">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:if>
						</input>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='cif']/node()"/>
						&nbsp;&nbsp;&nbsp;
						<input type="checkbox" class="muypeq" name="frete_tipo_fob" id="frete_tipo_fob" onchange="cambiofrete(document.forms['PedidoMinimo'],'fob');">
							<xsl:if test="Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_FRETE='FOB'">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:if>
						</input>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='fob']/node()"/>
					</td>
				</tr>
			</xsl:if>
			<tr class="sinLinea">
				<!--<td class="labelRight grisMed">-->
				<td class="labelRight">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/>:</label>
				</td>
				<td class="textLeft">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_PLAZOENTREGA/field"/>
					</xsl:call-template>
				</td>
			</tr>
			<!--<xsl:choose>
			<xsl:when test="Mantenimiento/LICITACION/LIC_AGREGADA='N'">-->
				<tr class="sinLinea">
					<td class="labelRight">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo_sIVA']/node()"/>:
					</td>
					<td class="textLeft">
						<xsl:value-of select="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_PEDIDOMINIMO"/>
					</td>
					<td>&nbsp;</td>
				</tr>
			<!--</xsl:when>
			<xsl:otherwise>
				<tr class="sinLinea">
					<td style="width:100px;">&nbsp;</td>
					<td class="textRight diez">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo_por_centro_sIVA']/node()"/>:</label>
					</td>
					<td class="datosLeft" style="padding: 15px 10px;">
						&nbsp;
					</td>
					<td>&nbsp;</td>
				</tr>
				<xsl:for-each select="/Mantenimiento/LICITACION/CENTROSLICITACION/CENTRO">
				<tr class="sinLinea">
					<td>&nbsp;</td>
					<td class="textRight">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={CEN_ID}','centro',100,80,0,-20);"><xsl:value-of select="NOMBRECORTO"/></a>:
					</td>
					<td class="datosLeft">
						<xsl:value-of select="PEDIDOMINIMO"/>&nbsp;<xsl:value-of select="/Mantenimiento/LICITACION/DIVISA/SUFIJO"/>
					</td>
					<td>&nbsp;</td>
				</tr>
				</xsl:for-each>
			</xsl:otherwise>
			</xsl:choose>-->
			<tr class="sinLinea">
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/>:</td>
				<td class="textLeft"><xsl:copy-of select="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_COMENTARIOSPROV/node()"/></td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea"><td colspan="4">&nbsp;</td></tr>
    	</table>
		<!--<table class="divLeft infoTable" id="lProductos_PROVE">-->
		<table class="buscador" id="lProductos_PROVE">
		<thead>
			<tr class="subTituloTabla" id="leyendaPaginacion">
				<!-- Link a pagina anterior -->
				<td colspan="4" id="pagAnterior" style="text-align:left;padding-left:20px;"></td>
				<!-- Desplegable para numProductos y leyenda paginacion -->
				<td colspan="10" style="text-align:left;padding-left:20px;font-size:11px;">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='tamanyo_pagina']/node()"/>:&nbsp;
					<select name="numRegistros" id="numRegistros" style="font-size:11px;">
						<option value="10">10 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
						<option value="20">20 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
						<option value="50">50 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
						<option value="100">100 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
						<option value="200">200 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
						<option value="9999" selected="selected"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos_productos']/node()"/></option>
					</select>
					<span id="paginacion" style="margin-left:20px;"></span>
					<span id="pagSiguiente" style="display:inline-block;margin-left:50px;"></span>
				</td>
				<!-- Link a pagina siguiente -->
				<td colspan="3">&nbsp;</td>
	<!--			<td colspan="3" id="pagSiguiente" style="text-align:right;padding-right:20px;"></td>-->
                	</tr>
			<tr class="subTituloTabla">
				<td class="uno">&nbsp;</td>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></td>
				<td class="zerouno"></td>
				<td style="width:100px">&nbsp;</td><!-- columna iconos campos avanzados producto informados -->
				<td class="veinte" style="text-align:left;">
					<!-- Permitimos ordenacion -->
					<a href="javascript:OrdenarProdsPorColumna('NombreNorm');" style="text-decoration:none;" id="anchorNombre">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>
					</a>
                        	</td>
				<td>&nbsp;</td><!-- columna anyadir campos avanzados + iconos campos avanzados informados -->
				<td class="seis"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/></td>
				<td class="uno"></td>
				<td style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/></td>
				<td class="seis"><xsl:value-of select="document($doc)/translation/texts/item[@name='lic_marca']/node()"/></td>
				<td class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></td>
				<td class="cuatro"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></td>
				<td class="siete"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ud_por_lote_2line']/node()"/></td>
				<td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_objetivo_sIVA_2line']/node()"/></td>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></td>
				<td class="seis">
					<!-- Permitimos ordenacion -->
					<a href="javascript:OrdenarProdsPorColumna('ConsumoOferta');" style="text-decoration:none;" id="anchorConsumoOferta">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/>
					</a>
                        	</td>
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/IDPAIS != '55'">
				<td class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/></td>
			</xsl:when>
			<xsl:otherwise>
				<td class="zerouno">&nbsp;</td>
        	</xsl:otherwise>
			</xsl:choose>
			</tr>
		</thead>

		<!-- Aqui dentro se informara el cuerpo de la tabla via javascript -->
		<tbody></tbody>

        </table>
	</xsl:when>
	<xsl:otherwise>
		<table class="buscador" id="lPedidoMinimo">
			<tr class="sinLinea"><td colspan="4">&nbsp;</td></tr>
			<!--	2jul19	ET	Nuevos campos, solo para Brasil, faltaba incluirlos en el aso de licitacion no editable	-->
			<xsl:if test="Mantenimiento/LICITACION/IDPAIS = 55">
				<tr class="sinLinea">
					<!--<td class="labelRight">-->
					<td class="textRight">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='frete']/node()"/>:</label>
					</td>
					<td class="datosLeft">
						<input type="hidden" name="LIC_PROV_FRETE" id="frete" value="{Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_FRETE}"/>
						<input type="checkbox" class="muypeq" name="frete_tipo_cif" id="frete_tipo_cif" onchange="cambiofrete(document.forms['PedidoMinimo'],'cif');">
							<xsl:if test="Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_FRETE='CIF'">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:if>
						</input>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='cif']/node()"/>
						&nbsp;&nbsp;&nbsp;
						<input type="checkbox" class="muypeq" name="frete_tipo_fob" id="frete_tipo_fob" onchange="cambiofrete(document.forms['PedidoMinimo'],'fob');">
							<xsl:if test="Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_FRETE='FOB'">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:if>
						</input>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='fob']/node()"/>
					</td>
				</tr>
			</xsl:if>
			<tr class="sinLinea">
				<!--<td class="labelRight grisMed">-->
				<td class="labelRight">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/>:</label>
				</td>
				<td class="textLeft">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_PLAZOENTREGA/field"/>
					</xsl:call-template>
				</td>
			</tr>
			<!--<xsl:choose>
			<xsl:when test="Mantenimiento/LICITACION/LIC_AGREGADA='N'">-->
				<tr class="sinLinea">
					<td class="labelRight">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo_sIVA']/node()"/>:
					</td>
					<td class="textLeft">
						<xsl:value-of select="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_PEDIDOMINIMO"/>
					</td>
					<td>&nbsp;</td>
				</tr>
			<!--</xsl:when>
			<xsl:otherwise>
				<tr class="sinLinea">
					<td style="width:100px;">&nbsp;</td>
					<td class="textRight diez">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo_por_centro_sIVA']/node()"/>:</label>
					</td>
					<td class="datosLeft" style="padding: 15px 10px;">
						&nbsp;
					</td>
					<td>&nbsp;</td>
				</tr>
				<xsl:for-each select="/Mantenimiento/LICITACION/CENTROSLICITACION/CENTRO">
				<tr class="sinLinea">
					<td>&nbsp;</td>
					<td class="textRight">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={CEN_ID}','centro',100,80,0,-20);"><xsl:value-of select="NOMBRECORTO"/></a>:
					</td>
					<td class="datosLeft">
						<xsl:value-of select="PEDIDOMINIMO"/>&nbsp;<xsl:value-of select="/Mantenimiento/LICITACION/DIVISA/SUFIJO"/>
					</td>
					<td>&nbsp;</td>
				</tr>
				</xsl:for-each>
			</xsl:otherwise>
			</xsl:choose>-->
			<tr class="sinLinea">
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/>:</td>
				<td class="textLeft"><xsl:copy-of select="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_COMENTARIOSPROV/node()"/></td>
				<td>&nbsp;</td>
			</tr>
			<tr class="sinLinea"><td colspan="4">&nbsp;</td></tr>
    	</table>
		<table class="buscador" id="lProductos_PROVE">
		<thead>
			<tr class="subTituloTabla">
				<td class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></td>
				<td class="trenta" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></td>
				<td class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/></td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/></td>
				<td class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='lic_marca']/node()"/></td>
				<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></td>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></td>
				<td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ud_por_lote_2line']/node()"/></td>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_objetivo_sIVA_2line']/node()"/></td>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></td>
				<td class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></td>
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/IDPAIS != '55'">
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/></td>
			</xsl:when>
			<xsl:otherwise>
				<td class="zerouno">&nbsp;</td>
                	</xsl:otherwise>
			</xsl:choose>
			</tr>
		</thead>
		<tbody>
			<tr><td colspan="12" align="center"><xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion_sin_productos']/node()"/></td></tr>
		</tbody>
		</table>
	</xsl:otherwise>
	</xsl:choose>

	<!-- DIV CamposAvanzados -->
	<div class="overlay-container" id="camposAvanzados">
		<div class="window-container zoomout">
			<!--<p><a href="javascript:showTabla(false);"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a></p>-->
			<form name="CamposAvanzadosForm" method="post" id="CamposAvanzadosForm">
			<input type="hidden" name="CADENA_DOCUMENTOS"/>
			<table>
			<thead>
				<th colspan="3">&nbsp;</th>
			</thead>

			<tbody>
				<tr>
					<td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='info_ampliada']/node()"/>:</strong></td>
					<td colspan="2"><textarea name="txtInfoAmpliada" id="txtInfoAmpliada" rows="4" cols="70" style="float:left;"/></td>
				</tr>

				<tr style="height:80px;">
					<td class="veinte"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/>:</strong></td>
					<td class="">
						<input type="file" name="inputFileDoc_CA" id="inputFileDoc_CA" onchange="subirDoc('LIC_OFERTA_FT');" style="float:left;"/>
						<span id="DocCargado" style="float:left;display:none;"><span id="NombreDoc"></span>&nbsp;<a href="javascript:borrarDoc('LIC_OFERTA_FT');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a></span>
						<input type="hidden" name="IDDOC" id="IDDOC"/>
						<input type="hidden" name="NombreDoc" id="NombreDoc"/>
						<input type="hidden" name="UrlDoc" id="UrlDoc"/>
					</td>
					<td class="trenta">
						<div id="waitBoxDoc_CA" align="center">&nbsp;</div>
						<div id="confirmBox_CA" style="display:none;" align="center">
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
						<!--<div class="boton">-->
							<a href="javascript:guardarCamposAvanzadosOfe();" class="btnDestacado">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
							</a>
							<!--&nbsp;<a href="javascript:showTabla(false);" class="btnNormal"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>-->
							&nbsp;<a href="javascript:cerrarCamposAvanzados();" class="btnNormal"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>
						<!--</div>-->
					</td>
				</tr>
			</tfoot>
			</table>
			</form>
		</div>
	</div>
	<!-- FIN DIV CamposAvanzados -->

<xsl:if test="/Mantenimiento/LICITACION/LIC_IDESTADO = 'CURS'">

	<!-- DIV Flotante -->
	<div class="FBox" id="floatingBoxMin" style="width:170px;display:none;clear:both;">
		<table id="TableFBMin" class="TablaFBox" style="border:1px solid black; width:100%;">
			<tr>
				<td class="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='num_prods_inform']/node()"/></td>
				<!--<td class="FBNumInform"></td>-->
				<td id="FBNumInform"></td>
				<td><a href="javascript:triggerFB(1);"><img src="http://www.newco.dev.br/images/anadir.gif"/></a></td>
			</tr>
		</table>
	</div>

	<div class="FBox" id="floatingBox" style="display:none;clear:both;margin-top:5px;">
	<!--<div class="FBox" id="floatingBox" style="display:none;clear:both;">-->
		<table id="TableFB" class="TablaFBox" style="border:1px solid black; width:100%;">
		<thead>
			<tr>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='num_prods_inform']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='num_cumple_objetivo']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_oferta']/node()"/></th>
				<th><a href="javascript:triggerFB(0);"><img src="http://www.newco.dev.br/images/cerrar.gif"/></a></th>
			</tr>
		</thead>
		<tbody>
			<tr><td class="FBNumInform"></td><td id="FBNumOpt"></td><td id="FBConsOfe"></td><td id="FBAviso"></td></tr>
		</tbody>
		</table>
	</div>

	<!-- DC - 09abr15 - Se cambia por un div flotante minimalista
	<div class="FBox" id="floatingBox" style="display:none;clear:both;">
		<table id="TableFB" style="border:2px solid black;">
		<thead>
			<tr>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='num_prods_inform']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='num_cumple_objetivo']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_oferta']/node()"/></th>
				<th>&nbsp;</th>
			</tr>
		</thead>
		<tbody>
			<tr><td id="FBNumInform"></td><td id="FBNumOpt"></td><td id="FBConsOfe"></td><td id="FBAviso"></td></tr>
		</tbody>
		</table>
	</div>
	-->
	<!-- FIN DIV Flotante -->
</xsl:if>

<xsl:if test="/Mantenimiento/LICITACION/LICITACION_AGREGADA">
	<!-- div flotante para mostrar info historica de centros -->
	<div class="overlay-container" id="infoHistoricaCentros">
		<div class="window-container zoomout">
			<p><a href="javascript:showTabla(false);"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a></p>

			<p id="tableTitle"></p>

			<div id="mensError" class="divLeft" style="display:none;">
				<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></strong></p>
			</div>

			<table id="datosCentros" style="width:100%;">
			<thead>
				<tr><th colspan="4">&nbsp;</th></tr>
				<tr>
					<th class="cinco">&nbsp;</th>
					<th class="" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
					<th class="veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_anual']/node()"/></th>
					<th class="cinco">&nbsp;</th>
				</tr>
			</thead>

			<tbody></tbody>

			</table>
		</div>
	</div>
	<!-- FIN div flotante -->
</xsl:if>

</div>
</xsl:template>
<!-- FIN Tabla Productos Proveedor -->


<!-- 14jul16 Tabla Productos para ser informada por un centro -->
<xsl:template name="Tabla_Productos_Centro_Estudio_Previo">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:value-of select="/Mantenimiento/LANG"/>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<div id="lProductos" class="posContenedorLic" style="display:none;">
	<xsl:choose>
<!--	<xsl:when test="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PRODUCTO and (/Mantenimiento/LICITACION/LIC_IDESTADO = 'CURS' or /Mantenimiento/LICITACION/LIC_IDESTADO = 'INF') and (/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_IDESTADO = 'CURS' or /Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_IDESTADO = 'INF')">-->
	<xsl:when test="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PRODUCTO and /Mantenimiento/LICITACION/PERMITIR_EDICION">

	<form name="PublicarCompras" id="PublicarCompras" method="post">
		<input type="hidden" name="LIC_ID" VALUE="{Mantenimiento/LICITACION/LIC_ID}"/>
		<input type="hidden" name="IDCENTRO" VALUE="{Mantenimiento/LICITACION/PRODUCTOSLICITACION/IDCENTRO}"/>
		<!--<input type="hidden" name="LIC_PROV_IDPROVEEDOR" VALUE="{Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_IDPROVEEDOR}"/>-->
		<input type="hidden" name="IDESTADO" VALUE="INF"/>
	</form>

	<!--
	<table class="divLeft infoTable incidencias" id="lPedidoMinimo" style="border-top:1px solid #999;" cellspacing="5">
	<form name="PedidoMinimo" method="post" id="PedidoMinimo">
	<input type="hidden" name="IDCENTRO" VALUE="{Mantenimiento/LICITACION/PRODUCTOSLICITACION/IDCENTRO}"/>
	<input type="hidden" name="IDESTADO" VALUE="INF"/>
	<thead>
		<tr class="subTituloTabla">
			<td colspan="2">
				<div style="margin:20px 0;width:90%;text-align:center;clear:both;font-size:12px;">
					<div style="width:40%;margin:0 auto;background-color:#BCF5A9;border:2px solid #488214;height:55px;padding:10px;">
						<xsl:copy-of select="document($doc)/translation/texts/item[@name='intro_pedido_minimo']/node()"/>
					</div>
				</div>
			</td>
		</tr>
        </thead>
		<xsl:choose>
		<xsl:when test="Mantenimiento/LICITACION/IDPAIS = 55">
			<tr>
				<td class="labelRight grisMed">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='frete']/node()"/>:
				</td>
				<td class="datosLeft">
					<input type="hidden" name="LIC_PROV_FRETE" id="frete" value="{Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_FRETE}"/>
					<input type="checkbox" name="frete_tipo_cif" id="frete_tipo_cif" onchange="cambiofrete(document.forms['PedidoMinimo'],'cif');">
						<xsl:if test="Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_FRETE='CIF'">
							<xsl:attribute name="checked">checked</xsl:attribute>
						</xsl:if>
					</input>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='cif']/node()"/>
					&nbsp;&nbsp;&nbsp;
					<input type="checkbox" name="frete_tipo_fob" id="frete_tipo_fob" onchange="cambiofrete(document.forms['PedidoMinimo'],'fob');">
						<xsl:if test="Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_FRETE='FOB'">
							<xsl:attribute name="checked">checked</xsl:attribute>
						</xsl:if>
					</input>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='fob']/node()"/>
				</td>
			</tr>
		</xsl:when>
		<xsl:otherwise>
			<input type="hidden" name="LIC_PROV_FRETE" id="frete" value=""/>
		</xsl:otherwise>
		</xsl:choose>
		<tr>
			<td class="labelRight grisMed">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/>:
			</td>
			<td class="datosLeft">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_PLAZOENTREGA/field"/>
				</xsl:call-template>
			</td>
		</tr>
		<tr>
			<td class="labelRight grisMed">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo_sIVA']/node()"/>:
			</td>
			<td class="datosLeft">
				<input type="text" name="LIC_PROV_PEDIDOMINIMO" id="pedido_minimo" value="{Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_PEDIDOMINIMO}"/>
			</td>
		</tr>
		<tr>
			<td class="labelRight grisMed" valign="top" style="padding-top:5px">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/>:
			</td>
			<td class="datosLeft">
				<textarea name="LIC_PROV_COMENTARIOSPROV" id="comentarios_prov" rows="4" cols="100"><xsl:copy-of select="Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_COMENTARIOSPROV/node()"/></textarea>
			</td>
		</tr>
		<tr id="botonesFormPedidoMinimo">
			<td>&nbsp;</td>
			<td>
				<div class="botonLargo divLeft20" id="InformarPedidoMinimo">
					<a href="javascript:ValidarFormulario(document.forms['PedidoMinimo'],'provPedidoMinimo');">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
					</a>
				</div>&nbsp;
				<div id="MensPedidoMinimo" style="display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo_ok']/node()"/></div>
			</td>
		</tr>
		<tr><td colspan="2">&nbsp;</td></tr>
        </form>
	</table>
	-->
	<xsl:choose>
	<xsl:when test="/Mantenimiento/LICITACION/LIC_PORPRODUCTO = 'S'">
		<div style="margin:20px 0;width:90%;text-align:center;clear:both;">
			<div style="width:40%;margin:0 auto;padding:10px 10px 3px;background-color:#BCF5A9;border:2px solid #488214; border-bottom:0px;">
				<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='productos_sin_ofertar_expli']/node()"/></strong>
			</div>
			<div style="width:40%;margin:0 auto;padding:3px 10px 10px;background-color:#BCF5A9;border:2px solid #488214; border-top:0px;">
				<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='informar_precio_cero_expli']/node()"/></strong>
			</div>
		</div>
	</xsl:when>
	<xsl:otherwise>
		<div style="margin:20px 0;width:90%;text-align:center;clear:both;">
			<div style="width:40%;margin:0 auto;padding:10px;background-color:#BCF5A9;border:2px solid #488214;">
				<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='informar_precio_cero_expli']/node()"/></strong>
			</div>
		</div>
	</xsl:otherwise>
	</xsl:choose>

	<form name="ProductosCompraCentro" method="post" id="ProductosCompraCentro">
	<input type="hidden" name="IDCENTRO" VALUE="{Mantenimiento/LICITACION/PRODUCTOSLICITACION/IDCENTRO}"/>
	<!--
	<input type="hidden" name="LIC_PROV_ID" VALUE="{Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_ID}"/>
	<input type="hidden" name="TIPO_DOC" VALUE="FT"/>
	<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
	<input type="hidden" name="BORRAR_ANTERIORES"/>
	<input type="hidden" name="CADENA_DOCUMENTOS"/>
	-->
	<!-- div superior para paginación y otros 
	<div id="topPesProds">
		< Link a pagina anterior 
		<div id="pagAnterior" style="float:left;width:110px;text-align:left;padding-left:20px;height:100%;line-height:30px;">&nbsp;</div>
		< Desplegable para numProductos en pagina, leyenda paginacion y desplegable tipo vista 
		<div id="pagTamanyo" style="float:left;width:800px;text-align:left;padding-left:20px;font-size:11px;height:100%;line-height:30px;">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='tamanyo_pagina']/node()"/>:&nbsp;
			<select name="numRegistros" id="numRegistros" style="font-size:11px;">
				<option value="10">10 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
				<option value="20">20 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
				<option value="50">50 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
				<option value="100">100 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
				<option value="200">200 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
				<option value="9999" selected="selected"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos_productos']/node()"/></option>
			</select>
			 Leyenda paginacion 
			<span id="paginacion" style="margin-left:20px;"></span>
			<span id="pagSiguiente" style="margin-left:60px;"></span>
		</div>
	</div>
	-->
	<table class="divLeft infoTable" id="lProductos_CENTRO" style="border-top:1px solid #999;" border="0">
	<thead>
		<tr class="subTituloTabla">
			<td class="uno">
				<!-- Permitimos ordenacion por productos no informados-->
				<a href="javascript:ordenacionInformado('CEN');" style="text-decoration:none;" id="anchorInformPROV">
					<img src="http://www.newco.dev.br/images/atencion.gif">
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='ordenar_por_productos_sin_oferta']/node()"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='ordenar_por_productos_sin_oferta']/node()"/></xsl:attribute>
					</img>
				</a>
			</td>
			<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></td>
			<td class="uno">&nbsp;</td>
			<td class="zerouno">&nbsp;</td><!-- columna iconos campos avanzados producto informados -->
			<td style="text-align:left;">
				<!-- Permitimos ordenacion -->
				<a href="javascript:OrdenarProdsPorColumna('NombreNorm');" style="text-decoration:none;" id="anchorNombre">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>
				</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="text" name="filtroProductos" id="filtroProductos" style="font-size:11px;width:100px;"/>&nbsp;
                <a href="javascript:filtrarProductosBeforeAjax();" style="font-size:11px;text-decoration:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/></a>
			</td>
			<td>&nbsp;</td><!-- columna anyadir campos avanzados + iconos campos avanzados informados -->
			<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/></td>
			<td class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></td>
			<td class="cuatro"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></td>
			<td>&nbsp;</td><!-- Celda para el boton para guardar los datos de la oferta fila a fila -->
			<td class="zerouno">&nbsp;</td><!-- Celda para mostrar la imagen con el resultado de la operacion de la celda anterior -->
		</tr>
	</thead>

	<tbody></tbody>

	<tfoot>
		<tr><td colspan="18">&nbsp;</td></tr>
		<tr>
			<td colspan="3">&nbsp;</td>
			<td colspan="2">
				<div class="boton">
					<a href="javascript:print();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
					</a>
				</div>&nbsp;
      </td>
			<td colspan="3">
<!--
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_IDESTADO = 'INF'">
				<div class="boton" id="BtnActualizarOfertas">
					<a href="javascript:ValidarFormulario(document.forms['ProductosProveedor'],'productosProveedor');">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar_datos']/node()"/>
					</a>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div class="botonLargo" id="BtnActualizarOfertas">
					<a href="javascript:ValidarFormulario(document.forms['ProductosProveedor'],'productosProveedor');">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar_datos_sin_publicar']/node()"/>
					</a>
				</div>
			</xsl:otherwise>
			</xsl:choose>
				&nbsp;<div id="LoadActualizarOfertas" style="display:none;"><img src="http://www.newco.dev.br/images/loading.gif"/></div>
				<div id="MensActualizarOfertas" style="display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar_ofertas_ok']/node()"/></div>
-->
			</td>
			<td colspan="10">&nbsp;</td>
		</tr>
		<tr><td colspan="18">&nbsp;</td></tr>
	</tfoot>

	</table>
	</form>
<!--
	<div id="uploadFrameBox" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>
	<div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>
-->
	</xsl:when>
	<xsl:when test="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PRODUCTO">
		<form name="PublicarCompras" id="PublicarCompras" method="post">
			<input type="hidden" name="LIC_ID" VALUE="{/Mantenimiento/LICITACION/LIC_ID}"/>
			<!--<input type="hidden" name="IDCENTRO" VALUE="{/Mantenimiento/LICITACION/COMPRAPORCENTRO/IDCENTRO}"/>-->
			<!--<input type="hidden" name="LIC_PROV_IDPROVEEDOR" VALUE="{Mantenimiento/LICITACION/PRODUCTOSLICITACION/LIC_PROV_IDPROVEEDOR}"/>-->
			<input type="hidden" name="IDESTADO" VALUE="INF"/>
			<table class="buscador" id="lProductos_CENTRO">
			<thead>
				<xsl:choose>
				<xsl:when test="/Mantenimiento/LICITACION/AUTOR or /Mantenimiento/LICITACION/MULTICENTRO">
				<tr class="subTituloTabla">
					<td colspan="7" class="borderLeft">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="/Mantenimiento/LICITACION/CENTROSCOMPRAS/field"/>
							<xsl:with-param name="onChange">javascript:CargarDatosComprasCentro();</xsl:with-param>
						</xsl:call-template>
					</td>
				</tr>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="IDCENTROCOMPRAS" VALUE="{/Mantenimiento/LICITACION/COMPRAPORCENTRO/IDCENTRO}"/>
				</xsl:otherwise>
				</xsl:choose>
				<tr>
					<td class="uno">&nbsp;</td>
					<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></td>
					<!--<td class="zerouno"></td>
					<td class="zerouno">&nbsp;</td> columna iconos campos avanzados producto informados -->
					<td class="veinte" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></td>		
					<td class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></td>
					<td class="cuatro"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></td>
					<td class="uno">&nbsp;</td>
					<td class="uno">&nbsp;</td>
				</tr>
			</thead>

			<!-- Aqui dentro se informara el cuerpo de la tabla via javascript -->
			<tbody></tbody>

        	</table>
		</form>
		<tr class="sinLinea"><td>&nbsp;</td></tr>

		<!--	8mar17		INICIO	Carga de cantidades desde Excel	-->
		<tr id="TblRefProductosCant"><td colspan="4">
			<table class="infoTable divLeft incidencias" border="0" cellspacing="5">
			<form id="RefProductosCant" name="RefProductosCant" method="post">
				<tr>
					<td class="veinte">&nbsp;</td>
					<td colspan="2" class="datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_nuevo_poducto_X_ref_licitaciones']/node()"/>:
						<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/>:
						<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/>
					</td>
					<td class="veinte">
						<a class="btnDestacado"  id="idGuardarTodasCantidades" style="display:none;" href="javascript:guardarTodosDatosCompraAjax(0);">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/>
						</a>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td class="labelRight quince grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencias']/node()"/>:</td>
					<td class="quince datosLeft">
						<textarea name="LIC_LISTA_REFPRODUCTO_CANT" id="LIC_LISTA_REFPRODUCTO_CANT" cols="50" rows="15"/>
					</td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;</td>
					<td>
						<a id="EnviarProductosCantPorRef" class="btnDestacado" href="javascript:ValidarFormulario(document.forms['RefProductosCant'],'productosCant');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_referencia']/node()"/>
						</a>
						<div id="idEstadoEnvio" style="display:none;"/>
					</td>
					<td>&nbsp;</td>
				</tr>
			</form>
			</table>
		</td></tr>
		<!--	8mar17		FINAL	Carga de cantidades desde Excel	-->



	</xsl:when>
	<xsl:otherwise>
		<table class="buscador" id="lProductos_CENTRO">
		<thead>
			<tr>
				<td class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></td>
				<td class="trenta" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></td>
				<td class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/></td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/></td>
				<td class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='lic_marca']/node()"/></td>
				<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></td>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></td>
				<td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ud_por_lote_2line']/node()"/></td>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_objetivo_sIVA_2line']/node()"/></td>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></td>
				<td class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></td>
			<xsl:choose>
			<xsl:when test="/Mantenimiento/LICITACION/IDPAIS != '55'">
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/></td>
			</xsl:when>
			<xsl:otherwise>
				<td class="zerouno">&nbsp;</td>
                	</xsl:otherwise>
			</xsl:choose>
			</tr>
		</thead>
		<tbody>
			<tr><td colspan="12" align="center"><xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion_sin_productos']/node()"/></td></tr>
		</tbody>
		</table>
	</xsl:otherwise>
	</xsl:choose>


<xsl:if test="/Mantenimiento/LICITACION/LICITACION_AGREGADA">
	<!-- div flotante para mostrar info historica de centros -->
	<div class="overlay-container" id="infoHistoricaCentros">
		<div class="window-container zoomout">
			<p><a href="javascript:showTabla(false);"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a></p>

			<p id="tableTitle"></p>

			<div id="mensError" class="divLeft" style="display:none;">
				<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></strong></p>
			</div>

			<table id="datosCentros" style="width:100%;">
			<thead>
				<tr><th colspan="4">&nbsp;</th></tr>
				<tr>
					<th class="cinco">&nbsp;</th>
					<th class="" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
					<th class="veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_anual']/node()"/></th>
					<th class="cinco">&nbsp;</th>
				</tr>
			</thead>

			<tbody></tbody>

			</table>
		</div>
	</div>
	<!-- FIN div flotante -->
</xsl:if>

</div>
</xsl:template>
<!-- FIN Tabla Productos Centro -->



<!-- Tabla Productos Compacta -->
<xsl:template name="Tabla_Productos_Compacto">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:value-of select="/Mantenimiento/LANG"/>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->


<div id="divProductosCompacto" class="tablaProductosCompacta" style="display:none;clear:both;">
	<div id="gridProductosCompacto">
		<table id="compactaTable">
			<thead>
				<tr>
					<th><span id="compactaHdr0">&nbsp;</span></th>
					<th><span id="compactaHdr1">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>&nbsp;</span></th>
					<th><span id="compactaHdr2">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>&nbsp;</span></th>

				<xsl:choose>
				<xsl:when test="not(/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA)">
					<th class="num"><span id="compactaHdr3">&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_historico_sIVA_abr_2line']/node()"/>&nbsp;</span></th>
					<th class="num"><span id="compactaHdr4">&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_objetivo_sIVA_abr_2line']/node()"/>&nbsp;</span></th>
					<th class="num"><span id="compactaHdr5">&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_sIVA_2line']/node()"/>&nbsp;</span></th>
				</xsl:when>
				<xsl:otherwise>
					<th class="num"><span id="compactaHdr3">&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_historico_cIVA_abr_2line']/node()"/>&nbsp;</span></th>
					<th class="num"><span id="compactaHdr4">&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_objetivo_cIVA_abr_2line']/node()"/>&nbsp;</span></th>
					<th class="num"><span id="compactaHdr5">&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_cIVA_2line']/node()"/>&nbsp;</span></th>
				</xsl:otherwise>
				</xsl:choose>

				<xsl:for-each select="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PROVEEDORESLICITACION/PROVEEDOR">
					<xsl:variable name="contador"><xsl:value-of select="COLUMNA + 5"/></xsl:variable>
					<th><span id="compactaHdr{$contador}"><xsl:value-of select="NOMBRECORTO"/></span></th>
				</xsl:for-each>
				</tr>
			</thead>

			<tbody>

			<xsl:for-each select="/Mantenimiento/LICITACION/PRODUCTOSLICITACION/PRODUCTO">
				<tr>
					<td><xsl:value-of select="LINEA"/></td>
					<td class="txt">
						<xsl:choose>
						<xsl:when test="LIC_PROD_REFCLIENTE != ''">
							<xsl:value-of select="LIC_PROD_REFCLIENTE"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="LIC_PROD_REFESTANDAR"/>
						</xsl:otherwise>
						</xsl:choose>
					</td>
					<td class="txt"><xsl:value-of select="LIC_PROD_NOMBRE"/></td>

				<xsl:choose>
				<xsl:when test="not(/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA)">
					<td><xsl:value-of select="LIC_PROD_PRECIOREFERENCIA"/></td>
					<td><xsl:value-of select="LIC_PROD_PRECIOOBJETIVO"/></td>
					<td><xsl:value-of select="LIC_PROD_CONSUMO"/></td>
				</xsl:when>
				<xsl:otherwise>
					<td><xsl:value-of select="LIC_PROD_PRECIOREFERENCIAIVA"/></td>
					<td><xsl:value-of select="LIC_PROD_PRECIOOBJETIVOIVA"/></td>
					<td><xsl:value-of select="LIC_PROD_CONSUMOIVA"/></td>
				</xsl:otherwise>
				</xsl:choose>

				<xsl:for-each select="OFERTA">
					<td class="blanco">
						<xsl:choose>
						<xsl:when test="NO_INFORMADA">
							<!-- DC - 22/09/14 - Edaurrdo prefiere mostrar solo un guion (-)
							<xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_no_informada']/node()"/>
							-->
							<xsl:text>&nbsp;-&nbsp;</xsl:text>
						</xsl:when>
						<xsl:when test="LIC_OFE_PRECIOIVA = '0,0000' and LIC_OFE_UNIDADESPORLOTE = '0,00'">
							<!-- DC - 22/09/14 - Eduardo prefiere mostrar solo un guion (-)
							<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_ofertar']/node()"/>
							-->
							<xsl:text>&nbsp;-&nbsp;</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
							<xsl:when test="not(/Mantenimiento/LICITACION/MOSTRAR_PRECIO_IVA)">
								<xsl:value-of select="LIC_OFE_PRECIO"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="LIC_OFE_PRECIOIVA"/>
							</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
						</xsl:choose>
                                        </td>
				</xsl:for-each>

                                </tr>
			</xsl:for-each>
			</tbody>
                </table>
        </div>
</div>
<xsl:text disable-output-escaping="yes">
<![CDATA[
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/Grid.301214.js"></script>
	<script type="text/javascript">
		function generaTablaCompacta(){
			if(jQuery('div.g_Base').length === 0){
				(function(window, document, undefined) {
					"use strict";

					var gridColSortTypes = ["number", "string", "string", "number", "number", "number",
]]>
</xsl:text>
					<xsl:for-each select="/Mantenimiento/LICITACION/PROVEEDORESLICITACION/PROVEEDOR">
						<xsl:text>"number"</xsl:text>
						<xsl:if test="position() != last()">
							<xsl:text>,</xsl:text>
						</xsl:if>
					</xsl:for-each>
<xsl:text disable-output-escaping="yes">
<![CDATA[
					];
					var gridColAlign = [];

					var onColumnSort = function(newIndexOrder, columnIndex, lastColumnIndex) {
						var offset = (this.options.allowSelections && this.options.showSelectionColumn) ? 1 : 0,
						    doc = document;

						if (columnIndex !== lastColumnIndex) {
							if (lastColumnIndex > -1) {
								doc.getElementById("compactaHdr" + (lastColumnIndex - offset)).parentNode.style.backgroundColor = "";
							}
							doc.getElementById("compactaHdr" + (columnIndex - offset)).parentNode.style.backgroundColor = "#f7f7f7";
						}
					};

					var onResizeGrid = function(newWidth, newHeight) {
						var demoDivStyle = document.getElementById("divProductosCompacto").style;
						demoDivStyle.width = newWidth + "px";
						demoDivStyle.height = newHeight + "px";
					};

					for (var i=0, col; col=gridColSortTypes[i]; i++) {
						gridColAlign[i] = (col === "number") ? "right" : "left";
					}

					var myGrid = new Grid("gridProductosCompacto", {
					    	srcType : "dom",
					    	srcData : "compactaTable",
					    	tableType : "compacta",
					    	allowGridResize : true,
					    	allowColumnResize : true,
					    	allowClientSideSorting : true,
					    	showSelectionColumn : true,
					    	onColumnSort : onColumnSort,
					    	onResizeGrid : onResizeGrid,
					    	colAlign : gridColAlign,
					    	colBGColors : ["#fafafa","#fafafa","#fafafa","#fafafa","#fafafa","#fafafa"],
					    	colSortTypes : gridColSortTypes,
					    	fixedCols : 6
					});
				})(this, this.document);
			}
		}
	</script>
]]>
</xsl:text>

<div class="tablaProductosCompacta divLeft" style="display:none;">
        <div class="divLeft" style="margin-top:20px">
		<table class="infoTable" border="0">
		<tfoot>
			<tr class="lejenda lineBorderBottom3" style="background:#E4E4E5;padding-top:3px;font-weight:bold;">
				<td colspan="4" class="datosLeft" style="padding:3px 0px 0px 20px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda']/node()"/>:</td>
			</tr>

                        <tr class="lineBorderBottom5">
                        <td class="tres datosLeft">
				<p>&nbsp;</p>
			</td>
			<td class="veinte datosLeft">
				<p>
					&nbsp;<span style="color:orange;font-weight:bold;height:3px;">1,0000</span>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_igual']/node()"/><br/>
					&nbsp;<span style="color:red;font-weight:bold;height:3px;">1,0000</span>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_superior']/node()"/><br/>
					&nbsp;<span style="color:green;font-weight:bold;height:3px;">1,0000</span>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_inferior']/node()"/><br/>
				</p>
			</td>
			<td class="cuarenta datosLeft">
				<p>&nbsp;</p>
			</td>
                        <td>&nbsp;</td>
                        </tr>


		</tfoot>
		</table>
                 <br /><br />
                </div>
</div>
</xsl:template>
<!-- FIN Tabla Productos Compacta -->

</xsl:stylesheet>
