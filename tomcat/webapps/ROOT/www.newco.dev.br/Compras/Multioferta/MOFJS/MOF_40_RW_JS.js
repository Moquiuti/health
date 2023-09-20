//	JS para MOF_40_RW
//	Ultima revision: ET 13may19	08:57

//13may19 Para subir documento
var uploadFilesDoc = new Array();
var periodicTimerDoc = 0;
var form_tmp;
var MAX_WAIT_DOC = 1000;


function Rechazar(form,accion)
{
	//	6jul17	No es necesario justificar el motivo del rechazo
	//	Comprueba que haya un comentario
	//if (form.elements['NMU_COMENTARIOS'].value=='')
	//{
	//	alert(document.forms['MensajeJS'].elements['INFORMAR_COME_MOTIVO_RECHAZO'].value);
	//}
	//else
	//{
		comentariosToForm1(document.forms['form1'], document.forms['form1'],'NMU_COMENTARIOS');	
		AsignarAccion(form,accion);
		//quito los botones asi no doble click
		document.getElementById('ocultarBotones').style.display = 'none';
		SubmitForm(form,document);
	//}
}

function Actua(formu,accion)
{
	comentariosToForm1(document.forms['form1'], document.forms['form1'],'NMU_COMENTARIOS');	
	AsignarAccion(formu,accion);
	//quito los botones asi no doble click
		document.getElementById('ocultarBotones').style.display = 'none';
	SubmitForm(formu, document);
}

//Copiar la zona de texto NMU_COMENTARIOS del form comentarios en el campo hidden NMU_COMENTARIOS del form1
function comentariosToForm1(formOrigen, formDestino,elemento) 
{
	formDestino.elements[elemento].value=formOrigen.elements[elemento].value;
}  


//
//	Carga de documento
//

//cargar documentos
function cargaDoc(){

	//solodebug
	console.log('cargaDoc: Inicio.');


    var form=document.forms['form1'];
	var msg = '';

	/*
	if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("body")[0]){
		uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";
	}
	
	if(msg != ''){
		alert(msg);
	}else{
	*/
		if(hasFilesDoc(form)){

			var actionAnt=form.action;		//	2oct18
			var targetAnt=form.target;		//	2oct18
			var encodingAnt=form.encoding;	//	2oct18
		
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

			//solodebug
			console.log('cargaDoc: submit form.');
			
			form.submit();
			
			form.action=actionAnt;		//	2oct18
			form.target=targetAnt;		//	2oct18
			form.encoding=encodingAnt;	//	2oct18
		}
	//}//fin else
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
function waitDoc(){

	//solodebug
	console.log('waitDoc.');


	jQuery('#waitBoxDoc').html ('<img src="http://www.newco.dev.br/images/loading.gif" />');
	jQuery('#waitBoxDoc').show();
	return false;
}

/**
 * Check periodically if the image upload is finished
 * @return Boolean - true if filled file input found
 */
function periodicUpdateDoc(){

	//solodebug
	console.log('periodicUpdateDoc: Inicio.');

	if(periodicTimerDoc >= MAX_WAIT_DOC){
		alert(document.forms['mensajeJS'].elements['HEMOS_ESPERADO'].value + MAX_WAIT_DOC + document.forms['mensajeJS'].elements['LA_CARGA_NO_TERMINO'].value);
		return false;
	}
	periodicTimerDoc++;

	if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("p")[0]){
		var tipoDocHTML	= document.forms['form1'].elements['TIPO_DOC_HTML'].value;

		var uFrame	= uploadFrameDoc.document.getElementsByTagName("p")[0];

		document.getElementById('waitBoxDoc').style.display = 'none';

		if(uFrame.innerHTML.substr(0, 1) != '{' && uFrame.innerHTML.substr(0, 1) != '['){
			alert(document.forms['mensajeJS'].elements['ERROR_SIN_DEFINIR'].value);
			return false;
		}else{
			var response = eval('(' + uFrame.innerHTML + ')');

			//solodebug
			console.log('periodicUpdateDoc: llamando a handleFileRequestDoc.');

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
				
	//solodebug
	console.log('handleFileRequestDoc: Inicio.');

	if(document.getElementById('myLanguage') && document.getElementById('myLanguage').innerHTML.length > 0){
		lang = document.getElementById('myLanguage').innerHTML;
	}
/*
	var form = form_tmp;
	var target = '_top';
	var enctype = 'application/x-www-form-urlencoded';
*/
	var msg = '';
	var documentChain = new String('');


//	var action = 'http://www.newco.dev.br/' + lang + 'confirmCargaDocumentoPedido.xsql';

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
						var lastWord = '';
						var sinEspacioNombre = resp.documentos[i].nombre.replace('__','_');

						var numSep = PieceCount(sinEspacioNombre,'_');
						var numSepOk = numSep -1;

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

	//var usuario	= document.forms['form1'].elements['ID_USUARIO'].value;
	var borrados	= document.forms['form1'].elements['DOCUMENTOS_BORRADOS'].value;
	var borr_ante	= document.forms['form1'].elements['BORRAR_ANTERIORES'].value;
	var tipoDocDB	= document.forms['form1'].elements['TIPO_DOC_DB'].value;
	var tipoDocHTML	= document.forms['form1'].elements['TIPO_DOC_HTML'].value;
	// En este caso usamos el IDEmpresa del cliente como parámetro de entrada para IDPROVEEDOR
	//var IDEmpresa	= '';
	//if(document.forms['form1'].elements['IDEMPRESA'].value != ''){
	//	IDEmpresa	= document.forms['form1'].elements['IDEMPRESA'].value;
	//}

	if(msg != ''){
		alert(msg);
		return false;
	}else{

//		form.encoding	= enctype;
//		form.action	= action;
//		form.target	= target;
		var d = new Date();

		jQuery.ajax({
			url:"http://www.newco.dev.br/Compras/Multioferta/confirmCargaDocumentoPedidoAJAX.xsql",
			data: "&MO_ID="+IDMultioferta+"&IDEMPRESA="+IDEmpresa+"&TIPODOC="+tipoDocDB+"&CADENA_DOCUMENTOS="+cadenaDoc+"&_="+d.getTime(),
			type: "GET",
			async: false,
			contentType: "application/xhtml+xml",
			beforeSend:function(){
				document.getElementById('waitBoxDoc').src = 'http://www.newco.dev.br/images/loading.gif';
			},
			error:function(objeto, quepaso, otroobj){
				alert("objeto:"+objeto);
				alert("otroobj:"+otroobj);
				alert("quepaso:"+quepaso);
			},
			success:function(data){
				var doc=eval("(" + data + ")");
				
				
				//solodebug
				console.log('handleFileRequestDoc: OK.'+data);
				

				//reinicializo los campos del form
				document.forms['form1'].elements['inputFileDoc'].value = '';

				if(document.forms['form1'].elements['MAN_PRO'] && document.forms['form1'].elements['MAN_PRO'].value != 'si'){
					if (document.forms['form1'].elements['US_MVM'] && document.forms['form1'].elements['US_MVM'].value == 'si'){
						document.forms['form1'].elements['IDPROVEEDOR'].value = '-1';
					}
				}

				var tipo = document.forms['form1'].elements['TIPO_DOC_HTML'].value;

				//vaciamos la carga documentos
				document.forms['form1'].elements['inputFileDoc'+tipo] = '';
				jQuery("#carga"+tipo).hide();

				uploadFrameDoc.document.getElementsByTagName("p")[0].innerHTML = '';
				uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";

//				var proveedor = document.forms['form1'].elements['IDPROVEEDOR'].value;

				//Informamos del IDDOC en el input hidden que toca y avisamos al usuario
				//jQuery('#IDDOCUMENTO').val(doc[0].id_doc);
				//Creamos el link para acceder al archivo, link para borrarlo y ocultamos link para subir documento
				var nombreDoc	= doc[0].nombre;
				var fileDoc	= doc[0].file;
				var htmlCad= '&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://www.newco.dev.br/Documentos/' + fileDoc + '" target="_blank">' + nombreDoc + '</a>'
								+'<a href="javascript:borrarDoc('+doc[0].id_doc+');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>';
				jQuery('#docBox').empty().append(htmlCad).show();
				//jQuery('#borraDoc').append('<a href="javascript:borrarDoc(' + doc[0].id_doc + ',\'' + tipo + '\')"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>').show();
				//jQuery('#newDoc').hide();
				jQuery('#inputFileDoc').hide();

				//reseteamos los input file, mismo que removeDoc
				var clearedInput;
				var uploadElem = document.getElementById("inputFileDoc");

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



function borrarDoc(IDDoc){
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
				//jQuery("#IDDOCUMENTO").val("");
				jQuery("#borraDoc").empty().hide();
				jQuery("#docBox").empty().hide();
				//jQuery("#newDoc").show();
				jQuery('#inputFileDoc').show();
            }else{
				alert('Error: ' + data.BorrarDocumento.message);
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}

