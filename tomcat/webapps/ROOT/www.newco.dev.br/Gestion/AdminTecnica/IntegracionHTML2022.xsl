<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 	Gestión de los fichero de integración XML
	ultima revision: ET 17abr23 09:00 IntegracionAjax2022_030423.js IntegracionEstandarBrasil2022_170423.js
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

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='integracion']/node()"/>&nbsp;XML</title>
	<xsl:call-template name="estiloIndip"/>

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>

	<!--	Nuevas librerías para manejo desde JS de ficheros XML	-->
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/AdminTecnica/ObjTree.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/AdminTecnica/IntegracionEstandarBrasil2022_170423.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/AdminTecnica/IntegracionAjax2022_030423.js"></script>
	<script type="text/javascript">
	var str_CreandoLicitacion= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Creando_licitacion']/node()"/>';
	var str_CreandoAutorizacion= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Creando_autorizacion']/node()"/>';
	var str_ErrorDesconocidoCreandoFichero= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Error_desconocido_creando_fichero']/node()"/>';
	var str_FicheroYaEnviado= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Fichero_ya_enviado']/node()"/>';
	var str_ErrorDesconocidoCreandoLicitacion= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Error_desconocido_creando_licitacion']/node()"/>';
	var str_NoPodidoIncluirProducto= '<xsl:value-of select="document($doc)/translation/texts/item[@name='No_podido_incluir_producto']/node()"/>';
	var str_FicheroProcesado= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Fichero_Procesado']/node()"/>';
	var str_CambioCantidad= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cambio_cantidad_linea']/node()"/>';
	var str_CantidadNoInformada= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cantidad_no_informada']/node()"/>';
	var str_FicheroConErrores= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Fichero_Procesado']/node()"/>';
	var str_Licitaciones= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitaciones']/node()"/>';	
	var str_Productos= '<xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/>';	
	var str_AbrirLic= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Desea_abrir_licit']/node()"/>';	
	var str_Contacto= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Contacto']/node()"/>';	
	
	function Buscar()
	{
		document.forms["frmBuscador"].submit();
	}
	
	
	</script>
</head>

<body>
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
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='integracion']/node()"/>&nbsp;XML
       		&nbsp;&nbsp;
			<span class="CompletarTitulo">
				<!--	Botones	-->
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>

	<form name="frmBuscador" action="Integracion2022.xsql">
	<table  class="buscador">
	<tr class="sinLinea">
		<xsl:choose>
		<xsl:when test="/Administracion/INICIO/INTEGRACION/EMPRESAS/field">
        	<td class="w100px">&nbsp;</td>
        	<td style="width:400px;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:</label>&nbsp;
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/Administracion/INICIO/INTEGRACION/EMPRESAS/field"/>
					<xsl:with-param name="onChange">javascript:Buscar();</xsl:with-param>
				<xsl:with-param name="claSel">w400px</xsl:with-param>
				</xsl:call-template>
        	</td>
		</xsl:when>
		<xsl:otherwise>
        	<td class="w100px">&nbsp;</td>
       		<td class="w300px">
				<select name="TipoEnvio" id="TipoEnvio" class="w240px">
					<option value="S" selected="selected"><xsl:value-of select="document($doc)/translation/texts/item[@name='Solicitud_compras']/node()"/></option>
					<option value="A"><xsl:value-of select="document($doc)/translation/texts/item[@name='Autorizacion_compras']/node()"/></option>
				</select>
        	</td>
        	<td class="w400px">
        		<div class="altaDocumento">
        			<span class="anadirDoc">
        				<div class="docLine" id="docLine">
        					<div class="docLongEspec" id="docLongEspec">
							<form name="SubirDocumentos" method="post">
								<!--<input type="hidden" name="IDPROVEEDOR" id="IDPROVEEDOR" value="1"/>
								<input type="hidden" name="CADENA_DOCUMENTOS"/>
								<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
								<input type="hidden" name="BORRAR_ANTERIORES"/>
								<input type="hidden" name="REMOVE" value="Eliminar"/>-->
								<input class="w400px" id="inputFile" name="inputFile" type="file" onChange="enviarFichero(this.files);"/>
							</form>
        					</div>
        				</div>
        			</span>
        		</div>
        	</td>
        	<td class="w50px">
            	&nbsp;
        	</td>
        	<td class="w1000px">
				<div style="text-align:left;"><p id="infoProgreso"></p></div>
				<div id="infoCargando" style="text-align:left;display:none;"><p><img src="http://www.newco.dev.br/images/loading.gif"/></p></div>
				<div id="infoErrores" style="text-align:left;color:red;display:none;"></div>
        	</td>
        	<td>&nbsp;</td>
		</xsl:otherwise>
		</xsl:choose>
       	<td class="w400px">
        </td>
    	</tr>
	</table>
	</form>
	<br/>
	<br/>
	<p class="floatRight marginRight50">
		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo']/node()"/>:</label>&nbsp;
		<xsl:call-template name="desplegable">
			<xsl:with-param name="path" select="/Administracion/INICIO/INTEGRACION/FPLAZO/field"/>
			<xsl:with-param name="onChange">javascript:Buscar();</xsl:with-param>
			<xsl:with-param name="claSel">w100px</xsl:with-param>
		</xsl:call-template>
	</p>
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
					<th class="w60px textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='codigo']/node()"/></th>
					<th class="w80px"><xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones']/node()"/><br/>/<xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/></th>
					<th class="w80px"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/><br/>/<xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/></th>
					<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
					<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='boton_descargarOC']/node()"/></th>
					<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_descarga']/node()"/></th>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='estado_descarga']/node()"/></th>
					<th class="w1px">&nbsp;</th>
				</tr>
			</thead>

			<tbody class="corpo_tabela">
			<xsl:choose>
			<xsl:when test="/Administracion/INICIO/INTEGRACION/FICHERO">
			<xsl:for-each select="/Administracion/INICIO/INTEGRACION/FICHERO">
				<tr class="conhover">
					<td class="color_status">&nbsp;</td>
					<td>&nbsp;<xsl:value-of select="FECHA"/></td>
					<td class="textLeft">
						<xsl:value-of select="CLIENTE/NOMBRE"/><BR/>
						<span class="fuentePeq"><xsl:value-of select="CLIENTE/NIF"/></span>
					</td>
					<td class="textLeft">
						<a href="javascript:FicheroIntegracion({ID});">
							<xsl:choose>
        					<xsl:when test="TITULO=''">
								<xsl:value-of select="NOMBRE"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="TITULO"/><BR/>
								<span class="fuentePeq"><xsl:value-of select="NOMBRE"/></span>
							</xsl:otherwise>
    					</xsl:choose>
						</a>
					</td>
					<td class="textLeft"><a href="javascript:FicheroIntegracion({ID});"><xsl:value-of select="CODIGOCLIENTE"/></a></td>
					<td>&nbsp;
    					<xsl:choose>
        					<xsl:when test="NUMPRODUCTOSLICITACION>0">
								<xsl:choose>
        							<xsl:when test="IDLICITACION!=''">
									<a href="javascript:FichaLicV2({IDLICITACION});">
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
					<td class="textLeft">&nbsp;<xsl:value-of select="NOMBREESTADO"/></td>
					<td>
						<xsl:choose>
						<xsl:when test="BOTON_DESCARGAR_OC">
							<a class="btnNormal" id="botonDescargarOC" href="javascript:DescargarOC({ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='boton_descargarOC']/node()"/></a>
						</xsl:when>
						<xsl:otherwise>&nbsp;</xsl:otherwise>
						</xsl:choose>
					</td>
					<td>&nbsp;<xsl:value-of select="FECHA_DESCARGA"/></td>
					<td>&nbsp;<xsl:value-of select="ESTADO_DESCARGA"/></td>
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
		<br/>	
		<br/>	
		<br/>	
		<br/>	
		<br/>	
		<br/>	
		</div>
	</xsl:if>
	<br/>
	<br/>
	<!-- Formulario, menús -->
	<form name="Admin" method="post" action="Integracion2022.xsql">
	<input type="hidden" name="ACCION"/>
	<input type="hidden" name="PARAMETROS"/>
	</form>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
