<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Listado/Buscador de Modelos de Contrato
	Ultima revision: ET 26feb20 08:56
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:param name="usuario" select="@US_ID"/>

<xsl:template match="/ModelosContrato">

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/ModelosContrato/LANG"><xsl:value-of select="/ModelosContrato/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<META Http-Equiv="Cache-Control" Content="no-cache" />

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Modelos_contrato']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript">
		function BuscarModelos()
		{
			SubmitForm(document.forms['Buscador']);
		}
	</script>
</head>
<body>

<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/ModelosContrato/LANG"><xsl:value-of select="/ModelosContrato/LANG"/></xsl:when>
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
                            <xsl:when test="/ModelosContrato/LANG"><xsl:value-of select="/ModelosContrato/LANG"/></xsl:when>
                            <xsl:otherwise>spanish</xsl:otherwise>
                    </xsl:choose>
            </xsl:variable>
            <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
            <!--idioma fin-->

		<xsl:variable name="usuario">
		<xsl:choose>
			<xsl:when test="not(MODELOS/OBSERVADOR) and ModelosContrato/CDC">CDC</xsl:when>
			<xsl:otherwise>NORMAL</xsl:otherwise>
		</xsl:choose>
		</xsl:variable>

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Modelos_contrato']/node()"/></span></p>
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Modelos_contrato']/node()"/>&nbsp;&nbsp;
			&nbsp;&nbsp;
			<span class="CompletarTitulo" style="width:350px;">
                <xsl:if test="MODELOS/ROL='COMPRADOR'">
				<!--<a class="btnDestacado" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/Contratos/ModeloContrato.xsql','Nuevo modelo contrato',100,100,0,0);"> -->
				<a class="btnDestacado" href="http://www.newco.dev.br/ProcesosCdC/Contratos/ModeloContrato.xsql"> 
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
				</a>
				&nbsp;
				</xsl:if>
                <xsl:if test="MODELOS/ROL='COMPRADOR'">
				<a class="btnNormal" href="http://www.newco.dev.br/ProcesosCdC/Contratos/Contratos.xsql"> 
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Contratos']/node()"/>
				</a>
				&nbsp;
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>
	
		<form name="Buscador" method="post" action="ModelosContrato.xsql">
		<table class="buscador">
			<!--<tr class="select" height="50px">-->
			<tr class="filtros" height="50px">
				<th class="uno">&nbsp;</th>
				<!--
				<th width="80px" style="text-align:left">
                    <a href="javascript:Reset(document.forms['Buscador']);">
                        <xsl:choose>
                            <xsl:when test="/Contratos/LANG='spanish'"><img src="http://www.newco.dev.br/images/sinFiltros.gif" alt="Sin filtros" /></xsl:when>
                            <xsl:otherwise><img src="http://www.newco.dev.br/images/sinFiltros-BR.gif" alt="Não filtrada" /></xsl:otherwise>
                        </xsl:choose>
                    </a>
                </th>
				-->
				<xsl:choose>
				<xsl:when test="MODELOS/MVM or MODELOS/MVMB or MODELOS/ROL = 'VENDEDOR'">
					<th width="140px" style="text-align:left">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></label><br />
					<xsl:call-template name="desplegable"><xsl:with-param name="path" select="Contratos/FIDEMPRESA/field"/></xsl:call-template>
					</th>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="FIDEMPRESA" value="-1" id="FIDEMPRESA"/>
				</xsl:otherwise>
				</xsl:choose>

				<th width="140px" style="text-align:left">
				<xsl:choose>
				<xsl:when test="MODELOS/ROL = 'COMPRADOR' and MODELOS/CDC">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></label><br />
					<xsl:call-template name="desplegable">
                        <xsl:with-param name="path" select="MODELOS/FIDCENTRO/field"/>
                    </xsl:call-template>
				</xsl:when>
				<xsl:when test="MODELOS/ROL != 'VENDEDOR'">
					<input type="hidden" name="FIDCENTRO" value="-1" id="FIDCENTRO"/>
				</xsl:when>
				<xsl:otherwise>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></label><br />
					<xsl:call-template name="desplegable"><xsl:with-param name="path" select="MODELOS/FIDCENTRO/field"/></xsl:call-template>
				</xsl:otherwise>
				</xsl:choose>
				</th>

				<th width="140px" style="text-align:left">
				<xsl:choose>
				<xsl:when test="MODELOS/ROL = 'COMPRADOR' and MODELOS/CDC">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/></label><br />
					<xsl:call-template name="desplegable"><xsl:with-param name="path" select="MODELOS/FIDRESPONSABLE/field"/></xsl:call-template>
				</xsl:when>
				<xsl:when test="MODELOS/ROL != 'VENDEDOR'">
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
						<xsl:attribute name="value"><xsl:value-of select="MODELOS/FTEXTO"/></xsl:attribute>
					</input>
				</th>

				<th width="140px" style="text-align:left">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></label><br />
					<xsl:call-template name="desplegable"><xsl:with-param name="path" select="MODELOS/FESTADO/field"/></xsl:call-template>
				</th>

				<th width="140px" style="text-align:left">
                    <!--<div class="botonLargo">
					<strong>-->
						<a class="btnDestacado" href="javascript:BuscarModelos();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
						</a>
					<!--</strong>
					</div>-->
				</th>
				<th>&nbsp;</th>
			</tr>
		</table>
		</form>

		<div id="ContratoBorradoOK" style="display:none;background:#CEF6CE;padding:5px;width:400px;color:#7d7d7d;font-weight:bold;text-align:center;border:1px solid #01DF01;margin:10px auto;"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_contrato_OK']/node()"/></div>
		<div id="ContratoBorradoKO" style="display:none;background:#F8E0E6;padding:5px;width:400px;color:#7d7d7d;font-weight:bold;text-align:center;border:1px solid red;margin:10px auto;"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_contrato_KO']/node()"/></div>

		<!--<table class="grandeInicio">-->
		<table class="buscador">
		<thead>
			<tr class="subTituloTabla">
				<th class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
				<th class="diez"><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_abbr']/node()"/></th>
				<th class="seis"><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
				<th class="diez" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>
				<th class="diez" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_cliente']/node()"/></th>
				<th style="text-align:left;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></th>
				<!--<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/></th>-->
				<th style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/></th>
				<th class="seis"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
				<th class="dos">&nbsp;</th>
			</tr>
		</thead>
        <xsl:choose>
		<xsl:when test="MODELOS/MODELO">
			<xsl:for-each select="MODELOS/MODELO">
				<xsl:variable name="IDContrato"><xsl:value-of select="CON_MOD_ID"/></xsl:variable>
				<tr id="SOLIC_{CON_MOD_ID}" style="border-bottom:1px solid #A7A8A9;">
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
						<strong>
                        <a href="http://www.newco.dev.br/ProcesosCdC/Contratos/ModeloContrato.xsql?CON_MOD_ID={CON_MOD_ID}">
                            <xsl:value-of select="CON_MOD_CODIGO"/>
                        </a>
						</strong>
                    </td>
					<td><xsl:value-of select="CON_MOD_FECHAALTA"/></td>
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
                        <a href="http://www.newco.dev.br/ProcesosCdC/Contratos/ModeloContrato.xsql?CON_MOD_ID={CON_MOD_ID}">
							<xsl:value-of select="CON_MOD_NOMBRE"/>
                        </a>
                    	</strong>
					</td>
                    <td style="text-align:left;"><xsl:value-of select="USUARIO"/></td>
					<td  style="text-align:left;"><xsl:value-of select="ESTADO"/></td>
					<td>
					<xsl:if test="$usuario = 'CDC'">
						<a href="javascript:BorrarContrato('{CON_MOD_ID}');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>
					</xsl:if>
					</td>
				</tr>
			</xsl:for-each>
                </xsl:when>
		<xsl:otherwise>
			<tr><td colspan="11" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='busqueda_sin_resultados']/node()"/></strong></td></tr>
		</xsl:otherwise>
		</xsl:choose>
		</table>
	</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
