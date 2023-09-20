<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Ficha de centro
 	Ultima revision ET 8nov22 17:40
+-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/">
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

	<title><xsl:value-of select="Mantenimiento/form/CENTRO/CEN_NOMBRE"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='detalle_centro']/node()"/></title>

	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
	<META Http-Equiv="Cache-Control" Content="no-cache"/>
	<meta name="description" content="insert brief description here"/>
	<meta name="keywords" content="insert, keywords, here"/>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

<!--	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

	<link rel="stylesheet" type="text/css" href="http://www.newco.dev.br/General/TablaResumen-popup.css"/>
	<script type="text/javascript" src="http://www.newco.dev.br/General/TablaResumen-popup.js"></script>

        <!--codigo etiquetas-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/Tabla-popup.150715.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/etiquetas.js"></script>

	<link rel="stylesheet" href="http://www.newco.dev.br/General/lightbox.css" type="text/css" media="screen"/>
	<link href="http://www.newco.dev.br/General/Tabla-popup.150715.css" rel="stylesheet" type="text/css"/>
        <!--fin codigo etiquetas-->

        <script type="text/javascript">
       <!-- Variables y Strings JS para las etiquetas -->
		var lang = '<xsl:value-of select="/Mantenimiento/LANG"/>';
		var IDRegistro = '<xsl:value-of select="/Mantenimiento/form/CENTRO/CEN_ID"/>';
		var IDTipo = 'CEN';
		var str_NuevaEtiquetaGuardada	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta_guardada']/node()"/>';
		var str_NuevaEtiquetaError		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta_error']/node()"/>';
		var str_autor			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/>';
		var str_fecha			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>';
		var str_etiqueta	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='etiqueta']/node()"/>';
		var str_borrar		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>';
		<!-- FIN Variables y Strings JS para las etiquetas -->
        </script>

        <xsl:text disable-output-escaping="yes">
	<![CDATA[
	<script type="text/javascript">
	<!--
		//	13set16 Incluimos pestanna documentos
		function verPestana(valor){

			if(valor == 'DOCS'){
				location.href = "http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDocs.xsql?CEN_ID="+IDRegistro;
			}
		}

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
	//-->
	</script>
	]]></xsl:text>
</head>

<body onload="">
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
<xsl:when test="//xsql-error">
	<xsl:apply-templates select="//xsql-error"/>
</xsl:when>
<xsl:otherwise>

	<!--	9set16	Pestaña: ficha y documentos, visible para cualqueira con permiso para abrir esta ficha	- ->
	<div style="background:#fff;float:left;">
	<!- -	Pestaña FICHA para todos - ->
	<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?CEN_ID={/Mantenimiento/form/CENTRO/CEN_ID}&amp;ESTADO=CABECERA" style="text-decoration:none;">
	  <xsl:choose>
	  <xsl:when test="/Empresas/LANG = 'spanish'">
    	<img src="http://www.newco.dev.br/images/botonFicha1.gif" alt="FICHA" id="FICHA"/>
	  </xsl:when>
	  <xsl:otherwise>
    	<img src="http://www.newco.dev.br/images/botonFicha1.gif" alt="FICHA" id="FICHA"/>
	  </xsl:otherwise>
	  </xsl:choose>
	</a>&nbsp;
	<a href="javascript:verPestana('DOCS');" style="text-decoration:none;">
		<img src="http://www.newco.dev.br/images/botonDocumentos.gif" alt="DOCUMENTOS" id="DOCUMENTOS"/>
	</a>&nbsp;
	</div>
	-->
 	<div class="divLeft">
		<ul class="pestannas">
			<li>
				<a href="#" id="Ficha" class="MenuEmp" style="background:#3b569b;color:#D6D6D6"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ficha']/node()"/></a>
			</li>
			<li>
				<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDocs.xsql?CEN_ID={/Mantenimiento/form/CENTRO/CEN_ID}&amp;" id="Docs" class="MenuEmp"><xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/></a>
			</li>
		</ul>
	</div>
	<br/>
	<br/>
	<!--	FIN PESTAÑAS		-->
	

	<div class="divLeft"><!--	Sin esto, se montan a las pestañas	-->
	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>&nbsp;</span>
		<span class="CompletarTitulo">
			<xsl:if test="/Mantenimiento/form/CENTRO/MVM or /Mantenimiento/form/CENTRO/CENTRO/ADMIN"><span class="amarillo">CEN_ID:&nbsp;<xsl:value-of select="/Mantenimiento/form/CENTRO/CEN_ID"/></span></xsl:if>
		</span></p>
		<p class="TituloPagina">
			<xsl:value-of select="substring(Mantenimiento/form/CENTRO/CEN_NOMBRE,0,50)"/><!--&nbsp;(<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>)-->
			<span class="CompletarTitulo">
				<xsl:if test="/Mantenimiento/form/CENTRO/ADMIN">
					<xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
					<a class="btnNormal">
						<xsl:attribute name="href">http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENManten.xsql?ID=<xsl:value-of select="/Mantenimiento/form/CENTRO/CEN_ID"/></xsl:attribute>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='modificar']/node()"/>
					</a>
					&nbsp;
				</xsl:if>
				<xsl:if test="/Mantenimiento/form/CENTRO/MVM or /Mantenimiento/form/CENTRO/MVMB">
					<a class="btnNormal" href="javascript:window.print();" style="text-decoration:none;" title="Imprimir">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
					</a>
					&nbsp;
					<a class="btnNormal" href="javascript:showTablaResumenEmpresa(true);" style="text-decoration:none;">
						<img src="http://www.newco.dev.br/images/tabla.gif"/>&nbsp;
						<xsl:value-of select="document($doc)/translation/texts/item[@name='resumen']/node()"/>
					</a>
					&nbsp;
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>
	</div>

	
	
	
<!--
	<div class="divLeft">
	<h1 class="titlePage ficha" style="float:left;width:70%;padding-left:10%;"><!- -class="titlePage"- ->
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
		<xsl:value-of select="substring(Mantenimiento/form/CENTRO/CEN_NOMBRE,0,50)"/>&nbsp;(<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>)
		<xsl:if test="/Mantenimiento/form/CENTRO/MVM or /Mantenimiento/form/CENTRO/MVMB">
			<xsl:if test="/Mantenimiento/form/CENTRO/ADMIN">
				<xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
				<a style="text-decoration:none;">
					<!- -<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENManten.xsql?ID=<xsl:value-of select="/Mantenimiento/form/CENTRO/CEN_ID"/>','Mantenimiento Centro',100,80,0,0);</xsl:attribute>- ->
					<xsl:attribute name="href">http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENManten.xsql?ID=<xsl:value-of select="/Mantenimiento/form/CENTRO/CEN_ID"/></xsl:attribute>
						<img src="http://www.newco.dev.br/images/modificarBoli.gif" />&nbsp;
				</a>
			</xsl:if>
				<xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
				<a href="javascript:window.print();" style="text-decoration:none;">
					<img src="http://www.newco.dev.br/images/imprimir.gif"/>&nbsp;
				</a>
					<xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
					<a href="javascript:showTablaResumenEmpresa(true);" style="text-decoration:none;">
						<img src="http://www.newco.dev.br/images/tabla.gif"/>&nbsp;
					</a>
		</xsl:if>
	</h1>
	<h1 class="titlePage" style="float:left;width:20%">
		<xsl:if test="/Mantenimiento/form/CENTRO/MVM or /Mantenimiento/form/CENTRO/CDC"><span style="float:right; padding:5px;" class="amarillo">CEN_ID: <xsl:value-of select="/Mantenimiento/form/CENTRO/CEN_ID"/></span></xsl:if>
	</h1>
	</div>
-->

	<!-- Pop-up para mostrar tabla resumen empresa -->
	<xsl:if test="/Mantenimiento/form/CENTRO/MVM or /Mantenimiento/form/CENTRO/MVMB">
	<div class="overlay-container-2">
		<div class="window-container zoomout">
			<p><a href="javascript:showTablaResumenEmpresa(false);"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a></p>
			<table>
			<thead>
				<tr>
					<td>&nbsp;</td>
				<xsl:for-each select="/Mantenimiento/form/CENTRO/RESUMENES_MENSUALES/CABECERA/COLUMNA">
					<td><xsl:value-of select="MES"/>/<xsl:value-of select="ANYO"/></td>
				</xsl:for-each>
				</tr>
			</thead>

			<tbody>
			<xsl:for-each select="/Mantenimiento/form/CENTRO/RESUMENES_MENSUALES/RESUMEN_MENSUAL">
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

	<div class="divLeft">
		<xsl:apply-templates select="Mantenimiento/form"/>
	</div>

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
			<xsl:value-of select="substring(Mantenimiento/form/CENTRO/CEN_NOMBRE,0,50)"/>
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

</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>

<!--
 | Templates
+-->

<xsl:template match="form">
<form method="post">
	<xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>

	<xsl:apply-templates select="CENTRO"/>
</form>
</xsl:template>

<xsl:template match="CENTRO">
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!--<table class="mediaTabla">-->
	<table class="buscador">
	<xsl:apply-templates select="CEN_ID"/>
	<xsl:apply-templates select="EMP_ID"/>

<tbody>
	<tr class="sinLinea">
    	<td class="dies">&nbsp;</td>
		<td class="veinte label" rowspan="3">
			<img src="{/Mantenimiento/form/CENTRO/URL_LOGOTIPO}" height="80px" width="160px" style="padding-left:10px"/>
		</td>
		<td class="labelRight">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_corto']/node()"/>:&nbsp;
		</td>
		<td class="textLeft">
			<xsl:choose>
		    <xsl:when test="EIS_EMPRESA">
				<a href="http://www.newco.dev.br/Gestion/EIS/EISMatriz.xsql?IDCENTRO={CEN_ID}" title="Matriz EIS" target="_blank"><xsl:value-of select="CEN_NOMBRECORTO"/></a>
    		</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="CEN_NOMBRECORTO"/>
			</xsl:otherwise>
			</xsl:choose>
		</td>
	</tr>
    <tr class="sinLinea">
    	<td colspan="2">&nbsp;</td>
		<td class="labelRight quince">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='nif']/node()"/>:&nbsp;
		</td>
		<td class="textLeft">
        	<xsl:value-of select="/Mantenimiento/form/CENTRO/CEN_NIF" />
		</td>
	</tr>
	<!--direccion-->
	<tr class="sinLinea">
    	<td>&nbsp;</td>
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='direccion']/node()"/>:&nbsp;</td>
		<td class="textLeft">
			<p><xsl:apply-templates select="CEN_DIRECCION"/>&nbsp;-&nbsp;
				<xsl:apply-templates select="CEN_CPOSTAL"/>&nbsp;-&nbsp;
				<xsl:apply-templates select="CEN_POBLACION"/>&nbsp;-&nbsp;
				<xsl:value-of select="CEN_PROVINCIA"/>
				<xsl:for-each select="//field[@name='CEN_PROVINCIA']">
					<xsl:value-of select="dropdownList/listElem/ID"/>
					<xsl:value-of select="dropdownList/listElem/listItem"/>
				</xsl:for-each>
			</p>
		</td>
    </tr>
    <tr class="sinLinea">
    	<td colspan="2">&nbsp;</td>
		<td class="labelRight">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='telefono']/node()"/>:&nbsp;</td>
        <td class="textLeft"><xsl:value-of select="/Mantenimiento/form/CENTRO/CEN_TELEFONO" /></td>
    </tr>
    <tr class="sinLinea">
    	<td colspan="2">&nbsp;</td>
		<td class="labelRight">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='Email_publico']/node()"/>:&nbsp;</td>
        <td class="textLeft"><xsl:value-of select="/Mantenimiento/form/CENTRO/CEN_EMAILPUBLICO" /></td>
    </tr>
    <xsl:if test="/Mantenimiento/form/CENTRO/CEN_FAX != ''">
    <tr class="sinLinea">
    	<td colspan="2">&nbsp;</td>
    	<td class="labelRight">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='fax']/node()"/>:
		</td>
		<td class="textLeft">
			<xsl:value-of select="/Mantenimiento/form/CENTRO/CEN_FAX" />
		</td>
	</tr>
	</xsl:if>

	<xsl:if test="/Mantenimiento/form/CENTRO/ROL = 'COMPRADOR'">
	<tr class="sinLinea">
    	<td colspan="2">&nbsp;</td>
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='numero_de_camas']/node()"/>:&nbsp;</td>
		<td class="textLeft"><xsl:value-of select="CEN_CAMAS"/><xsl:if test="CEN_CAMAS = ''">-</xsl:if></td>
    </tr>
    <tr class="sinLinea">
    	<td colspan="2">&nbsp;</td>
		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='quirofanos']/node()"/>:&nbsp;</td>
		<td class="textLeft"><xsl:value-of select="CEN_QUIROFANOS"/><xsl:if test="CEN_QUIROFANOS = ''">-</xsl:if></td>
	</tr>
	</xsl:if>

        <!--descripcion centro-->
	<tr class="sinLinea">
    	<td colspan="2">&nbsp;</td>
		<td class="labelRight" valign="top"> <xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:&nbsp;</td>
		<td class="textLeft">
            <xsl:copy-of select="CEN_DESCRIPCIONCOMERCIAL/node()" disable-output-escaping="yes"/>
		</td>
        </tr>
	<!--empresa-->
	<tr class="sinLinea">
    	<td colspan="2">&nbsp;</td>
		<td class="labelRight"> <xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:&nbsp;</td>
		<td class="textLeft">
				<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={//CENTRO/EMP_ID}&amp;VENTANA=NUEVA','DetalleEmpresa',100,80,0,0)">
					<xsl:value-of select="EMP_NOMBRE"/>
				</a>
		</td>
    </tr>
    <tr class="sinLinea">
    	<td colspan="2">&nbsp;</td>
		<td class="labelRight">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='nif']/node()"/>:&nbsp;
		</td>
		<td class="textLeft">
			<xsl:value-of select="EMP_NIF"/>
		</td>
	</tr>

</tbody>
</table>

<br/><br/>
		<p>&nbsp;&nbsp;&nbsp;<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='usuarios']/node()"/></strong></p>

		<!--usuarios-->
		<!--<table class="mediaTabla ficha">-->
		<table class="buscador ficha">
			<!--<tr>
				<td>&nbsp;</td>
				<td colspan="4">&nbsp;</td>
				<td>&nbsp;</td>
			</tr>-->

			<!--<tr class="tituloGrisScuro">-->
			<!--<tr class="subTituloTabla">
			<tr>
				<td>&nbsp;</td>
				<td colspan="5" align="left">
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='usuarios']/node()"/></strong>
				</td>
				<td>&nbsp;</td>
			</tr>-->

			<!--nombres columnas, nombre, cargo-->
			<!--<tr class="bold">-->
			<tr class="subTituloTabla">
				<td>&nbsp;</td>
				<td class="textLeft">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>
				</td>
				<td class="textLeft">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='cargo']/node()"/>
				</td>
				<xsl:if test="/Mantenimiento/form/CENTRO/USUARIOS/MOSTRAR_GESTOR">
					<td class="textLeft">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='gestor_licitaciones']/node()"/>
					</td>
				</xsl:if>
				<xsl:if test="/Mantenimiento/form/CENTRO/USUARIOS/MOSTRAR_EMAIL">
					<td class="textLeft">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='email']/node()"/>
					</td>
				</xsl:if>
                <td class="textLeft">
                	<xsl:if test="(/Mantenimiento/form/CENTRO/MVM or /Mantenimiento/form/CENTRO/MVMB) and /Mantenimiento/form/CENTRO/ADMIN">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='funcion']/node()"/>
                	</xsl:if>
				</td>
				<td>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='telefono']/node()"/>
				</td>
				<td>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Skype']/node()"/>
				</td>
				<td>&nbsp;</td>
			</tr>
		
		<tbody>
			<xsl:for-each select="USUARIOS/USUARIO">
				<xsl:choose>
					<xsl:when test="ID=../../../IDVENDEDOR">
						<tr>
							<td>&nbsp;</td>
							<td class="textLeft">
								<a href="javascript:verVacacionesComercial('{../../../IDVENDEDOR}');">
									<xsl:value-of select="NOMBRE"/>
								</a>
							</td>
								<td>
									<xsl:value-of select="TIPO_USUARIO"/>
								</td>
								<xsl:if test="/Mantenimiento/form/CENTRO/USUARIOS/MOSTRAR_EMAIL">
									<td class="textLeft">
										<xsl:value-of select="US_EMAIL"/>
									</td>
								</xsl:if>
                            	<td><!--funcion de usuario si vendedor no enseño--></td>
								<td>
									<xsl:value-of select="TELEFONO"/>
								</td>
								<td>
									<xsl:value-of select="SKYPE"/>
								</td>
							<td>&nbsp;</td>
						</tr>
					</xsl:when>
					<xsl:otherwise>
						<tr>
							<td>&nbsp;</td>
							<td class="textLeft">
                                <xsl:choose>
                                <xsl:when test="(/Mantenimiento/form/CENTRO/MVM or /Mantenimiento/form/CENTRO/MVMB) and /Mantenimiento/form/CENTRO/ADMIN">
                                    <a title="Manten Usuario">
                                    <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/USManten.xsql?ID_USUARIO=<xsl:value-of select="ID"/>&amp;EMP_ID=<xsl:value-of select="/Empresas/EMPRESA/EMP_ID"/>','Mantenimiento Usuario',100,80,0,0);</xsl:attribute>
                                       <xsl:value-of select="NOMBRE"/></a>
                                </xsl:when>
                                <xsl:otherwise><xsl:value-of select="NOMBRE"/></xsl:otherwise>
                                </xsl:choose>
                                &nbsp;
								<!-- Si no hya gestor, mostramos email	-->
								<xsl:if test="not(GESTOR)">
                                <a>
                                <xsl:attribute name="href">mailto:<xsl:value-of select="US_EMAIL"/></xsl:attribute>
                                <img src="http://www.newco.dev.br/images/mail.gif"/>
                                </a>
								</xsl:if>
							</td>
							<td class="textLeft">
								<xsl:value-of select="TIPO_USUARIO"/>
							</td>
							<xsl:if test="GESTOR">
								<td class="textLeft">
									<strong><xsl:value-of select="GESTOR/NOMBRE"/>&nbsp;(<xsl:value-of select="GESTOR/CENTRO"/>)</strong>
								</td>
							</xsl:if>
							<xsl:if test="/Mantenimiento/form/CENTRO/USUARIOS/MOSTRAR_EMAIL">
								<td class="textLeft">
									<xsl:choose>
									<xsl:when test="GESTOR">
										<xsl:value-of select="GESTOR/US_EMAIL"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="US_EMAIL"/>
									</xsl:otherwise>
									</xsl:choose>
								</td>
							</xsl:if>
                            <td class="textLeft">
                                <xsl:if test="(/Mantenimiento/form/CENTRO/MVM or /Mantenimiento/form/CENTRO/MVMB) and /Mantenimiento/form/CENTRO/ADMIN">
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
								<xsl:choose>
								<xsl:when test="GESTOR">
									<xsl:value-of select="GESTOR/TELEFONO"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="TELEFONO"/>
								</xsl:otherwise>
								</xsl:choose>
							</td>
							<td>
								<xsl:choose>
								<xsl:when test="GESTOR">
									<xsl:value-of select="GESTOR/SKYPE"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="SKYPE"/>
								</xsl:otherwise>
								</xsl:choose>
							</td>
							<td>&nbsp;</td>
						</tr>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		<tr class="sinLinea"><td colspan="6">&nbsp;</td></tr>
		</tbody>
		</table>

		<!--selecciones-->
		<xsl:if test="/Mantenimiento/form/CENTRO/SELECCIONES/SELECCION">
		<!--<table class="mediaTabla ficha">-->
		<table class="buscador ficha">
			<tr><td colspan="5">&nbsp;</td></tr>

			<!--tr class="tituloGrisScuro">-->
			<tr class="subTituloTabla">
				<td>&nbsp;</td>
				<td colspan="3" align="left">
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciones']/node()"/></strong>
					&nbsp;<a href="javascript:MostrarSelecciones();" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/tabla.gif"/></a>
				</td>
				<td>&nbsp;</td>
			</tr>

			<!--nombres columnas, nombre, cargo-->
			<!--<tr class="bold">-->
			<tr class="subTituloTabla">
				<td class="uno">&nbsp;</td>
				<td class="trenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></td>
				<td class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></td>
				<td class="dies">&nbsp;</td>
				<td>&nbsp;</td>
			</tr>

		<tbody>
		<xsl:for-each select="/Mantenimiento/form/CENTRO/SELECCIONES/SELECCION">
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

</xsl:template>

<xsl:template match="Sorry">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="CEN_ID">
	<input type="hidden" name="CEN_ID" size="59" maxlength="70">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="EMP_ID">
	<input type="hidden" name="EMP_ID" maxlength="70">
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	</input>
</xsl:template>

<xsl:template match="CEN_NOMBRE">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="CEN_DIRECCION">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="CEN_CPOSTAL">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="CEN_NIF">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="CEN_POBLACION">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="CEN_PROVINCIA">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="CEN_TELEFONO">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="CEN_FAX">
	<xsl:value-of select="."/>
</xsl:template>
</xsl:stylesheet>
