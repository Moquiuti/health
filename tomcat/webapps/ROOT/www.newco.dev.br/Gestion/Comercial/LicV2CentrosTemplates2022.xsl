<?xml version="1.0" encoding="iso-8859-1"?>
<!-- 
	Template para la pestaña de CENTROS de la licitación V2. Disenno 2022
	ultima revision: ET 27jun22 11:30
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>


<!-- Tabla Centros Estudio Previo -->
<xsl:template name="Tabla_Centros_Editable">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/Mantenimiento/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<table class="buscador" id="lCentros_EST" cellspacing="6px" cellpadding="6px">
	<thead class="cabecalho_tabela">
		<tr>
			<th class="w1px">&nbsp;</th>
			<th class="w1px">&nbsp;</th>
			<th class="veinte textLeft">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_corto']/node()"/>
			</th>
			<th class="textLeft">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>
			</th>
			<th class="textLeft">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>
			</th>
			<th class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='acciones']/node()"/></th>
		</tr>
	</thead>

	<!-- Aqui dentro se informara el cuerpo de la tabla via javascript -->
	<tbody class="corpo_tabela">
		<xsl:choose>
		<xsl:when test="/Mantenimiento/LICITACION/CENTROSLICITACION/CENTRO">
			<xsl:for-each select="/Mantenimiento/LICITACION/CENTROSLICITACION/CENTRO">
			<tr class="conhover">
				<td class="color_status">&nbsp;</td>
				<td>&nbsp;</td>
				<td class="textLeft"><xsl:value-of select="NOMBRECORTO"/></td>
				<td class="textLeft"><xsl:value-of select="NOMBRE"/></td>
				<td class="textLeft"><xsl:value-of select="ESTADOCOMPRA"/></td>
				<td>
					<xsl:if test="/Mantenimiento/LICITACION/AUTOR">
						<a class="accBorrar" href="javascript:borrarCentro({LICC_ID}, {CEN_ID});">
							<img src="http://www.newco.dev.br/images/2022/icones/del.svg"/>
						</a>
					</xsl:if>
				</td>
			</tr>
			</xsl:for-each>
		</xsl:when>
		<xsl:otherwise>
			<tr><td colspan="6" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion_sin_centros']/node()"/></strong></td></tr>
		</xsl:otherwise>
		</xsl:choose>
	</tbody>
	<tfoot class="rodape_tabela">
		<tr><td colspan="6">&nbsp;</td></tr>
	</tfoot>
	</table>
	<br/>
	<br/>

	<xsl:if test="(/Mantenimiento/LICITACION/AUTOR) and (/Mantenimiento/LICITACION/field[@name='CENTROSLICITACION']/dropDownList/listElem)">
	<form id="frmCentros" name="frmCentros" class="formEstandar" method="post">
        <ul style="width:800px;">
			<li class="sinSeparador">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;</label>
				<select name="LIC_IDCENTRO" id="LIC_IDCENTRO" class="w300px">
					<option value=""><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciona']/node()"/></option>
					<xsl:for-each select="/Mantenimiento/LICITACION/field[@name='CENTROSLICITACION']/dropDownList/listElem">
						<option value="{ID}"><xsl:value-of select="listItem"/></option>
					</xsl:for-each>
				</select>
				<xsl:if test="/Mantenimiento/LICITACION/EDITAR_SELECCIONES">
				&nbsp;<a class="btnDiscreto" href="javascript:MostrarSelecciones();"><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciones']/node()"/></a>
				</xsl:if>
	        </li>
			<li class="sinSeparador">
				<label>&nbsp;</label>
				<a class="btnDestacado" href="javascript:AnadirCentro();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir']/node()"/>
				</a>
	        </li>
		</ul>
	</form>
	</xsl:if>

</xsl:template>
<!-- FIN Tabla Centros Estudio Previo -->


<!-- Tabla Centros -->
<xsl:template name="Tabla_Centros_Estatica">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/Mantenimiento/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<table id="tbUsuarios" cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
		<tr>
			<th class="w1px">&nbsp;</th>
			<th class="w1px">&nbsp;</th>
			<th class="w200px textLeft">
				<!-- Permitimos ordenacion -->
				<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_corto']/node()"/>
			</th>
			<th class="textLeft">
				<!-- Permitimos ordenacion -->
				<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>
			</th>
			<th class="textLeft">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>
			</th>
			<th class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='acciones']/node()"/></th>
		</tr>
	</thead>

	<!-- Aqui dentro se informara el cuerpo de la tabla via javascript -->
	<tbody class="corpo_tabela">
		<xsl:choose>
		<xsl:when test="/Mantenimiento/LICITACION/CENTROSLICITACION/CENTRO">
			<xsl:for-each select="/Mantenimiento/LICITACION/CENTROSLICITACION/CENTRO">
			<tr class="conhover">
				<td class="color_status">&nbsp;</td>
				<td>&nbsp;</td>
				<td class="textLeft"><xsl:value-of select="NOMBRECORTO"/></td>
				<td class="textLeft"><xsl:value-of select="NOMBRE"/></td>
				<td class="textLeft"><xsl:value-of select="ESTADOCOMPRA"/></td>
				<td>&nbsp;</td>
			</tr>
			</xsl:for-each>
		</xsl:when>
		<xsl:otherwise>
			<tr><td colspan="5" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion_sin_centros']/node()"/></strong></td></tr>
		</xsl:otherwise>
		</xsl:choose>
	</tbody>
	<tfoot class="rodape_tabela">
		<tr><td colspan="6">&nbsp;</td></tr>
	</tfoot>
	</table>

</xsl:template>
<!-- FIN Tabla Centros -->

</xsl:stylesheet>
