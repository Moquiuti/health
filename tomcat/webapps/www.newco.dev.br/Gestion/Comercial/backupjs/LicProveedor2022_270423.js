//	Separamos librer�a con funciones que solo son utilizadas por los proveedores
//	Ultima revision ET 28abr23 10:50 LicProveedor2022_270423.js

//	Reload puede enviar par�metros equivocados
function RecargaLicProv()
{
	window.open('http://www.newco.dev.br/Gestion/Comercial/LicProveedor2022.xsql?LIC_ID='+IDRegistro,'_self');	
}


//	Publica el pedido m�nimo
function publicarPedidoMinimo(oForm){
	var IDProvLic		= oForm.elements['LIC_PROV_ID'].value;
	var PedidoMinimoProv	= oForm.elements['LIC_PROV_PEDIDOMINIMO'].value;
	var ComentariosProv	= encodeURIComponent(oForm.elements['LIC_PROV_COMENTARIOSPROV'].value.replace(/'/g, "''"));
	var Frete	= oForm.elements['LIC_PROV_FRETE'].value;
	var PlazoEntrega	= oForm.elements['LIC_PROV_PLAZOENTREGA'].value;
	var IDDocumento	= oForm.elements['LIC_PROV_IDDOCUMENTO'].value;
	var IDFormaPago	= '';
	var IDPlazoPago	= '';

	if (oForm.elements['IDFORMASPAGO']) IDFormaPago	= oForm.elements['IDFORMASPAGO'].value;
	if (oForm.elements['IDPLAZOSPAGO']) IDPlazoPago	= oForm.elements['IDPLAZOSPAGO'].value;

	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/PedidoMinimoProveedor.xsql',
		type:	"GET",
		data:	"LIC_PROV_ID="+IDProvLic+"&LIC_PROV_PEDIDOMINIMO="+encodeURIComponent(PedidoMinimoProv)+"&LIC_PROV_COMENTARIOSPROV="+ComentariosProv+"&LIC_PROV_FRETE="+Frete
					+"&LIC_PROV_PLAZOENTREGA="+PlazoEntrega+"&LIC_PROV_IDFORMAPAGO="+IDFormaPago+"&LIC_PROV_IDPLAZOPAGO="+IDPlazoPago+"&LIC_PROV_IDDOCUMENTO="+IDDocumento+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			jQuery("#MensPedidoMinimo").hide();
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.Resultado.estado == 'OK'){
				if(data.Resultado.id == IDProvLic){
					pedidoMinimoInform = 'S';		// variable global para poder publicar la oferta
					validarBotonPublicarOferta();	// Validamos para habilitar el boton de 'PublicarOferta'
					jQuery("#MensPedidoMinimo").show();
					ActivarTablaProductos();
					PedidoMinimoPend='N';
				}
			}else{
				alert('ERROR');
			}
		}
	});
}

//	15jul19 Separamos la funci�n para activar la tabla de productos
function ActivarTablaProductos()
{
	//jQuery("#lTablaProductosProv").show();	//	Mostramos el DIV con los productos

	jQuery("input.descripcion").attr("disabled",false);
	jQuery("input.marca").attr("disabled",false);
	jQuery("input.unidades").attr("disabled",false);
	jQuery("input.precio").attr("disabled",false);
}

//	13feb20 Separamos el env�o del cambio de estado
function enviarCambioEstado(IDProvLic, IDEstado, ComentariosProv, mensajeOK)
{
	var d = new Date();
	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/CambiarEstadoProveedor.xsql',
		type:	"GET",
		data:	"LIC_PROV_ID="+IDProvLic+"&IDESTADO="+IDEstado+"&COMENTARIOS="+ComentariosProv+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.NuevoEstado.estado == 'OK'){
				alert(mensajeOK);
				location.href = "http://www.newco.dev.br/Gestion/Comercial/LicProveedor2022.xsql?LIC_ID=" + IDLicitacion;
			}else{
				alert(alrt_NuevoEstadoProveedorKO);
			}
		}
	});
}


//	Publica la oferta del proveedor
function publicarOferta(oForm){
	console.log('publicarOferta');
	var IDProvLic		= oForm.elements['LIC_PROV_ID'].value;
	var ComentariosProv	= encodeURIComponent(document.forms['PedidoMinimo'].elements['LIC_PROV_COMENTARIOSPROV'].value.replace(/'/g, "''"));
	var IDEstado		= oForm.elements['LIC_PROV_IDESTADO'].value;
	
	//	COmprueba que se haya guardado el pedido m�nimo
	if ((PedidoMinimoPend=='S')&&(ofertaVacia=='N'))
	{
		alert(alrt_faltaPedidoMinimo);
		return;
	}

	enviarCambioEstado(IDProvLic, IDEstado, ComentariosProv, alrt_publicarOfertaOK);
}


//	13feb20 Cancela la oferta del proveedor
function cancelarOferta()
{
	var oForm			=document.forms['PublicarOfertas'];
	var IDProvLic		= oForm.elements['LIC_PROV_ID'].value;
	var ComentariosProv	= encodeURIComponent(document.forms['PedidoMinimo'].elements['LIC_PROV_COMENTARIOSPROV'].value.replace(/'/g, "''"));

	if (confirm(conf_CancelarOferta))
		enviarCambioEstado(IDProvLic, 'CANCELAR_OFERTA', ComentariosProv, alrt_cancelarOfertaOK);
}


//	Activar el bot�n de "Publicar oferta" cuando corresponda
function validarBotonPublicarOferta(){
	if(ofertaProvInformada == 'S' && pedidoMinimoInform == 'S'){
		jQuery('#botonPublicarOferta').removeClass("btnGris");
		jQuery('#botonPublicarOferta').addClass("btnDestacado");
		jQuery('#botonPublicarOferta').text(txtBotonPublicar);			//	24feb17	Por si antes no se pod�a publicar
		
		jQuery('#txtCondLicitacion').show();
	}
}


//	Dibuja la tabla de productos, formato "proveedor informado"
function dibujaTablaProductosPROVE_INF(){
	var htmlTBODY = '', thisRow = '', thisCell = '' , thisMacro = '';
	var contLinea = 0;
		
	//solodebug	debug('dibujaTablaProductosPROVE_INF totalProductos:'+totalProductos);
	

	if(totalProductos > 0){
		// Numero de registros para mostrar en la tabla
		numProductos	= parseInt(jQuery('#numRegistros').val());
		// Redondeamos para saber el numero de paginas totales
		pagsProdTotal = Math.ceil(totalProductos / numProductos);
		// Calculamos el producto inicial y final que se tienen que mostrar en la tabla
		firstProduct	= pagProductos * numProductos;
		lastProduct	= (totalProductos < (pagProductos * numProductos) + numProductos) ? totalProductos : ((pagProductos * numProductos) + numProductos) ;

		// Correccion en la paginacion en caso particular
		if(firstProduct >= lastProduct){
			pagProductos = pagsProdTotal - 1;
			firstProduct	= pagProductos * numProductos;
		}

		for(var i=firstProduct; i<lastProduct; i++){
			contLinea++;

			// Iniciamos la fila (tr)
			thisRow = rowStartIDStyle.replace('#ID#', 'posArr_' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1));
			/*	16dic16
			if(arrProductos[ColumnaOrdenadaProds[i]].Oferta.Adjudicada == 'S'){
				thisRow = thisRow.replace('#STYLE#', 'background:#FFFF99;');
			}else{
				thisRow = thisRow.replace('#STYLE#', '');
			}*/
			thisRow = thisRow.replace('#STYLE#', '');

			// Celda/Columna numeracion
			thisCell = cellStart;
			thisCell += '&nbsp;' + contLinea + '&nbsp;';
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Ref.Cliente
			thisCell = cellStart;
			if(isLicAgregada == 'S'){
				thisMacro = macroEnlace2.replace('#HREF#', 'javascript:verInfoCentros(' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1) + ');');
				thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
				thisCell += thisMacro;
				if(arrProductos[ColumnaOrdenadaProds[i]].RefCliente != ''){
					thisCell += arrProductos[ColumnaOrdenadaProds[i]].RefCliente;	// Mostramos Ref.Cliente si existe
				}else{
					thisCell += arrProductos[ColumnaOrdenadaProds[i]].RefEstandar;	// Mostramos Ref.Estandar si no existe Ref.Cliente
				}
				thisCell += macroEnlaceEnd;
			}else{
				if(arrProductos[ColumnaOrdenadaProds[i]].RefCliente != ''){
					thisCell += arrProductos[ColumnaOrdenadaProds[i]].RefCliente;	// Mostramos Ref.Cliente si existe
				}else{
					thisCell += arrProductos[ColumnaOrdenadaProds[i]].RefEstandar;	// Mostramos Ref.Estandar si no existe Ref.Cliente
				}
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Imagen-check (adjudicado)
			thisCell = cellStart;
			if(isLicPorProducto == 'S' && (estadoLicitacion == 'ADJ' || estadoLicitacion == 'FIRM' || estadoLicitacion == 'CON')){
				if(arrProductos[ColumnaOrdenadaProds[i]].Oferta.Adjudicada == 'S'){
					thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/check.gif');
					thisMacro = thisMacro.replace('#TITLE#', str_OfertaAdjudicada);
					thisMacro = thisMacro.replace('#ALT#', str_OfertaAdjudicada);
					thisCell += thisMacro;
				}
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna iconos campos avanzados productos informados
			thisCell = cellStart;
			// Info.Ampliada
			if(arrProductos[ColumnaOrdenadaProds[i]].InfoAmpliada != ''){
				//ET 14dic16	Cambio de estilos para los tooltips
				//ET 14dic16	thisMacro = '&nbsp;' + macroEnlaceAcc.replace('#HREF#', '#');
				thisMacro = '&nbsp;' + divStartClass;
				thisMacro = thisMacro.replace('#CLASS#', 'tooltip');
				thisCell += thisMacro;
				thisCell += '<img src="http://www.newco.dev.br/images/infoAmpliadaIcon.gif" class="static"/>';
				//ET 14dic16	thisCell += spanStartClass.replace('#CLASS#', 'classic spanEIS');
				thisCell += spanStartClass.replace('#CLASS#', 'tooltiptext');
				thisCell += str_InfoAmpliada + ':<br/><br/>';
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].InfoAmpliada;
				thisCell += spanEnd;
				thisCell += macroEnlaceEnd;
			}
			// Documento
			if(typeof arrProductos[ColumnaOrdenadaProds[i]].Documento.ID !== 'undefined'){
				thisMacro = '&nbsp;'+ macroEnlaceTarget.replace('#HREF#', 'http://www.newco.dev.br/Documentos/' + arrProductos[ColumnaOrdenadaProds[i]].Documento.Url);
				thisCell += thisMacro;
				thisMacro = macroImagen3.replace('#SRC#', 'http://www.newco.dev.br/images/clipIcon.gif');
				thisMacro = thisMacro.replace('#CLASS#', 'static');
				thisMacro = thisMacro.replace('#ALT#', str_Documento);
				thisMacro = thisMacro.replace('#TITLE#', str_Documento);
				thisCell += thisMacro;
//				thisCell += '<img src="" class="static"/>';
				thisCell += macroEnlaceEnd;
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Nombre
			thisCell = cellStartClassStyle.replace('#CLASS#','datosLeft');
			thisCell = thisCell.replace('#STYLE#','padding:2px 0px 2px 4px;');
			thisCell += '<strong>' + arrProductos[ColumnaOrdenadaProds[i]].Nombre + '</strong>&nbsp;';
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna icono anyadir campos avanzados + iconos campos avanzados ofertas informados
			thisCell = cellStart;
			valAux = parseFloat(arrProductos[ColumnaOrdenadaProds[i]].Oferta.UdsXLote.replace(".","").replace(",",".")); //arrProductos[ColumnaOrdenadaProds[i]].Oferta.UdsXLote;
			if(!isNaN(valAux))
			{	
				//	Si hay oferta creamos el bot�n visible	
				functionJS = 'javascript:abrirCamposAvanzadosOfe(' + (arrProductos[ColumnaOrdenadaProds[i]].linea - 1) + ');'
				thisCell += '&nbsp;' + macroEnlace.replace('#HREF#', functionJS);
				thisCell += macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/anadir.gif').replace('#TITLE#', str_AnyadirInfoAmpliada).replace('#ALT#', str_AnyadirInfoAmpliada);
				thisCell += macroEnlaceEnd;
			}
			
			// Info.Ampliada
			if(arrProductos[ColumnaOrdenadaProds[i]].Oferta.InfoAmpliada != ''){
				//ET 14dic16	Cambio de estilos para los tooltips
				//ET 14dic16	thisMacro = '&nbsp;' + macroEnlaceAcc.replace('#HREF#', '#');
				thisMacro = '&nbsp;' + divStartClass;
				thisMacro = thisMacro.replace('#CLASS#', 'tooltip');
				thisCell += thisMacro;
				thisCell += '<img src="http://www.newco.dev.br/images/infoAmpliadaIconO.gif" class="static"/>';
				//ET 14dic16	thisCell += spanStartClass.replace('#CLASS#', 'classic spanEIS');
				thisCell += spanStartClass.replace('#CLASS#', 'tooltiptext');
				thisCell += str_InfoAmpliada + ':<br/><br/>';
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].Oferta.InfoAmpliada;
				thisCell += spanEnd;
				thisCell += macroEnlaceEnd;
			}
			// Documento
			if(typeof arrProductos[ColumnaOrdenadaProds[i]].Oferta.Documento.ID !== 'undefined'){
				thisMacro = '&nbsp;' + macroEnlaceTarget.replace('#HREF#', 'http://www.newco.dev.br/Documentos/' + arrProductos[ColumnaOrdenadaProds[i]].Oferta.Documento.Url);
				thisCell += thisMacro;
				thisMacro = macroImagen3.replace('#SRC#', 'http://www.newco.dev.br/images/clipIconO.gif');
				thisMacro = thisMacro.replace('#CLASS#', 'static');
				thisMacro = thisMacro.replace('#ALT#', str_Documento);
				thisMacro = thisMacro.replace('#TITLE#', str_Documento);
				thisCell += thisMacro;
//				thisCell += '<img src="" class="static"/>';
				thisCell += macroEnlaceEnd;
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Ref.Proveedor
			thisCell = cellStart;
			if(IDPais != '55'){
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].Oferta.RefProv;
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Ficha Tecnica
			thisCell = cellStart;
			if(arrProductos[ColumnaOrdenadaProds[i]].Oferta.FichaTecnica.ID){
				thisMacro = macroEnlaceTarget.replace('#HREF#', 'http://www.newco.dev.br/Documentos/' + arrProductos[ColumnaOrdenadaProds[i]].Oferta.FichaTecnica.Url);
				thisCell += thisMacro;
				thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/fichaChange.gif');
				thisMacro = thisMacro.replace('#TITLE#', str_FichaTecnica);
				thisMacro = thisMacro.replace('#ALT#', str_FichaTecnica);
				thisCell += thisMacro;
				thisCell += macroEnlaceEnd;
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Descripcion
			thisCell = cellStartClassStyle.replace('#CLASS#','datosLeft');
			thisCell = thisCell.replace('#STYLE#','padding:2px 0px 2px 4px;');
			thisCell += arrProductos[ColumnaOrdenadaProds[i]].Oferta.Nombre;
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Marca
			thisCell = cellStart;
			thisCell += arrProductos[ColumnaOrdenadaProds[i]].Oferta.Marca;
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Ud.Basica
			thisCell = cellStart;
			thisCell += arrProductos[ColumnaOrdenadaProds[i]].UdBasica;
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Cantidad
			thisCell = cellStart;
			thisCell += arrProductos[ColumnaOrdenadaProds[i]].Cantidad;
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna UdsXLote
			thisCell = cellStart;
			thisCell += arrProductos[ColumnaOrdenadaProds[i]].Oferta.UdsXLote;
			thisCell += cellEnd;
			thisRow += thisCell;
	
			//solodebug	console.log('PreparaLineaProductoBloqueada ('+numProd+','+ contLinea+','+Indice+'). mostrarPrecioObj:'+mostrarPrecioObj);

			if (mostrarPrecioObj=='S')
			{
	
				//solodebug	console.log('PreparaLineaProductoBloqueada ('+numProd+','+ contLinea+','+Indice+'). mostrarPrecioObj:'+mostrarPrecioObj+' Incluyendo PrecioObj y COnsumo');
	
				// Celda/Columna Precio Objetivo
				thisCell = cellStart;
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].PrecioObj;
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Consumo
				thisCell = cellStart;
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].Oferta.Consumo;
				thisCell += cellEnd;
				thisRow += thisCell;
			}

			// Celda/Columna Precio Oferta
			thisCell = cellStart;
			thisCell += arrProductos[ColumnaOrdenadaProds[i]].Oferta.Precio;
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Consumo
			thisCell = cellStart;
			if(IDPais != '55'){
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].TipoIVA + '%';
			}else{
				thisCell += '&nbsp;';
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			thisRow += rowEnd;
			htmlTBODY += thisRow;
		}

		calcularPaginacion();
        }

	jQuery('#lProductos_PROVE tbody').empty().append(htmlTBODY);
}

function dibujaTablaProductosPROVE(){
	var htmlTBODY = '', thisRow = '', thisCell = '' , thisMacro = '', functionJS, valAux;
	var contLinea = 0;
	anyChange = false;

		
	//solodebug	debug('dibujaTablaProductosPROVE totalProductos:'+totalProductos);

	if(totalProductos > 0){
		// Numero de registros para mostrar en la tabla
		numProductos	= parseInt(jQuery('#numRegistros').val());			//	Desplegable de paginaci�n
		// Redondeamos para saber el numero de paginas totales
		pagsProdTotal = Math.ceil(totalProductos / numProductos);
		// Calculamos el producto inicial y final que se tienen que mostrar en la tabla
		firstProduct	= pagProductos * numProductos;
		lastProduct	= (totalProductos < (pagProductos * numProductos) + numProductos) ? totalProductos : ((pagProductos * numProductos) + numProductos) ;

		
		//solodebug	debug('dibujaTablaProductosPROVE firstProduct:'+firstProduct+' lastProduct:'+lastProduct+' numProductos:'+numProductos+' pagsProdTotal:'+pagsProdTotal+' totalProductos:'+totalProductos);


		// Correccion en la paginacion en caso particular
		if(firstProduct >= lastProduct){
			pagProductos = pagsProdTotal - 1;
			firstProduct = pagProductos * numProductos;
		}
		
		//solodebug	console.log('dibujaTablaProductosPROVE firstProduct:'+firstProduct+' lastProduct:'+lastProduct+' numProductos:'+numProductos+' pagsProdTotal:'+pagsProdTotal+' totalProductos:'+totalProductos);

		numOfertas=0;

		for(var i=firstProduct; i<lastProduct; i++)
		{
			contLinea++;
			
			if (arrProductos[ColumnaOrdenadaProds[i]].Oferta.UdsXLote && arrProductos[ColumnaOrdenadaProds[i]].Oferta.UdsXLote>0) ++numOfertas;

			if ((arrProductos[ColumnaOrdenadaProds[i]].Oferta.Informada=='S')&&(arrProductos[ColumnaOrdenadaProds[i]].Oferta.ProdAdjudicado=='S'))
				thisRow=PreparaLineaProductoBloqueada(i, contLinea);		//	3dic20
			else
				thisRow=PreparaLineaProducto(i, contLinea);
			
			htmlTBODY += thisRow;
		}
		
		ofertaVacia=(numOfertas==0)?'S':'N';
		
		//solodebug	debug('dibujaTablaProductosPROVE. numOfertas:'+numOfertas+' ofertaVacia:'+ofertaVacia);
		
		calcularPaginacion();
	}
	jQuery('#lProductos_PROVE tbody').empty().append(htmlTBODY);

	// Ahora recalculamos los valores del floatinBox
	if(jQuery(".FBox").length)
		MostrarFloatingBox_PROV();
		
		
	//solodebug	MuestraMatrizOfertas();		//21mar19
}


//	3dic20 Prepara el HTML correspondiente a una l�nea de producto bloqueada (producto adjudicado)
//	numProd: �ndice en el array, contLinea: contador de l�neas en pantalla (depende de la paginaci�n)
function PreparaLineaProductoBloqueada(numProd, contLinea)
{
	var	thisRow='';
	
	var Indice=arrProductos[ColumnaOrdenadaProds[numProd]].linea-1;		//	 En pantalla mostramos a partir del 1
	
	//solodebug	console.log('PreparaLineaProductoBloqueada ('+numProd+','+ contLinea+','+Indice+')');
	
	try
	{
		// Iniciamos la fila (tr)
		thisRow = rowStartIDClass.replace('#ID#', 'posArr_' + (Indice));
		thisRow = thisRow.replace('#CLASS#', 'infoProds fondoAmarillo');

		// Celda/Columna numeracion
		thisCell = cellStart;
		thisCell += '&nbsp;' + contLinea+ '&nbsp;';
		
		//solodebug	thisCell += '&nbsp;[' + arrProductos[ColumnaOrdenadaProds[numProd]].IDProdLic+ ']&nbsp;';
		
		thisCell += cellEnd;
		thisRow += thisCell;


		//	21mar19	Input hidden con el ID de producto
		thisCell=macroInputHidden
		thisCell = thisCell.replace('#ID#', 'IDPRODLIC_'+ (Indice));
		thisCell = thisCell.replace('#NAME#', 'IDPRODLIC_'+ (Indice));
		thisCell = thisCell.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].IDProdLic);
		thisRow += thisCell;

		//	15mar19	Input hidden con el ID de oferta
		thisCell=macroInputHidden
		thisCell = thisCell.replace('#ID#', 'IDOFERTALIC_'+ (Indice));
		thisCell = thisCell.replace('#NAME#', 'IDOFERTALIC_'+ (Indice));
		thisCell = thisCell.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.ID);
		thisRow += thisCell;

		//	15mar19	Input hidden con el numero de alternativa
		thisCell=macroInputHidden
		thisCell = thisCell.replace('#ID#', 'ALTERNATIVA_'+ (Indice));
		thisCell = thisCell.replace('#NAME#', 'ALTERNATIVA_'+ (Indice));
		thisCell = thisCell.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Alternativa);
		thisRow += thisCell;

		// Celda/Columna Ref.Cliente
		thisCell = cellStart;
		if(isLicAgregada == 'S'){
			thisMacro = macroEnlace2.replace('#HREF#', 'javascript:verInfoCentros(' + (Indice) + ');');
			thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
			thisCell += thisMacro;
			if(arrProductos[ColumnaOrdenadaProds[numProd]].RefCliente != ''){
				thisCell += arrProductos[ColumnaOrdenadaProds[numProd]].RefCliente;	// Mostramos Ref.Cliente si existe
			}else{
				thisCell += arrProductos[ColumnaOrdenadaProds[numProd]].RefEstandar;	// Mostramos Ref.Estandar si no existe Ref.Cliente
			}
			thisCell += macroEnlaceEnd;
		}else{
			if(arrProductos[ColumnaOrdenadaProds[numProd]].RefCliente != ''){
				thisCell += arrProductos[ColumnaOrdenadaProds[numProd]].RefCliente;	// Mostramos Ref.Cliente si existe
			}else{
				thisCell += arrProductos[ColumnaOrdenadaProds[numProd]].RefEstandar;	// Mostramos Ref.Estandar si no existe Ref.Cliente
			}
		}
		thisCell += cellEnd;
		thisRow += thisCell;

		// Celda/Columna Ficha Tecnica
		thisCell = cellStart;
		thisMacro = macroEnlace2.replace('#HREF#', 'javascript:verFichas(' + (Indice) + ');');
		thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
		thisCell += thisMacro;
		thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/masFicha.gif');
		thisMacro = thisMacro.replace('#TITLE#', str_FichaTecnica);
		thisMacro = thisMacro.replace('#ALT#', str_FichaTecnica);
		thisCell += thisMacro;
		thisCell += macroEnlaceEnd;
		thisCell += cellEnd;
		thisRow += thisCell;

		// Celda/Columna iconos campos avanzados productos informados
		thisCell = cellStart;
		// Info.Ampliada
		if(arrProductos[ColumnaOrdenadaProds[numProd]].InfoAmpliada != ''){
			thisMacro = '&nbsp;' + divStartClass;
			thisMacro = thisMacro.replace('#CLASS#', 'tooltip');
			thisCell += thisMacro;
			thisCell += '<img src="http://www.newco.dev.br/images/infoAmpliadaIcon.gif" class="static"/>';
			thisCell += spanStartClass.replace('#CLASS#', 'tooltiptext');
			thisCell += str_InfoAmpliada + ':<br/><br/>';
			thisCell += arrProductos[ColumnaOrdenadaProds[numProd]].InfoAmpliada;
			thisCell += spanEnd;
			thisCell += macroEnlaceEnd;
		}
		// Documento
		if(typeof arrProductos[ColumnaOrdenadaProds[numProd]].Documento.ID !== 'undefined'){
			thisMacro = '&nbsp;'+ macroEnlaceTarget.replace('#HREF#', 'http://www.newco.dev.br/Documentos/' + arrProductos[ColumnaOrdenadaProds[numProd]].Documento.Url);
			thisCell += thisMacro;
			thisMacro = macroImagen3.replace('#SRC#', 'http://www.newco.dev.br/images/clipIcon.gif');
			thisMacro = thisMacro.replace('#CLASS#', 'static');
			thisMacro = thisMacro.replace('#ALT#', str_Documento);
			thisMacro = thisMacro.replace('#TITLE#', str_Documento);
			thisCell += thisMacro;
	//				thisCell += '<img src="" class="static"/>';
			thisCell += macroEnlaceEnd;
		}
		thisCell += cellEnd;
		thisRow += thisCell;

		// Celda/Columna Nombre
		thisCell = cellStartClassStyle.replace('#CLASS#','datosLeft');
		thisCell = thisCell.replace('#STYLE#','padding:2px 0px 2px 4px;width:1000px;');
		thisCell += '<strong>' + NombreProductoConEstilo(numProd) + '</strong>&nbsp;';
		thisCell += cellEnd;
		thisRow += thisCell;

		// Celda/Columna icono anyadir campos avanzados + iconos campos avanzados oferta informados
		thisCell = cellStart;
		valAux = parseFloat(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.UdsXLote.replace(".","").replace(",",".")); 
/*		
		// Documento
		if((typeof arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Documento.ID !== 'undefined')&&(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Documento.ID!=''))
		{
			//solodebug	debug('Tabla productos. numProd:'+numProd+' url:'+arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Documento.Url);
		
			thisMacro = '&nbsp;' + macroEnlaceTarget.replace('#HREF#',(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Documento.Url.substring(0,7)=='http://'?'':'http://www.newco.dev.br/Documentos/') 
															+ arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Documento.Url);
			thisCell += thisMacro;
			thisMacro = macroImagen3.replace('#SRC#', 'http://www.newco.dev.br/images/clipIconO.gif');
			thisMacro = thisMacro.replace('#CLASS#', 'static');
			thisMacro = thisMacro.replace('#ALT#', str_Documento);
			thisMacro = thisMacro.replace('#TITLE#', str_Documento);
			thisCell += thisMacro;
	//				thisCell += '<img src="" class="static"/>';
			thisCell += macroEnlaceEnd;
		}
*/
		thisCell += cellEnd;
		thisRow += thisCell;

		// Celda/Columna Ref.Proveedor
		thisCell = cellStart;
		if(IDPais != '55'){
			thisMacro = macroInputHidden.replace('#NAME#', 'RefProv_' + (Indice));
			thisMacro = thisMacro.replace('#ID#', 'RefProv_' + (Indice));
			if(isLicPorProducto == 'S'){
				if(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.RefProv != ''){
					thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.RefProv);
				}else{
					thisMacro = thisMacro.replace('#VALUE#', '');
				}
			}else{
				thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.RefProv);
			}
			thisCell += thisMacro;
			thisCell += arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.RefProv
		}
		thisCell += cellEnd;
		thisRow += thisCell;

		// Celda/Columna Descripcion
		thisCell = cellStartStyle.replace('#STYLE#','text-align:left;');
		thisMacro = macroInputHidden.replace('#NAME#', 'Desc_' + (Indice));
		thisMacro = thisMacro.replace('#ID#', 'Desc_' + (Indice));
		var Cadena;
		if(isLicPorProducto == 'S'){
			if(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Nombre != '' || (arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Precio != '0,0000' && arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Precio != '')){
				thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Nombre);
				Cadena=arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Nombre;
			}
			else
			{
				if (arrProductos[ColumnaOrdenadaProds[numProd]].OfertaAnterior === 'S')
				{
					thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Anterior.Producto);
					Cadena = arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Anterior.Producto;
				}
				else
				{
					thisMacro = thisMacro.replace('#VALUE#', '');
				}
			}
		}
		else
		{
			thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Nombre);
			Cadena = arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Nombre
		}
		thisCell += thisMacro;
		thisCell += '&nbsp;'+Cadena;
		thisCell += cellEnd;
		thisRow += thisCell;

		// Celda/Columna Marca
		thisCell = cellStartStyle.replace('#STYLE#','text-align:left;');

		thisMacro = macroInputHidden.replace('#NAME#', 'Marca_' + (Indice));
		thisMacro = thisMacro.replace('#ID#', 'Marca_' + (Indice));
		if(isLicPorProducto == 'S'){
			if(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Marca != '' || (arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Precio != '0,0000' && arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Precio != '')){
				thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Marca);
				Cadena=arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Marca;
			}
			else
			{
				if (arrProductos[ColumnaOrdenadaProds[numProd]].OfertaAnterior === 'S')
				{
					thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Anterior.Marca);
					Cadena = arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Anterior.Marca;
				}
				else
				{
					//25mar19	thisMacro = thisMacro.replace('#VALUE#', str_SinOfertar);
					thisMacro = thisMacro.replace('#VALUE#', '');
					Cadena='';
				}
			}
		}
		else
		{
			thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Marca);
			Cadena = arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Marca;
		}

		thisCell += thisMacro;
		thisCell += '&nbsp;'+Cadena;
		thisCell += cellEnd;
		thisRow += thisCell;

		// Celda/Columna UdBasica
		thisCell = cellStartClass.replace('#CLASS#', 'udBasica');
		thisCell += arrProductos[ColumnaOrdenadaProds[numProd]].UdBasica;
		thisCell += cellEnd;
		thisRow += thisCell;

		// Celda/Columna Cantidad
		thisCell = cellStart;

		//	27abr23 Programacion de entregas
		if (arrProductos[ColumnaOrdenadaProds[numProd]].Entregas!='')
		{
			thisCell += '<a class="floatLeft" href="javascript:EntregasProducto('+ColumnaOrdenadaProds[numProd]+');"><img src="http://www.newco.dev.br/images/2022/icones/calendar-clock.png" class="valignM" title="'+str_ProgEntregas+': '+arrProductos[ColumnaOrdenadaProds[numProd]].Entregas.replaceAll('#',', ').replaceAll('|',':')+'"/></a>&nbsp;';
		}		
		
		thisCell += arrProductos[ColumnaOrdenadaProds[numProd]].Cantidad;
		thisCell += cellEnd;
		thisRow += thisCell;

		//	17dic21 Mostramos las columans de precio objetivo y consumo unicamente si esta informada
	
		//solodebug	console.log('PreparaLineaProductoBloqueada ('+numProd+','+ contLinea+','+Indice+'). mostrarPrecioObj:'+mostrarPrecioObj);
		
		// Celda/Columna UdsXLote
		thisCell = cellStart;
		if (arrProductos[ColumnaOrdenadaProds[numProd]].ForzarCaja=='N')
		{
			thisMacro = macroInputHidden.replace('#NAME#', 'UdsLote_' + (Indice));
			thisMacro = thisMacro.replace('#ID#', 'UdsLote_' + (Indice));
			if(isLicPorProducto == 'S'){
				if(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.UdsXLote != ''){
					thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.UdsXLote);
					Cadena=arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.UdsXLote;
				}
				else
				{
					if (arrProductos[ColumnaOrdenadaProds[numProd]].OfertaAnterior === 'S')
					{
						thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Anterior.UdesLote);
						Cadena = arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Anterior.UdesLote;
					}
					else
					{
						thisMacro = thisMacro.replace('#VALUE#', '0');
						Cadena='0';
					}
				}
			}
			else
			{
				thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.UdsXLote);
				Cadena=arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.UdsXLote;
			}
			thisCell += thisMacro;
			thisMacro=Cadena;
		}
		else
		{
			//	en caso de forzar caja, recordamos la unidad por lote para el precio. Campo oculto con el valor 1 para evitar errores de validaci�n
			thisMacro = '1 '+arrProductos[ColumnaOrdenadaProds[numProd]].UdBasica + '<input type="hidden" id="UdsLote_'+(Indice)+'" name="UdsLote_'+(Indice)+'" value="1"/>';
			thisMacro += '&nbsp;&nbsp;<img src="http://www.newco.dev.br/images/2017/info.png" title="'+str_AvisoInformarPrecioCaja+'"/>';
		}
		thisCell += thisMacro;
		thisCell += cellEnd;
		thisRow += thisCell;

		//	Precio objetivo antes del precio
		if (mostrarPrecioObj=='S')
		{
	
			//solodebug	console.log('PreparaLineaProductoBloqueada ('+numProd+','+ contLinea+','+Indice+'). mostrarPrecioObj:'+mostrarPrecioObj+' Incluyendo PrecioObj y COnsumo');
	
			// Celda/Columna Precio Objetivo
			thisCell = cellStartClass.replace('#CLASS#', 'precioObj');
			thisCell += arrProductos[ColumnaOrdenadaProds[numProd]].PrecioObj;
			thisCell += cellEnd;
			thisRow += thisCell;

			/*	27ene23
			// Celda/Columna Consumo
			thisCell = cellStart;
			thisCell += arrProductos[ColumnaOrdenadaProds[numProd]].Consumo;
			thisCell += cellEnd;
			thisRow += thisCell;*/
		}


		// Celda/Columna Precio
		thisCell = cellStartStyle.replace('#STYLE#','text-align:left;');
		
		thisMacro = macroInputHidden.replace('#NAME#', 'Precio_' + (Indice));
		thisMacro = thisMacro.replace('#ID#', 'Precio_' + (Indice));
		if(isLicPorProducto == 'S'){
			if(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Precio != ''){
				thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Precio);
				Cadena=arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Precio;
			}
			else
			{
				//	Si tiene info de la oferta anterior, la presentamos en pantalla
				if (arrProductos[ColumnaOrdenadaProds[numProd]].OfertaAnterior === 'S') 
				{
					thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Anterior.Precio);
					Cadena=arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Anterior.Precio;
				}
				else
				{
					thisMacro = thisMacro.replace('#VALUE#', '0');
					Cadena='0';
				}
			}
		}
		else
		{
			thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Precio);
			Cadena=arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Precio;
		}
		thisCell += thisMacro;
		thisCell += '&nbsp;'+Cadena;
		thisCell += cellEnd;
		thisRow += thisCell;
		
		if (arrProductos[ColumnaOrdenadaProds[numProd]].OfertaAnterior === 'S')
		{
			thisCell = cellStart;

			//macroImagen		= '<img src="#SRC#" title="#TITLE#" alt="#ALT#" style="vertical-align:text-bottom;"/>';
			var infoOferta=strUltimaOferta.replace('[[FECHA]]',arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Anterior.Fecha);
			infoOferta=infoOferta.replace('[[MARCA]]',arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Anterior.Marca);
			infoOferta=infoOferta.replace('[[PRECIO]]',arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Anterior.Precio);
			infoOferta=infoOferta.replace('[[ADJUDICADA]]',arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Anterior.Adjudicada);

			thisMacro = macroImagen.replace("#SRC#",'http://www.newco.dev.br/images/2017/info.png');
			thisMacro = thisMacro.replace("#TITLE#",infoOferta);
			thisMacro = thisMacro.replace("#ALT#",infoOferta);
			thisCell += thisMacro;

			thisCell += cellEnd;
			thisRow += thisCell;
		}
		else
		{
			thisRow += cellStart+cellEnd;
		}

		// Celda/Columna TipoIVA
		thisCell = cellStart;
		if(IDPais != '55'){
			thisCell += arrProductos[ColumnaOrdenadaProds[numProd]].TipoIVA + '%';
		}else{
			thisCell += '&nbsp;';
		}
		thisCell += cellEnd;
		thisRow += thisCell;

		// Celda/Columna para guardar los datos de la oferta fila a fila
		thisCell 	= cellStartClass.replace('#CLASS#', '');
		thisCell += strContrato;
		thisCell += cellEnd;
		thisRow += thisCell;

		thisCell = cellStartClass.replace('#CLASS#', 'resultado');
		thisCell += '<span id="AVISOACCION_'+ (Indice)+ '"/>';				//	17set16	ID '&nbsp;';
		thisCell += cellEnd;
		thisRow += thisCell;

		thisRow += rowEnd;
		//13mar19	htmlTBODY += thisRow;

		// Fila Fichas Tecnicas
		//13mar19	thisRow = rowStartIDClassStyl.replace('#ID#', 'FT_' + (Indice));
		thisRow += rowStartIDClassStyl.replace('#ID#', 'FT_' + (Indice));
		thisRow = thisRow.replace('#CLASS#', 'fichasTecnicas');
		thisRow = thisRow.replace('#STYLE#', 'display:none;');

		thisCell = cellStartColspan.replace('#COLSPAN#', '2') + '&nbsp;' + cellEnd;
		thisRow += thisCell;

		thisCell = cellStartColspanSty.replace('#COLSPAN#', '16');
		thisCell = thisCell.replace('#STYLE#', 'text-align:left;');
		thisCell += divStartStyle.replace('#STYLE#', '');
		thisMacro = macroSelect.replace('#NAME#', 'IDFICHA_' + (Indice));
		thisMacro = thisMacro.replace('#ID#', 'IDFICHA_' + (Indice));
		thisMacro = thisMacro.replace('#CLASS#', 'IDFicha select400 floatLeft');
		thisCell += thisMacro;
		for(var k=0; k<arrFichasTecnicas.length; k++){
			thisMacro = optionStart.replace('#VALUE#', arrFichasTecnicas[k].ID) + arrFichasTecnicas[k].listItem + optionEnd;
			if(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.FichaTecnica.ID == arrFichasTecnicas[k].ID){
				thisMacro = thisMacro.replace('#SELECTED#', 'selected="selected"');
			}else{
				thisMacro = thisMacro.replace('#SELECTED#', '');
			}
			thisCell += thisMacro;
		}
		thisCell += macroSelectEnd + '&nbsp;';
		thisCell += divEnd;
		// Aqui falta el template carga documentos
		//thisCell += dibujaSubirFT((Indice));
		thisCell += dibujaSubirDocumento('FT', (Indice));
		thisCell += cellEnd;
		thisRow += thisCell;

		thisRow += rowEnd;

		thisRow += '<p id="COMPLETAR_"'+numProd+'"/>' ;	// Marca para facilitar insertar nuevas filas
	}
	catch(err)
	{	
		console.log('PreparaLineaProductoBloqueada ('+numProd+','+ contLinea+'). error:'+err);
	}

	return thisRow;
}


//	13mar19 Prepara el HTML correspondiente a una l�nea de producto
//	numProd: �ndice en el array, contLinea: contador de l�neas en pantalla (depende de la paginaci�n)
function PreparaLineaProducto(numProd, contLinea)
{
	var	thisRow='';
	
	var Indice=arrProductos[ColumnaOrdenadaProds[numProd]].linea-1;		//	 En pantalla mostramos a partir del 1
	
	//solodebug	console.log('PreparaLineaProducto ('+numProd+','+ contLinea+','+Indice+')');
	
	try
	{
		// Iniciamos la fila (tr)
		thisRow = rowStartIDClass.replace('#ID#', 'posArr_' + (Indice));
		if (arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Informada=='S')				//	22mar19 Fondo rojo para productos sin oferta
			thisRow = thisRow.replace('#CLASS#', 'infoProds');
		else
			thisRow = thisRow.replace('#CLASS#', 'infoProds fondorojo');

		// Celda/Columna numeracion
		thisCell = cellStart;
		thisCell += '&nbsp;' + contLinea+ '&nbsp;';
		
		//solodebug	thisCell += '&nbsp;[' + arrProductos[ColumnaOrdenadaProds[numProd]].IDProdLic+ ']&nbsp;';
		
		thisCell += cellEnd;
		thisRow += thisCell;


		//	21mar19	Input hidden con el ID de producto
		thisCell=macroInputHidden
		thisCell = thisCell.replace('#ID#', 'IDPRODLIC_'+ (Indice));
		thisCell = thisCell.replace('#NAME#', 'IDPRODLIC_'+ (Indice));
		thisCell = thisCell.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].IDProdLic);
		thisRow += thisCell;

		//	15mar19	Input hidden con el ID de oferta
		thisCell=macroInputHidden
		thisCell = thisCell.replace('#ID#', 'IDOFERTALIC_'+ (Indice));
		thisCell = thisCell.replace('#NAME#', 'IDOFERTALIC_'+ (Indice));
		thisCell = thisCell.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.ID);
		thisRow += thisCell;

		//	15mar19	Input hidden con el numero de alternativa
		thisCell=macroInputHidden
		thisCell = thisCell.replace('#ID#', 'ALTERNATIVA_'+ (Indice));
		thisCell = thisCell.replace('#NAME#', 'ALTERNATIVA_'+ (Indice));
		thisCell = thisCell.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Alternativa);
		thisRow += thisCell;

		// Celda/Columna Ref.Cliente
		thisCell = cellStart;
		if(isLicAgregada == 'S'){
			thisMacro = macroEnlace2.replace('#HREF#', 'javascript:verInfoCentros(' + (Indice) + ');');
			thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
			thisCell += thisMacro;
			if(arrProductos[ColumnaOrdenadaProds[numProd]].RefCliente != ''){
				thisCell += arrProductos[ColumnaOrdenadaProds[numProd]].RefCliente;	// Mostramos Ref.Cliente si existe
			}else{
				thisCell += arrProductos[ColumnaOrdenadaProds[numProd]].RefEstandar;	// Mostramos Ref.Estandar si no existe Ref.Cliente
			}
			thisCell += macroEnlaceEnd;
		}else{
			if(arrProductos[ColumnaOrdenadaProds[numProd]].RefCliente != ''){
				thisCell += arrProductos[ColumnaOrdenadaProds[numProd]].RefCliente;	// Mostramos Ref.Cliente si existe
			}else{
				thisCell += arrProductos[ColumnaOrdenadaProds[numProd]].RefEstandar;	// Mostramos Ref.Estandar si no existe Ref.Cliente
			}
		}
		thisCell += cellEnd;
		thisRow += thisCell;

		// Celda/Columna Ficha Tecnica
		thisCell = cellStart;
		thisMacro = macroEnlaceAccIDStyleTitle
		thisMacro = thisMacro.replace('#HREF#', 'javascript:verFichas(' + (Indice) + ');');
		thisMacro = thisMacro.replace('#CLASS#', 'btnDestacadoPeq');
		thisMacro = thisMacro.replace('#STYLE#', '');
		thisMacro = thisMacro.replace('#TITLE#', str_FichaTecnica);
		thisMacro = thisMacro.replace('#ID#', 'btnFT_'+Indice);
		thisMacro = thisMacro.replace('#NAME#',  'btnFT_'+Indice);
		thisCell += thisMacro;
		thisCell += 'FT';
		thisCell += macroEnlaceEnd;
		thisCell += '&nbsp;';

		if (incluirRS=='S')
		{
			// Celda/Columna registro sanitario
			thisMacro = macroEnlaceAccIDStyleTitle
			thisMacro = thisMacro.replace('#HREF#', 'javascript:verRegSanitario(' + (Indice) + ');');
			thisMacro = thisMacro.replace('#CLASS#', 'btnDestacadoPeq');
			thisMacro = thisMacro.replace('#STYLE#', '');
			thisMacro = thisMacro.replace('#TITLE#', str_RegistroSanitario);
			thisMacro = thisMacro.replace('#ID#', 'btnRS_'+Indice);
			thisMacro = thisMacro.replace('#NAME#',  'btnRS_'+Indice);
			thisCell += thisMacro;
			thisCell += 'RS';
			thisCell += macroEnlaceEnd;
			thisCell += '&nbsp;';
		}
		
		//	Si son 4 botones los organizamos en 2 filas
		if ((incluirRS=='S')&&(incluirCE=='S')&&(incluirFS=='S'))
			thisCell += '<BR/><BR/>';			

		if (incluirCE=='S')
		{
			// Celda/Columna cert. experiencia
			thisMacro = macroEnlaceAccIDStyleTitle
			thisMacro = thisMacro.replace('#HREF#', 'javascript:verCertExperiencia(' + (Indice) + ');');
			thisMacro = thisMacro.replace('#CLASS#', 'btnDestacadoPeq');
			thisMacro = thisMacro.replace('#STYLE#', '');
			thisMacro = thisMacro.replace('#TITLE#', str_CertExperiencia);
			thisMacro = thisMacro.replace('#ID#', 'btnCE_'+Indice);
			thisMacro = thisMacro.replace('#NAME#',  'btnCE_'+Indice);
			thisCell += thisMacro;
			thisCell += 'CE';
			thisCell += macroEnlaceEnd;
			thisCell += '&nbsp;';
		}

		if (incluirFS=='S')
		{
			// Celda/Columna Ficha de seguridad
			thisMacro = macroEnlaceAccIDStyleTitle
			thisMacro = thisMacro.replace('#HREF#', 'javascript:verFichaSeguridad(' + (Indice) + ');');
			thisMacro = thisMacro.replace('#CLASS#', 'btnDestacadoPeq');
			thisMacro = thisMacro.replace('#STYLE#', '');
			thisMacro = thisMacro.replace('#TITLE#', str_FichaSeguridad);
			thisMacro = thisMacro.replace('#ID#', 'btnFS_'+Indice);
			thisMacro = thisMacro.replace('#NAME#',  'btnFS_'+Indice);
			thisCell += thisMacro;
			thisCell += 'FS';
			thisCell += macroEnlaceEnd;
			thisCell += '&nbsp;';
		}

		thisCell += cellEnd;
		thisRow += thisCell;
		
		// Celda/Columna iconos campos avanzados productos informados
		thisCell = cellStart;
		// Info.Ampliada
		if(arrProductos[ColumnaOrdenadaProds[numProd]].InfoAmpliada != ''){
			thisMacro = '&nbsp;' + divStartClass;
			thisMacro = thisMacro.replace('#CLASS#', 'tooltip');
			thisCell += thisMacro;
			thisCell += '<img src="http://www.newco.dev.br/images/infoAmpliadaIcon.gif" class="static"/>';
			thisCell += spanStartClass.replace('#CLASS#', 'tooltiptext');
			thisCell += str_InfoAmpliada + ':<br/><br/>';
			thisCell += arrProductos[ColumnaOrdenadaProds[numProd]].InfoAmpliada;
			thisCell += spanEnd;
			thisCell += macroEnlaceEnd;
		}
		// Documento
		if(typeof arrProductos[ColumnaOrdenadaProds[numProd]].Documento.ID !== 'undefined'){
			thisMacro = '&nbsp;'+ macroEnlaceTarget.replace('#HREF#', 'http://www.newco.dev.br/Documentos/' + arrProductos[ColumnaOrdenadaProds[numProd]].Documento.Url);
			thisCell += thisMacro;
			thisMacro = macroImagen3.replace('#SRC#', 'http://www.newco.dev.br/images/clipIcon.gif');
			thisMacro = thisMacro.replace('#CLASS#', 'static');
			thisMacro = thisMacro.replace('#ALT#', str_Documento);
			thisMacro = thisMacro.replace('#TITLE#', str_Documento);
			thisCell += thisMacro;
	//				thisCell += '<img src="" class="static"/>';
			thisCell += macroEnlaceEnd;
		}
		thisCell += cellEnd;
		thisRow += thisCell;

		// Celda/Columna Nombre
		thisCell = cellStartClass.replace('#CLASS#','datosLeft');
		thisCell += NombreProductoConEstilo(numProd);
		
		//	Si estan informadas las marcas aceptables, las concatenamos con fuente pequenna
		if (arrProductos[ColumnaOrdenadaProds[numProd]].Marcas!='')
			 thisCell += '&nbsp;<span class="fuentePeq">['+arrProductos[ColumnaOrdenadaProds[numProd]].Marcas+ ']</span>';
		
		if (arrProductos[ColumnaOrdenadaProds[numProd]].PrincActivo!='')
			thisCell += '<br/><span class="fuentePeq">'+strPrincActivo+':'+arrProductos[ColumnaOrdenadaProds[numProd]].PrincActivo+'</span>';
			
		thisCell += cellEnd;
		thisRow += thisCell;

		// Celda/Columna icono anyadir campos avanzados + iconos campos avanzados oferta informados
		thisCell = cellStart;
		valAux = parseFloat(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.UdsXLote.replace(".","").replace(",",".")); //arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.UdsXLote;

		//30oct19	Si hay oferta creamos el bot�n visible, si no oculto
		functionJS = 'javascript:abrirCamposAvanzadosOfe(' + (Indice) + ');'
		
		if(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.InfoAmpliada == '')
		{
			thisCell += '&nbsp;' + macroEnlaceAccIDStyleTitle.replace('#ID#', 'btnAvanz_'+(Indice)).replace('#CLASS#', 'btnDiscreto').replace('#HREF#', functionJS).replace('#STYLE#', isNaN(valAux)?'display:none':'').replace('#TITLE#', str_AnyadirInfoAmpliada);
			thisCell += '+';
			thisCell += macroEnlaceEnd;
		}
		else
		{
			// Info.Ampliada
			thisCell += '&nbsp;' + macroEnlaceIDStyle.replace('#ID#', 'btnAvanz_'+(Indice)).replace('#HREF#', functionJS).replace('#STYLE#', isNaN(valAux)?'display:none':'');//display:block
			thisMacro = macroImagen3.replace('#SRC#', 'http://www.newco.dev.br/images/infoAmpliadaIconO.gif');
			thisMacro = thisMacro.replace('#CLASS#', 'static');
			thisMacro = thisMacro.replace('#ALT#', str_InfoAmpliada);
			thisMacro = thisMacro.replace('#TITLE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.InfoAmpliada);
			thisCell += thisMacro;
			thisCell += macroEnlaceEnd;
		}
		
		
		// Documento
		if((typeof arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Documento.ID !== 'undefined')&&(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Documento.ID!=''))
		{
			//solodebug	debug('Tabla productos. numProd:'+numProd+' url:'+arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Documento.Url);
		
			thisMacro = '&nbsp;' + macroEnlaceTarget.replace('#HREF#',(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Documento.Url.substring(0,7)=='http://'?'':'http://www.newco.dev.br/Documentos/') 
															+ arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Documento.Url);
			thisCell += thisMacro;
			thisMacro = macroImagen3.replace('#SRC#', 'http://www.newco.dev.br/images/clipIconO.gif');
			thisMacro = thisMacro.replace('#CLASS#', 'static');
			thisMacro = thisMacro.replace('#ALT#', str_Documento);
			thisMacro = thisMacro.replace('#TITLE#', str_Documento);
			thisCell += thisMacro;
			thisCell += macroEnlaceEnd;
		}
		thisCell += cellEnd;
		thisRow += thisCell;

		// Celda/Columna Ref.Proveedor
		thisCell = cellStart;
		if(IDPais != '55'){
			thisMacro = macroInputTextonKeyUp.replace('#NAME#', 'RefProv_' + (Indice));
			thisMacro = thisMacro.replace('#ID#', 'RefProv_' + (Indice));
			thisMacro = thisMacro.replace('#CLASS#', 'refProv campopesquisa w100px');
			thisMacro = thisMacro.replace('#SIZE#', '15');
			thisMacro = thisMacro.replace('#MAXLENGTH#', '15');
			thisMacro = thisMacro.replace('#ONKEYUP#', 'javascript:ActivarBotonGuardar('+(Indice)+');');
			if(isLicPorProducto == 'S'){
				if(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.RefProv != ''){
					thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.RefProv);
				}else{
					thisMacro = thisMacro.replace('#VALUE#', '');
				}
			}else{
				thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.RefProv);
			}
			thisCell += thisMacro;
		}
		thisCell += cellEnd;
		thisRow += thisCell;
		
		/*	6abr23 Quitamos el campo de regsitro sanitario, se duplica con el codigo INVIMA
		//	22nov21 Codigo registro sanitario
		thisCell = cellStart;
		if (incluirRS=='S')
		{
			thisMacro = macroInputTextonKeyUp.replace('#NAME#', 'REGSAN_' + (Indice));
			thisMacro = thisMacro.replace('#ID#', 'REGSAN_' + (Indice));
			thisMacro = thisMacro.replace('#CLASS#', 'Regsan campopesquisa w100px');
			thisMacro = thisMacro.replace('#SIZE#', '100');
			thisMacro = thisMacro.replace('#MAXLENGTH#', '100');
			thisMacro = thisMacro.replace('#ONKEYUP#', 'javascript:ActivarBotonGuardar('+(Indice)+');');
			thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.CodRegistroSanitario);
			thisCell += thisMacro;		
		}
		thisCell += cellEnd;
		thisRow += thisCell;*/
		

		// Celda/Columna Descripcion
		//solodebug	console.log('PreparaLineaProducto. Celda/Columna Descripcion');
		thisCell = cellStart;
		thisMacro = macroInputTextonKeyUpStyle.replace('#NAME#', 'Desc_' + (Indice));
		thisMacro = thisMacro.replace('#ID#', 'Desc_' + (Indice));
		thisMacro = thisMacro.replace('#STYLE#', '');
		thisMacro = thisMacro.replace('#CLASS#', 'descripcion campopesquisa w200px');
		thisMacro = thisMacro.replace('#SIZE#', '');
		thisMacro = thisMacro.replace('#MAXLENGTH#', '100');
		thisMacro = thisMacro.replace('#ONKEYUP#', 'javascript:ActivarBotonGuardar('+(Indice)+');');
		if(isLicPorProducto == 'S'){
			if(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Nombre != '' || (arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Precio != '0,0000' && arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Precio != '')){
				thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Nombre);
			}else{
				//25mar19	thisMacro = thisMacro.replace('#VALUE#', str_SinOfertar);
					if (arrProductos[ColumnaOrdenadaProds[numProd]].OfertaAnterior === 'S')
						thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Anterior.Producto);
					else
						thisMacro = thisMacro.replace('#VALUE#', '');
			}
		}else{
			thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Nombre);
		}
		thisCell += thisMacro;
		thisCell += cellEnd;
		thisRow += thisCell;

		// Celda/Columna Marca (con espacio para separar)
		thisCell = cellStart;
		
		if ((arrProductos[ColumnaOrdenadaProds[numProd]].Marcas=='')||(DesplegableMarcas=='N'))	//	Desplegable de marcas si array informado Y este cliente trabaja con desplegable
		{
			thisMacro = macroInputTextonKeyUpStyle.replace('#NAME#', 'Marca_' + (Indice));
			thisMacro = thisMacro.replace('#ID#', 'Marca_' + (Indice));
			thisMacro = thisMacro.replace('#STYLE#', '');
			thisMacro = thisMacro.replace('#CLASS#', 'marca campopesquisa w100px');
			thisMacro = thisMacro.replace('#SIZE#', '10');
			thisMacro = thisMacro.replace('#MAXLENGTH#', '100');
			thisMacro = thisMacro.replace('#ONKEYUP#', 'javascript:ActivarBotonGuardar('+(Indice)+');');
			if(isLicPorProducto == 'S'){
				if(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Marca != '' || (arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Precio != '0,0000' && arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Precio != '')){
					thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Marca);
				}
				else
				{
					if (arrProductos[ColumnaOrdenadaProds[numProd]].OfertaAnterior === 'S')
						thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Anterior.Marca);
					else
						//25mar19	thisMacro = thisMacro.replace('#VALUE#', str_SinOfertar);
						thisMacro = thisMacro.replace('#VALUE#', '');
				}
			}else{
				thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Marca);
			}
		}
		else
		{
			//	Prepara un desplegable con las opciones v�lidas de marca
			thisMacro = macroSelectOnChange.replace('#NAME#', 'Marca_' + (Indice));
			thisMacro = thisMacro.replace('#ID#', 'Marca_' + (Indice));
			thisMacro = thisMacro.replace('#CLASS#', 'marca medio');
			thisMacro = thisMacro.replace('#ONCHANGE#',  'javascript:ActivarBotonGuardar('+(Indice)+');');
			
			var ListaMarcas=arrProductos[ColumnaOrdenadaProds[numProd]].Marcas;
			
			for (var i=0;i<=PieceCount(ListaMarcas,',');++i)
			{
				var Marca=Piece(ListaMarcas,',',i);

				thisMacro += optionStart.replace('#VALUE#', Marca).replace('#SELECTED#', '');
				thisMacro += Marca;
				thisMacro += optionEnd;
			}

			thisMacro += macroSelectEnd;
		}
		thisCell += thisMacro;
		thisCell += cellEnd;
		thisRow += thisCell;

		// Celda/Columna UdBasica
		thisCell = cellStartClass.replace('#CLASS#', 'udBasica');
		thisCell += arrProductos[ColumnaOrdenadaProds[numProd]].UdBasica;
		thisCell += cellEnd;
		thisRow += thisCell;

		// Celda/Columna Cantidad
		thisCell = cellStartClass.replace('#CLASS#', 'textRight');

		//	27abr23 Programacion de entregas
		if (arrProductos[ColumnaOrdenadaProds[numProd]].Entregas!='')
		{
			thisCell += '<a class="floatLeft" href="javascript:EntregasProducto('+ColumnaOrdenadaProds[numProd]+');"><img src="http://www.newco.dev.br/images/2022/icones/calendar-clock.png" class="valignM" title="'+str_ProgEntregas+': '+arrProductos[ColumnaOrdenadaProds[numProd]].Entregas.replaceAll('#',', ').replaceAll('|',':')+'"/></a>&nbsp;';
		}		

		thisCell += arrProductos[ColumnaOrdenadaProds[numProd]].Cantidad;
		thisCell += cellEnd;
		thisRow += thisCell;
	
		//solodebug	console.log('PreparaLineaProductoBloqueada ('+numProd+','+ contLinea+','+Indice+'). mostrarPrecioObj:'+mostrarPrecioObj);
	
		// Celda/Columna UdsXLote
		thisCell = cellStart;
		if (arrProductos[ColumnaOrdenadaProds[numProd]].ForzarCaja=='N')
		{
			thisMacro = macroInputTextonKeyUp.replace('#NAME#', 'UdsLote_' + (Indice));
			thisMacro = thisMacro.replace('#ID#', 'UdsLote_' + (Indice));
			thisMacro = thisMacro.replace('#CLASS#', 'unidades campopesquisa w70px');
			thisMacro = thisMacro.replace('#SIZE#', '6');
			thisMacro = thisMacro.replace('#MAXLENGTH#', '15');
			thisMacro = thisMacro.replace('#ONKEYUP#', 'javascript:ActivarBotonGuardar('+(Indice)+');');
			if(isLicPorProducto == 'S'){
				if(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.UdsXLote != ''){
					thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.UdsXLote);
				}
				else
				{
					if (arrProductos[ColumnaOrdenadaProds[numProd]].OfertaAnterior === 'S')
						thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Anterior.UdesLote);
					else
						thisMacro = thisMacro.replace('#VALUE#', '0');
				}
			}else{
				thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.UdsXLote);
			}
		}
		else
		{
			//	en caso de forzar caja, recordamos la unidad por lote para el precio. Campo oculto con el valor 1 para evitar errores de validaci�n
			thisMacro = '1 '+arrProductos[ColumnaOrdenadaProds[numProd]].UdBasica + '<input type="hidden" id="UdsLote_'+(Indice)+'" name="UdsLote_'+(Indice)+'" value="1"/>';
			thisMacro += '&nbsp;<img src="http://www.newco.dev.br/images/2017/info.png" class="valignM" title="'+str_AvisoInformarPrecioCaja+'"/>';
		}
		thisCell += thisMacro;
		thisCell += cellEnd;
		thisRow += thisCell;

		//	Precio objetivo antes del precio
		if (mostrarPrecioObj=='S')
		{
	
			//solodebug	console.log('PreparaLineaProductoBloqueada ('+numProd+','+ contLinea+','+Indice+'). mostrarPrecioObj:'+mostrarPrecioObj+' Incluyendo PrecioObj y COnsumo');

			// Celda/Columna Precio Objetivo
			thisCell = cellStartClass.replace('#CLASS#', 'precioObj');
			thisCell += arrProductos[ColumnaOrdenadaProds[numProd]].PrecioObj;
			thisCell += cellEnd;
			thisRow += thisCell;

			/*27ene23 Quitamos columna consumo para recuperar espacio
			// Celda/Columna Consumo
			thisCell = cellStart;
			thisCell += arrProductos[ColumnaOrdenadaProds[numProd]].Consumo;
			thisCell += cellEnd;
			thisRow += thisCell;*/
		}


		// Celda/Columna Precio
		thisCell = cellStart;
		
		thisMacro = macroInputTextonKeyUp.replace('#NAME#', 'Precio_' + (Indice));
		thisMacro = thisMacro.replace('#ID#', 'Precio_' + (Indice));
		
		
		//solodebug
		//solodebug	console.log("PreparaLineaProducto("+numProd+"): dispone de oferta anterior:"+ arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Anterior.IDLicitacion);
		//solodebug	if (arrProductos[ColumnaOrdenadaProds[numProd]].OfertaAnterior === 'S') 
		//solodebug		console.log("PreparaLineaProducto("+numProd+"): dispone de oferta anterior:"+arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Anterior.IDLicitacion
		//solodebug				+' Precio:'+arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Anterior.Precio);

		if(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Precio != '')
		{
			thisMacro = thisMacro.replace('#CLASS#', 'precio campopesquisa w100px');
			
			//solodebug	console.log("PreparaLineaProducto("+numProd+"): CON oferta actual" );
		}
		else if (arrProductos[ColumnaOrdenadaProds[numProd]].OfertaAnterior === 'S') 
		{
			thisMacro = thisMacro.replace('#CLASS#', 'precio campopesquisa w100px fondoGris');
			
			//solodebug	console.log("PreparaLineaProducto("+numProd+"): CON oferta anterior" );
		}
		else
		{
			thisMacro = thisMacro.replace('#CLASS#', 'precio campopesquisa w100px');
		}
		thisMacro = thisMacro.replace('#SIZE#', '16');
		thisMacro = thisMacro.replace('#MAXLENGTH#', '16');
		thisMacro = thisMacro.replace('#ONKEYUP#', 'javascript:ActivarBotonGuardar('+(Indice)+');');
		if(isLicPorProducto == 'S'){
			if(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Precio != ''){
				thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Precio);
			}
			else
			{
				//	Si tiene info de la oferta anterior, la presentamos en pantalla
				if (arrProductos[ColumnaOrdenadaProds[numProd]].OfertaAnterior === 'S') 
				{
					thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Anterior.Precio);
				}
				else
				{
					thisMacro = thisMacro.replace('#VALUE#', '0');
				}
			}
		}else{
			thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Precio);
		}
		thisCell += thisMacro;
		thisCell += cellEnd;
		thisRow += thisCell;
		
		if (arrProductos[ColumnaOrdenadaProds[numProd]].OfertaAnterior === 'S')
		{
			thisCell = cellStart;

			//macroImagen		= '<img src="#SRC#" title="#TITLE#" alt="#ALT#" style="vertical-align:text-bottom;"/>';
			var infoOferta=strUltimaOferta.replace('[[FECHA]]',arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Anterior.Fecha);
			infoOferta=infoOferta.replace('[[MARCA]]',arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Anterior.Marca);
			infoOferta=infoOferta.replace('[[PRECIO]]',arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Anterior.Precio);
			infoOferta=infoOferta.replace('[[ADJUDICADA]]',arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Anterior.Adjudicada);

			thisMacro = macroImagen.replace("#SRC#",'http://www.newco.dev.br/images/2017/info.png');
			thisMacro = thisMacro.replace("#TITLE#",infoOferta);
			thisMacro = thisMacro.replace("#ALT#",infoOferta);
			thisCell += thisMacro;

			thisCell += cellEnd;
			thisRow += thisCell;
		}
		else
		{
			thisRow += cellStart+cellEnd;
		}

		// Celda/Columna TipoIVA
		thisCell = cellStart;
		if(IDPais != '55'){
			//solodebug		console.log("PreparaLineaProducto("+numProd+"): TipoIVA. Desplegable");
			//27ene23 thisCell += arrProductos[ColumnaOrdenadaProds[numProd]].TipoIVA + '%';
			thisCell += DesplegableTipoIva(Indice, arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.TipoIVA);
		}else{
			thisCell += '&nbsp;';
		}
		thisCell += cellEnd;
		thisRow += thisCell;

		// Celda/Columna para guardar los datos de la oferta fila a fila
		//27may22	thisCell 	= cellStartClass.replace('#CLASS#', 'acciones valignT');
		thisCell 	= cellStartClass.replace('#CLASS#', 'acciones valignM');

		if((arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Precio == '')&&(arrProductos[ColumnaOrdenadaProds[numProd]].OfertaAnterior === 'S'))
		{
			thisMacro	= macroEnlaceAccIDStyleTitle.replace('#CLASS#', 'guardarOferta btnDestacado valignM');
			
			//solodebug	console.log("PreparaLineaProducto("+numProd+"): Bot�n activo");
		}
		else
			thisMacro	= macroEnlaceAccIDStyleTitle.replace('#CLASS#', 'guardarOferta btnGris valignM');
			
		thisMacro	= thisMacro.replace('#ID#', 'btnGuardar_'+ (Indice));
		functionJS	= "javascript:guardarOfertaFila('" + (Indice) +"','','S')";
		thisMacro	= thisMacro.replace('#STYLE#', 'disabled');	//	22jul19 Desactivamos el enlace
		thisMacro	= thisMacro.replace('#HREF#', functionJS);
		thisMacro	= thisMacro.replace('#TITLE#', str_AyudaGuardarOferta);
		thisMacro	+= str_Guardar;
		thisCell	+= thisMacro;
		thisCell	+= macroEnlaceEnd;

		thisCell += '&nbsp;';

		thisMacro	= macroEnlaceAccIDStyleTitle.replace('#CLASS#', 'guardarOferta btnGris  valignM');
		thisMacro	= thisMacro.replace('#ID#', 'btnAlter_'+ (Indice));
		functionJS	= "javascript:guardarOfertaFila('" + (Indice) + "','ALTER','S')";
		thisMacro	= thisMacro.replace('#STYLE#', 'disabled');	//	22jul19 Desactivamos el enlace
		thisMacro	= thisMacro.replace('#HREF#', functionJS);
		thisMacro	= thisMacro.replace('#TITLE#', str_AyudaOfertaAlternativa);

		thisCell	+= thisMacro;
		thisCell	+= str_Alternativa;
		thisCell	+= macroEnlaceEnd;

		thisMacro	= macroEnlace.replace('#HREF#', "javascript:BorrarOferta('" + (Indice) + "');")
					+'<img src="http://www.newco.dev.br/images/2017/trash.png" class=" valignM" title="'+str_AyudaBorrarOferta+'"/>'
					+macroEnlaceEnd;
		thisCell	+= thisMacro;

		thisCell += cellEnd;
		thisRow += thisCell;

		thisCell = cellStartClass.replace('#CLASS#', 'resultado');
		thisCell += '<span id="AVISOACCION_'+ (Indice)+ '"/>';	
		thisCell += cellEnd;
		thisRow += thisCell;

		thisRow += rowEnd;

		//26ene23 Algunas clases no estan inicializadas
		thisRow = thisRow.replaceAll('#CLASS#', '');
		

		// Fila Fichas Tecnicas
		thisRow += rowStartIDClassStyl.replace('#ID#', 'FT_' + (Indice));
		thisRow = thisRow.replace('#CLASS#', 'fichasTecnicas');
		thisRow = thisRow.replace('#STYLE#', 'display:none;');
		thisCell = cellStartColspan.replace('#COLSPAN#', '2') + '&nbsp;' + cellEnd;
		thisRow += thisCell;

		thisCell = cellStartColspanSty.replace('#COLSPAN#', '16');
		thisCell = thisCell.replace('#STYLE#', 'text-align:left;');
		thisCell += divStartStyle.replace('#STYLE#', 'float:left;line-height:30px;height:30px;vertical-align:middle;');
		thisCell += 'FT:&nbsp;';
			if (IDPais==57)	//	Para Colombia, desactivamos el desplegable
				thisMacro = macroSelectOnChangeDis.replace('#NAME#', 'IDFICHA_' + (Indice));
			else
				thisMacro = macroSelectOnChange.replace('#NAME#', 'IDFICHA_' + (Indice));
		thisMacro = thisMacro.replace('#ID#', 'IDFICHA_' + (Indice));
		thisMacro = thisMacro.replace('#CLASS#', 'IDFicha w500px');
		thisMacro = thisMacro.replace('#ONCHANGE#', 'javascript:DocumentoSeleccionado(\'FT\','+(Indice)+');');
		thisCell += thisMacro;
		for(var k=0; k<arrFichasTecnicas.length; k++){
			thisMacro = optionStart.replace('#VALUE#', arrFichasTecnicas[k].ID) + arrFichasTecnicas[k].listItem + optionEnd;
			if(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.FichaTecnica.ID == arrFichasTecnicas[k].ID){
				thisMacro = thisMacro.replace('#SELECTED#', 'selected="selected"');
			}else{
				thisMacro = thisMacro.replace('#SELECTED#', '');
			}
			thisCell += thisMacro;
		}
		thisCell += macroSelectEnd + '&nbsp;';
		
		thisCell += '<a id="verDocFT_'+Indice+'" href="javascript:VerDocumentoOferta(\'FT\', '+Indice+')" class="btnNormal" style="display:none">'+str_VerDoc+'</a>&nbsp;';
		
		thisCell += divEnd;
		thisCell += dibujaSubirDocumento('FT', Indice);
		thisCell += cellEnd;
		thisRow += thisCell;
		thisRow += rowEnd;

		if (incluirRS=='S')
		{

			// 5nov21 Fila Registro sanitario
			thisRow += rowStartIDClassStyl.replace('#ID#', 'RS_' + (Indice));
			thisRow = thisRow.replace('#CLASS#', 'fichasTecnicas');
			thisRow = thisRow.replace('#STYLE#', 'display:none;');

			thisCell = cellStartColspan.replace('#COLSPAN#', '2') + '&nbsp;' + cellEnd;
			thisRow += thisCell;

			thisCell = cellStartColspanSty.replace('#COLSPAN#', '16');
			thisCell = thisCell.replace('#STYLE#', 'text-align:left;');
			thisCell += divStartStyle.replace('#STYLE#', 'float:left;line-height:30px;height:30px;vertical-align:middle;');
			thisCell += 'RS:&nbsp;';
		
			if (IDPais==57)	//	Para Colombia, desactivamos el desplegable
				thisMacro = macroSelectOnChangeDis.replace('#NAME#', 'IDREGSAN_' + (Indice));
			else
				thisMacro = macroSelectOnChange.replace('#NAME#', 'IDREGSAN_' + (Indice));
			thisMacro = thisMacro.replace('#ID#', 'IDREGSAN_' + (Indice));
			thisMacro = thisMacro.replace('#CLASS#', 'IDRegSan w500px');
			thisMacro = thisMacro.replace('#ONCHANGE#', 'javascript:DocumentoSeleccionado(\'RS\','+(Indice)+');');
			thisCell += thisMacro;
			for(var k=0; k<arrRegSanitario.length; k++){
				thisMacro = optionStart.replace('#VALUE#', arrRegSanitario[k].ID) + arrRegSanitario[k].listItem + optionEnd;
				if((arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.RegSanitario)&&(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.RegSanitario.ID == arrRegSanitario[k].ID)){
					thisMacro = thisMacro.replace('#SELECTED#', 'selected="selected"');
				}else{
					thisMacro = thisMacro.replace('#SELECTED#', '');
				}
				thisCell += thisMacro;
			}
			thisCell += macroSelectEnd + '&nbsp;';
			thisCell += '<a id="verDocRS_'+Indice+'" href="javascript:VerDocumentoOferta(\'RS\', '+Indice+')" class="btnNormal" style="display:none">'+str_VerDoc+'</a>&nbsp;';
			thisCell += divEnd;
			thisCell += dibujaSubirDocumento('RS', Indice);
			thisCell += cellEnd;
			thisRow += thisCell;
			thisRow += rowEnd;
		}

		if (incluirCE=='S')
		{
			// 5nov21 Fila Certificado de experiencia
			thisRow += rowStartIDClassStyl.replace('#ID#', 'CE_' + (Indice));
			thisRow = thisRow.replace('#CLASS#', 'fichasTecnicas');
			thisRow = thisRow.replace('#STYLE#', 'display:none;');

			thisCell = cellStartColspan.replace('#COLSPAN#', '2') + '&nbsp;' + cellEnd;
			thisRow += thisCell;

			thisCell = cellStartColspanSty.replace('#COLSPAN#', '16');
			thisCell = thisCell.replace('#STYLE#', 'text-align:left;');
			thisCell += divStartStyle.replace('#STYLE#', 'float:left;line-height:30px;height:30px;vertical-align:middle;');
			thisCell += 'CE:&nbsp;';
			
			if (IDPais==57)	//	Para Colombia, desactivamos el desplegable
				thisMacro = macroSelectOnChangeDis.replace('#NAME#', 'IDCERTEXP_' + (Indice));
			else
				thisMacro = macroSelectOnChange.replace('#NAME#', 'IDCERTEXP_' + (Indice));
			thisMacro = thisMacro.replace('#ID#', 'IDCERTEXP_' + (Indice));
			thisMacro = thisMacro.replace('#CLASS#', 'IDCertExp w500px');
			thisMacro = thisMacro.replace('#ONCHANGE#', 'javascript:DocumentoSeleccionado(\'CE\','+(Indice)+');');
			thisCell += thisMacro;
			for(var k=0; k<arrCertExperiencia.length; k++){
				thisMacro = optionStart.replace('#VALUE#', arrCertExperiencia[k].ID) + arrCertExperiencia[k].listItem + optionEnd;
				if((arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.CertExperiencia)&&(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.CertExperiencia.ID == arrCertExperiencia[k].ID)){
					thisMacro = thisMacro.replace('#SELECTED#', 'selected="selected"');
				}else{
					thisMacro = thisMacro.replace('#SELECTED#', '');
				}
				thisCell += thisMacro;
			}
			thisCell += macroSelectEnd + '&nbsp;';
			
			thisCell += '<a id="verDocCE_'+Indice+'" href="javascript:VerDocumentoOferta(\'CE\', '+Indice+')" class="btnNormal" style="display:none">'+str_VerDoc+'</a>&nbsp;';

			thisCell += divEnd;
			thisCell += dibujaSubirDocumento('CE', Indice);
			thisCell += cellEnd;
			thisRow += thisCell;
			thisRow += rowEnd;
		}

		if (incluirFS=='S')
		{
			// 30ene23 Fila Ficha de seguridad
			thisRow += rowStartIDClassStyl.replace('#ID#', 'FS_' + (Indice));
			thisRow = thisRow.replace('#CLASS#', 'fichasTecnicas');
			thisRow = thisRow.replace('#STYLE#', 'display:none;');

			thisCell = cellStartColspan.replace('#COLSPAN#', '2') + '&nbsp;' + cellEnd;
			thisRow += thisCell;

			thisCell = cellStartColspanSty.replace('#COLSPAN#', '16');
			thisCell = thisCell.replace('#STYLE#', 'text-align:left;');
			thisCell += divStartStyle.replace('#STYLE#', 'float:left;line-height:30px;height:30px;vertical-align:middle;');
			thisCell += 'FS:&nbsp;';
			if (IDPais==57)	//	Para Colombia, desactivamos el desplegable
				thisMacro = macroSelectOnChangeDis.replace('#NAME#', 'IDFICHASEG_' + (Indice));
			else
				thisMacro = macroSelectOnChange.replace('#NAME#', 'IDFICHASEG_' + (Indice));
			thisMacro = thisMacro.replace('#ID#', 'IDFICHASEG_' + (Indice));
			thisMacro = thisMacro.replace('#CLASS#', 'IDFichaSeg w500px');
			thisMacro = thisMacro.replace('#ONCHANGE#', 'javascript:DocumentoSeleccionado(\'FS\','+(Indice)+');');
			thisCell += thisMacro;
			for(var k=0; k<arrFichaSeguridad.length; k++){
				thisMacro = optionStart.replace('#VALUE#', arrFichaSeguridad[k].ID) + arrFichaSeguridad[k].listItem + optionEnd;
				if((arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.FichaSeguridad)&&(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.FichaSeguridad.ID == arrFichaSeguridad[k].ID)){
					thisMacro = thisMacro.replace('#SELECTED#', 'selected="selected"');
				}else{
					thisMacro = thisMacro.replace('#SELECTED#', '');
				}
				thisCell += thisMacro;
			}
			thisCell += macroSelectEnd + '&nbsp;';
			
			thisCell += '<a id="verDocFS_'+Indice+'" href="javascript:VerDocumentoOferta(\'FS\', '+Indice+')" class="btnNormal" style="display:none">'+str_VerDoc+'</a>&nbsp;';

			thisCell += divEnd;
			thisCell += dibujaSubirDocumento('FS', Indice);
			thisCell += cellEnd;
			thisRow += thisCell;
			thisRow += rowEnd;
		}

		//2feb23 SI hay que infomar los campos propios de Colombia
		if ((IDPais == '57')&&(incluirRS=='S'))
		{
		
			// Fila Fichas Tecnicas
			thisRow += rowStartIDClassStyl.replace('#ID#', 'Cods_' + (Indice));
			thisRow = thisRow.replace('#CLASS#', 'Codigos');
			thisRow = thisRow.replace('#STYLE#', 'border-bottom: 1px solid #D0D0D0;');
			
			thisRow += '<td>&nbsp;</td>';


			thisCell = cellStartColspanSty.replace('#COLSPAN#', '15');
			thisCell = thisCell.replace('#STYLE#', 'text-align:left;');

			thisCell += str_CodExpediente+':&nbsp;';
			thisMacro = macroInputTextonKeyUp.replace('#NAME#', 'CodExp_' + (Indice));
			thisMacro = thisMacro.replace('#ID#', 'CodExp_' + (Indice));
			thisMacro = thisMacro.replace('#CLASS#', 'campopesquisa w100px');
			thisMacro = thisMacro.replace('#SIZE#', '100');
			thisMacro = thisMacro.replace('#MAXLENGTH#', '100');
			thisMacro = thisMacro.replace('#ONKEYUP#', 'javascript:ActivarBotonGuardar('+(Indice)+');');
			thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.CodExpediente);
			thisCell += thisMacro;

			thisCell += '&nbsp;&nbsp;&nbsp;';
			thisCell += str_CodCUM+':&nbsp;';
			thisMacro = macroInputTextonKeyUp.replace('#NAME#', 'CodCum_' + (Indice));
			thisMacro = thisMacro.replace('#ID#', 'CodCum_' + (Indice));
			thisMacro = thisMacro.replace('#CLASS#', 'campopesquisa w100px');
			thisMacro = thisMacro.replace('#SIZE#', '100');
			thisMacro = thisMacro.replace('#MAXLENGTH#', '100');
			thisMacro = thisMacro.replace('#ONKEYUP#', 'javascript:ActivarBotonGuardar('+(Indice)+');');
			thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.CodCum);
			thisCell += thisMacro;

			thisCell += '&nbsp;&nbsp;&nbsp;';
			thisCell += str_CodIUM+':&nbsp;';
			thisMacro = macroInputTextonKeyUp.replace('#NAME#', 'CodIum_' + (Indice));
			thisMacro = thisMacro.replace('#ID#', 'CodIum_' + (Indice));
			thisMacro = thisMacro.replace('#CLASS#', 'campopesquisa w100px');
			thisMacro = thisMacro.replace('#SIZE#', '100');
			thisMacro = thisMacro.replace('#MAXLENGTH#', '100');
			thisMacro = thisMacro.replace('#ONKEYUP#', 'javascript:ActivarBotonGuardar('+(Indice)+');');
			thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.CodIum);
			thisCell += thisMacro;

			thisCell += '&nbsp;&nbsp;&nbsp;';
			thisCell += str_CodInvima+':&nbsp;';
			thisMacro = macroInputTextonKeyUp.replace('#NAME#', 'CodInv_' + (Indice));
			thisMacro = thisMacro.replace('#ID#', 'CodInv_' + (Indice));
			thisMacro = thisMacro.replace('#CLASS#', 'campopesquisa w100px');
			thisMacro = thisMacro.replace('#SIZE#', '100');
			thisMacro = thisMacro.replace('#MAXLENGTH#', '100');
			thisMacro = thisMacro.replace('#ONKEYUP#', 'javascript:ActivarBotonGuardar('+(Indice)+');');
			thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.CodInvima);
			thisCell += thisMacro;

			thisCell += '&nbsp;&nbsp;&nbsp;';
			thisCell += str_FechaLimiteInvima+':&nbsp;';
			thisMacro = macroInputTextonKeyUp.replace('#NAME#', 'CadInvima_' + (Indice));
			thisMacro = thisMacro.replace('#ID#', 'CadInvima_' + (Indice));
			thisMacro = thisMacro.replace('#CLASS#', 'campopesquisa w100px');
			thisMacro = thisMacro.replace('#SIZE#', '100');
			thisMacro = thisMacro.replace('#MAXLENGTH#', '100');
			thisMacro = thisMacro.replace('#ONKEYUP#', 'javascript:ActivarBotonGuardar('+(Indice)+');');
			thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.FechaCadInvima);
			thisCell += thisMacro;

			thisCell += '&nbsp;&nbsp;&nbsp;';
			thisCell += str_ClasRiesgo+':&nbsp;';
			thisMacro = macroInputTextonKeyUp.replace('#NAME#', 'ClasRiesgo_' + (Indice));
			thisMacro = thisMacro.replace('#ID#', 'ClasRiesgo_' + (Indice));
			thisMacro = thisMacro.replace('#CLASS#', 'campopesquisa w100px');
			thisMacro = thisMacro.replace('#SIZE#', '10');
			thisMacro = thisMacro.replace('#MAXLENGTH#', '15');
			thisMacro = thisMacro.replace('#ONKEYUP#', 'javascript:ActivarBotonGuardar('+(Indice)+');');
			thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.ClasRiesgo);
			thisCell += thisMacro;

			thisCell += cellEnd;
			thisRow += thisCell;
			thisRow += rowEnd;

		}
		
		
		thisRow += '<p id="COMPLETAR_"'+numProd+'"/>' ;	// Marca para facilitar insertar nuevas filas
	}
	catch(err)
	{	
		console.log('PreparaLineaProducto ('+numProd+','+ contLinea+'). error:'+err);
	}

	return thisRow;
}


//27ene23 Mostrar el desplegable de tipos de IVA
function DesplegableTipoIva(NumeroLinea, TipoIva)
{
	var thisCell='', thisMacro;
	
	thisMacro = macroSelectOnChange.replace('#NAME#', 'TIPOIVA_' + NumeroLinea);
	thisMacro = thisMacro.replace('#ID#', 'TIPOIVA_' + NumeroLinea);
	thisMacro = thisMacro.replace('#CLASS#', 'w60px');
	thisMacro = thisMacro.replace('#ONCHANGE#', 'ActivarBotonGuardar('+NumeroLinea+');');
	thisCell += thisMacro;
	for(var k=0; k<arrTiposIva.length; k++){
		thisMacro = optionStart.replace('#VALUE#', arrTiposIva[k].Tipo) + arrTiposIva[k].Tipo+'%'+ optionEnd;
		if(TipoIva == arrTiposIva[k].Tipo){
			thisMacro = thisMacro.replace('#SELECTED#', 'selected="selected"');
		}else{
			thisMacro = thisMacro.replace('#SELECTED#', '');
		}
		thisCell += thisMacro;
	}
	thisCell += macroSelectEnd;
	return thisCell;
}


//	Activa el bot�n de guardar oferta
function ActivarBotonGuardar(NumeroLinea)
{
	//solodebug	console.log('ActivarBotonGuardar:'+NumeroLinea);
	
	jQuery('#AVISOACCION_'+NumeroLinea).html('');

	//22jul19jQuery('#btnGuardar_'+NumeroLinea).show();
	jQuery('#btnGuardar_'+NumeroLinea).attr('class','guardarOferta btnDestacado');
	
	//	Quitamos el texto "Sin ofertar", las unidades popr lote y el precio 0
	if (jQuery('#UdsLote_'+NumeroLinea).val()=='0') jQuery('#UdsLote_'+NumeroLinea).val('');
	if (jQuery('#Precio_'+NumeroLinea).val()=='0,000') jQuery('#Precio_'+NumeroLinea).val('');
	
	
	if (AlternativasInformadas(jQuery('#IDPRODLIC_'+NumeroLinea).val())>0)
		//22jul19 jQuery('#btnAlter_'+NumeroLinea).show();
		jQuery('#btnAlter_'+NumeroLinea).attr('class','guardarOferta btnDestacado');

	//solodebug	console.log('ActivarBotonGuardar:'+NumeroLinea+ 'IDPRODLIC:'+jQuery('#IDPRODLIC_'+NumeroLinea).val()+' Alternativas:'+AlternativasInformadas(jQuery('#IDPRODLIC_'+NumeroLinea).val()));
}


//	18mar19 Comprueba si existena alternativas informadas para este producto
function AlternativasInformadas(IDProdLic)
{
	var informadas=0;
	
	//	Recorre todo el array de productos por si hay alguna oferta informada para este producto
	for (var i=0;i<arrProductos.length;++i)
	{
		
		//solodebug	if (arrProductos[ColumnaOrdenadaProds[i]].IDProdLic==IDProdLic)
		//solodebug		console.log('AlternativasInformadas:'+IDProdLic+' informada:'+arrProductos[ColumnaOrdenadaProds[i]].Oferta.Informada+' TotalInf:'+informadas);
		
		if ((arrProductos[ColumnaOrdenadaProds[i]].IDProdLic==IDProdLic)&&(arrProductos[ColumnaOrdenadaProds[i]].Oferta.Informada=='S'))
			++informadas;
	}
	
	//solodebug console.log('AlternativasInformadas:'+IDProdLic+' informadas:'+informadas);
	
	return informadas;
}


//	25mar19 recupera la posicion a partir del array de orden
function RecuperaPosicion(PosOrdenada)
{
	var Indice=-1;
	for (var i=0;i<arrProductos.length;++i)
	{
		//solodebug	console.log("RecuperaPosicion. PosOrdenada:"+PosOrdenada+" i:"+i+" ColumnaOrdenadaProds[i]:"+ColumnaOrdenadaProds[i]);
		if (ColumnaOrdenadaProds[i]==PosOrdenada)
		{
			Indice=i;
			//solodebug	console.log("RecuperaPosicion. PosOrdenada:"+PosOrdenada+" i:"+i+" ColumnaOrdenadaProds[i]:"+ColumnaOrdenadaProds[i]+ 'Indice:'+Indice);
		}
	}
	console.log("RecuperaPosicion. PosOrdenada:"+PosOrdenada+ 'Indice:'+Indice);
	return Indice;
}


//	Borra una oferta, y recarga el formulario
function BorrarOferta(thisPosArr)
{
	//solodebug
	var oForm = document.forms['ProductosProveedor'];
    var IDProdLic   = arrProductos[thisPosArr].IDProdLic;    	//13mar19
	console.log("BorrarOferta. thisPosArr:"+thisPosArr+" IDProdLic:"+IDProdLic+'???'+jQuery('#IDPRODLIC_' + thisPosArr).val()//+" RefCliente:"+RefCliente
		+ " marca:"+oForm.elements['Marca_' + thisPosArr].value
		+' Precio min:'+arrProductos[thisPosArr].PrecioMin+' PrecioMax:'+arrProductos[thisPosArr].PrecioMax);
		
	//	26ene23 No limpiamos las celdas, ya se redibujara toda la tabla despues de borrar
	jQuery('#RefProv_' + thisPosArr).val('');
	jQuery('#Desc_' + thisPosArr).val('');
	jQuery('#Marca_' + thisPosArr).val('');
	jQuery('#UdsLote_' + thisPosArr).val('0');
	jQuery('#Precio_' + thisPosArr).val('0,0000');
	jQuery('#REGSAN_' + thisPosArr).val('');
	if ((IDPais == '57')&&(incluirRS=='S'))
	{
		jQuery('#CodExp_' + thisPosArr).val('');
		jQuery('#CodCum_' + thisPosArr).val('');
		jQuery('#CodIum_' + thisPosArr).val('');
		jQuery('#CodInv_' + thisPosArr).val('');
		jQuery('#CadInvima_' + thisPosArr).val('');
		jQuery('#ClasRiesgo_' + thisPosArr).val('');
	}
	//TIPOIVA no es necesario borrarlo
	
	//	24jul19 Quitamos el color gris para poder guardar la oferta
	jQuery('#btnGuardar_'+thisPosArr).attr('class','guardarOferta btnDestacado');

	guardarOfertaFila(thisPosArr, 'BORRAR','S');

	//jQuery('#btnGuardar_'+thisPosArr).attr('class','guardarOferta btnGris');
	//jQuery('#btnAlter_'+thisPosArr).attr('class','guardarOferta btnGris');
}



//	Funcion para guardar los datos de una oferta del proveedor para una fila en concreto
//	11mar19	Permite guardar alternativas
function guardarOfertaFila(thisPosArr, tipo, recal)
{
	//var Indice=RecuperaPosicion(thisPosArr);
	
	Indice=thisPosArr;

	//solodebug	
	console.log("guardarOfertaFila. thisPosArr:"+thisPosArr+' RecuperaPosicion:'+RecuperaPosicion(thisPosArr)+ ' Indice:'+Indice+" tipo:"+tipo+" recal:"+recal);
	
	
	//	Si el bot�n est� desactivado, sale directamente
	var myClass = jQuery('#btnGuardar_'+thisPosArr).attr("class");
	console.log('guardarOfertaFila:'+myClass);	
	
	if ((tipo!='BORRAR')&&(myClass.search("btnGris")>=0))
	{
		debug('guardarOfertaFila. boton desactivado.');
		return;	
	}

	// Validaciones
	var oForm = document.forms['ProductosProveedor'];
    var IDProdLic   = arrProductos[Indice].IDProdLic;    	//13mar19
    var IDOfeLic   = arrProductos[Indice].Oferta.ID;    	//26ene23
    var ProdNombre1 = arrProductos[Indice].Nombre;    		//7abr18
	var RefCliente	= (arrProductos[Indice].RefCliente != '') ? arrProductos[Indice].RefCliente : arrProductos[Indice].RefEstandar;
	var precioObj	= arrProductos[Indice].PrecioObj;
	var precioObjFormat	= parseFloat(precioObj.replace(/\./g,'').replace(',', '.'));
	var enviarOferta = false;
	var controlPrecio = '';
	var errores = 0;
	var Alternativa;
	var msgErrores='';		//24ene23 Concatenamos los mensajes de error
	var CodExp='', CodIum='', CodCum='', CodInv='', CadInv='', ClasRiesgo='';

	if ((IDPais == '57')&&(incluirRS=='S'))
	{
		CodExp=jQuery("#CodExp_" + thisPosArr).val();
		CodCum=jQuery("#CodCum_" + thisPosArr).val();
		CodIum=jQuery("#CodIum_" + thisPosArr).val();
		CodInv=jQuery("#CodInv_" + thisPosArr).val();
		CadInv=jQuery("#CadInvima_" + thisPosArr).val();
		ClasRiesgo=jQuery("#ClasRiesgo_" + thisPosArr).val();
	}
	
	if (tipo=='ALTER')
	{
		//	Busca la mayor alternativa para este producto
		Alternativa=0;
		for (var i=0;i<arrProductos.length;++i)
		{
			//solodebug	console.log("guardarOfertaFila. thisPosArr:"+thisPosArr+" tipo:"+tipo+ " IDProdLic:"+IDProdLic+'/'+Alternativa+' arrProductos['+i+'].IDProdLic:'+arrProductos[i].IDProdLic+'/'+arrProductos[i].Oferta.Alternativa);

			if ((arrProductos[i].IDProdLic==IDProdLic)&&(arrProductos[i].Oferta.Alternativa>Alternativa)) 
			{
				Alternativa=arrProductos[i].Oferta.Alternativa;
				//solodebug	console.log("guardarOfertaFila. thisPosArr:"+thisPosArr+ " IDProdLic:"+IDProdLic+" tipo:"+tipo+ " alternativa:"+Alternativa);
			}
		}
		
		++Alternativa;
	}
	else
	{
	/*	26ene23 Recuperamos el numero de alternativa directamente de arrProductos
		try
		{
			Alternativa=oForm.elements['ALTERNATIVA_' + thisPosArr].value;
		}
		catch(err)
		{
			//	este caso se produce al insertar una variante desde fichero
			Alternativa=1;
		}*/
		Alternativa=arrProductos[Indice].Oferta.Alternativa;
	}

	//solodebug
	debug("guardarOfertaFila. thisPosArr:"+thisPosArr+' IDOfeLic:'+IDOfeLic+" IDProdLic:"+IDProdLic+'='+jQuery('#IDPRODLIC_' + thisPosArr).val()+" RefCliente:"+RefCliente
		+ " marca:"+oForm.elements['Marca_' + thisPosArr].value
		+" tipo:"+tipo+ " alternativa:"+Alternativa+' Precio min:'+arrProductos[Indice].PrecioMin+' PrecioMax:'+arrProductos[Indice].PrecioMax);

	//solodebug
	debug("guardarOfertaFila. thisPosArr:"+thisPosArr+' FTObligatoria:'+FTObligatoria+ ' IDFicha:'+jQuery("#IDFICHA_" + thisPosArr).val()
			+' RSObligatorio:'+RSObligatorio+' CEObligatorio:'+CEObligatorio+' FSObligatoria:'+FSObligatoria
			+ ' RegSan:'+jQuery("#REGSAN_" + thisPosArr).val() + ' IDRegSan:'+jQuery("#IDREGSAN_" + thisPosArr).val() + ' IDCertExper:'+jQuery("#IDCERTEXPER_" + thisPosArr).val()
		);

	if(tipo!='BORRAR')	//26ene23 No realizar estas comprobaciones si se va a borrar el registro
	{

		// Comprobar si la FT es obligatoria
		if ((FTObligatoria=='S')&&((jQuery("#IDFICHA_" + thisPosArr).val()=='')||(jQuery("#IDFICHA_" + thisPosArr).val()=='-1')))
		{
			errores++;
			//24en23	alert(alrt_faltaFTObligatoria);
			msgErrores+=alrt_faltaFTObligatoria+'\n'
		}
		if ((RSObligatorio=='S')&&((jQuery("#IDREGSAN_" + thisPosArr).val()=='')||(jQuery("#IDREGSAN_" + thisPosArr).val()=='-1')))
		{
			errores++;
			//24en23	alert(alrt_faltaRSObligatorio);
			msgErrores+=alrt_faltaRSObligatorio+'\n'
		}
		if ((RSObligatorio=='S')&&(jQuery("#REGSAN_" + thisPosArr).val()==''))
		{
			errores++;
			//24en23	alert(alrt_faltaCodRSObligatorio);
			msgErrores+=alrt_faltaCodRSObligatorio+'\n'
		}
		if ((CEObligatorio=='S')&&((jQuery("#IDCERTEXP_" + thisPosArr).val()=='')||(jQuery("#IDCERTEXPER_" + thisPosArr).val()=='-1')))
		{
			errores++;
			//24en23	alert(alrt_faltaCEObligatorio);
			msgErrores+=alrt_faltaCEObligatorio+'\n'
		}
		if ((FSObligatoria=='S')&&((jQuery("#IDFICHASEG_" + thisPosArr).val()=='')||(jQuery("#IDFICHASEG_" + thisPosArr).val()=='-1')))
		{
			errores++;
			msgErrores+=alrt_faltaFSObligatoria+'\n'
		}

		if ((IDPais == '57')&&(incluirRS=='S'))
		{
			if ((CodExp=='')||(CodExp=='')||(CodCum=='')||(CodIum=='')||(CodInv=='')||(CadInv=='')||(ClasRiesgo==''))
			{
				errores++;
				msgErrores+=alrt_faltanCamposColObligatorios+'\n'
			}
		}


		// Validacion Precio, quitamos '.' separador de miles. 29jul22 cambiamos a replace ALL
		var precio		= jQuery('#Precio_' + thisPosArr).val().replaceAll('.','');
		var precioFormat= precio.replace(",",".");
		if(esNulo(precioFormat))
		{
			errores++;
			//24en23	alert(val_faltaPrecio.replace("[[REF]]",RefCliente));
			msgErrores+=val_faltaPrecio.replace("[[REF]]",RefCliente)+'\n'
			oForm.elements['Precio_' + thisPosArr].focus();
		}
		else if(isNaN(precioFormat))
		{
			errores++;
			//24en23	alert(val_malPrecio.replace("[[REF]]",RefCliente));
			msgErrores+=val_malPrecio.replace("[[REF]]",RefCliente)+'\n'
			oForm.elements['Precio_' + thisPosArr].focus();
		}
		else if(precioFormat != 0)
		{
			// Validacion de precio para Espa�a
			//	9abr18	if(IDPais != '55' && precioFormat > (precioObjFormat*2)){
			//	9abr18		controlPrecio += val_elPrecioProd +" "+ precio +" "+ val_precioProd.replace("[[REF]]",RefCliente)+" "+ val_doblePrecio +" "+ precioObj +" "+ "\n";
			//	9abr18		controlPrecio +=val_PrecioFueraRango
			//	9abr18	}

			//solodebug
			debug("guardarOfertaFila. thisPosArr:"+thisPosArr+' precioObj:'+precioObj+' precioFormat:'+precioFormat+' precioObjFormat:'+precioObjFormat);
			

			if ((precioObj!='')&&(precioFormat > precioObjFormat))
			{
				if (precioObjEstricto=='S')
				{
					errores++;
					//24en23	alert(val_precioObjObligatorio.replace("[[REF]]",RefCliente).replace("[[PRECIO]]",precio));
					msgErrores+=val_precioObjObligatorio.replace("[[REF]]",RefCliente).replace("[[PRECIO]]",precio).replace("[[PRECIOOBJ]]",precioObj)+'\n'
				}
				else if (!confirm(alrt_noCumplePrecioObjetivo.replace("[[REF]]",RefCliente)))
					errores++;
			}


			if	((arrProductos[Indice].PrecioMin!='' && precioFormat < parseFloat(arrProductos[Indice].PrecioMin.replace(/\./g,"").replace(',', '.')))||(arrProductos[Indice].PrecioMax!='' && precioFormat > parseFloat(arrProductos[Indice].PrecioMax.replace(/\./g,"").replace(',', '.'))))
			{
				controlPrecio +=val_PrecioFueraRango.replace("[[REF]]",RefCliente).replace("[[PRECIO]]",precio).replace("[[UDBASICA]]",arrProductos[Indice].UdBasica).replace("[[MIN]]",arrProductos[Indice].PrecioMin).replace("[[MAX]]",arrProductos[Indice].PrecioMax)
			}

		}

		//	6jul16	Campo marca obligatorio
		if ((esNulo(oForm.elements['Marca_' + thisPosArr].value) || (oForm.elements['Marca_' + thisPosArr].value=='SIN OFERTAR'))){
			errores++;
			//24en23	alert(val_marcaObligatoria.replace("[[REF]]",RefCliente));
			msgErrores+=val_marcaObligatoria.replace("[[REF]]",RefCliente)+'\n'
		}

		if(precioFormat != 0){
			valAux	= (precioFormat != '') ? String(parseFloat(precioFormat).toFixed(4)).replace(".",",") : '';
			jQuery('#Precio_' + thisPosArr).val( valAux );

			if(jQuery('#Desc_' + thisPosArr).val() == str_SinOfertar){
				jQuery('#Desc_' + thisPosArr).val('');
			}
			if(jQuery('#Marca_' + thisPosArr).val() == str_SinOfertar){
				jQuery('#Marca_' + thisPosArr).val('');
			}
		}

		// Validacion Unidades por Lote
		UdsXLote	= jQuery('#UdsLote_' + thisPosArr).val();

		if(esNulo(UdsXLote)){
			errores++;
			//24en23	alert(val_faltaUnidades.replace("[[REF]]",RefCliente));
			msgErrores+=val_faltaUnidades.replace("[[REF]]",RefCliente)+'\n'
			//24en23	oForm.elements['UdsLote_' + thisPosArr].focus();
		}
		else if(!esEntero(UdsXLote))
		{
			errores++;
			//24en23	alert(val_malEnteroUnidades.replace("[[REF]]",RefCliente));
			msgErrores+=val_malEnteroUnidades.replace("[[REF]]",RefCliente)+'\n'
			oForm.elements['UdsLote_' + thisPosArr].focus();
		}
		else if(UdsXLote == 0 && precioFormat != 0)
		{
			errores++;
			//24en23	alert(val_notZeroUnidades.replace("[[REF]]",RefCliente));
			msgErrores+=val_notZeroUnidades.replace("[[REF]]",RefCliente)+'\n'
			//24en23	oForm.elements['UdsLote_' + thisPosArr].focus();
		}

		if(IDPais != 55){
			// Validacion Ref.Proveedor
			valAux	= jQuery('#RefProv_' + thisPosArr).val();
			//if(!errores && esNulo(valAux) && (precioFormat != 0 || UdsXLoteFormat != 0)){ DC - 23feb16 - Las unidades por lote en formato n�mero entero
			if(esNulo(valAux) && (precioFormat != 0 || UdsXLote != 0))
			{
				errores++;
				//24en23	alert(val_faltaRefProv.replace("[[REF]]",RefCliente));
				msgErrores+=val_faltaRefProv.replace("[[REF]]",RefCliente)+'\n'
				//24en23	oForm.elements['RefProv_' + thisPosArr].focus();
			//}else if(!errores && UdsXLoteFormat != 0){ DC - 23feb16 - Las unidades por lote en formato n�mero entero
			}
			else if( UdsXLote != 0)
			{
				// Comprobamos que no hayan escrito 2 Ref.Prov. iguales en la tabla
				for (var i=0;i<arrProductos.length;++i)
				{
					//	Comprueba que no se haya utilizado ya la misma referencia de proveedor
					if((thisPosArr != i) && (arrProductos[i].Oferta.Informado == 'S') && (arrProductos[Indice].RefProv ==arrProductos[i].RefProv))
					{
						//	
						errores++;
						//24en23	alert(val_igualesRefProv.replace("[[REFPROV]]", arrProductos[Indice].RefProv).replace('[[PRODNOMBRE1]]', arrProductos[Indice].Nombre).replace('[[PRODNOMBRE2]]', arrProductos[i].Nombre));
						msgErrores+=al_igualesRefProv.replace("[[REFPROV]]", arrProductos[Indice].RefProv).replace('[[PRODNOMBRE1]]', arrProductos[Indice].Nombre).replace('[[PRODNOMBRE2]]', arrProductos[i].Nombre)+'\n'
						//24en23	oForm.elements['RefProv_' + thisPosArr].focus();
					}
				}


				// Tambien comprobamos que no exista previamente una Ref.Prov en el array de ofertas
				jQuery.each(arrProductos, function(key, producto){
					if(key != thisPosArr && producto.Oferta.RefProv.toUpperCase() == valAux.toUpperCase()){
						ProdNombre2 = producto.Nombre;
						errores++;
						//24en23	alert(val_igualesRefProv.replace("[[REFPROV]]", valAux).replace('[[PRODNOMBRE1]]', ProdNombre1).replace('[[PRODNOMBRE2]]', ProdNombre2));
						msgErrores+=val_igualesRefProv.replace("[[REFPROV]]", valAux).replace('[[PRODNOMBRE1]]', ProdNombre1).replace('[[PRODNOMBRE2]]', ProdNombre2)+'\n'
						//24en23	oForm.elements['RefProv_' + thisPosArr].focus();
					}
				});

			//}else if(!errores && precioFormat == 0 && UdsXLoteFormat == 0){ DC - 23feb16 - Las unidades por lote en formato n�mero entero
			}
			else if(!errores && precioFormat == 0 && UdsXLote == 0)
			{
				//solodebug
				console.log("precioFormat == 0 && UdsXLote == 0");

				jQuery('#RefProv_' + thisPosArr).val(str_SinOfertar);
				jQuery('#Desc_' + thisPosArr).val(str_SinOfertar);
				jQuery('#Marca_' + thisPosArr).val(str_SinOfertar);
			}
		}









		//	24ene23 Presentamos el mensaje con TODOS los errores
		if (errores)
			alert(msgErrores);
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

	if(enviarOferta){
		var IDLicProv	= oForm.elements['LIC_PROV_ID'].value;
		var IDLicProd	= arrProductos[Indice].IDProdLic;
		var IDFicha = '',IDRegSanitario='', IDCertExperiencia='',IDFichaSeg='';					//	5nov21 Nuevo campo para registro sanitario, texto reg. sanitario, certif.experiencia.
		if(jQuery("#IDFICHA_" + thisPosArr).val() > 0){
			IDFicha = jQuery("#IDFICHA_" + thisPosArr).val();
		}
		if(jQuery("#IDREGSAN_" + thisPosArr).val() > 0){
			IDRegSanitario = jQuery("#IDREGSAN_" + thisPosArr).val();
		}
		if(jQuery("#IDCERTEXP_" + thisPosArr).val() > 0){
			IDCertExperiencia = jQuery("#IDCERTEXP_" + thisPosArr).val();
		}
		if(jQuery("#IDFICHASEG_" + thisPosArr).val() > 0){
			IDFichaSeg = jQuery("#IDFICHASEG_" + thisPosArr).val();
		}
		var	RegSanitario = jQuery("#REGSAN_" + thisPosArr).val();
		var RefProv = (jQuery('#RefProv_' + thisPosArr).length) ? jQuery('#RefProv_' + thisPosArr).val() : '' ;
		var Descripcion = jQuery('#Desc_' + thisPosArr).val();
		var Marca = jQuery('#Marca_' + thisPosArr).val();
		var UdsXLote = jQuery('#UdsLote_' + thisPosArr).val();
		var Precio = jQuery('#Precio_' + thisPosArr).val();
		var Cantidad = arrProductos[Indice].Cantidad;
		var TipoIVA = jQuery('#TIPOIVA_' + thisPosArr).val();						//	27ene23 arrProductos[Indice].TipoIVA;
		var d = new Date();
		
		//	26ene23 Informar precio y unidades por lote a 0 cuando se quiere borrar el producto
		if (tipo=='BORRAR')
		{
			UdsXLote='0';
			Precio='0,0000';
		}
		else if (tipo=='ALTER')
			IDOfeLic='';	//No devolvemos IDOFELIC si queremos crear una nueva oferta
		
		var CadParametros=" LIC_ID:"+IDLicitacion+"&LIC_PROD_ID:"+IDLicProd+"&LIC_PROV_ID:"+IDLicProv+"&REFPROV:"+encodeURIComponent(ScapeHTMLString(RefProv))+"&DESC:"+encodeURIComponent(ScapeHTMLString(Descripcion))+"&MARCA:"
					+encodeURIComponent(ScapeHTMLString(Marca))+"&UDSXLOTE:"+UdsXLote+"&CANTIDAD:"+Cantidad+"&PRECIO:"+Precio+"&TIPOIVA:"+TipoIVA+"&IDFICHA:"+IDFicha+"&REGSANITARIO="+RegSanitario+"&IDREGSANITARIO="+IDRegSanitario
					+"&IDCERTEXPERIENCIA="+IDCertExperiencia+"&IDFICHASEG="+IDFichaSeg+"&ALTERNATIVA:"+Alternativa+"&IDOFERTALIC="+IDOfeLic
					+"&CODEXPEDIENTE="+encodeURIComponent(ScapeHTMLString(CodExp))+"&CODCUM="+encodeURIComponent(ScapeHTMLString(CodCum))+"&CODIUM="+encodeURIComponent(ScapeHTMLString(CodIum))+"&CODINVIMA="+encodeURIComponent(ScapeHTMLString(CodInv))+"&FECHACADINVIMA="+encodeURIComponent(ScapeHTMLString(CadInv))+"&CLASRIESGO="+encodeURIComponent(ScapeHTMLString(ClasRiesgo));	//3feb23
					
		//solodebug
		console.log("Preparando AnadirUnaOfertaAJAX. thisPosArr:"+thisPosArr+' CadParms:'+CadParametros)

		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/AnadirUnaOfertaAJAX.xsql',
			type:	"GET",
			data:	"LIC_ID="+IDLicitacion+"&LIC_PROD_ID="+IDLicProd+"&LIC_PROV_ID="+IDLicProv+"&REFPROV="+encodeURIComponent(ScapeHTMLString(RefProv))+"&DESC="+encodeURIComponent(ScapeHTMLString(Descripcion))+"&MARCA="
					+encodeURIComponent(ScapeHTMLString(Marca))+"&UDSXLOTE="+UdsXLote+"&CANTIDAD="+Cantidad+"&PRECIO="+Precio+"&TIPOIVA="+TipoIVA+"&IDFICHA="+IDFicha+"&REGSANITARIO="+RegSanitario+"&IDREGSANITARIO="+IDRegSanitario
					//ESTADOEVALUACION
					+"&IDCERTEXPERIENCIA="+IDCertExperiencia+"&IDFICHASEG="+IDFichaSeg+"&ALTERNATIVA="+Alternativa	
					+"&IDOFERTALIC="+IDOfeLic					//26ene23
					+"&CODEXPEDIENTE="+encodeURIComponent(ScapeHTMLString(CodExp))+"&CODCUM="+encodeURIComponent(ScapeHTMLString(CodCum))+"&CODIUM="+encodeURIComponent(ScapeHTMLString(CodIum))+"&CODINVIMA="+encodeURIComponent(ScapeHTMLString(CodInv))+"&FECHACADINVIMA="+encodeURIComponent(ScapeHTMLString(CadInv))+"&CLASRIESGO="+encodeURIComponent(ScapeHTMLString(ClasRiesgo))	//3feb23
					+"&_="+d.getTime(),
			beforeSend: function(){
				jQuery('#btnGuardar_'+thisPosArr).attr('class','guardarOferta btnGris');
				jQuery('#btnAlter_'+thisPosArr).attr('class','guardarOferta btnGris');
			},
			error: function(objeto, quepaso, otroobj){
				jQuery('#AVISOACCION_'+thisPosArr).html('<img src="http://www.newco.dev.br/images/error.gif"/>');
				alert('error'+quepaso+' '+otroobj+' '+objeto);
			},
			success: function(objeto){
				var data = eval("(" + objeto + ")");

				//	22jul19 Recupera los botones
				jQuery('#btnGuardar_'+thisPosArr).attr('class','guardarOferta btnDestacado');
				jQuery('#btnAlter_'+thisPosArr).attr('class','guardarOferta btnDestacado');

				if((tipo=='BORRAR')||(data.OfertaActualizada.IDOferta > 0)){	//al borrar devuelve IDOferta en blanco

					jQuery('#AVISOACCION_'+thisPosArr).html('<img src="http://www.newco.dev.br/images/recibido.gif"/>');
	
					//solodebug	console.log("guardarOfertaFila. thisPosArr:"+thisPosArr+" tipo:"+tipo+' arrProductos.length:'+arrProductos.length+' totalProductos:'+totalProductos+' GUARDADO OK. PROCESANDO.');
					
					if (tipo=='ALTER')
					{

						//solodebug	
						console.log("guardarOfertaFila. thisPosArr:"+thisPosArr+" tipo:"+tipo+' arrProductos.length:'+arrProductos.length+' totalProductos:'+totalProductos+' GUARDADO OK. INSERTANDO EN ARRAY.');

						//solodebug		MuestraMatrizOfertas();
						
						//	Incluimos el nuevo producto en el array
						var items		= [];
						var f = new Date();
						items['linea']		= arrProductos.length+1;				//	El contador empieza a 1 en lugar de 0
						items['IDProdLic']	= arrProductos[Indice].IDProdLic;
						items['IDProd']		= arrProductos[Indice].IDProd;
						items['RefEstandar']= arrProductos[Indice].RefEstandar;
						items['RefCliente']	= arrProductos[Indice].RefCliente;
						items['Nombre']		= arrProductos[Indice].Nombre;
						items['NombreNorm']	= arrProductos[Indice].NombreNorm;
						items['UdBasica']	= arrProductos[Indice].UdBasica;
						items['FechaAlta']	= f.getDate() + "/" + (f.getMonth()+1) + "/" + f.getFullYear();
						items['FechaMod']	= f.getDate() + "/" + (f.getMonth()+1) + "/" + f.getFullYear();
						items['Consumo']	= arrProductos[Indice].Consumo;
						items['ConsumoIVA']	= arrProductos[Indice].ConsumoIVA;
						items['Cantidad']	= arrProductos[Indice].Cantidad;
						items['PrecioHist']	= arrProductos[Indice].PrecioHist;
						items['PrecioObj']	= arrProductos[Indice].PrecioObj;
						items['TipoIVA']	= arrProductos[Indice].TipoIVA;
						items['Ordenacion']	= arrProductos[Indice].Ordenacion;
						items['PrecioMin']	= arrProductos[Indice].PrecioMin;
						items['PrecioMax']	= arrProductos[Indice].PrecioMax;
						items['Marcas']		= arrProductos[Indice].Marcas;
						items['PrincActivo']= arrProductos[Indice].PrincActivo;
						items['OfertaAnterior']	= arrProductos[Indice].OfertaAnterior;
						items['ForzarCaja']	=arrProductos[Indice].ForzarCaja;

						// Campos Avanzados producto
						items['InfoAmpliada']	= arrProductos[Indice].InfoAmpliada;
						items['Documento']	= [];
						if (arrProductos[Indice].Documento.length)
						{
							items['Documento']['ID']		= arrProductos[Indice].Documento.ID;
							items['Documento']['Nombre']		= arrProductos[Indice].Documento.Nombre;
							items['Documento']['Descripcion']	= arrProductos[Indice].Documento.Descripcion;
							items['Documento']['Url']		= arrProductos[Indice].Documento.Url;
							items['Documento']['Fecha']		= arrProductos[Indice].Documento.Fecha;
						}
						// FIN Campos Avanzados producto

						items['ConsumoOferta']	= arrProductos[Indice].ConsumoOferta;

						items['Oferta']	= [];
						items['Oferta']['ID']		= data.OfertaActualizada.IDOferta;
						items['Oferta']['Alternativa']= Alternativa;
						items['Oferta']['IDProvLic']	= IDLicProv;
						items['Oferta']['IDProducto']	= IDLicProd;
						items['Oferta']['RefProv']	= RefProv;
						items['Oferta']['Nombre']	= Descripcion;
						items['Oferta']['Marca']	= Marca;
						items['Oferta']['FechaAlta']= f.getDate() + "/" + (f.getMonth()+1) + "/" + f.getFullYear();
						items['Oferta']['FechaMod']	= f.getDate() + "/" + (f.getMonth()+1) + "/" + f.getFullYear();
						items['Oferta']['UdsXLote']	= UdsXLote;
						items['Oferta']['Cantidad']	= Cantidad;
						items['Oferta']['Precio']	= Precio;
						items['Oferta']['TipoIVA']	= TipoIVA;
						items['Oferta']['Consumo']	= Precio*Cantidad;
						items['Oferta']['ConsumoIVA']	= Precio*Cantidad*(1+TipoIVA/100);
						items['Oferta']['IDEstadoEval']	= '';
						items['Oferta']['EstadoEval']	= '';
						items['Oferta']['Marca']	= Marca;
						items['Oferta']['CodRegistroSanitario']	= RegSanitario;				//26ene23

						// Campos Avanzados oferta
						items['Oferta']['InfoAmpliada']	= '';
						items['Oferta']['Documento']	= [];
						items['Oferta']['Informada']	= 'S';
						items['Oferta']['Adjudicada']	= 'N';
						items['Oferta']['NoOfertada']	= 'N';
						items['Oferta']['NoInformada']	= 'N';

						items['Oferta']['FichaTecnica']	= [];								//26ene23
						items['Oferta']['FichaTecnica']['ID']=IDFicha;						//26ene23

						items['Oferta']['RegSanitario']	= [];								//26ene23
						items['Oferta']['RegSanitario']['ID']=IDRegSanitario;				//26ene23			

						items['Oferta']['CertExperiencia']	= [];							//26ene23
						items['Oferta']['CertExperiencia']['ID']=IDCertExperiencia;			//26ene23				

						arrProductos.push(items);						
						ColumnaOrdenadaProds[totalProductos]=totalProductos;		//	13mar19	Creamos la entrada en el array de ordenaci�n
						++totalProductos;

						//para pruebas	ColumnaOrdenadaProds[totalProductos]=totalProductos;		//	13mar19	Creamos la entrada en el array de ordenaci�n
						//solodebug		console.log("guardarOfertaFila. thisPosArr:"+thisPosArr+" tipo:"+tipo+' arrProductos.length:'+arrProductos.length+' totalProductos:'+totalProductos);

						//solodebug	console.log("guardarOfertaFila. thisPosArr:"+thisPosArr+" tipo:"+tipo+' arrProductos.length:'+arrProductos.length+' totalProductos:'+totalProductos+' INSERTADO EN ARRAY.');
						//solodebug	MuestraMatrizOfertas();

						//Ordena (y redibuja la tabla de productos)
						//Solodebug	console.log("guardarOfertaFila. thisPosArr:"+thisPosArr+" tipo:"+tipo+' arrProductos.length:'+arrProductos.length+' totalProductos:'+totalProductos+'. OrdenarProdsPorColumna (Ordena y dibuja)');

						OrdenarProdsPorColumna(ColumnaOrdenacionProds, true);

						//solodebug	console.log("guardarOfertaFila. thisPosArr:"+thisPosArr+" tipo:"+tipo+' arrProductos.length:'+arrProductos.length+' totalProductos:'+totalProductos+' TRAS ORDENAR Y DIBUJAR.');
						//solodebug	MuestraMatrizOfertas();

						ofertaVacia ='N';
					}
					if (tipo=='BORRAR')
					{
						//	Si es una variante de un producto, redibuja la tabla
						if (Alternativa>=1)
						{
							//Quita en el array de productos el registro que sobra
							//arrProductos.splice(Indice, 1);
							//--totalProductos;
							//OrdenarProdsPorColumna(ColumnaOrdenacionProds, true);
						
							//dibujaTablaProductosPROVE();
							
							//Colocamos el cursor en el nuevo indice
							//var Pos=(Indice-1>0)?Indice-1:0;
							//debug('AnadirUnaOfertaAJAX. colocar foco ('+Pos+')');
							//oForm.elements['RefProv_' + Pos].focus();
							
							
							RecargaLicProv(); 
						}
						else
						{
							//	Actualizamos los datos de la oferta
							arrProductos[Indice].Oferta.RefProv='';		
							arrProductos[Indice].Oferta.Nombre='';		
							arrProductos[Indice].Oferta.Precio='0';		
							arrProductos[Indice].Oferta.UdsXLote='0';
							arrProductos[Indice].Oferta.Marca='';
							arrProductos[Indice].Oferta.NoOfertada='S';
							arrProductos[Indice].Oferta.Informada='N';
							arrProductos[Indice].Oferta.NoInformada='S';

							//	26ene23 Limpiamos los campos
							jQuery('#Desc_' + thisPosArr).val('');
							jQuery('#Marca_' + thisPosArr).val('');
							jQuery('#UdsLote_' + thisPosArr).val('0');
							jQuery('#Precio_' + thisPosArr).val('0,0000');

							//	24jul19 Quitamos el color gris para poder guardar la oferta
							jQuery('#btnGuardar_'+thisPosArr).attr('class','guardarOferta btnDestacado');

							//	22mar19 Ponemos el fondo rojo
							jQuery('#posArr_'+thisPosArr).attr('class','infoProds fondoRojo');

							//	24jul19 Dejamos los botones de color gris
							jQuery('#btnGuardar_'+thisPosArr).attr('class','guardarOferta btnGris');
							jQuery('#btnAlter_'+thisPosArr).attr('class','guardarOferta btnGris');
						}
					}
					else
					{
						//	Actualizamos los datos de la oferta
						arrProductos[Indice].Oferta.RefProv=RefProv;		
						arrProductos[Indice].Oferta.Nombre=Descripcion;		
						arrProductos[Indice].Oferta.Precio=Precio;		
						arrProductos[Indice].Oferta.UdsXLote=UdsXLote;
						arrProductos[Indice].Oferta.Marca=Marca;
						arrProductos[Indice].Oferta.NoOfertada='N';
						arrProductos[Indice].Oferta.Informada='S';
						arrProductos[Indice].Oferta.NoInformada='N';
						arrProductos[Indice].Oferta.ID=data.OfertaActualizada.IDOferta;
						
						//	22mar19 QUitamos el fondo rojo en caso de que lo tuviera
						jQuery('#posArr_'+thisPosArr).attr('class','infoProds');
						
						jQuery('#btnAvanz_'+thisPosArr).show();		//	30oct19 Mostramos el bot�n para incluir datos complementarios
						
						//solodebug	MuestraMatrizOfertas();

						//	Redibuja la tabla de productos
						//	dibujaTablaProductosPROVE();

					}

					ofertaVacia ='N';
					ofertaProvInformada = 'S';

					validarBotonPublicarOferta();
					
					if (recal==='S') MostrarFloatingBox_PROV();			//	Actualizar la ventana de resumen

				}
				else
				{
					jQuery('#AVISOACCION_'+thisPosArr).html('<img src="http://www.newco.dev.br/images/error.gif"/>');
					
					if (data.OfertaActualizada.IDOferta==-2)	//	Si se ha superado el plazo, recargamos la p�gina para que se vea como ha quedado la oferta
						RecargaLicProv(); 	//	23jul19	location.reload();
					
				}
			}
		});
	}

	//17set16	jQuery("#BtnActualizarOfertas").show();
	//17set16	jQuery(".guardarOferta").show();

}



//	15mar19 Prepara la recuperaci�n de fichero de disco y el env�o seg�n opci�n seleccionada
function EnviarFicheroOfertas(files)
{
	//	Inicia la carga del fichero
	var file = files[0];

	var reader = new FileReader();

	reader.onload = function (e) {
		
		console.log('Contenido fichero '+file.name);
		ActualizarOfertas(e.target.result)
	};

	reader.readAsText(file);
	
}


//	21jun17	Extraemos los datos desde un areatext
function ActualizarOfertasDesdeAreaText(oForm)
{
	ActualizarOfertas(oForm.elements['LIC_LISTA_OFERTAS'].value);
}


//	Actualiza las ofertas desde cadena de texto (areatext o fichero).
//	Formato: Ref Nombre Marca Udes/lote Precio (separadores v�lidos: espacio, tabulador, etc)
//	25mar19 Tambi�n comprueba que utilice una marca correcta
/*
	Cambios debidos a ofertas m�ltiples:
	.- Comprobar si existe una oferta para el producto
	.- SI no existe, informar la oferta actual
	.- SI existe:
		- Modo completar: comprobar si existe la referencia de proveedor
			- SI existe: sustituir
			- SI no existe, crear una nueva
		- Modo sustituir: comprobar si existe la referencia de proveedor
			- SI existe: sustituir
			- SI no existe, crear una nueva
			
	SI se han creado nuevas ofertas, reordenar y redibujar
	
	
	14dic21 Si los documentos son obligatorios, no se envian las lineas
*/
function ActualizarOfertas(Referencias)
{
	var Cambios=false, Modificados=0, NoEncontrados=0, NoInformados=0, RefNoEncontradas='', ErrorMarca=0, RefConErrorMarca='', alternativasCreadas=0,RefAlternativasCreadas='';
	
	var docObligatorios='N';
	
	var Completar=document.getElementById('COMPLETAROFERTA').checked;
	
	if ((FTObligatoria=='S')||(RSObligatorio=='S')||(CEObligatorio=='S'))
		docObligatorios='S';
	
	
	jQuery("#EnviarOfertasPorRef").hide();
	
	//solodebug	var Control='';
	//var Referencias	= oForm.elements['LIC_LISTA_OFERTAS'].value.replace(/(?:\r\n|\r|\n)/g, '|');
	Referencias	= Referencias.replace(/(?:\r\n|\r|\n)/g, '�');
	Referencias	= Referencias.replace(/[\t:;|]/g, ':');	// 	Separadores admitidos para separar referencia de cantidad
	
	var numRefs	= PieceCount(Referencias, '�');

	//solodebug		
	console.log('>>>> ActualizarOfertas [INICIO] Oferta <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<');

	
	for (var i=0;i<=numRefs;++i)
	{
		var Ref,RefProv,RefProv2,Nombre,Marca,UdsXLote,Precio,TipoIva,RegSan,CodExpediente,CodCum,CodIum,CodInvima,FechaCadInvima,ClasRiesgo;
		var Producto	= Piece(Referencias, '�',i);
		if (IDPais==55)
		{
			Ref			= Piece(Producto, ':', 0).toUpperCase();
			Nombre		= Piece(Producto, ':', 1);
			Marca		= Piece(Producto, ':', 2).toUpperCase();
			UdsXLote	= Piece(Producto, ':', 3);
			Precio		= Piece(Producto, ':', 4);
			RegSan		= Piece(Producto, ':', 5);
			RefProv		= Ref+'-'+UdsXLote+'-'+Marca;	//	Misma formula que se aplica en la base de datos
		}
		else
		{
			Ref			= Piece(Producto, ':', 0).toUpperCase();
			RefProv		= Piece(Producto, ':', 1);
			Nombre		= Piece(Producto, ':', 2);
			Marca		= Piece(Producto, ':', 3).toUpperCase();
			UdsXLote	= Piece(Producto, ':', 4);
			Precio		= Piece(Producto, ':', 5);
			TipoIVA		= Piece(Producto, ':', 6);
			RegSan		= Piece(Producto, ':', 7);
			CodExpediente	= Piece(Producto, ':', 8);
			CodCum		= Piece(Producto, ':', 9);
			CodIum		= Piece(Producto, ':', 10);
			CodInvima	= Piece(Producto, ':', 11);
			FechaCadInvima	= Piece(Producto, ':', 12);
			ClasRiesgo	= Piece(Producto, ':', 13);
		}
		
		//	Trabajaremos con las referencias y marcas en may�sculas
		Ref=Ref.toUpperCase();
		Marca=Marca.toUpperCase();
		
		//solodebug	
		console.log('>>>> ActualizarOfertas [INICIO] Oferta ('+i+'). Ref:'+Ref+' RefProv:'+RefProv+' Prod:'+Nombre+' Marca:'+Marca+' UdsXLote:'+UdsXLote+' Precio:'+Precio+' TipoIVA:'+TipoIVA
			+' RegSan:'+RegSan+' CodExpediente:'+CodExpediente+' CodCum:'+CodCum+' CodIum:'+CodIum+' CodInvima:'+CodInvima+' FechaCadInvima:'+FechaCadInvima+' ClasRiesgo:'+ClasRiesgo	);
		
		if ((Ref=='')||(Ref=='REFCLIENTE'))
		{
		
			//solodebug	console.log('>>>> ActualizarOfertas [INICIO] Oferta ('+i+'). Ref:'+Ref+' Saltando l�nea vac�a');
		
		}
		else
		{
			//solodebug	Control=Control+'['+i+'/'+numRefs+'] Referencia:'+Ref+ '. Cantidad:'+Cant;

			//	Recorre el array de productos buscando la referencia
			var Encont=false;

			for (var j=0;((j<arrProductos.length) && (!Encont));++j)
			{

				//solodebug	console.log('ActualizarOfertas Oferta ('+i+') Fila:'+j+' Buscando Ref:'+Ref+' RefCliente:'+arrProductos[ColumnaOrdenadaProds[j]].RefCliente+' RefEstandar:'+arrProductos[ColumnaOrdenadaProds[j]].RefEstandar);

				if ((arrProductos[ColumnaOrdenadaProds[j]].RefCliente==Ref)||(arrProductos[ColumnaOrdenadaProds[j]].RefEstandar==Ref))
				{


					//solodebug	console.log('ActualizarOfertas Oferta ('+i+') Fila:'+j+'. Ref:'+Ref+' RefProv:'+arrProductos[ColumnaOrdenadaProds[j]].Oferta.RefProv+' Prod:'+Nombre+' Marca:'+Marca+' UdsXLote:'+UdsXLote+' Precio:'+Precio);

					Encont=true;


					//solodebug		console.log(Ref+' encontrado en posicion '+j);
					if (((UdsXLote==='')||(UdsXLote==='0'))&&((Precio==='')||(Precio==='0')))	//	11jul19 Ofertas sin precio ni empaquetamiento
					{
						++NoInformados;

						//solodebug	console.log('ActualizarOfertas Oferta ('+i+') Fila:'+j+'. Ref:'+Ref+' SIN OFERTA');

					}
					else if (!MarcaOK(arrProductos[ColumnaOrdenadaProds[j]].Marcas, Marca))
					{
						//solodebug	console.log("ActualizarOfertas. Comprobando:"+j+" RefProv:"+arrProductos[ColumnaOrdenadaProds[j]].Oferta.RefProv+" ERROR MARCA");
						
						ErrorMarca++;
						RefConErrorMarca+=Ref+' ';
					}
					else
					{
						//solodebug	
							console.log("ActualizarOfertas. Comprobando:"+j
											+" RefProv:"+arrProductos[ColumnaOrdenadaProds[j]].Oferta.RefProv
											+" RefProvAnt:"+RefProv
											+" RefProvAnt2:"+arrProductos[ColumnaOrdenadaProds[j]].RefEstandar.toUpperCase()+'-'+arrProductos[ColumnaOrdenadaProds[j]].Oferta.UdsXLote+'-'+arrProductos[ColumnaOrdenadaProds[j]].Oferta.Marca.toUpperCase()
											+" NumAlt:"+arrProductos[ColumnaOrdenadaProds[j]].NumAlternativas
											+ 'Completar:'+Completar);
						
						//	COmprueba si se puede sustituir una oferta existente
						if ((arrProductos[ColumnaOrdenadaProds[j]].NumAlternativas==0)								//	Si no hay ofertas, siempre informar� el registro actual
							||(arrProductos[ColumnaOrdenadaProds[j]].Oferta.RefProv==RefProv)						//	Misma ref.proveedor, siempre informar� el registro actual
							||((arrProductos[ColumnaOrdenadaProds[j]].Oferta.UdsXLote==UdsXLote) && (arrProductos[ColumnaOrdenadaProds[j]].Oferta.Marca.toUpperCase()==Marca))						//	Misma ref.proveedor, siempre informar� el registro actual
							||((!Completar)&&(arrProductos[ColumnaOrdenadaProds[j]].NumAlternativas==1))			//	No completar, solo hay una oferta
							||((!Completar)&&(arrProductos[ColumnaOrdenadaProds[j]].Oferta.RefProv==RefProv))		//	Misma ref.proveedor
							||((!Completar)&&(arrProductos[ColumnaOrdenadaProds[j]].Oferta.CodRegistroSanitario==RegSan)))		//	Mismo registro sanitario
						{

							console.log("ActualizarOfertas. Comprobando:"+j+" RefProv:"+arrProductos[ColumnaOrdenadaProds[j]].Oferta.RefProv
								+" alternativas:"+arrProductos[ColumnaOrdenadaProds[j]].NumAlternativas+' SUSTITUIR OFERTA');

							jQuery('#Desc_' + (arrProductos[ColumnaOrdenadaProds[j]].linea-1)).val(Nombre);
							jQuery('#Marca_' + (arrProductos[ColumnaOrdenadaProds[j]].linea-1)).val(Marca);
							jQuery('#UdsLote_' + (arrProductos[ColumnaOrdenadaProds[j]].linea-1)).val(UdsXLote);
							jQuery('#Precio_' + (arrProductos[ColumnaOrdenadaProds[j]].linea-1)).val(Precio);
							jQuery('#REGSAN_' + (arrProductos[ColumnaOrdenadaProds[j]].linea-1)).val(RegSan);
							
							if ((IDPais != '55')&&(TipoIVA!=''))
							{
								//solodebug	
								console.log("ActualizarOfertas. #TIPOIVA_'" + (arrProductos[ColumnaOrdenadaProds[j]].linea-1)+" TipoIVA:"+TipoIVA);
								jQuery('#TIPOIVA_' + (arrProductos[ColumnaOrdenadaProds[j]].linea-1)).val(TipoIVA);
							}

							if ((IDPais == '57')&&(incluirRS=='S'))
							{
								jQuery('#CodExp_' + (arrProductos[ColumnaOrdenadaProds[j]].linea-1)).val(CodExpediente);
								jQuery('#CodCum_' + (arrProductos[ColumnaOrdenadaProds[j]].linea-1)).val(CodCum);
								jQuery('#CodIum_' + (arrProductos[ColumnaOrdenadaProds[j]].linea-1)).val(CodIum);
								jQuery('#CodInv_' + (arrProductos[ColumnaOrdenadaProds[j]].linea-1)).val(CodInvima);
								jQuery('#CadInvima_' + (arrProductos[ColumnaOrdenadaProds[j]].linea-1)).val(FechaCadInvima);
								jQuery('#ClasRiesgo_' + (arrProductos[ColumnaOrdenadaProds[j]].linea-1)).val(ClasRiesgo);
							}

							if (IDPais!=55)
							{
								jQuery('#RefProv_' + (arrProductos[ColumnaOrdenadaProds[j]].linea-1)).val(RefProv);
							}
							
							//solodebug	alert('guardarOfertaFila. ');
							
							ActivarBotonGuardar(arrProductos[ColumnaOrdenadaProds[j]].linea-1);
							
							
							if (docObligatorios=='N')
								guardarOfertaFila(arrProductos[ColumnaOrdenadaProds[j]].linea-1, '','N')

							/*
							//	Mostramos el bot�n de guardar para esta fila, y el de guardar todos
							jQuery('#btnGuardar_'+ (arrProductos[ColumnaOrdenadaProds[j]].linea-1)).show();
							jQuery('#btnAlter_'+ (arrProductos[ColumnaOrdenadaProds[j]].linea-1)).show();
							jQuery('#idGuardarTodasOfertas').show();
							*/
							
							//	5ju1l9 Si no ten�a oferta, indica que ahora si tiene 1
							if (arrProductos[ColumnaOrdenadaProds[j]].NumAlternativas==0) arrProductos[ColumnaOrdenadaProds[j]].NumAlternativas=1;

							Cambios=true;
							Modificados++;
						}
						else
						{

							//solodebug	console.log("ActualizarOfertas. Comprobando:"+j+" RefProv:"+arrProductos[ColumnaOrdenadaProds[j]].Oferta.RefProv+" alternativas:"+arrProductos[ColumnaOrdenadaProds[j]].NumAlternativas+' NO sustituir oferta');
								
							//	Si se ha encontrado la referencia de cliente, miramos si existe una entrada en la que coincida tambi�n la referencia de proveedor
							var ExisteOtra=false;
							
							for (var k=0;((k<arrProductos.length) && (!ExisteOtra));++k)
							{
								if (arrProductos[ColumnaOrdenadaProds[k]].Oferta.RefProv==RefProv)
									ExisteOtra=true;
							}
							
							//	Si no existe una entrada que coincida la referencia del proveedor, creamos una entrada nueva
							if (!ExisteOtra)
							{
								//	Incluimos el nuevo producto en el array, recuperando los datos del producto
								//solodebug	
								console.log("ActualizarOfertas. Crear nuevo:"+RefProv);
								
								var Alternativa=AlternativasInformadas(arrProductos[j].IDProdLic)+1,
									IDProdLic=arrProductos[j].IDProdLic,
									IDProvLic=arrProductos[j].Oferta.IDProvLic,
									Cantidad=arrProductos[j].Cantidad;
									
								//	Si no esta informado el tipo de IVA en la carga utilizamos el del array JS
								if (TipoIVA=='')
									TipoIVA=arrProductos[j].TipoIVA;
	
								var items		= [];
								var f = new Date();
								items['linea']		= arrProductos.length+1;					//	El contador empieza a 1 en lugar de 0
								items['IDProdLic']	= IDProdLic;
								items['IDProd']		= arrProductos[j].IDProd;
								items['RefEstandar']= arrProductos[j].RefEstandar;
								items['RefCliente']	= arrProductos[j].RefCliente;
								items['Nombre']		= arrProductos[j].Nombre;
								items['NombreNorm']	= arrProductos[j].NombreNorm;
								items['UdBasica']	= arrProductos[j].UdBasica;
								items['FechaAlta']	= f.getDate() + "/" + (f.getMonth()+1) + "/" + f.getFullYear();
								items['FechaMod']	= f.getDate() + "/" + (f.getMonth()+1) + "/" + f.getFullYear();
								items['Consumo']	= arrProductos[j].Consumo;
								items['ConsumoIVA']	= arrProductos[j].ConsumoIVA;
								items['Cantidad']	= Cantidad;
								items['PrecioHist']	= arrProductos[j].PrecioHist;
								items['PrecioObj']	= arrProductos[j].PrecioObj;
								items['TipoIVA']	= TipoIVA;
								items['Ordenacion']	= arrProductos[j].Ordenacion;
								items['PrecioMin']	= arrProductos[j].PrecioMin;
								items['PrecioMax']	= arrProductos[j].PrecioMax;
								items['Marcas']		= arrProductos[j].Marcas;
								items['NumAlternativas'] = 1;									//	5jul19
								items['ForzarCaja'] = 'N';										//	7feb23

								// Campos Avanzados producto
								items['InfoAmpliada']	= arrProductos[j].InfoAmpliada;
								items['Documento']	= [];
								if (arrProductos[j].Documento.length)
								{
									items['Documento']['ID']		= arrProductos[j].Documento.ID;
									items['Documento']['Nombre']		= arrProductos[j].Documento.Nombre;
									items['Documento']['Descripcion']	= arrProductos[j].Documento.Descripcion;
									items['Documento']['Url']		= arrProductos[j].Documento.Url;
									items['Documento']['Fecha']		= arrProductos[j].Documento.Fecha;
								}
								// FIN Campos Avanzados producto

								items['ConsumoOferta']	= arrProductos[j].ConsumoOferta;

								items['Oferta']	= [];
								items['Oferta']['ID']		= IDProdLic+Alternativa+'PENDIENTE';
								items['Oferta']['Alternativa']= Alternativa;
								items['Oferta']['IDProvLic']	= IDProvLic;
								items['Oferta']['IDProducto']	= IDProdLic;
								items['Oferta']['RefProv']	= RefProv;
								items['Oferta']['Nombre']	= Nombre;
								items['Oferta']['Marca']	= Marca;
								items['Oferta']['FechaAlta']= f.getDate() + "/" + (f.getMonth()+1) + "/" + f.getFullYear();
								items['Oferta']['FechaMod']	= f.getDate() + "/" + (f.getMonth()+1) + "/" + f.getFullYear();
								items['Oferta']['UdsXLote']	= UdsXLote;
								items['Oferta']['Cantidad']	= Cantidad;
								items['Oferta']['Precio']	= Precio;
								items['Oferta']['TipoIVA']	= TipoIVA;
								items['Oferta']['Consumo']	= Precio*Cantidad;
								items['Oferta']['ConsumoIVA']	= Precio*Cantidad*(1+TipoIVA/100);
								items['Oferta']['IDEstadoEval']	= '';
								items['Oferta']['EstadoEval']	= '';

								// Campos Avanzados oferta
								items['Oferta']['InfoAmpliada']	= '';
								items['Oferta']['Documento']	= [];
								items['Oferta']['Informada']	= 'S';
								items['Oferta']['Adjudicada']	= 'N';
								items['Oferta']['NoOfertada']	= 'N';
								items['Oferta']['NoInformada']	= 'N';
								items['Oferta']['FichaTecnica']	= [];
								items['Oferta']['RegSanitario']	= [];
								items['Oferta']['CertExperiencia']	= [];
								items['Oferta']['FichaSeguridad']	= [];
								items['Oferta']['Anterior']	= [];

								items['Oferta']['CodRegistroSanitario']	= RegSan;
								items['Oferta']['CodExpediente']	= CodExpediente;					//	INICIO Nuevos campos 6feb23
								items['Oferta']['CodCum']	= CodCum;
								items['Oferta']['CodIum']	= CodIum;
								items['Oferta']['CodInvima']	= CodInvima;
								items['Oferta']['FechaCadInvima']	= FechaCadInvima;
								items['Oferta']['ClasRiesgo']	= ClasRiesgo;							//	FIN Nuevos campos 6feb23

								arrProductos.push(items);						
								ColumnaOrdenadaProds[totalProductos]=totalProductos;					//	13mar19	Creamos la entrada en el array de ordenaci�n
								++totalProductos;
								
								++alternativasCreadas;
								RefAlternativasCreadas+=Ref+' ';
								
								arrProductos[ColumnaOrdenadaProds[j]].NumAlternativas++;				//	06feb23


								//	5jul19 Redibujar tabla y guardar la oferta
								
								//solodebug
								//solodebug
								//solodebug
								//solodebugalert('CUIDADO! OrdenarProdsPorColumna. Ref.actual:'+arrProductos[j].RefCliente);
								//solodebugreturn;;
								//solodebug
								//solodebug
								//solodebug
								
								OrdenarProdsPorColumna(ColumnaOrdenacionProds, true);
								
								ActivarBotonGuardar(totalProductos-1);
								
								if (docObligatorios=='N')
									guardarOfertaFila(totalProductos-1, '','N');
								
								ofertaVacia='N';
							
							}
						
						}
					}
				}
			}
			//solodebug	
			if (!Encont) 
			{
				NoEncontrados++;
				RefNoEncontradas+=Ref+' ';
			}

			//solodebug	Control=Control+'\n\r';
		}

	}
	
	/*
	
	
		CUIDADO!!! Redibujar borra los datos pendientes de guardar
			
	if (alternativasCreadas>0)
		OrdenarProdsPorColumna(ColumnaOrdenacionProds, true);
	*/
	
	var aviso=alrt_AvisoOfertasActualizadas.replace('[[MODIFICADOS]]',Modificados).replace('[[NO_ENCONTRADOS]]',NoEncontrados+(NoEncontrados==0?".":":"+RefNoEncontradas));
	aviso=aviso.replace('[[NO_INFORMADOS]]',NoInformados);		//	11jul19 Ofertas sin precio ni empaquetamiento
	aviso=aviso.replace('[[ERROR_MARCA]]',ErrorMarca+(ErrorMarca==0?".":":"+RefConErrorMarca)).replace('[[NUEVAS_ALTERNATIVAS]]',alternativasCreadas+(alternativasCreadas==0?".":":"+RefAlternativasCreadas));

	alert(aviso);

	//	8jul19 jQuery("#EnviarOfertasPorRef").show();
	
	// 8jul19 Recargamos de nuevo toda la p�gina, para asegurar que se recalculan todos los datos

	if (docObligatorios=='N')
		RecargaLicProv();					//	23jul19	location.reload();
	else
		jQuery("#EnviarOfertasPorRef").show();
	
}


// Funcion recursiva para guardar los datos de todas las ofertas modificadas
function guardarTodasOfertasAjax(Pos){

	//	Si hemos superado el l�mite, sale
	if (Pos>=arrProductos.length)
	{
		jQuery("#idGuardarTodasOfertas").hide();
		return;
	}
	
	//	Comprueba si esta fila ha sido modificada, si no pasa a la siguiente
	if (!jQuery('#btnGuardar_'+Pos).is(':visible'))
	{
		guardarTodasOfertasAjax(Pos+1);
		return;
	}
	
	guardarOfertaFila(Pos,'','N');
	guardarTodasOfertasAjax(Pos+1);

}


//	Nuevo campo "frete"
function cambiofrete(form, tipofrete)
{
	if (tipofrete=='cif'){
		form.elements['frete_tipo_fob'].checked=false;
		form.elements['LIC_PROV_FRETE'].value="CIF";
	}else{
		form.elements['frete_tipo_cif'].checked=false;
		form.elements['LIC_PROV_FRETE'].value="FOB";
	}
}


//	Floating Box para proveedor, tiene en cuenta que pueden haber varias ofertas por producto
function MostrarFloatingBox_PROV(){
	var numProductos = 0, numOfertas = 0, numCumpleObj = 0, UdsXLote;
	var Cantidad, CantidadFormat, PrecioOfe, PrecioOfeFormat, PrecioObj, PrecioObjFormat, ConsumoOfe = 0;
	var valAux;


	jQuery.each(arrProductos, function(key, producto){
		UdsXLote = producto.Oferta.UdsXLote.replace(',','.');
		
		if (producto.Oferta.Alternativa==0)			// solo incrementamos un producto si es la alternativa 0
		{
			numProductos++;
		
		//solodebug	alert('Marca:'+producto.Oferta.Marca+' UdsxLote:'+producto.Oferta.UdsXLote+' Precio:'+producto.Oferta.Precio);

			// Si existe oferta informada
			if(UdsXLote > 0){
				numOfertas++;

				Cantidad	= producto.Cantidad;
				CantidadFormat	= Cantidad.replace(/\./g,"").replace(",",".");
				PrecioOfe	= producto.Oferta.Precio;
				valAux = PrecioOfe.replace(",",".");
				if(!isNaN(valAux) && !esNulo(valAux)){
					PrecioOfeFormat	= valAux;
				}else{
					PrecioOfeFormat	= 0;
				}
				PrecioObj	= producto.PrecioObj;
				valAux = PrecioObj.replace(",",".");
				if(!isNaN(valAux) && !esNulo(valAux)){
					PrecioObjFormat	= valAux;
				}else{
					PrecioObjFormat	= 0;
				}
				if(PrecioOfeFormat <= PrecioObjFormat){
					numCumpleObj++;
				}
				// Consumo Oferta
				if(PrecioOfeFormat != 0){
					ConsumoOfe	+= CantidadFormat * PrecioOfeFormat;
				}
			}
		}
	});

	//solodebug	alert('numOfertas:'+numOfertas);

	jQuery('#FBNumInform').html(numOfertas+'/'+numProductos);	//	3set16	jQuery('.#FBNumInform')
	jQuery('#FBNumOpt').html(numCumpleObj);
	jQuery('#FBConsOfe').html(FormatoNumero(ConsumoOfe.toFixed(2)));

	if(ofertaProvInformada == 'S' && pedidoMinimoInform == 'S'){
		jQuery('#FBAviso').html('&nbsp;<img src="http://www.newco.dev.br/images/check.gif" style="vertical-align:text-bottom;"/>');
	}else{
		jQuery('#FBAviso').html('&nbsp;<img src="http://www.newco.dev.br/images/atencion.gif" style="vertical-align:text-bottom;"/>');
	}

	jQuery('#floatingBoxMin').show();
}



//	25mar19 Comprueba que la marca sea correcta, devuelve siempre "true" para empresas que no obligan a informar la marca
function MarcaOK(ListaMarcas, Marca)
{
	var MarcaOk=false;

	if ((ListaMarcas=='')||(Marca=='')||(SoloMarcasAutorizadas=='N')) MarcaOk=true;
	else
	{
		for (var i=0;i<=PieceCount(ListaMarcas,',');++i)
		{
			if (Piece(ListaMarcas,',',i)==Marca) MarcaOk=true;
		}
	}
	
	//	solodebug
	console.log('MarcaOK. ListaMarcas:'+ListaMarcas+' Marca:'+Marca+' MarcaOk:'+MarcaOk);
	
	return MarcaOk;
}


//	Presenta el comunicado al proveedor, guarda la confirmaci�n si el proveedor lo acepta
function PresentaComunicado()
{
	if (confirm(strComunicado))
	{
		var d = new Date();

		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/FirmarComunicadoAJAX.xsql',
			type:	"GET",
			data:	"IDEMPRESA="+IDProveedorIni+"&IDLICITACION="+IDLicitacion+"&IDCOMUNICADO="+IDComunicado+"&_="+d.getTime(),
			contentType: "application/xhtml+xml",
			beforeSend: function(){
				jQuery("#MensPedidoMinimo").hide();
			},
			error: function(objeto, quepaso, otroobj){
				alert('error'+quepaso+' '+otroobj+' '+objeto);
			},
			success: function(objeto){
				var data = eval("(" + objeto + ")");

				if(data.Resultado.estado == 'OK'){
					if(data.Resultado.id == IDProvLic){
						pedidoMinimoInform = 'S';		// variable global para poder publicar la oferta
						validarBotonPublicarOferta();	// Validamos para habilitar el boton de 'PublicarOferta'
						jQuery("#MensPedidoMinimo").show();
						ActivarTablaProductos();
						PedidoMinimoPend='N';
					}
				}else{
					alert('ERROR');
				}
			}
		});
	}
	else
	{
		alert(txtRechazoComunicado);
		window.close();
	}
}


// Funcion para abrir el div flotante - formulario para anyadir campos avanzados de ofertas
function abrirCamposAvanzadosOfe(posArr){
	var infoAmpliada= arrProductos[posArr].Oferta.InfoAmpliada.replace(/<br>/gi,'\n');
	var IDDoc		= (typeof arrProductos[posArr].Oferta.Documento.ID !== 'undefined') ? arrProductos[posArr].Oferta.Documento.ID : '';
	var nombreDoc	= arrProductos[posArr].Oferta.Documento.Nombre;

	jQuery("#camposAvanzados #posArray").val(posArr);
	jQuery('#camposAvanzados #txtInfoAmpliada').val(infoAmpliada);
					
	//solodebug
	debug('abrirCamposAvanzadosOfe. posArr:'+posArr+' infoAmpliada:'+infoAmpliada+' IDDoc:'+IDDoc+' nombreDoc:'+nombreDoc);


	if(IDDoc != '')
	{
		jQuery('#camposAvanzados input#IDDOC').val(IDDoc);
		jQuery('#camposAvanzados input#NombreDoc').val(nombreDoc);
		jQuery('#camposAvanzados input#UrlDoc').val('http://www.newco.dev.br/Documentos/'+arrProductos[posArr].Oferta.Documento.Url);
		jQuery("#camposAvanzados span#NombreDoc").html('<a href="http://www.newco.dev.br/Documentos/'+arrProductos[posArr].Oferta.Documento.Url+'" target="_blank">'+nombreDoc+'</a>');
		jQuery("#camposAvanzados span#DocCargado").show();
		jQuery("#camposAvanzados input#inputFileDoc_CA").hide();
	}
	else
	{
		jQuery('#camposAvanzados input#IDDOC').val('');
		jQuery("#camposAvanzados span#NombreDoc").html('');
		jQuery("#camposAvanzados span#DocCargado").hide();
		jQuery("#camposAvanzados input#inputFileDoc_CA").show();
	}

	jQuery("#camposAvanzados #confirmBox_CA").hide();
	showTablaByID("camposAvanzados");
}


//	Guarda los campos avanzados de la oferta
function guardarCamposAvanzadosOfe()
{
	var posArr			= jQuery("#camposAvanzados #posArray").val();
	var infoAmpliada	= jQuery("#camposAvanzados #txtInfoAmpliada").val().replace(/'/g, "''");
	var IDDoc			= jQuery("#camposAvanzados input#IDDOC").val();
	var Nombre			= jQuery("#camposAvanzados input#NombreDoc").val();
	var Url				= jQuery("#camposAvanzados input#UrlDoc").val();
	var IDOferta		= arrProductos[posArr].Oferta.ID;
	var d = new Date();

	//4nov19 Guardamos en todos los casos, por si hay que reiniciar campos if(infoAmpliada != '' || IDDoc != ''){
		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/CamposAvanzadosOfeAJAX.xsql',
			type:	"POST",
			async:	false,
			data:	"IDOFERTA="+IDOferta+"&IDDOC="+IDDoc+"&INFOAMPLIADA="+encodeURIComponent(infoAmpliada)+"&_="+d.getTime(),
			success: function(objeto){
				//var data = eval("(" + objeto + ")");
				var data = JSON.parse(objeto);

				if(data.CamposAvanzadosOfe.estado == 'OK'){
					
					//4nov19 desactivamos provisionalmente recuperaDatosOfertaProductos(IDLicProveedor);
					
					//Guardamos los datos en la oferta que corresponda
					arrProductos[posArr].Oferta.InfoAmpliada=infoAmpliada;
					arrProductos[posArr].Oferta.Documento.ID=IDDoc;
					arrProductos[posArr].Oferta.Documento.Nombre=Nombre;
					arrProductos[posArr].Oferta.Documento.Url=Url;
					
					
					//solodebug	debug('guardarCamposAvanzadosOfe. Guardado OK. posArr:'+posArr+' infoAmpliada:'+infoAmpliada+' IDDoc:'+IDDoc+' Nombre:'+Nombre+'|'+arrProductos[posArr].Oferta.Documento.Nombre+' Url:'+Url+'|'+arrProductos[posArr].Oferta.Documento.Url);
					
			
					//4nov19 Ahora solo redibujamos la tabla
					prepararTablaProductos(true);
					
					
					
					alert(alrt_CamposAvanzadosOK);
					// Escondemos el formulario de campos avanzados
					showTabla(false);
        	    }
				else
				{
					alert(alrt_CamposAvanzadosKO);
				}
			},
			error: function(xhr, errorString, exception) {
				alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
			}
		});
	//4nov19 }
}


//	5nov19 Ademas de cerrar la tabla de campos avanzados, podr�a ser interesante actualizar la tabla de productos por si ha habido cambio en documento, pero este cambio todav�a requiere "guardar cambios"
function cerrarCamposAvanzados()
{
	showTabla(false);
	//5nov19 prepararTablaProductos(true);
}


//	recupera todas las ofertas de un proveedor. 27ene23 Incluimos multiples nuevos campos
function recuperaDatosOfertaProductos(LicProvID){
	var CheckCamposPublicar = true;
	var d		= new Date();

	ofertaVacia ='S';		//	21ago17
	
	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/RecuperaOfertaProductos.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&LIC_PROV_ID="+LicProvID+"&IDIDIOMA="+IDIdioma+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			arrProductos	= new Array();

			if(data.ProductosLicitacion.ListaProductosOfertas.length > 0){
				jQuery.each(data.ProductosLicitacion.ListaProductosOfertas, function(key, producto){
				
					// Comprobamos todos los productos estan validados para poder iniciar la licitacion
					if(producto.Informada == 'N'){
						CheckCamposPublicar = false;
					}
					else ofertaVacia = 'N';

					var items		= [];
					items['linea']		= producto.Linea;
					items['IDProdLic']	= producto.LIC_PROD_ID;
					items['IDProd']		= producto.IDProdEstandar;
					items['RefEstandar']	= producto.ProdRefEstandar;
					items['RefCliente']	= producto.ProdRefCliente;
					items['Nombre']		= producto.ProdNombre;
					items['NombreNorm']	= producto.ProdNombreNorm;
					items['UdBasica']	= producto.ProdUdBasica;
					items['FechaAlta']	= producto.FechaAlta;
					items['FechaMod']	= producto.FechaModificacion;
					items['Consumo']	= producto.Consumo;
					items['ConsumoIVA']	= producto.ConsumoIVA;
					items['Cantidad']	= producto.Cantidad;
					items['PrecioHist']	= producto.PrecioReferencia;
					items['PrecioObj']	= producto.PrecioObjetivo;
					items['TipoIVA']	= producto.TipoIVA;
					items['Ordenacion']	= '0';
					items['PrecioMin']	= producto.PrecioMin;
					items['PrecioMax']	= producto.PrecioMax;
					items['NumAlternativas']= producto.NumAlternativas;
					items['NumOfertas']= producto.NumOfertas;
					items['Marcas']= producto.Marcas;
					items['PrincActivo']= producto.PrincActivo;
					items['OfertaAnterior']	= producto.OfertaAnterior;
					items['ForzarCaja']	= producto.ForzarCaja;

					// Campos Avanzados producto
					items['InfoAmpliada']	= producto.InfoAmpliada;
					items['Documento']	= [];
					if(producto.Documento.ID != ''){
						items['Documento']['ID']		= producto.Documento.ID;
						items['Documento']['Nombre']		= producto.Documento.Nombre;
						items['Documento']['Descripcion']	= producto.Documento.Descripcion;
						items['Documento']['Url']		= producto.Documento.Url;
						items['Documento']['Fecha']		= producto.Documento.Fecha;
					}
					// FIN Campos Avanzados producto

					items['Oferta']	= [];
					items['Oferta']['ID']		= producto.IDOferta;
					items['Oferta']['IDProvLic']	= producto.LIC_PROV_ID;
					items['Oferta']['IDProducto']	= producto.IDProductoOfe;
					items['Oferta']['RefProv']	= producto.RefOfe;
					items['Oferta']['Nombre']	= producto.NombreOfe;
					items['Oferta']['Marca']	= producto.MarcaOfe;
					items['Oferta']['FechaAlta']	= producto.FechaAltaOfe;
					items['Oferta']['FechaMod']	= producto.FechaModificacionOfe;
					items['Oferta']['UdsXLote']	= producto.UdsXLoteOfe;
					items['Oferta']['Cantidad']	= producto.CantidadOfe;
					items['Oferta']['Precio']	= producto.PrecioOfe;
					items['Oferta']['PrecioColor']	= producto.Color;				//	16ene17
					items['Oferta']['TipoIVA']	= producto.TipoIVAOfe;
					items['Oferta']['Consumo']	= producto.ConsumoOfe;
					items['Oferta']['ConsumoIVA']	= producto.ConsumoIVAOfe;
					items['Oferta']['IDEstadoEval']	= producto.IDEstadoEvaluacionOfe;
					items['Oferta']['EstadoEval']	= producto.EstadoEvaluacionOfe;
					items['Oferta']['CodRegistroSanitario']	= producto.REGISTROSANITARIO;
					items['Oferta']['CodExpediente']	= producto.LIC_OFE_CODEXPEDIENTE;				//	INICIO Nuevos campos 6feb23
					items['Oferta']['CodCum']	= producto.LIC_OFE_CODCUM;
					items['Oferta']['CodIum']	= producto.LIC_OFE_CODIUM;
					items['Oferta']['CodInvima']	= producto.LIC_OFE_CODINVIMA;
					items['Oferta']['FechaCadInvima']	= producto.LIC_OFE_FECHACADINVIMA;
					items['Oferta']['ClasRiesgo']	= producto.LIC_OFE_CLASIFICACIONRIESGO;				//	FIN Nuevos campos 6feb23

					// Campos Avanzados oferta
					items['Oferta']['InfoAmpliada']	= producto.InfoAmpliadaOferta;
					items['Oferta']['Documento']	= [];
					if(producto.DocumentoOferta.ID != ''){
						items['Oferta']['Documento']['ID']		= producto.DocumentoOferta.ID;
						items['Oferta']['Documento']['Nombre']		= producto.DocumentoOferta.Nombre;
						items['Oferta']['Documento']['Descripcion']	= producto.DocumentoOferta.Descripcion;
						items['Oferta']['Documento']['Url']		= producto.DocumentoOferta.Url;
						items['Oferta']['Documento']['Fecha']		= producto.DocumentoOferta.Fecha;
					}
					// FIN Campos Avanzados oferta

					items['Oferta']['FichaTecnica']	= [];
					if(producto.FichaTecnica.ID != ''){
						items['Oferta']['FichaTecnica']['ID']		= producto.FichaTecnica.ID;
						items['Oferta']['FichaTecnica']['Nombre']	= producto.FichaTecnica.Nombre;
						items['Oferta']['FichaTecnica']['Descripcion']	= producto.FichaTecnica.Descripcion;
						items['Oferta']['FichaTecnica']['Url']		= producto.FichaTecnica.Fichero;
						items['Oferta']['FichaTecnica']['Fecha']	= producto.FichaTecnica.Fecha;
                    }

					items['Oferta']['RegSanitario']	= [];
					if(producto.RegSanitario.ID != ''){
						items['Oferta']['RegSanitario']['ID']		= producto.RegSanitario.ID;
						items['Oferta']['RegSanitario']['Nombre']	= producto.RegSanitario.Nombre;
						items['Oferta']['RegSanitario']['Descripcion']	= producto.RegSanitario.Descripcion;
						items['Oferta']['RegSanitario']['Url']		= producto.RegSanitario.Fichero;
						items['Oferta']['RegSanitario']['Fecha']	= producto.RegSanitario.Fecha;
                    }

					items['Oferta']['CertExperiencia']	= [];
					if(producto.CertExperiencia.ID != ''){
						items['Oferta']['CertExperiencia']['ID']		= producto.CertExperiencia.ID;
						items['Oferta']['CertExperiencia']['Nombre']	= producto.CertExperiencia.Nombre;
						items['Oferta']['CertExperiencia']['Descripcion']	= producto.CertExperiencia.Descripcion;
						items['Oferta']['CertExperiencia']['Url']		= producto.CertExperiencia.Fichero;
						items['Oferta']['CertExperiencia']['Fecha']	= producto.CertExperiencia.Fecha;
                    }

					items['Oferta']['Informada']	= producto.Informada;
					items['Oferta']['Adjudicada']	= producto.Adjudicada;
					items['Oferta']['CodRegistroSanitario']	= producto.RegistroSanitario;
					
					//solodebug
					debug('recuperaDatosOfertaProductos IDProv:'+LicProvID+' IDOfe:'+producto.IDOferta+' Oferta'+producto.PrecioOfe+'Color:'+producto.Color);

					arrProductos.push(items);
                });

				if(CheckCamposPublicar !== false){
					ofertaProvInformada = 'S';
				}
			}
			
			prepararTablaProductos(true);
    	  	validarBotonPublicarOferta();
		}
	});
}

//	12nov21 Muestra los campos para ver/subir/actualizar ficha tecnica (traido desde lic_121121.js)
function verFichas(ID){
	jQuery("#RS_" + ID).hide();
	jQuery("#CE_" + ID).hide();
	jQuery("#FS_" + ID).hide();
	if(document.getElementById('FT_' + ID).style.display == 'none'){
		jQuery("#FT_" + ID).show();
	}else{
		jQuery("#FT_" + ID).hide();
	}
}


//	5nov21 Muestra los campos para ver/subir/actualizar el registro sanitario
function verRegSanitario(ID){
	jQuery("#FT_" + ID).hide();
	jQuery("#CE_" + ID).hide();
	jQuery("#FS_" + ID).hide();
	if(document.getElementById('RS_' + ID).style.display == 'none'){
		jQuery("#RS_" + ID).show();
	}else{
		jQuery("#RS_" + ID).hide();
	}
}

//	5nov21 Muestra los campos para ver/subir/actualizar el certificado de experiencia
function verCertExperiencia(ID){
	jQuery("#FT_" + ID).hide();
	jQuery("#RS_" + ID).hide();
	jQuery("#FS_" + ID).hide();
	if(document.getElementById('CE_' + ID).style.display == 'none'){
		jQuery("#CE_" + ID).show();
	}else{
		jQuery("#CE_" + ID).hide();
	}
}

//	30ene23 Muestra los campos para ver/subir/actualizar la ficha de seguridad
function verFichaSeguridad(ID){
	jQuery("#FT_" + ID).hide();
	jQuery("#RS_" + ID).hide();
	jQuery("#CE_" + ID).hide();
	if(document.getElementById('FS_' + ID).style.display == 'none'){
		jQuery("#FS_" + ID).show();
	}else{
		jQuery("#FS_" + ID).hide();
	}
}


//	15nov21 Muestra la tabla con las opciones para subir un documento
function mostrarTablaDocOferta(Tipo, ID)
{
	jQuery("#tbl_"+Tipo+"_"+ID).show();
	jQuery("#a_"+Tipo+"_"+ID).hide();
}

//	12nov21 Muestra los campos para ver/subir/actualizar el registro sanitario (traido desde lic_121121.js)
//function dibujaSubirFT(Tipo, ID){
function dibujaSubirDocumento(Tipo, ID){
	var innerHTML, thisRow, thisCell;
	
	//solodebug debug('dibujaSubirDocumento. Tipo:'+Tipo+' ID:'+ID);
		
	var strJS="javascript:mostrarTablaDocOferta(\'"+Tipo+"\',"+ID+");";
	innerHTML = '<div class="w200px floatLeft"><a id="a_'+Tipo+'_'+ID+'" href="'+strJS+'" class="btnNormal">'+str_SubirDoc+'</a></div>';

	innerHTML += divStartClassID.replace('#ID#', 'cargaDoc'+Tipo);
	innerHTML = innerHTML.replace('#CLASS#', 'floatLeft cargaDoc'+Tipo);

	innerHTML += '<table id="tbl_'+Tipo+'_'+ID+'" class="infoTable" border="0" class="w1200px" style="display:none;">';
	thisRow = rowStart;

	thisCell = cellStartClass.replace('#CLASS#', 'labelRight trenta');
	thisCell += spanStartClass.replace('#CLASS#', 'text'+Tipo+'_' + ID);
	thisCell += str_SubirDoc+':&nbsp;';
	thisCell += spanEnd;
	thisCell += cellEnd;
	thisRow += thisCell;

	thisCell = cellStartClass.replace('#CLASS#', 'datosLeft trenta');
	thisCell += divStartClass.replace('#CLASS#', 'altaDocumento');
	thisCell += spanStartClass.replace('#CLASS#', 'anadirDoc');
	thisCell += divStartClassID.replace('#CLASS#', 'docLine').replace('#ID#', 'docLine_' + ID);
	thisCell += divStartClassID.replace('#CLASS#', 'docLongEspec').replace('#ID#', 'docLongEspec_' + ID);
	thisMacro = macroInputFile.replace('#NAME#', 'inputFileDoc');
	thisMacro = thisMacro.replace('#ID#', 'inputFileDoc_'+Tipo+'_' + ID);
	
	strJS="addDocFile(document.forms[\'ProductosProveedor\']," + ID + ");cargaDoc(document.forms[\'ProductosProveedor\'],\'"+Tipo+"\'," + ID + ");ActivarBotonGuardar("+ID+")";
	thisMacro = thisMacro.replace('#ONCHANGE#', strJS);
	thisCell += thisMacro;
	thisCell += divEnd;
	thisCell += divEnd;
	thisCell += spanEnd;
	thisCell += divEnd;
	thisCell += cellEnd;
	thisRow += thisCell;
	thisCell = cellStart;
	thisCell += divStartIDAlign.replace('#ID#', 'waitBoxDoc_'+Tipo+'_' + ID).replace('#ALIGN#', 'center');
	thisCell += '&nbsp;';
	thisCell += divEnd;
	thisCell += divStartIDStyAlg.replace('#ID#', 'confirmBox_'+Tipo+'_' + ID).replace('#STYLE#', 'display:none;').replace('#ALIGN#', 'center');
	thisCell += spanStartClassStyle.replace('#CLASS#', 'cargado').replace('#STYLE#', '');		//6abr23	.replace('#STYLE#', 'font-size:10px;');
	thisCell += '�' + str_DocCargado + '!';
	thisCell += spanEnd;
	thisCell += divEnd;
	thisCell += cellEnd;
	thisRow += thisCell;

	thisRow += rowEnd;
	innerHTML += thisRow;
	innerHTML += '</table>';

	innerHTML += divEnd;

	//solodebug debug('dibujaSubirDocumento. Tipo:'+Tipo+' ID:'+ID+' innerHTML:'+innerHTML);	

	return innerHTML;
}

//	7dic21 Muestra el documento seleccionado
function VerDocumentoOferta(tipo, Pos)
{
	var arrDocs, IDDoc;

	IDDoc=IDDocumentoSeleccionado(tipo, Pos);
	arrDocs=ArrayDocumentos(tipo);
			
	if (IDDoc!='-1')
	{
		var Pos = BuscaIDEnArray(arrDocs, IDDoc);
		
		if (Pos!=-1)
		{
			//solodebug debug('VerDocumentoOferta. Tipo:'+tipo+' Pos:'+Pos+' IDDoc:'+IDDoc+' AbrirDoc('+Pos+'):'+arrDocs[Pos].URL);	
			MostrarPagPersonalizada('http://www.newco.dev.br/Documentos/'+arrDocs[Pos].URL,10,90,90,10);
		}
	}	
	
}


//	7dic21 Al seleccionar un documento, ocultamos o mostramos el boton de "ver doc"
function DocumentoSeleccionado(tipo, Pos)
{
	var IDDoc=IDDocumentoSeleccionado(tipo, Pos);
	//solodebug	debug("DocumentoSeleccionado. tipo:"+tipo+" Pos:"+Pos+ "IDDoc:"+IDDoc);

	if (IDDoc==-1)
		jQuery("#verDoc"+tipo+"_"+Pos).hide();
	else
		jQuery("#verDoc"+tipo+"_"+Pos).show();

	ActivarBotonGuardar(Pos);
}


//	7dic21 Devuelve el ID de documento que corresponde al tipo de documentos y posicion de la oferta
function IDDocumentoSeleccionado(tipo, Pos)
{
	var IDDoc='-1';
	if (tipo=='FT')
	{
		IDDoc=jQuery('#IDFICHA_'+Pos).val();
	}
	else if (tipo=='RS')
	{
		IDDoc=jQuery('#IDREGSAN_'+Pos).val();
	}
	else if (tipo=='CE')
	{
		IDDoc=jQuery('#IDCERTEXP_'+Pos).val();
	}
	else if (tipo=='FS')
	{
		IDDoc=jQuery('#IDFICHASEG_'+Pos).val();
	}

	//solodebug	debug("IDDocumentoSeleccionado. tipo:"+tipo+" Pos:"+Pos+ "IDDoc:"+IDDoc);
		
	return IDDoc;
}


//	7dic21 Devuelve el array que corresponde al tipo de documentos
function ArrayDocumentos(tipo)
{
	var arrDocs;
	if (tipo=='FT')
	{
		arrDocs=arrFichasTecnicas;
	}
	else if (tipo=='RS')
	{
		arrDocs=arrRegSanitario;
	}
	else if (tipo=='CE')
	{
		arrDocs=arrCertExperiencia;
	}
	else if (tipo=='FS')
	{
		arrDocs=arrFichaSeguridad;
	}

	//solodebug	debug("ArrayDocumentos. tipo:"+tipo+" arrDocs:"+arrDocs.name+'('+arrDocs.length+')'+arrDocs[0].URL);

	return arrDocs;
}


//	7dic21 Busca un ID en un array
function BuscaIDEnArray(arrDocs, IDDoc)
{
	var Pos=-1;
	
	//solodebug debug('BuscaIDEnArray. IDDoc:'+IDDoc);	
	
	for(var k=0; (k<arrDocs.length) && (Pos==-1); k++)
	{
		//solodebug debug('VerDocumento. IDDoc:'+IDDoc+' Revisando '+k+':['+arrDocs[k].ID+']:'+arrDocs[k].URL);	

		if(IDDoc == arrDocs[k].ID)
		{

			//solodebug debug('VerDocumento. IDDoc:'+IDDoc+' Pos:'+Pos+' AbrirDoc('+k+'):'+arrDocs[k].URL);	
			
			Pos=k;
			
		}
	}
	return Pos;
}





//	23jun22 listado excel desde la matriz JS, sin peticion a la base de datos
function listadoExcelProv()
{
	var cadenaCSV='', thisRow='';

	//	Preparamos la cabecera para la licitacion
	cadenaCSV=strTitulosColumnasCSVProv;
	
	if ((IDPais == '57')&&(incluirRS=='S'))
		cadenaCSV+=StringtoCSV(str_RegistroSanitario)+StringtoCSV(str_CodExpediente)+StringtoCSV(str_CodCUM)+StringtoCSV(str_CodIUM)+StringtoCSV(str_FechaLimiteInvima)+StringtoCSV(str_ClasRiesgo);
	
	cadenaCSV+=saltoLineaCSV;

	debug('thislistadoExcelProv. Productos:'+arrProductos.length);

	if(arrProductos.length > 0)
	{

		for(var i=0; i<arrProductos.length; i++)
		{

			debug('listadoExcelProv: linea '+i);
		
			thisRow = StringtoCSV(arrProductos[ColumnaOrdenadaProds[i]].RefCliente)			// Ref.Cliente 
				+ StringtoCSV(arrProductos[ColumnaOrdenadaProds[i]].RefEstandar)			// Ref.Estandar
				+ StringtoCSV(arrProductos[ColumnaOrdenadaProds[i]].Nombre)					// Nombre
				+ StringtoCSV(arrProductos[ColumnaOrdenadaProds[i]].UdBasica)				// Unidad Basica
				+ StringtoCSV(arrProductos[ColumnaOrdenadaProds[i]].Oferta.Marca)			// Oferta:Marca
				+ StringtoCSV(arrProductos[ColumnaOrdenadaProds[i]].Oferta.UdsXLote)		// Oferta:UdsXLote
				+ StringtoCSV(arrProductos[ColumnaOrdenadaProds[i]].Oferta.Precio);			// Oferta:Precio
				
			if 	(arrProductos[ColumnaOrdenadaProds[i]].Oferta.Cantidad!='')
				thisRow += StringtoCSV(arrProductos[ColumnaOrdenadaProds[i]].Oferta.Cantidad);
			else
				thisRow += StringtoCSV(arrProductos[ColumnaOrdenadaProds[i]].Cantidad);				// 5abr22:Cantidad de producto, no de oferta

			if ((IDPais == '57')&&(incluirRS=='S'))
			{
				thisRow += StringtoCSV(arrProductos[ColumnaOrdenadaProds[i]].Oferta.CodRegistroSanitario)
						+StringtoCSV(arrProductos[ColumnaOrdenadaProds[i]].Oferta.CodExpediente)
						+StringtoCSV(arrProductos[ColumnaOrdenadaProds[i]].Oferta.CodCum)
						+StringtoCSV(arrProductos[ColumnaOrdenadaProds[i]].Oferta.CodIum)
						+StringtoCSV(arrProductos[ColumnaOrdenadaProds[i]].Oferta.FechaCadInvima)
						+StringtoCSV(arrProductos[ColumnaOrdenadaProds[i]].Oferta.ClasRiesgo);
			}
					
			debug('listadoExcelProv: thisRow('+i+'):'+thisRow);
			cadenaCSV += thisRow+saltoLineaCSV;

		}// fin bucle productos

    }
	
	//solodebug alert(cadenaCSV);
	
	//DescargaMIME(cadenaCSV, 'Licitacion.csv', 'text/csv;encoding:utf-8');		//	http://www.newco.dev.br/General/descargas_151117.js
	DescargaMIME(StringToISO(cadenaCSV), 'Licitacion.csv', 'text/csv');		//	http://www.newco.dev.br/General/descargas_151117.js
	
}


//	27abr23 Presenta el pop-up con la programacion de entregas
function EntregasProducto(Pos)
{
	var cadProv='';

	//	Si hay un anica oferta, incluimos la informacin del proveedor y marca seleccionados
	if (arrProductos[Pos].Oferta.UdsXLote!='')
	{
		cadProv='<label>'+strMarca+':&nbsp;</label>'+arrProductos[Pos].Oferta.Marca
					+'&nbsp;&nbsp;&nbsp;<label>'+strUdesLote+':&nbsp;</label>'+arrProductos[Pos].Oferta.UdsXLote;
	}

	//	alert('Provisional:'+arrProductos[Pos].Entregas);

	var strRef=(arrProductos[Pos].RefCliente=='')?arrProductos[Pos].RefMVM:arrProductos[Pos].RefCliente;
	var strProducto=cadProv+'&nbsp;&nbsp;&nbsp;<label>'+strCantidad+':&nbsp;</label>'+arrProductos[Pos].Cantidad+'&nbsp;'+arrProductos[Pos].UdBasica;

	//solodebug	
	debug("EntregasProducto:"+ strProducto);
	
	jQuery("#progEntrPosProd").val(Pos);
	jQuery("#progEntrTitulo").html('<label>'+str_ProgEntregas+'</label>:&nbsp('+strRef+')&nbsp'+arrProductos[Pos].Nombre);
	jQuery("#progEntrCant").html(strProducto);

	var Entregas=arrProductos[Pos].Entregas;

	//solodebug	debug("EntregasProducto:"+ Entregas);

	for (var i=0;i<PieceCount(Entregas,'#');++i)
	{
		var Entrega=Piece(Entregas,'#',i);
		
		//solodebug debug("EntregasProducto("+i+"):"+ Entrega);		
		if (Entrega!='')
		{
			jQuery("#dataEntr"+(i+1)).val(Piece(Entrega,'|',0));
			jQuery("#cantEntr"+(i+1)).val(Piece(Entrega,'|',1));
		}
	}

	showTablaByID("progEntregas");
}