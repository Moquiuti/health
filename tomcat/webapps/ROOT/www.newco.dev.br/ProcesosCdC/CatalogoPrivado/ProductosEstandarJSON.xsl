<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Lista de registros del Cat.Priv. en formato JSON
	Ultima revision: ET 20jul22 11:40
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1" 
doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" 
doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes" omit-xml-declaration="yes"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/">

<xsl:variable name="quot">"</xsl:variable>
<xsl:variable name="apos">'</xsl:variable>

{"Filtros":[
	<xsl:choose>
	<xsl:when test="/ProductosEstandar/PRODUCTOSESTANDAR/field/@current != ''">
	<xsl:for-each select="/ProductosEstandar/PRODUCTOSESTANDAR/field/dropDownList/listElem">
		{"Filtro":[{
			"nombre": "<xsl:value-of select="translate(./listItem,$quot,$apos)" disable-output-escaping="yes"/>",
			"id": "<xsl:value-of select="./ID"/>"
		}]}
		<xsl:if test="position()!=last()">,</xsl:if>
	</xsl:for-each>
	</xsl:when>
	</xsl:choose>
]}
</xsl:template>
</xsl:stylesheet>
