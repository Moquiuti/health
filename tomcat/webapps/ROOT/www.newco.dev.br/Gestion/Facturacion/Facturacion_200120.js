//	JS Control y facturas a clientes MVM
//	Ultima revisión: ET 20ene20 16:30 Facturacion_200120.js
function AnalisisListado(IDEmpresa, IDCentro){
	var parametros = 'FECHA_INICIO=' + fechaInicio + '&FECHA_FINAL=' + fechaFinal;
	parametros += '&IDEMPRESA=' + IDEmpresa + '&IDCENTRO=' + IDCentro;
	parametros += '&UTILFECHAENTREGA=S';

	MostrarPagPersonalizada('http://www.newco.dev.br/Personal/BandejaTrabajo/AnalisisPedidos.xsql?' + parametros,'Analisis Lineas',100,80,0,-20);
}

function AplicarFiltro(){
	var oForm = document.forms.FormBuscador;

	if(jQuery('#SOLOREMESAS_CHK').prop('checked')){
		jQuery('#SOLOREMESAS').val('S');
	}else{
		jQuery('#SOLOREMESAS').val('N');
	}

	SubmitForm(oForm);
}

function CrearFactura(linea, IDEmpresa, IDCentro, isRemesa){
	jQuery('#NF_IDEMPRESA').val(IDEmpresa);
	jQuery('#NF_IDCENTRO').val(IDCentro);
	var nombreEmpresa	= jQuery('tr#linea' + linea + ' span.NombreEmpresa').html();
	var nombreCentro	= jQuery('tr#linea' + linea + ' span.NombreCentro').html();
	var str_para = nombreCentro + ' (' + nombreEmpresa + ')';
	jQuery('#NF_NombreEmpresa').html(str_para);

	//Datos facturacion
	jQuery('#NF_TOTALPEDIDOS').html(jQuery('tr#linea' + linea + ' td.totalPedidos').html() + '€');
	jQuery('#NF_TOTALAHORRO').html(jQuery('tr#linea' + linea + ' td.totalAhorro').html() + '€');
	jQuery('#NF_COMPEDIDOSPORC').html(jQuery('tr#linea' + linea + ' td.comisionPedidosPorc').html() + '%');
	jQuery('#NF_COMAHORROPORC').html(jQuery('tr#linea' + linea + ' td.comisionAhorroPorc').html() + '%');
	jQuery('#NF_TOTALCOMISION').html(jQuery('tr#linea' + linea + ' td.totalComision').html() + '€');

	// Vaciamos campos del formulario
	jQuery('#NF_CODIGO').val('');
	jQuery('#NF_IMPORTE').val('');
	jQuery('#NF_FECHAFACTURA').val('');
	jQuery('#NF_COMENTARIO').val('');
	jQuery('#NF_FECHACOBROPREVISTO').val('');
	jQuery('#NF_FECHACOBROREAL').val('');
	jQuery('#NF_DESCRIPCIONREMESA').val('');
	jQuery('#NF_FECHAREMESA').val('');
	jQuery('#NF_ENVIADA').prop('checked', false);

	// Inicializamos campo textoFactura con valor por defecto
	var TextoFactura = jQuery('tr#linea' + linea + ' textarea.textoFacturaIni').val().replace('/<br>/gi','\n');
	jQuery('#NF_TEXTOFACTURA').val(TextoFactura);

	if(isRemesa){
		jQuery('.NF_Remesa').show();
	}else{
		jQuery('.NF_Remesa').hide();
	}

	showTablaByID("NuevaFacturaWrap");
}

function nuevaFactura(){
	var IDCentro = jQuery('#NF_IDCENTRO').val();
	var IDEmpresa = jQuery('#NF_IDEMPRESA').val();
	var codigo = jQuery('#NF_CODIGO').val();
	var importe = jQuery('#NF_IMPORTE').val();
	var importeFmtd = importe.replace(',','.');
	var comentarios = encodeURIComponent(jQuery('#NF_COMENTARIO').val().replace("/'/g", "''"));
	var textoFactura = encodeURIComponent(jQuery('#NF_TEXTOFACTURA').val().replace("/'/g", "''"));
	var FechaFactura = jQuery('#NF_FECHAFACTURA').val();
	var FechaCobroPrevisto = jQuery('#NF_FECHACOBROPREVISTO').val();
	var FechaCobroReal = jQuery('#NF_FECHACOBROREAL').val();
	var FechaRemesa = '';
	if(jQuery('#NF_FECHAREMESA').length){
		FechaRemesa = jQuery('#NF_FECHAREMESA').val();
	}
	var DescripcionRemesa = '';
	if(jQuery('#NF_DESCRIPCIONREMESA').length){
		DescripcionRemesa = jQuery('#NF_DESCRIPCIONREMESA').val();
	}
	var FacturaEnviada = '';
	if(jQuery('#NF_ENVIADA').prop('checked')){
		FacturaEnviada = 'S';
	}

	var d = new Date();

	if(codigo == ''){
		alert(str_codigoObli);
		return;
	}else if(importe == ''){
		alert(str_importeObli);
		return;
	}else if(isNaN(importeFmtd)){
		alert(str_importeSinFormato);
		return;
	}

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Facturacion/NuevaFacturaAJAX.xsql',
		type:	"POST",
		data:	"IDCENTRO="+IDCentro+"&IDEMPRESA="+IDEmpresa+"&MES="+mes+"&ANNO="+anno+"&CODIGO="+codigo+"&IMPORTE="+importeFmtd+"&TEXTOFACTURA="+textoFactura+"&COMENTARIOS="+comentarios+"&FECHACOBROPREVISTO="+FechaCobroPrevisto+"&FECHACOBROREAL="+FechaCobroReal+"&FECHAREMESA="+FechaRemesa+"&DESCRIPCIONREMESA="+DescripcionRemesa+"&ENVIADA="+FacturaEnviada+"&FECHAFACTURA="+FechaFactura+"&_="+d.getTime(),
		beforeSend: function(){
			jQuery("#botonNuevaFactura").hide();
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.NuevaFactura.estado == 'OK'){
				alert(str_nuevaFacturaOK);
				AplicarFiltro();
			}else{
				alert('Error');
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});

	jQuery("#botonNuevaFactura").show();
}


function EditarFactura(linea, IDFactura, IDEmpresa, IDCentro, isRemesa)
{
	
	jQuery('#EF_IDEMPRESA').val(IDEmpresa);
	jQuery('#EF_IDCENTRO').val(IDCentro);
	jQuery('#EF_IDFACTURA').val(IDFactura);

	var nombreEmpresa	= jQuery('tr#linea' + linea + ' span.NombreEmpresa').html();
	var nombreCentro	= jQuery('tr#linea' + linea + ' span.NombreCentro').html();
	var str_para = nombreCentro + ' (' + nombreEmpresa + ')'

	jQuery('#EF_NombreEmpresa').html(str_para);

	//Datos facturacion
	jQuery('#EF_TOTALPEDIDOS').html(jQuery('tr#linea' + linea + ' td.totalPedidos').html() + '€');
	jQuery('#EF_TOTALAHORRO').html(jQuery('tr#linea' + linea + ' td.totalAhorro').html() + '€');
	jQuery('#EF_COMPEDIDOSPORC').html(jQuery('tr#linea' + linea + ' td.comisionPedidosPorc').html() + '%');
	jQuery('#EF_COMAHORROPORC').html(jQuery('tr#linea' + linea + ' td.comisionAhorroPorc').html() + '%');
	jQuery('#EF_TOTALCOMISION').html(jQuery('tr#linea' + linea + ' td.totalComision').html() + '€');

	// Datos formulario
	var codigo	= jQuery('tr#linea' + linea + ' td.num_factura').html();
	var importe	= jQuery('tr#linea' + linea + ' td.importe').html();
	
	try	//	Si no existe el comentario, no queremos generar error
	{
		var comentario	= jQuery('tr#linea' + linea + ' span.comentario').html().replace('/<br>/gi','\n');
	}
	catch(e)
	{
	}

	var textoFactura	= jQuery('tr#linea' + linea + ' textarea.textoFactura').val().replace('/<br>/gi','\n');
	jQuery('#EF_CODIGO').val(codigo);
	jQuery('#EF_IMPORTE').val(importe);
	jQuery('#EF_COMENTARIO').val(comentario);
	jQuery('#EF_TEXTOFACTURA').val(textoFactura);

	var fechaFactura	= jQuery('tr#linea' + linea + ' input.fechaFactura').val();
	var fechaCobroPrevisto	= jQuery('tr#linea' + linea + ' td.fechacobroprevisto').html();
	var fechaCobroReal	= jQuery('tr#linea' + linea + ' td.fechacobroreal').html();
	var fechaRemesa	= jQuery('tr#linea' + linea + ' td.fecharemesa').html();
	var descRemesa	= jQuery('tr#linea' + linea + ' textarea.descremesa').val().replace('/<br>/gi','\n');
	jQuery('#EF_FECHAFACTURA').val(fechaFactura);
	jQuery('#EF_FECHACOBROPREVISTO').val(fechaCobroPrevisto);
	jQuery('#EF_FECHACOBROREAL').val(fechaCobroReal);
	jQuery('#EF_FECHAREMESA').val(fechaRemesa);
	jQuery('#EF_DESCRIPCIONREMESA').val(descRemesa);

	if(jQuery('tr#linea' + linea + ' input.FacEnviada').val() == 'S'){
		jQuery('#EF_ENVIADA').prop('checked', true);
	}else{
		jQuery('#EF_ENVIADA').prop('checked', false);
	}

	if(isRemesa){
		jQuery('.EF_Remesa').show();
	}else{
		jQuery('.EF_Remesa').hide();
	}

	// Boton 'Ver Factura'
	jQuery("div#botonVerFactura a").attr("href", "javascript:GenerarFactura('" + IDFactura + "');")


	showTablaByID("EditaFacturaWrap");
}

function modificaFactura(){
	var IDCentro = jQuery('#EF_IDCENTRO').val();
	var IDEmpresa = jQuery('#EF_IDEMPRESA').val();
	var IDFactura = jQuery('#EF_IDFACTURA').val();
	var codigo = jQuery('#EF_CODIGO').val();
	var importe = jQuery('#EF_IMPORTE').val();
	var importeFmtd = importe.replace(',','.');
	var fechaFactura	= jQuery('#EF_FECHAFACTURA').val();
	var textoFactura = encodeURIComponent(jQuery('#EF_TEXTOFACTURA').val().replace("/'/g", "''"));
	var comentarios = encodeURIComponent(jQuery('#EF_COMENTARIO').val().replace("/'/g", "''"));
	var fechaCobroPrevisto	= jQuery('#EF_FECHACOBROPREVISTO').val();
	var fechaCobroReal	= jQuery('#EF_FECHACOBROREAL').val();
	var fechaRemesa = '';
	if(jQuery('#EF_FECHAREMESA').length){
		fechaRemesa	= jQuery('#EF_FECHAREMESA').val();
	}
	var descRemesa = '';
	if(jQuery('#EF_DESCRIPCIONREMESA').length){
		descRemesa	= jQuery('#EF_DESCRIPCIONREMESA').val();
	}
	var FacturaEnviada = '';
	if(jQuery('#EF_ENVIADA').prop('checked')){
		FacturaEnviada = 'S';
	}
	var d = new Date();

	if(codigo == ''){
		alert(str_codigoObli);
		return;
	}else if(importe == ''){
		alert(str_importeObli);
		return;
	}else if(isNaN(importeFmtd)){
		alert(str_importeSinFormato);
		return;
	}

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Facturacion/ModificaFacturaAJAX.xsql',
		//type:	"GET",
		type:	"POST",
		data:	"IDCENTRO="+IDCentro+"&IDEMPRESA="+IDEmpresa+"&IDFACTURA="+IDFactura+"&MES="+mes+"&ANNO="+anno+"&CODIGO="+codigo+"&IMPORTE="+importeFmtd+"&TEXTOFACTURA="+textoFactura+"&COMENTARIOS="+comentarios+"&DESCRIPCIONREMESA="+descRemesa+"&FECHAREMESA="+fechaRemesa+"&FECHACOBROPREVISTO="+fechaCobroPrevisto+"&FECHACOBROREAL="+fechaCobroReal+"&ENVIADA="+FacturaEnviada+"&FECHAFACTURA="+fechaFactura+"&_="+d.getTime(),
		beforeSend: function(){
			jQuery("#botonEditaFactura").hide();
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.EditaFactura.estado == 'OK'){
				alert(str_nuevaFacturaOK);
				AplicarFiltro();
			}else{
				alert('Error');
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});

	jQuery("#botonEditaFactura").show();
}

function DescargarExcel(){
  var oForm = document.forms.FormBuscador;
	var Mes = '', Anno = '';
	var d = new Date();

  if(oForm.elements.MES && oForm.elements.MES.value !== '') Mes = oForm.elements.MES.value;
  if(oForm.elements.ANNO && oForm.elements.ANNO.value !== '') Anno = oForm.elements.ANNO.value;

	if(Mes == '' || Anno == ''){
		alert(str_MesYAnnoObli);
		return;
	}

	jQuery.ajax({
		url: 'http://www.newco.dev.br/Gestion/Facturacion/FacturacionExcel.xsql',
		data: "MES="+Mes+"&ANNO="+Anno+"&_="+d.getTime(),
	type: "GET",
	contentType: "application/xhtml+xml",
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

function GenerarFactura(IDFactura){
	MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Facturacion/Factura.xsql?IDFACTURA=' + IDFactura,'Factura',100,80,0,-20);
}

function MarcarFacturasEnviadas(){
	var lista = '';
	jQuery('.chk_FactEnviada').each(function(key, thisChkBox){
		if(this.checked){
			lista += jQuery(this).val() + ':S|';
}else{
			lista += jQuery(this).val() + ':N|';
		}
	});

	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Facturacion/MarcarFacturasEnviadasAJAX.xsql',
		type:	"POST",
		data:	"LISTA="+encodeURIComponent(lista)+"&_="+d.getTime(),
		beforeSend: function(){
			jQuery("#botonMarcarFacturas").hide();
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.MarcarFacturas.estado == 'OK'){
				var count = data.MarcarFacturas.count;
				alert(alrt_countFacturasMarcadasEnviadas.replace('[[COUNT]]', count));
			}else{
				alert('Error');
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});

	jQuery("#botonMarcarFacturas").show();
}
