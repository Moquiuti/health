//	Mantenimiento de productos de los catalogos de proveedores de MedicalVM
// 	Ultima revision ET 17abr23 15:15 PROResultados2022_170423.js


//	Recupera la historia de la pagina
function obtenerHistoria(){
	var Historia= document.forms['formResultados'].elements['HISTORY'].value;

	if(Historia=='')
		return history.length;
	else
		return Historia;
}


function CambioPagina(sentido){
	var oForm	= document.forms['ReloadForm'];
	oForm.action	= 'PROResultados2022.xsql';

	if(isAdmin == 'S'){	
		if(!confirm(confirmPag)){
			return;
		}
	}
	
	var pagina=0;
	if ((oForm.elements['PAGINA'].value!='')&&(!isNaN(oForm.elements['PAGINA'].value)))
		pagina=parseInt(oForm.elements['PAGINA'].value);
	
	if(sentido == 'SIGUIENTE')
		oForm.elements['PAGINA'].value	= pagina+1;
	else if(sentido == 'ANTERIOR')
		oForm.elements['PAGINA'].value	= pagina-1;

	SubmitForm(oForm);	
}


//	Acepta los cambios propuestos , recuperado desde PROBuscador

//	LLama a la pagina para aceptar los resultados
function AceptarCambios(){
	formu= document.forms['formResultados'];
	var Msg='';

	for(var j=0;j<formu.length;j++){
		var k = formu.elements[j].name;
		if (k.substring(0,7) == 'IDPROD_'){
			var IDProducto=formu.elements[j].value;
			var Aceptar=formu.elements['ACEPTAR_'+IDProducto].checked;
			var Cancelar=formu.elements['CANCELAR_'+IDProducto].checked;
			var Comentario= formu.elements['COMENTARIO_'+IDProducto].value;
		}

		if(Aceptar == true){
			if(!Msg.match(IDProducto)) Msg=Msg+IDProducto+'|A|'+Comentario+'#';
		}else if(Cancelar == true){
			if(!Msg.match(IDProducto)) Msg=Msg+IDProducto+'|C|'+Comentario+'#';
		}
	}

	formu.elements['CAMBIOS_PROVE'].value=Msg;
	formu.action = 'PROResultados2022.xsql';

	SubmitForm(formu);
}

//17abr23 alarmas solicitudes, si solicitudes ya estan en acto el usuario no puede solicitar de nuevo
function AlarmaSolicitud(tipo){
	if(tipo == 'P')
		alert(document.forms['MensajeJS'].elements['SOLICITUD_PENDIENTE'].value);

	if(tipo == 'D')
		alert(document.forms['MensajeJS'].elements['SOLICITUD_DEVUELTA'].value);
}

//17abr23 Seleccionar todos para aceptar solecitud del proveedor
function SelTodosAceptar(){
	SelTodos(true);
}

//17abr23 Seleccionar todos para cancelar solecitud del proveedor
function SelTodosCancelar(){
	SelTodos(false);
}


//17abr23 Actualiza todos los checkboxes para Aceptar o Rechazar
function SelTodos(Aceptar)		//	Aceptar true o false
{
	var formu = document.forms['formResultados'];
	var Estado=null;


	for(var i=0;(i<formu.length)&&(Estado==null);i++)
	{
		var k=formu.elements[i].name;

		if(k.substr(0,8)=='ACEPTAR_')
			formu.elements[i].checked = Aceptar;
		if(k.substr(0,9)=='CANCELAR_')
			formu.elements[i].checked = !Aceptar;
	}
	
}

//17abr23Si se pulsa "aceptar", fuerza "Cancelar" a NO y viceversa
function RevisarOpciones(IDProducto, opcion){
	var formu = document.forms['formResultados'];
	if((opcion=='ACEPTAR')&&(formu.elements['ACEPTAR_'+IDProducto].checked == true))
		formu.elements['CANCELAR_'+IDProducto].checked = false;

	if((opcion=='CANCELAR')&&(formu.elements['CANCELAR_'+IDProducto].checked == true))
		formu.elements['ACEPTAR_'+IDProducto].checked = false;
}








