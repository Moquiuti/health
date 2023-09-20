<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Página de adjudicacion de catálogo privado a catálogo de proveedor
	Ultima revision: ET 15dic22 11:10. MantenimientoReducido2022_151222.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<!-- template principal -->
<xsl:template match="/">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>


<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo_privado']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='medicalVM']/node()"/>&nbsp;-&nbsp;<xsl:value-of select="/Mantenimiento/MANTENIMIENTO/PRODUCTO/PRODUCTO"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducido2022_151222.js"></script>

	<script type='text/javascript'>
		var lang	= '<xsl:value-of select="/Productos/LANG"/>';
		var IDIdioma	= '<xsl:value-of select="/Productos/PRODUCTO/PRODUCTO/IDIDIOMA"/>';
	</script>
</head>

<!-- cuerpo -->
<body onLoad="javascript:onLoad();">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!-- gestion de errores -->
	<xsl:choose>
	<xsl:when test="/Mantenimiento/ERROR">
		<xsl:apply-templates match="/Mantenimiento/ERROR"/>
	</xsl:when>
	<!-- todo ha ido ok, mostramos un mensaje al usuario -->
	<xsl:when test="/Mantenimiento/OK">
		<xsl:apply-templates match="/Mantenimiento/OK"/>
	</xsl:when>
	<!-- todo ha ido ok, recargamos la pagina con los datos actualizados -->
	<xsl:otherwise>

	<form name="form1">
		<!-- zona de input ocultos action="MantenimientoReducidoSave.xsql" method="post"-->
		<input type="hidden" name="ORIGEN" value="{/Mantenimiento/ORIGEN}"/>
		<input type="hidden" name="SOL_PROD_ID" value="{/Mantenimiento/SOL_PROD_ID}"/>
		<input type="hidden" name="IDEMPRESA" value="{/Mantenimiento/MANTENIMIENTO/CLIENTE/IDEMPRESA}"/>
		<input type="hidden" name="IDPRODUCTO" value="{/Mantenimiento/MANTENIMIENTO/PRODUCTO/IDPRODUCTO}"/>
		<input type="hidden" name="IDPROVEEDOR" value="{/Mantenimiento/MANTENIMIENTO/PRODUCTO/IDPROVEEDOR}"/>
		<input type="hidden" name="IDPRODUCTOESTANDAR" value="{/Mantenimiento/MANTENIMIENTO/CLIENTE/IDPRODUCTO}"/>
		<input type="hidden" name="ORIGEN_PRECIOREF" value="{/Mantenimiento/MANTENIMIENTO/CLIENTE/ORIGEN_PRECIOREF}"/>
		<input type="hidden" name="IDPROVEEDOR_CP" value="{/Mantenimiento/MANTENIMIENTO/CLIENTE/IDPROVEEDOR_CP}"/>
		<input type="hidden" name="LISTA_PLANTILLAS"/>
		<input type="hidden" name="DERECHOS_PLANTILLAS" value="{/Mantenimiento/MANTENIMIENTO/DERECHOS}"/>
		<input type="hidden" name="BACKUP_DERECHOS_PLANTILLAS" value="{/Mantenimiento/MANTENIMIENTO/DERECHOS}"/>
		<input type="hidden" name="ACTION"/>
		<input type="hidden" name="ID_PRODUCTO"/>
		<input type="hidden" name="ID_EMPRESA"/>
		<input type="hidden" name="MARGENPORDEFECTO" value="{/Mantenimiento/MANTENIMIENTO/CLIENTE/MARGENPORDEFECTO}"/>
		<input type="hidden" name="HISTORICOSPORCENTRO">
		<xsl:attribute name="value">
		  <xsl:if test="/Mantenimiento/MANTENIMIENTO/HISTORICOSPORCENTRO">S</xsl:if>
		</xsl:attribute>
		</input>
		<input type="hidden" name="PRECIO_REFERENCIA_ORIGINAL_CLIENTE">
		<xsl:attribute name="value">
		  <xsl:if test="/Mantenimiento/MANTENIMIENTO/CLIENTE/PRECIO_REFERENCIA_ORIGINAL_CLIENTE">S</xsl:if>
		</xsl:attribute>
		</input>
		<!-- contiene la lista con los cambios para los precios de referencia de empresa o de centro -->
		<input type="hidden" name="LISTA_PRECIOREFERENCIA"/>
		<!-- fin zona de input ocultos -->

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='datos_privados_de']/node()"/>:&nbsp;
			<xsl:choose>
			<xsl:when test="/Mantenimiento/MANTENIMIENTO/MVM or /Mantenimiento/MANTENIMIENTO/MVMB">
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/Mantenimiento/MANTENIMIENTO/EMPRESAS/field"/>
					<xsl:with-param name="onChange">javascript:CambioCliente(this.value);</xsl:with-param>
					<xsl:with-param name="nombre">IDCLIENTE</xsl:with-param>
					<xsl:with-param name="id">IDCLIENTE</xsl:with-param>
					<xsl:with-param name="claSel">w500px</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="/Mantenimiento/MANTENIMIENTO/CLIENTE/EMPRESA_CORTO"/>&nbsp;
			</xsl:otherwise>
			</xsl:choose>
			</p>
			<p class="TituloPagina">
        		<xsl:value-of select="/Mantenimiento/MANTENIMIENTO/PRODUCTO/PRODUCTO" disable-output-escaping="yes"/>
				<span class="CompletarTitulo">
             		<a class="btnDestacado" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/NuevaEvaluacionProducto.xsql?PRO_ID={/Mantenimiento/MANTENIMIENTO/PRODUCTO/IDPRODUCTO}&amp;EMP_ID={/Mantenimiento/MANTENIMIENTO/PRODUCTO/IDPROVEEDOR}','Evaluación producto',100,80,0,-10);" style="text-decoration:none;">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitar_evaluacion']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="javascript:window.print();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="javascript:CerrarVentana(document.forms['form1']);">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
					</a>
					&nbsp;
					<xsl:if test="/Mantenimiento/MANTENIMIENTO/PRO_ID_ANTERIOR != ''">
						<a class="btnNormal" href="http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducido2022.xsql?PRO_ID={/Mantenimiento/MANTENIMIENTO/PRO_ID_ANTERIOR}&amp;EMP_ID={/Mantenimiento/MANTENIMIENTO/CLIENTE/IDEMPRESA}" title="Anterior producto" target="_self">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/>
						</a>&nbsp;
					</xsl:if>
					<xsl:if test="/Mantenimiento/MANTENIMIENTO/PRO_ID_SIGUIENTE != ''">
						<a class="btnNormal" href="http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducido2022.xsql?PRO_ID={/Mantenimiento/MANTENIMIENTO/PRO_ID_SIGUIENTE}&amp;EMP_ID={/Mantenimiento/MANTENIMIENTO/CLIENTE/IDEMPRESA}" title="Siguiente producto" target="_self">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/>
						</a>&nbsp;
					</xsl:if>
				</span>
			</p>
		</div>
		<br/>

      <div class="divLeft">
		<!--DATOS PRODUCTO PROVEEDOR-->
		<div class="divLeft30nopa">
			<table cellspacing="6px" cellpadding="6px">
			<tbody>
				<tr>
					<!--<td class="cinquenta" colspan="2" style="font-weight:bold; background:#e3e1e2; padding:3px 0;">-->
            		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='datos_proveedor']/node()"/>:&nbsp;</td>
					<td class="datosLeft">
						<!-- descripcion del producto del proveedor -->
						<a href="javascript:FichaProducto('{/Mantenimiento/MANTENIMIENTO/PRODUCTO/IDPRODUCTO}');">
							<xsl:value-of select="/Mantenimiento/MANTENIMIENTO/PRODUCTO/PRODUCTO" disable-output-escaping="yes"/>
						</a>
					</td>
				</tr>

        	  <xsl:if test="/Mantenimiento/MANTENIMIENTO/CDC">
            	<tr>
            	  <td class="labelRight">PRO_ID:&nbsp;</td>
            	  <td class="datosLeft"><span class="amarillo" style="padding:5px 8px;"><strong><xsl:value-of select="/Mantenimiento/MANTENIMIENTO/PRODUCTO/IDPRODUCTO"/></strong></span></td>
            	</tr>
        	  </xsl:if>

			<tr>
				<td class="labelRight"><!-- referencia del producto del proveedor -->
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>:&nbsp;
				</td>
				<td class="datosLeft">
                <a href="javascript:FichaProducto('{/Mantenimiento/MANTENIMIENTO/PRODUCTO/IDPRODUCTO}');">
					<xsl:value-of select="/Mantenimiento/MANTENIMIENTO/PRODUCTO/REFERENCIA"/>
                </a>&nbsp;
                <!--ficha tecnica-->
                <xsl:if test="/Mantenimiento/MANTENIMIENTO/PRODUCTO/FICHA_TECNICA != '' and /Mantenimiento/MANTENIMIENTO/PRODUCTO/FICHA_TECNICA/NOMBRE != ''">
                  <a target="_blank">
                    <xsl:attribute name="href">http://www.newco.dev.br/Documentos/<xsl:value-of select="/Mantenimiento/MANTENIMIENTO/PRODUCTO/FICHA_TECNICA/URL"/></xsl:attribute>
                    <img src="http://www.newco.dev.br/images/fichaTecnica.gif" alt="Ficha Tecnica"/>
                  </a>
                </xsl:if><!--fin de if ficha tecnica-->
              </td>
			</tr>

			<tr>
				<td class="cinquenta labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:&nbsp;</td>
				<td class="datosLeft">
					<a href="javascript:FichaEmpresa({/Mantenimiento/MANTENIMIENTO/PRODUCTO/IDPROVEEDOR})">
						<xsl:value-of select="/Mantenimiento/MANTENIMIENTO/PRODUCTO/PROVEEDOR"/>
                	</a>
				</td>
			</tr>

          <xsl:if test="/Mantenimiento/MANTENIMIENTO/PRODUCTO/MARCA != ''">
			<tr>
				<td class="cinquenta labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>:&nbsp;</td>
				<td class="datosLeft"><xsl:value-of select="/Mantenimiento/MANTENIMIENTO/PRODUCTO/MARCA"/></td>
			</tr>
          </xsl:if>

			<!--solo españa enseño iva-->
			<xsl:if test="Mantenimiento/MANTENIMIENTO/PRODUCTO/IDPAIS = '34'">
				<tr>
					<td class="cinquenta labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/>:&nbsp;</td>
					<td class="datosLeft"><xsl:value-of select="/Mantenimiento/MANTENIMIENTO/PRODUCTO/IVA"/></td>
				</tr>
			</xsl:if>

          <xsl:if test="/Mantenimiento/MANTENIMIENTO/PRODUCTOMARGENPORDEFECTO/UDBASE != ''">
			<tr>
				<td class="cinquenta labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_base']/node()"/>:&nbsp;</td>
				<td class="datosLeft"><xsl:value-of select="/Mantenimiento/MANTENIMIENTO/PRODUCTOMARGENPORDEFECTO/UDBASE"/></td>
			</tr>
          </xsl:if>

		<tr>
			<td class="cinquenta labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_lote']/node()"/>:&nbsp;</td>
			<td class="datosLeft"><xsl:value-of select="/Mantenimiento/MANTENIMIENTO/PRODUCTO/UDLOTE"/></td>
		</tr>

		<tr>
			<td class="cinquenta labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>:&nbsp;</td>
			<td class="datosLeft">
				<xsl:choose>
				<xsl:when test="/Mantenimiento/MANTENIMIENTO/CLIENTE/TARIFA/PRECIO_FORMATO!=''">
					<xsl:value-of select="/Mantenimiento/MANTENIMIENTO/CLIENTE/TARIFA/PRECIO_FORMATO"/>
				</xsl:when>
				<xsl:otherwise>- <xsl:value-of select="document($doc)/translation/texts/item[@name='sin_precio']/node()"/> -</xsl:otherwise>
				</xsl:choose>
                <!--si producto viene de licitación enseño link a contrato-->
                &nbsp;&nbsp;
                <xsl:if test="/Mantenimiento/MANTENIMIENTO/CLIENTE/IDLICITACION and /Mantenimiento/MANTENIMIENTO/CLIENTE/IDPROVEEDORLIC">
                 	<a class="btnDiscreto" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/ImprimirOferta.xsql?LIC_ID={/Mantenimiento/MANTENIMIENTO/CLIENTE/IDLICITACION}&amp;LIC_PROV_ID={/Mantenimiento/MANTENIMIENTO/CLIENTE/IDPROVEEDORLIC}',100,100,0,0);" style="text-decoration:none;">
                 		<xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion']/node()"/>
				  <!--  <xsl:choose>
                    <xsl:when test="Mantenimiento/MANTENIMIENTO/PRODUCTO/IDPAIS = '34'">
                      <img src="http://www.newco.dev.br/images/verLicitacion.gif" alt="Ver licitacion" style="text-decoration:none;"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <img src="http://www.newco.dev.br/images/verLicitacion-BR.gif" alt="Ver cotação" style="text-decoration:none;"/>
                    </xsl:otherwise>
                    </xsl:choose>-->
                  </a>
                </xsl:if>

                <xsl:for-each select="/Mantenimiento/MANTENIMIENTO/PRODUCTO/DATOS_CLIENTE">
                  <xsl:if test="OFERTA">
                    &nbsp;&nbsp;
                    <a target="_blank" style="text-decoration:none;">
                      <xsl:attribute name="href">http://www.newco.dev.br/Documentos/<xsl:value-of select="OFERTA/URL"/></xsl:attribute>
                      <img src="http://www.newco.dev.br/images/oferta.gif" alt="Oferta" style="text-decoration:none;"/>
                    </a>&nbsp;
                    <!--si tiene documentos anexos-->
                    <xsl:if test="OFERTA/DOCUMENTOHIJO">
                      <xsl:for-each select="OFERTA/DOCUMENTOHIJO">
                        <!--<xsl:value-of select="NOMBRE"/>&nbsp;
                        ( .<xsl:value-of select="substring-after(URL,'.')"/> )-->
                        <a target="_blank" style="text-decoration:none;">
                          <xsl:attribute name="href">http://www.newco.dev.br/Documentos/<xsl:value-of select="URL"/></xsl:attribute>
                          <img src="http://www.newco.dev.br/images/anexo.gif" alt="Anexo" style="text-decoration:none;"/>
                        </a>&nbsp;
                      </xsl:for-each>
                    </xsl:if>
                  </xsl:if>
                </xsl:for-each>
					</td>
				</tr>
			</tbody>
			</table>
		</div><!--fin div info producto de proveedor-->

				<!--DATOS PRODUCTO MVM-->
				<div class="divLeft40nopa">
					<table class="buscador" cellspacing="6px" cellpadding="6px">
					<tbody>
						<tr>
            				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='datos_cliente']/node()"/>:&nbsp;</td>
							<td class="datosLeft">
								<!-- descripcion de la clinica -->
								<xsl:choose>
								<xsl:when test="/Mantenimiento/MANTENIMIENTO/CLIENTE/IDPRODUCTO!=''">
									<a href="javascript:MantProductoEstandar('{/Mantenimiento/MANTENIMIENTO/CLIENTE/IDEMPRESA}','{/Mantenimiento/MANTENIMIENTO/CLIENTE/IDPRODUCTO}');">
										<xsl:value-of select="/Mantenimiento/MANTENIMIENTO/CLIENTE/PRODUCTO"/>
									</a>&nbsp;
                					<a class="btnDiscreto" href="javascript:AnalisisPedidos('{/Mantenimiento/MANTENIMIENTO/PRODUCTO/IDPRODUCTO}');">
                    					<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/><!--<img src="http://www.newco.dev.br/images/tabla.gif" alt="Lineas pedidos"/>-->
                					</a>
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
									<xsl:when test="/Mantenimiento/MANTENIMIENTO/CLIENTE/TARIFA/PRECIO != ''">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='producto_no_catalogado_para_clinica']/node()"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="document($doc)/translation/texts/item[@name='producto_no_se_puede_catalogar_falta_precio']/node()"/>
									</xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>

        			  <xsl:if test="/Mantenimiento/MANTENIMIENTO/CDC and /Mantenimiento/MANTENIMIENTO/CLIENTE/IDPRODUCTO != ''">
            			<tr>
            			  <td class="labelRight">CP_PRO_ID:&nbsp;</td>
            			  <td class="datosLeft">
                			<span class="amarillo" style="padding:5px 8px;"><strong><xsl:value-of select="/Mantenimiento/MANTENIMIENTO/CLIENTE/IDPRODUCTO"/></strong></span>
            			  </td>
            			</tr>
        			  </xsl:if>

						<tr>
							<!--<td class="labelRight grisMed">-->
							<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='margen']/node()"/> (<xsl:value-of select="/Mantenimiento/MANTENIMIENTO/CLIENTE/MARGENPORDEFECTO"/>%):&nbsp;</td>
							<td class="datosLeft">
								<input type="text" class="campopesquisa noinput w100px" maxlength="12" name="PRECIOCONMARGENPORDEFECTO" disabled="disabled"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Euros&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<xsl:if test="/Mantenimiento/MANTENIMIENTO/NUEVOMODELO">
									<a class="btnDiscreto" href="javascript:CopiarPrecioConMargenPorDefecto(document.forms['form1']);">&nbsp;=&nbsp;
                    				<!--<xsl:choose>
                    				<xsl:when test="/Mantenimiento/MANTENIMIENTO/PRODUCTO/IDIDIOMA = 0"><img src="http://www.newco.dev.br/images/calculaBoton.gif" alt="Calcula" /></xsl:when>
                    				<xsl:otherwise><img src="http://www.newco.dev.br/images/calculaBoton-BR.gif" alt="Calculado" /></xsl:otherwise>
                    				</xsl:choose>-->
                				  </a>
								</xsl:if>
							</td>
						</tr>

						<tr style="display:none;">
							<td class="cinquenta" colspan="2" >
								<!-- precio -->
								<input type="checkbox" name="ADJUDICADO" class="peq">
									<xsl:choose>
									<xsl:when test="/Mantenimiento/MANTENIMIENTO/CLIENTE/ADJUDICADO">
										<xsl:if test="/Mantenimiento/MANTENIMIENTO/CLIENTE/ADJUDICADO='S'">
											<xsl:attribute name="checked">checked</xsl:attribute>
										</xsl:if>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="checked">checked</xsl:attribute>
									</xsl:otherwise>
									</xsl:choose>
								</input>&nbsp;
								<xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado']/node()"/>
								<input type="hidden" name="BACKUP_ADJUDICADO">
									<xsl:choose>
									<xsl:when test="/Mantenimiento/MANTENIMIENTO/CLIENTE/ADJUDICADO">
										<xsl:choose>
										<xsl:when test="/Mantenimiento/MANTENIMIENTO/CLIENTE/ADJUDICADO='S'">
											<xsl:attribute name="value">true</xsl:attribute>
										</xsl:when>
										<xsl:otherwise>
											<xsl:attribute name="value">false</xsl:attribute>
										</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="value">true</xsl:attribute>
									</xsl:otherwise>
									</xsl:choose>
								</input>
							</td>
						</tr>

						<tr>
							<!--<td class="labelRight grisMed">--><!-- precio -->
							<td class="labelRight"><!-- precio -->
								<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_prov']/node()"/>
								<xsl:if test="Mantenimiento/MANTENIMIENTO/PRODUCTO/IDPAIS = '34'">
									(<xsl:value-of select="document($doc)/translation/texts/item[@name='s_iva']/node()"/>)
								</xsl:if>
								<span class="camposObligatorios">*</span>:&nbsp;
							</td>
							<td class="datosLeft">
								<input type="text" class="campopesquisa w100px" maxlength="12" name="PRECIO" id="PRECIO" value="{/Mantenimiento/MANTENIMIENTO/CLIENTE/TARIFA/PRECIO}" disabled="disabled"/>
								
								<!--	PRUEBA	
								<xsl:copy-of select="/Mantenimiento/MANTENIMIENTO/CLIENTE/TARIFA"/>
								<xsl:value-of select="/Mantenimiento/MANTENIMIENTO/CLIENTE/TARIFA/PRECIO"/>
								-->
								<input type="hidden" id="PRECIO_CLIENTE" value="{/Mantenimiento/MANTENIMIENTO/CLIENTE/TARIFA/PRECIO}"/>
								<input type="hidden" name="PRECIO_MVM" value="{/Mantenimiento/MANTENIMIENTO/PRODUCTO/PRECIO}"/>
								<input type="hidden" name="PRECIO_HISTORICO" value="{/Mantenimiento/MANTENIMIENTO/CLIENTE/TARIFA_HISTORICA/PRECIO}"/>
								<input type="hidden" name="BACKUP_PRECIO" value="{/Mantenimiento/MANTENIMIENTO/CLIENTE/PRECIO}"/>
								<input type="hidden" name="EXPANDIR"/>
								<input type="hidden" name="BACKUP_EXPANDIR">
									<xsl:choose>
									<xsl:when test="/Mantenimiento/MANTENIMIENTO/CLIENTE/TARIFA/ORIGEN='E' or /Mantenimiento/MANTENIMIENTO/CLIENTE/TARIFA/ORIGEN='I'">
										<xsl:attribute name="value">true</xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="value">false</xsl:attribute>
									</xsl:otherwise>
									</xsl:choose>
								</input>
								<xsl:if test="/Mantenimiento/MANTENIMIENTO/CLIENTE/TARIFA_HISTORICA/PRECIO_FORMATO!=''">
									<xsl:value-of select="/Mantenimiento/MANTENIMIENTO/CLIENTE/TARIFA_HISTORICA/PRECIO_FORMATO"/>&nbsp;
									<xsl:value-of select="document($doc)/translation/texts/item[@name='simbolo_euro']/node()"/> -
									<xsl:value-of select="/Mantenimiento/MANTENIMIENTO/CLIENTE/TARIFA_HISTORICA/FECHA"/>
								</xsl:if>
								<input type="hidden" name="PRECIO_EXCLUSIVO"/>
							</td>
						</tr>

						<tr>
							<!--<td class="labelRight grisMed">--><!-- precio de referencia -->
							<td class="labelRight"><!-- precio de referencia -->
								<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ref']/node()"/>.
								<xsl:if test="Mantenimiento/MANTENIMIENTO/PRODUCTO/IDPAIS = '34'">
									(<xsl:value-of select="document($doc)/translation/texts/item[@name='s_iva']/node()"/>)
								</xsl:if>:&nbsp;
							</td>
							<td class="datosLeft">
								<input type="text" class="campopesquisa w100px" maxlength="12" name="PRECIOREFERENCIA_{/Mantenimiento/MANTENIMIENTO/CLIENTE/IDEMPRESA}" value="{/Mantenimiento/MANTENIMIENTO/CLIENTE/PRECIOREFERENCIA}">
									<!--si viejo modelo no hace nada el onblur, si nuevo modelo si
									
									 onChange="javascript:CalcularPrecioFinal(document.forms['form1']);calcularTodosAhorros(document.forms['form1']);"
									
									<xsl:attribute name="onBlur">
										<xsl:choose>
										<xsl:when test="/Mantenimiento/MANTENIMIENTO/NUEVOMODELO">
											javascript:calcularAhorro(document.forms['form1'],this);
										</xsl:when>
										<xsl:otherwise></xsl:otherwise>
										</xsl:choose>
									</xsl:attribute>-->
								</input>
								<input type="hidden" name="BACKUP_PRECIOREFERENCIA_{/Mantenimiento/MANTENIMIENTO/CLIENTE/IDEMPRESA}" value="{/Mantenimiento/MANTENIMIENTO/CLIENTE/PRECIOREFERENCIA}"/>
								<input type="hidden" name="PRECIOREFERENCIA_SINHISTORICO_{/Mantenimiento/MANTENIMIENTO/CLIENTE/IDEMPRESA}" value="S"/>
								<input type="hidden" name="BACKUP_PRECIOREFERENCIA_SINHISTORICO_{/Mantenimiento/MANTENIMIENTO/CLIENTE/IDEMPRESA}" value="S"/>
								<!--ahorro percentual-->
								&nbsp;&nbsp;&nbsp;
								<span class="labelLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/>:&nbsp;</span>
								<input type="text" class="campopesquisa noinput w60px textRight" name="AHORRO_{/Mantenimiento/MANTENIMIENTO/CLIENTE/IDEMPRESA}" onFocus="this.blur();"/>%
								<!-- lo creamos como dummy :), solo lo necesitamos en los ahorros por centro -->
								<input type="hidden" name="IDHISTORICO_{/Mantenimiento/MANTENIMIENTO/CLIENTE/IDEMPRESA}" value=""/>
								<!--quitamos proveedor dejamos hidden-->
								<input type="hidden" size="12" maxlength="250" name="PROVEEDORANTERIOR_{/Mantenimiento/MANTENIMIENTO/CLIENTE/IDEMPRESA}" value="{/Mantenimiento/MANTENIMIENTO/CLIENTE/PROVEEDOR_ANTERIOR}"/>
							</td>
						</tr>

						<tr>
							<td class="labelRight">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_final']/node()"/>
								<xsl:if test="Mantenimiento/MANTENIMIENTO/PRODUCTO/IDPAIS = '34'">
									(
									<xsl:choose>
									<xsl:when test="/Mantenimiento/MANTENIMIENTO/NUEVOMODELO">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='c_iva_mvm']/node()"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="document($doc)/translation/texts/item[@name='c_iva']/node()"/>
									</xsl:otherwise>
									</xsl:choose>
									)
								</xsl:if>:&nbsp;
							</td>
							<td class="datosLeft">
								<input type="text" class="campopesquisa w100px" maxlength="12" name="PRECIOFINAL_{/Mantenimiento/MANTENIMIENTO/CLIENTE/IDEMPRESA}" value="{/Mantenimiento/MANTENIMIENTO/CLIENTE/TARIFA_TOTAL_SINFORMATO}">
									<!--si viejo modelo no hace nada el onblur, si nuevo modelo si
									<xsl:attribute name="onChange">
										<xsl:choose>
										<xsl:when test="/Mantenimiento/MANTENIMIENTO/NUEVOMODELO">
											javascript:cambiosAPartirDePrecioFinal(document.forms['form1'],<xsl:value-of select="/Mantenimiento/MANTENIMIENTO/CLIENTE/IDEMPRESA"/>);
										</xsl:when>
										<xsl:otherwise></xsl:otherwise>
										</xsl:choose>
									</xsl:attribute>-->
									<!--si nuevo modelo habilitado input si es viejo, asisa, viamed nuevo desabilito-->
									<xsl:if test="not(/Mantenimiento/MANTENIMIENTO/NUEVOMODELO)">
										<xsl:attribute name="disabled">disabled</xsl:attribute>
									</xsl:if>
								</input>
								<!--Campos necesarios para el cálculo del precio final	-->
								<input type="hidden" name="COMISION_AHORRO" value="{/Mantenimiento/MANTENIMIENTO/CLIENTE/COMISION_AHORRO}"/>
								<input type="hidden" name="COMISION_TRANSACCIONES" value="{/Mantenimiento/MANTENIMIENTO/CLIENTE/COMISION_TRANSACCIONES}"/>
								<input type="hidden" name="TIPO_IVA_MVM" value="{/Mantenimiento/MANTENIMIENTO/CLIENTE/TIPO_IVA_MVM}"/>
								<input type="hidden" name="TIPO_IVA_PRODUCTO" value="{/Mantenimiento/MANTENIMIENTO/PRODUCTO/TIPO_IVA}"/>
								<!--margen bruto-->
								&nbsp;&nbsp;&nbsp;
								<span class="labelLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='margen_bruto']/node()"/>:&nbsp;</span>
								<input type="text" class="campopesquisa noinput w60px textRight" maxlength="5" name="MARGENBRUTO_{/Mantenimiento/MANTENIMIENTO/CLIENTE/IDEMPRESA}" onFocus="this.blur();"/>%
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td align="left">
								<br/>
								<a class="btnDestacado" href="javascript:ComprobarReferencia(document.forms['form1']);">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_cambios']/node()"/>
								</a>
							</td>
						</tr>

					</tbody>
					</table>
				</div><!--fin div info producto de MVM-->

				<div class="divLeft30nopa">
					<table class="buscador" cellspacing="6px" cellpadding="6px">
					<tbody>
						<tr>
							<td class="cinquenta labelRight"><!-- AQUI	-->
								<!-- ref de la clinica -->
								<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_mvm']/node()"/>.<span class="camposObligatorios">*</span>:&nbsp;
							</td>
							<td class="datosLeft">
								<xsl:choose>
								<xsl:when test="/Mantenimiento/MANTENIMIENTO/CLIENTE/REFERENCIA!=''">
									<input type="text" class="campopesquisa w150px" maxlength="9" name="REFERENCIACLIENTE" value="{/Mantenimiento/MANTENIMIENTO/CLIENTE/REFERENCIA}"/>
									<input type="hidden" size="12" maxlength="9" name="REFERENCIACLIENTE_XML" value="{/Mantenimiento/MANTENIMIENTO/CLIENTE/REFERENCIA}"/>&nbsp;
									<!--15dic22	<a href="javascript:MostrarCatalogoPrivadoProductoEmpresa(document.forms['form1']);">
									<img src="http://www.newco.dev.br/images/info.gif" style="width:15px;"/></a>-->
								</xsl:when>
								<xsl:when test="/Mantenimiento/MANTENIMIENTO/CLIENTE/REFERENCIAESTANDARPROPUESTA!=''">
									<input type="text" class="campopesquisa w150px" maxlength="9" name="REFERENCIACLIENTE" value="{/Mantenimiento/MANTENIMIENTO/CLIENTE/REFERENCIAESTANDARPROPUESTA}"/>
									<input type="hidden" size="12" maxlength="9" name="REFERENCIACLIENTE_XML" value="{/Mantenimiento/MANTENIMIENTO/CLIENTE/REFERENCIAESTANDARPROPUESTA}"/>&nbsp;
									<a href="javascript:MostrarCatalogoPrivadoProductoEmpresa(document.forms['form1']);">
									<img src="http://www.newco.dev.br/images/info.gif" style="width:15px;"/></a>
								</xsl:when>
								<xsl:otherwise>
									<input type="text" class="campopesquisa w150px" maxlength="9" name="REFERENCIACLIENTE"/>
									<input type="hidden" size="12" maxlength="9" name="REFERENCIACLIENTE_XML"/>&nbsp;
									<a href="javascript:MostrarCatalogoPrivadoProductoEmpresa(document.forms['form1']);">
									<img src="http://www.newco.dev.br/images/info.gif" style="width:15px;"/></a>
								</xsl:otherwise>
								</xsl:choose>
								
								<!--15dic22 incluimos aqui el boton para adjudicar o quitar-->
								<xsl:choose>
								<xsl:when test="/Mantenimiento/MANTENIMIENTO/CLIENTE/PLANTILLAS/PLANTILLA">
									&nbsp;
									<a class="btnDestacado">
										<xsl:attribute name="href">javascript:QuitarDeLaPlantilla('<xsl:value-of select="//CLIENTE/IDEMPRESA"/>','<xsl:value-of select="//PRODUCTO/IDPRODUCTO"/>');</xsl:attribute>
										<xsl:value-of select="document($doc)/translation/texts/item[@name='quitar']/node()"/>
									</a>
									&nbsp;
								</xsl:when>
								<xsl:when test="/Mantenimiento/MANTENIMIENTO/CLIENTE/PLANTILLAS/PLANTILLA and //OTRAS_CLINICAS/CLINICA[1]/REFERENCIA">
									&nbsp;
									<a class="btnDestacado" href="javascript:InsertarEnLaPlantilla(document.forms['form1']);">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='insertar']/node()"/>
									</a>
									&nbsp;
								</xsl:when>
								</xsl:choose>
								<!--15dic22 FIN BLOQUE adjudicar o quitar-->

								<input type="hidden" name="BACKUP_REFERENCIACLIENTE" value="{/Mantenimiento/MANTENIMIENTO/CLIENTE/REFERENCIA}"/>
							</td>
						</tr>

        			  <xsl:choose>
        			  <xsl:when test="/Mantenimiento/MANTENIMIENTO/CLIENTE/PLANTILLAS/PLANTILLA">
            			<tr>
            			  <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='plantillas']/node()"/>:&nbsp;</td>
            			  <td class="datosLeft" style="line-height:20px; font-weight:bold;">
                			<xsl:for-each select="/Mantenimiento/MANTENIMIENTO/CLIENTE/PLANTILLAS/PLANTILLA">
								<a href="javascript:EjecutarFuncionDelFrame('zonaPlantilla','CambioPlantillaExterno({ID});');">
									<xsl:value-of select="NOMBRE"/>
								</a>
								<input type="hidden" name="PLANTILLA_{ID}" value="{ID}"/><br />
							</xsl:for-each>
            			  </td>
            			</tr>

            			<tr>
            			  <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado']/node()"/>:&nbsp;</td>
            			  <td class="datosLeft"><xsl:value-of select="/Mantenimiento/MANTENIMIENTO/CLIENTE/FECHAADJUDICACION"/></td>
            			</tr>

            			<tr>
            			  <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_limite']/node()"/>:&nbsp;</td>
            			  <td class="datosLeft">
                			<!--modificar fecha limite oferta, precio-->
                			<xsl:choose>
                			<!--si hay oferta no puedo cambiar la fecha limite pk manda la fecha limite de la oferta-->
                			<xsl:when test="/Mantenimiento/MANTENIMIENTO/PRODUCTO/DATOS_CLIENTE/OFERTA/ID != ''">
                			  <xsl:value-of select="/Mantenimiento/MANTENIMIENTO/CLIENTE/FECHALIMITEOFERTA"/>&nbsp;&nbsp;
                			  <a href="http://www.newco.dev.br/Documentos/{/Mantenimiento/MANTENIMIENTO/PRODUCTO/DATOS_CLIENTE/OFERTA/URL}">
                    			<img src="http://www.newco.dev.br/images/oferta.gif" alt="Download oferta"/>
                			  </a>
                			  <input type="hidden" name="FECHA_LIMITE" id="FECHA_LIMITE" value="{/Mantenimiento/MANTENIMIENTO/CLIENTE/FECHALIMITEOFERTA}"/>
                			  <input type="hidden" name="CLIENTE_ID" id="CLIENTE_ID" value="{/Mantenimiento/MANTENIMIENTO/CLIENTE/IDEMPRESA}"/>
                			</xsl:when>
                			<xsl:otherwise>
                			  <input type="text" class="campopesquisa w100px noinput" name="FECHA_LIMITE" id="FECHA_LIMITE" value="{/Mantenimiento/MANTENIMIENTO/CLIENTE/FECHALIMITEOFERTA}" size="10"/>
                			  <input type="hidden" name="CLIENTE_ID" id="CLIENTE_ID" value="{/Mantenimiento/MANTENIMIENTO/CLIENTE/IDEMPRESA}"/>
                			  &nbsp;
							  <a class="btnDiscreto" href="javascript:cambiaFecha();" id="ModificaFecha">M
                    			<!--15dic22	<img src="http://www.newco.dev.br/images/modificar.gif" alt="Modificar Fecha"/>-->
                			  </a>
                			  <a class="btnDestacado" style="display:none;" href="javascript:actualizarFechaLimite();" id="EnviarFecha">
								  <xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/>
                    			<!--15dic22	<img src="http://www.newco.dev.br/images/botonEnviar.gif" alt="Enviar Fecha Límite"/>-->
                			  </a>
                			</xsl:otherwise>
                			</xsl:choose>
            			  </td>
            			</tr>
            			<tr>
							<!--15dic22 Movemos estos botones junto a la referencia
							<td align="right">
							<br/>
							<xsl:choose>
							<xsl:when test="/Mantenimiento/MANTENIMIENTO/CLIENTE/PLANTILLAS/PLANTILLA">
								<a class="btnDestacado">
									<xsl:attribute name="href">javascript:QuitarDeLaPlantilla('<xsl:value-of select="//CLIENTE/IDEMPRESA"/>','<xsl:value-of select="//PRODUCTO/IDPRODUCTO"/>');</xsl:attribute>
									<xsl:value-of select="document($doc)/translation/texts/item[@name='quitar']/node()"/>
								</a>
								&nbsp;
							</xsl:when>
							<xsl:when test="/Mantenimiento/MANTENIMIENTO/CLIENTE/PLANTILLAS/PLANTILLA and //OTRAS_CLINICAS/CLINICA[1]/REFERENCIA">
								<a class="btnDestacado" href="javascript:InsertarEnLaPlantilla(document.forms['form1']);">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='insertar']/node()"/>
								</a>
								&nbsp;
							</xsl:when>
							</xsl:choose>
							</td>-->
							<td>&nbsp;</td>
							<td>
							<br/>
							<xsl:if test="/Mantenimiento/MANTENIMIENTO/CLIENTE/PLANTILLAS/PLANTILLA and not(/Mantenimiento/MANTENIMIENTO/DERECHOS_PRODUCTOS_POR_CENTRO)"><!--15dic22 Si los derechos sobre productos son por centro no mostramos el boton por usuario-->
								<a class="btnNormal" href="javascript:DerechosPlantillas(document.forms['form1']);">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='Derechos_usuarios']/node()"/>
								</a>
							</xsl:if>
							</td>
            			</tr>
				</xsl:when>
        	  <xsl:otherwise>
            	<tr>
            	  <td class="datosLeft" colspan="2" style="color:red;font-weight:bold;">
					<!-- si el producto esta catalogado y NO emplantillado mostramos el texto en rojo -->
                	<xsl:choose>
                	<xsl:when test="/Mantenimiento/MANTENIMIENTO/CLIENTE/IDPRODUCTO!=''">
                	  ** <xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo_no_emplantillado_maiu']/node()"/> **
                	</xsl:when>
                	<xsl:when test="/Mantenimiento/MANTENIMIENTO/CLIENTE/REFERENCIAESTANDARPROPUESTA!=''">
                	  <xsl:value-of select="document($doc)/translation/texts/item[@name='producto_no_catalogado']/node()"/>.<br/><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_estandar_propuesta_por_sistema']/node()"/>.
                	</xsl:when>
                	<xsl:otherwise>** <xsl:value-of select="document($doc)/translation/texts/item[@name='sin_plantilla_maiu']/node()"/> **</xsl:otherwise>
                	</xsl:choose>
            	  </td>
            	</tr>
					</xsl:otherwise>
					</xsl:choose>
					</tbody>
					</table>
				</div><!--FIN DE PLANTILLA-->
			</div><!--fin de diovLeft inicial-->

		<div class="divLeft">
		<br/>
		<br/>
		<ul class="pestannas">
			<li>
				<a id="pedidos"><xsl:value-of select="document($doc)/translation/texts/item[@name='ultimos_pedidos']/node()"/></a>
			</li>
			<xsl:if test="/Mantenimiento/MANTENIMIENTO/ADMIN or /Mantenimiento/MANTENIMIENTO/MVM or /Mantenimiento/MANTENIMIENTO/CDC">
				<li>
					<a id="consumoCentros"><xsl:value-of select="document($doc)/translation/texts/item[@name='resumen_compras']/node()"/></a>
				</li>
			</xsl:if>
			<li>
				<a id="roturas"><xsl:value-of select="document($doc)/translation/texts/item[@name='roturas_stock']/node()"/></a>
			</li>
			<li>
				<a id="precios"><xsl:value-of select="document($doc)/translation/texts/item[@name='historicos_precios']/node()"/></a>
			</li>
			<li>
				<a id="preciosReferencia"><xsl:value-of select="document($doc)/translation/texts/item[@name='historico_precios_referencia']/node()"/></a>
			</li>
			<xsl:if test="/Mantenimiento/MANTENIMIENTO/ADMIN or /Mantenimiento/MANTENIMIENTO/MVM or /Mantenimiento/MANTENIMIENTO/CDC">
				<li>
					<a id="historicoCentros"><xsl:value-of select="document($doc)/translation/texts/item[@name='historico_por_centro']/node()"/></a>
				</li>
			</xsl:if>
          	<xsl:if test="/Mantenimiento/MANTENIMIENTO/ADMIN">
				<!--25may22 Quitamos log de consumo en otras clinicas
				<li>
					<a id="precioConsumoClinicas"><xsl:value-of select="document($doc)/translation/texts/item[@name='precios_consumos_clinicas']/node()"/></a>
				</li>-->
				<li>
					<a id="todosPrecios"><xsl:value-of select="document($doc)/translation/texts/item[@name='otros_precios']/node()"/></a>
				</li>
			</xsl:if>
			<li>
				<a id="infoProveedor"><xsl:value-of select="document($doc)/translation/texts/item[@name='info_proveedor']/node()"/></a>
			</li>
			<!--25may22 Incluimos info log adjudicacion-->
			<li>
				<a id="logAdjudicacion"><xsl:value-of select="document($doc)/translation/texts/item[@name='Adjudicacion']/node()"/></a>
			</li>
		</ul>
		</div><!--fin de divleft pestañas-->

		<div class="divLeft" style="margin-top:28px;"><!--	Contenedor de todas las tablas inferiores	-->
				
        <div class="divLeft">
		<table id="pedidosBox" class="tablasDatos" cellspacing="6px" cellpadding="6px">
			<tr class="subTituloTabla">
				<th>&nbsp;</th>
				<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='codigo']/node()"/></th>
				<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
				<th align="left" class="veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
				<th align="left" class="veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
				<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
				<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_unitario']/node()"/></th>
				<th>&nbsp;</th>
			</tr>

          <xsl:choose>
          <xsl:when test="/Mantenimiento/MANTENIMIENTO/CLIENTE/PEDIDOS/LINEAPEDIDO">
          <xsl:for-each select="/Mantenimiento/MANTENIMIENTO/CLIENTE/PEDIDOS/LINEAPEDIDO">
            <tr>
              <td>&nbsp;</td>
              <td><a href="javascript:FichaPedido({MO_ID})"><xsl:value-of select="CODIGO"/></a></td>
              <td><xsl:value-of select="FECHA"/></td>
              <td align="left"><xsl:value-of select="CENTRO"/></td>
              <td align="left"><xsl:value-of select="PROVEEDOR"/></td>
              <td><xsl:value-of select="CANTIDAD"/></td>
              <td><xsl:value-of select="PRECIOUNITARIO"/></td>
              <td>&nbsp;</td>
            </tr>
          </xsl:for-each>
          </xsl:when>
			<xsl:otherwise>
				<tr style="border-bottom:1px solid #A7A8A9;">
					<td align="center" colspan="6">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='no_lineas_pedido']/node()"/>
					</td>
				</tr>
			</xsl:otherwise>
			</xsl:choose>
			</table>
		</div><!--fin div tabla pedidos-->

        <div class="divLeft">
		<table id="todosPreciosBox" class="tablasDatos" cellspacing="6px" cellpadding="6px" style="display:none;">
			<tr class="subTituloTabla">
				<th class="veinte">&nbsp;</th>
				<th class="dies" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>
				<th class="dies" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></th>
				<th class="veinte" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></th>
				<th class="dies" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
				<th class="dies" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></th>
				<th>&nbsp;</th>
			</tr>

          <xsl:choose>
          <xsl:when test="/Mantenimiento/MANTENIMIENTO/TODOSLOSPRECIOS/CATALOGOSPROVEEDORES/LINEA">
            <tr class="fondoAlternativa"><!--mejor precio-->
              <td class="textRight" style="font-weight:bold;"><xsl:value-of select="document($doc)/translation/texts/item[@name='mejor_precio']/node()"/>:&nbsp;</td>
              <td class="textLeft"><xsl:value-of select="/Mantenimiento/MANTENIMIENTO/TODOSLOSPRECIOS/MEJORPRECIO/CLIENTE"/></td>
              <td class="textLeft">
                <xsl:choose>
                <xsl:when test="/Mantenimiento/LANG = 'spanish'">
                  <xsl:value-of select="/Mantenimiento/MANTENIMIENTO/TODOSLOSPRECIOS/CATALOGOSPROVEEDORES/LINEA[1]/REFERENCIAESTANDAR"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="/Mantenimiento/MANTENIMIENTO/TODOSLOSPRECIOS/CATALOGOSPROVEEDORES/LINEA[1]/IDPRODUCTOESTANDAR"/>
                </xsl:otherwise>
                </xsl:choose>
              </td>
              <td class="textLeft"><xsl:value-of select="/Mantenimiento/MANTENIMIENTO/TODOSLOSPRECIOS/CATALOGOSPROVEEDORES/LINEA[1]/DESCRIPCIONESTANDAR"/></td>
              <td class="textLeft"><xsl:value-of select="/Mantenimiento/MANTENIMIENTO/TODOSLOSPRECIOS/MEJORPRECIO/PROVEEDOR"/></td>
              <td class="textLeft"><xsl:value-of select="/Mantenimiento/MANTENIMIENTO/TODOSLOSPRECIOS/MEJORPRECIO/TARIFA"/></td>
              <td>&nbsp;</td>
            </tr>

          <xsl:for-each select="/Mantenimiento/MANTENIMIENTO/TODOSLOSPRECIOS/CATALOGOSPROVEEDORES/LINEA">
            <tr>
              <td>&nbsp;</td>
              <td class="textLeft"><xsl:value-of select="CLIENTE"/></td>
              <td class="textLeft">
                <xsl:choose>
                <xsl:when test="/Mantenimiento/LANG = 'spanish'"><xsl:value-of select="REFERENCIAESTANDAR"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="IDPRODUCTOESTANDAR"/></xsl:otherwise>
                </xsl:choose>
              </td>
              <td class="textLeft"><xsl:value-of select="DESCRIPCIONESTANDAR"/></td>
              <td class="textLeft"><xsl:value-of select="PROVEEDOR"/></td>
              <td class="textLeft"><xsl:value-of select="TARIFA"/></td>
              <td>&nbsp;</td>
            </tr>
          </xsl:for-each>

          </xsl:when>
			<xsl:otherwise>
				<tr>
					<td align="center" colspan="7">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='no_datos_disponibles']/node()"/>
					</td>
				</tr>
			</xsl:otherwise>
			</xsl:choose>
			</table>
		</div><!--fin div tabla todos precios-->

        <!--tabla roturas de stock-->
        <div class="divLeft">
		<table id="roturasBox" class="tablasDatos" cellspacing="6px" cellpadding="6px" style="display:none;">
			<tr class="subTituloTabla">
              <th class="dos">&nbsp;</th>
              <th class="tres" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
              <th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>&nbsp;&nbsp;</th>
              <th class="veinte" align="left"><xsl:copy-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
              <th class="ocho" align="left"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/></th>
              <th class="dies" align="left"><xsl:copy-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
              <th class="veinte" align="left"><xsl:copy-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/></th>
              <th class="veinte" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='alternativa']/node()"/></th>
              <th class="cinco" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='final']/node()"/></th>
              <th class="cinco" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='duracion']/node()"/></th>
              <th>&nbsp;</th>
			</tr>

          <xsl:choose>
          <xsl:when test="/Mantenimiento/MANTENIMIENTO/ROTURAS_STOCKS/ROTURAS_STOCKS_ACTIVAS/ROTURA_STOCKS or /Mantenimiento/MANTENIMIENTO/ROTURAS_STOCKS/ROTURAS_STOCKS_HISTORICAS/ROTURA_STOCKS">

          <xsl:for-each select="/Mantenimiento/MANTENIMIENTO/ROTURAS_STOCKS/ROTURAS_STOCKS_ACTIVAS/ROTURA_STOCKS">
            <tr class="fondoAlternativa">
              <td>&nbsp;</td>
              <td style="text-align:left;"><xsl:value-of select="position()"/></td>
              <td style="text-align:left;"><xsl:value-of select="FECHA" />&nbsp;&nbsp;</td>
              <td style="text-align:left;"><xsl:value-of select="PRODUCTO" /></td>
              <td style="text-align:left;"><xsl:value-of select="REFPROVEEDOR" /></td>
              <td style="text-align:left;"><xsl:value-of select="PROVEEDOR" /></td>
              <td style="text-align:left;"><xsl:value-of select="COMENTARIOS" /></td>
              <td style="text-align:left;"><xsl:value-of select="ALTERNATIVA" /></td>
              <td style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/></td>
              <td style="text-align:left;">&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
          </xsl:for-each>

          <xsl:for-each select="/Mantenimiento/MANTENIMIENTO/ROTURAS_STOCKS/ROTURAS_STOCKS_HISTORICAS/ROTURA_STOCKS">
            <tr>
              <td>&nbsp;</td>
              <td style="text-align:left;"><xsl:value-of select="position()"/></td>
              <td style="text-align:left;"><xsl:value-of select="FECHA" />&nbsp;&nbsp;</td>
              <td style="text-align:left;"><xsl:value-of select="PRODUCTO" /></td>
              <td style="text-align:left;"><xsl:value-of select="REFPROVEEDOR" /></td>
              <td style="text-align:left;"><xsl:value-of select="PROVEEDOR" /></td>
              <td style="text-align:left;"><xsl:value-of select="COMENTARIOS" /></td>
              <td style="text-align:left;"><xsl:value-of select="ALTERNATIVA" /></td>
              <td style="text-align:left;"><xsl:value-of select="FECHAFINAL" /></td>
              <td style="text-align:center;"><xsl:value-of select="DURACION" /></td>
              <td>&nbsp;</td>
            </tr>
          </xsl:for-each>

          </xsl:when>
			<xsl:otherwise>
				<tr>
					<td align="center" colspan="8">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='no_datos_disponibles']/node()"/>
					</td>
				</tr>
			</xsl:otherwise>
			</xsl:choose>
			</table>
		</div><!--fin div tabla roturas de stock-->

        <!--tabla precios historicos por centro-->
        <div class="divLeft">
			<table id="historicoCentrosBox" class="tablasDatos" cellspacing="6px" cellpadding="6px" style="display:none;">
				<tr class="subTituloTabla">
					<th class="cinco">&nbsp;</th>
					<th class="veinte textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
					<th class="quince textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
					<th class="veinte textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
					<th class="ocho textRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></th>
					<th class="ocho textRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_anual']/node()"/></th>
					<th class="ocho textRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_anual']/node()"/></th>
					<th class="ocho textRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/></th>
					<th class="dies textRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro_porc']/node()"/></th>
					<th>&nbsp;</th>
				</tr>

          <xsl:choose>
          <xsl:when test="/Mantenimiento/MANTENIMIENTO/PRODUCTOESTANDAR">

          <xsl:for-each select="/Mantenimiento/MANTENIMIENTO/PRODUCTOESTANDAR/CENTRO">
            <tr class="gris">
              <td>&nbsp;</td>
              <td class="label textLeft"><xsl:value-of select="NOMBRE"/></td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td class="textRight"><xsl:value-of select="CP_HCC_PRECIOMEDIO" /></td>
              <td class="textRight"><xsl:value-of select="CP_HCC_CONSUMOANUAL" /></td>
              <td>&nbsp;</td>
              <td class="textRight"><xsl:value-of select="CP_HCC_AHORRO" /></td>
              <td class="textRight"><xsl:value-of select="CP_HCC_AHORROPORC" /></td>
              <td>&nbsp;</td>
            </tr>

						<xsl:for-each select="PRECIO_HISTORICO">
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td class="textLeft"><xsl:value-of select="PROVEEDOR" /></td>
                <td class="textLeft"><xsl:value-of select="PRODUCTO" /></td>
                <td class="textRight"><xsl:value-of select="PRECIO" /></td>
                <td>&nbsp;</td>
                <td class="textRight"><xsl:value-of select="CANTIDADANUAL" /></td>
                <td class="textRight"><xsl:value-of select="AHORRO" /></td>
                <td class="textRight"><xsl:value-of select="AHORROPORC" /></td>
                <td>&nbsp;</td>
              </tr>
            </xsl:for-each>
          </xsl:for-each>

          </xsl:when>
			<xsl:otherwise>
				<tr>
					<td align="center" colspan="7">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='no_datos_disponibles']/node()"/>
					</td>
				</tr>
			</xsl:otherwise>
			</xsl:choose>
			</table>
		</div><!--fin div tabla precios historicos por centro-->

		<!-- info histórica de cambios de precios -->
		<div class="divLeft">
			<table id="preciosBox" class="tablasDatos" cellspacing="6px" cellpadding="6px" style="display:none;">
				<tr class="subTituloTabla">
					<th class="veintecinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_origen']/node()"/></th>
					<th class="veintecinco">&nbsp;</th>
					<th class="veintecinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></th>
					<th><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_actual']/node()"/>
            		<xsl:if test="Mantenimiento/MANTENIMIENTO/PRODUCTO/IDPAIS = '34'">
                  <br/>(<xsl:value-of select="document($doc)/translation/texts/item[@name='iva_no_incluido']/node()"/>)
                </xsl:if>
              </th>
				<th class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_final']/node()"/><br/>(<xsl:value-of select="document($doc)/translation/texts/item[@name='con_comision_iva']/node()"/>)</th>
              <th>&nbsp;</th>
						</tr>

				<tr>
					<td><xsl:value-of select="/Mantenimiento/MANTENIMIENTO/CLIENTE/TARIFA/FECHA"/></td>
					<td align="left">&nbsp;</td>
					<td><xsl:value-of select="/Mantenimiento/MANTENIMIENTO/CLIENTE/TARIFA/USUARIO"/></td>
					<td><xsl:value-of select="/Mantenimiento/MANTENIMIENTO/CLIENTE/TARIFA/PRECIO"/></td>
					<td><xsl:value-of select="/Mantenimiento/MANTENIMIENTO/CLIENTE/TARIFA/PRECIOFINAL"/></td>
					<td>&nbsp;</td>
				</tr>

            	<tr><td colspan="6">&nbsp;</td></tr>
				<tr class="subTituloTabla">
					<th>&nbsp;</th>
					<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_fin']/node()"/></th>
					<th align="center">&nbsp;</th>
					<th align="center"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_anterior']/node()"/><xsl:if test="Mantenimiento/MANTENIMIENTO/PRODUCTO/IDPAIS = '34'"><br/>(<xsl:value-of select="document($doc)/translation/texts/item[@name='iva_no_incluido']/node()"/>)</xsl:if></th>
					<th align="center">&nbsp;</th>
					<th>&nbsp;</th>
				</tr>

					<!-- cada tr contiene (clinica, referencia de la clinica, precio) -->
					<xsl:choose>
					<xsl:when test="/Mantenimiento/MANTENIMIENTO/HISTORICO_PRECIOS/LOG">
					<xsl:for-each select="/Mantenimiento/MANTENIMIENTO/HISTORICO_PRECIOS/LOG">
						<tr style="border-bottom:1px solid #A7A8A9;">
							<td><xsl:value-of select="FECHAORIGENTARIFA"/></td>
							<td><xsl:value-of select="FECHA"/></td>
							<td><xsl:value-of select="USUARIO"/></td>
							<td><xsl:value-of select="PRECIOANTIGUO"/></td>
							<td><xsl:value-of select="PRECIOFINALANTIGUO"/></td>
              			<td>&nbsp;</td>
						</tr>
					</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<tr>
							<td align="center" colspan="6">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='no_datos_disponibles']/node()"/>
							</td>
						</tr>
					</xsl:otherwise>
					</xsl:choose>
					</table>
				</div><!--fin div tabla precios-->

				<!-- info histórica de cambios de precios de referencia -->
				<div class="divLeft">
					<table id="preciosReferenciaBox" style="display:none;" class="tablasDatos" cellspacing="6px" cellpadding="6px">
						<tr class="subTituloTabla">
							<th class="catorce"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
							<th class="catorce"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></th>
							<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_anterior']/node()"/><br/><xsl:if test="Mantenimiento/MANTENIMIENTO/PRODUCTO/IDPAIS = '34'">(<xsl:value-of select="document($doc)/translation/texts/item[@name='iva_no_incluido']/node()"/>)</xsl:if></th>
							<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='margen']/node()"/><br/>S/N</th>
							<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='teorico']/node()"/><br/>S/N</th>
							<th class="trenta" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/></th>
						</tr>

					<!-- cada tr contiene (clinica, referencia de la clinica, precio) -->
					<xsl:choose>
					<xsl:when test="/Mantenimiento/MANTENIMIENTO/HISTORICO_PRECIOS_REFERENCIA/LOG">
					<xsl:for-each select="/Mantenimiento/MANTENIMIENTO/HISTORICO_PRECIOS_REFERENCIA/LOG">
						<tr>
							<td><xsl:value-of select="FECHA"/></td>
							<td><xsl:value-of select="USUARIO"/></td>
							<td><xsl:value-of select="PRECIOANTIGUO"/></td>
							<td><xsl:value-of select="MARGENPORC"/></td>
							<td><xsl:value-of select="ESTEORICOANTIGUO"/></td>
							<td class="textLeft"><xsl:value-of select="COMENTARIOS"/></td>
						</tr>
					</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<tr>
							<td align="center" colspan="6">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='no_datos_disponibles']/node()"/>
							</td>
						</tr>
					</xsl:otherwise>
					</xsl:choose>
					</table>
				</div><!-- fin de tabla info histórica de cambios de precios de referencia -->

			<!-- info de otras clinicas que ya utilizan este producto -->
			<xsl:if test="/Mantenimiento/MANTENIMIENTO/ADMIN or /Mantenimiento/MANTENIMIENTO/MVM">
				<div class="divLeft">
					<table id="precioConsumoClinicasBox" style="display:none;" class="tablasDatos" cellspacing="6px" cellpadding="6px">
						<tr class="subTituloTabla">
              				<th class="tres">&nbsp;</th>
							<th style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_empresa']/node()"/></th>
							<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_clinica']/node()"/></th>
							<th class="veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/><xsl:if test="Mantenimiento/MANTENIMIENTO/PRODUCTO/IDPAIS = '34'"><br/>(<xsl:value-of select="document($doc)/translation/texts/item[@name='iva_no_incluido']/node()"/>)</xsl:if></th>
							<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='exclusivo']/node()"/> S/N</th>
							<th class="veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_comprada']/node()"/><br />(<xsl:value-of select="document($doc)/translation/texts/item[@name='ultimo_ano']/node()"/>)</th>
							<th class="dies"><xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_sIVA_2line']/node()"/></th>
							<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_emplantillado']/node()"/></th>
						</tr>

					<!-- cada tr contiene (clinica, referencia de la clinica, precio) -->
					<xsl:choose>
					<xsl:when test="/Mantenimiento/MANTENIMIENTO/OTRAS_CLINICAS/CLINICA">
					<xsl:for-each select="/Mantenimiento/MANTENIMIENTO/OTRAS_CLINICAS/CLINICA">
						<tr>
							<td class="tres">&nbsp;</td>
              					<td class="textLeft">
								<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantProductosEstandar2022.xsql?CATPRIV_IDPRODUCTOESTANDAR={IDPRODUCTO}&amp;CATPRIV_IDEMPRESA={IDEMPRESA}&amp;ACCION=CONSULTARPRODUCTOESTANDAR&amp;TIPO=CONSULTA&amp;VENTANA=NUEVA','producto',100,80,0,0);">
									<xsl:value-of select="EMPRESA_CORTO"/>
								</a>
							</td>
							<td>
								<a href="javascript:CopiarReferenciaAlProductoEstandar(document.forms['form1'], '{REFERENCIA}');">
									<xsl:value-of select="REFERENCIA"/>
								</a>
							</td>
							<td><xsl:value-of select="PRECIO"/></td>
							<td><xsl:value-of select="PRECIOEXCLUSIVO"/></td>
							<td><xsl:value-of select="CANTIDADCOMPRADA"/></td>
							<td>
								<xsl:variable name="refProd">
									<xsl:choose>
									<xsl:when test="REFERENCIACLIENTE != ''"><xsl:value-of select="REFERENCIACLIENTE"/></xsl:when>
									<xsl:otherwise><xsl:value-of select="REFERENCIA"/></xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:variable name="consumo"><xsl:value-of select="format-number(CANTIDADCOMPRADA * translate(translate(PRECIO,'.',''),',','.'),'#.00')"/></xsl:variable>

								<xsl:choose>
								<xsl:when test="$consumo = '.00'">0</xsl:when>
								<xsl:when test="/Mantenimiento/MANTENIMIENTO/MVM">
									<a href="javascript:MostrarEIS('CO_Pedidos_Eur','{IDEMPRESA}','','{$refProd}','9999');" style="text-decoration:none;">
										<xsl:value-of select="translate($consumo,'.',',')"/>
                  					</a>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="translate($consumo,'.',',')"/>
								</xsl:otherwise>
								</xsl:choose>
							</td>
							<td><xsl:value-of select="FECHA"/></td>
						</tr>
					</xsl:for-each>

						<tr>
							<td colspan="6">
								<strong>
									<xsl:choose>
                					  <xsl:when test="/Mantenimiento/MANTENIMIENTO/CLIENTE/REFERENCIA != ''">
                    					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/EIS/EISBasico.xsql?IDCONSULTA=COPedidosPorEmpEur&amp;REFERENCIA={/Mantenimiento/MANTENIMIENTO/CLIENTE/REFERENCIA}','ConsumosEIS',100,80,0,0);"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_consumo_producto']/node()"/></a>
                					  </xsl:when>
                					  <xsl:when test="/Mantenimiento/MANTENIMIENTO/CLIENTE/REFERENCIAESTANDARPROPUESTA != ''">
                    					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/EIS/EISBasico.xsql?IDCONSULTA=COPedidosPorEmpEur&amp;REFERENCIA={/Mantenimiento/MANTENIMIENTO/CLIENTE/REFERENCIAESTANDARPROPUESTA}','ConsumosEIS',100,80,0,0);"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_consumo_producto']/node()"/></a>
                					  </xsl:when>
                					  <xsl:otherwise>
                    					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/EIS/EISBasico.xsql?IDCONSULTA=COPedidosPorEmpEur&amp;REFERENCIA=','ConsumosEIS',100,80,0,0);"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_consumo_producto']/node()"/></a>
                					  </xsl:otherwise>
                					  </xsl:choose>
								</strong>
							</td>
						</tr>
					</xsl:when>
					<xsl:otherwise>
						<tr>
							<td colspan="7"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_datos_disponibles']/node()"/></td>
						</tr>
					</xsl:otherwise>
					</xsl:choose>
					</table>
				</div><!-- fin de info de otras clinicas que ya utilizan este producto -->
			</xsl:if>

			<!-- info historica del proveedor -->
			<div class="divLeft">
				<table id="infoProveedorBox" style="display:none;" class="tablasDatos" cellspacing="6px" cellpadding="6px">
					<tr class="subTituloTabla">
						<th><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_entrada']/node()"/></th>
						<th class="cuarenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/></th>
						<th class="trenta" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='acuerdos_condiciones']/node()"/></th>
					</tr>

				<xsl:choose>
				<xsl:when test="/Mantenimiento/MANTENIMIENTO/HISTORICO/LINEA">
				<xsl:for-each select="/Mantenimiento/MANTENIMIENTO/HISTORICO/LINEA">
					<tr>
						<td><xsl:value-of select="FECHA"/></td>
						<td><xsl:value-of select="USUARIO"/></td>
						<td class="textLeft">- <xsl:value-of select="TEXTO"/></td>
					</tr>
				</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<tr>
						<td class="textCenter" colspan="3"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_datos_historico_proveedor']/node()"/></td>
					</tr>
				</xsl:otherwise>
				</xsl:choose>

         		 <tfoot>
						<tr><td colspan="3">&nbsp;</td></tr>

						<tr>
							<td class="w30 labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_entrada_historico_proveedor']/node()"/>:</td>
							<td class="w500px">
								<textarea name="ENTRADA_HISTORICO" class="w500px" rows="6"></textarea>
							</td>
							<td class="textLeft">
								<a class="btnDestacado" href="javascript:enviarComentarioMantRed();">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar_comentario']/node()"/>
								</a>
              				</td>
						</tr>

						<tr class="h40px">
							<td class="textRight">
								<input type="checkbox" class="peq" name="ENTRADA_HISTORICO_TODOSPRODUCTOS"/>&nbsp;
							</td>
							<td colspan="2" class="textLeft fuentePeq">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='entrada_afecta_todos_productos_proveedor']/node()"/>&nbsp;
								<xsl:value-of select="/Mantenimiento/MANTENIMIENTO/PRODUCTO/PROVEEDOR_CORTO"/>
							</td>
						</tr>
          		</tfoot>
				</table>
			</div><!--fin div proveedores-->

			<!-- info historica de adjudicacion -->
			<div class="divLeft">
				<table id="logAdjudicacionBox" style="display:none;" class="tablasDatos" cellspacing="6px" cellpadding="6px">
					<tr class="subTituloTabla">
						<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_inicio']/node()"/></th>
						<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_final']/node()"/></th>
						<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/></th>
						<th class="w50px">CP_PRO_ID</th>
						<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_mvm']/node()"/></th>
						<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
						<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto_estandar']/node()"/></th>
						<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/></th>
					</tr>
				<xsl:choose>
				<xsl:when test="/Mantenimiento/MANTENIMIENTO/LOG_ADJUDICACION/ENTRADA">
				<xsl:for-each select="/Mantenimiento/MANTENIMIENTO/LOG_ADJUDICACION/ENTRADA">
					<tr>
						<td><xsl:value-of select="FECHAINICIO"/></td>
						<td><xsl:value-of select="FECHAFINAL"/></td>
						<td class="textLeft"><xsl:value-of select="USUARIO"/></td>
						<td><xsl:value-of select="CP_PRO_ID"/></td>
						<td><xsl:value-of select="CP_PRO_REFERENCIA"/></td>
						<td><xsl:value-of select="CP_PRO_REFCLIENTE"/></td>
						<td class="textLeft"><xsl:value-of select="CP_PRO_NOMBRE"/></td>
						<td class="textLeft"><xsl:value-of select="CP_PREH_COMENTARIOS"/></td>
					</tr>
				</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<tr>
						<td class="textCenter" colspan="3"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_datos_historico_proveedor']/node()"/></td>
					</tr>
				</xsl:otherwise>
				</xsl:choose>
				</table>
			</div><!--fin info historica de adjudicacion-->

			<xsl:if test="/Mantenimiento/MANTENIMIENTO/ADMIN or /Mantenimiento/MANTENIMIENTO/MVM or /Mantenimiento/MANTENIMIENTO/CDC">
				<!-- consumos por centro -->
				<div class="divLeft">
					<table id="consumoCentrosBox" style="display:none;" class="tablasDatos" cellspacing="6px" cellpadding="6px">
						<tr class="subTituloTabla">
							<th class="datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
							<th class="veinte datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='poblacion']/node()"/></th>
							<th class="dies"><xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_sIVA_2line']/node()"/></th>
							<th class="quince"><xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_reciente_sIVA_2line']/node()"/></th>
              				<th class="quince">&nbsp;</th>
						</tr>

					<xsl:for-each select="/Mantenimiento/MANTENIMIENTO/CONSUMOPORCENTRO/CENTRO">
						<tr>
							<xsl:variable name="refProd">
								<xsl:choose>
								<xsl:when test="/Mantenimiento/MANTENIMIENTO/CLIENTE/REFERENCIACLIENTE != ''"><xsl:value-of select="/Mantenimiento/MANTENIMIENTO/CLIENTE/REFERENCIACLIENTE"/></xsl:when>
								<xsl:when test="/Mantenimiento/MANTENIMIENTO/CLIENTE/REFERENCIA != ''"><xsl:value-of select="/Mantenimiento/MANTENIMIENTO/CLIENTE/REFERENCIA"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="/Mantenimiento/MANTENIMIENTO/PRODUCTO/REFERENCIA"/></xsl:otherwise>
								</xsl:choose>
							</xsl:variable>

							<td class="datosLeft">
								<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle2022.xsql?ID={ID}','Ficha Centro',100,80,0,0);" class="noDecor">
									<xsl:value-of select="NOMBRE"/>
               					</a>
							</td>
							<td class="datosLeft"><xsl:value-of select="POBLACION"/></td>
							<td>
								<xsl:choose>
								<xsl:when test="CONSUMO > 0">
									<a href="javascript:MostrarEIS('CO_Pedidos_Eur','{/Mantenimiento/MANTENIMIENTO/CLIENTE/IDEMPRESA}','{ID}','{$refProd}','9999');" style="text-decoration:none;">
										<xsl:value-of select="CONSUMO"/>
									</a>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="CONSUMO"/>
								</xsl:otherwise>
								</xsl:choose>
							</td>
							<td>
								<xsl:choose>
								<xsl:when test="CONSUMORECIENTE > 0">
									<a href="javascript:MostrarEIS('CO_Pedidos_Eur','{/Mantenimiento/MANTENIMIENTO/CLIENTE/IDEMPRESA}','{ID}','{$refProd}','9999');" style="text-decoration:none;">
										<xsl:value-of select="CONSUMORECIENTE"/>
									</a>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="CONSUMORECIENTE"/>
								</xsl:otherwise>
								</xsl:choose>
							</td>
              				<td>&nbsp;</td>
						</tr>
					</xsl:for-each>

						<tr><td colspan="5">&nbsp;</td></tr>
					</table>
				</div><!--fin div consumos-->
			</xsl:if>
			</div><!--fin de divLeft con tablas a elegir-->
		</form>

		<form name="MensajeJS">
			<input type="hidden" name="GUARDAR_CAMBIOS_CATALOGACION" value="{document($doc)/translation/texts/item[@name='guardar_cambios_catalogacion']/node()}"/>
			<input type="hidden" name="PROPORCIONAR_REF_ESTANDAR" value="{document($doc)/translation/texts/item[@name='proporcionar_ref_estandar']/node()}"/>
			<input type="hidden" name="PROD_NO_ADJUDICADO" value="{document($doc)/translation/texts/item[@name='prod_no_adjudicado']/node()}"/>
			<input type="hidden" name="PROPORCIONAR_PRECIO" value="{document($doc)/translation/texts/item[@name='proporcionar_precio']/node()}"/>
			<input type="hidden" name="GUARDAR_CAMBIOS_CATALOGACION" value="{document($doc)/translation/texts/item[@name='guardar_cambios_catalogacion']/node()}"/>
			<input type="hidden" name="INTRODUZCA_COMENTARIOS" value="{document($doc)/translation/texts/item[@name='introduzca_comentarios']/node()}"/>
			<input type="hidden" name="CAMBIOS_GUARDARLOS" value="{document($doc)/translation/texts/item[@name='cambios_guardarlos']/node()}"/>
			<input type="hidden" name="CAMBIOS_CATALOGACION" value="{document($doc)/translation/texts/item[@name='cambios_catalogacion']/node()}"/>
			<input type="hidden" name="DESCATALOGAR" value="{document($doc)/translation/texts/item[@name='descatalogar']/node()}"/>
			<input type="hidden" name="EXPANSION" value="{document($doc)/translation/texts/item[@name='expansion']/node()}"/>
			<input type="hidden" name="PRECIO_FINAL_NO_0" value="{document($doc)/translation/texts/item[@name='precio_final_no_0']/node()}"/>
			<input type="hidden" name="PRECIO_REFERENCIA_NO_0" value="{document($doc)/translation/texts/item[@name='precio_referencia_no_0']/node()}"/>
			<input type="hidden" name="FECHA_LIMITE_OBLI" id="FECHA_LIMITE_OBLI" value="{document($doc)/translation/texts/item[@name='fecha_limite_obli']/node()}" />
			<input type="hidden" name="ERROR_GUARDAR_FECHA" id="ERROR_GUARDAR_FECHA" value="{document($doc)/translation/texts/item[@name='error_guardar_fecha']/node()}" />
			<input type="hidden" name="DESEA_SUSTITUIR" id="DESEA_SUSTITUIR" value="{document($doc)/translation/texts/item[@name='desea_sustituir']/node()}" />
			<input type="hidden" name="POR" id="POR" value="{document($doc)/translation/texts/item[@name='por']/node()}" />
			<input type="hidden" name="PRECIO_REF_ORIGINAL_SEGURO_MODIFICAR" id="PRECIO_REF_ORIGINAL_SEGURO_MODIFICAR" value="{document($doc)/translation/texts/item[@name='precio_ref_original_seguro_modificar']/node()}" />
			<input type="hidden" name="PRECIO_REF_HISTORICOS_SEGURO_MODIFICAR" id="PRECIO_REF_HISTORICOS_SEGURO_MODIFICAR" value="{document($doc)/translation/texts/item[@name='precio_ref_historicos_seguro_modificar']/node()}" />
		</form>

	</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>

<!-- template error -->
<xsl:template match="/Mantenimiento/ERROR">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="divLeft">
		<h1 class="titlePage"><xsl:value-of select="./@titulo"/></h1>

		<p><xsl:value-of select="./@msg"/></p>
		<br/><br/>
		<p>
			<xsl:call-template name="botonPersonalizado">
				<xsl:with-param name="backgroundBoton">oscuro</xsl:with-param>
				<xsl:with-param name="foregroundBoton">medio</xsl:with-param>
				<xsl:with-param name="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/></xsl:with-param>
				<xsl:with-param name="status">Volver</xsl:with-param>
				<xsl:with-param name="funcion">history.go(-1);</xsl:with-param>
			</xsl:call-template>
		</p>
	</div>
</xsl:template>

<!-- template ok -->
<xsl:template match="/Mantenimiento/OK">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="divLeft">
		<h1 class="titlePage"><xsl:value-of select="./@titulo"/></h1>

		<p><xsl:value-of select="./@msg"/></p>
		<br/>
		<p>
			<xsl:call-template name="botonPersonalizado">
				<xsl:with-param name="backgroundBoton">oscuro</xsl:with-param>
				<xsl:with-param name="foregroundBoton">medio</xsl:with-param>
				<xsl:with-param name="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='ok']/node()"/></xsl:with-param>
				<xsl:with-param name="status">Ok</xsl:with-param>
				<xsl:with-param name="location">http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducido.xsql?PRO_ID=<xsl:value-of select="IDPRODUCTO"/>&amp;EMP_ID=<xsl:value-of select="CLIENTE/IDEMPRESA"/></xsl:with-param>
			</xsl:call-template>
		</p>
	</div>
</xsl:template>
</xsl:stylesheet>
