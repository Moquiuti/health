<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/USCopiarDerechos">
    <xsl:text>{"USCopiarDerechos":</xsl:text>
		<xsl:text>{"estado":"</xsl:text>
		<xsl:if test="/USCopiarDerechos/INICIO/RESULTADO">
			<xsl:value-of select="/USCopiarDerechos/INICIO/RESULTADO" />
		</xsl:if>
		<xsl:text>"}</xsl:text>
    <xsl:text>}</xsl:text>

</xsl:template>
</xsl:stylesheet>