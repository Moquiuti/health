<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">

<html>
<head>
<title>Informe de evaluación</title>
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
      
      var msgCerrarInforme='¿Finalizar el informe de evaluación?';
      var msgFechaRecepcion='Por favor, introduzca una fecha válida con el formato dd/mm/aaaa en el campo \" Fecha de recepción real \"' ;
      var msgFechaPrevision='Por favor, introduzca una fecha válida con el formato dd/mm/aaaa en el campo \" Prevision cierre \"';
      var msgEvaluacionFuncional='Por favor, introduzca comentarios en el campo \" Evaluación Funcional \"';
      var msgEvaluacionEnvoltorio='Por favor, introduzca comentarios en el campo \" Evaluación de la Presentación \"';
      var msgApto='Por favor, marque el informe como Apto / No apto';   
      var msgSinCriterio='Por favor, marque todos los criterios como Apto / No apto antes de cerrar el Informe'; 
      var msgCantidadUnidadesEnteras='Por favor,introduzca un número correcto en el campo muestras recibidas';
      var msgSinMuestras='Por favor, introduzca la cantidad de muestras a recibidas.';
      
      var msgSinComentariosCriterio='Por favor, introduzca un comentario explicando el motivo del NO APTO para este criterio';
      
      var msgSinEvaluador='Por favor, introduzca el nombre del evaluador.';
      var msgSinCargoEvaluador='Por favor, introduzca el cargo del evaluador.';
      
      

      
       ]]></xsl:text>
        var posicionPagina='#<xsl:value-of select="Mantenimiento/POSICION_PAGINA"/>';
      <xsl:text disable-output-escaping="yes"><![CDATA[
      
      
      ]]></xsl:text>
        <xsl:choose>
         <xsl:when test="Mantenimiento/READ_ONLY='S' or Mantenimiento/INFORME_EVALUACION/STATUS>=50">
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
              if(objFrame!=null){
                if(objFrame.ActualizarDatos){
                  objFrame.ActualizarDatos(objFrame.document.forms[0],'ACTUALIZARACTA');
                }
                else{
                  if(objFrame.recargarPagina){
                    objFrame.recargarPagina();
                  }
                  else{
                    Refresh(objFrame.document);
                  }
                }
                
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
      

      

      function ActualizarDatos(form, accion){   
        
        if(ValidarFormulario(form, accion)){
          form.elements['ACCION'].value=accion;
          
          /*  montamos la cadena de cambios */
          
          
          var cambiosCriterios='';  
          
          for(var n=0;n<form.length;n++){
          
            var idCriterio;
            var comentariosCriterio;
            var aptoCriterio;
          
            if((form.elements[n].name.substring(0,12)=='CHK_CRITERIO') && (obtenerNombre(form.elements[n].name,'_',2,'DESPUES')=='OK')){
              
              idCriterio=obtenerIdCriterio(form.elements[n]);
              
              if(form.elements['CHK_CRITERIO'+idCriterio+'_OK'].checked==true){
                aptoCriterio='S';
              }
              else{
                if(form.elements['CHK_CRITERIO'+idCriterio+'_NOOK'].checked==true){
                  aptoCriterio='N';
                }
                else{
                  aptoCriterio='P';
                }
              }
              
              comentariosCriterio=form.elements['COMENTARIOS_'+idCriterio].value;
              
              cambiosCriterios+=idCriterio+'|'+comentariosCriterio+'|'+aptoCriterio+'#'; 
            }
          }
          
          form.elements['CAMBIOSCRITERIOS'].value=cambiosCriterios;
          
          posicionPagina='zonaBotones';
          form.action+='?POSICION_PAGINA='+posicionPagina;
          SubmitForm(form);
          
        }
        
      }
      
      function ValidarFormulario(form,accion){
        var errores=0;

 
        /* quitamos los espacios sobrantes  */
        
        for(var n=0;n<form.length;n++){
          if(form.elements[n].type=='text'){
            form.elements[n].value=quitarEspacios(form.elements[n].value);
          }
        }
        
        
        
        /* si la accion es cerrar el formulario validamos el responsable*/
        
         if(accion=='CERRARINFORME'){
         
          
          if((!errores) && (form.elements['EVALUADORINFORME'].type=='text')){
            if(form.elements['EVALUADORINFORME'].value==''){
              errores++;
               alert(msgSinEvaluador);
              form.elements['EVALUADORINFORME'].focus();
            } 
          }
          
          if((!errores) && (form.elements['CARGOEVALUADORINFORME'].type=='text')){
            if(form.elements['CARGOEVALUADORINFORME'].value==''){
              errores++;
               alert(msgSinCargoEvaluador);
              form.elements['CARGOEVALUADORINFORME'].focus();
            } 
          }
          
        }
        
        
        
        
       //obligamos a informar las muestras del informe la primera vez que lo abren
       // comun para GUARDAR Y CERRAR
        
       if((!errores) && (form.elements['FECHANO_RECEPCIONMUESTRAS'].type=='text')){
         if((test2(form.elements['FECHANO_RECEPCIONMUESTRAS']))){
           errores++;
           alert(msgFechaRecepcion);
           form.elements['FECHANO_RECEPCIONMUESTRAS'].focus();
         }
       }
       
       if((!errores) && (form.elements['NUMEROMUESTRAS'].type=='text')){
          if((esNulo(form.elements['NUMEROMUESTRAS'].value))){
            alert(msgSinMuestras);
            form.elements['NUMEROMUESTRAS'].focus();
            errores++;
          }
        }
        
        
    
        
        /* comprobamos que todos los criterios estan informados al cerrar*/
        
         if(accion=='CERRARINFORME'){


          
          
          if(!errores){
            for(var n=0;n<form.length && !errores;n++){
              if((form.elements[n].name.substring(0,12)=='CHK_CRITERIO') && (obtenerNombre(form.elements[n].name,'_',2,'DESPUES')=='OK')){
                if(form.elements['CHK_CRITERIO'+obtenerIdCriterio(form.elements[n])+'_OK'].checked==false && form.elements['CHK_CRITERIO'+obtenerIdCriterio(form.elements[n])+'_NOOK'].checked==false){
                  errores++;
                  alert(msgSinCriterio);
                  form.elements['CHK_CRITERIO'+obtenerIdCriterio(form.elements[n])+'_OK'].focus();
                }
                else{
                  // si no esta marcado como no apto y no hay comentarios los solicitamos
                  if(form.elements['CHK_CRITERIO'+obtenerIdCriterio(form.elements[n])+'_NOOK'].checked==true){
                    if(quitarEspacios(form.elements['COMENTARIOS_'+obtenerIdCriterio(form.elements[n])].value)==''){
                      errores++;
                      alert(msgSinComentariosCriterio);
                      form.elements['COMENTARIOS_'+obtenerIdCriterio(form.elements[n])].focus();
                    }
                  } 
                }
              }
            }
          }
        }
        
        
        if(accion=='GUARDARINFORME'){

          /* comprobamos que todos los criterios estan informados */
          
          if(!errores){
            for(var n=0;n<form.length && !errores;n++){
              if((form.elements[n].name.substring(0,12)=='CHK_CRITERIO') && (obtenerNombre(form.elements[n].name,'_',2,'DESPUES')=='OK')){
                  // si esta marcado como no apto y no hay comentarios los solicitamos
                  if(form.elements['CHK_CRITERIO'+obtenerIdCriterio(form.elements[n])+'_NOOK'].checked==true){
                    if(quitarEspaciosYSaltosDeLinea(form.elements['COMENTARIOS_'+obtenerIdCriterio(form.elements[n])].value)==''){
                      errores++;
                      alert(msgSinComentariosCriterio);
                      form.elements['COMENTARIOS_'+obtenerIdCriterio(form.elements[n])].focus();
                    }
                  } 
              }
            }
          }
        }
        
        
        //actualizamos la conclusion global

        // la conclusion 
        if(form.elements['CHK_CONCLUSION_OK'].checked==true){
              form.elements['CHK_CONCLUSION'].value='S';
            }
            else{
              if(form.elements['CHK_CONCLUSION_NOOK'].checked==true){ 
                form.elements['CHK_CONCLUSION'].value='N';
              }
              else{
                form.elements['CHK_CONCLUSION'].value='P';
              }
            }
        
        /* validamos la conclusion global */
        
         if(accion=='CERRARINFORME'){
         

          if(!errores){
          
            if(form.elements['CHK_CONCLUSION'].value=='P'){
              errores++;
              alert(msgApto);
              form.elements['CHK_CONCLUSION_OK'].focus();
            }
          }

        }

        if(!errores){          
          return true;
        }
        else{
          return false;
        } 
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
      
      function CerrarInforme(form,accion){
        if(confirm(msgCerrarInforme)){
          ActualizarDatos(form,accion);
        }
      }
      
      
      /*
         archivamos los datos
         los unico que se actualiza es el estado.
         no hace falta validacion de formulario
      */
      
      function ArchivarInforme(form,accion){
        form.elements['ACCION'].value=accion;
        SubmitForm(form);
      }
      
      function AsignarCriterios(idActa, form, accion){
      
        var cambiosCriterios='';
        
        for(var n=0;n<form.length;n++){
          
          var idCriterio;
          var elininarDelActa;
          
          if(form.elements[n].name.substring(0,7)=='ASIGNAR'){
            
            idCriterio=obtenerId(form.elements[n].name);
            
            if(form.elements[n].checked==true){
              elininarDelActa='S';
            }
            else{
              elininarDelActa='N';
            }
            
            cambiosCriterios+=idActa+'|'+idCriterio+'|'+elininarDelActa+'#';  
          }
        }
        form.elements['CAMBIOSCRITERIOS'].value=cambiosCriterios;
 
        form.elements['ACCION'].value=accion;     
        SubmitForm(form);
      }
      
      function ActualizarCambios(idActa,form,accion){
        if(opcionSeleccionada(form) || !esNulo(document.forms[0].elements['DESCRIPCIONCRITERIO'].value)){
          ActualizarDatos(form,accion);
        }
        else{
          AsignarCriterios(idActa, form,'ASIGNARCRITERIO');
        }  
      }
      
      function obtenerIdCriterio(objChk){
        var id='';
        for(var n=0;n<objChk.name.length;n++){
          if(esEntero(objChk.name.substring(n,n+1))){
            id+=objChk.name.substring(n,n+1);
          }
        }
        return id;
      }
      
      function ValidarNumero(obj,decimales){
          
          if(esEnteroPositivo(obj.value)){
            if(decimales>0){
              if(parseFloat(reemplazaComaPorPunto(obj.value))!=0){
                obj.value=anyadirCerosDecimales(reemplazaPuntoPorComa(Round(reemplazaComaPorPunto(obj.value),decimales)),decimales);
              }
            }
          }
          else{
            alert(msgCantidadUnidadesEnteras);
            obj.focus();
          }
        }
        
        function esEnteroPositivo(valor){

          if(valor!=''){
            valor+='';
            for(var n=0;n<valor.length;n++){
              if(valor.substring(n,n+1)<'0' || valor.substring(n,n+1)>'9')
                return false;	
            }
            if(parseInt(valor)>=0){
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
    
    function situarEnPagina(){
      document.location.href=posicionPagina;
    }
    
    function MostrarSolicitudMuestras(idSolicitud){
      if(idSolicitud!=''){
        
      }
      MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/SolicitudMuestras.xsql?IDSOLICITUD='+idSolicitud+'&READ_ONLY=S','solicitud',70,70,0,0);
      
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
  <xsl:when test="//Status/CERRADO">
    <xsl:apply-templates select="//Status/CERRADO"/> 
  </xsl:when>
  <xsl:when test="//Status/ARCHIVADO">
    <xsl:apply-templates select="//Status/ARCHIVADO"/> 
  </xsl:when>
  <xsl:when test="//Status/GUARDADO">
    <xsl:apply-templates select="//Status/GUARDADO"/> 
  </xsl:when>
  <xsl:otherwise>
  <xsl:attribute name="onLoad">situarEnPagina();</xsl:attribute>
<!--<p align="center" class="tituloPag">Informe de Evaluación</p>-->
<form method="post" action="InformeEvaluacion.xsql">
  <input type="hidden" name="ACCION"/>
  <input type="hidden" name="CHK_CONCLUSION"/>
  <input type="hidden" name="IDINFORME" value="{Mantenimiento/INFORME_EVALUACION/IDINFORME}"/>
  <input type="hidden" name="CAMBIOSCRITERIOS"/>
  <input type="hidden" name="IDRESPONSABLEINFORME" value="{Mantenimiento/INFORME_EVALUACION/IDRESPONSABLEINFORME}"/>
  
  
   <p class="tituloPag" align="center">Informe de evaluación</p>
  <table width="100%" align="center">
    <tr>
      <td>
        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="oscuro">
          <!--<tr class="oscuro"> 
            <td class="oscuro" align="center">
              Informe de Evaluación
            </td>
          </tr>-->
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
          	                <xsl:value-of select="Mantenimiento/INFORME_EVALUACION/NUMEROINFORME"/>
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
          	                <xsl:value-of select="Mantenimiento/INFORME_EVALUACION/FECHAINICIO"/>
          	              </b>
          	            </font>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr>
                  <td> 
                    <table align="center" width="70%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                      <tr>
                        <td align="center" width="100%">
                          <!--<input class="inputOculto" style="text-align:center;" size="70" type="text" name="ETIQUETA" value="El Informe debe ser remitido antes de"/>-->
                          <font color="red">
                            El Informe de evaluación debe ser remitido antes de
                            <xsl:variable name="plazoVevolucion" select="Mantenimiento/INFORME_EVALUACION/PLAZODEVOLUCION"/>
                            <xsl:for-each select="/Mantenimiento/field[@name='PLAZODEVOLUCION']/dropDownList/listElem">
                              <xsl:if test="$plazoVevolucion=ID">
                                <b><xsl:value-of select="listItem"/></b>
                              </xsl:if>
                            </xsl:for-each> 
                            <!-- si se esperan muestras indicamos que es a partir de la rececion -->
                            <xsl:choose>
                              <xsl:when test="Mantenimiento/INFORME_EVALUACION/MUESTRASCRITERIO_PROV='S'">
                                a partir de la recepción de las muestras
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:if test="Mantenimiento/INFORME_EVALUACION/NUMEROMUESTRASPREVISTAS!=''">
                                  a partir de la recepción de las muestras
                                </xsl:if>
                              </xsl:otherwise>
                            </xsl:choose>
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
                            Responsable/Evaluador:
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
                                      <b><xsl:value-of select="Mantenimiento/INFORME_EVALUACION/RESPONSABLEINFORME"/></b><br/>
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
                                      <b><xsl:value-of select="Mantenimiento/INFORME_EVALUACION/CENTRORESPONSABLEINFORME"/></b>
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
                                      Evaluador:<span class="camposObligatorios">*</span>
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
                              <xsl:when test="Mantenimiento/INFORME_EVALUACION/MODIFICAREVALUADOR='S'">
                                
                                          <xsl:choose>
                                            <xsl:when test="Mantenimiento/INFORME_EVALUACION/STATUS>=40 or Mantenimiento/INFORME_EVALUACION/STATUS&lt;=10 or Mantenimiento/READ_ONLY='S' or Mantenimiento/INFORME_EVALUACION/IDRESPONSABLEINFORME!=Mantenimiento/US_ID">
                                              
                                              &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/EVALUADOR"/>
                                              <input name="EVALUADORINFORME" type="hidden" value="{Mantenimiento/INFORME_EVALUACION/EVALUADOR}"/>
                                              
                                            </xsl:when>
                                            <xsl:otherwise>
                                              &nbsp;<input name="EVALUADORINFORME" type="text" maxlength="100" size="50" value="{Mantenimiento/INFORME_EVALUACION/EVALUADOR}"/>
                                            </xsl:otherwise>
                                          </xsl:choose>
                                
                              </xsl:when>
                              <xsl:otherwise>
                              
                                &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/EVALUADOR"/>
                                <input name="EVALUADORINFORME" type="hidden" value="{Mantenimiento/INFORME_EVALUACION/EVALUADOR}"/>
                                
                              </xsl:otherwise>
                            </xsl:choose>
                                      
                                      
                                      
                                      <!--
                                      
                                      <xsl:choose>
                                        <xsl:when test="Mantenimiento/INFORME_EVALUACION/STATUS>=40 or Mantenimiento/READ_ONLY='S'">
                                          <xsl:choose>
                                            <xsl:when test="Mantenimiento/INFORME_EVALUACION/EVALUADOR!=''">
                                              &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/EVALUADOR"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                              &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/RESPONSABLEINFORME"/>
                                            </xsl:otherwise>
                                          </xsl:choose>
                                        </xsl:when>
                                        <xsl:otherwise>
                                          &nbsp;<input name="EVALUADORINFORME" type="text" maxlength="75" size="100" value="{Mantenimiento/INFORME_EVALUACION/EVALUADOR}"/>
                                        </xsl:otherwise>
                                      </xsl:choose> 
                                                   
                                      <xsl:choose>
                                        <xsl:when test="Mantenimiento/INFORME_EVALUACION/EVALUADOR!=''">
                                          
                                         
                                          &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/EVALUADOR"/>
                                          <input name="EVALUADORINFORME" type="hidden" value="{Mantenimiento/INFORME_EVALUACION/EVALUADOR}"/>
                                          
                                           
                                        </xsl:when>
                                        <xsl:otherwise>
                                          &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/RESPONSABLEINFORME"/>
                                          <input name="EVALUADORINFORME" type="hidden" value="{Mantenimiento/INFORME_EVALUACION/RESPONSABLEINFORME}"/>
                                        </xsl:otherwise>
                                      </xsl:choose>
                                      -->
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
                                      Cargo:<span class="camposObligatorios">*</span>
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
                              <xsl:when test="Mantenimiento/INFORME_EVALUACION/MODIFICAREVALUADOR='S'">
                                
                                          <xsl:choose>
                                            <xsl:when test="Mantenimiento/INFORME_EVALUACION/STATUS>=40 or Mantenimiento/INFORME_EVALUACION/STATUS&lt;=10 or Mantenimiento/READ_ONLY='S' or Mantenimiento/INFORME_EVALUACION/IDRESPONSABLEINFORME!=Mantenimiento/US_ID">
                                              
                                              &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/CARGOEVALUADOR"/>
                                              <input name="CARGOEVALUADORINFORME" type="hidden" value="{Mantenimiento/INFORME_EVALUACION/CARGOEVALUADOR}"/>
                                          
                                              
                                            </xsl:when>
                                            <xsl:otherwise>
                                              &nbsp;<input name="CARGOEVALUADORINFORME" type="text" maxlength="100" size="50" value="{Mantenimiento/INFORME_EVALUACION/CARGOEVALUADOR}"/>
                                            </xsl:otherwise>
                                          </xsl:choose>
                                
                              </xsl:when>
                              <xsl:otherwise>
                              
                                &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/CARGOEVALUADOR"/>&nbsp;
                                <input name="CARGOEVALUADORINFORME" type="hidden" value="{Mantenimiento/INFORME_EVALUACION/CARGOEVALUADOR}"/>
                                
                              </xsl:otherwise>
                            </xsl:choose>
                                      
                                      
                                      <!--<xsl:choose>
                                        <xsl:when test="Mantenimiento/INFORME_EVALUACION/STATUS>=40 or Mantenimiento/READ_ONLY='S'">
                                          <xsl:choose>
                                            <xsl:when test="Mantenimiento/INFORME_EVALUACION/CARGOEVALUADOR!=''">
                                              &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/CARGOEVALUADOR"/>&nbsp;
                                            </xsl:when>
                                            <xsl:otherwise>
                                              &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/CARGORESPONSABLEINFORME"/>
                                            </xsl:otherwise>
                                          </xsl:choose> 
                                        </xsl:when>
                                        <xsl:otherwise>
                                          &nbsp;<input name="CARGOEVALUADORINFORME" type="text" maxlength="100" size="50" value="{Mantenimiento/INFORME_EVALUACION/CARGOEVALUADOR}"/>
                                            
                                        </xsl:otherwise>
                                      </xsl:choose>
                                      
                                      <xsl:choose>
                                        <xsl:when test="Mantenimiento/INFORME_EVALUACION/CARGOEVALUADOR!=''">
                                          &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/CARGOEVALUADOR"/>&nbsp;
                                          <input name="CARGOEVALUADORINFORME" type="hidden" value="{Mantenimiento/INFORME_EVALUACION/CARGOEVALUADOR}"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                          &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/CARGORESPONSABLEINFORME"/>
                                          <input name="CARGOEVALUADORINFORME" type="hidden" value="{Mantenimiento/INFORME_EVALUACION/CARGORESPONSABLEINFORME}"/>
                                        </xsl:otherwise>
                                      </xsl:choose>  -->
                                      
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
                              <td align="right" width="170px">
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
                                      <table width="100%" align="center" cellpadding="0" cellspacing="0" border="0">
                                        <tr>
                                          <td align="left" width="150px">
                                            &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/REFERENCIAPRIVADA"/> 
                                          </td>
                                          <td align="left">
                                            <xsl:if test="Mantenimiento/INFORME_EVALUACION/IDSOLICITUD">
                                              <xsl:call-template name="botonPersonalizado">
	                                        <xsl:with-param name="funcion">MostrarSolicitudMuestras('<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/IDSOLICITUD"/>');</xsl:with-param>
	                                        <xsl:with-param name="label">Solicitud de muestras</xsl:with-param>
	                                        <xsl:with-param name="status">Solicitud de muestras detallada</xsl:with-param>
	                                        <xsl:with-param name="ancho">160px</xsl:with-param>
	                                      </xsl:call-template> 
                                            </xsl:if>
                                          </td>
                                        </tr>
                                      </table>
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
                                      &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/NOMBREPRIVADO"/>
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
                                      &nbsp;<xsl:copy-of select="Mantenimiento/INFORME_EVALUACION/DESCRIPCIONPRIVADA"/>
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
                                      &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/UNIDADBASICA"/>
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
                                      Comentarios:
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
                                          <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                              <td align="left" width="100%">
                                                <b><xsl:copy-of select="Mantenimiento/INFORME_EVALUACION/COMENTARIOS_RESP_ACTA_HTML"/></b>
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
                              <td align="right" width="170px">
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
                                      &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/PROV_NOMBRE"/>
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
                                      &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/REFERENCIAPRODUCTO"/>
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
                                      &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/NOMBREPRODUCTO"/>
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
                                        <xsl:when test="Mantenimiento/READ_ONLY='S' or Mantenimiento/INFORME_EVALUACION/STATUS>40">
                                          &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/NUMEROMUESTRAS"/>&nbsp;uds.
    	                                </xsl:when>
    	                                <xsl:otherwise>
    	                                  &nbsp;<input type="text" name="NUMEROMUESTRAS" maxlength="7" size="10" value="{Mantenimiento/INFORME_EVALUACION/NUMEROMUESTRAS}" onBlur="ValidarNumero(this,0);"/>&nbsp;uds.
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
          <tr>
            <td>
            
            <table width="100%" border="0" cellspacing="1" cellpadding="0" class="oscuro" align="center">
                <tr  class="oscuro">
                  <td class="oscuro">
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
                  <td class="claro" width="100%" height="100%">  
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
                            <tr>
                              <td align="right" width="170px">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Fecha de recepción prevista:
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
                              <xsl:when test="Mantenimiento/INFORME_EVALUACION/MUESTRASCRITERIO_PROV='S'">
                                &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/FECHAPREVISTAMUESTRAS"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:choose>
                                  <xsl:when test="Mantenimiento/INFORME_EVALUACION/NUMEROMUESTRASPREVISTAS=''">
                                    &nbsp;---
                                  </xsl:when>
                                  <xsl:otherwise>
                                    &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/FECHAPREVISTAMUESTRAS"/>
                                  </xsl:otherwise>
                                </xsl:choose>
                              </xsl:otherwise>
                            </xsl:choose> 
                            <input type="hidden" name="FECHAPREVISTAMUESTRAS" value="{Mantenimiento/INFORME_EVALUACION/NUMEROMUESTRAS}"/>
                                      
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>
                              <td align="right" width="170px">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Nº de muestras previstas:
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
                                      <input type="hidden" name="NUMEROMUESTRASPREVISTAS" maxlength="7" size="10" value="{Mantenimiento/INFORME_EVALUACION/NUMEROMUESTRASPREVISTAS}"/>
                                      
                            <xsl:choose>
                              <xsl:when test="Mantenimiento/INFORME_EVALUACION/MUESTRASCRITERIO_PROV='S'">
                               &nbsp;Nº de muestras que el proveedor considere oportuno para realizar una evaluación
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:choose>
                                  <xsl:when test="Mantenimiento/INFORME_EVALUACION/NUMEROMUESTRASPREVISTAS=''">
                                    &nbsp;---
                                  </xsl:when>
                                  <xsl:otherwise>
                                    &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/NUMEROMUESTRASPREVISTAS"/>&nbsp;
                                  </xsl:otherwise>
                                </xsl:choose>
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
                                      Fecha de recepción real:<span class="camposObligatorios">*</span>&nbsp;
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
                              <xsl:when test="Mantenimiento/INFORME_EVALUACION/MUESTRASCRITERIO_PROV='S'">
                                
                                <xsl:choose>
                                            <xsl:when test="Mantenimiento/INFORME_EVALUACION/STATUS>=40 or Mantenimiento/INFORME_EVALUACION/STATUS&lt;=10 or Mantenimiento/READ_ONLY='S' or Mantenimiento/INFORME_EVALUACION/IDRESPONSABLEINFORME!=Mantenimiento/US_ID">
                                              &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/FECHARECEPCIONMUESTRAS"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                              &nbsp;<input type="text" name="FECHANO_RECEPCIONMUESTRAS" maxlength="10" size="12" value="{Mantenimiento/INFORME_EVALUACION/FECHARECEPCIONMUESTRAS}" onBlur="validarFecha(this);"/>(dd/mm/yyyy)
                                            </xsl:otherwise>
                                          </xsl:choose>
                                
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:choose>
                                  <xsl:when test="Mantenimiento/INFORME_EVALUACION/NUMEROMUESTRASPREVISTAS=''">
                                    &nbsp;---
                                          &nbsp;<input type="hidden" name="FECHANO_RECEPCIONMUESTRAS" value="{Mantenimiento/INFORME_EVALUACION/FECHARECEPCIONMUESTRAS}"/>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    
                                    <xsl:choose>
                                            <xsl:when test="Mantenimiento/INFORME_EVALUACION/STATUS>=40 or Mantenimiento/INFORME_EVALUACION/STATUS&lt;=10 or Mantenimiento/READ_ONLY='S' or Mantenimiento/INFORME_EVALUACION/IDRESPONSABLEINFORME!=Mantenimiento/US_ID">
                                              &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/FECHARECEPCIONMUESTRAS"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                              &nbsp;<input type="text" name="FECHANO_RECEPCIONMUESTRAS" maxlength="10" size="12" value="{Mantenimiento/INFORME_EVALUACION/FECHARECEPCIONMUESTRAS}" onBlur="validarFecha(this);"/>(dd/mm/yyyy)
                                            </xsl:otherwise>
                                          </xsl:choose>
                                    
                                  </xsl:otherwise>
                                </xsl:choose>
                              </xsl:otherwise>
                            </xsl:choose>
                                       
                                    </td>
                                  </tr>
                                </table>             
                              </td>
                            </tr>
                            <tr>
                              <td align="right" width="170px">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%">
                                  <tr>
                                    <td align="right" width="100%">
                                      Nº de muestras recibidas:<span class="camposObligatorios">*</span>&nbsp;
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
                              <xsl:when test="Mantenimiento/INFORME_EVALUACION/MUESTRASCRITERIO_PROV='S'">
                                
                                <xsl:choose>
                                            <xsl:when test="Mantenimiento/INFORME_EVALUACION/STATUS>=40 or Mantenimiento/INFORME_EVALUACION/STATUS&lt;=10 or Mantenimiento/READ_ONLY='S' or Mantenimiento/INFORME_EVALUACION/IDRESPONSABLEINFORME!=Mantenimiento/US_ID">
                                              &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/NUMEROMUESTRAS"/>&nbsp;
                                              <input type="hidden" name="NUMEROMUESTRAS" value="{Mantenimiento/INFORME_EVALUACION/NUMEROMUESTRAS}"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                              <!--&nbsp;<input type="text" name="NUMEROMUESTRAS" maxlength="7" size="10" value="{Mantenimiento/INFORME_EVALUACION/NUMEROMUESTRAS}" onBlur="ValidarNumero(this,0);"/>&nbsp;uds.-->
                                              &nbsp;<input type="text" name="NUMEROMUESTRAS" maxlength="100" size="20" value="{Mantenimiento/INFORME_EVALUACION/NUMEROMUESTRAS}"/>&nbsp;
                                            </xsl:otherwise>
                                          </xsl:choose>
                                
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:choose>
                                  <xsl:when test="Mantenimiento/INFORME_EVALUACION/NUMEROMUESTRASPREVISTAS=''">
                                    &nbsp;---
                                          <input type="hidden" name="NUMEROMUESTRAS" value="{Mantenimiento/INFORME_EVALUACION/NUMEROMUESTRAS}"/>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    
                                    <xsl:choose>
                                            <xsl:when test="Mantenimiento/INFORME_EVALUACION/STATUS>=40 or Mantenimiento/INFORME_EVALUACION/STATUS&lt;=10 or Mantenimiento/READ_ONLY='S' or Mantenimiento/INFORME_EVALUACION/IDRESPONSABLEINFORME!=Mantenimiento/US_ID">
                                              &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/NUMEROMUESTRAS"/>&nbsp;
                                              <input type="hidden" name="NUMEROMUESTRAS" maxlength="7" size="10" value="{Mantenimiento/INFORME_EVALUACION/NUMEROMUESTRAS}"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                              <!--&nbsp;<input type="text" name="NUMEROMUESTRAS" maxlength="7" size="10" value="{Mantenimiento/INFORME_EVALUACION/NUMEROMUESTRAS}" onBlur="ValidarNumero(this,0);"/>&nbsp;uds.-->
                                              &nbsp;<input type="text" name="NUMEROMUESTRAS" maxlength="100" size="20" value="{Mantenimiento/INFORME_EVALUACION/NUMEROMUESTRAS}"/>&nbsp;
                                            </xsl:otherwise>
                                          </xsl:choose>
                                    
                                  </xsl:otherwise>
                                </xsl:choose>
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
                                      Documentación recibida:
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1px" class="oscuro">
                              </td>
                              <td align="left">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" bgcolor="#FFFFFF">
                                  <tr>
                                    <td width="100px" align="right">
                                       Ficha técnica:
                                    </td>
                                    <td width="50px" align="left">
                                      
                                      
                                      
                                      <xsl:choose>
                              <xsl:when test="Mantenimiento/INFORME_EVALUACION/MUESTRASCRITERIO_PROV='S'">
                                
                                <xsl:choose>
                                            <xsl:when test="Mantenimiento/INFORME_EVALUACION/STATUS>=40 or Mantenimiento/INFORME_EVALUACION/STATUS&lt;=10 or Mantenimiento/READ_ONLY='S' or Mantenimiento/INFORME_EVALUACION/IDRESPONSABLEINFORME!=Mantenimiento/US_ID">
                                              &nbsp;
                                              <xsl:choose>
                                                <xsl:when test="Mantenimiento/INFORME_EVALUACION/FICHATECNICA='S'">
                                                  Si
                                                </xsl:when>
                                                <xsl:otherwise>
                                                  No
                                                </xsl:otherwise>
                                              </xsl:choose>
                                              <input type="hidden" name="CHK_FICHATECNICA" value="{Mantenimiento/INFORME_EVALUACION/FICHATECNICA}"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                              &nbsp;
                                              <input type="checkbox" name="CHK_FICHATECNICA">
                                                <xsl:if test="Mantenimiento/INFORME_EVALUACION/FICHATECNICA='S'">
                                                  <xsl:attribute name="checked">checked</xsl:attribute>
                                                </xsl:if>
                                              </input> 
                                            </xsl:otherwise>
                                          </xsl:choose>
                                
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:choose>
                                  <xsl:when test="Mantenimiento/INFORME_EVALUACION/NUMEROMUESTRASPREVISTAS=''">
                                    &nbsp;---
                                          <input type="hidden" name="CHK_FICHATECNICA" value="{Mantenimiento/INFORME_EVALUACION/FICHATECNICA}"/>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    
                                    <xsl:choose>
                                            <xsl:when test="Mantenimiento/INFORME_EVALUACION/STATUS>=40 or Mantenimiento/INFORME_EVALUACION/STATUS&lt;=10 or Mantenimiento/READ_ONLY='S' or Mantenimiento/INFORME_EVALUACION/IDRESPONSABLEINFORME!=Mantenimiento/US_ID">
                                              &nbsp;
                                              <xsl:choose>
                                                <xsl:when test="Mantenimiento/INFORME_EVALUACION/FICHATECNICA='S'">
                                                  Si
                                                </xsl:when>
                                                <xsl:otherwise>
                                                  No
                                                </xsl:otherwise>
                                              </xsl:choose>
                                              <input type="hidden" name="CHK_FICHATECNICA" value="{Mantenimiento/INFORME_EVALUACION/FICHATECNICA}"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                              &nbsp;
                                              <input type="checkbox" name="CHK_FICHATECNICA">
                                                <xsl:if test="Mantenimiento/INFORME_EVALUACION/FICHATECNICA='S'">
                                                  <xsl:attribute name="checked">checked</xsl:attribute>
                                                </xsl:if>
                                              </input> 
                                            </xsl:otherwise>
                                          </xsl:choose>
                                    
                                  </xsl:otherwise>
                                </xsl:choose>
                              </xsl:otherwise>
                            </xsl:choose>
                                      
                                      
                                      
                                      
                                       
                                    </td>
                                    <td width="100px" align="right">
                                       Certificado CE
                                    </td>
                                    <td width="*" align="left">
                                       
                                       
                                       <xsl:choose>
                              <xsl:when test="Mantenimiento/INFORME_EVALUACION/MUESTRASCRITERIO_PROV='S'">
                                
                                <xsl:choose>
                                            <xsl:when test="Mantenimiento/INFORME_EVALUACION/STATUS>=40  or Mantenimiento/INFORME_EVALUACION/STATUS&lt;=10 or Mantenimiento/READ_ONLY='S' or Mantenimiento/INFORME_EVALUACION/IDRESPONSABLEINFORME!=Mantenimiento/US_ID">
                                              &nbsp;
                                              <xsl:choose>
                                                <xsl:when test="Mantenimiento/INFORME_EVALUACION/CERTIFICADO='S'">
                                                  Si
                                                </xsl:when>
                                                <xsl:otherwise>
                                                  No
                                                </xsl:otherwise>
                                              </xsl:choose>
                                              <input type="hidden" name="CHK_CERTIFICADO" value="{Mantenimiento/INFORME_EVALUACION/CERTIFICADO}"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                              &nbsp;
                                              <input type="checkbox" name="CHK_CERTIFICADO">
                                                <xsl:if test="Mantenimiento/INFORME_EVALUACION/CERTIFICADO='S'">
                                                  <xsl:attribute name="checked">checked</xsl:attribute>
                                                </xsl:if>
                                              </input> 
                                            </xsl:otherwise>
                                          </xsl:choose>
                                
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:choose>
                                  <xsl:when test="Mantenimiento/INFORME_EVALUACION/NUMEROMUESTRASPREVISTAS=''">
                                    &nbsp;---
                                          <input type="hidden" name="CHK_CERTIFICADO" value="{Mantenimiento/INFORME_EVALUACION/CERTIFICADO}"/>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    
                                    <xsl:choose>
                                            <xsl:when test="Mantenimiento/INFORME_EVALUACION/STATUS>=40  or Mantenimiento/INFORME_EVALUACION/STATUS&lt;=10 or Mantenimiento/READ_ONLY='S' or Mantenimiento/INFORME_EVALUACION/IDRESPONSABLEINFORME!=Mantenimiento/US_ID">
                                              &nbsp;
                                              <xsl:choose>
                                                <xsl:when test="Mantenimiento/INFORME_EVALUACION/CERTIFICADO='S'">
                                                  Si
                                                </xsl:when>
                                                <xsl:otherwise>
                                                  No
                                                </xsl:otherwise>
                                              </xsl:choose>
                                              <input type="hidden" name="CHK_CERTIFICADO" value="{Mantenimiento/INFORME_EVALUACION/CERTIFICADO}"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                              &nbsp;
                                              <input type="checkbox" name="CHK_CERTIFICADO">
                                                <xsl:if test="Mantenimiento/INFORME_EVALUACION/CERTIFICADO='S'">
                                                  <xsl:attribute name="checked">checked</xsl:attribute>
                                                </xsl:if>
                                              </input> 
                                            </xsl:otherwise>
                                          </xsl:choose>
                                    
                                  </xsl:otherwise>
                                </xsl:choose>
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
              
              <!--<br/>
                  
                  
                  
                    <table width="100%" border="0">
                    <tr>
                    <td align="center">
                    <table width="100%" border="0" cellspacing="1" cellpadding="3" class="oscuro">
                      <tr class="oscuro"> 
                        <td class="oscuro" colspan="4">
                        <b>Fechas:</b>
                        </td>
                      </tr>
                            <tr class="blanco" align="center"> 
                              <td width="20%" class="claro" align="right">
                                Informe Enviado:
                              </td>
                              <td width="20%" class="blanco" align="left">
                                <xsl:choose>
                                  <xsl:when test="Mantenimiento/INFORME_EVALUACION/FECHAENVIO=''">
                                    &nbsp;Pendiente de envío
                                  </xsl:when>
                                  <xsl:otherwise>
                                    &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/FECHAENVIO"/>
                                  </xsl:otherwise>
                                </xsl:choose>
                              </td>
                              <td  width="20%"  class="claro" align="right">
                                Informe entregado:
                              </td>
                              <td class="blanco" align="left" width="20%">
                                <xsl:choose>
                                  <xsl:when test="Mantenimiento/INFORME_EVALUACION/FECHACIERRE=''">
                                    &nbsp;Pendiente de entrega
                                  </xsl:when>
                                  <xsl:otherwise>
                                    &nbsp;<xsl:value-of select="Mantenimiento/INFORME_EVALUACION/FECHACIERRE"/>
                                  </xsl:otherwise>
                                </xsl:choose>
                              </td>
                            </tr>
                            <tr  class="blanco" align="center"> 
                              <td width="20%" class="claro" align="right">
                                Muestras recibidas:<span class="camposObligatorios">**</span>
                              </td>
                              <td  class="blanco" align="left">
                                <xsl:choose>
                                  <xsl:when test="Mantenimiento/INFORME_EVALUACION/STATUS>=40 or Mantenimiento/READ_ONLY='S'">
                                    <xsl:value-of select="Mantenimiento/INFORME_EVALUACION/FECHARECEPCION"/>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <input type="text" size="12" maxlength="10" name="FECHANO_REC_INF" value="{Mantenimiento/INFORME_EVALUACION/FECHARECEPCION}"/>
                                  </xsl:otherwise>
                                </xsl:choose>
                              </td>
                              <td class="claro" align="right">
                                Previsión cierre:<span class="camposObligatorios">*</span>
                              </td>
                              <td  class="blanco" align="left">
                                <xsl:choose>
                                  <xsl:when test="Mantenimiento/INFORME_EVALUACION/STATUS&gt;=40 or Mantenimiento/READ_ONLY='S'">
                                    <xsl:value-of select="Mantenimiento/INFORME_EVALUACION/FECHAPREVISION"/>
                                    <input type="hidden" name="FECHA_PRE_INF" value="{Mantenimiento/INFORME_EVALUACION/FECHAPREVISION}"/>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:choose>
                                      <xsl:when test="Mantenimiento/INFORME_EVALUACION/STATUS&lt;=10">
                                        <input type="text" size="12" maxlength="10" name="FECHA_PRE_INF" value="{Mantenimiento/INFORME_EVALUACION/FECHAPREVISION}"/>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:value-of select="Mantenimiento/INFORME_EVALUACION/FECHAPREVISION"/>
                                        <input type="hidden" name="FECHA_PRE_INF" value="{Mantenimiento/INFORME_EVALUACION/FECHAPREVISION}"/>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  
                                  </xsl:otherwise>
                                </xsl:choose>
                              </td>
                            </tr>
                    </table>
                    </td>
                    </tr>
                    <tr>
                    <td align="right">
                      formato fechas (dd/mm/aaaa)
                    </td>
                    </tr>
                    </table>-->
                  </td>
                </tr>
                <tr>
                  <td>
                    
                          <table width="100%" border="0" cellspacing="1" cellpadding="0" class="oscuro">
                            <tr  class="oscuro">
                              <td>
                                <table width="100%" cellpadding="1" cellspacing="3" border="0"> 
                                    <tr>
                                      <td align="left">
                                        <b>Evaluación funcional:</b><br/>
                                      </td>
                                    </tr>
                                  </table>  
                              </td>
                            </tr>
                            <tr class="medio">
                              <td class="medio">
                                <table width="100%" cellpadding="1" cellspacing="3" border="0"> 
                                  <tr>
                                    <td align="left" width="196px">
                                      Criterio
                                    </td>
                                    <td align="center" width="101px">
                                      Apto / No Apto 
                                    </td>
                                    <td align="center" width="*">
                                      Comentario
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                          <xsl:choose>
                            <xsl:when test="Mantenimiento/INFORME_EVALUACION/CRITERIOSFUNCIONALES/CRITERIO">
                              <tr>
                                <td class="claro">
                                  <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                    <xsl:for-each select="Mantenimiento/INFORME_EVALUACION/CRITERIOSFUNCIONALES/CRITERIO">
                                      <xsl:choose>
                                        <xsl:when test="//Mantenimiento/INFORME_EVALUACION/STATUS>=40 or //Mantenimiento/INFORME_EVALUACION/STATUS&lt;=10 or //Mantenimiento/READ_ONLY='S'">
                                          <tr>
                                            <td align="left" width="200px">
                                              <xsl:value-of select="DESCRIPCION"/>&nbsp;
                                            </td>
                                            <td class="oscuro" width="1px">
                                            </td>
                                            <td align="center" width="105px">
                                              <xsl:choose>
                                                <xsl:when test="APTO='S'">
                                                  <font color="NAVY" size="1">
                                                    <b>
                                                      APTO
                                                    </b>
                                                  </font>
                                                </xsl:when>
                                                <xsl:when test="APTO='N'">
                                                  <font color="RED" size="1">
                                                    <b>
                                                      NO APTO
                                                    </b>
                                                  </font>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                  <font size="1">
                                                    <b>
                                                      PENDIENTE
                                                    </b>
                                                  </font>
                                                </xsl:otherwise>
                                              </xsl:choose>
                                            </td>
                                            <td class="oscuro" width="1px">
                                            </td>
                                            <td align="center" width="*">
                                              <xsl:copy-of select="COMENTARIOS_HTML"/>&nbsp;
                                            </td>
                                          </tr>
                                        </xsl:when>
                                        <xsl:otherwise>
                                          <tr>
                                            <td align="left" width="200px">
                                              <xsl:value-of select="DESCRIPCION"/><span class="camposObligatorios">*</span>&nbsp;
                                            </td>
                                            <td class="oscuro" width="1px">
                                            </td>
                                            <td align="center" class="claro" width="105px">
                                              <table width="100%" align="center">
                                                <tr>
                                                  <td align="right">
                                                    <input type="checkbox" name="CHK_CRITERIO{IDCRITERIO}_OK"  onClick="validarChecks(document.forms[0], this.name);">
                                                      <xsl:choose>
                                                        <xsl:when test="APTO='S'">
                                                          <xsl:attribute name="checked">checked</xsl:attribute>
                                                        </xsl:when>
                                                      </xsl:choose>
                                                    </input>
                                                  </td>
                                                  <td align="left">
                                                    <input type="checkbox" name="CHK_CRITERIO{IDCRITERIO}_NOOK"  onClick="validarChecks(document.forms[0], this.name);">
                                                      <xsl:choose>
                                                        <xsl:when test="APTO='N'">
                                                          <xsl:attribute name="checked">checked</xsl:attribute>
                                                        </xsl:when>
                                                      </xsl:choose>
                                                    </input>
                                                  </td>
                                                </tr>
                                              </table>
                                            </td>
                                            <td class="oscuro" width="1px">
                                            </td>
                                            <td align="center" class="claro" width="*">
                                              <textarea name="COMENTARIOS_{IDCRITERIO}" cols="30" rows="3">
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
                            </xsl:when>
                            <xsl:otherwise>
                              <tr>
                                <td align="center" class="claro">
                                  <table width="100%" cellpadding="1" cellspacing="3" border="0"> 
                                    <tr>
                                      <td align="center">
                                        Ningún Criterio de Evaluación Funcional
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
                <tr>
                  <td>
                    
                    
                    <table width="100%" border="0" cellspacing="1" cellpadding="0" class="oscuro">
                            <tr  class="oscuro">
                              <td>
                                <table width="100%" cellpadding="1" cellspacing="3" border="0"> 
                                    <tr>
                                      <td align="left">
                                        <b>Evaluación de la Presentación:</b><br/>
                                      </td>
                                    </tr>
                                  </table>  
                              </td>
                            </tr>
                            <tr class="medio">
                              <td class="medio">
                                <table width="100%" cellpadding="1" cellspacing="3" border="0"> 
                                  <tr>
                                    <td align="left" class="medio" width="196px">
                                      Criterio
                                    </td>
                                    <td align="center" class="medio" width="101px">
                                      Apto / No Apto 
                                    </td>
                                    <td align="center" class="medio" width="*">
                                      Comentario
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                          <xsl:choose>
                            <xsl:when test="Mantenimiento/INFORME_EVALUACION/CRITERIOSENVOLTORIO/CRITERIO">
                              <tr>
                                <td>
                                  <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                    <xsl:for-each select="Mantenimiento/INFORME_EVALUACION/CRITERIOSENVOLTORIO/CRITERIO">
                                      <xsl:choose>
                                        <xsl:when test="//Mantenimiento/INFORME_EVALUACION/STATUS>=40 or //Mantenimiento/INFORME_EVALUACION/STATUS&lt;=10 or //Mantenimiento/READ_ONLY='S'">
                                          <tr class="medio">
                                            <td align="left" class="claro" width="200px">
                                              <xsl:value-of select="DESCRIPCION"/>&nbsp;
                                            </td>
                                            <td class="oscuro" width="1px">
                                            </td>
                                            <td align="center" class="claro" width="105px">
                                              <xsl:choose>
                                                <xsl:when test="APTO='S'">
                                                  <font color="NAVY" size="1">
                                                    <b>
                                                      APTO
                                                    </b>
                                                  </font>
                                                </xsl:when>
                                                <xsl:when test="APTO='N'">
                                                  <font color="RED" size="1">
                                                    <b>
                                                      NO APTO
                                                    </b>
                                                  </font>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                  <font size="1">
                                                    <b>
                                                      PENDIENTE
                                                    </b>
                                                  </font>
                                                </xsl:otherwise>
                                              </xsl:choose>
                                            </td>
                                            <td class="oscuro" width="1px">
                                            </td>
                                            <td align="center" class="claro" width="*">
                                              <xsl:copy-of select="COMENTARIOS_HTML"/>&nbsp;
                                            </td>
                                          </tr>
                                        </xsl:when>
                                        <xsl:otherwise>
                                          <tr>
                                            <td align="left" class="claro" width="200px">
                                              <xsl:value-of select="DESCRIPCION"/><span class="camposObligatorios">*</span>&nbsp;
                                            </td>
                                            <td class="oscuro" width="1px">
                                            </td>
                                            <td align="center" class="claro" width="105px">
                                              <table width="100%" align="center">
                                                <tr>
                                                  <td align="right">
                                                    <input type="checkbox" name="CHK_CRITERIO{IDCRITERIO}_OK"  onClick="validarChecks(document.forms[0], this.name);">
                                                      <xsl:choose>
                                                        <xsl:when test="APTO='S'">
                                                          <xsl:attribute name="checked">checked</xsl:attribute>
                                                        </xsl:when>
                                                      </xsl:choose>
                                                    </input>
                                                  </td>
                                                  <td align="left">
                                                    <input type="checkbox" name="CHK_CRITERIO{IDCRITERIO}_NOOK"  onClick="validarChecks(document.forms[0], this.name);">
                                                      <xsl:choose>
                                                        <xsl:when test="APTO='N'">
                                                          <xsl:attribute name="checked">checked</xsl:attribute>
                                                        </xsl:when>
                                                      </xsl:choose>
                                                    </input>
                                                  </td>
                                                </tr>
                                              </table>
                                            </td>
                                            <td class="oscuro" width="1px">
                                            </td>
                                            <td align="center" class="claro" width="*">
                                              <textarea name="COMENTARIOS_{IDCRITERIO}" cols="30" rows="3">
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
                            </xsl:when>
                            <xsl:otherwise>
                              <tr>
                                <td align="center" class="claro">
                                  <table width="100%" cellpadding="1" cellspacing="3" border="0"> 
                                    <tr>
                                      <td align="center">
                                        Ningún Criterio de Evaluación de la Presentación
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
                <tr>
                  <td>
                    <table width="100%" border="0" cellspacing="1" cellpadding="3" class="oscuro">
                      <tr>
                        <td height="20"><b>Conclusión:<span class="camposObligatorios">*</span></b><br/></td>
                      </tr>
                      <tr class="blanco" valign="middle">
                        <td class="blanco" align="center" valign="middle">
                          <br/>
                          <xsl:choose>
                            <xsl:when test="Mantenimiento/INFORME_EVALUACION/STATUS>=40 or //Mantenimiento/INFORME_EVALUACION/STATUS&lt;=10 or Mantenimiento/READ_ONLY='S'">    
                              <xsl:choose>
                                <xsl:when test="Mantenimiento/INFORME_EVALUACION/STATUS>=60">
                                  <font color="DARKRED" size="2">
                                    <b>
                                      ABORTADO
                                    </b>
                                  </font> 
                                </xsl:when>
                                <xsl:otherwise>
                                  <xsl:choose>
                                    <xsl:when test="Mantenimiento/INFORME_EVALUACION/APTO='S'">
                                      <font color="NAVY" size="2">
                                        <b>
                                          APTO
                                        </b>
                                      </font>
                                    </xsl:when>
                                    <xsl:when test="Mantenimiento/INFORME_EVALUACION/APTO='N'">
                                      <font color="RED" size="2">
                                        <b>
                                          NO APTO
                                        </b>
                                      </font>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <font size="2">
                                        <b>
                                          PENDIENTE
                                        </b>
                                     </font>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                </xsl:otherwise>
                              </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                            <br/>
                              <table width="100%" border="0" cellspacing="0" cellpadding="0" valign="middle">
                                <tr align="center">
                                  <td valign="middle">Apto
                                    <input type="checkbox" name="CHK_CONCLUSION_OK"  onClick="validarChecks(document.forms[0], this.name);">
                                      <xsl:if test="Mantenimiento/INFORME_EVALUACION/APTO='S'">
                                        <xsl:attribute name="checked">checked</xsl:attribute>
                                      </xsl:if>
                                    </input>
                                  </td>
                                  <td valign="middle">No Apto
                                    <input type="checkbox" name="CHK_CONCLUSION_NOOK"  onClick="validarChecks(document.forms[0], this.name);">
                                      <xsl:if test="Mantenimiento/INFORME_EVALUACION/APTO='N'">
                                        <xsl:attribute name="checked">checked</xsl:attribute>
                                      </xsl:if>
                                    </input>
                                  </td>
                                </tr>
                              </table>
                              <br/>
                            </xsl:otherwise>
                          </xsl:choose>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <!--
                <tr>
                  <td>
                    <table width="100%" border="0" cellspacing="1" cellpadding="0" class="gris">
                      <tr class="claro"> 
                        <td class="claro" width="15%"><b>Fecha de Cierre:</b></td>
                        <td class="claro">
                          <input type="text" size="12" maxlength="10" name="FECHANOCIERRE"/>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                -->
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
    <!--<tr>
      <td>
        Los campos marcados con (<span class="camposObligatorios">*</span>) son obligatorios antes de iniciar el informe.
      </td>
    </tr>
    <tr>
      <td>
        Los campos marcados con (<span class="camposObligatorios">**</span>) son obligatorios al finalizar el informe.
      </td>
    </tr>-->
  </table>
  <br/>
  <br/>
  <a name="zonaBotones"/>
      <table width="100%">
        <tr align="center">
          <td>
            <xsl:call-template name="boton">
              <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Cancelar']"/>
            </xsl:call-template>
          </td>
          
        <xsl:if test="//READ_ONLY!='S' or //DESDE='ACTA'">
          <xsl:if test="Mantenimiento/INFORME_EVALUACION/IDRESPONSABLEACTA=Mantenimiento/US_ID and Mantenimiento/INFORME_EVALUACION/STATUS=40">
            <td>
            <xsl:call-template name="boton">
              <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Archivar']"/>
            </xsl:call-template>
          </td>
          </xsl:if>
        </xsl:if>
          <td>
            <xsl:call-template name="boton">
              <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Imprimir']"/>
            </xsl:call-template>
          </td>
      <xsl:if test="//READ_ONLY!='S'">
        <xsl:if test="Mantenimiento/INFORME_EVALUACION/STATUS&lt;40 and Mantenimiento/INFORME_EVALUACION/STATUS&gt;10">
          <td>
            <xsl:call-template name="boton">
              <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='Guardar']"/>
            </xsl:call-template>
          </td>
          <td>
            <xsl:call-template name="boton">
              <xsl:with-param name="path" select="Mantenimiento/botones/button[@label='CerrarInforme']"/>
            </xsl:call-template>
          </td>
        </xsl:if>
      </xsl:if>
        </tr>
      </table>
  
</form>
<p>&nbsp; </p>
</xsl:otherwise>
</xsl:choose>
  </body>
  </html>
</xsl:template>


<xsl:template match="Status/CERRADO">


  <p class="tituloPag">
  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CATPRIV-0660' and @lang=$lang]" disable-output-escaping="yes"/>
  </p>
  <hr/>
  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CATPRIV-0670' and @lang=$lang]" disable-output-escaping="yes"/>
  <br/> 
  <br/> 
  <xsl:call-template name="boton">
              <xsl:with-param name="path" select="//Mantenimiento/botones/button[@label='Cerrar']"/>
            </xsl:call-template>
   
</xsl:template> 

<xsl:template match="Status/GUARDADO">


  <p class="tituloPag">
  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CATPRIV-0665' and @lang=$lang]" disable-output-escaping="yes"/>
  </p>
  <hr/>
  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CATPRIV-0670' and @lang=$lang]" disable-output-escaping="yes"/>
  <br/> 
  <br/> 
  <xsl:call-template name="boton">
              <xsl:with-param name="path" select="//Mantenimiento/botones/button[@label='Cerrar']"/>
            </xsl:call-template>
   
</xsl:template> 

<xsl:template match="Status/ARCHIVADO">


  <p class="tituloPag">
  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CATPRIV-0662' and @lang=$lang]" disable-output-escaping="yes"/>
  </p>
  <hr/>
  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CATPRIV-0672' and @lang=$lang]" disable-output-escaping="yes"/>
  <br/> 
  <br/> 
  <xsl:call-template name="boton">
              <xsl:with-param name="path" select="//Mantenimiento/botones/button[@label='Cerrar']"/>
            </xsl:call-template>
   
</xsl:template>  



</xsl:stylesheet>
