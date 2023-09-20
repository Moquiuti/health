<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Listado de usuarios y plantillas de la empresa
	Ultima revision: ET 10set20 10:30
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
		<xsl:when test="/ListadoUsuarios/LANG"><xsl:value-of select="/ListadoUsuarios/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_usuarios_carpetas_plantillas']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	<script type="text/javascript">
		//	Funciones de Javascript

		//	Presenta la pagina dederechos de carpetas y plantillas

		function DerechosCARPyPL(propietario, usuario){
			var opciones='?ID_USUARIO='          + propietario;

			MostrarPag('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CARPyPLManten.xsql'+opciones,'carpYpl'+propietario);
		}
	</script>
	]]></xsl:text>
</head>
<body>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/ListadoUsuarios/LANG"><xsl:value-of select="/ListadoUsuarios/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

<xsl:choose>
<xsl:when test="//SESION_CADUCADA">
	<xsl:apply-templates select="//SESION_CADUCADA"/>
</xsl:when>
<xsl:when test="//xsql-error">
	<xsl:apply-templates select="//xsql-error"/>
</xsl:when>
<xsl:otherwise>


		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_usuarios_carpetas_plantillas']/node()"/></span></p>
			<p class="TituloPagina">
				<xsl:value-of select="/ListadoUsuarios/USUARIOS/NOMBREEMPRESA" />
				<span class="CompletarTitulo">
				</span>
			</p>
		</div>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>


	<!-- Titulo 
	<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_usuarios_carpetas_plantillas']/node()"/></h1>
	-->
	<!--<table class="grandeInicio">-->
	<table class="buscador">
		<tr class="subTituloTabla">
			<th colspan="2">&nbsp;</th>
			<th class="trenta" colspan="2"><xsl:value-of select="document($doc)/translation/texts/item[@name='carpetas']/node()"/></th>
			<th class="trenta" colspan="2"><xsl:value-of select="document($doc)/translation/texts/item[@name='plantillas']/node()"/></th>
			<th>&nbsp;</th>
		</tr>
		<tr class="subTituloTabla">
			<td class="dies">&nbsp;</td>
			<td class="veinte textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></td>
			<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='lectura']/node()"/></td>
			<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='escritura']/node()"/></td>
			<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='lectura']/node()"/></td>
			<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='escritura']/node()"/></td>
			<td>&nbsp;</td>
		</tr>

	<xsl:for-each select="ListadoUsuarios/USUARIOS/USUARIO">
		<tr>
			<td>&nbsp;</td>
			<td class="textLeft">
				<a>
					<xsl:attribute name="href">javascript:DerechosCARPyPL('<xsl:value-of select="ID"/>');</xsl:attribute>
					<xsl:value-of select="CENTRO"/>:&nbsp;<xsl:value-of select="NOMBRE"/>
				</a>
			</td>
			<td><xsl:value-of select="CARPETAS_LECTURA"/></td>
			<td><xsl:value-of select="CARPETAS_ESCRITURA"/></td>
			<td><xsl:value-of select="PLANTILLAS_LECTURA"/></td>
			<td><xsl:value-of select="PLANTILLAS_ESCRITURA"/></td>
			<td>&nbsp;</td>
		</tr>
	</xsl:for-each>
	</table>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
