// JavaScript Document
//	MC	09-09-11 10.49

jQuery(document).ready(globalEvents);

function globalEvents(){
	//associo enter boton a funcion para buscar
	jQuery(document).keypress(function(e){
		if(e.keyCode == 13)
			EnviarBusqueda();
	});

	//proBuscador
	jQuery("#verClientes").mouseover(function(){	this.style.cursor="pointer";	});
	jQuery("#verClientes").mouseout(function(){	this.style.cursor="default";	});
	jQuery("#verClientes").click(function(){
		if(document.getElementById('listaClientes').style.display == 'none')
			jQuery("#listaClientes").show();
		else
			jQuery("#listaClientes").hide();
	});

	//seleccionar todos los clientes
	jQuery("#selTodosClientes").mouseover(function(){	this.style.cursor="pointer";	});
	jQuery("#selTodosClientes").mouseout(function(){	this.style.cursor="default";	});
	jQuery("#selTodosClientes").click(function(){
		if(document.getElementById('listaClientes').style.display != 'none')
			 SeleccionarTodos();
	});
	
	//elinar ordenacion por precio, provee...
	jQuery("#elimOrdenacion").mouseover(function(){	this.style.cursor="pointer";	});
	jQuery("#elimOrdenacion").mouseout(function(){	this.style.cursor="default";	});
	jQuery("#elimOrdenacion").click(function(){
		var formu = document.forms['formBusca'];
		formu.elements['ORDEN'].value = '';
		formu.elements['SENTIDO'].value = '';

		if(document.forms['formBusca'])
			formu.elements['PAGINA'].value = document.forms['formBusca'].elements['PAGINA'].value;

		formu.action = 'PROBuscador.xsql';
		SubmitForm(formu);
	});
}//fin de globalEvents

//var msg_SinCriterios = 'Introduzca algún criterio de busqueda antes de buscar. \nGracias.';
//var msg_DemasiadosCriteriosDefault = 'El criterio de búsqueda en el campo: \"';
//var msg_DemasiadosCriteriosExtra_1 = '\" contiene demasiadas palabras.\nEl máximo de palabras es de 5.\n\n    * Pulse \'Aceptar\' para enviar \"';
//var msg_DemasiadosCriteriosExtra_2 = '\"\n\n    * Pulse \'Cancelar\' para modificar los criterios manualmente.';
//var msgSinProveedor='Seleccione el proveedor para el que quiere realizar la busqueda.';
//var msgExpansion='Ha marcado algún producto para que se expandan sus precios. ¿Continuar con la expansión?';
//var msgExpandidosNulos='Alguno de los precios marcados para expandirse está vacío. Esta opción no está permitida. Desmarque la casilla o introduzca el precio. Gracias';

//elimina solicitud rechazada de lista rechazadas
function EliminaSolicitud(idprod){
	var form = document.forms['formResultados'];

	form.elements['ELIMINAR_SOLICITUD'].value = 'SI';
	form.elements['IDPRODUCTO_SOLICITUD'].value = idprod;

	SubmitForm(form);
}//fin alarma solicitud

//alarmas solicitudes, si solicitudes ya estan en acto el usuario no puede solicitar de nuevo
function AlarmaSolicitud(tipo){
	if(tipo == 'P')
		alert(document.forms['MensajeJS'].elements['SOLICITUD_PENDIENTE'].value);

	if(tipo == 'D')
		alert(document.forms['MensajeJS'].elements['SOLICITUD_DEVUELTA'].value);
}//fin alarma solicitud

/*eliminar imgenes X*/
function Eliminar(){
	alert(document.forms['MensajeJS'].elements['SEGURO_ELIMINAR_IMAGEN'].value);
}

function Linka(pag){
	parent.frames['zonaTrabajo'].document.location.href=pag;
}

function Busqueda(formu,accion){
	//el formulario de Productos que contiene el numero de pagina no existe en la primera busqueda
	if(document.forms['formBusca'])
		formu.elements['PAGINA'].value = document.forms['formBusca'].elements['PAGINA'].value;

	AsignarAccion(formu,accion);
	formu.action = 'PROResultados.xsql';
	// Ejecutamos la funcion que muestra el loading...
	window.parent.showLoading();
	SubmitForm(formu);
}

//si pico a la referencia se me queda solo este producto en el buscador
function soloUnProd(ref){
	document.forms['formResultados'].elements['PRODUCTO'].value = ref;
	Busqueda(document.forms['formResultados'],'PROResultados.xsql');
}

// Permite manipular los checkbox como si fueran 'Radio'
function ValidarCheckBox(formu,seleccionado){
	for(var i=0;i<formu.elements.length;i++){
		if(formu.elements[i].type=="checkbox")
			if (formu.elements[i].name != seleccionado)
				formu.elements[i].checked=false;
			else
				formu.elements[i].checked=true;
	}

	// Por defecto buscamos productos.
	formu.elements['LLP_LISTAR'].value = 'PRO';

	if(seleccionado == 'BuscarProveedores')
		formu.elements['LLP_LISTAR'].value = 'EMP';
}

function handleKeyPress(e){
	var keyASCII;

	if(navigator.appName.match('Microsoft'))
		keyASCII=event.keyCode;
	else
		keyASCII = (e.which);

	if(keyASCII == 13)
		EnviarBusqueda();
}

// Asignamos la función handleKeyPress al evento
if(navigator.appName.match('Microsoft')==false)
	document.captureEvents();
document.onkeypress = handleKeyPress;

//
//	Hacemos el cambio de la PLANTILLA ACTUAL.
//
function CambioPlantilla(pl_id){
	parent.location.href='../NuevaMultioferta/CambioPlantilla.xsql?PL_ID='+pl_id;
}

function CambioPagina(sentido){
	var oForm	= document.forms['ReloadForm'];
	oForm.action	= 'PROResultados.xsql';

	if(isAdmin == 'S'){	
		if(!confirm(confirmPag)){
			return;
		}
	}

	if(sentido == 'SIGUIENTE')
		oForm.elements['PAGINA'].value	= parseInt(oForm.elements['PAGINA'].value)+1;
	else if(sentido == 'ANTERIOR')
		oForm.elements['PAGINA'].value	= parseInt(oForm.elements['PAGINA'].value)-1;

	// Ejecutamos la funcion que muestra el loading...
	window.parent.showLoading();
	SubmitForm(oForm);	
}
//
//	Guarda en el campo oculto CAMBIOS el contenido de los campos editables por el usuario
//	en formato (ID, UnidadBasica, UnidadesPorLote, Precio)
//
//	y envia el formulario
//
function Enviar(formu, Accion){
	formOrigen= document.forms['formResultados'];
	var Msg='';

	if(Accion=='ANTERIOR'){	//	Guarda resultados y retrocede a la pagina anterior
		formOrigen.elements['PAGINA'].value	= parseInt(formOrigen.elements['PAGINA'].value)-1;
	}else if(Accion=='SIGUIENTE'){	//	Guarda resultados y avanza a la pagina siguiente
		formOrigen.elements['PAGINA'].value	= parseInt(formOrigen.elements['PAGINA'].value)+1;
	}else{				//	Guarda resultados y actualiza la pagina actual
		formOrigen.elements['PAGINA'].value	= formOrigen.elements['PAGINA'].value;
	}

	//Seleccion de uno o mas clientes
	var idClientes = '';
	//cambios o para un solo cliente o para varios
	if(document.getElementById('listaClientes') && document.getElementById('listaClientes').style.display != 'none'){
		var lun = document.forms['formResultados'].length;
		var formPro = document.forms['formResultados'];
		for(var i=0;i<lun;i++){
			var k = formPro.elements[i].name;

			if(k.substr(0,8)=='CLIENTE_'){
				//si hay mas de un producto
				if(formPro.elements['UN_PRODUCTO'].value == 'NO'){
					if(formPro.elements[i].checked == true)
						idClientes += formPro.elements[i].value+'|?#';
				}
				//si hay un solo producto
				if(formPro.elements['UN_PRODUCTO'].value == 'SI'){
					var idCli = Piece(formPro.elements[i].name,'_','1');

					var original = 'DESTACADO_ORIGINAL_'+idCli;

					try{
						var valueOriginal = formPro.elements['DESTACADO_ORIGINAL_'+idCli].value;

						//si antes era destacado y ahora no checkeado paso N
						if(valueOriginal == 'S' && formPro.elements[i].checked == false)
							idClientes += formPro.elements[i].value+'|N#';

						//si antes no destacado y ahora checked paso S
						if(valueOriginal == '' && formPro.elements[i].checked == true)
							idClientes += formPro.elements[i].value+'|S#';

					}catch(err){
						alert(document.forms['MensajeJS'].elements['ERROR_CON_CLIENTE'].value+formPro.elements[i].name+document.forms['MensajeJS'].elements['IDCLIENTE'].value+ ' ' +idCli);
					}
				}
			}//fin if k.match cliente_
		}
		document.forms['formResultados'].elements['IDCLIENTES'].value = idClientes;
	}else{	//else de if inicial, si listaClientes esta abierta cojo de alla si no del desplegable, cliente actual.
		idClientes= document.forms['formResultados'].elements['ID_CLIENTE_ACTUAL'].value+'|?#';
		document.forms['formResultados'].elements['IDCLIENTES'].value = idClientes;
	}	//fin para mas clientes

	var idClienteActual= document.forms['formResultados'].elements['ID_CLIENTE_ACTUAL'].value;
	var avisarExpansion=0;
	var hayNulosExpandidos=0;

	if(document.forms['formResultados'].elements['ADMIN_MVM'].value == 'si'){
		for(var j=0;j<formOrigen.length;j++){
			if(formOrigen.elements[j].name.substring(0,13)=='UNIDADBASICA_'){
				var IDProducto=obtenerId(formOrigen.elements[j].name);
				var Basica=formOrigen.elements['UNIDADBASICA_'+IDProducto].value;
                                var PorCajaOld=formOrigen.elements['UNIDADESPORLOTE_'+IDProducto+'_OLD'].value;
				var PorCaja=formOrigen.elements['UNIDADESPORLOTE_'+IDProducto].value;
                                var IDtipoIVAOld=formOrigen.elements['IDTIPOIVA_'+IDProducto+'_OLD'].value;
				var IDtipoIVA=formOrigen.elements['IDTIPOIVA_'+IDProducto].value;
				var Precio=formOrigen.elements['TARIFA_'+IDProducto].value;
                                var MarcaOld=formOrigen.elements['MARCA_'+IDProducto+'_OLD'].value;
				var Marca=formOrigen.elements['MARCA_'+IDProducto].value;
				var Borrar=formOrigen.elements['BORRAR_'+IDProducto].checked;
				var Copiar=formOrigen.elements['COPIAR_'+IDProducto].checked;	
				var Expandir=formOrigen.elements['EXPANDIR_'+IDProducto].checked;

				if(formOrigen.elements['DESTACAR_'+IDProducto].checked == true)
					var Destacar='S';
				else
					var Destacar='N';

				if(formOrigen.elements['OCULTAR_'+IDProducto].checked == true)
					var Ocultar='S';
				else
					var Ocultar='N';

				if(formOrigen.elements['EXPANDIR_'+IDProducto].checked==true && idClienteActual==1){
					avisarExpansion=1;

					if(formOrigen.elements['TARIFA_'+IDProducto].value=='')
						hayNulosExpandidos=1;
				}
                               //envio las lineas de producto solo si se ha cambiado algo, así más rapido
                                if (PorCaja != PorCajaOld || IDtipoIVA != IDtipoIVAOld || Marca != MarcaOld || Borrar === true || Copiar === true){
                                    Msg=Msg+IDProducto+'|'+Marca+'|'+Basica+'|'+PorCaja+'|'+IDtipoIVA+'|'+Precio+'|'+Borrar+'|'+Copiar+'|'+Expandir+'|'+Destacar+'|'+Ocultar+'#';
                                  //alert('msg '+Msg);
                                }

				//Msg=Msg+IDProducto+'|'+Marca+'|'+Basica+'|'+PorCaja+'|'+IDtipoIVA+'|'+Precio+'|'+Borrar+'|'+Copiar+'|'+Expandir+'|'+Destacar+'|'+Ocultar+'#';
                                
			}
		}
	}//fin if admin mvm

	if(avisarExpansion){
		if(hayNulosExpandidos)
			alert(document.forms['MensajeJS'].elements['EXPANDIDOS_NULOS'].value);
		else{
			if(confirm(document.forms['MensajeJS'].elements['DESEA_EXPANDIR_PRECIOS'].value)){
				formOrigen.elements['CAMBIOS'].value=Msg;
				// Ejecutamos la funcion que muestra el loading...
				window.parent.showLoading();
				SubmitForm(formOrigen);
			}
		}
	}else{
		formOrigen.elements['CAMBIOS'].value=Msg;
		// Ejecutamos la funcion que muestra el loading...
		window.parent.showLoading();
		SubmitForm(formOrigen);
	}
}	

function AceptarCambios(){
	formu= document.forms['formResultados'];
	var Msg='';

	for(var j=0;j<formu.length;j++){
		var k = formu.elements[j].name;
		//if(k.match('IDPROD')){
		if (k.substring(0,7) == 'IDPROD_'){
			//alert('mi ' +formu.elements[j].value +' name ' +formu.elements[j].name);
			var IDProducto=formu.elements[j].value;
			var Aceptar=formu.elements['ACEPTAR_'+IDProducto].checked;
			var Cancelar=formu.elements['CANCELAR_'+IDProducto].checked;
			var Comentario= formu.elements['COMENTARIO_'+IDProducto].value;
		}

		if(Aceptar == true){
			if(Msg.match(IDProducto)){ }//si ya esta el idprod no guardo de nuevo
			else{	Msg=Msg+IDProducto+'|A|'+Comentario+'#';}
		}else if(Cancelar == true){
			if(Msg.match(IDProducto)){ }//si ya esta el idprod no guardo de nuevo
			else{ Msg=Msg+IDProducto+'|C|'+Comentario+'#'; }
		}
	}

	formu.elements['CAMBIOS_PROVE'].value=Msg;
	formu.action = 'PROCambiosProveSave.xsql';

	SubmitForm(formu);
}

function esEntero(obj){
	if(obj.value == ""){
		alert(document.forms['MensajeJS'].elements['INTRODUZCA_CANTIDAD'].value);
		obj.focus();
	}else{
		if(obj.value < 0 || isNaN(obj.value)){
			alert(document.forms['MensajeJS'].elements['INTRODUZCA_CANTIDAD_CORRECTA'].value);
			obj.focus();
		}
	}

	if(!isNaN(obj.value)){
		var comas=0, puntos=0;

		for(var n=0;n<obj.value.length;n++){
			if(obj.value.substring(n,n+1)=='.')
				puntos++;
			else
				if(obj.value.substring(n,n+1)==',')
					comas++;
		}

		if(puntos)
			obj.value=quitaPuntos(obj.value);

		if(comas)
			obj.value=quitaComas(obj.value);
	}
}

function esNulo(obj){
	if(obj.value == ""){
		alert(document.forms['MensajeJS'].elements['INTRODUZCA_UNIDAD_BASE'].value);
		obj.focus();
	}
}

function validarCampos(){
/*
	for(var n=0;n<document.forms['Productos'].length;n++){
		if(document.forms['Productos'].elements[n].name.match('UNIDADBASICA_')){
			if(esNulo(document.forms['Productos'].elements[n].value)){
				return false;
			}
		}else{
			if(document.forms['Productos'].elements[n].name.match('UNIDADESPORLOTE_')){
				if(esNulo(document.forms['Productos'].elements[n].value) || !esEntero(document.forms['Productos'].elements[n].value)){
					return false;
				}
			}else{
				if(document.forms['Productos'].elements[n].name.match('TARIFA_')){
					if(!esFloat(document.forms['Productos'].elements[n].value)){
						return false;
					}
				}
			}
		}
	}
*/
	return true;
}

function recargarPagina(valor){
    
        
    
	if(document.forms['formBusca'].elements['HAYPRODUCTOS'].value!='S'){
		document.forms['formBusca'].elements['PRODUCTO'].value=valor;
		document.forms['formBusca'].elements['HAYPRODUCTOS'].value='S';
		Enviar(document.forms[1],document.forms[0]);
	}
}

function EnviarBusqueda(){
	document.forms['formBusca'].elements['PAGINA'].value=0;

	if(LimitarCantidadPalabras(document.forms['formBusca'].elements['PRODUCTO'],5)){
		if(isMVM == 'S'){
			if(document.forms['formBusca'].elements['PRODUCTO'].value == '' && document.forms['formBusca'].elements['FIDPROVEEDOR'].value == '0' && document.forms['formBusca'].elements['IDCLIENTE'].value == '-1'){
				//if(confirm(document.forms['MensajeJS'].elements['TEXT_BUSCA_CONFIRM'].value))
					Busqueda(document.forms[0],'./PROResultados.xsql');
			}else
				Busqueda(document.forms[0],'./PROResultados.xsql');
		}else
			Busqueda(document.forms[0],'./PROResultados.xsql');
        }
}

function LimitarCantidadPalabras(obj, numPalabras){
	var nombreCampo,numEspacios=0;

	if(obj.name=='PRODUCTO')
		nombreCampo='Producto';

	obj.value=quitarEspacios(obj.value);

	for(var n=0;n<obj.value.length;n++){
		if(obj.value.substring(n,n+1)==' ')
			numEspacios++;

		if(numEspacios>=numPalabras){
			var cadTemp=obj.value.substring(0,n);

			if(confirm(document.forms['MensajeJS'].elements['CRITERIO_BUSQUEDA'].value + nombreCampo + document.forms['MensajeJS'].elements['CRITERIO_BUSQUEDA_TEXT'].value +'\n'+ document.forms['MensajeJS'].elements['CRITERIO_BUSQUEDA_TEXT1'].value + '\n\n'+ document.forms['MensajeJS'].elements['CRITERIO_BUSQUEDA_TEXT2'].value +cadTemp+document.forms['MensajeJS'].elements['CRITERIO_BUSQUEDA_TEXT3'].value)){
				obj.value=obj.value.substring(0,n);
				return true;
			}else{
				return false;
			}
		}
	}
	return true;
}

function MantenimientoProductos(laUrl){
	document.location.href=laUrl;
}

function obtenerHistoria(){
	var Historia= document.forms['formResultados'].elements['HISTORY'].value;

	if(Historia=='')
		return history.length;
	else
		return Historia;
}

function ExpandirNOExpandir(form,obj,origen){
	var id=obtenerId(obj.name);

	if(obj.checked==false){
		//form.elements['TARIFA_'+id].disabled=false;
		form.elements['TARIFA_'+id].className='normal';
		form.elements['TARIFA_'+id].onfocus='';
		if(origen=='MVM')
			form.elements['TARIFA_'+id].value=form.elements['BACKUPTARIFA_'+id].value;
		else
			form.elements['TARIFA_'+id].value=form.elements['TARIFAHISTORICA_'+id].value;
	}else{
		//form.elements['TARIFA_'+id].disabled=true;
		form.elements['TARIFA_'+id].className='deshabilitado';
		form.elements['TARIFA_'+id].onfocus=eval('blurPrecio_'+id);
		if(origen=='MVM')
			form.elements['TARIFA_'+id].value=form.elements['TARIFAPRIVADAMVM_'+id].value;
		else
			form.elements['TARIFA_'+id].value=form.elements['BACKUPTARIFA_'+id].value;
	}
}
	
var siguienteCambioExpansion=1;

function inicializarExpandirTodos(form){
	var estado=0;

	for(var n=0;n<form.length&&!estado;n++){
		if(form.elements[n].name.substring(0,9)=='EXPANDIR_')
			if(form.elements[n].checked==false)
				estado=1;
	}

	siguienteCambioExpansion=estado;
}

function ExpandirNOExpandirTodos(form){
	for(var n=0;n<form.length;n++){
		if(form.elements[n].name.substring(0,9)=='EXPANDIR_'){
			if(siguienteCambioExpansion==1)
				form.elements[n].checked=false;
			else
				form.elements[n].checked=true;

			form.elements[n].click();
		}
	}

	if(siguienteCambioExpansion==1)
		siguienteCambioExpansion=0;
	else
		siguienteCambioExpansion=1;
}

//Si se pulsa "aceptar", fuerza "Cancelar" a NO y viceversa
function RevisarOpciones(formu, idprod, boton){
	if((boton=='ACEPTAR')&&(formu.elements['ACEPTAR_'+idprod].checked == true))
		formu.elements['CANCELAR_'+idprod].checked = false;

	if((boton=='CANCELAR')&&(formu.elements['CANCELAR_'+idprod].checked == true))
		formu.elements['ACEPTAR_'+idprod].checked = false;
}

//ordenar por
function OrdenarPor(Orden){
	var form=document.forms['formResultados'];

	form.elements['PAGINA'].value = '0';

	if(form.elements['ORDEN'].value==Orden)
		if(form.elements['SENTIDO'].value=='ASC')	form.elements['SENTIDO'].value='DESC';
		else						form.elements['SENTIDO'].value='ASC';
	else{
		form.elements['ORDEN'].value=Orden;
		form.elements['SENTIDO'].value='ASC';
	}

	AplicarFiltro();
}

function AplicarFiltro(){
	var form=document.forms['formResultados'];

	form.action='PROResultados.xsql';
	// Ejecutamos la funcion que muestra el loading...
	window.parent.showLoading();

	SubmitForm(form);
}

function SeleccionarTodos(){
	var formu = document.forms['formBusca'];
	var Estado=null;

	for(var i=0;(i<formu.length)&&(Estado==null);i++){
		var k=formu.elements[i].name;

		if(k.substr(0,8)=='CLIENTE_')
			if(formu.elements[i].checked == true)
				Estado=false;
			else
				Estado=true;
	}

	for(i=0;i<formu.length;i++){
		k=formu.elements[i].name;

		if(k.substr(0,8)=='CLIENTE_')
			formu.elements[i].checked = Estado;
	}
}

function SelTodosDestacados(){
	var formu = document.forms['formBusca'];
	var Estado=null;

	for(var i=0;(i<formu.length)&&(Estado==null);i++){
		var k=formu.elements[i].name;

		if(k.substr(0,9)=='DESTACAR_')
			if(formu.elements[i].checked == true)
				Estado=false;
			else
				Estado=true;
	}

	for(i=0;i<formu.length;i++){
		k=formu.elements[i].name;

		if(k.substr(0,9)=='DESTACAR_')
			formu.elements[i].checked = Estado;
	}
}

function SelTodosBorrar(){
	var formu = document.forms['formResultados'];
	var Estado=null;

	for(var i=0;(i<formu.length)&&(Estado==null);i++){
		var k=formu.elements[i].name;

		if(k.substr(0,7)=='BORRAR_')
			if (formu.elements[i].checked == true)
				Estado=false;
			else
				Estado=true;
	}

	for(i=0;i<formu.length;i++){
		k=formu.elements[i].name;

		if(k.substr(0,7)=='BORRAR_')
			formu.elements[i].checked = Estado;
	}
}

function SelTodosOcultos(){
	var formu = document.forms['formBusca'];
	var Estado=null;

	for(var i=0;(i<formu.length)&&(Estado==null);i++){
		var k=formu.elements[i].name;

		if(k.substr(0,8)=='OCULTAR_')
			if(formu.elements[i].checked == true )
				Estado=false;
			else
				Estado=true;
	}

	for(i=0;i<formu.length;i++){
		k=formu.elements[i].name;

		if(k.substr(0,8)=='OCULTAR_')
			formu.elements[i].checked = Estado;
	}
}

//selecionar todos para aceptar solecitud del proveedor
function SelTodosAceptar(){
	var formu = document.forms['formResultados'];
	var Estado=null;

	for(var i=0;(i<formu.length)&&(Estado==null);i++){
		var k=formu.elements[i].name;

		if(k.substr(0,8)=='ACEPTAR_')
			if(formu.elements[i].checked == true )
				Estado=false;
			else
				Estado=true;
	}

	for(i=0;i<formu.length;i++){
		k=formu.elements[i].name;

		if(k.substr(0,8)=='ACEPTAR_')
			formu.elements[i].checked = Estado;
	}
}

//selecionar todos para cancelar solecitud del proveedor
function SelTodosCancelar(){
	var formu = document.forms['formResultados'];
	var Estado=null;

	for(var i=0;(i<formu.length)&&(Estado==null);i++){
		var k=formu.elements[i].name;

		if(k.substr(0,9)=='CANCELAR_')
			if(formu.elements[i].checked == true )
				Estado=false;
			else
				Estado=true;
	}

	for(i=0;i<formu.length;i++){
		k=formu.elements[i].name;

		if(k.substr(0,9)=='CANCELAR_')
			formu.elements[i].checked = Estado;
	}
}

function reloadResultados(){
	var oForm	= document.forms['ReloadForm'];
	oForm.action	= 'PROResultados.xsql';

	SubmitForm(oForm);
}

function NuevaAltaProveedor(IDProveedor){
	var ventanaOrigen = window.parent;

        ventanaOrigen.location = 'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROManten.xsql?PROVEEDOR='+IDProveedor;
}


