<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	COmpromiso de adquirir productos en MedicalVM				
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:template match="/">
    <html>
      <head>
      
	<title><xsl:value-of select="TITULO" disable-output-escaping="yes"/></title>
     <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  
     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/compromiso_031212.js"></script>
	  </head>
      <body>      
        <xsl:choose>
      	<!-- ET Desactivado control errores: Habra que reactivarlo
          <xsl:when test="ListaDerechosUsuarios/xsql-error">
            <xsl:apply-templates select="ListaDerechosUsuarios/xsql-error"/>          
          </xsl:when>
	-->
        <xsl:when test="FamiliasYProductos/SESION_CADUCADA">
          <xsl:apply-templates select="FamiliasYProductos/SESION_CADUCADA"/> 
        </xsl:when>
        <xsl:when test="FamiliasYProductos/ROWSET/ROW/Sorry">
          <xsl:apply-templates select="FamiliasYProductos/ROWSET/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
        
        
         <!--idioma-->
        <xsl:variable name="lang">
        	<xsl:value-of select="/FamiliasYProductos/LANG" />
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
        
        <!--
          miramos si hay datos devueltos    
        
        <xsl:choose>
        	<xsl:when test="not(FamiliasYProductos/INICIO/LISTADO_FAMILIAS_Y_PRODUCTOS/FAMILIA)">
        		<div class="titlePage">
                	<xsl:value-of select="document($doc)/translation/texts/item[@name='busqueda_sin_resultados']/node()"/>
        		</div>
        	</xsl:when>
        	<xsl:otherwise>
        -->
            
  <form name="formCompromiso" action="Compromiso.xsql" method="post">
	<input type="hidden" name="PRODUCTO" value="{/FamiliasYProductos/INICIO/LISTADO_FAMILIAS_Y_PRODUCTOS/FPRODUCTO}"/>  
	<input type="hidden" name="IDFAMILIA" value="{/FamiliasYProductos/INICIO/LISTADO_FAMILIAS_Y_PRODUCTOS/FIDFAMILIA}"/>  
	<input type="hidden" name="IDSUBFAMILIA" value="{/FamiliasYProductos/INICIO/LISTADO_FAMILIAS_Y_PRODUCTOS/FIDSUBFAMILIA}"/>  
	<input type="hidden" name="IDPROVEEDOR" value="{/FamiliasYProductos/INICIO/LISTADO_FAMILIAS_Y_PRODUCTOS/IDPROVEEDOR}"/>  
	<table class="grandeInicio" border="0"> 
	<thead>
    <tr class="tituloTabla">
    	<th>&nbsp;</th>
		<th colspan="3">
        	<xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo_privado_listado']/node()"/>
			<xsl:if test="/FamiliasYProductos/INICIO/QUITARSELECCION">	
				<!--	usuario	-->
				:&nbsp;
				<xsl:call-template name="desplegable">
        			<xsl:with-param name="path" select="/FamiliasYProductos/INICIO/FIDCENTROCONSULTA/field">
        			</xsl:with-param>
                    <xsl:with-param name="onChange">javascript:Enviar();</xsl:with-param>
      			</xsl:call-template>
			</xsl:if>
            <!--<xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
            <span class="importante">
            	<a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Compras/Multioferta/ListaProductos.xsql?GRUPOPRODUCTOS=BRAUNAESCULAP&amp;FIDProveedor=2058','Catalogo',70,70,0,-50);">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo_especializado']/node()"/>
            </a>	
            </span>		-->
        </th>
		<th><a href="javascript:window.print();" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/imprimir.gif" alt="Imprimir" title="Imprimir" /></a>&nbsp;<a href="javascript:window.print();"><xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/></a></th>
        
      </tr>
      <tr class="noChange" height="20px;">
        <td class="tres">&nbsp;</td>
        <td class="veinte">&nbsp;</td>
      	<td align="center" class="cinquenta">
			<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='resultados']/node()"/>:&nbsp;
			<xsl:value-of select="/FamiliasYProductos/INICIO/LISTADO_FAMILIAS_Y_PRODUCTOS/TOTAL_FAMILIAS"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='familias']/node()"/>,&nbsp;
			<xsl:value-of select="/FamiliasYProductos/INICIO/LISTADO_FAMILIAS_Y_PRODUCTOS/TOTAL_SUBFAMILIAS"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='subfamilias']/node()"/>,&nbsp;
			<xsl:value-of select="/FamiliasYProductos/INICIO/LISTADO_FAMILIAS_Y_PRODUCTOS/TOTAL_PRODUCTOSESTANDAR"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='productos']/node()"/>
			</strong>
       </td>
       <td class="veinte">   
            <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
            <span class="importante">
            <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Compras/Multioferta/ListaProductos.xsql?GRUPOPRODUCTOS=BRAUNAESCULAP&amp;IDProveedor=2230&amp;TITULO=BRAUNAESCULAP','Catalogo',90,90,0,-50);">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo_especializado']/node()"/>
            </a>	
            </span>		
        </td>
        <td>&nbsp;</td>
      </tr>  
      <tr class="noChange" height="20px;">
        <td colspan="2">&nbsp;</td>
      	<td>  
			<p style="text-align:center;">Para solicitar un producto no incluido en esta lista rogamos envíe un email a 
			<a href="mailto:cdc@medicalvm.com?subject=[MVM] Solicitud de nuevo producto para centro FNCP">cdc@medicalvm.com</a></p>  
		</td>
        <td colspan="2">&nbsp;</td>
		</tr>   
      </thead>
      </table><!--fin de primer trozo, mas facil mantener-->
      
      <table class="grandeInicio"> 
		<thead>       
		<tr class="titulos">
        	<xsl:choose>
            	<!--si resumen compromiso no margin lateral sx-->
				<xsl:when test="/FamiliasYProductos/INICIO/LISTADO_FAMILIAS_Y_PRODUCTOS/RESUMENCOMPROMISOS">
        			<td class="uno">&nbsp;</td>
                </xsl:when>
                <xsl:otherwise>
                	<td class="dies">&nbsp;</td>
                </xsl:otherwise>
            </xsl:choose>
        		<td class="ocho textLeft">&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Ref']/node()"/>.</td>
                <td class="textLeft trentacinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/><br/>
					<!--<input type="text" size="20" maxlength="20" name="FPRODUCTO" value="{/FamiliasYProductos/INICIO/LISTADO_FAMILIAS_Y_PRODUCTOS/FPRODUCTO}"/>-->
				</td>
                <!--<td class="veinte textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></td>-->
                 <td class="ocho">
                	<xsl:copy-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/><br/>
					<!--	5nov12	Ocultamos desplegable proveedor	
					<xsl:call-template name="desplegable">
        				<xsl:with-param name="path" select="/FamiliasYProductos/INICIO/LISTADO_FAMILIAS_Y_PRODUCTOS/FIDPROVEEDOR/field">
        				</xsl:with-param>
      				</xsl:call-template>-->
                </td>
                <td class="ocho">
                	<xsl:copy-of select="document($doc)/translation/texts/item[@name='ref_prov']/node()"/>
                </td>
                <td class="ocho">
                	<xsl:copy-of select="document($doc)/translation/texts/item[@name='marca']/node()"/>
                </td>
                <td class="quince">
                	<xsl:copy-of select="document($doc)/translation/texts/item[@name='unidad_basica_2line']/node()"/>
                </td>
                <td class="siete">
                	<xsl:choose>
                    <xsl:when test="/FamiliasYProductos/INICIO/LISTADO_FAMILIAS_Y_PRODUCTOS/PRECIO_SIN_COMISION">
                    	<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_proveedor_c_iva_2line']/node()"/>)
                    </xsl:when>
                    <xsl:otherwise>
                		<xsl:copy-of select="document($doc)/translation/texts/item[@name='precio_final_iva_incl']/node()"/>
                    </xsl:otherwise>
                    </xsl:choose>
                </td>
				<xsl:choose>
				<xsl:when test="/FamiliasYProductos/INICIO/LISTADO_FAMILIAS_Y_PRODUCTOS/RESUMENCOMPROMISOS">
					<!--	Resumen de compromiso	-->
					<xsl:for-each select="/FamiliasYProductos/INICIO/LISTADO_FAMILIAS_Y_PRODUCTOS/CENTROS/CENTRO">
                    	<xsl:if test="NOMBRECORTO != ''">
						<td class="cinco" style="border-right:1px solid #ccc;">
							&nbsp;<xsl:value-of select="NOMBRECORTO"/>&nbsp;
						</td>
                        </xsl:if>
					</xsl:for-each>
				</xsl:when>
        		<xsl:otherwise>
					<td class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='compromiso']/node()"/><br/>
                		<xsl:choose>
						<xsl:when test="/FamiliasYProductos/INICIO/SELECCION='S'">
                			<input type="checkbox" name="FSELECCION" checked="true" />
						</xsl:when>
                		<xsl:otherwise>
                			<input type="checkbox" name="FSELECCION" onclick="verBoton('SEL');" />
                		</xsl:otherwise>
                		</xsl:choose>
					</td>
                    <td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='quitar_seleccion']/node()"/></td>
                	<!--<xsl:choose>
					<xsl:when test="/FamiliasYProductos/INICIO/QUITARSELECCION">
                		<td class="cinco"><xsl:copy-of select="document($doc)/translation/texts/item[@name='quitar_seleccion']/node()"/></td>
					</xsl:when>
                	<xsl:otherwise>
                		<td class="uno">&nbsp;</td>
                	</xsl:otherwise>
                	</xsl:choose>-->
                	<td class="uno">&nbsp;</td>
        		</xsl:otherwise>
				</xsl:choose>
                <xsl:choose>
            	<!--si resumen compromiso no boton buscar-->
				<xsl:when test="/FamiliasYProductos/INICIO/LISTADO_FAMILIAS_Y_PRODUCTOS/RESUMENCOMPROMISOS">
                <td class="uno">&nbsp;</td>
                </xsl:when>
                <xsl:otherwise>
                <td class="doce">
                	<div class="botonLargo">
						&nbsp;<a href="javascript:Enviar();" style="text-decoration:none;"><xsl:copy-of select="document($doc)/translation/texts/item[@name='buscar']/node()"/></a>&nbsp;
                	</div>
				</td>
                </xsl:otherwise>
                </xsl:choose>
                <td colspan="4">&nbsp;</td>
			</tr>		
     </thead>  
     <tbody>
 			<input type="hidden" name="ACCION"/>
			<input type="hidden" name="PARAMETROS"/>
   			<xsl:for-each select="FamiliasYProductos/INICIO/LISTADO_FAMILIAS_Y_PRODUCTOS/FAMILIA">
				<tr class="familia noChange">
				<td>&nbsp;</td>
				<td>
				 	&nbsp;&nbsp;&nbsp;<strong><xsl:value-of select="REFERENCIA"/></strong>
				</td>
				<td colspan="7">
					<xsl:value-of select="NOMBRE"/>
				</td>
    			<td>&nbsp;</td>
					<xsl:choose>
					<xsl:when test="/FamiliasYProductos/INICIO/LISTADO_FAMILIAS_Y_PRODUCTOS/RESUMENCOMPROMISOS">
                    	<td colspan="{/FamiliasYProductos/INICIO/LISTADO_FAMILIAS_Y_PRODUCTOS/CENTROS/TOTAL}">&nbsp;</td>
					</xsl:when>
                	<xsl:otherwise>
                    	<td colspan="5">&nbsp;</td>
        			</xsl:otherwise>
					</xsl:choose>
                    <td>&nbsp;</td>
				</tr>
				<xsl:for-each select="./SUBFAMILIA">
      				<tr class="subFamilia noChange">
                        <td>&nbsp;</td>
      					<td> 
      					    &nbsp;&nbsp;&nbsp;<xsl:value-of select="REFERENCIA"/>
      					</td>
      					<td colspan="6">
      					    <xsl:value-of select="NOMBRE"/>
                            <xsl:if test="/FamiliasYProductos/INICIO/LISTADO_FAMILIAS_Y_PRODUCTOS/ADMIN_CDC">
							&nbsp;&nbsp;&nbsp;[<xsl:value-of select="document($doc)/translation/texts/item[@name='ultima_ref_utilizada']/node()"/>: <xsl:value-of select="REFESTANDARMAX"/>]
							</xsl:if>
      					</td>
      					<td align="center">
							<xsl:if test="/FamiliasYProductos/INICIO/LISTADO_FAMILIAS_Y_PRODUCTOS/LISTADOCENTRO">
      					    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:MarcarSubfamilia({ID});" style="text-decoration:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></a>
							</xsl:if>
      					</td>
                      	<td>
						<xsl:if test="/FamiliasYProductos/INICIO/QUITARSELECCION and /FamiliasYProductos/INICIO/LISTADO_FAMILIAS_Y_PRODUCTOS/LISTADOCENTRO">
							<xsl:if test="HAYCOMPROMISOS">
      					    	&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:MarcarSubfamiliaQuitar({ID});" style="text-decoration:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></a>
							</xsl:if>
						</xsl:if>
						</td>
                        <!--pagina compromiso resumen centros-->
						<xsl:choose>
						<xsl:when test="/FamiliasYProductos/INICIO/LISTADO_FAMILIAS_Y_PRODUCTOS/RESUMENCOMPROMISOS">
                       		<td colspan="{/FamiliasYProductos/INICIO/LISTADO_FAMILIAS_Y_PRODUCTOS/CENTROS/TOTAL}">&nbsp;</td>
						</xsl:when>
                		<xsl:otherwise>
                       		<td colspan="5">&nbsp;</td>
        				</xsl:otherwise>
						</xsl:choose>
                         <td>&nbsp;</td>
					</tr>
      				<xsl:for-each select="./PRODUCTOESTANDAR">
                    	<xsl:sort select="NOMBRE" order="ascending"/>
                    	
                		<tr>
                        <!--<xsl:attribute name="class">
								<xsl:if test="COMPROMISO">azul</xsl:if>
							</xsl:attribute>-->
                            <td>&nbsp;</td>
                			<td class="textLeft">
                    			&nbsp;&nbsp;&nbsp;<strong><xsl:value-of select="REFERENCIA"/></strong>
                    		</td>
                    		<td class="textLeft">
	                    		<strong><xsl:value-of select="NOMBRE"/></strong>							
                			</td>
							<!--proveedor-->
                            <td><xsl:value-of select="PROVEEDOR/NOMBRE"/>&nbsp;</td>
                            <!--ref prove-->
                            <td><xsl:value-of select="PROVEEDOR/REFERENCIA"/>&nbsp;</td>
                              <!--marca-->
                            <td><xsl:value-of select="MARCA"/>&nbsp;</td>
                            <!--ud basica-->
                            <td><xsl:value-of select="PROVEEDOR/UNIDADBASICA"/>&nbsp;</td>
                            <!--precio-->
                    		<td>
                            	<xsl:choose>
                                <xsl:when test="/FamiliasYProductos/INICIO/LISTADO_FAMILIAS_Y_PRODUCTOS/PRECIO_SIN_COMISION">
                                    <xsl:value-of select="PROVEEDOR/PRECIOACTUAL_IVA"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="PROVEEDOR/COSTE_TOTAL"/>
                                </xsl:otherwise>
                                </xsl:choose>
                            &nbsp;
                            </td>
							<xsl:choose>
				        	<xsl:when test="/FamiliasYProductos/INICIO/LISTADO_FAMILIAS_Y_PRODUCTOS/RESUMENCOMPROMISOS">
								<!--	Resumen de compromiso	-->
								<xsl:for-each select="./COMPROMISOS/COMP">
									<td>
                                    <xsl:attribute name="style">
                            		<xsl:choose>
                                	<xsl:when test=".='S'">background:#D5DFF7</xsl:when>
                                	</xsl:choose>
									</xsl:attribute>
                            		<xsl:choose>
                                	<xsl:when test=".='S'">
                                    	<strong>S</strong>
                                	</xsl:when>
                                	<xsl:otherwise>
										.
                                	</xsl:otherwise>
                                	</xsl:choose>
									</td>
								</xsl:for-each>
							</xsl:when>
        					<xsl:otherwise>
								<!--	Seleccionado un centro, mostramos compromiso	-->	
								<td align="center">
								<xsl:choose>
				        		<xsl:when test="COMPROMISO">	
									<input type="checkbox" name="CK-BLOQUEADO_{ID}" checked="true" disabled="true" />
       							</xsl:when>
        						<xsl:otherwise>
									<input type="checkbox" name="CK-COMPROMISO_{ID}_{../ID}" onclick="verBoton('SEL');" />
        						</xsl:otherwise>
								</xsl:choose>
								</td>
                            	<td>
                                <xsl:choose>
				        			<xsl:when test="COMPROMISO">	
										<input type="checkbox" name="CK-QUITARCOMPROMISO_{ID}_{../ID}" onclick="verBoton('QUITAR');" />
       								</xsl:when>
        							<xsl:otherwise>
										&nbsp;
        							</xsl:otherwise>
									</xsl:choose>
                                    <!--
 								<xsl:if test="/FamiliasYProductos/INICIO/QUITARSELECCION">

									<xsl:choose>
				        			<xsl:when test="COMPROMISO">	
										<input type="checkbox" name="CK-QUITARCOMPROMISO_{ID}_{../ID}" />
       								</xsl:when>
        							<xsl:otherwise>
										&nbsp;
        							</xsl:otherwise>
									</xsl:choose>

								</xsl:if>-->
                            	</td>
                            	<td colspan="3">&nbsp;</td>
                            	
							</xsl:otherwise>
							</xsl:choose>
                            <td colspan="4">&nbsp;</td>
               			</tr>                							
					</xsl:for-each><!--Prod estandar-->
				</xsl:for-each><!--Subfamilia-->
			</xsl:for-each><!--Familia-->
             </tbody>
        	<xsl:choose>
			<xsl:when test="not(FamiliasYProductos/INICIO/LISTADO_FAMILIAS_Y_PRODUCTOS/FAMILIA)">
            <tfoot>
        		<tr class="lejenda">
					<td colspan="21">&nbsp;</td>
				</tr>
                <tr class="lejenda">
					<td colspan="21" align="center">
                		<p style="text-align:center"><xsl:value-of select="document($doc)/translation/texts/item[@name='busqueda_sin_resultados']/node()"/></p>
					</td>
				</tr>
            </tfoot>
       		</xsl:when>
        	<xsl:otherwise>
				<xsl:if test="/FamiliasYProductos/INICIO/LISTADO_FAMILIAS_Y_PRODUCTOS/LISTADOCENTRO">
            		<tfoot>
            		<tr>
            			<td colspan="4">&nbsp;</td>
                        <td colspan="3" valign="top">
                        <div id="comeQuitarCompromiso" style="display:none;">
                        	<p><xsl:value-of select="document($doc)/translation/texts/item[@name='informar_motivo']/node()"/>&nbsp;<span class="camposObligatorios">*</span>
                            &nbsp;<textarea type="text" name="COMENTARIOS" rows="2" cols="50" style="border:1px solid #4e6ba5;"/></p>
                        </div><!--fin de comeQuitarCompromiso-->
                        </td>
                		<td align="center" valign="top" colspan="4">
                		<div class="botonCenterAzul" id="botonConfirmarCompromiso" style="display:none;">
							<a href="javascript:ConfirmarCompromiso();" style="text-decoration:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='confirmar_compromiso']/node()"/></a>
                		</div>
                        
                        
                          <div id="botonQuitarCompromiso" style="display:none;">
                            <div class="botonCenterAzul">
								<a href="javascript:QuitarCompromisos();" style="text-decoration:none;"><xsl:value-of select="document($doc)/translation/texts/item[@name='quitar_seleccion']/node()"/></a>
                			</div>
                        </div><!--fin de botonQuitarSelecion-->
                        
						</td>
                        <td colspan="2">&nbsp;</td>
                		
            		</tr>
            		</tfoot>
				</xsl:if>
  			</xsl:otherwise>
  			</xsl:choose>
      
  </table><!--fin de grandeInicio--> 
  </form>
  <br /><br />
<!--
  </xsl:otherwise>
  </xsl:choose>-->
  
  </xsl:otherwise>
  </xsl:choose>
      </body>
    </html>
  </xsl:template>  
</xsl:stylesheet>
