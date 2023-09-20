<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Nueva licitacion. Creado a partir de MantLicitacion
	Actualizacion javascript NuevaLicV2_2022_220323.js
	Ultima revision: ET 15jul22 09:30
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:import href="http://www.newco.dev.br/Gestion/Comercial/LicGeneralTemplates2022.xsl"/>

<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:param name="usuario" select="@US_ID"/>

<xsl:template match="/">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<meta http-equiv="Cache-Control" content="no-cache"/>

	<title>
	<xsl:value-of select="/Mantenimiento/NUEVALICITACION/EMPRESALICITACION/NOMBRE"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_licitacion']/node()"/>
	</title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script><!--	16nov17	para abrir fichero excel	-->

	<script type="text/javascript">
		var lang		= '<xsl:value-of select="/Mantenimiento/LANG"/>';
		var IDUsuario		= '<xsl:value-of select="/Mantenimiento/US_ID"/>';
		var filtroNombre	= '';
		var sepCSV			=';';		//21feb18
		var sepTextoCSV		='';		//21feb18
		var saltoLineaCSV	='\r\n';	//21feb18

    <!-- Variables y Strings JS para las etiquetas -->
		var IDRegistro = '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_ID"/>';
		var fechaDecisionLic = '<xsl:value-of select="/Mantenimiento/LICITACION/LIC_FECHADECISIONPREVISTA"/>';		//	25abr17	
		var IDTipo = 'LIC';
		var str_NuevaEtiquetaGuardada	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta_guardada']/node()"/>';
		var str_NuevaEtiquetaError		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta_error']/node()"/>';
		var str_autor			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/>';
		var str_fecha			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>';
		var str_etiqueta	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='etiqueta']/node()"/>';
		var str_borrar		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>';
		<!-- FIN Variables y Strings JS para las etiquetas -->

    <xsl:choose>
		<xsl:when test='/Mantenimiento/LICITACION/COMPLETAR_COMPRA_CENTRO'>
		var completarCompraCentro = 'S';
		</xsl:when>
		<xsl:otherwise>
		var completarCompraCentro = 'N';
		</xsl:otherwise>
    </xsl:choose>

	var mesesSelected	= '<xsl:value-of select="/Mantenimiento/NUEVALICITACION/LIC_MESESDURACION"/>';
	var estadoLicitacion	= 'EST';
	var rol			= 'COMPRADOR';
	var isAutor		= 'S';
	var isLicAgregada	='N';	//	15set16 Valor por defecto, sino falla el cambio de meses
	var numProveedoresActivos=0;	// 22set16 Valor por defecto
	var IDPais		= '<xsl:value-of select="/Mantenimiento/NUEVALICITACION/IDPAIS"/>';
	var listaSelecciones ='';

	var str_Selecciona		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='selecciona']/node()"/>';
	
	<!-- Mensajes JS para validacion de formularios -->
	<!-- Condiciones de la licitacion -->
	var val_faltaTitulo		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_titulo']/node()"/>';
	var val_faltaFechaDecision	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_fecha_decision']/node()"/>';
	var val_malFechaDecision	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_fecha_decision']/node()"/>';
	var val_malFechaPedidoLic	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_fecha_pedido_lic']/node()"/>';
	var val_FechaDecisionAntigua= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision_antigua']/node()"/>';
	var val_FechaPedidoAntigua= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_pedido_antigua']/node()"/>';
	var val_faltaDescripcion	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_descripcion']/node()"/>';
	var val_faltaCondEntr		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_condiciones_entrega']/node()"/>';
	var val_faltaCondPago		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_condiciones_pago']/node()"/>';
	var val_faltaFechaRealAdj	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_fecha_real_adj']/node()"/>';
	var val_malFechaRealAdj		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_fecha_real_adj']/node()"/>';
	var val_faltaFechaRealCad	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_fecha_real_cad']/node()"/>';
	var val_malFechaRealCad		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_fecha_real_cad']/node()"/>';
	var conf_SalirDatosGenLic	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='seguro_salir_datos_gen_licitacion']/node()"/>';
	var val_malFechaAdjudic		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='valor_malo_fecha_adjudicacion']/node()"/>';
	var val_malFechaAdjudic2	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_adjudicacion_posterior_fecha_decision_obli']/node()"/>';
	</script>

	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/NuevaLicV2_2022_220323.js"></script>
</head>

<body onload="onloadEvents();">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
	<xsl:choose>
		<xsl:when test="//SESION_CADUCADA">
			<xsl:apply-templates select="//SESION_CADUCADA"/>
		</xsl:when>
		<xsl:when test="//Sorry">
			<xsl:apply-templates select="//Sorry"/>
		</xsl:when>
		<xsl:otherwise>
			<!--	Titulo de la página		-->
			<div class="ZonaTituloPagina">
				<p class="TituloPagina">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_licitacion']/node()"/>
					&nbsp;&nbsp;
					<span class="CompletarTitulo">
						<a class="btnDestacado" href="javascript:ValidarFormulario(document.forms['form1'],'datosGenerales');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
						</a>&nbsp;
						<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/Licitaciones2022.xsql" title="Volver a las licitaciones">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/>
						</a>
					</span>
				</p>			
			</div>
			<br/>
			<xsl:call-template name="Tabla_Datos_Generales_Nuevo"/>
			<div id="uploadFrameBox" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>
			<div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>
		</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>


<!-- template carga documentos (template compartido) -->
<!-- Se pueden subir fichas tecnicas (lado proveedor) => se informa campo en la tabla lic_productosofertas a partir del LIC_PROD_ID (LicProdID) -->
<!-- Tambien se pueden subir contratos/ofertas (autor de la licitacion) => se informa campo en la tabla licitaciones a partir del LIC_ID (LicID) -->
<xsl:template name="CargaDocumentos">
	<xsl:param name="tipo"/>
	<xsl:param name="LicProdID"/>
	<xsl:param name="LicID"/>
	<xsl:param name="nombre_corto"/>

	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/Mantenimiento/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:variable name="valueID">
		<xsl:choose>
		<xsl:when test="$LicProdID != ''"><xsl:value-of select="$LicProdID"/></xsl:when>
		<xsl:when test="$LicID != ''"><xsl:value-of select="$LicID"/></xsl:when>
		</xsl:choose>
	</xsl:variable>

	<div id="cargaDoc{$tipo}">
		<xsl:attribute name="class">
			<xsl:choose>
			<xsl:when test="$LicProdID != ''">divLeft80</xsl:when>
			<xsl:otherwise>divLeft99</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>

		<!--tabla imagenes y documentos-->
		<table class="infoTable" border="0">
			<tr>
				<!-- solo mostramos este tr en el caso de fichas tecnicas -->
				<xsl:if test="$LicProdID != ''">
				<!--documentos-->
				<td class="labelRight quince">
					<span class="text{$tipo}_{$valueID}">
						<xsl:choose>
						<xsl:when test="$nombre_corto != ''">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_oferta']/node()"/>&nbsp;<xsl:value-of select="$nombre_corto"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_ficha']/node()"/>
						</xsl:otherwise>
						</xsl:choose>
       	  </span>
				</td>
				</xsl:if>

				<td class="textLeft trenta">
					<div class="altaDocumento">
						<span class="anadirDoc">
							<xsl:call-template name="documentos">
								<xsl:with-param name="num" select="number(1)"/>
								<xsl:with-param name="LicProdID" select="$LicProdID"/>
								<xsl:with-param name="type" select="$tipo"/>
								<xsl:with-param name="LicID" select="$LicID"/>
							</xsl:call-template>
						</span>
					</div>
				</td>

				<td class="veinte">
					<div class="botonLargo">
						<a href="javascript:cargaDoc(document.forms['ProductosProveedor'],'{$tipo}','{$LicProdID}');">
							<xsl:choose>
							<xsl:when test="$LicProdID != ''">
								<xsl:attribute name="href">
									<xsl:text>javascript:cargaDoc(document.forms['ProductosProveedor'],'</xsl:text><xsl:value-of select="$tipo"/><xsl:text>','</xsl:text><xsl:value-of select="$LicProdID"/><xsl:text>');</xsl:text>
								</xsl:attribute>
							</xsl:when>
							<xsl:when test="$LicID != ''">
								<xsl:attribute name="href">
									<xsl:text>javascript:cargaDoc(document.forms['SubirContrato'],'</xsl:text><xsl:value-of select="$tipo"/><xsl:text>','</xsl:text><xsl:value-of select="$LicID"/><xsl:text>');</xsl:text>
								</xsl:attribute>
							</xsl:when>
							</xsl:choose>

							<span class="text{$tipo}">
								<xsl:choose>
								<xsl:when test="$LicProdID != ''">
									<xsl:choose>
									<xsl:when test="$nombre_corto != ''">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_oferta']/node()"/>&nbsp;<xsl:value-of select="$nombre_corto"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_ficha']/node()"/>
									</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:when test="$LicID != ''">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_contrato']/node()"/>
								</xsl:when>
								</xsl:choose>
                                                        </span>
						</a>
					</div>
				</td>
				<td>
                    <div id="waitBoxDoc_{$valueID}" align="center">&nbsp;</div>
                    <div id="confirmBox_{$valueID}" style="display:none;" align="center">
                    	<span class="cargado" style="font-size:10px;">¡<xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/>!</span>
                    </div>
                </td>
			</tr>
		</table><!--fin de tabla imagenes doc-->

	</div><!--fin de divleft-->
</xsl:template><!--fin de template carga documentos-->


<!--documentos-->
<xsl:template name="documentos">
	<xsl:param name="num" />
	<xsl:param name="type"/>
	<xsl:param name="LicProdID"/>
	<xsl:param name="LicID"/>

	<xsl:variable name="valueID">
		<xsl:choose>
		<xsl:when test="$LicProdID != ''"><xsl:value-of select="$LicProdID"/></xsl:when>
		<xsl:when test="$LicID != ''"><xsl:value-of select="$LicID"/></xsl:when>
		</xsl:choose>
	</xsl:variable>

	<xsl:choose>
	<xsl:when test="$num &lt; number(5)">
		<div class="docLine" id="docLine_{$valueID}">
			<div class="docLongEspec" id="docLongEspec_{$valueID}">
				<input id="inputFileDoc_{$valueID}" name="inputFileDoc" type="file" onChange="addDocFile('{$valueID}');" />
			</div>
		</div>
	</xsl:when>
	</xsl:choose>
</xsl:template>
<!--fin de documentos-->

</xsl:stylesheet>
