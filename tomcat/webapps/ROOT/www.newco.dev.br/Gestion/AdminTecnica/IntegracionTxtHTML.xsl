<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 	Integración: creación de pedidos a partir de ficheros de texto
	ultima revision: ET 17mar21 11:00 AltaLicitacionesAjax_170321.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/Administracion">
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
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<!--18oct19	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/AdminTecnica/admintecnica_220816.js"></script>-->
	<!--	Nuevas librerías para manejo desde JS de ficheros XML	-->
	<!--<script type="text/javascript" src="http://www.newco.dev.br/Gestion/AdminTecnica/ObjTree.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/AdminTecnica/AltaLicitacionesAjax_170321.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/Gestion/AdminTecnica/LecturaYEnvioLicitacionXML.js"></script>-->
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
	var str_CambioCantidad= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cambio_cantidad_linea']/node()"/>';
	var alrt_ProdsActualizadosOK= '<xsl:value-of select="document($doc)/translation/texts/item[@name='success_productos_actualizados']/node()"/>';
	var str_CentroNoInformado= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Centro_no_informado']/node()"/>';
	var str_FicheroVacio= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Fichero_vacio']/node()"/>';
	var str_CantidadNoInformada= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cantidad_no_informada']/node()"/>';
	
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
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='integracion']/node()"/></span></p>
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

	<table  align="left" class="buscador">
	<xsl:choose>
	<xsl:when test="/Administracion/INICIO/INTEGRACION/EMPRESAS/field">
		<form name="frmBuscador" action="Integracion.xsql">
		<tr class="sinLinea">
        	<td style="width:400px;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:</label>&nbsp;
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/Administracion/INICIO/INTEGRACION/EMPRESAS/field"/>
					<xsl:with-param name="onChange">javascript:Buscar();</xsl:with-param>
					<xsl:with-param name="style">width:400px;height:20px;font-size:15px;</xsl:with-param>
				</xsl:call-template>
        	</td>
        	<td style="width:400px;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo']/node()"/>:</label>&nbsp;
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/Administracion/INICIO/INTEGRACION/FPLAZO/field"/>
					<xsl:with-param name="onChange">javascript:Buscar();</xsl:with-param>
					<xsl:with-param name="style">width:100px;height:20px;font-size:15px;</xsl:with-param>
				</xsl:call-template>
        	</td>
    	</tr>
		</form>
	</xsl:when>
	<xsl:otherwise>
		<xsl:choose>
		<xsl:when test="/Administracion/INICIO/CENTROS">
			<tr class="sinLinea">
				<td class="labelRight">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;
				</td>
				<td class="textLeft">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Administracion/INICIO/CENTROS/field"></xsl:with-param>
						<xsl:with-param name="onChange">javascript:chCentro();</xsl:with-param>
						<xsl:with-param name="style">width:500px;</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
		</xsl:when>
		<xsl:otherwise>
			<input type="hidden" name="IDCENTRO" value="/Administracion/INICIO/IDCENTRO"/>
		</xsl:otherwise>
		</xsl:choose>
		<tr class="sinLinea">
			<td class="labelRight" style="width:100px;">
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
		<tr class="sinLinea">
			<td class="labelRight" colspan="4">
				&nbsp;
			</td>
		</tr>
		<tr class="sinLinea">
        	<td colspan="2">
        		<div class="altaDocumento">
        			<span class="anadirDoc">
        				<div class="docLine" id="docLine">
        					<div class="docLongEspec" id="docLongEspec">
							<form name="SubirDocumentos" method="post">
								<table class="buscador">
									<tr class="sinLinea">
										<td class="textLeft">
											<p id="MODELOCARGA"></p>
											<br/><br/>
											&nbsp;&nbsp;&nbsp;<textarea name="TXT_PRODUCTOS" id="TXT_PRODUCTOS" cols="120" rows="20"/>
										</td>
										<td class="textLeft">
											&nbsp;&nbsp;&nbsp;<a class="btnNormal" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoPrivadoProductoEmpresa.xsql?IDEMPRESA={/Administracion/INICIO/IDEMPRESA}&amp;ORIGEN=PEDIDOSTEXTO','Catalogo Privado',50,80,90,20);"><xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo']/node()"/></a>
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
			<table class="buscador">
			<thead>
				<tr class="subTituloTabla">
					<th align="center"> <!--colspan="4"-->
						<xsl:attribute name="colspan">
							<xsl:choose>
							<xsl:when test="/Administracion/INICIO/ADMIN_MVM">11</xsl:when>
							<xsl:otherwise>8</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='ficheros_de_integracion']/node()"/>
					</th>
				</tr>
				<tr>
					<th align="center" style="width:140px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
					<th align="center" class="cuarenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>
					<th align="center"><xsl:value-of select="document($doc)/translation/texts/item[@name='fichero']/node()"/></th>
					<th align="center" style="width:100px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones']/node()"/><br/>/<xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/></th>
					<th align="center" style="width:100px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/><br/>/<xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/></th>
					<!--<xsl:if test="/Administracion/INICIO/ADMIN_MVM">
						<th align="center" class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='accion']/node()"/></th>
						<th align="center" style="width:250px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/></th>
					</xsl:if>-->
					<th align="center" style="width:100px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
					<!--<xsl:if test="/Administracion/INICIO/ADMIN_MVM">
						<th align="center" style="width:200px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='acciones']/node()"/></th>
					</xsl:if>-->
					<th align="center" style="width:150px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='boton_descargarOC']/node()"/></th>
				</tr>
			</thead>

			<tbody>
			<xsl:choose>
			<xsl:when test="/Administracion/INICIO/INTEGRACION/FICHERO">
			<xsl:for-each select="/Administracion/INICIO/INTEGRACION/FICHERO">
				<tr>
					<td align="center">&nbsp;<xsl:value-of select="FECHA"/></td>
					<td align="center">&nbsp;<xsl:value-of select="CLIENTE/NOMBRE"/></td>
					<td align="left">&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/AdminTecnica/FicheroIntegracion.xsql?ID={ID}','FicheroIntegracion',100,100,0,0);"><xsl:value-of select="NOMBRE"/></a></td>
					<td align="center">&nbsp;
    					<xsl:choose>
        					<xsl:when test="NUMPRODUCTOSLICITACION>0">
								<xsl:choose>
        							<xsl:when test="IDLICITACION!=''">
									<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/MantLicitacion.xsql?LIC_ID={IDLICITACION}','Licitacion',100,100,0,0);">
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
					<td align="center">&nbsp;
    					<xsl:choose>
        					<xsl:when test="NUMPRODUCTOSPEDIDO>0"><xsl:value-of select="NUMPEDIDOS"/>/<xsl:value-of select="NUMPRODUCTOSPEDIDO"/></xsl:when>
        					<xsl:otherwise>-</xsl:otherwise>
    					</xsl:choose>
					</td>
					<!--<xsl:if test="/Administracion/INICIO/ADMIN_MVM">
						<td align="center">&nbsp;<xsl:value-of select="ACCION"/></td>
						<td align="left">&nbsp;<xsl:value-of select="COMENTARIOS_CORTO"/></td>
					</xsl:if>-->
					<td align="center">&nbsp;<xsl:value-of select="NOMBREESTADO"/></td>
					<!--
					<xsl:if test="/Administracion/INICIO/ADMIN_MVM">
						<td align="center">
							<a href="javascript:EjecutarFichero({ID});">
    							<xsl:attribute name="title">
        							<xsl:value-of select="document($doc)/translation/texts/item[@name='ejecutar_integ_expli']/node()"/>
    							</xsl:attribute>
    							<xsl:choose>
        							<xsl:when test="Administracion/LANG = 'spanish'"><img src="http://www.newco.dev.br/images/botonEjecutar.gif" alt="Ejecutar" /></xsl:when>
        							<xsl:otherwise><img src="http://www.newco.dev.br/images/botonEjecutar-BR.gif" alt="Executar" /></xsl:otherwise>
    							</xsl:choose>
							</a>&nbsp;
							<a href="javascript:OkManualFichero({ID});">
    							 <xsl:attribute name="title">
        							<xsl:value-of select="document($doc)/translation/texts/item[@name='archivar_integ_expli']/node()"/>
    							</xsl:attribute>
    							<xsl:choose>
        							<xsl:when test="Administracion/LANG = 'spanish'"><img src="http://www.newco.dev.br/images/botonArchivar.gif" alt="Archivar" /></xsl:when>
        							<xsl:otherwise><img src="http://www.newco.dev.br/images/botonArchivar-BR.gif" alt="Archivo" /></xsl:otherwise>
    							</xsl:choose>
							</a>&nbsp;
							<a href="javascript:EditarFichero({ID});">
    							 <xsl:attribute name="title">
        							<xsl:value-of select="document($doc)/translation/texts/item[@name='editar_integ_expli']/node()"/>
    							</xsl:attribute>
    							<img src="http://www.newco.dev.br/images/botonEditar.gif" alt="Editar" />
							</a>
							&nbsp;
						</td>
					</xsl:if>
					-->
					<td align="center" >
						<xsl:choose>
						<xsl:when test="BOTON_DESCARGAR_OC">
						<!--<div class="botonLargoVerdadNara clear" id="botonDescargarOC" valign="center">-->
							<a class="btnNormal" id="botonDescargarOC" href="javascript:DescargarOC({ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='boton_descargarOC']/node()"/></a>
                 		<!--</div>-->
						<!--<div class="botonLargoVerdadNara clear" id="botonDescargarOC"><a href="javascript:MostrarOC({ID});">Prueba OC</a></div>-->
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
		</table>
           
		<xsl:if test="/Administracion/INICIO/ADMIN_MVM">           
        <table class="infoTable">
		<tfoot>
			<tr class="lejenda lineBorderBottom3" style="background:#E4E4E5;font-weight:bold;"> 
				<td colspan="5" class="datosLeft" style="padding:3px 0px 0px 20px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda']/node()"/>:</td>
			</tr>
            <tr class="lineBorderBottom5">
                <td class="trenta datosLeft">
                    <p style="line-height:20px;">
						&nbsp;&nbsp;&nbsp;&nbsp; 
                        <xsl:choose>
                            <xsl:when test="Administracion/LANG = 'spanish'"><img src="http://www.newco.dev.br/images/botonEjecutar.gif" alt="Ejecutar" /></xsl:when>
                            <xsl:otherwise><img src="http://www.newco.dev.br/images/botonEjecutar-BR.gif" alt="Executar" /></xsl:otherwise>
                        </xsl:choose> 
                        &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ejecutar_integ_expli']/node()"/><br />
                        &nbsp;&nbsp;&nbsp;&nbsp; 
                        <xsl:choose>
                            <xsl:when test="Administracion/LANG = 'spanish'"><img src="http://www.newco.dev.br/images/botonArchivar.gif" alt="Archivar" /></xsl:when>
                            <xsl:otherwise><img src="http://www.newco.dev.br/images/botonArchivar-BR.gif" alt="Archivo" /></xsl:otherwise>
                        </xsl:choose> 
                        &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='archivar_integ_expli']/node()"/><br />
                        &nbsp;&nbsp;&nbsp;&nbsp; 
                        <img src="http://www.newco.dev.br/images/botonEditar.gif" alt="Editar" />
                        &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='editar_integ_expli']/node()"/>
                    </p>
                </td>
                <td>&nbsp;</td>
            </tr>
		</tfoot>
		</table>
		</xsl:if >

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
