<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Ficha de homologación de producto. También permite informar de roturas de stock o bloqueos de proveedores. Nuevo disenno.
	Ultima revisión  ET 26mar23 12:15 Homologacion2022_260523.js
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
			<xsl:when test="/Homologacion/LANG"><xsl:value-of select="/Homologacion/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title>
		<xsl:value-of select="/Homologacion/PRODUCTOS/REFESTANDAR"/>.&nbsp;<xsl:value-of select="substring(/Homologacion/PRODUCTOS/NOMBREPRODUCTO,1,50)"/>: &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Homologacion_del_producto']/node()"/>
    </title>
	
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/Homologacion2022_260523.js"></script>
</head>

<!--<body class="gris">-->
<body>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/Homologacion/LANG"><xsl:value-of select="/Homologacion/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:choose>
		<xsl:when test="SESION_CADUCADA">
			<xsl:apply-templates select="CarpetasYPlantillas/SESION_CADUCADA"/>
		</xsl:when>
		<xsl:otherwise>
			<form name="frmHomologacion" action="Homologacion2022.xsql" method="post">
			<input type="hidden" name="IDEMPRESA" value="{/Homologacion/PRODUCTOS/IDEMPRESA}"/>			
			<input type="hidden" name="REFERENCIA" id="REFERENCIA" value="{/Homologacion/PRODUCTOS/REFESTANDAR}"/>		<!--10mar23 Pasamos a utilizar la ref. estandar REFESTANDAR-->	
			<input type="hidden" name="ACCION" value=""/>			
			<input type="hidden" name="PARAMETROS" value=""/>			
			<!--	Titulo de la página		-->
			<div class="ZonaTituloPagina">
				<p class="TituloPagina">
					(<xsl:value-of select="/Homologacion/PRODUCTOS/REFESTANDAR"/>).&nbsp;<xsl:value-of select="/Homologacion/PRODUCTOS/CP_PRO_REFCLIENTE"/>&nbsp;<xsl:value-of select="substring(/Homologacion/PRODUCTOS/NOMBREPRODUCTO,1,50)"/>.&nbsp;
					<span class="CompletarTitulo" style="width:300px;">
						<!--	Botones	-->
        				<!--	PENDIENTE	-->
						<xsl:if test="/Homologacion/PRODUCTOS/EDICION"><!--25nov22 comprobar derechos edicion-->
							<a class="btnDestacado"  href="javascript:EnviarOrden();">
            					<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
            				</a>
							&nbsp;
						</xsl:if>
        				<!--
						<a class="btnNormal" href="javascript:document.location='about:blank'">
            				<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
            			</a>
						-->
					</span>
				</p>
			</div>
			<br/>
			<br/>
			<p class="marginLeft100">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;</label>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/Homologacion/PRODUCTOS/LISTACENTROS/field"/>
					<xsl:with-param name="claSel">w300px</xsl:with-param>
					<xsl:with-param name="onChange">javascript:CambioCentro();</xsl:with-param>
				</xsl:call-template>
			</p>
			<br/>
			<br/>
			<div class="tabela tabela_redonda">
			<table cellspacing="6px" cellpadding="6px">
				<thead class="cabecalho_tabela">
				<tr>
					<th class="w1x"></th>
					<th class="w1x"><xsl:value-of select="document($doc)/translation/texts/item[@name='Aut']/node()"/></th>
					<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
					<th class="w60px"><xsl:value-of select="document($doc)/translation/texts/item[@name='orden']/node()"/></th>
					<th class="w80px"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></th>
					<th class="w80px"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></th>
					<th class="w80px"><xsl:value-of select="document($doc)/translation/texts/item[@name='PrecioRef']/node()"/></th>
					<th class="w60px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_fin_rotura']/node()"/></th>
					<th class="w300px"><xsl:value-of select="document($doc)/translation/texts/item[@name='explicacion']/node()"/></th>
					<th class="w70px">&nbsp;</th>
					<th class="w70px">&nbsp;</th>
					<th class="w1x"></th>
				</tr>
				</thead>
				<!--	Cuerpo de la tabla	-->
				<tbody class="corpo_tabela">
					<xsl:if test="/Homologacion/PRODUCTOS/NO_ENCONTRADO">
					<tr>
						<td class="color_status">&nbsp;</td>
						<td colspan="9"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto_no_encontrado']/node()"/></td>
						<td>&nbsp;</td>
					</tr>
					</xsl:if>
					<xsl:for-each select="/Homologacion/PRODUCTOS/PRODUCTO">
					<tr>
						<xsl:choose>
						<xsl:when test="CP_PRD_PROD_DESACTIVADO='S' or CP_PRD_PROV_DESACTIVADO='S'">
							<xsl:attribute name="class">fondoRojo</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<!--	pendiente	-->
						</xsl:otherwise>
						</xsl:choose>

						<td class="color_status">&nbsp;</td>
						<td class="labelRight uno">
							<input class="muypeq" type="checkbox" name="CHK_CENTRO_{CP_PRO_ID}" id="CHK_CENTRO_{CP_PRO_ID}">
							<xsl:choose>
							<xsl:when test="CP_PRD_AUTORIZADO='S'">
								<xsl:attribute name="checked" value="checked"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="unchecked" value="unchecked"/>
							</xsl:otherwise>
							</xsl:choose>
							<xsl:if test="not(/Homologacion/PRODUCTOS/EDICION)">
								<xsl:attribute name="disabled" value="disabled"/>
							</xsl:if>
							</input>
							&nbsp;
						</td>
						<td class="textLeft">
							<xsl:value-of select="PROVEEDOR"/>
						</td>
						<td class="textCenter">
							&nbsp;
							<input type="text" class="campopesquisa w40px" name="ORDEN_{CP_PRO_ID}" id="ORDEN_{CP_PRO_ID}" value="{CP_PRD_ORDEN}" maxlength="2">
							<xsl:if test="not(/Homologacion/PRODUCTOS/EDICION)">
								<xsl:attribute name="disabled" value="disabled"/>
							</xsl:if>
							</input>
							&nbsp;
						</td>
						
						<!--28mar23 Permitimos editarla ref. del centro	-->
						<xsl:choose>
						<xsl:when test="CONTADOR=1 and /Homologacion/PRODUCTOS/EDICION">
							<td class="textLeft w150px">
								<input type="text" class="campopesquisa w120px" name="REFCENTRO" id="REFCENTRO" value="{CP_PRD_REFCENTRO}" maxlength="20" oninput="javascript:ActivaBtnGuardarRef();"/>
								<a id="btnGuardaRef" href="javascript:GuardarRefCentro()"  style="display:none;">
									<img src="http://www.newco.dev.br/images/2022/refresh-button.png" class="valignM"/>								
								</a>
								<img id="chkOK" src="http://www.newco.dev.br/images/check.gif" style="display:none;"/>
								<img id="chkError" src="http://www.newco.dev.br/images/error.gif" style="display:none;"/>							
							</td>
						</xsl:when>
						<xsl:otherwise>
							<td class="textLeft RefCentro">
								<xsl:value-of select="CP_PRD_REFCENTRO"/>
							</td>
						</xsl:otherwise>
						</xsl:choose>

						<td class="textLeft">
							<xsl:value-of select="TARIFA"/>
						</td>
						<td class="textCenter">
							<xsl:value-of select="CP_PRD_PRECIOREFERENCIA"/>
						</td>
						<td class="textLeft">
							<input type="text"  class="campopesquisa w100px" name="FECHA_{CP_PRO_ID}" id="FECHA_{CP_PRO_ID}" value="{FECHAPREVISTA}" maxlength="10">
							<xsl:if test="not(/Homologacion/PRODUCTOS/EDICION)">
								<xsl:attribute name="disabled" value="disabled"/>
							</xsl:if>
							</input>
						</td>
						<td class="textLeft">
							<input type="text" class="campopesquisa w300px" name="EXPLI_{CP_PRO_ID}" id="EXPLI_{CP_PRO_ID}" value="{CP_PRD_EXPLICACION}" size="40" maxlength="200">
							<xsl:if test="not(/Homologacion/PRODUCTOS/EDICION)">
								<xsl:attribute name="disabled" value="disabled"/>
							</xsl:if>
							</input>
						</td>
						<td>
							<xsl:if test="/Homologacion/PRODUCTOS/EDICION">
								<xsl:choose>
								<xsl:when test="CP_PRD_PROV_DESACTIVADO='S'">
									&nbsp;<a class="btnDestacadoPeq" name="btnProveedor_{IDPROVEEDOR}" href="javascript:BloquearProveedor({IDPROVEEDOR},{CP_PRO_ID},'N');"><xsl:value-of select="document($doc)/translation/texts/item[@name='desbloquear']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a>&nbsp;
								</xsl:when>
								<xsl:otherwise>
									<xsl:if test="CP_PRD_PROD_DESACTIVADO!='S'">
									&nbsp;<a class="btnDestacadoPeq" name="btnProveedor_{IDPROVEEDOR}" href="javascript:BloquearProveedor({IDPROVEEDOR},{CP_PRO_ID},'S');"><xsl:value-of select="document($doc)/translation/texts/item[@name='bloquear']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a>&nbsp;
									</xsl:if>
								</xsl:otherwise>
								</xsl:choose>
								<span id="waitProveedor_{IDPROVEEDOR}" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></span>
							</xsl:if>
						</td>
						<td>&nbsp;
							<xsl:if test="/Homologacion/PRODUCTOS/EDICION">
								<xsl:choose>
								<xsl:when test="CP_PRD_PROD_DESACTIVADO='S'">
									&nbsp;<a class="btnDestacadoPeq" name="btnProducto_{CP_PRO_ID}" href="javascript:ProductoSinStock({CP_PRO_ID},'N');"><xsl:value-of select="document($doc)/translation/texts/item[@name='con_stock']/node()"/></a>&nbsp;
								</xsl:when>
								<xsl:otherwise>
									<xsl:if test="CP_PRD_PROV_DESACTIVADO!='S'">
									&nbsp;<a class="btnDestacadoPeq" name="btnProducto_{CP_PRO_ID}" href="javascript:ProductoSinStock({CP_PRO_ID},'S');"><xsl:value-of select="document($doc)/translation/texts/item[@name='sin_stock']/node()"/></a>&nbsp;
									</xsl:if>
								</xsl:otherwise>
								</xsl:choose>
								<span id="waitProducto_{CP_PRO_ID}" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></span>
							</xsl:if>
						</td>
						<td>&nbsp;</td>
					</tr>
					</xsl:for-each>
				</tbody>
				<tfoot class="rodape_tabela">
					<tr><td colspan="12">&nbsp;</td></tr>
				</tfoot>
			</table>
 			</div>
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
			</form>
		</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
