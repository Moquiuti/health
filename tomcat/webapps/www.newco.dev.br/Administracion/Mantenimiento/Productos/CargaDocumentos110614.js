//Carga documentos js
// 28-03-12 MC
 
var uploadFilesDoc = new Array();
var periodicTimerDoc = 0;
var form_tmp;
var MAX_WAIT_DOC = 1000;

function addDocFile(id){
	if(document.getElementById('MantenEmpresa')){ var remove = document.forms['MantenEmpresa'].elements['REMOVE'].value;}
        if(document.getElementById('frmManten')){ var remove = document.forms['frmManten'].elements['REMOVE'].value;}
	if(document.getElementById('form1')){ var remove = document.forms['form1'].elements['REMOVE'].value;}

	var uploadElem = document.getElementById("inputFileDoc_" + id);

	if(uploadElem.value != ''){
               
		uploadFilesDoc[uploadFilesDoc.length] = uploadElem.value;

		if(!document.getElementById("inputDocLink_" + id)){
			var rmLink = document.createElement('div');
			rmLink.setAttribute("class","remove");

			jQuery('Element').append(rmLink);
			rmLink.setAttribute('id', 'inputDocLink_' + id);
			rmLink.innerHTML = '<a href="javascript:removeDoc(\'' + id + '\');">'+ remove +'</a>';
			document.getElementById("docLongEspec_" + id).appendChild(rmLink);
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

/**
 * Prepare image for removing
 * @param {string} fileId Database-ID of the image
 * @param {int} num Number of 
 * @return Boolean
 */
function deleteDoc(fileId, num){
	var uploadElem = document.getElementById("inputFileDoc_" + num);
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
function displayDoc(id){
	for(var i=1; i<6; i++){
		if(document.getElementById("inputFileDoc_" + id) && document.getElementById("inputFileDoc_" + id).value != '' && document.getElementById("inputFileDoc_" + (1+i))){
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
	if(periodicTimerDoc >= MAX_WAIT_DOC){
		return false;
	}
	periodicTimerDoc++;

	if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("p")[0]) {
		/*var buttons = document.getElementsByName("sendFormButton");
		if (buttons[0]) {
			for (var i = 0; i < buttons.length; i++) { 
			buttons[i].style.visibility  = 'visible';
			}
		}*/
		//alert('pppp '+uploadFrameDoc.document.getElementsByTagName("p")[0]);
		
		//poner de nuevo lo que esta comentado
		if(document.getElementById('MantenEmpresa')){ tipoDoc = document.forms['MantenEmpresa'].elements['TIPO_DOC'].value; }
                if(document.getElementById('frmManten')){ tipoDoc = document.forms['frmManten'].elements['TIPO_DOC'].value; }
		if(document.getElementById('form1')){ tipoDoc = document.forms['form1'].elements['TIPO_DOC'].value; }

		document.getElementById('waitBoxDoc'+tipoDoc).style.display = 'none';
		var uFrame = uploadFrameDoc.document.getElementsByTagName("p")[0];
		
		/*if (uFrame.innerHTML.substr(0, 1) == '{' || uFrame.innerHTML.substr(0, 1) != '[') {
			alert("mirta mirta mirta mirta mirta");
		}*/
				
		if (uFrame.innerHTML.substr(0, 1) != '{' && uFrame.innerHTML.substr(0, 1) != '[') {
			//alert(document.forms['mensajeJS'].elements['ERROR_SIN_DEFINIR'].value);
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
        //producto
	if(document.getElementById('form1')){
		var usuario = document.forms['form1'].elements['ID_USUARIO'].value;
		var borrados = document.forms['form1'].elements['DOCUMENTOS_BORRADOS'].value;
		var borr_ante = document.forms['form1'].elements['BORRAR_ANTERIORES'].value;
		var tipoDoc = document.forms['form1'].elements['TIPO_DOC'].value;
		var prove = '';

		if(document.forms['form1'].elements['IDPROVEEDOR'].value != ''){
			prove = document.forms['form1'].elements['IDPROVEEDOR'].value;
		}
	}
        //manten empresa
	if(document.getElementById('MantenEmpresa')){
		var usuario = document.forms['MantenEmpresa'].elements['ID_USUARIO'].value;
		var borrados = document.forms['MantenEmpresa'].elements['DOCUMENTOS_BORRADOS'].value;
		var borr_ante = document.forms['MantenEmpresa'].elements['BORRAR_ANTERIORES'].value;
		var tipoDoc = document.forms['MantenEmpresa'].elements['TIPO_DOC'].value;
		var prove = document.forms['MantenEmpresa'].elements['IDPROVEEDOR'].value;
	}
        //manten centro
        if(document.getElementById('frmManten')){
		var usuario = document.forms['frmManten'].elements['ID_USUARIO'].value;
		var borrados = document.forms['frmManten'].elements['DOCUMENTOS_BORRADOS'].value;
		var borr_ante = document.forms['frmManten'].elements['BORRAR_ANTERIORES'].value;
		var tipoDoc = document.forms['frmManten'].elements['TIPO_DOC'].value;
		var prove = document.forms['frmManten'].elements['IDPROVEEDOR'].value;
	}

	if(msg != ''){
		alert(msg);
		return false;
	}else{
		form.encoding = enctype;
		form.action = action;
		form.target = target;

		jQuery.ajax({
			url:"http://www.newco.dev.br/Administracion/Mantenimiento/Productos/confirmCargaDocumento.xsql",
			data: "ID_USUARIO="+usuario+"&ID_PROVEEDOR="+prove+"&DOCUMENTOS_BORRADOS="+borrados+"&BORRAR_ANTERIORES="+borr_ante+"&TIPO_DOC="+tipoDoc+"&CADENA_DOCUMENTOS="+cadenaDoc,
			type: "GET",
			async: false,
			contentType: "application/xhtml+xml",
			beforeSend:function(){
				document.getElementById('confirmBox'+tipoDoc).style.display = 'none';
				document.getElementById('waitBoxDoc'+tipoDoc).src = 'http://www.newco.dev.br/images/loading.gif';
			},
			error:function(objeto, quepaso, otroobj){
				alert("objeto:"+objeto);
				alert("otroobj:"+otroobj);
				alert("quepaso:"+quepaso);
			},
			success:function(data){
				var doc=eval("(" + data + ")");

				document.getElementById('confirmBox'+tipoDoc).style.display = 'block';
				//reinicializo los campos del form1 en manten productos
				if(document.getElementById('form1')){
					document.forms['form1'].elements['inputFileDoc'].value = '';

					if(document.forms['form1'].elements['MAN_PRO'] && document.forms['form1'].elements['MAN_PRO'].value != 'si'){
						if(document.forms['form1'].elements['US_MVM'].value && document.forms['form1'].elements['US_MVM'].value == 'si'){
							document.forms['form1'].elements['IDPROVEEDOR'].value = '-1';
						}
					}

					var tipo = document.forms['form1'].elements['TIPO_DOC'].value;

					//vaciamos la carga documentos
					document.forms['form1'].elements['inputFileDoc'+tipo] = '';
					document.getElementById('confirmBox'+tipo).style.display = 'none';
					jQuery("#carga"+tipo).hide();

					var proveedor = document.forms['form1'].elements['IDPROVEEDOR'].value;
				}
				//reinicializo los campos del MantenEmpresa en manten empresa, subida logos
				if(document.getElementById('MantenEmpresa')){
					document.forms['MantenEmpresa'].elements['inputFileDoc'].value = '';
					var tipo = document.forms['MantenEmpresa'].elements['TIPO_DOC'].value;
					var proveedor = document.forms['MantenEmpresa'].elements['IDPROVEEDOR'].value;
					document.getElementById('confirmBox'+tipo).style.display = 'none';
					jQuery("#carga"+tipo).hide();
				}
                                //reinicializo los campos del MantenCentro en manten centro, subida logos
				if(document.getElementById('frmManten')){
					document.forms['frmManten'].elements['inputFileDoc'].value = '';
					var tipo = document.forms['frmManten'].elements['TIPO_DOC'].value;
					var proveedor = document.forms['frmManten'].elements['IDPROVEEDOR'].value;
					document.getElementById('confirmBox'+tipo).style.display = 'none';
					jQuery("#carga"+tipo).hide();
				}

				uploadFrameDoc.document.getElementsByTagName("p")[0].innerHTML = '';
				uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";

				//recargamos las ofertas y las fichas
				if(tipo == 'FT'){
					var currentDocID	= doc[0].id_doc;

					SeleccionaFichas(proveedor,'IDFICHA',currentDocID);

                                }else if(tipo == 'CO')	SeleccionaDocumentos(proveedor,'IDDOCUMENTO');

				else if(tipo == 'LOGO')	SeleccionaLogos(proveedor,'IDLOGOTIPO');

				else			SeleccionaOfertas(proveedor,tipo);

				//resettamos los input file, mismo que removeDoc
				var clearedInput;
				var uploadElem = document.getElementById("inputFileDoc_" + tipo);

				uploadElem.value = '';
				clearedInput = uploadElem.cloneNode(false);

				uploadElem.parentNode.insertBefore(clearedInput, uploadElem);
				uploadElem.parentNode.removeChild(uploadElem);
				uploadFilesDoc.splice(tipo, 1);
				document.getElementById("docLongEspec_" + tipo).removeChild(document.getElementById("inputDocLink_" + tipo));

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
}

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
function waitDoc(tipo, text){
	jQuery('#waitBoxDoc'+tipo).html ('<img src="http://www.newco.dev.br/images/loading.gif" />');
	jQuery('#waitBoxDoc'+tipo).show();
	return false;
}

//cargar documentos
function cargaDoc(form, tipo){
	form.elements['CHANGE_PROV'].value = 'N';

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
			var action = 'http://' + location.hostname + '/cgi-bin/uploadDocsMVM.pl';
			var enctype = 'multipart/form-data';
			form.target = target;
			form.encoding = enctype;
			form.action = action;
			waitDoc(tipo, "Please wait...");
			form_tmp = form;
			man_tmp = true;
			periodicTimerDoc = 0;
			periodicUpdateDoc();
			form.submit();
		}
	}//fin else
}
//fin de carga documentos js