<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 |	Estadisticas de acceso de los usuarios en MedicalVM
 |
 |	(c) 12/1/2001 ET
 |
+-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
	<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
	<xsl:param name="lang" select="@lang"/>

<xsl:template match="/">
<html>
<head>
	<title><xsl:value-of select="TITULO" disable-output-escaping="yes"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<xsl:text disable-output-escaping="yes"><![CDATA[
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript">
	<!--
		function EjecutarFuncionDelFrame(nombreFrame,idPlantilla){
			var objFrame=new Object();
			objFrame=obtenerFrame(top, nombreFrame);
			objFrame.CambioPlantillaExterno(idPlantilla);
		}
	//-->
	</script>
	]]></xsl:text>
</head>
<body>
<xsl:choose>
<!-- ET Desactivado control errores: Habra que reactivarlo
<xsl:when test="ListaDerechosUsuarios/xsql-error">
	<xsl:apply-templates select="ListaDerechosUsuarios/xsql-error"/>
</xsl:when>
-->
<xsl:when test="ProductosEnPlantillas/SESION_CADUCADA">
	<xsl:apply-templates select="CarpetasYPlantillas/SESION_CADUCADA"/>
</xsl:when>
<xsl:when test="ProductosEnPlantillas/ROWSET/ROW/Sorry">
	<xsl:apply-templates select="CarpetasYPlantillas/ROWSET/ROW/Sorry"/>
</xsl:when>
<xsl:otherwise>
	<br/><br/>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/ProductosEnPlantillas/LANG"><xsl:value-of select="/ProductosEnPlantillas/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<table class="grandeInicio">
	<thead>
		<tr class="tituloTabla">
			<th>&nbsp;</th>
			<th colspan="2">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='productos_en_plantillas_listado']/node()"/>&nbsp;(&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:&nbsp;<xsl:value-of select="ProductosEnPlantillas/PRODUCTOS/TOTAL"/>&nbsp;)
			</th>
			<th>&nbsp;</th>
		</tr>
		<tr class="titulos">
			<td class="cinco">&nbsp;</td>
			<td class="cuarenta textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></td>
			<td class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='plantillas']/node()"/></td>
			<td>&nbsp;</td>
		</tr>
	</thead>
	<tbody>
		<xsl:for-each select="ProductosEnPlantillas/PRODUCTOS/PRODUCTO">
		<tr>
			<td>&nbsp;</td>
			<td class="textLeft">
				<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID={ID}','producto',100,80,0,0);">
					<xsl:value-of select="NOMBRE"/>
				</a>
			</td>
			<td class="textLeft">
				<xsl:for-each select="PLANTILLAS/PLANTILLA">
				<a href="javascript:EjecutarFuncionDelFrame('zonaPlantilla',{ID});">
					<xsl:value-of select="NOMBRE"/>
				</a>
                                &nbsp;&nbsp;&nbsp;
                                <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDPROVEEDOR}','Ficha Proveedor',100,80,0,-50);" style="text-decoration:none">
					<img src="http://www.newco.dev.br/images/verFicha.gif">
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='abrir_ficha_proveedor']/node()"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='abrir_ficha_proveedor']/node()"/></xsl:attribute>
					</img>
				</a>
				</xsl:for-each>
			</td>
			<td>&nbsp;</td>
		</tr>
		</xsl:for-each>
	</tbody>

		<tr>
			<td>&nbsp;</td>
			<td class="textLeft"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/></strong></td>
			<td class="textLeft"><strong><xsl:value-of select="ProductosEnPlantillas/PRODUCTOS/TOTAL"/></strong></td>
			<td>&nbsp;</td>
		</tr>
	</table>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>