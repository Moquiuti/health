// JavaScript Document
//mi-28-09-11

jQuery(document).ready(globalEvents);

function globalEvents(){
	RecuperaBienText();
        verComisiones(document.forms['frmManten']);
}//fin de globalEvents

function RecuperaBienText(){
	if(jQuery("#CEN_DESCRIPCIONCOMERCIAL").length > 0)	jQuery("#CEN_DESCRIPCIONCOMERCIAL").html(jQuery("#CEN_DESCRIPCIONCOMERCIAL").text().replace(/<br>/gi,'\n'));
        if(jQuery("#CEN_MODELODENEGOCIO_EXPLIC").length > 0)	jQuery("#CEN_MODELODENEGOCIO_EXPLIC").html(jQuery("#CEN_MODELODENEGOCIO_EXPLIC").text().replace(/<br>/gi,'\n'));
        if(jQuery("#CEN_DETALLEFORMAPAGOAMVM").length > 0)	jQuery("#CEN_DETALLEFORMAPAGOAMVM").html(jQuery("#CEN_DETALLEFORMAPAGOAMVM").text().replace(/<br>/gi,'\n'));
        if(jQuery("#TEXTOFACTURAMVM").length > 0)               jQuery("#TEXTOFACTURAMVM").html(jQuery("#TEXTOFACTURAMVM").text().replace(/<br>/gi,'\n'));
        
}

function Actua(formu){
	if(ConfirmarBorrado(formu))	SubmitForm(formu);
}

function ActualizarDatos(form){
	if(validarFormulario(form)){
                
               
                form.action = "CENMantenSave.xsql";
		form.enctype = "application/x-www-form-urlencoded";
		form.method = "post";
		form.target = '';
                
                //alert(form.action);
                //alert(form.elements['IDLOGOTIPO'].value);
                form.elements['CEN_IDLOGOTIPO'].value = form.elements['IDLOGOTIPO'].value;
		//multi pais => doy a provincia el valor de prov españa o brasil
		//españa
		if(form.elements['CEN_IDPAIS'].value == '34' && form.elements['PROVINCIA_34'].value != ''){
			form.elements['CEN_PROVINCIA'].value = form.elements['PROVINCIA_34'].value;
		}
		//brasil
		if(form.elements['CEN_IDPAIS'].value == '55' && form.elements['PROVINCIA_55'].value != ''){
			form.elements['CEN_PROVINCIA'].value = form.elements['PROVINCIA_55'].value;
		}

		jQuery(".boton").hide(); //cuando envio formulario que ok escondo botones
		SubmitForm(form);
	}
}

function verComisiones(formu){
    var modelo = formu.elements['IDMODELONEGOCIO'].value;
    //alert(modelo);
    if (modelo == 'COMISION_AHORRO' || modelo == 'COMISION_TRANSACCIONES' || modelo == 'COMISION_AHOYTRANS'){
        if (modelo == 'COMISION_AHORRO'){ 
            jQuery("#comisionAhorro").show(); 
            jQuery("#comisionTransicciones").hide(); 
        }
        if (modelo == 'COMISION_TRANSACCIONES'){
            jQuery("#comisionTransicciones").show();  
            jQuery("#comisionAhorro").hide();
        }
        if (modelo == 'COMISION_AHOYTRANS'){ 
            jQuery("#comisionTransicciones").show(); 
            jQuery("#comisionAhorro").show();
        }
    }
    else{
            jQuery("#comisionTransicciones").hide(); 
            jQuery("#comisionAhorro").hide();
        
    }
}

function validarFormulario(form){
	var regex_cpostal	= new RegExp("^[0-9\\-()]+$","g"); // Expresion regular para controlar el campo EMP_CPOSTAL que solo puede incluir números, guiones y parentesis (requisito MVMB)
	var regex_tlfn		= new RegExp("^[0-9\\-()]+$","g"); // Expresion regular para controlar el campo EMP_TELEFONO que solo puede incluir números, guiones y parentesis (requisito MVMB)
	var regex_fax		= new RegExp("^[0-9\\-()]+$","g"); // Expresion regular para controlar el campo EMP_FAX que solo puede incluir números, guiones y parentesis (requisito MVMB)
	var regex_num		= new RegExp("^[0-9\\-()]+$","g"); // Expresion regular para controlar que los campos de num camaras
	var regex_num1		= new RegExp("^[0-9\\-()]+$","g"); // Expresion regular para controlar que los campos de quirofano
	var regex_num2		= new RegExp("^[0-9\\-()]+$","g"); // Expresion regular para controlar que los campos de objetivo mensual
	var regex_solo_num	= new RegExp("^[0-9]+$","g"); // Expresion regular que acepta solo numeros
        var regex_solo_num1	= new RegExp("^[0-9]+$","g"); // Expresion regular que acepta solo numeros
	var regex_car_raros	= /([\#|\\|\'|\|])+/g; //caracteres raros que no queremos en los campos de texto (requisito MVM)
	var errores=0, raros=0;
        
        //alert(form.elements['IDFORMASPAGOMVM'].value);
        //alert(form.elements['IDMODELONEGOCIO'].value);
        
        
	if((!errores) && (esNulo(form.elements['CEN_NOMBRE'].value))){
		errores=1;
		alert(document.forms['MensajeJS'].elements['OBLI_NOMBRE_EMPRESA'].value);
		form.elements['CEN_NOMBRE'].focus();
		return false;
	}

	if((!errores) && (esNulo(form.elements['CEN_DIRECCION'].value))){
		errores=1;
		alert(document.forms['MensajeJS'].elements['OBLI_DIRECCION'].value);
		form.elements['CEN_DIRECCION'].focus();
		return false;
	}

	if((!errores) && (esNulo(form.elements['CEN_POBLACION'].value))){
		errores=1;
		alert(document.forms['MensajeJS'].elements['OBLI_POBLACION'].value);
		form.elements['CEN_POBLACION'].focus();
		return false;
	}

	//si es españa paso por control Codigo postal
	if(form.elements['CEN_IDPAIS'].value == '34'){
		if((!errores) && (!checkNumber(form.elements['CEN_CPOSTAL'].value, form.elements['CEN_CPOSTAL']))){
			errores=1;
			form.elements['CEN_CPOSTAL'].focus();
			return false;
		}else{
			if((!errores) && (esNulo(form.elements['CEN_CPOSTAL'].value))){
				errores=1;
				alert(document.forms['MensajeJS'].elements['OBLI_COD_POSTAL'].value);
				form.elements['CEN_CPOSTAL'].focus();
				return false;
			}
		}
	}//fin control si es españa

	//si es brasil controlo solo que no nulo Codigo postal
	if(form.elements['CEN_IDPAIS'].value == '55'){
		if((!errores) && (esNulo(form.elements['CEN_CPOSTAL'].value))){
			errores=1;
			alert(document.forms['MensajeJS'].elements['OBLI_COD_POSTAL'].value);
			form.elements['CEN_CPOSTAL'].focus();
			return false;
		}else{
			if(!checkRegEx(form.elements['CEN_CPOSTAL'].value, regex_cpostal)){
				errores=1;
				alert(document.forms['MensajeJS'].elements['FORMATO_NUM_GUION_PARENT'].value);
				form.elements['CEN_CPOSTAL'].focus();
				return false;
			}
		}
	}//fin control si es brasil

	if((!errores) && (esNulo(form.elements['CEN_TELEFONO'].value))){
		errores=1;
		alert(document.forms['MensajeJS'].elements['OBLI_TELEFONO'].value);
		form.elements['CEN_TELEFONO'].focus();
		return false;
	}else{
		if(!checkRegEx(form.elements['CEN_TELEFONO'].value, regex_tlfn)){
			errores=1;
			alert(document.forms['MensajeJS'].elements['FORMATO_NUM_GUION_PARENT'].value);
			form.elements['CEN_TELEFONO'].focus();
			return false;
		}
	}

	if((!errores) && (!checkRegEx(form.elements['CEN_FAX'].value, regex_fax)) && (!esNulo(form.elements['CEN_FAX'].value))){
		errores=1;
		alert(document.forms['MensajeJS'].elements['FORMATO_NUM_GUION_PARENT'].value);
		form.elements['CEN_FAX'].focus();
		return false;
	}

	if(form.elements['CEN_PEDIDOSPREVISTOSMES'] && form.elements['CEN_PEDIDOSPREVISTOSMES'].value != '' && (!checkRegEx(form.elements['CEN_PEDIDOSPREVISTOSMES'].value, regex_num))){
		errores=1;
		alert(document.forms['MensajeJS'].elements['FORMATO_NUM_GUION_PARENT'].value);
		form.elements['CEN_PEDIDOSPREVISTOSMES'].focus();
		return false;
	}

	if(form.elements['CEN_CAMAS'] && form.elements['CEN_CAMAS'].value != '' && (!checkRegEx(form.elements['CEN_CAMAS'].value, regex_num1))){
		errores=1;
		alert(document.forms['MensajeJS'].elements['FORMATO_NUM_GUION_PARENT'].value);
		form.elements['CEN_CAMAS'].focus();
		return false;
	}

	if(form.elements['CEN_QUIROFANOS'] && form.elements['CEN_QUIROFANOS'].value != '' && (!checkRegEx(form.elements['CEN_QUIROFANOS'].value, regex_num2))){
		errores=1;
		alert(document.forms['MensajeJS'].elements['FORMATO_NUM_GUION_PARENT'].value);
		form.elements['CEN_QUIROFANOS'].focus();
		return false;
	}


	if((form.elements['CEN_LIMITECOMPRASMENSUALES'] && form.elements['CEN_LIMITECOMPRASMENSUALES'].value != '')
	    || (form.elements['CEN_FECHAPRIMERACUOTA'] && form.elements['CEN_FECHAPRIMERACUOTA'].value != '')
	    || (form.elements['CEN_FECHACUOTAACTIVA'] && form.elements['CEN_FECHACUOTAACTIVA'].value != '')){

		//control limite compra mensual no puede estar vacio
		if(form.elements['CEN_LIMITECOMPRASMENSUALES'].value == ''){
			errores=1;
			alert(document.forms['MensajeJS'].elements['VACIO_CEN_LIMITECOMPRASMENSUALES'].value);
			form.elements['CEN_LIMITECOMPRASMENSUALES'].focus();
			return false;
		//control no decimales en limite compra mensual
		}else if(!checkRegEx(form.elements['CEN_LIMITECOMPRASMENSUALES'].value, regex_solo_num)){
			errores=1;
			alert(document.forms['MensajeJS'].elements['ERROR_CEN_LIMITECOMPRASMENSUALES'].value);
			form.elements['CEN_LIMITECOMPRASMENSUALES'].focus();
			return false;
		}

		//control fecha primera cuota no puede estar vacio
		if(form.elements['CEN_FECHAPRIMERACUOTA'].value == ''){
			errores=1;
			alert(document.forms['MensajeJS'].elements['VACIO_CEN_FECHAPRIMERACUOTA'].value);
			form.elements['CEN_FECHAPRIMERACUOTA'].focus();
			return false;
		//control fecha primera cuota
		}else{
			var errorFechaPrimeraCuota	= CheckDate(form.elements['CEN_FECHAPRIMERACUOTA'].value);

			if(errorFechaPrimeraCuota != ''){
				errores=1;
				alert(document.forms['MensajeJS'].elements['ERROR_CEN_FECHAPRIMERACUOTA'].value);
				form.elements['CEN_FECHAPRIMERACUOTA'].focus();
				return false;
			}

			var arrFecha1			= form.elements['CEN_FECHAPRIMERACUOTA'].value.split("/");
			var formattedFecha1		= new Date(arrFecha1[2], arrFecha1[1]-1, arrFecha1[0]);
		}

		//control fecha cuota activa no puede estar vacio
		if(form.elements['CEN_FECHACUOTAACTIVA'].value == ''){
			errores=1;
			alert(document.forms['MensajeJS'].elements['VACIO_CEN_FECHACUOTAACTIVA'].value);
			form.elements['CEN_FECHACUOTAACTIVA'].focus();
			return false;
		//control fecha cuota activa
		}else{
			var errorFechaCuotaActiva	= CheckDate(form.elements['CEN_FECHACUOTAACTIVA'].value);

			if(errorFechaCuotaActiva != ''){
				errores=1;
				alert(document.forms['MensajeJS'].elements['ERROR_CEN_FECHACUOTAACTIVA'].value);
				form.elements['CEN_FECHACUOTAACTIVA'].focus();
				return false;
			}

			var arrFecha2			= form.elements['CEN_FECHACUOTAACTIVA'].value.split("/");
			var formattedFecha2		= new Date(arrFecha2[2], arrFecha2[1]-1, arrFecha2[0]);
		}

		//control fecha primera cuota menor que ultima cuota activa mm/dd/yyyy  dd/mm/yyyy
		if(formattedFecha1 > formattedFecha2){
			alert(document.forms['MensajeJS'].elements['ERROR_FECHACUOTAACTIVA_MINOR'].value);
			form.elements['CEN_FECHACUOTAACTIVA'].focus();
			return false;
		}
	}
        //modelo de negocio
        if (form.elements['IDMODELONEGOCIO'].value == 'COMISION_AHOYTRANS' || form.elements['IDMODELONEGOCIO'].value == 'COMISION_TRANSACCIONES' || form.elements['IDMODELONEGOCIO'].value == 'COMISION_AHORRO'){ //si modelo comision ahorro o comision transacciones pongo las 2 comisiones
            if((form.elements['IDMODELONEGOCIO'].value == 'COMISION_AHOYTRANS' || form.elements['IDMODELONEGOCIO'].value == 'COMISION_AHORRO') && form.elements['CEN_COMISIONAHORRO_INPUT'] && form.elements['CEN_COMISIONAHORRO_INPUT'].value != ''){ 
                    //comision ahorro
                    if(!checkRegEx(form.elements['CEN_COMISIONAHORRO_INPUT'].value, regex_solo_num)){
                            errores=1;
                            alert(document.forms['MensajeJS'].elements['ERROR_CEN_COMISIONAHORRO'].value);
                            form.elements['CEN_COMISIONAHORRO_INPUT'].focus();
                            return false;
                    }
                    //si comision ahorro enseño comision ahorro y el otro lo paso vacío
                    form.elements['CEN_COMISIONTRANSACCIONES'].value = '';
                    
                }
            if ((form.elements['IDMODELONEGOCIO'].value == 'COMISION_AHOYTRANS' || form.elements['IDMODELONEGOCIO'].value == 'COMISION_TRANSACCIONES') && form.elements['CEN_COMISIONTRANSACCIONES_INPUT'] && form.elements['CEN_COMISIONTRANSACCIONES_INPUT'].value != ''){
                    //comision transacciones
                    if(!checkRegEx(form.elements['CEN_COMISIONTRANSACCIONES_INPUT'].value, regex_solo_num1)){
                            errores=1;
                            alert(document.forms['MensajeJS'].elements['ERROR_CEN_COMISIONTRANSACCIONES'].value);
                            form.elements['CEN_COMISIONTRANSACCIONES_INPUT'].focus();
                            return false;
                    }
                }
        }//fin comisiones
        
        else{
                form.elements['CEN_COMISIONAHORRO'].value = '';
                form.elements['CEN_COMISIONTRANSACCIONES'].value = '';
        }//fin de modelo de negocio
            
        form.elements['CEN_COMISIONTRANSACCIONES'].value = form.elements['CEN_COMISIONTRANSACCIONES_INPUT'].value;
        form.elements['CEN_COMISIONAHORRO'].value = form.elements['CEN_COMISIONAHORRO_INPUT'].value;
        
        
	//control que no pongan caracteres raros en los textos
	var inputText = [form.elements['CEN_NOMBRECORTO'].value, form.elements['CEN_NOMBRE'].value, form.elements['CEN_DIRECCION'].value, form.elements['CEN_POBLACION'].value];
	for(var i=0; i<inputText.length; i++){
		if(checkRegEx(inputText[i], regex_car_raros)){
			errores=1;
			raros=1;
		}
	}//fin for caracteres raros
	if(raros =='1')		alert(document.forms['MensajeJS'].elements['CAR_RAROS'].value);

	if(!errores)
		return true;
	else
		return false;
}

function NuevoLugarEntrega(){
	var idCentro	= document.forms[0].elements['CEN_ID'].value;
	var direccion	= document.forms[0].elements['CEN_DIRECCION'].value;
	var cpostal	= document.forms[0].elements['CEN_CPOSTAL'].value;
	var poblacion	= document.forms[0].elements['CEN_POBLACION'].value;
	var provincia	= document.forms[0].elements['CEN_PROVINCIA'].value;

	MostrarPag('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/LugaresEntrega.xsql?CEN_ID='+idCentro+
		'&LUGAR_ID=0'+
		'&NUEVADIRECCION='+direccion+
		'&NUEVOCPOSTAL='+cpostal+
		'&NUEVAPOBLACION='+poblacion+
		'&NUEVAPROVINCIA='+provincia+
		'&ACCION=','lugaresentrega');
}

function NuevoCentroConsumo(){
	var idCentro=document.forms[0].elements['CEN_ID'].value;

	MostrarPag('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CentrosConsumo.xsql?CEN_ID='+idCentro+
		'&CENTROCONSUMO_ID=0'+
		'&ACCION=','centroconsumo');
}

function EditarLugarEntrega(cen_id, lugar_id){
	MostrarPag('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/LugaresEntrega.xsql?CEN_ID='+cen_id+
		'&LUGAR_ID='+lugar_id+
		'&ACCION=EDITAR', 'lugaresentrega');
}

function EditarCentroConsumo(cen_id, centroconsumo_id){
	MostrarPag('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CentrosConsumo.xsql?CEN_ID='+cen_id+
		'&CENTROCONSUMO_ID='+centroconsumo_id+
		'&ACCION=EDITAR','centroconsumo');
}

//subir logo a nivel de centro
//recargo select logos desp que subo uno
function SeleccionaLogos(IDPROVE,ID,ACCION){
	//alert('prove '+IDPROVE+' id '+ID);
	var ACTION="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/LogosCentros.xsql";;
	var post='IDPROVEEDOR='+IDPROVE;
	if (IDPROVE!=-1 && IDPROVE!=0) sendRequest(ACTION,handleRequestLogos,post,ACCION);
}

function handleRequestLogos(req,accion){

	//alert('req '+req+' accion '+accion);
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

		jQuery("#IDLOGOTIPO").show();
		jQuery("#IDLOGOTIPO").html(Resultados);

		if (accion=='lista') document.forms['frmManten'].elements['IDLOGOTIPO'].value = '-1';
		else document.forms['frmManten'].elements['IDLOGOTIPO'].value = Doc_ID_Actual;

	}
	return true;
}
