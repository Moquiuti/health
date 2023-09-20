//	Funciones JS para la nueva version de la licitacion. BLOQUE PRODUCTOS.
//	Ultima revisión ET 11ene23 15:30 LicV2Prods_2022_020323.js

// tabla productos
var		totalProductos,			// numero total de productos en la licitacion
		numProductos,			// numero de productos que se muestran en la tabla (desplegable numRegistros)
		pagProductos= 0,		// pagina actual
		pagsProdTotal,			// total de paginas segun valor numRegistros
		firstProduct,			// primer indice de producto a mostrar en la tabla
		lastProduct,			// ultimo indice de producto a mostrar en la tabla
		ColumnaOrdenacionProds	= 'NombreNorm',		//	19mar19	'linea',
		OrdenProds		= '',
		ColumnaOrdenadaProds	= [];


//	22may19 Resumen de situación de las ofertas (antes variables locales, ahora globales para facilitar cálculos)
var	ConsumoPot,ConsumoPrev,Ahorro,numOfertas,numProdConOfe,numProdsAdjud,numProvsAdj;

var ProductExist = true;
var maxLineasParaInsertar = 500; 	//	Número máximo de líneas que pueden insertarse de una vez
var prodsInformados = 'S'			//	Marca cuando se estan insertando productos
var mostrarResumenFlotante;			//	Muestra el FloatingBox de resumen

function prepararTablaProductos(dibujaTabla)		//	17nov17
{
	//solodebug	
	debug('prepararTablaProductos. dibujaTabla:'+dibujaTabla);

	totalProductos	= arrProductos.length;
	mostrarResumenFlotante='S';								//	Presenta el Floating box
	calcularFloatingBox();									//	21oct22

	if(ColumnaOrdenacionProds == 'linea'){
		for(var i=0; i<totalProductos; i++){
			ColumnaOrdenadaProds[i] = i;
		}

		if (dibujaTabla) dibujaTablaProductos();			//	17nov17
	}else{
		OrdenarProdsPorColumna(ColumnaOrdenacionProds, true);
	}



	// Codigo para mostrar un div flotante que se auto-posiciona aunque se haga scroll
	if(jQuery(".FBox").length){

		jQuery(window).scroll(function(){
		
		ColocaFloatingBox();

		});
    }

}

//	Dibuja la tabla completa de productos con la matriz de ofertas
function dibujaTablaProductos(){

	//	14jul16	
	if(completarCompraCentro == 'S'){
		//solodebug		debug('dibujaTablaProductos->dibujaTablaProductosCENTRO');
		dibujaTablaProductosCENTRO();
	}else if(EstadoLic == 'EST'){
		//solodebug		debug('dibujaTablaProductos->dibujaTablaProductosEST');
		dibujaTablaProductosEST();
	}else if(rol == 'VENDEDOR'){
		if(permitirEdicionPROV == 'S'){
			//solodebug		debug('dibujaTablaProductos->dibujaTablaProductosPROVE');	
			dibujaTablaProductosPROVE();
		}else{
			//solodebug		debug('dibujaTablaProductos->dibujaTablaProductosPROVE_INF');
			dibujaTablaProductosPROVE_INF();
		}
	}else{
		//solodebug		debug('dibujaTablaProductos->dibujaTablaProductosOFE');		
		dibujaTablaProductosOFE();
	}

	if(ProductExist == false && ColumnaOrdenacionProds == 'Ordenacion'){
		alert(alrt_sinResultados);
	}
}


//	1set16	Busca la cantidad correspondiente al producto por ID
function buscaCantidadProductoPorCentro(ID)
{
	var Cantidad;
	//var Estado='NO ENCONTRADO';
	//var TextoDebug='';
	
	for(var i=0; i<totalProductos; i++){
		//TextoDebug+=' [ID:'+arrProductosPorCentro[i].IDProdLic+' Cantidad:'+arrProductosPorCentro[i].Cantidad+']';
		if (arrProductosPorCentro[i].IDProdLic==ID){
			Cantidad=arrProductosPorCentro[i].Cantidad;
			//Estado='Encontrado';
		}
	}
	//alert('ET DEBUG. ID:'+ID+' Estado:'+Estado+' Cantidad:'+Cantidad+ ' debug:'+TextoDebug);
	return Cantidad;
}

//	1set16	Busca la cantidad correspondiente al producto por ID
function buscaRefProductoPorCentro(ID)
{
	var Referencia;
	
	for(var i=0; i<totalProductos; i++){
		if (arrProductosPorCentro[i].IDProdLic==ID){
			if (arrProductosPorCentro[i].RefCentro!='')
				Referencia=arrProductosPorCentro[i].RefCentro;
			else if  (arrProductosPorCentro[i].RefCliente!='')
				Referencia=arrProductosPorCentro[i].RefCliente;
			else if  (arrProductosPorCentro[i].RefEstandar!='')
				Referencia=arrProductosPorCentro[i].RefEstandar;
		}
	}
	return Referencia;
}


//	Tabla de productos para informar los consumos por centro
function dibujaTablaProductosCENTRO(){

	var htmlTBODY = '', thisRow = '', thisCell = '' , thisMacro = '', functionJS, valAux;
	var contLinea = 0;
	anyChange = false;
	
	if(totalProductos > 0){
		for(var i=0; i<totalProductos; i++){
				
			contLinea++;

			// Iniciamos la fila (tr)
			thisRow = rowStartIDClass.replace('#ID#', 'posArr_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
			thisRow = thisRow.replace('#CLASS#', 'infoProds');

			// Celda/Columna numeracion
			thisCell = cellStart;
			thisCell += '&nbsp;' + contLinea + '&nbsp;';
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Ref.Cliente
			thisCell = cellStart;

			//	14jul20 Trabajamos con la referencia por centro
			var Referencia=buscaRefProductoPorCentro(arrProductos[ColumnaOrdenadaProds[i]].IDProdLic);
			thisCell += Referencia;
			
			/*if(arrProductos[ColumnaOrdenadaProds[i]].RefCliente != ''){
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].RefCliente;	// Mostramos Ref.Cliente si existe
			}else{
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].RefEstandar;	// Mostramos Ref.Estandar si no existe Ref.Cliente
			}*/
			
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Nombre
			thisCell = cellStartClassStyle.replace('#CLASS#','textLeft');
			thisCell = thisCell.replace('#STYLE#','padding:2px 0px 2px 4px;');
			//1set16 Cuidado, esta funcion utiliza el otro array: thisCell += '<strong>' + NombreProductoConEstilo(i) + '</strong>&nbsp;';
			thisCell += '<strong>' + arrProductos[ColumnaOrdenadaProds[i]].Nombre + '</strong>&nbsp;';
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna UdBasica
			thisCell = cellStartClass.replace('#CLASS#', 'udBasica');
			thisCell += arrProductos[ColumnaOrdenadaProds[i]].UdBasica;
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Cantidad
			thisCell = cellStart;
			thisMacro = macroInputTextonKeyUp.replace('#NAME#', 'Cantidad_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
			thisMacro = thisMacro.replace('#ID#', 'Cantidad_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
			thisMacro = thisMacro.replace('#CLASS#', 'cantidad campopesquisa w80px');
			thisMacro = thisMacro.replace('#SIZE#', '8');
			thisMacro = thisMacro.replace('#MAXLENGTH#', '8');
			thisMacro = thisMacro.replace('#ONKEYUP#', 'javascript:ActivarBotonGuardarCentro('+(arrProductos[ColumnaOrdenadaProds[i]].Linea - 1)+')');
			
			var Cantidad=buscaCantidadProductoPorCentro(arrProductos[ColumnaOrdenadaProds[i]].IDProdLic);
			
			if(isLicPorProducto == 'S'){
				if(Cantidad){
					thisMacro = thisMacro.replace('#VALUE#', Cantidad);
				}else{
					thisMacro = thisMacro.replace('#VALUE#', '0');
				}
			}else{
				thisMacro = thisMacro.replace('#VALUE#', Cantidad);
			}
			thisCell += thisMacro;
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna para guardar los datos de la oferta fila a fila
			thisCell = cellStartClass.replace('#CLASS#', 'acciones');
			functionJS	= 'javascript:guardarDatosCompraFila(\'' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1) + '\')';
			thisMacro	= macroEnlaceAccIDStyle.replace('#CLASS#', 'guardarOferta btnDestacadoPeq');
			thisMacro	= thisMacro.replace('#ID#', 'btnGuardar_'+ (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));	
			thisMacro	= thisMacro.replace('#HREF#', functionJS);
			thisMacro	= thisMacro.replace('#STYLE#', 'display:none;');
			thisCell	+= thisMacro;

			thisCell	+= strGuardar;

			thisCell	+= macroEnlaceEnd;
			thisCell += cellEnd;
			thisRow += thisCell;

			//	17set16	ID para el icono de guardado/error
			thisCell = cellStartClass.replace('#CLASS#', 'resultado');
			thisCell += '<span id="AVISOACCION_'+ (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1)+ '"/>';				//	17set16	ID '&nbsp;';
			thisCell += cellEnd;
			thisRow += thisCell;

			thisRow += rowEnd;
			htmlTBODY += thisRow;
    	}
	}

	jQuery('#lProductos_CENTRO tbody').empty().append(htmlTBODY);

}


// Este procedimiento dibuja la tabla de productos que permite seleccionar ofertas, sirve también para estados posteriores
function dibujaTablaProductosOFE()
{
	
	//solodebug	DebugProveedores();
	//solodebug	DebugOfertas();

	var htmlTBODY = '', thisRow = '', thisCell = '' , thisMacro = '', functionJS = '';
	var valAux, valAux2, contLinea = 0;
	anyChange = false;

	//solodebug	MuestraMatrizOfertas();
	//solodebug	debug("dibujaTablaProductosOFE INICIO. totalProductos:"+totalProductos);

	// Eliminamos la fila totalConsumo por si existe
	jQuery('#lProductos_OFE tfoot').remove();

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


		arrRadios = new Array();
		for(var i=firstProduct; i<lastProduct; i++){
			var items = [];
			items['checked']	= false;
			items['numOferta']	= null;
			items['OfertaID']	= null;
			contLinea++;

			// Iniciamos la fila (tr)
			thisRow = rowStartIDStyle.replace('#ID#', 'posArr_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
			thisRow = thisRow.replace('#STYLE#', 'border-bottom:1px solid #999;');

			// Celda/Columna numeracion
			thisCell = cellStartClass.replace('#CLASS#', 'textLeft');
			thisCell += '&nbsp;' + contLinea + '&nbsp;';
			if(isLicPorProducto == 'S' && (EstadoLic == 'CURS' || EstadoLic == 'INF')){
				thisCell += spanStartClassStyle.replace('#CLASS#', 'imgAviso');
				if(arrProductos[ColumnaOrdenadaProds[i]].TieneSeleccion == 'S'){
					thisCell = thisCell.replace('#STYLE#', 'display:none;');
				}else{
					thisCell = thisCell.replace('#STYLE#', '');
				}
				thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/atencion.gif');
				thisMacro = thisMacro.replace('#TITLE#', str_ProductoSinSeleccion);
				thisMacro = thisMacro.replace('#ALT#', str_ProductoSinSeleccion);
				thisCell += thisMacro + '&nbsp;';
				thisCell += spanEnd;
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Ref.Cliente
			thisCell = cellStartClass.replace('#CLASS#', 'textLeft');
			if(esAutor == 'S'){
				functionJS	= 'javascript:BorrarProducto(' + i +')';
				thisMacro	= '&nbsp;' + macroEnlaceAcc.replace('#CLASS#', 'accBorrar');
				thisMacro	= thisMacro.replace('#HREF#', functionJS);
				thisCell	+= thisMacro;
				thisCell	+= '<img src="http://www.newco.dev.br/images/2022/icones/del.svg" alt="' + str_borrar + '" title="' + str_borrar + '"/>'
				thisCell	+= macroEnlaceEnd;
			}

			thisCell += '&nbsp;' + macroEnlaceRef.replace('#LIC_PROD_ID#', arrProductos[ColumnaOrdenadaProds[i]].IDProdLic);
			if(arrProductos[ColumnaOrdenadaProds[i]].RefCentro != '')
			{
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].RefCentro;	// Mostramos Ref.Centro si existe
			}
			else if(arrProductos[ColumnaOrdenadaProds[i]].RefCliente != '')
			{
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].RefCliente;	// Mostramos Ref.Cliente si existe
			}
			else
			{
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].RefEstandar;	// Mostramos Ref.Estandar si no existe Ref.Cliente
			}
			thisCell += macroEnlaceEnd + cellEnd;
			thisRow += thisCell;

			// Celda/Columna Nombre
			thisCell = cellStartClass.replace('#CLASS#','textLeft');
			if(esAutor == 'S'){
				functionJS = 'javascript:abrirCamposAvanzadosProd(' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1) + ');'
				thisCell += '<span style="display:table-cell;vertical-align:middle;">';
				
				thisCell += macroEnlaceAcc.replace('#HREF#', functionJS).replace('#CLASS#', 'btnDiscreto');
				thisCell += '+'+macroEnlaceEnd + '&nbsp;';
				if ((arrProductos[ColumnaOrdenadaProds[i]].Marcas!='')||(arrProductos[ColumnaOrdenadaProds[i]].PrincActivo!=''))
					thisCell += '<a title="Marcas: '+arrProductos[ColumnaOrdenadaProds[i]].Marcas+'&#13;'+strPrincActivo+': '+arrProductos[ColumnaOrdenadaProds[i]].PrincActivo+'" class="btnDiscreto">&nbsp;i&nbsp;</a>'
				thisCell += '</span>';
			}
			thisCell += '<span style="display:table-cell;"><strong>' + NombreProductoConEstilo(i) + '</strong>&nbsp;';

			thisCell += '</span>';
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna iconos campos avanzados
			thisCell = cellStart;
			// Info.Ampliada
			if(arrProductos[ColumnaOrdenadaProds[i]].InfoAmpliada != ''){
				thisMacro = divStartClass;
				thisMacro = thisMacro.replace('#CLASS#', 'tooltip');
				thisCell += thisMacro;
				thisCell += '<img src="http://www.newco.dev.br/images/infoAmpliadaIconO.gif" class="static"/>';
				thisCell += spanStartClass.replace('#CLASS#', 'tooltiptext');
				thisCell += str_InfoAmpliada + ':<br/><br/>';
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].InfoAmpliada;
				thisCell += spanEnd;
				thisCell += macroEnlaceEnd + '&nbsp;';
			}
			// Documento
			if(typeof arrProductos[ColumnaOrdenadaProds[i]].Documento.ID !== 'undefined'){
				thisMacro = macroEnlaceTarget.replace('#HREF#', 'http://www.newco.dev.br/Documentos/' + arrProductos[ColumnaOrdenadaProds[i]].Documento.Url);
				thisCell += thisMacro;
				thisMacro = macroImagen3.replace('#SRC#', 'http://www.newco.dev.br/images/clipIconO.gif');
				thisMacro = thisMacro.replace('#CLASS#', 'static');
				thisMacro = thisMacro.replace('#ALT#', str_Documento);
				thisMacro = thisMacro.replace('#TITLE#', str_Documento);
				thisCell += thisMacro;
				thisCell += macroEnlaceEnd + '&nbsp;';
			}
			// Anotaciones
			if(arrProductos[ColumnaOrdenadaProds[i]].Anotaciones != ''){
				thisMacro = divStartClass;
				thisMacro = thisMacro.replace('#CLASS#', 'tooltip');
				thisCell += thisMacro;
				thisCell += '<img src="http://www.newco.dev.br/images/infoAmpliadaIconNaraO.gif " class="static"/>';
				thisCell += spanStartClass.replace('#CLASS#', 'tooltiptext');
				thisCell += str_Anotaciones + ':<br/><br/>';
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].Anotaciones;
				thisCell += spanEnd;
				thisCell += macroEnlaceEnd;
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna NumOfertas
			thisCell = cellStartClass;
			if(arrProductos[ColumnaOrdenadaProds[i]].NumOfertas == 0){
				thisCell = thisCell.replace('#CLASS#', 'fondoRojo');
			}else{
				thisCell = thisCell.replace('#CLASS#', 'borderLeft');
			}
			thisCell += arrProductos[ColumnaOrdenadaProds[i]].NumOfertas;
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna UdBasica
			thisCell = cellStartClass.replace('#CLASS#', 'borderLeft');
			if(esAutor == 'S' && EstadoLic != 'CONT'){
				thisMacro	= macroInputText.replace('#NAME#', 'UDBASICA_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
				thisMacro	= thisMacro.replace('#ID#', 'UDBASICA_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
				thisMacro	= thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].UdBasica);
				thisMacro	= thisMacro.replace('#CLASS#', 'udbasica w100px campopesquisa');
				thisMacro	= thisMacro.replace('#SIZE#', '15');
				thisMacro	= thisMacro.replace('#MAXLENGTH#', '100');
				thisCell	+= thisMacro;
			}else{
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].UdBasica;
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Precio Historico
			thisCell = cellStartClass.replace('#CLASS#', 'precioRef textRight');
			if(mostrarPrecioIVA == 'S'){
				if(esAutor == 'S' && EstadoLic != 'CONT'){
					thisMacro	=	macroInputText.replace('#NAME#', 'PRECIOREFIVA_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
					thisMacro	=	thisMacro.replace('#ID#', 'PRECIOREFIVA_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
					thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].PrecioHistIVA);
					thisMacro	=	thisMacro.replace('#CLASS#', 'preciorefiva w100px campopesquisa');
					thisMacro	=	thisMacro.replace('#SIZE#', '8');
					thisMacro	=	thisMacro.replace('#MAXLENGTH#', '10');
					thisCell	+=	thisMacro;

					thisMacro	=	macroInputHidden.replace('#NAME#', 'PRECIOREF_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
					thisMacro	=	thisMacro.replace('#ID#', 'PRECIOREF_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
					thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].PrecioHist);
					thisMacro	=	thisMacro.replace('#CLASS#', 'precioref  w100px campopesquisa');
					thisCell	+=	thisMacro;
				}else{
					thisCell += arrProductos[ColumnaOrdenadaProds[i]].PrecioHistIVA;
				}
                        }else{
				if(esAutor == 'S' && EstadoLic != 'CONT'){
					thisMacro	=	macroInputText.replace('#NAME#', 'PRECIOREF_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
					thisMacro	=	thisMacro.replace('#ID#', 'PRECIOREF_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
					thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].PrecioHist);
					thisMacro	=	thisMacro.replace('#CLASS#', 'precioref w100px campopesquisa');
					thisMacro	=	thisMacro.replace('#SIZE#', '8');
					thisMacro	=	thisMacro.replace('#MAXLENGTH#', '10');
					thisCell	+=	thisMacro;
				}else{
					thisCell += arrProductos[ColumnaOrdenadaProds[i]].PrecioHist;
				}
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Precio Objetivo
			thisCell = cellStartClass.replace('#CLASS#', 'textRight');
			if(mostrarPrecioIVA == 'S'){
				if(esAutor == 'S' && EstadoLic != 'CONT'){
					thisMacro	=	macroInputText.replace('#NAME#', 'PRECIO_OBJIVA_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
					thisMacro	=	thisMacro.replace('#ID#', 'PRECIO_OBJIVA_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
					thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].PrecioObjIVA);
					thisMacro	=	thisMacro.replace('#CLASS#', 'PrecioObjiva  w100px campopesquisa');
					thisMacro	=	thisMacro.replace('#SIZE#', '8');
					thisMacro	=	thisMacro.replace('#MAXLENGTH#', '10');
					thisCell	+=	thisMacro;

					thisMacro	=	macroInputHidden.replace('#NAME#', 'PRECIO_OBJ_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
					thisMacro	=	thisMacro.replace('#ID#', 'PRECIO_OBJ_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
					thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].PrecioObj);
					thisMacro	=	thisMacro.replace('#CLASS#', 'PrecioObj  w100px campopesquisa');
					thisCell	+=	thisMacro;
				}else{
					thisCell += arrProductos[ColumnaOrdenadaProds[i]].PrecioObjIVA;
				}
                        }else{
				if(esAutor == 'S' && EstadoLic != 'CONT'){
					thisMacro	=	macroInputText.replace('#NAME#', 'PRECIO_OBJ_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
					thisMacro	=	thisMacro.replace('#ID#', 'PRECIO_OBJ_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
					thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].PrecioObj);
					thisMacro	=	thisMacro.replace('#CLASS#', 'PrecioObj  w100px campopesquisa');
					thisMacro	=	thisMacro.replace('#SIZE#', '8');
					thisMacro	=	thisMacro.replace('#MAXLENGTH#', '10');
					thisCell	+=	thisMacro;
				}else{
					thisCell += arrProductos[ColumnaOrdenadaProds[i]].PrecioObj;
				}
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Ahorro
			thisCell = cellStartClass.replace('#CLASS#', 'textRight');
			if(arrProductos[ColumnaOrdenadaProds[i]].SinAhorro == 'S'){
				thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/change.png');
				thisMacro = thisMacro.replace('#TITLE#', str_ProductoSinAhorro);
				thisMacro = thisMacro.replace('#ALT#', str_ProductoSinAhorro);
				thisCell += thisMacro + '&nbsp;';
			}

			// Marcamos los ahorros como sospechosos o muy sospechosos
			if(arrProductos[ColumnaOrdenadaProds[i]].Sospechoso == '2'){
				thisCell += spanStartClassTitle.replace('#CLASS#', 'rojo2').replace('#TITLE#', '');
				thisCell += '?&nbsp;';
				thisCell += spanEnd;
			}else if(arrProductos[ColumnaOrdenadaProds[i]].Sospechoso == '1'){
				thisCell += spanStartClassTitle.replace('#CLASS#', 'orange').replace('#TITLE#', '');
				thisCell += '?&nbsp;';
				thisCell += spanEnd;
			}

			if(arrProductos[ColumnaOrdenadaProds[i]].AhorroMax != ''){
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].AhorroMax + '%&nbsp;';
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Cantidad
			thisCell = cellStartClass.replace('#CLASS#', 'cuatro cantidad textRight');
			if(esAutor == 'S' && EstadoLic != 'CONT' && isLicAgregada=='N'){											// No permitimos modificar en caso de licitacion agregada
				thisMacro	= macroInputText.replace('#NAME#', 'CANTIDAD_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
				thisMacro	= thisMacro.replace('#ID#', 'CANTIDAD_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
				thisMacro	= thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].Cantidad);
				thisMacro	= thisMacro.replace('#CLASS#', 'cantidad campopesquisa w80px');
				thisMacro	= thisMacro.replace('#SIZE#', '6');
				thisMacro	= thisMacro.replace('#MAXLENGTH#', '8');
				thisCell	+= thisMacro;
			}else{
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].Cantidad;
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Consumo
			thisCell = cellStartClass.replace('#CLASS#', 'cuatro textRight');
			if(mostrarPrecioIVA == 'S'){
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].ConsumoHistIVA;
			}else{
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].ConsumoHist;
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna TipoIVA
			thisCell = cellStartClass;
			if(IDPais != 55){
				thisCell = thisCell.replace('#CLASS#', 'dos textRight');
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].TipoIVA + '%';
			}else{
				thisCell = thisCell.replace('#CLASS#', 'zerouno');
				thisCell += '&nbsp;';
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// DATOS DE LAS OFERTAS
			// Recorremos todos los proveedores
			// 9set16 quitamos los proveedores que no han ofertado

			//solodebug	if (i==0) alert(i+'/'+arrProductos[ColumnaOrdenadaProds[i]].Ofertas.length+' '+arrProductos[ColumnaOrdenadaProds[i]].IDProdLic);

			/*var Columna=0;
			for(var j=0; j<arrProductos[ColumnaOrdenadaProds[i]].Ofertas.length; j++){
			
				//	5jul22 Recuperamos la columna del proveedor
				var ColProveedor=arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].ColProveedor;
				
				//solodebug	
				debug('dibujaTablaProductosOFE ('+i+','+j+') OrdenCol:'+ColumnaOrdenadaProds[i]+' IDProdLic:'+arrProductos[ColumnaOrdenadaProds[i]].IDProdLic+' IDProvLic:'+arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].IDPROVEEDORLIC
				//solodebug
						+' IDOferta:'+arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].ID+' ColProveedor:'+ColProveedor+' TieneOfertas:'+arrProveedores[ColProveedor].TieneOfertas);
				
				//solodebug
					var cont=0;
					if ((arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].IDPROVEEDORLIC==5085)&&(cont<10)){
						++cont;
						alert(' fila:'+i+' columna:'+j);
						alert('LicProvID:'+arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].IDPROVEEDORLIC+' fila:'+i+' columna:'+j+' Precio oferta:'+arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].PRECIO);
					}
				
				//solodebug	
				debug('dibujaTablaProductosOFE ('+i+','+j+') col.prov ('+arrProveedores[j].Orden + '): '+ arrProveedores[j].NombreCorto +' Ofe:'+arrProveedores[j].TieneOfertas);
			
				//	Inserta celdas vacias hasta llegar hasta la columna correcta
				debug('dibujaTablaProductosOFE ('+i+','+j+'). Incluir columnas vacias. INI. NumCols:'+NumColsMatriz+' ColActual:'+Columna+' ColMatrizProv:'+arrProveedores[ColProveedor].ColMatriz);



				for (var k=Columna;((k<NumColsMatriz)&&(arrProveedores[ColProveedor].ColMatriz<Columna));++k)
				{
					debug('dibujaTablaProductosOFE ('+i+','+j+') Col. vacia:'+k+' hasta:'+arrProveedores[ColProveedor].ColMatriz);
				
					thisRow += cellStart+cellEnd;
					++Columna;
				}
				debug('dibujaTablaProductosOFE ('+i+','+j+'). Incluir columnas vacias. FIN. NumCols:'+NumColsMatriz+' ColActual:'+Columna+' ColMatrizProv:'+arrProveedores[ColProveedor].ColMatriz);

				if (arrProveedores[ColProveedor].TieneOfertas=='S'){	//	COmprueba proveedor con ofertas /Mantenimiento/LICITACION/PRODUCTOSLICITACION/PROVEEDORESLICITACION/PROVEEDOR/TIENE_OFERTAS
			*/
			
			//	Recorre las columnas
			for(var k=0; k<NumColsMatriz; k++)
			{
				//	Busca a que proveedor corresponde esta columna
				var ColProv=-1;
				for (var l=0;((ColProv==-1)&&(l<arrProveedores.length));++l)
				{
					if (arrProveedores[l].ColMatriz==k) ColProv=l;
				}

				//solodebug debug('dibujaTablaProductosOFE ('+i+','+k+'). Buscar proveedor:'+ColProv);

				
				//	Busca si este proveedor tiene una oferta para este producto
				var j=-1;
				for (var l=0;((j==-1)&&(l<arrProductos[ColumnaOrdenadaProds[i]].Ofertas.length));++l)
				{
					//solodebug debug('dibujaTablaProductosOFE Revisando oferta ('+i+','+l+'). val:'+arrProductos[ColumnaOrdenadaProds[i]].Ofertas[l].ColMatriz);
					
					if (arrProductos[ColumnaOrdenadaProds[i]].Ofertas[l].ColMatriz==k) j=l;
				}
				
				//solodebug debug('dibujaTablaProductosOFE ('+i+','+k+'). Buscar oferta:'+j);
			
			
				if (j==-1)	//	Si no se ha encontrado oferta, columna vacia
				{
					// Si la oferta del proveedor para este producto no esta informada
					thisCell = cellStartColspanCls.replace('#COLSPAN#', '4');
					thisCell = thisCell.replace('#CLASS#', 'colSinOferta center');
					thisCell += cellEnd;
					thisRow += thisCell;
				}
				else
				{

					//solodebug	
					//alert(arrProveedores[j].NombreCorto+' tiene ofertas:'+arrProveedores[j].TieneOfertas
					//	+ ' NoInformada:'+arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].NoInformada
					//	+ ' NoOfertada:'+arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].NoOfertada
					//	);

					//solodebug		debug('dibujaTablaProductosOFE ('+i+','+j+') col.prov:'+arrProveedores[j].Orden + ' '+ arrProveedores[j].NombreCorto + ' Ofe:'+arrProveedores[j].TieneOfertas
					//solodebug			+' DATOS OFERTA. '+arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].IDPROVEEDORLIC+' NoInformada:'+arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].NoInformada+' NoOfertada:'+arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].NoOfertada);

					if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].NoInformada == 'S')
					{
						// Si la oferta del proveedor para este producto no esta informada
						thisCell = cellStartColspanCls.replace('#COLSPAN#', '4');
						thisCell = thisCell.replace('#CLASS#', 'colSinOferta center');
						thisCell += cellEnd;
						thisRow += thisCell;
					}
					else if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].NoOfertada == 'S')
					{
						// Si el proveedor ha informado de algunas ofertas, pero esta esta vacia
						thisCell = cellStartColspanCls.replace('#COLSPAN#', '4');
						thisCell = thisCell.replace('#CLASS#', 'colSinOferta center');
						thisCell += cellEnd;
						thisRow += thisCell;
					}
					else
					{	// Si esta oferta esta informada

						// Celda para licitaciones por producto (radio button o imagen checked)
							
						var fondo='';
						if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].OfertaAdjud == 'S') fondo='fondoAmarillo';
							
						thisCell = cellStartClass.replace('#CLASS#', 'textLeft '+fondo);
						//thisCell = cellStartClassStyle.replace('#CLASS#', 'textLeft '+fondo);
						//thisCell = thisCell.replace('#STYLE#', 'padding:0 1px;');
						if (isLicMultiopcion=='N')
						{

							//solodebug			debug('dibujaTablaProductosOFE ('+i+','+j+') col.prov:'+arrProveedores[j].Orden + ' isLicMultiopcion:'+ isLicMultiopcion);

							if((EstadoLic=='CURS' || EstadoLic=='INF') && (isLicPorProducto=='S') && (esAutor=='S')
									&&(ProveedorBloqueado(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].IDPROVEEDORLIC)=='N')		//	13ene20 Proveedor bloqueado por pedidos
									&&(arrProductos[ColumnaOrdenadaProds[i]].BloqPedidos=='N'))									//	13ene20 Producto bloqueado por pedidos
							{
								thisMacro = macroInputRadio.replace('#NAME#', 'RADIO_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
								thisMacro = thisMacro.replace('#CLASS#', 'RADIO_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1+' muypeq'));
								thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].ID);	//21set16	.IDOferta
								if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].OfertaAdjud == 'S')
								{
									items['checked']	= true;
									items['numOferta']	= (arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Orden);	//13abr17	(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Orden - 1);
									items['OfertaID']	= (arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].ID);

									//solodebug 8may17	debug('dibujaTablaProductosOFE. ID:'+items['OfertaID']+' fila:'+ColumnaOrdenadaProds[i]+'col:'+j+' ->OfertaAdjud');

									thisMacro = thisMacro.replace('#CHECKED#', 'checked="checked"');

									//	Nuevo caso: repartido entre varios proveedores, mostramos la cantidad y ocultamos el control
									if ((arrProductos[ColumnaOrdenadaProds[i]].VariosProv=='S')&&(parseFloat(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].CantAdjud.replace(',','.'))>0))
									{
										//	en lugar del radio, presenta la cantidad
										thisMacro = '<B>'+arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].CantAdjud+'x</B>'+thisMacro.replace('>', ' style="display:none;">');
									}
								}
								else
								{
									thisMacro = thisMacro.replace('#CHECKED#', '');

									//	Nuevo caso: repartido entre varios proveedores, mostramos la cantidad y ocultamos el control
									if (arrProductos[ColumnaOrdenadaProds[i]].VariosProv=='S')
									{
										thisMacro = thisMacro.replace('>', ' style="display:none;">');
									}
								}
								thisCell += thisMacro;


								//solodebug	13abr17	debug('Prov:' + arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].ID+' columna:'+(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Orden));

								thisMacro = macroInputHidden.replace('#NAME#', 'Prov_' + arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].ID);	//21set16	.IDOferta
								thisMacro = thisMacro.replace('#ID#', 'Prov_' + arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].ID);	//21set16	.IDOferta
								thisMacro = thisMacro.replace('#VALUE#', (arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Orden));	//13abr17	arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Orden - 1
								thisMacro = thisMacro.replace('#CLASS#', 'LicProv');
								thisCell += thisMacro;
							}
							else if(isLicPorProducto=='S')
							{
								if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].OfertaAdjud == 'S'){
									thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/check.gif');
									thisMacro = thisMacro.replace('#TITLE#', str_OfertaAdjudicada);
									thisMacro = thisMacro.replace('#ALT#', str_OfertaAdjudicada);
									thisCell += thisMacro;
									//	14ene20 Para el cálculo del floating box hay que guardar el valor en un checkbox oculto
									thisMacro = macroInputRadio.replace('#NAME#', 'RADIO_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
									thisMacro = thisMacro.replace('#CLASS#', 'RADIO_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1+' muypeq'));
									thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].ID);	//21set16	.IDOferta
									thisMacro = thisMacro.replace('#CHECKED#', 'checked="checked"');
									thisMacro = thisMacro.replace('>', ' style="display:none;">');
									thisCell += thisMacro;
								}else{
									//	14ene20 thisCell += '';
									//	14ene20 Para el cálculo del floating box hay que guardar el valor en un checkbox oculto
									thisMacro = macroInputRadio.replace('#NAME#', 'RADIO_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
									thisMacro = thisMacro.replace('#CLASS#', 'RADIO_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1+' muypeq'));
									thisMacro = thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].ID);	//21set16	.IDOferta
									thisMacro = thisMacro.replace('#CHECKED#', '');
									thisMacro = thisMacro.replace('>', ' style="display:none;">');
									thisCell += thisMacro;
								}
							}else{
								thisCell += '';
							}

							//solodebug		debug('dibujaTablaProductosOFE ('+i+','+j+') col.prov:'+arrProveedores[j].Orden + ' isLicMultiopcion NO. thisCell:'+thisCell);
						}
						else
						{

							//	9jul18 Licitación multiopcion
							if (arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Orden=='-1')
							{
								// No Adjudicado, mostramos "NO"
								thisCell += '<strong>NO</strong>&nbsp;';
							}
							else
							{	
								//	Adjudicado: mostramos número de orden, con formato de alta visibilidad para la opción 1
								thisCell += '<strong>'+arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Orden+'</strong>&nbsp;';
							}

							//solodebug		debug('dibujaTablaProductosOFE ('+i+','+j+') col.prov:'+arrProveedores[j].Orden + ' isLicMultiopcion SI. thisCell:'+thisCell);
						}
						thisCell += cellEnd;
						thisRow += thisCell;

						// Celda para precio oferta
						thisCell = cellStartIDClassSty.replace('#ID#', 'arrProd-' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1) + '_arrProvOfr-' + (arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Orden - 1));
						thisCell = thisCell.replace('#CLASS#', 'PrecioOferta_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1) + ' textRight colPrecio '+fondo);
						thisCell = thisCell.replace('#STYLE#', 'display:none;');
						if(mostrarPrecioIVA == 'S'){
							valAux	= parseFloat(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].PRECIOIVA.replace(',', '.'));
							valAux2	= parseFloat(arrProductos[ColumnaOrdenadaProds[i]].PrecioHistIVA.replace(',', '.'));
	/*
							// Marca oferta 80% inferior a precio historico
							if(valAux !== 0 && (valAux2 * 0.2 > valAux)){
								thisCell += spanStartClassTitle.replace('#CLASS#', 'rojo2').replace('#TITLE#', str_PrecioOfertaSospechoso);
								thisCell += '?&nbsp;';
								thisCell += spanEnd;
							}
	*/
							// Marcamos las ofertas como sospechosas o muy sospechosas
							if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Sospechoso == '2'){
								thisCell += spanStartClassTitle.replace('#CLASS#', 'rojo2').replace('#TITLE#', str_PrecioOfertaMuySospechoso);
								thisCell += '?&nbsp;';
								thisCell += spanEnd;
							}else if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Sospechoso == '1'){
								thisCell += spanStartClassTitle.replace('#CLASS#', 'orange').replace('#TITLE#', str_PrecioOfertaSospechoso);
								thisCell += '?&nbsp;';
								thisCell += spanEnd;
							}

							// Precio con IVA
							thisCell += macroEnlaceRef2.replace('#LIC_PROD_ID#', arrProductos[ColumnaOrdenadaProds[i]].IDProdLic);
							if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].PrecioColor == 'Naranja'){
								thisCell += spanStartClass.replace('#CLASS#', 'oferta naranja');
							}else if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].PrecioColor == 'Rojo'){
								thisCell += spanStartClass.replace('#CLASS#', 'oferta rojo');
							}else{
								thisCell += spanStartClass.replace('#CLASS#', 'oferta verde');
							}
							thisCell += arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].PRECIOIVA;
							thisCell += spanEnd + macroEnlaceEnd + '&nbsp;';
						}else{
							valAux	= parseFloat(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].PRECIO.replace(',', '.'));
							valAux2	= parseFloat(arrProductos[ColumnaOrdenadaProds[i]].PrecioHist.replace(',', '.'));
	/*
							// Marca oferta 80% inferior a precio historico
							if(valAux !== 0 && (valAux2 * 0.2 > valAux)){
								thisCell += spanStartClassTitle.replace('#CLASS#', 'rojo2').replace('#TITLE#', str_PrecioOfertaSospechoso);
								thisCell += '?&nbsp;';
								thisCell += spanEnd;
							}
	*/
							// Marcamos las ofertas como sospechosas o muy sospechosas
							if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Sospechoso == '2'){
								thisCell += spanStartClassTitle.replace('#CLASS#', 'rojo2').replace('#TITLE#', str_PrecioOfertaMuySospechoso);
								thisCell += '?&nbsp;';
								thisCell += spanEnd;
							}else if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Sospechoso == '1'){
								thisCell += spanStartClassTitle.replace('#CLASS#', 'orange').replace('#TITLE#', str_PrecioOfertaSospechoso);
								thisCell += '?&nbsp;';
								thisCell += spanEnd;
							}

							// Precio sin IVA
							thisCell += macroEnlaceRef2.replace('#LIC_PROD_ID#', arrProductos[ColumnaOrdenadaProds[i]].IDProdLic);
							if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].PrecioColor == 'Naranja'){
								thisCell += spanStartClass.replace('#CLASS#', 'oferta naranja');
							}else if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].PrecioColor == 'Rojo'){
								thisCell += spanStartClass.replace('#CLASS#', 'oferta rojo');
							}else if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].PrecioColor == 'Verde'){		//	16ene17
								thisCell += spanStartClass.replace('#CLASS#', 'oferta verde');
							}else{
								thisCell += spanStartClass.replace('#CLASS#', 'oferta');
							}
							thisCell += arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].PRECIO;
							thisCell += spanEnd + macroEnlaceEnd + '&nbsp;';
						}
						thisCell += cellEnd;
						thisRow += thisCell;

						// Celda para consumo
						thisCell = cellStartClassStyle.replace('#CLASS#', 'textRight colConsumo');
						thisCell = thisCell.replace('#STYLE#', 'display:none;');
						if(mostrarPrecioIVA == 'S'){
							thisCell += arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].ConsumoIVA + '&nbsp;';
						}else{
							thisCell += arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Consumo + '&nbsp;';
						}
						thisCell += cellEnd;
						thisRow += thisCell;

						// Celda para ahorro
						thisCell = cellStartClassStyle.replace('#CLASS#', 'textRight colAhorro');
						thisCell = thisCell.replace('#STYLE#', 'display:none;');
						if (arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Ahorro!=''){		//	31ago16	solo mostramos el ahorro si está informado
							thisCell += arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Ahorro + '%&nbsp;';
						}
						thisCell += cellEnd;
						thisRow += thisCell;

						// Celda para imagen evaluacion oferta
						thisCell = cellStartClassStyle.replace('#CLASS#', 'colEval');
						thisCell = thisCell.replace('#STYLE#', 'display:none;');
						if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].IDEstadoEval == 'NOAPTO'){
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/bolaRoja.gif');
							thisMacro = thisMacro.replace('#TITLE#', str_ofertaNoApto);
							thisMacro = thisMacro.replace('#ALT#', str_ofertaNoApto);
						}else if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].IDEstadoEval == 'PEND'){
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/bolaAmbar.gif');
							thisMacro = thisMacro.replace('#TITLE#', str_ofertaPendiente);
							thisMacro = thisMacro.replace('#ALT#', str_ofertaPendiente);
						}else{
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/bolaVerde.gif');
							thisMacro = thisMacro.replace('#TITLE#', str_ofertaApto);
							thisMacro = thisMacro.replace('#ALT#', str_ofertaApto);
						}
						thisCell += thisMacro;
						thisCell += cellEnd;
						thisRow += thisCell;

						// Celda para la ficha tecnica (si hay)
						thisCell = cellStartClassStyle.replace('#CLASS#', 'colInfo');
						thisCell = thisCell.replace('#STYLE#', 'display:none;');
						if((arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].FichaTecnica)&&(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].FichaTecnica.ID))
						{
							thisCell += macroEnlaceTarget.replace('#HREF#', 'http://www.newco.dev.br/Documentos/' + arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].FichaTecnica.Url);
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/fichaChange.gif');
							thisMacro = thisMacro.replace('#TITLE#', str_FichaTecnica);
							thisMacro = thisMacro.replace('#ALT#', str_FichaTecnica);
							thisCell += thisMacro;
							thisCell += macroEnlaceEnd + '&nbsp;';
						}
						// Info.Ampliada Oferta (si hay)
						if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].InfoAmpliada != ''){
							//ET 14dic16	Cambio de estilos para los tooltips
							//ET 14dic16	thisMacro = macroEnlaceAcc.replace('#HREF#', '#');
							thisMacro = divStartClass;
							thisMacro = thisMacro.replace('#CLASS#', 'tooltip');
							thisCell += thisMacro;
							thisCell += '<img src="http://www.newco.dev.br/images/infoAmpliadaIconO.gif" class="static"/>';
							//ET 14dic16	thisCell += spanStartClass.replace('#CLASS#', 'classic spanEIS');
							thisCell += spanStartClass.replace('#CLASS#', 'tooltiptext');
							thisCell += str_InfoAmpliada + ':<br/><br/>';
							thisCell += arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].InfoAmpliada;
							thisCell += spanEnd;
							thisCell += macroEnlaceEnd + '&nbsp;';
						}
						// Documento Oferta (si hay)
						//9ago22	if(typeof arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Documento.ID !== 'undefined')
						if((arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Documento)&&(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Documento.ID))
						{
							thisMacro = macroEnlaceTarget.replace('#HREF#', 'http://www.newco.dev.br/Documentos/' + arrProductos[ColumnaOrdenadaProds[i]].Ofertas[j].Documento.Url);
							thisCell += thisMacro;
							thisMacro = macroImagen3.replace('#SRC#', 'http://www.newco.dev.br/images/clipIconO.gif');
							thisMacro = thisMacro.replace('#CLASS#', 'static');
							thisMacro = thisMacro.replace('#ALT#', str_Documento);
							thisMacro = thisMacro.replace('#TITLE#', str_Documento);
							thisCell += thisMacro;
							thisCell += macroEnlaceEnd + '&nbsp;';
						}
						thisCell += cellEnd;
						thisRow += thisCell;
					}	//fin comprueba oferta informada	
				}	//fin comprueba proveedor con ofertas	
			}	//	fin bucle proveedores

			thisRow += rowEnd;
			htmlTBODY += thisRow;

			// Hacemos push de datos al array arrRadios
			arrRadios.push(items);
		}// fib bucle productos

		dibujarFilaConsumoProdOFE();
		calcularPaginacion();

    }

	jQuery('#lProductos_OFE tbody').empty().append(htmlTBODY);
	muestraNuevaVistaProductos(jQuery("select#tipoVista").val());
	MarcarMejoresPrecios();

	//	21set16
	validarBotonAdjudicar();


	//solodebug 31mar17 ET problemas floatingbox	debug('dibujaTablaProductosOFE. isLicPorProducto:'+isLicPorProducto+' EstadoLic:'+EstadoLic);


	// Permitir desseleccionar radio buttons
	if(isLicPorProducto == 'S' && (EstadoLic == 'CURS' ||EstadoLic == 'INF')){
		//
		jQuery('input[type=radio]').uncheckableRadio();

		//29may19	// Ahora recalculamos los valores del floatinBox
		//29may19	if(jQuery(".FBox").length)
		//29may19		calcularFloatingBox();
		// Ahora mostramos el floatinBox
		if(jQuery(".FBox").length)
			informarFloatingBox();
	}

	//solodebug	debug("dibujaTablaProductosOFE FINAL. totalProductos:"+totalProductos);

}

function dibujaTablaProductosEST(){
	var htmlTBODY = '', thisRow = '', thisCell = '' , thisMacro = '', functionJS = '', contLinea = 0;

	// Eliminamos la fila totalConsumo por si existe
	jQuery('#lProductos_EST tfoot').remove();

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
			thisRow = rowStartID.replace('#ID#', 'posArr_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));

			// Celda/Columna numeracion
			thisCell = cellStart + '&nbsp;' + contLinea + '&nbsp;' + cellEnd;
			thisRow += thisCell;

			// Celda/Columna Ref.Cliente
			thisCell = cellStart + macroEnlaceRef.replace('#LIC_PROD_ID#', arrProductos[ColumnaOrdenadaProds[i]].IDProdLic);
			if(arrProductos[ColumnaOrdenadaProds[i]].RefCentro != ''){
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].RefCentro;	// Mostramos Ref.Centro si existe
			}
			else if(arrProductos[ColumnaOrdenadaProds[i]].RefCliente != '')
			{
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].RefCliente;	// Mostramos Ref.Cliente si existe
			}
			else
			{
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].RefEstandar;	// Mostramos Ref.Estandar si no existe Ref.Cliente
			}
			thisCell += macroEnlaceEnd + cellEnd;
			thisRow += thisCell;

			// Celda/Columna Nombre
			thisCell = cellStartClass.replace('#CLASS#','textLeft');
			if(esAutor == 'S'){
				thisCell += '<span style="display:table-cell;vertical-align:middle;">';
				functionJS = 'javascript:abrirCamposAvanzadosProd(' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1) + ');'
				thisCell += macroEnlace.replace('#HREF#', functionJS);
				thisCell += macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/anadir.gif').replace('#TITLE#', str_AnyadirInfoAmpliada).replace('#ALT#', str_AnyadirInfoAmpliada);
				thisCell += macroEnlaceEnd + '&nbsp;';
				thisCell += '</span>';
			}

			thisCell += '<span style="padding:2px;display:table-cell;"><strong>' + NombreProductoConEstilo(i) + '</strong>&nbsp;</span>';
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna iconos campos avanzados
			thisCell = cellStart;
			// Info.Ampliada
			if(arrProductos[ColumnaOrdenadaProds[i]].InfoAmpliada != ''){
				thisMacro = divStartClass;
				thisMacro = thisMacro.replace('#CLASS#', 'tooltip');
				thisCell += thisMacro;
				thisCell += '<img src="http://www.newco.dev.br/images/infoAmpliadaIconO.gif" class="static"/>';
				thisCell += spanStartClass.replace('#CLASS#', 'tooltiptext');
				thisCell += str_InfoAmpliada + ':<br/><br/>';
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].InfoAmpliada;
				thisCell += spanEnd;
				thisCell += macroEnlaceEnd + '&nbsp;';
			}
			// Documento
			if(typeof arrProductos[ColumnaOrdenadaProds[i]].Documento.ID !== 'undefined'){
				thisMacro = macroEnlaceTarget.replace('#HREF#', 'http://www.newco.dev.br/Documentos/' + arrProductos[ColumnaOrdenadaProds[i]].Documento.Url);
				thisCell += thisMacro;
				thisMacro = macroImagen3.replace('#SRC#', 'http://www.newco.dev.br/images/clipIconO.gif');
				thisMacro = thisMacro.replace('#CLASS#', 'static');
				thisMacro = thisMacro.replace('#ALT#', str_Documento);
				thisMacro = thisMacro.replace('#TITLE#', str_Documento);
				thisCell += thisMacro;
				thisCell += macroEnlaceEnd + '&nbsp;';
			}
			// Anotaciones
			if(arrProductos[ColumnaOrdenadaProds[i]].Anotaciones != ''){
				thisMacro = divStartClass;
				thisMacro = thisMacro.replace('#CLASS#', 'tooltip');
				thisCell += thisMacro;
				thisCell += '<img src="http://www.newco.dev.br/images/infoAmpliadaIconNaraO.gif" class="static"/>';
				thisCell += spanStartClass.replace('#CLASS#', 'tooltiptext');
				thisCell += str_Anotaciones + ':<br/><br/>';
				thisCell += arrProductos[ColumnaOrdenadaProds[i]].Anotaciones;
				thisCell += spanEnd;
				thisCell += macroEnlaceEnd;
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// Celda/Columna Fecha Alta
			thisCell = cellStart + arrProductos[ColumnaOrdenadaProds[i]].FechaAlta + cellEnd;
			thisRow += thisCell;

			// Celda/Columna Fecha Modificacion
			thisCell = cellStart + arrProductos[ColumnaOrdenadaProds[i]].FechaMod + cellEnd;
			thisRow += thisCell;

			// Celda/Columna Ud. Basica
			thisCell = cellStart;
			if(esAutor == 'S'){
				thisMacro	=	macroInputText.replace('#NAME#', 'UDBASICA_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
				thisMacro	=	thisMacro.replace('#ID#', 'UDBASICA_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
				thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].UdBasica);
				thisMacro	=	thisMacro.replace('#CLASS#', 'udbasica peq');
				thisMacro	=	thisMacro.replace('#SIZE#', '15');
				thisMacro	=	thisMacro.replace('#MAXLENGTH#', '100');
				thisCell		+=	thisMacro;
			}else{
				thisCell	+=	arrProductos[ColumnaOrdenadaProds[i]].UdBasica;
			}
			thisCell	+= cellEnd;
			thisRow		+= thisCell;

			// Celda/Columna Precio Historico
			thisCell = cellStart;
			if(mostrarPrecioIVA == 'S'){
				if(esAutor == 'S'){
					thisMacro	=	macroInputText.replace('#NAME#', 'PRECIOREFIVA_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
					thisMacro	=	thisMacro.replace('#ID#', 'PRECIOREFIVA_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
					thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].PrecioHistIVA);
					thisMacro	=	thisMacro.replace('#CLASS#', 'preciorefiva medio');
					thisMacro	=	thisMacro.replace('#SIZE#', '8');
					thisMacro	=	thisMacro.replace('#MAXLENGTH#', '10');
					thisCell	+=	thisMacro;

					thisMacro	=	macroInputHidden.replace('#NAME#', 'PRECIOREF_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
					thisMacro	=	thisMacro.replace('#ID#', 'PRECIOREF_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
					thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].PrecioHist);
					thisMacro	=	thisMacro.replace('#CLASS#', 'precioref medio');
					thisCell	+=	thisMacro;
				}else{
					thisCell	+=	arrProductos[ColumnaOrdenadaProds[i]].PrecioHistIVA;
				}
			}else{
				if(esAutor == 'S'){
					thisMacro	=	macroInputText.replace('#NAME#', 'PRECIOREF_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
					thisMacro	=	thisMacro.replace('#ID#', 'PRECIOREF_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
					thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].PrecioHist);
					thisMacro	=	thisMacro.replace('#CLASS#', 'precioref medio');
					thisMacro	=	thisMacro.replace('#SIZE#', '8');
					thisMacro	=	thisMacro.replace('#MAXLENGTH#', '10');
					thisCell	+=	thisMacro;
				}else{
					thisCell	+=	arrProductos[ColumnaOrdenadaProds[i]].PrecioHist;
				}
			}
			thisCell	+= cellEnd;
			thisRow		+= thisCell;

			// Celda/Columna Precio Objetivo
			thisCell = cellStart;
			if(mostrarPrecioIVA == 'S'){
				if(esAutor == 'S'){
					thisMacro	=	macroInputText.replace('#NAME#', 'PRECIO_OBJIVA_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
					thisMacro	=	thisMacro.replace('#ID#', 'PRECIO_OBJIVA_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
					thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].PrecioObjIVA);
					thisMacro	=	thisMacro.replace('#CLASS#', 'PrecioObjiva medio');
					thisMacro	=	thisMacro.replace('#SIZE#', '8');
					thisMacro	=	thisMacro.replace('#MAXLENGTH#', '10');
					thisCell	+=	thisMacro;

					thisMacro	=	macroInputHidden.replace('#NAME#', 'PRECIO_OBJ_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
					thisMacro	=	thisMacro.replace('#ID#', 'PRECIO_OBJ_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
					thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].PrecioObj);
					thisMacro	=	thisMacro.replace('#CLASS#', 'PrecioObj medio');
					thisCell	+=	thisMacro;
				}else{
					thisCell	+=	arrProductos[ColumnaOrdenadaProds[i]].PrecioObjIVA;
				}
			}else{
				if(esAutor == 'S'){
					thisMacro	=	macroInputText.replace('#NAME#', 'PRECIO_OBJ_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
					thisMacro	=	thisMacro.replace('#ID#', 'PRECIO_OBJ_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
					thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].PrecioObj);
					thisMacro	=	thisMacro.replace('#CLASS#', 'PrecioObj medio');
					thisMacro	=	thisMacro.replace('#SIZE#', '8');
					thisMacro	=	thisMacro.replace('#MAXLENGTH#', '10');
					thisCell	+=	thisMacro;
				}else{
					thisCell	+=	arrProductos[ColumnaOrdenadaProds[i]].PrecioObj;
				}
			}
			thisCell	+= cellEnd;
			thisRow		+= thisCell;

			// Celda/Columna Cantidad
			thisCell = cellStart;
			if((esAutor == 'S')&&(isLicAgregada == 'N')){
				thisMacro	=	macroInputText.replace('#NAME#', 'CANTIDAD_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
				thisMacro	=	thisMacro.replace('#ID#', 'CANTIDAD_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
				thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].Cantidad);
				thisMacro	=	thisMacro.replace('#CLASS#', 'cantidad campopesquisa w80px');
				thisMacro	=	thisMacro.replace('#SIZE#', '6');
				thisMacro	=	thisMacro.replace('#MAXLENGTH#', '8');
				thisCell	+=	thisMacro;
			}else{
				thisCell	+=	arrProductos[ColumnaOrdenadaProds[i]].Cantidad;
				//12ago16	Campo oculto Cantidad
				thisMacro	=	macroInputHidden.replace('#NAME#', 'CANTIDAD_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
				thisMacro	=	thisMacro.replace('#ID#', 'CANTIDAD_' + (arrProductos[ColumnaOrdenadaProds[i]].Linea - 1));
				thisMacro	=	thisMacro.replace('#VALUE#', arrProductos[ColumnaOrdenadaProds[i]].Cantidad);
				thisCell	+=	thisMacro;
			}
			thisCell	+= cellEnd;
			thisRow		+= thisCell;

			// Celda/Columna Consumo y Celda/Columna tipoIVA (si se requiere)
			if(mostrarPrecioIVA == 'S'){
				thisCell = cellStart;
				if(IDPais == '34'){
					thisCell	+= arrProductos[ColumnaOrdenadaProds[i]].TipoIVA + '%';
				}else{
					thisCell	+= '';
				}
				thisCell	+= cellEnd;
				thisRow		+= thisCell;

				thisCell = cellStartClass.replace('#CLASS#', 'consumo') + arrProductos[ColumnaOrdenadaProds[i]].ConsumoHistIVA + cellEnd;
				thisRow		+= thisCell;
			}else{
				thisCell = cellStartClass.replace('#CLASS#', 'consumo') + arrProductos[ColumnaOrdenadaProds[i]].ConsumoHist + cellEnd;
				thisRow		+= thisCell;

				thisCell = cellStart;
				if(IDPais == '34'){
					thisCell	+= arrProductos[ColumnaOrdenadaProds[i]].TipoIVA + '%';
				}else{
					thisCell	+= '';
				}
				thisCell	+= cellEnd;
				thisRow		+= thisCell;
			}

			// Celda/Columna Acciones
			thisCell = cellStart;
			if(esAutor == 'S'){
				functionJS	= 'javascript:modificaProducto(\'' + arrProductos[ColumnaOrdenadaProds[i]].IDProdLic + '\', \'' + arrProductos[ColumnaOrdenadaProds[i]].IDProd + '\', \'' + arrProductos[ColumnaOrdenadaProds[i]].RefEstandar + '\', \'' + arrProductos[ColumnaOrdenadaProds[i]].Nombre + '\', \'' + arrProductos[ColumnaOrdenadaProds[i]].UdBasica + '\', \'' + arrProductos[ColumnaOrdenadaProds[i]].Cantidad + '\', \'' + arrProductos[ColumnaOrdenadaProds[i]].PrecioHist + '\', \'' + arrProductos[ColumnaOrdenadaProds[i]].PrecioObj + '\', \'' + arrProductos[ColumnaOrdenadaProds[i]].TipoIVA + '\', \'B\')';
				thisMacro	= macroEnlaceAcc.replace('#CLASS#', 'accBorrar');
				thisMacro	= thisMacro.replace('#HREF#', functionJS);
				thisCell	+= thisMacro;
				thisCell	+= '<img src="http://www.newco.dev.br/images/2022/icones/del.svg" alt="' + str_borrar + '" title="' + str_borrar + '"/>'
				thisCell	+= macroEnlaceEnd;
			}else{
				thisCell	+= '';
			}
			thisCell	+= cellEnd;
			thisRow		+= thisCell;


			thisRow += rowEnd;
			htmlTBODY += thisRow;
		}

		dibujarFilaConsumoProdEST();
		calcularPaginacion();
	}else{
		htmlTBODY = "<tr><td colspan=\"13\" align=\"center\"><strong>" + str_licSinProductos + "</strong></td></tr>";
	}

	jQuery('#lProductos_EST tbody').empty().append(htmlTBODY);

	// Ahora recalculamos los valores del floatinBox
	//PENDIENET!!!	if(jQuery(".FBox").length)
	//PENDIENET!!!		calcularFloatingBox_EST();
}

function seleccionarPreciosProveedor(columna){
	var MejorOfertaID;
	var posArr = columna - 1;

	jQuery.each(arrProductos, function(key, producto){
		if(producto.Ofertas[posArr].NoInformada != 'S' && producto.Ofertas[posArr].NoOfertada != 'S'){
//			debug(producto.Ofertas[posArr].IDOferta + ': yes, key: ' + key);
			MejorOfertaID = producto.Ofertas[posArr].ID;		//21set16	.IDOferta;
			// Una vez tengo el mejor precio y su IDOferta, busco el radio button que toca
			var radioAux = document.getElementsByName('RADIO_' + key);

			for(var j = 0; j < radioAux.length; j++){
				if(radioAux[j].value == MejorOfertaID){
					radioAux[j].checked = true;
					// Ahora lanzamos la funcion para que recalcule el div flotante
					recalcularFloatingBox(radioAux[j], 0);
				}
			}
		}
	});

	validarPedidosMinimosDOM();
}

function ordenacionInformado(tipo){
	filtroNombre	= '';
	jQuery('#filtroProductos').val('');

	jQuery.each(arrProductos, function(key, producto){
		if(tipo == 'EST'){
			if(producto.UdBasica == ''){
				producto.Ordenacion = '0';
			}else{
				producto.Ordenacion = '1';
			}
		}else if(tipo == 'PROV'){
			if(producto.Oferta.Informada == 'N'){
				producto.Ordenacion = '0';
			}else{
				if(producto.Oferta.RefProv.toUpperCase() == 'SIN OFERTAR'){
					producto.Ordenacion = '1';
				}else{
					producto.Ordenacion = '2';
				}
			}
		}else if(tipo == 'OFE'){
			if(producto.TieneSeleccion == 'N' && producto.NoAdjudicado == 'N'){	// Todavia no se ha guardado ninguna seleccion
				producto.Ordenacion = '0';
			}else{
				producto.Ordenacion = '1';
			}
		}
	});

	OrdenarProdsPorColumna('Ordenacion');
}

//	Ordena tabla productos por una columna
function OrdenarProdsPorColumna(col, flag){
	flag   = (typeof flag === "undefined") ? false : flag;
	col = (col=='')?ColumnaOrdenacionProds:col;			//18mar19	Valor por defecto
	
	//solodebug	debug('OrdenarProdsPorColumna:'+col);

	if(flag !== true){
		if(ColumnaOrdenacionProds == col && col != 'Ordenacion')
		{
			if(OrdenProds == 'ASC')
			{
				OrdenProds = 'DESC';
        	}else{
				OrdenProds = 'ASC';
        	}
		}
		else
		{
			ColumnaOrdenacionProds = col;
			OrdenProds = 'ASC';
		}
    }


//	if(col == 'Consumo' || col == 'ConsumoIVA' || col == 'ConsumoHist' || col == 'ConsumoHistIVA' || col == 'NumOfertas' || col == 'ConsumoOferta' || col == 'Ordenacion'){
	//	Si la columna es string, ordenamiento alfabetico
	if(col == 'NombreNorm' || col == 'RefCliente'){
		ordenamientoAlfabet(col, OrdenProds);
	//	Si la columna es numerica, ordenamiento burbuja
	}else{
		ordenamientoBurbuja(col, OrdenProds);
	}

	dibujaTablaProductos();
}

//	Prepara un array con los ordenes correspondientes a una columna de numeros
function ordenamientoBurbuja(col, tipo){
	var temp, temp2, size, valAux, posArr, column = '';
	var arrValores = new Array();

	if(col.indexOf("PrecioProvIVA") >= 0){
		column = 'PrecioIVA';
		posArr = col.replace("PrecioProvIVA_", "") - 1;
	}else if(col.indexOf("PrecioProv") >= 0){
		column = 'Precio';
		posArr = col.replace("PrecioProv_", "") - 1;
	}else if(col.indexOf("ConsProvIVA") >= 0){
		column = 'ConsumoIVA';
		posArr = col.replace("ConsProvIVA_", "") - 1;
	}else if(col.indexOf("ConsProv") >= 0){
		column = 'Consumo';
		posArr = col.replace("ConsProv_", "") - 1;
	}else if(col.indexOf("AhorProv") >= 0){
		column = 'Ahorro';
		posArr = col.replace("AhorProv_", "") - 1;
	}
		
	//solodebug	debug('ordenamientoBurbuja. column:'+column+' posArr:'+posArr);

	// Creamos un vector auxiliar con los valores que queremos ordenar (segun el vector de ordenacion)
	for(var i=0; i<totalProductos; i++){
		if(column != ''){
			if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[posArr].NoInformada == 'S'){
				valAux = -2;
			}else if(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[posArr].NoOfertada == 'S'){
				valAux = -1;
			}else{
				valAux = (desformateaDivisa(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[posArr][column]) != '') ? desformateaDivisa(arrProductos[ColumnaOrdenadaProds[i]].Ofertas[posArr][column]) : '0';
			}
//                }else if(column == 'Precio'){
//			valAux = (arrProductos[ColumnaOrdenadaProds[i]].Ofertas[posArr].PRECIO.replace(/\./g,'').replace(',','.') != '') ? arrProductos[ColumnaOrdenadaProds[i]].Ofertas[posArr].PRECIO.replace(/\./g,'').replace(',','.') : '0';
		}else{
			
			
			//solodebug	debug('ordenamientoBurbuja. i:'+i+' arrProductos[ColumnaOrdenadaProds[i]][col]: ('+arrProductos[ColumnaOrdenadaProds[i]][col]+')');
			
			if (Number.isInteger(arrProductos[ColumnaOrdenadaProds[i]][col]))
				valAux = arrProductos[ColumnaOrdenadaProds[i]][col];
			else
				valAux = (desformateaDivisa(arrProductos[ColumnaOrdenadaProds[i]][col]) != '') ? desformateaDivisa(arrProductos[ColumnaOrdenadaProds[i]][col]) : '0';
		}
		
		//solodebug	debug('ordenamientoBurbuja ('+i+'):'+valAux);
		
		arrValores.push(parseFloat(valAux));
	}

	size = totalProductos;
	for(var pass = 1; pass < size; pass++){ // outer loop
		for(var left = 0; left < (size - pass); left++){ // inner loop
			var right = left + 1;

			// Comparamos valores del vector auxiliar
			if(arrValores[left] > arrValores[right]){

				//solodebug	debug('ordenamientoBurbuja. Intercambiar:'+arrValores[left] +'>'+ arrValores[right]);
				
				// Intercambiamos valores del vector auxiliar y del vector de ordenacion, ya este ultimo es el que queremos ordenar y estan relacionados
				temp=ColumnaOrdenadaProds[left];
				temp2=arrValores[left];
				ColumnaOrdenadaProds[left]=ColumnaOrdenadaProds[right];
				arrValores[left]=arrValores[right];
				ColumnaOrdenadaProds[right]=temp;
				arrValores[right]=temp2;
		
			}
		}
	}

	//	En caso de ordenacion descendiente intercambiamos de forma simetrica el vector de ordenacion
	if(tipo=='DESC'){
		for(i=1; i<=totalProductos/2; i++){
			temp=ColumnaOrdenadaProds[totalProductos-i];
			ColumnaOrdenadaProds[totalProductos-i]=ColumnaOrdenadaProds[i-1];
			ColumnaOrdenadaProds[i-1]=temp;
		}
	}


	
	//solodebug
	//solodebugfor(var i=0; i<totalProductos; i++)
	//solodebug{
	//solodebug	debug('ordenamientoBurbuja fin ('+i+'). Pos:'+ColumnaOrdenadaProds[i]+' val:'+arrValores[i]);
	//solodebug}

}

//	Prepara un array con los ordenes correspondientes a una columna de caracteres alfanumericos
function ordenamientoAlfabet(col, tipo){
	var temp, temp2, size, valAux;
	var arrValores = new Array();
	
	var fila;

	// Creamos un vector auxiliar con los valores que queremos ordenar (segun el vector de ordenacion)
	for(var i=0; i<totalProductos; i++)
	{

		fila=i;
		ColumnaOrdenadaProds[i]=i;
	
		// Si ordenamos por referencia puede que tengamos que ordenar por RefCliente o RefEstandar para cada producto
		if(col == 'RefCliente')
		{
			valAux = (arrProductos[fila][col] != '') ? arrProductos[fila][col] : arrProductos[fila]['RefEstandar'] ;
		}
		else
		{
			try
			{
				valAux = arrProductos[fila][col];
			}
			catch(err)
			{
				debug('ordenamientoAlfabet,tipo:'+tipo+' no se ha encontrado valor en fila '+i+' ColOrd:'+fila+' columna:'+col);
				valAux = 'PRUEBA';
			}
		}

		//solodebug	debug('ordenamientoAlfabet('+col+', '+tipo+'). INICIO. pos:'+i+' val:'+ColumnaOrdenadaProds[i]+ ' valAux:'+valAux);

		arrValores.push(valAux);
	}


	if (totalProductos>1)	//4may22 Solo pasamos el algoritmo si es mas de 1 producto
	{
		size = totalProductos;
		for(var pass = 1; pass < size; pass++){ // outer loop
			for(var left = 0; left < (size - pass); left++){ // inner loop
				var right = left + 1;

				// Comparamos valores del vector auxiliar
				if(arrValores[left] > arrValores[right]){
					// Intercambiamos valores del vector auxiliar y del vector de ordenacion, ya este ultimo es el que queremos ordenar y estan relacionados
					temp=ColumnaOrdenadaProds[left];
					temp2=arrValores[left];
					ColumnaOrdenadaProds[left]=ColumnaOrdenadaProds[right];
					arrValores[left]=arrValores[right];
					ColumnaOrdenadaProds[right]=temp;
					arrValores[right]=temp2;
				}
			}
		}

		//	En caso de ordenacion descendiente intercambiamos de forma simetrica el vector de ordenacion
		if(tipo=='DESC'){
			for(i=1; i<=totalProductos/2; i++){
				temp=ColumnaOrdenadaProds[totalProductos-i];
				ColumnaOrdenadaProds[totalProductos-i]=ColumnaOrdenadaProds[i-1];
				ColumnaOrdenadaProds[i-1]=temp;
			}
		}
	}
	
	//solodebug	for(i=0; i<totalProductos; i++)	debug('ordenamientoAlfabet('+col+', '+tipo+'). FINAL. pos:'+i+' val:'+ColumnaOrdenadaProds[i]);
	
}


function filtrarProductosBeforeAjax(){
	var cadena = jQuery('#filtroProductos').val();

	normalizarString(cadena, filtrarProductosAfterAjax);
}

function filtrarProductosAfterAjax(cadenaNorm){
	ProductExist = false;
	if(cadenaNorm != ''){
		filtroNombre = cadenaNorm;

		jQuery.each(arrProductos, function(key, producto){
			if(producto.NombreNorm.indexOf(filtroNombre) > -1){
				producto.Ordenacion = '0';
				ProductExist = true;
			}else{
				producto.Ordenacion = '1';
			}
		});

		OrdenarProdsPorColumna('Ordenacion');
	}
}

function NombreProductoConEstilo(pos){
	var ini = arrProductos[ColumnaOrdenadaProds[pos]].NombreNorm.indexOf(filtroNombre);
	if(ini > -1  && filtroNombre != '' && ColumnaOrdenacionProds == 'Ordenacion'){
		var length	= filtroNombre.length;
		var nombre	= arrProductos[ColumnaOrdenadaProds[pos]].Nombre.substr(0, ini);
			nombre	+= '<span style="background-color:yellow;">';
			nombre	+= arrProductos[ColumnaOrdenadaProds[pos]].Nombre.substr(ini, length);
			nombre	+= '</span>';
			nombre	+= arrProductos[ColumnaOrdenadaProds[pos]].Nombre.substr(ini + length);
		return nombre;
	}else{
		return arrProductos[ColumnaOrdenadaProds[pos]].Nombre;
	}
}

function triggerFB(flag){
	if(flag){
		jQuery("#floatingBoxMin").hide();
		jQuery("#floatingBox").show();
	}else{
		jQuery("#floatingBox").hide();
		jQuery("#floatingBoxMin").show();
	}
}

function dibujarFilaConsumoProdOFE(){
	var htmlTFOOT = '', consumoTotalHist = 0, consumoTotalObj = 0, campo, valAux;

	if(mostrarPrecioIVA == 'S'){
		consumoTotalHist	= objLicitacion['ConsHistIVA'];
		consumoTotalObj		= objLicitacion['ConsumoIVA'];
	}else{
		consumoTotalHist	= objLicitacion['ConsHist'];
		consumoTotalObj		= objLicitacion['Consumo'];
	}

	htmlTFOOT = '<tfoot class="rodape_tabela">';
	htmlTFOOT += rowStartStyle.replace('#STYLE#', 'border-top:1px solid #999;height:30px;');
	htmlTFOOT += cellStart + cellEnd;
	htmlTFOOT += cellStartColspanCls.replace('#COLSPAN#', '4').replace('#CLASS#', 'centerDiv');
	if((EstadoLic == 'CURS' || EstadoLic == 'INF')){
		htmlTFOOT += '<strong>' + str_PorcNegociado + ':&nbsp' + objLicitacion['PorcConsNeg'] + '&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;' + str_PorcAhorro + ':&nbsp' + objLicitacion['AhorMejPrecio'] + '</strong>';
	}else{
		htmlTFOOT += '<strong>' + str_PorcNegociado + ':&nbsp' + objLicitacion['PorcConsNeg'] + '&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;' + str_PorcAhorro + ':&nbsp' + objLicitacion['Ahorro'] + '</strong>';
	}
	htmlTFOOT += cellEnd;

	htmlTFOOT += cellStartStyle.replace('#STYLE#', 'text-align:right;padding:5px 0px;');
	htmlTFOOT += '<strong>';
	if(mostrarPrecioIVA == 'S'){
		htmlTFOOT += str_TotalConsCIVA;
	}else{
		htmlTFOOT += str_TotalConsSIVA;
	}
	htmlTFOOT += ':&nbsp;</strong>';
	htmlTFOOT += cellEnd;

	htmlTFOOT += cellStartClass.replace('#CLASS#', 'textRight');
	htmlTFOOT += '<strong>' + consumoTotalHist + '&nbsp;</strong>';
	htmlTFOOT += cellEnd;

	htmlTFOOT += cellStartClass.replace('#CLASS#', 'textRight');
	htmlTFOOT += '<strong>' + consumoTotalObj + '&nbsp;</strong>';
	htmlTFOOT += cellEnd;

	htmlTFOOT += cellStartColspan.replace('#COLSPAN#', '4') + cellEnd;

	for(var i=0; i<NumProvsOfertas; i++){
	
		if (arrProveedores[i].TieneOfertas=='S'){	//	COmprueba proveedor con ofertas /Mantenimiento/LICITACION/PRODUCTOSLICITACION/PROVEEDORESLICITACION/PROVEEDOR/TIENE_OFERTAS

			htmlTFOOT += cellStartClass.replace('#CLASS#', 'borderLeft');
			htmlTFOOT += cellEnd;

			htmlTFOOT += cellStartClass.replace('#CLASS#', 'colPrecio');
			htmlTFOOT += cellEnd;

			if(mostrarPrecioIVA == 'S'){
				if(arrProveedores[i].ConsumoIVA != '0,00' && arrProveedores[i].ConsumoIVA != ''){
					htmlTFOOT += cellStartClassStyle.replace('#CLASS#', 'textRight colConsumo');
					htmlTFOOT = htmlTFOOT.replace('#STYLE#', 'display:none;');
					if((EstadoLic == 'CURS' || EstadoLic == 'INF')){
						htmlTFOOT += '<strong>' + arrProveedores[i].ConsumoIVA + '&nbsp;</strong>';
					}else{
						htmlTFOOT += '<strong>' + arrProveedores[i].ConsumoAdjIVA + '&nbsp;</strong>';
					}
					htmlTFOOT += cellEnd;

					htmlTFOOT += cellStartClassStyle.replace('#CLASS#', 'textRight colAhorro');
					htmlTFOOT = htmlTFOOT.replace('#STYLE#', 'display:none;');
					htmlTFOOT += '<strong>';
					if(arrProveedores[i].ConsumoPotIVA != '0,00' && arrProveedores[i].ConsumoPotIVA != ''){
						htmlTFOOT += arrProveedores[i].AhorroIVA + '%&nbsp;';
					}else{
						htmlTFOOT += '&nbsp;';
					}
					htmlTFOOT += '&nbsp;</strong>';
					htmlTFOOT += cellEnd;
				}else{
	//				htmlTFOOT += cellStartColspan.replace('#COLSPAN#', '2') + cellEnd;

					htmlTFOOT += cellStartClassStyle.replace('#CLASS#', 'colConsumo').replace('#STYLE#', 'display:none;');
					htmlTFOOT += cellEnd;
					htmlTFOOT += cellStartClassStyle.replace('#CLASS#', 'colAhorro').replace('#STYLE#', 'display:none;');
					htmlTFOOT += cellEnd;
				}
			}else{
				if(arrProveedores[i].Consumo != '0,00' && arrProveedores[i].Consumo != ''){
					htmlTFOOT += cellStartClassStyle.replace('#CLASS#', 'textRight colConsumo');
					htmlTFOOT = htmlTFOOT.replace('#STYLE#', 'display:none;');
					if((EstadoLic == 'CURS' || EstadoLic == 'INF')){
						htmlTFOOT += '<strong>' + arrProveedores[i].Consumo + '&nbsp;</strong>';
					}else{
						htmlTFOOT += '<strong>' + arrProveedores[i].ConsumoAdj + '&nbsp;</strong>';
					}
					htmlTFOOT += cellEnd;

					htmlTFOOT += cellStartClassStyle.replace('#CLASS#', 'textRight colAhorro');
					htmlTFOOT = htmlTFOOT.replace('#STYLE#', 'display:none;');
					htmlTFOOT += '<strong>';
					if(arrProveedores[i].ConsumoPot != '0,00' && arrProveedores[i].ConsumoPot != ''){
						htmlTFOOT += arrProveedores[i].Ahorro + '%&nbsp;';
					}else{
						htmlTFOOT += '&nbsp;';
					}
					htmlTFOOT += '&nbsp;</strong>';
					htmlTFOOT += cellEnd;
				}else{
	//				htmlTFOOT += cellStartColspan.replace('#COLSPAN#', '2') + cellEnd;

					htmlTFOOT += cellStartClassStyle.replace('#CLASS#', 'colConsumo').replace('#STYLE#', 'display:none;');
					htmlTFOOT += cellEnd;
					htmlTFOOT += cellStartClassStyle.replace('#CLASS#', 'colAhorro').replace('#STYLE#', 'display:none;');
					htmlTFOOT += cellEnd;
				}
			}
	//		htmlTFOOT += cellStartColspan.replace('#COLSPAN#', '2') + cellEnd;
		}
		htmlTFOOT += cellStartClassStyle.replace('#CLASS#', 'colEval').replace('#STYLE#', 'display:none;');
		htmlTFOOT += cellEnd;
		htmlTFOOT += cellStartClassStyle.replace('#CLASS#', 'colInfo').replace('#STYLE#', 'display:none;');
		htmlTFOOT += cellEnd;
	}

	htmlTFOOT += rowEnd;
	htmlTFOOT += '</tfoot>';

	jQuery('#lProductos_OFE').append(htmlTFOOT);
}

function calcularPaginacion(){
	var pagAnterior, pagSiguiente;
	var innerHTML = '';

	// Pagina anterior
	if(firstProduct != 0){
		pagAnterior = pagProductos - 1;
	}

	// Pagina siguiente
	if(lastProduct != totalProductos){
		pagSiguiente = pagProductos + 1;
	}

	// Info Pagina actual
	if(pagAnterior !== undefined){
		innerHTML = '<a class="btnNormal" style="text-decoration:none;font-size:11px;" href="javascript:paginacion(' + pagAnterior + ');">' + str_PagAnterior + '</a>';
		if(jQuery('#topPesProds').length)		jQuery('#topPesProds #pagAnterior').html(innerHTML);
		if(jQuery('#botPesProds').length)		jQuery('#botPesProds #pagAnterior').html(innerHTML);
	}else{
		if(jQuery('#topPesProds').length)		jQuery('#topPesProds #pagAnterior').html('');
		if(jQuery('#botPesProds').length)		jQuery('#botPesProds #pagAnterior').html('');
	}

	if(pagSiguiente !== undefined){
		innerHTML = '<a class="btnNormal" style="width:20px;text-align:right;padding-left:0px;text-decoration:none;font-size:11px;" href="javascript:paginacion(' + pagSiguiente + ');">' + str_PagSiguiente + '</a>';
		if(jQuery('#topPesProds').length)		jQuery('#topPesProds #pagSiguiente').html(innerHTML);
		if(jQuery('#botPesProds').length)		jQuery('#botPesProds #pagSiguiente').html(innerHTML);
	}else{
		if(jQuery('#topPesProds').length)		jQuery('#topPesProds #pagSiguiente').html('');
		if(jQuery('#botPesProds').length)		jQuery('#botPesProds #pagSiguiente').html('');
	}

	innerHTML = str_Paginacion.replace('[[PAGACTUAL]]', (pagProductos + 1)).replace('[[PAGTOTAL]]', pagsProdTotal).replace('[[TOTALPRODUCTOS]]', totalProductos);
	jQuery('#paginacion').html(innerHTML);

	if(rol == 'VENDEDOR'){
		if(pagsProdTotal > 1){
			if(jQuery('#topPesProds').length){
				jQuery('#topPesProds').css('border', '2px solid red');
				jQuery('#topPesProds div').css('background-color', '#FFFF99');
				jQuery('#topPesProds #pagAnterior a').css('color', 'red');
				jQuery('#topPesProds #pagSiguiente a').css('color', 'red');
			}
			if(jQuery('#botPesProds').length){
				jQuery('#botPesProds').css('border', '2px solid red');
				jQuery('#botPesProds div').css('background-color', '#FFFF99');
				jQuery('#botPesProds #pagAnterior a').css('color', 'red');
				jQuery('#botPesProds #pagSiguiente a').css('color', 'red');
			}
		}else{
			if(jQuery('#topPesProds').length){
				jQuery('#topPesProds').css('border', '1px solid #999');
				jQuery('#topPesProds div').css('background-color', 'rgba(0, 0, 0, 0)');
			}
			if(jQuery('#botPesProds').length){
				jQuery('#botPesProds').css('border', '1px solid #999');
				jQuery('#botPesProds div').css('background-color', 'rgba(0, 0, 0, 0)');
			}
		}
	}
}

function paginacion(numPag){
	var chk = true;

	// Si hay cambios en el formulario, pedimos confirmacion
	if(anyChange){
		chk = confirm(conf_hayCambios);
	}

	if(chk){
		if(jQuery('#MensActualizarOfertas').length){
			jQuery('#MensActualizarOfertas').hide();
		}
		pagProductos = numPag;
		dibujaTablaProductos();
	}
}


// Funcion que muestra o esconde las columnas de la tabla 'productos' segun el tipo de vista escogido (solo en tabla productos + ofertas)
function muestraNuevaVistaProductos(tipoVista){
	if(tipoVista == 'SP'){
		// Cambiamos el colspan de las celdas
		jQuery(".colNomProv").attr('colspan',2);
		jQuery(".colSinOferta").attr('colspan',2);

		jQuery(".colPrecio").show().removeClass( "borderLeft" );
		jQuery(".colConsumo").hide();
		jQuery(".colAhorro").hide();
		jQuery(".colEval").hide();
		jQuery(".colInfo").hide();
	}else if(tipoVista == 'SC'){
		// Cambiamos el colspan de las celdas
		jQuery(".colNomProv").attr('colspan',2);
		jQuery(".colSinOferta").attr('colspan',2);

		jQuery(".colPrecio").hide();
		jQuery(".colConsumo").show().removeClass( "borderLeft" );
		jQuery(".colAhorro").hide();
		jQuery(".colEval").hide();
		jQuery(".colInfo").hide();
	}else if(tipoVista == 'SA'){
		// Cambiamos el colspan de las celdas
		jQuery(".colNomProv").attr('colspan',2);
		jQuery(".colSinOferta").attr('colspan',2);

		jQuery(".colPrecio").hide();
		jQuery(".colConsumo").hide();
		jQuery(".colAhorro").show().removeClass( "borderLeft" );
		jQuery(".colEval").hide();
		jQuery(".colInfo").hide();
	}else if(tipoVista == 'PC'){
		// Cambiamos el colspan de las celdas
		jQuery(".colNomProv").attr('colspan',3);
		jQuery(".colSinOferta").attr('colspan',3);

		jQuery(".colPrecio").show().removeClass( "borderLeft" );
		jQuery(".colConsumo").show().addClass( "borderLeft" );
		jQuery(".colAhorro").hide();
		jQuery(".colEval").hide();
		jQuery(".colInfo").hide();
	}else if(tipoVista == 'PCA'){
		// Cambiamos el colspan de las celdas
		jQuery(".colNomProv").attr('colspan',4);
		jQuery(".colSinOferta").attr('colspan',4);

		jQuery(".colPrecio").show().removeClass( "borderLeft" );
		jQuery(".colConsumo").show().addClass( "borderLeft" );
		jQuery(".colAhorro").show().addClass( "borderLeft" );
		jQuery(".colEval").hide();
		jQuery(".colInfo").hide();
	}else if(tipoVista == 'PCAE'){
		// Cambiamos el colspan de las celdas
		jQuery(".colNomProv").attr('colspan',5);
		jQuery(".colSinOferta").attr('colspan',5);

		jQuery(".colPrecio").show().removeClass( "borderLeft" );
		jQuery(".colConsumo").show().addClass( "borderLeft" );
		jQuery(".colAhorro").show().addClass( "borderLeft" );
		jQuery(".colEval").show().addClass( "borderLeft" );
		jQuery(".colInfo").hide();
	}else if(tipoVista == 'PIC'){
		// Cambiamos el colspan de las celdas
		jQuery(".colNomProv").attr('colspan',3);
		jQuery(".colSinOferta").attr('colspan',3);

		jQuery(".colPrecio").show().removeClass( "borderLeft" );
		jQuery(".colConsumo").hide();
		jQuery(".colAhorro").hide();
		jQuery(".colEval").hide();
		jQuery(".colInfo").show();
	}
}


// Funcion que devuelve un fichero excel con detalles de la licitacion
function listadoExcel(IDProvLic){
	var d = new Date();
	IDProvLic   = (typeof IDProvLic === "undefined") ? '' : IDProvLic;

	jQuery.ajax({
		url:	"http://www.newco.dev.br/Gestion/Comercial/LicitacionesExcel.xsql",
		data:	"IDLIC="+IDLicitacion+"&IDPROVEEDORLIC="+IDProvLic+"&_="+d.getTime(),

		type:	"GET",
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			null;
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.estado == 'ok')
				window.location='http://www.newco.dev.br/Descargas/'+data.url;
			else
				alert(alrt_errorDescargaFichero);
		}
	});
}



// Funcion para colorear la celda que tiene el mejor precio
function MarcarMejoresPrecios(){
	var MejorPrecio, MejorColumna, valAux;

	if(rol == 'COMPRADOR' && (EstadoLic == 'CURS' || EstadoLic == 'INF')){

		// Para cada uno de los indices de arrProductos
		jQuery.each(arrProductos, function(key, producto){
			MejorPrecio	= -1;
			MejorColumna	= -1;

			jQuery.each(producto['Ofertas'], function(key2, oferta){
				valAux = (oferta.PRECIO != '') ? desformateaDivisa(oferta.PRECIO) : '';

				if(valAux != '' && (MejorPrecio < 0 || MejorPrecio > valAux)){
					MejorPrecio	= valAux;
					MejorColumna= oferta.columna;
				}
			});

			if(MejorColumna != -1){
				jQuery("table#lProductos_OFE tbody tr#posArr_" + key + " td#arrProd-" + key + "_arrProvOfr-" + (MejorColumna - 1)).addClass("mejorPrecio");
			}
		});
	}
}

// Funcion para seleccionar automaticamente los radio buttons con los mejores precios
function SeleccionarMejoresPrecios(){
	var MejorPrecio, MejorColumna, MejorOfertaID, valAux;

	// Marcamos el flag de control como que se han hecho nuevos cambios en el formulario
	anyChange = true;
	jQuery('#botonSelecMejPrecios').hide();

	jQuery.each(arrProductos, function(key, producto){
		MejorPrecio	= -1;
		MejorColumna	= -1;

		jQuery.each(producto['Ofertas'], function(key2, oferta){
			valAux = (oferta.PRECIO != '') ? desformateaDivisa(oferta.PRECIO) : '';

			if(valAux != '' && (MejorPrecio < 0 || MejorPrecio > valAux)){
				MejorPrecio	= valAux;
				MejorColumna	= key2;
			}
		});

		if(MejorColumna != -1){
			MejorOfertaID = arrProductos[key].Ofertas[MejorColumna].ID;	//21set16	.IDOferta
        }

		// Una vez tengo el mejor precio y su IDOferta, busco el radio button que toca
		var radioAux = document.getElementsByName('RADIO_' + key);

		for(var j = 0; j < radioAux.length; j++){
			if(radioAux[j].value == MejorOfertaID){
				radioAux[j].checked = true;
				// Ahora lanzamos la funcion para que recalcule el div flotante
				recalcularFloatingBox(radioAux[j], 0);
			}
		}
	});

	// Validamos pedidos minimos para mostrar/ocultar el aviso de pedido minimo por proveedores
	validarPedidosMinimosDOM();

	jQuery('#botonSelecMejPrecios').show();
}

//	Activa el botón de "adjudicar" cuando corresponda
function validarBotonAdjudicar(){
	var productosOlvidados;	//	21set16	Por ahora hacemos un control local
	
	//	21set16	Hacemos aqui las comprobaciones básicas que pueden dar lugar a errores antes de adjudicar
	if (((arrProductos.length>numProductos) && (numProdsSeleccion<numProductos))||(numProdsSeleccion==0)) {
		productosOlvidados = 'S';
	}
	else{
		productosOlvidados = 'N';
	}


	if(productosOlvidados == 'N'){
		jQuery('#botonAdjudicarSelec a').removeClass("grey");
	}
}

//	29may19 Busca el número de proveedores adjudicados
function ProveedoresAdjudicados()
{
	var ProvAdjud=0;

	for (var i=0;i<arrProveedores.length;++i)
	{
		if (arrProveedores[i].OfertasAdj>0) ++ProvAdjud;
	}
		
	return ProvAdjud;
}



/*
	PEDIDOS MINIMOS
*/

//	Recuperando datos desde DOM
function validarPedidosMinimosDOM(){
	var arrConsumos	= new Array(arrProveedores.length);
	var arrPedsMin	= new Array(arrProveedores.length);
	var errPedMin = false, numOfertas = 0;

	//Inicializamos dos arrays:
		// arrConsumos - contador de consumos por proveedor segun ofertas seleccionadas
		// arrPedsMin - donde guardamos el valor del pedido minimo segun proveedor
	for(var i=0; i<arrProveedores.length; i++){
		arrConsumos[i]	= 0;
		arrPedsMin[i]	= parseFloat(arrProveedores[i].PedidoMin.replace(".","").replace(",","."));
	}

	// Recorremos el array de productos entero
	jQuery.each(arrProductos, function(key, producto){
		// Si el producto en cuestion se muestra por pantalla, recuperamos los datos del radio button del DOM
		if(jQuery("tr#posArr_" + key).length){
			// Recorremos los N radio buttons del producto en cuestion para encontrar el que pertenece al proveedor que tiene la oferta
			jQuery(".RADIO_" + key).each(function(key2, thisRadio){
				if(jQuery(thisRadio).is(':checked')){ // Si esta checked, entonces sumamos el consumo en la posicion del array que toca
					numOfertas++;
					
					var thisPos = jQuery("#Prov_" + thisRadio.value).val();			//esto devuelve un número de columna
										
					//solodebug		debug ('validarPedidosMinimosDOM. IDPROVEEDOR:'+thisRadio.value+ ' thisPos:'+thisPos);
					
					try
					{
						arrConsumos[thisPos] += parseFloat(producto.Ofertas[thisPos].Consumo.replace(".","").replace(",","."));
					}
					catch(e)
					{
						debug('validarPedidosMinimosDOM. thisPos:'+thisPos+' error:'+e);
					}
					
					return false;
				}
			});
		// Si el producto en cuestion NO se muestra por pantalla, recuperamos los datos del propio objeto JS
		}else{

			jQuery.each(producto.Ofertas, function(key2, oferta){
				if(producto.Ofertas[key2].OfertaAdjud == 'S'){
					numOfertas++;
					arrConsumos[key2] += parseFloat(producto.Ofertas[key2].Consumo.replace(".","").replace(",","."));
					return false;
				}
			});
		}
	});

	// Ahora recorremos de nuevo el array para mostrar/ocultar la imagen de aviso segun la validacion de pedido minimo
	for(i=0; i<arrProveedores.length; i++){
		if(arrPedsMin[i] > arrConsumos[i] && arrConsumos[i] != 0){
			errPedMin = true;
			jQuery("#avisoProv_" + parseInt(i + 1)).show();
		}else{
			jQuery("#avisoProv_" + parseInt(i + 1)).hide();
		}
	}

	// Si existe alguna seleccion que no cumple el pedido minimo mostramos icono aviso en el floatingBox
	if(!errPedMin && numOfertas == arrProductos.length){
		jQuery('#FBAviso').html('&nbsp;<img src="http://www.newco.dev.br/images/check.gif" style="vertical-align:text-bottom;"/>');
	}else{
		jQuery('#FBAviso').html('&nbsp;<img src="http://www.newco.dev.br/images/atencion.gif" style="vertical-align:text-bottom;"/>');
	}
}


//	5set16	En el caso de licitación agregada, resulta complicado el cálculo del pedido minimo. Hacemos petición ajax al servidor para comprobarlo.
function validarPedidosMinimosAgr(){

	var d = new Date();
	var Result;

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/licComprobarPedidoMinimoAJAX.xsql',
		type:	"POST",
		async:	false,
		data:	"LIC_ID="+IDLicitacion+"&_="+d.getTime(),
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
			
			Result = 'N';
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);
			
			Result = (data.CumplePedidoMinimo=='S')?true:false;

		}
	});

	return Result;
}


function validarPedidosMinimos(option){
	var arrPedMin		= {};
	var arrProvTotal	= {};
	var arrProvNom		= {};

	jQuery.each(arrProveedores, function(key, proveedor){
		arrProvNom[key] = proveedor.NombreCorto;
		arrPedMin[key] = proveedor.PedidoMin;
		arrProvTotal[key] = 0;
	});

	var Cantidad, CantidadFormato, PrecioOferta, PrecioOfertaFormato;

	jQuery.each(arrProductos, function(key, producto){
		jQuery.each(producto.Ofertas, function(key2, oferta){
			if(oferta.OfertaAdjud == 'S'){
				Cantidad		= producto.Cantidad;
				CantidadFormato		= Cantidad.replace(".","").replace(",",".");
//				(mostrarPrecioIVA == 'S') ? PrecioOferta = oferta.PRECIOIVA : PrecioOferta = oferta.PRECIO;
				PrecioOferta = oferta.PRECIO;
				PrecioOfertaFormato	= PrecioOferta.replace(".","").replace(",",".");

        arrProvTotal[key2] += CantidadFormato * PrecioOfertaFormato;
			}
		});
	});

	var error = false, msg = '', importePedido, pedidoMinimo;

	jQuery.each(arrProvTotal, function(key, value){
		if(value > 0 && value < arrPedMin[key].replace(".","").replace(",",".")){
			error = true;
			importePedido	= FormatoNumero(value.toFixed(2));
			pedidoMinimo	= arrPedMin[key];
			msg += alrt_pedidoMinimoKO.replace('[[IMP_PEDIDO]]',importePedido).replace('[[PROV_NOMBRE]]',arrProvNom[key]).replace('[[PED_MINIMO]]',pedidoMinimo)+'\n';
			if(option == 2){
				jQuery("#avisoProv_" + (parseInt(key) + 1)).show();
			}
		}
	});

	if(error)
	{
		if(option == 1)
		{
			if (saltarPedMinimo=='N')
				alert(msg);
			else
				error=!confirm(msg+'\n'+alrt_avisoSaltarPedidoMinimo);
		}
  	}
	
	//solodebug debug('validarPedidosMinimos error:'+error);
	
	return !error;
}





/*
	FLOATING BOX
*/

//	29may19 inicializa los campos necesarios para el Floating Box
function inicializaFloatingBox()
{
	//solodebug	debug("inicializaFloatingBox. INICIO. NumProductos:"+arrProductos.length);

	ConsumoPot=0;ConsumoPrev=0;NumOfertas=0;numProdConOfe=0;numProdsAdjud=0;Ahorro=0;
	
	//	Recorre la matriz de productos
	for(var j=0;j<arrProductos.length;j++)
	{

		//solodebug	debug("inicializaFloatingBox. Recorriendo producto: " + j);
		
		if (arrProductos[j].NumOfertas>0) 	numProdConOfe++;
		if (arrProductos[j].TieneSeleccion=='S') ++numProdsAdjud;
	
		var PrecioTxt =(mostrarPrecioIVA == 'S') ?  arrProductos[j].PrecioHistIVA : arrProductos[j].PrecioHist;
		var Precio= (PrecioTxt=='')?0:desformateaDivisa(PrecioTxt);

		//	Recorre la matriz con de ofertas (solo para productos con ofertas
		for(var i=0;i<arrProductos[j].Ofertas.length;i++)
		{

			//solodebug	debug("inicializaFloatingBox("+i+") IDProdLic:"+arrProductos[j].IDProdLic + ' CantAdjud:'+arrProductos[j].Ofertas[i].CantAdjud+ " ConsumoPot:"+ConsumoPot+' ConsumoPrev:'+ConsumoPrev+' Ahorro:'+Ahorro);

			if (arrProductos[j].Ofertas[i].OfertaAdjud=='S')
			{

				//solodebug	debug("informaCantidades("+i+"): ADJUDICADA ");
				
				try
				{
					var PrecioOfertaTxt =(mostrarPrecioIVA == 'S') ?  arrProductos[j].Ofertas[i].PRECIOIVA : arrProductos[j].Ofertas[i].PRECIO;
					var PrecioOferta	=parseFloat(PrecioOfertaTxt.replace(",","."));
					var CantAdjud		=parseFloat(arrProductos[j].Ofertas[i].CantAdjud.replace(",","."));

					ConsumoPot+=CantAdjud*Precio;
					ConsumoPrev+=CantAdjud*PrecioOferta;
		
					//solodebug	debug("inicializaFloatingBox("+j+','+i+") ADJUDICADA. IDProdLic:"+arrProductos[j].IDProdLic+ " IDOfertaLic:" + arrProductos[j].Ofertas[i].ID+' CantAdjud:'+CantAdjud+' PrecioOferta:'+PrecioOferta+ " ConsumoPot:"+ConsumoPot+' ConsumoPrev:'+ConsumoPrev);
				}
				catch(e)
				{
					//solodebug	debug("inicializaFloatingBox("+j+','+i+") ADJUDICADA. IDProdLic:"+arrProductos[j].IDProdLic+ " IDOfertaLic:" + arrProductos[j].Ofertas[i].ID+' CantAdjud:'+arrProductos[j].Ofertas[i].CantAdjud+' PrecioOferta:'+arrProductos[j].Ofertas[i].PRECIO+ " ConsumoPot:"+ConsumoPot+' ConsumoPrev:'+ConsumoPrev+' error:'+e);
				}


			}
		}
	}
	Ahorro=(ConsumoPot==0)?0:100*(ConsumoPot-ConsumoPrev)/ConsumoPot;
	
	numProvsAdj=ProveedoresAdjudicados();
	
	//solodebug debug("inicializaFloatingBox. FINAL. ConsumoPot:"+ConsumoPot+' ConsumoPrev:'+ConsumoPrev+' Ahorro:'+Ahorro+' numProdConOfe:'+numProdConOfe+' numProdsAdjud:'+numProdsAdjud+' numProvsAdj:'+numProvsAdj);

}


//	5dic16	Colocamos el floating box en su lugar
function ColocaFloatingBox()
{
	//	Colocamos el FloatingBox en su lugar
	if (mostrarResumenFlotante=='S')			//	9mar20 Solo para casos en que se muestre el resumen
	{
		jQuery(".FBox").show();
		jQuery(".FBox").offset({ top: jQuery(window).scrollTop(), left: 700});	//jQuery(window).width()-600 });
		
		//solodebug	var offset = jQuery(".FBox").offset();
		//solodebug	alert('ColocaFloatingBox.[1]. left:' + offset.left + ', top:' + offset.top);
		
		//solodebug	debug('ColocaFloatingBox.[1]mostrarResumenFlotante:'+mostrarResumenFlotante+' top: '+(jQuery(window).scrollTop())+' left:'+'700');	//jQuery(window).width()-600 });
	}
	else
		jQuery(".FBox").hide();
	
	//solodebug	debug('ColocaFloatingBox.[2]mostrarResumenFlotante:'+mostrarResumenFlotante+' top: '+(jQuery(window).scrollTop())+' left:'+'700');	//jQuery(window).width()-600 });
}




function calcularFloatingBox(){

	//var numProductos = 0, numOfertas = 0, numProveedoresAdj = 0;
	var Cantidad, CantidadFormato, Cantidad, CantidadAdjFormato, PrecioRef, PrecioRefFormato, Precio, PrecioFormato;		//	28may19, ConsumoPot = 0, ConsumoPrev = 0, Ahorro = 0;
	//29may19	var chckPedMinimo = false, 
	var valAux;


	//	inicializamos las variables globales con los totales
	ConsumoPot = 0; 
	ConsumoPrevPot = 0;				//	COnsumo potencial de productos con precio de referencia, para poder calcular el ahorro
	ConsumoPrev = 0; 
	Ahorro = 0;
	numProductos = 0; 
	numOfertas = 0; 
	numProdConOfe = 0; 
	numProdsAdjud = 0; 
	numProveedoresAdj = 0;
	//solodebug	debug('calcularFloatingBox');


	//	21jul18	Inicializamos proveedores
	jQuery.each(arrProveedores, function(key, consumoProv){
		
		//solodebug	debug('calcularFloatingBox.Control proveedores seleccionados. Prov:('+consumoProv.IDProvLic+')'+consumoProv.NombreCorto+'. ofertasAdj:'+consumoProv.OfertasAdj+'->0');	//21jul18
		consumoProv.OfertasAdj=0;
	});



	jQuery.each(arrProductos, function(key, producto){
		numProductos++;

		//solodebug	
		debug('calcularFloatingBox. producto. Seleccionadas:'+producto.Seleccionadas);
		
		if (producto.NumOfertas>0)	numProdConOfe++;
		

		// Si hay una oferta seleccionada
		if(producto.Seleccionadas >0){
		
			++numProdsAdjud;
		
			jQuery.each(producto.Ofertas, function(key2, oferta){
				// Si esta es la oferta seleccionada
				if(oferta.OfertaAdjud == 'S'){
				
					//solodebug	alert('OfertaAdjud. precio:'+oferta.PRECIO);
				
					numOfertas++;
					Cantidad		= producto.Cantidad;
					CantidadFormato	= Cantidad.replace(",",".");
					
					// 20may19 Cantidad adjudicada
					CantidadAdj			= oferta.CANTIDADADJUDICADA;
					if (isNaN(CantidadAdj))					//	16nov22 En algunos casos esta en blanco
					{
						CantidadAdj			='0';
						CantidadAdjFormato	=0;
					}
					else
						CantidadAdjFormato	= CantidadAdj.replace(",",".");
					
					(mostrarPrecioIVA == 'S') ? PrecioRef = producto.PrecioHistIVA : PrecioRef = producto.PrecioHist;

					valAux = PrecioRef.replace(",",".");
					if(!isNaN(valAux) && !esNulo(valAux)){
						PrecioRefFormato	= valAux;
					}else{
						PrecioRefFormato	= 0;
					}
					(mostrarPrecioIVA == 'S') ? Precio = oferta.PRECIOIVA : Precio = oferta.PRECIO;
					PrecioFormato		= Precio.replace(",",".");

					if(PrecioRefFormato != 0){
						ConsumoPot		+= CantidadAdjFormato * PrecioRefFormato;
						//21jul18	ConsumoPrev		+= CantidadFormato * PrecioFormato;
	
						ConsumoPrevPot	+= CantidadAdjFormato * PrecioFormato;		//20may19 Cantidad adjudicada
					}
					ConsumoPrev		+= CantidadAdjFormato * PrecioFormato;		//20may19 Cantidad adjudicada
					
					if (ConsumoPot!=0)		//31mar17
						Ahorro			= (ConsumoPot - ConsumoPrevPot) * 100 / ConsumoPrevPot;
					else
						Ahorro			=  0;
						
						
					//	21jul18	Busca proveedor e inicializa
					jQuery.each(arrProveedores, function(key, consumoProv){
						if(consumoProv.IDProvLic==oferta.IDProvLic)						
							++consumoProv.OfertasAdj;
					});
						
						
				}
			});
		}
	});

	jQuery.each(arrProveedores, function(key, consumoProv){
		if(parseInt(consumoProv.OfertasAdj) > 0){
			//		+consumoProv.NombreCorto

			//solodebug
			debug('calcularFloatingBox.Control proveedores seleccionados. Prov:('+consumoProv.IDProvLic+')'+'. ofertasAdj:'+consumoProv.OfertasAdj);	//21jul18

			numProveedoresAdj++;
		}
	});

	//solodebug	debug('calcularFloatingBox ConsumoPot:'+ConsumoPot+' ConsumoPrev:'+ConsumoPrev);
	
	informarFloatingBox();
}



//	29may19 Separamos la funcion para mostrar el FLoatingBox del cálculo
function informarFloatingBox()
{
	var chckPedMinimo = false;
	
	if(mesesSelected == 0)	chckPedMinimo = validarPedidosMinimos(2);
	else	chckPedMinimo = true;

	jQuery('#FBConsPot').html(FormatoNumero(ConsumoPot.toFixed(2)));
	jQuery('#FBConsPrev').html(FormatoNumero(ConsumoPrev.toFixed(2)));
	jQuery('#FBAhorro').html(FormatoNumero(Ahorro.toFixed(2)) + '%');
	jQuery('#FBNumOfertas').html(numProdsAdjud+'/'+numProdConOfe+'/'+numProductos);	//	numOfertas
	jQuery('#FBProvs').html(numProvsAdj);

	if(chckPedMinimo && numOfertas == numProductos){
		jQuery('#FBAviso').html('&nbsp;<img src="http://www.newco.dev.br/images/check.gif" style="vertical-align:text-bottom;"/>');
	}else{
		jQuery('#FBAviso').html('&nbsp;<img src="http://www.newco.dev.br/images/atencion.gif" style="vertical-align:text-bottom;"/>');
	}

	if (mostrarResumenFlotante=='S')
		jQuery('#floatingBox').show();
	else
		jQuery('#floatingBox').hide();
}


//15may17 al guardar selección desde ficha, no marcar la licitación como pendiente de guardar selecciones
function recalcularFloatingBox(obj, flagPedMin, ofertaGuardada)
{
	//solodebug debug('recalcularFloatingBox: redirigido a calcularFloatingBox');
	
	calcularFloatingBox();
}


//	2may17	Comprueba si hay cambios en la licitacion
function CambiosEnOfertasSeleccionadas(hayCambios)
{
	//debug('licCambiosEnOfertasSel:'+hayCambios);
	

	licCambiosEnOfertasSel=hayCambios;
	
	if (hayCambios=='S')
	{
		jQuery("#botonAdjudicarSelec").hide();
		jQuery("#botonGuardarSelec").show();
	}
	else
	{
		jQuery("#botonAdjudicarSelec").show();
		jQuery("#botonGuardarSelec").hide();
	}
	
}


//	Actualiza todos los productos de la matriz en la base de datos
function ActualizarProductos()
{
	var IDTablaProds, thisRowID, thisPosArr, RefCliente, valAux;
	var precioRefIVA, precioRef, idPrecioRef, tipoIVA;
	var precioObjIVA, precioObj, idPrecioObj;
	var errores=0;

	if(jQuery("#lProductos_EST").length){
		IDTablaProds = '#lProductos_EST';
	}else if(jQuery("#lProductos_OFE").length){
		IDTablaProds = '#lProductos_OFE';
	}

	// Recorremos todas las filas de la tabla para hacer las validaciones
	jQuery(IDTablaProds + " > tbody > tr").each(function(){
		thisRowID	= this.id;
		thisPosArr	= thisRowID.replace('posArr_', '');
		RefCliente	= (arrProductos[thisPosArr].RefCliente != '') ? arrProductos[thisPosArr].RefCliente : arrProductos[thisPosArr].RefEstandar;

		// Validacion UdBasica
		valAux	= jQuery('#UDBASICA_' + thisPosArr).val();
		if(!errores && esNulo(valAux)){
			errores++;
			alert(val_faltaUdBasica.replace("[[REF]]",RefCliente));
			oForm.elements['UDBASICA_' + thisPosArr].focus();
			return false;
		}

		// Validacion Precio Historico
		if(mostrarPrecioIVA == 'S'){
			// Validacion de la columna para los precios historicos con IVA
			valAux	= jQuery('#PRECIOREFIVA_' + thisPosArr).val().replace(",",".");

			if(!errores && !esNulo(valAux) && isNaN(valAux)){
				errores++;
				alert(val_malPrecioRef.replace("[[REF]]", RefCliente));
				oForm.elements['PRECIOREFIVA_' + thisPosArr].focus();
				return false;
			}

			if(!errores){
				// Calculamos el valor para cada .precioRef (precio historico sin IVA) que son input hidden
				precioRefIVA	= (valAux != '') ? parseFloat(valAux) : '';
				idPrecioRef	= '#PRECIOREF_' + thisPosArr;
				tipoIVA		= parseFloat(arrProductos[thisPosArr].TipoIVA);
				precioRef	= (precioRefIVA != '') ? (precioRefIVA * 100) / (100 + tipoIVA) : '';
				valAux		= (precioRef != '') ? String(precioRef.toFixed(4)).replace(".",",") : '';
				jQuery(idPrecioRef).val(valAux);
				valAux		= (precioRefIVA != '') ? String(precioRefIVA.toFixed(4)).replace(".",",") : '';
				jQuery('#PRECIOREFIVA_' + thisPosArr).val(valAux);
			}
		}else{
			// Validacion de la columna para los precios historicos sin IVA
			valAux	= jQuery('#PRECIOREF_' + thisPosArr).val().replace(",",".");

			if(!errores && !esNulo(valAux) && isNaN(valAux)){
				errores++;
				alert(val_malPrecioRef.replace("[[REF]]", RefCliente));
				oForm.elements['PRECIOREF_' + thisPosArr].focus();
				return false;
			}

			if(!errores){
				valAux	= (valAux != '') ? String(parseFloat(valAux).toFixed(4)).replace(".",",") : '';
				jQuery('#PRECIOREF_' + thisPosArr).val(valAux);
			}
		}

		// Validacion Precio Objetivo
		if(mostrarPrecioIVA == 'S'){
			// Validacion de la columna para los precios historicos con IVA
			valAux	= jQuery('#PRECIO_OBJIVA_' + thisPosArr).val().replace(",",".");

			if(!errores && !esNulo(valAux) && isNaN(valAux)){
				errores++;
				alert(val_malPrecioObj.replace("[[REF]]", RefCliente));
				oForm.elements['PRECIO_OBJIVA_' + thisPosArr].focus();
				return false;
			}

			if(!errores){
				// Calculamos el valor para cada .precioObj (precio objetivo sin IVA) que son input hidden
				precioObjIVA	= (valAux != '') ? parseFloat(valAux) : '';
				idPrecioObj	= '#PRECIO_OBJ_' + thisPosArr;
				tipoIVA		= parseFloat(arrProductos[thisPosArr].TipoIVA);
				precioObj	= (precioObjIVA != '') ? (precioObjIVA * 100) / (100 + tipoIVA) : '';
				valAux		= (precioObj != '') ? String(precioObj.toFixed(4)).replace(".",",") : '';
				jQuery(idPrecioObj).val(valAux);
				valAux		= (precioObjIVA != '') ? String(precioObjIVA.toFixed(4)).replace(".",",") : '';
				jQuery('#PRECIO_OBJIVA_' + thisPosArr).val(valAux);
			}
		}else{
			// Validacion de la columna para los precios historicos sin IVA
			valAux	= jQuery('#PRECIO_OBJ_' + thisPosArr).val().replace(",",".");

			if(!errores && !esNulo(valAux) && isNaN(valAux)){
				errores++;
				alert(val_malPrecioObj.replace("[[REF]]",RefCliente));
				oForm.elements['PRECIO_OBJ_' + thisPosArr].focus();
				return false;
			}

			if(!errores){
				valAux	= (valAux != '') ? String(parseFloat(valAux).toFixed(4)).replace(".",",") : '';
				jQuery('#PRECIO_OBJ_' + thisPosArr).val(valAux);
			}
		}

		// Validacion Cantidad
		if (isLicAgregada=='N') {

			valAux	= jQuery('#CANTIDAD_' + thisPosArr).val().replace(",",".");

			//solodebug	alert('isLicAgregada:'+isLicAgregada);	//26set16

			if(!errores && (isLicAgregada=='N') &&(esNulo(valAux))){				//23set16 No comprobamos cantidad para licitaciones agregadas
				errores++;
				alert(val_faltaCantidad.replace("[[REF]]", RefCliente));
				oForm.elements['CANTIDAD_' + thisPosArr].focus();
				return false;
			//	ET	13jul16	}else if(!errores && parseFloat(valAux) === 0){
			//	ET	13jul16		errores++;
			//	ET	13jul16		alert(val_ceroCantidad.replace("[[REF]]",RefCliente));
			//	ET	13jul16		oForm.elements['CANTIDAD_' + thisPosArr].focus();
			//	ET	13jul16		return false;
			}else if(!errores && isNaN(valAux)){
				errores++;
				alert(val_malCantidad.replace("[[REF]]",RefCliente));
				oForm.elements['CANTIDAD_' + thisPosArr].focus();
				return false;
			}

			if(!errores){
				jQuery('#CANTIDAD_' + thisPosArr).val( String(parseFloat(valAux).toFixed(4)).replace(".",",") );
			}
		}
	});

	// si los datos son correctos enviamos el form
	if(!errores)
	{

		var arrayCambiosProductos =new Array();
		var listaProductos= '', arrayCambiosProductos, sendProductos, IDTablaProds, thisRowID, thisPosArr;
		var d = new Date();
		var lenAuxIni, lenAuxFin, loops, limit = 30;

		if(jQuery("#lProductos_EST").length){
			IDTablaProds = '#lProductos_EST';
		}else if(jQuery("#lProductos_OFE").length){
			IDTablaProds = '#lProductos_OFE';
		}

		// Como enviamos solo los datos de los productos que se muestran por pantalla (numProductos)
		// Evaluamos tambien que numProductos no sea mas grande que totalProductos
		sendProductos = (numProductos > totalProductos) ? totalProductos : numProductos;

		if(sendProductos > limit){
			//	Si hay mas productos que la variable limit => hacemos 'loops' peticiones ajax
			loops		= Math.ceil(sendProductos / limit);
		}else{
			//	Hacemos una unica peticion ajax
			loops		= 1;
		}

		jQuery('#botonActualizar').hide();
		jQuery('#botonActualizar2').hide();			//	17ene17

		for(var loop = 1; loop <= loops; loop++){

			jQuery('#idEstadoLic').html((limit*(loop-1))+'/'+sendProductos);


			// Calculamos el indice final de este loop
			lenAuxFin = (limit * loop > sendProductos) ?  sendProductos : (limit * loop);
			// Calculamos el indice inicial de este loop
			lenAuxIni = (limit * loop) - limit;

			listaProductos = '';
			jQuery(IDTablaProds + " tbody tr").each(function(index, element){
				thisRowID	= this.id;
				thisPosArr	= thisRowID.replace('posArr_', '');

				//solodebug	
				//solodebug	debug ('ActualizarProductos thisRow:'+jQuery(element).html()+' thisPosArr:'+thisPosArr
				//solodebug			+' orden:'+ColumnaOrdenadaProds[thisPosArr]+'ID:'+arrProductos[ColumnaOrdenadaProds[thisPosArr]].IDProdLic+ ' Cantidad:'+jQuery('#CANTIDAD_' + thisPosArr).val());


				// Construimos el string listaProductos con los datos de cada producto para este loop (desde lenAuxIni hasta lenAuxFin)
				if(index >= lenAuxIni && index < lenAuxFin){
					var IDProdLic = arrProductos[thisPosArr].IDProdLic;	//	ET 2feb17

					listaProductos += IDProdLic + '|' +				//p_IDProductoEstandar
						jQuery('#UDBASICA_' + thisPosArr).val() + '|' +		//p_UnidadBasica
						jQuery('#CANTIDAD_' + thisPosArr).val() + '|' +		//p_Cantidad
						jQuery('#PRECIOREF_' + thisPosArr).val() + '|' +	//p_PrecioReferencia
						jQuery('#PRECIO_OBJ_' + thisPosArr).val() + '#';	//p_PrecioObjetivo

					//28set16 Construimos un array que contenga la misma información para actualizarla si se guarda correctamente	
					var items		= [];
					items['Fila']=thisPosArr;
					items['IDProdLic']=IDProdLic;
					items['UnidadBasica']=jQuery('#UDBASICA_' + thisPosArr).val();
					items['PrecioRef']=jQuery('#PRECIOREF_' + thisPosArr).val();
					items['PrecioObj']=jQuery('#PRECIO_OBJ_' + thisPosArr).val();
					if (isLicAgregada=='N')	items['Cantidad']=Piece(jQuery('#CANTIDAD_' + thisPosArr).val(),',',0);

					//solodebug	debug('ActualizarProductos. IDProdLic:'+items['IDProdLic']+' Cant:'+items['Cantidad']);

					arrayCambiosProductos.push(items);
				}
			});

			// Quitamos la ultima '#' del string listaProductos
			listaProductos = listaProductos.substring(0, listaProductos.length - 1);

			//solodebug	alert ('ActualizarProductos ListaCambios:'+listaProductos);

			jQuery.ajax({
				cache:	false,
				url:	'http://www.newco.dev.br/Gestion/Comercial/ActualizarProductos.xsql',
				type:	"POST",
				async:	false,
				data:	"LIC_ID="+IDLicitacion+"&LISTA_PRODUCTOS="+encodeURIComponent(listaProductos)+"&ELIMINAROFERTAS=N&_="+d.getTime(),		//	 en la version lic_* hay una variable eliminarOfertas
				error: function(objeto, quepaso, otroobj){
					alert('error'+quepaso+' '+otroobj+' '+objeto);
				},
				success: function(objeto){
					//var data = eval("(" + objeto + ")");
					var data = JSON.parse(objeto);

					if(data.ProductosActualizados.estado == 'OK'){
						// Si estamos en estado 'EST' y se han hecho todas las peticiones ajax,
						// Recuperamos los datos de los productos via ajax, 28set16 También tenemos en cuenta el caso del estado COMP
						if(((EstadoLic == 'EST')||(EstadoLic == 'COMP')) && loop == loops){

							recuperaDatosProductosDesdeLista(arrayCambiosProductos);

							alert(alrt_ProdsActualizadosOK);
						// Si estamos en cualquier otro estado y se han hecho todas las peticiones ajax,
						// Recuperamos los datos de los productos con sus ofertas via ajax
        	        	}else if(loop == loops){

							//solodebug	alert ('ActualizarProductos ListaCambios:'+listaProductos+' -> recuperaDatosProductosDesdeLista');

							recuperaDatosProductosDesdeLista(arrayCambiosProductos);
							CargaOfertas(0);

							alert(alrt_ProdsActualizadosOK);
        	        	}
					}else{
						alert(alrt_ProdsActualizadosKO);
						jQuery('#botonActualizar').show();
						jQuery('#botonActualizar2').show();
        	        	return;
					}
				}
			});
		}
		jQuery('#botonActualizar').show();
		jQuery('#botonActualizar2').show();
		//jQuery('#idEstadoLic').html(mensajeEstadoActual);

		//	2feb17 Redibujamos la tabla de productos, por si hay que recalcular consumos
		dibujaTablaProductos();
	}
}


//19oct22 Faltaba actualizar los arrays con los datos de los productos
function recuperaDatosProductosDesdeLista(arrayCambiosProductos){

	//solodebug	var	msg='';		

	for (i=0;i<arrayCambiosProductos.length;++i){
	
		jQuery('#UDBASICA_' + arrayCambiosProductos[i].fila).val(arrayCambiosProductos[i].UnidadBasica);
		jQuery('#PRECIOREF_' + arrayCambiosProductos[i].fila).val(arrayCambiosProductos[i].PrecioRef);
		jQuery('#PRECIO_OBJ_' + arrayCambiosProductos[i].fila).val(arrayCambiosProductos[i].PrecioObj);
		if (isLicAgregada=='N')	jQuery('#CANTIDAD_' + arrayCambiosProductos[i].fila).val(Piece(arrayCambiosProductos[i].Cantidad,',',0));

		//solodebug	
		//msg+=' fila:'+arrayCambiosProductos[i].fila+' IDProdLic:'+arrayCambiosProductos[i].IDProdLic+'ud.basica:'+arrayCambiosProductos[i].UnidadBasica+' precioobj:'+arrayCambiosProductos[i].PrecioObj+'|';
		
		//	Recorre el array de productos para corregir las lineas correspondientes
		var found=false;
		for (j=0;((j<arrProductos.length) && (!found));++j)
		{
			if (arrProductos[j].IDProdLic==arrayCambiosProductos[i].IDProdLic)
			{

				arrProductos[j].UdBasica=arrayCambiosProductos[i].UnidadBasica;
				
				if (mostrarPrecioIVA == 'S')
				{
					arrProductos[j].PrecioHistIVA=arrayCambiosProductos[i].PrecioRef;
					arrProductos[j].PrecioObjIVA=arrayCambiosProductos[i].PrecioObj;
					
					if (arrProductos[j].TipoIVA != 0)
					{
						arrProductos[j].PrecioHist=arrProductos[j].PrecioHistIVA;
						arrProductos[j].PrecioObj=arrProductos[j].PrecioObjIVA;
					}
					else
					{
						arrProductos[j].PrecioHist=arrProductos[j].PrecioHistIVA/(1+arrProductos[j].TipoIVA/100);
						arrProductos[j].PrecioObj=arrProductos[j].PrecioObjIVA/(1+arrProductos[j].TipoIVA/100);
					}
					
				}
				else
				{
					arrProductos[j].PrecioHist=arrayCambiosProductos[i].PrecioRef;
					arrProductos[j].PrecioObj=arrayCambiosProductos[i].PrecioObj;

					arrProductos[j].PrecioHistIVA=arrProductos[j].PrecioHist;
					arrProductos[j].PrecioObjIVA=arrProductos[j].PrecioObj*(1+arrProductos[j].TipoIVA/100);

				}
				
				if (isLicAgregada=='N')	arrProductos[j].Cantidad=Piece(arrayCambiosProductos[i].Cantidad,',',0);
				
				arrProductos[j].Consumo=parseFloat(arrProductos[j].PrecioObj)*parseFloat(arrProductos[j].Cantidad);
				arrProductos[j].ConsumoIVA=parseFloat(arrProductos[j].PrecioObjIVA)*parseFloat(arrProductos[j].Cantidad);
				arrProductos[j].ConsumoHist=parseFloat(arrProductos[j].PrecioHist)*parseFloat(arrProductos[j].Cantidad);
				arrProductos[j].ConsumoHistIVA=parseFloat(arrProductos[j].PrecioHistIVA)*parseFloat(arrProductos[j].Cantidad);

				arrProductos[j].Consumo=arrProductos[j].Consumo.toString();
				arrProductos[j].ConsumoIVA=arrProductos[j].ConsumoIVA.toString();
				arrProductos[j].ConsumoHist=arrProductos[j].ConsumoHist.toString();
				arrProductos[j].ConsumoHistIVA=arrProductos[j].ConsumoHistIVA.toString();
				
				/*	2may17	Evitamos que aparezca "Nan" en pantalla si no  hay precio histórico informado	*/
				if (arrProductos[j].Consumo=='NaN')
				{
					arrProductos[j].Consumo='';
					arrProductos[j].ConsumoIVA='';
					arrProductos[j].ConsumoHist='';
					arrProductos[j].ConsumoHistIVA='';
				}
				
				//solodebug		
				//msg+=' fila:'+arrProductos[j].Linea+' ud.basica:'+arrProductos[j].UdBasica+' preciohist:'+arrProductos[j].PrecioHist
				//	+' precioobj:'+arrProductos[j].PrecioObj+' cantidad:'+arrProductos[j].Cantidad+' consumo:'+arrProductos[j].Consumo+'\n\r';
				
				found=true;	
			}
		}
		//solodebug	msg+='\n\r';
	}

	//solodebug		alert
	//debug('recuperaDatosProductosDesdeLista: num.filas:' + arrayCambiosProductos.length+'\n\r'+msg);
	//alert('recuperaDatosProductosDesdeLista: num.filas:' + arrayCambiosProductos.length+'\n\r'+msg);
	
	anyChange=false;
		
}


//	16mar18	Se producen problemas al enviar más de 50 selecciones de golpe. Paginaremos en bloques de 50
function GuardarSeleccion(){
	var thisRowID, thisPosArr, thisLicProdID, isThisChecked;
	var ListaOfertas = '', errores = 0, numProdsTotal = 0, numProdsLista = 0, numProdsAdj = 0, controlPaginacion=0, MaxPagina=50, numPaginas=1;
	var d = new Date();

	// Numero de productos en la licitacion
	numProdsTotal = totalProductos;

	// Recorremos cada fila de la tabla
	jQuery('table#lProductos_OFE tbody tr').each(function(){
		numProdsLista++;
		thisRowID	= this.id;
		thisPosArr	= thisRowID.replace('posArr_', '');
		thisLicProdID	= arrProductos[thisPosArr].IDProdLic;

		// Asignamos el LicProdID al string ListaOfertas
		ListaOfertas += thisLicProdID + '|';

		//Para cada una de las ofertas de proveedor miro que radio button esta seleccionado
		jQuery(".RADIO_" + thisPosArr).each(function(){
			isThisChecked = jQuery(this).is(':checked') ? true:false;		// 1jul22 .attr('checked')

			if(isThisChecked){
				numProdsAdj++;
				ListaOfertas += jQuery(this).val();
				arrProductos[thisPosArr].TieneSeleccion ='S';		//	3oct16	marcamos producto seleccionado 
			}
		});

		// Cerramos esta posicion
		ListaOfertas += '#';

		++controlPaginacion;
		if (controlPaginacion==MaxPagina)
		{
			ListaOfertas+='·';
			controlPaginacion=0;
			++numPaginas;
		}
		
		//solodebug debug('ListaOfertas:'+ListaOfertas+' controlPaginacion:'+controlPaginacion+'/'+MaxPagina+' numPaginas:'+numPaginas);
		
		
	});

	// Tiene que haber minimo una oferta seleccionada
	if(numProdsAdj == 0){
		errores++;
		alert(alrt_errSinOfertaSelec);
		return;
	}

	if(!errores){
		GuardarSeleccionAjax(ListaOfertas, numProdsLista, MaxPagina, 0, numPaginas, '');
	}
}


//	16mar18	Una vez creada la cadena completa, la enviamos por bloques
function GuardarSeleccionAjax(ListaOfertas, numProdsLista, MaxPagina, loop, loops, error)
{
	var thisRowID, thisPosArr, thisLicProdID, isThisChecked;
	var ListaOfertasPagina = '', errores = 0, numProdsTotal = 0, numProdsLista = 0, numProdsAdj = 0;
	var d = new Date();

	if (loop==loops)
	{
		if (!error)
		{
			alert(alrt_guardarSeleccionAdjOK);
		}
		else	//	6oct17 Aunque haya habido error, recargamos productos, ya que pueden haberse insertado algunos
		{
			alert(alrt_guardarSeleccionAdjKO);
		}

		jQuery(".botonAccion").show();
		return;
	}
	
	ListaOfertasPagina=Piece(ListaOfertas,'·',loop);
	//solodebug	debug('GuardarSeleccionAjax: '+ListaOfertas+ 'loop:'+loop+'loops:'+loop+' ListaOfertasPagina:'+ListaOfertasPagina);

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/SeleccionarProductos2AJAX.xsql',
		type:	"GET",
		data:	"IDLIC="+IDLicitacion+"&LISTAOFERTAS="+encodeURIComponent(ListaOfertasPagina)+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			jQuery(".botonAccion").hide();
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.Resultado.Estado == 'OK'){
				jQuery('#idEstadoEnvio').html((MaxPagina*loop)+'/'+numProdsLista);
				++loop;
				GuardarSeleccionAjax(ListaOfertas, numProdsLista, MaxPagina, loop, loops, error);
			}
			return;
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});

}


//	8jul22 CLick en oferta: selecciona o deselecciona, actualiza array, recalcula totales, guarda en base da datos
function clickRadio(codRadio, IDOfertaLic)
{
	//solodebug	debug('clickRadio. codRadio:'+codRadio+' IDOfertaLic:'+IDOfertaLic);
	
	//solodebug debug('clickRadio. 1. Array productos:\n'+VuelcaArrayProductos(-1));
	
	pos=BuscaFilaProducto(codRadio);
	//solodebug	debug('clickRadio. Producto (col.ord.:'+pos+'):'+arrProductos[pos].RefCliente+':'+arrProductos[pos].Nombre);
	
	//colOferta=BuscaOferta(pos, IDOfertaLic);
	//debug('clickRadio. Oferta:'+arrProductos[pos].Ofertas[colOferta].REFERENCIA+' ('+arrProductos[pos].Ofertas[colOferta].PROVEEDOR+')');
	
	//solodebug();	debug('clickRadio. 2. Array productos:\n'+VuelcaArrayProductos(pos));
	
	SeleccionadaOfertaEnMatriz(pos, IDOfertaLic);
}



//	8jul22 CLick en oferta: selecciona o deselecciona, actualiza array, recalcula totales, guarda en base da datos
function BuscaFilaProducto(codRadio)
{
	var Res=-1;
	for (var i=0; ((Res==-1)&&(i<arrProductos.length));++i)
	{
		if (arrProductos[i].Linea-1==codRadio) Res=i;
	}

	//solodebug debug('BuscaFilaProducto. codRadio:'+codRadio+' Res:'+Res);
	
	return Res;
}


// 25abr22 Al seleccionar una oferta, comprueba si es el precio mínimo
//			Adaptado a partir de la funcion en FichaProductoLicitacion2022_300322.js
function SeleccionadaOfertaEnMatriz(PosProd, ID)
{
	
	//solodebug	debug('SeleccionadaOfertaEnMatriz (1). ID:'+ID+' Producto ('+PosProd+'):'+arrProductos[PosProd].RefCliente+':'+arrProductos[PosProd].Nombre);
	//solodebug debug('SeleccionadaOfertaEnMatriz. 1. Array productos:\n'+VuelcaArrayProductos(PosProd));
	
	
	var oform=document.forms["frmProductos"];
	var CantidadActual;
	
	//	13abr21 Marca el cambio a nivel de adjudicaciones, para avisar antes de salir
	CambiosProveedores='S';
		
	//solodebug	alert(PresentaForms(document));
	
	//	Busca el precio actual
	var PosOfe	=BuscaOferta(PosProd, ID);
	arrProductos[PosProd].PrecioOfertaActual=desformateaDivisa(arrProductos[PosProd].Ofertas[PosOfe].PRECIO);			//8jul22 oform.elements["PrecioOriginal_"+ID].value);

	//solodebug debug('SeleccionadaOfertaEnMatriz (2). PosProd:'+PosProd+' ID:'+ID+' PosOfe:'+PosOfe);	
	
	//	Busca el mejor precio y calcula la cantidad pendiente de adjudicar
	arrProductos[PosProd].CantidadPendiente	=CalcCantidadPendiente(PosProd);
	
	//solodebug 
	/*debug('SeleccionadaOfertaEnMatriz (3). PosProd:'+PosProd+' ID:'+ID+' PrecioOfertaActual:'+arrProductos[PosProd].PrecioOfertaActual
			+' MejorPrecio:'+arrProductos[PosProd].MejorPrecio+' CantidadPendiente:'+arrProductos[PosProd].CantidadPendiente
			+ ' #ADJUD_'+ID+' checked:'+jQuery("#ADJUD_"+ID).prop("checked")
			+' OfertaAdjud:'+arrProductos[PosProd].Ofertas[PosOfe].OfertaAdjud
			);*/
	
	//	Compara con el mejor precio
	if ((jQuery("#ADJUD_"+ID).prop("checked"))&&(MostrarMotivoSeleccion=='S')&&(arrProductos[PosProd].PrecioOfertaActual>arrProductos[PosProd].MejorPrecio))
		jQuery("#lMotivo_"+PosProd).show();		
	else
	{
		jQuery("#IDMOTIVOSELECCION_"+PosProd).val("");			//	7nov19	Reinicializamos el desplegable
		jQuery("#MOTIVOSELECCION_"+PosProd).val("");			//	29jun22	Reinicializamos el desplegable
		jQuery("#lMotivo_"+PosProd).hide();
	}

	if ((isLicMultiopcion=='S')||((MesesDuracion==0)&&(isLicAgregada=='N')))			//	16dic19 Faltaba incluir la opción de SPOT	// 27ago20 Pero no para agregadas
	{
	
		//solodebug	console.log('SeleccionadaOfertaEnMatriz: ID:'+ID+' isLicMultiopcion:'+isLicMultiopcion+' MesesDuracion:'+MesesDuracion);

		//10jul 22 En lugar de comprobar el check, comprobamos el valor anterior en el array JS // if (jQuery("#ADJUD_"+ID).prop("checked"))
		if (arrProductos[PosProd].Ofertas[PosOfe].OfertaAdjud=='N')
		{
			
			//solodebug	console.log('SeleccionadaOfertaEnMatriz: ID:'+ID+' PrecioOfertaActual:'+arrProductos[PosProd].PrecioOfertaActual+' MejorPrecio:'+arrProductos[PosProd].MejorPrecio+' MARCANDO ADJUDICADA');

			arrProductos[PosProd].Ofertas[PosOfe].OfertaAdjud='S';
			arrProductos[PosProd].Ofertas[PosOfe].CANTIDADADJUDICADA=arrProductos[PosProd].Cantidad;

			//solodebug	CalculaCantidadPendiente();
			arrProductos[PosProd].CantidadPendiente=0;

			DesmarcaOtrasOfertas(PosProd, PosOfe);
		}
		else
		{
			arrProductos[PosProd].Ofertas[PosOfe].OfertaAdjud='N';
			arrProductos[PosProd].Ofertas[PosOfe].CANTIDADADJUDICADA='0';
			
			//solodebug	console.log('SeleccionadaOfertaEnMatriz: ID'+ID+' PrecioOfertaActual:'+arrProductos[PosProd].PrecioOfertaActual+' MejorPrecio:'+arrProductos[PosProd].MejorPrecio+'  MARCANDO NO ADJUDICADA');

			CantidadActual=0;
			arrProductos[PosProd].CantidadPendiente	=arrProductos[PosProd].Cantidad;
		}
	}
	else
	{

		//10jul 22 En lugar de comprobar el check, comprobamos el valor anterior en el array JS // if (jQuery("#ADJUD_"+ID).prop("checked"))
		if (arrProductos[PosProd].Ofertas[PosOfe].OfertaAdjud=='N')
		{
			//solodebug	console.log('SeleccionadaOfertaEnMatriz: ID. '+ID+' NO multiopcion, MARCANDO ADJUDICADA, desmarcando otras');

			arrProductos[PosProd].Ofertas[PosOfe].OfertaAdjud='S';
			arrProductos[PosProd].Ofertas[PosOfe].CANTIDADADJUDICADA=arrProductos[PosProd].Cantidad;

			DesmarcaOtrasOfertas(PosProd, PosOfe);
		}
		else
		{
			//solodebug	console.log('SeleccionadaOfertaEnMatriz: ID. '+ID+' NO multiopcion, MARCANDO NO ADJUDICADA');

			arrProductos[PosProd].Ofertas[PosOfe].OfertaAdjud='N';
			arrProductos[PosProd].Ofertas[PosOfe].CANTIDADADJUDICADA='0';
			arrProductos[PosProd].CantidadPendiente	=CalcCantidadPendiente(PosProd);
		}

	}

	CompruebaCambios(PosProd);
	RevisaOfertas(PosProd);

	//	29mar21
	if (isLicAgregada=='S')
		ActualizarCentrosYProveedores(PosProd);
	
	//	solodebug debug('SeleccionadaOfertaEnMatriz. Array productos:\n'+VuelcaArrayProductos(PosProd));
	
	//	29jun22 Guarda la seleccion
	GuardarProductoSel(PosProd,'');
	
	//	24oct22 Recaulcula el Floating Box
	calcularFloatingBox();
	
}


/*
	INCLUIR PRODUCTOS POR REFERENCIA
*/

//	19jul22 Inlcuye los productos en la licitacion
function IncluirProductosPorRef()
{
	var errores=0, msg='';
	var oForm=document.forms['frmIncluirProductos'];
	var listRefs = oForm.elements['LIC_LISTA_REFPRODUCTO'].value;

	if((!errores) && (esNulo(listRefs))){
		errores++;
		alert(val_faltaReferencia);
		oForm.elements['LIC_LISTA_REFPRODUCTO'].focus();
	}else{
		var arrLista	= listRefs.split(/\n/);
		if(arrLista.length > maxLineasParaInsertar){ // 18set16 ET No aceptamos mas de 500 referencias (antes 300)
			errores++;
			var Mensaje=val_maxReferencias.replace("[[NUM_REFS]]",arrLista.length);

			msg+=Mensaje.replace("[[MAX_REFS]]",maxLineasParaInsertar)+'\n';
			oForm.elements['LIC_LISTA_REFPRODUCTO'].focus();
		}

		//	13abr17 Recorre los datos de la lista para controlar errores
		for (i=0;i<arrLista.length;++i)
		{
			if (arrLista[i]!='')
			{
				var Ref=Piece(arrLista[i],':',0);
				var Cant=Piece(arrLista[i],':',1);
				var PrecioRef=Piece(arrLista[i],':',2);					//	8feb18	Permitimos subir precio ref
				var PrecioObj=Piece(arrLista[i],':',3);					//	8feb18	Permitimos subir precio obj
				var Restocadena=Piece(arrLista[i],':',4);				//	8feb18	Para control de errores

				if (((Cant!='')&&(!jQuery.isNumeric(Cant)))||(Restocadena!=''))	//	18abr17	COmprobar que la cantidad no sea null antes de chequear error
				{
					errores++;
					msg+=val_malCantidad.replace("[[REF]]",Ref)+'\n';
				}

			}

		}

	}

	//	Para Colombia tampoco comprobamos el IVA
	if(!errores && (IDPais!=55) && (IDPais!=57) && (oForm.elements['LIC_TIPOIVA'].value < 0 || oForm.elements['LIC_TIPOIVA'].value == '')){
		errores++;
		msg+=val_faltaTipoIVA+'\n';
		//No puede coger foco si esta oculto oForm.elements['LIC_TIPOIVA'].focus();
	}

	// si los datos son correctos enviamos el form
	if(!errores){
		AnadirProductos(oForm);
	}
	else
		alert(msg);

}

// Peticion ajax que inserta nuevos productos en la tabla lic_productos (por referencia cliente o MVM mediante cadena separada por '|')
// A la base de datos se envia en formato REFCLIENTE1[#CANTIDAD1]|REFCLIENTE2[#CANTIDAD2]|... o REFMVM1[#CANTIDAD1]|REFMVM2[#CANTIDAD2]|...
function AnadirProductos(oForm){
	var limit = 20;	
	
	var error=false;
	
	var Referencias	= oForm.elements['LIC_LISTA_REFPRODUCTO'].value.replace(/(?:\r\n|\r|\n)/g, '|');
	var TipoCodificacion	= jQuery("#IDCENTROREFERENCIA").val();
	
	Referencias	= Referencias.replace(/[\t:]/g, ':');	// 18set16	Separadores admitidos para separar referencia de cantidad

		
	//solodebug	debug('Referencias:'+Referencias);		
		

	// Como enviamos solo los datos de los productos que se muestran por pantalla (numProductos)
	// Evaluamos tambien que numProductos no sea mas grande que totalProductos
	var totProductos = PieceCount(Referencias,'|');
	
	//	Comprueba si la ultima referencia esta informada (muchas veces es linea en blanco)
	if (Piece(Referencias,'|',totProductos)!='') ++totProductos

	if(totProductos > limit){
		//	Si hay mas productos que la variable limit => hacemos 'loops' peticiones ajax
		loops		= Math.ceil(totProductos / limit);
	}else{
		//	Hacemos una unica peticion ajax
		loops		= 1;
	}

	jQuery("#EnviarProductosPorRef").hide();
	jQuery('#idEstadoEnvio').html('0/'+totProductos);
	jQuery('#idEstadoEnvio').show();
	
	//solodebug 
	debug('TipoCodificacion:'+TipoCodificacion+'AnadirProductos:'+Referencias+' totProductos:'+totProductos+' loops:'+loops);
	

	//6oct17	ColumnaOrdenacionProds = 'linea';	//	22mar17	Con otras ordenaciones se pueden producir errores por campos no inicializados
	//6oct17	prepararTablaProductos(true);

	AnadirProductosAjax(oForm, Referencias, TipoCodificacion, totProductos, 0, loops, '');
}

//	Añade los productos vía Ajax (función recursiva)
function AnadirProductosAjax(oForm, Referencias, TipoCodificacion, totProductos, loop, loops, error)
{
	var cadEnvio=''; limit = 20;

	var TipoIVA	= oForm.elements['LIC_TIPOIVA'].value;
	var d = new Date();

	//solodebug	
	debug('AnadirProductosAjax: totProductos:'+totProductos+' loop:'+loop+'/'+loops+ 'TipoCodificacion:'+TipoCodificacion);

	if (loop==loops)
	{
		if (!error)
		{

			//11dic20	if (estadoLicitacion=='CURS')
			//11dic20	{
				jQuery('#idEstadoEnvio').html(totProductos+'/'+totProductos);
				alert(str_InsertarProductos_OK);

				//22ago22 recuperar datos productos da problemas, mejor recargar todo. recuperaDatosProductos();			//20jul22
				
				Recarga();	
				
			//11dic20	}
			//11dic20	else
			//11dic20	{
			//11dic20		//alert(data.NuevosProductos.message);
			//11dic20		oForm.elements['LIC_LISTA_REFPRODUCTO'].value='';

			//11dic20		//	6oct17	Recargamos la tabla de productos
			//11dic20		ColumnaOrdenacionProds = 'NombreNorm';	//19mar19 'linea'//	22mar17	Con otras ordenaciones se pueden producir errores por campos no inicializados

			//11dic20		recuperaDatosProductos(0,'S');
			//11dic20		prepararTablaProductos(true);
			//11dic20	}
		}
		else	//	6oct17 Aunque haya habido error, recargamos productos, ya que pueden haberse insertado algunos
		{
			
			//solodebug
			alert('Saliendo por error');
			
			oForm.elements['LIC_LISTA_REFPRODUCTO'].value='';
			recuperaDatosProductos(0,'N');

			//	6oct17	Recargamos la tabla de productos
			ColumnaOrdenacionProds = 'NombreNorm';	//19mar19 'linea'//	22mar17	Con otras ordenaciones se pueden producir errores por campos no inicializados
			prepararTablaProductos(true);
		}

		jQuery('#idEstadoEnvio').hide();
		jQuery("#EnviarProductosPorRef").show();
		
		//	17jun20 En cualquier caso, activa el boton
		jQuery('#botonIniciarLici').removeClass("btnGris");
		jQuery('#botonIniciarLici').attr('class','btnDestacado');
		
		return;
	}

	//solodebug		debug('AnadirProductosAjax: '+Referencias+ 'limit:'+limit+' totProductos:'+totProductos);

	//6oct17	for (j=0;(j<limit)&&((loop*limit+j)<totProductos);++j)
	for (j=0;(j<limit)&&((loop*limit+j)<=totProductos);++j)		//	13jul20 
	{
		cadEnvio+=Piece(Referencias,'|',loop*limit+j)+'|';
		
		//solodebug	debug('AnadirProductosAjax: '+cadEnvio+' j:'+j);
	}

	//solodebug	
	debug('AnadirProductosAjax: '+cadEnvio+' final');

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/NuevosProductos.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&TIPO_CODIFICACION="+TipoCodificacion+"&LISTA_REFERENCIAS="+cadEnvio+"&TIPOIVA="+TipoIVA+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		//async: false,
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.NuevosProductos.estado == 'OK'){

				// Se han anyadido productos (pero falta informar campos como cantidad, uds x lote, precios, etc)
				prodsInformados = 'N';

            }else{
				alert('Error: \n' + data.NuevosProductos.message + '\n' + alrt_errorNuevosProductos);
				error=true;
			}
			
			jQuery('#idEstadoEnvio').html((limit*loop)+'/'+totProductos);
			++loop;
			
			//solodebug	6oct17	debug('AnadirProductosAjax: '+loop+'/'+loops+':'+cadEnvio);
			
			//	18abr17	En el caso de licitación en curso, al añadir productos recargamos la pagina
			//if (estadoLicitacion=='CURS')
			//	location.reload();
			//else
				AnadirProductosAjax(oForm, Referencias, TipoCodificacion, totProductos, loop, loops, error);
			
			return;	//28mar17

		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});

}


/*
	INCLUIR PRODUCTOS POR CATALOGO
*/

//	19jul22 Inlcuye los productos en la licitacion
function IncluirProductosPorCat()
{
	var errores=0, msg='';
	var oForm=document.forms['frmIncluirProductos'];

	if(mostrarCategorias == 'S'){
		// Estamos en el caso de empresas de 5 niveles
		if(!errores && (oForm.elements['IDCATEGORIA'].value < 0 || oForm.elements['IDCATEGORIA'].value == '')){
			errores++;
			msg+=val_faltaSelecDespl.replace("[[SUBFAMILIAS]]",txtNivel1)+'\n';
			oForm.elements['IDCATEGORIA'].focus();
		}else if(!errores && (oForm.elements['IDFAMILIA'].value < 0 || oForm.elements['IDFAMILIA'].value == '')){
			errores++;
			msg+=val_faltaSelecDespl.replace("[[SUBFAMILIAS]]",txtNivel2)+'\n';
			oForm.elements['IDFAMILIA'].focus();
		}else if(!errores && (oForm.elements['IDSUBFAMILIA'].value < 0 || oForm.elements['IDSUBFAMILIA'].value == '')){
			errores++;
			msg+=val_faltaSelecDespl.replace("[[SUBFAMILIAS]]",txtNivel3)+'\n';
			oForm.elements['IDSUBFAMILIA'].focus();
		}
	}else{
		// Estamos en el caso de empresas de 3 niveles
		if(!errores && (oForm.elements['IDFAMILIA'].value < 0 || oForm.elements['IDFAMILIA'].value == '')){
			errores++;
			msg+=val_faltaSelecDespl.replace("[[SUBFAMILIAS]]",txtNivel2)+'\n';
			oForm.elements['IDFAMILIA'].focus();
		}else if(!errores && (oForm.elements['IDSUBFAMILIA'].value < 0 || oForm.elements['IDSUBFAMILIA'].value == '')){
			errores++;
			msg+=val_faltaSelecDespl.replace("[[SUBFAMILIAS]]",txtNivel3)+'\n';
			oForm.elements['IDSUBFAMILIA'].focus();
		}
	}
	/* si los datos son correctos enviamos el form  */
	if(!errores){
		AnadirProductos_2(oForm);
	}
	else
		alert(msg);
}


function AnadirProductos_2(oForm){
	var TipoIVA	= oForm.elements['LIC_TIPOIVA_PORCAT'].value;
	var IDNivel, Nivel;
	var d = new Date();

	if(jQuery('#IDPRODUCTOESTANDAR').val() > 0 && jQuery('#IDPRODUCTOESTANDAR').val() != ''){
		Nivel	= 'PRO';
		IDNivel	= jQuery('#IDPRODUCTOESTANDAR').val();
	}else if(jQuery('#IDGRUPO').val() > 0 && jQuery('#IDGRUPO').val() != ''){
		Nivel	= 'GRU';
		IDNivel	= jQuery('#IDGRUPO').val();
	}else if(jQuery('#IDSUBFAMILIA').val() > 0 && jQuery('#IDSUBFAMILIA').val() != ''){
		Nivel	= 'SF';
		IDNivel	= jQuery('#IDSUBFAMILIA').val();
	}

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/NuevosProductosXCatPrivAJAX.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&NIVEL="+Nivel+"&NIVEL_ID="+IDNivel+"&TIPOIVA="+TipoIVA+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.NuevosProductos.estado == 'OK'){
				// Se han anyadido productos (pero falta informar campos como cantidad, uds x lote, precios, etc)
				prodsInformados = 'N';

				alert(data.NuevosProductos.message);
				recuperaDatosProductos();
            }else{
				alert('Error: \n' + data.NuevosProductos.message + '\n' + alrt_errorNuevosProductos);
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}






// Peticion ajax que devuelve el desplegable de familias (empresas de 5 o 3 niveles)
function SeleccionaFamilia(IDCategoria){
	var d = new Date();

	jQuery.ajax({
		url:	"http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/FamiliasAJAX.xsql",
		type:	"GET",
		data:	"IDCLIENTE="+IDEmpresa+"&IDCATEGORIA="+IDCategoria+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = JSON.parse(objeto);
			var Resultados = new String('');

			if(data.Filtros.length > 1){
				for(var i=0; i<data.Filtros.length; i++){
					Resultados = Resultados+' <option value="'+data.Filtros[i].Filtro[0].id+'">'+data.Filtros[i].Filtro[0].nombre+'</option>';
				}
				jQuery("#IDFAMILIA").html(Resultados).val('-1').removeAttr('disabled');
			}else{
				Resultados = '<option value="-1">' + str_Todas + '</option>';
				jQuery("#IDFAMILIA").html(Resultados).val('-1').attr('disabled', 'disabled');
			}
		}
	});
}

// Peticion ajax que devuelve el desplegable de subfamilias (empresas de 5 o 3 niveles)
function SeleccionaSubFamilia(IDFamilia){
	var d = new Date();

	jQuery.ajax({
		url:	"http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/SubFamiliasAJAX.xsql",
		type:	"GET",
		data:	"IDFAMILIA="+IDFamilia+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = JSON.parse(objeto);
			var Resultados = new String('');

			if(data.Filtros.length > 1){
				for(var i=0; i<data.Filtros.length; i++){
					Resultados = Resultados+' <option value="'+data.Filtros[i].Filtro[0].id+'">'+data.Filtros[i].Filtro[0].nombre+'</option>';
				}
				jQuery("#IDSUBFAMILIA").html(Resultados).val('-1').removeAttr('disabled');
			}else{
				Resultados = '<option value="-1">' + str_Todas + '</option>';
				jQuery("#IDSUBFAMILIA").html(Resultados).val('-1').attr('disabled', 'disabled');
			}
		}
	});
}

// Peticion ajax que devuelve el desplegable de grupos (empresas de 5 o 3 niveles)
function SeleccionaGrupo(IDSubfamilia){
	var d = new Date();

	jQuery.ajax({
		url:	"http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/GruposAJAX.xsql",
		type:	"GET",
		data:	"IDSUBFAMILIA="+IDSubfamilia+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = JSON.parse(objeto);
			var Resultados = new String('');

			if(data.Filtros.length > 1){
				if(mostrarGrupos == 'S'){
					for(var i=0; i<data.Filtros.length; i++){
						Resultados = Resultados+' <option value="'+data.Filtros[i].Filtro[0].id+'">'+data.Filtros[i].Filtro[0].nombre+'</option>';
					}
					jQuery("#IDGRUPO").html(Resultados).val('-1').removeAttr('disabled');
				}else{
					// En el caso que se trate de una empresa de 3 niveles
					// Recogemos el valor del IDGrupo por defecto y lo pasamos a la siguiente funcion (SeleccionaProducto)
					var IDGrupoXDefecto = data.Filtros[1].Filtro.id;
					SeleccionaProducto(IDGrupoXDefecto);
				}
			}else{
				Resultados = '<option value="-1">' + str_Todas + '</option>';
				jQuery("#IDGRUPO").html(Resultados).val('-1').attr('disabled', 'disabled');
			}
		}
	});
}

// Peticion ajax que devuelve el desplegable de grupos (empresas de 5 o 3 niveles)
function SeleccionaProducto(IDGrupo){
	var d = new Date();

	jQuery.ajax({
		url:	"http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ProductosEstandarAJAX.xsql",
		type:	"GET",
		data:	"IDGRUPO="+IDGrupo+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = JSON.parse(objeto);
			var Resultados = new String('');

			if(data.Filtros.length > 1){
				for(var i=0; i<data.Filtros.length; i++){
					Resultados = Resultados+' <option value="'+data.Filtros[i].Filtro[0].id+'">'+data.Filtros[i].Filtro[0].nombre+'</option>';
				}
				jQuery("#IDPRODUCTOESTANDAR").html(Resultados).val('-1').removeAttr('disabled');
			}else{
				Resultados = '<option value="-1">' + str_Todas + '</option>';
				jQuery("#IDPRODUCTOESTANDAR").html(Resultados).val('-1').attr('disabled', 'disabled');
			}
		}
	});
}



/*
	RECUPERA LOS PRODUCTOS
*/


//	Recupera los datos de productos vía AJAX	//	20jul22 (flag, actTabla)
function recuperaDatosProductos()		
{
	var precioReferenciaVacio = 0, CheckCamposIniciar = true;
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/RecuperaProductos.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			var data = JSON.parse(objeto);
			arrProductos	= new Array();

			if(data.ListaProductos.length > 0){

				jQuery.each(data.ListaProductos, function(key, producto){
					// Evaluamos si se han informado todos los precios historicos
					if(producto.PrecioReferencia == ''){
						precioReferenciaVacio = 1;
					}

					// Comprobamos todos los productos estan validados para poder iniciar la licitacion
					if(producto.Validado == 'N'){
						CheckCamposIniciar = false;
                    }

					var items		= [];
					items['linea']		= producto.Linea;
					items['IDProdLic']	= producto.LIC_PROD_ID;
					items['IDProd']		= producto.IDProdEstandar;
					items['RefEstandar']= producto.ProdRefEstandar;
					items['RefCliente']	= producto.ProdRefCliente;
					items['RefCentro']	= producto.ProdRefCentro;
					items['Nombre']		= producto.ProdNombre;
					items['NombreNorm']	= producto.ProdNombreNorm;
					items['UdBasica']	= producto.ProdUdBasica;
					items['FechaAlta']	= producto.FechaAlta;
					items['FechaMod']	= producto.FechaModificacion;
					items['Consumo']	= producto.Consumo;
					items['ConsumoIVA']	= producto.ConsumoIVA;
					items['ConsumoHist']	= producto.ConsumoHist;
					items['ConsumoHistIVA']	= producto.ConsumoHistIVA;
					items['Cantidad']	= producto.Cantidad;
					items['PrecioObj']	= producto.PrecioObjetivo;
					items['PrecioObjIVA']	= producto.PrecioObjetivoIVA;
					items['PrecioHist']	= producto.PrecioReferencia;
					items['PrecioHistIVA']	= producto.PrecioReferenciaIVA;
					items['TipoIVA']	= producto.TipoIVA;
					items['Marcas']		= producto.Marcas;
					items['PrincActivo']= producto.PrincActivo;

					// Campos Avanzados
					items['InfoAmpliada']	= producto.InfoAmpliada;
					items['Anotaciones']	= producto.Anotaciones;
					items['Documento']	= [];
					if(producto.Documento.ID != ''){
						items['Documento']['ID']		= producto.Documento.ID;
						items['Documento']['Nombre']		= producto.Documento.Nombre;
						items['Documento']['Descripcion']	= producto.Documento.Descripcion;
						items['Documento']['Url']		= producto.Documento.Url;
						items['Documento']['Fecha']		= producto.Documento.Fecha;
					}
					// FIN Campos Avanzados

					items['NumOfertas']	= '0';
					items['TieneSeleccion']	= 'N';
					items['Ordenacion']	= '0';

					//	Nuevos campos utilizados en el array de productos de la V2
					items['Sospechoso']	= '<xsl:choose><xsl:when test="MUY_SOSPECHOSO">2</xsl:when><xsl:when test="SOSPECHOSO">1</xsl:when><xsl:otherwise>0</xsl:otherwise></xsl:choose>';

					items['AhorroMax']	= '<xsl:value-of select="AHORRO_MAX"/>';
					items['SinAhorro']	= '<xsl:choose><xsl:when test="AVISO_SIN_AHORRO">S</xsl:when><xsl:otherwise>N</xsl:otherwise></xsl:choose>';

					//	No añadimos aquí las ofertas, lo haremos posteriormente vía ajax. Inicializamos las ofertas en blanco
					items['Ofertas'] = new Array();
					items['OfertasBack'] = new Array();		//	Copia de seguridad, antes de los cambios, para recalcular totales
					items['OfCargadas'] = 'N';

					items['CompraMedia']=[];
					items['UltCompra']=[];

					items['curvaABC']='';

					items['PrecioOfertaActual']='';			//sustituye a gl_PrecioOfertaActual
					items['MejorPrecio']='';				//sustituye a gl_MejorPrecio
					items['CantidadPendiente']=parseInt(producto.Cantidad);			//evita el recalculo de la CantidadPendiente
					items['Seleccionadas']=0;				//ofertas seleccionadas
					items['Cambios']='N';					//cambios pendientes de guardar
					items['CumpleFiltro']='S';				//cumple el filtro de busqueda
					items['Ahorro']='0';					//16jun22 ahorro seleccionado o maximo

					
					//solodebug 
					debug('recuperaDatosProductos ('+arrProductos.length+'):'+items.RefEstandar+'/'+items.RefCliente+': '+items.Nombre);

					arrProductos.push(items);
				});

				//
				//if(flag && CheckCamposIniciar !== false){
					prodsInformados = 'S';
				//}
			}
			
			//	Si es una liciatcion activa, recuperamos tambien las ofertas
			if ((EstadoLic=='CURS')||(EstadoLic=='INF'))
				CargaOfertas(0);

			/*	20jul22 Esto no tiene sentido con la nueva licitacion
			if (actTabla=='S')	//15ene20
				prepararTablaProductos(true);

			// Mostramos alert si hay productos con precioRef vacio
			if(flag && precioReferenciaVacio == 1){
				alert(alrt_prodsPrecioRefVacio);
			}*/
		}
	});
}


	// 8mar17	Formulario para modificar las cantidades en la licitacion agregada a traves de la referencia
function ActualizarCantidadesEnLicitacionAgregada()
{
	var oForm=document.forms['frmRefProductosCant'];
	var listRefs = oForm.elements['LIC_LISTA_REFPRODUCTO_CANT'].value;
	var errores=0, msg='';

	if((!errores) && (esNulo(listRefs))){
		errores++;
		msg+=val_faltaReferencia+'\n';
		oForm.elements['LIC_LISTA_REFPRODUCTO_CANT'].focus();
	}else{
		var arrLista	= listRefs.split(/\n/);
		if(arrLista.length > maxLineasParaInsertar){ // 18set16 ET No aceptamos mas de 500 referencias (antes 300)
			errores++;
			var Mensaje=val_maxReferencias.replace("[[NUM_REFS]]",arrLista.length);
			msg+=val_maxReferencias.replace("[[NUM_REFS]]",arrLista.length).replace("[[MAX_REFS]]",maxLineasParaInsertar)+'\n';

			oForm.elements['LIC_LISTA_REFPRODUCTO_CANT'].focus();
		}
	}

	/* si los datos son correctos enviamos el form  */
	if(!errores){
		ActualizarCantidadesEnLicitacionAgregada_Ajax(oForm);
	}
	else
		alert(msg);
}


//	8mar17	Actualiza las cantidades en licitacion agregada. Formato: Ref Cant (separadores válidos: espacio, tabulador, etc)
function ActualizarCantidadesEnLicitacionAgregada_Ajax(oForm)
{
	var Cambios=false;
	
	jQuery("#EnviarProductosPorRef").hide();
	
	//solodebug	var Control='';

	var Referencias	= oForm.elements['LIC_LISTA_REFPRODUCTO_CANT'].value.replace(/(?:\r\n|\r|\n)/g, '|');
	Referencias	= Referencias.replace(/[\t:]/g, ':');	// 	Separadores admitidos para separar referencia de cantidad
	Referencias	= Referencias.replace(/ /g, ':');		// 	Separadores admitidos para separar referencia de cantidad
	
	var numRefs	= PieceCount(Referencias, '|');
	
	for (i=0;i<=numRefs;++i)
	{
		var Producto= Piece(Referencias, '|',i);
		var Ref		= Piece(Producto, ':', 0);
		var Cant	= Piece(Producto, ':', 1);

		//solodebug	debug('ActualizarCantidadesEnLicitacionAgregada_Ajax. Ref['+i+'/'+numRefs+'] Referencia:'+Ref+ '. Cantidad:'+Cant);
		
		if (Ref!='')
		{
			/*//	Recorre el array con los referencias de centro
			for (j=0;((j<arrProductosPorCentro.length) && (!Encont));++j)
			{
				if (arrProductosPorCentro[j].RefCentro==Ref)
				{
					Encont=true;
					jQuery('#Cantidad_' + (arrProductos[ColumnaOrdenadaProds[j]].linea - 1)).val(Cant);
					jQuery('#btnGuardar_' + (arrProductos[ColumnaOrdenadaProds[j]].linea - 1)).show();
				}
			}*/
			
			//solodebug	Control='['+i+'/'+numRefs+'] Referencia:'+Ref+ '. Cantidad:'+Cant+' NumProds:'+arrProductos.length;
		

			//	Recorre el array de productos buscando la referencia
			var Encont=false;
			for (j=0;((j<arrProductos.length) && (!Encont));++j)
			{
		
				//solodebug	debug(Control+'['+i+'/'+numRefs+'] Referencia:'+Ref+ '. Cantidad:'+Cant+' Revisar RefCLi:'+arrProductos[ColumnaOrdenadaProds[j]].RefCliente+' refMvm:'+arrProductos[ColumnaOrdenadaProds[j]].RefEstandar);

				if (ReferenciaCentro(arrProductos[ColumnaOrdenadaProds[j]].IDProdLic)==Ref)
				{
					//solodebug	Control=Control+' encontrado POR REF CENTRO en posicion '+j+' PosOrd:'+(arrProductos[ColumnaOrdenadaProds[j]].linea - 1);
					Encont=true;
				}
				else if ((arrProductos[ColumnaOrdenadaProds[j]].RefCliente==Ref)||(arrProductos[ColumnaOrdenadaProds[j]].RefEstandar==Ref))
				{
					//solodebug	Control=Control+' encontrado POR REF CLI en posicion '+j+' PosOrd:'+ (arrProductos[ColumnaOrdenadaProds[j]].linea - 1);
					Encont=true;
					//Cambios=true;
				}
				
				if (Encont)
				{
					jQuery('#Cantidad_' + (arrProductos[ColumnaOrdenadaProds[j]].Linea - 1)).val(Cant);
					jQuery('#btnGuardar_' + (arrProductos[ColumnaOrdenadaProds[j]].Linea - 1)).show();
					Cambios=true;
				}
				
			}
			
			//solodebug	if (!Encont) Control=Control+'NO ENCONTRADO';

			//solodebug	Control=Control+'\n\r';
			
			//solodebug	debug(Control);
		}
	}

	//solodebug	alert('ActualizarCantidadesEnLicitacionAgregada:'+Referencias+'\n\r'+'\n\r'+Control);

	if (Cambios)
		jQuery("#idGuardarTodasCantidades").show();

	jQuery("#EnviarProductosPorRef").show();
}

//	DEvuelve la referencia de centro correspondiente al producto
function ReferenciaCentro(IDProdLic)
{
	var RefCentro='', Encont=false;
	for (var i=0;(i<arrProductosPorCentro.length)&&(!Encont);++i)
	{
		//solodebug	debug('ReferenciaCentro('+IDProdLic+')'+'. Comprobando arrProductosPorCentro('+i+'):'+arrProductosPorCentro[i].IDProdLic+' RefCentro:'+arrProductosPorCentro[i].RefCentro);
		
		if(arrProductosPorCentro[i].IDProdLic==IDProdLic)
		{
			RefCentro=arrProductosPorCentro[i].RefCentro;
			Encont=true;
		}
	}
	return RefCentro;
}


// 10abr17	Funcion recursiva para guardar los datos de la compra por centro para todas las filas
function guardarTodosDatosCompraAjax(Pos){

	//	Si hemos superado el límite, sale
	if (Pos>=arrProductos.length)
	{
		jQuery("#idGuardarTodasCantidades").hide();
		return;
	}
	
	//	Comprueba si esta fila ha sido modificada, si no pasa a la siguiente
	if (!jQuery('#btnGuardar_'+Pos).is(':visible'))
	{
		guardarTodosDatosCompraAjax(Pos+1);
		return;
	}

	//	Declaración de variables
	var oForm = document.forms['PublicarCompras'];
	var RefCliente	= (arrProductos[Pos].RefCliente != '') ? arrProductos[Pos].RefCliente : arrProductos[Pos].RefEstandar;
	var precioObj	= arrProductos[Pos].PrecioObj;
	var precioObjFormat	= parseFloat(precioObj.replace(/\./g,"").replace(',', '.'));
	var enviarOferta = false;
	var controlPrecio = '';
	var errores = 0;
	

	// Validacion Precio
	var cantidad		= jQuery('#Cantidad_' + Pos).val();
	var cantidadFormat	= cantidad.replace(",",".");
	if(!errores && esNulo(cantidadFormat)){
		errores++;
		alert(val_faltaCantidad.replace("[[REF]]",RefCliente));
		oForm.elements['Cantidad_' + Pos].focus();
		return false;
	}else if(!errores && isNaN(cantidadFormat)){
		errores++;
		alert(val_malCantidad.replace("[[REF]]",RefCliente));
		oForm.elements['Cantidad_' + Pos].focus();
	}
	if(!errores){
		var IDLicProd	= arrProductos[Pos].IDProdLic;
		var IDCentro = oForm.elements['IDCENTROCOMPRAS'].value;
		var IDFicha = '';
		if(jQuery("#IDFICHA_" + Pos).val() > 0){
			IDFicha = jQuery("#IDFICHA_" + Pos).val();
		}
		var Cantidad = arrProductos[Pos].Cantidad;
		var d = new Date();

		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/InformarDatosCOmpraAJAX.xsql',
			type:	"GET",
			data:	"LIC_ID="+IDLicitacion+"&LIC_PROD_ID="+IDLicProd+"&IDCENTRO="+IDCentro+"&CANTIDAD="+cantidad+"&_="+d.getTime(),
			beforeSend: function(){
				jQuery('#btnGuardar_'+Pos).hide();
			},
			error: function(objeto, quepaso, otroobj){
				jQuery('#AVISOACCION_'+Pos).html('<img src="http://www.newco.dev.br/images/error.gif"/>');
				alert('error'+quepaso+' '+otroobj+' '+objeto);
			},
			success: function(objeto){
				var data = JSON.parse(objeto);

				if(data.OfertaActualizada.IDOferta > 0){
					jQuery('#AVISOACCION_'+Pos).html('<img src="http://www.newco.dev.br/images/recibido.gif"/>');
				}else{
					jQuery('#AVISOACCION_'+Pos).html('<img src="http://www.newco.dev.br/images/recibido.gif"/>');
				}

				guardarTodosDatosCompraAjax(Pos+1);
				return;

			}
		});
	}

}


// 12set16	Comprueba que la licitacion esta lista para poder informar los consumos
function NoInformacionCompras(){

	if (isLicAgregada == 'S' && NumCentrosEnLicitacion>0){
		CambioEstadoLicitacion('COMP');
	}else{
		Mensaje=alrt_NoIniciarLicCentros;
		
		alert(Mensaje);
	}
}


//	Publica los datos de compra por centro
function PublicarDatosCompra()
{
	var oForm = document.forms['PublicarCompras'];
	var IDCentro = oForm.elements['IDCENTROCOMPRAS'].value;
	var d = new Date();
	
	//solodebug	alert('Publicar datos compra para el centro:'+IDCentro+' de la licitación '+IDLicitacion);

	jQuery("#botonPublicarCompra").hide();
	
	//	Si hay un desplegable de
	if (oForm.elements['IDCENTROCOMPRAS'].type=='select-one')
	{
		var sel = oForm.elements['IDCENTROCOMPRAS'];
		var IDCentro = '';
		for (var i = 0; i < sel.children.length; ++i) {
			IDCentro += sel.children[i].value+'|';
		}
	}
	
	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/PublicarComprasCentroAJAX.xsql',
		type:	"GET",
		data:	"IDLICITACION="+IDLicitacion+"&IDCENTRO="+IDCentro+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			var data = JSON.parse(objeto);

			if(data.DatosPublicados.estado == 'Si'){
				location.href = 'http://www.newco.dev.br/Gestion/Comercial/LicitacionV2_2022.xsql?LIC_ID=' + IDLicitacion;
			}else{
				alert(alrt_NuevoEstadoLicKO);
				jQuery("#botonPublicarCompra").show();
			}
		}
	});

}


//	Adjudicar ofertas
function AdjudicarOfertas(){
	var checkAdj = true, confirmChk=false, checkUdsXLote=false;
	
	//11ene23 Desactivamos durante la carga de ofertas
	if (cargaOfertasStatus=='Inicio') return;

	jQuery('.botonAccion').hide();
	
	//	Hacemos aqui las comprobaciones básicas que pueden dar lugar a errores antes de adjudicar
	if (CuentaSeleccionados()==0) {
		productosOlvidados = 'S';
	}
	else{
		productosOlvidados = 'N';
	}
		

	//	14set20 Control fecha de pedido posterior a la actual
	var oForm = document.forms['frmDatosGenerales'];
	if (oForm.elements['LIC_FECHAENTREGAPEDIDO'].value!='')
	{
		var hoy = new Date(),
		hoyOrd=hoy.getFullYear()*10000+(hoy.getMonth()+1)*100+hoy.getDate();			//	Este formato es más eficiente para comparar fechas

		var AnnoPed=parseInt(Piece(oForm.elements['LIC_FECHAENTREGAPEDIDO'].value,'/',2));
		if (AnnoPed<2000) AnnoPed+=2000;

 		var fechaPed=AnnoPed*10000+parseInt(Piece(oForm.elements['LIC_FECHAENTREGAPEDIDO'].value,'/',1))*100+parseInt(Piece(oForm.elements['LIC_FECHAENTREGAPEDIDO'].value,'/',0));

		//	solodebug
		console.log('GenerarPedido. hoyOrd:'+hoyOrd+' fechaPed:'+fechaPed);

		if (fechaPed<=hoyOrd)
		{
			alert(alrt_fechaEntregaPedidoAnteriorAFechaDeHoy);
			return;
		}
	}
		
	//solodebug	alert('AdjudicarOfertas numProdsSeleccion:'+numProdsSeleccion+' productosOlvidados:'+productosOlvidados);
		

	if(productosOlvidados == 'N'){

		// Solo validamos importe pedido minimo para licitaciones de 'pedido puntual'
		if(mesesSelected == 0){
			if	(isLicAgregada == 'S')
			{
				checkAdj = validarPedidosMinimosAgr();
				if (!checkAdj)
				{
					if (saltarPedMinimo=='N')						//	7nov19 Permitir saltar pedido mínimo
						alert(alrt_pedidoMinimoGlobalKO);
					else
						checkAdj=confirm(alrt_avisoSaltarPedidoMinimo);
				}
			}
			else
				checkAdj = validarPedidosMinimos(1);
		}
		if(checkAdj){
			// Comprobamos cantidad respecto udsXLote del proveedor
			var checkUdsXLote;
			if	(isLicAgregada == 'S')
			{
				checkUdsXLote = compruebaUdsXLoteAgr();
			}
			else
			{
				checkUdsXLote = compruebaUdsXLote();
			}

			if(!checkUdsXLote){
				if(confirm(conf_autoeditar_uds_x_lote)){
					if	(isLicAgregada == 'S')
					{
						calcularCantidadesAutoAgr();
					}
					else
					{
						calcularCantidadesAuto();
					}
					jQuery('.botonAccion').show();
					return;
				}else{
					jQuery('.botonAccion').show();
					return;
				}
			}

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

			if(confirmChk)
			{
				jQuery("#botonAdjudicarSelec").hide();	
				jQuery("#waitBotonAdjudicar").show();	
				CambioEstadoLicitacion('ADJ');
			}
		}
	}else{
		alert(alrt_faltaSeleccProductos);
	}

	jQuery('.botonAccion').show();
}



//	30set22 Descartar oferta, por no cumplir criterio de marca o similar (adaptado desde FichaProductoLicitacion)
function DescartarOferta(PosProd, IDOfertaLic)
{
	var PosOferta=BuscaEnArray(arrProductos[PosProd].Ofertas, "ID",IDOfertaLic);
	if (arrProductos[PosProd].Ofertas[PosOferta].OfertaAdjud=='S')
	{
		alert(alrt_NoBorrarOfertaAdjudicada);;
	}
	else
	{
		jQuery('#lMotivo_'+IDOfertaLic).show();
		jQuery('#btnDescartar_'+IDOfertaLic).hide();
	}
}

function CancDescartarOferta(IDOfertaLic)
{
	jQuery('#lMotivo_'+IDOfertaLic).hide();
	jQuery('#btnDescartar_'+IDOfertaLic).show();
}

function EjecDescartarOferta(PosProd, IDOfertaLic)
{
	var msgError='';
	var IDProdLic=arrProductos[PosProd].ID;
	var IDMotivo=jQuery("#IDMOTIVOSELECCION_"+IDOfertaLic).val();
	var Motivo=jQuery("#MOTIVOSELECCION_"+IDOfertaLic).val();
	var PosOferta=BuscaEnArray(arrProductos[PosProd].Ofertas, "ID",IDOfertaLic);
	var PosProv=BuscaEnArray(arrProveedores, "IDProvLic",arrProductos[PosProd].Ofertas[PosOferta].IDPROVEEDORLIC);

	if (IDMotivo=='')
	{
		msgError+=alrt_RequiereMotivo+'\n';
	}

	if (msgError!='')
	{
		alert(msgError);
		return;
	}
		
	//	COnfirmar descartar oferta
	if (!confirm(alrt_ConfirmDescartarOferta)) return;

	var d = new Date();

	//solodebug	
	debug("EjecDescartarOferta. LIC_ID:"+IDLicitacion+" IDPRODUCTOLIC:"+IDProdLic+" IDOFERTALIC:"+IDOfertaLic+' PosOferta:'+PosOferta+' Adjud:'+arrProductos[PosProd].Ofertas[PosOferta].OfertaAdjud+ ' PosProv:'+PosProv+	' Prov:'+arrProveedores[PosProv].NombreCorto+" IDMOTIVO:"+IDMotivo+" MOTIVO:"+encodeURIComponent(Motivo));

	//solodebug	 alert("LIC_ID="+IDLicitacion+"&IDPRODUCTOLIC="+IDProdLic+"&IDOFERTALIC="+IDOfertaLic+"&IDMOTIVO="+IDMotivo+"&MOTIVO="+encodeURIComponent(Motivo));

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

				//	Actualiza datos proveedor
				//	Elimina oferta
				arrProductos[PosProd].Ofertas.splice(PosOferta,1);

				//	Muestra la ficha de producto actualizada
				AbrirProducto(PosProd);
				
			}else{
				alert(alrt_DescartarOfertaKO);
				CancDescartarOferta(IDOfertaLic);
       	        return;
			}
		}
	});


}


//	15nov22 Borrar un producto de la licitacion, adaptado desde "modificaProducto" de lic_211221.js
function BorrarProducto(PosProd){
	var d = new Date();
	
	if (!confirm(alrt_avisoBorrarProducto))	
		return;
	
	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/ModificaEstadoProducto.xsql',
		type:	"GET",
		data:	"ID_PROD_LIC="+arrProductos[PosProd].IDProdLic+"&ESTADO_PROD=B&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			var data = JSON.parse(objeto);

			if	(data.ModificaEstadoProducto.estado == 'OK')
			{

				//	Elimina producto del array
				arrProductos.splice(PosProd, 1);

				//	Recalcula totales a nivel de proveedor
				ActualizaTotales();

				//	Decrementa el numero de productos (utilizado para mostrar 1/3 en la ficha de cada producto)
				totalProductos=arrProductos.length;

				//	Redibuja la pagina en la que estemos
				CambiaVista();
			}
			else
				alert(alrt_errorEliminarProduct);
		}
	});
}


