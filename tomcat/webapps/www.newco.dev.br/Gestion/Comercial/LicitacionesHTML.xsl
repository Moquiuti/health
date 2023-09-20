<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Listado/Buscador de licitaciones
	Ultima revision: ET 15dic21 17:45 Licitaciones_151221.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:param name="usuario" select="@US_ID"/>

<xsl:template match="/Licitaciones">

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

	<meta http-equiv="Cache-Control" content="no-cache"/>

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/Licitaciones_151221.js"></script>

	<!-- DC - 07sep15 - Comentado para actualizacion sobre novedades 
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/gantt.140915.js"></script>-->

	<script type="text/javascript">
        var nuevaLici = 'N';
		var errorNuevoEstadoLicitacion = '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_nuevo_estado_licitacion']/node()"/>';
		var strMotivoBorrar ='<xsl:value-of select="document($doc)/translation/texts/item[@name='aviso_informar_motivo_suspender']/node()"/>';

		var arrLicitaciones	= new Array();
		<xsl:for-each select="LICITACIONES/LICITACION">
			var items		= [];
			items['Linea']		= '<xsl:value-of select="LINEA"/>';
			items['Titulo']		= "<xsl:value-of select="LIC_TITULO_JS"/>";
			items['FechaAlta']	= '<xsl:value-of select="LIC_FECHAALTA"/>';
			items['FechaMod']	= '<xsl:value-of select="LIC_FECHAMODIFICACION"/>';
			items['FechaIni']	= '<xsl:value-of select="FECHAINICIO"/>';
			items['FechaFin']	= '<xsl:value-of select="FECHAFINAL"/>';
			items['IDEstado']	= '<xsl:value-of select="IDESTADO"/>';

			arrLicitaciones.push(items);
		</xsl:for-each>
	</script>
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
	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones']/node()"/></span></p>
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones']/node()"/><xsl:if test="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/BUSQUEDASESPECIALES != ''">:&nbsp;<xsl:variable name="nombreestado">LI_<xsl:value-of select="/WorkFlowPendientes/INICIO/PEDIDOSPROBLEMATICOS/BUSQUEDASESPECIALES"/></xsl:variable><xsl:value-of select="document($doc)/translation/texts/item[@name=$nombreestado]/node()"/></xsl:if>&nbsp;&nbsp;&nbsp;&nbsp;
			<span class="CompletarTitulo">
				<!--	PENDIENTE
				<input type="checkbox" name="GRAFICO" id="GRAFICO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ver_grafico']/node()"/>&nbsp;&nbsp;
				-->
				<xsl:value-of select="LICITACIONES/TOTAL"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones']/node()"/>&nbsp;&nbsp;
				<xsl:if test="LICITACIONES/CREARLICITACIONES">
				<a class="btnNormal" href="javascript:NuevaLicitacion();"> 
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/>
				</a>
				&nbsp;
				</xsl:if>
				<xsl:if test="LICITACIONES/COMPRADOR and LICITACIONES/IDPAIS != 55">
				<a class="btnNormal" href="http://www.newco.dev.br/ProcesosCdC/Convocatorias/Convocatorias.xsql">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatorias']/node()"/>
				</a>
				&nbsp;
				</xsl:if>
				<a class="btnNormal" href="http://www.newco.dev.br/Gestion/Comercial/LicAnalisisLineas.xsql">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Lineas']/node()"/>
				</a>
				&nbsp;
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>
	<div class="divLeft">

		<xsl:choose>
		<xsl:when test="LICITACIONES/VENDEDOR"><xsl:call-template name="Licitaciones_Proveedor"/></xsl:when>
		<xsl:otherwise><xsl:call-template name="Licitaciones_Cliente"/></xsl:otherwise>
		</xsl:choose>

		<table style="width:100%;display:none;" id="tblGantt">
			<thead></thead>
			<tbody></tbody>
			<tfoot></tfoot>
		</table>

	</div>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>

<!-- Template para los clientes -->
<xsl:template name="Licitaciones_Cliente">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/Licitaciones/LANG"><xsl:value-of select="/Licitaciones/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<form name="Buscador" method="post" action="Licitaciones.xsql">
    <input type="hidden" name="lici" id="lici" value="LISTA"/>
	<input type="hidden" name="ORDEN" value="{/Licitaciones/LICITACIONES/ORDEN}"/>
	<input type="hidden" name="SENTIDO" value="{/Licitaciones/LICITACIONES/SENTIDO}"/>
    <input type="hidden" name="BUSQUEDASESPECIALES" id="BUSQUEDASESPECIALES" value="{/Licitaciones/LICITACIONES/BUSQUEDASESPECIALES}"/>
	<table class="buscador" border="0">
	<tr class="filtrosgrandes">
		<th class="uno">&nbsp;</th>
		<!--	Convocatoria		-->
		<xsl:choose>
		<xsl:when test="/Licitaciones/LICITACIONES/FIDCONVOCATORIA">
			<th width="140px" style="text-align:left">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatoria']/node()"/></label><br />
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/Licitaciones/LICITACIONES/FIDCONVOCATORIA/field"/>
				<xsl:with-param name="style">width:130px;</xsl:with-param>
			</xsl:call-template>
			</th>
		</xsl:when>
		<xsl:otherwise>
			<input type="hidden" name="FIDCONVOCATORIA" value="-1"/>
		</xsl:otherwise>
		</xsl:choose>
		<!--	Area Geografica		-->
		<xsl:choose>
		<xsl:when test="/Licitaciones/LICITACIONES/FIDAREAGEOGRAFICA/field">
			<th width="180px" style="text-align:left">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Area_geografica']/node()"/></label><br />
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/Licitaciones/LICITACIONES/FIDAREAGEOGRAFICA/field"/>
				<xsl:with-param name="style">width:170px;</xsl:with-param>
			</xsl:call-template>
			</th>
		</xsl:when>
		<xsl:otherwise>
			<input type="hidden" name="FIDAREAGEOGRAFICA" value="-1"/>
		</xsl:otherwise>
		</xsl:choose>
		<!--	Categoria		-->
		<xsl:choose>
		<xsl:when test="/Licitaciones/LICITACIONES/FIDCATEGORIA/field">
			<th width="180px" style="text-align:left">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='categoria']/node()"/></label><br />
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/Licitaciones/LICITACIONES/FIDCATEGORIA/field"/>
				<xsl:with-param name="style">width:170px;</xsl:with-param>
			</xsl:call-template>
			</th>
		</xsl:when>
		<xsl:otherwise>
			<input type="hidden" name="FIDCATEGORIA" value="-1"/>
		</xsl:otherwise>
		</xsl:choose>
		<!--	Cliente		-->
		<xsl:choose>
		<xsl:when test="/Licitaciones/LICITACIONES/MVM or /Licitaciones/LICITACIONES/MVMB">
			<th width="210px" style="text-align:left">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></label><br />
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/Licitaciones/LICITACIONES/FIDEMPRESA/field"/>
				<xsl:with-param name="style">width:200px;</xsl:with-param>
			</xsl:call-template>
			</th>
		</xsl:when>
		<xsl:otherwise>
			<input type="hidden" name="FIDEMPRESA" value="-1"/>
		</xsl:otherwise>
		</xsl:choose>
		<!--	Centro		-->
		<xsl:choose>
		<xsl:when test="/Licitaciones/LICITACIONES/INCLUIR_CENTRO_PEDIDO">
			<th width="180px" style="text-align:left">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></label><br />
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/Licitaciones/LICITACIONES/FIDCENTROPEDIDO/field"/>
				<xsl:with-param name="style">width:170px;</xsl:with-param>
			</xsl:call-template>
			</th>
		</xsl:when>
		<xsl:otherwise>
			<input type="hidden" name="FIDCENTROPEDIDO" value="-1"/>
		</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
		<xsl:when test="/Licitaciones/LICITACIONES/INCLUIR_AUTOR">
			<xsl:choose>
			<xsl:when test="/Licitaciones/LICITACIONES/MOSTRAR_USUARIO_GESTOR">
				<th width="180px" style="text-align:left">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='creador']/node()"/></label><br />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/Licitaciones/LICITACIONES/FIDAUTOR/field"/>
					<xsl:with-param name="style">width:170px;</xsl:with-param>
				</xsl:call-template>
				</th>
				<th width="180px" style="text-align:left">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='gestor']/node()"/></label><br />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/Licitaciones/LICITACIONES/FIDGESTOR/field"/>
					<xsl:with-param name="style">width:170px;</xsl:with-param>
				</xsl:call-template>
				</th>
			</xsl:when>
			<xsl:otherwise>
				<th width="180px" style="text-align:left">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/></label><br />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/Licitaciones/LICITACIONES/FIDRESPONSABLE/field"/>
					<xsl:with-param name="style">width:170px;</xsl:with-param>
				</xsl:call-template>
				</th>
			</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise>
			<input type="hidden" name="FIDRESPONSABLE" value="-1"/>
		</xsl:otherwise>
		</xsl:choose>
		<!--<th>
			&nbsp;-->
			<!--	5jul16 quitamos este desplegable para simplificar el buscador
			<xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/><br />
			<xsl:call-template name="desplegable"><xsl:with-param name="path" select="/Licitaciones/LICITACIONES/FIDRESPONSABLE/field"/></xsl:call-template>
			-->
		<!--</th>-->
		<!--	El filtro de proveedores ralentiza demasiado
		<th width="140px" align="left">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></label><br />
			<xsl:call-template name="desplegable"><xsl:with-param name="path" select="/Licitaciones/LICITACIONES/FPROVEEDOR/field"/></xsl:call-template>
		</th>
		<th width="140px" style="text-align:left">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor_adjudicado']/node()"/></label><br />
			<xsl:call-template name="desplegable"><xsl:with-param name="path" select="/Licitaciones/LICITACIONES/FPROVEEDORSEL/field"/></xsl:call-template>
		</th>-->
		<th width="310px" style="text-align:left">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>/<xsl:value-of select="document($doc)/translation/texts/item[@name='nif']/node()"/>/<xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion']/node()"/></label><br />
			<input type="text" name="FTEXTO" size="30" style="width:300px;">
				<xsl:attribute name="value"><xsl:value-of select="/Licitaciones/LICITACIONES/FTEXTO"/></xsl:attribute>
			</input>
		</th>
		<th width="120px" style="text-align:left">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></label><br />
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/Licitaciones/LICITACIONES/FESTADO/field"/>
				<xsl:with-param name="style">width:100px;</xsl:with-param>
			</xsl:call-template>
		</th>
		<th width="120px" style="text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo']/node()"/></label><br />
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/Licitaciones/LICITACIONES/FPLAZO/field"/>
				<xsl:with-param name="style">width:100px;</xsl:with-param>
			</xsl:call-template>
		</th>
		<th width="140px" style="text-align:left">
			<!--<div class="botonLargo">
			<strong>-->
				<!--<a class="btnDestacado" href="javascript:BuscarLicitaciones(document.forms['Buscador']);">-->
				<a class="btnDestacado" href="javascript:Enviar();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
				</a>
			<!--</strong>
			</div>-->
		</th>
		<th>&nbsp;</th>
	</tr>
	</table>
</form>

<table class="buscador" id="tblData"><!--class="grandeInicio"-->
<thead>
	<tr class="subTituloTabla">
		<th class="zerouno"></th><!-- Numero de linea -->
		<th class="zerouno">&nbsp;</th><!-- Iconos bolas de colores -->
        <xsl:if test="/Licitaciones/LICITACIONES/INCLUIR_CODIGO_SOLICITUD">
        	<th class="dos" style="text-align:left"><a href="javascript:Orden('CODSOLICITUD');"><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_solicitud']/node()"/></a></th>
        </xsl:if>
		<th class="dos" style="text-align:left">
			&nbsp;<a href="javascript:Orden('COD');"><xsl:value-of select="document($doc)/translation/texts/item[@name='codigo']/node()"/></a>
		</th><!-- Codigo licitacion -->
        <xsl:if test="/Licitaciones/LICITACIONES/MVM or /Licitaciones/LICITACIONES/MVMB">
        	<th style="text-align:left"><a href="javascript:Orden('CLIENTE');"><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></a></th>
        </xsl:if>
		<xsl:if test="/Licitaciones/LICITACIONES/INCLUIR_CENTRO_PEDIDO">
			<th style="text-align:left">
				<a href="javascript:Orden('CENTROPEDIDO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Centro']/node()"/></a>
			</th>
			<xsl:if test="/Licitaciones/LICITACIONES/FIDAREAGEOGRAFICA/field">
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='Area_geografica']/node()"/></th>
			</xsl:if>
        </xsl:if>
        <xsl:if test="/Licitaciones/LICITACIONES/INCLUIR_AUTOR or /Licitaciones/LICITACIONES/MOSTRAR_USUARIO_GESTOR">
			<xsl:choose>
   		    <xsl:when test="/Licitaciones/LICITACIONES/MOSTRAR_USUARIO_GESTOR">
				<th class="diez" style="text-align:left">&nbsp;<a href="javascript:Orden('CREADOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='creador']/node()"/></a></th>
				<th class="diez" style="text-align:left">&nbsp;<a href="javascript:Orden('GESTOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='gestor']/node()"/></a></th>
			</xsl:when>
			<xsl:otherwise>
				<th class="diez" style="text-align:left">&nbsp;<a href="javascript:Orden('AUTOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/></a></th>
			</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
        <xsl:if test="not (/Licitaciones/LICITACIONES/OCULTAR_TITULO)">
			<th style="text-align:left">&nbsp;<a href="javascript:Orden('TITULO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/></a></th>
		</xsl:if>
		<th class="seis" style="text-align:left">&nbsp;<a href="javascript:Orden('ESTADO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></a></th>
		<xsl:if test="/Licitaciones/LICITACIONES/MULTICENTROS">
			<th class="tres" style="text-align:left"><a href="javascript:Orden('NUMCEN');"><xsl:value-of select="document($doc)/translation/texts/item[@name='num_centros']/node()"/></a></th>
        </xsl:if>
		<th class="cinco" style="text-align:left">&nbsp;<a href="javascript:Orden('NUMPROD');"><xsl:value-of select="document($doc)/translation/texts/item[@name='num_productos']/node()"/></a></th>
		<th class="cinco" style="text-align:left">&nbsp;<a href="javascript:Orden('NUMPROV');"><xsl:value-of select="document($doc)/translation/texts/item[@name='num_proveedores']/node()"/></a></th>
		<th class="dos">&nbsp;<a href="javascript:Orden('PENDPUBLICAR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='prov_pend_pub']/node()"/></a></th>
		<xsl:if test="/Licitaciones/LICITACIONES/HAY_LICITACIONES_SPOT">
			<th class="cuatro" style="text-align:left">&nbsp;<a href="javascript:Orden('PEDPENDIENTES');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ped_pend']/node()"/></a></th>
			<th class="cuatro" style="text-align:left">&nbsp;<a href="javascript:Orden('PEDENVIADOS');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ped_env']/node()"/></a></th>
        </xsl:if>
		<th style="width:115px;text-align:left">&nbsp;<a href="javascript:Orden('FECHALIC');"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_alta_abbr']/node()"/></a></th>
		<xsl:if test="/Licitaciones/LICITACIONES/MOSTRAR_FECHA_MODIFICACION">
			<th style="width:115px;text-align:left">&nbsp;<a href="javascript:Orden('FECHAMOD');"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_modificacion']/node()"/></a></th>
        </xsl:if>
		<th style="width:115px;text-align:left">&nbsp;<a href="javascript:Orden('FECHADEC');"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision_abbr']/node()"/></a></th>
		<xsl:if test="/Licitaciones/LICITACIONES/IDPAIS = '34'"><!--	para Brasil no mostramos la columna de consumo 	-->
		<th class="cinco" style="text-align:left">
			<a href="javascript:Orden('CONSUMO');">
			<xsl:choose>
			<xsl:when test="not(/Licitaciones/LICITACIONES/MOSTRAR_PRECIO_IVA)">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_obj_sIVA_2line']/node()"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_obj_cIVA_2line']/node()"/>
			</xsl:otherwise>
			</xsl:choose>
			</a>
		</th>
		</xsl:if>
		<th class="tres" style="text-align:left">&nbsp;<a href="javascript:Orden('PORCNEG');"><xsl:value-of select="document($doc)/translation/texts/item[@name='porcentage_negociado']/node()"/></a></th>
		<th class="tres" style="text-align:left">&nbsp;<a href="javascript:Orden('PORCAHO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='porcentage_ahorro']/node()"/></a></th>
		<!--4oct16	<th class="cinco" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='prov_adj']/node()"/></th>-->
		<th style="width:90px;text-align:left">&nbsp;</th>
	</tr>
</thead>
<xsl:choose>
<xsl:when test="/Licitaciones/LICITACIONES/LICITACION">
	<xsl:for-each select="/Licitaciones/LICITACIONES/LICITACION">
		<xsl:variable name="LicID"><xsl:value-of select="ID"/></xsl:variable>
		<tr style="border-bottom:1px solid #A7A8A9;">
			<xsl:choose>
			<xsl:when test="IDESTADO='CONT' and LIC_PEDIDOSPENDIENTES>0">
				<xsl:attribute name="class">conhover fondoRojo</xsl:attribute>
			</xsl:when>
			<xsl:when test="MODIFICADO_1HORA">
				<xsl:attribute name="class">conhover fondoNaranja</xsl:attribute>
			</xsl:when>
			<xsl:when test="MODIFICADO_24HORAS">
				<xsl:attribute name="class">conhover fondoAmarillo</xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="class">conhover</xsl:attribute>
			</xsl:otherwise>
			</xsl:choose>

			<td style="text-align:left;"><xsl:value-of select="LINEA"/></td>
			<td style="text-align:left;">
				<xsl:choose>
				<!--
				<xsl:when test="MODIFICADA_MENOS24HORAS">
					<img src="http://www.newco.dev.br/images/bolaVerde.gif"/>
				</xsl:when>
				-->
				<xsl:when test="RETRASADA">
					<img src="http://www.newco.dev.br/images/bolaRoja.gif"/>
				</xsl:when>
				<xsl:when test="ADJUDICADA_MENOS24HORAS">
					<img src="http://www.newco.dev.br/images/bolaVerde.gif"/>
				</xsl:when>
				<xsl:when test="CADUCA30DIAS">
					<img src="http://www.newco.dev.br/images/bolaAmbar.gif"/>
				</xsl:when>
				</xsl:choose>
			</td>
        	<xsl:if test="/Licitaciones/LICITACIONES/INCLUIR_CODIGO_SOLICITUD">
				<td style="text-align:left;">	
					&nbsp;<strong><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/MantLicitacion.xsql?LIC_ID={$LicID}','Licitacion',100,100,0,0)" title="{LIC_TITULO}"><xsl:value-of select="LIC_CODIGOSOLICITUD"/></a></strong>
				</td>
        	</xsl:if>
			<td style="text-align:left;">
				&nbsp;<strong><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/MantLicitacion.xsql?LIC_ID={$LicID}','Licitacion',100,100,0,0)" title="{LIC_TITULO}"><xsl:value-of select="LIC_CODIGO"/></a></strong>
			</td>
			<xsl:if test="/Licitaciones/LICITACIONES/MVM">
    			<td style="text-align:left;">
					&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDEMPRESA}&amp;VENTANA=NUEVA','Cliente',100,80,0,-20);"><xsl:value-of select="EMPRESA"/></a>
				</td>
			</xsl:if>
			<xsl:if test="/Licitaciones/LICITACIONES/INCLUIR_CENTRO_PEDIDO">
				<td style="text-align:left;">
        			&nbsp;
					<xsl:if test="/Licitaciones/LICITACIONES/OCULTAR_TITULO">
						<img src="http://www.newco.dev.br/images/2017/info.png"><xsl:attribute name="title"><xsl:value-of select="LIC_TITULO"/></xsl:attribute></img>
        			</xsl:if>
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={CENTROPEDIDO/ID}','centro',100,80,0,-20);" class="noDecor"><xsl:value-of select="CENTROPEDIDO/NOMBRE"/></a>
				</td>
				<xsl:if test="/Licitaciones/LICITACIONES/FIDAREAGEOGRAFICA/field">
           			<td>&nbsp;<xsl:value-of select="CENTROPEDIDO/AREAGEOGRAFICA"/></td>
				</xsl:if>
        	</xsl:if>
        	<xsl:if test="/Licitaciones/LICITACIONES/INCLUIR_AUTOR or /Licitaciones/LICITACIONES/MOSTRAR_USUARIO_GESTOR">
				<xsl:choose>
				<xsl:when test="/Licitaciones/LICITACIONES/MOSTRAR_USUARIO_GESTOR">
					<td style="text-align:left">&nbsp;
    					<xsl:choose>
						<xsl:when test="USUARIOCREADOR">
							<xsl:value-of select="USUARIOCREADOR"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="RESPONSABLE"/>
						</xsl:otherwise>
						</xsl:choose>
					</td>
					<td style="text-align:left">&nbsp;<xsl:value-of select="USUARIOGESTOR"/></td>
				</xsl:when>
				<xsl:otherwise>
					<td style="text-align:left">&nbsp;<xsl:value-of select="RESPONSABLE"/></td>
				</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
        	<xsl:if test="not (/Licitaciones/LICITACIONES/OCULTAR_TITULO)">
				<td style="text-align:left;">
					<xsl:if test="LIC_URGENTE = 'S'"><img src="http://www.newco.dev.br/images/2017/warning-red.png" title="{document($doc)/translation/texts/item[@name='urgente']/node()}"/>&nbsp;</xsl:if>
					<strong>
					<xsl:if test="/Licitaciones/LICITACIONES/MVM">
						<img src="http://www.newco.dev.br/images/2017/info.png">
						<xsl:attribute name="title">
    						<xsl:choose>
							<xsl:when test="/Licitaciones/LICITACIONES/IDPAIS=55">
								<xsl:value-of select="SELECCIONPRINCIPAL"/>.&nbsp;<xsl:value-of select="RESTOSELECCIONES"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="CATEGORIAPRINCIPAL"/>.&nbsp;<xsl:value-of select="RESTOCATEGORIAS"/>
							</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
						</img>&nbsp;
					</xsl:if>
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/MantLicitacion.xsql?LIC_ID={$LicID}','Licitacion',100,100,0,0)" title="{LIC_TITULO}">
    				<xsl:choose>
					<xsl:when test="string-length(LIC_TITULO) > 50">
						<xsl:value-of select="substring(LIC_TITULO, 1, 50)"/>...
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="LIC_TITULO"/>
					</xsl:otherwise>
					</xsl:choose>
					</a>
				</strong>
				</td>
        	</xsl:if>
			<td style="text-align:left;">
				<xsl:if test="LIC_CONTINUA='S' and (IDESTADO='EST' or IDESTADO='CURS' or IDESTADO='COMP' or IDESTADO='INF')">
				&nbsp;<img src="http://www.newco.dev.br/images/2017/reload.png"/>
				</xsl:if>
        		<xsl:if test="(IDESTADO!='SUS' and IDESTADO!='B') and (LIC_SITUACION!='' or INFORMADA_CONTINUA)">
					&nbsp;<img src="http://www.newco.dev.br/images/2017/info.png">
						<xsl:attribute name="title">
						<xsl:if test="INFORMADA_CONTINUA"><xsl:value-of select="document($doc)/translation/texts/item[@name='abierta_para_cambios_hasta_vencimiento']/node()"/>&amp;#13;</xsl:if>
						<xsl:value-of select="LIC_SITUACION"/></xsl:attribute>
					</img>
        		</xsl:if>
        		<xsl:if test="(IDESTADO='SUS' or IDESTADO='B') and MOTIVOSUSPENDER!=''">
					&nbsp;<img src="http://www.newco.dev.br/images/2017/info.png"><xsl:attribute name="title"><xsl:value-of select="MOTIVOSUSPENDER"/></xsl:attribute></img>
        		</xsl:if>
				&nbsp;<strong><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/MantLicitacion.xsql?LIC_ID={$LicID}','Licitacion',100,100,0,0)"><xsl:value-of select="ESTADO"/></a></strong>
			</td>
			<xsl:if test="/Licitaciones/LICITACIONES/MULTICENTROS">
				<td>
    				<xsl:choose>
					<xsl:when test="LIC_NUMEROCENTROS>0">
						<xsl:value-of select="LIC_NUMEROCENTROS"/>
					</xsl:when>
					<xsl:otherwise>
						.
					</xsl:otherwise>
					</xsl:choose>
				</td>
			</xsl:if>
			<td style="text-align:left">
    			&nbsp;<xsl:choose>
				<xsl:when test="PRODUCTOSADJUDICADOS>0"><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/licOfertasSeleccionadas.xsql?LIC_ID={$LicID}','Vencedores',100,80,0,-20);"><xsl:value-of select="PRODUCTOSADJUDICADOS"/></a>				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
				/&nbsp;<xsl:value-of select="PRODUCTOSCONOFERTA"/>&nbsp;/
    			<xsl:choose>
				<xsl:when test="LIC_PROD_ID!=''"><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={LIC_PROD_ID}&amp;LIC_ID={$LicID}','FichaProducto',100,80,0,-20);"><xsl:value-of select="LIC_NUMEROLINEAS"/></a>				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</td>
			<td style="text-align:left">&nbsp;<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/licOfertasSeleccionadas.xsql?LIC_ID={$LicID}','Vencedores',100,80,0,-20);"><xsl:value-of select="LIC_PROVEEDORESADJUDICADOS"/></a>&nbsp;/&nbsp;<xsl:value-of select="LIC_NUMEROPROVEEDORESINF"/>&nbsp;/&nbsp;<xsl:value-of select="LIC_NUMEROPROVEEDORES"/></td>
			<td><xsl:value-of select="LIC_PROVEEDORESPENDPUBLICAR"/>&nbsp;</td>
			<xsl:if test="/Licitaciones/LICITACIONES/HAY_LICITACIONES_SPOT">
				<td><xsl:if test="LIC_PEDIDOSPENDIENTES>0"><xsl:attribute name="style">font-weight:bold;</xsl:attribute></xsl:if><xsl:value-of select="LIC_PEDIDOSPENDIENTES"/></td>
				<td>
					<xsl:choose>
					<xsl:when test="LIC_PEDIDOSENVIADOS>0">
						<a href="javascript:VerPedidos({ID});"><xsl:value-of select="LIC_PEDIDOSENVIADOS"/></a>
					</xsl:when>
					<xsl:otherwise>
						0
					</xsl:otherwise>
					</xsl:choose>
				</td>
        	</xsl:if>
			<td style="text-align:left">&nbsp;<xsl:value-of select="LIC_FECHAALTA"/></td>
			<xsl:if test="/Licitaciones/LICITACIONES/MOSTRAR_FECHA_MODIFICACION"><td style="text-align:left">&nbsp;<xsl:value-of select="LIC_FECHAMODIFICACION"/></td></xsl:if>
			<td style="text-align:left">&nbsp;<xsl:value-of select="LIC_FECHADECISIONPREVISTA"/></td>
			<xsl:if test="/Licitaciones/LICITACIONES/IDPAIS = 34"><!--	para Brasil no mostramos la columna de consumo 	-->
			<td>
				<xsl:choose>
				<xsl:when test="not(/Licitaciones/LICITACIONES/MOSTRAR_PRECIO_IVA)">
					<xsl:value-of select="LIC_CONSUMO"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="LIC_CONSUMOIVA"/>
				</xsl:otherwise>
				</xsl:choose>
			</td>
			</xsl:if>
			<td><xsl:value-of select="CONSUMO"/></td>
			<td><xsl:value-of select="AHORRO"/></td>
			<td>
				<xsl:if test="AUTOR">
					<xsl:choose>
					<xsl:when test="IDESTADO = 'SUS'">
						<!--<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="/Licitaciones/LICITACIONES/FMOTIVOBORRAR/field"/>
							<xsl:with-param name="nombre">FMOTIVOBORRAR_<xsl:value-of select="ID"/></xsl:with-param>
							<xsl:with-param name="id">FMOTIVOBORRAR_<xsl:value-of select="ID"/></xsl:with-param>
							<xsl:with-param name="style">display:none;</xsl:with-param>
							<xsl:with-param name="defecto"><xsl:value-of select="LIC_IDMOTIVOSUSPENDER"/></xsl:with-param>
						</xsl:call-template>-->
						<a href="javascript:CambiarEstadoLicitacion({ID},'NULL');">
							<img src="http://www.newco.dev.br/images/2017/reload.png">
								<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='recuperar']/node()"/></xsl:attribute>
								<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='recuperar']/node()"/></xsl:attribute>
							</img>
						</a>
						<a href="javascript:CambiarEstadoLicitacion({ID},'B');">
							<img src="http://www.newco.dev.br/images/2017/trash.png">
								<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/></xsl:attribute>
								<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/></xsl:attribute>
							</img>
						</a>
					</xsl:when>
					<xsl:when test="IDESTADO != 'B' and IDESTADO != 'SUS' and IDESTADO != 'CON' and IDESTADO != 'FIRM' and IDESTADO != 'ADJ'">
						<!--<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="/Licitaciones/LICITACIONES/FMOTIVOBORRAR/field"/>
							<xsl:with-param name="nombre">FMOTIVOBORRAR_<xsl:value-of select="ID"/></xsl:with-param>
							<xsl:with-param name="id">FMOTIVOBORRAR_<xsl:value-of select="ID"/></xsl:with-param>
							<xsl:with-param name="style">display:none;</xsl:with-param>
						</xsl:call-template>-->
						<a href="javascript:CambiarEstadoLicitacion({ID},'SUS');">
							<img src="http://www.newco.dev.br/images/2017/turn-off.png">
								<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='suspender']/node()"/></xsl:attribute>
								<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='suspender']/node()"/></xsl:attribute>
							</img>
						</a>
					</xsl:when>
					</xsl:choose>
				</xsl:if>
			</td>
		</tr>
		<tr id="trMOTIVOBORRAR_{ID}" style="align:right;display:none;">
			<td colspan="10">&nbsp;</td>
			<td colspan="10">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/Licitaciones/LICITACIONES/FMOTIVOBORRAR/field"/>
					<xsl:with-param name="nombre">FMOTIVOBORRAR_<xsl:value-of select="ID"/></xsl:with-param>
					<xsl:with-param name="id">FMOTIVOBORRAR_<xsl:value-of select="ID"/></xsl:with-param>
				</xsl:call-template>
				<input type="text" name="MOTIVOBORRAR_{ID}" id="MOTIVOBORRAR_{ID}" class="muygrande" />
			</td>
		</tr>
	</xsl:for-each>

		<tr class="sinLinea" style="color:black;line-height:14px;">
			<td style="text-align:right;height:30px;">
			<xsl:choose>
                        <xsl:when test="/Licitaciones/LICITACIONES/MVM or /Licitaciones/LICITACIONES/MVMB">
				<xsl:attribute name="colspan">12</xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="colspan">11</xsl:attribute>
			</xsl:otherwise>
			</xsl:choose>
                            <strong>
                                <xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:
                            </strong>
                        </td>
			<td><strong>
			<xsl:choose>
			<xsl:when test="/Licitaciones/LICITACIONES/MOSTRAR_PRECIO_IVA">
				<xsl:value-of select="/Licitaciones/LICITACIONES/LIC_CONSUMOTOTALIVA"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="/Licitaciones/LICITACIONES/LIC_CONSUMOTOTAL"/>
			</xsl:otherwise>
			</xsl:choose>
			</strong></td>
			<td colspan="4">&nbsp;</td>
		</tr>
		<tr class="sinLinea">
			<td>
			<xsl:choose>
                <xsl:when test="/Licitaciones/LICITACIONES/MVM or /Licitaciones/LICITACIONES/MVMB">
				<xsl:attribute name="colspan">18</xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="colspan">17</xsl:attribute>
			</xsl:otherwise>
			</xsl:choose>
            </td>
        </tr>
</xsl:when>
<xsl:otherwise>
	<tr class="sinLinea">
		<td align="center">
			<xsl:attribute name="colspan">
				<xsl:choose>
				<xsl:when test="/Licitaciones/LICITACIONES/MVM or /Licitaciones/LICITACIONES/MVMB">18</xsl:when>
				<xsl:otherwise>17</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_sin_resultados']/node()"/></strong>
		</td>
	</tr>
</xsl:otherwise>
</xsl:choose>
</table>

</xsl:template>


<!-- Template para los proveedores -->
<xsl:template name="Licitaciones_Proveedor">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/Licitaciones/LANG"><xsl:value-of select="/Licitaciones/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<form name="Buscador" method="post" action="Licitaciones.xsql">
<input type="hidden" name="ORDEN" value="{/Licitaciones/LICITACIONES/ORDEN}"/>
<input type="hidden" name="SENTIDO" value="{/Licitaciones/LICITACIONES/SENTIDO}"/>
<table class="buscador">
	<tr class="filtrosgrandes" height="50px">
		<th class="uno">&nbsp;</th>

		<!--	Area geo		-->
		<xsl:choose>
		<xsl:when test="/Licitaciones/LICITACIONES/FIDAREAGEOGRAFICA/field">
			<th width="180px" style="text-align:left">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Area_geografica']/node()"/></label><br />
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/Licitaciones/LICITACIONES/FIDAREAGEOGRAFICA/field"/>
				<xsl:with-param name="style">width:170px;</xsl:with-param>
			</xsl:call-template>
			</th>
		</xsl:when>
		<xsl:otherwise>
			<input type="hidden" name="FIDAREAGEOGRAFICA" value="-1"/>
		</xsl:otherwise>
		</xsl:choose>

		<!--	categoria	-->
		<xsl:choose>
		<xsl:when test="/Licitaciones/LICITACIONES/FIDCATEGORIA/field">
			<th width="180px" style="text-align:left">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='categoria']/node()"/></label><br />
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/Licitaciones/LICITACIONES/FIDCATEGORIA/field"/>
				<xsl:with-param name="style">width:170px;</xsl:with-param>
			</xsl:call-template>
			</th>
		</xsl:when>
		<xsl:otherwise>
			<input type="hidden" name="FIDCATEGORIA" value="-1"/>
		</xsl:otherwise>
		</xsl:choose>

		<th style="width:210px; text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></label><br />
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/Licitaciones/LICITACIONES/FIDEMPRESA/field"/>
				<xsl:with-param name="style">width:200px;</xsl:with-param>
			</xsl:call-template>
		</th>
		<!--<th>
			<input type="hidden" name="FIDRESPONSABLE" value="-1"/>
		</th>
		<th>
			<input type="hidden" name="FPROVEEDOR" value="-1"/>
		</th>
		<th>
			<input type="hidden" name="FPROVEEDORSEL" value="-1"/>
		</th>-->
		<th width="310px" style="text-align:left">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/>/<xsl:value-of select="document($doc)/translation/texts/item[@name='nif']/node()"/>/<xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion']/node()"/></label><br />
			<input type="text" name="FTEXTO" size="30" style="width:300px;">
				<xsl:attribute name="value"><xsl:value-of select="/Licitaciones/LICITACIONES/FTEXTO"/></xsl:attribute>
			</input>
		</th>
		<th style="width:140px; text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></label><br />
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/Licitaciones/LICITACIONES/FESTADO/field"/>
				<xsl:with-param name="style">width:130px;</xsl:with-param>
				<xsl:with-param name="onChange">javascript:CambiaEstado();</xsl:with-param>
			</xsl:call-template>
		</th>
		<th style="width:140px; text-align:left;">
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo']/node()"/></label><br />
			<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/Licitaciones/LICITACIONES/FPLAZO/field"/>
				<xsl:with-param name="style">width:130px;</xsl:with-param>
			</xsl:call-template>
		</th>
		<th style="width:140px; text-align:left;">
			<!--<div class="botonLargo">
			<strong>-->
				<!--<a class="btnDestacado" href="javascript:BuscarLicitaciones(document.forms['Buscador']);">-->
				<a class="btnDestacado" href="javascript:Enviar();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
				</a>
			<!--</strong>
			</div>-->
		</th>
		<th>&nbsp;</th>
	</tr>
</table>
<input type="hidden" name="FIDRESPONSABLE" value="-1"/>
<input type="hidden" name="FPROVEEDOR" value="-1"/>
<input type="hidden" name="FPROVEEDORSEL" value="-1"/>
</form>

<!--<table class="grandeInicio" id="tblData">-->
<table class="buscador" id="tblData">
<thead>
	<tr class="subTituloTabla">
		<th class="dos">&nbsp;</th><!-- Numero de linea -->
		<th class="dos" style="text-align:left;"><a href="javascript:Orden('COD');"><xsl:value-of select="document($doc)/translation/texts/item[@name='codigo']/node()"/></a></th>
		<th style="text-align:left;">
			<xsl:choose>
			<xsl:when test="/Licitaciones/LICITACIONES/INCLUIR_CENTRO_PEDIDO">
				<a href="javascript:Orden('CENTROPEDIDO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></a></xsl:when>
			<xsl:otherwise><a href="javascript:Orden('CLIENTE');"><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></a></xsl:otherwise>
			</xsl:choose>
		</th>
		<xsl:if test="/Licitaciones/LICITACIONES/FIDAREAGEOGRAFICA/field">
			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='Area_geografica']/node()"/></th>
		</xsl:if>
        <xsl:if test="not (/Licitaciones/LICITACIONES/OCULTAR_TITULO)">
	        <th style="text-align:left;">&nbsp;<a href="javascript:Orden('TITULO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/></a></th>
		</xsl:if>
		<th style="text-align:left;"><a href="javascript:Orden('ESTADO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></a></th>
		<th style="text-align:left;">
			<xsl:choose>
			<xsl:when test="/Licitaciones/LICITACIONES/IDPAIS = 55"><xsl:value-of select="document($doc)/translation/texts/item[@name='Comprador']/node()"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="document($doc)/translation/texts/item[@name='Responsable']/node()"/></xsl:otherwise>
			</xsl:choose>
		</th>
		<th><a href="javascript:Orden('NUMPROD');"><xsl:value-of select="document($doc)/translation/texts/item[@name='num_productos']/node()"/></a></th>
		<th><a href="javascript:Orden('FECHALIC');"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_alta_abbr']/node()"/></a></th>
		<th><a href="javascript:Orden('FECHADEC');"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision_abbr']/node()"/></a></th>
		<th><a href="javascript:Orden('FECHAOFE');"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_oferta']/node()"/></a></th>
		<xsl:if test="/Licitaciones/LICITACIONES/IDPAIS = '34'"><!--	para Brasil no mostramos la columna de consumo 	-->
			<th><a href="javascript:Orden('CONSUMO');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_obj_sIVA_2line']/node()"/></a></th>
		</xsl:if>
		<th style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='vendedor']/node()"/></th>
		<!--<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado']/node()"/></th>-->
		<th class="zerouno">&nbsp;</th>
	</tr>
</thead>

<xsl:choose>
<xsl:when test="/Licitaciones/LICITACIONES/LICITACION">
	<xsl:for-each select="/Licitaciones/LICITACIONES/LICITACION">
		<xsl:variable name="LicID"><xsl:value-of select="ID"/></xsl:variable>
		<tr>
			<td><xsl:value-of select="LINEA"/></td>
			<td style="text-align:left;">&nbsp;<strong><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/MantLicitacion.xsql?LIC_ID={$LicID}','Licitacion',100,80,0,-20);"><xsl:value-of select="LIC_CODIGO"/></a></strong></td>
			<td style="text-align:left;">
				&nbsp;<xsl:if test="FEDERASSANTAS"><img src="http://www.newco.dev.br/Conecta/img/logo_conecta.png" height="24px" width="67px"/>&nbsp;</xsl:if>
				<xsl:if test="/Licitaciones/LICITACIONES/OCULTAR_TITULO">
					<img src="http://www.newco.dev.br/images/2017/info.png"><xsl:attribute name="title"><xsl:value-of select="LIC_TITULO"/></xsl:attribute></img>
        		</xsl:if>
				<xsl:choose>
				<xsl:when test="CENTROPEDIDO/NOMBRE=''"><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDEMPRESA}&amp;VENTANA=NUEVA','Cliente',100,80,0,-20);"><xsl:value-of select="substring(EMPRESA,1,50)"/></a></xsl:when>
				<xsl:otherwise><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={CENTROPEDIDO/ID}','centro',100,80,0,-20);" class="noDecor"><xsl:value-of select="CENTROPEDIDO/NOMBRE"/></a></xsl:otherwise>
				</xsl:choose>
			</td>
			<xsl:if test="/Licitaciones/LICITACIONES/FIDAREAGEOGRAFICA/field">
            	<td><xsl:value-of select="CENTROPEDIDO/AREAGEOGRAFICA"/></td>
			</xsl:if>
        	<xsl:if test="not (/Licitaciones/LICITACIONES/OCULTAR_TITULO)">
				<td style="text-align:left;">&nbsp;<strong><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/MantLicitacion.xsql?LIC_ID={$LicID}','Licitacion',100,80,0,-20);"><xsl:value-of select="substring(LIC_TITULO,1,50)"/></a></strong></td>
			</xsl:if>
			<td style="text-align:left;">&nbsp;<strong><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/MantLicitacion.xsql?LIC_ID={$LicID}','Licitacion',100,80,0,-20);"><xsl:value-of select="ESTADO"/></a></strong>
				<xsl:if test="ESTADO_AYUDA!=''">
					&nbsp;<xsl:choose>
					<xsl:when test="SEMAFORO='AMBAR'">
						<img src="http://www.newco.dev.br/images/bolaAmbar.gif" class="static">
						<xsl:attribute name="title">
						<xsl:if test="INFORMADA_CONTINUA"><xsl:value-of select="document($doc)/translation/texts/item[@name='abierta_para_cambios_hasta_vencimiento']/node()"/>. </xsl:if>
						<xsl:value-of select="ESTADO_AYUDA"/></xsl:attribute>
						</img>
					</xsl:when>
					<xsl:otherwise>
						&nbsp;<img src="http://www.newco.dev.br/images/2017/info.png">
						<xsl:attribute name="title">
						<xsl:if test="INFORMADA_CONTINUA"><xsl:value-of select="document($doc)/translation/texts/item[@name='abierta_para_cambios_hasta_vencimiento']/node()"/>. </xsl:if>
						<xsl:value-of select="ESTADO_AYUDA"/></xsl:attribute>
						</img>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</td>
            <td style="text-align:left;">&nbsp;<xsl:value-of select="RESPONSABLE"/></td>
			<td style="text-align:right;"><xsl:value-of select="LIC_NUMEROLINEAS"/>&nbsp;</td>
			<td>&nbsp;<xsl:value-of select="LIC_FECHAALTA"/></td>
			<td>&nbsp;<xsl:value-of select="LIC_FECHADECISIONPREVISTA"/></td>
			<td>
				<xsl:attribute name="style">
					<xsl:choose>
					<xsl:when test="SEMAFORO='AMBAR'">text-align:left;color:red;</xsl:when>
					<xsl:otherwise>text-align:left;</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				&nbsp;<strong><xsl:value-of select="FECHAOFERTA"/></strong>
				<xsl:if test="FECHAOFERTA!='' and ESTADO_AYUDA!='' and SEMAFORO='AMBAR'">
					&nbsp;<img src="http://www.newco.dev.br/images/bolaAmbar.gif" class="static" title="{ESTADO_AYUDA}"/>
				</xsl:if>

			</td>
			<xsl:if test="/Licitaciones/LICITACIONES/IDPAIS = '34'"><!--	para Brasil no mostramos la columna de consumo 	-->
				<td style="text-align:right;"><xsl:value-of select="LIC_CONSUMO"/>&nbsp;</td>
			</xsl:if>
			<!--<td style="text-align:left;"><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={LIC_IDPROVEEDORSELECCIONADO}&amp;VENTANA=NUEVA','Proveedor',100,80,0,-20);"><xsl:value-of select="PROVEEDORSELECCIONADO"/></a></td>-->
            <td style="text-align:left;">&nbsp;<xsl:value-of select="VENDEDOR"/></td>
			<td>&nbsp;</td>
		</tr>
	</xsl:for-each>
	<xsl:if test="/Licitaciones/LICITACIONES/IDPAIS = '34'">
	<tfoot>
		<tr style="color:black;line-height:14px;">
			<td colspan="9" style="text-align:right;height:30px;"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/>:</strong></td>
			<td><strong><xsl:value-of select="/Licitaciones/LICITACIONES/LIC_CONSUMOTOTAL"/></strong></td>
			<td colspan="2">&nbsp;</td>
		</tr>
	</tfoot>
	</xsl:if>
</xsl:when>
<xsl:otherwise>
	<tr>
		<td align="center" colspan="12">
			<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_sin_resultados']/node()"/></strong>
		</td>
	</tr>
</xsl:otherwise>
</xsl:choose>
</table>

</xsl:template>







</xsl:stylesheet>
