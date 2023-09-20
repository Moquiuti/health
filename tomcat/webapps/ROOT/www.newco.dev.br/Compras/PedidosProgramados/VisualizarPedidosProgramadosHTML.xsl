<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 	Ficha de Pedidos programados
	Ultima revision: ET 5abr18 15:28
 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
  <head>
  	 <!--idioma-->
        <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/PedidosProgramados/LANG"><xsl:value-of select="/PedidosProgramados/LANG" /></xsl:when>
            <xsl:when test="/PedidosProgramados/LANGTESTI != ''"><xsl:value-of select="/PedidosProgramados/LANGTESTI" /></xsl:when>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
      <!--idioma fin-->
      
      <title>
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>&nbsp;<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/DESCRIPCION"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/CENTRO"/>
      </title>
      <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  
      <link rel="stylesheet" href="http://www.newco.dev.br/General/calendario/spiffyCal_v2_1.css" type="text/css"/>
      <script type="text/javascript" src="http://www.newco.dev.br/General/jquery-1.8.3.min.js"></script>
      <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
      <script type="text/javascript" src="http://www.newco.dev.br/General/calendario/spiffyCal_v2_1.js"></script>	
     
	<xsl:text disable-output-escaping="yes"><![CDATA[

   
    <script type="text/javascript">
      <!--



        var msgSinPedidoParaMostrar='Por favor, seleccione un pedido.'; 
        var msgSinProveedorVacaciones='Por favor, seleccione un proveedor.';
        var msgFechaFinProgramaObligatoria='Ha marcado el programa como \"no solicitar confirmación\".\nPor favor, introduzca la fecha en la que el programa finalizará.';
        
        var msgDescripcionPrograma='Por favor, rellene el campo Nombre del programa.\n(le ayudará a identificarlo posteriormente)';
	      var msgUsuarioPrograma='Por favor, seleccione el usuario que enviará el pedido.';
        var msgProveedorPrograma='Por favor, seleccione el proveedor del pedido que quiere programar.';
        var msgOfertaPrograma='Por favor, seleccione el número pedido que quiere programar.';
        var msgFrecuenciaPrograma='Por favor, seleccione la frecuencia con la que el pedido será entregado.';
        var msgFechaFinObligatoria='El programa está marcado como \"no solicitar confirmación de envío\".\nPor favor introduzca la fecha en la que el programa finalizará.';
        var msgBorrarPrograma='¿Confirma la eliminación del programa?';
        
        var mensaje='';       
       
        /**/
          
          
          
                    /* inicio  */
            
            
            var msgInicioAnteriorCreacionConCambio='La fecha de inicio introducida es anterior o igual a la fecha de creación del programa.\nPor favor, introduzca una fecha posterior.';
            var msgInicioAnteriorCreacion='La fecha de inicio introducida es anterior o igual a la fecha de creación del programa.\nPor favor, introduzca una fecha posterior.';
            
            var msgInicioConCambio='La fecha de inicio introducida no corresponde a una fecha laborable.\nSe ha cogido la siguiente fecha correspondiente a un día laborable: ';
            
            var msgInicioNoLaborable='Por favor, introduzca una fecha laborable en el campo \'fecha de inicio\'.';
            var msgInicioObligatoria='Por favor, introduzca una fecha válida con el formato dd/mm/aaaa en el campo \'fecha de inicio\'.';
            
                    /*  fin  */
            
            var msgFinAnteriorInicioConCambio='La fecha de finalización introducida es anterior a la fecha de inicio del programa.\nPor favor, introduzca una fecha correcta.';
            var msgFinAnteriorInicio='La fecha de finalización introducida es anterior a la fecha de inicio del programa.\nPor favor, introduzca una fecha correcta.';
            
            var msgFinAnteriorLanzamientoConCambio='La fecha de finalización introducida es anterior a la fecha de lanzamiento del programa.\nPor favor, introduzca una fecha posterior.';
            var msgFinAnteriorLanzamiento='La fecha de finalización introducida es anterior a la fecha de lanzamiento del programa.\nPor favor, introduzca una fecha posterior.';
            
            var msgFinConCambio='La fecha de finalización introducida no corresponde a una fecha laborable.\nSe ha cogido la siguiente fecha correspondiente a un día laborable: ';
            
            var msgFinNoLaborable='Por favor, introduzca una fecha laborable en el campo \'fecha de finalización\'.';
            
                    /* lanzamiento */

            
            
            
            var msgLanzamientoAnteriorActualConCambio='La fecha de lanzamiento introducida es anterior o igual a la fecha actual.\nPor favor, introduzca una fecha posterior.';
            var msgLanzamientoAnteriorActual='La fecha de lanzamiento introducida es anterior o igual a la fecha actual.\nPor favor, introduzca una fecha posterior.';
            
            var msgLanzamientoAnteriorInicioConCambio='La fecha de lanzamiento introducida es anterior a la fecha de inicio del programa.\nPor favor, introduzca una fecha correcta.';
            var msgLanzamientoAnteriorInicio='La fecha de lanzamiento introducida es anterior a la fecha de inicio del programa.\nPor favor, introduzca una fecha correcta.';
                
            var msgLanzamientoPosteriorFinConCambio='La fecha de lanzamiento introducida es posterior a la fecha de finalización del programa.\nPor favor, introduzca una fecha correcta.';
            var msgLanzamientoPosteriorFin='La fecha de lanzamiento introducida es posterior a la fecha de finalización del programa.\nPor favor, introduzca una fecha correcta.';

            var msgLanzamientoAnteriorActualDesdeEntrega='La fecha de entrega introducida genera una fecha de lanzamiento anterior o igual a la fecha actual.\nPor favor, introduzca una fecha posterior.';
            var msgLanzamientoAnteriorActualConCambioDesdeEntrega='La fecha de entrega introducida genera una fecha de lanzamiento anterior o igua a la fecha actual.\nPor favor, introduzca una fecha posterior.';
            
            var msgLanzamientoAnteriorInicioDesdeEntrega='La fecha de entrega introducida genera una fecha de lanzamiento anterior a la fecha de inicio del programa.\nPor favor, introduzca una fecha correcta.';
            
            var msgLanzamientoPosteriorFinConCambioDesdeEntrega='La fecha de entrega introducida genera una fecha de lanzamiento posterior a la fecha de fin del programa.\nPor favor, introduzca una fecha correcta.';
            var msgLanzamientoPosteriorFinDesdeEntrega='La fecha de entrega introducida genera una fecha de lanzamiento posterior a la fecha de fin del programa.\nPor favor, introduzca una fecha correcta.';
            
            
            var msgLanzamientoConCambio='La fecha de lanzamiento introducida no corresponde a una fecha laborable.\nSe ha cogido la siguiente fecha correspondiente a un día laborable: ';
           
            var msgLanzamientoNoLaborable='Por favor, introduzca una fecha laborable en el campo \'fecha de lanzamiento\'.';
            var msgLanzamientoObligatoria='Por favor, introduzca una fecha válida con el formato dd/mm/aaaa en el campo \'fecha de lanzamiento\'.';
          
            
                    /* entrega */          
             
            var msgEntregaAnteriorActual='La fecha de entrega introducida es anterior o igual que la fecha actual.\nPor favor, introduzca una fecha posterior.';
            
            var msgEntregaAnteriorInicio='La fecha de entrega introducida es anterior o igual que la fecha de inicio del programa.\nPor favor, introduzca una fecha posterior.';
            
            var msgEntregaConCambio='La fecha de entrega introducida no corresponde a una fecha laborable.\nSe ha cogido la siguiente fecha correspondiente a un día laborable: ';
            
            var msgEntregaNoLaborable='Por favor, introduzca una fecha laborable en el campo \'fecha de entrega\'.';
            var msgEntregaObligatoria='Por favor, introduzca una fecha válida con el formato dd/mm/aaaa en el campo \'fecha de entrega\'.';
            
             ]]></xsl:text>
      
      
      /*  
          utilizamos un flag con tres esyados para saber si hemos de recalcular,
          recalcularPrograma=0  no hemos de reclacular, pero puede cambiar su estado
          recalcularPrograma=1; hemos de recalcular
          recalcularPrograma=-1;  no hemos de recalcular, y este estado no puede cambiar
      
      */

        <xsl:choose>
          <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA or not(PedidosProgramados/PEDIDOPROGRAMADO/EXISTE) or PedidosProgramados/PEDIDOPROGRAMADO/ESTADOPROGRAMA='F'">
            var recalcularPrograma=1;
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/MANUAL='S'">
                var recalcularPrograma=-1;
              </xsl:when>
              <xsl:otherwise>
                var recalcularPrograma=0;
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
        
        
     <xsl:text disable-output-escaping="yes"><![CDATA[
            
        
        
        
        function CerrarVentana(){
        
          ]]></xsl:text> 
            <xsl:choose>
              <xsl:when test="//VENTANA='NUEVA'">
                window.close();
              </xsl:when>
              <xsl:otherwise>
                document.location.href='about:blank';
              </xsl:otherwise>
            </xsl:choose>
          <xsl:text disable-output-escaping="yes"><![CDATA[
          
        }
        
        function compararFechas(fechaOrigen, tipo,fechaDestino ){
          var fechaOrigenFormatoIngles=formatoFecha(fechaOrigen,'E','I');
          var fechaDetinoFormatoIngles=formatoFecha(fechaDestino,'E','I');
          
          fechaOrigenFormatoIngles=new Date(fechaOrigenFormatoIngles);
          fechaDetinoFormatoIngles=new Date(fechaDetinoFormatoIngles);
          
          fechaOrigenFormatoIngles=parseInt(fechaOrigenFormatoIngles.getTime());
          fechaDetinoFormatoIngles=parseInt(fechaDetinoFormatoIngles.getTime());
          
          if(tipo=='MAYOR'){
            if(fechaOrigenFormatoIngles>fechaDetinoFormatoIngles)
              return 1;
            else
              return 0;
          }
          else{
            if(tipo=='MENOR'){
              if(fechaOrigenFormatoIngles<fechaDetinoFormatoIngles)
                return 1;
              else 
                return 0;
            }
            else{
              if(tipo=='MENORIGUAL'){
                if(fechaOrigenFormatoIngles<=fechaDetinoFormatoIngles)
                  return 1;
                else 
                  return 0;
              }
              else{
                if(tipo=='MAYORIGUAL'){
                  if(fechaOrigenFormatoIngles>=fechaDetinoFormatoIngles)
                    return 1;
                  else 
                    return 0;
                }
              }
            }
          }
        }
        
        
        function calculaFecha(form,objFecha, mas){  // nom: nombre del objFecha que queremos calcular
        
          var objInvocador;
          var msgFecha;
          
                  /* guardamos lel objeto invocador para comodidad de manejo */
          if(objFecha.name=='FECHA_INICIO'){
            objInvocador='INICIO';
          }
          else{
            if(objFecha.name=='FECHANO_FIN'){
              objInvocador='FIN';
              if(recalcularPrograma==0){
                recalcularPrograma=1;
              }
            }
            else{
              if(objFecha.name=='FECHANO_LANZAMIENTO'){
                objInvocador='LANZAMIENTO';
              }
              else{
                if(objFecha.name=='FECHANO_ENTREGA'){
                  objInvocador='ENTREGA';
                  if(recalcularPrograma==0){
                    recalcularPrograma=1;
                  }
                }
              }
            }
          }
          
          var plazoEntregaUsado=form.elements['PLAZOENTREGA'].value;
            
            
          var FechaActual=form.elements['FECHA_ACTUAL'].value;
          var FechaActualFormatoIngles=formatoFecha(FechaActual,'E','I');
          var fFechaActual=new Date(FechaActualFormatoIngles);        
                  
          var FechaCreacion=form.elements['FECHA_CREACION'].value;
          var FechaCreacionFormatoIngles=formatoFecha(FechaCreacion,'E','I');
          var fFechaCreacion=new Date(FechaCreacionFormatoIngles);
          
          
          var FechaInicio=form.elements['FECHA_INICIO'].value;
          var FechaInicioFormatoIngles=formatoFecha(FechaInicio,'E','I');
          var fFechaInicio=new Date(FechaInicioFormatoIngles);
          
          var FechaFin=form.elements['FECHANO_FIN'].value;
          var FechaFinFormatoIngles=formatoFecha(FechaFin,'E','I');
          var fFechaFin=new Date(FechaFinFormatoIngles);
          
          var FechaLanzamiento=form.elements['FECHANO_LANZAMIENTO'].value;
          var FechaLanzamientoFormatoIngles=formatoFecha(FechaLanzamiento,'E','I');
          var fFechaLanzamiento=new Date(FechaLanzamientoFormatoIngles);
          
          var FechaEntrega=form.elements['FECHANO_ENTREGA'].value;
          var FechaEntregaFormatoIngles=formatoFecha(FechaEntrega,'E','I');
          var fFechaEntrega=new Date(FechaEntregaFormatoIngles);  
                  
                  
                       /*  ENTREGA */
                   
                  
            /*
                En el caso de que el evento lo inicie ENTREGA
                miramos si la fecha es posterior o igual a INICIO
                si lo es miramos que sea un dia laborable
                si no lo es cogemos el siguiente que lo sea y
                calculamos la fecha de lanzamiento
                si es anterior a la de inicio indicamos que hay un error
            */
            
       
       //alert(objInvocador);
        
          if(objInvocador=='ENTREGA'){ 
                  
            var avisarCambioFecha=0;
            var fFechaEntregaTMP;
            var FechaEntregaTMP;
            
            
            /* 
              nacho 8.7.2003
            */
              
            var fechaAnterior=0;
            var fechaPosterior=0;
            var fechaLaborable=0;
            var fechaConCambio=0;
              
             
            /*
               8.7.2003
               
               miramos que la fecha de entrega este entre la fecha de inicio + el plazo de entrega y la fecha de fin y que sea un dia laborable
            
            */ 
            
            var fFechaEjecucion=calcularDiasHabiles(fFechaActual,1);
            var FechaEjecucion=convertirFechaATexto(fFechaEjecucion);
            
            var fFechaEntregaMinima=calcularDiasHabiles(fFechaEjecucion,plazoEntregaUsado);
            var FechaEntregaMinima=convertirFechaATexto(fFechaEntregaMinima);
            
              
            if(compararFechas(FechaEntrega,'MENOR',FechaEntregaMinima)){
              fechaAnterior=1;
            }
            else{
              fechaAnterior=0;
            }
            
            if(compararFechas(FechaEntrega,'MAYOR',FechaFin)){
              fechaPosterior=1;
            }
            else{
              fechaPosterior=0;
            }
            
            if(esLaborable(FechaEntrega)){
              fechaLaborable=1;
            }
            else{
              fechaLaborable=0;
              
              fechaConCambio=1;
              fFechaEntregaTMP=calculaSiguienteDiaLaborable(fFechaEntrega);
              FechaEntregaTMP=convertirFechaATexto(fFechaEntregaTMP);
            }
            
            //alert('fechaAnterior: '+fechaAnterior+' fechaPosterior: '+fechaPosterior+' fechaLaborable '+fechaLaborable+' fechaConCambio: '+fechaConCambio);
            
            if(fechaAnterior){
              alert('La fecha de entrega actual no es válida. La fecha de entrega no puede ser anterior al: '+FechaEntregaMinima+'\n\nPor favor, pongase en contacto con el usuario a fin de subsanar el error. Gracias');   
            }
            
            if(!esLaborable){
              alert('La fecha de entrega actual no corresponde a un día laborable.\n\nPor favor, pongase en contacto con el usuario a fin de subsanar el error. Gracias');
            }
            
            if(fechaPosterior){
              if(form.elements['IDFRECUENCIA'].value!=1){
                alert('La fecha de finalización actual no es válida. La fecha de finalización no puede ser anterior al: '+form.elements['FECHANO_ENTREGA'].value+'\n\nPor favor, pongase en contacto con el usuario a fin de subsanar el error. Gracias');
              }
            }
            
            if(!fechaAnterior && esLaborable && !fechaPosterior){
              form.elements['FECHANO_LANZAMIENTO'].value=convertirFechaATexto(calcularDiasHabiles(fFechaEntrega,-plazoEntregaUsado));
            }
            
            if(form.elements['IDFRECUENCIA'].value==1){
              form.elements['FECHANO_FIN'].value=form.elements['FECHANO_ENTREGA'].value;
            }
              
           }
                  
                                    /*  LANZAMIENTO */
          else{  
          
 
        
            if(objInvocador=='LANZAMIENTO'){
            
            
            /*
                8.7.2003
               
                miramos que la fecha de entrega este entre la fecha de inicio + el plazo de entrega y la fecha de fin y que sea un dia laborable
            
               */ 
               
               
              var fechaAnterior=0;
              var fechaPosterior=0;
              var fechaLaborable=0;
              var fechaConCambio=0; 
              var esManual;
              
              if(form.elements['MANUAL'].value=='S'){
                esManual=1;
              }
              else{
                esManual=0;
              }
              
            
              var fFechaEjecucion=calcularDiasHabiles(fFechaActual,1);
              var FechaEjecucion=convertirFechaATexto(fFechaEjecucion);
              
            
              var fFechaEntregaMinima=calcularDiasHabiles(fFechaEjecucion,plazoEntregaUsado);
              var FechaEntregaMinima=convertirFechaATexto(fFechaEntregaMinima);
              
              var fFechaEntregaTmp=calcularDiasHabiles(fFechaLanzamiento,plazoEntregaUsado);
              var FechaEntregaTmp=convertirFechaATexto(fFechaEntregaTmp);
              
              var fFechaLanzamientoTMP=calculaSiguienteDiaLaborable(fFechaLanzamiento);
              var FechaLanzamientoTMP=convertirFechaATexto(fFechaLanzamientoTMP);
             
            
             
            
              
              if(compararFechas(FechaLanzamiento,'MENOR',FechaEjecucion)){
                fechaAnterior=1;
                
                if(recalcularPrograma==0){
                  recalcularPrograma=1;
                }
                

                  /* 
                    el programa se debia haber lanzado, calculamos la fecha de entrega, para ver si todavia estamos a tiempo
                    si es posible cumplir el plazo de entrega actualizamos el dia de lanzamiento sin avisar al usuario y seguimos...
                    
                    si no lo es le indicamos alusuario que el plazo de entrega no es valido y proponemos el minimo
                   */
                   
                  
                   
                       
                
                if (compararFechas(FechaEntregaTmp,'MENOR',FechaEntregaMinima)){
                  form.elements['FECHANO_LANZAMIENTO'].value=FechaLanzamiento;
                  form.elements['FECHANO_ENTREGA'].value=FechaEntregaTmp;
                }
                else{
                  fechaAnterior=0;
                  form.elements['FECHANO_LANZAMIENTO'].value=FechaEjecucion;
                  form.elements['FECHANO_ENTREGA'].value=FechaEntregaTmp;
                }   
 
              }
              else{
                form.elements['FECHANO_LANZAMIENTO'].value=FechaLanzamiento;
                form.elements['FECHANO_ENTREGA'].value=FechaEntregaTmp;
                fechaAnterior=0;
              }
              
              
     
            
              if(compararFechas(FechaLanzamiento,'MAYOR',FechaFin)){
                fechaPosterior=1;
              }
              else{
                fechaPosterior=0;
              }
              
            
              if(esLaborable(FechaLanzamiento)){
                fechaLaborable=1;
              }
              else{
                fechaLaborable=0;
              
                fechaConCambio=1;
              }
       
              
              //alert(plazoEntregaUsado+' '+FechaLanzamiento+' '+FechaEjecucion+' '+FechaEntregaTmp+' '+FechaFin+' '+FechaLanzamientoTMP);
  
              if(fechaAnterior){
                if(!esManual){ 
                 alert('La fecha de entrega actual no es válida. La fecha de entrega no puede ser anterior al: '+FechaEntregaMinima+'\n\nPor favor, pongase en contacto con el usuario a fin de subsanar el error. Gracias'); 
                }
                else{
                  alert('La fecha de entrega actual no es válida. la fecha de entrega no puede ser anterior al: '+FechaEntregaMinima+'\n\nPor favor, pongase en contacto con el usuario a fin de subsanar el error. Gracias');
                }
              }
              
            
              if(!fechaAnterior && esLaborable && !fechaPosterior){
                form.elements['FECHANO_LANZAMIENTO'].value=convertirFechaATexto(calcularDiasHabiles(fFechaEntregaTmp,-plazoEntregaUsado));
              }
              
            
              if(form.elements['IDFRECUENCIA'].value==1){
                form.elements['FECHANO_FIN'].value=form.elements['FECHANO_ENTREGA'].value;
              }
              
            }
            else{
            
                                /* FIN */
            
                    /*
                     si el invocador es fin miramos que la fecha de FIN sea laborable, mas grande que la de INICIO
                     y la de lanzamiento
                     si lo  es ok, seguimos, si no lo indicamos
                    */
    
              if(objInvocador=='FIN'){
              
              
              
                /*
                  nacho 8.7.2003
                
                */
              
                var avisarCambioFecha=0;
                var fFechaFinTMP;
                var FechaFinTMP;
            
              
                var fechaAnterior=0;
                var fechaLaborable=0;
                var fechaConCambio=0;
              
             
                /*
                 8.7.2003
               
                 miramos que la fecha de fin no sea anterior a la de inicio, ni a la de entrega, que sea laborable
            
               */ 
            
               var fFechaEjecucion=calcularDiasHabiles(fFechaActual,1);
               var FechaEjecucion=convertirFechaATexto(fFechaEjecucion);
            
               var fFechaEntregaMinima=calcularDiasHabiles(fFechaEjecucion,plazoEntregaUsado);
               var FechaEntregaMinima=convertirFechaATexto(fFechaEntregaMinima);
            
              
               if(compararFechas(FechaFin,'MENOR',FechaEntrega)){
                 fechaAnterior=1;
               }
               else{
                 fechaAnterior=0;
               }
            
               if(esLaborable(FechaFin)){
                 fechaLaborable=1;
               }
               else{
                 fechaLaborable=0;
              
                 fechaConCambio=1;
                 fFechaFinTMP=calculaSiguienteDiaLaborable(fFechaFin);
                 FechaFinTMP=convertirFechaATexto(fFechaFin);
              }
            
              //alert('fechaAnterior: '+fechaAnterior+' fechaPosterior: '+fechaPosterior+' fechaLaborable '+fechaLaborable+' fechaConCambio: '+fechaConCambio);
            
              if(fechaAnterior){
                alert('La fecha de finalización actual no es válida. La fecha de finalización no puede ser anterior al: '+FechaEntrega+'\n\nPor favor, pongase en contacto con el usuario a fin de subsanar el error. Gracias');
              }
            
              if(!esLaborable){
                alert('La fecha de finalización actual no corresponde a un día laborable.\n\nPor favor, pongase en contacto con el usuario a fin de subsanar el error. Gracias');
              }

              }
              else{
              
                       /* INICIO */

                if(objInvocador=='INICIO'){
                
                  var fFechaInicioTMP;
                  var FechaInicioTMP;
                  
                  var avisarCambioFecha=0;
                        
                        /* miramos que sea laborable */
                        
                  if(fFechaInicio.getDay()==0 || fFechaInicio.getDay()==6){
                    if(fFechaInicio.getDay()==0){
                      fFechaInicioTMP=sumaDiasAFecha(fFechaInicio,1);
                    }
                    else{
                      if(fFechaInicio.getDay()==6){
                        fFechaInicioTMP=sumaDiasAFecha(fFechaInicio,2);
                      }
                    }
                    avisarCambioFecha=1;
                    var FechaInicioTMP=fFechaInicioTMP.getDate()+'/'+(Number(fFechaInicioTMP.getMonth())+1)+'/'+fFechaInicioTMP.getFullYear(); 
                  }
                  else{
                    fFechaInicioTMP=fFechaInicio;
                    FechaInicioTMP=FechaInicio;
                  }
                  
                             /* miramos que sea posterior a la de creacion */
                
                  if(compararFechas(FechaInicioTMP,'MENORIGUAL',FechaCreacion)){
                    if(avisarCambioFecha){
                      alert(msgInicioAnteriorCreacionConCambio);
                      //objFecha.focus();
                      return;
                    }
                    else{
                      alert(msgInicioAnteriorCreacion);
                      //objFecha.focus();
                      return;
                    }
                  }
                  else{
                    if(avisarCambioFecha){
                      alert(msgInicioConCambio+FechaInicioTMP);
                    }
                    form.elements['FECHA_INICIO'].value=FechaInicioTMP;
                  } 
                }
              }
            } 
          }
        }
        
        
        function obtenerIdAPartirDelValor(valor,objDespl){
          for(var n=0;n<objDespl.options.length;n++){
            if(objDespl.options[n].value==valor){
              return n;
            }
          }         
          return -1;
        }
        
        
        
        
        function CargarUsuarios(nombreDeplegable, elementoSeleccionado,proveedorSeleccionado,ofertaSeleccionada){
          var posicionElementoSeleccionado=0;
	        var objDesplegable=document.forms['form1'].elements[nombreDeplegable];
	        objDesplegable.options.length=0;
	        var textoDefecto;
	        if(elementoSeleccionado==-1){
	          textoDefecto='[Usuarios del Centro]';
	        }
	        else{
	          textoDefecto='Usuarios del Centro';
	        }
	        addOption=new Option(textoDefecto, '-1');
	        objDesplegable.options[objDesplegable.length]=addOption; 
	        for(var n=0;n<arrUsuarios.length;n++){
	          var texto;
	          if(arrUsuarios[n][0]==elementoSeleccionado){
	            texto='['+arrUsuarios[n][1]+']';
	            posicionElementoSeleccionado=n+1;
	          }
	          else{
	            texto=arrUsuarios[n][1];
	          }
	          addOption=new Option(texto, arrUsuarios[n][0]);
	          objDesplegable.options[objDesplegable.length]=addOption;  
	        }
	        objDesplegable.options.selectedIndex=posicionElementoSeleccionado;     
	        CargarProveedores('IDPROVEEDOR',proveedorSeleccionado,ofertaSeleccionada);     
	      }
	      
	      function CargarProveedores(nombreDeplegable, elementoSeleccionado,ofertaSeleccionada){
	        var posicionElementoSeleccionado=0;
	        var objDesplegable=document.forms['form1'].elements[nombreDeplegable];
	        if(objDesplegable.type!='hidden'){
	          objDesplegable.options.length=0;
	          var textoDefecto;
	          if(elementoSeleccionado==-1){
	            textoDefecto='[Proveedor del Pedido]';
	          }
	          else{
	            textoDefecto='Proveedor del Pedido';
	          }
	          addOption=new Option(textoDefecto, '-1');
	          objDesplegable.options[objDesplegable.length]=addOption; 
	          for(var n=0;n<arrProveedores.length;n++){
	            var texto;
	            if(arrProveedores[n][0]==elementoSeleccionado){
	              
	              texto='['+arrProveedores[n][1]+']';
	              posicionElementoSeleccionado=n+1;
	            }
	            else{
	              texto=arrProveedores[n][1];
	            }
	            addOption=new Option(texto, arrProveedores[n][0]);
	            objDesplegable.options[objDesplegable.length]=addOption;  
	          }
	          objDesplegable.options.selectedIndex=posicionElementoSeleccionado;
	          CargarPedidosProveedor('IDOFERTAMODELO',objDesplegable.options[objDesplegable.options.selectedIndex].value,ofertaSeleccionada);  
	        }
	      }
	      
	      function CargarPedidosProveedor(nombreDeplegable,idProveedor,elementoSeleccionado){
	        var posicionElementoSeleccionado=0;
	        var pedidoaBuscar=0;
	        var plazoentrega=3;
	        var objDesplegable=document.forms['form1'].elements[nombreDeplegable];
	        if(objDesplegable.type!='hidden'){
	          objDesplegable.options.length=0;
	          var textoDefecto;
	          if(elementoSeleccionado==-1){
	            textoDefecto='[Número de pedido]';
	            document.forms['form1'].elements['PLAZOENTREGA'].value=plazoentrega;
	          }
	          else{
	            textoDefecto='Número de pedido';
	          }
	          addOption=new Option(textoDefecto, '-1');
	          objDesplegable.options[objDesplegable.length]=addOption; 
	          for(var n=0;n<arrPedidos.length;n++){
	            if(idProveedor!='-1'){
	              if(arrPedidos[n][0]==idProveedor){
	                var texto;
	                if(arrPedidos[n][4]==elementoSeleccionado){
	                  texto='['+arrPedidos[n][2]+']';
	                  posicionElementoSeleccionado=n+1;
	                }
	                else{
	                  texto=arrPedidos[n][2];
	                }
	                addOption=new Option(texto, arrPedidos[n][4]);
	                objDesplegable.options[objDesplegable.length]=addOption;  
	              }
	            }
	            else{
	              var texto;
	              if(arrPedidos[n][4]==elementoSeleccionado){
	                texto='['+arrPedidos[n][2]+']';
	                posicionElementoSeleccionado=n+1;
	              }
	              else{
	                texto=arrPedidos[n][2];
	              }
	              addOption=new Option(texto, arrPedidos[n][4]);
	              objDesplegable.options[objDesplegable.length]=addOption;  
	            }
	          }
	          objDesplegable.options.selectedIndex=posicionElementoSeleccionado;
	        }
	      }
	      
	      function MostrarMultioferta(idMultioferta,cadRead_only){
	        var read_only='';
	        if(cadRead_only!='')
	          read_only='S';
	        
	        var estadoMultioferta;
	        ]]></xsl:text>
            var idSesion='<xsl:value-of select="//SES_ID"/>';
          <xsl:text disable-output-escaping="yes"><![CDATA[

	        estadoMultioferta=document.forms['form1'].elements['ESTADOOFERTA'].value;
	        MostrarPag('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID='+idMultioferta,'MultiofertaIncidencia'); 
	        
	      }
	      
	      function ValidarFormulario(form){
	        var errores=0;
	        
	         /* quitamos los espacios sobrantes */
        
          for(var n=0;n<form.length;n++){
            if(form.elements[n].type=='text'){
              form.elements[n].value=quitarEspacios(form.elements[n].value);
            }
          }
	        
	        if((!errores) && (esNulo(document.forms['form1'].elements['DESCRIPCION'].value))){
	          errores++;
	          alert(msgDescripcionPrograma);
	          document.forms['form1'].elements['DESCRIPCION'].focus();
	        }
	        
	        if((!errores) && (document.forms['form1'].elements['IDUSUARIO'].value<=0)){
	          errores++;
	          alert(msgUsuarioPrograma);
	          document.forms['form1'].elements['IDUSUARIO'].focus();
	        }
	        /*
	        if((!errores) && (document.forms['form1'].elements['IDPROVEEDOR'].value<=0)){
	          errores++;
	          alert(msgProveedorPrograma);
	          document.forms['form1'].elements['IDPROVEEDOR'].focus();
	        }
	        */
	        
	        if((!errores) && (document.forms['form1'].elements['IDOFERTAMODELO'].value<=0)){
	          errores++;
	          alert(msgOfertaPrograma);
	          document.forms['form1'].elements['IDOFERTAMODELO'].focus();
	        }
	        
	        if((!errores) && (document.forms['form1'].elements['IDFRECUENCIA'].value<=0)){
	          errores++;
	          alert(msgFrecuenciaPrograma);
	          document.forms['form1'].elements['IDFRECUENCIA'].focus();
	        }
	        
	        /* miramos la fecha de inicio */
	        
	        if(!errores){
	          if((mensaje=test2(document.forms['form1'].elements['FECHA_INICIO']))!=''){
	            errores++;
	            alert(msgInicioObligatoria);
	            document.forms['form1'].elements['FECHA_INICIO'].focus();
	          }
	          else{
	             /* la fecha tiene sintaxis correcta miramos que este dentro de los limites */
	              if(compararFechas(document.forms['form1'].elements['FECHA_INICIO'].value,'MENORIGUAL',document.forms['form1'].elements['FECHA_CREACION'].value)){
	                errores++;
	                alert(msgInicioAnteriorCreacion);
	              }
	              else{
	                  /* miramos que sea un dia laborable */
	                var fFechaSubmitTmp=new Date(formatoFecha(document.forms['form1'].elements['FECHA_INICIO'].value,'E','I'));
	                if(fFechaSubmitTmp.getDay()==0 || fFechaSubmitTmp.getDay()==6){
                    alert(msgInicioNoLaborable);
	                  errores++;
	                  document.forms['form1'].elements['FECHA_INICIO'].focus();     
	                }
	              }
	          }
	        }
	        
	        /* si esta activo el check de confirmacion  el campo fecha fin es obligatorio */
	        
	        if((!errores)){
	          /* no esta marcado, fecha obligatoria */
	          if((document.forms['form1'].elements['CONFIRMAR'].checked==false)){
	              /* si hay error de comprobacion */
	            if((mensaje=test2(document.forms['form1'].elements['FECHANO_FIN']))!=''){
	              /* esta vacio mostramos el mensaje de campo requerido */
	              alert(msgFechaFinObligatoria);
	              errores++;
	              document.forms['form1'].elements['FECHANO_FIN'].focus();
	            }
	            else{
	              /* no hay error comprobamos la fecha */
	              if(compararFechas(document.forms['form1'].elements['FECHANO_FIN'].value,'MENOR',document.forms['form1'].elements['FECHA_INICIO'].value)){
	                alert(msgFinAnteriorInicio);
	                errores++;
	                document.forms['form1'].elements['FECHANO_FIN'].focus();
	              }
	              else{
	                   /* miramos que sea un dia laborable */
	                var fFechaSubmitTmp=new Date(formatoFecha(document.forms['form1'].elements['FECHANO_FIN'].value,'E','I'));
	                if(fFechaSubmitTmp.getDay()==0 || fFechaSubmitTmp.getDay()==6){
                    alert(msgFinNoLaborable);
	                  errores++;
	                  document.forms['form1'].elements['FECHANO_FIN'].focus();     
	                }
	              }
	            }
	          }
	          else{
	           /* esta marcado, no es obligatoria comprobamos la sintaxis, si hay algun valor*/
	            if(document.forms['form1'].elements['FECHANO_FIN'].value!=''){
	              if((mensaje=test2(document.forms['form1'].elements['FECHANO_FIN']))!=''){
	                /* esta vacio mostramos el mensaje de campo requerido */
	                alert(msgFechaFinObligatoria);
	                errores++;
	                document.forms['form1'].elements['FECHANO_FIN'].focus();
	              }
	              else{
	                if(compararFechas(document.forms['form1'].elements['FECHANO_FIN'].value,'MENOR',document.forms['form1'].elements['FECHA_INICIO'].value)){
	                  alert(msgFinAnteriorInicio);
	                  errores++;
	                  document.forms['form1'].elements['FECHANO_FIN'].focus();
	                }
	                else{
	                  var fFechaSubmitTmp=new Date(formatoFecha(document.forms['form1'].elements['FECHANO_FIN'].value,'E','I'));
	                  if(fFechaSubmitTmp.getDay()==0 || fFechaSubmitTmp.getDay()==6){
                      alert(msgFinNoLaborable);
	                    errores++;
	                    document.forms['form1'].elements['FECHANO_FIN'].focus();     
	                  }
	                }
	              }
	            }
	          }
	        }
	        
	        /* si el programa esta activo... */
	        /* comprobamos que la de entrega este informada y mayor que la de inicio, y luego que sea laborable */
	        if(!errores){
	          if(document.forms['form1'].elements['ACTIVO'].checked==true){
	            if((mensaje=test2(document.forms['form1'].elements['FECHANO_ENTREGA']))!=''){
	              alert(msgEntregaObligatoria);
	              errores++;
	              document.forms['form1'].elements['FECHANO_ENTREGA'].focus();
	            }
	            else{
	              /* miramos que sea mayor que la de inicio */
	              if(compararFechas(document.forms['form1'].elements['FECHANO_ENTREGA'].value,'MENORIGUAL',document.forms['form1'].elements['FECHA_INICIO'].value)){
	                alert(msgEntregaAnteriorInicio);
	                errores++;
	                document.forms['form1'].elements['FECHANO_ENTREGA'].focus();
	              }
	              else{
	                /*miramos que la fecha de lanzamiento no sea anterior a inicio*/
	                  var fFechaSubmitEntregaTmp=new Date(formatoFecha(document.forms['form1'].elements['FECHANO_ENTREGA'].value,'E','I'));
	                  var fFechaSubmitLanzamientoTmp=calcularDiasHabiles(fFechaSubmitEntregaTmp,'-'+document.forms['form1'].elements['PLAZOENTREGA'].value);
                    var FechaSubmitLanzamientoTmp=fFechaSubmitLanzamientoTmp.getDate()+'/'+(Number(fFechaSubmitLanzamientoTmp.getMonth())+1)+'/'+fFechaSubmitLanzamientoTmp.getFullYear();
	                if(compararFechas(FechaSubmitLanzamientoTmp,'MENOR',document.forms['form1'].elements['FECHA_INICIO'].value)){
	                  alert(msgLanzamientoAnteriorInicioDesdeEntrega);
	                  errores++;
	                  document.forms['form1'].elements['FECHANO_ENTREGA'].focus();
	                }
	                else{
	                    /*miramos que la fecha de lanzamiento no sea anterior a inicio*/
	                    var fFechaSubmitEntregaTmp=new Date(formatoFecha(document.forms['form1'].elements['FECHANO_ENTREGA'].value,'E','I'));
	                    var fFechaSubmitLanzamientoTmp=calcularDiasHabiles(fFechaSubmitEntregaTmp,'-'+document.forms['form1'].elements['PLAZOENTREGA'].value);
                      var FechaSubmitLanzamientoTmp=fFechaSubmitLanzamientoTmp.getDate()+'/'+(Number(fFechaSubmitLanzamientoTmp.getMonth())+1)+'/'+fFechaSubmitLanzamientoTmp.getFullYear();
	                  if(compararFechas(FechaSubmitLanzamientoTmp,'MENORIGUAL',document.forms['form1'].elements['FECHA_ACTUAL'].value)){
	                    alert(msgLanzamientoAnteriorActualDesdeEntrega);
	                    errores++;
	                    document.forms['form1'].elements['FECHANO_ENTREGA'].focus();
	                  }
	                  else{
	                      /* miramos que sea un dia laborable*/
                      var fFechaSubmitTmp=new Date(formatoFecha(document.forms['form1'].elements['FECHANO_ENTREGA'].value,'E','I'));
	                    if(fFechaSubmitTmp.getDay()==0 || fFechaSubmitTmp.getDay()==6){
                        alert(msgEntregaNoLaborable);
	                      errores++;
	                      document.forms['form1'].elements['FECHANO_ENTREGA'].focus();     
	                    }
	                  }
	                }
	              }
	            }
	          }
	          else{
	            /* el programa no esta activo, no es obligatorio */
	            if(document.forms['form1'].elements['FECHANO_ENTREGA'].value!=''){
	              if((mensaje=test2(document.forms['form1'].elements['FECHANO_ENTREGA']))!=''){
	                alert(msgEntregaObligatoria);
	                errores++;
	                document.forms['form1'].elements['FECHANO_ENTREGA'].focus();
	              }
	              else{
	                /* miramos que sea mayor que la de inicio */
	                if(compararFechas(document.forms['form1'].elements['FECHANO_ENTREGA'].value,'MENORIGUAL',document.forms['form1'].elements['FECHA_INICIO'].value)){
	                  alert(msgEntregaAnteriorInicio);
	                  errores++;
	                  document.forms['form1'].elements['FECHANO_ENTREGA'].focus();
	                }
	                else{
	                  /*miramos que la fecha de lanzamiento sea correcta */
	                  var fFechaSubmitEntregaTmp=new Date(formatoFecha(document.forms['form1'].elements['FECHANO_ENTREGA'].value,'E','I'));
	                  var fFechaSubmitLanzamientoTmp=calcularDiasHabiles(fFechaSubmitEntregaTmp,'-'+document.forms['form1'].elements['PLAZOENTREGA'].value);
                    var FechaSubmitLanzamientoTmp=fFechaSubmitLanzamientoTmp.getDate()+'/'+(Number(fFechaSubmitLanzamientoTmp.getMonth())+1)+'/'+fFechaSubmitLanzamientoTmp.getFullYear();
	                  if(compararFechas(FechaSubmitLanzamientoTmp,'MENOR',document.forms['form1'].elements['FECHA_INICIO'].value)){
	                    alert(msgLanzamientoAnteriorInicioDesdeEntrega);
	                    errores++;
	                    document.forms['form1'].elements['FECHANO_ENTREGA'].focus();
	                  }
	                  else{
	                      /*miramos que la fecha de lanzamiento no sea anterior a inicio*/
	                      var fFechaSubmitEntregaTmp=new Date(formatoFecha(document.forms['form1'].elements['FECHANO_ENTREGA'].value,'E','I'));
	                      var fFechaSubmitLanzamientoTmp=calcularDiasHabiles(fFechaSubmitEntregaTmp,'-'+document.forms['form1'].elements['PLAZOENTREGA'].value);
                        var FechaSubmitLanzamientoTmp=fFechaSubmitLanzamientoTmp.getDate()+'/'+(Number(fFechaSubmitLanzamientoTmp.getMonth())+1)+'/'+fFechaSubmitLanzamientoTmp.getFullYear();
	                    if(compararFechas(FechaSubmitLanzamientoTmp,'MENORIGUAL',document.forms['form1'].elements['FECHA_ACTUAL'].value)){
	                      alert(msgLanzamientoAnteriorActualDesdeEntrega);
	                      errores++;
	                      document.forms['form1'].elements['FECHANO_ENTREGA'].focus();
	                    }
	                    else{
	                        /* miramos que sea un dia laborable*/
                        var fFechaSubmitTmp=new Date(formatoFecha(document.forms['form1'].elements['FECHANO_ENTREGA'].value,'E','I'));
	                      if(fFechaSubmitTmp.getDay()==0 || fFechaSubmitTmp.getDay()==6){
                          alert(msgEntregaNoLaborable);
	                        errores++;
	                        document.forms['form1'].elements['FECHANO_ENTREGA'].focus();     
	                      }
	                    }
	                  }
	                }
	              }
	            }
	          }
	        }
	        
	        /* si el programa esta activo... */
	        /* comprobamos que la de lanzamiento este informada y entre los limites, y luego que sea laborable*/
	        if(!errores){
	          if(document.forms['form1'].elements['ACTIVO'].checked==true){
	            if((mensaje=test2(document.forms['form1'].elements['FECHANO_LANZAMIENTO']))!=''){
	              alert(msgLanzamientoObligatoria);
	              errores++;
	              document.forms['form1'].elements['FECHANO_LANZAMIENTO'].focus();
	            }
	            else{
	              /* miramos que este entre los limites*/
	              if(compararFechas(document.forms['form1'].elements['FECHANO_LANZAMIENTO'].value,'MENOR',document.forms['form1'].elements['FECHA_INICIO'].value)){
	                alert(msgLanzamientoAnteriorInicio);
	                errores++;
	                document.forms['form1'].elements['FECHANO_LANZAMIENTO'].focus();
	              }
	              else{
	                if(compararFechas(document.forms['form1'].elements['FECHANO_LANZAMIENTO'].value,'MENORIGUAL',document.forms['form1'].elements['FECHA_ACTUAL'].value)){                                                                                        
	                  alert(msgLanzamientoAnteriorActual);
	                  errores++;
	                  document.forms['form1'].elements['FECHANO_LANZAMIENTO'].focus();
	                }
	                else{
	                  if(compararFechas(document.forms['form1'].elements['FECHANO_LANZAMIENTO'].value,'MAYOR',document.forms['form1'].elements['FECHANO_FIN'].value)){
	                    alert(msgLanzamientoPosteriorFin);
	                    errores++;
	                    document.forms['form1'].elements['FECHANO_LANZAMIENTO'].focus();
	                  }
	                  else{
	                    /* miramos que sea un dia laborable*/
	                    
                      var fFechaSubmitTmp=new Date(formatoFecha(document.forms['form1'].elements['FECHANO_LANZAMIENTO'].value,'E','I'));
	                    if(fFechaSubmitTmp.getDay()==0 || fFechaSubmitTmp.getDay()==6){
                        alert(msgLanzamientoNoLaborable);
	                      errores++;
	                      document.forms['form1'].elements['FECHANO_LANZAMIENTO'].focus();     
	                    }
	                  }
	                }
	              }
	            }
	          }
	          else{
	            /* no esta activo, no es obligatorio */
	            if(document.forms['form1'].elements['FECHANO_LANZAMIENTO'].value!=''){
	              if((mensaje=test2(document.forms['form1'].elements['FECHANO_LANZAMIENTO']))!=''){
	                alert(msgLanzamientoObligatoria);
	                errores++;
	                document.forms['form1'].elements['FECHANO_LANZAMIENTO'].focus();
	              }
	              else{
	                /* miramos que este entre los limites*/
	                if(compararFechas(document.forms['form1'].elements['FECHANO_LANZAMIENTO'].value,'MENOR',document.forms['form1'].elements['FECHA_INICIO'].value)){
	                  alert(msgLanzamientoAnteriorInicio);
	                  errores++;
	                  document.forms['form1'].elements['FECHANO_LANZAMIENTO'].focus();
	                }
	                else{
	                  if(compararFechas(document.forms['form1'].elements['FECHANO_LANZAMIENTO'].value,'MENORIGUAL',document.forms['form1'].elements['FECHA_ACTUAL'].value)){                                                                                        
	                    alert(msgLanzamientoAnteriorActual);
	                    errores++;
	                    document.forms['form1'].elements['FECHANO_LANZAMIENTO'].focus();
	                  }
	                  else{
	                    if(compararFechas(document.forms['form1'].elements['FECHANO_LANZAMIENTO'].value,'MAYOR',document.forms['form1'].elements['FECHANO_FIN'].value)){
	                      alert(msgLanzamientoPosteriorFin);
	                      errores++;
	                      document.forms['form1'].elements['FECHANO_LANZAMIENTO'].focus();
	                    }
	                    else{
	                      /* miramos que sea un dia laborable*/
	                      
                        var fFechaSubmitTmp=new Date(formatoFecha(document.forms['form1'].elements['FECHANO_LANZAMIENTO'].value,'E','I'));
	                      if(fFechaSubmitTmp.getDay()==0 || fFechaSubmitTmp.getDay()==6){
                          alert(msgLanzamientoNoLaborable);
	                        errores++;
	                        document.forms['form1'].elements['FECHANO_LANZAMIENTO'].focus();     
	                      }
	                    }
	                  }
	                }
	              }
	            } 
	          }
	        }
	        
	        if(!errores)
	          return true;
	        else
	          return false;
	      }
	      
	      function SolicitarFecha(nombreFecha,objCheck){
	        if(objCheck.checked==false){
	          if(document.forms['form1'].elements['FECHANO_FIN'].value==''){
	            alert(msgFechaFinProgramaObligatoria);
	            document.forms['form1'].elements['FECHANO_'+nombreFecha].focus();
	          }
	        }
	      }
	      
	      function CargarPlazoEntrega(nombreTexto,idMultioferta){
	        
	        var plazoEntrega=3;
	        
	        if(idMultioferta!='-1'){
	          for(var n=0;n<arrPedidos.length;n++){
	            if(arrPedidos[n][4]==idMultioferta){
	              plazoEntrega=arrPedidos[n][6];
	            }
	          }
	        }
	        document.forms['form1'].elements[nombreTexto].value=plazoEntrega;
	      }
	      
	      function incrementarFecha(fecha,incremento){
	      
	        var FechaTMP;
	        var fFechaTMP; 
	        
	        
	        if(fecha!=''){
	          fFechaTMP=formatoFecha(fecha,'E','I');
	          fFechaTMP=new Date(fFechaTMP);  
            fFechaTMP=calcularDiasHabiles(fFechaTMP,incremento);
            var FechaTMP=fFechaTMP.getDate()+'/'+(Number(fFechaTMP.getMonth())+1)+'/'+fFechaTMP.getFullYear();
          }
          else{
            FechaTMP=fecha;
          }
          
          return FechaTMP;
	      }
	      
	      function CopiarPrograma(form, accion){
	        form.action=accion;
	        if(ValidarFormulario(form)){
	          if(compararFechas(form.elements['FECHA_INICIO'].value,'MENOR',form.elements['FECHA_ACTUAL'].value)){
	            var fFechaInicioCopia=calcularDiasHabiles(new Date(formatoFecha(form.elements['FECHA_ACTUAL'].value,'E','I')),1);
	            var FechaInicioCopia=fFechaInicioCopia.getDate()+'/'+(Number(fFechaInicioCopia.getMonth())+1)+'/'+fFechaInicioCopia.getFullYear();
	            form.elements['FECHA_INICIO'].value=FechaInicioCopia;
	          }
	          SubmitForm(form);
	        }
	      }
	      
	      function GuardarCambios(form,accion){
	        form.action=accion;
	        if(ValidarFormulario(form)){
	          SubmitForm(form);
	        }
	      }
	      
	      function calculaFechaCalendarios(fecha,mas){
	        if(fecha!=''){
            var hoy=new Date(formatoFecha(fecha,'E','I'));
          }
          else{
            var hoy=new Date();
            hoy=new Date(formatoFecha(hoy.getDate()+'/'+(Number(hoy.getMonth())+1)+'/'+hoy.getFullYear(),'E','I'));
          }
          var Resultado=calcularDiasHabiles(hoy,mas);  
 
          var elDia=Resultado.getDate();
          var elMes=Number(Resultado.getMonth())+1;
          var elAnyo=Resultado.getFullYear();
          var laFecha=elDia+'/'+elMes+'/'+elAnyo;
          
          return laFecha;   
    }
	      
	      
	      
	      
      //-->
	</script>
        ]]></xsl:text>
      </head>
      <body>   
      <xsl:attribute name="onLoad">
      	<xsl:if test="/PedidosProgramados/LISTAUSUARIOSCENTRO != 'N'"><!--si es provee no editable no ve alert-->
            CargarProveedores('IDPROVEEDOR',<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/IDUSUARIO"/>,'-1');   
            document.forms['form1'].elements['FECHA_INICIO'].value=incrementarFecha('<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/INICIOPROGRAMA"/>',0);
            
            <xsl:choose>
              <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/ESTADOPROGRAMA='F'">
                document.forms['form1'].elements['FECHANO_LANZAMIENTO'].value=incrementarFecha('<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/FECHA"/>',1);
              </xsl:when>
              <xsl:otherwise>
                document.forms['form1'].elements['FECHANO_LANZAMIENTO'].value=incrementarFecha('<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/DIALANZAMIENTO"/>',0);
              </xsl:otherwise>
            </xsl:choose>
            
            calculaFecha(document.forms['form1'],document.forms['form1'].elements['FECHANO_LANZAMIENTO'],document.forms['form1'].elements['PLAZOENTREGA'].value);
        </xsl:if>
      </xsl:attribute>   
        <xsl:choose>
          <xsl:when test="ListaDerechosUsuarios/xsql-error">
            <xsl:apply-templates select="ListaDerechosUsuarios/xsql-error"/>          
          </xsl:when>
        <xsl:when test="PedidosProgramados/SESION_CADUCADA">
          <xsl:apply-templates select="FamiliasYProductos/SESION_CADUCADA"/> 
        </xsl:when>
        <xsl:when test="PedidosProgramados/ROWSET/ROW/Sorry">
          <xsl:apply-templates select="PedidosProgramados/ROWSET/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
 	  <form name="form1" action="MantPedidosProgramadosSave.xsql" method="post">

      <input type="hidden" name="FECHA_CREACION" size="14" maxlength="10" value="{PedidosProgramados/PEDIDOPROGRAMADO/CREACION}"/>
      <input type="hidden" name="FECHA_ACTUAL" size="14" maxlength="10"  value="{PedidosProgramados/PEDIDOPROGRAMADO/FECHA}"/>
      <input type="hidden" name="IDEMPRESA" value="{PedidosProgramados/PEDIDOPROGRAMADO/IDEMPRESA}"/>
      <input type="hidden" name="PEDP_ID" value="{PedidosProgramados/PEDIDOPROGRAMADO/ID}"/>
      <input type="hidden" name="IDCENTRO" value="{PedidosProgramados/PEDIDOPROGRAMADO/IDCENTRO}"/>
      <input type="hidden" name="VENTANA" value="{//VENTANA}"/>
      <input type="hidden" name="IDUSUARIOCONSULTA" value="{PedidosProgramados/PEDIDOPROGRAMADO/IDUSUARIOCONSULTA}"/>
      <input type="hidden" name="MANUAL" value="{PedidosProgramados/PEDIDOPROGRAMADO/MANUAL}"/>
      
       <!--idioma-->
        <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/PedidosProgramados/LANG"><xsl:value-of select="/PedidosProgramados/LANG" /></xsl:when>
            <xsl:when test="/PedidosProgramados/LANGTESTI != ''"><xsl:value-of select="/PedidosProgramados/LANGTESTI" /></xsl:when>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
      <!--idioma fin-->
      
	  
	  
	  <!--
      <h1 class="titlePage">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/>&nbsp;<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/DESCRIPCION"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/CENTRO"/>
      </h1>
		-->



		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedidos_programados']/node()"/></span></p>
			<p class="TituloPagina">
				<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/DESCRIPCION"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/CENTRO"/>
				&nbsp;&nbsp;
				<span class="CompletarTitulo" style="width:300px;">
                    <a class="btnNormal" href="javascript:window.close();">
                      <xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
                    </a>&nbsp;
                    <a class="btnNormal" href="javascript:window.print();">
                      <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
                    </a>
				</span>
			</p>
		</div>
		<br/>



      <div class="divleft">
        <div class="divLeft10">&nbsp;</div>
        <div class="divLeft80">
            
      <table class="buscador">
       
        <xsl:if test="PedidosProgramados/PEDIDOPROGRAMADO/ESTADOPROGRAMA='F'">
          <tr class="sinLinea">
            <td class="labelRight cuarenta">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='estado_del_programa']/node()"/>:&nbsp;
            </td>
            <td class="datosLeft">
              <span class="rojo">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='programa_finalizado']/node()"/>
              </span>
            </td>
          </tr>
        </xsl:if>
        <tr class="sinLinea">
          <td class="labelRight cuarenta">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_del_programa']/node()"/>:&nbsp;
          </td>
          <td class="datosLeft">
            <!-- pendiente los tamanyos -->
            <input class="grande" type="hidden" name="DESCRIPCION" maxlength="100" size="100" value="{PedidosProgramados/PEDIDOPROGRAMADO/DESCRIPCION}"/>
            <xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/DESCRIPCION"/>
          </td>
        </tr>
        <tr class="sinLinea">
          <td class="labelRight">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>:&nbsp;
          </td>
          <td class="datosLeft">
                <xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/CENTRO"/>
          </td>
        </tr>
        <tr class="sinLinea">
          <td class="labelRight">
           <xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:&nbsp;
          </td>
          <td class="datosLeft">
                <xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/USUARIO"/>
                <input type="hidden" name="IDUSUARIO" value="{PedidosProgramados/PEDIDOPROGRAMADO/IDUSUARIO}"/>  
          </td>
        </tr>
        
            <input type="hidden" name="IDPROVEEDOR" value="{PedidosProgramados/PEDIDOPROGRAMADO/IDPROVEEDOR}"/>  
        <tr class="sinLinea">
          <td class="labelRight">
               <xsl:value-of select="document($doc)/translation/texts/item[@name='numero_de_programa']/node()"/>:&nbsp;
          </td>
          <td class="datosLeft">
				<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/NUMERO"/>
				<xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
				<input type="hidden" name="IDOFERTAMODELO" value="{PedidosProgramados/PEDIDOPROGRAMADO/IDOFERTAMODELO}"/>
				<input type="hidden" name="ESTADOOFERTA" value="{PedidosProgramados/PEDIDOPROGRAMADO/ESTADOOFERTA}"/>

				<!--<xsl:call-template name="botonPersonalizado">
				<xsl:with-param  name="funcion">MostrarMultioferta(document.forms['form1'].elements['IDOFERTAMODELO'].value,'-RO');</xsl:with-param>
				<xsl:with-param  name="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_pedido']/node()"/></xsl:with-param>
				<xsl:with-param  name="status"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_pedido']/node()"/></xsl:with-param>
				</xsl:call-template>  -->
				<a class="btnNormal" href="javascript:MostrarMultioferta(document.forms['form1'].elements['IDOFERTAMODELO'].value,'-RO');">
    				<xsl:value-of select="document($doc)/translation/texts/item[@name='pedido']/node()"/><!--<img src="http://www.newco.dev.br/images/iconVerPedido.gif" alt="Ver Pedido"/>-->
				</a>
          </td>
        </tr>
        <tr class="sinLinea">
          <td class="labelRight">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_prima_entrega']/node()"/>:&nbsp;
          </td>
          <td class="datosLeft">
                  <input type="text" name="FECHANO_ENTREGA"  size="14" maxlength="10"  style="text-align:left;" class="inputOculto" onFocus="this.blur();"/>
          </td>
        </tr>
       
        <xsl:choose>
        <xsl:when test="not(PedidosProgramados/PEDIDOPROGRAMADO/MANUAL='S')">
        <tr class="sinLinea">
          <td class="labelRight">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='frecuencia_de_entregas']/node()"/>:&nbsp;<span class="camposObligatorios">*</span>
          </td>
          <td class="datosLeft">
                  <xsl:for-each select="PedidosProgramados/field[@name='IDFRECUENCIA']/dropDownList/listElem">
             		 <xsl:if test="//PedidosProgramados/PEDIDOPROGRAMADO/TIPOPERIODO=ID">
                		<xsl:value-of select="listItem"/>
              		 </xsl:if>
            	   </xsl:for-each>
            <input type="hidden" name="IDFRECUENCIA" value="{PedidosProgramados/PEDIDOPROGRAMADO/TIPOPERIODO}"/>
                 <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
                <!-- mostramos el boton programacion manual cuando ya existe el programa -->
                  <xsl:if test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE">
                      
                    <!--<xsl:call-template name="botonPersonalizado">
                        <xsl:with-param  name="funcion">MostrarPag('http://www.newco.dev.br/Compras/PedidosProgramados/LanzamientosPedidosProgramados.xsql?IDUSUARIO='+document.forms['form1'].elements['IDUSUARIOCONSULTA'].value+'&amp;PEDP_ID='+document.forms['form1'].elements['PEDP_ID'].value+'&amp;FECHAACTIVA='+document.forms['form1'].elements['FECHANO_ENTREGA'].value+'&amp;VENTANA=NUEVA'+'&amp;ACCION=LanzamientosPedidosProgramadosSave.xsql&amp;TITULO=Programación manual','lanzamientosProgramas');</xsl:with-param>
                        <xsl:with-param  name="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_programacion_manual']/node()"/></xsl:with-param>
                        <xsl:with-param  name="status"><xsl:value-of select="document($doc)/translation/texts/item[@name='visualiza_fechas_entrega']/node()"/></xsl:with-param>
                   </xsl:call-template>-->
                   
                        <a class="btnNormal" href="javascript:MostrarPag('http://www.newco.dev.br/Compras/PedidosProgramados/LanzamientosPedidosProgramados.xsql?IDUSUARIO='+document.forms['form1'].elements['IDUSUARIOCONSULTA'].value+'&amp;PEDP_ID='+document.forms['form1'].elements['PEDP_ID'].value+'&amp;FECHAACTIVA='+document.forms['form1'].elements['FECHANO_ENTREGA'].value+'&amp;VENTANA=NUEVA'+'&amp;ACCION=LanzamientosPedidosProgramadosSave.xsql&amp;TITULO=Programación manual','lanzamientosProgramas');">
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='ver_programacion_manual']/node()"/>
                        </a>
                 </xsl:if>
          </td>
        </tr>
        </xsl:when>
        <xsl:otherwise>
          <tr class="sinLinea">
          <td class="labelRight">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='frecuencia_de_entregas']/node()"/>:&nbsp;
          </td>
          <td class="datosLeft">
                  <xsl:value-of select="document($doc)/translation/texts/item[@name='asignada_manualmente_usuario']/node()"/>
                  <input type="hidden" name="IDFRECUENCIA" value="{PedidosProgramados/PEDIDOPROGRAMADO/TIPOPERIODO}"/>
                <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
               <!-- mostramos el boton programacion manual cuando ya existe el programa -->
                  <xsl:if test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE">
                   
                    <!-- pasamos el valor de no recargar la pagina, si en ella hacemos cambios (...Save) entonces le pasaremos 'S' desde la propia pagina  originalmente ponia 'S' 
                      
                      
                     <xsl:call-template name="botonPersonalizado">
                    <xsl:with-param  name="funcion">MostrarPag('http://www.newco.dev.br/Compras/PedidosProgramados/LanzamientosPedidosProgramados.xsql?IDUSUARIO='+document.forms['form1'].elements['IDUSUARIOCONSULTA'].value+'&amp;PEDP_ID='+document.forms['form1'].elements['PEDP_ID'].value+'&amp;FECHAACTIVA='+document.forms['form1'].elements['FECHANO_ENTREGA'].value+'&amp;VENTANA=NUEVA'+'&amp;ACCION=LanzamientosPedidosProgramadosSave.xsql&amp;TITULO=Programación manual','lanzamientosProgramas');</xsl:with-param>
                     <xsl:with-param  name="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_programacion_manual']/node()"/></xsl:with-param>
                     <xsl:with-param  name="status"><xsl:value-of select="document($doc)/translation/texts/item[@name='visualiza_fechas_entrega']/node()"/></xsl:with-param>
                  </xsl:call-template>-->
                  
                        <a class="btnNormal" href="MostrarPag('http://www.newco.dev.br/Compras/PedidosProgramados/LanzamientosPedidosProgramados.xsql?IDUSUARIO='+document.forms['form1'].elements['IDUSUARIOCONSULTA'].value+'&amp;PEDP_ID='+document.forms['form1'].elements['PEDP_ID'].value+'&amp;FECHAACTIVA='+document.forms['form1'].elements['FECHANO_ENTREGA'].value+'&amp;VENTANA=NUEVA'+'&amp;ACCION=LanzamientosPedidosProgramadosSave.xsql&amp;TITULO=Programación manual','lanzamientosProgramas');">
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='ver_programacion_manual']/node()"/>
                        </a>
                    
                  </xsl:if>
           </td>
        </tr>
        </xsl:otherwise>
      </xsl:choose>
       
            <input type="hidden" name="FECHA_INICIO"  size="14" maxlength="10" style="text-align:left;" class="inputOculto" onFocus="this.blur();"/>
        
        <tr class="sinLinea">
          <td class="labelRight">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_finalizacion_programa']/node()"/>:&nbsp;
          </td>
          <td class="datosLeft">
                  <input type="text" name="FECHANO_FIN" size="14" maxlength="10" style="text-align:left;" class="inputOculto" onFocus="this.blur();">
                    <xsl:if test="PedidosProgramados/PEDIDOPROGRAMADO/ESTADOPROGRAMA!='F'">
                    
                      <xsl:attribute name="value"><xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/FINPROGRAMA"/></xsl:attribute>
                    </xsl:if>
                  </input>
               		<xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
                  <xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_posterior_entrega']/node()"/>
          </td>
        </tr>
            <input type="hidden" size="2" maxlength="5" name="PLAZOENTREGA" value="{PedidosProgramados/PEDIDOPROGRAMADO/PLAZOENTREGA}"  class="inputOculto"  onFocus="this.blur();"/>
            <input type="hidden" name="FECHANO_LANZAMIENTO" size="14" maxlength="10"  style="text-align:left;" class="inputOculto" onFocus="this.blur();"/>
        
        <tr class="sinLinea">
          <td class="labelRight">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='solicitar_conf_envio']/node()"/>:&nbsp;
          </td>
          <td class="datosLeft">
                  <input type="hidden" name="CONFIRMAR">
                    <xsl:choose>
                      <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/CONFIRMAR='S'">
                        <xsl:attribute name="value">s</xsl:attribute>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:attribute name="value">n</xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>
                  </input>
                  <xsl:choose>
                    <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/CONFIRMAR='S'">
                      Sí
                    </xsl:when>
                    <xsl:otherwise>
                      No
                    </xsl:otherwise>
                  </xsl:choose> 
                <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
                <xsl:value-of select="document($doc)/translation/texts/item[@name='solicitar_conf_cada_pedido_programado']/node()"/>
          </td>
        </tr>
        <tr class="sinLinea">
          <td class="labelRight">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='comentario_anexos_ped_programado']/node()"/>:&nbsp;
          </td>
          <td class="datosLeft">
              <xsl:copy-of select="PedidosProgramados/PEDIDOPROGRAMADO/COMENTARIOS"/>
          </td>
        </tr>
        <tr class="sinLinea">
          <td class="labelRight">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='programa_visible_proveedor']/node()"/>:&nbsp;
          </td>
          <td class="datosLeft">
                  <input type="hidden" name="MOSTRARALPROVEEDOR">
                        <xsl:choose>
                          <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/PEDP_MOSTRARALPROVEEDOR='S'">
                            <xsl:attribute name="value">s</xsl:attribute>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:attribute name="value">n</xsl:attribute>
                          </xsl:otherwise>
                        </xsl:choose>
                  </input>
                  <xsl:choose>
                    <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/PEDP_MOSTRARALPROVEEDOR='S'">
                      Sí
                    </xsl:when>
                    <xsl:otherwise>
                      No
                    </xsl:otherwise>
                  </xsl:choose> 
               	<xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
                <xsl:value-of select="document($doc)/translation/texts/item[@name='programa_visible_proveedor_expli']/node()"/>
          </td>
        </tr>
        <tr class="sinLinea">
          <td class="labelRight">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='programa_activo']/node()"/>:&nbsp;
          </td>
          <td class="datosLeft">
                   <input type="hidden" name="ACTIVO">
                     <xsl:choose>
                       <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/INACTIVO='S'">
                         <xsl:attribute name="value">n</xsl:attribute>
                       </xsl:when>
                       <xsl:otherwise>
                         <xsl:attribute name="checked">s</xsl:attribute>
                       </xsl:otherwise>
                     </xsl:choose> 
                   </input>
                   <xsl:choose>
                     <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/INACTIVO='S'">
                       No
                     </xsl:when>
                     <xsl:otherwise>
                       Sí
                     </xsl:otherwise>
                   </xsl:choose>
                	<xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
                   <xsl:value-of select="document($doc)/translation/texts/item[@name='programa_activo_expli']/node()"/>
          </td>
        </tr>
		<!--
        <tr class="sinLinea"><td colspan="2">&nbsp;</td></tr>
        <tr class="sinLinea">
            <td>&nbsp;</td>
            <td> 
                <div class="boton">
                    <a href="javascript:window.close();">
                      <xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
                    </a>
                </div>
                <div class="boton" style="margin-left:40px;">
                    <a href="javascript:window.print();">
                      <xsl:value-of select="document($doc)/translation/texts/item[@name='imprimir']/node()"/>
                    </a>
                </div>
            </td>
        </tr>
		-->
      </table>
        </div>
     </div><!--fin de divLeft-->
    </form>
    
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  
</xsl:stylesheet>
