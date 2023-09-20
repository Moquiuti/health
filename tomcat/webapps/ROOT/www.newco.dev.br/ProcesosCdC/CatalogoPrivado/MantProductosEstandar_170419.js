//	JS para el mantenimiento de productos estándar
//	Ultima revisión: 17abr19 14:25

jQuery(document).ready(onloadEvents);

function onloadEvents(){
	// Si se cambia el desplegable de grupo (caso 5 niveles)
	jQuery('#CATPRIV_IDGRUPO').change(function(){
		UltimaRefProductoPorGrupo();
	});

	// Si se cambia el desplegable de subfamilia (caso 3 niveles)
	jQuery('#CATPRIV_IDSUBFAMILIA').change(function(){
		if(jQuery('#CATPRIV_IDGRUPO').length == 0)
			UltimaRefProductoPorSF();
	});

	// Recuperamos la ultima ref.utilizada segun el grupo por defecto (caso 5 niveles)
	if(jQuery('#CATPRIV_IDGRUPO').length){
		UltimaRefProductoPorGrupo();
	// Recuperamos la ultima ref.utilizada segun la subfamilia por defecto (caso 3 niveles)
	}else if(jQuery('#CATPRIV_IDSUBFAMILIA').length){
		UltimaRefProductoPorSF();
	}
	// Si se hace click sobre el icono de info
	jQuery('#toggleResumenCatalogo').click(function(){
		if(!jQuery("#ResumenCatalogo").is(':visible'))
			ResumenCatalogo();

		jQuery("#ResumenCatalogo").toggle("slow");
	});
}


function ValidarRefProdEstandar(form){
	jQuery("#CATPRIV_REF").css("background-color", "#FFF");
	jQuery("#RefProd_ERROR").hide();
	jQuery("#RefProd_OK").hide();

	if(form.elements['CATPRIV_REFERENCIA_STRING2'].value == ''){
		jQuery("#CATPRIV_REF").css("background-color", "#F3F781");
		document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
		alert(document.forms['MensajeJS'].elements['OBLI_REF_PROD_ESTANDAR'].value);
		return;
	}else if(form.elements['CATPRIV_REFERENCIA_AUX'].value == form.elements['CATPRIV_REFERENCIA_STRING1'].value + form.elements['CATPRIV_REFERENCIA_STRING2'].value){
		// La referencia no ha cambiado (es la misma)
		jQuery("#CATPRIV_REF").css("background-color", "#BCF5A9");
		jQuery("#RefProd_OK").show();
		return;
	}else if(form.elements['CATPRIV_REFERENCIA_STRING2'].value.length < 2 || form.elements['CATPRIV_REFERENCIA_STRING2'].value.length > 3){
		// Comprobamos longitud de input CATPRIV_REFERENCIA_STRING2 (2 o 3)
		jQuery("#CATPRIV_REF").css("background-color", "#F3F781");
		document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
		alert(document.forms['MensajeJS'].elements['LENGTH_REF_NUEVO_PROD_EST'].value);
		return;
	}else if(form.elements['CATPRIV_REFERENCIA_STRING2'].value.length == 2){
		// Comprobamos formato de input CATPRIV_REFERENCIA_STRING2 (2 caracteres alfanumericos)
		var dosChars		= form.elements['CATPRIV_REFERENCIA_STRING2'].value;
		var regex_alfanum	= /^[0-9A-Z]+$/;	//caracteres alfanumericos (solo mayusculas)

		if(!checkRegEx(dosChars, regex_alfanum)){
			jQuery("#CATPRIV_REF").css("background-color", "#F3F781");
			document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
			alert(document.forms['MensajeJS'].elements['LENGTH_REF_NUEVO_PROD_EST'].value);
			return;
		}
	}else if(form.elements['CATPRIV_REFERENCIA_STRING2'].value.length == 3){
		var dosChars = form.elements['CATPRIV_REFERENCIA_STRING2'].value.substring(0,2);
		var ultimoDigito = form.elements['CATPRIV_REFERENCIA_STRING2'].value.substring(2);
		var regex_alfanum	= /^[0-9A-Z]+$/;	//caracteres alfanumericos (solo mayusculas)

		if(!checkRegEx(dosChars, regex_alfanum)){
			jQuery("#CATPRIV_REF").css("background-color", "#F3F781");
			document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
			alert(document.forms['MensajeJS'].elements['LENGTH_REF_NUEVO_PROD_EST'].value);
			return;
		}

		if(isNaN(ultimoDigito) !== true){
			jQuery("#CATPRIV_REF").css("background-color", "#F3F781");
			document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
			alert(document.forms['MensajeJS'].elements['LENGTH_REF_NUEVO_PROD_EST'].value);
			return;
		}
	}

	var IDEmpresa	= jQuery('#CATPRIV_IDEMPRESA').val();
	var Referencia	= form.elements['CATPRIV_REFERENCIA_STRING1'].value + form.elements['CATPRIV_REFERENCIA_STRING2'].value;
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ValidarRefProdEstandarAJAX.xsql',
		type:	"GET",
		data:	"IDEMPRESA="+IDEmpresa+"&REFERENCIA="+Referencia+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.estado == 'ERROR'){
				jQuery("#CATPRIV_REF").css("background-color", "#F5A9A9");
				jQuery("#RefProd_ERROR").show();
				document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();

			}else{
				// Si no hay error continuamos
				jQuery("#CATPRIV_REF").css("background-color", "#BCF5A9");
				jQuery("#RefProd_OK").show();
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
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
	var ID		= oForm.elements['CATPRIV_ID'].value;
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
    var regex_car_raros     = new RegExp("[\#|\\|\'\|]","g"); //caracteres raros que no queremos en los campos de texto (requisito MVM)
    var regex_prod_estandar	= new RegExp("^[0-9a-zA-Z ]+$","g"); // Expresion regular para controlar el campo que solo puede incluir números y letras (requisito MVM)
    var raros=0;
	var errores=0;
	
	//solodebug	console.log('ValidarFormulario. Ref1:'+form.elements['CATPRIV_REFERENCIA_STRING1'].value+' Ref2:'+form.elements['CATPRIV_REFERENCIA_STRING2'].value);
	

	// quitamos los espacios sobrantes  
	for(var n=0;n<form.length;n++){
		if(form.elements[n].type=='text'){
			form.elements[n].value=quitarEspacios(form.elements[n].value);
		}
	}

	if((!errores) && (esNulo(form.elements['CATPRIV_IDSUBFAMILIA'].value))){
		errores++;
		alert(document.forms['MensajeJS'].elements['OBLI_FAMILIA_PROD_ESTANDAR'].value);
		document.forms[0].elements['CATPRIV_IDSUBFAMILIA'].focus();
	}

	// Solo permitimos modificar las últimas 2 cifras de la ref. (o 3 si se trata de una variante de producto)
	// Trabajamos con inputs hidden (CATPRIV_REFERENCIA, CATPRIV_REFERENCIA_STRING1, CATPRIV_REFERENCIA_AUX) y con input text (CATPRIV_REFERENCIA_STRING2)
	if((!errores) && form.elements['CATPRIV_REFERENCIA_STRING2'] && (esNulo(form.elements['CATPRIV_REFERENCIA_STRING2'].value))){
		errores++;
		alert(document.forms['MensajeJS'].elements['OBLI_REF_PROD_ESTANDAR'].value);
		document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
	}else if((!errores) && form.elements['CATPRIV_REFERENCIA_STRING2'] && (form.elements['CATPRIV_REFERENCIA_STRING2'].value.length < 2 || form.elements['CATPRIV_REFERENCIA_STRING2'].value.length > 3)){
		errores++;
		alert(document.forms['MensajeJS'].elements['LENGTH_REF_NUEVO_PROD_EST'].value);
		
		document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
	}else if(form.elements['CATPRIV_REFERENCIA_STRING2'] && form.elements['CATPRIV_REFERENCIA_STRING2'].value.length == 2){
		// Comprobamos formato de input CATPRIV_REFERENCIA_STRING2 (2 caracteres alfanumericos)
		var dosChars		= form.elements['CATPRIV_REFERENCIA_STRING2'].value;
		var regex_alfanum	= /^[0-9A-Z]+$/;	//caracteres alfanumericos (solo mayusculas)

		if(!checkRegEx(dosChars, regex_alfanum)){
			errores++;
			document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
		
			alert(document.forms['MensajeJS'].elements['LENGTH_REF_NUEVO_PROD_EST'].value);
		}

		form.elements['CATPRIV_REFERENCIA'].value = form.elements['CATPRIV_REFERENCIA_STRING1'].value + form.elements['CATPRIV_REFERENCIA_STRING2'].value;
	}else if(form.elements['CATPRIV_REFERENCIA_STRING2'] && form.elements['CATPRIV_REFERENCIA_STRING2'].value.length == 3){
		var dosChars = form.elements['CATPRIV_REFERENCIA_STRING2'].value.substring(0,2);
		var ultimoDigito = form.elements['CATPRIV_REFERENCIA_STRING2'].value.substring(2);
		var regex_alfanum	= /^[0-9A-Z]+$/;	//caracteres alfanumericos (solo mayusculas)

		if(!checkRegEx(dosChars, regex_alfanum)){
			errores++;
			document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
		
			alert(document.forms['MensajeJS'].elements['LENGTH_REF_NUEVO_PROD_EST'].value);
		}
		
		//	Este mensaje de error era para forzar 8 numeros, pero ahora manejamos letras en los primeros 8 caracteres
		//if(isNaN(ultimoDigito) !== true){
		//	errores++;
		//	document.forms[0].elements['CATPRIV_REFERENCIA_STRING2'].focus();
	
		//solodebug
		//console.log('ValidarFormulario. Err4. Ref1:'+form.elements['CATPRIV_REFERENCIA_STRING1'].value+' Ref2:'+form.elements['CATPRIV_REFERENCIA_STRING2'].value);
		
		//	alert(document.forms['MensajeJS'].elements['LENGTH_REF_NUEVO_PROD_EST'].value);
		//}
		

		form.elements['CATPRIV_REFERENCIA'].value = form.elements['CATPRIV_REFERENCIA_STRING1'].value + form.elements['CATPRIV_REFERENCIA_STRING2'].value;
	}

	// miramos que si el catalogo es estricto, la referencia lo sea, esto es, ref=ref_fam+ref_subfam+2 o mas digitos
	//  permitimos una letra

	if((!errores && esNulo(form.elements['CATPRIV_NOMBRE'].value))){
		errores++;
		alert(document.forms['MensajeJS'].elements['OBLI_NOMBRE_PROD_ESTANDAR'].value);
		document.forms[0].elements['CATPRIV_NOMBRE'].focus();
	}


	var nuevaReferencia=quitarEspacios(form.elements['CATPRIV_REFERENCIA'].value.toUpperCase());
	var ReferenciaOriginal=quitarEspacios(form.elements['REFERENCIAORIGINAL'].value.toUpperCase());
	var nuevoNombre=quitarEspacios(form.elements['CATPRIV_NOMBRE'].value.toUpperCase());
	var NombreOriginal=quitarEspacios(form.elements['NOMBREORIGINAL'].value.toUpperCase());


    //control que no pongan caracteres raros en los textos
    var inputText = [document.forms[0].elements['CATPRIV_REFERENCIA'].value,document.forms[0].elements['CATPRIV_NOMBRE'].value,document.forms[0].elements['CATPRIV_NOMBRE_PRIVADO'].value,document.forms[0].elements['CATPRIV_REFCLIENTE'].value];

    for (var i=0;i<inputText.length;i++){
    //var f=checkRegEx(inputText[i], regex_car_raros); alert ('valor f '+f);
        if(checkRegEx(inputText[i], regex_car_raros)){
            //si true implica que si ha encontrado caracteres raros
            errores=1; 
            raros=1;
        }
    }//fin for caracteres raros
    if (raros =='1') alert(raros_alert);


    //	Requiere licitacion
    if (form.elements['REQUIERELICITACION'] && form.elements['REQUIERELICITACION'].checked==true){
        form.elements['REQUIERELICITACION'].value = 'S';
    }
    else{form.elements['REQUIERELICITACION'].value = 'N';}

    //	24ene18	Producto regulado
    if (form.elements['CHK_REGULADO'] && form.elements['CHK_REGULADO'].checked==true){
        form.elements['REGULADO'].value = 'S';
    }
    else{form.elements['REGULADO'].value = 'N';}

    //	20mar19 Oncologico
    if (form.elements['CP_PRO_ONCOLOGICO'] && form.elements['CP_PRO_ONCOLOGICO'].checked==true){
        form.elements['CP_PRO_ONCOLOGICO'].value = 'S';
    }
    else{form.elements['CP_PRO_ONCOLOGICO'].value = 'N';}

    //text licitacion
    //if (form.elements['CP_PRO_IDTEXTOLICITACION'] && form.elements['CP_PRO_IDTEXTOLICITACION'].value != '' && (!checkRegEx(form.elements['CP_PRO_IDTEXTOLICITACION'].value, regex_prod_estandar)) ){
    //     alert(raros_prod_estandar);
    //     errores++;
    //}

    //cambiar precio de referencia 4-6-15
    if(form.elements['CATPRIV_PRECIOREFERENCIA'] && form.elements['CATPRIV_PRECIOREFERENCIA'].value != '' && form.elements['CATPRIV_PRECIOREFERENCIA_OLD'].value != '' && (form.elements['CATPRIV_PRECIOREFERENCIA'].value != form.elements['CATPRIV_PRECIOREFERENCIA_OLD'].value)){
        if(confirm(document.forms['MensajeJS'].elements['SEGURO_CAMBIAR_PRECIO_REF'].value)){}
        else{ errores++; }
    }
    //dejar vacío precio de referencia 4-6-15
    if(form.elements['CATPRIV_PRECIOREFERENCIA'] && form.elements['CATPRIV_PRECIOREFERENCIA_OLD'].value != '' && form.elements['CATPRIV_PRECIOREFERENCIA'].value == ''){
        if(confirm(document.forms['MensajeJS'].elements['SEGURO_CAMBIAR_PRECIO_REF_ZERO'].value)){}
        else{ errores++; }
    }


	//	Prepara la lista de centros para enviar, recorriendo todos los elementos CHK_CENTRO
	var cadenaCentros='';
	for (i=0;i<form.elements.length;++i)
	{
		//solodebug	console.log('Comprobando elemento:'+form.elements[i].name);

		if (form.elements[i].name.substring(0,10)=='CHK_CENTRO')
		{
			var ID=Piece(form.elements[i].name,'_',2);
			var Autorizado=(form.elements[i].checked==true)?'S':'N';

			cadenaCentros=cadenaCentros+ID+'#'+Autorizado+'#'+form.elements["REFCENTRO_"+ID].value+'#'+form.elements["ORDEN_"+ID].value+'#'+form.elements["PRECIOREF_"+ID].value+'#'+form.elements["MARCAS_"+ID].value+'|';

			//solodebug	console.log('Elemento:'+form.elements[i].name+' checked:'+form.elements[i].checked+' Cadena:'+cadenaCentros);
		}
	}
	//solodebug	alert(cadenaCentros)
	form.elements['LISTA_CENTROS'].value=cadenaCentros;

	// si los datos son correctos enviamos el form 
	if(!errores){
        jQuery(".boton").hide();
		EnviarCambios(form)
	}
}

// permitimos 8 o 9 caracteres
function esReferenciaEstricta(form){
	//alert('Referencia:'+form.elements['CATPRIV_REFERENCIA'].value+' length'+form.elements['CATPRIV_REFERENCIA'].value.length+ ' ref estricta:'+montarReferenciaEstricta(form));

	if(form.elements['CATPRIV_REFERENCIA'].value.substring(0,montarReferenciaEstricta(form).length)==montarReferenciaEstricta(form)
	&& ((form.elements['CATPRIV_REFERENCIA'].value.length==8) || (form.elements['CATPRIV_REFERENCIA'].value.length==9))){
		return 1;
	}else{
		return 0;
	}
}

function montarReferenciaEstricta(form){
	// buscamos la ref de familia y de subfamilia
	var encontrado=0;
	var refFamilia='';
	var refSubfamilia='';
	for(var n=0;n<arrTodasSubfamilias.length && !encontrado;n++){
		var arrFamilia=arrTodasSubfamilias[n][0];
		if(arrFamilia[0]==form.elements['CATPRIV_IDFAMILIA'].value){
			refFamilia=arrFamilia[1];
			for(var i=1;i<arrTodasSubfamilias[n].length;i++){
				var arrSubfamilia=arrTodasSubfamilias[n][i];
				if(arrSubfamilia[0]==form.elements['CATPRIV_IDSUBFAMILIA'].value){
					var refSubfamilia=arrSubfamilia[2];
					encontrado=1;
				}
			}
		}
	}
	return refFamilia+refSubfamilia;
}

function EnviarCambios(form){
	SubmitForm(form);
}

function ValidarNumero(obj,decimales){
	if(checkNumberNulo(obj.value,obj)){
		if(parseFloat(reemplazaComaPorPunto(obj.value))!=0){
			obj.value=anyadirCerosDecimales(reemplazaPuntoPorComa(Round(reemplazaComaPorPunto(obj.value),decimales)),decimales);
		}
		return true;
	}
	return false;
}


// Cambio en el desplegable de Categoria, informa familias
function CambioCategoriaActual(valor,accion){
	var objName='CATPRIV_IDFAMILIA';
	var encontrado=0;
	var arrFamilia=new Array();
	//alert('mi '+arrTodasFamilias.length);
	for(var n=0;n<arrTodasFamilias.length && !encontrado;n++){
		var arrCategoria=arrTodasFamilias[n][0];
		if(arrCategoria[0]==valor){
			encontrado=1;
			arrFamilias=arrTodasFamilias[n];
		}
	}

	document.forms['form1'].elements['IDCATEGORIA'].value=document.forms['form1'].elements['CATPRIV_IDCATEGORIA'].value;
	document.forms['form1'].elements[objName].length=0;
	for(var n=1;n<arrFamilias.length;n++){
		var id=arrFamilias[n][0];
		var elemento=arrFamilias[n][1];
		var addOption=new Option(elemento,id);
		document.forms['form1'].elements[objName]
		document.forms['form1'].elements[objName].options[document.forms['form1'].elements[objName].length]=addOption;
	}
	//alert('val '+document.forms['form1'].elements[objName].value);
	CambioFamiliaActual(document.forms['form1'].elements[objName].value,'CAMBIOSUBFAMILIA');
}

function CambioFamiliaActual(valor,accion){
	var objName='CATPRIV_IDSUBFAMILIA';
	var encontrado=0;
	var arrSubfamilias=new Array();
	for(var n=0;n<arrTodasSubfamilias.length && !encontrado;n++){
		var arrFamilia=arrTodasSubfamilias[n][0];
		//alert(arrFamilia);
		if(arrFamilia[0]==valor){
			encontrado=1;
			arrSubfamilias=arrTodasSubfamilias[n];
		}
	}
	document.forms['form1'].elements['IDFAMILIA'].value=document.forms['form1'].elements['CATPRIV_IDFAMILIA'].value;
	document.forms['form1'].elements[objName].length=0;
	for(var n=1;n<arrSubfamilias.length;n++){
		var id=arrSubfamilias[n][0];
		var elemento=arrSubfamilias[n][1];
		var addOption=new Option(elemento,id);
		document.forms['form1'].elements[objName]
		document.forms['form1'].elements[objName].options[document.forms['form1'].elements[objName].length]=addOption;
	}
	CambioSubfamiliaActual(document.forms['form1'].elements[objName].value,'CAMBIOGRUPO');
}

//	Cambio de la subfamilia
function CambioSubfamiliaActual(valor,accion){

	var objName='CATPRIV_IDGRUPO';
	var encontrado=0;
	var arrGrupos=new Array();

	for(var n=0;n<arrTodasGrupos.length && !encontrado;n++){
		var arrSubfamilia=arrTodasGrupos[n][0];
		if(arrSubfamilia[0]==valor){
			encontrado=1;
			arrGrupos=arrTodasGrupos[n];
		}
	}

	//si CATPRIV_IDGRUPO es hidden significa oculto, 3 niveles
	if (document.forms['form1'].elements[objName].type == 'hidden'){
		for(var n=0;n<arrGrupos.length;n++){
			var id=arrGrupos[n][0];
			var elemento=arrGrupos[n][1];
			var grupo=arrGrupos[n][1];
			//alert(id+' - '+elemento);
		}
		document.forms['form1'].elements[objName].value = grupo;

		// Lanzamos la funcion ajax que devuelve la ref de grupo
		ReferenciaGrupo();

		// Lanzo la funcion para recuperar la ultima ref.utilizada por subfamilia (3 niveles)
		UltimaRefProductoPorSF();
	}else{

		document.forms['form1'].elements['IDSUBFAMILIA'].value=document.forms['form1'].elements['CATPRIV_IDSUBFAMILIA'].value;
		document.forms['form1'].elements[objName].length=0;
		for(var n=1;n<arrGrupos.length;n++){
			var id=arrGrupos[n][0];
			var elemento=arrGrupos[n][1];
			var addOption=new Option(elemento,id);
			document.forms['form1'].elements[objName]
			document.forms['form1'].elements[objName].options[document.forms['form1'].elements[objName].length]=addOption;
		}

		// Lanzamos la funcion ajax que devuelve la ref de grupo
		ReferenciaGrupo();

		// Lanzo la funcion para recuperar la ultima ref.utilizada por grupo (5 niveles)
		UltimaRefProductoPorGrupo();
	}
}

//	Cambio del grupo
function CambioGrupoActual(valor,accion){
	//UltimaRefProductoPorGrupo();
}

function restaurarNombre(objTexto,valor,objPadre){
	if(confirm(document.forms['MensajeJS'].elements['RESTAURAR_NOMBRE_PRODUCTO'].value+'\n\n'+ document.forms['MensajeJS'].elements['NOMBRE_ACTUAL'].value+' : '+objTexto.value+'\n '+ document.forms['MensajeJS'].elements['NUEVO_NOMBRE'].value +': '+valor)){
		objTexto.value=valor;
		objPadre.value='S';
	}
}

function debugando(form){
	var id_1=form.elements['CATPRIV_IDFAMILIA'].value;
	var id_2=form.elements['CATPRIV_IDSUBFAMILIA'].value;
	if(confirm('idfamilia: '+id_1+' idsubfamilia: '+id_2+' ¿Enviamos los datos?')){
		return 1;
	}else{
		return 0;
	}
}


function seleccionarValor(elemento,valor){
	var valorSeleccionado=0;
	if(elemento.type=='select-one'){
		for(var n=0;n<elemento.options.length;n++){
			if(elemento.options[n].value==valor){
				valorSeleccionado=n;
			}
		}
		elemento.selectedIndex=valorSeleccionado;
	}
}


//	Guardar el producto estándar completo
function GuardarProducto(form, accion){
	form.elements['ACCION'].value=accion;
	ValidarFormulario(form);
}


/*
//	Mueve el producto estándar completo, incluyendo hijos e históricos
function MoverProducto(form){
	form.elements['ACCION'].value='MOVER';
	if (form.elements['MOVERAREFESTANDAR'].value=='')
		alert(document.forms['MensajeJS'].elements['MOVER_REF_ERROR'].value);
	else
		ValidarFormulario(form);
}
*/

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
	EjecutarFuncionDelFrame('zonaCatalogo','CambioProductoEstandarActual('+jQuery('#CATPRIV_IDEMPRESA').val()+','+jQuery('#CATPRIV_ID').val()+',\'CAMBIOPRODUCTOESTANDAR\');');
}


function sustituirDescripcion(cont){
	var IDEmpresa		= jQuery('#CATPRIV_IDEMPRESA').val();
	var IDProdEstandar	= jQuery('#CATPRIV_ID').val();
	var NombreAntiguo	= encodeURIComponent(jQuery('#DUMP_' + cont).html());
	var d = new Date();

	// Ocultamos y vaciamos la zona de mensajes
	jQuery('tr#DESC_ANT_MESSAGE').hide();
	jQuery('tr#DESC_ANT_MESSAGE td#MSG').html('');

	jQuery.ajax({
		cache:	false,
		url:	'SustituirDescripcion.xsql',
		type:	"GET",
		data:	"IDEMPRESA="+IDEmpresa+"&IDPRODESTANDAR="+IDProdEstandar+"&DUMP_NOMBREANTIGUO="+NombreAntiguo+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			jQuery("#ACTION_" + cont).attr("src","http://www.newco.dev.br/images/loading.gif");
			jQuery("tr#DESC_ANT_MESSAGE td#MSG").html(msg_previo_desc_antiguas);
			jQuery("tr#DESC_ANT_MESSAGE").show()
		},
		error: function(objeto, quepaso, otroobj){
// El proceso tarda mas de 3 minutos en responder y salta el timeout
// De momento, comentamos y borramos la linia (asumiendo que ha salido bien)
			jQuery("tr#DESC_" + cont).remove();
			jQuery("tr#DESC_ANT_MESSAGE").hide().html('');
			//alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.SustituirDescripcion.estado == 'OK'){
				var Total = data.SustituirDescripcion.TotalLineas;

				jQuery('tr#DESC_ANT_MESSAGE td#MSG').html(sustituirDescAntOK.replace('[[LINEAS]]', Total));
				ActualizarDescripcionesAntiguas();
			}else{
				jQuery('tr#DESC_ANT_MESSAGE td#MSG').html(sustituirDescAntErr);
			}
		}
	});
}

function ActualizarDescripcionesAntiguas(){
	var IDEmpresa		= jQuery('#CATPRIV_IDEMPRESA').val();
	var IDProdEstandar	= jQuery('#CATPRIV_ID').val();
	var d = new Date();
	var txtHTML = '', botonAccion = '';

	jQuery.ajax({
		cache:	false,
		url:	'DescripcionesAnteriores.xsql',
		type:	"GET",
		data:	"IDEMPRESA="+IDEmpresa+"&IDPRODESTANDAR="+IDProdEstandar+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.DescripcionesAnteriores.length > 0){
				// Reconstruir la tabla de descripciones antiguas
				// Ocultar las filas para descripciones antiguas
				jQuery("tr.descAntic").each(function(){
					jQuery(this).remove();
				});

				jQuery(data.DescripcionesAnteriores.ListaDescripciones).each(function(key,descripcion){

					if(lang == 'spanish'){
						botonAccion = '<img src="http://www.newco.dev.br/images/sustituir.gif" id="ACTION_' + descripcion.Num + '" title="Sustituir" alt="Sustituir"/>';
					}else{
						botonAccion = '<img src="http://www.newco.dev.br/images/sustituir-BR.gif" id="ACTION_' + descripcion.Num + '" title="Substituir" alt="Substituir"/>';
					}

					txtHTML = '<tr id="DESC_' + descripcion.Num + '" class="descAntic">' +
						'<td>&nbsp;</td>' +
						'<td colspan="2">[' + descripcion.Nombre + ']<span id="DUMP_' + descripcion.Num + '" style="display:none;">' + descripcion.NombreDump + '</span></td>' +
						'<td>' +
							'<a href="javascript:sustituirDescripcion(' + descripcion.Num + ');">' +
								botonAccion +
							'</a>' +
						'</td>' +
						'<td colspan="3">&nbsp;</td>' +
					'</tr>';

					jQuery("#TituloDescAntic").after(txtHTML);
				});
			}else{
				// Ocultar las filas para descripciones antiguas
				jQuery("tr.descAntic").each(function(){
					jQuery(this).remove();
				});
			}
		}
	});
}


function UltimaRefProductoPorSF(){
	var IDEmpresa	= jQuery('#CATPRIV_IDEMPRESA').val();
	var IDSubfam	= jQuery('#CATPRIV_IDSUBFAMILIA').val();
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/UltimaRefProductoPorSF_ajax.xsql',
		type:	"GET",
		data:	"IDEMPRESA="+IDEmpresa+"&IDSUBFAMILIA="+IDSubfam+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.UltimaReferenciaMVM != '')
				jQuery('span#ley_ref_prodestandar').html(leyenda_ref_nivel5.replace('[[REF_MVM]]', data.UltimaReferenciaMVM).replace('[[CODE_NIVEL5]]', chars_nivel5));

			if(data.UltimaReferenciaCliente != '')
				jQuery('span#UltimaRefCliente').html(data.UltimaReferenciaCliente);
			else
				jQuery('span#UltimaRefCliente').html(no_hay);
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}

function UltimaRefProductoPorGrupo(){
	var IDEmpresa	= jQuery('#CATPRIV_IDEMPRESA').val();
	var IDGrupo	= jQuery('#CATPRIV_IDGRUPO').val();
	var d = new Date();

	//solodebug	alert('UltimaRefProductoPorGrupo IDEmpresa:'+IDEmpresa+' IDGrupo:'+IDGrupo);

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/UltimaRefProductoPorGrupo_ajax.xsql',
		type:	"GET",
		data:	"IDEMPRESA="+IDEmpresa+"&IDGRUPO="+IDGrupo+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.UltimaReferenciaMVM != '')
				jQuery('span#ley_ref_prodestandar').html(leyenda_ref_nivel5.replace('[[REF_MVM]]', data.UltimaReferenciaMVM).replace('[[CODE_NIVEL5]]', chars_nivel5));

			if(data.UltimaReferenciaCliente != '')
				jQuery('span#UltimaRefCliente').html(data.UltimaReferenciaCliente);
			else
				jQuery('span#UltimaRefCliente').html(no_hay);
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

function ReferenciaGrupo(){
	var IDGrupo	= jQuery('#CATPRIV_IDGRUPO').val();
	var d		= new Date();
	
	//solodebug console.log('ReferenciaGrupo:'+IDGrupo);

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ReferenciaGrupoAJAX.xsql',
		type:	"GET",
		data:	"IDGRUPO="+IDGrupo+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.ReferenciaGrupo.estado == 'ERROR'){
				null;
			}else{
				// Si no hay error mostramos laRefGrupo donde toca
				jQuery("#CATPRIV_REFERENCIA_TXT").val(data.ReferenciaGrupo.RefGrupo);
				jQuery("#CATPRIV_REFERENCIA_STRING1").val(data.ReferenciaGrupo.RefGrupo);
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}

function CopiaraLicitacion(idProd){

    jQuery.ajax({
        cache:    false,
        url:  'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/CopiaraLicitacionAJAX.xsql',
        type:    "GET",
        data:    "IDPROD="+idProd,
        contentType: "application/xhtml+xml",
        success: function(objeto){
            var data = eval("(" + objeto + ")");
            alert(data.CopiaraLicitacion.estado);

                                var res='';
            if(data.CopiaraLicitacion.estado == 'ERROR'){
                                    res = document.forms['MensajeJS'].elements['ERROR_ACTUALIZAR_LICI'].value;
            }else if (data.CopiaraLicitacion.estado == 'NO_ENCONTRADA'){
                res = document.forms['MensajeJS'].elements['PROD_NO_ENCONTRADO'].value;
            }
            else{
                res = document.forms['MensajeJS'].elements['ACTUALIZADAS_LINEAS_LICI'].value+" data.CopiaraLicitacion.estado "+document.forms['MensajeJS'].elements['ACTUALIZADAS_LINEAS_LICI2'].value;
            }

            jQuery("#resCopiaraLici").append(res);
        },
        error: function(xhr, errorString, exception) {
            alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
        }
    });
}//fin de copiaraLici 

//añadir producto a una licitacion
function InsertarProdLici(oForm){
    var IDLic	= oForm.elements['IDLICITACION'].value;
    var refProd	= oForm.elements['REF_PROD'].value;
    var TipoIVA	= oForm.elements['PRO_IDTIPOIVA'].value;
    var d = new Date();

    if (IDLic != '-1'){
        jQuery.ajax({
                cache:	false,
                url:	'http://www.newco.dev.br/Gestion/Comercial/NuevosProductos.xsql',
                type:	"GET",
                data:	"LIC_ID="+IDLic+"&LISTA_REFERENCIAS="+refProd+"&TIPOIVA="+TipoIVA+"&_="+d.getTime(),
                contentType: "application/xhtml+xml",
                success: function(objeto){
                        var data = eval("(" + objeto + ")");


                        if(data.NuevosProductos.estado == 'OK'){
                                alert(data.NuevosProductos.message);
                        }
                        else{
                                alert('Error: \n' + data.NuevosProductos.message + '\n' + errorNuevosProductos);
                        }

                },
                error: function(xhr, errorString, exception) {
                        alert("mimi xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
                }
        });
    }
    else{ alert('elige licitacion'); }
} //fin de InsertarProdLici


//	17abr19	Muestra los controles para desactivar el producto
function PrepararDesactivar()
{
	jQuery("#btnGuardar").hide();
	jQuery("#btnPrepararDesactivar").hide();
	jQuery("#REFCLIENTETRASPASO").show();
	jQuery("#btnComprobar").show();
	jQuery("#btnCancelarDesactivar").show();
}


//	Comprueba que la referencia de traspaso propuesta corresponde a un producto estándar correcto
function ComprobarTraspaso()
{
	var oForm=document.forms[0];

	var IDEmpresa=oForm.elements['CATPRIV_IDEMPRESA'].value,
		Referencia=oForm.elements['REFCLIENTETRASPASO'].value,
    	d = new Date();
		
	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/IDProductoEstandarAJAX.xsql',
		type:	"GET",
		data:	"IDEMPRESA="+IDEmpresa+"&REFERENCIA="+Referencia+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = JSON.parse(objeto);

			if(data.estado == 'ERROR'){
				alert("Referencia no encontrada");
			}else{
				if (data.IDProductoEstandar==-1)
				{
					alert("Referencia no encontrada");
				}
				else
				{
					// Si no hay error continuamos
					console.log("IDProductoEstandar:"+data.IDProductoEstandar);
					oForm.elements['IDPRODESTANDARTRASPASO'].value=data.IDProductoEstandar;
					jQuery("#btnComprobar").hide();
					jQuery("#btnDesactivar").show();
				}
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}

//	Si se cambia la referencia, obligamos a comprobarla de nuevo
function CambiadaReferencia()
{
	jQuery("#btnDesactivar").hide();
	jQuery("#btnComprobar").show();
	document.forms[0].elements['IDPRODESTANDARTRASPASO'].value='';
}


//	Cancela la desactivación del producto
function CancelarDesactivar()
{
	jQuery("#REFCLIENTETRASPASO").hide();
	jQuery("#btnComprobar").hide();
	jQuery("#btnCancelarDesactivar").hide();
	jQuery("#btnGuardar").show();
	jQuery("#btnPrepararDesactivar").show();
	jQuery("#btnDesactivar").hide();
	document.forms[0].elements['IDPRODESTANDARTRASPASO'].value='';
}

//	
function Desactivar()
{
	GuardarProducto(document.forms[0], 'TRASPASO');
}











