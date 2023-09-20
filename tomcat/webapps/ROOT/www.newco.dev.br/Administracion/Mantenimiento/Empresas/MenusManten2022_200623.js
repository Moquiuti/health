//	JS para el mantenimiento de menus
//	Ultima revision: ET 20jun23 17:52 MenusManten2022_200623.js

function deshabilitaCabecera(obj){
 var id;
 if(obj.checked==false){
   id=obtenerId(obj.name);
   document.forms[0].elements['CABECERA_'+id].checked=false;
 }
}


function comprobarMaximoBotonesCabecera(min,max,obj){

  var cuantos=0;
  form=document.forms[0];

  var id;



  if(arguments.length>2){
    id=obtenerId(obj.name);
    if(form.elements['MENU_'+id].checked==false)
      obj.checked=false;
  }

  for(var n=0;n<form.length;n++){
    if(form.elements[n].name.substring(0,9)=='CABECERA_' && form.elements[n].checked==true){
      cuantos++;
    }
  }
  if(cuantos<=min){
    if(arguments.length<3){
      alert(msgMinimoBotones);
      return false;
    }
  }
  else{
    if(cuantos>max){
      alert(msgMaximoBotones+max);
      if(arguments.length>2)
        obj.checked=false;
      return false;
    }
    else{
      return true;
    }
  }    
}


function CargarPerfilMenus(idPerfil)
{

  var cadenaMenus;

  //  recorrer el arrayPerfiles : array(identificador,array(idPerfil,cadenaMenus{idmenu|accesibilidad|cabecera#...}))
  for(var n=0;n<arrayPerfiles.length;n++)
    if(arrayPerfiles[n][0]==parseInt(idPerfil))
      cadenaMenus=arrayPerfiles[n][1];
  cadenaMenus=cadenaMenus.substring(0,cadenaMenus.length-1);   

  //  transformar la cadena en un array('idmenu|accesibilidad'....)
  //  y para cada elemento lo extraigo y lo convierto es un array(idmenu,accesibilidad)
  //  que es con el que voy a trabajar
  var arrayMenus=cadenaMenus.split('#');

  for(var n=0;n<arrayMenus.length;n++){
    var cadenaMenu=arrayMenus[n];
    var arrayMenu=cadenaMenu.split('|');
    if(document.forms[0].elements['MENU_'+arrayMenu[0]])
      if(arrayMenu[1]=='S')
        document.forms[0].elements['MENU_'+arrayMenu[0]].checked=true;
      else
        document.forms[0].elements['MENU_'+arrayMenu[0]].checked=false;

    if(document.forms[0].elements['CABECERA_'+arrayMenu[0]])
      if(arrayMenu[2]=='S')
        document.forms[0].elements['CABECERA_'+arrayMenu[0]].checked=true;
      else
        document.forms[0].elements['CABECERA_'+arrayMenu[0]].checked=false;    

  }
}



function ValidaySubmit(formu, accion)
{
  var id;
  var cadenaCambios='';
  var visualizable;
  var pertenece;
  var cabecera;

	formu.elements['ACCION'].value=accion;

  if(validarFormulario(formu))
  {

    for(var i=0;i<formu.length;i++){
      if(formu.elements[i].name.substring(0,5)=='MENU_'){
        id=obtenerId(formu.elements[i].name);

        if(formu.elements[i].checked==true)
          visualizable=1;
        else
          visualizable=0;



       if(formu.elements['CABECERA_'+id].checked==true)
          cabecera='S';
        else
          cabecera='N';

        cadenaCambios+=id+'|'+visualizable+'|'+cabecera+'#';
      }
    }
    formu.elements['CAMBIOS_MENUS'].value=cadenaCambios;

    SubmitForm(formu);
  }
}


function validarFormulario(form)
{
  var errores=0;

  if((!errores)&& (!comprobarMenusPorUsuario(document.forms[0]))){
    alert('Por favor, rogamos seleccione los menús a los que tendrá acceso este usuario antes de enviar el formulario.'); 
    document.location.href='#menus';
    return false;
  }

  if((!errores)&& (!comprobarMaximoBotonesCabecera(0,10))){
    document.location.href='#menus';
    return false;
  }


      if(!errores)
        return true;
      else  
        return false;

}

function comprobarMenusPorUsuario(form){
  var algunoInformado=0;
  for(var n=0;n<form.length;n++){
    if(form.elements[n].name.substring(0,5)=='MENU_'){
      if(form.elements[n].checked==true){
        algunoInformado++;
      }
    }
  }
  return algunoInformado;
}
