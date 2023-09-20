<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:param name="usuario" select="@US_ID"/>

<xsl:template match="/StockDemandaList">

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<META Http-Equiv="Cache-Control" Content="no-cache" />

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='demandas_stock']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/StockDemanda.js"></script>
</head>

<body>
<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
	<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
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

	<xsl:variable name="usuario">
		<xsl:choose>
		<xsl:when test="not(CONTROLPRECIOS_DEMANDAS/OBSERVADOR) and CONTROLPRECIOS_DEMANDAS/CDC">CDC</xsl:when>
		<xsl:otherwise>NORMAL</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<h1 class="titlePage" style="border:0px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='demandas_stock']/node()"/></h1>

	<form name="Buscador" method="post" action="StockDemandaList.xsql">
	<table class="buscador">
		<tr class="select" height="50px">
			<th class="dies">
<!--
        <br /><a href="javascript:Reset(document.forms['Buscador']);">
          <xsl:choose>
          <xsl:when test="LANG='spanish'"><img src="http://www.newco.dev.br/images/sinFiltros.gif" alt="Sin filtros" /></xsl:when>
          <xsl:otherwise><img src="http://www.newco.dev.br/images/sinFiltros-BR.gif" alt="Não filtrada" /></xsl:otherwise>
          </xsl:choose>
        </a>
-->
      </th>
			<th>
				<xsl:choose>
				<xsl:when test="CONTROLPRECIOS_DEMANDAS/MVM or CONTROLPRECIOS_DEMANDAS/MVMB or CONTROLPRECIOS_DEMANDAS/ROL = 'VENDEDOR'">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/><br />
					<xsl:call-template name="desplegable"><xsl:with-param name="path" select="CONTROLPRECIOS_DEMANDAS/FIDEMPRESA/field"/></xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="FIDEMPRESA" value="-1" id="FIDEMPRESA"/>
				</xsl:otherwise>
				</xsl:choose>
			</th>

			<th>
				<xsl:choose>
				<xsl:when test="CONTROLPRECIOS_DEMANDAS/ROL = 'COMPRADOR' and CONTROLPRECIOS_DEMANDAS/CDC">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/><br />
					<xsl:call-template name="desplegable"><xsl:with-param name="path" select="CONTROLPRECIOS_DEMANDAS/FIDCENTRO/field"/></xsl:call-template>
				</xsl:when>
				<xsl:when test="CONTROLPRECIOS_DEMANDAS/ROL != 'VENDEDOR'">
					<input type="hidden" name="FIDCENTRO" value="-1" id="FIDCENTRO"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/><br />
					<xsl:call-template name="desplegable"><xsl:with-param name="path" select="CONTROLPRECIOS_DEMANDAS/FIDCENTRO/field"/></xsl:call-template>
				</xsl:otherwise>
				</xsl:choose>
			</th>

			<th>
				<xsl:choose>
				<xsl:when test="CONTROLPRECIOS_DEMANDAS/ROL = 'COMPRADOR' and CONTROLPRECIOS_DEMANDAS/CDC">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/><br />
					<xsl:call-template name="desplegable"><xsl:with-param name="path" select="CONTROLPRECIOS_DEMANDAS/FIDRESPONSABLE/field"/></xsl:call-template>
				</xsl:when>
				<xsl:when test="CONTROLPRECIOS_DEMANDAS/ROL != 'VENDEDOR'">
					<input type="hidden" name="FIDRESPONSABLE" value="-1" id="FIDRESPONSABLE"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="FIDRESPONSABLE" value="-1" id="FIDRESPONSABLE"/>
				</xsl:otherwise>
				</xsl:choose>
			</th>

			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/><br />
					<input type="text" name="FTEXTO" size="20" id="FTEXTO">
						<xsl:attribute name="value"><xsl:value-of select="CONTROLPRECIOS_DEMANDAS/FTEXTO"/></xsl:attribute>
					</input>
			</th>

			<th>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/><br />
					<xsl:call-template name="desplegable"><xsl:with-param name="path" select="CONTROLPRECIOS_DEMANDAS/FESTADO/field"/></xsl:call-template>
			</th>

			<th><div class="botonLargo">
				<strong>
					<a href="javascript:BuscarStockDemandas(document.forms['Buscador']);">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
					</a>
				</strong>
				</div>
			</th>

			<th class="uno">&nbsp;</th>

			<xsl:if test="$usuario = 'CDC'">
			<th><div class="botonLargo">
				<strong><a href="javascript:NuevoStockDemanda();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/>
				</a></strong>
				</div>
      </th>
			</xsl:if>

			<th class="uno">&nbsp;</th>
		</tr>
	</table>
	</form>

	<div id="StockDemandaBorradaOK" style="display:none;background:#CEF6CE;padding:5px;width:400px;color:#01DF01;text-align:center;border:1px solid #01DF01;margin:10px auto;"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_stock_demanda_OK']/node()"/></div>
	<div id="StockDemandaBorradaKO" style="display:none;background:#F8E0E6;padding:5px;width:400px;color:red;text-align:center;border:1px solid red;margin:10px auto;"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_stock_demanda_KO']/node()"/></div>

	<table class="grandeInicio">
	<thead>
		<tr class="subTituloTabla">
			<th class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_abbr']/node()"/></th>
			<th><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
                        <th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>
			<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_cliente']/node()"/></th>
			<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/></th>
			<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/></th>
			<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/></th>
			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
			<th>&nbsp;</th>
		</tr>
	</thead>

  <xsl:choose>
	<xsl:when test="CONTROLPRECIOS_DEMANDAS/DEMANDA">
		<xsl:for-each select="CONTROLPRECIOS_DEMANDAS/DEMANDA">
			<xsl:variable name="DemandaID"><xsl:value-of select="CT_DEM_ID"/></xsl:variable>

			<tr id="DEM_{CT_DEM_ID}" style="border-bottom:1px solid #A7A8A9;">
				<td><xsl:value-of select="position()"/></td>
				<td><xsl:value-of select="CT_DEM_CODIGO"/></td>
				<td><xsl:value-of select="CT_DEM_FECHA"/></td>
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
				<td style="text-align:left;">&nbsp;
					<strong>
            <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/StockDemanda.xsql?SD_ID={CT_DEM_ID}','demanda de stock',100,80,0,-10)">
							<xsl:value-of select="CT_DEM_TITULO"/>
            </a>
          </strong>
				</td>
				<td style="text-align:left;">&nbsp;
					<xsl:choose>
					<!-- Texto largo => mostramos pop-up -->
					<xsl:when test="string-length(CT_DEM_DESCRIPCION) > 75">
						<a href="#" class="tooltip">
							<xsl:value-of select="substring(CT_DEM_DESCRIPCION,0,75)"/><xsl:text>...</xsl:text>
							<span class="classic"><xsl:value-of select="CT_DEM_DESCRIPCION"/></span>
						</a>
					</xsl:when>
					<!-- Texto corto => no hace falta pop-up -->
					<xsl:otherwise>
						<xsl:value-of select="CT_DEM_DESCRIPCION"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td style="text-align:left;"><xsl:value-of select="USUARIO"/></td>
				<td><xsl:value-of select="ESTADO"/></td>
				<td>
					<xsl:if test="$usuario = 'CDC'">
						<a href="javascript:BorrarDemandaStock('{CT_DEM_ID}');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>
					</xsl:if>
				</td>
			</tr>
		</xsl:for-each>
  </xsl:when>
	<xsl:otherwise>
			<tr><td colspan="11" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='stock_demanda_sin_resultados']/node()"/></strong></td></tr>
	</xsl:otherwise>
	</xsl:choose>
	</table>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
