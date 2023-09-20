<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 |   Mostrar ficha de la empresa.
 |
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:template match="/Ficha">

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

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<meta http-equiv="Cache-Control" Content="no-cache"/>

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

  <!--codigo etiquetas-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/Tabla-popup.150715.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/etiquetas.js"></script>

	<link href="http://www.newco.dev.br/General/Tabla-popup.150715.css" rel="stylesheet" type="text/css"/>
  <!--fin codigo etiquetas-->

  <script type="text/javascript">
    <!-- Variables y Strings JS para las etiquetas -->
		var IDRegistro = '<xsl:value-of select="EMPRESA/EMP_ID"/>';
		var IDTipo = 'EMP';
		var str_NuevaEtiquetaGuardada	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta_guardada']/node()"/>';
		var str_NuevaEtiquetaError		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta_error']/node()"/>';
		var str_autor			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/>';
		var str_fecha			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>';
		var str_etiqueta	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='etiqueta']/node()"/>';
		var str_borrar		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>';
		<!-- FIN Variables y Strings JS para las etiquetas -->

		var str_incluir		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='incluir']/node()"/>';
		var str_quitar		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='quitar']/node()"/>';
		var str_errorCambiarSeleccion = '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_cambiar_seleccion']/node()"/>';

		<xsl:text disable-output-escaping="yes">
		<![CDATA[

		function cambiarSeleccion(IDSel, flag){
			var d = new Date();

			jQuery.ajax({
				url:"http://www.newco.dev.br/Gestion/EIS/cambiarSeleccionAJAX.xsql",
				data: "IDSELECCION="+IDSel+"&IDREGISTRO="+IDRegistro+"&_="+d.getTime(),
				type: "GET",
				async: false,
				contentType: "application/xhtml+xml",
				beforeSend:function(){
					null;
				},
				error:function(objeto, quepaso, otroobj){
					alert("objeto:"+objeto);
					alert("otroobj:"+otroobj);
					alert("quepaso:"+quepaso);
				},
				success:function(objeto){
					var data = eval("(" + objeto + ")");

					if(data.Seleccion.estado == 'OK'){
						if(flag){
							jQuery("#SEL_" + IDSel + " td.estadoSel").html("<img src='http://www.newco.dev.br/images/checkCenter.gif'/>");
							jQuery("#SEL_" + IDSel + " td.accionSel").html("<a href='javascript:cambiarSeleccion(" + IDSel + ", false);'>" + str_quitar + "</a>");
						}else{
							jQuery("#SEL_" + IDSel + " td.estadoSel").html("<img src='http://www.newco.dev.br/images/nocheck.gif'/>");
							jQuery("#SEL_" + IDSel + " td.accionSel").html("<a href='javascript:cambiarSeleccion(" + IDSel + ", true);'>" + str_incluir + "</a>");
						}
					}else{
						alert(str_errorCambiarSeleccion);
					}
				}
			});
		}

		//	Presenta la pagina con las selecciones
		function MostrarSelecciones(){
			var Enlace	= 'http://www.newco.dev.br/Gestion/EIS/EISSelecciones.xsql';

			MostrarPagPersonalizada(Enlace, '_blank', 100, 80, 0, 10);
		}

		]]>
		</xsl:text>
  </script>
</head>

<body>
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
	<xsl:otherwise>
		<xsl:apply-templates select="EMPRESA"/>
	</xsl:otherwise>
	</xsl:choose>
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
		<xsl:when test="/Ficha/LANG"><xsl:value-of select="/Ficha/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

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

	<!-- ET Cambiar formato titulo		<xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>< ! - -&nbsp;<xsl:value-of select="EMP_TIPO"/>-->
      &nbsp;
        <xsl:choose>
        <xsl:when test="EMP_NOMBRE_CORTO != ''"><xsl:value-of select="EMP_NOMBRE_CORTO" disable-output-escaping="yes"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="substring(EMP_NOMBRE,0,50)" disable-output-escaping="yes"/></xsl:otherwise>
        </xsl:choose>
      &nbsp;

			<xsl:if test="MVM or MVMB or ADMIN">
				<xsl:text>&nbsp;&nbsp;</xsl:text>
				<a style="text-decoration:none;">
					<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPManten.xsql?ID=<xsl:value-of select="EMP_ID"/>&amp;ADMINISTRADORMVM=ADMINISTRADORMVM','Mantenimiento empresa',100,80,0,0);</xsl:attribute>
					<img src="http://www.newco.dev.br/images/modificarBoli.gif" title="Modificar empresa"/>
				</a>
				<xsl:text>&nbsp;&nbsp;</xsl:text>
				<a href="javascript:window.print();" style="text-decoration:none;" title="Imprimir">
					<img src="http://www.newco.dev.br/images/imprimir.gif"/>
				</a>
			</xsl:if>
    </h1>

    <h1 class="titlePage ficha" style="float:left;width:20%;">
      <xsl:if test="MVM or MVMB or ADMIN"><span style="float:right; padding:5px;" class="amarillo">EMP_ID: <xsl:value-of select="EMP_ID"/></span></xsl:if>
		</h1>

		<table class="mediaTabla ficha">
		<tbody>
			<tr>
				<td class="veinte label" rowspan="4">
					<img src="http://www.newco.dev.br/Documentos/{URL_LOGOTIPO}" height="80px" width="160px" style="padding-left:10px"/>
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
				<td>
					<xsl:value-of select="EMP_TELEFONO"/>
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
          <xsl:if test="(MVM or MVMB or ADMIN) and ROL ='COMPRADOR'">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_corto']/node()"/>:
          </xsl:if>
          <xsl:if test="ES_EMPRESA_ESPECIAL"><br />
            <xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eis']/node()"/>:
          </xsl:if>
				</td>
				<td>
          <xsl:if test="(MVM or MVMB or ADMIN) and ROL ='COMPRADOR'">
            <xsl:value-of select="EMP_NOMBRE_CORTO"/>
          </xsl:if>
          <xsl:if test="ES_EMPRESA_ESPECIAL"><br />
            <a href="http://www.newco.dev.br/Gestion/EIS/EISMatriz.xsql" title="Matriz EIS" target="_blank">
              <xsl:value-of select="EMP_NOMBRECORTOPUBLICO"/>
            </a>
          </xsl:if>
        </td>
				<td>&nbsp;</td>
			</tr>

		<xsl:if test="EMP_REFERENCIAS != ''">
      <tr>
        <td class="label" valign="top">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_comercial_corta']/node()"/>:
				</td>
        <td colspan="3">
          <xsl:copy-of select="EMP_REFERENCIAS/node()"/>
        </td>
        <td>&nbsp;</td>
      </tr>
		</xsl:if>
		</tbody>
		</table>

    <!--selecciones-->
	<xsl:if test="SELECCIONES/SELECCION">
		<table class="mediaTabla ficha">
			<tr><td colspan="5">&nbsp;</td></tr>

			<tr class="tituloGrisScuro">
				<td>&nbsp;</td>
				<td colspan="3" align="left">
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciones']/node()"/></strong>
					&nbsp;<a href="javascript:MostrarSelecciones();" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/tabla.gif"/></a>
				</td>
				<td>&nbsp;</td>
			</tr>

			<!--nombres columnas, nombre, cargo-->
			<tr class="bold">
				<td class="uno">&nbsp;</td>
				<td class="trenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></td>
				<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></td>
				<td class="dies">&nbsp;</td>
				<td>&nbsp;</td>
			</tr>

		<tbody>
		<xsl:for-each select="SELECCIONES/SELECCION">
			<tr id="SEL_{EIS_SEL_ID}">
				<td>&nbsp;</td>
				<td><xsl:value-of select="EIS_SEL_NOMBRE"/></td>
				<td class="estadoSel" style="padding-left:5px;">
					<xsl:choose>
					<xsl:when test="NO_INCLUIDO">
						<img src="http://www.newco.dev.br/images/nocheck.gif"/>
					</xsl:when>
					<xsl:otherwise>
						<img src="http://www.newco.dev.br/images/checkCenter.gif"/>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td class="accionSel">
					<xsl:choose>
					<xsl:when test="NO_INCLUIDO">
						<a href="javascript:cambiarSeleccion({EIS_SEL_ID}, true);"><xsl:value-of select="document($doc)/translation/texts/item[@name='incluir']/node()"/></a>
					</xsl:when>
					<xsl:otherwise>
						<a href="javascript:cambiarSeleccion({EIS_SEL_ID}, false);"><xsl:value-of select="document($doc)/translation/texts/item[@name='quitar']/node()"/></a>
					</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>&nbsp;</td>
			</tr>
		</xsl:for-each>
		</tbody>

		</table>
		</xsl:if>
	</div><!--fin de divCenter50-->
                       
	<!--centros-->
		<table class="mediaTabla ficha">
		<tbody>
			<tr>
				<td>&nbsp;</td>
				<td>
					<xsl:attribute name="colspan">
						<xsl:choose>
						<xsl:when test="ROL = 'COMPRADOR'">5</xsl:when>
						<xsl:otherwise>3</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					&nbsp;
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="tituloGrisScuro">
				<td class="uno">&nbsp;</td>
				<td align="left">
					<xsl:attribute name="colspan">
						<xsl:choose>
						<xsl:when test="ROL = 'COMPRADOR'">5</xsl:when>
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
				<xsl:if test="ROL = 'COMPRADOR'">
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
				<xsl:if test="/Ficha/EMPRESA/ROL = 'COMPRADOR'">
					<td style="padding-left:30px;"><xsl:value-of select="CAMAS"/><xsl:if test="CAMAS = ''">-</xsl:if></td>
					<td style="padding-left:30px;"><xsl:value-of select="QUIROFANOS"/><xsl:if test="QUIROFANOS = ''">-</xsl:if></td>
				</xsl:if>
				<td>&nbsp;</td>
			</tr>
			</xsl:for-each>
		</tbody>
		</table>

		<!--usuarios-->
		<table class="mediaTabla ficha">
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
				<td class="uno">&nbsp;</td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='cargo']/node()"/></td>
        <td><xsl:value-of select="document($doc)/translation/texts/item[@name='funcion']/node()"/></td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='telefono']/node()"/></td>
				<td>&nbsp;</td>
			</tr>

		<tbody>
		<xsl:for-each select="USUARIOS/USUARIO">
			<tr>
				<td>&nbsp;</td>
				<td>
          <xsl:choose>
          <xsl:when test="(/Ficha/EMPRESA/MVM or /Ficha/EMPRESA/MVMB) and /Ficha/EMPRESA/ADMIN">
            <a title="Manten Usuario">
              <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/USManten.xsql?ID_USUARIO=<xsl:value-of select="ID"/>&amp;EMP_ID=<xsl:value-of select="/Ficha/EMPRESA/EMP_ID"/>','Mantenimiento Usuario',100,80,0,0);</xsl:attribute>
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
          <xsl:if test="(/Ficha/EMPRESA/MVM or /Ficha/EMPRESA/MVMB) and /Ficha/EMPRESA/ADMIN">
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
		</xsl:for-each>
		</tbody>

			<tr><td colspan="6">&nbsp;</td></tr>
		</table>

		

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
</xsl:stylesheet>
