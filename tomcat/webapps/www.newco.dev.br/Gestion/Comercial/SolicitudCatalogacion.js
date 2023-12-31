//	Ultima revisi�n: 20may14
var uploadFilesDoc = new Array();
var periodicTimerDoc = 0;
var form_tmp;
var MAX_WAIT_DOC = 1000;

function RecuperaBienText(){

     if(jQuery("#SC_DESCRIPCION").length > 0)        jQuery("#SC_DESCRIPCION").html(jQuery("#SC_DESCRIPCION").text().replace(/<br>/gi,'\n'));
     
     if(jQuery("#SC_DIAGNOSTICO").length > 0)        jQuery("#SC_DIAGNOSTICO").html(jQuery("#SC_DIAGNOSTICO").text().replace(/<br>/gi,'\n'));
     if(jQuery("#DIAGNOSTICO_OLD").length > 0)        jQuery("#DIAGNOSTICO_OLD").html(jQuery("#DIAGNOSTICO_OLD").text().replace(/<br>/gi,'\n'));
     
     if(jQuery("#SC_SOLUCION").length > 0)        jQuery("#SC_SOLUCION").html(jQuery("#SC_SOLUCION").text().replace(/<br>/gi,'\n'));
     if(jQuery("#SOLUCION_OLD").length > 0)        jQuery("#SOLUCION_OLD").html(jQuery("#SOLUCION_OLD").text().replace(/<br>/gi,'\n'));
  
}

function abrirSolicitud(IDSol){
    window.open('SolicitudCatalogacion.xsql?SC_ID='+IDSol,'_self',false);
}

function anadirProducto(form){
    
    var IDSol = form.elements['IDSOLICITUD'].value;
    var prod = form.elements['PRODUCTO'].value;
    var refCli = form.elements['REFCLIENTE'].value;
    var refProv = form.elements['REFPROVEEDOR'].value;
    var prov = form.elements['PROVEEDOR'].value;
    var precio = form.elements['PRECIO'].value;
    var consumo = form.elements['CONSUMO'].value;
    
    
    jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/AnadirProductosSolicitudAJAX.xsql',
		type:	"GET",
		data:	"IDSOLICITUD="+IDSol+"&REFCLIENTE="+refCli+"&REFPROVEEDOR="+refProv+"&PRODUCTO="+prod+"&PROVEEDOR="+prov+"&PRECIO="+precio+"&CONSUMO="+consumo,
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.Resultado.Estado == 'OK'){
                            form.elements['PRODUCTO'].value = '';
                            form.elements['REFCLIENTE'].value = '';
                            form.elements['REFPROVEEDOR'].value = '';
                            form.elements['PROVEEDOR'].value = '';
                            form.elements['PRECIO'].value = '';
                            form.elements['CONSUMO'].value = '';
                            location.reload(); 
                            
                        }else{
				alert('Error ');
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
    
   
}

function BuscarSolicitudesCatalogacion(oForm){
	SubmitForm(oForm);
}

// Abre la p�gina para crear una nueva solicitud de catalogaci�n
function NuevaSolicitudCatalogacion(){
	window.open('NuevaSolicitudCatalogacion.xsql','_self',false);
}

// Funci�n que valida los campos de los formularios antes de hacer el submit
function ValidarFormulario(oForm,IDEstado){
	if(IDEstado == 'NUEVA'){
		// Escondemos el bot�n de enviar
		jQuery('#BotonSubmit').hide();
        
		if(oForm.elements['SC_TITULO'] && oForm.elements['SC_TITULO'].value == ''){
			oForm.elements['SC_TITULO'].focus();
			alert(titulo_obligatorio);
			jQuery('#BotonSubmit').show();
			return;
		}

		if(oForm.elements['SC_DESCRIPCION'] && oForm.elements['SC_DESCRIPCION'].value == ''){
			oForm.elements['SC_DESCRIPCION'].focus();
			alert(descripcion_obligatoria);
			jQuery('#BotonSubmit').show();
			return;
		}

		if(oForm.elements['SC_INFOPRECIO'] && oForm.elements['SC_INFOPRECIO'].value == ''){
			oForm.elements['SC_INFOPRECIO'].focus();
			alert(infoprecio_obligatoria);
			jQuery('#BotonSubmit').show();
			return;
		}

		if(oForm.elements['SC_CONSUMO'] && oForm.elements['SC_CONSUMO'].value == ''){
			oForm.elements['SC_CONSUMO'].focus();
			alert(consumo_obligatorio);
			jQuery('#BotonSubmit').show();
			return;
		}else if(oForm.elements['SC_CONSUMO'] && oForm.elements['SC_CONSUMO'].value != ''){
			var consumo_anual = oForm.elements['SC_CONSUMO'].value.replace(',','.');

			if(oForm.elements['SC_CONSUMO'].value.indexOf(".") > -1){
				oForm.elements['SC_CONSUMO'].focus();
				alert(consumo_contiene_punto);
				jQuery('#BotonSubmit').show();
				return;
			}else if(isNaN(consumo_anual)){
				oForm.elements['SC_CONSUMO'].focus();
				alert(consumo_no_numerico);
				jQuery('#BotonSubmit').show();
				return;
			}
                }

		// Si no hay errores se envia el formulario
		oForm.encoding	= 'application/x-www-form-urlencoded';
		oForm.target	= '_self';
		AsignarAccion(oForm,'http://www.newco.dev.br/Gestion/Comercial/NuevaSolicitudCatalogacionSave.xsql')
		SubmitForm(oForm);
		return;
	}else if(IDEstado == 'D'){	// DIAGNOSTICO
		// Escondemos el bot�n de enviar
		jQuery('#BotonDIAG').hide();

		if(oForm.elements['SC_DIAGNOSTICO'] && oForm.elements['SC_DIAGNOSTICO'].value == ''){
			oForm.elements['SC_DIAGNOSTICO'].focus();
			alert(diagnostico_obligatorio);
			jQuery('#BotonDIAG').show();
			return;
		}

		// Si no hay errores se envia el formulario
		oForm.elements['SC_IDESTADO'].value = IDEstado;
		oForm.encoding	= 'application/x-www-form-urlencoded';
		oForm.target	= '_self';
		AsignarAccion(oForm,'http://www.newco.dev.br/Gestion/Comercial/SolicitudCatalogacionSave.xsql')
		SubmitForm(oForm);
		return;		
	}else if(IDEstado == 'S'){	// PROPUESTA SOLUCION
		// Escondemos el bot�n de enviar
		jQuery('#BotonSOL').hide();

		if(oForm.elements['SC_SOLUCION'] && oForm.elements['SC_SOLUCION'].value == ''){
			oForm.elements['SC_SOLUCION'].focus();
			alert(solucion_obligatoria);
			jQuery('#BotonSOL').show();
			return;
		}

		// Si no hay errores se envia el formulario
		oForm.elements['SC_IDESTADO'].value = IDEstado;
		oForm.encoding	= 'application/x-www-form-urlencoded';
		oForm.target	= '_self';
		AsignarAccion(oForm,'http://www.newco.dev.br/Gestion/Comercial/SolicitudCatalogacionSave.xsql')
		SubmitForm(oForm);
		return;		
	}else if(IDEstado == 'R'){	// RESUELTA
		// Escondemos el bot�n de enviar
		jQuery('#BotonRES').hide();

		if(oForm.elements['SC_SOLUCION'] && oForm.elements['SC_SOLUCION'].value == ''){
			oForm.elements['SC_SOLUCION'].focus();
			alert(solucion_obligatoria);
			jQuery('#BotonRES').show();
			return;
		}

		// Si no hay errores se envia el formulario
		oForm.elements['SC_IDESTADO'].value = IDEstado;
		oForm.encoding	= 'application/x-www-form-urlencoded';
		oForm.target	= '_self';
		AsignarAccion(oForm,'http://www.newco.dev.br/Gestion/Comercial/SolicitudCatalogacionSave.xsql')
		SubmitForm(oForm);
		return;		
	}
}

 function Reset(form){
                    form.elements['FIDEMPRESA'].value = '-1';
                    form.elements['FIDCENTRO'].value = '-1';
                    form.elements['FIDRESPONSABLE'].value = '-1';
                    form.elements['FESTADO'].value = '-1';
                    form.elements['FTEXTO'].value = ''; 
                }
                
//Ense�ar el input file para subir documentos
function verCargaDoc(tipo){
	if(document.getElementById('carga'+tipo).style.display == 'none'){
		jQuery(".cargas").hide();
		jQuery("#carga"+tipo).show();

		document.forms['SolicitudCatalogacion'].elements['TIPO_DOC_DB'].value	= 'SOLCAT';
		document.forms['SolicitudCatalogacion'].elements['TIPO_DOC_HTML'].value	= tipo;
	}else{
		jQuery("#carga"+tipo).hide();
	}
}

//cargar documentos
function cargaDoc(form, tipo){
	var msg = '';

	if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("body")[0]){
		uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";
	}

	if(msg != ''){
		alert(msg);
	}else{
		if(hasFilesDoc(form)){
			var target = 'uploadFrameDoc';
			var action = 'http://' + location.hostname + '/cgi-bin/uploadDocsMVM.pl';
			var enctype = 'multipart/form-data';

			form.target = target;
			form.encoding = enctype;
			form.action = action;
			waitDoc(tipo);
			form_tmp = form;
			man_tmp = true;
			periodicTimerDoc = 0;
			periodicUpdateDoc();
			form.submit();
		}
	}//fin else
}//fin de carga documentos js

//Search form if there is a filled file input
function hasFilesDoc(form){
	for(var i=1; i<form.length; i++){
		if(form.elements[i].type == 'file' && (form.elements[i].name == 'inputFileDoc') && form.elements[i].value != '' ){
			return true;
		}
	}
	return false;
}

//function que dice al usuario de esperar
function waitDoc(tipo){
	jQuery('#waitBoxDoc'+tipo).html ('<img src="http://www.newco.dev.br/images/loading.gif" />');
	jQuery('#waitBoxDoc'+tipo).show();
	return false;
}

/**
 * Check periodically if the image upload is finished
 * @return Boolean - true if filled file input found
 */
function periodicUpdateDoc(){
	if(periodicTimerDoc >= MAX_WAIT_DOC){
		alert(document.forms['mensajeJS'].elements['HEMOS_ESPERADO'].value + MAX_WAIT_DOC + document.forms['mensajeJS'].elements['LA_CARGA_NO_TERMINO'].value);
		return false;
	}
	periodicTimerDoc++;

	if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("p")[0]){
		var tipoDocHTML	= document.forms['SolicitudCatalogacion'].elements['TIPO_DOC_HTML'].value;

		var uFrame	= uploadFrameDoc.document.getElementsByTagName("p")[0];

		document.getElementById('waitBoxDoc'+tipoDocHTML).style.display = 'none';

		if(uFrame.innerHTML.substr(0, 1) != '{' && uFrame.innerHTML.substr(0, 1) != '['){
			alert(document.forms['mensajeJS'].elements['ERROR_SIN_DEFINIR'].value);
			return false;
		}else{
			var response = eval('(' + uFrame.innerHTML + ')');

			handleFileRequestDoc(response);
			return true;
		}
	}else{
		window.setTimeout(periodicUpdateDoc, 1000);
		return false;
	}
	return true;
}

/**
 * handle Request after file (or image) upload
 * @param {Array} resp Hopefully JSON string array
 * @return Boolean
 */
function handleFileRequestDoc(resp){
	var lang = new String('');

	if(document.getElementById('myLanguage') && document.getElementById('myLanguage').innerHTML.length > 0){
		lang = document.getElementById('myLanguage').innerHTML;
	}

	var form = form_tmp;
	var msg = '';
	var target = '_top';
	var enctype = 'application/x-www-form-urlencoded';
	var documentChain = new String('');

//	var action = 'http://' + location.hostname + '/' + lang + 'confirmCargaDocumento.xsql';

	var docNombre = '';
	var docDescri = '';
	var nombre = '';

	if(resp.documentos){
		if(resp.documentos && resp.documentos.length > 0){
			for(var i=0; i<resp.documentos.length; i++){
				if(resp.documentos[i].error && resp.documentos[i].error != ''){
					msg += resp.documentos[i].error;
				}else{
					if(resp.documentos[i].size){
					/*en lugar del elemento nombre del form cojo el nombre del fichero diretamente, si hay espacios el sistema pone ghion bajo, entonces cuento cuantos ghiones son, divido al penultimo y a�ado la ultima palabra, si la ultima palabra esta vac�a implica que hay 2 ghiones bajos, entonces divido a los 2 ghiones bajos y cojo la primera parte.*/
						var sinEspacioNombre = '';
						var lastWord = '';
						var numSep = PieceCount(sinEspacioNombre,'_');
						var numSepOk = numSep -1;

						sinEspacioNombre = resp.documentos[i].nombre.replace('__','_');

						if(Piece(sinEspacioNombre,'_',numSepOk) == ''){
							if(sinEspacioNombre.search('__')){
								lastWord	= sinEspacioNombre.split('__');
								docNombre	= lastWord[0];
							}
						}else{
							lastWord	= Piece(sinEspacioNombre,'_',numSepOk);
							nombre		= sinEspacioNombre.split(lastWord);
							docNombre	= nombre[0].concat(lastWord);
						}

						documentChain += resp.documentos[i].nombre + '|'+ docNombre+'|'+ resp.documentos[i].size +'|'+ docDescri + '#';
					}
				}
			}

			if(msg == ''){
				document.getElementsByName('CADENA_DOCUMENTOS')[0].value = documentChain;
				var cadenaDoc	= document.getElementsByName('CADENA_DOCUMENTOS')[0].value;
			}
		}
	}

	var usuario	= document.forms['SolicitudCatalogacion'].elements['ID_USUARIO'].value;
	var borrados	= document.forms['SolicitudCatalogacion'].elements['DOCUMENTOS_BORRADOS'].value;
	var borr_ante	= document.forms['SolicitudCatalogacion'].elements['BORRAR_ANTERIORES'].value;
	var tipoDocDB	= document.forms['SolicitudCatalogacion'].elements['TIPO_DOC_DB'].value;
	var tipoDocHTML	= document.forms['SolicitudCatalogacion'].elements['TIPO_DOC_HTML'].value;
	// En este caso usamos el IDEmpresa del cliente como par�metro de entrada para IDPROVEEDOR
	var IDEmpresa	= '';
	if(document.forms['SolicitudCatalogacion'].elements['IDEMPRESA'].value != ''){
		IDEmpresa	= document.forms['SolicitudCatalogacion'].elements['IDEMPRESA'].value;
	}

	if(msg != ''){
		alert(msg);
		return false;
	}else{

//		form.encoding	= enctype;
//		form.action	= action;
//		form.target	= target;
		var d = new Date();

		jQuery.ajax({
			url:"http://www.newco.dev.br/Administracion/Mantenimiento/Productos/confirmCargaDocumento.xsql",
			data: "ID_USUARIO="+usuario+"&ID_PROVEEDOR="+IDEmpresa+"&DOCUMENTOS_BORRADOS="+borrados+"&BORRAR_ANTERIORES="+borr_ante+"&TIPO_DOC="+tipoDocDB+"&CADENA_DOCUMENTOS="+cadenaDoc+"&_="+d.getTime(),
			type: "GET",
			async: false,
			contentType: "application/xhtml+xml",
			beforeSend:function(){
				document.getElementById('waitBoxDoc'+tipoDocHTML).src = 'http://www.newco.dev.br/images/loading.gif';
			},
			error:function(objeto, quepaso, otroobj){
				alert("objeto:"+objeto);
				alert("otroobj:"+otroobj);
				alert("quepaso:"+quepaso);
			},
			success:function(data){
				var doc=eval("(" + data + ")");

				//reinicializo los campos del form
				document.forms['SolicitudCatalogacion'].elements['inputFileDoc'].value = '';

				if(document.forms['SolicitudCatalogacion'].elements['MAN_PRO'] && document.forms['SolicitudCatalogacion'].elements['MAN_PRO'].value != 'si'){
					if (document.forms['SolicitudCatalogacion'].elements['US_MVM'] && document.forms['SolicitudCatalogacion'].elements['US_MVM'].value == 'si'){
						document.forms['SolicitudCatalogacion'].elements['IDPROVEEDOR'].value = '-1';
					}
				}

				var tipo = document.forms['SolicitudCatalogacion'].elements['TIPO_DOC_HTML'].value;

				//vaciamos la carga documentos
				document.forms['SolicitudCatalogacion'].elements['inputFileDoc'+tipo] = '';
				jQuery("#carga"+tipo).hide();

				uploadFrameDoc.document.getElementsByTagName("p")[0].innerHTML = '';
				uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";

//				var proveedor = document.forms['SolicitudCatalogacion'].elements['IDPROVEEDOR'].value;

				//Informamos del IDDOC en el input hidden que toca y avisamos al usuario
				var IDDoc = doc[0].id_doc;
				jQuery('#DOC_'+tipo).val(IDDoc);
				//Creamos el link para acceder al archivo, link para borrarlo y ocultamos link para subir documento
				var nombreDoc	= doc[0].nombre;
				var fileDoc	= doc[0].file;
				jQuery('#docBox'+tipo).empty().append('<a href="http://' + location.hostname + '/Documentos/' + fileDoc + '" target="_blank">' + nombreDoc + '</a>').show();
				jQuery('#borraDoc'+tipo).append('<a href="javascript:borrarDoc(' + IDDoc + ',\'' + tipo + '\')"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>').show();
				jQuery('#newDoc'+tipo).hide();

				//reseteamos los input file, mismo que removeDoc
				var clearedInput;
				var uploadElem = document.getElementById("inputFileDoc_" + tipo);

				uploadElem.value = '';
				clearedInput = uploadElem.cloneNode(false);

				uploadElem.parentNode.insertBefore(clearedInput, uploadElem);
				uploadElem.parentNode.removeChild(uploadElem);
				uploadFilesDoc.splice(tipo, 1);

				return undefined;
			}
		});
	}
	return true;
}

function borrarDoc(IDDoc, tipo){
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/BorrarDocumento.xsql',
		type:	"GET",
		data:	"DOC_ID="+IDDoc+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.BorrarDocumento.estado == 'OK'){
				jQuery("#DOC_"+tipo).val("");
				jQuery("#borraDoc"+tipo).empty().hide();
				jQuery("#docBox"+tipo).empty().hide();
				jQuery("#newDoc"+tipo).show();
                        }else{
				alert('Error: ' + data.BorrarDocumento.message);
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}

function BorrarSolicitudCatalogacion(IDSol){
	var d	= new Date();

	jQuery.ajax({
		url: 'http://www.newco.dev.br/Gestion/Comercial/BorrarSolicitudCatalogacion.xsql',
		data: "SC_ID="+IDSol+"&amp;_="+d.getTime(),
		type: "GET",
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			jQuery("#SolicitudBorradaOK").hide();
			jQuery("#SolicitudBorradaKO").hide();
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.estado == 'OK'){
				var IDSolicitud = data.id;

				jQuery("#SolicitudBorradaOK").show();
				jQuery("#SOLIC_" + IDSolicitud).hide();
			}else
				jQuery("#SolicitudBorradaKO").show();
			}
		});
}