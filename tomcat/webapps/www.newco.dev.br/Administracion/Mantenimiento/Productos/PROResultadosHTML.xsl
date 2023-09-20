<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Mantenimiento de productos de los catalogos de proveedores de MedicalVM
	(c) 30/8/2001 ET

	19abr07	ET	Permitimos modificar la marca desde este mantenimiento
 	Ultima revision ET 2ene17 09:52
-->
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
		<xsl:when test="/MantenimientoProductos/LANG"><xsl:value-of select="/MantenimientoProductos/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_de_productos']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style -->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROBuscador_230818.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/imagen.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/litebox.js"></script>-->

	<link rel="stylesheet" href="http://www.newco.dev.br/General/lightbox.css" type="text/css" media="screen"/>

	<script type="text/javascript">
		var isAdmin	= '<xsl:value-of select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/DERECHOS/@ADMIN"/>';
		var confirmPag	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='confirm_cambio_pagina']/node()"/>';
  </script>
</head>

<body>
<!--
	<xsl:attribute name="onLoad">
		<xsl:if test="//PRO_BUSQUEDA!=''">
			recargarPagina('<xsl:value-of select="//PRO_BUSQUEDA"/>');
		</xsl:if>
	</xsl:attribute>
-->
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/MantenimientoProductos/LANG"><xsl:value-of select="/MantenimientoProductos/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!-- ET Desactivado control errores: Habra que reactivarlo -->
	<xsl:choose>
	<xsl:when test="/MantenimientoProductos/DATOS/xsql-error">
		<xsl:apply-templates select="MantenimientoProductos/DATOS/xsql-error"/>
	</xsl:when>

	<xsl:when test="/MantenimientoProductos/DATOS/ROW/Sorry">
		<xsl:apply-templates select="MantenimientoProductos/DATOS/ROW/Sorry"/>
	</xsl:when>

	<xsl:otherwise>
		<form name="formResultados" method="POST">
			<!-- inputs hidden necesarios para cambiar de página manteniendo los criterios de búsqueda -->
			<input type="hidden" name="PRODUCTO" value="{/MantenimientoProductos/PRODUCTO}"/>
			<input type="hidden" name="IDCLIENTE" value="{/MantenimientoProductos/IDCLIENTE}"/>
			<input type="hidden" name="IDCLIENTES"/>
			<input type="hidden" name="FIDPROVEEDOR" value="{/MantenimientoProductos/FIDPROVEEDOR}"/>
			<input type="hidden" name="CAMBIOS"/>
			<input type="hidden" name="SINPRIVADOS" value="{/MantenimientoProductos/SINPRIVADOS}"/>
			<input type="hidden" name="SINEMPLANTILLAR" value="{/MantenimientoProductos/SINEMPLANTILLAR}"/>
			<input type="hidden" name="SOLODESTACADOS" value="{/MantenimientoProductos/SOLODESTACADOS}"/>
			<input type="hidden" name="MODIFICADOSPROV" value="{/MantenimientoProductos/MODIFICADOSPROV}"/>
			<input type="hidden" name="SOLOOCULTOS" value="{/MantenimientoProductos/SOLOOCULTOS}"/>
			<input type="hidden" name="SOLOVISIBLES" value="{/MantenimientoProductos/SOLOVISIBLES}"/>
			<input type="hidden" name="SOLOFARMACOS" value="{/MantenimientoProductos/SOLOFARMACOS}"/>
			<input type="hidden" name="SOLOFNCP" value="{/MantenimientoProductos/SOLOFNCP}"/>
			<input type="hidden" name="SOLORECOLETAS" value="{/MantenimientoProductos/SOLORECOLETAS}"/>
			<input type="hidden" name="RECHAZADOS" value="{/MantenimientoProductos/RECHAZADOS}"/>
			<input type="hidden" name="SINPRECIOMVM" value="{/MantenimientoProductos/SINPRECIOMVM}"/>
			<input type="hidden" name="SINOFERTAMVM" value="{/MantenimientoProductos/SINOFERTAMVM}"/>
			<input type="hidden" name="SINOFERTAFNCP" value="{/MantenimientoProductos/SINOFERTAFNCP}"/>
			<input type="hidden" name="ESPACK" value="{/MantenimientoProductos/ESPACK}"/>
			<input type="hidden" name="ENPACK" value="{/MantenimientoProductos/ENPACK}"/>
			<input type="hidden" name="DOC_OK" value="{/MantenimientoProductos/DOC_OK}"/>
			<input type="hidden" name="DOC_PEND_APROBAR" value="{/MantenimientoProductos/DOC_PEND_APROBAR}"/>
			<input type="hidden" name="DOC_PENDIENTE" value="{/MantenimientoProductos/DOC_PENDIENTE}"/>
			<input type="hidden" name="PAGINA" value="{/MantenimientoProductos/PAGINA}"/>

			<input type="hidden" name="ORDEN" value="{/MantenimientoProductos/ORDEN}"/>
			<input type="hidden" name="SENTIDO" value="{/MantenimientoProductos/SENTIDO}"/>
			<!-- FIN inputs hidden necesarios para el buscador -->

			<!-- inputs hidden necesarios para funcion de descartar cambios-->
			<input type="hidden" name="ELIMINAR_SOLICITUD"/>
			<input type="hidden" name="IDPAIS" value="{/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS}"/>
			<input type="hidden" name="IDPROVEEDOR" value="{/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDEMPRESA}"/>
			<input type="hidden" name="IDPRODUCTO_SOLICITUD"/>
			<!-- FIN inputs hidden necesarios para funcion de descartar cambios-->

			<input type="hidden" name="HISTORY" value="{/MantenimientoProductos/HISTORY}"/>
			<input type="hidden" name="ID_CLIENTE_ACTUAL" value="{/MantenimientoProductos/DATOS/LISTAPRODUCTOS/CLIENTES/field/@current}"/>
			<input type="hidden" name="ADMIN_MVM">
			<xsl:attribute name="value">
				<xsl:choose>
				<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM">si</xsl:when>
				<xsl:otherwise>no</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			</input>
			
			
			<!--	Titulo de la página		-->
			<div class="ZonaTituloPagina">
				<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_de_productos']/node()"/></span>
				<span class="CompletarTitulo">
					<xsl:value-of select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/MENSAJE"/>
				</span>
				</p>
				<p class="TituloPagina">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_de_productos']/node()"/>
					<span class="CompletarTitulo" style="width:380px;">
						<!--	Botones	-->
						<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINAANTERIOR">
							<a class="btnNormal" href="javascript:CambioPagina('ANTERIOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>&nbsp;
						</xsl:if>

                        <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/COMPRADOR">
						<a class="btnDestacado" href="javascript:Enviar(document.forms[1],document.forms[0],'ACTUALIZAR');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar']/node()"/>
						</a>&nbsp;
						</xsl:if>
						<!-- "Nuevo" ya está en el buscador principal
                    	<a class="btnDestacado" href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROManten.xsql','NuevoProducto', 100,80,0,0);">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
						</a>&nbsp;
						-->
						<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINASIGUIENTE">
							<a class="btnNormal" href="javascript:CambioPagina('SIGUIENTE');" title="siguiente"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>&nbsp;
						</xsl:if>
 					</span>
				</p>
			</div>
			<br/>
			<br/>
			<br/>
			

		<!--tabla productos-->
		<!-- si usuario admin mvm puede cambiar todo, admin cliente tb añadido 26-11-15 si es proveedor solo imagenes-->
		<xsl:choose>
		<!--<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN">-->
		<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/COMPRADOR">
			<xsl:choose>
			<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PRODUCTO">
				<xsl:call-template name="comprador"/>
			</xsl:when>
 	        	<xsl:otherwise>
				<div class="divLeft"><br /><br />
					<div class="divCenter30">
						<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_datos_que_mostrar']/node()"/>.</strong>
					</div><br /><br />
				</div>
			</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="proveedor"/>
		</xsl:otherwise>
		</xsl:choose>
        </form>
	</xsl:otherwise>
	</xsl:choose>

	<!--frame para las imagenes-->
	<div id="uploadFrameBox" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>

	<!--mensaje js-->
	<form name="MensajeJS">
		<input type="hidden" name="CRITERIO_BUSQUEDA" value="{document($doc)/translation/texts/item[@name='criterio_busqueda']/node()}"/>
		<input type="hidden" name="CRITERIO_BUSQUEDA_TEXT" value="{document($doc)/translation/texts/item[@name='criterio_busqueda_text']/node()}"/>
		<input type="hidden" name="CRITERIO_BUSQUEDA_TEXT1" value="{document($doc)/translation/texts/item[@name='criterio_busqueda_text1']/node()}"/>
		<input type="hidden" name="CRITERIO_BUSQUEDA_TEXT2" value="{document($doc)/translation/texts/item[@name='criterio_busqueda_text2']/node()}"/>
		<input type="hidden" name="CRITERIO_BUSQUEDA_TEXT3" value="{document($doc)/translation/texts/item[@name='criterio_busqueda_text3']/node()}"/>
		<input type="hidden" name="DESEA_EXPANDIR_PRECIOS" value="{document($doc)/translation/texts/item[@name='desea_expandir_precios']/node()}"/>
		<input type="hidden" name="SEGURO_ELIMINAR_IMAGEN" value="{document($doc)/translation/texts/item[@name='seguro_eliminar_imagen']/node()}"/>
		<input type="hidden" name="ERROR_CON_CLIENTE" value="{document($doc)/translation/texts/item[@name='error_con_cliente']/node()}"/>
		<input type="hidden" name="IDCLIENTE" value="{document($doc)/translation/texts/item[@name='idcliente']/node()}"/>
		<input type="hidden" name="EXPANDIDOS_NULOS" value="{document($doc)/translation/texts/item[@name='expandidos_nulos']/node()}"/>
		<input type="hidden" name="INTRODUZCA_CANTIDAD" value="{document($doc)/translation/texts/item[@name='introduzca_cantidad']/node()}"/>
		<input type="hidden" name="INTRODUZCA_CANTIDAD_CORRECTA" value="{document($doc)/translation/texts/item[@name='introduzca_cantidad_correcta']/node()}"/>
		<input type="hidden" name="INTRODUZCA_UNIDAD_BASE" value="{document($doc)/translation/texts/item[@name='introduzca_unidad_base']/node()}"/>
		<input type="hidden" name="INTRODUZCA_CANTIDAD_CORRECTA" value="{document($doc)/translation/texts/item[@name='introduzca_cantidad_correcta']/node()}"/>
		<input type="hidden" name="INTRODUZCA_CANTIDAD_CORRECTA" value="{document($doc)/translation/texts/item[@name='introduzca_cantidad_correcta']/node()}"/>
		<input type="hidden" name="INTRODUZCA_CANTIDAD_CORRECTA" value="{document($doc)/translation/texts/item[@name='introduzca_cantidad_correcta']/node()}"/>
		<input type="hidden" name="INTRODUZCA_CANTIDAD_CORRECTA" value="{document($doc)/translation/texts/item[@name='introduzca_cantidad_correcta']/node()}"/>
		<input type="hidden" name="INTRODUZCA_CANTIDAD_CORRECTA" value="{document($doc)/translation/texts/item[@name='introduzca_cantidad_correcta']/node()}"/>
		<input type="hidden" name="SOLICITUD_PENDIENTE" value="{document($doc)/translation/texts/item[@name='alarma_solicitud_pendiente']/node()}"/>
		<input type="hidden" name="SOLICITUD_DEVUELTA" value="{document($doc)/translation/texts/item[@name='alarma_solicitud_devuelta']/node()}"/>
	</form>

	<form name="ReloadForm" method="POST" >
		<input type="hidden" name="ADMIN_MVM">
		<xsl:attribute name="value">
			<xsl:choose>
			<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM">si</xsl:when>
			<xsl:otherwise>no</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		</input>
		<input type="hidden" name="PRODUCTO" value="{/MantenimientoProductos/PRODUCTO}"/>
		<input type="hidden" name="FIDPROVEEDOR" value="{/MantenimientoProductos/FIDPROVEEDOR}"/>
		<input type="hidden" name="IDCLIENTE" value="{/MantenimientoProductos/IDCLIENTE}"/>
		<input type="hidden" name="SINPRIVADOS" value="{/MantenimientoProductos/SINPRIVADOS}"/>
		<input type="hidden" name="SOLODESTACADOS" value="{/MantenimientoProductos/SOLODESTACADOS}"/>
		<input type="hidden" name="SOLOOCULTOS" value="{/MantenimientoProductos/SOLOOCULTOS}"/>
		<input type="hidden" name="SOLOVISIBLES" value="{/MantenimientoProductos/SOLOVISIBLES}"/>
		<input type="hidden" name="SOLOFARMACOS" value="{/MantenimientoProductos/SOLOFARMACOS}"/>
		<input type="hidden" name="MODIFICADOSPROV" value="{/MantenimientoProductos/MODIFICADOSPROV}"/>
		<input type="hidden" name="SINEMPLANTILLAR" value="{/MantenimientoProductos/SINEMPLANTILLAR}"/>
		<input type="hidden" name="SINPRECIOMVM" value="{/MantenimientoProductos/SINPRECIOMVM}"/>
		<!--<input type="hidden" name="PRECIOASISADIFERENTE" value="{/MantenimientoProductos/PRECIOASISADIFERENTE}"/>-->
		<input type="hidden" name="SINOFERTAMVM" value="{/MantenimientoProductos/SINOFERTAMVM}"/>
		<input type="hidden" name="SINOFERTAFNCP" value="{/MantenimientoProductos/SINOFERTAFNCP}"/>
		<!--<input type="hidden" name="SINOFERTATEKNON" value="{/MantenimientoProductos/SINOFERTATEKNON}"/>
		<input type="hidden" name="SINOFERTAASISA" value="{/MantenimientoProductos/SINOFERTAASISA}"/>
		<input type="hidden" name="SINOFERTAVIAMED" value="{/MantenimientoProductos/SINOFERTAVIAMED}"/>-->
		<input type="hidden" name="SINOFERTARECOLETAS" value="{/MantenimientoProductos/SINOFERTARECOLETAS}"/>
		<input type="hidden" name="PAGINA" value="{/MantenimientoProductos/PAGINA}"/>
		<input type="hidden" name="ORDEN" value="{/MantenimientoProductos/ORDEN}"/>
		<input type="hidden" name="SENTIDO" value="{/MantenimientoProductos/SENTIDO}"/>
		<input type="hidden" name="SOLOFNCP" value="{/MantenimientoProductos/SOLOFNCP}"/>
		<!--<input type="hidden" name="SOLOASISA" value="{/MantenimientoProductos/SOLOASISA}"/>
		<input type="hidden" name="SOLOTEKNON" value="{/MantenimientoProductos/SOLOTEKNON}"/>
		<input type="hidden" name="SOLOVIAMED" value="{/MantenimientoProductos/SOLOVIAMED}"/>-->
		<input type="hidden" name="SOLORECOLETAS" value="{/MantenimientoProductos/SOLORECOLETAS}"/>
		<input type="hidden" name="RECHAZADOS" value="{/MantenimientoProductos/RECHAZADOS}"/>
		<input type="hidden" name="ESPACK" value="{/MantenimientoProductos/ESPACK}"/>
		<input type="hidden" name="ENPACK" value="{/MantenimientoProductos/ENPACK}"/>

	</form>
</body>
</html>
</xsl:template>


<xsl:template name="comprador">
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/MantenimientoProductos/LANG"><xsl:value-of select="/MantenimientoProductos/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<!--productos normales-->
	<xsl:choose>
	<xsl:when test="not(/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/SOLOMODIFICADOSPROV)">
		<input type="hidden" name="IDPROVEEDOR"/>
		<input type="hidden" name="IDCLIENTE"/>
		<input type="hidden" name="IDPRODUCTO"/>

		<!--<table class="encuesta" border="0">-->
		<table class="buscador">
		<thead>
			<!--<tr class="lejenda">-->
			<!--
			<tr class="subTituloTabla">
				<th colspan="3" class="textLeft"><xsl:value-of select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/MENSAJE"/></th>
				<th colspan="4" align="left">
				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
					<p style="align:left; font-weight:normal; margin-left:5px;">
						<img src="http://www.newco.dev.br/images/cuadroRojo.gif"/>&nbsp;
						<span class="font11"><xsl:value-of select="document($doc)/translation/texts/item[@name='precios_diferentes']/node()"/></span>
					</p>
				</xsl:if>
				</th>
				<th colspan="9" class="textRight">
					<div class="boton">
                        <a href="javascript:Enviar(document.forms[1],document.forms[0],'ACTUALIZAR');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar']/node()"/>
						</a>
					</div>

				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINAANTERIOR">
					<a href="javascript:CambioPagina('ANTERIOR');"><img src="http://www.newco.dev.br/images/flechaLeft.gif"/></a>
					<a href="javascript:CambioPagina('ANTERIOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
				</xsl:if>

				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINASIGUIENTE">
					&nbsp;&nbsp;&nbsp;
					<a href="javascript:CambioPagina('SIGUIENTE');" title="siguiente"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
					<a href="javascript:CambioPagina('SIGUIENTE');" title="siguiente"><img src="http://www.newco.dev.br/images/flechaRight.gif"/></a>
				</xsl:if>
				</th>
			</tr>
			-->

			<!--<tr class="titulos">-->
			<tr class="subTituloTabla">
				<th class="dos"><a href="javascript:OrdenarPor('VALORDOC');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Cont']/node()"/></a></th>
				<th class="cinco"><a href="javascript:OrdenarPor('REFERENCIA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></a></th>
				<th class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='ima']/node()"/></th>
				<th align="left"><a href="javascript:OrdenarPor('PRODUCTO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a></th>
				<th align="left"><a href="javascript:OrdenarPor('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a></th>
				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM">
					<th class="diez"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado']/node()"/></th>
				</xsl:if>
				<th class="tres"><a href="javascript:OrdenarPor('MARCA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></a></th>
				<th class="cinco"><a href="javascript:OrdenarPor('DOCS');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Docs']/node()"/></a></th>
				<th class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_base']/node()"/></th>
				<th class="tres"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ud_por_caja_2line']/node()"/></th>
				<th class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></th>
				<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>
				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM">
					<br /><xsl:value-of select="document($doc)/translation/texts/item[@name='mvm']/node()"/>
				</xsl:if>
				</th>

				<!--precio fncp, recoletas -->
				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
					<th class="cuatro"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_fncp']/node()"/></th>
					<th class="cuatro"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_recoletas']/node()"/></th>
				</xsl:if>

				<th class="dos"><a href="javascript:OrdenarPor('CONSUMO');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></a></th>
				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM">
					<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='bor']/node()"/><br /><a href="javascript:SelTodosBorrar();"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></a></th>
				</xsl:if>
<!--				<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='cop']/node()"/></th>

				<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='dest']/node()"/><br /><a href="javascript:SelTodosDestacados();"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></a></th>
				<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='ocu']/node()"/><br /><a href="javascript:SelTodosOcultos();"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></a></th>
-->
			</tr>
		</thead>
		<!--	Cuerpo de la tabla	-->
		<tbody>
		<xsl:for-each select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PRODUCTO">
			<tr><!--<xsl:if test="OCULTO = 'S'">
					<xsl:attribute name="class">ocultoTR</xsl:attribute>
				</xsl:if>-->
				<td class="center">
					<xsl:choose>
    	  			<xsl:when test="NIVELDOCUMENTACION='V'">
						<xsl:attribute name="style">background:#4E9A06;</xsl:attribute>
					</xsl:when>
    	  			<xsl:when test="NIVELDOCUMENTACION='A'">
						<xsl:attribute name="style">background:#F57900;</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="style">background:#CC0000;</xsl:attribute>
					</xsl:otherwise>
    	 			</xsl:choose>
					<xsl:value-of select="CONTADOR"/>
				</td>
				<td class="center">
					<strong>
					<a>
						<!--<xsl:attribute name="href">javascript:soloUnProd('<xsl:value-of select="REFERENCIA"/>');</xsl:attribute>-->
						<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROManten.xsql?PRO_ID=<xsl:value-of select="IDPRODUCTO"/>&amp;TIPO=M&amp;PRO_BUSQUEDA=<xsl:value-of select="//LISTAPRODUCTOS/BUSQUEDA/PRODUCTO"/>&amp;IDCLIENTE=<xsl:value-of select="//LISTAPRODUCTOS/BUSQUEDA/IDCLIENTE"/>&amp;HISTORY='+obtenerHistoria(),'Mantenimiento Producto - <xsl:value-of select="IDPRODUCTO"/>',100,80,0,0);</xsl:attribute>
						<xsl:value-of select="REFERENCIA"/>
					</a>
					</strong>
				</td>

				<td>
				<xsl:if test="(count(IMAGENES/IMAGEN)) &gt; 0">
					<xsl:variable name="idRef" select="REFERENCIA"/>
					<img src="../../../images/fotoListadoPeq.gif" alt="con foto" id="{$idRef}" onmouseover="verFoto('{$idRef}');" onmouseout="verFoto('{$idRef}');"/>
					<div id="verFotoPro_{$idRef}" class="divFotoProBusca" style="display:none;">
						<xsl:for-each select="IMAGENES/IMAGEN">
							<xsl:if test="@id != '-1'">
								<img src="http://www.newco.dev.br/Fotos/{@peq}"/>
							</xsl:if>
						</xsl:for-each>
					</div>
				</xsl:if>
				</td>

				<td class="textLeft">
					<strong>
						<a>
							<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROManten.xsql?PRO_ID=<xsl:value-of select="IDPRODUCTO"/>&amp;TIPO=M&amp;PRO_BUSQUEDA=<xsl:value-of select="//LISTAPRODUCTOS/BUSQUEDA/PRODUCTO"/>&amp;IDCLIENTE=<xsl:value-of select="//LISTAPRODUCTOS/BUSQUEDA/IDCLIENTE"/>&amp;HISTORY='+obtenerHistoria(),'Mantenimiento Producto - <xsl:value-of select="IDPRODUCTO"/>',100,80,0,0);</xsl:attribute>
							<xsl:value-of select="NOMBRE"/>
						</a>
					</strong>

        			  <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducido.xsql?PRO_ID={IDPRODUCTO}','Ficha Catalogación',100,100,0,0);" title="Catalogar">
            			<img src="http://www.newco.dev.br/images/catalogo.gif" alt="Catalogar" />
        			  </a>
				</td>

				<td class="textLeft">
					<a>
						<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="IDPROVEEDOR"/>&amp;VENTANA=NUEVA','DetalleEmpresa',100,80,0,0)</xsl:attribute>
						<xsl:value-of select="PROVEEDOR"/>
					</a>
				</td>

				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM">
					<td class="center">
					<xsl:choose>
					<xsl:when test="./CLIENTESADJ/field/dropDownList/listElem[2]">
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="./CLIENTESADJ/field"/>
							<!--<xsl:with-param name="claSel">select120</xsl:with-param>-->
							<xsl:with-param name="claSel">medio</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='ninguna_clinica']/node()"/>
					</xsl:otherwise>
					</xsl:choose>
					</td>
				</xsl:if>

				<td class="center">
                    <input type="hidden" >
						<xsl:attribute name="name">MARCA_<xsl:value-of select="IDPRODUCTO"/>_OLD</xsl:attribute>
						<xsl:attribute name="value"><xsl:value-of select="MARCA"/></xsl:attribute>
					</input>
					<input type="text" class="peq" maxlength="100" size="10">
						<xsl:attribute name="name">MARCA_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
						<xsl:attribute name="value"><xsl:value-of select="MARCA"/></xsl:attribute>
					</input>
				</td>

				<td class="center">
					<xsl:value-of select="NUMDOCUMENTOS"/>&nbsp;
				</td>


				<td class="center">
					<input type="hidden" maxlength="100" size="13" class="inright">
						<xsl:attribute name="name">UNIDADBASICA_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
						<xsl:attribute name="value"><xsl:value-of select="UNIDADBASICA"/></xsl:attribute>
					</input>
					<xsl:value-of select="UNIDADBASICA"/>
				</td>

				<td class="center">
                	<input type="hidden" maxlength="10" size="4" class="inright">
						<xsl:attribute name="name">UNIDADESPORLOTE_<xsl:value-of select="IDPRODUCTO"/>_OLD</xsl:attribute>
						<xsl:attribute name="value"><xsl:value-of select="UNIDADESPORLOTE"/></xsl:attribute>
					</input>
					<xsl:choose>
						<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM">
							<input type="text" class="inright peq" maxlength="10" size="4">
								<xsl:attribute name="name">UNIDADESPORLOTE_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
								<xsl:attribute name="value"><xsl:value-of select="UNIDADESPORLOTE"/></xsl:attribute>
								<xsl:attribute name="onBlur">esEntero(this);</xsl:attribute>
							</input>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="UNIDADESPORLOTE"/>
						</xsl:otherwise>
					</xsl:choose><!--fin checkbox borrar-->
				</td>

				<td class="center">
                    <input type="hidden">
						<xsl:attribute name="name">IDTIPOIVA_<xsl:value-of select="IDPRODUCTO"/>_OLD</xsl:attribute>
						<xsl:attribute name="value"><xsl:value-of select="IVA/field/@current"/></xsl:attribute>
					</input>
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="IVA/field"/>
						<xsl:with-param name="claSel">peq</xsl:with-param>
					</xsl:call-template>
				</td>

<!--x de expansion
				<td>
				<xsl:choose>
				<xsl:when test="TARIFA/ORIGEN='E' or TARIFA/ORIGEN='I' or TARIFA/ORIGEN='X'">
					*<xsl:value-of select="TARIFA/ORIGEN"/>*
				</xsl:when>
				<xsl:otherwise>
					&nbsp;
				</xsl:otherwise>
				</xsl:choose>
				</td>-->

				<td align="right">
					<xsl:choose>
					<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM">
						<input type="hidden" maxlength="10" size="8" class="inright">
							<xsl:attribute name="name">TARIFA_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
							<xsl:attribute name="value"><xsl:value-of select="TARIFAPRIVADA_MVM"/></xsl:attribute>
						</input>
						<input type="hidden" maxlength="10" size="8" class="inright">
							<xsl:attribute name="name">BACKUPTARIFA_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
							<xsl:attribute name="value"><xsl:value-of select="TARIFAPRIVADA_MVM"/></xsl:attribute>
						</input>

						<!--si precios emplantillados veo precio, si no bola ambar con title precio 18-12-12-->
						<xsl:if test="TARIFAPRIVADA_MVM">
							<xsl:choose>
							<xsl:when test="MVM_TARIFA_ALTA">
								<span class="fondoRojo"><xsl:value-of select="TARIFAPRIVADA_MVM"/></span>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="TARIFAPRIVADA_MVM"/>
							</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<!--si precios emplantillados veo precio, si no bola ambar con title precio 18-12-12-->
						<xsl:if test="TARIFAPRIVADA_DIV">
								<xsl:value-of select="TARIFAPRIVADA_DIV"/>
						</xsl:if>
					</xsl:otherwise>
					</xsl:choose>
				</td>

				<!-- <td>
					check expansion
					<xsl:choose>
					<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/CLIENTES/field/@current=1">
						<input type="checkbox" name="EXPANDIR_{IDPRODUCTO}"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="checkbox" name="EXPANDIR_{IDPRODUCTO}">
							<xsl:choose>
							<xsl:when test="TARIFA/ORIGEN='E' or TARIFA/ORIGEN='I'">
								<xsl:attribute name="checked">checked</xsl:attribute>
								<xsl:attribute name="onClick">ExpandirNOExpandir(document.forms['Productos'],this,'ANTERIOR');</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="onClick">ExpandirNOExpandir(document.forms['Productos'],this,'MVM');</xsl:attribute>
							</xsl:otherwise>
							</xsl:choose>
						</input>
					</xsl:otherwise>
					</xsl:choose>
				</td> -->

				<input type="hidden" name="EXPANDIR_{IDPRODUCTO}" value="N"/>

			<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">

				<!--precio fncp-->
				<td class="center">
					<xsl:if test="TARIFAPRIVADA_FNCP">
							<xsl:choose>
							<xsl:when test="FNCP_TARIFA_ALTA">
								<span class="fondoRojo"><xsl:value-of select="TARIFAPRIVADA_FNCP"/></span>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="TARIFAPRIVADA_FNCP"/>
							</xsl:otherwise>
							</xsl:choose>
					</xsl:if>
				</td><!--fin de precio fncp-->

				<!--precio viamed- ->
				<td class="center">
					<xsl:if test="TARIFAPRIVADA_VIAMED">
							<xsl:choose>
							<xsl:when test="VIAMED_TARIFA_ALTA">
								<span class="fondoRojo"><xsl:value-of select="TARIFAPRIVADA_VIAMED"/></span>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="TARIFAPRIVADA_VIAMED"/>
							</xsl:otherwise>
							</xsl:choose>
					</xsl:if>
				</td><!- -fin de precio viamed-->
				<!--precio recoletas-->
				<td class="center">
					<xsl:if test="TARIFAPRIVADA_RECOLETAS">
							<xsl:choose>
							<xsl:when test="RECOLETAS_TARIFA_ALTA">
								<span class="fondoRojo"><xsl:value-of select="TARIFAPRIVADA_RECOLETAS"/></span>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="TARIFAPRIVADA_RECOLETAS"/>
							</xsl:otherwise>
							</xsl:choose>
					</xsl:if>
				</td><!--fin de precio recoletas-->

			</xsl:if><!--fin if si es españa-->


				<td class="center" align="right">&nbsp;<xsl:value-of select="CONSUMO"/>&nbsp;</td>

				<xsl:choose>
					<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM">
						<td class="center">
							<input type="checkbox" class="muypeq">
								<xsl:attribute name="name">BORRAR_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
							</input>
						</td>
					</xsl:when>
					<xsl:otherwise>
						<input type="hidden" class="muypeq" name="BORRAR_{IDPRODUCTO}"/>
					</xsl:otherwise>
				</xsl:choose><!--fin checkbox borrar-->


					<input type="checkbox" style="display:none;">
						<xsl:attribute name="name">COPIAR_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
					</input>

					<input type="checkbox" class="destInput" style="display:none;">
						<xsl:if test="DESTACADO = 'S'">
							<xsl:attribute name="checked">checked</xsl:attribute>
						</xsl:if>

						<xsl:attribute name="name">DESTACAR_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
					</input>

					<input type="checkbox" class="destInput" style="display:none;">
						<xsl:if test="OCULTO = 'S'">
							<xsl:attribute name="checked">checked</xsl:attribute>
						</xsl:if>

						<xsl:attribute name="name">OCULTAR_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
					</input>

<!--
                                <td class="center"></td>
				<td class="center">
					<input type="checkbox" class="destInput">
						<xsl:if test="DESTACADO = 'S'">
							<xsl:attribute name="checked">checked</xsl:attribute>
						</xsl:if>

						<xsl:attribute name="name">DESTACAR_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
					</input>
				</td>

				<td class="center">
					<input type="checkbox" class="destInput">
						<xsl:if test="OCULTO = 'S'">
							<xsl:attribute name="checked">checked</xsl:attribute>
						</xsl:if>

						<xsl:attribute name="name">OCULTAR_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
					</input>
				</td>
-->
			</tr>
		</xsl:for-each>
		</tbody>

		<tr class="subTituloTabla">
			<th class="dos"><a href="javascript:OrdenarPor('VALORDOC');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Cont']/node()"/></a></th>
			<th class="cinco"><a href="javascript:OrdenarPor('REFERENCIA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></a></th>
			<th class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='ima']/node()"/></th>
			<th align="left"><a href="javascript:OrdenarPor('PRODUCTO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a></th>
			<th align="left"><a href="javascript:OrdenarPor('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a></th>
			<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM">
				<th class="diez"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado']/node()"/></th>
			</xsl:if>
			<th class="tres"><a href="javascript:OrdenarPor('MARCA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></a></th>
			<th class="cinco"><a href="javascript:OrdenarPor('DOCS');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Docs']/node()"/></a></th>
			<th class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_base']/node()"/></th>
			<th class="tres"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ud_por_caja_2line']/node()"/></th>
			<th class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></th>
			<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>
			<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM">
				<br /><xsl:value-of select="document($doc)/translation/texts/item[@name='mvm']/node()"/>
			</xsl:if>
			</th>

			<!--precio fncp, recoletas -->
			<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
				<th class="cuatro"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_fncp']/node()"/></th>
				<th class="cuatro"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_recoletas']/node()"/></th>
			</xsl:if>

			<th class="dos"><a href="javascript:OrdenarPor('CONSUMO');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></a></th>
			<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM">
				<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='bor']/node()"/><br /><a href="javascript:SelTodosBorrar();"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></a></th>
			</xsl:if>


<!--				<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='cop']/node()"/></th>

			<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='dest']/node()"/><br /><a href="javascript:SelTodosDestacados();"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></a></th>
			<th class="uno"><xsl:value-of select="document($doc)/translation/texts/item[@name='ocu']/node()"/><br /><a href="javascript:SelTodosOcultos();"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></a></th>
-->
		</tr>

<!--		<tfoot>
			<tr class="lejenda">
				<th colspan="7" class="textLeft"><xsl:value-of select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/MENSAJE"/></th>
				<th colspan="9" class="textRight">
					<div class="boton">
						<a href="javascript:Enviar(document.forms[1],document.forms[0],'ACTUALIZAR');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar']/node()"/>
						</a>
					</div>

				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINAANTERIOR">
					<a href="javascript:CambioPagina('ANTERIOR');"><img src="http://www.newco.dev.br/images/flechaLeft.gif"/></a>
					<a href="javascript:CambioPagina('ANTERIOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
				</xsl:if>

				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINASIGUIENTE">
					&nbsp;&nbsp;&nbsp;
					<a href="javascript:CambioPagina('SIGUIENTE');" title="siguiente"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
					<a href="javascript:CambioPagina('SIGUIENTE');" title="siguiente"><img src="http://www.newco.dev.br/images/flechaRight.gif" /></a>
				</xsl:if>
				</th>
			</tr>
		</tfoot>-->
		</table>
	</xsl:when>
	<xsl:otherwise>
		<!--solicitudes de proveedores-->
		<!--productos nuevos o modificado del proveedor mvm acepta o no
        <input type="hidden" name="US_ID_CAMBIO" value="{//LISTAPRODUCTOS/IDCLIENTE}"/>-->
		<input type="hidden" name="CAMBIOS_PROVE"/>


		<table class="buscador">
		<thead>
			<tr class="lejenda">
				<td colspan="5">
					<p style="align:left; font-weight:normal; margin-left:5px;">
						<img src="http://www.newco.dev.br/images/cuadroRojo.gif" />&nbsp;
						<span class="font11"><xsl:value-of select="document($doc)/translation/texts/item[@name='precios_diferentes']/node()"/></span>
					</p>
				</td>
				<td colspan="3">
				<!--
					<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
						<p style="align:left; font-weight:normal; margin-left:5px;">
							&nbsp;<span class="verde">V</span>&nbsp;&nbsp;
							<span class="font11"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado_viamed']/node()"/></span>
							<br />
							&nbsp;<span class="verde">F</span>&nbsp;&nbsp;
							<span class="font11"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado_fncp']/node()"/></span>
						</p>
					</xsl:if>
					-->
				</td>
				<td colspan="3">
					&nbsp;
				</td>
				<td colspan="5">
					<div class="boton">
						<a href="PROManten.xsql"><xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_producto']/node()"/></a>
					</div>
				</td>
				<td colspan="2">&nbsp;</td>
				<td colspan="2">
					<div class="boton">
						<a href="javascript:AceptarCambios(document.forms['formResultados'])"><xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar_cambios']/node()"/></a>
					</div>
				</td>
			</tr>

			<tr class="lejenda">
				<th colspan="10" class="textLeft">
					<xsl:value-of select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/MENSAJE"/>
				</th>
				<th colspan="10" class="textRight">
					<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINAANTERIOR">
						<a href="javascript:CambioPagina('ANTERIOR');"><img src="http://www.newco.dev.br/images/flechaLeft.gif"/></a>
						<a href="javascript:CambioPagina('ANTERIOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
					</xsl:if>
					<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINASIGUIENTE">
						&nbsp;&nbsp;&nbsp;
						<a href="javascript:CambioPagina('SIGUIENTE');" title="siguiente"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
						<a href="javascript:CambioPagina('SIGUIENTE');" title="siguiente"><img src="http://www.newco.dev.br/images/flechaRight.gif" /></a>
					</xsl:if>
				</th>
			</tr>

			<tr class="titulos">
				<th class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='contador']/node()"/></th>
				<th class="seis"><a href="javascript:OrdenarPor('REFERENCIA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></a></th>
				<th class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='ima']/node()"/></th>
				<th class="dos"></th>
				<th class="quince"><a href="javascript:OrdenarPor('PRODUCTO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a></th>
				<th class="ocho"><a href="javascript:OrdenarPor('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a></th>
				<th class="cinco"><a href="javascript:OrdenarPor('MARCA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></a></th>
				<th class="cinco"><a href="javascript:OrdenarPor('DOCS');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Docs']/node()"/></a></th>
				<th class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_base']/node()"/></th>
				<th class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ud_por_caja_2line']/node()"/></th>
				<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></th>

			<!--precio anterior mvm-->
			<xsl:choose>
			<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
				<th class="uno">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='anterior_mvm']/node()"/>
				</th>
			</xsl:when>
			<xsl:otherwise>
				<th class="cinco">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_anterior']/node()"/>
				</th>
			</xsl:otherwise>
			</xsl:choose>

			<!--precio propuesto, si españa(34) no enseño, proveedores ya no pueden cambiar precio mvm, si brasil enseño, solo un precio-->
			<xsl:choose>
			<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
				<th class="uno">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='propuesto_mvm']/node()"/>
				</th>
			</xsl:when>
			<xsl:otherwise>
				<th class="cinco">
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_propuesto']/node()"/>
				</th>
			</xsl:otherwise>
			</xsl:choose>

			<!--precio asisa solo si españa-->
			<xsl:choose>
			<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
				<th class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='anterior_fncp']/node()"/></th>
				<th class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='propuesto_fncp']/node()"/></th>
				<th class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='anterior_viamed']/node()"/></th>
				<th class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='propuesto_viamed']/node()"/></th>
			</xsl:when>
			<xsl:otherwise>
				<th colspan="4" class="uno"></th>
			</xsl:otherwise>
			</xsl:choose>

				<!--columna para cambios de ficha tecnica o oferta-->
				<th class="tres">&nbsp;</th>
				<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='acep']/node()"/><br /><a href="javascript:SelTodosAceptar();"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></a></th>
				<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='rechazar']/node()"/><br /><a href="javascript:SelTodosCancelar();"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></a></th>
				<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/></th>
			</tr>
		</thead>

		<!--	Cuerpo de la tabla	-->
		<tbody>
		<xsl:for-each select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PRODUCTO">
			<input type="hidden" name="IDPROD_{IDPRODUCTO}" value="{IDPRODUCTO}"/>
			<tr>
				<td class="center">
					<xsl:choose>
    	  			<xsl:when test="COLOR='VERDE'">
						<xsl:attribute name="style">background:#4E9A06;</xsl:attribute>
					</xsl:when>
    	  			<xsl:when test="COLOR='NARANJA'">
						<xsl:attribute name="style">background:#F57900;</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="style">background:#CC0000;</xsl:attribute>
					</xsl:otherwise>
    	 			</xsl:choose>
					<xsl:value-of select="CONTADOR"/>
				</td>
				<td class="center">
					<p>
						<xsl:attribute name="class"><xsl:if test="CAMBIOS/REFERENCIA">amarillo</xsl:if> </xsl:attribute>
						<xsl:value-of select="REFERENCIA"/>
					</p>
				</td>
				<td>
					<xsl:if test="(count(IMAGENES/IMAGEN)) &gt; 0">
						<xsl:variable name="idRef" select="REFERENCIA"/>
						<p>
							<xsl:attribute name="class"><xsl:if test="CAMBIOS/NOMBRE">amarillo</xsl:if></xsl:attribute>
							<img src="../../../images/fotoListadoPeq.gif" alt="con foto" id="{$idRef}" onmouseover="verFoto('{$idRef}');" onmouseout="verFoto('{$idRef}');"/>
						</p>

						<div id="verFotoPro_{$idRef}" class="divFotoProBusca" style="display:none;">
						<xsl:for-each select="IMAGENES/IMAGEN">
							<xsl:if test="@id != '-1'">
								<img src="http://www.newco.dev.br/Fotos/{@peq}"/>
							</xsl:if>
						</xsl:for-each>
						</div>
					</xsl:if>
				</td>
				<td>
					<xsl:if test="ESTADO = 'X'">
						<img src="http://www.newco.dev.br/images/basura.gif" alt="Eliminar prod" title="eliminar"/>
					</xsl:if>
				</td>
				<td class="textLeft">
					<strong>
						<a>
							<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="IDPRODUCTO"/>','producto',100,80,0,0);</xsl:attribute>
							<xsl:attribute name="class"><xsl:if test="CAMBIOS/NOMBRE">amarillo</xsl:if></xsl:attribute>
							<xsl:value-of select="NOMBRE"/>
						</a>
					</strong>
				</td>
				<td class="center">
					<a>
						<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="IDPROVEEDOR"/>&amp;VENTANA=NUEVA','DetalleEmpresa',100,80,0,0)</xsl:attribute>
						<xsl:value-of select="PROVEEDOR"/>&nbsp;
					</a>
				</td>
				<td class="center">
					<p>
						<xsl:attribute name="class"><xsl:if test="CAMBIOS/MARCA">amarillo</xsl:if> </xsl:attribute>
						<xsl:value-of select="MARCA"/>&nbsp;
					</p>
				</td>
				<td class="center">
					<p>
						<xsl:attribute name="class"><xsl:if test="CAMBIOS/NUMDOCUMENTOS">amarillo</xsl:if> </xsl:attribute>
						<xsl:value-of select="NUMDOCUMENTOS"/>&nbsp;
					</p>
				</td>
				<td class="center">
					<p>
						<!--<xsl:attribute name="class"><xsl:if test="CAMBIOS/UNIDADBASICA">amarillo</xsl:if></xsl:attribute>-->
						<xsl:value-of select="UNIDADBASICA"/>
					</p>
				</td>
				<td class="center">
					<p>
						<xsl:attribute name="class"><xsl:if test="CAMBIOS/UNIDADESPORLOTE">amarillo</xsl:if></xsl:attribute>
						<xsl:value-of select="UNIDADESPORLOTE"/>
					</p>
				</td>
				<td class="center">
					<p>
						<xsl:attribute name="class"><xsl:if test="CAMBIOS/TIPOIVA">amarillo</xsl:if></xsl:attribute>
						<xsl:for-each select="IVA/field/dropDownList/listElem">
							<xsl:if test="ID=../../@current">
								<xsl:value-of select="listItem"/>
							</xsl:if>
						</xsl:for-each>
					</p>
				</td>
				<td class="center">
					<xsl:value-of select="TARIFAORIGINAL_MVM"/>
				</td>
				<td class="center">
						<!--precio propuesto si igual al anterior no escribo, si sube rojo, si baja verde-->
						<xsl:choose>
						<xsl:when test="MANTIENE_TARIFA">
							&nbsp;
						</xsl:when>
						<xsl:when test="SUBIDA_TARIFA">
							<img src="http://www.newco.dev.br/images/order_a_rojo.gif"/>
							<!--<span class="rojoNormal"><xsl:value-of select="TARIFAPRIVADA_DIV"/></span>-->
						</xsl:when>
						<xsl:when test="BAJADA_TARIFA">
							<img src="http://www.newco.dev.br/images/order_d_verde.gif"/>
						</xsl:when>
						</xsl:choose>
						<xsl:value-of select="TARIFAPRIVADA_DIV"/>
				</td>

				<!--precio anterior fncp solo si españa-->
				<td class="center">
					<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
						<xsl:value-of select="TARIFAORIGINAL_FNCP"/>
					</xsl:if>
				</td>

				<!--precio FNCP solo si españa-->
				<td class="center">
					<xsl:choose>
					<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
						<xsl:choose>
						<xsl:when test="MANTIENE_TARIFA_FNCP">
							&nbsp;
						</xsl:when>
						<xsl:when test="SUBIDA_TARIFA_FNCP">
							<img src="http://www.newco.dev.br/images/order_a_rojo.gif"/>
						</xsl:when>
						<xsl:when test="BAJADA_TARIFA_FNCP">
							<img src="http://www.newco.dev.br/images/order_d_verde.gif"/>
						</xsl:when>
						</xsl:choose>

						<!--precio asisa si differente de mvm rojo-->
						<xsl:choose>
						<xsl:when test="TARIFAPRIVADA_DIV != TARIFAPRIVADA_FNCP">
							<span class="fondoRojo"><xsl:value-of select="TARIFAPRIVADA_FNCP"/></span>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="TARIFAPRIVADA_FNCP"/>
						</xsl:otherwise>
						</xsl:choose>
						<!--fin precio FNCP si differente de mvm amarillo-->
					</xsl:when>
					</xsl:choose>

					<xsl:if test="CAMBIOS/EMPLANTILLADO_EN_FNCP">&nbsp;<strong><span class="verde">F</span></strong></xsl:if>
				</td>

				<!--precio anterior viamed solo si españa-->
				<td class="center">
					<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
						<xsl:value-of select="TARIFAORIGINAL_VIAMED"/>
					</xsl:if>
				</td>

				<!--precio viamed solo si españa-->
				<td class="center">
					<xsl:choose>
					<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
						<xsl:choose>
						<xsl:when test="MANTIENE_TARIFA_VIAMED">
							&nbsp;
						</xsl:when>
						<xsl:when test="SUBIDA_TARIFA_VIAMED">
							<img src="http://www.newco.dev.br/images/order_a_rojo.gif"/>
						</xsl:when>
						<xsl:when test="BAJADA_TARIFA_VIAMED">
							<img src="http://www.newco.dev.br/images/order_d_verde.gif"/>
						</xsl:when>
						</xsl:choose>

						<!--precio VIAMED si diferente de mvm rojo-->
						<xsl:choose>
						<xsl:when test="TARIFAPRIVADA_DIV != TARIFAPRIVADA_VIAMED">
							<span class="fondoRojo"><xsl:value-of select="TARIFAPRIVADA_VIAMED"/></span>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="TARIFAPRIVADA_VIAMED"/>
						</xsl:otherwise>
						</xsl:choose>
						<!--fin precio VIAMED si differente de mvm amarillo-->
					</xsl:when>
					</xsl:choose>

					<xsl:if test="CAMBIOS/EMPLANTILLADO_EN_VIAMED">&nbsp;<strong><span class="verde">V</span></strong></xsl:if>
				</td>


				<!--cambios en ficha tecnica o en oferta-->
				<td>
					<!--2-10-13 solo para brasil, proveedores no pueden poner precio u ofertas mvm en españa-->
					<xsl:if test="CAMBIOS/OFERTA and /MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '55'">
						<img src="http://www.newco.dev.br/images/ofertaChange.gif" alt="Cambio de oferta"/>
					</xsl:if>
					<xsl:if test="CAMBIOS/FICHATECNICA">
						<img src="http://www.newco.dev.br/images/fichaChange.gif" alt="Cambio de ficha técnica"/>
					</xsl:if>
					<xsl:if test="CAMBIOS/OFERTAFNCP">
						<img src="http://www.newco.dev.br/images/ofertaFNCPChange.gif" alt="Cambio de oferta FNCP"/>
					</xsl:if>
					<xsl:if test="CAMBIOS/OFERTAVIAMED">
						<img src="http://www.newco.dev.br/images/ofertaViamedChange.gif" alt="Cambio de oferta Viamed"/>
					</xsl:if>
				</td>

				<td class="center">
					<input type="checkbox" onclick="RevisarOpciones(document.forms['formResultados'], {IDPRODUCTO},'ACEPTAR');">
						<xsl:attribute name="name">ACEPTAR_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
					</input>
				</td>

				<td class="center">
					<input type="checkbox" onclick="RevisarOpciones(document.forms['formResultados'], {IDPRODUCTO},'CANCELAR');">
						<xsl:attribute name="name">CANCELAR_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
					</input>
				</td>

				<td class="center">
					<input size="15">
						<xsl:attribute name="name">COMENTARIO_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
					</input>
				</td>
			</tr>
		</xsl:for-each>
		</tbody>

		<tfoot>
			<tr class="lejenda">
				<th colspan="10" class="textLeft"><xsl:value-of select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/MENSAJE"/></th>
				<th colspan="10" class="textRight">
					<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINAANTERIOR">
						<a href="javascript:CambioPagina('ANTERIOR');"><img src="http://www.newco.dev.br/images/flechaLeft.gif"/></a>
						<a href="javascript:CambioPagina('ANTERIOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
					</xsl:if>
					<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINASIGUIENTE">
						&nbsp;&nbsp;&nbsp;
						<a href="javascript:CambioPagina('SIGUIENTE');" title="siguiente"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
						<a href="javascript:CambioPagina('SIGUIENTE');" title="siguiente"><img src="http://www.newco.dev.br/images/flechaRight.gif"/></a>
					</xsl:if>
				</th>
			</tr>

		<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVMB">
			<tr class="lejenda">
				<td colspan="14">&nbsp;</td>
				<td colspan="4">&nbsp; </td>
				<td colspan="2">
					<div class="boton">
						<a href="javascript:AceptarCambios(document.forms['formResultados'])"><xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar_cambios']/node()"/></a>
					</div>
				</td>
			</tr>
		</xsl:if>
		</tfoot>
		</table>
	</xsl:otherwise>
	</xsl:choose>
</xsl:template><!--fin de adminMVM-->

<xsl:template name="proveedor">
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/MantenimientoProductos/LANG"><xsl:value-of select="/MantenimientoProductos/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<input type="hidden" name="CADENA_IMAGENES"/>
	<input type="hidden" name="IMAGENES_BORRADAS"/>
	<input type="hidden" name="US_ID"/>
	<input type="hidden" name="PRO_ID"/>

	<table class="buscador">
	<thead>
		<tr class="lejenda">
			<th colspan="3" class="textLeft"><xsl:value-of select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/MENSAJE"/></th>
			<th colspan="2" align="left">
			<!--
				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
					<p style="align:left; font-weight:normal; margin-left:5px;">
						<img src="http://www.newco.dev.br/images/cuadroRojo.gif"/>&nbsp;
						<span class="font11"><xsl:value-of select="document($doc)/translation/texts/item[@name='precios_diferentes']/node()"/></span>
					</p>
				</xsl:if>
			-->
			</th>
			<th colspan="2" align="left">
			<!--
				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
					<p style="align:left; font-weight:normal; margin-left:5px;">
						&nbsp;<span class="verde">V</span>&nbsp;&nbsp;
						<span class="font11"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado_viamed']/node()"/></span>
						<br />
						&nbsp;<span class="verde">F</span>&nbsp;&nbsp;
						<span class="font11"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado_fncp']/node()"/></span>
					</p>
				</xsl:if>
			-->
				<p style="align:left; font-weight:normal;">
					<span style="color:#FF9900; font-weight:bold;">P</span>&nbsp;
					<span class="font11"><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_pendiente']/node()"/></span>
				</p>
			</th>
			<th colspan="3">
				<p style="align:left; font-weight:normal;">
					&nbsp;<span style="color:#FF9900; font-weight:bold;">D</span>&nbsp;
					<span class="font11"><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_rechazada']/node()"/></span>
				</p>
			</th>
			<th colspan="5" class="textRight">
				<!--
				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINAANTERIOR">
					<a href="javascript:CambioPagina('ANTERIOR');" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/flechaLeft.gif"/></a>&nbsp;
					<a href="javascript:CambioPagina('ANTERIOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
				</xsl:if>
				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINASIGUIENTE">
					&nbsp;&nbsp;&nbsp;
					<a href="javascript:CambioPagina('SIGUIENTE');"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>&nbsp;
					<a href="javascript:CambioPagina('SIGUIENTE');" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/flechaRight.gif"/></a>
				</xsl:if>
				-->
			</th>
		</tr>

	<!--eliminación de solicitudes parte proveedor-->
	<xsl:choose>
	<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/RECHAZADOS and /MantenimientoProductos/DATOS/OK">
		<tr class="titulos">
			<td colspan="20" align="center"><p class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitus_eliminada_con_exito']/node()"/></p></td>
		</tr>
	</xsl:when>
	<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/RECHAZADOS and /MantenimientoProductos/DATOS/ERROR">
		<tr class="titulos">
			<td colspan="20" align="center"><p class="rojo"><xsl:value-of select="/MantenimientoProductos/DATOS/ERROR/@msg"/></p></td>
		</tr>
	</xsl:when>
	</xsl:choose>
	<!--fin eliminación de solicitudes parte proveedor-->

		<tr class="subTituloTabla">
			<th class="dos"><a href="javascript:OrdenarPor('VALORDOC');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Cont']/node()"/></a></th>
			<th class="ocho"><a href="javascript:OrdenarPor('REFERENCIA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></a></th>
			<!--<th class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='ima']/node()"/></th>-->
			<th><a href="javascript:OrdenarPor('PRODUCTO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a></th>
			<!--<th class="seis"><xsl:value-of select="document($doc)/translation/texts/item[@name='detalle']/node()"/></th>-->
			<th class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='imagen']/node()"/></th>
			<th class="seis"><a href="javascript:OrdenarPor('MARCA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></a></th>
			<th class="cinco"><a href="javascript:OrdenarPor('DOCS');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Docs']/node()"/></a></th>
			<th class="ocho"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_base']/node()"/></th>
			<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_lote']/node()"/></th>
			<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></th>
			<th class="siete" align="right"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='mvm']/node()"/></th>

		<!--si es españa enseño precio asisa y fncp
		<xsl:choose>
		<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
			<!- -precio fncp- ->
			<th class="cinco" align="right"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_fncp']/node()"/></th>
			<!- -emplantillado fncp- ->
			<th class="uno">&nbsp;</th>
			<!- -precio viamed- ->
			<th class="cinco" align="right"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_viamed']/node()"/></th>
			<!- -emplantillado viamed- ->
			<th class="uno">&nbsp;</th>
		</xsl:when>
		<xsl:otherwise><th colspan="8" class="uno">&nbsp;</th></xsl:otherwise>
		</xsl:choose>
		-->

		<!--si son solicitudes rechazadas enseño comentario-->
		<xsl:choose>
		<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/RECHAZADOS">
			<th class="dies" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentario']/node()"/></th>
			<th class="cinco" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/></th>
		</xsl:when>
		<xsl:otherwise><th class="uno" colspan="2"></th></xsl:otherwise>
		</xsl:choose>
		</tr>
	</thead>

	<!--	Cuerpo de la tabla	-->
	<tbody>
	<xsl:for-each select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PRODUCTO">
		<tr>
			<td class="center">
				<xsl:choose>
    	  		<xsl:when test="NIVELDOCUMENTACION='V'">
					<xsl:attribute name="style">background:#4E9A06;</xsl:attribute>
				</xsl:when>
    	  		<xsl:when test="NIVELDOCUMENTACION='A'">
					<xsl:attribute name="style">background:#F57900;</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="style">background:#CC0000;</xsl:attribute>
				</xsl:otherwise>
    	 		</xsl:choose>
				<xsl:value-of select="CONTADOR"/>
			</td>
			<td class="center">
				<xsl:value-of select="REFERENCIA"/>
				<input type="hidden" name="REF_{IDPRODUCTO}" value="{REFERENCIA}"/>
			</td>
			<!--
			<td>
				<input type="hidden" name="PRO_ID" value="{IDPRODUCTO}"/>
				<input type="checkbox" class="muypeq" name="CHECK" id="{IDPRODUCTO}" alt="{REFERENCIA}"/>
			</td>
			-->
			<td class="textLeft">
				<!--solicitud pendiente o devuelta-->
				<xsl:choose>
				<xsl:when test="SOLICITUD_DEVUELTA">
					<strong>
						<a href="javascript:AlarmaSolicitud('D');">
							<span style="color:#FF9900;">D</span>&nbsp;<xsl:value-of select="NOMBRE"/>
						</a>
					</strong>
				</xsl:when>
				<xsl:when test="SOLICITUD_PENDIENTE">
					<strong>
						<a href="javascript:AlarmaSolicitud('P');">
							<span style="color:#FF9900;">P</span>&nbsp;<xsl:value-of select="NOMBRE"/>
						</a>
					</strong>
				</xsl:when>
				<xsl:otherwise>
					<strong>
						<a>
							<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROManten.xsql?PRO_ID=<xsl:value-of select="IDPRODUCTO"/>&amp;TIPO=M&amp;PRO_BUSQUEDA=<xsl:value-of select="//LISTAPRODUCTOS/BUSQUEDA/PRODUCTO"/>&amp;IDCLIENTE=<xsl:value-of select="//LISTAPRODUCTOS/BUSQUEDA/IDCLIENTE"/>&amp;HISTORY='+obtenerHistoria(),'producto',100,80,0,0);</xsl:attribute>
							<xsl:value-of select="NOMBRE"/>
						</a>
					</strong>
				</xsl:otherwise>
				</xsl:choose>
			</td>
			<!--ficha de producto
			<td align="center">
				<a>
					<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="IDPRODUCTO"/>','producto',100,80,0,0);</xsl:attribute>
					Detalle
				</a>
			</td>
			-->
			<!--imagenes-->
			<td class="center">
				<xsl:variable name="ima" select="count(IMAGENES/IMAGEN)"/>

				<xsl:choose>
				<xsl:when test="$ima &gt; '0'">
					<xsl:variable name="idRef" select="REFERENCIA"/>
					<img src="http://www.newco.dev.br/images/imagenSI.gif" alt="{IDPRODUCTO}" id="IMA_{IDPRODUCTO}" onmouseover="verFoto('{$idRef}');" onmouseout="verFoto('{$idRef}');"/>

					<div id="verFotoPro_{$idRef}" class="divFotoProBusca" style="display:none;">
						<xsl:for-each select="IMAGENES/IMAGEN">
							<xsl:if test="@id != '-1'">
								<img src="http://www.newco.dev.br/Fotos/{@peq}"/>
							</xsl:if>
						</xsl:for-each>
					</div>
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="idIma" select="IDPRODUCTO"/>
					<!--
					<img src="http://www.newco.dev.br/images/imagenNO.gif" id="IMA_{$idIma}"/>
					-->
				</xsl:otherwise>
				</xsl:choose>
			</td>
			<td class="center">
				<xsl:value-of select="MARCA"/>&nbsp;
			</td>
			<td class="center">
				<xsl:value-of select="NUMDOCUMENTOS"/>&nbsp;
			</td>
			<td class="center">
				<xsl:value-of select="UNIDADBASICA"/>
			</td>
			<td class="center">
				<xsl:value-of select="UNIDADESPORLOTE"/>
			</td>
			<td class="center">
				<xsl:for-each select="IVA/field/dropDownList/listElem">
					<xsl:if test="ID=../../@current">
						<xsl:value-of select="listItem"/>
					</xsl:if>
				</xsl:for-each>
			</td>
			<td align="right">
				<xsl:value-of select="TARIFAPRIVADA_MVM"/>
				<xsl:text>&nbsp;</xsl:text>
			</td>

			<!--si es españa enseño emplantillado fncp y precio fncp si no nada
			<td align="right">
				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
					<xsl:choose>
					<xsl:when test="TARIFAPRIVADA_FNCP != TARIFAPRIVADA_MVM">
						<span class="fondoRojo"><xsl:value-of select="TARIFAPRIVADA_FNCP"/></span>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="TARIFAPRIVADA_FNCP"/>
					</xsl:otherwise>
					</xsl:choose>
					<xsl:text>&nbsp;</xsl:text>
				</xsl:if>
			</td>
			<td align="right">
				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
					<xsl:if test="EMPLANTILLADO_EN_FNCP">&nbsp;<strong><span class="verde">F</span></strong></xsl:if>
				</xsl:if>
			</td>

			<!- -si es españa enseño emplantillado viamed y precio viamed si no nada- ->
			<td align="right">
				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
					<xsl:choose>
					<xsl:when test="TARIFAPRIVADA_VIAMED != TARIFAPRIVADA_MVM">
						<span class="fondoRojo"><xsl:value-of select="TARIFAPRIVADA_VIAMED"/></span>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="TARIFAPRIVADA_VIAMED"/>
					</xsl:otherwise>
					</xsl:choose>
					<xsl:text>&nbsp;</xsl:text>
				</xsl:if>
			</td>
			<td align="right">
				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
					<xsl:if test="EMPLANTILLADO_EN_VIAMED">&nbsp;<strong><span class="verde">V</span></strong></xsl:if>
				</xsl:if>
			</td>
			-->



		<!--si son solicitudes rechazadas enseño comentario-->
		<xsl:choose>
		<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/RECHAZADOS">
			<td>
				<xsl:if test="COMENTARIO_RECHAZO != ''">
					<xsl:value-of select="COMENTARIO_RECHAZO"/>
				</xsl:if>
			</td>
			<td>
				<a href="javascript:EliminaSolicitud({IDPRODUCTO});"><img src="http://www.newco.dev.br/images/eliminarOferta.gif" alt="Elimina"/></a>
			</td>
		</xsl:when>
		<xsl:otherwise>
			<td colspan="2">&nbsp;</td>
		</xsl:otherwise>
		</xsl:choose>
		</tr>
	</xsl:for-each>
	</tbody>
<!--
	<tfoot>
		<tr class="lejenda">
			<th colspan="8" class="textLeft"><xsl:value-of select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/MENSAJE"/></th>
			<th colspan="2">&nbsp;</th>
			<th colspan="5" class="textRight">
				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINAANTERIOR">

					<a href="javascript:CambioPagina('ANTERIOR');" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/flechaLeft.gif"/></a>&nbsp;
					<a href="javascript:CambioPagina('ANTERIOR');"> <xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
				</xsl:if>
				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINASIGUIENTE">
					&nbsp;&nbsp;&nbsp;

					<a href="javascript:CambioPagina('SIGUIENTE');"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>&nbsp;
					<a href="javascript:CambioPagina('SIGUIENTE');" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/flechaRight.gif"/></a>
				</xsl:if>
			</th>
		</tr>
	</tfoot>-->
	</table>
</xsl:template><!--fin de proveedor-->

<!--INICIO TEMPLATE IMAGE-->
<xsl:template name="image">
	<xsl:param name="num"/>

	<div class="imageLineBusca" id="imageLine_{$num}">
		<input id="inputFile_{$num}" name="inputFile" type="file" onchange="addFile({$num});"/>
	</div>
</xsl:template>

<!--INICIO TEMPLATE IMAGE-->
<xsl:template name="imageMan">
	<xsl:param name="num"/>

	<div class="imageLineBusca" id="imageLine_{$num}">
	<xsl:if test="@id != '-1'">
		<div class="imageBuscaManten">
			<a href="http://www.newco.dev.br/Fotos/{@grande}" rel="lightbox" title="Foto producto" style="text-decoration:none;"><img src="http://www.newco.dev.br/Fotos/{@peq}" class="manFotoBusca"/></a>
			&nbsp;
			<a id="deleteLink_{$num}" href="javascript:Eliminar();" onclick="this.parentNode.style.display='none'; return deleteImagen({@id}, {$num});"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>
		</div>
	</xsl:if>
	</div>
</xsl:template>
<!--fin de template image-->
</xsl:stylesheet>
