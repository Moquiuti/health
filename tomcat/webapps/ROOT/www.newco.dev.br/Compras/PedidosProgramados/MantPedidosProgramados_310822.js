//	JS Ficha de PROGRAMA. Nuevo disenno 2022
//	Ultima revision: ET 31ago22 16:00 MantPedidosProgramados_310822.js


//	PENDIENTE TRADUCIR MENSAJES

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




function EliminarPrograma(form,accion){

    var ventana=document.forms['form1'].elements['VENTANA'].value;

    if(confirm(msgBorrarPrograma)){
      document.location.href=accion+'?PEDP_ID='+idpedido+'&IDOFERTAMODELO='+idofertamodelo+'&VENTANA='+ventana;
    }
  }


function CerrarVentana(){
	if (ventanaNueva=='S')
        window.close();
	else
        document.location.href='about:blank';
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


function ValidarFormulario(form){
	var errores=0;

	 /* quitamos los espacios sobrantes */

	for(var n=0;n<form.length;n++){
	if(form.elements[n].type=='text'){
	  form.elements[n].value=form.elements[n].value.trim();
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
	  if((mensaje=CheckDate(document.forms['form1'].elements['FECHA_INICIO'].value))!=''){
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
		if((mensaje=CheckDate(document.forms['form1'].elements['FECHANO_FIN'].value))!='' && document.forms['form1'].elements['IDFRECUENCIA'].value!=1){
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
		  if((mensaje=CheckDate(document.forms['form1'].elements['FECHANO_FIN'].value))!=''){
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
		if((mensaje=CheckDate(document.forms['form1'].elements['FECHANO_LANZAMIENTO'].value))!=''){
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
		  if((mensaje=CheckDate(document.forms['form1'].elements['FECHANO_LANZAMIENTO'].value))!=''){
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
MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame2022.xsql?EMP_ID='+idProveedor+'&VENTANA=NUEVA','empresa',65,58,0,-50);
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
  MostrarPagPersonalizada('http://www.newco.dev.br/Compras/NuevaMultioferta/UltimosComentarios2022.xsql?NOMBRE_OBJETO='+nombreObjeto+'&NOMBRE_FORM='+nombreForm+'&ACCION='+accion+'&TIPO='+tipoComentario+'&COMENTARIO='+document.forms[nombreForm].elements[nombreObjeto].value.replace(/\n/g,'\\\\n'),'comentarios',90,90,10,10);
}


function copiarComentarios(nombreForm,nombreObjeto,texto){
  if(document.forms[nombreForm].elements[nombreObjeto].value.trim()!=''){
    document.forms[nombreForm].elements[nombreObjeto].value+='\n\n';
  }
  document.forms[nombreForm].elements[nombreObjeto].value+=texto;
}


function recargarPagina(){
	document.location.href='http://www.newco.dev.br/Compras/PedidosProgramados/MantPedidosProgramados2022.xsql?PEDP_ID='+pedp_id+'&LISTAPEDIDOS='+listaPedidos+'&LISTAUSUARIOSCENTRO='+listaUsuariosCentro+'&VENTANA='+ventana+'&IDOFERTAMODELO='+idOfertaModelo;
}
    

function MostrarMultioferta(idMultioferta, esModelo){
	var estadoMultioferta;
	var cadRead_only='';
	var read_only='';

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
      MostrarPag('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame2022.xsql?MO_ID='+idMultioferta,'MultiofertaIncidencia'); 
	}
	else{
	  alert(msgSinPedidoParaMostrar);
	}
}









//	Desde basic_180608.js


function esLaborable(fecha){

	fFecha=new Date(formatoFecha(fecha,'E','I'));

	if(fFecha.getDay()==0 || fFecha.getDay()==6){
	  return 0; 
	}
	else{
	  return 1;
	}
}
  
  
  
function calculaSiguienteDiaLaborable(fFecha){

fFechaTmp=fFecha;

if(fFechaTmp.getDay()==0 || fFechaTmp.getDay()==6){
  if(fFechaTmp.getDay()==0){
    fFechaTmp=sumaDiasAFecha(fFechaTmp,1);
  }
  else{
    if(fFechaTmp.getDay()==6){
      fFechaTmp=sumaDiasAFecha(fFechaTmp,2);
    }
  }
}

return fFechaTmp;
}  

function esFechaIndeterminada(textoFecha){
	if(textoFecha.replace(' ','')==''){
	  return 1; 
	}
	else{
	  return 0;
	}  
}
