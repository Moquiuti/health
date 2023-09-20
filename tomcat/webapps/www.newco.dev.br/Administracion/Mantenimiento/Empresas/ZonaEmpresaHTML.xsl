<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Margen izquierdo del mantenimiento de empresas
	ultima revision: 29mar22 11:00 ZonaEmpresa_190420.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
      
      <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  
      
      <!--idioma-->
        <xsl:variable name="lang">
            <xsl:value-of select="/ZonaEmpresa/LANG"/>
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
        <!--idioma fin-->

		<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/ZonaEmpresa_190420.js"></script>
		<script type="text/javascript">
		var usuarioAdministrador=<xsl:value-of select="ZonaEmpresa/AREAEMPRESA/IDUSUARIO"/>;
	    var usuarioGerente='<xsl:if test="not(/ZonaEmpresa/AREAEMPRESA/CENTROS/EDICION)"><xsl:value-of select="/ZonaEmpresa/AREAEMPRESA/CENTROS/field/@current"/></xsl:if>';
        
        var msgSinCentro='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgSinCentro']/node()"/>';
        var msgSinEmpresa='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgSinEmpresa']/node()"/>';
        var msgBorrarEmpresa='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgBorrarEmpresa']/node()"/>';
		var msgBorrarCentro='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgBorrarCentro']/node()"/>';
		var msgBorrarUsuario='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgBorrarUsuario']/node()"/>';
		var msgSinDerechosEmpresa='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgSinDerechosEmpresa']/node()"/>';
        var usuarioConectadoNoEliminar ='<xsl:value-of select="document($doc)/translation/texts/item[@name='usuarioConectadoNoEliminar']/node()"/>';
        var usuarioConPedidos='<xsl:value-of select="document($doc)/translation/texts/item[@name='usuarioConPedidos']/node()"/>';
        var usuarioConPedidosHistoricos='<xsl:value-of select="document($doc)/translation/texts/item[@name='usuarioConPedidosHistoricos']/node()"/>';
        var centroConPedidos='<xsl:value-of select="document($doc)/translation/texts/item[@name='centroConPedidos']/node()"/>';
        var empresaConPedidos='<xsl:value-of select="document($doc)/translation/texts/item[@name='empresaConPedidos']/node()"/>';
        var seguroEliminarUsuario='<xsl:value-of select="document($doc)/translation/texts/item[@name='seguroEliminarUsuario']/node()"/>';
        var seguroEliminarCentro='<xsl:value-of select="document($doc)/translation/texts/item[@name='seguroEliminarCentro']/node()"/>';
        var seguroEliminarEmpresa='<xsl:value-of select="document($doc)/translation/texts/item[@name='seguroEliminarEmpresa']/node()"/>';
        var noEmpresaActiva='<xsl:value-of select="document($doc)/translation/texts/item[@name='noEmpresaActiva']/node()"/>';
        var noEmpresaActivaBorrar='<xsl:value-of select="document($doc)/translation/texts/item[@name='noEmpresaActivaBorrar']/node()"/>';
		
		<xsl:choose>
		  <xsl:when test="ZonaEmpresa/AREAEMPRESA/EMPRESAS/EDICION">
		    var derechosEmpresa=1;
		  </xsl:when>
		  <xsl:otherwise>
		    var derechosEmpresa=0;
		  </xsl:otherwise>
		</xsl:choose>
		</script>
	</head>
	<body class="areaizq">
		<xsl:choose><!-- error -->
		<xsl:when test="//xsql-error">
		 <xsl:apply-templates select="//xsql-error"/>         
		</xsl:when> 
		<xsl:when test="//SESION_CADUCADA">
		<xsl:apply-templates select="//SESION_CADUCADA"/>        
		</xsl:when> 
		<xsl:otherwise>   

			<!--idioma-->                                             
			<xsl:variable name="lang">
			<xsl:choose>   
    			<xsl:when test="/ZonaEmpresa/LANG"><xsl:value-of select="/ZonaEmpresa/LANG" /></xsl:when>
    			<xsl:otherwise>spanish</xsl:otherwise>
			</xsl:choose>       
			</xsl:variable>
			<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
			<!--idioma fin-->
			
			<form action="ZonaEmpresa.xsql" name="Centros" method="POST">
				<input type="hidden" name="ACCION"/>
				<input type="hidden" name="IDUSUARIO" value="{/ZonaEmpresa/AREAEMPRESA/IDUSUARIO}"/>
				<input type="hidden" name="US_ID" value="{ZonaEmpresa/AREAEMPRESA/IDUSUARIO}"/>	

				<input type="hidden" name="IDNUEVOPAIS">
		   			<xsl:attribute name="value"><xsl:value-of select="ZonaEmpresa/AREAEMPRESA/IDPAIS"/>
					</xsl:attribute>
				</input>

				<input type="hidden" name="IDNUEVAEMPRESA">
		   			<xsl:attribute name="value"><xsl:value-of select="ZonaEmpresa/AREAEMPRESA/IDEMPRESA"/>
					</xsl:attribute>
				</input>

				<input type="hidden" name="IDNUEVOCENTRO">
		   			<xsl:attribute name="value"><xsl:value-of select="ZonaEmpresa/AREAEMPRESA/IDCENTRO"/>
					</xsl:attribute>
				</input>

			<table class="areaizq">
				<xsl:choose>
				<xsl:when test="ZonaEmpresa/AREAEMPRESA/PAISES/field">
            	   <tr style="height:40px;background:#F44810;">
                		<th>&nbsp;</th>
                		<th colspan="3">
							<xsl:call-template name="desplegable">
        						<xsl:with-param name="path" select="ZonaEmpresa/AREAEMPRESA/PAISES/field"></xsl:with-param>
                                <xsl:with-param name="claSel">select200</xsl:with-param>
                                <xsl:with-param name="onChange">javascript:CambioPaisActual(this.value);</xsl:with-param>
      				        </xsl:call-template>
                    	</th>
                    	<th>&nbsp;</th>
                	</tr>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="IDPAIS" value="{ZonaEmpresa/AREAEMPRESA/IDPAIS}"/>
				</xsl:otherwise>
				</xsl:choose>
			
			
               <tr height="25px">
                	<th>&nbsp;</th>
                	<th colspan="3">
                    	<a href="javascript:ListadoEmpresas();">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='empresa_maiu']/node()"/>
                        </a>
                    </th>
                    <th>&nbsp;</th>
                </tr>
				<tr align="center" style="height:40px;">
                	<td>&nbsp;</td>
                	<td colspan="3" class="textCenter">
						<xsl:choose>
						<xsl:when test="ZonaEmpresa/AREAEMPRESA/EMPRESAS/field/dropDownList/listElem">
						  <xsl:choose>
				    		<xsl:when test="ZonaEmpresa/AREAEMPRESA/EMPRESAS/EDICION">	
								<xsl:call-template name="desplegable">
        							<xsl:with-param name="path" select="ZonaEmpresa/AREAEMPRESA/EMPRESAS/field"></xsl:with-param>
                                	<xsl:with-param name="claSel">select200</xsl:with-param>
      				        	</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<!--6may21 Simplificamos codigo
      				    	   <xsl:for-each select="ZonaEmpresa/AREAEMPRESA/EMPRESAS/field/dropDownList/listElem">
      				        	 <xsl:if test="ID=../../@current">
      				        	   <xsl:value-of select="listItem"/>
      				        	   <input type="hidden" name="IDEMPRESA">
      				            	 <xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>
      				        	   </input>
      				        	 </xsl:if>
      				    	   </xsl:for-each>-->
							    <input type="hidden" name="IDEMPRESA" value="{ZonaEmpresa/AREAEMPRESA/IDEMPRESA}"/>
      				    	 </xsl:otherwise>
      					   </xsl:choose>
						</xsl:when>
						<xsl:otherwise>
                			<xsl:value-of select="document($doc)/translation/texts/item[@name='no_existen_empresas']/node()"/>
							<input type="hidden" name="IDEMPRESA" value="-1"/>
						</xsl:otherwise>			
						</xsl:choose>
					</td>
                	<td>&nbsp;</td>
                </tr>
				<tr>
                 <td>&nbsp;</td>
	   		 	<xsl:choose>
	   		 	  <xsl:when test="ZonaEmpresa/AREAEMPRESA/EMPRESAS/EDICION">	
						<td>
                        <a href="javascript:NuevaEmpresa();">
                    		<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/>
                   		</a>  
						
						</td>
						<td>
                        <a href="javascript:EditarEmpresa();">
                    		<xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades']/node()"/>
                   		</a>  
						
						</td>
						<td>
						<xsl:if test="ZonaEmpresa/AREAEMPRESA/EMPRESAS/BORRAR">
                        	<a href="javascript:BorrarEmpresa();">
                    			<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>
                   			</a>  
						</xsl:if>	
						</td>
		                   </xsl:when>
		                   <xsl:otherwise>
		                        <td colspan="3" align="center">
									  <a href="javascript:EditarEmpresa();">
                                        <xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades']/node()"/>
                                      </a>  
								</td>
		                   </xsl:otherwise>
		                   </xsl:choose>
                         <td>&nbsp;</td>
					</tr>
					  <tfoot>
                         <tr>
                        <td class="footLeft">&nbsp;</td>
                        <td colspan="3">&nbsp;</td>
                        <td class="footRight">&nbsp;</td>
                        </tr>
                    </tfoot>
			</table><!--fin de tabla empresa-->
			<br/>
            <!--tabla CENTRO-->
			<!--<table class="plantilla">-->
			<table class="areaizq">
			<tr height="25px">
                	<th>&nbsp;</th>
                	<th colspan="3">
                    	<a href="javascript:ListadoCentros();">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='centro_maiu']/node()"/>
                        </a>
                        <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
                        [&nbsp;<a href="javascript:FacturacionEspecial();">
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='Fact_especial']/node()"/>
                        </a>&nbsp;]
                    </th>
                    <th>&nbsp;</th>
                </tr>
                <!--  <tr>
                	<td>&nbsp;</td>
                	<td colspan="3">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>-->
				<tr style="height:40px;">
                <td>&nbsp;</td>
                <td colspan="3" class="textCenter">
				<xsl:choose>
				  <xsl:when test="ZonaEmpresa/AREAEMPRESA/CENTROS/field/dropDownList/listElem">
				    <xsl:choose>
				      <xsl:when test="ZonaEmpresa/AREAEMPRESA/CENTROS/EDICION">				
						<!--<div class="boton" style="margin-left:20px;">
    						<a href="javascript:ListadoCentros();"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_centros']/node()"/></a>
						</div>
						<br/><br />-->
				        <xsl:call-template name="desplegable">
        			          <xsl:with-param name="path" select="ZonaEmpresa/AREAEMPRESA/CENTROS/field"/>
                                          <xsl:with-param name="claSel">select200</xsl:with-param>
      			                </xsl:call-template>
      			              </xsl:when>
      			              <xsl:otherwise>
      			                <xsl:for-each select="ZonaEmpresa/AREAEMPRESA/CENTROS/field/dropDownList/listElem">
      				         <xsl:if test="ID=../../@current">
      				           <xsl:value-of select="listItem"/>
      				           <input type="hidden" name="IDCENTRO">
      				             <xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>
      				           </input>
      				         </xsl:if>
      				       </xsl:for-each>
      			              </xsl:otherwise>
      			            </xsl:choose>
				  </xsl:when>
				  <xsl:otherwise>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='no_existen_centros']/node()"/>
					<input type="hidden" name="IDCENTRO" value="-1"/>
				  </xsl:otherwise>			
				</xsl:choose>
				 <td>&nbsp;</td>
				</td>
                </tr>
                <!-- <tr>
                	<td>&nbsp;</td>
                	<td colspan="3">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>-->
				<tr>
                 <td>&nbsp;</td>
	   		 	  <xsl:choose>
	   		 	    <xsl:when test="ZonaEmpresa/AREAEMPRESA/CENTROS/EDICION">		
						<td>
                        <a href="javascript:NuevoCentro();">
                    		<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
                   		</a>  
						
						</td>
						<td>
                        <a href="javascript:EditarCentro();">
                    		<xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades']/node()"/>
                   		</a>  
						
						</td>
						<td>
 							<xsl:if test="ZonaEmpresa/AREAEMPRESA/EMPRESAS/BORRAR">
                       			<a href="javascript:BorrarCentro();">
                    				<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>
                   				</a>  
							</xsl:if>
						</td>
				    </xsl:when>
				    <xsl:otherwise>
				        <td colspan="3">
                            <a href="javascript:EditarCentro();">
                                <xsl:value-of select="document($doc)/translation/texts/item[@name='propiedades']/node()"/>
                            </a>  
						</td>
				    </xsl:otherwise>
				    </xsl:choose>
                  <td>&nbsp;</td>
					</tr>
					  <tfoot>
                         <tr>
                        <td class="footLeft">&nbsp;</td>
                        <td colspan="3">&nbsp;</td>
                        <td class="footRight">&nbsp;</td>
                        </tr>
                    </tfoot>
			</table><!--fin de tabla CENTRO-->
            <br/>
            <!--USUARIOS DEL CENTRO-->
			<!--<table class="plantilla">-->
			<table class="areaizq" style="border:1px;">
                <tr height="25px">
                 	<th colspan="3">
                    	<a href="javascript:ListaTodosUsuarios();">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_maiu']/node()"/>
                        </a>
                        <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
                        [&nbsp;<a href="javascript:ControlUsuarios();">
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='control']/node()"/>
                        </a>&nbsp;]
                    </th>
                    <th>&nbsp;</th>
                </tr>
                <!--  <tr>
                	<td>&nbsp;</td>
                	<td colspan="3">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>-->
			
               
		   <xsl:choose>
	   		 <xsl:when test="ZonaEmpresa/AREAEMPRESA/USUARIOS/EDICION">	
		          <xsl:choose>
                  <xsl:when test="ZonaEmpresa/AREAEMPRESA/USUARIOS/USUARIO">	
                              
					<!--	Lista de usuarios	-->
          				<xsl:for-each select="ZonaEmpresa/AREAEMPRESA/USUARIOS/USUARIO">
							<tr class="lineBorderBottom">
							     <td colspan="4" class="textLeft noventa">
							    <!--	Link a la ficha del usuario	-->
                                 <xsl:apply-templates select="NOMBRE"/>
								
							  </td>
							  <td class="seis" valign="top">
                              <!--<xsl:value-of select="count(../USUARIO)"/>-->
                              <xsl:if test="count(../USUARIO) &gt; 1">
                                  <!--<a href="javascript:BorrarUsuario('BORRARUSUARIO','{ID}');">-->
                                  <a href="javascript:ComprobarAntesBorrarUsuario('{ID}');">
                                    <img src="/images/2017/trash.png"  style="margin:2px 0px;"/>
                                  </a>
                              </xsl:if>
							  </td>
							</tr>
		  				</xsl:for-each>	    
						<input type="hidden" name="PRODUCTOS" value="CONPRODUCTOS"/>
				</xsl:when>
				<xsl:otherwise>
                    <tr height="20px"><td colspan="5">&nbsp;</td></tr>
					<tr>
                    <td>&nbsp;</td>
					  <td colspan="3" class="botonesLargo">
					    <xsl:call-template name="botonNostyle">
				              <xsl:with-param name="path" select="ZonaEmpresa/button[@label='NuevoUsuario']"/>
				            </xsl:call-template>
					  </td>
                      <td>&nbsp;</td>
					</tr>
                    <!--<tr height="5px"><td colspan="5">&nbsp;</td></tr>-->
                    <tr>
                    <td>&nbsp;</td>
					  <td colspan="3" class="textCenter">
					    <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_existen_usuarios']/node()"/></strong>
					    <input type="hidden" name="USUARIOS" value="-1"/>
					  </td>
                      <td>&nbsp;</td>
					</tr>
				</xsl:otherwise>			
				</xsl:choose>
                    <tr height="20px"><td colspan="5">&nbsp;</td></tr>
                     <tr>
                		<td>&nbsp;</td>			
						<td>
                            <a href="javascript:NuevoUsuario();">
                                <xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
                            </a> 
                        </td>
                        <td colspan="3">&nbsp;</td>			
                    </tr>
                    <tr height="5px"><td colspan="5">&nbsp;</td></tr>
                    <tr>
						<td>
                        	<a href="javascript:LugaresEntrega();">
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='Lugares_entrega']/node()"/>
                        	</a>  
                    	</td>
						<td>&nbsp;
                        	<a href="javascript:Logotipos();">
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='Logotipos']/node()"/>
                        	</a>  
                    	</td>
                    </tr>
					<xsl:if test="/ZonaEmpresa/AREAEMPRESA/ADMIN_MVM">
                    	<tr height="5px"><td colspan="5">&nbsp;</td></tr>
                    	<tr>
                        	<td>
                            	<a href="javascript:ListaCarpetasYPlantillasPorUsuario('{/ZonaEmpresa/AREAEMPRESA/CENTROS/field/@current}');">
                                	<xsl:value-of select="document($doc)/translation/texts/item[@name='plantillas']/node()"/>
                            	</a>  
							</td>
                        	<td>&nbsp;
                            	<a href="javascript:Perfiles();">
                            	   <xsl:value-of select="document($doc)/translation/texts/item[@name='perfiles']/node()"/>
                            	</a>  
                        	</td>
							<td>
                        		<a href="javascript:Circuitos();">
                            		<xsl:value-of select="document($doc)/translation/texts/item[@name='Circuitos']/node()"/>
                        		</a>  
                    		</td>
                    	</tr>
					</xsl:if>
                    <tr height="5px"><td colspan="5">&nbsp;</td></tr>
                    <tr>
						<td>
                        	<a href="javascript:AsignarComerciales();">
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='vendedores']/node()"/>
                        	</a>  
                    	</td>
						<td>&nbsp;
                        	<a href="javascript:Comentarios();">
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/>
                        	</a>  
                    	</td>
                    </tr>
					<xsl:if test="/ZonaEmpresa/AREAEMPRESA/ADMIN_MVM">
                    	<tr height="5px"><td colspan="5">&nbsp;</td></tr>
                    	<tr>
							<td>
                        		<a href="javascript:Integracion();">
                            		<xsl:value-of select="document($doc)/translation/texts/item[@name='integracion']/node()"/>
                        		</a>
                    		</td>
							<td>&nbsp;
								<xsl:choose>
								<xsl:when test="ZonaEmpresa/AREAEMPRESA/OTRO_PAIS">
                            		&nbsp;<!--(<xsl:value-of select="document($doc)/translation/texts/item[@name='selecciones']/node()"/>)-->
		    					</xsl:when>
		    					<xsl:otherwise>
                       				<a href="javascript:Selecciones();">
                            			<xsl:value-of select="document($doc)/translation/texts/item[@name='selecciones']/node()"/>
                        			</a>  
		    					</xsl:otherwise>
								</xsl:choose>
                    		</td>
                    	</tr>
					</xsl:if>
		      </xsl:when>
		      <xsl:otherwise>
                <tr height="5px"><td colspan="5">&nbsp;</td></tr>
                <tr>
                      <td>&nbsp;</td>
                      <td colspan="3" class="textCenter">
		               <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derecho_editar_usuario']/node()"/></strong>
                      </td>
                      <td>&nbsp;</td>
                </tr>
		      </xsl:otherwise>
		  </xsl:choose>
			<tfoot>
             <tr>
            	<td class="footLeft">&nbsp;</td>
            	<td colspan="3">&nbsp;</td>
            	<td class="footRight">&nbsp;</td>
             </tr>
             
            </tfoot>
			</table>
		</form>
	</xsl:otherwise>  
	</xsl:choose>  
	</body>      
</html>   
</xsl:template>
 
<xsl:template match="PROVEEDOR">
	<table width="100%">
	<tr><td align="left">
	<a class="suave" onmouseover="window.status=' ';return true" onmouseup="window.status=' ';return true" onmousedown="window.status=' ';return true">  
	<xsl:attribute name="href">javascript:MostrarPagPersonalizada('../../Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of	select="../ID"/>','producto',70,50,0,-50);</xsl:attribute>
	Pedidos:&nbsp;<!--<xsl:value-of select="../PEDIDOSTOTALES"/>&nbsp;(--><xsl:value-of select="../PEDIDOSMES"/><!--)-->
	</a>
	</td>
	<td align="right">
	<a style="color:#000000">
    <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="../IDPROVEEDOR"/>&amp;VENTANA=NUEVA','empresa',65,58,0,-50)</xsl:attribute> 
    <xsl:attribute name="onMouseOver">window.status='Información sobre la empresa.';return true;</xsl:attribute>
    <xsl:attribute name="class">suave</xsl:attribute>
    <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
    <xsl:value-of select="." disable-output-escaping="yes"/>
	</a>
	</td></tr></table>
</xsl:template>

<xsl:template match="NOMBRE">
	<!--	28mar22
	<input type="hidden" name="IDUSUARIO_{../ID}" value="{../ID}"/>
	<a style="text-decoration:none;" onmouseover="window.status='Editar usuario';return true" onmouseup="window.status=' ';return true" onmouseout="window.status=' ';return true" onmousedown="window.status=' ';return true">  
	<xsl:attribute name="href">javascript:EditarUsuario('./USManten.xsql?ID_USUARIO=<xsl:value-of select="../ID"/><xsl:if test="not(/ZonaEmpresa/AREAEMPRESA/CENTROS/EDICION)">&amp;GERENTECENTRO=<xsl:value-of select="/ZonaEmpresa/AREAEMPRESA/CENTROS/field/@current"/></xsl:if><xsl:if test="ZonaEmpresa/AREAEMPRESA/EMPRESAS/EDICION">&amp;VER_USUARIO=</xsl:if>');</xsl:attribute>
	<xsl:value-of select="." disable-output-escaping="yes"/></a>-->
	<input type="hidden" name="IDUSUARIO_{../ID}" value="{../ID}"/>
	&nbsp;<a>  
	<xsl:attribute name="href">javascript:EditarUsuario('./USManten.xsql?ID_USUARIO=<xsl:value-of select="../ID"/><xsl:if test="not(/ZonaEmpresa/AREAEMPRESA/CENTROS/EDICION)">&amp;GERENTECENTRO=<xsl:value-of select="/ZonaEmpresa/AREAEMPRESA/CENTROS/field/@current"/></xsl:if><xsl:if test="ZonaEmpresa/AREAEMPRESA/EMPRESAS/EDICION">&amp;VER_USUARIO=</xsl:if>');</xsl:attribute>
		<xsl:value-of select="." disable-output-escaping="yes"/>
        <xsl:if test="../DERECHOS!='NOR'">&nbsp;<span class="amarillo"><xsl:value-of select="../DERECHOS"/></span></xsl:if>
	</a>
</xsl:template>
 
</xsl:stylesheet>
