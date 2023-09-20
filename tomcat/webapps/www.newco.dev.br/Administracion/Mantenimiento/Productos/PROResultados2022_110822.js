//	Mantenimiento de productos de los catalogos de proveedores de MedicalVM
// 	Ultima revision ET 11ago22 09:10 PROResultados2022_110822.js


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


/*11ago22 Tras probar, no resulta comodo
// Abre la ficha de producto
function chMantenProducto(IDProducto, Busqueda, IDCliente)
{
	document.location="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROManten2022.xsql?PRO_ID="+IDProducto+"&TIPO=M&PRO_BUSQUEDA="+Busqueda+"&IDCLIENTE="+IDCliente;
}*/

