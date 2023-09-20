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
    <html>
      <head>
        <title>Calendario de MedicalVM</title>
		
      <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  
      
     <link rel="stylesheet" href="http://www.newco.dev.br/General/calendarioPedPro.css" type="text/css"/>

	 <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
     <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
        
	<xsl:text disable-output-escaping="yes"><![CDATA[
	
	<script type="text/javascript">
	<!--
	
	
	var msgDiaEntregaFinDeSemana='El día selecionado no corresponde con un día laborable, no puede ser seleccionado como día de entrega.';
	var msgDiaEntregaConflictos='El día seleccionado esta marcado como no hábil por ';
	var confimacionAccionActivo='.\n¿Desea no seleccionarlo como fecha de entrega?';
	var confimacionAccionNoActivo='.\n¿Desea seleccionarlo como fecha de entrega?';
	
	var explicacionNoActivo='\n\n    * Aceptar: selecciona el día como fecha de entrega\n    * Cancelar: no realiza ningún cambio';
	
	var explicacionActivo='\n\n    * Aceptar: deselecciona el día como fecha de entrega\n    * Cancelar: no realiza ningún cambio';
	
	var msgSinLanzamientos='Por favor, seleccione al menos una fecha de entrega';
	
	var msgLanzamientosManuales='¿Desea asignar la frecuencia de entregas como \"Manual\"?\n\nSi no ha realizado ningún cambio en las fechas de entrega le aconsejamos que pulse cancelar';
	
	var msgLanzamientoImposible='';
	
	
	
  var lanzamientoDiasAnteriores=0;
	
	
	
	
	
	
	]]></xsl:text>
	  var plazoEntregaGenerico='<xsl:value-of select="PedidosProgramados/CALENDARIOANUAL/PEDIDOENTREGA/PLAZOENTREGA"/>';
	<xsl:text disable-output-escaping="yes"><![CDATA[
	

	// montamos un array con los anyos posibles  
	
	var arrayAnyos=new Array();
	
	]]></xsl:text>
	  
	  <xsl:for-each select="/PedidosProgramados/CALENDARIOANUAL/ANYO/field/dropDownList/listElem">
	    arrayAnyos[arrayAnyos.length]='<xsl:value-of select="ID"/>';
	  </xsl:for-each>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	

  /* montamos un array con las fechas */
  
	
	]]></xsl:text>
	  var arrayFechasTemp=new Array();
	  <xsl:for-each select="/PedidosProgramados/CALENDARIOANUAL/LINEA">
	    <xsl:for-each select="./CALENDARIO">
	      <xsl:for-each select="./SEMANA">
	        <xsl:for-each select="./DIA">
	        
	              <!-- inicio -->
			     
						    
				  <xsl:choose>
					    <!-- estamos en edicion, hay enlaces -->
				    <xsl:when test="//PedidosProgramados/CALENDARIOANUAL/EDICION and //READ_ONLY!='S'">

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
	<xsl:text disable-output-escaping="yes"><![CDATA[
	
	
	
	
	
	
	function asignarFondo(){
	  
	  
	  
	  for(var n=0;n<arrayFechasTemp.length;n++){
	    var arrFechaActual=arrayFechasTemp[n];
	    if(esFechaLanzamiento(arrFechaActual[1])){
	      if(document.getElementById('CELDA_'+arrFechaActual[0])){
	        asignarFondoAObjeto('CELDA_',arrFechaActual[0],obtenerClase('CELDA_',arrFechaActual[0]));
	      }
	      if(document.getElementById('FECHA_'+arrFechaActual[0])){
	        asignarFondoAObjeto('FECHA_',arrFechaActual[0],obtenerClase('FECHA_',arrFechaActual[0]));
	      }
	    }
	  }
	}
	
	function obtenerClase(prefijo,fecha){

	  var clase;
	  
	   
	  if(document.getElementById(prefijo+fecha).className=='diasVacacionesProveedor' ||
	     document.getElementById(prefijo+fecha).className=='diasVacacionesCliente' ||
	     document.getElementById(prefijo+fecha).className=='grisclaro'){
	    clase='diasLanzamientosConflictos';
	  }
	  else{
	    clase='diasLanzamientosCorrectos';
	  }
	  return clase;
	}
	
	
	
	function esFechaLanzamiento(estilo){
	
	  
	  if(estilo=='diasLanzamientosCorrectos'|| estilo=='diasLanzamientosConflictos'){
	    return true;
	  }
	  else{
	    return false;
	  }
	}
	
	function esVacaciones(fecha){
	

	  if(document.getElementById('FECHA_'+fecha)){
	  	if(document.getElementById('FECHA_'+fecha).className=='diasVacacionesCliente'||
	     	document.getElementById('FECHA_'+fecha).className=='diasVacacionesProveedor'){
	    	return true;   
	  	}
	  	else{
	    	return false;
	  	}
	  }
	  else{
	  	return false;
	  }
	}
	
	
	function asignarFondoAObjeto(prefijo,fecha,estilo){
	  
	  var bgcolorEstilo='';
	  var fontColorEstilo='';
	  var fontWeightEstilo='';
	  var txtDecoration='';
	  
	  //alert(prefijo+fecha+' '+estilo);

	  document.getElementById(prefijo+fecha).className=estilo;
	  
	  
	  switch(estilo){

	    case 'diasLanzamientosCorrectos':
	      bgcolorEstilo='blue';
	      fontColorEstilo='white';
	      fontWeightEstilo='bold';
	    break;
	    
	    case 'diasLanzamientosConflictos':
	      bgcolorEstilo='blue';
	      fontColorEstilo='white';
	      fontWeightEstilo='bold';
	    break;
	    
	    case 'diasAnteriores':
	      bgcolorEstilo='#EBEBEB';
	      fontColorEstilo='black';
	      fontWeightEstilo='normal';
	      txtDecoration='line-through';
	    break;
	    
	    
	  }
	    
	  if(prefijo=='FECHA_'){
	    
	    document.getElementById(prefijo+fecha).style.background=bgcolorEstilo;
	    document.getElementById(prefijo+fecha).style.color=fontColorEstilo;
	    document.getElementById(prefijo+fecha).style.fontWeight=fontWeightEstilo;
	    document.getElementById(prefijo+fecha).style.textDecoration=txtDecoration;
	  }
			  
	}
	
	
	
	
	
	// montamos una variable con los anyos por los que hemos pasado
	
	
	
	]]></xsl:text>
	  
	  var AnyosVisitados='<xsl:value-of select="/PedidosProgramados/ANYOS_VISITADOS"/>';
	  
	  <xsl:variable name="anyoActual"><xsl:value-of select="/PedidosProgramados/CALENDARIOANUAL/@Anyo"/></xsl:variable>
	  <xsl:variable name="anyosVisitados"><xsl:value-of select="/PedidosProgramados/ANYOS_VISITADOS"/></xsl:variable>
	  
	  
	  // si no hemos pasado por este anyo lo incluimos
	  <xsl:if test="not(contains($anyosVisitados,$anyoActual))">
	    AnyosVisitados=AnyosVisitados+'<xsl:value-of select="/PedidosProgramados/CALENDARIOANUAL/@Anyo"/>'+'|';
	  </xsl:if>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	
	
	
	var arrayEstilos=new Array();
	
	//	Funciones de Javascript

	
	function obtenerClasePorDefectoDelDia(objDia){
    for(var n=0;n<arrayEstilos.length;n++){
      if(arrayEstilos[n][0]==objDia){
        return (arrayEstilos[n][1]);
      }
    }    
  }
  
  /* calculamos los diasd habiles teninedo en cuenta las vacaciones */
  
  function calcularDiasHabiles(hoy,incremento, conVacaciones){
	  
      
      // conVacaciones  tenemos en cuenta los dias marcados como vacaciones para los calculos (los tratamos como fin de semana)
   
   var fechaResultado=hoy;
   
   var incrementoDiasHabiles=0;
   
   if(incremento>=0){
     while(incrementoDiasHabiles<incremento){
       fechaResultado=sumaDiasAFecha(fechaResultado,1);  
         /* es dia laborable */
       if(fechaResultado.getDay()!=0 && fechaResultado.getDay()!=6){
          /* controlamos las vacaciones */
         
         if(conVacaciones==true){
              /* no esta marcado como vacaciones */ 
 
           var fechaResultadoTexto=convertirFechaATexto(fechaResultado);
			  
              
              
           if(!esVacaciones(fechaResultadoTexto)){
             incrementoDiasHabiles++;     
           } 
         }
         else{
             /* no lo controlamos, se contabiliza el dia */
           incrementoDiasHabiles++;
         }
       }
       else{
         /* es finde */
         null;
         /* no hacemos nada*/
       }
     }
   }
   else{
     while(incrementoDiasHabiles>incremento){
       fechaResultado=sumaDiasAFecha(fechaResultado,-1);
         /* es dia laborable */  
       if(fechaResultado.getDay()!=0 && fechaResultado.getDay()!=6){
         /* controlamos las vacaciones */
         if(conVacaciones==true){
          /* no esta marcado como vacaciones */ 
          
           var fechaResultadoTexto=convertirFechaATexto(fechaResultado);
              
           if(!esVacaciones(fechaResultadoTexto)){
             incrementoDiasHabiles--;     
           } 
         }
         else{ 
             /* no lo controlamos, se contabiliza el dia */
           incrementoDiasHabiles--;
         }
       }
     }
   }
   
   return(fechaResultado);
 }
  
  
   
	
	
	//	Cambia la clase del "anchor" correspondiente al dia modificado
	function Pulsado(ControlPulsado)
	{
	  var bgcolorEstiloPorDefecto;
	  var clasePorDefecto;
	  var usuario;
	  txtDecoration='';
	  
	  
	  
	  clasePorDefecto=obtenerClasePorDefectoDelDia(document.getElementById(ControlPulsado).name);
	  
	  if(clasePorDefecto=='diasVacacionesCliente'){
	    usuario='usted';
	  }
	  else{
	    usuario='el proveedor';
	  }
	  
	  var id=obtenerId(document.getElementById(ControlPulsado).name);
	  
	  switch(clasePorDefecto){
	    case 'claro':
	      bgcolorEstiloPorDefecto='#EEFFFF';
	      fontColorEstiloPorDefecto='black';
	      fontWeightEstiloPorDefecto='normal';
	    break;
	    
	    case 'oscuro':
	      bgcolorEstiloPorDefecto='#EBEBEB';
	      fontColorEstiloPorDefecto='black';
	      fontWeightEstiloPorDefecto='normal';
	    break;
	    
	    case 'diasVacacionesCliente':
	      bgcolorEstiloPorDefecto='#FDD61F';
	      fontColorEstiloPorDefecto='black';
	      fontWeightEstiloPorDefecto='bold';
	    break;
	    
	    case 'diasVacacionesProveedor':
	      bgcolorEstiloPorDefecto='red';
	      fontColorEstiloPorDefecto='white';
	      fontWeightEstiloPorDefecto='bold';
	    break;
	    
	    case 'grisclaro':
	      bgcolorEstiloPorDefecto='#EBEBEB';
	      fontColorEstiloPorDefecto='black';
	      fontWeightEstiloPorDefecto='normal';
	    break;  
	    
	    case 'diasAnteriores':
	      bgcolorEstiloPorDefecto='#EBEBEB';
	      fontColorEstiloPorDefecto='black';
	      fontWeightEstiloPorDefecto='normal';
	      txtDecoration='line-through';
	    break;
	    
	  }
	  
	  //colorDiasVacacionesCliente='#FDD61F';
	  //colorDiasVacacionesProveedor='red';
		//colorDiasLanzamientosCorrectos='blue';
		//colorDiasLanzamientosConflictos='blue';
		
		
		//alert(clasePorDefecto+' '+ document.getElementById(ControlPulsado).className);
	  
	    
		if (document.getElementById(ControlPulsado).className=='diasLanzamientosCorrectos'||
		    document.getElementById(ControlPulsado).className=='diasLanzamientosConflictos'){
			
			if(document.getElementById(ControlPulsado).className=='diasLanzamientosConflictos'){
			  if(confirm(msgDiaEntregaConflictos+usuario+confimacionAccionActivo+explicacionActivo)){
			    document.getElementById(ControlPulsado).className=clasePorDefecto;
			    document.getElementById('CELDA_'+id).className=clasePorDefecto;
			    document.getElementById(ControlPulsado).style.color=fontColorEstiloPorDefecto;
			    document.getElementById(ControlPulsado).style.background=bgcolorEstiloPorDefecto;
			    document.getElementById(ControlPulsado).style.fontWeight=fontWeightEstiloPorDefecto;
			    document.getElementById(ControlPulsado).blur();
			  }
			}
			else{
			  document.getElementById(ControlPulsado).className=clasePorDefecto;
			  document.getElementById('CELDA_'+id).className=clasePorDefecto;
			  document.getElementById(ControlPulsado).style.color=fontColorEstiloPorDefecto;
			  document.getElementById(ControlPulsado).style.background=bgcolorEstiloPorDefecto;
			  document.getElementById(ControlPulsado).style.fontWeight=fontWeightEstiloPorDefecto;
			  document.getElementById(ControlPulsado).blur();
			}
			
		}
		else{
		  if(document.getElementById(ControlPulsado).className=='diasVacacionesCliente'  ||
		     document.getElementById(ControlPulsado).className=='diasVacacionesProveedor'||
		     document.getElementById(ControlPulsado).className=='grisclaro' ||
		     document.getElementById(ControlPulsado).className=='diasAnteriores'){
		    if(document.getElementById(ControlPulsado).className=='grisclaro'||
		       document.getElementById(ControlPulsado).className=='diasAnteriores'){
		      alert(msgDiaEntregaFinDeSemana);
		    }
		    else{
		      if(confirm(msgDiaEntregaConflictos+usuario+confimacionAccionNoActivo+explicacionNoActivo)){
		        document.getElementById('CELDA_'+id).className='diasLanzamientosConflictos';
		        document.getElementById(ControlPulsado).className='diasLanzamientosConflictos';
			      document.getElementById(ControlPulsado).style.color='white';
			      document.getElementById(ControlPulsado).style.background='blue';
			      document.getElementById(ControlPulsado).style.fontWeight='bold';
			      document.getElementById(ControlPulsado).blur(); 
			    }
			  }
		  }
		  else{
			  document.getElementById(ControlPulsado).className='diasLanzamientosCorrectos';
			  document.getElementById('CELDA_'+id).className='diasLanzamientosCorrectos';
			  document.getElementById(ControlPulsado).style.color='white';
			  document.getElementById(ControlPulsado).style.background='blue';
			  document.getElementById(ControlPulsado).style.fontWeight='bold';
			  document.getElementById(ControlPulsado).blur();
			}
	  }
	}
	
	// funcion para montar la cadena de resultados
	function montarCadenaResultados(){

	  ]]></xsl:text>
	    var anyoActual='<xsl:value-of select="//PedidosProgramados/CALENDARIOANUAL/@Anyo"/>';
	  <xsl:text disable-output-escaping="yes"><![CDATA[
	  
	  /* quitamos las vacaciones de este anyo y las volvemos a montar, junto con los demas anyos*/
	  
	    
	    
	    var arrayResultadoTmp=document.forms['form1'].elements['RESULTADO'].value.split('·');
	  
	    
	    var Resultado='';
	    
	    for(var n=0;n<arrayResultadoTmp.length;n++){
	      if(arrayResultadoTmp[n]!=''){
	        arrTmp=arrayResultadoTmp[n].split('|');
	        if(!existeSubCadena(arrTmp[0], anyoActual)){
	          Resultado+=arrTmp[0]+'|'+arrTmp[1]+'·';
	        }
	      }
	    }

       /* tratamos las de este anyo */	  



		for (i=0;i<document.anchors.length;++i)
		{
		
		    
		
			if (document.anchors[i].className=="diasLanzamientosCorrectos"||document.anchors[i].className=="diasLanzamientosConflictos"){
			
			  var fFechaEntrega=new Date(formatoFecha(document.anchors[i].name.replace('FECHA_',''),'E','I'));
		    var fFechaLanzamiento=calcularDiasHabiles(new Date(formatoFecha(document.anchors[i].name.replace('FECHA_',''),'E','I')),-plazoEntregaGenerico,true);
		    
		    var plazoEntrega=diferenciaDias(fFechaLanzamiento,fFechaEntrega,'HABILES');
				Resultado=Resultado+document.anchors[i].name+'|'+plazoEntrega+'·';
		  }
		}
		
		return Resultado;
	  
	}
	
	

	//	Guarda los cambios creando una cadena a partir de los "anchor" correspondientes a los dias modificados
	function Guardar()
	{
		
    document.forms[0].elements['ANYOS_VISITADOS'].value=AnyosVisitados;
		document.forms[0].elements['RESULTADO'].value=montarCadenaResultados();
		
		/**/
		
		/* la cadena resultado contine las fechas con el siguiente formato:
		      FECHA_xx/xx/xxx|FECHA_xx/xx/xxxx|...
		   el formato que necesitamos es 
		      xx/xx/xxx|xx/xx/xxxx|...
		 */
		var arrayFechas=document.forms[0].elements['RESULTADO'].value.split('·');
		var resultado='';
		
		//alert(arrayFechas);
		
		lanzamientoDiasAnteriores=0;
		
		for(var n=0;n<arrayFechas.length;n++){
		  if(arrayFechas[n]!=''){
		    /* 
		      hemos de calcular el dia de lanzamiento y el plazo de entrega 
		    */
		    
		    var arrTmp=arrayFechas[n].split('|');
		    
		    var fFechaEntrega=new Date(formatoFecha(arrTmp[0].replace('FECHA_',''),'E','I'));
		    var FechaEntrega=convertirFechaATexto(fFechaEntrega);
		    var fFechaLanzamiento=calcularDiasHabiles(new Date(formatoFecha(arrTmp[0].replace('FECHA_',''),'E','I')),-arrTmp[1],false);

        var FechaLanzamiento=convertirFechaATexto(fFechaLanzamiento);
		    
        resultado+=FechaLanzamiento+'|'+arrTmp[1]+'#';
        
        if(obtenerClasePorDefectoDelDia('FECHA_'+FechaEntrega)=='diasAnteriores'){
          if(lanzamientoDiasAnteriores==0){
            lanzamientoDiasAnteriores=1;
            msgLanzamientoImposible='Las siguientes fechas de entrega no son válidas:\n\n  * '+FechaEntrega+'\n';
            
          }
          else{
            msgLanzamientoImposible+='  * '+FechaEntrega+'\n';
          }
        }
        
        
        
      }
    }	
    
    msgLanzamientoImposible+='\nPor favor, corrijalas antes de guardar los cambios';
    
    	
		
		
		document.forms[0].elements['RESULTADO'].value=resultado;
		
		/**/
		

		
		
		//	Envia el formulario
		
		//alert('-'+document.forms[0].elements['RESULTADO'].value+'-');

		if(document.forms[0].elements['RESULTADO'].value==''){
		  alert(msgSinLanzamientos);
		}
		else{
		    
		 ]]></xsl:text>
		   var actualizarPagina='<xsl:value-of select="/PedidosProgramados/ACTUALIZARPAGINA"/>';   
		 <xsl:text disable-output-escaping="yes"><![CDATA[
		    
		  //if(actualizarPagina=='S'){
		  //  if(confirm(msgLanzamientosManuales)){
		  //    SubmitForm(document.forms[0]);
		  //  }
		  //}
		  //else{  
		    if(!lanzamientoDiasAnteriores){
		      SubmitForm(document.forms[0]);
		    }
		    else{
		      alert(msgLanzamientoImposible);
		    }
		  //}
		}
		
	}
	
	
	
	
	
	
	
	function CerrarVentana(){
	  ]]></xsl:text>
	    <xsl:choose>
	      <xsl:when test="/PedidosProgramados/VENTANA='NUEVA'">
	        <xsl:choose>
	          <xsl:when test="//PedidosProgramados/ACTUALIZARPAGINA='S'">
	  <xsl:text disable-output-escaping="yes"><![CDATA[
	            if(window.parent.opener && !window.parent.opener.closed){
                var objFrameTop=new Object();   
                objFrameTop=window.parent.opener.top;
                var FrameOpenerName=window.parent.opener.name;
                var objFrame=new Object();
                objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
                if(objFrame!=null && objFrame.recargarPagina){
                  objFrame.recargarPagina();
                
                }
                else{
                  Refresh(objFrame.document);
                }  	
              }
              window.close(); 
     ]]></xsl:text>
	          </xsl:when>
	          <xsl:otherwise>         
	   <xsl:text disable-output-escaping="yes"><![CDATA[
	            window.close();
	   ]]></xsl:text>
	          </xsl:otherwise>
	        </xsl:choose>
	        
	      </xsl:when>
	      <xsl:otherwise>
	   <xsl:text disable-output-escaping="yes"><![CDATA[
	        document.location.href='about:blank';
	   ]]></xsl:text>
	      </xsl:otherwise>
	    </xsl:choose>
	  <xsl:text disable-output-escaping="yes"><![CDATA[
	}
	
	function IncrementarAnyo(incremento){
  
	  ]]></xsl:text>
	    var idusuario='<xsl:value-of select="PedidosProgramados/IDUSUARIO"/>';
	    var accion='<xsl:value-of select="PedidosProgramados/CALENDARIOANUAL/@Accion"/>';
	    var titulo='<xsl:value-of select="PedidosProgramados/CALENDARIOANUAL/@Titulo"/>';
	    var ventana='<xsl:value-of select="PedidosProgramados/VENTANA"/>';
	    var actualizarPagina='<xsl:value-of select="PedidosProgramados/ACTUALIZARPAGINA"/>';
            var read_only='<xsl:value-of select="PedidosProgramados/READ_ONLY"/>';
	    
	    
	    
	  <xsl:text disable-output-escaping="yes"><![CDATA[
	  
	  // montamos la cadena
	  document.forms[0].elements['RESULTADO'].value=montarCadenaResultados();
	  
	  // calculamos el anyo destino
	  var anyoDestino=Number(obtenerSubCadena(document.forms['form1'].elements['FECHAACTIVA'].value, 3))+Number(incremento);
	  document.forms['form1'].elements['FECHAACTIVA'].value=obtenerSubCadena(document.forms['form1'].elements['FECHAACTIVA'].value, 1)+'/'+obtenerSubCadena(document.forms['form1'].elements['FECHAACTIVA'].value, 2)+'/'+anyoDestino;
	  
	  document.location.href='http://www.newco.dev.br/Compras/PedidosProgramados/LanzamientosPedidosProgramados.xsql?PEDP_ID='+document.forms['form1'].elements['PEDP_ID'].value+'&ACCION='+accion+'&TITULO='+titulo+'&FECHAACTIVA='+document.forms['form1'].elements['FECHAACTIVA'].value+'&IDUSUARIO='+idusuario+'&RESULTADO_TMP='+document.forms['form1'].elements['RESULTADO'].value+'&ANYOS_VISITADOS='+AnyosVisitados+'&VENTANA='+ventana+'&ACTUALIZARPAGINA='+actualizarPagina+'&READ_ONLY='+read_only;
	}

	
	//-->
	</script>
        ]]></xsl:text>
        
      </head>  
        <xsl:choose>
          <xsl:when test="//xsql-error"> 
          <P class="tituloform">     
            <xsl:apply-templates select="//xsql-error"/>
          </P>
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

	<!--	Solo creamos el formulario si tiene una accion definida	-->
	<xsl:if test="/PedidosProgramados/CALENDARIOANUAL/@Accion">
		<form method="POST" name="form1">
			<xsl:attribute name="action"><xsl:value-of select="/PedidosProgramados/CALENDARIOANUAL/@Accion"/></xsl:attribute>
			<input type="hidden" name="RESULTADO" value="{/PedidosProgramados/RESULTADO_TMP}"/>
			<input type="hidden" name="FECHAACTIVA">
			  <xsl:choose>
			    <xsl:when test="/PedidosProgramados/FECHAACTIVA!=''">
			      <xsl:attribute name="value"><xsl:value-of select="/PedidosProgramados/FECHAACTIVA"/></xsl:attribute>
			    </xsl:when>
			    <xsl:otherwise>
			      <xsl:attribute name="value"><xsl:value-of select="/PedidosProgramados/FECHAACTUAL"/></xsl:attribute>
			    </xsl:otherwise>
			  </xsl:choose>
			</input>
			<input type="hidden" name="ANYOS_VISITADOS"/>
			<input type="hidden" name="PEPE"/>
			<input type="hidden" name="PEDP_ID" value="{/PedidosProgramados/PEDP_ID}"/>
			<input type="hidden" name="VENTANA" value="{/PedidosProgramados/VENTANA}"/>
			<input type="hidden" name="DESDEOFERTA" value="{/PedidosProgramados/DESDEOFERTA}"/>
			
			
			
			
			<input type="hidden" name="ANYO">
				<xsl:attribute name="value"><xsl:value-of select="/PedidosProgramados/CALENDARIOANUAL/@Anyo"/></xsl:attribute>
			</input>
		</form>
	</xsl:if>
    
    <!--title page
	      <h1 class="titlePage">
		      <xsl:value-of select="/PedidosProgramados/CALENDARIOANUAL/USUARIOAGENDA"/>&nbsp;<xsl:value-of select="/PedidosProgramados/CALENDARIOANUAL/@Anyo"/>:&nbsp;Programación manual
	      </h1>
	 fin title page-->   
	    


		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_programados']/node()"/></span></p>
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
					  <xsl:when test="/PedidosProgramados/CALENDARIOANUAL/EDICION  and //READ_ONLY!='S'">
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




    
    
	<!-- botones de siguiente / anterior

	<div class="divLeft">
     <div class="divLeft10">&nbsp;</div>
    <div class="divLeft20">
      <!- - solo mostramos el de anterior si no estamos al inicio del rango - ->
      <xsl:for-each select="/PedidosProgramados/CALENDARIOANUAL/ANYO/field/dropDownList/listElem">
	      <xsl:if test="position()=1">
	          <xsl:if test="not(ID=//PedidosProgramados/CALENDARIOANUAL/@Anyo)">
              
              <img src="http://www.newco.dev.br/images/anterior.gif" alt="anterior"/>&nbsp;
               <strong><a href="javascript:IncrementarAnyo(-1);">Anterior</a></strong>
              
	          </xsl:if>
	      </xsl:if>
	    </xsl:for-each>
	</div><!- -fin divLeft20- ->
    <div class="divLeft40">&nbsp;</div>
    <div class="divLeft20">
	  
	    <!- - solo mostramos el de siguiente si no estamos al final del rango - ->
	    <xsl:for-each select="/PedidosProgramados/CALENDARIOANUAL/ANYO/field/dropDownList/listElem">
        <xsl:if test="position()=last()">
	          <xsl:if test="not(ID=//PedidosProgramados/CALENDARIOANUAL/@Anyo)">
              
              <strong><a href="javascript:IncrementarAnyo(1);">Siguiente</a></strong>&nbsp;
              <img src="http://www.newco.dev.br/images/siguiente.gif" alt="siguiente"/>
	          </xsl:if>
	      </xsl:if>
	    </xsl:for-each>
   </div><!- -fin de divLeft20- ->
   </div><!- -fin de divLeft-->
	
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
  
  
  
  
		<!--	Sin accion no tiene sentido el boton de enviar formulario	- ->
		<xsl:choose>
		  <xsl:when test="/PedidosProgramados/CALENDARIOANUAL/EDICION  and //READ_ONLY!='S'">
			  <xsl:if test="/PedidosProgramados/CALENDARIOANUAL/@Accion">
				  <tr valign="top">
				    <td align="center" colspan="2">
	            		  <xsl:choose>
	            		    <xsl:when test="//PedidosProgramados/ACTUALIZARPAGINA='S'">
							<!- -
	            		      <xsl:call-template name="botonPersonalizado">
	            		        <xsl:with-param name="funcion">CerrarVentana();</xsl:with-param>
	            		        <xsl:with-param name="label">Cerrar</xsl:with-param>
	            		        <xsl:with-param name="status">Cerrar</xsl:with-param>
	            		        <xsl:with-param name="ancho">120px</xsl:with-param>
	            		        <xsl:with-param name="backgroundBoton">oscuro</xsl:with-param>
	            		        <xsl:with-param name="foregroundBoton">blanco</xsl:with-param>
	                      		</xsl:call-template>
								- ->
								<a class="btnNormal" href="javascript:CerrarVentana();">Cerrar</a>
	            		    </xsl:when>
	            		    <xsl:otherwise>
								<!- -
	            		      <xsl:call-template name="botonPersonalizado">
	            		        <xsl:with-param name="funcion">CerrarVentana();</xsl:with-param>
	            		        <xsl:with-param name="label">Cancelar</xsl:with-param>
	            		        <xsl:with-param name="status">Cancelar</xsl:with-param>
	            		        <xsl:with-param name="ancho">120px</xsl:with-param>
	            		        <xsl:with-param name="backgroundBoton">oscuro</xsl:with-param>
	            		        <xsl:with-param name="foregroundBoton">blanco</xsl:with-param>
		                      </xsl:call-template> - ->
								<a class="btnNormal" href="javascript:CerrarVentana();">Cancelar</a>
	            		    </xsl:otherwise>
	            		  </xsl:choose>
					  </td>		
					  <td align="center" colspan="2">
					  	<!- -
	            		<xsl:call-template name="botonPersonalizado">
	            		  <xsl:with-param name="funcion">Guardar();</xsl:with-param>
	            		  <xsl:with-param name="label">Guardar los cambios</xsl:with-param>
	            		  <xsl:with-param name="status">Guardar</xsl:with-param>
	            		  <xsl:with-param name="ancho">120px</xsl:with-param>
	            		  <xsl:with-param name="backgroundBoton">oscuro</xsl:with-param>
	            		  <xsl:with-param name="foregroundBoton">blanco</xsl:with-param>
	            		</xsl:call-template> 
						- ->
								<a class="btnDestacado" href="javascript:CerrarVentana();">Guardar</a>
					  </td>				
				  </tr>
				  
			  </xsl:if>
		  </xsl:when>
		  <xsl:otherwise>
		    <tr valign="top">
					  <td align="center" colspan="4">
					  <!- -
	            			<xsl:call-template name="botonPersonalizado">
	            					  <xsl:with-param name="funcion">CerrarVentana();</xsl:with-param>
	            					  <xsl:with-param name="label">Cerrar la ventana</xsl:with-param>
	            					  <xsl:with-param name="status">Cerrar</xsl:with-param>
	            					  <xsl:with-param name="ancho">120px</xsl:with-param>
	            					  <xsl:with-param name="backgroundBoton">oscuro</xsl:with-param>
	            					  <xsl:with-param name="foregroundBoton">blanco</xsl:with-param>
	            			</xsl:call-template> 
						- ->
						<a class="btnNormal" href="javascript:CerrarVentana();">Cerrar</a>
					  </td>				
				  </tr>
		  </xsl:otherwise>
		</xsl:choose>
		-->
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
				    <xsl:when test="//PedidosProgramados/CALENDARIOANUAL/EDICION  and //READ_ONLY!='S'">

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
				    <xsl:when test="//PedidosProgramados/CALENDARIOANUAL/EDICION  and //READ_ONLY!='S'">

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
