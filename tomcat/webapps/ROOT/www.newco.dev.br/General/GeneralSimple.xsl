<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 |
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>

<xsl:variable name="default">
	<xsl:text>spanish</xsl:text>
</xsl:variable>

<xsl:template name="translate">
	<xsl:param name="text"/>
	<xsl:param name="lang"/>
	<xsl:choose>
		<xsl:when test="document('http://www.newco.dev.br/General/texts.xml')/translation/texts[lang('spanish')]/item[@name=$text]/node() != ''">
			<xsl:copy-of select="document('http://www.newco.dev.br/General/texts.xml')/translation/texts[lang('spanish')]/item[@name=$text]/node()"/>
		</xsl:when>
		<xsl:when test="document('http://www.newco.dev.br/General/texts.xml')/translation/texts[lang($default)]/item[@name=$text]/node() != ''">
			<xsl:copy-of select="document('http://www.newco.dev.br/General/texts.xml')/translation/texts[lang($default)]/item[@name=$text]/node()"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$text"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!--estilo en todas las paginas-->
<xsl:template name="estiloIndip">
	<link rel="stylesheet" type="text/css">
		<xsl:variable name="lenght" select="string-length(//STYLE)"/>
			<xsl:attribute name="href">
				<xsl:choose>
					<xsl:when test="//STYLE != '' and $lenght &gt; 48">
						<xsl:variable name="ref1" select="substring-before(//STYLE,'%')"/>
						<xsl:variable name="ref2" select="substring-after(//STYLE,'//')"/>
						<xsl:variable name="ref3" select="concat($ref1,'://',$ref2)"/>
						<xsl:variable name="ref4" select="substring-before(//STYLE,'%')"/>
						<xsl:variable name="ref5" select="substring-after(//STYLE,'//')"/>
						<xsl:variable name="ref6" select="concat($ref1,'://',$ref2)"/>
						<xsl:value-of select="$ref6"/>
					</xsl:when>
					<xsl:when test="//STYLE != '' and $lenght &lt; 50">
						<xsl:variable name="ref1" select="substring-before(//STYLE,'%')"/>
						<xsl:variable name="ref2" select="substring-after(//STYLE,'//')"/>
						<xsl:variable name="ref3" select="concat($ref1,'://',$ref2)"/>
						<xsl:value-of select="$ref3"/>
					</xsl:when>
					<xsl:otherwise>
						http://www.newco.dev.br/General/basic.css
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
	</link>
</xsl:template>


</xsl:stylesheet>