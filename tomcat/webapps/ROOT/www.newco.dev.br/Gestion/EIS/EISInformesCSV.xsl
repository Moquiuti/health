<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 	Presentacion de los datos para EIS Informes en formato CSV
	Ultima revision: ET 15nov17
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/EISInformes">
	<!--idioma-->
	<xsl:variable name="lang"><xsl:value-of select="LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<xsl:value-of select="INFORME/TITULOCSV"/>#
	<xsl:for-each select="INFORME/BLOQUE">#
	<xsl:value-of select="NOMBRE"/>#
	<xsl:for-each select="LINEA">
	<xsl:if test="INCLUIR_CABECERA_TABLA">
	|<xsl:for-each select="//INFORME/CABECERA_TABLAS/COLUMNA"><xsl:value-of select="MES"/><xsl:if test="MES != 'TOTAL'"><xsl:text>/</xsl:text></xsl:if><xsl:value-of select="ANYO"/>|</xsl:for-each>#
	</xsl:if>
	<xsl:if test="RESUMEN_MENSUAL">
	<xsl:value-of select="RESUMEN_MENSUAL/@Nombre"/>|<xsl:for-each select="RESUMEN_MENSUAL/COLUMNA"><xsl:value-of select="VALOR"/>|</xsl:for-each>#
	</xsl:if>
	<!--<xsl:text disable-output-escaping="yes">
	<![CDATA[


	]]>
	</xsl:text>-->
	</xsl:for-each>
	<xsl:if test="INCLUIR_CIERRE_TABLA">
	<!--<xsl:text disable-output-escaping="yes">
	<![CDATA[


	]]>
	</xsl:text>-->
	</xsl:if>
</xsl:for-each>
</xsl:template>

</xsl:stylesheet>
