<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
	<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
	<xsl:param name="lang" select="@lang"/>  
	
	<xsl:template match="/">
		<html>
			<head>
				<title>Catálogo privado - Negociación</title>
				<xsl:text disable-output-escaping="yes"><![CDATA[
				<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
				<link rel="stylesheet" href="http://www.newco.dev.br/General/EstilosImprimir.css" type="text/css" media="print">	
				<script type="text/javascript" src="http://www.newco.dev.br/General/general.js"></script>
				<style type="text/css">
	  			textarea{ 
            font-family: verdana, arial, "ms sans serif", sans-serif; 
            font-size: 10px; 
            margin: 2px;
            line-height: 14px;
            padding-left: 1px;
            color: #000000;
          }
    		</style>
        <style type="text/css" media="print">
	  			textarea{ 
            font-family: verdana, arial, "ms sans serif", sans-serif; 
            font-size: 8px; 
            margin: 2px;
            line-height: 14px;
            padding-left: 1px;
            color: #000000;
          }
          
          select{ 
            font-family: verdana, arial, "ms sans serif", sans-serif; 
            font-size: 8px; 
            margin: 1px;
            line-height: 10px;
            padding-left: 1px;
          }
		 
         input{ 
           font-family: verdana, arial, "ms sans serif", sans-serif; 
           font-size: 8px; 
           margin: 1px;
           line-height: 10px;
           padding-left: 1px;
           color: #000000;
         }
        </style>
				<script type="text/javascript">
					<!--
					
						var msgIdProveedor='Seleccione un proveedor';
						var msgNegociacion='Introduzca sus comentarios';
						var msgTitulo='Introduzca una descripción para poder indentificar el informe posteriormente';
						var msgFinalizar='¿Realmente quiere finalizar el Informe de Negociación?';
						var msgFinalizarConComentarios='Ha introducido comentarios que no serán leídos por el proveedor si finaliza el informe.\n\n¿Realmente quiere finalizar el Informe de Negociación?';
						
						function Enviar(form){
							if(validarFormulario(form,'ENVIAR')){
								form.elements['ACCION'].value='ENVIAR';
								SubmitForm(form);
							}
						}
						
						function Devolver(form){
							if(validarFormulario(form,'DEVOLVER')){
								form.elements['ACCION'].value='DEVOLVER';
								SubmitForm(form);
							}
						}
						
						function Finalizar(form){
							if(validarFormulario(form,'FINALIZAR')){
								if(form.elements['NEGOCIACION'].value!=''){
									if(confirm(msgFinalizarConComentarios)){
										form.elements['ACCION'].value='FINALIZAR';
										SubmitForm(form);
									}
								}
								else{
									if(confirm(msgFinalizar)){
										form.elements['ACCION'].value='FINALIZAR';
										SubmitForm(form);
									}
								}
							}
						}
						
						function validarFormulario(form,accion){
							
							var errores=0;
							
							if((!errores) &&(form.elements['IDPROVEEDOR'].value==-1)){
								errores++;
								alert(msgIdProveedor);
								form.elements['IDPROVEEDOR'].focus();
							}
							
							if(form.elements['TITULO']){
								if((!errores) &&(form.elements['TITULO'].value=='')){
									errores++;
									alert(msgTitulo);
									form.elements['TITULO'].focus();
								}
							}
							
							if(accion!='FINALIZAR'){
								if((!errores) &&(form.elements['NEGOCIACION'].value=='')){
									errores++;
									alert(msgNegociacion);
									form.elements['NEGOCIACION'].focus();
								}
							}
							
							if(errores){
								return 0;
							}
							else{
								return 1;
							}
						}	
						
						function CerrarVentana(){ 
            	if(window.parent.opener && !window.parent.opener.closed){
              	var objFrameTop=new Object();          
              	objFrameTop=window.parent.opener.top;   
              	var FrameOpenerName=window.parent.opener.name;
              	var objFrame=new Object();
              	objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
              	if(objFrame!=null && objFrame.recargarPagina){
                	objFrame.recargarPagina('PROPAGAR');
              	}
              	else{
                	Refresh(objFrame.document);
              	}  	
            	}
            	else{
            		document.location.href='about:blank';
            	}
            	window.parent.close();
          	}
						
						function Imprimir(){
							window.print();
						}
					
					//-->
				</script>
				]]></xsl:text>
			</head>
			<body class="blanco" text="#000000" link="#333366" vlink="#333366" alink="#3399ff">      
				<xsl:choose>
					<xsl:when test="Negociacion/SESION_CADUCADA">
						<xsl:apply-templates select="Negociacion/SESION_CADUCADA"/> 
					</xsl:when>
					<xsl:when test="Negociacion/ROWSET/ROW/Sorry">
						<xsl:apply-templates select="Negociacion/ROWSET/ROW/Sorry"/> 
					</xsl:when>
					<xsl:otherwise>
						<form method="post" action="NegociacionCdCSave.xsql">
							<!-- campos hidden -->
							<input type="hidden" name="IDUSUARIORESPONSABLE" value="{Negociacion/INFORME/IDUSUARIORESPONSABLE}"/>
							<input type="hidden" name="IDUSUARIOPROVEEDOR" value="{Negociacion/INFORME/IDUSUARIOPROVEEDOR}"/>
							<input type="hidden" name="IDUSUARIOCLIENTE" value="{Negociacion/INFORME/IDUSUARIOCLIENTE}"/>
							<input type="hidden" name="IDINFORME" value="{Negociacion/INFORME/IDINFORME}"/>
							<input type="hidden" name="ACCION"/>
   						<p class="tituloPag" align="center">Informe de negociación</p>
  							<table width="90%" align="center">
    							<tr>
      							<td>
        							<table width="100%" border="0" cellspacing="1" cellpadding="3" class="oscuro">
        							  <tr class="blanco"> 
        							    <td height="18"  class="blanco">
        							      <table width="100%" border="0" cellspacing="0" cellpadding="10" align="center">
        							        <tr>
        							          <td> 
        							            <table width="100%" border="0" cellspacing="1" cellpadding="3" class="oscuro" align="center">
        							              <tr  class="blanco">
        							                <td width="164px" align="right" class="claro">
        							                  <b>
        							                  Número de Informe:
        							                  </b>
        							                </td>
        							                <td width="*" class="blanco">
        							                  <font color="NAVY" size="1">
        							                    <b>
        							  	                <xsl:value-of select="Negociacion/INFORME/NUMERO"/>
        							  	              </b>
        							  	            </font>
        							                </td>
        							                <td width="164px" align="right" class="claro">
        							                  <b>
        							                  Fecha de inicio:
        							                  </b>
        							                </td>
        							                <td width="164px" class="blanco">
        							                  <font color="NAVY" size="1">
        							                    <b>
        							  	                <xsl:value-of select="Negociacion/INFORME/FECHAINICIO"/>
        							  	              </b>
        							  	            </font>
        							                </td>
        							              </tr>
        							            </table>
        							          </td>
        							        </tr>
        							        <tr>
        							          <td> 
        							          	<table width="100%" border="0" cellspacing="1" cellpadding="0" class="oscuro" align="center">
        							        			<tr  class="oscuro">
        							          			<td class="oscuro" colspan="2">
        							            			<table width="100%" border="0" cellspacing="0" cellpadding="3">
        							              			<tr>
        							                			<td>
        							                  			<b>
        							                    			Negociadores:
        							                  			</b>
        							                  			<br/>
        							                			</td>
        							              			</tr>
        							            			</table>
        							          			</td>
        							        			</tr>
        							        			<tr align="center" class="claro">
        							          			<td class="claro" width="100%" height="100%" colspan="2">  
        							                  <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
        							                    <tr>
        							                      <td align="right" width="170px">
        							                        <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
        							                          <tr>
        							                            <td align="right" width="100%">
        							                              Responsable:
        							                            </td>
        							                          </tr>
        							                        </table>
        							                      </td>
        							                      <td align="right" width="1px" class="oscuro">
        							                      </td>
        							                      <td align="left">
        							                        <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
        							                          <tr>
        							                            <td align="left" width="100%">
        							                              <b><xsl:value-of select="Negociacion/INFORME/USUARIOCLIENTE"/></b><br/>
        							                            </td>
        							                          </tr>
        							                        </table>
        							                      </td>
        							                    </tr>
        							                    <tr>
        							                      <td align="right">
        							                        <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
        							                          <tr>
        							                            <td align="right" width="100%">
        							                              Centro: 
        							                            </td>
        							                          </tr>
        							                        </table>
        							                      </td>
        							                      <td align="right" width="1px" class="oscuro">
        							                      </td>
        							                      <td align="left">
        							                        <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
        							                          <tr>
        							                            <td align="left" width="100%">
        							                              <xsl:value-of select="Negociacion/INFORME/CENTRO_CLIENTE"/>
        							                            </td>
        							                          </tr>
        							                        </table>
        							                      </td>
        							                    </tr>
																					<!-- READ_ONLY != S -->
																					<xsl:choose>
																						<xsl:when test="Negociacion/READ_ONLY!='S'">
        							                    		<xsl:choose>
        							                    			<xsl:when test="Negociacion/INFORME/IDINFORME=0">                 
        							                    				<tr>
        							                    		  		<td align="right">
        							                    		    		<table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
        							                    		      		<tr>
        							                    		        		<td align="right" width="100%">
        							                    		          		Proveedor:<span class="camposObligatorios">*</span>
        							                    		        		</td>
        							                    		      		</tr>
        							                    		    		</table>
        							                    		  		</td>
        							                    		  		<td align="right" width="1px" class="oscuro">
        							                    		  		</td>
        							                    		  		<td align="left">
        							                    		    		<table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
        							                    		      		<tr>
        							                    		        		<td align="left" width="100%">
        							                    		  						<xsl:call-template name="field_funcion">
    	                    																		<xsl:with-param name="path" select="Negociacion/INFORME/PROVEEDORES/field[@name='IDPROVEEDOR']"/>
    	                    																		<xsl:with-param name="IDAct" select="Negociacion/INFORME/PROVEEDORES/field[@name='IDPROVEEDOR']/@current"/>
    	                  																		</xsl:call-template>
        							                    		        		</td>
        							                    		      		</tr>
        							                    		    		</table>
        							                    		  		</td>
        							                    				</tr>
        							                    			</xsl:when>
        							                    			<xsl:otherwise>
        							                    				<tr>
        							                    		  		<td align="right">
        							                    		    		<table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
        							                    		      		<tr>
        							                    		        		<td align="right" width="100%">
        							                    		          		Comercial: 
        							                    		        		</td>
        							                    		      		</tr>
        							                    		    		</table>
        							                    		  		</td>
        							                    		  		<td align="right" width="1px" class="oscuro">
        							                    		  		</td>
        							                    		  		<td align="left">
        							                    		    		<table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
        							                    		      		<tr>
        							                    		        		<td align="left" width="100%">
        							                    		          		<b><xsl:value-of select="Negociacion/INFORME/USUARIOPROVEEDOR"/></b>
        							                    		        		</td>
        							                    		      		</tr>
        							                    		    		</table>
        							                    		  		</td>
        							                    				</tr>
        							                    				<tr>
        							                    		  		<td align="right">
        							                    		    		<table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
        							                    		      		<tr>
        							                    		        		<td align="right" width="100%">
        							                    		          		Proveedor:
        							                    		        		</td>
        							                    		      		</tr>
        							                    		    		</table>
        							                    		  		</td>
        							                    		  		<td align="right" width="1px" class="oscuro">
        							                    		  		</td>
        							                    		  		<td align="left">
        							                    		    		<table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
        							                    		      		<tr>
        							                    		        		<td align="left" width="100%">
        							                    		        			<xsl:value-of select="Negociacion/INFORME/EMPRESA_PROVEEDOR"/>
        							                    		        			<input type="hidden" name="IDPROVEEDOR" value="{Negociacion/INFORME/IDEMPRESA_PROVEEDOR}"/>
        							                    		        		</td>
        							                    		      		</tr>
        							                    		    		</table>
        							                    		  		</td>
        							                    				</tr>
        							                    			</xsl:otherwise>
        							                    		</xsl:choose>
																						</xsl:when>
																						<!-- READ_ONLY = S -->
																						<xsl:otherwise>
																							<tr>
        							                    			<td align="right">
        							                    		  	<table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
        							                    		    	<tr>
        							                    		      	<td align="right" width="100%">
        							                    		        	Comercial: 
        							                    		        </td>
        							                    		      </tr>
        							                    		    </table>
        							                    		  </td>
        							                    		  <td align="right" width="1px" class="oscuro">
        							                    		  </td>
        							                    		  <td align="left">
        							                    		    <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
        							                    		      <tr>
        							                    		        <td align="left" width="100%">
        							                    		          <b><xsl:value-of select="Negociacion/INFORME/USUARIOPROVEEDOR"/></b>
        							                    		        </td>
        							                    		      </tr>
        							                    		    </table>
        							                    		  </td>
        							                    		</tr>
        							                    		<tr>
        							                    		  <td align="right">
        							                    		    <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
        							                    		      <tr>
        							                    		        <td align="right" width="100%">
        							                    		          Proveedor:
        							                    		        </td>
        							                    		      </tr>
        							                    		    </table>
        							                    		  </td>
        							                    		  <td align="right" width="1px" class="oscuro">
        							                    		  </td>
        							                    		  <td align="left">
																									<table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
        							                    		      <tr>
        							                    		        <td align="left" width="100%">
        							                    		        	<xsl:value-of select="Negociacion/INFORME/EMPRESA_PROVEEDOR"/>
        							                    		        	<input type="hidden" name="IDPROVEEDOR" value="{Negociacion/INFORME/IDEMPRESA_PROVEEDOR}"/>
        							                    		        </td>
        							                    		      </tr>
        							                    		    </table>
        							                    		  </td>
        							                    		</tr>
																						</xsl:otherwise>
																					</xsl:choose>
        							                  </table>
        							          			</td>
        							        			</tr>
        							      			</table>
        							          </td>
        							        </tr>
        							        <tr>
																<td>
        							          	<table width="100%" border="0" cellspacing="1" cellpadding="0" class="oscuro" align="center">
        							        			<tr  class="oscuro">
        							          			<td class="oscuro" colspan="2">
        							            			<table width="100%" border="0" cellspacing="0" cellpadding="3">
        							              			<tr>
        							                			<td>
        							                 	 			<b>
        							                    			Negociación:
        							                  			</b>
        							                  			<br/>
        							                			</td>
        							              			</tr>
        							            			</table>
        							          			</td>
        							        			</tr>
        							        			<tr align="center" class="claro">
        							          			<td class="claro" width="100%" height="100%" colspan="2">  
        							                  <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
        							                    <tr>
        							                      <td align="right" width="170px">
        							                        <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
        							                          <tr>
        							                            <td align="right" width="100%">
        							                            	Descripción:<span class="camposObligatorios">*</span>  
        							                            </td>
        							                          </tr>
        							                        </table>
        							                      </td>
        							                      <td align="right" width="1px" class="oscuro">
        							                      </td>
        							                      <td align="left">
        							                        <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
        							                          <tr>
        							                            <td align="left" width="100%">
        							                            	<xsl:choose>
																											<xsl:when test="Negociacion/READ_ONLY!='S'">
																												<xsl:choose>
																													<xsl:when test="Negociacion/INFORME/IDINFORME=0">
																														<input type="text" name="TITULO" size="100" maxlength="300"/>
																													</xsl:when>
																													<xsl:otherwise>
																														<b><xsl:value-of select="Negociacion/INFORME/TITULO"/></b>
																													</xsl:otherwise>
																												</xsl:choose>
																											</xsl:when>
																											<xsl:otherwise>
																												<b><xsl:value-of select="Negociacion/INFORME/TITULO"/></b>
																											</xsl:otherwise>
																										</xsl:choose>
        							                            </td>
        							                          </tr>
        							                        </table>
        							                      </td>
        							                    </tr>
																					<xsl:choose>
																						<xsl:when test="Negociacion/READ_ONLY!='S'">
																							<tr>
																								<td align="right">
																									<table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
																										<tr>
																											<td align="right" width="100%" valign="top">
																												Comentarios:<span class="camposObligatorios">*</span>
																											</td>
																										</tr>
																									</table>
																								</td>
																								<td align="right" width="1px" class="oscuro">
																								</td>
																								<td align="left">
																									<table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
																										<tr>
																											<td align="left" width="100%">
																												<textarea name="NEGOCIACION" rows="15" cols="100"></textarea>  
																											</td>
																										</tr>
																									</table>
																								</td>
																							</tr>
																						</xsl:when>
																						<xsl:otherwise>
																							<tr>
																								<td colspan="3">
																									<table width="100%" cellpadding="0" cellspacing="0" border="0"> 
																										<tr>
																											<td align="center" class="oscuro" valign="top">
																												<b>Histórico</b>
																												<br/>
																											</td>
																										</tr>
																									</table>
																								</td>
																							</tr>
																							<tr>
																								<td colspan="3">
																									<table width="100%" cellpadding="0" cellspacing="0" border="0"> 
																										<tr>
																											<td align="center">
																												<!-- aqui van los historicos de la negociacion (READ_ONLY)-->
																												<xsl:apply-templates select="Negociacion/INFORME/LINEASNEGOCIACION"/>
																											</td>
																										</tr>
																									</table>
																								</td>
																							</tr>
																						</xsl:otherwise>
																					</xsl:choose>
        							                  </table>
        							          			</td>
        							        			</tr>
        							      			</table>
        							    			</td>
        							  			</tr>
        							  			<tr>
        							  				<td>
        							  				<!-- zona de botones -->
        							  					<table width="100%">
						        								<tr align="center">
																			<xsl:choose>
																				<xsl:when test="Negociacion/READ_ONLY!='S'">
																					<xsl:choose>
																						<xsl:when test="Negociacion/INFORME/ESTADO=10">
																							<td>
																								<xsl:call-template name="boton">
																									<xsl:with-param name="path" select="Negociacion/botones/button[@label='Enviar']"/>
																								</xsl:call-template>
																							</td>
																							<xsl:if test="Negociacion/INFORME/IDINFORME>0">
																								<td>
																									<xsl:call-template name="boton">
																										<xsl:with-param name="path" select="Negociacion/botones/button[@label='Finalizar']"/>
																									</xsl:call-template>
																								</td>
																							</xsl:if>
																						</xsl:when>
																						<xsl:when test="Negociacion/INFORME/ESTADO=20">
																							<td>
																								<xsl:call-template name="boton">
																									<xsl:with-param name="path" select="Negociacion/botones/button[@label='Devolver']"/>
																								</xsl:call-template>
																							</td>
																						</xsl:when>
																					</xsl:choose>
																				</xsl:when>
																				<xsl:otherwise>
																					<td>
																						<xsl:call-template name="boton">
																							<xsl:with-param name="path" select="Negociacion/botones/button[@label='Cerrar']"/>
																						</xsl:call-template>
																					</td>
																					<td>
																						<xsl:call-template name="boton">
																							<xsl:with-param name="path" select="Negociacion/botones/button[@label='Imprimir']"/>
																						</xsl:call-template>
																					</td>
																				</xsl:otherwise>
																			</xsl:choose>
						        								</tr>
						      								</table>
						      								<!-- fin zona de botones -->
        							  				</td>
        							  			</tr>
        							        <xsl:if test="Negociacion/INFORME/IDINFORME!=0 and Negociacion/READ_ONLY!='S'">  
        							        	<tr>
        							        	  <td>
        							        	  	<table width="100%" border="0" cellspacing="1" cellpadding="0" class="oscuro">
        							        	    	<tr  class="oscuro">
        							        	      	<td>
        							        	        	<table width="100%" cellpadding="1" cellspacing="3" border="0"> 
        							        	          	<tr>
        							        	            	<td align="left">
        							        	              	<b>
        							        	              		Histórico:
        							        	              	</b>
        							        	              	<br/>
        							        	              </td>
        							        	            </tr>
        							        	          </table>  
        							        	        </td>
        							        	      </tr>
        							        	      <tr class="medio">
        							        	      	<td class="medio">
        							        	      		<!-- aqui van los historicos de la negociacion -->
        							        	      		<xsl:apply-templates select="Negociacion/INFORME/LINEASNEGOCIACION"/>
        							        	      	</td>
        							        	    	</tr>                   
        							        	  	</table>
        							        		</td>
        							        	</tr>
        							        </xsl:if>
        							      </table>
        							    </td>
        							  </tr>
        							</table>
						      </td>
						    </tr>
						    <tr>
						      <td>
						        Los campos marcados con (<span class="camposObligatorios">*</span>) son obligatorios.
						      </td>
						    </tr>
						  </table>
						</form>

					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="LINEASNEGOCIACION">  
  	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="muyoscuro">
    	<tr class="blanco">
      	<td class="blanco">
        	<table width="100%" cellpadding="0" cellspacing="0">
          	<xsl:for-each select="NEGOCIACION_ROW">
            	<tr>
              	<td>
                	<table width="100%" cellpadding="0" cellspacing="1" class="oscuro">
                  	<tr>
                    	<xsl:choose> 
                      	<xsl:when test="/Negociacion/INFORME/IDCENTRO_RESPONSABLE!=IDCENTRO">
                        	<xsl:attribute name="class">blanco</xsl:attribute>
                      	</xsl:when>
                      	<xsl:otherwise>
                        	<xsl:attribute name="class">claro</xsl:attribute>
                      	</xsl:otherwise>
                    	</xsl:choose>
                    	<td valign="top" width="25%" align="left"> 
                      	<xsl:choose> 
                        	<xsl:when test="/Negociacion/INFORME/IDCENTRO_RESPONSABLE!=IDCENTRO">
                        		<xsl:attribute name="class">blanco</xsl:attribute>
                        	</xsl:when>
                        	<xsl:otherwise>
                          	<xsl:attribute name="class">claro</xsl:attribute>
                        	</xsl:otherwise>
                      	</xsl:choose>
	                		
	                			<xsl:value-of select="CENTRO"/>:&nbsp;	  
	                			
                    	</td>
                    	<td valign="top" width="*" align="center"> 
                      	<xsl:choose> 
                        	<xsl:when test="/Negociacion/INFORME/IDCENTRO_RESPONSABLE!=IDCENTRO">
                          	<xsl:attribute name="class">blanco</xsl:attribute>
                        	</xsl:when>
                        	<xsl:otherwise>
                          	<xsl:attribute name="class">claro</xsl:attribute>
                        	</xsl:otherwise>
                      	</xsl:choose>
	                			
	                			<xsl:copy-of select="LNGC_ESTADO"/>  
	                			
                    	</td>
                    	<td valign="top" width="25%" align="right"> 
                      	<xsl:choose> 
                        	<xsl:when test="/Negociacion/INFORME/IDCENTRO_RESPONSABLE!=IDCENTRO">
                          	<xsl:attribute name="class">blanco</xsl:attribute>
                        	</xsl:when>
                        	<xsl:otherwise>
                          	<xsl:attribute name="class">claro</xsl:attribute>
                        	</xsl:otherwise>
                      	</xsl:choose>

	                			<xsl:value-of select="LNGC_FECHA"/> 	  

                    	</td>
                  	</tr>
                  	<tr>
                    	<xsl:choose> 
                      	<xsl:when test="/Negociacion/INFORME/IDCENTRO_RESPONSABLE!=IDCENTRO">
                        	<xsl:attribute name="class">blanco</xsl:attribute>
                      	</xsl:when>
                      	<xsl:otherwise>
                        	<xsl:attribute name="class">claro</xsl:attribute>
                      	</xsl:otherwise>
                    	</xsl:choose>
                    	<td colspan="3">   
                      	<xsl:choose> 
                        	<xsl:when test="/Negociacion/INFORME/IDCENTRO_RESPONSABLE!=IDCENTRO">
                          	<xsl:attribute name="class">blanco</xsl:attribute>
                        	</xsl:when>
                        	<xsl:otherwise>
                          	<xsl:attribute name="class">claro</xsl:attribute>
                        	</xsl:otherwise>
                      	</xsl:choose>
                      	<table width="70%" align="center">
                        	<tr>
                          	<td>
                            	&nbsp;<xsl:copy-of select="LNGC_COMENTARIOS"/>
                          	</td>
                        	</tr>
                      	</table>                     
                    	</td>  
                  	</tr>
                	</table>
              	</td>
            	</tr>
          	</xsl:for-each> 
        	</table>
      	</td>
    	</tr>                    
  	</table>
	</xsl:template>
	
</xsl:stylesheet>
