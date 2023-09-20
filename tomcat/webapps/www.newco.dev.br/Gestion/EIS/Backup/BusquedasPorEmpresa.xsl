<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 |	Envio de Pedidos hacia Picking Pack a traves de formulario seguro
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
<body class="gris">
	<xsl:choose>
	<xsl:when test="Busquedas/ROWSET/ROW/Sorry">
		<xsl:apply-templates select="Busquedas/ROWSET/ROW/Sorry"/>
	</xsl:when>
	<xsl:otherwise>
		<!-- Titulo -->
		<h1 class="titlePage">Búsquedas por Empresa - Últimos 30 días</h1>

		<div class="divLeft">
			<table class="grandeInicio">
			<thead>
				<tr class="titulos">
					<td class="cinquenta">Empresa</td>
					<td class="cinquenta">Búsquedas</td>
				</tr>
			</thead>

			<tbody>
			<xsl:for-each select="Busquedas/ROW">
				<tr>
					<td>
						<a href="PalabrasMasBuscadasPorEmpresa.xsql?IDEMPRESA={IDEMPRESA}">
							<xsl:value-of select="EMPRESA"/>
						</a>
					</td>
					<td><xsl:value-of select="BUSQUEDAS"/></td>
				</tr>
			</xsl:for-each>
			</tbody>
			</table>
			<br/><br/>
		</div>
	</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>