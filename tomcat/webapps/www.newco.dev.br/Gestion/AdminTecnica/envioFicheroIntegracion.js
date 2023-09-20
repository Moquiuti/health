//Carga documentos js
// 28-03-12 MC
//  PS  11jul16 llamada nuevo script perl
//	ET	19jul16	Adaptación para subir ficheros de integracion
//	ET 20jul16	09:34



//carga de un documento
var uploadFilesDoc = new Array();
var periodicTimerDoc = 0;
var form_tmp;
var MAX_WAIT_DOC = 1000;

function cargaDoc(form){
var tipo = form.elements['TIPO_DOC'].value;

if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("body")[0]){
uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";
}

if(hasFilesDoc(form,tipo)){
var target = 'uploadFrameDoc';
var action = 'http://' + location.hostname + '/cgi-bin/uploadIntegracionMVM.pl';		//uploadDocsMVM.pl
var enctype = 'multipart/form-data';
form.target = target;
form.encoding = enctype;
form.action = action;
waitDoc("Please wait...");
form_tmp = form;
man_tmp = true;
periodicTimerDoc = 0;
periodicUpdateDoc();
form.submit();
}
}//fin cargaDoc

//Veo si hay un input file en el form
function hasFilesDoc(form){
for(var i = 1; i < form.length; i++){
if(form.elements[i].type == 'file' && (form.elements[i].name == 'inputFileDoc') && form.elements[i].value != '' ){
  return true;
}
}
return false;
}

//function que dice al usuario de esperar
function waitDoc(text){
jQuery('#waitBoxDoc').html ('<img src="http://www.newco.dev.br/images/loading.gif" />');
jQuery('#waitBoxDoc').show();
return false;
}

function periodicUpdateDoc(){
if(periodicTimerDoc >= MAX_WAIT_DOC){
alert(document.forms['mensajeJS'].elements['HEMOS_ESPERADO'].value + MAX_WAIT_DOC + document.forms['mensajeJS'].elements['LA_CARGA_NO_TERMINO'].value);
return false;
}
periodicTimerDoc++;

if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("p")[0]){
document.getElementById('waitBoxDoc').style.display = 'none';
var uFrame = uploadFrameDoc.document.getElementsByTagName("p")[0];

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

//request json carga doc
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
	var action = 'http://' + location.hostname + '/' + lang + 'confirmCargaDocumentoIntegracion.xsql';
	var docNombre = '';
	var docDescri = '';
	var nombre = '';

	if(resp.documentos){
		if(resp.documentos && resp.documentos.length > 0){
		  for(var i = 0; i < resp.documentos.length; i++){
    		if(resp.documentos[i].error && resp.documentos[i].error != ''){
    		  msg += resp.documentos[i].error;
    		}else{
    		  if(resp.documentos[i].size){
        		// En lugar del elemento nombre del form cojo el nombre del fichero diretamente, si hay espacios el sistema pone ghion bajo, entonces cuento cuantos ghiones son, divido al penultimo y aï¿½ado la ultima palabra, si la ultima palabra esta vacï¿½a implica que hay 2 ghiones bajos, entonces divido a los 2 ghiones bajos y cojo la primera parte.
        		var sinEspacioNombre = '';
        		var lastWord = '';
        		var sinEspacioNombre = resp.documentos[i].nombre.replace('__','_');
        		var numSep = PieceCount(sinEspacioNombre,'_');
        		var numSepOk = numSep -1;

        		if(Piece(sinEspacioNombre,'_',numSepOk) == ''){
        		  if(sinEspacioNombre.search('__')){
            		lastWord = 	sinEspacioNombre.split('__');
            		docNombre = lastWord[0];
        		  }
        		}else{
        		  lastWord = Piece(sinEspacioNombre,'_',numSepOk);
        		  nombre = sinEspacioNombre.split(lastWord);
        		  docNombre = nombre[0].concat(lastWord);
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

	var borrados = document.forms['SubirDocumentos'].elements['DOCUMENTOS_BORRADOS'].value;
	var borr_ante = document.forms['SubirDocumentos'].elements['BORRAR_ANTERIORES'].value;
	var tipoDoc = document.forms['SubirDocumentos'].elements['TIPO_DOC'].value;
	var prove = document.forms['SubirDocumentos'].elements['IDPROVEEDOR'].value;;

	if(msg != ''){
	alert(msg);
	return false;
	}else{
	form.encoding = enctype;
	form.action = action;
	form.target = target;

	jQuery.ajax({
	  url:"confirmCargaDocumentoIntegracion.xsql",
	  //data: "ID_PROVEEDOR="+prove+"&DOCUMENTOS_BORRADOS="+borrados+"&BORRAR_ANTERIORES="+borr_ante+"&TIPO_DOC="+tipoDoc+"&CADENA_DOCUMENTOS="+cadenaDoc,
	  data: "CADENA_DOCUMENTOS="+cadenaDoc,
	  type: "GET",
	  async: false,
	  contentType: "application/xhtml+xml",
	  beforeSend:function(){
    	document.getElementById('confirmBoxDocEmpresa').style.display = 'none';
    	document.getElementById('waitBoxDoc').src = 'http://www.newco.dev.br/images/loading.gif';
	  },
	  error:function(objeto, quepaso, otroobj){
    	alert("objeto:"+objeto);
    	alert("otroobj:"+otroobj);
    	alert("quepaso:"+quepaso);
	  },
	  success:function(data){
    	var doc=eval("(" + data + ")");

    	document.getElementById('confirmBoxDocEmpresa').style.display = 'block';
    	//reinicializo los campos del form
    	document.forms['SubirDocumentos'].elements['inputFileDoc'].value = '';

    	//vaciamos la carga documentos
    	document.forms['SubirDocumentos'].elements['inputFileDoc'] = '';

    	uploadFrameDoc.document.getElementsByTagName("p")[0].innerHTML = '';
    	uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";

    	document.location.reload(true);

    	//resettamos los input file, mismo que removeDoc
    	var clearedInput;
    	var uploadElem = document.getElementById("inputFileDoc");

    	uploadElem.value = '';
    	clearedInput = uploadElem.cloneNode(false);

    	uploadElem.parentNode.insertBefore(clearedInput, uploadElem);
    	uploadElem.parentNode.removeChild(uploadElem);
    	document.getElementById("docLine").removeChild(document.getElementById("inputDocLink"));
    	return undefined;
	  }
	});
}

return true;
}//fin handleFileRequestDoc

function addDocFile(id){
	var remove = document.forms['SubirDocumentos'].elements['REMOVE'].value;
	var uploadElem = document.getElementById("inputFileDoc");

	if(uploadElem.value != ''){
	uploadFilesDoc[uploadFilesDoc.length] = uploadElem.value;

	if(!document.getElementById("inputDocLink")){
	  var rmLink = document.createElement('div');
	  rmLink.setAttribute("class","remove");

	  jQuery('Element').append(rmLink);
	  rmLink.setAttribute('id', 'inputDocLink');
	  rmLink.innerHTML = '<a href="javascript:removeDoc(\'' + id + '\');">'+ remove +'</a>';
	  document.getElementById("docLine").appendChild(rmLink);
	}
	}else{
	uploadFilesDoc.splice(id, 1);
	document.getElementById("docLine").removeChild(document.getElementById("inputDocLink"));
}

return true;
}


/*

//funcion visualiza ofertas que quiero asociar con anexo
function verOfertasAnexo(tipo,id){
jQuery(".ofertasAnexo").hide();

if(tipo == '-1'){
alert('debes seleccionar un tipo de ofertas');
}else{
document.getElementById("OFERTAS_ANEXO_"+tipo+'_'+id).style.display = 'block';
}
}

function asociarDocumentoPadre(id){
var form = document.forms['Anexos'];
var tipo = '';

for(i=0;i<form.length;i++){
if(form.elements[i].name.substring(0,14) == 'OFERTAS_ANEXO_'){
  var nombreSel= form.elements[i].name;
  if(document.getElementById(nombreSel).style.display == 'block'){
    var vectorTipo = nombreSel.split('_');
    var tipo = vectorTipo[2];
  }
}
}

var doc_padre = form.elements['OFERTAS_ANEXO_'+tipo+'_'+id].value;
var doc_anexo = id;

jQuery.ajax({
url:"confirmAsignarDocumentoPadre.xsql",
data: "ID_DOCUMENTO="+doc_anexo+"&ID_DOCUMENTO_PADRE="+doc_padre,
type: "GET",
async: false,
contentType: "application/xhtml+xml",
beforeSend:function(){
  document.getElementById('confirmBoxDocPadre_'+id).style.display = 'none';
  document.getElementById('waitBoxDocPadre_'+id).src = 'http://www.newco.dev.br/images/loading.gif';
  document.getElementById('waitBoxDocPadre_'+id).style.display = 'block';
},
error:function(objeto, quepaso, otroobj){
  alert("objeto:"+objeto);
  alert("otroobj:"+otroobj);
  alert("quepaso:"+quepaso);
},
success:function(data){
  var doc=eval("(" + data + ")");

  document.getElementById('waitBoxDocPadre_'+id).style.display = 'none';
  document.getElementById('confirmBoxDocPadre_'+id).style.display = 'block';

  var url = document.URL+'&ZONA=DOCS'; //aï¿½ado la zona asï¿½ seguirï¿½ estando en la parte de documentos.
    	window.open(url,'_self');
}
});
}//fin de asociarDocumentoPadre



//asociar una oferta a todos los productos de una empresa
function AsociarOfertaTodos(oferta, tipoDoc, tipo){
	var form = document.forms['OfertaForm'];
	var idempresa = form.elements['ID_EMPRESA'].value;
	var idoferta = oferta;
	var idtipoDoc = tipoDoc;
	var enctype = 'application/x-www-form-urlencoded';

	//si usuario confirma
	if(confirm(document.forms['MensajeJS'].elements['SEGURO_ASOCIAR_OFERTA'].value)){
		form.encoding = enctype;

		jQuery.ajax({
			url:"confirmAsociaOferta.xsql",
			data:"ID_EMPRESA="+idempresa+"&ID_DOCUMENTO="+idoferta+"&ID_TIPO="+idtipoDoc,
			type: "GET",
			contentType: "application/xhtml+xml",
			beforeSend:function(){
				document.getElementById('waitBoxOferta_'+tipo).style.display = 'block';
				document.getElementById('waitBoxOferta_'+tipo).src = 'http://www.newco.dev.br/images/loading.gif';
			},
			error:function(objeto, quepaso, otroobj){
				alert("objeto:"+objeto);
				alert("otroobj:"+otroobj);
				alert("quepaso:"+quepaso);
			},
			success:function(data){
				var doc=eval("(" + data + ")");

				document.getElementById('waitBoxOferta_'+tipo).style.display = 'none';
				document.getElementById('confirmBoxAsociaOferta_'+tipo).style.display = 'block';
			}
		});
	}//fin if
}//fin AsociarOfertaTodos

//asociar una oferta a todos los productos de una empresa
function AsociarDocComeTodos(oferta, tipo,nombre){
	var form = document.forms['OfertaForm'];
	var idempresa = form.elements['ID_EMPRESA'].value;
	var idoferta = oferta;
	var idtipoDoc = tipo;
	var enctype = 'application/x-www-form-urlencoded';

	//si usuario confirma
	if(confirm(document.forms['MensajeJS'].elements['SEGURO_ASOCIAR_OFERTA'].value)){
		form.encoding = enctype;

		jQuery.ajax({
			url:"confirmAsociaDocuCome.xsql",
			data:"ID_EMPRESA="+idempresa+"&ID_DOCUMENTO="+idoferta+"&ID_TIPO="+idtipoDoc,
			type: "GET",
			contentType: "application/xhtml+xml",
			beforeSend:function(){
				document.getElementById('waitBoxOferta_'+nombre).style.display = 'block';
				document.getElementById('waitBoxOferta_'+nombre).src = 'http://www.newco.dev.br/images/loading.gif';
			},
			error:function(objeto, quepaso, otroobj){
				alert("objeto:"+objeto);
				alert("otroobj:"+otroobj);
				alert("quepaso:"+quepaso);
			},
			success:function(data){
				var doc=eval("(" + data + ")");

				document.getElementById('waitBoxOferta_'+nombre).style.display = 'none';
				document.getElementById('confirmBoxAsociaOferta_'+nombre).style.display = 'block';
			}
		});
	}//fin if
}//fin AsociarDocComeTodos

//eliminar una oferta
function EliminarDocumento(oferta,tipo,nombre){
	var form = document.forms['OfertaForm'];
	var idempresa = form.elements['ID_EMPRESA'].value;
	var idoferta = oferta;
	var enctype = 'application/x-www-form-urlencoded';

	//si usuario confirma
	if(confirm(document.forms['MensajeJS'].elements['SEGURO_ELIMINAR_OFERTA'].value)){
		form.encoding = enctype;

		jQuery.ajax({
			url:"confirmEliminaOferta.xsql",
			data:"ID_DOCUMENTO="+idoferta,
			type: "GET",
			contentType: "application/xhtml+xml",
			beforeSend:function(){
				document.getElementById('waitBoxOferta_'+nombre).style.display = 'block';
				document.getElementById('waitBoxOferta_'+nombre).src = 'http://www.newco.dev.br/images/loading.gif';
			},
			error:function(objeto, quepaso, otroobj){
				alert("objeto:"+objeto);
				alert("otroobj:"+otroobj);
				alert("quepaso:"+quepaso);
			},
			success:function(data){
				var doc=eval("(" + data + ")");

				document.getElementById('waitBoxOferta_'+nombre).style.display = 'none';
				document.getElementById('confirmBoxEliminaOferta_'+nombre).style.display = 'block';

    var url = document.URL+'&ZONA=DOCS'; //aï¿½ado la zona asï¿½ seguirï¿½ estando en la parte de documentos.
    window.open(url,'_self');
			}
		});
	}//fin if
}//fin EliminarDocumento

// Actualiza la fecha de la oferta (solo usuarios MVM o MVMB)
function ActualizarFechaOferta(IDOferta, tipo, nombre){
	var form	= document.forms['OfertaForm'];
	var IDEmpresa	= form.elements['ID_EMPRESA'].value;
	var fecha	= form.elements['fecha_'+IDOferta].value;
var fechaFinal	= form.elements['fechaFinal_'+IDOferta].value;
	var IDDoc	= IDOferta;
	var enctype = 'application/x-www-form-urlencoded';

	//si usuario confirma
	if(confirm(document.forms['MensajeJS'].elements['SEGURO_MODIFICAR_FECHA'].value)){
		form.encoding = enctype;

		jQuery.ajax({
			url:"confirmModFechaOferta.xsql",
  data:"ID_EMPRESA="+IDEmpresa+"&ID_DOCUMENTO="+IDDoc+"&MOD_FECHA="+fecha+"&MOD_FECHA_FINAL="+fechaFinal,
			type: "GET",
			contentType: "application/xhtml+xml",
			beforeSend:function(){
				document.getElementById('confirmBoxModificaFecha_'+nombre).style.display = 'block';
				document.getElementById('waitBoxOferta_'+nombre).style.display = 'block';
				document.getElementById('waitBoxOferta_'+nombre).src = 'http://www.newco.dev.br/images/loading.gif';
			},
			error:function(objeto, quepaso, otroobj){
				alert("objeto:"+objeto);
				alert("otroobj:"+otroobj);
				alert("quepaso:"+quepaso);
			},
			success:function(data){
				var doc=eval("(" + data + ")");

				document.getElementById('waitBoxOferta_'+nombre).style.display = 'none';
				document.getElementById('confirmBoxModificaFecha_'+nombre).style.display = 'block';
			}
		});
	}
}//fin ActualizarFechaOferta

*/

//fin de carga documentos js
