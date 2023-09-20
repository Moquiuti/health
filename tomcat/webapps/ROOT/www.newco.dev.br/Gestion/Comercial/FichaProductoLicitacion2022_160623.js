//	JS para la ficha de producto de la licitacion // pruebas de pedido para licitaciones multicentro
//	Ultima revision ET 16jun23 10:00 FichaProductoLicitacion2022_160623.js

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


function onloadEvents2()
{
	//solodebug console.log('onloadEvents2 2jun23 12:34. OfertasSeleccionadas:'+OfertasSeleccionadas()+' IDMOTIVOSELECCION:'+jQuery("#IDMOTIVOSELECCION").val());

	//	los "input radio" podrán desmarcarse
	jQuery('input[type=radio]').uncheckableRadio();
	
	//	SI no está informado, ocultamos la línea de motivos
	if ((jQuery("#IDMOTIVOSELECCION").val()=="")||(OfertasSeleccionadas()==0))
	{
		jQuery("#lMotivo").hide();		
	}

	//	29mar21
	if (LicAgregada=='S')
		ActualizarCentrosYProveedores();
	
	//	Marcamos el mejor precio (normalmente el primero)
	MarcarMejorPrecio();
	
	//	Calcula la cantidad pendiente de adjudicar
	CalculaCantidadPendiente();
	
	if(IDEstadoLicitacion == 'EST')
	{
		CambioPestannaVisible('lInfoCli');	
	}
	else
	{
		CambioPestannaVisible('lInfoProv');	
	}
	

	// Click en pestaña Info. Prov.
	jQuery("#pes_lInfoProv").click(function(){		
		CambioPestannaVisible('lInfoProv');	
	});

	// Click en pestaña Info. Cliente
	jQuery("#pes_lInfoCli").click(function(){
	
		//	Si han habido cambios en proveedores, y estamos en modo "agregado", avisa para actualizar
		if (CambiosProveedores=='S')
		{
			if (!confirm('Se han producido cambios en proveedores, ¿desea guardarlos y continuar?'))
				return;
			else
			{
				GuardarProductoSel(IDProdLic,'PROVEEDORES');
			}
		}	
		
		CambioPestannaVisible('lInfoCli');	
	});


	//	16jun23 Construimos la lista, poniendo la parte entera de las cantidades para informar el "title" de la programacion
	var v_ListaEntregas='';
	for (var i=0;i<=PieceCount(Entregas,'#');++i)		//	Cuidado, devuelve 0 aunque haya una programacion, por que no acaba con #
	{
		var Entrega=Piece(Entregas,'#',i);
		if (Entrega!='')
			v_ListaEntregas+=Piece(Entrega,'|',0)+':'+Piece(Piece(Entrega,'|',1),'.',0);	//	6jun23 Cortamos punto decimal
	}
	jQuery("#ImgEntregas").prop('title',str_ProgEntregas+': '+v_ListaEntregas);


}


//	14jul22 Vuelve a la licitacion en el producto seleccionado
function VolverLicitacion()
{
	chLicPorProducto(IDLicitacion, IDProdLic);
}

//	14jul22 Vuelve a Vencedores
function VolverVencedores()
{
	chVencedores(IDLicitacion, IDProdLic);
}


//	Separamos la función de cambio de pestañas del propio evento
function CambioPestannaVisible(Activa)
{
	//solodebug console.log('CambioPestannaVisible:'+Activa);

	if (Activa=='lInfoProv')
	{
		jQuery("#pes_lInfoProv").css('background','#3b569b');
		jQuery("#pes_lInfoProv").css('color','#D6D6D6');
		jQuery("#pes_lInfoCli").css('background','#E6E6E6');
		jQuery("#pes_lInfoCli").css('color','#555555');
		jQuery("#lInfoProv").show();
		jQuery("#lInfoCli").hide();
	}
	else
	{
		jQuery("#pes_lInfoCli").css('background','#3b569b');
		jQuery("#pes_lInfoCli").css('color','#D6D6D6');
		jQuery("#pes_lInfoProv").css('background','#E6E6E6');
		jQuery("#pes_lInfoProv").css('color','#555555');
		jQuery("#lInfoProv").hide();
		jQuery("#lInfoCli").show();
	}
}

function MarcarMejorPrecio()
{
	if(IDEstadoLicitacion == 'CURS' || IDEstadoLicitacion == 'INF'){
		gl_MejorPrecio		= -1;
		var MejorOfertaID	= 0;

		// Para cada una de las celdas con class 'PrecioOferta'
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

function GuardarDatosProducto(){
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
		//2ago22	valAux	= jQuery('#PrecioObjIVA').val().replace(",",".");
		valAux	= desformateaDivisa(jQuery('#PrecioObjIVA').val());

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
		//2ago22	valAux	= jQuery('#PrecioObj').val().replace(",",".");
		valAux	= desformateaDivisa(jQuery('#PrecioObj').val());

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
	//2ago22	valAux	= jQuery('#Cantidad').val().replace(",",".");
	valAux	= desformateaDivisa(jQuery('#Cantidad').val());

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
	var nuevaCant=parseInt(jQuery('#Cantidad').val());

	listaProductos = IDProdLic + '|' +		//p_IDProductoEstandar
		jQuery('#UdBasica').val() + '|' +	//p_UnidadBasica
		nuevaCant + '|' +	//p_Cantidad
		jQuery('#PrecioRef').val() + '|' +	//p_PrecioReferencia
		jQuery('#PrecioObj').val();		//p_PrecioObjetivo

	//	28jun19 Si hay cambios en la cantidad, actualiza también las ofertas adjudicadas
	if (CantidadTotal!=nuevaCant)
	{
		//	Recorre las ofertas, comprobando cual es la que tiene mayor cantidad adjudicada
		var IDOfeAdj='', ValorMax=-1, NumAdj=0;
		//jQuery("table#lDatosOfertas").find("tbody").find("tr").each(function(){
		jQuery("table#lDatosOfertas").find("tr.filaOferta").each(function(){

			var ID	= this.id.replace("OFE_","");
			
			//solodebug	console.log('ActualizarProducto. Comprobando ID:'+ID);
			
			if (jQuery("#ADJUD_"+ID).prop("checked"))
			{
				++NumAdj;
			
				//solodebug	console.log('ActualizarProducto. Comprobando ID:'+ID+' -> checked. NumAdj:'+NumAdj);
			
				var Cantidad=parseFloat(jQuery("#CANTADJUD_"+ID).val().replace(",","."));		//5may23 no utilizamos la variable local, si no la global
				if (Cantidad>ValorMax)
				{
					ValorMax=Cantidad;
					IDOfeAdj=ID;
			
					//solodebug	console.log('ActualizarProducto. Comprobando ID:'+ID+' -> checked. '+Cantidad+'>'+ValorMax+' NumAdj:'+NumAdj);
			
				}
			}
		});
		
		if (IDOfeAdj!='')
		{
			
			//solodebug	console.log('ActualizarProducto. Asignando IDOfeAdj:'+IDOfeAdj);
			
			jQuery("#CANTADJUD_"+IDOfeAdj).val((NumAdj==1)?nuevaCant:(ValorMax+nuevaCant-CantidadTotal));
		}
	
	}
	CantidadTotal=nuevaCant;

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
				jQuery("#botonGuardarDatosProd").show();
				/*	
				
				5may23	Evitamos recargar todo
				
				try
				{
					opener.location.reload();
				}
				catch(e)
				{
				}
				location.reload();*/
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

	//jQuery("table#lDatosOfertas").find("tbody").find("tr").each(function(){
	jQuery("table#lDatosOfertas").find("tr.filaOferta").each(function(){
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

	//jQuery("table#lDatosOfertas").find("tbody").find("tr").each(function(){
	jQuery("table#lDatosOfertas").find("tr.filaOferta").each(function(){
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



// Funcion para guardar la cantidad de compra de un centro para un producto
function guardarDatosCompraCentro(IDCentro){
	// Validaciones
	var oform=document.forms["cantidadPorCentro"];
	
	var errores = 0;

	//jQuery("#BtnActualizarOfertas").hide();
	//jQuery("img .guardarOferta").hide();
	//alert("("+oForm.elements['Marca_' + thisPosArr].value+")");

	// Validacion Cantidad
	var cantidad	= oform['Cantidad_'+IDCentro].value;
	var cantidadFormat	= cantidad.replace(",",".");
	if(!errores && esNulo(cantidadFormat)){
		errores++;
		alert(val_faltaCantidad.replace("[[REF]]",RefCliente));
		return;
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
				//jQuery("#BtnActualizarOfertas").hide();
				jQuery(".cantidad").hide();
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

	//jQuery("#BtnActualizarOfertas").show();
	jQuery(".cantidad").show();

}


// Funcion para guardar la cantidad de compra de un centro a un proveedor
function guardarDatosCompraCentroYProv(IDCentro, IDOfertaLic, IDProveedorLic){
	// Validaciones
	var oform=document.forms["cantidadPorCentro"], cantidades='';
	
	var errores = 0;

	//jQuery("#BtnActualizarOfertas").hide();
	//jQuery("img .guardarOferta").hide();
	//alert("("+oForm.elements['Marca_' + thisPosArr].value+")");

	// Validacion Cantidad
	/*var cantidad	= oform['Cantidad_'+IDCentro+'_'+IDProveedorLic].value;
	var cantidadFormat	= cantidad.replace(",",".");
	if(!errores && esNulo(cantidadFormat)){
		errores++;
		alert(val_faltaCantidad.replace("[[REF]]",RefCliente));
		return;
	}else if(!errores && isNaN(cantidadFormat)){
		errores++;
		alert(val_malCantidad.replace("[[REF]]",RefCliente));
	}*/
	
	//	Comprueba que no se supere la cantidad a nivel de centro
	var PosCentro=-1;
	for (i=0;(i<arrCentros.length)&&(PosCentro==-1);++i)
	{
		if (arrCentros[i].IDCentro==IDCentro) PosCentro=i;
	}
	
	var Total=0;

	debug('guardarDatosCompraCentroYProv('+IDCentro+','+IDOfertaLic+','+IDProveedorLic+'). NumProv:'+arrCentros[PosCentro].Proveedores.length);

	for (i=0;(i<arrCentros[PosCentro].Proveedores.length);++i)
	{
		//if (arrCentros[PosCentro].Proveedores[i].IDProveedorLic!=IDProveedorLic) Total+=arrCentros[PosCentro].Proveedores[i].CantidadSF;
		var cantidadTxt	= oform['Cantidad_'+IDCentro+'_'+arrCentros[PosCentro].Proveedores[i].IDOfertaLic].value;
		var cantidadFormat	= cantidadTxt.replace(",",".");
		if(!errores && esNulo(cantidadFormat)){
			errores++;
			alert(arrCentros[PosCentro].Nombre+','+arrCentros[PosCentro].Proveedores[i].Nombre+':'+val_faltaCantidad.replace("[[REF]]",RefCliente));
			return;
		}else if(!errores && isNaN(cantidadFormat)){
			errores++;
			alert(arrCentros[PosCentro].Nombre+','+arrCentros[PosCentro].Proveedores[i].Nombre+':'+val_malCantidad.replace("[[REF]]",RefCliente));
			return;
		}
		
		var cantidad=parseInt(cantidadTxt);
		
		if (cantidad%arrCentros[PosCentro].Proveedores[i].UdesLote!=0)
		{
			errores++;
			
			var nuevaCantidad=arrCentros[PosCentro].Proveedores[i].UdesLote*Math.ceil(cantidad/arrCentros[PosCentro].Proveedores[i].UdesLote);
			
			alert(arrCentros[PosCentro].Nombre+','+arrCentros[PosCentro].Proveedores[i].Nombre+': La cantidad '+cantidad
					+' no corresponde al empaquetamiento:'+arrCentros[PosCentro].Proveedores[i].UdesLote
					+' cantidad corregida:'+nuevaCantidad);
			
			oform['Cantidad_'+IDCentro+'_'+arrCentros[PosCentro].Proveedores[i].IDOfertaLic].value=nuevaCantidad;
			return;
		}
		
		
		arrCentros[PosCentro].Proveedores[i].Cantidad=cantidadTxt;
		arrCentros[PosCentro].Proveedores[i].CantidadSF=cantidad;
		
		Total+=cantidad;
		cantidades+=arrCentros[PosCentro].Proveedores[i].IDProvLic+'|'+arrCentros[PosCentro].Proveedores[i].IDOfertaLic+'|'+arrCentros[PosCentro].Proveedores[i].Cantidad+'#';
		
		debug('guardarDatosCompraCentroYProv('+i+'). text:'+oform['Cantidad_'+IDCentro+'_'+arrCentros[PosCentro].Proveedores[i].IDOfertaLic].value+' Total:'+Total+' listacantidades:'+cantidades);
		
	}
	
	if (Total>arrCentros[PosCentro].CantidadSF)
	{
		alert('La cantidad '+Total+ ' asignada a proveedores supera la cantidad total del centro:'+arrCentros[PosCentro].Cantidad)
		errores++;
	}

	if (Total<arrCentros[PosCentro].CantidadSF)
	{
		alert('La cantidad '+Total+ ' asignada a proveedores no cubre la cantidad total del centro:'+arrCentros[PosCentro].Cantidad)
		errores++;
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
			url:	'http://www.newco.dev.br/Gestion/Comercial/InformarDatosCompraCentroYProvAJAX.xsql',
			type:	"GET",
			//data:	"LIC_ID="+IDLicitacion+"&LIC_PROD_ID="+IDProdLic+"&IDCENTRO="+IDCentro+"&IDPROVEEDOR="+IDProveedorLic+"&CANTIDAD="+cantidad+"&_="+d.getTime(),
			data:	"LIC_ID="+IDLicitacion+"&LIC_PROD_ID="+IDProdLic+"&IDCENTRO="+IDCentro+"&CANTIDADES="+encodeURIComponent(cantidades)+"&_="+d.getTime(),
			beforeSend: function(){
				//jQuery("#BtnActualizarOfertas").hide();
				jQuery(".cantidad").hide();
			},
			error: function(objeto, quepaso, otroobj){
				jQuery('#Resultado_'+IDCentro+'_'+IDOfertaLic).html('<img src="http://www.newco.dev.br/images/error.gif"/>');
				alert('error'+quepaso+' '+otroobj+' '+objeto);
			},
			success: function(objeto){
				var data = eval("(" + objeto + ")");

				if(data.OfertaActualizada.Estado =='OK'){
					jQuery('#Resultado_'+IDCentro+'_'+IDOfertaLic).html('<img src="http://www.newco.dev.br/images/recibido.gif"/>');
					ActualizarCentrosYProveedores();
					//	7set16	Recargamos los datos, también hay que recargar la página principal
					/*location.reload();
					try
					{
						opener.location.reload();
					}
					catch(e)
					{
					}*/
				}else{
					jQuery('#Resultado_'+IDCentro+'_'+IDOfertaLic).html('<img src="http://www.newco.dev.br/images/error.gif"/>');
				}
			}
		});
	}

	//jQuery("#BtnActualizarOfertas").show();
	//jQuery(".cantidad").show();

}



// Guarda la selección para la oferta de un unico producto. Copiado desde lic_170916
function GuardarProductoSel(IDProdLic, Accion){
	var d = new Date();
	var msgError ='';

	// Busco el radio button seleccionado
	//15may19	var IDOfertaLic = (jQuery("input[type='radio'][name='ADJUD_" + IDProdLic + "']:checked").val() !== undefined) ? jQuery("input[type='radio'][name='ADJUD_" + IDProdLic + "']:checked").val() : '';

	var IDOfertaLic = IDOfertaSeleccionada();

	var IDMotivo=jQuery("#IDMOTIVOSELECCION").val();
	var Motivo=jQuery("#MOTIVOSELECCION").val();
	
	var adjudOfertas='',multOfertas='', cantAdjud=0;

	if ((MostrarMotivoSeleccion=='S')&&(gl_PrecioOfertaActual>gl_MejorPrecio)&&(IDOfertaLic!='')&&(IDMotivo=='')){				// 2jun23 Unicamente si esta seleccionado el producto
		msgError=alrt_RequiereMotivo;
	}

	
	//solodebug
	debug('GuardarProductoSel. LicMultiOpcion:'+LicMultiOpcion+' OfertasSeleccionadas:'+OfertasSeleccionadas());
	
	
	if (LicMultiOpcion=='S')
	{
		var Inform='N', opcion1='N';
		jQuery("select").each(function()
		{
        	//solodebug	
			console.log('Nombre:'+jQuery(this).attr("name").substring(0,5));
			
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

        	    //solodebug	
				console.log('Valor:'+jQuery(this).val()+' Inform:'+Inform+' opcion1:'+opcion1+' lista adj:'+adjudOfertas);
			}
        });
	
		//	11jul18 Opcion1 no obligatoria
		//if ((Inform=='S')&&(opcion1=='N'))
		//	msgError=alrt_RequiereOpcion1;
	}
	else if (OfertasSeleccionadas()>1)
	{
        //solodebug	
		console.log ('OfertasSeleccionadas>1');

		jQuery("input[name*='CANTADJUD_']").each(function(){

			var Cantidad=parseFloat(jQuery(this).val().replace(",","."));

			var ID=Piece(jQuery(this).attr("name"),'_',1);

			//solodebug	
			console.log('CalculaCantidadPendiente. Comprobando ID:'+ID+' Cantidad:'+Cantidad+' checked:'+jQuery("#ADJUD_"+ID).prop("checked"));

			if (jQuery("#ADJUD_"+ID).prop("checked"))
			{
				cantAdjud+=Cantidad;
				multOfertas+=ID+'#'+Cantidad+'|';

				//solodebug	
				console.log('OfertasSeleccionadas. Comprobando ID:'+ID+' multOfertas:'+multOfertas);
			}
		});

		//solodebug	
		console.log('OfertasSeleccionadas. multOfertas:'+multOfertas+ 'cantAdjud:'+cantAdjud+'CantidadTotal:'+CantidadTotal);
		
		if (cantAdjud<CantidadTotal) msgError=alrt_CantidadInfTotal;
		if (cantAdjud>CantidadTotal) msgError=alrt_CantidadSupTotal;
		
		
		//	5may21 SI esta correcto a nivel de proveedores, revisa las opciones a nivel de centros/proveedores
		if ((msgError=='')&&(LicAgregada=='S'))
			msgError=CompruebaCantidadCentrosProv();
		
	
	}

	//2jun23 Ya no solicitamos confirmacion al guardar producto sin oferta seleccionada, ya que el guardado es automatico
	//2jun23 if ((IDOfertaLic=='')&&(multOfertas=='')&&(adjudOfertas=='')&&(!confirm(alrt_NoHaSeleccionadoOferta)))		//	30nov18	Solicitamos confirmación antes de guardar producto sin oferta seleccionada
	//2jun23 	return;
	
	//solodebug	alert("IDLIC="+IDLicitacion+"&IDPRODUCTOLIC="+IDProdLic+"&IDOFERTA="+IDOfertaLic+"&IDMOTIVO="+IDMotivo+"&MOTIVO="+encodeURIComponent(Motivo));

	//solodebug	
	console.log('OfertasSeleccionadas. LicMultiOpcion:'+LicMultiOpcion+' multOfertas:'+multOfertas+ 'cantAdjud:'+cantAdjud+'CantidadTotal:'+CantidadTotal);
	
	if(msgError == '')
	{
		if ((LicMultiOpcion!='S')&&(multOfertas==''))
		{			

			//solodebug	
			console.log('OfertasSeleccionadas. LicMultiOpcion:'+LicMultiOpcion+' multOfertas:'+multOfertas+ 'cantAdjud:'+cantAdjud+'CantidadTotal:'+CantidadTotal+' -> Adjudicación única');

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
							//	ESTA LLAMADA RALENTIZA MUCHO EN LICITACIONES GRANDES
							//	SI la licitación tiene más de 100 productos, no se recalculan los totales en la matriz
							if (NumLineas<100) 
								window.opener.actualizarRadio(IDProdLic, IDOfertaLic, 'S');
							else
								window.opener.actualizarRadio(IDProdLic, IDOfertaLic, 'N');
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
			if ((LicMultiOpcion!='S')&&(multOfertas!=''))
			{

				//solodebug	
				console.log('OfertasSeleccionadas. LicMultiOpcion:'+LicMultiOpcion+' multOfertas:'+multOfertas+ 'cantAdjud:'+cantAdjud+'CantidadTotal:'+CantidadTotal+' -> Adjudicación repartida');

				//	Cantidad repartida entre varios proveedores			
				console.log('multOfertas:'+multOfertas);

				jQuery.ajax({
					url:	"http://www.newco.dev.br/Gestion/Comercial/SeleccionarProductoRepartidoAJAX.xsql",
					data:	"IDLIC="+IDLicitacion+"&IDPRODUCTOLIC="+IDProdLic+"&LISTA_OFERTAS="+encodeURIComponent(multOfertas)+"&IDMOTIVO="+IDMotivo+"&MOTIVO="+encodeURIComponent(Motivo)+"&_="+d.getTime(),
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
								//	ESTA LLAMADA RALENTIZA MUCHO EN LICITACIONES GRANDES
								//	SI la licitación tiene más de 100 productos, no se recalculan los totales en la matriz
								/*if (NumLineas<100)
									window.opener.actualizarRadio(IDProdLic, IDOfertaLic, 'S');
								else
									window.opener.actualizarRadio(IDProdLic, IDOfertaLic, 'N');

								window.opener.dibujaTablaProductosOFE();
								*/
								window.opener.informaCantidades(IDProdLic, multOfertas, 'S');
							}
							catch(e)
							{
								console.log(' no se ha podido ejecutar actualizarAdjudicacionMultiple');
							}

							// Si existe el botón 'siguiente', automáticamente saltamos a la siguiente página
							//13abr21 Si la accion es SIGUIENTE pasamos al siguiente... if(jQuery('#botonProdSiguiente').length){
							if((Accion=='SIGUIENTE')&&(href!=undefined))	//17nov21 Si es el ultimo registro, no pasa al siguiente
							{
								var href = jQuery('#botonProdSiguiente').attr('href');
								window.location.href = href;
							}
							//13abr21 Si la accion es PROVEEDORES recuperamos los datos de los proveedores para mostrar la tabla
							if(Accion=='PROVEEDORES')
							{
								ProveedoresAdjudicadosAJAX();
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

				//solodebug	console.log('OfertasSeleccionadas. LicMultiOpcion:'+LicMultiOpcion+' multOfertas:'+multOfertas+ 'cantAdjud:'+cantAdjud+'CantidadTotal:'+CantidadTotal+' -> Adjudicación multiple');

				//solodebug	console.log('adjudOfertas:'+adjudOfertas);

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
		}

	}else{
		alert(msgError);
	}

}


//	15may19 Busca el ID de la oferta seleccionada
function IDOfertaSeleccionada()
{
	var IDOferta='';
	jQuery("input[name*='ADJUD_']").each(function(){
	
		//solodebug	console.log('IDOfertaSeleccionada. Comprobando name:'+jQuery(this).attr("name")+' checked:'+jQuery(this).prop("checked"));

		if (jQuery(this).prop("checked"))
			IDOferta=Piece(jQuery(this).attr("name"),'_',1);

	});
	
	//solodebug	console.log('IDOfertaSeleccionada. IDOferta:'+IDOferta);
		
	return IDOferta;
}


// 25oct16 Al seleccionar una oferta, comprueba si es el precio mínimo
function SeleccionadaOferta (ID)
{
	var oform=document.forms["ProdLici"];
	var CantidadActual;
	var PosOfe=BuscaEnArray(arrOfertas,'IDOferta', ID);
	
	//	13abr21 Marca el cambio a nivel de adjudicaciones, para avisar antes de salir
	CambiosProveedores='S';
	
	//	Busca el precio actual
	gl_PrecioOfertaActual=parseFloat(oform.elements["Precio_"+ID].value.replace(",","."));
	
	//solodebug console.log('SeleccionadaOferta: ID:'+ID+' PrecioOfertaActual:'+gl_PrecioOfertaActual+' MejorPrecio:'+gl_MejorPrecio+' CantidadPendiente:'+CantidadPendiente+ ' #ADJUD_'+ID+' checked:'+jQuery("#ADJUD_"+ID).prop("checked"));
	
	//	Compara con el mejor precio
	if ((MostrarMotivoSeleccion=='S')&&(gl_PrecioOfertaActual>gl_MejorPrecio))
		jQuery("#lMotivo").show();		
	else
	{
		//7nov19	if (jQuery("#IDMOTIVOSELECCION").val()=="")
		jQuery("#IDMOTIVOSELECCION").val("");			//	7nov19	Reinicializamos el desplegable
		jQuery("#lMotivo").hide();
	}

	if ((LicMultiOpcion=='S')||((MesesDuracion==0)&&(LicAgregada=='N')))	//	16dic19 Faltaba incluir la opción de SPOT	// 27ago20 Pero no para agregadas
	{
	
		//solodebug	console.log('SeleccionadaOferta: ID'+ID+' LicMultiOpcion:'+LicMultiOpcion+' MesesDuracion:'+MesesDuracion);

		if (jQuery("#ADJUD_"+ID).prop("checked"))
		{
			//solodebug	console.log('SeleccionadaOferta: ID'+ID+' actual:CHECKED. CantidadPendiente:'+CantidadPendiente);
			
			CantidadActual=CantidadPendiente;
			if (CantidadPendiente>0)
			{
				//solodebug	console.log('SeleccionadaOferta: ID'+ID+' PrecioOfertaActual:'+gl_PrecioOfertaActual+' MejorPrecio:'+gl_MejorPrecio+' CantidadPendiente:'+CantidadPendiente+' CHECKED');

				jQuery("#CANTADJUD_"+ID).val(CantidadPendiente);

				arrOfertas[PosOfe].CantAdjudicada=CantidadPendiente;		//1jun23
				arrOfertas[PosOfe].OfertaAdjud='S';							//1jun23

				//solodebug	CalculaCantidadPendiente();
				CantidadPendiente=0;
			}
			else
			{
				//solodebug	console.log('SeleccionadaOferta: ID'+ID+' PrecioOfertaActual:'+gl_PrecioOfertaActual+' MejorPrecio:'+gl_MejorPrecio+' CantidadPendiente:'+CantidadPendiente+' CHECKED');

				jQuery("#ADJUD_"+ID).prop("checked",false);

				arrOfertas[PosOfe].CantAdjudicada=0;		//2jun23
				arrOfertas[PosOfe].OfertaAdjud='N';			//2jun23


			}
		}
		else
		{
			//solodebug	console.log('SeleccionadaOferta: ID'+ID+' PrecioOfertaActual:'+gl_PrecioOfertaActual+' MejorPrecio:'+gl_MejorPrecio+' CantidadPendiente:'+CantidadPendiente+' UNCHECKED');

			CantidadActual=0;
			jQuery("#CANTADJUD_"+ID).val('');

			arrOfertas[PosOfe].CantAdjudicada=0;		//2jun23
			arrOfertas[PosOfe].OfertaAdjud='N';			//2jun23

			CalculaCantidadPendiente();
		}
		
		jQuery("#Consumo_"+ID).html(String((gl_PrecioOfertaActual*CantidadActual).toFixed(2)));	
	}
	else
	{
		//solodebug	console.log('SeleccionadaOferta: ID. '+ID+' NO multiopcion');
	
		//	Si no es multiopción, desmarca el resto de opciones
		//jQuery("table#lDatosOfertas").find("tr.filaOferta").each(function(){
		jQuery(".ADJUD").each(function(){		//	PENDIENTE PROBAR ESTO; PARECE MAS EFICIENTE
			//IDOferta	= this.id.replace("OFE_","");
			IDOferta	= this.id.replace("ADJUD_","");

			//solodebug	console.log('SeleccionadaOferta: ID:'+ID+' Comprobando IDOferta:'+IDOferta+' checked:'+jQuery("#ADJUD_"+IDOferta).prop("checked"))

			if ((ID!=IDOferta)&&(jQuery("#ADJUD_"+IDOferta).prop("checked")))
			{

				//solodebug	console.log('SeleccionadaOferta: ID:'+ID+' Comprobando IDOferta:'+IDOferta+' UNCHECK')

				jQuery("#ADJUD_"+IDOferta).prop("checked",false);
				
				arrOfertas[PosOfe].CantAdjudicada=0;		//2jun23
				arrOfertas[PosOfe].OfertaAdjud='N';			//2jun23
			}
		});

	}

	//	29mar21
	if (LicAgregada=='S')
		ActualizarCentrosYProveedores();

	//	1jun23 Guarda la seleccion, sin avisar de errores
	GuardarProductoSel(IDProdLic,'N');
	
	//	1jun23 En el caso de cambio de la cantidad, actualiza los datos del producto
	RevisaCambiosCantidad();
	
}

//	15may19 al cambiar la cantidad, comprobamos como quedan las cantidades
function chCantidadAdjudicada (ID)
{
	var Cantidad=0;
	var oform=document.forms["ProdLici"];
	var PosOfe=BuscaEnArray(arrOfertas,'IDOferta', ID);

	//solodebug
	console.log('chCantidadAdjudicada. Comprobando ID:'+ID+' PosOfe:'+PosOfe);
	
	//	13abr21 Marca el cambio a nivel de adjudicaciones, para avisar antes de salir
	CambiosProveedores='S';
	
	//	Busca el precio actual
	gl_PrecioOfertaActual=parseFloat(oform.elements["PrecioOriginal_"+ID].value.replace(",","."));

	var CantTxt=jQuery('#CANTADJUD_'+ID).val();
	
	if ((CantTxt=='')||(!jQuery.isNumeric(CantTxt)))
	{
		jQuery('#CANTADJUD_'+ID).val('');
		jQuery("#ADJUD_"+ID).prop("checked",false);	

		arrOfertas[PosOfe].CantAdjudicada=0;		//1jun23
		arrOfertas[PosOfe].OfertaAdjud='N';		//1jun23
	
		CalculaCantidadPendiente();
		Cantidad=0;
	}
	else
	{

		jQuery("#ADJUD_"+ID).prop("checked",true);

		//	Comprueba que la cantidad pendiente sea correcta
		Cantidad=parseInt(CantTxt.replace(",","."));

		//solodebug
		console.log('chCantidadAdjudicada. Comprobando ID:'+ID+' Cantidad:'+Cantidad);

		if (Cantidad<0) Cantidad=0;
		
		//	9abr21 Control del empaquetamiento
		var UdsLote=parseInt(jQuery("#UdsLote_"+ID).val());
		
		if (Cantidad%UdsLote!=0)
		{
			var nuevaCantidad=UdsLote*Math.ceil(Cantidad/UdsLote);
			/*alert('La cantidad '+Cantidad
					+' no corresponde al empaquetamiento:'+UdsLote
					+' cantidad corregida:'+nuevaCantidad);*/
					
			alert(alrt_CantidadNoCorresponde.replace('[[CANTIDAD]]',Cantidad).replace('[[UNIDADESPORLOTE]]',UdsLote).replace('[[CANTIDADCORREGIDA]]',nuevaCantidad));
			Cantidad=nuevaCantidad;
		}

		//solodebug
		console.log('chCantidadAdjudicada. Asignando ID:'+ID+' Cantidad:'+Cantidad);
		
		jQuery('#CANTADJUD_'+ID).val(Cantidad);

		arrOfertas[PosOfe].CantAdjudicada=Cantidad;		//1jun23
		arrOfertas[PosOfe].OfertaAdjud='S';				//1jun23

		//	Recalcula la cantidad pendiente	
		CalculaCantidadPendiente();

		//	Corrige si hemos sobrepasado el total
		if (CantidadPendiente<0) 
		{
			Cantidad+=CantidadPendiente;
			
			alert("Superada la cantidad total de producto, nueva cantidad:"+Cantidad);

			
			CalculaCantidadPendiente();
			if (Cantidad>0 )
			{
				jQuery('#CANTADJUD_'+ID).val(Cantidad);
			}
			else	
			{
				//	Quita la marca de adjudicación
				jQuery('#CANTADJUD_'+ID).val('');
				jQuery("#ADJUD_"+ID).prop("checked",false);
				CantidadPendiente=0;
			}
		}
	}

	jQuery("#Consumo_"+ID).html(String((gl_PrecioOfertaActual*Cantidad).toFixed(2)));
	
	//	29mar21
	if (LicAgregada=='S')
		ActualizarCentrosYProveedores();

	//	1jun23 Guarda la seleccion, sin avisar de errores
	GuardarProductoSel(IDProdLic,'N');
	
	//	1jun23 En el caso de cambio de la cantidad, actualiza los datos del producto
	RevisaCambiosCantidad();

}


//	15may19 Recalcula la cantidad pendiente
function CalculaCantidadPendiente()
{
	//solodebug	console.log('CalculaCantidadPendiente. CantidadTotal:'+CantidadTotal);

	CantidadPendiente=CantidadTotal;
	jQuery("input[name*='CANTADJUD_']").each(function(){

		var Cantidad=parseFloat(jQuery(this).val().replace(",","."));
		
		var ID=Piece(jQuery(this).attr("name"),'_',1);
		
		//solodebug	console.log('CalculaCantidadPendiente. Comprobando ID:'+ID+' Cantidad:'+Cantidad+' checked:'+jQuery("#ADJUD_"+ID).prop("checked"));
		
		if (jQuery("#ADJUD_"+ID).prop("checked"))
		{
			CantidadPendiente-=Cantidad;
		
			//solodebug	console.log('CalculaCantidadPendiente. Comprobando ID:'+ID+' CantidadPendiente:'+CantidadPendiente);
		}
	});
	
	//solodebug	console.log('CalculaCantidadPendiente. CantidadPendiente:'+CantidadPendiente);
}



//	15may19 Recalcula la cantidad pendiente
function OfertasSeleccionadas()
{
	var OfertasSel=0;

	jQuery("input[name*='CANTADJUD_']").each(function(){

		var ID=Piece(jQuery(this).attr("name"),'_',1);
		
		//solodebug	console.log('OfertasSeleccionadas. Comprobando ID:'+ID+' Cantidad:'+Cantidad+' checked:'+jQuery("#ADJUD_"+ID).prop("checked"));
		
		if (jQuery("#ADJUD_"+ID).prop("checked"))
		{
			++OfertasSel;
		
			//solodebug	console.log('OfertasSeleccionadas. Comprobando ID:'+ID+' OfertasSel:'+OfertasSel);
		}
	});

	//solodebug	
	console.log('OfertasSeleccionadas. OfertasSel:'+OfertasSel);
	
	return OfertasSel;
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
				location.reload();
			}else{
				alert(alrt_CatalogarOfertaKO);
				jQuery('#btnCatalogo_'+IDOfertaLic).show();
       	        return;
			}
		}
	});


}

//	12jul19 Lanzar directamente pedido desde oferta
function Pedido(IDOfertaLic)
{

	//	Comprobar si existen pedidos al proveedor
	var IDProveedorLic=jQuery("#IDProveedorLic_"+IDOfertaLic).val(),
		Proveedor=jQuery("#Proveedor_"+IDOfertaLic).val(),
		IDMultioferta=jQuery("#MO_ID_"+IDOfertaLic).val(),
		IDEstadoMO=jQuery("#MO_STATUS_"+IDOfertaLic).val(),
		//27jul22 PedMinimo=parseFloat(jQuery("#PEDMINIMO_"+IDOfertaLic).val().replace('PUNTO','').replace(',','.')),
		PedMinimo=desformateaDivisa(jQuery("#PEDMINIMO_"+IDOfertaLic).val()),
		//27jul22 Consumo=parseFloat(jQuery("#CONSUMO_"+IDOfertaLic).val().replace('PUNTO','').replace(',','.')),
		Consumo=desformateaDivisa(jQuery("#CONSUMO_"+IDOfertaLic).val()),
		CodPedido=jQuery("#CODPEDIDO_"+IDOfertaLic).val(),
		UdesLote=desformateaDivisa(jQuery("#UdsLote_"+IDOfertaLic).val()),
		//27jul22 UdesLote=parseFloat(jQuery("#UdsLote_"+IDOfertaLic).val().replace('PUNTO','').replace(',','.')),
		Lotes,
		Cantidad=CantidadTotal,
		IDCentroPedido='', 
		CentroPedido=''
		;
	
	//solodebug
	console.log('Pedido. Inicio. LicAgregada:'+LicAgregada+' IDProveedorLic:'+IDProveedorLic+' IDMultioferta:'+IDMultioferta+' IDEstadoMO:'+IDEstadoMO+' CodPedido:'+CodPedido+' Consumo:'+Consumo+' PedMinimo:'+PedMinimo+' Cantidad:'+Cantidad);
	
	var Seguir=false;
	
	
	if (LicAgregada=='S')
	{
		IDCentroPedido=jQuery("#IDCentroPedido").val();
		CentroPedido=Piece(jQuery("#IDCentroPedido").find('option:selected').text(),':',0);
		
		//	Busca la cantidad correspondiente al centro
		Cantidad=jQuery("#Cantidad_"+IDCentroPedido).val();
		
		//solodebug	console.log('Pedido para centro: '+"("+IDCentroPedido+") "+CentroPedido+" Cantidad:"+Cantidad);
		
		//solodebug	alert("Preparando pedido para "+"("+IDCentroPedido+") "+CentroPedido+" Cantidad:"+Cantidad);
	
		//solodebug	return;
	}
	
	if (IDMultioferta=='')
	{
		if ((PedMinimo>Consumo)&&(saltarPedMinimo=='N'))
		{
			//27jul22 var PrecioU=parseFloat(jQuery("#PrecioOriginal_"+IDOfertaLic).val().replace('PUNTO','').replace(',','.'));
			var PrecioU=desformateaDivisa(jQuery("#PrecioOriginal_"+IDOfertaLic).val());
		
			Cantidad=Math.ceil(PedMinimo/PrecioU);
			Lotes=Math.ceil(Cantidad/UdesLote);
			Cantidad=Lotes*UdesLote;
		
			if (confirm(str_RevisarCantProd.replace("[[CANTIDAD]]", Cantidad)))
			{
				Seguir=true;
			}
		}
		else
		{
			Seguir=true;
		}
	}
	else if (IDEstadoMO==13)
	{
		Seguir=confirm(str_PedAceptAnnadirProd);
	}
	else
	{
		Seguir=true;
	}
	
	if (Cantidad%UdesLote!=0)
	{
		var Lotes=Math.ceil(Cantidad/UdesLote);
		Cantidad=Lotes*UdesLote;
		Seguir=confirm(alrt_avisoCambioUnidades.replace("[[CANTIDAD]]", Cantidad));
	}
	
	if (Seguir)
	{
	
		//solodebug
		console.log('Pedido. Preparar AJAX. IDProveedorLic:'+IDProveedorLic+' IDMultioferta:'+IDMultioferta+' IDEstadoMO:'+IDEstadoMO+' CodPedido:'+CodPedido+' Consumo:'+Consumo+' PedMinimo:'+PedMinimo+' Cantidad:'+Cantidad);
	

		var d = new Date();

		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/PedidoDesdeOfertaAJAX.xsql',
			type:	"POST",
			async:	false,
			data:	"LIC_ID="+IDLicitacion+"&IDOFERTALIC="+IDOfertaLic+"&IDMULTIOFERTA="+IDMultioferta+"&CANTIDAD="+Cantidad+'&IDCENTROPEDIDO='+IDCentroPedido+"&_="+d.getTime(),
			beforeSend: function(){
				jQuery('#btnPedido_'+IDOfertaLic).hide();
			},
			error: function(objeto, quepaso, otroobj){
				alert(alert_GuardarPedidoKO);
			},
			success: function(objeto){
				//var data = eval("(" + objeto + ")");
				var data = JSON.parse(objeto);
				
				if(data.PedidoDesdeOferta.estado == 'OK'){
					alert(str_ProdIncluidoOK.replace("[[NUM_PEDIDO]]",data.PedidoDesdeOferta.codpedido).replace("[[PROVEEDOR]]",Proveedor));
					var urlPed='<a id="btnVerPedido_'+IDOfertaLic+'" href="javascript:VerPedido('+data.PedidoDesdeOferta.idmultioferta+')">'+data.PedidoDesdeOferta.codpedido+'</a>'; 
					urlPed+='<a class="btnDestacado" style="display:none;" id="btnPedido_'+IDOfertaLic+'" href="javascript:Pedido('+IDOfertaLic+')">'+strPedido+'</a>'; 
					jQuery('#tdPedido_'+IDOfertaLic).html(urlPed);
					
					if (LicAgregada=='S')
					{
						//	Actualiza también la matriz de multiofertas con el dato de este pedido
						
						var Pend=true;
						for (var i=0; (i<arrOfertas.length)&&(Pend); ++i)
						{
							
							//solodebug	console.log('Pedido. arrOfertas['+i+']: COmprobando IDOferta:'+arrOfertas[i].IDOferta+' vs '+IDOfertaLic);
							
							if (arrOfertas[i].IDOferta==IDOfertaLic)
							{
							
								//solodebug
								console.log('Pedido. arrOfertas['+i+']: Incluyendo datos de multioferta. '+data.PedidoDesdeOferta.idmultioferta);
								
								var pendCentro=true;
								//	Comprueba si ya hay una multioferta para esta oferta y centro
								for (var j=0; (j<arrOfertas[i].Multiofertas.length)&&(pendCentro); ++j)
								{
									if (arrOfertas[i].Multiofertas[j].IDCentro==IDCentroPedido)
									{
										//solodebug
										console.log('Pedido. arrOfertas['+i+']: Comprobando datos de multioferta. '+arrOfertas[i].Multiofertas[j].IDCentro+' vs '+IDCentroPedido);
										console.log('Pedido. arrOfertas['+i+']: Comprobando datos de multioferta. '+data.PedidoDesdeOferta.idmultioferta+' vs '+arrOfertas[i].Multiofertas[j].MO_ID);
									
										
									
										pendCentro=false;
										arrOfertas[i].Multiofertas[j].Incluido='S';
									}
								}
								
								if (pendCentro)
								{
									var multioferta	= [];
									multioferta['MO_ID']	= data.PedidoDesdeOferta.idmultioferta;
									multioferta['LMO_ID']	= '';
									multioferta['CodPedido']= data.PedidoDesdeOferta.codpedido;
									multioferta['Estado']	= '11';
									multioferta['IDCentro']	= IDCentroPedido;
									multioferta['Incluido']	= 'S';
									
									arrOfertas[i].Multiofertas.push(multioferta);
								
									//solodebug
									console.log('Pedido. arrOfertas['+i+']: Incluyendo datos de multioferta. Incluido:'+arrOfertas[i].Multiofertas[arrOfertas[i].Multiofertas.length-1].MO_ID+' vs '+data.PedidoDesdeOferta.idmultioferta);
								}
								
								Pend=false;
								
							}
						}
						
						//location.reload();
						
					}
					
				}
				else
				{
					alert(alert_GuardarPedidoKO);
					jQuery('#btnPedido_'+IDOfertaLic).show();
       	        	return;
				}
			}
		});

	}
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
	//jQuery("#btnGuardar_"+IDOferta).show();
	//jQuery("#btnDescartar_"+IDOferta).hide();
	jQuery("#lMotivoPrecio_"+IDOferta).show();
}


//	14dic18 Cancela la edición del precio, recupera el valor original
function CancGuardarOferta(IDOferta)
{
	jQuery('#Precio_' + IDOferta).val(jQuery('#PrecioOriginal_' + IDOferta).val());
	jQuery("#lMotivoPrecio_"+IDOferta).hide();
}


// Funcion para guardar los datos de una oferta del proveedor para una fila en concreto
// Traido desde lic_090418.js
function guardarOferta(Pos, IDOferta){
	// Validaciones
	var oForm = document.forms['ProdLici'];
	
	var enviarOferta = false;
	var controlPrecio = '';
	var errores = 0;


	// Validacion Precio
	var precio		= jQuery('#Precio_' + IDOferta).val()
	var precioFormat= precio.replace(",",".");


	var IDMotivo=jQuery("#IDMOTIVOCAMBIOPRECIO_"+IDOferta).val();
	var Motivo=jQuery("#MOTIVOCAMBIOPRECIO_"+IDOferta).val();

	//solodebug console.log('guardarOferta. Motivo:'+IDMotivo+':'+Motivo);

	if (IDMotivo=='')
	{
		alert(alrt_RequiereMotivoPrecio);
		return;
	}

	if(!errores && esNulo(precioFormat)){
		errores++;
		alert(val_faltaPrecio.replace("[[REF]]",RefCliente));
		oForm.elements['Precio_' + IDOferta].focus();
		return;
	}else if(!errores && isNaN(precioFormat)){
		errores++;
		alert(val_malPrecio.replace("[[REF]]",RefCliente));
		oForm.elements['Precio_' + IDOferta].focus();
		return;
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
	if(!errores && esNulo(UdsXLote)){
		errores++;
		alert(val_faltaUnidades.replace("[[REF]]",RefCliente));
		oForm.elements['UdsLote_' + IDOferta].focus();
		return;
	}else if(!errores && !esEntero(UdsXLote)){
		errores++;
		//alert(val_malUnidades.replace("[[REF]]",RefCliente));
		alert(val_malEnteroUnidades.replace("[[REF]]",RefCliente));
		oForm.elements['UdsLote_' + IDOferta].focus();
		return;
	}else if(!errores && UdsXLote == 0 && precioFormat != 0){
		errores++;
		alert(val_notZeroUnidades.replace("[[REF]]",RefCliente));
		oForm.elements['UdsLote_' + IDOferta].focus();
		return;
	}

	if(IDPais != 55){
		// Validacion Ref.Proveedor
		valAux	= jQuery('#RefProv_' + IDOferta).val();
		
		console.log('guardarOferta. IDOferta:'+IDOferta+' RefProv:'+valAux);
		
		//if(!errores && esNulo(valAux) && (precioFormat != 0 || UdsXLoteFormat != 0))
		if(!errores && esNulo(valAux) && (precioFormat != 0 || UdsXLote != 0)){
			errores++;
			alert(val_faltaRefProv.replace("[[REF]]",RefCliente));
			oForm.elements['RefProv_' + IDOferta].focus();

		}

		if(!errores && precioFormat == 0 && UdsXLote == 0){
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
			data:	"LIC_ID="+IDLicitacion+"&LIC_PROD_ID="+IDProdLic+"&LIC_PROV_ID="+IDLicProv+"&REFPROV="+RefProv+"&DESC="+Descripcion+"&MARCA="+Marca+"&UDSXLOTE="+UdsXLote
					+"&CANTIDAD="+Cantidad+"&PRECIO="+Precio+"&TIPOIVA="+TipoIVA+"&IDFICHA="+IDFicha
					+"&IDMOTIVO="+IDMotivo+"&MOTIVO="+encodeURIComponent(ScapeHTMLString(Motivo))
					+"&_="+d.getTime(),
			beforeSend: function(){
				jQuery("#btnGuardar_"+IDOferta).hide();
			},
			error: function(objeto, quepaso, otroobj){
				jQuery('#AVISOACCION_'+IDOferta).html('<img src="http://www.newco.dev.br/images/error.gif"/>');
				alert('error'+quepaso+' '+otroobj+' '+objeto);
			},
			success: function(objeto){
				var data = eval("(" + objeto + ")");

				if(data.OfertaActualizada.IDOferta > 0)
				{
					jQuery('#AVISOACCION_'+IDOferta).html('<img src="http://www.newco.dev.br/images/recibido.gif"/>');
					if(data.OfertaActualizada.TodosInformados == 'Si')
					{
						location.reload();
					}
				}
				else
				{
					jQuery("#btnGuardar_"+IDOferta).show();
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
		gl_PrecioOfertaActual=parseFloat(oform.elements["Precio_"+IDOferta].value.replace(",","."));

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


// 25abr19 Incluye las marcas seleccionadas en la lista de aceptables
function IncluirMarcas()
{
	var Marcas='';
	//solodebug	console.log("IncluirMarcas");
	
	//	Recorre los controles de marcas para preparar la lista input:checkbox:checked
	jQuery(".chkmarca").each(function(){
		if (this.checked)
		{
			IDOferta	= this.id.replace("chkMarca_","");
			Marcas		=Marcas+(Marcas==''?'':',')+jQuery("#Marca_"+IDOferta).val();
			
			//solodebug	console.log("IncluirMarcas SEL IDOferta:"+IDOferta);
		}
		else
		{
			IDOferta	= this.id.replace("chkMarca_","");
			//solodebug	console.log("IncluirMarcas NOSEL IDOferta:"+IDOferta);
		}
	});
	
	//solodebug	console.log("IncluirMarcas:"+Marcas);
	
	jQuery("#PARAMETROS").val(Marcas);
	jQuery("#ACCION").val("MARCAS");
	SubmitForm(document.forms["ProdLici"]);
}


//	22may19 Abre o activa la página de la licitación,c omprobando si ya estaba abierta
function AbrirLicitacion(IDLicitacion)
{
	
	if ((window.opener && window.opener.open && !window.opener.closed)&&(window.opener.name=='Licitacion'))
	{
		console.log('AbrirLicitacion. Opener:'+window.opener.name);
		window.opener.focus();
		window.close();
	}
	else
	{
		console.log('AbrirLicitacion. Opener: cerrado');
		MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/MantLicitacion2022.xsql?LIC_ID='+IDLicitacion,'Licitacion',90,90,10,10);
	}
}

//	5jun19 Muestra el histórico de compras del producto estándar
function VerHistorico()
{
	var IDEmpresa=jQuery("#IDEMPRESA").val();
	var IDCentro=jQuery("#IDCENTRO").val();
	var IDProdEstandar=jQuery("#LIC_PROD_IDPRODESTANDAR").val();
	
	console.log('VerHistorico. IDEmpresa:'+IDEmpresa+' IDCentro:'+IDCentro+' IDProdEstandar:'+IDProdEstandar);


	MostrarPagPersonalizada('http://www.newco.dev.br/Personal/BandejaTrabajo/AnalisisPedidos.xsql?IDEMPRESA='+IDEmpresa+'&IDCENTRO='+IDCentro+'&IDPRODESTANDAR='+IDProdEstandar,'HistoricoPedidos',90,90,10,10);
}


//	26jul19 Realiza el cambio de los datos de multiofertas al cambiarse el centro seleccionado
function CambioCentro()
{
	if (LicAgregada=='S')
	{
		var IDCentroPedido=jQuery("#IDCentroPedido").val();
		//solodebug	console.log('CambioCentro: LicAgregada: S. IDCentroPedido:'+IDCentroPedido);	
		
		//	Revisa las ofertas correspondientes al centro del pedido
		
		for (var i=0;i<arrOfertas.length;++i)
		{
			//solodebug	console.log('CambioCentro: Oferta['+i+'] :'+arrOfertas[i].IDOferta);

			jQuery("#btnPedido_"+arrOfertas[i].IDOferta).show();
			jQuery("#btnVerPedido_"+arrOfertas[i].IDOferta).hide();
			jQuery("#imgSemAmbar_"+arrOfertas[i].IDOferta).hide();
			jQuery("#imgSemVerde_"+arrOfertas[i].IDOferta).hide();

			//	29jul19 Faltaba inicializar los datos utilizados en la multioferta
			jQuery("#MO_ID_"+arrOfertas[i].IDOferta).val('');
			jQuery("#MO_STATUS_"+arrOfertas[i].IDOferta).val('');
			jQuery("#CODPEDIDO_"+arrOfertas[i].IDOferta).val('');


			var btnVisible=true;
			for (var j=0;j<arrOfertas[i].Multiofertas.length;++j)
			{
				//solodebug	console.log('CambioCentro: Oferta['+i+'] Multioferta['+j+']. IDCentro:'+arrOfertas[i].Multiofertas[j].IDCentro);
				
				if (arrOfertas[i].Multiofertas[j].IDCentro===IDCentroPedido)
				{
					jQuery("#MO_ID_"+arrOfertas[i].IDOferta).val(arrOfertas[i].Multiofertas[j].MO_ID);
					jQuery("#MO_STATUS_"+arrOfertas[i].IDOferta).val(arrOfertas[i].Multiofertas[j].Estado);
					jQuery("#CODPEDIDO_"+arrOfertas[i].IDOferta).val(arrOfertas[i].Multiofertas[j].CodPedido);

					if (arrOfertas[i].Multiofertas[j].Incluido==='S')
					{
						//solodebug	
						console.log('CambioCentro: Oferta['+i+'] Multioferta['+j+']. COINCIDE. OCULTAR BOTON. MO_ID:'+arrOfertas[i].Multiofertas[j].MO_ID+' Estado:'+arrOfertas[i].Multiofertas[j].Estado);
						
						jQuery("#btnPedido_"+arrOfertas[i].IDOferta).hide();
						jQuery("#btnVerPedido_"+arrOfertas[i].IDOferta).text(arrOfertas[i].Multiofertas[j].CodPedido);
						jQuery("#btnVerPedido_"+arrOfertas[i].IDOferta).attr("href", "javascript:VerPedido("+arrOfertas[i].Multiofertas[j].MO_ID+");");
						jQuery("#btnVerPedido_"+arrOfertas[i].IDOferta).show();
					}
					else
					{
						if (arrOfertas[i].Multiofertas[j].Estado==11)
							jQuery("#imgSemVerde_"+arrOfertas[i].IDOferta).show();
						else if (arrOfertas[i].Multiofertas[j].Estado==13)
							jQuery("#imgSemAmbar_"+arrOfertas[i].IDOferta).show();
					}
				}				
			}
			
		}
		
	}
	else
	{
		console.log('CambioCentro: LicAgregada: N');	
	}
}

/*
	7nov19 FUNCIONES PARA MANEJAR NUEVA OFERTA
*/
function ActivarBotonGuardarNuevaOferta()
{
	jQuery("#lMotivoPrecio_NUEVA").show();
}

// Guardar los datos de una nueva oferta
function guardarNuevaOferta(){
	// Validaciones
	var oForm = document.forms['ProdLici'];
	
	var enviarOferta = false;
	var controlPrecio = '';
	var errores = 0;


	// Validacion Precio
	var precio		= jQuery('#Precio_NUEVA').val()
	var precioFormat= precio.replace(",",".");


	var IDMotivo=jQuery("#IDMOTIVOCAMBIOPRECIO_NUEVA").val();
	var Motivo=jQuery("#MOTIVOCAMBIOPRECIO_NUEVA").val();

	//solodebug console.log('guardarOferta. Motivo:'+IDMotivo+':'+Motivo);

	if (IDMotivo=='')
	{
		alert(alrt_RequiereMotivoPrecio);
		return;
	}

	if(!errores && esNulo(precioFormat)){
		errores++;
		alert(val_faltaPrecio.replace("[[REF]]",RefCliente));
		oForm.elements['Precio_NUEVA'].focus();
		return;
	}else if(!errores && isNaN(precioFormat)){
		errores++;
		alert(val_malPrecio.replace("[[REF]]",RefCliente));
		oForm.elements['Precio_NUEVA'].focus();
		return;
	}

	if(!errores && precioFormat != 0){
		valAux	= (precioFormat != '') ? String(parseFloat(precioFormat).toFixed(4)).replace(".",",") : '';
		jQuery('#Precio_NUEVA').val( valAux );

		if(jQuery('#Desc_NUEVA').val() == str_SinOfertar){
			jQuery('#Desc_NUEVA').val('');
		}
		if(jQuery('#Marca_NUEVA').val() == str_SinOfertar){
			jQuery('#Marca_NUEVA').val('');
		}
	}

	// Validacion Unidades por Lote
	UdsXLote	= jQuery('#UdsLote_NUEVA').val();
	if(!errores && esNulo(UdsXLote)){
		errores++;
		alert(val_faltaUnidades.replace("[[REF]]",RefCliente));
		oForm.elements['UdsLote_NUEVA'].focus();
		return;
	}else if(!errores && !esEntero(UdsXLote)){
		errores++;
		//alert(val_malUnidades.replace("[[REF]]",RefCliente));
		alert(val_malEnteroUnidades.replace("[[REF]]",RefCliente));
		oForm.elements['UdsLote_NUEVA'].focus();
		return;
	}else if(!errores && UdsXLote == 0 && precioFormat != 0){
		errores++;
		alert(val_notZeroUnidades.replace("[[REF]]",RefCliente));
		oForm.elements['UdsLote_NUEVA'].focus();
		return;
	}

	if(IDPais != 55){
		// Validacion Ref.Proveedor
		valAux	= jQuery('#RefProv_NUEVA').val();
		
		console.log('guardarOferta. IDOferta:'+IDOferta+' RefProv:'+valAux);
		
		//if(!errores && esNulo(valAux) && (precioFormat != 0 || UdsXLoteFormat != 0))
		if(!errores && esNulo(valAux) && (precioFormat != 0 || UdsXLote != 0)){
			errores++;
			alert(val_faltaRefProv.replace("[[REF]]",RefCliente));
			oForm.elements['RefProv_NUEVA'].focus();

		}

		if(!errores && precioFormat == 0 && UdsXLote == 0){
			jQuery('#RefProv_NUEVA').val(str_SinOfertar.toUpperCase());
			jQuery('#Desc_NUEVA').val(str_SinOfertar.toUpperCase());
			jQuery('#Marca_NUEVA').val(str_SinOfertar.toUpperCase());
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
		var IDLicProv	= jQuery('#IDPROVEEDOR_NUEVA').val();
		var IDFicha = jQuery('#FT_NUEVA').val();
		var RefProv = jQuery('#RefProv_NUEVA').val();
		var Descripcion = encodeURIComponent(jQuery('#Desc_NUEVA').val());
		var Marca = encodeURIComponent(jQuery('#Marca_NUEVA').val());
		var UdsXLote = encodeURIComponent(jQuery('#UdsLote_NUEVA').val());
		var Precio = jQuery('#Precio_NUEVA').val();
		var Cantidad = jQuery('#Cant_NUEVA').val();
		var TipoIVA = jQuery('#TIVA_NUEVA').val();
		var d = new Date();

		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/AnadirUnaOfertaAJAX.xsql',
			type:	"GET",
			data:	"LIC_ID="+IDLicitacion+"&LIC_PROD_ID="+IDProdLic+"&LIC_PROV_ID="+IDLicProv+"&REFPROV="+RefProv+"&DESC="+Descripcion+"&MARCA="+Marca+"&UDSXLOTE="+UdsXLote
					+"&CANTIDAD="+Cantidad+"&PRECIO="+Precio+"&TIPOIVA="+TipoIVA+"&IDFICHA="+IDFicha
					+"&IDMOTIVO="+IDMotivo+"&MOTIVO="+encodeURIComponent(ScapeHTMLString(Motivo))
					+'&ACCION=NUEVAOFERTA'			//	Para marcar el proveedor como informado, externo, etc
					+"&_="+d.getTime(),
			beforeSend: function(){
				jQuery("#btnGuardar_NUEVA").hide();
			},
			error: function(objeto, quepaso, otroobj){
				jQuery('#AVISOACCION_NUEVA').html('<img src="http://www.newco.dev.br/images/error.gif"/>');
				alert('error'+quepaso+' '+otroobj+' '+objeto);
			},
			success: function(objeto){
				var data = eval("(" + objeto + ")");

				if(data.OfertaActualizada.IDOferta > 0){
					jQuery('#AVISOACCION_NUEVA').html('<img src="http://www.newco.dev.br/images/recibido.gif"/>');
					location.reload();
				}
				else
				{
					jQuery("#btnGuardar_NUEVA").show();
					alert("Se ha producido un error.");
				}
			}
		});
	}

}


//	29ago20 Muestra la ficha de adjudicación para una oferta ya existenete en el catálogo
function VerProductoEstandar(IDEmpresa, IDProducto)
{
	MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducido.xsql?PRO_ID='+IDProducto+'&EMP_ID='+IDEmpresa,'Ficha adjudicación producto',100,80,0,-10);
}


//	29mar21 Construimos la tabla de centros y proveedores
function ActualizarCentrosYProveedores()
{

	var html='<thead class="cabecalho_tabela"><tr id="cabTablaCentros">'+jQuery('#cabTablaCentros').html()+'</tr></thead><tbody class="corpo_tabela">';
	
	for (var i=0;i<arrCentros.length;++i)
	{
		html+='<tr class="conhover">'
			+		'<td class="color_status">'+arrCentros[i].linea+'&nbsp;</td>'
			+		'<td class="textLeft">'+arrCentros[i].Centro+'&nbsp;</td>'
			+		'<td class="textLeft">'+arrCentros[i].Marcas+'&nbsp;</td>'
			+		'<td class="textLeft">&nbsp;</td>'
			+		'<td class="textLeft"><input name="Cantidad_'+arrCentros[i].IDCentro+'" id="Cantidad_'+arrCentros[i].IDCentro+'" value="'+arrCentros[i].CantidadSF+'" class="campopesquisa w100px" maxlength="8" type="text" onKeyUp="javascript:chCantidadCentro('+arrCentros[i].IDCentro+')"/></td><td class="acciones"><a id="btnCantidad_'+arrCentros[i].IDCentro+'" href="javascript:guardarDatosCompraCentro('+arrCentros[i].IDCentro+')" class="btnDestacado guardarCant" style="text-decoration:none;display:none;">'+str_Guardar+'</a></td><td id="Resultado_'+arrCentros[i].IDCentro+'" class="resultado">&nbsp;</td>'
			+		'<td>&nbsp;</td>'
			+	'</tr>';

		for (var j=0;j<arrCentros[i].Proveedores.length;++j)
		{
			datosPorProveedor='S';
			html+='<tr class="conhover">'
				+		'<td class="color_status">'+arrCentros[i].linea+'&nbsp;</td>'
				+		'<td class="textLeft">&nbsp;</td>'
				+		'<td class="textLeft">'+arrCentros[i].Proveedores[j].Proveedor+' (tot:'+jQuery('#CANTADJUD_'+arrCentros[i].Proveedores[j].IDOfertaLic).val()+')&nbsp;</td>'
				+		'<td class="textRight">'+arrCentros[i].Proveedores[j].UdesLote+'&nbsp;</td>'
				+		'<td class="textLeft"><input name="Cantidad_'+arrCentros[i].IDCentro+'_'+arrCentros[i].Proveedores[j].IDOfertaLic+'" id="Cantidad_'+arrCentros[i].IDCentro+'_'+arrCentros[i].Proveedores[j].IDOfertaLic+'" value="'+arrCentros[i].Proveedores[j].CantidadSF+'"  class="campopesquisa w100px" maxlength="8" type="text" onKeyUp="javascript:chCantidadCentroYProv('+arrCentros[i].IDCentro+','+arrCentros[i].Proveedores[j].IDOfertaLic+')"/></td><td class="acciones"><a id="btnCantidad_'+arrCentros[i].IDCentro+'_'+arrCentros[i].Proveedores[j].IDOfertaLic+'" href="javascript:guardarDatosCompraCentroYProv('+arrCentros[i].IDCentro+','+arrCentros[i].Proveedores[j].IDOfertaLic+','+arrCentros[i].Proveedores[j].IDProveedorLic+')" class="btnDestacado guardarOferta" style="display:none;">'+str_Guardar+'</a></td><td id="Resultado_'+arrCentros[i].IDCentro+'_'+arrCentros[i].Proveedores[j].IDOfertaLic+'" class="resultado">&nbsp;</td>'
				+		'<td>&nbsp;</td>'
				+	'</tr>';
		}
	}
	html+='</tbody><tfoot class="rodape_tabela"><tr><td colspan="12">&nbsp;</td></tr></tfoot>';
	jQuery('#tblCentros').html(html);
	
	//solodebug	debug('ActualizarCentrosYProveedores:'+html);
	
}

//	30mar21 Cambio de la cantidad por centro
function chCantidadCentro(IDCentro)
{
	jQuery('#btnCantidad_'+IDCentro).show();
}

//	30mar21 Cambio de la cantidad por centro y proveedor
function chCantidadCentroYProv(IDCentro, IDProveedor)
{
	jQuery('#btnCantidad_'+IDCentro+'_'+IDProveedor).show();
}

//	13abr21 Recupera la info de los proveedores
function ProveedoresAdjudicadosAJAX()
{
	debug('ProveedoresAdjudicadosAJAX');

	var d = new Date();
	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/ProveedoresAdjudicadosAJAX.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&LIC_PROD_ID="+IDProdLic+"&_="+d.getTime(),
		beforeSend: function(){
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			arrCentros	= new Array();
			
			for (var i=0;i<data.Centros.length;++i)
			{
				var centro	= [];
				centro['IDCentro']	= data.Centros[i].IDCentro;
				centro['Centro']= data.Centros[i].Centro;
				centro['Marcas']= data.Centros[i].Marcas;
				centro['Cantidad']= data.Centros[i].Cantidad;
				centro['CantidadSF']= parseInt(data.Centros[i].CantidadSF);
				centro['Proveedores']	= [];
				for (var j=0;j<data.Centros[i].Proveedores.length;++j)
				{
						var Proveedor	= [];
						Proveedor['IDOfertaLic']= data.Centros[i].Proveedores[j].IDOfertaLic;
						Proveedor['IDProvLic']	= data.Centros[i].Proveedores[j].IDProveedorLic;
						Proveedor['IDProveedor']= data.Centros[i].Proveedores[j].IDProveedor;
						Proveedor['Proveedor']	= data.Centros[i].Proveedores[j].Proveedor;
						Proveedor['UdesLote']	= data.Centros[i].Proveedores[j].UnidadesPorLote;
						Proveedor['Cantidad']	= data.Centros[i].Proveedores[j].Cantidad;
						Proveedor['CantidadSF']	= parseInt(data.Centros[i].Proveedores[j].CantidadSF);
						centro['Proveedores'].push(Proveedor);
				}
				arrCentros.push(centro);
			}
			ActualizarCentrosYProveedores();

		}
	});
	
}

// 5may21 COmprueba la cantidad
function CompruebaCantidadCentrosProv()
{
	var errMsg='';

	//solodebug	
	debug('CompruebaCantidadCentrosProv.');

	//	Guardaremos los datos totales en el primer centro, todos tendran los mismos proveedores en el mismo orden
	for (var j=0;j<arrCentros[0].Proveedores.length;++j)
	{
		var tot=0;
		
		for (var i=0;i<arrCentros.length;++i)
		{
			tot+=arrCentros[i].Proveedores[j].CantidadSF;
		}
		arrCentros[0].Proveedores[j].CantidadTotal=tot;
		
		var Adj=parseInt(jQuery('#CANTADJUD_'+arrCentros[0].Proveedores[j].IDOfertaLic).val());
		
		if (Adj!=tot)
			errMsg+=arrCentros[0].Proveedores[j].Proveedor+':'+ alrt_TotalAsignadoNoCoincide.replace('[[TOTAL_ASIGNADO]]', tot).replace('[[TOTAL_ADJUDICADO]]', Adj)+'\n\r';
	}
	
	return errMsg;
}




//	19ago21 Sustituye el producto estandar asociado al producto de la licitacion
function SustituirProductoLicitacion(id, ref, nombre)
{
	console.log('SustituirProductoLicitacion. id:'+id+'. ref'+ref+'. nombre'+nombre);
	
	jQuery("#PARAMETROS").val(id);
	jQuery("#ACCION").val("CAMBIOPRODEST");
	SubmitForm(document.forms["ProdLici"]);

}

//	30mar22 Abre la pagina del catalogo privado de la empresa para cambiar el producto
function VerCatalogoPrivado(IDEmpresa)
{
	MostrarPagPersonalizada("http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoPrivadoProductoEmpresa2022.xsql?IDEMPRESA="+IDEmpresa+"&amp;ORIGEN=PRODUCTOLIC",'Catalogo Privado',50,80,90,20);
}



// 3mar23 Funcion (ajax) para cambiar el estado evaluacion de una oferta(recuperado desde lic2022_070223.js)
function CambiarEstadoOferta(IDOfe){
	var IDEstadoEval = jQuery("#IDESTADO_"+IDOfe).val();
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/CambiarEstadoOferta.xsql',
		type:	"GET",
		data:	"LIC_OFE_ID="+IDOfe+"&IDESTADO="+IDEstadoEval+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.NuevoEstado.estado == 'OK'){
				//recuperaOfertaProductos(IDLic,IDProvLic);
				//jQuery("#lPublOferta").hide();
				alert(estadoOfertaActualizado);
			}else{
				alert(errorNuevoEstadoOferta);
			}
		}
	});
}



//	2may23 Presenta el pop-up con la programacion de entregas
function EntregasProducto(Pos)
{
	var cadProv='',OfSeleccionadas=OfertasSeleccionadas();
	// si hay mas de una oferta seleccionadas, muestra aviso y sale
	if (OfSeleccionadas>1)
	{
		alert(alrt_VariasSelNoPermiteProg);
		return;		
	}

	//	Si hay un anica oferta, incluimos la informacin del proveedor y marca seleccionados
	if (OfSeleccionadas==1)
	{
		var fin=false;
		for(var i=0;(i<arrOfertas.length)&&(!fin);++i)
		{
			if (arrOfertas[i].OfertaAdjud=='S')
			{
				cadProv='<label>'+strProveedor+':&nbsp;</label>'+arrOfertas[i].Proveedor+'&nbsp;&nbsp;&nbsp;<label>'+strMarca+':&nbsp;</label>'+arrOfertas[i].Marca;
				fin=true;
			}
		}
	}

	//	alert('Provisional:'+arrProductos[Pos].Entregas);

	var strProducto=cadProv+'&nbsp;&nbsp;&nbsp;<label>'+strCantidad+':&nbsp;</label>'+Cantidad+'&nbsp;'+UdBasica+'&nbsp;&nbsp;&nbsp;<label>'+str_CantProg+':&nbsp;</label>&nbsp;<span id="totProgr"/>';

	//solodebug	debug("EntregasProducto:"+ strProducto);
	
	jQuery("#progEntrPosProd").val(Pos);
	jQuery("#progEntrTitulo").html('<label>'+str_ProgEntregas+'</label>:&nbsp('+RefCliente+')&nbsp'+nombreProducto.substring(0,80));
	jQuery("#progEntrCant").html(strProducto);

	//solodebug	debug("EntregasProducto:"+ Entregas);

	for (var i=0;i<=PieceCount(Entregas,'#');++i)		//	Cuidado, devuelve 0 aunque haya una programacion, por que no acaba con #
	{
		var Entrega=Piece(Entregas,'#',i);
		
		//solodebug debug("EntregasProducto("+i+"):"+ Entrega);		
		if (Entrega!='')
		{
			jQuery("#dataEntr"+(i+1)).val(FechaParaControlDate(Piece(Entrega,'|',0)));
			jQuery("#cantEntr"+(i+1)).val(Piece(Piece(Entrega,'|',1),'.',0));				//	6jun23 Cortamos punto decimal
		}
		else
		{
			jQuery("#dataEntr"+(i+1)).val('');
			jQuery("#cantEntr"+(i+1)).val('');				//	6jun23 Cortamos punto decimal
		}
	}

	//	Vaciamos el final de la tabla
	for (;i<=9;++i)		
	{
		jQuery("#dataEntr"+(i+1)).val('');
		jQuery("#cantEntr"+(i+1)).val('');				
	}


	MuestraTotalPrograma();

	showTablaByID("progEntregas");
}


//	2may23 Comprueba la cantidad cambiada en un programa
function CambiaCantidadProg(IndProg)
{
	var cantTxt=jQuery("#cantEntr"+IndProg).val();
	var msg='';
	
	if ((cantTxt!='')&&(!esEntero(cantTxt)))
	{
		msg+=alrt_CantIncorrecta+i+':'+cantTxt+'.\n\r';
	}

	//solodebug
	debug("CambiaCantidadProg. IndProg:"+IndProg+" cantTxt:"+cantTxt);

	if (msg!='')
		alert(msg);
	else
		MuestraTotalPrograma();
}

//	2may23 Muestra el total del programa
function MuestraTotalPrograma()
{
	Pos=jQuery("#progEntrPosProd").val();

	//solodebug
	debug("MuestraTotalPrograma. Pos:"+ Pos);
	
	//	Revisa los importes, y que esten informados para las fechas
	var msg='',total=0;
	for (i=1;i<=10;++i)
	{
		var cantTxt=jQuery("#cantEntr"+i).val();

		//solodebug	debug("MuestraTotalPrograma. Pos:"+ Pos+ ' Prog('+i+'):'+cantTxt);
		if (cantTxt!='')
		{
			cant=parseInt(cantTxt);	
			total+=cant;
		}
	}

	//solodebug
	debug("MuestraTotalPrograma. total:"+total);

	jQuery("#totProgr").html(total+'&nbsp;'+UdBasica);
}


//	2may23 Guarda la programacion correspondiente a un producto
function GuardarProgramacion()
{
	jQuery("#btnGuardarEntregas").hide();		//	evitar dobleclic
	var Pos=jQuery("#progEntrPosProd").val();
	var OfSeleccionadas=OfertasSeleccionadas()
	
	//solodebug	debug("GuardarProgramacion. Pos:"+ Pos);
	
	//	Revisa los importes, y que esten informados para las fechas
	var msg='',cadPrograma='', total=0, final=false, ultFecha='', cambioCant=false;
	for (i=1;i<=10;++i)
	{
		
		var fechaOrig=jQuery("#dataEntr"+i).val();
	
		//solodebug	debug("GuardarProgramacion. Pos:"+ Pos+ 'Prog('+i+'):'+fechaOrig);

		var fecha=((fechaOrig=='')?'':FechaDeControlDate(fechaOrig));
		var cantTxt=jQuery("#cantEntr"+i).val();
		
		if ((fecha!='')&&(cantTxt==''))
			msg+=alrt_CantNoInformada+i+'.\n\r';
		else if ((fecha=='')&&(cantTxt!=''))
			msg+=alrt_FechaNoInformada+i+'.\n\r';
		else if ((fecha=='')&&(cantTxt==''))
			final=true;
		else if ((fecha!='')&&(cantTxt!=''))
		{
			if (final)
			{
				msg+=alrt_SaltoEnPrograma+i+':'+cantTxt+'.\n\r';
			}
			else
			{
				if (!esEntero(cantTxt))
				{
					msg+=alrt_CantIncorrecta+i+':'+cantTxt+'.\n\r';
				}
				else if ((ultFecha!='')&&(comparaFechas(fecha, ultFecha)!='>'))
				{
					msg+=alrt_OrdenFechas+i+':'+fecha+'<='+ultFecha+'.\n\r';
				}
				else
				{
					cant=parseInt(cantTxt);	
					total+=cant;
					ultFecha=fecha;
					cadPrograma+=((cadPrograma=='')?'':'#')+fecha+'|'+cantTxt;
				}
			}
		}
	}

	//solodebug
	debug("GuardarProgramacion:"+ cadPrograma+' msg:'+msg);
	
	//	Si hay datos incorrectos, avisa al usuario y sale de la funcion
	if (msg!='')
	{
		alert(msg);
		jQuery("#btnGuardarEntregas").show();
		return;
	}

	//solodebug
	debug("GuardarProgramacion:"+ cadPrograma);
	
	//	Si ha cambiado la cantidad, pedir confirmacion antes de guardar
	if (total!=CantidadTotal)
	{
		var aviso;
		//	Si hay ofertas seleccionadas, avisar que tambien se perdera la seleccion
		if (OfSeleccionadas>0)
			aviso=conf_CambiaCantidad;
		else
			aviso=conf_CambioCantTotProg
	
		if (!confirm(aviso))
		{
			jQuery("#btnGuardarEntregas").show();
			return;
		}
			
		cambioCant=true;
	}
		
	//	Actualizacion via Ajax
	jQuery.ajax({
		url:	"http://www.newco.dev.br/Gestion/Comercial/ActualizarProgEntregasProdLicAJAX.xsql",
		data:	"LIC_ID="+IDLicitacion+"&LIC_PROD_ID="+IDProdLic+"&ENTREGAS="+encodeURIComponent(cadPrograma),
		type:	"GET",
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			null;
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = JSON.parse(objeto);

			//solodebug
			debug("GuardarVencimiento. Res:"+objeto);

			if(data.Licitacion.Estado == 'OK'){
			
				//	Actualiza el programa tanto en el array, como en la base de datos
				Entregas=cadPrograma;

				//	Presentar mensaje de datos guardados OK
				alert(alrt_CambiosGuardados);
				
				//	Salir
				jQuery("#btnGuardarEntregas").show();
				showTabla(false);
				
				//	Si se ha producido cambio de cantidad
				if (cambioCant)
				{
					CantidadTotal=total;
					CantidadPendiente=total;
					jQuery('#Cantidad').val(total);
					QuitarSeleccionesProducto();
					ActualizarProducto(Pos,'N');
				}
				
			}else{
				alert(alrt_ErrorGuardarCambios);
				jQuery("#btnGuardarEntregas").show();
			}
		}
	});

}

//	5may23 Desmarca todas las ofertas seleccionadas para un producto
function QuitarSeleccionesProducto()
{
	//solodebug	console.log('QuitarSeleccionesProducto Ofertas:'+arrOfertas.length);

	for (var i=0;i<arrOfertas.length;++i)
	{
		var ID	= arrOfertas[i].IDOferta;

		//solodebug	console.log('QuitarSeleccionesProducto. Comprobando oferta '+i+' ID:'+ID+ ' Adjud:'+arrOfertas[i].OfertaAdjud);

		if (arrOfertas[i].OfertaAdjud=='S')
		{

			//solodebug	console.log('QuitarSeleccionesProducto. Comprobando oferta '+i+' ID:'+ID+ ' Adjud:'+arrOfertas[i].OfertaAdjud+ 'ADJUDICADA: DESADJUDICAR');
			
			arrOfertas[i].OfertaAdjud='N';

			jQuery('#ADJUD_'+ID).prop('checked', false);
			jQuery('#CANTADJUD_'+ID).val('');
			
			var Consumo=Round(Cantidad*desformateaDivisa(arrOfertas[i].PRECIO),2);
			var Color=CompruebaColorOferta(i);
			jQuery('#Consumo_'+ID).html('<span class="'+Color+'">'+FormatoNumero(Consumo)+'</span>');
		}
	}

}

//	5may23 Comprueba el color con el que debe informarse una oferta, tambien modifica campos SUPERIOR/INFERIOR/IGUAL
function CompruebaColorOferta(PosOfe)
{
	var Color='verde';
	if (PrecioHist!='')
	{
		PrecioHistNum=desformateaDivisa(PrecioHist);
		PrecioNum=desformateaDivisa(arrOfertas[PosOfe].PRECIO);

		//solodebug 
		debug('CompruebaColorOferta('+ PosOfe+') PrecioHistNum:'+PrecioHistNum+' PrecioNum:'+PrecioNum);

		if (PrecioHistNum<PrecioNum)
		{
			Color='rojo';
		}
		else if (PrecioHistNum==PrecioNum)
		{
			Color='naranja';
		}
		else
			arrOfertas[PosOfe].INFERIOR='S';
		
		//solodebug 
		debug('CompruebaColorOferta('+ PosOfe+') PrecioHistNum:'+PrecioHistNum+' PrecioNum:'+PrecioNum+' Color:'+Color);
	}
	//solodebug else
		//solodebug debug('CompruebaColorOferta('+PosProd+','+ PosOfe+') No hay precio historico. Color:'+Color);

	arrOfertas[PosOfe].PrecioColor=Color;
	return Color;
}




//	1jun23 COmprueba si las cantidades adjudicadas a productos han cambiado el total. EN cuyo caso, guarda los datos
//	Adaptado desde LicitacionV2_2022_250523.js
function RevisaCambiosCantidad()
{
	var CantOrig=CantidadTotal;
	var Cantidad=0;

	for (var i=0;i<arrOfertas.length;++i)
	{
		var ID	= arrOfertas[i].ID;

		//solodebug	console.log('ActualizarProducto '+Pos+'. Comprobando oferta '+i+' ID:'+ID+ ' Adjud:'+arrProductos[Pos].Ofertas[i].OfertaAdjud);

		if (arrOfertas[i].OfertaAdjud=='S')
			Cantidad+=parseInt(arrOfertas[i].CantAdjudicada);
	}

	if ((Cantidad!=0)&&(CantOrig<Cantidad))	//31mar23 Solo guardamos si la cantidad es mayor que la prevista
	{
		jQuery('#Cantidad').val(Cantidad);
		ActualizarProducto('N');
	}

}
