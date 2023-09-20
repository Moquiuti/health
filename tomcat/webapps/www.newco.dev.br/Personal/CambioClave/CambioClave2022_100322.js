//	Cambio de clave del usuario
//	Ultima revision: ET 10mar22 11:30 CambioClave2022_100322.js
var error='La clave nueva tiene que ser igual en clave nueva y repita clave';
var msgSinClave='La clave no puede estar en blanco.';

function ValidaClave(){
    formu=document.forms[0];        

	if(formu.elements['fClaveNueva'].value==''){
	  	alert(msgSinClave);
	}
	else{
	  if(formu.elements['fClaveNueva'].value==formu.elements['fClaveNuevaRep'].value){

		//SubmitForm(formu);

		formu.method="post";
  		formu.action="CambioClaveSave2022.xsql";
		SubmitForm(formu);
    	}
	  else{

    	}
	}
}
      
	 
