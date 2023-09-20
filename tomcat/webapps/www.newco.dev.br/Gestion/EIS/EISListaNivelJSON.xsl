<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/ListaNivel">


	<xsl:text>{"ListaNivel":[</xsl:text>
    	<xsl:if test="IDPadre = '1640'">
        <xsl:text>{"nombre":"</xsl:text>
			<xsl:text>MATERIAL SANITARIO",</xsl:text>
			<xsl:text>"id":"</xsl:text>
			<xsl:text>-2"}</xsl:text>  
            <xsl:text>,</xsl:text>      
        </xsl:if>
		<xsl:for-each select = "field/dropDownList/listElem">
			<xsl:text>{"nombre":"</xsl:text>
			<xsl:value-of select="listItem"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"id":"</xsl:text>
			<xsl:value-of select="ID"/>
			<xsl:text>"}</xsl:text>                                
				<xsl:if test="position() != last()">
					<xsl:text>,</xsl:text>
				</xsl:if>
		</xsl:for-each>
	<xsl:text>],</xsl:text>
<xsl:text>"Field":{"label":"</xsl:text>
<xsl:value-of select="field/@label"/>
<xsl:text>","name":"</xsl:text>
<xsl:value-of select="field/@name"/>
<xsl:text>"}}</xsl:text>
</xsl:template>
</xsl:stylesheet>