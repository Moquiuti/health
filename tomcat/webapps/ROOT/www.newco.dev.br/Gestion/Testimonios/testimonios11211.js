// JavaScript Document

//	ET	4jul11	09:41
jQuery.noConflict();
// GLOBAL VARS   
var arroba = '@';

//----------------------------------------------------------

jQuery(document).ready(globalEvents);


function globalEvents(){
	
	
	// ver caja pa enviar testimonios
	jQuery("#verEnviarTestimonio").mouseover (function() { this.style.cursor="pointer"; });
	jQuery("#verEnviarTestimonio").mouseout (function() { this.style.cursor="default"; });
	jQuery("#verEnviarTestimonio").click (function() { if (document.getElementById('nuevoTestimonio').style.display == 'none'){
															//document.forms['testi'].elements['TES_TEXTO'].value   
															jQuery('#nuevoTestimonio').show();					   
														}
														else{
															 if (document.getElementById('nuevoTestimonio').style.display != 'none'){
																jQuery('#nuevoTestimonio').hide();					   
																}
															
															}
													});
	//cerrar enviar testimonio
	jQuery("#cerrarEnviarTestimonio").mouseover (function() { this.style.cursor="pointer"; });
	jQuery("#cerrarEnviarTestimonio").mouseout (function() { this.style.cursor="default"; });
	jQuery("#cerrarEnviarTestimonio").click (function() { jQuery('#nuevoTestimonio').hide(); });		
	//buscar testimonios
	jQuery("#buscaTestimonios").mouseover (function() { this.style.cursor="pointer"; });
	jQuery("#buscaTestimonios").mouseout (function() { this.style.cursor="default"; });
	jQuery("#buscaTestimonios").click (function() { BuscaTesti(); });	
	
	//buscar testimonios admin, en el manten
	jQuery("#buscaAdminTestimonios").mouseover (function() { this.style.cursor="pointer"; });
	jQuery("#buscaAdminTestimonios").mouseout (function() { this.style.cursor="default"; });
	jQuery("#buscaAdminTestimonios").click (function() { BuscaAdminTesti(); });		
														
													
	
													

}//fin de globalEvents
	//buscador de testimonios admin
	function BuscaAdminTesti(){
		var form = document.forms['pageTesti'];
		
		if (form.elements['PENDIENTE_TESTI_CK'].checked == true){
			form.elements['PENDIENTE_TESTI'].value = 'PENDIENTES';
			}
		//alert(form.elements['PENDIENTE_TESTI'].value )
		//SubmitForm(formu);
		form.submit();
		}
		
	//buscador de testimonios
	function BuscaTesti(){
		var form = document.forms['BuscaTesti'];
		//alert(form.elements['BUSCA_TESTI'].value )
		//SubmitForm(formu);
		form.submit();
		}
	
		
	//paginacion de testimonios
	function navegaTesti(formu,pag, accion){
		var form = document.forms['pageTesti'];
		if (accion =='siguiente'){
			var pagina= pag +1;
		}
		if (accion =='anterior'){
			var pagina= pag -1;
		}
		form.elements['PAG'].value = pagina;
		//SubmitForm(formu);
		form.submit();
		}
	
	//testimonios, enviar testimonio
	function EnviaTestimonio(formu){
		var msg='';
	
		if(formu.elements['TES_NOMBRE'].value == ''){ msg += 'El nombre y apellido son obligatorios.\n';}
		if(formu.elements['TES_CENTRO'].value == ''){ msg += 'El centro es obligatorio.\n';}
		if(formu.elements['TES_CARGO'].value == ''){ msg += 'El cargo es obligatorio.\n';}
		if(formu.elements['TES_TEXTO'].value == ''){ msg += 'Tu testimonio es obligatorio.\n';}
		
		if (msg == ''){
			SubmitForm(formu);
			jQuery('#confirmTestimonio').show();
			
		}
		else{ alert(msg); }
		
	}//fin de EnviaTestimonio

	//testimonios, enviar testimonio
	function EnviaMantTestimonio(formu){
		var msg='';
	
		if(formu.elements['TES_NOMBRE'].value == ''){ msg += 'El nombre y apellido son obligatorios.\n';}
		if(formu.elements['TES_CENTRO'].value == ''){ msg += 'El centro es obligatorio.\n';}
		if(formu.elements['TES_CARGO'].value == ''){ msg += 'El cargo es obligatorio.\n';}
		if(formu.elements['TES_TEXTO'].value == ''){ msg += 'Tu testimonio es obligatorio.\n';}
		
		if (msg == ''){
			SubmitForm(formu);
			jQuery('#nuevoTestimonio').hide();
			jQuery('#confirmTestimonio').show();
			
		}
		else{ alert(msg); }
		
	}//fin de EnviaTestimonio

