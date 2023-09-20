//	Ultima revision ET 11jul18 11:29

jQuery(document).ready(onloadEvents2);

var gl_MejorPrecio;					//	25oct16	Dejamos guardado el mejor precio
var gl_PrecioOfertaActual;			//	25oct16	Dejamos guardado la oferta actual

// Pluguin que permite desmarcar un radio button seleccionado previamente, copiado desde lic_170916.js
(function(jQuery){
	jQuery.fn.uncheckableRadio = function() {

		return this.each(function(){
			jQuery(this).mousedown(function() {
				jQuery(this).data('wasChecked', this.checked);
			});

			jQuery(this).click(function() {
				if (jQuery(this).data('wasChecked')){
					this.checked = false;
            	}
			});
		});
	};
})( jQuery );


function onloadEvents2(){
	//	los "input radio" podrán desmarcarse
	jQuery('input[type=radio]').uncheckableRadio();
	
	//	SI no está informado, ocultamos la línea de motivos
	if (jQuery("#IDMOTIVOSELECCION").val()=="")
	{
		jQuery("#lMotivo").hide();		
	}
	
	//	Marcamos el mejor precio (normalmente el primero)
	MarcarMejorPrecio();
	
	if(IDEstadoLicitacion == 'EST')
	{
		CambioPestannaVisible('lInfoCli');	
	}
	

	// Click en pestaña Info. Prov.
	jQuery("#pes_lInfoProv").click(function(){
	/*
		if(lang == 'spanish'){
			jQuery("#pes_lInfoProv > img").attr('src',"/images/botonInfoProv1.gif");
			jQuery("#pes_lInfoCli > img").attr('src',"/images/botonInfoCliente.gif");
		}else{
			jQuery("#pes_lInfoProv > img").attr('src',"/images/botonInfoProv1-BR.gif");
			jQuery("#pes_lInfoCli > img").attr('src',"/images/botonInfoCliente.gif");
		}

		jQuery("#lInfoProv").show();
		jQuery("#lInfoCli").hide();*/
		
		CambioPestannaVisible('lInfoProv');	
	});
	// Click en pestaña Info. Cliente
	jQuery("#pes_lInfoCli").click(function(){
		/*if(lang == 'spanish'){
			jQuery("#pes_lInfoProv > img").attr('src',"/images/botonInfoProv.gif");
			jQuery("#pes_lInfoCli > img").attr('src',"/images/botonInfoCliente1.gif");
		}else{
			jQuery("#pes_lInfoProv > img").attr('src',"/images/botonInfoProv-BR.gif");
			jQuery("#pes_lInfoCli > img").attr('src',"/images/botonInfoCliente1.gif");
		}

		jQuery("#lInfoProv").hide();
		jQuery("#lInfoCli").show();*/
		
		CambioPestannaVisible('lInfoCli');	
	});
}

//	Separamos la función de cambio de pestañas del propio evento
function CambioPestannaVisible(Activa){

	if (Activa=='lInfoProv')
	{
		if(lang == 'spanish'){
			jQuery("#pes_lInfoProv > img").attr('src',"/images/botonInfoProv1.gif");
			jQuery("#pes_lInfoCli > img").attr('src',"/images/botonInfoCliente.gif");
		}else{
			jQuery("#pes_lInfoProv > img").attr('src',"/images/botonInfoProv1-BR.gif");
			jQuery("#pes_lInfoCli > img").attr('src',"/images/botonInfoCliente.gif");
		}

		jQuery("#lInfoProv").show();
		jQuery("#lInfoCli").hide();
	}
	else
	{
		if(lang == 'spanish'){
			jQuery("#pes_lInfoProv > img").attr('src',"/images/botonInfoProv.gif");
			jQuery("#pes_lInfoCli > img").attr('src',"/images/botonInfoCliente1.gif");
		}else{
			jQuery("#pes_lInfoProv > img").attr('src',"/images/botonInfoProv-BR.gif");
			jQuery("#pes_lInfoCli > img").attr('src',"/images/botonInfoCliente1.gif");
		}

		jQuery("#lInfoProv").hide();
		jQuery("#lInfoCli").show();
	}
}

function MarcarMejorPrecio(){

	if(IDEstadoLicitacion == 'CURS' || IDEstadoLicitacion == 'INF'){
		gl_MejorPrecio		= -1;
		var MejorOfertaID	= 0;

		// Para cada una de las celdas con class 'PrecioOferta'
		//jQuery("td.PrecioOferta span.precio").each(function(){
		jQuery("input[name*='Precio_']").each(function(){
		
			var PrecioActual=parseFloat(jQuery(this).val().replace(",","."));

			if((gl_MejorPrecio < 0) || (gl_MejorPrecio > PrecioActual)){
				gl_MejorPrecio	= PrecioActual;
				MejorOfertaID	= jQuery(this).parent().attr('id');

				//solodebug	alert('MejorPrecio:'+gl_MejorPrecio);
			}
		});

		if(MejorOfertaID != 0){
			jQuery("td#" + MejorOfertaID).addClass("mejorPrecio");
		}
	}
}

function ValidarDatosProducto(){
	var errores=0;
	var precioRefIVA, precioRef, tipoIVA;
	var precioObjIVA, precioObj;
	var valAux;

	// Validacion Precio Historico
	if(MostrarPrecioIVA == 'S'){
		// Validacion de la columna para el precio historico con IVA
		valAux	= jQuery('#PrecioRefIVA').val().replace(",",".");

		if(!errores && !esNulo(valAux) && isNaN(valAux)){
			errores++;
			alert(val_malPrecioRef);
			jQuery('#PrecioRefIVA').focus();
			return;
		}

		if(!errores){
			// Tambien calculamos el valor para el #PrecioRef (precio historico sin IVA) que es un input hidden
			precioRefIVA	= (valAux != '') ? valAux : '';
			tipoIVA		= parseFloat(jQuery('#TipoIVA').val());
			precioRef	= (precioRefIVA != '') ? (precioRefIVA * 100) / (100 + tipoIVA) : '';
			valAux		= (precioRef != '') ? String(precioRef.toFixed(4)).replace(".",",") : '';
			jQuery('#PrecioRef').val(valAux);
			valAux		= (precioRefIVA != '') ? String(precioRefIVA.toFixed(4)).replace(".",",") : '';
			jQuery('#PrecioRefIVA').val(valAux);
		}
	}else{
		// Validacion de la columna para el precio historico sin IVA
		valAux	= jQuery('#PrecioRef').val().replace(",",".");

		if(!errores && !esNulo(valAux) && isNaN(valAux)){
			errores++;
			alert(val_malPrecioRef);
			jQuery('#PrecioRef').focus();
			return;
		}

		if(!errores){
			valAux	= (valAux != '') ? String(parseFloat(valAux).toFixed(4)).replace(".",",") : '';
			jQuery('#PrecioRef').val(valAux);
		}
	}

	// Validacion Precio Objetivo
	if(MostrarPrecioIVA == 'S'){
		// Validacion de la columna para el precio objetivo con IVA
		valAux	= jQuery('#PrecioObjIVA').val().replace(",",".");

		if(!errores && !esNulo(valAux) && isNaN(valAux)){
			errores++;
			alert(val_malPrecioObj);
			jQuery('#PrecioObjIVA').focus();
			return;
		}

		if(!errores){
			// Tambien calculamos el valor para cada #PrecioObj (precio objetivo sin IVA) que es un input hidden
			precioObjIVA	= (valAux != '') ? valAux : '';
			tipoIVA		= parseFloat(jQuery('#TipoIVA').val());
			precioObj	= (precioObjIVA != '') ? (precioObjIVA * 100) / (100 + tipoIVA) : '';
			valAux		= (precioObj != '') ? String(precioObj.toFixed(4)).replace(".",",") : '';
			jQuery('#PrecioObj').val(valAux);
			valAux		= (precioObjIVA != '') ? String(precioObjIVA.toFixed(4)).replace(".",",") : '';
			jQuery('#PrecioObjIVA').val(valAux);
		}
	}else{
		// Validacion de la columna para el precio objetivo sin IVA
		valAux	= jQuery('#PrecioObj').val().replace(",",".");

		if(!errores && !esNulo(valAux) && isNaN(valAux)){
			errores++;
			alert(val_malPrecioObj);
			jQuery('#PrecioObj').focus();
			return;
		}

		if(!errores){
			valAux	= (valAux != '') ? String(parseFloat(valAux).toFixed(4)).replace(".",",") : '';
			jQuery('#PrecioObj').val(valAux);
		}
	}

	// Validacion UdBasica
	valAux	= jQuery('#UdBasica').val();
	if(!errores && esNulo(valAux)){
		errores++;
		alert(val_faltaUdBasica);
		jQuery('#UdBasica').focus();
		return;
	}

	// Validacion Cantidad
	valAux	= jQuery('#Cantidad').val().replace(",",".");

	// Cantidad obligatoria si es una licitacion para pedido
	if(!errores && MesesDuracion == '0' && (esNulo(valAux))){
		errores++;
		alert(val_faltaCantidad);
		jQuery('#Cantidad').focus();
		return;
	}else if(!errores && parseFloat(valAux) === 0){
		errores++;
		alert(val_ceroCantidad);
		jQuery('#Cantidad').focus();
		return;
	}else if(!errores && isNaN(valAux)){
		errores++;
		alert(val_malCantidad);
		jQuery('#Cantidad').focus();
		return;
	}

	if(!errores){
		jQuery('#Cantidad').val( String(parseFloat(valAux)).replace(".",",") );
	}

	// si los datos son correctos enviamos el form
	if(!errores){
		ActualizarProducto();
	}
}

function ActualizarProducto(){
	var listaProductos;
	var d = new Date();

	listaProductos = IDProdLic + '|' +		//p_IDProductoEstandar
		jQuery('#UdBasica').val() + '|' +	//p_UnidadBasica
		jQuery('#Cantidad').val() + '|' +	//p_Cantidad
		jQuery('#PrecioRef').val() + '|' +	//p_PrecioReferencia
		jQuery('#PrecioObj').val();		//p_PrecioObjetivo

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/ActualizarProductos.xsql',
		type:	"POST",
		async:	false,
		data:	"LIC_ID="+IDLicitacion+"&LISTA_PRODUCTOS="+encodeURIComponent(listaProductos)+"&ELIMINAROFERTAS=N&_="+d.getTime(),
		beforeSend: function(){
			jQuery("#botonGuardarDatosProd").hide();
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.ProductosActualizados.estado == 'OK'){
				alert(alrt_ProdActualizadoOK);
				try
				{
					opener.location.reload();
				}
				catch(e)
				{
				}
				location.reload();
			}else{
				alert(alrt_ProdActualizadoKO);
				jQuery('#botonGuardarDatosProd').show();
       	        return;
			}
		}
	});
}

function ValidarDatosOfertas(){
	var errores=0;
	var precioIVA, precio, tipoIVA;
	var valAux, IDOferta, RefProv;

	jQuery("table#lDatosOfertas").find("tbody").find("tr").each(function(){
		IDOferta	= this.id.replace("OFE_","");

		// Si la oferta esta informada
		if(jQuery("#UdsXLote_" + IDOferta).length){
			RefProv = jQuery('#RefProv_' + IDOferta).html();

			// Validamos Precio
			if(MostrarPrecioIVA == 'S'){
				// Validacion de la columna para el precio con IVA
				valAux	= jQuery('#PrecioIVA_' + IDOferta).val().replace(",",".");

				if(!errores && !esNulo(valAux) && isNaN(valAux)){
					errores++;
					alert(val_malPrecioOfe.replace("[[REF]]", RefProv));
					jQuery('#PrecioIVA_' + IDOferta).focus();
					return false;
				}

				if(!errores){
					// Tambien calculamos el valor para cada #PrecioObj (precio objetivo sin IVA) que es un input hidden
					precioIVA	= (valAux != '') ? valAux : '';
					tipoIVA		= parseFloat(jQuery('#TipoIVA').val());
					precio		= (precioIVA != '') ? (precioIVA * 100) / (100 + tipoIVA) : '';
					valAux		= (precio != '') ? String(precio.toFixed(4)).replace(".",",") : '';
					jQuery('#Precio_' + IDOferta).val(valAux);
					valAux		= (precioIVA != '') ? String(precioIVA.toFixed(4)).replace(".",",") : '';
					jQuery('#PrecioIVA_' + IDOferta).val(valAux);
				}
			}else{
				// Validacion de la columna para el precio sin IVA
				valAux	= jQuery('#Precio_' + IDOferta).val().replace(",",".");

				if(!errores && !esNulo(valAux) && isNaN(valAux)){
					errores++;
					alert(val_malPrecioOfe.replace("[[REF]]", RefProv));
					jQuery('#Precio_' + IDOferta).focus();
					return false;
				}

				if(!errores){
					valAux	= (valAux != '') ? String(parseFloat(valAux).toFixed(4)).replace(".",",") : '';
					jQuery('#Precio_' + IDOferta).val(valAux);
				}

			}

			// Validamos UdsXLote
			valAux	= jQuery('#UdsXLote_' + IDOferta).val();
			if(!errores && esNulo(valAux)){
				errores++;
				alert(val_faltaUnidades.replace("[[REF]]", RefProv));
				jQuery('#UdsXLote_' + IDOferta).focus();
				return false;
			}
		}

	});

	// Si los datos son correctos enviamos el form
	if(!errores){
		ActualizarOfertas();
	}
}

function ActualizarOfertas(){
	var listaOfertas='';
	var d = new Date();

	jQuery("table#lDatosOfertas").find("tbody").find("tr").each(function(){
		IDOferta	= this.id.replace("OFE_","");

		// Si la oferta esta informada
		if(jQuery("#UdsXLote_" + IDOferta).length){
			listaOfertas += IDOferta + '|' +
				jQuery("#UdsXLote_" + IDOferta).val() + '|' +
				jQuery("#Precio_" + IDOferta).val() + '#';
		}
	});

	// Quitamos la ultima '#' del string ListaOfertas
	listaOfertas = listaOfertas.substring(0, listaOfertas.length - 1);

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/ActualizarOfertasAJAX.xsql',
		type:	"POST",
		async:	false,
		data:	"LIC_ID="+IDLicitacion+"&LISTA_OFERTAS="+encodeURIComponent(listaOfertas)+"&_="+d.getTime(),
		beforeSend: function(){
			jQuery("#botonGuardarOfertas").hide();
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.OfertasActualizadas.estado == 'OK'){
				alert(alrt_OfertasOK);
				location.reload();
				try
				{
					opener.location.reload();
				}
				catch(e)
				{
				}
			}else{
				alert(alrt_OfertasKO);
				jQuery('#botonGuardarOfertas').show();
       	        return;
			}
		}
	});
}

// Funcion para abrir el div flotante - formulario para anyadir campos avanzados de ofertas
function abrirCamposAvanzadosOfe2(IDOferta){
//	var infoAmpliada	= (typeof jQuery("#INFOAMPLIADA_" + IDOferta).val() !== 'undefined') ? jQuery("#INFOAMPLIADA_" + IDOferta).val() : '';
//	var IDDoc		= (typeof jQuery("#IDDOC_" + IDOferta).val() !== 'undefined') ? jQuery("#IDDOC_" + IDOferta).val() : '';
//	var nombreDoc		= (typeof jQuery("#NOMBREDOC_" + IDOferta).val() !== 'undefined') ? jQuery("#NOMBREDOC_" + IDOferta).val() : '';
	var infoAmpliada	= jQuery("#INFOAMPLIADA_" + IDOferta).val().replace(/<br>/gi,'\n');
	var IDDoc		= jQuery("#IDDOC_" + IDOferta).val();
	var nombreDoc		= jQuery("#NOMBREDOC_" + IDOferta).val();

	jQuery("#IDOferta").val(IDOferta);

	if(infoAmpliada != ''){
		jQuery('#txtInfoAmpliada').val(infoAmpliada);
	}

	if(IDDoc != ''){
		jQuery('input#IDDOC').val(IDDoc);
		jQuery("span#NombreDoc").html(nombreDoc);
		jQuery("span#DocCargado").show();
		jQuery("input#inputFileDoc_CA").hide();
	}

	jQuery("#confirmBox_CA").hide();
	showTablaByID("CamposAvanzados");
	//showTabla(true);
}

function guardarCamposAvanzadosOfe2(){
	var IDOferta		= jQuery("#IDOferta").val();
	var infoAmpliada	= jQuery("#txtInfoAmpliada").val().replace(/'/g, "''");
	var IDDoc		= jQuery("#IDDOC").val();
	var d = new Date();

	if(infoAmpliada != '' || IDDoc != ''){
		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/CamposAvanzadosOfeAJAX.xsql',
			type:	"POST",
			async:	false,
			data:	"IDOFERTA="+IDOferta+"&IDDOC="+IDDoc+"&INFOAMPLIADA="+encodeURIComponent(infoAmpliada)+"&_="+d.getTime(),
			success: function(objeto){
				var data = eval("(" + objeto + ")");

				if(data.CamposAvanzadosOfe.estado == 'OK'){
					alert(alrt_CamposAvanzadosOK);
					location.reload();
        	                }else{
					alert(alrt_CamposAvanzadosKO);
				}
			},
			error: function(xhr, errorString, exception) {
				alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
			}
		});
	}
}

function borrarDoc2(tipo){
	var IDOferta	= jQuery("#IDOferta").val();
	var d = new Date(), action;

	if(tipo == 'LIC_PRODUCTO_FT'){
		action = 'http://www.newco.dev.br/Gestion/Comercial/BorrarDocumentoProductoAJAX.xsql';
	}else{
		action = 'http://www.newco.dev.br/Gestion/Comercial/BorrarDocumentoOfertaAJAX.xsql';
	}

	jQuery.ajax({
		cache:	false,
		url:	action,
		type:	"GET",
		data:	"ID="+IDOferta+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.Resultado.Estado == 'OK'){
				alert(alrt_BorrarDocumentoOK);
				jQuery("span#DocCargado").hide();
				jQuery("div#confirmBox_CA").hide();
				jQuery("input#inputFileDoc_CA").show();
           }else{
				alert(alrt_BorrarDocumentoKO);
          }
		}
	});
}



// Funcion para guardar los datos de una oferta del proveedor para una fila en concreto
//	Adaptada desde  guardarDatosCompraFila(thisPosArr) de lic_010916.js
function guardarDatosCompraCentro(IDCentro){
	// Validaciones
	var oform=document.forms["cantidadPorCentro"];
	
	var errores = 0;

	//jQuery("#BtnActualizarOfertas").hide();
	//jQuery("img .guardarOferta").hide();
	//alert("("+oForm.elements['Marca_' + thisPosArr].value+")");

	// Validacion Precio
	var cantidad	= oform['Cantidad_'+IDCentro].value;
	var cantidadFormat	= cantidad.replace(",",".");
	if(!errores && esNulo(cantidadFormat)){
		errores++;
		alert(val_faltaCantidad.replace("[[REF]]",RefCliente));
		return false;
	}else if(!errores && isNaN(cantidadFormat)){
		errores++;
		alert(val_malCantidad.replace("[[REF]]",RefCliente));
	}
	if(!errores){
	
		//alert('IDCentro:'+IDCentro+ ' Cantidad:'+cantidad);
	
		//var IDLicProv	= oForm.elements['LIC_PROV_ID'].value;
		//var IDProdLic	= arrProductos[thisPosArr].IDProdLic;
		//var IDCentro = oForm.elements['IDCENTROCOMPRAS'].value;
		//var IDFicha = '';
		//if(jQuery("#IDFICHA_" + thisPosArr).val() > 0){
		//	IDFicha = jQuery("#IDFICHA_" + thisPosArr).val();
		//}

		var d = new Date();

		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/InformarDatosCOmpraAJAX.xsql',
			type:	"GET",
			data:	"LIC_ID="+IDLicitacion+"&LIC_PROD_ID="+IDProdLic+"&IDCENTRO="+IDCentro+"&CANTIDAD="+cantidad+"&_="+d.getTime(),
			beforeSend: function(){
				jQuery("#BtnActualizarOfertas").hide();
				jQuery(".guardarOferta").hide();
			},
			error: function(objeto, quepaso, otroobj){
				jQuery('#Resultado_'+IDCentro).html('<img src="http://www.newco.dev.br/images/error.gif"/>');
				alert('error'+quepaso+' '+otroobj+' '+objeto);
			},
			success: function(objeto){
				var data = eval("(" + objeto + ")");

				if(data.OfertaActualizada.IDOferta > 0){
					jQuery('#Resultado_'+IDCentro).html('<img src="http://www.newco.dev.br/images/recibido.gif"/>');
					//	7set16	Recargamos los datos, también hay que recargar la página principal
					location.reload();
					try
					{
						opener.location.reload();
					}
					catch(e)
					{
					}
				}else{
					jQuery('#Resultado_'+IDCentro).html('<img src="http://www.newco.dev.br/images/error.gif"/>');
				}
			}
		});
	}

	jQuery("#BtnActualizarOfertas").show();
	jQuery(".guardarOferta").show();

}



// 25oct16 Guarda la selección para la oferta de un unico producto. Copiado desde lic_170916
function GuardarProductoSel(IDProdLic){
	var d = new Date();
	var msgError ='';

	// Busco el radio button seleccionado
	var IDOfertaLic = (jQuery("input[type='radio'][name='RADIO_" + IDProdLic + "']:checked").val() !== undefined) ? jQuery("input[type='radio'][name='RADIO_" + IDProdLic + "']:checked").val() : '';

	var IDMotivo=jQuery("#IDMOTIVOSELECCION").val();
	var Motivo=jQuery("#MOTIVOSELECCION").val();
	
	var adjudOfertas='';


	if ((gl_PrecioOfertaActual>gl_MejorPrecio)&&(IDMotivo=='')){
		msgError=alrt_RequiereMotivo;
	}

	
	if (LicMultiOpcion=='S')
	{
		var Inform='N', opcion1='N';
		jQuery("select").each(function()
		{
        	//solodebug	console.log('Nombre:'+jQuery(this).attr("name").substring(0,5));
			if (jQuery(this).attr("name").substring(0,5)=='ORDEN')
			{

				adjudOfertas+=Piece(jQuery(this).attr("name"),'_',1)+'#'+jQuery(this).val()+'|';

				if (jQuery(this).val()!='')
				{
	        	    Inform='S';
				}

				if (jQuery(this).val()=='1')
					if (opcion1=='S')
						msgError=alrt_SoloUnaOpcion1;
					else
						opcion1='S';

        	    //solodebug	console.log('Valor:'+jQuery(this).val()+' Inform:'+Inform+' opcion1:'+opcion1);
			}
        });
	
		//	11jul18 Opcion1 no obligatoria
		//if ((Inform=='S')&&(opcion1=='N'))
		//	msgError=alrt_RequiereOpcion1;
	}

	
	//solodebug	alert("IDLIC="+IDLicitacion+"&IDPRODUCTOLIC="+IDProdLic+"&IDOFERTA="+IDOfertaLic+"&IDMOTIVO="+IDMotivo+"&MOTIVO="+encodeURIComponent(Motivo));

	if(msgError == '')
	{
		if (LicMultiOpcion!='S')
		{			
			//	Adjudicación única
			jQuery.ajax({
				url:	"http://www.newco.dev.br/Gestion/Comercial/SeleccionarProductoAJAX.xsql",
				data:	"IDLIC="+IDLicitacion+"&IDPRODUCTOLIC="+IDProdLic+"&IDOFERTA="+IDOfertaLic+"&IDMOTIVO="+IDMotivo+"&MOTIVO="+encodeURIComponent(Motivo)+"&_="+d.getTime(),
				type:	"GET",
				contentType: "application/xhtml+xml",
				beforeSend: function(){
					null;
				},
				error: function(objeto, quepaso, otroobj){
					alert('error'+quepaso+' '+otroobj+''+objeto);
				},
				success: function(objeto){
					var data = eval("(" + objeto + ")");

					if(data.Resultado.Estado == 'OK'){
						//alert(guardar_selecc_adjudica_ok);

						// Se tiene que seleccionar el radio button del documento padre, siempre y cuando este doc esté abierto
						try
						{
							window.opener.actualizarRadio(IDProdLic, IDOfertaLic);
						}
						catch(e)
						{
						}

						// Si existe el botón 'siguiente', automáticamente saltamos a la siguiente página
						//CUIDADO, con esta restricción no funciona if(jQuery('#botonProdSiguiente a').length){
						if(jQuery('#botonProdSiguiente').length){
							var href = jQuery('#botonProdSiguiente').attr('href');
							window.location.href = href;
						}
					}else{
						alert(guardar_selecc_adjudica_ko);
					}
				}
			});
		}
		else
		{
			//	Adjudicación múltiple			
			//solodebug
			console.log('adjudOfertas:'+adjudOfertas);

			jQuery.ajax({
				url:	"http://www.newco.dev.br/Gestion/Comercial/SeleccionarProductoMultipleAJAX.xsql",
				data:	"IDLIC="+IDLicitacion+"&IDPRODUCTOLIC="+IDProdLic+"&LISTA_OFERTAS="+encodeURIComponent(adjudOfertas)+"&IDMOTIVO="+IDMotivo+"&MOTIVO="+encodeURIComponent(Motivo)+"&_="+d.getTime(),
				type:	"GET",
				contentType: "application/xhtml+xml",
				beforeSend: function(){
					null;
				},
				error: function(objeto, quepaso, otroobj){
					alert('error'+quepaso+' '+otroobj+''+objeto);
				},
				success: function(objeto){
					var data = eval("(" + objeto + ")");

					if(data.Resultado.Estado == 'OK'){
						
						//solodebug	alert(guardar_selecc_adjudica_ok+':'+adjudOfertas);

						// Se tiene que actualizar el orden del documento padre, siempre y cuando este doc esté abierto
						try
						{
							//alert(window.opener.name);
							
							window.opener.actualizarAdjudicacionMultiple(IDProdLic, adjudOfertas);
							//alert('actualizarAdjudicacionMultiple OK');
							
							//window.opener.reload();
							
						}
						catch(e)
						{
							console.log(' no se ha podido ejecutar actualizarAdjudicacionMultiple');
						}

						// Si existe el botón 'siguiente', automáticamente saltamos a la siguiente página
						if(jQuery('#botonProdSiguiente').length){
							var href = jQuery('#botonProdSiguiente').attr('href');
							window.location.href = href;
						}
					}else{
						alert(guardar_selecc_adjudica_ko);
					}
				}
			});
			
		}

	}else{
		alert(msgError);
	}

}


// 25oct16 Al seleccionar una oferta, comprueba si es el precio mínimo
function SeleccionadaOferta (ID)
{
	var oform=document.forms["ProdLici"];
	
	//	Busca el precio actual
	gl_PrecioOfertaActual=parseFloat(oform.elements["Precio_"+ID].value.replace(",","."));
	
	//	Compara con el mejor precio
	if (gl_PrecioOfertaActual>gl_MejorPrecio)
		jQuery("#lMotivo").show();		
	else
		if (jQuery("#IDMOTIVOSELECCION").val()=="")
			jQuery("#lMotivo").hide();		
		
}


//	20abr17	catalogar ofertas, para facilitar al cliente lanzar pedidos
function CatalogarOferta(IDOfertaLic)
{

	if (!confirm(alrt_ConfirmCatalogarOferta)) return;

	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/CatalogarOfertaAJAX.xsql',
		type:	"POST",
		async:	false,
		data:	"LIC_ID="+IDLicitacion+"&IDPRODUCTOLIC="+IDProdLic+"&IDOFERTALIC="+IDOfertaLic+"&_="+d.getTime(),
		beforeSend: function(){
			jQuery('#btnCatalogo_'+IDOfertaLic).hide();
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.Resultado.Estado == 'OK'){
				alert(data.Resultado.Res);
			}else{
				alert(alrt_CatalogarOfertaKO);
				jQuery('#btnCatalogo_'+IDOfertaLic).show();
       	        return;
			}
		}
	});


}

//	4abr18 Descartar oferta, por no cumplir criterio de marca o similar
function DescartarOferta(IDOfertaLic)
{
	jQuery('#lMotivo_'+IDOfertaLic).show();
	jQuery('#btnDescartar_'+IDOfertaLic).hide();
}

function CancDescartarOferta(IDOfertaLic)
{
	jQuery('#lMotivo_'+IDOfertaLic).hide();
	jQuery('#btnDescartar_'+IDOfertaLic).show();
}


function EjecDescartarOferta(IDOfertaLic)
{

	var IDMotivo=jQuery("#IDMOTIVOSELECCION_"+IDOfertaLic).val();
	var Motivo=jQuery("#MOTIVOSELECCION_"+IDOfertaLic).val();

	if (IDMotivo=='')
	{
		msgError=alrt_RequiereMotivo;
	}

	if (!confirm(alrt_ConfirmDescartarOferta)) return;

	var d = new Date();


	//solodebug	alert("LIC_ID="+IDLicitacion+"&IDPRODUCTOLIC="+IDProdLic+"&IDOFERTALIC="+IDOfertaLic+"&IDMOTIVO="+IDMotivo+"&MOTIVO="+encodeURIComponent(Motivo));

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/DescartarOfertaAJAX.xsql',
		type:	"POST",
		async:	false,
		data:	"LIC_ID="+IDLicitacion+"&IDPRODUCTOLIC="+IDProdLic+"&IDOFERTALIC="+IDOfertaLic+"&IDMOTIVO="+IDMotivo+"&MOTIVO="+encodeURIComponent(Motivo)+"&_="+d.getTime(),
		beforeSend: function(){
			jQuery('#btnDescartar_'+IDOfertaLic).hide();
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.Resultado.Estado == 'OK'){
				
				//solodebug	alert(data.Resultado.Res);
				
				//	recarga la página principal y esta
				try
				{
					opener.location.reload();
				}
				catch(e)
				{
				}
				location.reload();
				
			}else{
				alert(alrt_DescartarOfertaKO);
				CancDescartarOferta(IDOfertaLic);
				//jQuery('#btnCatalogo_'+IDOfertaLic).show();
       	        return;
			}
		}
	});


}


//	2may18	Activa el botón de guardar cuando se detectan cambios en entradas de texto de ofertas (solo usuarios MVM)
function ActivarBotonGuardar(IDOferta)
{
	jQuery("#btnGuardar_"+IDOferta).show();
	jQuery("#btnDescartar_"+IDOferta).hide();
}


// Funcion para guardar los datos de una oferta del proveedor para una fila en concreto
// Traido desde lic_090418.js
function guardarOferta(IDOferta){
	// Validaciones
	var oForm = document.forms['ProdLici'];
	
	var enviarOferta = false;
	var controlPrecio = '';
	var errores = 0;


	// Validacion Precio
	var precio		= jQuery('#Precio_' + IDOferta).val()
	var precioFormat= precio.replace(",",".");

	if(!errores && esNulo(precioFormat)){
		errores++;
		alert(val_faltaPrecio.replace("[[REF]]",RefCliente));
		oForm.elements['Precio_' + IDOferta].focus();
		return false;
	}else if(!errores && isNaN(precioFormat)){
		errores++;
		alert(val_malPrecio.replace("[[REF]]",RefCliente));
		oForm.elements['Precio_' + IDOferta].focus();
	}

	if(!errores && precioFormat != 0){
		valAux	= (precioFormat != '') ? String(parseFloat(precioFormat).toFixed(4)).replace(".",",") : '';
		jQuery('#Precio_' + IDOferta).val( valAux );

		if(jQuery('#Desc_' + IDOferta).val() == str_SinOfertar){
			jQuery('#Desc_' + IDOferta).val('');
		}
		if(jQuery('#Marca_' + IDOferta).val() == str_SinOfertar){
			jQuery('#Marca_' + IDOferta).val('');
		}
	}

	// Validacion Unidades por Lote
	UdsXLote	= jQuery('#UdsLote_' + IDOferta).val();
	//if(!errores && esNulo(UdsXLoteFormat)){ DC - 23feb16 - Las unidades por lote en formato número entero
	if(!errores && esNulo(UdsXLote)){
		errores++;
		alert(val_faltaUnidades.replace("[[REF]]",RefCliente));
		oForm.elements['UdsLote_' + IDOferta].focus();
	//}else if(!errores && isNaN(UdsXLoteFormat)){ DC - 23feb16 - Las unidades por lote en formato número entero
	}else if(!errores && !esEntero(UdsXLote)){
		errores++;
		//alert(val_malUnidades.replace("[[REF]]",RefCliente));
		alert(val_malEnteroUnidades.replace("[[REF]]",RefCliente));
		oForm.elements['UdsLote_' + IDOferta].focus();
	//}else if(!errores && UdsXLoteFormat == 0 && precioFormat != 0){ DC - 23feb16 - Las unidades por lote en formato número entero
		}else if(!errores && UdsXLote == 0 && precioFormat != 0){
		errores++;
		alert(val_notZeroUnidades.replace("[[REF]]",RefCliente));
		oForm.elements['UdsLote_' + IDOferta].focus();
	}
/* DC - 23feb16 - Las unidades por lote en formato número entero
	if(!errores && UdsXLoteFormat != 0){
		valAux	= (UdsXLoteFormat != '') ? String(parseFloat(UdsXLoteFormat).toFixed(2)).replace(".",",") : '';
		jQuery('#UdsLote_' + IDOferta).val( valAux );
	}
*/
	if(IDPais != 55){
		// Validacion Ref.Proveedor
		valAux	= jQuery('#RefProv_' + IDOferta).val();
		//if(!errores && esNulo(valAux) && (precioFormat != 0 || UdsXLoteFormat != 0)){ DC - 23feb16 - Las unidades por lote en formato número entero
		if(!errores && esNulo(valAux) && (precioFormat != 0 || UdsXLote != 0)){
			errores++;
			alert(val_faltaRefProv.replace("[[REF]]",RefCliente));
			oForm.elements['RefProv_' + IDOferta].focus();
		//}else if(!errores && UdsXLoteFormat != 0){ DC - 23feb16 - Las unidades por lote en formato número entero
		}else if(!errores && UdsXLote != 0){
			// Comprobamos que no hayan escrito 2 Ref.Prov. iguales en la tabla
			jQuery("#lProductos_PROVE > tbody > tr.infoProds").each(function(){
				thisRowID2	= this.id;
				IDOferta2	= thisRowID2.replace('posArr_', '');
				RefCliente2	= (arrProductos[IDOferta2].RefCliente != '') ? arrProductos[IDOferta2].RefCliente : arrProductos[IDOferta2].RefEstandar;
				ProdNombre2	= arrProductos[IDOferta2].Nombre;

				valAux2		= jQuery('#RefProv_' + IDOferta2).val();
				if(IDOferta != IDOferta2 && valAux.toUpperCase() == valAux2.toUpperCase()){
					errores++;
					alert(val_igualesRefProv.replace("[[REFPROV]]", valAux).replace('[[nombreProducto]]', nombreProducto).replace('[[PRODNOMBRE2]]', ProdNombre2));
					oForm.elements['RefProv_' + IDOferta2].focus();
				}
			});

			// Tambien comprobamos que no exista previamente una Ref.Prov en el array de ofertas
			jQuery.each(arrProductos, function(key, producto){
				if(!errores && key != IDOferta && producto.Oferta.RefProv.toUpperCase() == valAux.toUpperCase()){
					ProdNombre2 = producto.Nombre;
					errores++;
					alert(val_igualesRefProv.replace("[[REFPROV]]", valAux).replace('[[nombreProducto]]', nombreProducto).replace('[[PRODNOMBRE2]]', ProdNombre2));
					oForm.elements['RefProv_' + IDOferta].focus();
				}
			});

		//}else if(!errores && precioFormat == 0 && UdsXLoteFormat == 0){ DC - 23feb16 - Las unidades por lote en formato número entero
		}else if(!errores && precioFormat == 0 && UdsXLote == 0){
			jQuery('#RefProv_' + IDOferta).val(str_SinOfertar.toUpperCase());
			jQuery('#Desc_' + IDOferta).val(str_SinOfertar.toUpperCase());
			jQuery('#Marca_' + IDOferta).val(str_SinOfertar.toUpperCase());
		}
	}

	// si los datos son correctos enviamos el form
	if(!errores && controlPrecio == ''){
		enviarOferta = true;
	}else{
		if(!errores && controlPrecio != ''){
			controlPrecio += conf_estaSeguro;
			var answer = confirm(controlPrecio);
			if(answer){
				//si clica ok envio form, implica que esta seguro no error
				enviarOferta = true;
			}
		}
	}

	if(enviarOferta)
	{
		var IDLicProv	= jQuery('#IDProveedorLic_' + IDOferta).val();
		var IDFicha = jQuery('#FT_' + IDOferta).val();
		var RefProv = jQuery('#RefProv_' + IDOferta).val();
		var Descripcion = encodeURIComponent(jQuery('#Desc_' + IDOferta).val());
		var Marca = encodeURIComponent(jQuery('#Marca_' + IDOferta).val());
		var UdsXLote = encodeURIComponent(jQuery('#UdsLote_' + IDOferta).val());
		var Precio = jQuery('#Precio_' + IDOferta).val();
		var Cantidad = jQuery('#Cant_' + IDOferta).val();
		var TipoIVA = jQuery('#TIVA_' + IDOferta).val();
		var d = new Date();

		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/AnadirUnaOfertaAJAX.xsql',
			type:	"GET",
			data:	"LIC_ID="+IDLicitacion+"&LIC_PROD_ID="+IDProdLic+"&LIC_PROV_ID="+IDLicProv+"&REFPROV="+RefProv+"&DESC="+Descripcion+"&MARCA="+Marca+"&UDSXLOTE="+UdsXLote+"&CANTIDAD="+Cantidad+"&PRECIO="+Precio+"&TIPOIVA="+TipoIVA+"&IDFICHA="+IDFicha+"&_="+d.getTime(),
			beforeSend: function(){
				jQuery("#btnGuardar_"+IDOferta).hide();
			},
			error: function(objeto, quepaso, otroobj){
				jQuery('#AVISOACCION_'+IDOferta).html('<img src="http://www.newco.dev.br/images/error.gif"/>');
				alert('error'+quepaso+' '+otroobj+' '+objeto);
			},
			success: function(objeto){
				var data = eval("(" + objeto + ")");

				if(data.OfertaActualizada.IDOferta > 0){
					jQuery('#AVISOACCION_'+IDOferta).html('<img src="http://www.newco.dev.br/images/recibido.gif"/>');
					if(data.OfertaActualizada.TodosInformados == 'Si'){
						location.reload();
					}
				}else{
					jQuery("#btnGuardar_"+IDOferta).hide();
					
					alert("Se ha producido un error.");
					
				}
			}
		});
	}

	//17set16	jQuery("#BtnActualizarOfertas").show();
	//17set16	jQuery(".guardarOferta").show();

}


//	6jul18 cambio en el orden de las adjudicaciones (para licitaciones multiopcion)
function cambioOrden(IDOferta)
{
	console.log('IDOferta:'+IDOferta+' orden:'+jQuery("#ORDEN_"+IDOferta).val());

	var oform=document.forms["ProdLici"];
	var Orden=parseInt(jQuery("#ORDEN_"+IDOferta).val());

	if (Orden==1)
	{
		//	Busca el precio actual
		var gl_PrecioOfertaActual=parseFloat(oform.elements["Precio_"+IDOferta].value.replace(",","."));

		//	Compara con el mejor precio
		if (gl_PrecioOfertaActual>gl_MejorPrecio)
			jQuery("#lMotivo").show();		
		else
		{
			jQuery("#IDMOTIVOSELECCION").val("")
			jQuery("#lMotivo").hide();
		}
		
	}
}


//	10jul18 Asigna el orden automatico a los desplegables (para licitaciones multiopcion)
function ordenAutomatico()
{
	jQuery("select").each(function()
	{
    	//solodebug	console.log('Nombre:'+jQuery(this).attr("name").substring(0,5));
		if (jQuery(this).attr("name").substring(0,5)=='ORDEN')
		{
			var Control=jQuery(this).attr("name");
			var ID=Piece(jQuery(this).attr("name"),'_',1);
			var Orden=jQuery('#CONT_'+ID).val();

        	//solodebug	
			console.log('Control:'+Control+' ID:'+ID+' Valor anterior:'+jQuery(this).val()+' Orden:'+Orden);

			
			jQuery(this).val(Orden);
		}
	});
}






