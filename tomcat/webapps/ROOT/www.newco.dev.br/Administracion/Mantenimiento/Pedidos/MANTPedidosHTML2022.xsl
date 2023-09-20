<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Mantenimiento de pedido. Nuevo disenno 2022.
	Ultima revision: ET 17ago23 15:48 MANTPedidos2022_170823.js
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
		<xsl:when test="/MantenimientoPedidos/LANG"><xsl:value-of select="/MantenimientoPedidos/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Pedidos/MANTPedidos2022_170823.js"></script>

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_pedidos']/node()"/>:&nbsp;<xsl:value-of select="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/PED_NUMEROCLINICA"/>&nbsp;<xsl:value-of select="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/CENTROCLIENTE"/></title>

	<script type="text/javascript">
		var IDMultioferta ='<xsl:value-of select="/MantenimientoPedidos/MO_ID" />';
		var IDEmpresa ='<xsl:value-of select="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/MO_IDCLIENTE" />';
		var derManten =('<xsl:value-of select="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/MANTENIMIENTO_AVANZADO" />'=='S')?'S':'N';
		var justifObligat ='<xsl:choose><xsl:when test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/JUSTIFICACION_OBLIGATORIA">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		var derPrecios ='<xsl:choose><xsl:when test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/MANTENIMIENTO_PRECIOS">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		var alrt_MotivoBorrarObligatorio = '<xsl:value-of select="document($doc)/translation/texts/item[@name='motivo_borrar_obl']/node()"/>';
		var alrt_RequiereMotivo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_requiere_motivo_cambio']/node()"/>';
		var permitirManten ='<xsl:choose><xsl:when test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/PERMITIR_MANTENIMIENTO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';
		var alrt_YaExisteEnPedido	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='Error_ya_existe_en_pedido']/node()"/>';
	
	var arrProductos = new Array();
	<xsl:for-each select="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/LINEASPEDIDO/LINEAPEDIDO">	
		
		var ref=[];
		ref["Referencia"]='<xsl:value-of select="REFPRIVADA" />';
		ref["Nombre"]='<xsl:value-of select="NOMBRE_JS" />';
		
		arrProductos.push(ref);	
	</xsl:for-each>	

	</script>
</head>
<body class="gris" onload="javascript:onLoad();">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/MantenimientoPedidos/LANG"><xsl:value-of select="/MantenimientoPedidos/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<form action="MANTPedidosSave2022.xsql" method="POST" name="frmMantenPedido">
		<input type="hidden" id="ACCION" name="ACCION"/>
		<input type="hidden" id="PARAMETROS" name="PARAMETROS"/>
		<input type="hidden" name="IDLINEAPEDIDO"/>
		<input type="hidden" name="IDCLIENTE" value="{/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/MO_IDCLIENTE}"/>
		<input type="hidden" name="IDPROVEEDOR" value="{/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/MO_IDPROVEEDOR}"/>
		<input type="hidden" name="OCULTAR"/>
		<input type="hidden" name="PEDIDO_MINIMO" value="{/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/MO_PROV_PEDIDOMINIMO_SF}"/>
		<input type="hidden" name="MANT_AVANZADO" value="{/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/MANTENIMIENTO_AVANZADO}"/>

	<xsl:choose>
	<!-- ET Desactivado control errores: Habra que reactivarlo -->
	<xsl:when test="MantenimientoPedidos/xsql-error">
		<xsl:apply-templates select="Noticias/xsql-error"/>
	</xsl:when>
	<xsl:when test="MantenimientoPedidos/ROW/Sorry">
		<xsl:apply-templates select="Noticias/ROW/Sorry"/>
	</xsl:when>
	<xsl:otherwise>
		<xsl:value-of select="@TIPO"/>

 		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
 				<xsl:value-of select="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/PED_NUMEROCLINICA"/>&nbsp;<xsl:value-of select="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/CENTROCLIENTE"/>
				&nbsp;(<xsl:value-of select="MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/ESTADO"/>)
                &nbsp;<span style="background-color:yellow;">MO_ID:<xsl:value-of select="MantenimientoPedidos/MANTENIMIENTO/MO_ID"/></span>&nbsp;
				<span class="CompletarTitulo w700px">
					<a class="btnNormal">
            			<xsl:attribute name="href">javascript:VerPedido('<xsl:value-of select="/MantenimientoPedidos/MANTENIMIENTO/MO_ID"/>');</xsl:attribute>
            			<xsl:value-of select="document($doc)/translation/texts/item[@name='ver_pedido']/node()"/>&nbsp;
					</a>
					&nbsp;
            		<!--si es un pedido rechazado (que no tiene lineas de pedido) no retrocedemos si no fallan los datos
					Retrocederemos mediante desplegable de estados válidos
            		<xsl:if test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/RETROCEDER_PEDIDO">
						<a class="btnDestacado" href="javascript:RetrocederPedido(document.forms['frmMantenPedido']);">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Retroceder_pedido']/node()"/>&nbsp;</a>
					&nbsp;
            		</xsl:if>
					-->
					<a class="btnNormal" href="javascript:VerTodosDocumentos({/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/MO_ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/></a>
					&nbsp;
					<xsl:if test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/PED_ID">
						<a class="btnDestacado" href="javascript:GenerarPDF();"><xsl:value-of select="document($doc)/translation/texts/item[@name='generar_pdf']/node()"/></a>
						&nbsp;
            			<xsl:if test="MantenimientoPedidos/LANG = 'spanish'">
							<a class="btnDestacado btnActualizar" href="javascript:Actualizar('ACTUALIZARIVA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar_iva']/node()"/></a>
            			</xsl:if>
					</xsl:if>
				</span>
			</p>
		</div>
      
		<div class="divLeft">
			<table cellspacing="6px" cellpadding="6px">
			<tbody>
				<tr class="sinLinea"><td colspan="2">&nbsp;</td></tr>
				<tr class="sinLinea" id="BLOQUEADO" style="display:none"><td colspan="2"><span class="avisoFondoDestacado"><xsl:value-of select="document($doc)/translation/texts/item[@name='Pedido_bloqueado_descargado_ERP']/node()"/></span></td></tr>
				<tr class="sinLinea"><td colspan="2">&nbsp;</td></tr>
				<tr class="sinLinea">
					<td class="labelRight">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>:&nbsp;</td>
					<td class="textLeft w500px">
 						<xsl:call-template name="desplegable"> 
						<xsl:with-param name="id" value="IDESTADO"/>
						<xsl:with-param name="path" select="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/ESTADOS/field" />
						<xsl:with-param name="claSel">w500px txtActualizar</xsl:with-param>
						</xsl:call-template> 
					</td>
					<td class="textLeft">
						<a class="btnDestacado btnActualizar" href="javascript:Actualizar('CAMBIAR_ESTADO')">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar']/node()"/>
						</a>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr class="sinLinea">
					<td class="labelRight trenta">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='lugar_entrega']/node()"/>:&nbsp;</td>
					<td class="textLeft">
 						<xsl:call-template name="desplegable"> 
						<xsl:with-param name="id" value="IDLUGARENTREGA"/>
						<xsl:with-param name="path" select="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/LUGARESENTREGA/field" />
						<xsl:with-param name="claSel">w500px txtActualizar</xsl:with-param>
						</xsl:call-template> 
					</td>
					<td class="textLeft">
						<a class="btnDestacado btnActualizar" href="javascript:Actualizar('LUGAR_ENTREGA')">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar']/node()"/>
						</a>
					</td>
					<td class="quince">&nbsp;</td>
				</tr>
				<xsl:if test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/CENTROSCONSUMO">
				<tr class="sinLinea">
					<td class="labelRight trenta">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_consumo']/node()"/>:&nbsp;</td>
					<td class="textLeft">
 						<xsl:call-template name="desplegable"> 
						<xsl:with-param name="id" value="IDCENTROCONSUMO"/>
						<xsl:with-param name="path" select="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/CENTROSCONSUMO/field" />
						<xsl:with-param name="claSel">w500px txtActualizar</xsl:with-param>
						</xsl:call-template> 
					</td>
					<td class="textLeft">
						<a class="btnDestacado btnActualizar" href="javascript:Actualizar('CENTRO_CONSUMO')">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar']/node()"/>
						</a>
					</td>
					<td class="quince">&nbsp;</td>
				</tr>
				</xsl:if>
				<tr class="sinLinea">
					<td class="labelRight">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:&nbsp;</td>
					<td class="textLeft" colspan="3">
						<strong><xsl:value-of select="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/MO_NOMBREPROVEEDOR"/></strong>&nbsp;
						<xsl:if test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/MO_PROV_PEDIDOMINIMO and /MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/MO_PROV_PEDIDOMINIMO!=''">
							(<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo_de']/node()"/>&nbsp;
							<xsl:value-of select="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/MO_PROV_PEDIDOMINIMO"/>
							<xsl:value-of select="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/DIVISA/SUFIJO"/>)
						</xsl:if>
					</td>
				</tr>
				<input type="hidden" id="MO_ID" name="MO_ID">
					<xsl:attribute name="value">
						<xsl:choose>
						<xsl:when test="/MantenimientoPedidos/MO_ID != ''"><xsl:value-of select="/MantenimientoPedidos/MO_ID"/></xsl:when>
						<xsl:otherwise><xsl:value-of select="/MantenimientoPedidos/MANTENIMIENTO/MO_ID"/></xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
				</input>
				<xsl:if test="/MantenimientoPedidos/MANTENIMIENTO/ESTADO">
					<!-- Si NO es un pedido programado -->
					<xsl:if test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/PED_ID">
						<tr class="sinLinea">
							<td class="labelRight trenta">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='numero_pedido']/node()"/>:&nbsp;</td>
							<td class="textLeft">
								<input type="text" name="NUM_PEDIDO"  class="campopesquisa txtActualizar" value="{/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/PED_NUMEROCLINICA}"/>
							</td>
							<td class="textLeft">
								<!--<div class="boton">-->
									<a class="btnDestacado btnActualizar" href="javascript:Actualizar('NUMERO_PEDIDO')">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar']/node()"/>
									</a>
								<!--</div>-->
							</td>
							<td>&nbsp;</td>
						</tr>
						<tr class="sinLinea">
							<td class="labelRight">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_entrega']/node()"/>:&nbsp;</td>
							<td class="textLeft">
								<input type="text" name="FECHA_ENTREGA"  class="campopesquisa txtActualizar" value="{/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/PED_FECHAENTREGA}"/>
							</td>
							<td class="textLeft">
								<!--<div class="boton">-->
									<a class="btnDestacado btnActualizar" href="javascript:Actualizar('FECHA_ENTREGA')">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar']/node()"/>
									</a>
								<!--</div>-->
							</td>
							<td>&nbsp;</td>
						</tr>
						<tr class="sinLinea">
							<td class="labelRight">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='coste_trasporte']/node()"/>:&nbsp;</td>
							<td class="textLeft">
								<input type="text" name="COSTE_LOGISTICA"  class="campopesquisa txtActualizar" value="{/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/MO_COSTELOGISTICA}"/>
							</td>
							<td class="textLeft">
								<!--<div class="boton">-->
									<a class="btnDestacado btnActualizar" href="javascript:Actualizar('COSTE_LOGISTICA')">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar']/node()"/>
									</a>
								<!--</div>-->
							</td>
							<td>&nbsp;</td>
						</tr>
						<xsl:if test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/MULTIOFERTA_EN_DIVISA">
							<tr class="sinLinea">
								<td class="labelRight">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_cambio']/node()"/>:&nbsp;</td>
								<td class="textLeft">
									<input type="text" name="TIPO_CAMBIO"  class="campopesquisa txtActualizar" value="{/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/MO_DIV_TIPOCAMBIO}"/>
								</td>
								<td class="textLeft">
									<!--<div class="boton">-->
										<a class="btnDestacado btnActualizar" href="javascript:Actualizar('TIPO_CAMBIO')">
											<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar']/node()"/>
										</a>
									<!--</div>-->
								</td>
								<td>&nbsp;</td>
							</tr>
						</xsl:if>
						<xsl:if test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/MO_INT_ULTIMADESCARGAENT!=''">
							<tr class="sinLinea">
								<td class="labelRight">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Fecha_envio_ERP']/node()"/>:&nbsp;</td>
								<td class="textLeft">
									<strong><xsl:value-of select="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/MO_INT_ULTIMADESCARGAENT"/></strong>
								</td>
								<td class="textLeft">
									<!--<div class="boton">-->
										<a class="btnDestacado btnActualizar" href="javascript:Actualizar('ENVIAR_ERP')">
											<xsl:value-of select="document($doc)/translation/texts/item[@name='Enviar_ERP']/node()"/>
										</a>
									<!--</div>-->
								</td>
								<td>&nbsp;</td>
							</tr>
						</xsl:if>
						<tr><td colspan="3">&nbsp;</td></tr>
					</xsl:if>
				</xsl:if>
			</tbody>
			</table>

		<!--buttons-->
		<xsl:choose>
		<!--28feb17	Siempre mostramos la tabla completa	<xsl:when test="/MantenimientoPedidos/MANTENIMIENTO/ESTADO='OK' or /MantenimientoPedidos/MANTENIMIENTO/ESTADO='ACTUALIZADO'">-->
		<xsl:when test="/MantenimientoPedidos/MANTENIMIENTO/ESTADO">
			<div class="linha_separacao_cotacao_y"></div>
			<div class="tabela tabela_redonda">
			<table cellspacing="10px" cellpadding="10px">
				<thead class="cabecalho_tabela">
					<!--LINEAS DE PEDIDO-->
					<tr class="subTituloTabla">
						<th class="w1px">&nbsp;</th>
						<th class="textLeft w60px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_privada']/node()"/></th>
						<th class="textLeft w60px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/></th>
						<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
						<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></th>
						<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_por_lote']/node()"/></th>
						<th class="w80px"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
						<th class="w170px"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></th>
						<xsl:if test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/MANTENIMIENTO_AVANZADO='S'">
							<th class="w170px"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ref']/node()"/></th>
						</xsl:if>
						<xsl:if test="/MantenimientoPedidos/LANG = 'spanish'">
							<th class="w70px"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></th>
						</xsl:if>
						<th class="textLeft dies">&nbsp;</th>
						<xsl:if test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/MANTENIMIENTO_AVANZADO='S'">
							<th><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_alternativa']/node()"/></th>
							<th><xsl:value-of select="document($doc)/translation/texts/item[@name='prod_alternativo']/node()"/></th>
							<th class="w1px">&nbsp;</th>
							<th class="w1px">&nbsp;</th>
						</xsl:if>
						<th class="uno">&nbsp;</th>
						<!--th class="uno">&nbsp;</th>-->
					</tr>
	            </thead>
    	        <tbody class="corpo_tabela_oculto">
				<xsl:for-each select="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/LINEASPEDIDO/LINEAPEDIDO">
   					<tr class="conhover">
    					 <xsl:attribute name="class">
        					 <xsl:choose>
            					 <xsl:when test="ESPACK='S'">fondoAmarillo</xsl:when>
            					 <xsl:otherwise></xsl:otherwise>
        					 </xsl:choose>
    					 </xsl:attribute>
						<td class="color_status">&nbsp;</td>
						<td class="textLeft refPrivada"><xsl:value-of select="REFPRIVADA"/></td>
						<td class="textLeft refProveedores"><xsl:value-of select="REFPROVEEDOR"/></td>
						<td class="textLeft"><xsl:value-of select="NOMBRE"/></td>
						<td class="textLeft">
							<xsl:choose>
							<xsl:when test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/MANTENIMIENTO_AVANZADO='S' and ESPACK='N'">
								<input type="text" class="w120px campopesquisa txtActualizar" name="UN_BASICA_{LMO_ID}" size="10" value="{UNIDADBASICA}" onkeyup="javascript:ActivarBoton({LMO_ID})"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="UNIDADBASICA"/>
								<input type="hidden" name="UN_BASICA_{LMO_ID}" value="{UNIDADBASICA}"/>
							</xsl:otherwise>
							</xsl:choose>
                                                </td>
						<td class="datosRight">
							<xsl:choose>
							<xsl:when test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/MANTENIMIENTO_AVANZADO='S' and ESPACK='N'">
								<input type="text" class="w100px campopesquisa peq txtActualizar" name="UN_LOTE_{LMO_ID}" size="4" value="{UNIDADESPORLOTE}" onkeyup="javascript:ActivarBoton({LMO_ID})"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="UNIDADESPORLOTE"/>
								<input type="hidden" name="UN_LOTE_{LMO_ID}" value="{UNIDADESPORLOTE}"/>
							</xsl:otherwise>
							</xsl:choose>
                                                </td>
						<td class="datosRight">
							<xsl:choose>
							<xsl:when test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/MANTENIMIENTO_AVANZADO='S' and ESPACK='N'">
								<input type="text" class="campopesquisa peq txtActualizar" name="CANTIDAD_{LMO_ID}" size="4" value="{CANTIDAD}" onkeyup="javascript:ActivarBoton({LMO_ID})"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="CANTIDAD"/>
								<input type="hidden" name="CANTIDAD_{LMO_ID}" value="{CANTIDAD}"/>
							</xsl:otherwise>
							</xsl:choose>
						</td>
						<td class="datosRight">
							<xsl:choose>
							<xsl:when test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/MANTENIMIENTO_AVANZADO='S' and ESPACK='N'">
								<strong><xsl:value-of select="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/DIVISA/PREFIJO"/></strong>&nbsp;<input type="text" class="w120px campopesquisa clPrecio txtActualizar" name="PRECIO_{LMO_ID}" size="10" value="{PRECIOUNITARIO}" onkeyup="javascript:ActivarBoton({LMO_ID})"/>&nbsp;<strong><xsl:value-of select="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/DIVISA/SUFIJO"/></strong>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="PRECIOUNITARIO"/>
								<input type="hidden" name="PRECIO_{LMO_ID}" value="{PRECIOUNITARIO}"/>
							</xsl:otherwise>
							</xsl:choose>
                        </td>
						<td class="datosRight">
							<xsl:choose>
							<xsl:when test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/MANTENIMIENTO_AVANZADO='S' and ESPACK='N'">
								<strong><xsl:value-of select="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/DIVISA_EMPRESA/DIVISA/PREFIJO"/></strong>&nbsp;<input type="text" class="w120px campopesquisa clPrecioRef txtActualizar" name="PRECIOREF_{LMO_ID}" size="10" value="{PRECIOREFERENCIA}" onkeyup="javascript:ActivarBoton({LMO_ID})"/>&nbsp;<strong><xsl:value-of select="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/DIVISA_EMPRESA/DIVISA/SUFIJO"/></strong>
							</xsl:when>
							<xsl:otherwise>
								<!--<xsl:value-of select="PRECIOREFERENCIA"/>-->
								<input type="hidden" name="PRECIOREF_{LMO_ID}" value="{PRECIOREFERENCIA}"/>
							</xsl:otherwise>
							</xsl:choose>
                        </td>
                        <xsl:if test="//MantenimientoPedidos/LANG = 'spanish'">
                        <td class="datosRight">
                            <xsl:value-of select="PORCENTAJEIVA"/>&nbsp;%
                            <input type="hidden" name="PORCENTAJEIVA_{LMO_ID}" value="{PORCENTAJEIVA}"/>
                        </td>
                        </xsl:if>
                        <td>
							<xsl:if test="ESPACK='N'">
								<a id="btnActLinea_{LMO_ID}" style="display:none;" class="btnDestacado" href="javascript:Actualizar('CAMBIAR_LINEA','{LMO_ID}','{LPE_ID}')">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar']/node()"/>
								</a>
							</xsl:if>
						</td>
						<xsl:if test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/MANTENIMIENTO_AVANZADO='S'">
							<td class="textLeft"><xsl:value-of select="ALTERNATIVA/REFERENCIA"/></td>
							<td class="textLeft"><xsl:value-of select="ALTERNATIVA/NOMBRE"/></td>
							<!-- ocultar = N => visible, ocultar = S =>oculto  <xsl:value-of select="ALTERNATIVA/NO_MOSTRAR"/>-->
							<td>
							<xsl:choose>
							<xsl:when test="ALTERNATIVA/NO_MOSTRAR = 'N'">
								<a href="javascript:Ocultar({LPE_ID},'S')">
									<img src="http://www.newco.dev.br/images/visible.gif" alt="Visible"/>
								</a>
							</xsl:when>
							<xsl:when test="ALTERNATIVA/NO_MOSTRAR = 'S'">
								<a href="javascript:Ocultar({LPE_ID},'N')">
									<img src="http://www.newco.dev.br/images/oculto.gif" alt="Oculto"/>
								</a>
							</xsl:when>
							<xsl:otherwise>&nbsp;</xsl:otherwise>
							</xsl:choose>
							</td>
							<td>
							<xsl:choose>
							<!-- Si NO es un pedido programado -->
							<xsl:when test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/PED_ID and /MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/TOTAL_LINEAS>1">
								<a href="javascript:Actualizar('BORRAR_LINEA',{LMO_ID},{LPE_ID})">
									<img src="http://www.newco.dev.br/images/2017/trash.png" alt="eliminar"/>
								</a>
							</xsl:when>
							<xsl:otherwise>&nbsp;</xsl:otherwise>
							</xsl:choose>
							</td>
						</xsl:if>
						<td>&nbsp;</td>
					</tr>
					<!--	Motivo por el que se modifica un precio	-->
					<tr id="lMotivo_{LMO_ID}" name="lMotivo_{LMO_ID}" style="display:none;">
						<td class="color_status">&nbsp;</td>
						<td>&nbsp;</td>
						<td colspan="9">&nbsp;
							<xsl:value-of select="document($doc)/translation/texts/item[@name='motivo']/node()"/>:
							<xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/IDMOTIVOCAMBIO/field"/>
								<xsl:with-param name="nombre">IDMOTIVO_<xsl:value-of select="LMO_ID"/></xsl:with-param>
								<xsl:with-param name="id">IDMOTIVO_<xsl:value-of select="LMO_ID"/></xsl:with-param>
								<xsl:with-param name="claSel">w300px</xsl:with-param>
							</xsl:call-template>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<xsl:value-of select="document($doc)/translation/texts/item[@name='explicacion']/node()"/>:&nbsp;
							<input type="text" class="w300px campopesquisa" name="MOTIVO_{LMO_ID}" id="MOTIVO_{LMO_ID}" value=""/>
						</td>
						<td colspan="5">&nbsp;</td>
					</tr>
				</xsl:for-each>
				<!-- Si NO es un pedido programado -->
				<xsl:if test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/PED_ID">
					<!--añadir una nueva linea al pedido-->
					<tr class="fondoAmarillo divActualizar">
						<td class="color_status">&nbsp;</td>
						<td class="labelRight" colspan="3">
							<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='anadir_linea_pedido']/node()"/>:</strong>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ref']/node()"/>.
						</td>
						<td class="textLeft" colspan="2"><input type="text" class="campopesquisa w120px" name="NEWLINE_REFPROV" id="NEWLINE_REFPROV" /></td>
                        <td class="textLeft">
								<a class="btnNormal"  id="botonBuscarEnvio" href="javascript:DatosProducto();">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>&nbsp;
								</a>
						</td>
						<td class="textLeft" colspan="9">
							&nbsp;<span class="rojo">(<xsl:value-of select="document($doc)/translation/texts/item[@name='producto_debe_estar_adjudicado']/node()"/>)</span>
							&nbsp;&nbsp;&nbsp;<a class="btnNormal" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoPrivadoProductoEmpresa2022.xsql?IDEMPRESA={/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/MO_IDCLIENTE}&amp;ORIGEN=MANTENPEDIDO&amp;IDDIVISA={/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/DIVISA/ID}&amp;IDPROVEEDOR={/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/MO_IDPROVEEDOR}','Catalogo Privado',50,80,90,20);"><xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo']/node()"/></a>
						</td>
					</tr>
                    <tr class="fondoAmarillo" id="datosProd" style="display:none;">
                    </tr>
					<!--	Motivo por el que se modifica un precio	-->
					<tr id="lMotivo" name="lMotivo" style="display:none;">
						<td class="color_status">&nbsp;</td>
						<td>&nbsp;</td>
						<td colspan="9">&nbsp;
							<xsl:value-of select="document($doc)/translation/texts/item[@name='motivo']/node()"/>:
							<xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/IDMOTIVOCAMBIO/field"/>
								<xsl:with-param name="nombre">IDMOTIVO</xsl:with-param>
								<xsl:with-param name="id">IDMOTIVO</xsl:with-param>
								<xsl:with-param name="claSel">w300px</xsl:with-param>
							</xsl:call-template>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<xsl:value-of select="document($doc)/translation/texts/item[@name='explicacion']/node()"/>:&nbsp;
							<input type="input" class="campopesquisa w500px" name="MOTIVO" id="MOTIVO" value=""/>
						</td>
						<td colspan="5">&nbsp;</td>
					</tr>
				</xsl:if>
    	        </tbody>
				<tfoot class="rodape_tabela"><tr><td colspan="17">&nbsp;</td></tr></tfoot>
				</table>
				</div>
				<br /><br />
				<!--fin de añadir una nueva linea al pedido-->
    		<div class="divleft divActualizar">
				<table class="w1200px tableCenter">
					<tr class="sinLinea">
						<xsl:if test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/DOCUMENTOS/DOCUMENTOS_COMPRADOR/DOCUMENTO">
							<xsl:for-each select="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/DOCUMENTOS/DOCUMENTOS_COMPRADOR/DOCUMENTO">
								&nbsp;<a>
									<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Documentos/<xsl:value-of select="URL"/>','Documentos',100,80,0,0);</xsl:attribute>
									<xsl:value-of select="NOMBRETIPO"/>:&nbsp;<xsl:value-of select="NOMBRE"/>
								</a><br/>
							</xsl:for-each>
						</xsl:if>
						<xsl:if test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/DOCUMENTOS/DOCUMENTOS_VENDEDOR/DOCUMENTO">
							<xsl:for-each select="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/DOCUMENTOS/DOCUMENTOS_VENDEDOR/DOCUMENTO">
								&nbsp;<a>
									<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Documentos/<xsl:value-of select="URL"/>','Documentos',100,80,0,0);</xsl:attribute>
									<xsl:value-of select="NOMBRETIPO"/>:&nbsp;<xsl:value-of select="NOMBRE"/>
								</a><br/>
							</xsl:for-each>
						</xsl:if>
					</tr>
					<tr class="sinLinea">
						<td class="cincuenta textLeft">&nbsp;
							<br/><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones']/node()"/>:</strong><br/><br/>
							<textarea  class="w1000px" name="MO_COMENTARIOS" id="MO_COMENTARIOS"><xsl:value-of select="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/MO_COMENTARIOS"/></textarea>
							&nbsp;<a class="btnDestacado btnActualizar" id="btnComentario" href="javascript:ActualizarComentario();">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>&nbsp;</a>&nbsp;
						</td>
					</tr>
					<xsl:if test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/MANTENIMIENTO_AVANZADO='S'">
						<tr class="sinLinea">
							<td class="cincuenta textLeft" valign="top">
								<br/><strong><xsl:copy-of select="document($doc)/translation/texts/item[@name='motivo_borrar']/node()"/></strong><br/><br/>
								<textarea class="w1000px" name="MOTIVO_BORRAR" id="MOTIVO_BORRAR"></textarea>
								&nbsp;<a class="btnRojo" href="javascript:BorrarPedido();">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_pedido']/node()"/>&nbsp;</a>&nbsp;
								<br/><br/>
							</td>                                
							<td>&nbsp;</td>                                
            			</tr>
					</xsl:if>
 				</table>
        	</div>

	</xsl:when>
	<xsl:otherwise>
        <table class="buscador" border="0">
		<!--LINEAS DE PEDIDO-->
		<tr>
		<th class="uno">&nbsp;</th>
		<th align="left" class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_privada']/node()"/></th>
		<th align="left" class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/></th>
		<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
		<th align="left" class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/></th>
		<th align="left" class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_por_lote']/node()"/></th>
		<th align="left" class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
		<th align="left" class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></th>
		<xsl:if test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/MOSTRAR_PRECIO_REFERENCIA">
			<th align="left" class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ref']/node()"/></th>
		</xsl:if>
		<xsl:if test="/MantenimientoPedidos/LANG = 'spanish'">
			<th align="left" class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></th>
		</xsl:if>
		<th align="left" class="dies">&nbsp;</th>
		<xsl:if test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/MANTENIMIENTO_AVANZADO='S'">
			<th align="left" class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_alternativa']/node()"/></th>
			<th align="left" class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='prod_alternativo']/node()"/></th>
			<th align="left" class="cinco">&nbsp;</th>
			<th class="uno">&nbsp;</th>
		</xsl:if>
		<th class="uno">&nbsp;</th>
		</tr>
			<xsl:for-each select="MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/LINEASPEDIDO/LINEAPEDIDO">
				<tr>
					<td>&nbsp;</td>
					<td class="textLeft refPrivada"><xsl:value-of select="REFPRIVADA"/></td>
					<td class="textLeft refProveedores"><xsl:value-of select="REFPROVEEDOR"/></td>
					<td class="textLeft"><xsl:value-of select="NOMBRE"/></td>
					<td class="textLeft">
						<xsl:choose>
						<xsl:when test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/MANTENIMIENTO_AVANZADO='S'">
							<input type="text" class="campopesquisa" name="UN_BASICA_{LMO_ID}" size="10" value="{UNIDADBASICA}"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="UNIDADBASICA"/>
							<input type="hidden" name="UN_BASICA_{LMO_ID}" value="{UNIDADBASICA}"/>
						</xsl:otherwise>
						</xsl:choose>
                   </td>
					<td class="textLeft">
						<xsl:choose>
						<xsl:when test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/MANTENIMIENTO_AVANZADO='S'">
							<input type="text" class="campopesquisa" name="UN_LOTE_{LMO_ID}" size="4" value="{UNIDADESPORLOTE}"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="UNIDADESPORLOTE"/>
							<input type="hidden" name="UN_LOTE_{LMO_ID}" value="{UNIDADESPORLOTE}"/>
						</xsl:otherwise>
						</xsl:choose>
                    </td>
					<td class="textLeft"><input type="text" class="campopesquisa w70px" name="CANTIDAD_{LMO_ID}" value="{CANTIDAD}"/></td>
					<td class="textLeft">
						<xsl:choose>
						<xsl:when test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/MANTENIMIENTO_AVANZADO='S'">
							<input type="text" class="campopesquisa" name="PRECIO_{LMO_ID}" size="10" value="{PRECIOUNITARIO}"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="PRECIOUNITARIO"/>
							<input type="hidden" name="PRECIO_{LMO_ID}" value="{PRECIOUNITARIO}"/>
						</xsl:otherwise>
						</xsl:choose>
                    </td>
                    <xsl:if test="../../MOSTRAR_PRECIO_REFERENCIA">
						<td class="textLeft">
							<xsl:choose>
							<xsl:when test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/MANTENIMIENTO_AVANZADO='S'">
								<input type="text" class="campopesquisa" name="PRECIOREF_{LMO_ID}" size="10" value="{PRECIOREFERENCIA}"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="PRECIOREFERENCIA"/>
								<input type="hidden" name="PRECIOREF_{LMO_ID}" value="{PRECIOREFERENCIA}"/>
							</xsl:otherwise>
							</xsl:choose>
                    	</td>
                    </xsl:if>
                    <xsl:if test="//MantenimientoPedidos/LANG = 'spanish'">
                    <td class="textLeft">
                        <xsl:value-of select="PORCENTAJEIVA"/>&nbsp;%
                        <input type="hidden" name="PORCENTAJEIVA_{LMO_ID}" value="{PORCENTAJEIVA}"/>
                    </td>
                    </xsl:if>
                    <td>
						<a class="btnDestacado btnActualizar" href="javascript:Actualizar('CAMBIAR_LINEA','{LMO_ID}','{LPE_ID}')">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar']/node()"/>
						</a>
					</td>
					<xsl:if test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/MANTENIMIENTO_AVANZADO='S'">
						<td class="textLeft"><xsl:value-of select="ALTERNATIVA/REFERENCIA"/></td>
						<td class="textLeft"><xsl:value-of select="ALTERNATIVA/NOMBRE"/></td>

						<!-- ocultar = N => visible, ocultar = S =>oculto  <xsl:value-of select="ALTERNATIVA/NO_MOSTRAR"/>-->
						<td>
							<xsl:choose>
							<xsl:when test="ALTERNATIVA/NO_MOSTRAR = 'N'">
								<a href="javascript:Ocultar({LPE_ID},'S')">
									<img src="http://www.newco.dev.br/images/visible.gif" alt="Visible"/>
								</a>
							</xsl:when>
							<xsl:when test="ALTERNATIVA/NO_MOSTRAR = 'S'">
								<a href="javascript:Ocultar({LPE_ID},'N')">
									<img src="http://www.newco.dev.br/images/oculto.gif" alt="Oculto"/>
								</a>
							</xsl:when>
							<xsl:otherwise>&nbsp;</xsl:otherwise>
							</xsl:choose>
						</td>
						<td>
							<xsl:choose>
							<!-- Si NO es un pedido programado -->
							<xsl:when test="/MantenimientoPedidos/MANTENIMIENTO/LISTAEMPRESAS/PEDIDO/PED_ID">
								<a class="btnActualizar" href="javascript:Actualizar('BORRAR_LINEA',{LMO_ID},{LPE_ID})">
									<img src="http://www.newco.dev.br/images/2017/trash.png" alt="eliminar"/>
								</a>
							</xsl:when>
							<xsl:otherwise>&nbsp;</xsl:otherwise>
							</xsl:choose>
						</td>
					</xsl:if>
					<td>&nbsp;</td>
				</tr>
			</xsl:for-each>

			</table>
<!--
			<div class="divLeft40">&nbsp;</div>
				<div class="divLeft20 boton">
					<a href="javascript:ComprobarPedido();">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='comprobar_pedido']/node()"/>&nbsp;</a>
				</div>
-->
		</xsl:otherwise>
		</xsl:choose>
		</div><!--fin de divleft-->
        <p>&nbsp;</p>
	</xsl:otherwise>
	</xsl:choose>
	</form>

	<!--mensaje de error-->
	<form name="MensajeJS">
		<input type="hidden" name="OBLI_FECHA_ENTREGA" value="{document($doc)/translation/texts/item[@name='obligatorio_fecha_entrega']/node()}"/>
		<input type="hidden" name="OBLI_NUM_PEDIDO" value="{document($doc)/translation/texts/item[@name='obligatorio_num_pedido']/node()}"/>
		<input type="hidden" name="OBLI_UD_BASE" value="{document($doc)/translation/texts/item[@name='obligatorio_ud_basica']/node()}"/>
		<input type="hidden" name="OBLI_UD_LOTE" value="{document($doc)/translation/texts/item[@name='obligatorio_ud_lote']/node()}"/>
		<input type="hidden" name="OBLI_CANTIDAD" value="{document($doc)/translation/texts/item[@name='obligatorio_cantidad']/node()}"/>
		<input type="hidden" name="OBLI_REF_PROVE" value="{document($doc)/translation/texts/item[@name='obligatorio_ref_proveedor']/node()}"/>
		<input type="hidden" name="NOT_A_NUMBER" value="{document($doc)/translation/texts/item[@name='not_a_number']/node()}"/>
		<input type="hidden" name="PRODUCTO_EXISTE_PEDIDO" value="{document($doc)/translation/texts/item[@name='producto_existe_pedido']/node()}"/>
		<input type="hidden" name="SEGURO_ELIMINAR_LINEA_PEDIDO" value="{document($doc)/translation/texts/item[@name='seguro_eliminar_linea_pedido']/node()}"/>
		<input type="hidden" name="CLIENTE_OBLI" value="{document($doc)/translation/texts/item[@name='seleccionar_cliente_obligatorio']/node()}"/>
		<input type="hidden" name="PROVEEDOR_OBLI" value="{document($doc)/translation/texts/item[@name='seleccionar_proveedor_obligatorio']/node()}"/>
		<input type="hidden" name="MO_ID_OBLI" value="{document($doc)/translation/texts/item[@name='mo_id_obligatorio']/node()}"/>
		<input type="hidden" name="CANTIDAD_INCORRECTA" value="{document($doc)/translation/texts/item[@name='cantidad_incorrecta']/node()}"/>
		<input type="hidden" name="ENVIAR" value="{document($doc)/translation/texts/item[@name='enviar']/node()}"/>
		<input type="hidden" name="BUSCAR" value="{document($doc)/translation/texts/item[@name='buscar']/node()}"/>
		<input type="hidden" name="PRECIO_REF_INFERIOR" value="{document($doc)/translation/texts/item[@name='precio_ref_inferior']/node()}"/>
		<input type="hidden" name="OBLI_PRECIO_REF_POSITIVO" value="{document($doc)/translation/texts/item[@name='obligatorio_precioref_positivo']/node()}"/>
		<input type="hidden" name="OBLI_PRECIO_POSITIVO" value="{document($doc)/translation/texts/item[@name='obligatorio_precio_positivo']/node()}"/>
		<input type="hidden" name="OBLI_CANTIDAD_POSITIVA" value="{document($doc)/translation/texts/item[@name='obligatorio_cantidad_positiva']/node()}"/>
		<input type="hidden" name="OBLI_COSTE_LOGISTICA" value="{document($doc)/translation/texts/item[@name='obligatorio_coste_logistica']/node()}"/>
		<!--
		<input type="hidden" name="OBLI_LUGAR_ENTREGA" value="{document($doc)/translation/texts/item[@name='obligatorio_lugar_entrega']/node()}"/>
		<input type="hidden" name="OBLI_CENTRO_CONSUMO" value="{document($doc)/translation/texts/item[@name='obligatorio_centro_consumo']/node()}"/>
        -->
        <!--mensajeJS prod manuales-->
        <input type="hidden" name="ERROR_INSERTAR_DATOS" value="{document($doc)/translation/texts/item[@name='error_insertar_datos']/node()}"/>
        <input type="hidden" name="ERROR_ELIMINAR_DATOS" value="{document($doc)/translation/texts/item[@name='error_eliminar_datos']/node()}"/>
        <input type="hidden" name="TODOS_CAMPOS_OBLI" value="{document($doc)/translation/texts/item[@name='todos_campos_obli']/node()}"/>
        <input type="hidden" name="PDF_ENVIADO_CON_EXITO" value="{document($doc)/translation/texts/item[@name='pdf_enviado_con_exito']/node()}"/>
        <input type="hidden" name="ERROR_TIPOCAMBIO" value="{document($doc)/translation/texts/item[@name='Informar_tipo_cambio']/node()}"/>
	</form>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
