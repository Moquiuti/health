//	Funciones JS para PEDIDOMINIMOPORCLIENTE
//	Ultima revisión ET 25jul22 11:00 PedidoMinimoPorCliente2022_250722.js

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




function BorrarPedidoMinimo(idCliente,idCentro,accion,desdeDonde){
     var msgBorrarPedidoMinimo;

     if(accion=='BORRARCLIENTE'){
       msgBorrarPedidoMinimo=document.forms['MensajeJS'].elements['BORRAR_PEDIDO_MINIMO_EMPRESA'].value;
     }
     else{
       if(accion=='BORRARCENTRO'){
         msgBorrarPedidoMinimo=document.forms['MensajeJS'].elements['BORRAR_PEDIDO_MINIMO_CENTRO'].value;
       }
     }
     if(confirm(msgBorrarPedidoMinimo)){
       document.forms[0].elements['ACCION'].value=accion;    
       document.forms[0].elements['NUEVO_CLIENTE'].value=idCliente;
       document.forms[0].elements['NUEVO_CENTRO'].value=idCentro;
       document.forms[0].elements['DESDE'].value=desdeDonde;
       document.forms[0].elements['EMP_PEDIDOMINIMO'].value=reemplazaComaPorPunto(document.forms[0].elements['EMP_PEDIDOMINIMO'].value);

       SubmitForm(document.forms[0]);
     }
}

function ModificarPedidoMinimo(idCliente,idCentro,accion){
     document.forms[0].elements['ACCION'].value=accion; 
     document.forms[0].elements['NUEVO_CLIENTE'].value=idCliente;
     document.forms[0].elements['NUEVO_CENTRO'].value=idCentro;
     document.forms[0].elements['EMP_PEDIDOMINIMO'].value=reemplazaComaPorPunto(document.forms[0].elements['EMP_PEDIDOMINIMO'].value);

     SubmitForm(document.forms[0]);
}

function NuevoPedidoMinimoPorCliente(form){

     var opciones='?IDPROVEEDOR='+ form.elements['IDPROVEEDOR'].value 
                  +'&EMP_PEDMINIMO_ACTIVO='+ pedidoMinimoActivo
                  +'&EMP_PEDMINIMO_IMPORTE='+ importePedidoMinimo 
                  +'&EMP_PEDMINIMO_DETALLE='+ descripcionPedidoMinimo;




     var opciones='?IDPROVEEDOR='+ form.elements['IDPROVEEDOR'].value 
                  +'&EMP_PEDMINIMO_ACTIVO='+ form.elements['EMP_PEDMINIMO_ACTIVO'].value 
                  +'&EMP_PEDMINIMO_IMPORTE='+ form.elements['EMP_PEDMINIMO_IMPORTE'].value 
                  +'&EMP_PEDMINIMO_DETALLE='+ form.elements['EMP_PEDMINIMO_DETALLE'].value

     document.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/PedidoMinimoPorCliente2022.xsql'+opciones;      

}	

function ActualizarDatos(form, accion){
  if(validarFormulario(form)){
    form.elements['NUEVO_CLIENTE'].value=form.elements['IDEMPRESACLIENTE'].value;
    if(form.elements['IDCENTROCLIENTE']){
      form.elements['NUEVO_CENTRO'].value=form.elements['IDCENTROCLIENTE'].value;
    }

    form.elements['ACCION'].value=accion;
    SubmitForm(form);
  }
}

function validarFormulario(form){
  var errores=0;
  //alert(document.forms[0].elements['IDEMPRESACLIENTE'].value);

  if((!errores) && (document.forms[0].elements['IDEMPRESACLIENTE'].value<=0) && (document.forms[0].elements['IDCENTROCLIENTE'].value<=0))
  {
    errores=1;
    document.forms[0].elements['IDEMPRESACLIENTE'].focus();
    alert(document.forms['MensajeJS'].elements['SEL_EMPRESA_PEDIDO_MINIMO'].value);
  }

  if((!errores) && (document.forms[0].elements['EMP_PEDMINIMOACTIVO_CHECK'].checked==true || document.forms[0].elements['EMP_INTEGRADO_CHECK'].checked==true)){
    var queMensaje;
    if(document.forms[0].elements['EMP_PEDMINIMOACTIVO_CHECK'].checked==true){
      document.forms[0].elements['EMP_PEDMINIMOACTIVO'].value='S';
      queMensaje='MINIMO_ACTIVO';
      if(document.forms[0].elements['EMP_PEDMINIMOESTRICTO_CHECK'].checked==true)
        document.forms[0].elements['EMP_PEDMINIMOACTIVO'].value='E';
    }
    else{
      document.forms[0].elements['EMP_PEDMINIMOACTIVO'].value='I';
      queMensaje='INTEGRADO';
    }

    if(esNulo(document.forms[0].elements['EMP_PEDIDOMINIMO'].value)){
      errores=1;
      if(queMensaje=='MINIMO_ACTIVO'){
        alert(document.forms['MensajeJS'].elements['RELLENE_IMPORTE_MINIMO_ACTIVO'].value);
      }
      else{
        alert(document.forms['MensajeJS'].elements['RELLENE_IMPORTE_MINIMO_NO_ACEPTAR'].value);
      }
      form.elements['EMP_PEDIDOMINIMO'].focus();
      return false;
    }
    /*else{
     document.forms[0].elements['EMP_PEDIDOMINIMO'].value=reemplazaComaPorPunto(document.forms[0].elements['EMP_PEDIDOMINIMO'].value);
    }*/
  }
  else{
    if((!errores) && (document.forms[0].elements['EMP_PEDMINIMOACTIVO_CHECK'].checked==false)){
      document.forms[0].elements['EMP_PEDMINIMOACTIVO'].value='N';
    }
  }

  if(!errores)
    return true;  
}

function pedidoMinimo(nombre,form)
{
  if(nombre=="EMP_PEDMINIMOACTIVO_CHECK")
  {
    if(form.elements[nombre].checked==true){
      form.elements['EMP_PEDMINIMOESTRICTO_CHECK'].disabled=false;
      form.elements['EMP_PEDIDOMINIMO'].disabled=false;
      form.elements['EMP_PEDIDOMINIMO_NM'].disabled=false;

      form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].disabled=false;
    }
    else{
      form.elements['EMP_PEDMINIMOESTRICTO_CHECK'].checked=false;
      form.elements['EMP_PEDMINIMOESTRICTO_CHECK'].disabled=true;

      form.elements['EMP_PEDIDOMINIMO'].value='';
      form.elements['EMP_PEDIDOMINIMO'].disabled=true;
      form.elements['EMP_PEDIDOMINIMO_NM'].value='';
      form.elements['EMP_PEDIDOMINIMO_NM'].disabled=true;

      form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].value='';
      form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].disabled=true;
    }
  }
}


function cargarValoresDescripcionPedidoMinimo(textoConBR,nombreObjeto){

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
