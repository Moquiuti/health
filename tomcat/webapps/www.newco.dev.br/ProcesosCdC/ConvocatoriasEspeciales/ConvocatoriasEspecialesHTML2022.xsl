<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Convocatorias especiales. Carga de productos desde fichero. Nuevo disenno 2022.
	Ultima revisión: ET 23may22 15:15 ConvocatoriasEspeciales2022_230522.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/MantenProductos">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

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
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/ConvocatoriasEspeciales2022_230522.js"></script>
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
		<br/>
		<!--<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatorias_Especiales']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Mant_cat_fichero']/node()"/></span></p>-->
		<p class="TituloPagina">
			<!--<xsl:value-of select="/MantenProductos/INICIO/EMPRESA"/>--><xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatorias_Especiales']/node()"/>
			<span class="CompletarTitulo500">
				<a class="btnNormal" href="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/InformarProcedimientos2022.xsql">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Informar_procedimientos']/node()"/>
				</a>
				&nbsp;
				<a class="btnNormal" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProcedimientos2022.xsql','convesp_buscadores',100,80,0,-10);">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimientos']/node()"/>
				</a>
				&nbsp;
				<a class="btnNormal" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProductos2022.xsql','convesp_buscadores',100,80,0,-10);">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>
				</a>
			</span>
		</p>
	</div>
	<br/>
	<form name="frmProductos" method="post">
	<table cellspacing="6px" cellpadding="6px">
		<tr>
			<td class="labelRight" style="width:150px">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatoria']/node()"/>:&nbsp;
			</td>
			<td class="textLeft" style="width:400px">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/MantenProductos/INICIO/CONVOCATORIAS/field"/>
					<xsl:with-param name="claSel">w500px</xsl:with-param>
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
		<tr>
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
				<a class="btnNormal" href="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/OHSJD_ModeloFicheroCargaElementosEspeciales_1oct18.xlsx"><xsl:value-of select="document($doc)/translation/texts/item[@name='Descargar_modelo']/node()"/></a>
			</td>
			<td>
				&nbsp;
			</td>
		</tr>
	</table>
	<br/>
	<br/>

	<table cellspacing="6px" cellpadding="6px">
	<tr>
		<td class="textLeft" colspan="3">
			&nbsp;&nbsp;&nbsp;&nbsp;<span id="formatoCarga">********* pendiente **********</span>
			<br/><br/>
		</td>
	</tr>
	<tr>
        <td style="width:1100px;">
			<div class="divLeft">
				<table class="buscador">
					<tr>
						<td class="textLeft">
							&nbsp;&nbsp;&nbsp;<textarea name="TXT_PRODUCTOS" id="TXT_PRODUCTOS" cols="120" rows="30" wrap="off"/><!--maxlength no parece servir	-->
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
			<div class="divLeft"><p id="infoProgreso"></p></div>
			<div id="infoErrores" class="textLeft" style="color:red;display:none;"></div>
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
	</table>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	</form>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
