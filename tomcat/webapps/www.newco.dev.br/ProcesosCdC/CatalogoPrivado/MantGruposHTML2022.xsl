<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Mantenimiento de GRUPO
	Ultima revisión: ET 7mar22 17:50 MantGrupos2022_070322.js
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
		<xsl:when test="/Mantenimiento/GRUPO/REFERENCIA != ''">
			<xsl:value-of select="Mantenimiento/GRUPO/REFERENCIA"/>&nbsp;<xsl:value-of select="Mantenimiento/GRUPO/NOMBRE"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="document($doc)/translation/texts/item[@name='mant_de']/node()"/>
			<xsl:value-of select="Mantenimiento/GRUPO/NOMBRESNIVELES/NIVEL4"/>
			<xsl:value-of select="document($doc)/translation/texts/item[@name='de_productos']/node()"/>&nbsp;-&nbsp;
            <xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo_privado']/node()"/>
		</xsl:otherwise>
		</xsl:choose>
    </title>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantGrupos2022_070322.js"></script>

	<script>
		var introducir_ref_nuevo_nivel4	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='introducir_ref']/node()"/>";
		var length_ref_nuevo_nivel4	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='length_ref']/node()"/>";
		var introducir_nombre_nivel4	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='introducir_nombre']/node()"/>";
		var raros_alert			= "<xsl:value-of select="document($doc)/translation/texts/item[@name='caracteres_raros']/node()"/>";
		var ya_existe_ref_nivel4	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='ya_existe_ref']/node()"/>";
		var ya_existe_ref_cliente	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='existe_ref_cliente_nivel']/node()"/>";
		var nombre_nivel4		= "<xsl:value-of select="/Mantenimiento/GRUPO/NOMBRESNIVELES/NIVEL4"/>";

        <xsl:choose>
		<xsl:when test="Mantenimiento/GRUPO/NOMBRESNIVELES[@id='custom']">
			introducir_ref_nuevo_nivel4	+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_familia']/node()"/>.";
			length_ref_nuevo_nivel4		+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_familia']/node()"/>";
			introducir_nombre_nivel4	+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_familia']/node()"/>.";
			ya_existe_ref_nivel4		+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_familia']/node()"/>";
		</xsl:when>
        <xsl:when test="Mantenimiento/GRUPO/NOMBRESNIVELES[@id='estandar']">
			introducir_ref_nuevo_nivel4	+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_grupo']/node()"/>.";
			length_ref_nuevo_nivel4		+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_grupo']/node()"/>";
			introducir_nombre_nivel4	+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_grupo']/node()"/>.";
			ya_existe_ref_nivel4		+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_grupo']/node()"/>";
		</xsl:when>
        </xsl:choose>
                
        length_ref_nuevo_nivel4	+= "<xsl:value-of select="document($doc)/translation/texts/item[@name='length_ref_nivel4']/node()"/>";

		chars_nivel4 = "<xsl:value-of select="Mantenimiento/GRUPO/CODIFICACIONNIVELES/NIVEL4"/>";
		leyenda_ref_nivel4	= "<xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_ref_grupo']/node()"/>";

		no_hay		= "<xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_datos']/node()"/>";

		length_nueva_ref_grupo = <xsl:value-of select="string-length(/Mantenimiento/GRUPO/CODIFICACIONNIVELES/NIVEL4) - string-length(/Mantenimiento/GRUPO/CODIFICACIONNIVELES/NIVEL3)"/>;
	</script>

</head>

<!--<body class="gris">-->
<body>
<!-- Si es el alta de un nuevo grupo -->
<!--
<xsl:if test="/Mantenimiento/GRUPO/ID = 0 and (/Mantenimiento/GRUPO/MASTER or /Mantenimiento/GRUPO/MASTER_UNICO)">
	<xsl:attribute name="onload">ReferenciaSubfamilia()</xsl:attribute>
</xsl:if>
-->
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:choose>
		<xsl:when test="//SESION_CADUCADA">
			<xsl:apply-templates select="//SESION_CADUCADA"/>
		</xsl:when>
		<xsl:when test="//Sorry">
			<xsl:apply-templates select="//Sorry"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:if test="Mantenimiento/GRUPO/MENSAJE = 'OK'">
				<xsl:attribute name="onLoad">RecargarInfoCatalogo();</xsl:attribute>
			</xsl:if>

			<form name="form1" action="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantGrupos2022.xsql" method="post">
			
				<!--	Titulo de la página		-->
				<div class="ZonaTituloPagina">
					<p class="TituloPagina">
						<!--	Nombre de la categoría si ya existe o "Categoría" -->
						<xsl:choose>
							<xsl:when test="/Mantenimiento/GRUPO/REFERENCIA != ''">
								<xsl:value-of select="Mantenimiento/GRUPO/REFERENCIA"/>&nbsp;<xsl:value-of select="Mantenimiento/GRUPO/NOMBRE"/>
								<xsl:if test="(/Mantenimiento/GRUPO/MASTER or /Mantenimiento/GRUPO/MASTER_UNICO) and /Mantenimiento/ACCION = 'MODIFICARGRUPO'">
									&nbsp;&nbsp;&nbsp;<span class="amarillo">CP_GRU_ID:&nbsp;<xsl:value-of select="/Mantenimiento/GRUPO/ID"/></span>
								</xsl:if>
                            </xsl:when>
							<xsl:otherwise>	
								<xsl:value-of select="document($doc)/translation/texts/item[@name='mant_de']/node()"/>
								<xsl:value-of select="Mantenimiento/GRUPO/NOMBRESNIVELES/NIVEL4"/>
								<xsl:value-of select="document($doc)/translation/texts/item[@name='de_productos']/node()"/>
							</xsl:otherwise>							
						</xsl:choose>
								
						&nbsp;<a href="#" id="toggleResumenCatalogo" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/info.gif"/></a>
						<xsl:if test="/Mantenimiento/GRUPO/MENSAJE">
							<xsl:choose>
								<xsl:when test="/Mantenimiento/GRUPO/MENSAJE='OK'">
                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='cambios_guardados']/node()"/>
                                	:&nbsp;<xsl:value-of select="/Mantenimiento/GRUPO/FECHA"/>
									<!--&nbsp;-&nbsp;
                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='datos_historicos']/node()"/>-->
                            	</xsl:when>
								<xsl:otherwise><xsl:value-of select="/Mantenimiento/GRUPO/MENSAJE"/>&nbsp;<xsl:value-of select="/Mantenimiento/GRUPO/FECHA"/></xsl:otherwise>
							</xsl:choose>
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
                <div class="divLeft">
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
						<xsl:if test="/Mantenimiento/GRUPO/NOMBRESNIVELES/NIVEL1">
						<tr id="Nivel_1">
							<td>&nbsp;</td>
							<td class="labelRight"><xsl:value-of select="/Mantenimiento/GRUPO/NOMBRESNIVELES/NIVEL1"/></td>
							<td class="total datosRight">&nbsp;</td>
							<td class="ref_cliente datosRight">&nbsp;</td>
							<td class="ref_mvm datosRight">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						</xsl:if>

						<xsl:if test="/Mantenimiento/GRUPO/NOMBRESNIVELES/NIVEL2">
						<tr id="Nivel_2">
							<td>&nbsp;</td>
							<td class="labelRight"><xsl:value-of select="/Mantenimiento/GRUPO/NOMBRESNIVELES/NIVEL2"/></td>
							<td class="total datosRight">&nbsp;</td>
							<td class="ref_cliente datosRight">&nbsp;</td>
							<td class="ref_mvm datosRight">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						</xsl:if>

						<xsl:if test="/Mantenimiento/GRUPO/NOMBRESNIVELES/NIVEL3">
						<tr id="Nivel_3">
							<td>&nbsp;</td>
							<td class="labelRight"><xsl:value-of select="/Mantenimiento/GRUPO/NOMBRESNIVELES/NIVEL3"/></td>
							<td class="total datosRight">&nbsp;</td>
							<td class="ref_cliente datosRight">&nbsp;</td>
							<td class="ref_mvm datosRight">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						</xsl:if>

						<xsl:if test="/Mantenimiento/GRUPO/NOMBRESNIVELES/NIVEL4">
						<tr id="Nivel_4">
							<td>&nbsp;</td>
							<td class="labelRight"><xsl:value-of select="/Mantenimiento/GRUPO/NOMBRESNIVELES/NIVEL4"/></td>
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

				<table cellspacing="6px" cellpadding="6px">
					<input type="hidden" name="CATPRIV_IDUSUARIO" VALUE="{Mantenimiento/US_ID}"/>
					<input type="hidden" name="CATPRIV_IDEMPRESA" VALUE="{Mantenimiento/CATPRIV_IDEMPRESA}" id="CATPRIV_IDEMPRESA"/>
					<input type="hidden" name="CATPRIV_ID" VALUE="{Mantenimiento/GRUPO/ID}"/>
					<input type="hidden" name="CATPRIV_IDSUBFAMILIA" VALUE="{Mantenimiento/GRUPO/IDSUBFAMILIA}"/>
					<input type="hidden" name="ACCION" id="ACCION" VALUE="{Mantenimiento/ACCION}"/>
					<input type="hidden" name="VENTANA" VALUE="{Mantenimiento/VENTANA}"/>

					<tr class="sinLinea">
						<td>&nbsp;</td>
						<td class="textLeft">
							<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='los_siguientes_caracteres_no_deben_sin_barra']/node()"/></span>
						</td>
					</tr>

					<tr class="sinLinea">
						<td class="labelRight trentacinco">
							<xsl:value-of select="Mantenimiento/GRUPO/NOMBRESNIVELES/NIVEL3"/>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='de_productos']/node()"/>
							<xsl:if test="/Mantenimiento/ACCION = 'NUEVOGRUPO'">
								<span class="camposObligatorios">*</span>
							</xsl:if>:&nbsp;
						</td>
						<td class="datosLeft sesenta">
							<xsl:for-each select="Mantenimiento/GRUPO/SUBFAMILIAS/field/dropDownList/listElem">
								<xsl:if test="ID=../../@current">
									<xsl:value-of select="listItem"/>
								</xsl:if>
							</xsl:for-each>
							<!--<xsl:choose>
								<!- - solo consulta - ->
								<xsl:when test="Mantenimiento/TIPO='CONSULTA'">
									<xsl:for-each select="Mantenimiento/GRUPO/SUBFAMILIAS/field/dropDownList/listElem">
										<xsl:if test="ID=../../@current">
											<xsl:value-of select="listItem"/>
										</xsl:if>
									</xsl:for-each>
								</xsl:when>
								<!- - edicion - ->
								<xsl:otherwise>
									<xsl:choose>										
										<!- - no puede modificar la subfamilia de la que depende o puede crear nuevos grupos - ->
										<xsl:when test="Mantenimiento/GRUPO/MASTER or Mantenimiento/GRUPO/MASTER_UNICO">
											<!- - nueva - ->
											<xsl:choose>
												<xsl:when test="Mantenimiento/GRUPO/ID='0'">
													<xsl:call-template name="desplegable">
														<xsl:with-param name="path" select="Mantenimiento/GRUPO/SUBFAMILIAS/field"></xsl:with-param>
														<xsl:with-param name="claSel">w300px</xsl:with-param>
													</xsl:call-template>
												</xsl:when>
												<!- - modificacion - ->
												<xsl:otherwise>
													<xsl:call-template name="desplegable_disabled">
														<xsl:with-param name="path" select="Mantenimiento/GRUPO/SUBFAMILIAS/field"></xsl:with-param>
														<xsl:with-param name="claSel">w300px</xsl:with-param>
													</xsl:call-template>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:when>
										<!- - no puede modificar la subfamilia de la que depende
										<xsl:when test="Mantenimiento/GRUPO/EDICION">
											<xsl:for-each select="Mantenimiento/GRUPO/SUBFAMILIAS/field/dropDownList/listElem">
												<xsl:if test="ID=../../@current">
													<xsl:value-of select="listItem"/>
													<input type="hidden" name="CATPRIV_IDSUBFAMILIA" value="{ID}"/>
												</xsl:if>
											</xsl:for-each>
										</xsl:when>- ->
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>-->
						</td>
					</tr>

					<tr class="sinLinea">
						<td class="labelRight">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/>
							<xsl:if test="/Mantenimiento/ACCION = 'NUEVOGRUPO'">
								<span class="camposObligatorios">*</span>
							</xsl:if>:&nbsp;
						</td>
						<td class="datosLeft">
							<xsl:choose>
								<!-- solo consulta -->
								<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/GRUPO/BLOQUEADO">
									<xsl:value-of select="Mantenimiento/GRUPO/REFERENCIA"/>
									<input type="hidden" name="CATPRIV_REFERENCIA" value="{Mantenimiento/GRUPO/REFERENCIA}"/>
								</xsl:when>
								<!-- edicion -->
								<xsl:otherwise>

									<xsl:choose>
										<xsl:when test="Mantenimiento/GRUPO/ID='0'">
											<input type="hidden" name="CATPRIV_REFERENCIA_TXT" id="CATPRIV_REFERENCIA_TXT" disabled="disabled" class="noinput peq" size="4"/><!--9may22 pasamos esto a hidden-->
											<strong><xsl:value-of select="/Mantenimiento/GRUPO/REFMVM_ANTERIOR"/></strong>&nbsp;
											<input type="hidden" name="CATPRIV_REFERENCIA_STRING1" id="CATPRIV_REFERENCIA_STRING1"/>
											<input type="text"  class="campopesquisa w60px" id="CATPRIV_REF" name="CATPRIV_REFERENCIA_STRING2" size="1">
												<xsl:attribute name="maxlength"><xsl:value-of select="string-length(/Mantenimiento/GRUPO/CODIFICACIONNIVELES/NIVEL4) - string-length(/Mantenimiento/GRUPO/CODIFICACIONNIVELES/NIVEL3)"/></xsl:attribute>
											</input>&nbsp;
											<input type="hidden" name="CATPRIV_REFERENCIA_AUX"/>
											<input type="hidden" name="CATPRIV_REFERENCIA"/>&nbsp;
											<a class="btnDiscreto" href="javascript:ValidarRefGrupo(document.forms[0]);">
												<xsl:value-of select="document($doc)/translation/texts/item[@name='comprobar']/node()"/>
											</a>
											<!--<a href="javascript:ValidarRefGrupo(document.forms[0]);" style="text-decoration:none;">
												<xsl:choose>
												<xsl:when test="/Mantenimiento/LANG = 'portugues'">
													<img src="http://www.newco.dev.br/images/comprobar-BR.gif" alt="Verificar"/>
												</xsl:when>
												<xsl:otherwise>
													<img src="http://www.newco.dev.br/images/comprobar.gif" alt="Comprobar"/>
												</xsl:otherwise>
												</xsl:choose>
											</a>-->
											<span id="RefGrupo_OK" style="display:none;">&nbsp;
												<img src="http://www.newco.dev.br/images/recibido.gif">
													<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia_correcta']/node()"/></xsl:attribute>
                                        					                    	</img>
											</span>
											<span id="RefGrupo_ERROR" style="color:#FE2E2E;display:none;">&nbsp;
												<img src="http://www.newco.dev.br/images/error.gif">
													<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='existe_referencia']/node()"/></xsl:attribute>
                                        					                    	</img>&nbsp;
												<span id="RefGrupo_ERROR_TXT"><xsl:value-of select="document($doc)/translation/texts/item[@name='ya_existe_ref']/node()"/></span>
											</span><br />
											<span id="ley_ref_grupo">&nbsp;</span>
										</xsl:when>
										<!-- modificacion -->
										<xsl:otherwise>
                                        	<xsl:value-of select="Mantenimiento/GRUPO/REFERENCIA"/>
											<input type="hidden" name="CATPRIV_REFERENCIA" value="{Mantenimiento/GRUPO/REFERENCIA}" size="8" maxlength="{string-length(Mantenimiento/GRUPO/CODIFICACIONNIVELES/NIVEL4)}"/>
											&nbsp;<span class="fuentePeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='para_modificar_consultar']/node()"/></span>
										</xsl:otherwise>
									</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>

									<!--
									<xsl:choose>
										
										<!- - no puede modificar la subfamilia de la que depende o puede crear nuevos grupos - ->
										<xsl:when test="Mantenimiento/GRUPO/MASTER or Mantenimiento/GRUPO/MASTER_UNICO">
											<!- - nuevo - ->
											<xsl:choose>
												<xsl:when test="Mantenimiento/GRUPO/ID='0'">
													<input type="text" name="CATPRIV_REFERENCIA_TXT" id="CATPRIV_REFERENCIA_TXT" disabled="disabled" class="noinput peq" size="4"/>
													<input type="hidden" name="CATPRIV_REFERENCIA_STRING1" id="CATPRIV_REFERENCIA_STRING1"/>
													<input type="text" class="peq" id="CATPRIV_REF" name="CATPRIV_REFERENCIA_STRING2" size="1">
														<xsl:attribute name="maxlength"><xsl:value-of select="string-length(/Mantenimiento/GRUPO/CODIFICACIONNIVELES/NIVEL4) - string-length(/Mantenimiento/GRUPO/CODIFICACIONNIVELES/NIVEL3)"/></xsl:attribute>
													</input>&nbsp;
													<input type="hidden" name="CATPRIV_REFERENCIA_AUX"/>
													<input type="hidden" name="CATPRIV_REFERENCIA"/>&nbsp;
													<a href="javascript:ValidarRefGrupo(document.forms[0]);" style="text-decoration:none;">
														<xsl:choose>
														<xsl:when test="/Mantenimiento/LANG = 'portugues'">
															<img src="http://www.newco.dev.br/images/comprobar-BR.gif" alt="Verificar"/>
														</xsl:when>
														<xsl:otherwise>
															<img src="http://www.newco.dev.br/images/comprobar.gif" alt="Comprobar"/>
														</xsl:otherwise>
														</xsl:choose>
													</a>
													<span id="RefGrupo_OK" style="display:none;">&nbsp;
														<img src="http://www.newco.dev.br/images/recibido.gif">
															<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia_correcta']/node()"/></xsl:attribute>
                                        					                                </img>
													</span>
													<span id="RefGrupo_ERROR" style="color:#FE2E2E;display:none;">&nbsp;
														<img src="http://www.newco.dev.br/images/error.gif">
															<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='existe_referencia']/node()"/></xsl:attribute>
                                        					                                </img>&nbsp;
														<span id="RefGrupo_ERROR_TXT"><xsl:value-of select="document($doc)/translation/texts/item[@name='ya_existe_ref']/node()"/></span>
													</span><br />
													<span id="ley_ref_grupo">&nbsp;</span>
													<!- -<xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda_ref_grupo']/node()"/>- ->
													<!- -{Mantenimiento/PRODUCTOESTANDAR/TODOSGRUPOS/SUBFAMILIA[@current = ID]/GRUPO[@current = ID]/SIGUIENTE}- ->
												</xsl:when>
												<!- - modificacion - ->
												<xsl:otherwise>
                                                    <xsl:value-of select="Mantenimiento/GRUPO/REFERENCIA"/>
													<input type="hidden" name="CATPRIV_REFERENCIA" value="{Mantenimiento/GRUPO/REFERENCIA}" size="8" maxlength="{string-length(Mantenimiento/GRUPO/CODIFICACIONNIVELES/NIVEL4)}"/>
													&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='para_modificar_consultar']/node()"/>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:when>
										<!- - no puede modificar la subfamilia de la que depende - ->
										<xsl:when test="Mantenimiento/GRUPO/EDICION">
											<xsl:value-of select="Mantenimiento/GRUPO/REFERENCIA"/>
											<input type="hidden" name="CATPRIV_REFERENCIA" value="{Mantenimiento/GRUPO/REFERENCIA}"/>
										</xsl:when>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>-->
						</td>
					</tr>

					<tr class="sinLinea">
						<td class="labelRight">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:&nbsp;
							<span class="camposObligatorios">*</span>
						</td>
						<td class="datosLeft">
							<xsl:choose>
								<xsl:when test="Mantenimiento/TIPO='CONSULTA' or Mantenimiento/GRUPO/BLOQUEADO">
									<xsl:value-of select="Mantenimiento/GRUPO/NOMBRE"/>
									<input type="hidden" name="CATPRIV_NOMBRE" value="{Mantenimiento/GRUPO/NOMBRE}"/>
								</xsl:when>
								<xsl:otherwise>
									<input type="text" class="campopesquisa w300px" name="CATPRIV_NOMBRE" value="{Mantenimiento/GRUPO/NOMBRE}" size="70" maxlength="300"/>
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
									<xsl:value-of select="Mantenimiento/SUBFAMILIA/REFCLIENTE"/>
								</xsl:when>
								<xsl:otherwise>
									<input type="hidden" name="CATPRIV_REFCLIENTE_AUX" id="CATPRIV_REFCLIENTE_AUX" value="{Mantenimiento/GRUPO/REFCLIENTE}"/>
									<input type="text" class="campopesquisa w100px" name="CATPRIV_REFCLIENTE" id="CATPRIV_REFCLIENTE" value="{Mantenimiento/GRUPO/REFCLIENTE}" maxlength="20"/>&nbsp;
									<a class="btnDiscreto" href="javascript:ValidarRefCliente(document.forms[0],'GRUPOS');" style="text-decoration:none;">
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
						<td>&nbsp;</td>
						<td colspan="2">&nbsp;</td>
						<td>&nbsp;</td>
					</tr>

					<tr class="sinLinea">
						<td>&nbsp;</td>
						<td colspan="2" class="textLeft fuentePeq">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='los_campos_marcados_con']/node()"/>
							&nbsp;(<span class="camposObligatorios">*</span>)&nbsp;
							<xsl:value-of select="document($doc)/translation/texts/item[@name='son_obligatorios']/node()"/>.
						</td>
					</tr>
				</table>
                </div><!--fin de divleft-->
			</form>

			<form name="MensajeJS">
				<input type="hidden" name="SELECCIONAR_SUBFAMILIA_GRUPO" value="{document($doc)/translation/texts/item[@name='seleccionar_subfamilia_grupo']/node()}"/>
			</form>
		</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
