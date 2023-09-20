<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 |	Mantenimiento de fichero de integracion para pedidos
 |
 |	(c) 24/07/2013 DC
 |
+-->
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
			<xsl:when test="/MantFicheroIntegracion/LANG"><xsl:value-of select="/MantFicheroIntegracion/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='mant_fichero_integracion']/node()"/></title>
	<xsl:call-template name="estiloIndip"/>
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/AdminTecnica/admintecnica_220816.js"></script>
	<script type="text/javascript">
		var linea_fichero_actualizada = '<xsl:value-of select="document($doc)/translation/texts/item[@name='linea_fichero_actualizada']/node()"/>';

		function cerrarVentana(){
			window.close();
		}
	</script>
</head>

<body>
<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
	<xsl:when test="/MantFicheroIntegracion/LANG"><xsl:value-of select="/MantFicheroIntegracion/LANG"/></xsl:when>
	<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<xsl:choose>
<xsl:when test="/MantFicheroIntegracion/ERROR">
	<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='mant_fichero_integracion']/node()"/></h1>
	<h2 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></h2>
</xsl:when>
<xsl:otherwise>
	<!-- Bloque de título -->
	<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='mant_fichero_integracion']/node()"/> - INTF_ID: <xsl:value-of select="/MantFicheroIntegracion/INTF_ID"/></h1>
	<br />

	<div class="divLeft50nopa">
	<!--tabla izquierda especificas producto-->
	<table class="prodTabla">
		<tr height="5px;">
			<td class="cuarenta" height="5px;">&nbsp;</td>
			<td height="5px;">&nbsp;</td>
		</tr>
	<tbody>
		<tr>
			<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_fichero']/node()"/>:</td>
			<td class="valor">&nbsp;<xsl:value-of select="/MantFicheroIntegracion/FICHERO/NOMBRE"/></td>
		</tr>
		<tr>
			<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='accion']/node()"/>:</td>
			<td class="valor">&nbsp;<xsl:value-of select="/MantFicheroIntegracion/FICHERO/ACCION"/></td>
		</tr>
		<tr>
			<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/>:</td>
			<td class="valor">&nbsp;<xsl:value-of select="/MantFicheroIntegracion/FICHERO/CLIENTE"/></td>
		</tr>
		<tr>
			<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/>:</td>
			<td class="valor">&nbsp;<xsl:value-of select="/MantFicheroIntegracion/FICHERO/COMENTARIOS"/></td>
		</tr>
	</tbody>
	</table>
        </div>
	<div class="divLeft50nopa">
	<!--tabla izquierda especificas producto-->
	<table class="prodTabla">
		<tr height="5px;">
			<td class="cuarenta" height="5px;">&nbsp;</td>
			<td height="5px;">&nbsp;</td>
		</tr>
	<tbody>
		<tr>
			<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:</td>
			<td class="valor">&nbsp;<xsl:value-of select="/MantFicheroIntegracion/FICHERO/FECHA"/></td>
		</tr>
		<tr>
			<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>:</td>
			<td class="valor">&nbsp;<xsl:value-of select="/MantFicheroIntegracion/FICHERO/ESTADO"/></td>
		</tr>
		<tr>
			<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</td>
			<td class="valor">&nbsp;<xsl:value-of select="/MantFicheroIntegracion/FICHERO/PROVEEDOR"/></td>
		</tr>
		<tr>
			<td class="label">&nbsp;</td>
			<td class="valor">&nbsp;</td>
		</tr>
	</tbody>
	</table>
        </div>

	<table align="center" class="encuesta">
	<thead>
		<tr class="titulos">
			<td align="center"><xsl:value-of select="document($doc)/translation/texts/item[@name='num_linea']/node()"/></td>
			<td align="center"><xsl:value-of select="document($doc)/translation/texts/item[@name='texto_linea']/node()"/></td>
			<td align="center"><xsl:value-of select="document($doc)/translation/texts/item[@name='acciones']/node()"/></td>
		</tr>
	</thead>
	<tbody>
	<xsl:for-each select="/MantFicheroIntegracion/FICHERO/LINEA">
		<tr>
                    
		<xsl:if test="INTL_TIPO = 'ERROR' or (INTL_TIPO = 'PRODUCTO' and INTL_COMENTARIOS != '')">
			<xsl:attribute name="class">amarillo</xsl:attribute>
		</xsl:if>
			<td align="center"><xsl:value-of select="INTL_LINEA"/></td>
			<td align="left">
			<xsl:if test="INTL_COMENTARIOS != ''">
				<a href="javascript:verComentarios('{INTL_COMENTARIOS}');">(<xsl:value-of select="document($doc)/translation/texts/item[@name='ver']/node()"/>)</a>&nbsp;
			</xsl:if>
			<xsl:choose>
			<xsl:when test="INTL_TIPO = 'PRODUCTO' and INTL_COMENTARIOS != ''">
				<input type="text" name="input_{/MantFicheroIntegracion/INTF_ID}_{INTL_LINEA}" id="input_{/MantFicheroIntegracion/INTF_ID}_{INTL_LINEA}" value="{INTL_TEXTO}" size="120"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="INTL_TEXTO"/>
			</xsl:otherwise>
			</xsl:choose>
			</td>
			<td align="center">
			<xsl:choose>
			<xsl:when test="INTL_TIPO = 'PRODUCTO' and INTL_COMENTARIOS != ''">
				<a href="javascript:modificarLinea({/MantFicheroIntegracion/INTF_ID},{INTL_LINEA});">
					<img src="http://www.newco.dev.br/images/actualizarFlecha.gif">
						<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar_los_cambios']/node()"/></xsl:attribute>
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar_los_cambios']/node()"/></xsl:attribute>
                	                </img>
				</a>
			</xsl:when>
			<xsl:when test="INTL_TIPO = 'ERROR'">
				<a href="javascript:marcarComentarios({/MantFicheroIntegracion/INTF_ID},{INTL_LINEA});"><xsl:value-of select="document($doc)/translation/texts/item[@name='marcar_comentarios']/node()"/></a>
			</xsl:when>
			</xsl:choose>
			</td>
                </tr>
	</xsl:for-each>
	</tbody>
	</table><br />

</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
