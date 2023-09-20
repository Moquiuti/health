<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Ficha de producto (de proveedor)
		Ultima revision: ET 14jun23 10:50 PRODetalle2022_140623.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:import href = "http://www.newco.dev.br/Administracion/Mantenimiento/Productos/ProductosEquivalentes.xsl"/>
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
		<xsl:when test="/Productos/LANG"><xsl:value-of select="/Productos/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="/Productos/PRODUCTO/PRODUCTO/REFERENCIA_PROVEEDOR"/>&nbsp;<xsl:value-of select="/Productos/PRODUCTO/PRODUCTO/PRO_NOMBRE"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='detalle_producto']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>

	<script type="text/javascript">

		var lang	= '<xsl:value-of select="/Productos/LANG"/>';
		var IDIdioma	= '<xsl:value-of select="/Productos/PRODUCTO/PRODUCTO/IDIDIOMA"/>';
		var IDProducto	= '<xsl:value-of select="/Productos/PRODUCTO/PRODUCTO/PRO_ID"/>';
		var IDProveedor	= '<xsl:value-of select="/Productos/PRODUCTO/PRODUCTO/IDPROVEEDOR"/>';

		<!-- Mensajes Validacion Formulario Productos Equivalentes -->
		var comprIncidencias	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='comprueba_incidencias']/node()"/>';
		var errRefEquiv		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='errorRefEquiv']/node()"/>';
		var errProvSelEquiv	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='errorProvSelEquiv']/node()"/>';
		var errProvManualEquiv	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='errorProvManualEquiv']/node()"/>';
		var errNombreEquiv	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='errorNombreEquiv']/node()"/>';
		var errMarcaEquiv	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='errorMarcaEquiv']/node()"/>';
		var errEstadoEquiv	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='errorEstadoEquiv']/node()"/>';
		var errNoIDProv		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='errorNoIDProv']/node()"/>';
		var errProvManual	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='errorProvManual']/node()"/>';

		<!-- Mensajes Peticion ajax Nuevo Producto Equivalente -->
		var nuevoEquiv_ok	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='okNuevoEquiv']/node()"/>';
		var nuevoEquiv_error	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='errorNuevoEquiv']/node()"/>';
		var sinFichaTecnica	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_ficha']/node()"/>';

		<!-- Mensajes Peticion ajax Borrar Producto Equivalente -->
		var borrarEquiv_ok	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='okBorrarEquiv']/node()"/>';
		var borrarEquiv_error	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='errorBorrarEquiv']/node()"/>';
		var borrar		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>';
 		var sinProdEquiv	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_productos_equiv_manuales']/node()"/>';
		var seguroBorrarProducto	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='seguro_borrar_producto']/node()"/>';

		var IDEmpresaCompradora	= '<xsl:value-of select="/Productos/IDEMPRESA_COMPRADORA"/>';

		<!-- Variables y Strings JS para las etiquetas -->
		//var IDRegistro = '<xsl:value-of select="/Productos/PRODUCTO/PRODUCTO/PRO_ID"/>';
		var IDTipo = 'PROD';
		var str_NuevaEtiquetaGuardada	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta_guardada']/node()"/>';
		var str_NuevaEtiquetaError		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_etiqueta_error']/node()"/>';
		var str_autor			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/>';
		var str_fecha			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>';
		var str_etiqueta	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='etiqueta']/node()"/>';
		var str_borrar		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>';
		<!-- FIN Variables y Strings JS para las etiquetas -->

	</script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle2022_140623.js"></script>
</head>

<!--<body onload="getURLParameter('DEST');">-->
<body>
<xsl:choose>
<xsl:when test="Productos/SESION_CADUCADA">
	<xsl:for-each select="Productos/SESION_CADUCADA">
		<xsl:if test="position()=last()">
			<xsl:apply-templates select="."/>
		</xsl:if>
	</xsl:for-each>
</xsl:when>
<xsl:when test="//xsql-error">
	<xsl:apply-templates select="//xsql-error"/>
</xsl:when>
<xsl:when test="Productos/LIC_PROD_ID != ''">
	<xsl:apply-templates select="Productos/PRODUCTO/PRODUCTOLICITACION"/>
</xsl:when>
<!--si borramos el producto devuelve esto-->
<xsl:when test="not(Productos/PRODUCTO/PRODUCTO) or Productos/PRODUCTO/PRODUCTO/PRO_STATUS = 'B' ">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Productos/LANG"><xsl:value-of select="/Productos/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<h1 class="titlePage">
    <xsl:choose>
    <xsl:when test="/Productos/PRODUCTO_BORRADO/OK or Productos/PRODUCTO/PRODUCTO/PRO_STATUS = 'B'">
    	<xsl:value-of select="document($doc)/translation/texts/item[@name='producto_eliminado']/node()"/>
    </xsl:when>
    <xsl:when test="/Productos/PRODUCTO_BORRADO/ERROR">
      <xsl:value-of select="/Productos/PRODUCTO_BORRADO/ERROR"/>
    </xsl:when>
    </xsl:choose>
	</h1>

  <p>&nbsp;</p>
  <p style="text-align:center;">
    <img src="http://www.newco.dev.br/images/cerrar.gif"/>&nbsp;
    <a href="javascript:Salir();" title="cerrar"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>
  </p>
</xsl:when>
<xsl:otherwise>
	<xsl:apply-templates select="Productos/PRODUCTO/PRODUCTO"/>
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>

<xsl:template match="PRODUCTO">
	<form action="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROBorrarSave.xsql" name="Busqueda" method="POST">
		<input type="hidden" name="PRO_ID" value="{PRO_ID}"/>
	</form>

	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Productos/LANG"><xsl:value-of select="/Productos/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:variable name="usuario">
		<xsl:choose>
		<xsl:when test="/Productos/PRODUCTO/PRODUCTO/OBSERVADOR">OBSERVADOR</xsl:when>
		<xsl:when test="/Productos/PRODUCTO/PRODUCTO/MVM or /Productos/PRODUCTO/PRODUCTO/MVMB or /Productos/PRODUCTO/PRODUCTO/CDC">CDC</xsl:when>
		<xsl:otherwise>NORMAL</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<div><!--	contiene todo lo que hay bajo las pestañas	-->
	
		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
				<xsl:choose>
				<xsl:when test="NOMBRE_PRIVADO">
					<xsl:value-of select="substring(NOMBRE_PRIVADO, 1, 60)"/>
				</xsl:when>
				<xsl:when test="PRO_ID">
					<xsl:choose>
					<xsl:when test="string-length(PRO_NOMBRE) > 60">
						<xsl:value-of select="REFERENCIA_PROVEEDOR"/>&nbsp;<xsl:value-of select="substring(PRO_NOMBRE, 1, 60)"/>...
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="REFERENCIA_PROVEEDOR"/>&nbsp;<xsl:value-of select="PRO_NOMBRE"/>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				</xsl:choose>
				<xsl:if test="/Productos/PRODUCTO/PRODUCTO/MVM or /Productos/PRODUCTO/PRODUCTO/CDC">&nbsp;<span class="amarillo">PRO_ID: <xsl:value-of select="PRO_ID"/></span></xsl:if>
				<span class="CompletarTitulo">
        			<a class="btnNormal" href="javascript:AnalisisPedidos('{PRO_ID}');">
            			<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>
        			</a>&nbsp;
        			<a class="btnNormal" href="javascript:HistoricoTarifas('{PRO_ID}','{IDEMPRESADELUSUARIO}');">
            			<xsl:value-of select="document($doc)/translation/texts/item[@name='Historico_tarifas']/node()"/>
        			</a>&nbsp;
 					<xsl:if test="MVM and PRO_ID">
        				<a class="btnDestacado" href="javascript:Borrar();" title="borrar"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_producto']/node()"/></a>
						&nbsp;
					</xsl:if>
					<xsl:if test="$usuario = 'CDC' and /Productos/PRODUCTO/PRODUCTO/PRO_ESPACK='S'">
						<a class="btnNormal" href="javascript:VerPack('{/Productos/PRODUCTO/PRODUCTO/PRO_ID}');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='Pack']/node()"/>
						</a>
						&nbsp;
					</xsl:if>
					<xsl:if test="$usuario = 'CDC'">
						<a class="btnNormal" href="javascript:NuevaEvaluacion('{/Productos/PRODUCTO/PRODUCTO/PRO_ID}','{/Productos/PRODUCTO/PRODUCTO/IDPROVEEDOR}')">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='evaluacion']/node()"/>
						</a>
						&nbsp;
					</xsl:if>
					<xsl:if test="$usuario != 'OBSERVADOR'">
						<a class="btnNormal" href="javascript:NuevaIncidencia('{/Productos/PRODUCTO/PRODUCTO/PRO_ID}&amp;USER={$usuario}');">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='incidencia']/node()"/>
						</a>
						&nbsp;
					</xsl:if>
                    <!--modificar producto-->
                    <xsl:if test="(MVM or ADMIN or CDC) and PRO_ID != ''">
                        <a class="btnNormal" href="javascript:MantenProducto('{PRO_ID}','','');" >
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='Editar']/node()"/>Editar
                        </a>
						&nbsp;
                        <a class="btnNormal" href="javascript:FichaAdjudicacion('{PRO_ID}','{IDEMPRESADELUSUARIO}');">
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='Catalogo']/node()"/>Catalogo
                        </a>
						&nbsp;
                    </xsl:if>
				</span>
			</p>
		</div>
		<br/>
	
	</div>

	<!--productos equivalentes-->
	<div class="divLeft" id="productosEquivalentes" style="display:none;">
		<xsl:call-template name="productosEquivalentes">
			<xsl:with-param name="pro_id" select="/Productos/PRODUCTO/PRODUCTO/EQUIVALENTES/IDPRODUCTOESTANDAR"/>
		</xsl:call-template>
	</div><!--fin de productos equivalentes-->

	<!--ficha producto normal-->
	<div id="fichaProducto">

	<xsl:if test="/Productos/PRODUCTO/PRODUCTO/MVM">
	<div class="divLeft">
		<table class="buscador" cellspacing="6px" cellpadding="6px">
			<form action="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle2022.xsql" name="Cliente" method="POST">
				<input type="hidden" name="PRO_ID" value="{PRO_ID}"/>

        		<xsl:if test="/Productos/PRODUCTO/PRODUCTO/CLIENTESADJ/field/dropDownList/listElem/ID">
        		<tr>
        		  <td class="labelRight veinte">
            		<xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/>:&nbsp;
        		  </td>
        		  <td class="datosLeft">
            		<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Productos/PRODUCTO/PRODUCTO/CLIENTESADJ/field[@name='IDCLIENTE']/."/>
						<xsl:with-param name="onChange">this.form.submit();</xsl:with-param>
						<xsl:with-param name="style">height:28px;font-size:20px;width:500px;</xsl:with-param>
            		</xsl:call-template>
        		  </td>
        		</tr>
        		</xsl:if>
			</form>
			<tr><td colspan="2">&nbsp;</td></tr>
		</table>
	</div>
	</xsl:if>

	<!--datos originales producto-->
	<xsl:if test="(NOMBRE_PRIVADO or PRO_ID) and ORIGINAL">
		<div class="divLeft">
			<div class="originalPro divLeft">
				<xsl:attribute name="id">
					<xsl:if test="number(ORIGINAL/ANTIGUEDAD) &gt; number(365)">backAma</xsl:if><!--amarillo-->
					<xsl:if test="number(ORIGINAL/ANTIGUEDAD) &lt; number(365)">backRojo</xsl:if><!--rojo-->
				</xsl:attribute>

				<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='datos_originales_maiu']/node()"/></strong></p>
				<p>&nbsp;</p>
				<!--valores prod original-->
				<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='tarifa']/node()"/>:</label>
					<xsl:value-of select="ORIGINAL/TARIFA"/>
				</p>
				<p>&nbsp;</p>
				<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:</label>
					<xsl:value-of select="ORIGINAL/FECHA"/>
				</p>
				<p>&nbsp;</p>
				<!--  <p><a style="color:#000000;">
					<xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="ORIGINAL/ID"/>','producto',70,50,0,-50);</xsl:attribute>
				Ver original</a></p>-->
				<p><a style="color:#000000;" target="_blank">
					<xsl:attribute name="href">PRODetalle2022.xsql?PRO_ID=<xsl:value-of select="ORIGINAL/ID"/></xsl:attribute>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='ver_original']/node()"/></a></p>
			</div>
		</div><!--fin divLeft-->
	</xsl:if>

<!--si prod no esta borrado enseño tabla-->
<xsl:if test="NOMBRE_PRIVADO or PRO_ID">

    <div class="divLeft">
	    <!--imagen producto, logo-->
	    <div class="divLeftw w240px textRight">

	    	<p><img src="{/Productos/PRODUCTO/PRODUCTO/URL_LOGOTIPO}" height="auto" width="200px" /></p>
	      <p>&nbsp;</p>
	      <!--imagenes-->
	      <xsl:if test="(count(/Productos/PRODUCTO/PRODUCTO/IMAGENES/IMAGEN)) &gt; 0">
	      	<xsl:for-each select="/Productos/PRODUCTO/PRODUCTO/IMAGENES/IMAGEN">
	        	<xsl:if test="@id != '-1'">
					<xsl:choose>
					<xsl:when test="TIPO_URL='Completa'">
	            		<p><a href="http://www.newco.dev.br/{URL_GRANDE}" rel="lightbox" title="Foto producto" style="text-decoration:none;">
	            		  <img src="http://www.newco.dev.br/{URL_GRANDE}" style="max-width:200px;max-height:200px;"/>
	            		</a></p>
					</xsl:when>
					<xsl:otherwise>
	            		<p><a href="http://www.newco.dev.br/Fotos/{@grande}" rel="lightbox" title="Foto producto" style="text-decoration:none;">
	            			<img src="http://www.newco.dev.br/Fotos/{@peq}" style="max-width:200px;max-height:200px;"/>
	            		</a></p>
					</xsl:otherwise>
					</xsl:choose>
	        	</xsl:if>
	        </xsl:for-each>
	      </xsl:if>
	 			<!--fin de imagenes-->
	    </div><!--fin de divLeft30nopa-->

   		<!--tabla especificas producto-->
		<div class="divLeft70nopa">
		<table class="buscador" cellspacing="6px" cellpadding="6px">
		<tbody>
		<tr>
			<!--proveedor-->
			<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:&nbsp;</td>
			<td class="datosLeft" colspan="3">
				<a href="javascript:FichaEmpresa({/Productos/PRODUCTO/PRODUCTO/IDPROVEEDOR})"><xsl:value-of select="/Productos/PRODUCTO/PRODUCTO/PROVEEDOR"/></a>
			</td>
		</tr>
        <tr>
			<xsl:choose>
			<xsl:when test="NOMBRE_PRIVADO">
				<td class="labelRight veinte"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_privado']/node()"/>:&nbsp;</td>
				<td class="datosLeft">
					<xsl:choose>
					<xsl:when test="CDC">
						<a href="javascript:FichaAdjudicacion('{PRO_ID}&amp;EMP_ID={IDEMPRESADELUSUARIO}');">
							<xsl:value-of select="NOMBRE_PRIVADO"/>
						</a>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="NOMBRE_PRIVADO"/>
					</xsl:otherwise>
					</xsl:choose>

					<xsl:if test="REGULADO='S'">
						&nbsp;&nbsp;<span class="amarillo"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='Regulado']/node()"/></strong></span>&nbsp;&nbsp;
					</xsl:if>

					<xsl:if test="PRO_ENLACEFICHA!=''">
						<xsl:text>&nbsp;&nbsp;[&nbsp;</xsl:text>
						<a href="javascript:MostrarPag('FichaTecnica.xsql?FICHA_IMG={PRO_ENLACEFICHA}','ficha');"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_ficha_tecnica']/node()"/></a>
						<xsl:text>&nbsp;]</xsl:text>
					</xsl:if>
					<!--
        			&nbsp;<a class="btnDiscreto" href="javascript:AnalisisPedidos('{PRO_ID}');">
            			<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>
        			</a>
        			&nbsp;<a class="btnDiscreto" href="javascript:AnalisisTarifas('{PRO_ID}','{IDEMPRESADELUSUARIO}');">
            			<xsl:value-of select="document($doc)/translation/texts/item[@name='Analisis_tarifas']/node()"/>
        			</a>
					-->
					<!--enseño en un alert la cadena de busqueda para este prod solo si mvm-->
					<xsl:if test="MVM">
						&nbsp;<a class="btnDiscreto" href="javascript:verCadenaBusqueda('{CADENABUSQUEDA}')">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='busquedas']/node()"/>
						</a>
					</xsl:if>
				</td>
			</xsl:when>
			<xsl:when test="PRO_ID">
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_privado']/node()"/>:&nbsp;</td>
				<td class="datosLeft"><strong><xsl:value-of select="PRO_NOMBRE" disable-output-escaping="yes"/></strong>
					<xsl:if test="PRO_ENLACEFICHA!=''">
						<xsl:text>&nbsp;&nbsp;[&nbsp;</xsl:text>
						<a href="javascript:MostrarPag('FichaTecnica.xsql?FICHA_IMG={PRO_ENLACEFICHA}','ficha');"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_ficha_tecnica']/node()"/></a>
						<xsl:text>&nbsp;]</xsl:text>
					</xsl:if>
        			&nbsp;<a class="btnDiscreto" href="javascript:AnalisisPedidos('{PRO_ID}');">
            			<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/><!--<img src="http://www.newco.dev.br/images/tabla.gif" alt="Lineas pedidos"/>-->
            		</a>
					<!--enseño en un alert la cadena de busqueda para este prod solo si mvm-->
					<xsl:if test="MVM">
						&nbsp;<a class="btnDiscreto" href="javascript:verCadenaBusqueda('{CADENABUSQUEDA}')">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='busquedas']/node()"/>
						</a>
					</xsl:if>
				</td>
			</xsl:when>
			</xsl:choose>
 			</tr>

     		<xsl:if test="/Productos/PRODUCTO/PRODUCTO/MVM or /Productos/PRODUCTO/PRODUCTO/CDC">
				<tr>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_proveedor']/node()"/>:&nbsp;</td>
					<td class="datosLeft" colspan="3"><xsl:value-of select="PRO_NOMBRE" disable-output-escaping="yes"/></td>
				</tr>
			</xsl:if>

			<!--19may22 Incluimos los documentos-->
     		<xsl:if test="/Productos/PRODUCTO/PRODUCTO/DOCUMENTOS_OBLIGATORIOS/DOCUMENTO">
				<tr>
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='documentos']/node()"/>:&nbsp;</td>
					<td class="datosLeft" colspan="3">
						<xsl:for-each select="/Productos/PRODUCTO/PRODUCTO/DOCUMENTOS_OBLIGATORIOS/DOCUMENTO">
							<xsl:if test="URL!=''">
							<a>
								<xsl:choose>
    	  						<xsl:when test="COLOR='VERDE'">
									<xsl:attribute name="style">color:#4E9A06;</xsl:attribute>
								</xsl:when>
    	  						<xsl:when test="COLOR='NARANJA'">
									<xsl:attribute name="style">color:#F57900;</xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="style">color:#CC0000;</xsl:attribute>
								</xsl:otherwise>
    	 						</xsl:choose>
								<xsl:attribute name="href">http://www.newco.dev.br/Documentos/<xsl:value-of select="URL"/></xsl:attribute>
								<xsl:value-of select="FECHA"/>:&nbsp;<xsl:value-of select="NOMBRETIPO"/>
							</a>&nbsp;&nbsp;&nbsp;
							</xsl:if>
						</xsl:for-each>
					</td>
				</tr>
			</xsl:if>
			<tr>
				<!--ref provee-->
				<td class="labelRight w150px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/>:&nbsp;</td>
				<td class="datosLeft w300px"><xsl:apply-templates select="REFERENCIA_PROVEEDOR"/></td>
      			<xsl:if test="PRO_MARCA !=''">
						<!--marca-->
						<td class="labelRight w150px"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>:&nbsp;</td>
						<td class="datosLeft w200px"><xsl:value-of select="PRO_MARCA" disable-output-escaping="yes"/></td>
     			</xsl:if>
			</tr>

			<xsl:if test="USUARIO/NOMBRE != ''">
			<tr>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='responsable']/node()"/>:&nbsp;</td>
				<td class="datosLeft" colspan="3"><xsl:value-of select="USUARIO/NOMBRE"/></td>
			</tr>
			</xsl:if>
			<xsl:if test="ALTA != ''">
			<tr>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;</td>
				<td class="datosLeft" colspan="3"><xsl:value-of select="ALTA" /></td>
			</tr>
			</xsl:if>

			<xsl:if test="REFERENCIA_CLIENTE !=''">
				<tr>
					<!--referencia cliente-->
					<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:&nbsp;</td>
					<td class="datosLeft"><xsl:value-of select="REFERENCIA_CLIENTE"/></td>
      				<xsl:if test="REFERENCIA_PRIVADA !=''">
						<!--ref estandar propuesta-->
						<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_estandar']/node()"/>:&nbsp;</td>
						<td class="datosLeft">
		        			<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducido2022.xsql?PRO_ID={PRO_ID}','Ficha Catalogación',100,80,0,-20);">
		        				<xsl:apply-templates select="REFERENCIA_PRIVADA"/>
		        			</a>
		    		  	</td>
					</xsl:if>
				</tr>
			</xsl:if>


    	  <xsl:if test="/Productos/PRODUCTO/PRODUCTO/IDPAIS !='55'">
        	<tr>
        	  <!--iva-->
        	  <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/>:&nbsp;</td>
        	  <td class="datosLeft"><xsl:value-of select="PRO_TIPOIVA" disable-output-escaping="yes"/></td>
        	</tr>
    	  </xsl:if>

		<xsl:if test="PRO_DESCRIPCION != ''">
			<tr>
				<td class="labelRight" valign="top"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:&nbsp;</td>
				<td class="datosLeft"><xsl:value-of select="PRO_DESCRIPCION"  disable-output-escaping="yes"/>&nbsp;</td>
			</tr>
		</xsl:if>

    	<tr>
			<!--unidad basica-->
			<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/>:&nbsp;</td>
			<td class="datosLeft"><xsl:apply-templates select="PRO_UNIDADBASICA"/>&nbsp;</td>
			<!--unidad lote-->
			<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_lote']/node()"/>:&nbsp;</td>
			<td class="datosLeft"><xsl:apply-templates select="PRO_UNIDADESPORLOTE"/>&nbsp;</td>
		</tr>
		<xsl:if test="/Productos/PRODUCTO/PRODUCTO/IDPAIS !='55'">
			<tr>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Cod_Expediente']/node()"/>:&nbsp;</td>
				<td class="datosLeft"><xsl:value-of select="PRO_CODEXPEDIENTE" disable-output-escaping="yes"/></td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Cod_IUM']/node()"/>:&nbsp;</td>
				<td class="datosLeft"><xsl:value-of select="PRO_CODIUM" disable-output-escaping="yes"/></td>
			</tr>
			<tr>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Cod_CUM']/node()"/>:&nbsp;</td>
				<td class="datosLeft"><xsl:value-of select="PRO_CODCUM" disable-output-escaping="yes"/></td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Cod_Invima']/node()"/>:&nbsp;</td>
				<td class="datosLeft"><xsl:value-of select="PRO_CODINVIMA" disable-output-escaping="yes"/> (<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:<xsl:value-of select="PRO_FECHACADINVIMA" disable-output-escaping="yes"/>)</td>
			</tr>
			<tr>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Clas_Riesgo']/node()"/>:&nbsp;</td>
				<td class="datosLeft"><xsl:value-of select="PRO_CLASIFICACIONRIESGO" disable-output-escaping="yes"/></td>
			</tr>
		</xsl:if>

    	<!--19may22 farmacia
    	<tr>
			<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='farmacia']/node()"/>:&nbsp;</td>
			<td class="datosLeft">
				<xsl:choose>
        		<xsl:when test="PRO_CATEGORIA='F'">
            		<input type="checkbox" class="muypeq" name="PRO_CATEGORIA_CHK" checked="checked" disabled="disabled"/>
	        	</xsl:when>
	        	<xsl:otherwise>
	            	<input type="checkbox" class="muypeq" name="PRO_CATEGORIA_CHK" disabled="disabled"/>
	        	</xsl:otherwise>
	        	</xsl:choose>
	        </td>
		</tr>-->

		<tr>
      		<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='homologado']/node()"/>:&nbsp;</td>
        	<td class="datosLeft"><xsl:apply-templates select="PRO_HOMOLOGADO"/></td>
      	</tr>

		<xsl:if test="PRO_CERTIFICADOS != ''">
			<tr>
    			<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='certificacion']/node()"/>:&nbsp;</td>
    			<td class="datosLeft">
					<xsl:apply-templates select="PRO_CERTIFICADOS"/>
        			<xsl:if test="PRO_ENLACECERTIFICADO != ''">
        			&nbsp;<a href="javascript:MostrarPag('Certificado.xsql?CERT_IMG={PRO_ENLACECERTIFICADO}','Certificado');"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_certificado']/node()"/></a>
        			</xsl:if>
				</td>
			</tr>
		</xsl:if>

    	<xsl:choose>
    	<xsl:when test="MOSTRAR_CATEGORIA = 'S'">
        	<tr>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/>:&nbsp;</td>
				<td class="datosLeft"><xsl:value-of select="NOMBRECATEGORIA"/></td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='grupo']/node()"/>:&nbsp;</td>
				<td class="datosLeft"><xsl:value-of select="NOMBREFAMILIA"/></td>
        	</tr>
        	<tr>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='subgrupo']/node()"/>:&nbsp;</td>
				<td class="datosLeft"><xsl:value-of select="NOMBRESUBFAMILIA"/></td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='familia']/node()"/>:&nbsp;</td>
				<td class="datosLeft"><xsl:value-of select="NOMBREGRUPO"/></td>
        	</tr>
    	</xsl:when>
    	<xsl:when test="MOSTRAR_CATEGORIA = 'N'">
        	<tr>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='familia']/node()"/>:&nbsp;</td>
				<td class="datosLeft"><xsl:value-of select="NOMBREFAMILIA"/></td>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='subfamilia']/node()"/>:&nbsp;</td>
				<td class="datosLeft"><xsl:value-of select="NOMBRESUBFAMILIA"/></td>
        	</tr>
        	<xsl:if test="MOSTRAR_GRUPO = 'S'">
        	<tr>
				<td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='grupo']/node()"/>:&nbsp;</td>
				<td class="datosLeft"><xsl:value-of select="NOMBREGRUPO"/></td>
        	</tr>
        	</xsl:if>
    	</xsl:when>
    	</xsl:choose>
		<tr><td colspan="4" class="h40px">&nbsp;</td></tr>
	</tbody>
	</table>
	</div><!--fin de divLeft-->
	</div><!--fin de divLeft-->
	<br/>
	<br/>
	<br/>
	<div class="tabela tabela_redonda" >
		<table class="buscador w95 tableCenter" id="tbTarifaCliente" cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
		<tr>
			<th class="w1px"></th>
			<xsl:choose><!--28jun23-->
			<xsl:when test="/Productos/PRODUCTO/PRODUCTO/MOSTRAR_PRECIO_FABRICA">
				<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Precio_fabrica']/node()"/></th>
				<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Descuento']/node()"/></th>
				<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Precio_final']/node()"/></th>
			</xsl:when>
			<xsl:otherwise>
				<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Tarifa']/node()"/></th>
			</xsl:otherwise>
			</xsl:choose>
			<!--28jun23	<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></th>	-->
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Fec_inic_tarifa']/node()"/></th>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Fec_fin_tarifa']/node()"/></th>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Doc_tarifa']/node()"/></th>
			<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='Tipo_negociacion']/node()"/></th>
			<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta']/node()"/></th>
			<th class="w1px">&nbsp;</th>
		</tr>
		</thead>
		<!--	Cuerpo de la tabla	-->
		<tbody class="corpo_tabela">
		<xsl:choose>
        <xsl:when test="/Productos/PRODUCTO/PRODUCTO/MVM and (/Productos/PRODUCTO/PRODUCTO/DATOS_CLIENTE)">
			<xsl:for-each select="/Productos/PRODUCTO/PRODUCTO/DATOS_CLIENTE">
            	<xsl:if test="TARIFA_CONFORMATO != ''">
					<tr class="conhover">
						<td class="color_status">&nbsp;</td>
						<xsl:if test="/Productos/PRODUCTO/PRODUCTO/MOSTRAR_PRECIO_FABRICA">
							<td><xsl:value-of select="DIVISA/PREFIJO"/>&nbsp;<xsl:value-of select="TRF_PRECIOFABRICA"/>&nbsp;<xsl:value-of select="DIVISA/SUFIJO"/></td>
							<td><xsl:value-of select="TRF_DESCUENTO"/>%</td>
						</xsl:if>
						<td><xsl:value-of select="DIVISA/PREFIJO"/>&nbsp;<xsl:value-of select="TARIFA_CONFORMATO"/>&nbsp;<xsl:value-of select="DIVISA/SUFIJO"/></td>
						<td><xsl:value-of select="TRF_FECHAINICIO"/></td>
						<td><xsl:value-of select="TRF_FECHALIMITE"/></td>
						<td><xsl:value-of select="TRF_NOMBREDOCUMENTO"/></td>
						<td><xsl:value-of select="TIPONEGOCIACION"/></td>
						<td>
						<xsl:choose>
						<xsl:when test="OFERTA">
							<xsl:value-of select="NOMBRE_CORTO"/>:&nbsp;
								<xsl:value-of select="OFERTA/NOMBRE"/>&nbsp;&nbsp;
								<a target="_blank" style="text-decoration:none;">
									<xsl:attribute name="href">http://www.newco.dev.br/Documentos/<xsl:value-of select="OFERTA/URL"/></xsl:attribute>
									<img src="http://www.newco.dev.br/images/descarga.gif" alt="Descarga"/>
								</a>&nbsp;
								<!--si tiene documentos anexos-->
								<xsl:if test="OFERTA/DOCUMENTOHIJO">
									<xsl:for-each select="OFERTA/DOCUMENTOHIJO">
										<a target="_blank" style="text-decoration:none;">
    									<xsl:attribute name="href">http://www.newco.dev.br/Documentos/<xsl:value-of select="URL"/></xsl:attribute><img src="http://www.newco.dev.br/images/anexo.gif" alt="Anexo"/></a>&nbsp;
									</xsl:for-each>
								</xsl:if>
						</xsl:when>
						<xsl:otherwise>
						&nbsp;
						</xsl:otherwise>
						</xsl:choose>
						</td>
						<td>&nbsp;</td>
            		</tr>
            	</xsl:if>
			</xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
			<tr>
				<td class="color_status">&nbsp;</td>
				<xsl:if test="/Productos/PRODUCTO/PRODUCTO/MOSTRAR_PRECIO_FABRICA">
					<td><xsl:value-of select="DIVISA/PREFIJO"/>&nbsp;<xsl:value-of select="TARIFA_CLIENTE/TRF_PRECIOFABRICA"/>&nbsp;<xsl:value-of select="DIVISA/SUFIJO"/></td>
					<td><xsl:value-of select="TARIFA_CLIENTE/TRF_DESCUENTO"/>%</td>
				</xsl:if>
				<td><xsl:value-of select="TARIFA_CLIENTE/DIVISA/PREFIJO"/>&nbsp;<xsl:value-of select="TARIFA_CLIENTE/TARIFA_CONFORMATO"/>&nbsp;<xsl:value-of select="TARIFA_CLIENTE/DIVISA/SUFIJO"/></td>
				<td><xsl:value-of select="TARIFA_CLIENTE/TRF_FECHAINICIO"/></td>
				<td><xsl:value-of select="TARIFA_CLIENTE/TRF_FECHALIMITE"/></td>
				<td><xsl:value-of select="TARIFA_CLIENTE/TRF_NOMBREDOCUMENTO"/></td>
				<td><xsl:value-of select="TARIFA_CLIENTE/TIPONEGOCIACION"/></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
        </xsl:otherwise>
        </xsl:choose>
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="12">&nbsp;</td></tr>
		</tfoot>
		</table><!--fin de infoTableAma-->
 	</div>
 	<br/>  
	
	<!--solo mvm o cdc ven la tabla-->
	<xsl:if test="/Productos/PRODUCTO/PRODUCTO/CDC or /Productos/PRODUCTO/PRODUCTO/MVM or /Productos/PRODUCTO/PRODUCTO/MVMB">
		<div class="divLeft">
		<br/>
		<br/>
		<ul class="pestannas">
			<!--28jun23 Ya se muestran las tarifas en la tabla anterior
			<li>
				<a id="Tarifas" class="menuProd"><xsl:value-of select="document($doc)/translation/texts/item[@name='tarifas']/node()"/></a>
			</li>-->
			<li>
				<a id="Catalogos" class="menuProd"><xsl:value-of select="document($doc)/translation/texts/item[@name='catalogos']/node()"/></a>
			</li>
			<li>
				<!--28jun23	<xsl:if test="not(/Productos/PRODUCTO/PRODUCTO/ADMIN)">
					<xsl:attribute name="style">background:#C3D2E9;</xsl:attribute>
				</xsl:if>-->
				<a id="Incidencias" class="menuProd"><xsl:value-of select="document($doc)/translation/texts/item[@name='incidencias']/node()"/>(<xsl:value-of select="/Productos/PRODUCTO/PRODUCTO/INCIDENCIASPRODUCTOS/TOTAL" />)</a>
			</li>
			<li>
				<a id="Evaluaciones" class="menuProd"><xsl:value-of select="document($doc)/translation/texts/item[@name='evaluaciones']/node()"/>(<xsl:value-of select="/Productos/PRODUCTO/PRODUCTO/EVALUACIONESPRODUCTOS/TOTAL" />)</a>
			</li>
			<li>
				<a id="Licitaciones" class="menuProd"><xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones']/node()"/>(<xsl:value-of select="/Productos/PRODUCTO/PRODUCTO/LICITACIONESPRODUCTO/TOTAL" />)</a>
			</li>
			<li>
				<a id="Roturas" class="menuProd"><xsl:value-of select="document($doc)/translation/texts/item[@name='roturas_stock']/node()"/>(<xsl:value-of select="/Productos/PRODUCTO/PRODUCTO/ROTURAS_STOCKS/TOTAL" />)</a>
			</li>
			<li>
				<a id="Consumos" class="menuProd"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumos']/node()"/></a>
			</li>
			<xsl:if test="/Productos/PRODUCTO/PRODUCTO/LOGS">
			<li>
				<a id="Logs" class="menuProd"><!--<xsl:value-of select="document($doc)/translation/texts/item[@name='consumos']/node()"/>-->Logs</a>
			</li>
			</xsl:if>
		</ul>
		</div><!--fin de divleft pestañas-->

	<div class="divLeft" style="margin-top:28px;"><!--	Contenedor de todas las tablas inferiores	-->
   
		<!--28jun23
		<div class="divLeft tbDetalle" id="TarifasBox"><!- -pestanaTarifasDiv- ->
			<xsl:if test="not(/Productos/PRODUCTO/PRODUCTO/ADMIN)">
				<xsl:attribute name="style">display:none;</xsl:attribute>
			</xsl:if>
			<!- -	Tarifas tabla si precio mvm esta informado, si no no- ->
			<xsl:apply-templates select="../LasTarifas/TARIFAS"/>
		</div>
		-->

		<div class="divLeft tbDetalle" id="IncidenciasBox">
			<xsl:if test="/Productos/PRODUCTO/PRODUCTO/ADMIN">
				<xsl:attribute name="style">display:none;</xsl:attribute>
			</xsl:if>
			<xsl:call-template name="INCIDENCIAS"/>
		</div>

		<div class="divLeft tbDetalle" id="LicitacionesBox" style="display:none;">
			<xsl:apply-templates select="/Productos/PRODUCTO/PRODUCTO/LICITACIONESPRODUCTO"/>
		</div>

		<div class="divLeft tbDetalle" id="CatalogosBox" style="display:none;">
			<xsl:call-template name="CATALOGOS"/>
		</div>

		<div class="divLeft tbDetalle" id="RoturasBox" style="display:none;">
			<xsl:call-template name="ROTURAS"/>
		</div>

		<div class="divLeft tbDetalle" id="EvaluacionesBox" style="display:none;">
			<xsl:call-template name="EVALUACIONES"/>
		</div>

		<div class="divLeft tbDetalle" id="ConsumosBox" style="display:none;">
			<xsl:apply-templates select="CONSUMOPORCENTRO"/>
		</div>

		<div class="divLeft tbDetalle" id="LogsBox" style="display:none;">
			<xsl:apply-templates select="LOGS"/>
		</div>
     </div><!--fin de buttons-->
	</xsl:if>
</xsl:if><!--fin de if si prod no es borrado-->
<br/><br/><br/><br/><br/><br/>
</div><!--fin div fichaproducto-->

</xsl:template>
<!--fin de producto normal-->


<!--producto licitacion-->
<xsl:template match="PRODUCTOLICITACION">
	<form action="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROBorrarSave.xsql" name="Busqueda" method="POST">
		<input type="hidden" name="PRO_ID" value="{PRO_ID}"/>
	</form>

	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Productos/LANG"><xsl:value-of select="/Productos/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:variable name="usuario">
		<xsl:choose>
		<xsl:when test="/Productos/PRODUCTO/PRODUCTO/OBSERVADOR">OBSERVADOR</xsl:when>
		<xsl:when test="/Productos/PRODUCTO/PRODUCTOLICITACION/MVM or /Productos/PRODUCTO/PRODUCTOLICITACION/MVMB or /Productos/PRODUCTO/PRODUCTOLICITACION/CDC">CDC</xsl:when>
		<xsl:otherwise>NORMAL</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<div class="divLeft" style="background:#fff;">
		<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle2022.xsql?LIC_PROD_ID={/Productos/LIC_PROD_ID}&amp;LIC_OFE_ID={/Productos/LIC_OFE_ID}"  style="text-decoration:none;">
		<xsl:choose>
		<xsl:when test="/Productos/LANG = 'spanish'">
			<img src="http://www.newco.dev.br/images/botonFicha1.gif" alt="FICHA" id="pesFicha"/>
		</xsl:when>
		<xsl:otherwise>
			<img src="http://www.newco.dev.br/images/botonFicha1.gif" alt="FICHA" id="pesFicha"/>
		</xsl:otherwise>
		</xsl:choose>
		</a>

	<xsl:if test="/Productos/PRODUCTO/PRODUCTO/MVM or /Productos/PRODUCTO/PRODUCTOLICITACION/MVMB or /Productos/PRODUCTO/PRODUCTOLICITACION/CDC or /Productos/PRODUCTO/PRODUCTOLICITACION/INCIDENCIAS/INCIDENCIA">
		&nbsp;
		<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencias.xsql?PRO_ID={/Productos/PRODUCTO/PRODUCTOLICITACION/OFERTAS/OFERTA/LIC_OFE_IDPRODUCTO}&amp;LIC_PROD_ID={/Productos/LIC_PROD_ID}&amp;LIC_OFE_ID={/Productos/LIC_OFE_ID}&amp;PRO_NOMBRE={/Productos/PRODUCTO/PRODUCTOLICITACION/LIC_PROD_NOMBRE}" style="text-decoration:none;">
		<xsl:choose>
		<xsl:when test="/Productos/LANG = 'spanish'">
			<img src="http://www.newco.dev.br/images/botonIncidencias.gif" alt="INCIDENCIAS"/>
		</xsl:when>
		<xsl:otherwise>
			<img src="http://www.newco.dev.br/images/botonIncidencias-Br.gif" alt="INCIDENCIAS"/>
		</xsl:otherwise>
		</xsl:choose>
		</a>
	</xsl:if>
	<xsl:if test="$usuario != 'OBSERVADOR'">
		&nbsp;
		<a href="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/NuevaIncidencia.xsql?PRO_ID={/Productos/PRODUCTO/PRODUCTOLICITACION/OFERTAS/OFERTA/LIC_OFE_IDPRODUCTO}&amp;USER={$usuario}&amp;LIC_PROD_ID={/Productos/LIC_PROD_ID}&amp;LIC_OFE_ID={/Productos/LIC_OFE_ID}&amp;PRO_NOMBRE={/Productos/PRODUCTO/PRODUCTOLICITACION/LIC_PROD_NOMBRE}" style="text-decoration:none;">
		<xsl:choose>
		<xsl:when test="/Productos/LANG = 'spanish'">
			<img src="http://www.newco.dev.br/images/botonNuevaIncidencia.gif" alt="NUEVAINCIDENCIA"/>
		</xsl:when>
		<xsl:otherwise>
			<img src="http://www.newco.dev.br/images/botonNuevaIncidencia-Br.gif" alt="NUEVAINCIDENCIA"/>
		</xsl:otherwise>
		</xsl:choose>
		</a>
	</xsl:if>
	</div><!--fin de bloque de pestañas-->

	<!--nombre producto-->
	<div class="divLeft">
		<h1 class="titlePage">
		<xsl:choose>
		<xsl:when test="LIC_PROD_NOMBRE">
			<xsl:value-of select="LIC_PROD_NOMBRE"/><br />
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="document($doc)/translation/texts/item[@name='producto_borrado_maiu']/node()"/>
		</xsl:otherwise>
		</xsl:choose>
		</h1>
	</div>

<!--si prod no esta borrado enseño tabla-->
<xsl:if test="LIC_PROD_NOMBRE">
	<div class="divLeft" id="fichaProducto">
		<div class="divLeft50nopa">

<!--tabla izquierda especificas producto-->
<table class="prodTabla" cellspacing="6px" cellpadding="6px">
	<tr height="5px;">
		<td class="cuarenta" height="5px;">&nbsp;</td>
		<td height="5px;">&nbsp;</td>
	</tr>

<tbody>
	<tr>
	<xsl:if test="LIC_PROD_NOMBRE">
		<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_privado']/node()"/>:</td>
		<td><strong><xsl:value-of select="LIC_PROD_NOMBRE" disable-output-escaping="yes"/></strong></td>
	</xsl:if>
	</tr>
	<tr>
		<!--ref provee-->
		<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/>:</td>
		<td><xsl:apply-templates select="OFERTAS/OFERTA/LIC_OFE_REFERENCIA"/></td>
	</tr>
	<tr>
		<!--proveedor-->
		<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:</td>
		<td><xsl:apply-templates select="//PROVEEDOR"/></td>
	</tr>
	<tr>
		<!--referencia cliente-->
		<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>:</td>
		<td><xsl:value-of select="REFERENCIA_CLIENTE"/></td>
	</tr>
	<tr>
		<!--ref estandar propuesta-->
		<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_estandar']/node()"/>:</td>
		<td><xsl:apply-templates select="LIC_PROD_REFESTANDAR"/></td>
	</tr>
</tbody>
</table>

		</div><!--fin de divleft50nopa-->

		<div class="divLeft50nopa">

<!--tabla izquierda especificas producto-->
<table class="prodTabla" cellspacing="6px" cellpadding="6px">
	<tr height="5px;">
		<td class="cuarenta" height="5px;">&nbsp;</td>
		<td height="5px;">&nbsp;</td>
		<td>&nbsp;</td>
	</tr>

<tbody>
	<tr>
	<!--precio unidad basica-->
	<xsl:choose>
	<xsl:when test="/Productos/PRODUCTO/PRODUCTOLICITACION/MOSTRAR_PRECIO_IVA and /Productos/PRODUCTO/PRODUCTOLICITACION/OFERTAS/OFERTA/LIC_OFE_PRECIOIVA != ''">
		<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_c_iva_line']/node()"/>:</td>
		<td><strong><xsl:value-of select="/Productos/PRODUCTO/PRODUCTOLICITACION/OFERTAS/OFERTA/LIC_OFE_PRECIOIVA"/></strong>
		<xsl:if test="/Productos/LANG = 'spanish'">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<span class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/>:</span>
			&nbsp;<xsl:apply-templates select="LIC_PROD_TIPOIVA"/>%
		</xsl:if>
		</td>
		<td>&nbsp;</td>
	</xsl:when>
	<xsl:when test="/Productos/PRODUCTO/PRODUCTOLICITACION/OFERTAS/OFERTA/LIC_OFE_PRECIO != ''">
		<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_s_iva_line']/node()"/>:</td>
		<td><strong><xsl:value-of select="/Productos/PRODUCTO/PRODUCTOLICITACION/OFERTAS/OFERTA/LIC_OFE_PRECIO"/></strong>
		<xsl:if test="/Productos/LANG = 'spanish'">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<span class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/>:</span>
			&nbsp;<xsl:apply-templates select="LIC_PROD_TIPOIVA"/>%
		</xsl:if>
		</td>
		<td>&nbsp;</td>
	</xsl:when>
	<xsl:otherwise>
		<td colspan="2" align="center"><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_precio']/node()"/></strong></td>
		<td>&nbsp;</td>
	</xsl:otherwise>
	</xsl:choose>
	</tr>

	<tr>
		<!--unidad basica-->
		<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/>:</td>
		<td><xsl:value-of select="LIC_PROD_UNIDADBASICA"/>&nbsp;</td>
	</tr>

	<tr>
		<!--unidad lote-->
		<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_por_lote']/node()"/>:</td>
		<td><xsl:value-of select="substring-before(OFERTAS/OFERTA/LIC_OFE_UNIDADESPORLOTE,',')"/>&nbsp;</td>
	</tr>

	<!--marca-->
	<tr>
		<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='lic_marca']/node()"/>:</td>
		<td><xsl:value-of select="OFERTAS/OFERTA/LIC_OFE_MARCA" disable-output-escaping="yes"/></td>
	</tr>

	<tr>
		<td class="label">&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</tbody>
</table>

		</div><!--fin divLeft50nopa-->
	</div><!--fin de divLeft-->

	<!--buttons-->
	<div class="divLeft">
		<br /><br  />
	<xsl:if test="MVM and PRO_ID">
		<div class="divLeft30">&nbsp;</div>
		<div class="divleft20">
			<img src="http://www.newco.dev.br/images/2017/trash.png"/>&nbsp;
			<a href="javascript:Borrar();" title="borrar"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_producto']/node()"/></a>
		</div>
	</xsl:if>

	</div><!--fin de buttons-->
</xsl:if><!--fin de if si prod no es borrado-->
</xsl:template><!--fin de producto licitacion-->

 <!--evaluaciones -->
<xsl:template name="EVALUACIONES">
    <!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Productos/LANG"><xsl:value-of select="/Productos/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

		<table class="buscador" cellspacing="6px" cellpadding="6px">
		<thead>
			<tr class="subTituloTabla">
				<th class="cinco">&nbsp;</th>
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
                <xsl:choose>
                <xsl:when test="/Productos/PRODUCTO/PRODUCTO/EVALUACIONESPRODUCTOS/EVALUACION">
		<tbody>
		<xsl:for-each select="/Productos/PRODUCTO/PRODUCTO/EVALUACIONESPRODUCTOS/EVALUACION">
			<tr>
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
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle2022.xsql?ID={IDCENTROEVALUACION}','DetalleCentro',100,80,0,0)">
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
                </xsl:when>
                <xsl:otherwise>
                            <tr>
                                <td colspan="12"><xsl:value-of select="document($doc)/translation/texts/item[@name='evaluaciones_sin_resultados']/node()"/></td>
                            </tr>
                </xsl:otherwise>
                </xsl:choose>
		</table>

</xsl:template>

<!--incidencias -->
<xsl:template name="INCIDENCIAS">
    <!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/Productos/LANG"><xsl:value-of select="/Productos/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
        <!--idioma fin-->

		<table class="buscador" cellspacing="6px" cellpadding="6px">
		<thead>
			<tr class="subTituloTabla">
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
                <xsl:choose>
                <xsl:when test="/Productos/PRODUCTO/PRODUCTO/INCIDENCIASPRODUCTOS/INCIDENCIA">
		<tbody>
		<xsl:for-each select="/Productos/PRODUCTO/PRODUCTO/INCIDENCIASPRODUCTOS/INCIDENCIA">
			<tr>
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
						<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle2022.xsql?ID={IDCENTROCLIENTE}','DetalleCentro',100,80,0,0)">
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
                </xsl:when>
                <xsl:otherwise>
                            <tr>
                                <td colspan="9"><xsl:value-of select="document($doc)/translation/texts/item[@name='incidecias_sin_resultados']/node()"/></td>
                            </tr>
                </xsl:otherwise>
                </xsl:choose>
		</table>

</xsl:template><!--fin de incidencias-->
<!--
<xsl:template match="TARIFAS">
	<!- -idioma- ->
	<xsl:variable name="lang">
		<xsl:value-of select="../../../LANG" />
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!- -idioma fin- ->

		<table class="buscador" cellspacing="6px" cellpadding="6px">
		<thead>
			<tr class="subTituloTabla">
			<th class="diecisiete">&nbsp;</th>
			<th class="veinte"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_proveedor_c_iva_2line']/node()"/>
        <xsl:if test="../../PRODUCTO/PRO_TIPOIVA != '0' and /Productos/PRODUCTO/PRODUCTO/IDPAIS ='34'">
          <xsl:value-of select="../../PRODUCTO/PRO_TIPOIVA"/>)
        </xsl:if>
      </th>
      <th class="veinte">
        <xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_final_comision_mvm_c_iva_2line']/node()"/>
        <xsl:if test="/Productos/PRODUCTO/PRODUCTO/IDPAIS ='34'">&nbsp;
          <xsl:value-of select="../../PRODUCTO/TIPOIVA_MVM" />%)
        </xsl:if>
      </th>
			<th class="veinte"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_final_s_iva_2line']/node()"/></th>
			<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='divisa']/node()"/></th>
            <th>&nbsp;</th>
		</tr>
	</thead>

	<tbody align="center">

  <xsl:choose>
  <xsl:when test="TARIFAS_ROW[last()]/TRF_IMPORTE != ''">
    <xsl:for-each select="TARIFAS_ROW">
		<tr>
			<td>&nbsp;</td>
			<td><xsl:value-of select="PRECIOPROVEEDOR_CONIVA"/></td>
			<td><xsl:value-of select="COMISION_CONIVA"/></td>
			<td><strong><xsl:value-of select="TRF_IMPORTE"/></strong></td>
			<td>
				<xsl:value-of select="/Productos/PRODUCTO/PRODUCTO/DIVISA/SUFIJO"/>
			</td>
      <td>&nbsp;</td>
		</tr>
    </xsl:for-each>
  </xsl:when>
  <xsl:otherwise>
    <tr>
			<td colspan="6"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_datos']/node()"/></td>
    </tr>
  </xsl:otherwise>
  </xsl:choose>
	</tbody>
	</table>
</xsl:template>-->
<!--fin tarifas-->

<!--licitaciones del producto-->
<xsl:template match="LICITACIONESPRODUCTO">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="../../../LANG" />
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<table class="buscador" cellspacing="6px" cellpadding="6px">
	<thead>
		<tr class="subTituloTabla">
           	<th class="diecisiete">&nbsp;</th>
			<th class="veinte" style="text-align:left;">&nbsp;<xsl:copy-of select="document($doc)/translation/texts/item[@name='licitaciones']/node()"/></th>
			<th class="veinte"><xsl:copy-of select="document($doc)/translation/texts/item[@name='fecha_alta']/node()"/></th>
			<th class="veinte"><xsl:copy-of select="document($doc)/translation/texts/item[@name='estado']/node()"/></th>
			<th class="quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_decision']/node()"/></th>
            <th>&nbsp;</th>
		</tr>
	</thead>
	<tbody align="center">
        <xsl:choose>
        <xsl:when test="LICITACION">
	<xsl:for-each select="LICITACION">
		<tr>
                        <td>&nbsp;</td>
			<td style="text-align:left;">
                <p>&nbsp;<xsl:value-of select="LIC_TITULO"/>&nbsp;
                 <xsl:if test="LIC_ID and LIC_PROV_ID">
                    <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/ImprimirOferta.xsql?LIC_ID={LIC_ID}&amp;LIC_PROV_ID={LIC_PROV_ID}',100,100,0,0);" style="text-decoration:none;">
                        <xsl:choose>
                        <xsl:when test="../IDPAIS = '34'">
                            <img src="http://www.newco.dev.br/images/verLicitacion.gif" alt="Ver licitación" style="text-decoration:none;vertical-align:middle;"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <img src="http://www.newco.dev.br/images/verLicitacion-BR.gif" alt="Ver cotação" style="text-decoration:none;vertical-align:middle;"/>
                        </xsl:otherwise>
                        </xsl:choose>
                    </a>
                 </xsl:if>
                </p>
            </td>
			<td><xsl:value-of select="LIC_FECHAALTA"/></td>
			<td><xsl:value-of select="ESTADO"/></td>
			<td><xsl:value-of select="LIC_FECHADECISIONPREVISTA"/></td>
                        <td>&nbsp;</td>
		</tr>
	</xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
            <tr>
                <td colspan="6"><xsl:value-of select="document($doc)/translation/texts/item[@name='licitaciones_sin_resultados']/node()"/></td>
            </tr>
        </xsl:otherwise>
        </xsl:choose>
	</tbody>
	</table>
</xsl:template>
<!--fin de licitaciones del producto-->

<xsl:template match="PRO_ENLACE">
	<a class="valor">
		<xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute>
		<img>
			<xsl:attribute name="src">http://www.newco.dev.br/images/anexo.gif</xsl:attribute>
		</img>
	</a>
</xsl:template>

<xsl:template match="PRO_HOMOLOGADO">
	<input type="checkbox" class="muypeq" name="HOMOLOGADO" disabled="disabled">
	<xsl:choose>
	<xsl:when test=".=1">
		<xsl:attribute name="checked">checked</xsl:attribute>
	</xsl:when>
	</xsl:choose>
	</input>
</xsl:template>

<xsl:template name="ROTURAS">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/Productos/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
	<table class="buscador" cellspacing="6px" cellpadding="6px">
	<thead>
		<tr class="subTituloTabla">
			<th class="dies">&nbsp;</th>
            <th class="cinco" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='pos']/node()"/>.</th>
			<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>&nbsp;&nbsp;</th>
			<th class="veinte" align="left"><xsl:copy-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></th>
            <th class="veinte" align="left"><xsl:copy-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/></th>
			<th class="veinte" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='alternativa']/node()"/></th>
			<th class="ocho" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='final']/node()"/></th>
			<th class="cinco" align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='duracion']/node()"/></th>
            <th>&nbsp;</th>
		</tr>
	</thead>

        <xsl:choose>
        <xsl:when test="/Productos/PRODUCTO/PRODUCTO/ROTURAS_STOCKS/ROTURAS_STOCKS_HISTORICAS/ROTURA_STOCKS or /Productos/PRODUCTO/PRODUCTO/ROTURAS_STOCKS/ROTURAS_STOCKS_ACTIVAS/ROTURA_STOCKS">

            <xsl:for-each select="/Productos/PRODUCTO/PRODUCTO/ROTURAS_STOCKS/ROTURAS_STOCKS_ACTIVAS/ROTURA_STOCKS">
			<tr class="amarillo">
				<td>&nbsp;</td>
				<td style="text-align:left;"><xsl:value-of select="POS"/></td>
                                <td style="text-align:left;"><xsl:value-of select="FECHA" />&nbsp;&nbsp;</td>
                                <td style="text-align:left;"><xsl:value-of select="PRODUCTO" /></td>
                                <td style="text-align:left;"><xsl:value-of select="COMENTARIOS" /></td>
                                <td style="text-align:left;"><xsl:value-of select="ALTERNATIVA" /></td>
                                <td style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/></td>
                                <td style="text-align:left;">&nbsp;</td>
                                <td>&nbsp;</td>
			</tr>
            </xsl:for-each>
            <xsl:for-each select="/Productos/PRODUCTO/PRODUCTO/ROTURAS_STOCKS/ROTURAS_STOCKS_HISTORICAS/ROTURA_STOCKS">
			<tr>
				<td>&nbsp;</td>
				<td style="text-align:left;"><xsl:value-of select="POS"/></td>
                                <td style="text-align:left;"><xsl:value-of select="FECHA" />&nbsp;&nbsp;</td>
                                <td style="text-align:left;"><xsl:value-of select="PRODUCTO" /></td>
                                <td style="text-align:left;"><xsl:value-of select="COMENTARIOS" /></td>
                                <td style="text-align:left;"><xsl:value-of select="ALTERNATIVA" /></td>
                                <td style="text-align:left;"><xsl:value-of select="FECHAFINAL" /></td>
                                <td style="text-align:left;"><xsl:value-of select="DURACION" /></td>
                                <td>&nbsp;</td>
			</tr>
            </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
            <tr>
                <td colspan="10" align="left">
                  <xsl:value-of select="document($doc)/translation/texts/item[@name='roturas_sin_resultados']/node()"/>
                </td>
            </tr>
        </xsl:otherwise>
        </xsl:choose>
	</table>
</xsl:template>

<xsl:template name="CATALOGOS">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/Productos/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
	<table class="buscador" cellspacing="6px" cellpadding="6px">
	<thead>
		<tr class="subTituloTabla">
			<th class="uno">&nbsp;</th>
			<th class="veinte datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>
			<th class="dies"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_estandar']/node()"/>&nbsp;</th>
			<th class="trenta textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_estandar']/node()"/></th>
			<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='adjudicado']/node()"/></th>
			<th class="dies"><xsl:copy-of select="document($doc)/translation/texts/item[@name='tarifa_euros_2line']/node()"/></th>
			<th class="dies"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_referencia_euros_2line']/node()"/> </th>
			<th class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='teorico']/node()"/></th>
			<th class="dies">*<xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_ultimo_ano_ud_2line']/node()"/></th>
			<th>&nbsp;</th>
		</tr>
	</thead>

        <xsl:choose>
        <xsl:when test="CATALOGOS/CATALOGO">
	<xsl:for-each select="CATALOGOS/CATALOGO">
		<tr>
			<td>&nbsp;</td>
			<td class="datosLeft"><xsl:value-of select="EMPRESA_CORTO"/></td>
			<td><xsl:value-of select="REFESTANDAR"/></td>
			<td class="datosLeft"><xsl:value-of select="DESCRIPCION"/></td>
			<td><xsl:value-of select="ADJUDICADO"/></td>
			<td><xsl:value-of select="TARIFA"/></td>
			<td><xsl:value-of select="PRECIOREFERENCIA"/></td>
			<td><xsl:value-of select="PRECIOREFERENCIATEORICO"/></td>
			<td>
				<xsl:variable name="refProd">
					<xsl:choose>
					<xsl:when test="REFCLIENTE != ''"><xsl:value-of select="REFCLIENTE"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="REFESTANDAR"/></xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

			<xsl:choose>
			<xsl:when test="CANTIDADCOMPRADA > 0">
				<a href="javascript:MostrarEIS('CO_Pedidos_Eur','{IDEMPRESA}','','{$refProd}','9999');" style="text-decoration:none;">
					<xsl:value-of select="CANTIDADCOMPRADA"/>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="CANTIDADCOMPRADA"/>
			</xsl:otherwise>
			</xsl:choose>
                        </td>
			<td>&nbsp;</td>
		</tr>
	</xsl:for-each>
            <tr>
                <td colspan="10" align="left">
                    <xsl:choose>
                    <xsl:when test="IDPAIS = '34'">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_ultimos_12_meses']/node()"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_ultimos_12_meses']/node()"/>
                    </xsl:otherwise>
                    </xsl:choose>

                </td>
            </tr>
        </xsl:when>
        <xsl:otherwise>
            <tr>
                <td colspan="10" align="left">
                  <xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_datos']/node()"/>
                </td>
            </tr>
        </xsl:otherwise>
        </xsl:choose>
	</table>
</xsl:template>

<xsl:template match="CONSUMOPORCENTRO">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/Productos/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
	<table class="buscador" cellspacing="6px" cellpadding="6px">
	<thead>
		<tr class="subTituloTabla">
			<th class="uno">&nbsp;</th>
			<th class="veinte datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
			<th class="veinte datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='poblacion']/node()"/>&nbsp;</th>
			<th class="dies"><xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_ultimo_ano_ud_2line']/node()"/></th>
			<th class="dies"><xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_reciente_ud_2line']/node()"/></th>
			<th class="uno">&nbsp;</th>
		</tr>
	</thead>
        <xsl:choose>
        <xsl:when test="CENTRO">
	<xsl:for-each select="CENTRO">
		<tr>
		<xsl:variable name="refProd">
			<xsl:choose>
			<xsl:when test="/Productos/PRODUCTO/PRODUCTO/REFERENCIA_CLIENTE != ''"><xsl:value-of select="/Productos/PRODUCTO/PRODUCTO/REFERENCIA_CLIENTE"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="/Productos/PRODUCTO/PRODUCTO/REFERENCIA_PRIVADA"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
			<td>&nbsp;</td>
			<td class="datosLeft"><xsl:value-of select="NOMBRE"/></td>
			<td class="datosLeft"><xsl:value-of select="POBLACION"/></td>
			<td>
			<xsl:choose>
			<xsl:when test="CONSUMO > 0">
				<a href="javascript:MostrarEIS('CO_Pedidos_Eur','{/Productos/PRODUCTO/PRODUCTO/IDEMPRESA}','{ID}','{$refProd}','9999');" style="text-decoration:none;">
					<xsl:value-of select="CONSUMO"/>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="CONSUMO"/>
			</xsl:otherwise>
			</xsl:choose>
                        </td>
			<td>
			<xsl:choose>
			<xsl:when test="CONSUMORECIENTE > 0">
				<a href="javascript:MostrarEIS('CO_Pedidos_Eur','{/Productos/PRODUCTO/PRODUCTO/IDEMPRESA}','{ID}','{$refProd}','9999');" style="text-decoration:none;">
					<xsl:value-of select="CONSUMORECIENTE"/>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="CONSUMORECIENTE"/>
			</xsl:otherwise>#
			</xsl:choose>
                        </td>
			<td>&nbsp;</td>
		</tr>
	</xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
            <tr>
                <td colspan="6"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_datos']/node()"/></td>
            </tr>
        </xsl:otherwise>
        </xsl:choose>
	</table>
</xsl:template>

<xsl:template match="LOGS">
	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:value-of select="/Productos/LANG"/>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
	<table class="buscador" cellspacing="6px" cellpadding="6px">
	<thead>
		<tr class="subTituloTabla">
			<th class="w50px">&nbsp;</th>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/></th>
			<th class="w100px"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></th>
			<th class="datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/>&nbsp;</th>
			<th>&nbsp;</th>
		</tr>
	</thead>
        <xsl:choose>
        <xsl:when test="LOG">
		<xsl:for-each select="LOG">
		<tr>
			<td>&nbsp;</td>
			<td><xsl:value-of select="FECHA"/></td>
			<td><xsl:value-of select="USUARIO"/></td>
			<td class="datosLeft"><xsl:value-of select="TEXTO"/></td>
			<td>&nbsp;</td>
		</tr>
	</xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
            <tr>
                <td class="textCenter" colspan="5"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_datos']/node()"/></td>
            </tr>
        </xsl:otherwise>
        </xsl:choose>
	</table>
</xsl:template>
</xsl:stylesheet>
