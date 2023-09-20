//	Funciones javascript para MODocsHTML
//	ultima revision: ET 28set20 12:16 MODocs_180920.js


//eliminar una oferta
function EliminarDocumento(iddocumento,tipo,nombre)
{
	var form = document.forms['frmDocumentos'];
	var idempresa = form.elements['ID_EMPRESA'].value;
	//11jun18	var iddocumento = oferta;
	var enctype = 'application/x-www-form-urlencoded';

	//si usuario confirma
	if(confirm(alertSeguroEliminarDoc)){
		form.encoding = enctype;

		jQuery.ajax({
			url:"http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/confirmEliminaOferta.xsql",
			data:"ID_DOCUMENTO="+iddocumento,
			type: "GET",
			contentType: "application/xhtml+xml",
			beforeSend:function(){
				document.getElementById('waitBoxOferta_'+iddocumento).style.display = 'block';
				document.getElementById('waitBoxOferta_'+iddocumento).src = 'http://www.newco.dev.br/images/loading.gif';
			},
			error:function(objeto, quepaso, otroobj){
				alert("objeto:"+objeto);
				alert("otroobj:"+otroobj);
				alert("quepaso:"+quepaso);
			},
			success:function(data){
				var doc=eval("(" + data + ")");

				//document.getElementById('waitBoxOferta_'+iddocumento).style.display = 'none';
				//document.getElementById('confirmBoxEliminaOferta_'+iddocumento).style.display = 'block';
				alert(strDocumentoBorrado);
				
				ActualizarPadre();

 				location.reload();
			}
		});
	}//fin if
}//fin EliminarDocumento



//carga de un documento
var uploadFilesDoc = new Array();
var periodicTimerDoc = 0;
var form_tmp;
var MAX_WAIT_DOC = 1000;

function cargaDoc(form){
  var tipo = form.elements['TIPO_DOC'].value;
  
  //	COmprueba que el tipo esté informado
  if (tipo == -1)
  {
  	alert(document.forms["MensajeJS"].elements['TIPO_OBLIGATORIO'].value);
	return;
  }
  

  if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("body")[0]){
    uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";
  }

  if(hasFilesDoc(form,tipo)){
    var target = 'uploadFrameDoc';
    var action = 'http://www.newco.dev.br/cgi-bin/uploadDocsMVM.pl';
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
      alert(alrtErrorDesconocido);
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
/*  var lang = new String('');

  if(document.getElementById('myLanguage') && document.getElementById('myLanguage').innerHTML.length > 0){
    lang = document.getElementById('myLanguage').innerHTML;
  }*/

  var form = form_tmp;
  var msg = '';
  var target = '_top';
  var enctype = 'application/x-www-form-urlencoded';
  var documentChain = new String('');
  //var action = 'http://www.newco.dev.br/' + lang + 'confirmCargaDocumentoPedido.xsql';
  var action = 'http://www.newco.dev.br/Compras/Multioferta/confirmCargaDocumentoPedido.xsql';
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
            // En lugar del elemento nombre del form cojo el nombre del fichero diretamente, si hay espacios el sistema pone guion bajo, entonces cuento cuantos guiones son, divido al penultimo y annado la ultima palabra, si la ultima palabra esta vacï¿½a implica que hay 2 ghiones bajos, entonces divido a los 2 ghiones bajos y cojo la primera parte.
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

  var tipoDoc = document.forms['SubirDocumentos'].elements['TIPO_DOC'].value;

  if(msg != ''){
    alert(msg);
    return false;
  }else{
    form.encoding = enctype;
    form.action = action;
    form.target = target;

    jQuery.ajax({
      url:"confirmCargaDocumentoPedidoAJAX.xsql",
      data: "MO_ID="+IDMultioferta+"&IDEMPRESA="+IDEmpresaUsuario+"&TIPODOC="+tipoDoc+"&CADENA_DOCUMENTOS="+cadenaDoc,
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
			
		ActualizarPadre();

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


//	29set20 Actualiza la página que haya llamado a esta
function ActualizarPadre()
{
	var w=window.opener;
	if (Origen=='CONTROL')
	{
		w.location='http://www.newco.dev.br/Personal/BandejaTrabajo/ControlPedidos.xsql?IDPEDIDO='+IDPedido;
	}
	else if (Origen=='MANTEN')
	{
		w.location='http://www.newco.dev.br/Administracion/Mantenimiento/Pedidos/MANTPedidosSave.xsql?MO_ID='+IDMultioferta+'&IDCLIENTE='+IDCliente+'&IDPROVEEDOR='+IDProveedor+'&ACCION=COMPROBAR';
	}
	else
	{
		
		if (MOStatus<11)
			w.location='http://www.newco.dev.br/Compras/Multioferta/CVGenerar_MO.xsql?LP_ID='+LP_ID;
		else
			w.location='http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID='+IDMultioferta;
	}
}





