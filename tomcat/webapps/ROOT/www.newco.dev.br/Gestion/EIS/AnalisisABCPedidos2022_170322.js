//	JS del listado de análisis ABC de pedidos
//	ultima revisión: ET 17mar22 16:15 AnalisisABCPedidos2022_170322.js


function globalEvents(){

	jQuery(document).keypress(function(e){
		if(e.keyCode == 13){
			//alert('You pressed enter!');
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
	mm = parseInt(dateParts[1])-1; 				//January is 0!
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
		mm = dFinal.getMonth()-1, 				//January is 0!
		year = dFinal.getFullYear();
	var FinalOrd=year*10000+mm*100+dd; 		//  Este formato es más eficiente para comparar fechas


	//solodebug	console.log('fec.ini.:'+dInicio+' fec.fin.:'+dFinal+' FinalOrd:'+FinalOrd+' LimiteOrd:'+LimiteOrd);
	
	if (FinalOrd>LimiteOrd) 
	{
		alert(strInforme12mesesmaximo);
		return 'ERROR';
	}

	return 'OK';
}



function AplicarFiltro(){
	var form=document.forms[0];
	form.action='AnalisisABCPedidos2022.xsql';
	
	jQuery("#PAGINA").val('0');		//14dic16
	    
	if (CompruebaFechas()=='OK')
		SubmitForm(form);
}

function AplicarFiltroPagina(pag){
    var form=document.forms[0];
    form.elements['PAGINA'].value = pag;
        
	if (CompruebaFechas()=='OK')
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

	jQuery('#btnExcel').hide();
	jQuery('#waitExcel').show();

    var form=document.forms[0];
	var IDEmpresa, IDCentro, IDProveedor, IDFamilia, fechaInicio, fechaFinal, IDCentroConsumo,GrupoDeStock,Oncologico,PorcA,PorcB,Producto;

    if (form.elements['IDEMPRESA'] && form.elements['IDEMPRESA'].value != '') {
         IDEmpresa = form.elements['IDEMPRESA'].value;
    }
    else  IDEmpresa = '';

    if (form.elements['IDCENTRO'] && (form.elements['IDCENTRO'].value != '') )  IDCentro = form.elements['IDCENTRO'].value;
    else  IDCentro = '';

    if (form.elements['IDPROVEEDOR'] && (form.elements['IDPROVEEDOR'].value != '') )  IDProveedor = form.elements['IDPROVEEDOR'].value;
    else  IDProveedor = '';

    if (form.elements['FECHA_INICIO'] && form.elements['FECHA_INICIO'].value != '')  fechaInicio = form.elements['FECHA_INICIO'].value;
    else  fechaInicio = '';

    if (form.elements['FECHA_FINAL'] && form.elements['FECHA_FINAL'].value != '')  fechaFinal = form.elements['FECHA_FINAL'].value;
    else  fechaFinal = '';

    if (form.elements['IDFAMILIA'] && form.elements['IDFAMILIA'].value != '')  IDFamilia = form.elements['IDFAMILIA'].value;
    else  IDFamilia = '';

    if (form.elements['IDCENTROCONSUMO'] && form.elements['IDCENTROCONSUMO'].value != '')  IDCentroConsumo = form.elements['IDCENTROCONSUMO'].value;
    else  IDCentroConsumo = '';

    if (form.elements['GRUPODESTOCK'] && form.elements['GRUPODESTOCK'].value != '')  GrupoDeStock = form.elements['GRUPODESTOCK'].value;
    else  GrupoDeStock = '';

    if (form.elements['ONCOLOGICO'] && form.elements['ONCOLOGICO'].value != '')  Oncologico = form.elements['ONCOLOGICO'].value;
    else  Oncologico = '';

    if (form.elements['PORCENTAJE_A'] && form.elements['PORCENTAJE_A'].value != '')  PorcA = form.elements['PORCENTAJE_A'].value;
    else  PorcA = '';

    if (form.elements['PORCENTAJE_B'] && form.elements['PORCENTAJE_B'].value != '')  PorcB = form.elements['PORCENTAJE_B'].value;
    else  PorcB = '';

    if (form.elements['PRODUCTO'] && form.elements['PRODUCTO'].value != '')  Producto = form.elements['PRODUCTO'].value;
    else  Producto = '';

	var d = new Date();

	jQuery.ajax({
		url: 'http://www.newco.dev.br/Gestion/EIS/AnalisisABCPedidosExcel.xsql',
		data: "IDEMPRESA="+IDEmpresa+"&IDCENTRO="+IDCentro+"&IDPROVEEDOR="+IDProveedor+"&PRODUCTO="+Producto
					+"&FECHA_INICIO="+fechaInicio+"&FECHA_FINAL="+fechaFinal
					+"&IDFAMILIA="+IDFamilia+"&GRUPODESTOCK="+GrupoDeStock+"&ONCOLOGICO="+Oncologico+"&PORCENTAJE_A="+PorcA+"&PORCENTAJE_B="+PorcB
					+"&_="+d.getTime(),
        type: "GET",
        contentType: "application/xhtml+xml",
        beforeSend: function(){
                null;
        },
        error: function(objeto, quepaso, otroobj){
            alert('error'+quepaso+' '+otroobj+''+objeto);
			jQuery('#btnExcel').show();
			jQuery('#waitExcel').hide();
        },
        success: function(objeto){
            var data = eval("(" + objeto + ")");

            if(data.estado == 'ok')
                    window.location='http://www.newco.dev.br/Descargas/'+data.url;
            else
                    alert('Se ha producido un error. No se puede descargar el fichero.');
			jQuery('#btnExcel').show();
			jQuery('#waitExcel').hide();
        }
	});
}


//	30jul19 al marcar FINALIZADOS desmarca PENDIENTES y vice versa
function chkPendienteOFinalizadoChange(Control)
{
	var Alter=(Control=='FINALIZADOS')?'PENDIENTES':'FINALIZADOS';
	if(jQuery("#"+Control+"_CHECK").is(':checked'))
	{
		jQuery("#"+Alter+"_CHECK").prop('checked',false);		//1jul22 attr
	}
}


