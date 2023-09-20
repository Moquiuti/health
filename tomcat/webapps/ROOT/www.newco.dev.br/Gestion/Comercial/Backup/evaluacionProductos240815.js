//evaluacion de productos 
//start 12-9-2014
jQuery.noConflict();
var arroba = '@';
var uploadFilesDoc = new Array();
var periodicTimerDoc = 0;
var form_tmp;
var MAX_WAIT_DOC = 1000;

//----------------------------------------------------------

jQuery(document).ready(globalEvents);

function globalEvents(){
                                                   
	jQuery("#DIAGNOSTICO_NO_APTO").change(function(){
		jQuery(".expliNoApto").show();
	});
        jQuery("#DIAGNOSTICO_NO_PROCEDE").change(function(){
		jQuery(".expliNoApto").show();
	});
        jQuery("#DIAGNOSTICO_APTO").change(function(){
		jQuery(".expliNoApto").hide();
	});
        
        jQuery("#US_EVAL_SI").change(function(){
		jQuery("#usuarioEvaluador").show();
	});
        jQuery("#US_EVAL_NO").change(function(){
		jQuery("#usuarioEvaluador").hide();
	});
        //si usuario empieza a escribir referencia quito boton de buscar en catalogo y pongo el de recuperar producto
        jQuery("#REF_PROD").focus(function(){
            jQuery("#botonBuscarEval").hide();
            jQuery("#botonRecuperarProd").show();
        });
        
        if (document.forms['EvaluacionProducto'] && document.forms['EvaluacionProducto'].elements['REF_PROV'] && document.forms['EvaluacionProducto'].elements['REF_PROV'].value != ''){
             jQuery('.datosProductoEstandard').show();              
        }
      
      

    }//fin de globalEvents

function Reset(form){
    
    form.elements['FIDEMPRESA'].value = '-1';
    form.elements['FIDCENTRO'].value = '-1';
    form.elements['FIDRESPONSABLE'].value = '-1';
    form.elements['FPRODUCTO'].value = '-1';
    form.elements['FIDAUTOR'].value = '-1';
    form.elements['FPROVEEDOR'].value = '-1';
    form.elements['FESTADO'].value = '-1';
    form.elements['FDIAGNOSTICO'].value = '-1';
    form.elements['FTEXTO'].value = ''; 
}


function RecuperarDatosProducto(){
    var form = document.forms['EvaluacionProducto'];
    var idemp = form.elements['EMP_ID'].value;    
    var ref  = '';
    
    if (form.elements['REF_CLIENTE_LIC'].value != ''){  ref = form.elements['REF_CLIENTE_LIC'].value; }
    if (form.elements['REF_PROD'].value != ''){  ref = form.elements['REF_PROD'].value; }
    
    if(idemp != '' && ref != ''){
        jQuery.ajax({
		url: 'http://www.newco.dev.br/Gestion/Comercial/RecuperaDatosProducto.xsql',
		data: "ID_EMP="+idemp+"&REF_PROD_ESTANDAR="+ref,
                type: "GET",
                contentType: "application/xhtml+xml",
                beforeSend: function(){
                    null;
                },
                error: function(objeto, quepaso, otroobj){
                    alert('error'+quepaso+' '+otroobj+''+objeto);
                    //alert(document.forms['mensajeJS'].elements['NO_PRODUCTO_ENCONTRADO'].value);
                },
                success: function(objeto){
                    var data = eval("(" + objeto + ")");
                  
                    
                    if ( (data[0] && data[0].ProdIDCP != '') || (data[1] && data[1].IDProv != '') ){
                          //oculto linea de busqueda
                        jQuery('.recuperaProd').hide();
                        
                        //datos prod del cat priv
                        if (data[0] && data[0].ProdIDCP != ''){
                            form.elements['ID_PROD_ESTANDAR'].value = data[0].ProdIDCP; 
                            form.elements['REF_ESTANDAR'].value = data[0].ProdRefCP;
                            form.elements['REF_CLIENTE'].value = data[0].RefClienteCP;
                            form.elements['DESCR_ESTANDAR'].value = data[0].DescrCP;
                            //si ya datos de cat priv de producto no enseño pa buscarlo
                            jQuery('.recuperaProd').hide();
                            //enseño linea de producto
                            jQuery('.datosProductoEstandard').show(); 
                            
                            if (form.elements['ID_PROVEEDOR'].value == ''){
                                jQuery('#botonBuscarCatalogoProveedores').show(); 
                            }
                            
                        }
                        //datos prod del provee
                        if (data[1] && data[1].IDProv != '' && form.elements['ID_PROVEEDOR'].value == ''){
                            form.elements['ID_PROVEEDOR'].value = data[1].IDProv;
                            form.elements['PROVEEDOR'].value = data[1].Prov;
                            form.elements['ID_PROD'].value = data[1].ProdIDProv;
                            form.elements['REF_PROV'].value = data[1].RefProdProv;
                            form.elements['DESCR_PROV'].value = data[1].DescrProv;
                            form.elements['MARCA'].value = data[1].MarcaProd;
                            //enseño linea de producto
                            jQuery('.datosProducto').show(); 
                            if (form.elements['MARCA'].value == '') jQuery("#marcaProd").hide();
                        }
                        else{  if (form.elements['ID_PROVEEDOR'].value == '') alert(prodNoAdj); }
                        
                    }
                    else{ alert(codigoNoDisp);  location.reload();  }
                    
                    //RecuperaUsuariosProveedor();

                    RecuperaUsuariosCentro();                  
                                      
                }
            });
        }//fin if
              
}//fin recuperaDatosProducto

//recupero datos prod desde id producto y id empresa
function RecuperarDatosProductoID(){
    var form = document.forms['EvaluacionProducto'];
    var idemp = form.elements['EMP_ID'].value;
    var idprod = form.elements['ID_PROD'].value;
    var idProdEstandar = form.elements['ID_PROD_ESTANDAR'].value;
    var idOfeLic = form.elements['LIC_OFE_ID'].value;
    
    
    if((idprod != '' || idProdEstandar != '' || idOfeLic != '') ){
             jQuery.ajax({
		url: 'http://www.newco.dev.br/Gestion/Comercial/RecuperaDatosProducto.xsql',
		data: "ID_EMP="+idemp+"&ID_PROD="+idprod+"&ID_PROD_ESTANDAR="+idProdEstandar+"&LIC_OFE_ID="+idOfeLic,
                type: "GET",
                contentType: "application/xhtml+xml",
                beforeSend: function(){
                    null;
                },
                error: function(objeto, quepaso, otroobj){
                    alert('error'+quepaso+' '+otroobj+''+objeto);
                },
                success: function(objeto){
                    var data = eval("(" + objeto + ")");
                    
                    if (data[0] || data[1] || data[2]){
                       
                        //datos prod del cat priv
                        if (data[0] && data[0].ProdIDCP != ''){
                            form.elements['ID_PROD_ESTANDAR'].value = data[0].ProdIDCP; 
                            form.elements['REF_ESTANDAR'].value = data[0].ProdRefCP;
                            form.elements['REF_CLIENTE'].value = data[0].RefClienteCP;
                            form.elements['DESCR_ESTANDAR'].value = data[0].DescrCP;
                            //si ya datos de cat priv de producto no enseño pa buscarlo
                            jQuery('.recuperaProd').hide();
                            //enseño linea de producto
                            jQuery('.datosProductoEstandard').show(); 
                            jQuery('#botonBuscarCatalogoProveedores').show(); 
                            
                        }
                        //datos prod del provee
                        if (data[1] && data[1].IDProv != ''){
                            form.elements['ID_PROVEEDOR'].value = data[1].IDProv;
                            form.elements['PROVEEDOR'].value = data[1].Prov;
                            form.elements['ID_PROD'].value = data[1].ProdIDProv;
                            form.elements['REF_PROV'].value = data[1].RefProdProv;
                            form.elements['DESCR_PROV'].value = data[1].DescrProv;
                            form.elements['MARCA'].value = data[1].MarcaProd;
                            //enseño linea de producto
                            jQuery('.datosProducto').show(); 
                            if (form.elements['MARCA'].value == '') jQuery("#marcaProd").hide();
                        }
                        if (data[2] && data[2].IDProv != ''){
                            form.elements['ID_PROVEEDOR'].value = data[2].IDProv;
                            form.elements['DESCR_PROV'].value = data[2].ProdNombre;
                            form.elements['PROVEEDOR'].value = data[2].Prov;
                            form.elements['REF_PROV'].value = data[2].LicOfeRef;
                            //enseño linea de producto
                            jQuery('.datosProducto').show(); 
                            jQuery('.datosProductoEstandard').show(); 
                            jQuery('.recuperaProd').hide();
                            if (form.elements['MARCA'].value == '') jQuery("#marcaProd").hide();
                        }
                        else{ if (form.elements['ID_PROVEEDOR'].value == '') alert(prodNoAdj); }
                        
                        
                    }
                    else{ alert(codigoNoDisp); }
                                        
                    //RecuperaUsuariosProveedor();
                    
                    RecuperaUsuariosCentro();
                  
                }
            });
        }//fin if              
}//fin recuperaDatosProductoID

//recupera los usuarios de un centro
function RecuperaUsuariosCentro(){
    var form = document.forms['EvaluacionProducto'];
    var idcentro = form.elements['IDCENTROCLIENTE'].value;
        
     jQuery.ajax({
		url: 'http://www.newco.dev.br/Gestion/Comercial/RecuperaUsuariosCentro.xsql',
		data: "ID_CENTRO="+idcentro,
                type: "GET",
                contentType: "application/xhtml+xml",
                beforeSend: function(){
                    null;
                },
                error: function(objeto, quepaso, otroobj){
                    alert('error'+quepaso+' '+otroobj+''+objeto);
                },
                success: function(objeto){
                    var data = eval("(" + objeto + ")");
                    var Resultados = new String('');
                    
                    jQuery("#ID_USUARIO_COOR").empty();
                    jQuery("#ID_USUARIO_EVALUADOR").empty();
                        
                    for(var i=0; i<data.ListaUsuarios.length; i++){
			var us_id	= data.ListaUsuarios[i].Usuario.ID;
			var us_nombre	= data.ListaUsuarios[i].Usuario.Nombre;
			Resultados = Resultados+'<option value="'+data.ListaUsuarios[i].Usuario.ID+'">'+data.ListaUsuarios[i].Usuario.Nombre+'</option>';
			}

			jQuery(".usuarioCoordinador").show();
			jQuery("#ID_USUARIO_COOR").html(Resultados);
                        
                        jQuery("#USUARIO_EVALUADOR").html(Resultados);
                  
                  
                }
            });
    
}//fin de recuperaUsuarios

//recupera los usuarios del proveedor para las muestras
function RecuperaUsuariosProveedor(){
    var form = document.forms['EvaluacionProducto'];
    var idprov = form.elements['ID_PROVEEDOR'].value;

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/UsuariosProveedor.xsql',
		type:	"GET",
		data:	"IDProveedor="+idprov,
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
                        var Resultados = new String('');
                        
			jQuery("#ID_USUARIO_MUESTRAS").empty();
			//jQuery("#ID_USUARIO_MUESTRAS").append("<option value=''>" + txtSelecciona + "</option>");
                        
			jQuery("#ID_USUARIO_COOR").html(Resultados);
			for(var i=0;i<data.ListaUsuarios.length;i++){
				Resultados = Resultados+"<option value='"+data.ListaUsuarios[i].id+"'>"+data.ListaUsuarios[i].nombre+"</option>";
			}
                        jQuery(".usuarioMuestras").show();
			jQuery("#ID_USUARIO_MUESTRAS").html(Resultados);
		}
	});
}

function GuardarNuevaEvaluacion(form){
    form.action= 'http://www.newco.dev.br/Gestion/Comercial/NuevaEvaluacionProductoSave.xsql';
    form.submit();
    
}

function BuscarEvaluacionesProductos(form){
			SubmitForm(form);
}
                
function MuestrasEnviadasProveedor(form){
    form.elements['ESTADO'].value = 'P';
    form.action='http://www.newco.dev.br/Gestion/Comercial/EvaluacionProductoSave.xsql';
    form.submit();
}       

function MuestrasProbadas(form){
    form.elements['ESTADO'].value = 'I';
    form.action='http://www.newco.dev.br/Gestion/Comercial/EvaluacionProductoSave.xsql';
    form.submit();
}

function FinalizarEvaluacion(form){
    form.elements['ESTADO'].value = 'C';
    form.action='http://www.newco.dev.br/Gestion/Comercial/EvaluacionProductoSave.xsql';
    form.submit();
}


function errorCheck(form){
    var msg = '';
    var estado = form.elements['ESTADO'].value;
    var regex_numero	= new RegExp("^[0-9]+$","g"); 
    var regex_fecha	= new RegExp("^[0-9\/]+$","g");
    
    //si nueva evaluacion
    if (estado == ''){
        
        //si ref_estandar = mvm o desc estandar => error
        if ((form.elements['DESCR_ESTANDAR'] && form.elements['DESCR_ESTANDAR'].value == '')){
            msg += obliRecuperoDatos+'\n';
        }
        
        //desc proveedor o ref prov vacío => error
        if ((form.elements['DESCR_PROV'] && form.elements['DESCR_PROV'].value == '') && (form.elements['DESCR_ESTANDAR'] && form.elements['DESCR_ESTANDAR'].value != '')){
            msg += obliRecuperoDatosProveedor+'\n';
        }
        
        if (form.elements['IDCENTROCLIENTE'] && form.elements['IDCENTROCLIENTE'].value == ''){
            msg += centroClienteObli+'\n';
        }
        if (form.elements['ID_USUARIO_COOR'] && form.elements['ID_USUARIO_COOR'].value == ''){
            msg += usuarioCoorObli+'\n';
        }
               
        var radioMotivo = document.getElementsByName('MOTIVO_VALUES');
		for(var j = 0; j < radioMotivo.length; j++){
			if(radioMotivo[j].checked == true){
				form.elements['MOTIVO'].value = radioMotivo[j].value;
			}
		}
        if (form.elements['MOTIVO'] && form.elements['MOTIVO'].value == ''){
            msg += motivoObli+'\n';
        }
        
        var evaluador = "";
        var radioEvaluador = document.getElementsByName('US_EVAL');
		for(var j = 0; j < radioEvaluador.length; j++){
			if(radioEvaluador[j].checked == true){
				evaluador = radioEvaluador[j].value;
			}
		}
        if (evaluador == '' && !(form.elements['EVALUADOR']) ){
            msg += elegirInformarEvaluadorObli+'\n';
        }
        
        
        /*if (form.elements['MOTIVO'] && form.elements['MOTIVO'].value != 'NUEVO' && form.elements['INSTRUCCIONES'] && form.elements['INSTRUCCIONES'].value == ''){
            msg += instruccionesObli+'\n';
        }*/
        if (form.elements['FECHA_LIMITE'] && form.elements['FECHA_LIMITE'].value == ''){
            msg += fechaLimiteObli+'\n';
        }
        
        if (form.elements['NUM_MUESTRAS'] && form.elements['NUM_MUESTRAS'].value == ''){
            msg += numMuestrasObli+'\n';
        }
        else{
            if(!checkRegEx(form.elements['NUM_MUESTRAS'].value, regex_numero)){
				msg += numMuestras + ' ' + soloNumeros +'\n';
				form.elements['NUM_MUESTRAS'].focus();
			}
            }
        //USUARIO EVALUADOR
        if (document.getElementById("usuarioEvaluador") && document.getElementById("usuarioEvaluador").style.display != 'none'){
            form.elements['ID_USUARIO_EVALUADOR'].value = form.elements['USUARIO_EVALUADOR'].value
                if (form.elements['USUARIO_EVALUADOR'] && form.elements['USUARIO_EVALUADOR'].value == ''){
                msg += usEvaluadorObli+'\n';
                }
        }
        
        //si muestras mayor de 0 pasamos por el proveedor
        if (msg == '' && form.elements['NUM_MUESTRAS'].value != '0'){ GuardarNuevaEvaluacion(form); }
        //si muestras = a 0 no pasamos por el proveedor
        else if (msg == '' && form.elements['NUM_MUESTRAS'].value == '0'){ MuestrasEnviadasProveedor(form); }
        else{ alert(msg); }
      
    }//fin nueva evaluación
    
    //prove envia muestras
    if (estado == 'N'){
        
        if (form.elements['FECHA_MUESTRAS'] && form.elements['FECHA_MUESTRAS'].value == ''){
            msg += fechaMuestrasObli+'\n';
        }
        else{
            if(!checkRegEx(form.elements['FECHA_MUESTRAS'].value, regex_fecha)){
				msg += fechaEnvio + ' ' + soloNumerosBarras +'\n';
				form.elements['FECHA_MUESTRAS'].focus();
			}
            }
        
        if (msg == ''){ MuestrasEnviadasProveedor(form); }
        else{ alert(msg); }
      
    }//fin envio muestras del provee

    //coordinador evalua muestras
    if (estado == 'P'){
                    
        if (form.elements['USUARIO_EVALUADOR'] && form.elements['USUARIO_EVALUADOR'].value ==''){
            msg += usEvaluadorObli+'\n';
            }
        if (form.elements['EVALUACION'] && form.elements['EVALUACION'].value == ''){
            msg += evaluacionObli+'\n';
        }
        if (form.elements['MUESTRAS_PROBADAS'] && form.elements['MUESTRAS_PROBADAS'].value == ''){
            msg += muestrasProbadasObli+'\n';
        }
        else{
            if(!checkRegEx(form.elements['MUESTRAS_PROBADAS'].value, regex_numero)){
				msg += numMuestrasProbadas + ' ' + soloNumeros +'\n';
				form.elements['MUESTRAS_PROBADAS'].focus();
			}
            }
            
        var radioDiag = document.getElementsByName('DIAGNOSTICO_VALUES');
		for(var j = 0; j < radioDiag.length; j++){
			if(radioDiag[j].checked == true){
				form.elements['DIAGNOSTICO'].value = radioDiag[j].value;
			}
		}
        if (form.elements['DIAGNOSTICO'] && form.elements['DIAGNOSTICO'].value == ''){
            msg += diagnosticoObli+'\n';
        }
        if (form.elements['DIAGNOSTICO'].value == 'NOAPTO'){
            if (form.elements['EXPLI_NO_APTO'] && form.elements['EXPLI_NO_APTO'].value == ''){
                msg += expliNoAptoObli+'\n';
            }
        }
               
        if (msg == ''){ MuestrasProbadas(form); }
        else{ alert(msg); }
      
    }//fin coordinador evalua muestras
    
    
    
}



function ConcadenarValores(input, symbol) {	
    var s = '';
    var i, j;
	
    for (i = 0; i < document.getElementsByName(input).length; i++) {
        if (document.getElementsByName(input)[i].checked) {
            if (s == '')
                s += document.getElementsByName(input)[i].value;
            else
                s += symbol + document.getElementsByName(input)[i].value;
        }
    }
    return s;
}


//ensenyar el input file para subir docs
function verCargaDoc(tipo){
	if(document.getElementById('carga'+tipo).style.display == 'none'){
		jQuery(".cargas").hide();
		jQuery("#carga"+tipo).show();

		document.forms['EvaluacionProducto'].elements['TIPO_DOC_DB'].value	= 'EVAL';
		document.forms['EvaluacionProducto'].elements['TIPO_DOC_HTML'].value	= tipo;
	}else{
		jQuery("#carga"+tipo).hide();
	}
}

function addDocFile(id){
	var remove	= document.forms['EvaluacionProducto'].elements['REMOVE'].value;
	var uploadElem	= document.getElementById("inputFileDoc_" + id);

	if(uploadElem.value != ''){
		uploadFilesDoc[uploadFilesDoc.length] = uploadElem.value;

		if(!document.getElementById("inputDocLink_" + id)){
			var rmLink = document.createElement('div');

			rmLink.setAttribute("class","remove");
			jQuery('Element').append(rmLink);
			rmLink.setAttribute('id', 'inputDocLink_' + id);
			rmLink.innerHTML = '<a href="javascript:removeDoc(\'' + id + '\');">'+ remove +'</a>';

			document.getElementById("docLine_" + id).appendChild(rmLink);
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

	uploadElem.parentNode.insertBefore(clearedInput, uploadElem);
	uploadElem.parentNode.removeChild(uploadElem);
	uploadFilesDoc.splice(id, 1);
	document.getElementById("docLine_" + id).removeChild(document.getElementById("inputDocLink_" + id));

	return undefined;
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

//function que dice al usuario de esperar
function waitDoc(tipo){
	jQuery('#waitBoxDoc'+tipo).html ('<img src="http://www.newco.dev.br/images/loading.gif" />');
	jQuery('#waitBoxDoc'+tipo).show();
	return false;
}

//Search form if there is a filled file input
function hasFilesDoc(form){
	for(var i=1; i<form.length; i++){
		if(form.elements[i].type == 'file' && (form.elements[i].name == 'inputFileDoc') && form.elements[i].value != '' ){
			return true;
		}
	}
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
		var tipoDocHTML	= document.forms['EvaluacionProducto'].elements['TIPO_DOC_HTML'].value;
		//var tipoDocDB	= document.forms['Incidencia'].elements['TIPO_DOC_DB'].value;
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

	var action = 'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/confirmCargaDocumento.xsql';

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

	var usuario	= document.forms['EvaluacionProducto'].elements['ID_USUARIO'].value;
	var borrados	= document.forms['EvaluacionProducto'].elements['DOCUMENTOS_BORRADOS'].value;
	var borr_ante	= document.forms['EvaluacionProducto'].elements['BORRAR_ANTERIORES'].value;
	var tipoDocDB	= document.forms['EvaluacionProducto'].elements['TIPO_DOC_DB'].value;
	var tipoDocHTML	= document.forms['EvaluacionProducto'].elements['TIPO_DOC_HTML'].value;
	var prove	= document.forms['EvaluacionProducto'].elements['IDPROVEEDOR'].value;;


	if(msg != ''){
		alert(msg);
		return false;
	}else{

		form.encoding	= enctype;
		form.action	= action;
		form.target	= target;
		var d = new Date();

		jQuery.ajax({
			url:"http://www.newco.dev.br/Administracion/Mantenimiento/Productos/confirmCargaDocumento.xsql",
			data: "ID_USUARIO="+usuario+"&ID_PROVEEDOR="+prove+"&DOCUMENTOS_BORRADOS="+borrados+"&BORRAR_ANTERIORES="+borr_ante+"&TIPO_DOC="+tipoDocDB+"&CADENA_DOCUMENTOS="+cadenaDoc+"&_="+d.getTime(),
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
				document.forms['EvaluacionProducto'].elements['inputFileDoc'].value = '';

				var tipo = document.forms['EvaluacionProducto'].elements['TIPO_DOC_HTML'].value;

				//vaciamos la carga documentos
				document.forms['EvaluacionProducto'].elements['inputFileDoc'+tipo] = '';
				jQuery("#carga"+tipo).hide();

				uploadFrameDoc.document.getElementsByTagName("p")[0].innerHTML = '';
				uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";

				var proveedor = document.forms['EvaluacionProducto'].elements['IDPROVEEDOR'].value;

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


function DescargarExcel(){
			var FIDEmpresa		= jQuery('#FIDEMPRESA').val();
			var FIDCentro		= jQuery('#FIDCENTRO').val();
			var FIDResponsable	= jQuery('#FIDRESPONSABLE').val();
			var FIDProveedor	= jQuery('#FPROVEEDOR').val();
			var FIDProducto		= jQuery('#FPRODUCTO').val();
			var FTexto		= codificacionAjax(jQuery('#FTEXTO').val());
			var FEstado		= jQuery('#FESTADO').val();
			var d			= new Date();
                        
			jQuery.ajax({
				url: 'http://www.newco.dev.br/Gestion/Comercial/EvaluacionesExcel.xsql',
				data: "FIDEMPRESA="+FIDEmpresa+"&FIDCENTRO="+FIDCentro+"&FIDCOORD="+FIDResponsable+"&FIDPROVEEDOR="+FIDProveedor+"&FIDPRODUCTO="+FIDProducto+"&FTEXTO="+FTexto+"&FESTADO="+FEstado+"&_="+d.getTime(),
                                type: "GET",
                                contentType: "application/xhtml+xml",
                                beforeSend: function(){
                                        null;
                                },
                                error: function(objeto, quepaso, otroobj){
                                        alert('error'+quepaso+' '+otroobj+''+objeto);
                                },
                                success: function(objeto){
                                        var data = eval("(" + objeto + ")");

                                        if(data.estado == 'ok')
                                                window.location='http://www.newco.dev.br/Descargas/'+data.url;
                                        else
                                                alert('Se ha producido un error. No se puede descargar el fichero.');
                                }
                        });
                }
                
                
                function BorrarEvaluacionProducto(IDEval){
			var d			= new Date();

			jQuery.ajax({
				url: 'http://www.newco.dev.br/Gestion/Comercial/BorrarEvaluacionProducto.xsql',
				data: "IDINCIDENCIA="+IDEval+"&_="+d.getTime(),
				type: "GET",
				contentType: "application/xhtml+xml",
				beforeSend: function(){
					jQuery("#EvalBorradaOK").hide();
					jQuery("#EvalBorradaKO").hide();
				},
				error: function(objeto, quepaso, otroobj){
					alert('error'+quepaso+' '+otroobj+''+objeto);
				},
				success: function(objeto){
					var data = eval("(" + objeto + ")");

					if(data.estado == 'OK'){
						var IDEval = data.id;

						jQuery("#EvalBorradaOK").show();
						jQuery("#EVAL_" + IDEval).hide();
					}else
						jQuery("#EvalBorradaKO").show();
				}
			});
		}