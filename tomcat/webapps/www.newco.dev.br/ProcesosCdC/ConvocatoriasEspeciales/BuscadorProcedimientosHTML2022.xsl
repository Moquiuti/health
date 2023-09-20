<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Convocatorias especiales: buscador de procedimientos. Nuevo disenno. 
	Ultima revision ET 23may22 10:30. BuscadorProcedimientos2022_200522.js
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
		<xsl:when test="/Procedimientos/LANG"><xsl:value-of select="/Procedimientos/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatorias']/node()"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimientos']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProcedimientos2022_200522.js"></script>
	
	<script type="text/javascript">
		var IDConvocatoria='<xsl:value-of select="/Procedimientos/PROCEDIMIENTOS/IDCONVOCATORIA"/>';
		var alrt_errorDescargaFichero	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_descarga_fichero']/node()"/>';
	</script>
</head>

<body class="gris" onload="javascript:onLoad();">
<xsl:choose>
<xsl:when test="/Procedimientos/SESION_CADUCADA">
	<xsl:for-each select="/Procedimientos/SESION_CADUCADA">
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
		<xsl:when test="/Procedimientos/LANG"><xsl:value-of select="/Procedimientos/LANG" /></xsl:when>
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
		<!--<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatorias']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="/Procedimientos/PROCEDIMIENTOS/TOTAL"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimientos']/node()"/></span>
			<span class="CompletarTitulo">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='pagina']/node()"/>&nbsp;
				<xsl:value-of select="/Procedimientos/PROCEDIMIENTOS/PAGINA_ACTUAL"/>&nbsp;
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
				<xsl:value-of select="/Procedimientos/PROCEDIMIENTOS/TOTAL_PAGINAS"/>
			</span>
		</p>-->
		<p class="TituloPagina">
			<xsl:value-of select="/Procedimientos/PROCEDIMIENTOS/CONVOCATORIA"/>
			<span class="fuentePeq">
				(<xsl:value-of select="/Procedimientos/PROCEDIMIENTOS/TOTAL"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimientos']/node()"/>.&nbsp;
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='pagina']/node()"/>&nbsp;
				<xsl:value-of select="/Procedimientos/PROCEDIMIENTOS/PAGINA_ACTUAL"/>&nbsp;
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
				<xsl:value-of select="/Procedimientos/PROCEDIMIENTOS/TOTAL_PAGINAS"/>)
			</span>
			<span class="CompletarTitulo500">
				<a class="btnNormal" href="javascript:DescargarExcel();">
					<!--<img src="http://www.newco.dev.br/images/iconoExcel.gif" alt="Descargar Excel"/>-->
					<xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/>
				</a>&nbsp;
				<xsl:if test="/Procedimientos/PROCEDIMIENTOS/ROL='COMPRADOR'">
				<a class="btnNormal" href="javascript:VerProductos()">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>
				</a>&nbsp;
				<a class="btnNormal" href="javascript:VerProveedores({/Procedimientos/PROCEDIMIENTOS/IDPROVEEDOR})">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>
				</a>
				</xsl:if>
				<!--	Botones	anterior y siguiente-->
				<xsl:if test="/Procedimientos/PROCEDIMIENTOS/ANTERIOR">
					&nbsp;<a class="btnNormal" href="javascript:PaginaAnterior();"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
				</xsl:if>
				<xsl:if test="/Procedimientos/PROCEDIMIENTOS/SIGUIENTE">
					&nbsp;<a class="btnNormal" href="javascript:PaginaSiguiente();"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>
	
	
	<div class="divLeft">
		<form name="Buscador" method="post" action="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProcedimientos2022.xsql">
        <input type="hidden" name="ROL" id="ROL" value="{/Procedimientos/PROCEDIMIENTOS/ROL}"/>
        <input type="hidden" name="PAGINA" id="PAGINA" value="{/Procedimientos/PROCEDIMIENTOS/PAGINA}"/>
        <input type="hidden" name="ORDEN" id="ORDEN" value="{/Procedimientos/PROCEDIMIENTOS/ORDEN}"/>
		<input type="hidden" name="SENTIDO" value="{/Procedimientos/PROCEDIMIENTOS/SENTIDO}"/>
        <input type="hidden" name="IDPROVEEDOR" id="IDPROVEEDOR" value="{/Procedimientos/PROCEDIMIENTOS/IDPROVEEDOR}"/>
        <input type="hidden" name="FIDCONVOCATORIA" id="FIDCONVOCATORIA" value="{/Procedimientos/PROCEDIMIENTOS/IDCONVOCATORIA}"/>
		<table  cellspacing="6px" cellpadding="6px">
			<tr>
				<td class="w40px">&nbsp;</td>
    			<xsl:if test="/Procedimientos/PROCEDIMIENTOS/MVM or /Procedimientos/PROCEDIMIENTOS/MVMB or /Procedimientos/PROCEDIMIENTOS/ROL = 'COMPRADOR'">
					<td class="w300px textLeft">
        				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></label><br />
        				<xsl:call-template name="desplegable">
            			<xsl:with-param name="path" select="/Procedimientos/PROCEDIMIENTOS/FIDPROVEEDOR/field"/>
            			<xsl:with-param name="defecto" select="/Procedimientos/PROCEDIMIENTOS/FIDPROVEEDOR/field/@current"/>
            			<xsl:with-param name="claSel">w300px</xsl:with-param>
						<xsl:with-param name="onChange">javascript:proveedorOnChange();</xsl:with-param>
        			</xsl:call-template>
					</td>
    			</xsl:if>
				<td class="w200px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/></label><br />
					<input type="text" class="campopesquisa w200px" name="FTEXTO" id="FTEXTO" >
						<xsl:attribute name="value"><xsl:value-of select="/Procedimientos/PROCEDIMIENTOS/FTEXTO"/></xsl:attribute>
					</input>
				</td>
    			<xsl:if test="/Procedimientos/PROCEDIMIENTOS/MVM or /Procedimientos/PROCEDIMIENTOS/MVMB or /Procedimientos/PROCEDIMIENTOS/ROL = 'COMPRADOR'">
				<td class="w200px textLeft">
        			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Filtros']/node()"/>:&nbsp;</label><br />
        			<xsl:call-template name="desplegable">
            			<xsl:with-param name="path" select="/Procedimientos/PROCEDIMIENTOS/FESPECIALES/field"/>
            			<xsl:with-param name="claSel">w200px</xsl:with-param>
            			<xsl:with-param name="disabled">disabled</xsl:with-param>
        			</xsl:call-template>
				</td>
    			</xsl:if>
				<td class="w150px textLeft">
					<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='lineas_por_pagina']/node()"/></label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Procedimientos/PROCEDIMIENTOS/LINEASPORPAGINA/field"/>
            			<xsl:with-param name="claSel">w150px</xsl:with-param>
						<xsl:with-param name="onChange">javascript:Buscar();</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="w140px textLeft">
					<br/>
					<input type="checkbox" class="muypeq" style="widtd:30px;" name="FINFORMADO">
					<xsl:if test="/Procedimientos/PROCEDIMIENTOS/FINFORMADO='S'">
						<xsl:attribute name="checked" value="checked"/>
					</xsl:if>
					</input>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Informado']/node()"/></label><br />
				</td>

				<td class="w140px textLeft">
					<br/>
					<a class="btnDestacado" href="javascript:Buscar();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
					</a>
				</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		</form>

		<div class="tabela tabela_redonda">
		<table cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
			<tr>
				<th class="w1x"></th>
				<th class="textLeft w50px"><a href="javascript:Orden('REFERENCIA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ref']/node()"/></a></th>
				<th align="left"><a href="javascript:Orden('PROCEDIMIENTO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimiento']/node()"/></a></th>
				<xsl:choose>
				<xsl:when test="/Procedimientos/PROCEDIMIENTOS/CON_FILTRO_PROVEEDOR">
					<th class="textLeft w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></th>
					<th class="textLeft w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
				</xsl:when>
				<xsl:otherwise>
				</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="/Procedimientos/PROCEDIMIENTOS/ROL='COMPRADOR'">
					<th class="textLeft w50px"><a href="javascript:Orden('OFERTAS');"><xsl:value-of select="document($doc)/translation/texts/item[@name='ofertas']/node()"/></a></th>
					<th class="textLeft w50px"><a href="javascript:Orden('ORDEN');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Orden']/node()"/></a></th>
				</xsl:if>
				<th class="textLeft w50px"><a href="javascript:Orden('CONSUMO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Consumo_hist']/node()"/></a></th>
				<th class="textLeft w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Valor_factura']/node()"/></th>
				<th class="textLeft w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Costo_neto']/node()"/></th>
				<th class="textLeft w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Valor_factura_hist']/node()"/></th>
				<th class="textLeft w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Costo_neto_hist']/node()"/></th>
				<th class="textLeft w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Mejor_valor_factura']/node()"/></th>
				<th class="textLeft w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Mejor_costo_neto']/node()"/></th>
				<th class="textLeft w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedor_actual']/node()"/></th>
				<th class="textLeft w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Prov_mejor_costo_neto']/node()"/></th>
				<th>&nbsp;</th>
			</tr>
		</thead>
		<!--	Cuerpo de la tabla	-->
		<tbody class="corpo_tabela">
        <xsl:choose>
		<xsl:when test="/Procedimientos/PROCEDIMIENTOS/PROCEDIMIENTO">
			<xsl:for-each select="/Procedimientos/PROCEDIMIENTOS/PROCEDIMIENTO">
				<xsl:variable name="IncID"><xsl:value-of select="ID"/></xsl:variable>
				<tr id="PRO_{LIC_CEL_ID}" class="con_hover">
					<xsl:choose>
					<xsl:when test="MODIFICADO_1HORA">
						<xsl:attribute name="class">fondoNaranja</xsl:attribute>
					</xsl:when>
					<xsl:when test="MODIFICADO_24HORAS">
						<xsl:attribute name="class">fondoAmarillo</xsl:attribute>
					</xsl:when>
					</xsl:choose>
                    <td class="color_status"><xsl:value-of select="LINEA"/></td>
					<td>
						<!--<a href="javascript:Procedimiento({/Procedimientos/PROCEDIMIENTOS/IDCONVOCATORIA},{LIC_CMP_IDESPECIALIDAD},{LIC_CMP_ID},{/Procedimientos/PROCEDIMIENTOS/IDPROVEEDOR});">-->
						<a href="javascript:Procedimiento({/Procedimientos/PROCEDIMIENTOS/IDCONVOCATORIA},{LIC_CMP_IDESPECIALIDAD},{LIC_CMP_ID});">
                    		<xsl:value-of select="LIC_CMP_REFERENCIA"/>
                        </a>
                    </td>
					<td class="textLeft fuentePeq"><xsl:value-of select="LIC_CMP_PROCEDIMIENTO"/></td>
					<xsl:choose>
					<xsl:when test="/Procedimientos/PROCEDIMIENTOS/CON_FILTRO_PROVEEDOR">
						<td class="textLeft fuentePeq"><xsl:value-of select="INFORMADO/USUARIO"/></td>
						<td class="textLeft fuentePeq"><xsl:value-of select="INFORMADO/FECHA"/></td>
					</xsl:when>
					<xsl:otherwise>
					</xsl:otherwise>
					</xsl:choose>
					<xsl:if test="/Procedimientos/PROCEDIMIENTOS/ROL='COMPRADOR'">
						<td class="textRight"><xsl:value-of select="LIC_CMP_NUMEROOFERTAS"/></td>
						<td>
							<xsl:choose>
							<xsl:when test="INFORMADO/LIC_CEP_ORDEN=1">
								<xsl:attribute name="class">textRight azul</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="class">textRight</xsl:attribute>
							</xsl:otherwise>
							</xsl:choose>
							<strong><xsl:value-of select="INFORMADO/LIC_CEP_ORDEN"/></strong>
						</td>
					</xsl:if>
					<td class="textRight"><xsl:value-of select="LIC_CMP_CONSUMOHISTORICO"/></td>
					<td>
						<xsl:choose>
						<xsl:when test="INFORMADO/PRECIOBASE_MEJORPRECIO">
							<xsl:attribute name="class">textRight azul</xsl:attribute>
						</xsl:when>
						<xsl:when test="INFORMADO/PRECIOBASE_MASBARATO">
							<xsl:attribute name="class">textRight verde</xsl:attribute>
						</xsl:when>
						<xsl:when test="INFORMADO/PRECIOBASE_MASCARO">
							<xsl:attribute name="class">textRight rojo</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="class">textRight</xsl:attribute>
						</xsl:otherwise>
						</xsl:choose>
						<strong>
							<xsl:value-of select="INFORMADO/LIC_CEP_PRECIOBASE"/>
						</strong>
						</td>
					<td class="textRight">
						<xsl:choose>
						<xsl:when test="INFORMADO/PRECIONETO_MEJORPRECIO">
							<xsl:attribute name="class">textRight azul</xsl:attribute>
						</xsl:when>
						<xsl:when test="INFORMADO/PRECIONETO_MASBARATO">
							<xsl:attribute name="class">textRight verde</xsl:attribute>
						</xsl:when>
						<xsl:when test="INFORMADO/PRECIONETO_MASCARO">
							<xsl:attribute name="class">textRight rojo</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="class">textRight</xsl:attribute>
						</xsl:otherwise>
						</xsl:choose>
						<strong>
							<xsl:value-of select="INFORMADO/LIC_CEP_PRECIOBONIFICADO"/>
						</strong>
					</td>
					<td class="textRight"><strong><xsl:value-of select="LIC_CMP_PRECIOREFERENCIA"/></strong></td>
					<td class="textRight"><strong><xsl:value-of select="LIC_CMP_PRECIOREFERENCIADESC"/></strong></td>
					<td class="textRight"><strong><xsl:value-of select="LIC_CMP_MEJORPRECIO"/></strong></td>
					<td class="textRight"><strong><xsl:value-of select="LIC_CMP_MEJORPRECIODESC"/></strong></td>
					<td class="textLeft"><a href="javascript:VerProveedor({IDPROVEEDOR_ACTUAL},'{LIC_CMP_REFERENCIA}');"><xsl:value-of select="PROVEEDOR_ACTUAL"/></a></td>
					<td class="textLeft"><a href="javascript:VerProveedor({IDPROVEEDOR_MEJORPRECIODESC},'{LIC_CMP_REFERENCIA}');"><xsl:value-of select="PROVEEDOR_MEJORPRECIODESC"/></a></td>
					<td>&nbsp;</td>
				</tr>
			</xsl:for-each>
                </xsl:when>
		<xsl:otherwise>
			<tr><td colspan="17" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_se_han_encontrado_resultados']/node()"/></strong></td></tr>
		</xsl:otherwise>
		</xsl:choose>
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="17">&nbsp;</td></tr>
		</tfoot>
	</table>
 	</div>
 	<br/>  
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
