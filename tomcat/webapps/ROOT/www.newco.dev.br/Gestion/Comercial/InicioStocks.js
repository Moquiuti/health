var uploadFilesDoc = new Array();
var periodicTimerDoc = 0;
var form_tmp;
var MAX_WAIT_DOC = 1000;

jQuery.noConflict();

jQuery(document).ready(globalEvents);

function globalEvents(){
    
    
}

function FinalizarOferta(oForm,estado){
     oForm.elements.ESTADO.value = estado;
     AsignarAccion(oForm,'http://www.newco.dev.br/Gestion/Comercial/StockOfertaFinalizada.xsql');
     SubmitForm(oForm);
     return;
    
}

function verPedidoMinimo(){
    if (jQuery("input[type='radio'][name='SO_PEDIDOMINIMO_RADIO']:checked").val() == 'I' || jQuery("input[type='radio'][name='STOCK_PEDIDOMINIMO_RADIO']:checked").val() == 'I'){
        jQuery(".pedidoMinimoValue").show();
    }
    else jQuery(".pedidoMinimoValue").hide();
    
}

function checkTipo(user){
   
    //oferta nueva
    if (user == 'NORMAL'){
        if (jQuery("input[type='radio'][name='SO_TIPO_RADIO']:checked").val() == 'SEG'){
            jQuery(".noObliSeg").hide();
        }
        else jQuery(".noObliSeg").show();
    }
    else if (user == 'CDC'){
        //oferta ya creada    
        if (jQuery("input[type='radio'][name='STOCK_TIPO_RADIO']:checked").val() == 'SEG'){
            jQuery(".noObliSeg").hide();
        }
        else jQuery(".noObliSeg").show();
    }
}



function calculaCantidadRestante(){
    var oForm = document.forms['formPedido'];
    var cantInicial = parseInt(oForm.elements.CANTIDAD_STOCK.value);
    var cantPedida = parseInt(oForm.elements.CANTIDAD_PEDIDA.value);
    var cantRestante = cantInicial - cantPedida;
    
    jQuery("#cantidadRestante").append(cantRestante);
    
}

//funcion para enviar pedido
function ValidarFormularioPedido(oForm){
    oForm.target	= '_self';
    var msg = '';
    jQuery('#BotonPedido').hide();
    
    var tipo = oForm.elements['TIPO'].value;
    
    if (oForm.elements['CODIGO_PEDIDO'].value == ''){
         msg += codigo_pedido_obli+'\n';
    }
     if (oForm.elements['PEDIDO_CANTIDAD'].value == ''){
         msg += cantidad_pedido_obli+'\n';
    }
    
    //cantidad de stock restante
    var cantidad_stock = oForm.elements['CANTIDAD_STOCK'].value;
    var cant_stock = cantidad_stock.split(',');
    var can_stock_fin = cant_stock[0];
    
    //cantidad pedida
    var cantidad = oForm.elements['PEDIDO_CANTIDAD'].value;
    var cant = cantidad.split(',');
    var cant_pedida = cant[0];    
    var compra_minima = oForm.elements.COMPRA_MINIMA.value.replace('.','');
    //alert('cantidad stock '+can_stock_fin);
    //alert('can pedida '+cant_pedida);
    //alert('compra minima '+oForm.elements['COMPRA_MINIMA'].value);
    
    if (parseInt(cant_pedida) > parseInt(can_stock_fin)){
        msg += cantidad_pedido_menor+'\n';
    }
   // alert('cant pedida '+parseInt(cant_pedida));
   // alert('compra minima '+parseInt(compra_minima));
    
    if (tipo == 'LIQ' && parseInt(cant_pedida) < parseInt(compra_minima)){
        msg += cantidad_pedida_mayor_compra_minima+'\n';
    }
    //resto
    var resto = cant_pedida % oForm.elements['UDLOTE_STOCK'].value;
    //alert('resto '+resto);
    if (tipo == 'LIQ' && resto != ''){
        msg += cantidad_multiple_ud_lote+'\n';
    }
    
    //cantidad pedida debe superar pedido minimo, si hay pedido minimo
    if (tipo == 'LIQ' && oForm.elements.PEDIDOMINIMO.value != ''){
        var pedidoMinimo = oForm.elements.PEDIDOMINIMO.value;
        var precioUni = oForm.elements.PRECIO_UNI.value.replace(',','.');
        var totalComprado = parseFloat(precioUni) * parseInt(cantidad);

        if (parseInt(totalComprado) < parseInt(pedidoMinimo)){
            msg += cantidad_pedida_no_llega_pedido_minimo+'\n';
        }
    }
    
    if (msg == ''){
        AsignarAccion(oForm,'http://www.newco.dev.br/Gestion/Comercial/StockOfertaPedidoSave.xsql');
        SubmitForm(oForm);
        return;
    }
    else{ 
        alert(msg); 
        jQuery('#BotonPedido').show();
        }
}


// Función que valida los campos de los formularios antes de hacer el submit
function ValidarFormulario(oForm, IDEstado){
    
        var regex_numero	= new RegExp("^[0-9]+$","g"); // Expresion regular para controlar el campo ud lote que solo puede incluir n�meros, puntos o comas
        
	if(IDEstado == 'NUEVA'){
		// Escondemos el botón de enviar
		jQuery('#BotonSubmit').hide();
                
		if(oForm.elements.SO_TITULO && oForm.elements.SO_TITULO.value === ''){
			oForm.elements.SO_TITULO.focus();
			alert(titulo_obligatorio);
			jQuery('#BotonSubmit').show();
			return;
		}
                 //tipo liquidacion
                var tipo = jQuery("input[type='radio'][name='SO_TIPO_RADIO']:checked").val();
                //alert(tipo);
                if (oForm.elements.SO_TIPO_RADIO && tipo === ''){
			alert(tipo_liqui_obli);
			jQuery('#BotonSubmit').show();
			return;
		}
                oForm.elements['SO_TIPO'].value = tipo; 
                
                
		if(oForm.elements.SO_REFCLIENTE && oForm.elements.SO_REFCLIENTE.value === ''){
			oForm.elements.SO_REFCLIENTE.focus();
			alert(refprov_obligatorio);
			jQuery('#BotonSubmit').show();
			return;
		}

		if(oForm.elements.SO_PRODUCTO && oForm.elements.SO_PRODUCTO.value === ''){
			oForm.elements.SO_PRODUCTO.focus();
			alert(producto_obligatorio);
			jQuery('#BotonSubmit').show();
			return;
		}
                if(tipo == 'LIQ' && oForm.elements.SO_UDBASICA && oForm.elements.SO_UDBASICA.value === ''){
			oForm.elements.SO_UDBASICA.focus();
			alert(ud_basica_obli);
			jQuery('#BotonSubmit').show();
			return;
		}
                 if(tipo == 'LIQ' && oForm.elements.SO_UDLOTE && oForm.elements.SO_UDLOTE.value === ''){
			oForm.elements.SO_UDLOTE.focus();
			alert(ud_lote_obli);
			jQuery('#BotonSubmit').show();
			return;
		}
                var checkNum = checkRegEx(oForm.elements['SO_UDLOTE'].value, regex_numero);
                //alert(checkNum);
                if(tipo == 'LIQ' && checkNum == false){
                        alert(ud_lote_numerico);
                        jQuery('#BotonSubmit').show();
			return;
                }
		if(oForm.elements.SO_PRECIOUNITARIO && oForm.elements.SO_PRECIOUNITARIO.value === ''){
			oForm.elements.SO_PRECIOUNITARIO.focus();
			alert(precio_obligatorio);
			jQuery('#BotonSubmit').show();
			return;
		}else if(oForm.elements.SO_PRECIOUNITARIO){
			var precio = oForm.elements.SO_PRECIOUNITARIO.value.replace(',','.');

			if(!esNulo(precio) && isNaN(precio)){
				oForm.elements.SO_PRECIOUNITARIO.focus();
				alert(precio_error);
				jQuery('#BotonSubmit').show();
				return;
			}else{
				oForm.elements.SO_PRECIOUNITARIO.value = precio.replace('.',',');
			}
		}
                if(oForm.elements.SO_IVA && oForm.elements.SO_IVA.value === ''){
			oForm.elements.SO_IVA.focus();
			alert(iva_obli);
			jQuery('#BotonSubmit').show();
			return;
		}
                if(tipo == 'LIQ' && oForm.elements.SO_COMPRAMINIMA && oForm.elements.SO_COMPRAMINIMA.value === ''){
			oForm.elements.SO_COMPRAMINIMA.focus();
			alert(compra_minima_obli);
			jQuery('#BotonSubmit').show();
			return;
		}
		
                if(oForm.elements.SO_CANTIDAD && oForm.elements.SO_CANTIDAD.value === ''){
			oForm.elements.SO_CANTIDAD.focus();
			alert(cantidad_obligatorio);
			jQuery('#BotonSubmit').show();
			return;
		}else if(oForm.elements.SO_CANTIDAD){
			var cantidad = oForm.elements.SO_CANTIDAD.value;

			if(!(/^\+?[1-9]\d*$/.test(cantidad))){
				oForm.elements.SO_CANTIDAD.focus();
				alert(cantidad_error);
				jQuery('#BotonSubmit').show();
				return;
			}
		}
                
                var pedidoMinimo = jQuery("input[type='radio'][name='SO_PEDIDOMINIMO_RADIO']:checked").val();
                
                if (tipo == 'LIQ' && oForm.elements.SO_PEDIDOMINIMO_RADIO && pedidoMinimo === ''){
			alert(pedido_minimo_obli);
			jQuery('#BotonSubmit').show();
			return;
		}
                else if (tipo == 'LIQ' && pedidoMinimo == 'I' && oForm.elements['SO_PEDIDOMINIMO_VALUE'].value == ''){
                        oForm.elements.SO_PEDIDOMINIMO_VALUE.focus();
			alert(pedido_minimo_value_obli);
			jQuery('#BotonSubmit').show();
			return;         
                }
                //asigno el valor del pedido minimo al campo input hidden
                if (pedidoMinimo == 'I' && oForm.elements['SO_PEDIDOMINIMO_VALUE'].value != ''){
                    oForm.elements['SO_PEDIDOMINIMO'].value = oForm.elements['SO_PEDIDOMINIMO_VALUE'].value;
                }
                else{ oForm.elements['SO_PEDIDOMINIMO'].value = pedidoMinimo; }
               
                
                
                
		/*if(oForm.elements.SO_FECHACADUCIDAD && oForm.elements.SO_FECHACADUCIDAD.value === ''){
			oForm.elements.SO_FECHACADUCIDAD.focus();
			alert(fecha_obligatorio);
			jQuery('#BotonSubmit').show();
			return;
		}else*/
                if(oForm.elements.SO_FECHACADUCIDAD && CheckDate(oForm.elements.SO_FECHACADUCIDAD.value)){
			oForm.elements.SO_FECHACADUCIDAD.focus();
			alert(fecha_error);
			jQuery('#BotonSubmit').show();
			return;
		}
                if(oForm.elements.SO_FECHACADUCIDAD_PROD && CheckDate(oForm.elements.SO_FECHACADUCIDAD_PROD.value)){
			oForm.elements.SO_FECHACADUCIDAD_PROD.focus();
			alert(fecha_error);
			jQuery('#BotonSubmit').show();
			return;
		}

/*
		if(oForm.elements.SC_DESCRIPCION && oForm.elements.SC_DESCRIPCION.value === ''){
			oForm.elements.SC_DESCRIPCION.focus();
			alert(descripcion_obligatoria);
			jQuery('#BotonSubmit').show();
			return;
		}

		if(oForm.elements.SC_INFOPRECIO && oForm.elements.SC_INFOPRECIO.value === ''){
			oForm.elements.SC_INFOPRECIO.focus();
			alert(infoprecio_obligatoria);
			jQuery('#BotonSubmit').show();
			return;
		}
*/
		//si hay imagenes
			if(hasFiles(oForm)){
				var target = 'uploadFrame';
				var action = 'http://' + location.hostname + '/cgi-bin/imageMVM.pl';
				var enctype = 'multipart/form-data';
				oForm.target = target;
				oForm.encoding = enctype;
				oForm.action = action;
				wait("Please wait...");
				oForm.submit();
				form_tmp = oForm;
				man_tmp = true;
				periodicTimer = 0;
				periodicUpdate();
                            }
                            else{
                                // Si no hay errores se envia el formulario
                                oForm.target	= '_self';
                                oForm.method = 'post';
                                oForm.enctype = 'application/x-www-form-urlencoded';
                                AsignarAccion(oForm,'http://www.newco.dev.br/Gestion/Comercial/StockOfertaSave.xsql');
                                SubmitForm(oForm);
                                return;
                            }
                }
}

// Función que valida los campos de los formularios antes de hacer el submit
function ValidarFormularioCdC(oForm, IDEstado){
    
        //tipo liquidacion
        var tipo = jQuery("input[type='radio'][name='STOCK_TIPO_RADIO']:checked").val();
        
	if(IDEstado == 'OFERTA'){
		// Escondemos el botón de enviar
		jQuery('#BotonSubmitID').hide();

		if(oForm.elements.STOCK_REF_CLIENTE && oForm.elements.STOCK_REF_CLIENTE.value === ''){
			oForm.elements.STOCK_REF_CLIENTE.focus();
			alert(refcliente_obligatorio);
			jQuery('#BotonSubmitID').show();
			return;
		}

		if(oForm.elements.STOCK_PRODUCTO && oForm.elements.STOCK_PRODUCTO.value === ''){
			oForm.elements.STOCK_PRODUCTO.focus();
			alert(producto_obligatorio);
			jQuery('#BotonSubmitID').show();
			return;
		}
                
		if(oForm.elements.STOCK_PRECIO && oForm.elements.STOCK_PRECIO.value === ''){
			oForm.elements.STOCK_PRECIO.focus();
			alert(precio_obligatorio);
			jQuery('#BotonSubmitID').show();
			return;
		}else if(oForm.elements.STOCK_PRECIO){
                        var precio1 = oForm.elements.STOCK_PRECIO.value.replace('.','');
			var precio = precio1.replace(',','.');

			if(!esNulo(precio) && isNaN(precio)){
				oForm.elements.STOCK_PRECIO.focus();
				alert(precio_error);
				jQuery('#BotonSubmitID').show();
				return;
			}else{
				oForm.elements.STOCK_PRECIO.value = precio.replace('.',',');
			}
		}

		if(oForm.elements.STOCK_CANTIDAD && oForm.elements.STOCK_CANTIDAD.value === ''){
			oForm.elements.STOCK_CANTIDAD.focus();
			alert(cantidad_obligatorio);
			jQuery('#BotonSubmitID').show();
			return;
		}
                
                var pedidoMinimo = jQuery("input[type='radio'][name='STOCK_PEDIDOMINIMO_RADIO']:checked").val();
                
                if (tipo == 'LIQ' && pedidoMinimo == 'I' && oForm.elements['STOCK_PEDIDOMINIMO_VALUE'].value == ''){
                        oForm.elements.STOCK_PEDIDOMINIMO_VALUE.focus();
			alert(pedido_minimo_value_obli);
			jQuery('#BotonSubmit').show();
			return;         
                }
                //alert(pedidoMinimo);
                //asigno el valor del pedido minimo al campo input hidden
                if (tipo == 'LIQ' && pedidoMinimo == 'I' && oForm.elements['STOCK_PEDIDOMINIMO_VALUE'].value != ''){
                    oForm.elements['STOCK_PEDIDOMINIMO'].value = oForm.elements['STOCK_PEDIDOMINIMO_VALUE'].value;
                }
                else{ oForm.elements['STOCK_PEDIDOMINIMO'].value = pedidoMinimo; }
                
                if (tipo == 'SEG'){
                    oForm.elements['STOCK_PEDIDOMINIMO'].value = '0';
                }
                //alert(oForm.elements['STOCK_PEDIDOMINIMO'].value);
                
                //si hay imagenes
			if(hasFiles(oForm)){
				var target = 'uploadFrame';
				var action = 'http://' + location.hostname + '/cgi-bin/imageMVM.pl';
				var enctype = 'multipart/form-data';
				oForm.target = target;
				oForm.encoding = enctype;
				oForm.action = action;
				wait("Please wait...");
				oForm.submit();
				form_tmp = oForm;
				man_tmp = true;
				periodicTimer = 0;
				periodicUpdate();
                            }
                        // Si no hay errores se envia el formulario
                        oForm.target	= '_self';
                        oForm.method = 'post';
                        oForm.enctype = 'application/x-www-form-urlencoded';
                        AsignarAccion(oForm,'http://www.newco.dev.br/Gestion/Comercial/StockOfertaSave.xsql');
                        SubmitForm(oForm);
                        return;
		
	}
}
function BuscarStockOfertas(oForm){
	SubmitForm(oForm);
}

function NuevoStockOferta(){
	MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/StockOferta.xsql','Nueva oferta stock',100,100,0,0);
}

function BorrarOfertaStock(IDStockO){
	var d	= new Date();

	jQuery.ajax({
		url: 'http://www.newco.dev.br/Gestion/Comercial/StockOfertaBorrarAJAX.xsql',
		data: "SO_ID="+IDStockO+"&_="+d.getTime(),
		type: "GET",
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			jQuery("#StockOfertaBorradaOK").hide();
			jQuery("#StockOfertaBorradaKO").hide();
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.estado == 'OK'){
				jQuery("#StockOfertaBorradaOK").show();
				jQuery("#OFE_" + IDStockO).hide();
			}else
				jQuery("#StockOfertaBorradaKO").show();
			}
		});
}

//Ense�ar el input file para subir documentos
function verCargaDoc(tipo){
	if(document.getElementById('carga'+tipo).style.display == 'none'){
		jQuery(".cargas").hide();
		jQuery("#carga"+tipo).show();
                
                //el documento es una ficha tecnica
                if (document.forms['frmStockOferta']){
                    document.forms['frmStockOferta'].elements['TIPO_DOC_DB'].value	= 'FT';
                    document.forms['frmStockOferta'].elements['TIPO_DOC_HTML'].value = tipo;
                }
                if (document.forms['frmStockOfertaID']){
                    document.forms['frmStockOfertaID'].elements['TIPO_DOC_DB'].value	= 'FT';
                    document.forms['frmStockOfertaID'].elements['TIPO_DOC_HTML'].value = tipo;
                }
                
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
                if (document.forms['frmStockOferta']){
                    var tipoDocHTML	= document.forms['frmStockOferta'].elements['TIPO_DOC_HTML'].value;
                }
                if (document.forms['frmStockOfertaID']){
                    var tipoDocHTML	= document.forms['frmStockOfertaID'].elements['TIPO_DOC_HTML'].value;
                }

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
					/*en lugar del elemento nombre del form cojo el nombre del fichero diretamente, si hay espacios el sistema pone ghion bajo, entonces cuento cuantos ghiones son, divido al penultimo y a�ado la ultima palabra, si la ultima palabra esta vac�a implica que hay 2 ghiones bajos, entonces divido a los 2 ghiones bajos y cojo la primera parte.*/
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
        //PARA ENVIAR DOCUMENTO
        if (document.forms['frmStockOferta']){
            var usuario         = document.forms['frmStockOferta'].elements['ID_USUARIO'].value;
            var borrados	= document.forms['frmStockOferta'].elements['DOCUMENTOS_BORRADOS'].value;
            var borr_ante	= document.forms['frmStockOferta'].elements['BORRAR_ANTERIORES'].value;
            var tipoDocDB	= document.forms['frmStockOferta'].elements['TIPO_DOC_DB'].value;
            var tipoDocHTML	= document.forms['frmStockOferta'].elements['TIPO_DOC_HTML'].value;
            var IDEmpresa	= document.forms['frmStockOferta'].elements['ID_EMPRESA'].value;
        }
        if (document.forms['frmStockOfertaID']){
            var usuario         = document.forms['frmStockOfertaID'].elements['ID_USUARIO'].value;
            var borrados	= document.forms['frmStockOfertaID'].elements['DOCUMENTOS_BORRADOS'].value;
            var borr_ante	= document.forms['frmStockOfertaID'].elements['BORRAR_ANTERIORES'].value;
            var tipoDocDB	= document.forms['frmStockOfertaID'].elements['TIPO_DOC_DB'].value;
            var tipoDocHTML	= document.forms['frmStockOfertaID'].elements['TIPO_DOC_HTML'].value;
            var IDEmpresa	= document.forms['frmStockOfertaID'].elements['ID_EMPRESA'].value;
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

				//vaciamos la carga documentos
                                if (document.forms['frmStockOferta']){
                                    var tipo = document.forms['frmStockOferta'].elements['TIPO_DOC_HTML'].value;
                                    document.forms['frmStockOferta'].elements['inputFileDoc'+tipo] = '';
                                }
                                if (document.forms['frmStockOfertaID']){
                                    var tipo = document.forms['frmStockOfertaID'].elements['TIPO_DOC_HTML'].value;
                                    document.forms['frmStockOfertaID'].elements['inputFileDoc'+tipo] = '';
                                }
				jQuery("#carga"+tipo).hide();

				uploadFrameDoc.document.getElementsByTagName("p")[0].innerHTML = '';
				uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";


				//Informamos del ID documento guardado en el input hidden que toca y avisamos al usuario
				var IDDoc = doc[0].id_doc;
				jQuery('#DOC_'+tipo).val(IDDoc);
                                
				//Creamos el link para acceder al archivo, link para borrarlo y ocultamos link para subir documento
				var nombreDoc	= doc[0].nombre;
				var fileDoc	= doc[0].file;
				jQuery('#docBox'+tipo).empty().append('<a href="http://' + location.hostname + '/Documentos/' + fileDoc + '" target="_blank">' + nombreDoc + '</a>').show();
				jQuery('#borraDoc'+tipo).append('<a href="javascript:borrarDoc(' + IDDoc + ',\'' + tipo + '\')"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>').show();
				jQuery('#newDoc'+tipo).hide();
                                
			}
		});
	}
	return true;
}

function borrarDoc(IDDoc, tipo){
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


// IMAGE UPLOAD       ----------------------------------------------------------
var IMG_WIDTH = 200;
var IMG_HEIGHT = 200;
var IMG_SMALL_WIDTH = 50;
var IMG_SMALL_HEIGHT = 50;
var MAX_WAIT = 30;
var numImages = 0;
var uploadFiles = new Array();
var periodicTimer = 0;

/**
 * Add new Line with remove button
 * @param {string} id Suffix of the element id
 * @return Boolean
 * @author Martin Gangkofer gangkofer@gmail.com
 */
function hasFiles(form){
	for(var i=1; i<form.length; i++){
		if(form.elements[i].type == 'file' && (form.elements[i].name == 'inputFile') && form.elements[i].value != ''){
			return true;
		}
	}
	return false;
}

function addFile(id){

        var uploadElem = document.getElementById("inputFile_" + id);

	if(uploadElem.value != ''){
		uploadFiles[uploadFiles.length] = uploadElem.value;

		if (!document.getElementById("inputLink_" + id)){
			var rmLink = document.createElement('div');

			rmLink.setAttribute("class","remove");
			jQuery('Element').append(rmLink);
			rmLink.setAttribute('id', 'inputLink_' + id);
			rmLink.innerHTML = '<a href="javascript:removeFile(\'' + id + '\');">Remove</a>';
			document.getElementById("imageLine_" + id).appendChild(rmLink);
		}
	}else{
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
function removeFile(id){
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
 * Display new line for image
 * @return Boolean
 * @author Martin Gangkofer gangkofer@gmail.com
 */
function displayFiles(){
	for(var i=1; i<6; i++){
		if(document.getElementById("inputFile_" + i) && document.getElementById("inputFile_" + i).value != '' && document.getElementById("imageLine_" + (1+i))){
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
function periodicUpdate(){
	if(periodicTimer >= MAX_WAIT){
		alert("we waited " + MAX_WAIT + " seconds and the upload still did not finish, so we suspect sth. went wrong ;-)\n\nYou should press the stop button of your browser!\n");
		return false;
	}
	periodicTimer++;
        //a�adido un alert pk si no no coje el texto del fichero subido, imagen, solo para mvm.
        /*if (document.forms['frmStockOfertaID']){
            var oform = document.forms['frmStockOfertaID'];
            alert('Cargando...');
        }*/
       //alert('Cargando...'+periodicTimer);
      // alert('kokoko '+window.frames['uploadFrame'].document.getElementsByTagName("p")[0]);
       
	if(window.frames['uploadFrame'] && window.frames['uploadFrame'].document && window.frames['uploadFrame'].document.getElementsByTagName("p")[0]){
		document.getElementById('waitBox').style.display = 'none';
		var uFrame = window.frames['uploadFrame'].document.getElementsByTagName("p")[0];
                alert(uFrame);
		if(uFrame.innerHTML.substr(0, 1) != '{' && uFrame.innerHTML.substr(0, 1) != '['){
			alert("An undefined error occurred, please notify the admin");
			return false;
		}else{
                    //alert('mimimim');
			var response = eval('(' + uFrame.innerHTML + ')');
			handleFileRequest(response);
			return true;
		}
	}else{
            alert('mi else periodic');
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
function handleFileRequest(resp){
	var lang = new String('');
        
        if (document.forms['frmStockOfertaID']){
            var oform = document.forms['frmStockOfertaID'];
            //alert('Cargando...');
        }
        else if (document.forms['frmStockOferta']){
            var oform = document.forms['frmStockOferta'];
        }
	
	var msg = '';
	var msgHeader = 'Se ha producido errores en el upload de imagenes!<br /><br />'
	var target = '_self';
        //var target = '';
	var enctype = 'application/x-www-form-urlencoded';
	var imageChain = new String('');
	var action = 'PROMantenSave.xsql';
	var action = 'http://www.newco.dev.br/Gestion/Comercial/StockOfertaSave.xsql';

	if(resp instanceof Array && resp.length > 0){
		for(var i=0; i<resp.length; i++){
			if(resp[i].big && resp[i].small){
				var lungmax = resp[i].small.length;
				var lungmin = resp[i].small.length;
			}
		}
	}

	if(resp instanceof Array && resp.length > 0){
		for(i=0; i<resp.length; i++){
			if(resp[i].error && resp[i].error != ''){
				msg += resp[i].error;
			}else if(resp[i].big && resp[i].small){
				imageChain += 'mvm' + '|' + resp[i].small + '|' + resp[i].big + '#';
			}
		}

		if(msg == ''){
			document.getElementsByName('CADENA_IMAGENES')[0].value = imageChain;
                        //alert(imageChain);
                        //alert('nombre form' +oform.name);
                        oform.encoding = enctype;
			oform.action = action;
			oform.target = target;

			var accion = 'http://www.newco.dev.br/Gestion/Comercial/StockOfertaSave.xsql';
			AsignarAccion(oform,accion);

			SubmitForm(oform);
		}
	}else if(resp.length < 1){
		msg += "Parece que tus ficheros son demasiados grandes.<br />";
	}else{
		msg += "Se ha producido un error.<br />";
	}

	if(msg != ''){
		msg = msgHeader + msg;
		return false;
	}

	return true;
}

function wait(text) {
	//aparece el loading arriba en messageError
	jQuery('#waitBox').html ('<img src="http://www.newco.dev.br/images/loading.gif" />');
	if(jQuery('#ocultoButton'))	jQuery('#ocultoButton').hide();
	jQuery('#waitBox').show();
	return false;
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
        document.forms['frmStockOfertaID'].elements['CADENA_IMAGENES'].value = '';
	return false;
}
