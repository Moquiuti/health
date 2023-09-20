
//	Variables globales

jQuery(document).ready(globalEvents);

function globalEvents(){
	null;
}

var rowStart		= '<tr>';
var rowStartIDStyle	= '<tr id="#ID#" style="#STYLE#">';
var rowEnd		= '</tr>';

var cellStart		= '<td>';
var cellStartClass	= '<td class="#CLASS#">';
var cellStartClassStyle	= '<td class="#CLASS#" style="#STYLE#">';
var cellEnd		= '</td>';

var anchorStart		= '<a href="#HREF#" style="text-decoration:none;">';
var anchorEnd		= '</a>';

// Funcion que recoje datos de la linea actual (si se pasa ID como parametro) y abre pop-up para editar
// Si no se pasa ID como parametro, entonces se inserta una nueva fila de datos
function abrirBoxEntradaDatos(ID){

	cleanTableInfoHistorica();

	if(ID == null){
		jQuery("span#newDatos").show();
		jQuery("tr#trIDCentro").show();
		var Nombre	= jQuery("#NOMBRE_BASE").html();
		var UdBasica	= jQuery("#UDBASICA_BASE").val();

		jQuery("#NOMBRE").val(Nombre);
		jQuery("#UDBASICA").val(UdBasica);
	}else{
		var NomCentro	= jQuery("#CEN_" + ID).html();
		var IDCentro	= jQuery("#IDCEN_" + ID).html();
		var Nombre	= jQuery("#NOM_" + ID).html();
		var Proveedor	= jQuery("#PROV_" + ID).html();
		var RefProv	= (jQuery("#REFP_" + ID).length) ? jQuery("#REFP_" + ID).html() : '';
		var RefCliente	= (jQuery("#REFC_" + ID).length) ? jQuery("#REFC_" + ID).html() : '';
		var UdBasica	= jQuery("#UDB_" + ID).html();
		var UdsLote	= jQuery("#UDL_" + ID).html();
		var Precio	= jQuery("#PR_" + ID).html();
		var Cantidad	= jQuery("#CANT_" + ID).html();
		var Anotaciones	= jQuery("#ANOT_" + ID).html().replace(/<br>/gi,'\n');

		jQuery("span#modDatos").show();
		jQuery("span#NombreCentro").html(NomCentro);
		jQuery("#ID").val(ID);
		jQuery("#IDCENTRO").val(IDCentro);
		jQuery("#NOMBRE").val(Nombre);
		jQuery("#REFCLI").val(RefCliente);
		jQuery("#PROVEEDOR").val(Proveedor);
		jQuery("#REFPROV").val(RefProv);
		jQuery("#UDBASICA").val(UdBasica);
		jQuery("#UDSLOTE").val(UdsLote);
		jQuery("#PRECIO").val(Precio);
		jQuery("#CANTIDAD").val(Cantidad);
		jQuery("#ANOTACIONES").val(Anotaciones);
	}

	showTablaByID("InfoHistorica");
}

function cleanTableInfoHistorica(){
	jQuery("tr#trIDCentro").hide();
	jQuery("span#modDatos").hide();
	jQuery("span#newDatos").hide();
	jQuery("span#NombreCentro").html('');
	jQuery("#ID").val('');
	jQuery("#IDCENTRO").val('');
	jQuery("#NOMBRE").val('');
	jQuery("#REFCLI").val('');
	jQuery("#PROVEEDOR").val('');
	jQuery("#REFPROV").val('');
	jQuery("#UDBASICA").val('');
	jQuery("#UDSLOTE").val('');
	jQuery("#PRECIO").val('');
	jQuery("#CANTIDAD").val('');
	jQuery("#ANOTACIONES").val('');
}

function validarForm(){
	var oForm	= document.forms['entradaDatosForm'];
	var ID		= jQuery('#ID').val();
	var errores	= 0, valAux;

	if(ID == ''){		// MODO NUEVA ENTRADA
		// Validamos desplegable centros
		if((!errores) && (esNulo(oForm.elements['IDCENTRO'].value))){
			errores++;
			alert(val_faltaCentro);
			oForm.elements['IDCENTRO'].focus();
		}
	}else{			// MODO EDICION ENTRADA ANTIGUA

	}

	// Validamos input ud basica
	if((!errores) && (esNulo(oForm.elements['UDBASICA'].value))){
		errores++;
		alert(val_faltaUdBasica);
		oForm.elements['UDBASICA'].focus();
	}

	// Validamos input precio que tenga buen formato
	valAux	= jQuery('#PRECIO').val().replace(",",".");
	if(!errores && isNaN(valAux)){
		errores++;
		alert(val_malPrecio);
		oForm.elements['PRECIO'].focus();
	}else{
		jQuery('#PRECIO').val(valAux.replace(".", ","));
	}

	// Validamos input cantidad anual
	valAux	= jQuery('#CANTIDAD').val().replace(",",".");
	if((!errores) && (esNulo(valAux))){
		errores++;
		alert(val_faltaCantAnual);
		oForm.elements['CANTIDAD'].focus();
	}else if(!errores && (Math.floor(valAux) != valAux || !jQuery.isNumeric(valAux))){
		errores++;
		alert(val_malCantAnual);
		oForm.elements['CANTIDAD'].focus();
	}else{
		jQuery('#CANTIDAD').val(valAux.replace(".", ","));
	}

	// Validamos input udsLote sea numérico
	valAux	= jQuery('#UDSLOTE').val().replace(",",".");
	if(!errores && (Math.floor(valAux) != valAux || !jQuery.isNumeric(valAux))){
		errores++;
		alert(val_malUdsLote);
		oForm.elements['UDSLOTE'].focus();
	}else{
		jQuery('#UDSLOTE').val(valAux.replace(".", ","));
	}


	if(!errores){
		guardarDatosHistoricos();
	}
}


function guardarDatosHistoricos(){
	var ID		= jQuery('#ID').val();
	var IDEmpresa	= jQuery('#IDEMPRESA').val();
	var IDProdEst	= jQuery('#IDPRODESTANDAR').val();
	var IDCentro	= jQuery('#IDCENTRO').val();
	var Proveedor	= jQuery('#PROVEEDOR').val();
	var RefCliente	= jQuery('#REFCLI').val();
	var RefProv	= jQuery('#REFPROV').val();
	var Nombre	= jQuery('#NOMBRE').val();
	var UdBasica	= jQuery('#UDBASICA').val();
	var UdsLote	= jQuery('#UDSLOTE').val();
	var Precio	= jQuery('#PRECIO').val();
	var CantAnual	= jQuery('#CANTIDAD').val();
	var Anotaciones	= jQuery('#ANOTACIONES').val().replace(/'/g, "''");
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/GuardarDatosInfoHistoricoAJAX.xsql',
		type:	"POST",
		data:	"ID="+ID+"&IDEMPRESA="+IDEmpresa+"&IDCENTRO="+IDCentro+"&IDPRODESTANDAR="+IDProdEst+"&PROVEEDOR="+Proveedor+"&REFCLIENTE="+RefCliente+"&REFPROV="+RefProv+"&NOMBRE="+Nombre+"&UDBASICA="+UdBasica+"&UDSLOTE="+UdsLote+"&PRECIO="+Precio+"&CANTANUAL="+CantAnual+"&ANOTACIONES="+encodeURIComponent(Anotaciones)+"&_="+d.getTime(),
		beforeSend: function(){
			jQuery("#GuardarDatos").hide();
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
			jQuery("#GuardarDatos").show();
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.Resultado.Estado == 'OK'){
				jQuery("td#Respuesta").addClass("verde").html(str_guardarDatosOK);
				location.reload();
			}else{
				jQuery("td#Respuesta").addClass("rojo2").html(str_guardarDatosKO);
				jQuery("#GuardarDatos").show();
			}
		}
	});
}

function guardarDatosBasicos(){
	var PrecioMVM	= jQuery('#PRECIO_MVM').val();
	var UdBasica	= jQuery('#UDBASICA_BASE').val();
	var errores	= 0, valAux;
	var d = new Date();

	// Validamos precio MVM
	valAux	= PrecioMVM.replace(",",".");
	if(!esNulo(valAux) && isNaN(valAux)){
		errores++;
		alert(val_malPrecioMVM);
		jQuery('#PRECIO_MVM').focus();
	}else{
		jQuery('#PRECIO_MVM').val(valAux.replace(".", ","));
	}
	// Validamos Unidad basica
	if((!errores) && (esNulo(UdBasica))){
		errores++;
		alert(val_faltaUdBasica);
		jQuery('#UDBASICA_BASE').focus();
	}

	if(errores){
		return;
	}

	var IDEmpresa	= jQuery('#IDEMPRESA').val();
	var IDProdEst	= jQuery('#IDPRODESTANDAR').val();
	PrecioMVM	= jQuery('#PRECIO_MVM').val();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/GuardarDatosBasicosAJAX.xsql',
		type:	"GET",
		data:	"IDEMPRESA="+IDEmpresa+"&IDPRODESTANDAR="+IDProdEst+"&UDBASICA="+UdBasica+"&PRECIOMVM="+PrecioMVM+"&_="+d.getTime(),
		beforeSend: function(){
			jQuery("#GuardarDatosBasicos").hide();
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
			jQuery("#GuardarDatosBasicos").show();
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.Resultado.Estado == 'OK'){
				alert(str_guardarDatosOK);
				location.reload();
			}else{
				alert(str_guardarDatosKO);
				jQuery("#GuardarDatosBasicos").show();
			}
		}
	});
}
