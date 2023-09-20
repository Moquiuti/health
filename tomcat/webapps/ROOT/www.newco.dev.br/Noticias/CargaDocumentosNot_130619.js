//	Carga documentos JS
//	copiado desde Administracion/Mantenimiento/Empresas/CargaDocumentos_260419.js para su uso en las noticias
//	Ultima revision 13jun19 09:23
 
var uploadFilesDoc = new Array();
var periodicTimerDoc = 0;
var form_tmp;
var MAX_WAIT_DOC = 1000;

function addDocFile(){
	var remove = document.forms['frmNoticias'].elements['DOCUMENTOS_BORRADOS'].value;

	var uploadElem = document.getElementById("inputFileDoc");

	if(uploadElem.value != ''){
               
		uploadFilesDoc[uploadFilesDoc.length] = uploadElem.value;

		if(!document.getElementById("inputDocLink")){
			var rmLink = document.createElement('div');
			rmLink.setAttribute("class","remove");

			jQuery('Element').append(rmLink);
			rmLink.setAttribute('id', 'inputDocLink');
			rmLink.innerHTML = '<a href="javascript:removeDoc();">'+ remove +'</a>';
			document.getElementById("divDatosDocumento").appendChild(rmLink);
		}
	}else{
		uploadFilesDoc.splice(id, 1);
		document.getElementById("docLine").removeChild(document.getElementById("inputDocLink"));
	}

	return true;
}

/**
 * Remove line with remove button
 * @param {string} id Suffix of the element id
 * @return Boolean
 */
function removeDoc(){
	var clearedInput;
	var uploadElem = document.getElementById("inputFileDoc");

	uploadElem.value = '';
	clearedInput = uploadElem.cloneNode(false);

	uploadElem.parentNode.insertBefore(clearedInput, uploadElem);
	uploadElem.parentNode.removeChild(uploadElem);
	uploadFilesDoc.splice(id, 1);
	document.getElementById("docLine").removeChild(document.getElementById("inputDocLink"));

	return undefined;
}

/**
 * Prepare image for removing
 * @param {string} fileId Database-ID of the image
 * @param {int} num Number of 
 * @return Boolean
 */
function deleteDoc(fileId){
	var uploadElem = document.getElementById("inputFileDoc");
	var deleteChain = document.getElementsByName('DOCUMENTOS_BORRADOS')[0].value;
	uploadElem.style.display = '';
	uploadElem.value = '';
	deleteChain += fileId + '|S#';

	document.getElementsByName('DOCUMENTOS_BORRADOS')[0].value = deleteChain;
	return false;
}

/**
 * Display new line for doc
 * @return Boolean
 */
function displayDoc(){
	for(var i=1; i<6; i++){
		if(document.getElementById("inputFileDoc") && document.getElementById("inputFileDoc").value != '' && document.getElementById("inputFileDoc" + (1+i))){
			document.getElementById("docLine_" + (1+i)).style.display = 'block';
		}
	}
	return true;
}

/**
 * Check periodically if the image upload is finished
 * @return Boolean - true if filled file input found
 */
function periodicUpdateDoc(form){

	//solodebug
	debug('periodicUpdateDoc');

	if(periodicTimerDoc >= MAX_WAIT_DOC){
		return false;
	}
	periodicTimerDoc++;

	if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("p")[0]) 
	{
		
		tipoDoc = document.forms['frmNoticias'].elements['TIPO_DOC'].value;
 
		document.getElementById('waitBoxDoc').style.display = 'none';
		var uFrame = uploadFrameDoc.document.getElementsByTagName("p")[0];
				
		if (uFrame.innerHTML.substr(0, 1) != '{' && uFrame.innerHTML.substr(0, 1) != '[') {
			return false;
		}
		else {var response = eval('(' + uFrame.innerHTML + ')');
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


	//solodebug
	debug('handleFileRequestDoc');

	var lang = new String('');
	if(document.getElementById('myLanguage') && document.getElementById('myLanguage').innerHTML.length > 0){
		lang = document.getElementById('myLanguage').innerHTML;
	}

	var form = form_tmp;
	var msg = '';
	var target = '_top';
	var enctype = 'application/x-www-form-urlencoded';
	var documentChain = new String('');
	var action = 'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/confirmCargaDocumento.xsql';
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
				cadenaDoc= document.getElementsByName('CADENA_DOCUMENTOS')[0].value;
			}
		}
	}

	var usuario = document.forms['frmNoticias'].elements['ID_USUARIO'].value;
	var borrados = document.forms['frmNoticias'].elements['DOCUMENTOS_BORRADOS'].value;
	var borr_ante = document.forms['frmNoticias'].elements['BORRAR_ANTERIORES'].value;
	var tipoDoc = document.forms['frmNoticias'].elements['TIPO_DOC'].value;
	var prove = document.forms['frmNoticias'].elements['IDEMPRESAUSUARIO'].value;

	if(msg != ''){
		alert(msg);
		return false;
	}else{
		form.encoding = enctype;
		form.action = action;
		form.target = target;

		jQuery.ajax({
			url:"http://www.newco.dev.br/Administracion/Mantenimiento/Productos/confirmCargaDocumento.xsql",
			data: "ID_USUARIO="+usuario+"&ID_IDEmpUsuario="+prove+"&DOCUMENTOS_BORRADOS="+borrados+"&BORRAR_ANTERIORES="+borr_ante+"&TIPO_DOC="+tipoDoc+"&CADENA_DOCUMENTOS="+cadenaDoc,
			type: "GET",
			async: false,
			contentType: "application/xhtml+xml",
			beforeSend:function(){
				document.getElementById('confirmBox').style.display = 'none';
				document.getElementById('waitBoxDoc').src = 'http://www.newco.dev.br/images/loading.gif';
			},
			error:function(objeto, quepaso, otroobj){
				alert("objeto:"+objeto);
				alert("otroobj:"+otroobj);
				alert("quepaso:"+quepaso);
			},
			success:function(data){
				var doc=eval("(" + data + ")");

				var currentDocID	= doc[0].id_doc;
				var nombreDoc		= doc[0].nombre;
				var fileDoc			= doc[0].file;

				document.getElementById('confirmBox').style.display = 'block';

				form.elements['IDDOCUMENTO'].value=currentDocID;
				
				
				//solodebug
				debug('handleFileRequestDoc currentDocID:'+currentDocID);
				
				
				jQuery("#inputFileDoc").hide();
				jQuery("#docSubido").html('<a target="_blank" href="http://www.newco.dev.br/Documentos/'+fileDoc+'">'+nombreDoc+'</a>');
				jQuery("#divDatosDocumento").show();
				
				document.forms['frmNoticias'].elements['inputFileDoc'].value = '';
				var tipo = document.forms['frmNoticias'].elements['TIPO_DOC'].value;
				var IDEmpUsuario = document.forms['frmNoticias'].elements['IDEMPRESAUSUARIO'].value;
				document.getElementById('confirmBox').style.display = 'none';
				jQuery("#carga").hide();

				uploadFrameDoc.document.getElementsByTagName("p")[0].innerHTML = '';
				uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";

				//resettamos los input file, mismo que removeDoc
				var clearedInput;
				var uploadElem = document.getElementById("inputFileDoc");

				uploadElem.value = '';
				clearedInput = uploadElem.cloneNode(false);

				uploadElem.parentNode.insertBefore(clearedInput, uploadElem);
				uploadElem.parentNode.removeChild(uploadElem);
				uploadFilesDoc.splice(tipo, 1);
				//pendiente document.getElementById("docLongEspec").removeChild(document.getElementById("inputDocLink"));

				return undefined;
			}
		});
	}
	return true;
}

/**
 * @param {string} texto
 * @return string
 */
 /*
function seperatePoints(texto){
	var miString = texto;
	var result = ""

	for(var i=0; i<miString.length-1;i++){
		if((miString.charAt(i)==',')||(miString.charAt(i)==';')){
			result += miString.charAt(i)+' ';
		}else{
			result += miString.charAt(i);
		}
	}
	result += miString.charAt(miString.length - 1);
	return result;
}*/

//Search form if there is a filled file input
function hasFilesDoc(form){
	for(var i=1; i<form.length; i++) {
		if(form.elements[i].type == 'file' && (form.elements[i].name == 'inputFileDoc') && form.elements[i].value != '' ){
			return true;
		}
	}
	return false;
}

//function que dice al usuario de esperar
function waitDoc(){
	jQuery('#waitBoxDoc').html ('<img src="http://www.newco.dev.br/images/loading.gif" />');
	jQuery('#waitBoxDoc').show();
	return false;
}

//cargar documentos
function cargaDoc(form, tipo){
	//form.elements['CHANGE_PROV'].value = 'N';

	if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("body")[0]){
		uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";

		/*if (uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("p")[0]) {
			uploadFrameDoc.document.getElementsByTagName("p")[0].innerHTML = '';
		}
		if (uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("p")[1]) {
			uploadFrameDoc.document.getElementsByTagName("p")[1].innerHTML = '';
		}*/
	}

	var msg = '';

	if(msg != ''){
		alert(msg);
	}else{
		if(hasFilesDoc(form,tipo)){
			var target = 'uploadFrameDoc';
			var action = 'http://www.newco.dev.br/cgi-bin/uploadDocsMVM.pl';
			var enctype = 'multipart/form-data';
			form.target = target;
			form.encoding = enctype;
			form.action = action;
			waitDoc();
			form_tmp = form;
			man_tmp = true;
			periodicTimerDoc = 0;
			periodicUpdateDoc();
			form.submit();
		}
	}//fin else
}


function borrarDoc()
{
	//	Si es una nueva entrada, no podemos utilizar el procedimiento normal de borrado de documento
	jQuery("#inputFileDoc").show();
	jQuery("#divDatosDocumento").hide();
	jQuery("#IDDOCUMENTO").val('');
}



//fin de carga documentos js
