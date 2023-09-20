<?xml version="1.0" encoding="iso-8859-1" ?> 
<!--
	Recupera los registros sanitarios de un proveedor
	Ultima revision: ET 12nov21 12:21
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1" 
doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" 
doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes" omit-xml-declaration="yes" /> 
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/">

{"Filtros":[
<xsl:choose>

<xsl:when test="//OFERTAS/field/@current != ''">
<xsl:for-each select="//OFERTAS/field/dropDownList/listElem">
	<xsl:choose>
		<xsl:when test="position()=last()">
		{"Fitro": {				
				"nombre": "<xsl:value-of select="./listItem" />",
  				"id": "<xsl:value-of select="./ID" />",
                "file": "<xsl:value-of select="./URL" />"
		}}
		</xsl:when>
		<xsl:otherwise>
		{"Fitro": {				
				"nombre": "<xsl:value-of select="./listItem" />",
  				"id": "<xsl:value-of select="./ID" />",
                "file": "<xsl:value-of select="./URL" />"
		}},
		</xsl:otherwise>
	</xsl:choose>
</xsl:for-each>	
</xsl:when>

</xsl:choose>
]}

</xsl:template>
</xsl:stylesheet>
