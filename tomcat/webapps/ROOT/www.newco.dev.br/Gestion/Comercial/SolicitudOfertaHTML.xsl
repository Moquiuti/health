<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<!--
	Ultima revisión:ET 28jun17
-->

<xsl:template match="/SolicitudOferta">
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

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_oferta']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<!--codigo etiquetas-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/Tabla-popup.150715.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/etiquetas.js"></script>

	<link rel="stylesheet" href="http://www.newco.dev.br/General/lightbox.css" type="text/css" media="screen"/>
	<link href="http://www.newco.dev.br/General/Tabla-popup.150715.css" rel="stylesheet" type="text/css"/>
	<!--fin codigo etiquetas-->

	<script type="text/javascript">
	var lang = '<xsl:value-of select="LANG"/>';

	var producto_obligatorio	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_producto_solicitud_oferta']/node()"/>';
	var precio_mal_formato = '<xsl:value-of select="document($doc)/translation/texts/item[@name='mal_formato_precio_solicitud_oferta']/node()"/>';
	var cantidad_mal_formato = '<xsl:value-of select="document($doc)/translation/texts/item[@name='mal_formato_cantidad_solicitud_oferta']/node()"/>';
	var diagnostico_obligatorio	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_diagnostico_solicitud_oferta']/node()"/>';
	var oferta_obligatoria	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_oferta_solicitud_oferta']/node()"/>';
	var ref_guardada_con_exito	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_guardada_con_exito']/node()"/>';
	var filas_productos_obligatorio = '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_filas_productos_solicitud_oferta']/node()"/>';
	var err_subir_productos = '<xsl:value-of select="document($doc)/translation/texts/item[@name='err_subir_productos_solicitud_oferta']/node()"/>';

	<!-- Variables y Strings JS para las etiquetas -->
	var IDRegistro	= '<xsl:value-of select="SOLICITUD/SO_ID"/>';
	var IDIdioma		= '<xsl:value-of select="SOLICITUD/IDIDIOMA"/>';
	var IDTipo = 'SOLCAT';
	var str_NuevaEtiquetaGuardada	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta_guardada']/node()"/>';
	var str_NuevaEtiquetaError		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta_error']/node()"/>';
	var str_autor			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/>';
	var str_fecha			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>';
	var str_etiqueta	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='etiqueta']/node()"/>';
	var str_borrar		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>';
	var str_sinProductos = '<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_productos_sol_cat']/node()"/>';
	<!-- FIN Variables y Strings JS para las etiquetas -->
	</script>

	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/SolicitudOferta_13jul17.js"></script>
</head>
<!--<body class="gris" onload="RecuperaBienText();">-->
<body onload="RecuperaBienText();">
<xsl:choose>
<xsl:when test="SESION_CADUCADA">
	<xsl:for-each select="SESION_CADUCADA">
		<xsl:if test="position()=last()">
			<xsl:apply-templates select="."/>
		</xsl:if>
	</xsl:for-each>
</xsl:when>
<xsl:when test="//xsql-error">
	<xsl:apply-templates select="//xsql-error"/>
</xsl:when>
<xsl:otherwise>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="divLeft">
	<xsl:choose>
	<xsl:when test="ERROR">
		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='error_solicitud_oferta']/node()"/></h1>
	</xsl:when>
	<xsl:otherwise>

		<xsl:variable name="usuario">
		<xsl:choose>
			<xsl:when test="not(SOLICITUD/OBSERVADOR) and SOLICITUD/CDC and SOLICITUD/IDEMPRESAUSUARIO = SOLICITUD/SO_IDCLIENTE">CDC</xsl:when>
			<xsl:otherwise>NORMAL</xsl:otherwise>
		</xsl:choose>
		</xsl:variable>
                <xsl:variable name="adminCliente">
		<xsl:choose>
			<xsl:when test="SOLICITUD/ADMIN">ADMIN</xsl:when>
			<xsl:otherwise>NOADMIN</xsl:otherwise>
		</xsl:choose>
		</xsl:variable>
                <xsl:variable name="usuarioMVM">
		<xsl:choose>
			<xsl:when test="SOLICITUD/MVM">MVM</xsl:when>
			<xsl:otherwise>NOMVM</xsl:otherwise>
		</xsl:choose>
		</xsl:variable>

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_oferta']/node()"/></span></p>
			<p class="TituloPagina">
				<xsl:value-of select="SOLICITUD/SO_CODIGO"/>&nbsp;
				<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_oferta']/node()"/>:&nbsp;
				<xsl:value-of select="SOLICITUD/SO_TITULO"/>
				<span class="CompletarTitulo">


					<xsl:if test="SOLICITUD/AUTOR or $usuario = 'CDC' or $usuarioMVM = 'MVM' or $adminCliente = 'ADMIN'">
       					<xsl:if test="SOLICITUD/SO_IDESTADO = 'P'">
							<a class="btnDestacado" href="javascript:cambiarEstado('N');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/>
							</a>
							&nbsp;
						</xsl:if>
					</xsl:if>

					<xsl:if test="SOLICITUD/EDITAROFERTA">
						<xsl:if test="SOLICITUD/SO_IDESTADO = 'N' or SOLICITUD/SO_IDESTADO = 'D' or SOLICITUD/SO_IDESTADO = 'S'">
							<a class="btnDestacado" id="BotonDIAG" href="javascript:ValidarFormulario(document.forms['SolicitudCatalogacion'],'D');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='diagnostico']/node()"/>
							</a>
						</xsl:if>

						<xsl:if test="SOLICITUD/SO_IDESTADO = 'N' or SOLICITUD/SO_IDESTADO = 'D' or SOLICITUD/SO_IDESTADO = 'S'">
							<a class="btnDestacado" id="BotonSOL" href="javascript:ValidarFormulario(document.forms['SolicitudCatalogacion'],'S');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='oferta']/node()"/>
							</a>
						</xsl:if>
					</xsl:if>

					<xsl:if test="SOLICITUD/CERRAROFERTA">
						<xsl:if test="SOLICITUD/SO_IDESTADO != 'P' and SOLICITUD/SO_IDESTADO != 'R'">
							<a class="btnDestacado" id="BotonRES" href="javascript:ValidarFormulario(document.forms['SolicitudCatalogacion'],'R');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='resuelta']/node()"/>
							</a>
						</xsl:if>
					</xsl:if>
				</span>
			</p>
		</div>
		<br/>


		<!--
		<h1 class="titlePage" style="float:left;width:70%;padding-left:10%;padding-bottom:5px;">
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

		<xsl:value-of select="SOLICITUD/SO_CODIGO"/>&nbsp;
		<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_oferta']/node()"/>:&nbsp;
		<xsl:value-of select="SOLICITUD/SO_TITULO"/>
		</h1>
		<h1 class="titlePage" style="float:left;width:20%;padding-bottom:5px;">
		<xsl:if test="/SolicitudCatalogacion/SOLICITUD/MVMB or /SolicitudCatalogacion/SOLICITUD/MVM or /SolicitudCatalogacion/SOLICITUD/ADMIN"><span style="float:right; padding:5px; font-weight:bold;" class="amarillo">SOL_ID: <xsl:value-of select="/SolicitudCatalogacion/SOLICITUD/SO_ID"/></span></xsl:if>
		</h1>
		-->

		<form class="formEstandar" name="SolicitudCatalogacion" id="SolicitudCatalogacion" method="post">
			<input type="hidden" name="SO_ID" id="SO_ID" value="{SOLICITUD/SO_ID}"/>
			<input type="hidden" name="TIPO_DOC_DB" id="TIPO_DOC_DB"/>
			<input type="hidden" name="TIPO_DOC_HTML" id="TIPO_DOC_HTML"/>
			<input type="hidden" name="CADENA_DOCUMENTOS"/>
			<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
			<input type="hidden" name="BORRAR_ANTERIORES"/>
			<input type="hidden" name="SO_IDESTADO" id="SO_IDESTADO"/>
			<input type="hidden" name="SO_IDDOCSOLICITUD" id="DOC_SOLCAT" value="{SOLICITUD/DOCUMENTO_SOLICITUD/ID}"/>
			<input type="hidden" name="SO_IDDOCDIAGNOSTICO" id="DOC_DIAG" value="{SOLICITUD/DOCUMENTO_DIAGNOSTICO/ID}"/>
			<input type="hidden" name="SO_IDDOCOFERTA" id="DOC_SOL" value="{SOLICITUD/DOCUMENTO_OFERTA/ID}"/>
			<input type="hidden" name="IDPRODESTANDAR" id="IDPRODESTANDAR"/>
			<input type="hidden" name="ID_USUARIO" value="{SOLICITUD/IDUSUARIO}"/>
			<input type="hidden" name="IDEMPRESA" id="IDEMPRESA" value="{SOLICITUD/IDEMPRESAUSUARIO}"/>
		
		<!--	Nuevo formulario	-->
    	<div>
        	<ul style="width:1000px;">
            	<li>
                <xsl:choose>
                    <xsl:when test="LANG = 'spanish'">
                        <xsl:choose>
                        <xsl:when test="SOLICITUD/SO_IDESTADO = 'P'">
                          <img src="http://www.newco.dev.br/images/step2sol.gif" alt="Paso 2 - Añadir productos" />
                        </xsl:when>
                        <xsl:when test="SOLICITUD/SO_IDESTADO = 'N'">
                          <img src="http://www.newco.dev.br/images/step3sol.gif" alt="Paso 3 - Diagnóstico" />
                        </xsl:when>
                        <xsl:when test="SOLICITUD/SO_IDESTADO = 'D'">
                          <img src="http://www.newco.dev.br/images/step4sol.gif" alt="Paso 4 - Propuesta de solución" />
                        </xsl:when>
                        <xsl:when test="SOLICITUD/SO_IDESTADO = 'S'">
                          <img src="http://www.newco.dev.br/images/step5sol.gif" alt="Paso 5 - Solución" />
                        </xsl:when>
                        <xsl:when test="SOLICITUD/SO_IDESTADO = 'R'">
                          <img src="http://www.newco.dev.br/images/step6sol.gif" alt="Paso 6 - Resuelta" />
                        </xsl:when>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                        <xsl:when test="SOLICITUD/SO_IDESTADO = 'P'">
                          <img src="http://www.newco.dev.br/images/step2sol-BR.gif" alt="Paso 2 - Adicionar produtos" />
                        </xsl:when>
                        <xsl:when test="SOLICITUD/SO_IDESTADO = 'N'">
                          <img src="http://www.newco.dev.br/images/step3sol-BR.gif" alt="Paso 3 - Diagnóstico" />
                        </xsl:when>
                        <xsl:when test="SOLICITUD/SO_IDESTADO = 'D'">
                          <img src="http://www.newco.dev.br/images/step4sol-BR.gif" alt="Paso 4 - Solução proposta" />
                        </xsl:when>
                        <xsl:when test="SOLICITUD/SO_IDESTADO = 'S'">
                          <img src="http://www.newco.dev.br/images/step5sol-BR.gif" alt="Paso 5 - Catalogação" />
                        </xsl:when>
                        <xsl:when test="SOLICITUD/SO_IDESTADO = 'R'">
                          <img src="http://www.newco.dev.br/images/step6sol-BR.gif" alt="Paso 6 - Terminado" />
                        </xsl:when>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
             	</li>
				<li>
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='datos_generales']/node()"/></strong>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/>:</label>
					<strong><xsl:copy-of select="SOLICITUD/CLIENTE" disable-output-escaping="yes"/></strong>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label>
					<strong><xsl:copy-of select="SOLICITUD/PROVEEDOR" disable-output-escaping="yes"/></strong>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>:</label>
					<input type="text" name="SO_TITULO" id="SO_TITULO" maxlength="200" size="62" value="{SOLICITUD/SO_TITULO}"/>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</label>
					<input type="hidden" name="SO_DESCRIPCION" id="SO_DESCRIPCION" value="{SOLICITUD/SO_DESCRIPCION}"/>
					<xsl:copy-of select="SOLICITUD/SO_DESCRIPCION/node()" disable-output-escaping="yes"/>&nbsp;
				</li>
				<xsl:if test="not(SOLICITUD/PRODUCTOS/PRODUCTO)">
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='infoprecio']/node()"/>:</label>
					<input type="hidden" name="SO_INFOPRECIO" id="SO_INFOPRECIO" value="{SOLICITUD/SO_INFOPRECIO}"/>
					<xsl:copy-of select="SOLICITUD/SO_INFOPRECIO/node()" disable-output-escaping="yes"/>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/>:</label>
					<input type="hidden" name="SO_CONSUMO" id="SO_CONSUMO" value="{SOLICITUD/SO_CONSUMO}"/>
					<xsl:copy-of select="SOLICITUD/SO_CONSUMO/node()" disable-output-escaping="yes"/>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label>
					<input type="hidden" name="SO_PROVEEDOR" id="SO_PROVEEDOR" value="{SOLICITUD/SO_PROVEEDOR}"/>
					<xsl:copy-of select="SOLICITUD/SO_PROVEEDOR/node()" disable-output-escaping="yes"/>
				</li>
				</xsl:if>
          		<xsl:if test="SOLICITUD/DOCUMENTO_rMulti/ID">
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='DOCUMENTO_SOLICITUD']/node()"/>:</label>
					<a href="http://www.newco.dev.br/Documentos/{SOLICITUD/DOCUMENTO_SOLICITUD/URL}" target="_blank">
						<xsl:value-of select="SOLICITUD/DOCUMENTO_SOLICITUD/NOMBRE"/>
					</a>
				</li>
				</xsl:if>
				<xsl:if test="SOLICITUD/SO_NUMPRODUCTOS and SOLICITUD/SO_NUMPRODUCTOSCAT">
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='prod']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='prod_cat']/node()"/>:</label>
            		<xsl:value-of select="SOLICITUD/SO_NUMPRODUCTOS"/>&nbsp;/&nbsp;<xsl:value-of select="SOLICITUD/SO_NUMPRODUCTOSCAT"/>
				</li>
				</xsl:if>
				<!--	revisar para que servía este separador	
				<xsl:if test="SOLICITUD/PRODUCTOS/PRODUCTO">
					<tr><td colspan="3">&nbsp;</td></tr>
				</xsl:if>
				-->
				<xsl:if test="SOLICITUD/SO_IDESTADO = 'S'">
				<li>
					<!--	
					
							REVISAR ESTE BLOQUE (iconos/acciones)
							
					-->
					<label>
					1)&nbsp;<img src="http://www.newco.dev.br/images/modificarLente.gif" alt="Buscar" />&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='buscar_ref_proveedor']/node()"/><br/>
					2)&nbsp;<img src="http://www.newco.dev.br/images/catalogo.gif" alt="Catalogar" />&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='catalogar_producto']/node()"/><br/>
					3)&nbsp;<img src="http://www.newco.dev.br/images/checkCenter.gif" alt="Catalogado" />&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='producto_catalogado']/node()"/><br/>
					</label>
				</li>
				</xsl:if>
			
			</ul>
			<!-- Finalizamos aquí la primera parte del formulario	-->
			
			
        	<!--PRODUCTOS modelo nuevo solicitudes-->
        	<xsl:if test="SOLICITUD/PRODUCTOS/PRODUCTO/SO_OFE_ID != ''">
        	<!--<table id="listadoProductos" class="grandeInicio" style="border:2px solid #D7D8D7;border-top:0;">-->
        	<table id="listadoProductos" class="buscador" style="width:1000px; margin-left:60px;">
			<thead>
				<!--<tr class="titulosAzul">-->
				<tr class="subTituloTabla">
					<th align="left">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
					<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_centro']/node()"/></th>
					<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/></th>
					<th class="dies" style="text-align:left;">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
					<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></th>
					<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></th>
				<xsl:if test="SOLICITUD/SO_IDESTADO = 'S'">
					<th class="veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/></th>
					<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
					<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
					<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo']/node()"/></th>
				</xsl:if>
				<xsl:if test="SOLICITUD/SO_IDESTADO = 'R'">
					<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/></th>
					<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
					<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
					<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo']/node()"/></th>
				</xsl:if>
				</tr>
			</thead>

			<tbody>
			<xsl:for-each select="SOLICITUD/PRODUCTOS/PRODUCTO">
			  <!--input hidden para insertar de nuevo el producto en la solicitud pero con el id prod estandar esta vez, que antes hemos recuperado.-->
			  <input type="hidden" name="IDSOL_{SO_OFE_ID}" value="{../../SO_ID}"/>
			  <input type="hidden" name="IDPRODSOL_{SO_OFE_ID}" value="{SO_OFE_ID}"/>
			  <input type="hidden" name="PRODUCTO_{SO_OFE_ID}" value="{SO_OFE_PRODUCTO}"/>
			  <input type="hidden" name="REFCLIENTE_{SO_OFE_ID}" value="{SO_OFE_REFCLIENTE}"/>
			  <input type="hidden" name="REFPROVEEDOR_{SO_OFE_ID}" value="{SO_OFE_REFPROVEEDOR}"/>
			  <input type="hidden" name="PROVEEDOR_{SO_OFE_ID}" value="{SO_OFE_PROVEEDOR}"/>
			  <input type="hidden" name="PRECIO_{SO_OFE_ID}" value="{SO_OFE_PRECIO}"/>
			  <input type="hidden" name="CONSUMO_{SO_OFE_ID}" value="{SO_OFE_CONSUMO}"/>
			  <input type="hidden" name="IDPRODUCTO_{SO_OFE_ID}"/>

			  <tr style="border-bottom:1px solid #E3E2E2;">
    			<td style="text-align:left;border-right:1px solid #E3E2E2;">&nbsp;<xsl:value-of select="SO_OFE_PRODUCTO" /></td>
    			<td style="border-right:1px solid #E3E2E2;"><xsl:value-of select="SO_OFE_REFCLIENTE" /></td>
    			<td style="border-right:1px solid #E3E2E2;"><xsl:value-of select="SO_OFE_REFPROVEEDOR" /></td>
    			<td style="border-right:1px solid #E3E2E2;" class="textLeft">&nbsp;<xsl:value-of select="SO_OFE_PROVEEDOR" /></td>
    			<td style="border-right:1px solid #E3E2E2;"><xsl:value-of select="SO_OFE_PRECIO" /></td>
    			<td style="border-right:1px solid #E3E2E2;"><xsl:value-of select="SO_OFE_CONSUMO" /></td>
			  <!--si estado oferta tengo input y botones para catalogar el producto-->
			  <xsl:choose>
			  <xsl:when test="../../SO_IDESTADO = 'S'">
    			<td style="border-right:1px solid #E3E2E2;">
    			  <input type="hidden" class="IDProd" name="IDPROD_{SO_OFE_ID}" id="IDPROD_{SO_OFE_ID}" size="10" max-length="8" disabled="disabled" value="{SO_OFE_IDPRODUCTO}" />
    			  <input type="text" class="refPro peq" name="REF_PROV_{SO_OFE_ID}" id="REF_PROV_{SO_OFE_ID}" value="{CATALOGOPROVEEDOR/PRO_REFERENCIA}" size="8" max-length="8" disabled="disabled" />&nbsp;
    			  <a style="text-decoration:none;" id="buscarProd">
        			<xsl:attribute name="href">javascript:abrirCatalogoPoveedores('<xsl:value-of select="SO_OFE_ID" />','<xsl:value-of select="SO_OFE_PRODUCTO"/>');</xsl:attribute>
        			<img src="http://www.newco.dev.br/images/modificarLente.gif" alt="Buscar" />
    			  </a>&nbsp;
    			  <span id="catalogar_{SO_OFE_ID}">
        			<xsl:attribute name="style">
        			  <xsl:choose>
        			  <xsl:when test="SO_OFE_IDPRODUCTO != ''"></xsl:when>
        			  <xsl:otherwise>display:none;</xsl:otherwise>
        			  </xsl:choose>
        			</xsl:attribute>
        			<a style="text-decoration:none;">
        			  <xsl:attribute name="href">javascript:abrirFichaCatalogacion('<xsl:value-of select="SO_OFE_ID" />','<xsl:value-of select="../../SO_IDCLIENTE"/>');</xsl:attribute>
        			  <img src="http://www.newco.dev.br/images/catalogo.gif" alt="Catalogar" />
        			</a>
    			  </span>
    			</td>
    			<td style="border-right:1px solid #E3E2E2;">
    			  <input type="text" name="PROVE_CAT_{SO_OFE_ID}" id="PROVE_CAT_{SO_OFE_ID}" size="12" max-length="30" disabled="disabled" value="{CATALOGOPROVEEDOR/PROVEEDOR}" />
    			</td>
    			<td style="border-right:1px solid #E3E2E2;">
    			  <input type="hidden" class="IDProdEstan" name="IDPROD_ESTAN_{SO_OFE_ID}" id="IDPROD_ESTAN_{SO_OFE_ID}" size="10" max-length="8" disabled="disabled" value="{SO_OFE_IDPRODUCTOESTANDAR}" />
    			  <input type="text" name="REF_CLIENTE_CAT_{SO_OFE_ID}" id="REF_CLIENTE_CAT_{SO_OFE_ID}" size="8" max-length="10" disabled="disabled" value="{CATALOGOPRIVADO/CP_PRO_REFCLIENTE}"/>
    			</td>
    			<td style="border-right:1px solid #E3E2E2;">
    			  <xsl:if test="SO_OFE_IDESTADO = 'C'">&nbsp;<img src="http://www.newco.dev.br/images/checkCenter.gif" alt="Catalogado" valign="top" /></xsl:if>
    			</td>
			  </xsl:when>
			  <!--si estado resuelto veo los datos de la catalogación-->
			  <xsl:when test="../../SO_IDESTADO = 'R'">
    			<td style="border-right:1px solid #E3E2E2;">
    			  <xsl:value-of select="CATALOGOPROVEEDOR/PRO_REFERENCIA" />
    			  <input type="hidden" class="IDProd" name="IDPROD_{SO_OFE_ID}" id="IDPROD_{SO_OFE_ID}" size="10" max-length="8" disabled="disabled" value="{SO_OFE_IDPRODUCTO}" />
    			</td>
    			<td style="border-right:1px solid #E3E2E2;">
    			  <xsl:value-of select="CATALOGOPROVEEDOR/PROVEEDOR" />
    			</td>
    			<td style="border-right:1px solid #E3E2E2;">
    			  <xsl:value-of select="CATALOGOPRIVADO/CP_PRO_REFCLIENTE" />
    			  <input type="hidden" class="IDProdEstan" name="IDPROD_ESTAN_{SO_OFE_ID}" id="IDPROD_ESTAN_{SO_OFE_ID}" size="10" max-length="8" disabled="disabled" value="{SO_OFE_IDPRODUCTOESTANDAR}" />
    			</td>
    			<td>
        			<xsl:choose>
    			  <xsl:when test="SO_OFE_IDPRODUCTOESTANDAR != ''">&nbsp;<img src="http://www.newco.dev.br/images/checkCenter.gif" alt="Catalogado" valign="top" /></xsl:when>
    			  <xsl:otherwise>&nbsp;<img src="http://www.newco.dev.br/images/nocheck.gif" alt="No catalogado" valign="top" /></xsl:otherwise>
    			  </xsl:choose>
    			</td>
			  </xsl:when>
			  </xsl:choose>
			  </tr>
			</xsl:for-each>
			</tbody>
			</table>
			</xsl:if>
			<!--FIN TABLA DE PRODUCTOS-->

       		<xsl:if test="SOLICITUD/SO_IDESTADO = 'P'">
				<!-- INICIO pestañas para dar de alta producto/s -->
				<xsl:if test="SOLICITUD/ADMIN">
				<div id="pestanas" class="divLeft" style="margin-top:10px;border-bottom:0px solid #3B5998;">
					<xsl:choose>
					<xsl:when test="LANG = 'spanish'">
						<a href="#" id="pes_lAltaProducto" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/botonAltaProducto1.gif" alt="Alta Producto" title="Alta Producto"/></a>&nbsp;
						<a href="#" id="pes_lAltaFichero" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/botonAltaFichero.gif" alt="Alta Fichero" title="Alta Fichero"/></a>&nbsp;
					</xsl:when>
					<xsl:otherwise>
						<a href="#" id="pes_lAltaProducto" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/botonAltaProducto1-BR.gif" alt="Alta Produto" title="Alta Produto"/></a>&nbsp;
						<a href="#" id="pes_lAltaFichero" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/botonAltaFichero-BR.gif" alt="Alta Arquivo" title="Alta Arquivo"/></a>&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</div>
				</xsl:if>
				
				<!--anadir productos-->
				<div id="lAltaProducto">
				<div id="anadirProductos">
                <input type="hidden" name="IDSOLICITUD" id="IDSOLICITUD" value="{SOLICITUD/SO_ID}" />
        		<ul style="width:1000px;">
				<li>
					<strong>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir']/node()"/>&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/>
					</strong>			
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:<span class="camposObligatorios">*</span></label>
					<input type="text" name="PRODUCTO" id="PRODUCTO" maxlength="200" size="62"/>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:</label>
					<input type="text" name="REFCLIENTE" id="REFCLIENTE" maxlength="100"/>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/>:</label>
					<input type="text" name="REFPROVEEDOR" id="REFPROVEEDOR" maxlength="100"/>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label>
					<input type="text" name="PROVEEDOR" id="PROVEEDOR" maxlength="100"/>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>:</label>
					<input name="PRECIO" id="PRECIO" maxlength="10"/>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_anual']/node()"/>:</label>
					<input type="text" name="CANTIDAD" id="CANTIDAD" maxlength="10"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_explicacion_sol_cat']/node()"/>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_anual']/node()"/>:</label>
					<input type="text" name="CANTIDAD" id="CANTIDAD" maxlength="10"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_explicacion_sol_cat']/node()"/>
				</li>
				<li>
					<label>&nbsp;</label>
					<a class="btnDestacado" id="BotonSubmit" href="javascript:anadirProducto(document.forms['SolicitudCatalogacion']);">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir']/node()"/>
                	</a>
					<!--&nbsp;
					<a class="btnDestacado" href="javascript:cambiarEstado('N');">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/>
					</a>-->
					&nbsp;
					<a class="btnNormal" href="javascript:closeWindow();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente2']/node()"/>
					</a>
				</li>
				</ul>
				</div>
				</div>
				<!--fin de anadir productos-->

				<!--anadir fichero de productos vía textarea-->
				<div id="lAltaFichero" style="display: none;">
				<div id="anadirProductos">
        			<ul style="width:1000px;">
					<li>
						<strong>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir']/node()"/>&nbsp;
						<xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/>
						</strong>			
					</li>
					<li>
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='Productos']/node()"/>:<span class="camposObligatorios">*</span></label>
						<textarea name="TXT_PRODUCTOS" id="TXT_PRODUCTOS" cols="120" rows="20"/>
					</li>
					<li>
						<label>&nbsp;</label>
						<a class="btnDestacado" id="BotonSubmit2" href="javascript:javascript:anadirFilasProductos(document.forms['SolicitudCatalogacion']);">
						  <xsl:value-of select="document($doc)/translation/texts/item[@name='anadir']/node()"/>
						</a>
						&nbsp;
						<a class="btnNormal" href="javascript:closeWindow();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente2']/node()"/>
						</a>
					</li>
					</ul>
				</div>
				</div>
			</xsl:if>
			<!--fin de anadir productos por fichero-->
        	<xsl:choose>
        	<xsl:when test="SOLICITUD/SO_IDESTADO = 'P'">
        	  <!--si es usuario que solicita y solicitud estado Nueva no veo esto, estoy añadiendo productos-->
        	</xsl:when>
        	<xsl:otherwise>
        		<ul style="width:1000px;">
				<!--	DIAGNOSTICO		-->
				<li>
					<strong>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='diagnostico']/node()"/>
					<xsl:if test="SOLICITUD/SO_FECHADIAGNOSTICO != ''">
						<span style="float:right;padding-right:30px;">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;<xsl:value-of select="SOLICITUD/SO_FECHADIAGNOSTICO"/>
                    	</span>
					</xsl:if>
					</strong>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:</label>
					<xsl:choose>
					<xsl:when test="not (SOLICITUD/EDITAROFERTA)">
						<xsl:value-of select="SOLICITUD/USUARIODIAGNOSTICO"/>
					</xsl:when>
					<xsl:otherwise>
						[<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>]
					</xsl:otherwise>
					</xsl:choose>
				</li>
				<xsl:choose>
				<xsl:when test="SOLICITUD/EDITAROFERTA">
					<li>
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='diagnostico']/node()"/>:</label>
						<input type="hidden" name="DIAGNOSTICO_OLD" id="DIAGNOSTICO_OLD" value="{SOLICITUD/SO_DIAGNOSTICO}"/>
						<textarea name="SO_DIAGNOSTICO" id="SO_DIAGNOSTICO" rows="4" cols="60" maxlength="3000">
							<xsl:copy-of select="SOLICITUD/SO_DIAGNOSTICO/node()" disable-output-escaping="yes"/>
						</textarea>
					</li>
					<li>
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/>:</label>
						<xsl:choose>
						<xsl:when test="SOLICITUD/DOCUMENTO_DIAGNOSTICO/ID">
						<span id="newDocDIAG" align="center" style="display:none;">
							<a href="javascript:verCargaDoc('DIAG');" title="Subir documento" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/subirDocumento.gif" alt="Subir Documento" title="Subir Documento"/>
							</a>
						</span>&nbsp;
						<span id="docBoxDIAG" align="center">
							<a href="http://www.newco.dev.br/Documentos/{SOLICITUD/DOCUMENTO_DIAGNOSTICO/URL}" target="_blank">
								<xsl:value-of select="SOLICITUD/DOCUMENTO_DIAGNOSTICO/NOMBRE"/>
							</a>
						</span>&nbsp;
						<span id="borraDocDIAG" align="center">
							<a href="javascript:borrarDoc({SOLICITUD/DOCUMENTO_DIAGNOSTICO/ID},'DIAG')">
								<img src="http://www.newco.dev.br/images/2017/trash.png"/>
						</a>
						</span>
						</xsl:when>
						<xsl:otherwise>
						<span id="newDocDIAG" align="center">
							<a href="javascript:verCargaDoc('DIAG');" title="Subir documento" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/subirDocumento.gif" alt="Subir Documento" title="Subir Documento"/>
							</a>
						</span>&nbsp;
						<span id="docBoxDIAG" style="display:none;" align="center"></span>&nbsp;
						<span id="borraDocDIAG" style="display:none;" align="center"></span>
						</xsl:otherwise>
						</xsl:choose>
					</li>
					<li id="cargaDIAG" class="cargas" style="display:none;">
						<xsl:call-template name="CargaDocumentos"><xsl:with-param name="tipo">DIAG</xsl:with-param></xsl:call-template>
					</li>
				</xsl:when>
				<xsl:otherwise>
					<li>
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='diagnostico']/node()"/>:</label>
						<input type="hidden" name="SO_DIAGNOSTICO" id="SO_DIAGNOSTICO" value="{SOLICITUD/SO_DIAGNOSTICO}"/>
						<xsl:copy-of select="SOLICITUD/SO_DIAGNOSTICO/node()" disable-output-escaping="yes"/>&nbsp;
					</li>
					<xsl:if test="SOLICITUD/DOCUMENTO_DIAGNOSTICO/ID">
						<li>
							<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_diagnostico']/node()"/>:</label>
							<a href="http://www.newco.dev.br/Documentos/{SOLICITUD/DOCUMENTO_DIAGNOSTICO/URL}" target="_blank">
								<xsl:value-of select="SOLICITUD/DOCUMENTO_DIAGNOSTICO/NOMBRE"/>
							</a>
						</li>
					</xsl:if>
		        </xsl:otherwise>
        		</xsl:choose>
				<!--	OFERTA		-->
				<li>
					<strong>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='oferta']/node()"/>
					<xsl:if test="SOLICITUD/SO_FECHAOFERTA != ''">
						<span style="float:right;padding-right:30px;">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;<xsl:value-of select="SOLICITUD/SO_FECHAOFERTA"/>
						</span>
					</xsl:if>
					</strong>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:</label>
					<xsl:choose>
					<xsl:when test="not (SOLICITUD/EDITAROFERTA)">
						<xsl:value-of select="SOLICITUD/USUARIOOFERTA"/>&nbsp;
					</xsl:when>
					<xsl:otherwise>
						[<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>]
					</xsl:otherwise>
					</xsl:choose>
				</li>			
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta']/node()"/>:</label>
					<xsl:choose>
					<xsl:when test="SOLICITUD/EDITAROFERTA">
						<input type="hidden" name="OFERTA_OLD" id="OFERTA_OLD" value="{SOLICITUD/SO_OFERTA}"/>
						<textarea name="SO_OFERTA" id="SO_OFERTA" rows="4" cols="60" maxlength="3000">
							<xsl:copy-of select="SOLICITUD/SO_OFERTA/node()" disable-output-escaping="yes"/>&nbsp;
						</textarea>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="SOLICITUD/SO_OFERTA/node()" disable-output-escaping="yes"/>&nbsp;
					</xsl:otherwise>
					</xsl:choose>
				</li>			
				<xsl:choose>
				<xsl:when test="SOLICITUD/EDITAROFERTA">
					<li>
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/>:</label>	
						<xsl:choose>
						<xsl:when test="SOLICITUD/DOCUMENTO_OFERTA/ID">
						<span id="newDocSOL" align="center" style="display:none;">
							<a href="javascript:verCargaDoc('SOL');" title="Subir documento" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/subirDocumento.gif" alt="Subir Documento" title="Subir Documento"/>
							</a>
						</span>&nbsp;
						<span id="docBoxSOL" align="center">
							<a href="http://www.newco.dev.br/Documentos/{SOLICITUD/DOCUMENTO_OFERTA/URL}" target="_blank">
								<xsl:value-of select="SOLICITUD/DOCUMENTO_OFERTA/NOMBRE"/>
							</a>
						</span>&nbsp;
						<span id="borraDocSOL" align="center">
							<a href="javascript:borrarDoc({SOLICITUD/DOCUMENTO_OFERTA/ID},'SOL')">
								<img src="http://www.newco.dev.br/images/2017/trash.png"/>
							</a>
						</span>
						</xsl:when>
						<xsl:otherwise>
						<span id="newDocSOL" align="center">
							<a href="javascript:verCargaDoc('SOL');" title="Subir documento" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/subirDocumento.gif" alt="Subir Documento" title="Subir Documento"/>
							</a>
						</span>&nbsp;
						<span id="docBoxSOL" style="display:none;" align="center"></span>&nbsp;
						<span id="borraDocSOL" style="display:none;" align="center"></span>
						</xsl:otherwise>
						</xsl:choose>
					</li>
					<li id="cargaSOL" class="cargas" style="display:none;">
						<xsl:call-template name="CargaDocumentos"><xsl:with-param name="tipo">SOL</xsl:with-param></xsl:call-template>
					</li>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="SOLICITUD/DOCUMENTO_OFERTA/ID">
							<li>
								<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_oferta']/node()"/>:</label>
								<a href="http://www.newco.dev.br/Documentos/{SOLICITUD/DOCUMENTO_OFERTA/URL}" target="_blank">
									<xsl:value-of select="SOLICITUD/DOCUMENTO_OFERTA/NOMBRE"/>
								</a>
							</li>
						</xsl:if>
					</xsl:otherwise>
					</xsl:choose>
				</ul>
        	</xsl:otherwise>
        	</xsl:choose>
    	</div>
		</form>
		<!--	FIN nuevo formulario	-->
			
			<!--frame para las imagenes-->
			<div id="uploadFrameBox" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>
			<div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>

			<!--form de mensaje de error de js-->
			<form name="mensajeJS">
				<!--carga documentos-->
				<input type="hidden" name="ERROR_SIN_DEFINIR" value="{document($doc)/translation/texts/item[@name='error_sin_definir']/node()}"/>
				<input type="hidden" name="HEMOS_ESPERADO" value="{document($doc)/translation/texts/item[@name='hemos_esperado']/node()}"/>
				<input type="hidden" name="LA_CARGA_NO_TERMINO" value="{document($doc)/translation/texts/item[@name='la_carga_no_termino']/node()}"/>
			</form>

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
			<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='para']/node()"/>&nbsp;
			<xsl:value-of select="SOLICITUD/SO_CODIGO"/>&nbsp;
            <xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_oferta']/node()"/>:
            	&nbsp;<xsl:value-of select="SOLICITUD/SO_TITULO"/>
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
	</xsl:choose><!--fin choose si incidencia guardada con exito-->
	</div><!--fin de divLeft-->
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>

<!--template carga documentos-->
<xsl:template name="CargaDocumentos">
	<xsl:param name="tipo" />

	<!--idioma-->
	<xsl:variable name="lang"><xsl:value-of select="LANG"/></xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="divLeft" id="cargaDoc{$tipo}">
		<!--tabla imagenes y documentos-->
		<table class="buscador" border="0">
			<tr>
				<!--documentos-->
				<td class="labelRight trenta grisMed">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='elige_documento']/node()"/>
				</td>
				<td class="datosLeft">
					<div class="altaDocumento">
						<span class="anadirDoc">
							<xsl:call-template name="documentos">
								<xsl:with-param name="num" select="number(1)"/>
								<xsl:with-param name="type" select="$tipo"/>
							</xsl:call-template>
						</span>
					</div>
				</td>
			</tr>
		</table><!--fin de tabla imagenes doc-->

		<div id="waitBoxDoc{$tipo}" align="center">&nbsp;</div>
	</div><!--fin de divleft-->
</xsl:template><!--fin de template carga documentos-->

<!--documentos-->
<xsl:template name="documentos">
	<xsl:param name="num"/>
	<xsl:param name="type"/>

	<xsl:choose>
	<xsl:when test="$num &lt; number(5)">
		<div class="docLine" id="docLine_{$type}">
			<div class="docLongEspec" id="docLongEspec_{$type}">
				<input id="inputFileDoc_{$type}" name="inputFileDoc_{$type}" type="file" onChange="cargaDoc(document.forms['SolicitudCatalogacion'],'{$type}');"/>
			</div>
		</div>
	</xsl:when>
	</xsl:choose>
</xsl:template><!--fin de documentos-->
</xsl:stylesheet>
