<?xml version="1.0" encoding="iso-8859-1" ?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1" 
doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" 
doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes" omit-xml-declaration="yes" /> 
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/">

{"Filtros":[
<xsl:choose>
<xsl:when test="FILTROS/PARAMETRO/field">
<xsl:for-each select="FILTROS/PARAMETRO/field/listElem">
	<xsl:choose>
		<xsl:when test="position()=last()">
		{"Fitro": {				
				nombre: "<xsl:value-of select="./listItem" />",
  				id: "<xsl:value-of select="./ID" />",
				idpadre: "<xsl:value-of select="./IDPADRE" />",
				nom_id: "<xsl:value-of select="./NOM_ID" />"
		}}
		</xsl:when>
		<xsl:otherwise>
		{"Fitro": {				
				nombre: "<xsl:value-of select="./listItem" />",
  				id: "<xsl:value-of select="./ID" />",
				idpadre: "<xsl:value-of select="./IDPADRE" />",
				nom_id: "<xsl:value-of select="./NOM_ID" />"
		}},
		</xsl:otherwise>
	</xsl:choose>
</xsl:for-each>	
</xsl:when>
<xsl:otherwise>
{"Fitro": {				
				nombre: "Sin resultados",
  				id: "-1"
		}}
</xsl:otherwise>
</xsl:choose>
]}

</xsl:template>
</xsl:stylesheet>