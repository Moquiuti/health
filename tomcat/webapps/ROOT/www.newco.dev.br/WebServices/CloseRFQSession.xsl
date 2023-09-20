<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
	
	<xsl:template match="/">    
	
	<RFQSessionId>
	<xsl:value-of select="/page/FICHERO/IDSESION"/>
    	</RFQSessionId>
	
	</xsl:template>
</xsl:stylesheet>
