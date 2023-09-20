// JavaScript Document
//DETALLE PRODUCTO INCIDENCIAS MC 18-06-2013

var uploadFilesDoc = new Array();
var periodicTimerDoc = 0;
var form_tmp;
var MAX_WAIT_DOC = 1000;

function GuardarNuevaIncidencia(form){
	var msg = '';
	var idLic = form.elements['LIC_OFE_ID'].value;
	var licProdId = form.elements['LIC_PROD_ID'].value;
	var user = form.elements['USER'].value;
        
        
        var radioSeguirUtilizando = document.getElementsByName('SEGUIR_UTILIZANDO_VALUES');
		for(var j = 0; j < radioSeguirUtilizando.length; j++){
			if(radioSeguirUtilizando[j].checked == true){
				form.elements['SEGUIR_UTILIZANDO'].value = radioSeguirUtilizando[j].value;
			}
		}
                
	if (form.elements['INCIDENCIA'].value == ''){ msg += textoIncidenciaObli;}
	
	if (msg == ''){
		//si estoy en licitacion paso el id de licitacion
		if (idLic != ''){
			form.action = "NuevaIncidenciaSave.xsql?USER="+user+"&LIC_OFE_ID="+idLic+"&LIC_PROD_ID="+licProdId;
			}
		else{ form.action = "NuevaIncidenciaSave.xsql";}
		
    	SubmitForm(form);
	}
	else { alert(msg);}

}

//guardar modifica incidencia
function GuardarIncidencia(form,IDEstado){
	var msg = '';
	var idLic = form.elements['LIC_OFE_ID'].value;
	var licProdId = form.elements['LIC_PROD_ID'].value;
        
         var radioSeguirUtilizando = document.getElementsByName('SEGUIR_UTILIZANDO_CDC_VALUES');
		for(var j = 0; j < radioSeguirUtilizando.length; j++){
			if(radioSeguirUtilizando[j].checked == true){
				form.elements['SEGUIR_UTILIZANDO_CDC'].value = radioSeguirUtilizando[j].value;
			}
		}   
        if (IDEstado == 'DIAG'){
            if (jQuery.trim(form.elements['DIAGNOSTICO'].value) == ''){
                msg = msg + document.forms['mensajeJS'].elements['TEXTO_DIAG_OBLI'].value;                
            }
        }
        if (IDEstado == 'P'){
            if (jQuery.trim(form.elements['PROPUESTA_SOLUCION'].value) == ''){
                msg = msg + document.forms['mensajeJS'].elements['TEXTO_PROP_SOLUCION_OBLI'].value;                
            }
        }
        
        if (IDEstado == 'RHOSP'){
            if (jQuery.trim(form.elements['TEXTO_RESP_HOSPITAL'].value) == ''){
                msg = msg + document.forms['mensajeJS'].elements['TEXTO_RESP_HOSPITAL_OBLI'].value;                
            }
        }
        
        /*if (IDEstado == 'RES' && form.elements['ESTADO_ACTUAL'].value == 'P'){
            form.elements['SOLUCION'].value = form.elements['PROPUESTA_SOLUCION'].value;
        }
        alert('sol '+form.elements['SOLUCION'].value);*/
        
	if(msg == ''){
		if(idLic != ''){
			form.action = "IncidenciaSave.xsql?LIC_OFE_ID="+idLic+"&LIC_PROD_ID="+licProdId+"&IDESTADO="+IDEstado;
		}else{
			form.action = "IncidenciaSave.xsql?IDESTADO="+IDEstado;
		}

		SubmitForm(form);
	}else{alert(msg)}
}

function RecuperaBienText(){

    if(jQuery("#INCIDENCIA").length > 0)        jQuery("#INCIDENCIA").html(jQuery("#INCIDENCIA").text().replace(/<br>/gi,'\n'));
     if(jQuery("#INCIDENCIA_OLD").length > 0)        jQuery("#INCIDENCIA_OLD").html(jQuery("#INCIDENCIA_OLD").text().replace(/<br>/gi,'\n'));
     
   
     if(jQuery("#DIAGNOSTICO").length > 0)        jQuery("#DIAGNOSTICO").html(jQuery("#DIAGNOSTICO").text().replace(/<br>/gi,'\n'));
     if(jQuery("#DIAGNOSTICO_OLD").length > 0)        jQuery("#DIAGNOSTICO_OLD").html(jQuery("#DIAGNOSTICO_OLD").text().replace(/<br>/gi,'\n'));
     
     if(jQuery("#PROPUESTA_SOLUCION").length > 0)        jQuery("#PROPUESTA_SOLUCION").html(jQuery("#PROPUESTA_SOLUCION").text().replace(/<br>/gi,'\n'));
     if(jQuery("#PROPUESTA_SOLUCION_OLD").length > 0)        jQuery("#PROPUESTA_SOLUCION_OLD").html(jQuery("#PROPUESTA_SOLUCION_OLD").text().replace(/<br>/gi,'\n'));
     
     if(jQuery("#TEXTO_RESP_HOSPITAL").length > 0)        jQuery("#TEXTO_RESP_HOSPITAL").html(jQuery("#TEXTO_RESP_HOSPITAL").text().replace(/<br>/gi,'\n'));
     if(jQuery("#TEXTO_RESP_HOSPITAL_OLD").length > 0)        jQuery("#TEXTO_RESP_HOSPITAL_OLD").html(jQuery("#TEXTO_RESP_HOSPITAL_OLD").text().replace(/<br>/gi,'\n'));
     
     if(jQuery("#SOLUCION").length > 0)        jQuery("#SOLUCION").html(jQuery("#SOLUCION").text().replace(/<br>/gi,'\n'));
     if(jQuery("#SOLUCION_OLD").length > 0)        jQuery("#SOLUCION_OLD").html(jQuery("#SOLUCION_OLD").text().replace(/<br>/gi,'\n'));
    
}
//cancelar, volver a las incidencias desde modifica incidencia comprobando datos
function ComprobarCambiosIncidencia(form,guardar){
	var change= '';
	
	var producto = form.elements['PRO_ID'].value;
	
	if (form.elements['INCIDENCIA_OLD'].value == form.elements['INCIDENCIA'].value){}
	else{ change += '1';}
	if (form.elements['DIAGNOSTICO_OLD'].value == form.elements['DIAGNOSTICO'].value){}
	else{ change += '2';}
	if (form.elements['SOLUCION_OLD'].value == form.elements['SOLUCION'].value){}
	else{ change += '3';}
	
	//si no he hecho cambios vuelvo atras
	if (change == ''){ 
		document.location = 'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencias.xsql?PRO_ID='+producto;
		}
	//si usuario ha hecho cambios le pregunto antes de salir
	else{
		 if(!confirm(seguroSalirIncidencia)) {} 
         else { document.location = 'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/Incidencias.xsql?PRO_ID='+producto; }   
		
		}
}
//eliminar una incidencia 
function EliminarIncidencia(idInc){
	var d = new Date();
	
	jQuery.ajax({
		cache:	false,
		url:	'EliminarIncidencia.xsql',
		type:	"GET",
		data:	"PROD_INC_ID="+idInc+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			//alert(data.EliminarIncidencia.estado);
			
			if(data.EliminarIncidencia.estado == 'OK'){  document.location.reload(); }
			else{
				alert(errorEliminarIncidencia);
			}		
		}
	});	
}

//ensenyar el input file para subir docs
function verCargaDoc(tipo){
	if(document.getElementById('carga'+tipo).style.display == 'none'){
		jQuery(".cargas").hide();
		jQuery("#carga"+tipo).show();

		document.forms['Incidencia'].elements['TIPO_DOC_DB'].value	= 'INC';
		document.forms['Incidencia'].elements['TIPO_DOC_HTML'].value	= tipo;
	}else{
		jQuery("#carga"+tipo).hide();
	}
}

function addDocFile(id){
	var remove	= document.forms['Incidencia'].elements['REMOVE'].value;
	var uploadElem	= document.getElementById("inputFileDoc_" + id);

	if(uploadElem.value != ''){
		uploadFilesDoc[uploadFilesDoc.length] = uploadElem.value;

		if(!document.getElementById("inputDocLink_" + id)){
			var rmLink = document.createElement('div');

			rmLink.setAttribute("class","remove");
			jQuery('Element').append(rmLink);
			rmLink.setAttribute('id', 'inputDocLink_' + id);
			rmLink.innerHTML = '<a href="javascript:removeDoc(\'' + id + '\');">'+ remove +'</a>';

			document.getElementById("docLine_" + id).appendChild(rmLink);
		}
	}else{
		uploadFilesDoc.splice(id, 1);
		document.getElementById("docLine_" + id).removeChild(document.getElementById("inputDocLink_" + id));
	}

	return true;
}

/**
 * Remove line with remove button
 * @param {string} id Suffix of the element id
 * @return Boolean
 */
function removeDoc(id){
	var clearedInput;
	var uploadElem = document.getElementById("inputFileDoc_" + id);

	uploadElem.value = '';
	clearedInput = uploadElem.cloneNode(false);

	uploadElem.parentNode.insertBefore(clearedInput, uploadElem);
	uploadElem.parentNode.removeChild(uploadElem);
	uploadFilesDoc.splice(id, 1);
	document.getElementById("docLine_" + id).removeChild(document.getElementById("inputDocLink_" + id));

	return undefined;
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

//function que dice al usuario de esperar
function waitDoc(tipo){
	jQuery('#waitBoxDoc'+tipo).html ('<img src="http://www.newco.dev.br/images/loading.gif" />');
	jQuery('#waitBoxDoc'+tipo).show();
	return false;
}

//Search form if there is a filled file input
function hasFilesDoc(form){
	for(var i=1; i<form.length; i++){
		if(form.elements[i].type == 'file' && (form.elements[i].name == 'inputFileDoc') && form.elements[i].value != '' ){
			return true;
		}
	}
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
		var tipoDocHTML	= document.forms['Incidencia'].elements['TIPO_DOC_HTML'].value;
		//var tipoDocDB	= document.forms['Incidencia'].elements['TIPO_DOC_DB'].value;
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

	var action = 'http://' + location.hostname + '/' + lang + 'confirmCargaDocumento.xsql';

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
					/*en lugar del elemento nombre del form cojo el nombre del fichero diretamente, si hay espacios el sistema pone ghion bajo, entonces cuento cuantos ghiones son, divido al penultimo y añado la ultima palabra, si la ultima palabra esta vacía implica que hay 2 ghiones bajos, entonces divido a los 2 ghiones bajos y cojo la primera parte.*/
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

	var usuario	= document.forms['Incidencia'].elements['ID_USUARIO'].value;
	var borrados	= document.forms['Incidencia'].elements['DOCUMENTOS_BORRADOS'].value;
	var borr_ante	= document.forms['Incidencia'].elements['BORRAR_ANTERIORES'].value;
	var tipoDocDB	= document.forms['Incidencia'].elements['TIPO_DOC_DB'].value;
	var tipoDocHTML	= document.forms['Incidencia'].elements['TIPO_DOC_HTML'].value;
	var prove	= '';

	if(document.forms['Incidencia'].elements['IDPROVEEDOR'].value != ''){
		prove	= document.forms['Incidencia'].elements['IDPROVEEDOR'].value;
	}

	if(msg != ''){
		alert(msg);
		return false;
	}else{

		form.encoding	= enctype;
		form.action	= action;
		form.target	= target;
		var d = new Date();

		jQuery.ajax({
			url:"confirmCargaDocumento.xsql",
			data: "ID_USUARIO="+usuario+"&ID_PROVEEDOR="+prove+"&DOCUMENTOS_BORRADOS="+borrados+"&BORRAR_ANTERIORES="+borr_ante+"&TIPO_DOC="+tipoDocDB+"&CADENA_DOCUMENTOS="+cadenaDoc+"&_="+d.getTime(),
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
				document.forms['Incidencia'].elements['inputFileDoc'].value = '';

				if(document.forms['Incidencia'].elements['MAN_PRO'] && document.forms['Incidencia'].elements['MAN_PRO'].value != 'si'){
					if (document.forms['Incidencia'].elements['US_MVM'].value && document.forms['Incidencia'].elements['US_MVM'].value == 'si'){
						document.forms['Incidencia'].elements['IDPROVEEDOR'].value = '-1';
					}
				}

				var tipo = document.forms['Incidencia'].elements['TIPO_DOC_HTML'].value;

				//vaciamos la carga documentos
				document.forms['Incidencia'].elements['inputFileDoc'+tipo] = '';
				jQuery("#carga"+tipo).hide();

				uploadFrameDoc.document.getElementsByTagName("p")[0].innerHTML = '';
				uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";

				var proveedor = document.forms['Incidencia'].elements['IDPROVEEDOR'].value;

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

function recordatorioProveedor(IDUsuario, IDIncidencia){
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/RecordatorioProveedor.xsql',
		type:	"GET",
		data:	"PROD_INC_ID="+IDIncidencia+"&IDUSUARIO="+IDUsuario+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.RecordatorioProveedor.estado == 'OK'){
				alert(recordProvOK);
                        }else{
				alert(recordProvERR);
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}