
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
       
	SubmitForm(form);
}

function AplicarFiltroPagina(pag){
    var form=document.forms[0];
    form.elements['PAGINA'].value = pag;
    AplicarFiltro();
    
}

function OrdenarPor(Orden){
	var form=document.forms[0];

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
    
                        if (form.elements['IDEMPRESA'] && (form.elements['IDEMPRESA'].value != '' && form.elements['IDEMPRESA'].value != '-1')) {
                            var IDEmpresa = form.elements['IDEMPRESA'].value;
                        }
                        else var IDEmpresa = '';
                        
                        if (form.elements['IDEMPRESAUSUARIO'] && form.elements['IDEMPRESAUSUARIO'].value != '') var IDEmpresa = form.elements['IDEMPRESAUSUARIO'].value;
                        
                        if (form.elements['IDCENTRO'] && (form.elements['IDCENTRO'].value != '' && form.elements['IDCENTRO'].value != '-1') ) var IDCentro = form.elements['IDCENTRO'].value;
                        else var IDCentro = '';
			
                        if (form.elements['IDPROVEEDOR'] && (form.elements['IDPROVEEDOR'].value != '' && form.elements['IDPROVEEDOR'].value != '-1') ) var IDProveedor = form.elements['IDPROVEEDOR'].value;
                        else var IDProveedor = '';
                        
                        if (form.elements['PRODUCTO'] && form.elements['PRODUCTO'].value != '') var producto = form.elements['PRODUCTO'].value;
                        else var producto = '';
                        
                        if (form.elements['FECHA_INICIO'] && form.elements['FECHA_INICIO'].value != '') var fechaInicio = form.elements['FECHA_INICIO'].value;
                        else var fechaInicio = '';
                        
                        if (form.elements['FECHA_FINAL'] && form.elements['FECHA_FINAL'].value != '') var fechaFinal = form.elements['FECHA_FINAL'].value;
                        else var fechaFinal = '';
                        
                        if (form.elements['CODIGOPEDIDO'] && form.elements['CODIGOPEDIDO'].value != '') var pedido = form.elements['CODIGOPEDIDO'].value;
                        else var pedido = '';
			
                        //alert('emp '+IDEmpresa);
                        //alert('prov '+IDProveedor);
                        //alert('centro '+IDCentro);
                        
			var d = new Date();
                        
			jQuery.ajax({
				url: 'http://www.newco.dev.br/Personal/BandejaTrabajo/AnalisisPedidosExcel.xsql',
				data: "IDEMPRESA="+IDEmpresa+"&IDCENTRO="+IDCentro+"&IDPROVEEDOR="+IDProveedor+"&PRODUCTO="+producto+"&FECHA_INICIO="+fechaInicio+"&FECHA_FINAL="+fechaFinal+"&CODIGOPEDIDO="+fechaFinal+"&_="+d.getTime(),
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

