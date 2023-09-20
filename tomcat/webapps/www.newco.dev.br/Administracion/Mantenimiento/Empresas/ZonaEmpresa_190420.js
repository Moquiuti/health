//	JS Margen izquierdo mantenimiento de empresas
//	Ultima revision: ET 27nov19 10:45 ZonaEmpresa_190420.js

function NuevaEmpresa() 
{
	var IDPais = document.forms[0].elements['IDPAIS'].value;
	var IDUsuario = document.forms[0].elements['IDUSUARIO'].value;

	//solodebug	alert('IDPais:'+IDPais+' IDUsuario:'+IDUsuario);

    parent.areaTrabajo.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPNueva.xsql?EMP_IDPAIS='+IDPais+'&IDUSUARIO='+IDUsuario+'&ADMINISTRADORMVM=ADMINISTRADORMVM';
} 

function EditarEmpresa(){
	var emp_id = document.forms[0].elements['IDEMPRESA'].value;

	if(emp_id==-1)
		alert(noEmpresaActiva);
	else
		//parent.areaTrabajo.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPManten.xsql?ID='+emp_id+'&ADMINISTRADORMVM=ADMINISTRADORMVM';
		parent.areaTrabajo.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPManten.xsql?IDEMPRESA='+emp_id+'&ADMINISTRADORMVM=ADMINISTRADORMVM';
}
          
     	
// No dejamos borrar la última Empresa. De esta forma aseguramos que no nos quedamos sin Empresas.
// Comprobamos si tiene pedidos, si tiene no borramos, 29-11-13 - problema de borrar todo viamed viejo

function BorrarEmpresa() 
{
	if(sinoSeBorraAsiMismoEnviarCambios('BORRAREMPRESA',usuarioAdministrador))
	{
  		var emp_actual = document.forms[0].elements['IDEMPRESA'].value;

		if (emp_actual==-1)
	  		alert(noEmpresaActivaBorrar);
		else
		{	
        	//si empresa tiene pedidos no se puede borrar
        	jQuery.ajax({
            	//cache:	false,
            	url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/confirmEliminarEmpresa.xsql',
            	type:	"GET",
            	data:	"IDEMPRESA="+emp_actual,
            	//contentType: "application/xhtml+xml",
            	success: function(objeto){
                	var data = eval("(" + objeto + ")");

                	//alert('succes data '+data.confirmEliminarEmpresa.estado);
                	//si tiene pedidos devuelve S
                	if(data.confirmEliminarEmpresa.estado == 'S'){

                    	alert(empresaConPedidos);
                	}
                	//si no tiene pedidos envio cambios, elimino empresa
                	else{ 
                    	//trozo que comprueba y elimina
                    	contestacion = confirm(seguroEliminarEmpresa);
                    	if (!contestacion) 
                        	return;
                    	else
	      				EnviarCambios('BORRAREMPRESA', emp_actual);
                	 }
            	},
            	error: function(xhr, errorString, exception) {
                	alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
            	}
        	});

		}//FIN ELSE ANTES DE AJAX
	}
}//FIN BORRAR EMPRESA


//	11ene17	Cambio de pais
function CambioPaisActual(IDPais)
{
	//SOLODEBUG	alert('pais_id:'+IDPais);

	parent.areaTrabajo.location.href='about:blank';

    document.forms[0].elements['ACCION'].value='CAMBIOPAIS';
    document.forms[0].elements['IDNUEVOPAIS'].value=IDPais
    document.forms[0].elements['IDNUEVAEMPRESA'].value='-1';
    document.forms[0].elements['IDNUEVOCENTRO'].value='-1';
    SubmitForm(document.forms[0]);
}


// Hacemos el cambio de la Empresa ACTUAL.
//esta funcion recibe un parametro (opcionalmente) cuando se llama desde otro frame (nueva Empresa)este parametro es el id de la empresa recien creada.
//si la funcion tiene parametro lo utilizamos en lugar de  document.forms[0].elements['IDEMPRESA'].value;

function CambioEmpresaActual(emp_id)
{
    document.forms[0].elements['ACCION'].value='CAMBIOEMPRESA';
    document.forms[0].elements['IDNUEVOCENTRO'].value=-1;
    if(arguments.length>0)
      document.forms[0].elements['IDNUEVAEMPRESA'].value=arguments[0];
    else
      document.forms[0].elements['IDNUEVAEMPRESA'].value=document.forms[0].elements['IDEMPRESA'].value;
    SubmitForm(document.forms[0]);
}



function RecargarEmpresaActual(emp_id)
{
    document.forms[0].elements['ACCION'].value='CAMBIOEMPRESA';
    //document.forms[0].elements['IDNUEVOCENTRO'].value=-1;
    if(arguments.length>0)
      document.forms[0].elements['IDNUEVAEMPRESA'].value=arguments[0];
    else
      document.forms[0].elements['IDNUEVAEMPRESA'].value=document.forms[0].elements['IDEMPRESA'].value;
	 SubmitForm(document.forms[0]);
}

//
// Hacemos el cambio de la Centro ACTUAL.
//

function ActualizarNuevaEmpresa(emp_id){
  parent.areaTrabajo.location='about:blank';
  CambioEmpresaActual(emp_id);
}

function CambioCentroActual(emp_id, cen_id)
{	
	  document.forms[0].elements['ACCION'].value='CAMBIOCENTRO';
     	  if(arguments.length>0){
            document.forms[0].elements['IDNUEVAEMPRESA'].value=arguments[0];
     	    document.forms[0].elements['IDNUEVOCENTRO'].value=arguments[1];
            }
     	  else{

            document.forms[0].elements['IDNUEVAEMPRESA'].value=document.forms[0].elements['IDEMPRESA'].value;
     	    document.forms[0].elements['IDNUEVOCENTRO'].value=document.forms[0].elements['IDCENTRO'].value;
            }
	  SubmitForm(document.forms[0]);
	  //CambioCentro(document.forms[0].elements['IDNUEVOCENTRO'].value,document.forms[0].elements['IDNUEVAEMPRESA'].value);
}

function CambioCentro(cen_id, emp_id){
    document.forms[0].elements['ACCION'].value='CAMBIOCENTRO';
    document.forms[0].elements['IDNUEVOCENTRO'].value=cen_id;
    document.forms[0].elements['IDNUEVAEMPRESA'].value=emp_id;
	SubmitForm(document.forms[0]);
}

function EditarCentro()
{
  var cen_id = document.forms[0].elements['IDCENTRO'].value;
  var emp_id = document.forms[0].elements['IDEMPRESA'].value;
	if (cen_id==-1)
	  	alert(msgSinCentro);
	else
	{
     	parent.areaTrabajo.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENManten.xsql?ID='+cen_id;
	}
} 


// No dejamos borrar la última Centro. De esta forma aseguramos que no nos quedamos sin Centros.
// tb comprobamos si el centro titne pedidos, si tiene no se puede borrar-29-11-13 desp de eliminacion viamed antiguo que creo problemas

function BorrarCentro() 
{
  	var pl_actual = document.forms[0].elements['IDCENTRO'].value;

 	if(sinoSeBorraAsiMismoEnviarCambios('BORRARCENTRO',usuarioAdministrador))
	{

		if (pl_actual==-1)
	  		alert(msgSinCentro);
		else {
        	//si centro tiene pedidos no se puede borrar
        	jQuery.ajax({
            	//cache:	false,
            	url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/confirmEliminarCentro.xsql',
            	type:	"GET",
            	data:	"IDCENTRO="+pl_actual,
            	//contentType: "application/xhtml+xml",
            	success: function(objeto){
                	var data = eval("(" + objeto + ")");

                	//alert('succes data '+data.confirmEliminarCentro.estado);
                	//si tiene pedidos devuelve S
                	if(data.confirmEliminarCentro.estado == 'S'){

                    	alert(centroConPedidos);
                	}
                	//si no tiene pedidos envio cambios, elimino usuario
                	else{ 
                    	//trozo que elimina centro previa confirmacion
                    	contestacion = confirm(seguroEliminarCentro);
                    	if (!contestacion) 
                        	return;
                    	else
                        	EnviarCambios('BORRARCENTRO', pl_actual);
                	 }
            	},
            	error: function(xhr, errorString, exception) {
                	alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
            	}
        	});
    	 }  
	}  


}//FIN FUNCION BORRARCENTRO


function NuevoCentro() 
{
if(document.forms[0].elements['IDEMPRESA'].value>0){
      parent.areaTrabajo.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENManten.xsql?EMP_ID='+document.forms[0].elements['IDEMPRESA'].value+'&amp;ID=';
    }
    else{
      alert(msgSinEmpresa);
    }
} 
     	
              
function ComprobarAntesBorrarUsuario(idUsuario){

	//no puedo borrar mi mismo usuario
      var us_conectado = document.forms[0].elements['US_ID'].value;  

      if (us_conectado == idUsuario){ 
            alert(usuarioConectadoNoEliminar); 

        }
      else{
        //si usuario tiene pedidos historicos o activos no se puede borrar
          jQuery.ajax({
              //cache:	false,
              url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/comprobarAntesEliminarUsuario.xsql',
              type:	"GET",
              data:	"IDUSUARIO="+idUsuario,
              //contentType: "application/xhtml+xml",
              success: function(objeto){
                  var data = eval("(" + objeto + ")");

                  //alert('succes data '+data.comprobarAntesEliminarUsuario.estado);

                  //si tiene pedidos activos devuelve KO|1
                  if(data.comprobarAntesEliminarUsuario.estado == 'KO|1'){
                      alert(usuarioConPedidos);
                      return false;
                  }
                  //si tiene pedidos historicos devuelve KO|2
                  else if(data.comprobarAntesEliminarUsuario.estado == 'KO|2'){ 
                      alert(usuarioConPedidosHistoricos);
                      return false;
                   }
                  else if (data.comprobarAntesEliminarUsuario.estado == 'OK|'){ 
                      BorrarUsuario('BORRARUSUARIO', idUsuario);
                  }

              },
              error: function(xhr, errorString, exception) {
                  alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
              }
          });
      }//fin de else

}//fin comprobar si se puede borrar usuario
              
            
//comprobamos si el usuario tiene pedidos, si tiene no se puede borrar-29-11-13 desp de eliminacion viamed antiguo que creo problemas
function BorrarUsuario(accion, idUsuario){

  if(sinoSeBorraAsiMismoEnviarCambios('BORRARUSUARIO',usuarioAdministrador, idUsuario)){

    //si usuario tiene pedidos no se puede borrar
    jQuery.ajax({
        //cache:	false,
        url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/confirmEliminarUsuario.xsql',
        type:	"GET",
        data:	"IDUSUARIO="+idUsuario,
        //contentType: "application/xhtml+xml",
        success: function(objeto){
            var data = eval("(" + objeto + ")");

            //alert('succes data '+data.confirmEliminarUsuario.estado);
            //si tiene pedidos devuelve S
            if(data.confirmEliminarUsuario.estado == 'S'){

                alert(usuarioConPedidos);
            }
            //si no tiene pedidos envio cambios, elimino usuario
            else{ 
                //trozo que comprueba y elimina
                if(confirm(seguroEliminarUsuario)){
                  	document.forms[0].elements['IDUSUARIO'].value=idUsuario;
                  	EnviarCambios(accion, idUsuario);
              	}
             }
        },
        error: function(xhr, errorString, exception) {
            alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
        }
    });

  }
}

function EnviarCambios(accion, id)
{

  var centro_actual = document.forms[0].elements['IDCENTRO'].value;


    document.forms[0].elements['ACCION'].value=accion;
	//document.forms[0].elements['IDPRODUCTO'].value=idProducto;
	SubmitForm(document.forms[0]);


    //var laUrl=top.mainFrame.Trabajo.zonaTrabajo.location;
    //laUrl=String(laUrl);

    /*
     	si en zonaTrabajo esta cargado el Centro lo recargamos
    */

    //if(laUrl.match('LPLista.xsql') && laUrl.match('PL_ID='+pl_actual)){
      //top.mainFrame.areaTrabajo.zonaTrabajo.location.href='about:blank';
    //}

}
	  
	 

//funcion para evitar la eliminacion del usuario activo, el centro del usuario activo o la empresa del usuario activo 

function sinoSeBorraAsiMismoEnviarCambios(accion,idusuarioActivo, idUsuarioaeliminar){

  var msg='Imposible ejecutar accion';

  if(accion=='BORRAREMPRESA')
	msg=msgBorrarEmpresa;
  else
	if(accion=='BORRARCENTRO')
	  msg=msgBorrarCentro;
	else
	  if(accion=='BORRARUSUARIO')
	    msg=msgBorrarUsuario;

  if(accion!='BORRARUSUARIO'){
	for(var n=0;n<document.forms['Centros'].length;n++){
	  if(document.forms['Centros'].elements[n].name.match('IDUSUARIO_') && document.forms['Centros'].elements[n].value==idusuarioActivo){
	    alert(msg);
	    return false;
	  }   
	}
  }
  else{
	if(idusuarioActivo==idUsuarioaeliminar){
	  alert(msg);
	  return false;
	}
  }
  return true;
}


function NuevoUsuario()
{
  if(document.forms[0].elements['IDCENTRO'].value>0){
	  parent.areaTrabajo.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/USManten.xsql?EMP_ID='+document.forms[0].elements['IDEMPRESA'].value+'&ID_USUARIO=0&CEN_ID='+document.forms[0].elements['IDCENTRO'].value+'&GERENTECENTRO='+usuarioGerente;
  }
  else{
	alert(msgSinCentro);
  }
}


function EditarUsuario(url){
	var emp_id=document.forms[0].elements['IDEMPRESA'].value;  
	var objFrame=new Object();

	parent.areaTrabajo.location.href=url+'&EMP_ID='+emp_id;

}

function ListaCarpetasYPlantillasPorUsuario(idCentro)
{
  if(document.forms[0].elements['IDCENTRO'].value>0)
  {
	  parent.areaTrabajo.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/ListadoUsuarios.xsql?CEN_ID='+idCentro;
  }
}

function AsignarComerciales()
{
  if(document.forms[0].elements['IDNUEVAEMPRESA'].value>0)
  {
	  parent.areaTrabajo.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/AsignarComerciales.xsql?IDEMPRESA='+document.forms[0].elements['IDNUEVAEMPRESA'].value;
  }
}  

function Perfiles()
{
  if(document.forms[0].elements['IDNUEVAEMPRESA'].value>0)
  {
	  parent.areaTrabajo.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/PerfilesUsuarios.xsql?IDEMPRESA='+document.forms[0].elements['IDNUEVAEMPRESA'].value;
  }
}  

function ListadoEmpresas() 
{
   	parent.areaTrabajo.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/ListadoEmpresas.xsql?IDPAIS='+document.forms[0].elements['IDPAIS'].value;
} 

function ListadoCentros() 
{
   	parent.areaTrabajo.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/BuscadorCentros.xsql?IDPAIS='+document.forms[0].elements['IDPAIS'].value;
} 

function ListaTodosUsuarios()
{
	parent.areaTrabajo.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/ListadoCorreosUsuarios.xsql?IDPAIS='+document.forms[0].elements['IDPAIS'].value;
}

function ControlUsuarios() 
{
   	parent.areaTrabajo.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/ListaUsuariosControl.xsql?IDPAIS='+document.forms[0].elements['IDPAIS'].value;
} 

function FacturacionEspecial()	
{
   	parent.areaTrabajo.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/FacturacionEspecial.xsql?IDEMPRESA='+document.forms[0].elements['IDNUEVAEMPRESA'].value;
} 


function Comentarios()	
{
	parent.areaTrabajo.location.href='http://www.newco.dev.br/Compras/NuevaMultioferta/UltimosComentarios.xsql?IDEMPRESA='+document.forms[0].elements['IDEMPRESA'].value+'&IDCENTRO='+document.forms[0].elements['IDCENTRO'].value;
} 

function Circuitos()	
{
	parent.areaTrabajo.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CircuitosAprobacion.xsql?IDEMPRESA='+document.forms[0].elements['IDEMPRESA'].value;
} 

function LugaresEntrega()	
{
	parent.areaTrabajo.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/LugaresEntrega.xsql?IDEMPRESA='+document.forms[0].elements['IDEMPRESA'].value;
} 

//	25nov19 Mantenimiento de logotipos por centro
function Logotipos()	
{
	parent.areaTrabajo.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/Logotipos.xsql?IDEMPRESA='+document.forms[0].elements['IDEMPRESA'].value;
} 

//	27nov19 Mantenimiento de integración por centro
function Integracion()	
{
	parent.areaTrabajo.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/Integracion.xsql?IDEMPRESA='+document.forms[0].elements['IDEMPRESA'].value;
} 

//	Selecciones
function Selecciones()	
{
	parent.areaTrabajo.location.href='http://www.newco.dev.br/Gestion/EIS/EISSelecciones.xsql?IDEMPRESALISTA='+document.forms[0].elements['IDEMPRESA'].value;
} 

