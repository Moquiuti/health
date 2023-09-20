<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<!--
	Solicitud de Catalogacion. Nuevo disenno 2022.
	Ultima revision: ET 16may22 10:40 SolicitudCatalogacion2022_130522.js
-->
<xsl:template match="/SolicitudCatalogacion">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

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

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_catalogacion']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/Tabla-popup.150715.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/etiquetas.js"></script>-->

	<link rel="stylesheet" href="http://www.newco.dev.br/General/lightbox.css" type="text/css" media="screen"/>
	<link href="http://www.newco.dev.br/General/Tabla-popup.150715.css" rel="stylesheet" type="text/css"/>
	<!--fin codigo etiquetas-->

	<script type="text/javascript">
	var lang = '<xsl:value-of select="LANG"/>';

	var producto_obligatorio	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_producto_solicitud_catalogacion']/node()"/>';
	var precio_mal_formato = '<xsl:value-of select="document($doc)/translation/texts/item[@name='mal_formato_precio_solicitud_catalogacion']/node()"/>';
	var cantidad_mal_formato = '<xsl:value-of select="document($doc)/translation/texts/item[@name='mal_formato_cantidad_solicitud_catalogacion']/node()"/>';
	var diagnostico_obligatorio	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_diagnostico_solicitud_catalogacion']/node()"/>';
	var solucion_obligatoria	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_solucion_solicitud_catalogacion']/node()"/>';
	var ref_guardada_con_exito	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_guardada_con_exito']/node()"/>';
	var filas_productos_obligatorio = '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_filas_productos_solicitud_catalogacion']/node()"/>';
	var err_subir_productos = '<xsl:value-of select="document($doc)/translation/texts/item[@name='err_subir_productos_solicitud_catalogacion']/node()"/>';

	<!-- Variables y Strings JS para las etiquetas -->
	var IDRegistro	= '<xsl:value-of select="SOLICITUD/SC_ID"/>';
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

	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/SolicitudCatalogacion2022_130522.js"></script>
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
		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='error_solicitud_catalogacion']/node()"/></h1>
	</xsl:when>
	<xsl:otherwise>

		<xsl:variable name="usuario">
		<xsl:choose>
			<xsl:when test="not(SOLICITUD/OBSERVADOR) and SOLICITUD/CDC and SOLICITUD/IDEMPRESAUSUARIO = SOLICITUD/SC_IDCLIENTE">CDC</xsl:when>
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
			<p class="TituloPagina">
				<xsl:value-of select="SOLICITUD/SC_CODIGO"/>&nbsp;
				<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_catalogacion']/node()"/>:&nbsp;
				<xsl:value-of select="SOLICITUD/SC_TITULO"/>
				<span class="CompletarTitulo">
					<xsl:if test="SOLICITUD/AUTOR or $usuario = 'CDC' or $usuarioMVM = 'MVM' or $adminCliente = 'ADMIN'">
       					<xsl:if test="SOLICITUD/SC_IDESTADO = 'P'">
							<a class="btnDestacado" href="javascript:cambiarEstado('N');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/>
							</a>
							&nbsp;
						</xsl:if>
					</xsl:if>

					<xsl:if test="$usuario = 'CDC' or $usuarioMVM = 'MVM' or $adminCliente = 'ADMIN'">
						<xsl:if test="SOLICITUD/SC_IDESTADO = 'N' or SOLICITUD/SC_IDESTADO = 'D' or SOLICITUD/SC_IDESTADO = 'S'">
							<a class="btnDestacado" id="BotonDIAG" href="javascript:GuardaYCambiaEstado('D');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='diagnostico']/node()"/>
							</a>&nbsp;
						</xsl:if>

						<xsl:if test="SOLICITUD/SC_IDESTADO = 'N' or SOLICITUD/SC_IDESTADO = 'D' or SOLICITUD/SC_IDESTADO = 'S'">
							<a class="btnDestacado" id="BotonSOL" href="javascript:GuardaYCambiaEstado('S');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='propuesta_solucion']/node()"/>
							</a>&nbsp;
						</xsl:if>

						<xsl:if test="SOLICITUD/SC_IDESTADO != 'P' and SOLICITUD/SC_IDESTADO != 'R'">
							<a class="btnDestacado" id="BotonRES" href="javascript:GuardaYCambiaEstado('R');">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='resuelta']/node()"/>
							</a>&nbsp;
						</xsl:if>
					</xsl:if>
					<a class="btnNormal" href="javascript:Solicitudes();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/>
					</a>

				</span>
			</p>
		</div>
		<br/>
		<form class="formEstandar" name="SolicitudCatalogacion" id="SolicitudCatalogacion" method="post">
			<input type="hidden" name="SC_ID" id="SC_ID" value="{SOLICITUD/SC_ID}"/>
			<input type="hidden" name="TIPO_DOC_DB" id="TIPO_DOC_DB"/>
			<input type="hidden" name="TIPO_DOC_HTML" id="TIPO_DOC_HTML"/>
			<input type="hidden" name="CADENA_DOCUMENTOS"/>
			<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
			<input type="hidden" name="BORRAR_ANTERIORES"/>
			<input type="hidden" name="SC_IDESTADO" id="SC_IDESTADO"/>
			<input type="hidden" name="SC_IDDOCSOLICITUD" id="DOC_SOLCAT" value="{SOLICITUD/DOCUMENTO_SOLICITUD/ID}"/>
			<input type="hidden" name="SC_IDDOCDIAGNOSTICO" id="DOC_DIAG" value="{SOLICITUD/DOCUMENTO_DIAGNOSTICO/ID}"/>
			<input type="hidden" name="SC_IDDOCSOLUCION" id="DOC_SOL" value="{SOLICITUD/DOCUMENTO_SOLUCION/ID}"/>
			<input type="hidden" name="IDPRODESTANDAR" id="IDPRODESTANDAR"/>
			<input type="hidden" name="ID_USUARIO" value="{SOLICITUD/IDUSUARIO}"/>
			<input type="hidden" name="IDEMPRESA" id="IDEMPRESA" value="{SOLICITUD/IDEMPRESAUSUARIO}"/>
		
		<!--	Nuevo formulario	-->
    	<div>
        	<ul class="w1000px">
            	<li>
                <xsl:choose>
                    <xsl:when test="LANG = 'spanish'">
                        <xsl:choose>
                        <xsl:when test="SOLICITUD/SC_IDESTADO = 'P'">
                          <img src="http://www.newco.dev.br/images/step2sol.gif" alt="Paso 2 - Añadir productos" />
                        </xsl:when>
                        <xsl:when test="SOLICITUD/SC_IDESTADO = 'N'">
                          <img src="http://www.newco.dev.br/images/step3sol.gif" alt="Paso 3 - Diagnóstico" />
                        </xsl:when>
                        <xsl:when test="SOLICITUD/SC_IDESTADO = 'D'">
                          <img src="http://www.newco.dev.br/images/step4sol.gif" alt="Paso 4 - Propuesta de solución" />
                        </xsl:when>
                        <xsl:when test="SOLICITUD/SC_IDESTADO = 'S'">
                          <img src="http://www.newco.dev.br/images/step5sol.gif" alt="Paso 5 - Solución" />
                        </xsl:when>
                        <xsl:when test="SOLICITUD/SC_IDESTADO = 'R'">
                          <img src="http://www.newco.dev.br/images/step6sol.gif" alt="Paso 6 - Resuelta" />
                        </xsl:when>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                        <xsl:when test="SOLICITUD/SC_IDESTADO = 'P'">
                          <img src="http://www.newco.dev.br/images/step2sol-BR.gif" alt="Paso 2 - Adicionar produtos" />
                        </xsl:when>
                        <xsl:when test="SOLICITUD/SC_IDESTADO = 'N'">
                          <img src="http://www.newco.dev.br/images/step3sol-BR.gif" alt="Paso 3 - Diagnóstico" />
                        </xsl:when>
                        <xsl:when test="SOLICITUD/SC_IDESTADO = 'D'">
                          <img src="http://www.newco.dev.br/images/step4sol-BR.gif" alt="Paso 4 - Solução proposta" />
                        </xsl:when>
                        <xsl:when test="SOLICITUD/SC_IDESTADO = 'S'">
                          <img src="http://www.newco.dev.br/images/step5sol-BR.gif" alt="Paso 5 - Catalogação" />
                        </xsl:when>
                        <xsl:when test="SOLICITUD/SC_IDESTADO = 'R'">
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
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>:</label>
					<input type="text" name="SC_TITULO" id="SC_TITULO" class="campopesquisa w300px" maxlength="200"  value="{SOLICITUD/SC_TITULO}"/>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:</label>
					<input type="hidden" name="SC_DESCRIPCION" id="SC_DESCRIPCION" value="{SOLICITUD/SC_DESCRIPCION}"/>
					<xsl:copy-of select="SOLICITUD/SC_DESCRIPCION/node()" disable-output-escaping="yes"/>
				</li>
				<xsl:if test="not(SOLICITUD/PRODUCTOS/PRODUCTO)">
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='infoprecio']/node()"/>:</label>
					<input type="hidden" name="SC_INFOPRECIO" id="SC_INFOPRECIO" value="{SOLICITUD/SC_INFOPRECIO}"/>
					<xsl:copy-of select="SOLICITUD/SC_INFOPRECIO/node()" disable-output-escaping="yes"/>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/>:</label>
					<input type="hidden" name="SC_CONSUMO" id="SC_CONSUMO" value="{SOLICITUD/SC_CONSUMO}"/>
					<xsl:copy-of select="SOLICITUD/SC_CONSUMO/node()" disable-output-escaping="yes"/>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label>
					<input type="hidden" name="SC_PROVEEDOR" id="SC_PROVEEDOR" value="{SOLICITUD/SC_PROVEEDOR}"/>
					<xsl:copy-of select="SOLICITUD/SC_PROVEEDOR/node()" disable-output-escaping="yes"/>
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
				<xsl:if test="SOLICITUD/SC_NUMPRODUCTOS and SOLICITUD/SC_NUMPRODUCTOSCAT">
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='prod']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='prod_cat']/node()"/>:</label>
            		<xsl:value-of select="SOLICITUD/SC_NUMPRODUCTOS"/>&nbsp;/&nbsp;<xsl:value-of select="SOLICITUD/SC_NUMPRODUCTOSCAT"/>
				</li>
				</xsl:if>
				<xsl:if test="SOLICITUD/SC_IDESTADO = 'S'">
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
        	<xsl:if test="SOLICITUD/PRODUCTOS/PRODUCTO/SC_PROD_PRODUCTO != ''">
			<div class="tabela tabela_redonda w90 tableCenter">
			<table id="listadoProductos" cellspacing="6px" cellpadding="6px">
				<thead class="cabecalho_tabela">
				<tr>
					<th class="w1px">&nbsp;</th>
					<th class="textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
					<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_centro']/node()"/></th>
					<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/></th>
					<th class="textLeft">&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
					<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></th>
					<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></th>
				<xsl:if test="SOLICITUD/SC_IDESTADO = 'S'">
					<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/></th>
					<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
					<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
					<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo']/node()"/></th>
				</xsl:if>
				<xsl:if test="SOLICITUD/SC_IDESTADO = 'R'">
					<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/></th>
					<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
					<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
					<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo']/node()"/></th>
				</xsl:if>
				</tr>
			</thead>
			<!--	Cuerpo de la tabla	-->
			<tbody class="corpo_tabela">
			<xsl:for-each select="SOLICITUD/PRODUCTOS/PRODUCTO">
			  <input type="hidden" name="IDSOL_{SC_PROD_ID}" value="{../../SC_ID}"/>
			  <input type="hidden" name="IDPRODSOL_{SC_PROD_ID}" value="{SC_PROD_ID}"/>
			  <input type="hidden" name="PRODUCTO_{SC_PROD_ID}" value="{SC_PROD_PRODUCTO}"/>
			  <input type="hidden" name="REFCLIENTE_{SC_PROD_ID}" value="{SC_PROD_REFCLIENTE}"/>
			  <input type="hidden" name="REFPROVEEDOR_{SC_PROD_ID}" value="{SC_PROD_REFPROVEEDOR}"/>
			  <input type="hidden" name="PROVEEDOR_{SC_PROD_ID}" value="{SC_PROD_PROVEEDOR}"/>
			  <input type="hidden" name="PRECIO_{SC_PROD_ID}" value="{SC_PROD_PRECIO}"/>
			  <input type="hidden" name="CONSUMO_{SC_PROD_ID}" value="{SC_PROD_CONSUMO}"/>
			  <input type="hidden" name="IDPRODUCTO_{SC_PROD_ID}"/>

			  <tr class="con_hover">
				<td class="color_status">&nbsp;</td>
    			<td class="textLeft">&nbsp;<xsl:value-of select="SC_PROD_PRODUCTO" /></td>
    			<td style=""><xsl:value-of select="SC_PROD_REFCLIENTE" /></td>
    			<td style=""><xsl:value-of select="SC_PROD_REFPROVEEDOR" /></td>
    			<td style="" class="textLeft">&nbsp;<xsl:value-of select="SC_PROD_PROVEEDOR" /></td>
    			<td style=""><xsl:value-of select="SC_PROD_PRECIO" /></td>
    			<td style=""><xsl:value-of select="SC_PROD_CONSUMO" /></td>
			  <!--si estado solucion tengo input y botones para catalogar el producto-->
			  <xsl:choose>
			  <xsl:when test="../../SC_IDESTADO = 'S'">
    			<td style="">
    			  <input type="hidden" class="IDProd" name="IDPROD_{SC_PROD_ID}" id="IDPROD_{SC_PROD_ID}" size="10" max-length="8" disabled="disabled" value="{SC_PROD_IDPRODUCTO}" />
    			  <input type="text" class="refPro peq" name="REF_PROV_{SC_PROD_ID}" id="REF_PROV_{SC_PROD_ID}" value="{CATALOGOPROVEEDOR/PRO_REFERENCIA}" size="8" max-length="8" disabled="disabled" />&nbsp;
    			  <a style="text-decoration:none;" id="buscarProd">
        			<xsl:attribute name="href">javascript:abrirCatalogoPoveedores('<xsl:value-of select="SC_PROD_ID" />','<xsl:value-of select="SC_PROD_PRODUCTO"/>');</xsl:attribute>
        			<img src="http://www.newco.dev.br/images/modificarLente.gif" alt="Buscar" />
    			  </a>&nbsp;
    			  <span id="catalogar_{SC_PROD_ID}">
        			<xsl:attribute name="style">
        			  <xsl:choose>
        			  <xsl:when test="SC_PROD_IDPRODUCTO != ''"></xsl:when>
        			  <xsl:otherwise>display:none;</xsl:otherwise>
        			  </xsl:choose>
        			</xsl:attribute>
        			<a style="text-decoration:none;">
        			  <xsl:attribute name="href">javascript:abrirFichaCatalogacion('<xsl:value-of select="SC_PROD_ID" />','<xsl:value-of select="../../SC_IDCLIENTE"/>');</xsl:attribute>
        			  <img src="http://www.newco.dev.br/images/catalogo.gif" alt="Catalogar" />
        			</a>
    			  </span>
    			</td>
    			<td style="">
    			  <input type="text" name="PROVE_CAT_{SC_PROD_ID}" id="PROVE_CAT_{SC_PROD_ID}" size="12" max-length="30" disabled="disabled" value="{CATALOGOPROVEEDOR/PROVEEDOR}" />
    			</td>
    			<td style="">
    			  <input type="hidden" class="IDProdEstan" name="IDPROD_ESTAN_{SC_PROD_ID}" id="IDPROD_ESTAN_{SC_PROD_ID}" size="10" max-length="8" disabled="disabled" value="{SC_PROD_IDPRODUCTOESTANDAR}" />
    			  <input type="text" name="REF_CLIENTE_CAT_{SC_PROD_ID}" id="REF_CLIENTE_CAT_{SC_PROD_ID}" size="8" max-length="10" disabled="disabled" value="{CATALOGOPRIVADO/CP_PRO_REFCLIENTE}"/>
    			</td>
    			<td style="">
    			  <xsl:if test="SC_PROD_IDESTADO = 'C'">&nbsp;<img src="http://www.newco.dev.br/images/checkCenter.gif" alt="Catalogado" valign="top" /></xsl:if>
    			</td>
			  </xsl:when>
			  <!--si estado resuelto veo los datos de la catalogación-->
			  <xsl:when test="../../SC_IDESTADO = 'R'">
    			<td style="">
    			  <xsl:value-of select="CATALOGOPROVEEDOR/PRO_REFERENCIA" />
    			  <input type="hidden" class="IDProd" name="IDPROD_{SC_PROD_ID}" id="IDPROD_{SC_PROD_ID}" size="10" max-length="8" disabled="disabled" value="{SC_PROD_IDPRODUCTO}" />
    			</td>
    			<td style="">
    			  <xsl:value-of select="CATALOGOPROVEEDOR/PROVEEDOR" />
    			</td>
    			<td style="">
    			  <xsl:value-of select="CATALOGOPRIVADO/CP_PRO_REFCLIENTE" />
    			  <input type="hidden" class="IDProdEstan" name="IDPROD_ESTAN_{SC_PROD_ID}" id="IDPROD_ESTAN_{SC_PROD_ID}" size="10" max-length="8" disabled="disabled" value="{SC_PROD_IDPRODUCTOESTANDAR}" />
    			</td>
    			<td>
        			<xsl:choose>
    			  <xsl:when test="SC_PROD_IDPRODUCTOESTANDAR != ''">&nbsp;<img src="http://www.newco.dev.br/images/checkCenter.gif" alt="Catalogado" valign="top" /></xsl:when>
    			  <xsl:otherwise>&nbsp;<img src="http://www.newco.dev.br/images/nocheck.gif" alt="No catalogado" valign="top" /></xsl:otherwise>
    			  </xsl:choose>
    			</td>
			  </xsl:when>
			  </xsl:choose>
			  </tr>
			</xsl:for-each>
			</tbody>
			<tfoot class="rodape_tabela">
				<tr><td colspan="12">&nbsp;</td></tr>
			</tfoot>
			</table><!--fin de infoTableAma-->
 			</div>
 			<br/>  
 			<br/>  
			</xsl:if>
			<!--FIN TABLA DE PRODUCTOS-->

       		<xsl:if test="SOLICITUD/SC_IDESTADO = 'P'">
				<!-- INICIO pestañas para dar de alta producto/s -->
				<xsl:if test="SOLICITUD/ADMIN">
				<!--
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
				-->
 					<div class="divLeft marginTop20">
						<ul class="pestannas w100" style="position:relative;">
							<li>
								<a id="pes_lAltaProducto" class="MenuLic MenuActivo"><xsl:value-of select="document($doc)/translation/texts/item[@name='Incluir_producto']/node()"/></a>
							</li>
							<li>
								<a id="pes_lAltaFichero" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='Incluir_archivo']/node()"/></a>
							</li>
						</ul>
					</div>
				</xsl:if>
				
				<!--anadir productos-->
				<div id="lAltaProducto">
				<div id="anadirProductos">
                <input type="hidden" name="IDSOLICITUD" id="IDSOLICITUD" value="{SOLICITUD/SC_ID}" />
        		<ul style="width:1000px;">
				<li>
					<strong>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir']/node()"/>&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/>
					</strong>			
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:<span class="camposObligatorios">*</span></label>
					<input type="text" name="PRODUCTO" id="PRODUCTO" class="campopesquisa w300px" maxlength="200" />
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:</label>
					<input type="text" name="REFCLIENTE" id="REFCLIENTE" class="campopesquisa w100px" maxlength="100"/>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/>:</label>
					<input type="text" name="REFPROVEEDOR" id="REFPROVEEDOR" class="campopesquisa w100px" maxlength="100"/>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</label>
					<input type="text" name="PROVEEDOR" id="PROVEEDOR" class="campopesquisa w300px" maxlength="100"/>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>:</label>
					<input name="PRECIO" id="PRECIO" class="campopesquisa w100px" maxlength="10"/>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_anual']/node()"/>:</label>
					<input type="text" name="CANTIDAD" id="CANTIDAD" class="campopesquisa w100px" maxlength="10"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_explicacion_sol_cat']/node()"/>
				</li>
				<!--13may22 PARECE DUPLICADO!
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_anual']/node()"/>:</label>
					<input type="text" name="CANTIDAD" id="CANTIDAD" class="campopesquisa w100px" maxlength="10"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_explicacion_sol_cat']/node()"/>
				</li>-->
				<li>
					<label>&nbsp;</label>
					<a class="btnDestacado" id="BotonSubmit" href="javascript:anadirProducto(document.forms['SolicitudCatalogacion']);">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='anadir']/node()"/>
                	</a>
					<!--	13may22 No parece util cerrar la ventana desde aqui
					&nbsp;
					<a class="btnNormal" href="javascript:closeWindow();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente2']/node()"/>
					</a>-->
				</li>
				</ul>
				</div>
				<br/>
				<br/>
				<br/>
				<br/>
				<br/>
				<br/>
				<br/>
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
        	<xsl:when test="SOLICITUD/SC_IDESTADO = 'P'">
        	  <!--si es usuario que solicita y solicitud estado Nueva no veo esto, estoy añadiendo productos-->
        	</xsl:when>
        	<xsl:otherwise>
        		<ul style="width:1000px;">
				<!--	DIAGNOSTICO		-->
				<li>
					<strong>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='diagnostico']/node()"/>
					<xsl:if test="SOLICITUD/SC_FECHADIAGNOSTICO != ''">
						<span style="float:right;padding-right:30px;">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;<xsl:value-of select="SOLICITUD/SC_FECHADIAGNOSTICO"/>
                    	</span>
					</xsl:if>
					</strong>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:</label>
					<xsl:choose>
					<xsl:when test="SOLICITUD/USUARIODIAGNOSTICO">
						<xsl:value-of select="SOLICITUD/USUARIODIAGNOSTICO"/>
					</xsl:when>
					<xsl:otherwise>
						[<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>]
					</xsl:otherwise>
					</xsl:choose>
				</li>
				<xsl:choose>
				<xsl:when test="(SOLICITUD/SC_IDESTADO = 'N' or SOLICITUD/SC_IDESTADO = 'D' or SOLICITUD/SC_IDESTADO = 'S') and ($usuario = 'CDC' or $usuarioMVM = 'MVM' or $adminCliente = 'ADMIN')">
					<li>
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='diagnostico']/node()"/>:</label>
						<input type="hidden" name="DIAGNOSTICO_OLD" id="DIAGNOSTICO_OLD" value="{SOLICITUD/SC_DIAGNOSTICO}"/>
						<textarea name="SC_DIAGNOSTICO" id="SC_DIAGNOSTICO" rows="4" cols="60" maxlength="3000">
							<xsl:copy-of select="SOLICITUD/SC_DIAGNOSTICO/node()" disable-output-escaping="yes"/>
						</textarea>
					</li>
					<li>
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_diagnostico']/node()"/>:</label>
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
								<img src="http://www.newco.dev.br/images/2022/icones/del.svg"/>
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
						<input type="hidden" name="SC_DIAGNOSTICO" id="SC_DIAGNOSTICO" value="{SOLICITUD/SC_DIAGNOSTICO}"/>
						<xsl:copy-of select="SOLICITUD/SC_DIAGNOSTICO/node()" disable-output-escaping="yes"/>&nbsp;
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
				<!--	SOLUCION		-->
				<li>
					<strong>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='propuesta']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='solucion']/node()"/>
					<xsl:if test="SOLICITUD/SC_FECHASOLUCION != ''">
						<span style="float:right;padding-right:30px;">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;<xsl:value-of select="SOLICITUD/SC_FECHASOLUCION"/>
						</span>
					</xsl:if>
					</strong>
				</li>
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:</label>
					<xsl:choose>
					<xsl:when test="SOLICITUD/USUARIOSOLUCION">
						<xsl:value-of select="SOLICITUD/USUARIOSOLUCION"/>
					</xsl:when>
					<xsl:otherwise>
						[<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/>]
					</xsl:otherwise>
					</xsl:choose>
				</li>			
				<li>
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='propuesta']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='solucion']/node()"/>:</label>
					<xsl:choose>
					<xsl:when test="($usuario = 'CDC' or $usuarioMVM = 'MVM' or $adminCliente = 'ADMIN') and SOLICITUD/SC_IDESTADO != 'R'">
						<input type="hidden" name="SOLUCION_OLD" id="SOLUCION_OLD" value="{SOLICITUD/SC_SOLUCION}"/>
						<textarea name="SC_SOLUCION" id="SC_SOLUCION" rows="4" cols="60" maxlength="3000">
							<xsl:copy-of select="SOLICITUD/SC_SOLUCION/node()" disable-output-escaping="yes"/>
						</textarea>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="SOLICITUD/SC_SOLUCION/node()" disable-output-escaping="yes"/>
					</xsl:otherwise>
					</xsl:choose>
				</li>			
				<xsl:choose>
				<xsl:when test="($usuario = 'CDC' or $usuarioMVM = 'MVM' or $adminCliente = 'ADMIN') and SOLICITUD/SC_IDESTADO != 'R'">
					<li>
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_solucion']/node()"/>:</label>	
						<xsl:choose>
						<xsl:when test="SOLICITUD/DOCUMENTO_SOLUCION/ID">
						<span id="newDocSOL" align="center" style="display:none;">
							<a href="javascript:verCargaDoc('SOL');" title="Subir documento" style="text-decoration:none;">
								<img src="http://www.newco.dev.br/images/subirDocumento.gif" alt="Subir Documento" title="Subir Documento"/>
							</a>
						</span>&nbsp;
						<span id="docBoxSOL" align="center">
							<a href="http://www.newco.dev.br/Documentos/{SOLICITUD/DOCUMENTO_SOLUCION/URL}" target="_blank">
								<xsl:value-of select="SOLICITUD/DOCUMENTO_SOLUCION/NOMBRE"/>
							</a>
						</span>&nbsp;
						<span id="borraDocSOL" align="center">
							<a href="javascript:borrarDoc({SOLICITUD/DOCUMENTO_SOLUCION/ID},'SOL')">
								<img src="http://www.newco.dev.br/images/2022/icones/del.svg"/>
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
						<xsl:if test="SOLICITUD/DOCUMENTO_SOLUCION/ID">
							<li>
								<label><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_solucion']/node()"/>:</label>
								<a href="http://www.newco.dev.br/Documentos/{SOLICITUD/DOCUMENTO_SOLUCION/URL}" target="_blank">
									<xsl:value-of select="SOLICITUD/DOCUMENTO_SOLUCION/NOMBRE"/>
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
			<xsl:value-of select="SOLICITUD/SC_CODIGO"/>&nbsp;
            <xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_catalogacion']/node()"/>:
            &nbsp;<xsl:value-of select="SOLICITUD/SC_TITULO"/>
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
				<td colspan="2" class="textLeft"><textarea name="TEXTO" id="TEXTO" rows="4" cols="70" /></td>
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
				<td id="Respuesta" class="textLeft"></td>
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
		<table class="infoTable" border="0">
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
