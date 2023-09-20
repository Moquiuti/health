<?xml version="1.0" encoding="iso-8859-1"?>
<!-- 
	Recupera los datos de una tarea
	Ultima revision: ET 6jun19 17:48
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/Tarea">

	<xsl:param name="pPattern">"</xsl:param>
	<xsl:param name="pReplacement">\"</xsl:param>

	<xsl:text>{"Tarea":</xsl:text>

		<xsl:choose>
		<xsl:when test="GESTION">

			<!-- Evitamos la doble comilla (") en el nombre de producto -->
			<xsl:variable name="Texto">
				<xsl:call-template name="string-replace-all">
					<xsl:with-param name="text" select="GESTION/TEXTO"/>
					<xsl:with-param name="replace" select="$pPattern"/>
					<xsl:with-param name="by" select="$pReplacement"/>
				</xsl:call-template>
			</xsl:variable>

			<xsl:text>{"ID":"</xsl:text>
				<xsl:value-of select="GESTION/ID"/>
			<xsl:text>","IDIdioma":"</xsl:text>
				<xsl:value-of select="GESTION/IDIDIOMA"/>
			<xsl:text>","Fecha":"</xsl:text>
				<xsl:value-of select="GESTION/FECHA"/>
			<xsl:text>","FechaLimite":"</xsl:text>
				<xsl:value-of select="GESTION/FECHALIMITE"/>
			<xsl:text>","UltimoCambio":"</xsl:text>
				<xsl:value-of select="GESTION/ULTIMOCAMBIO"/>
			<xsl:text>","IDAutor":"</xsl:text>
				<xsl:value-of select="GESTION/IDAUTOR"/>
			<xsl:text>","Autor":"</xsl:text>
				<xsl:value-of select="GESTION/AUTOR"/>
			<xsl:text>","IDResponsable":"</xsl:text>
				<xsl:value-of select="GESTION/IDRESPONSABLE"/>
			<xsl:text>","Responsable":"</xsl:text>
				<xsl:value-of select="GESTION/RESPONSABLE"/>
			<xsl:text>","IDEmpresa":"</xsl:text>
				<xsl:value-of select="GESTION/IDEMPRESA"/>
			<xsl:text>","Empresa":"</xsl:text>
				<xsl:value-of select="GESTION/EMPRESA"/>
			<xsl:text>","IDCentro":"</xsl:text>
				<xsl:value-of select="GESTION/IDCENTRO"/>
			<xsl:text>","Centro":"</xsl:text>
				<xsl:value-of select="GESTION/CENTRO"/>
			<xsl:text>","Texto":"</xsl:text>
				<xsl:value-of select="$Texto"/>
			<xsl:text>","IDPrioridad":"</xsl:text>
				<xsl:value-of select="GESTION/IDPRIORIDAD"/>
			<xsl:text>","IDTipo":"</xsl:text>
				<xsl:value-of select="GESTION/GC_IDTIPO"/>
			<xsl:text>","IDEstado":"</xsl:text>
			<xsl:value-of select="GESTION/IDESTADO"/>
			<xsl:text>","Visibilidad":"</xsl:text>
				<xsl:value-of select="GESTION/VISIBILIDAD"/>
			<xsl:text>","IDDocumento":"</xsl:text>
				<xsl:value-of select="GESTION/IDDOCUMENTO"/>
			<xsl:text>","NombreDoc":"</xsl:text>
				<xsl:value-of select="GESTION/DOC_SEGUIMIENTO/NOMBRE"/>
			<xsl:text>","URLDoc":"</xsl:text>
				<xsl:value-of select="GESTION/DOC_SEGUIMIENTO/URL"/>
			<xsl:text>","FechaDoc":"</xsl:text>
				<xsl:value-of select="GESTION/DOC_SEGUIMIENTO/FECHA"/>
			<!--
			<xsl:text>","Responsables":[</xsl:text>

				<xsl:for-each select="GESTION/IDRESPONSABLE/field/dropDownList/listElem">
					<xsl:text>{"ID":"</xsl:text>
						<xsl:value-of select="ID"/>
						<xsl:text>","Nombre":"</xsl:text>
							<xsl:value-of select="listItem"/>
						<xsl:text>"}</xsl:text>

						<xsl:if test="position() != last()">
							<xsl:text>,</xsl:text>
						</xsl:if>
				</xsl:for-each>

				<xsl:text>],"Empresas":[</xsl:text>

				<xsl:for-each select="GESTION/IDEMPRESA/field/dropDownList/listElem">
					<xsl:text>{"ID":"</xsl:text>
						<xsl:value-of select="ID"/>
						<xsl:text>","Nombre":"</xsl:text>
							<xsl:value-of select="listItem"/>
						<xsl:text>"}</xsl:text>

						<xsl:if test="position() != last()">
							<xsl:text>,</xsl:text>
						</xsl:if>
				</xsl:for-each>
                                
                                <xsl:text>],"Responsables":[</xsl:text>

				<xsl:for-each select="GESTION/IDRESPONSABLE/field/dropDownList/listElem">
					<xsl:text>{"ID":"</xsl:text>
						<xsl:value-of select="ID"/>
						<xsl:text>","Nombre":"</xsl:text>
							<xsl:value-of select="listItem"/>
						<xsl:text>"}</xsl:text>

						<xsl:if test="position() != last()">
							<xsl:text>,</xsl:text>
						</xsl:if>
				</xsl:for-each>

				<xsl:text>],"Centros":[</xsl:text>

				<xsl:for-each select="GESTION/IDCENTRO/field/dropDownList/listElem">
					<xsl:text>{"ID":"</xsl:text>
						<xsl:value-of select="ID"/>
						<xsl:text>","Nombre":"</xsl:text>
							<xsl:value-of select="listItem"/>
						<xsl:text>"}</xsl:text>

						<xsl:if test="position() != last()">
							<xsl:text>,</xsl:text>
						</xsl:if>
				</xsl:for-each>

				<xsl:text>],"Prioridades":[</xsl:text>

				<xsl:for-each select="GESTION/PRIORIDAD/field/dropDownList/listElem">
					<xsl:text>{"ID":"</xsl:text>
						<xsl:value-of select="ID"/>
						<xsl:text>","Nombre":"</xsl:text>
							<xsl:value-of select="listItem"/>
						<xsl:text>"}</xsl:text>

						<xsl:if test="position() != last()">
							<xsl:text>,</xsl:text>
						</xsl:if>
				</xsl:for-each>

				<xsl:text>],"Estados":[</xsl:text>

				<xsl:for-each select="GESTION/ESTADO/field/dropDownList/listElem">
					<xsl:text>{"ID":"</xsl:text>
						<xsl:value-of select="ID"/>
						<xsl:text>","Nombre":"</xsl:text>
							<xsl:value-of select="listItem"/>
						<xsl:text>"}</xsl:text>

						<xsl:if test="position() != last()">
							<xsl:text>,</xsl:text>
						</xsl:if>
				</xsl:for-each>

				<xsl:text>],"Tipos":[</xsl:text>

				<xsl:for-each select="GESTION/TIPO/field/dropDownList/listElem">
					<xsl:text>{"ID":"</xsl:text>
						<xsl:value-of select="ID"/>
						<xsl:text>","Nombre":"</xsl:text>
							<xsl:value-of select="listItem"/>
						<xsl:text>"}</xsl:text>

						<xsl:if test="position() != last()">
							<xsl:text>,</xsl:text>
						</xsl:if>
				</xsl:for-each>

				<xsl:text>]}</xsl:text>
			-->
			<xsl:text>"}</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>{"Error":"SINDATOS"}</xsl:text>
		</xsl:otherwise>
		</xsl:choose>

	<xsl:text>}</xsl:text>
</xsl:template>

<xsl:template name="string-replace-all">
	<xsl:param name="text"/>
	<xsl:param name="replace"/>
	<xsl:param name="by"/>

	<xsl:choose>
	<xsl:when test="contains($text, $replace)">
		<xsl:value-of select="substring-before($text,$replace)"/>
		<xsl:value-of select="$by"/>

		<xsl:call-template name="string-replace-all">
			<xsl:with-param name="text" select="substring-after($text,$replace)"/>
			<xsl:with-param name="replace" select="$replace"/>
			<xsl:with-param name="by" select="$by"/>
		</xsl:call-template>
	</xsl:when>
	<xsl:otherwise>
		<xsl:copy-of select="$text"/>
	</xsl:otherwise>
	</xsl:choose>
</xsl:template>
</xsl:stylesheet>
