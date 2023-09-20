<?xml version="1.0" encoding="iso-8859-1"?>
<!--incidencias de producto-->
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
		<xsl:when test="Incidencias/LANG"><xsl:value-of select="Incidencias/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='incidencias']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/proIncidencias170915.js"></script>
	<script type="text/javascript">
		var errorEliminarIncidencia	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_eliminar_incidencia']/node()"/>';
	</script>
</head>

<body class="gris">
<xsl:choose>
<xsl:when test="Incidencias/SESION_CADUCADA">
	<xsl:for-each select="Incidencias/SESION_CADUCADA">
		<xsl:if test="position()=last()">
			<xsl:apply-templates select="."/>
		</xsl:if>
	</xsl:for-each>
</xsl:when>
<xsl:when test="//xsql-error">
	<xsl:apply-templates select="//xsql-error"/>
</xsl:when>
<xsl:otherwise>
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
	<xsl:when test="Incidencias/LANG"><xsl:value-of select="Incidencias/LANG" /></xsl:when>
	<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:variable name="usuario">
		<xsl:choose>
		<xsl:when test="/Incidencias/INCIDENCIAS/OBSERVADOR">OBSERVADOR</xsl:when>
		<xsl:when test="/Incidencias/INCIDENCIAS/MVM or /Incidencias/INCIDENCIAS/MVMB or /Incidencias/INCIDENCIAS/CDC">CDC</xsl:when>
		<xsl:otherwise>NORMAL</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<div style="background:#fff;float:left;">
	<!--boton volver a la ficha, si vengo desde incidencias o desde un buscador-->
	<xsl:choose>
	<xsl:when test="/Incidencias/LIC_PROD_ID != ''">
		<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?LIC_PROD_ID={Incidencias/LIC_PROD_ID}&amp;LIC_OFE_ID={/Incidencias/LIC_OFE_ID}" style="text-decoration:none;">
			<img src="http://www.newco.dev.br/images/botonFicha.gif" alt="FICHA"/>
		</a>
	</xsl:when>
	<xsl:otherwise>
		<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID={/Incidencias/PRO_ID}&amp;IDCLIENTE={/Incidencias/INCIDENCIAS/INCIDENCIA/PROD_INC_IDCLIENTE}" style="text-decoration:none;">
			<img src="http://www.newco.dev.br/images/botonFicha.gif" alt="FICHA"/>
		</a>
	</xsl:otherwise>
	</xsl:choose>

	<!--productos equivalentes-->
	<xsl:if test="$usuario = 'CDC' or $usuario = 'OBSERVADOR'">
		&nbsp;
		<a style="text-decoration:none;">
			<xsl:attribute name="href">http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="/Incidencias/PRO_ID"/>&amp;IDCLIENTE=<xsl:value-of select="/Incidencias/INCIDENCIAS/INCIDENCIA/PROD_INC_IDCLIENTE"/>&amp;USER=CDC&amp;DEST=EQUIV</xsl:attribute>

			<xsl:choose>
			<xsl:when test="/Incidencias/LANG = 'spanish'">
				<img src="http://www.newco.dev.br/images/botonEquivalentes.gif" alt="EQUIVALENTES"/>
			</xsl:when>
			<xsl:otherwise>
				<img src="http://www.newco.dev.br/images/botonEquivalentes-Br.gif" alt="EQUIVALENTES"/>
			</xsl:otherwise>
			</xsl:choose>
		</a>
	</xsl:if>
	</div><!--fin de bloque de pestañas-->

	<div style="background:#fff;float:right">

		<a style="text-decoration:none;">
			<xsl:attribute name="href">
				<xsl:choose>
				<xsl:when test="/Incidencias/LIC_PROD_ID != ''">http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencias.xsql?LIC_PROD_ID=<xsl:value-of select="Incidencias/LIC_PROD_ID"/>&amp;LIC_OFE_ID=<xsl:value-of select="/Incidencias/LIC_OFE_ID"/>&amp;USER=<xsl:value-of select="$usuario"/>&amp;PRO_ID=<xsl:value-of select="/Incidencias/PRO_ID"/>&amp;PRO_NOMBRE=<xsl:value-of select="/Incidencias/PRO_NOMBRE"/></xsl:when>
				<xsl:otherwise>http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencias.xsql?PRO_ID=<xsl:value-of select="/Incidencias/PRO_ID"/>&amp;USER=<xsl:value-of select="$usuario"/></xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>

			<xsl:choose>
			<xsl:when test="/Incidencias/LANG = 'spanish'">
				<img src="http://www.newco.dev.br/images/botonIncidencias1.gif" alt="INCIDENCIAS"/>
			</xsl:when>
			<xsl:otherwise>
				<img src="http://www.newco.dev.br/images/botonIncidencias1-Br.gif" alt="INCIDENCIAS"/>
			</xsl:otherwise>
			</xsl:choose>
		</a>

	<!-- Para crear nueva incidencia solo los usuarios de la empresa -->
	<xsl:if test="/Incidencias/INCIDENCIAS/IDEMPRESAUSUARIO = /Incidencias/INCIDENCIAS/INCIDENCIA/PROD_INC_IDCLIENTE and $usuario != 'OBSERVADOR'">
		&nbsp;
		<a style="text-decoration:none;">
			<xsl:attribute name="href">
				<xsl:choose>
				<xsl:when test="/Incidencias/LIC_PROD_ID != ''">http://www.newco.dev.br/Administracion/Mantenimiento/Productos/NuevaIncidencia.xsql?LIC_PROD_ID=<xsl:value-of select="Incidencias/LIC_PROD_ID"/>&amp;LIC_OFE_ID=<xsl:value-of select="/Incidencias/LIC_OFE_ID"/>&amp;PRO_ID=<xsl:value-of select="/Incidencias/PRO_ID"/>&amp;USER=<xsl:value-of select="$usuario"/>&amp;PRO_NOMBRE=<xsl:value-of select="/Incidencias/PRO_NOMBRE"/></xsl:when>
				<xsl:otherwise>http://www.newco.dev.br/Administracion/Mantenimiento/Productos/NuevaIncidencia.xsql?PRO_ID=<xsl:value-of select="/Incidencias/PRO_ID"/>&amp;USER=<xsl:value-of select="$usuario"/></xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>

			<xsl:choose>
			<xsl:when test="/Incidencias/LANG = 'spanish'">
				<img src="http://www.newco.dev.br/images/botonNuevaIncidencia.gif" alt="NUEVAINCIDENCIA"/>
			</xsl:when>
			<xsl:otherwise>
				<img src="http://www.newco.dev.br/images/botonNuevaIncidencia-Br.gif" alt="NUEVAINCIDENCIA"/>
			</xsl:otherwise>
			</xsl:choose>
		</a>
	</xsl:if>
	</div><!--fin de bloque de pestañas-->

	<div class="divLeft">
		<h1 class="titlePage">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='incidencias']/node()"/>
			<xsl:choose>
				<xsl:when test="/Incidencias/INCIDENCIAS/INCIDENCIA[1]/PROD_INC_NOMBRE != ''">
					:&nbsp;
					<xsl:choose>
					<xsl:when test="string-length(/Incidencias/INCIDENCIAS/INCIDENCIA[1]/PROD_INC_NOMBRE) > 75">
						<xsl:value-of select="substring(/Incidencias/INCIDENCIAS/INCIDENCIA[1]/PROD_INC_NOMBRE, 1, 75)"/>...
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="/Incidencias/INCIDENCIAS/INCIDENCIA[1]/PROD_INC_NOMBRE"/>
					</xsl:otherwise>
					</xsl:choose>
					&nbsp;-&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:&nbsp;
					<xsl:choose>
					<xsl:when test="/Incidencias/INCIDENCIAS/INCIDENCIA[1]/PROD_INC_REFCLIENTE != ''">
						<xsl:value-of select="/Incidencias/INCIDENCIAS/INCIDENCIA[1]/PROD_INC_REFCLIENTE"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="/Incidencias/INCIDENCIAS/INCIDENCIA[1]/PROD_INC_REFERENCIA"/>
					</xsl:otherwise>
					</xsl:choose>
                                </xsl:when>
				<xsl:when test="/Incidencias/PRO_NOMBRE != ''">:&nbsp;<xsl:value-of select="/Incidencias/PRO_NOMBRE"/></xsl:when>
			</xsl:choose>
		</h1>

		<form name="Incidencias">
		<table class="grandeInicio">
                        <!-- Para editar tiene que ser usuario CdC de la empresa cliente (no MVM o MVMB) -->
			<!--<tr>
				<th colspan="13" height="20px;">
					<span class="rojo">
					<xsl:choose>
					<xsl:when test="/Incidencias/INCIDENCIAS/INCIDENCIA and /Incidencias/INCIDENCIAS/CDC and /Incidencias/INCIDENCIAS/IDEMPRESAUSUARIO = PROD_INC_IDCLIENTE">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='informar_incidencias']/node()"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='consultar_incidencias']/node()"/>
					</xsl:otherwise>
					</xsl:choose>
					</span>
				</th>
			</tr>-->
			<tr class="subTituloTabla">
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_abbr']/node()"/></th>
				<th class="ocho"><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha_comunicacion_2line']/node()"/></th>
				<th class="quince" align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/></th>
				<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
				<th class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='usuario_centro_2line']/node()"/></th>
				<th>&nbsp;</th>
				<th class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha_gestion_2line']/node()"/></th>
				<th class="quince" align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='diagnostico']/node()"/></th>
				<th class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='usuario_diagnostico_2line']/node()"/></th>
                                
                                <th class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha_propuesta_2line']/node()"/></th>
                                <th class="quince"><xsl:copy-of select="document($doc)/translation/texts/item[@name='propuesta']/node()"/></th>
                                <th class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='usuario_propuesta_2line']/node()"/></th>
                                
				<th class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha_solucion_2line']/node()"/></th>
				<th class="quince" align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='solucion']/node()"/></th>
				<th class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='usuario_solucion_2line']/node()"/></th>
			<xsl:if test="/Incidencias/INCIDENCIAS/CDC and /Incidencias/INCIDENCIAS/IDEMPRESAUSUARIO = /Incidencias/INCIDENCIAS/INCIDENCIA/PROD_INC_IDCLIENTE">
				<th>&nbsp;</th>
			</xsl:if>
			</tr>

		<tbody>
		<xsl:choose>
		<xsl:when test="/Incidencias/INCIDENCIAS/TOTAL = '0'">
			<tr>
				<td colspan="13"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_incidencias_producto']/node()"/></strong></td>
			</tr>
		</xsl:when>
		<xsl:otherwise>
		<xsl:for-each select="/Incidencias/INCIDENCIAS/INCIDENCIA">
		<xsl:if test="PROD_INC_IDESTADO != 'B'">
			<tr>
				<td><xsl:value-of select="PROD_INC_CODIGO"/></td>
				<td><xsl:copy-of select="PROD_INC_FECHA"/></td>
				<td class="textLeft">
					<xsl:choose>
					<!-- Texto largo => mostramos pop-up -->
					<xsl:when test="string-length(PROD_INC_DESCRIPCION) > 75">
						<a href="#" class="tooltip">
							<xsl:value-of select="substring(PROD_INC_DESCRIPCION,0,75)"/><xsl:text>...</xsl:text>
							<span class="classic"><xsl:value-of select="PROD_INC_DESCRIPCION"/></span>
						</a>
					</xsl:when>
					<!-- Texto cortio => no hace falta pop-up -->
					<xsl:otherwise>
							<xsl:value-of select="PROD_INC_DESCRIPCION"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td><xsl:value-of select="ESTADO"/></td>
				<td><xsl:value-of select="USUARIO"/></td>
				<td class="fondoAmarillo">
				<xsl:choose>
				<!-- Para editar tiene que ser usuario CdC de la empresa cliente (no MVM o MVMB) -->
				<xsl:when test="/Incidencias/INCIDENCIAS/CDC and /Incidencias/INCIDENCIAS/IDEMPRESAUSUARIO = PROD_INC_IDCLIENTE">
					<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencia.xsql?ID_INC={PROD_INC_ID}&amp;PRO_ID={PROD_INC_IDPRODUCTO}&amp;LIC_PROD_ID={/Incidencias/LIC_PROD_ID}&amp;LIC_OFE_ID={/Incidencias/LIC_OFE_ID}" title="Modifica">
						<img src="http://www.newco.dev.br/images/modificar.gif"/>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencia.xsql?ID_INC={PROD_INC_ID}&amp;PRO_ID={PROD_INC_IDPRODUCTO}&amp;LIC_PROD_ID={/Incidencias/LIC_PROD_ID}&amp;LIC_OFE_ID={/Incidencias/LIC_OFE_ID}" title="Consulta">
						<img src="http://www.newco.dev.br/images/consultar.gif"/>
					</a>					
				</xsl:otherwise>
				</xsl:choose>
				</td>
				<td><xsl:value-of select="PROD_INC_FECHADIAGNOSTICO"/></td>
				<td class="textLeft">
					<xsl:choose>
					<!-- Texto largo => mostramos pop-up -->
					<xsl:when test="string-length(PROD_INC_DIAGNOSTICO) > 75">
						<a href="#" class="tooltip">
							<xsl:value-of select="substring(PROD_INC_DIAGNOSTICO,0,75)"/><xsl:text>...</xsl:text>
							<span class="classic"><xsl:value-of select="PROD_INC_DIAGNOSTICO"/></span>
						</a>
					</xsl:when>
					<!-- Texto cortio => no hace falta pop-up -->
					<xsl:otherwise>
							<xsl:value-of select="PROD_INC_DIAGNOSTICO"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td><xsl:value-of select="USUARIODIAGNOSTICO"/></td>
                                <!--propuesta-->
                                <td><xsl:value-of select="PROD_INC_FECHAPROPSOLUCION"/></td>
                                <td class="textLeft">
                                    <xsl:choose>
					<!-- Texto largo => mostramos pop-up -->
					<xsl:when test="string-length(PROD_INC_PROPSOLUCION) > 75">
						<a href="#" class="tooltip">
							<xsl:value-of select="substring(PROD_INC_PROPSOLUCION,0,75)"/><xsl:text>...</xsl:text>
							<span class="classic"><xsl:value-of select="PROD_INC_PROPSOLUCION"/></span>
						</a>
					</xsl:when>
					<!-- Texto corto => no hace falta pop-up -->
					<xsl:otherwise>
							<xsl:value-of select="PROD_INC_PROPSOLUCION"/>
					</xsl:otherwise>
					</xsl:choose>
                                </td>
                                <td><xsl:value-of select="USUARIOPROPSOLUCION"/></td>
                                
                                <!--solucion-->
				<td><xsl:value-of select="PROD_INC_FECHASOLUCION"/></td>
				<td class="textLeft">
					<xsl:choose>
                                        <xsl:when test="PROD_INC_IDESTADO = 'RES' and not(PROD_INC_SOLUCION)">
                                            <span class="amarillo">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='resuelta']/node()"/>&nbsp;</span>
                                        </xsl:when>
					<!-- Texto largo => mostramos pop-up -->
					<xsl:when test="PROD_INC_SOLUCION != '' and string-length(PROD_INC_SOLUCION) > 75">
						<a href="#" class="tooltip">
							<xsl:value-of select="substring(PROD_INC_SOLUCION,0,75)"/><xsl:text>...</xsl:text>
							<span class="classic"><xsl:value-of select="PROD_INC_SOLUCION"/></span>
						</a>
					</xsl:when>
					<!-- Texto cortio => no hace falta pop-up -->
					<xsl:otherwise>
							<xsl:value-of select="PROD_INC_SOLUCION"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td><xsl:value-of select="USUARIOSOLUCION"/></td>
			<xsl:if test="/Incidencias/INCIDENCIAS/CDC and /Incidencias/INCIDENCIAS/IDEMPRESAUSUARIO = PROD_INC_IDCLIENTE and $usuario != 'OBSERVADOR'">
				<td>
					<a href="javascript:EliminarIncidencia({PROD_INC_ID})">
						<img src="http://www.newco.dev.br/images/2017/trash.png"/>
					</a>
				</td>
			</xsl:if>
			</tr>
		</xsl:if>
		</xsl:for-each>
		</xsl:otherwise>
		</xsl:choose>
		</tbody>
		</table>
		</form>
	</div><!--fin de divLeft-->
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>