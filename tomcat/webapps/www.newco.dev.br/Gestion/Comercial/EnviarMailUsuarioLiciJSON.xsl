<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/EnviarMailUsuarioLiciJSON">

		<xsl:text>{"estado":"</xsl:text>
			<xsl:text>OK</xsl:text>
		<xsl:text>"}</xsl:text>
</xsl:template>
</xsl:stylesheet>