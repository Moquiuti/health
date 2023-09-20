//	JS mantenimiento centros de consumo
//	Ultima revision: ET 19abr22 09:00 CentrosConsumo2022_190422.js

               
function EditarCentroConsumo(cen_id, centroconsumo_id){
    document.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CentrosConsumo2022.xsql?CEN_ID='+cen_id+'&CENTROCONSUMO_ID='+centroconsumo_id+'&ACCION=EDITAR';
}

function BorrarCentroConsumo(idCentro, idcentroConsumo,accion){

	var id;

	document.forms[0].elements['ACCION'].value=accion; 
	document.forms[0].elements['CEN_ID'].value=idCentro;
	document.forms[0].elements['CENTROCONSUMO_ID'].value=idcentroConsumo;

	if(document.forms[0].elements['CHECKPORDEFECTO_'+idcentroConsumo]){
	   if(document.forms[0].elements['CHECKPORDEFECTO_'+idcentroConsumo].checked==true){
    	 alert(msgBorrarPorDefecto);
	   }
	   else{
    	 for(var n=0;n<document.forms[0].length;n++){
    	   if(document.forms[0].elements[n].name.substring(0,5)=='CHECK' && document.forms[0].elements[n].checked==true){
        	 id=obtenerId(document.forms[0].elements[n].name);
        	 if(isNaN(id)){
        	   alert(msgBorrarSinPorDefecto);
        	 }
        	 else{
        	   document.forms[0].elements['IDPORDEFECTO'].value=id;
        	   if(confirm(msgConfirmarBorrado)){
            	 SubmitForm(document.forms[0]);
        	   }
        	 }   
    	   }
    	 }
	   }
	}
	else{
	   if(document.forms[0].elements['CHECKNUEVOPORDEFECTO'].checked==true)
    	 alert(msgBorrarPorDefecto);
	   else{
    	 for(var n=0;n<document.forms[0].length;n++){
    	   if(document.forms[0].elements[n].name.substring(0,5)=='CHECK' && document.forms[0].elements[n].checked==true){
        	 id=obtenerId(document.forms[0].elements[n].name);
        	 if(isNaN(id)){
        	   alert(msgBorrarSinPorDefecto);
        	 }
        	 else{
        	   document.forms[0].elements['IDPORDEFECTO'].value=id;
        	   if(confirm(msgConfirmarBorrado)){ 
            	 SubmitForm(document.forms[0]);
        	   }
        	 }   
    	   }
    	 }
	   }
	}
}	
        	
        	
function ActualizarDatos(form, accion){

    document.forms[0].elements['ACCION'].value=accion; 

  if(accion=='INSERTAR'){
    document.forms[0].elements['CENTROCONSUMO_ID'].value=0;
    if(document.forms[0].elements['CHECKNUEVOPORDEFECTO'].checked==true)
        document.forms[0].elements['NUEVOPORDEFECTO'].value='S';
    else
      document.forms[0].elements['NUEVOPORDEFECTO'].value='N';

    if(validarFormulario(form)){ 
        form.elements['ACCION'].value=accion;
      for(var n=0;n<document.forms[0].length;n++){
        if(document.forms[0].elements[n].name.substring(0,5)=='CHECK'){
            if(document.forms[0].elements[n].checked==true){
            id=obtenerId(document.forms[0].elements[n].name);
            if(isNaN(id)){
            document.forms[0].elements['IDPORDEFECTO'].value=0;
            }
            else{
            document.forms[0].elements['IDPORDEFECTO'].value=id; 
            }
         }
       }
     }
     if(document.forms[0].elements['IDPORDEFECTO'].value==''){
       if(confirm(msgSinPorDefecto)){
        document.forms[0].elements['NUEVOPORDEFECTO'].value='S';
        SubmitForm(document.forms[0]);
       }
     }
     else{
        SubmitForm(document.forms[0]);
     }
    }
  }
  else{
    if(accion=='GUARDAR'){
      if(document.forms[0].elements['CHECKNUEVOPORDEFECTO'].checked==true)
        document.forms[0].elements['NUEVOPORDEFECTO'].value='S';
      else
        document.forms[0].elements['NUEVOPORDEFECTO'].value='N';

      if(validarFormulario(form)){ 
        form.elements['ACCION'].value=accion;
        for(var n=0;n<document.forms[0].length;n++){
              if(document.forms[0].elements[n].name.substring(0,5)=='CHECK' && document.forms[0].elements[n].checked==true){
                id=obtenerId(document.forms[0].elements[n].name);
                if(isNaN(id)){
                  document.forms[0].elements['IDPORDEFECTO'].value=0;
                }
                else{
                  document.forms[0].elements['IDPORDEFECTO'].value=id; 
                }   
              }
            }
            if(document.forms[0].elements['IDPORDEFECTO'].value==''){
       if(confirm(msgSinPorDefecto)){
        document.forms[0].elements['NUEVOPORDEFECTO'].value='S';
        SubmitForm(document.forms[0]);
       }
     }
     else{
        SubmitForm(document.forms[0]);
     }

      }
    }
    else{
      if(accion=='CAMBIARPORDEFECTO'){
        var hemosAvisado=0;
        for(var n=0;n<document.forms[0].length;n++){
              if(document.forms[0].elements[n].name.substring(0,5)=='CHECK' && document.forms[0].elements[n].checked==true){
                id=obtenerId(document.forms[0].elements[n].name);
                if(isNaN(id)){
                    hemosAvisado=1;
                  alert(msgBorrarSinPorDefecto);
                }
                else{
                  document.forms[0].elements['IDPORDEFECTO'].value=id; 
                }   
              }
            }
            if(document.forms[0].elements['IDPORDEFECTO'].value==''){
                if(document.forms[0].elements['CENTROCONSUMO_ID'].value==0){
                    if(!hemosAvisado){
                        alert(msgSinPorDefectoError);
                    }
                }
                else{
                   		if(confirm(msgSinPorDefecto)){
                   			document.forms[0].elements['NUEVOPORDEFECTO'].value='S';
                   			SubmitForm(document.forms[0]);
                   		}
                   	}
                 	}
                 	else{
                 		SubmitForm(document.forms[0]);
                 	}
      }
    }
  }
}
        	
function validarFormulario(form){
  var errores=0;



        	if((!errores) && (document.forms[0].elements['NUEVAREFERENCIA'].value=='')){
        alert('Debe proporcionar una referencia para el centro de consumo');
        document.forms[0].elements['NUEVAREFERENCIA'].focus();
        errores++;
      }

      if((!errores) && (document.forms[0].elements['NUEVONOMBRE'].value=='')){
        alert('Debe proporcionar un nombre para el centro de consumo');
        document.forms[0].elements['NUEVONOMBRE'].focus();
        errores++;
      }



  if(!errores){
    return true;  
  }
}
        	
        
        
        
function comprobarCheck(obj,form){
  if(obj.checked==false){
    obj.checked=true;
  }

  for(var n=0;n<form.length;n++){
    if(form.elements[n].name.substring(0,5)=='CHECK' && form.elements[n].name!=obj.name)
      form.elements[n].checked=false;
  }
}
