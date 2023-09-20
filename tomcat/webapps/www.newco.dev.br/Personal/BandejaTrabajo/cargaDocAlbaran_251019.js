//	carga de documentos JS, utilizado por página de inicio y por Control de pedidos
//	Ultima revisión: ET 29oct19 19:05 cargaDocAlbaran_251019.js
 
var uploadFilesDoc = new Array();
var periodicTimerDoc = 0;
var form_tmp;
var MAX_WAIT_DOC = 1000;

var moID = '';
var IDControl = '';							//	28oct19 Guarda el ID de la multioferta para la que se sube el albarán en WFSTatusHTML
var tipoDoc ='';

//cargar documentos
function cargaDocPed(Tipo, nombreForm, MO_ID)
{
	//solodebug	console.log('cargaDocPed ('+Tipo+','+nombreForm+','+MO_ID+')');

	IDControl=MO_ID;
	tipoDoc=Tipo;

    var form=document.forms[nombreForm];
	var msg = '';
	
	//	Copia el control con el fichero a subir
	jQuery("#inputFileDoc").remove()
	var x = jQuery("#inputFileDoc_"+IDControl),
    y = x.clone();
	y.attr("id", "inputFileDoc");
	y.attr("name", "inputFileDoc");
	y.hide();
	y.insertAfter("#inputFileDoc_"+IDControl);

	//	Limpia el espacio de intercambio de ficheros o pondrá el nombre del anterior
	/*if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("p")[0]) 
	{
		var elements = uploadFrameDoc.document.getElementsByTagName("p");
		while (elements[0]) elements[0].parentNode.removeChild(elements[0]);
	}*/

	if(hasFilesDoc(form)){

		var actionAnt=form.action;	
		var targetAnt=form.target;	
		var encodingAnt=form.encoding;

		form.target = 'uploadFrameDoc';
		form.encoding = 'multipart/form-data';
		form.action = 'http://www.newco.dev.br/cgi-bin/uploadDocsMVM.pl';

		form_tmp = form;
		man_tmp = true;
		periodicTimerDoc = 0;
		periodicUpdateDoc();
		
		form.submit();

		form.action=actionAnt;
		form.target=targetAnt;
		form.encoding=encodingAnt;
	}

}//fin de carga documentos js


//	función recursiva de espera de que la imagen se haya subido
function periodicUpdateDoc()
{
	if(periodicTimerDoc >= MAX_WAIT_DOC){

		//solodebug	console.log('periodicUpdateDoc:'+IDControl+' periodicTimerDoc:'+periodicTimerDoc+' MAX_WAIT_DOC');

		return false;
	}
	periodicTimerDoc++;

	if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("p")[0]) {
            
		var uFrame = uploadFrameDoc.document.getElementsByTagName("p")[0];
		
		if (uFrame.innerHTML.substr(0, 1) != '{' && uFrame.innerHTML.substr(0, 1) != '[') {

			//control de errores vía consola
			console.log('periodicUpdateDoc:'+IDControl+' ret:'+uFrame.innerHTML+' err:'+document.forms['mensajeJS'].elements['ERROR_SIN_DEFINIR'].value);

			return false;
		}
		else 
		{
			var response = eval('(' + uFrame.innerHTML + ')');

			handleFileRequestDoc(response);
			return true;
		}
	}
	else
	{
		window.setTimeout(periodicUpdateDoc, 1000);
		return false;
	}
	return true;
}


//	Una vez enviado el documento, realiza el postproceso
function handleFileRequestDoc(resp)
{    
		
	//solodebug console.log('handleFileRequestDoc('+resp+','+IDMultioferta+')');
	
	var lang = new String('');
	if(document.getElementById('myLanguage') && document.getElementById('myLanguage').innerHTML.length > 0){
		lang = document.getElementById('myLanguage').innerHTML;
	}

	var form = form_tmp;
	var msg = '';
	var documentChain = new String('');
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
						/*en lugar del elemento nombre del form cojo el nombre del fichero diretamente, si hay espacios el sistema pone guion bajo, entonces cuento cuantos guiones son, divido al penultimo y aÃ±ado la ultima palabra, si la ultima palabra esta vacÃ­a implica que hay 2 guiones bajos, entonces divido a los 2 guiones bajos y cojo la primera parte.*/
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
	//solodebug console.log("Tipo:"+tipoDoc);
	var IDProveedor,IDMultioferta,IDEmpresa;
    if (PaginaOrigen=="WFStatus")
	{
		usuario = document.forms['Form1'].elements['ID_USUARIO'].value;
		IDProveedor = document.forms['Form1'].elements['IDPROVEEDOR_ALB'].value;
		IDMultioferta=IDControl;
		IDEmpresa=document.forms['Form1'].elements['IDCLIENTE_'+IDMultioferta].value;
	}
    else
	{
        if(document.getElementById('Cabecera'))
		{
			usuario = document.forms['Cabecera'].elements['ID_USUARIO'].value;
			IDProveedor = document.forms['Cabecera'].elements['IDPROVEEDOR'].value;
			IDEmpresa=document.forms['Cabecera'].elements['IDEMPRESA'].value;
			IDMultioferta=IDControl;
		}
		else
		{
			console.log("PaginaOrigen:"+PaginaOrigen+" ERROR.");
		}
	}

    //alert("LLamando a confirmCargaDocumento: ID_USUARIO="+usuario+"&ID_PROVEEDOR="+prove+"&DOCUMENTOS_BORRADOS="+borrados+"&BORRAR_ANTERIORES="+borr_ante+"&TIPO_DOC="+tipoDoc+"&CADENA_DOCUMENTOS="+cadenaDoc);

	if(msg != ''){
		alert(msg);
		return false;
	}else{

		jQuery.ajax({
			//url:"http://www.newco.dev.br/Administracion/Mantenimiento/Productos/confirmCargaDocumento.xsql",
			url:"http://www.newco.dev.br/Compras/Multioferta/confirmCargaDocumentoPedidoAJAX.xsql",
			//data: "&MO_ID="+IDMultioferta+"&IDEMPRESA="+IDEmpresa+"&ID_USUARIO="+usuario+"&ID_PROVEEDOR="+IDProveedor+"&DOCUMENTOS_BORRADOS="+borrados+"&BORRAR_ANTERIORES="+borr_ante+"&TIPODOC="+tipoDoc+"&CADENA_DOCUMENTOS="+cadenaDoc,
			data: "&MO_ID="+IDMultioferta+"&IDEMPRESA="+IDEmpresa+"&ID_PROVEEDOR="+IDProveedor+"&DOCUMENTOS_BORRADOS=&BORRAR_ANTERIORES=&TIPODOC="+tipoDoc+"&CADENA_DOCUMENTOS="+cadenaDoc,
			type: "GET",
			async: false,
			contentType: "application/xhtml+xml",
			beforeSend:function(){
				jQuery('#waitBoxDoc_'+IDControl).attr('src','http://www.newco.dev.br/images/loading.gif');
				jQuery('#waitBoxDoc_'+IDControl).show();
			},
			error:function(objeto, quepaso, otroobj){
				jQuery('#waitBoxDoc_'+IDControl).hide();
				alert("objeto:"+objeto+" otroobj:"+otroobj+" quepaso:"+quepaso);
			},
			success:function(data){
				var doc=JSON.parse(data);
				
				jQuery('#waitBoxDoc_'+IDControl).hide();

				uploadFrameDoc.document.getElementsByTagName("p")[0].innerHTML = '';
				uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";

				//	solodebug	console.log('Guardado doc. ID:'+doc[0].id_doc);
                                
				var nombreDoc	= doc[0].nombre;
				var fileDoc	= doc[0].file;
				var htmlCad= '&nbsp;<a href="http://www.newco.dev.br/Documentos/' + fileDoc + '" target="_blank">' + nombreDoc + '</a>'
								+'<a href="javascript:borrarDoc(\'ALBARAN\','+doc[0].id_doc+','+IDMultioferta+');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>';

				//recargamos las ofertas y las fichas
   				if (PaginaOrigen=="WFStatus")
				{
					jQuery('#docBox_'+IDControl).empty().append(htmlCad).show();
					jQuery('#inputFileDoc_'+IDControl).hide();
            	}
				else
				{
            		if(document.forms['Cabecera'])
					{
						jQuery('#docBox_'+IDControl).empty().append(htmlCad).show();
						jQuery('#inputFileDoc_'+IDControl).hide();
            		}
				}
				
				//limpiamos los input file, mismo que removeDoc
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


//Search form if there is a filled file input
function hasFilesDoc(form){
	for(var i=1; i<form.length; i++) {
		if(form.elements[i].type == 'file' && (form.elements[i].name == 'inputFileDoc') && form.elements[i].value != '' ){
			return true;
		}
	}
	return false;
}


//	Borra un documento de la base de datos y de la pantalla
function borrarDoc(Tipo, IDDoc, MO_ID)
{
	var d = new Date();

	//solodebug console.log('borrarDoc('+Tipo+', '+IDDoc+', '+MO_ID+')');
	
	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/BorrarDocumento.xsql',
		type:	"GET",
		data:	"DOC_ID="+IDDoc+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			//solodebug console.log('borrarDoc('+Tipo+', '+IDDoc+', '+MO_ID+'). Estado:'+data.BorrarDocumento.estado);

			if(data.BorrarDocumento.estado == 'OK')
			{
				//solodebug console.log('borrarDoc('+Tipo+', '+IDDoc+', '+MO_ID+'). Estado:'+data.BorrarDocumento.estado+' vaciando...');

				jQuery('#docBox_'+MO_ID).empty().hide();
				jQuery('#inputFileDoc_'+MO_ID).show();
            }
			else
			{
				alert('Error: ' + data.BorrarDocumento.message);
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}

