<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Recupera los datos de una seleccion via AJAX
	Ultima revision: ET 9jul19 10:30
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/RecuperaSeleccion">
{"Filtros":[

{"Empresas":[
<xsl:choose>
<xsl:when test="SELECCION/EMPRESAS/field/dropDownList/listElem">
<xsl:for-each select="SELECCION/EMPRESAS/field/dropDownList/listElem">
    <xsl:if test="ID != ''">
	<xsl:choose>
		<xsl:when test="position()=last()">
		{"Empresa": {
				"nombre": "<xsl:value-of select="listItem" />",
  				"id": "<xsl:value-of select="ID" />"
		}}
		</xsl:when>
		<xsl:otherwise>
		{"Empresa": {
				"nombre": "<xsl:value-of select="listItem" />",
  				"id": "<xsl:value-of select="ID" />"
		}},
		</xsl:otherwise>
	</xsl:choose>
    </xsl:if>
</xsl:for-each>
</xsl:when>
<xsl:when test="SELECCION/PROVEEDORES/field/dropDownList/listElem">
<xsl:for-each select="SELECCION/PROVEEDORES/field/dropDownList/listElem">
    <xsl:if test="ID != ''">
	<xsl:choose>
		<xsl:when test="position()=last()">
		{"Empresa": {
				"nombre": "<xsl:value-of select="listItem" />",
  				"id": "<xsl:value-of select="ID" />"
		}}
		</xsl:when>
		<xsl:otherwise>
		{"Empresa": {
				"nombre": "<xsl:value-of select="listItem" />",
  				"id": "<xsl:value-of select="ID" />"
		}},
		</xsl:otherwise>
	</xsl:choose>
    </xsl:if>
</xsl:for-each>
</xsl:when>
<xsl:when test="SELECCION/CENTROS/field/dropDownList/listElem">
<xsl:for-each select="SELECCION/CENTROS/field/dropDownList/listElem">
    <xsl:if test="ID != ''">
	<xsl:choose>
		<xsl:when test="position()=last()">
		{"Empresa": {
				"nombre": "<xsl:value-of select="listItem" />",
  				"id": "<xsl:value-of select="ID" />"
		}}
		</xsl:when>
		<xsl:otherwise>
		{"Empresa": {
				"nombre": "<xsl:value-of select="listItem" />",
  				"id": "<xsl:value-of select="ID" />"
		}},
		</xsl:otherwise>
	</xsl:choose>
    </xsl:if>
</xsl:for-each>
</xsl:when>
</xsl:choose>
]},

{"Selecciones":[
<xsl:if test="SELECCION">
<xsl:for-each select="SELECCION">
	{"Seleccion": {
	"idSel": "<xsl:value-of select="EIS_SEL_ID" />",
  	"idUsuario": "<xsl:value-of select="EIS_SEL_IDUSUARIO" />",
    "nombreSel": "<xsl:value-of select="EIS_SEL_NOMBRE" />",
    "excluir": "<xsl:value-of select="EIS_SEL_EXCLUIR" />",
    "selPublico": "<xsl:value-of select="EIS_SEL_PUBLICO" />",
    "idtipo": "<xsl:value-of select="EIS_SEL_TIPO" />",
    "tipo": "<xsl:value-of select="TIPO" />",
    "todosAdmin": "<xsl:value-of select="EIS_SEL_TODOSLOSADMIN" />",
    "Autorizados": "<xsl:value-of select="EIS_SEL_AUTORIZADOS" />",
    "Excluidos": "<xsl:value-of select="EIS_SEL_EXCLUIDOS" />",
    "AreaGeo": "<xsl:value-of select="EIS_SEL_AREAGEOGRAFICA" />",
    "nombreCorto": "<xsl:value-of select="EIS_SEL_NOMBRECORTO" />"
	}}
</xsl:for-each>
</xsl:if>
]},

{"Registros":[
<xsl:if test="SELECCION/REGISTROS/REGISTRO">
<xsl:for-each select="SELECCION/REGISTROS/REGISTRO">
	<xsl:choose>
		<xsl:when test="position()=last()">
		{"Registro": {
				"id": "<xsl:value-of select="EIS_SELD_ID" />",
  				"idRegistro": "<xsl:value-of select="EIS_SELD_VALOR" />",
                "nombreRegistro": "<xsl:value-of select="NOMBRECONNIF" />"
		}}
		</xsl:when>
		<xsl:otherwise>
		{"Registro": {
				"id": "<xsl:value-of select="EIS_SELD_ID" />",
  				"idRegistro": "<xsl:value-of select="EIS_SELD_VALOR" />",
                "nombreRegistro": "<xsl:value-of select="NOMBRECONNIF" />"
		}},
		</xsl:otherwise>
	</xsl:choose>
</xsl:for-each>
</xsl:if>
]}

        ]}
</xsl:template>
</xsl:stylesheet>
