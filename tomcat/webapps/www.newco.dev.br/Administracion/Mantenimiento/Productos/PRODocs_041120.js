//	Funciones javascript para PRODocsHTML
//	ultima revision: ET 4nov20 15:30  PRODocs_041120.js

var Dominio='http://www.newco.dev.br';	//	facilita portabilidad

function onloadEvents(){

	console.log('Inicio');

	//	12dic16	Marcamos la primera opción de menú
	jQuery("#pes_Documentos").css('background','#3b569b');
	jQuery("#pes_Documentos").css('color','#D6D6D6');
	
	// Se clica en pestañas
	jQuery("#pes_Tarifas").click(function(){
	
		//	Pendiente identificar si estamos en mantenimiento o en lectura
 		var IDProducto = document.forms['SubirDocumentos'].elements['IDPRODUCTO'].value;
		window.location.assign("http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROTarifas.xsql?PRO_ID="+IDProducto);

	});
	jQuery("#pes_Ficha").click(function(){
	
		//	Pendiente identificar si estamos en mantenimiento o en lectura
 		var IDProducto = document.forms['SubirDocumentos'].elements['IDPRODUCTO'].value;
		window.location.assign("http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROManten.xsql?PRO_ID="+IDProducto);

	});
	jQuery("#pes_Pack").click(function(){
	
		//	Pendiente identificar si estamos en mantenimiento o en lectura
 		var IDProducto = document.forms['SubirDocumentos'].elements['IDPRODUCTO'].value;
		window.location.assign("http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROPack.xsql?PRO_ID="+IDProducto);

	});
}




//eliminar una oferta
function EliminarDocumento(iddocumento,tipo,nombre)
{
	var form = document.forms['frmDocumentos'];
	var idempresa = form.elements['ID_EMPRESA'].value;
	//11jun18	var iddocumento = oferta;
	var enctype = 'application/x-www-form-urlencoded';

	//si usuario confirma
	if(confirm(strEliminarDoc)){
		form.encoding = enctype;

		jQuery.ajax({
			url:"confirmEliminaDocumentoProductoAJAX.xsql",
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

   				//var url = document.URL+'&ZONA=DOCS'; //aï¿½ado la zona asï¿½ seguirï¿½ estando en la parte de documentos.
   				//window.open(url,'_self');
				
				
				
				
				location.reload();
			}
		});
	}//fin if
}//fin EliminarDocumento


// Actualiza la fecha de la oferta (solo usuarios MVM o MVMB)
function ActualizarFechaOferta(IDOferta, tipo, nombre, IoF)
{
	//solodebug
	console.log('ActualizarFechaOferta ID:'+IDOferta+' tipo:'+tipo+' nombre:'+ nombre+' IoF:'+IoF);


	var form	= document.forms['frmDocumentos'];
	var IDEmpresa	= form.elements['ID_EMPRESA'].value;
	var fecha	= form.elements['fecha_'+IDOferta].value;
	var fechaFinal	= form.elements['fechaFinal_'+IDOferta].value;
	//var IDDoc	= IDOferta;
	var enctype = 'application/x-www-form-urlencoded';
	var buton = 'Fecha'+IoF+'_'+IDOferta;
	var waitBox = 'waitBoxFecha'+IoF+'_'+IDOferta;

	//solodebug
	console.log('ActualizarFechaOferta ID:'+IDOferta+' tipo:'+tipo+' nombre:'+ nombre);

	//si usuario confirma
	if(strModificarFecha){
		form.encoding = enctype;

		jQuery.ajax({
			url:"http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/confirmModFechaOferta.xsql",
 			data:"ID_EMPRESA="+IDEmpresa+"&ID_DOCUMENTO="+IDOferta+"&MOD_FECHA="+fecha+"&MOD_FECHA_FINAL="+fechaFinal,
			type: "GET",
			contentType: "application/xhtml+xml",
			beforeSend:function(){
				jQuery("#"+buton).hide();
				jQuery("#"+waitBox).attr("src", "http://www.newco.dev.br/images/loading.gif")
				jQuery("#"+waitBox).show();
			},
			error:function(objeto, quepaso, otroobj){
				alert("objeto:"+objeto+otroobj+quepaso);
				jQuery("#"+waitBox).hide();
				jQuery("#"+buton).show();
			},
			success:function(data){
				var doc=eval("(" + data + ")");
				jQuery("#"+waitBox).hide();
				jQuery("#"+buton).show();
			}
		});
	}
}//fin ActualizarFechaOferta


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
  	alert(strTipoObligatorio);
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
    alert(strHemosEsperado + MAX_WAIT_DOC + strCargaNoTermino);
    return false;
  }
  periodicTimerDoc++;

  if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("p")[0]){
    document.getElementById('waitBoxDoc').style.display = 'none';
    var uFrame = uploadFrameDoc.document.getElementsByTagName("p")[0];

    if(uFrame.innerHTML.substr(0, 1) != '{' && uFrame.innerHTML.substr(0, 1) != '['){
      alert(strErrorSinDefinir);
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
  var action = 'http://' + location.hostname + '/' + lang + 'confirmCargaDocumentoProductoAJAX.xsql';
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
            // En lugar del elemento nombre del form cojo el nombre del fichero diretamente, si hay espacios el sistema pone guion bajo, entonces cuento cuantos ghiones son, divido al penultimo y aï¿½ado la ultima palabra, si la ultima palabra esta vacï¿½a implica que hay 2 ghiones bajos, entonces divido a los 2 ghiones bajos y cojo la primera parte.
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

  //var borrados = document.forms['SubirDocumentos'].elements['DOCUMENTOS_BORRADOS'].value;
  //var borr_ante = document.forms['SubirDocumentos'].elements['BORRAR_ANTERIORES'].value;
  var tipoDoc = document.forms['SubirDocumentos'].elements['TIPO_DOC'].value;
  var IDProveedor = document.forms['SubirDocumentos'].elements['IDPROVEEDOR'].value;
  var IDProducto = document.forms['SubirDocumentos'].elements['IDPRODUCTO'].value;

  if(msg != ''){
    alert(msg);
    return false;
  }else{
    form.encoding = enctype;
    form.action = action;
    form.target = target;

    jQuery.ajax({
      url:"confirmCargaDocumentoProductoAJAX.xsql",
      data: "IDPROVEEDOR="+IDProveedor+"&IDPRODUCTO="+IDProducto+"&TIPO_DOC="+tipoDoc+"&CADENA_DOCUMENTOS="+cadenaDoc,
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


		/*

        //resettamos los input file, mismo que removeDoc
        var clearedInput;
        var uploadElem = document.getElementById("inputFileDoc");

        uploadElem.value = '';
        clearedInput = uploadElem.cloneNode(false);

        uploadElem.parentNode.insertBefore(clearedInput, uploadElem);
        uploadElem.parentNode.removeChild(uploadElem);
        document.getElementById("docLine").removeChild(document.getElementById("inputDocLink"));
        return undefined;
		*/
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

//funcion visualiza ofertas que quiero asociar con anexo
function verOfertasAnexo(tipo,id){
  jQuery(".ofertasAnexo").hide();

  if(tipo == '-1'){
    alert('debes seleccionar un tipo de ofertas');
  }else{
    document.getElementById("OFERTAS_ANEXO_"+tipo+'_'+id).style.display = 'block';
  }
}



//	Et 11jun18 copiado desde CargaDocumentos280314.js
function removeDoc(){
	var clearedInput;
	var uploadElem = document.getElementById("inputFileDoc");

	uploadElem.value = '';
	clearedInput = uploadElem.cloneNode(false);

	uploadElem.parentNode.insertBefore(clearedInput, uploadElem);
	uploadElem.parentNode.removeChild(uploadElem);
	document.getElementById("docLine").removeChild(document.getElementById("inputDocLink"));

	return undefined;
}


//	12jun18	Cambia el estado de revisión del documento
function revisarDocumento(IDDocumento)
{
	var color='',rev='',
		stat=document.getElementById('st_'+IDDocumento).value;

	//solodebug console.log('revisarDocumento:'+IDDocumento+': '+stat);
	
	if (stat=='NARANJA') 
		{ stat='VERDE'; rev='S'; color='#4E9A06' }
	else if (stat=='VERDE') 
		{ stat='ROJO'; rev='E'; color='#CC0000'}
	else if (stat=='ROJO') 
		{ stat='NARANJA'; rev='N'; color='#F57900' }


	jQuery.ajax({
		url:Dominio+"/Administracion/Mantenimiento/Empresas/confirmDocRevisadoAJAX.xsql",
		data: "ID_DOCUMENTO="+IDDocumento+"&ESTADO="+rev,
		type: "GET",
		async: false,
		contentType: "application/xhtml+xml",
		beforeSend:function(){
		  jQuery('#btnEstado_'+IDDocumento).hide();
		  jQuery('#waitBoxEst_'+IDDocumento).attr('src','http://www.newco.dev.br/images/loading.gif');
		  jQuery('#waitBoxEst_'+IDDocumento).show(); 
		},
		error:function(objeto, quepaso, otroobj){
		  alert("objeto:"+objeto);
		  alert("otroobj:"+otroobj);
		  alert("quepaso:"+quepaso);
		},
		success:function(data){
			var doc=eval("(" + data + ")");

			jQuery('#btnEstado_'+IDDocumento).show();
			jQuery('#waitBoxEst_'+IDDocumento).hide();
			jQuery('#doc_'+IDDocumento).css("backgroundColor",color);

			jQuery('#st_'+IDDocumento).val(stat);

			//solodebug console.log('revisarDocumento:'+IDDocumento+': '+stat+': '+color+'. Res AJAX: '+data);
		}
	});
	
}













