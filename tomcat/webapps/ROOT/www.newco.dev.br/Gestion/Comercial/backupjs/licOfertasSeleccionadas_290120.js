//	JS para la página con las ofertas seleccionadas, "Vencedores"	
//	Ultima revision ET 29ene20 12:10 licOfertasSeleccionadas_290120.js


function ActivarCambio(IDProveedorLic)
{
	//alert('ActivarCambio:'+IDProveedorLic);

	jQuery('#AVISOACCION_'+IDProveedorLic).html('');
	jQuery('#BOTONGUARDAR_'+IDProveedorLic).show();
}

function GuardarFormaYPlazoPago(IDProveedorLic)
{
	var oForm=document.forms['Proveedores'];

	//alert('GuardarFormaYPlazoPago. IDProveedorLic:'+IDProveedorLic);

	var IDLicitacion=oForm.elements['IDLicitacion'].value;
	var IDFormaPago=oForm.elements['FORMASPAGO_'+IDProveedorLic].value;
	var IDPlazoPago=oForm.elements['PLAZOSPAGO_'+IDProveedorLic].value;
	var d = new Date();

	//alert('GuardarFormaYPlazoPago. FormaPago:'+IDFormaPago+' PlazoPago:'+IDPlazoPago);

	jQuery.ajax({
		cache:	false,
		url:	'InformarFormaYPlazoPagoAJAX.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&LIC_PROV_ID="+IDProveedorLic+"&IDFORMAPAGO="+IDFormaPago+"&IDPLAZOPAGO="+IDPlazoPago+"&_="+d.getTime(),
		beforeSend: function(){
			jQuery('#BOTONGUARDAR_'+IDProveedorLic).hide();
		},
		error: function(objeto, quepaso, otroobj){
			jQuery('#AVISOACCION_'+IDProveedorLic).html('<img src="http://www.newco.dev.br/images/error.gif"/>');
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.DatosActualizados.Resultado =='OK'){
				jQuery('#AVISOACCION_'+IDProveedorLic).html('<img src="http://www.newco.dev.br/images/recibido.gif"/>');
			}else{
				jQuery('#AVISOACCION_'+IDProveedorLic).html('<img src="http://www.newco.dev.br/images/error.gif"/>');
			}
			location.reload();
		}
	})

}

function GuardarFormaYPlazoPagoCentro(IDProveedorLic)
{
	var oForm=document.forms['Proveedores'];

	//alert('GuardarFormaYPlazoPago. IDProveedorLic:'+IDProveedorLic);

	var IDLicitacion=oForm.elements['IDLicitacion'].value;
	var IDCentro=oForm.elements['IDCentro'].value;
	var IDFormaPago=oForm.elements['FORMASPAGO_'+IDProveedorLic].value;
	var IDPlazoPago=oForm.elements['PLAZOSPAGO_'+IDProveedorLic].value;
	var d = new Date();

	//alert('GuardarFormaYPlazoPagoCentro IDLicitacion:'+IDLicitacion+' IDCentro:'+IDCentro+' FormaPago:'+IDFormaPago+' PlazoPago:'+IDPlazoPago);

	jQuery.ajax({
		cache:	false,
		url:	'InformarFormaYPlazoPagoCentroAJAX.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&IDCENTRO="+IDCentro+"&LIC_PROV_ID="+IDProveedorLic+"&IDFORMAPAGO="+IDFormaPago+"&IDPLAZOPAGO="+IDPlazoPago+"&_="+d.getTime(),
		beforeSend: function(){
			jQuery('#BOTONGUARDAR_'+IDProveedorLic).hide();
		},
		error: function(objeto, quepaso, otroobj){
			jQuery('#AVISOACCION_'+IDProveedorLic).html('<img src="http://www.newco.dev.br/images/error.gif"/>');
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.DatosActualizados.Resultado =='OK'){
				jQuery('#AVISOACCION_'+IDProveedorLic).html('<img src="http://www.newco.dev.br/images/recibido.gif"/>');
			}else{
				jQuery('#AVISOACCION_'+IDProveedorLic).html('<img src="http://www.newco.dev.br/images/error.gif"/>');
			}
			location.reload();
		}
	})

}

//	24oct16	Mostrar conversacion con proveedor
function conversacionProveedor(ProvID)
{
	var oForm=document.forms['Proveedores'];
	var IDLicitacion=oForm.elements['IDLicitacion'].value;
	MostrarPagPersonalizada('ConversacionLicitacion.xsql?IDLICITACION='+IDLicitacion+'&IDPROVEEDOR='+ProvID,'',70,70,0,0);
}

// Funcion que devuelve un fichero excel con detalles de los vencedores de la licitacion
function listadoExcel(){
	var oForm=document.forms['Proveedores'];
	var IDLicitacion=oForm.elements['IDLicitacion'].value;

	var d = new Date();

	jQuery.ajax({
		url:	"http://www.newco.dev.br/Gestion/Comercial/LicitacionesExcel.xsql",
		data:	"IDLIC="+IDLicitacion+"&SOLOADJUDICADAS=S&_="+d.getTime(),

		type:	"GET",
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			null;
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.estado == 'ok')
				window.location='http://www.newco.dev.br/Descargas/'+data.url;
			else
				alert(alrt_errorDescargaFichero);
		}
	});
}


//	3ene20 Crea un pedido para un proveedor
function crearPedido(IDProveedorLic)
{
	jQuery("#btnCrearPedido_"+IDProveedorLic).hide();
	if (confirm(strConfirmarPedido))
	{
		var oForm=document.forms['Proveedores'];
		oForm.elements['ACCION'].value='PEDIDO';
		oForm.elements['PARAMETROS'].value=IDProveedorLic;

		//solodebug console.log('crearPedido.IDProveedorLic:'+IDProveedorLic);

		SubmitForm(oForm);
	}
	else
		jQuery("#btnCrearPedido_"+IDProveedorLic).show();
}




