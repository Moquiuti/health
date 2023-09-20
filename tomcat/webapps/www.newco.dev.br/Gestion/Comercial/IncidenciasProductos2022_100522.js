//	JS buscador y Listado de Incidencias de Productos. Nuevo disenno. 
//	ultima revision: 10may22 17:01 IncidenciasProductos2022_100522.js

function DescargarExcel(){
	var FIDEmpresa		= jQuery('#FIDEMPRESA').val();
	var FIDCentro		= jQuery('#FIDCENTRO').val();
	var FIDResponsable	= jQuery('#FIDRESPONSABLE').val();
	var FIDProveedor	= jQuery('#FPROVEEDOR').val();
	var FIDProducto		= jQuery('#FPRODUCTO').val();
	var FTexto		= codificacionAjax(jQuery('#FTEXTO').val());
	var FEstado		= jQuery('#FESTADO').val();
	var d			= new Date();

	jQuery.ajax({
		url: 'http://www.newco.dev.br/Gestion/Comercial/IncidenciasExcel.xsql',
		data: "FIDEMPRESA="+FIDEmpresa+"&amp;FIDCENTRO="+FIDCentro+"&amp;FIDRESPONSABLE="+FIDResponsable+"&amp;FIDPROVEEDOR="+FIDProveedor+"&amp;FIDPRODUCTO="+FIDProducto+"&amp;FTEXTO="+FTexto+"&amp;FESTADO="+FEstado+"&amp;_="+d.getTime(),
                        type: "GET",
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
                                        alert('Se ha producido un error. No se puede descargar el fichero.');
                        }
                });
        }

function BuscarIncidenciasProductos(oForm){
	SubmitForm(oForm);
}

function BorrarIncidenciaProducto(IDInc){
	var d			= new Date();

	jQuery.ajax({
		url: 'http://www.newco.dev.br/Gestion/Comercial/BorrarIncidenciaProducto.xsql',
		data: "IDINCIDENCIA="+IDInc+"&amp;_="+d.getTime(),
		type: "GET",
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			jQuery("#IncBorradaOK").hide();
			jQuery("#IncBorradaKO").hide();
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.estado == 'OK'){
				var IDIncidencia = data.id;

				jQuery("#IncBorradaOK").show();
				jQuery("#INC_" + IDIncidencia).hide();
			}else
				jQuery("#IncBorradaKO").show();
		}
	});
}

function Reset(form){
    form.elements['FIDEMPRESA'].value = '-1';
    form.elements['FIDCENTRO'].value = '-1';
    form.elements['FPRODUCTO'].value = '-1';
    form.elements['FPROVEEDOR'].value = '-1';
    form.elements['FTEXTO'].value = '';
}




