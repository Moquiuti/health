<?xml version="1.0" encoding="iso-8859-1"?>
<!-- Revisado ET 13mar17 09:09	-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>


<!-- Tabla Centros Estudio Previo -->
<xsl:template name="Tabla_Centros_Estudio_Previo">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:value-of select="/Mantenimiento/LANG"/>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<div id="lCentros" style="display:none;margin-top:30px;">
	<!--<table class="divLeft infoTable" id="lCentros_EST" border="0">-->
	<table class="buscador" id="lCentros_EST">
	<thead>
		<tr class="subTituloTabla">
			<td class="uno">&nbsp;</td>
			<td class="zerouno">&nbsp;</td>
			<td class="veinte" style="text-align:left;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_corto']/node()"/>
			</td>
			<td style="text-align:left;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>
			</td>
			<td style="text-align:left;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>
			</td>
			<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='acciones']/node()"/></td>
		</tr>
	</thead>

	<!-- Aqui dentro se informara el cuerpo de la tabla via javascript -->
	<tbody>
	<xsl:choose>
	<xsl:when test="/Mantenimiento/LICITACION/CENTROSLICITACION/CENTRO">
		<xsl:for-each select="/Mantenimiento/LICITACION/CENTROSLICITACION/CENTRO">

		<!--<tr style="border-bottom:1px solid #7d7d7d;">-->
		<tr>
			<td colspan="2">&nbsp;</td>
			<td class='datosLeft'><xsl:value-of select="NOMBRECORTO"/></td>
			<td class='datosLeft'><xsl:value-of select="NOMBRE"/></td>
			<td class='datosLeft'><xsl:value-of select="ESTADOCOMPRA"/></td>
			<td>
				<xsl:if test="/Mantenimiento/LICITACION/AUTOR">
					<a class="accBorrar" href="javascript:borrarCentro({LICC_ID}, {CEN_ID});">
						<img src="http://www.newco.dev.br/images/2017/trash.png"/>
					</a>
				</xsl:if>
			</td>
		</tr>
		</xsl:for-each>
	</xsl:when>
	<xsl:otherwise>
		<tr><td colspan="5" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion_sin_centros']/node()"/></strong></td></tr>
	</xsl:otherwise>
	</xsl:choose>

	</tbody>

	</table>

	<xsl:if test="/Mantenimiento/LICITACION/AUTOR">
	<form id="Centros" name="Centros" method="post">
		<!--<table class="divLeft infoTable incidencias" id="lCentrosForm" cellspacing="5">-->
		<table class="buscador" id="lCentrosForm">
			<!--<tr style="border-top:2px solid #66667B;">-->
			<tr class="sinLinea">
				<td class="veinte">&nbsp;</td>
				<td class="labelRight veinte grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</td>
				<td class="veinte datosLeft">
					<select name="LIC_IDCENTRO" id="LIC_IDCENTRO">
						<option value=""><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciona']/node()"/></option>
						<xsl:for-each select="/Mantenimiento/LICITACION/field[@name='CENTROSLICITACION']/dropDownList/listElem">
							<option value="{ID}"><xsl:value-of select="listItem"/></option>
						</xsl:for-each>
					</select>
					<xsl:if test="/Mantenimiento/LICITACION/EDITAR_SELECCIONES">
					&nbsp;<a href="javascript:MostrarSelecciones();"><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciones']/node()"/></a>
					</xsl:if>
				</td>
				<td>&nbsp;</td>
			</tr>

			<tr class="sinLinea">
				<td colspan="2">&nbsp;</td>
				<td>
					<!--<div class="boton">-->
						<a class="btnDestacado" href="javascript:ValidarFormulario(document.forms['Centros'],'centros');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir']/node()"/>
						</a>
					<!--</div>-->
				</td>
				<td>&nbsp;</td>
			</tr>
		</table>
	</form>
	</xsl:if>



</div>

</xsl:template>
<!-- FIN Tabla Centros Estudio Previo -->


<!-- Tabla Centros -->
<xsl:template name="Tabla_Centros">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:value-of select="/Mantenimiento/LANG"/>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<div id="lCentros" style="display:none;margin-top:30px;">
	<!--<table class="divLeft buscador" id="lCentros" border="0">-->
	<table class="buscador" id="lCentros" border="0">
	<thead>
		<tr class="subTituloTabla">
			<td class="uno">&nbsp;</td>
			<td class="zerouno">&nbsp;</td>
			<td class="veinte" style="text-align:left;">
				<!-- Permitimos ordenacion -->
				<!--&nbsp;<a href="javascript:OrdenarCentrosPorColumna('NombreCorto');" style="text-decoration:none;" id="anchorNombreCortoCen">-->
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_corto']/node()"/>
				<!--</a>-->
			</td>
			<td style="text-align:left;">
				<!-- Permitimos ordenacion -->
				<!--&nbsp;<a href="javascript:OrdenarCentrosPorColumna('NombreLargo');" style="text-decoration:none;" id="anchorNombreLargoCen">-->
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>
				<!--</a>-->
			</td>
			<td style="text-align:left;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>
			</td>
			<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='acciones']/node()"/></td>
		</tr>
	</thead>

	<!-- Aqui dentro se informara el cuerpo de la tabla via javascript -->
	<tbody>
	<xsl:choose>
	<xsl:when test="/Mantenimiento/LICITACION/CENTROSLICITACION/CENTRO">
		<xsl:for-each select="/Mantenimiento/LICITACION/CENTROSLICITACION/CENTRO">

		<tr style="border-bottom:1px solid #7d7d7d;">
			<td colspan="2">&nbsp;</td>
			<td class='datosLeft'><xsl:value-of select="NOMBRECORTO"/></td>

			<td class='datosLeft'><xsl:value-of select="NOMBRE"/></td>
			<td class='datosLeft'><xsl:value-of select="ESTADOCOMPRA"/></td>
			<td>&nbsp;</td>
		</tr>
		</xsl:for-each>
	</xsl:when>
	<xsl:otherwise>
		<tr><td colspan="5" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion_sin_centros']/node()"/></strong></td></tr>
	</xsl:otherwise>
	</xsl:choose>

	</tbody>

	</table>
</div>

</xsl:template>
<!-- FIN Tabla Centros -->

</xsl:stylesheet>
