<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/RecuperaDatosProducto">
            <!--CP viene de catalogo privado data 0-->
            <xsl:text>[</xsl:text>
                    <xsl:choose>
                    <xsl:when test="DATOS_PRODUCTOS/PRODUCTOESTANDAR">
			<xsl:text>{"ProdIDCP":"</xsl:text>
				<xsl:value-of select="DATOS_PRODUCTOS/PRODUCTOESTANDAR/CP_PRO_ID"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ProdRefCP":"</xsl:text>
				<xsl:value-of select="DATOS_PRODUCTOS/PRODUCTOESTANDAR/CP_PRO_REFERENCIA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"RefClienteCP":"</xsl:text>
				<xsl:value-of select="DATOS_PRODUCTOS/PRODUCTOESTANDAR/CP_PRO_REFCLIENTE"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"DescrCP":"</xsl:text>
				<xsl:value-of select="DATOS_PRODUCTOS/PRODUCTOESTANDAR/CP_PRO_NOMBRE"/> 
                                <xsl:text>"}</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>{"ProdIDCP":"",</xsl:text>
			<xsl:text>"ProdRefCP":"",</xsl:text>
			<xsl:text>"RefClienteCP":"",</xsl:text>
			<xsl:text>"DescrCP":""}</xsl:text>
                    </xsl:otherwise>
                    </xsl:choose>
                    ,
            <!--datos proveedor data 1-->
                    <xsl:choose>
                    <xsl:when test="DATOS_PRODUCTOS/PRODUCTO">
			<xsl:text>{"RefProdProv":"</xsl:text>
				<xsl:value-of select="DATOS_PRODUCTOS/PRODUCTO/PRO_REFERENCIA"/>
			<xsl:text>",</xsl:text>
                        <xsl:text>"IDProv":"</xsl:text>
				<xsl:value-of select="DATOS_PRODUCTOS/PRODUCTO/IDPROVEEDOR"/>
			<xsl:text>",</xsl:text>
                        <xsl:text>"Prov":"</xsl:text>
				<xsl:value-of select="DATOS_PRODUCTOS/PRODUCTO/PROVEEDOR"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"ProdIDProv":"</xsl:text>
				<xsl:value-of select="DATOS_PRODUCTOS/PRODUCTO/PRO_ID"/>
			<xsl:text>",</xsl:text>
                        <xsl:text>"MarcaProd":"</xsl:text>
				<xsl:value-of select="DATOS_PRODUCTOS/PRODUCTO/PRO_MARCA"/>
			<xsl:text>",</xsl:text>
			<xsl:text>"DescrProv":"</xsl:text>
				<xsl:value-of select="DATOS_PRODUCTOS/PRODUCTO/PRO_NOMBRE"/> 
                                <xsl:text>"}</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>{"RefProdProv":"",</xsl:text>
                        <xsl:text>"IDProv":"",</xsl:text>
                        <xsl:text>"Prov":"",</xsl:text>
			<xsl:text>"ProdIDProv":"",</xsl:text>
			<xsl:text>"DescrProv":""}</xsl:text>
                    </xsl:otherwise>
                    </xsl:choose>
                     ,
            <!--datos proveedor de oferta licitacion data 2-->
                    <xsl:choose>
                    <xsl:when test="DATOS_PRODUCTOS/OFERTA">
			<xsl:text>{"LicOfeRef":"</xsl:text>
				<xsl:value-of select="DATOS_PRODUCTOS/OFERTA/LIC_OFE_REFERENCIA"/>
			<xsl:text>",</xsl:text>
                        <xsl:text>"IDProdEstandar":"</xsl:text>
				<xsl:value-of select="DATOS_PRODUCTOS/OFERTA/IDPRODESTANDAR"/>
			<xsl:text>",</xsl:text>                      
                        <xsl:text>"ProdNombre":"</xsl:text>
				<xsl:value-of select="DATOS_PRODUCTOS/OFERTA/LIC_OFE_NOMBRE"/>
			<xsl:text>",</xsl:text>
                        <xsl:text>"IDProv":"</xsl:text>
				<xsl:value-of select="DATOS_PRODUCTOS/OFERTA/IDPROVEEDOR"/>
			<xsl:text>",</xsl:text>
                        <xsl:text>"Prov":"</xsl:text>
				<xsl:value-of select="DATOS_PRODUCTOS/OFERTA/PROVEEDOR"/>
                                <xsl:text>"}</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>{"LicOfeRef":"",</xsl:text>
                        <xsl:text>"IDProdEstandar":"",</xsl:text>
                        <xsl:text>"ProdNombre":"",</xsl:text>
                        <xsl:text>"IDProv":"",</xsl:text>
			<xsl:text>"Prov":""}</xsl:text>
                    </xsl:otherwise>
                    </xsl:choose>
            <xsl:text>]</xsl:text>
			
			
</xsl:template>
</xsl:stylesheet>