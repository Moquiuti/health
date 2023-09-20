<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Listado/Buscador de roturas de stock
	Ultima revision: ET 31jul19 14:55
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:param name="usuario" select="@US_ID"/>

<xsl:template match="/RoturasStock">

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/RoturasStock/ROTURAS_STOCK/LANG"><xsl:value-of select="/RoturasStock/ROTURAS_STOCK/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<META Http-Equiv="Cache-Control" Content="no-cache" />

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='roturas_stock']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript">
		
		function Buscar()
		{
			SubmitForm(document.forms['Buscador']);
		}
		
		function EjecutarAccion(Accion, Parametro)
		{
			document.forms.Buscador.elements.ACCION.value=Accion;
			document.forms.Buscador.elements.PARAMETRO.value=Parametro;
			SubmitForm(document.forms['Buscador']);
		}
	</script>
</head>
<body>
<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/RoturasStock/ROTURAS_STOCK/LANG"><xsl:value-of select="/RoturasStock/ROTURAS_STOCK/LANG"/></xsl:when>
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
                            <xsl:when test="/RoturasStock/ROTURAS_STOCK/LANG"><xsl:value-of select="/RoturasStock/ROTURAS_STOCK/LANG"/></xsl:when>
                            <xsl:otherwise>spanish</xsl:otherwise>
                    </xsl:choose>
            </xsl:variable>
            <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
            <!--idioma fin-->

		<xsl:variable name="usuario">
		<xsl:choose>
			<xsl:when test="not(ROTURAS_STOCK/OBSERVADOR) and ROTURAS_STOCK/CDC">CDC</xsl:when>
			<xsl:otherwise>NORMAL</xsl:otherwise>
		</xsl:choose>
		</xsl:variable>

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='roturas_stock']/node()"/></span></p>
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='roturas_stock']/node()"/>&nbsp;&nbsp;
			&nbsp;&nbsp;
			<span class="CompletarTitulo">
                <xsl:if test="ROTURAS_STOCK/PERMITIR_CREAR">
				<a class="btnDestacado" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/RoturasStock/NuevaRoturaStock.xsql','Nueva rotura de stock',100,100,0,0);"> 
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/>
				</a>
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>
		<form name="Buscador" method="post" action="http://www.newco.dev.br/ProcesosCdC/RoturasStock/RoturasStock.xsql">
		<input name="ACCION" type="hidden" value=""/>
		<input name="PARAMETRO" type="hidden" value=""/>
		<table class="buscador">
			<!--<tr class="select" height="50px">-->
			<tr class="filtros" height="50px">
				<th class="uno">&nbsp;</th>
				<xsl:choose>
				<xsl:when test="ROTURAS_STOCK/MVM or ROTURAS_STOCK/ROL = 'VENDEDOR'">
					<th width="140px" style="text-align:left">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></label><br />
					<xsl:call-template name="desplegable"><xsl:with-param name="path" select="ROTURAS_STOCK/FIDCLIENTE/field"/></xsl:call-template>
					</th>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="FIDCLIENTE" value="-1" id="FIDCLIENTE"/>
				</xsl:otherwise>
				</xsl:choose>

				<xsl:choose>
				<xsl:when test="ROTURAS_STOCK/MVM or ROTURAS_STOCK/MVMB or ROTURAS_STOCK/ROL = 'COMPRADOR'">
					<th width="140px" style="text-align:left">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></label><br />
					<xsl:call-template name="desplegable"><xsl:with-param name="path" select="ROTURAS_STOCK/FIDPROVEEDOR/field"/></xsl:call-template>
					</th>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="FIDPROVEEDOR" value="-1" id="FIDPROVEEDOR"/>
				</xsl:otherwise>
				</xsl:choose>

				<th width="140px" style="text-align:left">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/></label><br />
					<input type="text" name="FTEXTO" size="20" id="FTEXTO">
						<xsl:attribute name="value"><xsl:value-of select="ROTURAS_STOCK/FTEXTO"/></xsl:attribute>
					</input>
				</th>

				<th width="140px" style="text-align:left">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></label><br />
					<xsl:call-template name="desplegable"><xsl:with-param name="path" select="ROTURAS_STOCK/FIDESTADO/field"/></xsl:call-template>
				</th>

				<th width="140px" style="text-align:left;">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/></label><br />
					<xsl:call-template name="desplegable"><xsl:with-param name="path" select="ROTURAS_STOCK/FIDTIPO/field"/></xsl:call-template>
				</th>

				<th width="140px" style="text-align:left">
					<a class="btnDestacado" href="javascript:Buscar();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
					</a>
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
				<th class="seis"><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
				<th class="seis"><xsl:copy-of select="document($doc)/translation/texts/item[@name='Fecha_final']/node()"/></th>
				<th class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
				<th class="seis"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></th>
				<th class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
				<th align="quince">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/></th>
				<th align="quince">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/></th>
				<th class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='alternativa']/node()"/></th>
				<th class="seis"><xsl:value-of select="document($doc)/translation/texts/item[@name='duracion']/node()"/></th>
				<th class="dos">&nbsp;</th>
			</tr>
		</thead>
        <xsl:choose>
		<xsl:when test="ROTURAS_STOCK/ROTURA_STOCK">
			<xsl:for-each select="ROTURAS_STOCK/ROTURA_STOCK">
				<tr id="PRO_{IDPRODUCTO}" style="border-bottom:1px solid #A7A8A9;">
					<xsl:choose>
					<xsl:when test="MODIFICADO_1HORA">
						<xsl:attribute name="class">fondoNaranja</xsl:attribute>
					</xsl:when>
					<xsl:when test="MODIFICADO_24HORAS">
						<xsl:attribute name="class">fondoAmarillo</xsl:attribute>
					</xsl:when>
					</xsl:choose>

					<td><xsl:value-of select="position()"/></td>
					<td><xsl:value-of select="FECHA"/></td>
					<td><xsl:value-of select="FECHAFINAL"/></td>
                    <td style="text-align:left;">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDCLIENTE}','DetalleEmpresa',100,80,0,0)">
							<xsl:value-of select="PROVEEDOR"/>
						</a>
					</td>
					<td style="text-align:left;">
							<xsl:value-of select="REFPROVEEDOR"/>
					</td>
					<td style="text-align:left;">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID={IDPRODUCTO}','DetalleProducto',100,80,0,0)">
							<xsl:value-of select="PRODUCTO"/>
                        </a>
					</td>
					<td style="text-align:left;">
							<xsl:value-of select="TIPO"/>
					</td>
					<td style="text-align:left;">
							&nbsp;<xsl:value-of select="COMENTARIOS"/>
					</td>
					<td style="text-align:left;">
							<xsl:value-of select="ALTERNATIVA"/>
					</td>
					<td><xsl:value-of select="DURACION"/></td>
					<td>
					<xsl:if test="../MVM and ../FILTROS/ESTADO='A'">
						<a href="javascript:EjecutarAccion('FINROTURA', '{IDPRODUCTO}');"><img src="http://www.newco.dev.br/images/2017/reload.png"/></a>
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
