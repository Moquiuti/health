<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>
<xsl:param name="usuario" select="@US_ID"/>

<xsl:template match="/FichaProductoLic">

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

	<meta http-equiv="Cache-Control" content="no-cache"/>

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='ficha_producto_licitaciones']/node()"/></title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/Comercial/lic_020215a.js"></script>
	<script type="text/javascript">
		var lang = '<xsl:value-of select="LANG"/>';

		var estadoOfertaActualizado	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='estado_oferta_actualizado']/node()"/>';
		var errorNuevoEstadoOferta	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_nuevo_estado_oferta']/node()"/>';
		var sinSeleccion		= '<xsl:value-of select="document($doc)/translation/texts/item[@name='error_oferta_no_seleccionada']/node()"/>';
		var guardar_selecc_adjudica_ok	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_selecc_adjudica_ok']/node()"/>';
		var guardar_selecc_adjudica_ko	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_selecc_adjudica_ko']/node()"/>';
		var IDEstadoLicitacion		= '<xsl:value-of select="PRODUCTOLICITACION/LIC_IDESTADOLICITACION"/>';
		var IDLicitacion		= '<xsl:value-of select="LIC_ID"/>';

		jQuery(document).ready(MarcarMejorPrecio);

		function MarcarMejorPrecio(){
			if(IDEstadoLicitacion == 'CURS' || IDEstadoLicitacion == 'INF'){
				var MejorPrecio		= -1;
				var MejorOfertaID	= 0;

				<!-- Para cada una de las celdas con class 'PrecioOferta' -->
				jQuery("td.PrecioOferta span").each(function(){

					if(MejorPrecio &lt; 0 || MejorPrecio &gt; parseFloat(jQuery(this).html().replace(",","."))){
						MejorPrecio	= parseFloat(jQuery(this).html().replace(",","."));
						MejorOfertaID	= jQuery(this).parent().attr('id');
					}

				});

				if(MejorOfertaID != 0){
					jQuery("td#" + MejorOfertaID).addClass("mejorPrecio");
				}
			}
		}
	</script>

	<style type="text/css">
		td.mejorPrecio { background-color: #FFFF99;}
	</style>
</head>
<body class="gris">
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

	<!-- Tabla Datos Cliente -->
	<div class="divLeft">

            <h1 class="titlePage" style="float:left;width:20%;">
		<xsl:if test="//PRODUCTOLICITACION/IDPRODUCTOLIC_ANTERIOR">
			<div id="botonProdAnterior" class="boton" style="margin-left:20px;">
				<a href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={//PRODUCTOLICITACION/IDPRODUCTOLIC_ANTERIOR}&amp;LIC_ID={//LIC_ID}"><xsl:value-of select="document($doc)/translation/texts/item[@name='boton_producto_anterior']/node()"/></a>
			</div>
		</xsl:if>
            </h1>
            <h1 class="titlePage" style="float:left;width:60%;">
                                <xsl:choose>
				<xsl:when test="PRODUCTOLICITACION/LIC_PROD_REFCLIENTE != ''">
					<xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_REFCLIENTE" disable-output-escaping="yes"/>:&nbsp;				
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_REFESTANDAR" disable-output-escaping="yes"/>:&nbsp;
				</xsl:otherwise>
				</xsl:choose>
                                <xsl:value-of select="substring(PRODUCTOLICITACION/LIC_PROD_NOMBRE,0,30)" disable-output-escaping="yes"/>
            </h1>
            <h1 class="titlePage" style="float:left;width:20%;">
		<xsl:if test="//PRODUCTOLICITACION/IDPRODUCTOLIC_SIGUIENTE">
			<div id="botonProdSiguiente" class="boton" style="float:right;margin-right:20px;">
				<a href="http://www.newco.dev.br/Gestion/Comercial/FichaProductoLicitacion.xsql?LIC_PROD_ID={//PRODUCTOLICITACION/IDPRODUCTOLIC_SIGUIENTE}&amp;LIC_ID={//LIC_ID}"><xsl:value-of select="document($doc)/translation/texts/item[@name='boton_producto_siguiente']/node()"/></a>
			</div>
		</xsl:if>&nbsp;
            </h1>
        
        <div class="divLeft">
            <!--tabla izquierda especificas producto-->
            <table class="prodTabla" border="0">
                <tbody>
               <tr>
                    <td class="label trenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/>:</td>    	
                    <td class="valor" colspan="5">
                        <xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_NOMBRE" disable-output-escaping="yes"/>
                    </td>
                </tr>
                <!--precio historicos + fecha-->
                <tr>
                <xsl:choose>
                <xsl:when test="PRODUCTOLICITACION/MOSTRAR_PRECIO_IVA">
                    <td class="labelnopa" style="color:#000;">
                        <span class="fondoVerde" style="padding:2px 5px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_historico_cIVA']/node()"/>:</span>
                    </td>    	
                    <td class="valor quince">
                        <span class="fondoVerde" style="padding:2px 5px;"><strong><xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_PRECIOREFERENCIAIVA" disable-output-escaping="yes"/></strong></span>&nbsp;&nbsp;
                    </td>
                </xsl:when>
                <xsl:otherwise>
                    <td class="labelnopa" style="color:#000;">
                        <span class="fondoVerde" style="padding:2px 5px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_historico_sIVA']/node()"/>:</span>
                    </td>    	
                    <td class="valor quince">
                        <span class="fondoVerde" style="padding:2px 5px;"><strong><xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_PRECIOREFERENCIA" disable-output-escaping="yes"/></strong></span>&nbsp;&nbsp;
                    </td>     
                </xsl:otherwise>  
                </xsl:choose>
                
                    <td class="label quince"><xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/>:</td>    	
                    <td class="valor quince">&nbsp;<xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_UNIDADBASICA" disable-output-escaping="yes"/></td>
                    
                    <td class="label doce"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/>:</td>    	
                    <td class="valor">&nbsp;<xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_CANTIDAD" disable-output-escaping="yes"/></td>
                </tr>
                <!--precio objetivo + fecha modif-->
                <tr>
                <xsl:choose>
                <xsl:when test="PRODUCTOLICITACION/MOSTRAR_PRECIO_IVA">
                    <td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_objetivo_cIVA']/node()"/>:</td>    	
                    <td class="valor">
                    <xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_PRECIOOBJETIVOIVA" disable-output-escaping="yes"/>&nbsp;&nbsp;
                    <!--<xsl:if test="PRODUCTOLICITACION/IDPAIS != '55'">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='iva']/node()"/>:&nbsp;
                        <xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_TIPOIVA"/>%     
                    </xsl:if>  -->             
                    </td>
                </xsl:when>
                <xsl:otherwise>
                    <td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='precio_objetivo_sIVA']/node()"/>:</td>    	
                    <td class="valor"><xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_PRECIOOBJETIVO" disable-output-escaping="yes"/>&nbsp;&nbsp;
                    </td>            
                </xsl:otherwise>
                </xsl:choose>
                
                <!--consumo-->
                <xsl:choose>
                <xsl:when test="PRODUCTOLICITACION/MOSTRAR_PRECIO_IVA">
                    <td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_cIVA']/node()"/>:</td>    	
                    <td class="valor" colspan="3">&nbsp;<xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_CONSUMOIVA" disable-output-escaping="yes"/></td> 
                </xsl:when>
                <xsl:otherwise>
                    <td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='consumo_sIVA']/node()"/>:</td>    	
                    <td class="valor" colspan="3">&nbsp;<xsl:value-of select="PRODUCTOLICITACION/LIC_PROD_CONSUMO" disable-output-escaping="yes"/></td>
                </xsl:otherwise>
                </xsl:choose> 
                   
                </tr>
                
                             
            </tbody>
            </table>
            </div><!--fin de divleft-->
	</div><!-- FIN divLeft Tabla Datos Clientes -->
        
        
	<!-- Tabla Datos Ofertas -->
        <div class="divLeft" style="margin-top:10px;">
        
		<table class="infoTable" id="lDatosOfertas" border="1">
                  
		<thead>
			<tr class="subtituloTabla">
				<td class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_oferta']/node()"/></td>
				<td class="dies" style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></td>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/></td>
				<td class="dos">&nbsp;</td>
				<td style="text-align:left;"><xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion_oferta']/node()"/></td>
				<td class="siete"><xsl:value-of select="document($doc)/translation/texts/item[@name='lic_marca']/node()"/></td>
				<td class="siete"><xsl:copy-of select="document($doc)/translation/texts/item[@name='ud_por_lote_2line']/node()"/></td>
			<xsl:if test="not(PRODUCTOLICITACION/MOSTRAR_PRECIO_IVA)">
				<td class="dos">&nbsp;</td>
				<td class="siete"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_2line']/node()"/></td>
			</xsl:if>
				<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='cantidad']/node()"/></td>
			<xsl:if test="not(PRODUCTOLICITACION/MOSTRAR_PRECIO_IVA)">
				<td class="siete"><xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_sIVA_2line']/node()"/></td>
			</xsl:if>
			<xsl:if test="PRODUCTOLICITACION/IDPAIS != '55'">
				<td class="dos"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_iva']/node()"/></td>
			</xsl:if>
			<xsl:if test="PRODUCTOLICITACION/MOSTRAR_PRECIO_IVA">
				<td class="dos">&nbsp;</td>
				<td class="siete"><xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_cIVA_2line']/node()"/></td>
				<td class="siete"><xsl:copy-of select="document($doc)/translation/texts/item[@name='consumo_cIVA_2line']/node()"/></td>
			</xsl:if>
				<td class="doce"><xsl:value-of select="document($doc)/translation/texts/item[@name='estado_evaluacion']/node()"/></td>
                                <td class="tres">&nbsp;</td>
			</tr>
		</thead>
		<tbody>
		<xsl:choose>
		<xsl:when test="PRODUCTOLICITACION/OFERTAS/OFERTA">
		<xsl:for-each select="PRODUCTOLICITACION/OFERTAS/OFERTA">
                    
                    <xsl:variable name="precio"> 
                    <xsl:choose>
                        <xsl:when test="not(//PRODUCTOLICITACION/MOSTRAR_PRECIO_IVA)"><xsl:value-of select="LIC_OFE_PRECIO" /></xsl:when>
                        <xsl:otherwise><xsl:value-of select="LIC_OFE_PRECIOIVA" /></xsl:otherwise>
                    </xsl:choose>
                    </xsl:variable>
                    
                    <xsl:value-of select="$precio" />
                    
                    <xsl:sort select="$precio" order="descending" />
                   
			<tr>
				<td>
				<xsl:choose>
				<xsl:when test="LIC_OFE_FECHAMODIFICACION != ''">
					<xsl:value-of select="LIC_OFE_FECHAMODIFICACION"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="LIC_OFE_FECHAALTA"/>
				</xsl:otherwise>
				</xsl:choose>
                                </td>
				<td style="text-align:left;"><xsl:value-of select="PROVEEDOR"/></td>

			<xsl:choose>
			<xsl:when test="LIC_OFE_PRECIOIVA = '0,0000' and LIC_OFE_UNIDADESPORLOTE = '0,00'">
				<td style="text-align:center;">
					<xsl:attribute name="colspan">
						<xsl:choose>
						<xsl:when test="//PRODUCTOLICITACION/IDPAIS != '55'">12</xsl:when>
						<xsl:otherwise>11</xsl:otherwise>
						</xsl:choose>
                                        </xsl:attribute>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_no_ofertada']/node()"/>
				</td>
			</xsl:when>
			<xsl:otherwise>
				<td><a href="javascript:FichaProductoOfe('{//PRODUCTOLICITACION/LIC_PROD_ID}','{LIC_OFE_ID}');"><xsl:value-of select="LIC_OFE_REFERENCIA"/></a></td>
				<td>
				<xsl:if test="FICHA_TECNICA/ID">
					<a href="http://www.newco.dev.br/Documentos/{FICHA_TECNICA/URL}" target="_blank">
						<img src="http://www.newco.dev.br/images/fichaChange.gif">
							<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='ficha_tecnica']/node()"/></xsl:attribute>
						</img>
					</a>
				</xsl:if>
				</td>
                                <td class="datosLeft">
                                    <strong><xsl:value-of select="LIC_OFE_NOMBRE"/></strong></td>
				<td><xsl:value-of select="LIC_OFE_MARCA"/></td>
				<td><xsl:value-of select="LIC_OFE_UNIDADESPORLOTE"/></td>
			<xsl:if test="not(//PRODUCTOLICITACION/MOSTRAR_PRECIO_IVA)">
				<!-- checkbox o marca adjudicacion -->
				<td>
					<xsl:choose>
					<xsl:when test="//PRODUCTOLICITACION/LIC_PORPRODUCTO = 'N'">
						<xsl:if test="LIC_OFE_ADJUDICADA = 'S' and //PRODUCTOLICITACION/LIC_IDESTADOLICITACION != 'CURS' and //PRODUCTOLICITACION/LIC_IDESTADOLICITACION != 'INF'">
							<img src="http://www.newco.dev.br/images/check.gif">
								<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()"/></xsl:attribute>
								<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()"/></xsl:attribute>
							</img>
						</xsl:if>
                                        </xsl:when>
					<xsl:when test="//PRODUCTOLICITACION/LIC_PORPRODUCTO = 'S' and not(//PRODUCTOLICITACION/AUTOR)">
						<xsl:if test="LIC_OFE_ADJUDICADA = 'S' and //PRODUCTOLICITACION/LIC_IDESTADOLICITACION != 'CURS' and //PRODUCTOLICITACION/LIC_IDESTADOLICITACION != 'INF'">
							<img src="http://www.newco.dev.br/images/check.gif">
								<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()"/></xsl:attribute>
								<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()"/></xsl:attribute>
							</img>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
						<xsl:when test="//PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'CURS' or //PRODUCTOLICITACION/LIC_IDESTADOLICITACION = 'INF'">
							<input type="radio" name="RADIO_{../../LIC_PROD_ID}" class="RADIO_{../../LIC_PROD_ID}" value="{LIC_OFE_ID}">
								<xsl:if test="LIC_OFE_ADJUDICADA = 'S'">
									<xsl:attribute name="checked">checked</xsl:attribute>
								</xsl:if>
							</input>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="LIC_OFE_ADJUDICADA = 'S'">
								<img src="http://www.newco.dev.br/images/check.gif">
									<xsl:attribute name="alt"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()"/></xsl:attribute>
									<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='oferta_adjudicada']/node()"/></xsl:attribute>
								</img>
							</xsl:if>
						</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
                                        </xsl:choose>
				</td>
				<!--valor de precio-->
				<td id="PrOf_{LIC_OFE_ID}" class="PrecioOferta">
                                        <xsl:choose>
					<xsl:when test="IGUAL"><span style="color:orange;font-weight:bold;"><xsl:value-of select="LIC_OFE_PRECIO"/></span>&nbsp;</xsl:when>
					<xsl:when test="SUPERIOR"><span style="color:red;font-weight:bold;"><xsl:value-of select="LIC_OFE_PRECIO"/></span>&nbsp;</xsl:when>
					<xsl:otherwise><span style="color:green;font-weight:bold;"><xsl:value-of select="LIC_OFE_PRECIO"/></span>&nbsp;</xsl:otherwise>
					</xsl:choose>
				</td>
			</xsl:if>
				<td><xsl:value-of select="LIC_OFE_CANTIDAD"/></td>
			<xsl:if test="not(//PRODUCTOLICITACION/MOSTRAR_PRECIO_IVA)">
				<td>
					<xsl:value-of select="LIC_OFE_CONSUMO"/>
				</td>
			</xsl:if>
			<xsl:if test="//PRODUCTOLICITACION/IDPAIS != '55'">
				<td><xsl:value-of select="LIC_OFE_TIPOIVA"/>%</td>
			</xsl:if>
			<xsl:if test="//PRODUCTOLICITACION/MOSTRAR_PRECIO_IVA">
				<!-- checkbox o marca adjudicacion -->
				<td>

				</td>
				<!--valor de precio-->
				<td id="PrOf_{LIC_OFE_ID}" class="PrecioOferta">
                                        <xsl:choose>
					<xsl:when test="IGUAL"><span style="color:orange;font-weight:bold;"><xsl:value-of select="LIC_OFE_PRECIOIVA"/></span>&nbsp;</xsl:when>
					<xsl:when test="SUPERIOR"><span style="color:red;font-weight:bold;"><xsl:value-of select="LIC_OFE_PRECIOIVA"/></span>&nbsp;</xsl:when>
					<xsl:otherwise><span style="color:green;font-weight:bold;"><xsl:value-of select="LIC_OFE_PRECIOIVA"/></span>&nbsp;</xsl:otherwise>
					</xsl:choose>
				</td>
				<td><xsl:value-of select="LIC_OFE_CONSUMOIVA"/></td>
			</xsl:if>
			<xsl:choose>
			<xsl:when test="//PRODUCTOLICITACION/LIC_IDESTADOLICITACION ='CURS' or //PRODUCTOLICITACION/LIC_IDESTADOLICITACION ='INF'">
				<td>
					<select name="LIC_OFE_IDESTADOEVALUACION_{LIC_OFE_ID}" id="IDESTADO_{LIC_OFE_ID}" class="select100">							
					<xsl:for-each select="ESTADOSEVALUACION/field/dropDownList/listElem">
						<option value="{ID}">
							<xsl:if test="ID = ../../@current">
								<xsl:attribute name="selected">selected</xsl:attribute>
							</xsl:if>
							<xsl:value-of select="listItem"/>
						</option>
					</xsl:for-each>
					</select>&nbsp;
					<a href="javascript:CambiarEstadoOferta({LIC_OFE_ID});"><img src="http://www.newco.dev.br/images/actualizarFlecha.gif"/></a>
				</td>
			</xsl:when>
			<xsl:otherwise>
				<td><xsl:value-of select="ESTADOEVALUACION"/></td>
			</xsl:otherwise>
			</xsl:choose>
                            
                            <td><!--solicitar evaluacion-->
                             <xsl:if test="LIC_OFE_PRECIOIVA != '0,0000' and LIC_OFE_UNIDADESPORLOTE != '0,00'">
                                    <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/NuevaEvaluacionProducto.xsql?PRO_ID={LIC_PROD_ID}&amp;LIC_OFE_ID={LIC_OFE_ID}','Evaluación producto',100,80,0,-10);">
                                        <xsl:choose>
                                        <xsl:when test="//PRODUCTOLICITACION/IDPAIS != '55'"><img src="http://www.newco.dev.br/images/evaluar.gif" alt="Evaluar"/></xsl:when>
                                        <xsl:otherwise><img src="http://www.newco.dev.br/images/evaluar-BR.gif" alt="Avaliaçaõ"/></xsl:otherwise>
                                        </xsl:choose>
                                    </a>
                             </xsl:if>
                            </td>	
                            
			</xsl:otherwise>
			</xsl:choose>
			</tr>
		</xsl:for-each>
		</xsl:when>
		<xsl:otherwise>
			<tr>
				<td align="center">
					<xsl:attribute name="colspan">
						<xsl:choose>
						<xsl:when test="//PRODUCTOLICITACION/IDPAIS != '55'">14</xsl:when>
						<xsl:otherwise>13</xsl:otherwise>
						</xsl:choose>
                                        </xsl:attribute>
					<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='licitacion_sin_ofertas']/node()"/></strong>
				</td>
                        </tr>
		</xsl:otherwise>
		</xsl:choose>
		</tbody>
		</table><!-- FIN Tabla Datos Ofertas -->
		</div><!--fin divLeft datos Ofertas-->

		<div class="divLeft" style="margin-top:20px">
		<table class="infoTable">
			<tr>
				<td class="dos">&nbsp;</td>
				<td class="quince"></td>
				<td class="cinco">&nbsp;</td>
				<td class="quince"></td>
				<td class="cinco">&nbsp;</td>
				<td class="quince">
				<xsl:if test="//PRODUCTOLICITACION/AUTOR">
					<div id="botonGuardarSelec" class="botonLargo">
						<a href="javascript:GuardarProductoSel({//LIC_PROD_ID})"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
					</div>
				</xsl:if>
				</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		</div><!--fin de divLeft-->

        <div class="divLeft" style="margin-top:20px">
		<table class="infoTable" border="0">
		<tfoot>
			<tr class="lejenda lineBorderBottom3" style="background:#E4E4E5;padding-top:3px;font-weight:bold;">
				<td colspan="4" class="datosLeft" style="padding:3px 0px 0px 20px;"><xsl:value-of select="document($doc)/translation/texts/item[@name='leyenda']/node()"/>:</td>
			</tr>
                        
                        <tr class="lineBorderBottom5">
			<td class="tres">&nbsp;</td>
                        <td class="trenta datosLeft">
				<p>
					&nbsp;&nbsp;&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/actualizarFlecha.gif" border="0"/>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizar_evaluacion_producto']/node()"/><br/>
					&nbsp;&nbsp;&nbsp;&nbsp;<span style="background-color:#FFFF99;height:3px;width:10px;">&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='mejor_precio']/node()"/><br/>
				</p>
			</td>
			<td class="trenta datosLeft">
				<p>
					&nbsp;<span style="color:orange;font-weight:bold;height:3px;">1,0000</span>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_igual']/node()"/><br/>
					&nbsp;<span style="color:red;font-weight:bold;height:3px;">1,0000</span>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_superior']/node()"/><br/>
					&nbsp;<span style="color:green;font-weight:bold;height:3px;">1,0000</span>&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='precio_inferior']/node()"/><br/>
				</p>
			</td>
			<td>&nbsp;</td>
                        </tr>
			
			
		</tfoot>
		</table>
                 <br /><br />
                </div>

	</xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
