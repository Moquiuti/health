//	Separamos librer�a con funciones que solo son utilizadas por los proveedores
//	Ultima revisi�n ET 21jun19 09:00


//	Publica el pedido m�nimo
function publicarPedidoMinimo(oForm){
	var IDProvLic		= oForm.elements['LIC_PROV_ID'].value;
	var PedidoMinimoProv	= oForm.elements['LIC_PROV_PEDIDOMINIMO'].value;
	var ComentariosProv	= encodeURIComponent(oForm.elements['LIC_PROV_COMENTARIOSPROV'].value.replace(/'/g, "''"));
	var Frete	= oForm.elements['LIC_PROV_FRETE'].value;
	var PlazoEntrega	= oForm.elements['LIC_PROV_PLAZOENTREGA'].value;

	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/PedidoMinimoProveedor.xsql',
		type:	"GET",
		data:	"LIC_PROV_ID="+IDProvLic+"&LIC_PROV_PEDIDOMINIMO="+encodeURIComponent(PedidoMinimoProv)+"&LIC_PROV_COMENTARIOSPROV="+encodeURIComponent(ComentariosProv)+"&LIC_PROV_FRETE="+Frete+"&LIC_PROV_PLAZOENTREGA="+PlazoEntrega+"&_="+d.getTime(),
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
				}
			}else{
				alert('ERROR');
			}
		}
	});
}

//	Publica la oferta del proveedor
function publicarOferta(oForm){
	var IDProvLic		= oForm.elements['LIC_PROV_ID'].value;
	var ComentariosProv	= encodeURIComponent(document.forms['PedidoMinimo'].elements['LIC_PROV_COMENTARIOSPROV'].value.replace(/'/g, "''"));
	var IDEstado		= oForm.elements['LIC_PROV_IDESTADO'].value;
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/CambiarEstadoProveedor.xsql',
		type:	"GET",
		data:	"LIC_PROV_ID="+IDProvLic+"&IDESTADO="+IDEstado+"&COMENTARIOS="+encodeURIComponent(ComentariosProv)+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

                        //alert('data nuevo estado '+data.NuevoEstado.estado);
                        //alert(navigator.appName);
                        //alert(navigator.userAgent);
			if(data.NuevoEstado.estado == 'OK'){
                                //quitado 23-11-15 en explorer no funciona bien mc
				/*if (window.opener !== null && !window.opener.closed){
					opener.location.reload();	// Recarga de la pagina padre para actualizar el estado de la licitacion
				}*/

				alert(alrt_publicarOfertaOK);
				location.href = "http://www.newco.dev.br/Gestion/Comercial/MantLicitacion.xsql?LIC_ID=" + IDLicitacion;
			}else{
				alert(alrt_NuevoEstadoProveedorKO);
			}
		}
	});
}


//	A�ade una oferta a la licitaci�n
function AnadirOfertas(oForm){
	var IDLicProv	= oForm.elements['LIC_PROV_ID'].value;		// LIC_PROV_ID
	var thisRowID, thisPosArr, IDLicProd, IDFicha, listaOfertas= '';
	var refProv;
	var d = new Date();

	// Construimos el string listaOfertas con los datos de cada producto
	var len = jQuery('table#lProductos_PROVE tbody tr.infoProds').length;
	jQuery('table#lProductos_PROVE tbody tr.infoProds').each(function(index, element){
		thisRowID	= this.id;
		thisPosArr	= thisRowID.replace('posArr_', '');
		IDLicProd	= arrProductos[thisPosArr].IDProdLic;

		if(jQuery("#IDFICHA_" + thisPosArr).val() > 0){
			IDFicha = jQuery("#IDFICHA_" + thisPosArr).val();
		}else{
			IDFicha = '';
		}

		refProv = (jQuery('#RefProv_' + thisPosArr).length) ? jQuery('#RefProv_' + thisPosArr).val() : '' ;

		listaOfertas += IDLicProd + '|' +					//p_IDProductoLic,
			refProv + '|' +							//p_Referencia,
			jQuery('#Desc_' + thisPosArr).val() + '|' +			//p_Descripcion,
			jQuery('#Marca_' + thisPosArr).val() + '|' +			//p_Marca,
			jQuery('#UdsLote_' + thisPosArr).val() + '|' +			//p_UnidadesPorLote,
			arrProductos[thisPosArr].Cantidad + '|' +	//p_Cantidad,
			jQuery('#Precio_' + thisPosArr).val() + '|' +			//p_Precio,
			arrProductos[thisPosArr].TipoIVA + '|' +	//p_TipoIva
			IDFicha;

		if(index != len - 1){
			listaOfertas += '#';
		}
	});

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/AnadirOfertasAJAX.xsql',
		type:	"POST",
		data:	"LIC_ID="+IDLicitacion+"&LIC_PROV_ID="+IDLicProv+"&LISTA_OFERTAS="+encodeURIComponent(listaOfertas)+"&_="+d.getTime(),
		beforeSend: function(){
			jQuery("#BtnActualizarOfertas").hide();
			jQuery("#MensActualizarOfertas").hide();
			jQuery("#LoadActualizarOfertas").show();
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			jQuery("#LoadActualizarOfertas").hide();

			if(data.NuevasOfertas.estado == 'OK'){
				recuperaDatosOfertaProductos(IDLicProv);
				jQuery("#MensActualizarOfertas").show();
			}else{
				alert(alrt_errorNuevasOfertas);
			}
			jQuery("#BtnActualizarOfertas").show();
		}
	});
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
			if(!isNaN(valAux)){	// Asumimos que no hay oferta
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

			// Celda/Columna Precio Objetivo
			thisCell = cellStart;
			thisCell += arrProductos[ColumnaOrdenadaProds[i]].PrecioObj;
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Precio Oferta
			thisCell = cellStart;
			thisCell += arrProductos[ColumnaOrdenadaProds[i]].Oferta.Precio;
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Consumo
			thisCell = cellStart;
			thisCell += arrProductos[ColumnaOrdenadaProds[i]].Oferta.Consumo;
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Consumo
			thisCell = cellStart;
			if(IDPais == '34'){
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].TipoIVA + '%';
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

	if(totalProductos > 0){
		// Numero de registros para mostrar en la tabla
		numProductos	= parseInt(jQuery('#numRegistros').val());			//	Desplegable de paginaci�n
		// Redondeamos para saber el numero de paginas totales
		pagsProdTotal = Math.ceil(totalProductos / numProductos);
		// Calculamos el producto inicial y final que se tienen que mostrar en la tabla
		firstProduct	= pagProductos * numProductos;
		lastProduct	= (totalProductos < (pagProductos * numProductos) + numProductos) ? totalProductos : ((pagProductos * numProductos) + numProductos) ;
		
		//solodebug	console.log('dibujaTablaProductosPROVE firstProduct:'+firstProduct+' lastProduct:'+lastProduct+' numProductos:'+numProductos+' pagsProdTotal:'+pagsProdTotal+' totalProductos:'+totalProductos);

		// Correccion en la paginacion en caso particular
		if(firstProduct >= lastProduct){
			pagProductos = pagsProdTotal - 1;
			firstProduct = pagProductos * numProductos;
		}
		
		//solodebug	console.log('dibujaTablaProductosPROVE firstProduct:'+firstProduct+' lastProduct:'+lastProduct+' numProductos:'+numProductos+' pagsProdTotal:'+pagsProdTotal+' totalProductos:'+totalProductos);

		for(var i=firstProduct; i<lastProduct; i++)
		{
			contLinea++;
			thisRow=PreparaLineaProducto(i, contLinea);
			htmlTBODY += thisRow;
		}
		calcularPaginacion();
	}
	jQuery('#lProductos_PROVE tbody').empty().append(htmlTBODY);

	// Ahora recalculamos los valores del floatinBox
	if(jQuery(".FBox").length)
		MostrarFloatingBox_PROV();
		
		
	//solodebug	MuestraMatrizOfertas();		//21mar19
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
		if (arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Informada=='S')	//	22mar19 Fondo rojo para productos sin oferta
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
		thisCell = thisCell.replace('#STYLE#','padding:2px 0px 2px 4px;');
	//			thisCell += '<strong>' + arrProductos[ColumnaOrdenadaProds[numProd]].Nombre + '</strong>&nbsp;';
		thisCell += '<strong>' + NombreProductoConEstilo(numProd) + '</strong>&nbsp;';
		thisCell += cellEnd;
		thisRow += thisCell;

		// Celda/Columna icono anyadir campos avanzados + iconos campos avanzados oferta informados
		thisCell = cellStart;
		valAux = parseFloat(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.UdsXLote.replace(".","").replace(",",".")); //arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.UdsXLote;
		if(!isNaN(valAux)){	// Asumimos que no hay oferta
			functionJS = 'javascript:abrirCamposAvanzadosOfe(' + (Indice) + ');'
			thisCell += '&nbsp;' + macroEnlace.replace('#HREF#', functionJS);
			thisCell += macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/anadir.gif').replace('#TITLE#', str_AnyadirInfoAmpliada).replace('#ALT#', str_AnyadirInfoAmpliada);
			thisCell += macroEnlaceEnd;
		}

		// Info.Ampliada
		if(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.InfoAmpliada != ''){
			thisMacro = '&nbsp;' + divStartClass;
			thisMacro = thisMacro.replace('#CLASS#', 'tooltip');
			thisCell += thisMacro;
			thisCell += '<img src="http://www.newco.dev.br/images/infoAmpliadaIconO.gif" class="static"/>';
			thisCell += spanStartClass.replace('#CLASS#', 'tooltiptext');
			thisCell += str_InfoAmpliada + ':<br/><br/>';
			thisCell += arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.InfoAmpliada;
			thisCell += spanEnd;
			thisCell += macroEnlaceEnd;
		}
		// Documento
		if(typeof arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Documento.ID !== 'undefined'){
			thisMacro = '&nbsp;' + macroEnlaceTarget.replace('#HREF#', 'http://www.newco.dev.br/Documentos/' + arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Documento.Url);
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
			thisMacro = macroInputTextonKeyUp.replace('#NAME#', 'RefProv_' + (Indice));
			thisMacro = thisMacro.replace('#ID#', 'RefProv_' + (Indice));
			thisMacro = thisMacro.replace('#CLASS#', 'refProv medio');
			thisMacro = thisMacro.replace('#SIZE#', '10');
			thisMacro = thisMacro.replace('#MAXLENGTH#', '15');
			thisMacro = thisMacro.replace('#ONKEYUP#', 'javascript:ActivarBotonGuardar('+(Indice)+');');
			if(isLicPorProducto == 'S'){
				if(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.RefProv != ''){
					thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.RefProv);
				}else{
					//25mar19	thisMacro = thisMacro.replace('#VALUE#', str_SinOfertar);
					thisMacro = thisMacro.replace('#VALUE#', '');
				}
			}else{
				thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.RefProv);
			}
			thisCell += thisMacro;
		}
		thisCell += cellEnd;
		thisRow += thisCell;

		// Celda/Columna Descripcion
		thisCell = cellStart;
		thisMacro = macroInputTextonKeyUp.replace('#NAME#', 'Desc_' + (Indice));
		thisMacro = thisMacro.replace('#ID#', 'Desc_' + (Indice));
		thisMacro = thisMacro.replace('#CLASS#', 'descripcion');
		thisMacro = thisMacro.replace('#SIZE#', '25');
		thisMacro = thisMacro.replace('#MAXLENGTH#', '100');
		thisMacro = thisMacro.replace('#ONKEYUP#', 'javascript:ActivarBotonGuardar('+(Indice)+');');
		if(isLicPorProducto == 'S'){
			if(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Nombre != '' || (arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Precio != '0,0000' && arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Precio != '')){
				thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Nombre);
			}else{
				//25mar19	thisMacro = thisMacro.replace('#VALUE#', str_SinOfertar);
				thisMacro = thisMacro.replace('#VALUE#', '');
			}
		}else{
			thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Nombre);
		}
		thisCell += thisMacro;
		thisCell += cellEnd;
		thisRow += thisCell;

		// Celda/Columna Marca
		thisCell = cellStart;
		
		if ((arrProductos[ColumnaOrdenadaProds[numProd]].Marcas=='')||(DesplegableMarcas=='N'))	//	Desplegable de marcas si array informado Y este cliente trabaja con desplegable
		{
			thisMacro = macroInputTextonKeyUp.replace('#NAME#', 'Marca_' + (Indice));
			thisMacro = thisMacro.replace('#ID#', 'Marca_' + (Indice));
			thisMacro = thisMacro.replace('#CLASS#', 'marca medio');
			thisMacro = thisMacro.replace('#SIZE#', '10');
			thisMacro = thisMacro.replace('#MAXLENGTH#', '100');
			thisMacro = thisMacro.replace('#ONKEYUP#', 'javascript:ActivarBotonGuardar('+(Indice)+');');
			if(isLicPorProducto == 'S'){
				if(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Marca != '' || (arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Precio != '0,0000' && arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Precio != '')){
					thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Marca);
				}else{
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
			
			for (i=0;i<=PieceCount(ListaMarcas,',');++i)
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
		thisCell = cellStart;
		thisCell += arrProductos[ColumnaOrdenadaProds[numProd]].Cantidad;
		thisCell += cellEnd;
		thisRow += thisCell;

		// Celda/Columna Precio Objetivo
		thisCell = cellStartClass.replace('#CLASS#', 'precioObj');
		thisCell += arrProductos[ColumnaOrdenadaProds[numProd]].PrecioObj;
		thisCell += cellEnd;
		thisRow += thisCell;

		// Celda/Columna Consumo
		thisCell = cellStart;
		thisCell += arrProductos[ColumnaOrdenadaProds[numProd]].Consumo;
		thisCell += cellEnd;
		thisRow += thisCell;

		// Celda/Columna UdsXLote
		thisCell = cellStart;
		thisMacro = macroInputTextonKeyUp.replace('#NAME#', 'UdsLote_' + (Indice));
		thisMacro = thisMacro.replace('#ID#', 'UdsLote_' + (Indice));
		thisMacro = thisMacro.replace('#CLASS#', 'unidades peq');
		thisMacro = thisMacro.replace('#SIZE#', '6');
		thisMacro = thisMacro.replace('#MAXLENGTH#', '15');
		thisMacro = thisMacro.replace('#ONKEYUP#', 'javascript:ActivarBotonGuardar('+(Indice)+');');
		if(isLicPorProducto == 'S'){
			if(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.UdsXLote != ''){
				thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.UdsXLote);
			}else{
				thisMacro = thisMacro.replace('#VALUE#', '0');
			}
		}else{
			thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.UdsXLote);
		}
		thisCell += thisMacro;
		thisCell += cellEnd;
		thisRow += thisCell;

		// Celda/Columna Precio
		thisCell = cellStart;
		thisMacro = macroInputTextonKeyUp.replace('#NAME#', 'Precio_' + (Indice));
		thisMacro = thisMacro.replace('#ID#', 'Precio_' + (Indice));
		thisMacro = thisMacro.replace('#CLASS#', 'precio medio');
		thisMacro = thisMacro.replace('#SIZE#', '8');
		thisMacro = thisMacro.replace('#MAXLENGTH#', '8');
		thisMacro = thisMacro.replace('#ONKEYUP#', 'javascript:ActivarBotonGuardar('+(Indice)+');');
		if(isLicPorProducto == 'S'){
			if(arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Precio != ''){
				thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Precio);
			}else{
				thisMacro = thisMacro.replace('#VALUE#', '0');
			}
		}else{
			thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[numProd]].Oferta.Precio);
		}
		thisCell += thisMacro;
		thisCell += cellEnd;
		thisRow += thisCell;

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
		thisCell 	= cellStartClass.replace('#CLASS#', 'acciones');

		thisMacro	= macroEnlaceAccIDStyle.replace('#CLASS#', 'guardarOferta btnDestacado');
		thisMacro	= thisMacro.replace('#ID#', 'btnGuardar_'+ (Indice));
		functionJS	= "javascript:guardarOfertaFila('" + (Indice) +"','')";
		thisMacro	= thisMacro.replace('#STYLE#', 'display:none;');	//	17set16	botones ocultos
		thisMacro	= thisMacro.replace('#HREF#', functionJS);
		thisMacro	+= str_Guardar;
		thisCell	+= thisMacro;
		thisCell	+= macroEnlaceEnd;

		thisMacro	= macroEnlaceAccIDStyle.replace('#CLASS#', 'guardarOferta btnDestacado');
		thisMacro	= thisMacro.replace('#ID#', 'btnAlter_'+ (Indice));
		functionJS	= "javascript:guardarOfertaFila('" + (Indice) + "','ALTER')";
		thisMacro	= thisMacro.replace('#STYLE#', 'display:none;');	//	17set16	botones ocultos
		thisMacro	= thisMacro.replace('#HREF#', functionJS);

		thisCell	+= thisMacro;
		thisCell	+= str_Alternativa;
		thisCell	+= macroEnlaceEnd;
		//thisCell += '<a href="javascript:guardarOfertaFila(' + (Indice) + ');" class="guardarOferta">Guardar</a>';
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
		thisCell += divStartStyle.replace('#STYLE#', 'float:left;line-height:30px;height:30px;vertical-align:middle;');
		thisMacro = macroSelect.replace('#NAME#', 'IDFICHA_' + (Indice));
		thisMacro = thisMacro.replace('#ID#', 'IDFICHA_' + (Indice));
		thisMacro = thisMacro.replace('#CLASS#', 'IDFicha select200');
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
		thisCell += dibujaSubirFT((Indice));
		thisCell += cellEnd;
		thisRow += thisCell;

		thisRow += rowEnd;
		thisRow += '<p id="COMPLETAR_"'+numProd+'"/>' ;	// Marca para facilitar insertar nuevas filas
	}
	catch(err)
	{	
		console.log('PreparaLineaProducto ('+numProd+','+ contLinea+'). error:'+err);
	}

	return thisRow;
}


//	Activa el bot�n de guardar oferta
function ActivarBotonGuardar(NumeroLinea)
{
	//solodebug	console.log('ActivarBotonGuardar:'+NumeroLinea);
	
	jQuery('#AVISOACCION_'+NumeroLinea).html('');
	jQuery('#btnGuardar_'+NumeroLinea).show();
	
	//	Quitamos el texto "Sin ofertar", las unidades popr lote y el precio 0
	//if (jQuery('#RefProv_'+NumeroLinea).val()==str_SinOfertar) jQuery('#RefProv_'+NumeroLinea).val('');
	//if (jQuery('#Desc_'+NumeroLinea).val()==str_SinOfertar) jQuery('#Desc_'+NumeroLinea).val('');
	//if (jQuery('#Marca_'+NumeroLinea).val()==str_SinOfertar) jQuery('#Marca_'+NumeroLinea).val('');
	if (jQuery('#UdsLote_'+NumeroLinea).val()=='0') jQuery('#UdsLote_'+NumeroLinea).val('');
	if (jQuery('#Precio_'+NumeroLinea).val()=='0,000') jQuery('#Precio_'+NumeroLinea).val('');
	
	
	if (AlternativasInformadas(jQuery('#IDPRODLIC_'+NumeroLinea).val())>0)	
		jQuery('#btnAlter_'+NumeroLinea).show();

	//solodebug	console.log('ActivarBotonGuardar:'+NumeroLinea+ 'IDPRODLIC:'+jQuery('#IDPRODLIC_'+NumeroLinea).val()+' Alternativas:'+AlternativasInformadas(jQuery('#IDPRODLIC_'+NumeroLinea).val()));
}


//	18mar19 Comprueba si existena alternativas informadas para este producto
function AlternativasInformadas(IDProdLic)
{
	var informadas=0;
	
	//	Recorre todo el array de productos por si hay alguna oferta informada para este producto
	for (i=0;i<arrProductos.length;++i)
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
	for (i=0;i<arrProductos.length;++i)
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


//	Funcion para guardar los datos de una oferta del proveedor para una fila en concreto
//	11mar19	Permite guardar alternativas
function guardarOfertaFila(thisPosArr, tipo)
{
	//var Indice=RecuperaPosicion(thisPosArr);
	
	Indice=thisPosArr;

	//solodebug	console.log("guardarOfertaFila. thisPosArr:"+thisPosArr+' RecuperaPosicion:'+RecuperaPosicion(thisPosArr)+ ' Indice:'+Indice+" tipo:"+tipo);

	// Validaciones
	var oForm = document.forms['ProductosProveedor'];
    var IDProdLic   = arrProductos[Indice].IDProdLic;    	//13mar19
    var ProdNombre1 = arrProductos[Indice].Nombre;    		//7abr18
	var RefCliente	= (arrProductos[Indice].RefCliente != '') ? arrProductos[Indice].RefCliente : arrProductos[Indice].RefEstandar;
	var precioObj	= arrProductos[Indice].PrecioObj;
	var precioObjFormat	= parseFloat(precioObj.replace(/\./g,'').replace(',', '.'));
	var enviarOferta = false;
	var controlPrecio = '';
	var errores = 0;
	var Alternativa;
	
	if (tipo=='ALTER')
	{
		//	Busca la mayor alternativa para este producto
		Alternativa=0;
		for (i=0;i<arrProductos.length;++i)
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
		var Alternativa=oForm.elements['ALTERNATIVA_' + thisPosArr].value;
	}

	//solodebug
	console.log("guardarOfertaFila. thisPosArr:"+thisPosArr+" IDProdLic:"+IDProdLic+'???'+jQuery('#IDPRODLIC_' + thisPosArr).val()+" RefCliente:"+RefCliente
		+ " marca:"+oForm.elements['Marca_' + thisPosArr].value
		+" tipo:"+tipo+ " alternativa:"+Alternativa+' Precio min:'+arrProductos[Indice].PrecioMin+' PrecioMax:'+arrProductos[Indice].PrecioMax);

	// Validacion Precio
	var precio		= jQuery('#Precio_' + thisPosArr).val()
	var precioFormat= precio.replace(",",".");
	if(!errores && esNulo(precioFormat))
	{
		errores++;
		alert(val_faltaPrecio.replace("[[REF]]",RefCliente));
		oForm.elements['Precio_' + thisPosArr].focus();
		return false;
	}
	else if(!errores && isNaN(precioFormat))
	{
		errores++;
		alert(val_malPrecio.replace("[[REF]]",RefCliente));
		oForm.elements['Precio_' + thisPosArr].focus();
	}
	else if(!errores && precioFormat != 0)
	{
		// Validacion de precio para Espa�a
		//	9abr18	if(IDPais != '55' && precioFormat > (precioObjFormat*2)){
		//	9abr18		controlPrecio += val_elPrecioProd +" "+ precio +" "+ val_precioProd.replace("[[REF]]",RefCliente)+" "+ val_doblePrecio +" "+ precioObj +" "+ "\n";
		//	9abr18		controlPrecio +=val_PrecioFueraRango
		//	9abr18	}

		if	((arrProductos[Indice].PrecioMin!='' && precioFormat < parseFloat(arrProductos[Indice].PrecioMin.replace(/\./g,"").replace(',', '.')))||(arrProductos[Indice].PrecioMax!='' && precioFormat > parseFloat(arrProductos[Indice].PrecioMax.replace(/\./g,"").replace(',', '.'))))
		{
			controlPrecio +=val_PrecioFueraRango.replace("[[REF]]",RefCliente).replace("[[PRECIO]]",precio).replace("[[UDBASICA]]",arrProductos[Indice].UdBasica).replace("[[MIN]]",arrProductos[Indice].PrecioMin).replace("[[MAX]]",arrProductos[Indice].PrecioMax)
		}

		//	6jul16	Campo marca obligatorio
		if (!errores && (esNulo(oForm.elements['Marca_' + thisPosArr].value) || (oForm.elements['Marca_' + thisPosArr].value=='SIN OFERTAR'))){
			errores++;
			alert(val_marcaObligatoria.replace("[[REF]]",RefCliente));
		}
	}

	if(!errores && precioFormat != 0){
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
	//UdsXLoteFormat	= UdsXLote.replace(",","."); DC - 23feb16 - Las unidades por lote en formato n�mero entero

	//if(!errores && esNulo(UdsXLoteFormat)){ DC - 23feb16 - Las unidades por lote en formato n�mero entero
	if(!errores && esNulo(UdsXLote)){
		errores++;
		alert(val_faltaUnidades.replace("[[REF]]",RefCliente));
		oForm.elements['UdsLote_' + thisPosArr].focus();
	//}else if(!errores && isNaN(UdsXLoteFormat)){ DC - 23feb16 - Las unidades por lote en formato n�mero entero
	}
	else if(!errores && !esEntero(UdsXLote))
	{
		errores++;
		//alert(val_malUnidades.replace("[[REF]]",RefCliente));
		alert(val_malEnteroUnidades.replace("[[REF]]",RefCliente));
		oForm.elements['UdsLote_' + thisPosArr].focus();
	//}else if(!errores && UdsXLoteFormat == 0 && precioFormat != 0){ DC - 23feb16 - Las unidades por lote en formato n�mero entero
	}
	else if(!errores && UdsXLote == 0 && precioFormat != 0)
	{
		errores++;
		alert(val_notZeroUnidades.replace("[[REF]]",RefCliente));
		oForm.elements['UdsLote_' + thisPosArr].focus();
	}

/* DC - 23feb16 - Las unidades por lote en formato n�mero entero
	if(!errores && UdsXLoteFormat != 0){
		valAux	= (UdsXLoteFormat != '') ? String(parseFloat(UdsXLoteFormat).toFixed(2)).replace(".",",") : '';
		jQuery('#UdsLote_' + thisPosArr).val( valAux );
	}
*/

	if(IDPais != 55){
		// Validacion Ref.Proveedor
		valAux	= jQuery('#RefProv_' + thisPosArr).val();
		//if(!errores && esNulo(valAux) && (precioFormat != 0 || UdsXLoteFormat != 0)){ DC - 23feb16 - Las unidades por lote en formato n�mero entero
		if(!errores && esNulo(valAux) && (precioFormat != 0 || UdsXLote != 0))
		{
			errores++;
			alert(val_faltaRefProv.replace("[[REF]]",RefCliente));
			oForm.elements['RefProv_' + thisPosArr].focus();
		//}else if(!errores && UdsXLoteFormat != 0){ DC - 23feb16 - Las unidades por lote en formato n�mero entero
		}
		else if(!errores && UdsXLote != 0)
		{
			// Comprobamos que no hayan escrito 2 Ref.Prov. iguales en la tabla
			/*
			jQuery("#lProductos_PROVE > tbody > tr.infoProds").each(function(){
				thisRowID2	= this.id;
				thisPosArr2	= thisRowID2.replace('posArr_', '');
				
				try
				{
					RefCliente2	= (arrProductos[thisPosArr2].RefCliente != '') ? arrProductos[thisPosArr2].RefCliente : arrProductos[thisPosArr2].RefEstandar;
					ProdNombre2	= arrProductos[thisPosArr2].Nombre;

					valAux2		= jQuery('#RefProv_' + thisPosArr2).val();
					if(thisPosArr != thisPosArr2 && valAux.toUpperCase() == valAux2.toUpperCase()){
						errores++;
						alert(val_igualesRefProv.replace("[[REFPROV]]", valAux).replace('[[PRODNOMBRE1]]', ProdNombre1).replace('[[PRODNOMBRE2]]', ProdNombre2));
						oForm.elements['RefProv_' + thisPosArr2].focus();
					}
				}
				catch(err)
				{
					//solodebug
					console.log("Error comprobando fila "+thisPosArr2+". err:"+err);
				}
			});
			*/
			
			//
			//	CUIDADO! EN DESARROLLO!!!!!!!!
			//
			for (i=0;i<arrProductos.length;++i)
			{
				//	Comprueba que no se haya utilizado ya la misma referencia de proveedor
				if((thisPosArr != i) && (arrProductos[i].Oferta.Informado == 'S') && (arrProductos[Indice].RefProv ==arrProductos[i].RefProv))
				{
					//	
					errores++;
					alert(val_igualesRefProv.replace("[[REFPROV]]", arrProductos[Indice].RefProv).replace('[[PRODNOMBRE1]]', arrProductos[Indice].Nombre).replace('[[PRODNOMBRE2]]', arrProductos[i].Nombre));
					oForm.elements['RefProv_' + thisPosArr].focus();
				}
			}
			
			
			

			// Tambien comprobamos que no exista previamente una Ref.Prov en el array de ofertas
			jQuery.each(arrProductos, function(key, producto){
				if(!errores && key != thisPosArr && producto.Oferta.RefProv.toUpperCase() == valAux.toUpperCase()){
					ProdNombre2 = producto.Nombre;
					errores++;
					alert(val_igualesRefProv.replace("[[REFPROV]]", valAux).replace('[[PRODNOMBRE1]]', ProdNombre1).replace('[[PRODNOMBRE2]]', ProdNombre2));
					oForm.elements['RefProv_' + thisPosArr].focus();
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
		var IDFicha = '';
		if(jQuery("#IDFICHA_" + thisPosArr).val() > 0){
			IDFicha = jQuery("#IDFICHA_" + thisPosArr).val();
		}
		var RefProv = (jQuery('#RefProv_' + thisPosArr).length) ? jQuery('#RefProv_' + thisPosArr).val() : '' ;
		var Descripcion = jQuery('#Desc_' + thisPosArr).val();
		var Marca = jQuery('#Marca_' + thisPosArr).val();
		var UdsXLote = jQuery('#UdsLote_' + thisPosArr).val();
		var Precio = jQuery('#Precio_' + thisPosArr).val();
		var Cantidad = arrProductos[Indice].Cantidad;
		var TipoIVA = arrProductos[Indice].TipoIVA;
		var d = new Date();
		
		
		//solodebug
		
		console.log("AnadirUnaOfertaAJAX. thisPosArr:"+thisPosArr+" LIC_ID:"+IDLicitacion+"&LIC_PROD_ID:"+IDLicProd+"&LIC_PROV_ID:"+IDLicProv+"&REFPROV:"+encodeURIComponent(ScapeHTMLString(RefProv))+"&DESC:"+encodeURIComponent(ScapeHTMLString(Descripcion))+"&MARCA:"
					+encodeURIComponent(ScapeHTMLString(Marca))+"&UDSXLOTE:"+UdsXLote+"&CANTIDAD:"+Cantidad+"&PRECIO:"+Precio+"&TIPOIVA:"+TipoIVA+"&IDFICHA:"+IDFicha
					+"&ALTERNATIVA:"+Alternativa);
		

		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/AnadirUnaOfertaAJAX.xsql',
			type:	"GET",
			data:	"LIC_ID="+IDLicitacion+"&LIC_PROD_ID="+IDLicProd+"&LIC_PROV_ID="+IDLicProv+"&REFPROV="+encodeURIComponent(ScapeHTMLString(RefProv))+"&DESC="+encodeURIComponent(ScapeHTMLString(Descripcion))+"&MARCA="
					+encodeURIComponent(ScapeHTMLString(Marca))+"&UDSXLOTE="+UdsXLote+"&CANTIDAD="+Cantidad+"&PRECIO="+Precio+"&TIPOIVA="+TipoIVA+"&IDFICHA="+IDFicha
					//ESTADOEVALUACION
					+"&ALTERNATIVA="+Alternativa	
					+"&_="+d.getTime(),
			beforeSend: function(){
				//17set16	jQuery("#BtnActualizarOfertas").hide();
				//17set16	jQuery(".guardarOferta").hide();
				jQuery('#btnGuardar_'+thisPosArr).hide();
				jQuery('#btnAlter_'+thisPosArr).hide();
			},
			error: function(objeto, quepaso, otroobj){
				//17set16	jQuery('tr#posArr_' + thisPosArr + ' .resultado').html('<img src="http://www.newco.dev.br/images/error.gif"/>');
				jQuery('#AVISOACCION_'+thisPosArr).html('<img src="http://www.newco.dev.br/images/error.gif"/>');
				alert('error'+quepaso+' '+otroobj+' '+objeto);
			},
			success: function(objeto){
				var data = eval("(" + objeto + ")");

				if(data.OfertaActualizada.IDOferta > 0){

					//17set16	jQuery('tr#posArr_' + thisPosArr + ' .resultado').html('<img src="http://www.newco.dev.br/images/recibido.gif"/>');
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

						// Campos Avanzados oferta
						items['Oferta']['InfoAmpliada']	= '';
						items['Oferta']['Documento']	= [];
						items['Oferta']['Informada']	= 'S';
						items['Oferta']['Adjudicada']	= 'N';
						items['Oferta']['NoOfertada']	= 'N';
						items['Oferta']['NoInformada']	= 'N';
						items['Oferta']['FichaTecnica']	= [];
						/*

							PENDIENTE


						items['Oferta']['Documento']	= [];
						<xsl:if test="DOCUMENTOOFERTA">
							items['Oferta']['Documento']['ID']		= '<xsl:value-of select="DOCUMENTOOFERTA/ID"/>';
							items['Oferta']['Documento']['Nombre']		= '<xsl:value-of select="DOCUMENTOOFERTA/NOMBRE"/>';
							items['Oferta']['Documento']['Descripcion']	= '<xsl:value-of select="DOCUMENTOOFERTA/DESCRIPCION"/>';
							items['Oferta']['Documento']['Url']		= '<xsl:value-of select="DOCUMENTOOFERTA/URL"/>';
							items['Oferta']['Documento']['Fecha']		= '<xsl:value-of select="DOCUMENTOOFERTA/FECHA"/>';
						</xsl:if>
						<!-- FIN Campos Avanzados oferta -->

						items['Oferta']['FichaTecnica']	= [];
						<xsl:if test="FICHA_TECNICA/ID">
							items['Oferta']['FichaTecnica']['ID']		= '<xsl:value-of select="FICHA_TECNICA/ID"/>';
							items['Oferta']['FichaTecnica']['Nombre']	= '<xsl:value-of select="FICHA_TECNICA/NOMBRE"/>';
							items['Oferta']['FichaTecnica']['Descripcion']	= '<xsl:value-of select="FICHA_TECNICA/DESCRIPCION"/>';
							items['Oferta']['FichaTecnica']['Url']		= '<xsl:value-of select="FICHA_TECNICA/URL"/>';
							items['Oferta']['FichaTecnica']['Fecha']	= '<xsl:value-of select="FICHA_TECNICA/FECHA"/>';
						</xsl:if>
						*/

						arrProductos.push(items);						
						ColumnaOrdenadaProds[totalProductos]=totalProductos;		//	13mar19	Creamos la entrada en el array de ordenaci�n
						++totalProductos;

						//para pruebas	ColumnaOrdenadaProds[totalProductos]=totalProductos;		//	13mar19	Creamos la entrada en el array de ordenaci�n
						//solodebug		console.log("guardarOfertaFila. thisPosArr:"+thisPosArr+" tipo:"+tipo+' arrProductos.length:'+arrProductos.length+' totalProductos:'+totalProductos);


						//solodebug	console.log("guardarOfertaFila. thisPosArr:"+thisPosArr+" tipo:"+tipo+' arrProductos.length:'+arrProductos.length+' totalProductos:'+totalProductos+' INSERTADO EN ARRAY.');
						//solodebug	MuestraMatrizOfertas();

						//	Ordena (y redibuja la tabla de productos)
						//Solodebug	console.log("guardarOfertaFila. thisPosArr:"+thisPosArr+" tipo:"+tipo+' arrProductos.length:'+arrProductos.length+' totalProductos:'+totalProductos+'. OrdenarProdsPorColumna (Ordena y dibuja)');

						OrdenarProdsPorColumna(ColumnaOrdenacionProds, true);

						//solodebug	console.log("guardarOfertaFila. thisPosArr:"+thisPosArr+" tipo:"+tipo+' arrProductos.length:'+arrProductos.length+' totalProductos:'+totalProductos+' TRAS ORDENAR Y DIBUJAR.');
						//solodebug	MuestraMatrizOfertas();

						ofertaVacia ='N';
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
						
						//	22mar19 QUitamos el fondo rojo en caso de que lo tuviera
						jQuery('#posArr_'+thisPosArr).attr('class','infoProds');
						
						
						//solodebug	MuestraMatrizOfertas();

						//	Redibuja la tabla de productos
						//	dibujaTablaProductosPROVE();

					}

					ofertaVacia ='N';
					ofertaProvInformada = 'S';

					validarBotonPublicarOferta();
					MostrarFloatingBox_PROV();			//	Actualizar la ventana de resumen

				}
				else
				{
					jQuery('#AVISOACCION_'+thisPosArr).html('<img src="http://www.newco.dev.br/images/error.gif"/>');
					
					if (data.OfertaActualizada.IDOferta==-2)	//	Si se ha superado el plazo, recargamos la p�gina para que se vea como ha quedado la oferta
						location.reload();
					
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


//	Actualiza las ofertas desde Areatext. Formato: Ref Nombre Marca Udes/lote Precio (separadores v�lidos: espacio, tabulador, etc)
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
*/
function ActualizarOfertas(Referencias)
{
	var Cambios=false, Modificados=0, NoEncontrados=0, RefNoEncontradas='', ErrorMarca=0, RefConErrorMarca='', alternativasCreadas=0,RefAlternativasCreadas='';
	
	var Completar=document.getElementById('COMPLETAROFERTA').checked;
	
	jQuery("#EnviarOfertasPorRef").hide();
	
	//solodebug	var Control='';
	//var Referencias	= oForm.elements['LIC_LISTA_OFERTAS'].value.replace(/(?:\r\n|\r|\n)/g, '|');
	Referencias	= Referencias.replace(/(?:\r\n|\r|\n)/g, '�');
	Referencias	= Referencias.replace(/[\t:;|]/g, ':');	// 	Separadores admitidos para separar referencia de cantidad
	
	var numRefs	= PieceCount(Referencias, '�');
	
	for (i=0;i<=numRefs;++i)
	{
		var Ref,RefProv,Nombre,Marca,UdsXLote,Precio;
		var Producto	= Piece(Referencias, '�',i);
		if (IDPais==55)
		{
			Ref			= Piece(Producto, ':', 0);
			Nombre		= Piece(Producto, ':', 1);
			Marca		= Piece(Producto, ':', 2);
			UdsXLote	= Piece(Producto, ':', 3);
			Precio		= Piece(Producto, ':', 4);
			RefProv		= Ref.toUpperCase()+'-'+UdsXLote+'-'+Marca.toUpperCase();	//	Misma formula que se aplica en la base de datos
		}
		else
		{
			Ref			= Piece(Producto, ':', 0);
			RefProv		= Piece(Producto, ':', 1);
			Nombre		= Piece(Producto, ':', 2);
			Marca		= Piece(Producto, ':', 3);
			UdsXLote	= Piece(Producto, ':', 4);
			Precio		= Piece(Producto, ':', 5);
		}
		
		//	Trabajaremos con las referencias y marcas en may�sculas
		Ref=Ref.toUpperCase();
		Marca=Marca.toUpperCase();
		
		//solodebug		
		console.log('ActualizarOfertas [INICIO] Oferta ('+i+'). Ref:'+Ref+' RefProv:'+RefProv+' Prod:'+Nombre+' Marca:'+Marca+' UdsXLote:'+UdsXLote+' Precio:'+Precio);
		
		if (Ref!='')
		{
			//solodebug	Control=Control+'['+i+'/'+numRefs+'] Referencia:'+Ref+ '. Cantidad:'+Cant;

			//	Recorre el array de productos buscando la referencia
			var Encont=false;

			for (j=0;((j<arrProductos.length) && (!Encont));++j)
			{
				if ((arrProductos[ColumnaOrdenadaProds[j]].RefCliente==Ref)||(arrProductos[ColumnaOrdenadaProds[j]].RefEstandar==Ref))
				{


					//solodebug		
					console.log('ActualizarOfertas Oferta ('+i+') Fila:'+j+'. Ref:'+Ref+' RefProv:'+arrProductos[ColumnaOrdenadaProds[j]].Oferta.RefProv+' Prod:'+Nombre+' Marca:'+Marca+' UdsXLote:'+UdsXLote+' Precio:'+Precio);


					//solodebug		console.log(Ref+' encontrado en posicion '+j);
					if (!MarcaOK(arrProductos[ColumnaOrdenadaProds[j]].Marcas, Marca))
					{
						console.log("ActualizarOfertas. Comprobando:"+j+" RefProv:"+arrProductos[ColumnaOrdenadaProds[j]].Oferta.RefProv+" ERROR MARCA");
						ErrorMarca++;
						RefConErrorMarca+=Ref+' ';
						Encont=true;
					}
					else
					{
						console.log("ActualizarOfertas. Comprobando:"+j+" RefProv:"+arrProductos[ColumnaOrdenadaProds[j]].Oferta.RefProv
								+" NumAlt:"+arrProductos[ColumnaOrdenadaProds[j]].NumAlternativas+ 'Completar:'+Completar);
						
						//	COmprueba si se puede sustituir una oferta existente
						if ((arrProductos[ColumnaOrdenadaProds[j]].NumAlternativas==0)								//	Si no hay ofertas, siempre informar� el registro actual
							||(arrProductos[ColumnaOrdenadaProds[j]].Oferta.RefProv==RefProv)						//	Misma ref.proveedor, siempre informar� el registro actual
							||((!Completar)&&(arrProductos[ColumnaOrdenadaProds[j]].NumAlternativas==1))			//	No completar, solo hay una oferta
							||((!Completar)&&(arrProductos[ColumnaOrdenadaProds[j]].Oferta.RefProv==RefProv)))		//	Misma ref.proveedor
						{

							console.log("ActualizarOfertas. Comprobando:"+j+" RefProv:"+arrProductos[ColumnaOrdenadaProds[j]].Oferta.RefProv
								+" alternativas:"+arrProductos[ColumnaOrdenadaProds[j]].NumAlternativas+' SUSTITUIR OFERTA');

							jQuery('#Desc_' + (arrProductos[ColumnaOrdenadaProds[j]].linea-1)).val(Nombre);
							jQuery('#Marca_' + (arrProductos[ColumnaOrdenadaProds[j]].linea-1)).val(Marca);
							jQuery('#UdsLote_' + (arrProductos[ColumnaOrdenadaProds[j]].linea-1)).val(UdsXLote);
							jQuery('#Precio_' + (arrProductos[ColumnaOrdenadaProds[j]].linea-1)).val(Precio);

							if (IDPais!=55)
							{
								jQuery('#RefProv_' + (arrProductos[ColumnaOrdenadaProds[j]].linea-1)).val(RefProv);
							}

							//	Mostramos el bot�n de guardar para esta fila, y el de guardar todos
							jQuery('#btnGuardar_'+ (arrProductos[ColumnaOrdenadaProds[j]].linea-1)).show();
							jQuery('#btnAlter_'+ (arrProductos[ColumnaOrdenadaProds[j]].linea-1)).show();
							jQuery('#idGuardarTodasOfertas').show();

							Encont=true;
							Cambios=true;
							Modificados++;
						}
						else
						{

							console.log("ActualizarOfertas. Comprobando:"+j+" RefProv:"+arrProductos[ColumnaOrdenadaProds[j]].Oferta.RefProv
								+" alternativas:"+arrProductos[ColumnaOrdenadaProds[j]].NumAlternativas+' NO sustituir oferta');
								
							//	Si se ha encontrado la referencia de cliente, miramos si existe una entrada en la que coincida tambi�n la referencia de proveedor
							var ExisteOtra=false;
							
							for (k=0;((k<arrProductos.length) && (!ExisteOtra));++k)
							{
								if (arrProductos[ColumnaOrdenadaProds[k]].Oferta.RefProv==RefProv)
									ExisteOtra=true;
							}
							
							//	Si no existe una entrada que coincida la referencia del proveedor, creamos una entrada nueva
							if (!ExisteOtra)
							{
								//	Incluimos el nuevo producto en el array, recuperando los datos del producto
								console.log("ActualizarOfertas. Crear nuevo:"+RefProv);
								
								var Alternativa=AlternativasInformadas(arrProductos[j].IDProdLic)+1,
									IDProdLic=arrProductos[j].IDProdLic,
									IDProvLic=arrProductos[j].Oferta.IDProvLic,
									Cantidad=arrProductos[j].Cantidad,
									TipoIVA=arrProductos[j].TipoIVA;
	
								var items		= [];
								var f = new Date();
								items['linea']		= arrProductos.length+1;				//	El contador empieza a 1 en lugar de 0
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
								/*

									PENDIENTE


								items['Oferta']['Documento']	= [];
								<xsl:if test="DOCUMENTOOFERTA">
									items['Oferta']['Documento']['ID']		= '<xsl:value-of select="DOCUMENTOOFERTA/ID"/>';
									items['Oferta']['Documento']['Nombre']		= '<xsl:value-of select="DOCUMENTOOFERTA/NOMBRE"/>';
									items['Oferta']['Documento']['Descripcion']	= '<xsl:value-of select="DOCUMENTOOFERTA/DESCRIPCION"/>';
									items['Oferta']['Documento']['Url']		= '<xsl:value-of select="DOCUMENTOOFERTA/URL"/>';
									items['Oferta']['Documento']['Fecha']		= '<xsl:value-of select="DOCUMENTOOFERTA/FECHA"/>';
								</xsl:if>
								<!-- FIN Campos Avanzados oferta -->

								items['Oferta']['FichaTecnica']	= [];
								<xsl:if test="FICHA_TECNICA/ID">
									items['Oferta']['FichaTecnica']['ID']		= '<xsl:value-of select="FICHA_TECNICA/ID"/>';
									items['Oferta']['FichaTecnica']['Nombre']	= '<xsl:value-of select="FICHA_TECNICA/NOMBRE"/>';
									items['Oferta']['FichaTecnica']['Descripcion']	= '<xsl:value-of select="FICHA_TECNICA/DESCRIPCION"/>';
									items['Oferta']['FichaTecnica']['Url']		= '<xsl:value-of select="FICHA_TECNICA/URL"/>';
									items['Oferta']['FichaTecnica']['Fecha']	= '<xsl:value-of select="FICHA_TECNICA/FECHA"/>';
								</xsl:if>
								*/

								arrProductos.push(items);						
								ColumnaOrdenadaProds[totalProductos]=totalProductos;		//	13mar19	Creamos la entrada en el array de ordenaci�n
								++totalProductos;
								
								++alternativasCreadas;
								RefAlternativasCreadas+=Ref+' ';
							
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
	
	if (alternativasCreadas>0)
		OrdenarProdsPorColumna(ColumnaOrdenacionProds, true);
	
	var aviso=alrt_AvisoOfertasActualizadas.replace('[[MODIFICADOS]]',Modificados).replace('[[NO_ENCONTRADOS]]',NoEncontrados+(NoEncontrados==0?".":":"+RefNoEncontradas));
	aviso=aviso.replace('[[ERROR_MARCA]]',ErrorMarca+(ErrorMarca==0?".":":"+RefConErrorMarca)).replace('[[NUEVAS_ALTERNATIVAS]]',alternativasCreadas+(alternativasCreadas==0?".":":"+RefAlternativasCreadas));

	alert(aviso);

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
	
	guardarOfertaFila(Pos);
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
	jQuery('#FBConsOfe').html(FormateaNumeroNacho(ConsumoOfe.toFixed(2)));

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
		for (i=0;i<=PieceCount(ListaMarcas,',');++i)
		{
			if (Piece(ListaMarcas,',',i)==Marca) MarcaOk=true;
		}
	}
	
	//	solodebug
	console.log('MarcaOK. ListaMarcas:'+ListaMarcas+' Marca:'+Marca+' MarcaOk:'+MarcaOk);
	
	return MarcaOk;
}





