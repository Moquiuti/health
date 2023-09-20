// JavaScript Document
//productos equivalentes

function proveedorManual(valor){
	if (valor == 'PROV_MANUAL'){
		jQuery("#PROV_EQUI_DESPLE").hide();
		jQuery("#PROV_EQUI_SPAN").show();
		jQuery("#PROV_EQUI_MANUAL").val('');
		jQuery("#IDPROVEEDOR").val('');
	}else 	if (valor == 'desplegable'){
		jQuery("#PROV_EQUI_DESPLE").val('');
		jQuery("#PROV_EQUI_DESPLE").show();
		jQuery("#PROV_EQUI_SPAN").hide();
		jQuery("#IDPROVEEDOR").val('');
	}else{
		jQuery("#IDPROVEEDOR").val(valor);
                recuperaDocsProveedor(valor,-1);
        }
}

function recuperaDocsProveedor(IDProv,IDDocActual){
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/FichasProveedor.xsql',
		type:	"GET",
		data:	"IDPROVEEDOR="+IDProv+"&IDDOC_ACTUAL="+IDDocActual+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			jQuery('#IDFICHA').find('option').remove().end();
			jQuery.each(data.Filtros, function(key,val){
				jQuery('#IDFICHA').append(jQuery('<option></option>').val(val.Fitro.id).html(val.Fitro.nombre));
			});

			if(IDDocActual > 0)
				jQuery('#IDFICHA').val(IDDocActual);
			else
				jQuery('#IDFICHA').val('-1');
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}

function verCargaDoc(tipo){
	if(document.forms['form1'].elements['IDPROVEEDOR'].value == '-1'){
		var proveObli = document.forms['mensajeJS'].elements['PROVEEDOR_OBLI'].value;
		alert(document.forms['mensajeJS'].elements['SELECCIONAR_PROVEEDOR'].value);
	}else{
		if(document.getElementById('carga'+tipo).style.display == 'none'){
			//ficha tecnica
			if (tipo == 'FT'){
				jQuery(".textFT").show();
			}

			jQuery(".cargas").hide();
			jQuery("#carga"+tipo).show();

			document.forms['form1'].elements['TIPO_DOC'].value= tipo;
		}else{
			jQuery("#carga"+tipo).hide(); 
		}
	}//fin else si provee no esta selecionado
}

function validarFormEquiv(oForm){
	var msg = '';

	jQuery('#FormEquivError').hide();
	jQuery('#FormEquivError').html('');

	if(oForm['REF_EQUI'].value == ''){
		msg += errRefEquiv + '<br />';
	}

	if(oForm['PROV_EQUI_DESPLE'].value == ''){
		msg += errProvSelEquiv + '<br />';
	}else if(oForm['PROV_EQUI_DESPLE'].value == 'PROV_MANUAL'){
		if(oForm['PROV_EQUI_MANUAL'].value == ''){
			msg += errProvManualEquiv + '<br />';
		}else{
			jQuery('#IDPROV').val(oForm['PROV_EQUI_MANUAL'].value);
		}
	}else{
		jQuery('#IDPROV').val(oForm['PROV_EQUI_DESPLE'].value);
	}

	if(oForm['NOMBRE_EQUI'].value == ''){
		msg += errNombreEquiv + '<br />';
	}

	if(oForm['MARCA_EQUI'].value == ''){
		msg += errMarcaEquiv + '<br />';
	}

	if(oForm['IDESTADOEVAL'].value == ''){
		msg += errEstadoEquiv + '<br />';
	}

	if(msg == ''){
		NuevoProductoEquivalente(oForm);
	}else{
		msg = comprIncidencias + '<br /><br />' + msg;

		jQuery('#FormEquivError').html(msg);
		jQuery('#FormEquivError').show();
	}
}

function NuevoProductoEquivalente(oForm){
	var idLic,licProdId,user,params='';
	var IDProdEstandar	= oForm.elements['IDPROD'].value;
	var IDProveedor		= (oForm.elements['PROV_EQUI_DESPLE'].value != 'PROV_MANUAL' ? oForm.elements['PROV_EQUI_DESPLE'].value : '');
	var Proveedor		= (oForm.elements['PROV_EQUI_MANUAL'].value != '' ? encodeURIComponent(oForm.elements['PROV_EQUI_MANUAL'].value) : '');
	var Referencia		= encodeURIComponent(oForm.elements['REF_EQUI'].value);
	var Nombre		= encodeURIComponent(oForm.elements['NOMBRE_EQUI'].value);
	var Marca		= encodeURIComponent(oForm.elements['MARCA_EQUI'].value);
	var Comentarios		= encodeURIComponent(oForm.elements['COMENTARIO_EQUI'].value);
	var IDEstadoEvaluacion	= oForm.elements['IDESTADOEVAL'].value;
	var IDFichaTecnica	= oForm.elements['IDFICHA'].value;
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/ProductosEquivalentes_ajax.xsql',
		type:	"GET",
		data:	"ACCION=NUEVO&IDPROD="+IDProdEstandar+"&IDPROVEEDOR="+IDProveedor+"&PROVEEDOR="+Proveedor+"&REFERENCIA="+Referencia+"&NOMBRE="+Nombre+"&MARCA="+Marca+"&COMENTARIOS="+Comentarios+"&IDESTADOEVAL="+IDEstadoEvaluacion+"&IDFICHA="+IDFichaTecnica+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.NuevoProdEquiv.estado == 'OK'){
				jQuery('#FormEquivError').html(nuevoEquiv_ok);
				RecuperaProdsEquiv(IDProdEstandar);
                        }else{
				jQuery('#FormEquivError').html(nuevoEquiv_error);
			}
			jQuery('#FormEquivError').show();
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}

function RecuperaProdsEquiv(IDProdEstandar){
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/RecuperaProdEquiv.xsql',
		type:	"GET",
		data:	"IDPROD="+IDProdEstandar+"&IDIDIOMA="+IDIdioma+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.length > 0){
				jQuery('#ProdEquivManual > tbody').html('');
				jQuery.each(data.ListaProdEquiv, function(key,value){
					InsertaNuevaFila(value);
				});
			}else{
				jQuery('#ProdEquivManual > tbody').html('<tr><td colspan="10">' + sinProdEquiv + '</td></tr>');
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}

function InsertaNuevaFila(obj){
	var IDProdEquiv		= obj.ID;
	var IDProdEstandar	= obj.IDPRODESTANDAR;
	var IDProveedor		= obj.IDPROVEEDOR;
	var NombreProveedor	= obj.PROVEEDOR;
	var Referencia		= obj.Referencia;
	var Nombre		= obj.Nombre;
	var Marca		= obj.Marca;
	var IDEstadoEval	= obj.IDEstadoEval;
	var EstadoEval		= obj.EstadoEval;
	var Comentarios		= obj.Comentarios;
	var IDFicha		= obj.FichaTecnica.IDFICHA;
	var NombreFicha		= obj.FichaTecnica.NombreFicha;
	var DescripcionFicha	= obj.FichaTecnica.DescripcionFicha;
	var URLFicha		= obj.FichaTecnica.URLFicha;
	var FechaFicha		= obj.FichaTecnica.Fecha;
	var strFicha, classEstado='';

	if(IDFicha != ''){
		strFicha = '<a href="http://www.newco.dev.br/Documentos/' + URLFicha + '" id="' + IDFicha + '">' + NombreFicha + '</a>';
	}else{
		strFicha = sinFichaTecnica;
	}

	if(IDEstadoEval == 'NOAPTO'){
		classEstado = 'class="celdaconrojo Evaluacion"';
	}else{
		classEstado = 'class="Evaluacion"';
	}

	jQuery('table#ProdEquivManual > tbody').append(
		'<tr id="ID_' + IDProdEquiv + '">' +
			'<td>&nbsp;</td>' +
			'<td class="datosLeft Referencia">' + Referencia + '</td>' +
			'<td class="datosLeft Proveedor">' + NombreProveedor + '</td>' +
			'<td class="datosLeft Nombre"><a href="javascript:llenarFormEquiv(' + IDProdEquiv + ');">' + Nombre + '</a></td>' +
			'<td class="datosLeft Marca">' + Marca + '</td>' +
			'<td ' + classEstado + '>' + EstadoEval + '</td>' +
			'<td class="FichaTecnica">' + strFicha + '</td>' +
			'<td class="datosLeft Comentarios">' + Comentarios + '</td>' +
			'<td><a href="javascript:borrarProdEquiv(' + IDProdEquiv + ');"><img src="http://www.newco.dev.br/images/2017/trash.png" title="' + borrar + '"/></a></td>' +
			'<td>&nbsp;</td>' +
		'</tr>'
	);
}

function borrarProdEquiv(IDProdEquiv){
	var NuevoEstado = 'B';
	var Comentarios = encodeURIComponent('Borrado desde sistema');
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/ProdEquivBorrar_ajax.xsql',
		type:	"GET",
		data:	"IDPRODEQUIV="+IDProdEquiv+"&COMENTARIOS="+Comentarios+"&IDESTADOEVAL="+NuevoEstado+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.BorrarProdEquiv.estado == 'OK'){
				jQuery('#FormEquivError').html(borrarEquiv_ok);
				EliminarFila(data.BorrarProdEquiv.id);
                        }else{
				jQuery('#FormEquivError').html(borrarEquiv_error);
			}
			jQuery('#FormEquivError').show();
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}

function EliminarFila(IDProdEquiv){
	jQuery('#ProdEquivManual tr#ID_' + IDProdEquiv).remove();

	if(jQuery('table#ProdEquivManual > tbody').children().length == 0){
		jQuery('#ProdEquivManual > tbody').html('<tr><td colspan="10">' + sinProdEquiv + '</td></tr>');
	}
}

function validateIDProvFT(){
	var IDProv = jQuery('#PROV_EQUI_DESPLE').val();
	var err = 0;

	jQuery('#messageBoxFT').html('').hide();

	if(IDProv == ''){
		jQuery('#messageBoxFT').html(errNoIDProv).show();
		err = 1;
	}else if(IDProv == 'PROV_MANUAL'){
		jQuery('#messageBoxFT').html(errProvManual).show();
		err = 1;
	}

	if(err == 0)
        	cargaDoc(document.forms['form1'],'FT');

}

//cambio de fichas segun el proveedor
function SeleccionaFichas(IDPROVE,ID,currentDocID){
	recuperaDocsProveedor(IDPROVE,currentDocID);

/*
	var ACTION="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/FichasProveedor.xsql";;
	var post='IDPROVEEDOR='+IDPROVE;
	if (IDPROVE!=-1 && IDPROVE!=0)sendRequest(ACTION,handleRequestFichas,post,ACCION);
*/	
}

function handleRequestFichas(req,accion){
	
	var response = eval("(" + req.responseText + ")");
	var Resultados = new String('');
	var Doc_ID_Actual = new String('');
	

	if (response.Filtros != ''){
		
		for (var i=0; i < response.Filtros.length; i++) {
			
			if (i==1) {
				Doc_ID_Actual=response.Filtros[i].Fitro.id;
				File_ID_Actual = response.Filtros[i].Fitro.file;
				File_URL_Actual = 'http://www.newco.dev.br/Documentos/'+File_ID_Actual;
			}
			Resultados =Resultados+' <option value="'+response.Filtros[i].Fitro.id+'">'+response.Filtros[i].Fitro.nombre+'</option>';
		}
		
		$("#IDFICHA").show();
		$("#IDFICHA").html(Resultados);
					
		if (accion=='lista') document.forms['form1'].elements['IDFICHA'].value = '-1';
		else document.forms['form1'].elements['IDFICHA'].value = Doc_ID_Actual;
		
		//si change_prov es S significa prod nuevo, al cargar provee se cargan ofertas y aparece boton comprobar, esto es para que no pase
		if (document.forms['form1'].elements['CHANGE_PROV'].value == 'N'){
			$("#comprobarFT").attr('href', File_URL_Actual);
			document.getElementById("comprobarFT").style.display='block';
		}
			
	}
	return true;
}

function llenarFormEquiv(IDProdEquiv){
	var Referencia	= jQuery('tr#ID_'+IDProdEquiv).find('td.Referencia').html();
	var Proveedor	= jQuery('tr#ID_'+IDProdEquiv).find('td.Proveedor').html();
	var Nombre	= jQuery('tr#ID_'+IDProdEquiv).find('td.Nombre a').html();
	var Marca	= jQuery('tr#ID_'+IDProdEquiv).find('td.Marca').html();
	var Evaluacion	= jQuery('tr#ID_'+IDProdEquiv).find('td.Evaluacion').html();
	var IDFichaTec	= jQuery('tr#ID_'+IDProdEquiv).find('td.FichaTecnica a').attr('id');
	var Comentarios	= jQuery('tr#ID_'+IDProdEquiv).find('td.Comentarios').html();
	var IDProv_exist= 0;

	// Miramos si existe IDProveedor en el desplegable
	jQuery('#PROV_EQUI_DESPLE option').each(function(){
		if(jQuery(this).text() == Proveedor){
			jQuery('#PROV_EQUI_DESPLE').val(jQuery(this).attr('value'));
			proveedorManual(jQuery(this).attr('value'));
			IDProv_exist = 1;
		}
	});

	// No existe IDProveedor => Proveedor desconocido y activamos input text
	if(IDProv_exist == 0){
		jQuery('#PROV_EQUI_DESPLE').val('PROV_MANUAL');
		proveedorManual('PROV_MANUAL');
		jQuery('#PROV_EQUI_MANUAL').val(Proveedor);
	}

	jQuery('#REF_EQUI').val(Referencia);
	jQuery('#NOMBRE_EQUI').val(Nombre);
	jQuery('#MARCA_EQUI').val(Marca);

	jQuery('#IDESTADOEVAL option').each(function(){
		if(jQuery(this).text().toLowerCase() == Evaluacion.toLowerCase()){
			jQuery('#IDESTADOEVAL').val(jQuery(this).attr('value'));
		}
	});

	jQuery('#COMENTARIO_EQUI').val(Comentarios);

	// Ponemos un timeout para dar tiempo a llenar el desplegable de fichas tecnicas
	setTimeout(function(){
		// Miramos si existe IDFichaTec en el desplegable
		jQuery('#IDFICHA option').each(function(){
			if(jQuery(this).attr('value') == IDFichaTec){
				jQuery('#IDFICHA').val(IDFichaTec);
			}
		});
	}, 500);
}
//fin de js cambio fichas segun proveedor