<?xml version="1.0" encoding="iso-8859-1" ?>
<!-- 
 |
 +--> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"> 
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  
      
        
<!--nueva Oferta Club Vip Tiendas-->
<xsl:template name="nuevaOfertaClubVipTiendas">
    <!--idioma-->                                              
    <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="//LANG"><xsl:value-of select="//LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
        </xsl:choose>  
    </xsl:variable>
    <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
  <!--idioma fin-->
<!--oferta stock -->
    
    <tr class="sinLinea">
	<td class="labelRight grisMed">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='familia']/node()"/>:&nbsp;
		<span class="camposObligatorios">*</span>
	</td>
	<td class="datosLeft">
            <input type="hidden" name="IDEMPRESA" id="IDEMPRESA" value="{NUEVAOFERTA/USUARIO/EMP_ID}" />
            <xsl:call-template name="desplegable">
                <xsl:with-param name="path" select="NUEVAOFERTA/LISTAFAMILIAS/field"/>
                <xsl:with-param name="onChange">javascript:SeleccionaSubFamilia(this.value);</xsl:with-param>
                <xsl:with-param name="claSel">select140</xsl:with-param>
                <xsl:with-param name="nombre">SO_IDFAMILIA</xsl:with-param>
                <xsl:with-param name="id">SO_IDFAMILIA</xsl:with-param>
            </xsl:call-template>
        </td>
	</tr>
        <tr style="display:none;" id="desplSubFamilia">
            <td class="labelRight grisMed">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='subfamilia']/node()"/>:&nbsp;
		<span class="camposObligatorios">*</span>
            </td>
            <td class="datosLeft">
        	<select name="SO_IDSUBFAMILIA" id="SO_IDSUBFAMILIA" class="select140 catalogo">
                    <xsl:if test="Buscador/BUSCADOR/LISTACATEGORIAS">
                	<xsl:attribute name="onchange">javascript:SeleccionaGrupo(this.value);</xsl:attribute>
                    </xsl:if>
        	</select>
            </td>
	</tr>
        <tr class="sinLinea">
            <td class="labelRight grisMed">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>:&nbsp;
		<span class="camposObligatorios">*</span>
            </td>
            <td class="datosLeft">
                <xsl:call-template name="desplegable">
                    <xsl:with-param name="path" select="NUEVAOFERTA/MARCA/field"/>
                    <xsl:with-param name="claSel">select140</xsl:with-param>
                    <xsl:with-param name="nombre">SO_IDMARCA</xsl:with-param>
                    <xsl:with-param name="id">SO_IDMARCA</xsl:with-param>
                </xsl:call-template>
		<xsl:value-of select="document($doc)/translation/texts/item[@name='caso_otras_marcas']/node()"/>:&nbsp;
		<input type="text" name="SO_NUEVAMARCA" id="SO_NUEVAMARCA" maxlength="25" size="15"/>
            </td>
        </tr>
	<tr class="sinLinea">
            <td class="diecisiete labelRight grisMed">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>:&nbsp;
		<span class="camposObligatorios">*</span>
            </td>
            <td class="cinquenta datosLeft"><input type="text" name="SO_TITULO" id="SO_TITULO" maxlength="200" size="62"/>&nbsp;
                <xsl:value-of select="document($doc)/translation/texts/item[@name='titulo_explicacion_stck_ofe']/node()"/>
            </td>
	</tr>
        <!--por default liquidacion en club vip tiendas-->
        <tr style="display:none;">
            <td class="labelRight grisMed">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/>:
		<span class="camposObligatorios">*</span>
            </td>
            <td class="datosLeft">
                <input type="radio" class="muypeq" name="SO_TIPO_RADIO" id="SO_TIPO_VACIO" value="" style="display:none;"></input>
                <input type="radio" class="muypeq" name="SO_TIPO_RADIO" id="SO_TIPO_LIQ" value="LIQ" checked="checked" onchange="checkTipo('NORMAL');"></input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='liquidaciones_stock']/node()"/>&nbsp;&nbsp;
                <input type="radio" class="muypeq" name="SO_TIPO_RADIO" id="SO_PM_SEG" value="SEG" onchange="checkTipo('NORMAL');"></input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='segunda_mano']/node()"/>&nbsp;&nbsp;
            </td>
	</tr>
	<tr class="sinLinea">
            <td class="labelRight grisMed">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='ref_vendedor']/node()"/>:&nbsp;
		<span class="camposObligatorios">*</span>
            </td>
            <td class="datosLeft">
    	   <input type="text" class="peq" name="SO_REFCLIENTE" id="SO_REFCLIENTE" maxlength="20" size="15" value="{NUEVAOFERTA/REFPROVEEDOR}"/>&nbsp;
    	</td>
	</tr>
	<!--campos hidden mvm-->
	<input type="hidden" name="SO_FECHACADUCIDAD_PROD" id="SO_FECHACADUCIDAD_PROD" />
	<input type="hidden" name="SO_UDBASICA" id="SO_UDBASICA"/>
	<input type="hidden" name="SO_PRECIOUNITARIO" id="SO_PRECIOUNITARIO"/>
	<input type="hidden" name="SO_COMPRAMINIMA" id="SO_COMPRAMINIMA"/>   
	<input type="hidden" name="SO_PRODUCTO" id="SO_PRODUCTO"/>
	<input type="hidden" name="SO_FECHACADUCIDAD" id="SO_FECHACADUCIDAD"/>
	<input type="hidden" name="SO_CANTIDAD" id="SO_CANTIDAD"/>
	<input type="hidden" name="SO_UDLOTE" id="SO_UDLOTE"/>

	<tr class="sinLinea">
	<td class="diecisiete labelRight grisMed">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:&nbsp;
		<span class="camposObligatorios">*</span>
	</td>
	<td class="cinquenta datosLeft">
    	<textarea type="text" name="SO_DESCRIPCION" id="SO_DESCRIPCION" row="3" cols="62"/>&nbsp;
	<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_explicacion_stck_ofe']/node()"/>
	</td>
	</tr>
	<tr class="noObliSeg sinLinea">
	<td class="labelRight grisMed">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_lote']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_iva']/node()"/>:&nbsp;
		<span class="camposObligatorios">*</span>
	</td>
	<td class="datosLeft"><input type="text" class="peq" name="SO_PRECIOLOTE" id="SO_PRECIOLOTE" maxlength="10" size="8"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/></td>
	</tr>
	<tr class="noObliSeg sinLinea">
	<td class="labelRight grisMed">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_retail_lote']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_iva']/node()"/>:&nbsp;
		<span class="camposObligatorios">*</span>
	</td>
	<td class="datosLeft"><input type="text" class="peq" name="SO_PRECIOPUBLICOLOTE" id="SO_PRECIOPUBLICOLOTE" maxlength="10" size="8"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/></td>
	</tr>
	<!--ahorro: lo quitamos (ET 16/4/16)
	<tr class="sinLinea">
	<td class="labelRight grisMed">
	<xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/>:&nbsp;
	</td>
	<td class="datosLeft"><input type="text" name="SO_AHORRO" id="SO_AHORRO" maxlength="10" size="8"/>
	&nbsp;%
	</td>
	</tr>
	-->
	<xsl:choose>
	<xsl:when test="/StockOferta/LANG = 'spanish'">
	<tr class="sinLinea">
    	<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/>:&nbsp;
	<span class="camposObligatorios">*</span>
    	</td>
    	<td class="datosLeft">
        	<select name="SO_IVA" id="SO_IVA">
            	<option value="0">0%</option>
            	<option value="3">3%</option>
            	<option value="4">4%</option>
            	<option value="10">10%</option>
            	<option value="21" selected="selected">21%</option>
        	</select>
    	</td>
	</tr>
	</xsl:when>
	<xsl:otherwise>
    	 <input type="hidden" name="SO_IVA" id="SO_IVA" value="0" />
	</xsl:otherwise>
	</xsl:choose>

	<!--solo para mvm si no no enseño.-->
	<tr style="display:none;">
		<td class="labelRight grisMed">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/>:
			<span class="camposObligatorios">*</span>
		</td>
		<td class="datosLeft">
            <input type="radio" class="muypeq" name="SO_PEDIDOMINIMO_RADIO" id="SO_PM_SIN" value="" style="display:none;"></input>
            <input type="radio" class="muypeq" name="SO_PEDIDOMINIMO_RADIO" id="SO_PM_SIN" value="0" checked="checked" onchange="verPedidoMinimo();"></input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_pedido_minimo']/node()"/>&nbsp;&nbsp;
            <input type="radio" class="muypeq" name="SO_PEDIDOMINIMO_RADIO" id="SO_PM_DEFECTO" value="-1" onchange="verPedidoMinimo();"></input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo_defecto']/node()"/>&nbsp;&nbsp;
            <input type="radio" class="muypeq" name="SO_PEDIDOMINIMO_RADIO" id="SO_PM_INFORMAR" value="I" onchange="verPedidoMinimo();"></input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='informar_pedido_minimo']/node()"/>&nbsp;&nbsp;
            <span class="pedidoMinimoValue" style="display:none;">
                <input type="text" class="peq" name="SO_PEDIDOMINIMO_VALUE" id="SO_PEDIDOMINIMO_VALUE" maxlength="8" size="5"/>&nbsp;
                <xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>
            </span>
		</td>
	</tr>
                         <tr class="sinLinea">
		<td class="labelRight grisMed">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/>:
			<span class="camposObligatorios">*</span>
		</td>
		<td class="datosLeft"><input type="text" class="peq" name="SO_PLAZOENVIO" id="SO_PLAZOENVIO" maxlength="10" size="8"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='dias']/node()"/>
		</td>
	</tr>
	<!--	18abr16 No mostramos el coste de envío
	<tr class="sinLinea">
		<td class="labelRight grisMed">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='coste_trasporte']/node()"/>:
			<span class="camposObligatorios">*</span>
		</td>
		<td class="datosLeft"><input type="text" name="SO_COSTEENVIO" id="SO_COSTEENVIO" maxlength="10" size="8"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>
		</td>
	</tr>
	-->
	<input type="hidden" name="SO_COSTEENVIO" id="SO_COSTEENVIO" maxlength="10" size="8" value="0"/>
	<tr class="sinLinea">
		<td class="labelRight grisMed">
		<xsl:value-of select="document($doc)/translation/texts/item[@name='lista_de_contenido']/node()"/>:</td>
		<td class="datosLeft" colspan="2">
			
			<span id="newDocFICHA" align="center">
			<a class="botonPeque" href="javascript:verCargaDoc('FICHA');" title="Subir ficha técnica" style="text-decoration:none;">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='subir_documento']/node()"/>
			</a>
			&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='explica_descargar_modelo']/node()"/>:&nbsp;
			<a class="botonPeque" id="modelo" href="http://www.newco.dev.br/images/CVT_ModeloInformativoLote.xlsx" title="Modelo Informativo Lote" style="text-decoration:none;">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='descargar_modelo']/node()"/>
			</a>
			</span>
                                                
			<span id="docBoxFICHA" style="display:none;" align="center"></span>&nbsp;
			<span id="borraDocFICHA" style="display:none;" align="center"></span>
		</td>
	</tr>
    <tr id="cargaFICHA" class="cargas" style="display:none;">
		<td colspan="3"><xsl:call-template name="CargaDocumentos"><xsl:with-param name="tipo">FICHA</xsl:with-param></xsl:call-template></td>
	</tr>
     <tr class="sinLinea">
        <td class="labelRight grisMed">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='imagen']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:
        </td>
        <td class="datosLeft" colspan="2">
            <br />
            <xsl:copy-of select="document($doc)/translation/texts/item[@name='formato_imagenes']/node()"/>
            <xsl:call-template name="image"><xsl:with-param name="num">1</xsl:with-param></xsl:call-template>
            <xsl:call-template name="image"><xsl:with-param name="num">2</xsl:with-param></xsl:call-template>
            <xsl:call-template name="image"><xsl:with-param name="num">3</xsl:with-param></xsl:call-template>
            <xsl:call-template name="image"><xsl:with-param name="num">4</xsl:with-param></xsl:call-template>
            <xsl:call-template name="image"><xsl:with-param name="num">5</xsl:with-param></xsl:call-template>
            <xsl:call-template name="image"><xsl:with-param name="num">6</xsl:with-param></xsl:call-template>
            <div id="waitBox">&nbsp;</div>
        </td>
    </tr>
    <tr class="sinLinea"> 
        <td colspan="2">&nbsp;</td>
    </tr>
	<tr class="sinLinea">
		<td class="labelRight"></td>
		<td class="datosLeft">
			<!--<div class="boton" id="BotonSubmit">-->
				<a class="btnDestacado" id="BotonSubmit" href="javascript:ValidarFormulario(document.forms['frmStockOferta'],'NUEVA','CVT');">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/>
				</a>
			<!--/div>-->
		</td>

	</tr>
</xsl:template>


<!--Oferta Club Vip Tiendas-->
<xsl:template name="ofertaClubVipTiendas">
    <!--idioma-->                                              
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="//LANG"><xsl:value-of select="//LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
    <!--idioma fin-->
      <h1 class="titlePageDark" style="float:left;width:70%;padding-left:10%;padding-bottom:5px;">
         <img src="http://www.newco.dev.br/images/logoCVTblackFino.jpg" alt="Club Vip Tiendas" />
         <xsl:choose>
                <xsl:when test="GUARDAR = 'S'">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_stock_guardada_exito']/node()"/>&nbsp;
                    <xsl:value-of select="OFERTA/CT_OFE_CODIGO"/>:&nbsp;<xsl:value-of select="OFERTA/CT_OFE_TITULO"/>
                </xsl:when> 
               <!-- <xsl:otherwise>
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_stock']/node()"/>&nbsp;
                    <xsl:value-of select="OFERTA/CT_OFE_CODIGO"/>:&nbsp;<xsl:value-of select="OFERTA/CT_OFE_TITULO"/>
                </xsl:otherwise>-->
		</xsl:choose>
                
        </h1>
        <h1 class="titlePageDark" style="float:left;width:20%;padding-bottom:5px;">
				<xsl:if test="/StockOferta/OFERTA/MVMB or /StockOferta/OFERTA/MVM or /StockOferta/OFERTA/ADMIN"><span style="float:right; padding:5px; font-weight:bold;" class="amarillo">OFE_ID: <xsl:value-of select="/StockOferta/OFERTA/CT_OFE_ID"/></span></xsl:if>
        </h1>
		<!--oferta club vip -->
        <div class="fichaClubVip">
            <div class="imageFichaClubVip">
                <xsl:choose>
                    <xsl:when test="/StockOferta/OFERTA/IMAGENES/IMAGEN/@id != ''"><img src="http://www.newco.dev.br/Fotos/{/StockOferta/OFERTA/IMAGENES/IMAGEN/@grande}" /></xsl:when>
                    <xsl:otherwise><img src="http://www.newco.dev.br/images/noImageCVTgrande.jpg" alt="no image"/></xsl:otherwise>
                </xsl:choose>
                
            </div>
            <div class="datosFichaClubVip">
                <h2>
				<xsl:if test="OFERTA/CT_OFE_IDESTADO = 'F'"><xsl:value-of select="document($doc)/translation/texts/item[@name='lote_vendido']/node()"/>:&nbsp;
				</xsl:if>
				<xsl:value-of select="OFERTA/CT_OFE_TITULO"/>
				</h2>
                <h3>
					<!--
                    <xsl:value-of select="OFERTA/MARCA/field/dropDownList/listElem[ID = ../../@current]/listItem"/>&nbsp;&nbsp;&nbsp;&nbsp;
                    [<xsl:value-of select="OFERTA/LISTASUBFAMILIAS/field/dropDownList/listElem[ID = ../../@current]/listItem"/>&nbsp;-&nbsp;
                    <xsl:value-of select="OFERTA/LISTAFAMILIAS/field/dropDownList/listElem[ID = ../../@current]/listItem"/>]
					-->
					Marca:&nbsp;"<xsl:value-of select="OFERTA/NOMBREMARCA"/>"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					Categoría:&nbsp;"<xsl:value-of select="OFERTA/CATEGORIA_PRODUCTO"/>"
                </h3>
                <p class="descripcion"><xsl:copy-of select="OFERTA/CT_OFE_DESCRIPCION"/></p>
                
                <p class="contenidoLote">
                    <a href="http://www.newco.dev.br/Documentos/{OFERTA/FT/URL}" title="{OFERTA/FT/NOMBRE} - {OFERTA/FT/FECHA}" target="_blank">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='ver_lista_de_contenido']/node()"/>&nbsp;
                        <img src="http://www.newco.dev.br/images/lente.gif" alt="contenido" />
                    </a>
                </p> 
                
                <div class="precio">
                    <!-- 10/05/2016 - Mostrar los precios con IVA -->
                    <p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_retail']/node()"/></label>&nbsp;&nbsp;<span><xsl:value-of select="OFERTA/CT_OFE_PRECIOPUBLICOLOTE_IVA" />&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/></span></p>
                    <p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/></label>&nbsp;&nbsp;<span><xsl:value-of select="OFERTA/CT_OFE_AHORRO" />&nbsp;%</span></p>
                    <p class="precioLote"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_lote']/node()"/></label>&nbsp;&nbsp;<xsl:value-of select="OFERTA/CT_OFE_PRECIOLOTECONCOMISION_IVA" />&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/></p>
                </div>
                
                <div class="envio">
                    <p><xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/>:&nbsp;<xsl:value-of select="OFERTA/CT_OFE_PLAZOENVIO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='dias']/node()"/></p>
					<!--	18abr16 No mostramos el coste de envío
                    <p><xsl:value-of select="document($doc)/translation/texts/item[@name='coste_trasporte']/node()"/>:&nbsp;<xsl:value-of select="OFERTA/CT_OFE_COSTEENVIO"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/></p>
					-->
                </div>
                <!--	16abr16 Esta información no deben verla los clientes	-->
		<xsl:if test="/StockOferta/OFERTA/MVMB or /StockOferta/OFERTA/MVM or /StockOferta/OFERTA/ADMIN or /StockOferta/OFERTA/CDC">
                    <div class="lineaFinal">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='ref_vendedor']/node()"/>:&nbsp;<xsl:value-of select="OFERTA/CT_OFE_REFPROVEEDOR"/>&nbsp;&nbsp;
                        <xsl:value-of select="OFERTA/USUARIO"/>&nbsp;&nbsp;<xsl:value-of select="OFERTA/CT_OFE_FECHA"/>&nbsp;&nbsp;&nbsp;&nbsp;
                        [<xsl:value-of select="OFERTA/ESTADO"/>&nbsp;-&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='cod']/node()"/>.&nbsp;<xsl:value-of select="OFERTA/CT_OFE_CODIGO"/>]
                    </div>
                </xsl:if>

		<xsl:for-each select="/StockOferta/OFERTA/IMAGENES/IMAGEN">
                    <xsl:choose>
                        <xsl:when test="@id != '' and @num != '1'"><img src="http://www.newco.dev.br/Fotos/{@peq}" /></xsl:when>
                        <!--<xsl:otherwise><img src="http://www.newco.dev.br/images/noImageCVTpeq.jpg" alt="no image"/></xsl:otherwise>-->
                    </xsl:choose>
		</xsl:for-each>

                <xsl:if test="OFERTA/CT_OFE_IDESTADO = 'P'">
                    <!-- 29/04/2016 -->
                    <!--<xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente_revision']/node()"/>-->
                    <br></br>
                    <br></br>    
                    <p id="textPendRev"><xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente_revision']/node()"/></p>
                </xsl:if>
              
			   
                <xsl:if test="OFERTA/CT_OFE_IDESTADO = 'O'">  
                    <div class="botonFichaClubVip">
                    <!--segun lo que dice el artículo tienes que poner aquí tu mail y tu nombre
                    <form action="http://www.paypal.com/es/cgi-bin/webscr" method="post">
                        <input type="hidden" name="cmd" value="_xclick"/>
                        <input type="hidden" name="business" value="you@youremail.com"/>
                        <input type="hidden" name="item_name" value="Item Name"/>
                        <input type="hidden" name="currency_code" value="EUR"/>
                        <input type="hidden" name="amount" value="{OFERTA/CT_OFE_PRECIOLOTE}"/>
                        <input type="image" src="http://www.newco.dev.br/images/comprarPayPal.gif" name="submit" alt="Compra con PayPal - rápido, gratis y seguro!"/>
                        </form>
                                            -->

                                            <!--	Por ahora enviamos un pedido sin validar el pago	
                                            <form id="formPedido" name="formPedido">
                                                    <input type="hidden" name="STOCK_ID" id="STOCK_ID" value="{OFERTA/CT_OFE_ID}"/>
                                                    <input type="hidden" name="CODIGO_PEDIDO" id="CODIGO_PEDIDO" value=""/>
                                                    <input type="hidden" name="STOCK_CANTIDAD" id="STOCK_CANTIDAD" value=""/>
                                            </form>
                            <div class="boton" id="BotonPedido" style="margin-left:40px;">
                                            <a href="javascript:EnviarPedido(document.forms['formPedido']);">
                                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='comprar']/node()"/>
                                            </a>
                                            </div>
                                            -->


                                            <!--					
                                            El botón apunta para sus respuestas a:
                                            http://www.newco.dev.br/Gestion/Comercial/StockPedidoCancel.xsql
                                            http://www.newco.dev.br/Gestion/Comercial/StockPedidoSave.xsql


                                            <form action="http://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
                                            <input type="hidden" name="cmd" value="_s-xclick">
                                            <input type="hidden" name="hosted_button_id" value="9M7MZGKV8U4UY">
                                            <input type="image" src="http://www.paypalobjects.com/es_ES/ES/i/btn/btn_buynowCC_LG.gif" border="0" name="submit" alt="PayPal. La forma rápida y segura de pagar en Internet.">
                                            <img alt="" border="0" src="http://www.paypalobjects.com/es_ES/i/scr/pixel.gif" width="1" height="1">
                                            </form>

                                            -->					

                        <!--<form action="http://www.paypal.com/cgi-bin/webscr" method="post" target="_top"> abrimos Paypal en un pop-up-->
                        <form action="http://www.paypal.com/cgi-bin/webscr" method="post" target="_blank">
                            <!--<input type="hidden" name="cmd" value="_s-xclick"/>-->
                            <input type="hidden" name="cmd" value="_xclick"/>
                            <input type="hidden" name="business" value="etorrellas@tiendasenliquidacion.com"/>
                            <!--<input type="hidden" name="business" value="etorrellas-facilitator@tiendasenliquidacion.com"/>-->
                            <input type="hidden" name="item_name" value="Compra de stock {OFERTA/CT_OFE_ID}"/>
                            <input type="hidden" name="item_number" value="{OFERTA/SES_ID}|{OFERTA/CT_OFE_ID}"/>
                            <input type="hidden" name="currency_code" value="EUR"/>                    
                            <input type="hidden" name="tax" value="{OFERTA/LOTE_IMPORTEIVA_PP}"/>
                            <input type="hidden" name="amount" value="{OFERTA/CT_OFE_PRECIOLOTECONCOMISION_PP}"/>
                            <!-- para pruebas                    
                            <input type="hidden" name="tax" value="0.01"/>
                            <input type="hidden" name="amount" value="0.01"/>-->
                            <input type="hidden" name="hosted_button_id" value="9M7MZGKV8U4UY"/>
                            <!--<input type="hidden" name="return" value="http://www.newco.dev.br/Gestion/Comercial/StockOfertaPedidoPaypalSave.xsql"/>-->
                            <!--<input type="hidden" name="cancel_return" value="http://www.newco.dev.br/Gestion/Comercial/StockOfertaPedidoPaypalErrorSave.xsql"/>-->
                            <input type="image" src="http://www.newco.dev.br/images/comprarPayPal.gif" name="submit" alt="Compra con PayPal - rápido, gratis y seguro!"/>
                            <img alt="" border="0" src="http://www.paypalobjects.com/es_ES/i/scr/pixel.gif" width="1" height="1"/>
                        </form>

                    </div>
                    <!-- 10/05/2016 - Hay que añadir texto informativo, botón de Más información y más información para alternativa de pago distinta a PayPal -->
                    <div class="infoAlternativaPago">
                        <p>*Si no dispone de PayPal, tambien puede pagar por transferencia</p>
                        <div class="botonMasInfoPago" id="botonMasInfPag">Más información</div>
                    </div>
                    <!-- 11/05/2016 - Texto de más información -->
                    <div class="textoMasInfo">
                        <p>Si desea puede realizar el pago de su compra por transferencia bancaria:</p>
                        <br></br>
                        <p>Destinatario: ClubVipTiendas </p>
                        <p id="cuentaIBAN"></p>
                        <br></br>
                        <p>Una vez recibida la transferencia ClubVipTiendas le comunicará por correo electrónico que ha sido recibida y en el plazo de 48 horas recibirá su pedido.</p>    
                        <br></br>
                        <form class="confirmTransfer" action="http://www.newco.dev.br/Gestion/Comercial/StockOfertaPedidoSave.xsql" id="confirmTransfer" method="post">
                            <input type="hidden" name="OFERTA_STOCK" id="OFERTA_STOCK" value="{OFERTA/CT_OFE_ID}"/>
                            <label for="name">Confirmo que he realizado la transferencia: </label> 
                            <input id="INFO_COMPLEMENTARIA" name="INFO_COMPLEMENTARIA" type="text" placeholder="Indique código transferencia" required="true" />
                            <button id="boton_transfer" class="submit" type="submit">Enviar</button>
                        </form>
                    </div>
                </xsl:if>
					
            </div>
            
        </div>
        
     
</xsl:template>

<!--modifica de la oferta en club vip tiendas si es cdc o autor de oferta-->
<xsl:template name="modificaOfertaClubVipTiendas">
    
    <!--idioma-->                                              
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="//LANG"><xsl:value-of select="//LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
    <!--idioma fin-->
    
    <div class="divLeft15nopa">&nbsp;</div>
    <div class="divLeft70">
            
            <!--<table class="infoTable incidencias" cellspacing="5" cellpadding="5" style="border-bottom:2px solid #D7D8D7;">-->
            <table class="buscador">
                
				<form name="frmStockOfertaID" id="frmStockOfertaID" method="post">

				<!-- Solictud Catalogacion -->
				<input type="hidden" name="STOCK_ID" id="STOCK_ID" value="{OFERTA/CT_OFE_ID}"/>
				<input type="hidden" name="STOCK_ESTADO" id="STOCK_ESTADO" value="O"/>
				<input type="hidden" name="ESTADO" id="ESTADO"/><!--uso para finalizarla-->
				<input type="hidden" name="STOCK_ID_PROD" id="STOCK_ID_PROD" />
				<input type="hidden" name="TIPO_DOC_DB" id="TIPO_DOC_DB"/>
				<input type="hidden" name="TIPO_DOC_HTML" id="TIPO_DOC_HTML"/>
				<input type="hidden" name="CADENA_DOCUMENTOS"/>
				<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
				<input type="hidden" name="BORRAR_ANTERIORES"/>
				<input type="hidden" name="STOCK_FICHATECNICA" id="DOC_FICHAID" value="{OFERTA/CT_OFE_IDFICHATECNICA}"/>
				<input type="hidden" name="ID_USUARIO" value="{OFERTA/IDUSUARIO}"/>
				<input type="hidden" name="ID_EMPRESA" value="{OFERTA/IDEMPRESAUSUARIO}"/>
				<input type="hidden" name="STOCK_PEDIDOMINIMO" value="{OFERTA/PEDIDOMINIMO}"/>
				<input type="hidden" name="STOCK_ESTADO"/>
				<input type="hidden" name="STOCK_TIPO" id="STOCK_TIPO" value="{OFERTA/CT_OFE_IDTIPO}"/>
				<xsl:variable name="image">mvm|<xsl:value-of select="OFERTA/IMAGENES/IMAGEN[@num='1']/@peq"/>|<xsl:value-of select="OFERTA/IMAGENES/IMAGEN[@num='1']/@grande"/>#</xsl:variable>
				<!-- <xsl:value-of select="$image" />-->
				<input type="hidden" name="CADENA_IMAGENES">
    				<xsl:attribute name="value">
        				<xsl:if test="OFERTA/IMAGENES/IMAGEN[@peq !='']"><xsl:value-of select="$image"/></xsl:if>
    				</xsl:attribute>
				</input>
				<input type="hidden" name="IMAGENES_BORRADAS"/>

				<!--campos hidden mvm-->
				<input type="hidden" name="STOCK_FECHACADUCIDAD_PROD" id="SO_FECHACADUCIDAD_PROD" />
				<input type="hidden" name="STOCK_UDBASICA" id="SO_UDBASICA"/>
				<input type="hidden" name="STOCK_PRECIOUNITARIO" id="SO_PRECIOUNITARIO"/>
				<input type="hidden" name="STOCK_COMPRAMINIMA" id="SO_COMPRAMINIMA"/>   
				<input type="hidden" name="STOCK_PRODUCTO" id="SO_PRODUCTO"/>
				<input type="hidden" name="STOCK_FECHACADUCIDAD" id="SO_FECHACADUCIDAD"/>
				<input type="hidden" name="STOCK_CANTIDAD" id="SO_CANTIDAD"/>
				<input type="hidden" name="STOCK_UDLOTE" id="STOCK_UDLOTE"/>
				<input type="hidden" name="STOCK_PEDIDOMINIMO" id="STOCK_PEDIDOMINIMO"/>



				<!--dibujo de estado hay que rehacer para club vip tiendas
				<tr class="sinLinea">
    				<td>&nbsp;</td>
    				<td class="datosLeft">
        				<xsl:choose>
            				<xsl:when test="OFERTA/CT_OFE_IDESTADO = 'O'">
                				<xsl:choose>
                				<xsl:when test="LANG = 'spanish'">
                    				<img src="http://www.newco.dev.br/images/step3ofertas.gif" alt="Nueva" />
                				</xsl:when>
                				<xsl:otherwise>
                    				<img src="http://www.newco.dev.br/images/step3ofertas-BR.gif" alt="Novo" />
                				</xsl:otherwise>
                				</xsl:choose>
            				</xsl:when>
            				<xsl:otherwise>
                				<xsl:choose>
                				<xsl:when test="LANG = 'spanish'">
                    				<img src="http://www.newco.dev.br/images/step2ofertas.gif" alt="Publicar" />
                				</xsl:when>
                				<xsl:otherwise>
                    				<img src="http://www.newco.dev.br/images/step2ofertas-BR.gif" alt="Publicar" />
                				</xsl:otherwise>
                				</xsl:choose>
            				</xsl:otherwise>
        				</xsl:choose>
    				</td>    
				</tr>-->
				<xsl:if test="OFERTA/CT_OFE_IDESTADO = 'O'">
                                    <tr class="sinLinea">
                                        <td>&nbsp;</td>
                                        <td class="datosLeft">
                                            <p class="urgente">
                                                <xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_publicada_ya']/node()"/>
                                            </p>
                                        </td>
                                    </tr>
				</xsl:if>
				<tr class="sinLinea">
                                    <td>&nbsp;</td>
                                    <td style="text-transform:uppercase;text-align:left;background-color:#D3D3D3;padding-left:10px;">
                                        &nbsp;<strong>
                                        <xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_stock']/node()"/>
                                        <!--18/05/2016 Mostrar numero de veces que se ha visto un anuncio -->
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Visualizaciones:&nbsp;<xsl:value-of select="OFERTA/CT_OFE_VECESVISTO"/>
					<span style="float:right;padding-right:20px;">
                                            <xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;<xsl:value-of select="OFERTA/CT_OFE_FECHA"/>
					</span>
					</strong>
                                    </td>
				</tr>
                                
                                <input type="hidden" name="IDEMPRESA" id="IDEMPRESA" value="{OFERTA/IDEMPRESAUSUARIO}" />
                                <tr class="sinLinea">
                                    <td class="trenta labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:</td>
                                    <td class="datosLeft"><xsl:value-of select="OFERTA/USUARIO"/>&nbsp;-&nbsp;
                                        <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={OFERTA/CT_OFE_IDPROVEEDOR}','DetalleEmpresa',100,80,0,0);">
                                            <xsl:value-of select="OFERTA/PROVEEDOR"/>
                                        </a>
                                    </td>
				</tr>
                                <tr class="sinLinea">
                                    <td class="labelRight grisMed">
                                        <xsl:value-of select="document($doc)/translation/texts/item[@name='familia']/node()"/>:&nbsp;
					<span class="camposObligatorios">*</span>
                                    </td>
                                    <td class="datosLeft"><xsl:value-of select="OFERTA/CATEGORIA_PRODUCTO"/>
                                    <input type="hidden" name="STOCK_IDPRODESTANDAR" id="STOCK_IDPRODESTANDAR" value="{OFERTA/CT_OFE_IDPRODUCTOESTANDAR}"/>
						<!--	19abr16
                        <xsl:call-template name="desplegable">
                            <xsl:with-param name="path" select="OFERTA/LISTAFAMILIAS/field"/>
                            <xsl:with-param name="onChange">javascript:SeleccionaSubFamilia(this.value);</xsl:with-param>
                            <xsl:with-param name="claSel">select140</xsl:with-param>
                            <xsl:with-param name="nombre">STOCK_IDFAMILIA</xsl:with-param>
                            <xsl:with-param name="id">STOCK_IDFAMILIA</xsl:with-param>
                        </xsl:call-template>-->
                                    </td>
                                </tr>
					<!--
							<tr style="display:none;" id="desplSubFamilia">
							<td class="labelRight grisMed">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='subfamilia']/node()"/>:&nbsp;
							<span class="camposObligatorios">*</span>
							</td>
							<td class="datosLeft">
							<select name="STOCK_IDSUBFAMILIA" id="STOCK_IDSUBFAMILIA" class="select140 catalogo">
    							<xsl:if test="Buscador/BUSCADOR/LISTACATEGORIAS">
        							<xsl:attribute name="onchange">javascript:SeleccionaGrupo(this.value);</xsl:attribute>
    							</xsl:if>
							</select>
							</td>
					</tr>
					-->
                                <tr class="sinLinea">
                                    <td class="labelRight grisMed">
                                        <xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>:&nbsp;
					<span class="camposObligatorios">*</span>
                                    </td>
                                    <td class="datosLeft">
                                        <xsl:call-template name="desplegable">
                                            <xsl:with-param name="path" select="OFERTA/MARCA/field"/>
                                            <xsl:with-param name="claSel">select140</xsl:with-param>
                                            <xsl:with-param name="nombre">STOCK_IDMARCA</xsl:with-param>
                                            <xsl:with-param name="defecto"><xsl:value-of select="CT_OFE_IDMARCA" /></xsl:with-param>
                                            <xsl:with-param name="id">STOCK_IDMARCA</xsl:with-param>
                                        </xsl:call-template>
                                    </td>
				</tr>
                               
				<tr class="sinLinea">
                                    <td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>:</td>
                                    <td class="datosLeft">
                                        <input type="text" class="peq" name="STOCK_TITULO" id="STOCK_TITULO" value="{OFERTA/CT_OFE_TITULO}" size="62" maxlenght="100" />
                                    </td>
				</tr>
                                
                                <tr class="sinLinea">
                                    <td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_vendedor']/node()"/>:</td>
                                    <td class="datosLeft">
                                        <input type="text" class="peq" name="STOCK_REF_CLIENTE" id="STOCK_REF_CLIENTE" value="{OFERTA/CT_OFE_REFPROVEEDOR}"/>
                                    </td>
				</tr>
				<tr class="sinLinea">
                                    <td class="diecisiete labelRight grisMed">
                                        <xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>:&nbsp;
                                        <span class="camposObligatorios">*</span>
                                    </td>
                                    <td class="cinquenta datosLeft">
        				<textarea type="text" name="STOCK_DESCRIPCION" id="STOCK_DESCRIPCION" row="3" cols="62">
                                            <xsl:copy-of select="OFERTA/CT_OFE_DESCRIPCION/node()" />
        				</textarea>
        				<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_explicacion_stck_ofe']/node()"/>
                                    </td>
				</tr>
    				<tr class="noObliSeg sinLinea">
                                    <td class="labelRight grisMed">
                                        <xsl:value-of select="document($doc)/translation/texts/item[@name='precio_lote']/node()"/>:&nbsp;
                                        <span class="camposObligatorios">*</span>
                                    </td>
                                    <td class="datosLeft"><input type="text" class="peq" name="STOCK_PRECIOLOTE" id="STOCK_PRECIOLOTE" value="{OFERTA/CT_OFE_PRECIOLOTE_SINFORMATO}" maxlength="10" size="8"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/></td>
				</tr>
				<tr class="noObliSeg sinLinea">
                                    <td class="labelRight grisMed">
                                        <xsl:value-of select="document($doc)/translation/texts/item[@name='precio_retail_lote']/node()"/>:&nbsp;
					<span class="camposObligatorios">*</span>
                                    </td>
                                    <td class="datosLeft"><input type="text" class="peq" name="STOCK_PRECIOPUBLICOLOTE" id="STOCK_PRECIOPUBLICOLOTE" value="{OFERTA/CT_OFE_PRECIOPUBLICOLOTE_SINFORMATO}" maxlength="10" size="8"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/></td>
                                </tr>
                                <!--iva-->
                                <xsl:choose>
                                    <xsl:when test="/StockOferta/LANG = 'spanish'">
                                        <tr class="sinLinea">
                                            <td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/>:&nbsp;
                                                <span class="camposObligatorios">*</span>
                                            </td>
                                            <td class="datosLeft">
                                                <xsl:call-template name="desplegable">
                                                    <xsl:with-param name="path" select="OFERTA/TIPOSIVA/field"/>
                                                    <xsl:with-param name="nombre">STOCK_IVA</xsl:with-param>
                                                    <xsl:with-param name="defecto"><xsl:value-of select="@current" /></xsl:with-param>
                                                    <xsl:with-param name="id">STOCK_IVA</xsl:with-param>
                                                </xsl:call-template>
                                            </td>
                                        </tr>
                                    </xsl:when>
                                <xsl:otherwise>
                                    <input type="hidden" name="STOCK_IVA" id="STOCK_IVA" value="0" />
                                </xsl:otherwise>
                            </xsl:choose>
                               
                            <tr class="sinLinea">
                                <td class="labelRight grisMed">
                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_entrega']/node()"/>:
                                    <span class="camposObligatorios">*</span>
				</td>
				<td class="datosLeft"><input type="text" class="peq" name="STOCK_PLAZOENVIO" id="STOCK_PLAZOENVIO" value="{OFERTA/CT_OFE_PLAZOENVIO}" maxlength="10" size="8"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='dias']/node()"/>
				</td>
                            </tr>
					<!--	20abr16	Quitamos el coste de transporte
                     <tr class="sinLinea">
						<td class="labelRight grisMed">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='coste_trasporte']/node()"/>:
							<span class="camposObligatorios">*</span>
						</td>
						<td class="datosLeft">
                        <input type="text" name="STOCK_COSTEENVIO" id="STOCK_COSTEENVIO" value="{OFERTA/CT_OFE_COSTEENVIO}" maxlength="10" size="8"/>&nbsp;
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>
						</td>
					</tr>-->
                            <input type="hidden" name="STOCK_COSTEENVIO" id="STOCK_COSTEENVIO" value="{OFERTA/CT_OFE_COSTEENVIO}"/>
                            <!--si no hay ficha tecnica puedo añadir-->
                            <xsl:choose>
                                <xsl:when test="OFERTA/FT">
                                    <!--<tr class="contenidoCVT" id="contenidoCVT">-->
                                    <tr class="sinLinea" id="contenidoCVT">
                                        <td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='lista_de_contenido']/node()"/>:</td>
					<td class="datosLeft">
                                            <a href="http://www.newco.dev.br/Documentos/{OFERTA/FT/URL}" target="_blank">
                                                <xsl:value-of select="OFERTA/FT/NOMBRE" />
                                            </a>&nbsp;
                                            <a href="http://www.newco.dev.br/Documentos/{OFERTA/FT/URL}" target="_blank">
                                            </a>
					</td>
                                    </tr>
                                    <tr class="sinLinea">
					<td class="labelRight grisMed"><span class="contenidoCVT"><xsl:value-of select="document($doc)/translation/texts/item[@name='substituir']/node()"/>&nbsp;</span><xsl:value-of select="document($doc)/translation/texts/item[@name='lista_de_contenido']/node()"/>:</td>
					<td class="datosLeft" colspan="2">
                                            <a class="botonPeque" id="modelo" href="http://www.newco.dev.br/images/CVT_ModeloInformativoLote.xlsx" title="Modelo Informativo Lote" style="text-decoration:none;">
                                                <xsl:value-of select="document($doc)/translation/texts/item[@name='descargar_modelo']/node()"/>
                                            </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <span id="newDocFICHAID" align="center">
                                                <a href="javascript:verCargaDoc('FICHAID');" class="botonPeque" title="Subir ficha técnica" style="text-decoration:none;">
                                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='subir_documento']/node()"/>
                                                </a>
                                            </span>
                                            <span id="docBoxFICHAID" style="display:none;" align="center"></span>&nbsp;
                                            <span id="borraDocFICHAID" style="display:none;" align="center"></span>
					</td>
                                    </tr>
                                    <tr id="cargaFICHAID" class="cargas" style="display:none;">
					<td colspan="3"><xsl:call-template name="CargaDocumentos"><xsl:with-param name="tipo">FICHAID</xsl:with-param></xsl:call-template></td>
                                    </tr>
                                </xsl:when>
                            <xsl:otherwise>
                                <tr class="sinLinea">
                                    <td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='lista_de_contenido']/node()"/>:</td>
                                    <td class="datosLeft" colspan="2">
                                        <a class="botonPeque" id="modelo" href="http://www.newco.dev.br/images/CVT_ModeloInformativoLote.xlsx" title="Modelo Informativo Lote" style="text-decoration:none;">
                                            <xsl:value-of select="document($doc)/translation/texts/item[@name='descargar_modelo']/node()"/>
                                        </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <span id="newDocFICHAID" align="center">
                                            <a href="javascript:verCargaDoc('FICHAID');" class="botonPeque" title="Subir ficha técnica" style="text-decoration:none;">
                                                <xsl:value-of select="document($doc)/translation/texts/item[@name='subir_documento']/node()"/>
                                            </a>
                                        </span>
                                        <span id="docBoxFICHAID" style="display:none;" align="center"></span>&nbsp;
                                        <span id="borraDocFICHAID" style="display:none;" align="center"></span>
                                    </td>
				</tr>
				<tr id="cargaFICHAID" class="cargas" style="display:none;">
                                    <td colspan="3"><xsl:call-template name="CargaDocumentos"><xsl:with-param name="tipo">FICHAID</xsl:with-param></xsl:call-template></td>
				</tr>
                            </xsl:otherwise>
                        </xsl:choose>

                        <tr class="sinLinea">
                            <td class="labelRight grisMed" valign="top">
                                <xsl:value-of select="document($doc)/translation/texts/item[@name='imagen']/node()"/>:
                            </td>
                            <td class="datosLeft">
                                <p><xsl:copy-of select="document($doc)/translation/texts/item[@name='formato_imagenes']/node()"/></p>
                                <p>&nbsp;</p>
                                <span class="anadirImage">
                                    <xsl:variable name="ima" select="count(OFERTA/IMAGENES/IMAGEN)"/>
                                    <xsl:choose>
                                        <xsl:when test="$ima >= '1'">
                                            <xsl:for-each select="OFERTA/IMAGENES/IMAGEN">
                                                <xsl:call-template name="imageMan"><xsl:with-param name="num" select="@num" /></xsl:call-template>
                                            </xsl:for-each>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:call-template name="image"><xsl:with-param name="num" select="number(1)" /></xsl:call-template>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </span>
                                <div id="waitBox">&nbsp;</div>
                            </td>
                        </tr>
                        <tr class="sinLinea">
                            <td colspan="2">&nbsp;</td>
			</tr>
                        <!--29/04/2016 - No hace falta que muestre las imágenes otravez -->
                        <!--<tr class="sinLinea">
                            <td colspan="2">				
                                <xsl:for-each select="/StockOferta/OFERTA/IMAGENES/IMAGEN">
                                    <xsl:choose>
                                        <xsl:when test="@id != ''"><img src="http://www.newco.dev.br/Fotos/{@peq}" /></xsl:when>
                                        <xsl:otherwise><img src="http://www.newco.dev.br/images/noImageCVTpeq.jpg" alt="no image"/></xsl:otherwise>
                                    </xsl:choose>
				</xsl:for-each>
                            </td>
			</tr>-->
                    <!--<tr class="sinLinea">
                        <td colspan="2">&nbsp;</td>
                    </tr>-->
                    </form>	<!-- Fin del form de mantenimiento, aqui vendra el form de Paypal 	-->
                    
                    <tr class="sinLinea">
                        <td class="labelRight"></td>
			<td class="datosLeft">
                            <xsl:choose>
                                <xsl:when test="OFERTA/CT_OFE_IDESTADO = 'O'">
                                    <xsl:if test="OFERTA/MVM or OFERTA/MVMB or OFERTA/CDC">
                                        <!--<div class="boton" id="BotonSubmitID">-->
                                            <a class="btnDestacado" id="BotonSubmitID" href="javascript:ValidarFormularioCdC(document.forms['frmStockOfertaID'],'OFERTA','CVT');">
                                                <xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar']/node()"/>
                                            </a>
                                        <!--</div>-->
                                        <br></br>
                                        <br></br>
                                        <br></br>
                            <!--
                            <div class="boton" id="BotonPedido" style="margin-left:40px;">
                                <a href="javascript:FinalizarOferta(document.forms['frmStockOfertaID'],'F','CVT');">
                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='finalizar']/node()"/>
                                </a>
                            </div>
                            -->
                                
                            <!--	Botón de Paypal para el responsable que también debe poder comprar-->
                            <form action="http://www.paypal.com/cgi-bin/webscr" method="post" target="_blank">
								<input type="hidden" name="cmd" value="_xclick"/>
								<input type="hidden" name="business" value="etorrellas@tiendasenliquidacion.com"/>
								<input type="hidden" name="item_name" value="Compra de stock {OFERTA/CT_OFE_ID}"/>
								<input type="hidden" name="item_number" value="{OFERTA/SES_ID}|{OFERTA/CT_OFE_ID}"/>
								<input type="hidden" name="currency_code" value="EUR"/>
								<input type="hidden" name="tax" value="{OFERTA/LOTE_IMPORTEIVA_PP}"/>
								<input type="hidden" name="amount" value="{OFERTA/CT_OFE_PRECIOLOTECONCOMISION_PP}"/>
								<input type="hidden" name="hosted_button_id" value="9M7MZGKV8U4UY"/>
								<input type="image" src="http://www.newco.dev.br/images/comprarPayPal.gif" name="submit" alt="Compra con PayPal - rápido, gratis y seguro!"/>
								<img alt="" border="0" src="http://www.paypalobjects.com/es_ES/i/scr/pixel.gif" width="1" height="1"/>
                            </form>
                                        
                                    </xsl:if>
                                </xsl:when>
                        <xsl:otherwise>
                            <!--<div class="boton" id="BotonSubmitID">-->
                                <a class="btnDestacado" id="BotonSubmitID" href="javascript:ValidarFormularioCdC(document.forms['frmStockOfertaID'],'OFERTA','CVT');">
                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='publicar']/node()"/>
                                </a>
                            <!--</div>-->
                        </xsl:otherwise>
                    </xsl:choose>
                    <!-- 29/04/2016 - Está duplicado no hace falta -->
                    <!--<tr class="sinLinea">
                        <td colspan="2">				
                            <xsl:for-each select="/StockOferta/OFERTA/IMAGENES/IMAGEN">
				<xsl:choose>
                                    <xsl:when test="@id != ''"><img src="http://www.newco.dev.br/Fotos/{@peq}" /></xsl:when>
                                    <xsl:otherwise><img src="http://www.newco.dev.br/images/noImageCVTpeq.jpg" alt="no image"/></xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </td>
                    </tr>-->
                </td>
                <td class="datosLeft">&nbsp;</td>
            </tr>
        <!--</form>    -->
        <tr class="sinLinea">
            <td colspan="2">&nbsp;</td>
	</tr>
                                
                    <tr class="sinLinea">
                        <td colspan="2">
                            <xsl:if test="OFERTA/PEDIDOS/PEDIDO and (OFERTA/MVM or OFERTA/MVMB)">

                                <table class="grandeInicio" style="width:70%; margin-left:15%;border:2px solid #D7D8D7; border-top:0;">
                                    <thead>
                                    <tr class="subTituloTabla" style="border-top:none;">
                                        <th><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/></th>
                                        <th><xsl:value-of select="document($doc)/translation/texts/item[@name='enviado']/node()"/></th>
                                        <th><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
                                        <th><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <xsl:for-each select="OFERTA/PEDIDOS/PEDIDO">
                                        <tr class="sinLinea">
                                            <td><xsl:value-of select="CT_PED_CODIGO" /></td>
                                            <td><xsl:value-of select="CT_PED_FECHA" /></td>
                                            <td><xsl:value-of select="CT_PED_CANTIDAD" /></td>
                                            <td><xsl:value-of select="CENTRO" /></td>
                                        </tr>
                                    </xsl:for-each>  
                                    </tbody>                              
                                </table>
                            </xsl:if>

                        </td>
                    </tr>
                                
			</table>
                          
        <br /><br />
    </div>
    
</xsl:template>



<!--nueva Oferta MVM-->
<xsl:template name="nuevaOferta">
    
    <!--idioma-->                                              
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="//LANG"><xsl:value-of select="//LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
    <!--oferta stock -->
		<tr class="sinLinea">
			<td class="diecisiete labelRight grisMed">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>:&nbsp;
				<span class="camposObligatorios">*</span>
			</td>
			<td class="cinquenta datosLeft"><input type="text" name="SO_TITULO" id="SO_TITULO" maxlength="200" size="62"/>&nbsp;
            <xsl:value-of select="document($doc)/translation/texts/item[@name='titulo_explicacion_stck_ofe']/node()"/>
            </td>
		</tr>
                             <tr class="sinLinea">
			<td class="labelRight grisMed">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/>:
				<span class="camposObligatorios">*</span>
			</td>
			<td class="datosLeft">
            	<input type="radio" class="muypeq" name="SO_TIPO_RADIO" id="SO_TIPO_VACIO" value="" checked="checked" style="display:none;"></input>
            	<input type="radio" class="muypeq" name="SO_TIPO_RADIO" id="SO_TIPO_LIQ" value="LIQ" onchange="checkTipo('NORMAL');"></input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='liquidaciones_stock']/node()"/>&nbsp;&nbsp;
            	<input type="radio" class="muypeq" name="SO_TIPO_RADIO" id="SO_PM_SEG" value="SEG" onchange="checkTipo('NORMAL');"></input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='segunda_mano']/node()"/>&nbsp;&nbsp;
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight grisMed">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/>:&nbsp;
				<span class="camposObligatorios">*</span>
			</td>
			<td class="datosLeft">
                <input type="text" class="peq" name="SO_REFCLIENTE" id="SO_REFCLIENTE" maxlength="20" size="15"/>&nbsp;
			</td>
		</tr>

		<tr class="sinLinea">
			<td class="labelRight grisMed">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:&nbsp;
				<span class="camposObligatorios">*</span>
			</td>
			<td class="datosLeft"><input type="text" name="SO_PRODUCTO" id="SO_PRODUCTO" maxlength="300" size="62"/>&nbsp;
                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='producto_explicacion_stck_dem']/node()"/>
                                    </td>
		</tr>
        <!--idempresa para desplegar selects-->
        <input type="hidden" name="IDEMPRESA" id="IDEMPRESA" value="{NUEVAOFERTA/USUARIO/EMP_ID}" />&nbsp;
        <!--si es mvm enseño las categoria-->
            <tr class="sinLinea">
			<td class="labelRight grisMed">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='categoria']/node()"/>:&nbsp;
				<span class="camposObligatorios">*</span>
			</td>
			<td class="datosLeft">
                <xsl:call-template name="desplegable">
                    <xsl:with-param name="path" select="NUEVAOFERTA/LISTACATEGORIAS/field"/>
                    <xsl:with-param name="onChange">javascript:SeleccionaFamilia(this.value);</xsl:with-param>
                    <xsl:with-param name="claSel">select140 catalogo</xsl:with-param>
                    <xsl:with-param name="nombre">IDCATEGORIA</xsl:with-param>
                    <xsl:with-param name="id">IDCATEGORIA</xsl:with-param>
                </xsl:call-template>
                </td>
            </tr>
            <tr class="sinLinea">
                    <td class="labelRight grisMed">
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='familia']/node()"/>:&nbsp;
                            <span class="camposObligatorios">*</span>
                    </td>
                    <td class="datosLeft">
                        <select name="IDFAMILIA" id="IDFAMILIA" class="select140 catalogo" onchange="javascript:SeleccionaSubFamilia(this.value);"/>
                    </td>
            </tr>
            <tr class="sinLinea">
                    <td class="labelRight grisMed">
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='subfamilia']/node()"/>:&nbsp;
                            <span class="camposObligatorios">*</span>
                    </td>
                    <td class="datosLeft">
                        <select name="IDSUBFAMILIA" id="IDSUBFAMILIA" class="select140 catalogo">
                            <xsl:if test="Buscador/BUSCADOR/LISTACATEGORIAS">
                                <xsl:attribute name="onchange">javascript:SeleccionaGrupo(this.value);</xsl:attribute>
                            </xsl:if>
                        </select>
                    </td>
            </tr>

        <tr class="sinLinea">
			<td class="labelRight grisMed">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_caducidad_producto']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<span style="float:left;">
					<script type="text/javascript">
						calFechaCaducidadProducto.dateFormat="dd/MM/yyyy";
						calFechaCaducidadProducto.labelCalendario='<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_caducidad_producto']/node()"/>';
						calFechaCaducidadProducto.minDate=new Date(new Date().setDate(new Date().getDate()+1));
						calFechaCaducidadProducto.writeControl();
					</script>
				</span>
				<span style="float:left;margin-top:8px;">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='formato_fecha2']/node()"/></span>
			</td>
		</tr>
        <tr class="noObliSeg sinLinea">
			<td class="labelRight grisMed">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>:&nbsp;
				<span class="camposObligatorios">*</span>
			</td>
			<td class="datosLeft"><input type="text" class="peq" name="SO_UDBASICA" id="SO_UDBASICA" maxlength="30" size="15"/></td>
		</tr>
         <tr class="noObliSeg sinLinea">
            <td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_lote']/node()"/>:&nbsp;
            <span class="camposObligatorios">*</span>
            </td>
            <td class="datosLeft"><input name="SO_UDLOTE" class="peq" id="SO_UDLOTE" maxlength="10" size="8" type="text"/>
            </td>
         </tr>
		<tr class="sinLinea">
			<td class="labelRight grisMed">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_unitario']/node()"/>:&nbsp;
				<span class="camposObligatorios">*</span>
			</td>
			<td class="datosLeft"><input type="text" class="peq" name="SO_PRECIOUNITARIO" id="SO_PRECIOUNITARIO" maxlength="10" size="8"/>
                                    &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='euro']/node()"/>&nbsp;
                                    (<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_unitario_expli']/node()"/>)
                                    </td>
		</tr>
                            <tr class="sinLinea">
			<td class="labelRight grisMed">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_unitario_venta']/node()"/>:&nbsp;
				<span class="camposObligatorios">*</span>
			</td>
			<td class="datosLeft"><input type="text" class="peq" name="SO_PRECIOPUBLICO" id="SO_PRECIOPUBLICO" maxlength="10" size="8"/>
                                    &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='euro']/node()"/>&nbsp;
                                    (<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_unitario_venta_expli']/node()"/>)
                                    </td>
		</tr>
            <!--ahorro-->
            <tr class="sinLinea">
			<td class="labelRight grisMed">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/>:&nbsp;
				<span class="camposObligatorios">*</span>
			</td>
			<td class="datosLeft"><input type="text" class="peq" name="SO_AHORRO" id="SO_AHORRO" maxlength="10" size="8"/>
            &nbsp;%
            </td>
		</tr>

        <xsl:choose>
            <xsl:when test="/StockOferta/LANG = 'spanish'">
            <tr class="sinLinea">
                <td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/>:&nbsp;
					<span class="camposObligatorios">*</span>
                </td>
                <td class="datosLeft">
                    <select name="SO_IVA" id="SO_IVA">
                        <option value="0">0%</option>
                        <option value="3">3%</option>
                        <option value="4">4%</option>
                        <option value="10">10%</option>
                        <option value="21" selected="selected">21%</option>
                    </select>
                </td>
            </tr>
            </xsl:when>
            <xsl:otherwise>
                 <input type="hidden" name="SO_IVA" id="SO_IVA" value="0" />
            </xsl:otherwise>
        </xsl:choose>
        <tr class="noObliSeg sinLinea">
			<td class="labelRight grisMed">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='compra_minima']/node()"/>:
				<span class="camposObligatorios">*</span>
			</td>
			<td class="datosLeft" colspan="2"><input type="text" class="peq" name="SO_COMPRAMINIMA" id="SO_COMPRAMINIMA" maxlength="10" size="8"/>&nbsp;
				(<xsl:value-of select="document($doc)/translation/texts/item[@name='compra_minima_expli']/node()"/>)
			</td>
		</tr>
        <tr class="sinLinea">
			<td class="labelRight grisMed">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_stock']/node()"/>:
				<span class="camposObligatorios">*</span>
			</td>
			<td class="datosLeft"><input type="text" class="peq" name="SO_CANTIDAD" id="SO_CANTIDAD" maxlength="10" size="8"/>&nbsp;
                                    (<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_expli']/node()"/>)
			</td>
		</tr>
        <tr class="noObliSeg sinLinea">
			<td class="labelRight grisMed">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/>:
				<span class="camposObligatorios">*</span>
			</td>
			<td class="datosLeft">
                <input type="radio" class="muypeq" name="SO_PEDIDOMINIMO_RADIO" id="SO_PM_SIN" value="" checked="checked" style="display:none;"></input>
                <input type="radio" class="muypeq" name="SO_PEDIDOMINIMO_RADIO" id="SO_PM_SIN" value="0" onchange="verPedidoMinimo();"></input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='sin_pedido_minimo']/node()"/>&nbsp;&nbsp;
                <input type="radio" class="muypeq" name="SO_PEDIDOMINIMO_RADIO" id="SO_PM_DEFECTO" value="-1" onchange="verPedidoMinimo();"></input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo_defecto']/node()"/>&nbsp;&nbsp;
                <input type="radio" class="muypeq" name="SO_PEDIDOMINIMO_RADIO" id="SO_PM_INFORMAR" value="I" onchange="verPedidoMinimo();"></input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='informar_pedido_minimo']/node()"/>&nbsp;&nbsp;
                <span class="pedidoMinimoValue" style="display:none;">
                    <input type="text" class="peq" name="SO_PEDIDOMINIMO_VALUE" id="SO_PEDIDOMINIMO_VALUE" maxlength="8" size="5"/>&nbsp;
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>
                </span>
			</td>
		</tr>
		<tr class="sinLinea">
			<td class="labelRight grisMed">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_caducidad']/node()"/>:&nbsp;
			</td>
			<td class="datosLeft">
				<span style="float:left;">
					<script type="text/javascript">
						calFechaCaducidad.dateFormat="dd/MM/yyyy";
						calFechaCaducidad.labelCalendario='<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_caducidad']/node()"/>';
						calFechaCaducidad.minDate=new Date(new Date().setDate(new Date().getDate()+1));
						calFechaCaducidad.writeControl();
					</script>
				</span>
				<span style="float:left;margin-top:8px;">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='formato_fecha2']/node()"/></span>
			</td>
		</tr>


		<tr class="sinLinea">
			<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='ficha_tecnica']/node()"/>:</td>
			<td class="datosLeft" colspan="2">
				<span id="newDocFICHA" align="center">
					<a href="javascript:verCargaDoc('FICHA');" title="Subir ficha técnica" style="text-decoration:none;">
						<img src="http://www.newco.dev.br/images/subirDocumento.gif" alt="Subir ficha técnica"/>
					</a>
				</span>&nbsp;
				<span id="docBoxFICHA" style="display:none;" align="center"></span>&nbsp;
				<span id="borraDocFICHA" style="display:none;" align="center"></span>
			</td>
		</tr>
                            <tr id="cargaFICHA" class="cargas" style="display:none;">
			<td colspan="3"><xsl:call-template name="CargaDocumentos"><xsl:with-param name="tipo">FICHA</xsl:with-param></xsl:call-template></td>
		</tr>
                             <tr class="sinLinea">
                                <td class="labelRight grisMed">
                                        <xsl:value-of select="document($doc)/translation/texts/item[@name='imagen']/node()"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:
                                </td>
                                <td class="datosLeft" colspan="2">
                                    <xsl:call-template name="image"><xsl:with-param name="num">1</xsl:with-param></xsl:call-template>
                                        &nbsp;<span class="font11"><xsl:copy-of select="document($doc)/translation/texts/item[@name='formato_imagenes']/node()"/></span>
                                    <div id="waitBox">&nbsp;</div>
                                </td>
                            </tr>
                            <tr class="sinLinea"> 
                                <td colspan="2">&nbsp;</td>
                            </tr>
		<tr class="sinLinea">
			<td class="labelRight"></td>
			<td class="datosLeft">
				<!--<div class="boton" id="BotonSubmit">-->
					<a class="btnDestacado" id="BotonSubmit" href="javascript:ValidarFormulario(document.forms['frmStockOferta'],'NUEVA','MVM');">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/>
					</a>
				<!--</div>-->
			</td>

		</tr>
</xsl:template>


<xsl:template name="oferta">
    
     <!--idioma-->                                              
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="//LANG"><xsl:value-of select="//LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
      
      <h1 class="titlePage" style="float:left;width:70%;padding-left:10%;padding-bottom:5px;">
             <xsl:choose>
                    <xsl:when test="GUARDAR = 'S'">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_stock_guardada_exito']/node()"/>
                    </xsl:when>
                    <xsl:otherwise>
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_stock']/node()"/>
                    </xsl:otherwise>
		</xsl:choose>&nbsp;
                <xsl:value-of select="OFERTA/CT_OFE_CODIGO"/>:&nbsp; 
            <xsl:value-of select="OFERTA/CT_OFE_TITULO"/> 
        </h1>
        <h1 class="titlePage" style="float:left;width:20%;padding-bottom:5px;">
				<xsl:if test="/StockOferta/OFERTA/MVMB or /StockOferta/OFERTA/MVM or /StockOferta/OFERTA/ADMIN"><span style="float:right; padding:5px; font-weight:bold;" class="amarillo">OFE_ID: <xsl:value-of select="/StockOferta/OFERTA/CT_OFE_ID"/></span></xsl:if>
        </h1>
    <div class="divLeft20">&nbsp;</div>
    <div class="divLeft60nopa">
    
      <!--<table class="infoTable incidencias" cellspacing="5" cellpadding="5" style="border-bottom:2px solid #D7D8D7;">-->
      <table class="buscador">

				<tr class="sinLinea">
                    <td>&nbsp;</td>
                    <td class="datosLeft">
                        <xsl:choose>
                        <xsl:when test="LANG = 'spanish'">
                            <xsl:choose>
                            <xsl:when test="OFERTA/CT_OFE_IDESTADO = 'F'">
                                <img src="http://www.newco.dev.br/images/step4ofertas.gif" alt="Oferta stock finalizada" />
                            </xsl:when>
                            <xsl:when test="OFERTA/CT_OFE_CANTIDAD = '0' and (OFERTA/MVM or OFERTA/MVM or OFERTA/ROL ='COMPRADOR')">
                                <img src="http://www.newco.dev.br/images/step4ofertas.gif" alt="Oferta stock finalizada" />
                            </xsl:when>
                            <xsl:when test="OFERTA/CT_OFE_CANTIDAD != '0' and not(/StockOferta/NUEVOPEDIDO) and ((OFERTA/CT_OFE_IDESTADO = 'O' and (OFERTA/MVM or OFERTA/MVM)) or (OFERTA/CT_OFE_IDESTADO = 'O' and OFERTA/ROL ='COMPRADOR' and OFERTA/CDC))">
                                <img src="http://www.newco.dev.br/images/step3ofertas.gif" alt="Pedidos oferta stock" />
                            </xsl:when>
                            <xsl:when test="(OFERTA/CT_OFE_CANTIDAD != '0' and OFERTA/CT_OFE_CANTIDADPEDIDA != '') or ((OFERTA/CT_OFE_IDESTADO = 'O' and (OFERTA/MVM or OFERTA/MVM)) or (OFERTA/CT_OFE_IDESTADO = 'O' and OFERTA/ROL ='COMPRADOR'))">
                                <img src="http://www.newco.dev.br/images/step3ofertas.gif" alt="Pedidos oferta stock" />
                            </xsl:when>
                            <xsl:otherwise><img src="http://www.newco.dev.br/images/step2ofertas.gif" alt="Publicar oferta stock" /></xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:choose>
                            <xsl:when test="OFERTA/CT_OFE_IDESTADO = 'F'">
                                <img src="http://www.newco.dev.br/images/step4ofertas-BR.gif" alt="Terminado" />
                            </xsl:when>
                            <xsl:when test="OFERTA/CT_OFE_CANTIDAD = '0' and (OFERTA/MVM or OFERTA/MVM or OFERTA/ROL ='COMPRADOR')">
                                <img src="http://www.newco.dev.br/images/step4ofertas-BR.gif" alt="Terminado" />
                            </xsl:when>
                            <xsl:when test="OFERTA/CT_OFE_CANTIDAD != '0' and not(/StockOferta/NUEVOPEDIDO) and ((OFERTA/CT_OFE_IDESTADO = 'O' and (OFERTA/MVM or OFERTA/MVM)) or (OFERTA/CT_OFE_IDESTADO = 'O' and OFERTA/ROL ='COMPRADOR' and OFERTA/CDC))">
                                <img src="http://www.newco.dev.br/images/step3ofertas-BR.gif" alt="Pedidos" />
                            </xsl:when>
                            <xsl:when test="(OFERTA/CT_OFE_CANTIDAD != '0' and OFERTA/CT_OFE_CANTIDADPEDIDA != '') or ((OFERTA/CT_OFE_IDESTADO = 'O' and (OFERTA/MVM or OFERTA/MVM)) or (OFERTA/CT_OFE_IDESTADO = 'O' and OFERTA/ROL ='COMPRADOR'))">
                                <img src="http://www.newco.dev.br/images/step3ofertas-BR.gif" alt="Pedidos" />
                            </xsl:when>
                            <xsl:otherwise><img src="http://www.newco.dev.br/images/step2ofertas-BR.gif" alt="Publicar" /></xsl:otherwise>
                            </xsl:choose>
                        </xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
				<!-- oferta stock -->
				<tr class="sinLinea">
					<td>&nbsp;</td>
					<td style="text-transform:uppercase;text-align:left;background-color:#D3D3D3;padding-left:10px;">
						<strong>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_stock']/node()"/>
							<span style="float:right;padding-right:30px;">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;<xsl:value-of select="OFERTA/CT_OFE_FECHA"/>
							</span>
						</strong>
                                        </td>
				</tr>
                                <tr class="sinLinea">
					<td class="trenta labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:</td>
					<td class="datosLeft"><xsl:value-of select="OFERTA/USUARIO"/>&nbsp;-&nbsp;<xsl:value-of select="OFERTA/PROVEEDOR"/></td>
				</tr>
                                 <tr class="sinLinea">
						<td class="labelRight grisMed">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/>:
						</td>
						<td class="datosLeft">
                                                    <xsl:choose>
                                                        <xsl:when test="OFERTA/CT_OFE_IDTIPO = 'SEG'"><xsl:value-of select="document($doc)/translation/texts/item[@name='segunda_mano']/node()"/></xsl:when>
                                                        <xsl:when test="OFERTA/CT_OFE_IDTIPO = 'LIQ'"><xsl:value-of select="document($doc)/translation/texts/item[@name='liquidaciones_stock']/node()"/></xsl:when>
                                                    </xsl:choose>
						</td>
					</tr>
				<tr class="sinLinea">
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/>:</td>
					<td class="datosLeft"><xsl:value-of select="OFERTA/CT_OFE_REFPROVEEDOR" disable-output-escaping="yes"/></td>
				</tr>
				<tr class="sinLinea">
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:</td>
					<td class="datosLeft"><xsl:value-of select="OFERTA/CT_OFE_PRODUCTO" disable-output-escaping="yes"/></td>
                                </tr>
                                <tr class="sinLinea">
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_caducidad_producto']/node()"/>:</td>
					<td class="datosLeft">
                                             <xsl:choose>
                                                <xsl:when test="OFERTA/CT_OFE_FECHACADPRODUCTO != ''">
                                                    <xsl:value-of select="OFERTA/CT_OFE_FECHACADPRODUCTO" disable-output-escaping="yes"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='no_informado']/node()"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </td>
				</tr>
                                <xsl:if test="OFERTA/CT_OFE_IDTIPO = 'LIQ'">
                                <tr class="sinLinea">
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>:</td>
					<td class="datosLeft"><xsl:value-of select="OFERTA/CT_OFE_UNIDADBASICA" disable-output-escaping="yes"/></td>
				</tr>
                                </xsl:if>
				<tr class="sinLinea">
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_unitario']/node()"/>:</td>
					<td class="datosLeft"><xsl:value-of select="OFERTA/CT_OFE_PRECIO" disable-output-escaping="yes"/>
                                        &nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='euro']/node()"/>&nbsp;
                                        (<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_unitario_expli']/node()"/>)
                                        </td>
				</tr>
                                <xsl:if test="OFERTA/CT_OFE_IDTIPO = 'LIQ'">
                                <tr class="sinLinea">
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='ud_lote']/node()"/>:</td>
					<td class="datosLeft"><xsl:value-of select="OFERTA/CT_OFE_UNIDADESPORLOTE" disable-output-escaping="yes"/>
                                        </td>
				</tr>
                                </xsl:if>
                                <xsl:if test="/StockOferta/LANG = 'spanish'">
                                        <tr class="sinLinea">
                                                <td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/>:</td>
                                                <td class="datosLeft">
                                                    <xsl:value-of select="OFERTA/TIPOSIVA/field/@current" disable-output-escaping="yes"/>&nbsp;%
                                                </td>
                                        </tr>
                                </xsl:if>
                                <xsl:if test="OFERTA/CT_OFE_IDTIPO = 'LIQ'">
                                <tr class="sinLinea">
						<td class="labelRight grisMed">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='compra_minima']/node()"/>:
						</td>
                                                <td class="datosLeft"><xsl:value-of select="OFERTA/CT_OFE_COMPRAMINIMA_UDS" disable-output-escaping="yes"/>
                                                 &nbsp;&nbsp;(<xsl:value-of select="document($doc)/translation/texts/item[@name='compra_minima_expli_cliente']/node()"/>)</td>						
                                </tr>
                                </xsl:if>
				<tr class="sinLinea">
					<td class="labelRight grisMed">
                                            <xsl:choose>
                                                <xsl:when test="OFERTA/CT_OFE_CANTIDADPEDIDA != ''"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_inicial']/node()"/>:</xsl:when>
                                                <xsl:otherwise><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_stock']/node()"/>:</xsl:otherwise>
                                            </xsl:choose>
                                        </td>
					<td class="datosLeft">
                                             <xsl:choose>
                                                <xsl:when test="OFERTA/CT_OFE_CANTIDADPEDIDA != ''"><xsl:value-of select="OFERTA/CT_OFE_CANTIDADINICIAL" disable-output-escaping="yes"/></xsl:when>
                                                <xsl:otherwise><xsl:value-of select="OFERTA/CT_OFE_CANTIDAD" disable-output-escaping="yes"/></xsl:otherwise>
                                            </xsl:choose>
                                            &nbsp;&nbsp;(<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_expli']/node()"/>)
                                            
                                        </td>
				</tr>
                                
                                <xsl:if test="OFERTA/CT_OFE_CANTIDADPEDIDA != ''">
                                <tr class="sinLinea">
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_pedida']/node()"/>:</td>
					<td class="datosLeft"><xsl:value-of select="OFERTA/CT_OFE_CANTIDADPEDIDA" disable-output-escaping="yes"/></td>
                                </tr>
                                <tr class="sinLinea">
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_stock']/node()"/>:</td>
                                        <td class="datosLeft"><xsl:value-of select="OFERTA/CT_OFE_CANTIDAD" disable-output-escaping="yes"/>&nbsp;
                                                (<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_expli']/node()"/>)</td>
				</tr>
                                </xsl:if>
                                
                                <xsl:if test="OFERTA/CT_OFE_IDTIPO = 'LIQ'">
                                 <tr class="sinLinea">
						<td class="labelRight grisMed">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/>:
						</td>
						<td class="datosLeft">
                                                    <xsl:choose>
                                                        <xsl:when test="OFERTA/IDPEDIDOMINIMO = '0'"><xsl:value-of select="document($doc)/translation/texts/item[@name='sin_pedido_minimo']/node()"/></xsl:when>
                                                        <xsl:when test="OFERTA/IDPEDIDOMINIMO = '-1'"><!--pedido minimo por defecto-->
                                                            <xsl:value-of select="OFERTA/PEDIDOMINIMO_IMPORTE" disable-output-escaping="yes"/>&nbsp;
                                                            <xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>
                                                        </xsl:when>
                                                        <xsl:when test="OFERTA/IDPEDIDOMINIMO != '0' and OFERTA/IDPEDIDOMINIMO != '-1'">
                                                            <xsl:value-of select="OFERTA/PEDIDOMINIMO_IMPORTE" disable-output-escaping="yes"/>&nbsp;
                                                            <xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>
                                                        </xsl:when>
                                                    </xsl:choose>
						</td>
					</tr>
                                </xsl:if>
				<tr class="sinLinea">
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_caducidad']/node()"/>:</td>
					<td class="datosLeft">
                                            <xsl:choose>
                                                <xsl:when test="OFERTA/CT_OFE_FECHACADUCIDAD != ''">
                                                    <xsl:value-of select="OFERTA/CT_OFE_FECHACADUCIDAD" disable-output-escaping="yes"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='hasta_agotar_existencias']/node()"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </td>
				</tr>
                                <xsl:if test="OFERTA/FT">
                                <tr class="sinLinea">
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='ficha_tecnica']/node()"/>:</td>
					<td class="datosLeft">
                                           <a href="http://www.newco.dev.br/Documentos/{OFERTA/FT/URL}" target="_blank">
							<xsl:value-of select="OFERTA/FT/NOMBRE" />
						</a>
                                        </td>
				</tr>
                                </xsl:if>
                                <xsl:if test="OFERTA/IMAGENES/IMAGEN">
                                <tr class="sinLinea">
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='imagen']/node()"/>:</td>
					<td class="datosLeft">
                                           <img src="http://www.newco.dev.br/Fotos/{OFERTA/IMAGENES/IMAGEN/@peq}" />
                                        </td>
				</tr>
                                </xsl:if>
                                
				<tr class="sinLinea">
					<td colspan="2">&nbsp;</td>
                    </tr>
                    <!--si cantidad diferente de 0 puedo pedir, si no no-->
                    <xsl:if test="OFERTA/CT_OFE_CANTIDAD != '0' and OFERTA/CT_OFE_IDESTADO != 'F'">
                    <!--info pedido del cliente veo solo si oferta esta a O, cdc ya ha informado-->
                    <xsl:choose>
                        <!--condicion antes debía ser CDC ahora solo comprador porqué los clientes con cuadro avanzado tb pueden ver 15-10-15 mc
                    not(/StockOferta/NUEVOPEDIDO) and ((OFERTA/CT_OFE_IDESTADO = 'O' and (OFERTA/MVM or OFERTA/MVM)) or (OFERTA/CT_OFE_IDESTADO = 'O' and OFERTA/ROL ='COMPRADOR' and OFERTA/CDC))-->
                    <xsl:when test="not(/StockOferta/NUEVOPEDIDO) and ((OFERTA/CT_OFE_IDESTADO = 'O' and (OFERTA/MVM or OFERTA/MVMB)) or (OFERTA/CT_OFE_IDESTADO = 'O' and OFERTA/ROL ='COMPRADOR'))">

                    <form name="formPedido" id="formPedido" method="post">
                        <input type="hidden" name="OFERTA_STOCK" id="OFERTA_STOCK" value="{OFERTA/CT_OFE_ID}"/>
                        <input type="hidden" name="CANTIDAD_STOCK" id="CANTIDAD_STOCK" value="{OFERTA/CT_OFE_CANTIDAD_SINFORMATO}"/>
                        <input type="hidden" name="CANTIDAD_PEDIDA" id="CANTIDAD_PEDIDA" value="{OFERTA/CT_OFE_CANTIDADPEDIDA_SINFORMATO}"/>
                        <input type="hidden" name="UDBASICA_STOCK" id="UDBASICA_STOCK" value="{OFERTA/CT_OFE_UNIDADBASICA}"/>
                        <input type="hidden" name="COMPRA_MINIMA" id="COMPRA_MINIMA" value="{OFERTA/CT_OFE_COMPRAMINIMA_UDS}"/>
                        <input type="hidden" name="UDLOTE_STOCK" id="UDLOTE_STOCK" value="{OFERTA/CT_OFE_UNIDADESPORLOTE}"/>    
                        <input type="hidden" name="PRECIO_UNI" id="PRECIO_UNI" value="{OFERTA/CT_OFE_PRECIO}"/>                                    
                        <input type="hidden" name="PEDIDOMINIMO" id="PEDIDOMINIMO" value="{OFERTA/PEDIDOMINIMO_IMPORTE}"/>
                        <input type="hidden" name="TIPO" id="TIPO" value="{OFERTA/CT_OFE_IDTIPO}"/>      
                        <input type="hidden" name="ESTADO" id="ESTADO" />                             
                        <tr class="sinLinea">
					<td>&nbsp;</td>
					<td style="text-transform:uppercase;text-align:left;background-color:#D3D3D3;padding-left:10px;">
						<strong>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='info_pedido']/node()"/>
						</strong>
                    </td>
				</tr>
                <tr class="sinLinea">
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_pedido']/node()"/>:&nbsp;
                    <span class="camposObligatorios">*</span></td>
					<td class="datosLeft">
                    <input type="text" class="peq" name="CODIGO_PEDIDO" id="CODIGO_PEDIDO" size="10"/>
                 </td>
				</tr>
               <tr class="sinLinea">
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/>:&nbsp;
                    <span class="camposObligatorios">*</span></td>
					<td class="datosLeft">
                    <input type="text" class="peq" name="PEDIDO_CANTIDAD" id="PEDIDO_CANTIDAD" size="10"/>
                </td>
				</tr>
                  <tr class="sinLinea">
						<td class="labelRight"></td>
						<td class="datosLeft">
							<!--<div class="boton" id="BotonPedido">-->
								<a class="btnDestacado" id="BotonPedido" href="javascript:ValidarFormularioPedido(document.forms['formPedido']);">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/>
								</a>
							<!--</div>-->
                            <xsl:if test="OFERTA/MVM or OFERTA/MVMB">
                            <!--<div class="boton" id="BotonPedido" style="margin-left:40px;">-->
								<a class="btnDestacado" id="BotonPedido" href="javascript:FinalizarOferta(document.forms['formPedido'],'F');">
									<xsl:value-of select="document($doc)/translation/texts/item[@name='finalizar']/node()"/>
								</a>
							<!--</div>-->
                            </xsl:if>
						</td>
                        <td class="datosLeft">&nbsp;</td>
					</tr>
                	</form>   
                	</xsl:when><!--fin de infoPedido-->   
                	<xsl:when test="/StockOferta/NUEVOPEDIDO">
                    	 <tr class="sinLinea">
		<td class="labelRight"></td>
                        	<td class="datosLeft">
                            	<span class="exito">
                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_guardado_con_exito']/node()"/>
                            	</span>
                        	</td>
                    	 </tr>
                	</xsl:when>
                	</xsl:choose> 
            	</xsl:if>
			</table>
    </div>
</xsl:template>

<!--modifica de la oferta en mvm si es mvm o autor de oferta-->
<xsl:template name="modificaOferta">
    
    <!--idioma-->                                              
        <xsl:variable name="lang">
         	<xsl:choose>
                <xsl:when test="//LANG"><xsl:value-of select="//LANG" /></xsl:when>
                <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
    <!--idioma fin-->
    
    <div class="divLeft15nopa">&nbsp;</div>
    <div class="divLeft70">
        
            <!--<table class="infoTable incidencias" cellspacing="5" cellpadding="5" style="border-bottom:2px solid #D7D8D7;">-->
            <table class="buscador">
                
                <form name="frmStockOfertaID" id="frmStockOfertaID" method="post">
				
				<!-- Solictud Catalogacion -->
                <input type="hidden" name="STOCK_TITULO" id="STOCK_TITULO" value="{OFERTA/CT_OFE_TITULO}"/>
                <input type="hidden" name="STOCK_ID" id="STOCK_ID" value="{OFERTA/CT_OFE_ID}"/>
                <input type="hidden" name="STOCK_ESTADO" id="STOCK_ESTADO" value="O"/>
                <input type="hidden" name="STOCK_ID_PROD" id="STOCK_ID_PROD" />
                <input type="hidden" name="TIPO_DOC_DB" id="TIPO_DOC_DB"/>
                <input type="hidden" name="TIPO_DOC_HTML" id="TIPO_DOC_HTML"/>
                <input type="hidden" name="CADENA_DOCUMENTOS"/>
                <input type="hidden" name="DOCUMENTOS_BORRADOS"/>
                <input type="hidden" name="BORRAR_ANTERIORES"/>
                <input type="hidden" name="STOCK_FICHATECNICA" id="DOC_FICHAID" value="{OFERTA/CT_OFE_IDFICHATECNICA}"/>
                <input type="hidden" name="ID_USUARIO" value="{OFERTA/IDUSUARIO}"/>
                <input type="hidden" name="ID_EMPRESA" value="{OFERTA/IDEMPRESAUSUARIO}"/>
                <input type="hidden" name="STOCK_PEDIDOMINIMO" value="{OFERTA/PEDIDOMINIMO}"/>
                <input type="hidden" name="ESTADO"/>
                <input type="hidden" name="STOCK_TIPO" id="STOCK_TIPO" value="{OFERTA/CT_OFE_IDTIPO}"/>
                <xsl:variable name="image">mvm|<xsl:value-of select="OFERTA/IMAGENES/IMAGEN[@num='1']/@peq"/>|<xsl:value-of select="OFERTA/IMAGENES/IMAGEN[@num='1']/@grande"/>#</xsl:variable>
               <!-- <xsl:value-of select="$image" />-->
                <input type="hidden" name="CADENA_IMAGENES">
                    <xsl:attribute name="value">
                        <xsl:if test="OFERTA/IMAGENES/IMAGEN[@peq !='']"><xsl:value-of select="$image"/></xsl:if>
                    </xsl:attribute>
                </input>
                <input type="hidden" name="IMAGENES_BORRADAS"/>

                <tr class="sinLinea">
                    <td>&nbsp;</td>
                    <td class="datosLeft">
                        <xsl:choose>
                            <xsl:when test="OFERTA/CT_OFE_IDESTADO = 'O'">
                                <xsl:choose>
                                <xsl:when test="LANG = 'spanish'">
                                    <img src="http://www.newco.dev.br/images/step3ofertas.gif" alt="Nueva" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <img src="http://www.newco.dev.br/images/step3ofertas-BR.gif" alt="Novo" />
                                </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:choose>
                                <xsl:when test="LANG = 'spanish'">
                                    <img src="http://www.newco.dev.br/images/step2ofertas.gif" alt="Publicar" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <img src="http://www.newco.dev.br/images/step2ofertas-BR.gif" alt="Publicar" />
                                </xsl:otherwise>
                                </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>    
                </tr>
                <xsl:if test="OFERTA/CT_OFE_IDESTADO = 'O'">
                    <tr class="sinLinea">
                    <td>&nbsp;</td>
                    <td class="datosLeft">
                        <p class="urgente">
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_publicada_ya']/node()"/>
                            <xsl:choose>
                            <xsl:when test="not(OFERTA/CT_OFE_CANTIDADPEDIDA != '')">,&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='aun_sin_pedidos']/node()"/></xsl:when>
                            <xsl:otherwise>,&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='con_pedidos']/node()"/></xsl:otherwise>
                            </xsl:choose>
                        </p>
                    </td>
                    </tr>
                </xsl:if>
				<tr class="sinLinea">
					<td>&nbsp;</td>
					<td style="text-transform:uppercase;text-align:left;background-color:#D3D3D3;padding-left:10px;">
						&nbsp;<strong>
							<xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_stock']/node()"/>
							<span style="float:right;padding-right:30px;">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:&nbsp;<xsl:value-of select="OFERTA/CT_OFE_FECHA"/>
							</span>
						</strong>
                    </td>
				</tr>
                <tr class="sinLinea">
					<td class="labelRight grisMed">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/>:
						<span class="camposObligatorios">*</span>
					</td>
					<td class="datosLeft">
                        <input type="radio" class="muypeq" name="STOCK_TIPO_RADIO" id="STOCK_TIPO_LIQ" value="LIQ" onchange="checkTipo('CDC');">
                            <xsl:if test="OFERTA/CT_OFE_IDTIPO = 'LIQ'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
                        </input>&nbsp;
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='liquidaciones_stock']/node()"/>&nbsp;&nbsp;

                        <input type="radio" class="muypeq" name="STOCK_TIPO_RADIO" id="STOCK_TIPO_SEG" value="SEG" onchange="checkTipo('CDC');">
                            <xsl:if test="OFERTA/CT_OFE_IDTIPO = 'SEG'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
                        </input>&nbsp;
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='segunda_mano']/node()"/>
					</td>
				</tr>
				<tr class="sinLinea">
					<td class="trenta labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:</td>
					<td class="datosLeft"><xsl:value-of select="OFERTA/USUARIO"/>&nbsp;-&nbsp;
                        <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={OFERTA/CT_OFE_IDPROVEEDOR}','DetalleEmpresa',100,80,0,0);">
                            <xsl:value-of select="OFERTA/PROVEEDOR"/>
                        </a>
                    </td>
				</tr>
				<tr class="sinLinea">
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_proveedor']/node()"/>:</td>
					<td class="datosLeft">
                        <input type="text" class="peq" name="STOCK_REF_CLIENTE" id="STOCK_REF_CLIENTE" value="{OFERTA/CT_OFE_REFPROVEEDOR}"/>&nbsp;
                        <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/BuscarProveedoresEval.xsql?ORIGEN=OFERTASTOCK','Buscador proveedores',60,40,0,40);" style="text-decoration:none;">
                            <img src="http://www.newco.dev.br/images/buscarCatalogoProveedores.gif" alt="Buscar catalogo proveedores" />
                        </a>&nbsp;
                        <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROManten.xsql','Crear nuevo producto',80,80,0,0);" style="text-decoration:none;">
                            <xsl:choose>
                                <xsl:when test="/StockOferta/LANG = 'spanish'"><img src="http://www.newco.dev.br/images/nuevoProducto.gif" alt="Nuevo producto" /></xsl:when>
                                <xsl:otherwise><img src="http://www.newco.dev.br/images/nuevoProducto-BR.gif" alt="Produto novo" /></xsl:otherwise>
                            </xsl:choose>
                        </a>                                       
                    </td>
				</tr>

				<tr class="sinLinea">
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:</td>
					<td class="datosLeft">
                        <input type="text" class="peq" name="STOCK_PRODUCTO" id="STOCK_PRODUCTO" value="{OFERTA/CT_OFE_PRODUCTO}" size="62" maxlenght="100" />
                    </td>
				</tr>
                <tr class="sinLinea">
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_caducidad_producto']/node()"/>:</td>
					<td class="datosLeft">
						<span style="float:left;">
							<script type="text/javascript">
								calCDCFechaCaducidadProducto.dateFormat="dd/MM/yyyy";
								calCDCFechaCaducidadProducto.labelCalendario='<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_caducidad_producto']/node()"/>';
								calCDCFechaCaducidadProducto.minDate=new Date(new Date().setDate(new Date().getDate()+1));
								calCDCFechaCaducidadProducto.writeControl();
							</script>
						</span>
						<span style="float:left;margin-top:8px;">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='formato_fecha2']/node()"/></span>
					</td>
				</tr>
                                
				<tr class="noObliSeg sinLinea">
                <xsl:attribute name="style"><xsl:if test="OFERTA/CT_OFE_IDTIPO = 'SEG'">display:none;</xsl:if></xsl:attribute>
						<td class="labelRight grisMed">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica']/node()"/>:&nbsp;
							<span class="camposObligatorios">*</span>
						</td>
						<td class="datosLeft"><input type="text" class="peq" name="STOCK_UDBASICA" id="STOCK_UDBASICA" maxlength="30" value="{OFERTA/CT_OFE_UNIDADBASICA}"/></td>
                </tr>
				<tr class="sinLinea">
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_unitario']/node()"/>:</td>
					<td class="datosLeft">
                	<input type="text" class="peq" name="STOCK_PRECIO_SN" id="STOCK_PRECIO_SN" value="{OFERTA/CT_OFE_PRECIO_SINFORMATO}" maxlength="10" size="8" style="display:none;"/>&nbsp;
                	<input type="text" class="peq" name="STOCK_PRECIO" id="STOCK_PRECIO" value="{OFERTA/CT_OFE_PRECIO}" maxlength="10" size="8"/>&nbsp;
                	<xsl:value-of select="document($doc)/translation/texts/item[@name='euro']/node()"/>&nbsp;
                    	(<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_unitario_expli']/node()"/>)
            	</td>
				</tr>
                        <tr class="noObliSeg sinLinea">
                            <xsl:attribute name="style"><xsl:if test="OFERTA/CT_OFE_IDTIPO = 'SEG'">display:none;</xsl:if></xsl:attribute>
				<td class="labelRight grisMed">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_lote']/node()"/>:&nbsp;
					<span class="camposObligatorios">*</span>
				</td>
				<td class="datosLeft"><input type="text" class="peq" name="STOCK_UDLOTE" id="STOCK_UDLOTE" maxlength="10" size="8" value="{OFERTA/CT_OFE_UNIDADESPORLOTE}"/></td>
				</tr>
                <!--iva-->
               <xsl:choose>
                    <xsl:when test="/StockOferta/LANG = 'spanish'">
                        <tr class="sinLinea">
                                <td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/>:</td>
                                <td class="datosLeft">
                                    <xsl:call-template name="desplegable">
                                    <xsl:with-param name="path" select="/StockOferta/OFERTA/TIPOSIVA/field"/>
                                    </xsl:call-template>
                                </td>
                        </tr>
                    </xsl:when>
                    <xsl:otherwise><input type="text" class="peq" name="IDTIPOIVA" id="IDTIPOIVA" value="0"/></xsl:otherwise>
                </xsl:choose>
				
				<tr class="noObliSeg sinLinea">
    				<xsl:attribute name="style"><xsl:if test="OFERTA/CT_OFE_IDTIPO = 'SEG'">display:none;</xsl:if></xsl:attribute>
				<td class="labelRight grisMed">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='compra_minima']/node()"/>:
					<span class="camposObligatorios">*</span>
				</td>
				<td class="datosLeft" colspan="2"><input type="text" class="peq" name="STOCK_COMPRAMINIMA" id="STOCK_COMPRAMINIMA"  maxlength="10" size="8" value="{OFERTA/CT_OFE_COMPRAMINIMA_UDS}"/>&nbsp;
					(<xsl:value-of select="document($doc)/translation/texts/item[@name='compra_minima_expli']/node()"/>)
				</td>
				</tr>
                <tr class="sinLinea">
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_stock']/node()"/>:</td>
					<td class="datosLeft">
                    <input type="text" class="peq" name="STOCK_CANTIDAD" id="STOCK_CANTIDAD" value="{OFERTA/CT_OFE_CANTIDAD}" maxlength="10" size="8"/>&nbsp;
                    (<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_expli']/node()"/>)
                    </td>
				</tr>
               <tr class="noObliSeg sinLinea">
                     <xsl:attribute name="style"><xsl:if test="OFERTA/CT_OFE_IDTIPO = 'SEG'">display:none;</xsl:if></xsl:attribute>
						<td class="labelRight grisMed">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo']/node()"/>:
							<span class="camposObligatorios">*</span>
						</td>
						<td class="datosLeft">
                            <input type="radio" class="muypeq" name="STOCK_PEDIDOMINIMO_RADIO" id="STOCK_PM_SIN" value="0" onchange="verPedidoMinimo();">
                                <xsl:if test="OFERTA/IDPEDIDOMINIMO = '0'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
                            </input>&nbsp;
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='sin_pedido_minimo']/node()"/>&nbsp;&nbsp;

                            <input type="radio" class="muypeq" name="STOCK_PEDIDOMINIMO_RADIO" id="STOCK_PM_DEFECTO" value="-1" onchange="verPedidoMinimo();">
                                <xsl:if test="OFERTA/IDPEDIDOMINIMO = '-1'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
                            </input>&nbsp;
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo_defecto']/node()"/>&nbsp;&nbsp;

                            <input type="radio" class="muypeq" name="STOCK_PEDIDOMINIMO_RADIO" id="STOCK_PM_INFORMAR" value="I" onchange="verPedidoMinimo();">
                                <xsl:if test="OFERTA/IDPEDIDOMINIMO != '0' and OFERTA/IDPEDIDOMINIMO != '-1'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
                            </input>&nbsp;
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='informar_pedido_minimo']/node()"/>&nbsp;&nbsp;
                            <span class="pedidoMinimoValue">
                                <xsl:attribute name="style">
                                <xsl:if test="OFERTA/IDPEDIDOMINIMO = '0' or OFERTA/IDPEDIDOMINIMO = '-1'">display:none;</xsl:if>
                                </xsl:attribute>
                                <input type="text" name="STOCK_PEDIDOMINIMO_VALUE" id="STOCK_PEDIDOMINIMO_VALUE" value="{OFERTA/PEDIDOMINIMO_IMPORTE}" maxlength="8" size="5"/>&nbsp;
                                <xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>
                            </span>
						</td>
					</tr>
				<tr class="sinLinea">
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_caducidad']/node()"/>:</td>
					<td class="datosLeft">
                                            
                            <span style="float:left;">
								<script type="text/javascript">
									calCDCFechaCaducidad.dateFormat="dd/MM/yyyy";
									calCDCFechaCaducidad.labelCalendario='<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_caducidad']/node()"/>';
                                    calCDCFechaCaducidad.minDate=new Date(new Date().setDate(new Date().getDate()+1));
									calCDCFechaCaducidad.writeControl();
								</script>
							</span>
							<span style="float:left;margin-top:8px;">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='formato_fecha2']/node()"/></span>
                                        </td>
				</tr>
                                <!--si no hay ficha tecnica puedo añadir-->
                                <xsl:choose>
                                <xsl:when test="OFERTA/FT">
                                <tr class="sinLinea">
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='ficha_tecnica']/node()"/>:</td>
					<td class="datosLeft">
                                           <a href="http://www.newco.dev.br/Documentos/{OFERTA/FT/URL}" target="_blank">
							<xsl:value-of select="OFERTA/FT/NOMBRE" />
						</a>
                                        </td>
				</tr>
                                </xsl:when>
                                <xsl:otherwise>
                                <tr class="sinLinea">
					<td class="labelRight grisMed"><xsl:value-of select="document($doc)/translation/texts/item[@name='ficha_tecnica']/node()"/>:</td>
					<td class="datosLeft" colspan="2">
							<span id="newDocFICHAID" align="center">
								<a href="javascript:verCargaDoc('FICHAID');" title="Subir ficha técnica" style="text-decoration:none;">
									<img src="http://www.newco.dev.br/images/subirDocumento.gif" alt="Subir ficha técnica"/>
								</a>
							</span>&nbsp;
							<span id="docBoxFICHAID" style="display:none;" align="center"></span>&nbsp;
							<span id="borraDocFICHAID" style="display:none;" align="center"></span>
					</td>
				</tr>
				<tr id="cargaFICHAID" class="cargas" style="display:none;">
					<td colspan="3"><xsl:call-template name="CargaDocumentos"><xsl:with-param name="tipo">FICHAID</xsl:with-param></xsl:call-template></td>
				</tr>
                                </xsl:otherwise>
                                </xsl:choose>
                                
                                <tr class="sinLinea">
                                <td class="labelRight grisMed">
                                        <xsl:value-of select="document($doc)/translation/texts/item[@name='imagen']/node()"/>:
                                </td>
                                <td class="datosLeft">

                                    <span class="anadirImage">
                                    <xsl:variable name="ima" select="count(OFERTA/IMAGENES/IMAGEN)"/>

                                        <xsl:choose>
                                        <xsl:when test="$ima = '2'">
                                            <xsl:for-each select="OFERTA/IMAGENES/IMAGEN">
                                                 <xsl:call-template name="imageMan"><xsl:with-param name="num" select="@num" /></xsl:call-template>
                                            </xsl:for-each>
                                        </xsl:when>
                                        <xsl:when test="$ima = '1'">
                                            <xsl:for-each select="OFERTA/IMAGENES/IMAGEN">
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
				</tr>
                 <tr class="sinLinea">
					<td class="labelRight"></td>
					<td class="datosLeft">

                        <xsl:choose>
                            <xsl:when test="OFERTA/CT_OFE_IDESTADO = 'O'">
                                <!--<div class="boton" id="BotonSubmitID">-->
                                	<a class="btnDestacado" id="BotonSubmitID" href="javascript:ValidarFormularioCdC(document.forms['frmStockOfertaID'],'OFERTA','MVM');">
                               			<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar']/node()"/>
                               		</a>
									&nbsp;
                                <!--</div>-->
                                <xsl:if test="OFERTA/MVM or OFERTA/MVMB">
                                    <!--<div class="boton" id="BotonPedido" style="margin-left:40px;">-->
                                            <a class="btnDestacado" id="BotonPedido" href="javascript:FinalizarOferta(document.forms['frmStockOfertaID'],'F');">
                                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='finalizar']/node()"/>
                                            </a>
                                    <!--</div>-->
                                </xsl:if>
                            </xsl:when>
                            <xsl:otherwise>
                               <!-- <div class="boton" id="BotonSubmitID">-->
                                <a class="btnDestacado" id="BotonSubmitID" href="javascript:ValidarFormularioCdC(document.forms['frmStockOfertaID'],'OFERTA','MVM');">
                                <xsl:value-of select="document($doc)/translation/texts/item[@name='publicar']/node()"/>
                                </a>
                               <!-- </div>-->
                            </xsl:otherwise>
                        </xsl:choose>
								
							
						</td>
                        <td class="datosLeft">&nbsp;</td>
					</tr>
                </form>    
                <tr class="sinLinea">
					<td colspan="2">&nbsp;</td>
				</tr>
                                
                <tr class="sinLinea">
                    <td colspan="2">
                        <xsl:if test="OFERTA/PEDIDOS/PEDIDO and (OFERTA/MVM or OFERTA/MVMB)">

                            <table class="grandeInicio" style="width:70%; margin-left:15%;border:2px solid #D7D8D7; border-top:0;">
                                <thead>
                                <tr class="subTituloTabla" style="border-top:none;">
                                    <th><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/></th>
                                    <th><xsl:value-of select="document($doc)/translation/texts/item[@name='enviado']/node()"/></th>
                                    <th><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></th>
                                    <th><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>
                                </tr>
                                </thead>
                                <tbody>
                                <xsl:for-each select="OFERTA/PEDIDOS/PEDIDO">
                                    <tr class="sinLinea">
                                        <td><xsl:value-of select="CT_PED_CODIGO" /></td>
                                        <td><xsl:value-of select="CT_PED_FECHA" /></td>
                                        <td><xsl:value-of select="CT_PED_CANTIDAD" /></td>
                                        <td><xsl:value-of select="CENTRO" /></td>
                                    </tr>
                                </xsl:for-each>  
                                </tbody>                              
                            </table>
                        </xsl:if>

                    </td>
                </tr>
                                
                                
			</table>
                          
        <br /><br />
    </div>
    
</xsl:template>


</xsl:stylesheet>
