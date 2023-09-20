/*
	JS para gestión de la Ficha Completa de proveedor
	UltimaRevisión: ET 21ago18 13:00
*/

//	Activar Parsley
jQuery(function () {
  jQuery('#frmFicha').parsley().on('field:validated', function() {
    var ok = jQuery('.parsley-error').length === 0;
    jQuery('.bs-callout-info').toggleClass('hidden', !ok);
    jQuery('.bs-callout-warning').toggleClass('hidden', ok);
  })
  .on('form:submit', function() {
	console.log("submit");
  });
});


function onloadEvents(){

	//solodebug	console.log('Inicio');

	//	Activamos la primera opción de menú
	activarPestanna('pes_FichaBasica');
	
	// Codigo javascript para mostrar/ocultar tablas cuando se clica en pestañas
	jQuery("#pes_FichaBasica").click(function(){
		activarPestanna('pes_FichaBasica');
	});
	jQuery("#pes_UsRepresentante").click(function(){
		activarPestanna('pes_UsRepresentante');
	});
	jQuery("#pes_UsGerente").click(function(){
		activarPestanna('pes_UsGerente');
	});
	jQuery("#pes_DirFinanciero").click(function(){
		activarPestanna('pes_DirFinanciero');
	});
	jQuery("#pes_EncCartera").click(function(){
		activarPestanna('pes_EncCartera');
	});
	jQuery("#pes_DirComercial").click(function(){
		activarPestanna('pes_DirComercial');
	});
	jQuery("#pes_ServCliente").click(function(){
		activarPestanna('pes_ServCliente');
	});
	jQuery("#pes_UsRepDirecto").click(function(){
		activarPestanna('pes_UsRepDirecto');
	});
	jQuery("#pes_DatosFin").click(function(){
		activarPestanna('pes_DatosFin');
	});
	jQuery("#pes_Cuenta1").click(function(){
		activarPestanna('pes_Cuenta1');
	});
	jQuery("#pes_Cuenta2").click(function(){
		activarPestanna('pes_Cuenta2');
	});
	
}


//	Marca pestaña pulsada + activa el div con el formulario según pestaña activa
function activarPestanna(pestanna)
{	
	//solodebug console.log(pestanna+'.click(function(): activar div_'+pestanna);

	//	16oct17	Marcamos la pestaña seleccionada
	jQuery("a.MenuLic").css('background','#F0F0F0');
	jQuery("a.MenuLic").css('color','#555555');
	jQuery("#"+pestanna).css('background','#3b569b');
	jQuery("#"+pestanna).css('color','#D6D6D6');


	jQuery(".divForm").hide();
	jQuery("#div_"+pestanna).show();
}


//	Publica la ficha para ser revisada por la central de compras
function CambioEstado(Estado)
{
	
	//solodebug	alert('CambioEstado:'+Estado);
	
	document.forms['frmFicha'].elements['ACCION'].value=Estado;
	jQuery('#frmFicha').submit();
}


//	Publica la ficha para ser revisada por la central de compras
function PublicarFicha()
{
	CambioEstado('PUBLICAR');
}

//	Ficha aprobada por la central de compras
function AprobarFicha()
{
	CambioEstado('APROBAR');
}

//	Ficha rechazada por la central de compras
function RechazarFicha()
{
	CambioEstado('RECHAZAR');
}

//	Ficha rechazada por la central de compras
function SolicitarActualizar()
{
	CambioEstado('SOL.ACT.');
}

//	Permitir actualizar ficha
function AprobarActualizar()
{
	CambioEstado('APR_ACT');
}

//	Rechazar actualizar ficha
function RechazarActualizar()
{
	CambioEstado('RECH_ACT');
}



//	Validar y enviar ficha básica
function ValidarYEnviar(IDForm)
{
	jQuery('#'+IDForm).parsley().validate();

    var ok = jQuery('.parsley-error').length === 0;

	//console.log("Provincia:"+document.forms['frmFicha'].elements['PROVINCIA'].value);
	//
	console.log("ValidarYEnviar: IDForm:"+IDForm+' val:'+ok);

	if (ok) 
	{
    	jQuery('.bs-callout-info').show();
    	jQuery('.bs-callout-warning').hide();
		
		//solodebug alert("submit"); 
		jQuery('#'+IDForm).submit();
	}
	else
	{
    	jQuery('.bs-callout-info').hide();
    	jQuery('.bs-callout-warning').show();
	}

}
