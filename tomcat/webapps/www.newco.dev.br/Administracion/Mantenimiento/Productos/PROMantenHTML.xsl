<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Mant.producto
 	Ultima revision: ET 28mar22 PROManten_280322.js
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
		<xsl:when test="/MantenimientoProductos/LANG"><xsl:value-of select="/MantenimientoProductos/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title>
	<xsl:choose>
	<xsl:when test="/MantenimientoProductos/Form/PRODUCTO/PRO_ID!=''">
		<xsl:value-of select="/MantenimientoProductos/Form/PRODUCTO/REFERENCIA_PROVEEDOR"/>:&nbsp;
        <xsl:value-of select="substring(MantenimientoProductos/Form/PRODUCTO/PRO_NOMBRE,0,50)"/>
	</xsl:when>
	<xsl:otherwise>
		<xsl:value-of select="document($doc)/translation/texts/item[@name='alta']/node()"/>&nbsp;
		<xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
		<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>
	</xsl:otherwise>
	</xsl:choose>
	</title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<!--cuando se cambia cargaDoc el nombre cambiar tb en Empresas/EMPManten-->
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CargaDocumentos_070519.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Compras/Multioferta/BuscaProd.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROManten_280322.js"></script>
	<!-- <script type="text/javascript" src="http://www.newco.dev.br/General/imagenOneProd.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/General/ajax.js"></script>

	<script type="text/javascript">
		var tipoIVA = 0;
		var precio_cIVA_mal_formado = '<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_cIVA_no_numerico']/node()"/>';
	</script>
</head>

<body>
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/MantenimientoProductos/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->


	<!--	Titulo de la página		-->


	<xsl:variable name="tituloCompleto">
		<xsl:choose>
		<xsl:when test="/MantenimientoProductos/Form/PRODUCTO/PRO_ID!=''">
        	<!--<xsl:value-of select="MantenimientoProductos/Form/PRODUCTO/PROVEEDOR"/>:-->
        	<xsl:value-of select="/MantenimientoProductos/Form/PRODUCTO/REFERENCIA_PROVEEDOR"/>:&nbsp;
        	<xsl:value-of select="substring(MantenimientoProductos/Form/PRODUCTO/PRO_NOMBRE,0,50)"/>
		</xsl:when>
		<xsl:otherwise>
        	<xsl:if test="not(//ADMIN_MVM) and not(//ADMIN_MVMB)and not(//ADMIN)">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_de']/node()"/>&nbsp;
			</xsl:if>
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='alta']/node()"/>&nbsp;
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<!--	Pestañas y Titulo de la página, únicamente si el producto ya existe. Si no, hay quie crearlo antes de poder incluir documentos		-->
	<xsl:if test="/MantenimientoProductos/Form/PRODUCTO/PRO_ID!=''">
 	<div class="divLeft" style="background-color:white;">
		<ul class="pestannas" style="position:relative;width:600px;">
			<li>
				<a id="pes_Ficha" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='Ficha_de_producto']/node()"/></a>
			</li>
			<li>
				<a id="pes_Tarifas" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='tarifas']/node()"/></a>
			</li>
			<li>
				<a id="pes_Documentos" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/></a>
			</li>
			<li>
				<a id="pes_Pack" class="MenuLic"><xsl:value-of select="document($doc)/translation/texts/item[@name='Contenido_pack']/node()"/></a>
			</li>
		</ul>
	</div>
	</xsl:if>

	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_de_productos']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>&nbsp;</span>
			<span class="CompletarTitulo">
				<!--<xsl:value-of select="substring($tituloCompleto,0,150)"/>-->
				<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_modificacion']/node()"/>:&nbsp;<xsl:value-of select="/MantenimientoProductos/Form/PRODUCTO/FECHACAMBIO"/>
			</span>
		</p>
		<p class="TituloPagina">
			<xsl:value-of select="substring($tituloCompleto,0,60)"/>
			<span class="CompletarTitulo" style="width:600px;">
				<!--	Botones	-->
				<!--
                <a class="btnNormal">
                    <xsl:attribute name="href">
                        <xsl:choose>
                            <xsl:when test="/MantenimientoProductos/TIPO = 'M'">javascript:window.close();</xsl:when>
                            <xsl:otherwise>javascript:document.location='about:blank';</xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
                </a>&nbsp;
				-->
				<a class="btnNormal" href="javascript:window.close();"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>&nbsp;
           		<!--<xsl:if test="//ADMIN_MVM or //ADMIN_MVMB or //ADMIN or //TIPO='M'">-->
					<xsl:if test="/MantenimientoProductos/Form/PRODUCTO/ROL='VENDEDOR' or /MantenimientoProductos/Form/PRODUCTO/PRO_ID !='' ">
                    	<a class="btnDestacado" id="botonCopiar" href="javascript:CrearNuevoProd(document.forms[0],'PROMantenSave.xsql');">
                        	<xsl:value-of select="document($doc)/translation/texts/item[@name='crear_nuevo_producto']/node()"/>
                    	</a>&nbsp;
					</xsl:if>
            	<!--</xsl:if>-->
                <xsl:choose>
                <xsl:when test="/MantenimientoProductos/Form/PRODUCTO/ROL='COMPRADOR'">
                	<a class="btnDestacado" id="botonGuardar" href="javascript:EnviaProd(document.forms[0],'PROMantenSave.xsql');">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
                    </a>&nbsp;
				</xsl:when>
				<xsl:otherwise>
					<!--si es proveedor pongo solicitud-->
					<a class="btnDestacado" id="botonGuardar" href="javascript:CompruebaCambios(document.forms[0],'PROMantenSave.xsql');">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitar']/node()"/>
					</a>&nbsp;
				</xsl:otherwise>
				</xsl:choose>
				<!--si es proveedor borrar producto boton, si no input hidden-->
				<xsl:if test="/MantenimientoProductos/Form/PRODUCTO/ROL='COMPRADOR' and //ADMIN_MVM"> <!--proveedor-->
					<a class="btnDestacado" href="javascript:BorrarProd(document.forms[0],'PROMantenSave.xsql');">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_producto']/node()"/>
					</a>&nbsp;
				</xsl:if>
			</span>
		</p>
	</div>
	<br/>

	<div class="divLeft">
	<!--si es proveedor le pongo un text para que sepa que sus cambios o nuevos productos son solicitudes-->
	<xsl:choose>
	<xsl:when test="not(//ADMIN_MVM) and not(//ADMIN_MVMB) and not(//ADMIN) and //TIPO=''">
<!--		<br />
		<p align="center"><strong><xsl:copy-of select="document($doc)/translation/texts/item[@name='solicito_se_incluya_este_producto']/node()"/>.</strong></p>
-->
	</xsl:when>
	<xsl:when test="(//ADMIN_MVM or //ADMIN_MVMB or //ADMIN) and //TIPO=''">
<!--		<br />
		<p align="center"><strong><xsl:copy-of select="document($doc)/translation/texts/item[@name='rogamos_que_antes_de_rellenar_los_datos']/node()"/>.</strong></p>
-->
	</xsl:when>
	<xsl:when test="not(//ADMIN_MVM) and not(//ADMIN_MVMB) and not(//ADMIN) and //TIPO='M'">
<!--		<br />
		<p align="center"><strong><xsl:copy-of select="document($doc)/translation/texts/item[@name='solicito_se_incluyan_los_cambios']/node()"/></strong></p>
-->
	</xsl:when>
	</xsl:choose>
		<xsl:apply-templates select="MantenimientoProductos/Form"/>
	</div>

	<!--frame para las imagenes-->
	<div id="uploadFrameBox" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>
	<div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>
</body>
</html>
</xsl:template>

<xsl:template match="MantenimientoProductos/Form">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="../LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="divLeft">
	<form name="form1" id="form1" method="post">
		<input type="hidden" name="IDPRODUCTO" value="{/MantenimientoProductos/Form/PRODUCTO/PRO_ID}"/>
		<input type="hidden" name="HISTORIA"/>
		<input type="hidden" name="PRO_BORRAR_VAL" value="N"/>
		<!--imagen proveedor, si modifica prov con imagen se la paso, si no se pierde-->
		<xsl:variable name="imaProve">mvm|<xsl:value-of select="PRODUCTO/IMAGENES/IMAGEN[@num='1']/@peq"/>|<xsl:value-of select="PRODUCTO/IMAGENES/IMAGEN[@num='1']/@grande"/>#</xsl:variable>
		<input type="hidden" name="CADENA_IMAGENES">
			<xsl:attribute name="value">
				<xsl:choose>
				<!--<xsl:when test="//ADMIN_MVM or //ADMIN_MVMB or //ADMIN"></xsl:when>-->
				<xsl:when test="/MantenimientoProductos/Form/PRODUCTO/ROL='COMPRADOR'"></xsl:when>
				<xsl:otherwise><xsl:value-of select="$imaProve"/></xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		</input>

		<input type="hidden" name="IMAGENES_BORRADAS"/>
		<input type="hidden" name="US_MVM">
			<xsl:attribute name="value">
				<xsl:choose>
				<!--<xsl:when test="//ADMIN_MVM or //ADMIN_MVMB">si</xsl:when>-->
				<xsl:when test="/MantenimientoProductos/Form/PRODUCTO/ROL='COMPRADOR'">si</xsl:when>
				<xsl:otherwise>no</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		</input>
            <input type="hidden" name="US_ADMINCLI">
			<xsl:attribute name="value">
				<xsl:choose>
				<xsl:when test="//ADMIN">si</xsl:when>
				<xsl:otherwise>no</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		</input>

		<input type="hidden" name="ROL" value="{/MantenimientoProductos/Form/PRODUCTO/ROL}"/>
		<input type="hidden" name="MANT_PRO" value="{//TIPO}"/>
		<input type="hidden" name="PAIS" value="{PRODUCTO/IDPAIS}"/>
		<input type="hidden" name="PRO_LISTA_CAMBIOS"/>

		<!--input hidden carga documentos-->
		<input type="hidden" name="REMOVE" value="{document($doc)/translation/texts/item[@name='remove']/node()}"/>
		<input type="hidden" name="CADENA_DOCUMENTOS"/>
		<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
		<input type="hidden" name="ID_USUARIO" value="{//Form/PRODUCTO/USUARIO/US_ID}"/>
		<input type="hidden" name="TIPO_DOC"/>
		<input type="hidden" name="DOC_NOMBRE"/>
		<input type="hidden" name="DOC_DESCRI"/>
		<!--fine input hidden carga documentos-->

		<input type="hidden" name="BORRAR_ANTERIORES"/>
		<!--input hidden compruebo que algo cambia, para solicitudes proveedores-->
		<input type="hidden" name="ANT_PRO_REFERENCIA" value="{PRODUCTO/REFERENCIA_PROVEEDOR}"/>
		<input type="hidden" name="ANT_PRO_NOMBRE" value="{PRODUCTO/PRO_NOMBRE}"/>

		<input type="hidden" name="ANT_PRO_IDTIPOIVA" value="{PRODUCTO/PRO_IDTIPOIVA}"/>
		<input type="hidden" name="ANT_PRO_UNIDADBASICA" value="{PRODUCTO/PRO_UNIDADBASICA}"/>
		<input type="hidden" name="ANT_PRO_UNIDADESPORLOTE" value="{PRODUCTO/PRO_UNIDADESPORLOTE}"/>
		<input type="hidden" name="ANT_FARMACIA" value="{PRODUCTO/PRO_CATEGORIA}"/>
		<input type="hidden" name="ANT_FICHA" value="{PRODUCTO/FICHAS_TECNICAS/field/@current}"/>
		<input type="hidden" name="ANT_OFERTA" value="{PRODUCTO/OFERTAS/field/@current}"/>
		<input type="hidden" name="ANT_IMAGEN" value="{PRODUCTO/IMAGENES/IMAGEN/@peq}"/>
		<!--fin input hidden compruebo cambios -->

		<div class="divLeft">
		<!--<table class="infoTable incidencias" border="0" style="border:none;" cellspacing="5">-->
		<table class="buscador">
			<tr class="sinLinea">
			<xsl:choose>
			<!--22ene18	xsl:when test="(//ADMIN_MVM or //ADMIN_MVMB or //ADMIN)">-->
			<xsl:when test="/MantenimientoProductos/Form/PRODUCTO/ROL='COMPRADOR'">
				<td colspan="2" class="labelRight grisMed">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:<span class="camposObligatorios">*</span>&nbsp;
				</td>
				<td class="datosLeft" colspan="5">
				<xsl:choose>
				<xsl:when test="PRODUCTO/PRO_ID">
					<strong>
						<a>
							<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="PRODUCTO/IDPROVEEDOR"/>&amp;VENTANA=NUEVA','DetalleEmpresa',100,70,0,-30)</xsl:attribute>
							<xsl:value-of select="PRODUCTO/PROVEEDOR"/>
						</a>
					</strong>
					<input type="hidden" name="IDPROVEEDOR" value="{PRODUCTO/IDPROVEEDOR}"/>
					<!--input para ver si es nuevo prod o no, para comprobar-->
					<input type="hidden" name="CHANGE_PROV" value="N"/>
				</xsl:when>
				<xsl:otherwise>
					<select name="IDPROVEEDOR" id="IDPROVEEDOR">
						<option value="-1"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></option>
						<xsl:for-each select="PRODUCTO/PROVEEDORES/field/dropDownList/listElem">
							<xsl:if test="ID != '' ">
								<option value="{ID}"><xsl:value-of select="listItem"/></option>
							</xsl:if>
						</xsl:for-each>
					</select>
					<!--input para ver si es nuevo prod o no, para comprobar, si es S no ense?o los comprobar hasta que no subo un doc-->
					<input type="hidden" name="CHANGE_PROV" value="S"/>
				</xsl:otherwise>
				</xsl:choose>
				</td>
			</xsl:when>
			<xsl:otherwise>
				<!--input para ver si es nuevo prod o no, para comprobar, si es S no ense?o los comprobar hasta que no subo un doc-->
				<xsl:choose>
				<xsl:when test="PRODUCTO/PRO_ID">
					<input type="hidden" name="CHANGE_PROV" value="N"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="CHANGE_PROV" value="S"/>
				</xsl:otherwise>
				</xsl:choose>
				<!--fin de input para ver si es nuevo prod o no, para comprobar, si es S no ense?o los comprobar hasta que no subo un doc-->
				<input type="hidden" name="IDPROVEEDOR" value="{PRODUCTO/USUARIO/EMP_ID}"/>

				<td colspan="2">&nbsp;</td>
				<td colspan="3">
					<xsl:if test="PRODUCTO/PRO_STATUS = 'S' or PRODUCTO/PRO_STATUS = 'D'">
						<table class="infoTableAma">
							<tr class="sinLinea">
								<td>
									<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitud_rechazada_por_mvm']/node()"/>
									<xsl:if test="PRODUCTO/COMENTARIO != ''">
										:<xsl:value-of select="PRODUCTO/COMENTARIO"/>
									</xsl:if>
								</td>
							</tr>
						</table>
					</xsl:if>
				</td>
				<td colspan="2">&nbsp;</td>
			</xsl:otherwise>
			</xsl:choose>
			</tr>
			<xsl:if test="/MantenimientoProductos/Form/PRODUCTO/PACKS">
            	<tr class="sinLinea">
                	<td>&nbsp;</td>
                	<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='Incl_pack']/node()"/>:&nbsp;&nbsp;&nbsp;
					</td>
					<td class="datosLeft">
						<xsl:for-each select="/MantenimientoProductos/Form/PRODUCTO/PACKS/PACK">
							<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROManten.xsql?PRO_ID={PRO_ID}',100,80,0,0);"><xsl:value-of select="PRO_REFERENCIA"/>. <xsl:value-of select="PRO_NOMBRE"/></a><br/>
						</xsl:for-each>
					</td>
                	<td colspan="4">&nbsp;</td>
            	</tr>
			</xsl:if>
			<tr class="sinLinea">
				<td class="quince" rowspan="3">
				<xsl:choose>
				<xsl:when test="(/MantenimientoProductos/Form/PRODUCTO/ADMIN_MVM or /MantenimientoProductos/Form/PRODUCTO/ADMIN) and /MantenimientoProductos/Form/PRODUCTO/TIPO=''"></xsl:when>
				<xsl:when test="//TIPO=''">
					<img src="{/MantenimientoProductos/Form/PRODUCTO/USUARIO/URL_LOGOTIPO}" height="80px" width="160px"/>
				</xsl:when>
				<xsl:otherwise>
					<img src="{/MantenimientoProductos/Form/PRODUCTO/URL_LOGOTIPO}" height="80px" width="160px"/>
				</xsl:otherwise>
				</xsl:choose>
				</td>
				<td class="dies labelRight grisMed">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia']/node()"/>:<span class="camposObligatorios">*</span>&nbsp;
				</td>
				<td class="datosLeft" colspan="2">
					<input type="text" name="PRO_REFERENCIA" value="{PRODUCTO/REFERENCIA_PROVEEDOR}" size="20"/>&nbsp;
					<input type="hidden" name="PRO_REFERENCIA_ORIG" value="{PRODUCTO/REFERENCIA_PROVEEDOR}"/>
                        <a href="javascript:ValidarRefProd(document.forms['form1']);" style="text-decoration:none;">
                        <xsl:choose>
                        <xsl:when test="/MantenimientoProductos/LANG = 'portugues'">
                             <img src="http://www.newco.dev.br/images/comprobar-BR.gif" alt="Verificar"/>
						</xsl:when>
						<xsl:otherwise>
                             <img src="http://www.newco.dev.br/images/comprobar.gif" alt="Comprobar"/>
						</xsl:otherwise>
                        </xsl:choose>
					</a>
					<span id="RefProd_OK" style="display:none;">&nbsp;
                        <img src="http://www.newco.dev.br/images/recibido.gif">
                        <xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='referencia_correcta']/node()"/></xsl:attribute>
                        </img>
					</span>
					<span id="RefProd_ERROR" style="color:#FE2E2E;display:none;">&nbsp;
						<img src="http://www.newco.dev.br/images/error.gif">
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='existe_referencia']/node()"/></xsl:attribute>
						</img>&nbsp;
						<xsl:value-of select="document($doc)/translation/texts/item[@name='existe_ref_prod']/node()"/>
					</span>
					<span id="RefProd_VACIO" style="color:#FE2E2E;display:none;">&nbsp;
						<img src="http://www.newco.dev.br/images/error.gif">
						<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='existe_referencia']/node()"/></xsl:attribute>
						</img>&nbsp;
						<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia_obli']/node()"/>
					</span><br />
				</td>
				<td colspan="3">&nbsp;</td>
			</tr>

			<!--	28mar22	Quitamos la ref MVM, genera dudas a los usuarios OHSJD
			<tr class="sinLinea">
				<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='cod_mvm']/node()"/>:&nbsp;</td>
				<td class="datosLeft" colspan="6">
					<input type="text" name="PRO_REF_ESTANDAR" value="{PRODUCTO/REFERENCIA_ESTANDAR}" maxlength="8"/>&nbsp;
					<a class="botonLink"><xsl:attribute name="href">javascript:MostrarPagCatalogo('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoPrivadoProducto.xsql','producto',100,70,0,-30);</xsl:attribute><xsl:value-of select="document($doc)/translation/texts/item[@name='buscar_referencia']/node()"/></a>
				</td>
			</tr>
			-->

			<tr class="sinLinea">
				<td class="labelRight grisMed">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:<span class="camposObligatorios">*</span>&nbsp;<br/>
					<a class="font11">
						<xsl:attribute name="href">javascript:MostrarPagPersonalizada('PRODetalle.xsql?PRO_ID=<xsl:value-of select="PRODUCTO/PRO_ID"/>','producto',100,70,0,-30);</xsl:attribute>
						<xsl:value-of select="document($doc)/translation/texts/item[@name='ver_ficha']/node()"/></a>&nbsp;&nbsp;
				</td>
				<td class="datosLeft" colspan="3">
					<input type="hidden" name="textcount"/>
					<textarea name="PRO_NOMBRE" cols="70" rows="2">
						<xsl:attribute name="onkeyup">conteoDePulsaciones(this,'textcount',300)</xsl:attribute>
						<xsl:attribute name="onkeypress">longitudMaxima(this,300);</xsl:attribute>
						<xsl:value-of select="PRODUCTO/PRO_NOMBRE"/>
					</textarea>
					<input type="hidden" name="PRO_NOMBRE_ORIG" value="{PRODUCTO/PRO_NOMBRE}"/>
					<input type="hidden" name="PRO_NOMBRE2"/>
				</td>
				<td class="datosLeft" colspan="2">
					<xsl:if test="not(PRODUCTO/ADMIN_MVM) and not(PRODUCTO/ADMIN_MVMB) and not(PRODUCTO/ADMIN)">
						<span class="font11"><xsl:copy-of select="document($doc)/translation/texts/item[@name='es_necesario_que_escriban_sus_productos']/node()"/>.</span>
					</xsl:if>
				</td>
			</tr>

			<input type="hidden" name="PRO_DESCRIPCION"/>

			<tr class="sinLinea">
				<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>:&nbsp;</td>
				<td colspan="5" class="datosLeft">
					<xsl:call-template name="GENERAL_TEXTBOX">
						<xsl:with-param name="nom">PRO_MARCA</xsl:with-param>
						<xsl:with-param name="maxChars">100</xsl:with-param>
						<xsl:with-param name="valor"><xsl:value-of select="PRODUCTO/PRO_MARCA"/></xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>


			<xsl:if test="/MantenimientoProductos/Form/PRODUCTO/IDPAIS=57">
				<!--
				PRO_CODEXPEDIENTE,			- -	15ene18 Campos específicos para Colombia
				PRO_CODIUM,					- -	13feb20
				PRO_CODCUM,					- -	15ene18
				PRO_CODINVIMA	,			- -	15ene18
				PRO_FECHACADINVIMA	,		- -	15ene18
				PRO_CLASIFICACIONRIESGO,	- -	15ene18
				PRO_REGULADO				- -	15ene18
				-->
				<tr class="sinLinea">
					<td colspan="2" class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='CodExpediente']/node()"/>:&nbsp;</td>
					<td colspan="5" class="datosLeft">
						<xsl:call-template name="GENERAL_TEXTBOX">
							<xsl:with-param name="nom">PRO_CODEXPEDIENTE</xsl:with-param>
							<xsl:with-param name="maxChars">100</xsl:with-param>
							<xsl:with-param name="valor"><xsl:value-of select="PRODUCTO/PRO_CODEXPEDIENTE"/></xsl:with-param>
						</xsl:call-template>
					</td>
				</tr>
				<tr class="sinLinea">
					<td colspan="2" class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='CodIUM']/node()"/>:&nbsp;</td>
					<td colspan="5" class="datosLeft">
						<xsl:call-template name="GENERAL_TEXTBOX">
							<xsl:with-param name="nom">PRO_CODIUM</xsl:with-param>
							<xsl:with-param name="maxChars">100</xsl:with-param>
							<xsl:with-param name="valor"><xsl:value-of select="PRODUCTO/PRO_CODIUM"/></xsl:with-param>
						</xsl:call-template>
					</td>
				</tr>
				<tr class="sinLinea">
					<td colspan="2" class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='CodCUM']/node()"/>:&nbsp;</td>
					<td colspan="5" class="datosLeft">
						<xsl:call-template name="GENERAL_TEXTBOX">
							<xsl:with-param name="nom">PRO_CODCUM</xsl:with-param>
							<xsl:with-param name="maxChars">100</xsl:with-param>
							<xsl:with-param name="valor"><xsl:value-of select="PRODUCTO/PRO_CODCUM"/></xsl:with-param>
						</xsl:call-template>
					</td>
				</tr>
				<tr class="sinLinea">
					<td colspan="2" class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='CodINVIMA']/node()"/>:&nbsp;</td>
					<td colspan="5" class="datosLeft">
						<xsl:call-template name="GENERAL_TEXTBOX">
							<xsl:with-param name="nom">PRO_CODINVIMA</xsl:with-param>
							<xsl:with-param name="maxChars">100</xsl:with-param>
							<xsl:with-param name="valor"><xsl:value-of select="PRODUCTO/PRO_CODINVIMA"/></xsl:with-param>
						</xsl:call-template>
					</td>
				</tr>
				<tr class="sinLinea">
					<td colspan="2" class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='FechaCadINVIMA']/node()"/>:&nbsp;</td>
					<td colspan="5" class="datosLeft">
						<xsl:call-template name="GENERAL_TEXTBOX">
							<xsl:with-param name="nom">PRO_FECHACADINVIMA</xsl:with-param>
							<xsl:with-param name="maxChars">100</xsl:with-param>
							<xsl:with-param name="valor"><xsl:value-of select="PRODUCTO/PRO_FECHACADINVIMA"/></xsl:with-param>
						</xsl:call-template>
					</td>
				</tr>
				<tr class="sinLinea">
					<td colspan="2" class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='ClasRiesgo']/node()"/>:&nbsp;</td>
					<td colspan="5" class="datosLeft">
						<xsl:call-template name="GENERAL_TEXTBOX">
							<xsl:with-param name="nom">PRO_CLASIFICACIONRIESGO</xsl:with-param>
							<xsl:with-param name="maxChars">100</xsl:with-param>
							<xsl:with-param name="valor"><xsl:value-of select="PRODUCTO/PRO_CLASIFICACIONRIESGO"/></xsl:with-param>
						</xsl:call-template>
					</td>
				</tr>
				<tr class="sinLinea">
					<td colspan="2" class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='ProdRegulado']/node()"/>:&nbsp;</td>
					<td colspan="5" class="datosLeft">
                        <xsl:choose>
                        <xsl:when test="/MantenimientoProductos/Form/PRODUCTO/PRO_REGULADO='S'">
                        	<input type="checkbox" class="muypeq" name="PRO_REGULADO_CHK" checked="checked"/>
                        </xsl:when>
                        <xsl:otherwise>
                        	<input type="checkbox" class="muypeq" name="PRO_REGULADO_CHK"/>
                        </xsl:otherwise>
                        </xsl:choose>
						<input type="hidden" name="PRO_REGULADO"/>
					</td>
				</tr>
			</xsl:if>

			<tr class="sinLinea">
				<td colspan="2">&nbsp;</td>
				<td colspan="5" class="datosLeft">
					<div id="refPrecioObjetivo" style="font-family:Verdana, Arial, Helvetica, sans-serif; display:none; text-align:left;" align="left">
						<p class="rojoNormal">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_maximo_recomendado']/node()"/>:&nbsp;
							<input type="text" name="PRECIO_CAT_PRIV" class="noinput" value="" size="8" style="color:#FF0000; padding-bottom:3px; vertical-align:top;"/>&nbsp;
							<xsl:value-of select="document($doc)/translation/texts/item[@name='euros']/node()"/>&nbsp;&nbsp;
							<xsl:value-of select="document($doc)/translation/texts/item[@name='por']/node()"/>&nbsp;&nbsp;
							<input type="text" name="UDBA_CAT_PRIV" class="noinput" value="" size="15" style="color:#FF0000; padding-bottom:3px; vertical-align:top;"/>
						</p>
					</div>
				</td>
			</tr>

		<!--si es mvm ense?o unidad basica si no a 1-->
		<xsl:choose>
		<xsl:when test="(PRODUCTO/ADMIN_MVM or PRODUCTO/ADMIN or PRODUCTO/CDC)">
			<tr class="sinLinea">
				<td colspan="2" class="labelRight grisMed">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/>:<span class="camposObligatorios">*</span>&nbsp;
				</td>
				<td colspan="5" class="datosLeft">
					<xsl:call-template name="GENERAL_TEXTBOX">
						<xsl:with-param name="nom">PRO_UNIDADBASICA</xsl:with-param>
						<xsl:with-param name="maxChars">100</xsl:with-param>
						<xsl:with-param name="valor"><xsl:value-of select="PRODUCTO/PRO_UNIDADBASICA"/></xsl:with-param>
					</xsl:call-template>
					&nbsp;<span class="font11"><xsl:value-of select="document($doc)/translation/texts/item[@name='ej_unidad_basica']/node()"/>.</span>
					<xsl:if test="(PRODUCTO/ADMIN_MVM or PRODUCTO/ADMIN or PRODUCTO/CDC) and /MantenimientoProductos/TIPO='M' "><!--empaquetamientos solo en man prod-->
						&nbsp;<a href="javascript:MostrarPag('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Empaquetamientos.xsql?PRO_ID={PRODUCTO/PRO_ID}','Empaquetamiento')" class="botonLink">
						<xsl:choose>
						<xsl:when test="PRODUCTO/EMPAQUETAMIENTO_PRIVADO">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='hay_empaquetamientos_privados']/node()"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='empaquetamientos']/node()"/>
						</xsl:otherwise>
						</xsl:choose>
						</a>
					</xsl:if>
				</td>
			</tr>

			<tr class="sinLinea">
				<td colspan="2">&nbsp;</td>
				<td colspan="5" class="datosLeft"><span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='comprobar_text']/node()"/></span></td>
			</tr>
		</xsl:when>
		<xsl:otherwise>
			<tr class="sinLinea">
				<td colspan="2">&nbsp;</td>
				<td colspan="5" class="datosLeft"><span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='comprobar_text']/node()"/></span></td>
			</tr>

			<tr class="sinLinea">
				<td colspan="2">&nbsp;</td>
				<td colspan="3" class="datosLeft"><span class="font11 rojoNormal"><xsl:copy-of select="document($doc)/translation/texts/item[@name='validez_oferta']/node()"/></span></td>
				<td colspan="2">&nbsp;</td>
			</tr>

			<input type="hidden" name="PRO_UNIDADBASICA">
				<xsl:attribute name="value"><xsl:value-of select="document($doc)/translation/texts/item[@name='1_unidad']/node()"/></xsl:attribute>
                        </input>
		</xsl:otherwise>
		</xsl:choose>

                 <xsl:if test="PRODUCTO/ADMIN_MVM or PRODUCTO/ADMIN_MVMB or //ADMIN">
                    <tr class="sinLinea">
                            <td colspan="2" class="labelRight grisMed">
                                <xsl:value-of select="document($doc)/translation/texts/item[@name='requiere_presupuesto']/node()"/>:&nbsp;
                            </td>
                             <td class="datosLeft" colspan="5">
                                    <input type="hidden" name="PRO_REQUIEREPRESUPUESTO"/>
                            <xsl:choose>
                            <xsl:when test="/MantenimientoProductos/Form/PRODUCTO/PRO_REQUIEREPRESUPUESTO='S'">
                            <input type="checkbox" class="muypeq" name="PRO_REQUIEREPRESUPUESTO_CHK" checked="checked"/>
                            </xsl:when>
                            <xsl:otherwise>
                            <input type="checkbox" class="muypeq" name="PRO_REQUIEREPRESUPUESTO_CHK"/>
                            </xsl:otherwise>
                            </xsl:choose>
                            </td>
                    </tr>
                </xsl:if>
			<input type="hidden" name="TARIFAMVM_EURO" value="{//TARIFAMVM_EURO_CONFORMATO}"/>
			<input type="hidden" name="PRO_UNIDADBASICA_OLD" value="{//PRO_UNIDADBASICA}"/>

		<!--trozo nuevo para pasar string de valores 11-2-14 mc- - >
		<xsl:for-each select="PRODUCTO/DATOS_CLIENTE">
			<xsl:variable name="tipo"><xsl:value-of select="TIPO"/></xsl:variable>
			<xsl:variable name="nombre_corto"><xsl:value-of select="NOMBRE_CORTO"/></xsl:variable>
		<! - -<xsl:choose>
		 Solo mostramos la opcion de precio MVM si es usuario ADMIN  de Espanya o es Brasil
		<xsl:when test="not(/MantenimientoProductos/Form/PRODUCTO/IDPAIS = '34' and not(../ADMIN_MVM) and $tipo = 'OF')">- - >
			<tr class="sinLinea">
				<input type="hidden" name="IDCLIENTE_{$tipo}" id="IDCLIENTE_{$tipo}" value="{EMP_ID}"/>
        <input type="hidden" name="CLIENTE_ID_{$tipo}" id="CLIENTE_ID_{$tipo}" value="{EMP_ID}"/>
				<input type="hidden" name="ANTIGUEDAD_TARIFA_{$tipo}" id="ANTIGUEDAD_TARIFA_{$tipo}" value="{ANTIGUEDAD_TARIFA}"/>
				<input type="hidden" name="ANT_PRO_PRECIOUNITARIO_{$tipo}" id="ANT_PRO_PRECIOUNITARIO_{$tipo}" value="{TARIFA_EURO_CONFORMATO}"/>
				<input type="hidden" name="NOMBRE_CORTO_{$tipo}" id="NOMBRE_CORTO_{$tipo}" value="{NOMBRE_CORTO}"/>
				<input type="hidden" name="INPUT_IDOFERTA_{$tipo}" id="INPUT_IDOFERTA_{$tipo}"/>
				<input type="hidden" name="ANT_IDOFERTA_{$tipo}" id="ANT_IDOFERTA_{$tipo}" value="{OFERTAS/field/@current}"/>

				<td colspan="2" class="labelRight grisMed">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>&nbsp;<xsl:value-of select="NOMBRE_CORTO"/>:&nbsp;
				</td>
				<td class="datosLeft" colspan="5">
					<input type="text" name="PRO_PRECIOUNITARIO_{$tipo}" class="inputPrecio" id="PRO_PRECIOUNITARIO_{$tipo}" size="15" value="{TARIFA_CONFORMATO}"/>&nbsp;&nbsp;
					<select name="IDOFERTA_{$tipo}" id="IDOFERTA_{$tipo}" style="width:200px;">
						<xsl:for-each select="OFERTAS/field/dropDownList/listElem">
							<option value="{ID}">
								<xsl:if test="ID = ../../@current"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
								<xsl:value-of select="listItem"/>
							</option>
						</xsl:for-each>
					</select>&nbsp;&nbsp;

					<a href="javascript:verCargaDoc('{$tipo}');" title="Subir documento" class="botonLink">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_oferta']/node()"/>&nbsp;<xsl:value-of select="NOMBRE_CORTO"/>
					</a><xsl:text>&nbsp;&nbsp;</xsl:text>

					<xsl:if test="FECHA_LIMITE and (/MantenimientoProductos/Form/PRODUCTO/ADMIN_MVM or /MantenimientoProductos/Form/PRODUCTO/ADMIN_MVMB or /MantenimientoProductos/Form/PRODUCTO/ADMIN)">
                        <xsl:choose>
                            <!- -si hay oferta asociada NO puedo cambiar fecha limite validez precio- ->
                            <xsl:when test="OFERTAS/field/@current != ''">
                                <xsl:value-of select="FECHA_LIMITE" />
                                <input type="hidden" name="FECHA_LIMITE_{$tipo}" id="FECHA_LIMITE_{$tipo}" value="{FECHA_LIMITE}" size="10"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <!- -si no hay oferta asociada puedo cambiar fecha limite del precio- ->
                                <input type="text" name="FECHA_LIMITE_{$tipo}" id="FECHA_LIMITE_{$tipo}" value="{FECHA_LIMITE}" class="noinput" size="10"/>

                                <a style="text-decoration:none;" href="javascript:cambiaFecha('{$tipo}');" id="ModificaFecha_{$tipo}">
                                        <img src="http://www.newco.dev.br/images/modificar.gif" alt="Modificar Fecha"/>
                                </a>

                                <a style="text-decoration:none;display:none;" href="javascript:actualizarFechaLimite('{$tipo}');" id="EnviarFecha_{$tipo}">
                                        <img src="http://www.newco.dev.br/images/botonEnviar.gif" alt="Enviar Fecha L?mite"/>
                                </a>
                            </xsl:otherwise>
                        </xsl:choose>

					</xsl:if>
                    &nbsp;&nbsp;
                    <a id="comprobar_{$tipo}" style="display:none;" target="_blank">
                        <xsl:choose>
                            <xsl:when test="/MantenimientoProductos/LANG = 'portugues'">
                                <img src="http://www.newco.dev.br/images/comprobar-BR.gif" alt="Verificar"/>
							</xsl:when>
							<xsl:otherwise>
                               <img src="http://www.newco.dev.br/images/comprobar.gif" alt="Comprobar"/>
							</xsl:otherwise>
                       </xsl:choose>
                    </a>
				</td>

			</tr>
			<tr id="carga{$tipo}" class="cargas" style="display:none;">
				<td colspan="7">
					<xsl:call-template name="CargaDocumentos">
						<xsl:with-param name="tipo" select="$tipo"/>
						<xsl:with-param name="nombre_corto" select="$nombre_corto"/>
					</xsl:call-template>
				</td>
			</tr>

		<!- - Sólo visible para usuarios MVM (sólo España) - ->
		<xsl:if test="(/MantenimientoProductos/Form/PRODUCTO/ADMIN_MVM or /MantenimientoProductos/Form/PRODUCTO/ADMIN) and /MantenimientoProductos/Form/PRODUCTO/IDPAIS= '34'">
			<!- - campo para precios con IVA - ->
			<tr class="sinLinea">
				<td colspan="2" class="labelRight grisMed">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>&nbsp;<xsl:value-of select="NOMBRE_CORTO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='con_iva']/node()"/>:&nbsp;
				</td>
				<td class="datosLeft" colspan="5">
					<input type="text" name="PRO_PRECIOUNITARIO_IVA_{$tipo}" class="inputPrecioIVA" id="PRO_PRECIOUNITARIO_IVA_{$tipo}" size="15"/>&nbsp;
					<span class="alertPrecioIVA" id="alertPrecioIVA_{$tipo}" style="display:none">
						<img src="http://www.newco.dev.br/images/caution.gif">
							<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='alerta_precios_no_coinciden']/node()"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='alerta_precios_no_coinciden']/node()"/></xsl:attribute>
						</img>
					</span>
				</td>
			</tr>
			<!- - FIN campo para precios con IVA - ->
		</xsl:if>

		<!- -</xsl:when>
		<xsl:otherwise>
			<input type="hidden" name="IDCLIENTE_{$tipo}" id="IDCLIENTE_{$tipo}" value="{EMP_ID}"/>
			<input type="hidden" name="ANTIGUEDAD_TARIFA_{$tipo}" id="ANTIGUEDAD_TARIFA_{$tipo}" value="{ANTIGUEDAD_TARIFA}"/>
			<input type="hidden" name="ANT_PRO_PRECIOUNITARIO_{$tipo}" id="ANT_PRO_PRECIOUNITARIO_{$tipo}" value="{TARIFA_EURO_CONFORMATO}"/>
			<input type="hidden" name="PRO_PRECIOUNITARIO_{$tipo}" class="inputPrecio" id="PRO_PRECIOUNITARIO_{$tipo}" value="{TARIFA_EURO_CONFORMATO}"/>
			<input type="hidden" name="NOMBRE_CORTO_{$tipo}" id="NOMBRE_CORTO_{$tipo}" value="{NOMBRE_CORTO}"/>
			<input type="hidden" name="IDOFERTA_{$tipo}" id="IDOFERTA_{$tipo}" value="{OFERTAS/field/@current}"/>
			<input type="hidden" name="INPUT_IDOFERTA_{$tipo}" id="INPUT_IDOFERTA_{$tipo}"/>
			<input type="hidden" name="ANT_IDOFERTA_{$tipo}" id="ANT_IDOFERTA_{$tipo}" value="{OFERTAS/field/@current}"/>
		</xsl:otherwise>
		</xsl:choose>- ->
		</xsl:for-each>-->
		<!--fin de nuevo trozo para pasar stringa de valores 11-2-14 mc-->

   <!--unidad lote-->
     <tr class="sinLinea">
      <td colspan="2" class="labelRight grisMed">
        <xsl:value-of select="document($doc)/translation/texts/item[@name='ud_lote']/node()"/>:<span class="camposObligatorios">*</span>&nbsp;
      </td>
      <td colspan="5" class="datosLeft">

        		<xsl:call-template name="GENERAL_TEXTBOX">
          		<xsl:with-param name="nom">PRO_UNIDADESPORLOTE</xsl:with-param>
			<xsl:with-param name="maxChars">5</xsl:with-param>
          		<xsl:with-param name="valor"><xsl:value-of select="PRODUCTO/PRO_UNIDADESPORLOTE"/></xsl:with-param>
        		</xsl:call-template>&nbsp;
                <xsl:value-of select="document($doc)/translation/texts/item[@name='insertar_un_valor_numerico']/node()"/>
      </td>
      </tr>

    <!--iva solo si es spain-->
    <!--si espa?a ense?o iva si brasil no -->
    <xsl:choose>
      <xsl:when test="/MantenimientoProductos/Form/PRODUCTO/IDPAIS != '55'">
      <tr class="sinLinea">
      <td colspan="2" class="labelRight grisMed">
        <xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/>:<span class="camposObligatorios">*</span>&nbsp;
      </td>
      <td class="datosLeft" colspan="5">
        		<xsl:choose>
          		<xsl:when test="/MantenimientoProductos/Form/PRODUCTO/IVA">
            		<xsl:call-template name="desplegable">
              		<xsl:with-param name="path" select="/MantenimientoProductos/Form/PRODUCTO/IVA/field"></xsl:with-param>
            		</xsl:call-template>
          		</xsl:when>
          		<xsl:otherwise>
            		<select name="PRO_IDTIPOIVA">
                     <option value="3">0%</option>
                     <option value="2">4%</option>
                     <option value="8">10%</option>
                     <option value="21" selected="selected">21%</option>
        				</select>
          		</xsl:otherwise>
        		</xsl:choose>


       </td>
     </tr>
     </xsl:when>
     <xsl:otherwise><input type="hidden" name="PRO_IDTIPOIVA" value="3"/></xsl:otherwise>
     </xsl:choose>
    <!--<tr class="sinLinea"><td colspan="7">&nbsp;</td></tr>-->
      <tr class="sinLinea">
        <td colspan="2" class="labelRight grisMed">
       <xsl:value-of select="document($doc)/translation/texts/item[@name='certificacion']/node()"/>:&nbsp;
      </td>
      <td colspan="5" class="datosLeft">

        		<xsl:choose>
        			<xsl:when test="PRODUCTO/PRO_ID!=''">
        				<xsl:call-template name="GENERAL_TEXTBOX">
          				<xsl:with-param name="nom">PRO_VALOR_CERTIFICADO</xsl:with-param>
					<xsl:with-param name="maxChars">20</xsl:with-param>
          				<xsl:with-param name="valor"><xsl:value-of select="PRODUCTO/PRO_CERTIFICADOS"/></xsl:with-param>
        				</xsl:call-template>
        			</xsl:when>
        			<xsl:otherwise>
   							<input type="text" name="PRO_VALOR_CERTIFICADO" size="15" value="CE"/>
        			</xsl:otherwise>
        		</xsl:choose>

      </td>
      <input type="checkbox" class="muypeq" name="PRO_HOMOLOGADO" checked="checked" style="display:none;"/>
    </tr>
	<!--	29jun18	Ya no tiene sentido ocultar productos
    <xsl:if test="PRODUCTO/ADMIN_MVM or PRODUCTO/ADMIN_MVMB or PRODUCTO/ADMIN">
        <tr class="sinLinea">
      		<td colspan="2" class="labelRight grisMed">
        		<xsl:value-of select="document($doc)/translation/texts/item[@name='oculto']/node()"/>:&nbsp;
			</td>
     		 <td class="datosLeft" colspan="5">
			<input type="hidden" name="PRO_OCULTO"/>
        	<xsl:choose>
        	<xsl:when test="/MantenimientoProductos/Form/PRODUCTO/PRO_OCULTO='S'">
            	<input type="checkbox" class="muypeq" name="PRO_OCULTO_CHK" checked="checked"/>
        	</xsl:when>
        	<xsl:otherwise>
            	<input type="checkbox" class="muypeq" name="PRO_OCULTO_CHK"/>
        	</xsl:otherwise>
        	</xsl:choose>
			&nbsp; <xsl:value-of select="document($doc)/translation/texts/item[@name='oculto_expli']/node()"/>
			</td>
    	</tr>
    </xsl:if>
	-->

    <input type="hidden" name="FECHA_ACCION" value="" />
	<!--	ficha tecnica 			
      <tr class="sinLinea">
        <td colspan="2" class="labelRight grisMed">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='ficha_tecnica']/node()"/>:&nbsp;
        </td>
        <td class="datosLeft" colspan="4">
            <select name="IDFICHA" id="IDFICHA" style="width:200px;">

            	<xsl:for-each select="PRODUCTO/FICHAS_TECNICAS/field/dropDownList/listElem">
                <option value="{ID}">
                	<xsl:if test="ID = ../../@current">
                	<xsl:attribute name="selected">selected</xsl:attribute>
                    </xsl:if>
                <xsl:value-of select="listItem"/></option>
                </xsl:for-each>
            </select>
            &nbsp;
       	    <a href="javascript:verCargaDoc('FT');" id="verFichaDoc" style="text-decoration:none;">
            	<xsl:choose>
                <xsl:when test="/MantenimientoProductos/Form/PRODUCTO/IDPAIS = '55'">
            		<img src="http://www.newco.dev.br/images/subirFicheiro.gif" alt="Subir Ficheiro tecnico"/>
                </xsl:when>
                <xsl:otherwise>
            		<img src="http://www.newco.dev.br/images/subirFicha.gif" alt="Subir ficha técnica"/>
                </xsl:otherwise>
                </xsl:choose>

            </a>

        </td>
        <td>
            <a id="comprobar_FT" style="display:none; float:left;" target="_blank"><img src="http://www.newco.dev.br/images/comprobar.gif" alt="Comprobar"/></a>
        </td>
     </tr>
     <tr id="cargaFT" class="cargas" style="display:none;">
      	<td colspan="7">
        	<xsl:call-template name="CargaDocumentos">
            	<xsl:with-param name="tipo">FT</xsl:with-param>
            </xsl:call-template>
      	</td>
     </tr>
	 -->
  	 <tr class="sinLinea"><td colspan="7">&nbsp;</td></tr>
	
     <tr class="sinLinea">
        <td colspan="2" class="labelRight grisMed">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='imagen']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:
        </td>
        <td class="datosLeft" colspan="5">

            <span class="anadirImage">
            <xsl:variable name="ima" select="count(PRODUCTO/IMAGENES/IMAGEN)"/>

            	<xsl:choose>
            	<xsl:when test="$ima = '2'">
                    <xsl:for-each select="PRODUCTO/IMAGENES/IMAGEN">
                         <xsl:call-template name="imageMan"><xsl:with-param name="num" select="@num" /></xsl:call-template>
                    </xsl:for-each>
                </xsl:when>
                <xsl:when test="$ima = '1'">
                    <xsl:for-each select="PRODUCTO/IMAGENES/IMAGEN">
                          <xsl:call-template name="imageMan"><xsl:with-param name="num" select="@num" /></xsl:call-template>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                	  <xsl:call-template name="image"><xsl:with-param name="num" select="number(1)" /></xsl:call-template>

                </xsl:otherwise>
                </xsl:choose>
            </span>
            &nbsp;&nbsp;<span class="font11"><xsl:copy-of select="document($doc)/translation/texts/item[@name='formato_imagenes']/node()"/></span>
        	<div id="waitBox">&nbsp;</div>
        </td>
    </tr>
    <tr class="sinLinea">
    <td colspan="2">&nbsp;</td>
    <td colspan="4">

<!--
       <xsl:if test="(PRODUCTO/ADMIN_MVM or PRODUCTO/ADMIN_MVMB or PRODUCTO/ADMIN) and //TIPO='M'">
        <table class="infoTableAma" border="0">
       <!- -DOCUMENTOS COMERCIALES solo para mvm y solo si es manten, para nuevos no and //TIPO='M'- ->
          <tr class="sinLinea">
            <td class="datosLeft label cinquenta">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='documentos_del_producto']/node()"/>&nbsp;
            </td>
            <td align="right" class="cinquenta">
                <span class="rojo">[<xsl:value-of select="document($doc)/translation/texts/item[@name='confidencial_mvm']/node()"/>]</span>
           </td>
          </tr>
          <xsl:if test="PRODUCTO/DOCUMENTOS_COMERCIALES_PROD/DOCUMENTO">
          <tr class="sinLinea">
            <td class="datosLeft" colspan="2">
                <div id="confirmBoxEliminaDocumento" style="display:none;">
                    <span class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_eliminado']/node()"/>.</span>
               </div>
               <div id="waitBoxEliminaDocumento" style="display:none;"></div>

                <table class="docuProd">
                <xsl:for-each select="PRODUCTO/DOCUMENTOS_COMERCIALES_PROD/DOCUMENTO">
                <tr style="border:1px solid grey;">
                <td class="quince datosLeft">-&nbsp;<xsl:value-of select="NOMBRE"/></td>
                <td class="dies datosLeft"><xsl:value-of select="USUARIO"/></td>
                <td class="cinco datosLeft">
                    <a>
                    <xsl:attribute name="href">http://www.newco.dev.br/Documentos/<xsl:value-of select="URL"/></xsl:attribute>
                        <img src="http://www.newco.dev.br/images/descarga.gif" alt="Descarga"/>
                    </a>
                </td>
                <td class="cinco datosLeft">
                    <a><xsl:attribute name="href">javascript:EliminarDocumentoDeProducto('<xsl:value-of select="ID"/>');</xsl:attribute>
                        <img src="http://www.newco.dev.br/images/eliminarOferta.gif" alt="Eliminar"/>
                    </a>
                </td>
                </tr>
                </xsl:for-each>
                </table>
            </td>
          </tr>
           <tr class="sinLinea"><td colspan="4">&nbsp;</td></tr>
          </xsl:if>
          <!- -cargar documentos
          <tr class="sinLinea">
            <td class="datosLeft" colspan="2">
                &nbsp;&nbsp;<select name="IDDOCUMENTO" id="IDDOCUMENTO" style="width:200px;">

                    <xsl:for-each select="PRODUCTO/DOCUMENTOS_COMERCIALES_PROV/field/dropDownList/listElem">
                    <option value="{ID}">
                        <xsl:if test="ID = ../../@current">
                        <xsl:attribute name="selected">selected</xsl:attribute>
                        </xsl:if>
                    <xsl:value-of select="listItem"/></option>
                    </xsl:for-each>
                </select>
                &nbsp;
                <a href="javascript:verCargaDoc('CO');" id="verDocuDoc" style="text-decoration:none;">
                    <img src="http://www.newco.dev.br/images/subirDocumento.gif" alt="Subir Documento"/>
                </a>
              &nbsp;&nbsp;&nbsp;
                    <a href="javascript:asociarAProducto();">
                        <img src="http://www.newco.dev.br/images/asociarAProducto.gif" alt="Asociar a producto"/>
                    </a>
                    <span id="confirmBoxAsocia" style="display:none;" class="rojo"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento_asociado_a_producto']/node()"/>.</span>
                    <div id="waitBoxAsocia" style="display:none;"></div>
            </td>
            <td>
            <a id="comprobar_Doc" style="display:none; float:left;" target="_blank"><img src="http://www.newco.dev.br/images/comprobar.gif" alt="Comprobar"/></a>
        	</td>
         </tr>
         <tr id="cargaCO" class="cargas" style="display:none;">
            <td colspan="3">
                <xsl:call-template name="CargaDocumentos">
                    <xsl:with-param name="tipo">CO</xsl:with-param>
                </xsl:call-template>
            </td>
         </tr>
         <tr class="sinLinea"><td colspan="2">&nbsp;</td></tr>
         </table><!- -fin de tabla documentos- ->
        </xsl:if><!- -fin de documentyos comerciales- ->
-->

    </td>
    <td>&nbsp;</td>
    </tr>
   </table><!--fin de infoTableAma-->
  </div><!--fin de divLeft35 producto-->


  <input type="hidden" name="PRO_ID" value="{PRODUCTO/PRO_ID}"/>

  <div class="divLeft" id="botonesMantenPRO">
  	<p align="center">
    	<xsl:value-of select="document($doc)/translation/texts/item[@name='los_campos_marcados_con']/node()"/>
       (<span class="camposObligatorios"> * </span>)
        <xsl:value-of select="document($doc)/translation/texts/item[@name='son_obligatorios']/node()"/>
  	<br/>

    	<xsl:value-of select="document($doc)/translation/texts/item[@name='aceptacion_mvm']/node()"/>
    </p>
    <br />
	<!--
        	<div class="divLeft20">&nbsp;</div>
        	<div class="divLeft20">
       			<div class="boton">

                    <a>
                        <xsl:attribute name="href">
                            <xsl:choose>
                                <xsl:when test="/MantenimientoProductos/TIPO = 'M'">javascript:window.close();</xsl:when>
                                <xsl:otherwise>javascript:document.location='about:blank';</xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
                    </a>
       			</div>
     		</div>
            <!- -si es proveedor meno espacio porque hay un boton mas- ->
            <div>
            	<xsl:attribute name="class">
                    <xsl:choose>
                    <!- -MVM- ->
                    <xsl:when test="not(PRODUCTO/ADMIN_MVM) and not(PRODUCTO/ADMIN_MVMB) and not(PRODUCTO/ADMIN) and //TIPO = 'M'">divLeft5</xsl:when>
                    <!- -proveedor- ->
                    <xsl:otherwise>divLeft3</xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                &nbsp;
            </div>
            <xsl:if test="//ADMIN_MVM or //ADMIN_MVMB or //ADMIN">
            <div class="divLeft20" id="botonCopiar">
       			<div class="boton">
                            <a href="javascript:CrearNuevoProd(document.forms[0],'PROMantenSave.xsql');">
                                <xsl:value-of select="document($doc)/translation/texts/item[@name='crear_nuevo_producto']/node()"/>
                            </a>
       			</div>
            </div><!- -fin divLeft20 crear nuevo producto- ->
            </xsl:if>
            <div class="divLeft20" id="botonGuardar">
       			<div class="boton">
                  <xsl:choose>
                  <xsl:when test="//ADMIN_MVM or //ADMIN_MVMB or //PRODUCTO/ADMIN">
                	<a href="javascript:EnviaProd(document.forms[0],'PROMantenSave.xsql');">
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/>
                        </a>
                  </xsl:when>
                  <xsl:otherwise>
                  <!- -si es proveedor pongo solicitud- ->
                      <a href="javascript:CompruebaCambios(document.forms[0],'PROMantenSave.xsql');">
                      	<xsl:value-of select="document($doc)/translation/texts/item[@name='solicitar']/node()"/>
                      </a>
                  </xsl:otherwise>
                  </xsl:choose>
       			</div>
     		</div><!- -fin divLeft20 solicitar- ->
            <!- -si es proveedor borrar producto boton, si no input hidden- ->
             <xsl:choose>
                <xsl:when test="not(PRODUCTO/ADMIN_MVM) and not(PRODUCTO/ADMIN_MVMB) and not(PRODUCTO/ADMIN) and //TIPO = 'M'"> <!- -proveedor- ->
                	<input type="hidden" name="PRO_BORRAR_VAL" value="N"/>
                 	<div class="divLeft5">&nbsp;</div>
                    <div class="divLeft20">
       					<div class="boton">
                        <a href="javascript:BorrarProd(document.forms[0],'PROMantenSave.xsql');">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_producto']/node()"/>
                        </a>
                        </div>
                    </div>
                 </xsl:when>
                 <xsl:otherwise> <!- -mvm- ->
                     <input type="hidden" name="PRO_BORRAR_VAL"/>
                 </xsl:otherwise>
                 </xsl:choose>
           <br /><br />
	-->

    </div><!--fin divleft botones-->
 </form>




  </div><!--fin de divleft-->
  <div class="divLeft" style="height:20px;">&nbsp;</div>


 <!--form de mensaje de error de js-->
   <form name="mensajeJS">

	<input type="hidden" name="OFERTA_OBLI_CLIENTE" value="{document($doc)/translation/texts/item[@name='oferta_obligatoria_cliente']/node()}"/>

	<input type="hidden" name="OFERTA_ACEPTADA_CLIENTE" value="{document($doc)/translation/texts/item[@name='oferta_aceptada_cliente']/node()}"/>

        <input type="hidden" name="TODAVIA_NO" value="{document($doc)/translation/texts/item[@name='todavia_no']/node()}"/>
        <input type="hidden" name="PROVEEDOR_OBLI" value="{document($doc)/translation/texts/item[@name='proveedor_obli']/node()}"/>
        <input type="hidden" name="NOMBRE_OBLI" value="{document($doc)/translation/texts/item[@name='nombre_obli']/node()}"/>
        <input type="hidden" name="REFERENCIA_OBLI" value="{document($doc)/translation/texts/item[@name='referencia_obli']/node()}"/>
        <input type="hidden" name="UNIDAD_BASICA_OBLI" value="{document($doc)/translation/texts/item[@name='unidad_basica_obli']/node()}"/>
        <input type="hidden" name="UN_LOTE_OBLI" value="{document($doc)/translation/texts/item[@name='un_lote_obli']/node()}"/>
        <input type="hidden" name="RELLENE_OBLI" value="{document($doc)/translation/texts/item[@name='rellene_obligatorios']/node()}"/>
        <input type="hidden" name="EL_CAMPO" value="{document($doc)/translation/texts/item[@name='el_campo']/node()}"/>
        <input type="hidden" name="ES_OBLI" value="{document($doc)/translation/texts/item[@name='es_obligatorio']/node()}"/>
        <input type="hidden" name="CANT_CORRECTA" value="{document($doc)/translation/texts/item[@name='cantidad_correcta']/node()}"/>
        <input type="hidden" name="TIPO_OBLI" value="{document($doc)/translation/texts/item[@name='seleccione_tipo_prod']/node()}"/>
        <input type="hidden" name="SEGURO_BORRAR" value="{document($doc)/translation/texts/item[@name='solicitar_borrar']/node()}"/>
        <input type="hidden" name="DIGITOS_INCORRECTOS" value="{document($doc)/translation/texts/item[@name='referencia_estandar_8_digitos']/node()}"/>
        <input type="hidden" name="PRECIOS_VACIOS" value="{document($doc)/translation/texts/item[@name='precios_vacios']/node()}"/>
        <input type="hidden" name="NO_CAMBIOS_NO_SOLICITUD" value="{document($doc)/translation/texts/item[@name='no_cambios_no_solicitud']/node()}"/>
        <input type="hidden" name="SELECCIONAR_PROVEEDOR" value="{document($doc)/translation/texts/item[@name='seleccionar_proveedor']/node()}"/>
        <input type="hidden" name="SEGURO_ELIMINAR_DOCUMENTO" value="{document($doc)/translation/texts/item[@name='seguro_eliminar_documento']/node()}"/>
        <input type="hidden" name="SELECCIONA_OFERTA" value="{document($doc)/translation/texts/item[@name='selecciona_oferta']/node()}"/>
        <input type="hidden" name="CAR_RAROS" value="{document($doc)/translation/texts/item[@name='caracteres_raros_sin_barra']/node()}"/>
        <input type="hidden" name="NO_MISMA_REFERENCIA" value="{document($doc)/translation/texts/item[@name='no_misma_referencia']/node()}"/>

        <!--carga documentos-->
        <input type="hidden" name="ERROR_SIN_DEFINIR" value="{document($doc)/translation/texts/item[@name='error_sin_definir']/node()}"/>
        <input type="hidden" name="HEMOS_ESPERADO" value="{document($doc)/translation/texts/item[@name='hemos_esperado']/node()}"/>
        <input type="hidden" name="LA_CARGA_NO_TERMINO" value="{document($doc)/translation/texts/item[@name='la_carga_no_termino']/node()}"/>
        <input type="hidden" name="CARGANDO_IMAGEN" value="{document($doc)/translation/texts/item[@name='cargando_imagen']/node()}"/>
        <input type="hidden" name="FICHA_OBLIGATORIA" value="{document($doc)/translation/texts/item[@name='ficha_obligatoria']/node()}"/>
        <input type="hidden" name="FECHA_LIMITE_OBLI" id="FECHA_LIMITE_OBLI" value="{document($doc)/translation/texts/item[@name='fecha_limite_obli']/node()}" />
        <input type="hidden" name="ERROR_GUARDAR_FECHA" id="ERROR_GUARDAR_FECHA" value="{document($doc)/translation/texts/item[@name='error_guardar_fecha']/node()}" />
        <input type="hidden" name="ERROR_UN_LOTE_NO_NUMERO" id="ERROR_UN_LOTE_NO_NUMERO" value="{document($doc)/translation/texts/item[@name='error_un_lote_no_numero']/node()}" />
        <input type="hidden" name="ERROR_PRECIO_NO_NUMERO" id="ERROR_PRECIO_NO_NUMERO" value="{document($doc)/translation/texts/item[@name='error_precio_no_numero']/node()}" />


    </form>
 <!--fin de form de mensaje de error de js-->
</xsl:template>

 <xsl:template name="GENERAL_TEXTBOX">
   <xsl:param name="nom"/>
   <xsl:param name="valor"/>
   <xsl:param name="size">15</xsl:param>
   <xsl:param name="perderFoco"/>
   <xsl:param name="maxChars"/>

   <input type="text" name="{$nom}" size="{$size}" value="{$valor}">
     <xsl:if test="$perderFoco!=''">
       <xsl:attribute name="onBlur"><xsl:value-of select="$perderFoco"/></xsl:attribute>
     </xsl:if>
     <xsl:if test="$maxChars!=''">
       <xsl:attribute name="maxlength"><xsl:value-of select="$maxChars"/></xsl:attribute>
     </xsl:if>
   </input>
</xsl:template>

<!--INICIO TEMPLATE IMAGE-->
 <xsl:template name="image">
	<xsl:param name="num" />
	<div class="imageLine" id="imageLine_{$num}">
			<label class="medium" for="inputFile_{$num}" style="display:none;">&nbsp;</label>
			<input id="inputFile_{$num}" name="inputFile" type="file" onchange="addFile({$num});" />
	</div>
</xsl:template>

<!--INICIO TEMPLATE IMAGE Mantenimiento-->
<xsl:template name="imageMan">
	<xsl:param name="num" />

	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="../../../../LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="imageLine" id="imageLine_{$num}">
		<label for="inputFile_{$num}" id="labelFile_{$num}">
			<xsl:if test="@id != '-1' or $num != '0'">
				<xsl:attribute name="style">display:none;</xsl:attribute>
			</xsl:if>
			&nbsp;<xsl:value-of select="$num"/>:&nbsp;
		</label>
		<input id="inputFile_{$num}" name="inputFile" type="file" onchange="addFile({$num});">
			<xsl:if test="@id != '-1' or $num != '0'">
				<xsl:attribute name="style">display:none;</xsl:attribute>
			</xsl:if>
		</input>

		<xsl:if test="@id != '-1'">
			<div class="imageManten">
				<label class="medium" for="inputFile_{$num}" style="display:none;">&nbsp;<xsl:value-of select="$num"/>:&nbsp;</label>
				<img src="http://www.newco.dev.br/Fotos/{@peq}" class="manFoto"/>
				<xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
				<a id="deleteLink_{$num}" href="javascript:void();" onclick="this.parentNode.style.display='none'; return deleteFile({@id}, {$num});">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/>
				</a>
			</div>
		</xsl:if>
	</div>
</xsl:template>
<!--fin de template image-->


<!--template carga documentos-->
<xsl:template name="CargaDocumentos">
	<xsl:param name="tipo"/>
	<xsl:param name="nombre_corto"/>

	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/MantenimientoProductos/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="divLeft" id="cargaDoc{$tipo}">
		<div id="confirmBox{$tipo}" style="display:none;" align="center">
			<span class="cargado">?<xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/>!</span>
		</div>

		<!--tabla imagenes y documentos-->
		<table class="infoTable" border="0">
			<tr>
				<!--documentos-->
				<td class="veintecinco">&nbsp;</td>
				<td class="labelRight dies">
					<span class="text{$tipo}">
						<xsl:choose>
						<xsl:when test="$nombre_corto != ''">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_oferta']/node()"/><!--&nbsp;<xsl:value-of select="$nombre_corto"/>-->
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_ficha']/node()"/>
						</xsl:otherwise>
						</xsl:choose>
                   </span>
				</td>
				<td class="datosLeft quince">
					<div class="altaDocumento">
						<span class="anadirDoc">
							<xsl:call-template name="documentos">
								<xsl:with-param name="num" select="number(1)"/>
								<xsl:with-param name="type" select="$tipo"/>
							</xsl:call-template>
						</span>
					</div>
				</td>
				<td class="dies">
						<a href="javascript:cargaDoc(document.forms['form1'],'{$tipo}');" class="botonLink">
							<span class="text{$tipo}">
								<xsl:choose>
								<xsl:when test="$nombre_corto != ''">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_oferta']/node()"/><!--&nbsp;<xsl:value-of select="$nombre_corto"/>-->
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_ficha']/node()"/>
								</xsl:otherwise>
								</xsl:choose>
                            </span>
						</a>
				</td>
				<td>&nbsp;</td>
			</tr>
		</table><!--fin de tabla imagenes doc-->

		<div id="waitBoxDoc{$tipo}" align="center">&nbsp;</div>
	</div><!--fin de divleft-->
</xsl:template><!--fin de template carga documentos-->

<!--documentos-->
<xsl:template name="documentos">
	<xsl:param name="num" />
    <xsl:param name="type" />
	<xsl:choose>
		<xsl:when test="$num &lt; number(5)">
			<div class="docLine" id="docLine_{$type}">

				<div class="docLongEspec" id="docLongEspec_{$type}">
					<input id="inputFileDoc_{$type}" name="inputFileDoc" type="file" onChange="addDocFile('{$type}');" />
				</div>
			</div>
		</xsl:when>

	</xsl:choose>
    </xsl:template>
<!--fin de documentos-->


<!--template carga documentos-->
<xsl:template name="CargaDocumentosNormal">
	<xsl:param name="tipo" />

	<!--idioma-->
        <xsl:variable name="lang">
        	<xsl:value-of select="/MantenimientoProductos/LANG" />
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->

    <div class="divLeft" id="cargaDoc{$tipo}">

    <div id="confirmBox{$tipo}" style="display:none;" align="center"><span class="cargado">?<xsl:value-of select="document($doc)/translation/texts/item[@name='documento_cargado']/node()"/>!</span></div>

  <!--tabla imagenes y documentos-->
  <table class="infoTable" border="0">
  <tr>
     <!--documentos-->
        <td class="veintecinco labelRight">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_documento']/node()"/>:&nbsp;
        </td>

        <td class="datosLeft quince">
       	<div class="altaDocumento">

            <span class="anadirDoc">
                <xsl:call-template name="documentos">
                	<xsl:with-param name="num" select="number(1)" />
                    <xsl:with-param name="type" select="$tipo"/>
            	</xsl:call-template>
            </span>
        </div>
        </td>
        <td class="dies">
        	<div class="boton">
                	<a href="javascript:cargaDoc(document.forms['form1'],'{$tipo}');">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_documento']/node()"/>&nbsp;</a>
       			</div>
        </td>
        <td>&nbsp;</td>
     </tr>
  </table><!--fin de tabla imagenes doc-->

  <div id="waitBoxDoc{$tipo}" align="center">&nbsp;</div>

  </div><!--fin de divleft-->

</xsl:template><!--fin de template carga documentos-->
</xsl:stylesheet>
