//	Funciones javascript para PROPacksHTML
//	ultima revision: ET 4set18 11:57

var Dominio='http://www.newco.dev.br';	//	facilita portabilidad

function onloadEvents(){

	console.log('Inicio');

	//	12dic16	Marcamos la primera opción de menú
	jQuery("#pes_Pack").css('background','#3b569b');
	jQuery("#pes_Pack").css('color','#D6D6D6');
	
	// Se clica en pestañas
	jQuery("#pes_Ficha").click(function(){
	
		//	Pendiente identificar si estamos en mantenimiento o en lectura
	
 		var IDProducto = document.forms['IncluirProductos'].elements['PRO_ID'].value;
		window.location.assign("http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROManten.xsql?PRO_ID="+IDProducto);

	});
	// Se clica en pestañas
	jQuery("#pes_Documentos").click(function(){
	
		//	Pendiente identificar si estamos en mantenimiento o en lectura
	
 		var IDProducto = document.forms['IncluirProductos'].elements['PRO_ID'].value;
		window.location.assign("http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODocs.xsql?PRO_ID="+IDProducto);

	});
}


//	Incluye un producto en el pack
function IncluirProducto()
{
	//var RefProducto=document.forms['IncluirProductos'].elements['REFPROVEEDOR'].value;
	var IDProducto=document.forms['IncluirProductos'].elements['IDNUEVOPRODUCTO'].value;
	
	console.log('IncluirProducto:'+document.forms['IncluirProductos'].elements['IDNUEVOPRODUCTO'].value);
	
	if (IDProducto=='')
	{
		alert(document.forms['MensajeJS'].elements['FALTA_REFERENCIA'].value);
		return;
	}

	var Cantidad=document.forms['IncluirProductos'].elements['CANTIDAD'].value;
	
	if ((Cantidad=='')||(isNaN(parseFloat(Cantidad))))
	{
		alert(document.forms['MensajeJS'].elements['CANTIDAD_OBLIGATORIA'].value);
		return;
	}
	
	document.forms['IncluirProductos'].elements['PARAMETROS'].value=IDProducto+':'+Cantidad;
	document.forms['IncluirProductos'].elements['ACCION'].value='INCLUIR';
	document.forms['IncluirProductos'].submit();
}


//	Quitar un producto en el pack
function QuitarProducto(IDProducto)
{	
	document.forms['IncluirProductos'].elements['PARAMETROS'].value=IDProducto;
	document.forms['IncluirProductos'].elements['ACCION'].value='QUITAR';
	document.forms['IncluirProductos'].submit();
}

//	Guardar cambios para licitaciones
function btnGuardar()
{
	var listaCambios='';
	
	console.log('btnGuardar');
	jQuery(".chkIncluir").each(function()
	{
        console.log(jQuery(this).attr('id'));
		
		var IDProducto=Piece(jQuery(this).attr('id'),'_',2);
		var incluirLic=(jQuery("#chk_INCLUIR_"+IDProducto).attr("checked"))?'S':'N';
		var IDProdCopia=(incluirLic=='S')?'':document.forms['frmProductos'].elements['ASOCIAR_'+IDProducto].value;
		
		if ((incluirLic!=document.forms['frmProductos'].elements['INCLUIR_'+IDProducto+'_ORIG'].value) ||(IDProdCopia!=document.forms['frmProductos'].elements['ASOCIAR_'+IDProducto+'_ORIG'].value))
			listaCambios+=IDProducto+':'+incluirLic+':'+IDProdCopia+'|';
			
    });
	
	console.log('btnGuardar. listaCambios:'+listaCambios);


	document.forms['IncluirProductos'].elements['PARAMETROS'].value=listaCambios;
	document.forms['IncluirProductos'].elements['ACCION'].value='CAMBIOSLIC';
	document.forms['IncluirProductos'].submit();

}



//	Marcado/desmarcado checkbox "Incluir en licitaciones"
function chkIncluirChange(IDProducto)
{
	var chkChecked=jQuery("#chk_INCLUIR_"+IDProducto).attr("checked");
	
	console.log('chkIncluirChange. IDProducto:'+IDProducto+' chkChecked:'+chkChecked);
	
	if (chkChecked)
	{
		jQuery('#ASOCIAR_'+IDProducto).hide();
	}
	else
	{
		jQuery('#ASOCIAR_'+IDProducto).show();
	}
}





