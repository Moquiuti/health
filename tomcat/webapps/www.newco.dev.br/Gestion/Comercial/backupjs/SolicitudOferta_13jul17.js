//	Ultima revisión: 20may14
var uploadFilesDoc = new Array();
var periodicTimerDoc = 0;
var form_tmp;
var MAX_WAIT_DOC = 1000;

jQuery(document).ready(globalEvents);

function globalEvents(){
  // Codigo javascript para mostrar/ocultar tablas cuando se clica en la pestanya 'Alta Producto'
	jQuery("#pes_lAltaProducto").click(function(){
    if(lang == 'spanish'){
      jQuery("#pes_lAltaProducto > img").attr('src',"/images/botonAltaProducto1.gif");
      jQuery("#pes_lAltaFichero > img").attr('src',"/images/botonAltaFichero.gif");
    }else{
      jQuery("#pes_lAltaProducto > img").attr('src',"/images/botonAltaProducto1-BR.gif");
      jQuery("#pes_lAltaFichero > img").attr('src',"/images/botonAltaFichero-BR.gif");
    }

    jQuery("#lAltaProducto").show();
    jQuery("#lAltaFichero").hide();
  });

  // Codigo javascript para mostrar/ocultar tablas cuando se clica en la pestanya 'Alta Fichero'
	jQuery("#pes_lAltaFichero").click(function(){
    if(lang == 'spanish'){
      jQuery("#pes_lAltaProducto > img").attr('src',"/images/botonAltaProducto.gif");
      jQuery("#pes_lAltaFichero > img").attr('src',"/images/botonAltaFichero1.gif");
    }else{
      jQuery("#pes_lAltaProducto > img").attr('src',"/images/botonAltaProducto-BR.gif");
      jQuery("#pes_lAltaFichero > img").attr('src',"/images/botonAltaFichero1-BR.gif");
    }

    jQuery("#lAltaProducto").hide();
    jQuery("#lAltaFichero").show();
  });
}

function abrirCatalogoPrivado(SolProdID, desc){
    MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoPrivadoProductoEmpresa.xsql?IDEMPRESA=1&ORIGEN=SOLICITUD&INPUT_SOL=PROD_ESTAN_' + SolProdID + '&DESCRIPCION=' + desc,'Catalogo privado producto',100,70,0,40);
}

function abrirCatalogoPoveedores(SolProdID, desc){
    MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/BuscarProveedoresEval.xsql?SOL_PROD_ID='+ SolProdID +'&DESCRIPCION='+ desc+'&ORIGEN=SOLICITUD', +'Catalogo proveedores',100,70,0,40);
}

function abrirFichaCatalogacion(SolProdID, cliente){
    var idProd = document.forms['SolicitudOferta'].elements['IDPROD_'+SolProdID].value
    MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducido.xsql?PRO_ID=' + idProd +"&EMP_ID=" + cliente + "&SOL_PROD_ID="+ SolProdID +"&ORIGEN=SOLICITUD", +'Ficha de catalogación',100,70,0,40);
}

//una vez que recuperamos del catalogo privado la ref estandar, buscamos el id prod estandar que guardamos en un campo hidden y desp retrasmitimos de nuevo el producto con anadirProducto añadiendole el id prod estandar
function recuperarIDProdEstandard(idEmpresa,solProdID){

    var ref = document.forms['SolicitudOferta'].elements['PROD_ESTAN_'+solProdID].value;

     jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/RecuperarIDProdEstandarAJAX.xsql',
		type:	"GET",
		data:	"REF="+ref+"&IDEMPRESA="+idEmpresa,
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.Resultado.Estado > 1){
                            //alert(data.Resultado.Estado);
                            document.forms['SolicitudOferta'].elements['IDPRODUCTO_'+solProdID].value = data.Resultado.Estado;
                            jQuery("#catalogar_"+solProdID).show();
                            //jQuery("#IDPRODUCTO_"+solProdID).html(data.Resultado.Estado);
                            anadirProductoConID(data.Resultado.Estado,solProdID)

                        }else{
				alert('Error');
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});

}


//añadimos el id prod estandar despues de haberlo recuperado de la ref estandar con recuperarIDProdEstandard
function anadirProductoConID(idProd, solProdID){
    var form = document.forms['SolicitudOferta'];

    var idSol = form.elements['IDSOL_'+solProdID].value;
    var prod = form.elements['PRODUCTO_'+solProdID].value;
    var idProdSol = form.elements['IDPRODSOL_'+solProdID].value;
    var refCli = form.elements['REFCLIENTE_'+solProdID].value;
    var refProv = form.elements['REFPROVEEDOR_'+solProdID].value;
    var prov = form.elements['PROVEEDOR_'+solProdID].value;
    var precio = form.elements['PRECIO_'+solProdID].value;
    var consumo = form.elements['CONSUMO_'+solProdID].value;

    if (idProd != ''){

    jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/AnadirProductosSolicitudOfertaAJAX.xsql',
		type:	"GET",
		data:	"IDPRODSOLICITUD="+idProdSol+"&IDSOLICITUD="+idSol+"&REFCLIENTE="+refCli+"&REFPROVEEDOR="+refProv+"&PRODUCTO="+prod+"&PROVEEDOR="+prov+"&PRECIO="+precio+"&CONSUMO="+consumo+"&IDPROD="+idProd+"&IDPRODESTANDAR=",
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.Resultado.Estado == 'OK'){
                            //alert(ref_guardada_con_exito);
                            jQuery("#REF_PROV_"+solProdID).css({"background":"#8AC007","border":"1px solid #D3D3D3"});
                            jQuery("#catalogar_"+solProdID).show();


                        }else{
				alert('Error');
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
    }
    else {
        form.elements['PRODUCTO'].focus();
	alert(producto_obligatorio);
    }
}

// para los textos que los enseñe bien
function RecuperaBienText(){

     if(jQuery("#SO_DESCRIPCION").length > 0)        jQuery("#SO_DESCRIPCION").html(jQuery("#SO_DESCRIPCION").text().replace(/<br>/gi,'\n'));

     if(jQuery("#SO_DIAGNOSTICO").length > 0)        jQuery("#SO_DIAGNOSTICO").html(jQuery("#SO_DIAGNOSTICO").text().replace(/<br>/gi,'\n'));
     if(jQuery("#DIAGNOSTICO_OLD").length > 0)        jQuery("#DIAGNOSTICO_OLD").html(jQuery("#DIAGNOSTICO_OLD").text().replace(/<br>/gi,'\n'));

     if(jQuery("#SO_SOLUCION").length > 0)        jQuery("#SO_SOLUCION").html(jQuery("#SO_SOLUCION").text().replace(/<br>/gi,'\n'));
     if(jQuery("#SOLUCION_OLD").length > 0)        jQuery("#SOLUCION_OLD").html(jQuery("#SOLUCION_OLD").text().replace(/<br>/gi,'\n'));

}

//cuando guardamos una nueva solicitud abrimos la página de solicitud despues para añadir mas productos
function abrirSolicitud(IDSol){
    window.open('SolicitudOferta.xsql?SO_ID='+IDSol,'_self',false);
}

//añadimos uno a uno los productos de la solicitud despues de haberla creada con un producto por defecto
function anadirProducto(form){

    var IDSol = form.elements['IDSOLICITUD'].value;
    var prod = form.elements['PRODUCTO'].value;
    var refCli = form.elements['REFCLIENTE'].value;
    var refProv = form.elements['REFPROVEEDOR'].value;
    var prov = form.elements['PROVEEDOR'].value;
    var precio = form.elements['PRECIO'].value;
    var cantidad = form.elements['CANTIDAD'].value;

		// Escondemos el botón de enviar
		jQuery('#BotonSubmit').hide();

		// Validaciones
		if(prod === ''){
			form.elements['PRODUCTO'].focus();
			alert(producto_obligatorio);
			jQuery('#BotonSubmit').show();
			return;
		}

		if(precio !== ''){
			var precioFmt = precio.replace(',', '.');
			if(isNaN(precioFmt)){
			 form.elements['PRECIO'].focus();
			 alert(precio_mal_formato);
			 jQuery('#BotonSubmit').show();
			 return;
			}else{
				form.elements['PRECIO'].value = precioFmt.replace('.', ',');
				precio = precioFmt.replace('.', ',');
			}
		}

		if(cantidad !== ''){
      if(isNaN(cantidad) || (cantidad % 1 !== 0)){
        form.elements['CANTIDAD'].focus();
  			alert(cantidad_mal_formato);
  			jQuery('#BotonSubmit').show();
  			return;
      }
    }

    jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/AnadirProductosSolicitudOfertaAJAX.xsql',
		type:	"GET",
		data:	"IDSOLICITUD="+IDSol+"&REFCLIENTE="+refCli+"&REFPROVEEDOR="+refProv+"&PRODUCTO="+prod+"&PROVEEDOR="+prov+"&PRECIO="+precio+"&CANTIDAD="+cantidad+"&IDPRODESTANDAR=",
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.Resultado.Estado == 'OK'){
                            form.elements['PRODUCTO'].value = '';
                            form.elements['REFCLIENTE'].value = '';
                            form.elements['REFPROVEEDOR'].value = '';
                            form.elements['PROVEEDOR'].value = '';
                            form.elements['PRECIO'].value = '';
                            form.elements['CANTIDAD'].value = '';
                            location.reload();

                        }else{
				alert('Error ');
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});



}

function BuscarSolicitudesCatalogacion(oForm){
	SubmitForm(oForm);
}

// Abre la página para crear una nueva solicitud de catalogación
function NuevaSolicitudOferta(){
	window.open('NuevaSolicitudOferta.xsql','_self',false);
}

// Función que valida los campos de los formularios antes de hacer el submit
function ValidarFormulario(oForm,IDEstado){


	console.log('ValidarFormulario IDEstado:'+IDEstado);
	alert('ValidarFormulario IDEstado:'+IDEstado);

	if(IDEstado == 'NUEVA'){
		// Escondemos el botón de enviar
		jQuery('#BotonSubmit').hide();

		if(oForm.elements['SO_TITULO'] && oForm.elements['SO_TITULO'].value === ''){
			oForm.elements['SO_TITULO'].focus();
			alert(titulo_obligatorio);
			jQuery('#BotonSubmit').show();
			return;
		}

/*
		if(oForm.elements['SO_DESCRIPCION'] && oForm.elements['SO_DESCRIPCION'].value === ''){
			oForm.elements['SO_DESCRIPCION'].focus();
			alert(descripcion_obligatoria);
			jQuery('#BotonSubmit').show();
			return;
		}*/

    if(oForm.elements['SO_PRODUCTO'] && oForm.elements['SO_PRODUCTO'].value === ''){
			oForm.elements['SO_PRODUCTO'].focus();
			alert(producto_obligatorio);
			jQuery('#BotonSubmit').show();
			return;
		}

		if(oForm.elements['SO_PRECIO'] && oForm.elements['SO_PRECIO'].value !== ''){
      var precio = oForm.elements['SO_PRECIO'].value.replace(',', '.');
      if(isNaN(precio)){
			 oForm.elements['SO_PRECIO'].focus();
			 alert(precio_mal_formato);
			 jQuery('#BotonSubmit').show();
			 return;
      }else{
        oForm.elements['SO_PRECIO'].value = precio.replace('.', ',');
      }
		}

    if(oForm.elements['SO_CANTIDAD'] && oForm.elements['SO_CANTIDAD'].value !== ''){
      if(isNaN(oForm.elements['SO_CANTIDAD'].value) || (oForm.elements['SO_CANTIDAD'].value % 1 !== 0)){
        oForm.elements['SO_CANTIDAD'].focus();
  			alert(cantidad_mal_formato);
  			jQuery('#BotonSubmit').show();
  			return;
      }
    }
		// Si no hay errores se envia el formulario
		oForm.encoding	= 'application/x-www-form-urlencoded';
		oForm.target	= '_self';
		AsignarAccion(oForm,'http://www.newco.dev.br/Gestion/Comercial/NuevaSolicitudOfertaSave.xsql')
		SubmitForm(oForm);
		return;
	}else if(IDEstado == 'D'){	// DIAGNOSTICO
		// Escondemos el botón de enviar
		jQuery('#BotonDIAG').hide();

		if(oForm.elements['SO_DIAGNOSTICO'] && oForm.elements['SO_DIAGNOSTICO'].value == ''){
			oForm.elements['SO_DIAGNOSTICO'].focus();
			alert(diagnostico_obligatorio);
			jQuery('#BotonDIAG').show();
			return;
		}

		// Si no hay errores se envia el formulario
		oForm.elements['SO_IDESTADO'].value = IDEstado;
		oForm.encoding	= 'application/x-www-form-urlencoded';
		oForm.target	= '_self';
		AsignarAccion(oForm,'http://www.newco.dev.br/Gestion/Comercial/SolicitudOfertaSave.xsql')
		SubmitForm(oForm);
		return;
	}else if(IDEstado == 'S'){	// PROPUESTA SOLUCION
		// Escondemos el botón de enviar
		jQuery('#BotonSOL').hide();

		if(oForm.elements['SO_SOLUCION'] && oForm.elements['SO_SOLUCION'].value == ''){
			oForm.elements['SO_SOLUCION'].focus();
			alert(solucion_obligatoria);
			jQuery('#BotonSOL').show();
			return;
		}

		// Si no hay errores se envia el formulario
		oForm.elements['SO_IDESTADO'].value = IDEstado;
		oForm.encoding	= 'application/x-www-form-urlencoded';
		oForm.target	= '_self';
		AsignarAccion(oForm,'http://www.newco.dev.br/Gestion/Comercial/SolicitudOfertaSave.xsql')
		SubmitForm(oForm);
		return;
	}else if(IDEstado == 'R'){	// RESUELTA
		// Escondemos el botón de enviar
		jQuery('#BotonRES').hide();

		if(oForm.elements['SO_SOLUCION'] && oForm.elements['SO_SOLUCION'].value == ''){
			oForm.elements['SO_SOLUCION'].focus();
			alert(solucion_obligatoria);
			jQuery('#BotonRES').show();
			return;
		}

		// Si no hay errores se envia el formulario
		oForm.elements['SO_IDESTADO'].value = IDEstado;
		oForm.encoding	= 'application/x-www-form-urlencoded';
		oForm.target	= '_self';
		AsignarAccion(oForm,'http://www.newco.dev.br/Gestion/Comercial/SolicitudOfertaSave.xsql')
		SubmitForm(oForm);
		return;
	}
}

function Reset(form){
    form.elements['FIDEMPRESA'].value = '-1';
    form.elements['FIDCENTRO'].value = '-1';
    form.elements['FIDRESPONSABLE'].value = '-1';
    form.elements['FESTADO'].value = '-1';
    form.elements['FTEXTO'].value = '';
}

//Enseñar el input file para subir documentos
function verCargaDoc(tipo){
	if(document.getElementById('carga'+tipo).style.display == 'none'){
		jQuery(".cargas").hide();
		jQuery("#carga"+tipo).show();

		document.forms['SolicitudOferta'].elements['TIPO_DOC_DB'].value	= 'SOLCAT';
		document.forms['SolicitudOferta'].elements['TIPO_DOC_HTML'].value	= tipo;
	}else{
		jQuery("#carga"+tipo).hide();
	}
}

//cargar documentos
function cargaDoc(form, tipo){
	var msg = '';

	if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("body")[0]){
		uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";
	}

	if(msg != ''){
		alert(msg);
	}else{
		if(hasFilesDoc(form)){
			var target = 'uploadFrameDoc';
			var action = 'http://' + location.hostname + '/cgi-bin/uploadDocsMVM.pl';
			var enctype = 'multipart/form-data';

			form.target = target;
			form.encoding = enctype;
			form.action = action;
			waitDoc(tipo);
			form_tmp = form;
			man_tmp = true;
			periodicTimerDoc = 0;
			periodicUpdateDoc();
			form.submit();
		}
	}//fin else
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
function waitDoc(tipo){
	jQuery('#waitBoxDoc'+tipo).html ('<img src="http://www.newco.dev.br/images/loading.gif" />');
	jQuery('#waitBoxDoc'+tipo).show();
	return false;
}

/**
 * Check periodically if the image upload is finished
 * @return Boolean - true if filled file input found
 */
function periodicUpdateDoc(){
	if(periodicTimerDoc >= MAX_WAIT_DOC){
		alert(document.forms['mensajeJS'].elements['HEMOS_ESPERADO'].value + MAX_WAIT_DOC + document.forms['mensajeJS'].elements['LA_CARGA_NO_TERMINO'].value);
		return false;
	}
	periodicTimerDoc++;

	if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("p")[0]){
		var tipoDocHTML	= document.forms['SolicitudOferta'].elements['TIPO_DOC_HTML'].value;

		var uFrame	= uploadFrameDoc.document.getElementsByTagName("p")[0];

		document.getElementById('waitBoxDoc'+tipoDocHTML).style.display = 'none';

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

/**
 * handle Request after file (or image) upload
 * @param {Array} resp Hopefully JSON string array
 * @return Boolean
 */
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

//	var action = 'http://' + location.hostname + '/' + lang + 'confirmCargaDocumento.xsql';

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
				var cadenaDoc	= document.getElementsByName('CADENA_DOCUMENTOS')[0].value;
			}
		}
	}

	var usuario	= document.forms['SolicitudOferta'].elements['ID_USUARIO'].value;
	var borrados	= document.forms['SolicitudOferta'].elements['DOCUMENTOS_BORRADOS'].value;
	var borr_ante	= document.forms['SolicitudOferta'].elements['BORRAR_ANTERIORES'].value;
	var tipoDocDB	= document.forms['SolicitudOferta'].elements['TIPO_DOC_DB'].value;
	var tipoDocHTML	= document.forms['SolicitudOferta'].elements['TIPO_DOC_HTML'].value;
	// En este caso usamos el IDEmpresa del cliente como parámetro de entrada para IDPROVEEDOR
	var IDEmpresa	= '';
	if(document.forms['SolicitudOferta'].elements['IDEMPRESA'].value != ''){
		IDEmpresa	= document.forms['SolicitudOferta'].elements['IDEMPRESA'].value;
	}

	if(msg != ''){
		alert(msg);
		return false;
	}else{

//		form.encoding	= enctype;
//		form.action	= action;
//		form.target	= target;
		var d = new Date();

		jQuery.ajax({
			url:"http://www.newco.dev.br/Administracion/Mantenimiento/Productos/confirmCargaDocumento.xsql",
			data: "ID_USUARIO="+usuario+"&ID_PROVEEDOR="+IDEmpresa+"&DOCUMENTOS_BORRADOS="+borrados+"&BORRAR_ANTERIORES="+borr_ante+"&TIPO_DOC="+tipoDocDB+"&CADENA_DOCUMENTOS="+cadenaDoc+"&_="+d.getTime(),
			type: "GET",
			async: false,
			contentType: "application/xhtml+xml",
			beforeSend:function(){
				document.getElementById('waitBoxDoc'+tipoDocHTML).src = 'http://www.newco.dev.br/images/loading.gif';
			},
			error:function(objeto, quepaso, otroobj){
				alert("objeto:"+objeto);
				alert("otroobj:"+otroobj);
				alert("quepaso:"+quepaso);
			},
			success:function(data){
				var doc=eval("(" + data + ")");

				//reinicializo los campos del form
				document.forms['SolicitudOferta'].elements['inputFileDoc'].value = '';

				if(document.forms['SolicitudOferta'].elements['MAN_PRO'] && document.forms['SolicitudOferta'].elements['MAN_PRO'].value != 'si'){
					if (document.forms['SolicitudOferta'].elements['US_MVM'] && document.forms['SolicitudOferta'].elements['US_MVM'].value == 'si'){
						document.forms['SolicitudOferta'].elements['IDPROVEEDOR'].value = '-1';
					}
				}

				var tipo = document.forms['SolicitudOferta'].elements['TIPO_DOC_HTML'].value;

				//vaciamos la carga documentos
				document.forms['SolicitudOferta'].elements['inputFileDoc'+tipo] = '';
				jQuery("#carga"+tipo).hide();

				uploadFrameDoc.document.getElementsByTagName("p")[0].innerHTML = '';
				uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";

//				var proveedor = document.forms['SolicitudOferta'].elements['IDPROVEEDOR'].value;

				//Informamos del IDDOC en el input hidden que toca y avisamos al usuario
				var IDDoc = doc[0].id_doc;
				jQuery('#DOC_'+tipo).val(IDDoc);
				//Creamos el link para acceder al archivo, link para borrarlo y ocultamos link para subir documento
				var nombreDoc	= doc[0].nombre;
				var fileDoc	= doc[0].file;
				jQuery('#docBox'+tipo).empty().append('<a href="http://' + location.hostname + '/Documentos/' + fileDoc + '" target="_blank">' + nombreDoc + '</a>').show();
				jQuery('#borraDoc'+tipo).append('<a href="javascript:borrarDoc(' + IDDoc + ',\'' + tipo + '\')"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>').show();
				jQuery('#newDoc'+tipo).hide();

				//reseteamos los input file, mismo que removeDoc
				var clearedInput;
				var uploadElem = document.getElementById("inputFileDoc_" + tipo);

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
				jQuery("#DOC_"+tipo).val("");
				jQuery("#borraDoc"+tipo).empty().hide();
				jQuery("#docBox"+tipo).empty().hide();
				jQuery("#newDoc"+tipo).show();
                        }else{
				alert('Error: ' + data.BorrarDocumento.message);
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}

function BorrarSolicitudOferta(IDSol){
	var d	= new Date();

	jQuery.ajax({
		url: 'http://www.newco.dev.br/Gestion/Comercial/BorrarSolicitudOferta.xsql',
		data: "SO_ID="+IDSol+"&amp;_="+d.getTime(),
		type: "GET",
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			jQuery("#SolicitudBorradaOK").hide();
			jQuery("#SolicitudBorradaKO").hide();
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.estado == 'OK'){
				var IDSolicitud = data.id;

				jQuery("#SolicitudBorradaOK").show();
				jQuery("#SOLIC_" + IDSolicitud).hide();
			}else
				jQuery("#SolicitudBorradaKO").show();
			}
		});
}


function anadirFilasProductos(oForm){
	var d;
	text = oForm.elements['TXT_PRODUCTOS'].value;

	// Escondemos el botón de enviar
	jQuery('#BotonSubmit2').hide();

	if(text == ''){
		oForm.elements['TXT_PRODUCTOS'].focus();
		alert(filas_productos_obligatorio);
		jQuery('#BotonSubmit2').show();
		return;
	}

	var arrRows = text.split(/\n/);
	var arrRwLenght = arrRows.length;
	var arrProd, res = true, errores = 0;

	jQuery.each(arrRows, function(index, row){
		if(row === '')	return;

		row	= row.replace(/[\t:]/g, ':');	// 	Separadores admitidos para separar campos: tab y ":"
		
		arrProd = row.split(":");

		res = validarLineaProducto(arrProd);
		if(!res){
			errores++;
			return;
		}

		// Volcamos las posiciones del array en los datos que vamos a tratar/validar
		var nombreProd, refCliente, refProv, nombreProv, precio, cantidad;
		nombreProd  = ("0" in arrProd) ? arrProd[0] : '';
		refCliente  = ("1" in arrProd) ? arrProd[1] : '';
		refProv     = ("2" in arrProd) ? arrProd[2] : '';
		nombreProv  = ("3" in arrProd) ? arrProd[3] : '';
		precio      = ("4" in arrProd) ? arrProd[4].replace('.', ',') : '';
		cantidad    = ("5" in arrProd) ? arrProd[5] : '';

		// Peticion ajax para incorporar el producto a la tabla
		d	= new Date();
		jQuery.ajax({
				url: 'http://www.newco.dev.br/Gestion/Comercial/AnadirProductosSolicitudAJAX.xsql',
				data:	"IDSOLICITUD="+IDRegistro+"&REFCLIENTE="+refCliente+"&REFPROVEEDOR="+refProv+"&PRODUCTO="+nombreProd+"&PROVEEDOR="+nombreProv+"&PRECIO="+precio+"&CANTIDAD="+cantidad+"&_="+d.getTime(),
				type: "GET",
				async: false,
				contentType: "application/xhtml+xml",
				beforeSend: function(){
					null;
				},
				error: function(objeto, quepaso, otroobj){
					alert('error'+quepaso+' '+otroobj+''+objeto);
				},
				success: function(objeto){
					var data = eval("(" + objeto + ")");

					// ACCIONES
					if(data.Resultado.Estado == 'OK'){
							if(index == arrRwLenght-1)
									oForm.elements['TXT_PRODUCTOS'].value = oForm.elements['TXT_PRODUCTOS'].value.replace(arrRows[index], '');
							else
									oForm.elements['TXT_PRODUCTOS'].value = oForm.elements['TXT_PRODUCTOS'].value.replace(arrRows[index]+'\n', '');
					}

				}
		});
  });

	recuperaProductos();

	if(errores)		alert(err_subir_productos);
	jQuery('#BotonSubmit2').show();
}

function validarLineaProducto(arr){
	// Volcamos las posiciones del array en los datos que vamos a tratar/validar
	var nombreProd  = ("0" in arr) ? arr[0] : '';
	var refCliente  = ("1" in arr) ? arr[1] : '';
	var refProv     = ("2" in arr) ? arr[2] : '';
	var nombreProv  = ("3" in arr) ? arr[3] : '';
	var precio      = ("4" in arr) ? arr[4] : '';
	var cantidad    = ("5" in arr) ? arr[5] : '';
	var res = true;

	if(nombreProd === null || nombreProd === '')										res = false;
	if(precio !== '' && isNaN(precio.replace(',', '.')))						res = false;
	if(cantidad !== '' && isNaN(cantidad) || (cantidad % 1 !== 0))	res = false;

	return res;
}

function recuperaProductos(){
	var innerHTML = '';
	var d	= new Date();

	jQuery.ajax({
			url: 'http://www.newco.dev.br/Gestion/Comercial/RecuperaProductosSolicitudAJAX.xsql',
			data:	"IDSOLICITUD="+IDRegistro+"&IDIDIOMA="+IDIdioma+"&_="+d.getTime(),
			type: "GET",
			async: false,
			contentType: "application/xhtml+xml",
			beforeSend: function(){
				null;
			},
			error: function(objeto, quepaso, otroobj){
				alert('error'+quepaso+' '+otroobj+''+objeto);
			},
			success: function(objeto){
				var data = eval("(" + objeto + ")");

				// ACCIONES
				if(data.ListaProductos.length){
						jQuery.each(data.ListaProductos, function(index, producto){
								innerHTML += '<tr style="border-bottom:1px solid #E3E2E2;">';
									innerHTML += '<td style="text-align:left;border-right:1px solid #E3E2E2;">' + producto.Producto + '</td>';
									innerHTML += '<td style="border-right:1px solid #E3E2E2;">' + producto.RefCliente + '</td>';
									innerHTML += '<td style="border-right:1px solid #E3E2E2;">' + producto.RefProveedor + '</td>';
									innerHTML += '<td class="textLeft" style="border-right:1px solid #E3E2E2;">' + producto.Proveedor + '</td>';
									innerHTML += '<td style="border-right:1px solid #E3E2E2;">' + producto.Precio + '</td>';
									innerHTML += '<td style="border-right:1px solid #E3E2E2;">' + producto.Consumo + '</td>';
								innerHTML += '</tr>';
						});
				}else{
					innerHTML += '<tr style="border-bottom:1px solid #E3E2E2;">';
						innerHTML += '<td colspan="6">' + str_sinProductos + '</td>';
					innerHTML += '</tr>';
				}

				jQuery('#listadoProductos tbody').empty().append(innerHTML);
			}
	});
}

function closeWindow(){
		opener.location.reload();
		window.close();
}

function cambiarEstado(IDEstado){
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/CambiarEstadoSolicitudOfertaAJAX.xsql',
		type:	"GET",
		data:	"IDSOLICITUD="+IDRegistro+"&IDESTADO="+IDEstado+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.estado == 'OK'){
				opener.location.reload();
				window.close();
			}else{
				alert('Error');
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}
