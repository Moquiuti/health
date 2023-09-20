// JavaScript Document
//	ET	23-01-14	12.13
jQuery.noConflict();
// GLOBAL VARS

function  searchURLParameters(){
	var query	= window.location.search.substring(1);
	var query_parts	= query.split("&");

	for(var i=0;i < query_parts.length;i++){
		// Si no está logado => mostrar pop-up de login
		if((query_parts[i] == 'LOGIN=ADMIN')){
			document.forms['Login'].elements['USER'].value= 'ADMINDEMO';
			document.forms['Login'].elements['PASS'].value= 'ADMINDEMO17106';
			AbrirVentana(document.forms['Login']);
			return false;
		}else if(query_parts[i] == 'LOGIN=CDC'){
			document.forms['Login'].elements['USER'].value= 'CDCDEMO';
			document.forms['Login'].elements['PASS'].value= 'CDCDEMO18246';
			AbrirVentana(document.forms['Login']);
			return;
		}else if(query_parts[i] == 'LOGIN=COMPRADOR'){
			document.forms['Login'].elements['USER'].value= 'COMPRADORDEMO';
			document.forms['Login'].elements['PASS'].value= 'COMPRADORDEMO';
			AbrirVentana(document.forms['Login']);
			return;
		}
	}
}