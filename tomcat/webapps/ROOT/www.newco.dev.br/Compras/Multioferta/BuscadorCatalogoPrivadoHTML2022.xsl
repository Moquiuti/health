<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Busqueda de productos en la plantilla desde Enviar Pedidos
	Ultima revision: ET 27jun22 09:05 BuscadorCatalogoPrivado2022_180322.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
	<meta http-equiv="Cache-Control" Content="no-cache"/>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<link href="http://www.newco.dev.br/General/Tabla-popup.css" rel="stylesheet" type="text/css"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/Tabla-popup.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Compras/Multioferta/BuscadorCatalogoPrivado2022_180322.js"></script>

	<!--idioma-->
	<xsl:variable name="lang">
	  <xsl:choose>
	  <xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG"/></xsl:when>
	  <xsl:otherwise>spanish</xsl:otherwise>
	  </xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='Buscador_catalogo_privado']/node()"/></title>

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
	</script>

</head>
<body>
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
			<p class="TituloPagina">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='Buscador_catalogo_privado']/node()"/>
				&nbsp;<span class="fuentePeq">(<xsl:value-of select="/ProductosEnPlantillas/LISTAPRODUCTOS/MENSAJE"/>)</span>			
				<span class="CompletarTitulo300">
					<!--	botones	-->
					<xsl:if test="/ProductosEnPlantillas/LISTAPRODUCTOS/PAGINAANTERIOR">
					<a class="btnNormal" href="javascript:Enviar(document.forms[0],'ANTERIOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
					&nbsp;
					</xsl:if>
					<xsl:if test="/ProductosEnPlantillas/LISTAPRODUCTOS/PAGINASIGUIENTE">
					<a class="btnNormal" href="javascript:Enviar(document.forms[0],'SIGUIENTE');"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>
					&nbsp;
					</xsl:if>
				</span>
			</p>
		</div>
		<br/>
		<br/>

	<!--	Campos ocultos para avanzar y retroceder en la busqueda	-->
	<form action="" name="Busqueda" method="GET">
		<input type="hidden" name="PAGINA" value="{/ProductosEnPlantillas/LISTAPRODUCTOS/PAGINA}"/>
		<input type="hidden" name="LLP_NOMBRE" value="{/ProductosEnPlantillas/LISTAPRODUCTOS/PRODUCTOBUSCADO}"/><!--	PRODUCTO	-->
		<input type="hidden" name="LLP_PROVEEDOR" value="{/ProductosEnPlantillas/LISTAPRODUCTOS/PROVEEDORBUSCADO}"/><!--	PROVEEDOR	-->
		<input type="hidden" name="ORDEN" value="{/ProductosEnPlantillas/LISTAPRODUCTOS/ORDEN}"/>
		<input type="hidden" name="SENTIDO" value="{/ProductosEnPlantillas/LISTAPRODUCTOS/SENTIDO}"/>
		<input type="hidden" name="IDPRODUCTO"/>
		<input type="hidden" name="OCULTAR"/>
		<input type="hidden" name="SOLO_OCULTOS"/>
		<input type="hidden" name="SIN_STOCKS" value="{/ProductosEnPlantillas/LISTAPRODUCTOS/SIN_STOCKS}"/>
		<input type="hidden" name="IDPROVEEDOR" value="{/ProductosEnPlantillas/LISTAPRODUCTOS/IDPROVEEDOR}"/>

      <xsl:choose>
      <xsl:when test="/ProductosEnPlantillas/LISTAPRODUCTOS/PRODUCTO">

		<xsl:if test="/ProductosEnPlantillas/LISTAPRODUCTOS/LISTAEMPRESAS">
			<table>
			<tr class="h30px">
				<td class="w100px">&nbsp;</td>
				<td class="w140px textRight"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/>:&nbsp;</label></td>
				<td class="w300px textLeft">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/ProductosEnPlantillas/LISTAPRODUCTOS/LISTAEMPRESAS/field"/>
						<xsl:with-param name="onChange">javascript:Enviar(document.forms[0],'BUSCAR');</xsl:with-param>
                		<xsl:with-param name="claSel">w300px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td>&nbsp;</td>
			</tr>
			</table>
		</xsl:if>

      <xsl:choose>
      <xsl:when test="/ProductosEnPlantillas/LISTAPRODUCTOS/LISTAUSUARIOS">
        <table class="buscador">
          <!--elegir usuario para asisa-->
          <tr class="h30px">
				<td class="w100px">&nbsp;</td>
				<td class="w140px"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:&nbsp;</label></td>
				<td class="w300px">
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/ProductosEnPlantillas/LISTAPRODUCTOS/LISTAUSUARIOS/field"/>
						<xsl:with-param name="onChange">CambiarUsuario(this.value);</xsl:with-param>
						<xsl:with-param name="claSel">w500px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td>&nbsp;</td>
          </tr>
        </table>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
      </xsl:choose>

	<div class="tabela tabela_redonda">
	<table cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
		<tr class="subTituloTabla">
            <th class="w1px">&nbsp;</th>
            <th class="w1px">&nbsp;</th>
            <th class="w1px">&nbsp;</th>
			<th class="textLeft">
				<a href="javascript:OrdenarPor('PRODUCTO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/></a>
            </th>
            <th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_cliente']/node()"/></th>
            <th class="w200px">
              <a href="javascript:OrdenarPor('PROVEEDOR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></a>&nbsp;(<xsl:value-of select="document($doc)/translation/texts/item[@name='ref']/node()"/>.)<br />
              <!--desplegable proveedores-->
				<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/ProductosEnPlantillas/LISTAPRODUCTOS/FIDProveedor/field"/>
					<xsl:with-param name="onChange">Enviar(document.forms[0],'BUSCAR');</xsl:with-param>
                	<xsl:with-param name="claSel">w200px</xsl:with-param>
				</xsl:call-template>
            </th>
            <th>
              <xsl:choose>
              <xsl:when test="(/ProductosEnPlantillas/LISTAPRODUCTOS/ADMIN_CDC or /ProductosEnPlantillas/LISTAPRODUCTOS/ADMIN_MVM) and (/ProductosEnPlantillas/LISTAPRODUCTOS/MOSTRAR_BOTON_OCULTOS)">
                <xsl:attribute name="class">w30px</xsl:attribute>

                <xsl:if test="not(/ProductosEnPlantillas/LISTAPRODUCTOS/MVM) and not(/ProductosEnPlantillas/LISTAPRODUCTOS/MVMB)">
                  <xsl:value-of select="document($doc)/translation/texts/item[@name='ocultos_mayu']/node()"/><br/>
                  <input type="checkbox" class="muypeq" name="SOLO_OCULTOS_IN" onchange="Enviar(document.forms[0],'BUSCAR');">
                    <xsl:choose>
                    <xsl:when test="/ProductosEnPlantillas/LISTAPRODUCTOS/SOLO_OCULTOS = 'S'">
                      <xsl:attribute name="checked">checked</xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                    </xsl:otherwise>
                    </xsl:choose>
                  </input>
                </xsl:if>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="class">w1px</xsl:attribute>
                <input type="checkbox" name="SOLO_OCULTOS_IN" style="display:none;"/>
              </xsl:otherwise>
              </xsl:choose>
            </th>
            <th class="w50px">
				<a href="javascript:OrdenarPor('MARCA');"><xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/></a>
            </th>
            <th class="w120px"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/></th>
            <!--precio sin iva, con iva, total-->
            <th class="w80px">
			<xsl:choose>
              <!--viejo modelo asisa viamed-->
				<xsl:when test="/ProductosEnPlantillas/LISTAPRODUCTOS/VIEJO_MODELO">
                <xsl:choose>
                <xsl:when test="/ProductosEnPlantillas/LISTAPRODUCTOS/MOSTRAR_PRECIO_CON_IVA"><!--viamed-->
					<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_prov_con_iva_2line']/node()"/>
                </xsl:when>
                <xsl:otherwise><!--asisa precio sin iva-->
                  <xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_prov_sin_iva_2line']/node()"/>
                </xsl:otherwise>
                </xsl:choose>
			</xsl:when>
              <!--nuevo modelo gomosa, vendrell, fncp-->
              <xsl:when test="/ProductosEnPlantillas/LISTAPRODUCTOS/NUEVO_MODELO">
				<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_final']/node()"/> <br/>
                (<xsl:value-of select="document($doc)/translation/texts/item[@name='iva_comision']/node()"/>)
				</xsl:when>
				</xsl:choose>
            </th>

			<xsl:if test="(/ProductosEnPlantillas/LISTAPRODUCTOS/ADMIN_CDC or /ProductosEnPlantillas/LISTAPRODUCTOS/ADMIN_MVM) and /ProductosEnPlantillas/LISTAPRODUCTOS/NUEVO_MODELO">
	            <!--enseñamos precio ref solo a nuevo modelo y super usuarios porqué ve precio final, gomosa, fncp-->
            	<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_ref']/node()"/>.</th>
			</xsl:if>

            <th class="w100px"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ud_ba_lote_2line']/node()"/></th>
            <th class="w50px">
            	<xsl:if test="/ProductosEnPlantillas/LISTAPRODUCTOS/ADMIN_CDC or /ProductosEnPlantillas/LISTAPRODUCTOS/ADMIN or /ProductosEnPlantillas/LISTAPRODUCTOS/CDC">
					<a href="javascript:OrdenarPor('CONSUMO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo']/node()"/></a>
            	</xsl:if>
            </th>
		</tr>
		</thead>
		<!--	Cuerpo de la tabla	-->
		<tbody class="corpo_tabela">
        <xsl:for-each select="ProductosEnPlantillas/LISTAPRODUCTOS/PRODUCTO">
          <tr class="conhover">
            <td class="color_status">
              <!--si usuario gerente tipo msirvent ve info de sin stock, no modifica-->
              <xsl:if test="../ADMIN and TIPO_SIN_STOCK != ''">
                <xsl:choose>
                <xsl:when test="TIPO_SIN_STOCK='S'">
                  <img src="http://www.newco.dev.br/images/SemaforoAmbar.gif" title="Sin stock: {TEXTO_SIN_STOCK}" />
                </xsl:when>
                <xsl:when test="TIPO_SIN_STOCK='D'">
                  <img src="http://www.newco.dev.br/images/SemaforoRojo.gif" title="Descatalogado: {TEXTO_SIN_STOCK}" />
                </xsl:when>
                </xsl:choose>
              </xsl:if>
            </td>
            <td>
				<xsl:if test="/ProductosEnPlantillas/LISTAPRODUCTOS/ADMIN_CDC">
                <xsl:choose>
                <!--si es mvm y busco por otro cliente no visualizo el boton catalogo-->
                <xsl:when test="(/ProductosEnPlantillas/DONDE_SE_BUSCA='PLA' or /ProductosEnPlantillas/DONDE_SE_BUSCA='CP') and /ProductosEnPlantillas/LISTAPRODUCTOS/BLOQUEADO">
                </xsl:when>
                <xsl:otherwise>
	    			<a class="btnDiscreto" href="FichaAdjudicacion({IDPRODUCTO});">CAT</a>
                </xsl:otherwise>
                </xsl:choose>
	    		</xsl:if>
            </td>

          <xsl:choose>
          <xsl:when test="/ProductosEnPlantillas/LISTAPRODUCTOS/DERECHOS/@ADMIN='S'">
            <td>
				<a href="javascript:FichaEmpresa({IDCLIENTE});">
                	<xsl:value-of select="CLIENTE"/>
            	</a>
            </td>
          </xsl:when>
          </xsl:choose>

            <!--images-->
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
            <td style="padding-left:4px;text-align:left;">
              <xsl:choose>
              <!--minimalista para proveedores.com-->
              <xsl:when test="/ProductosEnPlantillas/LISTAPRODUCTOS/MINIMALISTA">
                <a href="javascript:verDetalleProducto({IDPRODUCTO});">
                    <xsl:choose>
                    <xsl:when test="NOMBRE_PRIVADO">
                      <xsl:value-of select="NOMBRE_PRIVADO"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="PRODUCTO"/>
                    </xsl:otherwise>
                    </xsl:choose>
                </a>
              </xsl:when>
              <xsl:otherwise>
                <a href="javascript:FichaProducto({IDPRODUCTO});">
                  <span class="strongAzul">
                    <xsl:choose>
                    <xsl:when test="NOMBRE_PRIVADO">
                      <xsl:value-of select="NOMBRE_PRIVADO"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="PRODUCTO"/>
                    </xsl:otherwise>
                    </xsl:choose>
                  </span>
                </a>
              </xsl:otherwise>
              </xsl:choose>
            </td>
			<td>
				<xsl:choose>
					<xsl:when test="REFCLIENTE != ''">
						<xsl:value-of select="REFCLIENTE"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="REFERENCIA_PRIVADA"/>
					</xsl:otherwise>
				</xsl:choose>&nbsp;
			</td>
            <td align="left">
              <xsl:choose>
              <xsl:when test="/ProductosEnPlantillas/LISTAPRODUCTOS/MINIMALISTA">
                <xsl:value-of select="PROVEEDOR"/>
              </xsl:when>
              <xsl:otherwise>
				 <xsl:choose>
				<xsl:when test="/ProductosEnPlantillas/LISTAPRODUCTOS/BLOQUEADO">
                  <xsl:value-of select="PROVEEDOR"/>&nbsp;
                  <br />
                  <span class="fuentePeq">(<xsl:value-of select="REFERENCIA"/>)</span>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:choose>
                  <xsl:when test="PLANTILLAS/PLANTILLA/ID!='MASPLANTILLAS'">
                    <a class="noDecor">
                      <xsl:attribute name="href">javascript:EjecutarFuncionDelFrame('zonaPlantilla',<xsl:value-of select="PLANTILLAS/PLANTILLA/ID"/>);</xsl:attribute>
                      <xsl:value-of select="PROVEEDOR"/></a>&nbsp;
                    <br />
                    <span class="fuentePeq">(<xsl:value-of select="REFERENCIA"/>)</span>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="PROVEEDOR"/>&nbsp;
                    <br />
                    <span class="fuentePeq">(<xsl:value-of select="REFERENCIA"/>)</span>
                    &nbsp;<img width="12" src="http://www.newco.dev.br/images/urgente.gif"/>
                  </xsl:otherwise>
                  </xsl:choose>
                </xsl:otherwise>
                </xsl:choose>
              </xsl:otherwise>
              </xsl:choose>
            </td>
            <td align="center">
              <!--si hay marca enseño ocultos-->
              <xsl:if test="(/ProductosEnPlantillas/LISTAPRODUCTOS/ADMIN_CDC or /ProductosEnPlantillas/LISTAPRODUCTOS/ADMIN_MVM) and (/ProductosEnPlantillas/LISTAPRODUCTOS/MOSTRAR_BOTON_OCULTOS)">
                <xsl:choose>
                <xsl:when test="PLANTILLAS/PLANTILLA/CENTROAUTORIZADO='N'">
                     <xsl:value-of select="document($doc)/translation/texts/item[@name='Centro_bloqueado']/node()"/>
                </xsl:when>
                <xsl:when test="PLANTILLAS/PLANTILLA/OCULTAR='S'">
               		<a href="javascript:Ocultar({IDPRODUCTO},'N')" class="btnRojoPeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='Oculto']/node()"/></a>
                </xsl:when>
                <xsl:when test="PLANTILLAS/PLANTILLA/OCULTAR='N'">
                	<a href="javascript:Ocultar({IDPRODUCTO},'S')" class="btnDestacadoPeq"><xsl:value-of select="document($doc)/translation/texts/item[@name='Visible']/node()"/></a>
                </xsl:when>
                <xsl:otherwise>
                </xsl:otherwise>
                </xsl:choose>
              </xsl:if>
            </td>
            <td align="center"><xsl:value-of select="substring(MARCA,0,15)"/></td>
            <td align="center"><xsl:value-of select="UNIDADBASICA"/></td>
            <td align="right">
              <xsl:choose>
              <!--viejo modelo asisa viamed-->
				<xsl:when test="/ProductosEnPlantillas/LISTAPRODUCTOS/VIEJO_MODELO">
                <xsl:choose>
                <xsl:when test="/ProductosEnPlantillas/LISTAPRODUCTOS/MOSTRAR_PRECIO_CON_IVA"><!--viamed-->
					<xsl:value-of select="TARIFAPRIVADA_CONIVA_EURO"/>
                </xsl:when>
                <xsl:otherwise><!--asisa precio sin iva-->
                	<xsl:value-of select="TARIFAPRIVADA_EURO"/>
                </xsl:otherwise>
                </xsl:choose>
				</xsl:when>
              	<!--nuevo modelo gomosa, vendrell, fncp-->
              	<xsl:when test="/ProductosEnPlantillas/LISTAPRODUCTOS/NUEVO_MODELO">
					<xsl:value-of select="TARIFATOTAL_EURO"/>
				</xsl:when>
				</xsl:choose>
            </td>

          <xsl:if test="(/ProductosEnPlantillas/LISTAPRODUCTOS/ADMIN_CDC or /ProductosEnPlantillas/LISTAPRODUCTOS/ADMIN_MVM) and /ProductosEnPlantillas/LISTAPRODUCTOS/NUEVO_MODELO">
            <td align="center">
              <xsl:choose>
					<xsl:when test="PRECIOREF!=''">
						<xsl:value-of select="PRECIOREF"/>
					</xsl:when>
					<xsl:otherwise>
        				<xsl:value-of select="document($doc)/translation/texts/item[@name='no_informado']/node()"/>
					</xsl:otherwise>
              </xsl:choose>
            </td>
			</xsl:if>

            <td align="center"><xsl:value-of select="UNIDADESPORLOTE"/></td>
            <!--consumo-->
            <td align="center">
			
              <xsl:if test="/ProductosEnPlantillas/LISTAPRODUCTOS/ADMIN_CDC or /ProductosEnPlantillas/LISTAPRODUCTOS/ADMIN or /ProductosEnPlantillas/LISTAPRODUCTOS/CDC">
                <xsl:value-of select="PEDIDOS"/>
              </xsl:if>
            </td>
          </tr>
	  	</xsl:for-each>
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="13">&nbsp;</td></tr>
		</tfoot>
        </table>
		</div>-->
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
