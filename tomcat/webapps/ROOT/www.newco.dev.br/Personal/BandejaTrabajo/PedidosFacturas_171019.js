// JS Página de Pedidos y facturas
// Ultima revisión ET: 17oct19 09:45

jQuery.noConflict();

//----------------------------------------------------------

jQuery(document).ready(globalEvents);

function globalEvents(){
}


function FiltrarBusqueda(){
	jQuery('#PAGINA').val('0');
	AplicarFiltro();
}


function AplicarFiltro(){
	var form=document.forms[0];
	form.action='PedidosFacturas.xsql';

	SubmitForm(form);
}



function ActivarGuardar(IDOferta)
{
	jQuery('#Guardar_'+IDOferta).show();
	jQuery('#OK_'+IDOferta).hide();
	jQuery('#Error_'+IDOferta).hide();
}

function Guardar(IDOferta)
{
	jQuery('#Guardar_'+IDOferta).hide();
	var Factura	= encodeURIComponent(jQuery('#Factura_'+IDOferta).val()),
		Pagado	= encodeURIComponent(jQuery('#Pagado_'+IDOferta).val()),
		d = new Date();


	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Personal/BandejaTrabajo/GuardarFacturaPagadoAJAX.xsql',
		type:	"GET",
		data:	"MO_ID="+IDOferta+"&FACTURA="+Factura+"&PAGADO="+Pagado+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			jQuery("#MensPedidoMinimo").hide();
		},
		error: function(objeto, quepaso, otroobj){
			jQuery('#Error_'+IDOferta).hide();
			console.log('Guardar '+IDOferta+' error:'+quepaso);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.Resultado.estado == 'OK'){
				jQuery('#OK_'+IDOferta).show();
			}else{
				jQuery('#Error_'+IDOferta).hide();
			}
		}
	});


}
