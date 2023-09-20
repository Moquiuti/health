<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Ultima revision: ET 30dic16 08:46
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:param name="usuario" select="@US_ID"/>

<xsl:template match="/IncidenciasProd">

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="//LANG"><xsl:value-of select="//LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<META Http-Equiv="Cache-Control" Content="no-cache" />

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='incidencias']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

	<script type="text/javascript">
		function DescargarExcel(){
			var FIDEmpresa		= jQuery('#FIDEMPRESA').val();
			var FIDCentro		= jQuery('#FIDCENTRO').val();
			var FIDResponsable	= jQuery('#FIDRESPONSABLE').val();
			var FIDProveedor	= jQuery('#FPROVEEDOR').val();
			var FIDProducto		= jQuery('#FPRODUCTO').val();
			var FTexto		= codificacionAjax(jQuery('#FTEXTO').val());
			var FEstado		= jQuery('#FESTADO').val();
			var d			= new Date();

			jQuery.ajax({
				url: 'http://www.newco.dev.br/Gestion/Comercial/IncidenciasExcel.xsql',
				data: "FIDEMPRESA="+FIDEmpresa+"&amp;FIDCENTRO="+FIDCentro+"&amp;FIDRESPONSABLE="+FIDResponsable+"&amp;FIDPROVEEDOR="+FIDProveedor+"&amp;FIDPRODUCTO="+FIDProducto+"&amp;FTEXTO="+FTexto+"&amp;FESTADO="+FEstado+"&amp;_="+d.getTime(),
                                type: "GET",
                                contentType: "application/xhtml+xml",
                                beforeSend: function(){
                                        null;
                                },
                                error: function(objeto, quepaso, otroobj){
                                        alert('error'+quepaso+' '+otroobj+''+objeto);
                                },
                                success: function(objeto){
                                        var data = eval("(" + objeto + ")");

                                        if(data.estado == 'ok')
                                                window.location='http://www.newco.dev.br/Descargas/'+data.url;
                                        else
                                                alert('Se ha producido un error. No se puede descargar el fichero.');
                                }
                        });
                }

		function BuscarIncidenciasProductos(oForm){
			SubmitForm(oForm);
		}

		function BorrarIncidenciaProducto(IDInc){
			var d			= new Date();

			jQuery.ajax({
				url: 'http://www.newco.dev.br/Gestion/Comercial/BorrarIncidenciaProducto.xsql',
				data: "IDINCIDENCIA="+IDInc+"&amp;_="+d.getTime(),
				type: "GET",
				contentType: "application/xhtml+xml",
				beforeSend: function(){
					jQuery("#IncBorradaOK").hide();
					jQuery("#IncBorradaKO").hide();
				},
				error: function(objeto, quepaso, otroobj){
					alert('error'+quepaso+' '+otroobj+''+objeto);
				},
				success: function(objeto){
					var data = eval("(" + objeto + ")");

					if(data.estado == 'OK'){
						var IDIncidencia = data.id;

						jQuery("#IncBorradaOK").show();
						jQuery("#INC_" + IDIncidencia).hide();
					}else
						jQuery("#IncBorradaKO").show();
				}
			});
		}

                function Reset(form){
                    form.elements['FIDEMPRESA'].value = '-1';
                    form.elements['FIDCENTRO'].value = '-1';
                    form.elements['FPRODUCTO'].value = '-1';
                    form.elements['FPROVEEDOR'].value = '-1';
                    form.elements['FTEXTO'].value = '';
                }
	</script>
</head>
<body>
	<xsl:attribute name="onload">
    	<xsl:if test="/IncidenciasProd/PROVEEDOR != ''">javascript:BuscarIncidenciasProductos(document.forms['Buscador']);</xsl:if>
    </xsl:attribute>
<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="//LANG"><xsl:value-of select="//LANG"/></xsl:when>
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

		<xsl:variable name="usuario">
		<xsl:choose>
			<xsl:when test="not(INCIDENCIASPRODUCTOS/OBSERVADOR) and INCIDENCIASPRODUCTOS/CDC">CDC</xsl:when>
			<xsl:otherwise>NORMAL</xsl:otherwise>
		</xsl:choose>
		</xsl:variable>

	
		<!--	Titulo de la p�gina		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='incidencias']/node()"/></span></p>
			<p class="TituloPagina">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='incidencias']/node()"/>&nbsp;&nbsp;
				&nbsp;&nbsp;
				<span class="CompletarTitulo">
					<xsl:if test="INCIDENCIASPRODUCTOS/INCIDENCIA">
						&nbsp;&nbsp;<a class="btnNormal" href="javascript:DescargarExcel();">
							<img alt="Descargar Excel" src="http://www.newco.dev.br/images/iconoExcel.gif" title="Descargar Excel"/>
						</a>
					</xsl:if>
				</span>
			</p>
		</div>
		<br/>
		<br/>
		<br/>
		<!--	Cambio CSS
		<h1 class="titlePage" style="border:0px;">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='incidencias']/node()"/>
			<xsl:if test="INCIDENCIASPRODUCTOS/INCIDENCIA">
				&nbsp;&nbsp;<a href="javascript:DescargarExcel();">
					<img alt="Descargar Excel" src="http://www.newco.dev.br/images/iconoExcel.gif" title="Descargar Excel"/>
				</a>
			</xsl:if>
		</h1>
		-->

		<form name="Buscador" method="post" action="IncidenciasProductos.xsql">
		<table class="buscador">
			<!--<tr class="select" height="50px">-->
			<tr class="filtros" height="50px">
				<th width="80px">
                    <br />
                    <a href="javascript:Reset(document.forms['Buscador']);">
                        <xsl:choose>
                            <xsl:when test="/IncidenciasProd/LANG='spanish'"><img src="http://www.newco.dev.br/images/sinFiltros.gif" alt="Sin filtros" /></xsl:when>
                            <xsl:otherwise><img src="http://www.newco.dev.br/images/sinFiltros-BR.gif" alt="Nao filtrada" /></xsl:otherwise>
                        </xsl:choose>
                    </a>
                </th>
				<xsl:choose>
				<xsl:when test="INCIDENCIASPRODUCTOS/MVM or INCIDENCIASPRODUCTOS/MVMB or INCIDENCIASPRODUCTOS/ROL = 'VENDEDOR'">
					<th width="140px" style="text-align:left;">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></label><br />
					<xsl:call-template name="desplegable"><xsl:with-param name="path" select="INCIDENCIASPRODUCTOS/FIDEMPRESA/field"/></xsl:call-template>
					</th>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="FIDEMPRESA" value="-1" id="FIDEMPRESA"/>
				</xsl:otherwise>
				</xsl:choose>

				<th width="140px" style="text-align:left;">
				<xsl:choose>
				<xsl:when test="INCIDENCIASPRODUCTOS/ROL = 'COMPRADOR' and INCIDENCIASPRODUCTOS/CDC">
					<input type="hidden" name="FIDRESPONSABLE" value="-1" id="FIDRESPONSABLE"/>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></label><br />
					<xsl:call-template name="desplegable"><xsl:with-param name="path" select="INCIDENCIASPRODUCTOS/FIDCENTRO/field"/></xsl:call-template>
				</xsl:when>
				<xsl:when test="INCIDENCIASPRODUCTOS/ROL != 'VENDEDOR'">
					<input type="hidden" name="FIDCENTRO" value="-1" id="FIDCENTRO"/>
					<input type="hidden" name="FIDRESPONSABLE" value="-1" id="FIDRESPONSABLE"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="FIDRESPONSABLE" value="-1" id="FIDRESPONSABLE"/>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></label><br />
					<xsl:call-template name="desplegable"><xsl:with-param name="path" select="INCIDENCIASPRODUCTOS/FIDCENTRO/field"/></xsl:call-template>
				</xsl:otherwise>
				</xsl:choose>
				</th>
                <th width="140px" style="text-align:left;">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></label><br />
					<xsl:call-template name="desplegable"><xsl:with-param name="path" select="INCIDENCIASPRODUCTOS/FPRODUCTO/field"/></xsl:call-template>
				</th>
				<th width="140px" style="text-align:left;">
				<xsl:choose>
				<xsl:when test="INCIDENCIASPRODUCTOS/ROL != 'VENDEDOR'">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></label><br />
					<xsl:call-template name="desplegable">
                    	<xsl:with-param name="path" select="INCIDENCIASPRODUCTOS/FPROVEEDOR/field"/>
                        <xsl:with-param name="defecto" select="/IncidenciasProd/PROVEEDOR"/>
                    </xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="FPROVEEDOR" value="-1" id="FPROVEEDOR"/>
				</xsl:otherwise>
				</xsl:choose>
				</th>

				<th width="140px" style="text-align:left;"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/></label><br />
					<input type="text" name="FTEXTO" size="10" id="FTEXTO">
						<xsl:attribute name="value"><xsl:value-of select="INCIDENCIASPRODUCTOS/FTEXTO"/></xsl:attribute>
					</input>
				</th>

				<th width="140px" style="text-align:left;">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></label><br />
					<xsl:call-template name="desplegable"><xsl:with-param name="path" select="INCIDENCIASPRODUCTOS/FESTADO/field"/></xsl:call-template>
				</th>

				<th width="140px" style="text-align:left;">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo']/node()"/></label><br />
					<xsl:call-template name="desplegable"><xsl:with-param name="path" select="INCIDENCIASPRODUCTOS/FPLAZO/field"/></xsl:call-template>
				</th>

				<th width="140px" style="text-align:left;">
					<!--<br/><div class="botonLargo">
					<strong>-->
						<a class="btnDestacadoPeq"  href="javascript:BuscarIncidenciasProductos(document.forms['Buscador']);">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
						</a>
					<!--</strong>
					</div>-->
				</th>
				<th>&nbsp;</th>
			</tr>
		</table>
		</form>

		<div id="IncBorradaOK" style="display:none;background:#CEF6CE;padding:5px;width:400px;color:#01DF01;text-align:center;border:1px solid #01DF01;margin:10px auto;"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_incidencia_OK']/node()"/></div>
		<div id="IncBorradaKO" style="display:none;background:#F8E0E6;padding:5px;width:400px;color:red;text-align:center;border:1px solid red;margin:10px auto;"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_incidencia_KO']/node()"/></div>

		<table class="buscador">
		<thead>
			<tr class="subTituloTabla">
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
				<th class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_abbr']/node()"/></th>
				<th class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
                                <th class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ultimo_cambio']/node()"/></th>
                                <!--<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>-->
				<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_cliente']/node()"/></th>
				<th align="left" class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ref_cliente_2line']/node()"/></th>
				<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
				<!--<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/></th>-->
				<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
				<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
                                <th><xsl:copy-of select="document($doc)/translation/texts/item[@name='seguir_utilizando_2line']/node()"/></th>
				<th>&nbsp;</th>
			</tr>
		</thead>
                <xsl:choose>
		<xsl:when test="INCIDENCIASPRODUCTOS/INCIDENCIA">
			<xsl:for-each select="INCIDENCIASPRODUCTOS/INCIDENCIA">
				<xsl:variable name="IncID"><xsl:value-of select="ID"/></xsl:variable>
				<tr id="INC_{PROD_INC_ID}" style="border-bottom:1px solid #A7A8A9;">
					<xsl:choose>
					<xsl:when test="MODIFICADO_1HORA">
						<xsl:attribute name="class">fondoNaranja</xsl:attribute>
					</xsl:when>
					<xsl:when test="MODIFICADO_24HORAS">
						<xsl:attribute name="class">fondoAmarillo</xsl:attribute>
					</xsl:when>
					</xsl:choose>

					<td><xsl:value-of select="position()"/></td>
					<td>
                                            <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencia.xsql?ID_INC={PROD_INC_ID}&amp;PRO_ID={PROD_INC_IDPRODUCTO}&amp;LIC_OFE_ID={PROD_INC_IDOFERTA_LIC}','incidencia',100,80,0,-10)">
                                                <xsl:value-of select="PROD_INC_CODIGO"/>
                                            </a>
                                        </td>
					<td><xsl:value-of select="PROD_INC_FECHA"/></td>
                                        <td><xsl:value-of select="FECHA_ULTIMO_CAMBIO"/></td>
                                        <!--<td style="text-align:left;">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDCLIENTE}&amp;VENTANA=NUEVA','DetalleEmpresa',100,80,0,0)">
							<xsl:value-of select="CLIENTE"/>
						</a>
					</td>-->
					<td style="text-align:left;">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTROCLIENTE}','DetalleCentro',100,80,0,0)" title="Respon. {USUARIO}">
							<xsl:value-of select="CENTROCLIENTE"/>
                                                </a>
					</td>
					<td style="text-align:left;">
<!--						<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencia.xsql?ID_INC={PROD_INC_ID}&amp;PRO_ID={PROD_INC_IDPRODUCTO}&amp;LIC_OFE_ID={PROD_INC_IDOFERTA_LIC}">-->
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencia.xsql?ID_INC={PROD_INC_ID}&amp;PRO_ID={PROD_INC_IDPRODUCTO}&amp;LIC_OFE_ID={PROD_INC_IDOFERTA_LIC}','incidencia',100,80,0,-10)">

							<xsl:value-of select="REFERENCIA"/>
						</a>
					</td>
					<td style="text-align:left;">
						<strong>
                                                    <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencia.xsql?ID_INC={PROD_INC_ID}&amp;PRO_ID={PROD_INC_IDPRODUCTO}&amp;LIC_OFE_ID={PROD_INC_IDOFERTA_LIC}','incidencia',100,80,0,-10)">
							<xsl:value-of select="PROD_INC_DESCESTANDAR"/>
                                                    </a>
                                                </strong>
					</td>
					<!--<td style="text-align:left;"><xsl:value-of select="USUARIO"/></td>-->

					<td style="text-align:left;">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDPROVEEDOR}&amp;VENTANA=NUEVA','DetalleEmpresa',100,80,0,0)">
							<xsl:value-of select="PROVEEDOR"/>
                                                </a>
					</td>
					<td style="text-align:left;"><xsl:value-of select="ESTADO"/></td>
                                        <!--seguir utilizando-->
                                        <xsl:variable name="seguirUtilizando">
                                            <xsl:choose>
                                                <xsl:when test="PROD_INC_SEGUIRUTILIZANDO_CDC != ''"><xsl:value-of select="PROD_INC_SEGUIRUTILIZANDO_CDC" /></xsl:when>
                                                <xsl:otherwise><xsl:value-of select="PROD_INC_SEGUIRUTILIZANDO" /></xsl:otherwise>
                                            </xsl:choose>
                                            </xsl:variable>
                                        <td>
                                            <xsl:attribute name="style">
                                                <xsl:choose>
                                                    <xsl:when test="$seguirUtilizando = 'S'"></xsl:when>
                                                    <xsl:otherwise>background:#FE4162;</xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:attribute>
                                            
                                            <xsl:choose>
                                                <xsl:when test="$seguirUtilizando = 'S'"><span class="verde"><xsl:value-of select="document($doc)/translation/texts/item[@name='si']/node()"/></span></xsl:when>
                                                <xsl:otherwise><span style="font-weight:bold;"><xsl:value-of select="document($doc)/translation/texts/item[@name='no']/node()"/></span></xsl:otherwise>
                                            </xsl:choose>
                                        </td>
					<td>
					<xsl:if test="$usuario = 'CDC'">
						<a href="javascript:BorrarIncidenciaProducto('{PROD_INC_ID}');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>
					</xsl:if>
					</td>
				</tr>
			</xsl:for-each>
                </xsl:when>
		<xsl:otherwise>
			<tr><td colspan="11" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='incidencias_sin_resultados']/node()"/></strong></td></tr>
		</xsl:otherwise>
		</xsl:choose>
		</table>
	</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
