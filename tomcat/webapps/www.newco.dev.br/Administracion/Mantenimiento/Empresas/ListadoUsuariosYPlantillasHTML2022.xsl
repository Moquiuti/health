<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Listado de usuarios y plantillas de la empresa. Nuevo disenno 2022.
	Ultima revision: ET 26may22 11:50
+-->
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
		<xsl:when test="/ListadoUsuarios/LANG"><xsl:value-of select="/ListadoUsuarios/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="/ListadoUsuarios/USUARIOS/NOMBREEMPRESA" />:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='listado_usuarios_carpetas_plantillas']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->

	<xsl:text disable-output-escaping="yes"><![CDATA[
	<script type="text/javascript">
		//	Funciones de Javascript

		//	Presenta la pagina dederechos de carpetas y plantillas

		function DerechosCARPyPL(propietario, usuario){
			var opciones='?ID_USUARIO='          + propietario;

			document.location="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CARPyPLManten2022.xsql"+opciones;
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
			<p class="TituloPagina">
				<xsl:value-of select="/ListadoUsuarios/USUARIOS/NOMBREEMPRESA" />:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='listado_usuarios_carpetas_plantillas']/node()"/>
				<span class="CompletarTitulo">
				</span>
			</p>
		</div>
		<br/>
		<br/>
		<br/>

	<div class="tabela tabela_redonda">
	<table class="w1000px tableCenter" cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
		<tr>
			<th class="w1px">&nbsp;</th>
			<th class="textLeft"><br/><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></th>
			<th class="w150px"><xsl:value-of select="document($doc)/translation/texts/item[@name='carpetas']/node()"/><br/><xsl:value-of select="document($doc)/translation/texts/item[@name='lectura']/node()"/></th>
			<th class="w150px"><xsl:value-of select="document($doc)/translation/texts/item[@name='carpetas']/node()"/><br/><xsl:value-of select="document($doc)/translation/texts/item[@name='escritura']/node()"/></th>
			<th class="w150px"><xsl:value-of select="document($doc)/translation/texts/item[@name='plantillas']/node()"/><br/><xsl:value-of select="document($doc)/translation/texts/item[@name='lectura']/node()"/></th>
			<th class="w150px"><xsl:value-of select="document($doc)/translation/texts/item[@name='plantillas']/node()"/><br/><xsl:value-of select="document($doc)/translation/texts/item[@name='escritura']/node()"/></th>
			<th>&nbsp;</th>
		</tr>
	</thead>
	<!--	Cuerpo de la tabla	-->
	<tbody class="corpo_tabela">
	<xsl:for-each select="ListadoUsuarios/USUARIOS/USUARIO">
		<tr class="con_hover">
			<td class="color_status">&nbsp;</td>
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
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="12">&nbsp;</td></tr>
		</tfoot>
	</table><!--fin de infoTableAma-->
 	</div>
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
