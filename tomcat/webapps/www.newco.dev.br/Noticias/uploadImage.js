/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

// IMAGE UPLOAD       ----------------------------------------------------------
var IMG_WIDTH = 200;
var IMG_HEIGHT = 200;
var IMG_SMALL_WIDTH = 50;
var IMG_SMALL_HEIGHT = 50;
var MAX_WAIT = 30;
var numImages = 0;
var uploadFiles = new Array();
var periodicTimer = 0;

/**
 * Add new Line with remove button
 * @param {string} id Suffix of the element id
 * @return Boolean
 * @author Martin Gangkofer gangkofer@gmail.com
 */
function hasFiles(form){
	for(var i=1; i<form.length; i++){
		if(form.elements[i].type == 'file' && (form.elements[i].name == 'inputFile') && form.elements[i].value != ''){
			return true;
		}
	}
	return false;
}

function addFile(id){
	var uploadElem = document.getElementById("inputFile_" + id);

	if(uploadElem.value != ''){
		uploadFiles[uploadFiles.length] = uploadElem.value;

		if (!document.getElementById("inputLink_" + id)){
			var rmLink = document.createElement('div');

			rmLink.setAttribute("class","remove");
			jQuery('Element').append(rmLink);
			rmLink.setAttribute('id', 'inputLink_' + id);
			rmLink.innerHTML = '<a href="javascript:removeFile(\'' + id + '\');">Remove</a>';
			document.getElementById("imageLine_" + id).appendChild(rmLink);
		}
	}else{
		uploadFiles.splice(id, 1);
		document.getElementById("imageLine_" + id).removeChild(document.getElementById("inputLink_" + id));
	}

	displayFiles();
	return true;
}

/**
 * Remove line with remove button
 * @param {string} id Suffix of the element id
 * @return Boolean
 * @author Martin Gangkofer gangkofer@gmail.com
 */
function removeFile(id){
	var clearedInput;
	var uploadElem = document.getElementById("inputFile_" + id);

	uploadElem.value = '';
	clearedInput = uploadElem.cloneNode(false);
	uploadElem.parentNode.insertBefore(clearedInput, uploadElem);
	uploadElem.parentNode.removeChild(uploadElem);
	uploadFiles.splice(id, 1);
	document.getElementById("imageLine_" + id).removeChild(document.getElementById("inputLink_" + id));
	displayFiles();
	return undefined;
}

/**
 * Display new line for image
 * @return Boolean
 * @author Martin Gangkofer gangkofer@gmail.com
 */
function displayFiles(){
	for(var i=1; i<6; i++){
		if(document.getElementById("inputFile_" + i) && document.getElementById("inputFile_" + i).value != '' && document.getElementById("imageLine_" + (1+i))){
			document.getElementById("imageLine_" + (1+i)).style.display = '';
		}
	}
	return true;
}

/**
 * Check periodically if the image upload is finished
 * @return Boolean - true if filled file input found
 * @author Martin Gangkofer gangkofer@gmail.com
 */
function periodicUpdate(){
	if(periodicTimer >= MAX_WAIT){
		alert("we waited " + MAX_WAIT + " seconds and the upload still did not finish, so we suspect sth. went wrong ;-)\n\nYou should press the stop button of your browser!\n");
		return false;
	}
	periodicTimer++;

	if(window.frames['uploadFrame'] && window.frames['uploadFrame'].document && window.frames['uploadFrame'].document.getElementsByTagName("p")[0]){
		document.getElementById('waitBox').style.display = 'none';
		var uFrame = window.frames['uploadFrame'].document.getElementsByTagName("p")[0];
		if(uFrame.innerHTML.substr(0, 1) != '{' && uFrame.innerHTML.substr(0, 1) != '['){
			alert("An undefined error occurred, please notify the admin");
			return false;
		}else{
			var response = eval('(' + uFrame.innerHTML + ')');
			handleFileRequest(response);
			return true;
		}
	}else{
		window.setTimeout(periodicUpdate,1000);
		return false;
	}
	return true;
}

/**
 * handle Request after file (or image) upload
 * @param {Array} resp Hopefully JSON string array
 * @return Boolean
 * @author Martin Gangkofer gangkofer@gmail.com
 */
function handleFileRequest(resp){
	var lang = new String('');
	var form = form_tmp;
	var msg = '';
	var msgHeader = 'Se ha producido errores en el upload de imagenes!<br /><br />'
	var target = '';
	var enctype = 'application/x-www-form-urlencoded';
	var imageChain = new String('');
	var action = 'PROMantenSave.xsql';

	if(resp instanceof Array && resp.length > 0){
		for(var i=0; i<resp.length; i++){
			if(resp[i].big && resp[i].small){
				var lungmax = resp[i].small.length;
				var lungmin = resp[i].small.length;
			}
		}
	}

	if(resp instanceof Array && resp.length > 0){
		for(i=0; i<resp.length; i++){
			if(resp[i].error && resp[i].error != ''){
				msg += resp[i].error;
			}else if(resp[i].big && resp[i].small){
				imageChain += 'mvm' + '|' + resp[i].small + '|' + resp[i].big + '#';
			}
		}

		if(msg == ''){
			document.getElementsByName('CADENA_IMAGENES')[0].value = imageChain;
			form.encoding = enctype;
			form.action = action;
			form.target = target;

			var accion = 'MantenimientoNoticiasSave.xsql';
			AsignarAccion(document.forms['form1'],accion);

			SubmitForm(document.forms['form1']);
		}
	}else if(resp.length < 1){
		msg += "Parece que tus ficheros son demasiados grandes.<br />";
	}else{
		msg += "Se ha producido un error.<br />";
	}

	if(msg != ''){
		msg = msgHeader + msg;
		return false;
	}

	return true;
}

function wait(text) {
	//aparece el loading arriba en messageError
	jQuery('#waitBox').html ('<img src="http://www.newco.dev.br/images/loading.gif" />');
	if(jQuery('#ocultoButton'))	jQuery('#ocultoButton').hide();
	jQuery('#waitBox').show();
	return false;
}

/**
 * Prepare image for removing
 * @param {string} fileId Database-ID of the image
 * @param {int} num Number of
 * @return Boolean
 * @author Martin Gangkofer gangkofer@gmail.com
 */
function deleteFile(fileId, num) {


	var uploadElem = document.getElementById("inputFile_" + num);
	var labelElem = document.getElementById("labelFile_" + num);
	var deleteChain = document.getElementsByName('IMAGENES_BORRADAS')[0].value;
	uploadElem.style.display = '';
	labelElem.style.display = '';
	uploadElem.value = '';
	deleteChain += fileId + '|S#';
	document.getElementsByName('IMAGENES_BORRADAS')[0].value = deleteChain;
        document.forms['form1'].elements['CADENA_IMAGENES'].value = '';
	return false;
}



