<?xml version="1.0" encoding="iso-8859-1"?>
<!-- 
	Buscador para preparar pedidos desde catalogo privado
	Ultima revision. ET 11may21 09:00 PedidoDesdeCatalogo_120321.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/">

<html>
<head>
  <meta http-equiv="Cache-Control" Content="no-cache"/>

  <title><xsl:value-of select="TITULO" disable-output-escaping="yes"/></title>

  <!--style-->
  <xsl:call-template name="estiloIndip"/>
  <link href="http://www.newco.dev.br/General/Tabla-popup.css" rel="stylesheet" type="text/css"/>
  <!--fin de style-->

  <script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
  <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
  <script type="text/javascript" src="http://www.newco.dev.br/General/Tabla-popup.js"></script>
  <script type="text/javascript" src="http://www.newco.dev.br/Compras/NuevaMultioferta/PedidoDesdeCatalogo_120321.js"></script>

  <!--idioma-->
  <xsl:variable name="lang">
	  <xsl:choose>
	  <xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG"/></xsl:when>
	  <xsl:otherwise>spanish</xsl:otherwise>
	  </xsl:choose>
  </xsl:variable>
  <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
  <!--idioma fin-->

  <script type="text/javascript">
	var nombre	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>';
    var proveedor	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>';
    var ref_estandar	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_estandar']/node()"/>';
    var ref_proveedor	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/>';
    var marca	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>';
    var iva	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/>';
    var unidad_basica	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/>';
    var unidad_lote	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_lote']/node()"/>';
    var farmacia	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='farmacia']/node()"/>';
    var homologado	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='homologado']/node()"/>';
    var precio	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>';
    var familia	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='familia']/node()"/>';
    var subfamilia	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='subfamilia']/node()"/>';
    var grupo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='grupo']/node()"/>';
	
	var strPedido='<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/> ([NUMPRODUCTOS] <xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/>)';
	
	var totProductos=<xsl:value-of select="/ProductosEnPlantillas/LISTAPRODUCTOS/NUMERO_PRODUCTOS"/>;
	var totPaginas=<xsl:value-of select="/ProductosEnPlantillas/LISTAPRODUCTOS/NUMERO_PAGINAS"/>;
	var numSeleccionados;			//	Seleccionados total
	var numSeleccionadosPant;		//	Seleccionados en pantalla
	
  </script>
</head>
<body onLoad="javascript:onLoad();">
  <!--idioma-->
  <xsl:variable name="lang">
    <xsl:choose>
    <xsl:when test="/ProductosEnPlantillas/LANG"><xsl:value-of select="/ProductosEnPlantillas/LANG" /></xsl:when>
    <xsl:otherwise>spanish</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
  <!--idioma fin-->

  <xsl:choose>
  <xsl:when test="ProductosEnPlantillas/SESION_CADUCADA">
    <xsl:apply-templates select="ProductosEnPlantillas/SESION_CADUCADA"/>
  </xsl:when>
<!--
  <xsl:when test="ProductosEnPlantillas/LISTAPRODUCTOS/Sorry">
    <xsl:apply-templates select="ProductosEnPlantillas/LISTAPRODUCTOS/Sorry"/>
  </xsl:when>
-->
  <xsl:otherwise>
    <div class="divLeft">

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscador_catalogo']/node()"/></span>
				<span class="CompletarTitulo" style="width:600px;">
					<xsl:value-of select="/ProductosEnPlantillas/LISTAPRODUCTOS/MENSAJE"/>
					&nbsp;
				</span>
			</p>
			<p class="TituloPagina">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='buscador_catalogo']/node()"/>
				<span class="CompletarTitulo" style="width:700px;">
					<xsl:if test="/ProductosEnPlantillas/LISTAPRODUCTOS/NUMERO_PAGINAS>0">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='pagina']/node()"/>:&nbsp;<xsl:value-of select="/ProductosEnPlantillas/LISTAPRODUCTOS/FILTROS/PAGINAMASUNO"/>&nbsp;/&nbsp;<xsl:value-of select="/ProductosEnPlantillas/LISTAPRODUCTOS/NUMERO_PAGINAS"/>
					</xsl:if>
					&nbsp;&nbsp;&nbsp;
					<!--	botones	-->
					<xsl:if test="/ProductosEnPlantillas/LISTAPRODUCTOS/PAGINAANTERIOR">
					<a class="btnNormal" href="javascript:Enviar('ANTERIOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
					&nbsp;
					</xsl:if>
					<xsl:if test="/ProductosEnPlantillas/LISTAPRODUCTOS/PAGINASIGUIENTE">
					<a class="btnNormal" href="javascript:Enviar('SIGUIENTE');"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
					&nbsp;
					</xsl:if>
					<a class="btnDestacado" id="btnPedido" href="javascript:Pedido();" style="display:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/></a>
					&nbsp;
				</span>
			</p>
		</div>
		<br/>
		<br/>
		  <xsl:choose>
			<xsl:when test="/ProductosEnPlantillas/DONDE_SE_BUSCA='PLA' or /ProductosEnPlantillas/DONDE_SE_BUSCA='CP'">
				<xsl:if test="/ProductosEnPlantillas/LISTAPRODUCTOS/BLOQUEADO">
          <div class="tituloCamp">
            <p><xsl:value-of select="document($doc)/translation/texts/item[@name='esta_buscando_en_plantillas_de_otra_empresa']/node()"/>.</p>
	    		</div><!--fin de tituloCamp-->
        </xsl:if>
	</xsl:when>
	</xsl:choose>


	<form action="http://www.newco.dev.br/Compras/NuevaMultioferta/PedidoDesdeCatalogo.xsql" name="Busqueda" method="POST">
		<input type="hidden" name="IDEMPRESA" value="{/ProductosEnPlantillas/LISTAPRODUCTOS/FILTROS/IDEMPRESADELUSUARIO}"/>
		<input type="hidden" name="PAGINA" value="{/ProductosEnPlantillas/LISTAPRODUCTOS/FILTROS/PAGINA}"/>
		<input type="hidden" name="ORDEN" value="{/ProductosEnPlantillas/LISTAPRODUCTOS/FILTROS/ORDEN}"/>
		<input type="hidden" name="SENTIDO" value="{/ProductosEnPlantillas/LISTAPRODUCTOS/FILTROS/SENTIDO}"/>
		<input type="hidden" name="SELECCIONADOS" id="SELECCIONADOS" value="{/ProductosEnPlantillas/LISTAPRODUCTOS/FILTROS/SELECCIONADOS}"/>
		<input type="hidden" name="HOJADEGASTOS" value="{/ProductosEnPlantillas/HOJADEGASTOS}"/>
		<input type="hidden" name="NUMCEDULA" value="{/ProductosEnPlantillas/NUMCEDULA}"/>
		<input type="hidden" name="NOMBREPACIENTE" value="{/ProductosEnPlantillas/NOMBREPACIENTE}"/>
		<input type="hidden" name="HABITACION" value="{/ProductosEnPlantillas/HABITACION}"/>
		<!--	Buscador -->
		<table>
		<tr>
			<td width="350px" style="text-align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:&nbsp;</label><br/>
				<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/ProductosEnPlantillas/LISTAPRODUCTOS/FILTROS/LISTAPROVEEDORES/field"/>
				<xsl:with-param name="style">width:340px;height:25px;font-size:20px</xsl:with-param>
				</xsl:call-template>
			</td>
			<td width="350px" style="text-align:left;">
				<label><xsl:value-of select="/ProductosEnPlantillas/LISTAPRODUCTOS/FILTROS/NOMBRENIVEL2"/>:&nbsp;</label><br/>
				<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/ProductosEnPlantillas/LISTAPRODUCTOS/FILTROS/LISTAFAMILIAS/field"/>
				<xsl:with-param name="style">width:340px;height:25px;font-size:20px</xsl:with-param>
				</xsl:call-template>
			</td>
			<td width="300px" style="text-align:left;">
				<label><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:&nbsp;</label><br/>
				<input type="text" name="PRODUCTO" style="width:300px;height:25px;font-size:20px" value="{/ProductosEnPlantillas/LISTAPRODUCTOS/FILTROS/PRODUCTO}"/>
			</td>
			<td width="150px" >&nbsp;&nbsp;<a class="btnDestacado" href="javascript:Buscar()"><xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/></a></td>
			<td>&nbsp;</td>
		</tr>
		</table>
		<br/>
		<br/>



      <xsl:choose>
      <xsl:when test="ProductosEnPlantillas/LISTAPRODUCTOS/PRODUCTOS">
	  
		<table class="buscador">
			<!--	Cabecera		-->
          <tr class="subTituloTabla">
            <th class="uno">&nbsp;</th>
            <th class="uno">&nbsp;</th>
            <th class="tres">
				<a href="javascript:OrdenarPor('REFMVM');"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_estandar']/node()"/></a>
			</th>
            <th class="tres">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/>
			</th>
			<th align="left">
				&nbsp;<a href="javascript:OrdenarPor('PRODUCTO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a>
            </th>
            <th class="quince">
              <a href="javascript:OrdenarPor('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a>
            </th>
            <th class="tres">
				<a href="javascript:OrdenarPor('REFPROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/></a>
            </th>
            <th>
				<a href="javascript:OrdenarPor('MARCA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></a>
            </th>
            <th class="diez">
				<a href="javascript:OrdenarPor('FAMILIA');"><xsl:value-of select="/ProductosEnPlantillas/LISTAPRODUCTOS/FILTROS/NOMBRENIVEL2"/></a>
            </th>
            <th class="tres"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/></th>
            <th class="tres"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ud_lote']/node()"/></th>
            <th class="ocho">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio']/node()"/>
            </th>
            <th class="dos">&nbsp;</th>
            <th style="width:60px;"><span id="Contador"></span></th>
            <th class="uno">&nbsp;</th>
	      </tr>

		<!--	Lineas de producto	-->
        <xsl:for-each select="ProductosEnPlantillas/LISTAPRODUCTOS/PRODUCTOS/PRODUCTO">
          <tr class="lineBorderBottom">
            <!--images-->
            <td>&nbsp;</td>
            <td>
              <xsl:if test="IMAGENES/IMAGEN/@id != ''">
                <xsl:variable name="id" select="IMAGENES/IMAGEN/@id"/>
                &nbsp;<img src="http://www.newco.dev.br/images/fotoListadoPeq.gif" alt="con foto" id="{$id}" onmouseover="verFoto('{$id}');" onmouseout="verFoto('{$id}');"/>
                <div id="verFotoPro_{$id}" class="divFotoProBusca" style="display:none;">
                  <img src="http://www.newco.dev.br/Fotos/{IMAGENES/IMAGEN/@peq}"/>
                </div>
              </xsl:if>
            </td>
            <!--producto-->
            <td>&nbsp;<xsl:value-of select="REFERENCIA_PRIVADA"/></td>
            <td>&nbsp;<xsl:value-of select="REFCLIENTE"/></td>
            <td style="padding-left:4px;text-align:left;">
                &nbsp;<a style="text-decoration:none;">
                  <xsl:attribute name="href">javascript:MostrarPagPersonalizada(&#39;http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="PRO_ID"/>&#39;,&#39;producto&#39;,100,80,0,-50);</xsl:attribute>
                  <span class="strongAzul">
                      <xsl:value-of select="NOMBRE_PRIVADO"/>
                  </span>
                </a>
            </td>
            <td align="left">
                &nbsp;<xsl:value-of select="PROVEEDOR"/>
            </td>
            <td align="left">
               &nbsp; <xsl:value-of select="REFERENCIA"/>
            </td>
            <td align="left">&nbsp;<xsl:value-of select="MARCA"/></td>
            <td align="left">&nbsp;<a href="javascript:Familia({IDFAMILIA})"><xsl:value-of select="FAMILIA"/></a></td>
            <td align="left">&nbsp;<xsl:value-of select="UNIDADBASICA"/></td>
            <td align="center"><xsl:value-of select="UNIDADESPORLOTE"/></td>
            <td align="right">
				<xsl:value-of select="TARIFA"/>&nbsp;
            </td>
            <td align="left">
				&nbsp;<xsl:value-of select="DIV_CODIGO"/>
            </td>
            <td align="center">
				<a class="btnDestacado" id="btnInsertar_{PRO_ID}" href="javascript:Insertar({PRO_ID},{IDPROVEEDOR})"><xsl:value-of select="document($doc)/translation/texts/item[@name='insertar']/node()"/></a>
				<a id="btnQuitar_{PRO_ID}" href="javascript:Quitar({PRO_ID})" style="display:none;"><img src="http://www.newco.dev.br/images/check.gif"/></a>
            </td>
            <td>&nbsp;</td>
          </tr>
		</xsl:for-each>
        </table>
      </xsl:when>
      <xsl:otherwise>
        <p style="text-align:center;margin-top:10px;padding-bottom:10px;font-weight:bold;border-bottom:1px solid grey;"><xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_datos_que_mostrar']/node()"/></p>
      </xsl:otherwise>
      </xsl:choose>
      </form>
    </div><!--fin de divLeft del inicio-->

    <!-- detalle de producto -->
    <div class="overlay-container">
		  <div class="window-container zoomout">
        <p style="text-align:right;margin-bottom:5px;">
          <a href="javascript:showTabla(false);" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/cerrar.gif" /></a>
          <a href="javascript:showTabla(false);"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>
        </p>

        <table class="infoTable incidencias" id="detalleProd" cellspacing="5" style="border-collapse:none; border:2px solid #7d7d7d;" >
        <tbody></tbody>
        </table>
      </div>
    </div>
    <!-- detalle de producto-->

  </xsl:otherwise>
  </xsl:choose>
</body>
</html>
</xsl:template>

<xsl:template match="Sorry">
  <br/><br/><br/>
  <div class="middle">
    <br/>
    <xsl:choose>
		<xsl:when test="/ProductosEnPlantillas/DONDE_SE_BUSCA='PLA'">
      <xsl:value-of select="document($doc)/translation/texts/item[@name='producto_no_encontrado_en_plantillas']/node()"/>
		</xsl:when>
		<xsl:when test="/ProductosEnPlantillas/DONDE_SE_BUSCA='CP'">
      <xsl:value-of select="document($doc)/translation/texts/item[@name='producto_no_encontrado_en_catalogo_privado']/node()"/>
		</xsl:when>
		<xsl:when test="/ProductosEnPlantillas/DONDE_SE_BUSCA='NOPLA'">
      <xsl:value-of select="document($doc)/translation/texts/item[@name='producto_no_encontrado']/node()"/>
		</xsl:when>
		</xsl:choose>

    <br/><br/>
    <xsl:value-of select="document($doc)/translation/texts/item[@name='por_favor_compruebe_ortografia']/node()"/>
    <br/><br/>
    <xsl:value-of select="document($doc)/translation/texts/item[@name='muchas_gracias']/node()"/>
    <br/><br/>
  </div><!--fin de middle-->
</xsl:template>
</xsl:stylesheet>
