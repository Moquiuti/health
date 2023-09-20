/*
	Funciones para el buscador/listado de lineas de licitacion
	14dic16 Faltaba poner el contador de página actual a 0 al hacer una nueva búsqueda
	ultima revisión: 14dic16	10:24
*/



function globalEvents(){

	jQuery(document).keypress(function(e){
		if(e.keyCode == 13){
			//alert('You pressed enter!');
			AplicarFiltro();
		}
	});
       

}//fin de globalEvent


function AplicarFiltro(){
	var form=document.forms[0];
	form.action='LicAnalisisProveedores.xsql';

	jQuery("#PAGINA").val('0');		//14dic16
                
	if(jQuery("#UTILFECHAENTREGA").is(':checked')){
		jQuery("#UTILFECHAENTREGA").val('S');
	}else{
		jQuery("#UTILFECHAENTREGA").val('N');
	}
        
        //alert(form.elements['UTILFECHAENTREGA'].value);
        
	SubmitForm(form);
}

function AplicarFiltroPagina(pag){
    var form=document.forms[0];

    form.elements['PAGINA'].value = pag;

	//14dic16   AplicarFiltro();
	
	if(jQuery("#UTILFECHAENTREGA").is(':checked')){
		jQuery("#UTILFECHAENTREGA").val('S');
	}else{
		jQuery("#UTILFECHAENTREGA").val('N');
	}
        
	SubmitForm(form);

}

function OrdenarPor(Orden){
	var form=document.forms[0];
        //alert(Orden);

	if (form.elements['ORDEN'].value==Orden){
		if (form.elements['SENTIDO'].value=='ASC') form.elements['SENTIDO'].value='DESC';
		else  form.elements['SENTIDO'].value='ASC';
	}else{
		form.elements['ORDEN'].value=Orden;
		form.elements['SENTIDO'].value='ASC';
	}
	AplicarFiltro();
}

function DescargarExcel(){

    var form=document.forms[0];

    if (form.elements['IDEMPRESA'] && form.elements['IDEMPRESA'].value != '') {
        var IDEmpresa = form.elements['IDEMPRESA'].value;
    }
    else var IDEmpresa = '';

    if (form.elements['IDCENTRO'] && (form.elements['IDCENTRO'].value != '') ) var IDCentro = form.elements['IDCENTRO'].value;
    else var IDCentro = '';

    if (form.elements['IDPROVEEDOR'] && (form.elements['IDPROVEEDOR'].value != '') ) var IDProveedor = form.elements['IDPROVEEDOR'].value;
    else var IDProveedor = '';

    if (form.elements['PRODUCTO'] && form.elements['PRODUCTO'].value != '') var producto = form.elements['PRODUCTO'].value;
    else var producto = '';

    if (form.elements['FECHA_INICIO'] && form.elements['FECHA_INICIO'].value != '') var fechaInicio = form.elements['FECHA_INICIO'].value;
    else var fechaInicio = '';

    if (form.elements['FECHA_FINAL'] && form.elements['FECHA_FINAL'].value != '') var fechaFinal = form.elements['FECHA_FINAL'].value;
    else var fechaFinal = '';

    if (form.elements['CODIGOLICITACION'] && form.elements['CODIGOLICITACION'].value != '') var pedido = form.elements['CODIGOLICITACION'].value;
    else var pedido = '';

    if(jQuery("#UTILFECHAENTREGA").is(':checked')){
        jQuery("#UTILFECHAENTREGA").val('S');
        var utilFechaEntrega = 'S';
    }
    else var utilFechaEntrega = 'N';

    //alert('emp '+IDEmpresa);
    //alert('prov '+IDProveedor);
    //alert('centro '+IDCentro);
   // alert('fec entr '+utilFechaEntrega);

	var d = new Date();

	jQuery.ajax({
		url: 'http://www.newco.dev.br/Gestion/Comercial/LicAnalisisProveedoresExcel.xsql',
		data: "IDEMPRESA="+IDEmpresa+"&IDCENTRO="+IDCentro+"&IDPROVEEDOR="+IDProveedor+"&PRODUCTO="+producto+"&FECHA_INICIO="+fechaInicio+"&FECHA_FINAL="+fechaFinal+"&CODIGOPEDIDO="+pedido+"&UTILFECHAENTREGA="+utilFechaEntrega+"&_="+d.getTime(),
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
