<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Convocatorias especiales: listado de proveedores. Nuevo disenno.
	Ultima revision ET 20may22 12:15. Proveedores2022_200522.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/Productos/LANG"><xsl:value-of select="/Productos/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatorias']/node()"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/Proveedores2022_200522.js"></script>
	<script type="text/javascript">
		var IDConvocatoria='<xsl:value-of select="/Proveedores/PROVEEDORES/IDCONVOCATORIA"/>';
		var alrt_errorDescargaFichero	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_descarga_fichero']/node()"/>';
	</script>
</head>

<body class="gris">
<xsl:choose>
<xsl:when test="/Productos/SESION_CADUCADA">
	<xsl:for-each select="/Productos/SESION_CADUCADA">
		<xsl:if test="position()=last()">
			<xsl:apply-templates select="."/>
		</xsl:if>
	</xsl:for-each>
</xsl:when>
<xsl:when test="//xsql-error">
	<xsl:apply-templates select="//xsql-error"/>
</xsl:when>
<xsl:otherwise>
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
		<xsl:when test="/Productos/LANG"><xsl:value-of select="/Productos/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
    <!--idioma fin-->

	<xsl:variable name="usuario">
		<xsl:choose>
		<xsl:when test="EVALUACIONESPRODUCTOS/OBSERVADOR and EVALUACIONESPRODUCTOS/CDC">CDC</xsl:when>
		<xsl:otherwise>NORMAL</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<!--<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatorias']/node()"/>&nbsp;/&nbsp;<span class="FinPath">
			<xsl:value-of select="/Proveedores/PROVEEDORES/TOTAL_PROVEEDORES"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/></span>
			<span class="CompletarTitulo">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='pagina']/node()"/>&nbsp;
				<xsl:value-of select="/Proveedores/PROVEEDORES/PAGINA_ACTUAL"/>&nbsp;
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
				<xsl:value-of select="/Proveedores/PROVEEDORES/TOTAL_PAGINAS"/>
			</span>
		</p>-->
		<p class="TituloPagina">
			<xsl:value-of select="/Proveedores/PROVEEDORES/CONVOCATORIA"/>
			&nbsp;
			<span class="fuentePeq">
				(<xsl:value-of select="/Proveedores/PROVEEDORES/TOTAL_PROVEEDORES"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>)
			</span>
			<span class="CompletarTitulo400">
				<a class="btnNormal" href="javascript:VerConvocatoria();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatoria']/node()"/>
				</a>&nbsp;
				<xsl:if test="/Proveedores/PROVEEDORES/ROL='COMPRADOR'">
				<a class="btnNormal" href="javascript:DescargarExcel();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/>
				</a>&nbsp;
				<a class="btnNormal" href="javascript:VerProcedimientos('');">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimientos']/node()"/>
				</a>&nbsp;
				<a class="btnNormal" href="javascript:VerProductos();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>
				</a>&nbsp;
				</xsl:if>
				<!--	Botones	anterior y siguiente-->
				<xsl:if test="/Proveedores/PROVEEDORES/ANTERIOR">
					<a class="btnNormal" href="javascript:PaginaAnterior();"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>&nbsp;
				</xsl:if>
				<xsl:if test="/Proveedores/PROVEEDORES/SIGUIENTE">
					<a class="btnNormal" href="javascript:PaginaSiguiente();"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>&nbsp;
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>
	
	
	<div class="divLeft">
		<form name="Procedimiento" method="post" action="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/Proveedores2022.xsql">
		<input type="hidden" name="PAGINA" value="{/Proveedores/PROVEEDORES/PAGINA}"/>
		<input type="hidden" name="ORDEN" value="{/Proveedores/PROVEEDORES/ORDEN}"/>
		<input type="hidden" name="SENTIDO" value="{/Proveedores/PROVEEDORES/SENTIDO}"/>
		<input type="hidden" name="FLINEASPORPAGINA" id="FLINEASPORPAGINA" value="9999"/>
		<input type="hidden" name="ACCION" value=""/>
		<input type="hidden" name="PARAMETROS" value=""/>
		<table  cellspacing="6px" cellpadding="6px">
		<!-- 20may22 Quitamos desplegable de convocatorias, que utilicen el buscador
		<tr>
		<td class="w150px labelRight">
      		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatoria']/node()"/>:</label>
		</td>
		<td class="w400px textLeft">
        	<xsl:call-template name="desplegable">
            	<xsl:with-param name="path" select="/Proveedores/PROVEEDORES/FIDCONVOCATORIA/field"/>
            	<xsl:with-param name="claSel">w400px</xsl:with-param>
            	<xsl:with-param name="onChange">javascript:CambioDesplegables('CAMBIO_CONVOCATORIA');</xsl:with-param>
        	</xsl:call-template>
		</td>
		<td class="w150px textLeft">
			<a class="btnNormal" href="javascript:VerConvocatoria();">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatoria']/node()"/>
			</a>
		</td>
		<td width="*">
      		&nbsp;
		</td>
		</tr>
		-->
		<tr>
			<td class="w40px">&nbsp;</td>
			<td class="w400px textLeft">
        		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Filtros']/node()"/>:</label><br/>
        		<xsl:call-template name="desplegable">
            		<xsl:with-param name="path" select="/Proveedores/PROVEEDORES/FESPECIALES/field"/>
            		<xsl:with-param name="claSel">w400px</xsl:with-param>
        		</xsl:call-template>
			</td>
			<td class="w200px textLeft">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/>:</label><br/>
				<input type="text" class="campopesquisa w200px" name="FTEXTO" size="10" id="FTEXTO">
					<xsl:attribute name="value"><xsl:value-of select="/Proveedores/PROVEEDORES/FTEXTO"/></xsl:attribute>
				</input>
			</td>
			<!-- 20may22 Quitamos desplegable de lineas por pagina, mostramos todos los proveedores
			<td class="w300px textLeft">
				<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='lineas_por_pagina']/node()"/>:</label>
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/Proveedores/PROVEEDORES/LINEASPORPAGINA/field"/>
            		<xsl:with-param name="claSel">w100px</xsl:with-param>
				</xsl:call-template>
			</td>
			-->
			<td width="140px" class="textLeft">
				<br/>
				<a class="btnDestacado" href="javascript:Buscar();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
				</a>
			</td>
			<td>&nbsp;</td>
		</tr>
		</table>
		</form>
		<br/>

		<div class="tabela tabela_redonda">
		<table cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
			<tr>
				<th class="w1px"></th>
				<th class="textLeft"><a href="javascript:Orden('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a></th>
				<th class="w40px">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
				<xsl:if test="not(/Proveedores/PROVEEDORES/NOEDICION)">
					<th class="w50px">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='accion']/node()"/></th>
					<th class="w50px">&nbsp;<a href="javascript:Orden('FICHA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_ficha']/node()"/></a></th>
				</xsl:if>
				<th class="w60px">&nbsp;<a href="javascript:Orden('NUMOFERTAS');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/></a></th>
				<th class="w60px"><a href="javascript:Orden('PROCEDIMIENTOS');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Proced']/node()"/></a></th>
				<th class="w60px"><a href="javascript:Orden('ADJUDICADOS');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Adj']/node()"/></a></th>
				<th class="w60px"><a href="javascript:Orden('ORDEN1');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ord1']/node()"/></a></th>
				<th class="w60px">&nbsp;<a href="javascript:Orden('PROD_MEJOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimientos_mejor_precio']/node()"/></a></th>
				<th class="w80px">&nbsp;<a href="javascript:Orden('CONSUMO_MEJOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Importe_global_mejor_precio']/node()"/></a></th>
				<th class="w60px"><a href="javascript:Orden('PROD_AHORRO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimientos_con_ahorro']/node()"/></a></th>
				<th class="w80px"><a href="javascript:Orden('CONSUMO_AHORRO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Importe_global_con_ahorro']/node()"/></a></th>
				<th>&nbsp;</th>
			</tr>
		</thead>
		<!--	Cuerpo de la tabla	-->
		<tbody class="corpo_tabela">
        <xsl:choose>
		<xsl:when test="/Proveedores/PROVEEDORES/PROVEEDOR">
			<xsl:for-each select="/Proveedores/PROVEEDORES/PROVEEDOR">
				<xsl:variable name="IncID"><xsl:value-of select="ID"/></xsl:variable>
				<tr id="PRO_{LIC_CEL_ID}" class="conhover">
					<xsl:if test="IDESTADO='SUS'">
						<xsl:attribute name="class">fondoRojo</xsl:attribute>
					</xsl:if>
                    <td class="color_status"><xsl:value-of select="LINEA"/></td>
					<td class="textLeft">
						<a href="javascript:VerProcedimientos({IDPROVEEDOR});">
							<strong><xsl:value-of select="PROVEEDOR"/></strong>
						</a>
					</td>
					<td><xsl:value-of select="ESTADO"/></td>
					<xsl:if test="not(/Proveedores/PROVEEDORES/NOEDICION)">
						<td>
							<xsl:if test="IDESTADO='INF' or IDESTADO='FUERAPLAZO'">
								<a href="javascript:reabrirConvocatoria({IDPROVEEDOR});">
									<img src="http://www.newco.dev.br/images/2022/refresh-button.png" class="valignM"/>
									<!--<img src="http://www.newco.dev.br/images/2017/reload.png"/>-->
								</a>
							</xsl:if>
							<a class="btnDiscreto" href="javascript:activaOSuspendeProveedor({IDPROVEEDOR});">Sus<!--<img src="http://www.newco.dev.br/images/suspender.gif"/>--></a>
						</td>
						<td>
							<xsl:choose>
							<xsl:when test="EXISTE_FICHA_PROVEEDOR">
								<a class="btnDiscreto" href="javascript:FichaCompleta('{IDPROVEEDOR}');">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='ver_ficha']/node()"/>
								</a>
							</xsl:when>
							<xsl:otherwise><xsl:value-of select="document($doc)/translation/texts/item[@name='Sin_ficha_proveedor']/node()"/></xsl:otherwise>
							</xsl:choose>
						</td>
					</xsl:if>
					<td class="textRight"><strong><xsl:value-of select="NUMEROLINEAS"/></strong></td>
					<td class="textRight"><strong><xsl:value-of select="NUMPROCEDIMIENTOS"/></strong></td>
					<td class="textRight"><strong><xsl:value-of select="ADJUDICADOS"/></strong></td>
					<td class="textRight"><strong><xsl:value-of select="ORDEN1"/></strong></td>
					<td class="textRight azul"><strong><xsl:value-of select="OFERTASMEJORPRECIO"/></strong></td>
					<td class="textRight azul"><strong><xsl:value-of select="CONSUMOMEJORPRECIO"/></strong></td>
					<td class="textRight verde"><strong><xsl:value-of select="OFERTASCONAHORRO"/></strong></td>
					<td class="textRight verde"><strong><xsl:value-of select="CONSUMOCONAHORRO"/></strong></td>
					<td>
					</td>
				</tr>
			</xsl:for-each>
                </xsl:when>
		<xsl:otherwise>
			<tr><td colspan="15" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_se_han_encontrado_resultados']/node()"/></strong></td></tr>
		</xsl:otherwise>
		</xsl:choose>
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="15">&nbsp;</td></tr>
		</tfoot>
	</table>
 	</div>
 	<br/>  
 	<br/>  
    </div><!--fin de divLeft-->
	</xsl:otherwise>
        </xsl:choose>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
