<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Convocatorias especiales: buscador de productos. Nuevo disenno 2022. 
	Ultima revision ET 26may22 12:00 BuscadorProductos2022_230522.js
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

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatorias']/node()"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProductos2022_230522.js"></script>
	<script type="text/javascript">
		var alrt_errorDescargaFichero	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_descarga_fichero']/node()"/>';
	</script>
</head>

<body onLoad="javascript:Inicio();">
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
		<p class="TituloPagina">
			<xsl:value-of select="/Productos/PRODUCTOS/CONVOCATORIA"/>
			&nbsp;&nbsp;
			<span class="fuentePeq">(<xsl:value-of select="/Productos/PRODUCTOS/TOTAL"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>.&nbsp;
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='pagina']/node()"/>&nbsp;
				<xsl:value-of select="/Productos/PRODUCTOS/PAGINA_ACTUAL"/>&nbsp;
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
				<xsl:value-of select="/Productos/PRODUCTOS/TOTAL_PAGINAS"/>)
			</span>
			<span class="CompletarTitulo400">
				<a class="btnNormal" href="javascript:DescargarExcel();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/>
				</a>&nbsp;
				<a class="btnNormal" href="javascript:VerProcedimientos('');">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Procedimientos']/node()"/>
				</a>&nbsp;
				<!--	Botones	anterior y siguiente-->
				<xsl:if test="/Productos/PRODUCTOS/ANTERIOR">
					&nbsp;<a class="btnNormal" href="javascript:PaginaAnterior();"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
				</xsl:if>
				<xsl:if test="/Productos/PRODUCTOS/SIGUIENTE">
					&nbsp;<a class="btnNormal" href="javascript:PaginaSiguiente();"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>
	
	
	<div class="divLeft">
		<form name="Buscador" method="post" action="http://www.newco.dev.br/ProcesosCdC/ConvocatoriasEspeciales/BuscadorProductos2022.xsql">
        <input type="hidden" name="PAGINA" id="PAGINA" value="{/Productos/PRODUCTOS/PAGINA}"/>
        <input type="hidden" name="ORDEN" id="ORDEN" value="{/Productos/PRODUCTOS/ORDEN}"/>
        <input type="hidden" name="FIDCONVOCATORIA" id="FIDCONVOCATORIA" value="{/Productos/PRODUCTOS/IDCONVOCATORIA}"/>
		<table  cellspacing="6px" cellpadding="6px">
			<tr>
			<!--CONVOCATORIA-->
			<td class="w40px">&nbsp;</td>
			<!--
			<td class="textLeft w300px">
        	<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Convocatoria']/node()"/></label><br />
        	<xsl:call-template name="desplegable">
            	<xsl:with-param name="path" select="/Productos/PRODUCTOS/FIDCONVOCATORIA/field"/>
            	<xsl:with-param name="defecto" select="/Productos/PRODUCTOS/FIDCONVOCATORIA/field/@current"/>
            	<xsl:with-param name="claSel">w300px</xsl:with-param>
        	</xsl:call-template>
			</td>
			-->
    		<xsl:if test="/Productos/PRODUCTOS/MVM or /Productos/PRODUCTOS/MVMB or /Productos/PRODUCTOS/ROL = 'COMPRADOR'">
				<td class="textLeft w300px">
        		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></label><br />
        		<xsl:call-template name="desplegable">
            		<xsl:with-param name="path" select="/Productos/PRODUCTOS/FIDPROVEEDOR/field"/>
            		<xsl:with-param name="defecto" select="/Productos/PRODUCTOS/FIDPROVEEDOR/field/@current"/>
            		<xsl:with-param name="claSel">w300px</xsl:with-param>
        		</xsl:call-template>
				</td>
    		</xsl:if>
			<td class="textLeft w200px">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/></label><br />
				<input type="text" class="campopesquisa w200px" name="FTEXTO" size="10" id="FTEXTO" >
					<xsl:attribute name="value"><xsl:value-of select="/Productos/PRODUCTOS/FTEXTO"/></xsl:attribute>
				</input>
			</td>
			<td class="textLeft w200px">
				<label><xsl:copy-of select="document($doc)/translation/texts/item[@name='lineas_por_pagina']/node()"/></label><br />
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/Productos/PRODUCTOS/LINEASPORPAGINA/field"/>
					<xsl:with-param name="onChange">javascript:Buscar();</xsl:with-param>
 		           	<xsl:with-param name="claSel">w200px</xsl:with-param>
				</xsl:call-template>
			</td>
			<td class="textLeft w140px">
				<br/>
				<a class="btnDestacado" href="javascript:Buscar();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
				</a>
			</td>
			<td>&nbsp;</td>
			</tr>
		</table>
		</form>

		<div id="EvalBorradaOK" style="display:none;background:#CEF6CE;padding:5px;width:400px;color:#333;text-align:center;border:1px solid #01DF01;margin:10px auto;"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_evaluacion_OK']/node()"/></div>
		<div id="EvalBorradaKO" style="display:none;background:#F8E0E6;padding:5px;width:400px;color:#333;text-align:center;border:1px solid red;margin:10px auto;"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_evaluacion_KO']/node()"/></div>

		<br/>
		<div class="tabela tabela_redonda">
		<table cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
			<tr>
				<th class="w1px"></th>
				<th class="textLeft w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/></th>
				<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
				<th class="textLeft w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Medida']/node()"/></th>
				<th class="textLeft w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></th>
				<th class="textLeft w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Fabricante']/node()"/></th>
				<th class="textLeft w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/></th>
				<th class="textLeft w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_lote']/node()"/></th>
				<th class="textLeft w130px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Clasificacion']/node()"/></th>
				<!--<th class="textLeft w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Cod_Invima']/node()"/></th>
				<th class="textLeft w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_Limite']/node()"/></th>
				<th class="textLeft w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Clas_Riesgo']/node()"/></th>-->
				<th class="textLeft w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ud_basica']/node()"/></th>
				<th class="textLeft w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/></th>
				<th class="textLeft w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Descuento']/node()"/></th>
				<th class="textLeft w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Bonificacion']/node()"/></th>
				<th>&nbsp;</th>
			</tr>
		</thead>
		<!--	Cuerpo de la tabla	-->
		<tbody class="corpo_tabela">
        <xsl:choose>
		<xsl:when test="/Productos/PRODUCTOS/PRODUCTO">
			<xsl:for-each select="/Productos/PRODUCTOS/PRODUCTO">
				<xsl:variable name="IncID"><xsl:value-of select="ID"/></xsl:variable>
				<tr id="PRO_{LIC_CEL_ID}">
					<xsl:choose>
					<xsl:when test="MODIFICADO_1HORA">
						<xsl:attribute name="class">con_hover fondoNaranja</xsl:attribute>
					</xsl:when>
					<xsl:when test="MODIFICADO_24HORAS">
						<xsl:attribute name="class">con_hover fondoAmarillo</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="class">con_hover</xsl:attribute>
					</xsl:otherwise>
					</xsl:choose>
                    <td class="color_status"><xsl:value-of select="LINEA"/></td>
					<td class="textLeft">
						<a class="refProducto" href="javascript:IncluirEnPaginaPrincipal('{LIC_CEL_REFERENCIA}');">
                    		<xsl:value-of select="LIC_CEL_REFERENCIA"/>
                        </a>
                    </td>
					<td class="textLeft"><xsl:value-of select="LIC_CEL_PRODUCTO"/></td>
					<td class="textLeft"><xsl:value-of select="LIC_CEL_MEDIDA"/></td>
					<td class="textLeft"><xsl:value-of select="LIC_CEL_MARCA"/></td>
					<td class="textLeft"><xsl:value-of select="LIC_CEL_FABRICANTE"/></td>
					<td class="textLeft"><xsl:value-of select="LIC_CEL_UNIDADBASICA"/></td>
					<td class="textRight"><xsl:value-of select="LIC_CEL_UNIDADESPORLOTE"/></td>
					<td class="textLeft">
						<xsl:value-of select="LIC_CEL_CLASIFICACION"/>
						<img src="http://www.newco.dev.br/images/2017/info.png" class="valignM">
						<xsl:attribute name="title">
<xsl:value-of select="document($doc)/translation/texts/item[@name='Cod_Invima']/node()"/>:<xsl:value-of select="LIC_CEL_REGISTROINVIMA"/>.&nbsp;
<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_Limite']/node()"/>:<xsl:value-of select="LIC_CEL_FECHAVENCINVIMA"/>.&nbsp;
<xsl:value-of select="document($doc)/translation/texts/item[@name='Clas_Riesgo']/node()"/>:<xsl:value-of select="LIC_CEL_CLASRIESGO"/>.
						</xsl:attribute>
						</img>
					</td>
					<!--<td class="textLeft"><xsl:value-of select="LIC_CEL_REGISTROINVIMA"/></td>
					<td><xsl:value-of select="LIC_CEL_FECHAVENCINVIMA"/></td>
					<td class="textLeft"><xsl:value-of select="LIC_CEL_CLASRIESGO"/></td>-->
					<td class="textRight"><xsl:value-of select="LIC_CEL_PRECIO"/></td>
					<td class="textRight"><xsl:value-of select="LIC_CEL_TIPOIVA"/></td>
					<td class="textRight"><xsl:value-of select="LIC_CEL_DESCUENTOCOMERCIAL"/></td>
					<td class="textRight"><xsl:value-of select="LIC_CEL_BONIFICACION"/></td>
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
    </div>
	</xsl:otherwise>
	</xsl:choose>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
