<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">

<html>
<head>
<title>Acta de evaluación</title>
  <xsl:text disable-output-escaping="yes"><![CDATA[
    <link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
    <link rel="stylesheet" href="http://www.newco.dev.br/General/EstilosImprimir.css" type="text/css" media="print">
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
    <script language="javascript" src="http://www.newco.dev.br/General/general.js"></script>
    <script language="javascript">
      <!--
      
      var msgExisteResponsable='El responsable de la evaluación que está intentando añadir ya está incluído en el acta.';
      var msgBorrarResponsable='¿Borrar el responsable y su informe asociado?';
      var msgBorrarActa='¿Borrar el Acta?';
      var msgSinResponsableActa='Por favor, seleccione un responsable para el Comité de Evaluación.';
      var msgSinMuestras='Por favor,  Introduzca el número de muestras a Evaluar.';
      //var msgInformesAbiertos='Hay Informes de Evaluación pendientes de evaluar.\nPara cerrar el Acta de Evaluación debe finalizar todos los informes.';
      var msgInformesAbiertos='Hay Informes de evaluación pendientes de evaluar.\nSi finaliza el Acta estos informes serán abortados.\n\n¿Confirma la finaliación del Acta?';
      var msgExistenInformes='El Acta de Evaluación contiene informes. Para eliminarlo debe eliminar primero los informes.';
      var msgOpcionSeleccionada='Por favor, marque el Acta como Apto / No Apto.';
      var msgFinalizarActaEvaluacion='¿Finalizar el Acta de Evaluación?';
      var msgSinEvaluador='Por favor, introduzca el nombre del evaluador del informe.';
      var msgSinCargoEvaluador='Por favor, introduzca el cargo del evaluador del informe.';
      
      var msgCantidadUnidadesEnteras='Por favor, introduzca un número correcto.';
      
      var msgSinMuestrasParaInforme='¿Confirma el envío del informe sin solicitar muestras al proveedor?';
      
      var msgEnviarInforme='¿Enviar el informe de evaluación?';
      
      var posicionPagina='#<xsl:value-of select="Mantenimiento/POSICION_PAGINA"/>';
      
      ]]></xsl:text>
        var posicionPagina='#<xsl:value-of select="Mantenimiento/POSICION_PAGINA"/>';    
        var acta_read_only='<xsl:value-of select="Mantenimiento/READ_ONLY"/>';   
      <xsl:text disable-output-escaping="yes"><![CDATA[
      
      
      function ValidarFormulario(form, accion){
        var errores=0;
 
        /* quitamos los espacios sobrantes  */
        
        for(var n=0;n<form.length;n++){
          if(form.elements[n].type=='text'){
            form.elements[n].value=quitarEspacios(form.elements[n].value);
          }
        }
        
       /* 
        if((!errores) && (esNulo(form.elements['IDRESPONSABLEACTA'].value))){
          alert(msgSinResponsableActa);
          form.elements['IDRESPONSABLEACTA'].focus();
          errores++;
        }
        */
        
        /*
        // no obligamos a introducir las muestras
        
        //if(accion=='CERRARACTA' || accion=='GUARDARACTA' || accion=='ENVIARINFORME'){
        //  if((!errores) && (esNulo(form.elements['NUMEROMUESTRAS'].value))){
        //    alert(msgSinMuestras);
        //    form.elements['NUMEROMUESTRAS'].focus();
        //    errores++;
       //   }
        //}
        */
        
        if(accion=='CERRARACTA' || accion=='GUARDARACTA' || accion=='ENVIARINFORME'){
          //if((!errores)){
            
            //if(document.forms[0].elements['NUMEROMUESTRAS'].value!=''){
              //var muestrasTotales=document.forms[0].elements['NUMEROMUESTRAS'].value;
            //}
            //else{
              //var muestrasTotales=0;
            //}
            //var totalesInformes=calcularMuestrasTotales('NUMEROMUESTRASPREVISTAS_')
            //if(parseFloat(muestrasTotales)<parseFloat(totalesInformes)){
              //if(confirm('El nº de muestras solicitadas ('+muestrasTotales+' uds.)\nes inferior al total de muestras asignadas a los informes ('+totalesInformes+' uds.)\nQuiere asignar el valor de '+totalesInformes+' uds. al nº de muestras solicitadas?')){
                //document.forms[0].elements['NUMEROMUESTRAS'].value=totalesInformes;
              //}
              //else{
                //document.forms[0].elements['NUMEROMUESTRAS'].focus();
                //errores++;
              //}
            //}
         // }
        }

        
        /* en el caso de que cerremos el informe hay que informar los checks APTO / NO APTO */
        
        
        if(!errores){
          if(accion=='CERRARACTA'){
            if(!opcionSeleccionada(form)){
              errores++;
              alert(msgOpcionSeleccionada);
              form.elements['CHK_CONCLUSION_OK'].focus();
            }
          }
        }
  
        
        if(!errores){
        
          /* NO HAY ERRORES INFORMAMOS LAS MUESTRAS, FICHA , CERTIFICADO Y CONCLUSION */
          
            for(var n=0;n<form.length;n++){
              
              if((form.elements[n].type=='checkbox') && (obtenerNombre(form.elements[n].name,'_',2,'DESPUES')=='OK')){
                
                var nombreChk=obtenerNombre(form.elements[n].name,'_',2,'ANTES');

                if(form.elements[n].checked==true){
                  form.elements[nombreChk.substring(0,nombreChk.length-1)].value='S';
                }
                else{
                  if(form.elements[nombreChk+'NOOK'].checked==true){
                    
                    form.elements[nombreChk.substring(0,nombreChk.length-1)].value='N';
                  }
                  else{
                    form.elements[nombreChk.substring(0,nombreChk.length-1)].value='P';
                  }
                }
              }
            } 
            
          return true;
        }
        else{
          return false;
        }
        
      }
      
      
      function opcionSeleccionada(form){
        for(var n=0;n<form.length;n++){
          if(form.elements[n].name.substring(0,15)=='CHK_CONCLUSION_'){
            if(form.elements[n].checked==true)
              return true;
          }
        }
        return false;
      }
      
      function existeResponsable(idResponsable){
        var form=document.forms[0];
        for(var n=0;n<form.length;n++){
          if(form.elements[n].type=='hidden' && form.elements[n].name.substring(0,5)=='RESP_'){
            if(obtenerId(form.elements[n].name)==idResponsable)
              return true;
          }
        }
        return false;
      }
      
      
 
 ]]></xsl:text>
        <xsl:choose>
         <xsl:when test="Mantenimiento/READ_ONLY='S' or Mantenimiento/ACTA_EVALUACION/STATUS>=50">
      <xsl:text disable-output-escaping="yes"><![CDATA[
          
          function CerrarVentana(){
            window.close();
          }
         
         ]]></xsl:text>
        </xsl:when>
        <xsl:otherwise>
      <xsl:text disable-output-escaping="yes"><![CDATA[
          
          function CerrarVentana(){
            if(window.opener && !window.opener.closed){
              var objFrameTop=new Object(); 
              objFrameTop=window.opener.top;
               var FrameOpenerName=window.opener.name;
              var objFrame=new Object();
              objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
              if(objFrame!=null && objFrame.recargarPagina){
                objFrame.recargarPagina('PROPAGAR');
              
              }
              else{
                Refresh(objFrame.document);
              }
            }
            window.close();
          }

        ]]></xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      <xsl:text disable-output-escaping="yes"><![CDATA[

          
          
          //function CerrarVentana(){
            //if(window.opener && !window.opener.closed){
             //// var objFrameTop=new Object();    
              objFrameTop=window.opener.top;
              // var FrameOpenerName=window.opener.name;
              //var objFrame=new Object();
              //objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
              //if(objFrame!=null && objFrame.recargarPagina){
              //  objFrame.recargarPagina('PROPAGAR');
                
              //}
              //else{
             //   Refresh(objFrame.document);
             // }  	
            //}
            //window.close(); 
          //}    

      
      function AnyadirResponsable(form,idResponsable,accion){
        //if(!existeResponsable(idResponsable)){
          form.elements['IDNUEVORESPONSABLEEVALUACION'].value=idResponsable;
          if(ValidarFormulario(form, accion)){
            posicionPagina='responsableEvaluacion';
            ActualizarDatos(form,accion);
          }
       // }
        //else{
         // alert(msgExisteResponsable);
        //}
      }
      
      function BorrarResponsable(form,idInforme,accion){
        if(confirm(msgBorrarResponsable)){
          form.elements['IDINFORME'].value=idInforme;
          if(ValidarFormulario(form, accion)){
            posicionPagina='responsableEvaluacion';
            ActualizarDatos(form,accion);
          }
        }
      }
      
      function EnviarInforme(form,idInforme,numMuestras,accion){
        //if(numMuestras==''){
        //  if(confirm(msgSinMuestrasParaInforme)){
        //    form.elements['IDINFORME'].value=idInforme;
        //    if(ValidarFormulario(form, accion)){
        //      posicionPagina='responsableEvaluacion';
       //       ActualizarDatos(form,accion);
       //     }
       //   }
       // }
       // else{
       //   if(confirm(msgEnviarInforme)){
            form.elements['IDINFORME'].value=idInforme;
            if(ValidarFormulario(form, accion)){
              posicionPagina='responsableEvaluacion';
              ActualizarDatos(form,accion);
            }
          //}
        //}
      }
      
      function BorrarActa(form,accion){
        if(noHayInformes(form)){
          if(confirm(msgBorrarActa)){
            ActualizarDatos(form, accion);
          }
        }
        else{
          alert(msgExistenInformes);
        }
      }
      
      function noHayInformes(form){
        for(var n=0;n<form.length;n++){
          if(form.elements[n].name.substring(0,5)=='RESP_'){
            return false;
          }
        }
        return true;
      }
      
      
      /*
        valido que todos los formulartios esten cerrados
        recibe el id de estado que representa el cierre. Si mas adelante
         este cambiara hay que cambiarlo aqui tambien
      
      */
      
      function todosInformesCerrados(form,idStatusCerrado){
        for(var n=0;n<form.length;n++){
          if(form.elements[n].name.substring(0,7)=='STATUS_'){
            if(form.elements[n].value<idStatusCerrado){
              return false;
            }
          }
        }
        return true;
      }
      
      
      
      function CerrarActa(form,accion){
        if(todosInformesCerrados(form,40)){
          if(confirm(msgFinalizarActaEvaluacion)){
            if(ValidarFormulario(form, accion)){
              ActualizarDatos(form, accion); 
            }
          }
        }
        else{
          if(confirm(msgInformesAbiertos)){
            if(ValidarFormulario(form, accion)){
              ActualizarDatos(form, accion); 
            }
          }
        }  
      }
      
      function GuardarActa(form, accion){
        if(ValidarFormulario(form, accion)){
          posicionPagina='zonaBotones';
          ActualizarDatos(form, accion);
        }
      }
      
      function ActualizarDatos(form, accion){   
        
        form.elements['ACCION'].value=accion;
        
        /* preparamos los anexos */
        
        var anexos='';
        
        for(var n=0;n<form.length;n++){

          if(form.elements[n].name.substring(0,6)=='ANEXO_'){
          
            var idAnexo='';
            var fechaSolicitud='';
            var fechaPrevision='';
            var fechaEntrega='';
            var comentarios='';
            var idFechaPrevision='';
            var recibido='';
            
            
            idAnexo=obtenerId(form.elements[n].name);
            fechaSolicitud=form.elements['FECHANO_SOL_ANX_'+idAnexo].value;
            //fechaPrevision=form.elements['FECHANO_PRE_ANX_'+idAnexo].value;
            //fechaEntrega=form.elements['FECHANO_ENT_ANX_'+idAnexo].value;
            comentarios=form.elements['COMENTARIOS_ANX_'+idAnexo].value;
            //idFechaPrevision=form.elements['DESPLEG_PRE_ANX_'+idAnexo].value;
            //if(form.elements['CHECKBX_ENT_ANX_'+idAnexo].checked==true){
            //  recibido='S';
            //}
            //else{
            //  recibido='N';
            //}
            
            
            anexos=anexos+idAnexo+'|'+fechaSolicitud+'|'+fechaPrevision+'|'+fechaEntrega+'|'+comentarios+'|'+idFechaPrevision+'|'+recibido+'#';
            
            
          }
        }
        
        
        form.elements['ANEXOS'].value=anexos;
        
        /*
        
          preparamos los comentarios del responsable del acta, el evaluador, el cargo del evaluador (para cada informe)
        
        */  
        
        var cambiosInforme='';
        
        //if(accion!='BORRARRESPONSABLE'){
          
          for(var n=0;n<form.length;n++){

            if(form.elements[n].name.substring(0,10)=='IDINFORME_'){
              
          
          
              var idInforme='';
              //var comentarios='';
              var evaluador='';
              var cargoEvaluador='';
              var muestrasInforme='';
              var plazoDevolucion='';
            
            
              idInforme=obtenerId(form.elements[n].name);
              
              if(form.elements['STATUS_'+idInforme].value<=10){
              
                //comentarios=form.elements[n].value;
                evaluador=form.elements['EVALUADORINFORME_'+idInforme].value;
                cargoEvaluador=form.elements['CARGOEVALUADORINFORME_'+idInforme].value;
                muestrasInforme=form.elements['NUMEROMUESTRASPREVISTAS_'+idInforme].value;
                
                
                plazoDevolucion=form.elements['PLAZODEVOLUCION_'+idInforme].value;
            
                if(accion=='ENVIARINFORME'){
                  if(form.elements['IDINFORME'].value==idInforme){
                    
                    //if(evaluador==''){
                      //alert(msgSinEvaluador);
                      //form.elements['EVALUADORINFORME_'+idInforme].focus();
                      //return false;
                    //}
            
                    //if(cargoEvaluador==''){
                      //alert(msgSinCargoEvaluador);
                      //form.elements['CARGOEVALUADORINFORME_'+idInforme].focus();
                      //return false;
                    //}
                    
                    if(form.elements['CHK_MUESTRASCRITERIOPROV'].type=='checkbox'){
                      if(form.elements['CHK_MUESTRASCRITERIOPROV'].checked==false){
                        if(muestrasInforme==0 || muestrasInforme==''){
                          if(!confirm(msgSinMuestrasParaInforme)){
                            return false;
                          }
                        }
                      }
                    }
                    
                    
              
                    //if(muestrasInforme==''){
                    //  alert(msgCantidadUnidadesEnteras);
                    //  form.elements['NUMEROMUESTRASPREVISTAS_'+idInforme].focus();
                    //  return false;
                    //}
                
                  }
                }
              
            
                //comentariosResponsableActa=comentariosResponsableActa+idInforme+'|'+comentarios+'|'+evaluador+'|'+cargoEvaluador+'#';
                cambiosInforme+=idInforme+'|'+evaluador+'|'+cargoEvaluador+'|'+muestrasInforme+'|'+plazoDevolucion+'#';
              }
            }
          }
        //}
        
        //form.elements['CAMBIOS_INFORMES'].value=comentariosResponsableActa;
        form.elements['CAMBIOS_INFORMES'].value=cambiosInforme;
        
        
        // informamos correctamente el check (S,N,P);
        
        
        for(var n=0;n<form.length;n++){
              
              if((form.elements[n].type=='checkbox') && (obtenerNombre(form.elements[n].name,'_',2,'DESPUES')=='OK')){
                
                var nombreChk=obtenerNombre(form.elements[n].name,'_',2,'ANTES');

                if(form.elements[n].checked==true){
                  form.elements[nombreChk.substring(0,nombreChk.length-1)].value='S';
                }
                else{
                  if(form.elements[nombreChk+'NOOK'].checked==true){
                    
                    form.elements[nombreChk.substring(0,nombreChk.length-1)].value='N';
                  }
                  else{
                    form.elements[nombreChk.substring(0,nombreChk.length-1)].value='P';
                  }
                }
              }
            } 
        
          
        	   
	    
        form.action+='?POSICION_PAGINA='+posicionPagina;
        //alert('Actualizando Datos...');
        SubmitForm(form);
      }
      
      function validarChecks(form, objName){
        var opcion=obtenerNombre(objName,'_',2,'DESPUES');
        var nombreChk=obtenerNombre(objName,'_',2,'ANTES');
        
        var opcionContraria;
        
        if(opcion=='OK'){
          opcionContraria='NOOK';
        }
        else{
          opcionContraria='OK';
        };
        
        if(form.elements[objName].checked==true)
          form.elements[nombreChk+opcionContraria].checked=false;
        
      }
      
      function obtenerNombre(nombre, separador, posicion, lado){
        
        var apariciones=0;
        var subCadena='';
        
        for(var n=0;n<nombre.length;n++){
          if(nombre.substring(n,n+1)==separador){
            apariciones++;
          }
          if(apariciones==posicion){
            if(lado=='DESPUES'){
              return subCadena=nombre.substring(n+1,nombre.length);
            }
            else{
              return subCadena=nombre.substring(0,n+1);
            }
          }
        }
        return null;
      }
      
      
      function esEnteroPositivo(valor){

          if(valor!=''){
            valor+='';
            for(var n=0;n<valor.length;n++){
              if(valor.substring(n,n+1)<'0' || valor.substring(n,n+1)>'9')
                return false;	
            }
            if(parseInt(valor)>0){
              return true;
            }
            else{
              return false;
            }
          }
          else{
            return true;
          }
        }
      
      
      function ValidarNumero(obj,decimales,msg,paraQueElemento){
          
          if(esEnteroPositivo(obj.value)){
            if(decimales>0){
              if(parseFloat(reemplazaComaPorPunto(obj.value))!=0){
                obj.value=anyadirCerosDecimales(reemplazaPuntoPorComa(Round(reemplazaComaPorPunto(obj.value),decimales)),decimales);
              }
            }
            if(paraQueElemento=='ACTA'){
              
              if(obj.value!=''){
                var valor=obj.value;
              }
              else{
                var valor=0;
              }
               var totalesInformes=calcularMuestrasTotales('NUMEROMUESTRASPREVISTAS_');
                if(parseFloat(valor)<parseFloat(totalesInformes)){
                  if(confirm('El nº de muestras solicitadas ('+valor+' uds.)\nes inferior al total de muestras asignadas a los informes ('+totalesInformes+' uds.)\nQuiere asignar el valor de '+totalesInformes+' uds. al nº de muestras solicitadas?')){
                    obj.value=totalesInformes;
                  }
                  //else{
                  //  obj.focus();
                  ///}
                }
              
            }
            else{
              if(paraQueElemento=='INFORME'){
                
                if(obj.value!=''){
                  var valor=obj.value;
                }
                else{
                  var valor=0;
                }
 
                if(document.forms[0].elements['NUMEROMUESTRAS'].value!=''){
                  var muestrasTotales=document.forms[0].elements['NUMEROMUESTRAS'].value;
                }
                else{
                  var muestrasTotales=0;
                }
                
                var totalesInformes=calcularMuestrasTotales('NUMEROMUESTRASPREVISTAS_');
                if(parseFloat(muestrasTotales)<parseFloat(totalesInformes)){
                  if(confirm('El nº de muestras solicitadas ('+muestrasTotales+' uds.)\nes inferior al total de muestras asignadas a los informes ('+totalesInformes+' uds.)\nQuiere asignar el valor de '+totalesInformes+' uds. al nº de muestras solicitadas?')){
                    document.forms[0].elements['NUMEROMUESTRAS'].value=totalesInformes;
                  }
                  //else{
                    //document.forms[0].elements['NUMEROMUESTRAS'].focus();
                  //}
                }
              }
            }
          }
          else{
            alert(msg);
            obj.focus();
          }
        }
        
      function ModificarInforme(idInforme,accion,respInforme,respActa,idstatus,idSolicitud){
        posicionPagina='responsableEvaluacion';
        
        ]]></xsl:text>
          var desde='<xsl:value-of select="//DESDE"/>';
        <xsl:text disable-output-escaping="yes"><![CDATA[

        if(acta_read_only=='S'){
          var read_only='S';
        }
        else{
          if(respActa!=respInforme){
            var read_only='S';
          }
          else{
            if(idstatus==15){
              var read_only='S';
            }
            else{
              var read_only='N';
            }
          }
        }
        
        
        if(idstatus>=15 && idstatus<=25 && idstatus!=20){
          MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/SolicitudMuestras.xsql?IDSOLICITUD='+idSolicitud+'&READ_ONLY='+read_only+'&DESDE='+desde,'solicitud',65,65,0,0);
        }
        else{
          MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/InformeEvaluacion.xsql?IDINFORME='+idInforme+'&ACCION='+accion+'&READ_ONLY='+read_only+'&DESDE='+desde,'informe',65,65,0,0);
        }
      }
      
      function calcularMuestrasTotales(objName){
        var total=0;
        for(var n=0;n<document.forms[0].length;n++){
          if(document.forms[0].elements[n].name.substring(0,objName.length)==objName){
            if(esEnteroPositivo(document.forms[0].elements[n].value)&& !esNulo(document.forms[0].elements[n].value)){
              total+=parseFloat(document.forms[0].elements[n].value);
            }
          }
        }
        return total;
      }
      
      function calculaFecha(nom,mas,fechaOrigen){ // nom:nombre del combo; mas:incremento del "delay" cf sabado, domingo... la fecha de origen
    
        if(fechaOrigen!=''){
            
            if(mas==999){
              mas=15;
            }
        
            if(arguments.length==2){
              var hoy=new Date();
            }
            else{
             var fechaOrigenFormatoIngles=obtenerSubCadena(fechaOrigen,2)+'/'+obtenerSubCadena(fechaOrigen,1)+'/'+obtenerSubCadena(fechaOrigen,3);
             var hoy=new Date(fechaOrigenFormatoIngles);
            }

            var Resultado=calcularDiasHabiles(hoy,mas);
        
            
           
            // imprimir datos en los textbox en el formato dd/mm/aaaa....
          
            var elDia=Resultado.getDate();
            var elMes=Number(Resultado.getMonth())+1;
            var elAnyo=Resultado.getFullYear();
            var laFecha=elDia+'/'+elMes+'/'+elAnyo;
          
            document.forms[0].elements[nom].value = laFecha;
        }
        else{
          document.forms[0].elements[nom].value='';
        }    
     
    } 
    
    function inicializarFechas(){
     ]]></xsl:text>
      <xsl:if test="/Mantenimiento/ACTA_EVALUACION/STATUS&lt;40 and Mantenimiento/READ_ONLY!='S'">
        <xsl:for-each select="/Mantenimiento/ACTA_EVALUACION/ANEXOS/ANEXO">
          calculaFecha('FECHANO_SOL_ANX_<xsl:value-of select="ID"/>',0,document.forms[0].elements['FECHANO_SOL_ANX_<xsl:value-of select="ID"/>'].value);
          <!--<xsl:choose>
            <xsl:when test="FECHAPREVISTA=''">
              calculaFecha('FECHANO_PRE_ANX_<xsl:value-of select="ID"/>',<xsl:value-of select="IDFECHAPREVISTA"/>,document.forms[0].elements['FECHANO_SOL_ANX_<xsl:value-of select="ID"/>'].value);
            </xsl:when>
          </xsl:choose>
          //-->
        </xsl:for-each>
      </xsl:if>
     <xsl:text disable-output-escaping="yes"><![CDATA[
    }
    
    function calculaFechaPrevista(nombreObjetoDestino,incremento, fechaOrigen){
      if(fechaOrigen!=''){
       if(incremento!=999){
          calculaFecha(nombreObjetoDestino,incremento, fechaOrigen);
        }
      }
      else{
        document.forms[0].elements[nombreObjetoDestino].value='';
      }
    }
    
    function calculaFechaEntrega(nombreObjetoDestino,fechaActual,objCheck){
      if(objCheck.checked==true){
        calculaFecha(nombreObjetoDestino,0, fechaActual);
      }
      else{
        document.forms[0].elements[nombreObjetoDestino].value='';
      }
    }
    
    function activarCheckRecibido(obj,nombreCheck){
      if(obj.value!=''){
        document.forms[0].elements[nombreCheck].checked=true;
      }
      else{
        document.forms[0].elements[nombreCheck].checked=false;
      }
    }
    
    function anyadirCriteriosActa(idActa){
      posicionPagina='criteriosEvaluacion';
      MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantCriteriosEvaluacionActa.xsql?IDACTA='+idActa+'&ACCION=','criterios',70,75,0,0);
    }
    
    function ModificarCriterio(idActa,idCriterio,accion){
      posicionPagina='criteriosEvaluacion';
      MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantCriteriosEvaluacionActa.xsql?IDACTA='+idActa+'&IDCRITERIO='+idCriterio+'&ACCION='+accion,'criterios',70,75,0,0);
    }
    
    function anyadirCriteriosGenerales(){
      MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantCriteriosEvaluacionGenerales.xsql?ACCION=','criterios',70,75,0,0);
    }
    
    function recargarPagina(){
      alert('recargarPagina');
     ]]></xsl:text>
       var idActa='<xsl:value-of select="Mantenimiento/ACTA_EVALUACION/IDACTA"/>';
       var idProveedorProducto='';
       var accion='<xsl:value-of select="Mantenimiento/ACCION"/>';
     <xsl:text disable-output-escaping="yes"><![CDATA[
      //alert('Recargando Pagina...');
      document.location.href='http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ActaEvaluacion.xsql?IDACTA='+idActa+'&IDPROVEEDORPRODUCTO='+idProveedorProducto+'&ACCION=MODIFICARACTA&POSICION_PAGINA='+posicionPagina;
    }
    
    function situarEnPagina(){
      document.location.href=posicionPagina;
    }
    
    
    
    
    function validarFecha(objFecha){
      
      var error='';        
      
      if(objFecha.name.substr(0,7)=='FECHANO' && objFecha.value!=''){	          
        error=CheckDate(objFecha.value);
      }	  	
      else {
        if (objFecha.name.substr(0,5)=='FECHA' && objFecha.name.substr(0,7)!='FECHANO'){     		    
	  error=CheckDate(objFecha.value);
	}
      }    
      
      if (error!=''){
        alert(error);
	objFecha.focus();
      }
    }
    
    function decideElProveedor(obj){
        if(obj.checked==true){
          document.forms[0].elements['NUMEROMUESTRAS'].value='';
          document.forms[0].elements['NUMEROMUESTRAS'].disabled=true;
        
          for(var n=0;n<document.forms[0].length;n++){
            if(document.forms[0].elements[n].name.substring(0,24)=='NUMEROMUESTRASPREVISTAS_' && document.forms[0].elements[n].type=='text'){
              document.forms[0].elements[n].value='';
              document.forms[0].elements[n].disabled=true;
            }
          }
        }
        else{
          document.forms[0].elements['NUMEROMUESTRAS'].disabled=false;
        
          for(var n=0;n<document.forms[0].length;n++){
            if(document.forms[0].elements[n].name.substring(0,24)=='NUMEROMUESTRASPREVISTAS_' && document.forms[0].elements[n].type=='text'){
              document.forms[0].elements[n].disabled=false;
            }
          }
        }
    }
    
    function iniciarMuestras(valor){
      if(valor=='S'){
          if(document.forms[0].elements['NUMEROMUESTRAS'].type=='text'){
            document.forms[0].elements['NUMEROMUESTRAS'].value='';
            document.forms[0].elements['NUMEROMUESTRAS'].disabled=true;
          }
        
          for(var n=0;n<document.forms[0].length;n++){
            if(document.forms[0].elements[n].name.substring(0,24)=='NUMEROMUESTRASPREVISTAS_' && document.forms[0].elements[n].type=='text'){
              document.forms[0].elements[n].value='';
              document.forms[0].elements[n].disabled=true;
            }
          }
        }
    }
    
      
  
     //-->
    </script>
    ]]></xsl:text>
  </head>

<body bgcolor="#FFFFFF">
  <xsl:choose>
  <xsl:when test="//SESION_CADUCADA">
    <xsl:apply-templates select="//SESION_CADUCADA"/> 
  </xsl:when>
  <xsl:when test="//ROWSET/ROW/Sorry">
    <xsl:apply-templates select="//ROWSET/ROW/Sorry"/> 
  </xsl:when>
  <xsl:when test="//Status/BORRADO">
    <xsl:apply-templates select="//Status/BORRADO"/> 
  </xsl:when>
  <xsl:when test="//Status/CERRADO">
    <xsl:apply-templates select="//Status/CERRADO"/> 
  </xsl:when>
  <xsl:when test="//Status/GUARDADO">
    <xsl:apply-templates select="//Status/GUARDADO"/> 
  </xsl:when>
  <xsl:otherwise>
  <xsl:attribute name="onLoad">situarEnPagina();iniciarMuestras('<xsl:value-of select="Mantenimiento/ACTA_EVALUACION/MUESTRASCRITERIO_PROV"/>');<!--inicializarFechas();--></xsl:attribute>
<!--<p align="center" class="tituloPag">Acta de Evaluación</p>-->
<form method="post" action="ActaEvaluacion.xsql">
  <input type="hidden" name="ACCION" value="MODIFICARACTA"/>
  <input type="hidden" name="IDACTA" value="{Mantenimiento/ACTA_EVALUACION/IDACTA}"/>
  <input type="hidden" name="IDNUEVORESPONSABLEEVALUACION"/>
  <input type="hidden" name="IDINFORME"/>
  <input type="hidden" name="ANEXOS"/>
  <input type="hidden" name="CAMBIOS_INFORMES"/>
  <input type="hidden" name="CHK_CONCLUSION"/>
  <input type="hidden" name="FECHAACTUAL" value="{Mantenimiento/ACTA_EVALUACION/FECHAACTUAL}"/>
  
  
  <p class="tituloPag" align="center">Acta de evaluación</p>
  
  <table width="100%" border="0">
    <tr> 
      <td align="center">
  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="oscuro">
    <!--<tr class="oscuro"> 
      <td class="oscuro" align="center">
        Acta de Evaluación
      </td>
    </tr>-->
    <tr class="blanco"> 
      <td height="18" class="blanco">
        <table width="100%" border="0" cellspacing="0" cellpadding="10" align="center">
          <tr>
            <td> 
              <table width="100%" border="0" cellspacing="1" cellpadding="3" class="oscuro" align="center">
                <tr  class="blanco">
                  <td width="154px" class="claro" align="right">
                    <b>Número de acta:</b>
                  </td>
                  <td width="*"  class="blanco">
                    <font color="NAVY" size="1">
    	              <b><xsl:value-of select="Mantenimiento/ACTA_EVALUACION/NUMEROACTA"/></b>
    	            </font>
                  </td>
                  <td width="154px" align="right" class="claro">
                    <b>Fecha de inicio:</b>
                  </td>
                  <td width="154px"  class="blanco">
                    <font color="NAVY" size="1">
    	              <b><xsl:value-of select="Mantenimiento/ACTA_EVALUACION/FECHAINICIO"/></b>
    	            </font>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td> 
              <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="oscuro">
                <tr class="blanco">
                  <td width="154px" class="claro" align="right"><!--Responsable del comité de Evaluación:-->Responsable del acta:&nbsp;<!--<span class="camposObligatorios">*</span> -->
                  </td>
                  <td width="*" valign="middle" class="blanco">
                    <!--<xsl:choose>
                      <xsl:when test="Mantenimiento/READ_ONLY='S' or Mantenimiento/ACTA_EVALUACION/STATUS>40">-->
                        <xsl:for-each select="Mantenimiento/ACTA_EVALUACION/RESPONSABLESACTA/field[@name='IDRESPONSABLEACTA']/dropDownList/listElem">
                          <xsl:if test="../../@current=ID">
                            <xsl:value-of select="listItem"/>
                             <input type="hidden" name="IDRESPONSABLEACTA" value="{ID}"/>
                          </xsl:if>
                        </xsl:for-each>
                       
    	              <!--</xsl:when>
    	              <xsl:otherwise>
    	                <xsl:call-template name="field_funcion">
    	                  <xsl:with-param name="path" select="Mantenimiento/ACTA_EVALUACION/RESPONSABLESACTA/field[@name='IDRESPONSABLEACTA']"/>
    	                  <xsl:with-param name="IDAct" select="Mantenimiento/ACTA_EVALUACION/RESPONSABLESACTA/field[@name='IDRESPONSABLEACTA']/@current"/>
    	                </xsl:call-template>-->
    	                <!--&nbsp;(<xsl:value-of select="Mantenimiento/ACTA_EVALUACION/CENTRORESPONSABLE"/>)-->
    	              <!--</xsl:otherwise>
    	            </xsl:choose>-->
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
                            Producto:
                          </b>
                          <br/>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr  class="medio">
                  <td colspan="2" class="medio">
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr>
                        <td>
                          Datos privados:
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr align="center" class="claro">
                  <td class="claro" width="100%" height="100%" colspan="2">  
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
                            <tr>
                              <td align="right" width="160px">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Referencia:
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
                                      &nbsp;<xsl:value-of select="Mantenimiento/ACTA_EVALUACION/REFERENCIAPRIVADA"/> 
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
                                      Nombre del producto: 
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
                                      &nbsp;<xsl:value-of select="Mantenimiento/ACTA_EVALUACION/NOMBREPRIVADO"/>
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
                                      Descripción del producto:
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
                                      &nbsp;<xsl:copy-of select="Mantenimiento/ACTA_EVALUACION/DESCRIPCIONPRIVADA"/>
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
                                      Unidad de embalaje:
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
                                      &nbsp;<xsl:value-of select="Mantenimiento/ACTA_EVALUACION/UNIDADBASICA"/>
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
                                      <!--Comentarios para los informes:-->
                                      Comentarios (informe):
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
                                        <xsl:when test="Mantenimiento/READ_ONLY='S' or Mantenimiento/ACTA_EVALUACION/STATUS>40">
                                          
                                          &nbsp;
                                          <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                              <td align="left" width="100%">
                                                <xsl:copy-of select="Mantenimiento/ACTA_EVALUACION/COMENTARIOS_INFORMES_HTML"/>
                                              </td>
                                            </tr>
                                          </table> 
    	                                </xsl:when>
    	                                <xsl:otherwise>
    	                                  &nbsp;<textarea name="COMENTARIOS_INFORMES" cols="50" rows="2">
                                            <xsl:value-of select="Mantenimiento/ACTA_EVALUACION/COMENTARIOS_INFORMES"/>
                                            </textarea>
    	                                </xsl:otherwise>
    	                              </xsl:choose>
                                      
                                      
                                    </td>
                                  </tr>
                                </table>             
                              </td>
                            </tr>
                          </table>
                  </td>
                </tr>
                <tr  class="medio">
                  <td class="medio" colspan="2">
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr>
                        <td>
                          Datos proveedor:
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr class="claro">
                  <td class="claro">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" colspan="2">
                            <tr>
                              <td align="right" width="160px">
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
                                      &nbsp;<xsl:value-of select="Mantenimiento/ACTA_EVALUACION/PROV_NOMBRE"/>
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
                                      Ref. del proveedor:
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
                                      &nbsp;<xsl:value-of select="Mantenimiento/ACTA_EVALUACION/REFERENCIAPRODUCTO"/>
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
                                      Descripción del proveedor:
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
                                      &nbsp;<xsl:value-of select="Mantenimiento/ACTA_EVALUACION/NOMBREPRODUCTO"/>
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
                                      <!--Coment. para el proveedor:-->
                                      Comentarios (proveedor):
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
                                        <xsl:when test="Mantenimiento/READ_ONLY='S' or Mantenimiento/ACTA_EVALUACION/STATUS>40">
                                          
                                          &nbsp;
                                          <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                              <td align="left" width="100%">
                                                <xsl:copy-of select="Mantenimiento/ACTA_EVALUACION/COMENTARIOS_PROV_HTML"/>
                                              </td>
                                            </tr>
                                          </table> 
    	                                </xsl:when>
    	                                <xsl:otherwise>
    	                                  &nbsp;<textarea name="COMENTARIOS_PROV" cols="50" rows="2">
                                            <xsl:value-of select="Mantenimiento/ACTA_EVALUACION/COMENTARIOS_PROV"/>
                                            </textarea>
    	                                </xsl:otherwise>
    	                              </xsl:choose>
                                      
                                      
                                    </td>
                                  </tr>
                                </table>             
                              </td>
                            </tr>
                          <!--  <tr>
                              <td align="right">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Número total de muestras a evaluar:--><!--<span class="camposObligatorios">*</span>  -->
                            <!--   </td>
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
                                        <xsl:when test="Mantenimiento/READ_ONLY='S' or Mantenimiento/ACTA_EVALUACION/STATUS>40">
                                          &nbsp;<xsl:value-of select="Mantenimiento/ACTA_EVALUACION/NUMEROMUESTRAS"/>&nbsp;uds.
    	                                </xsl:when>
    	                                <xsl:otherwise>
    	                                  &nbsp;<input type="text" name="NUMEROMUESTRAS" maxlength="7" size="10" value="{Mantenimiento/ACTA_EVALUACION/NUMEROMUESTRAS}" onBlur="ValidarNumero(this,0);"/>&nbsp;uds.
    	                                </xsl:otherwise>
    	                              </xsl:choose>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>-->
                          </table>
                  </td>
                </tr>
              </table>
        
            </td>
          </tr>
         <!--
          <tr>
          <td>
          
          <table width="100%" border="1" cellspacing="1" cellpadding="0" class="oscuro">
                <tr  class="oscuro">
                  <td class="oscuro" colspan="2">
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr>
                        <td>
                          <b>
                            Documentación/Muestras:
                          </b>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr  class="medio">
                  <td colspan="2" class="medio">
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr>
                        <td>
                          Muestras:
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr align="center" class="claro">
                  <td class="claro" width="30%" height="100%">  
                          <table border="0" cellspacing="0" cellpadding="3" height="100%" width="100%">
                            <tr>
                              <td align="right">
                                Número total de muestras a evaluar:
                              </td>
                            </tr>
                          </table>
                  </td>
                  <td class="blanco" height="100%"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                            <tr>
                              <td align="left">
                                <xsl:choose>
                                  <xsl:when test="Mantenimiento/READ_ONLY='S' or Mantenimiento/ACTA_EVALUACION/STATUS>40">
                                    &nbsp;<xsl:value-of select="Mantenimiento/ACTA_EVALUACION/NUMEROMUESTRAS"/>&nbsp;uds.
    	                          </xsl:when>
    	                          <xsl:otherwise>
    	                            &nbsp;<input type="text" name="NUMEROMUESTRAS" maxlength="7" size="10" value="{Mantenimiento/ACTA_EVALUACION/NUMEROMUESTRAS}" onBlur="ValidarNumero(this,0);"/>&nbsp;uds.
    	                          </xsl:otherwise>
    	                        </xsl:choose>
                              </td>
                            </tr>
                          </table>
                  </td>
                </tr>
                <tr  class="medio">
                  <td colspan="2" class="medio">
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr>
                        <td>
                          Fechas:
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr align="center" class="claro">
                  <td class="claro" width="30%" height="100%">  
                          <table border="0" cellspacing="0" cellpadding="3" height="100%" width="100%">
                            <tr>
                              <td align="right">
                                Fecha de solicitud:
                              </td>
                            </tr>
                            <tr>
                              <td align="right">
                                Fecha de recepción prevista:
                              </td>
                            </tr>
                            <tr>
                              <td align="right">
                                Fecha de recepción:
                              </td>
                            </tr>
                            <tr height="*">
                              <td align="right" height="*">
                                Recibido:
                              </td>
                            </tr>
                          </table>
                  </td>
                  <td class="blanco" height="100%"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                            <tr>
                              <td align="left">
                                &nbsp;<input type="text" name="NUMEROMUESTRAS" maxlength="7" size="10" value="{Mantenimiento/ACTA_EVALUACION/NUMEROMUESTRAS}" onBlur="ValidarNumero(this,0);"/><span class="textoComentario">&nbsp;dd/mm/aaaa</span>
                              </td>
                            </tr>
                            <tr>
                              <td align="left">
                                &nbsp;<input type="text" name="NUMEROMUESTRAS" maxlength="7" size="10" value="{Mantenimiento/ACTA_EVALUACION/NUMEROMUESTRAS}" onBlur="ValidarNumero(this,0);"/><span class="textoComentario">&nbsp;dd/mm/aaaa</span>
                              </td>
                            </tr>
                            <tr>
                              <td align="left">
                                &nbsp;<input type="text" name="NUMEROMUESTRAS" maxlength="7" size="10" value="{Mantenimiento/ACTA_EVALUACION/NUMEROMUESTRAS}" onBlur="ValidarNumero(this,0);"/><span class="textoComentario">&nbsp;dd/mm/aaaa</span>
                              </td>
                            </tr>
                            <tr>
                              <td align="left">
                                &nbsp;<input type="checkbox" name="NUMEROMUESTRAS" maxlength="7" size="10" value="{Mantenimiento/ACTA_EVALUACION/NUMEROMUESTRAS}" onBlur="ValidarNumero(this,0);"/>
                              </td>
                            </tr>
                          </table>
                  </td>
                </tr>
                <tr  class="medio">
                  <td class="medio" colspan="2">
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr>
                        <td>
                          Otros:
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr class="claro">
                  <td class="claro">
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                            <tr>
                              <td align="right">
                                Comentarios:
                              </td>
                            </tr>
                          </table>
                  </td>
                  <td class="blanco"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="3">
                            <tr>
                              <td align="left">
                                &nbsp;<xsl:value-of select="Mantenimiento/ACTA_EVALUACION/PROV_NOMBRE"/>
                              </td>
                            </tr>
                          </table>
                  </td>
                </tr>
              </table>
          
          </td>
          </tr>-->
          
          <tr>
          <td>
          
          
          
          <table width="100%" border="0" cellspacing="1" cellpadding="0" class="oscuro" align="center">
                <tr  class="oscuro">
                  <td class="oscuro" colspan="2">
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr>
                        <td>
                          <b>
                            Muestras y documentación técnica solicitada:
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
                              <td align="right" width="160px">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Nº de muestras solicitadas:
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
                                        <xsl:when test="Mantenimiento/READ_ONLY='S' or Mantenimiento/ACTA_EVALUACION/STATUS>40">
                                          <xsl:choose>
                                            <xsl:when test="Mantenimiento/ACTA_EVALUACION/NUMEROMUESTRAS='' or Mantenimiento/ACTA_EVALUACION/NUMEROMUESTRAS&lt;=0">
                                              <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
                                                <tr>
                                                  <td align="left" width="">
                                                    ---
                                                    <input type="hidden" name="NUMEROMUESTRAS" value="{Mantenimiento/ACTA_EVALUACION/NUMEROMUESTRAS}"/>
                                                  </td>
                                                  <td align="left" width="">
                                                    <input type="hidden" name="CHK_MUESTRASCRITERIOPROV" value="Mantenimiento/ACTA_EVALUACION/MUESTRASCRITERIO_PROV"/>
                                                      <xsl:choose>
                                                        <xsl:when test="Mantenimiento/ACTA_EVALUACION/MUESTRASCRITERIO_PROV='S'">
                                                          &nbsp;&nbsp;<b>Sí</b>, dejar que sea el proveedor quien decida el número.
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                          &nbsp;&nbsp;<b>No</b>, se solicita un número exacto de muestras al proveedor
                                                        </xsl:otherwise>
                                                      </xsl:choose>
                                                    
                                                  </td>
                                                </tr>
                                              </table>
                                            </xsl:when>
                                            <xsl:otherwise>
                                              <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
                                                <tr>
                                                  <td align="left" width="">
                                                    &nbsp;<xsl:value-of select="Mantenimiento/ACTA_EVALUACION/NUMEROMUESTRAS"/>&nbsp; 
                                                    <input type="hidden" name="NUMEROMUESTRAS" value="{Mantenimiento/ACTA_EVALUACION/NUMEROMUESTRAS}"/>
                                                  </td>
                                                  <td align="left" width="">
                                                    <input type="hidden" name="CHK_MUESTRASCRITERIOPROV" value="Mantenimiento/ACTA_EVALUACION/MUESTRASCRITERIO_PROV"/>
                                                      <xsl:choose>
                                                        <xsl:when test="Mantenimiento/ACTA_EVALUACION/MUESTRASCRITERIO_PROV='S'">
                                                          &nbsp;&nbsp;<b>Sí</b>, dejar que sea el proveedor quien decida el número.
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                          &nbsp;&nbsp;<b>No</b>, se solicita un número exacto de muestras al proveedor
                                                        </xsl:otherwise>
                                                      </xsl:choose>
                                                  </td>
                                                </tr>
                                              </table>
                                            </xsl:otherwise>
                                          </xsl:choose>
    	                                </xsl:when>
    	                                <xsl:otherwise>
    	                                  <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
                                            <tr>
                                              <td align="left" width="">
                                                <!--&nbsp;<input type="text" name="NUMEROMUESTRAS" maxlength="7" size="12" value="{Mantenimiento/ACTA_EVALUACION/NUMEROMUESTRAS}" onBlur="ValidarNumero(this,0,msgCantidadUnidadesEnteras,'ACTA');"/>&nbsp;uds.-->
                                                &nbsp;<input type="text" name="NUMEROMUESTRAS" maxlength="100" size="20" value="{Mantenimiento/ACTA_EVALUACION/NUMEROMUESTRAS}"/>&nbsp;
                                              </td>
                                              <td align="left" width="">
                                                <input type="checkbox" name="CHK_MUESTRASCRITERIOPROV" onCLick="decideElProveedor(this);">
                                                  <xsl:choose>
                                                    <xsl:when test="Mantenimiento/ACTA_EVALUACION/MUESTRASCRITERIO_PROV='S'">
                                                      <xsl:attribute name="checked">checked</xsl:attribute>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                      <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                                                    </xsl:otherwise>
                                                  </xsl:choose>
                                                </input>
                                                &nbsp;Dejar que sea el proveedor quien decida el número.
                                              </td>
                                            </tr>
                                          </table>
    	                                </xsl:otherwise>
    	                              </xsl:choose>
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
                                      Fecha de la solicitud: 
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
                                        <xsl:when test="Mantenimiento/READ_ONLY='S' or Mantenimiento/ACTA_EVALUACION/STATUS>40">
                                          
                                          &nbsp;<xsl:value-of select="Mantenimiento/ACTA_EVALUACION/ANEXOS/ANEXO/FECHASOLICITUD"/>
    	                                </xsl:when>
    	                                <xsl:otherwise>
    	                                  <input type="hidden" name="ANEXO_{Mantenimiento/ACTA_EVALUACION/ANEXOS/ANEXO/ID}"/>
    	                                  &nbsp;<input type="text" name="FECHANO_SOL_ANX_{Mantenimiento/ACTA_EVALUACION/ANEXOS/ANEXO/ID}" maxlength="10" size="12" value="{Mantenimiento/ACTA_EVALUACION/ANEXOS/ANEXO/FECHASOLICITUD}" onBlur="validarFecha(this);"/>(dd/mm/yyyy)
    	                                </xsl:otherwise>
    	                              </xsl:choose>
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
                                      Comentarios del acta:
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
                                        <xsl:when test="Mantenimiento/READ_ONLY='S' or Mantenimiento/ACTA_EVALUACION/STATUS>40">
                                          
                                          &nbsp;
                                          <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                              <td align="left" width="100%">
                                                <xsl:copy-of select="Mantenimiento/ACTA_EVALUACION/ANEXOS/ANEXO/COMENTARIOS_HTML"/>
                                              </td>
                                            </tr>
                                          </table> 
    	                                </xsl:when>
    	                                <xsl:otherwise>
    	                                  &nbsp;<textarea name="COMENTARIOS_ANX_{Mantenimiento/ACTA_EVALUACION/ANEXOS/ANEXO/ID}" cols="50" rows="3">
                                            <xsl:value-of select="Mantenimiento/ACTA_EVALUACION/ANEXOS/ANEXO/COMENTARIOS"/>
                                            </textarea>
    	                                </xsl:otherwise>
    	                              </xsl:choose>
                                      
                                      
                                      
                                    </td>
                                  </tr>
                                </table>             
                              </td>
                            </tr>
                          </table>
                  </td>
                </tr>
              </table>
          
          
          <!--<table width="100%" border="0" cellspacing="1" cellpadding="0" class="oscuro" align="center">
                <tr  class="oscuro">
                  <td class="oscuro" colspan="2">
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr>
                        <td>
                          <b>
                            Muestras y documentación técnica solicitada:
                          </b>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>-->
                <!--<tr  class="medio">
                  <td colspan="2" class="medio">
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr>
                        <td>
                          Muestras:
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>-->
                <!--<tr align="center" class="claro">
                  <td class="claro" width="250px" height="100%">  
                          <table border="0" cellspacing="0" cellpadding="3" height="100%" width="100%">
                            <tr>
                              <td align="right">-->
                                <!--Número total de muestras a evaluar:--><!--Nº muestras solicitadas:--><!--<span class="camposObligatorios">*</span>  -->
                              <!--</td>
                            </tr>
                          </table>
                  </td>
                  <td class="blanco" height="100%"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                            <tr>
                              <td align="left">
                                <xsl:choose>
                                  <xsl:when test="Mantenimiento/READ_ONLY='S' or Mantenimiento/ACTA_EVALUACION/STATUS>40">
                                    &nbsp;<xsl:value-of select="Mantenimiento/ACTA_EVALUACION/NUMEROMUESTRAS"/>&nbsp;uds.
    	                          </xsl:when>
    	                          <xsl:otherwise>
    	                            &nbsp;<input type="text" name="NUMEROMUESTRAS" maxlength="7" size="10" value="{Mantenimiento/ACTA_EVALUACION/NUMEROMUESTRAS}" onBlur="ValidarNumero(this,0);"/>&nbsp;uds.
    	                          </xsl:otherwise>
    	                        </xsl:choose>
                              </td>
                            </tr>
                          </table>
                  </td>
                </tr>
                <tr align="center" class="claro">
                  <td class="claro" width="250px" height="100%">  
                          <table border="0" cellspacing="0" cellpadding="3" height="100%" width="100%">
                            <tr>
                              <td align="right">-->
                                <!--Número total de muestras a evaluar:--><!--Fecha de solicitud:--><!--<span class="camposObligatorios">*</span>  -->
                              <!--</td>
                            </tr>
                          </table>
                  </td>
                  <td class="blanco" height="100%"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                            <tr>
                              <td align="left">
                                <xsl:choose>
                                  <xsl:when test="Mantenimiento/READ_ONLY='S' or Mantenimiento/ACTA_EVALUACION/STATUS>40">
                                    &nbsp;<xsl:value-of select="Mantenimiento/ACTA_EVALUACION/NUMEROMUESTRAS"/>
    	                          </xsl:when>
    	                          <xsl:otherwise>
    	                            &nbsp;<input type="text" name="NUMEROMUESTRAS" maxlength="7" size="10" value="{Mantenimiento/ACTA_EVALUACION/NUMEROMUESTRAS}" onBlur="ValidarNumero(this,0);"/>(dd/mm/yyyy)
    	                          </xsl:otherwise>
    	                        </xsl:choose>
                              </td>
                            </tr>
                          </table>
                  </td>
                </tr>-->
                <!--<tr  class="medio">
                  <td colspan="2" class="medio">
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr>
                        <td>
                          Fechas:&nbsp;<span class="textoComentarios">(dd/mm/aaaa)</span>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>-->
                <!--<tr  class="claro">
                  <td colspan="2" class="claro">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td>
                          <table border="0" cellspacing="0" cellpadding="3" height="100%" width="100%" align="center">
                            <tr>
                              <td align="left" width="119px">
                                Solicitud:
                              </td>
                              <td align="left" width="119px">
                                Recepción prevista:
                              </td>
                              <td align="left" width="119px">
                                Recepción:
                              </td>
                              <td align="center" width="*">
                                Recibido:
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>-->
                <!--<tr  class="blanco">
                  <td colspan="2" class="blanco">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td>
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" align="center">
                            <tr>
                              <td align="left" width="119px">
                                &nbsp;<input type="text" name="FECHANO_SOLICITUD" maxlength="7" size="10" value="{Mantenimiento/ACTA_EVALUACION/NUMEROMUESTRAS}" onBlur="ValidarNumero(this,0);"/>
                              </td>
                              <td align="left" width="119px">
                                &nbsp;<input type="text" name="FECHANO_PREVISTA" maxlength="7" size="10" value="{Mantenimiento/ACTA_EVALUACION/NUMEROMUESTRAS}" onBlur="ValidarNumero(this,0);"/>
                              </td>
                              <td align="left" width="119px">
                                &nbsp;<input type="text" name="FECHANO_ENTREGA" maxlength="7" size="10" value="{Mantenimiento/ACTA_EVALUACION/NUMEROMUESTRAS}" onBlur="ValidarNumero(this,0);"/>
                              </td>
                              <td align="center" width="*">
                                &nbsp;<input type="checkbox" name="CHK_RECIBIDO" maxlength="7" size="10" value="{Mantenimiento/ACTA_EVALUACION/NUMEROMUESTRAS}" onBlur="ValidarNumero(this,0);"/>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>-->
                <!--<tr  class="medio">
                  <td class="medio" colspan="2">
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr>
                        <td>
                          Otros:
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>-->
                <!--<tr class="claro">
                  <td class="claro">
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                            <tr>
                              <td align="right">-->
                                <!--Comentarios:-->
                              <!--</td>
                            </tr>
                          </table>
                  </td>
                  <td class="blanco"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="3">
                            <tr>
                              <td align="left">
                                &nbsp;
                                <textarea name="COMENTARIOS_ANX_{ID}" cols="50" rows="3">
                                  <xsl:value-of select="COMENTARIOS"/>
                                </textarea>
                              </td>
                            </tr>
                          </table>
                  </td>
                </tr>
              </table>-->
          
          </td>
          </tr>
         <!-- 
          <tr>
            <td>
           <table width="100%" border="0">
           <tr> 
            <td>
              <table width="100%" border="0" cellspacing="1" cellpadding="3" class="grisclaro">
                <tr class="oscuro"> 
                  <td class="oscuro" colspan="6"><b>Documentación entregada:</b><br/></td>
                </tr>
                      <tr class="claro" align="center"> 
                        <td width="10%" height="18" class="claro">&nbsp; </td>
                        <td width="10%" height="18" class="claro">solicitado</td>
                        <td width="10%" height="18" class="claro">recep. prevista</td>
                        <td width="10%" height="18" class="claro">recepción</td>
                        <td width="10%" height="18" class="claro">recibido</td>
                        <td width="*" height="18" class="claro">Comentarios</td>
                      </tr>
                      <xsl:for-each select="Mantenimiento/ACTA_EVALUACION/ANEXOS/ANEXO">
                        <input type="hidden" name="ANEXO_{ID}"/>
                        
                        <xsl:choose>
                          <xsl:when test="//Mantenimiento/READ_ONLY='S' or //Mantenimiento/ACTA_EVALUACION/STATUS>40">
                             <tr class="blanco"> 
                               <td class="claro" align="right"><xsl:value-of select="TIPO"/>:</td>
                               <td  class="blanco" align="center">
                                 &nbsp;<xsl:value-of select="FECHASOLICITUD"/>
                               </td>
                               <td  class="blanco" align="center">
                                 &nbsp;<xsl:value-of select="FECHAPREVISTA"/>
                               </td>
                               <td  class="blanco" align="center">
                                 &nbsp;<xsl:value-of select="FECHAENTREGA"/>
                               </td>
                               <td  class="blanco" align="center">
                                   <xsl:choose>
                                     <xsl:when test="RECIBIDO='S'">
                                       Si
                                     </xsl:when>
                                     <xsl:otherwise>
                                       No
                                     </xsl:otherwise>
                                   </xsl:choose>
                               </td>  
                               <td  class="blanco" align="center">
                                 &nbsp;<xsl:copy-of select="COMENTARIOS_HTML"/>
                               </td>
                             </tr> 
    	                  </xsl:when>
    	                  <xsl:otherwise>
    	                     <tr class="blanco"> 
                               <td class="claro" align="right"><xsl:value-of select="TIPO"/>:</td>
                               <td  class="blanco" align="center">
                                 <input type="text" size="12" maxlength="10" name="FECHANO_SOL_ANX_{ID}" value="{FECHASOLICITUD}">
                                   <xsl:attribute name="onChange">calculaFechaPrevista('FECHANO_PRE_ANX_<xsl:value-of select="ID"/>',document.forms[0].elements['DESPLEG_PRE_ANX_<xsl:value-of select="ID"/>'].value,this.value);</xsl:attribute>
                                 </input>
                               </td>
                               <td  class="blanco" align="center">
                                 <table width="100%">
                                   <tr align="center">
                                     <td>
                                       <input type="text"  size="12" maxlength="10" name="FECHANO_PRE_ANX_{ID}" value="{FECHAPREVISTA}"/>
                                     </td>
                                     <td>
                                       <xsl:call-template name="COMBO_PREVISION">
                                         <xsl:with-param name="nombre">DESPLEG_PRE_ANX_<xsl:value-of select="ID"/></xsl:with-param>
                                         <xsl:with-param name="IDAct"><xsl:value-of select="IDFECHAPREVISTA"/></xsl:with-param>
                                         <xsl:with-param name="onChange">calculaFecha('FECHANO_PRE_ANX_<xsl:value-of select="ID"/>',this.value,document.forms[0].elements['FECHANO_SOL_ANX_<xsl:value-of select="ID"/>'].value);</xsl:with-param>
                                       </xsl:call-template>
                                     </td>
                                   </tr>
                                 </table>
                               </td>
                               <td  class="blanco" align="center">
                                 <input type="text"  size="12" maxlength="10" name="FECHANO_ENT_ANX_{ID}" value="{FECHAENTREGA}" onBlur="activarCheckRecibido(this,'CHECKBX_ENT_ANX_{ID}')"/>
                               </td>
                               <td  class="blanco" align="center">
                                 <input type="checkbox" name="CHECKBX_ENT_ANX_{ID}" value="{CHECK_RECIBIDO}" onclick="calculaFechaEntrega('FECHANO_ENT_ANX_{ID}',document.forms[0].elements['FECHAACTUAL'].value,this);">
                                   <xsl:choose>
                                     <xsl:when test="RECIBIDO='S'">
                                       <xsl:attribute name="checked">checked</xsl:attribute>
                                     </xsl:when>
                                     <xsl:otherwise>
                                       <xsl:attribute name="unchecked">unchecked</xsl:attribute>
                                     </xsl:otherwise>
                                   </xsl:choose>
                                 </input>
                               </td>                          
                               <td  class="blanco" align="center">
                                 <textarea name="COMENTARIOS_ANX_{ID}" cols="50" rows="1">
                                   <xsl:value-of select="COMENTARIOS"/>
                                 </textarea>
                               </td>
                             </tr>        
    	                  </xsl:otherwise>
    	                </xsl:choose>
                      </xsl:for-each>
              </table>
              </td>
          </tr>
          <tr>
            <td align="right">
               formato fechas (dd/mm/aaaa)
              </td>
             </tr>
          </table>
            </td>
          </tr>-->
          <tr>
          <td>
            <a name="criteriosEvaluacion"/>
             <table width="100%" border="0" cellspacing="1" cellpadding="0" class="oscuro" align="center">
                <tr class="grisClaro"> 
                  <td class="grisClaro">
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr>
                        <td>                          
                          <b>Criterios de evaluación:</b><br/><br/>
                        </td>
                        <xsl:choose>
                          <xsl:when test="Mantenimiento/READ_ONLY='S' or Mantenimiento/ACTA_EVALUACION/STATUS>40 or not(Mantenimiento/ACTA_EVALUACION/EDICIONCRITERIOS)">
                            <td>
                              &nbsp;
                            </td>
    	                  </xsl:when>
    	                  <xsl:otherwise>
    	                    <!--<td width="1%">              
                              <xsl:call-template name="botonPersonalizado">
	                        <xsl:with-param name="funcion">anyadirCriteriosGenerales();</xsl:with-param>
	                        <xsl:with-param name="label">Mantenimiento de Criterios Generales</xsl:with-param>
	                        <xsl:with-param name="status">Mantenimiento de Criterios de Evaluación</xsl:with-param>
	                        <xsl:with-param name="ancho">220px</xsl:with-param>
	                      </xsl:call-template> 
                            </td>-->
                            <td width="1%">              
                              <xsl:call-template name="botonPersonalizado">
	                        <xsl:with-param name="funcion">anyadirCriteriosActa('<xsl:value-of select="Mantenimiento/ACTA_EVALUACION/IDACTA"/>');</xsl:with-param>
	                        <xsl:with-param name="label">Añadir/Quitar criterios</xsl:with-param>
	                        <xsl:with-param name="status">Permite Añadir/Quitar criterios a este Acta</xsl:with-param>
	                        <xsl:with-param name="ancho">150px</xsl:with-param>
	                      </xsl:call-template> 
                            </td>
    	                  </xsl:otherwise>
    	                </xsl:choose>
                      </tr>
                    </table>
                  </td>
                </tr>
                <!--<tr class="oscuro"> 
                  <td> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr>
                        <td>
                          Criterios Evaluación Funcional
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>-->
                <tr class="claro"> 
                  <td class="claro"> 
                    <table width="100%" border="0" cellspacing="1" cellpadding="3">
                      <xsl:choose>
                        <xsl:when test="Mantenimiento/ACTA_EVALUACION/CRITERIOSFUNCIONALES/CRITERIO">
                          <xsl:for-each select="Mantenimiento/ACTA_EVALUACION/CRITERIOSFUNCIONALES/CRITERIO">
                            <tr> 
                              <td align="left"> 
                                <xsl:choose>
                                  <xsl:when test="//Mantenimiento/READ_ONLY='S' or //Mantenimiento/ACTA_EVALUACION/STATUS>40 or not(//Mantenimiento/ACTA_EVALUACION/EDICIONCRITERIOS)">
                                    &nbsp;<xsl:value-of select="DESCRIPCION"/> 
    	                          </xsl:when>
    	                          <xsl:otherwise>
    	                            &nbsp;
                                    <a href="javascript:ModificarCriterio('{//Mantenimiento/ACTA_EVALUACION/IDACTA}','{IDCRITERIO}','MODIFICARCRITERIO');">
                                      <xsl:value-of select="DESCRIPCION"/>
                                    </a>
    	                          </xsl:otherwise>
    	                        </xsl:choose>
                              </td>
                            </tr>
                          </xsl:for-each>
                        </xsl:when>
                        <!--<xsl:otherwise>
                          <tr> 
                            <td align="center"> 
                              Ningún Criterio de Evaluación Funcional
                            </td>
                          </tr>
                        </xsl:otherwise>-->
                      </xsl:choose>
                 <!--   </table>
                  </td>
                </tr>-->
                <!--<tr class="oscuro"> 
                  <td class="oscuro"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr>
                        <td>
                          Criterios Evaluación de la Presentación
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>-->
                <!--<tr class="claro"> 
                  <td class="claro"> 
                    <table width="100%" border="0" cellspacing="1" cellpadding="3">-->
                      <xsl:choose>
                        <xsl:when test="Mantenimiento/ACTA_EVALUACION/CRITERIOSENVOLTORIO/CRITERIO">
                          <xsl:for-each select="Mantenimiento/ACTA_EVALUACION/CRITERIOSENVOLTORIO/CRITERIO">
                            <tr> 
                              <td align="left"> 
                                <xsl:choose>
                                  <xsl:when test="//Mantenimiento/READ_ONLY='S' or //Mantenimiento/ACTA_EVALUACION/STATUS>40 or not(//Mantenimiento/ACTA_EVALUACION/EDICIONCRITERIOS)">
                                    &nbsp;<xsl:value-of select="DESCRIPCION"/> 
    	                          </xsl:when>
    	                          <xsl:otherwise>
    	                            &nbsp;
                                    <a href="javascript:ModificarCriterio('{//Mantenimiento/ACTA_EVALUACION/IDACTA}','{IDCRITERIO}','MODIFICARCRITERIO');">
                                      <xsl:value-of select="DESCRIPCION"/>
                                    </a>
    	                          </xsl:otherwise>
    	                        </xsl:choose>
                              </td>
                            </tr>
                          </xsl:for-each>
                        </xsl:when>
                        <!--<xsl:otherwise>
                          <tr> 
                            <td align="center"> 
                              Ningún Criterio de Evaluación de la Presentación
                            </td>
                          </tr>
                        </xsl:otherwise>-->
                      </xsl:choose>
                      <xsl:if test="not(Mantenimiento/ACTA_EVALUACION/CRITERIOSENVOLTORIO/CRITERIO) and not (Mantenimiento/ACTA_EVALUACION/CRITERIOSFUNCIONALES/CRITERIO)">
                        <tr> 
                          <td align="center"> 
                            No hay criterios de evaluación
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
              <a name="responsableEvaluacion"/>
              <table width="100%" border="0" cellspacing="1" cellpadding="0" class="oscuro" align="center">
                <tr class="grisClaro"> 
                  <td class="grisClaro">
                    <table width="100%" border="0" cellpadding="0" cellspacing="3">
                      <tr>
                        <td>
                          <b>Informes de evaluación:</b><br/><br/>
                        </td>
                        <!-- mostramos el boton de anyadir responsable-->
                        <xsl:choose>
                          <xsl:when test="Mantenimiento/READ_ONLY='S' or Mantenimiento/ACTA_EVALUACION/STATUS>40">
                            <td>
                              &nbsp;
                            </td>
                            <td>
                              &nbsp;
                            </td>
    	                  </xsl:when>
    	                  <xsl:otherwise>
    	                    <td align="right">
                              <xsl:call-template name="field_funcion">
    	                        <xsl:with-param name="path" select="Mantenimiento/ACTA_EVALUACION/RESPONSABLESEVALUACION/field[@name='IDRESPONSABLEEVALUACION']"/>
    	                      </xsl:call-template>
                            </td>
                            <td width="1%">
                              <xsl:call-template name="boton">
                                <xsl:with-param name="path" select="//Mantenimiento/botones/button[@label='AnyadirResponsable']"></xsl:with-param>  
                              </xsl:call-template>
                            </td>
    	                  </xsl:otherwise>
    	                </xsl:choose>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr class="grisClaro"> 
                  <td> 
                    <table width="100%" border="0" cellspacing="1" cellpadding="1" class="oscuro">
                      <tr class="oscuro" align="center"> 
                        <!-- cabeceras -->
                        <xsl:choose>
                          <xsl:when test="//Mantenimiento/READ_ONLY='S' or //Mantenimiento/ACTA_EVALUACION/STATUS>10">
                            <td width="25%"  class="oscuro" colspan="2"> Responsable/Evaluador</td>
    	                  </xsl:when>
    	                  <xsl:otherwise>
    	                    <td width="25%"  class="oscuro" colspan="2"> Responsable / Evaluador</td>
    	                  </xsl:otherwise>
    	                </xsl:choose>
                        <td width="15%" class="oscuro"> Cargo</td>
                        <td width="13%" class="oscuro">Centro</td>
                        <td width="11%" class="oscuro">Muestras / Devolución</td>
                        <td width="15%" class="oscuro">Apto / no Apto</td>
                        <td width="*" class="oscuro">Estado</td>
                      </tr>
                  <xsl:choose>
                    <xsl:when test="//INFORMES/INFORME">
                      <xsl:for-each select="//INFORMES/INFORME">
                        <!-- primera linea -->
                        <tr align="center">
                          <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2=0">blanco</xsl:when><xsl:otherwise>claro</xsl:otherwise></xsl:choose></xsl:attribute>
                            <!-- mostramos el boton de eliminar responsable -->
                            <xsl:if test="not(//Mantenimiento/READ_ONLY='S') and not(IDSTATUS>10)">
                              <td width="1%" align="left" rowspan="2">
                                <xsl:call-template name="botonPersonalizado">
	                          <xsl:with-param name="funcion">BorrarResponsable(document.forms[0],'<xsl:value-of select="IDINFORME"/>','BORRARRESPONSABLE');</xsl:with-param>
	                          <xsl:with-param name="label">X</xsl:with-param>
	                          <xsl:with-param name="fontColor">red</xsl:with-param>
	                          <xsl:with-param name="status">Eliminar Responsable</xsl:with-param>
	                          <xsl:with-param name="ancho">18px</xsl:with-param>
	                        </xsl:call-template>
	                      </td>
    	                    </xsl:if>
    	                    <input type="hidden" name="RESP_{IDRESPONSABLE}" value="{IDRESPONSABLE}"/>
	                    <input type="hidden" name="STATUS_{IDINFORME}" value="{IDSTATUS}"/>
                          <td>
                            <xsl:attribute name="colspan">
                              <xsl:choose>
                                <xsl:when test="not(//Mantenimiento/READ_ONLY='S') and not(IDSTATUS>10)">
                                  1
                                </xsl:when>
                                <xsl:otherwise>
                                  2
                                </xsl:otherwise>
                              </xsl:choose>
                            </xsl:attribute>
                            <!-- el responsable -->
                            <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2=0">blanco</xsl:when><xsl:otherwise>claro</xsl:otherwise></xsl:choose></xsl:attribute>
                            <table width="100%" border="0" cellspacing="0" cellpadding="3">
                              <tr align="left"> 
                                <td width="35px" align="right">
                                  Resp:
                                </td>
                                <td width="*">
                                  <input type="hidden" name="IDINFORME_{IDINFORME}"/>
                                  <a href="javascript:ModificarInforme('{IDINFORME}','MODIFICARINFORME','{IDRESPONSABLE}',document.forms[0].elements['IDRESPONSABLEACTA'].value,'{IDSTATUS}','{IDSOLICITUD}');">
                                    &nbsp;<xsl:value-of select="NOMBRERESPONSABLE"/>
                                  </a>
                                </td>
                              </tr>
                            </table>
                          </td>
                          <td  align="center">
                            <!-- cargo del responsable -->
                            <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2=0">blanco</xsl:when><xsl:otherwise>claro</xsl:otherwise></xsl:choose></xsl:attribute>
                            <table width="100%" border="0" cellspacing="0" cellpadding="3">
                              <tr  align="center"> 
                                <td width="100%">
                                  <xsl:value-of select="CARGORESPONSABLE"/>
                                </td>
                              </tr>
                            </table>
                          </td>
                          <td rowspan="2">
                            <!-- centro, tanto del responsable como del evaluador -->
                            <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2=0">blanco</xsl:when><xsl:otherwise>claro</xsl:otherwise></xsl:choose></xsl:attribute>
                            <table width="100%" border="0" cellspacing="0" cellpadding="3">
                              <tr align="center"> 
                                <td width="100%">
                                  <xsl:value-of select="NOMBRECENTRO"/>
                                </td>
                              </tr>
                            </table>
                          </td>
                          <td>
                            <table width="100%" border="0" cellspacing="0" cellpadding="3">
                              <tr align="center"> 
                                <td width="50%">
                                  <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2=0">blanco</xsl:when><xsl:otherwise>claro</xsl:otherwise></xsl:choose></xsl:attribute>
                                  <xsl:choose>
                                  <xsl:when test="IDSTATUS&gt;10 or //Mantenimiento/READ_ONLY='S'">
                                    
                                    <xsl:choose>
                                      <xsl:when test="MUESTRASCRITERIO_PROV='S'">
                                        decisión del proveedor 
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:choose>
                                          <xsl:when test="NUMEROMUESTRASPREVISTAS='' or Mantenimiento/ACTA_EVALUACION/NUMEROMUESTRASPREVISTAS&lt;=0">
                                            no solicitadas
                                          </xsl:when>
                                          <xsl:otherwise>
                                            <xsl:value-of select="NUMEROMUESTRASPREVISTAS"/>&nbsp; 
                                          </xsl:otherwise>
                                        </xsl:choose>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  <input name="NUMEROMUESTRASPREVISTAS_{IDINFORME}" type="hidden" value="{NUMEROMUESTRASPREVISTAS}"/>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <!--<input name="NUMEROMUESTRASPREVISTAS_{IDINFORME}" type="text" maxlength="10" size="5" value="{NUMEROMUESTRASPREVISTAS}"  onBlur="ValidarNumero(this,0,msgCantidadUnidadesEnteras,'INFORME');"/>&nbsp;uds.-->
                                    <input name="NUMEROMUESTRASPREVISTAS_{IDINFORME}" type="text" maxlength="10" size="15" value="{NUMEROMUESTRASPREVISTAS}"/>&nbsp;
                                    
                                  </xsl:otherwise>
                                </xsl:choose>
                                  
                                </td>
                              </tr>
                            </table>
                            <!-- muestras -->
                            <!--
                            <xsl:choose>
                              <xsl:when test="NUMEROMUESTRAS=''">
                                Sin asignar
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:value-of select="NUMEROMUESTRAS"/>
                              </xsl:otherwise>
                            </xsl:choose>-->
                              
                          </td>
                          <td rowspan="2">
                            <!-- estado evaluacion -->
                            <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2=0">blanco</xsl:when><xsl:otherwise>claro</xsl:otherwise></xsl:choose></xsl:attribute>
                            <table width="100%" border="0" cellspacing="0" cellpadding="3">
                              <tr align="center"> 
                                <td width="100%">
                                  <xsl:choose>
                                    <xsl:when test="IDSTATUS&gt;=40 and IDSTATUS&lt;60">
                                      <xsl:choose>
                                        <xsl:when test="APTO='S'">
                                          <font color="NAVY">
                                            <b>APTO</b>
                                          </font>
                                        </xsl:when>
                                        <xsl:when test="APTO='N'">
                                          <font color="RED">
                                            <b>NO APTO</b>
                                          </font>
                                        </xsl:when>
                                        <xsl:otherwise>
                                          <xsl:value-of select="APTO"/>
                                        </xsl:otherwise>
                                      </xsl:choose>
                                    </xsl:when>
                                    <xsl:when test="IDSTATUS&gt;=60">
                                          <font color="darkred">
                                            <b>ABORTADO</b>
                                          </font>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      Pendiente
                                    </xsl:otherwise>
                                  </xsl:choose>
                                </td>
                              </tr>
                            </table>
                          </td>
                          <td width="10%" align="center" rowspan="2">
                          <!-- boton enviar -->
                          <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2=0">blanco</xsl:when><xsl:otherwise>claro</xsl:otherwise></xsl:choose></xsl:attribute>
                            <table width="100%" border="0" cellspacing="0" cellpadding="3">
                              <tr align="center"> 
                                <td width="100%">
                                  <xsl:choose>
                                    <xsl:when test="IDSTATUS=10 and //Mantenimiento/READ_ONLY!='S'">
                                      <xsl:call-template name="botonPersonalizado">
	                                <xsl:with-param name="funcion">EnviarInforme(document.forms[0],'<xsl:value-of select="IDINFORME"/>',document.forms[0].elements['NUMEROMUESTRASPREVISTAS_<xsl:value-of select="IDINFORME"/>'].value,'ENVIARINFORME');</xsl:with-param>
	                                <xsl:with-param name="label">Enviar</xsl:with-param>
	                                <xsl:with-param name="ancho">50px</xsl:with-param>
	                                <xsl:with-param name="status">Enviar Informe</xsl:with-param>
	                                <xsl:with-param name="foregroundBoton">medio</xsl:with-param>
	                              </xsl:call-template>
	                            </xsl:when>
	                            <xsl:otherwise>
	                              <a href="javascript:ModificarInforme('{IDINFORME}','MODIFICARINFORME','{IDRESPONSABLE}',document.forms[0].elements['IDRESPONSABLEACTA'].value,'{IDSTATUS}','{IDSOLICITUD}');">
                                      <xsl:value-of select="NOMBRESTATUS"/>
                                      </a>
	                            </xsl:otherwise>
	                          </xsl:choose>
                                </td>
                              </tr>
                            </table>
	                  </td>
                        </tr>
                        <!-- segunda linea -->
                        <tr align="center">
                          <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2=0">blanco</xsl:when><xsl:otherwise>claro</xsl:otherwise></xsl:choose></xsl:attribute>
                          <td>
                            <xsl:attribute name="colspan">
                              <xsl:choose>
                                <xsl:when test="not(//Mantenimiento/READ_ONLY='S') and not(IDSTATUS>10)">
                                  1
                                </xsl:when>
                                <xsl:otherwise>
                                  2
                                </xsl:otherwise>
                              </xsl:choose>
                            </xsl:attribute>
                            <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2=0">blanco</xsl:when><xsl:otherwise>claro</xsl:otherwise></xsl:choose></xsl:attribute>
                            <table width="100%" border="0" cellspacing="0" cellpadding="3">
                              <tr align="left"> 
                                <td width="35px" align="right">
                                  Eval:<!--<span class="camposObligatorios">*</span>-->
                                </td>
                                <td width="*">
                                  <xsl:choose>
                                    <xsl:when test="IDSTATUS&gt;10 or //Mantenimiento/READ_ONLY='S'">
                                      <input name="EVALUADORINFORME_{IDINFORME}" type="hidden" value="{EVALUADOR}"/>
                                      &nbsp;<xsl:value-of select="EVALUADOR"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      &nbsp;<input name="EVALUADORINFORME_{IDINFORME}" type="text" maxlength="75" size="20" value="{EVALUADOR}"/>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                </td>
                              </tr>
                            </table>
                          </td>
                          <td align="center">
                            <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2=0">blanco</xsl:when><xsl:otherwise>claro</xsl:otherwise></xsl:choose></xsl:attribute>
                            <table width="100%" border="0" cellspacing="0" cellpadding="3">
                              <tr align="left"> 
                                <td width="100%" align="center">
                                  <xsl:choose>
                                    <xsl:when test="IDSTATUS&gt;10 or //Mantenimiento/READ_ONLY='S'">
                                      <input name="CARGOEVALUADORINFORME_{IDINFORME}" type="hidden"  value="{CARGOEVALUADOR}"/>
                                      <xsl:value-of select="CARGOEVALUADOR"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <input name="CARGOEVALUADORINFORME_{IDINFORME}" type="text" maxlength="100" size="15" value="{CARGOEVALUADOR}"/>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                </td>
                              </tr>
                            </table>
                          </td>
                          <td align="left">
                            <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2=0">blanco</xsl:when><xsl:otherwise>claro</xsl:otherwise></xsl:choose></xsl:attribute>
                            <table width="100%" border="0" cellspacing="0" cellpadding="3">
                              <tr align="center"> 
                                <td width="100%">
                                  <xsl:choose>
                                    <xsl:when test="IDSTATUS&gt;10 or //Mantenimiento/READ_ONLY='S'">
                                      <xsl:variable name="plazoVevolucion" select="PLAZODEVOLUCION"/>
                                      <xsl:for-each select="/Mantenimiento/field[@name='PLAZODEVOLUCION']/dropDownList/listElem">
                                        <xsl:if test="$plazoVevolucion=ID">
                                          <xsl:value-of select="listItem"/>
                                          <input name="PLAZODEVOLUCION_{IDINFORME}" type="hidden" value="{ID}"/>
                                        </xsl:if>
                                      </xsl:for-each>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:call-template name="PLAZODEVOLUCION">
                                         <xsl:with-param name="nombre">PLAZODEVOLUCION_<xsl:value-of select="IDINFORME"/></xsl:with-param>
                                         <xsl:with-param name="IDAct"><xsl:value-of select="PLAZODEVOLUCION"/></xsl:with-param>
                                       </xsl:call-template>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                </td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                      </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                      <tr class="claro" align="right">
                          <td class="claro" colspan="7" align="center">
                            Ningún Responsable
                          </td>
                        </tr>
                    </xsl:otherwise>
                  </xsl:choose> 
                    </table>
                  </td>
                </tr>
              </table>
              <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
                <tr>
                  <td align="right">
                    (<font color="navy">*</font>) plazo de devolución del informe a la CdC a partir de la recepción de las muestras
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td>
              <table width="100%" border="0" cellspacing="1" cellpadding="3" class="oscuro" align="center">
                <tr class="oscuro">
                  <td  class="oscuro" height="20" colspan="2">
                    <b>Conclusión:</b>
                  </td>
                </tr>
                <tr class="blanco">
                  <td height="20" width="160px" align="right" class="claro">
                    <b>Fecha de cierre:</b>
                  </td>
                  <td height="20" class="blanco">
                    <xsl:choose>
                      <xsl:when test="Mantenimiento/ACTA_EVALUACION/FECHACIERRE=''">
                        &nbsp;Pendiente
                      </xsl:when>
                      <xsl:otherwise>
                        <font size="1" color="NAVY">
                          <b>&nbsp;<xsl:value-of select="Mantenimiento/ACTA_EVALUACION/FECHACIERRE"/></b>
                        </font>
                        
                      </xsl:otherwise>
                    </xsl:choose>
                    <!--<input type="text"  size="12" maxlength="10" name="FECHANOCIERRE" value="{Mantenimiento/ACTA_EVALUACION/FECHACIERRE}"/>-->
                  </td>
                </tr>
                <tr class="blanco">
                  <td colspan="2">
                    <table width="70%" border="0" cellspacing="1" cellpadding="3" align="center">
                      <tr align="center">
                        <xsl:choose>
                          <xsl:when test="//Mantenimiento/READ_ONLY='S' or //Mantenimiento/ACTA_EVALUACION/STATUS>40">
                            <td valign="middle">
                              <br/>
                              <xsl:choose>
                                <xsl:when test="Mantenimiento/ACTA_EVALUACION/APTO='S'">
                                  <font size="2" color="NAVY">
                                    <b>APTO</b>
                                  </font>
                                </xsl:when>
                                <xsl:when test="Mantenimiento/ACTA_EVALUACION/APTO='N'">
                                  <font size="2" color="RED">
                                    <b>NO APTO</b>
                                  </font>
                                </xsl:when>
                                <xsl:otherwise>
                                  <font size="2">
                                    <b>PENDIENTE</b>
                                  </font>
                                </xsl:otherwise>
                              </xsl:choose>
                              <br/><br/>
                            </td> 
    	                  </xsl:when>
    	                  <xsl:otherwise> 
    	                    <td valign="middle">Apto
                              <input type="checkbox" name="CHK_CONCLUSION_OK"  onClick="validarChecks(document.forms[0], this.name);">
                                <xsl:if test="Mantenimiento/ACTA_EVALUACION/APTO='S'">
                                  <xsl:attribute name="checked">checked</xsl:attribute>
                                </xsl:if>
                              </input>
                            </td>
                            <td valign="middle">No Apto
                              <input type="checkbox" name="CHK_CONCLUSION_NOOK"  onClick="validarChecks(document.forms[0], this.name);">
                                <xsl:if test="Mantenimiento/ACTA_EVALUACION/APTO='N'">
                                  <xsl:attribute name="checked">checked</xsl:attribute>
                                </xsl:if>
                              </input>
                            </td>
    	                  </xsl:otherwise>
    	                </xsl:choose>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr class="blanco">
                  <td align="right" class="claro">
                    Comentarios:&nbsp;
                  </td>
                  <td height="20" align="left" class="blanco">
                    <xsl:choose>
                      <xsl:when test="Mantenimiento/READ_ONLY='S' or Mantenimiento/ACTA_EVALUACION/STATUS>40">
                        <xsl:copy-of select="Mantenimiento/ACTA_EVALUACION/COMENTARIOS_HTML"/>
    	              </xsl:when>
    	              <xsl:otherwise>
    	                &nbsp;
    	                <textarea name="COMENTARIOS" cols="50" rows="3">
                          <xsl:value-of select="Mantenimiento/ACTA_EVALUACION/COMENTARIOS"/>
                        </textarea>
    	              </xsl:otherwise>
    	            </xsl:choose>
                  </td>
                </tr>
             </table>
            </td>
          </tr>
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
  <a name="zonaBotones"/>
  <br/>
  <br/>
      <table width="100%">
        <tr align="center"> 
          <xsl:choose>
            <xsl:when test="//Mantenimiento/READ_ONLY='S' or //Mantenimiento/ACTA_EVALUACION/STATUS>40">
              <td>
                <xsl:call-template name="boton">
                  <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Cancelar']"/>
                </xsl:call-template>
              </td>
              <td>
                <xsl:call-template name="boton">
                  <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Imprimir']"/>
                </xsl:call-template>
              </td>
    	    </xsl:when>
    	    <xsl:otherwise> 
    	      <td>
                <xsl:call-template name="boton">
                  <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Cancelar']"/>
                </xsl:call-template>
              </td>
              <xsl:if test="Mantenimiento/ACTA_EVALUACION/BORRAR_ACTA_ACTIVO='S'">
                <td>
                  <xsl:call-template name="boton">
                    <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Borrar']"/>
                  </xsl:call-template>
                </td>
              </xsl:if>
              <td>
                <xsl:call-template name="boton">
                  <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Guardar']"/>
                </xsl:call-template>
              </td>
              <td>
                <xsl:call-template name="boton">
                  <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Imprimir']"/>
                </xsl:call-template>
              </td>
              <td>
                <xsl:call-template name="boton">
                  <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='CerrarActa']"/>
                </xsl:call-template>
              </td> 
    	    </xsl:otherwise>
    	  </xsl:choose>
        </tr>
      </table>
  
</form>
<p>&nbsp; </p>
</xsl:otherwise>
</xsl:choose>
  </body>
  </html>
</xsl:template>


<xsl:template match="Status/BORRADO">


  <p class="tituloPag">
  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CATPRIV-0600' and @lang=$lang]" disable-output-escaping="yes"/>
  </p>
  <hr/>
  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CATPRIV-0610' and @lang=$lang]" disable-output-escaping="yes"/>
  <br/> 
  <br/> 
  <xsl:call-template name="boton">
              <xsl:with-param name="path" select="//Mantenimiento/botones/button[@label='Cerrar']"/>
            </xsl:call-template>
   
</xsl:template> 

<xsl:template match="Status/CERRADO">


  <p class="tituloPag">
  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CATPRIV-0611' and @lang=$lang]" disable-output-escaping="yes"/>
  </p>
  <hr/>
  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CATPRIV-0612' and @lang=$lang]" disable-output-escaping="yes"/>
  <br/> 
  <br/> 
  <xsl:call-template name="boton">
              <xsl:with-param name="path" select="//Mantenimiento/botones/button[@label='Cerrar']"/>
            </xsl:call-template>
   
</xsl:template>

<xsl:template match="Status/GUARDADO">


  <p class="tituloPag">
  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CATPRIV-0613' and @lang=$lang]" disable-output-escaping="yes"/>
  </p>
  <hr/>
  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CATPRIV-0612' and @lang=$lang]" disable-output-escaping="yes"/>
  <br/> 
  <br/> 
  <xsl:call-template name="boton">
              <xsl:with-param name="path" select="//Mantenimiento/botones/button[@label='Cerrar']"/>
            </xsl:call-template>
   
</xsl:template>  

<xsl:template name="COMBO_PREVISION">
      <xsl:param name="nombre"/>
      <xsl:param name="IDAct"/>
      <xsl:param name="onChange"/>
      <xsl:call-template name="desplegable">
    	<xsl:with-param name="path" select="/Mantenimiento/field[@name='COMBO_PREVISION']"/>
    	<xsl:with-param name="nombre"><xsl:value-of select="$nombre"/></xsl:with-param>
    	<xsl:with-param name="defecto"><xsl:value-of select="$IDAct"/></xsl:with-param>
    	<xsl:with-param name="onChange"><xsl:value-of select="$onChange"/></xsl:with-param>
    </xsl:call-template>
</xsl:template>

<xsl:template name="PLAZODEVOLUCION">
      <xsl:param name="nombre"/>
      <xsl:param name="IDAct"/>
      <xsl:param name="onChange"/>
      
      <xsl:call-template name="desplegable">
    	<xsl:with-param name="path" select="/Mantenimiento/field[@name='PLAZODEVOLUCION']"/>
    	<xsl:with-param name="nombre"><xsl:value-of select="$nombre"/></xsl:with-param>
    	<xsl:with-param name="defecto"><xsl:value-of select="$IDAct"/></xsl:with-param>
    	<xsl:with-param name="onChange"><xsl:value-of select="$onChange"/></xsl:with-param>
    </xsl:call-template>
</xsl:template>


</xsl:stylesheet>
