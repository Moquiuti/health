/*
	JS para gestión de la Ficha Completa de proveedor
	UltimaRevisión: ET 9ene23 18:25
*/

//	Activar Parsley
jQuery(function () {
  jQuery('#frmFicha').parsley().on('field:validated', function() {
    var ok = jQuery('.parsley-error').length === 0;
    jQuery('.bs-callout-info').toggleClass('hidden', !ok);
    jQuery('.bs-callout-warning').toggleClass('hidden', ok);
  })
  .on('form:submit', function() {
  
  	//	Comprueba si estamos en el formulario de datos financieros, en cuyo caso tiene que comprobar que no se hayan reducido los descuentos ni el plazo de pago 
  
	console.log("submit");
  });
});


function onloadEvents(){

	//solodebug	console.log('Inicio');

	//	Activamos la primera opción de menú
	activarPestanna('pes_FichaBasica');
	
    //      inicializamos los campos de descuento en función de la forma de pago, únicamente si existe el formulario
    try
	{
		if  ((document.forms['frmDatosPago'].elements['EMP_FIP_PLAZOPAGO'].value=='') || (document.forms['frmDatosPago'].elements['EMP_FIP_DESC_PAGO30DIAS'].value==''))
    	{
        	console.log('Cond.financieras: Inicializar. PlazoPago:'+jQuery('#PLAZO_PAGO').val()+' Desc30dias:'+jQuery('#DESC_PAGO_30DIAS').val()+' Desc60dias:'+jQuery('#DESC_PAGO_60DIAS').val()
        	+' Desc90dias:'+jQuery('#DESC_PAGO_90DIAS').val()+' Desc120dias:'+jQuery('#DESC_PAGO_120DIAS').val());

			document.forms['frmDatosPago'].elements['EMP_FIP_PLAZOPAGO'].value=jQuery('#PLAZO_PAGO').val();
			document.forms['frmDatosPago'].elements['EMP_FIP_DESC_PAGO30DIAS'].value=jQuery('#DESC_PAGO_30DIAS').val();
			document.forms['frmDatosPago'].elements['EMP_FIP_DESC_PAGO60DIAS'].value=jQuery('#DESC_PAGO_60DIAS').val();
			document.forms['frmDatosPago'].elements['EMP_FIP_DESC_PAGO90DIAS'].value=jQuery('#DESC_PAGO_90DIAS').val();
			document.forms['frmDatosPago'].elements['EMP_FIP_DESC_PAGO120DIAS'].value=jQuery('#DESC_PAGO_120DIAS').val();
		}
	}
	catch(err)
	{
		console.log('Read only');
	}
	
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
	jQuery("#pes_DatosPago").click(function(){
		activarPestanna('pes_DatosPago');
	});
	jQuery("#pes_DatosEntrega").click(function(){
		activarPestanna('pes_DatosEntrega');
	});
	
}


//	Marca pestaña pulsada + activa el div con el formulario según pestaña activa
function activarPestanna(pestanna)
{	
	jQuery(".pestannas a").attr('class', 'MenuInactivo');
	jQuery("#"+pestanna).attr('class', 'MenuActivo');

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
	var	Errores='';

	jQuery('#'+IDForm).parsley().validate();

    var ok = jQuery('.parsley-error').length === 0;

	//console.log("Provincia:"+document.forms['frmFicha'].elements['PROVINCIA'].value);
	//
	console.log("ValidarYEnviar: IDForm:"+IDForm+' val:'+ok);
	
	if (IDForm=='frmDatosPago')
	{
	
		if (parseInt(document.forms['frmDatosPago'].elements['EMP_FIP_PLAZOPAGO'].value)<parseInt(jQuery('#PLAZO_PAGO').val()))
		{
			Errores='El plazo de pago no puede ser inferior a '+jQuery('#PLAZO_PAGO').val()+'\n';
		}
	
		if (parseInt(document.forms['frmDatosPago'].elements['EMP_FIP_DESC_PAGO30DIAS'].value)<parseInt(jQuery('#DESC_PAGO_30DIAS').val()))
		{
			Errores='El descuento por pago a 30 días no puede ser inferior a '+jQuery('#DESC_PAGO_30DIAS').val()+'\n';
		}
	
		if (parseInt(document.forms['frmDatosPago'].elements['EMP_FIP_DESC_PAGO60DIAS'].value)<parseInt(jQuery('#DESC_PAGO_60DIAS').val()))
		{
			Errores+='El descuento por pago a 60 días no puede ser inferior a '+jQuery('#DESC_PAGO_60DIAS').val()+'\n';
		}
	
		if (parseInt(document.forms['frmDatosPago'].elements['EMP_FIP_DESC_PAGO90DIAS'].value)<parseInt(jQuery('#DESC_PAGO_90DIAS').val()))
		{
			Errores+='El descuento por pago a 90 días no puede ser inferior a '+jQuery('#DESC_PAGO_90DIAS').val()+'\n';
		}
	
		if (parseInt(document.forms['frmDatosPago'].elements['EMP_FIP_DESC_PAGO120DIAS'].value)<parseInt(jQuery('#DESC_PAGO_120DIAS').val()))
		{
			Errores+='El descuento por pago a 120 días no puede ser inferior a '+jQuery('#DESC_PAGO_120DIAS').val()+'\n';
		}


		if (Errores!='')
		{
			alert (Errores+'\n\nPara cambiar estas condiciones, por favor contacte con la Central de Compras.');
			ok=false;
		}
	}
	

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
