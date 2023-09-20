<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Informe/resumen de pedidos activos.Nuevo disenno 2022. WFStatus2022_170223.js
	Ultima revision 27may22 15:06
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="usuario" select="@US_ID"/>

<xsl:template match="/InformePedidos">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

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

	<meta http-equiv="Cache-Control" Content="no-cache"/>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
 	<script type="text/javascript" src="http://www.newco.dev.br/Personal/BandejaTrabajo/WFStatus2022_170223.js"></script>
    <script type="text/javascript" src="http://www.newco.dev.br/Personal/BandejaTrabajo/cargaDoc.js"></script>
  
</head>
<body>
	<!--onLoad="javascript:EliminaCookies();"-->
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<form  method="post" name="Form1" id="Form1" action="WFStatusSave.xsql">
	<input type="hidden" name="IDOFERTA"/>
	<input type="hidden" name="IDMOTIVO"/>
	<input type="hidden" name="FECHAPEDIDO"/>
	<input type="hidden" name="NUEVAFECHAENTREGA"/>
	<input type="hidden" name="FECHAACTUAL" value="{/InformePedidos/PEDIDOSPROBLEMATICOS/FECHAACTUAL}"/>
	<input type="hidden" name="COMENTARIOS"/>
	<input type="hidden" name="BLOQUEADO"/>
	<input type="hidden" name="NOCUMPLEPEDMIN"/>
	<input type="hidden" name="FARMACIA"/>
	<input type="hidden" name="MATERIAL"/>
	<input type="hidden" name="SINSTOCKS"/>
    <input type="hidden" name="TODOS12MESES"/>
    <input type="hidden" name="INCFUERAPLAZO"/>
    <input type="hidden" name="PED_ENTREGADOOK"/>
    <input type="hidden" name="PED_PEDIDONOCOINCIDE"/>
    <input type="hidden" name="PED_RETRASADO"/>
    <input type="hidden" name="PED_ENTREGADOPARCIAL"/>
    <input type="hidden" name="PED_NOINFORMADOENPLATAFORMA"/>
    <input type="hidden" name="PED_PRODUCTOSANYADIDOS"/>
    <input type="hidden" name="PED_PRODUCTOSRETIRADO"/>
    <input type="hidden" name="PED_MALAATENCIONPROV"/>
    <input type="hidden" name="PED_URGENTE"/>
    <input type="hidden" name="PED_RETRASODOCTECNICA"/>
    <input type="hidden" name="ALBARAN"/>
    <input type="hidden" name="IDALBARAN"/>
    <!--subir documentos-->
    <input type="hidden" name="CADENA_DOCUMENTOS" />
    <input type="hidden" name="DOCUMENTOS_BORRADOS"/>
    <input type="hidden" name="BORRAR_ANTERIORES"/>
    <input type="hidden" name="ID_USUARIO" />
    <input type="hidden" name="TIPO_DOC" value="ALBARAN"/>
    <input type="hidden" name="DOC_DESCRI" />
    <input type="hidden" name="REMOVE" value="{document($doc)/translation/texts/item[@name='remove']/node()}"/>
    <input type="hidden" name="CHANGE_PROV" />
    <input type="hidden" name="IDPROVEEDOR_ALB" value="{EMP_ID}" />
            
	<xsl:choose>
	<!-- Error en alguna sentencia del XSQL -->
	<xsl:when test="INICIO/xsql-error">
		<xsl:apply-templates select="INICIO/xsql-error"/>
	</xsl:when>
	<xsl:when test="INICIO/SESION_CADUCADA">
		<xsl:for-each select="INICIO/SESION_CADUCADA">
			<xsl:if test="position()=last()">
				<xsl:apply-templates select="."/>
			</xsl:if>
		</xsl:for-each>
	</xsl:when>
	<xsl:otherwise>
        <xsl:call-template name="estiloIndip"/>		

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
        		<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_activos']/node()"/>.&nbsp;
				<!--27may22 la condicion deberia aplicarse en el PL/SQL
				<xsl:if test="/InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN='MVM' or /InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN='CDC' or /InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN='EMPRESA' or /InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/ADMIN='MULTICENTROS'">-->
				<xsl:choose>
				<xsl:when test="/InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDEMPRESA">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:&nbsp;
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDEMPRESA/field"/>
						<xsl:with-param name="onChange">javascript:ResumenPedidos();</xsl:with-param>
						<xsl:with-param name="claSel">w300px</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="IDEMPRESA" value="{IDEMPRESA}" />
				</xsl:otherwise>
				</xsl:choose>
				<span class="CompletarTitulo">
				</span>
			</p>
		</div>
		<br/>
		<br/>
		<table cellspacing="6px" cellpadding="6px">
			<xsl:variable name="BuscAvanzStyle">
				<xsl:choose>
				<xsl:when test="/InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/URGENTE = 'S' or /InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/BLOQUEADO = 'S' or /InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/FARMACIA = 'S' or /InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/MATERIALSANITARIO = 'S' or /InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/SINSTOCKS = 'S' or /InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/TODOS12MESES = 'S' or /InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/INCFUERAPLAZO = 'S' or /InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/PEDIDOOK = 'S' or /InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/ENTR_RETRASADO = 'S' or /InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/PEDIDONOCOINCIDE = 'S' or /InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/ENTR_PARCIAL = 'S' or /InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/RETRASODOCUMTEC = 'S' or /InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/NOINFORMADOPLAT = 'S' or /InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/PROD_ANYADIDOS = 'S' or /InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/PROD_RETIRADOS = 'S' or /InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/MALAATENCIONPROV = 'S' or /InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/FECHAINICIO != '' or /InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/FECHAFINAL != ''"></xsl:when>
				<xsl:otherwise>display:none;</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<tr>
				<td class="w40px">&nbsp;</td>
				<xsl:choose>
				<xsl:when test="/InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDCENTRO">
					<td class="w200px">
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:</label><br />
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="/InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDCENTRO/field"/>
							<xsl:with-param name="claSel">w200px</xsl:with-param>
						</xsl:call-template>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="IDCENTRO" value="{IDCENTRO}" />
				</xsl:otherwise>
				</xsl:choose>
				<td class="w200px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDPROVEEDOR/field"/>
						<xsl:with-param name="claSel">w200px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="w200px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/>:</label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDFILTRORESPONSABLE/field"/>
						<xsl:with-param name="claSel">w200px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="w160px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='situacion']/node()"/>:</label><br />
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/FILTROS/IDFILTROSEMAFORO/field"/>
						<xsl:with-param name="claSel">w160px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td class="w160px textLeft">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:</label><br />
					<input class="campopesquisa w160px" type="text" name="PRODUCTO" maxlength="40" value="{/InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/PRODUCTO}"/>
				</td>
				<td class="w100px">
					<br/>
       				<a href="javascript:VerBuscadorAvanzado();" title="Buscador avanzado" class="btnNormal">
						[<xsl:value-of select="document($doc)/translation/texts/item[@name='AVANZADO']/node()"/>]
        			</a>
				</td>
				<td class="w70px textLeft">
					<br/>
					<a href="javascript:ResumenPedidos();" title="Buscar" class="btnDestacado">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Resumen']/node()"/>
					</a>
				</td>
				<td class="w70px textLeft">
					<br/>
					<a href="javascript:FiltrarBusqueda();" title="Buscar" class="btnDestacado">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>
					</a>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
			<td colspan="11" border="1" class="buscadorAvanzado" style="display:none"> 
				<table class="tbBuscAvanzado">
    			<tr id="buscadorAvanzadoOne" class="selectAva buscadorAvanzado sinLinea" height="40">
    			  <th>&nbsp;</th>
    			  <th style="text-align:left;">
        			<!--fecha inicio-->
        			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_inicio']/node()"/>:</label>&nbsp;
        			<input type="text" name="FECHA_INICIO" value="{INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FECHAINICIO}" size="9" />
    			  </th>
    				<th style="text-align:left;">
        			<!--fecha final-->
        			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_final']/node()"/>:</label>&nbsp;
        			<input type="text" name="FECHA_FINAL" value="{INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/FECHAFINAL}"  size="9"  />
    			  </th>
    			  <th style="text-align:left;">
	  				&nbsp;
    			  </th>
    			  <th style="text-align:left;">
					<!--pedido entregado ok-->
					<input class="muypeq" type="checkbox" name="PED_ENTREGADOOK_CHECK">
					<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PEDIDOOK = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
					</input>&nbsp;
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='entrega_ok']/node()"/></label>
    			  </th>
    			  <th style="text-align:left;">
					<!--pedido retrasado-->
					<input class="muypeq" type="checkbox" name="PED_RETRASADO_CHECK">
						<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ENTR_RETRASADO = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
					</input>&nbsp;
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ped_retrasado']/node()"/></label>
    			  </th>
    			  <th style="text-align:left;">
					<!--pedido parcial-->
					<input class="muypeq" type="checkbox" name="PED_ENTREGADOPARCIAL_CHECK">
						<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/ENTR_PARCIAL = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
					</input>&nbsp;
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ped_parcial']/node()"/></label>
    			  </th>
    			  <th>&nbsp;</th>
    			</tr>

    			<tr id="buscadorAvanzadoTwo" class="selectAva buscadorAvanzado sinLinea" height="40">
    			  <th>&nbsp;</th>
    				<th style="text-align:left;">
					<!--pedido no informado en la plataforma mvm-->
					<input class="muypeq" type="checkbox" name="PED_NOINFORMADOENPLATAFORMA_CHECK">
						<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/NOINFORMADOPLAT = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
					</input>&nbsp;
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='no_info_sistema']/node()"/></label>
    			  </th>
    			  <th style="text-align:left;">
        			<!--ped no coincide-->
					<input class="muypeq" type="checkbox" name="PED_PEDIDONOCOINCIDE_CHECK">
						<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PEDIDONOCOINCIDE = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
					</input>&nbsp;
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ped_no_coincide']/node()"/></label>
    			  </th>
    			  <th style="text-align:left;">
        			<!--pedido con productos a?adidos-->
					<input class="muypeq" type="checkbox" name="PED_PRODUCTOSANYADIDOS_CHECK">
						<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PROD_ANYADIDOS = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
					</input>&nbsp;
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='prod_anadidos']/node()"/></label>
    			  </th>
    			  <th style="text-align:left;">
        			<!--pedido con productos retirados-->
					<input class="muypeq" type="checkbox" name="PED_PRODUCTOSRETIRADO_CHECK">
						<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/PROD_RETIRADOS = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
					</input>&nbsp;
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='prod_retirados']/node()"/></label>
    			  </th>
    			  <th style="text-align:left;">
					<!--pedido con problemas en la documentacion tecnica-->
					<input class="muypeq" type="checkbox" name="PED_RETRASODOCTECNICA_CHECK">
						<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/RETRASODOCUMTEC = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
					</input>&nbsp;
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='prob_doc_tecnica']/node()"/></label>
    			  </th>
    			  <th style="text-align:left;">
					<!--incidencia fuera de plazo-->
					<input class="muypeq" type="checkbox" name="INCFUERAPLAZO_CHECK">
						<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/INCFUERAPLAZO = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
					</input>&nbsp;
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='inc_ped_cerrado']/node()"/></label>
    			  </th>
    			  <th>&nbsp;</th>
    			</tr>

    			<tr id="buscadorAvanzadoThree" class="selectAva buscadorAvanzado" height="40">
				  <th>&nbsp;</th>
    			  <th style="text-align:left;">
					<!--pedido no informado en la plataforma mvm-->
					<input class="muypeq" type="checkbox" name="PED_URGENTE_CHECK">
						<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/URGENTE = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
					</input>&nbsp;
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='urgente']/node()"/></label>
    			  </th>
    			  <th style="text-align:left;">
					<!--bloqueado check-->
					<input class="muypeq" type="checkbox" name="BLOQUEADO_CHECK">
						<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BLOQUEADO = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
					</input>&nbsp;
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='bloqueados']/node()"/></label>
    			  </th>
    			  <th style="text-align:left;">
					<!--material check-->
					<input class="muypeq" type="checkbox" name="NOCUMPLEPEDMIN_CHECK">
						<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/NOCUMPLEPEDMIN = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
					</input>&nbsp;
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='no_cumple_ped_min']/node()"/></label>
    			  </th>
    			  <th style="text-align:left;">
					<!--sin stock check-->
					<input class="muypeq" type="checkbox" name="SINSTOCKS_CHECK">
						<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/SINSTOCKS = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
					</input>&nbsp;
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='sin_stock']/node()"/></label>
					</th>
    			  <th style="text-align:left;">
					<!--proveedor no atiende bien-->
					<input class="muypeq" type="checkbox" name="PED_MALAATENCIONPROV_CHECK">
						<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/MALAATENCIONPROV = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
					</input>&nbsp;
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='mala_atencion_prov']/node()"/></label>
    			  </th>
    			  <th style="text-align:left;">
					<!--proveedor no atiende bien-->
					<input class="muypeq" type="checkbox" name="BUSCAR_PACKS_CHECK">
						<xsl:if test="INICIO/PEDIDOSPROBLEMATICOS/COMPRADOR/BUSCAR_PACKS = 'S'"><xsl:attribute name="checked">true</xsl:attribute></xsl:if>
					</input>&nbsp;
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='busca_packs']/node()"/></label>
    			  </th>
    			  <th>&nbsp;</th>
    			</tr>
				</table>
    		</td>
    		</tr>
		
			<tr>
				<td colspan="12">
					<!--	tabla de resultados		-->
					<div class="tabela tabela_redonda">
					<table class="tableCenter" cellspacing="6px" cellpadding="6px">
						<thead class="cabecalho_tabela">
						<tr>
							<th class="w1x"></th>
    						<th><xsl:value-of select="document($doc)/translation/texts/item[@name='indicador']/node()"/></th>
							<xsl:for-each select="/InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/RESUMEN_PEDIDOS_POR_CENTRO/CENTROS/COL">
								<th class="w200px"><xsl:value-of select="."/></th>
							</xsl:for-each>
							<th class="w20x"></th>
    					</tr>
						</thead>
						<!--	Cuerpo de la tabla	-->
						<tbody class="corpo_tabela">
						<xsl:for-each select="/InformePedidos/PEDIDOSPROBLEMATICOS/COMPRADOR/RESUMEN_PEDIDOS_POR_CENTRO/FILA">
 							<tr>
								<td class="color_status">&nbsp;</td>
   								<td class="textLeft"><xsl:value-of select="NOMBRE"/></td>
								<xsl:for-each select="COL">
   									<td class="textRight"><xsl:value-of select="."/></td>
								</xsl:for-each>
								<td>&nbsp;</td>
							</tr>
						</xsl:for-each>
						</tbody>
						<tfoot class="rodape_tabela">
							<tr><td colspan="20">&nbsp;</td></tr>
						</tfoot>
					</table><!--fin de infoTableAma-->
 					<br/>  
 					<br/>  
 					<br/>  
 					<br/>  
 					<br/>  
 					<br/>  
 					<br/>  
 					</div>
				</td>
			</tr>
		
		</table>
		<div class="divLeft">
		</div>
    </xsl:otherwise>
    </xsl:choose>
	</form>
 </body>
</html>
</xsl:template>

</xsl:stylesheet>
