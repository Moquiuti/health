//	Catalogo Privado. Mantenimiento de categorias. Nuevo disenno.
//	Ultima revision: ET 07mar22 15:30. MantCategorias2022_070322.js

jQuery(document).ready(onloadEvents);

function onloadEvents(){
	jQuery('span#ley_ref_categoria').html(leyenda_ref_nivel1.replace('[[CODE_NIVEL1]]', chars_nivel1));

	// Si se hace click sobre el icono de info
	jQuery('#toggleResumenCatalogo').click(function(){
		if(!jQuery("#ResumenCatalogo").is(':visible'))
			ResumenCatalogo();

		jQuery("#ResumenCatalogo").toggle("slow");
	});
}


function ValidarRefCliente(oForm, Nivel){
	jQuery("#CATPRIV_REFCLIENTE").css("background-color", "#FFF");
	jQuery("#RefCliente_ERROR").hide();
	jQuery("#RefCliente_OK").hide();

	if(oForm.elements['CATPRIV_REFCLIENTE'].value == ''){
		jQuery("#CATPRIV_REFCLIENTE").css("background-color", "#F3F781");
		oForm.elements['CATPRIV_REFCLIENTE'].focus();
		alert(document.forms['MensajeJS'].elements['OBLI_REF_CLIENTE_PROD_ESTANDAR'].value);
		return;
	}else if(oForm.elements['CATPRIV_REFCLIENTE_AUX'].value == oForm.elements['CATPRIV_REFCLIENTE'].value){
		// La referencia no ha cambiado (es la misma)
		jQuery("#CATPRIV_REFCLIENTE").css("background-color", "#BCF5A9");
		jQuery("#RefCliente_OK").show();
		return;
	}

	var IDEmpresa	= jQuery('#CATPRIV_IDEMPRESA').val();
	var Referencia	= oForm.elements['CATPRIV_REFCLIENTE'].value;
	var ID		= oForm.elements['CATPRIV_IDCATEGORIA'].value;
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ValidarRefClienteAJAX.xsql',
		type:	"GET",
		data:	"IDEMPRESA="+IDEmpresa+"&REFERENCIA="+Referencia+"&CP_ID="+ID+"&NIVEL="+Nivel+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.estado == 'ERROR'){
				jQuery("#RefCliente_ERROR .text").html(ya_existe_ref_cliente.replace('[[NIVEL]]',nombre_nivel1));
				jQuery("#RefCliente_ERROR").show();
				jQuery("#CATPRIV_REFCLIENTE").css("background-color", "#F5A9A9");
				jQuery("#RefCliente_ERROR").show();
				oForm.elements['CATPRIV_REFCLIENTE'].focus();
			}else{
				// Si no hay error continuamos
				jQuery("#CATPRIV_REFCLIENTE").css("background-color", "#BCF5A9");
				jQuery("#RefCliente_OK").show();
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}

function ValidarFormulario(form){
    var regex_car_raros     = new RegExp("[\%|\$|\#|\\|\'|\&\|]","g"); //caracteres raros que no queremos en los campos de texto (requisito MVM)
    var raros=0;
	var errores=0;
	for(var n=0;n<form.length;n++){
		if(form.elements[n].type=='text'){
			/* quitamos los espacios sobrantes  */
			//form.elements[n].value=quitarEspacios(form.elements[n].value);
			form.elements[n].value=form.elements[n].value.trim();
		}
	}

	if((!errores) && (esNulo(form.elements['CATPRIV_REFERENCIACATEGORIA'].value))){
		errores++;
		alert(introducir_ref_nuevo_nivel1);
		document.forms[0].elements['CATPRIV_REFERENCIACATEGORIA'].focus();
	}else if ((!errores) && (form.elements['CATPRIV_REFERENCIACATEGORIA'].value.length != chars_nivel1.length)){
		errores++;
		alert(length_ref_nuevo_nivel1.replace('[[DIGITO]]', chars_nivel1.length));
		document.forms[0].elements['CATPRIV_REFERENCIACATEGORIA'].focus();
	}

	if((!errores) && (esNulo(form.elements['CATPRIV_NOMBRE'].value))){
		errores++;
		alert(introducir_nombre_nivel1);
		document.forms[0].elements['CATPRIV_NOMBRE'].focus();
	}

                    //control que no pongan caracteres raros en los textos
                    var inputText = [document.forms[0].elements['CATPRIV_REFERENCIACATEGORIA'].value,document.forms[0].elements['CATPRIV_NOMBRE'].value, document.forms[0].elements['CATPRIV_REFCLIENTE'].value];

                    for (var i=0;i<inputText.length;i++){
                    //var f=checkRegEx(inputText[i], regex_car_raros); alert ('valor f '+f);
                        if(checkRegEx(inputText[i], regex_car_raros)){
                            //si true implica que si ha encontrado caracteres raros
                            errores=1; 
                            raros=1;
                        }
                    }//fin for caracteres raros
                    if (raros =='1') alert(raros_alert);

	/* si los datos son correctos enviamos el form  */
	if(!errores){
        jQuery(".btnestacado").hide();
		jQuery('#ACCION').val('MODIFICARCATEGORIA');
		EnviarCambios(form)
	}
}

function EnviarCambios(form){
	SubmitForm(form);
}

function EjecutarFuncionDelFrame(nombreFrame,nombreFuncion){
	var objFrame=new Object();
	objFrame=obtenerFrame(top, nombreFrame);

	if(objFrame!=null){
		var retorno=eval('objFrame.'+nombreFuncion);
		if(retorno!=undefined){
			return retorno;
		}
	}
}

function RecargarInfoCatalogo(){
	EjecutarFuncionDelFrame('zonaCatalogo','CambioCategoriaActual('+jQuery('#CATPRIV_IDEMPRESA').val()+',document.forms[\'form1\'].elements[\'CATPRIV_IDCATEGORIA\'].value,\'CAMBIOCATEGORIA\');');
}

function ResumenCatalogo(){
	var IDEmpresa	= jQuery('#CATPRIV_IDEMPRESA').val();
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ResumenCatalogo_ajax.xsql',
		type:	"GET",
		data:	"IDEMPRESA="+IDEmpresa+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.Categorias){		// Tenemos 5 niveles
				// Nivel 1
				jQuery('tr#Nivel_1 td.total').html(data.Categorias.Total);
				jQuery('tr#Nivel_1 td.ref_cliente').html(data.Categorias.ReferenciaCliente ? data.Categorias.ReferenciaCliente : no_hay);
				jQuery('tr#Nivel_1 td.ref_mvm').html(data.Categorias.ReferenciaMVM);
				// Nivel 2
				jQuery('tr#Nivel_2 td.total').html(data.Familias.Total);
				jQuery('tr#Nivel_2 td.ref_cliente').html(data.Familias.ReferenciaCliente ? data.Familias.ReferenciaCliente : no_hay);
				jQuery('tr#Nivel_2 td.ref_mvm').html(data.Familias.ReferenciaMVM);
				// Nivel 3
				jQuery('tr#Nivel_3 td.total').html(data.Subfamilias.Total);
				jQuery('tr#Nivel_3 td.ref_cliente').html(data.Subfamilias.ReferenciaCliente ? data.Subfamilias.ReferenciaCliente : no_hay);
				jQuery('tr#Nivel_3 td.ref_mvm').html(data.Subfamilias.ReferenciaMVM);
				// Nivel 4
				jQuery('tr#Nivel_4 td.total').html(data.Grupos.Total);
				jQuery('tr#Nivel_4 td.ref_cliente').html(data.Grupos.ReferenciaCliente ? data.Grupos.ReferenciaCliente : no_hay);
				jQuery('tr#Nivel_4 td.ref_mvm').html(data.Grupos.ReferenciaMVM);
				// Nivel 5
				jQuery('tr#Nivel_5 td.total').html(data.ProductosEstandar.Total);
				jQuery('tr#Nivel_5 td.ref_cliente').html(data.ProductosEstandar.ReferenciaCliente ? data.ProductosEstandar.ReferenciaCliente : no_hay);
				jQuery('tr#Nivel_5 td.ref_mvm').html(data.ProductosEstandar.ReferenciaMVM);

			}else if(data.Familias){	// Tenemos 3 niveles
				null;
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}



