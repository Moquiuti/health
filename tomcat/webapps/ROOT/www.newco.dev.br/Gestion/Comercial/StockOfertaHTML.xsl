<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
<xsl:import href = "http://www.newco.dev.br/Gestion/Comercial/StockOfertaTemplate.xsl" />          

<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/StockOferta">   
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

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_stock']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
        <link href="http://www.newco.dev.br/General/Fuentes/css?family=Montserrat:400,700" rel="stylesheet" type="text/css"/>    
	<link rel="stylesheet" href="http://www.newco.dev.br/General/calendario/spiffyCal_v2_1.css" type="text/css"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/calendario/spiffyCal_v2_1.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/StockOferta180416.js"></script>
     
	<script type="text/javascript">     
	var titulo_obligatorio			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_titulo_stck_ofe']/node()"/>';
	var descripcion_obligatoria		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_descripcion']/node()"/>';
	var refprov_obligatorio         = '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_ref_prov_stck']/node()"/>';
	var producto_obligatorio		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_descr_producto_stck_dem']/node()"/>';
	var precio_obligatorio			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_precio_stck_dem']/node()"/>';
	var precio_error			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_precio_stck_dem']/node()"/>';
	var cantidad_obligatorio 		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_cantidad_stck_dem']/node()"/>';
	var ud_basica_obli		        = '<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_basica_obli']/node()"/>';
	var ud_lote_obli		        = '<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_lote_obli']/node()"/>';
	var ud_lote_numerico		    = '<xsl:value-of select="document($doc)/translation/texts/item[@name='ud_lote_numerico']/node()"/>';
	var cantidad_numerico		    = '<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_numerico']/node()"/>';
	var compra_minima_obli          = '<xsl:value-of select="document($doc)/translation/texts/item[@name='compra_minima_obli']/node()"/>';
	var cantidad_error			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_cantidad_stck_dem']/node()"/>';       
	var cantidad_pedido_menor		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_pedido_menor']/node()"/>';
	var cantidad_multiple_ud_lote   = '<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_multiple_ud_lote']/node()"/>';
	var fecha_obligatorio			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_fecha_stck_dem']/node()"/>';
	var fecha_error				= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_fecha_stck_dem']/node()"/>';
	var codigo_pedido_obli			= '<xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_pedido_obli']/node()"/>';
	var cantidad_pedido_obli		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_pedido_obli']/node()"/>';
	var cantidad_pedida_mayor_compra_minima = '<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_pedida_mayor_compra_minima']/node()"/>';  
	var pedido_minimo_obli                  = '<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo_obli']/node()"/>';
	var pedido_minimo_value_obli            = '<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_minimo_value_obli']/node()"/>';
	var cantidad_pedida_no_llega_pedido_minimo	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad_pedida_no_llega_pedido_minimo']/node()"/>';
	var tipo_liqui_obli                     = '<xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_liqui_obli']/node()"/>';
	var familia_obligatoria		        = '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_familia']/node()"/>';	
	var subfamilia_obligatoria		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='obli_subfamilia']/node()"/>';	
	var marca_obligatoria		        = '<xsl:value-of select="document($doc)/translation/texts/item[@name='marca_obli']/node()"/>';		
	var precio_lote_obligatorio		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_lote_obli']/node()"/>';		
	var precio_retail_lote_obligatorio	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_retail_obli']/node()"/>';	
	var coste_envio_obligatorio	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='coste_envio_obli']/node()"/>';
	var plazo_envio_obligatorio	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='plazo_envio_obli']/node()"/>';		
	</script>
</head>     
 
<body>   
    <xsl:attribute name="onload">RecuperaBienText();</xsl:attribute>
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
        
        
	<div id="spiffycalendar" class="text"></div>
        <xsl:choose>
            <xsl:when test="OFERTA/CT_OFE_IDESTADO = 'P' or OFERTA/CT_OFE_IDESTADO = 'O'">
                <script type="text/javascript">
                        var calCDCFechaCaducidad	= new ctlSpiffyCalendarBox("calCDCFechaCaducidad", "frmStockOfertaID", "STOCK_FECHACADUCIDAD","btnDateCDCFechaCaducidad",'<xsl:value-of select="OFERTA/CT_OFE_FECHACADUCIDAD"/>',scBTNMODE_CLASSIC,'');
                        var calCDCFechaCaducidadProducto = new ctlSpiffyCalendarBox("calCDCFechaCaducidadProducto", "frmStockOfertaID", "STOCK_FECHACADUCIDAD_PROD","btnDateCDCFechaCaducidadProducto",'<xsl:value-of select="OFERTA/CT_OFE_FECHACADPRODUCTO"/>',scBTNMODE_CLASSIC,'');
                </script>
            </xsl:when>
            <xsl:otherwise>
                <script type="text/javascript"> 
                        var calFechaCaducidad	= new ctlSpiffyCalendarBox("calFechaCaducidad", "frmStockOferta", "SO_FECHACADUCIDAD","btnDateFechaCaducidad",'<xsl:value-of select="OFERTA/SO_FECHACADUCIDAD"/>',scBTNMODE_CLASSIC,'');
                        var calFechaCaducidadProducto	= new ctlSpiffyCalendarBox("calFechaCaducidadProducto", "frmStockOferta", "SO_FECHACADUCIDAD_PROD","btnDateFechaCaducidadProducto",'<xsl:value-of select="OFERTA/SO_FECHACADUCIDAD_PROD"/>',scBTNMODE_CLASSIC,'');
                </script>
            </xsl:otherwise>
        </xsl:choose> 
<div class="divLeft">
                                    
<xsl:choose>
  <!--si es usuario normal solo verá datos oferta, no puede modificar, si es mvm o cdc tenemos la parte de info pedido
  <xsl:when test="((OFERTA/CT_OFE_ID != '' and OFERTA/MVM or OFERTA/MVMB) and OFERTA/CT_OFE_IDESTADO = 'O') or (OFERTA/CT_OFE_ID != '' and (not(OFERTA/MVM) and not(OFERTA/MVMB)) and (OFERTA/CT_OFE_IDESTADO = 'P' or OFERTA/CT_OFE_IDESTADO = 'O'))">
  <xsl:when test="(OFERTA/CT_OFE_ID != '' and (not(OFERTA/MVM) and not(OFERTA/MVMB)) and (OFERTA/CT_OFE_IDESTADO = 'P' or OFERTA/CT_OFE_IDESTADO = 'O'))">
    -->
    <!--lo que ve usuario-->
    <xsl:when test="(OFERTA/CT_OFE_ID != '' and (not(OFERTA/CDC) and not(OFERTA/MVM) and not(OFERTA/MVMB)) and (OFERTA/CT_OFE_IDESTADO = 'F' or OFERTA/CT_OFE_IDESTADO = 'P' or OFERTA/CT_OFE_IDESTADO = 'O'))">
        <xsl:variable name="clubvip">
            <xsl:choose>
                <!--<xsl:when test="/StockOferta/OFERTA/PROVEEDOR = 'CVT' or /StockOferta/OFERTA/CENTROPROVEEDOR = 'CVT'">S</xsl:when>-->
                <xsl:when test="/StockOferta/OFERTA/IDPORTAL = 'CVTIENDAS'">S</xsl:when>
                <xsl:otherwise>N</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
                                        
        <xsl:choose>
            <xsl:when test="$clubvip = 'S'"> 
                <xsl:call-template name="ofertaClubVipTiendas" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="oferta" />
             </xsl:otherwise>
        </xsl:choose> 
               
  </xsl:when>
  <!--si es mvm puede informar la oferta de stock y si ya se ha publicado puedo cambiarla-->
  <xsl:when test="OFERTA/CT_OFE_ID != '' and (OFERTA/CT_OFE_IDESTADO = 'P' or OFERTA/CT_OFE_IDESTADO = 'O') and (OFERTA/CDC or OFERTA/MVM or OFERTA/MVMB or OFERTA/IDUSUARIO = OFERTA/CT_OFE_IDUSUARIO)">



	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='ofertas_stock']/node()"/></span></p>
		<p class="TituloPagina">
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
			<xsl:if test="/StockOferta/OFERTA/MVMB or /StockOferta/OFERTA/MVM or /StockOferta/OFERTA/ADMIN">
    			&nbsp;&nbsp;&nbsp;<span class="amarillo">OFE_ID:<xsl:value-of select="/StockOferta/OFERTA/CT_OFE_ID"/></span>
			</xsl:if>
			<span class="CompletarTitulo">
				<!--	PENDIENTE	-->
			</span>
		</p>
	</div>
	<br/>




		<!--
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
		<xsl:if test="/StockOferta/OFERTA/MVMB or /StockOferta/OFERTA/MVM or /StockOferta/OFERTA/ADMIN">
                     <span style="float:right; padding:5px; font-weight:bold;" class="amarillo">OFE_ID: 
                        <xsl:value-of select="/StockOferta/OFERTA/CT_OFE_ID"/>
                    </span>
                </xsl:if>
        </h1>
		-->

        <xsl:variable name="clubvip">
            <xsl:choose>
                <!--<xsl:when test="/StockOferta/OFERTA/PROVEEDOR = 'CVT'">S</xsl:when>-->
                <xsl:when test="/StockOferta/OFERTA/IDPORTAL = 'CVTIENDAS'">S</xsl:when>
                <xsl:otherwise>N</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
                          
        <xsl:choose>         
            <xsl:when test="$clubvip = 'S'"> 
                <xsl:call-template name="modificaOfertaClubVipTiendas" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="modificaOferta" />
             </xsl:otherwise>
        </xsl:choose>  
      

    </xsl:when>

    <xsl:when test="ERROR">
		<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='error_oferta_stock']/node()"/></h1>
    </xsl:when>
        
    <!--nueva oferta stock-->
    <xsl:otherwise>

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='ofertas_stock']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_oferta_stock']/node()"/></span></p>
			<p class="TituloPagina">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_oferta_stock']/node()"/>
				<span class="CompletarTitulo">
					<!--<a class="btnDestacado" href="javascript:NuevoStockOferta();"> 
						<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/>
					</a>-->
				</span>
			</p>
		</div>
		<br/>


		<!--
        	<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_oferta_stock']/node()"/></h1>
           -->    
        <xsl:variable name="clubvip">
            <xsl:choose>
                <!--<xsl:when test="/StockOferta/NUEVAOFERTA/USUARIO/EMPRESA = 'CVT'">S</xsl:when>-->
                <xsl:when test="/StockOferta/NUEVAOFERTA/IDPORTAL = 'CVTIENDAS'">S</xsl:when>
                <xsl:otherwise>N</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
		<form name="frmStockOferta" id="frmStockOferta" method="post">
			<input type="hidden" name="GUARDAR" value="S"/>
			<input type="hidden" name="TIPO_DOC_DB" id="TIPO_DOC_DB"/>
			<input type="hidden" name="TIPO_DOC_HTML" id="TIPO_DOC_HTML"/>
			<input type="hidden" name="CADENA_DOCUMENTOS"/> 
			<input type="hidden" name="DOCUMENTOS_BORRADOS"/>
			<input type="hidden" name="BORRAR_ANTERIORES"/>
			<input type="hidden" name="SO_FICHATECNICA" id="DOC_FICHA"/>
			<input type="hidden" name="ID_USUARIO" value="{USUARIO/US_ID}"/>
			<input type="hidden" name="ID_EMPRESA" value="{USUARIO/EMP_ID}"/>
			<input type="hidden" name="SO_PEDIDOMINIMO" id="SO_PEDIDOMINIMO"/>
			<input type="hidden" name="SO_TIPO" id="SO_TIPO"/>
			<input type="hidden" name="CADENA_IMAGENES"/> 
			<input type="hidden" name="IMAGENES_BORRADAS"/>
			

			<div class="divLeft10">&nbsp;</div>
                <div class="divLeft80">      

                <table class="infoTable incidencias" cellspacing="5" style="border-bottom:2px solid #D7D8D7;">

                <xsl:choose>
                    <xsl:when test="$clubvip = 'S'">
                        <tr>
                            <td>&nbsp;</td>
                            <td class="datosLeft">&nbsp;</td> 
                        </tr>
                    </xsl:when>
                    <!--si es mvm veo dibujo donde estoy-->
                    <xsl:otherwise>
                        <tr>
                            <td>&nbsp;</td>
                            <td class="datosLeft">
                                <xsl:choose>
                                <xsl:when test="LANG = 'spanish'">
                                    <img src="http://www.newco.dev.br/images/step1ofertas.gif" alt="Nueva" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <img src="http://www.newco.dev.br/images/step1ofertas-BR.gif" alt="Novo" />
                                </xsl:otherwise>
                                </xsl:choose>
                            </td>
                        </tr>
                    </xsl:otherwise>
                </xsl:choose>

                <!--las altas ofertas estan en un template, mirar arriba, cuando se modifica el template hay que modificar y guardar esta pagina tb(basta con poner un espacio en algun lado ) si no no veremos las modificas del template-->
                <xsl:choose>
                    <xsl:when test="$clubvip = 'S'">
                        <xsl:call-template name="nuevaOfertaClubVipTiendas" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="nuevaOferta" />
                    </xsl:otherwise>
                </xsl:choose>
				</table>
		</div><!--fin de divLeft60nopa-->
		</form>

		
		<!--form de mensaje de error de js-->
		<form name="mensajeJS">
			<!--carga documentos-->
			<input type="hidden" name="ERROR_SIN_DEFINIR" value="{document($doc)/translation/texts/item[@name='error_sin_definir']/node()}"/>
			<input type="hidden" name="HEMOS_ESPERADO" value="{document($doc)/translation/texts/item[@name='hemos_esperado']/node()}"/>
			<input type="hidden" name="LA_CARGA_NO_TERMINO" value="{document($doc)/translation/texts/item[@name='la_carga_no_termino']/node()}"/>
		</form>
	</xsl:otherwise>
	</xsl:choose><!--fin choose si incidencia guardada con exito-->
	</div><!--fin de divLeft-->
</xsl:otherwise>
</xsl:choose>

                <!--frame para las imagenes y documentos-->
		<div id="uploadFrameBox" style="display:none;"><iframe src="" id="uploadFrame" name="uploadFrame" style="width: 100%;"></iframe></div>
		<div id="uploadFrameBoxDoc" style="display:none;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>
</body>
</html>
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
				<td class="labelRight veintecinco grisMed">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/>:
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
				<td>&nbsp;</td>
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
                <xsl:choose>
                    <xsl:when test="$type = 'FICHAID'">
                        <input id="inputFileDoc_{$type}" name="inputFileDoc" type="file" onChange="cargaDoc(document.forms['frmStockOfertaID'],'{$type}');"/>
                    </xsl:when>
                    <xsl:when test="$type = 'FICHA'">
                        <input id="inputFileDoc_{$type}" name="inputFileDoc" type="file" onChange="cargaDoc(document.forms['frmStockOferta'],'{$type}');"/>
                    </xsl:when>
                </xsl:choose>
			</div>
		</div>
	</xsl:when>
	</xsl:choose>
</xsl:template><!--fin de documentos-->
</xsl:stylesheet>
