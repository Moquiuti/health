//	JS para la página con las ofertas seleccionadas, "Vencedores"	
//	Ultima revision ET 1oct20 16:00 licOfertasSeleccionadas_011020.js


function ActivarCambio(IDProveedorLic, IDCentro)
{
	//alert('ActivarCambio:'+IDProveedorLic);
	
	jQuery('#AVISOACCION_'+IDProveedorLic+IDCentro).html('');
	jQuery('#BOTONGUARDAR_'+IDProveedorLic+IDCentro).show();
}

function GuardarFormaYPlazoPago(IDProveedorLic)
{
	var oForm=document.forms['Proveedores'];

	//alert('GuardarFormaYPlazoPago. IDProveedorLic:'+IDProveedorLic);

	var IDLicitacion=oForm.elements['IDLicitacion'].value;
	var IDFormaPago=oForm.elements['FORMASPAGO_'+IDProveedorLic].value;
	var IDPlazoPago=oForm.elements['PLAZOSPAGO_'+IDProveedorLic].value;
	var d = new Date();

	//	alert('GuardarFormaYPlazoPago CUIDADO. IDProveedorLic:'+IDProveedorLic+' FormaPago:'+IDFormaPago+' PlazoPago:'+IDPlazoPago);

	jQuery.ajax({
		cache:	false,
		url:	'InformarFormaYPlazoPagoAJAX.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&LIC_PROV_ID="+IDProveedorLic+"&IDFORMAPAGO="+IDFormaPago+"&IDPLAZOPAGO="+IDPlazoPago+"&_="+d.getTime(),
		beforeSend: function(){
			jQuery('#BOTONGUARDAR_'+IDProveedorLic).hide();
		},
		error: function(objeto, quepaso, otroobj){
			jQuery('#AVISOACCION_'+IDProveedorLic).html('<img src="http://www.newco.dev.br/images/error.gif"/>');
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.DatosActualizados.Resultado =='OK'){
				jQuery('#AVISOACCION_'+IDProveedorLic).html('<img src="http://www.newco.dev.br/images/recibido.gif"/>');
			}else{
				jQuery('#AVISOACCION_'+IDProveedorLic).html('<img src="http://www.newco.dev.br/images/error.gif"/>');
			}
			location.reload();
		}
	})

}

function GuardarFormaYPlazoPagoCentro(IDProveedorLic, IDCentro)
{
	var oForm=document.forms['Proveedores'];

	//alert('GuardarFormaYPlazoPago. IDProveedorLic:'+IDProveedorLic);

	var IDLicitacion=oForm.elements['IDLicitacion'].value;
	//var IDCentro=oForm.elements['IDCentro'].value;
	var IDFormaPago=oForm.elements['FORMASPAGO_'+IDProveedorLic+IDCentro].value;
	var IDPlazoPago=oForm.elements['PLAZOSPAGO_'+IDProveedorLic+IDCentro].value;
	var d = new Date();

	//	alert('GuardarFormaYPlazoPagoCentro IDLicitacion:'+IDLicitacion+' IDProveedorLic:'+IDProveedorLic+' IDCentro:'+IDCentro+' FormaPago:'+IDFormaPago+' PlazoPago:'+IDPlazoPago);
	
	//solodebug return;

	jQuery.ajax({
		cache:	false,
		url:	'InformarFormaYPlazoPagoCentroAJAX.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&IDCENTRO="+IDCentro+"&LIC_PROV_ID="+IDProveedorLic+"&IDFORMAPAGO="+IDFormaPago+"&IDPLAZOPAGO="+IDPlazoPago+"&_="+d.getTime(),
		beforeSend: function(){
			jQuery('#BOTONGUARDAR_'+IDProveedorLic+IDCentro).hide();
		},
		error: function(objeto, quepaso, otroobj){
			jQuery('#AVISOACCION_'+IDProveedorLic+IDCentro).html('<img src="http://www.newco.dev.br/images/error.gif"/>');
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.DatosActualizados.Resultado =='OK'){
				jQuery('#AVISOACCION_'+IDProveedorLic+IDCentro).html('<img src="http://www.newco.dev.br/images/recibido.gif"/>');
			}else{
				jQuery('#AVISOACCION_'+IDProveedorLic+IDCentro).html('<img src="http://www.newco.dev.br/images/error.gif"/>');
			}
			location.reload();
		}
	})

}

//	24oct16	Mostrar conversacion con proveedor
function conversacionProveedor(ProvID)
{
	var oForm=document.forms['Proveedores'];
	var IDLicitacion=oForm.elements['IDLicitacion'].value;
	MostrarPagPersonalizada('ConversacionLicitacion.xsql?IDLICITACION='+IDLicitacion+'&IDPROVEEDOR='+ProvID,'',70,70,0,0);
}

// Funcion que devuelve un fichero excel con detalles de los vencedores de la licitacion
function listadoExcel(){
	var oForm=document.forms['Proveedores'];
	var IDLicitacion=oForm.elements['IDLicitacion'].value;

	var d = new Date();

	jQuery.ajax({
		url:	"http://www.newco.dev.br/Gestion/Comercial/LicitacionesExcel.xsql",
		data:	"IDLIC="+IDLicitacion+"&SOLOADJUDICADAS=S&_="+d.getTime(),

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

			if(data.estado == 'ok')
				window.location='http://www.newco.dev.br/Descargas/'+data.url;
			else
				alert(alrt_errorDescargaFichero);
		}
	});
}


//	3ene20 Crea un pedido para un proveedor
function crearPedido(IDProveedorLic, IDCentro, revisarUdesLote)
{
	var mensaje;
	jQuery("#btnCrearPedido_"+IDProveedorLic).hide();

	//solodebug console.log('crearPedido.IDProveedorLic:'+IDProveedorLic+' IDCentro:'+IDCentro+' revisarUdesLote:'+revisarUdesLote);
	
	
	if (revisarUdesLote>0)
	{
		mensaje=strConfirmarPedidoConCambioUdes+'\n\n';
		
		//	Prepara un mensaje personalizado con los cambios
		var Encontrado='N';
		for (var i=0;(i<arrProveedores.length)&&(Encontrado=='N');++i)
		{
			if ((arrProveedores[i].IDProvLic==IDProveedorLic)&&(arrProveedores[i].IDCentro==IDCentro))
			{
			
				//solodebug	console.log('crearPedido.IDProveedorLic:'+IDProveedorLic+':'+arrProveedores[i].Nombre);
				
				//	Recorre los productos comprobando cantidad y unidades por lote
				for (var j=0;(j<arrProveedores[i].Productos.length);++j)
				{
					var cant=desformateaDivisa(arrProveedores[i].Productos[j].Cantidad);
					var udesLote=desformateaDivisa(arrProveedores[i].Productos[j].UdsXLote);
					
					if (cant%udesLote!=0)
					{
						var nuevaCant=(Math.floor(cant/udesLote)+1)*udesLote;

						//solodebug console.log('crearPedido.IDProveedorLic:'+IDProveedorLic+':'+arrProveedores[i].Nombre+' cant:'+cant+' udesLote:'+udesLote+' nuevaCant:'+nuevaCant);
						mensaje+=strAvisoCambioUnidades.replace('[[REFPRODUCTO]]',arrProveedores[i].Productos[j].RefCliente).replace('[[PRODUCTO]]',arrProveedores[i].Productos[j].Nombre).replace('[[UNIDADES_OLD]]',cant.toFixed(0)).replace('[[UNIDADESPORLOTE]]',udesLote.toFixed(0)).replace('[[UNIDADES_NEW]]',nuevaCant.toFixed(0))+'\n\n';
					}
				}
			
				Encontrado='S';
			}
		}
		
		
	}
	else if (conCircuitoAprobacion=='S') mensaje=strConfirmarPedidoConCircuito;
		else mensaje=strConfirmarPedido;
		
	if (confirm(mensaje))
	{
		var oForm=document.forms['Proveedores'];
		var codPedido=(jQuery("#CODPEDIDO_"+IDProveedorLic).length)?jQuery("#CODPEDIDO_"+IDProveedorLic).val():'';
		oForm.elements['ACCION'].value='PEDIDO';
		oForm.elements['PARAMETROS'].value=IDProveedorLic;
		oForm.elements['CODPEDIDO'].value=codPedido;
		oForm.elements['IDCENTROPEDIDO'].value=IDCentro;

		//solodebug console.log('crearPedido.IDProveedorLic:'+IDProveedorLic+' IDCentro:'+IDCentro);

		//alert(codPedido);return;

		SubmitForm(oForm);
	}
	else
		jQuery("#btnCrearPedido_"+IDProveedorLic).show();
}


//	7set20 Lanza todos los pedidos (la comprobación de condiciones se hace antes)
function LanzarTodosPedidos(Actual, NumErrores)
{
	//console.log('LanzarTodosPedidos:'+Actual+'/'+arrProveedores.length);

	if (Actual>=arrProveedores.length) 
	{
		if (NumErrores==0)
		{
			alert(alrt_GenerarPedidoOK);
			Recarga();
			return;
		}
		else
		{
			//	Recargamos igualmente, para que el comprador tenga la info actualizada de los pedidos
			Recarga();
			return;
		}
	}
	
	//	Si el proveedor/centro ya tiene pedido creado, pasa al siguiente
	if (arrProveedores[Actual].IDMultioferta!='')
	{
		if (arrProveedores.length>Actual+1) LanzarTodosPedidos(Actual+1, NumErrores)
		return;
	}
		
	
	jQuery("#txtPrepPedido").html((Actual+1)+'/'+arrProveedores.length);
	console.log('LanzarTodosPedidos('+Actual+'): '+arrProveedores[Actual].Nombre+' IDProveedorLic:'+arrProveedores[Actual].IDProvLic+' IDCentro:'+arrProveedores[Actual].IDCentro);

	var codPedido=(jQuery("#CODPEDIDO_"+arrProveedores[Actual].IDProvLic).length)?jQuery("#CODPEDIDO_"+arrProveedores[Actual].IDProvLic).val():'';

	var d = new Date();
	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/GenerarPedidoProveedorCentro.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&IDPROVEEDORLIC="+arrProveedores[Actual].IDProvLic+"&IDCENTRO="+arrProveedores[Actual].IDCentro+"&CODPEDIDO="+codPedido+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		beforeSend: function(){
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.Resultado.Estado == 'OK')
			{
				LanzarTodosPedidos(Actual+1, NumErrores);
			}
			else
			{
				alert(alrt_ErrorPedido.replace('[[PROVEEDOR]]',arrProveedores[Actual].Nombre)+' '+data.Resultado.Mensaje);
				LanzarTodosPedidos(Actual+1, NumErrores+1);
			}
		}
	});
}



/*
	IMPORTANTE: Código de adjudicación y lanzamiento de pedidos traido desde la página principal de la licitación
				Múltiples cambios en validaciones previas a la adjudicación
				Cuidado al modificar!
	
	25jun20
*/


// Funcion (AJAX) que lanza el proceso que genera los pedidos necesarios en una licitacion de pedido puntual
function GenerarPedido(){
	var d = new Date();
	var mensaje;
	
	if (numProdsRevisarUdesLote>0) mensaje=strConfirmarPedidoConCambioUdes;
	else if (conCircuitoAprobacion=='S') mensaje=strConfirmarPedidoConCircuito;
		else mensaje=strConfirmarPedido;

	if (confirm(mensaje))
	{
		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/GenerarPedido.xsql',
			type:	"GET",
			data:	"LIC_ID="+IDLicitacion+"&_="+d.getTime(),
			contentType: "application/xhtml+xml",
			beforeSend: function(){
				jQuery("#botonGenerarPedido").hide();
				jQuery("#waitBotonGenPedido").show();
			},
			error: function(objeto, quepaso, otroobj){
				alert('error'+quepaso+' '+otroobj+' '+objeto);
			},
			success: function(objeto){
				//var data = eval("(" + objeto + ")");
				var data = JSON.parse(objeto);

				if(data.Resultado.Estado == 'OK')
				{
					jQuery("#waitBotonGenPedido").hide();
					alert(alrt_GenerarPedidoOK);
					Recarga();	//23jul19	location.reload();
				}
				else
				{
					jQuery("#waitBotonGenPedido").hide();
					jQuery("#botonGenerarPedido").show();
					alert(data.Resultado.Mensaje);
				}
			}
		});
	}
}




//	10jul18 Adjudica producto a producto, múltiples ofertas seleccionadas
function AdjudicarOfertasMultiples()
{
	var errores='',resAdjudicacion='',debug='',prodAdju=0,prodOpcion1=0,cadAdjudicados;

	//solodebug	debug('AdjudicarOfertasMultiples 13jul18 10:52');
	
	//Revisa la situación de la adjudicación, solicita confirmación del usuario antes de adjudicar
	if(totalProductos = 0)
	{
		errores=str_licSinProductos;
	}
	else
	{
		for(var i=0; i<arrProductos.length; i++)
		{
			//debug=debug+'i:'+arrProductos[i].IDProdLic+'|';
			var Adjud='N',Orden1='N';
			resAdjudicacion+='('+arrProductos[i].RefEstandar+') '+arrProductos[i].Nombre+':';
			cadAdjudicados='';
			for (var j=0; j<arrProductos[i].Ofertas.length; ++j)
			{
				if (arrProductos[i].Ofertas[j].OfertaAdjud=='S')
				{
					Adjud='S';
					if (arrProductos[i].Ofertas[j].Orden=='1') Orden1='S';
					
					cadAdjudicados+=((cadAdjudicados=='')?'':',')+arrProductos[i].Ofertas[j].Orden;
				}
			}
			
			if (Adjud=='S') ++prodAdju;
			if (Orden1=='S') ++prodOpcion1;
			resAdjudicacion+=((cadAdjudicados=='')?str_NoAdjudicado:cadAdjudicados)+'\n\r';
		}
		//debug('AdjudicarOfertasMultiples:'+debug);
		
		if (prodAdju==0) 
		{
			errores=alrt_sinProductosSeleccionados;
		}
		else
		{
			resAdjudicacion=alrt_SeleccionadosYOrden1.replace('[[NUM_PROD_TOTAL]]',arrProductos.length).replace('[[NUM_PROD_ADJ]]',prodAdju).replace('[[NUM_ORDEN1]]',prodOpcion1)+'\n\r\n\r'+resAdjudicacion;
		}
	}

	if ((errores=='')&&(confirm(resAdjudicacion)))
	{
		errorAdjud='N';
		AdjudicarOfertasMultiplesAjax(0);
	}
	else
	{
		alert(errores);
	}

	//solodebug	
	debug('AdjudicarOfertasMultiples: Saliendo. errores: ['+errores+'] resAdjudicacion: ['+resAdjudicacion+']');
	
}


//	16mar18	Una vez creada la cadena completa, la enviamos por bloques
var errorAdjud;
function AdjudicarOfertasMultiplesAjax(fila)
{
	//var thisRowID, thisPosArr, thisLicProdID, isThisChecked;
	//var ListaOfertasPagina = '', errores = 0, numProdsTotal = 0, numProdsLista = 0, numProdsAdj = 0;
	var d = new Date();

	//solodebug	
	debug('AdjudicarOfertasMultiplesAjax:'+fila+ ' errorAdjud:'+errorAdjud);
	

	if ((fila==arrProductos.length)||(errorAdjud=='S'))
	{
		if (errorAdjud=='N')
		{
			alert(alrt_guardarAdjudicacionOK);
			CambioEstadoLicitacion('CONT');
		}

		return;
	}

	//solodebug	
	debug('AdjudicarOfertasMultiplesAjax. fila:'+fila+' IDProdLic:'+arrProductos[fila].IDProdLic);


	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/AdjudicarProductoMultiplesOfertasAJAX.xsql',
		type:	"GET",
		data:	"IDLIC="+IDLicitacion+"&IDPRODUCTOLIC="+arrProductos[fila].IDProdLic+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			jQuery("#botonAdjudicarSelec").hide();
			jQuery("#idAvanceAdjudicar").show();
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.Resultado.Estado == 'OK'){
				jQuery('#idAvanceAdjudicar').html((fila+1)+'/'+arrProductos.length);
				++fila;

				//solodebug		debug('AdjudicarOfertasMultiplesAjax. SIGUIENTE. fila:'+fila);
				
				AdjudicarOfertasMultiplesAjax(fila);
			}
			else
			{
				errorAdjud='S';
				alert(alrt_guardarAdjudicacionKO);
				jQuery("#botonAdjudicarSelec").show();
				jQuery("#idAvanceAdjudicar").hide();
			}

			return;
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
			errorAdjud='S';
			return;
		}
	});

}



//	Prepara para lanzar todos los pedidos (lic SPOT)
function PreparaLanzarTodosPedidos(){
	var checkAdj = true, confirmChk=false, checkUdsXLote=false;

	jQuery('.botonAccion').hide();
	
	//	Control de productos seleccionados
	if (numProdsSeleccion==0) {
		productosOlvidados = 'S';
	}
	else{
		productosOlvidados = 'N';
	}
		
		
	//solodebug	console.log('PreparaLanzarTodosPedidos numProdsSeleccion:'+numProdsSeleccion+' productosOlvidados:'+productosOlvidados);
		

	if(productosOlvidados == 'N'){

		//ET 22/2/16	alert('Probando, paso1, pedidos minimos');//ET 22/2/16

		// Solo validamos importe pedido minimo para licitaciones de 'pedido puntual'
		if((mesesSelected == 0)&&(numProvsNoCumplen>0))
		{
			if (saltarPedMinimo=='N')						//	7nov19 Permitir saltar pedido mínimo
				alert(alrt_pedidoMinimoGlobalKO);
			else
			{
				checkAdj=confirm(alrt_avisoSaltarPedidoMinimo);
			}
		}
	
		if((mesesSelected == 0)&&(fechaEntregaPedidoVencida=='S'))
		{
			checkAdj=confirm(alrt_FechaEntregaVencida);
		}
		
		if ((checkAdj)&&(mesesSelected == 0))
		{
			//	Control de unidades por lote
			var mensaje=strConfirmarPedidoConCambioUdes+'\n\n';

			//	Prepara un mensaje personalizado con los cambios
			var HayProblema='N';
			for (var i=0;(i<arrProveedores.length);++i)
			{
				//solodebug	console.log('PreparaLanzarTodosPedidos.IDProveedorLic:'+arrProveedores[i].IDProvLic+':'+arrProveedores[i].Nombre+' IDMultioferta:'+arrProveedores[i].IDMultioferta);

				if (arrProveedores[i].IDMultioferta=='')	//	Solo comprobamos los proveedores que no están pendientes de generar pedido
				{
					//	Recorre los productos comprobando cantidad y unidades por lote
					for (var j=0;(j<arrProveedores[i].Productos.length);++j)
					{
						var cant=desformateaDivisa(arrProveedores[i].Productos[j].Cantidad);
						var udesLote=desformateaDivisa(arrProveedores[i].Productos[j].UdsXLote);

						if (cant%udesLote!=0)
						{
							HayProblema='S';
							var nuevaCant=(Math.floor(cant/udesLote)+1)*udesLote;

							//solodebug 	console.log('PreparaLanzarTodosPedidos.IDProveedorLic:'+arrProveedores[i].IDProvLic+':'+arrProveedores[i].Nombre+' cant:'+cant+' udesLote:'+udesLote+' nuevaCant:'+nuevaCant);
							
							mensaje+=strAvisoCambioUnidades.replace('[[REFPRODUCTO]]',arrProveedores[i].Productos[j].RefCliente).replace('[[PRODUCTO]]',arrProveedores[i].Productos[j].Nombre).replace('[[UNIDADES_OLD]]',cant.toFixed(0)).replace('[[UNIDADESPORLOTE]]',udesLote.toFixed(0)).replace('[[UNIDADES_NEW]]',nuevaCant.toFixed(0))+'\n\n';
						}
					}	//	for arrProveedores[i].Productos
				}

			}	//	for arrProveedores

			//	Si se han detectado cambios a nivel de unidades por lote y el comprador no los confirma, salimos de la función
			if (HayProblema=='S')
			{
				if (!confirm(mensaje)) return;
			}
						
		}

		//ET 22/2/16	alert('Probando, paso2, pedidos minimos:'+checkAdj);//ET 22/2/16

		if(checkAdj){
			// Comprobamos cantidad respecto udsXLote del proveedor
				
			// Antes de adjudicar pedimos confirmacion
			if(numProdsSeleccion < totalProductos){
				if(confirm(conf_adjudicar1 + conf_adjudicar2.replace("[[NUM_PROD_TOTAL]]", totalProductos).replace("[[NUM_PROD_ADJ]]", numProdsSeleccion))){
					confirmChk = true;
				}
			}else{
				if(confirm(conf_adjudicar1)){
					confirmChk = true;
				}
			}

			//ET 22/2/16	alert('Probando, paso, confirmar adjudicación:'+confirmChk);//ET 22/2/16
			if(confirmChk)
			{
				jQuery("#botonAdjudicarSelec").hide();	//25oct17
				jQuery("#waitBotonAdjudicar").show();	//25oct17

				//CambioEstadoLicitacion('ADJ');
				
				LanzarTodosPedidos(0,0);
				
			}
		}
	}else{
		alert(alrt_faltaSeleccProductos);
	}

	//ET 22/2/16	alert('Probando, SALIDA');//ET 22/2/16
	jQuery('.botonAccion').show();
}


//	Adjudica ofertas (no SPOT)
function AdjudicarOfertas(){
	var checkAdj = true, confirmChk=false, checkUdsXLote=false;

	jQuery('.botonAccion').hide();
	
	//	21set16	Hacemos aqui las comprobaciones básicas que pueden dar lugar a errores antes de adjudicar
	//3oct16 Solo mostramos el aviso si no hay productos selecionados	if (((arrProductos.length>numProductos) && (numProdsSeleccion<numProductos))||(numProdsSeleccion==0)) {
	if (numProdsSeleccion==0) {
		productosOlvidados = 'S';
	}
	else{
		productosOlvidados = 'N';
	}
		
		
	//solodebug	alert('AdjudicarOfertas numProdsSeleccion:'+numProdsSeleccion+' productosOlvidados:'+productosOlvidados);
		

	if(productosOlvidados == 'N'){

		//ET 22/2/16	alert('Probando, paso1, pedidos minimos');//ET 22/2/16

		// Solo validamos importe pedido minimo para licitaciones de 'pedido puntual'
		if((mesesSelected == 0)&&(numProvsNoCumplen>0))
		{
			if (saltarPedMinimo=='N')						//	7nov19 Permitir saltar pedido mínimo
				alert(alrt_pedidoMinimoGlobalKO);
			else
				checkAdj=confirm(alrt_avisoSaltarPedidoMinimo);
		}

		//ET 22/2/16	alert('Probando, paso2, pedidos minimos:'+checkAdj);//ET 22/2/16

		if(checkAdj){
			// Comprobamos cantidad respecto udsXLote del proveedor
				
			//ET 22/2/16	alert('Probando, paso3, comprueba unidades lote:'+checkUdsXLote);//ET 22/2/16

			/* PENDIENTE VER CUAL ES EL MEJOR MOMENTO PARA ACTUALIZAR CANTIDADES			
			
			
			if(numProdsRevisarUdesLote>0){
			
				if(!confirm(conf_autoeditar_uds_x_lote))
				{
					jQuery('.botonAccion').show();
					return;
				}
			}	*/

			// Antes de adjudicar pedimos confirmacion
			if(numProdsSeleccion < totalProductos){
				if(confirm(conf_adjudicar1 + conf_adjudicar2.replace("[[NUM_PROD_TOTAL]]", totalProductos).replace("[[NUM_PROD_ADJ]]", numProdsSeleccion))){
					confirmChk = true;
				}
			}else{
				if(confirm(conf_adjudicar1)){
					confirmChk = true;
				}
			}

			//ET 22/2/16	alert('Probando, paso, confirmar adjudicación:'+confirmChk);//ET 22/2/16
			if(confirmChk)
			{
				jQuery("#botonAdjudicarSelec").hide();	//25oct17
				jQuery("#waitBotonAdjudicar").show();	//25oct17
				CambioEstadoLicitacion('ADJ');
			}
		}
	}else{
		alert(alrt_faltaSeleccProductos);
	}

	//ET 22/2/16	alert('Probando, SALIDA');//ET 22/2/16
	jQuery('.botonAccion').show();
}



// Cambiamos estado de la licitacion, ya sea pq se inicia ('EST' => 'CURS') 16ago16:('EST' => 'COMP') ('COMP' => 'CURS')
// Ya sea pq se adjudica ('CURS' => 'ADJ' o 'INF' => 'ADJ')
function CambioEstadoLicitacion(IDEstado){
	var Comentarios	= '', IDProveedor = '';
	var d = new Date();
	var	enviarCambio = true;
	
	//	En el caso de licitación agregada, comprobamos si hay centros pendientes antes de iniciar
	if ((IDEstado=='CURS') && (isLicAgregada=='S') && (NumCentrosPendientes>0) && (confirm(conf_CentrosPendientesInformar.replace('#NUMCENTROS#', NumCentrosPendientes))==false))
	{
		enviarCambio = false;
	}
	
	if (enviarCambio){
		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/CambiarEstadoLicitacion.xsql',
			type:	"GET",
			data:	"ID_LIC="+IDLicitacion+"&ID_ESTADO="+IDEstado+"&ID_PROVEEDOR="+IDProveedor+"&COMENTARIOS="+Comentarios+"&_="+d.getTime(),
			contentType: "application/xhtml+xml",
			error: function(objeto, quepaso, otroobj){
				alert('error'+quepaso+' '+otroobj+' '+objeto);
			},
			success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

				if(data.NuevoEstado.estado == 'OK'){
					Recarga();
				}else{
					alert(alrt_NuevoEstadoLicKO);
					jQuery("#botonAdjudicarSelec").show();
					jQuery("#waitBotonAdjudicar").hide();
				}
			}
		});
	}
}







//	Reloadd puede enviar parámetros equivocados
function Recarga()
{
	window.open('http://www.newco.dev.br/Gestion/Comercial/licOfertasSeleccionadas.xsql?LIC_ID='+IDLicitacion,'_self');
	
}
