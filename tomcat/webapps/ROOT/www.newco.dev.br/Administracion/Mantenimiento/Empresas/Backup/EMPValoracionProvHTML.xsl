<?xml version="1.0" encoding="iso-8859-1"?>
<!-- -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/Valoracion">

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="LANG != ''"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--fin idioma-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='valoracion_proveedor']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->
  <link href="http://www.newco.dev.br/General/Tabla-popup.150715.css" rel="stylesheet" type="text/css"/>

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPValoracionProv.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/Tabla-popup.150715.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/starrating.js"></script>

  <script type="text/javascript">
    var notaCalidadObli		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nota_calidad_obli']/node()"/>';
    var notaServicioObli	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nota_servicio_obli']/node()"/>';
    var notaPrecioObli		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nota_precio_obli']/node()"/>';

		jQuery(window).load(function(){
			initStarRating();
		});

		// init star rating functionality
		function initStarRating(context)
		{
			jQuery('.rating-holder', context).starRating();
		}
  </script>
</head>

<body>
<xsl:choose>
<!-- Error en alguna sentencia del XSQL -->
<xsl:when test="//xsql-error">
	<xsl:apply-templates select="//xsql-error"/>
</xsl:when>
<xsl:when test="//SESION_CADUCADA">
	<xsl:for-each select="//SESION_CADUCADA">
		<xsl:if test="position()=last()">
			<xsl:apply-templates select="."/>
		</xsl:if>
	</xsl:for-each>
</xsl:when>
<xsl:otherwise>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="LANG != ''"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--fin idioma-->

  <form name="form1" action="EMPValoracionProv.xsql" method="post">
	<input type="hidden" name="IDPAIS" value="{ENTRADAS_SEGUIMIENTO/TITULOS/IDPAIS}"/>
	<input type="hidden" name="IDEMPRESAUSUARIO" value="{ENTRADAS_SEGUIMIENTO/IDEMPRESAUSUARIO}"/>
	<input type="hidden" name="EMP_ID" value="{ENTRADAS_SEGUIMIENTO/TITULOS/IDEMPRESA}"/>
	<input type="hidden" name="ACCION" id="ACCION"/>
	<input type="hidden" name="PARAMETROS" id="PARAMETROS"/>
	<input type="hidden" name="NOTA_CALIDAD" id="NOTA_CALIDAD"/>
	<input type="hidden" name="NOTA_SERVICIO" id="NOTA_SERVICIO"/>
	<input type="hidden" name="NOTA_PRECIO" id="NOTA_PRECIO"/>

		<div class="divLeft">
			<h1 class="titlePage" style="float:left;width:50%;padding-left:20%;">
         <xsl:value-of select="ENTRADAS_SEGUIMIENTO/TITULOS/EMPRESA"/>:&nbsp;
       <xsl:value-of select="document($doc)/translation/texts/item[@name='valoracion_proveedor']/node()"/>&nbsp;
        <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
				<select name="NumLineas" id="NumLineas" onchange="mostrarLineas(this.value);">
					<option value="10" selected="selected">
						10 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
					</option>
					<option value="20">
						20 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
					</option>
					<option value="50">
						50 <xsl:value-of select="document($doc)/translation/texts/item[@name='lineas']/node()"/>
					</option>
					<option value="todas">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='todas']/node()"/>
					</option>
				</select>
				&nbsp;&nbsp;&nbsp;
        <a href="javascript:window.print();" style="text-decoration:none;">
	        <img src="http://www.newco.dev.br/images/imprimir.gif"/>
          <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
        </a>
			</h1>
			<h1  class="titlePage" style="float:left;width:10%;">
			<xsl:if test="ENTRADAS_SEGUIMIENTO/COMERCIAL">
				<div class="botonLargo" style="padding:0 0 5px 0;">
					<strong><a href="javascript:AbrirNuevo();"><xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/></a></strong>
				</div>
			</xsl:if>
			</h1>
      <h1 class="titlePage" style="float:left;width:20%;">
        <xsl:if test="ENTRADAS_SEGUIMIENTO/MVM or ENTRADAS_SEGUIMIENTO/MVMB or ENTRADAS_SEGUIMIENTO/ADMIN">
          <span style="float:right; padding:5px;" class="amarillo">EMP_ID: <xsl:value-of select="ENTRADAS_SEGUIMIENTO/TITULOS/IDEMPRESA"/></span>
        </xsl:if>
      </h1>

			<!-- Pop-up para nueva entrada de valoracion -->
			<xsl:if test="ENTRADAS_SEGUIMIENTO/COMERCIAL">
				<div class="overlay-container" id="NuevaValoracionWrap">
					<div class="window-container zoomout">
						<p style="text-align:right;">
				      <a href="javascript:showTabla(false);" style="text-decoration:none;">
				        <xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
				      </a>&nbsp;
				      <a href="javascript:showTabla(false);" style="text-decoration:none;">
				        <img src="http://www.newco.dev.br/images/cerrar.gif" alt="Cerrar"/>
				      </a>
				    </p>

						<p id="tableTitle">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_valoracion']/node()"/>&nbsp;
							<xsl:value-of select="document($doc)/translation/texts/item[@name='para']/node()"/>&nbsp;
							<xsl:value-of select="ENTRADAS_SEGUIMIENTO/TITULOS/EMPRESA"/>,&nbsp;
							<xsl:value-of select="document($doc)/translation/texts/item[@name='dia']/node()"/>&nbsp;
							<xsl:value-of select="ENTRADAS_SEGUIMIENTO/FECHA"/>
						</p>

						<div id="mensError" class="divLeft" style="display:none;">
							<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></strong></p>
						</div>

						<form name="NuevaValoracionForm" method="post" id="NuevaValoracionForm">
						<input type="hidden" name="NV_IDEmpresa" id="NV_IDEmpresa" value="{ENTRADAS_SEGUIMIENTO/TITULOS/IDEMPRESA}"/>

						<table id="NuevaValoracion" style="width:100%;">
						<thead>
							<th colspan="4">&nbsp;</th>
						</thead>

						<tbody>
							<tr style="line-height:30px;">
		            <td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='visibilidad']/node()"/>:</strong></td>
		            <td colspan="3" style="text-align:left; padding-left:3px;">
		              <input type="radio" name="NV_IDVISIBILIDAD" id="NV_VIS_PRIVADA" value="P"></input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='priv']/node()"/>&nbsp;&nbsp;
		              <input type="radio" name="NV_IDVISIBILIDAD" id="NV_VIS_PUBLICO" value="Z" checked="checked"></input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pub']/node()"/>&nbsp;&nbsp;
		            </td>
		          </tr>

							<tr style="line-height:30px;">
		            <td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='nota_calidad']/node()"/>:</strong></td>
		            <td colspan="3" class="rating-holder" style="text-align:left; padding-left:3px;">
									<input type="hidden" name="NV_NOTACALIDAD" id="NV_NOTACALIDAD"/>
									<ul class="list-unstyled">
										<li class="">
											<a href="#">1</a>
										</li>
										<li class="">
											<a href="#">2</a>
										</li>
										<li class="">
											<a href="#">3</a>
										</li>
										<li class="">
											<a href="#">4</a>
										</li>
										<li class="">
											<a href="#">5</a>
										</li>
									</ul>
									<span class="rating"><span>0</span>/5</span>
								</td>
		          </tr>

							<tr style="line-height:30px;">
		            <td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='nota_servicio']/node()"/>:</strong></td>
		            <td colspan="3" class="rating-holder" style="text-align:left; padding-left:3px;">
									<input type="hidden" name="NV_NOTASERVICIO" id="NV_NOTASERVICIO"/>
									<ul class="list-unstyled">
										<li class="">
											<a href="#">1</a>
										</li>
										<li class="">
											<a href="#">2</a>
										</li>
										<li class="">
											<a href="#">3</a>
										</li>
										<li class="">
											<a href="#">4</a>
										</li>
										<li class="">
											<a href="#">5</a>
										</li>
									</ul>
									<span class="rating"><span>0</span>/5</span>
								</td>
		          </tr>

							<tr style="line-height:30px;">
		            <td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='nota_precio']/node()"/>:</strong></td>
		            <td colspan="3" class="rating-holder" style="text-align:left; padding-left:3px;">
									<input type="hidden" name="NV_NOTAPRECIO" id="NV_NOTAPRECIO"/>
									<ul class="list-unstyled">
										<li class="">
											<a href="#">1</a>
										</li>
										<li class="">
											<a href="#">2</a>
										</li>
										<li class="">
											<a href="#">3</a>
										</li>
										<li class="">
											<a href="#">4</a>
										</li>
										<li class="">
											<a href="#">5</a>
										</li>
									</ul>
									<span class="rating"><span>0</span>/5</span>
								</td>
		          </tr>

							<tr>
		            <td><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='comentario']/node()"/>:</strong></td>
		            <td colspan="3" style="text-align:left; padding-left:3px;">
									<textarea name="NV_COMENTARIO" id="NV_COMENTARIO" cols="80" rows="5" style="float:left;margin-right:10px;"/>&nbsp;
								</td>
		          </tr>
						</tbody>

						<tfoot>
							<tr>
								<td>&nbsp;</td>
								<td>
									<div class="boton" id="botonNuevaValoracion">
										<a href="javascript:nuevaValoracion();">
											<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/>
										</a>
									</div>
								</td>
								<td id="Respuesta" colspan="2" style="text-align:left;"></td>
							</tr>
						</tfoot>
						</table>
						</form>
					</div>
				</div>
			</xsl:if>
			<!-- FIN Pop-up para nueva valoracion -->


			<table id="ListaValoraciones" class="infoTable" border="0">
      <xsl:choose>
      <xsl:when test="ENTRADAS_SEGUIMIENTO/SEGUIMIENTO/ENTRADA">
      <!--buscador-->

			<thead>
        <tr class="subTituloTablaNoB">
					<td class="uno">&nbsp;</td>
          <td class="seis">&nbsp;</td>
          <td class="datosLeft doce"><xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/></td>
          <td class="datosLeft quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></td>
					<td class="center cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='calidad']/node()"/></td>
					<td class="center cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='servicio']/node()"/></td>
					<td class="center cinco "><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></td>
          <td class="datosLeft cuaranta"><xsl:value-of select="document($doc)/translation/texts/item[@name='texto']/node()"/></td>
					<td class="datosLeft">&nbsp;</td>
					<td class="uno">&nbsp;</td>
				</tr>
<!--
        <tr class="subTituloTablaNoB">
					<td colspan="2">&nbsp;</td>
					<td class="datosLeft">
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="ENTRADAS_SEGUIMIENTO/FTIPO/field"/>
              <xsl:with-param name="defecto" select="ENTRADAS_SEGUIMIENTO/TITULOS/FTIPO"/>
						</xsl:call-template>
					</td>
          <td class="datosLeft">
            <xsl:if test="ENTRADAS_SEGUIMIENTO/EMPRESAS/field/@current != ''">
              <select name="FIDCENTRO" id="FIDCENTRO" class="select140 centroBox">
                <xsl:for-each select="ENTRADAS_SEGUIMIENTO/LISTACENTROS/field/dropDownList/listElem">
                  <option value="{ID}"><xsl:value-of select="listItem"/></option>
                </xsl:for-each>
              </select>
            </xsl:if>
					</td>
          <td>&nbsp;</td>
					<td class="datosLeft" colspan="2">
						<input type="text" name="FTEXTO" size="40" value="{TEXTO}" style="float:left;"/>
					</td>
					<td class="center" colspan="2">
						<div class="boton" style="margin-left:20px;">
							<strong>
								<a href="javascript:GuardarEntrada();">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
								</a>
							</strong>
						</div>
					</td>
				</tr>
-->
				<tr class="subTituloTablaNoB line5"><td colspan="10" height="5px"></td></tr>
			</thead>
      <!--fin buscador-->


			<tbody>
			<xsl:for-each select="ENTRADAS_SEGUIMIENTO/SEGUIMIENTO/ENTRADA">
				<xsl:variable name="id" select="ID"/>

				<tr>
					<xsl:choose>
					<xsl:when test="MODIFICADO_1HORA">
						<xsl:attribute name="style">background:#ff9900;</xsl:attribute>
					</xsl:when>
					<xsl:when test="MODIFICADO_24HORAS">
						<xsl:attribute name="style">background:FFFF99;</xsl:attribute>
					</xsl:when>
					</xsl:choose>

					<td>&nbsp;</td>
					<td class="datosCenter"><strong><xsl:value-of select="FECHA"/></strong></td>
					<td style="text-align:left;"><span style="font-weight:bold;"><xsl:value-of select="AUTOR"/></span></td>
					<td style="text-align:left;"><xsl:value-of select="CENTROAUTOR"/></td>
					<td style="text-align:center;font-weight:bold;">
						<xsl:value-of select="NOTACALIDAD"/>/5
					</td>
					<td style="text-align:center;font-weight:bold;">
						<xsl:value-of select="NOTASERVICIO"/>/5
					</td>
					<td style="text-align:center;font-weight:bold;">
						<xsl:value-of select="NOTAPRECIO"/>/5
					</td>
					<td style="text-align:left;padding:5px 0px;"><xsl:copy-of select="TEXTO" /></td>
					<td style="padding-left:10px;text-align:left;">
						<xsl:if test="/Valoracion/ENTRADAS_SEGUIMIENTO/ADMIN or (/Valoracion/ENTRADAS_SEGUIMIENTO/IDUSUARIO = IDAUTOR)">
							<a href="javascript:Borrar({ID});" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/2017/trash.png"/>
							</a>
						</xsl:if>
					</td>
					<td>&nbsp;</td>
				</tr>

			</xsl:for-each>
			</tbody>

    	</xsl:when>
      <xsl:otherwise>
        <tr style="border-bottom:2px solid #D7D8D7;"><td colspan="6" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='valoraciones_sin_resultados']/node()"/></strong></td></tr>
      </xsl:otherwise>
      </xsl:choose>
    	</table>

      <br /><br />
		</div>

	</form>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
