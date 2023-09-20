//	Funciones JS para MANTENIMIENTO COSTE DE TRASNPORTE
//	Ultima revisión ET 9may22 11:00 CosteTransportePorCliente2022_090522.js

CosteTransportePorCliente2022_090522.js

function CambiarCentro(idCliente,idCentro,accion){
     //alert('cliente '+idCliente);
     document.forms[0].elements['ACCION'].value=accion; 
     document.forms[0].elements['NUEVO_CLIENTE'].value=idCliente;
     document.forms[0].elements['NUEVO_CENTRO'].value=idCentro;

     SubmitForm(document.forms[0]);
}

function ValidarNumero(obj,decimales){

    if(checkNumber(obj.value,obj)){
      if(parseFloat(reemplazaComaPorPunto(obj.value))!=0){
        obj.value=anyadirCerosDecimales(reemplazaPuntoPorComa(Round(reemplazaComaPorPunto(obj.value),decimales)),decimales);
      }
      //alert('obj '+obj.value);
    return true;
    }
    return false;
}


function CerrarVentana(){
   window.close();
   Refresh(top.opener.document);
}


function BorrarCosteTrasporte(idCliente,idCentro,accion,desdeDonde)
{
     var msgBorrarCosteTrasporte;

     if(accion=='BORRARCLIENTE'){
       msgBorrarCosteTrasporte=document.forms['MensajeJS'].elements['BORRAR_COSTE_TRANSPORTE_EMPRESA'].value;
     }
     else{
       if(accion=='BORRARCENTRO'){
         msgBorrarCosteTrasporte=document.forms['MensajeJS'].elements['BORRAR_COSTE_TRANSPORTE_CENTRO'].value;
       }
     }
     if(confirm(msgBorrarCosteTrasporte)){
       document.forms[0].elements['ACCION'].value=accion;    
       document.forms[0].elements['NUEVO_CLIENTE'].value=idCliente;
       document.forms[0].elements['NUEVO_CENTRO'].value=idCentro;
       document.forms[0].elements['DESDE'].value=desdeDonde;
       document.forms[0].elements['EMP_COSTETRANSPORTE'].value=reemplazaComaPorPunto(document.forms[0].elements['EMP_COSTETRANSPORTE'].value);

       SubmitForm(document.forms[0]);
     }
}

function ModificarCosteTransporte(idCliente,idCentro,accion)
{
     //	9may22 alert(accion);
     document.forms[0].elements['ACCION'].value=accion; 
     document.forms[0].elements['NUEVO_CLIENTE'].value=idCliente;
     document.forms[0].elements['NUEVO_CENTRO'].value=idCentro;
     document.forms[0].elements['EMP_COSTETRANSPORTE'].value=reemplazaComaPorPunto(document.forms[0].elements['EMP_COSTETRANSPORTE'].value);

     SubmitForm(document.forms[0]);
}

function NuevoCosteTrasportePorCliente(form)
{

      var costeTrasporte= form.elements['EMP_COSTETRANSPORTE_ACTIVO'].value;
      var importeCosteTrasporte=form.elements['EMP_COSTETRANSPORTE_IMPORTE'].value;
      var descripcionCosteTrasporte=form.elements['EMP_COSTETRANSPORTE_DETALLE'].value;


     var opciones='?IDPROVEEDOR='+ form.elements['IDPROVEEDOR'].value 
                  +'&EMP_COSTETRANSPORTE_ACTIVO='   + costeTrasporte 
                  +'&EMP_COSTETRANSPORTE_IMPORTE='  + importeCosteTrasporte 
                  +'&EMP_COSTETRANSPORTE_DETALLE='  + descripcionCosteTrasporte;




     var opciones='?IDPROVEEDOR='  + form.elements['IDPROVEEDOR'].value 
                  +'&EMP_COSTETRANSPORTE_ACTIVO='	+ form.elements['EMP_COSTETRANSPORTE_ACTIVO'].value 
                  +'&EMP_COSTETRANSPORTE_IMPORTE='	+ form.elements['EMP_COSTETRANSPORTE_IMPORTE'].value 
                  +'&EMP_COSTETRANSPORTE_DETALLE='	+ form.elements['EMP_COSTETRANSPORTE_DETALLE'].value;

     document.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CosteTransportePorCliente2022.xsql'+opciones;      

}	

function BorrarCosteTrasporte(idCliente,idCentro,accion,desdeDonde)
{
     var msgBorrarCosteTrasporte;

     if(accion=='BORRARCLIENTE'){
       msgBorrarCosteTrasporte=document.forms['MensajeJS'].elements['BORRAR_COSTE_TRANSPORTE_EMPRESA'].value;
     }
     else{
       if(accion=='BORRARCENTRO'){
         msgBorrarCosteTrasporte=document.forms['MensajeJS'].elements['BORRAR_COSTE_TRANSPORTE_CENTRO'].value;
       }
     }
     if(confirm(msgBorrarCosteTrasporte)){
       document.forms[0].elements['ACCION'].value=accion;    
       document.forms[0].elements['NUEVO_CLIENTE'].value=idCliente;
       document.forms[0].elements['NUEVO_CENTRO'].value=idCentro;
       document.forms[0].elements['DESDE'].value=desdeDonde;
       document.forms[0].elements['EMP_COSTETRANSPORTE'].value=reemplazaComaPorPunto(document.forms[0].elements['EMP_COSTETRANSPORTE'].value);

       SubmitForm(document.forms[0]);
     }
}

function ModificarCosteTransporte(idCliente,idCentro,accion)
{
     alert(accion);
     document.forms[0].elements['ACCION'].value=accion; 
     document.forms[0].elements['NUEVO_CLIENTE'].value=idCliente;
     document.forms[0].elements['NUEVO_CENTRO'].value=idCentro;
     document.forms[0].elements['EMP_COSTETRANSPORTE'].value=reemplazaComaPorPunto(document.forms[0].elements['EMP_COSTETRANSPORTE'].value);

     SubmitForm(document.forms[0]);
}

function NuevoCosteTrasportePorCliente(form)
{

      var costeTrasporte= form.elements['EMP_COSTETRANSPORTE_ACTIVO'].value;
      var importeCosteTrasporte=form.elements['EMP_COSTETRANSPORTE_IMPORTE'].value;
      var descripcionCosteTrasporte=form.elements['EMP_COSTETRANSPORTE_DETALLE'].value;


     var opciones='?IDPROVEEDOR='+ form.elements['IDPROVEEDOR'].value 
                  +'&EMP_COSTETRANSPORTE_ACTIVO=' + costeTrasporte  
                  +'&EMP_COSTETRANSPORTE_IMPORTE='+ importeCosteTrasporte 
                  +'&EMP_COSTETRANSPORTE_DETALLE='+ descripcionCosteTrasporte;




     var opciones='?IDPROVEEDOR='    + form.elements['IDPROVEEDOR'].value 
                  +'&EMP_COSTETRANSPORTE_ACTIVO='   + form.elements['EMP_COSTETRANSPORTE_ACTIVO'].value 
                  +'&EMP_COSTETRANSPORTE_IMPORTE='  + form.elements['EMP_COSTETRANSPORTE_IMPORTE'].value 
                  +'&EMP_COSTETRANSPORTE_DETALLE='  + form.elements['EMP_COSTETRANSPORTE_DETALLE'].value

     document.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CosteTransportePorCliente2022.xsql'+opciones;      

}	




function ActualizarDatos(form, accion)
{
  if(validarFormulario(form)){
    form.elements['NUEVO_CLIENTE'].value=form.elements['IDEMPRESACLIENTE'].value;
    if(form.elements['IDCENTROCLIENTE']){
      form.elements['NUEVO_CENTRO'].value=form.elements['IDCENTROCLIENTE'].value;
    }

    form.elements['ACCION'].value=accion;
    SubmitForm(form);
  }
}

function validarFormulario(form)
{
  var errores=0;
  //alert(document.forms[0].elements['IDEMPRESACLIENTE'].value);

  if((!errores) && (document.forms[0].elements['IDEMPRESACLIENTE'].value<=0) && (document.forms[0].elements['IDCENTROCLIENTE'].value<=0))
  {
    errores=1;
    document.forms[0].elements['IDEMPRESACLIENTE'].focus();
    alert(document.forms['MensajeJS'].elements['SEL_EMPRESA_COSTE_TRANSPORTE'].value);
  }

  if((!errores) && (document.forms[0].elements['EMP_COSTETRANSPORTEACTIVO_CHECK'].checked==true || document.forms[0].elements['EMP_INTEGRADO_CHECK'].checked==true)){
    var queMensaje;
    if(document.forms[0].elements['EMP_COSTETRANSPORTEACTIVO_CHECK'].checked==true){
      document.forms[0].elements['EMP_COSTETRANSPORTEACTIVO'].value='S';
      queMensaje='MINIMO_ACTIVO';
      if(document.forms[0].elements['EMP_COSTETRANSPORTEESTRICTO_CHECK'].checked==true)
        document.forms[0].elements['EMP_COSTETRANSPORTEACTIVO'].value='E';
    }
    else{
      document.forms[0].elements['EMP_COSTETRANSPORTEACTIVO'].value='I';
      queMensaje='INTEGRADO';
    }

    if(esNulo(document.forms[0].elements['EMP_COSTETRANSPORTE'].value)){
      errores=1;
      if(queMensaje=='MINIMO_ACTIVO'){
        alert(document.forms['MensajeJS'].elements['COSTE_TRANSPORTE_ACTIVO_ALERT'].value);
      }
      else{
        alert(document.forms['MensajeJS'].elements['RELLENE_COSTE_TRANSPORTE_NO_ACEPTAR'].value);
      }
      form.elements['EMP_COSTETRANSPORTE'].focus();
      return false;
    }
    /*else{
     document.forms[0].elements['EMP_COSTETRANSPORTE'].value=reemplazaComaPorPunto(document.forms[0].elements['EMP_COSTETRANSPORTE'].value);
    }*/
  }
  else{
    if((!errores) && (document.forms[0].elements['EMP_COSTETRANSPORTEACTIVO_CHECK'].checked==false)){
      document.forms[0].elements['EMP_COSTETRANSPORTEACTIVO'].value='N';
    }
  }

  if(!errores)
    return true;  
}

function costeTransporte(nombre,form)
{
  if(nombre=="EMP_COSTETRANSPORTEACTIVO_CHECK")
  {
    if(form.elements[nombre].checked==true){
      form.elements['EMP_COSTETRANSPORTEESTRICTO_CHECK'].disabled=false;
      form.elements['EMP_COSTETRANSPORTE'].disabled=false;
      form.elements['EMP_DESCRIPCIONCOSTETRANSPORTE'].disabled=false;
    }
    else{
      form.elements['EMP_COSTETRANSPORTEESTRICTO_CHECK'].checked=false;
      form.elements['EMP_COSTETRANSPORTEESTRICTO_CHECK'].disabled=true;

      form.elements['EMP_COSTETRANSPORTE'].value='';
      form.elements['EMP_COSTETRANSPORTE'].disabled=true;

      form.elements['EMP_DESCRIPCIONCOSTETRANSPORTE'].value='';
      form.elements['EMP_DESCRIPCIONCOSTETRANSPORTE'].disabled=true;
    }
  }
  /*
  else
  {
    if(nombre=="EMP_INTEGRADO_CHECK")
	{
      if(form.elements['EMP_INTEGRADO_CHECK'].checked==true){
        form.elements['EMP_COSTETRANSPORTEACTIVO_CHECK'].checked=false;
        form.elements['EMP_COSTETRANSPORTEACTIVO_CHECK'].disabled=true;
        form.elements['EMP_COSTETRANSPORTEESTRICTO_CHECK'].checked=false;
        form.elements['EMP_COSTETRANSPORTEESTRICTO_CHECK'].disabled=true;
        form.elements['EMP_COSTETRANSPORTE'].disabled=false;
        form.elements['EMP_DESCRIPCIONCOSTETRANSPORTE'].disabled=false;
      }
      else{
        form.elements['EMP_COSTETRANSPORTEACTIVO_CHECK'].disabled=false;
        form.elements['EMP_COSTETRANSPORTEESTRICTO_CHECK'].disabled=true;
        form.elements['EMP_COSTETRANSPORTE'].value='';
        form.elements['EMP_COSTETRANSPORTE'].disabled=true;

        form.elements['EMP_DESCRIPCIONCOSTETRANSPORTE'].value='';
        form.elements['EMP_DESCRIPCIONCOSTETRANSPORTE'].disabled=true;
      }
    }
  }
  */
}


function cargarValoresDescripcionCosteTrasporte(textoConBR,nombreObjeto){

  var cadenaTmp='';  

  for(var i=0;i<textoConBR.length;i++){
    if(textoConBR.charCodeAt(i)==60 && textoConBR.charCodeAt(i+1)==98 && textoConBR.charCodeAt(i+2)==114 && textoConBR.charCodeAt(i+3)==47 && textoConBR.charCodeAt(i+4)==62){
      cadenaTmp+='\n';
      i=i+4;
    }
    else{
      cadenaTmp+=String.fromCharCode(textoConBR.charCodeAt(i));
    }
  }
  document.forms[0].elements[nombreObjeto].value=cadenaTmp;        
}

