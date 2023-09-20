<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Ultima revision: ET 30dic16 08:46
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:param name="usuario" select="@US_ID"/>

<xsl:template match="/SolicitudesOferta">

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/SolicitudesOferta/LANG"><xsl:value-of select="/SolicitudesOferta/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<META Http-Equiv="Cache-Control" Content="no-cache" />

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitudes_oferta']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/SolicitudOferta121115.js"></script>
</head>
<body>
<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/SolicitudesOferta/LANG"><xsl:value-of select="/SolicitudesOferta/LANG"/></xsl:when>
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
                            <xsl:when test="/SolicitudesOferta/LANG"><xsl:value-of select="/SolicitudesOferta/LANG"/></xsl:when>
                            <xsl:otherwise>spanish</xsl:otherwise>
                    </xsl:choose>
            </xsl:variable>
            <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
            <!--idioma fin-->

		<xsl:variable name="usuario">
		<xsl:choose>
			<xsl:when test="not(SolicitudesOferta/OBSERVADOR) and SolicitudesOferta/CDC">CDC</xsl:when>
			<xsl:otherwise>NORMAL</xsl:otherwise>
		</xsl:choose>
		</xsl:variable>

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitudes_oferta']/node()"/></span></p>
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitudes_oferta']/node()"/>&nbsp;&nbsp;
			&nbsp;&nbsp;
			<span class="CompletarTitulo">
                <xsl:if test="SOLICITUDESOFERTA/PERMITIR_CREAR">
				<a class="btnDestacado" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/NuevaSolicitudOferta.xsql','Nueva solicitud',100,100,0,0);"> 
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/>
				</a>
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>

	<!--
		<h1 class="titlePage" style="float:left;width:60%;padding-left:20%;">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitudes_oferta']/node()"/>
		</h1>
                <h1 class="titlePage" style="float:left;width:20%;">
                    <xsl:if test="SOLICITUDESOFERTA/ROL='COMPRADOR'">
				<th>
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/NuevaSolicitudOferta.xsql','Nueva solicitud',100,100,0,0);">
                                                    <div class="botonNara">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/>
                                                    </div>
						</a>
					
                                </th>
                    </xsl:if>
                </h1>
	-->
	
		<form name="Buscador" method="post" action="SolicitudesOferta.xsql">
		<table class="buscador">
			<!--<tr class="select" height="50px">-->
			<tr class="filtros" height="50px">
				<th class="uno">&nbsp;</th>
				<th width="80px" style="text-align:left">
                    <a href="javascript:Reset(document.forms['Buscador']);">
                        <xsl:choose>
                            <xsl:when test="/SolicitudesOferta/LANG='spanish'"><img src="http://www.newco.dev.br/images/sinFiltros.gif" alt="Sin filtros" /></xsl:when>
                            <xsl:otherwise><img src="http://www.newco.dev.br/images/sinFiltros-BR.gif" alt="Não filtrada" /></xsl:otherwise>
                        </xsl:choose>
                    </a>
                </th>
				<xsl:choose>
				<xsl:when test="SOLICITUDESOFERTA/MVM or SOLICITUDESOFERTA/MVMB or SOLICITUDESOFERTA/ROL = 'VENDEDOR'">
					<th width="140px" style="text-align:left">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></label><br />
					<xsl:call-template name="desplegable"><xsl:with-param name="path" select="SOLICITUDESOFERTA/FIDEMPRESA/field"/></xsl:call-template>
					</th>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="FIDEMPRESA" value="-1" id="FIDEMPRESA"/>
				</xsl:otherwise>
				</xsl:choose>

				<th width="140px" style="text-align:left">
				<xsl:choose>
				<xsl:when test="SOLICITUDESOFERTA/ROL = 'COMPRADOR' and SOLICITUDESOFERTA/CDC">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></label><br />
					<xsl:call-template name="desplegable">
                        <xsl:with-param name="path" select="SOLICITUDESOFERTA/FIDCENTRO/field"/>
                    </xsl:call-template>
				</xsl:when>
				<xsl:when test="SOLICITUDESOFERTA/ROL != 'VENDEDOR'">
					<input type="hidden" name="FIDCENTRO" value="-1" id="FIDCENTRO"/>
				</xsl:when>
				<xsl:otherwise>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></label><br />
					<xsl:call-template name="desplegable"><xsl:with-param name="path" select="SOLICITUDESOFERTA/FIDCENTRO/field"/></xsl:call-template>
				</xsl:otherwise>
				</xsl:choose>
				</th>

				<th width="140px" style="text-align:left">
				<xsl:choose>
				<xsl:when test="SOLICITUDESOFERTA/ROL = 'COMPRADOR' and SOLICITUDESOFERTA/CDC">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/></label><br />
					<xsl:call-template name="desplegable"><xsl:with-param name="path" select="SOLICITUDESOFERTA/FIDRESPONSABLE/field"/></xsl:call-template>
				</xsl:when>
				<xsl:when test="SOLICITUDESOFERTA/ROL != 'VENDEDOR'">
					<input type="hidden" name="FIDRESPONSABLE" value="-1" id="FIDRESPONSABLE"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="FIDRESPONSABLE" value="-1" id="FIDRESPONSABLE"/>
				</xsl:otherwise>
				</xsl:choose>
				</th>

				<th width="140px" style="text-align:left">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/></label><br />
					<input type="text" name="FTEXTO" size="20" id="FTEXTO">
						<xsl:attribute name="value"><xsl:value-of select="SOLICITUDESOFERTA/FTEXTO"/></xsl:attribute>
					</input>
				</th>

				<th width="140px" style="text-align:left">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></label><br />
					<xsl:call-template name="desplegable"><xsl:with-param name="path" select="SOLICITUDESOFERTA/FESTADO/field"/></xsl:call-template>
				</th>

				<th width="140px" style="text-align:left;">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo']/node()"/></label><br />
					<xsl:call-template name="desplegable"><xsl:with-param name="path" select="SOLICITUDESOFERTA/FPLAZO/field"/></xsl:call-template>
				</th>

				<th width="140px" style="text-align:left">
                    <!--<div class="botonLargo">
					<strong>-->
						<a class="btnDestacadoPeq" href="javascript:BuscarSOLICITUDESOFERTA(document.forms['Buscador']);">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
						</a>
					<!--</strong>
					</div>-->
				</th>
				<th>&nbsp;</th>
			</tr>
		</table>
		</form>

		<div id="SolicitudBorradaOK" style="display:none;background:#CEF6CE;padding:5px;width:400px;color:#7d7d7d;font-weight:bold;text-align:center;border:1px solid #01DF01;margin:10px auto;"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_solicitud_OK']/node()"/></div>
		<div id="SolicitudBorradaKO" style="display:none;background:#F8E0E6;padding:5px;width:400px;color:#7d7d7d;font-weight:bold;text-align:center;border:1px solid red;margin:10px auto;"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_solicitud_KO']/node()"/></div>

		<!--<table class="grandeInicio">-->
		<table class="buscador">
		<thead>
			<tr class="subTituloTabla">
				<th class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
				<th class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_abbr']/node()"/></th>
				<th class="seis"><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
				<th class="quince" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>
				<th class="quince" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_cliente']/node()"/></th>
				<th style="text-align:left;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/></th>
				<!--<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/></th>-->
				<th class="seis"><xsl:value-of select="document($doc)/translation/texts/item[@name='prod']/node()"/></th>
				<th class="seis"><xsl:value-of select="document($doc)/translation/texts/item[@name='prod_cat']/node()"/></th>
				<th class="quince" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/></th>
				<th class="seis"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
				<th class="dos">&nbsp;</th>
			</tr>
		</thead>
        <xsl:choose>
		<xsl:when test="SOLICITUDESOFERTA/SOLICITUD">
			<xsl:for-each select="SOLICITUDESOFERTA/SOLICITUD">
				<xsl:variable name="SolicID"><xsl:value-of select="SO_ID"/></xsl:variable>
				<tr id="SOLIC_{SO_ID}" style="border-bottom:1px solid #A7A8A9;">
					<xsl:choose>
					<xsl:when test="MODIFICADO_1HORA">
						<xsl:attribute name="class">fondoNaranja</xsl:attribute>
					</xsl:when>
					<xsl:when test="MODIFICADO_24HORAS">
						<xsl:attribute name="class">fondoAmarillo</xsl:attribute>
					</xsl:when>
					</xsl:choose>

					<td><xsl:value-of select="position()"/></td>
					<td>
                        <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/SolicitudOferta.xsql?SO_ID={SO_ID}','solicitud catalogacion',100,80,0,-10)">
                            <xsl:value-of select="SO_CODIGO"/>
                        </a>
                    </td>
					<td><xsl:value-of select="SO_FECHA"/></td>
                       <td style="text-align:left;">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDCLIENTE}','DetalleEmpresa',100,80,0,0)">
							<xsl:value-of select="CLIENTE"/>
						</a>
					</td>
					<td style="text-align:left;">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTROCLIENTE}','DetalleCentro',100,80,0,0)">
							<xsl:value-of select="CENTROCLIENTE"/>
                        </a>
					</td>
					<td style="text-align:left;">
						<strong>
                            <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/SolicitudOferta.xsql?SO_ID={SO_ID}','solicitud catalogacion',100,80,0,-10)">
								<xsl:value-of select="SO_TITULO"/>
                        	</a>
                        </strong>
					</td>
					<!--<td style="text-align:left;">&nbsp;
						<xsl:choose>
						<xsl:when test="string-length(SO_DESCRIPCION) > 75">
							<a href="#" class="tooltip">
								<xsl:value-of select="substring(SO_DESCRIPCION,0,75)"/><xsl:text>...</xsl:text>
								<span class="classic"><xsl:value-of select="SO_DESCRIPCION"/></span>
							</a>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="SO_DESCRIPCION"/>
						</xsl:otherwise>
						</xsl:choose>
					</td>-->
					<td><xsl:value-of select="SO_NUMPRODUCTOS"/></td>
					<td><xsl:value-of select="SO_NUMPRODUCTOSCAT"/></td>
                    <td style="text-align:left;"><xsl:value-of select="USUARIO"/></td>
					<td  style="text-align:left;"><xsl:value-of select="ESTADO"/></td>
					<td>
					<xsl:if test="$usuario = 'CDC'">
						<a href="javascript:BorrarSolicitudOferta('{SO_ID}');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>
					</xsl:if>
					</td>
				</tr>
			</xsl:for-each>
                </xsl:when>
		<xsl:otherwise>
			<tr><td colspan="11" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_oferta_sin_resultados']/node()"/></strong></td></tr>
		</xsl:otherwise>
		</xsl:choose>
		</table>
	</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
