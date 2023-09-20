<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>  
<xsl:param name="usuario" select="@US_ID"/>

<xsl:template match="/StockOfertaList">

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

	<META Http-Equiv="Cache-Control" Content="no-cache" />

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='ofertas_stock']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->
        
        <link href="http://www.newco.dev.br/General/Fuentes/css?family=Montserrat:400,700" rel="stylesheet" type="text/css"/>
         
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/StockOferta180416.js"></script>
</head>

<body>
<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
	<xsl:when test="LANG"><xsl:value-of select="LANG"/></xsl:when>
	<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->

<xsl:choose>
<xsl:when test="//SESION_CADUCADA">
	<xsl:apply-templates select="//SESION_CADUCADA"/>
</xsl:when>
<xsl:when test="//Sorry">
	<xsl:apply-templates select="//Sorry"/>
</xsl:when>
<xsl:otherwise>

    <xsl:variable name="usuario">
        <xsl:choose>
            <xsl:when test="not(CONTROLPRECIOS_OFERTAS/OBSERVADOR) and CONTROLPRECIOS_OFERTAS/CDC">CDC</xsl:when>
            <xsl:otherwise>NORMAL</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <form name="Buscador" method="post" action="InicioStocks.xsql">
        
	<table class="buscadorInicio">
		<tr class="select" height="50px">
			<th class="dies">&nbsp;</th>
			<th class="veinte">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>&nbsp;
                                <br></br>
                                <xsl:call-template name="desplegable">
                                    <xsl:with-param name="path" select="CONTROLPRECIOS_OFERTAS/FIDPRODUCTOESTANDAR/field"/>
                                </xsl:call-template>
			</th>
 			<th class="veinte">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>&nbsp;
				<br></br>
                                <xsl:call-template name="desplegable">
                                    <xsl:with-param name="path" select="CONTROLPRECIOS_OFERTAS/FIDMARCA/field"/>
                                    <xsl:with-param name="claSel">selectcortacvt</xsl:with-param>
                                </xsl:call-template>
			</th>
 			<th class="veinte">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='orden']/node()"/>&nbsp;
				<br></br>
                                <xsl:call-template name="desplegable">
                                    <xsl:with-param name="path" select="CONTROLPRECIOS_OFERTAS/ORDEN/field"/>
                                    <xsl:with-param name="claSel">selectcortacvt</xsl:with-param>
                                </xsl:call-template>
			</th>
			<xsl:if test="$usuario = 'CDC'">
                            <th class="veinte">
                                <xsl:value-of select="document($doc)/translation/texts/item[@name='estado']/node()"/>&nbsp;
				<br></br>
                                <xsl:call-template name="desplegable">
                                    <xsl:with-param name="path" select="CONTROLPRECIOS_OFERTAS/FESTADO/field"/>
                                    <xsl:with-param name="claSel">selectcortacvt</xsl:with-param>
                                </xsl:call-template>
                            </th>
                            <th class="veinte">&nbsp;</th>
			</xsl:if>
			<th class="dies">
                <a class="botonWhite" href="javascript:BuscarStockOfertas(document.forms['Buscador']);">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/>
                </a>
			</th>
            <th class="veinte">&nbsp;</th>
            <th>
			<xsl:if test="CONTROLPRECIOS_OFERTAS/VENDERLOTES">
                <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/StockOferta.xsql?ORIGEN=INICIOSTOCKS','Nueva oferta stock',100,100,0,0);">
                     <div class="botonNara">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/>
                    </div>
                </a>
			</xsl:if>&nbsp;
            </th>
			<th class="uno">&nbsp;</th>
		</tr>
	</table> 
	</form>

	<div id="StockOfertaBorradaOK" style="display:none;background:#CEF6CE;padding:5px;width:400px;color:#333;text-align:center;border:1px solid #01DF01;margin:10px auto;"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_stock_oferta_OK']/node()"/></div>
	<div id="StockOfertaBorradaKO" style="display:none;background:#F8E0E6;padding:5px;width:400px;color:#333;text-align:center;border:1px solid red;margin:10px auto;"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar_stock_oferta_KO']/node()"/></div>
<div class="divLeft clubVip">
  <xsl:choose>
	<xsl:when test="CONTROLPRECIOS_OFERTAS/OFERTA">
		<br/>
                <!-- 09/05/2016 - Se cambia el texto 
                <div id="textsiniva">     
                    <p>TODOS LOS PRECIOS SON "SIN IVA"</p>
                </div>
                -->
                <div id="textconiva">     
                    <p>TODOS LOS PRECIOS SON "CON IVA"</p>
                </div>
		<br/>
                <!-- Paginacion 26/04/2016-->
                <div class="paginacion">                        
                        <p>
                            <xsl:if test="CONTROLPRECIOS_OFERTAS/ANTERIOR">                
                                <a id="pagAnt" title="pagina anterior" href="http://www.newco.dev.br/Gestion/Comercial/InicioStocks.xsql?FIDPRODUCTOESTANDAR={CONTROLPRECIOS_OFERTAS/IDPRODUCTOESTANDAR}&amp;FIDMARCA={CONTROLPRECIOS_OFERTAS/IDMARCA}&amp;IDORDEN={CONTROLPRECIOS_OFERTAS/IDORDEN}&amp;FESTADO={CONTROLPRECIOS_OFERTAS/IDESTADO}&amp;PAGINA={CONTROLPRECIOS_OFERTAS/ANTERIOR/@pagina} ">&lt; P�gina Anterior</a>
                            </xsl:if>
                            &nbsp;&nbsp;&nbsp;<label>Mostrando p�gina </label><xsl:value-of select="CONTROLPRECIOS_OFERTAS/PAGINA" />&nbsp;
                            <label>de </label><xsl:value-of select="CONTROLPRECIOS_OFERTAS/TOTAL_PAGINAS" />
                            <label>, con </label><xsl:value-of select="CONTROLPRECIOS_OFERTAS/TOTAL_REGISTROS" />&nbsp;
                            lotes.
                            <xsl:if test="CONTROLPRECIOS_OFERTAS/SIGUIENTE">
                                &nbsp;&nbsp;&nbsp;<a id="pagSig" title="pagina siguiente" href="http://www.newco.dev.br/Gestion/Comercial/InicioStocks.xsql?FIDPRODUCTOESTANDAR={CONTROLPRECIOS_OFERTAS/IDPRODUCTOESTANDAR}&amp;FIDMARCA={CONTROLPRECIOS_OFERTAS/IDMARCA}&amp;IDORDEN={CONTROLPRECIOS_OFERTAS/IDORDEN}&amp;FESTADO={CONTROLPRECIOS_OFERTAS/IDESTADO}&amp;PAGINA={CONTROLPRECIOS_OFERTAS/SIGUIENTE/@pagina}">P�gina siguiente &gt;</a>
                            </xsl:if>
                        </p>                         
                </div>
		<xsl:for-each select="CONTROLPRECIOS_OFERTAS/OFERTA">
			<xsl:variable name="DemandaID"><xsl:value-of select="CT_OFE_ID"/></xsl:variable>
                        
               <div class="oneOfertaClubVip" id="OFE_{CT_OFE_ID}">
                  <xsl:choose>
					<xsl:when test="MODIFICADO_1HORA">
						<xsl:attribute name="class">fondoNaranja oneOfertaClubVip</xsl:attribute>
					</xsl:when>
					<xsl:when test="MODIFICADO_24HORAS">
						<xsl:attribute name="class">fondoAmarillo oneOfertaClubVip</xsl:attribute>
					</xsl:when>
				</xsl:choose>
                                
                <div class="imageOfertaClubVip">
                    <xsl:choose>
                        <xsl:when test="IMAGENES/IMAGEN/@id != ''"><img src="http://www.newco.dev.br/Fotos/{IMAGENES/IMAGEN/@peq}" /></xsl:when>
                        <xsl:otherwise><img src="http://www.newco.dev.br/images/noImageCVT.jpg" alt="no image"/></xsl:otherwise>
                    </xsl:choose>

                </div>
                <div class="datosOfertaClubVip">
                    <h2>
                        <xsl:value-of select="CT_OFE_TITULO"/>
                        <xsl:if test="$usuario = 'CDC'">
                            <a href="javascript:BorrarOfertaStock('{CT_OFE_ID}');" title="Eliminar {CT_OFE_TITULO}"><img src="http://www.newco.dev.br/images/2017/trash.png" alt="Eliminar"/></a>                        
                        </xsl:if>
                    </h2>
                    <p class="descripcion">
                        <xsl:value-of select="substring(CT_OFE_DESCRIPCION,0,170)"/>
                        <xsl:if test="string-length(CT_OFE_DESCRIPCION) > 170">...</xsl:if>
                    </p>

                    <div class="precio">
                        <!--<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_retail']/node()"/></label>&nbsp;&nbsp;<span><xsl:value-of select="CT_OFE_PRECIOPUBLICOLOTE" />&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/></span></p>
                        <p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/></label>&nbsp;&nbsp;<span><xsl:value-of select="CT_OFE_AHORRO" />&nbsp;%</span></p>-->         
                        <!-- 10/05/2016 - Mostrar precios con IVA -->
                        <p id="precioRetail">
                            <label>
                                <xsl:value-of select="document($doc)/translation/texts/item[@name='precio_retail']/node()"/>
                            </label>&nbsp;&nbsp;
                            <span>
                                <xsl:value-of select="CT_OFE_PRECIOPUBLICOLOTE_IVA" />&nbsp;
                                <xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/>
                            </span>
                        </p>
                        <p id="ahorro"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='ahorro']/node()"/></label>&nbsp;&nbsp;<span><xsl:value-of select="CT_OFE_AHORRO" />&nbsp;%</span></p>
                        <!--<p class="precioLote"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></label>&nbsp;&nbsp;<xsl:value-of select="CT_OFE_PRECIOLOTECONCOMISION" />&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/></p>-->
                    </div>
                    <!-- 25/04/2016 - Separamos en dos l�neas los precios -->
                    <div class="precioLote">
                        <p id="precioLot"><label><xsl:value-of select="document($doc)/translation/texts/item[@name='precio']/node()"/></label>&nbsp;&nbsp;<xsl:value-of select="CT_OFE_PRECIOLOTECONCOMISION_IVA" />&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='eur']/node()"/></p>
                    </div>
                    <div class="lineaFinal">
                        <span class="datos">
                            <!--<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_vendedor']/node()"/>:&nbsp;<xsl:value-of select="CT_OFE_REFPROVEEDOR"/>&nbsp;&nbsp;
                            <xsl:value-of select="USUARIO"/>&nbsp;&nbsp;--><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha']/node()"/>:<xsl:value-of select="CT_OFE_FECHA"/>&nbsp;&nbsp;&nbsp;&nbsp;
							<!--<xsl:if test="IDESTADO='O'">
                            [<xsl:value-of select="ESTADO"/>]
							</xsl:if>-->
							<!--&nbsp;-&nbsp;[<xsl:value-of select="document($doc)/translation/texts/item[@name='cod']/node()"/>.&nbsp;<xsl:value-of select="CT_OFE_CODIGO"/>]-->
                        </span>
			<xsl:choose>
                            <xsl:when test="IDESTADO='O'">
                        	<span class="botonClubVip">
                                    <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/StockOferta.xsql?SO_ID={CT_OFE_ID}','oferta de stock',100,80,0,-10)">
                                        <div class="botonCompra">
                                            <xsl:value-of select="document($doc)/translation/texts/item[@name='ver_oferta']/node()"/>
                                        </div>
                                    </a>
                        	</span>
                            </xsl:when>
                            <xsl:when test="IDESTADO='F'">
                                <!--26/04/2016 a�ado maquetacion boton y link -->
                                <span class="botonClubVip">
                                    <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/StockOferta.xsql?SO_ID={CT_OFE_ID}','oferta de stock',100,80,0,-10)">
                                        <div class="botonLotVendido">
                                            <xsl:value-of select="document($doc)/translation/texts/item[@name='lote_vendido']/node()"/>
                                        </div>
                                    </a>
                        	</span>
                            </xsl:when>
                            <xsl:otherwise>
                        	<span class="botonClubVip">
                            	<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/StockOferta.xsql?SO_ID={CT_OFE_ID}','oferta de stock',100,80,0,-10)">
                                	<div class="botonEdicion">
                                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='editar_ofertas']/node()"/>
                                	</div>
                            	</a>
                        	</span>
						</xsl:otherwise>
						</xsl:choose>
                    </div>
              </div>
                   </div>
		</xsl:for-each>
        </xsl:when>
	<xsl:otherwise>
            <center>
                <p>&nbsp;</p>
		<p class="parCVT"><xsl:value-of select="document($doc)/translation/texts/item[@name='stock_oferta_sin_resultados']/node()"/></p>
            </center>
	</xsl:otherwise>
	</xsl:choose>
</div><!--fin de divLeft-->
</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
