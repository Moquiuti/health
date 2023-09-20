<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Frame derecho del buscador del catalogo privadoç
	Se abre desde CatPrivUnica2022.html
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
	<title>Buscador catalogo privado</title>
</head>

<frameset id="fsInterno" rows="190px,*" frameborder="no" border="0" framespacing="0">
	<frame src="UntitledFrame-1" name="Cabecera" scrolling="auto" noresize="yes">
		<xsl:attribute name="src">Buscador2022.xsql?VENTANA=<xsl:value-of select="Buscador/VENTANA"/></xsl:attribute>
	</frame>

	<frame name="Resultados" scrolling="auto" noresize="yes">
	</frame>
</frameset>
<noframes></noframes>
</html>
</xsl:template>
</xsl:stylesheet>
