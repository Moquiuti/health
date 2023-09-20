<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Listado/Buscador de roturas de stock. Nuevo disenno 2022.
	Ultima revision: ET 26may23 17:07
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:param name="usuario" select="@US_ID"/>

<xsl:template match="/RoturasStock">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>


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

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/descargas_151117.js"></script>		<!-- Para descargas excel	-->
	<script type="text/javascript" src="RoturasStock2022_260523.js"></script>
	<script type="text/javascript">
	
		var arrRoturas= [];
		<xsl:for-each select="ROTURAS_STOCK/ROTURA_STOCK">
			Rotura = [];
			Rotura["RefEstandar"]="<xsl:value-of select="REFESTANDAR"/>";
			Rotura["Fecha"]="<xsl:value-of select="FECHA"/>";
			Rotura["FechaFinal"]="<xsl:value-of select="FECHAFINAL"/>";
			Rotura["Proveedor"]="<xsl:value-of select="PROVEEDOR_JS"/>";
			Rotura["RefProveedor"]="<xsl:value-of select="REFPROVEEDOR"/>";
			Rotura["Producto"]="<xsl:value-of select="PRODUCTO_JS"/>";
			Rotura["Tipo"]="<xsl:value-of select="TIPO"/>";
			Rotura["Comentarios"]="<xsl:value-of select="COMENTARIOS_JS"/>";
			Rotura["Alternativa"]="<xsl:value-of select="ALTERNATIVA_JS"/>";
			Rotura["Duracion"]="<xsl:value-of select="DURACION"/>";
			
			arrRoturas.push(Rotura);
		</xsl:for-each>
		
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
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='roturas_stock']/node()"/>&nbsp;&nbsp;
			&nbsp;&nbsp;
			<span class="CompletarTitulo">
				<!--	Incluir los botones	-->
				<a class="btnNormal" href="javascript:ExportarExcel();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/>
				</a>&nbsp;
                <xsl:if test="ROTURAS_STOCK/PERMITIR_CREAR"><!--11may22 Esta marca esta pendiente de montar, no hay opcion de crear nuevas roturas desde aqui-->
				<a class="btnDestacado" href="javascript:NuevaRotura();"> 
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/>
				</a>
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>
		<form name="Buscador" method="post" action="http://www.newco.dev.br/ProcesosCdC/RoturasStock/RoturasStock2022.xsql">
		<input name="ACCION" type="hidden" value=""/>
		<input name="PARAMETRO" type="hidden" value=""/>
		<table cellspacing="6px" cellpadding="6px">
			<tr class="filtros h50px">
				<th class="uno">&nbsp;</th>
				<xsl:choose>
				<xsl:when test="ROTURAS_STOCK/MVM or ROTURAS_STOCK/ROL = 'VENDEDOR'">
					<th class="w140px textLeft">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></label><br />
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="ROTURAS_STOCK/FIDCLIENTE/field"/>
        					<xsl:with-param name="claSel">w140px</xsl:with-param>
						</xsl:call-template>
					</th>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="FIDCLIENTE" value="-1" id="FIDCLIENTE"/>
				</xsl:otherwise>
				</xsl:choose>

				<xsl:choose>
				<xsl:when test="ROTURAS_STOCK/MVM or ROTURAS_STOCK/MVMB or ROTURAS_STOCK/ROL = 'COMPRADOR'">
					<th class="w140px textLeft">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></label><br />
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="ROTURAS_STOCK/FIDPROVEEDOR/field"/>
        					<xsl:with-param name="claSel">w140px</xsl:with-param>
						</xsl:call-template>
					</th>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="FIDPROVEEDOR" value="-1" id="FIDPROVEEDOR"/>
				</xsl:otherwise>
				</xsl:choose>

				<th class="w140px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/></label><br />
					<input type="text" class="campopesquisa w150px" name="FTEXTO" id="FTEXTO">
						<xsl:attribute name="value"><xsl:value-of select="ROTURAS_STOCK/FILTROS/FTEXTO"/></xsl:attribute>
					</input>
				</th>

				<th class="w140px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="ROTURAS_STOCK/FIDESTADO/field"/>
        				<xsl:with-param name="claSel">w140px</xsl:with-param>
					</xsl:call-template>
				</th>

				<th width="140px" class="textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/></label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="ROTURAS_STOCK/FIDTIPO/field"/>
        				<xsl:with-param name="claSel">w140px</xsl:with-param>
					</xsl:call-template>
				</th>

				<th class="w140px textLeft">
					<br/>
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

		<div class="tabela tabela_redonda">
		<table cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
			<tr>
				<th class="w1x">&nbsp;</th>
				<th class="w50px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
				<th class="w50px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='Fecha_final']/node()"/></th>
				<xsl:if test="/RoturasStock/ROTURAS_STOCK/MOSTRAR_COLUMNA_REFESTANDAR"><!--25oct22 Ref Estandar para usuarios no MVM-->
					<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_mvm']/node()"/></th>
				</xsl:if>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
				<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
				<th class="w150px">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/></th>
				<th class="textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='alternativa']/node()"/></th>
				<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='duracion']/node()"/></th>
				<th class="w1x">&nbsp;</th>
			</tr>
		</thead>
		<!--	Cuerpo de la tabla	-->
		<tbody class="corpo_tabela">
        <xsl:choose>
		<xsl:when test="ROTURAS_STOCK/ROTURA_STOCK">
			<xsl:for-each select="ROTURAS_STOCK/ROTURA_STOCK">
				<tr id="PRO_{IDPRODUCTO}">
					<xsl:choose>
					<xsl:when test="MODIFICADO_1HORA">
						<xsl:attribute name="class">fondoNaranja</xsl:attribute>
					</xsl:when>
					<xsl:when test="MODIFICADO_24HORAS">
						<xsl:attribute name="class">fondoAmarillo</xsl:attribute>
					</xsl:when>
					</xsl:choose>

					<td class="color_status"><xsl:value-of select="position()"/></td>
					<td><xsl:value-of select="FECHA"/></td>
					<td><xsl:value-of select="FECHAFINAL"/></td>
					<xsl:if test="/RoturasStock/ROTURAS_STOCK/MOSTRAR_COLUMNA_REFESTANDAR"><!--25oct22 Ref Estandar para usuarios no MVM-->
						<td class="textLeft"><xsl:value-of select="REFESTANDAR"/></td>
					</xsl:if>
                    <td class="textLeft">
						<a href="javascript:FichaEmpresa({IDCLIENTE})">
							<xsl:value-of select="PROVEEDOR"/>
						</a>
					</td>
					<td class="textLeft">
						<xsl:value-of select="REFPROVEEDOR"/>
					</td>
					<td class="textLeft">
						<a href="javascript:FichaProducto('{IDPRODUCTO}')">
							<xsl:value-of select="PRODUCTO"/>
                        </a>
					</td>
					<td class="textLeft">
						<xsl:value-of select="TIPO"/>
					</td>
					<td class="textLeft">
						&nbsp;<xsl:value-of select="COMENTARIOS"/>
					</td>
					<td class="textLeft">
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
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="11">&nbsp;</td></tr>
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
