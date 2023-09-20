//	JS para manten. Contrato
//	Ultima revisión: ET 17set18 13:20 Contrato2022_120522.js

var Dominio='http://www.newco.dev.br/';

//	Activar Parsley
jQuery(function () {
  jQuery('#Contrato').parsley().on('field:validated', function() {
    var ok = jQuery('.parsley-error').length === 0;
    jQuery('.bs-callout-info').toggleClass('hidden', !ok);
    jQuery('.bs-callout-warning').toggleClass('hidden', ok);
  })
  .on('form:submit', function() {
	//solodebug	console.log("submit");
  });
});


//	Validar y enviar ficha básica
function ValidarYEnviar()
{
	jQuery('#Contrato').parsley().validate();

    var ok = jQuery('.parsley-error').length === 0;

	//solodebug	console.log("Provincia:"+document.forms['frmFicha'].elements['PROVINCIA'].value);
	//
	//solodebug console.log("ValidarYEnviar: IDForm:Contrato. val:"+ok);

	if (ok) 
	{
		OcultarBotones();
		
    	jQuery('.bs-callout-info').show();
    	jQuery('.bs-callout-warning').hide();
		
		document.forms['Contrato'].elements['ACCION'].value='GUARDAR';	
		
		//solodebug	alert('Antes del submit: Accion:'+document.forms['Contrato'].elements['ACCION'].value+' IDCOntrato:'+document.forms['Contrato'].elements['CON_ID'].value+ ' IDDocumento:'+document.forms['Contrato'].elements['CON_IDDOCUMENTO'].value);
		
		//solodebug alert("submit"); 
		jQuery('#Contrato').submit();
	}
	else
	{
    	jQuery('.bs-callout-info').hide();
    	jQuery('.bs-callout-warning').show();
	}

}

//	26feb20 Procesa el contrato y obtiene la URL vía AJAX
function ProcesarContrato()
{
	var d= new Date();
	var IDContrato=jQuery('#CON_ID').val(),
		NombreContrato=jQuery('#CON_TITULO').val();
		
	jQuery.ajax({
		cache:	false,
		async: false,
		url:	Dominio+'/ProcesosCdC/Contratos/ProcesarContratoAJAX.xsql',
		type:	"GET",
		data:	"IDCONTRATO="+IDContrato+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
		},
		success: function(objeto){
			var data = JSON.parse(objeto);
			//	Envio correcto de datos
			
			//	solodebug console.log('ProcesarContrato:'+data.Contrato.NombreFichero);
			
			if (data.Contrato.estado=='OK')
				javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Descargas/'+data.Contrato.NombreFichero,NombreContrato,100,100,0,0);
			else
				alert(strErrorDescarga);
			
		}
	});
	
}

//	26feb20 Abre un documento en pop-up
function VerDocumento(nombre, url)
{
	javascript:MostrarPagPersonalizada(url, nombre,100,100,0,0);	
}


//	Publica la ficha para ser revisada por la central de compras
function CambioEstado(Estado)
{
	OcultarBotones();
	document.forms['Contrato'].elements['ACCION'].value='CAMBIOESTADO';
	jQuery('#Contrato').submit();
}


//	Publica la ficha para ser revisada por la central de compras
function PublicarContrato()
{
	CambioEstado('PUBLICAR');
}


//	Publica la ficha para ser revisada por la central de compras
function EliminarDocumento()
{
	OcultarBotones();
	document.forms['Contrato'].elements['ACCION'].value='QUITARDOC';
	jQuery('#Contrato').submit();
}


//	Oculta todos los botones
function OcultarBotones()
{
	jQuery('.btnDestacado').hide();
	jQuery('.btnNormal').hide();
}


//
//	Gestión del contrato escaneado, adaptado desde EMPDocs_120618.js
//

//carga de un documento
var uploadFilesDoc = new Array();
var periodicTimerDoc = 0;
var form_tmp;
var MAX_WAIT_DOC = 1000;

function cargaDoc(){

	//solodebug	console.log('cargaDoc');
	
	OcultarBotones();
	
	var form=document.forms["Documentos"];
	
  var tipo = form.elements['TIPO_DOC'].value;
  
  //	COmprueba que el tipo esté informado
  if (tipo == -1)
  {
  	alert(document.forms["MensajeJS"].elements['TIPO_OBLIGATORIO'].value);
	return;
  }
  

  if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("body")[0]){

	//solodebug	console.log('cargaDoc.Limpiando uploadFrameDoc');

    uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";
  }

  if(hasFilesDoc(form,tipo)){
  
	//solodebug	console.log('cargaDoc, preparando submit');
  
    var target = 'uploadFrameDoc';
    var action = Dominio + '/cgi-bin/uploadDocsMVM.pl';
    var enctype = 'multipart/form-data';
    form.target = target;
    form.encoding = enctype;
    form.action = action;
    waitDoc("Please wait...");
    form_tmp = form;
    man_tmp = true;
    periodicTimerDoc = 0;
    periodicUpdateDoc();
  
	//solodebug	console.log('cargaDoc, submit');

	form.submit();
	
  }
}//fin cargaDoc

//Veo si hay un input file en el form
function hasFilesDoc(form){
  for(var i = 0; i < form.length; i++){
  
	//solodebug	console.log('hasFilesDoc, comprobando:'+form.elements[i].name+' tipo:'+form.elements[i].type +' valor:'+form.elements[i].value);
  
    if(form.elements[i].type == 'file' && (form.elements[i].name == 'inputFileDoc') && form.elements[i].value != '' ){
  
		//solodebug	console.log('hasFilesDoc, true');

      return true;
    }
  }

	//solodebug	console.log('hasFilesDoc, false');

  return false;
}

//function que dice al usuario de esperar
function waitDoc(text){
  jQuery('#waitBoxDoc').html ('<img src="'+Dominio+'/images/loading.gif" />');
  jQuery('#waitBoxDoc').show();
  return false;
}

function periodicUpdateDoc()
{
	if(periodicTimerDoc >= MAX_WAIT_DOC)
	{
		alert(document.forms['mensajeJS'].elements['HEMOS_ESPERADO'].value + MAX_WAIT_DOC + document.forms['mensajeJS'].elements['LA_CARGA_NO_TERMINO'].value);
		return false;
	}
	periodicTimerDoc++;

	if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("p")[0])
	{
		document.getElementById('waitBoxDoc').style.display = 'none';
		var uFrame = uploadFrameDoc.document.getElementsByTagName("p")[0];

		if(uFrame.innerHTML.substr(0, 1) != '{' && uFrame.innerHTML.substr(0, 1) != '['){
		  alert(document.forms['mensajeJS'].elements['ERROR_SIN_DEFINIR'].value);
		  return false;
		}
		else
		{
		  var response = eval('(' + uFrame.innerHTML + ')');


			//solodebug	console.log('handleFileRequestDoc. Res:'+uFrame.innerHTML);



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

//request json carga doc
function handleFileRequestDoc(resp){
/*	17set18
  var lang = new String('');

  if(document.getElementById('myLanguage') && document.getElementById('myLanguage').innerHTML.length > 0){
    lang = document.getElementById('myLanguage').innerHTML;
  }
*/

//17set18  var form = form_tmp;

	//solodebug	console.log('handleFileRequestDoc. Response:'+resp.documentos);

	
	var form=document.forms["Documentos"];
	var cadenaDoc='';


  var msg = '';
  //var target = '_top';
  //var enctype = 'application/x-www-form-urlencoded';
  var documentChain = new String('');
  //var action = Dominio+'Administracion/Mantenimiento/Empresas/confirmCargaDocumentoEmpresa.xsql';
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
            // En lugar del elemento nombre del form cojo el nombre del fichero diretamente, si hay espacios el sistema pone guion bajo, entonces cuento cuantos guiones son, divido al penultimo y añado la ultima palabra, si la ultima palabra esta vacï¿½a implica que hay 2 ghiones bajos, entonces divido a los 2 ghiones bajos y cojo la primera parte.
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

  var borrados = jQuery('#DOCUMENTOS_BORRADOS').val();
  var borr_ante = jQuery('#BORRAR_ANTERIORES').val();
  var tipoDoc = jQuery('#TIPO_DOC').val();
  var prove = jQuery('#IDEMPRESA').val();
  

  if(msg != '')
  {
    alert(msg);
    return false;
  }
  else
  {
    
    //form.encoding = enctype;
    //form.action = action;
    //form.target = target;

    jQuery.ajax({
      url: Dominio+'Administracion/Mantenimiento/Empresas/confirmCargaDocumentoEmpresa.xsql',
      data: "ID_PROVEEDOR="+prove+"&DOCUMENTOS_BORRADOS="+borrados+"&BORRAR_ANTERIORES="+borr_ante+"&TIPO_DOC="+tipoDoc+"&CADENA_DOCUMENTOS="+cadenaDoc,
      type: "GET",
      async: false,
      contentType: "application/xhtml+xml",
      beforeSend:function(){
        document.getElementById('confirmBoxDocEmpresa').style.display = 'none';
        document.getElementById('waitBoxDoc').src = Dominio+'images/loading.gif';
      },
      error:function(objeto, quepaso, otroobj){
        alert("objeto:"+objeto);
        alert("otroobj:"+otroobj);
        alert("quepaso:"+quepaso);
      },
      success:function(data){
        //var doc=eval("(" + data + ")");
		
		var doc=JSON.parse(data);
       
		//solodebug	alert("handleFileRequestDoc. success. inicio.");

        //Informamos el campo CON_IDDocumento con el ID del documento subido
		//solodebug		console.log('confirmCargaDocumentoEmpresa. CADENA_DOCUMENTOS:'+ cadenaDoc+'//data:'+data+'//doc:'+doc+'//IDDoc:'+doc[0].id_doc);
        document.forms['Contrato'].elements['CON_IDDOCUMENTO'].value = doc[0].id_doc;

        //	Recargamos para que quede asociado el documento al registro
	    //	form.action = Dominio+'ProcesosCdC/Contratos/Contrato.xsql';

		ValidarYEnviar();

/*
        //vaciamos la carga documentos
        document.getElementById('confirmBoxDocEmpresa').style.display = 'block';
		
        //reinicializo los campos del form
        document.forms['Contrato'].elements['inputFileDoc'].value = '';

        //vaciamos la carga documentos
        document.forms['Contrato'].elements['inputFileDoc'] = '';

        uploadFrameDoc.document.getElementsByTagName("p")[0].innerHTML = '';
        uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";

		document.location.reload(true); 

        //reseteamos los input file, mismo que removeDoc
        var clearedInput;
        var uploadElem = document.getElementById("inputFileDoc");

        uploadElem.value = '';
        clearedInput = uploadElem.cloneNode(false);

        uploadElem.parentNode.insertBefore(clearedInput, uploadElem);
        uploadElem.parentNode.removeChild(uploadElem);
        document.getElementById("docLine").removeChild(document.getElementById("inputDocLink"));

		//solodebug	alert("handleFileRequestDoc. success. final.");

*/
        return undefined;
      }
    });
  }

  return true;
}//fin handleFileRequestDoc


function addDocFile(id){
  var remove = jQuery('#REMOVE').val();
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


//	Elimina el documento asociado
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










