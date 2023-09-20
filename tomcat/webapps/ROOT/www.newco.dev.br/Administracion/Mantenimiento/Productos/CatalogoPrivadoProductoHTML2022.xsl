<?xml version="1.0" encoding="iso-8859-1"?>
<!--
    Buscador de productos en catalogos privados
	Ultima revision: ET 27set22 16:26 CatalogoPrivadoProducto2022_261022.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:param name="usuario" select="@US_ID"/>
<xsl:template match="/">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
  <!--idioma-->
  <xsl:variable name="lang">
    <xsl:choose>
    <xsl:when test="/CatalogoPrivado/LANG"><xsl:value-of select="/CatalogoPrivado/LANG"/></xsl:when>
    <xsl:otherwise>spanish</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
  <!--idioma fin-->

  <title>
    <xsl:value-of select="document($doc)/translation/texts/item[@name='central_compras_material_sanitario']/node()"/>&nbsp;-&nbsp;
    <xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo_privado']/node()"/>&nbsp;-&nbsp;
    <xsl:value-of select="document($doc)/translation/texts/item[@name='medicalvm']/node()"/>
  </title>

	<link rel="shortcut icon" href="http://www.newco.dev.br/images/MedicalVM.ico"/>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoPrivadoProducto2022_261022.js"></script>
	<script type="text/javascript">
	var alrt_CambiarProductoEstandar	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cambiar_producto_estandar']/node()"/>';
	</script>

</head>

<body>
  <!--idioma-->
  <xsl:variable name="lang">
    <xsl:choose>
    <xsl:when test="/CatalogoPrivado/LANG"><xsl:value-of select="/CatalogoPrivado/LANG"/></xsl:when>
    <xsl:otherwise>spanish</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
  <!--idioma fin-->

  <xsl:choose>
	<!-- Error en alguna sentencia del XSQL -->
	<xsl:when test="CatalogoPrivado/xsql-error">
		<xsl:apply-templates select="CatalogoPrivado/xsql-error"/>
	</xsl:when>
	<xsl:otherwise>
		<!--	/AreaPublica	-->
		<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:value-of select="/CatalogoPrivado/CATALOGO/EMPRESA"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo_privado']/node()"/>
			<span class="CompletarTitulo" style="width:100px;">
				<a class="btnNormal" href="javascript:window.close();">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
				</a>
			</span>
		</p>
		</div>
		<br/>		
		<br/>		

		<!--<h1 class="titlePage"><xsl:value-of select="/CatalogoPrivado/CATALOGO/EMPRESA"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo_privado']/node()"/></h1>-->
		<form name="catalogo" method="post">
		<input type="hidden" id="IDEMPRESA" name="IDEMPRESA" value="{/CatalogoPrivado/CATALOGO/IDEMPRESA}"/>
		<input type="hidden" id="ORIGEN" name="ORIGEN" value="{/CatalogoPrivado/ORIGEN}"/>
		<input type="hidden" id="INPUT_SOL" name="INPUT_SOL" value="{/CatalogoPrivado/INPUT_SOL}"/>
		<input type="hidden" id="PAGINA" name="PAGINA" value="{/CatalogoPrivado/CATALOGO/FILTROS/PAGINA}"/>
		<input type="hidden" id="IDPROVEEDOR" name="IDPROVEEDOR" value="{/CatalogoPrivado/CATALOGO/FILTROS/IDPROVEEDOR}"/>
		<input type="hidden" id="IDDIVISA" name="IDDIVISA" value="{/CatalogoPrivado/CATALOGO/FILTROS/IDDIVISA}"/>

	<xsl:if test="/CatalogoPrivado/CATALOGO/FILTROS/IDPROVEEDOR!=''">
		<p style="font-size: 15px;">&nbsp;&nbsp;&nbsp;&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label>&nbsp;<strong><xsl:value-of select="/CatalogoPrivado/CATALOGO/FILTROS/PROVEEDOR"/></strong></p><BR/>
	</xsl:if >
	<xsl:if test="/CatalogoPrivado/CATALOGO/FILTROS/IDDIVISA!=''">	
		<p style="font-size: 15px;">&nbsp;&nbsp;&nbsp;&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='divisa']/node()"/>:</label>&nbsp;<strong><xsl:value-of select="/CatalogoPrivado/CATALOGO/FILTROS/DIVISA"/></strong></p>
	</xsl:if >
	<br/>		
	<br/>		
	<div class="tabela tabela_redonda">
	<table>
	<thead class="cabecalho_tabela">
        <xsl:choose>
        <xsl:when test="/CatalogoPrivado/CATALOGO/FILTROS/PUBLICO = 'N'"><!--si publico = N enseño tb ref cliente-->
        	<tr>
				<th class="w1px">&nbsp;</th>
            	<th style="width:150px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></th>
            	<th style="width:150px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
            	<th style="width:*;text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/></th>
				<xsl:choose>
        		<xsl:when test="/CatalogoPrivado/CATALOGO/GRUPODESTOCK">
					<th style="width:200px;">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Grupo_stock']/node()"/>
					</th>
				</xsl:when>
				<xsl:otherwise>
					<th style="width:1px;">&nbsp;</th>
				</xsl:otherwise>
				</xsl:choose>
            	<th>
					<xsl:attribute name="style">
						<xsl:choose>
       					<xsl:when test="/CatalogoPrivado/CATALOGO/GRUPODESTOCK">width:200px;</xsl:when>
						<xsl:otherwise>width:400px;</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>
				</th>
				<th style="width:300px;">&nbsp;</th>
				<th>&nbsp;</th>
			</tr>
			<tr>
				<th class="w1px">&nbsp;</th>
            	<th colspan="2">
					&nbsp;
            	  <xsl:choose>
            	  <xsl:when test="/CatalogoPrivado/REFERENCIA != '' and /CatalogoPrivado/IDEMPRESA != ''">
                	<input type="text" class="campopesquisa" id="REFERENCIA" name="REFERENCIA" maxlength="8" size="20" value="{/CatalogoPrivado/REFERENCIA}" />
            	  </xsl:when>
            	  <xsl:otherwise>
                	<input type="text" class="campopesquisa" id="REFERENCIA" name="REFERENCIA" maxlength="8" size="20" value="{/CatalogoPrivado/CATALOGO/FILTROS/REFERENCIA}" />
            	  </xsl:otherwise>
            	  </xsl:choose>
            	</th>
            	<th class="textLeft">
            	  <xsl:choose>
            	  <xsl:when test="/CatalogoPrivado/CATALOGO/FILTROS/DESCRIPCION != ''">
                	<input type="text" class="campopesquisa w300px" id="DESCRIPCION" name="DESCRIPCION" maxlength="50" value="{/CatalogoPrivado/CATALOGO/FILTROS/DESCRIPCION}" />
            	  </xsl:when>
            	  <xsl:when test="/CatalogoPrivado/CATALOGO/FILTROS/DESCRIPCION != ''">
                	<input type="text" class="campopesquisa w300px" id="DESCRIPCION" name="DESCRIPCION" maxlength="50" value="{/CatalogoPrivado/DESCRIPCION}" />
            	  </xsl:when>
            	  <xsl:otherwise>
                	<input type="text" class="campopesquisa w300px" id="DESCRIPCION" name="DESCRIPCION" maxlength="50" />
            	  </xsl:otherwise>
            	  </xsl:choose>
            	</th>
            	<th class="textLeft" colspan="4">
					<xsl:if test="/CatalogoPrivado/CATALOGO/GRUPODESTOCK">
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="/CatalogoPrivado/CATALOGO/GRUPODESTOCK/field"/>
						</xsl:call-template>&nbsp;
					</xsl:if>&nbsp;
              		<a class="btnDestacado" href="javascript:BuscarDesde0();"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/></a>
            	</th>
			</tr>
			<tr>
				<th class="w1px">&nbsp;</th>
				<th align="right">
					<xsl:if test="/CatalogoPrivado/CATALOGO/ANTERIOR">
						<a class="btnNormal" href="javascript:PaginaAnterior();"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
					</xsl:if>
				</th>
				<th colspan="4">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='lineas_por_pagina']/node()"/>:&nbsp;
					<xsl:call-template name="desplegable">
						<xsl:with-param name="id" value="LINEASPORPAGINA"/>
						<xsl:with-param name="path" select="/CatalogoPrivado/CATALOGO/LINEASPORPAGINA/field"/>
						<xsl:with-param name="onChange">javascript:Pagina0();</xsl:with-param>
					</xsl:call-template>&nbsp;&nbsp;&nbsp;
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='pagina']/node()"/>&nbsp;
					<xsl:value-of select="/CatalogoPrivado/CATALOGO/PAGINA_ACTUAL"/>&nbsp;
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
					<xsl:value-of select="/CatalogoPrivado/CATALOGO/TOTAL_PAGINAS"/>
				</th>
				<th>&nbsp;</th>
				<th align="left">
					<xsl:if test="/CatalogoPrivado/CATALOGO/SIGUIENTE">
						<a class="btnNormal" href="javascript:PaginaSiguiente();"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
					</xsl:if>
				</th>
			</tr>
        </xsl:when>
        <xsl:otherwise>
          <tr>
			<th class="w1px">&nbsp;</th>
            <th><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/><br/>
              <xsl:choose>
              <xsl:when test="/CatalogoPrivado/REFERENCIA != '' and /CatalogoPrivado/IDEMPRESA != ''">
                <input type="text" class="campopesquisa" id="REFERENCIA" name="REFERENCIA" maxlength="8" size="8" value="{/CatalogoPrivado/REFERENCIA}" />
              </xsl:when>
              <xsl:otherwise>
                <input type="text" class="campopesquisa" id="REFERENCIA" name="REFERENCIA" maxlength="8" size="8" value="{/CatalogoPrivado/CATALOGO/FILTROS/REFERENCIA}" />
              </xsl:otherwise>
              </xsl:choose>
            </th>
            <th><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/><br/>
				<input type="text" class="campopesquisa w300px" id="DESCRIPCION" name="DESCRIPCION" maxlength="50" size="50" value="{/CatalogoPrivado/CATALOGO/FILTROS/DESCRIPCION}"/>
            </th>
			<th>&nbsp;</th>
			<th><br />
            	<div class="botonEstrecho">
                <a class="btnDestacado" href="javascript:BuscarDesde0();"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/></a>
				</div>
			</th>
		  </tr>
        </xsl:otherwise>
        </xsl:choose>
      </thead>

		<tbody class="corpo_tabela">
				<!--	Cuerpo de la tabla	-->
        <xsl:choose>
        <xsl:when test="/CatalogoPrivado/CATALOGO/PRODUCTO_ESTANDAR"><!--si publico = N enseño tb ref cliente-->
        <xsl:for-each select="/CatalogoPrivado/CATALOGO/PRODUCTO_ESTANDAR">
          <tr class="conhover">
			<td class="color_status">&nbsp;</td>
            <td class="ref" align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!--valign="top"-->
              <!--si vengo de evaluacion-->
              <xsl:choose>
              <xsl:when test="/CatalogoPrivado/ORIGEN = 'EVALUACION'">
                <a href="javascript:InsertarPROEvaluacion('{REFERENCIA}')">
                  <xsl:value-of select="REFERENCIA"/>
                </a>
              </xsl:when>
              <xsl:when test="/CatalogoPrivado/ORIGEN = 'LICITACION'">
                <a href="javascript:InsertarPROLicitacion('{REFERENCIA}')">
                  <xsl:value-of select="REFERENCIA"/>
                </a>
              </xsl:when>
              <xsl:when test="/CatalogoPrivado/ORIGEN = 'SOLICITUD'">
                <a href="javascript:InsertarPROSolicitud('{REFERENCIA}','{//INPUT_SOL}')">
                  <xsl:value-of select="REFERENCIA"/>
                </a>
              </xsl:when>
              <xsl:when test="/CatalogoPrivado/ORIGEN = 'STOCK'">
                <a href="javascript:InsertarPROStock('{REFERENCIA}')">
                  <xsl:value-of select="REFERENCIA"/>
                </a>
              </xsl:when>
              <xsl:when test="/CatalogoPrivado/ORIGEN = 'PEDIDOSTEXTO'">
                <a href="javascript:InsertarPrepararPedidoTexto('{REFERENCIA}')">
                  <xsl:value-of select="REFERENCIA"/>
                </a>
              </xsl:when>
              <xsl:when test="/CatalogoPrivado/ORIGEN = 'MANTENPEDIDO'">
                <a href="javascript:InsertarMantenimientoPedido('{REFERENCIA}')">
                  <xsl:value-of select="REFERENCIA"/>
                </a>
              </xsl:when>
              <xsl:when test="/CatalogoPrivado/ORIGEN = 'PRODUCTOLIC'">
                <a href="javascript:SustituirProductoLicitacion('{ID}','{REFERENCIA}','{DESCRIPCION}','{MARCASACEPTABLES}')">
                  <xsl:value-of select="REFERENCIA"/>
                </a>
              </xsl:when>
              <xsl:otherwise>
                <!--si vengo de nuevo producto o manten producto o manten reducido-->
                <xsl:choose>
                <xsl:when test="/CatalogoPrivado/IDEMPRESA != ''">
                  <a href="javascript:InsertarMantenimientoReducido('{REFERENCIA}')">
                    <xsl:value-of select="REFERENCIA"/>
                  </a>
                </xsl:when>
                <xsl:otherwise>
                  <a href="javascript:InsertarPROManten('{REFERENCIA}','{PRECIOOBJETIVO}','{UNIDADBASICA}')">
                    <xsl:value-of select="REFERENCIA"/>
                  </a>
                </xsl:otherwise>
                </xsl:choose>
              </xsl:otherwise>
              </xsl:choose>
            </td>

            <xsl:if test="/CatalogoPrivado/CATALOGO/FILTROS/PUBLICO = 'N'">
              <td class="ref" align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <xsl:value-of select="REFCLIENTE"/>
              </td>
            </xsl:if>

            <td class="textLeft">
				<xsl:attribute name="colspan">
					<xsl:choose>
       				<xsl:when test="/CatalogoPrivado/CATALOGO/GRUPODESTOCK">1</xsl:when>
					<xsl:otherwise>2</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<xsl:value-of select="DESCRIPCION"/>&nbsp;&nbsp;&nbsp;
            </td>
        	<xsl:if test="/CatalogoPrivado/CATALOGO/GRUPODESTOCK">
				<td class="textLeft">
					&nbsp;<xsl:value-of select="GRUPODESTOCK"/>
				</td>
			</xsl:if>
			<td class="textLeft">
				&nbsp;<!--27set22 Si disponemos de la marca del producto, mostramos esta <xsl:value-of select="MARCASACEPTABLES"/>-->
				<xsl:choose>
       			<xsl:when test="PRO_MARCA"><xsl:value-of select="PRO_MARCA"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="MARCASACEPTABLES"/></xsl:otherwise>
				</xsl:choose>
            </td>

            <xsl:if test="/CatalogoPrivado/CATALOGO/FILTROS/PUBLICO = 'N'">
              <td class="ref" align="left">
			  	<xsl:if test="REFPROVEEDOR!=''">
                	<xsl:value-of select="REFPROVEEDOR"/>:&nbsp;<xsl:value-of select="PROVEEDOR"/>
				 </xsl:if>
              </td>
            </xsl:if>
			<td>&nbsp;</td>
          </tr>
		  </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
			<tr>
			<td class="color_status">&nbsp;</td>
			<td align="center" colspan="9">
			<br/>
			<br/>
			<strong>
        	<xsl:choose>
        	<xsl:when test="/CatalogoPrivado/CATALOGO/FILTROS/REFERENCIA != '' or /CatalogoPrivado/CATALOGO/FILTROS/DESCRIPCION != ''">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='no_se_han_encontrado_resultados']/node()"/>
        	</xsl:when>
        	<xsl:otherwise>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='aplique_filtro_para_buscar']/node()"/>
        	</xsl:otherwise>
        	</xsl:choose>
			</strong>
			<br/>
			<br/>
			</td>
			</tr>
        </xsl:otherwise>
        </xsl:choose>
		</tbody>
		<tfoot class="rodape_tabela">
			<td colspan="8">&nbsp;</td>
		</tfoot>
      </table>
	  </div>
	</form>

    <!--form de mensaje de error de js-->
    <form name="mensajeJS">
      <input type="hidden" name="REF_YA_INSERTADA" value="{document($doc)/translation/texts/item[@name='ref_ya_insertada']/node()}"/>
    </form>

  </xsl:otherwise>
  </xsl:choose>
  <br/>
</body>
</html>
</xsl:template>

<xsl:template match="Sorry">
  <xsl:apply-templates select="Noticias/ROW/Sorry"/>
</xsl:template>
</xsl:stylesheet>
