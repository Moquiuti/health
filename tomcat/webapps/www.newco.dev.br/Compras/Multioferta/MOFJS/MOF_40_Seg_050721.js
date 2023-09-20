//	JS para seguimiento en caso de pedidos pendientes de aprobacion (estado 40)
//	Ultima revision: ET 7jul21	12:00 MOF_40_Seg_050721.js


function GuardarSeguimientoAprobacion(IDLinea)
{
	var d = new Date();
	
	jQuery("#btnGuardarSeguimiento_"+IDLinea).hide();
	jQuery("#chkOK_"+IDLinea).hide();
	jQuery("#chkError_"+IDLinea).hide();
	texto=jQuery("#Seguimiento_"+IDLinea).val();
	
	debug('GuardarSeguimientoAprobacion:'+texto);

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Compras/Multioferta/GuardarSeguimientoAJAX.xsql',
		type:	"GET",
		data:	"LMO_ID="+IDLinea+"&TEXTO="+texto+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.SeguimientoActualizado.estado == 'OK'){
				jQuery("#chkOK_"+IDLinea).show();
            }else{
				jQuery("#chkError_"+IDLinea).show();
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}


function ActivarBotonGuardar(IDLinea)
{
	jQuery("#btnGuardarSeguimiento_"+IDLinea).show();
	jQuery("#chkOK_"+IDLinea).hide();
	jQuery("#chkError_"+IDLinea).hide();
}
