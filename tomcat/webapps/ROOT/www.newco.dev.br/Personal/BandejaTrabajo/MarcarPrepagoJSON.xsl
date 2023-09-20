<?xml version="1.0" encoding="iso-8859-1"?>
<!--	Ultima revision ET 20nov17	-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>

<xsl:template match="/MarcarPrepago">

	<xsl:text>{"estado":</xsl:text>
		<xsl:if test="OK">
			"<xsl:value-of select="OK"/>"
		</xsl:if>
		<xsl:if test="ERROR">
			<xsl:text>"ERROR"</xsl:text>
		</xsl:if>
	<xsl:text>}</xsl:text>
</xsl:template>
</xsl:stylesheet>
