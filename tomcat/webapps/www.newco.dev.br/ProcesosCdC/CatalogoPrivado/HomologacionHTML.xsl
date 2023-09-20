<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Ficha de homologación de producto. También permite informar de roturas de stock o bloqueos de proveedores
	Ultima revisión ET 16ene19 15:12
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
			<xsl:when test="/Homologacion/LANG"><xsl:value-of select="/Homologacion/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title>
		<xsl:value-of select="substring(/Homologacion/PRODUCTOS/NOMBREPRODUCTO,1,50)"/>: &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Homologacion_del_producto']/node()"/>
        </title>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/Homologacion_10ene18.js"></script>
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
			<form name="frmHomologacion" action="Homologacion.xsql" method="post">
			<input type="hidden" name="IDEMPRESA" value="{/Homologacion/PRODUCTOS/IDEMPRESA}"/>			
			<input type="hidden" name="REFERENCIA" value="{/Homologacion/PRODUCTOS/REFERENCIA}"/>			
			<input type="hidden" name="ACCION" value=""/>			
			<input type="hidden" name="PARAMETROS" value=""/>			
			<!--	Titulo de la página		-->
			<div class="ZonaTituloPagina">
				<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Homologacion_del_producto']/node()"/>
				</span>
					<span class="CompletarTitulo">
					<!--
					<xsl:if test="(/Homologacion/FAMILIA/MASTER or /Homologacion/FAMILIA/MASTER_UNICO) and /Homologacion/ACCION = 'MODIFICARFAMILIA'">
						&nbsp;&nbsp;&nbsp;<span class="amarillo">CP_CAT_ID:&nbsp;<xsl:value-of select="/Homologacion/CATEGORIA/ID"/></span>
					</xsl:if>
					-->
					</span>
				</p>
				<p class="TituloPagina">
					<xsl:value-of select="substring(/Homologacion/PRODUCTOS/NOMBREPRODUCTO,1,50)"/>.
					<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Homologacion/PRODUCTOS/LISTACENTROS/field"/>
						<xsl:with-param name="claSel">muygrande</xsl:with-param>
						<xsl:with-param name="onChange">javascript:CambioCentro();</xsl:with-param>
					</xsl:call-template>
					<span class="CompletarTitulo" style="width:300px;">
						<!--	Botones	-->
        				<!--	PENDIENTE	-->
						<a class="btnDestacado"  href="javascript:EnviarOrden();">
            				<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
            			</a>
						&nbsp;
        				<a class="btnNormal" href="javascript:document.location='about:blank'">
            				<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
            			</a>
						&nbsp;
					</span>
				</p>
			</div>
			<br/>
			<br/>
        	<div class="divLeft">
			<table class="buscador">
				<tr class="subTituloTabla">
					<td>&nbsp;</td>
					<td class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='autorizado']/node()"/></td>
					<td class="treinta"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></td>
					<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='orden']/node()"/></td>
					<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></td>
					<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></td>
					<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='PrecioRef']/node()"/></td>
					<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_fin_rotura']/node()"/></td>
					<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='explicacion']/node()"/></td>
					<!--<td class="cinco">&nbsp;</td>-->
					<td class="diez">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<xsl:if test="/Homologacion/PRODUCTOS/NO_ENCONTRADO">
				<tr>
					<td>&nbsp;</td>
					<td colspan="6"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto_no_encontrado']/node()"/></td>
					<td>&nbsp;</td>
				</tr>
				</xsl:if>
				<xsl:for-each select="/Homologacion/PRODUCTOS/PRODUCTO">
				<!--<tr class="sinLinea">-->
				<tr>
					
					<xsl:choose>
					<xsl:when test="CP_PRD_PROD_DESACTIVADO='S' or CP_PRD_PROV_DESACTIVADO='S'">
						<xsl:attribute name="class">fondoRojo</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<!--	pendiente	-->
					</xsl:otherwise>
					</xsl:choose>
					
					<td>&nbsp;</td>
					<td class="labelRight uno">
						<xsl:choose>
						<xsl:when test="CP_PRD_AUTORIZADO='S'">
							<input class="muypeq" type="checkbox" name="CHK_CENTRO_{CEN_ID}" checked="checked" disabled="true" />
						</xsl:when>
						<xsl:otherwise>
							<input class="muypeq" type="checkbox" name="CHK_CENTRO_{CEN_ID}" unchecked="unchecked" disabled="true" />
						</xsl:otherwise>
						</xsl:choose>
						&nbsp;
					</td>
					<td class="textLeft">
						<xsl:value-of select="PROVEEDOR"/>
					</td>
					<td class="textCenter">
						&nbsp;
						<!--<xsl:value-of select="CP_PRD_ORDEN"/>-->
						<!--	PENDIENTE-->
						<xsl:choose>
						<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
							<xsl:value-of select="CP_PRD_ORDEN"/>
						</xsl:when>
						<xsl:otherwise>
							<input type="text" class="muypeq" style="height:20px;" name="ORDEN_{CP_PRO_ID}" id="ORDEN_{CP_PRO_ID}" value="{CP_PRD_ORDEN}" size="2" maxlength="2"/>
						</xsl:otherwise>
						</xsl:choose>
						&nbsp;
					</td>
					<td class="textLeft">
						&nbsp;<xsl:value-of select="CP_PRD_REFCENTRO"/>
					</td>
					<td class="textLeft">
						<xsl:value-of select="TARIFA"/>
					</td>
					<td class="textCenter">
						<xsl:value-of select="CP_PRD_PRECIOREFERENCIA"/>
					</td>
					<td class="textLeft">
						<input type="text" class="peq" name="FECHA_{CP_PRO_ID}" id="FECHA_{CP_PRO_ID}" value="{FECHAPREVISTA}" size="10" maxlength="10"/>
					</td>
					<td class="textLeft">
						<input type="text" name="EXPLI_{CP_PRO_ID}" id="EXPLI_{CP_PRO_ID}" value="{CP_PRD_EXPLICACION}" size="40" maxlength="200"/>
					</td>
					<td>
						<xsl:choose>
						<xsl:when test="CP_PRD_PROV_DESACTIVADO='S'">
							&nbsp;<a class="btnDestacado" name="btnProveedor_{IDPROVEEDOR}" href="javascript:BloquearProveedor({IDPROVEEDOR},{CP_PRO_ID},'N');"><xsl:value-of select="document($doc)/translation/texts/item[@name='desbloquear']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a>&nbsp;
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="CP_PRD_PROD_DESACTIVADO!='S'">
							&nbsp;<a class="btnDestacado" name="btnProveedor_{IDPROVEEDOR}" href="javascript:BloquearProveedor({IDPROVEEDOR},{CP_PRO_ID},'S');"><xsl:value-of select="document($doc)/translation/texts/item[@name='bloquear']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a>&nbsp;
							</xsl:if>
						</xsl:otherwise>
						</xsl:choose>
						<span id="waitProveedor_{IDPROVEEDOR}" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></span>
					</td>
					<td>&nbsp;
						<xsl:choose>
						<xsl:when test="CP_PRD_PROD_DESACTIVADO='S'">
							&nbsp;<a class="btnDestacado" name="btnProducto_{CP_PRO_ID}" href="javascript:ProductoSinStock({CP_PRO_ID},'N');"><xsl:value-of select="document($doc)/translation/texts/item[@name='con_stock']/node()"/></a>&nbsp;
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="CP_PRD_PROV_DESACTIVADO!='S'">
							&nbsp;<a class="btnDestacado" name="btnProducto_{CP_PRO_ID}" href="javascript:ProductoSinStock({CP_PRO_ID},'S');"><xsl:value-of select="document($doc)/translation/texts/item[@name='sin_stock']/node()"/></a>&nbsp;
							</xsl:if>
						</xsl:otherwise>
						</xsl:choose>
						<span id="waitProducto_{CP_PRO_ID}" style="display:none;" class="clear"><img src="http://www.newco.dev.br/images/loading.gif"/></span>
					</td>
					<td>&nbsp;</td>
				</tr>
				</xsl:for-each>
			</table>
			</div>
			</form>
		</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
