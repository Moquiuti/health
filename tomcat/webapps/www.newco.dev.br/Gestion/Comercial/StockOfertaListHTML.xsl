<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:param name="usuario" select="@US_ID"/>

<xsl:template match="/StockOfertaList">

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

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='ofertas_stock']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/StockOferta180416.js"></script>
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
		<xsl:when test="not(CONTROLPRECIOS_OFERTAS/OBSERVADOR) and CONTROLPRECIOS_OFERTAS/CDC">CDC</xsl:when>
		<xsl:otherwise>NORMAL</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<!--	Titulo de la p�gina		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='ofertas_stock']/node()"/></span></p>
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='ofertas_stock']/node()"/>&nbsp;&nbsp;
			&nbsp;&nbsp;
			<span class="CompletarTitulo">
          		<xsl:if test="$usuario = 'CDC'">
				<a class="btnDestacado" href="javascript:NuevoStockOferta();"> 
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/>
				</a>
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>



	<!--
	<h1 class="titlePage" style="float:left;width:60%;padding-left:20%;"><xsl:value-of select="document($doc)/translation/texts/item[@name='ofertas_stock']/node()"/></h1>
        
        <h1 class="titlePage" style="float:left;width:20%;">
            <xsl:if test="$usuario = 'CDC'">
				<a href="javascript:NuevoStockOferta();">
                    <div class="botonNara">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/>
                    </div>
				</a>
            </xsl:if>
        </h1>
	-->
	<form name="Buscador" method="post" action="StockOfertaList.xsql">
	<table class="buscador">
		<!--<tr class="select" height="50px">-->
		<tr class="filtros" height="50px">
			<th width="140px" style="align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:</label><br />
				<xsl:call-template name="desplegable"><xsl:with-param name="path" select="CONTROLPRECIOS_OFERTAS/FIDEMPRESA/field"/></xsl:call-template>
			</th>
            <input type="hidden" name="FIDCENTRO" value="-1" id="FIDCENTRO"/>
			<input type="hidden" name="FIDRESPONSABLE" value="-1" id="FIDRESPONSABLE"/>
			<th width="140px" style="align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/>:</label><br />
				<input type="text" name="FTEXTO" size="30" id="FTEXTO">
					<xsl:attribute name="value"><xsl:value-of select="CONTROLPRECIOS_OFERTAS/FTEXTO"/></xsl:attribute>
				</input>
			</th>
			<th width="140px" style="align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>:</label><br />
				<xsl:call-template name="desplegable"><xsl:with-param name="path" select="CONTROLPRECIOS_OFERTAS/FESTADO/field"/></xsl:call-template>
			</th>
			<th width="140px" style="align:left;">
				<!--<br />
				<div class="botonLargo">
				<strong>-->
					<a class="btnDestacado" href="javascript:BuscarStockOfertas(document.forms['Buscador']);">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
					</a>
				<!--</strong>
				</div>-->
			</th>
			<th>&nbsp;</th>
		</tr>
	</table>
	</form>

	<div id="StockOfertaBorradaOK" style="display:none;background:#CEF6CE;padding:5px;width:400px;color:#333;text-align:center;border:1px solid #01DF01;margin:10px auto;"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_stock_oferta_OK']/node()"/></div>
	<div id="StockOfertaBorradaKO" style="display:none;background:#F8E0E6;padding:5px;width:400px;color:#333;text-align:center;border:1px solid red;margin:10px auto;"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_stock_oferta_KO']/node()"/></div>

	<!--<table class="grandeInicio">-->
	<table class="buscador">
	<thead>
		<tr class="subTituloTabla">
			<th class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
			<th class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_abbr']/node()"/></th>
			<th class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
			<th class="dies" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
			<th class="dies" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/></th>
			<th class="uno" align="left">&nbsp;</th>
			<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/></th>
			<th class="seis" align="right"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>&nbsp;</th>
			<th class="cinco" align="right"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
			<th class="cinco">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_pedida']/node()"/></th>
			<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/></th>
			<th class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
			<th class="dos">&nbsp;</th>
		</tr>
	</thead>

  <xsl:choose>
	<xsl:when test="CONTROLPRECIOS_OFERTAS/OFERTA">
		<xsl:for-each select="CONTROLPRECIOS_OFERTAS/OFERTA">
			<xsl:variable name="DemandaID"><xsl:value-of select="CT_OFE_ID"/></xsl:variable>

			<tr id="OFE_{CT_OFE_ID}" style="border-bottom:1px solid #A7A8A9;">
                <xsl:choose>
					<xsl:when test="MODIFICADO_1HORA">
						<xsl:attribute name="class">fondoNaranja</xsl:attribute>
					</xsl:when>
					<xsl:when test="MODIFICADO_24HORAS">
						<xsl:attribute name="class">fondoAmarillo</xsl:attribute>
					</xsl:when>
				</xsl:choose>
				<td><xsl:value-of select="position()"/></td>
				<td><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/StockOferta.xsql?SO_ID={CT_OFE_ID}','oferta de stock',100,80,0,-10)">
                        <xsl:value-of select="CT_OFE_CODIGO"/>
                    </a>
                </td>
				<td><xsl:value-of select="CT_OFE_FECHA"/></td>
                <td style="text-align:left;">
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDPROVEEDOR}','DetalleEmpresa',100,80,0,0)">
						<xsl:value-of select="PROVEEDOR"/>
					</a>
				</td>
                <td style="text-align:left;"><xsl:value-of select="USUARIO"/></td>
                <td style="text-align:left;">
                    <xsl:choose>
                        <xsl:when test="CT_OFE_IDTIPO = 'LIQ'"><img src="http://www.newco.dev.br/images/iconCajas.gif" alt="Liquidaciones de stock"/></xsl:when>
                        <xsl:when test="CT_OFE_IDTIPO = 'SEG'"><img src="http://www.newco.dev.br/images/iconSegundaMano.gif" alt="Segunda mano"/></xsl:when>
                    </xsl:choose>
                </td>
				<td style="text-align:left;">
					<strong>
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/StockOferta.xsql?SO_ID={CT_OFE_ID}','oferta de stock',100,80,0,-10)">
					<xsl:value-of select="CT_OFE_TITULO"/>
					</a>
					</strong>
				</td>
                <td style="text-align:right;"><xsl:value-of select="CT_OFE_PRECIO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/></td>
                <td style="text-align:right;"><xsl:value-of select="CT_OFE_CANTIDAD"/></td>
                <td style="text-align:right;"><xsl:value-of select="CT_OFE_CANTIDADPEDIDA"/></td>
                <td><xsl:value-of select="CT_OFE_NUMPEDIDOS"/></td>
				<td><xsl:value-of select="ESTADO"/></td>
				<td>
					<xsl:if test="$usuario = 'CDC'">
						<a href="javascript:BorrarOfertaStock('{CT_OFE_ID}');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>
					</xsl:if>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:when>
	<xsl:otherwise>
			<tr><td colspan="11" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='stock_oferta_sin_resultados']/node()"/></strong></td></tr>
	</xsl:otherwise>
	</xsl:choose>
	</table>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
