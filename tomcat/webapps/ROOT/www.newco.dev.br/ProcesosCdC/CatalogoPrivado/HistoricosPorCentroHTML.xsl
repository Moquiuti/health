<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>

<xsl:template match="/HistoricosPorCentro">
<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='historicos_por_centro_de']/node()"/>&nbsp;<xsl:value-of select="HISTORICOPORCENTRO/EMPRESA"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.highlight-5.closure.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/HistoricosPorCentro.261015.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Utilidades/Utilidades.js"></script>

	<script type="text/javascript">
		var IDEmpresa	= '<xsl:value-of select="IDEMPRESA"/>';
		var isAdmin	= '<xsl:choose><xsl:when test="HISTORICOPORCENTRO/ADMIN">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		var AgruparPor	= 'REFESTANDAR';

		var val_faltaReferencia	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_referencia']/node()"/>';
		var val_maxReferencias	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='num_max_referencias']/node()"/>';

		var alrt_errorNuevosProductos	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_nuevos_productos']/node()"/>';

		var str_PagAnterior	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/>';
		var str_PagSiguiente	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/>';
		var str_Paginacion	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_paginacion']/node()"/>';

		var arrayCentros = new Array();
		<xsl:for-each select="HISTORICOPORCENTRO/CENTRO">
			var centro	= [];
			centro['ID']	= '<xsl:value-of select="ID"/>';
			centro['Nombre']= '<xsl:value-of select="NOMBRE"/>';
			arrayCentros.push(centro);
		</xsl:for-each>

		var arrayProdsEstandar = new Array();
		<xsl:for-each select="HISTORICOPORCENTRO/PRODUCTOESTANDAR">
			var producto	= [];
			producto['ID']		= '<xsl:value-of select="CP_PRO_ID"/>';
			producto['Referencia']	= '<xsl:value-of select="CP_PRO_REFERENCIA"/>';
			producto['RefCliente']	= '<xsl:value-of select="CP_PRO_REFCLIENTE"/>';
			producto['Nombre']	= '<xsl:value-of select="CP_PRO_NOMBRE"/>';
			producto['NombreNorm']	= '<xsl:value-of select="CP_PRO_NOMBRE_NORM"/>';
			producto['UdBasica']	= '<xsl:value-of select="CP_PRO_UDBASE"/>';
			producto['PrecioMedio']	= '<xsl:value-of select="CP_HCE_PRECIOMEDIO"/>';
			producto['PrecioMVM']	= '<xsl:value-of select="CP_HCE_PRECIOMVM"/>';
			producto['AhorroPorc']	= '<xsl:value-of select="CP_HCE_AHORROPORC"/>';
			producto['ConsAnual']	= '<xsl:value-of select="CP_HCE_CONSUMOANUAL"/>';
			producto['ConsPorc']	= '<xsl:value-of select="CP_HCE_CONSUMOPORC"/>';
			producto['Ahorro']	= '<xsl:value-of select="CP_HCE_AHORRO"/>';
			producto['Sospechoso']	= '<xsl:choose><xsl:when test="PRECIOSOSPECHOSO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
			producto['TxtBusqueda']	= '<xsl:value-of select="CAMPOBUSQUEDA"/>';
			producto['Texto']	= '0';

			producto['Centros']	= new Array();
			<xsl:for-each select="CENTRO">
				var centro	= [];
				centro['Columna']	= '<xsl:value-of select="COLUMNA"/>';
				centro['Proveedor']	= '<xsl:value-of select="PROVEEDOR"/>';
				centro['Precio']	= '<xsl:value-of select="PRECIO"/>';
				centro['CantidadAnual']	= '<xsl:value-of select="CANTIDADANUAL"/>';
				centro['ConsumoAnual']	= '<xsl:value-of select="CONSUMOANUAL"/>';
				centro['ConsumoPorc']	= '<xsl:value-of select="CONSUMOPORC"/>';
				centro['AhorroPorc']	= '<xsl:value-of select="AHORROPORC"/>';
				centro['Sospechoso']	= '<xsl:choose><xsl:when test="PRECIOSOSPECHOSO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
				producto['Centros'].push(centro);
			</xsl:for-each>

			arrayProdsEstandar.push(producto);
		</xsl:for-each>
	</script>
</head>
<body>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="divLeft">
		<h1 class="titlePage">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='historicos_por_centro_de']/node()"/>&nbsp;
			<xsl:value-of select="HISTORICOPORCENTRO/EMPRESA"/>&nbsp;
			<span class="importante">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='historicos_por_centro_precios_expli']/node()"/>
			</span>
		</h1>

		<table class="infoTable incidencias" cellspacing="5" border="0" style="border-bottom:2px solid #D7D8D7;">
			<tr>
				<td class="labelRight grisMed dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/>:</td>
				<td class="datosLeft dies"><strong><xsl:value-of select="HISTORICOPORCENTRO/CONSUMOTOTAL"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='euro']/node()"/></strong></td>
				<td class="labelRight grisMed dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/>:</td>
				<td class="datosLeft veinte"><strong><xsl:value-of select="HISTORICOPORCENTRO/AHORROTOTAL"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='euro']/node()"/>&nbsp;&nbsp;
					(<xsl:value-of select="HISTORICOPORCENTRO/AHORROPORC"/>)</strong>
				</td>
				<td class="labelRight grisMed quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='num_prod']/node()"/>:</td>
				<td class="datosLeft cinco"><strong><xsl:value-of select="HISTORICOPORCENTRO/NUMEROPRODUCTOS"/></strong></td>
				<td class="labelRight grisMed veintecinco">
					<img src="http://www.newco.dev.br/images/change.png" />&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='avisos_precios_sospechosos']/node()"/>:
				</td>
				<td class="datosLeft"><strong><xsl:value-of select="HISTORICOPORCENTRO/AVISOS"/></strong></td>
			</tr>
			<tr style="height:5px;"><td colspan="6"></td></tr>
		</table>

		<!--tabla buscador-->
		<table class="infoTable incidencias" border="0" cellspacing="5" cellpadding="5" style="border-bottom:2px solid #D7D8D7;">
			<tr style="height:5px;"><td colspan="6"></td></tr>
			<tr>
				<td class="labelRight grisMed doce"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_de_vista']/node()"/>:</td>
				<td class="datosLeft dies">
					<strong>
						<select id="TipoVista" name="TipoVista">
							<option value="SP"><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_precio']/node()"/></option>
							<option value="SC"><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_consumo']/node()"/></option>
							<option value="PC"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_y_consumo']/node()"/></option>
							<option value="PCA"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_consumo_y_ahorro']/node()"/></option>
						</select>
					</strong>
				</td>
				<td class="labelRight grisMed veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_porcentaje']/node()"/>:</td>
				<td class="datosLeft tres">
					<input type="checkbox" name="ConsPorcentual" id="ConsPorcentual"/>&nbsp;
				</td>
				<td class="labelRight grisMed veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='agregar_por']/node()"/>:</td>
				<td class="datosLeft">
					<strong>
					<xsl:if test="HISTORICOPORCENTRO/NOMBRESNIVELES/NIVEL2 != ''">
						<a href="javascript:AbrirHistoricosAgregados('FAMILIA');">
							<xsl:value-of select="HISTORICOPORCENTRO/NOMBRESNIVELES/NIVEL2"/>
						</a>
					</xsl:if>
					<xsl:if test="HISTORICOPORCENTRO/NOMBRESNIVELES/NIVEL3 != ''">
						|&nbsp;<a href="javascript:AbrirHistoricosAgregados('SUBFAMILIA');">
							<xsl:value-of select="HISTORICOPORCENTRO/NOMBRESNIVELES/NIVEL3"/>
						</a>
					</xsl:if>
					<xsl:if test="HISTORICOPORCENTRO/NOMBRESNIVELES[@MostrarGrupo] = 'S' and HISTORICOPORCENTRO/NOMBRESNIVELES/NIVEL4 != ''">
						|&nbsp;<a href="javascript:AbrirHistoricosAgregados('GRUPO');">
							<xsl:value-of select="HISTORICOPORCENTRO/NOMBRESNIVELES/NIVEL4"/>
						</a>
					</xsl:if>
						|&nbsp;<a href="javascript:AbrirHistoricosAgregados('REFESTANDAR');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_estandar']/node()"/>
						</a>
					</strong>
				</td>
			</tr>
			<tr style="height:5px;"><td colspan="6"></td></tr>
		</table><!--fin tabla buscador-->

		<table class="infoTable TblHistPorCentro" id="TblHistPorCentro" style="border-bottom:1px solid #999999;" border="0">
		<thead>
			<tr class="subTituloTabla leyendaPaginacion">
				<!-- Link a pagina anterior -->
				<td colspan="2" class="pagAnterior" style="text-align:left;padding-left:20px;"></td>
				<!-- Desplegable para numProductos y leyenda paginacion -->
				<td colspan="5" style="text-align:left;padding-left:20px;font-size:11px;">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='tamanyo_pagina']/node()"/>:&nbsp;
					<select name="numRegistros" class="numRegistros" style="font-size:11px;">
						<option value="10">10 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
						<option value="20" selected="selected">20 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
						<option value="50">50 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
						<option value="100">100 <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></option>
					</select>
					<span class="paginacion" style="margin-left:20px;"></span>
				</td>
				<!-- Link a pagina siguiente -->
				<td colspan="2" class="pagSiguiente" style="text-align:right;padding-right:20px;"></td>

			<!-- Nombres de Proveedores -->
			<xsl:for-each select="HISTORICOPORCENTRO/CENTRO">
				<td colspan="1" class="colNomCentro">&nbsp;</td>
			</xsl:for-each>
			</tr>

			<tr class="subTituloTabla">
				<td class="borderLeft" rowspan="2">
					<!-- Permitimos ordenacion -->
					<a href="javascript:Ordenacion('Referencia');" style="text-decoration:none;" class="anchorReferencia">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_mvm']/node()"/>
					</a>
					<span style="width:80px;height:1px;float:left;">&nbsp;</span>
				</td>
				<td class="borderLeft" style="padding:0 3px;" rowspan="2">
					<!-- Permitimos ordenacion -->
					<a href="javascript:Ordenacion('RefCliente');" style="text-decoration:none;" class="anchorRefCliente">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>
					</a>
					<span style="width:80px;height:1px;float:left;">&nbsp;</span>
				</td>
				<td class="borderLeft datosLeft" style="padding:0 3px;" rowspan="2">
					<!-- Permitimos ordenacion -->
					<a href="javascript:Ordenacion('Nombre');" style="text-decoration:none;" class="anchorNombre">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_estandar']/node()"/>
					</a>&nbsp;&nbsp;&nbsp;
					<input class="filtroProductos" id="FP_1" type="text" style="font-size:11px;width:200px;" name="filtroProductos"/>&nbsp;
					<a style="font-size:11px;text-decoration:none;" href="javascript:filtrarProductosBeforeAjax('FP_1');">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
					</a>
					<span style="width:400px;height:1px;float:left;">&nbsp;</span>
				</td>
				<td class="borderLeft" style="padding:0 3px;" rowspan="2">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>
					<span style="width:70px;height:1px;float:left;">&nbsp;</span>
				</td>
				<td class="borderLeft" style="padding:0 3px;" rowspan="2">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_medio']/node()"/>
					<span style="width:60px;height:1px;float:left;">&nbsp;</span>
				</td>
				<td class="borderLeft" style="padding:0 3px;" rowspan="2">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_mvm']/node()"/>
					<span style="width:60px;height:1px;float:left;">&nbsp;</span>
				</td>
				<td class="borderLeft" style="padding:0 3px;" rowspan="2">
					<!-- Permitimos ordenacion -->
					<a href="javascript:Ordenacion('AhorroPorc');" style="text-decoration:none;" class="anchorAhorroPorc">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/><br />(%)
					</a>
					<span style="width:50px;height:1px;float:left;">&nbsp;</span>
				</td>
				<td class="borderLeft" style="padding:0 3px;" rowspan="2">
					<!-- Permitimos ordenacion -->
					<a href="javascript:Ordenacion('ConsAnual');" style="text-decoration:none;" class="anchorConsAnual">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='total_compras']/node()"/>
					</a>
					<span style="width:75px;height:1px;float:left;">&nbsp;</span>
				</td>
				<td class="borderLeft" style="padding:0 3px;" rowspan="2">
					<!-- Permitimos ordenacion -->
					<a href="javascript:Ordenacion('Ahorro');" style="text-decoration:none;" class="anchorAhorro">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/>
					</a>
					<span style="width:60px;height:1px;float:left;">&nbsp;</span>
				</td>

			<!-- Nombres de Centros -->
			<xsl:for-each select="HISTORICOPORCENTRO/CENTRO">
				<td colspan="1" class="borderLeft colNomCentro" style="text-align:center;padding:0 3px;">
					<a href="javascript:AbrirFichaCentro({ID});" style="text-decoration:none;">
						<xsl:value-of select="NOMBRE"/>
					</a>
					<span style="width:100px;height:1px;float:left;">&nbsp;</span>
				</td>
			</xsl:for-each>
			</tr>

			<!-- Columnas de centros -->
			<tr class="subTituloTabla">
			<xsl:for-each select="HISTORICOPORCENTRO/CENTRO">
				<td class="borderLeft colPrecio" style="padding:0 3px;">
					<!-- Permitimos ordenacion -->
					<a href="javascript:Ordenacion('PrecioCentro_{COLUMNA}');" style="text-decoration:none;" class="anchorPrecioCentro_{COLUMNA}">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>
					</a>
				</td>
				<td class="borderLeft colConsumo" style="padding:0 3px;display:none;">
					<!-- Permitimos ordenacion -->
					<a href="javascript:Ordenacion('ConsumoCentro_{COLUMNA}');" style="text-decoration:none;" class="anchorConsumoCentro_{COLUMNA}">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/>
					</a>
				</td>
				<td class="borderLeft colAhorro" style="padding:0 3px;display:none;">
					<!-- Permitimos ordenacion -->
					<a href="javascript:Ordenacion('AhorroCentro_{COLUMNA}');" style="text-decoration:none;" class="anchoAhorroCentro_{COLUMNA}">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/>
					</a>
				</td>
			</xsl:for-each>
			</tr>
		</thead>

		<tbody></tbody>

		<tfoot>
			<tr style="border-top:2px solid #999;height:40px;">
				<td colspan="6" class="borderLeft datosRight" style="font-size:14px;padding:0 3px;">
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:</strong>
				</td>
				<td class="borderLeft datosRight" style="padding:0 3px;">
					<strong><xsl:value-of select="HISTORICOPORCENTRO/AHORROPORC"/></strong>
				</td>
				<td class="borderLeft datosRight" style="padding:0 3px;">
					<strong><xsl:value-of select="HISTORICOPORCENTRO/CONSUMOTOTAL"/></strong>
				</td>
				<td class="borderLeft datosRight" style="padding:0 3px;">
					<strong><xsl:value-of select="HISTORICOPORCENTRO/AHORROTOTAL"/></strong>
				</td>

			<xsl:for-each select="HISTORICOPORCENTRO/TOTALES/CENTRO">
				<td class="borderLeft datosRight colPrecio" style="padding:0 3px;">&nbsp;</td>
				<td class="borderLeft datosRight colConsumo" style="padding:0 3px;display:none;">
					<strong><xsl:value-of select="CANTIDADANUAL"/></strong>
				</td>
				<td class="borderLeft datosRight colAhorro" style="padding:0 3px;display:none;">&nbsp;</td>
			</xsl:for-each>
			</tr>
		</tfoot>
		</table>

	<xsl:if test="HISTORICOPORCENTRO/ADMIN">
		<!-- Formulario para introducir nuevas referencias -->
		<form id="NuevasRefs" name="NuevasRefs" method="post">
		<table class="infoTable divLeft incidencias" border="0" cellspacing="5">
			<tr>
				<td class="veinte">&nbsp;</td>
				<td colspan="3" class="datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_nuevo_poducto_X_ref_licitaciones']/node()"/></td>
			</tr>

			<tr>
				<td>&nbsp;</td>
				<td class="labelRight quince grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencias']/node()"/>:</td>
				<td class="quince datosLeft">
					<textarea name="LISTA_REFS" id="LISTA_REFS" cols="25" rows="15"/>
				</td>
				<td class="datosLeft" style="padding-left:5px;">
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoPrivadoProductoEmpresa.xsql?IDEMPRESA={IDEMPRESA}','Catálogo Privado',50,80,90,20);">
					<xsl:choose>
					<xsl:when test="LANG = 'spanish'">
						<img src="http://www.newco.dev.br/images/abrirCatalogo.gif" alt="Abrir catálogo"/>
					</xsl:when>
					<xsl:otherwise>
						<img src="http://www.newco.dev.br/images/abrirCatalogo-BR.gif" alt="Catálogo aberto"/>
					</xsl:otherwise>
					</xsl:choose>
					</a>
				</td>
			</tr>

			<tr>
				<td colspan="2">&nbsp;</td>
				<td>
					<div class="boton" id="AnadirRefs">
						<a href="javascript:AnadirReferencias();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_referencia']/node()"/>
						</a>
					</div>
				</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		</form>
	</xsl:if>
		<!-- Formulario para introducir nuevas referencias -->
	</div>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
