<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Solicitudes de Catalogacion. Nuevo disenno 2022.
	Ultima revision: ET 13may22 11:55 SolicitudCatalogacion2022_130522.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:param name="usuario" select="@US_ID"/>

<xsl:template match="/SolicitudesCatalogacion">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/SolicitudesCatalogacion/LANG"><xsl:value-of select="/SolicitudesCatalogacion/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<META Http-Equiv="Cache-Control" Content="no-cache" />

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitudes_catalogacion']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/SolicitudCatalogacion2022_130522.js"></script>
</head>
<body>
<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/SolicitudesCatalogacion/LANG"><xsl:value-of select="/SolicitudesCatalogacion/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->
<xsl:choose>
	<xsl:when test="//SESION_CADUCADA">
		<xsl:apply-templates select="//SESION_CADUCADA"/>
	</xsl:when>
	<xsl:when test="//Sorry">
		<xsl:apply-templates select="//Sorry"/>
	</xsl:when>
	<xsl:otherwise>
            <!--idioma-->
            <xsl:variable name="lang">
                    <xsl:choose>
                            <xsl:when test="/SolicitudesCatalogacion/LANG"><xsl:value-of select="/SolicitudesCatalogacion/LANG"/></xsl:when>
                            <xsl:otherwise>spanish</xsl:otherwise>
                    </xsl:choose>
            </xsl:variable>
            <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
            <!--idioma fin-->

		<xsl:variable name="usuario">
		<xsl:choose>
			<xsl:when test="not(SOLICITUDESCATALOGACION/OBSERVADOR) and SOLICITUDESCATALOGACION/CDC">CDC</xsl:when>
			<xsl:otherwise>NORMAL</xsl:otherwise>
		</xsl:choose>
		</xsl:variable>

	<!--	Titulo de la p�gina		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitudes_catalogacion']/node()"/>&nbsp;&nbsp;
			&nbsp;&nbsp;
			<span class="CompletarTitulo">
                <xsl:if test="SOLICITUDESCATALOGACION/ROL='COMPRADOR'">
				<a class="btnDestacado" href="javascript:NuevaSolicitud();"> 
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/>
				</a>
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>
	
		<form name="Buscador" method="post" action="SolicitudesCatalogacion2022.xsql">
		<table cellspacing="6px" cellpadding="6px">
			<tr class="h50px">
				<th class="uno">&nbsp;</th>
				<th width="80px" style="text-align:left">
                    <a href="javascript:Reset(document.forms['Buscador']);">
                        <xsl:choose>
                            <xsl:when test="/SolicitudesCatalogacion/LANG='spanish'"><img src="http://www.newco.dev.br/images/sinFiltros.gif" alt="Sin filtros" /></xsl:when>
                            <xsl:otherwise><img src="http://www.newco.dev.br/images/sinFiltros-BR.gif" alt="N�o filtrada" /></xsl:otherwise>
                        </xsl:choose>
                    </a>
                </th>
				<xsl:choose>
				<xsl:when test="SOLICITUDESCATALOGACION/MVM or SOLICITUDESCATALOGACION/MVMB or SOLICITUDESCATALOGACION/ROL = 'VENDEDOR'">
					<th class="w200px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="SOLICITUDESCATALOGACION/FIDEMPRESA/field"/>
          				<xsl:with-param name="claSel">w200px</xsl:with-param>
					</xsl:call-template>
					</th>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="FIDEMPRESA" value="-1" id="FIDEMPRESA"/>
				</xsl:otherwise>
				</xsl:choose>

				<th class="w140px textLeft">
				<xsl:choose>
				<xsl:when test="SOLICITUDESCATALOGACION/ROL = 'COMPRADOR' and SOLICITUDESCATALOGACION/CDC">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></label><br />
					<xsl:call-template name="desplegable">
                        <xsl:with-param name="path" select="SOLICITUDESCATALOGACION/FIDCENTRO/field"/>
          				<xsl:with-param name="claSel">w140px</xsl:with-param>
                    </xsl:call-template>
				</xsl:when>
				<xsl:when test="SOLICITUDESCATALOGACION/ROL != 'VENDEDOR'">
					<input type="hidden" name="FIDCENTRO" value="-1" id="FIDCENTRO"/>
				</xsl:when>
				<xsl:otherwise>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="SOLICITUDESCATALOGACION/FIDCENTRO/field"/>
          				<xsl:with-param name="claSel">w140px</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
				</xsl:choose>
				</th>

				<th class="w140px textLeft">
				<xsl:choose>
				<xsl:when test="SOLICITUDESCATALOGACION/ROL = 'COMPRADOR' and SOLICITUDESCATALOGACION/CDC">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/></label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="SOLICITUDESCATALOGACION/FIDRESPONSABLE/field"/>
          				<xsl:with-param name="claSel">w140px</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="SOLICITUDESCATALOGACION/ROL != 'VENDEDOR'">
					<input type="hidden" name="FIDRESPONSABLE" value="-1" id="FIDRESPONSABLE"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="FIDRESPONSABLE" value="-1" id="FIDRESPONSABLE"/>
				</xsl:otherwise>
				</xsl:choose>
				</th>

				<th class="w140px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/></label><br />
					<input type="text" name="FTEXTO" id="FTEXTO" class="campopesquisa w150px">
						<xsl:attribute name="value"><xsl:value-of select="SOLICITUDESCATALOGACION/FTEXTO"/></xsl:attribute>
					</input>
				</th>

				<th class="w140px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="SOLICITUDESCATALOGACION/FESTADO/field"/>
          				<xsl:with-param name="claSel">w140px</xsl:with-param>
					</xsl:call-template>
				</th>

				<th width="140px" class="textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo']/node()"/></label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="SOLICITUDESCATALOGACION/FPLAZO/field"/>
          				<xsl:with-param name="claSel">w140px</xsl:with-param>
					</xsl:call-template>
				</th>

				<th class="w140px textLeft">
               		<br/>
					<a class="btnDestacado" href="javascript:BuscarSolicitudesCatalogacion(document.forms['Buscador']);">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
					</a>
				</th>
				<th>&nbsp;</th>
			</tr>
		</table>
		</form>

		<div id="SolicitudBorradaOK" style="display:none;background:#CEF6CE;padding:5px;width:400px;color:#7d7d7d;font-weight:bold;text-align:center;border:1px solid #01DF01;margin:10px auto;"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_solicitud_OK']/node()"/></div>
		<div id="SolicitudBorradaKO" style="display:none;background:#F8E0E6;padding:5px;width:400px;color:#7d7d7d;font-weight:bold;text-align:center;border:1px solid red;margin:10px auto;"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_solicitud_KO']/node()"/></div>

		<div class="tabela tabela_redonda">
		<table cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
			<tr>
				<th class="w1px"></th>
				<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_abbr']/node()"/></th>
				<th class="w100px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_cliente']/node()"/></th>
				<th class="textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/></th>
				<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='prod']/node()"/></th>
				<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='prod_cat']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/></th>
				<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
				<th class="w1px">&nbsp;</th>
			</tr>
		</thead>
		<!--	Cuerpo de la tabla	-->
		<tbody class="corpo_tabela">
        <xsl:choose>
		<xsl:when test="SOLICITUDESCATALOGACION/SOLICITUD">
			<xsl:for-each select="SOLICITUDESCATALOGACION/SOLICITUD">
				<xsl:variable name="SolicID"><xsl:value-of select="SC_ID"/></xsl:variable>
				<tr id="SOLIC_{SC_ID}" style="border-bottom:1px solid #A7A8A9;">
					<xsl:choose>
					<xsl:when test="MODIFICADO_1HORA">
						<xsl:attribute name="class">fondoNaranja</xsl:attribute>
					</xsl:when>
					<xsl:when test="MODIFICADO_24HORAS">
						<xsl:attribute name="class">fondoAmarillo</xsl:attribute>
					</xsl:when>
					</xsl:choose>
					<td class="color_status"><xsl:value-of select="position()"/></td>
					<td>
                        <a href="javascript:Solicitud('{SC_ID}');">
                            <xsl:value-of select="SC_CODIGO"/>
                        </a>
                    </td>
					<td><xsl:value-of select="SC_FECHA"/></td>
                    <td class="textLeft">
						<a href="javascript:FichaEmpresa('{IDCLIENTE}');">
							<xsl:value-of select="CLIENTE"/>
						</a>
					</td>
					<td class="textLeft">
						<a href="javascript:FichaCentro('{IDCENTROCLIENTE}');">
							<xsl:value-of select="CENTROCLIENTE"/>
                        </a>
					</td>
					<td class="textLeft">
						<strong>
                        <a href="javascript:Solicitud('{SC_ID}');">
							<xsl:value-of select="SC_TITULO"/>
                        </a>
                        </strong>
					</td>
					<td><xsl:value-of select="SC_NUMPRODUCTOS"/></td>
					<td><xsl:value-of select="SC_NUMPRODUCTOSCAT"/></td>
					<td class="textLeft"><xsl:value-of select="USUARIO"/></td>
					<td class="textLeft"><xsl:value-of select="ESTADO"/></td>
					<td>
					<xsl:if test="$usuario = 'CDC'">
						<a href="javascript:BorrarSolicitudCatalogacion('{SC_ID}');"><img src="http://www.newco.dev.br/images/2022/icones/del.svg"/></a>
					</xsl:if>
					</td>
				</tr>
			</xsl:for-each>
                </xsl:when>
		<xsl:otherwise>
			<tr><td colspan="11" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_catalogacion_sin_resultados']/node()"/></strong></td></tr>
		</xsl:otherwise>
		</xsl:choose>
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="12">&nbsp;</td></tr>
		</tfoot>
	</table><!--fin de infoTableAma-->
 	</div>
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  
	</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
