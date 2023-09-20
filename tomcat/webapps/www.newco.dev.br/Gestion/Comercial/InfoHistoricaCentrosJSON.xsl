<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/InfoHistorica">

	<xsl:param name="pPattern">"</xsl:param>
	<xsl:param name="pReplacement">\"</xsl:param>

	<xsl:text>{"ListaCentros":[</xsl:text>
		<xsl:for-each select="PRODUCTOESTANDAR/CENTRO">
			<!-- Evitamos la doble comilla (") en el nombre de producto -->
			<xsl:variable name="NombreCentro">
				<xsl:call-template name="string-replace-all">
					<xsl:with-param name="text" select="NOMBRE"/>
					<xsl:with-param name="replace" select="$pPattern"/>
					<xsl:with-param name="by" select="$pReplacement"/>
				</xsl:call-template>
			</xsl:variable>

			<xsl:text>{"ID":"</xsl:text>
				<xsl:value-of select="ID"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Nombre":"</xsl:text>
				<xsl:value-of select="$NombreCentro"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"Cantidad":"</xsl:text>
				<xsl:value-of select="CP_HCC_CANTIDAD"/>
			<xsl:text>"}</xsl:text>
			<xsl:if test="position() != last()">
				<xsl:text>,</xsl:text>
			</xsl:if>
		</xsl:for-each>
	<xsl:text>]}</xsl:text>
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
		<xsl:copy-of select="$text"/>
	</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
