
// JavaScript Document

// IMAGE UPLOAD       ----------------------------------------------------------
var IMG_WIDTH = 200;
var IMG_HEIGHT = 200;
var IMG_SMALL_WIDTH = 50;
var IMG_SMALL_HEIGHT = 50;
var MAX_WAIT = 30;
var numImages = 0;
var uploadFiles = new Array();
var periodicTimer = 0;
var imageCarga = '';
/**
 * Add new Line with remove button
 * @param {string} id Suffix of the element id
 * @return Boolean
 * @author Martin Gangkofer gangkofer@gmail.com
 */
 function hasFiles(form) {
	for (var i = 1; i < form.length; i++) {
		if (form.elements[i].type == 'file' && form.elements[i].value != '') {
			return true;
		}
	}
	return false;
}

function addFile(id) {
	//alert(id);
	
	var uploadElem = document.getElementById("inputFile_" + id);
	//alert('uploadelem '+uploadElem);
	if (uploadElem.value != '') {
		uploadFiles[uploadFiles.length] = uploadElem.value;
		if (!document.getElementById("inputLink_" + id)) {
			var rmLink = document.createElement('div');
			rmLink.setAttribute("class","remove");
			
			jQuery('Element').append(rmLink);
			rmLink.setAttribute('id', 'inputLink_' + id);
			rmLink.innerHTML = '<a href="javascript:removeFile(\'' + id + '\');">Remove</a>'
			//alert(document.getElementById("imageLine_" + id));
			document.getElementById("imageLine_" + id).appendChild(rmLink);
		}
	}
	else {
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

function removeFile(id) {
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
	return false;
}

/**
 * Display new line for image
 * @return Boolean
 * @author Martin Gangkofer gangkofer@gmail.com
 */
function displayFiles() {
	for (var i = 1; i < 6; i++) {
		if (document.getElementById("inputFile_" + i) && document.getElementById("inputFile_" + i).value != '' && document.getElementById("imageLine_" + (1+i))) {
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

function periodicUpdate() {
	if (periodicTimer >= MAX_WAIT) {
		alert("we waited " + MAX_WAIT + " seconds and the upload still did not finish, so we suspect sth. went wrong ;-)\n\nYou should press the stop button of your browser!\n");
		return false;
	}
	periodicTimer++;
	

	
	if (window.frames['uploadFrame'] && window.frames['uploadFrame'].document && window.frames['uploadFrame'].document.getElementsByTagName("p")[0]) {
	
		document.getElementById('waitBox').style.display = 'none';
		var uFrame = window.frames['uploadFrame'].document.getElementsByTagName("p")[0];
		if (uFrame.innerHTML.substr(0, 1) != '{' && uFrame.innerHTML.substr(0, 1) != '[') {
			alert("An undefined error occurred, please notify the admin");
			return false;
		}
		else {
			var response = eval('(' + uFrame.innerHTML + ')');
			handleFileRequest(response);
			return true;
		}
	}
	else {
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
function handleFileRequest(resp) {
	var lang = new String('');
	
	var form = form_tmp;
	var msg = '';
	var msgHeader = 'Se ha producido errores en el upload de imagenes!<br /><br />'
	//var target = '_top';
	var target = '';
	var metodo = 'post';
	var enctype = 'multipart/form-data';
	var imageChain = new String('');
	//var action = 'http://' + location.hostname + '/Administracion/Mantenimiento/Productos/PROMantenSave.xsql';
	
	
	//var action = 'PROImageSave.xsql';
	var action = 'PROMantenSave.xsql'; 
	
	
			
	if (resp instanceof Array && resp.length > 0) {
		for (var i = 0; i < resp.length; i++) {
			 if (resp[i].big && resp[i].small) {
				var lungmax = resp[i].small.length; 
				var lungmin = resp[i].small.length; 
			 }
		}
	}
	
	if (resp instanceof Array && resp.length > 0) {
		for (var i = 0; i < resp.length; i++) {
			if (resp[i].error && resp[i].error != '') {
				msg += resp[i].error;
			}
			else if (resp[i].big && resp[i].small) {
				imageChain += 'mvm' + '|' + resp[i].small + '|' + resp[i].big + '#';
			}
		}	
		
		
		if (msg == '') {
			
			document.getElementsByName('CADENA_IMAGENES')[0].value = imageChain;
			form.encoding = enctype;
			form.method = metodo;
			form.action = action;
			form.target = target;
			
			/*  function RecargarFrames(emp_id){
              //top.mainFrame.Trabajo.zonaEmpresa.CambioEmpresaActual(emp_id);
              ejecutarFuncionDelFrame(obtenerFrame(top,'zonaEmpresa'),emp_id);
              document.location='about:blank';
            }*/
			//SubmitForm(document.forms['form']);
			
			//alert(document.getElementsByName('CADENA_IMAGENES')[0].value);
			//alert('Despues de handleFileRequest'+document.getElementsByName('PRO_ID').value);
			form.submit();
		}
	}
	else if (resp.length < 1) {
		msg += "Parece que tus ficheros son demasiados grandes.<br />";
	}
	else { 
		msg += "Se ha producido un error.<br />";
	}

	if (msg != '') {
		msg = msgHeader + msg;
		return false;
	}
	
	return true;
}

/**
 * Display new line for image
 * @return Boolean
 * @author Martin Gangkofer gangkofer@gmail.com
 */
function displayFiles() {
	
	for (var i = 1; i < 6; i++) {
		if (document.getElementById("inputFile_" + i) && document.getElementById("inputFile_" + i).value != '' && document.getElementById("imageLine_" + (1+i))) {
			document.getElementById("imageLine_" + (1+i)).style.display = '';
		} 
	}
	return true;
}


function wait(text) {
	//aparece el loading arriba en messageError
		
	jQuery('#waitBox').html ('<img src="http://www.newco.dev.br/images/loading.gif" />');
	if (jQuery('#ocultoButton')) jQuery('#ocultoButton').hide();
	jQuery('#waitBox').show();
	return false;
}

//function para cargar imagenes en proveedor, una imagen varios productos
function CargarImagen(formu) {
	
		if (hasFiles(formu)) {
					//alert('inside '+formu.elements[i].name);
					var target = 'uploadFrame';
					var action = 'http://' + location.hostname + '/cgi-bin/imageMVM.pl';
					var enctype = 'multipart/form-data';
					formu.target = target;
					formu.encoding = enctype;
					formu.action = action;
					wait("Please wait...");
					formu.submit();
					form_tmp = formu;
					man_tmp = true;
					periodicTimer = 0;
					periodicUpdate();
					
			}//fin if si hay imagenes
		
		
}//fin cargarImagenes

/**
 * Check periodically if the image upload is finished
 * @return Boolean - true if filled file input found
 * @author Martin Gangkofer gangkofer@gmail.com
 */

function periodicUpdate() {
	if (periodicTimer >= MAX_WAIT) {
		alert("we waited " + MAX_WAIT + " seconds and the upload still did not finish, so we suspect sth. went wrong ;-)\n\nYou should press the stop button of your browser!\n");
		return false;
	}
	periodicTimer++;
	
	if (window.frames['uploadFrame'] && window.frames['uploadFrame'].document && window.frames['uploadFrame'].document.getElementsByTagName("p")[0]) {
	
		document.getElementById('waitBox').style.display = 'none';
		var uFrame = window.frames['uploadFrame'].document.getElementsByTagName("p")[0];
		if (uFrame.innerHTML.substr(0, 1) != '{' && uFrame.innerHTML.substr(0, 1) != '[') {
			alert("An undefined error occurred, please notify the admin");
			return false;
		}
		else {
			var response = eval('(' + uFrame.innerHTML + ')');
			handleFileRequest(response);
			return true;
		}
	}
	else {
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
function handleFileRequest(resp) {
	var lang = new String('');
	
	var form = form_tmp;
	var msg = '';
	var msgHeader = 'Se ha producido errores en el upload de imagenes!<br /><br />'
	//var target = '_top';
	var target = '';
	var metodo = 'post';
	var enctype = 'multipart/form-data';
	var imageChain = new String('');
	
	if (resp instanceof Array && resp.length > 0) {
		for (var i = 0; i < resp.length; i++) {
			 if (resp[i].big && resp[i].small) {
				var lungmax = resp[i].small.length; 
				var lungmin = resp[i].small.length; 
			 }
		}
	}
	
	if (resp instanceof Array && resp.length > 0) {
		for (var i = 0; i < resp.length; i++) {
			if (resp[i].error && resp[i].error != '') {
				msg += resp[i].error;
			}
			else if (resp[i].big && resp[i].small) {
				imageChain += 'mvm' + '|' + resp[i].small + '|' + resp[i].big + '#';
			}
		}	
		
		
		if (msg == '') {
			
			document.getElementsByName('CADENA_IMAGENES')[0].value = imageChain;
			imageCarga = imageChain;
			//alert('Carga de imagen completada');
			
			var imaVector = imageCarga.split('|');
			var location = '<img src="http://www.medicalvm/Fotos/'+imaVector[1]+'" />';
			//alert(location);
			
			if (document.getElementById('imageCargada')){
				//$("#imageCargada").html(location);
				$("#imageCargada").html('<b><span class="rojo">Imagen Cargada</span></b>');
				

				}
			//test para ver si estoy en manten de 1 producto(tengo id=OneProdManten) o en prod provee
			
			if (document.getElementById('OneProdManten')){
				alert('mi');
				form.submit();
				}
			else{ return imageCarga;}
			
		}
	}
	else if (resp.length < 1) {
		msg += "Parece que tus ficheros son demasiados grandes.<br />";
	}
	else { 
		msg += "Se ha producido un error.<br />";
	}

	if (msg != '') {
		msg = msgHeader + msg;
		return false;
	}
	
	return true;
}

//compruebo los productos checkeados para cargar la imagen
function prodCheck (form1) {
	
	var lun = form1.length;
	//CargarImagen(form1, form0);
	var cadenaIma = form1.elements['CADENA_IMAGENES'].value;
	
	for (var i=0;i<lun;i++){
		var k = new String (form1.elements[i].name);
		if (k.match('CHECK')){
			if (form1.elements[i].checked ==true){
				var idprod = form1.elements[i].id;
							
				form1.elements['PRO_ID'].value=form1.elements[i].id;
				
				var proid = form1.elements['PRO_ID'].value;
				var idIma;
			
				jQuery.ajax({
						url:"PROImageSave.xsql",
						data:"PRO_ID="+proid+"&CADENA_IMAGENES="+cadenaIma,
			  			type: "GET",
						contentType: "application/xhtml+xml",
						beforeSend:function(){
							idIma = 'IMA_'+proid;
							document.getElementById(idIma).src = 'http://www.newco.dev.br/images/loading.gif';
							
						},
						error:function(objeto, quepaso, otroobj){
							alert("objeto:"+objeto);
							alert("otroobj:"+otroobj);
							alert("quepaso:"+quepaso);
						},
						success:function(data){
							
							var imagenes=eval("(" + data + ")");
							for (var i = 0; i < imagenes.length; i++) {
								//alert('ESTADO '+imagenes[i].estado);
								//alert('PRODUCTO '+imagenes[i].producto);
								//alert('IMAGEN '+imagenes[i].grande);
								idIma = 'IMA_'+imagenes[i].producto;
								
							}
							document.getElementById(idIma).src = 'http://www.newco.dev.br/images/imagenSI.gif';
							
							
						}
				}); 
			
			}
		}
	}
}