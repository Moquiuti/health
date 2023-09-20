/*
	Funciones para el buscador/listado de lineas de licitacion
	Ultima revisión: ET 8jun22 15:40 LicAnalisisLineas2022_200223.js
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
	form.action='LicAnalisisLineas2022.xsql';

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
	var IDEmpresa = '', IDCentro = '',IDProveedor = '',producto = '',marca = '',fechaInicio = '',fechaFinal = '',licitacion = '',incluirOfertas = 'N',soloactivas='N';

    if (form.elements['IDEMPRESA'] && form.elements['IDEMPRESA'].value != '') IDEmpresa = form.elements['IDEMPRESA'].value;
    if (form.elements['IDCENTRO'] && (form.elements['IDCENTRO'].value != '') ) IDCentro = form.elements['IDCENTRO'].value;
    if (form.elements['IDPROVEEDOR'] && (form.elements['IDPROVEEDOR'].value != '') ) IDProveedor = form.elements['IDPROVEEDOR'].value;
    if (form.elements['PRODUCTO'] && form.elements['PRODUCTO'].value != '') producto = form.elements['PRODUCTO'].value;
    if (form.elements['MARCA'] && form.elements['MARCA'].value != '') marca = form.elements['MARCA'].value;
    if (form.elements['FECHA_INICIO'] && form.elements['FECHA_INICIO'].value != '') fechaInicio = form.elements['FECHA_INICIO'].value;
    if (form.elements['FECHA_FINAL'] && form.elements['FECHA_FINAL'].value != '') fechaFinal = form.elements['FECHA_FINAL'].value;
    if (form.elements['CODIGOLICITACION'] && form.elements['CODIGOLICITACION'].value != '') licitacion = form.elements['CODIGOLICITACION'].value;
    if (form.elements['INCLUIROFERTAS'] && form.elements['INCLUIROFERTAS'].value != '') incluirOfertas = (form.elements['INCLUIROFERTAS'].checked)?'S':'N';
    if (form.elements['SOLOACTIVAS'] && form.elements['SOLOACTIVAS'].value != '') soloactivas = (form.elements['SOLOACTIVAS'].checked)?'S':'N';

    if(jQuery("#UTILFECHAENTREGA").is(':checked')){
        jQuery("#UTILFECHAENTREGA").val('S');
        var utilFechaEntrega = 'S';
    }
    else var utilFechaEntrega = 'N';
	
	//solodebug
	console.log("DescargarExcel. IDEMPRESA="+IDEmpresa+"&IDCENTRO="+IDCentro+"&IDPROVEEDOR="+IDProveedor+"&PRODUCTO="+producto+"&MARCA="+marca+"&FECHA_INICIO="+fechaInicio+"&FECHA_FINAL="+fechaFinal+"&CODIGOLICITACION="+licitacion+"&INCLUIROFERTAS="+incluirOfertas+"&UTILFECHAENTREGA="+utilFechaEntrega);

	var d = new Date();

	jQuery.ajax({
		url: 'http://www.newco.dev.br/Gestion/Comercial/LicAnalisisLineasExcel.xsql',
		data:"IDEMPRESA="+IDEmpresa+"&IDCENTRO="+IDCentro+"&IDPROVEEDOR="+IDProveedor+"&PRODUCTO="+producto+"&MARCA="+marca
				+"&FECHA_INICIO="+fechaInicio+"&FECHA_FINAL="+fechaFinal+"&CODIGOLICITACION="+licitacion+"&INCLUIROFERTAS="+incluirOfertas
				+"&SOLOACTIVAS="+soloactivas+"&UTILFECHAENTREGA="+utilFechaEntrega+"&_="+d.getTime(),
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



function IncluirOfertasClick()
{
    var form=document.forms[0];
	if (form.elements['INCLUIROFERTAS'].checked==false) form.elements['BORRADOSENPEDIDOS'].checked=false;
}



function BorradosEnPedidosClick()
{
    var form=document.forms[0];
	if (form.elements['BORRADOSENPEDIDOS'].checked==true) form.elements['INCLUIROFERTAS'].checked=true;
}

//	Abre la licitacion, en funcion del Rol
function AbrirLicitacion(IDLicitacion)
{
	if (Rol=='COMPRADOR')
		FichaLicV2(IDLicitacion,'');
	else
		LicitacionProveedor(IDLicitacion);
}




