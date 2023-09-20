//	JS para manten. Contrato
//	Ultima revisión: ET 27ago18 13:15


//	Activar Parsley
jQuery(function () {
  jQuery('#Contrato').parsley().on('field:validated', function() {
    var ok = jQuery('.parsley-error').length === 0;
    jQuery('.bs-callout-info').toggleClass('hidden', !ok);
    jQuery('.bs-callout-warning').toggleClass('hidden', ok);
  })
  .on('form:submit', function() {
	//solodebug	console.log("submit");
  });
});


//	Validar y enviar ficha básica
function ValidarYEnviar()
{
	jQuery('#Contrato').parsley().validate();

    var ok = jQuery('.parsley-error').length === 0;

	//console.log("Provincia:"+document.forms['frmFicha'].elements['PROVINCIA'].value);
	//
	console.log("ValidarYEnviar: IDForm:Contrato. val:"+ok);

	if (ok) 
	{
    	jQuery('.bs-callout-info').show();
    	jQuery('.bs-callout-warning').hide();
		
		//solodebug alert("submit"); 
		jQuery('#Contrato').submit();
	}
	else
	{
    	jQuery('.bs-callout-info').hide();
    	jQuery('.bs-callout-warning').show();
	}

}


//	Publica la ficha para ser revisada por la central de compras
function CambioEstado(Estado)
{
	
	//solodebug	alert('CambioEstado:'+Estado);
	
	document.forms['Contrato'].elements['ACCION'].value=Estado;
	jQuery('#Contrato').submit();
}


//	Publica la ficha para ser revisada por la central de compras
function PublicarContrato()
{
	CambioEstado('PUBLICAR');
}
