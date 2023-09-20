<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/IDProductoEstandar">

		<xsl:text>{"IDProductoEstandar":"</xsl:text>
		<xsl:if test="IDPRODUCTOESTANDAR">
			<xsl:value-of select="IDPRODUCTOESTANDAR"/>
		</xsl:if>
		<xsl:if test="ERROR">
			<xsl:text>-1</xsl:text>
		</xsl:if>
		<xsl:text>"}</xsl:text>
</xsl:template>
</xsl:stylesheet>
