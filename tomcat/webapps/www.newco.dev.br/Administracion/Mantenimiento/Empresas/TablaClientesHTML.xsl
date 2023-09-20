<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Listado de empresas de MedicalVM con sus datos principales

	14set10		ET
+-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/">
<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/Centros/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
</head>
<body>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/Centros/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<table class="grandeInicio">
	<thead>
		<tr class="titulos">
			<td class="textLeft dos">&nbsp;</td>
			<td class="textLeft quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></td>
			<td class="textLeft quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></td>
			<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='cif']/node()"/></td>
			<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='direccion']/node()"/></td>
			<td class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='poblacion']/node()"/></td>
			<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_postal']/node()"/></td>
			<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='telefono']/node()"/></td>
			<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='fax']/node()"/></td>
		</tr>
	</thead>

	<tbody>
	<xsl:for-each select="/Centros/CENTROS/CENTRO">
		<tr>
			<td class="textLeft"><xsl:value-of select="COUNT"/></td>
			<td class="textLeft">
				<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDEMPRESA}','empresa',100,80,0,0);">
					<xsl:value-of select="EMPRESA"/>
                                </a>
			</td>
			<td class="textLeft">
                            <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={ID}','Centro',100,80,0,0);">
                                <xsl:value-of select="NOMBRE"/>
                            </a>
                        </td>
			<td class="textLeft"><xsl:value-of select="NIF"/></td>
			<td class="textLeft"><xsl:value-of select="DIRECCION"/></td>
			<td class="textLeft"><xsl:value-of select="POBLACION"/></td>
			<td><xsl:value-of select="COD_POSTAL"/></td>
			<td><xsl:value-of select="TELEFONO"/></td>
			<td><xsl:value-of select="FAX"/></td>
		</tr>
	</xsl:for-each>
	</tbody>

	<tfoot></tfoot>
	</table>
</body>
</html>
</xsl:template>
</xsl:stylesheet>