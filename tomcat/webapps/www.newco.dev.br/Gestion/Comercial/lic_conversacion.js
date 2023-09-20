//	ultima revision: 25-06-14

function onloadEvents(){
	null;
}

function ValidarFormulario(oForm){
	var errores=0;

	/* quitamos los espacios sobrantes  */
	for(var n=0; n < oForm.length; n++){
		if(oForm.elements[n].type=='text'){
			oForm.elements[n].value=quitarEspacios(oForm.elements[n].value);
		}
	}

	if((!errores) && (esNulo(oForm.elements['LIC_MENSAJE'].value))){
		errores++;
		alert(faltaMensaje);
		oForm.elements['LIC_MENSAJE'].focus();
	}

	/* si los datos son correctos enviamos el form  */
	if(!errores){
		SubmitForm(oForm);
	}
}
