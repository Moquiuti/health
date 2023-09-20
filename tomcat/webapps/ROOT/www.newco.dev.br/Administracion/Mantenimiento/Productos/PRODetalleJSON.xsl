<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Respuesta JSON vía ajax
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/Productos">


	<xsl:text>{"Producto":{</xsl:text>
		<xsl:text>"nombre":"</xsl:text><xsl:value-of select="PRODUCTO/PRODUCTO/PRO_NOMBRE" />",
                <xsl:text>"ref_prove":"</xsl:text><xsl:value-of select="PRODUCTO/PRODUCTO/REFERENCIA_PROVEEDOR" />",
                <xsl:text>"prove":"</xsl:text><xsl:value-of select="PRODUCTO/PRODUCTO/PROVEEDOR" />",
                <xsl:text>"ref_estandar":"</xsl:text><xsl:value-of select="PRODUCTO/PRODUCTO/REFERENCIA_PRIVADA" />",
                <xsl:text>"marca":"</xsl:text><xsl:value-of select="PRODUCTO/PRODUCTO/PRO_MARCA" />",
                <xsl:text>"iva":"</xsl:text><xsl:value-of select="PRODUCTO/PRODUCTO/PRO_TIPOIVA" />",
                <xsl:text>"un_basica":"</xsl:text><xsl:value-of select="PRODUCTO/PRODUCTO/PRO_UNIDADBASICA" />",
                <xsl:text>"un_lote":"</xsl:text><xsl:value-of select="PRODUCTO/PRODUCTO/PRO_UNIDADESPORLOTE" />",
                <xsl:text>"farmacia":"</xsl:text><xsl:value-of select="PRODUCTO/PRODUCTO/FARMACIA" />",
                <xsl:text>"homologado":"</xsl:text><xsl:value-of select="PRODUCTO/PRODUCTO/PRO_HOMOLOGADO" />",
                <xsl:text>"categoria":"</xsl:text><xsl:value-of select="PRODUCTO/PRODUCTO/NOMBRECATEGORIA" />",
                <xsl:text>"familia":"</xsl:text><xsl:value-of select="PRODUCTO/PRODUCTO/NOMBREFAMILIA" />",
                <xsl:text>"sub_familia":"</xsl:text><xsl:value-of select="PRODUCTO/PRODUCTO/NOMBRESUBFAMILIA" />",
                <xsl:text>"grupo":"</xsl:text><xsl:value-of select="PRODUCTO/PRODUCTO/NOMBREGRUPO" />",
                <xsl:text>"tarifa":"</xsl:text><xsl:value-of select="PRODUCTO/LasTarifas/TARIFAS/TARIFAS_ROW/TRF_IMPORTE" />",
                <xsl:text>"pais":"</xsl:text><xsl:value-of select="PRODUCTO/LasTarifas/IDPAIS" />",
                <xsl:text>"imagen":"</xsl:text><xsl:value-of select="PRODUCTO/PRODUCTO/IMAGENES/IMAGEN/@peq" />",
                <xsl:text>"imagenGrande":"</xsl:text><xsl:value-of select="PRODUCTO/PRODUCTO/IMAGENES/IMAGEN/@grande" />"                               
		<xsl:text>}</xsl:text>
                <!--
                    <xsl:text>"Cliente":[</xsl:text>
                    <xsl:for-each select="PRODUCTO/PRODUCTO/DATOS_CLIENTE">
                    <xsl:text>{</xsl:text>
                        <xsl:text>"nombre":"</xsl:text><xsl:value-of select="NOMBRE_CORTO" />",
                        <xsl:text>"tarifa":"</xsl:text><xsl:value-of select="TARIFA_EURO_CONFORMATO" />",
                        <xsl:text>"fecha_limite":"</xsl:text><xsl:value-of select="FECHA_LIMITE" />"
                        <xsl:if test="OFERTAS/field/@current != ''">
                            <xsl:text>,"documento":"</xsl:text><xsl:value-of select="OFERTAS/field/dropDownList/listElem[ID = OFERTAS/field/@current]/listItem" />"
                        </xsl:if>
                        <xsl:text>}</xsl:text>
                    
                        <xsl:if test="position() != last()">
					<xsl:text>,</xsl:text>
			</xsl:if>
                    </xsl:for-each>
                    <xsl:text>]</xsl:text>  --> 
	<xsl:text></xsl:text>
    <xsl:text>}</xsl:text>
</xsl:template>
</xsl:stylesheet>