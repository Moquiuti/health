//	JS del listado de análisis de tarifas
//	ultima revision: ET 9jun23 09:45 AnalisisTarifas2022_070623.js (adaptado desde AnalisisPedidos)

function globalEvents(){

	jQuery(document).keypress(function(e){
		if(e.keyCode == 13){
			AplicarFiltro();
		}
	});
       

}//fin de globalEvent


function CompruebaFechas()
{
	//
	//	1mar21 COmprueba que no sean mas de 6 meses
	//
	var fInicio=jQuery("#FECHA_INICIO").val(), fFinal=jQuery("#FECHA_FINAL").val(), dFinal=new Date();

	var dateParts = fInicio.split("/");
	var year=parseInt(dateParts[2]);
	
	if (year<1900) year+=2000;
	var dInicio = new Date(year, (dateParts[1] - 1), dateParts[0]); 

	dd = parseInt(dateParts[0]);
	mm = parseInt(dateParts[1]); 				//January is 0!

	year++;
	var LimiteOrd=year*10000+mm*100+dd; 		//  Este formato es más eficiente para comparar fechas


	if (fFinal!='')
	{
		var dateParts = fFinal.split("/");
		console.log('fec.fin.:'+dateParts[0]+'/'+dateParts[1]+'/'+dateParts[2]);
		var year=parseInt(dateParts[2]);
		if (year<1900) year+=2000;
		dFinal = new Date(year, (dateParts[1] - 1), dateParts[0]); 
	}

	var dd = dFinal.getDate(),
		mm = dFinal.getMonth() + 1, 				//January is 0!
		year = dFinal.getFullYear();
	var FinalOrd=year*10000+mm*100+dd; 		//  Este formato es más eficiente para comparar fechas

	//solodebug	console.log('fec.ini.:'+dInicio+' fec.fin.:'+dFinal+' FinalOrd:'+FinalOrd+' LimiteOrd:'+LimiteOrd);

	return 'OK';
}


function AplicarFiltro(){
	var form=document.forms[0];
	form.action='AnalisisTarifas2022.xsql';
	
	jQuery("#PAGINA").val('0');		
	
	if ((limiteMeses=='N')||(CompruebaFechas()=='OK'))
	{
		SubmitForm(form);
	}
}

function AplicarFiltroPagina(pag){
    var form=document.forms[0];
    form.elements['PAGINA'].value = pag;
 
	if ((limiteMeses=='N')||(CompruebaFechas()=='OK'))
	{
		SubmitForm(form);
	}

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
	var IDEmpresa, IDCentro, IDProveedor, producto, fechaInicio, fechaFinal;

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

	var d = new Date();

	jQuery.ajax({
		url: 'http://www.newco.dev.br/Gestion/EIS/AnalisisTarifasExcel.xsql',
		data: "IDEMPRESA="+IDEmpresa+"&IDCENTRO="+IDCentro+"&IDPROVEEDOR="+IDProveedor+"&PRODUCTO="+producto
					+"&FECHA_INICIO="+fechaInicio+"&FECHA_FINAL="+fechaFinal
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


