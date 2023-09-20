//	carga de documentos JS, utilizado por p�gina de inicio y por Control de pedidos
//	Ultima revisi�n: ET 15mar19 10:05
 
var uploadFilesDoc = new Array();
var periodicTimerDoc = 0;
var form_tmp;
var MAX_WAIT_DOC = 1000;

var moID = '';
var tipo = '';
var IDControl = '';


//	23ene17	Iniciaremos por jQuery
function iniciar(){
    //cada class de quantity llama a su funcion
    var allCargar = document.querySelectorAll(".cargar");
    var i;

    for (i = 0; i < allCargar.length; i++) {
        allCargar[i].addEventListener('click', cargaDoc);
    }
   
}

function cargaDoc(IDElemento){
 //solodebug alert('cargaDoc-1: ');

    if (document.forms['Form1'])	var form = document.forms['Form1'];
    if (document.forms['Cabecera']) var form = document.forms['Cabecera'];

	// solodebug 	
	//alert('cargaDoc-2: '+jQuery(this).html()); 
	//alert('cargaDoc-2: '+this.document.forms['Form1']);        
	//alert ('cargaDoc-3: '+this);
	
	//var linea = this.parentNode.parentNode.parentNode;
	var linea = this.document.forms['Form1'];

	
    //para wfstatus
	if (IDElemento!='')
	{
		IDControl = IDElemento;
		moID=Piece(IDElemento,'_',1);
	}
	else
	{
	    var moIDped = linea.querySelector('.moID');
    	if (moIDped != null) moID = moIDped.value;

    	var typeDoc = linea.querySelector('.type');
    	if (typeDoc != null) IDControl = typeDoc.value; 

	}

   	var tipoDoc = linea.querySelector('.tipoDoc');
   	tipo = tipoDoc.value;

     
    if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("body")[0]){
		uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";
                
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
			waitDoc(IDControl, "Please wait...");
			form_tmp = form;
			man_tmp = true;
			periodicTimerDoc = 0;
			periodicUpdateDoc();
			form.submit();
		}
	}//fin else
    
}
}//fin cargaDoc


function cargaDocPed(id){
	// solodebug alert/'cargaDoc-1: ');
    //alert('id: '+id);
    if (document.forms['Form1']){ var form = document.forms['Form1'];  }
    if (document.forms['Cabecera']){ var form = document.forms['Cabecera'];  }

	// solodebug 	
	//alert('cargaDoc-2: '+jQuery(this).html()); 
	//alert('cargaDoc-2: '+this.document.forms['Form1']);        
	//alert ('cargaDoc-3: '+this);
	
	//var linea = this.parentNode.parentNode.parentNode;
	var linea = this.document.forms['Cabecera'];
	
	//var linea = document.getElementById("inputFileDoc_" + id);
	//alert('linea: '+linea);

    //para wfstatus
    var tipoDoc = linea.querySelector('.tipoDoc');
    tipo = tipoDoc.value;
    var moIDped = linea.querySelector('.moID');
    if (moIDped != null){  moID = moIDped.value; }
    var typeDoc = linea.querySelector('.type');
    if (typeDoc != null){  IDControl = typeDoc.value; }
    
     
    if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("body")[0]){
		uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";
                
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
			waitDoc(IDControl, "Please wait...");
			form_tmp = form;
			man_tmp = true;
			periodicTimerDoc = 0;
			periodicUpdateDoc();
			form.submit();
		}
	}//fin else
    
}
}//fin cargaDocPed

function addDocFile(id){
	//alert('id add doc file '+id + ' IDControl '+IDControl+'mo id'+moID);
	//si es control pedido y quiero añadir otro documento porqué lo quiero cambiar sobrescribo solo el id anterior.
	if (document.getElementById('ficheroAlbaranOld')){ document.getElementById('ficheroAlbaranOld').style.display = 'none'; }
	//bandeja de inicio
	if (document.getElementById('ficheroAlbaranOld_'+id)){ /*alert('ficheroAlbaranOld_'+id);*/ document.getElementById('ficheroAlbaranOld_'+id).style.display = 'none'; }
    
	var uploadElem = document.getElementById("inputFileDoc_" + id);

	if(uploadElem.value != ''){
                
                
		uploadFilesDoc[uploadFilesDoc.length] = uploadElem.value;
                
        document.getElementById('botonCargar_'+id).style.display = '';
               
		if(!document.getElementById("inputDocLink_" + id)){
            document.getElementById('remove'+id).style.display = '';
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
/*
	uploadElem.parentNode.insertBefore(clearedInput, uploadElem);
	uploadElem.parentNode.removeChild(uploadElem);
	uploadFilesDoc.splice(id, 1);*/
	document.getElementById("remove" + id).style.display = 'none';
        document.getElementById("botonCargar_" + id).style.display = 'none';

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
function periodicUpdateDoc(){
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
            
		var uFrame = uploadFrameDoc.document.getElementsByTagName("p")[0];
		
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
        
		
	//alert('moid '+moID+' '+tipo);
	
	
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
	//alert('UNO');
	if(resp.documentos){
		if(resp.documentos && resp.documentos.length > 0){
			for(var i=0; i<resp.documentos.length; i++){
				if(resp.documentos[i].error && resp.documentos[i].error != ''){
					msg += resp.documentos[i].error;
				}else{
					if(resp.documentos[i].size){
						/*en lugar del elemento nombre del form cojo el nombre del fichero diretamente, si hay espacios el sistema pone guion bajo, entonces cuento cuantos guiones son, divido al penultimo y añado la ultima palabra, si la ultima palabra esta vacía implica que hay 2 guiones bajos, entonces divido a los 2 guiones bajos y cojo la primera parte.*/
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
        
      
    //wfstatus - bandeja de inicio
	console.log("Tipo:"+Tipo);
    if (Tipo=="WFStatus")
	{
		var usuario = document.forms['Form1'].elements['ID_USUARIO'].value;
		var borrados = '';				//15mar19	document.forms['Form1'].elements['DOCUMENTOS_BORRADOS'].value;
		var borr_ante = '';				//15mar19	document.forms['Form1'].elements['BORRAR_ANTERIORES'].value;
		var tipoDoc = 'ALBARAN';		//15mar19	document.forms['Form1'].elements['TIPO_DOC'].value;
		var prove = document.forms['Form1'].elements['IDPROVEEDOR_ALB'].value;
		console.log("tipo:"+Tipo+' usuario:'+usuario);
	}
    else
        if(document.getElementById('Cabecera'))
		{
			var usuario = document.forms['Cabecera'].elements['ID_USUARIO'].value;
			var borrados = document.forms['Cabecera'].elements['DOCUMENTOS_BORRADOS'].value;
			var borr_ante = document.forms['Cabecera'].elements['BORRAR_ANTERIORES'].value;
			var tipoDoc = document.forms['Cabecera'].elements['TIPO_DOC'].value;
			var prove = document.forms['Cabecera'].elements['IDPROVEEDOR'].value;
		}
		else
		{
			console.log("tipo:"+Tipo+" ERROR.");
		}


    //alert("LLamando a confirmCargaDocumento: ID_USUARIO="+usuario+"&ID_PROVEEDOR="+prove+"&DOCUMENTOS_BORRADOS="+borrados+"&BORRAR_ANTERIORES="+borr_ante+"&TIPO_DOC="+tipoDoc+"&CADENA_DOCUMENTOS="+cadenaDoc);

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
				document.getElementById('confirmBox'+IDControl).style.display = 'none';
				document.getElementById('waitBoxDoc'+IDControl).src = 'http://www.newco.dev.br/images/loading.gif';
			},
			error:function(objeto, quepaso, otroobj){
				alert("objeto:"+objeto+" otroobj:"+otroobj+" quepaso:"+quepaso);
			},
			success:function(data){
				var doc=eval("(" + data + ")");

				uploadFrameDoc.document.getElementsByTagName("p")[0].innerHTML = '';
				uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";

				//alert('resultado:'+doc[0]+' luego deberia cargar albaran en WFSTatus');
                                
				//recargamos las ofertas y las fichas
   				if (Tipo=="WFStatus")
				{
				
					//alert('resultado: IDALBARAN_'+moID+'='+doc[0]);
				
                	document.forms['Form1'].elements['IDALBARAN_'+moID].value = doc[0].id_doc;
                	document.getElementById('download_'+moID).href = 'http://www.newco.dev.br/Documentos/'+doc[0].file;
                	document.getElementById('download_'+moID).title = doc[0].nombre;
                	//visulizo link descarga
                	document.getElementById('download_'+moID).style.display = '';
                	//oculto subida documento
                	document.getElementById('docLine_'+IDControl).style.display = 'none';
            	}
				else
            		if(document.forms['Cabecera']){
                		document.forms['Cabecera'].elements['IDALBARAN'].value = doc[0].id_doc;
                		document.getElementById('download_'+IDControl).href = 'http://www.newco.dev.br/Documentos/'+doc[0].file;
                		document.getElementById('download_'+IDControl).title = doc[0].nombre;
                		//visulizo link descarga
                		document.getElementById('download_'+IDControl).style.display = '';
                		//oculto subida documento
                		document.getElementById('docLine_'+IDControl).style.display = 'none';
            		}
                                        

				//resettamos los input file, mismo que removeDoc
				var clearedInput;
				var uploadElem = document.getElementById("inputFileDoc_" + IDControl);

				uploadElem.value = '';
				clearedInput = uploadElem.cloneNode(false);

				uploadElem.parentNode.insertBefore(clearedInput, uploadElem);
				uploadElem.parentNode.removeChild(uploadElem);
				uploadFilesDoc.splice(IDControl, 1);

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


