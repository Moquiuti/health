
// Función que valida los campos de los formularios antes de hacer el submit
function ValidarFormulario(oForm, IDEstado){
	if(IDEstado == 'NUEVA'){
		// Escondemos el botón de enviar
		jQuery('#BotonSubmit').hide();

		if(oForm.elements.SD_TITULO && oForm.elements.SD_TITULO.value === ''){
			oForm.elements.SD_TITULO.focus();
			alert(titulo_obligatorio);
			jQuery('#BotonSubmit').show();
			return;
		}

		if(oForm.elements.SD_REFCLIENTE && oForm.elements.SD_REFCLIENTE.value === ''){
			oForm.elements.SD_REFCLIENTE.focus();
			alert(refcliente_obligatorio);
			jQuery('#BotonSubmit').show();
			return;
		}

		if(oForm.elements.SD_PRODUCTO && oForm.elements.SD_PRODUCTO.value === ''){
			oForm.elements.SD_PRODUCTO.focus();
			alert(producto_obligatorio);
			jQuery('#BotonSubmit').show();
			return;
		}

		if(oForm.elements.SD_PRECIOUNITARIO && oForm.elements.SD_PRECIOUNITARIO.value === ''){
			oForm.elements.SD_PRECIOUNITARIO.focus();
			alert(precio_obligatorio);
			jQuery('#BotonSubmit').show();
			return;
		}else if(oForm.elements.SD_PRECIOUNITARIO){
			var precio = oForm.elements.SD_PRECIOUNITARIO.value.replace(',','.');

			if(!esNulo(precio) && isNaN(precio)){
				oForm.elements.SD_PRECIOUNITARIO.focus();
				alert(precio_error);
				jQuery('#BotonSubmit').show();
				return;
			}else{
				oForm.elements.SD_PRECIOUNITARIO.value = precio.replace('.',',');
			}
		}

		if(oForm.elements.SD_CANTIDAD && oForm.elements.SD_CANTIDAD.value === ''){
			oForm.elements.SD_CANTIDAD.focus();
			alert(cantidad_obligatorio);
			jQuery('#BotonSubmit').show();
			return;
		}else if(oForm.elements.SD_CANTIDAD){
			var cantidad = oForm.elements.SD_CANTIDAD.value;

			if(!(/^\+?[1-9]\d*$/.test(cantidad))){
				oForm.elements.SD_CANTIDAD.focus();
				alert(cantidad_error);
				jQuery('#BotonSubmit').show();
				return;
			}
		}

		if(oForm.elements.SD_FECHACADUCIDAD && oForm.elements.SD_FECHACADUCIDAD.value === ''){
			oForm.elements.SD_FECHACADUCIDAD.focus();
			alert(fecha_obligatorio);
			jQuery('#BotonSubmit').show();
			return;
		}else if(oForm.elements.SD_FECHACADUCIDAD && CheckDate(oForm.elements.SD_FECHACADUCIDAD.value)){
			oForm.elements.SD_FECHACADUCIDAD.focus();
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

		// Si no hay errores se envia el formulario
		oForm.target	= '_self';
		AsignarAccion(oForm,'http://www.newco.dev.br/Gestion/Comercial/StockDemandaSave.xsql');
		SubmitForm(oForm);
		return;
	}/*else if(IDEstado == 'D'){	// DIAGNOSTICO
		// Escondemos el boton de enviar
		jQuery('#BotonDIAG').hide();

		if(oForm.elements['SC_DIAGNOSTICO'] && oForm.elements['SC_DIAGNOSTICO'].value == ''){
			oForm.elements['SC_DIAGNOSTICO'].focus();
			alert(diagnostico_obligatorio);
			jQuery('#BotonDIAG').show();
			return;
		}

		// Si no hay errores se envia el formulario
		oForm.elements['SC_IDESTADO'].value = IDEstado;
		oForm.encoding	= 'application/x-www-form-urlencoded';
		oForm.target	= '_self';
		AsignarAccion(oForm,'http://www.newco.dev.br/Gestion/Comercial/SolicitudCatalogacionSave.xsql')
		SubmitForm(oForm);
		return;
	}else if(IDEstado == 'S'){	// PROPUESTA SOLUCION
		// Escondemos el botón de enviar
		jQuery('#BotonSOL').hide();

		if(oForm.elements['SC_SOLUCION'] && oForm.elements['SC_SOLUCION'].value == ''){
			oForm.elements['SC_SOLUCION'].focus();
			alert(solucion_obligatoria);
			jQuery('#BotonSOL').show();
			return;
		}

		// Si no hay errores se envia el formulario
		oForm.elements['SC_IDESTADO'].value = IDEstado;
		oForm.encoding	= 'application/x-www-form-urlencoded';
		oForm.target	= '_self';
		AsignarAccion(oForm,'http://www.newco.dev.br/Gestion/Comercial/SolicitudCatalogacionSave.xsql')
		SubmitForm(oForm);
		return;
	}else if(IDEstado == 'R'){	// RESUELTA
		// Escondemos el botón de enviar
		jQuery('#BotonRES').hide();

		if(oForm.elements['SC_SOLUCION'] && oForm.elements['SC_SOLUCION'].value == ''){
			oForm.elements['SC_SOLUCION'].focus();
			alert(solucion_obligatoria);
			jQuery('#BotonRES').show();
			return;
		}

		// Si no hay errores se envia el formulario
		oForm.elements['SC_IDESTADO'].value = IDEstado;
		oForm.encoding	= 'application/x-www-form-urlencoded';
		oForm.target	= '_self';
		AsignarAccion(oForm,'http://www.newco.dev.br/Gestion/Comercial/SolicitudCatalogacionSave.xsql')
		SubmitForm(oForm);
		return;
	}
*/
}

function BuscarStockDemandas(oForm){
	SubmitForm(oForm);
}

function NuevoStockDemanda(){
	MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/StockDemanda.xsql','Nueva demanda stock',100,100,0,0);
}

function BorrarDemandaStock(IDStockD){
	var d	= new Date();

	jQuery.ajax({
		url: 'http://www.newco.dev.br/Gestion/Comercial/StockDemandaBorrarAJAX.xsql',
		data: "SD_ID="+IDStockD+"&_="+d.getTime(),
		type: "GET",
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			jQuery("#StockDemandaBorradaOK").hide();
			jQuery("#StockDemandaBorradaKO").hide();
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.estado == 'OK'){
				jQuery("#StockDemandaBorradaOK").show();
				jQuery("#DEM_" + IDStockD).hide();
			}else
				jQuery("#StockDemandaBorradaKO").show();
			}
		});
}
