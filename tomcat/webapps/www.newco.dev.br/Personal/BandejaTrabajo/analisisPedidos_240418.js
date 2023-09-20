/*
	14dic16 Faltaba poner el contador de página actual a 0 al hacer una nueva búsqueda
	ultima revisión: 24abr1810:47
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
	form.action='AnalisisPedidos.xsql';
	
	jQuery("#PAGINA").val('0');		//14dic16

	//	3abr18
	if(jQuery("#FINALIZADOS_CHECK").is(':checked'))
	{
		jQuery("#FINALIZADOS").val('S');
	   // alert('Finalizados:S');
	}
	else
	{
		jQuery("#FINALIZADOS").val('N');
	   // alert('Finalizados:N');
	}

	//	24abr18
	if(jQuery("#URGENTES_CHECK").is(':checked'))
	{
		jQuery("#URGENTES").val('S');
	    //alert('URGENTES:S');
	}
	else
	{
		jQuery("#URGENTES").val('N');
	    //alert('URGENTES:N');
	}
                
	if(jQuery("#UTILFECHAENTREGA").is(':checked')){
		jQuery("#UTILFECHAENTREGA").val('S');
	}else{
		jQuery("#UTILFECHAENTREGA").val('N');
	}
        
        
	SubmitForm(form);
}

function AplicarFiltroPagina(pag){
    var form=document.forms[0];
    form.elements['PAGINA'].value = pag;
 
	//14dic16   AplicarFiltro();

	//	3abr18
	if(jQuery("#FINALIZADOS_CHECK").is(':checked')){
		jQuery("#FINALIZADOS").val('S');
	}else{
		jQuery("#FINALIZADOS").val('N');
	}

	//	24abr18
	if(jQuery("#URGENTES_CHECK").is(':checked'))
	{
		jQuery("#URGENTES").val('S');
	}
	else
	{
		jQuery("#URGENTES").val('N');
	}
 
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
	var IDEmpresa, IDCentro, IDProveedor, producto, fechaInicio, fechaFinal, pedido, utilFechaEntrega, finalizados, urgentes;

    if (form.elements['IDEMPRESA'] && form.elements['IDEMPRESA'].value != '') {
         IDEmpresa = form.elements['IDEMPRESA'].value;
    }
    else  IDEmpresa = '';

    if (form.elements['IDCENTRO'] && (form.elements['IDCENTRO'].value != '') )  IDCentro = form.elements['IDCENTRO'].value;
    else  IDCentro = '';

    if (form.elements['IDPROVEEDOR'] && (form.elements['IDPROVEEDOR'].value != '') )  IDProveedor = form.elements['IDPROVEEDOR'].value;
    else  IDProveedor = '';

    if (form.elements['PRODUCTO'] && form.elements['PRODUCTO'].value != '')  producto = form.elements['PRODUCTO'].value;
    else  producto = '';

    if (form.elements['FECHA_INICIO'] && form.elements['FECHA_INICIO'].value != '')  fechaInicio = form.elements['FECHA_INICIO'].value;
    else  fechaInicio = '';

    if (form.elements['FECHA_FINAL'] && form.elements['FECHA_FINAL'].value != '')  fechaFinal = form.elements['FECHA_FINAL'].value;
    else  fechaFinal = '';

    if (form.elements['CODIGOPEDIDO'] && form.elements['CODIGOPEDIDO'].value != '')  pedido = form.elements['CODIGOPEDIDO'].value;
    else  pedido = '';

    if(jQuery("#UTILFECHAENTREGA").is(':checked')){
         utilFechaEntrega = 'S';
    }
    else  utilFechaEntrega = 'N';

	//	24abr18	Faltaba incluir este campo para finalizados
    if(jQuery("#FINALIZADOS_CHECK").is(':checked')){
         finalizados = 'S';
    }
    else  finalizados = 'N';

	//	24abr18	Urgentes
    if(jQuery("#URGENTES_CHECK").is(':checked')){
         urgentes = 'S';
    }
    else  urgentes = 'N';


//alert('emp '+IDEmpresa);
//alert('prov '+IDProveedor);
//alert('centro '+IDCentro);
// alert('fec entr '+utilFechaEntrega);

	var d = new Date();

	jQuery.ajax({
		url: 'http://www.newco.dev.br/Personal/BandejaTrabajo/AnalisisPedidosExcel.xsql',
		data: "IDEMPRESA="+IDEmpresa+"&IDCENTRO="+IDCentro+"&IDPROVEEDOR="+IDProveedor+"&PRODUCTO="+producto
					+"&FECHA_INICIO="+fechaInicio+"&FECHA_FINAL="+fechaFinal+"&CODIGOPEDIDO="+pedido+"&UTILFECHAENTREGA="+utilFechaEntrega
					+"&FINALIZADOS="+finalizados+"&URGENTES="+urgentes
					+"&_="+d.getTime(),
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
