<?xml version="1.0" encoding="iso-8859-1"?>
<!-- 
	13jul10	Sistema para poner comentarios que ayuden a la gestión comercial
	Ultima revision: ET 23feb22 16:00 EMPValoracionProv_060917.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/Valoracion">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>


<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="LANG != ''"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--fin idioma-->

	<title><xsl:value-of select="ENTRADAS_SEGUIMIENTO/TITULOS/EMPRESA"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='valoracion_proveedor']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->
 	
	<link href="http://www.newco.dev.br/General/Tabla-popup.2022.css" rel="stylesheet" type="text/css"/>

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPValoracionProv_060917.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/Tabla-popup.150715.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/starrating.js"></script>

  <script type="text/javascript">
    var notaCalidadObli		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nota_calidad_obli']/node()"/>';
    var notaServicioObli	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nota_servicio_obli']/node()"/>';
    var notaPrecioObli		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nota_precio_obli']/node()"/>';
  	
	/*	INICIO CABECERA JS, ANTES EN EMPValoracionProv.js	*/
	jQuery(document).ready(globalEvents);

	function globalEvents(){
		var numRows = jQuery("select#NumLineas").val();
		mostrarLineas(numRows);
		jQuery('.rating-holder').starRating();
	}
	/*	FIN CABECERA JS, ANTES EN EMPValoracionProv.js	*/

	/*jQuery(window).load(function(){
		initStarRating();
	});*/

	// init star rating functionality
	function initStarRating(context)
	{
		jQuery('.rating-holder', context).starRating();
	}
	
  </script>
</head>

<body>
<xsl:choose>
<!-- Error en alguna sentencia del XSQL -->
<xsl:when test="//xsql-error">
	<xsl:apply-templates select="//xsql-error"/>
</xsl:when>
<xsl:when test="//SESION_CADUCADA">
	<xsl:for-each select="//SESION_CADUCADA">
		<xsl:if test="position()=last()">
			<xsl:apply-templates select="."/>
		</xsl:if>
	</xsl:for-each>
</xsl:when>
<xsl:otherwise>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Valoracion/LANG != ''"><xsl:value-of select="/Valoracion/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--fin idioma-->

  <form name="formValoracion" action="EMPValoracionProv.xsql" method="post">
	<input type="hidden" name="IDPAIS" value="{ENTRADAS_SEGUIMIENTO/TITULOS/IDPAIS}"/>
	<input type="hidden" name="IDEMPRESAUSUARIO" value="{ENTRADAS_SEGUIMIENTO/IDEMPRESAUSUARIO}"/>
	<input type="hidden" name="EMP_ID" value="{ENTRADAS_SEGUIMIENTO/TITULOS/IDEMPRESA}"/>
	<input type="hidden" name="ACCION" id="ACCION"/>
	<input type="hidden" name="PARAMETROS" id="PARAMETROS"/>
	<input type="hidden" name="NOTA_CALIDAD" id="NOTA_CALIDAD"/>
	<input type="hidden" name="NOTA_SERVICIO" id="NOTA_SERVICIO"/>
	<input type="hidden" name="NOTA_PRECIO" id="NOTA_PRECIO"/>


	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
        	<xsl:value-of select="ENTRADAS_SEGUIMIENTO/TITULOS/EMPRESA"/>
			<span class="CompletarTitulo">
				<select name="NumLineas" id="NumLineas" onchange="mostrarLineas(this.value);">
					<option value="10" selected="selected">
						10 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
					</option>
					<option value="20">
						20 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
					</option>
					<option value="50">
						50 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
					</option>
					<option value="todas">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/>
					</option>
				</select>&nbsp;
				<xsl:if test="ENTRADAS_SEGUIMIENTO/MVM or ENTRADAS_SEGUIMIENTO/MVMB">
					<a class="btnNormal" href="javascript:window.print();" style="text-decoration:none;" title="Imprimir">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
					</a>&nbsp;
				</xsl:if>
				<xsl:if test="ENTRADAS_SEGUIMIENTO/COMERCIAL">
					<a class="btnDestacado" href="javascript:AbrirNuevaValoracion();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
					</a>&nbsp;
				</xsl:if>			
			</span>
		</p>
	</div>
	<br/>

	<div class="divLeft">
	
	<!-- Pop-up para nueva entrada de valoracion -->
	<xsl:if test="ENTRADAS_SEGUIMIENTO/COMERCIAL">
		<xsl:call-template name="nuevavaloracion">
			<xsl:with-param name="doc" select="$doc"/>
			<xsl:with-param name="idproveedor" select="ENTRADAS_SEGUIMIENTO/TITULOS/IDEMPRESA"/>
			<xsl:with-param name="proveedor" select="ENTRADAS_SEGUIMIENTO/TITULOS/EMPRESA"/>
			<xsl:with-param name="fecha" select="ENTRADAS_SEGUIMIENTO/FECHA"/>
		</xsl:call-template>
	</xsl:if>



	<div class="divLeft textCenter space40px">
	<div class="linha_separacao_cotacao_y"></div>
	<div class="tabela tabela_redonda">
	<table id="ListaValoraciones" cellspacing="10px" cellpadding="10px" class="w1200px tableCenter">
		<xsl:choose>
		<xsl:when test="ENTRADAS_SEGUIMIENTO/SEGUIMIENTO/ENTRADA">
			<thead class="cabecalho_tabela">
        	<tr>
				<th class="w1px">&nbsp;</th>
				<th class="seis">&nbsp;</th>
				<th class="datosLeft w200px"><xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/></th>
				<th class="datosLeft w200px"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
				<th class="center w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='calidad']/node()"/></th>
				<th class="center w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='servicio']/node()"/></th>
				<th class="center w100px "><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></th>
				<th class="datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/></th>
				<th class="datosLeft w1px">&nbsp;</th>
				<th class="w1px">&nbsp;</th>
			</tr>
			</thead>
   	    	<tbody class="corpo_tabela">
			<xsl:for-each select="ENTRADAS_SEGUIMIENTO/SEGUIMIENTO/ENTRADA">
				<xsl:variable name="id" select="ID"/>

				<tr class="conhover">
					<xsl:choose>
					<xsl:when test="MODIFICADO_1HORA">
						<xsl:attribute name="style">background:#ff9900;</xsl:attribute>
					</xsl:when>
					<xsl:when test="MODIFICADO_24HORAS">
						<xsl:attribute name="style">background:FFFF99;</xsl:attribute>
					</xsl:when>
					</xsl:choose>

					<td class="color_status">&nbsp;</td>
					<td class="datosCenter"><strong><xsl:value-of select="FECHA"/></strong></td>
					<td style="text-align:left;"><span style="font-weight:bold;"><xsl:value-of select="AUTOR"/></span></td>
					<td style="text-align:left;"><xsl:value-of select="CENTROAUTOR"/></td>
					<td style="text-align:center;font-weight:bold;">
						<xsl:value-of select="NOTACALIDAD"/>/5
					</td>
					<td style="text-align:center;font-weight:bold;">
						<xsl:value-of select="NOTASERVICIO"/>/5
					</td>
					<td style="text-align:center;font-weight:bold;">
						<xsl:value-of select="NOTAPRECIO"/>/5
					</td>
					<td style="text-align:left;padding:5px 0px;"><xsl:copy-of select="TEXTO" /></td>
					<td style="padding-left:10px;text-align:left;">
						<xsl:if test="/Valoracion/ENTRADAS_SEGUIMIENTO/ADMIN or (/Valoracion/ENTRADAS_SEGUIMIENTO/IDUSUARIO = IDAUTOR)">
							<a href="javascript:Borrar({ID});" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/2017/trash.png"/>
							</a>
						</xsl:if>
					</td>
					<td>&nbsp;</td>
				</tr>

			</xsl:for-each>
			</tbody>
		</xsl:when>
		<xsl:otherwise>
			<thead class="cabecalho_tabela">
        	<tr>
				<th class="w1px">&nbsp;</th>
				<th colspan="9">&nbsp;</th>
			</tr>
			</thead>
   	    	<tbody class="corpo_tabela">
			<tr>
				<td class="color_status">&nbsp;</td>
				<td colspan="9" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='valoraciones_sin_resultados']/node()"/></strong></td>
			</tr>
			</tbody>
		</xsl:otherwise>
		</xsl:choose>
		<tfoot class="rodape_tabela"><tr><td colspan="10">&nbsp;</td></tr></tfoot>
    </table>
	</div>

    <br /><br />
	</div>
	</div>

	</form>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>

</xsl:stylesheet>
