<?xml version="1.0" encoding="iso-8859-1" ?>
<!-- 

		"templates" de uso habitual
		
		(c) 2004 ET

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"> 
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>

<!--	Templates para trabajar con listas desplegables		-->  
<xsl:template match="field">
    <xsl:variable name="IDAct"><xsl:value-of select="./@current"/></xsl:variable>
	<select>

	<xsl:attribute name="name">
		<xsl:value-of select="./@name"/>
	</xsl:attribute>

	<xsl:if test="./@onChange">
		<xsl:attribute name="onChange">
			<xsl:value-of select="./@onChange"/>
		</xsl:attribute>
	</xsl:if>

	<xsl:for-each select="listElem">
		<xsl:choose>
			<xsl:when test="$IDAct = ID">
    			<option selected="selected">
    		  		<xsl:attribute name="value">
     					<xsl:value-of select="ID"/>
		  			</xsl:attribute>                       
		  			[<xsl:value-of select="listItem" disable-output-escaping="yes"/>]
    			</option>
			</xsl:when>
			<xsl:otherwise>
    			<option>
    		  		<xsl:attribute name="value">
     					<xsl:value-of select="ID"/>
		  			</xsl:attribute>
    		  		<xsl:value-of select="listItem" disable-output-escaping="yes"/>
    			</option> 
    		</xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>
</select>
</xsl:template>

</xsl:stylesheet>
