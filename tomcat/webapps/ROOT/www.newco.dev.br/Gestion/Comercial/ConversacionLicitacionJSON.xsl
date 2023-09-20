<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/ConversacionLicitacion">

	<xsl:param name="pPattern">"</xsl:param>
	<xsl:param name="pReplacement">\"</xsl:param>

	<xsl:choose>
	<xsl:when test="CONVERSACION">

		<xsl:text>{"Estado":"OK",</xsl:text>
		<xsl:text>"Titulo":"</xsl:text>
			<xsl:value-of select="CONVERSACION/LICITACION"/>
		<xsl:text>","isAutor":"</xsl:text>
			<xsl:choose><xsl:when test="CONVERSACION/AUTOR">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>
		<xsl:text>","isProveedor":"</xsl:text>
			<xsl:choose><xsl:when test="CONVERSACION/PROVEEDOR">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>
		<xsl:text>","ListaComentarios":[</xsl:text>
			<xsl:for-each select="CONVERSACION/COMENTARIO">
				<xsl:text>{"IDLic":"</xsl:text>
					<xsl:value-of select="LIC_ID"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"IDConv":"</xsl:text>
					<xsl:value-of select="LIC_CONV_ID"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"Fecha":"</xsl:text>
					<xsl:value-of select="FECHA"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"IDProveedor":"</xsl:text>
					<xsl:value-of select="LIC_CONV_IDPROVEEDOR"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"IDUsuarioAutor":"</xsl:text>
					<xsl:value-of select="LIC_CONV_IDUSUARIOAUTOR"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"IDUsuarioCliente":"</xsl:text>
					<xsl:value-of select="LIC_CONV_IDUSUARIOCLIENTE"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"UsuarioCliente":"</xsl:text>
					<xsl:value-of select="USUARIOCLIENTE"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"IDUsuarioProv":"</xsl:text>
					<xsl:value-of select="LIC_CONV_IDUSUARIOPROV"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"UsuarioProv":"</xsl:text>
					<xsl:value-of select="USUARIOPROV"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"Mensaje":"</xsl:text>
					<xsl:copy-of select="LIC_CONV_MENSAJE_JS/node()"/>
				<xsl:text>",</xsl:text>
				<xsl:text>"Estado":"</xsl:text>
					<xsl:value-of select="LIC_CONV_IDESTADO"/>
				<xsl:text>"}</xsl:text>
				<xsl:if test="position() != last()">
					<xsl:text>,</xsl:text>
				</xsl:if>
			</xsl:for-each>
		<xsl:text>]}</xsl:text>

	</xsl:when>
	<xsl:otherwise>

		<xsl:text>{"Estado":"ERROR",</xsl:text>
		<xsl:text>"mensaje":"</xsl:text>
			<xsl:value-of select="ERROR/@msg"/>
		<xsl:text>"}</xsl:text>

	</xsl:otherwise>
	</xsl:choose>

</xsl:template>

<xsl:template name="string-replace-all">
	<xsl:param name="text"/>
	<xsl:param name="replace"/>
	<xsl:param name="by"/>

	<xsl:choose>
	<xsl:when test="contains($text, $replace)">
		<xsl:value-of select="substring-before($text,$replace)"/>
		<xsl:value-of select="$by"/>
                
		<xsl:call-template name="string-replace-all">
			<xsl:with-param name="text" select="substring-after($text,$replace)"/>
			<xsl:with-param name="replace" select="$replace"/>
			<xsl:with-param name="by" select="$by"/>
		</xsl:call-template>
	</xsl:when>
	<xsl:otherwise>
		<xsl:value-of select="$text"/>
	</xsl:otherwise>
	</xsl:choose>
</xsl:template>
</xsl:stylesheet>