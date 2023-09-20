<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Convocatorias especiales. Carga de productos desde fichero
	Ultima revisión: ET 27set18 10:00
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/MantenProductos">
<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/MantenProductos/LANG"><xsl:value-of select="/MantenProductos/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatorias_Especiales']/node()"/>.&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Mant_cat_fichero']/node()"/>:&nbsp;<xsl:value-of select="/MantenProductos/INICIO/EMPRESA"/></title>
	<xsl:call-template name="estiloIndip"/>
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/ConvocatoriasEspeciales_070119.js"></script>
	<script type="text/javascript">
	var IDUsuario= '<xsl:value-of select="/MantenProductos/INICIO/IDUSUARIO"/>';
	var IDPais= '<xsl:value-of select="/MantenProductos/INICIO/IDPAIS"/>';
	var IDEmpresa= '<xsl:value-of select="/MantenProductos/INICIO/IDEMPRESA"/>';
	var Rol= '<xsl:value-of select="/MantenProductos/INICIO/ROL"/>';
	var esMVM= '<xsl:choose><xsl:when test="/MantenProductos/INICIO/MVM">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';	
	

	var ncRefProducto= '<xsl:value-of select="document($doc)/translation/texts/item[@name='RefProducto']/node()"/>';
	var ncProducto= '<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>';
	var ncMedida= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Medida']/node()"/>';
	var ncMarca= '<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>';
	var ncFabricante= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Fabricante']/node()"/>';
	var ncUdBasica= '<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>';
	var ncUdesLote= '<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_lote']/node()"/>';
	var ncPrecio= '<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ud_basica']/node()"/>';
	var ncIVA= '<xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/>';

	var ncCodExpediente= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cod_Expediente']/node()"/>';
	var ncCodCum= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cod_CUM']/node()"/>';
	var ncInvima= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Cod_Invima']/node()"/>';
	var ncFechaInvima= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_Limite']/node()"/>';
	var ncClasRiesgo= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Clas_Riesgo']/node()"/>';
	
	var ncDescuento= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Descuento']/node()"/>';
	var ncBonificacion= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Bonificacion']/node()"/>';
	var ncClasificacion= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Clasificacion']/node()"/>';

	var strReferenciaObligatoria= '<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia_obli']/node()"/>';
	var strNombreObligatorio= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_obli']/node()"/>';
	var strMarcaObligatoria= '<xsl:value-of select="document($doc)/translation/texts/item[@name='marca_obli']/node()"/>';
	var strUdBasica= '<xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica_obli']/node()"/>';
	var strPrecioObligatorio= '<xsl:value-of select="document($doc)/translation/texts/item[@name='precios_vacios']/node()"/>';
	var strUdesLoteNoNumerico= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_un_lote_no_numero']/node()"/>';
	var strPrecioNoNumerico= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_precio_no_numero']/node()"/>';
	var strTipoIVAObligatorio= '<xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva_no_numero']/node()"/>';
	var strCantidadObligatoria= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_obli']/node()"/>';

	var str_NoPodidoIncluirProducto= '<xsl:value-of select="document($doc)/translation/texts/item[@name='No_podido_incluir_producto']/node()"/>';
	var str_ErrSubirProductos= '<xsl:value-of select="document($doc)/translation/texts/item[@name='err_subir_productos_solicitud_catalogacion']/node()"/>';
	var str_FicheroProcesado= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Fichero_Procesado']/node()"/>';
	
	var strExistenProcedimientos= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Existen_Procedimientos']/node()"/>';
	var strExisteFichero= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Existe_Fichero']/node()"/>';
	var strProcesados= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_procesados']/node()"/>';
	var strFueraDePlazo= '<xsl:value-of select="document($doc)/translation/texts/item[@name='FueraDePlazo']/node()"/>';
	
	//	Control de convocatorias informadas
	var Convocatorias = new Array();
	<xsl:for-each select="/MantenProductos/INICIO/CONVOCATORIAS/field/dropDownList/listElem">
		var Conv = [];
		Conv['ID']= <xsl:value-of select="ID"/>;
		Conv['Nombre']= '<xsl:value-of select="listItem"/>';
		Conv['Procedimientos']=<xsl:value-of select="PROCINFORMADOS"/>;
		Conv['Fichero']='<xsl:value-of select="FICHERO"/>';
		Conv['IDEstado']='<xsl:value-of select="IDESTADO"/>';
		Convocatorias.push(Conv);
	</xsl:for-each>
	</script>
</head>

<body onLoad="javascript:Inicializar();">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/MantenProductos/LANG"><xsl:value-of select="/MantenProductos/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
	
	<xsl:choose>
	<xsl:when test="/MantenProductos/ERROR">
		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_de_productos']/node()"/></h1>
		<h2 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></h2>
	</xsl:when>
	<xsl:otherwise>

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatorias_Especiales']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Mant_cat_fichero']/node()"/></span></p>
		<p class="TituloPagina">
			<xsl:value-of select="/MantenProductos/INICIO/EMPRESA"/>
			<!--
 			<xsl:choose>
			<xsl:when test="/MantenProductos/INICIO/OPCION">
				<xsl:value-of select="/MantenProductos/INICIO/OPCION"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="/MantenProductos/INICIO/EMPRESA"/>
			</xsl:otherwise>
			</xsl:choose>
       		&nbsp;&nbsp;
			-->
			<span class="CompletarTitulo">
				<a class="btnNormal" href="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/InformarProcedimientos.xsql">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Informar_procedimientos']/node()"/>
				</a>
				&nbsp;
				<a class="btnNormal" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProcedimientos.xsql','convesp_buscadores',100,80,0,-10);">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Ver_procedimientos']/node()"/>
				</a>
				&nbsp;
				<a class="btnNormal" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProductos.xsql','convesp_buscadores',100,80,0,-10);">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Ver_productos']/node()"/>
				</a>
			</span>
		</p>
	</div>
	<br/>
	<form name="frmProductos" method="post">
	<table  align="center" class="buscador">
	<!--<xsl:choose>
	<xsl:when test="/MantenProductos/INICIO/CONVOCATORIAS/field">-->
		<tr class="sinLinea">
			<td class="labelRight" style="width:150px">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatoria']/node()"/>:&nbsp;
			</td>
			<td class="textLeft" style="width:400px">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/MantenProductos/INICIO/CONVOCATORIAS/field"/>
					<xsl:with-param name="style">font-size:15px;width:450px;background-color:#white;</xsl:with-param>
					<xsl:with-param name="onChange">javascript:selConvocatoria();</xsl:with-param>
				</xsl:call-template>
			</td>
			<td style="width:400px">
				&nbsp;<p id="IDESTADO"></p>
			</td>
			<td style="width:*">
				&nbsp;
			</td>
		</tr>
	<!--</xsl:when>
	<xsl:otherwise>
		<input type="hidden" name="FIDOPCION" value="{/MantenProductos/INICIO/IDOPCION}"/>
	</xsl:otherwise>
	</xsl:choose>-->
		<tr class="sinLinea">
			<td class="labelRight">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='fichero']/node()"/>:&nbsp;
			</td>
			<td class="textLeft">
				<input type="hidden" name="IDPROVEEDOR" id="IDPROVEEDOR" value="1"/>
				<input type="hidden" name="CADENA_DOCUMENTOS"/>
				<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
				<input type="hidden" name="BORRAR_ANTERIORES"/>
				<input type="hidden" name="REMOVE" value="Eliminar"/>
				<input class="muygrande" id="inputFile" name="inputFile" type="file" onChange="EnviarFichero(this.files);" disabled="disabled"/>
			</td>
			<td class="textLeft">
				<input type="checkbox" class="muypeq" name="COMPLETAR" checked="checked" onchange="javascript:onChangeChecks('COMPLETAR');"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Completar_fichero_anterior']/node()"/>&nbsp;
				<input type="checkbox" class="muypeq" name="SUSTITUIR" unchecked="unchecked" onchange="javascript:onChangeChecks('SUSTITUIR');"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Sustituir_fichero_anterior']/node()"/>&nbsp;
			</td>
			<td class="textLeft">
				<strong><a href="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/OHSJD_ModeloFicheroCargaElementosEspeciales_1oct18.xlsx"><xsl:value-of select="document($doc)/translation/texts/item[@name='Descargar_modelo']/node()"/></a></strong>
			</td>
			<td>
				&nbsp;
			</td>
		</tr>
	</table>
	<br/>
	<br/>

	<table  align="center" class="buscador">
	<tr class="sinLinea">
		<td class="textLeft" colspan="3">
			&nbsp;&nbsp;&nbsp;&nbsp;<span id="formatoCarga">********* pendiente **********</span>
			<br/><br/>
		</td>
	</tr>
	<tr class="sinLinea">
        <td style="width:1100px;">
			<div style="text-align:left;">
				<table class="buscador">
					<tr class="sinLinea">
						<td class="textLeft">
							&nbsp;&nbsp;&nbsp;<textarea name="TXT_PRODUCTOS" id="TXT_PRODUCTOS" cols="150" rows="20" wrap="off"/><!--maxlength no parece servir	-->
						</td>
						<td class="textLeft">
 							&nbsp;&nbsp;&nbsp;<a id="btnMantenProductos" class="btnDestacado" href="javascript:MantenCatalogosTXT();"><xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/></a>
						</td>
					</tr>
				</table>
        	</div>
        </td>
        <td style="width:20px;">
            &nbsp;
        </td>
        <td style="width:*;">
			<div style="text-align:left;"><p id="infoProgreso"></p></div>
			<div id="infoErrores" style="text-align:left;color:red;display:none;"></div>
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
	</table>
	</form>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
