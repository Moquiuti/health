<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Catalogo Privado. Mantenimiento de FAMILIA
	Ultima revisión: ET 9may22 12:41 MantFamilias2022_070322.js
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
			<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title>
		<xsl:choose>
		<xsl:when test="/Mantenimiento/FAMILIA/REFERENCIA != ''">
			<xsl:value-of select="Mantenimiento/FAMILIA/REFERENCIA"/>&nbsp;<xsl:value-of select="Mantenimiento/FAMILIA/NOMBRE"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="document($doc)/translation/texts/item[@name='mant_de']/node()"/>
			<xsl:value-of select="Mantenimiento/FAMILIA/NOMBRESNIVELES/NIVEL2"/>
			<xsl:value-of select="document($doc)/translation/texts/item[@name='de_productos']/node()"/>&nbsp;-&nbsp;
			<xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo_privado']/node()"/>
		</xsl:otherwise>
		</xsl:choose>
    </title>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<!--	11ene22 nuevos estilos -->
	<!--<link rel="stylesheet" href="http://www.newco.dev.br/General/basicMVM2022.css"/>-->
	<link href='http://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'/>
	<!--	11ene22 nuevos estilos -->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantFamilias2022_070322.js"></script>

	<script>
		var raros_alert			= "<xsl:value-of select="document($doc)/translation/texts/item[@name='caracteres_raros']/node()"/>";
		var no_hay			= "<xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_datos']/node()"/>";
		var leyenda_ref_nivel2		= "<xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_ref_familia']/node()"/>";
		var leyenda_ref_nivel2_3niveles	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_ref_familia_3niveles']/node()"/>";
		var chars_nivel2		= "<xsl:value-of select="Mantenimiento/FAMILIA/CODIFICACIONNIVELES/NIVEL2"/>";
		var ya_existe_ref_cliente	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='existe_ref_cliente_nivel']/node()"/>";
		var nombre_nivel2		= "<xsl:value-of select="/Mantenimiento/FAMILIA/NOMBRESNIVELES/NIVEL2"/>";

		var length_nueva_ref_familia;
		<xsl:choose>
		<xsl:when test="/Mantenimiento/FAMILIA/CODIFICACIONNIVELES[@MostrarCategoria='S']">
			length_nueva_ref_familia	= <xsl:value-of select="string-length(/Mantenimiento/FAMILIA/CODIFICACIONNIVELES/NIVEL2) - string-length(/Mantenimiento/FAMILIA/CODIFICACIONNIVELES/NIVEL1)"/>;
		</xsl:when>
		<xsl:otherwise>
			length_nueva_ref_familia	= <xsl:value-of select="string-length(/Mantenimiento/FAMILIA/CODIFICACIONNIVELES/NIVEL2)"/>;
		</xsl:otherwise>
		</xsl:choose>

		var introducir_ref_nuevo_nivel2	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='introducir_ref']/node()"/>";
		var length_ref_nuevo_nivel2	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='length_ref']/node()"/>";
		var introducir_nombre_nivel2	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='introducir_nombre']/node()"/>";
		var ya_existe_ref_nivel2	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='ya_existe_ref']/node()"/>";
                <xsl:choose>
		<xsl:when test="Mantenimiento/FAMILIA/NOMBRESNIVELES[@id='custom']">
			introducir_ref_nuevo_nivel2	+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_grupo']/node()"/>.";
			length_ref_nuevo_nivel2		+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_grupo']/node()"/>";
			introducir_nombre_nivel2	+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_grupo']/node()"/>.";
			ya_existe_ref_nivel2		+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_grupo']/node()"/>";
		</xsl:when>
                <xsl:when test="Mantenimiento/FAMILIA/NOMBRESNIVELES[@id='estandar']">
			introducir_ref_nuevo_nivel2	+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_familia']/node()"/>.";
			length_ref_nuevo_nivel2		+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_familia']/node()"/>";
			introducir_nombre_nivel2	+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_familia']/node()"/>.";
			ya_existe_ref_nivel2		+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_familia']/node()"/>";
		</xsl:when>
                </xsl:choose>
                
                length_ref_nuevo_nivel2	+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='length_ref_nivel2']/node()"/>";
	</script>

	<script language="javascript">
	</script>

	<xsl:text disable-output-escaping="yes">
	<![CDATA[
		<script language="javascript">
		<!--
		//-->
		</script>
	]]>
	</xsl:text>
</head>

<body>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:choose>
		<xsl:when test="CarpetasYPlantillas/SESION_CADUCADA">
			<xsl:apply-templates select="CarpetasYPlantillas/SESION_CADUCADA"/>
		</xsl:when>
		<xsl:when test="CarpetasYPlantillas/ROWSET/ROW/Sorry">
			<xsl:apply-templates select="CarpetasYPlantillas/ROWSET/ROW/Sorry"/>
		</xsl:when>
		<xsl:otherwise>

			<form name="form1" action="MantFamilias2022.xsql" method="post">

				<!--	Titulo de la página		-->
				<div class="ZonaTituloPagina">
					<p class="TituloPagina">
						<!--	Nombre de la familia si ya existe o "Familia" -->
						<xsl:choose>
							<xsl:when test="/Mantenimiento/FAMILIA/REFERENCIA != ''">
								<xsl:value-of select="Mantenimiento/FAMILIA/REFERENCIA"/>&nbsp;<xsl:value-of select="Mantenimiento/FAMILIA/NOMBRE"/>
								<xsl:if test="(/Mantenimiento/FAMILIA/MASTER or /Mantenimiento/FAMILIA/MASTER_UNICO) and /Mantenimiento/ACCION = 'MODIFICARFAMILIA'">
									&nbsp;&nbsp;&nbsp;<span class="amarillo">CP_FAM_ID:&nbsp;<xsl:value-of select="/Mantenimiento/FAMILIA/ID"/></span>
								</xsl:if>
                            </xsl:when>
							<xsl:otherwise>	
								<xsl:value-of select="document($doc)/translation/texts/item[@name='mant_de']/node()"/>
								<xsl:value-of select="Mantenimiento/FAMILIA/NOMBRESNIVELES/NIVEL2"/>
								<xsl:value-of select="document($doc)/translation/texts/item[@name='de_productos']/node()"/>
							</xsl:otherwise>							
						</xsl:choose>
								
						&nbsp;<a href="#" id="toggleResumenCatalogo" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/info.gif"/></a>
						<xsl:if test="/Mantenimiento/FAMILIA/MENSAJE">
							<span class="fuentePeq">
							<xsl:choose>
								<xsl:when test="/Mantenimiento/FAMILIA/MENSAJE='OK'">
                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='cambios_guardados']/node()"/>
                                	:&nbsp;<xsl:value-of select="/Mantenimiento/FAMILIA/FECHA"/>
									<!--&nbsp;-&nbsp;
                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='datos_historicos']/node()"/>-->
                            	</xsl:when>
								<xsl:otherwise><xsl:value-of select="/Mantenimiento/FAMILIA/MENSAJE"/>&nbsp;<xsl:value-of select="/Mantenimiento/FAMILIA/FECHA"/></xsl:otherwise>
							</xsl:choose>
							</span>
						</xsl:if>
						<span class="CompletarTitulo" style="width:400px;">
							<!--	Botones	-->
        					<a class="btnDestacado"  href="javascript:ValidarFormulario(document.forms[0]);">
            					<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
            				</a>
							&nbsp;
        					<a class="btnNormal" href="javascript:document.location='about:blank'">
            					<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
            				</a>
							&nbsp;
						</span>
					</p>
				</div>
				<br/>
				<br/>


				            
                <div clasS="divLeft">
				<div id="ResumenCatalogo" style="display:none;margin-bottom:20px;border-bottom:2px solid #3B5998;">
					<table cellspacing="6px" cellpadding="6px">
					<thead>
						<tr class="sinLinea">
							<th class="trenta">&nbsp;</th>
							<th class="doce"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_nivel']/node()"/></th>
							<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/></th>
							<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
							<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_mvm']/node()"/></th>
							<th class="">&nbsp;</th>
						</tr>
					</thead>

					<tbody>
						<xsl:if test="/Mantenimiento/FAMILIA/NOMBRESNIVELES/NIVEL1">
						<tr id="Nivel_1">
							<td>&nbsp;</td>
							<td class="labelRight"><xsl:value-of select="/Mantenimiento/FAMILIA/NOMBRESNIVELES/NIVEL1"/></td>
							<td class="total datosRight">&nbsp;</td>
							<td class="ref_cliente datosRight">&nbsp;</td>
							<td class="ref_mvm datosRight">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						</xsl:if>

						<xsl:if test="/Mantenimiento/FAMILIA/NOMBRESNIVELES/NIVEL2">
						<tr id="Nivel_2">
							<td>&nbsp;</td>
							<td class="labelRight"><xsl:value-of select="/Mantenimiento/FAMILIA/NOMBRESNIVELES/NIVEL2"/></td>
							<td class="total datosRight">&nbsp;</td>
							<td class="ref_cliente datosRight">&nbsp;</td>
							<td class="ref_mvm datosRight">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						</xsl:if>

						<xsl:if test="/Mantenimiento/FAMILIA/NOMBRESNIVELES/NIVEL3">
						<tr id="Nivel_3">
							<td>&nbsp;</td>
							<td class="labelRight"><xsl:value-of select="/Mantenimiento/FAMILIA/NOMBRESNIVELES/NIVEL3"/></td>
							<td class="total datosRight">&nbsp;</td>
							<td class="ref_cliente datosRight">&nbsp;</td>
							<td class="ref_mvm datosRight">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						</xsl:if>

						<xsl:if test="/Mantenimiento/FAMILIA/NOMBRESNIVELES/NIVEL4">
						<tr id="Nivel_4">
							<td>&nbsp;</td>
							<td class="labelRight"><xsl:value-of select="/Mantenimiento/FAMILIA/NOMBRESNIVELES/NIVEL4"/></td>
							<td class="total datosRight">&nbsp;</td>
							<td class="ref_cliente datosRight">&nbsp;</td>
							<td class="ref_mvm datosRight">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						</xsl:if>

						<tr id="Nivel_5">
							<td>&nbsp;</td>
							<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos_estandar']/node()"/></td>
							<td class="total datosRight">&nbsp;</td>
							<td class="ref_cliente datosRight">&nbsp;</td>
							<td class="ref_mvm datosRight">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
					</tbody>
					</table>
				</div>

				<!--<table class="mediaTabla">-->
				<table cellspacing="6px" cellpadding="6px">
					<input type="hidden" name="CATPRIV_IDUSUARIO" VALUE="{Mantenimiento/US_ID}"/>
					<input type="hidden" name="CATPRIV_IDEMPRESA" VALUE="{Mantenimiento/CATPRIV_IDEMPRESA}" id="CATPRIV_IDEMPRESA"/>
					<input type="hidden" name="CATPRIV_IDFAMILIA" value="{Mantenimiento/FAMILIA/ID}"/>
					<input type="hidden" name="ACCION" id="ACCION" VALUE="{Mantenimiento/ACCION}"/>

					<tr class="sinLinea">
						<td>&nbsp;</td>
						<td class="textLeft"><span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='los_siguientes_caracteres_no_deben_sin_barra']/node()"/></span></td>
					</tr>

					<xsl:choose>
						<xsl:when test="Mantenimiento/FAMILIA/CATEGORIAS">
							<!-- SELECT DE CATEGORIAS -->
							<tr class="sinLinea">
								<td class="labelRight trentacinco">
									<xsl:value-of select="Mantenimiento/FAMILIA/NOMBRESNIVELES/NIVEL1"/>
									<xsl:value-of select="document($doc)/translation/texts/item[@name='de_productos']/node()"/>:
									<xsl:if test="/Mantenimiento/ACCION = 'NUEVAFAMILIA'">
										<span class="camposObligatorios">*</span>
									</xsl:if>
								</td>
								<td class="datosLeft sesenta">
									<xsl:choose>
										<!-- solo consulta -->
										<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/FAMILIA/BLOQUEADO">
											<xsl:for-each select="Mantenimiento/FAMILIA/CATEGORIAS/field/dropDownList/listElem">
												<xsl:if test="ID=../../@current">
													<xsl:value-of select="listItem"/>
												</xsl:if>
											</xsl:for-each>
										</xsl:when>
										<!-- edicion -->
										<xsl:otherwise>
											<xsl:choose>
											<xsl:when test="Mantenimiento/FAMILIA/ID='0'">
												<xsl:call-template name="desplegable">
													<xsl:with-param name="path" select="Mantenimiento/FAMILIA/CATEGORIAS/field"></xsl:with-param>
													<xsl:with-param name="claSel">w300px</xsl:with-param>
												</xsl:call-template>
											</xsl:when>
											<!-- modificacion -->
											<xsl:otherwise>
												<xsl:call-template name="desplegable_disabled">
													<xsl:with-param name="path" select="Mantenimiento/FAMILIA/CATEGORIAS/field"></xsl:with-param>
													<xsl:with-param name="claSel">w300px</xsl:with-param>
												</xsl:call-template>
											</xsl:otherwise>
											</xsl:choose>
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
							<!-- FIN SELECT DE CATEGORIAS -->
						</xsl:when>
						<xsl:otherwise>
							<input type="hidden" name="CATPRIV_IDCATEGORIA" value="{Mantenimiento/FAMILIA/IDCATEGORIA}"/>
						</xsl:otherwise>
					</xsl:choose>

					<tr class="sinLinea">
						<td class="labelRight trentacinco">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/>
							<xsl:if test="/Mantenimiento/ACCION = 'NUEVAFAMILIA'">
								<span class="camposObligatorios">*</span>
							</xsl:if>:&nbsp;
						</td>
						<td class="datosLeft sesanta">
							<xsl:choose>
								<!-- CONSULTA -->
								<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/FAMILIA/BLOQUEADO">
									<xsl:value-of select="Mantenimiento/FAMILIA/REFERENCIA"/>
									<input type="hidden" name="CATPRIV_REFERENCIAFAMILIA" value="{Mantenimiento/FAMILIA/REFERENCIA}"/>
								</xsl:when>
								<!-- EDICION -->
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="Mantenimiento/FAMILIA/ID='0'">
											<xsl:if test="/Mantenimiento/FAMILIA/CODIFICACIONNIVELES[@MostrarCategoria='S']">
												<input type="hidden" name="CATPRIV_REFERENCIA_TXT" id="CATPRIV_REFERENCIA_TXT" disabled="disabled" class="noinput muypeq" size="1"/><!--9may22 pasamos esto a hidden-->
												<strong><xsl:value-of select="/Mantenimiento/FAMILIA/REFMVM_ANTERIOR"/></strong>&nbsp;
											</xsl:if>
											<input type="hidden" name="CATPRIV_REFERENCIA_STRING1" id="CATPRIV_REFERENCIA_STRING1"/>
											<input type="text" class="campopesquisa w30px" id="CATPRIV_REF" name="CATPRIV_REFERENCIA_STRING2" size="1">
												<xsl:choose>
												<xsl:when test="/Mantenimiento/FAMILIA/CODIFICACIONNIVELES[@MostrarCategoria='S']">
													<xsl:attribute name="maxlength"><xsl:value-of select="string-length(/Mantenimiento/FAMILIA/CODIFICACIONNIVELES/NIVEL2) - string-length(/Mantenimiento/FAMILIA/CODIFICACIONNIVELES/NIVEL1)"/></xsl:attribute>
												</xsl:when>
												<xsl:otherwise>
													<xsl:attribute name="maxlength"><xsl:value-of select="string-length(/Mantenimiento/FAMILIA/CODIFICACIONNIVELES/NIVEL2)"/></xsl:attribute>
												</xsl:otherwise>
												</xsl:choose>
											</input>&nbsp;
											<input type="hidden" name="CATPRIV_REFERENCIA_AUX"/>
											<input type="hidden" name="CATPRIV_REFERENCIAFAMILIA"/>&nbsp;
											<a class="btnDiscreto" href="javascript:ValidarRefFamilia(document.forms[0]);" style="text-decoration:none;">
												<xsl:value-of select="document($doc)/translation/texts/item[@name='comprobar']/node()"/>
											</a>
											<span id="RefFamilia_OK" style="display:none;">&nbsp;
												<img src="http://www.newco.dev.br/images/recibido.gif">
													<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia_correcta']/node()"/></xsl:attribute>
                                        		</img>
											</span>
											<span id="RefFamilia_ERROR" style="color:#FE2E2E;display:none;">&nbsp;
												<img src="http://www.newco.dev.br/images/error.gif">
													<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='existe_referencia']/node()"/></xsl:attribute>
                                        					                        </img>&nbsp;
												<span id="RefFamilia_ERROR_TXT"><xsl:value-of select="document($doc)/translation/texts/item[@name='ya_existe_ref']/node()"/></span>
											</span><br />
											<span id="ley_ref_familia">&nbsp;</span>
										</xsl:when>
										<xsl:otherwise>
                                            <xsl:value-of select="Mantenimiento/FAMILIA/REFERENCIA"/>
											<input type="hidden" name="CATPRIV_REFERENCIAFAMILIA" value="{Mantenimiento/FAMILIA/REFERENCIA}" size="4" maxlength="{string-length(Mantenimiento/FAMILIA/CODIFICACIONNIVELES/NIVEL2)}"/>
											&nbsp;<span class="fuentePeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='para_modificar_consultar']/node()"/></span>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>

					<tr class="sinLinea">
						<td class="labelRight">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:&nbsp;
							<span class="camposObligatorios">*</span>
						</td>
						<td class="datosLeft">
							<xsl:choose>
								<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/FAMILIA/BLOQUEADO">
									<xsl:value-of select="Mantenimiento/FAMILIA/NOMBRE"/>
									<input type="hidden" name="CATPRIV_NOMBRE" value="{Mantenimiento/FAMILIA/NOMBRE}"/>
								</xsl:when>
								<xsl:otherwise>
									<input type="text"  class="campopesquisa w300px" name="CATPRIV_NOMBRE" value="{Mantenimiento/FAMILIA/NOMBRE}" size="50" maxlength="100"/>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>

					<tr class="sinLinea">
						<td class="labelRight">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:&nbsp;
						</td>
						<td class="datosLeft">
							<xsl:choose>
								<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
									<xsl:value-of select="Mantenimiento/FAMILIA/REFCLIENTE"/>
									<input type="hidden" name="CATPRIV_REFCLIENTE" id="CATPRIV_REFCLIENTE" value="{Mantenimiento/FAMILIA/REFCLIENTE}"/>
								</xsl:when>
								<xsl:otherwise>
									<input type="hidden" name="CATPRIV_REFCLIENTE_AUX" id="CATPRIV_REFCLIENTE_AUX" value="{Mantenimiento/FAMILIA/REFCLIENTE}"/>
									<input type="text" class="campopesquisa w100px" name="CATPRIV_REFCLIENTE" id="CATPRIV_REFCLIENTE" value="{Mantenimiento/FAMILIA/REFCLIENTE}" maxlength="20"/>&nbsp;
									<a class="btnDiscreto" href="javascript:ValidarRefCliente(document.forms[0],'FAMILIAS');">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='comprobar']/node()"/>
									</a>
									<span id="RefCliente_OK" style="display:none;">&nbsp;
										<img src="http://www.newco.dev.br/images/recibido.gif">
											<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia_correcta']/node()"/></xsl:attribute>
										</img>
									</span>
									<span id="RefCliente_ERROR" style="color:#FE2E2E;display:none;">&nbsp;
										<img src="http://www.newco.dev.br/images/error.gif">
											<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='existe_ref_cliente']/node()"/></xsl:attribute>
										</img>&nbsp;
										<span class="text"><xsl:value-of select="document($doc)/translation/texts/item[@name='existe_ref_cliente_nivel']/node()"/></span>
									</span>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
					<tr class="sinLinea">
						<td class="labelRight">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/>:&nbsp;
						</td>
						<td class="datosLeft">
							<xsl:choose>
								<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
									<xsl:value-of select="Mantenimiento/FAMILIA/NOMBRESELECCION"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="desplegable">
										<xsl:with-param name="path" select="Mantenimiento/FAMILIA/CP_FAM_IDSELECCION/field"/>
										<xsl:with-param name="claSel">w300px</xsl:with-param>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>

					<tr class="sinLinea">
						<td>&nbsp;</td>
						<td colspan="2">&nbsp;</td>
						<td>&nbsp;</td>
					</tr>

					<tr class="sinLinea">
						<td>&nbsp;</td>
						<td colspan="2" class="textLeft">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='los_campos_marcados_con']/node()"/>
							&nbsp;(<span class="camposObligatorios">*</span>)&nbsp;
							<xsl:value-of select="document($doc)/translation/texts/item[@name='son_obligatorios']/node()"/>.
						</td>
					</tr>
				</table>
                </div><!--fin de divleft-->
			</form>
		</xsl:otherwise>
	</xsl:choose>
   
</body>
</html>
</xsl:template>
</xsl:stylesheet>
