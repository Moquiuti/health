<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Mantenimiento de productos de los catalogos de proveedores de MedicalVM
 	Ultima revision ET 13feb20 15:15

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>  
<xsl:template match="/">

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/MantenimientoProductos/LANG"><xsl:value-of select="/MantenimientoProductos/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_de_productos']/node()"/></title>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style -->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROBuscador_230818.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/imagen.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/litebox.js"></script>

	<link rel="stylesheet" href="http://www.newco.dev.br/General/lightbox.css" type="text/css" media="screen"/>

	<script type="text/javascript">
		<xsl:choose>
		<xsl:when test="/MantenimientoProductos/CATALOGO_PROVEEDORES/MVM">var isMVM = 'S';</xsl:when>
		<xsl:otherwise>var isMVM = 'N';</xsl:otherwise>
		</xsl:choose>

		var txtBuscadorConfirm = '<xsl:value-of select="document($doc)/translation/texts/item[@name='CatProvBuscadorConfirm']/node()"/>';
	</script>
</head>

<body class="gris">
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/MantenimientoProductos/LANG"><xsl:value-of select="/MantenimientoProductos/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!-- ET Desactivado control errores: Habra que reactivarlo -->
	<xsl:choose>
	<xsl:when test="/MantenimientoProductos/DATOS/xsql-error">
		<xsl:apply-templates select="MantenimientoProductos/DATOS/xsql-error"/>
	</xsl:when>

	<xsl:when test="/MantenimientoProductos/DATOS/ROW/Sorry">
		<xsl:apply-templates select="MantenimientoProductos/DATOS/ROW/Sorry"/>
	</xsl:when>

	<xsl:otherwise>
		<form name="formBusca" method="POST" target="Resultados">
		<!--<table class="infoTable gris" border="0" style="border-top:5px solid #FED136;">-->
		<table class="buscador">

		<input type="hidden" name="ADMIN_MVM">
		<xsl:attribute name="value">
			<xsl:choose>
			<xsl:when test="/MantenimientoProductos/CATALOGO_PROVEEDORES/MVM">si</xsl:when>
			<xsl:otherwise>no</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		</input>
		<input type="hidden" name="PAGINA"/>
		<input type="hidden" name="CAMBIOS"/>
		<!--comun para todos-->
		<input type="hidden" name="HISTORY" value="{//HISTORY}"/>
		<!--input para productos nuevos o modificado del proveedor mvm acepta o no-->
		<input type="hidden" name="CAMBIOS_PROVE"/>
		<input type="hidden" name="US_ID_CAMBIO" value="{//LISTAPRODUCTOS/IDCLIENTE}"/>
		<input type="hidden" name="ORDEN" value="{/MantenimientoProductos/CATALOGO_PROVEEDORES/BUSQUEDA/ORDEN}"/>
		<input type="hidden" name="SENTIDO" value="{/MantenimientoProductos/CATALOGO_PROVEEDORES/BUSQUEDA/SENTIDO}"/>

		<xsl:choose>
		<!--SI ES MVM ESPAÑA O ES ADMIN DE CLIENTE ENSEÑO MUCHOS CHECKBOX-->
		<!--<xsl:when test="(/MantenimientoProductos/CATALOGO_PROVEEDORES/MVM or /MantenimientoProductos/CATALOGO_PROVEEDORES/ADMIN) and /MantenimientoProductos/CATALOGO_PROVEEDORES/IDPAIS = '34'">-->
		<xsl:when test="/MantenimientoProductos/CATALOGO_PROVEEDORES/BUSCADOR_CLIENTE and /MantenimientoProductos/CATALOGO_PROVEEDORES/IDPAIS = '34'">
			<!--si es mvm veré 3 campos del buscador-->
			<!--<tr style="padding:7px 0px 0px;">-->
			<tr class="filtros sinLinea">
				<td class="datosLeft" style="width:350px;">
					<label>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></label>:<br />
					&nbsp;<input type="text" name="PRODUCTO" maxlength="200" size="38" style="height:20px;font-size:15px;width:300px;"/>
					<input type="hidden" name="HAYPRODUCTOS" value="{//HAYPRODUCTOS}"/>
					<input type="hidden" name="IDCLIENTES"/>
				</td>
				<td class="datosLeft" style="width:350px;">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></label>:<br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/MantenimientoProductos/CATALOGO_PROVEEDORES/PROVEEDORES/field"/>
						<xsl:with-param name="style">height:20px;font-size:15px;width:300px;</xsl:with-param>
					</xsl:call-template>
				</td>
                <xsl:if test="/MantenimientoProductos/CATALOGO_PROVEEDORES/MVM and /MantenimientoProductos/CATALOGO_PROVEEDORES/ADMIN">
				<td class="datosLeft" style="width:350px;">
					<label> <xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></label>:<br/>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/MantenimientoProductos/CATALOGO_PROVEEDORES/CLIENTES/field"/>
						<xsl:with-param name="style">height:20px;font-size:15px;width:300px;</xsl:with-param>
					</xsl:call-template>
 				</td>
                </xsl:if>
				<td class="datosLeft" style="width:200px;">
					<!--<div class="boton" style="margin-top:10px;">-->
					<p><a href="javascript:DescargarExcel();"><img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel" style="margin-top:2px;margin-bottom:6px;"/></a></p>
					<a class="btnDestacadoPeq" id="BuscarSubmit" href="javascript:EnviarBusqueda();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
					</a>
					<!--</div>-->
				</td>
				<td>&nbsp;</td>
				<td>
                    <a class="btnDestacado" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROManten.xsql','NuevoProducto', 100,80,0,0);">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
					</a>&nbsp;
				</td>
			</tr>
			<!--<tr style="padding:5px 0 0 0;">-->
			<tr class="filtros sinLinea">
				<td class="textLeft" style="padding:5px 0px;">
					<input type="hidden" name="SINPRIVADOS" value=""/>
					<input type="hidden" name="SOLODESTACADOS" value=""/>
					<input type="hidden" name="SOLOOCULTOS" value=""/>
					<input type="hidden" name="SOLOVISIBLES" value=""/>
					<input type="hidden" name="SOLOFARMACOS" value=""/>
                                        <!-- quitado 24-11-15 no se usa mucho
                                        <p class="textLeft">
						<input type="checkbox" class="muypeq" name="SOLODESTACADOS"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_destacados']/node()"/></label>
					</p>-->
					<!--	Solo ocultos	- ->
					<p class="textLeft">
						<input type="checkbox" class="muypeq" name="SOLOOCULTOS"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_ocultos']/node()"/></label>
					</p>
					<!- -	6set12	Solo visibles	- - >
					<p class="textLeft">
						<input type="checkbox" class="muypeq" name="SOLOVISIBLES"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_visibles']/node()"/></label>
					</p>
					<!- -<p class="textLeft">
						<input type="checkbox" class="muypeq" name="SOLOFARMACOS"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_farmacos']/node()"/></label>
					</p>-->
					<p class="textLeft">
						<input type="checkbox" class="muypeq" name="ESPACK" id="ESPACK"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Pack']/node()"/></label>
					</p>
					<p class="textLeft">
						<input type="checkbox" class="muypeq" name="ENPACK" id="ENPACK"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Incl_pack']/node()"/></label>
					</p>
				</td>
				<td>
					<p class="textLeft">
						<input type="checkbox" class="muypeq" name="MODIFICADOSPROV" id="MODIFICADOSPROV"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitudes_cambios_prove']/node()"/></label>
					</p>
					<!--sin emplantillar-->
					<p class="textLeft">
						<input type="checkbox" class="muypeq" name="SINEMPLANTILLAR" id="SINEMPLANTILLAR"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='sin_emplantillar']/node()"/></label>
					</p>
					<!--sin precio -->
					<p class="textLeft">
						<input type="checkbox" class="muypeq" name="SINPRECIOMVM" id="SINPRECIOMVM"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='sin_precio_MVM']/node()"/></label>
					</p>
                    <!--  2jul18                  
                          <input type="hidden" name="PRECIOASISADIFERENTE" value=""/>
					 quitado 24-11-15 no se usa ya, precio asisa diferente
					<p class="textLeft">
						<input type="checkbox" class="muypeq" name="PRECIOASISADIFERENTE"/>&nbsp;
						<label>Precio MVM diferente de precio ASISA</label>
					</p>-->
				</td>
				<td>
					<p class="textLeft">
						<input type="checkbox" class="muypeq" name="SINOFERTAMVM" id="SINOFERTAMVM"/>&nbsp;
						<label>Sin oferta MVM</label>
					</p>
					<!--<p class="textLeft">
						<input type="checkbox" class="muypeq" name="SINOFERTAASISA"/>&nbsp;
						<label>Sin oferta Asisa</label>
					</p>-->
					<p class="textLeft">
						<input type="checkbox" class="muypeq" name="SINOFERTAFNCP" id="SINOFERTAFNCP"/>&nbsp;
						<label>Sin oferta FNCP</label>
					</p>
					<!--<p class="textLeft">
						<input type="checkbox" class="muypeq" name="SINOFERTAVIAMED"/>&nbsp;
						<label>Sin oferta Viamed</label>
					</p>-->
					<p class="textLeft">
						<input type="checkbox" class="muypeq" name="SINOFERTARECOLETAS" id="SINOFERTARECOLETAS"/>&nbsp;
						<label>Sin oferta Recoletas</label>
					</p>
					<!--<p class="textLeft">
						<input type="checkbox" class="muypeq" name="SINOFERTATEKNON"/>&nbsp;
						<label>Sin oferta Teknon</label>
					</p>-->
                    <br />
				</td>
				<td>
					<!--documentación-->
					<p class="textLeft">
						<input type="checkbox" class="muypeq documentacion" name="DOC_OK" id="DOC_OK" onChange="javascript:checkDocumentacion('DOC_OK');"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documentacion_ok']/node()"/></label>
					</p>
					<p class="textLeft">
						<input type="checkbox" class="muypeq documentacion" name="DOC_PEND_APROBAR" id="DOC_PEND_APROBAR" onChange="javascript:checkDocumentacion('DOC_PEND_APROBAR');"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documentacion_pend_aprobar']/node()"/></label>
					</p>
					<p class="textLeft">
						<input type="checkbox" class="muypeq documentacion" name="DOC_PENDIENTE" id="DOC_PENDIENTE" onChange="javascript:checkDocumentacion('DOC_PENDIENTE');"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documentacion_pendiente']/node()"/></label>
					</p>
				</td>
				<td>&nbsp;</td>
			</tr>
		</xsl:when>
		<!--PARA OTROS PAISES ENSEÑO OTRO FORMATO NO HAY TANTOS CHECKBOX-->
		<xsl:when test="/MantenimientoProductos/CATALOGO_PROVEEDORES/BUSCADOR_CLIENTE and /MantenimientoProductos/CATALOGO_PROVEEDORES/IDPAIS != '34'">
			<tr class="filtros sinLinea">
				<td class="datosLeft" style="width:350px;">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></label><br />
					<input type="text" name="PRODUCTO" maxlength="200" size="80"  style="height:20px;font-size:15px;width:300px;"/>
					<input type="hidden" name="HAYPRODUCTOS" value="{//HAYPRODUCTOS}"/>
					<input type="hidden" name="IDCLIENTES"/>
				</td>
				<td class="datosLeft" style="width:350px;">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/MantenimientoProductos/CATALOGO_PROVEEDORES/PROVEEDORES/field"/>
						<xsl:with-param name="style">height:20px;font-size:15px;width:300px;</xsl:with-param>
					</xsl:call-template>
				</td>
                <xsl:if test="/MantenimientoProductos/CATALOGO_PROVEEDORES/MVM and /MantenimientoProductos/CATALOGO_PROVEEDORES/ADMIN">
				<td class="datosLeft" style="width:350px;">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></label><br/>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/MantenimientoProductos/CATALOGO_PROVEEDORES/CLIENTES/field"/>
						<xsl:with-param name="style">height:20px;font-size:15px;width:300px;</xsl:with-param>
					</xsl:call-template>
				</td>
                </xsl:if>
				<td  class="datosLeft" style="width:200px;">
					<!--	Solo destacados	
					<p class="textLeft">
						<input type="checkbox" class="muypeq" name="SOLODESTACADOS"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_destacados']/node()"/></label>
					</p>-->
					<!--	Solo ocultos	
					<p class="textLeft">
						<input type="checkbox" class="muypeq" name="SOLOOCULTOS"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_ocultos']/node()"/></label>
					</p>-->
					<!--	6set12	Solo visibles	
					<p class="textLeft">
						<input type="checkbox" class="muypeq" name="SOLOVISIBLES"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_visibles']/node()"/></label>
					</p>-->
					<!--<p class="textLeft">
						<input type="checkbox" class="muypeq" name="SOLOFARMACOS"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='solo_farmacos']/node()"/></label>
					</p>-->
					<p class="textLeft">
						<input type="checkbox" class="muypeq" name="MODIFICADOSPROV" id="MODIFICADOSPROV"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitudes_cambios_prove']/node()"/></label>
					</p>
					<p class="textLeft">
						<input type="checkbox" class="muypeq" name="ESPACK" id="ESPACK"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Pack']/node()"/></label>
					</p>
					<p class="textLeft">
						<input type="checkbox" class="muypeq" name="ENPACK" id="ENPACK"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Incl_pack']/node()"/></label>
					</p>
				</td>
				<td class="datosLeft" style="width:250px;">
					<!--documentación-->
					<p class="textLeft">
						<input type="checkbox" class="muypeq documentacion" name="DOC_OK" id="DOC_OK" onChange="javascript:checkDocumentacion('DOC_OK');"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documentacion_ok']/node()"/></label>
					</p>
					<p class="textLeft">
						<input type="checkbox" class="muypeq documentacion" name="DOC_PEND_APROBAR" id="DOC_PEND_APROBAR" onChange="javascript:checkDocumentacion('DOC_PEND_APROBAR');"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documentacion_pend_aprobar']/node()"/></label>
					</p>
					<p class="textLeft">
						<input type="checkbox" class="muypeq documentacion" name="DOC_PENDIENTE" id="DOC_PENDIENTE" onChange="javascript:checkDocumentacion('DOC_PENDIENTE');"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documentacion_pendiente']/node()"/></label>
					</p>
				</td>
				<td class="datosLeft" style="width:200px;">
					<!--<div class="boton" style="margin-top:10px;">-->
					<p><a href="javascript:DescargarExcel();"><img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel" style="margin-top:2px;margin-bottom:6px;"/></a></p>
					<a class="btnDestacadoPeq" id="BuscarSubmit" href="javascript:EnviarBusqueda();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
					</a>
				</td>
				<td>&nbsp;</td>
				<td>
                    <a class="btnDestacado" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROManten.xsql','NuevoProducto', 100,80,0,0);">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
					</a>&nbsp;
				</td>
			</tr>

			<input type="hidden" name="SOLODESTACADOS" value=""/>
			<input type="hidden" name="SOLOOCULTOS" value=""/>
			<input type="hidden" name="SOLOVISIBLES" value=""/>
			<input type="hidden" name="SOLOFARMACOS" value=""/>
			<input type="hidden" name="SINPRIVADOS" value=""/>
			<!--<input type="hidden" name="SOLOASISA" value=""/>-->
			<input type="hidden" name="SOLOFNCP" value=""/>
			<!--<input type="hidden" name="SOLOVIAMED" value=""/>-->
			<!--<input type="hidden" name="SOLOTEKNON" value=""/>-->
			<input type="hidden" name="SINPRECIOMVM" value=""/>
			<!--<input type="hidden" name="PRECIOASISADIFERENTE" value=""/>-->
			<input type="hidden" name="SINOFERTAMVM" value=""/>
			<input type="hidden" name="SINOFERTAFNCP" value=""/>
			<!--<input type="hidden" name="SINOFERTAASISA" value=""/>
			<input type="hidden" name="SINOFERTAVIAMED" value=""/>
			<input type="hidden" name="SINOFERTARECOLETAS" value=""/>-->
			<input type="hidden" name="SINOFERTATEKNON" value=""/>
		</xsl:when>
		<!--si es proveedor veo solo input producto-->
		<xsl:otherwise>
			<tr class="filtros sinLinea">
				<input type="hidden" name="IDPROVEEDOR" value="{/MantenimientoProductos/CATALOGO_PROVEEDORES/IDEMPRESA}"/>

				<!--si es proveedor doy un ancho a la columna asi queda a la derecha, este unico campo que ve mvm y proveedores-->
				<td class="datosLeft" style="width:300px;">
					&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:</label>&nbsp;
					&nbsp;<input type="text" style="width:200px;" name="PRODUCTO" maxlength="200" size="38"/>
					<input type="hidden" name="HAYPRODUCTOS" value="{//HAYPRODUCTOS}"/>
					<!--<input type="hidden" name="IDCLIENTES"/>
					<input type="hidden" name="IDCLIENTE" value="-1"/>-->
				</td>
				<td class="datosLeft" style="width:250px;">
					<!--solicitudes rechazadas-->
					<p class="textLeft">
						<input type="checkbox" class="muypeq" name="ESPACK"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Pack']/node()"/></label>
					</p>
					<p class="textLeft">
						<input type="checkbox" class="muypeq" name="ENPACK"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Incl_pack']/node()"/></label>
					</p>
				</td>
				<td class="datosLeft" style="width:250px;">
					<p class="textLeft">
						<input type="checkbox" class="muypeq documentacion" name="DOC_OK" id="DOC_OK" onChange="javascript:checkDocumentacion('DOC_OK');"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documentacion_ok']/node()"/></label>
					</p>
					<p class="textLeft">
						<input type="checkbox" class="muypeq documentacion" name="DOC_PEND_APROBAR" id="DOC_PEND_APROBAR" onChange="javascript:checkDocumentacion('DOC_PEND_APROBAR');"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documentacion_pend_aprobar']/node()"/></label>
					</p>
					<p class="textLeft">
						<input type="checkbox" class="muypeq documentacion" name="DOC_PENDIENTE" id="DOC_PENDIENTE" onChange="javascript:checkDocumentacion('DOC_PENDIENTE');"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documentacion_pendiente']/node()"/></label>
					</p>
				</td>
				<td class="datosLeft" style="width:250px;">
					<input type="hidden" name="SOLOFNCP" value=""/>
					<!--<input type="hidden" name="SOLOVIAMED" value=""/>
					<input type="hidden" name="SOLOASISA" value=""/>
					<input type="hidden" name="SOLOVIAMED" value=""/>
					<input type="hidden" name="SOLOTEKNON" value=""/>-->

					<!--solicitudes rechazadas-->
					<p class="textLeft">
						<input type="checkbox" class="muypeq" name="RECHAZADOS"/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitudes_rechazadas']/node()"/></label>
					</p>
				</td>
				<td class="datosLeft" style="width:200px;">
					<label> <xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></label>:<br/>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/MantenimientoProductos/CATALOGO_PROVEEDORES/CLIENTES/field"/>
					</xsl:call-template>
 				</td>
				<td class="datosLeft" style="width:200px;">
					<!--<div class="boton" style="margin-top:10px;">-->
					<p><a href="javascript:DescargarExcel();"><img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel" style="margin-top:2px;margin-bottom:6px;"/></a></p>
					<a class="btnDestacado" id="BuscarSubmit" href="javascript:EnviarBusqueda();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
					</a>
				</td>
				<td>&nbsp;</td>
				<td>
                    <a class="btnDestacado" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROManten.xsql','NuevoProducto', 100,80,0,0);">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
					</a>&nbsp;
				</td>
			</tr>
		</xsl:otherwise>
		</xsl:choose>
		</table>
		</form>
	</xsl:otherwise>
	</xsl:choose>

	<!--mensaje js-->
	<form name="MensajeJS">
		<input type="hidden" name="CRITERIO_BUSQUEDA" value="{document($doc)/translation/texts/item[@name='criterio_busqueda']/node()}"/>
		<input type="hidden" name="CRITERIO_BUSQUEDA_TEXT" value="{document($doc)/translation/texts/item[@name='criterio_busqueda_text']/node()}"/>
		<input type="hidden" name="CRITERIO_BUSQUEDA_TEXT1" value="{document($doc)/translation/texts/item[@name='criterio_busqueda_text1']/node()}"/>
		<input type="hidden" name="CRITERIO_BUSQUEDA_TEXT2" value="{document($doc)/translation/texts/item[@name='criterio_busqueda_text2']/node()}"/>
		<input type="hidden" name="CRITERIO_BUSQUEDA_TEXT3" value="{document($doc)/translation/texts/item[@name='criterio_busqueda_text3']/node()}"/>
		<input type="hidden" name="DESEA_EXPANDIR_PRECIOS" value="{document($doc)/translation/texts/item[@name='desea_expandir_precios']/node()}"/>
		<input type="hidden" name="SEGURO_ELIMINAR_IMAGEN" value="{document($doc)/translation/texts/item[@name='seguro_eliminar_imagen']/node()}"/>
		<input type="hidden" name="ERROR_CON_CLIENTE" value="{document($doc)/translation/texts/item[@name='error_con_cliente']/node()}"/>
		<input type="hidden" name="IDCLIENTE" value="{document($doc)/translation/texts/item[@name='idcliente']/node()}"/>
		<input type="hidden" name="EXPANDIDOS_NULOS" value="{document($doc)/translation/texts/item[@name='expandidos_nulos']/node()}"/>
		<input type="hidden" name="INTRODUZCA_CANTIDAD" value="{document($doc)/translation/texts/item[@name='introduzca_cantidad']/node()}"/>
		<input type="hidden" name="INTRODUZCA_CANTIDAD_CORRECTA" value="{document($doc)/translation/texts/item[@name='introduzca_cantidad_correcta']/node()}"/>
		<input type="hidden" name="INTRODUZCA_UNIDAD_BASE" value="{document($doc)/translation/texts/item[@name='introduzca_unidad_base']/node()}"/>
		<input type="hidden" name="INTRODUZCA_CANTIDAD_CORRECTA" value="{document($doc)/translation/texts/item[@name='introduzca_cantidad_correcta']/node()}"/>
		<input type="hidden" name="INTRODUZCA_CANTIDAD_CORRECTA" value="{document($doc)/translation/texts/item[@name='introduzca_cantidad_correcta']/node()}"/>
		<input type="hidden" name="INTRODUZCA_CANTIDAD_CORRECTA" value="{document($doc)/translation/texts/item[@name='introduzca_cantidad_correcta']/node()}"/>
		<input type="hidden" name="INTRODUZCA_CANTIDAD_CORRECTA" value="{document($doc)/translation/texts/item[@name='introduzca_cantidad_correcta']/node()}"/>
		<input type="hidden" name="INTRODUZCA_CANTIDAD_CORRECTA" value="{document($doc)/translation/texts/item[@name='introduzca_cantidad_correcta']/node()}"/>
		<input type="hidden" name="SOLICITUD_PENDIENTE" value="{document($doc)/translation/texts/item[@name='alarma_solicitud_pendiente']/node()}"/>
		<input type="hidden" name="SOLICITUD_DEVUELTA" value="{document($doc)/translation/texts/item[@name='alarma_solicitud_devuelta']/node()}"/>
        <input type="hidden" name="TEXT_BUSCA_CONFIRM" value="{document($doc)/translation/texts/item[@name='CatProvBuscadorConfirm']/node()}"/>
	</form>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
