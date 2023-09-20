<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Listado del cat�logo privado, incluye datos proveedor y precio
	ultima revision	ET 8may23 11:00 BuscadorCatPriv2022_100323.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>

<xsl:template match="/">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/FamiliasYProductos/LANG"><xsl:value-of select="/FamiliasYProductos/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Catalogo_privado']/node()"/>:&nbsp;<xsl:value-of select="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/EMPRESA"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>

	<script type="text/javascript">
		var errorFechaLimite	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_guardar_fecha']/node()"/>';
		var obliFechaLimite	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_limite_obli']/node()"/>';
	</script>

	<script type="text/javascript">
		var origen	= '<xsl:value-of select="/FamiliasYProductos/ORIGEN"/>';
		var type	= '<xsl:value-of select="/FamiliasYProductos/TYPE"/>';
	</script>

	<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/BuscadorCatPriv2022_100323.js"></script>
</head>

<body>
	<xsl:choose>
	
	<xsl:when test="FamiliasYProductos/SESION_CADUCADA"><xsl:apply-templates select="FamiliasYProductos/SESION_CADUCADA"/> </xsl:when>
	<xsl:when test="FamiliasYProductos/ROWSET/ROW/Sorry"><xsl:apply-templates select="FamiliasYProductos/ROWSET/ROW/Sorry"/></xsl:when>
	<xsl:otherwise>

		<!--idioma-->
		<xsl:variable name="lang"><xsl:value-of select="/FamiliasYProductos/LANG"/></xsl:variable>
		<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
		<!--idioma fin-->

		<!-- miramos si hay datos devueltos -->
		<xsl:choose>
		<xsl:when test="not(FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CATEGORIA)">
			<div class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='busqueda_sin_resultados']/node()"/></div>
		</xsl:when>
		<xsl:otherwise>

			<!--	Titulo de la pagina		-->
			<div class="ZonaTituloPagina">
				<p class="TituloPagina">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='resultados']/node()"/>:&nbsp;
					<xsl:value-of select="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/TOTAL_PRODUCTOSESTANDAR"/>&nbsp;
					<xsl:choose>
					<xsl:when test="/FamiliasYProductos/ORIGEN = 'CATCLIENTES'">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/>&nbsp;
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='productos_estandar']/node()"/>&nbsp;
					</xsl:otherwise>
					</xsl:choose>
       				&nbsp;
					<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ROL != 'VENDEDOR'">
						<span class="fuentePeq">
						<xsl:if test="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SOLO_PRODESTANDAR != 'S'">
							<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRARCATEGORIAS or (/FamiliasYProductos/ORIGEN = 'CATCLIENTES' and /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CATEGORIA/REFERENCIA != 'DEF')">
								<xsl:value-of select="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/TOTAL_CATEGORIAS"/>&nbsp;
								<xsl:value-of select="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NOMBRESNIVELES/NIVEL1"/>(s),&nbsp;
							</xsl:if>
							<xsl:value-of select="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/TOTAL_FAMILIAS"/>&nbsp;
							<xsl:value-of select="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NOMBRESNIVELES/NIVEL2"/>(s),&nbsp;
							<xsl:value-of select="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/TOTAL_SUBFAMILIAS"/>&nbsp;
							<xsl:value-of select="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NOMBRESNIVELES/NIVEL3"/>(s),&nbsp;
							<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRARGRUPOS">
								<xsl:value-of select="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/TOTAL_GRUPOS"/>&nbsp;
								<xsl:value-of select="/SFamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NOMBRESNIVELES/NIVEL4"/>(s)&nbsp;
							</xsl:if>
						</xsl:if>
						(<xsl:value-of select="document($doc)/translation/texts/item[@name='productos_estandar_vacios']/node()"/>:&nbsp;
						<xsl:value-of select="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/TOTAL_PRODUCTOSESTANDARVACIOS"/>)
						</span>
					</xsl:if>
					<span class="CompletarTitulo w300px">
						<!--	Botones	-->
						<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ANTERIOR">
							<a class="btnNormal" href="javascript:PaginaAnterior();"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
						</xsl:if>&nbsp;
						<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SIGUIENTE">
							<a class="btnNormal" href="javascript:PaginaSiguiente();"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
						</xsl:if>&nbsp;
					</span>
				</p>
			</div>
			<br/>

			<div id="pruebaDescarga">
				<!--	17ago16	Guardamos los campos en un formulario, más comodo para manejarlos-->
				<form action="BuscadorCatPriv2022.xsql" method="POST" name="form1">
				<table class="buscador">
				<thead>

        			<input type="hidden" name="IDCLIENTE" id="IDCLIENTE" value="{FamiliasYProductos/IDCLIENTE}"/>
        			<input type="hidden" name="IDINFORME" id="IDINFORME" value="{FamiliasYProductos/IDINFORME}"/>
        			<input type="hidden" name="IDCATEGORIA" id="IDCATEGORIA" value="{FamiliasYProductos/IDCATEGORIA}"/>
        			<input type="hidden" name="IDFAMILIA" id="IDFAMILIA" value="{FamiliasYProductos/IDFAMILIA}"/>
        			<input type="hidden" name="IDSUBFAMILIA" id="IDSUBFAMILIA" value="{FamiliasYProductos/IDSUBFAMILIA}"/>
        			<input type="hidden" name="IDPROVEEDOR" id="IDPROVEEDOR"  value="{FamiliasYProductos/IDPROVEEDOR}"/>
        			<input type="hidden" name="PRODUCTO" id="PRODUCTO" value="{FamiliasYProductos/PRODUCTO}"/>
        			<input type="hidden" name="PROVEEDOR" id="PROVEEDOR" value="{FamiliasYProductos/PROVEEDOR}"/>
        			<input type="hidden" name="IDCENTROCLIENTE" id="IDCENTROCLIENTE" value="{FamiliasYProductos/IDCENTROCLIENTE}"/>
        			<input type="hidden" name="SINUSAR" id="SINUSAR" value="{FamiliasYProductos/SINUSAR}"/>
        			<input type="hidden" name="ADJUDICADO" id="ADJUDICADO" value="{FamiliasYProductos/ADJUDICADO}"/>
        			<input type="hidden" name="MES" id="MES" value="{FamiliasYProductos/MES}"/>
        			<input type="hidden" name="ANNO" id="ANNO" value="{FamiliasYProductos/ANNO}"/>
        			<input type="hidden" name="TIPOFILTRO" id="TIPOFILTRO" value="{FamiliasYProductos/TIPOFILTRO}"/>
        			<input type="hidden" name="PRIMEROSPEDIDOS" id="PRIMEROSPEDIDOS" value="{FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/PRIMEROSPEDIDOS}"/>
        			<input type="hidden" name="CONCONSUMO" id="CONCONSUMO" value="{FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CONCONSUMO}"/>
        			<input type="hidden" name="SINCONSUMO" id="SINCONSUMO" value="{FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SINCONSUMORECIENTE}"/>
        			<input type="hidden" name="informarXCentro" id="informarXCentro" value="{FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/PORCENTRO}"/>
        			<input type="hidden" name="consumoMinimo" id="consumoMinimo" value="{FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/FILTROCONSUMO}"/>
        			<input type="hidden" name="PAGINA" id="PAGINA" value="{FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/PAGINA}"/>
        			<input type="hidden" name="ORDEN" id="ORDEN" value="{FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ORDEN}"/>
        			<input type="hidden" name="SOLO_PROD_ESTANDAR" id="SOLO_PROD_ESTANDAR" value="{FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SOLO_PRODESTANDAR}"/>
        			<input type="hidden" name="SOLO_REGULADOS" id="SOLO_REGULADOS" value="{FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SOLO_REGULADOS}"/>
        			<input type="hidden" name="SOLO_OPCION1" id="SOLO_OPCION1" value="{FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SOLO_OPCION1}"/>
        			<input type="hidden" name="SIN_STOCK" id="SIN_STOCK" value="{FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SIN_STOCK}"/>
        			<input type="hidden" name="PROV_BLOQUEADO" id="PROV_BLOQUEADO" value="{FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/PROV_BLOQUEADO}"/>

				<!--<tr class="select">-->
				<tr class="filtros">
				<td colspan="2" align="right">
					&nbsp;
					<!--<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ANTERIOR">
						<a href="javascript:PaginaAnterior();"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
					</xsl:if>-->
				</td>
				<td colspan="6">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='lineas_por_pagina']/node()"/>:&nbsp;
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="LINEASPORPAGINA"/>
						<xsl:with-param name="path" select="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/LINEASPORPAGINA/field"/>
						<xsl:with-param name="onChange">javascript:Buscar();</xsl:with-param>
					</xsl:call-template>&nbsp;&nbsp;&nbsp;
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='pagina']/node()"/>&nbsp;
					<xsl:value-of select="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/PAGINA_ACTUAL"/>&nbsp;
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
					<xsl:value-of select="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/TOTAL_PAGINAS"/>
				</td>
				<td colspan="4" align="left">
					&nbsp;
					<!--<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SIGUIENTE">
						<a href="javascript:PaginaSiguiente();"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
					</xsl:if>-->
				</td>
				</tr>
				</thead>
			</table>
			</form>
			<div class="tabela tabela_redonda">
			<table class="buscador">
				<thead class="cabecalho_tabela">
				<tr>
					<th class="w1px">&nbsp;</th>
                    <!--columna empresa solo para catalogo clientes-->
                    <xsl:choose>
                    <xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_EMPRESA or /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_CENTRO">
                        <th class="w80px"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>
                    </xsl:when>
                    <xsl:otherwise><th class="zerouno">&nbsp;</th></xsl:otherwise>
                    </xsl:choose>
					<th class="w80px textLeft"><a href="javascript:CambiarOrden('REF_MVM');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ref']/node()"/></a></th>
					<!--si cdc veo ref privada y ref cliente, si usuario normal veo ref cliente si informADA, SI NO REF-->
					<xsl:choose>
					<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NUEVO_MODELO">
						<th class="w1px"></th>
					</xsl:when>
					<xsl:when test="not(/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_REFCLIENTE)">
						<th class="w1px"></th>
					</xsl:when>
					<xsl:otherwise>
						<th class="seis textLeft">
							<a href="javascript:CambiarOrden('REF_CLIENTE');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>
							</a>
							<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CATALOGO_MULTIOPCION">
								<br/><xsl:value-of select="document($doc)/translation/texts/item[@name='Orden']/node()"/>
							</xsl:if>
						</th>
					</xsl:otherwise>
					</xsl:choose>
					<th class="textLeft"><a href="javascript:CambiarOrden('NOMBRE');"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a></th>
					<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_PRECIOREF or /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_PRECIOMAXIMO">
						<th class="w80px textLeft">
							<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_PRECIOREF">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ref']/node()"/>
								<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_PRECIOMAXIMO">
									<br/>
								</xsl:if>
							</xsl:if>
							<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_PRECIOMAXIMO">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_max']/node()"/>
							</xsl:if>
						</th>
					</xsl:if>
					<th class="w1px"></th>
					<th class="w100px textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
					<th class="w80px textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/></th>
					<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></th><!--10may22 marca de proveedor en lugar de marcas autorizadas-->
					<th>
						<xsl:attribute name="class">
							<xsl:choose>
							<xsl:when test="/FamiliasYProductos/ORIGEN = 'CATCLIENTES'">w100px</xsl:when>
							<xsl:otherwise>w60px</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>

						<xsl:choose>
						<xsl:when test="/FamiliasYProductos/ORIGEN = 'CATCLIENTES'">&nbsp;</xsl:when>
						<xsl:otherwise><xsl:copy-of select="document($doc)/translation/texts/item[@name='unidad_basica_2line']/node()"/></xsl:otherwise>
						</xsl:choose>
					</th>

					<th><!--precio-->
						<xsl:attribute name="class">
							<xsl:choose>
							<xsl:when test="/FamiliasYProductos/ORIGEN = 'CATCLIENTES' and /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NO_MOSTRAR_PRECIO">w1px</xsl:when>
							<xsl:otherwise>w100px</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
						<!--si es catalogo clientes no veo precio  cambio condiciones 24-11-2014 mc-->
						<xsl:choose>
						<xsl:when test="/FamiliasYProductos/ORIGEN = 'CATCLIENTES' and /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NO_MOSTRAR_PRECIO">&nbsp;</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
							<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NUEVO_MODELO"><!--gomosa-->
								<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_final_iva_incl']/node()"/>
							</xsl:when>
                            <xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_PRECIO_IVA"><!--optima-->
								<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_prov_iva_incl']/node()"/>
							</xsl:when>
							<xsl:otherwise><!--tipo asisa-->
								<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_prov_sin_iva_2line']/node()"/>
							</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
						</xsl:choose>
					</th>

					<th class="w140px">
						<xsl:choose>
						<xsl:when test="/FamiliasYProductos/ORIGEN = 'CATCLIENTES' or /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_PRECIO">
							&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='validez_precio']/node()"/>&nbsp;&nbsp;&nbsp;
						</xsl:when>
						<xsl:otherwise>
							<span class="font11"><xsl:value-of select="document($doc)/translation/texts/item[@name='validez_precio']/node()"/></span>
						</xsl:otherwise>
						</xsl:choose>
					</th>

				<xsl:choose>
				<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COMISION_MVM and /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NUEVO_MODELO">
					<th class="w80px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='comision_mvm_2line']/node()"/></th>
				</xsl:when>
				<xsl:otherwise>
					<th class="zerouno"></th>
				</xsl:otherwise>
				</xsl:choose>

				<!-- Margen -->
				<xsl:choose>
				<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CDC or /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ADMIN and /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NUEVO_MODELO">
					<th class="w80px"><xsl:value-of select="document($doc)/translation/texts/item[@name='margen']/node()"/></th>
				</xsl:when>
				<xsl:otherwise>
					<th class="zerouno"></th>
				</xsl:otherwise>
				</xsl:choose>

				<xsl:choose>
				<xsl:when test="/FamiliasYProductos/ADJUDICADO = 'S' and /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_CONSUMOS">
					<!-- Consumo ultimo anyo -->
					<th class="w80px">
						<xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_ultimo_anyo_2line']/node()"/>
					</th>
					<!-- Consumo reciente -->
					<th class="w80px">
						<xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_reciente_2line']/node()"/>
					</th>
				</xsl:when>
				<xsl:otherwise>
					<th colspan="2" class="zerouno">&nbsp;</th>
				</xsl:otherwise>
				</xsl:choose>

				</tr>
			</thead>

			<tbody class="corpo_tabela">
				<!--categoria productos-->
				<xsl:for-each select="FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CATEGORIA">
				<xsl:if test="(/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SOLO_PRODESTANDAR != 'S') and (./FAMILIA/SUBFAMILIA/GRUPO/PRODUCTOESTANDAR)">
				<tr	class="conhover">
                    <td class="color_status">&nbsp;</td>
                    <td>&nbsp;</td>
					<td class="textLeft bold">
						<xsl:value-of select="REFERENCIA"/>
					</td>
					<!--ref cliente si es usuario admin-->
					<td class="textLeft">
					<xsl:choose>
					<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NUEVO_MODELO">
						&nbsp;
					</xsl:when>
					<xsl:when test="not(/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_REFCLIENTE)">
						&nbsp;
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="REFCLIENTE"/>
					</xsl:otherwise>
					</xsl:choose>
					</td>
					<td colspan="13" class="textLeft">
						<a href="javascript:EjecutarFuncionDelFrame('zonaCatalogo','CambioCategoriaActual({/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/IDEMPRESA},{ID},\'CAMBIOCATEGORIA\');');" style="color:#666666; font-size:13px;">
							<xsl:value-of select="NOMBRE"/>
						</a>&nbsp;
						<a href="javascript:nuevaBusqueda({ID});" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/modificarLente.gif" alt="" title=""/></a>
					</td>
				</tr>
				</xsl:if>

				<!--familia productos-->
				<xsl:for-each select="./FAMILIA">
				<xsl:if test="(/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SOLO_PRODESTANDAR != 'S') and (./SUBFAMILIA/GRUPO/PRODUCTOESTANDAR)">
				<tr class="conhover">
                    <xsl:attribute name="class">
						<xsl:choose>
                        <xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SOLO_PRODESTANDAR = 'S'">familia oculta</xsl:when>
						<xsl:otherwise>familia oculta</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
                    <td class="color_status">&nbsp;</td>
                                    
                    <!--columna centro cliente solo para buscador clientes-->
                    <td>&nbsp;</td>
                                        
					<td class="bold textLeft">
						<xsl:value-of select="REFERENCIA"/>
					</td>
					<td>

					<xsl:choose>
					<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NUEVO_MODELO">
						&nbsp;
					</xsl:when>
					<xsl:when test="not(/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_REFCLIENTE)">
						&nbsp;
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="REFCLIENTE"/>
					</xsl:otherwise>
					</xsl:choose>
					</td>
					<td colspan="13" class="textLeft">
						<a href="javascript:CambioFamiliaActual({/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/IDEMPRESA},{ID});" style="color:#666666; font-size:13px;">
							<xsl:value-of select="NOMBRE"/>
						</a>&nbsp;
						<a href="javascript:nuevaBusqueda({../ID},{ID});" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/modificarLente.gif" alt="" title=""/></a>
					</td>
				</tr>
				</xsl:if>

				<xsl:for-each select="./SUBFAMILIA">
				<xsl:if test="(/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SOLO_PRODESTANDAR != 'S') and (./GRUPO/PRODUCTOESTANDAR)">
				<tr class="conhover">
                   <xsl:attribute name="class">
						<xsl:choose>
                       <xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SOLO_PRODESTANDAR = 'S'">subFamilia oculta</xsl:when>
						<xsl:otherwise>subFamilia oculta</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
                    <td class="color_status">&nbsp;</td>
                    <!--columna centro cliente solo para buscador clientes-->
                    <td>&nbsp;</td>
					<td class="bold textLeft">
						<xsl:value-of select="REFERENCIA"/>
					</td>
					<td class="textLeft">

					<xsl:choose>
					<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NUEVO_MODELO">
						&nbsp;
					</xsl:when>
					<xsl:when test="not(/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_REFCLIENTE)">
						&nbsp;
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="REFCLIENTE"/>
					</xsl:otherwise>
					</xsl:choose>
					</td>
					<td colspan="13" class="textLeft">
						<a href="javascript:CambioSubfamiliaActual({/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/IDEMPRESA},{ID});" style="color:#666666; font-size:13px;">
							<xsl:value-of select="NOMBRE"/>
						</a>&nbsp;
						<a href="javascript:nuevaBusqueda({../../ID},{../ID},{ID});" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/modificarLente.gif" alt="" title=""/></a>
						<xsl:if test="(//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ADMIN or //FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CDC) and not(//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRARGRUPOS)">
							&nbsp;[<xsl:value-of select="document($doc)/translation/texts/item[@name='ultima_ref_utilizada']/node()"/>:&nbsp;<xsl:value-of select="GRUPO/REFESTANDARMAX"/>]
						</xsl:if>
					</td>
				</tr>
				</xsl:if>

				<xsl:for-each select="./GRUPO">
				<xsl:if test="(/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SOLO_PRODESTANDAR != 'S') and (./PRODUCTOESTANDAR)">
				<tr class="conhover">
					<xsl:attribute name="class">
						<xsl:choose>
                        <xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SOLO_PRODESTANDAR = 'S'">grupo oculta</xsl:when>
						<xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NOMBRESNIVELES/@MostrarGrupo = 'S'">grupo</xsl:when>
<!--						<xsl:when test="/FamiliasYProductos/ORIGEN = 'CATCLIENTES' and REFERENCIA != ''">grupo</xsl:when>-->
						<xsl:otherwise>grupo oculta</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
                    <td class="color_status">&nbsp;</td>
                   <!--columna centro cliente solo para buscador clientes-->
                   	<td>&nbsp;</td>
                                        
					<td class="bold textLeft">
						<xsl:value-of select="REFERENCIA"/>
					</td>
					<td class="textLeft">

					<xsl:choose>
					<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NUEVO_MODELO">
						&nbsp;
					</xsl:when>
					<xsl:when test="not(/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_REFCLIENTE)">
						&nbsp;
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="REFCLIENTE"/>
					</xsl:otherwise>
					</xsl:choose>
					</td>
					<td colspan="13" class="textLeft">
						<!--<a href="javascript:EjecutarFuncionDelFrame('zonaCatalogo','CambioGrupoActual({/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/IDEMPRESA},{ID},\'CAMBIOGRUPO\');');" style="color:#666666; font-size:13px;">-->
						<a href="javascript:CambioGrupoActual({/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/IDEMPRESA},{ID});" style="color:#666666; font-size:13px;">
							<xsl:value-of select="NOMBRE"/>
						</a>&nbsp;
						<a href="javascript:nuevaBusqueda({../../../ID},{../../ID},{../ID},{ID});" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/modificarLente.gif" alt="" title=""/></a>
						<xsl:if test="(//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ADMIN or //FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CDC) and //FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRARGRUPOS">
							&nbsp;[<xsl:value-of select="document($doc)/translation/texts/item[@name='ultima_ref_utilizada']/node()"/>:&nbsp;<xsl:value-of select="REFESTANDARMAX"/>]
						</xsl:if>
					</td>
				</tr>
				</xsl:if>

				<!-- productos   -->
				<xsl:for-each select="./PRODUCTOESTANDAR">
					<xsl:if test="((count(PROVEEDOR) = 0))
					or ((count(PROVEEDOR) &gt; 0) and /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/SINUSAR != 'S')
					or (/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/TODOSPRODUCTOS='S')">

						<!--Mostrar productos no adjudic solo si es mvm, si no solo los adjudicados-->
						<xsl:choose>
						<xsl:when test="(count(PROVEEDOR) &gt; 0)"><!--and /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/TODOSPRODUCTOS!='S'-->
							<!-- mostramos todos los proveedores -->
							<xsl:if test="PROVEEDOR">
								<xsl:for-each select="PROVEEDOR">
								<tr class="conhover">
									<xsl:if test="../TRASPASADO">
										<xsl:attribute name="class">fondoRojo</xsl:attribute>
									</xsl:if>
         				           <td class="color_status">&nbsp;</td>
                                    <td><!--columna centro cliente solo para buscador clientes-->
                                    <xsl:choose>
                                        <xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_EMPRESA">
                                                <a href="javascript:FichaEmpresa({../IDCLIENTE});">
                                                    <xsl:value-of select="../CLIENTE" />
                                                </a>
                                        </xsl:when>
                                         <xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_CENTRO"><!--pinxado checkbox por centro-->
                                                <a href="javascript:FichaCentro({IDCENTRO});">
                                                    <xsl:value-of select="CENTRO" />
                                                </a>
                                        </xsl:when>
                                        <xsl:otherwise>&nbsp;</xsl:otherwise>
                                    </xsl:choose>
                                    </td>
                                    <!-- Referencia -->
									<td class="textLeft">
										<span class="bold">
                                        <xsl:choose>
										<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ROL = 'MVMi' or /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ADMIN or /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CDC">
											<a href="javascript:CatalogacionRapida({../ID})"><xsl:value-of select="../REFERENCIA"/></a>
											<!--<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducido.xsql?PRO_ID={IDPRODUCTO}&amp;EMP_ID={../IDCLIENTE}','Ficha Catalogación',100,80,0,-20);">
												<xsl:value-of select="../REFERENCIA"/>
                                            </a>-->
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="../REFERENCIA"/>
										</xsl:otherwise>
										</xsl:choose>
										<xsl:if test="SIN_PLANTILLAS"><span color="rojo">!!</span></xsl:if>
                                        </span>
                                        <!--si hay esta marca enseña centro, CAT PRIVADO-->
                                        <xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_NOMBRE_CENTRO">
                                            <br /><a href="javascript:FichaCentro({IDCENTRO});">
                                                <xsl:value-of select="CENTRO" />
                                            </a>
                                        </xsl:if>
									</td>
									<!-- Referencia Cliente -->
									<td class="textLeft celdaconverde">
											<xsl:choose>
											<xsl:when test="../REFCENTRO!=''">
												<xsl:value-of select="../REFCENTRO"/><xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CATALOGO_MULTIOPCION">-<xsl:value-of select="../ORDEN"/></xsl:if>
											</xsl:when>
											<xsl:when test="../REFCLIENTE != ''">
													<xsl:value-of select="../REFCLIENTE"/><xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CATALOGO_MULTIOPCION">-<xsl:value-of select="../ORDEN"/></xsl:if>
											</xsl:when>
											</xsl:choose>
									</td>
									<!-- Producto -->
									<td class="textLeft bold">
										<xsl:choose>
										<xsl:when test="/FamiliasYProductos/ORIGEN = 'CATCLIENTES'">
											<xsl:choose>
											<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ROL = 'MVMi'">
												<a href="javascript:FichaProducto({IDPRODUCTO},'',{../IDCLIENTE})">
													<xsl:value-of select="../NOMBRE"/>
												</a>
											</xsl:when>
											<xsl:otherwise>
												<xsl:if test="../REGULADO='S'"><span class="amarillo"><b>[REG]</b></span>&nbsp;</xsl:if><xsl:value-of select="../NOMBRE"/>
											</xsl:otherwise>
											</xsl:choose>
										</xsl:when>
										<xsl:when test="../ID!='' and /FamiliasYProductos/VENTANA!='NUEVA'">
											<xsl:if test="../REGULADO='S'"><span class="amarillo"><b>[REG]</b></span>&nbsp;</xsl:if><a href="javascript:ProdEstandar({/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/IDEMPRESA},{../ID})"><xsl:value-of select="../NOMBRE"/><xsl:if test="../PRINCIPIOACTIVO!=''">&nbsp;[<xsl:value-of select="../PRINCIPIOACTIVO"/>]</xsl:if></a>
										</xsl:when>
										<xsl:otherwise>
											<xsl:if test="../REGULADO='S'"><span class="amarillo"><b>[REG]</b></span>&nbsp;</xsl:if><xsl:value-of select="../NOMBRE"/><xsl:if test="../PRINCIPIOACTIVO!=''">&nbsp;[<xsl:value-of select="../PRINCIPIOACTIVO"/>]</xsl:if>
										</xsl:otherwise>
										</xsl:choose>
										<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CDC and /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/IDEMPRESA=19796">
											<span class="fuentePeq">[<xsl:value-of select="../UNIDADBASICA"/>]</span>
										</xsl:if>
									</td>
									<!--	10may22 Marcas aceptables -> sustituido por marca del producto	- ->
									<td class="textLeft bold">
										<xsl:value-of select="../MARCASACEPTABLES"/>
									</td>-->
									<!-- 17oct22 Precio Ref y precio max	-->
									<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_PRECIOREF or /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_PRECIOMAXIMO">
										<td class="w80px textLeft fuentePeq">
											<xsl:if test="../PRECIOREFERENCIA!=''">
												Ref:<xsl:value-of select="../PRECIOREFERENCIA"/>
												<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_PRECIOMAXIMO">
													<br/>
												</xsl:if>
											</xsl:if>
											<xsl:if test="../PRECIOMAXIMO!=''">
												Max:<xsl:value-of select="../PRECIOMAXIMO"/>
											</xsl:if>
										</td>
									</xsl:if>
									<!-- Proveedor y su referencia-->
									<td class="textLeft">
										<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CATALOGO_MULTIOPCION">
											<a href="javascript:Homologacion({../IDCLIENTE},'{../REFERENCIA}')">H</a>
										</xsl:if>
                                    </td>
									<xsl:choose>
									<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ROL != 'VENDEDOR'">
										<td class="textLeft">
											<a href="javascript:FichaEmpresa('{ID}');">
												<xsl:value-of select="NOMBRE"/>
											</a>
                                    	</td>
										<td class="textLeft">
											<a href="javascript:FichaProducto('{IDPRODUCTO}','','{../IDCLIENTE}');"><xsl:value-of select="REFERENCIA"/></a>
                                    	</td>
										<td class="textLeft">
											<xsl:value-of select="MARCA"/>
										</td>
									</xsl:when>
									<xsl:otherwise>
										<td class="textLeft">
											<xsl:value-of select="NOMBRE"/>
                                    	</td>
										<td class="textLeft">
											<xsl:value-of select="REFERENCIA"/>
                                    	</td>
										<td class="textLeft">
											<xsl:value-of select="MARCA"/>
										</td>
									</xsl:otherwise>
									</xsl:choose>
									<!-- Resto de campos -->
									<td>
                                     <xsl:choose>
                                      <xsl:when test="/FamiliasYProductos/ORIGEN = 'CATCLIENTES'">&nbsp;</xsl:when>
                                      <xsl:otherwise><xsl:value-of select="UNIDADBASICA"/></xsl:otherwise>
                                     </xsl:choose>
                                    </td>
                                    
                                    <!-- Precio -->
                                    <td>
                                        <xsl:choose>
                                        <xsl:when test="BARATO">
                                            <xsl:attribute name="style">color:green;</xsl:attribute>
                                        </xsl:when>
                                        <xsl:when test="CARO">
                                            <xsl:attribute name="style">color:red;</xsl:attribute>
                                        </xsl:when>
                                        <xsl:when test="IGUAL">
                                            <xsl:attribute name="style">color:blue;</xsl:attribute>
                                        </xsl:when>
                                        </xsl:choose>
                                        <xsl:choose>
										<xsl:when test="/FamiliasYProductos/ORIGEN = 'CATCLIENTES' and /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NO_MOSTRAR_PRECIO">&nbsp;</xsl:when>
										<xsl:otherwise>
											<xsl:choose>
											<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NUEVO_MODELO"><!--gomosa-->
												<xsl:choose>
                                				<xsl:when test="COSTE_TOTAL != ''"><xsl:value-of select="COSTE_TOTAL"/></xsl:when>
                                				<xsl:when test="PRECIOACTUAL_IVA != ''"><xsl:value-of select="PRECIOACTUAL_IVA"/></xsl:when>
                                				</xsl:choose>
											</xsl:when>
                            				<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_PRECIO_IVA"><!--optima-->
												<xsl:value-of select="PRECIOACTUAL_IVA"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_DIVISA">
													<xsl:value-of select="DIV_PREFIJO"/>&nbsp;
												</xsl:if>
												<xsl:value-of select="TRF_IMPORTE"/>&nbsp;
												<xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_DIVISA">
													<xsl:value-of select="DIV_SUFIJO"/>&nbsp;
												</xsl:if>
											</xsl:otherwise>
											</xsl:choose>
										</xsl:otherwise>
										</xsl:choose>
										<!-- 8dic22 Tipo IVA, en la linea inferior	-->
										<xsl:if test="TIPOIVA">
											<br/><span class="fuentePeq">(<xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/>:&nbsp;<xsl:value-of select="TIPOIVA"/>%)</span>
										</xsl:if>
										</td>
										<!-- Validez Precio -->
										<td>
											<img src="http://www.newco.dev.br/images/info.gif" class="static">
											<xsl:attribute name="title">
												<xsl:value-of select="document($doc)/translation/texts/item[@name='Fec_inic_tarifa']/node()"/>:&nbsp;<xsl:value-of select="TRF_FECHAINICIO"/>,<xsl:value-of select="document($doc)/translation/texts/item[@name='Fec_fin_tarifa']/node()"/>:&nbsp;<xsl:value-of select="TRF_FECHALIMITE"/>, <xsl:value-of select="document($doc)/translation/texts/item[@name='Doc_tarifa']/node()"/>:&nbsp;<xsl:value-of select="TRF_NOMBREDOCUMENTO"/>, <xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_negociacion']/node()"/>:&nbsp;<xsl:value-of select="TIPONEGOCIACION"/>
											</xsl:attribute>
											</img>&nbsp;
                        					<xsl:choose>
                        					<xsl:when test="/FamiliasYProductos/ORIGEN = 'CATCLIENTES' and not(/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODIFICAR_FECHA_OFERTA)">
                            					<xsl:value-of select="TRF_FECHALIMITE"/>
                        					</xsl:when>
                        					<xsl:otherwise>
												<xsl:choose>
												<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MODIFICAR_FECHA_OFERTA and ../IDOFERTA = ''">
                            						<input type="hidden" name="CLIENTE_ID" id="CLIENTE_ID_{IDPRODUCTO}" value="{/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/IDEMPRESA}"/>
                            						<input type="text" name="FECHA_CADUCIDAD" id="FECHA_CADUCIDAD_{IDPRODUCTO}" value="{TRF_FECHALIMITE}" class="campopesquisa w100px noinput"/>
                            						<a class="btnDiscreto" href="javascript:cambiaFecha({IDPRODUCTO});" id="ModificaFecha_{IDPRODUCTO}">M</a>
                            						<a class="btnDestacadoPeq" style="display:none;" href="javascript:actualizarFechaLimite({IDPRODUCTO});" id="EnviarFecha_{IDPRODUCTO}">
														<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
                            						</a>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="TRF_FECHALIMITE"/>&nbsp;
													<xsl:if test="../IDOFERTA!=''">
                            							<a class="btnDiscreto" href="javascript:verOferta({../IDOFERTA})">O</a>
													</xsl:if>
												</xsl:otherwise>
												</xsl:choose>
                    						</xsl:otherwise>
                    						</xsl:choose>
                        					<xsl:if test="IDFICHATECNICA">
                           						&nbsp;<a class="btnDiscreto" href="javascript:verOferta({IDFICHATECNICA})">FT</a>
											</xsl:if>
                						</td>
										<!-- Comision -->
										<xsl:choose>
										<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COMISION_MVM and /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NUEVO_MODELO">
											<td><xsl:value-of select="COMISIONMVM_PORC"/>%</td>
										</xsl:when>
										<xsl:otherwise><td class="zerouno"></td></xsl:otherwise>
										</xsl:choose>
										<!-- Margen -->
										<xsl:choose>
										<xsl:when test="(/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ADMIN or/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CDC) and /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NUEVO_MODELO">
											<td><xsl:value-of select="MARGEN"/></td>
										</xsl:when>
										<xsl:otherwise><td class="zerouno"></td></xsl:otherwise>
										</xsl:choose>

										<xsl:choose>
										<xsl:when test="/FamiliasYProductos/ADJUDICADO = 'S' and /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_CONSUMOS">
											<xsl:variable name="consumo"><xsl:value-of select="CONSUMO"/></xsl:variable>
											<xsl:variable name="consumo_reciente"><xsl:value-of select="CONSUMORECIENTE"/></xsl:variable>
											<!-- Consumo ultimo anyo -->
											<td>
                						   <xsl:variable name="refProd">
                        						<xsl:choose>
                            						<xsl:when test="../REFCLIENTE != ''"><xsl:value-of select="../REFCLIENTE"/></xsl:when>
                            						<xsl:otherwise><xsl:value-of select="../REFERENCIA"/></xsl:otherwise>
                        						</xsl:choose>
                    						</xsl:variable>

                            			<xsl:choose>
			<!--
                            			<xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_EMPRESA">
                                			<a href="javascript:MostrarEIS('COPedidosPorEmpEur','{../IDCLIENTE}','','{$refProd}','9999');">
                                			 <xsl:value-of select="$consumo"/>
                                			</a>
                            			</xsl:when>
			-->
                            			<xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_CENTRO">
                                			<a href="javascript:MostrarEIS('CO_Pedidos_Eur','{../IDCLIENTE}','{IDCENTRO}','{$refProd}','9999');">
                                    			<xsl:value-of select="$consumo"/>
                                			</a>
                            			</xsl:when>
                            			<xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_NOMBRE_CENTRO">
                                			 <a href="javascript:MostrarEIS('CO_Pedidos_Eur','{../IDCLIENTE}','{IDCENTRO}','{$refProd}','9999');">
                                			 <xsl:value-of select="$consumo"/>
                                			</a>
                            			</xsl:when>
                            			<xsl:otherwise>
                                			<a href="javascript:MostrarEIS('CO_Pedidos_Eur','{../IDCLIENTE}','{IDCENTRO}','{$refProd}','9999');">
                                			 <xsl:value-of select="$consumo"/>
                                			</a>
                            			</xsl:otherwise>
			<!--
                            			<xsl:otherwise><xsl:value-of select="$consumo"/></xsl:otherwise>
			-->
                        			</xsl:choose>
                                                                        
										</td>
										<!-- Consumo reciente -->
										<td>
											<xsl:value-of select="$consumo_reciente"/>
											<xsl:choose>
											<xsl:when test="$consumo_reciente = $consumo and $consumo &gt; 0">
												&nbsp;<img src="http://www.newco.dev.br/images/bolaVerde.gif"/>
											</xsl:when>
											<xsl:when test="$consumo_reciente = 0 and $consumo &gt; 0">
												&nbsp;<img src="http://www.newco.dev.br/images/bolaRoja.gif"/>
											</xsl:when>
											</xsl:choose>
										</td>
									</xsl:when>
									<xsl:otherwise>
										<td colspan="3">&nbsp;</td>
									</xsl:otherwise>
									</xsl:choose>
								</tr>
								</xsl:for-each>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
							<xsl:when test="PROVEEDOR">
								<xsl:for-each select="PROVEEDOR">
								<tr class="conhover">
									<xsl:if test="TRASPASADO">
										<xsl:attribute name="class">fondoRojo</xsl:attribute>
									</xsl:if>
              					 	<td class="color_status">&nbsp;</td>
                                    <td><!--columna centro cliente solo para buscador clientes-->
                                    <xsl:choose>
                                        <xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_EMPRESA">
                                                <a href="javascript:FichaEmpresa('{../IDCLIENTE}');">
                                                    <xsl:value-of select="../CLIENTE" />
                                                </a>
                                        </xsl:when>
                                         <xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_CENTRO"><!--pinxado checkbox por centro-->
                                                <a href="javascript:FichaCentro('{IDCENTRO}');">
                                                    <xsl:value-of select="CENTRO" />
                                                </a>
                                        </xsl:when>
                                        <xsl:otherwise>&nbsp;</xsl:otherwise>
                                    </xsl:choose>
                                    </td>
									<!-- Referencia -->
									<td class="textLeft bold">
										<xsl:value-of select="../REFERENCIA"/>
											<!--<xsl:value-of select="../REFERENCIA"/>-->
										<xsl:if test="SIN_PLANTILLAS"><span color="rojo">!!</span></xsl:if>
                                         <!--si hay esta marca enseña centro, CAT PRIVADO-->
                                        <xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_NOMBRE_CENTRO">
                                            <br /><a href="javascript:FichaCentro('{IDCENTRO}');">
                                                <xsl:value-of select="CENTRO" />
                                            </a>
                                        </xsl:if>
									</td>
									<!-- Referencia Cliente -->
									<td class="textLeft celdaconverde">
										<xsl:if test="../REFCLIENTE != ''">
											<xsl:value-of select="../REFCLIENTE"/>
										</xsl:if>
									</td>
									<!-- Producto -->
									<td class="textLeft bold">
										<xsl:choose>
										<xsl:when test="../ID!='' and /FamiliasYProductos/VENTANA!='NUEVA'">
											<a href="javascript:ProdEstandar({/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/IDEMPRESA},{../ID})">
												<xsl:value-of select="../NOMBRE"/><xsl:if test="../PRINCIPIOACTIVO!=''">&nbsp;[<xsl:value-of select="../PRINCIPIOACTIVO"/>]</xsl:if>
											</a>
										</xsl:when>
										<xsl:otherwise><xsl:value-of select="../NOMBRE"/><xsl:if test="../PRINCIPIOACTIVO!=''">&nbsp;[<xsl:value-of select="../PRINCIPIOACTIVO"/>]</xsl:if></xsl:otherwise>
										</xsl:choose>
									</td>
									<!-- Proveedor y su referencia -->
									<td class="textLeft">
										<xsl:choose>
										<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ROL != 'VENDEDOR'">
											<a href="javascript:FichaEmpresa('{ID}')">
												<xsl:value-of select="NOMBRE"/>
											</a>
											(<a href="javascript:FichaProducto('{IDPRODUCTO}','','{../IDCLIENTE}');"><xsl:value-of select="REFERENCIA"/></a>)
										</xsl:when>
										<xsl:otherwise>
											<!--<xsl:if test="NOMBRECORTO != ''">-->
											<xsl:value-of select="NOMBRE"/>&nbsp;(<xsl:value-of select="REFERENCIA"/>)
											<!--</xsl:if>-->
										</xsl:otherwise>
										</xsl:choose>
                                                                        </td>
									<!-- Resto de campos -->
									<td><xsl:value-of select="UNIDADBASICA"/></td>
									<!-- Precio -->
									<td>
										<!-- DC - 26may14 - Aplicamos colores a los precios cuando se trata de variantes de productos que tienen distinto precio -->
										<xsl:choose>
										<xsl:when test="BARATO">
    										<xsl:attribute name="style">color:green;</xsl:attribute>
										</xsl:when>
										<xsl:when test="CARO">
    										<xsl:attribute name="style">color:red;</xsl:attribute>
										</xsl:when>
										<xsl:when test="IGUAL">
    										<xsl:attribute name="style">color:blue;</xsl:attribute>
										</xsl:when>
										</xsl:choose>
										<xsl:choose>
										<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_PRECIO_IVA">
											<xsl:value-of select="PRECIOACTUAL_IVA"/>
										</xsl:when>
										<xsl:otherwise><xsl:value-of select="COSTE_TOTAL"/></xsl:otherwise>
										</xsl:choose>
									</td>
									<!-- Validez Precio -->
									<td class="font10"><xsl:value-of select="../FECHACADUCIDAD"/></td>
									<!-- Comision -->
									<xsl:choose>
									<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COMISION_MVM">
										<td><xsl:value-of select="COMISIONMVM_PORC"/>%</td>
									</xsl:when>
									<xsl:otherwise><td class="zerouno"></td></xsl:otherwise>
									</xsl:choose>
									<td colspan="2">&nbsp;</td>
								</tr>
								</xsl:for-each>
							</xsl:when>
							<xsl:otherwise>
								<tr class="conhover">
									<xsl:if test="TRASPASADO">
										<xsl:attribute name="class">fondoRojo</xsl:attribute>
									</xsl:if>
                    				<td class="color_status">&nbsp;</td>
                                	<td><!--columna centro cliente solo para buscador clientes-->
                                	<xsl:choose>
                                    	<xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_EMPRESA">
                                            	<a href="javascript:FichaEmpresa('{IDCLIENTE}');">
                                                	<xsl:value-of select="CLIENTE" />
                                            	</a>
                                    	</xsl:when>
                                    	 <xsl:when test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_CENTRO"><!--pinxado checkbox por centro-->
                                            	<a href="javascript:FichaCentro('{IDCENTRO}');">
                                                	<xsl:value-of select="CENTRO" />
                                            	</a>
                                    	</xsl:when>
                                    	<xsl:otherwise>&nbsp;</xsl:otherwise>
                                	</xsl:choose>
                                	</td>
									<!-- Referencia -->
									<td class="textLeft bold">
										<xsl:choose>
										<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ROL = 'MVMi'">
												<a href="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/CatalogacionRapida2022.xsql?IDPRODESTANDAR={ID}"><xsl:value-of select="REFERENCIA"/></a>
										</xsl:when>
										<xsl:otherwise>
                                            <!--si cdc o admin enlazo a precios historicos por centro-->
                                            <xsl:choose>
                                                <xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ADMIN or /FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/CDC">
													<a href="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/CatalogacionRapida2022.xsql?IDPRODESTANDAR={ID}"><xsl:value-of select="REFERENCIA"/></a>
                                                 <!--   <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/HistoricosCentros.xsql?ID_EMP={IDCLIENTE}&amp;ID_PROD_ESTANDAR={ID}','Centro',100,80,0,0);"><xsl:value-of select="REFERENCIA"/></a>-->
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="REFERENCIA"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
											
										</xsl:otherwise>
										</xsl:choose>

										<xsl:if test="SIN_PLANTILLAS"><span color="rojo">!!</span></xsl:if>
                                             <!--si hay esta marca enseña centro, CAT PRIVADO-->
                                            <xsl:if test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_NOMBRE_CENTRO">
                                                <br /><a href="javascript:FichaCentro('{IDCENTRO}');">
                                                    <xsl:value-of select="CENTRO" />
                                                </a>
                                            </xsl:if>
									</td>
									<!-- Referencia Cliente -->
									<td class="textLeft celdaconverde">
<!-- DC - 24/07/14 - No se mostraba Ref. Cliente en el catálogo clientes
										<xsl:if test="//FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/ADMIN_CDC and REFCLIENTE != ''">
											<xsl:value-of select="REFCLIENTE"/>
										</xsl:if>
-->
										<xsl:choose>
										<xsl:when test="/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/NUEVO_MODELO">
											&nbsp;
										</xsl:when>
										<xsl:when test="not(/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/MOSTRAR_COLUMNA_REFCLIENTE)">
											&nbsp;
										</xsl:when>
										<xsl:otherwise>
											<xsl:choose>
											<xsl:when test="REFCENTRO!=''">
												<xsl:value-of select="REFCENTRO"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="REFCLIENTE"/>
											</xsl:otherwise>
											</xsl:choose>
										</xsl:otherwise>
										</xsl:choose>
									</td>
									<!-- Producto -->
									<td class="textLeft bold">
										<a href="javascript:ProdEstandar({/FamiliasYProductos/LISTADO_FAMILIAS_Y_PRODUCTOS/IDEMPRESA},{ID})">
											<xsl:value-of select="NOMBRE"/><xsl:if test="PRINCIPIOACTIVO!=''">&nbsp;[<xsl:value-of select="PRINCIPIOACTIVO"/>]</xsl:if>
										</a>
										<xsl:if test="TRASPASADO">
											-> <xsl:value-of select="TRASPASADO/REFERENCIA"/>:&nbsp;<xsl:value-of select="TRASPASADO/NOMBRE"/>
										</xsl:if>
									</td>
									<!--	Marcas aceptables	-->
									<td class="textLeft bold">
										<xsl:value-of select="MARCASACEPTABLES"/>
									</td>
									<!-- Resto de campos -->
									<td colspan="9">&nbsp;</td>
								</tr>
							</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
						</xsl:choose>
					</xsl:if><!--fin de if antes de chooose-->
				</xsl:for-each><!--3 for each de inicio-->
				</xsl:for-each>
				</xsl:for-each>
				</xsl:for-each>
				</xsl:for-each>
			</tbody>
			<tfoot class="rodape_tabela">
				<tr><td colspan="17">&nbsp;</td></tr>
			</tfoot>
			</table><!--fin de grandeInicio-->
			<!--Sin los espacios, no se ve el final de la tabla-->
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
            </div>
            </div>
			<br /><br />
		</xsl:otherwise>
		</xsl:choose>
	</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
