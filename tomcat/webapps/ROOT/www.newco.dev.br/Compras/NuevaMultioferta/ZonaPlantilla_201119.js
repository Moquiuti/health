//	funciones JS para "ZonaPlantilla" en "EnviarPedidos"
//	Ultima revision: ET 20nov19	13:50 ZonaPlantilla_201119.js


//		funcion para montar un desplegable dinamicamente: recibe el array y el valor por defecto
function montarDesplegable(arrayDatos, obj, defecto)
{
	obj.length=0;

	for(var n=0;n<arrayDatos.length;n++){
		if(defecto==arrayDatos[n][0]){
			// DC - 06/06/14 - Cambiamos la manera de informar los desplegables de plantillas para:
			//	1.- Aceptar ampersand (&) en nombres de plantillas
			//	2.- IE8 falla si no utilizamos la variable decoded de esta manera
			var decoded	= jQuery("<div/>").html('['+arrayDatos[n][1]+']').text();
			var addOption	= new Option(decoded,arrayDatos[n][0]);

			privilegiosPlantilla=arrayDatos[n][2];
			obj.options[obj.length]=addOption;
			obj.options[obj.length-1].selected=true;
		}else{
			// DC - 06/06/14 - Cambiamos la manera de informar los desplegables de plantillas para:
			//	1.- Aceptar ampersand (&) en nombres de plantillas
			//	2.- IE8 falla si no utilizamos la variable decoded de esta manera
			var decoded	= jQuery("<div/>").html(arrayDatos[n][1]).text();
			var addOption	= new Option(decoded,arrayDatos[n][0]);

			obj.options[obj.length]=addOption;
		}
	}
}

function EditarCarpeta(){
	var pl_id = document.forms[0].elements['IDCARPETA'].value;

	if (pl_id==-1)
		alert('No hay ninguna carpeta activa para consultar propiedades');
	else{
		var objFrame=new Object();
		objFrame=obtenerFrame(window.parent.frames[2],'areaTrabajo');
		objFrame.location.href='../NuevaMultioferta/CARPManten.xsql?CARP_ID='+pl_id+'&amp;BOTON=CABECERA';
	}
}

/* quitamos ya no se usa ninguna funcion para carpetas
function NuevaCarpeta(){
function BorrarCarpeta(){
*/

//
// Hacemos el cambio de la CARPETA ACTUAL.
function CambioCarpetaActual(){
	document.forms[0].elements['ACCION'].value='CAMBIOCARPETA';
	document.forms[0].elements['IDNUEVACARPETA'].value=document.forms[0].elements['IDCARPETA'].value;
	zonaProductosEnBlanco();
	SubmitForm(document.forms[0]);
}


//
// Hacemos el cambio de la PLANTILLA ACTUAL.
//
function CambioPlantillaActual(){
	CambioPlantilla();
}

function SeleccionarPlantillaDeLaCarpetaActual(nombreDesplegable,idPlantilla){
	for(var n=0;n<document.forms[0].elements[nombreDesplegable].length;n++){
		if(document.forms[0].elements[nombreDesplegable].options[n].value==idPlantilla){
			document.forms[0].elements[nombreDesplegable].options[n].selected=true;
			return true;
		}
	}
	return false;
}

function CambioPlantillaExterno(idPlantilla){
	if(SeleccionarPlantillaDeLaCarpetaActual('IDPLANTILLA',idPlantilla)){
		//montarDesplegable(arrayPlantillas, document.forms[0].elements['IDPLANTILLA'],idPlantilla);
		CambioPlantillaActual();
	}else{
		document.forms[0].elements['ACCION'].value='CAMBIOPLANTILLA';
		document.forms[0].elements['IDNUEVAPLANTILLA'].value=idPlantilla;
		zonaProductosEnBlanco();
		SubmitForm(document.forms[0]);
	}
}

function CambioPlantilla(){
/*
	nacho 14/11/2002
	recargamos la zonpaProductos en vez de someter el form
*/

	carp_id=document.forms[0].elements['IDCARPETA'].value;
	pl_id=document.forms[0].elements['IDPLANTILLA'].value;
	montarDesplegable(arrayPlantillas, document.forms[0].elements['IDPLANTILLA'],pl_id);

	CargarListaProductos(carp_id, pl_id,'','');
}

function EditarPlantilla(){
	var pl_id = document.forms[0].elements['IDPLANTILLA'].value;
	if (pl_id==-1)
		alert(document.forms['MensajeJS'].elements['MENS_SIN_PLANTILLA'].value);
	else{
		var objFrame=new Object();
		objFrame=obtenerFrame(window.parent.frames[2],'areaTrabajo');
		
		console.log('EditarPlantilla.Frame:'+objFrame.name);
		
		//objFrame.location.href='../Multioferta/PLManten.xsql?PL_ID='+pl_id+'&amp;BOTON=CABECERA';
		objFrame.location.href='http://www.newco.dev.br/Compras/NuevaMultioferta/AreaTrabajo.html';

		setTimeout(function(){
			//	Una vez cargada el areaTrabajop, mostramos la lista de productos de la plantilla
			objFrameHijo=obtenerFrame(objFrame,'zonaTrabajo');
			objFrameHijo.location.href='../Multioferta/PLManten.xsql?PL_ID='+pl_id;
		},100);
	}
}


//
//
// No dejamos borrar la última plantilla. De esta forma aseguramos que no nos quedamos
//  sin plantillas.
function BorrarPlantilla(){
	if(privilegiosPlantilla){
		var pl_actual = document.forms[0].elements['IDPLANTILLA'].value;

		if (pl_actual==-1)
			alert(document.forms['MensajeJS'].elements['MENS_SIN_PLANTILLA'].value);
		else{
			contestacion = confirm("¿Esta seguro de querer eliminar la plantilla?");
			if(!contestacion)
				return;
			else
				EnviarCambios('BORRARPLANTILLA', pl_actual);
            
			top.zonaPlantilla.location.reload();

		}
	}else{
		alert(document.forms['MensajeJS'].elements['NO_AUTORIZADO_BORRAR_PLANTILLA'].value);
	}
}

function CopiarPlantilla(pl_id){
	document.location.href='../Multioferta/PLManten.xsql?PL_ID='+pl_id+'&amp;BOTON=COPIAR';
}


function InsertarProducto(idProducto)
{
	var pl_actual = document.forms[0].elements['IDPLANTILLA'].value;
	if (pl_actual==-1)
		alert(document.forms['MensajeJS'].elements['MENS_SIN_PLANTILLA'].value);
	else{
		EnviarCambios('INSERTARPRODUCTO', idProducto);
	}
}

function BorrarProducto()
{
	if(privilegiosPlantilla){
		if(confirm('¿Esta seguro de querer eliminar el Producto?'))
			return true;
	}else{
		alert(document.forms['MensajeJS'].elements['NO_AUTORIZADO_MODIFICAR_PLANTILLA'].value);
		return false;
	}
}

function EnviarCambios(accion, idObjeto)
{

	if(document.forms[0].elements['IDPLANTILLA'])
		var pl_actual = document.forms[0].elements['IDPLANTILLA'].value;
		if(document.forms[0].elements['IDCARPETA'])
			var carp_actual = document.forms[0].elements['IDCARPETA'].value;

			if(accion=='BORRARPRODUCTO'){
				document.forms[0].elements['IDPRODUCTO'].value=idObjeto;
			}else{
				if(accion=='BORRARPLANTILLA'){
					document.forms[0].elements['IDNUEVAPLANTILLA'].value=idObjeto;
				}else{
					if(accion=='BORRARCARPETA'){
						document.forms[0].elements['IDNUEVACARPETA'].value=idObjeto;
					}
				}
			}

			document.forms[0].elements['ACCION'].value=accion;
			//document.forms[0].elements['IDPRODUCTO'].value=idObjeto;

			var laUrl;
			var nombreFrame;
			var actualizarFrame=0;
			var frameARecargar='PaginaEnBlanco.xsql';

			if(top.mainFrame.areaTrabajo.zonaTrabajo){
				laUrl=top.mainFrame.areaTrabajo.zonaTrabajo.location;
				nombreFrame='zonaTrabajo';
			}else{
				if(top.mainFrame.areaTrabajo){
					laUrl=top.mainFrame.areaTrabajo.location;
					nombreFrame='areaTrabajo';
					frameARecargar='AreaTrabajo.html';
				}
			}

			laUrl=String(laUrl);

/*
			si en el frame derecho esta cargada alguna pagina
			que esta afectada por la accion a ejecutar (borrado de carpetas, plantillas o productos)
			actualizamos este frame

			a veces se produce un error de productos
			duplicados en la plantilla, no sabemos si es un problema de oracle o de javascript
			en el campo FECHA enviamos los milisegundos a la hora de hacer el envio.
*/

			var miFecha=new Date();
			document.forms[0].elements['FECHA'].value=' los milisegundos: '+ miFecha.getMilliseconds();

			if(accion=='BORRARPRODUCTO'){
				if(laUrl.match('LPLista.xsql') && laUrl.match('PL_ID='+pl_actual)){
					//MostrarPlantilla();
					actualizarFrame=1;
				}
			}else{
				if(accion=='BORRARCARPETA'){
					if(laUrl.match('CARPManten.xsql') && laUrl.match('CARP_ID='+carp_actual)){
						actualizarFrame=1;
					}else{
						if(laUrl.match('PLManten.xsql')){
							actualizarFrame=1;
						}else{
							if(laUrl.match('LPLista.xsql')){
								actualizarFrame=1;
							}
						}
					}
				}else{
					if(accion=='BORRARPLANTILLA'){
						if(laUrl.match('PLManten.xsql') && laUrl.match('PL_ID='+pl_actual)){
							actualizarFrame=1;
						}else{
							if(laUrl.match('LPLista.xsql') && laUrl.match('PL_ID='+pl_actual)){
								actualizarFrame=1;
							}
						}
					}
				}
			}
			zonaProductosEnBlanco();
			SubmitForm(document.forms[0]);

			//	si hemos de recargar lo hacemos aqui
			if(actualizarFrame)
				if(nombreFrame=='areaTrabajo'){
					var objFrame=new Object();
					objFrame=obtenerFrame(top,'areaTrabajo');
					objFrame.location=frameARecargar;
				}else{
					if(nombreFrame=='zonaTrabajo'){
						var objFrame=new Object();
						objFrame=obtenerFrame(top,'zonaTrabajo');
						objFrame.location=frameARecargar;
					}
				}
}

function zonaProductosEnBlanco(){
	var objFrame=new Object();
	objFrame=obtenerFrame(top,'zonaProducto');
	objFrame.location.href='about:blank';
}

function MostrarPlantilla(){

	var pl_id = document.forms[0].elements['IDPLANTILLA'].value;
	if (pl_id==-1)
		alert(document.forms['MensajeJS'].elements['MENS_SIN_PLANTILLA'].value);
	else{
		var objFrame=new Object();

		//	Se actualiza el areaTrabajo para mostrar el buscador
		//20nov19 objFrame=obtenerFrame(top,'areaTrabajo');
		objFrame=obtenerFrame(window.parent.frames[2],'areaTrabajo');
		
		console.log('MostrarPlantilla.Frame:'+objFrame.name);
		
		objFrame.location.href='http://www.newco.dev.br/Compras/NuevaMultioferta/AreaTrabajo.html';

		setTimeout(function(){
			//	Una vez cargada el areaTrabajop, mostramos la lista de productos de la plantilla
			objFrameHijo=obtenerFrame(objFrame,'zonaTrabajo');
			objFrameHijo.location.href='http://www.newco.dev.br/Compras/Multioferta/LPLista.xsql?PL_ID='+pl_id;		//20nov19	+'&SES_ID='+document.forms[0].elements['SES_ID'].value;
		},100);

	}
}


//prueba clubVipLimpieza   funciona dejamos esta                         
function PrepararOfertaPedido(tipo)
{

	var pl_id = document.forms[0].elements['IDPLANTILLA'].value;

	var objFrame=new Object();
	objFrame=obtenerFrame(window.parent.frames[1],'zonaProducto');
	var productos = objFrame.document.forms[0].elements['PRODUCTOS'].value;


	if (pl_id==-1)
		alert(document.forms['MensajeJS'].elements['MENS_SIN_PLANTILLA'].value);
	else if (productos==-1)
		alert(document.forms['MensajeJS'].elements['PLANTILLA_SIN_PRODUCTOS'].value);
	else{
		if(tipo=='EDICION'){
			var objFrame=new Object();
                                     //alert(' mmm 1'+window.parent.frames[2].name+window.parent.frames[2]);
			objFrame=obtenerFrame(window.parent.frames[2],'areaTrabajo');
			objFrame.location.href='../Multioferta/LPAnalizarFrame.xsql?PL_ID='+pl_id+'&SES_ID='+document.forms[0].elements['SES_ID'].value+'&ACCION='+tipo;
		}else{
			var objFrame=new Object();
			objFrame=obtenerFrame(window.parent.frames[2],'areaTrabajo');
			objFrame.location.href='../Multioferta/LPAnalizarFrame.xsql?PL_ID='+pl_id+'&SES_ID='+document.forms[0].elements['SES_ID'].value+'&ACCION='+tipo;
		}
	}
}



/*
funcion para controlar que el producto que se quiere insertar no existe ya en la plantilla.
si existe se avisa al usuario y no se somete la accion
en caso contrario seguimos
*/

function sinoExisteEnPlantillaEnviarCambios(accion,idProducto){
	if(existePlantilla>0){
		if(privilegiosPlantilla){
			for(var n=0;n<document.forms['plantillas'].length;n++){
				if(document.forms['plantillas'].elements[n].name.match('PRODUCTO_') && document.forms['plantillas'].elements[n].value==idProducto){
					alert(document.forms['MensajeJS'].elements['PRODUCTO_YA_EXISTE'].value);
					return;
				}
			}
			InsertarProducto(idProducto);
		}else{
			alert(document.forms['MensajeJS'].elements['NO_AUTORIZADO_MODIFICAR_PLANTILLA'].value);
		}
	}else{
		alert(document.forms['MensajeJS'].elements['MENS_SIN_PLANTILLA'].value);
	}
}

//	Presenta la lista de todas las carpetas y plantillas
function ListarCarpetasYPlantillas(){
	var objFrame=new Object();
	objFrame=obtenerFrame(top,'areaTrabajo');
	objFrame.location.href='CarpetasYPlantillasFrame.html';
}

//	Presenta la lista de todos los productos incluidos en plantillas
function ListarProductosPlantillas(){
	var objFrame=new Object();
	objFrame=obtenerFrame(window.parent.frames[2],'areaTrabajo');
	objFrame.location.href='ProductosEnPlantillasFrame.html';
}

//	Presenta la lista de todos los productos incluidos en plantillas
function PlantillasPorUsuario(){
	var objFrame=new Object();
	objFrame=obtenerFrame(window.parent.frames[2],'areaTrabajo');
	objFrame.location.href='PlantillasPorUsuarioFrame.html';
}

function CargarListaProductos(idCarpeta, idPlantilla, idProducto, accion){
	var objFrame=new Object();
	objFrame=obtenerFrame(window.parent.frames[1],'zonaProducto');
	objFrame.location.href='http://www.newco.dev.br/Compras/NuevaMultioferta/ZonaProducto.xsql?IDCARPETA='+idCarpeta+'&IDPLANTILLA='+idPlantilla+'&IDPRODUCTO='+idProducto+'&ACCION='+accion;
}

//funcion para cambiar categoria de productos, farmacia o normales
function cambioCategoria(accion,cat){
	//alert('cat '+cat);
	//alert(document.forms[0].elements['IDNUEVACARPETA'].value);
	//alert(document.forms[0].elements['IDNUEVAPLANTILLA'].value);
	//alert(document.forms[0].elements['IDPRODUCTO'].value);
	//alert(document.forms[0].elements['FECHA'].value);
	document.forms[0].elements['CATEGORIA'].value = cat;
	document.forms[0].elements['ACCION'].value=accion;
	var laUrl;
	var nombreFrame;
	var actualizarFrame=0;
	var frameARecargar='PaginaEnBlanco.xsql';

	if(top.mainFrame.areaTrabajo.zonaTrabajo){
		laUrl=top.mainFrame.areaTrabajo.zonaTrabajo.location;
		nombreFrame='zonaTrabajo';
	}else{
		if(top.mainFrame.areaTrabajo){
			laUrl=top.mainFrame.areaTrabajo.location;
			nombreFrame='areaTrabajo';
			frameARecargar='AreaTrabajo.html';
		}
	}

	laUrl=String(laUrl);

	var miFecha=new Date();
	document.forms[0].elements['FECHA'].value=' los milisegundos: '+ miFecha.getMilliseconds();

	zonaProductosEnBlanco();
	SubmitForm(document.forms[0]);
}



