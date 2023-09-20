//	JS Derechos de usuarios sobre una plantilla
//	ultima revisión: ET 18nov19 	PLManten_18nov19.js

function CambioResponsable(propietarioNuevo){
      var propietarioAnterior=idUsuarioPropietario;

      idUsuarioPropietario=propietarioNuevo;
      document.forms[0].elements['ESCR_'+propietarioNuevo].checked=true;
      document.forms[0].elements['LECT_'+propietarioNuevo].checked=true;
      document.forms[0].elements['ESCR_'+propietarioAnterior].checked=false;
      document.forms[0].elements['LECT_'+propietarioAnterior].checked=false;
}

/*
    recorremos todos los centros y todos los usuarios
    para cada centro si TODOS los usuarios tienen permisos guardo
    en un hidden <ACCION>_TODOS_<ID> el valor true, esto es para cuando se pulse el link "Todos"
    saber que accion tiene que realizar dar o quitar privilegios
*/
function inicializarDerechosPorUsuario(form){
  if(aplicarDerechos=='S'){
    for(i=0;i<arrayUsuarios.length;i++){
      var tienePermisosLect=1;
      var tienePermisosEscr=1;
      for(j=1;j<arrayUsuarios[i].length;j++){
        if(form.elements['LECT_'+arrayUsuarios[i][j]].checked==false)
          tienePermisosLect=0;
        if(form.elements['ESCR_'+arrayUsuarios[i][j]].checked==false)
          tienePermisosEscr=0;
      }
      form.elements['LECT_TODOS_'+arrayUsuarios[i][0]].value=tienePermisosLect;
      form.elements['ESCR_TODOS_'+arrayUsuarios[i][0]].value=tienePermisosEscr;
    }
  }
}

//seleccionar todos en lectura o ecsritura
function selTodosEscrituraLectura(accion,form){
  var form = document.forms['form1'];
  var Estado=null;

  for(var i=0;(i<form.length)&&(Estado==null);i++){
    var k=form.elements[i].name;

    if(k.substr(0,5)==accion){
      if(form.elements[i].checked == true)
        Estado=false;
      else
        Estado=true;
    }
  }

  for(var i=0;i<form.length;i++){
    var k=form.elements[i].name;

    if(k.substr(0,5)==accion){
      form.elements[i].checked = Estado;
    }
  }
}//fin seleccionar todos

/*
si es un check de usuario recibe la acion LECT / ESCR, el ID de usuario, y a quien afecta 'ESTE'
si es un link (Todos) recibe la accion LECT / ESCR, el ID del centro, y a quien afecta 'TODOS'
si es un boton recibe la accion EMPRESA, se aplica a toda la empresa
*/
function validacionEscrituraLectura(accion,id,tipo,form){
  // ESTE usuario
  if(tipo=='ESTE'){
    if(idUsuarioPropietario!=id){
      if(accion=='LECT'){
        if(form.elements[accion+'_'+id].checked==false){
          form.elements['ESCR_'+id].checked=false;
        }
      }else{
        if(form.elements[accion+'_'+id].checked==true){
          form.elements['LECT_'+id].checked=true;
        }
      }
    }else{
      form.elements[accion+'_'+id].checked=true;
      alert(msgAfectaUsuarioPropietario);
    }
  }else{
    if(tipo=='TODOS'){
      //  TODOS los usuarios
      var afectaAlPropietario='';
      var posicionDelCentro=0;

/*
      obtengo la posicion del centro en el array
*/
      for(var n=0;n<arrayUsuarios.length;n++){
        if(arrayUsuarios[n][0]==id)
          posicionDelCentro=n;
      }

/*
      para todos los usuarios activamos o desactivamos
*/
      for(var i=1;i<arrayUsuarios[posicionDelCentro].length;i++){
        if(idUsuarioPropietario!=arrayUsuarios[posicionDelCentro][i]){
          if(form.elements[accion+'_TODOS_'+arrayUsuarios[posicionDelCentro][0]].value==1)
            form.elements[accion+'_'+arrayUsuarios[posicionDelCentro][i]].checked=false;
          else
            form.elements[accion+'_'+arrayUsuarios[posicionDelCentro][i]].checked=true;

/*
          miramos que no haya conflictos con los derechos lectura / escritura
          si no puede leer tampoco puede escribir
          si puede escribir puede leer
*/
          if(accion=='LECT' && form.elements[accion+'_'+arrayUsuarios[posicionDelCentro][i]].checked==false){
            form.elements['ESCR_'+arrayUsuarios[posicionDelCentro][i]].checked=false;
          }else{
            if(accion=='ESCR' && form.elements[accion+'_'+arrayUsuarios[posicionDelCentro][i]].checked==true){
              form.elements['LECT_'+arrayUsuarios[posicionDelCentro][i]].checked=true;
            }
          }
        }else{
          afectaAlPropietario='S';
          form.elements[accion+'_'+arrayUsuarios[posicionDelCentro][i]].checked=true;
        }
      }

      //if(afectaAlPropietario=='S' && form.elements[accion+'_TODOS_'+arrayUsuarios[posicionDelCentro][0]].value==1){
      //  alert(msgAfectaUsuarioPropietario);
      //}

/*
      guardamos la siguiente accion a realizar al pulsar el link "Todos"
      dar / quitar alternativamente
*/
      if(form.elements[accion+'_TODOS_'+arrayUsuarios[posicionDelCentro][0]].value==1){
        form.elements[accion+'_TODOS_'+arrayUsuarios[posicionDelCentro][0]].value=0;
        if(accion=='LECT')
          form.elements['ESCR_TODOS_'+arrayUsuarios[posicionDelCentro][0]].value=0;
      }else{
        form.elements[accion+'_TODOS_'+arrayUsuarios[posicionDelCentro][0]].value=1;
        if(accion=='ESCR')
          form.elements['LECT_TODOS_'+arrayUsuarios[posicionDelCentro][0]].value=1;
      }
    }else{
      // tipo = EMPRESA
      var afectaAlPropietario='';
      var posicionDelCentro=0;

/*
      miramos que la accion global concuerde con las de los centros
      si lo centros son diferentes (alguno activar / alguno desactivar usamos la global)
      escojemos la opcion que esta para todos los centros. todos desactivar ==> desactivar
*/
      var accionGlobal=-1;
      var salir=0;

      for(var n=0;n<arrayUsuarios.length&&!salir;n++){
        posicionDelCentro=n;
        if(accionGlobal==-1){
          accionGlobal=form.elements[accion+'_TODOS_'+arrayUsuarios[posicionDelCentro][0]].value;
        }else{
          if(form.elements[accion+'_TODOS_'+arrayUsuarios[posicionDelCentro][0]].value!=accionGlobal){
            salir=1;
          }
        }
      }

      if(!salir){
        form.elements[accion+'_EMPRESA'].value=accionGlobal;
      }

/*
      obtengo la posicion del centro en el array
*/
      arrayUsuarios

      // PARA TODOS LOS CENTROS
      for(var n=0;n<arrayUsuarios.length;n++){
        posicionDelCentro=n;

/*
        para todos los usuarios DEL CENTRO ACTUAL activamos o desactivamos
*/
        for(var i=1;i<arrayUsuarios[posicionDelCentro].length;i++){
          if(idUsuarioPropietario!=arrayUsuarios[posicionDelCentro][i]){
            if(form.elements[accion+'_EMPRESA'].value==1)
              form.elements[accion+'_'+arrayUsuarios[posicionDelCentro][i]].checked=false;
            else
              form.elements[accion+'_'+arrayUsuarios[posicionDelCentro][i]].checked=true;

/*
            miramos que no haya conflictos con los derechos lectura / escritura
            si no puede leer tampoco puede escribir
            si puede escribir puede leer
*/
            if(accion=='LECT' && form.elements[accion+'_'+arrayUsuarios[posicionDelCentro][i]].checked==false){
              form.elements['ESCR_'+arrayUsuarios[posicionDelCentro][i]].checked=false;
            }else{
              if(accion=='ESCR' && form.elements[accion+'_'+arrayUsuarios[posicionDelCentro][i]].checked==true){
                form.elements['LECT_'+arrayUsuarios[posicionDelCentro][i]].checked=true;
              }
            }
          }else{
            afectaAlPropietario='S';
            form.elements[accion+'_'+arrayUsuarios[posicionDelCentro][i]].checked=true;
          }
        }

        /* guardamos la accion a realizar a nivel de centro para que concuerde con la de empresa */
        if(form.elements[accion+'_EMPRESA'].value==1){
          form.elements[accion+'_TODOS_'+arrayUsuarios[posicionDelCentro][0]].value=0;
          if(accion=='LECT')
            form.elements['ESCR_TODOS_'+arrayUsuarios[posicionDelCentro][0]].value=0;
        }else{
          form.elements[accion+'_TODOS_'+arrayUsuarios[posicionDelCentro][0]].value=1;
          if(accion=='ESCR')
            form.elements['LECT_TODOS_'+arrayUsuarios[posicionDelCentro][0]].value=1;
        }
      }

/*
      guardamos la siguiente accion a realizar al pulsar el link "Todos" empresa
      dar / quitar alternativamente
*/
      if(form.elements[accion+'_EMPRESA'].value==1){
        form.elements[accion+'_EMPRESA'].value=0;
        if(accion=='LECT')
          form.elements['ESCR_EMPRESA'].value=0;
      }else{
        form.elements[accion+'_EMPRESA'].value=1;
        if(accion=='ESCR')
          form.elements['LECT_EMPRESA'].value=1;
      }
    }
  }
}

function Actua(formu){
  var Cadena='';

  if(Edicion=='EDICION'){
    if(validaNombre(formu)==true){
      //  Construye la cadena con los derechos de los usuarios
  	  for (j=0;j<formu.elements.length;j++){
        if(formu.elements[j].name.substring(0,10)=='USUARIO_ID'){
          Cadena+=formu.elements[j].value+'|'+(formu.elements['LECT_'+formu.elements[j].value].checked==true?'S':'N')+'|'+(formu.elements['ESCR_'+formu.elements[j].value].checked==true?'S':'N')+'#';
        }
      }

      //  Guarda la cadena de derechos en el campo asignado
      formu.elements['DERECHOS'].value=Cadena;
	  formu.elements['ACCION'].value='GUARDARDERECHOS';
      SubmitForm(formu);
    }
  }else{
    SubmitForm(formu);
  }
}
function validaNombre(formu){
  if(formu.elements['NOMBRE'].value==""){
    alert(msgPL0340);
    formu.elements['NOMBRE'].focus();
    return false;
  }else
    return true;
}

function validaFechaSiEstaProgramada(formu){
  if (formu.PL_PROGRAMADA.checked){
    //Si PERIODOACTIVACION esta vacio obligamos a que FECHANO_ACTIVACION exista
    if(formu.PL_PERIODOACTIVACION.value==""){
      if (formu.FECHANO_ACTIVACION.value!=""){
        return test(formu);
      }else{
        alert(msgPL0275);
        formu.FECHANO_ACTIVACION.focus();
        return false;
      }
    }
    //Si existe PERIODOACTIVACION obligamos a que exista FECHANO_ACTIVACION
    else{
      if(formu.FECHANO_ACTIVACION.value==""){
        alert(msgPL0270);
        formu.FECHANO_ACTIVACION.focus();
        return false;
      }else{
        return test(formu);
      }
    }
  }else{return true};
}

function EmpresasAutorizadas(){
  var form=document.forms[0];

  if(form.elements['PL_ID'].value==0){
    alert(msgSinPlantilla);
  }else{
    var opciones='?PL_ID='+ form.elements['PL_ID'].value;
    MostrarPag('http://www.newco.dev.br/Compras/Multioferta/PLEmpresasAutorizadas.xsql'+opciones,'empresasAutorizadas');
  }
}


// 18nov19 Mostrar todos los productos al usuario
function MostrarTodos(IDUsuario)
{
	console.log('MostrarTodos:'+IDUsuario);
 	var formu = document.forms[0];
	formu.elements['ACCION'].value='MOSTRARTODOS';
	formu.elements['PARAMETROS'].value=IDUsuario;
    SubmitForm(formu);
}

// 18nov19 Ocultar todos los productos al usuario
function OcultarTodos(IDUsuario)
{
	console.log('OcultarTodos:'+IDUsuario);
 	var formu = document.forms[0];
	formu.elements['ACCION'].value='OCULTARTODOS';
	formu.elements['PARAMETROS'].value=IDUsuario;
    SubmitForm(formu);
}

// 18nov19 Bloquear todos los productos al usuario
function BloquearTodos(IDUsuario)
{
	console.log('BloquearTodos:'+IDUsuario);
 	var formu = document.forms[0];
	formu.elements['ACCION'].value='BLOQUEARTODOS';
	formu.elements['PARAMETROS'].value=IDUsuario;
    SubmitForm(formu);
}
