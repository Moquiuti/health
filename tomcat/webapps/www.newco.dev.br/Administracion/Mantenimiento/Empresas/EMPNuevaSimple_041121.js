//	Creado a partir de EMPNueva.js
//	Ultima revision: ET 03nov21 09:00 EMPNuevaSimple_041121.js

jQuery.noConflict();

//----------------------------------------------------------

jQuery(document).ready(globalEvents);


function globalEvents(){
	//	Al cargarse, actualiza la cookie
	SetCookie('SES_ID', IDSesion);
	if (Accion=='DOCUMENTO') MostrarDiv('divDocumentos');

	var fase=jQuery("#FASE").val();
	if (fase=='1') 
		MostrarDiv('divDatosEmpresa');
	else if (fase=='2') 
		MostrarDiv('divAreasGeo');
	else if (fase=='3') 
		MostrarDiv('divCategorias');
	else if (fase=='4') 
		MostrarDiv('divDocumentos');
	else if (fase=='5') 
		MostrarDiv('FIN');
	
	//console.log("EMPNueva. globalEvents. Fase:"+jQuery("#FASE").val());
	
}//fin de globalEvents


//	Muestra el DIV que corresponda a la fase actual
function MostrarDiv(nombreDiv)
{
	jQuery(".divAvance").hide();

	//	En el caso del div de documentos, recuperamos los datos para esta empresa
	if(nombreDiv=='divDocumentos')
		RecuperaDocumentosAjax();

	if (nombreDiv!='FIN')
		jQuery("#"+nombreDiv).show();
}

//	Guarda los datos de la empresa       
function GuardaEmpresa(accion)
{

	var formu=document.forms['MantEmpresaSimple'];
	if (validarFormulario(formu))
	{
		AsignarAccion(formu,'EMPNuevaSimple2022.xsql');
		if (IDSesion=='')
			jQuery("#ACCION").val('NUEVA');
		else
			jQuery("#ACCION").val(accion);
		SubmitForm(formu);
	}

}

//	Retrocede a la fase anterior
function Atras()
{
	var fase=parseInt(jQuery("#FASE").val());
	jQuery("#FASE").val(fase-2);
	var formu=document.forms['MantEmpresaSimple'];
	jQuery("#ACCION").val('ATRAS');
	SubmitForm(formu);
}

//	Revisa los datos del formulario	
function validarFormulario(form)
{
	var regex_cpostal	= new RegExp("^[0-9\\-()]+$","g"); // Expresion regular para controlar el campo EMP_CPOSTAL que solo puede incluir números, guiones y parentesis (requisito MVMB)
	var regex_tlfn		= new RegExp("^[0-9\\-()]+$","g"); // Expresion regular para controlar el campo EMP_TELEFONO que solo puede incluir números, guiones y parentesis (requisito MVMB)
	var regex_fax		= new RegExp("^[0-9\\-()]+$","g"); // Expresion regular para controlar el campo EMP_FAX que solo puede incluir números, guiones y parentesis (requisito MVMB)
	var regex_tlfn_fijo	= new RegExp("^[0-9\\-()]+$","g"); // Expresion regular para controlar el campo US_TF_FIJO que solo puede incluir números, guiones y parentesis (requisito MVMB)

	var errores=0;

	if((!errores) && (esNulo(document.forms[0].elements['EMP_NOMBRE'].value))){
		errores=1;
		alert(str_OBLI_NOMBRE_EMPRESA);
		form.elements['EMP_NOMBRE'].focus();
		return false;
	}

	if((!errores) && (esNulo(document.forms[0].elements['EMP_NIF'].value))){
		errores=1;
		alert(str_OBLI_NIF);
		form.elements['EMP_NIF'].focus();
		return false;
	}

	if((!errores) && (esNulo(document.forms[0].elements['EMP_DIRECCION'].value))){
		errores=1;
		alert(str_OBLI_DIRECCION);
		form.elements['EMP_DIRECCION'].focus();
		return false;
	}

	if((!errores) && (esNulo(document.forms[0].elements['EMP_CPOSTAL'].value))){
		errores=1;
		alert(str_OBLI_COD_POSTAL);
		form.elements['EMP_CPOSTAL'].focus();
		return false;
	}else{
		if(!checkRegEx(document.forms[0].elements['EMP_CPOSTAL'].value, regex_cpostal)){
			errores=1;
			alert(str_EL_CAMPO+' ' + str_FORMATO_COD_POSTAL+' '+ str_SOLO_NUM_GUIONES_PAR);
			form.elements['EMP_CPOSTAL'].focus();
			return false;
		}
	}

	if((!errores) && (esNulo(document.forms[0].elements['EMP_POBLACION'].value))){
		errores=1;
		alert(str_OBLI_POBLACION);
		form.elements['EMP_POBLACION'].focus();
		return false;
	}

	if((!errores) && (esNulo(document.forms[0].elements['EMP_TELEFONO'].value))){
		errores=1;
		alert(str_OBLI_TELEFONO);
		form.elements['EMP_TELEFONO'].focus();
		return false;
	}else{
		if((!errores) && (!checkRegEx(document.forms[0].elements['EMP_TELEFONO'].value, regex_tlfn))){
			errores=1;
			alert(str_EL_CAMPO+' ' + str_FORMATO_TELEFONO+ ' '+ str_SOLO_NUM_GUIONES_PAR);
			form.elements['EMP_TELEFONO'].focus();
			return false;
		}
	}

	if((!errores) && (document.forms[0].elements['EMP_IDTIPO'].value<1)){
		errores=1;
		alert(str_OBLI_TIPO_EMPRESA);
		form.elements['EMP_IDTIPO'].focus();
		return false;
	}

	/*
	if(esNulo(document.forms[0].elements['EMP_PEDIDOMINIMO'].value)){
		//errores=1;
		//alert(msgPedidoMinimoActivo);
		form.elements['EMP_PEDIDOMINIMO'].focus();
		return false;
	}*/

	if((!errores) && (esNulo(document.forms[0].elements['US_NOMBRE'].value))){
		errores=1;
		alert(str_OBLI_NOMBRE_USUARIO);
		form.elements['US_NOMBRE'].focus();
		return false;
	}

	if((!errores) && (esNulo(document.forms[0].elements['US_APELLIDO1'].value))){
		errores=1;
		alert(str_OBLI_PRIMER_APELLIDO);
		form.elements['US_APELLIDO1'].focus();
		return false;
	}


	if((!errores) && (esNulo(document.forms[0].elements['US_EMAIL'].value))){
		errores=1;
		alert(str_OBLI_EMAIL_USUARIO);
		form.elements['US_EMAIL'].focus();
	}
	
	if(!errores)
		return true;
	else
		return false;
}


function comprobarFormulario(formu){
	var obligatorios=['EMP_NOMBRE','EMP_NIF','EMP_DIRECCION','EMP_TELEFONO','EMP_IDTIPO','US_TITULO','EMP_CPOSTAL','EMP_POBLACION','DEP_NOMBRE','US_NOMBRE','US_APELLIDO_1','US_EMAIL','US_TF_FIJO'];	//EMP_ESPECIALIDAD',
	var numericos=['EMP_CPOSTAL','US_TF_FIJO','US_TF_MOVIL','EMP_TELEFONO','EMP_FAX'];
	var messError='';
	var Error = 0;
        
	for(i=0;i<formu.length;i++){
		// Campos obligatorios
		if((obligatorios.toString()).indexOf(formu.elements[i].name)!=-1){
		  if(formu.elements[i].type=='select-one'){
    		if((formu.elements[i].value<1) ||(formu.elements[i].value=='NULL')){
    		  Error=1;
    		  messError += str_OBLI_CAMPOS_OBLI;
    		  formu.elements[i].focus();
    		  break;
    		}
		  }
		  else{
    		if (formu.elements[i].value==''){
    		  Error=1;
    		  messError += str_OBLI_CAMPOS_OBLI;
    		  formu.elements[i].focus();
    		  break;
    		}
		  }
		}

		// Campos numericos
		if((numericos.toString()).indexOf(formu.elements[i].name)!=-1){
		  if(!checkNumber(formu.elements[i].value,formu.elements[i])){
    		Error=1;
    		break;
		  }
		}
 	}
 	if (messError != '') alert(messError);
   	return Error;
}
        
function siempreCheckeado(obj){
  if(obj.checked==false)
    obj.checked=true;
}
        
function pedidoMinimo(nombre,form){
  if(nombre=="EMP_PEDMINIMOACTIVO_CHECK"){
    if(form.elements[nombre].checked==true){
      form.elements['EMP_PEDMINIMOESTRICTO_CHECK'].disabled=false;
      form.elements['EMP_PEDIDOMINIMO'].disabled=false;
      form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].disabled=false;
    }
    else{
      form.elements['EMP_PEDMINIMOESTRICTO_CHECK'].checked=false;
      form.elements['EMP_PEDMINIMOESTRICTO_CHECK'].disabled=true;

      form.elements['EMP_PEDIDOMINIMO'].value='';
      form.elements['EMP_PEDIDOMINIMO'].disabled=true;

      form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].value='';
      form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].disabled=true;
    }
  }
  else{
    if(nombre=="EMP_INTEGRADO_CHECK"){
      if(form.elements['EMP_INTEGRADO_CHECK'].checked==true){
        form.elements['EMP_PEDMINIMOACTIVO_CHECK'].checked=false;
        form.elements['EMP_PEDMINIMOACTIVO_CHECK'].disabled=true;
        form.elements['EMP_PEDMINIMOESTRICTO_CHECK'].checked=false;
        form.elements['EMP_PEDMINIMOESTRICTO_CHECK'].disabled=true;
        form.elements['EMP_PEDIDOMINIMO'].disabled=false;
        form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].disabled=false;
      }
      else{
        form.elements['EMP_PEDMINIMOACTIVO_CHECK'].disabled=false;
        form.elements['EMP_PEDMINIMOESTRICTO_CHECK'].disabled=true;
        form.elements['EMP_PEDIDOMINIMO'].value='';
        form.elements['EMP_PEDIDOMINIMO'].disabled=true;

        form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].value='';
        form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].disabled=true;
      }
    }
  }
}


//	Cambia la seleccion
function cambiarSeleccion(IDSel, flag){
	var d = new Date();

	jQuery.ajax({
		url:"http://www.newco.dev.br/Gestion/EIS/cambiarSeleccionAJAX.xsql",
		data: "IDSELECCION="+IDSel+"&IDREGISTRO="+IDEmpresa+"&_="+d.getTime(),
		type: "GET",
		async: false,
		contentType: "application/xhtml+xml",
		beforeSend:function(){
			null;
		},
		error:function(objeto, quepaso, otroobj){
			alert("objeto:"+objeto);
			alert("otroobj:"+otroobj);
			alert("quepaso:"+quepaso);
		},
		success:function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.Seleccion.estado == 'OK'){
				if(flag){
					jQuery("#SEL_" + IDSel + " td.estadoSel").html("<a href='javascript:cambiarSeleccion(" + IDSel + ", false);'><img src='http://www.newco.dev.br/images/checkCenter.gif'/></a>");
				}else{
					jQuery("#SEL_" + IDSel + " td.estadoSel").html("<a href='javascript:cambiarSeleccion(" + IDSel + ", true);'><img src='http://www.newco.dev.br/images/nocheck.gif'/></a>");
				}
			}else{
				alert(str_errorCambiarSeleccion);
			}
		}
	});
}

//	3nov21 Comprueba si ya existe el NIF (para el pais correspondiente al alta)
function ComprobarNIF()
{
	var form=document.forms['MantEmpresaSimple'];
	var Nif=form.elements['EMP_NIF'].value;
	var IDPais=form.elements['IDPAIS'].value;

	console.log("EMPNueva. ComprobarNIF. Nif:"+Nif+' para IDPais:'+IDPais);

	var d = new Date();

	jQuery.ajax({
		url:"http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/ComprobarNifAjax.xsql",
		data: "NIF="+Nif+"&IDPAIS="+IDPais+"&_="+d.getTime(),
		type: "GET",
		async: false,
		contentType: "application/xhtml+xml",
		beforeSend:function(){
			null;
		},
		error:function(objeto, quepaso, otroobj){
			alert("objeto:"+objeto);
			alert("otroobj:"+otroobj);
			alert("quepaso:"+quepaso);
		},
		success:function(objeto){
			var data = eval("(" + objeto + ")");
			console.log("EMPNueva. ComprobarNIF. Nif:"+Nif+' para IDPais:'+IDPais+' res:'+objeto);
		
			if (data.Estado=='EXISTE')
			{
				alert(strEmpresaYaExiste.replace(/<br>/gi,'\n'));
				document.getElementById("EMP_NIF").focus();
			}
		}
	});

	
}





