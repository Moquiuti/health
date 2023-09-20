<?xml version="1.0" encoding="iso-8859-1" ?>
<!--

	Presenta un AÑO completo del CALENDARIO a un usuario
	
	(c) may 2003 ET

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>  
<xsl:template match="/">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
	<title>Calendario de MedicalVM</title>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->  

	<link rel="stylesheet" href="http://www.newco.dev.br/General/calendarioPedPro.css" type="text/css"/>

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Compras/PedidosProgramados/LanzamientosPedidosProgramados2022_140922.js"></script>
	<script type="text/javascript">
	var msgDiaEntregaFinDeSemana='El día selecionado no corresponde con un día laborable, no puede ser seleccionado como día de entrega.';
	var msgDiaEntregaConflictos='El día seleccionado esta marcado como no hábil por ';
	var confimacionAccionActivo='.\n¿Desea no seleccionarlo como fecha de entrega?';
	var confimacionAccionNoActivo='.\n¿Desea seleccionarlo como fecha de entrega?';
	
	var explicacionNoActivo='\n\n    * Aceptar: selecciona el día como fecha de entrega\n    * Cancelar: no realiza ningún cambio';
	
	var explicacionActivo='\n\n    * Aceptar: deselecciona el día como fecha de entrega\n    * Cancelar: no realiza ningún cambio';
	
	var msgSinLanzamientos='Por favor, seleccione al menos una fecha de entrega';
	
	var msgLanzamientosManuales='¿Desea asignar la frecuencia de entregas como \"Manual\"?\n\nSi no ha realizado ningún cambio en las fechas de entrega le aconsejamos que pulse cancelar';
	
	var msgLanzamientoImposible='';	
	
	var IDPrograma='<xsl:value-of select="/PedidosProgramados/CALENDARIOANUAL/IDPROGRAMA"/>';
	var lanzamientoDiasAnteriores=0;
	var plazoEntregaGenerico='<xsl:value-of select="PedidosProgramados/CALENDARIOANUAL/PEDIDOENTREGA/PLAZOENTREGA"/>';
	var anyoActual='<xsl:value-of select="PedidosProgramados/CALENDARIOANUAL/@Anyo"/>';
	var actualizarPagina='<xsl:value-of select="/PedidosProgramados/ACTUALIZARPAGINA"/>';   

	var idusuario='<xsl:value-of select="PedidosProgramados/IDUSUARIO"/>';
	var accion='<xsl:value-of select="PedidosProgramados/CALENDARIOANUAL/@Accion"/>';
	var titulo='<xsl:value-of select="PedidosProgramados/CALENDARIOANUAL/@Titulo"/>';
	var ventana='<xsl:value-of select="PedidosProgramados/VENTANA"/>';
	var actualizarPagina='<xsl:value-of select="PedidosProgramados/ACTUALIZARPAGINA"/>';
    var read_only='<xsl:choose><xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/CALENDARIOANUAL/EDICION">N</xsl:when><xsl:otherwise>S</xsl:otherwise></xsl:choose>';
	var plazoEntregaGenerico='<xsl:value-of select="PedidosProgramados/CALENDARIOANUAL/PEDIDOENTREGA/PLAZOENTREGA"/>';

	// montamos un array con los anyos posibles  
	var arrayAnyos=new Array();
	  
	<xsl:for-each select="/PedidosProgramados/CALENDARIOANUAL/ANYO/field/dropDownList/listElem">
		arrayAnyos[arrayAnyos.length]='<xsl:value-of select="ID"/>';
	</xsl:for-each>

	// montamos un array con las fechas
	var arrayFechasTemp=new Array();
	<xsl:for-each select="/PedidosProgramados/CALENDARIOANUAL/LINEA">
	    <xsl:for-each select="./CALENDARIO">
	      <xsl:for-each select="./SEMANA">
	        <xsl:for-each select="./DIA">
	        
	              <!-- inicio -->
			     
						    
				  <xsl:choose>
					    <!-- estamos en edicion, hay enlaces -->
				    <xsl:when test="/PedidosProgramados/CALENDARIOANUAL/EDICION">

						  <xsl:variable name="anyosVisitados"><xsl:value-of select="//PedidosProgramados/ANYOS_VISITADOS"/></xsl:variable>
						  <xsl:variable name="anyoActual"><xsl:value-of select="//PedidosProgramados/CALENDARIOANUAL/@Anyo"/></xsl:variable>
						  
						  <xsl:choose>
						      <!-- miramos en los temporales -->
						    <xsl:when test="contains($anyosVisitados,$anyoActual)">
						      
						      <!--
						          los temporales
						      -->

						      
						      <xsl:variable name="resultado_tmp"><xsl:value-of select="//PedidosProgramados/RESULTADO_TMP"/></xsl:variable>
						      <xsl:variable name="diaActual">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:variable>
						      <xsl:choose>
						         <!-- es lanzamiento (tmp) -->
						        
						        <xsl:when test="contains($resultado_tmp,$diaActual)">
					            <!-- miramos si es un lanzamiento valido (tmp) esto es, no es fiesta de nadie -->
					            
					            
					            
					            <xsl:choose>
					                <!-- fiesta del proveedor , no es valido -->
						            <xsl:when test="./@VacacionesProveedor='S' and not(./@Vacaciones='S')">
						                
						                  arrayFechasTemp[arrayFechasTemp.length]=new Array('<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>','diasLanzamientosConflictos');
						                  
						            </xsl:when>
						              <!-- fiesta del cliente , no es valido -->
						            <xsl:when test="./@Vacaciones='S'">
						                  
						                  arrayFechasTemp[arrayFechasTemp.length]=new Array('<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>','diasLanzamientosConflictos');

						            </xsl:when>
						               <!-- lanzamiento valido -->
						            <xsl:otherwise>
						                
						                arrayFechasTemp[arrayFechasTemp.length]=new Array('<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>','diasLanzamientosCorrectos');

						            </xsl:otherwise>    
						          </xsl:choose>

					          </xsl:when>
					            <!-- no es lanzamiento (tmp) -->
					          <xsl:otherwise>
					      
					           <!--  este dia no esta marcado como lanzamiento mostramos si es fiesta del proveedor o del cliente
						               si es de ambos tiene preferencia la del cliente
						               si no, lo podemos asignar como lanzamiento sera un enlace 
						         -->
						          <xsl:choose>
						               <!-- fiesta del proveedor no puede ser lanzamiento -->
						            <xsl:when test="./@VacacionesProveedor='S' and not(./@Vacaciones='S')">
						              
						              
						              arrayFechasTemp[arrayFechasTemp.length]=new Array('<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>','diasVacacionesProveedor');
					                
						            </xsl:when>
						               <!-- fiesta del cliente no puede ser lanzamiento -->
						            <xsl:when test="./@Vacaciones='S'">
						              
						              arrayFechasTemp[arrayFechasTemp.length]=new Array('<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>','diasVacacionesCliente');
					                
						            </xsl:when> 
						              <!-- candidato a ser un lanzamiento -->
						            <xsl:otherwise>

						              <xsl:choose>
						                <xsl:when test="./@Clase">
						                
						                  arrayFechasTemp[arrayFechasTemp.length]=new Array('<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>','<xsl:value-of select="./@Clase"/>');
						                  
						                </xsl:when>
						                <xsl:otherwise>
						                
						                  arrayFechasTemp[arrayFechasTemp.length]=new Array('<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>','grisclaro');
						                  
						                </xsl:otherwise>
						              </xsl:choose>

						            </xsl:otherwise>
						          </xsl:choose>
						      
					          </xsl:otherwise>
					        </xsl:choose> 
						      
						      
						      <!--
						        fin los temporales
						      -->
						      
						      
						      
						    </xsl:when>
						           <!-- miramos en la BD -->
						    <xsl:otherwise>
						      <xsl:choose>
						      
						         <!-- es lanzamiento (BD) -->
						        <xsl:when test="./@Lanzamiento='S'">
					            <!-- miramos si es un lanzamineto valido (BD) esto es, no es fiesta de nadie -->
					            <xsl:choose>
					                 fiesta del proveedor , no es valido 
						            <xsl:when test="./@VacacionesProveedor='S' and not(./@Vacaciones='S')">
						                
						              arrayFechasTemp[arrayFechasTemp.length]=new Array(convertirFechaATexto(calcularDiasHabiles(new Date(formatoFecha('<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>','E','I')),<xsl:choose><xsl:when test="./@PlazoEntrega=-1">plazoEntregaGenerico</xsl:when><xsl:otherwise>'<xsl:value-of select="./@PlazoEntrega"/>'</xsl:otherwise></xsl:choose>,false)),'diasLanzamientosConflictos');

						            </xsl:when>
						              <!-- fiesta del cliente , no es valido -->
						            <xsl:when test="./@Vacaciones='S'">
						                
						              arrayFechasTemp[arrayFechasTemp.length]=new Array(convertirFechaATexto(calcularDiasHabiles(new Date(formatoFecha('<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>','E','I')),<xsl:choose><xsl:when test="./@PlazoEntrega=-1">plazoEntregaGenerico</xsl:when><xsl:otherwise>'<xsl:value-of select="./@PlazoEntrega"/>'</xsl:otherwise></xsl:choose>,false)),'diasLanzamientosConflictos');
						              

						            </xsl:when>
						               <!-- lanzamiento valido -->
						            <xsl:otherwise>
						              
						              arrayFechasTemp[arrayFechasTemp.length]=new Array(convertirFechaATexto(calcularDiasHabiles(new Date(formatoFecha('<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>','E','I')),<xsl:choose><xsl:when test="./@PlazoEntrega=-1">plazoEntregaGenerico</xsl:when><xsl:otherwise>'<xsl:value-of select="./@PlazoEntrega"/>'</xsl:otherwise></xsl:choose>,false)),'diasLanzamientosCorrectos');

						            </xsl:otherwise>    
						          </xsl:choose>

					          </xsl:when>
					            <!-- no es lanzamiento (BD) -->
					          <xsl:otherwise>
					      
					            <!-- este dia no esta marcado como lanzamiento mostramos si es fiesta del proveedor o del cliente
						               si es de ambos tiene preferencia la del cliente
						               si no, lo podemos asignar como lanzamiento sera un enlace 
						          -->
						          <xsl:choose>
						               <!-- fiesta del proveedor no puede ser lanzamiento -->
						            <xsl:when test="./@VacacionesProveedor='S' and not(./@Vacaciones='S')">
						              
						              arrayFechasTemp[arrayFechasTemp.length]=new Array('<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>','diasVacacionesProveedor');
						              
						            </xsl:when>
						               <!-- fiesta del cliente no puede ser lanzamiento -->
						            <xsl:when test="./@Vacaciones='S'">
						              
						              arrayFechasTemp[arrayFechasTemp.length]=new Array('<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>','diasVacacionesCliente');
						              
						            </xsl:when> 
						              <!-- candidato a ser un lanzamiento -->
						            <xsl:otherwise>

						              <xsl:choose>
						                <xsl:when test="./@Clase">
						                
						                  arrayFechasTemp[arrayFechasTemp.length]=new Array('<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>','<xsl:value-of select="./@Clase"/>');
						                  
						                </xsl:when>
						                <xsl:otherwise>
						                
						                  arrayFechasTemp[arrayFechasTemp.length]=new Array('<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>','grisclaro');
						                  
						                </xsl:otherwise>
						              </xsl:choose>

						            </xsl:otherwise>
						          </xsl:choose>
						      
					          </xsl:otherwise>
					        </xsl:choose> 
					        
					      </xsl:otherwise>
					    </xsl:choose>
					    
					  </xsl:when>
					  
					     <!-- READ_ONLY -->
					  <xsl:otherwise>
					       <!--
					           asignamos colores, e informamos de las fechas conflictivas (en principio no deberia haber ninguna)
					            ya que el cliente deberia haber congifurado los lanzamientos correctamente
					       -->
						  <xsl:choose> 
						        <!-- es lanzamiento, miramos si hay conflictos -->
						    <xsl:when test="./@Lanzamiento='S'">
						    
						      <xsl:choose>
					              <!-- fiesta del proveedor , conflicto -->
						        <xsl:when test="./@VacacionesProveedor='S' and not(./@Vacaciones='S')">
						            
						          arrayFechasTemp[arrayFechasTemp.length]=new Array(convertirFechaATexto(calcularDiasHabiles(new Date(formatoFecha('<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>','E','I')),<xsl:choose><xsl:when test="./@PlazoEntrega=-1">plazoEntregaGenerico</xsl:when><xsl:otherwise>'<xsl:value-of select="./@PlazoEntrega"/>'</xsl:otherwise></xsl:choose>,false)),'diasLanzamientosConflictos');
						          
						        </xsl:when>
						           <!-- fiesta del cliente ,  conflicto -->
						        <xsl:when test="./@Vacaciones='S'">
						            
						          arrayFechasTemp[arrayFechasTemp.length]=new Array(convertirFechaATexto(calcularDiasHabiles(new Date(formatoFecha('<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>','E','I')),<xsl:choose><xsl:when test="./@PlazoEntrega=-1">plazoEntregaGenerico</xsl:when><xsl:otherwise>'<xsl:value-of select="./@PlazoEntrega"/>'</xsl:otherwise></xsl:choose>,false)),'diasLanzamientosConflictos');
						               
						        </xsl:when>
						               <!-- lanzamiento valido, no hay conflicto -->
						        <xsl:otherwise>
						          
						          arrayFechasTemp[arrayFechasTemp.length]=new Array(convertirFechaATexto(calcularDiasHabiles(new Date(formatoFecha('<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>','E','I')),<xsl:choose><xsl:when test="./@PlazoEntrega=-1">plazoEntregaGenerico</xsl:when><xsl:otherwise>'<xsl:value-of select="./@PlazoEntrega"/>'</xsl:otherwise></xsl:choose>,false)),'diasLanzamientosCorrectos');
						               
						        </xsl:otherwise>    
						      </xsl:choose>
						      
						    </xsl:when>
						       <!-- no es lanzamiento, mostramos las fiestas de los usuarios -->
						    <xsl:otherwise> 
						      
						      <xsl:choose>
					              <!-- fiesta del proveedor , conflicto -->
						        <xsl:when test="./@VacacionesProveedor='S' and not(./@Vacaciones='S')">
						          
						          arrayFechasTemp[arrayFechasTemp.length]=new Array('<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>','diasVacacionesProveedor');
						          
						        </xsl:when>
						           <!-- fiesta del cliente ,  conflicto -->
						        <xsl:when test="./@Vacaciones='S'">
						          
						          arrayFechasTemp[arrayFechasTemp.length]=new Array('<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>','diasVacacionesCliente');
						            
						        </xsl:when>
						               <!-- lanzamiento valido, no hay conflicto -->
						        <xsl:otherwise>
					              
					              <xsl:choose>
						              <xsl:when test="./@Clase">
						              
						                arrayFechasTemp[arrayFechasTemp.length]=new Array('<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>','<xsl:value-of select="./@Clase"/>');
						                
						              </xsl:when>
						              <xsl:otherwise>
						              
						                arrayFechasTemp[arrayFechasTemp.length]=new Array('<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>','grisclaro');
						                
						              </xsl:otherwise>
						            </xsl:choose>
					              
						        </xsl:otherwise>    
						      </xsl:choose>  
						    
						    </xsl:otherwise>
						  </xsl:choose>
						  
					  </xsl:otherwise>
				  </xsl:choose>
						    
	              <!-- fin -->
	        
	        
	        </xsl:for-each>
	      </xsl:for-each>
	    </xsl:for-each>
	</xsl:for-each>
	  
	// montamos una variable con los anyos por los que hemos pasado
	var AnyosVisitados='<xsl:value-of select="/PedidosProgramados/ANYOS_VISITADOS"/>';

	<xsl:variable name="anyoActual"><xsl:value-of select="/PedidosProgramados/CALENDARIOANUAL/@Anyo"/></xsl:variable>
	<xsl:variable name="anyosVisitados"><xsl:value-of select="/PedidosProgramados/ANYOS_VISITADOS"/></xsl:variable>


	// si no hemos pasado por este anyo lo incluimos
	<xsl:if test="not(contains($anyosVisitados,$anyoActual))">
	AnyosVisitados=AnyosVisitados+'<xsl:value-of select="/PedidosProgramados/CALENDARIOANUAL/@Anyo"/>'+'|';
	</xsl:if>
	var arrayEstilos=new Array();
	</script>
</head>  
<xsl:choose>
<xsl:when test="//xsql-error"> 
	<p class="tituloform">     
		<xsl:apply-templates select="//xsql-error"/>
	</p>
</xsl:when>
<xsl:otherwise>
          
           
          
<body onLoad="asignarFondo();">
   <!--idioma-->
    <xsl:variable name="lang">
    <xsl:choose>
        <xsl:when test="/PedidosProgramados/LANG"><xsl:value-of select="/PedidosProgramados/LANG" /></xsl:when>
        <xsl:when test="/PedidosProgramados/LANGTESTI != ''"><xsl:value-of select="/PedidosProgramados/LANGTESTI" /></xsl:when>
        </xsl:choose>  
    </xsl:variable>
    <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
	<!--idioma fin-->

	<form method="POST" name="form1" action="http://www.newco.dev.br/Compras/PedidosProgramados/LanzamientosPedidosProgramados2022.xsql">
		<input type="hidden" name="RESULTADO" value="{/PedidosProgramados/RESULTADO_TMP}"/>
		<input type="hidden" name="FECHAACTIVA">
		  <xsl:choose>
			<xsl:when test="/PedidosProgramados/FECHAACTIVA!=''">
			  <xsl:attribute name="value"><xsl:value-of select="/PedidosProgramados/FECHAACTIVA"/></xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
			  <xsl:attribute name="value"><xsl:value-of select="/PedidosProgramados/CALENDARIOANUAL/FECHAACTUAL"/></xsl:attribute>
			</xsl:otherwise>
		  </xsl:choose>
		</input>
		<input type="hidden" name="ANYOS_VISITADOS"/>
		<input type="hidden" name="ACCION" value="{/PedidosProgramados/ACCION}"/><!--16set22-->
		<!--<input type="hidden" name="READ_ONLY" value="{/PedidosProgramados/READ_ONLY}"/>-->
		<input type="hidden" name="PEDP_ID" value="{/PedidosProgramados/CALENDARIOANUAL/IDPROGRAMA}"/>
		<!--<input type="hidden" name="VENTANA" value="{/PedidosProgramados/VENTANA}"/>
		<input type="hidden" name="DESDEOFERTA" value="{/PedidosProgramados/DESDEOFERTA}"/>-->

		<input type="hidden" name="ANYO">
			<xsl:attribute name="value"><xsl:value-of select="/PedidosProgramados/CALENDARIOANUAL/@Anyo"/></xsl:attribute>
		</input>
	</form>

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
				<xsl:value-of select="/PedidosProgramados/CALENDARIOANUAL/PROGRAMA"/>
				&nbsp;&nbsp;
				<span class="CompletarTitulo" style="width:600px;">
      				<!-- solo mostramos el de anterior si no estamos al inicio del rango -->
    			  	<xsl:for-each select="/PedidosProgramados/CALENDARIOANUAL/ANYO/field/dropDownList/listElem">
	    			  <xsl:if test="position()=1">
	        			  <xsl:if test="not(ID=//PedidosProgramados/CALENDARIOANUAL/@Anyo)">
             			 	 <a class="btnNormal" href="javascript:IncrementarAnyo(-1);"><xsl:value-of select="document($doc)/translation/texts/item[@name='anterior']/node()"/></a>
	        			  </xsl:if>
	    			  </xsl:if>
	    			</xsl:for-each>
					<!--	Sin accion no tiene sentido el boton de enviar formulario	-->
					<xsl:choose>
					  <xsl:when test="/PedidosProgramados/CALENDARIOANUAL/EDICION">
						  <xsl:if test="/PedidosProgramados/CALENDARIOANUAL/@Accion">
							  <tr valign="top">
				    			<td align="center" colspan="2">
	            					  <xsl:choose>
	            		    			<xsl:when test="//PedidosProgramados/ACTUALIZARPAGINA='S'">
											<a class="btnNormal" href="javascript:CerrarVentana();"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>
	            		    			</xsl:when>
	            		    			<xsl:otherwise>
											<a class="btnNormal" href="javascript:CerrarVentana();"><xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/></a>
	            		    			</xsl:otherwise>
	            					  </xsl:choose>
								  </td>		
								  <td align="center" colspan="2">
										<a class="btnDestacado" href="javascript:Guardar();"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
								  </td>				
							  </tr>

						  </xsl:if>
					  </xsl:when>
					  <xsl:otherwise>
		    			<tr valign="top">
								  <td align="center" colspan="4">
									<a class="btnNormal" href="javascript:CerrarVentana();"><xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/></a>
								  </td>				
							  </tr>
					  </xsl:otherwise>
					</xsl:choose>
	  
	    			<!-- solo mostramos el de siguiente si no estamos al final del rango -->
	    			<xsl:for-each select="/PedidosProgramados/CALENDARIOANUAL/ANYO/field/dropDownList/listElem">
        				<xsl:if test="position()=last()">
	        				<xsl:if test="not(ID=//PedidosProgramados/CALENDARIOANUAL/@Anyo)">
            			  		<a class="btnNormal" href="javascript:IncrementarAnyo(1);"><xsl:value-of select="document($doc)/translation/texts/item[@name='siguiente']/node()"/></a>&nbsp;
 	        				</xsl:if>
	    				</xsl:if>
	    			</xsl:for-each>
				</span>
			</p>
		</div>
		<br/>
	
	<table width="95%" border="0" align="center" cellspacing="10" cellpadding="10">
		<xsl:for-each select="/PedidosProgramados/CALENDARIOANUAL/LINEA">
			<tr valign="top">
				<xsl:for-each select="./CALENDARIO">
					<td align="center">
						<table width="200" border="0" align="center" cellspacing="2" cellpadding="2" class="calendario">
							<xsl:apply-templates select="."/>
						</table>
					</td>				
				</xsl:for-each>	
			</tr>
		</xsl:for-each>	
		
  <!-- leyenda de colores -->
<tr>
  <td colspan="4">
    <table border="0" width="100%" cellpadding="1" cellspacing="1">
      <tr>
        <td align="left" width="30%">
          <table cellpadding="0" cellspacing="0" align="left" width="100%" border="0">
            <tr>
              <td width="1px">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              </td>
              <td width="30px">
                <table cellpadding="1" cellspacing="1" align="left" width="25px" class="oscuro">
                  <tr>
                    <td class="diasVacacionesCliente" align="center">
                      día
                    </td>
                  </tr>
                </table>
              </td>
              <td width="*">
                &nbsp;reservado por el cliente.
              </td>
            </tr>
          </table>
        </td>
        <td align="left" width="30%">
          <table cellpadding="0" cellspacing="0" align="left" width="100%" border="0">
            <tr>
              <td width="1px">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              </td>
              <td width="30px">
                <table cellpadding="1" cellspacing="1" align="left" width="25px" class="oscuro">
                  <tr>
                    <td class="diasVacacionesProveedor" align="center">
                      día
                    </td>
                  </tr>
                </table>
              </td>
              <td>
                &nbsp;reservado por el proveedor.
              </td>
            </tr>
          </table>
        </td>
        <td align="left" width="30%">
          <table cellpadding="0" cellspacing="0" align="left" width="100%" border="0">
            <tr>
              <td width="1px">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              </td>
              <td width="30px">
                <table cellpadding="1" cellspacing="1" align="left" width="25px" class="oscuro">
                  <tr>
                    <td class="diasLanzamientosCorrectos" align="center">
                      día
                    </td>
                  </tr>
                </table>
              </td>
              <td>
                &nbsp;de entrega.
              </td>
            </tr>
          </table>
        </td>
      </tr>
    
    </table>
  </td>
</tr>
	</table>
</body>
  

</xsl:otherwise>
</xsl:choose>
</html>
</xsl:template>

<!--	"Template" correspondiente al calendario de un mes		-->
<xsl:template match="CALENDARIO">
	<tr>
		<td align="center" class="oscuro" colspan="8" >
			<xsl:value-of select="./@Mes"/>
		</td>
	</tr>
	<tr class="oscuro">
		<td width="9%" align="center">&nbsp;</td>
		<td width="13%" align="center">L</td>
		<td width="13%" align="center">M</td>
		<td width="13%" align="center">X</td>
		<td width="13%" align="center">J</td>
		<td width="13%" align="center">V</td>
		<td width="13%" align="center">S</td>	
		<td width="13%" align="center">D</td>
	</tr>
	<xsl:for-each select="./SEMANA">
		<tr>
			<!--	Semana		-->
			<td align="center" class="oscuro" >
				S<xsl:value-of select="./@Numero"/>
			</td>
			<xsl:for-each select="./DIA">
				<td align="center" valign="top">
					<xsl:attribute name="id">CELDA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>
					</xsl:attribute>
					<xsl:attribute name="name">CELDA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>
					</xsl:attribute>
					<!-- asignamos el fondo del TD -->
				  	<xsl:choose>
					    <!-- estamos en edicion, hay enlaces -->
				   		<xsl:when test="/PedidosProgramados/CALENDARIOANUAL/EDICION">

						  <xsl:variable name="anyosVisitados"><xsl:value-of select="//PedidosProgramados/ANYOS_VISITADOS"/></xsl:variable>
						  <xsl:variable name="anyoActual"><xsl:value-of select="//PedidosProgramados/CALENDARIOANUAL/@Anyo"/></xsl:variable>
						  
						  <xsl:choose>
						      <!-- miramos en los temporales -->
						    <xsl:when test="contains($anyosVisitados,$anyoActual)">
						      
						      <!--++++++++++++++++++
						          los temporales
						      ++++++++++++++++++++-->
						      <xsl:variable name="resultado_tmp"><xsl:value-of select="//PedidosProgramados/RESULTADO_TMP"/></xsl:variable>
						      <xsl:variable name="diaActual">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:variable>
						      <xsl:choose>
						         <!-- es lanzamiento (tmp) -->
						        
						        <xsl:when test="contains($resultado_tmp,$diaActual)">
					            <!-- miramos si es un lanzamiento valido (tmp) esto es, no es fiesta de nadie-->
					            <xsl:choose>
					                <!-- fiesta del proveedor , no es valido -->
						            <xsl:when test="./@VacacionesProveedor='S' and not(./@Vacaciones='S')">
						                
						                  <!--<xsl:attribute name="class">diasLanzamientosConflictos</xsl:attribute>-->
						                  <xsl:attribute name="class">diasVacacionesProveedor</xsl:attribute>
						                  
						            </xsl:when>
						              <!-- fiesta del cliente , no es valido -->
						            <xsl:when test="./@Vacaciones='S'">
						                  
						                  <!--<xsl:attribute name="class">diasLanzamientosConflictos</xsl:attribute>-->
						                  <xsl:attribute name="class">diasVacacionesCliente</xsl:attribute>

						            </xsl:when>
						               <!-- lanzamiento valido -->
						            <xsl:otherwise>
						                
						                <!--<xsl:attribute name="class">diasLanzamientosCorrectos</xsl:attribute>-->
						                <xsl:choose>
						                <xsl:when test="./@Clase">
						                  <xsl:attribute name="class"><xsl:value-of select="./@Clase"/></xsl:attribute>
						                </xsl:when>
						                <xsl:otherwise>
						                  <xsl:attribute name="class">grisclaro</xsl:attribute>
						                </xsl:otherwise>
						              </xsl:choose>

						            </xsl:otherwise>    
						          </xsl:choose>

					          </xsl:when>
					            <!-- no es lanzamiento (tmp) -->
					          <xsl:otherwise>
					      
					            <!-- este dia no esta marcado como lanzamiento mostramos si es fiesta del proveedor o del cliente
						               si es de ambos tiene preferencia la del cliente
						               si no, lo podemos asignar como lanzamiento sera un enlace -->
						          <xsl:choose>
						               <!-- fiesta del proveedor no puede ser lanzamiento -->
						            <xsl:when test="./@VacacionesProveedor='S' and not(./@Vacaciones='S')">
						              
						              <xsl:attribute name="class">diasVacacionesProveedor</xsl:attribute>
					                
						            </xsl:when>
						               <!-- fiesta del cliente no puede ser lanzamiento -->
						            <xsl:when test="./@Vacaciones='S'">
						              
						              <xsl:attribute name="class">diasVacacionesCliente</xsl:attribute>
					                
						            </xsl:when> 
						              <!--candidato a ser un lanzamiento -->
						            <xsl:otherwise>

						              <xsl:choose>
						                <xsl:when test="./@Clase">
						                  <xsl:attribute name="class"><xsl:value-of select="./@Clase"/></xsl:attribute>
						                </xsl:when>
						                <xsl:otherwise>
						                  <xsl:attribute name="class">grisclaro</xsl:attribute>
						                </xsl:otherwise>
						              </xsl:choose>

						            </xsl:otherwise>
						          </xsl:choose>
						      
					          </xsl:otherwise>
					        </xsl:choose> 
						      
						      
						      <!--+++++++++++++++++++
						        fin los temporales
						      +++++++++++++++++++++-->
						      
						      
						      
						    </xsl:when>
						           <!-- miramos en la BD -->
						    <xsl:otherwise>
						      <xsl:choose>
						         <!-- es lanzamiento (BD) -->
						        <xsl:when test="./@Lanzamiento='S'">
					            <!-- miramos si es un lanzamineto valido (BD) esto es, no es fiesta de nadie-->
					            <xsl:choose>
					                <!-- fiesta del proveedor , no es valido -->
						            <xsl:when test="./@VacacionesProveedor='S' and not(./@Vacaciones='S')">
						                
						              <!--<xsl:attribute name="class">diasLanzamientosConflictos</xsl:attribute>-->
						              <xsl:attribute name="class">diasVacacionesProveedor</xsl:attribute>

						            </xsl:when>
						              <!-- fiesta del cliente , no es valido -->
						            <xsl:when test="./@Vacaciones='S'">
						                
						              <!--<xsl:attribute name="class">diasLanzamientosConflictos</xsl:attribute>-->
						              <xsl:attribute name="class">diasVacacionesCliente</xsl:attribute>

						            </xsl:when>
						               <!-- lanzamiento valido -->
						            <xsl:otherwise>
						              
						              <!--<xsl:attribute name="class">diasLanzamientosCorrectos</xsl:attribute>-->
						              <xsl:choose>
						                <xsl:when test="./@Clase">
						                  <xsl:attribute name="class"><xsl:value-of select="./@Clase"/></xsl:attribute>
						                </xsl:when>
						                <xsl:otherwise>
						                  <xsl:attribute name="class">grisclaro</xsl:attribute>
						                </xsl:otherwise>
						              </xsl:choose>

						            </xsl:otherwise>    
						          </xsl:choose>

					          </xsl:when>
					            <!-- no es lanzamiento (BD) -->
					          <xsl:otherwise>
					      
					            <!-- este dia no esta marcado como lanzamiento mostramos si es fiesta del proveedor o del cliente
						               si es de ambos tiene preferencia la del cliente
						               si no, lo podemos asignar como lanzamiento sera un enlace -->
						          <xsl:choose>
						               <!-- fiesta del proveedor no puede ser lanzamiento -->
						            <xsl:when test="./@VacacionesProveedor='S' and not(./@Vacaciones='S')">
						              
						              <xsl:attribute name="class">diasVacacionesProveedor</xsl:attribute>
						              
						            </xsl:when>
						               <!-- fiesta del cliente no puede ser lanzamiento -->
						            <xsl:when test="./@Vacaciones='S'">
						              
						              <xsl:attribute name="class">diasVacacionesCliente</xsl:attribute>
						              
						            </xsl:when> 
						              <!--candidato a ser un lanzamiento -->
						            <xsl:otherwise>

						              <xsl:choose>
						                <xsl:when test="./@Clase">
						                  <xsl:attribute name="class"><xsl:value-of select="./@Clase"/></xsl:attribute>
						                </xsl:when>
						                <xsl:otherwise>
						                  <xsl:attribute name="class">grisclaro</xsl:attribute>
						                </xsl:otherwise>
						              </xsl:choose>

						            </xsl:otherwise>
						          </xsl:choose>
						      
					          </xsl:otherwise>
					        </xsl:choose> 
					        
					      </xsl:otherwise>
					    </xsl:choose>
					    
					  </xsl:when>
					  
					 <!-- READ_ONLY -->
					  <xsl:otherwise>
					       <!-- asignamos colores, e informamos de las fechas conflictivas (en principio no deberia haber ninguna)
					            ya que el cliente deberia haber congifurado los lanzamientos correctamente -->
						  <xsl:choose> 
						        <!-- es lanzamiento, miramos si hay conflictos --> 
						    <xsl:when test="./@Lanzamiento='S'">
						    
						      <xsl:choose>
					              <!-- fiesta del proveedor , conflicto -->
						        <xsl:when test="./@VacacionesProveedor='S' and not(./@Vacaciones='S')">
						            
						          <!--<xsl:attribute name="class">diasLanzamientosConflictos</xsl:attribute>-->
						          <xsl:attribute name="class">diasVacacionesProveedor</xsl:attribute>
						          
						          
						        </xsl:when>
						           <!-- fiesta del cliente ,  conflicto -->
						        <xsl:when test="./@Vacaciones='S'">
						            
						          <!--<xsl:attribute name="class">diasLanzamientosConflictos</xsl:attribute>-->
						          <xsl:attribute name="class">diasVacacionesCliente</xsl:attribute>
						               
						        </xsl:when>
						               <!-- lanzamiento valido, no hay conflicto -->
						        <xsl:otherwise>
						          
						          <!--<xsl:attribute name="class">diasLanzamientosCorrectos</xsl:attribute>-->
						              <xsl:choose>
						                <xsl:when test="./@Clase">
						                  <xsl:attribute name="class"><xsl:value-of select="./@Clase"/></xsl:attribute>
						                </xsl:when>
						                <xsl:otherwise>
						                  <xsl:attribute name="class">grisclaro</xsl:attribute>
						                </xsl:otherwise>
						              </xsl:choose>
						               
						        </xsl:otherwise>    
						      </xsl:choose>
						      
						    </xsl:when>
						       <!-- no es lanzamiento, mostramos las fiestas de los usuarios-->
						    <xsl:otherwise> 
						      
						      <xsl:choose>
					              <!-- fiesta del proveedor , conflicto -->
						        <xsl:when test="./@VacacionesProveedor='S' and not(./@Vacaciones='S')">
						          
						          <xsl:attribute name="class">diasVacacionesProveedor</xsl:attribute>
						          
						        </xsl:when>
						           <!-- fiesta del cliente ,  conflicto -->
						        <xsl:when test="./@Vacaciones='S'">
						          
						          <xsl:attribute name="class">diasVacacionesCliente</xsl:attribute>
						            
						        </xsl:when>
						               <!-- lanzamiento valido, no hay conflicto -->
						        <xsl:otherwise>
					              
					              <xsl:choose>
						              <xsl:when test="./@Clase">
						                <xsl:attribute name="class"><xsl:value-of select="./@Clase"/></xsl:attribute>
						              </xsl:when>
						              <xsl:otherwise>
						                <xsl:attribute name="class">grisclaro</xsl:attribute>
						              </xsl:otherwise>
						            </xsl:choose>
					              
						        </xsl:otherwise>    
						      </xsl:choose>  
						    
						    </xsl:otherwise>
						  </xsl:choose>
						  
					  </xsl:otherwise>
				  </xsl:choose>
						    
					
					      <!-- guardamos el valor del estilo en un array -->
					      <xsl:choose>
							    <xsl:when test="./@Clase">
							      <xsl:choose>
						             <!-- fiesta del proveedor no puede ser lanzamiento -->
						          <xsl:when test="./@VacacionesProveedor='S' and not(./@Vacaciones='S')">
						                <script type="text/javascript">
				                      arrayEstilos[arrayEstilos.length]=new Array('FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>','diasVacacionesProveedor');
					                  </script>
					                  
						          </xsl:when>
						             <!-- fiesta del cliente no puede ser lanzamiento -->
						          <xsl:when test="./@Vacaciones='S'">
						            
						                <script type="text/javascript">
				                      arrayEstilos[arrayEstilos.length]=new Array('FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>','diasVacacionesCliente');
					                  </script>
						              
						          </xsl:when> 
						              <!--candidato a ser un lanzamiento -->
						          <xsl:otherwise>
						            <script type="text/javascript">
				                  arrayEstilos[arrayEstilos.length]=new Array('FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>','<xsl:value-of select="./@Clase"/>');
					              </script>
						          </xsl:otherwise>
						        </xsl:choose>
							    </xsl:when>
							      <!-- no tiene ningun estilo predefinido -->
							    <xsl:otherwise>
							      <script type="text/javascript">
				              arrayEstilos[arrayEstilos.length]=new Array('FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>','grisclaro');
					          </script>
							    </xsl:otherwise>
						    </xsl:choose>
						    
					 <!-- miramos si estamos en edicion o en READ_ONLY -->
					<xsl:choose>
					    <!-- estamos en edicion, hay enlaces -->
				    <xsl:when test="/PedidosProgramados/CALENDARIOANUAL/EDICION">

						  <xsl:variable name="anyosVisitados"><xsl:value-of select="//PedidosProgramados/ANYOS_VISITADOS"/></xsl:variable>
						  <xsl:variable name="anyoActual"><xsl:value-of select="//PedidosProgramados/CALENDARIOANUAL/@Anyo"/></xsl:variable>
						  
						  <xsl:choose>
						      <!-- miramos en los temporales -->
						    <xsl:when test="contains($anyosVisitados,$anyoActual)">
						      
						      <!--++++++++++++++++++
						          los temporales
						      ++++++++++++++++++++-->

						      
						      <xsl:variable name="resultado_tmp"><xsl:value-of select="//PedidosProgramados/RESULTADO_TMP"/></xsl:variable>
						      <xsl:variable name="diaActual">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:variable>
						      <xsl:choose>
						         <!-- es lanzamiento (tmp) -->
						        
						        <xsl:when test="contains($resultado_tmp,$diaActual)">
					            <!-- miramos si es un lanzamiento valido (tmp) esto es, no es fiesta de nadie-->
					            <xsl:choose>
					                <!-- fiesta del proveedor , no es valido -->
						            <xsl:when test="./@VacacionesProveedor='S' and not(./@Vacaciones='S')">
						                <a onMouseOver="window.status='Marcar este día';return true;" onMouseOut="window.status='';return true;" >
						                  <xsl:attribute name="name">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:attribute>
						                  <xsl:attribute name="id">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:attribute>
						                  <xsl:attribute name="href">javascript:Pulsado('FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>');</xsl:attribute>
						                  <!--<xsl:attribute name="class">diasLanzamientosConflictos</xsl:attribute>-->
						                  <!--<xsl:attribute name="style">color:white;font-weight:bold;</xsl:attribute>-->
						                  <xsl:attribute name="class">diasVacacionesProveedor</xsl:attribute>
						                  <xsl:attribute name="style">color:white;font-weight:bold;</xsl:attribute>
						                  
						                  <xsl:value-of select="./@Numero"/>
					                  </a>
						            </xsl:when>
						              <!-- fiesta del cliente , no es valido -->
						            <xsl:when test="./@Vacaciones='S'">
						                <a onMouseOver="window.status='Marcar este día';return true;" onMouseOut="window.status='';return true;" >
						                  <xsl:attribute name="name">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:attribute>
						                  <xsl:attribute name="id">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:attribute>
						                  <xsl:attribute name="href">javascript:Pulsado('FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>');</xsl:attribute>
						                  <!--<xsl:attribute name="class">diasLanzamientosConflictos</xsl:attribute>-->
						                  <!--<xsl:attribute name="style">color:white;font-weight:bold;</xsl:attribute>-->
						                  <xsl:attribute name="class">diasVacacionesCliente</xsl:attribute>
						                  <xsl:attribute name="style">color:black;font-weight:bold;</xsl:attribute>

						                  <xsl:value-of select="./@Numero"/>
					                  </a>
						            </xsl:when>
						               <!-- lanzamiento valido -->
						            <xsl:otherwise>
						              <a onMouseOver="window.status='Marcar este día';return true;" onMouseOut="window.status='';return true;" >
						                <xsl:attribute name="name">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:attribute>
						                <xsl:attribute name="id">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:attribute>
						                <xsl:attribute name="href">javascript:Pulsado('FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>');</xsl:attribute>
						                <!--<xsl:attribute name="class">diasLanzamientosCorrectos</xsl:attribute>-->
						                <!--<xsl:attribute name="style">color:white;font-weight:bold;</xsl:attribute>-->
						                <xsl:choose>
						                  <xsl:when test="./@Clase">
						                    <xsl:attribute name="class"><xsl:value-of select="./@Clase"/></xsl:attribute>
						                  </xsl:when>
						                  <xsl:otherwise>
						                    <xsl:attribute name="class">grisclaro</xsl:attribute>
						                  </xsl:otherwise>
						                </xsl:choose>

						                <xsl:value-of select="./@Numero"/>
					                </a>
						            </xsl:otherwise>    
						          </xsl:choose>

					          </xsl:when>
					            <!-- no es lanzamiento (tmp) -->
					          <xsl:otherwise>
					      
					            <!-- este dia no esta marcado como lanzamiento mostramos si es fiesta del proveedor o del cliente
						               si es de ambos tiene preferencia la del cliente
						               si no, lo podemos asignar como lanzamiento sera un enlace -->
						          <xsl:choose>
						               <!-- fiesta del proveedor no puede ser lanzamiento -->
						            <xsl:when test="./@VacacionesProveedor='S' and not(./@Vacaciones='S')">
						              <a onMouseOver="window.status='Marcar este día';return true;" onMouseOut="window.status='';return true;" >
						                  <xsl:attribute name="name">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:attribute>
						                  <xsl:attribute name="id">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:attribute>
						                  <xsl:attribute name="href">javascript:Pulsado('FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>');</xsl:attribute>
						                  <xsl:attribute name="class">diasVacacionesProveedor</xsl:attribute>
						                  <xsl:attribute name="style">color:white;font-weight:bold;</xsl:attribute>

						                  <xsl:value-of select="./@Numero"/>
					                </a>
					                
						            </xsl:when>
						               <!-- fiesta del cliente no puede ser lanzamiento -->
						            <xsl:when test="./@Vacaciones='S'">
						              <a onMouseOver="window.status='Marcar este día';return true;" onMouseOut="window.status='';return true;" >
						                  <xsl:attribute name="name">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:attribute>
						                  <xsl:attribute name="id">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:attribute>
						                  <xsl:attribute name="href">javascript:Pulsado('FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>');</xsl:attribute>
						                  <xsl:attribute name="class">diasVacacionesCliente</xsl:attribute>
						                  <xsl:attribute name="style">color:black;font-weight:bold;</xsl:attribute>

						                  <xsl:value-of select="./@Numero"/>
					                </a>
					                
						            </xsl:when> 
						              <!--candidato a ser un lanzamiento -->
						            <xsl:otherwise>

						              <a onMouseOver="window.status='Marcar este día';return true;" onMouseOut="window.status='';return true;" >
						                <xsl:attribute name="name">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:attribute>
						                <xsl:attribute name="id">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:attribute>
						                <xsl:attribute name="href">javascript:Pulsado('FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>');</xsl:attribute>
						                <xsl:choose>
						                  <xsl:when test="./@Clase">
						                    <xsl:attribute name="class"><xsl:value-of select="./@Clase"/></xsl:attribute>
						                  </xsl:when>
						                  <xsl:otherwise>
						                    <xsl:attribute name="class">grisclaro</xsl:attribute>
						                  </xsl:otherwise>
						                </xsl:choose>

						                <xsl:value-of select="./@Numero"/>
					                </a>

						            </xsl:otherwise>
						          </xsl:choose>
						      
					          </xsl:otherwise>
					        </xsl:choose> 
						      
						      
						      <!--+++++++++++++++++++
						        fin los temporales
						      +++++++++++++++++++++-->
						      
						      
						      
						    </xsl:when>
						           <!-- miramos en la BD -->
						    <xsl:otherwise>
						      <xsl:choose>
						         <!-- es lanzamiento (BD) -->
						        <xsl:when test="./@Lanzamiento='S'">
					            <!-- miramos si es un lanzamineto valido (BD) esto es, no es fiesta de nadie-->
					            <xsl:choose>
					                <!-- fiesta del proveedor , no es valido -->
						            <xsl:when test="./@VacacionesProveedor='S' and not(./@Vacaciones='S')">
						                <a onMouseOver="window.status='Marcar este día';return true;" onMouseOut="window.status='';return true;" >
						                  <xsl:attribute name="name">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:attribute>
						                  <xsl:attribute name="id">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:attribute>
						                  <xsl:attribute name="href">javascript:Pulsado('FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>');</xsl:attribute>
						                  <!--<xsl:attribute name="class">diasLanzamientosConflictos</xsl:attribute>-->
						                  <!--<xsl:attribute name="style">color:white;font-weight:bold;</xsl:attribute>-->
						                  <xsl:attribute name="class">diasVacacionesProveedor</xsl:attribute>
						                  <xsl:attribute name="style">color:white;font-weight:bold;</xsl:attribute>

						                  <xsl:value-of select="./@Numero"/>
					                  </a>
						            </xsl:when>
						              <!-- fiesta del cliente , no es valido -->
						            <xsl:when test="./@Vacaciones='S'">
						                <a onMouseOver="window.status='Marcar este día';return true;" onMouseOut="window.status='';return true;" >
						                  <xsl:attribute name="name">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:attribute>
						                  <xsl:attribute name="id">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:attribute>
						                  <xsl:attribute name="href">javascript:Pulsado('FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>');</xsl:attribute>
						                  <!--<xsl:attribute name="class">diasLanzamientosConflictos</xsl:attribute>-->
						                  <!--<xsl:attribute name="style">color:white;font-weight:bold;</xsl:attribute>-->
						                  <xsl:attribute name="class">diasVacacionesCliente</xsl:attribute>
						                  <xsl:attribute name="style">color:black;font-weight:bold;</xsl:attribute>

						                  <xsl:value-of select="./@Numero"/>
					                  </a>
						            </xsl:when>
						               <!-- lanzamiento valido -->
						            <xsl:otherwise>
						              <a onMouseOver="window.status='Marcar este día';return true;" onMouseOut="window.status='';return true;" >
						                <xsl:attribute name="name">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:attribute>
						                <xsl:attribute name="id">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:attribute>
						                <xsl:attribute name="href">javascript:Pulsado('FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>');</xsl:attribute>
						                <!--<xsl:attribute name="class">diasLanzamientosCorrectos</xsl:attribute>-->
						                <!--<xsl:attribute name="style">color:white;font-weight:bold;</xsl:attribute>-->
						                <xsl:choose>
						                  <xsl:when test="./@Clase">
						                    <xsl:attribute name="class"><xsl:value-of select="./@Clase"/></xsl:attribute>
						                  </xsl:when>
						                  <xsl:otherwise>
						                    <xsl:attribute name="class">grisclaro</xsl:attribute>
						                  </xsl:otherwise>
						                </xsl:choose>

						                <xsl:value-of select="./@Numero"/>
					                </a>
						            </xsl:otherwise>    
						          </xsl:choose>

					          </xsl:when>
					            <!-- no es lanzamiento (BD) -->
					          <xsl:otherwise>
					      
					            <!-- este dia no esta marcado como lanzamiento mostramos si es fiesta del proveedor o del cliente
						               si es de ambos tiene preferencia la del cliente
						               si no, lo podemos asignar como lanzamiento sera un enlace -->
						          <xsl:choose>
						               <!-- fiesta del proveedor no puede ser lanzamiento -->
						            <xsl:when test="./@VacacionesProveedor='S' and not(./@Vacaciones='S')">
						              <a onMouseOver="window.status='Marcar este día';return true;" onMouseOut="window.status='';return true;" >
						                  <xsl:attribute name="name">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:attribute>
						                  <xsl:attribute name="id">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:attribute>
						                  <xsl:attribute name="href">javascript:Pulsado('FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>');</xsl:attribute>
						                  <xsl:attribute name="class">diasVacacionesProveedor</xsl:attribute>
						                  <xsl:attribute name="style">color:white;font-weight:bold;</xsl:attribute>

						                  <xsl:value-of select="./@Numero"/>
					                </a>
						            </xsl:when>
						               <!-- fiesta del cliente no puede ser lanzamiento -->
						            <xsl:when test="./@Vacaciones='S'">
						              <a onMouseOver="window.status='Marcar este día';return true;" onMouseOut="window.status='';return true;" >
						                  <xsl:attribute name="name">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:attribute>
						                  <xsl:attribute name="id">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:attribute>
						                  <xsl:attribute name="href">javascript:Pulsado('FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>');</xsl:attribute>
						                  <xsl:attribute name="class">diasVacacionesCliente</xsl:attribute>
						                  <xsl:attribute name="style">color:black;font-weight:bold;</xsl:attribute>

						                  <xsl:value-of select="./@Numero"/>
					                </a>
						            </xsl:when> 
						              <!--candidato a ser un lanzamiento -->
						            <xsl:otherwise>

						              <a onMouseOver="window.status='Marcar este día';return true;" onMouseOut="window.status='';return true;" >
						                <xsl:attribute name="name">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:attribute>
						                <xsl:attribute name="id">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:attribute>
						                <xsl:attribute name="href">javascript:Pulsado('FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>');</xsl:attribute>

						                <xsl:choose>
						                  <xsl:when test="./@Clase">
						                    <xsl:attribute name="class"><xsl:value-of select="./@Clase"/></xsl:attribute>
						                  </xsl:when>
						                  <xsl:otherwise>
						                    <xsl:attribute name="class">grisclaro</xsl:attribute>
						                  </xsl:otherwise>
						                </xsl:choose>
						                
						                <xsl:value-of select="./@Numero"/>
					                </a>

						            </xsl:otherwise>
						          </xsl:choose>
						      
					          </xsl:otherwise>
					        </xsl:choose> 
					        
					      </xsl:otherwise>
					    </xsl:choose>
					    
					  </xsl:when>
					  
					     <!-- READ_ONLY -->
					  <xsl:otherwise>
					       <!-- asignamos colores, e informamos de las fechas conflictivas (en principio no deberia haber ninguna)
					            ya que el cliente deberia haber congifurado los lanzamientos correctamente -->
						  <xsl:choose> 
						        <!-- es lanzamiento, miramos si hay conflictos --> 
						    <xsl:when test="./@Lanzamiento='S'">
						    
						      <xsl:choose>
					              <!-- fiesta del proveedor , conflicto -->
						        <xsl:when test="./@VacacionesProveedor='S' and not(./@Vacaciones='S')">
					                <xsl:value-of select="./@Numero"/>
						        </xsl:when>
						           <!-- fiesta del cliente ,  conflicto -->
						        <xsl:when test="./@Vacaciones='S'">
					                <xsl:value-of select="./@Numero"/>     
						        </xsl:when>
						               <!-- lanzamiento valido, no hay conflicto -->
						        <xsl:otherwise>
					              <xsl:value-of select="./@Numero"/>     
						        </xsl:otherwise>    
						      </xsl:choose>
						      
						    </xsl:when>
						       <!-- no es lanzamiento, mostramos las fiestas de los usuarios-->
						    <xsl:otherwise> 
						      
						      <xsl:choose>
					              <!-- fiesta del proveedor , conflicto -->
						        <xsl:when test="./@VacacionesProveedor='S' and not(./@Vacaciones='S')">
					              <xsl:value-of select="./@Numero"/>
						        </xsl:when>
						           <!-- fiesta del cliente ,  conflicto -->
						        <xsl:when test="./@Vacaciones='S'">
					              <xsl:value-of select="./@Numero"/>    
						        </xsl:when>
						               <!-- lanzamiento valido, no hay conflicto -->
						        <xsl:otherwise>
					              <xsl:value-of select="./@Numero"/>    
						        </xsl:otherwise>    
						      </xsl:choose>  
						    
						    </xsl:otherwise>
						  </xsl:choose>
						  
					  </xsl:otherwise>
				  </xsl:choose>
				</td>
			</xsl:for-each>	
		</tr>
	</xsl:for-each>	
</xsl:template>

 
</xsl:stylesheet>


<!--
    diasVacacionesCliente {color: #FDD61F; font-weight:bold} 
		diasVacacionesProveedor {color: red; font-weight:bold} 
		diasLanzamientosCorrectos {color: #FC4EC1; font-weight:bold} 
		diasLanzamientosConflictos {color: blue; font-weight:bold} 

-->
