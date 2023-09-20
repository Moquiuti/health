<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Ficha de PROGRAMA
	Ultima revisión: ET 13jun18 13:03
 +-->
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
            <xsl:when test="/Analizar/LANG"><xsl:value-of select="/Analizar/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
      <!--idioma fin-->
      
    <title><xsl:value-of select="document($doc)/translation/texts/item[@name='mant_pedido_programado']/node()"/>&nbsp;<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/DESCRIPCION"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/CENTRO"/></title>
     <!--style-->
      <xsl:call-template name="estiloIndip"/>
     <!--fin de style-->  
 	<link rel="stylesheet" href="http://www.newco.dev.br/General/calendario/spiffyCal_v2_1.css" type="text/css"/>
    <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
    <script type="text/javascript" src="http://www.newco.dev.br/General/calendario/spiffyCal_v2_1.js"></script>  
    
	<xsl:text disable-output-escaping="yes"><![CDATA[
	
    <script type="text/javascript">
      <!--

        var msgSinPedidoParaMostrar='Por favor, seleccione un pedido.'; 
        var msgSinProveedorVacaciones='Por favor, seleccione un proveedor.';
        var msgFechaFinProgramaObligatoria='Por favor, introduzca la fecha en la que el programa finalizará.';
        var msgNumeroDePedido='RECUERDE:\nSi piensa asignar un número de pedido debe dejar marcada esta casilla.';
        
        var msgDescripcionPrograma='Por favor, rellene el campo Nombre del programa.\n(le ayudará a identificarlo posteriormente)';
	var msgUsuarioPrograma='Por favor, seleccione el usuario que enviará el pedido.';
        var msgProveedorPrograma='Por favor, seleccione el proveedor del pedido que quiere programar.';
        var msgOfertaPrograma='Por favor, seleccione el número pedido que quiere programar.';
        var msgFrecuenciaPrograma='Por favor, seleccione la frecuencia con la que el pedido será entregado.';
        var msgFechaFinObligatoria='Por favor, introduzca la fecha en la que el programa finalizará.';
        var msgBorrarPrograma='¿Confirma la eliminación del programa?';
        
        var msgUsuarioUltimosComentarios='Por favor, seleccione el usuario para el que quiere consultar sus últimos comentarios.';
        var msgProveedorUltimosComentarios='Por favor, seleccione un proveedor antes de consutar los últimos comentarios';
        
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
            
            var msgFinAnteriorEntregaConCambio='La fecha de finalización introducida es anterior a la fecha de entrega del programa.\nPor favor, introduzca una fecha posterior.';
            var msgFinAnteriorEntrega='La fecha de finalización introducida es anterior a la fecha de entrega del programa.\nPor favor, introduzca una fecha posterior.';
            
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
        
        
        
        
        
        var arrProveedores=new Array();
        var arrPedidos=new Array();
        var arrUsuarios=new Array();
        
        
        ]]></xsl:text>
        
          <xsl:for-each select="PedidosProgramados/PEDIDOPROGRAMADO/PROVEEDORES/PROVEEDOR">
            arrProveedores[arrProveedores.length]=new Array('<xsl:value-of select="@ID"/>','<xsl:value-of select="@NOMBRE"/>');
            <xsl:for-each select="PEDIDOS/PEDIDO">
              arrPedidos[arrPedidos.length]=new Array('<xsl:value-of select="../../@ID"/>','<xsl:value-of select="ID"/>','<xsl:value-of select="NUMERO"/>','<xsl:value-of select="IDUSUARIO"/>','<xsl:value-of select="IDOFERTAMODELO"/>','<xsl:value-of select="ESTADOOFERTA"/>','<xsl:value-of select="PLAZOENTREGA"/>');
            </xsl:for-each> 
          </xsl:for-each>
          
          <xsl:for-each select="PedidosProgramados/PEDIDOPROGRAMADO/USUARIOS_DEL_CENTRO/USUARIO">
            arrUsuarios[arrUsuarios.length]=new Array('<xsl:value-of select="ID"/>','<xsl:value-of select="NOMBRE"/>');
          </xsl:for-each>
          
        <xsl:text disable-output-escaping="yes"><![CDATA[
        
        
        function EliminarPrograma(form,accion){
            
            ]]></xsl:text> 
            
              var idpedido='<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/ID"/>';
              var idofertamodelo='<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/IDOFERTAMODELO"/>';
            
            <xsl:text disable-output-escaping="yes"><![CDATA[
            
            var ventana=document.forms['form1'].elements['VENTANA'].value;
            
            if(confirm(msgBorrarPrograma)){
              document.location.href=accion+'?PEDP_ID='+idpedido+'&IDOFERTAMODELO='+idofertamodelo+'&VENTANA='+ventana;
            }
          }
        
        
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
          
          //alert(objFecha.name);
          
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
          
            /* si la fecha de entrega es nula, no hacemos nada */
            
            if(FechaEntrega.replace(' ','')==''){ 
              form.elements['FECHANO_ENTREGA'].value='';
              form.elements['FECHANO_LANZAMIENTO'].value='';
              form.elements['FECHANO_FIN'].value='';
            }
            else{
                  
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
                if(confirm('La fecha de entrega actual no es válida. La fecha de entrega no puede ser anterior al: '+FechaEntregaMinima+'\n\n¿Desea asignar el '+FechaEntregaMinima+' como la fecha de entrega?')){
                  form.elements['FECHANO_ENTREGA'].value=FechaEntregaMinima;
                  form.elements['FECHANO_LANZAMIENTO'].value=convertirFechaATexto(calcularDiasHabiles(fFechaEntregaMinima,-plazoEntregaUsado));
                
                }
                else{
                  form.elements['FECHANO_ENTREGA'].value='';
                  form.elements['FECHANO_LANZAMIENTO'].value='';
                  form.elements['FECHANO_FIN'].value='';
                }
              }
            
              if(!esLaborable){
                if(confirm('La fecha de entrega actual no corresponde a un día laborable.\n\n¿Desea asignar el '+FechaEntregaTmp+' como la fecha de entrega?')){
                  form.elements['FECHANO_ENTREGA'].value=FechaEntregaTmp;
                  form.elements['FECHANO_LANZAMIENTO'].value=convertirFechaATexto(calcularDiasHabiles(fFechaEntregaTmp,-plazoEntregaUsado));
                }
                else{
                  form.elements['FECHANO_ENTREGA'].value='';
                  form.elements['FECHANO_LANZAMIENTO'].value='';
                  form.elements['FECHANO_FIN'].value='';
                }
              }
            
              if(fechaPosterior){
                if(form.elements['IDFRECUENCIA'].value!=1){
                  if(confirm('La fecha de finalización actual no es válida. La fecha de finalización no puede ser anterior al: '+form.elements['FECHANO_ENTREGA'].value+'\n\n¿Desea asignar el '+form.elements['FECHANO_ENTREGA'].value+' como la fecha de finalización?')){
                    form.elements['FECHANO_FIN'].value=form.elements['FECHANO_ENTREGA'].value;
                  }
                  else{
                    form.elements['FECHANO_FIN'].value='';
                  }
                }
              }
            
              if(!fechaAnterior && esLaborable && !fechaPosterior){
                form.elements['FECHANO_LANZAMIENTO'].value=convertirFechaATexto(calcularDiasHabiles(fFechaEntrega,-plazoEntregaUsado));
              }
            
              if(form.elements['IDFRECUENCIA'].value==1){
                form.elements['FECHANO_FIN'].value=form.elements['FECHANO_ENTREGA'].value;
              }
              
            
              /*
                fin nacho
              */
            
            }
          }
                  
                                    /*  LANZAMIENTO */
          else{  
          
 
            //      
            //             /*
            //              miramos que la fecha de lanzamiento no sea inferior a la de inicio
            //              si es correcta miramos que sea un dia laborable
            //              si ni lo es lo indicamos y calculamos con el nuevo valor
            //            */
                  
        
            if(objInvocador=='LANZAMIENTO'){
              if(FechaLanzamiento.replace(' ','')==''){
                form.elements['FECHANO_ENTREGA'].value='';
                form.elements['FECHANO_LANZAMIENTO'].value='';
                form.elements['FECHANO_FIN'].value='';
              }
              else{
            
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
                  
                    if(confirm('La fecha de entrega actual no es válida. La fecha de entrega no puede ser anterior al: '+FechaEntregaMinima+'\n\n¿Desea asignar el '+FechaEntregaMinima+' como la fecha de entrega?')){
                      form.elements['FECHANO_ENTREGA'].value=FechaEntregaMinima;
                      form.elements['FECHANO_LANZAMIENTO'].value=convertirFechaATexto(calcularDiasHabiles(fFechaEntregaMinima,-plazoEntregaUsado));
                
                    }
                    else{
                      form.elements['FECHANO_ENTREGA'].value='';
                      form.elements['FECHANO_LANZAMIENTO'].value='';
                      form.elements['FECHANO_FIN'].value='';
                    }
                  }
                  else{
                    alert('La fecha de entrega actual no es válida. la fecha de entrega no puede ser anterior al: '+FechaEntregaMinima+'\n\nPor favor, pulse sobre el boton \"Programación manual\" para seleccionar una fecha de entrega válida.');
                  }
                }
              
                if(!fechaAnterior && esLaborable && !fechaPosterior){
                  form.elements['FECHANO_LANZAMIENTO'].value=convertirFechaATexto(calcularDiasHabiles(fFechaEntregaTmp,-plazoEntregaUsado));
                }
              
                if(form.elements['IDFRECUENCIA'].value==1){
                  form.elements['FECHANO_FIN'].value=form.elements['FECHANO_ENTREGA'].value;
                }
              }
         
                /*
                  fin nacho
                */
         
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
                if(confirm('La fecha de finalización actual no es válida. La fecha de finalización no puede ser anterior al: '+FechaEntrega+'\n\n¿Desea asignar el '+FechaEntrega+' como la fecha de finalización?')){
                  form.elements['FECHANO_FIN'].value=FechaEntrega;
                }
                else{
                  form.elements['FECHANO_FIN'].value='';
                }
              }
            
              if(!esLaborable){
                if(confirm('La fecha de finalización actual no corresponde a un día laborable.\n\n¿Desea asignar el '+FechaFinTmp+' como la fecha de finalización?')){
                  form.elements['FECHANO_FIN'].value=FechaFinTmp;
                }
                else{
                  form.elements['FECHANO_FIN'].value='';
                }
              }

              /*
              fin nacho
              
              */


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
          
          //alert('LNZ: '+form.elements['FECHANO_LANZAMIENTO'].value+'\nENT: '+form.elements['FECHANO_ENTREGA'].value);
          
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
	            textoDefecto='[Nº de pedido]';
	            document.forms['form1'].elements['PLAZOENTREGA'].value=plazoentrega;
	          }
	          else{
	            textoDefecto='Nº de pedido';
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
	      
	      function MostrarMultioferta(idMultioferta, esModelo){
	        var estadoMultioferta;
	        var cadRead_only='';
	        var read_only='';
	        ]]></xsl:text>
	        
	        
	        <xsl:if test="not(PedidosProgramados/PEDIDOPROGRAMADO/EXISTE) and not(PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA)">
	          cadRead_only='-RO';
	          read_only='S';  
	        </xsl:if>
	        
	        
                  var idSesion='<xsl:value-of select="//SES_ID"/>';
                <xsl:text disable-output-escaping="yes"><![CDATA[
          
	        if(idMultioferta!='-1'){
	          if(document.forms['form1'].elements['ESTADOOFERTA'].value==''){
	            for(var n=0;n<arrPedidos.length;n++){
	              if(arrPedidos[n][4]==idMultioferta){
	                estadoMultioferta=arrPedidos[n][5];
	              }
	            }
	          }
	          else{
	            estadoMultioferta=document.forms['form1'].elements['ESTADOOFERTA'].value;
	          }
	          //MostrarPag('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID='+idMultioferta,'MultiofertaIncidencia');  quitado 3-4-14 actualiza mof mc
              
              MostrarPag('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID='+idMultioferta,'MultiofertaIncidencia'); 
	        }
	        else{
	          alert(msgSinPedidoParaMostrar);
	        }
	      }
	      
	      function ValidarFormulario(form){
	        var errores=0;
	        
	         /* quitamos los espacios sobrantes */
        
          for(var n=0;n<form.length;n++){
            if(form.elements[n].type=='text'){
              form.elements[n].value=quitarEspacios(form.elements[n].value);
            }
          }
          
          /* actualizamos con el valor correcto el campo manual */
          
          if(form.elements['IDFRECUENCIA'].value=='Z'){
            form.elements['MANUAL'].value='S';
          }
          else{
            form.elements['MANUAL'].value='N';
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
	        
	        if((!errores) && (document.forms['form1'].elements['IDPROVEEDOR'].value<=0)){
	          errores++;
	          alert(msgProveedorPrograma);
	          document.forms['form1'].elements['IDPROVEEDOR'].focus();
	        }
	        
	        
	        if((!errores) && (document.forms['form1'].elements['IDOFERTAMODELO'].value<=0)){
	          errores++;
	          alert(msgOfertaPrograma);
	          document.forms['form1'].elements['IDOFERTAMODELO'].focus();
	        }
	        
	        
	        
	        
	        /* si el programa esta activo... */
	        /* comprobamos que la de entrega este informada y mayor que la de inicio, y luego que sea laborable */
	        if(!errores){
	          if(document.forms['form1'].elements['ACTIVO'].checked==true){
	            
	            
	            /*
                8.7.2003
               
                miramos que la fecha de entrega este entre la fecha de inicio + el plazo de entrega y la fecha de fin y que sea un dia laborable
            
               */ 
               
               
              var fechaAnterior=0;
              var fechaIndeterminada=0;
              var fechaPosterior=0;
              var fechaLaborable=0;
              var fechaConCambio=0; 
              var esManual;
              
              var plazoEntregaUsado=document.forms['form1'].elements['PLAZOENTREGA'].value;
              
              if(form.elements['MANUAL'].value=='S'){
                esManual=1;
              }
              else{
                esManual=0;
              }
              
              if(!esManual){
              
              var FechaActual=document.forms['form1'].elements['FECHA_ACTUAL'].value;
              var FechaActualFormatoIngles=formatoFecha(FechaActual,'E','I');
              var fFechaActual=new Date(FechaActualFormatoIngles);
              
            
              var fFechaEjecucion=calcularDiasHabiles(fFechaActual,1);
              var FechaEjecucion=convertirFechaATexto(fFechaEjecucion);
              
            
              var fFechaEntregaMinima=calcularDiasHabiles(fFechaEjecucion,plazoEntregaUsado);
              var FechaEntregaMinima=convertirFechaATexto(fFechaEntregaMinima);          
              

              if(esFechaIndeterminada(document.forms['form1'].elements['FECHANO_ENTREGA'].value)){
                fechaIndeterminada=1;
              }
              else{
                if(compararFechas(document.forms['form1'].elements['FECHANO_ENTREGA'].value,'MENOR',FechaEntregaMinima)){
                  fechaAnterior=1;
                
                  if(recalcularPrograma==0){
                    recalcularPrograma=1;
                  }           
                }
              }
              
              if(fechaIndeterminada){
                  if(!esManual){
                    if(confirm('La fecha de entrega actual no es válida.\n\n¿Desea asignar el '+FechaEntregaMinima+' como la fecha de entrega?')){
                      document.forms['form1'].elements['FECHANO_ENTREGA'].value=FechaEntregaMinima;
                      document.forms['form1'].elements['FECHANO_LANZAMIENTO'].value=convertirFechaATexto(calcularDiasHabiles(fFechaEntregaMinima,-plazoEntregaUsado));
                    
                      if(document.forms['form1'].elements['IDFRECUENCIA'].value==1){
                        document.forms['form1'].elements['FECHANO_FIN'].value=document.forms['form1'].elements['FECHANO_ENTREGA'].value;
                      }
                    }
                    else{
                      errores++;
                      document.forms['form1'].elements['FECHANO_ENTREGA'].value='';
                      document.forms['form1'].elements['FECHANO_LANZAMIENTO'].value='';
                      document.forms['form1'].elements['FECHANO_FIN'].value='';
                    }
                  }
                  else{
                    errores++;
                    alert('La fecha de entrega actual no es válida. La fecha de entrega no puede ser anterior al: '+FechaEntregaMinima+'\n\nPor favor, pulse sobre el boton \"Programación manual\" para seleccionar una fecha de entrega válida.');
                  }
              }
              else{
                if(fechaAnterior){
                  if(!esManual){
                  
                    if(confirm('La fecha de entrega actual no es válida. La fecha de entrega no puede ser anterior al: '+FechaEntregaMinima+'\n\n¿Desea asignar el '+FechaEntregaMinima+' como la fecha de entrega?')){
                      document.forms['form1'].elements['FECHANO_ENTREGA'].value=FechaEntregaMinima;
                      document.forms['form1'].elements['FECHANO_LANZAMIENTO'].value=convertirFechaATexto(calcularDiasHabiles(fFechaEntregaMinima,-plazoEntregaUsado));
                    
                      if(document.forms['form1'].elements['IDFRECUENCIA'].value==1){
                        document.forms['form1'].elements['FECHANO_FIN'].value=document.forms['form1'].elements['FECHANO_ENTREGA'].value;
                      }
                    }
                    else{
                      errores++;
                      document.forms['form1'].elements['FECHANO_ENTREGA'].value='';
                      document.forms['form1'].elements['FECHANO_LANZAMIENTO'].value='';
                      document.forms['form1'].elements['FECHANO_FIN'].value='';
                    }
                  }
                  else{
                    errores++;
                    alert('La fecha de entrega actual no es válida. La fecha de entrega no puede ser anterior al: '+FechaEntregaMinima+'\n\nPor favor, pulse sobre el boton \"Programación manual\" para seleccionar una fecha de entrega válida.');
                  }
                }
              }  // fechaIndeterminada

	            } // !esManual
	            
	 
	            
	          }
	          else{
	            /* el programa no esta activo, no es obligatorio */
	            if(document.forms['form1'].elements['FECHANO_ENTREGA'].value!=''){
	            
	              
	              /*
                8.7.2003
               
                miramos que la fecha de entrega este entre la fecha de inicio + el plazo de entrega y la fecha de fin y que sea un dia laborable
            
               */ 
               
               
              var fechaAnterior=0;
              var fechaPosterior=0;
              var fechaLaborable=0;
              var fechaConCambio=0; 
              var esManual;
              
              var plazoEntregaUsado=document.forms['form1'].elements['PLAZOENTREGA'].value;
              
              if(form.elements['MANUAL'].value=='S'){
                esManual=1;
              }
              else{
                esManual=0;
              }
              
              if(!esManual){
              
            
              var FechaActual=document.forms['form1'].elements['FECHA_ACTUAL'].value;
              var FechaActualFormatoIngles=formatoFecha(FechaActual,'E','I');
              var fFechaActual=new Date(FechaActualFormatoIngles);
              
              var fFechaEjecucion=calcularDiasHabiles(fFechaActual,1);
              var FechaEjecucion=convertirFechaATexto(fFechaEjecucion);
              
            
              var fFechaEntregaMinima=calcularDiasHabiles(fFechaEjecucion,plazoEntregaUsado);
              var FechaEntregaMinima=convertirFechaATexto(fFechaEntregaMinima);          
              
              if(compararFechas(document.forms['form1'].elements['FECHANO_ENTREGA'].value,'MENOR',FechaEntregaMinima)){
                fechaAnterior=1;
                
                if(recalcularPrograma==0){
                  recalcularPrograma=1;
                }           
                
 
              }
              
              if(fechaAnterior){
                if(!esManual){
                  
                  if(confirm('La fecha de entrega actual no es válida. La fecha de entrega no puede ser anterior al: '+FechaEntregaMinima+'\n\n¿Desea asignar el '+FechaEntregaMinima+' como la fecha de entrega?')){
                    document.forms['form1'].elements['FECHANO_ENTREGA'].value=FechaEntregaMinima;
                    document.forms['form1'].elements['FECHANO_LANZAMIENTO'].value=convertirFechaATexto(calcularDiasHabiles(fFechaEntregaMinima,-plazoEntregaUsado));
                    
                    if(document.forms['form1'].elements['IDFRECUENCIA'].value==1){
                      document.forms['form1'].elements['FECHANO_FIN'].value=document.forms['form1'].elements['FECHANO_ENTREGA'].value;
                    }
                  }
                  else{
                    errores++;
                    document.forms['form1'].elements['FECHANO_ENTREGA'].value='';
                    document.forms['form1'].elements['FECHANO_LANZAMIENTO'].value='';
                    document.forms['form1'].elements['FECHANO_FIN'].value='';
                  }
                }
                else{
                  errores++;
                  alert('La fecha de entrega actual no es válida. La fecha de entrega no puede ser anterior al: '+FechaEntregaMinima+'\n\nPor favor, pulse sobre el boton \"Programación manual\" para seleccionar una fecha de entrega válida.');
                }
              }
  
              }  // !esManual
	              
	            }
	          }
	        }
	        
	        
	        /* si es manual no reclaculamos */
	        if(form.elements['MANUAL'].value=='S'){
            form.elements['RECALCULAR'].value='N';   
          }
          else{
            form.elements['RECALCULAR'].value='S';
          }
	        
	        
	        
	        
	        if((!errores) && (document.forms['form1'].elements['IDFRECUENCIA'].value<=0)){
	          errores++;
	          alert(msgFrecuenciaPrograma);
	          document.forms['form1'].elements['IDFRECUENCIA'].focus();
	        }
	        
	        /* miramos la fecha de inicio */
	        
	        if(!errores){
	        
	          var esManual;
              
              if(form.elements['MANUAL'].value=='S'){
                esManual=1;
              }
              else{
                esManual=0;
              }
              
	        
	          if(!esManual){ 
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
	          }// !esManual
	        }
	        
	        /* si esta activo el check de confirmacion  el campo fecha fin es obligatorio */
	        
	        if((!errores)){
	          var esManual;
              
              
              if(form.elements['MANUAL'].value=='S'){
                esManual=1;
              }
              else{
                esManual=0;
              }
              
            if(!esManual){
	          /* no esta marcado, fecha obligatoria */
	          if((document.forms['form1'].elements['CONFIRMAR'].checked==false)){
	              /* si hay error de comprobacion */
	            if((mensaje=test2(document.forms['form1'].elements['FECHANO_FIN']))!='' && document.forms['form1'].elements['IDFRECUENCIA'].value!=1){
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
					   
					//
					//
					//	ET	19/6/03	No importa que la fecha de final caiga en festivo, quitamos este control
					//
	                //	var fFechaSubmitTmp=new Date(formatoFecha(document.forms['form1'].elements['FECHANO_FIN'].value,'E','I'));
	                //	if(fFechaSubmitTmp.getDay()==0 || fFechaSubmitTmp.getDay()==6){
                    //	alert(msgFinNoLaborable);
	                //	  errores++;
	                //	  document.forms['form1'].elements['FECHANO_FIN'].focus();     
	                //}
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
					//
					//
					//	ET	19/6/03	No importa que la fecha de final caiga en festivo, quitamos este control
					//
	                //  var fFechaSubmitTmp=new Date(formatoFecha(document.forms['form1'].elements['FECHANO_FIN'].value,'E','I'));
	                //    if(fFechaSubmitTmp.getDay()==0 || fFechaSubmitTmp.getDay()==6){
                    //    alert(msgFinNoLaborable);
	                //      errores++;
	                //      document.forms['form1'].elements['FECHANO_FIN'].focus();     
	                //    }
	                }
	              }
	            }
	          }
	          }// !esManual
	        }
	        
	        
	        
	        /* si el programa esta activo... */
	        /* comprobamos que la de lanzamiento este informada y entre los limites, y luego que sea laborable*/
	        if(!errores){
	          var esManual;
              
              var plazoEntregaUsado=document.forms['form1'].elements['PLAZOENTREGA'].value;
              
              if(form.elements['MANUAL'].value=='S'){
                esManual=1;
              }
              else{
                esManual=0;
              }
              
            if(!esManual){
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
	          }// !esManual
	        }
	        
	        if(!errores)
	          return true;
	        else
	          return false;
	      }
	      
	      function SolicitarFecha(nombreFecha,objCheck){
	        if(objCheck.checked==false){
	        	if(document.forms['form1'].elements['IDFRECUENCIA'].value!=1){
	          	if(document.forms['form1'].elements['FECHANO_FIN'].value==''){
	            	if(document.forms['form1'].elements['FECHANO_'+nombreFecha].disabled==false){
	              	alert(msgFechaFinProgramaObligatoria+'\n\n'+msgNumeroDePedido);
	              	document.forms['form1'].elements['FECHANO_'+nombreFecha].focus();
	            	}
	          	}
	          	else{
	          		if(document.forms['form1'].elements['FECHANO_'+nombreFecha].disabled==false){
	              	alert(msgNumeroDePedido);
	            	}
	          	}
	          }
	          else{
	          	if(document.forms['form1'].elements['FECHANO_'+nombreFecha].disabled==false){
	            	alert(msgNumeroDePedido);
	            }
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
	          if(compararFechas(form.elements['FECHA_INICIO'].value,'MENORIGUAL',form.elements['FECHA_ACTUAL'].value)){
	            var fFechaInicioCopia=calcularDiasHabiles(new Date(formatoFecha(form.elements['FECHA_ACTUAL'].value,'E','I')),1);
	            var FechaInicioCopia=fFechaInicioCopia.getDate()+'/'+(Number(fFechaInicioCopia.getMonth())+1)+'/'+fFechaInicioCopia.getFullYear();
	            form.elements['FECHA_INICIO'].value=FechaInicioCopia;
	            form.elements['FINALICACION_FECHA'].value=form.elements['FECHANO_FIN'].value;
	            FINALICACION_FECHA
	          }
	          SubmitForm(form);
	        }
	      }
	      
	      function GuardarCambios(form,accion){
	        //alert(form.elements['FECHANO_FIN'].value);
            
	        form.action=accion;
	        if(ValidarFormulario(form)){
	          if(recalcularPrograma==0){
	            form.elements['RECALCULAR'].value='N';
            }
            else{
              if(recalcularPrograma==1){
	              form.elements['RECALCULAR'].value='S';
              }
              else{
                if(recalcularPrograma==-1){
	                form.elements['RECALCULAR'].value='N';
                }
              } 
            }
            form.elements['FINALICACION_FECHA'].value=form.elements['FECHANO_FIN'].value;
            // solo mostramos las fechas de entrega si el programa NO existe y es manual
            if(((form.elements['PEDP_ID'].value<=0 || form.elements['PEDP_ID'].value=='') && form.elements['IDFRECUENCIA'].value=='Z')||(form.elements['IDFRECUENCIA'].value=='Z' && form.elements['IDFRECUENCIA_ANTERIOR'].value!=form.elements['IDFRECUENCIA'].value)){
              form.elements['EDITAR_FECHAS'].value='S';
            }
            else{
              form.elements['EDITAR_FECHAS'].value='N';
            }
              document.getElementById("aceptarBoton").style.display = 'none';
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
    
    function MostrarVacacionesProveedor(idProveedor){
      if(idProveedor!=-1){
        MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID='+idProveedor+'&VENTANA=NUEVA','empresa',65,58,0,-50);
      }
      else{
        alert(msgSinProveedorVacaciones);
      }
    }
    
    function habilitarDeshabilitarFechas(valor){
        /* si solo es un lanzamiento fecha fin=fecha entrega */
      if(valor=='1'){
        if(document.forms['form1'].elements['FECHANO_ENTREGA'].value==''){
          document.forms['form1'].elements['FECHANO_LANZAMIENTO'].value=document.forms['form1'].elements['FECHANO_LANZAMIENTO_ALMACENADA'].value;
          calculaFecha(document.forms['form1'],document.forms['form1'].elements['FECHANO_LANZAMIENTO'],document.forms['form1'].elements['PLAZOENTREGA'].value);
        }
        calFechaEntrega.enabled=true;
        document.forms['form1'].elements['FECHANO_ENTREGA'].disabled=false;
        
        document.forms['form1'].elements['FECHANO_FIN'].value=document.forms['form1'].elements['FECHANO_ENTREGA'].value;
        calFechaFin.enabled=false;
        document.forms['form1'].elements['FECHANO_FIN'].disabled=true;
      }
      else{
        /* es manual */
        if(valor=='Z'){
          document.forms['form1'].elements['FECHANO_FIN'].value='';
          calFechaFin.enabled=false;
          document.forms['form1'].elements['FECHANO_FIN'].disabled=true;
          
          document.forms['form1'].elements['FECHANO_ENTREGA'].value='';
          calFechaEntrega.enabled=false;
          document.forms['form1'].elements['FECHANO_ENTREGA'].disabled=true;
          
          document.forms['form1'].elements['FECHANO_LANZAMIENTO'].value='';
          
        }
        else{
          if(document.forms['form1'].elements['FECHANO_ENTREGA'].value==''){
            document.forms['form1'].elements['FECHANO_LANZAMIENTO'].value=document.forms['form1'].elements['FECHANO_LANZAMIENTO_ALMACENADA'].value;
            calculaFecha(document.forms['form1'],document.forms['form1'].elements['FECHANO_LANZAMIENTO'],document.forms['form1'].elements['PLAZOENTREGA'].value);
          }
          else{
            if(document.forms['form1'].elements['FECHANO_FIN'].value==document.forms['form1'].elements['FECHANO_ENTREGA'].value){
             document.forms['form1'].elements['FECHANO_FIN'].value='';
            }
          }
          calFechaFin.enabled=true;
          document.forms['form1'].elements['FECHANO_FIN'].disabled=false;
          
          calFechaEntrega.enabled=true;
          document.forms['form1'].elements['FECHANO_ENTREGA'].disabled=false;
          
        }
      }
    }
    
    
    
    function recargarPagina(){
      ]]></xsl:text>
        var pedp_id='<xsl:value-of select="/PedidosProgramados/PEDP_ID"/>';
        var listaPedidos='<xsl:value-of select="/PedidosProgramados/LISTAPEDIDOS"/>';
        var listaUsuariosCentro='<xsl:value-of select="/PedidosProgramados/LISTAUSUARIOSCENTRO"/>';
        var ventana='<xsl:value-of select="/PedidosProgramados/VENTANA"/>';
        var idOfertaModelo='<xsl:value-of select="/PedidosProgramados/IDOFERTAMODELO"/>';

        
      <xsl:text disable-output-escaping="yes"><![CDATA[
      document.location.href='http://www.newco.dev.br/Compras/PedidosProgramados/MantPedidosProgramados.xsql?PEDP_ID='+pedp_id+'&LISTAPEDIDOS='+listaPedidos+'&LISTAUSUARIOSCENTRO='+listaUsuariosCentro+'&VENTANA='+ventana+'&IDOFERTAMODELO='+idOfertaModelo;
    }
    
    function actualizarRecalculo(objDespl){
      if(objDespl.value!='Z'){
        if(recalcularPrograma==0){
          recalcularPrograma=1;
        }
      }
      else{
        recalcularPrograma=0;
      }
    }
    
    
    function ultimosComentarios(nombreObjeto,nombreForm,tipoComentario){
    
      var accion='CONSULTAR';
      MostrarPagPersonalizada('http://www.newco.dev.br/Compras/NuevaMultioferta/UltimosComentarios.xsql?NOMBRE_OBJETO='+nombreObjeto+'&NOMBRE_FORM='+nombreForm+'&ACCION='+accion+'&TIPO='+tipoComentario+'&COMENTARIO='+document.forms[nombreForm].elements[nombreObjeto].value.replace(/\n/g,'\\\\n'),'comentarios',90,90,10,10);
    }
    
    function copiarComentarios(nombreForm,nombreObjeto,texto){
      if(quitarEspacios(document.forms[nombreForm].elements[nombreObjeto].value)!=''){
        document.forms[nombreForm].elements[nombreObjeto].value+='\n\n';
      }
      document.forms[nombreForm].elements[nombreObjeto].value+=texto;
    }
    
    
    
	        
      //-->
	</script>
        ]]></xsl:text>
      </head>
      <body>   
      <xsl:attribute name="onLoad">
        <xsl:choose>
          <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/ADMIN">
               <!-- es admin -->
            <xsl:choose>
              <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
                   <!-- no es nuevo -->
                CargarUsuarios('IDUSUARIO','<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/IDUSUARIO"/>','<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/IDPROVEEDOR"/>','<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/IDOFERTAMODELO"/>');
              </xsl:when>
              <xsl:otherwise>
                  <!--  nueva programacion -->
                CargarUsuarios('IDUSUARIO','<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/IDUSUARIO"/>','-1','-1');
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
              <!--  no es admin -->
            <xsl:choose>
              <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
                 <!-- existe la programacion -->
                CargarProveedores('IDPROVEEDOR',<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/IDUSUARIO"/>,'-1');   
              </xsl:when>
              <xsl:otherwise>
                  <!-- nueva programacion -->
                CargarProveedores('IDPROVEEDOR','-1','-1');
              </xsl:otherwise>
            </xsl:choose>
            
          </xsl:otherwise>
        </xsl:choose>
            <!-- inicializacion de la fecha de inicio  -->
        <xsl:choose>
          <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE">
              document.forms['form1'].elements['FECHA_INICIO'].value=incrementarFecha('<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/INICIOPROGRAMA"/>',0);
          </xsl:when>
          <xsl:otherwise>
              document.forms['form1'].elements['FECHA_INICIO'].value=incrementarFecha('<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/FECHA"/>',1);
          </xsl:otherwise>
        </xsl:choose>
        
        
          <!-- inicializacion de la fecha de lanzamiento  -->
        <xsl:choose>
          <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE">
            <xsl:choose>
              <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/ESTADOPROGRAMA='F'">
                document.forms['form1'].elements['FECHANO_LANZAMIENTO'].value=incrementarFecha('<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/FECHA"/>',1);
              </xsl:when>
              <xsl:otherwise>
              document.forms['form1'].elements['FECHANO_LANZAMIENTO'].value=incrementarFecha('<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/DIALANZAMIENTO"/>',0);
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
              document.forms['form1'].elements['FECHANO_LANZAMIENTO'].value=incrementarFecha('<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/FECHA"/>',1);
          </xsl:otherwise>
        </xsl:choose>
        document.forms['form1'].elements['FECHANO_LANZAMIENTO_ALMACENADA'].value=document.forms['form1'].elements['FECHANO_LANZAMIENTO'].value;
        
        
        calculaFecha(document.forms['form1'],document.forms['form1'].elements['FECHANO_LANZAMIENTO'],document.forms['form1'].elements['PLAZOENTREGA'].value);
        <xsl:if test="PedidosProgramados/PEDIDOPROGRAMADO/TIPOPERIODO='1'">
          <xsl:if test="PedidosProgramados/PEDIDOPROGRAMADO/MANUAL='N'">
            calFechaFin.enabled=false;
            document.forms['form1'].elements['FECHANO_FIN'].disabled=true;
          </xsl:if>
          
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

        <div id="spiffycalendar" class="text"></div>
                 
          <!-- si el programa es manual no tiene sentido mostrar el calendario -->
          
          <xsl:choose>
            <xsl:when test="not(PedidosProgramados/PEDIDOPROGRAMADO/MANUAL='S')">
          
              <script type="text/javascript">
                var calFechaFin = new ctlSpiffyCalendarBox("calFechaFin", "form1", "FECHANO_FIN","btnDateFechaFin",'',scBTNMODE_CLASSIC,'ONBLUR|calculaFecha(document.forms[\'form1\'],document.forms[\'form1\'].elements[\'FECHANO_FIN\'],0);#CHANGEDAY|calculaFecha(document.forms[\'form1\'],document.forms[\'form1\'].elements[\'FECHANO_FIN\'],0);');
              </script>
              <script type="text/javascript">
                var calFechaEntrega = new ctlSpiffyCalendarBox("calFechaEntrega", "form1", "FECHANO_ENTREGA","btnDateFechaEntrega",'',scBTNMODE_CLASSIC,'ONBLUR|calculaFecha(document.forms[\'form1\'],document.forms[\'form1\'].elements[\'FECHANO_ENTREGA\'],\'-\'+document.forms[\'form1\'].elements[\'PLAZOENTREGA\'].value);#CHANGEDAY|calculaFecha(document.forms[\'form1\'],document.forms[\'form1\'].elements[\'FECHANO_ENTREGA\'],\'-\'+document.forms[\'form1\'].elements[\'PLAZOENTREGA\'].value);');
              </script>
              
           </xsl:when>
         </xsl:choose>
       
        
 <form name="form1" action="MantPedidosProgramadosSave.xsql" method="post">
      <xsl:choose>
        <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
          <input type="hidden" name="FECHA_CREACION" size="14" maxlength="10" value="{PedidosProgramados/PEDIDOPROGRAMADO/CREACION}"/>
        </xsl:when>
        <xsl:otherwise>
          <input type="hidden" name="FECHA_CREACION" size="14" maxlength="10"  value="{PedidosProgramados/PEDIDOPROGRAMADO/FECHA}"/>
        </xsl:otherwise>
      </xsl:choose>
      
      <input type="hidden" name="FECHA_ACTUAL" size="14" maxlength="10"  value="{PedidosProgramados/PEDIDOPROGRAMADO/FECHA}"/>
      <input type="hidden" name="IDEMPRESA" value="{PedidosProgramados/PEDIDOPROGRAMADO/IDEMPRESA}"/>
      <input type="hidden" name="PEDP_ID" value="{PedidosProgramados/PEDIDOPROGRAMADO/ID}"/>
      <input type="hidden" name="IDCENTRO" value="{PedidosProgramados/PEDIDOPROGRAMADO/IDCENTRO}"/>
      <input type="hidden" name="VENTANA" value="{//VENTANA}"/>
      <input type="hidden" name="FINALICACION_FECHA"/>
      <input type="hidden" name="FECHANO_LANZAMIENTO_ALMACENADA"/>
      <input type="hidden" name="IDUSUARIOCONSULTA" value="{PedidosProgramados/PEDIDOPROGRAMADO/IDUSUARIOCONSULTA}"/>
      <input type="hidden" name="EDITAR_FECHAS"/>
      <input type="hidden" name="IDFRECUENCIA_ANTERIOR" value="{PedidosProgramados/PEDIDOPROGRAMADO/TIPOPERIODO}"/>
      <input type="hidden" name="MANUAL">
      
      
        <xsl:choose>
          <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/ESTADOPROGRAMA='F'">
            <xsl:attribute name="value">N</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="value"><xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/MANUAL"/></xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      </input>
      
      <input type="hidden" name="DESDEOFERTA">
        <xsl:choose>
          <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
            <xsl:attribute name="value">S</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="value">N</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      </input>
      
      
      <!-- si es desde oferta(el prograsma no existe), o el programa tadavia no existe,  hemos de recalcular (realmente es la primera vez que lo calculamos) -->
      <input type="hidden" name="RECALCULAR">
        <xsl:choose>
          <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA or not(PedidosProgramados/PEDIDOPROGRAMADO/EXISTE)">
            <xsl:attribute name="value">S</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
              <!-- el programa si existe, si el programa esta marcado como manual no recalculamos-->
            <xsl:choose>
              <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/MANUAL='S'">
                <xsl:attribute name="value">N</xsl:attribute>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="value">N</xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </input>
      <input type="hidden" name="PLAZOENTREGAOFERTAMODELO" value="{PedidosProgramados/PEDIDOPROGRAMADO/PLAZOENTREGAOFERTAMODELO}"/>
      <input type="hidden" name="ACTUALIZARPAGINA">
        <xsl:choose>
          <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/MANUAL='N'">
            <xsl:attribute name="value">S</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="value">S</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      </input>
      
      <!--idioma-->
        <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/PedidosProgramados/LANG"><xsl:value-of select="/PedidosProgramados/LANG" /></xsl:when>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
      <!--idioma fin-->


	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Pedidos']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='mant_pedido_programado']/node()"/></span></p>
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='mant_pedido_programado']/node()"/>&nbsp;&nbsp;
			&nbsp;&nbsp;
			<span class="CompletarTitulo">
				<xsl:choose>
					<xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
						<a class="btnDestacado" href="javascript:EliminarPrograma(document.forms['form1'],'http://www.newco.dev.br/Compras/PedidosProgramados/BorrarPedidoProgramado.xsql');">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/>
						</a>&nbsp;
					</xsl:when>
					<xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE and not(PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA)">
						<a class="btnNormal" href="javascript:window.close();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
						</a>&nbsp;
						<a class="btnDestacado" href="javascript:EliminarPrograma(document.forms['form1'],'http://www.newco.dev.br/Compras/PedidosProgramados/BorrarPedidoProgramado.xsql');">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/>
						</a>&nbsp;
					</xsl:when>
					<xsl:otherwise>
						<a class="btnNormal" href="javascript:window.close();">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
						</a>&nbsp;
					</xsl:otherwise>
				</xsl:choose>
              	<a class="btnDestacado" href="javascript:GuardarCambios(document.forms['form1'],'http://www.newco.dev.br/Compras/PedidosProgramados/MantPedidosProgramadosSave.xsql');" id="aceptarBoton">
               		<xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar_minu']/node()"/>
                </a>&nbsp;
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<!--
      <h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='mant_pedido_programado']/node()"/>&nbsp;<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/DESCRIPCION"/>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='de']/node()"/>&nbsp;<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/CENTRO"/></h1>
     -->
     <div class="divLeft">
     <!-- <div class="divLeft10">&nbsp;</div>-->
      <div class="divLeft80">
          
      <!--<table class="infoTable incidencias" cellspacing="5" style="border-bottom:2px solid #D7D8D7;">-->
      <table class="buscador">
        <xsl:if test="PedidosProgramados/PEDIDOPROGRAMADO/ESTADOPROGRAMA='F'">
          <tr class="sinLinea">
            <td class="labelRight grisMed">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='estado_del_programa']/node()"/>:&nbsp;
            </td>
            <td class="datosleft">
              <span class="rojo14"> <xsl:value-of select="document($doc)/translation/texts/item[@name='programa_finalizado']/node()"/></span>
            </td>
          </tr>
        </xsl:if>
        <tr class="sinLinea">
          <td class="labelRight trenta grisMed">
           <xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_del_programa']/node()"/>:&nbsp;<span class="camposObligatorios">*</span>
          </td>
          <td class="datosleft">
            <!-- pendiente los tamanyos -->
            <input type="text" class="muygrande" name="DESCRIPCION" maxlength="100" size="60">
              <xsl:if test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
                <xsl:attribute name="value">
                  <xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/DESCRIPCION"/>
                </xsl:attribute>
              </xsl:if>
            </input>
          </td>
        </tr>
        <tr class="sinLinea">
           <td class="labelRight grisMed">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_de_creacion']/node()"/>:&nbsp;
          </td>
           <td class="datosleft">
            <xsl:choose>
              <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
                <b><xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/CREACION"/></b>
              </xsl:when>
              <xsl:otherwise>
                <b><xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/FECHA"/></b>
              </xsl:otherwise>
            </xsl:choose>
          </td>
        </tr>
        <xsl:choose>
           <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/ADMIN">
        <tr class="sinLinea">
          <td class="labelRight grisMed">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/>:&nbsp;<span class="camposObligatorios">*</span>
          </td>
           <td class="datosleft">
                <select name="IDUSUARIO" onChange="CargarPedidosProveedor('IDOFERTAMODELO',document.forms['form1'].elements['IDPROVEEDOR'].value,document.forms['form1'].elements['IDOFERTAMODELO'].value);">  
                </select>
          </td>
        </tr>
        </xsl:when>
        <xsl:otherwise>
               <input type="hidden" name="IDUSUARIO" value="{PedidosProgramados/PEDIDOPROGRAMADO/IDUSUARIOCONSULTA}"/>  
        </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
          <!-- existe -->
          <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
            <tr class="sinLinea">
              <td class="labelRight grisMed">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:&nbsp;<span class="camposObligatorios">*</span>
              </td>
              <td class="datosLeft">
                <a href="javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={PedidosProgramados/PEDIDOPROGRAMADO/IDPROVEEDOR}&amp;VENTANA=NUEVA','empresa',100,60,0,-50)">
                  <xsl:attribute name="onMouseOver">window.status='Información sobre la empresa.';return true;</xsl:attribute>
                  <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
                  <xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/PROVEEDOR"/>
                </a>
                <input type="hidden" name="IDPROVEEDOR" value="{PedidosProgramados/PEDIDOPROGRAMADO/IDPROVEEDOR}"/>  
              </td>
            </tr>
            
          </xsl:when>
         <!-- no existe -->
          <xsl:otherwise>
            <tr class="sinLinea">
              <td class="labelRight grisMed">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/>:&nbsp;<span class="camposObligatorios">*</span>
              </td>
              <td class="datosLeft">
                      <select name="IDPROVEEDOR"  onChange="CargarPedidosProveedor('IDOFERTAMODELO',this.value,'-1');">
                      </select>
                    <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
                     <!-- <xsl:call-template name="botonPersonalizado">
                        <xsl:with-param  name="funcion">MostrarVacacionesProveedor(document.forms['form1'].elements['IDPROVEEDOR'].value);</xsl:with-param>
                        <xsl:with-param  name="label">Días hábiles</xsl:with-param>
                        <xsl:with-param  name="status">Días hábiles</xsl:with-param>
                        <xsl:with-param  name="ancho">120px</xsl:with-param>
                      </xsl:call-template>-->
                      <a href="javascript:MostrarVacacionesProveedor(document.forms['form1'].elements['IDPROVEEDOR'].value);">
                      	<xsl:value-of select="document($doc)/translation/texts/item[@name='dias_habiles']/node()"/>
                      </a>
              </td>
            </tr>
          </xsl:otherwise>
        </xsl:choose>
        <tr class="sinLinea">
          <td class="labelRight grisMed">
            <xsl:choose>
              <!-- existe -->
              <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
               <xsl:value-of select="document($doc)/translation/texts/item[@name='numero_de_programa']/node()"/>:&nbsp;
              </xsl:when>
                <!-- no existe -->
              <xsl:otherwise>
                <xsl:value-of select="document($doc)/translation/texts/item[@name='numero_de_programa']/node()"/>:&nbsp;<span class="camposObligatorios">*</span>
              </xsl:otherwise>
            </xsl:choose>
            
          </td>
          <td class="datosLeft">
          
                <xsl:choose>
                  <!-- existe -->
                  <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
                    <xsl:choose>
                      <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/NUMERO!=''">
                        <font color="NAVY">
                          &nbsp;&nbsp;&nbsp;&nbsp;<b><xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/NUMERO"/></b>
                        </font>
                      </xsl:when>
                      <xsl:otherwise>
                        <font color="NAVY">
                          <strong> <xsl:value-of select="document($doc)/translation/texts/item[@name='pendiente']/node()"/></strong>
                        </font>
                      </xsl:otherwise>
                    </xsl:choose>
                    <input type="hidden" name="IDOFERTAMODELO" value="{PedidosProgramados/PEDIDOPROGRAMADO/IDOFERTAMODELO}"/>
                    <input type="hidden" name="ESTADOOFERTA" value="{PedidosProgramados/PEDIDOPROGRAMADO/ESTADOOFERTA}"/>
                    
                  </xsl:when>
                    <!-- no existe -->
                  <xsl:otherwise>
                    <select name="IDOFERTAMODELO" onChange="CargarPlazoEntrega('PLAZOENTREGA',this.value);calculaFecha(document.forms['form1'],document.forms['form1'].elements['FECHANO_LANZAMIENTO'],document.forms['form1'].elements['PLAZOENTREGA'].value);habilitarDeshabilitarFechas(document.forms['form1'].elements['IDFRECUENCIA'].value)">
                    </select>
                    <input type="hidden" name="ESTADOOFERTA" value="{PedidosProgramados/PEDIDOPROGRAMADO/ESTADOOFERTA}"/>
                  </xsl:otherwise>
                </xsl:choose>
                <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
                  <a href="javascript:MostrarMultioferta(document.forms['form1'].elements['IDOFERTAMODELO'].value,'S');">
                      <xsl:choose>
                          <xsl:when test="/PedidosProgramados/LANG= 'spanish'"><img src="http://www.newco.dev.br/images/modificarPedidoModelo.gif" alt="Modificar pedido modelo" /></xsl:when>
                          <xsl:otherwise><img src="http://www.newco.dev.br/images/modificarPedidoModelo-BR.gif" alt="Modificar modelo de pedido" /></xsl:otherwise>
                      </xsl:choose>
                  </a> 
                <!--boton mostrar multioferta--> 
                <xsl:if test="PedidosProgramados/PEDIDOPROGRAMADO/PEDIDO_SIGUIENTE_DIFERENTE='S'">
                	 <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
                    <a>
                    <xsl:attribute name="href">javascript:MostrarMultioferta('<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/PROXIMA_OFERTA"/>','N');</xsl:attribute>
                      <xsl:choose>
                          <xsl:when test="/PedidosProgramados/LANG= 'spanish'"><img src="http://www.newco.dev.br/images/modificarProximoPedido.gif" alt="Modificar próximo pedido" /></xsl:when>
                          <xsl:otherwise><img src="http://www.newco.dev.br/images/modificarPedidoModelo-BR.gif" alt="Modificar próximo pedido" /></xsl:otherwise>
                      </xsl:choose>
                    </a>  
                </xsl:if>
           
          </td>
        </tr>
        
        <!-- si es manual, mostramos el calendario (edicion) -->
        <xsl:choose>
          <xsl:when test="not(PedidosProgramados/PEDIDOPROGRAMADO/MANUAL='S')">
            <tr class="sinLinea">
              <td class="labelRight grisMed">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_prima_entrega']/node()"/>:&nbsp;<span class="camposObligatorios">*</span>
              </td>
              <td class="datosLeft">
                    <script type="text/javascript">
                      calFechaEntrega.dateFormat="d/M/yyyy";
                      calFechaEntrega.writeControl();
                    </script>
            </td>
          </tr>
        </xsl:when>
        <xsl:otherwise>
          <tr class="sinLinea">
              <td class="labelRight grisMed">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_prox_entrega']/node()"/>:&nbsp;
              </td>
              <td class="datosLeft">
                    <input type="text" name="FECHANO_ENTREGA" size="14" maxlength="10" style="text-align:left;" class="inputOculto" onFocus="this.blur();"/>
            </td>
          </tr>
        </xsl:otherwise>
      </xsl:choose> 
        <!-- no mostramos la frecuencia, ya que es manual -->
      <xsl:choose>
        <xsl:when test="not(PedidosProgramados/PEDIDOPROGRAMADO/MANUAL='S')">
        <tr class="sinLinea">
          <td class="labelRight grisMed">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='frecuencia_de_entregas']/node()"/>:&nbsp;<span class="camposObligatorios">*</span>
          </td>
          <td class="datosLeft">
                  <xsl:call-template name="field_funcion">
                    <xsl:with-param name="path" select="PedidosProgramados/field[@name='IDFRECUENCIA']"/>
                    <xsl:with-param name="IDAct">
                      <xsl:choose><xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA"><xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/TIPOPERIODO"/></xsl:when><xsl:otherwise>-1</xsl:otherwise></xsl:choose>
                    </xsl:with-param>
                    <xsl:with-param name="cambio">habilitarDeshabilitarFechas(this.value);actualizarRecalculo(this);</xsl:with-param>
                  </xsl:call-template>
               
                <!-- mostramos el boton programacion manual cuando ya existe el programa -->
                  <xsl:if test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE">
                   <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
                    <!-- pasamos el valor de no recargar la pagina, si en ella hacemos cambios (...Save) entonces le pasaremos 'S' desde la propia pagina -  originalmente ponia 'S' -->
                      <xsl:variable name="actualizarPagina">
                        <xsl:if test="//PedidosProgramados/PEDIDOPROGRAMADO/MANUAL='N'">N</xsl:if>
                      </xsl:variable>
                      
                      <!--<xsl:call-template name="botonPersonalizado">
                        <xsl:with-param  name="funcion">MostrarPag('http://www.newco.dev.br/Compras/PedidosProgramados/LanzamientosPedidosProgramados.xsql?IDUSUARIO='+document.forms['form1'].elements['IDUSUARIOCONSULTA'].value+'&amp;PEDP_ID='+document.forms['form1'].elements['PEDP_ID'].value+'&amp;FECHAACTIVA='+document.forms['form1'].elements['FECHANO_ENTREGA'].value+'&amp;VENTANA=NUEVA'+'&amp;ACCION=LanzamientosPedidosProgramadosSave.xsql&amp;ACTUALIZARPAGINA=<xsl:value-of select="$actualizarPagina"/>&amp;TITULO=Programación manual&amp;READ_ONLY=S','lanzamientosProgramas');</xsl:with-param>
                        <xsl:with-param  name="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='ver_fechas_entrega']/node()"/></xsl:with-param>
                        <xsl:with-param  name="status">Permite visualizar las fechas de entrega</xsl:with-param>
                      </xsl:call-template>-->
                      <a>
                      <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Compras/PedidosProgramados/LanzamientosPedidosProgramados.xsql?IDUSUARIO='+document.forms['form1'].elements['IDUSUARIOCONSULTA'].value+'&amp;PEDP_ID='+document.forms['form1'].elements['PEDP_ID'].value+'&amp;FECHAACTIVA='+document.forms['form1'].elements['FECHANO_ENTREGA'].value+'&amp;VENTANA=NUEVA'+'&amp;ACCION=LanzamientosPedidosProgramadosSave.xsql&amp;ACTUALIZARPAGINA=<xsl:value-of select="$actualizarPagina"/>&amp;TITULO=Programación manual&amp;READ_ONLY=S','lanzamientosProgramas');</xsl:attribute>
                      	<xsl:value-of select="document($doc)/translation/texts/item[@name='ver_fechas_entrega']/node()"/>
                    </a>  
                  </xsl:if>
                 
           </td>
        </tr>
        <tr class="sinLinea">
        	<td>&nbsp;</td>
            <td class="datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='pedido_automatico_no_modificar']/node()"/></td>
        </tr>
        </xsl:when>
        <xsl:otherwise>
          <tr class="sinLinea">
          <td class="labelRight grisMed">
            <xsl:copy-of select="document($doc)/translation/texts/item[@name='frecuencia_de_entregas']/node()"/>:&nbsp;
          </td>
          <td class="datosLeft">
                  <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='asignada_manualmente_usuario']/node()"/></strong>
                  <input type="hidden" name="IDFRECUENCIA" value="{PedidosProgramados/PEDIDOPROGRAMADO/TIPOPERIODO}"/>
         
               <!-- mostramos el boton programacion manual cuando ya existe el programa -->
                  <xsl:if test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE">
                    <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
                    <!-- pasamos el valor de no recargar la pagina, si en ella hacemos cambios (...Save) entonces le pasaremos 'S' desde la propia pagina - originalmente ponia 'S' -->
                      <xsl:variable name="actualizarPagina">
                        <xsl:if test="//PedidosProgramados/PEDIDOPROGRAMADO/MANUAL='N'">N</xsl:if>
                      </xsl:variable>
                      
                      <!--<xsl:call-template name="botonPersonalizado">
                        <xsl:with-param  name="funcion">MostrarPag('http://www.newco.dev.br/Compras/PedidosProgramados/LanzamientosPedidosProgramados.xsql?IDUSUARIO='+document.forms['form1'].elements['IDUSUARIOCONSULTA'].value+'&amp;PEDP_ID='+document.forms['form1'].elements['PEDP_ID'].value+'&amp;FECHAACTIVA='+document.forms['form1'].elements['FECHANO_ENTREGA'].value+'&amp;VENTANA=NUEVA'+'&amp;ACCION=LanzamientosPedidosProgramadosSave.xsql&amp;ACTUALIZARPAGINA=<xsl:value-of select="$actualizarPagina"/>&amp;TITULO=Programación manual','lanzamientosProgramas');</xsl:with-param>
                        <xsl:with-param  name="label">Programación manual</xsl:with-param>
                        <xsl:with-param  name="status">Permite asignar las fechas de entrega de forma manual</xsl:with-param>
                      </xsl:call-template>-->
                   	
                     <a>
                     <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Compras/PedidosProgramados/LanzamientosPedidosProgramados.xsql?IDUSUARIO='+document.forms['form1'].elements['IDUSUARIOCONSULTA'].value+'&amp;PEDP_ID='+document.forms['form1'].elements['PEDP_ID'].value+'&amp;FECHAACTIVA='+document.forms['form1'].elements['FECHANO_ENTREGA'].value+'&amp;VENTANA=NUEVA'+'&amp;ACCION=LanzamientosPedidosProgramadosSave.xsql&amp;ACTUALIZARPAGINA=<xsl:value-of select="$actualizarPagina"/>&amp;TITULO=Programación manual','lanzamientosProgramas');</xsl:attribute>
                      	<xsl:value-of select="document($doc)/translation/texts/item[@name='ver_programacion_manual']/node()"/>
                    </a>  
                  </xsl:if>
              </td> 
        </tr>
        </xsl:otherwise>
      </xsl:choose>
            <input type="hidden" name="FECHA_INICIO"  size="14" maxlength="10" onBlur="calculaFecha(document.forms['form1'],this,document.forms['form1'].elements['PLAZOENTREGA'].value);"/>
            
      <xsl:choose>
        <xsl:when test="not(PedidosProgramados/PEDIDOPROGRAMADO/MANUAL='S')">
        <tr class="sinLinea">
          <td class="labelRight grisMed">
          	<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_finalizacion_programa']/node()"/>:&nbsp;
          </td>
          <td class="datosLeft">
                  <script type="text/javascript">
                    calFechaFin.dateFormat="d/M/yyyy";
                    <xsl:choose> 
                      <xsl:when test="not(PedidosProgramados/PEDIDOPROGRAMADO/EXISTE)">
                        calFechaFin.minDate=new Date(formatoFecha(calculaFechaCalendarios('<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/CREACION"/>',1),'E','I'));
                      </xsl:when>
                      <xsl:otherwise>
                        calFechaFin.minDate=new Date(formatoFecha(calculaFechaCalendarios('<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/INICIOPROGRAMA"/>',0),'E','I'));
                      </xsl:otherwise>
                    </xsl:choose>
                    calFechaFin.writeControl();
                    <xsl:if test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
                      <xsl:if test="PedidosProgramados/PEDIDOPROGRAMADO/ESTADOPROGRAMA!='F'">
                        calFechaFin.setTextBoxValue('<xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/FINPROGRAMA"/>');
                      </xsl:if>
                    </xsl:if>
                  </script>
                  <xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_posterior_entrega']/node()"/>.
          </td>
        </tr>
        </xsl:when>
        <xsl:otherwise>
          
        <tr class="sinLinea">
          <td class="labelRight grisMed">
          	<xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_finalizacion_programa']/node()"/>:&nbsp;
          </td>
          <td class="datosLeft">
                  <input type="text" name="FECHANO_FIN" size="14" maxlength="10" onFocus="this.blur();" style="text-align:left;" class="inputOculto">
                    <xsl:if test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
                      <xsl:if test="PedidosProgramados/PEDIDOPROGRAMADO/ESTADOPROGRAMA!='F'">
                        <xsl:attribute name="value">
                          <xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/FINPROGRAMA"/>
                        </xsl:attribute>
                      </xsl:if>
                    </xsl:if>
                  </input>
                <xsl:value-of select="document($doc)/translation/texts/item[@name='fecha_posterior_entrega']/node()"/>.
          </td>
        </tr>
        </xsl:otherwise>
        </xsl:choose>
      
            <input type="hidden" size="2" maxlength="5" name="PLAZOENTREGA" value="{PedidosProgramados/PEDIDOPROGRAMADO/PLAZOENTREGA}" class="inputOculto"  onFocus="this.blur();">
              <xsl:choose>
                <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
                  <xsl:attribute name="value">
                    <xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/PLAZOENTREGA"/>
                  </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:attribute name="value">3</xsl:attribute>
                </xsl:otherwise>
              </xsl:choose>
            </input>
          
            <input type="hidden" name="FECHANO_LANZAMIENTO" size="14" maxlength="10" onblur="calculaFecha(document.forms['form1'],this,document.forms['form1'].elements['PLAZOENTREGA'].value);"/>
          
        <tr class="sinLinea">
          <td class="labelRight grisMed">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='solicitar_conf_envio']/node()"/>:&nbsp;
          </td>
          <td class="datosLeft">
                  <input class="muypeq" type="checkbox" name="CONFIRMAR" onCLick="SolicitarFecha('FIN',this);">
                    <xsl:choose>
                      <xsl:when test="not(PedidosProgramados/PEDIDOPROGRAMADO/EXISTE) or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
                        <xsl:attribute name="checked">checked</xsl:attribute>
                        <xsl:attribute name="valor">EXISTE or DESDEOFERTA</xsl:attribute>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:choose>
                          <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/CONFIRMAR='S'">
                            <xsl:attribute name="checked">checked</xsl:attribute>
                            <xsl:attribute name="valor">s</xsl:attribute>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                            <xsl:attribute name="valor">n</xsl:attribute>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:otherwise>
                    </xsl:choose>
                  </input>
               <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
               <xsl:value-of select="document($doc)/translation/texts/item[@name='solicitar_conf_cada_pedido_programado']/node()"/>.
          </td>
        </tr>
        <tr class="sinLinea">
          <td class="labelRight grisMed">
          	<xsl:value-of select="document($doc)/translation/texts/item[@name='comentario_anexos_ped_programado']/node()"/>:&nbsp;
          </td>
          <td class="datosLeft">
	                  <textarea name="COMENTARIOS" cols="50" rows="3">
                            <xsl:value-of select="PedidosProgramados/PEDIDOPROGRAMADO/COMENTARIOS"/>
                          </textarea>  <!--<br />--> &nbsp;&nbsp;&nbsp;<xsl:text>&gt;&gt;&nbsp;</xsl:text>           
	                  <!--<xsl:call-template name="botonPersonalizado">
	                    <xsl:with-param name="label">Comentarios</xsl:with-param>
	                    <xsl:with-param name="status">Comentarios</xsl:with-param>
	                    <xsl:with-param name="funcion">ultimosComentarios('COMENTARIOS','form1','MULTIOFERTAS');</xsl:with-param>
	                  </xsl:call-template>-->
                      <a href="javascript:ultimosComentarios('COMENTARIOS','form1','MULTIOFERTAS');">
                      	<xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/>
                      </a>
	             
          </td>
        </tr>
        <tr class="sinLinea">
          <td class="labelRight grisMed">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='programa_visible_proveedor']/node()"/>:&nbsp;
          </td>
          <td class="datosLeft">
          
                  <input class="muypeq" type="checkbox" name="MOSTRARALPROVEEDOR">
                    <xsl:choose>
                      <xsl:when test="not(PedidosProgramados/PEDIDOPROGRAMADO/EXISTE) or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">           
                        <xsl:attribute name="checked">checked</xsl:attribute>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:choose>
                          <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/PEDP_MOSTRARALPROVEEDOR='S'">
                            <xsl:attribute name="checked">checked</xsl:attribute>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:otherwise>
                    </xsl:choose>
                  </input> 
                <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>  
                <xsl:value-of select="document($doc)/translation/texts/item[@name='programa_visible_proveedor_expli']/node()"/>. 
          </td>
        </tr>
        <tr class="sinLinea">
          <td class="labelRight grisMed">
            <xsl:value-of select="document($doc)/translation/texts/item[@name='programa_activo']/node()"/>:&nbsp;
          </td>
          <td class="datosLeft">
           
            	<input class="muypeq" type="checkbox" name="ACTIVO">
            	  <xsl:choose>
                	<xsl:when test="not(PedidosProgramados/PEDIDOPROGRAMADO/EXISTE) or PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
                	  <xsl:attribute name="checked">checked</xsl:attribute>
                	</xsl:when>
                	<xsl:otherwise>
                	  <xsl:choose>
                    	<xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/INACTIVO='S'">
                    	  <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                    	</xsl:when>
                    	<xsl:otherwise>
                    	  <xsl:attribute name="checked">checked</xsl:attribute>
                    	</xsl:otherwise>
                	  </xsl:choose>
                	</xsl:otherwise>
            	  </xsl:choose>
            	</input>
                <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>   
        	   <xsl:value-of select="document($doc)/translation/texts/item[@name='programa_activo_expli']/node()"/>.

      </td>
     </tr>
     <tr class="sinLinea">
        <td colspan="2">&nbsp;<!--<xsl:value-of select="document($doc)/translation/texts/item[@name='consultar_dias_habiles_provee']/node()"/>.  --> </td>
     </tr>       
     <tr class="sinLinea">
       <td>&nbsp;</td><td class="datosLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='los_campos_marcados_con']/node()"/> (<span class="camposObligatorios">*</span>) <xsl:value-of select="document($doc)/translation/texts/item[@name='son_obligatorios']/node()"/>.</td>
     </tr>
	 <!--
     <tr class="sinLinea">
         <td colspan="2">&nbsp;</td>
     </tr>
     <tr class="sinLinea">
         <td>&nbsp;</td>
         <td>
          <xsl:choose>
          <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/DESDEOFERTA">
              	 <div class="boton">
                    <a href="javascript:EliminarPrograma(document.forms['form1'],'http://www.newco.dev.br/Compras/PedidosProgramados/BorrarPedidoProgramado.xsql');">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/>
                    </a>
                 </div>
          </xsl:when>
          <xsl:when test="PedidosProgramados/PEDIDOPROGRAMADO/EXISTE">
                	<div class="boton">
                        <a href="javascript:window.close();">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
                        </a>
              		</div>
                        
                	<div class="boton">
                        <a href="javascript:EliminarPrograma(document.forms['form1'],'http://www.newco.dev.br/Compras/PedidosProgramados/BorrarPedidoProgramado.xsql');">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/>
                        </a>
              		</div>
          </xsl:when>
          <xsl:otherwise>
                  <div class="boton">
                        <a href="javascript:window.close();">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/>
                        </a>
              	  </div>
          </xsl:otherwise>
        </xsl:choose>
        
        <div class="boton" style="margin-left:20px;">
              	<a href="javascript:GuardarCambios(document.forms['form1'],'http://www.newco.dev.br/Compras/PedidosProgramados/MantPedidosProgramadosSave.xsql');" id="aceptarBoton">
                <xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar_minu']/node()"/>
                </a>
        </div>
        </td>
     </tr>
	 -->
     
    </table>
    
    
   
     <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="//LANG"><xsl:value-of select="//LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        
      <!--idioma fin-->
      
         
  </div><!--fin de divLeft-->
  </div>
  </form>

      </xsl:otherwise>
      </xsl:choose>
      </body>
    </html>
  </xsl:template>  
</xsl:stylesheet>
