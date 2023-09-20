<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Listado de empresas de MedicalVM con sus datos principales
	Ultima revision: ET 22mar22 10:00 ListadoEmpresasHTML2022_220322.js
+-->
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
		<xsl:value-of select="/ListadoEmpresas/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_de_empresas']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<!--	11ene22 nuevos estilos -->
	<!--<link rel="stylesheet" href="http://www.newco.dev.br/General/basicMVM2022.css"/>-->
	<link href='http://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'/>
	<!--	11ene22 nuevos estilos -->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/ListadoEmpresasHTML2022_220322.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->

</head>
<body>
	<form action="ListadoEmpresas2022.xsql" method="POST" name="form1">
	<xsl:choose>
	<xsl:when test="ListadoEmpresas/SIN_DERECHOS">
		<!--	Sin derechos -> Página en blanco	-->
	</xsl:when>
	<xsl:otherwise>
		<!--idioma-->
		<xsl:variable name="lang">
			<xsl:value-of select="/ListadoEmpresas/LANG"/>
		</xsl:variable>
		<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
		<!--idioma fin-->

		<!--<div class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_de_empresas']/node()"/> (<xsl:value-of select="document($doc)/translation/texts/item[@name='empresas_encontradas']/node()"/>: <xsl:value-of select="/ListadoEmpresas/EMPRESAS/TOTAL"/>)</div>-->
		<!-- Campos ocultos para transmision de datos	-->
		<input type="hidden" name="LISTAEMPRESAS"/>
		<input type="hidden" id="IDENCUESTA" name="IDENCUESTA"/>
		<input type="hidden" id="FECHA"  name="FECHA"/>
		<input type="hidden" id="IDUSUARIO" name="IDUSUARIO"/>
		<input type="hidden" id="LISTACENTROS" name="LISTACENTROS"/>
		<input type="hidden" id="REFERENCIA" name="REFERENCIA"/>
		<input type="hidden" id="PRODUCTO" name="PRODUCTO"/>
		<input type="hidden" id="PROVEEDOR" name="PROVEEDOR"/>
		<input type="hidden" id="PRECIO" name="PRECIO"/>
		<input type="hidden" id="UNIDADBASICA" name="UNIDADBASICA"/>
		<input type="hidden" id="ESTADO" name="ESTADO" value="O"/>
		<input type="hidden" id="ACCION" name="ACCION"/>
		<input type="hidden" id="PAGINA" name="PAGINA" value="{/ListadoEmpresas/EMPRESAS/FILTROS/PAGINA}"/>
		<input type="hidden" id="IDPAIS" name="IDPAIS" value="{/ListadoEmpresas/EMPRESAS/FILTROS/IDPAIS}"/>

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
        		<xsl:value-of select="document($doc)/translation/texts/item[@name='listado_de_empresas']/node()"/>&nbsp;<span class="fuentePeq">(<xsl:value-of select="document($doc)/translation/texts/item[@name='empresas_encontradas']/node()"/>: <xsl:value-of select="/ListadoEmpresas/EMPRESAS/TOTAL"/>)</span>
				<!--<span class="CompletarTitulo">
				<!- -	Botones	- ->
				</span>-->
			</p>
		</div>
		<br/>
		<br/>
		<br/>
		<br/>
		<div class="divLeft">
		<table cellspacing="6px" cellpadding="6px">
			<tr class="filtros">
				<td class="textLeft w40px">&nbsp;</td>
				<td class="textLeft w210px">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:</label><br/>
					<input type="text" class="campopesquisa w200px" id="FNOMBRE" name="FNOMBRE" value="{/ListadoEmpresas/EMPRESAS/FILTROS/NOMBRE}"/>
				</td>
				<td class="textLeft w100px">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Pend_aprobar']/node()"/>:</label><br/>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FPENDIENTEAPROBAR"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/PENDIENTEAPROBAR/field"/>
            			<xsl:with-param name="claSel">w90px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="textLeft w110px">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='provincia']/node()"/>:</label><br/>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FPROVINCIA"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FPROVINCIA/field"/>
            			<xsl:with-param name="claSel">w100px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="textLeft w110px">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/>:</label><br/>
            		<xsl:choose>
                		<xsl:when test="/ListadoEmpresas/LANG = 'spanish'">
						<xsl:call-template name="desplegable">
							<xsl:with-param name="id" value="FIDTIPO"/>
							<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/TIPOEMPRESA/field"/>
            				<xsl:with-param name="claSel">w100px</xsl:with-param>
						</xsl:call-template>
                	</xsl:when>
                	<xsl:otherwise>
                    	<select id="FIDTIPO" name="FIDTIPO" class="w100px">
                        	<xsl:for-each select="/ListadoEmpresas/EMPRESAS/FILTROS/TIPOEMPRESA/field/dropDownList/listElem">
                            	<option value="{ID}">
                                	<xsl:if test="ID = /ListadoEmpresas/EMPRESAS/FILTROS/TIPOEMPRESA/field/@current">
                                    	<xsl:attribute name="selected">selected</xsl:attribute>
                                	</xsl:if>
                                	<xsl:choose>
                                	<xsl:when test="ID = 'VENDEDOR'">
                                    	<xsl:copy-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>
                                	</xsl:when>
                                	<xsl:otherwise>
                                    	<xsl:value-of select="listItem" />
                                	</xsl:otherwise>
                                	</xsl:choose>
                            	</option>
                        	</xsl:for-each>
                    	</select>
                	</xsl:otherwise>
           			</xsl:choose>
				</td>
				<td class="w100px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/> 30:</label><br/>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FCOMPRAS30DIAS"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/COMPRAS30DIAS/field"/>
            			<xsl:with-param name="claSel">w90px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="w100px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/> 365:</label><br/>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FCOMPRAS"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/COMPRAS/field"/>
            			<xsl:with-param name="claSel">w90px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="w90px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo']/node()"/>:</label><br/>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FCATALOGO"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/CATALOGO/field"/>
            			<xsl:with-param name="claSel">w80px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="w90px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Ped_min']/node()"/>:</label><br/>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="FPEDIDOMINIMO"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/PEDIDOMINIMO/field"/>
            			<xsl:with-param name="claSel">w80px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="w90px textLeft">
					<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>:&nbsp;</label><br/>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="LINEASPORPAGINA"/>
						<xsl:with-param name="path" select="/ListadoEmpresas/EMPRESAS/FILTROS/LINEASPORPAGINA/field"/>
            			<xsl:with-param name="claSel">w80px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="w80px textLeft">
					<br/>
					<a class="btnDestacado" href="javascript:Buscar();"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/></a>&nbsp;
				</td>
				<td class="w80px textLeft">
					<xsl:if test="/ListadoEmpresas/EMPRESAS/ANTERIOR">
						<br/>
						<a class="btnNormal" href="javascript:PaginaAnterior();"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
					</xsl:if>
				</td>
				<td class="w80px textLeft">
					<xsl:if test="/ListadoEmpresas/EMPRESAS/SIGUIENTE">
						<br/>
						<a class="btnNormal" href="javascript:PaginaSiguiente();"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
					</xsl:if>
				</td>
				<td>&nbsp;</td>
			</tr>
			</table>
			<br/>
		</div>

		<div class="tabela tabela_redonda marginTop20">
		<table cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
			<tr class="subTituloTabla">
				<th class="w1px">&nbsp;</th>
				<th class="w1px"><a href="javascript:SeleccionarTodas();"><xsl:copy-of select="document($doc)/translation/texts/item[@name='todas']/node()"/></a></th>
				<th class="textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></th>
				<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Pend_aprobar']/node()"/></th>
				<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='provincia']/node()"/></th>
				<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/></th>
				<th class="w50px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='pedidos_30_dias_2line']/node()"/></th>
				<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_365_dias_2line']/node()"/></th>
				<th class="w50px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='lineas_catalogo_2line']/node()"/></th>
				<th class="w50px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='pedido_minimo_activo_3line']/node()"/></th>
				<th class="w50px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='importe_minimo_activo_3line']/node()"/></th>
				<th class="w1px">&nbsp;</th>
			</tr>
		</thead>

	<xsl:choose>
	<xsl:when test="/ListadoEmpresas/EMPRESAS/EMPRESA">
		<tbody class="corpo_tabela">
		<xsl:for-each select="/ListadoEmpresas/EMPRESAS/EMPRESA">
			<tr class="conhover">
				<xsl:if test="EMP_STATUS = 'E'">
                    <xsl:attribute name="class">fondoRojo</xsl:attribute> 
				</xsl:if>                                             
				<td class="color_status textRight"><xsl:value-of select="CONTADOR"/></td>
				<td><input class="muypeq" type="checkbox" name="CHK_{EMP_ID}"/></td>
				<td class="textLeft">
                    &nbsp;<a href="javascript:CambiarEmpresa({EMP_ID});">
                        <xsl:choose>
                            <xsl:when test="EMP_NOMBRE_CORTO != ''"><xsl:value-of select="EMP_NOMBRE_CORTO"/></xsl:when>
                            <xsl:otherwise><xsl:value-of select="NOMBRE"/></xsl:otherwise>
                        </xsl:choose>                                               
                    </a>
                </td>
				<td>
                    <xsl:choose>
                        <xsl:when test="EMP_STATUS = 'E'">S</xsl:when>
                        <xsl:otherwise>N</xsl:otherwise>
                    </xsl:choose>                                               
				</td>
				<td class="textLeft">&nbsp;<xsl:value-of select="EMP_PROVINCIA"/></td>
				<td><xsl:value-of select="TIPOEMPRESA"/></td>

				<td><xsl:if test="EMP_CONSUMOMES != 'N'"><xsl:value-of select="EMP_CONSUMOMES"/></xsl:if></td>
				<td><xsl:if test="EMP_CONSUMOANNO != 'N'"><xsl:value-of select="EMP_CONSUMOANNO"/></xsl:if></td>
				<td><xsl:if test="EMP_LINEASCATALOGO != 'N'"><xsl:value-of select="EMP_LINEASCATALOGO"/></xsl:if></td>

				<!--<td><xsl:if test="EMP_OCULTARPRECIOREF != 'N'"><xsl:value-of select="EMP_OCULTARPRECIOREF"/></xsl:if></td>
				<td><xsl:if test="EMP_MOSTRARCOMISIONES_NM != 'N'"><xsl:value-of select="EMP_MOSTRARCOMISIONES_NM"/></xsl:if></td>-->
				<td><xsl:if test="EMP_PEDMINIMO_ACTIVO != 'N'"><xsl:value-of select="EMP_PEDMINIMO_ACTIVO"/></xsl:if></td>
				<td><xsl:value-of select="EMP_PEDMINIMO_IMPORTE"/></td>
				<!--<td><xsl:if test="EMP_PROVNONAVEGAR != 'N'"><xsl:value-of select="EMP_PROVNONAVEGAR"/></xsl:if></td>
				<td><xsl:if test="EMP_PROVNONAVEGARPORDEFECTO != 'N'"><xsl:value-of select="EMP_PROVNONAVEGARPORDEFECTO"/></xsl:if></td>
				<td><xsl:if test="EMP_BLOQUEARMUESTRAS != 'N'"><xsl:value-of select="EMP_BLOQUEARMUESTRAS"/></xsl:if></td>-->
				<!--
				<td><xsl:if test="EMP_BLOQUEARBANDEJA != 'N'"><xsl:value-of select="EMP_BLOQUEARBANDEJA"/></xsl:if></td>
				<td><xsl:if test="EMP_CATALOGOVISIBLE != 'N'"><xsl:value-of select="EMP_CATALOGOVISIBLE"/></xsl:if></td>
				<td><xsl:if test="EMP_CATPRIV_CATEGORIAS != 'N'"><xsl:value-of select="EMP_CATPRIV_CATEGORIAS"/></xsl:if></td>
				<td><xsl:if test="EMP_CATPRIV_GRUPOS != 'N'"><xsl:value-of select="EMP_CATPRIV_GRUPOS"/></xsl:if></td>
				<td align="right"><xsl:if test="EMP_COMISION_TRANSACCIONES > 0"><xsl:value-of select="EMP_COMISION_TRANSACCIONES"/>&nbsp;</xsl:if></td>
				<td align="right"><xsl:value-of select="EMP_COMISION_AHORRO"/>&nbsp;</td>
				-->
				<!--<td align="right"><xsl:if test="BUSQUEDAS>0"><xsl:value-of select="BUSQUEDAS"/></xsl:if></td>
				<td align="right"><xsl:if test="BUSQUEDAS30DIAS>0"><xsl:value-of select="BUSQUEDAS30DIAS"/></xsl:if></td>
				<td align="right"><xsl:if test="SOLICITUDES>0"><xsl:value-of select="SOLICITUDES"/></xsl:if></td>
				<td align="right"><xsl:if test="SOLICITUDES30DIAS>0"><xsl:value-of select="SOLICITUDES30DIAS"/></xsl:if></td>
				<td align="right"><xsl:if test="NAVEGANPROVEEDORES>0"><xsl:value-of select="NAVEGANPROVEEDORES"/></xsl:if></td>
				<td><xsl:value-of select="LOGOTIPO"/></td>
				<td><xsl:value-of select="ESTILOS"/></td>-->
				<td>&nbsp;</td>
			</tr>
		</xsl:for-each>
		<!--
		<tr class="sinLinea">
			<td colspan="5">&nbsp;</td>
			<td align="right"><b><xsl:value-of select="/ListadoEmpresas/EMPRESAS/TOTAL_COMPRAS30DIAS"/></b></td>
			<td align="right"><b><xsl:value-of select="/ListadoEmpresas/EMPRESAS/TOTAL_COMPRAS"/></b></td>
			<td align="right"><b><xsl:value-of select="/ListadoEmpresas/EMPRESAS/TOTAL_LINEAS"/></b></td>
			<td colspan="10">&nbsp;</td>
			<!- -<td align="right"><b><xsl:value-of select="/ListadoEmpresas/EMPRESAS/TOTAL_BUSQUEDAS"/></b></td>
			<td align="right"><b><xsl:value-of select="/ListadoEmpresas/EMPRESAS/TOTAL_BUSQUEDAS30DIAS"/></b></td>
			<td align="right"><b><xsl:value-of select="/ListadoEmpresas/EMPRESAS/TOTAL_SOLICITUDES"/></b></td>
			<td align="right"><b><xsl:value-of select="/ListadoEmpresas/EMPRESAS/TOTAL_SOLICITUDES30DIAS"/></b></td>
			<td align="right"><b><xsl:value-of select="/ListadoEmpresas/EMPRESAS/TOTAL_NAVEGANPROVEEDORES"/></b></td>
			<td colspan="2">&nbsp;</td>- ->
		</tr>
		-->
			<tr class="sinLinea"><td colspan="15">&nbsp;</td></tr>
			<tr class="sinLinea">
				<td colspan="15" class="textCenter">
					<a class="btnDestacado" href="javascript:Continuar();" title="Buscar los centros correspondientes a las empresas seleccionadas"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscar_centros']/node()"/></a>
				</td>
			</tr>
		<!--</tfoot>-->
		</tbody>
	</xsl:when>
	<xsl:otherwise>
		<tr><td colspan="15"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_se_han_encontrado_resultados']/node()"/></td></tr>
	</xsl:otherwise>
	</xsl:choose>
		</table>
		<br/>
		<br/>
		<br/>
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
