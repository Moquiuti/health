<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/PestanasInicio">

		<xsl:text>{</xsl:text>
			<xsl:if test="RESUMEN_PROCEDIMIENTOS/RESUMEN_PROCEDIMIENTOS_CDC">
				<xsl:text>"ResumenProcedimientosCDC":</xsl:text>
				<xsl:text>{"licitaciones":"</xsl:text>
				<xsl:value-of select="RESUMEN_PROCEDIMIENTOS/RESUMEN_PROCEDIMIENTOS_CDC/LICITACIONES"/>
				<xsl:text>","evaluaciones":"</xsl:text>
				<xsl:value-of select="RESUMEN_PROCEDIMIENTOS/RESUMEN_PROCEDIMIENTOS_CDC/EVALUACIONES"/>
				<xsl:text>","incidencias":"</xsl:text>
				<xsl:value-of select="RESUMEN_PROCEDIMIENTOS/RESUMEN_PROCEDIMIENTOS_CDC/INCIDENCIAS"/>
				<xsl:text>","solicitudes":"</xsl:text>
				<xsl:value-of select="RESUMEN_PROCEDIMIENTOS/RESUMEN_PROCEDIMIENTOS_CDC/SOLICITUDES"/>
				<xsl:text>","tareas":"</xsl:text>
				<xsl:value-of select="RESUMEN_PROCEDIMIENTOS/RESUMEN_PROCEDIMIENTOS_CDC/TAREAS"/>
				<xsl:text>"}</xsl:text>
			</xsl:if>

			<xsl:if test="RESUMEN_PROCEDIMIENTOS/RESUMEN_PROCEDIMIENTOS_CDC_1DIA">
				<xsl:text>,"ResumenProcedimientosCDC_1Dia":</xsl:text>
				<xsl:text>{"licitaciones":"</xsl:text>
				<xsl:value-of select="RESUMEN_PROCEDIMIENTOS/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/LICITACIONES"/>
				<xsl:text>","evaluaciones":"</xsl:text>
				<xsl:value-of select="RESUMEN_PROCEDIMIENTOS/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/EVALUACIONES"/>
				<xsl:text>","incidencias":"</xsl:text>
				<xsl:value-of select="RESUMEN_PROCEDIMIENTOS/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/INCIDENCIAS"/>
				<xsl:text>","solicitudes":"</xsl:text>
				<xsl:value-of select="RESUMEN_PROCEDIMIENTOS/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/SOLICITUDES"/>
				<xsl:text>","tareas":"</xsl:text>
				<xsl:value-of select="RESUMEN_PROCEDIMIENTOS/RESUMEN_PROCEDIMIENTOS_CDC_1DIA/TAREAS"/>
				<xsl:text>"}</xsl:text>
			</xsl:if>

			<xsl:if test="RESUMEN_PROCEDIMIENTOS/RESUMEN_PROCEDIMIENTOS_CDC_RECIENTES">
				<xsl:text>,"ResumenProcedimientosCDC_Recientes":</xsl:text>
				<xsl:text>{"licitaciones":"</xsl:text>
				<xsl:value-of select="RESUMEN_PROCEDIMIENTOS/RESUMEN_PROCEDIMIENTOS_CDC_RECIENTES/LICITACIONES"/>
				<xsl:text>","evaluaciones":"</xsl:text>
				<xsl:value-of select="RESUMEN_PROCEDIMIENTOS/RESUMEN_PROCEDIMIENTOS_CDC_RECIENTES/EVALUACIONES"/>
				<xsl:text>","incidencias":"</xsl:text>
				<xsl:value-of select="RESUMEN_PROCEDIMIENTOS/RESUMEN_PROCEDIMIENTOS_CDC_RECIENTES/INCIDENCIAS"/>
				<xsl:text>","solicitudes":"</xsl:text>
				<xsl:value-of select="RESUMEN_PROCEDIMIENTOS/RESUMEN_PROCEDIMIENTOS_CDC_RECIENTES/SOLICITUDES"/>
				<xsl:text>","tareas":"</xsl:text>
				<xsl:value-of select="RESUMEN_PROCEDIMIENTOS/RESUMEN_PROCEDIMIENTOS_CDC_RECIENTES/TAREAS"/>
				<xsl:text>"}</xsl:text>
			</xsl:if>
		<xsl:text>}</xsl:text>
</xsl:template>
</xsl:stylesheet>
