<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Informar procedimientos en convocatoria de elementos especiales
	Ultima revision ET 2nov18 08:51
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
		<xsl:when test="/Productos/LANG"><xsl:value-of select="/Productos/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimiento']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/InformarProcedimientos_101018.js"></script>
	<script type="text/javascript">
		var strReferenciaObligatoria= '<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia_obli']/node()"/>';	
	</script>
</head>

<body class="gris" onload="javascript:RecalcularTotales();">
<xsl:choose>
<xsl:when test="/Productos/SESION_CADUCADA">
	<xsl:for-each select="/Productos/SESION_CADUCADA">
		<xsl:if test="position()=last()">
			<xsl:apply-templates select="."/>
		</xsl:if>
	</xsl:for-each>
</xsl:when>
<xsl:when test="//xsql-error">
	<xsl:apply-templates select="//xsql-error"/>
</xsl:when>
<xsl:otherwise>
	<xsl:choose>
	<xsl:when test="//SESION_CADUCADA">
		<xsl:apply-templates select="//SESION_CADUCADA"/>
	</xsl:when>
	<xsl:when test="//Sorry">
		<xsl:apply-templates select="//Sorry"/>
	</xsl:when>
	<xsl:otherwise>

    <!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/Productos/LANG"><xsl:value-of select="/Productos/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
    <!--idioma fin-->

	<xsl:variable name="usuario">
		<xsl:choose>
		<xsl:when test="EVALUACIONESPRODUCTOS/OBSERVADOR and EVALUACIONESPRODUCTOS/CDC">CDC</xsl:when>
		<xsl:otherwise>NORMAL</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimiento']/node()"/></span>
			<span class="CompletarTitulo">
			</span>
		</p>
		<p class="TituloPagina">
			<xsl:value-of select="/Productos/INICIO/CONVOCATORIA"/>
			&nbsp;&nbsp;
			<span class="CompletarTitulo">
				<xsl:choose>
				<xsl:when test="/Productos/INICIO/ROL='VENDEDOR'">
					<xsl:if test="/Productos/INICIO/EDICION">
					<a class="btnDestacado" href="javascript:ValidarYEnviar();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
					</a>
					&nbsp;
					</xsl:if>
					<a class="btnNormal" href="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/ConvocatoriasEspeciales.xsql">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Subir_productos']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProcedimientos.xsql','convesp_buscadores',100,80,0,-10);">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Ver_procedimientos']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProductos.xsql','convesp_buscadores',100,80,0,-10);">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Ver_productos']/node()"/>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="/Productos/INICIO/MVM or /Productos/INICIO/CDC">
					<a class="btnDestacado" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/','Nueva convocatoria',100,100,0,0)">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/>
					</a>
					</xsl:if>
					<a class="btnNormal" href="javascript:VerOfertas();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Competencia']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/Proveedores.xsql">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProcedimientos.xsql">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Ver_procedimientos']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProductos.xsql">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Ver_productos']/node()"/>
					</a>
				</xsl:otherwise>
				</xsl:choose>
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>
	
	
	<div class="divLeft">
		<form name="Procedimiento" method="post" action="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/InformarProcedimientos.xsql">
		<input type="hidden" name="ROL"/>
		<input type="hidden" name="ACCION"/>
		<input type="hidden" name="PARAMETROS"/>
		<!--<table class="buscador" border="0">-->
		<table class="buscador" border="0">
		<tr class="sinLinea" style="height:30px;">
		<td width="300px" class="labelRight">
      		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatoria']/node()"/>:&nbsp;</label>
		</td>
		<td width="450px" class="textLeft">
        	<xsl:call-template name="desplegable">
            	<xsl:with-param name="path" select="/Productos/INICIO/FIDCONVOCATORIA/field"/>
            	<xsl:with-param name="defecto" select="/Productos/INICIO/FIDCONVOCATORIA/field/@current"/>
            	<xsl:with-param name="style">width:400px;height:20px;</xsl:with-param>
            	<xsl:with-param name="onChange">javascript:CambioDesplegables('CAMBIO_CONVOCATORIA');</xsl:with-param>
        	</xsl:call-template>
		</td>
		<td width="*">
      		&nbsp;
		</td>
		</tr>
		<xsl:if test="/Productos/INICIO/ROL='COMPRADOR'">
		<tr class="sinLinea" style="height:30px;">
		<td class="labelRight">
        	<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:&nbsp;</label>
		</td>
		<td class="textLeft">
        	<xsl:call-template name="desplegable">
            	<xsl:with-param name="path" select="/Productos/INICIO/FIDPROVEEDOR/field"/>
            	<xsl:with-param name="defecto" select="/Productos/INICIO/FIDPROVEEDOR/field/@current"/>
            	<xsl:with-param name="style">width:400px;height:20px;</xsl:with-param>
            	<xsl:with-param name="onChange">javascript:CambioDesplegables('CAMBIO_PROVEEDOR');</xsl:with-param>
        	</xsl:call-template>
		</td>
		<td width="*">
      		&nbsp;
		</td>
		</tr>
		</xsl:if>
		<tr class="sinLinea" style="height:30px;">
		<td class="labelRight">
        	<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Especialidad']/node()"/>:&nbsp;</label>
		</td>
		<td class="textLeft">
        	<xsl:call-template name="desplegable">
            	<xsl:with-param name="path" select="/Productos/INICIO/FIDESPECIALIDAD/field"/>
            	<xsl:with-param name="defecto" select="/Productos/INICIO/FIDESPECIALIDAD/field/@current"/>
            	<xsl:with-param name="style">width:400px;height:20px;</xsl:with-param>
            	<xsl:with-param name="onChange">javascript:CambioDesplegables('CAMBIO_ESPECIALIDAD');</xsl:with-param>
        	</xsl:call-template>
		</td>
		<td width="*">
      		&nbsp;
		</td>
		</tr>
		<tr class="sinLinea" style="height:30px;">
		<td class="labelRight">
        	<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimiento']/node()"/>:&nbsp;</label>
		</td>
		<td class="textLeft">
        	<xsl:call-template name="desplegable">
            	<xsl:with-param name="path" select="/Productos/INICIO/FIDPROCEDIMIENTO/field"/>
            	<xsl:with-param name="defecto" select="/Productos/INICIO/FIDPROCEDIMIENTO/field/@current"/>
            	<xsl:with-param name="style">width:400px;height:20px;</xsl:with-param>
            	<xsl:with-param name="onChange">javascript:CambioDesplegables('CAMBIO_PROCEDIMIENTO');</xsl:with-param>
        	</xsl:call-template>
		</td>
		<td width="*">
      		&nbsp;
		</td>
		</tr>
		</table>
		<BR/><BR/><BR/>
				<table class="buscador" border="0">
		<tr class="sinLinea" style="height:30px;">
		<td class="datosRight">
			<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='Historico']/node()"/>:&nbsp;</strong>
		</td>
		<td class="datosLeft">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:&nbsp;<strong><xsl:value-of select="/Productos/INICIO/HISTORICO/PROVEEDOR"/></strong>&nbsp;
		</td>
		<!--
		<td class="textLeft">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>:&nbsp;<strong><xsl:value-of select="/Productos/INICIO/HISTORICO/LIC_CMP_MARCAACTUAL"/></strong>&nbsp;
		</td>
		-->
		<td class="textLeft">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/>:&nbsp;<strong><xsl:value-of select="/Productos/INICIO/HISTORICO/LIC_CMP_CONSUMOHISTORICO"/></strong>&nbsp;
		</td>
		<td class="textLeft">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Valor_factura']/node()"/>&nbsp;<strong><xsl:value-of select="/Productos/INICIO/HISTORICO/LIC_CMP_PRECIOREFERENCIA"/></strong>&nbsp;
		</td>
		<td class="textLeft">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Costo_neto']/node()"/>&nbsp;<strong><xsl:value-of select="/Productos/INICIO/HISTORICO/LIC_CMP_PRECIOREFERENCIADESC"/></strong>&nbsp;
		</td>
		<td class="textLeft veinte">
			&nbsp;
		</td>
		</tr>
		</table>

		
		<BR/>

		<!--<table class="grandeInicio" border="0">-->
		<table class="buscador" border="0">
		<thead>
			<tr class="subTituloTabla">
				<th align="left" class="uno">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
				<th align="left" class="cinco">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
				<th align="left" class="veinte">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
				<th class="cinco">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
				<th class="cinco">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Bonif']/node()"/></th>
				<th align="left" style="width:150px;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/></th>
				<th align="left" style="width:150px;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></th>
				<th align="left" style="width:150px;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='RangDiametro']/node()"/></th>
				<th align="left" style="width:150px;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='RangLongitud']/node()"/></th>
				<th class="cinco">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/></th>
				<th class="cinco">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ud_basica']/node()"/></th>
				<th class="cinco">&nbsp;</th>
				<th class="cinco">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='TotalLinea']/node()"/></th>
				<!--<th>&nbsp;</th>-->
			</tr>
		</thead>
        <xsl:choose>
		<xsl:when test="/Productos/INICIO/PRODUCTOS/PRODUCTO">
			<xsl:for-each select="/Productos/INICIO/PRODUCTOS/PRODUCTO">
				<tr id="PRO_{ID}">
                    <td>
						<xsl:value-of select="LINEA"/>
						<input type="hidden" name="REFCLIENTE_{ID}" value="{REFERENCIA}"/>
						<input type="hidden" name="PRECIO_{ID}" value="{PRECIO}"/>
						<input type="hidden" name="TOTALLINEA_{ID}" value="{TOTAL_LINEA}"/>
					</td>
					<td class="datosLeft">&nbsp;<xsl:value-of select="REFERENCIA"/></td>
					<td class="datosLeft">&nbsp;<xsl:value-of select="PRODUCTO"/></td>
					<td class="datosRight">&nbsp;<xsl:value-of select="CANTIDAD"/></td>
					<td class="datosRight">&nbsp;
						<xsl:choose>
						<xsl:when test="/Productos/INICIO/EDICION">
        					<xsl:call-template name="desplegable">
            					<xsl:with-param name="path" select="BONIFICADO/field"/>
            					<xsl:with-param name="nombre">BONIF_<xsl:value-of select="ID"/></xsl:with-param>
            					<xsl:with-param name="style">width:50px;</xsl:with-param>
            					<xsl:with-param name="onChange">javascript:RecalcularTotales();</xsl:with-param>
         					</xsl:call-template>
        				</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="BONIFICADO/field/@current"/>
							<input type="hidden" name="BONIF_{ID}" value="{NUMBONIFICADOS}"/>
						</xsl:otherwise>
						</xsl:choose>
					</td>
					<td class="datosLeft">&nbsp;
						<xsl:choose>
						<xsl:when test="/Productos/INICIO/EDICION">
							<input type="text" style="width:120px;" name="REFPROV_{ID}" value="{REFPROVEEDOR}"/>
        				</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="REFPROVEEDOR"/>
							<input type="hidden" name="REFPROV_{ID}" value="{REFPROVEEDOR}"/>
						</xsl:otherwise>
						</xsl:choose>
					</td>
					<td class="datosLeft">&nbsp;
						<xsl:value-of select="MARCA"/>
					</td>
					<td class="datosRight">&nbsp;
						<xsl:choose>
						<xsl:when test="/Productos/INICIO/EDICION">
							<input type="text" style="width:120px;" name="RANGDIAM_{ID}" value="{RANG_DIAMETRO}"/>
        				</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="RANG_DIAMETRO"/>
						</xsl:otherwise>
						</xsl:choose>
					</td>
					<td class="datosLeft">&nbsp;
						<xsl:choose>
						<xsl:when test="/Productos/INICIO/EDICION">
							<input type="text" style="width:120px;" name="RANGLONG_{ID}" value="{RANG_LONGITUD}"/>
        				</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="RANG_LONGITUD"/>
						</xsl:otherwise>
						</xsl:choose>
					</td>
					<td class="datosRight">&nbsp;<xsl:value-of select="TIPOIVA"/></td>
					<td class="datosRight">&nbsp;<xsl:value-of select="PRECIO"/></td>
					<th>&nbsp;</th>
					<td class="datosRight">&nbsp;<xsl:value-of select="TOTAL_LINEA"/>&nbsp;</td>
				</tr>
			</xsl:for-each>
			<tr class="subTituloTabla">
				<th align="left" colspan="4">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Valor_factura_sis']/node()"/></th>
				<th align="left" colspan="8">&nbsp;</th>
				<th align="right"><span id="TOTAL"><xsl:value-of select="/Productos/INICIO/PRODUCTOS/IMPORTE_TOTAL"/></span>&nbsp;</th>
			</tr>
			<tr>
				<th align="left" colspan="4">&nbsp;</th>
				<th align="left" colspan="6">&nbsp;</th>
				<th align="center">&nbsp;%&nbsp;</th>
				<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Liquidacion']/node()"/></th>
				<th>&nbsp;</th>
			</tr>
			<tr>
				<td align="left" colspan="4">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Reembolso_cartera']/node()"/></td>
				<td align="left" colspan="6">&nbsp;</td>
				<xsl:choose>
				<xsl:when test="/Productos/INICIO/EDICION">
					<td><input type="text" style="width:120px;" name="REEMBOLSO_CARTERA" onChange="javascript:RecalcularTotales();" value="{/Productos/INICIO/PROCEDIMIENTO/LIC_CEP_REEMBCARTERA}"/></td>
        			<td>
						<xsl:call-template name="desplegable">
            				<xsl:with-param name="path" select="/Productos/INICIO/IDTIPOLIQUIDACION/field"/>
            				<xsl:with-param name="style">width:140px;</xsl:with-param>
         				</xsl:call-template>
					</td>
        		</xsl:when>
				<xsl:otherwise>
					<td align="left">&nbsp;<xsl:value-of select="/Productos/INICIO/PROCEDIMIENTO/LIC_CEP_REEMBCARTERA"/>
						<input type="hidden" name="REEMBOLSO_CARTERA" value="{/Productos/INICIO/PROCEDIMIENTO/LIC_CEP_REEMBCARTERA}"/>
					</td>
        			<td>
						<xsl:call-template name="desplegable">
            				<xsl:with-param name="path" select="/Productos/INICIO/IDTIPOLIQUIDACION/field"/>
            				<xsl:with-param name="style">width:140px;</xsl:with-param>
            				<xsl:with-param name="deshabilitado">disabled</xsl:with-param>
         				</xsl:call-template>
					</td>
				</xsl:otherwise>
				</xsl:choose>
				<th align="right"><span id="BONIF1" style="color:#3d5d95;"></span>&nbsp;</th>
			</tr>
			<!--
			<tr class="subTituloTabla">
				<th align="left" colspan="4">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Valor_factura_cred']/node()"/></th>
				<td align="left" colspan="5">&nbsp;</td>
				<td align="center">&nbsp;%&nbsp;</td>
				<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Liquidacion']/node()"/></th>
				<td align="left">&nbsp;</td>
			</tr>
			<tr>
				<td align="left" colspan="4">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Bonificacion_corporativa']/node()"/></td>
				<td align="left" colspan="5">&nbsp;</td>
				<xsl:choose>
				<xsl:when test="/Productos/INICIO/EDICION">
					<td><input type="text" style="width:120px;" name="BONIF_CORPORATIVA" value="{/Productos/INICIO/PROCEDIMIENTO/LIC_CEP_BONIFCORPORATIVA}"/></td>
        		</xsl:when>
				<xsl:otherwise>
					<td align="left">&nbsp;<xsl:value-of select="/Productos/INICIO/PROCEDIMIENTO/LIC_CEP_BONIFCORPORATIVA"/></td>
				</xsl:otherwise>
				</xsl:choose>
			</tr>
			-->
			<tr class="subTituloTabla">
				<th align="center" colspan="13">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='De_proponer_bonificacion']/node()"/></th>
			</tr>
			<tr>
				<th align="left" colspan="6">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_bonificacion_01']/node()"/></th>
				<td align="left" colspan="4">&nbsp;</td>
				<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Cantidad_Bonificada']/node()"/></th>
				<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Consumo_meta']/node()"/></th>
				<th align="right"><!--<span id="TOTAL1"><xsl:value-of select="/Productos/INICIO/PRODUCTOS/IMPORTE_TOTAL"/></span>&nbsp;--></th>
			</tr>
			<tr>
				<td align="left" colspan="4">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Bonificacion_en_producto']/node()"/></td>
				<td align="left" colspan="6">&nbsp;</td>
				<xsl:choose>
				<xsl:when test="/Productos/INICIO/EDICION">
					<td><input type="text" style="width:120px;" name="CANT_BONIFICADA" onChange="javascript:RecalcularTotales();" value="{/Productos/INICIO/PROCEDIMIENTO/LIC_CEP_BP1_CANTBONIFICADA}"/></td>
					<td><input type="text" style="width:120px;" name="CONSUMO_META" onChange="javascript:RecalcularTotales();" value="{/Productos/INICIO/PROCEDIMIENTO/LIC_CEP_BP1_CONSUMOOBJ}"/></td>
        		</xsl:when>
				<xsl:otherwise>
					<td align="left">&nbsp;
						<xsl:value-of select="/Productos/INICIO/PROCEDIMIENTO/LIC_CEP_BP1_CANTBONIFICADA"/>
						<input type="hidden" name="CANT_BONIFICADA" value="{/Productos/INICIO/PROCEDIMIENTO/LIC_CEP_BP1_CANTBONIFICADA}"/>
					</td>
					<td align="left">&nbsp;
						<xsl:value-of select="/Productos/INICIO/PROCEDIMIENTO/LIC_CEP_BP1_CONSUMOOBJ"/>
						<input type="hidden" name="CONSUMO_META" value="{/Productos/INICIO/PROCEDIMIENTO/LIC_CEP_BP1_CONSUMOOBJ}"/>
					</td>
				</xsl:otherwise>
				</xsl:choose>
				<th align="right"><span id="BONIF2" style="color:#3d5d95;"></span>&nbsp;</th>
			</tr>
			<tr>
				<th align="left" colspan="6">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_bonificacion_02']/node()"/></th>
				<td align="left" colspan="6">&nbsp;</td>
				<!--
				<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Producto_Bonificado']/node()"/></th>
				<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Cantidad_Bonificada']/node()"/></th>
				-->
				<th align="right"><span id="BONIFPROD" style="color:#3d5d95;"></span>&nbsp;</th>
			</tr>
			<!--
			<tr>
				<td align="left" colspan="4">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Bonificacion_de_un_producto']/node()"/></td>
				<td align="left" colspan="6">&nbsp;</td>
				<xsl:choose>
				<xsl:when test="/Productos/INICIO/EDICION">
					<td><input type="text" style="width:120px;" name="PROD_BONIFICADO" value="{/Productos/INICIO/PROCEDIMIENTO/LIC_CEP_BP2_PRODUCTO}"/></td>
					<td><input type="text" style="width:120px;" name="CANT_PROD_BONIFICADO" value="{/Productos/INICIO/PROCEDIMIENTO/LIC_CEP_BP2_CANTIDAD}"/></td>
        		</xsl:when>
				<xsl:otherwise>
					<td align="left">&nbsp;<xsl:value-of select="/Productos/INICIO/PROCEDIMIENTO/LIC_CEP_BP2_PRODUCTO"/></td>
					<td align="left">&nbsp;<xsl:value-of select="/Productos/INICIO/PROCEDIMIENTO/LIC_CEP_BP2_CANTIDAD"/></td>
				</xsl:otherwise>
				</xsl:choose>
			</tr>
			-->
			<!--<tr class="subTituloTabla">-->
			<tr class="subTituloTabla">
				<th align="left" colspan="9">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_descuentos']/node()"/></th>
				<th align="left" colspan="3">&nbsp;</th>
				<th align="right"><span id="TOTAL_DESCUENTOS" style="color:#3d5d95;"></span>&nbsp;</th>
			</tr>
			<!--<tr class="subTituloTabla">-->
			<tr class="subTituloTabla">
				<th align="left" colspan="9">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Costo_neto_procedimiento']/node()"/></th>
				<th align="left" colspan="3">&nbsp;</th>
				<th align="right"><span id="TOTAL_FINAL"></span>&nbsp;</th>
			</tr>
		
			
        </xsl:when>
		<xsl:otherwise>
			<tr><td colspan="15" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_se_han_encontrado_resultados']/node()"/></strong></td></tr>
		</xsl:otherwise>
		</xsl:choose>
		</table>
		</form>
        </div><!--fin de divLeft-->
	</xsl:otherwise>
        </xsl:choose>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
