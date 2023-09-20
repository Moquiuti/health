<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 |
 |
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/">

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/CatalogosClientes/LANG"><xsl:value-of select="/CatalogosClientes/LANG" /></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='catalogos_clientes']/node()"/></title>

	<xsl:text disable-output-escaping="yes">
	<![CDATA[

	]]>
	</xsl:text>
</head>

<xsl:choose>
	<xsl:when test="//xsql-error">
		<xsl:apply-templates select="//xsql-error"/>
		<body>
			<br/><br/>
			<center><xsl:apply-templates select="//jumpTo"/></center>
		</body>
	</xsl:when>
	<xsl:otherwise>
		<!--idioma-->
		<xsl:variable name="lang">
			<xsl:choose>
				<xsl:when test="/CatalogosClientes/LANG"><xsl:value-of select="/CatalogosClientes/LANG" /></xsl:when>
				<xsl:otherwise>spanish</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
		<!--idioma fin-->


		<frame src="UntitledFrame-1" name="areaTrabajo">
		<frameset rows="90px,*" frameborder="no" border="0" framespacing="0">
        	<xsl:choose>
						<xsl:when test="/CatalogosClientes/TYPE = 'MVM' and /CatalogosClientes/VS = 'SIMPLE'">
            	aaa<frame name="Cabecera" scrolling="auto" noresize="yes" src="Buscador.xsql?ORIGEN=CATCLIENTES_S&amp;TYPE=MVM"/>
            </xsl:when>
            <xsl:when test="/CatalogosClientes/TYPE = 'MVM'">
            	bbb<frame name="Cabecera" scrolling="auto" noresize="yes" src="Buscador.xsql?ORIGEN=CATCLIENTES&amp;TYPE=MVM"/>
            </xsl:when>
            <xsl:otherwise>
            	<frame name="Cabecera" scrolling="auto" noresize="yes" src="Buscador.xsql?ORIGEN=CATCLIENTES"/>
            </xsl:otherwise>
            </xsl:choose>

	    	<frame name="Resultados" scrolling="auto" noresize="yes" src="about:blank"/><!--PreciosYComisiones.xsql-->
		</frameset>
		</frame>

		<noframes>
			<body>
				<!--idioma-->
				<xsl:variable name="lang">
					<xsl:choose>
						<xsl:when test="/Empresa/LANG"><xsl:value-of select="/Empresa/LANG" /></xsl:when>
						<xsl:otherwise>spanish</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
				<!--idioma fin-->

				<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar_navegador']/node()"/>
			</body>
		</noframes>
	</xsl:otherwise>
</xsl:choose>
</html>

</xsl:template>
</xsl:stylesheet>
