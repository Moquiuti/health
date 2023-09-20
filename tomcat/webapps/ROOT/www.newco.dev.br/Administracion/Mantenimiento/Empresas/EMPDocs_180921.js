//	Funciones javascript para EMPDocsHTML
//	ultima revision: ET 18set21 18:32 EMPDocs_180921.js. Cuidado, en caso de cambios actualizar tambien EMPNuevaSimpleHTML

var sepCSV			=';';		//	10ene20
var sepTextoCSV		='';		//	10ene20
var saltoLineaCSV	='\r\n';	//	10ene20

function Inicio()
{
	//SOLODEBUG	RecuperaDocumentosAjax();
	DibujaTablas();	
}


function Buscar()
{
	var oForm = document.forms['frmDocumentos'];
	SubmitForm(oForm);
}

function cbEmpresaChange()
{
	jQuery("#IDFILTROEMPRESA").val(jQuery("#FIDEMPRESA").val());
	Buscar();
}

function DocsEmpresa(IDEmpresa)
{
	jQuery("#IDFILTROEMPRESA").val(IDEmpresa);
	Buscar();
}



function verPestana(valor)
{
	if(valor == 'DOCS'){
		jQuery(".ficha").hide();
		jQuery(".cond_comercial").hide();
		jQuery(".cond_comercial_prov").hide();
		jQuery(".documentos").show();

		if(lang == 'spanish'){
			jQuery("#DOCUMENTOS").attr('src','http://www.newco.dev.br/images/botonDocumentos1.gif');
			jQuery("#FICHA").attr('src','http://www.newco.dev.br/images/botonFicha.gif');
			jQuery("#COND_COMERC").attr('src','http://www.newco.dev.br/images/botonCondicionesComerciales.gif');
		}else{
			jQuery("#DOCUMENTOS").attr('src','http://www.newco.dev.br/images/botonDocumentos1.gif');
			jQuery("#FICHA").attr('src','http://www.newco.dev.br/images/botonFicha.gif');
			jQuery("#COND_COMERC").attr('src','http://www.newco.dev.br/images/botonCondicionesComerciales-BR.gif');
		}
	}

	if(valor == 'COND_COMERC'){
		jQuery(".ficha").hide();
		jQuery(".documentos").hide();
		jQuery(".cond_comercial_prov").hide();
        jQuery(".cond_comercial").show();

		if(lang == 'spanish'){
			jQuery("#DOCUMENTOS").attr('src','http://www.newco.dev.br/images/botonDocumentos.gif');
			jQuery("#FICHA").attr('src','http://www.newco.dev.br/images/botonFicha.gif');
			jQuery("#COND_COMERC").attr('src','http://www.newco.dev.br/images/botonCondicionesComerciales1.gif');
		}else{
			jQuery("#DOCUMENTOS").attr('src','http://www.newco.dev.br/images/botonDocumentos.gif');
			jQuery("#FICHA").attr('src','http://www.newco.dev.br/images/botonFicha.gif');
			jQuery("#COND_COMERC").attr('src','http://www.newco.dev.br/images/botonCondicionesComerciales1-BR.gif');
		}
	}

	if(valor == 'COND_COMERC_PROV'){
		jQuery(".ficha").hide();
		jQuery(".documentos").hide();
		jQuery(".cond_comercial").hide();
		jQuery(".cond_comercial_prov").show();

		if(lang == 'spanish'){
			jQuery("#DOCUMENTOS").attr('src','http://www.newco.dev.br/images/botonDocumentos.gif');
			jQuery("#FICHA").attr('src','http://www.newco.dev.br/images/botonFicha.gif');
			jQuery("#COND_COMERC_PROV").attr('src','http://www.newco.dev.br/images/botonCondicionesComerciales1.gif');
		}else{
			jQuery("#DOCUMENTOS").attr('src','http://www.newco.dev.br/images/botonDocumentos.gif');
			jQuery("#FICHA").attr('src','http://www.newco.dev.br/images/botonFicha.gif');
			jQuery("#COND_COMERC_PROV").attr('src','http://www.newco.dev.br/images/botonCondicionesComerciales1-BR.gif');
		}
	}
}


function CondProveedorSend(oForm)
{
	var IDProv	= oForm.elements['IDPROV'].value;
	var idFormaPago	= oForm.elements['IDFORMAPAGO'].value;
	var idPlazoPago	= oForm.elements['IDPLAZOPAGO'].value;
	var gestionCad	= encodeURIComponent(oForm.elements['GESTION_CADUCIDAD'].value);
	var otrasLic	= encodeURIComponent(oForm.elements['OTRAS_LICITACIONES'].value);
	var observaciones	= encodeURIComponent(oForm.elements['OBSERVACIONES'].value);
	var d		= new Date();

	jQuery('#SAVE_MSG').hide();
	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CondProvSave.xsql',
		type:	"GET",
		data:	"PROV_ID="+IDProv+"&IDFORMAPAGO="+idFormaPago+"&IDPLAZOPAGO="+idPlazoPago+"&GESTION_CADUCIDAD="+gestionCad+"&OTRAS_LICITACIONES="+otrasLic+"&OBSERVACIONES="+observaciones+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.Estado == 'OK'){
				jQuery('#SAVE_MSG_CELL').html(condProvOK);
				jQuery('#SAVE_MSG').show();

				// DC - 09/12/13 - Si venimos de Gestion >> Proveedores entonces refrescamos el frame padre
				if(String(window.opener.document.location) == 'http://www.newco.dev.br/Gestion/Comercial/CondicionesProveedores.xsql'){
					Refresh(window.opener.document);
    }
		}else{
				jQuery('#SAVE_MSG_CELL').html(condProvERR);
				jQuery('#SAVE_MSG').show();
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}


function verVacacionesComercial(idComercial)
{
	var fFecha=new Date();
	var fecha=convertirFechaATexto(fFecha);

	MostrarPagPersonalizada('http://www.newco.dev.br/Agenda/CalendarioAnual.xsql?ACCION=&TITULO=D%EDas%20H%E1biles%20del%20Comercial&FECHAACTIVA='+fecha+'&IDUSUARIOAGENDA='+idComercial+'&VENTANA=NUEVA','vacacionesProveedor',100,80,0,0);
}
	

//asociar una oferta a todos los productos de una empresa
function AsociarOfertaTodos(oferta, tipoDoc, tipo){
	var form = document.forms['frmDocumentos'];
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
function AsociarDocComeTodos(oferta, tipo,nombre)
{
	var form = document.forms['frmDocumentos'];
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
function EliminarDocumento(iddocumento,tipo,nombre)
{
	var form = document.forms['frmDocumentos'];
	var idempresa = form.elements['ID_EMPRESA'].value;
	//11jun18	var iddocumento = oferta;
	var enctype = 'application/x-www-form-urlencoded';

	//si usuario confirma
	if(confirm(document.forms['MensajeJS'].elements['SEGURO_ELIMINAR_OFERTA'].value)){
		form.encoding = enctype;

		jQuery.ajax({
			url:"confirmEliminaOferta.xsql",
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
				
				//15set21 location.reload();
				RecuperaDocumentosAjax();		
			}
		});
	}//fin if
}//fin EliminarDocumento


// Actualiza la fecha de la oferta (solo usuarios MVM o MVMB)
function ActualizarFechaOferta(IDOferta, IDEmpresa, tipo, nombre)
{
	//solodebug
	console.log('ActualizarFechaOferta ID:'+IDOferta+' tipo:'+tipo+' nombre:'+ nombre);


	var form	= document.forms['frmDocumentos'];
	//var IDEmpresa	= form.elements['ID_EMPRESA'].value;
	var fecha	= form.elements['fecha_'+IDOferta].value;
	var fechaFinal	= form.elements['fechaFinal_'+IDOferta].value;
	//var IDDoc	= IDOferta;
	var enctype = 'application/x-www-form-urlencoded';

	//solodebug
	console.log('ActualizarFechaOferta ID:'+IDOferta+' tipo:'+tipo+' nombre:'+ nombre);

	//si usuario confirma
	if(confirm(document.forms['MensajeJS'].elements['SEGURO_MODIFICAR_FECHA'].value)){
		form.encoding = enctype;

		jQuery.ajax({
			url:"http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/confirmModFechaOferta.xsql",
 			data:"ID_EMPRESA="+IDEmpresa+"&ID_DOCUMENTO="+IDOferta+"&MOD_FECHA="+fecha+"&MOD_FECHA_FINAL="+fechaFinal,
			type: "GET",
			contentType: "application/xhtml+xml",
			beforeSend:function(){
				/*document.getElementById('confirmBoxModificaFecha_'+nombre).style.display = 'block';
				document.getElementById('waitBoxOferta_'+nombre).style.display = 'block';
				document.getElementById('waitBoxOferta_'+nombre).src = 'http://www.newco.dev.br/images/loading.gif';*/
				jQuery('#fecha_'+IDOferta).hide();
				jQuery('#fechaFinal_'+IDOferta).hide();
			},
			error:function(objeto, quepaso, otroobj){
				alert("objeto:"+objeto);
				alert("otroobj:"+otroobj);
				alert("quepaso:"+quepaso);
			},
			success:function(data){
				/*var doc=eval("(" + data + ")");

				document.getElementById('waitBoxOferta_'+nombre).style.display = 'none';
				document.getElementById('confirmBoxModificaFecha_'+nombre).style.display = 'block';*/
				jQuery('#fecha_'+IDOferta).show();
				jQuery('#fechaFinal_'+IDOferta).show();
			}
		});
	}
}//fin ActualizarFechaOferta

//gestion comercial
function CambiarEmpresa(id)
{
	document.location.href = 'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalle.xsql?EMP_ID='+id+'&ESTADO=CABECERA';
}

//carga de un documento
var uploadFilesDoc = new Array();
var periodicTimerDoc = 0;
var form_tmp;
var MAX_WAIT_DOC = 1000;

function cargaDoc(form)
{

	console.log('cargaDoc. Inicio.');

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

	console.log('cargaDoc. hasFilesDoc');
	if(hasFilesDoc(form,tipo))
	{

		console.log('cargaDoc. hasFilesDoc ok. dentro.');

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

//Veo si hay un input file en el form, cargado con un documento
function hasFilesDoc(form){
	
	//soldebug
	console.log('hasFilesDoc.form:'+form.name);
	
	
	for(var i = 1; i < form.length; i++)
	{
		//solodebug
		if(form.elements[i].type == 'file')
		{
			console.log('hasFilesDoc. form.elements['+i+'].name:'+form.elements[i].name+' value:'+form.elements[i].value);
		}
	
		if(form.elements[i].type == 'file' && (form.elements[i].name == 'inputFileDoc') && form.elements[i].value != '' )
		{
			console.log('hasFilesDoc. return true.');
			return true;
		}
	}
	console.log('hasFilesDoc. return false.');
	return false;
}

//function que dice al usuario de esperar
function waitDoc(text)
{
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
  var action = 'http://' + location.hostname + '/' + lang + 'confirmCargaDocumentoEmpresa.xsql';
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
      url:"confirmCargaDocumentoEmpresa.xsql",
      data: "ID_PROVEEDOR="+prove+"&DOCUMENTOS_BORRADOS="+borrados+"&BORRAR_ANTERIORES="+borr_ante+"&TIPO_DOC="+tipoDoc+"&CADENA_DOCUMENTOS="+cadenaDoc,
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

		/*
        //vaciamos la carga documentos
        uploadFrameDoc.document.getElementsByTagName("p")[0].innerHTML = '';
        uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";

        //28jul21	document.location.reload(true);

        //resettamos los input file, mismo que removeDoc
        var clearedInput;
        var uploadElem = document.getElementById("inputFileDoc");

        uploadElem.value = '';
        clearedInput = uploadElem.cloneNode(false);

        uploadElem.parentNode.insertBefore(clearedInput, uploadElem);
        uploadElem.parentNode.removeChild(uploadElem);
        document.getElementById("docLine").removeChild(document.getElementById("inputDocLink"));
		
		*/
		
		RecuperaDocumentosAjax();		
		
        return;
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

    	//28jul21	var url = document.URL+'&ZONA=DOCS';
	    //28jul21			window.open(url,'_self');
			
		RecuperaDocumentosAjax();
    }
  });
}//fin de asociarDocumentoPadre

function verTablas70(id){
  var k = id+"Div";

  jQuery(".tablas70").hide();
  jQuery("#PestanasInicio .veinte").css("background","#E3E2E2");
  jQuery("#"+id).css("background","#C3D2E9");
  jQuery("#"+k).show();
}

function mostrarEIS(indicador, idempresa, idcentro, refPro, anno){
	var Enlace;

	Enlace='http://www.newco.dev.br/Gestion/EIS/EISDatos2.xsql?'
			+'IDCUADROMANDO='+indicador
			+'&'+'ANNO='+anno
			+'&'+'IDEMPRESA=-1'
			+'&'+'IDCENTRO='
			+'&'+'IDUSUARIO=-1'
			+'&'+'IDEMPRESA2='+idempresa
			+'&'+'IDCENTRO=-1'
			+'&'+'IDPRODUCTO=-1'
			+'&'+'IDGRUPOCAT=-1'
			+'&'+'IDSUBFAMILIA=-1'
			+'&'+'IDESTADO=-1'
			+'&'+'REFERENCIA='+refPro
			+'&'+'CODIGO='
			+'&'+'AGRUPARPOR=EMP2';

	MostrarPagPersonalizada(Enlace,'EIS',100,80,0,0);
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
		url:"confirmDocRevisadoAJAX.xsql",
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



//
//	Funciones para crear fichero CSV adaptadas desde lic_020120.js
//

//	quitamos ";" de las cadenas
function StringtoCSV(Cadena)
{
	var CadCSV=Cadena.replace('&amp;','&');
	CadCSV=CadCSV.replace(';','');

	//solodebug
	if (CadCSV!=Cadena) debug('StringtoCSV. ['+Cadena+'] -> ['+CadCSV+']');

	return (sepTextoCSV+CadCSV+sepTextoCSV+sepCSV);
}

function NumbertoCSV(Number) {return (sepTextoCSV+Number.toString()+sepTextoCSV+sepCSV);}


//	10ene20 Descargar excel
function DescargarExcel()
{
	var oForm=document.forms['frmDocumentos'], cadenaCSV='';

	console.log("DescargarExcel. v3. Datos contacto proveedores.");

	
	//	Preparamos la cabecera para la licitacion
	cadenaCSV=StringtoCSV(strEmpresa+':')+StringtoCSV(Empresa)+saltoLineaCSV+saltoLineaCSV;

	if (Rol=='VENDEDOR')
	{
		cadenaCSV+=StringtoCSV(strUsuario+':')+StringtoCSV(Usuario)+saltoLineaCSV;
		cadenaCSV+=StringtoCSV(strTelefono+':')+StringtoCSV(Telefono)+saltoLineaCSV;
		cadenaCSV+=StringtoCSV(strEmail+':')+StringtoCSV(Email)+saltoLineaCSV;
		cadenaCSV+=StringtoCSV(strProvincia+':')+StringtoCSV(Provincia)+saltoLineaCSV+saltoLineaCSV;
	}
	
	//cadenaCSV+='CONTADOR;NOMBRE;NOMBRETIPO;EMPRESA;NIF;CENTRO;NIF;FECHA;FECHACADUCIDAD;USUARIO_REVISION;FECHAREVISION'+saltoLineaCSV;
	cadenaCSV+=strCabeceraExcel+saltoLineaCSV;
	
	for (i=0; i<oForm.elements.length; i++)
	{
		//solodebug console.log("DescargarExcel. revisando "+oForm.elements[i].name.substring(0,6));
		if (oForm.elements[i].name.substring(0,6)=="EXCEL_")
		{
			//solodebug console.log("DescargarExcel. revisando "+oForm.elements[i].name.substring(0,6)+' OK');
			cadenaCSV+=oForm.elements[i].value+saltoLineaCSV;
		}
	}

	DescargaMIME(StringToISO(cadenaCSV), 'DocumentacionEmpresa.csv', 'text/csv');		//	http://www.newco.dev.br/General/descargas_151117.js
	
}



//	28jul21 Carga la lista actualizada de documentos
function RecuperaDocumentosAjax()
{
	console.log('RecuperaDocumentosAjax. Inicio.');

  jQuery.ajax({
    url:"EMPDocsAJAX.xsql",
    data: "IDFILTROEMPRESA="+jQuery("#IDFILTROEMPRESA").val(),
    type: "GET",
    async: false,
    contentType: "application/xhtml+xml",
    beforeSend:function(){
    },
    error:function(objeto, quepaso, otroobj){
      alert("objeto:"+objeto);
      alert("otroobj:"+otroobj);
      alert("quepaso:"+quepaso);
    },
    success:function(data){
		var arrCatJSON = JSON.parse(data);
		
		debug('RecuperaDocumentosAjax. data:'+data);
		
		/*
		for (var i=0;i<arrCatJSON.Categorias.length;++i)
		{
			var Categoria=[]
			Categoria['Nombre']=arrCatJSON.Categorias[i].Nombre;
			Categoria['Tipo']=arrCatJSON.Categorias[i].Tipo;
			Categoria['Documentos']=[];
			var arrDocumentos	= [];
			
			debug('RecuperaDocumentosAjax. Categoria('+i+'): ['+Categoria['Tipo']+']'+Categoria['Nombre']);
			
			for (var j=0;j<arrCatJSON.Categorias[i].Documentos.length;++j)
			{

				debug('RecuperaDocumentosAjax. Categoria('+i+'). Doc('+j+'):' +arrCatJSON.Categorias[i].Documentos[j].Nombre);

				var Doc= [];
				Doc=arrCatJSON.Categorias[i].Documentos[j];
				arrDocumentos.push(Doc);
				
				Categoria['NumDocs']=arrDocumentos.length;
				Categoria['Documentos']=arrDocumentos;
			}
			arrCategorias.push(Categoria);
		}
		*/
		
		arrCategorias=arrCatJSON.Categorias;		

		//	Redibuja las tablas tras cargar los datos de los documentos
		DibujaTablas();	  
    }
  });
	
}



//	Recorre el array de documentos, categorizado por categorias
function DibujaTablas()
{
	//debug('DibujaTablas. NumCategorias:'+arrCategorias.length);


	var cadHtml='';
	for (var i=0;i<arrCategorias.length;++i)
	{
		debug('DibujaTablas ('+i+'):'+arrCategorias[i].Nombre+' docs:'+arrCategorias[i].NumDocs+'='+arrCategorias[i].Documentos.length);
		if (arrCategorias[i].Documentos.length>0)
		{
			//for (var j=0;j<arrCategorias[i].Documentos.length;++j)
			//{
			//	debug('DibujaTablas ('+i+'):'+arrCategorias[i].Nombre+' doc('+j+'):'+arrCategorias[i].Documentos[j].Nombre);
			//}

			cadHtml+=DibujaTabla(arrCategorias[i]);
		}
	}
	
	
	//alert('DibujaTablas');

	jQuery('#divTablasDocs').html('');
	
	//alert(cadHtml);
	
	jQuery('#divTablasDocs').html(cadHtml);
}


function DibujaTabla(Categoria)
{
	debug('DibujaTabla. Categoria:'+Categoria.Nombre+':'+Categoria.Documentos.length);

	//	Quita el mensaje de "documento cargado"
	document.getElementById('confirmBoxDocEmpresa').style.display = 'none';

	if (Categoria.Documentos.length==0)
		return '';

	var strHiddenStatus='<input type="hidden" id="st_[ID]" value="[COLOR]"/>';

	var strHiddenExcelMVM='<input type="hidden" id="EXCEL_[ID]" name="EXCEL_[ID]" value="[CONTADOR];[NOMBRE];[NOMBRETIPO];[EMP_NIF];[EMPRESA];[CEN_NIF];[CENTRO];[FECHAALTA];[FECHACAD];[USUARIOREV];[FECHAREV];[FECHAULTPEDIDO];[FECHAULTLICITACION];[COMERCIAL_NOMBRE];[COMERCIAL_EMAIL];[COMERCIAL_TELEFONO];[COMERCIAL_PROVINCIA]"/> ';
	var strHiddenExcel='<input type="hidden" id="EXCEL_[ID]" name="EXCEL_[ID]" value="[CONTADOR];[NOMBRE];[NOMBRETIPO];[EMP_NIF];[EMPRESA];[CEN_NIF];[CENTRO];[FECHAALTA];[FECHACAD];[USUARIOREV];[FECHAREV];[FECHAULTPEDIDO];[FECHAULTLICITACION]"/> ';

	var strCabecera='<table class="buscador documentos"><input type="hidden" name="ID_EMPRESA" value="[IDEMPRESA]">'
					+'<tr class="sinLinea">'
					+'<th colspan="11">&nbsp;</th>'
					+'</tr>'
					+'<tr class="subTituloTabla">'
					+'<th colspan="11"><strong>[TITULO]</strong>'
					+'</th>'
					+'</tr>'
					+'<tr class="subTituloTabla">'
					+'<th class="uno">&nbsp;</th>'
					+'<th>'+strNombre+'</th>'
					+'<th>'+strCentro+'</th>'
					+'<th class="cerouno">&nbsp;</th>'
					+'<th>'+strUsuario+'</th>'
					+'<th style="width:200px;">'+strFecha+'</th>'
					+'<th style="width:240px;">'+strVencimiento+'</th>'
					+'<th>'+strUsuarioRev+'</th>'
					+'<th style="width:200px;">'+strFechaRev+'</th>'
					+'<th class="uno"></th>';
	
	if (v_BorrarOfertas=='S')
		strCabecera+='<th class="uno">'+strBorrar+'</th>';
		
	strCabecera+='</tr>';

	var strLineaDoc='<tr class="conhover"><td id="doc_[ID]" style="background:[COLOR]">[CONTADOR]</td><td class="textLeft">&nbsp;<strong><a href="http://www.newco.dev.br/Documentos/[URL]">[NOMBRE]</a></strong></td>'
    	+'<td class="textLeft"><a href="javascript:DocsEmpresa([IDEMPRESA]);">[CENTROOEMPRESA]</a></td><td></td><td align="left">[USUARIO]</td><td align="left"><input type="text" name="fecha_[ID]" value="[FECHAALTA]" maxlength="10" size="10" class="medio" id="fecha_[ID]">'
		+'<img src="http://www.newco.dev.br/images/actualizarFlecha.gif" alt="Actualizar Fecha" onclick="javascript:ActualizarFechaOferta(\'[ID]\',\'[IDEMPRESA]\',\'[TIPO]\',\'\');">'
    	+'</td><td align="left"><input type="text" name="fechaFinal_[ID]" value="[FECHACAD]" maxlength="10" size="10" class="medio" id="fechaFinal_[ID]">'
		+'<img src="http://www.newco.dev.br/images/actualizarFlecha.gif" alt="Actualizar Fecha final" onclick="javascript:ActualizarFechaOferta(\'[ID]\',\'[IDEMPRESA]\',\'[TIPO]\',\'\');">'
		+'&nbsp;[CADUCADO]</td><td align="left">[USUARIOREV]</td><td>[FECHAREV]</td><td><a id="btnEstado_[ID]" class="btnDestacado" href="javascript:revisarDocumento([ID]);">Rev.</a>'
    	+'<div id="waitBoxEst_[ID]" class="gris" style="display:none; margin-top:5px;">'+strCargando+'...&nbsp;</div>'
    	+'</td>';
		
	if (v_BorrarOfertas=='S')	
		strLineaDoc+='<td><a href="javascript:EliminarDocumento(\'[ID]\',\'[TIPO]\',\'\');"><img src="http://www.newco.dev.br/images/2017/trash.png" alt="eliminar"></a><div id="waitBoxOferta_[ID]" class="gris" style="display:none; margin-top:5px;">'+strCargando+'...&nbsp;</div></td>';
	
	strLineaDoc+='</tr>';
	
	var strLineaVacia='<tr class="conhover"><td style="background:[COLOR]">[CONTADOR]</td><td class="textLeft">[NOMBRETIPO]. '+strDocNoInformado+'</td><td colspan="6">&nbsp;</td></tr>';

	

	//debug('DibujaTabla. strLineaDoc:'+strLineaDoc);


	if (v_AdminMVM=='S')
		strExcel=strHiddenExcelMVM;
	else
		strExcel=strHiddenExcel;
		
	var cadHtml=strCabecera.replace(/\[IDEMPRESA\]/g,IDEmpresa).replace(/\[TITULO\]/g,Categoria.Nombre);

	//debug('DibujaTabla:'+Categoria.Documentos.length);
	for (var i=0;i<Categoria.Documentos.length;++i)
	{
		var color, Caducado='';

		//	Color para indicar estado de revision del documento
		if (Categoria.Documentos[i].Color=='VERDE')
			color='#4E9A06';
		else if (Categoria.Documentos[i].Color=='NARANJA')
			color='#F57900';
		else
			color='#CC0000';

		//	Marca de documento caducado
		if (Categoria.Documentos[i].Caducado=='S')
			Caducado='<img src="http://www.newco.dev.br/images/2017/warning-red.png"/>';


		//debug('DibujaTabla('+i+'):'+Categoria.Documentos[i].Nombre+'. Tipo:'+Categoria.Documentos[i].Tipo+'. Url:'+Categoria.Documentos[i].Url+'. Centro:'+Categoria.Documentos[i].Centro+' Color:'+color);

		//	Documento no informado
		if (Categoria.Documentos[i].ID=='')
			linea=strLineaVacia;
		else
			linea=strHiddenStatus+strExcel+strLineaDoc;

		//debug('DibujaTabla('+i+'). Linea original:'+linea);

		linea=linea.replace(/\[ID\]/g,Categoria.Documentos[i].ID).replace(/\[CONTADOR\]/g,Categoria.Documentos[i].Cont).replace(/\[URL\]/g,Categoria.Documentos[i].Url).replace(/\[NOMBRE\]/g,Categoria.Documentos[i].Nombre);
		linea=linea.replace(/\[IDEMPRESA\]/g,Categoria.Documentos[i].IDEmpresa).replace(/\[CENTROOEMPRESA\]/g,Categoria.Documentos[i].CentroOEmpresa).replace(/\[USUARIO\]/g,Categoria.Documentos[i].Usuario);
		linea=linea.replace(/\[FECHAALTA\]/g,Categoria.Documentos[i].FechaAlta).replace(/\[FECHACAD\]/g,Categoria.Documentos[i].FechaCad).replace(/\[TIPO\]/g,Categoria.Documentos[i].Tipo);
		linea=linea.replace(/\[CADUCADO\]/g,Caducado).replace(/\[COLOR\]/g,color);
		//	Campos correspondientes al excel
		linea=linea.replace(/\[EMP_NIF\]/g,Categoria.Documentos[i].NifEmpresa).replace(/\[EMPRESA\]/g,Categoria.Documentos[i].Empresa).replace(/\[CEN_NIF\]/g,Categoria.Documentos[i].NifCentro).replace(/\[CENTRO\]/g,Categoria.Documentos[i].Centro);
		linea=linea.replace(/\[NOMBRETIPO\]/g,Categoria.Documentos[i].NombreTipo).replace(/\[USUARIOREV\]/g,Categoria.Documentos[i].UsuarioRev).replace(/\[FECHAREV\]/g,Categoria.Documentos[i].FechaRev).replace(/\[FECHAULTPEDIDO\]/g,Categoria.Documentos[i].FechaUltPed);
		linea=linea.replace(/\[FECHAULTLICITACION\]/g,Categoria.Documentos[i].FechaUltLic).replace(/\[COMERCIAL_NOMBRE\]/g,Categoria.Documentos[i].Comercial_Nombre).replace(/\[COMERCIAL_EMAIL\]/g,Categoria.Documentos[i].Comercial_Mail);
		linea=linea.replace(/\[COMERCIAL_TELEFONO\]/g,Categoria.Documentos[i].Comercial_Telf).replace(/\[COMERCIAL_PROVINCIA\]/g,Categoria.Documentos[i].Comercial_Prov);

		//debug('DibujaTabla('+i+'). Linea revisada:'+linea);

		cadHtml+=linea;
	}
	
	return cadHtml;
}

















