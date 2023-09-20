<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 |	Informe: Lista de búsquedas realizadas por los usuarios
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

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
</head>
<body>
	<xsl:choose>
<!-- ET Desactivado control errores: Habra que reactivarlo
	<xsl:when test="ListaDerechosUsuarios/xsql-error">
		<xsl:apply-templates select="ListaDerechosUsuarios/xsql-error"/>
	</xsl:when>
-->
	<xsl:when test="Busquedas/ROWSET/ROW/Sorry">
		<xsl:apply-templates select="Busquedas/ROWSET/ROW/Sorry"/>
	</xsl:when>
	<xsl:otherwise>

	<h1 class="titlePage">Volcado de Búsquedas en MedicalVM de los últimos 60 dias</h1>

	<div class="divLeft">
		<table class="grandeInicio">
			<!-- Titulo -->
			<tr class="titulos">
				<td class="dies">Fecha</td>
				<td class="veinte">Empresa</td>
				<td class="veinte">Usuario</td>
				<td class="trenta">Producto</td>
				<td class="trenta">Proveedor</td>
				<td class="dies">Resultado(Productos)</td>
			</tr>

		<xsl:for-each select="Busquedas/ROW">
			<tr>
				<td><xsl:value-of select="FECHA"/>&nbsp;</td>
				<td>
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDEMPRESA}&amp;VENTANA=NUEVA','DetalleEmpresa',100,80,0,0)">
						<xsl:value-of select="EMPRESA"/>&nbsp;
					</a>
				</td>
				<td><xsl:value-of select="USUARIO"/></td>
				<td><xsl:value-of select="LGC_NOMBRE"/></td>
				<td><xsl:value-of select="LGC_PROVEEDOR"/></td>
				<td><xsl:value-of select="LINEAS"/></td>
			</tr>
		</xsl:for-each>
		</table>
	</div>
	<br/><br/>
	</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>