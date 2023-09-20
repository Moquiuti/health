<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Conversaciones con proveedores
	- 25oct16 El superusuario puede consultar pero no participar
	- 25oct16 Arreglado problema con los títulos
	
	ultima revision: ET 25oct17 13:22
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/ConversacionLicitacion">

<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="LANG != ''"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--fin idioma-->

<html>
<head>

	<title>
		<xsl:choose>
		<xsl:when test="IDPROVEEDOR = ''">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='comentario_interno']/node()"/>&nbsp;"<xsl:value-of select="CONVERSACION/LICITACION"/>"
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="document($doc)/translation/texts/item[@name='conversacion_con']/node()"/>&nbsp;<xsl:value-of select="CONVERSACION/NOMBREPROVEEDOR"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='para']/node()"/>&nbsp;"<xsl:value-of select="CONVERSACION/LICITACION"/>"
		</xsl:otherwise>
		</xsl:choose>
        </title>

	<xsl:call-template name="estiloIndip"/>
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/lic_conversacion.js"></script>

	<script type="text/javascript">
		var faltaMensaje	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='falta_comentario_licitacion']/node()"/>';
	</script>
</head>

<body>
	<!--idioma
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/LANG != ''"><xsl:value-of select="/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	fin idioma-->

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>
		&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Licitacion']/node()"/>
		&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='conversacion_con']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></span>
		</p>
		<p class="TituloPagina">
			<xsl:choose>
			<xsl:when test="IDPROVEEDOR = ''">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='comentario_interno']/node()"/>&nbsp;"<xsl:value-of select="CONVERSACION/LICITACION"/>"
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='conversacion_con']/node()"/>&nbsp;<xsl:value-of select="CONVERSACION/NOMBREPROVEEDOR"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='para']/node()"/>&nbsp;"<xsl:value-of select="CONVERSACION/LICITACION"/>"
			</xsl:otherwise>
			</xsl:choose>
			<span class="CompletarTitulo" style="width:100px;">
				<a class="btnNormal" href="javascript:window.print();" style="text-decoration:none;">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
				</a>&nbsp;		
			</span>
		</p>
	</div>
	<br/>
	<br/>


	<!--
	<h1 class="titlePage">
	<xsl:choose>
	<xsl:when test="IDPROVEEDOR = ''">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='comentario_interno']/node()"/>&nbsp;"<xsl:value-of select="CONVERSACION/LICITACION"/>"
	</xsl:when>
	<xsl:otherwise>
		<xsl:value-of select="document($doc)/translation/texts/item[@name='conversacion_con']/node()"/>&nbsp;<xsl:value-of select="CONVERSACION/NOMBREPROVEEDOR"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='para']/node()"/>&nbsp;"<xsl:value-of select="CONVERSACION/LICITACION"/>"
	</xsl:otherwise>
	</xsl:choose>

		&nbsp;<a href="javascript:window.print();" style="text-decoration:none;">
			<img src="http://www.newco.dev.br/images/imprimir.gif">
			<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></xsl:attribute>
			<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></xsl:attribute>
			</img>
		</a>
	</h1>
	-->

	<xsl:choose>
		<xsl:when test="ERROR">
			<div class="divLeft">
				<p style="margin-left:100px;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></strong></p>
			</div>
		</xsl:when>
		<xsl:otherwise>
			<div class="divLeft">
			<xsl:choose>
			<xsl:when test="CONVERSACION/COMENTARIO">
				<!--<table class="infoTable" border="0">-->
				<table class="buscador">
				<xsl:for-each select="CONVERSACION/COMENTARIO">
					<tr class="sinLinea">
						<td class="labelRight" style="width:200px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/>:&nbsp;</td>
						<td class="datosLeft">
							<xsl:choose>
							<xsl:when test="LIC_CONV_IDUSUARIOAUTOR = LIC_CONV_IDUSUARIOCLIENTE">
								<xsl:value-of select="USUARIOCLIENTE"/>
							</xsl:when>
							<xsl:when test="LIC_CONV_IDUSUARIOAUTOR = LIC_CONV_IDUSUARIOPROV">
								<xsl:value-of select="USUARIOPROV"/>
							</xsl:when>
							</xsl:choose>
						</td>
						<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;</td>
						<td class="datosLeft"><xsl:value-of select="FECHA"/></td>
						<td class="dies">&nbsp;</td>
					</tr>
					<tr>
						<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentario']/node()"/>:&nbsp;</td>
						<td colspan="3" class="datosLeft"><xsl:value-of select="LIC_CONV_MENSAJE"/></td>
						<td>&nbsp;</td>
					</tr>
					<!--<tr>
						<td colspan="5">&nbsp;</td>
						<td colspan="3" style="border-bottom:2px solid #3B5998;">&nbsp;</td>
						<td>&nbsp;</td>
					</tr>-->
				</xsl:for-each>
				</table>
			</xsl:when>
			<xsl:otherwise>
				<br/>
				<br/>
				<p style="margin-left:100px;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_existen_conversaciones']/node()"/></strong></p>
			</xsl:otherwise>
			</xsl:choose>
			<br/>
			<br/>
			
			<!--<xsl:if test="CONVERSACION/AUTOR or CONVERSACION/PROVEEDOR">-->
			<xsl:if test="CONVERSACION/PERMITIR_COMENTARIOS">
			<form name="ConversacionForm" action="ConversacionLicitacionSave.xsql" method="POST" id="ConversacionForm">
				<input type="hidden" name="IDLICITACION" value="{IDLICITACION}"/>
				<input type="hidden" name="IDPROVEEDOR" value="{IDPROVEEDOR}"/>
				<input type="hidden" name="IDUSUARIOCLIENTE" value="{IDUSUARIOCLIENTE}"/>
				<input type="hidden" name="IDUSUARIOPROV" value="{IDUSUARIOPROV}"/>

				<!--<table class="infoTable" border="0">-->
				<table class="buscador">
					<tr class="sinLinea">
						<td class="labelRight" style="width:200px;">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='comentario']/node()"/>:&nbsp;
						</td>
						<td class="datosLeft" colspan="2">
							<textarea name="LIC_MENSAJE" rows="4" cols="70"/>
                        </td>
					</tr>
					<tr class="sinLinea">
						<td>&nbsp;</td>
						<td class="datosLeft" align="center">
							<!--<div class="boton" id="botonGuardarComentario">--> <!--style="margin:10px 0 0 0;"-->
								<a class="btnDestacado" id="botonGuardarComentario" href="javascript:ValidarFormulario(document.forms['ConversacionForm']);">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
								</a>
							<!--</div>-->
						</td>
						<td>&nbsp;</td><!--para centrar bien el botón-->
					</tr>
				</table>
			</form>
			</xsl:if>
			</div>
		</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
