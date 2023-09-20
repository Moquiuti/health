//	Catalogo Privado. Mantenimiento de categorias. Nuevo disenno.
//	Ultima revision: ET 07mar22 15:30. MantFamilias2022_070322.js
jQuery(document).ready(onloadEvents);

function onloadEvents(){
	RecargarInfoCatalogo();

	// Si se cambia el desplegable de categorias
	jQuery('#CATPRIV_IDCATEGORIA').change(function(){
		UltimaRefFamiliaPorCat();
	});

	// Recuperamos la ultima ref.utilizada segun la categoria por defecto (caso 5 niveles)
	if(jQuery('#CATPRIV_IDCATEGORIA').length){
		UltimaRefFamiliaPorCat();
	}else{
		jQuery('span#ley_ref_familia').html(leyenda_ref_nivel2_3niveles.replace('[[CODE_NIVEL2]]', chars_nivel2).replace('[[DIGITO]]',chars_nivel2.length));
	}

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
	var ID		= oForm.elements['CATPRIV_IDFAMILIA'].value;
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
				jQuery("#RefCliente_ERROR .text").html(ya_existe_ref_cliente.replace('[[NIVEL]]',nombre_nivel2));
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

	/* quitamos los espacios sobrantes  */
	for(var n=0;n<form.length;n++){
		if(form.elements[n].type=='text'){
			form.elements[n].value=form.elements[n].value.trim();
		}
	}

	if((form.elements['ACCION'].value == 'MODIFICARFAMILIA')&&(form.elements['CATPRIV_IDFAMILIA'].value!=0)){
		/*	11may22 No se permite modificar la referencia de la familia
		if((!errores) && (esNulo(form.elements['CATPRIV_REFERENCIAFAMILIA'].value))){
			errores++;
			alert(introducir_ref_nuevo_nivel2);
			document.forms[0].elements['CATPRIV_REFERENCIAFAMILIA'].focus();
		}else if ((!errores) && (form.elements['CATPRIV_REFERENCIAFAMILIA'].value.length != chars_nivel2.length)){
			errores++;
			alert(length_ref_nuevo_nivel2.replace('[[DIGITO]]', chars_nivel2.length));
			document.forms[0].elements['CATPRIV_REFERENCIAFAMILIA'].focus();
		}*/
	}else if((form.elements['ACCION'].value == 'NUEVAFAMILIA')||(form.elements['CATPRIV_IDFAMILIA'].value==0)){
		if(form.elements['CATPRIV_REFERENCIA_STRING2'].value == ''){
			document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
			alert(introducir_ref_nuevo_nivel2);
			return;
		}else if(form.elements['CATPRIV_REFERENCIA_STRING2'].value.length != length_nueva_ref_familia){
			// Comprobamos longitud de input CATPRIV_REFERENCIA_STRING2 (1 o 2 segun caracteres para codificacion de este nivel)
			document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
			alert(length_ref_nuevo_nivel2.replace('[[DIGITO]]', chars_nivel2.length));
			return;
		}else if(form.elements['CATPRIV_REFERENCIA_STRING2'].value.length == length_nueva_ref_familia){
			// Comprobamos formato de input CATPRIV_REFERENCIA_STRING2 (2 caracteres alfanumericos)
			var dosChars		= form.elements['CATPRIV_REFERENCIA_STRING2'].value;
			var regex_alfanum	= /^[0-9A-Z]+$/;	//caracteres alfanumericos (solo mayusculas)

			if(!checkRegEx(dosChars, regex_alfanum)){
				document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
				alert(length_ref_nuevo_nivel2.replace('[[DIGITO]]', chars_nivel2.length));
				return;
			}

			form.elements['CATPRIV_REFERENCIAFAMILIA'].value = form.elements['CATPRIV_REFERENCIA_STRING1'].value + form.elements['CATPRIV_REFERENCIA_STRING2'].value;
		}
	}

	if((!errores) && (esNulo(form.elements['CATPRIV_NOMBRE'].value))){
		errores++;
		alert(introducir_nombre_nivel2);
		document.forms[0].elements['CATPRIV_NOMBRE'].focus();
	}

                    //control que no pongan caracteres raros en los textos
                    var inputText = [document.forms[0].elements['CATPRIV_REFERENCIAFAMILIA'].value,document.forms[0].elements['CATPRIV_NOMBRE'].value, document.forms[0].elements['CATPRIV_REFCLIENTE'].value];

                    for (var i=0;i<inputText.length;i++){
                        if(checkRegEx(inputText[i], regex_car_raros)){
                            //si true implica que si ha encontrado caracteres raros
                            errores=1; 
                            raros=1;
                        }

                    }//fin for caracteres raros
                    if (raros =='1') alert(raros_alert);

	/* si los datos son correctos enviamos el form  */
	if(!errores){
        jQuery(".btnDestacado").hide();
		jQuery('#ACCION').val('MODIFICARFAMILIA');
		EnviarCambios(form)
	}
}

function EnviarCambios(form){
	SubmitForm(form);
}

function EjecutarFuncionDelFrame(nombreFrame,nombreFuncion){
	var objFrame=new Object();
	// PS 20170125 objFrame=obtenerFrame(top, nombreFrame);
	objFrame=parent.nombreFrame;

	if(objFrame!=null){
		var retorno=eval('objFrame.'+nombreFuncion);
		if(retorno!=undefined){
			return retorno;
		}
	}
}

function RecargarInfoCatalogo(){
	EjecutarFuncionDelFrame('zonaCatalogo','CambioFamiliaActual('+jQuery('#CATPRIV_IDEMPRESA').val()+',document.forms[\'form1\'].elements[\'CATPRIV_IDFAMILIA\'].value,\'CAMBIOFAMILIA\');');
}

function UltimaRefFamiliaPorCat(){
	var IDEmpresa	= jQuery('#CATPRIV_IDEMPRESA').val();
	var IDCategoria	= jQuery('#CATPRIV_IDCATEGORIA').val();
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/UltimaRefFamiliaPorCat_ajax.xsql',
		type:	"GET",
		data:	"IDEMPRESA="+IDEmpresa+"&IDCATEGORIA="+IDCategoria+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.UltimaReferenciaMVM != '')
				jQuery('span#ley_ref_familia').html(leyenda_ref_nivel2.replace('[[REF_MVM]]', data.UltimaReferenciaMVM).replace('[[CODE_NIVEL2]]', chars_nivel2).replace('[[DIGITO]]',chars_nivel2.length));

			if(data.UltimaReferenciaCliente != '')
				jQuery('span#UltimaRefCliente').html(data.UltimaReferenciaCliente);
			else
				jQuery('span#UltimaRefCliente').html(no_hay);

			// Lanzamos la funcion ajax que devuelve la ref de categoria
			if(document.forms[0].elements['ACCION'].value == 'NUEVAFAMILIA')
				ReferenciaCategoria();
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
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
				// Nivel 1
				jQuery('tr#Nivel_1').hide();
				// Nivel 2
				jQuery('tr#Nivel_2 td.total').html(data.Familias.Total);
				jQuery('tr#Nivel_2 td.ref_cliente').html(data.Familias.ReferenciaCliente ? data.Familias.ReferenciaCliente : no_hay);
				jQuery('tr#Nivel_2 td.ref_mvm').html(data.Familias.ReferenciaMVM);
				// Nivel 3
				jQuery('tr#Nivel_3 td.total').html(data.Subfamilias.Total);
				jQuery('tr#Nivel_3 td.ref_cliente').html(data.Subfamilias.ReferenciaCliente ? data.Subfamilias.ReferenciaCliente : no_hay);
				jQuery('tr#Nivel_3 td.ref_mvm').html(data.Subfamilias.ReferenciaMVM);
				// Nivel 4
				jQuery('tr#Nivel_4').hide();
				// Nivel 5
				jQuery('tr#Nivel_5 td.total').html(data.ProductosEstandar.Total);
				jQuery('tr#Nivel_5 td.ref_cliente').html(data.ProductosEstandar.ReferenciaCliente ? data.ProductosEstandar.ReferenciaCliente : no_hay);
				jQuery('tr#Nivel_5 td.ref_mvm').html(data.ProductosEstandar.ReferenciaMVM);
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}

function ReferenciaCategoria(){
	var IDCategoria	= jQuery('#CATPRIV_IDCATEGORIA').val();
	var d		= new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ReferenciaCategoriaAJAX.xsql',
		type:	"GET",
		data:	"IDCATEGORIA="+IDCategoria+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.ReferenciaCategoria.estado == 'ERROR'){
				null;
			}else{
				// Si no hay error mostramos la RefCategoria donde toca
				jQuery("#CATPRIV_REFERENCIA_TXT").val(data.ReferenciaCategoria.RefCategoria);
				jQuery("#CATPRIV_REFERENCIA_STRING1").val(data.ReferenciaCategoria.RefCategoria);
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}

function ValidarRefFamilia(oForm){
	jQuery("#CATPRIV_REF").css("background-color", "#FFF");
	jQuery("#RefFamilia_ERROR").hide();
	jQuery("#RefFamilia_OK").hide();

	if(oForm.elements['CATPRIV_REFERENCIA_STRING2'].value == ''){
		jQuery("#CATPRIV_REF").css("background-color", "#F3F781");
		oForm.elements['CATPRIV_REFERENCIA_STRING2'].focus();
		alert(introducir_ref_nuevo_nivel2);
		return;
	}else if(oForm.elements['CATPRIV_REFERENCIA_AUX'].value == oForm.elements['CATPRIV_REFERENCIA_STRING1'].value + oForm.elements['CATPRIV_REFERENCIA_STRING2'].value){
		// La referencia no ha cambiado (es la misma)
		jQuery("#CATPRIV_REF").css("background-color", "#BCF5A9");
		jQuery("#RefFamilia_OK").show();
		return;
	}else if(oForm.elements['CATPRIV_REFERENCIA_STRING2'].value.length != length_nueva_ref_familia){
		// Comprobamos longitud de input CATPRIV_REFERENCIA_STRING2 (2 o 3 segun caracteres para codificacion de este nivel)
		jQuery("#CATPRIV_REF").css("background-color", "#F3F781");
		oForm.elements['CATPRIV_REFERENCIA_STRING2'].focus();
		alert(length_ref_nuevo_nivel2.replace('[[DIGITO]]', chars_nivel2.length));
		return;
	}else if(oForm.elements['CATPRIV_REFERENCIA_STRING2'].value.length == length_nueva_ref_familia){
		// Comprobamos formato de input CATPRIV_REFERENCIA_STRING2 (2 caracteres alfanumericos)
		var dosChars		= oForm.elements['CATPRIV_REFERENCIA_STRING2'].value;
		var regex_alfanum	= /^[0-9A-Z]+$/;	//caracteres alfanumericos (solo mayusculas)

		if(!checkRegEx(dosChars, regex_alfanum)){
			jQuery("#CATPRIV_REF").css("background-color", "#F3F781");
			oForm.elements['CATPRIV_REFERENCIA_STRING2'].focus();
			alert(length_ref_nuevo_nivel2.replace('[[DIGITO]]', chars_nivel2.length));
			return;
		}
	}

	var IDEmpresa	= jQuery('#CATPRIV_IDEMPRESA').val();
	var IDCategoria	= jQuery('#CATPRIV_IDCATEGORIA').val();
	var Referencia	= oForm.elements['CATPRIV_REFERENCIA_STRING1'].value + oForm.elements['CATPRIV_REFERENCIA_STRING2'].value;
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ValidarRefFamiliaAJAX.xsql',
		type:	"GET",
		data:	"IDEMPRESA="+IDEmpresa+"&REFERENCIA="+Referencia+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.estado == 'ERROR'){
				jQuery("#CATPRIV_REF").css("background-color", "#F5A9A9");
				jQuery("#RefFamilia_ERROR_TXT").html(ya_existe_ref_nivel2.replace('[[REF]]',Referencia));
				jQuery("#RefFamilia_ERROR").show();
				oForm.elements['CATPRIV_REFERENCIA_STRING2'].focus();
			}else{
				// Si no hay error continuamos
				jQuery("#CATPRIV_REF").css("background-color", "#BCF5A9");
				jQuery("#RefFamilia_OK").show();
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}
