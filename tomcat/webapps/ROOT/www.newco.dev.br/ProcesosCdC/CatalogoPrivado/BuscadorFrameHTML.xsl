<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
	<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
	<xsl:param name="lang" select="@lang"/>

<xsl:template match="/">
<html>
<head>
	<title>Buscador catalogo privado</title>
</head>

<frameset rows="100px,*" frameborder="no" border="0" framespacing="0">
	<frame src="UntitledFrame-1" name="Cabecera" scrolling="auto" noresize="yes">
		<xsl:attribute name="src">Buscador.xsql?VENTANA=<xsl:value-of select="Buscador/VENTANA"/></xsl:attribute>
	</frame>

	<frame name="Resultados" scrolling="auto" noresize="yes">
        	<!--  <xsl:choose>
            	<xsl:when test="Buscador/PAGINARESULTADOS!=''">
            	  <xsl:attribute name="src"><xsl:value-of select="Buscador/PAGINARESULTADOS"/></xsl:attribute>
            	</xsl:when>
            	<xsl:otherwise>
			<xsl:attribute name="src">PreciosYComisiones.xsql?IDINFORME=Comisiones&amp;IDFAMILIA=-1&amp;IDCENTRO=-1&amp;CONPRECIO=on&amp;SINPRECIO=on</xsl:attribute>
            <xsl:attribute name="src">PreciosYComisionesVacios.html</xsl:attribute>-->
            	<!--</xsl:otherwise>
        	  </xsl:choose>-->
	</frame>
</frameset>
<noframes></noframes>
</html>
</xsl:template>
</xsl:stylesheet>
