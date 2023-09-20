<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Mantenimiento de productos de los catalogos de proveedores de MedicalVM
 	Ultima revision ET 17abr23 15:15 PROResultados2022_170423.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
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

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROResultados2022_170423.js"></script>

	<link rel="stylesheet" href="http://www.newco.dev.br/General/lightbox.css" type="text/css" media="screen"/>

	<script type="text/javascript">
		var isAdmin	= '<xsl:value-of select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/DERECHOS/@ADMIN"/>';
		var confirmPag	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='confirm_cambio_pagina']/node()"/>';
	</script>
</head>

<body>
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
				<p class="TituloPagina">
					<xsl:value-of select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/MENSAJE"/>
					<span class="CompletarTitulo w400px">
						<!--	Botones	-->
						<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINAANTERIOR">
							<a class="btnNormal" href="javascript:CambioPagina('ANTERIOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>&nbsp;
						</xsl:if>
						<!--29mar22 Este boton no tiene funcionalidad actualmente
                        <xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/COMPRADOR">
						<a class="btnDestacado" href="javascript:Enviar(document.forms[1],document.forms[0],'ACTUALIZAR');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar']/node()"/>
						</a>&nbsp;
						</xsl:if>-->
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
		<div class="tabela tabela_redonda">
		<table id="tblData">
		<thead class="cabecalho_tabela">
			<tr>
				<th class="w1px"><a href="javascript:OrdenarPor('VALORDOC');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Cont']/node()"/></a></th>
				<th class="w40px"><a href="javascript:OrdenarPor('REFERENCIA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></a></th>
				<th class="w1px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ima']/node()"/></th>
				<th class="textLeft"><a href="javascript:OrdenarPor('PRODUCTO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a></th>
				<th class="textLeft"><a href="javascript:OrdenarPor('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a></th>
				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM">
					<th class="diez"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado']/node()"/></th>
				</xsl:if>
				<th class="w20px"><a href="javascript:OrdenarPor('MARCA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></a></th>
				<th class="w20px"><a href="javascript:OrdenarPor('DOCS');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Docs']/node()"/></a></th>
				<th class="w20px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_base']/node()"/></th>
				<th class="w20px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ud_por_caja_2line']/node()"/></th>
				<th class="w20px"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></th>
				<th class="w20px"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>
				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM">
					<br /><xsl:value-of select="document($doc)/translation/texts/item[@name='mvm']/node()"/>
				</xsl:if>
				</th>

				<!--precio fncp, recoletas -->
				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
					<th class="w20px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_fncp']/node()"/></th>
					<th class="w20px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_recoletas']/node()"/></th>
				</xsl:if>

				<th class="w20px"><a href="javascript:OrdenarPor('CONSUMO');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></a></th>
				<!--27jul22 No permitimos borrar desde este mantenimiento
				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM">
					<th class="w1px"><xsl:value-of select="document($doc)/translation/texts/item[@name='bor']/node()"/><br /><a href="javascript:SelTodosBorrar();"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></a></th>
				</xsl:if>
				-->
			</tr>
		</thead>
		<!--	Cuerpo de la tabla	-->
		<tbody class="corpo_tabela">
		<xsl:for-each select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PRODUCTO">
			<tr class="conhover">
				<td class="textCenter">
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
				<td class="textCenter">
					<strong>
					<a>
						<!--<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROManten.xsql?PRO_ID=<xsl:value-of select="IDPRODUCTO"/>&amp;TIPO=M&amp;PRO_BUSQUEDA=<xsl:value-of select="//LISTAPRODUCTOS/BUSQUEDA/PRODUCTO"/>&amp;IDCLIENTE=<xsl:value-of select="//LISTAPRODUCTOS/BUSQUEDA/IDCLIENTE"/>&amp;HISTORY='+obtenerHistoria(),'Mantenimiento Producto - <xsl:value-of select="IDPRODUCTO"/>',100,80,0,0);</xsl:attribute>-->
						<xsl:attribute name="href">javascript:MantenProducto(<xsl:value-of select="IDPRODUCTO"/>,'<xsl:value-of select="//LISTAPRODUCTOS/BUSQUEDA/PRODUCTO"/>','<xsl:value-of select="//LISTAPRODUCTOS/BUSQUEDA/IDCLIENTE"/>');</xsl:attribute>
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
					<!--	8mar22 QUitamos el boton de catalogar, desde la ficha de producto pueden acceder, 28jun22 OHSJD solicita recuperar el boton	-->
        			<a class="btnDiscreto" href="javascript:FichaAdjudicacion('{IDPRODUCTO}','{/MantenimientoProductos/IDCLIENTE}');">
            			<xsl:value-of select="document($doc)/translation/texts/item[@name='Cat']/node()"/>
        			</a>&nbsp;
					<strong>
						<a>
							<xsl:attribute name="href">javascript:MantenProducto(<xsl:value-of select="IDPRODUCTO"/>,'<xsl:value-of select="//LISTAPRODUCTOS/BUSQUEDA/PRODUCTO"/>','<xsl:value-of select="//LISTAPRODUCTOS/BUSQUEDA/IDCLIENTE"/>');</xsl:attribute>
							<xsl:value-of select="NOMBRE"/>
						</a>
					</strong>
				</td>

				<td class="textLeft">
					<a>
						<xsl:attribute name="href">javascript:FichaEmpresa(<xsl:value-of select="IDPROVEEDOR"/>);</xsl:attribute>
						<xsl:value-of select="PROVEEDOR"/>
					</a>
				</td>

				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM">
					<td class="textCenter">
					<xsl:choose>
					<xsl:when test="./CLIENTESADJ/field/dropDownList/listElem[2]">
						<xsl:call-template name="desplegable">
							<xsl:with-param name="path" select="./CLIENTESADJ/field"/>
							<xsl:with-param name="claSel">w120px</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='ninguna_clinica']/node()"/>
					</xsl:otherwise>
					</xsl:choose>
					</td>
				</xsl:if>

				<td class="textCenter">
                    <input type="hidden" >
						<xsl:attribute name="name">MARCA_<xsl:value-of select="IDPRODUCTO"/>_OLD</xsl:attribute>
						<xsl:attribute name="value"><xsl:value-of select="MARCA"/></xsl:attribute>
					</input>
					<xsl:value-of select="MARCA"/>
					<!--
					<input type="text" class="campopesquisa w100px" maxlength="100">
						<xsl:attribute name="name">MARCA_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
						<xsl:attribute name="value"><xsl:value-of select="MARCA"/></xsl:attribute>
					</input>-->
				</td>

				<td class="textCenter">
					<xsl:value-of select="NUMDOCUMENTOS"/>&nbsp;
				</td>


				<td class="textCenter w100px">
					<input type="hidden" maxlength="100" size="13" class="inright">
						<xsl:attribute name="name">UNIDADBASICA_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
						<xsl:attribute name="value"><xsl:value-of select="UNIDADBASICA"/></xsl:attribute>
					</input>
					<xsl:value-of select="UNIDADBASICA"/>
				</td>

				<td class="textCenter w50px">
                	<input type="hidden" maxlength="10" size="4" class="inright">
						<xsl:attribute name="name">UNIDADESPORLOTE_<xsl:value-of select="IDPRODUCTO"/>_OLD</xsl:attribute>
						<xsl:attribute name="value"><xsl:value-of select="UNIDADESPORLOTE"/></xsl:attribute>
					</input>
					<xsl:choose>
						<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM">
							<input type="text" class="campopesquisa w60px" maxlength="10">
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

				<td class="textCenter w50px">
                    <input type="hidden">
						<xsl:attribute name="name">IDTIPOIVA_<xsl:value-of select="IDPRODUCTO"/>_OLD</xsl:attribute>
						<xsl:attribute name="value"><xsl:value-of select="IVA/field/@current"/></xsl:attribute>
					</input>
					<!--29mar22 no se puede modificar el tipo de IVA desde aqui
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="IVA/field"/>
						<xsl:with-param name="claSel">w70px</xsl:with-param>
						<xsl:with-param name="disabled">disabled</xsl:with-param>
					</xsl:call-template>-->
					<xsl:value-of select="TIPOIVA"/>
				</td>
				<td align="right">
					<xsl:choose>
					<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM">
						<input type="hidden">
							<xsl:attribute name="name">TARIFA_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
							<xsl:attribute name="value"><xsl:value-of select="TARIFAPRIVADA_MVM"/></xsl:attribute>
						</input>
						<input type="hidden">
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
				<input type="hidden" name="EXPANDIR_{IDPRODUCTO}" value="N"/>

			<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">

				<!--precio fncp-->
				<td class="textCenter">
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
				<!--precio recoletas-->
				<td class="textCenter">
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
				<td class="textCenter" align="right">&nbsp;<xsl:value-of select="CONSUMO"/>&nbsp;</td>

				<!--27jul22 No permitimos borrar desde este mantenimiento
				<xsl:choose>
					<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM">
						<td class="textCenter">
							<input type="checkbox" class="muypeq">
								<xsl:attribute name="name">BORRAR_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
							</input>
						</td>
					</xsl:when>
					<xsl:otherwise>
						<input type="hidden" class="muypeq" name="BORRAR_{IDPRODUCTO}"/>
					</xsl:otherwise>
				</xsl:choose><


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
-->
			</tr>
		</xsl:for-each>
		</tbody>
		<tfoot class="rodape_tabela">
			<tr>
				<td><a href="javascript:OrdenarPor('VALORDOC');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Cont']/node()"/></a></td>
				<td><a href="javascript:OrdenarPor('REFERENCIA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></a></td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='ima']/node()"/></td>
				<td><a href="javascript:OrdenarPor('PRODUCTO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a></td>
				<td><a href="javascript:OrdenarPor('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a></td>
				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM">
					<td><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado']/node()"/></td>
				</xsl:if>
				<td><a href="javascript:OrdenarPor('MARCA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></a></td>
				<td><a href="javascript:OrdenarPor('DOCS');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Docs']/node()"/></a></td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_base']/node()"/></td>
				<td><xsl:copy-of select="document($doc)/translation/texts/item[@name='ud_por_caja_2line']/node()"/></td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></td>
				<td><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>
				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM">
					<br /><xsl:value-of select="document($doc)/translation/texts/item[@name='mvm']/node()"/>
				</xsl:if>
				</td>

				<!--precio fncp, recoletas -->
				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
					<td><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_fncp']/node()"/></td>
					<td><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_recoletas']/node()"/></td>
				</xsl:if>

				<td><a href="javascript:OrdenarPor('CONSUMO');"><xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></a></td>
				<!--27jul22 No permitimos borrar desde este mantenimiento
				<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/ADMIN_MVM">
					<td><xsl:value-of select="document($doc)/translation/texts/item[@name='bor']/node()"/><br /><a href="javascript:SelTodosBorrar();"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></a></td>
				</xsl:if>-->
			</tr>
		</tfoot>
		</table>
		</div>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		
	</xsl:when>
	<xsl:otherwise>
		<!--
		
			solicitudes de proveedores
				
		-->
		<!--productos nuevos o modificado del proveedor mvm acepta o no
        <input type="hidden" name="US_ID_CAMBIO" value="{//LISTAPRODUCTOS/IDCLIENTE}"/>-->
		<input type="hidden" name="CAMBIOS_PROVE"/>

		<div class="divLeft">
		<span class="floatRight">
		<a class="btnNormal" href="PROManten2022.xsql"><xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_producto']/node()"/></a>&nbsp;
		<a class="btnDestacado" href="javascript:AceptarCambios();"><xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar_cambios']/node()"/></a>&nbsp;&nbsp;&nbsp;&nbsp;
		</span>

		<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINAANTERIOR or /MantenimientoProductos/DATOS/LISTAPRODUCTOS/PAGINASIGUIENTE">
			<table cellspacing="6px" cellpadding="6px">
				<tr>
					<th class="textRight">
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
			</table>
		</xsl:if>
		</div>
		<br/>
		<div class="tabela tabela_redonda">
		<table cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
			<tr class="titulos">
				<th class="w1px">.</th>
				<th class="w50px"><a href="javascript:OrdenarPor('REFERENCIA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></a></th>
				<th class="w1px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ima']/node()"/></th>
				<th class="w1px"></th>
				<th class="texLeft"><a href="javascript:OrdenarPor('PRODUCTO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a></th>
				<th class="texLeft"><a href="javascript:OrdenarPor('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a></th>
				<th class="texLeft"><a href="javascript:OrdenarPor('MARCA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></a></th>
				<th class="w50px"><a href="javascript:OrdenarPor('DOCS');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Docs']/node()"/></a></th>
				<th class="w80px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_base']/node()"/></th>
				<th class="w80px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ud_por_caja_2line']/node()"/></th>
				<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></th>

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
		<tbody class="corpo_tabela">
		<xsl:for-each select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PRODUCTO">
			<input type="hidden" name="IDPROD_{IDPRODUCTO}" value="{IDPRODUCTO}"/>
			<tr>
				<td class="textCenter">
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
				<td class="textCenter">
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
							<!--<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="IDPRODUCTO"/>','producto',100,80,0,0);</xsl:attribute>-->
							<xsl:attribute name="href">javascript:FichaProducto(<xsl:value-of select="IDPRODUCTO"/>);</xsl:attribute>
							<xsl:attribute name="class"><xsl:if test="CAMBIOS/NOMBRE">amarillo</xsl:if></xsl:attribute>
							<xsl:value-of select="NOMBRE"/>
						</a>
					</strong>
				</td>
				<td class="texLeft">
					<a>
						<!--<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="IDPROVEEDOR"/>&amp;VENTANA=NUEVA','DetalleEmpresa',100,80,0,0)</xsl:attribute>-->
						<xsl:attribute name="href">javascript:FichaEmpresa(<xsl:value-of select="IDPROVEEDOR"/>);</xsl:attribute>
						<xsl:value-of select="PROVEEDOR"/>&nbsp;
					</a>
				</td>
				<td class="texLeft">
					<p>
						<xsl:attribute name="class"><xsl:if test="CAMBIOS/MARCA">amarillo</xsl:if> </xsl:attribute>
						<xsl:value-of select="MARCA"/>&nbsp;
					</p>
				</td>
				<td class="textCenter">
					<p>
						<xsl:attribute name="class"><xsl:if test="CAMBIOS/NUMDOCUMENTOS">amarillo</xsl:if> </xsl:attribute>
						<xsl:value-of select="NUMDOCUMENTOS"/>&nbsp;
					</p>
				</td>
				<td class="texLeft">
					<p>
						<!--<xsl:attribute name="class"><xsl:if test="CAMBIOS/UNIDADBASICA">amarillo</xsl:if></xsl:attribute>-->
						<xsl:value-of select="UNIDADBASICA"/>
					</p>
				</td>
				<td class="textCenter">
					<p>
						<xsl:attribute name="class"><xsl:if test="CAMBIOS/UNIDADESPORLOTE">amarillo</xsl:if></xsl:attribute>
						<xsl:value-of select="UNIDADESPORLOTE"/>
					</p>
				</td>
				<td class="textCenter">
					<p>
						<xsl:attribute name="class">w70px <xsl:if test="CAMBIOS/TIPOIVA">amarillo</xsl:if></xsl:attribute>
						<xsl:for-each select="IVA/field/dropDownList/listElem">
							<xsl:if test="ID=../../@current">
								<xsl:value-of select="listItem"/>
							</xsl:if>
						</xsl:for-each>
					</p>
				</td>
				<td class="textCenter">
					<xsl:value-of select="TARIFAORIGINAL_MVM"/>
				</td>
				<td class="textCenter">
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
				<td class="textCenter">
					<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
						<xsl:value-of select="TARIFAORIGINAL_FNCP"/>
					</xsl:if>
				</td>

				<!--precio FNCP solo si españa-->
				<td class="textCenter">
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
				<td class="textCenter">
					<xsl:if test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/IDPAIS = '34'">
						<xsl:value-of select="TARIFAORIGINAL_VIAMED"/>
					</xsl:if>
				</td>

				<!--precio viamed solo si españa-->
				<td class="textCenter">
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

				<td class="textCenter">
					<input type="checkbox" onclick="RevisarOpciones({IDPRODUCTO},'ACEPTAR');">
						<xsl:attribute name="name">ACEPTAR_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
					</input>
				</td>

				<td class="textCenter">
					<input type="checkbox" onclick="RevisarOpciones({IDPRODUCTO},'CANCELAR');">
						<xsl:attribute name="name">CANCELAR_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
					</input>
				</td>

				<td class="textCenter">
					<input size="15">
						<xsl:attribute name="name">COMENTARIO_<xsl:value-of select="IDPRODUCTO"/></xsl:attribute>
					</input>
				</td>
			</tr>
		</xsl:for-each>
		</tbody>

		<tfoot class="rodape_tabela">
			<tr class="lejenda">
				<td colspan="26">&nbsp;</td>
			</tr>
		</tfoot>
		</table>
		</div>
	</xsl:otherwise>
	</xsl:choose>
	<br/>
	<br/>
	<br/>
	<br/>
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

	<div class="divLeft">
	<table cellspacing="6px" cellpadding="6px">
		<tr>
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
				<p class="textLeft">
					<span class="naranja">P</span>&nbsp;
					<span class="fuentePeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_pendiente']/node()"/></span>
				</p>
			</th>
			<th colspan="3">
				<p class="textLeft">
					&nbsp;<span class="naranja">D</span>&nbsp;
					<span class="fuentePeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_rechazada']/node()"/></span>
				</p>
			</th>
			<th colspan="5" class="textRight">
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
	</table>
	</div>

	<div class="tabela tabela_redonda">
	<table cellspacing="6px" cellpadding="6px">
	<thead class="cabecalho_tabela">
		<tr class="subTituloTabla">
			<th class="w1px"><a href="javascript:OrdenarPor('VALORDOC');">.</a></th>
			<th class="w50px"><a href="javascript:OrdenarPor('REFERENCIA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/></a></th>
			<th><a href="javascript:OrdenarPor('PRODUCTO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='imagen']/node()"/></th>
			<th class="textLeft"><a href="javascript:OrdenarPor('MARCA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></a></th>
			<th class="w50px"><a href="javascript:OrdenarPor('DOCS');"><xsl:value-of select="document($doc)/translation/texts/item[@name='Docs']/node()"/></a></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_base']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_lote']/node()"/></th>
			<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/></th>
			<th class="w50px" align="right"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='mvm']/node()"/></th>
		<!--si son solicitudes rechazadas enseño comentario-->
		<xsl:choose>
		<xsl:when test="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/BUSQUEDA/RECHAZADOS">
			<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentario']/node()"/></th>
			<th class="w50px textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/></th>
		</xsl:when>
		<xsl:otherwise><th class="uno" colspan="2"></th></xsl:otherwise>
		</xsl:choose>
		</tr>
	</thead>

	<!--	Cuerpo de la tabla	-->
	<tbody class="corpo_tabela">
	<xsl:for-each select="/MantenimientoProductos/DATOS/LISTAPRODUCTOS/PRODUCTO">
		<tr class="conhover">
			<td>
				<xsl:attribute name="class">
				<xsl:choose>
    	  		<xsl:when test="NIVELDOCUMENTACION='V'">textCenter fondoVerde</xsl:when>
    	  		<xsl:when test="NIVELDOCUMENTACION='A'">textCenter fondoAmarillo</xsl:when>
				<xsl:otherwise>textCenter color_status</xsl:otherwise>
    	 		</xsl:choose>
				</xsl:attribute>
				<xsl:value-of select="CONTADOR"/>
			</td>
			<td class="textCenter">
				<xsl:value-of select="REFERENCIA"/>
				<input type="hidden" name="REF_{IDPRODUCTO}" value="{REFERENCIA}"/>
			</td>
			<td class="textLeft">
				<!--solicitud pendiente o devuelta-->
				<xsl:choose>
				<xsl:when test="SOLICITUD_DEVUELTA">
					<strong>
						<a href="javascript:AlarmaSolicitud('D');">
							<span class="naranja">D</span>&nbsp;<xsl:value-of select="NOMBRE"/>
						</a>
					</strong>
				</xsl:when>
				<xsl:when test="SOLICITUD_PENDIENTE">
					<strong>
						<a>
							<xsl:attribute name="href">javascript:MantenProducto(<xsl:value-of select="SOLICITUD_PENDIENTE/@IDPRODUCTO"/>,'<xsl:value-of select="//LISTAPRODUCTOS/BUSQUEDA/PRODUCTO"/>','<xsl:value-of select="/MantenimientoProductos/IDCLIENTE"/>'+'&amp;TIPO=M');</xsl:attribute>
							<span class="naranja">P</span>&nbsp;<xsl:value-of select="NOMBRE"/>
						</a>
					</strong>
				</xsl:when>
				<xsl:otherwise>
					<strong>
						<a>
							<xsl:attribute name="href">javascript:MantenProducto(<xsl:value-of select="IDPRODUCTO"/>,'<xsl:value-of select="//LISTAPRODUCTOS/BUSQUEDA/PRODUCTO"/>','<xsl:value-of select="/MantenimientoProductos/IDCLIENTE"/>'+'&amp;TIPO=M');</xsl:attribute>
							<xsl:value-of select="NOMBRE"/>
						</a>
					</strong>
				</xsl:otherwise>
				</xsl:choose>
			</td>
			<!--imagenes-->
			<td class="textCenter">
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
				</xsl:otherwise>
				</xsl:choose>
			</td>
			<td class="textLeft">
				<xsl:value-of select="MARCA"/>&nbsp;
			</td>
			<td class="textCenter">
				<xsl:value-of select="NUMDOCUMENTOS"/>&nbsp;
			</td>
			<td class="textCenter">
				<xsl:value-of select="UNIDADBASICA"/>
			</td>
			<td class="textCenter">
				<xsl:value-of select="UNIDADESPORLOTE"/>
			</td>
			<td class="textCenter">
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
	<tfoot class="rodape_tabela">
		<tr><td colspan="12">&nbsp;</td></tr>
	</tfoot>
	</table>
	<br/>
	<br/>
	<br/>
	<br/>
	</div>
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
