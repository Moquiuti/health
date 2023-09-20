<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/Centros">


	<xsl:text>{"ListaCentros":[</xsl:text>
        
        <xsl:for-each select="field[@name='IDCENTRO']/dropDownList/listElem">
	
	<xsl:choose>
		<xsl:when test="position()=last()">
		{"Centro": {				
				Nombre: "<xsl:value-of select="listItem" />",
  				ID: "<xsl:value-of select="ID" />"
		}}
		</xsl:when>
		<xsl:otherwise>
		{"Centro": {				
				Nombre: "<xsl:value-of select="listItem" />",
  				ID: "<xsl:value-of select="ID" />"
		}},
		</xsl:otherwise>
	</xsl:choose>
        </xsl:for-each>	
        
		]}
</xsl:template>
</xsl:stylesheet>


