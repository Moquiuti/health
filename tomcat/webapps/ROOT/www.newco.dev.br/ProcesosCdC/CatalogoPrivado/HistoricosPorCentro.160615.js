
//	Variables globales
var	TotalProductos,			// numero total de productos
	NumProductos,			// numero de productos que se muestran en la tabla (desplegable numRegistros)
	PagProductos		= 0,	// pagina actual
	PagsProdTotal,			// total de paginas segun valor numRegistros
	FirstProduct,			// primer indice de producto a mostrar en la tabla
	LastProduct,			// ultimo indice de producto a mostrar en la tabla
	ColumnaOrdenacion	= 'linea';
	ColumnaOrdenada		= [],
	Orden			= '',
	FiltroNombre		= '',
	IDTabla			= '1',
	ConsumoPorcentual	= false;


jQuery(document).ready(globalEvents);

function globalEvents(){
	// Para dibujar la tabla si hay cambios en el desplegable de registros
	jQuery('.numRegistros').change(function(){
		jQuery('.numRegistros').val(this.value);
		dibujarTabla();
	});

	// Para mostrar el tipo de vista (tabla) que elige el usuario
	jQuery('#TipoVista').change(function(){
		IDTabla = this.value;
		dibujarTabla();
	});

	// Para mostrar la info del consumo en porcentaje
	jQuery('#ConsPorcentual').click(function(){
		ConsumoPorcentual = jQuery(this).is(':checked');
		dibujarTabla();
	});

	// Para mostrar el tipo de vista (tabla) que elige el usuario
//	jQuery('#AgregarPor').change(function(){
//		var AgregarPor = this.value;
//		if(AgregarPor != ''){
//			MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/HistoricosPorCentroAgregado.xsql?IDEMPRESA='+IDEmpresa+'&AGRUPAR_POR='+AgregarPor,'Historicos por centro agrupado',80,80,0,0);
//		}
//	});

	// Para permitir abrir la pagina de producto haciendo click en toda la fila
	if(AgruparPor == 'REFESTANDAR'){
		jQuery('.TblHistPorCentro tbody').on('click', 'tr', function() {
			var IDProducto = arrayProdsEstandar[this.id.replace('posArr_', '')].ID;
			MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/HistoricosCentros.xsql?ID_EMP='+IDEmpresa+'&ID_PROD_ESTANDAR='+IDProducto,'Ficha Centro',80,80,0,0);
		});
	}

	ordenacionDefecto();
	dibujarTabla();
}

var rowStart		= '<tr>';
var rowStartIDStyle	= '<tr id="#ID#" style="#STYLE#">';
var rowEnd		= '</tr>';

var cellStart		= '<td>';
var cellStartClass	= '<td class="#CLASS#">';
var cellStartClassStyle	= '<td class="#CLASS#" style="#STYLE#">';
var cellEnd		= '</td>';

var anchorStart		= '<a href="#HREF#" style="text-decoration:none;">';
var anchorEnd		= '</a>';

function dibujarTabla(){
	var htmlTBODY = '', thisRow = '', thisCell = '' , thisMacro = '', functionJS = '';

	jQuery(".TblHistPorCentro").hide().find('tbody').empty();

	if(TotalProductos > 0){
		// Numero de registros para mostrar en la tabla
		NumProductos	= parseInt(jQuery('.numRegistros').val());

		// Redondeamos para saber el numero de paginas totales
		PagsProdTotal = Math.ceil(TotalProductos / NumProductos);
		// Calculamos el producto inicial y final que se tienen que mostrar en la tabla
		FirstProduct	= PagProductos * NumProductos;
		LastProduct	= (TotalProductos < (PagProductos * NumProductos) + NumProductos) ? TotalProductos : ((PagProductos * NumProductos) + NumProductos) ;

		// Correccion en la paginacion en caso particular
		if(FirstProduct >= LastProduct){
			PagProductos = PagsProdTotal - 1;
			FirstProduct	= PagProductos * NumProductos;
		}

//	for(var key=0; key<TotalProductos; key++){
		for(var key=FirstProduct; key<LastProduct; key++){
			// INICIO fila con info producto estandar
			thisRow = rowStartIDStyle.replace('#ID#', 'posArr_' + (arrayProdsEstandar[ColumnaOrdenada[key]].linea)).replace('#STYLE#', 'border-bottom:1px solid #999;');

			// Ref.MVM
			thisCell = cellStartClassStyle.replace('#CLASS#', 'borderLeft datosLeft').replace('#STYLE#', 'padding:0 3px;');
			if(AgruparPor == 'REFESTANDAR'){
				functionJS = 'javascript:AbrirFichaProducto(' + arrayProdsEstandar[ColumnaOrdenada[key]].ID + ');';
				thisCell += anchorStart.replace('#HREF#', functionJS);
				thisCell += '<span class="toHighlight">' + arrayProdsEstandar[ColumnaOrdenada[key]].Referencia + '</span>';
				thisCell += anchorEnd;
			}else{
				thisCell += '<span class="toHighlight">' + arrayProdsEstandar[ColumnaOrdenada[key]].Referencia + '</span>';
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// Ref.Cliente
			thisCell = cellStartClassStyle.replace('#CLASS#', 'borderLeft datosRight').replace('#STYLE#', 'padding:0 3px;');
			thisCell += '<span class="toHighlight">' + arrayProdsEstandar[ColumnaOrdenada[key]].RefCliente + '</span>';
			thisCell += cellEnd;
			thisRow += thisCell;

			// Descripcion Estandar
			thisCell = cellStartClassStyle.replace('#CLASS#', 'borderLeft datosLeft').replace('#STYLE#', 'padding:0 3px;');
			thisCell += '<strong><span class="toHighlight">' + arrayProdsEstandar[ColumnaOrdenada[key]].Nombre + '</span></strong>&nbsp;';//thisCell += arrayProdsEstandar[ColumnaOrdenada[key]].Nombre;
			thisCell += cellEnd;
			thisRow += thisCell;

			// Ud.Basica
			thisCell = cellStartClass.replace('#CLASS#', 'borderLeft');
			thisCell += arrayProdsEstandar[ColumnaOrdenada[key]].UdBasica;
			thisCell += cellEnd;
			thisRow += thisCell;

			// Precio Medio
			thisCell = cellStartClassStyle.replace('#CLASS#', 'borderLeft datosRight').replace('#STYLE#', 'padding:0 3px;');
			thisCell += arrayProdsEstandar[ColumnaOrdenada[key]].PrecioMedio;
			thisCell += cellEnd;
			thisRow += thisCell;

			// Precio MVM
			thisCell = cellStartClassStyle.replace('#CLASS#', 'borderLeft datosRight').replace('#STYLE#', 'padding:0 3px;');
			if(arrayProdsEstandar[ColumnaOrdenada[key]].Sospechoso == 'S'){
				thisCell += '<img src="http://www.newco.dev.br/images/change.png" style="vertical-align:top"/>&nbsp;';
			}
			thisCell += arrayProdsEstandar[ColumnaOrdenada[key]].PrecioMVM;
			thisCell += cellEnd;
			thisRow += thisCell;

			// Ahorro (%)
			thisCell = cellStartClassStyle.replace('#CLASS#', 'borderLeft datosRight').replace('#STYLE#', 'padding:0 3px;');
			thisCell += arrayProdsEstandar[ColumnaOrdenada[key]].AhorroPorc;
			thisCell += cellEnd;
			thisRow += thisCell;

			// Consumo Anual
			thisCell = cellStartClassStyle.replace('#CLASS#', 'borderLeft datosRight').replace('#STYLE#', 'padding:0 3px;');
			if(ConsumoPorcentual !== true)
				thisCell += arrayProdsEstandar[ColumnaOrdenada[key]].ConsAnual;
			else
				if(arrayProdsEstandar[ColumnaOrdenada[key]].ConsPorc != '')
					thisCell += arrayProdsEstandar[ColumnaOrdenada[key]].ConsPorc + '%';
			thisCell += cellEnd;
			thisRow += thisCell;

			// Ahorro
			thisCell = cellStartClassStyle.replace('#CLASS#', 'borderLeft datosRight').replace('#STYLE#', 'padding:0 3px;');
			thisCell += arrayProdsEstandar[ColumnaOrdenada[key]].Ahorro;
			thisCell += cellEnd;
			thisRow += thisCell;

			jQuery.each(arrayProdsEstandar[ColumnaOrdenada[key]].Centros, function(key2, centro){
				if(IDTabla == '1'){
					// Precio
					thisCell = cellStartClassStyle.replace('#CLASS#', 'borderLeft datosRight').replace('#STYLE#', 'padding:0 3px;');
					if(centro.Sospechoso == 'S'){
						thisCell += '<img src="http://www.newco.dev.br/images/change.png" style="vertical-align:top"/>&nbsp;';
					}
					thisCell += centro.Precio;
					thisCell += cellEnd;
					thisRow += thisCell;
                                }else if(IDTabla == '2'){
					// Consumo
					thisCell = cellStartClassStyle.replace('#CLASS#', 'borderLeft datosRight').replace('#STYLE#', 'padding:0 3px;');
//					if(centro.Sospechoso == 'S'){
//						thisCell += '<img src="http://www.newco.dev.br/images/change.png" style="vertical-align:top"/>&nbsp;';
//					}
					if(ConsumoPorcentual !== true)
						thisCell += centro.ConsumoAnual;
					else
						if(centro.ConsumoPorc != '')
							thisCell += centro.ConsumoPorc + '%';
					thisCell += cellEnd;
					thisRow += thisCell;
                                }else if(IDTabla == '3'){
					// Precio
					thisCell = cellStartClassStyle.replace('#CLASS#', 'borderLeft datosRight').replace('#STYLE#', 'padding:0 3px;');
					if(centro.Sospechoso == 'S'){
						thisCell += '<img src="http://www.newco.dev.br/images/change.png" style="vertical-align:top"/>&nbsp;';
					}
					thisCell += centro.Precio;
					thisCell += cellEnd;
					thisRow += thisCell;

					// Consumo
					thisCell = cellStartClassStyle.replace('#CLASS#', 'borderLeft datosRight').replace('#STYLE#', 'padding:0 3px;');
//					if(centro.Sospechoso == 'S'){
//						thisCell += '<img src="http://www.newco.dev.br/images/change.png" style="vertical-align:top"/>&nbsp;';
//					}
					if(ConsumoPorcentual !== true)
						thisCell += centro.ConsumoAnual;
					else
						if(centro.ConsumoPorc != '')
							thisCell += centro.ConsumoPorc + '%';
					thisCell += cellEnd;
					thisRow += thisCell;					
				}else if(IDTabla == '4'){
					// Precio
					thisCell = cellStartClassStyle.replace('#CLASS#', 'borderLeft datosRight').replace('#STYLE#', 'padding:0 3px;');
					if(centro.Sospechoso == 'S'){
						thisCell += '<img src="http://www.newco.dev.br/images/change.png" style="vertical-align:top"/>&nbsp;';
					}
					thisCell += centro.Precio;
					thisCell += cellEnd;
					thisRow += thisCell;

					// Consumo
					thisCell = cellStartClassStyle.replace('#CLASS#', 'borderLeft datosRight').replace('#STYLE#', 'padding:0 3px;');
//					if(centro.Sospechoso == 'S'){
//						thisCell += '<img src="http://www.newco.dev.br/images/change.png" style="vertical-align:top"/>&nbsp;';
//					}
					if(ConsumoPorcentual !== true)
						thisCell += centro.ConsumoAnual;
					else
						if(centro.ConsumoPorc != '')
							thisCell += centro.ConsumoPorc + '%';
					thisCell += cellEnd;
					thisRow += thisCell;

					// Ahorro
					thisCell = cellStartClassStyle.replace('#CLASS#', 'borderLeft datosRight').replace('#STYLE#', 'padding:0 3px;');
//					if(centro.Sospechoso == 'S'){
//						thisCell += '<img src="http://www.newco.dev.br/images/change.png" style="vertical-align:top"/>&nbsp;';
//					}
					if(centro.AhorroPorc != ''){
						thisCell += centro.AhorroPorc + '%';
					}else{
						thisCell += '&nbsp;';
					}
					thisCell += cellEnd;
					thisRow += thisCell;					
				}
			});

			thisRow += rowEnd;
			htmlTBODY += thisRow;
		}
		// Aqui montamos los enlaces para la paginación y tb la leyenda
		calcularPaginacion();
	}
//console.log('dibuja: ' + IDTabla);
//console.log(htmlTBODY);
	jQuery('#TblHistPorCentro_' + IDTabla).show().find('tbody').append(htmlTBODY);

	if(FiltroNombre != ''){
		highlightString();
	}

}

function ordenacionDefecto(){
	TotalProductos	= arrayProdsEstandar.length;

	for(var i=0; i<TotalProductos; i++){
		arrayProdsEstandar[i].linea	= i;
		ColumnaOrdenada[i]		= i;
	}
}

function Ordenacion(campo){
	if(ColumnaOrdenacion == campo && campo != 'Texto'){
		if(Orden == 'ASC'){
			Orden = 'DESC';
       	        }else{
			Orden = 'ASC';
       	        }
	}else{
		ColumnaOrdenacion = campo;
		Orden = 'ASC';
	}

	//	Si la columna es string, ordenamiento alfabetico
	if(campo == 'RefMVM' || campo == 'RefCliente' || campo == 'Nombre'){
		ordenamientoAlfabet(campo, Orden);
	//	Si la columna es numerica, ordenamiento burbuja
	}else{
		ordenamientoBurbuja(campo, Orden);
	}

	dibujarTabla();
}

//	Prepara un array con los ordenes correspondientes a una columna de numeros
function ordenamientoBurbuja(col, tipo){
	var temp, temp2, size, valAux, column='', posArr;
	var arrValores = new Array();

	if(col.indexOf("PrecioCentro_") >= 0){
		column = 'Precio';
		posArr = col.replace("PrecioCentro_", "") - 1;
	}else if(col.indexOf("ConsumoCentro_") >= 0){
		column = 'ConsumoAnual';
		posArr = col.replace("ConsumoCentro_", "") - 1;
	}else if(col.indexOf("AhorroCentro_") >= 0){
		column = 'AhorroPorc';
		posArr = col.replace("AhorroCentro_", "") - 1;
	}

	// Creamos un vector auxiliar con los valores que queremos ordenar (segun el vector de ordenacion)
	for(var i=0; i<TotalProductos; i++){
		if(column!=''){
			valAux = (arrayProdsEstandar[ColumnaOrdenada[i]].Centros[posArr][column].replace(/\./g,'').replace(',','.') != '') ? arrayProdsEstandar[ColumnaOrdenada[i]].Centros[posArr][column].replace(/\./g,'').replace(',','.') : '0';
		}else{
			valAux = (arrayProdsEstandar[ColumnaOrdenada[i]][col].replace(/\./g,'').replace(',','.') != '') ? arrayProdsEstandar[ColumnaOrdenada[i]][col].replace(/\./g,'').replace(',','.') : '0';
		}
		arrValores.push(parseFloat(valAux));
	}

	size = TotalProductos;
	for(var pass = 1; pass < size; pass++){ // outer loop
		for(var left = 0; left < (size - pass); left++){ // inner loop
			var right = left + 1;

			// Comparamos valores del vector auxiliar
			if(arrValores[left] > arrValores[right]){
				// Intercambiamos valores del vector auxiliar y del vector de ordenacion, ya este ultimo es el que queremos ordenar y estan relacionados
				temp=ColumnaOrdenada[left];
				temp2=arrValores[left];
				ColumnaOrdenada[left]=ColumnaOrdenada[right];
				arrValores[left]=arrValores[right];
				ColumnaOrdenada[right]=temp;
				arrValores[right]=temp2;
			}
		}
	}

	//	En caso de ordenacion descendiente intercambiamos de forma simetrica el vector de ordenacion
	if(tipo=='DESC'){
		for(i=1; i<=TotalProductos/2; i++){
			temp=ColumnaOrdenada[TotalProductos-i];
			ColumnaOrdenada[TotalProductos-i]=ColumnaOrdenada[i-1];
			ColumnaOrdenada[i-1]=temp;
		}
	}
}

//	Prepara un array con los ordenes correspondientes a una columna de caracteres alfanumericos
function ordenamientoAlfabet(col, tipo){
	var temp, temp2, size, valAux;
	var arrValores = new Array();

	// Creamos un vector auxiliar con los valores que queremos ordenar (segun el vector de ordenacion)
	for(var i=0; i<TotalProductos; i++){
		valAux = arrayProdsEstandar[ColumnaOrdenada[i]][col].trim();
		arrValores.push(valAux);
	}

	size = TotalProductos;
	for(var pass = 1; pass < size; pass++){ // outer loop
		for(var left = 0; left < (size - pass); left++){ // inner loop
			var right = left + 1;

			// Comparamos valores del vector auxiliar
			if(arrValores[left] > arrValores[right]){
				// Intercambiamos valores del vector auxiliar y del vector de ordenacion, ya este ultimo es el que queremos ordenar y estan relacionados
				temp=ColumnaOrdenada[left];
				temp2=arrValores[left];
				ColumnaOrdenada[left]=ColumnaOrdenada[right];
				arrValores[left]=arrValores[right];
				ColumnaOrdenada[right]=temp;
				arrValores[right]=temp2;
			}
		}
	}

	//	En caso de ordenacion descendiente intercambiamos de forma simetrica el vector de ordenacion
	if(tipo=='DESC'){
		for(i=1; i<=TotalProductos/2; i++){
			temp=ColumnaOrdenada[TotalProductos-i];
			ColumnaOrdenada[TotalProductos-i]=ColumnaOrdenada[i-1];
			ColumnaOrdenada[i-1]=temp;
		}
	}
}

function filtrarProductosBeforeAjax(id){
	var cadena = jQuery('#' + id).val();

	jQuery('.filtroProductos').val(cadena);
	FiltroNombre = cadena;
	normalizarString(cadena, filtrarProductosAfterAjax);
}

function filtrarProductosAfterAjax(cadenaNorm){
	var arrStr	= cadenaNorm.split(" ");
	var check;

	if(cadenaNorm != ''){
		jQuery.each(arrayProdsEstandar, function(key, linea){
			check = true;

			for(var i=0; i<arrStr.length; i++){
				if(linea.TxtBusqueda.indexOf(arrStr[i]) < 0){
					check = false;
					break;
				}
			}

			if(check){
				linea.Texto = '0';
			}else{
				linea.Texto = '1';
			}
		});



/*
		jQuery.each(arrayProdsEstandar, function(key, producto){
			if(producto.TxtBusqueda.indexOf(FiltroNombre) > -1){
				producto.Texto = '0';
			}else{
				producto.Texto = '1';
			}
		});
*/
		Ordenacion('Texto');
	}
}

function CampoConEstilo(value){
	var ini = value.indexOf(FiltroNombre);
	if(ini > -1  && FiltroNombre != '' && ColumnaOrdenacion == 'Texto'){
		var length	= FiltroNombre.length;
		var field	= value.substr(0, ini);
			field	+= '<span style="background-color:yellow;">';
			field	+= value.substr(ini, length);
			field	+= '</span>';
			field	+= value.substr(ini + length);
		return field;
	}else{
		return value;
	}
}

function NombreProductoConEstilo(pos){
	var ini = arrayProdsEstandar[ColumnaOrdenada[pos]].NombreNorm.indexOf(FiltroNombre);
	if(ini > -1  && FiltroNombre != '' && ColumnaOrdenacion == 'Texto'){
		var length	= FiltroNombre.length;
		var nombre	= arrayProdsEstandar[ColumnaOrdenada[pos]].Nombre.substr(0, ini);
			nombre	+= '<span style="background-color:yellow;">';
			nombre	+= arrayProdsEstandar[ColumnaOrdenada[pos]].Nombre.substr(ini, length);
			nombre	+= '</span>';
			nombre	+= arrayProdsEstandar[ColumnaOrdenada[pos]].Nombre.substr(ini + length);
		return nombre;
	}else{
		return arrayProdsEstandar[ColumnaOrdenada[pos]].Nombre;
	}
}

function calcularPaginacion(){
	var pagAnterior, pagSiguiente;
	var innerHTML = '';

	// Pagina anterior
	if(FirstProduct != 0){
		pagAnterior = PagProductos - 1;
	}

	// Pagina siguiente
	if(LastProduct != TotalProductos){
		pagSiguiente = PagProductos + 1;
	}

	// Info Pagina actual
	if(pagAnterior !== undefined){
		innerHTML = '<a style="text-decoration:none;font-size:11px;" href="javascript:paginacion(' + pagAnterior + ');">' + str_PagAnterior + '</a>';
		jQuery('.pagAnterior').html(innerHTML);
	}else{
		jQuery('.pagAnterior').html('');
	}

	if(pagSiguiente !== undefined){
		innerHTML = '<a style="text-decoration:none;font-size:11px;" href="javascript:paginacion(' + pagSiguiente + ');">' + str_PagSiguiente + '</a>';
		jQuery('.pagSiguiente').html(innerHTML);
	}else{
		jQuery('.pagSiguiente').html('');
	}

	innerHTML = str_Paginacion.replace('[[PAGACTUAL]]', (PagProductos + 1)).replace('[[PAGTOTAL]]', PagsProdTotal).replace('[[TOTALPRODUCTOS]]', TotalProductos);
	jQuery('.paginacion').html(innerHTML);

	if(PagsProdTotal > 1){
		jQuery('.leyendaPaginacion').css('border', '2px solid red');
		jQuery('.leyendaPaginacion td').css('background-color', '#FFFF99');
		jQuery('.pagAnterior a').css('color', 'red');
		jQuery('.pagSiguiente a').css('color', 'red');
	}else{
		jQuery('.leyendaPaginacion').css('border', '1px solid #999');
		jQuery('.leyendaPaginacion td').css('background-color', 'rgba(0, 0, 0, 0)');
	}
}

function paginacion(numPag){
	PagProductos = numPag;
	dibujarTabla();
}

function AbrirFichaCentro(IDCentro){
	MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?ID='+IDCentro,'Ficha Centro',80,80,0,0);
}

function AbrirFichaProducto(IDProducto){
	MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/HistoricosCentros.xsql?ID_EMP='+IDEmpresa+'&ID_PROD_ESTANDAR='+IDProducto,'Ficha Centro',80,80,0,0);
}

function AbrirHistoricosAgregados(tipo){
	MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/HistoricosPorCentroAgregado.xsql?IDEMPRESA='+IDEmpresa+'&AGRUPAR_POR='+tipo,'Historicos por centro agrupado',80,80,0,0);
}

function highlightString(){
	var arrStr	= FiltroNombre.split(" ");

	for(var i=0; i<arrStr.length; i++){
		jQuery('.toHighlight').highlight(arrStr[i]);
	}
}