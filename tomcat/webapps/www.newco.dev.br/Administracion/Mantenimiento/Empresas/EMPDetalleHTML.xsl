<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 |   Mostrar detalle de la empresa.
 |
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/">

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
    <xsl:choose>
		<xsl:when test="/Empresas/LANG"><xsl:value-of select="/Empresas/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
    </xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<meta http-equiv="Cache-Control" Content="no-cache"/>

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

	<link rel="stylesheet" type="text/css" href="http://www.newco.dev.br/General/TablaResumen-popup.css"/>
	<script type="text/javascript" src="http://www.newco.dev.br/General/TablaResumen-popup.js"></script>

  <!--codigo etiquetas-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/Tabla-popup.150715.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/etiquetas.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalle_060217.js"></script>
	
	<link rel="stylesheet" href="http://www.newco.dev.br/General/lightbox.css" type="text/css" media="screen"/>
	<link href="http://www.newco.dev.br/General/Tabla-popup.150715.css" rel="stylesheet" type="text/css"/>
  <!--fin codigo etiquetas-->

	<script type="text/javascript">
		var lang = '<xsl:value-of select="/Empresas/LANG"/>';
		var condProvOK	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='ok_cond_proveedor_save']/node()"/>';
		var condProvERR	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_cond_proveedor_save']/node()"/>';
	</script>

  <script type="text/javascript">
    <!-- Variables y Strings JS para las etiquetas -->
		var IDRegistro = '<xsl:value-of select="/Empresas/EMPRESA/EMP_ID"/>';
		var IDTipo = 'EMP';
		var str_NuevaEtiquetaGuardada	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta_guardada']/node()"/>';
		var str_NuevaEtiquetaError		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta_error']/node()"/>';
		var str_autor			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/>';
		var str_fecha			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>';
		var str_etiqueta	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='etiqueta']/node()"/>';
		var str_borrar		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>';
		<!-- FIN Variables y Strings JS para las etiquetas -->
  </script>

	<!--	script movido a EMPDetalle_060217.js		-->
</head>

<body>
	<xsl:attribute name="onload">
    <xsl:choose>
    <xsl:when test="/Empresas/ZONA='DOCS'">javascript:verPestana('DOCS');</xsl:when>
		<xsl:when test="/Empresas/ZONA='COND_COMERC'">javascript:verPestana('COND_COMERC');</xsl:when>
    <xsl:when test="/Empresas/ZONA='COND_COMERC_PROV'">javascript:verPestana('COND_COMERC_PROV');</xsl:when>
    </xsl:choose>
	</xsl:attribute>

	<xsl:choose>
		<xsl:when test="//SESION_CADUCADA">
			<xsl:apply-templates select="//SESION_CADUCADA"/>
		</xsl:when>
		<xsl:when test="//xsql-error">
			<xsl:apply-templates select="//xsql-error"/>
		</xsl:when>
		<xsl:when test="//Status">
			<xsl:apply-templates select="//Status"/>
		</xsl:when>
		<xsl:when test="//ESTADO[.='CABECERA']">
			<xsl:apply-templates select="Empresas/EMPRESA"/>
		</xsl:when>
		<xsl:when test="//ESTADO[.='LINK']">
			<xsl:choose>
				<xsl:when test="Empresas/EMPRESA/EMP_PUBLICAR='S' and Empresas/EMPRESA/EMP_ENLACE_HTTP[.!='']">
					<script>document.location='<xsl:value-of select="Empresas/EMPRESA/EMP_ENLACE_HTTP"/>'</script>
				</xsl:when>

				<xsl:otherwise>
					<script>document.location='http://www.newco.dev.br/files/Empresas/MedicalVM/empresa_sin_informacion.html'</script>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
	</xsl:choose>

    <div id="uploadFrameBox" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>
    <div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>
</body>
</html>
</xsl:template>

<!--
 |  Templates
 +-->

<xsl:template match="EMPRESA">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Empresas/LANG"><xsl:value-of select="/Empresas/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!-- Pop-up para mostrar tabla resumen empresa -->
	<!--<xsl:if test="/Empresas/EMPRESA/MVM or /Empresas/EMPRESA/MVMB">-->
	<xsl:if test="/Empresas/EMPRESA/MVM">
	<div class="overlay-container-2">
		<div class="window-container zoomout">
			<p><a href="javascript:showTablaResumenEmpresa(false);"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a></p>

			<table>
			<thead>
				<tr>
					<td>&nbsp;</td>
				<xsl:for-each select="/Empresas/EMPRESA/RESUMENES_MENSUALES/CABECERA/COLUMNA">
					<td><xsl:value-of select="MES"/>/<xsl:value-of select="ANYO"/></td>
				</xsl:for-each>
				</tr>
			</thead>

			<tbody>
			<xsl:for-each select="/Empresas/EMPRESA/RESUMENES_MENSUALES/RESUMEN_MENSUAL">
				<tr>
					<td class="indicador"><xsl:value-of select="@Nombre"/></td>
				<xsl:for-each select="COLUMNA">
					<td><xsl:value-of select="VALOR"/></td>
				</xsl:for-each>
        </tr>
			</xsl:for-each>
			</tbody>
			</table>
		</div>
	</div>
	</xsl:if>
	<!-- FIN Pop-up para mostrar tabla resumen empresa -->

	<!-- Desplegable empresas
  <xsl:if test="/Empresas/EMPRESA/COMERCIAL or /Empresas/EMPRESA/MVM or /Empresas/EMPRESA/MVMB or /Empresas/EMPRESA/USUARIO_CDC">frffrfrfr
    <form name="Empresas" id="Empresas">
		<table class="infoTable" style="margin-bottom:10px;">
			<tr style="background:#C3D2E9;border-bottom:0px solid #3B5998;">
				<td>
					<p style="font-weight:bold;">
                                                    <xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="/Empresas/EMPRESA/EMPRESAS/field"/>
							<xsl:with-param name="onChange">javascript:CambiarEmpresa(this.value);</xsl:with-param>
                                                        <xsl:with-param name="claSel">selectFont18</xsl:with-param>
                                                    </xsl:call-template>&nbsp;&nbsp;
            <input type="hidden" name="IDPAIS" value="{/Empresas/EMPRESA/EMP_IDPAIS}"/>
            <input type="hidden" name="IDEMPRESA" value="{/Empresas/EMPRESA/EMP_ID}"/>
            <input type="hidden" name="SOLO_CLIENTES"/>
            <input type="hidden" name="SOLO_PROVEE"/>
            <input type="checkbox" name="SOLO_CLIENTES_CK" onchange="soloClientes(document.forms['Empresas']);"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='solo_clientes']/node()"/>&nbsp;&nbsp;
            <input type="checkbox" name="SOLO_PROVEE_CK" onchange="soloProvee(document.forms['Empresas']);"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='solo_proveedores']/node()"/>
          </p>
				</td>
			</tr>
		</table>fin desplegable empresas, para saber de que empresa veo los datos
    </form>
  </xsl:if>-->

  <xsl:if test="/Empresas/EMPRESA/COMERCIAL or /Empresas/EMPRESA/MVM or /Empresas/EMPRESA/USUARIO_CDC">
		<div style="background:#fff;float:left;">
			<!--	Pestaña FICHA para todos -->
			&nbsp;
			<!--	Bloque de pestañas solo si mvm o mvmb	-->
      <xsl:if test="/Empresas/EMPRESA/COMERCIAL or /Empresas/EMPRESA/MVM or /Empresas/EMPRESA/USUARIO_CDC">
        <a href="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalle.xsql?EMP_ID={/Empresas/EMPRESA/EMP_ID}&amp;ESTADO=CABECERA" style="text-decoration:none;">
          <xsl:choose>
          <xsl:when test="/Empresas/LANG = 'spanish'">
            <img src="http://www.newco.dev.br/images/botonFicha1.gif" alt="FICHA" id="FICHA"/>
          </xsl:when>
          <xsl:otherwise>
            <img src="http://www.newco.dev.br/images/botonFicha1.gif" alt="FICHA" id="FICHA"/>
          </xsl:otherwise>
          </xsl:choose>
        </a>&nbsp;
      </xsl:if>

		<xsl:if test="/Empresas/EMPRESA/ROL = 'COMPRADOR' and (/Empresas/EMPRESA/COMERCIAL or /Empresas/EMPRESA/MVM or /Empresas/EMPRESA/USUARIO_CDC)">
			<a href="javascript:verPestana('COND_COMERC');" style="text-decoration:none;">
				<xsl:choose>
				<xsl:when test="/Empresas/LANG = 'spanish'">
					<img src="http://www.newco.dev.br/images/botonCondicionesComerciales.gif" alt="CONDICIONES COMERCIALES" id="COND_COMERC"/>
				</xsl:when>
				<xsl:otherwise>
					<img src="http://www.newco.dev.br/images/botonCondicionesComerciales-BR.gif" alt="CONDIÇÕES COMERCIAIS" id="COND_COMERC"/>
				</xsl:otherwise>
				</xsl:choose>
			</a>&nbsp;
		</xsl:if>

		<xsl:if test="/Empresas/EMPRESA/ROL = 'VENDEDOR' and (/Empresas/EMPRESA/COMERCIAL or /Empresas/EMPRESA/MVM or /Empresas/EMPRESA/USUARIO_CDC)">
			<a href="javascript:verPestana('COND_COMERC_PROV');" style="text-decoration:none;">
				<xsl:choose>
				<xsl:when test="/Empresas/LANG = 'spanish'">
					<img src="http://www.newco.dev.br/images/botonCondicionesComerciales.gif" alt="CONDICIONES COMERCIALES" id="COND_COMERC_PROV"/>
				</xsl:when>
				<xsl:otherwise>
					<img src="http://www.newco.dev.br/images/botonCondicionesComerciales-BR.gif" alt="CONDIï¿½ï¿½ES COMERCIAIS" id="COND_COMERC_PROV"/>
				</xsl:otherwise>
				</xsl:choose>
			</a>&nbsp;
		</xsl:if>

		<xsl:if test="/Empresas/EMPRESA/COMERCIAL or /Empresas/EMPRESA/MVM">    <!--antes olo mvm, ahora cualquier comprador que tiene marca de comercial ve el seguimiento y las tareas-->
			<a href="http://www.newco.dev.br/Gestion/Comercial/Seguimiento.xsql?FIDEMPRESA={/Empresas/EMPRESA/EMP_ID}" style="text-decoration:none;">
				<xsl:choose>
				<xsl:when test="/Empresas/LANG = 'spanish'">
					<img src="http://www.newco.dev.br/images/botonSeguimiento.gif" alt="SEGUIMIENTO"/>
				</xsl:when>
				<xsl:otherwise>
					<img src="http://www.newco.dev.br/images/botonSeguimiento-Br.gif" alt="SEGUIMENTO"/>
				</xsl:otherwise>
				</xsl:choose>
			</a>&nbsp;

			<a href="http://www.newco.dev.br/Gestion/Comercial/Tareas.xsql?FIDEMPRESA={/Empresas/EMPRESA/EMP_ID}&amp;FIDRESPONSABLE=-1" style="text-decoration:none;">
				<xsl:choose>
				<xsl:when test="/Empresas/LANG = 'spanish'">
					<img src="http://www.newco.dev.br/images/botonTareas.gif" alt="TAREAS"/>
				</xsl:when>
				<xsl:otherwise>
					<img src="http://www.newco.dev.br/images/botonTareas-Br.gif" alt="TAREFAS"/>
				</xsl:otherwise>
				</xsl:choose>
			</a>&nbsp;
		</xsl:if>
		<xsl:if test="/Empresas/EMPRESA/MVM">
			<a href="http://www.newco.dev.br/Gestion/Comercial/Meddicc.xsql?FIDEMPRESA={/Empresas/EMPRESA/EMP_ID}" style="text-decoration:none;">
				<xsl:choose>
				<xsl:when test="/Empresas/LANG = 'spanish'">
					<img src="http://www.newco.dev.br/images/botonMeddicc.gif" alt="MEDDICC"/>
				</xsl:when>
				<xsl:otherwise>
					<img src="http://www.newco.dev.br/images/botonMeddicc.gif" alt="MEDDICC"/>
				</xsl:otherwise>
				</xsl:choose>
			</a>&nbsp;
		</xsl:if>

      <!--	Bloque Pestañas solo si mvm , mvmb o CdC	-->
      <xsl:if test="/Empresas/EMPRESA/ROL = 'VENDEDOR' and (/Empresas/EMPRESA/MVM or /Empresas/EMPRESA/USUARIO_CDC)">
				<xsl:if test="/Empresas/EMPRESA/VEROFERTAS">
					<a href="javascript:verPestana('DOCS');" style="text-decoration:none;">
						<img src="http://www.newco.dev.br/images/botonDocumentos.gif" alt="DOCUMENTOS" id="DOCUMENTOS"/>
					</a>&nbsp;
				</xsl:if>
      </xsl:if><!--	fin de bloque de pestañas	-->
		</div>
  </xsl:if>

	<!--	Bloque de pestañas solo si mvm o mvmb	-->
	<xsl:if test="/Empresas/EMPRESA/MVM">
		<div style="background:#fff;float:right;">
			<a href="http://www.newco.dev.br/Gestion/Comercial/BuscadorEmpresas.xsql" style="text-decoration:none;">
				<img src="http://www.newco.dev.br/images/botonBuscador.gif" alt="BUSCADOR"/>
			</a>
    </div>
	</xsl:if>

	<div class="divLeft">
		<h1 class="titlePage ficha" style="float:left;width:60%;padding-left:20%;">
      <a id="conEtiquetas" href="javascript:abrirEtiqueta(true);" style="text-decoration:none;display:none;">
				<img src="http://www.newco.dev.br/images/tagsAma.png" width="20px">
					<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_mas_nueva_etiqueta']/node()"/></xsl:attribute>
					<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_mas_nueva_etiqueta']/node()"/></xsl:attribute>
				</img>
			</a>&nbsp;

			<a id="sinEtiquetas" href="javascript:abrirEtiqueta(false);" style="text-decoration:none;display:none;">
				<img src="http://www.newco.dev.br/images/tags.png" width="20px">
					<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta']/node()"/></xsl:attribute>
					<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta']/node()"/></xsl:attribute>
				</img>
			</a>&nbsp;

			<!-- ET Cambiamos texto titulo	<xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/> < ! - - &nbsp;<xsl:value-of select="EMP_TIPO"/>-->
      &nbsp;
        <xsl:choose>
        <xsl:when test="EMP_NOMBRE_CORTO != ''"><xsl:value-of select="EMP_NOMBRE_CORTO" disable-output-escaping="yes"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="substring(EMP_NOMBRE,0,50)" disable-output-escaping="yes"/></xsl:otherwise>
        </xsl:choose>
      &nbsp;

			<xsl:if test="/Empresas/EMPRESA/MVM or /Empresas/EMPRESA/ADMIN">
				<xsl:text>&nbsp;&nbsp;</xsl:text>
				<a style="text-decoration:none;">
					<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPManten.xsql?ID=<xsl:value-of select="EMP_ID"/>&amp;ADMINISTRADORMVM=ADMINISTRADORMVM','Mantenimiento empresa',100,80,0,0);</xsl:attribute>
					<img src="http://www.newco.dev.br/images/modificarBoli.gif" title="Modificar empresa"/>
				</a>
				<xsl:text>&nbsp;&nbsp;</xsl:text>
				<a href="javascript:window.print();" style="text-decoration:none;" title="Imprimir">
					<img src="http://www.newco.dev.br/images/imprimir.gif"/>
				</a>
				<!--<xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
				<a style="text-decoration:none;">
					<xsl:attribute name="href">javascript:showTablaResumenEmpresa(true);</xsl:attribute>
					<img src="http://www.newco.dev.br/images/tabla.gif"/>&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='resumen']/node()"/>
				</a>-->
			</xsl:if>
    </h1>

    <h1 class="titlePage ficha" style="float:left;width:20%;">
      <xsl:if test="/Empresas/EMPRESA/MVM or /Empresas/EMPRESA/ADMIN"><span style="float:right; padding:5px;" class="amarillo">EMP_ID: <xsl:value-of select="EMP_ID"/></span></xsl:if>
		</h1>

		<!--<table class="mediaTabla ficha">-->
		<table class="buscador ficha">
		<tbody>
			<tr>
				<td class="veinte label" rowspan="4">
					<img src="http://www.newco.dev.br/Documentos/{/Empresas/EMPRESA/URL_LOGOTIPO}" height="80px" width="160px" style="padding-left:10px"/>
				</td>
				<td class="label dies">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nif']/node()"/>:
				</td>
				<td class="veintecinco">
					<xsl:value-of select="EMP_NIF"/>
				</td>
				<td class="label quince">&nbsp;
					<xsl:if test="EMP_ENLACE != 'http://' and EMP_ENLACE != ''"><xsl:value-of select="document($doc)/translation/texts/item[@name='web']/node()"/>:</xsl:if>
				</td>
				<td><xsl:if test="EMP_ENLACE != 'http://' and EMP_ENLACE != ''"><a href="{EMP_ENLACE}" target="_blank"><xsl:value-of select="EMP_ENLACE"/></a></xsl:if></td>
				<td class="cuatro">&nbsp;</td>
			</tr>
			<tr>
				<td class="label">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='tel']/node()"/>:
                    <xsl:if test="EMP_FAX[.!='']"><br /><xsl:value-of select="document($doc)/translation/texts/item[@name='fax']/node()"/>:</xsl:if>
				</td>
				<td><xsl:value-of select="EMP_TELEFONO"/>
                	<xsl:if test="EMP_FAX != ''"><br /><xsl:value-of select="EMP_FAX"/></xsl:if>
                </td>
				<td class="label">
						<xsl:if test="EMP_PEDMINIMO_DETALLE!=''"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/>:</xsl:if>
				</td>
				<td><xsl:if test="EMP_PEDMINIMO_DETALLE!=''"><xsl:value-of select="EMP_PEDMINIMO_DETALLE"/></xsl:if></td>
				<td>&nbsp;</td>
			</tr>

			<tr>
				<td class="label" valign="top">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='direccion']/node()"/>:
				</td>
				<td>
					<xsl:value-of select="EMP_DIRECCION" disable-output-escaping="yes"/>,&nbsp;
					<xsl:value-of select="EMP_CPOSTAL"/><br/>
					<xsl:value-of select="EMP_POBLACION" disable-output-escaping="yes"/>&nbsp;
					(<xsl:value-of select="EMP_PROVINCIA" disable-output-escaping="yes"/>)
				</td>
				<td class="label">
                	 <xsl:if test="(/Empresas/EMPRESA/MVM or /Empresas/EMPRESA/ADMIN) and /Empresas/EMPRESA/ROL ='COMPRADOR'">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_corto']/node()"/>:
                    </xsl:if>
                	<xsl:if test="/Empresas/EMPRESA/ES_EMPRESA_ESPECIAL"><br />
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eis']/node()"/>:
                    </xsl:if>
				</td>
				<td>
                 <xsl:if test="(/Empresas/EMPRESA/MVM or /Empresas/EMPRESA/ADMIN) and /Empresas/EMPRESA/ROL ='COMPRADOR'">
                        	<xsl:value-of select="/Empresas/EMPRESA/EMP_NOMBRE_CORTO" />
                    </xsl:if>
                 <xsl:if test="/Empresas/EMPRESA/ES_EMPRESA_ESPECIAL"><br />
                    	<a href="http://www.newco.dev.br/Gestion/EIS/EISMatriz.xsql" title="Matriz EIS" target="_blank">
                        	<xsl:value-of select="/Empresas/EMPRESA/EMP_NOMBRECORTOPUBLICO" />
                        </a>
                    </xsl:if>
                </td>
				<td>&nbsp;</td>
			</tr>

		<xsl:if test="/Empresas/EMPRESA/EMP_REFERENCIAS != ''">
      <tr>
        <td class="label" valign="top">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_comercial_corta']/node()"/>:
		</td>
        <td colspan="3">
          <xsl:copy-of select="/Empresas/EMPRESA/EMP_REFERENCIAS/node()"/>
        </td>
        <td>&nbsp;</td>
      </tr>
		</xsl:if>
		</tbody>
		</table>

		<!--centros-->
		<!--<table class="mediaTabla ficha">-->
		<table class="buscador ficha">
		<tbody>
			<tr>
				<td>&nbsp;</td>
				<td>
					<xsl:attribute name="colspan">
						<xsl:choose>
						<xsl:when test="/Empresas/EMPRESA/ROL = 'COMPRADOR'">5</xsl:when>
						<xsl:otherwise>3</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					&nbsp;
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="tituloGrisScuro">
				<td>&nbsp;</td>
				<td align="left">
					<xsl:attribute name="colspan">
						<xsl:choose>
						<xsl:when test="/Empresas/EMPRESA/ROL = 'COMPRADOR'">5</xsl:when>
						<xsl:otherwise>3</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='centros']/node()"/></strong>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="bold">
				<td>&nbsp;</td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='provincia']/node()"/></td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='poblacion']/node()"/></td>
				<xsl:if test="/Empresas/EMPRESA/ROL = 'COMPRADOR'">
					<td><xsl:value-of select="document($doc)/translation/texts/item[@name='numero_de_camas']/node()"/></td>
					<td><xsl:value-of select="document($doc)/translation/texts/item[@name='quirofanos']/node()"/></td>
				</xsl:if>
				<td>&nbsp;</td>
			</tr>

			<xsl:for-each select="CENTROS/CENTRO">
			<tr>
				<td class="label" valign="top">&nbsp;

				</td>
				<td>
					<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={ID}','Centro',100,80,0,0);">
						<xsl:value-of select="NOMBRE"/>
					</a>
				</td>
				<td><xsl:value-of select="PROVINCIA"/></td>
				<td><xsl:value-of select="POBLACION"/></td>
				<xsl:if test="/Empresas/EMPRESA/ROL = 'COMPRADOR'">
					<td style="padding-left:30px;"><xsl:value-of select="CAMAS"/><xsl:if test="CAMAS = ''">-</xsl:if></td>
					<td style="padding-left:30px;"><xsl:value-of select="QUIROFANOS"/><xsl:if test="QUIROFANOS = ''">-</xsl:if></td>
				</xsl:if>
				<td>&nbsp;</td>
			</tr>
			</xsl:for-each>
		</tbody>
		</table>

		<!--usuarios-->
		<!--<table class="mediaTabla ficha">-->
		<table class="buscador ficha">
			<tr>
				<td>&nbsp;</td>
				<td colspan="4">&nbsp;</td>
				<td>&nbsp;</td>
			</tr>

			<tr class="tituloGrisScuro">
				<td>&nbsp;</td>
				<td colspan="4" align="left">
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='usuarios']/node()"/></strong>
				</td>
				<td>&nbsp;</td>
			</tr>

			<!--nombres columnas, nombre, cargo-->
			<tr class="bold">
				<td>&nbsp;</td>
				<td>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>
				</td>
				<td>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>
				</td>
				<td>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='cargo']/node()"/>
				</td>
                                <td>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='funcion']/node()"/>
				</td>
				<td>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='telefono']/node()"/>
				</td>
				<td>&nbsp;</td>
			</tr>

		<tbody>
			<xsl:for-each select="USUARIOS/USUARIO">
				<xsl:choose>
					<xsl:when test="ID=../../../IDVENDEDOR">
						<tr>
							<td>&nbsp;</td>
							<td>
								<a href="javascript:verVacacionesComercial('{../../../IDVENDEDOR}');">
									<xsl:value-of select="NOMBRE"/>
								</a>
							</td>
							<td>
								<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTRO}','Centro',100,80,0,0);">
									<xsl:value-of select="CENTRO"/>
								</a>
							</td>
							<td>
								<xsl:value-of select="TIPO_USUARIO"/>
							</td>
                                                        <td><!--funcion de usuario si vendedor no enseï¿½o--></td>
							<td>
								<xsl:value-of select="TELEFONO"/>
							</td>
							<td>&nbsp;</td>
						</tr>
					</xsl:when>
					<xsl:otherwise>
						<tr>
							<td>&nbsp;</td>
							<td>
                                <xsl:choose>
                                <xsl:when test="(/Empresas/EMPRESA/MVM or /Empresas/EMPRESA/MVMB) and /Empresas/EMPRESA/ADMIN">
                                    <a title="Manten Usuario">
                                    <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/USManten.xsql?ID_USUARIO=<xsl:value-of select="ID"/>&amp;EMP_ID=<xsl:value-of select="/Empresas/EMPRESA/EMP_ID"/>','Mantenimiento Usuario',100,80,0,0);</xsl:attribute>
                                        <xsl:value-of select="NOMBRE"/></a>
                                </xsl:when>
                                <xsl:otherwise><xsl:value-of select="NOMBRE"/></xsl:otherwise>
                                </xsl:choose>
                                &nbsp;
                                <a>
                                <xsl:attribute name="href">mailto:<xsl:value-of select="US_EMAIL"/></xsl:attribute>
                                <img src="http://www.newco.dev.br/images/mail.gif"/>
                                </a>
							</td>
							<td>
								<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTRO}','Centro',100,80,0,0);">
									<xsl:value-of select="CENTRO"/>
								</a>
							</td>
							<td>
								<xsl:value-of select="TIPO_USUARIO"/>
							</td>
                                <td>
                                    <xsl:if test="(/Empresas/EMPRESA/MVM or /Empresas/EMPRESA/MVMB) and /Empresas/EMPRESA/ADMIN">
                                        <xsl:choose>
                                            <xsl:when test="../../ROL = 'VENDEDOR'">
                                                <xsl:if test="US_DELEGADOURGENCIAS = 'S'">
                                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='urgencias']/node()"/>&nbsp;
                                                </xsl:if>
                                                <xsl:if test="COMERCIALPORDEFECTO">
                                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='comercial']/node()"/>&nbsp;
                                                </xsl:if>
                                                <xsl:if test="MUESTRAS">
                                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='muestras']/node()"/>&nbsp;
                                                </xsl:if>
                                                <xsl:if test="INCIDENCIAS">
                                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='reclamaciones']/node()"/>
                                                </xsl:if>
                                                <xsl:if test="US_DELEGADOZONA != ''">
                                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='zona']/node()"/>:&nbsp;<xsl:value-of select="US_DELEGADOZONA" />
                                                </xsl:if>
                                            </xsl:when>
                                            <xsl:when test="../../ROL = 'COMPRADOR'">
                                                <xsl:if test="ADMIN = 'S'">
                                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='admin']/node()"/>&nbsp;
                                                </xsl:if>
                                                <xsl:if test="CDC = 'S'">
                                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='cdc']/node()"/>&nbsp;
                                                </xsl:if>
                                                <xsl:if test="GERENTECENTRO = 'S'">
                                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='gerente_centro']/node()"/>&nbsp;
                                                </xsl:if>
                                            </xsl:when>
                                        </xsl:choose>
                                    </xsl:if>
							</td>
							<td>
								<xsl:value-of select="TELEFONO"/>
							</td>
							<td>&nbsp;</td>
						</tr>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</tbody>

			<tr><td colspan="6">&nbsp;</td></tr>
		</table>

		<h1 class="titlePage documentos" style="display:none;float:left;width:60%;padding-left:20%;">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/><!--&nbsp;<xsl:value-of select="EMP_TIPO"/>-->
                        [&nbsp;
                        <xsl:choose>
                            <xsl:when test="EMP_NOMBRE_CORTO != ''"><xsl:value-of select="EMP_NOMBRE_CORTO" disable-output-escaping="yes"/></xsl:when>
                            <xsl:otherwise><xsl:value-of select="EMP_NOMBRE" disable-output-escaping="yes"/></xsl:otherwise>
                        </xsl:choose>
                        &nbsp;]
			<xsl:if test="/Empresas/EMPRESA/MVM or /Empresas/EMPRESA/MVMB">
				<xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
				<a href="javascript:window.print();" style="text-decoration:none;">
					<img src="http://www.newco.dev.br/images/imprimir.gif"/>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
				</a>
			</xsl:if>
		</h1>
                <h1 class="titlePage documentos" style="float:left;width:20%;display:none;">
                    <xsl:if test="/Empresas/EMPRESA/MVM or /Empresas/EMPRESA/MVMB or /Empresas/EMPRESA/ADMIN"><span style="float:right; padding:5px;" class="amarillo">EMP_ID: <xsl:value-of select="EMP_ID"/></span></xsl:if>
                </h1>

        <!--si usuario observador no puede aï¿½adir nuevos documentos-->
        <xsl:if test="(/Empresas/EMPRESA/MVM or /Empresas/EMPRESA/MVMB or /Empresas/EMPRESA/USUARIO_CDC) and not(/Empresas/EMPRESA/OBSERVADOR)">
		 <!--tabla imagenes y documentos-->
          <table class="infoTableAma documentos" border="0" style="display:none;">
          <form name="SubirDocumentos" method="post">
          <input type="hidden" name="IDPROVEEDOR" id="IDPROVEEDOR" value="{/Empresas/EMPRESA/EMP_ID}"/>
          <input type="hidden" name="CADENA_DOCUMENTOS" />
          <input type="hidden" name="DOCUMENTOS_BORRADOS" />
          <input type="hidden" name="BORRAR_ANTERIORES" />
          <input type="hidden" name="REMOVE" value="{document($doc)/translation/texts/item[@name='remove']/node()}"/>

          <tr>
             <!--documentos-->
                <td class="quince"><!--<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='se_permite_cargar_documentos']/node()"/>.</strong>-->&nbsp;</td>
                <td class="labelRight dies">
                    <span class="text"><xsl:value-of select="document($doc)/translation/texts/item[@name='subir_documento']/node()"/></span>
                </td>
                <td class="datosLeft veintecinco">
                <div class="altaDocumento">
                    <span class="anadirDoc">
                        <xsl:call-template name="documentos">
                            <xsl:with-param name="num" select="number(1)" />
                        </xsl:call-template>
                    </span>

                </div>
                </td>
                <td class="datosLeft dies">
                <select name="TIPO_DOC" id="TIPO_DOC">
                    <xsl:for-each select="/Empresas/EMPRESA/TIPOS_DOCUMENTOS/field/dropDownList/listElem">
                        <option value="{ID}"><xsl:value-of select="listItem"/></option>
                    </xsl:for-each>
<!--
	                <option value="ANE"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='anexo']/node()"/></option>
                    <option value="CO"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='confidencial']/node()"/></option>
                    <option value="OF"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='mvm']/node()"/></option>

                    <xsl:if test="/Empresas/LANG ='spanish'">
                        <option value="OA"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='asisa']/node()"/></option>
                        <option value="OFNCP"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='fncp']/node()"/></option>
                        <option value="OVIAM"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='viamed']/node()"/></option>
                        <option value="OTEKN"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='teknon']/node()"/></option>
                    </xsl:if>
                    <option value="FT"><xsl:value-of select="document($doc)/translation/texts/item[@name='ficha_tecnica']/node()"/></option>
-->
                </select>
                </td>
                <td class="quince">
                    <div class="boton">
                            <a href="javascript:cargaDoc(document.forms['SubirDocumentos']);">
                                <span class="text"><xsl:value-of select="document($doc)/translation/texts/item[@name='subir_documento']/node()"/></span>
                            </a>

                    </div>
                    <div id="waitBoxDoc" align="center">&nbsp;</div>
                </td>
                <td>

  		  			<div id="confirmBoxDocEmpresa" align="center" style="display:none;"><span class="cargado">ï¿½<xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/>!</span></div>
                </td>
             </tr>
             </form>
          </table><!--fin de tabla doc-->
          </xsl:if><!--fin if si es mvm-->


		<!--	24ago16	NUEVO BLOQUE CON LOS DOCUMENTOS LEGALES DE LA EMPRESA. POR AHORA SOLO PROVEEDORES DE BRASIL. COPIADO DESDE EMPDocs.HTML		-->
		<!--ofertas new-->
		<xsl:if test="DOCUMENTOSLEGALES">
			<!--<table class="mediaTabla documentos">-->
			<table class="buscador documentos">
			<form name="DocumentosLegales">
				<tr><td colspan="9">&nbsp;</td></tr>
				  <!--nombres columnas-->
				  <tr class="bold">
					<td class="uno">&nbsp;</td>
					<td class="trenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></td>
					<xsl:if test="/Docs/EMPRESA/MVM or /Docs/EMPRESA/MVMB or /Docs/EMPRESA/ADMIN">
						<td><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></td>
						<td><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></td>
					</xsl:if>
					<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='descarga']/node()"/></td>
					<xsl:choose>
					<xsl:when test="//BORRAROFERTAS and not(/Docs/EMPRESA/OBSERVADOR)">
						<td class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/></td>
					</xsl:when>
					<xsl:otherwise>
						<td class="dos">&nbsp;</td>
					</xsl:otherwise>
        			</xsl:choose>
          		</tr>

        		<xsl:for-each select="DOCUMENTOSLEGALES/DOCUMENTO">
        		  <input type="hidden" name="ID_EMPRESA" value="{/Docs/EMPRESA/EMP_ID}"/>
        		  <tr>
					<td>&nbsp;</td>
					<td><xsl:value-of select="NOMBRETIPO"/>:&nbsp;<xsl:value-of select="NOMBRE"/></td>
					<td>
					</td>
					<xsl:if test="/Docs/EMPRESA/MVM or /Docs/EMPRESA/MVMB or /Docs/EMPRESA/ADMIN">
						<td><xsl:value-of select="USUARIO"/></td>
						<td>
							<xsl:choose>
							<xsl:when test="((/Docs/EMPRESA/MVM or /Docs/EMPRESA/MVMB or /Docs/EMPRESA/ADMIN) and not(/Docs/EMPRESA/OBSERVADOR)) and ../NOMBRE_CORTO != 'ANEXOS' and ../NOMBRE_CORTO != 'FICHAS_TECNICAS' and ../NOMBRE_CORTO != 'LOGOS' and ../NOMBRE_CORTO != 'DOCUMENTOS_COMERCIALES_PROV'">
								<input type="text" name="fecha_{ID}" value="{FECHA}" maxlength="10" size="10" id="fecha_{ID}"/>
								<img src="http://www.newco.dev.br/images/actualizarFlecha.gif" alt="Actualizar Fecha" onmouseover="style.cursor='pointer'" onclick="javascript:ActualizarFechaOferta('{ID}','{../TIPO}','{../NOMBRE_CORTO}');"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="FECHA"/>
							</xsl:otherwise>
							</xsl:choose>
						</td>
					</xsl:if>
					<td>
						<a>
							<xsl:attribute name="href">http://www.newco.dev.br/Documentos/<xsl:value-of select="URL"/></xsl:attribute>
							<img src="http://www.newco.dev.br/images/descarga.gif" alt="Descarga"/>
						</a>
					</td>
            		<td>
				</td>
				<xsl:choose>
				<xsl:when test="//BORRAROFERTAS and not(/Docs/EMPRESA/OBSERVADOR)">
					<td class="ocho">
					<a>
						<xsl:attribute name="href">javascript:EliminarDocumento('<xsl:value-of select="ID"/>','<xsl:value-of select="../TIPO"/>','<xsl:value-of select="../NOMBRE_CORTO"/>');</xsl:attribute>
						<img src="http://www.newco.dev.br/images/eliminarOferta.gif" alt="Eliminar"/>
					</a>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td class="dos">&nbsp;</td>
				</xsl:otherwise>
        		</xsl:choose>
			</tr>
      	</xsl:for-each>
      </form>
      </table>
    </xsl:if>



		<!--ofertas new-->
		<xsl:if test="OFERTAS and VEROFERTAS">
			<!--<table class="mediaTabla documentos" style="display:none;">-->
			<table class="buscador documentos" style="display:none;">
			<tr>
				<td colspan="9">&nbsp;</td>
			</tr>
				<form name="OfertaForm">
            <xsl:for-each select="OFERTAS">
                <xsl:if test="DOCUMENTO and NOMBRE_CORTO != 'ANEXOS'">
                        <tr class="tituloGrisScuro">
                            <td>&nbsp;</td>
                            <td colspan="8" align="left" >
                                <strong>
                                    <xsl:if test="NOMBRE_CORTO != 'FICHAS_TECNICAS' and NOMBRE_CORTO != 'LOGOS' and NOMBRE_CORTO != 'DOCUMENTOS_COMERCIALES_PROV'">DOCUMENTOS</xsl:if>
                                    &nbsp;<xsl:value-of select="NOMBRE_CORTO"/>
                                </strong>
                                    <div id="waitBoxOferta_{NOMBRE_CORTO}" class="gris" style="display:none; margin-top:5px;">
                                            <xsl:value-of select="document($doc)/translation/texts/item[@name='cargando']/node()"/>...&nbsp;
                                    </div>
                                    <div id="confirmBoxAsociaOferta_{NOMBRE_CORTO}" class="gris" style="display:none; margin-top:5px;">
                                            <span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_asociada_a_todos']/node()"/></span>
                                    </div>
                                    <div id="confirmBoxEliminaOferta_{NOMBRE_CORTO}" class="gris" style="display:none; margin-top:5px;">
                                            <span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_eliminada']/node()"/>.</span>
                                    </div>
                                    <div id="confirmBoxModificaFecha_{NOMBRE_CORTO}" class="gris" style="display:none; margin-top:5px;">
                                            <span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_oferta_actualizada']/node()"/>.</span>
                                    </div>
                            </td>
                        </tr>

                        <!--nombres columnas-->
                        <tr class="bold">
                            <td class="uno">&nbsp;</td>
                            <td><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_oferta']/node()"/></td>
                            <td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='descarga']/node()"/></td>
                            <xsl:choose>
                                    <xsl:when test="//BORRAROFERTAS and NOMBRE_CORTO != 'FICHAS_TECNICAS' and NOMBRE_CORTO != 'LOGOS'">
                                            <td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='asociar_a_todos']/node()"/></td>
                                    </xsl:when>
                                    <xsl:otherwise>
                                            <td class="quince">&nbsp;</td>
                                    </xsl:otherwise>
                            </xsl:choose>
                            <td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></td>
                            <td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></td>
                            <td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_final']/node()"/></td>
                            <xsl:choose>
                                    <xsl:when test="//BORRAROFERTAS">
                                            <td class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/></td>
                                    </xsl:when>
                                    <xsl:otherwise>
                                            <td class="dos">&nbsp;</td>
                                    </xsl:otherwise>
                            </xsl:choose>
                        </tr>


                        <xsl:for-each select="DOCUMENTO">
                            <input type="hidden" name="ID_EMPRESA" value="{/Empresas/EMPRESA/EMP_ID}"/>
                                <tr>
								<td>&nbsp;</td>
								<td><xsl:if test="DOCUMENTOHIJO"><span class="rojo amarillo">|&nbsp;</span></xsl:if><xsl:value-of select="NOMBRE"/>&nbsp;( .<xsl:value-of select="substring-after(URL,'.')"/> )</td>
								<td>
									<a>
										<xsl:attribute name="href">http://www.newco.dev.br/Documentos/<xsl:value-of select="URL"/></xsl:attribute>
										<img src="http://www.newco.dev.br/images/descarga.gif" alt="Descarga"/>
									</a>
								</td>
								<td>
                                                                    <xsl:choose>
                                                                        <xsl:when test="//BORRAROFERTAS and not(/Empresas/EMPRESA/OBSERVADOR) and ../NOMBRE_CORTO = 'DOCUMENTOS_COMERCIALES_PROV'">
										<a>
											<xsl:attribute name="href">javascript:AsociarDocComeTodos('<xsl:value-of select="ID"/>','<xsl:value-of select="../TIPO"/>','<xsl:value-of select="../NOMBRE_CORTO"/>');</xsl:attribute>
											<img src="http://www.newco.dev.br/images/asociar.gif" alt="Asociar a todos los productos"/>
										</a>
									</xsl:when>
									<xsl:when test="//BORRAROFERTAS and not(/Empresas/EMPRESA/OBSERVADOR) and ../NOMBRE_CORTO != 'FICHAS_TECNICAS' and ../NOMBRE_CORTO != 'ANEXOS' and ../NOMBRE_CORTO != 'LOGOS'">
										<a>
											<xsl:attribute name="href">javascript:AsociarOfertaTodos('<xsl:value-of select="ID"/>','<xsl:value-of select="../TIPO"/>','<xsl:value-of select="../NOMBRE_CORTO"/>');</xsl:attribute>
											<img src="http://www.newco.dev.br/images/asociar.gif" alt="Asociar a todos los productos"/>
										</a>
									</xsl:when>
                                                                    </xsl:choose>

								</td>
								<td><xsl:value-of select="USUARIO"/></td>
								<td>
									<xsl:choose>
									<xsl:when test="((/Empresas/EMPRESA/MVM or /Empresas/EMPRESA/MVMB or /Empresas/EMPRESA/ADMIN) and not(/Empresas/EMPRESA/OBSERVADOR)) and ../NOMBRE_CORTO != 'ANEXOS' and ../NOMBRE_CORTO != 'FICHAS_TECNICAS' and ../NOMBRE_CORTO != 'LOGOS' and ../NOMBRE_CORTO != 'DOCUMENTOS_COMERCIALES_PROV'">
										<input type="text" name="fecha_{ID}" value="{FECHA}" maxlength="10" size="10" id="fecha_{ID}"/>
										<img src="http://www.newco.dev.br/images/actualizarFlecha.gif" alt="Actualizar Fecha" onmouseover="style.cursor='pointer'" onclick="javascript:ActualizarFechaOferta('{ID}','{../TIPO}','{../NOMBRE_CORTO}');"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="FECHA"/>
									</xsl:otherwise>
									</xsl:choose>
								</td>
                                                                <td>
									<xsl:choose>
									<xsl:when test="((/Empresas/EMPRESA/MVM or /Empresas/EMPRESA/MVMB or /Empresas/EMPRESA/ADMIN) and not(/Empresas/EMPRESA/OBSERVADOR)) and ../NOMBRE_CORTO != 'ANEXOS' and ../NOMBRE_CORTO != 'FICHAS_TECNICAS' and ../NOMBRE_CORTO != 'LOGOS' and ../NOMBRE_CORTO != 'DOCUMENTOS_COMERCIALES_PROV'">
										<input type="text" name="fechaFinal_{ID}" value="{FECHACADUCIDAD}" maxlength="10" size="10" id="fechaFinal_{ID}"/>
										<img src="http://www.newco.dev.br/images/actualizarFlecha.gif" alt="Actualizar Fecha final" onmouseover="style.cursor='pointer'" onclick="javascript:ActualizarFechaOferta('{ID}','{../TIPO}','{../NOMBRE_CORTO}');"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="FECHA"/>
									</xsl:otherwise>
									</xsl:choose>
								</td>
								<td>
									<xsl:if test="//BORRAROFERTAS and not(/Empresas/EMPRESA/OBSERVADOR)">
										<a>
											<xsl:attribute name="href">javascript:EliminarDocumento('<xsl:value-of select="ID"/>','<xsl:value-of select="../TIPO"/>','<xsl:value-of select="../NOMBRE_CORTO"/>');</xsl:attribute>
											<img src="http://www.newco.dev.br/images/eliminarOferta.gif" alt="Eliminar"/>
										</a>
									</xsl:if>
								</td>
							</tr>
                                                        <xsl:if test="DOCUMENTOHIJO">
                                                            <tr>
                                                                <td></td>
                                                                <td><span class="rojo amarillo">|&nbsp;<xsl:value-of select="DOCUMENTOHIJO/TIPO"/></span>&nbsp;<xsl:value-of select="DOCUMENTOHIJO/NOMBRE"/></td>
                                                                <td>
                                                                    <a>
										<xsl:attribute name="href">http://www.newco.dev.br/Documentos/<xsl:value-of select="DOCUMENTOHIJO/URL"/></xsl:attribute>
										<img src="http://www.newco.dev.br/images/descarga.gif" alt="Descarga"/>
                                                                    </a>
                                                                </td>
                                                                <td>&nbsp;</td>
                                                                <td><xsl:value-of select="DOCUMENTOHIJO/FECHA"/></td>
                                                            </tr>
                                                        </xsl:if>

                                        </xsl:for-each>

                                    </xsl:if>
                                </xsl:for-each>
                            </form>
                        </table>
                </xsl:if>
         <!--docuemntos anexos-->
            <xsl:for-each select="OFERTAS[NOMBRE_CORTO = 'ANEXOS']">
		<xsl:if test="//VEROFERTAS and DOCUMENTO">
			<table class="infoTableAma documentos" style="display:none;">
				<tr class="tituloGrisScuro">
					<td>&nbsp;</td>
					<td colspan="8" align="left" >
						<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='documentos_anexos']/node()"/></strong>
						<div id="waitBoxOfertaANE" class="gris" style="display:none; margin-top:5px;">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='cargando']/node()"/>...&nbsp;
						</div>
						<div id="confirmBoxAsociaOfertaANE" class="gris" style="display:none; margin-top:5px;">
							<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='anexo_asociado_a_todos']/node()"/></span>
						</div>
						<div id="confirmBoxEliminaOfertaANE" class="gris" style="display:none; margin-top:5px;">
							<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='anexo_eliminado']/node()"/>.</span>
						</div>
						<div id="confirmBoxModificaFechaANE" class="gris" style="display:none; margin-top:5px;">
							<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_anexo_actualizada']/node()"/>.</span>
						</div>
					</td>
				</tr>
				<!--nombres columnas-->
				<tr class="bold">
					<td class="uno">&nbsp;</td>
					<td><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_anexo']/node()"/></td>
					<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='descarga']/node()"/></td>
					<xsl:choose>
						<xsl:when test="BORRAROFERTAS">
							<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='asociar_anexo']/node()"/></td>
						</xsl:when>
						<xsl:otherwise>
							<td class="quince">&nbsp;</td>
						</xsl:otherwise>
					</xsl:choose>
					<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></td>
					<td class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></td>
					<xsl:choose>
						<xsl:when test="BORRAROFERTAS">
							<td class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/></td>
						</xsl:when>
						<xsl:otherwise>
							<td class="dos">&nbsp;</td>
						</xsl:otherwise>
					</xsl:choose>
				</tr>

				<form name="Anexos" method="post">
					<input type="hidden" name="ID_EMPRESA" value="{EMP_ID}"/>
					<tbody>
						<xsl:for-each select="DOCUMENTO">
							<tr>
								<td>&nbsp;</td>
								<td><xsl:value-of select="NOMBRE"/>&nbsp;( .<xsl:value-of select="substring-after(URL,'.')"/> )</td>
								<td>
									<a>
										<xsl:attribute name="href">http://www.newco.dev.br/Documentos/<xsl:value-of select="URL"/></xsl:attribute>
										<img src="http://www.newco.dev.br/images/descarga.gif" alt="Descarga"/>
									</a>
								</td>
								<td>

									<xsl:if test="../../BORRAROFERTAS and not(/Empresas/EMPRESA/OBSERVADOR)">
                                                                            <select name="SELECT_OFERTAS_{ID}" id="SELECT_OFERTAS_{ID}" onchange="verOfertasAnexo(this.value,'{ID}');">
                                                                                     <option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='seleccionar']/node()"/></option>
                                                                                      <xsl:for-each select="//OFERTAS">
                                                                                         <xsl:if test="DOCUMENTO">
                                                                                            <option value="{TIPO}"><xsl:value-of select="NOMBRE_CORTO"/></option>
                                                                                         </xsl:if>
                                                                                     </xsl:for-each>
                                                                             </select>
                                                                             <xsl:variable name="idanexo" select="ID" />
                                                                              <xsl:for-each select="//OFERTAS">
                                                                                         <xsl:if test="DOCUMENTO">
                                                                                            <select name="OFERTAS_ANEXO_{TIPO}_{$idanexo}" id="OFERTAS_ANEXO_{TIPO}_{$idanexo}" class="ofertasAnexo" style="display:none;">
                                                                                                    <xsl:for-each select="DOCUMENTO">
                                                                                                    <option value="{ID}"><xsl:value-of select="NOMBRE"/></option>
                                                                                                </xsl:for-each>
                                                                                            </select>
                                                                                         </xsl:if>
                                                                              </xsl:for-each>

										<a>
											<xsl:attribute name="href">javascript:asociarDocumentoPadre('<xsl:value-of select="ID"/>');</xsl:attribute>
											<img src="http://www.newco.dev.br/images/asociar.gif" alt="Asociar a la oferta"/>
										</a>
                                                                            <div id="confirmBoxDocPadre_{ID}" style="display:none;">
                                                                                <span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_anexo_asociado']/node()"/>.</span>
                                                                            </div>
                                                                            <div id="waitBoxDocPadre_{ID}" style="display:none;">&nbsp;</div>

									</xsl:if>
								</td>
								<td><xsl:value-of select="USUARIO"/></td>
								<td><xsl:value-of select="FECHA"/>
									<!--<xsl:choose>
									<xsl:when test="/Empresas/EMPRESA/MVM or /Empresas/EMPRESA/MVMB">
										<input type="text" name="fecha_{ID}" value="{FECHA}" maxlength="10" size="10" id="fecha_{ID}"/>
										<img src="http://www.newco.dev.br/images/actualizarFlecha.gif" alt="Actualizar Fecha" onmouseover="style.cursor='pointer'" onclick="javascript:ActualizarFechaOferta('Anexos',{ID},'ANE');"/>
									</xsl:when>
									<xsl:otherwise>

									</xsl:otherwise>
									</xsl:choose>-->
								</td>
								<td>
									<xsl:if test="../../BORRAROFERTAS and not(/Empresas/EMPRESA/OBSERVADOR)">
										<a>
											<xsl:attribute name="href">javascript:EliminarDocumento('Anexos','<xsl:value-of select="ID"/>','ANE');</xsl:attribute>
											<img src="http://www.newco.dev.br/images/eliminarOferta.gif" alt="Eliminar"/>
										</a>
									</xsl:if>
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
				</form>
			</table><!--fin de tabla anexos-->
		</xsl:if><!--fin de if si hay doc anexos-->
            </xsl:for-each>

		<!--logos-->
		<xsl:if test="/Empresas/EMPRESA/LOGOS/DOCUMENTO and /Empresas/EMPRESA/MVM">
			<!--<table class="mediaTabla documentos" style="display:none;">-->
			<table class="buscador documentos" style="display:none;">
				<tr class="tituloGrisScuro documentos">
					<td>&nbsp;</td>
					<td colspan="8" align="left" >
						<strong>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='logos']/node()"/>
						</strong>
						<div id="waitBoxOfertaLOGO" class="gris" style="display:none; margin-top:5px;">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='cargando']/node()"/>...&nbsp;
						</div>
						<div id="confirmBoxAsociaOfertaLOGO" class="gris" style="display:none; margin-top:5px;">
							<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_asociado_a_todos']/node()"/></span>
						</div>
						<div id="confirmBoxEliminaOfertaLOGO" class="gris" style="display:none; margin-top:5px;">
							<span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_eliminado']/node()"/>.</span>
						</div>
					</td>
				</tr>

				<!--nombres columnas-->
				<tr class="bold">
					<td class="uno">&nbsp;</td>
					<td><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_logo']/node()"/></td>
					<td class="dies"><!--<xsl:value-of select="document($doc)/translation/texts/item[@name='descarga']/node()"/>--></td>
					<td class="quince">&nbsp;</td>
					<td class="quince"><!--<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>--></td>
					<td class="quince"><!--<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>--></td>
					<td class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/></td>
				</tr>

				<form name="LOGO">
					<input type="hidden" name="ID_EMPRESA" value="{EMP_ID}"/>
					<tbody>
						<xsl:for-each select="/Empresas/EMPRESA/LOGOS/DOCUMENTO">
							<tr>
								<td>&nbsp;</td>
								<td><xsl:value-of select="NOMBRE"/>&nbsp;( .<xsl:value-of select="substring-after(URL,'.')"/> )</td>
								<td>
									<!--<a>
										<xsl:attribute name="href">http://www.newco.dev.br/Documentos/<xsl:value-of select="URL"/></xsl:attribute>
										<img src="http://www.newco.dev.br/images/descarga.gif" alt="Descarga"/>
									</a>-->
								</td>
								<td>&nbsp;</td>
								<td><xsl:value-of select="USUARIO"/></td>
								<td><xsl:value-of select="FECHA"/></td>
								<td>
                                                                    <xsl:if test="not(/Empresas/EMPRESA/OBSERVADOR)">
										<a>
											<xsl:attribute name="href">javascript:EliminarDocumento('LOGO','<xsl:value-of select="ID"/>','LOGO');</xsl:attribute>
											<img src="http://www.newco.dev.br/images/eliminarOferta.gif" alt="Eliminar"/>
										</a>
                                                                    </xsl:if>
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
				</form>
			</table><!--fin de tabla logos-->
		</xsl:if><!--fin de if si hay logos solo mvm-->


		<!-- INICIO Condiciones Comerciales -->
		<h1 class="titlePage cond_comercial cond_comercial_prov" style="display:none;float:left;width:60%;padding-left:20%;">
                    <xsl:choose>
                        <xsl:when test="EMP_NOMBRE_CORTO != ''"><xsl:value-of select="EMP_NOMBRE_CORTO" disable-output-escaping="yes"/></xsl:when>
                        <xsl:otherwise><xsl:value-of select="EMP_NOMBRE" disable-output-escaping="yes"/></xsl:otherwise>
                    </xsl:choose>:&nbsp;
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='informacion_comercial']/node()"/>

                    <xsl:if test="/Empresas/EMPRESA/MVM or /Empresas/EMPRESA/MVMB">
                        <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
                        <a href="javascript:window.print();" style="text-decoration:none;">
                            <img src="http://www.newco.dev.br/images/imprimir.gif"/>
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
                        </a>
                        <!--enseï¿½o resumen arriba solo para proveedores, si es cliente enseï¿½o tabla directamente-->
                            <xsl:if test="/Empresas/EMPRESA/ROL = 'VENDEDOR'">
                            <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
                                <a style="text-decoration:none;">
                                    <xsl:attribute name="href">javascript:showTablaResumenEmpresa(true);</xsl:attribute>
                                    <img src="http://www.newco.dev.br/images/tabla.gif"/>&nbsp;
                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='resumen']/node()"/>
                                </a>
                            </xsl:if>
                    </xsl:if>
		</h1>
                <h1 class="titlePage cond_comercial cond_comercial_prov" style="display:none;float:left;width:20%;">&nbsp;
                    <xsl:if test="/Empresas/EMPRESA/MVM or /Empresas/EMPRESA/MVMB or /Empresas/EMPRESA/ADMIN"><span style="float:right; padding:5px;" class="amarillo">EMP_ID: <xsl:value-of select="EMP_ID"/></span></xsl:if>
                </h1>

        <!--CONDICIONES COMERCIALES SI SOY PROVEEDOR-->
        <xsl:if test="/Empresas/EMPRESA/ROL = 'VENDEDOR'">
            <xsl:call-template name="condComercialProveedor" />
	</xsl:if>
	<!-- FIN Condiciones Comerciales (ficha empresa proveedor) -->


	<!-- INICIO Condiciones Comerciales a Proveedor (ficha empresa cliente) -->
	<xsl:if test="/Empresas/EMPRESA/ROL = 'COMPRADOR'">
            <xsl:call-template name="condComercialCliente" />
	</xsl:if>

		<!--mensajes js -->
		<form name="MensajeJS">
			<input type="hidden" name="SEGURO_ELIMINAR_OFERTA" value="{document($doc)/translation/texts/item[@name='seguro_eliminar_oferta']/node()}"/>

            <input type="hidden" name="SEGURO_ELIMINAR_OFERTA_ANE" value="{document($doc)/translation/texts/item[@name='seguro_eliminar_anexo']/node()}"/>
            <input type="hidden" name="SEGURO_ELIMINAR_FICHA" value="{document($doc)/translation/texts/item[@name='seguro_eliminar_ficha']/node()}"/>
            <input type="hidden" name="SEGURO_ASOCIAR_OFERTA" value="{document($doc)/translation/texts/item[@name='seguro_asociar_oferta']/node()}"/>
            <input type="hidden" name="SEGURO_MODIFICAR_FECHA" value="{document($doc)/translation/texts/item[@name='seguro_modificar_fecha']/node()}"/>
             <!--carga documentos-->
            <input type="hidden" name="ERROR_SIN_DEFINIR" value="{document($doc)/translation/texts/item[@name='error_sin_definir']/node()}"/>
            <input type="hidden" name="HEMOS_ESPERADO" value="{document($doc)/translation/texts/item[@name='hemos_esperado']/node()}"/>
            <input type="hidden" name="LA_CARGA_NO_TERMINO" value="{document($doc)/translation/texts/item[@name='la_carga_no_termino']/node()}"/>
            <input type="hidden" name="CARGANDO_IMAGEN" value="{document($doc)/translation/texts/item[@name='cargando_imagen']/node()}"/>
            <input type="hidden" name="FICHA_OBLIGATORIA" value="{document($doc)/translation/texts/item[@name='ficha_obligatoria']/node()}"/>
		</form>
		<!--fin de mensajes js -->
	</div><!--fin de divCenter50-->

        <!-- DIV Nueva etiqueta -->
<div class="overlay-container" id="verEtiquetas">
	<div class="window-container zoomout">
		<p style="text-align:right;">
                    <a href="javascript:showTabla(false);" style="text-decoration:none;">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
                    </a>&nbsp;
                    <a href="javascript:showTabla(false);" style="text-decoration:none;">
                        <img src="http://www.newco.dev.br/images/cerrar.gif" alt="Cerrar" />
                    </a>
                </p>

		<p id="tableTitle">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta']/node()"/>&nbsp;
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='para']/node()"/>&nbsp;

                    <xsl:choose>
			<xsl:when test="EMP_NOMBRE_CORTO != ''"><xsl:value-of select="EMP_NOMBRE_CORTO" disable-output-escaping="yes"/></xsl:when>
                        <xsl:otherwise><xsl:value-of select="substring(EMP_NOMBRE,0,50)" disable-output-escaping="yes"/></xsl:otherwise>
                    </xsl:choose>
<!--
			&nbsp;<a href="javascript:window.print();" style="text-decoration:none;">
				<img src="http://www.newco.dev.br/images/imprimir.gif">
					<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></xsl:attribute>
					<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></xsl:attribute>
				</img>
			</a>
-->
		</p>

		<div id="mensError" class="divLeft" style="display:none;">
			<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/></strong></p>
		</div>

		<table id="viejasEtiquetas" border="0" style="width:100%;display:none;">
		<thead>
			<th colspan="5">&nbsp;</th>
		</thead>

		<tbody></tbody>

		</table>

		<form name="nuevaEtiquetaForm" method="post" id="nuevaEtiquetaForm">

		<table id="nuevaEtiqueta" style="width:100%;">
		<thead>
			<th colspan="3">&nbsp;</th>
		</thead>

		<tbody>
			<tr>
				<td class="quince"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='etiqueta']/node()"/>:</strong></td>
				<td colspan="2" style="text-align:left;"><textarea name="TEXTO" id="TEXTO" rows="4" cols="70" /></td>
			</tr>
		</tbody>

		<tfoot>
			<tr>
				<td>&nbsp;</td>
				<td>
					<div class="boton" id="botonGuardar">
						<a href="javascript:guardarEtiqueta();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
						</a>
					</div>
				</td>
				<td id="Respuesta" style="text-align:left;"></td>
			</tr>
		</tfoot>
		</table>
		</form>
	</div>
</div>
<!-- FIN DIV Nueva etiqueta -->

</xsl:template>

<!--documentos-->
<xsl:template name="documentos">
	<xsl:param name="num" />
	<xsl:choose>
	<!--imagenes de la tienda-->
		<xsl:when test="$num &lt; number(5)">
			<div class="docLine" id="docLine">
				<!--<xsl:if test="number($num) &gt; number(1)">
						<xsl:attribute name="style">display: none;</xsl:attribute>
				</xsl:if>-->
				<div class="docLongEspec" id="docLongEspec">
					<input id="inputFileDoc" name="inputFileDoc" type="file" onChange="addDocFile();" />
				</div>
			</div>
		</xsl:when>

	</xsl:choose>
    </xsl:template>
<!--fin de documentos-->

<!--TEMPLATE COND_COMMERCIALES PROVEEDOR-->
<xsl:template name="condComercialProveedor">
    <!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/Empresas/LANG"><xsl:value-of select="/Empresas/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

        <!-- Pop-up para mostrar tabla resumen empresa -->
	<xsl:if test="/Empresas/EMPRESA/MVM or /Empresas/EMPRESA/MVMB">
	<div class="overlay-container-2">
		<div class="window-container zoomout">
			<p><a href="javascript:showTablaResumenEmpresa(false);"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a></p>
			<table>
			<thead>
				<tr>
					<td>&nbsp;</td>
				<xsl:for-each select="/Empresas/EMPRESA/RESUMENES_MENSUALES/CABECERA/COLUMNA">
					<td><xsl:value-of select="MES"/>/<xsl:value-of select="ANYO"/></td>
				</xsl:for-each>
				</tr>
			</thead>

			<tbody>
			<xsl:for-each select="/Empresas/EMPRESA/RESUMENES_MENSUALES/RESUMEN_MENSUAL">
				<tr>
					<td class="indicador"><xsl:value-of select="@Nombre"/></td>
				<xsl:for-each select="COLUMNA">
					<td><xsl:value-of select="VALOR"/></td>
				</xsl:for-each>
                                </tr>
			</xsl:for-each>
			</tbody>
			</table>
		</div>
	</div>
	</xsl:if>
	<!-- FIN Pop-up para mostrar tabla resumen empresa -->

        <div class="divLeft cond_comercial_prov" style="display:none;">
        <!--ANALISI PEDIDOS-->
        <div class="divLeft30nopa">
        <xsl:choose>
        <xsl:when test="/Empresas/EMPRESA/CONDICIONES/IMPORTE_PEDIDOS != '0' and /Empresas/EMPRESA/CONDICIONES/NUMERO_PEDIDOS != '0' and /Empresas/EMPRESA/CONDICIONES/RETRASO_MEDIO != '0,00'">
        <table class="infoTable" border="0">
		<thead>
			<tr class="subTituloTabla">
				<td colspan="3">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='analisis_pedidos']/node()"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='periodo']/node()"/>&nbsp;<xsl:value-of select="/Empresas/EMPRESA/CONDICIONES/INICIO_ANALISIS"/>&nbsp;-&nbsp;<xsl:value-of select="/Empresas/EMPRESA/CONDICIONES/FINAL_ANALISIS"/>
				</td>
			</tr>
        </thead>
        <tbody>
            <tr>
            	<td class="labelRight sesanta">
                	<xsl:value-of select="document($doc)/translation/texts/item[@name='importe_tot_pedidos']/node()"/>:
                </td>
                <td class="datosLeft">
                        <strong><xsl:value-of select="/Empresas/EMPRESA/CONDICIONES/IMPORTE_PEDIDOS"/>&nbsp;
                        <xsl:choose>
                            <xsl:when test="/Empresas/LANG = 'spanish'">€</xsl:when>
                            <xsl:otherwise>R$</xsl:otherwise>
                        </xsl:choose>
                        </strong>

                </td>
								<td class="datosLeft">
									<a href="javascript:mostrarEIS('CO_Pedidos_Eur','{/Empresas/EMPRESA/EMP_ID}','','','9999');">
										<img src="http://www.newco.dev.br/images/tabla.gif"/>
									</a>
								</td>
            </tr>
            <tr>
                <td class="labelRight sesanta">
                	<xsl:value-of select="document($doc)/translation/texts/item[@name='numero_de_pedidos']/node()"/>:
                </td>
                <td class="datosLeft"><strong><xsl:value-of select="/Empresas/EMPRESA/CONDICIONES/NUMERO_PEDIDOS"/></strong></td>
								<td class="datosLeft">
									<a href="javascript:mostrarEIS('CO_Resumen_Num','{/Empresas/EMPRESA/EMP_ID}','','','9999');">
										<img src="http://www.newco.dev.br/images/tabla.gif"/>
									</a>
								</td>
            </tr>
            <tr>
                <td class="labelRight sesanta">
                	<xsl:value-of select="document($doc)/translation/texts/item[@name='retraso_medio']/node()"/>:
                </td>
                <td class="datosLeft"><strong><xsl:value-of select="/Empresas/EMPRESA/CONDICIONES/RETRASO_MEDIO"/></strong></td>
								<td class="datosLeft">
									<a href="javascript:mostrarEIS('CO_RetrasosPedidos','{/Empresas/EMPRESA/EMP_ID}','','','9999');">
										<img src="http://www.newco.dev.br/images/tabla.gif"/>
									</a>
								</td>
            </tr>
        </tbody>
        </table>
        </xsl:when>
        <xsl:otherwise>
        	<table class="infoTable" border="0">
            <thead>
                <tr class="subTituloTabla">
                    <td>
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='estadisticas_de_servicio']/node()"/>
                    </td>
                </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_pedidos_en_periodo']/node()"/>:&nbsp;<xsl:value-of select="/Empresas/EMPRESA/CONDICIONES/INICIO_ANALISIS"/>&nbsp;-&nbsp;<xsl:value-of select="/Empresas/EMPRESA/CONDICIONES/FINAL_ANALISIS"/>
                        </td>
                    </tr>
                </tbody>
            </table>
        </xsl:otherwise>
        </xsl:choose>
        </div><!--fin de divLeft30nopa-->

        <!--PEDIDO MINIMO-->
            <div class="divLeft40nopa">
                <xsl:call-template name="pedidoMinimo" />
            </div>
        <!--CONDICIONES PROVEE-->
        <div class="divLeft30nopa">
            <table class="infoTable" border="0">
            	<thead>
                 <tr class="subTituloTabla">
                    <td><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_para']/node()"/>&nbsp;<xsl:value-of select="/Empresas/EMPRESA/EMP_NOMBRE" /></td>
                </tr>
                </thead>
                <xsl:if test="/Empresas/EMPRESA/CONDICIONES/COP_FORMADEPAGO = ''">
                <tr>
                    <td>
                    <!--<xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_pago_centro']/node()"/>&nbsp;
                    "<xsl:value-of select="/Empresas/EMPRESA/CONDICIONES/FORMA_PAGO/CEN_NOMBRE"/>"&nbsp;a&nbsp;
                    <xsl:value-of select="EMP_NOMBRE" disable-output-escaping="yes"/>:&nbsp;-->
                    <xsl:value-of select="/Empresas/EMPRESA/CONDICIONES/FORMA_PAGO/CEN_FORMAPAGO_TXT"/>&nbsp;-&nbsp;
                    <xsl:value-of select="/Empresas/EMPRESA/CONDICIONES/FORMA_PAGO/CEN_PLAZOPAGO_TXT"/>
                    </td>
                </tr>
                </xsl:if>
                <xsl:if test="/Empresas/EMPRESA/CONDICIONES/PLAZOENTREGA/PLANTILLA and /Empresas/EMPRESA/ROL = 'VENDEDOR'">
                    <xsl:for-each select="/Empresas/EMPRESA/CONDICIONES/PLAZOENTREGA/PLANTILLA">
                        <tr>
                            <td><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/>&nbsp;-&nbsp;<strong><xsl:value-of select="CATEGORIA"/></strong>&nbsp;<xsl:value-of select="PL_PLAZOENTREGA"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='dias']/node()"/>
                            </td>
                        </tr>
                    </xsl:for-each>

		</xsl:if>
                <tr>
                    <td></td>
                </tr>
                </table>
            </div><!--fin de divLeft30nopa-->

        </div><!--fin de divLeft-->


        <!--pestaï¿½as condic comerciales prove, licitaciones, incidencias, rotura stock proveedor, cliente y mvm visualiza-->
        <div class="divLeft lineaAzul cond_comercial_prov" style="display:none;">&nbsp;</div>
        <div class="divLeft cond_comercial_prov" style="display:none;">
        <div class="divLeft15nopa">&nbsp;</div>
					<div class="divLeft70">
						<table id="PestanasInicio" border="0">
							<tr>
                                                                <th>&nbsp;</th>
                                                                <!--condic comm-->
                                                                    <th class="veinte" id="pestanaCondicPartic">
                                                                            <xsl:if test="not(/Mantenimiento/MANTENIMIENTO/ADMIN)"><xsl:attribute name="bgcolor">#C3D2E9</xsl:attribute></xsl:if>
                                                                            <a href="javascript:verTablas70('pestanaCondicPartic');">
                                                                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_particulares']/node()"/>
                                                                            </a>
                                                                    </th>
                                                                <!--licitaciones
                                                                    <th class="veinte pestanaInicio" id="pestanaLicitaciones">
                                                                            <a href="javascript:verTablas70('pestanaLicitaciones');">
                                                                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones']/node()"/>
                                                                            </a>
                                                                    </th>-->
                                                                <!--evaluaciones-->
                                                                    <th class="veinte pestanaInicio" id="pestanaEvaluaciones">
                                                                            <a href="javascript:verTablas70('pestanaEvaluaciones');">
                                                                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='evaluaciones']/node()"/>
                                                                                    &nbsp;(<xsl:value-of select="EVALUACIONESPRODUCTOS/TOTAL" />)

                                                                            </a>
                                                                    </th>
                                                                <!--incidencias-->
                                                                    <th class="veinte pestanaInicio" id="pestanaIncidecias">
                                                                            <a href="javascript:verTablas70('pestanaIncidecias');">
                                                                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='incidencias']/node()"/>
                                                                                    &nbsp;(<xsl:value-of select="INCIDENCIASPRODUCTOS/TOTAL" />)
                                                                            </a>
                                                                    </th>
                                                                <!--rotura de stock-->
                                                                    <th class="veinte pestanaInicio" id="pestanaRoturas">
                                                                            <a href="javascript:verTablas70('pestanaRoturas');">
                                                                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='roturas_stock']/node()"/>
                                                                                    &nbsp;(<xsl:value-of select="ROTURAS_STOCKS/TOTAL" />)
                                                                            </a>
                                                                    </th>
                                                                <th>&nbsp;</th>
							</tr>
						</table>
					</div><!--fin de divcenter70-->
				</div><!--fin de divleft pestaï¿½as-->

            <!--condiciones particulares-->
            <div class="divLeft tablas70 cond_comercial_prov" id="pestanaCondicParticDiv" style="margin-bottom:15px;display:none;">

		<table class="infoTable" border="0">
		<form name="CondProveedor" id="formCondProveedor" method="post">
		<input type="hidden" name="IDPROV" value="{/Empresas/EMPRESA/EMP_ID}" id="IDPROV"/>
		<thead>
			<tr>
				<th colspan="7"><xsl:value-of select="document($doc)/translation/texts/item[@name='condiciones_particulares']/node()"/></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class="dos">&nbsp;</td>
				<td class="labelRight trenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='forma_pago']/node()"/>:</td>
				<td clasS="datosLeft quince">
				<xsl:choose>
				<xsl:when test="/Empresas/EMPRESA/ADMIN">
                                        <xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Empresas/EMPRESA/CONDICIONES/FORMASPAGO/field"/>
                                            </xsl:call-template>
					<!--<input type="text" name="FORMA_PAGO" value="{/Empresas/EMPRESA/CONDICIONES/COP_FORMADEPAGO}" size="40"/>-->
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/Empresas/EMPRESA/CONDICIONES/COP_FORMADEPAGO"/>
				</xsl:otherwise>
				</xsl:choose>
                                </td>
                                <td class="labelRight dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_de_pago']/node()"/>:</td>
				<td clasS="datosLeft">
				<xsl:choose>
				<xsl:when test="/Empresas/EMPRESA/ADMIN">
                                        <xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Empresas/EMPRESA/CONDICIONES/PLAZOSPAGO/field"/>
                                            </xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/Empresas/EMPRESA/CONDICIONES/COP_FORMADEPAGO"/>
				</xsl:otherwise>
				</xsl:choose>
                                </td>
				<td>&nbsp;</td>
                        </tr>
			<tr>
				<td>&nbsp;</td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='gestion_caducidades']/node()"/>:</td>
				<td clasS="datosLeft" colspan="3">
				<xsl:choose>
				<xsl:when test="/Empresas/EMPRESA/ADMIN">
					<textarea name="GESTION_CADUCIDAD" cols="80" rows="4">
						<xsl:value-of select="/Empresas/EMPRESA/CONDICIONES/COP_GESTIONCADUCIDADES"/>
					</textarea>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/Empresas/EMPRESA/CONDICIONES/COP_GESTIONCADUCIDADES"/>
				</xsl:otherwise>
				</xsl:choose>
				</td>
				<td>&nbsp;</td>
                        </tr>

			<tr>
				<td>&nbsp;</td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='otras_licitaciones']/node()"/>:</td>
				<td clasS="datosLeft" colspan="3">
				<xsl:choose>
				<xsl:when test="/Empresas/EMPRESA/ADMIN">
					<textarea name="OTRAS_LICITACIONES" cols="80" rows="4">
						<xsl:value-of select="/Empresas/EMPRESA/CONDICIONES/COP_OTRASLICITACIONES"/>
					</textarea>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/Empresas/EMPRESA/CONDICIONES/COP_OTRASLICITACIONES"/>
				</xsl:otherwise>
				</xsl:choose>
				</td>
				<td>&nbsp;</td>
                        </tr>
                        <tr>
				<td>&nbsp;</td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones_pedidos']/node()"/>:</td>
				<td clasS="datosLeft" colspan="3">
				<xsl:choose>
				<xsl:when test="/Empresas/EMPRESA/ADMIN">
					<textarea name="OBSERVACIONES" cols="80" rows="4">
						<xsl:value-of select="/Empresas/EMPRESA/CONDICIONES/COP_OBSERVACIONESPEDIDOS"/>
					</textarea>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/Empresas/EMPRESA/CONDICIONES/COP_OBSERVACIONESPEDIDOS"/><br />
				</xsl:otherwise>
				</xsl:choose>
                                <br />
                                <xsl:value-of select="document($doc)/translation/texts/item[@name='observaciones_pedido_expli']/node()"/>
				</td>
				<td>&nbsp;</td>
                        </tr>
		<xsl:if test="/Empresas/EMPRESA/ADMIN">
			<tr style="display:none;" id="SAVE_MSG">
				<td colspan="2">&nbsp;</td>
				<td colspan="2" id="SAVE_MSG_CELL" class="fondoVerde" style="text-align:left;font-weight:bold;">&nbsp;</td>
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;</td>
				<td>
					<xsl:if test="not(/Empresas/EMPRESA/OBSERVADOR)">
                                            <div class="boton">
						<a href="javascript:CondProveedorSend(document.forms['CondProveedor']);">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
						</a>
                                            </div>
                                        </xsl:if>
				</td>
				<td colspan="3">&nbsp;</td>
			</tr>
		</xsl:if>
		</tbody>
                </form>
		</table>

        </div><!--fin de divLeft-->

        <!--licitaciones info comm-->
            <div class="divLeft tablas70" id="pestanaLicitacionesDiv" style="display:none;">
                <xsl:choose>
                <xsl:when test="/Empresas/EMPRESA/CONDICIONES/LICITACIONES/LICITACION">
		<table class="infoTable" border="0">
		<thead>
			<tr>
				<th class="dies">&nbsp;</th>
				<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_alta']/node()"/></th>
				<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/></th>
				<th style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
				<th>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/>&nbsp;
					(<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='c_iva']/node()"/>)
				</th>
				<th style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor_adjudicado']/node()"/></th>
			</tr>
                </thead>
		<tbody>
		<xsl:for-each select="/Empresas/EMPRESA/CONDICIONES/LICITACIONES/LICITACION">
			<tr class="lineGris">
				<td class="dos">&nbsp;</td>
				<td class="textLeft ocho"><xsl:value-of select="LIC_FECHAALTA"/></td>
				<td class="textLeft ocho"><xsl:value-of select="LIC_FECHADECISIONPREVISTA"/></td>
				<td class="veinte" style="text-align:left;"><xsl:value-of select="LIC_TITULO"/></td>
				<td><xsl:value-of select="ESTADO"/></td>
				<td><xsl:value-of select="LIC_CONSUMOIVA"/></td>
				<td style="text-align:left;"><xsl:value-of select="PROVEEDORSELECCIONADO"/></td>
			</tr>
		</xsl:for-each>
		</tbody>
		</table>
                </xsl:when>
                <xsl:otherwise>
                    <table class="infoTable" border="0">
                    <thead>
			<tr>
                            <th><xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_sin_resultados']/node()"/></th>
			</tr>
                    </thead>
                    </table>
                </xsl:otherwise>
                </xsl:choose>
            </div><!--fin de divLeft-->

        <!--evaluaciones info comm-->
        <div class="divLeft tablas70" id="pestanaEvaluacionesDiv" style="display:none;">
            <xsl:choose>
            <xsl:when test="/Empresas/EMPRESA/EVALUACIONESPRODUCTOS/EVALUACION">
		<table class="infoTable" border="0">
		<thead>
			<tr>
				<td class="cinco">&nbsp;</td>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
				<th class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_abbr']/node()"/></th>
				<th><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
                                <!--<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>-->
				<th align="left" class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_cliente']/node()"/></th>
                                <th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='respon']/node()"/></th>
                                <th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
                                <th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/></th>
				<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
                                <th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='coordinador']/node()"/></th>
				<!--<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>-->
                                <th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_prov']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='diagn']/node()"/></th>
                                <th>&nbsp;</th>
			</tr>
                </thead>
		<tbody>
		<xsl:for-each select="/Empresas/EMPRESA/EVALUACIONESPRODUCTOS/EVALUACION">
			<tr class="lineGris">
				<td>&nbsp;</td>
                                <td><xsl:value-of select="position()"/></td>
					<td><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/EvaluacionProducto.xsql?ID_EVAL={PROD_EV_ID}','evaluacion',100,80,0,-10)">
                                            <xsl:value-of select="PROD_EV_CODIGO"/>
                                            </a>
                                        </td>
					<td><xsl:value-of select="PROD_EV_FECHA"/></td>
					<!--<td style="text-align:left;">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={IDCLIENTE}&amp;VENTANA=NUEVA','DetalleEmpresa',100,80,0,0)">
							<xsl:value-of select="CLIENTE"/>
						</a>&nbsp;
					</td>-->
					<td style="text-align:left;">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTROEVALUACION}','DetalleCentro',100,80,0,0)">
							<xsl:value-of select="CENTROEVALUACION"/>
                                                </a>
					</td>
                                        <td style="text-align:left;"><xsl:value-of select="AUTOR"/></td>
                                        <td style="text-align:left;">&nbsp;
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/EvaluacionProducto.xsql?ID_EVAL={PROD_EV_ID}','evaluacion',100,80,0,-10)">
							<xsl:value-of select="REFERENCIA"/></a>
					</td>
                                        <td style="text-align:left;">
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/EvaluacionProducto.xsql?ID_EVAL={PROD_EV_ID}','evaluacion',100,80,0,-10)">

							<xsl:value-of select="PROD_EV_REFPROVEEDOR"/>&nbsp;
						</a>
					</td>
					<td style="text-align:left;">
						<strong><a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/EvaluacionProducto.xsql?ID_EVAL={PROD_EV_ID}','evaluacion',100,80,0,-10)">
							<xsl:value-of select="PROD_EV_NOMBRE"/>
						</a></strong>
					</td>
                                        <td style="text-align:left;">
							<xsl:value-of select="COORDINADOR"/>
					</td>
					<!--<td style="text-align:left;">
							<xsl:value-of select="PROVEEDOR"/>
					</td>-->
                                        <td style="text-align:left;">&nbsp;<xsl:value-of select="USUARIOMUESTRAS"/></td>
					<td><xsl:value-of select="ESTADO"/></td>
                                        <td>
                                            &nbsp;
                                            <xsl:choose>
                                                <xsl:when test="PROD_EV_DIAGNOSTICO = 'Apto'"><span class="verde"><xsl:value-of select="PROD_EV_DIAGNOSTICO" /></span></xsl:when>
                                                <xsl:otherwise><span class="rojo"><xsl:value-of select="PROD_EV_DIAGNOSTICO" /></span></xsl:otherwise>
                                            </xsl:choose>

                                        </td>
					<td>&nbsp;</td>
			</tr>
		</xsl:for-each>
		</tbody>
		</table>
            </xsl:when>
            <xsl:otherwise>
                <table class="infoTable" border="0">
		<thead>
			<tr>
                            <th><xsl:value-of select="document($doc)/translation/texts/item[@name='evaluaciones_sin_resultados']/node()"/></th>
			</tr>
                </thead>
                </table>
            </xsl:otherwise>
            </xsl:choose>
        </div><!--fin de divLeft-->

        <!--incidencias info comm-->
        <div class="divLeft tablas70" id="pestanaIncideciasDiv" style="display:none;">
        <xsl:choose>
            <xsl:when test="/Empresas/EMPRESA/INCIDENCIASPRODUCTOS/INCIDENCIA">
		<table class="infoTable" border="0">
		<thead>
			<tr>
				<th class="cinco">&nbsp;</th>
                                <th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
				<th class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_abbr']/node()"/></th>
				<th><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha_comunicacion_2line']/node()"/></th>
                                <th><xsl:copy-of select="document($doc)/translation/texts/item[@name='ultimo_cambio']/node()"/></th>
                                <!--<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>-->
				<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_de_cliente']/node()"/></th>
				<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
				<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
				<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/></th>
				<!--<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>-->
				<th><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
                                <th>&nbsp;</th>

			</tr>
                </thead>
		<tbody>
		<xsl:for-each select="/Empresas/EMPRESA/INCIDENCIASPRODUCTOS/INCIDENCIA">
			<tr class="lineGris">
				<td class="dos">&nbsp;</td>
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
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID={IDCENTROCLIENTE}','DetalleCentro',100,80,0,0)">
							<xsl:value-of select="CENTROCLIENTE"/>
                                                </a>
					</td>
					<td style="text-align:left;">&nbsp;
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencia.xsql?ID_INC={PROD_INC_ID}&amp;PRO_ID={PROD_INC_IDPRODUCTO}&amp;LIC_OFE_ID={PROD_INC_IDOFERTA_LIC}','incidencia',100,80,0,-10)">

							<xsl:value-of select="REFERENCIA"/>
						</a>
					</td>
					<td style="text-align:left;">&nbsp;
						<strong>
                                                    <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencia.xsql?ID_INC={PROD_INC_ID}&amp;PRO_ID={PROD_INC_IDPRODUCTO}&amp;LIC_OFE_ID={PROD_INC_IDOFERTA_LIC}','incidencia',100,80,0,-10)">
							<xsl:value-of select="PROD_INC_DESCESTANDAR"/>
                                                    </a>
                                                </strong>
					</td>
					<td style="text-align:left;"><xsl:value-of select="USUARIO"/></td>

					<!--<td style="text-align:left;">
						<xsl:value-of select="PROVEEDOR"/>
					</td>-->
					<td><xsl:value-of select="ESTADO"/></td>
			</tr>
		</xsl:for-each>
		</tbody>
		</table>
            </xsl:when>
            <xsl:otherwise>
                <table class="infoTable" border="0">
		<thead>
                    <tr>
			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='incidecias_sin_resultados']/node()"/></th>
                    </tr>
                </thead>
                </table>
            </xsl:otherwise>
        </xsl:choose>
        </div><!--fin de divLeft-->

         <!--roturas de stock info comm-->
        <div class="divLeft tablas70" id="pestanaRoturasDiv" style="display:none;">
        <xsl:choose>
            <xsl:when test="/Empresas/EMPRESA/ROTURAS_STOCKS/ROTURAS_STOCKS_HISTORICAS/ROTURA_STOCKS or /Empresas/EMPRESA/ROTURAS_STOCKS/ROTURAS_STOCKS_ACTIVAS/ROTURA_STOCKS">
		<table class="infoTable" border="0">
		<thead>
			<tr>
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
                </thead>
		<tbody>
                <xsl:for-each select="/Empresas/EMPRESA/ROTURAS_STOCKS/ROTURAS_STOCKS_ACTIVAS/ROTURA_STOCKS">
			<tr class="lineGris amarillo">
				<td>&nbsp;</td>
				<td style="text-align:left;"><xsl:value-of select="POS"/></td>
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
		<xsl:for-each select="/Empresas/EMPRESA/ROTURAS_STOCKS/ROTURAS_STOCKS_HISTORICAS/ROTURA_STOCKS">
			<tr class="lineGris">
				<td>&nbsp;</td>
				<td style="text-align:left;"><xsl:value-of select="POS"/></td>
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
		</tbody>
		</table>
            </xsl:when>
            <xsl:otherwise>
                <table class="infoTable" border="0">
		<thead>
                    <tr>
			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='roturas_sin_resultados']/node()"/></th>
                    </tr>
                </thead>
                </table>
            </xsl:otherwise>
        </xsl:choose>
        </div><!--fin de divLeft-->

</xsl:template><!--find de cond comercial prove-->

<xsl:template name="condComercialCliente">
     <!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/Empresas/LANG"><xsl:value-of select="/Empresas/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
        <!--idioma fin-->

        <!-- Pop-up para mostrar tabla resumen empresa -->
	<xsl:if test="/Empresas/EMPRESA/MVM or /Empresas/EMPRESA/MVMB">
	<div class="divLeft cond_comercial">
			<table class="grandeInicio">
			<thead>
				<tr class="subTituloTabla">
					<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='resumen']/node()"/></th>
				<xsl:for-each select="/Empresas/EMPRESA/RESUMENES_MENSUALES/CABECERA/COLUMNA">
					<th><xsl:value-of select="MES"/>/<xsl:value-of select="ANYO"/></th>
				</xsl:for-each>
				</tr>
			</thead>

			<tbody>
			<xsl:for-each select="/Empresas/EMPRESA/RESUMENES_MENSUALES/RESUMEN_MENSUAL">
				<tr>
					<td class="indicador textLeft"><xsl:value-of select="@Nombre"/></td>
				<xsl:for-each select="COLUMNA">
					<td><xsl:value-of select="VALOR"/></td>
				</xsl:for-each>
                                </tr>
			</xsl:for-each>
			</tbody>
			</table>
	</div>
	</xsl:if>

</xsl:template>

<!--PEDIDO MINIMO PARA PROVEE-->
    <xsl:template name="pedidoMinimo">
        <!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/Empresas/LANG"><xsl:value-of select="/Empresas/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

        <xsl:choose><!--si no hay pedidos minimos por centros enseï¿½o en 4 lineas el pedido minimo general, si no enseï¿½o todo como tabla-->
        <xsl:when test="(/Empresas/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA  or /Empresas/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_ACTIVO != '') and /Empresas/EMPRESA/ROL = 'VENDEDOR' and /Empresas/EMPRESA/CONDICIONES/PEDIDOMINIMO/CENTROS/CENTRO">

		<table class="infoTable cond_comercial cond_comercial_prov"  style="border-right:1px solid #666;border-left:1px solid #666;display:none;">
		<thead>
        	<tr class="subTituloTabla">
            	<td colspan="4"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/></td>
			</tr>
			<tr class="subTituloTablaNoB">
				<td align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/></td>
				<td>
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='importe']/node()"/>
				</td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/></td>
			</tr>
            </thead>

            <tbody>

		<xsl:for-each select="/Empresas/EMPRESA/CONDICIONES/PEDIDOMINIMO/CENTROS/CENTRO">
			<tr>
				<td class="textLeft"><xsl:value-of select="NOMBRE"/></td>
				<td>
				<xsl:choose>
				<xsl:when test="PMC_PEDMINIMO_ACTIVO='N'">
					<b><xsl:value-of select="document($doc)/translation/texts/item[@name='no_activo']/node()"/></b>
				</xsl:when>
				<xsl:when test="PMC_PEDMINIMO_ACTIVO='S'">
					<b><xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/></b>
				</xsl:when>
				<xsl:when test="PMC_PEDMINIMO_ACTIVO='E'">
					<b><xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/></b>
				</xsl:when>
				<xsl:when test="PMC_PEDMINIMO_ACTIVO='I'">
					<b><xsl:value-of select="document($doc)/translation/texts/item[@name='integrado']/node()"/></b>
				</xsl:when>
				</xsl:choose>
				</td>
				<td>
					<xsl:value-of select="PMC_PEDMINIMO_IMPORTE"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='s_iva']/node()"/>
				</td>
				<td>
					<xsl:copy-of select="PMC_PEDMINIMO_DETALLE"/>
				</td>
			</tr>
		</xsl:for-each>


			<tr style="border-bottom:1px solid #999999;">
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='resto_centros']/node()"/></td>
				<td>
				<xsl:choose>
				<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA">
					<xsl:choose>
					<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_ACTIVO='N'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='no_activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_ACTIVO='S'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_ACTIVO='E'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/></b>
					</xsl:when>
					<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_ACTIVO='I'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='integrado']/node()"/></b>
					</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL">
					<xsl:choose>
					<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_ACTIVO='N'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='no_activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_ACTIVO='S'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_ACTIVO='E'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/></b>
					</xsl:when>
					<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/EMP_PEDMINIMO_ACTIVO='I'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='integrado']/node()"/></b>
					</xsl:when>
					</xsl:choose>
				</xsl:when>
				</xsl:choose>
				</td>
				<td>
				<xsl:choose>
				<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA">
					<xsl:value-of select="/Empresas/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_IMPORTE"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='s_iva']/node()"/>
				</xsl:when>
				<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL">
					<xsl:value-of select="/Empresas/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_IMPORTE"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='s_iva']/node()"/>
				</xsl:when>
				</xsl:choose>
				</td>
				<td>
				<xsl:choose>
				<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA">
					<xsl:copy-of select="/Empresas/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_DETALLE"/>
				</xsl:when>
				<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL">
					<xsl:copy-of select="/Empresas/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_DETALLE"/>
				</xsl:when>
				</xsl:choose>
				</td>
			</tr>
		</tbody>
                <tr>
                    <td colspan="2">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2">&nbsp;</td>
                </tr>
		</table>
		</xsl:when>
        <xsl:otherwise>
        <table class="infoTable cond_comercial cond_comercial_prov"  style="border-right:1px solid #666;border-left:1px solid #666;display:none;">
            <thead>
                <tr class="subTituloTabla">
                    <td colspan="2"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/></td>
                </tr>
            </thead>
            <tbody>

           <tr>
				<td class="labelRight veinte">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='importe']/node()"/>:
				</td>
                <td class="datosLeft">
				<b>
                <xsl:choose>
				<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA">
					<xsl:value-of select="/Empresas/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_IMPORTE"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='s_iva']/node()"/>
				</xsl:when>
				<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL">
					<xsl:value-of select="/Empresas/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_IMPORTE"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='s_iva']/node()"/>
				</xsl:when>
				</xsl:choose>
                </b>
				</td>
            </tr>
            <tr>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/>:</td>
                <td class="datosLeft">
				<xsl:choose>
				<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA">
					<xsl:choose>
					<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_ACTIVO='N'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='no_activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_ACTIVO='S'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_ACTIVO='E'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/></b>
					</xsl:when>
					<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_ACTIVO='I'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='integrado']/node()"/></b>
					</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL">
					<xsl:choose>
					<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_ACTIVO='N'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='no_activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_ACTIVO='S'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='activo']/node()"/></b>
					</xsl:when>
					<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_ACTIVO='E'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='estricto']/node()"/></b>
					</xsl:when>
					<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/EMP_PEDMINIMO_ACTIVO='I'">
						<b><xsl:value-of select="document($doc)/translation/texts/item[@name='integrado']/node()"/></b>
					</xsl:when>
					</xsl:choose>
				</xsl:when>
				</xsl:choose>
				</td>
           </tr>
                <xsl:if test="/Empresas/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_DETALLE != '' or /Empresas/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_DETALLE != ''">
                        <tr>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</td>
                                <td class="datosLeft">
				<xsl:choose>
				<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA">
					<xsl:copy-of select="/Empresas/EMPRESA/CONDICIONES/PEDIDOMINIMO/EMPRESA/PME_PEDMINIMO_DETALLE"/>
				</xsl:when>
				<xsl:when test="/Empresas/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL">
					<xsl:copy-of select="/Empresas/EMPRESA/CONDICIONES/PEDIDO_MINIMO_GENERAL/EMP_PEDMINIMO_DETALLE"/>
				</xsl:when>
				</xsl:choose>
				</td>
			</tr>
                </xsl:if>
            </tbody>
            <tr>
                    <td colspan="2">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2">&nbsp;</td>
                </tr>
        </table>
        </xsl:otherwise>
        </xsl:choose>

    </xsl:template><!--fin de pedido minimo-->



</xsl:stylesheet>
