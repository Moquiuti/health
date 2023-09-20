//	JS para ZonaProducto
//	Ultima revision: ET 3oct22 10:41 ZonaProducto2022_031022.js


function InsertarProducto(idProducto)
{ 
	var pl_actual = document.forms['envio'].elements['IDPLANTILLA'].value;
	if (pl_actual==-1)
	  	alert(msgSinPlantilla);
	else
	{
		EnviarCambios('INSERTARPRODUCTO', idProducto);
	}
}

function BorrarProducto(accion, idProducto){
  var objFrame=new Object();
  objFrame=obtenerFrame(top,'zonaPlantilla');
  //27mar08	ET	Los botones solo se muestran si el usuario tiene derecho a realizar la acción
  //if(objFrame.BorrarProducto())
  {
    var carp_id=document.forms['envio'].elements['IDCARPETA'].value;
    var pl_id=document.forms['envio'].elements['IDPLANTILLA'].value;
    document.location.href='ZonaProducto2022.xsql?IDCARPETA='+carp_id+'&IDPLANTILLA='+pl_id+'&IDPRODUCTO='+idProducto+'&ACCION='+accion;

    //   actualizamos los frames que esten cargados (plantilla del producto recien borrado)
      var objFrame=new Object();
      var laUrl;
      objFrame=obtenerFrame(top,'zonaTrabajo');
      if(objFrame!=null)
	  {
        laUrl=String(objFrame.location.href);
        if(laUrl.match('LPLista2022.xsql') && laUrl.match('PL_ID='+document.forms['envio'].elements['IDPLANTILLA'].value))
		{
     	  Refresh(objFrame);
     	}
      }
   }
}

function EnviarCambios(accion, idProducto)
{
  if(document.forms['envio'].elements['IDPLANTILLA'])
    var pl_actual = document.forms['envio'].elements['IDPLANTILLA'].value;
  if(document.forms['envio'].elements['IDCARPETA'])  
    var carp_actual = document.forms['envio'].elements['IDCARPETA'].value;


   document.forms['envio'].elements['ACCION'].value=accion;
document.forms['envio'].elements['IDPRODUCTO'].value=idProducto;


    var laUrl;
    var nombreFrame;
    var actualizarFrame=0;
    var frameARecargar='PaginaEnBlanco2022.xsql';

    if(top.mainFrame.areaTrabajo.zonaTrabajo){
      laUrl=top.mainFrame.areaTrabajo.zonaTrabajo.location;
      nombreFrame='zonaTrabajo';
    }
    else{
      if(top.mainFrame.areaTrabajo){
     	laUrl=top.mainFrame.areaTrabajo.location;
     	nombreFrame='areaTrabajo';
     	frameARecargar='AreaTrabajo2022.html';
      }
    }

    laUrl=String(laUrl);


    /*
     	si en el frame derecho esta cargada alguna pagina
     	que debemos que esta afectada por la accion a ejecutar (borrado de carpetas, plantillas o productos)
     	actualizamos este frame
    */

    /*
      alert('carpeta nueva: '+document.forms['envio'].elements['IDNUEVACARPETA'].value+'\n'
     	  +' plantilla nueva: '+document.forms['envio'].elements['IDNUEVAPLANTILLA'].value+'\n'
     	  +' accion: '+document.forms['envio'].elements['ACCION'].value+'\n'
     	  +' producto: '+document.forms['envio'].elements['IDPRODUCTO'].value);
     */ 




    /*
       a veces se produce un error de productos 
       duplicados en la plantilla, no sabemos si es un problema de oracle o de javascript
       en el campo FECHA enviamos los milisegundos a la hora de hacer el envio.

    */

    var miFecha=new Date();
    document.forms['envio'].elements['FECHA'].value=' los milisegundos: '+ miFecha.getMilliseconds();



    if(accion=='BORRARPRODUCTO'){
      if(laUrl.match('LPLista2022.xsql') && laUrl.match('PL_ID='+pl_actual)){
     	actualizarFrame=1;
      }
    }
    else{
      if(accion=='BORRARCARPETA'){
     	if(laUrl.match('CARPManten.xsql') && laUrl.match('CARP_ID='+carp_actual)){
     	  actualizarFrame=1; 
     	}
     	else{
     	  if(laUrl.match('PLManten2022.xsql')){
     	    actualizarFrame=1;
     	  }
     	  else{
     	    if(laUrl.match('LPLista2022.xsql')){
     	      actualizarFrame=1;
     	    }
     	  }
     	}
      } 
      else{
     	if(accion=='BORRARPLANTILLA'){
     	  if(laUrl.match('PLManten2022.xsql') && laUrl.match('PL_ID='+pl_actual)){
     	    actualizarFrame=1;
     	  }
     	  else{
     	    if(laUrl.match('LPLista2022.xsql') && laUrl.match('PL_ID='+pl_actual)){
     	      actualizarFrame=1;
     	    }
     	  }
     	}
      }
    }

    SubmitForm(document.forms['envio']);

    //  si hemos de recargar lo hacemos
    if(actualizarFrame)
      if(nombreFrame=='areaTrabajo')
     	top.mainFrame.areaTrabajo.location=frameARecargar;
      else
     	if(nombreFrame=='zonaTrabajo')
     	  top.mainFrame.areaTrabajo.zonaTrabajo.location=frameARecargar;	
}



function MostrarPlantilla(nombreFrame)
{

	//solodebug alert('nombreFrame:'+nombreFrame);

	if(parseInt(maxVisibles)>0)
	{
		if(parseInt(totalEnLaPlantilla)>parseInt(maxVisibles))
		{
		  if(confirm(msgMuchosProductosEnLaPlantilla))
		  {
			var objFrame=new Object();

     		objFrame=obtenerFrame(top,nombreFrame);
     		objFrame.MostrarPlantilla();
		  }
		}
		else{
			var objFrame=new Object();
			objFrame=obtenerFrame(top,nombreFrame);
			objFrame.MostrarPlantilla();
		}
	}
	else
	{
		var objFrame=new Object();
		objFrame=obtenerFrame(top,nombreFrame);
		objFrame.MostrarPlantilla();	
	}
}



/*
funcion para controlar que el producto que se quiere insertar no existe ya en la plantilla.
si existe se avisa al usuario y no se somete la accion

en caso contrario seguimos
*/

function sinoExisteEnPlantillaEnviarCambios(accion,idProducto){
var objFrame=new Object();

objFrame=obtenerFrame(top,'zonaPlantilla');

if(objFrame.existePlantilla>0)
{
if(objFrame.privilegiosPlantilla)
{
  for(var n=0;n<document.forms['productos'].length;n++)
  {
	if(document.forms['productos'].elements[n].name.match('PRODUCTO_') && document.forms['productos'].elements[n].value==idProducto)
	{
	  alert('El Producto que está intentando insertar ya existe en la Plantilla');
	  return;
	}   
  }
  InsertarProducto(idProducto);
}
else
{
  alert(objFrame.msgPrivilegiosProducto);
}
}
else
{
alert(objFrame.msgSinPlantilla);
}
}
