<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Listado/Buscador de centros de MedicalVM
	Ultima revision: ET 22mar22 11:00 BuscadorCentros2022_220322.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/BuscadorCentros/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_de_centros']/node()"/></title>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/BuscadorCentros2022_220322.js"></script>

</head>
<body>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/BuscadorCentros/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<form action="BuscadorCentros2022.xsql" method="POST" name="form1">
	<xsl:choose>
		<xsl:when test="BuscadorCentros/SIN_DERECHOS">
			<!--	Sin derechos -> Página en blanco	-->   
		</xsl:when>
		<xsl:otherwise>

		<!--<div class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_de_centros']/node()"/> (<xsl:value-of select="document($doc)/translation/texts/item[@name='centros_encontrados']/node()"/>: <xsl:value-of select="/BuscadorCentros/CENTROS/TOTAL"/>)</div>-->
		<!-- Campos ocultos para transmision de datos	-->
		<input type="hidden" name="LISTAEMPRESAS" value=""/>
		<input type="hidden" id="IDENCUESTA" name="IDENCUESTA" value="" />
		<input type="hidden" id="FECHA"  name="FECHA" value="" />
		<input type="hidden" id="IDUSUARIO" name="IDUSUARIO" value="" />
		<input type="hidden" id="LISTACENTROS" name="LISTACENTROS" value="" />
		<input type="hidden" id="REFERENCIA" name="REFERENCIA" value="" />
		<input type="hidden" id="PRODUCTO" name="PRODUCTO" value="" />
		<input type="hidden" id="PROVEEDOR" name="PROVEEDOR" value="" />
		<input type="hidden" id="PRECIO" name="PRECIO" value="" />
		<input type="hidden" id="UNIDADBASICA" name="UNIDADBASICA" value="" />
		<input type="hidden" id="ESTADO" name="ESTADO" value="O" />
		<input type="hidden" id="ACCION" name="ACCION" value="" />
		<input type="hidden" id="PAGINA" name="PAGINA" value="{/BuscadorCentros/CENTROS/FILTROS/PAGINA}" />
		<input type="hidden" id="IDPAIS" name="IDPAIS" value="{/BuscadorCentros/CENTROS/FILTROS/IDPAIS}" />

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
        	  <xsl:value-of select="document($doc)/translation/texts/item[@name='listado_de_centros']/node()"/>&nbsp;<span class="fuentePeq">(<xsl:value-of select="document($doc)/translation/texts/item[@name='centros_encontrados']/node()"/>: <xsl:value-of select="/BuscadorCentros/CENTROS/TOTAL"/>)</span>
			  <!--<span class="CompletarTitulo">
			  	Botones
			  </span>	-->
			</p>
		</div>
		<br/>
		<br/>
		<br/>
		<br/>


		<div class="divLeft">
		<table cellspacing="6px" cellpadding="6px">
			<tr>
				<th class="w40px">&nbsp;</th>
				<th class="w210px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>/<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</label><br/>
					<input type="text" class="campopesquisa w200px" id="FNOMBRE" name="FNOMBRE" maxlength="20" value="{/BuscadorCentros/CENTROS/FILTROS/NOMBRE}"/>
				</th>
				<th class="w110px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='provincia']/node()"/>:</label><br/>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FPROVINCIA"/>
						<xsl:with-param name="path" select="/BuscadorCentros/CENTROS/FPROVINCIA/field"/>
						<xsl:with-param name="claSel">w100px</xsl:with-param>
					</xsl:call-template>
				</th>
				<th class="w110px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/>:</label><br/>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FIDTIPO"/>
						<xsl:with-param name="path" select="/BuscadorCentros/CENTROS/FILTROS/TIPOEMPRESA/field"/>
						<xsl:with-param name="claSel">w100px</xsl:with-param>
					</xsl:call-template>
				</th>
				<th class="w130px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='sin_comisiones']/node()"/>:</label><br/>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FSINCOMISIONES"/>
						<xsl:with-param name="path" select="/BuscadorCentros/CENTROS/FILTROS/SINCOMISIONES/field"/>
						<xsl:with-param name="claSel">w120px</xsl:with-param>
					</xsl:call-template>
				</th>
				<th class="w150px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='lineas_por_pagina']/node()"/>:</label><br/>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="LINEASPORPAGINA"/>
						<xsl:with-param name="path" select="/BuscadorCentros/CENTROS/FILTROS/LINEASPORPAGINA/field"/>
						<xsl:with-param name="claSel">w140px</xsl:with-param>
					</xsl:call-template>
				</th>
				<th class="w80px textLeft">
					<br/>
					<a class="btnDestacado" href="javascript:Buscar();"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/></a>
				</th>
				<th class="w80px textLeft">
					<xsl:if test="/BuscadorCentros/CENTROS/ANTERIOR">
						<br/>
						<a class="btnNormal" href="javascript:PaginaAnterior();"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
					</xsl:if>
				</th>
				<th class="w80px textLeft">
					<xsl:if test="/BuscadorCentros/CENTROS/SIGUIENTE">
						<br/>
						<a class="btnNormal" href="javascript:PaginaSiguiente();"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
					</xsl:if>
				</th>
				<th>&nbsp;</th>
			</tr>
			</table>
			<br/>
		</div>

		<div class="tabela tabela_redonda">
		<table cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
			<tr>
				<th class="w1px">&nbsp;</th>
				<th class="w10px"><a href="javascript:SeleccionarTodas();"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/></a></th>
				<th class="w200px textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></th>
				<th class="w200px textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
				<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='provincia']/node()"/></th>
				<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/></th>
				<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='sin_comisiones']/node()"/></th>
				<th class="w50px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='accesos_30_dias']/node()"/></th>
				<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='logotipo']/node()"/></th>
				<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='estilos']/node()"/></th>
			</tr>
		</thead>
		<xsl:choose>
		<xsl:when test="/BuscadorCentros/CENTROS/CENTRO">
			<tbody class="corpo_tabela">
			<xsl:for-each select="/BuscadorCentros/CENTROS/CENTRO">
				<tr class="conhover">
					<td class="color_status"><xsl:value-of select="CONTADOR"/></td>
					<td><input class="muypeq" type="checkbox" name="CHK_{EMP_ID}"/></td>
					<td class="textLeft">
						<a href="javascript:CambiarEmpresa({EMP_ID});"><xsl:value-of select="EMPRESA"/></a>
					</td>
					<td class="textLeft">
						<a href="javascript:CambiarCentro({EMP_ID}, {CEN_ID});"><xsl:value-of select="NOMBRE"/></a>
					</td>
					<td><xsl:value-of select="PROVINCIA"/></td>
					<td><xsl:value-of select="TIPOEMPRESA"/></td>
					<td><xsl:value-of select="SINCOMISIONES"/></td>
					<td>
						<xsl:if test="ACCESOS30DIAS>0">
							<xsl:value-of select="ACCESOS30DIAS"/>
						</xsl:if>
					</td>
					<!--<td align="right">
						<xsl:if test="BUSQUEDAS>0">
							<xsl:value-of select="BUSQUEDAS"/>&nbsp;
						</xsl:if>
					</td>
					<td align="right">
						<xsl:if test="BUSQUEDAS30DIAS>0">
							<xsl:value-of select="BUSQUEDAS30DIAS"/>&nbsp;
						</xsl:if>
					</td>
					<td align="right">
						<xsl:if test="SOLICITUDES>0">
							<xsl:value-of select="SOLICITUDES"/>&nbsp;
						</xsl:if>
					</td>
					<td align="right">
						<xsl:if test="SOLICITUDES30DIAS>0">
							<xsl:value-of select="SOLICITUDES30DIAS"/>&nbsp;
						</xsl:if>
					</td>
					<td align="right">
						<xsl:if test="NAVEGANPROVEEDORES>0">
							<xsl:value-of select="NAVEGANPROVEEDORES"/>&nbsp;
						</xsl:if>
					</td>-->
					<td><xsl:value-of select="LOGOTIPO"/></td>
					<td><xsl:value-of select="ESTILOS"/></td>
				</tr>
			</xsl:for-each>
			</tbody>
			<!--
			<tfoot>
				<tr class="sinLinea">
					<td colspan="7">&nbsp;</td>
					<td align="right">
						<b><xsl:value-of select="/BuscadorCentros/CENTROS/TOTAL_NAVEGANPROVEEDORES"/>&nbsp;</b>
					</td>
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr class="sinLinea">
					<td colspan="14">&nbsp;</td>
				</tr>-->
				<tr><td colspan="14">&nbsp;</td></tr>
				<tr>
					<td colspan="14" class="textCenter">
						<a class="btnDestacado" href="javascript:Continuar();" title="Buscar los usuarios correspondientes a las empresas seleccionadas"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscar_usuarios']/node()"/></a>
					</td>
				</tr>
			<!--</tfoot>-->
		</xsl:when>
		<xsl:otherwise>
			<tr><td colspan="14"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_se_han_encontrado_resultados']/node()"/></td></tr>
		</xsl:otherwise>
		</xsl:choose>
		</table>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		</div>
	</xsl:otherwise>
        </xsl:choose>
	</form>
	</body>
</html>

	</xsl:template>
</xsl:stylesheet>
