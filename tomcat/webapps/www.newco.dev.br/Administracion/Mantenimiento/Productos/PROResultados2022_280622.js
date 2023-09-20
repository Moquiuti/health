//	Mantenimiento de productos de los catalogos de proveedores de MedicalVM
// 	Ultima revision ET 8mar22 16:15 PROResultados2022_280622.js


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
