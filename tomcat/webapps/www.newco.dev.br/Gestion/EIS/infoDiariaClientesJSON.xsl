<?xml version="1.0" encoding="iso-8859-1" ?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1" 
doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" 
doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes" omit-xml-declaration="yes" /> 
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/">

{
<xsl:if test="/infoDiariaClientes/EIS_SEGUIMIENTO/INFORMACION_DIARIA">
    "infoDiaria": {				
                    "numPedidosDiaActual": "<xsl:value-of select="/infoDiariaClientes/EIS_SEGUIMIENTO/INFORMACION_DIARIA/NUMERO_PEDIDOS/DIAACTUAL" />",
                    "numPedidosDiaAnterior": "<xsl:value-of select="/infoDiariaClientes/EIS_SEGUIMIENTO/INFORMACION_DIARIA/NUMERO_PEDIDOS/DIAANTERIOR" />",
                    "importePedidosDiaActual": "<xsl:value-of select="/infoDiariaClientes/EIS_SEGUIMIENTO/INFORMACION_DIARIA/IMPORTE_PEDIDOS/DIAACTUAL" />",
                    "importePedidosDiaAnterior": "<xsl:value-of select="/infoDiariaClientes/EIS_SEGUIMIENTO/INFORMACION_DIARIA/IMPORTE_PEDIDOS/DIAANTERIOR" />",
                    "controlPedidosDiaActual": "<xsl:value-of select="/infoDiariaClientes/EIS_SEGUIMIENTO/INFORMACION_DIARIA/CONTROL_PEDIDOS/DIAACTUAL" />",
                    "controlPedidosDiaAnterior": "<xsl:value-of select="/infoDiariaClientes/EIS_SEGUIMIENTO/INFORMACION_DIARIA/CONTROL_PEDIDOS/DIAANTERIOR" />",
                    "incidenciasDiaActual": "<xsl:value-of select="/infoDiariaClientes/EIS_SEGUIMIENTO/INFORMACION_DIARIA/INCIDENCIAS/DIAACTUAL" />",
                    "incidenciasDiaAnterior": "<xsl:value-of select="/infoDiariaClientes/EIS_SEGUIMIENTO/INFORMACION_DIARIA/INCIDENCIAS/DIAANTERIOR" />",
                    "evaluacionesDiaActual": "<xsl:value-of select="/infoDiariaClientes/EIS_SEGUIMIENTO/INFORMACION_DIARIA/EVALUACIONES/DIAACTUAL" />",
                    "evaluacionesDiaAnterior": "<xsl:value-of select="/infoDiariaClientes/EIS_SEGUIMIENTO/INFORMACION_DIARIA/EVALUACIONES/DIAANTERIOR" />",
                    "licitacionesDiaActual": "<xsl:value-of select="/infoDiariaClientes/EIS_SEGUIMIENTO/INFORMACION_DIARIA/LICITACIONES/DIAACTUAL" />",
                    "licitacionesDiaAnterior": "<xsl:value-of select="/infoDiariaClientes/EIS_SEGUIMIENTO/INFORMACION_DIARIA/LICITACIONES/DIAANTERIOR" />"
		},
</xsl:if>

<xsl:if test="/infoDiariaClientes/EIS_SEGUIMIENTO/EMPRESASSELECCIONADAS/SEGUIMIENTO">
    "Empresas":[
    
    <xsl:for-each select="/infoDiariaClientes/EIS_SEGUIMIENTO/EMPRESASSELECCIONADAS/SEGUIMIENTO">
        <xsl:choose>
		<xsl:when test="position()=last()">
                    {"datosEmpresa": {				
                                    "empID": "<xsl:value-of select="EMP_ID" />",
                                    "empNombre": "<xsl:value-of select="EMP_NOMBRE" />",
                                    "empPotComprasMens": "<xsl:value-of select="EMP_POTENCIAL_COMPRASMENSUALES" />",
                                    "empPotCatalogo": "<xsl:value-of select="EMP_POTENCIAL_CATALOGO" />",
                                    "catCatal": "<xsl:value-of select="CATALOGO/CATALOGADOS" />",
                                    "catAdj": "<xsl:value-of select="CATALOGO/ADJUDICADOS" />",
                                    "catComprados12": "<xsl:value-of select="CATALOGO/COMPRADOS_12MESES" />",
                                    "pedCompras12": "<xsl:value-of select="PEDIDOS/COMPRAS_12MESES" />",
                                    "pedMesAnt": "<xsl:value-of select="PEDIDOS/MES_ANTERIOR" />",
                                    "ped30Dias": "<xsl:value-of select="PEDIDOS/ULTIMOS_30DIAS" />",
                                    "pedUltimoDia": "<xsl:value-of select="PEDIDOS/ULTIMO_DIA_LABORABLE" />",
                                    "pedDiaActual": "<xsl:value-of select="PEDIDOS/DIA_ACTUAL" />",
                                    "incPedPend": "<xsl:value-of select="INCIDENCIAS/PEDIDOS_PENDIENTES_ACEPTAR" />",
                                    "incPedProbl": "<xsl:value-of select="INCIDENCIAS/PEDIDOS_PROBLEMATICOS" />"
                                }}
                </xsl:when>
                <xsl:otherwise>
                   {"datosEmpresa": {				
                                    "empID": "<xsl:value-of select="EMP_ID" />",
                                    "empNombre": "<xsl:value-of select="EMP_NOMBRE" />",
                                    "empPotComprasMens": "<xsl:value-of select="EMP_POTENCIAL_COMPRASMENSUALES" />",
                                    "empPotCatalogo": "<xsl:value-of select="EMP_POTENCIAL_CATALOGO" />",
                                    "catCatal": "<xsl:value-of select="CATALOGO/CATALOGADOS" />",
                                    "catAdj": "<xsl:value-of select="CATALOGO/ADJUDICADOS" />",
                                    "catComprados12": "<xsl:value-of select="CATALOGO/COMPRADOS_12MESES" />",
                                    "pedCompras12": "<xsl:value-of select="PEDIDOS/COMPRAS_12MESES" />",
                                    "pedMesAnt": "<xsl:value-of select="PEDIDOS/MES_ANTERIOR" />",
                                    "ped30Dias": "<xsl:value-of select="PEDIDOS/ULTIMOS_30DIAS" />",
                                    "pedUltimoDia": "<xsl:value-of select="PEDIDOS/ULTIMO_DIA_LABORABLE" />",
                                    "pedDiaActual": "<xsl:value-of select="PEDIDOS/DIA_ACTUAL" />",
                                    "incPedPend": "<xsl:value-of select="INCIDENCIAS/PEDIDOS_PENDIENTES_ACEPTAR" />",
                                    "incPedProbl": "<xsl:value-of select="INCIDENCIAS/PEDIDOS_PROBLEMATICOS" />"
                                }},
                </xsl:otherwise>
        </xsl:choose>
    </xsl:for-each>	
    ]
</xsl:if>
}


</xsl:template>
</xsl:stylesheet>
