<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 	Integración: creación de pedidos (o licitaciones) a partir de ficheros de texto
	ultima revision: ET 15nov11 11:00 AltaLicitacionesAjax2022_151122.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/Administracion">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/Administracion/LANG"><xsl:value-of select="/Administracion/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='integracion']/node()"/></title>
	<xsl:call-template name="estiloIndip"/>

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--	Nuevas librerías para manejo desde JS de ficheros XML	-->
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/AdminTecnica/AltaLicitacionesAjax2022_151122.js"></script>
	<script type="text/javascript">
	var usMulticentros= '<xsl:choose><xsl:when test="/Administracion/INICIO/MULTICENTROS">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
	var str_ModeloFicPedidos= '<xsl:value-of select="/Administracion/INICIO/MODELOFICPEDIDOS"/>';
	var str_SeparadorFicPedidos= '<xsl:value-of select="/Administracion/INICIO/SEPARADORFICPEDIDOS"/>';
	var str_CabeceraFicPedidos= '<xsl:value-of select="/Administracion/INICIO/CABECERAFICPEDIDOS"/>';
	
	var str_ModeloFicEstandarMulticentro= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Formato_carga_pedidos_desde_texto_multicentro']/node()"/>';
	var str_ModeloFicEstandarComprador= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Formato_carga_pedidos_desde_texto_comprador']/node()"/>';
	var str_CreandoLicitacion= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Creando_licitacion']/node()"/>';
	var str_ErrorDesconocidoCreandoFichero= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Error_desconocido_creando_fichero']/node()"/>';
	var str_FicheroYaEnviado= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Fichero_ya_enviado']/node()"/>';
	var str_ErrorDesconocidoCreandoLicitacion= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Error_desconocido_creando_licitacion']/node()"/>';
	var str_NoPodidoIncluirProducto= '<xsl:value-of select="document($doc)/translation/texts/item[@name='No_podido_incluir_producto']/node()"/>';
	var str_FicheroProcesado= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Fichero_Procesado']/node()"/>';
	var str_FicheroConErrores= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Fichero_Procesado']/node()"/>';
	var str_CambioCantidad= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cambio_cantidad_linea']/node()"/>';
	var alrt_ProdsActualizadosOK= '<xsl:value-of select="document($doc)/translation/texts/item[@name='success_productos_actualizados']/node()"/>';
	var str_CentroNoInformado= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Centro_no_informado']/node()"/>';
	var str_FicheroVacio= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Fichero_vacio']/node()"/>';
	var str_CantidadNoInformada= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cantidad_no_informada']/node()"/>';

	//	Nuevas cadenas para mensaje de OK ampliado
	var str_Pedidos= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos']/node()"/>';
	var str_Licitaciones= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitaciones']/node()"/>';
	var str_PedMin= '<xsl:value-of select="document($doc)/translation/texts/item[@name='ped_min']/node()"/>';
	var str_Productos= '<xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/>';
	var str_AbrirPed= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Desea_abrir_pedidos']/node()"/>';
	var str_AbrirLic= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Desea_abrir_licit']/node()"/>';
	var str_NoCumple= '<xsl:value-of select="document($doc)/translation/texts/item[@name='No_cumple']/node()"/>';

	<xsl:choose>
	<xsl:when test="/Administracion/INICIO/CENTROS">
		var multiCentros='S';
	</xsl:when>
	<xsl:otherwise>
		var multiCentros='N';
	</xsl:otherwise>
	</xsl:choose>
	var arrCentros	= new Array();
	<xsl:for-each select="/Administracion/INICIO/CENTROS/field/dropDownList/listElem">
		var centro		= [];
		centro['ID']	= '<xsl:value-of select="ID"/>';
		centro['listItem']	= '<xsl:value-of select="listItem"/>';
		centro['Linea']	= '<xsl:value-of select="MODELOFICCARGAPEDIDOS"/>';
		centro['Separador']	= '<xsl:value-of select="SEPFICCARGAPEDIDOS"/>';
		centro['Cabecera']	= '<xsl:value-of select="CABFICCARGAPEDIDOS"/>';

		arrCentros.push(centro);
	</xsl:for-each>
	
	function Buscar()
	{
		document.forms["frmBuscador"].submit();
	}
	
	</script>
</head>

<body onLoad="javascript:Inicio();">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/Administracion/LANG"><xsl:value-of select="/Administracion/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:choose>
	<xsl:when test="/Administracion/ERROR">
		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='integracion']/node()"/></h1>
		<h2 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></h2>
	</xsl:when>
	<xsl:otherwise>

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='Carga_pedidos_desde_fichero']/node()"/>
       		&nbsp;&nbsp;
			<span class="CompletarTitulo">
				<!--	Botones	-->
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>

	<table class="textLeft">
	<xsl:choose>
	<xsl:when test="/Administracion/INICIO/INTEGRACION/EMPRESAS/field">
		<form name="frmBuscador" action="IntegracionTxt2022.xsql">
		<tr>
        	<td class="w100px">&nbsp;</td>
        	<td class="w400px">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:</label>&nbsp;
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/Administracion/INICIO/INTEGRACION/EMPRESAS/field"/>
					<xsl:with-param name="onChange">javascript:Buscar();</xsl:with-param>
					<xsl:with-param name="claSel">w400px</xsl:with-param>
				</xsl:call-template>
        	</td>
        	<td class="w400px">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo']/node()"/>:</label>&nbsp;
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/Administracion/INICIO/INTEGRACION/FPLAZO/field"/>
					<xsl:with-param name="onChange">javascript:Buscar();</xsl:with-param>
					<xsl:with-param name="claSel">w100px</xsl:with-param>
				</xsl:call-template>
        	</td>
    	</tr>
		</form>
	</xsl:when>
	<xsl:otherwise>
		<xsl:choose>
		<xsl:when test="/Administracion/INICIO/CENTROS">
			<tr>
				<td class="labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Administracion/INICIO/CENTROS/field"></xsl:with-param>
						<xsl:with-param name="onChange">javascript:chCentro();</xsl:with-param>
					<xsl:with-param name="claSel">w500px</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
		</xsl:when>
		<xsl:otherwise>
			<input type="hidden" name="IDCENTRO" value="/Administracion/INICIO/IDCENTRO"/>
		</xsl:otherwise>
		</xsl:choose>
		<tr>
			<td class="labelRight w100px">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='fichero']/node()"/>:&nbsp;
			</td>
			<td class="textLeft" style="width:*;">
				<input type="hidden" name="IDPROVEEDOR" id="IDPROVEEDOR" value="1"/>
				<input type="hidden" name="CADENA_DOCUMENTOS"/>
				<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
				<input type="hidden" name="BORRAR_ANTERIORES"/>
				<input type="hidden" name="REMOVE" value="Eliminar"/>
				<input class="muygrande" id="inputFile" name="inputFile" type="file" onChange="EnviarFicheroPedido(this.files);"/>
			</td>
			<td class="labelRight" style="width:*;">
				&nbsp;
			</td>
			<td class="labelRight" style="width:70%;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td class="labelRight" colspan="4">
				&nbsp;
			</td>
		</tr>
		<tr>
        	<td colspan="2">
        		<div class="altaDocumento marginLeft100">
        			<span class="anadirDoc">
        				<div class="docLine" id="docLine">
        					<div class="docLongEspec" id="docLongEspec">
							<form name="SubirDocumentos" method="post">
								<table class="buscador">
									<tr>
										<td class="textLeft">
											<p id="MODELOCARGA"></p>
											<br/><br/>
											&nbsp;&nbsp;&nbsp;<textarea name="TXT_PRODUCTOS" id="TXT_PRODUCTOS" cols="120" rows="20"/>
										</td>
										<td class="textLeft">
											&nbsp;&nbsp;&nbsp;<a class="btnNormal" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoPrivadoProductoEmpresa2022.xsql?IDEMPRESA={/Administracion/INICIO/IDEMPRESA}&amp;ORIGEN=PEDIDOSTEXTO','Catalogo Privado',50,80,90,20);"><xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo']/node()"/></a>
											<br/><br/><br/><br/>
 											&nbsp;&nbsp;&nbsp;<a id="EnviarPedidoDesdeTexto" class="btnDestacado" href="javascript:EnviarPedidoDesdeTexto();"><xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/></a>
										</td>
									</tr>
								</table>
							</form>
        					</div>
        				</div>
        			</span>
        		</div>
        	</td>
        	<td style="width:50px;">
            	&nbsp;
        	</td>
        	<td style="width:700px;">
				<div style="text-align:left;"><p id="infoProgreso"></p></div>
				<div id="infoErrores" style="text-align:left;color:red;display:none;"></div>
        	</td>
        	<td>
        	</td>
        	<td>
            	&nbsp;
        	</td>
    	</tr>
	</xsl:otherwise>
	</xsl:choose>
	</table>
	<br/>
	<br/>

	<!-- Bloque de info para los ficheros de integración -->
	<xsl:if test="/Administracion/INICIO/ACCION='INT_CONSULTA' or /Administracion/INICIO/ACCION='INT_EJECUTAR' or /Administracion/INICIO/ACCION='INT_OKMANUAL'">
		<div class="tabela tabela_redonda">
		<table cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
				<tr>
					<th class="w1px">&nbsp;</th>
					<th class="w150px"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
					<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>
					<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='fichero']/node()"/></th>
					<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones']/node()"/><br/>/<xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/></th>
					<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/><br/>/<xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/></th>
					<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
					<th class="w150px"><xsl:value-of select="document($doc)/translation/texts/item[@name='boton_descargarOC']/node()"/></th>
				</tr>
			</thead>

			<tbody class="corpo_tabela">
			<xsl:choose>
			<xsl:when test="/Administracion/INICIO/INTEGRACION/FICHERO">
			<xsl:for-each select="/Administracion/INICIO/INTEGRACION/FICHERO">
				<tr class="conhover">
					<td class="color_status">&nbsp;</td>
					<td>&nbsp;<xsl:value-of select="FECHA"/></td>
					<td>&nbsp;<xsl:value-of select="CLIENTE/NOMBRE"/></td>
					<td class="textLeft">&nbsp;<a href="javascript:FicheroIntegracion({ID});"><xsl:value-of select="NOMBRE"/></a></td>
					<td>&nbsp;
    					<xsl:choose>
        					<xsl:when test="NUMPRODUCTOSLICITACION>0">
								<xsl:choose>
        							<xsl:when test="IDLICITACION!=''">
									<a href="javascript:FichaLicitacion({IDLICITACION});">
										<xsl:value-of select="NUMLICITACIONES"/>/<xsl:value-of select="NUMPRODUCTOSLICITACION"/>
									</a>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="NUMLICITACIONES"/>/<xsl:value-of select="NUMPRODUCTOSLICITACION"/>
									</xsl:otherwise>
    							</xsl:choose>
								</xsl:when>
        					<xsl:otherwise>-</xsl:otherwise>
    					</xsl:choose>
					</td>
					<td>&nbsp;
    					<xsl:choose>
        					<xsl:when test="NUMPRODUCTOSPEDIDO>0"><xsl:value-of select="NUMPEDIDOS"/>/<xsl:value-of select="NUMPRODUCTOSPEDIDO"/></xsl:when>
        					<xsl:otherwise>-</xsl:otherwise>
    					</xsl:choose>
					</td>
					<td>&nbsp;<xsl:value-of select="NOMBREESTADO"/></td>
					<td >
						<xsl:choose>
						<xsl:when test="BOTON_DESCARGAR_OC">
							<a class="btnNormal" id="botonDescargarOC" href="javascript:DescargarOC({ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='boton_descargarOC']/node()"/></a>
						</xsl:when>
						<xsl:otherwise>&nbsp;</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
			</xsl:for-each>
			
			<!-- solo para pruebas de guardar fichero <div id="prueba">Prueba</div>	-->
		</xsl:when>
		<xsl:otherwise>
        	<tr style="text-align:center;font-weight:bold;">
				<td>
					<xsl:attribute name="colspan">
						<xsl:choose>
						<xsl:when test="/Administracion/INICIO/ADMIN_MVM">11</xsl:when>
						<xsl:otherwise>8</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_ficheros_pendientes']/node()"/>
				</td>
			</tr>
		</xsl:otherwise>
		</xsl:choose>
 		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="11">&nbsp;</td></tr>
		</tfoot>
		</table>
		</div>
	</xsl:if>
	<br/>
	<br/>
	<!-- Formulario, menús -->
	<form name="Admin" method="post" action="Integracion.xsql">
	<input type="hidden" name="ACCION"/>
	<input type="hidden" name="PARAMETROS"/>
	</form>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
