<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Informar procedimientos en convocatoria de elementos especiales. Nuevo disenno 2022.
	Ultima revision ET 23may22 15:31 InformarProcedimientos2022_230522.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

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

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/InformarProcedimientos_041218.js"></script>
	<script type="text/javascript">
		var strReferenciaObligatoria= '<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia_obli']/node()"/>';	
		var strConfirmBorrarOferta= '<xsl:value-of select="document($doc)/translation/texts/item[@name='confirm_borrar_oferta']/node()"/>';
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
		<!--<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimiento']/node()"/></span>
			<span class="CompletarTitulo">
			</span>
		</p>-->
		<br/>
		<p class="TituloPagina">
			<xsl:value-of select="/Productos/INICIO/CONVOCATORIA"/>
			<span class="CompletarTitulo500">
				<xsl:choose>
				<xsl:when test="/Productos/INICIO/ROL='VENDEDOR'">
					<xsl:if test="/Productos/INICIO/EDICION">
					<a class="btnDestacado" href="javascript:ValidarYEnviar();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
					</a>
					&nbsp;
					</xsl:if>
					<a class="btnDestacado" href="javascript:BorrarOferta();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/ConvocatoriasEspeciales2022.xsql">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Subir_productos']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProcedimientos2022.xsql','convesp_buscadores',100,80,0,-10);">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimientos']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProductos2022.xsql','convesp_buscadores',100,80,0,-10);">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>
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
					<a class="btnNormal" href="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/Proveedores2022.xsql">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProcedimientos2022.xsql">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimientos']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProductos2022.xsql">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>
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
		<form name="Procedimiento" method="post" action="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/InformarProcedimientos2022.xsql">
		<input type="hidden" name="ROL"/>
		<input type="hidden" name="ACCION"/>
		<input type="hidden" name="PARAMETROS"/>
		<input type="hidden" name="FIDCONVOCATORIA" value="{/Productos/INICIO/IDCONVOCATORIA}"/>
		<table cellspacing="6px" cellpadding="6px">
		<!--<tr style="height:30px;">
		<td width="300px" class="labelRight">
      		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatoria']/node()"/>:&nbsp;</label>
		</td>
		<td width="450px" class="textLeft">
        	<xsl:call-template name="desplegable">
            	<xsl:with-param name="path" select="/Productos/INICIO/FIDCONVOCATORIA/field"/>
            	<xsl:with-param name="defecto" select="/Productos/INICIO/FIDCONVOCATORIA/field/@current"/>
            	<xsl:with-param name="claSel">w400px</xsl:with-param>
            	<xsl:with-param name="onChange">javascript:CambioDesplegables('CAMBIO_CONVOCATORIA');</xsl:with-param>
        	</xsl:call-template>
		</td>
		<td width="*">
      		&nbsp;
		</td>
		</tr>-->
		<xsl:if test="/Productos/INICIO/ROL='COMPRADOR'">
		<tr style="height:30px;">
		<td class="labelRight">
        	<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:&nbsp;</label>
		</td>
		<td class="textLeft">
        	<xsl:call-template name="desplegable">
            	<xsl:with-param name="path" select="/Productos/INICIO/FIDPROVEEDOR/field"/>
            	<xsl:with-param name="defecto" select="/Productos/INICIO/FIDPROVEEDOR/field/@current"/>
            	<xsl:with-param name="claSel">w400px</xsl:with-param>
            	<xsl:with-param name="onChange">javascript:CambioDesplegables('CAMBIO_PROVEEDOR');</xsl:with-param>
        	</xsl:call-template>
		</td>
		<td width="*">
      		&nbsp;
		</td>
		</tr>
		</xsl:if>
		<tr style="height:30px;">
		<td class="labelRight">
        	<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Especialidad']/node()"/>:&nbsp;</label>
		</td>
		<td class="textLeft">
        	<xsl:call-template name="desplegable">
            	<xsl:with-param name="path" select="/Productos/INICIO/FIDESPECIALIDAD/field"/>
            	<xsl:with-param name="defecto" select="/Productos/INICIO/FIDESPECIALIDAD/field/@current"/>
            	<xsl:with-param name="claSel">w400px</xsl:with-param>
            	<xsl:with-param name="onChange">javascript:CambioDesplegables('CAMBIO_ESPECIALIDAD');</xsl:with-param>
        	</xsl:call-template>
		</td>
		<td width="*">
      		&nbsp;
		</td>
		</tr>
		<tr style="height:30px;">
		<td class="labelRight">
        	<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimiento']/node()"/>:&nbsp;</label>
		</td>
		<td class="textLeft">
        	<xsl:call-template name="desplegable">
            	<xsl:with-param name="path" select="/Productos/INICIO/FIDPROCEDIMIENTO/field"/>
            	<xsl:with-param name="defecto" select="/Productos/INICIO/FIDPROCEDIMIENTO/field/@current"/>
            	<xsl:with-param name="claSel">w400px</xsl:with-param>
            	<xsl:with-param name="onChange">javascript:CambioDesplegables('CAMBIO_PROCEDIMIENTO');</xsl:with-param>
        	</xsl:call-template>
		</td>
		<td width="*">
      		&nbsp;
		</td>
		</tr>
		</table>
		<BR/><BR/><BR/>
		<xsl:if test="/Productos/INICIO/HISTORICO/PROVEEDOR!=''"><!--23may22 Esta info solo para clientes-->
			<table cellspacing="6px" cellpadding="6px">
			<tr>
			<td class="textRight">
				<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='Historico']/node()"/>:&nbsp;</strong>
			</td>
			<td class="textLeft">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label>&nbsp;<strong><xsl:value-of select="/Productos/INICIO/HISTORICO/PROVEEDOR"/></strong>&nbsp;
			</td>
			<td class="textLeft">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/>:</label>&nbsp;<strong><xsl:value-of select="/Productos/INICIO/HISTORICO/LIC_CMP_CONSUMOHISTORICO"/></strong>&nbsp;
			</td>
			<td class="textLeft">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Valor_factura']/node()"/>:</label>&nbsp;<strong><xsl:value-of select="/Productos/INICIO/HISTORICO/LIC_CMP_PRECIOREFERENCIA"/></strong>&nbsp;
			</td>
			<td class="textLeft">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Costo_neto']/node()"/>:</label>&nbsp;<strong><xsl:value-of select="/Productos/INICIO/HISTORICO/LIC_CMP_PRECIOREFERENCIADESC"/></strong>&nbsp;
			</td>
			<td class="textLeft veinte">
				&nbsp;
			</td>
			</tr>
			</table>
			<BR/>
		</xsl:if>	

		<div class="tabela tabela_redonda">
		<table cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
			<tr>
				<th class="w1px"></th>
				<th class="textLeft w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
				<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
				<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Bonif']/node()"/></th>
				<th class="textLeft w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/></th>
				<th class="textLeft w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></th>
				<th class="textLeft w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='RangDiametro']/node()"/></th>
				<th class="textLeft w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='RangLongitud']/node()"/></th>
				<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/></th>
				<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ud_basica']/node()"/></th>
				<!--23may22<th class="w50px"></th>-->
				<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='TotalLinea']/node()"/></th>
			</tr>
		</thead>
		<!--	Cuerpo de la tabla	-->
		<tbody class="corpo_tabela">
        <xsl:choose>
		<xsl:when test="/Productos/INICIO/PRODUCTOS/PRODUCTO">
			<xsl:for-each select="/Productos/INICIO/PRODUCTOS/PRODUCTO">
				<tr id="PRO_{ID}" class="con_hover">
                    <td class="color_status">
						<xsl:value-of select="LINEA"/>
						<input type="hidden" name="REFCLIENTE_{ID}" value="{REFERENCIA}"/>
						<input type="hidden" name="PRECIO_{ID}" value="{PRECIO}"/>
						<input type="hidden" name="TOTALLINEA_{ID}" value="{TOTAL_LINEA}"/>
					</td>
					<td class="textLeft">&nbsp;<xsl:value-of select="REFERENCIA"/></td>
					<td class="textLeft">&nbsp;<xsl:value-of select="PRODUCTO"/></td>
					<td class="textRight">&nbsp;<xsl:value-of select="CANTIDAD"/></td>
					<td class="textRight">&nbsp;
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
					<td class="textLeft">&nbsp;
						<xsl:choose>
						<xsl:when test="/Productos/INICIO/EDICION">
							<input type="text" class="campopesquisa w100px" name="REFPROV_{ID}" value="{REFPROVEEDOR}"/>
        				</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="REFPROVEEDOR"/>
							<input type="hidden" name="REFPROV_{ID}" value="{REFPROVEEDOR}"/>
						</xsl:otherwise>
						</xsl:choose>
					</td>
					<td class="textLeft">&nbsp;
						<xsl:value-of select="MARCA"/>
					</td>
					<td class="textRight">&nbsp;
						<xsl:choose>
						<xsl:when test="/Productos/INICIO/EDICION">
							<input type="text" class="campopesquisa w100px" name="RANGDIAM_{ID}" value="{RANG_DIAMETRO}"/>
        				</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="RANG_DIAMETRO"/>
						</xsl:otherwise>
						</xsl:choose>
					</td>
					<td class="textLeft">&nbsp;
						<xsl:choose>
						<xsl:when test="/Productos/INICIO/EDICION">
							<input type="text" class="campopesquisa w100px" name="RANGLONG_{ID}" value="{RANG_LONGITUD}"/>
        				</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="RANG_LONGITUD"/>
						</xsl:otherwise>
						</xsl:choose>
					</td>
					<td class="textRight">&nbsp;<xsl:value-of select="TIPOIVA"/></td>
					<td class="textRight">&nbsp;<xsl:value-of select="PRECIO"/></td>
					<!--23may22	<th>&nbsp;</th>-->
					<td class="textRight">&nbsp;<xsl:value-of select="TOTAL_LINEA"/>&nbsp;</td>
				</tr>
			</xsl:for-each>
			<tfoot class="rodape_tabela">
				<td class="textLeft" colspan="4">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Valor_factura_sis']/node()"/></td>
				<td class="textLeft" colspan="7">&nbsp;</td>
				<td align="right"><span id="TOTAL"><xsl:value-of select="/Productos/INICIO/PRODUCTOS/IMPORTE_TOTAL"/></span>&nbsp;</td>
			</tfoot>
        	</xsl:when>
			<xsl:otherwise>
				<tr><td colspan="15" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_se_han_encontrado_resultados']/node()"/></strong></td></tr>
			</xsl:otherwise>
			</xsl:choose>
		</tbody>
		</table>
		<br/>
		<!--23may22 Separamos la tabla de producto de los descuentos-->
		<table cellspacing="6px" cellpadding="6px">
		<tbody>
			<tr>
				<td class="textLeft">&nbsp;</td>
				<td class="textLeft">&nbsp;</td>
				<td class="labelCenter w150px">&nbsp;%&nbsp;</td>
				<td class="labelCenter w150px">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Liquidacion']/node()"/></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td class="textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Reembolso_cartera']/node()"/></td>
				<td class="textLeft">&nbsp;</td>
				<xsl:choose>
				<xsl:when test="/Productos/INICIO/EDICION">
					<td><input type="text" class="campopesquisa w100px" name="REEMBOLSO_CARTERA" onChange="javascript:RecalcularTotales();" value="{/Productos/INICIO/PROCEDIMIENTO/LIC_CEP_REEMBCARTERA}"/></td>
        			<td>
						<xsl:call-template name="desplegable">
            				<xsl:with-param name="path" select="/Productos/INICIO/IDTIPOLIQUIDACION/field"/>
            				<xsl:with-param name="claSel">w140px</xsl:with-param>
         				</xsl:call-template>
					</td>
        		</xsl:when>
				<xsl:otherwise>
					<td class="textRight">&nbsp;<xsl:value-of select="/Productos/INICIO/PROCEDIMIENTO/LIC_CEP_REEMBCARTERA"/>
						<input type="hidden" name="REEMBOLSO_CARTERA" value="{/Productos/INICIO/PROCEDIMIENTO/LIC_CEP_REEMBCARTERA}"/>
					</td>
        			<td>
						<xsl:call-template name="desplegable">
            				<xsl:with-param name="path" select="/Productos/INICIO/IDTIPOLIQUIDACION/field"/>
            				<xsl:with-param name="claSel">w140px</xsl:with-param>
            				<xsl:with-param name="deshabilitado">disabled</xsl:with-param>
         				</xsl:call-template>
					</td>
				</xsl:otherwise>
				</xsl:choose>
				<td align="right"><span id="BONIF1" class="colorAzul"></span>&nbsp;</td>
			</tr>
			<tr class="subTituloTabla">
				<td align="center" colspan="6">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='De_proponer_bonificacion']/node()"/></td>
			</tr>
			<tr>
				<td class="textLeft"><span class="fuentePeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_bonificacion_01']/node()"/></span></td>
				<td class="textLeft">&nbsp;</td>
				<td class="textLeft"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='Cantidad_Bonificada']/node()"/></label></td>
				<td class="textLeft"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='Consumo_meta']/node()"/></label></td>
				<td align="right"><!--<span id="TOTAL1"><xsl:value-of select="/Productos/INICIO/PRODUCTOS/IMPORTE_TOTAL"/></span>&nbsp;--></td>
			</tr>
			<tr>
				<td class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='Bonificacion_en_producto']/node()"/></td>
				<td class="textLeft">&nbsp;</td>
				<xsl:choose>
				<xsl:when test="/Productos/INICIO/EDICION">
					<td><input type="text" class="campopesquisa w100px" name="CANT_BONIFICADA" onChange="javascript:RecalcularTotales();" value="{/Productos/INICIO/PROCEDIMIENTO/LIC_CEP_BP1_CANTBONIFICADA}"/></td>
					<td><input type="text" class="campopesquisa w100px" name="CONSUMO_META" onChange="javascript:RecalcularTotales();" value="{/Productos/INICIO/PROCEDIMIENTO/LIC_CEP_BP1_CONSUMOOBJ}"/></td>
        		</xsl:when>
				<xsl:otherwise>
					<td class="textRight">&nbsp;
						<xsl:value-of select="/Productos/INICIO/PROCEDIMIENTO/LIC_CEP_BP1_CANTBONIFICADA"/>
						<input type="hidden" name="CANT_BONIFICADA" value="{/Productos/INICIO/PROCEDIMIENTO/LIC_CEP_BP1_CANTBONIFICADA}"/>
					</td>
					<td class="textRight">&nbsp;
						<xsl:value-of select="/Productos/INICIO/PROCEDIMIENTO/LIC_CEP_BP1_CONSUMOOBJ"/>
						<input type="hidden" name="CONSUMO_META" value="{/Productos/INICIO/PROCEDIMIENTO/LIC_CEP_BP1_CONSUMOOBJ}"/>
					</td>
				</xsl:otherwise>
				</xsl:choose>
				<td class="textLeft">&nbsp;</td>
				<td align="right"><span id="BONIF2" class="colorAzul"></span>&nbsp;</td>
			</tr>
			<tr>
				<td class="textLeft" colspan="4"><span class="fuentePeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_bonificacion_02']/node()"/></span></td>
				<td class="textLeft">&nbsp;</td>
				<td align="right"><span id="BONIFPROD" class="colorAzul"></span>&nbsp;</td>
			</tr>
			<tr class="subTituloTabla">
				<td class="textLeft" colspan="4">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Total_descuentos']/node()"/></td>
				<td class="textLeft">&nbsp;</td>
				<td align="right"><span id="TOTAL_DESCUENTOS" class="colorAzul"></span>&nbsp;</td>
			</tr>
			<tr class="subTituloTabla">
				<td class="textLeft" colspan="4">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Costo_neto_procedimiento']/node()"/></td>
				<td class="textLeft">&nbsp;</td>
				<td align="right"><span id="TOTAL_FINAL" class="colorAzul"></span>&nbsp;</td>
			</tr>
	</tbody>
<!--		<tfoot class="rodape_tabela">
			<tr><td colspan="15">&nbsp;</td></tr>
		</tfoot>-->
	</table>
 	</div>
 	<br/>  
 	<br/>  
	</form>
    </div>
	</xsl:otherwise>
    </xsl:choose>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
