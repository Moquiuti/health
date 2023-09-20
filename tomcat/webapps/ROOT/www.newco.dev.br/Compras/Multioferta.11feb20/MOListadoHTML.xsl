<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	ultima revision: ET 17mar17 10:40
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/Multiofertas">

<html>
<head>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

	<xsl:text disable-output-escaping="yes">
	<![CDATA[
		<script type="text/javascript">
		<!--
			Actualitza_Cookie('MOListado','Iniciar');

			function Visualiza(sel){
				var seleccionado=sel.options[sel.selectedIndex].value;
				document.location.href="]]></xsl:text>MOListado.xsql?ROL=<xsl:value-of select="/Multiofertas/ROL"/>&amp;TIPO=<xsl:value-of select="/Multiofertas/TIPO"/>&amp;ID=<xsl:text disable-output-escaping="yes"><![CDATA["+seleccionado;
			}

			function CerrarVentana(){
				if(window.parent.opener && !window.parent.opener.closed){
					if(window.parent.opener.location.href=='http://www.newco.dev.br' || window.parent.opener.location.href=='http://www.newco.dev.br/'){
						document.location.href='http://www.newco.dev.br/Personal/BandejaTrabajo/WFStatus.xsql';
					}else{
						window.parent.opener.location.href=window.parent.opener.location.href;
					}
				}
				window.close();
			}
		//-->
		</script>
	]]>
	</xsl:text>
</head>

<body>
	<div class="divCenter">
		<xsl:choose><!-- error -->
			<xsl:when test="//xsql-error">
				<xsl:apply-templates select="//xsql-error"/>
			</xsl:when>
			<xsl:when test="//SESION_CADUCADA">
				<xsl:apply-templates select="//SESION_CADUCADA"/>
			</xsl:when>
			<xsl:otherwise><!--  no error -->
            
				<!--idioma-->
				<xsl:variable name="lang">
					<xsl:value-of select="/Multiofertas/LANG"/>
				</xsl:variable>
				<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
				<!--idioma fin-->

				<!--	Titulo de la página		-->
				<div class="ZonaTituloPagina">
					<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/></span></p>
					<p class="TituloPagina">
						<xsl:value-of select="/Multiofertas/LISTATAREAS/TITULO"/>&nbsp;&nbsp;
						&nbsp;&nbsp;
						<span class="CompletarTitulo">
							<a class="btnNormal" href="javascript:window.print();">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
							</a>
							&nbsp;
							<a class="btnNormal" href="javascript:parent.window.close();">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
							</a>
						</span>
					</p>
				</div>
				<br/>
				<br/>

				<!--
				<h1 class="titlePage"><xsl:value-of select="/Multiofertas/LISTATAREAS/TITULO"/></h1>
				-->

				<!--BOTONES arriba- ->
				<xsl:if test="count(LISTATAREAS/TAREA)>15">
					<div class="botonLeft">
						<img src="http://www.newco.dev.br/images/imprimir.gif"/>&nbsp;
						<a href="javascript:window.print();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
						</a>

						&nbsp;<xsl:value-of select="count(LISTATAREAS/TAREA)"/>
						&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eis_elemento']/node()"/>
					</div><!- -fin de botonLeft- ->

					<div class="botonRight">
						<img src="http://www.newco.dev.br/images/cerrar.gif"/>&nbsp;
						<a href="javascript:parent.window.close();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
						</a>

					</div><!- -fin de botonRight- ->
				</xsl:if><!- -FIN DE BOTONES-->
               

				<table class="buscador">
                <!--idioma-->
				<xsl:variable name="lang">
					<xsl:value-of select="/Multiofertas/LANG"/>
				</xsl:variable>
				<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
				<!--idioma fin-->
					<xsl:choose><!--  no error /sorry -->
						<xsl:when test="//Sorry">
							<tr>
								<td colspan="4" align="center">
                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='eis_sin_elementos_en_buzon']/node()"/>
                                </td>
							</tr>
						</xsl:when>
						<xsl:otherwise><!--  no error / no sorry -->
							<!-- ********** CABECERA ********* -->
							<thead>
								<tr class="subTituloTabla">
									<!--bloaqueado-->
									<th class="zerouno">&nbsp;</th>
									<!-- numero -->
									<th class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='eis_num']/node()"/></th>
									<!-- fecha -->
									<th class="cinco">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='eis_fecha']/node()"/>
<!--										<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0365' and @lang=$lang]"/>-->
									</th>
									<!-- Si es usuario gerente mostramos los datos del usuario. -->
									<xsl:if test="LISTATAREAS/GERENTE">
										<!-- usuario -->
										<th class="ocho">
											<xsl:value-of select="document($doc)/translation/texts/item[@name='eis_usuario']/node()"/>
<!--											<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0375' and @lang=$lang]"/>-->
										</th>
										<!-- centro del usuario -->
										<th class="dies">
											<xsl:value-of select="document($doc)/translation/texts/item[@name='eis_centro']/node()"/>
<!--											<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0377' and @lang=$lang]"/>-->
										</th>
									</xsl:if>
									<!-- empresa proveedor-->
									<th class="ocho">
										<xsl:value-of select="LISTATAREAS/TITULOEMPRESA"/>
									</th>
									<!-- Estado -->
									<th class="trentacinco">
										<xsl:value-of select="document($doc)/translation/texts/item[@name='eis_estado']/node()"/>
<!--										<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0380' and @lang=$lang]"/>-->
									</th>

									<xsl:choose><!-- no error / no sorry / comprador -->
										<xsl:when test="LISTATAREAS/ROL[.='C']">
											<!-- plantilla -->
											<th class="cinco">
												<xsl:value-of select="document($doc)/translation/texts/item[@name='eis_plantilla']/node()"/>
<!--												<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0305' and @lang=$lang]"/>-->
											</th>
										</xsl:when>
									</xsl:choose>

									<!-- Fecha 3 fecha pedido-->
									<th class="cinco">
										<xsl:value-of select="LISTATAREAS/TITULOFECHA3"/>
									</th>
									<th class="cinco">
										<!-- Fecha 2 -->
										<xsl:value-of select="LISTATAREAS/TITULOFECHA2"/>
									</th>
									<xsl:if test="/Multiofertas/LANG = 'spanish'">
										<th class="cuatro">
											<!-- Importe -->
											<xsl:value-of select="document($doc)/translation/texts/item[@name='eis_total_siva']/node()"/>
<!--											Total s/IVA-->
										</th>
									</xsl:if>
								</tr>
							</thead>
							<!-- ********** DATOS ********* -->
							<tbody>
								<xsl:for-each select="LISTATAREAS/TAREA">
									<tr>
										<xsl:choose>
											<xsl:when test="IDINCIDENCIA!=''">
												<xsl:attribute name="class">claroAlerta</xsl:attribute>
											</xsl:when>
											<xsl:otherwise>
												<xsl:attribute name="class">claro</xsl:attribute>
											</xsl:otherwise>
										</xsl:choose>
										<!--bloqueado-->
										<td>
											<xsl:if test="BLOQUEADO ='S'">
												<img src="http://www.newco.dev.br/images/SemaforoRojo.gif"/>
											</xsl:if>
										</td>
										<!--numero-->
										<xsl:apply-templates select="MO_ID"/>
										<td>
											<xsl:choose>
												<xsl:when test="STATUS_COLOR[.='OPONENT_SIDE']">
													<a>
														<xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="ID"/>','Multioferta');</xsl:attribute>
														<xsl:attribute name="onMouseOver">window.status='Ver oferta.';return true;</xsl:attribute>
														<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
														<xsl:attribute name="class">
															<xsl:if test="IDINCIDENCIA!=''">alerta</xsl:if>
														</xsl:attribute>
														<xsl:apply-templates select="NUMERO"/>
													</a>
												</xsl:when>
												<xsl:when test="STATUS_COLOR[.='DEAD_PROCESS']">
													<a>
														<xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="ID"/>','Multioferta');</xsl:attribute>
														<xsl:attribute name="onMouseOver">window.status='Ver oferta.';return true;</xsl:attribute>
														<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
														<xsl:attribute name="class">
															<xsl:if test="IDINCIDENCIA!=''">alerta</xsl:if>
														</xsl:attribute>
														<xsl:apply-templates select="NUMERO"/>
													</a>
												</xsl:when>
												<xsl:when test="STATUS_COLOR[.='ACTION_REQUIRED']">
													<b>
														<a>
															<xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="ID"/>','Multioferta');</xsl:attribute>
															<xsl:attribute name="onMouseOver">window.status='Abrir oferta pendiente de acción.';return true;</xsl:attribute>
															<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
															<xsl:attribute name="class">
																<xsl:if test="IDINCIDENCIA!=''">alerta</xsl:if>
															</xsl:attribute>
															<xsl:apply-templates select="NUMERO"/>
														</a>
													</b>
												</xsl:when>
											</xsl:choose>
										</td>
										<td>
											<a>
												<xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="ID"/>','Multioferta');</xsl:attribute>
												<xsl:attribute name="onMouseOver">window.status='Ver oferta.';return true;</xsl:attribute>
												<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
												<xsl:attribute name="class">
													<xsl:if test="IDINCIDENCIA!=''">alerta</xsl:if>
												</xsl:attribute>
												<xsl:apply-templates select="FECHA"/>
											</a>
										</td>
										<xsl:if test="../GERENTE">
											<td class="textLeft">
												<xsl:apply-templates select="MO_USUARIO"/>
											</td>
											<td class="textLeft">
												<xsl:apply-templates select="CENTRO"/>
											</td>
										</xsl:if>
										<td class="textLeft">
											<xsl:choose>
												<xsl:when test="/Multiofertas/LISTATAREAS/ROL[.='C']">
													<xsl:apply-templates select="EMPRESA2"/>
												</xsl:when>
												<xsl:when test="/Multiofertas/LISTATAREAS/ROL[.='V']">
													<xsl:apply-templates select="CENTRO2"/>
												</xsl:when>
											</xsl:choose>
										</td>
										<td class="textLeft">
											<xsl:choose>
												<xsl:when test="STATUS_COLOR[.='OPONENT_SIDE']">
													<a>
														<xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="ID"/>','Multioferta');</xsl:attribute>
														<xsl:attribute name="onMouseOver">window.status='Ver oferta.';return true;</xsl:attribute>
														<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
														<xsl:attribute name="class">
															<xsl:if test="IDINCIDENCIA!=''">alerta</xsl:if>
														</xsl:attribute>
														<xsl:value-of select="ERW_DESCRIPCION_BANDEJA"/>
													</a>
												</xsl:when>
												<xsl:when test="STATUS_COLOR[.='DEAD_PROCESS']">
													<a>
														<xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="ID"/>','Multioferta');</xsl:attribute>
														<xsl:attribute name="onMouseOver">window.status='Ver oferta.';return true;</xsl:attribute>
														<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
														<xsl:attribute name="class">
															<xsl:if test="IDINCIDENCIA!=''">alerta</xsl:if>
														</xsl:attribute>
														<xsl:value-of select="ERW_DESCRIPCION_BANDEJA"/>
													</a>
												</xsl:when>
												<xsl:when test="STATUS_COLOR[.='ACTION_REQUIRED']">
													<b>
														<a>
															<xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="ID"/>','Multioferta');</xsl:attribute>
															<xsl:attribute name="onMouseOver">window.status='Abrir oferta pendiente de acción.';return true;</xsl:attribute>
															<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
															<xsl:attribute name="class">
																<xsl:if test="IDINCIDENCIA!=''">alerta</xsl:if>
															</xsl:attribute>
															<xsl:value-of select="ERW_DESCRIPCION_BANDEJA"/>
														</a>
													</b>
												</xsl:when>
											</xsl:choose>
										</td>
										<xsl:choose>
											<xsl:when test="/Multiofertas/LISTATAREAS/ROL[.='C']">
												<td class="textLeft">
													<xsl:apply-templates select="LP_NOMBRE"/> <!-- presentamos el nombre de la plantilla -->
												</td>
											</xsl:when>
										</xsl:choose>
										<td>
											<a>
												<xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="ID"/>','Multioferta');</xsl:attribute>
												<xsl:attribute name="onMouseOver">window.status='Ver oferta.';return true;</xsl:attribute>
												<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
												<xsl:attribute name="class">
													<xsl:if test="IDINCIDENCIA!=''">alerta</xsl:if>
												</xsl:attribute>
												<xsl:value-of select="FECHA3"/>
											</a>
										</td>
										<td>
											<a>
												<xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="ID"/>','Multioferta');</xsl:attribute>
												<xsl:attribute name="onMouseOver">window.status='Ver oferta.';return true;</xsl:attribute>
												<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
												<xsl:attribute name="class">
													<xsl:if test="IDINCIDENCIA!=''">alerta</xsl:if>
												</xsl:attribute>
												<xsl:value-of select="FECHA2"/>
											</a>
										</td>
										<xsl:if test="/Multiofertas/LANG = 'spanish'">
											<td>
												<a>
													<xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="ID"/>','Multioferta');</xsl:attribute>
													<xsl:attribute name="onMouseOver">window.status='Ver oferta.';return true;</xsl:attribute>
													<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
													<xsl:attribute name="class">
														<xsl:if test="IDINCIDENCIA!=''">alerta</xsl:if>
													</xsl:attribute>
													<xsl:value-of select="SUBTOTAL"/>
												</a>
											</td>
										</xsl:if>
									</tr>
								</xsl:for-each>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="11">
										<strong><xsl:value-of select="count(LISTATAREAS/TAREA)"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eis_elemento']/node()"/></strong>
									</td>
								</tr>
							</tfoot>
						</xsl:otherwise>
					</xsl:choose><!-- error -->
				</table>   <!--fin de tabla compras-->
				<!--<xsl:apply-templates select="jumpTo"/>-->
			</xsl:otherwise>
		</xsl:choose>
	</div><!--fin de middle-->
</body>
</html>
</xsl:template>

<xsl:template match="MO_ID"></xsl:template>

<xsl:template match="EMPRESA2">
	<a>
		<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="../EMP_ID2"/>&amp;VENTANA=NUEVA','Empresa',100,80,0,0)</xsl:attribute>
		<xsl:attribute name="onMouseOver">window.status='Información sobre la empresa.';return true;</xsl:attribute>
		<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
		<xsl:attribute name="class">
			<xsl:if test="../IDINCIDENCIA!=''">alerta</xsl:if>
		</xsl:attribute>
		<xsl:value-of select="."/>
	</a>
</xsl:template>

<xsl:template match="MO_USUARIO">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="CENTRO2">
	<a>
		<xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID=<xsl:value-of select="../CEN_ID2"/>&amp;VENTANA=NUEVA','Centro')</xsl:attribute>
		<xsl:attribute name="onMouseOver">window.status='Información sobre la empresa.';return true;</xsl:attribute>
		<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
		<xsl:attribute name="class">
			<xsl:if test="../IDINCIDENCIA!=''">alerta</xsl:if>
		</xsl:attribute>
		<xsl:value-of select="."/>
	</a>
</xsl:template>

<xsl:template match="CENTRO">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="LP_NOMBRE">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="FECHA_ENTRADA">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="ERW_DESCRIPCION_BANDEJA">
	<a>
		<xsl:attribute name="href">MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="../MO_ID"/></xsl:attribute>
		<xsl:attribute name="onMouseOver">window.status='Abrir multioferta.';return true;</xsl:attribute>
		<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
		<!--<xsl:attribute name="href">Multioferta.xsql?MO_ID=<xsl:value-of select="../MO_ID"/>&amp;ROL=<xsl:value-of select="/Multiofertas/ROL"/>&amp;TIPO=<xsl:value-of select="/Multiofertas/TIPO"/>&amp;xml-stylesheet=none</xsl:attribute>-->
		<xsl:attribute name="class">
			<xsl:if test="../IDINCIDENCIA!=''">alerta</xsl:if>
		</xsl:attribute>
		<xsl:value-of select="."/>
	</a>
</xsl:template>

<xsl:template match="Sorry">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/Multiofertas/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
    			
	<p>
		<xsl:value-of select="document($doc)/translation/texts/item[@name='eis_sin_elementos_en_buzon']/node()"/>
	</p>
</xsl:template>

</xsl:stylesheet>
