<?xml version="1.0" encoding="iso-8859-1" ?> 
<!--
	Recupera las FICHAS DE SEGURIDAD de un proveedor
	Ultima revision: ET 21feb23 17:11
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1" 
doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" 
doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes" omit-xml-declaration="yes" /> 
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/">

{"Filtros":[
<xsl:for-each select="/FichasProveedor/OFERTAS/field/dropDownList/listElem">
	{"Fitro": {				
			"nombre": "<xsl:value-of select="./listItem" />",
  			"id": "<xsl:value-of select="./ID" />",
            "file": "<xsl:value-of select="./URL" />"
	}}
	<xsl:if test="position()!=last()">,</xsl:if>
</xsl:for-each>	
]}
</xsl:template>
</xsl:stylesheet>
