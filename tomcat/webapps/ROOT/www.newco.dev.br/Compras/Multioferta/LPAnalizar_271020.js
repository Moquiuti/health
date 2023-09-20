//	Javascript para el primer paso del pedido
//	Última revisión: ET 27oct20 17:45 LPAnalizar_271020.js



var v_SolicitudMuestras	= 'NO';			//	control de solicitud de muestras
var v_OrdenarProductos	= 'NO';			//	control para ordenar productos alfabéticamente (Solución para Brasil)
var estadoSeleccion	= false;			//	estado actual para todos los checkboxes (seleccionado o no seleccionado)
var filtroTXT		= '';				//	Valor del filtro
var v_OcultarNoSeleccionados= 'NO';		//	Para plantillas largas, ocultaremos las líneas no seleccionadas
var FiltroSeleccion = false;			//	Variable global para informar si estamos filtrando por texto o no
var cLimitePlantillaVisible=200;		//	Limite de plantilla máximo para el funcionamiento tradicional. Subimos de 150 a 200 por solicitud de Healthtime (4oct19)
var	tipoPlantilla;						//	Tipo de plantilla

var totalProductos,											// numero total de productos en el listado
		ColumnaOrdenacionProds	= 'linea',
		OrdenProds		= 'ASC',
		ColumnaOrdenadaProds	= [];

jQuery(document).ready(globalEvents);

function globalEvents(){

	// Definimos el tipo de plantilla que usaremos
	if((nuevoModeloNegocio=='N' && pedidoAntiguo=='N' /*&& mostrarPrecioIVA=='N'*/) || IDPais=='55'){
		tipoPlantilla = 'asisaBrasil';
	//}else if(nuevoModeloNegocio=='N' && pedidoAntiguo=='N' && mostrarPrecioIVA=='S'){
	//	tipoPlantilla = 'viamedNuevo';
	}else if(nuevoModeloNegocio=='S' && pedidoAntiguo=='S'){
		tipoPlantilla = 'nuevoModeloViejoPedido';
	}else if(nuevoModeloNegocio=='S' && pedidoAntiguo=='N'){
		tipoPlantilla = 'nuevoModeloNuevoPedido';
	}
	
	//	ET	11may16
	if (sinCategorias=='S') v_OrdenarProductos='SI';
	
	//	ET	26may17		
	if (arrayLineasProductos.length>cLimitePlantillaVisible)
	{
		v_OcultarNoSeleccionados='SI';
		
		aplicarFiltro('··· CADENA QUE NO DEBE SER ENCONTRADA ZZZ','');
	}
	

	jQuery("#strFiltro").on('input propertychange', function(){
		filtroTXT	= jQuery.trim(this.value.toLowerCase());

		//solodebug	console.log('jQuery("#strFiltro") filtro:'+filtroTXT);
		
		aplicarFiltro(filtroTXT, '');
	});

	// Prepara el array de ordenación para preparar los datos para dibujar la tabla
	prepararTablaProductos();

	// Validamos por si hay cantidades que no se corresponden con las UdsXLote (no son multiplo)
	validarCantidades();

	if (document.forms['formBot'].elements['CENTROSVISIBLES'].value=='S')
		inicializarDesplegableCentros(-1);
	else
		inicializarDesplegableCentros(document.forms['formBot'].elements['IDCENTRO'].value);

	// Se calculan las fechas de forma automatica
	//	7feb20	calculaFecha('ENTREGA',document.forms[0].elements['COMBO_ENTREGA'].value);
	if (saltarPedMinimo=='N') inicializaDesplegablePlazoEntrega();
	calculaFecha('ENTREGA',document.forms[0].elements['PLAZOCONSULTA'].value);

}

//	7feb20 Quita los valores inferiores al plazo de entrega
function inicializaDesplegablePlazoEntrega()
{
	var sel = document.getElementById('PLAZOCONSULTA'); 


	while (sel[0] && sel[0].value<plazoEntrega)
		sel.remove(sel[0]);
}


//	Inicializa el desplegable del centro
function inicializarDesplegableCentros(IDCentro){

	//solodebug console.log('inicializarDesplegableCentros IDCentro:'+IDCentro+' IDCentroDefecto:'+IDCentroDefecto);

	var IDPrimerCentro=-1, CentroExiste='N', centroSeleccionado;
	
	//	Comprobamos que el centroSeleccionado existe (no existirá si el centro del usuario no hace pedidos)
	if ((IDCentroDefecto!='')&&(IDCentro=='-1'))
	{
		IDPrimerCentro=IDCentroDefecto;
		CentroExiste='S';
		//10feb20 No preseleccionamos centro. centroSeleccionado=IDCentroDefecto;
		centroSeleccionado=-1;
	}
	else
	{
		centroSeleccionado=IDCentro;
		for(var n=0; n<arrayCentros.length; n++)
		{
			if (IDPrimerCentro==-1) IDPrimerCentro=arrayCentros[n][0];
			if (arrayCentros[n][0]==IDCentro) CentroExiste='S';
		}
		if (CentroExiste=='N') centroSeleccionado=IDPrimerCentro;
	}

	//solodebug console.log('inicializarDesplegableCentros centroSeleccionado:'+centroSeleccionado+' CentroExiste:'+CentroExiste+' IDPrimerCentro:'+IDPrimerCentro);

	document.forms['formBot'].elements['IDCENTRO'].length=0;

	for(var n=0; n<arrayCentros.length; n++){
	
		//solodebug	alert(arrayCentros[n][1]);
	
		if(arrayCentros[n][0]==centroSeleccionado){
			document.forms['formBot'].elements['IDCENTRO'].options[document.forms['formBot'].elements['IDCENTRO'].length]=new Option('['+arrayCentros[n][1]+']',arrayCentros[n][0]);
			
			document.forms['formBot'].elements['IDCENTRO'].options[document.forms['formBot'].elements['IDCENTRO'].length-1].selected=true;

			//coste de transporte
			document.forms['sumaTotal'].elements['COSTE_LOGISTICA'].value =anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(arrayCentros[n][3]),2)),2);

			inicializarDesplegableCentrosConsumo(centroSeleccionado);
		}else{
			document.forms['formBot'].elements['IDCENTRO'].options[document.forms['formBot'].elements['IDCENTRO'].length]=new Option(arrayCentros[n][1],arrayCentros[n][0]);
		}
	}

	//cambio total brasil si cambia coste de transporte
	var coste = parseFloat(desformateaDivisa(document.forms['sumaTotal'].elements['COSTE_LOGISTICA'].value));
	var total = parseFloat(desformateaDivisa(document.forms['sumaTotal'].elements['sumaTotal'].value));
	sumaBrasil = total + coste;

	//si total ya diferente de 0 escribo, si no no
	if(total != '0'){
		document.forms['sumaTotal'].elements['sumaTotalBrasil'].value = anyadirCerosDecimales(reemplazaPuntoPorComa(sumaBrasil),2);
	}
	//fin de total brasil

	//if (IDCentro==-1) mostrarDesplegableLugarDeEntrega(IDCentroDefecto, IDLugarEntrega, false);
	//else mostrarDesplegableLugarDeEntrega(centroSeleccionado, '', true);

	if (centroSeleccionado!=-1) mostrarDesplegableLugarDeEntrega(centroSeleccionado, '');
	else
		document.forms['formBot'].elements['IDLUGARENTREGA'].style.display = 'none';
}

function inicializarDesplegableCentrosConsumo(centroSeleccionado){
	document.forms['formBot'].elements['IDCENTROCONSUMO'].length=0;

	for(var n=0;n<arrayCentrosConsumo.length;n++){
		if(arrayCentrosConsumo[n][1]==centroSeleccionado){
			//if(arrayCentrosConsumo[n][4]=='S'){
			if(arrayCentrosConsumo[n][0]==IDCentroCoste){
				document.forms['formBot'].elements['IDCENTROCONSUMO'].options[document.forms['formBot'].elements['IDCENTROCONSUMO'].length]=new Option('['+arrayCentrosConsumo[n][3]+']',arrayCentrosConsumo[n][0]);	//	7mar08	ET	+' ('+arrayCentrosConsumo[n][2]
				document.forms['formBot'].elements['IDCENTROCONSUMO'].options[document.forms['formBot'].elements['IDCENTROCONSUMO'].length-1].selected=true;
			}else{
				document.forms['formBot'].elements['IDCENTROCONSUMO'].options[document.forms['formBot'].elements['IDCENTROCONSUMO'].length]=new Option(arrayCentrosConsumo[n][3],arrayCentrosConsumo[n][0]);	//	7mar08	ET	+' ('+arrayCentrosConsumo[n][2]+')'
			}
		}
	}
}

//	Oculta los desplegables de lugares de entrega, deja solo el del centro seleccionado
function mostrarDesplegableLugarDeEntrega(IDCentroActual, IDLugarEntregaActual){

	//solodebug console.log('mostrarDesplegableLugarDeEntrega IDCentroActual:'+IDCentroActual+' IDLugarEntregaActual:'+IDLugarEntregaActual);

	//no visualizo ninguno de los lugares entrega
	var formu = document.forms['formBot'];

	for(var i=0;(i<formu.length);i++){
		var k=formu.elements[i].name;
		if(k.substr(0,15)=='IDLUGARENTREGA_'){
			formu.elements[i].style.display = 'none';
		}
	}

	//enseño solo lugar entrega seleccionado
	document.forms['formBot'].elements['IDLUGARENTREGA_'+IDCentroActual].style.display = 'block';

	//selecciono lugar entrega por defecto
	//2set19 Categoría siempre "Normal" - var Categoria=document.forms['form_iddivisa'].elements['CATEGORIA'].value;
	var Categoria='N';
	var lugarSelect='';
	var ExisteIDLugarEntregaActual='N';

	for(var n=0;n<arrayLugaresEntrega.length;n++){
	
		if ((ExisteIDLugarEntregaActual=='N')&&(arrayLugaresEntrega[n][0]==IDLugarEntregaActual)) ExisteIDLugarEntregaActual='S'
		
		//	Inicializamos lugarSelect con un valor cualquiera de la lista
		if((arrayLugaresEntrega[n][1]==IDCentroActual)&&(lugarSelect=='')){
			lugarSelect = arrayLugaresEntrega[n][0];
			
			//solodebug console.log('mostrarDesplegableLugarDeEntrega IDCentroActual:'+IDCentroActual+' Incluyendo: ('+arrayLugaresEntrega[n][0]+') '+arrayLugaresEntrega[n][2]);
		}

		//si es farmacia miro decimo campo array indica "por defecto"
		if(((arrayLugaresEntrega[n][1]==IDCentroActual)&&(arrayLugaresEntrega[n][10]=='S')&&(Categoria=='F'))
		  || ((arrayLugaresEntrega[n][1]==IDCentroActual)&&(arrayLugaresEntrega[n][8]=='S')&&(Categoria=='N'))){
			document.forms['formBot'].elements['IDLUGARENTREGA_'+IDCentroActual].value=arrayLugaresEntrega[n][0];
			lugarSelect = arrayLugaresEntrega[n][0];
		}
	}//fin for


	//doy a IDLUGARENTREGA el valor seleccionado
	if ((IDLugarEntregaActual!='')&&(ExisteIDLugarEntregaActual=='S'))
		document.forms['formBot'].elements['IDLUGARENTREGA_'+IDCentroActual].value = IDLugarEntregaActual;
	else
		document.forms['formBot'].elements['IDLUGARENTREGA_'+IDCentroActual].value = lugarSelect;


	document.forms['formBot'].elements['IDLUGARENTREGA'].value = document.forms['formBot'].elements['IDLUGARENTREGA_'+IDCentroActual].value;

	ActualizarTextoLugarEntrega(lugarSelect);
	
	document.forms['formBot'].elements['IDLUGARENTREGA'].style.display = 'block';
}

function ActualizarTextoLugarEntrega(idlugarEntrega){
	var form=document.forms['formBot'];

	for(var n=0;n<arrayLugaresEntrega.length;n++){
		if(arrayLugaresEntrega[n][0]==idlugarEntrega){
			form.elements['CEN_DIRECCION'].value=arrayLugaresEntrega[n][4];
			form.elements['CEN_CPOSTAL'].value=arrayLugaresEntrega[n][5];
			form.elements['CEN_POBLACION'].value=arrayLugaresEntrega[n][6];
			form.elements['CEN_PROVINCIA'].value=arrayLugaresEntrega[n][7];
			form.elements['CEN_PEDIDOMINIMO'].value=arrayLugaresEntrega[n][9];
		}
	}
}// fin ActualizarTextoLugarEntrega


function aplicarFiltroTipoNegociacion()
{
	var	filtroTXT= jQuery('#strFiltro').val().toLowerCase();
	var	IDTipoNeg= jQuery('#IDTIPONEGOCIACION').val();
	aplicarFiltro(filtroTXT, IDTipoNeg);
}


function aplicarFiltro(filtroTxt, IDTipoNeg){
	var check;

	//solodebug	console.log('FiltroSeleccion:'+filtroTxt+' IDTipoNeg:'+IDTipoNeg);
	
	jQuery.each(arrayLineasProductos, function(key, linea){
		check = true;
		
		if (filtroTxt!='')
		{
			var arrStr	= filtroTxt.split(" ");
			for(var i=0; i<arrStr.length; i++){
				if(linea.Productos[0].stringBuscador.toLowerCase().indexOf(arrStr[i]) < 0){
					check = false;
					break;
				}
			}
			if(check)
			{
				linea.ContieneFiltroTXT = 'S';
			}
			else
			{
				linea.ContieneFiltroTXT = 'N';
			}
		}
		else
			linea.ContieneFiltroTXT = 'S';
		
		if( ((IDTipoNeg=='')||(linea.Productos[0].IDTipoNeg==IDTipoNeg)) && (!FiltroSeleccion ||linea.ContieneSeleccion == 'S') && linea.ContieneFiltroTXT == 'S'){
			linea.Mostrar = 'S';
		}else{
			linea.Mostrar = 'N';
		}
		
		//solodebug ET 26may17	console.log('FiltroSeleccion:'+FiltroSeleccion+' Sel:'+linea.ContieneSeleccion+' Producto:'+linea.Productos[0].filtroTxtBuscador.toLowerCase()+' Filt:'+linea.ContieneFiltroTXT);
		
	});

	dibujaLineasPedido();
}

var rowStart		= '<tr>';
var rowStartStyle	= '<tr style="#STYLE#">';
var rowStartClass	= '<tr class="#CLASS#">';
var rowStartClassStyle	= '<tr class="#CLASS#" style="#STYLE#">';
var rowStartID		= '<tr id="#ID#">';
var rowStartIDStyle	= '<tr id="#ID#" style="#STYLE#">';
var rowStartClassID	= '<tr class="#CLASS#" id="#ID#">';
var rowEnd		= '</tr>';

var cellHStart		= '<th>';
var cellHColStart	= '<th colspan="#COLSPAN#">';
var cellHAlignColStart	= '<th align="#ALIGN#" colspan="#COLSPAN#">';
var cellHAlignColClassStart	= '<th align="#ALIGN#" colspan="#COLSPAN#" class="#CLASS#">';	//21dic16
var cellHEnd		= '</th>';

var cellStart		= '<td>';
var cellStartAlign	= '<td align="#ALIGN#">';
var cellStartStyle	= '<td style="#STYLE#">';
var cellStartClass	= '<td class="#CLASS#">';
var cellStartClassStyle	= '<td class="#CLASS#" style="#STYLE#">';
var cellStartStyleClspn	= '<td style="#STYLE#" colspan="#COLSPAN#">';
var cellEnd		= '</td>';

var spanClassStart	= '<span class="#CLASS#">';
var spanEnd		= '</span>';

var inputHiddenName	= '<input type="hidden" name="#NAME#"/>';
var inputHiddenNameVal	= '<input type="hidden" name="#NAME#" value="#VALUE#"/>';

var anchorStyleHrefStrt	= '<a style="#STYLE#" href="#HREF#">';
var anchorEnd		= '</a>';

var macroInputText	= '<input type="text" class="#CLASS#" size="#SIZE#" align="#ALIGN#" name="#NAME#" value="#VALUE#" onFocus="#ONFOCUS#" style="#STYLE#"/>';
var macroInputText2	= '<input type="text" size="#SIZE#" name="#NAME#" class="#CLASS#" value="#VALUE#" style="#STYLE#" maxlength="#MAXLENGTH#" onBlur="#ONBLUR#" onInput="#ONINPUT#" #DISABLED#/>';
var macroInputText3	= '<input type="text" size="#SIZE#" name="#NAME#" id="#ID#" value="#VALUE#" style="#STYLE#" maxlength="#MAXLENGTH#" class="#CLASS#" onFocus="#ONFOCUS#"/>';
var macroCheckbox	= '<input type="checkbox" name="#NAME#" class="#CLASS#" value="#VALUE#" #DISABLED# #CHECKED# onClick="#ONCLICK#">';


function dibujaLineasPedido(){
	var htmlTBODY = '', thisRow = '', thisCell = '' , thisMacro = '', functionJS = '';
	var valAux, valAux2, lastGrupo = '', lastSubfamilia='', hayPrecio = 0, disabled, checked, displayTxt;
	
	//	26may17
	if (v_OcultarNoSeleccionados=='SI')
	{
		thisRow = rowStartClassStyle.replace('#CLASS#', 'subCategorias').replace('#STYLE#', displayTxt);

		thisCell = cellHColStart.replace('#COLSPAN#', '2') + '&nbsp;' + cellHEnd;
		thisRow += thisCell;
		thisCell = cellHAlignColClassStart.replace('#ALIGN#', 'left').replace('#CLASS#', 'encabezadoBloque');

		thisCell += strPlantillaGrande;

		thisCell += cellHEnd;
		thisRow += thisCell;

		htmlTBODY += thisRow;
	}
	

//	jQuery.each(arrayLineasProductos, function(key, linea){
	jQuery.each(ColumnaOrdenadaProds, function(key, value){
		(arrayLineasProductos[value].Mostrar=='S') ? displayTxt='' : displayTxt='display:none;';

		jQuery.each(arrayLineasProductos[value].Productos, function(key2, producto){
			(producto.Tarifa=='') ? hayPrecio=0 : hayPrecio=1;

			// Generamos la fila con el nombre de la subfamilia y/o grupo
			if(v_OrdenarProductos == 'NO' && (lastGrupo!=producto.Grupo || lastSubfamilia!=producto.Subfamilia)){
				thisRow = rowStartClassStyle.replace('#CLASS#', 'subCategorias').replace('#STYLE#', displayTxt);

				thisCell = cellHColStart.replace('#COLSPAN#', '2') + '&nbsp;' + cellHEnd;
				thisRow += thisCell;

				//21dic16	thisCell = cellHAlignColStart.replace('#ALIGN#', 'left');
				
				//solodebug	console.log('cellHAlignColClassStart:'+cellHAlignColClassStart);
				
				thisCell = cellHAlignColClassStart.replace('#ALIGN#', 'left').replace('#CLASS#', 'encabezadoBloque');
				if(tipoPlantilla == 'asisaBrasil'){
					thisCell = thisCell.replace('#COLSPAN#', '11');
				}else if(tipoPlantilla == 'viamedNuevo'){
					thisCell = thisCell.replace('#COLSPAN#', '11');
				}else if(tipoPlantilla == 'nuevoModeloViejoPedido'){
					thisCell = thisCell.replace('#COLSPAN#', '12');
				}else if(tipoPlantilla == 'nuevoModeloNuevoPedido'){
					thisCell = thisCell.replace('#COLSPAN#', '10');
				}

				//solodebug	console.log('thisCell:'+thisCell);

				/*	21dic16
				thisCell += '<strong>' + spanClassStart.replace('#CLASS#', 'subfamilia');
				if(usarGrupo=='S' && producto.Grupo!=''){
					thisCell += producto.Subfamilia + '&nbsp;>&nbsp;' + producto.Grupo;
				}else if(usarGrupo=='N' && producto.Subfamilia!=''){
					thisCell += producto.Subfamilia;
				}else{	// Caso VIAMED5 => enseï¿½o "sin grupo""
					if(usarGrupo=='S'){
						thisCell += str_SinGrupo;
					}else{
						thisCell += str_SinSubfamilia;
					}
				}
				thisCell += spanEnd + '</strong>';*/
				if(usarGrupo=='S' && producto.Grupo!=''){
					thisCell += producto.Subfamilia + '&nbsp;>&nbsp;' + producto.Grupo;
				}else if(usarGrupo=='N' && producto.Subfamilia!=''){
					thisCell += producto.Subfamilia;
				}else{	// Caso VIAMED5 => enseï¿½o "sin grupo""
					if(usarGrupo=='S'){
						thisCell += str_SinGrupo;
					}else{
						thisCell += str_SinSubfamilia;
					}
				}


				thisCell += cellHEnd;

				thisRow += thisCell;

				thisRow += rowEnd;
				htmlTBODY += thisRow;
			}
			// FIN fila nombre subfamilia y/o grupo

			// INICIO fila con info producto
			thisRow = rowStartIDStyle.replace('#ID#', 'posArr_' + key).replace('#STYLE#', displayTxt);

			// Ref.MVM si no es farmacia o Ref.Prove si es farmacia
			thisCell = cellStartAlign.replace('#ALIGN#', 'left');
			thisCell += spanClassStart.replace('#CLASS#', 'font11') + '&nbsp;';
			
			
			//solodebug	console.log("RefPrivada:"+ producto.RefPrivada+ "RefCliente:"+producto.RefCliente);
			
			if(producto.RefCliente!=''){
				thisCell += '<span class="toHighlight">' + producto.RefCliente + '</span>';
			}else{
				thisCell += '<span class="toHighlight">' + producto.RefPrivada + '</span>';
			}

			thisCell += spanEnd;
			thisCell += cellEnd;

			thisRow += thisCell;

                        //imagen
			thisCell = cellStart;
            if (producto.Image != '')
			{
                thisCell += '<img src="http://www.newco.dev.br/images/fotoListadoPeq.gif" id="'+producto.IDImage+'" onmouseover="verFoto(\''+producto.IDImage+'\');" onmouseout="verFoto(\''+producto.IDImage+'\');" /> ';
                thisCell += '<div id="verFotoPro_'+producto.IDImage+'" clas="divFotoProBusca" style="display:none;" ><img src="http://www.newco.dev.br/Fotos/'+producto.Image+'" /> ';
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// Nombre producto (con link)
			thisCell = cellStartStyle.replace('#STYLE#', 'padding-left:5px;text-align:left;');
			if(producto.TipoSinStock){
				thisCell += spanClassStart.replace('#CLASS#', 'rojo') + '<b>[*]</b>' + spanEnd + '&nbsp;';
			} 
			else if(producto.Regulado=='S'){
				thisCell += spanClassStart.replace('#CLASS#', 'amarillo') + '<b>[REG]</b>' + spanEnd + '&nbsp;';
			}
			else if(producto.Pack=='S'){
				thisCell += spanClassStart.replace('#CLASS#', 'amarillo') + '<b>[PACK]</b>' + spanEnd + '&nbsp;';
			}
			
			
            //si usuario minimalista, comeprovee veo ficha producto reducida
            if (minimalista == 'S'){
                thisCell += anchorStyleHrefStrt.replace('#STYLE#', 'text-decoration:none;').replace('#HREF#', 'javascript:verDetalleProducto(' + producto.IDProducto + ');');
            }
            else{
                thisCell += anchorStyleHrefStrt.replace('#STYLE#', 'text-decoration:none;').replace('#HREF#', 'javascript:MostrarPagPersonalizada(\'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=' + producto.IDProducto + '\',\'producto\',100,80,0,0);');

            }
			
			thisCell += spanClassStart.replace('#CLASS#', 'strongAzul');
			if(producto.NombrePrivado!=''){
				thisCell += '<span class="toHighlight">' + producto.NombrePrivado + '</span>';
			}else{
				thisCell += '<span class="toHighlight">' + producto.Nombre + '</span>';
			}
			thisCell += spanEnd;
			thisCell += anchorEnd;
			thisCell += cellEnd;

			thisRow += thisCell;

			// Si es farmacia no veo Ref.prov
			if (ocultarRefProveedor=='N')
			{
				if(tipoPlantilla == 'viamedNuevo')
				{

					thisCell = cellStartClass.replace('#CLASS#', 'center');
					if(producto.Categoria=='F' && usarRefProveedor=='N'){
						thisCell += '<span class="toHighlight">' + producto.Referencia + '</span>';
					}else if(producto.Categoria=='N'){
						thisCell += '<span class="toHighlight">' + producto.Referencia + '</span>';
					}
					thisCell += cellEnd;
				}
				else
				{

                            		thisCell = cellStartClass.replace('#CLASS#', 'center');
					if(producto.Categoria=='N'){
						thisCell += '<span class="toHighlight">' + producto.Referencia + '</span>';
					}
					thisCell += cellEnd;
				}
				thisRow += thisCell;
			}

			// Marca
			thisCell = cellStartClassStyle.replace('#CLASS#', 'center').replace('#STYLE#', 'font-size:11px;');
			if(tipoPlantilla == 'asisaBrasil'){
				thisCell += '<span class="toHighlight">' + producto.Marca + '</span>';
			}else{
				if(sinMarca=='S'){
					thisCell += '&nbsp;';
				}else{
					thisCell += '<span class="toHighlight">' + producto.Marca + '</span>';
				}
			}
			thisCell += cellEnd;
			thisRow += thisCell;

			// UdBasica
			thisCell = cellStartClass.replace('#CLASS#', 'center');
			thisCell += producto.UdBasica + '&nbsp;';
			thisCell += cellEnd;

			thisRow += thisCell;

			if(tipoPlantilla == 'asisaBrasil' || tipoPlantilla == 'nuevoModeloViejoPedido'){
				// Precio Prov (sIVA)
				valAux	= desformateaDivisa(producto.Tarifa_SinFormat);
				/*
				if(valAux <= 10)
					valAux2	= anyadirCerosDecimales(FormateaNumeroNacho(reemplazaPuntoPorComa(Round(valAux,4))),4);
				else
					valAux2	= anyadirCerosDecimales(FormateaNumeroNacho(reemplazaPuntoPorComa(Round(valAux,2))),2);
				*/
				valAux2	= anyadirCerosDecimales(FormateaNumeroNacho(reemplazaPuntoPorComa(Round(valAux,decimalesPrecio))),decimalesPrecio);

				thisCell = cellStartClass.replace('#CLASS#', 'center');
				thisMacro = macroInputText.replace('#CLASS#', 'noinput medio');
				thisMacro = thisMacro.replace('#SIZE#', '7');
				thisMacro = thisMacro.replace('#ALIGN#', 'right');
				thisMacro = thisMacro.replace('#NAME#', 'PRECIOUNITARIO_' + key);
				thisMacro = thisMacro.replace('#VALUE#', valAux2);					//	ET 3nov17 , 22ago18 volvemos a quitar divisa + sufDivisa
				thisMacro = thisMacro.replace('#ONFOCUS#', 'this.blur()');
				thisMacro = thisMacro.replace('#STYLE#', 'text-align:right;');
				thisCell += thisMacro;

				thisCell += cellEnd;

				thisRow += thisCell;
                        }

			if(tipoPlantilla == 'viamedNuevo' || tipoPlantilla == 'nuevoModeloViejoPedido'){
				// Precio Prov + IVA
				valAux	= desformateaDivisa(producto.Tarifa_SinFormat) + desformateaDivisa(producto.ImporteIVA_SinFormat);
				/*
				if(valAux <= 10)
					valAux2	= anyadirCerosDecimales(FormateaNumeroNacho(reemplazaPuntoPorComa(Round(valAux,4))),4);
				else
					valAux2	= anyadirCerosDecimales(FormateaNumeroNacho(reemplazaPuntoPorComa(Round(valAux,2))),2);
				*/
				valAux2	= anyadirCerosDecimales(FormateaNumeroNacho(reemplazaPuntoPorComa(Round(valAux,decimalesPrecio))),decimalesPrecio);

				thisCell = cellStartClass.replace('#CLASS#', 'center');
				thisMacro = macroInputText.replace('#CLASS#', 'noinput medio');
				thisMacro = thisMacro.replace('#SIZE#', '7');
				thisMacro = thisMacro.replace('#ALIGN#', 'right');
				thisMacro = thisMacro.replace('#NAME#', 'PRECIOUNITARIOCONIVA_' + key);
				thisMacro = thisMacro.replace('#VALUE#', valAux2);				//	ET 3nov17 , 22ago18 volvemos a quitar divisa + sufDivisa
				thisMacro = thisMacro.replace('#ONFOCUS#', 'this.blur()');
				thisMacro = thisMacro.replace('#STYLE#', 'text-align:right;');
				thisCell += thisMacro;
				thisCell += cellEnd;

				thisRow += thisCell;
			}else if(tipoPlantilla == 'nuevoModeloNuevoPedido'){
				// Precio Prov + IVA + comision MVM
				valAux	= desformateaDivisa(producto.Tarifa_SinFormat) + desformateaDivisa(producto.ImporteIVA_SinFormat) + desformateaDivisa(producto.ComisionMVM_SinFormat);
				/*
				if(valAux <= 10)
					valAux2	= anyadirCerosDecimales(FormateaNumeroNacho(reemplazaPuntoPorComa(Round(valAux,4))),4);
				else
					valAux2	= anyadirCerosDecimales(FormateaNumeroNacho(reemplazaPuntoPorComa(Round(valAux,2))),2);
				*/
				valAux2	= anyadirCerosDecimales(FormateaNumeroNacho(reemplazaPuntoPorComa(Round(valAux,decimalesPrecio))),decimalesPrecio);

				thisCell = cellStartClass.replace('#CLASS#', 'center');
				thisMacro = macroInputText.replace('#CLASS#', 'noinput medio');
				thisMacro = thisMacro.replace('#SIZE#', '7');
				thisMacro = thisMacro.replace('#ALIGN#', 'right');
				thisMacro = thisMacro.replace('#NAME#', 'PRECIOUNITARIOCONIVA_' + key);
				thisMacro = thisMacro.replace('#VALUE#', valAux2);				//	ET 3nov17 , 22ago18 volvemos a quitar divisa + sufDivisa
				thisMacro = thisMacro.replace('#ONFOCUS#', 'this.blur()');
				thisMacro = thisMacro.replace('#STYLE#', 'text-align:right;');
				thisCell += thisMacro;
				thisCell += cellEnd;

				thisRow += thisCell;
			}

			// Flechas que indican si el precio ha bajado o subido
			if(tipoPlantilla == 'viamedNuevo' || tipoPlantilla == 'nuevoModeloViejoPedido' || tipoPlantilla == 'nuevoModeloNuevoPedido'){
				thisCell = cellStart;
				if(ocultarPrecioReferencia=='N'){
					if(producto.VariacionPrecio == 'Caro'){
						thisCell += '<img src="http://www.newco.dev.br/images/order_a_rojo.gif"/>';
					}else if(producto.VariacionPrecio == 'Barato'){
						thisCell += '<img src="http://www.newco.dev.br/images/order_d_verde.gif"/>';
					}
				}else if(ocultarPrecioReferencia=='S'){
					if(producto.VariacionPrecioFinal == 'Caro'){
						thisCell += '<img src="http://www.newco.dev.br/images/order_a_rojo.gif"/>';
					}else if(producto.VariacionPrecioFinal == 'Barato'){
						thisCell += '<img src="http://www.newco.dev.br/images/order_d_verde.gif"/>';
					}
				}
				thisCell += cellEnd;

				thisRow += thisCell;
			}

			// Cantidad
			thisCell = cellStartClass.replace('#CLASS#', 'center peq');
			thisMacro = macroInputText2.replace('#SIZE#', '4');
			thisMacro = thisMacro.replace('#NAME#', 'NuevaCantidad_' + key);
			thisMacro = thisMacro.replace('#CLASS#', 'cantidad peq');
			thisMacro = thisMacro.replace('#VALUE#', producto.Cantidad_SinFormato);
			thisMacro = thisMacro.replace('#STYLE#', 'text-align:right;');
			thisMacro = thisMacro.replace('#MAXLENGTH#', '7');								//	Aumentamos tamaño a 7 digitos, solicitado por Imbanaco
//			functionJS= 'if(UnidadesALotes(this.value, producto.UdsXLote_SinFormato, this, document.forms[\'form_' + key + '\'])) Cantidad2Importe(document.forms[\'form_' + key + '\'], producto.PLL_ID, accion, hayPrecio); else realizarCalculosPorDefinir(document.forms[\'form_' + key + '\'], producto.PLL_ID, accion, hayPrecio);';
//			functionJS= 'if(UnidadesALotes(this)) Cantidad2Importe(document.forms[\'form_' + key + '\'], producto.PLL_ID, accion, ' + hayPrecio + '); else realizarCalculosPorDefinir(document.forms[\'form_' + key + '\'], producto.PLL_ID, accion, ' + hayPrecio + ');';
//			functionJS= 'if(UnidadesALotes(this)) Cantidad2Importe(' + key + ', ' + hayPrecio + '); else realizarCalculosPorDefinir(document.forms[\'form_' + key + '\'], producto.PLL_ID, ' + hayPrecio + ');';
//			functionJS= 'if(UnidadesALotes(this)) Cantidad2Importe(' + key + ', ' + hayPrecio + ');';
			functionJS= 'javascript:UnidadesALotes(this);';
			thisMacro = thisMacro.replace('#ONBLUR#', functionJS);
			functionJS= 'javascript:Seleccionar(this);';
			thisMacro = thisMacro.replace('#ONINPUT#', functionJS);

			//	27oct20 Deshabilitamos este campo en caso de "sin stock"
			disabled='';
			//solodebug
			if (producto.TipoSinStock!='' && producto.TextSinStock)
				 console.log(producto.Nombre+'. TipoSinStock:'+producto.TipoSinStock+' TextSinStock:'+producto.TextSinStock+' indexOf:'+producto.TextSinStock.indexOf('NO SOLICITAR'));
			if(producto.Tarifa=='' || (producto.TipoSinStock!='' && ((producto.TipoSinStock=='D') || (producto.TextSinStock && producto.TextSinStock.indexOf('NO SOLICITAR')>=0)))){
				disabled='disabled="disabled"';
			}
			thisMacro = thisMacro.replace('#DISABLED#', disabled);


			thisCell += thisMacro;
			thisCell += cellEnd;

			thisRow += thisCell;

			// Lote
			thisCell = cellStartClass.replace('#CLASS#', 'textRight');
			thisCell += '&nbsp;&nbsp;' + producto.UdsXLote;
			thisCell += cellEnd;

			thisRow += thisCell;

			if(tipoPlantilla == 'asisaBrasil'){
				// Si es Brasil no enseï¿½o iva
				thisCell = cellStartClass;
				if(IDPais=='55'){
					thisCell = thisCell.replace('#CLASS#', 'uno');
					thisCell += '&nbsp;';
				}else{
					thisCell = thisCell.replace('#CLASS#', 'textRight');
					thisCell += '&nbsp;' + producto.TipoIVA;
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Importe total
				thisCell = cellStartClass.replace('#CLASS#', 'textRight');
				if(hayPrecio==0){
					thisCell += str_PedirOferta;
				}else{
					// Importe total sIVA -- precio prov * cantidad
					valAux	= desformateaDivisa(producto.Tarifa_SinFormat) * desformateaDivisa(producto.Cantidad_SinFormato);
					valAux2	= anyadirCerosDecimales(FormateaNumeroNacho(reemplazaPuntoPorComa(Round(valAux,decimalesTotal))),decimalesTotal);

					thisMacro = macroInputText3.replace('#SIZE#', '8');
					thisMacro = thisMacro.replace('#NAME#', 'NuevoImporte_' + key);
					thisMacro = thisMacro.replace('#ID#', 'NuevoImporte_' + key);
					thisMacro = thisMacro.replace('#VALUE#', valAux2);						//	ET 3nov17 , 22ago18 volvemos a quitar divisa + sufDivisa
					thisMacro = thisMacro.replace('#STYLE#', 'text-align:right;');
					thisMacro = thisMacro.replace('#MAXLENGTH#', '10');
					thisMacro = thisMacro.replace('#CLASS#', 'noinput medio');
					thisMacro = thisMacro.replace('#ONFOCUS#', 'this.blur();');
					thisCell += thisMacro;
				}
				thisCell += cellEnd;
				thisRow += thisCell;
			}else if(tipoPlantilla == 'viamedNuevo'){
				thisCell = cellStart + '&nbsp;' + cellEnd;
				thisRow += thisCell;

				// Importe total cIVA -- (precio prov + IVA) * cantidad
				valAux	= (desformateaDivisa(producto.Tarifa_SinFormat) + desformateaDivisa(producto.ImporteIVA_SinFormat)) * desformateaDivisa(producto.Cantidad_SinFormato);
				valAux2	= anyadirCerosDecimales(FormateaNumeroNacho(reemplazaPuntoPorComa(Round(valAux,decimalesTotal))),decimalesTotal);

				thisCell = cellStartClass.replace('#CLASS#', 'textRight');
				thisMacro = macroInputText3.replace('#SIZE#', '8');
				thisMacro = thisMacro.replace('#NAME#', 'NuevoImporteConIVA_' + key);
				thisMacro = thisMacro.replace('#ID#', 'NuevoImporteConIVA_' + key);
				thisMacro = thisMacro.replace('#VALUE#', valAux2);							//	ET 3nov17 , 22ago18 volvemos a quitar divisa + sufDivisa
				thisMacro = thisMacro.replace('#STYLE#', 'text-align:right;');
				thisMacro = thisMacro.replace('#MAXLENGTH#', '10');
				thisMacro = thisMacro.replace('#CLASS#', 'noinput medio');
				thisMacro = thisMacro.replace('#ONFOCUS#', 'this.blur();');
				thisCell += thisMacro;
				thisRow += thisCell;
			}else if(tipoPlantilla == 'nuevoModeloViejoPedido'){
				// Importe total sIVA -- precio prov * cantidad
				valAux	= desformateaDivisa(producto.Tarifa_SinFormat) * desformateaDivisa(producto.Cantidad_SinFormato);
				valAux2	= anyadirCerosDecimales(FormateaNumeroNacho(reemplazaPuntoPorComa(Round(valAux,decimalesTotal))),decimalesTotal);

				thisCell = cellStartClass.replace('#CLASS#', 'textRight');
				thisMacro = macroInputText3.replace('#SIZE#', '8');
				thisMacro = thisMacro.replace('#NAME#', 'NuevoImporte_' + key);
				thisMacro = thisMacro.replace('#ID#', 'NuevoImporte_' + key);
				thisMacro = thisMacro.replace('#VALUE#', valAux2);							//	ET 3nov17 , 22ago18 volvemos a quitar divisa + sufDivisa
				thisMacro = thisMacro.replace('#STYLE#', 'text-align:right;');
				thisMacro = thisMacro.replace('#MAXLENGTH#', '10');
				thisMacro = thisMacro.replace('#CLASS#', 'noinput medio');
				thisMacro = thisMacro.replace('#ONFOCUS#', 'this.blur();');
				thisCell += thisMacro;
				thisRow += thisCell;

				// Importe total cIVA -- (precio prov + IVA) * cantidad
				valAux	= (desformateaDivisa(producto.Tarifa_SinFormat) + desformateaDivisa(producto.ImporteIVA_SinFormat)) * desformateaDivisa(producto.Cantidad_SinFormato);
				valAux2	= anyadirCerosDecimales(FormateaNumeroNacho(reemplazaPuntoPorComa(Round(valAux,decimalesTotal))),decimalesTotal);

				thisCell = cellStartClass.replace('#CLASS#', 'textRight');
				thisMacro = macroInputText3.replace('#SIZE#', '8');
				thisMacro = thisMacro.replace('#NAME#', 'NuevoImporteConIVA_' + key);
				thisMacro = thisMacro.replace('#ID#', 'NuevoImporteConIVA_' + key);
				thisMacro = thisMacro.replace('#VALUE#', valAux2);							//	ET 3nov17 , 22ago18 volvemos a quitar divisa + sufDivisa
				thisMacro = thisMacro.replace('#STYLE#', 'text-align:right;');
				thisMacro = thisMacro.replace('#MAXLENGTH#', '10');
				thisMacro = thisMacro.replace('#CLASS#', 'noinput medio');
				thisMacro = thisMacro.replace('#ONFOCUS#', 'this.blur();');
				thisCell += thisMacro;
				thisRow += thisCell;
			}else if(tipoPlantilla == 'nuevoModeloNuevoPedido'){
				// Importe total cIVA y comision -- (Precio Prov + IVA + comision MVM) * cantidad
				valAux	= (desformateaDivisa(producto.Tarifa_SinFormat) + desformateaDivisa(producto.ImporteIVA_SinFormat) + desformateaDivisa(producto.ComisionMVM_SinFormat)) * desformateaDivisa(producto.Cantidad_SinFormato);
				valAux2	= anyadirCerosDecimales(FormateaNumeroNacho(reemplazaPuntoPorComa(Round(valAux,decimalesTotal))),decimalesTotal);

				thisCell = cellStartClass.replace('#CLASS#', 'textRight');
				thisMacro = macroInputText3.replace('#SIZE#', '8');
				thisMacro = thisMacro.replace('#NAME#', 'NuevoImporte_' + key);
				thisMacro = thisMacro.replace('#ID#', 'NuevoImporte_' + key);
				thisMacro = thisMacro.replace('#VALUE#', valAux2);							//	ET 3nov17 , 22ago18 volvemos a quitar divisa + sufDivisa
				thisMacro = thisMacro.replace('#STYLE#', 'text-align:right;');
				thisMacro = thisMacro.replace('#MAXLENGTH#', '10');
				thisMacro = thisMacro.replace('#CLASS#', 'noinput medio');
				thisMacro = thisMacro.replace('#ONFOCUS#', 'this.blur();');
				thisCell += thisMacro;
				thisRow += thisCell;
			}

			// Checkbox seleccion
			thisCell = cellStartClass.replace('#CLASS#', 'center');
			thisMacro = macroCheckbox.replace('#NAME#', 'SELECCION_' + key);
			thisMacro = thisMacro.replace('#CLASS#', 'SELECCION peq');
			thisMacro = thisMacro.replace('#VALUE#', key);
			disabled='';
			
			//solodebug
			if (producto.TipoSinStock!='' && producto.TextSinStock)
			 console.log(producto.Nombre+'. TipoSinStock:'+producto.TipoSinStock+' TextSinStock:'+producto.TextSinStock+' indexOf:'+producto.TextSinStock.indexOf('NO SOLICITAR'));
			
			
			if(producto.Tarifa=='' || (producto.TipoSinStock!='' && ((producto.TipoSinStock=='D') || (producto.TextSinStock && producto.TextSinStock.indexOf('NO SOLICITAR')>=0)))){
				disabled='disabled="disabled"';
			}
			thisMacro = thisMacro.replace('#DISABLED#', disabled);
			checked='';
			if(producto.Seleccionado=='S'){
				checked='checked="checked"';
			}
			thisMacro = thisMacro.replace('#CHECKED#', checked);
			thisMacro = thisMacro.replace('#ONCLICK#', 'clickCheckbox(this);');
			thisCell += thisMacro;
			thisCell += cellEnd;

			thisRow += thisCell;

			thisRow += rowEnd;
			htmlTBODY += thisRow;
			// FIN fila con info producto

			// INICIO Fila Sin Stock
			if(producto.TipoSinStock){
				thisRow = rowStartStyle.replace('#STYLE#', displayTxt);

				thisCell = cellStart + '&nbsp;' + cellEnd;
				thisRow += thisCell;

				thisCell = cellStartStyleClspn.replace('#STYLE#', 'background:#FFFF99;').replace('#COLSPAN#', '13');
				thisCell += '&nbsp;' + spanClassStart.replace('#CLASS#', 'rojo') + '<b>[*]</b>' + spanEnd;
				thisCell += '&nbsp;' + producto.TextSinStock;
				thisCell += '&nbsp;' + str_Alternativa;
				thisCell += '&nbsp;' + str_Ref + '.&nbsp;' + producto.RefAlternativa;
				thisCell += '&nbsp;' + str_Prod + '.&nbsp;' + producto.DescAlternativa;
				thisCell += cellEnd;
				thisRow += thisCell;

				thisRow += rowEnd;
				htmlTBODY += thisRow;
                        }
			// FIN Fila Sin Stock

			if(arrayLineasProductos[value].Mostrar=='S'){
				lastGrupo	= producto.Grupo;
				lastSubfamilia	= producto.Subfamilia;
			}
		});
	});


	//solodebug console.log('htmlTBODY:'+htmlTBODY);


	//21dic16jQuery('table.encuesta tbody').empty().append(htmlTBODY);
	jQuery('#lineas tbody').empty().append(htmlTBODY);

	if(filtroTXT != ''){
		highlightString();
	}
}


function validarCantidades(){
	var uds, udsXLote, lotes, nuevasUds;

	// Nos recorremos el array de productos para la validacion
	//jQuery.each(arrayLineasProductos, function(key, linea){
	jQuery.each(ColumnaOrdenadaProds, function(key, value){
		uds		= parseInt(arrayLineasProductos[value].Productos[0].Cantidad_SinFormato);
		udsXLote	= parseInt(arrayLineasProductos[value].Productos[0].UdsXLote_SinFormato);

		if(uds%udsXLote == 0){
			lotes		= uds/udsXLote;
			nuevasUds	= udsXLote*lotes;

			// Editamos el valor del input text para la cantidad correspondiente
			jQuery("input.cantidad[name='NuevaCantidad_" + key + "']").val(nuevasUds);
		}else{
			lotes		= (Math.abs(uds)-(Math.abs(uds)%udsXLote))/udsXLote+1;
			nuevasUds	= udsXLote*lotes;

			// Editamos el valor del input text para la cantidad correspondiente
			jQuery("input.cantidad[name='NuevaCantidad_" + key + "']").val(nuevasUds);
			jQuery("input.cantidad[name='NuevaCantidad_" + key + "']").focus();
			jQuery("input.cantidad[name='NuevaCantidad_" + key + "']").blur();	// Esto se hace para lanzar la funcion Cantidad2Importe()
		}

		// Editamos el valor de la cantidad en el objeto
		arrayLineasProductos[value].Productos[0].Cantidad_SinFormato	= nuevasUds;
		arrayLineasProductos[value].Productos[0].Cantidad		= nuevasUds;
	});
}

function UnidadesALotes(obj){
	var uds		= parseInt(obj.value);
	var posArr	= obj.name.substr(14, obj.name.length);
//	var udsXLote	= parseInt(arrayLineasProductos[posArr].Productos[0].UdsXLote_SinFormato);
	var udsXLote	= parseInt(arrayLineasProductos[ColumnaOrdenadaProds[posArr]].Productos[0].UdsXLote_SinFormato);
//	var tarifa	= desformateaDivisa(arrayLineasProductos[posArr].Productos[0].Tarifa_SinFormat);
	var tarifa	= desformateaDivisa(arrayLineasProductos[ColumnaOrdenadaProds[posArr]].Productos[0].Tarifa_SinFormat);
	var nuevasUds, hayPrecio=1, lotes;

	if(tarifa=="")	hayPrecio=0;

	if(isNaN(uds) || uds==""){
		//2set19	alert(document.forms['form_iddivisa'].elements['CANTIDAD_INCORRECTA'].value);
		alert(strCantidadIncorrecta);
		uds=1;
		obj.value=1;
	}else{
		if(!esEnteroConSigno(obj.value)){
			//2set19	alert(document.forms['form_iddivisa'].elements['CANTIDAD_INCORRECTA'].value);
			alert(strCantidadIncorrecta);
			uds=1;
			obj.value=1;
		}
	}

	if(uds%udsXLote==0){
		lotes=uds/udsXLote;
		nuevasUds=udsXLote*lotes;
		// Editamos el valor del input text para la cantidad correspondiente
		jQuery("input.cantidad[name='NuevaCantidad_" + posArr + "']").val(nuevasUds);

		// Editamos el valor de la cantidad en el objeto
		//arrayLineasProductos[posArr].Productos[0].Cantidad_SinFormato	= nuevasUds;
		arrayLineasProductos[ColumnaOrdenadaProds[posArr]].Productos[0].Cantidad_SinFormato	= nuevasUds;
		//arrayLineasProductos[posArr].Productos[0].Cantidad		= nuevasUds;
		arrayLineasProductos[ColumnaOrdenadaProds[posArr]].Productos[0].Cantidad		= nuevasUds;
	}else{
		lotes=(Math.abs(uds)-(Math.abs(uds)%udsXLote))/udsXLote+1;
		//2set19	alert(uds+ document.forms['form_iddivisa'].elements['REDONDEO_UNIDADES'].value +'\n'+ document.forms['form_iddivisa'].elements['REDONDEO_UNIDADES_2'].value +Math.abs(lotes)+ document.forms['form_iddivisa'].elements['CAJAS'].value + '. ('+Math.abs(udsXLote*lotes)+ document.forms['form_iddivisa'].elements['UNIDADES'].value + ')');
		alert(uds+ strRedondeoUnidades +'\n'+ strRedondeoUnidades2 +Math.abs(lotes)+ strCajas + '. ('+Math.abs(udsXLote*lotes)+ strUnidades + ')');

		nuevasUds=udsXLote*lotes;
		if(uds>0){
			// Editamos el valor del input text para la cantidad correspondiente
			jQuery("input.cantidad[name='NuevaCantidad_" + posArr + "']").val(nuevasUds);

			// Editamos el valor de la cantidad en el objeto
			//arrayLineasProductos[posArr].Productos[0].Cantidad_SinFormato	= nuevasUds;
			arrayLineasProductos[ColumnaOrdenadaProds[posArr]].Productos[0].Cantidad_SinFormato	= nuevasUds;
			//arrayLineasProductos[posArr].Productos[0].Cantidad		= nuevasUds;
			arrayLineasProductos[ColumnaOrdenadaProds[posArr]].Productos[0].Cantidad		= nuevasUds;
		}else{
			// Editamos el valor del input text para la cantidad correspondiente
			jQuery("input.cantidad[name='NuevaCantidad_" + posArr + "']").val(-nuevasUds);

			// Editamos el valor de la cantidad en el objeto
			//arrayLineasProductos[posArr].Productos[0].Cantidad_SinFormato	= -nuevasUds;
			arrayLineasProductos[ColumnaOrdenadaProds[posArr]].Productos[0].Cantidad_SinFormato	= -nuevasUds;
			//arrayLineasProductos[posArr].Productos[0].Cantidad		= -nuevasUds;
			arrayLineasProductos[ColumnaOrdenadaProds[posArr]].Productos[0].Cantidad		= -nuevasUds;
		}
	}

	// Una vez tenemos la cantidad validada y correctamente informada => calculamos el nuevo total para el pedido de este producto
	Cantidad2Importe(posArr, hayPrecio);
}


//	26may17 Al cambiar la cantidad, de paso seleccionamos la línea
function Seleccionar(obj){
	var posArr	= obj.name.substr(14, obj.name.length);
	
	if (!jQuery("input.SELECCION[name='SELECCION_" + posArr + "']").attr('checked'))
	{
		jQuery("input.SELECCION[name='SELECCION_" + posArr + "']").attr('checked', true);
		arrayLineasProductos[ColumnaOrdenadaProds[posArr]].Productos[0].Seleccionado = 'S';
	}
}


//
// Recalculo el importe cuando cambia la cantidad
//
function Cantidad2Importe(posArr, hayPrecio){
	if(hayPrecio){
		if(esEnteroConSigno(desformateaDivisa(arrayLineasProductos[ColumnaOrdenadaProds[posArr]].Productos[0].Cantidad_SinFormato))){
			var cant	= desformateaDivisa(arrayLineasProductos[ColumnaOrdenadaProds[posArr]].Productos[0].Cantidad_SinFormato);
			var precioBase	= desformateaDivisa(arrayLineasProductos[ColumnaOrdenadaProds[posArr]].Productos[0].Tarifa_SinFormat);
			var importeIVA	= desformateaDivisa(arrayLineasProductos[ColumnaOrdenadaProds[posArr]].Productos[0].ImporteIVA_SinFormat);
			var comisionMVM	= desformateaDivisa(arrayLineasProductos[ColumnaOrdenadaProds[posArr]].Productos[0].ComisionMVM_SinFormat);
			var importe='', importe2='', total, totalFormat;

			// Segun el modelo de negocio calculamos el importe base
			if(tipoPlantilla == 'asisaBrasil'){
				importe		= precioBase;
			}else if(tipoPlantilla == 'viamedNuevo'){
				importe2	= precioBase + importeIVA;
			}else if(tipoPlantilla == 'nuevoModeloViejoPedido'){
				importe		= precioBase;
				importe2	= precioBase + importeIVA;
			}else if(tipoPlantilla == 'nuevoModeloNuevoPedido'){
				importe	= precioBase + importeIVA + comisionMVM;
			}

			// Editamos el valor del input text para el importe correspondiente
			if(importe!=''){
				total		= parseFloat(cant)*parseFloat(importe);
				totalFormat	= anyadirCerosDecimales(FormateaNumeroNacho(reemplazaPuntoPorComa(Round(total,2))),2);
				if(jQuery("input[name='NuevoImporte_" + posArr + "']").length)
					jQuery("input[name='NuevoImporte_" + posArr + "']").val(totalFormat);
			}

			if(importe2!=''){
				total		= parseFloat(cant)*parseFloat(importe2);
				totalFormat	= anyadirCerosDecimales(FormateaNumeroNacho(reemplazaPuntoPorComa(Round(total,2))),2);

				if(jQuery("input[name='NuevoImporteConIVA_" + posArr + "']").length)
					jQuery("input[name='NuevoImporteConIVA_" + posArr + "']").val(totalFormat);
			}

			if(arrayLineasProductos[ColumnaOrdenadaProds[posArr]].Productos[0].Seleccionado == 'S'){
				sumar_pedidoDirecto();
			}
		}
	}
}

//Para la inicializacion
//Suma el importe de todas las lineas.
function sumar_pedidoDirecto(){
	var porDefinir=0;
	var suma=0;
	var sumaBrasil = 0;

	var cant, precioBase, precio, importeIVA, comisionMVM, importe, precioSeleccionado, costeTransporte;

	//jQuery.each(arrayLineasProductos, function(key, linea){
	jQuery.each(ColumnaOrdenadaProds, function(key, value){
		if(jQuery("#NuevoImporte_" + key).length < 0){
			if(arrayLineasProductos[value].Productos[0].Seleccionado == 'S'){
				arrayLineasProductos[value].Productos[0].Seleccionado = 'N';
				jQuery("input.SELECCION[name='SELECCION_" + key + "']").attr('checked', false);
			}
		}else{
			if(jQuery("#NuevoImporte_" + key).val() == 'Sol.Muestra' || jQuery("#NuevoImporte_" + key).val() == 'Sol.Amostra'){
				if(!porDefinir)
					porDefinir=1;
			}else{
				if(arrayLineasProductos[value].Productos[0].Seleccionado == 'S'){
					//21may15	Recuperamos los datos de precios y cantidades relativos al producto
					cant		= desformateaDivisa(arrayLineasProductos[value].Productos[0].Cantidad_SinFormato);
					precioBase	= desformateaDivisa(arrayLineasProductos[value].Productos[0].Tarifa_SinFormat);
					importeIVA	= desformateaDivisa(arrayLineasProductos[value].Productos[0].ImporteIVA_SinFormat);
					comisionMVM	= desformateaDivisa(arrayLineasProductos[value].Productos[0].ComisionMVM_SinFormat);

					if(tipoPlantilla == 'asisaBrasil'){
						importe	= precioBase;					//21may15
					}else if(tipoPlantilla == 'viamedNuevo'){
						importe	= precioBase + importeIVA;			//21may15
					}else if(tipoPlantilla == 'nuevoModeloViejoPedido'){
						importe	= precioBase;					//21may15
					}else if(tipoPlantilla == 'nuevoModeloNuevoPedido'){
						importe	= precioBase + importeIVA + comisionMVM;	//21may15
					}
					precioSeleccionado = parseFloat(cant)*parseFloat(importe);

					suma		= suma + precioSeleccionado;
				}
			}
		}
	});

	costeTransporte = parseFloat(desformateaDivisa(document.forms['sumaTotal'].elements['COSTE_LOGISTICA'].value));
	sumaBrasil	= suma + costeTransporte;

	if(!porDefinir){
		document.forms['formBot'].elements['sumanumerica'].value=suma;		//	24mar10	ET	Guardamos el numero en el formato numerico original
		document.forms['formBot'].elements['sum'].value=anyadirCerosDecimales(formateaDivisa(Round(suma,2)),2);
		document.forms['sumaTotal'].elements['sumaTotal'].value=preDivisa + anyadirCerosDecimales(document.forms['formBot'].elements['sum'].value,2) + sufDivisa;
		//suma brasil
		document.forms['formBot'].elements['sumBrasil'].value=preDivisa + anyadirCerosDecimales(formateaDivisa(Round(sumaBrasil,2)),2);
		document.forms['sumaTotal'].elements['sumaTotalBrasil'].value=preDivisa + anyadirCerosDecimales(document.forms['formBot'].elements['sumBrasil'].value,2) + sufDivisa;
	}else{
		//2set19 Sin muestras, no debe entrar aquí: document.forms['sumaTotal'].elements['sumaTotal'].value= preDivisa + document.forms['form_iddivisa'].elements['SOL_MUESTRAS'].value + sufDivisa;
	}
}

function clickCheckbox(obj){
	var posArr	= obj.name.replace('SELECCION_', '');
	var isChecked	= jQuery(obj).is(':checked');
	var thisProd	= arrayLineasProductos[ColumnaOrdenadaProds[posArr]].Productos[0];

	// Editamos el valor del campo 'Seleccionado' en el objeto
	if(isChecked){
		thisProd.Seleccionado = 'S';
	}else{
		thisProd.Seleccionado = 'N';
	}

	sumar_pedidoDirecto();
}


function mostrarSeleccionados(obj){

	//console.log('mostrarSeleccionados');

	//	var mostrarSeleccionados = jQuery(obj).prop("checked");
	FiltroSeleccion = jQuery(obj).prop("checked");

	// Vaciamos el filtro para texto y la variable global
	jQuery('#strFiltro').val('');
	filtroTXT	= '';

	jQuery.each(arrayLineasProductos, function(key, linea){
		linea.ContieneFiltroTXT = 'N';

		if(!FiltroSeleccion && v_OcultarNoSeleccionados!='SI'){
			linea.ContieneSeleccion = 'S';
		}else{
			if(linea.Productos[0].Seleccionado == 'S'){
				linea.ContieneSeleccion = 'S';
			}else{
				linea.ContieneSeleccion = 'N';
			}
		}

		if(linea.ContieneSeleccion == 'S'){
			linea.Mostrar = 'S';
		}else{
			linea.Mostrar = 'N';
		}
	});

	dibujaLineasPedido();
}

//control pedido minimo
function enviarPedido(){
	var pedMinimo		= parseFloat(document.getElementById('CEN_PEDIDOMINIMO').value.replace(/\./g,'').replace(",","."));		//16ago19 añadimos parsefloat y replace
	var pedMinimoTipo	= document.getElementById('CEN_TIPOPEDIDOMINIMO').value;

	// Esconder boton de continuar para evitar doble-click
	jQuery('#divContinuar').hide();
	
	if(document.forms['formBot'].elements['IDCENTRO'].value==-1)
	{
		alert(str_CentroNoSeleccionado);	
		return;
	}

	if(limiteComprasMensual != 'N'){	// Cliente club privado de compra

		if(limiteComprasMensual == '0'){
			alert(str_FechaCuotaCaducada.replace('[[FECHAULTIMACUOTA]]', fechaCuota));
			return;
		}else if(parseFloat(limiteComprasMensual) < (parseFloat(comprasPrevias) + parseFloat(desformateaDivisa(document.forms['sumaTotal'].elements['sumaTotal'].value)))){
			alert(str_LimiteComprasSuperado.replace('[[TOTALPEDIDO]]', document.forms['sumaTotal'].elements['sumaTotal'].value).replace('[[TOTALANTERIOR]]', anyadirCerosDecimales(formateaDivisa(comprasPrevias))).replace('[[LIMITE]]', limiteComprasMensual));
			return;
		}
	}

	var errorPedido	= pedidoMinimo(pedMinimo, parseFloat(document.forms['sumaTotal'].elements['sumaTotal'].value.replace(/\./g,'').replace(",",".")));

	//solodebug	console.log('enviarPedido. pedMinimoTipo:'+pedMinimoTipo+' pedidoMinimo:'+pedMinimo+' sumaTotal:'+parseFloat(document.forms['sumaTotal'].elements['sumaTotal'].value.replace(/\./g,'').replace(",","."))+'. errorPedido:'+errorPedido);

	if((errorPedido != '') && (errorPedido != 0) && ((pedMinimoTipo == 'E')||(pedMinimoTipo == 'S')))	//	Solo validamos en caso de pedido mínimo estricto
	{
		//solodebug		console.log('enviarPedido. pedidoMinimo. errorPedido:'+errorPedido);
		
		if (saltarPedMinimo=='N')
		{
			
			//solodebug			console.log('enviarPedido. errorPedido:'+errorPedido+'. alert!');
			
			//2set19	alert(errorPedido+ document.forms['form_iddivisa'].elements['POR_FAVOR_REVISE'].value);
			alert(errorPedido+ strPorFavorRevise);
			errorPedido='errr';
		}
		else
		{
			
			//solodebug		console.log('enviarPedido. errorPedido:'+errorPedido+'. confirm!');
			
			//2set19	if (confirm(errorPedido+ document.forms['form_iddivisa'].elements['AVISO_SALTAR_PEDMINIMO'].value)) errorPedido='';
			if (confirm(errorPedido+ strAvisoSaltarPedMinimo)) errorPedido='';
		}
	}
	else
	{
		errorPedido ='';
	}	
	
	if (errorPedido !='')
	{
		//solodebug		console.log('enviarPedido. errorPedido:'+errorPedido+'. show!');
		
		jQuery('#divContinuar').show();
	}
	else
	{
		//solodebug			console.log('enviarPedido. errorPedido:'+errorPedido+'. Actua!');
		
		Actua();
	}
}//fin de control pedido minimo


// Comprobacion pedido minimo
function pedidoMinimo(pedMinimo, total){
	var msg = '';

	//solodebug	console.log('pedidoMinimo('+pedMinimo+', '+total+')');

	if(total < pedMinimo){
		//2set19	msg += document.forms['form_iddivisa'].elements['PEDIDO_NO_LLEGA'].value +' '+ preDivisa + pedMinimo + sufDivisa +'.\n';
		msg += strPedidoNoLLega +' '+ preDivisa + pedMinimo + sufDivisa +'.\n';
	}

	//solodebug	console.log('pedidoMinimo('+pedMinimo+', '+total+'):'+msg);
	return msg;
}//fin pedidoMinimo


//  Validaciones y envio del formulario
function Actua(){

	var	Especial='',LineaEspecial;	//	24ene18	Control no juntar productos regulados y no regulados

	//anadido 11-05-12 mi si no lugar entrega se quedaba en el por defecto, ahora lo cogemos del select
	var centro = document.forms['formBot'].elements['IDCENTRO'].value;
	
	if (centro==-1)
	{
		alert(str_CentroNoSeleccionado);
		return;
	}
	
	document.forms['formBot'].elements['IDLUGARENTREGA'].value = document.forms['formBot'].elements['IDLUGARENTREGA_'+centro].value;

	var accio = 'LPAnalizarSave.xsql';
	var select='', selectCantidades='', suma;
	var mensajeError="";

	// Esconder boton de continuar para evitar doble-click
	jQuery('#divContinuar').hide();
	resetSignoDelProveedor();
	arrayProveedoresConDiferenteSigno.length=new Array();

	if(comprobarTodasCantidadesMismoSigno()!=true){
		mensajeError = asignarMensajeProveedoresDiferenteSigno(arrayProveedoresConDiferenteSigno);
	}
	InformaSeleccionaAlgun = str_NoSePuedeEnviarPedido;

	AsignarAccion(document.forms['formBot'], accio);

	jQuery.each(arrayLineasProductos, function(key, linea){
		if(linea.Productos[0].Seleccionado == 'S'){
			var cant	= linea.Productos[0].Cantidad_SinFormato;
			var IDPll	= linea.Productos[0].PLL_ID;
			
			LineaEspecial=(linea.Productos[0].Regulado=='S')?'Regulado':((linea.Productos[0].Pack=='S')?'Pack':'Normal');

			//solodebug	console.log('Pedido Especial:'+Especial+' Regulado:'+linea.Productos[0].Regulado+' Pack:'+linea.Productos[0].Pack+' LineaEspecial:'+LineaEspecial+' error:'+mensajeError);
			
			if (Especial=='') Especial=LineaEspecial;
			else if ((Especial!=LineaEspecial)&&(Especial!='ERROR'))
			{
				
				if ((Especial=='Regulado')||(LineaEspecial=='Regulado'))
					mensajeError += str_NoMezclarReguladoYNoRegulado;
				else if ((Especial=='Pack')||(LineaEspecial=='Pack'))
					mensajeError += str_NoMezclarPackYNoPack;
				
				Especial='ERROR';
			};
			

			if(IDPll != ''){
				//5nov18 selectCantidades	+= '(' + IDPll + '|' + cant + ')';
				selectCantidades	+= IDPll + '|' + cant + '#';

				if(select == ''){
					select	= IDPll;
				}else{
					select	+= ',' + IDPll;
				}
			}
		}
	});

	//Cadena con todas las cantidades de los productos seleccionados
	document.forms['formBot'].elements['STRING_CANTIDADES'].value	= selectCantidades;
	
	//La siguiente cadena no se utiliza, no la informamos para reducir HEADER del envío POST
	//document.forms['formBot'].elements['SELECCIONTOTAL'].value	= select;

	if(select==""){
		alert(InformaSeleccionaAlgun);
		jQuery('#divContinuar').show();
	}else{
		if(test(document.forms['formBot'])){
			var fechaActualTemp	= new Date();
			var fechaActual		= fechaActualTemp.getDate()+'/'+eval(fechaActualTemp.getMonth()+1)+'/'+fechaActualTemp.getFullYear();

			if(comparaFechas(document.forms['formBot'].elements['FECHA_ENTREGA'].value, fechaActual)=='&lt;'){
				mensajeError += str_FechaLimiteRespuesta + '\n';
			}

/*			if(parseFloat(document.forms['formBot'].elements['sumanumerica'].value)>10000){
				if(confirm(document.forms['form_iddivisa'].elements['PEDIDO_SUPERA_DIESMIL'].value)==false)
					return;
			}
*/
/*	2set19 Ya no se aceptan muestras desde pedidos
			//19-09-11 si es solicitud muestras compruebo que num solicitud sea menor de 15
			if(document.forms['sumaTotal'].elements['sumaTotal'].value=='Sol.Muestra' || document.forms['sumaTotal'].elements['sumaTotal'].value=='Sol.Amostra'){
				alert(document.forms['form_iddivisa'].elements['LIMITE_MUESTRAS'].value);
				document.getElementById('botonContinuar').disabled = true;
			}else{
			*/
				suma	= parseFloat(desformateaDivisa(document.forms['formBot'].elements['sum'].value));
				suma	= anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(suma),2)),2);

				//COPIO EN FORMU_BOTONES PARA QUE SE ENVIE
				document.forms['formBot'].elements['COSTE_LOGISTICA'].value =  document.forms['sumaTotal'].elements['COSTE_LOGISTICA'].value;

				//envio
				if(mensajeError==""){
					if((msgCantidadNegativa=algunProveedorConCantidadesNegativas(msgCantidadNegativa))!=''){
						if(confirm(msgCantidadNegativa)){
							SubmitForm(document.forms['formBot'], document);
						}
					}else{
						if(document.forms['formBot'].elements['STRING_CANTIDADES'].value!=''){
							SubmitForm(document.forms['formBot'], document);
						}
					}
				}else{
					alert(mensajeError);
					jQuery('#divContinuar').show();
				}
				//fin if-else envio
			//2set19	}//fin else de muestras
		}
	}
}


//	Se calculan los dias habiles. nom:nombre del combo; mas:incremento del "delay" cf sabado, domingo...
function calculaFecha(nom,mas)
{
	if(nom=='ENTREGANO' && document.forms['formBot'].elements['IDPLAZO'+nom].options[document.forms['formBot'].elements['IDPLAZO'+nom].selectedIndex].value==0){
		document.forms['formBot'].elements['FECHANO_ENTREGA'].value='';
	}else{
		var hoy=new Date();
		var Resultado;
		/*
		para la entrega y la decision se calculan dias habiles
		para el pago naturales
		*/

		if(nom=='ENTREGA' || nom=='DECISION'){
			/* para la fecha de entrega si el valor del desplegable es otros calculamos con el plazo minimo posible */
			if(mas==999){
				mas = plazoEntrega;
			}

			Resultado = calcularDiasHabiles(hoy,mas);
		}else{
			/* para la fecha de pago si el valor del desplegable es otros calculamos la de hoy */
			if(mas==999){
				mas = 0;
			}

			Resultado = sumaDiasAFecha(hoy, mas);

			// gestion de los sabados y domingos...
			var diaSemana = Resultado.getDay();

			if(diaSemana==0)
				Resultado = sumaDiasAFecha(Resultado,1);
			else
				if(diaSemana==6)
					Resultado = sumaDiasAFecha(Resultado,2);
		}

		// imprimir datos en los textbox en el formato dd/mm/aaaa....
		var elDia =	Resultado.getDate();
		var elMes =	Number(Resultado.getMonth())+1;
		var elAnyo = Resultado.getFullYear();
		var laFecha = elDia+'/'+elMes+'/'+elAnyo;

		if(nom=='ENTREGANO'){
			document.forms['formBot'].elements['FECHANO_ENTREGA'].value = laFecha;
		}else{
			document.forms['formBot'].elements['FECHA_'+nom].value = laFecha;
		}
	}
}


/* 29may15 - DC - El calculo de dias habiles ya se realiza en calculaFecha()
var fechaEntregaMinima;
function calculaFechaMinima(objDespl,queCampo){
	var hoy=new Date();

	if(queCampo=='ENTREGA'){
		fechaEntregaMinima = calcularDiasHabiles(hoy,obtenerValorMinimo(objDespl));
	}
}
*/

function highlightString(){
	var arrStr	= filtroTXT.split(" ");

	for(var i=0; i<arrStr.length; i++){
		jQuery('.toHighlight').highlight(arrStr[i]);
	}
}

//ver detalle producto
function verDetalleProducto(idProd){

    jQuery("#detalleProd tbody").empty();

     if(idProd != ''){
        jQuery.ajax({
		url: 'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalleAJAX.xsql',
		data: "PRO_ID="+idProd,
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

                    var tbodyProd = "";
                    tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ nombre +":</td><td class='datosLeft'>"+data.Producto.nombre+"</td></tr>";
                    tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ ref_proveedor +":</td><td class='datosLeft'>"+data.Producto.ref_prove+"</td></tr>";
                    tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ proveedor +":</td><td class='datosLeft'>"+data.Producto.prove+"</td>";
                    if(data.Producto.imagen != ''){
                        tbodyProd +=  "<td rowspan='4'><img src='http://www.newco.dev.br/Fotos/"+data.Producto.imagen+"' /></td>";
                    }
                    tbodyProd +="</tr>";
                    tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ ref_estandar +":</td><td class='datosLeft'>"+data.Producto.ref_estandar+"</td></tr>";
                    tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ marca +":</td><td class='datosLeft'>"+data.Producto.marca+"</td></tr>";
                    if(data.Producto.pais != '55'){
                        tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ iva +":</td><td class='datosLeft'>"+data.Producto.iva+"</td></tr>";
                    }
                    tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ unidad_basica +":</td><td class='datosLeft'>"+data.Producto.un_basica+"</td></tr>";
                    tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ unidad_lote +":</td><td class='datosLeft'>"+data.Producto.un_lote+"</td></tr>";
                    if(data.Producto.farmacia != ''){
                        tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ farmacia +":</td><td class='datosLeft'>"+data.Producto.farmacia+"</td></tr>";
                    }
                    if(data.Producto.homologado != ''){
                        tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ homologado +":</td><td class='datosLeft'>"+data.Producto.homologado+"</td></tr>";
                    }
                    tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ precio +":</td><td class='datosLeft'>"+data.Producto.tarifa+"</td></tr>";
                    if(data.Producto.categoria != '' && data.Producto.categoria != 'DEFECTO'){
                        tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ catalogo +":</td><td class='datosLeft'>"+data.Producto.categoria+"</td></tr>";
                    }
                    tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ familia +":</td><td class='datosLeft'>"+data.Producto.familia+"</td></tr>";
                    tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ subfamilia +":</td><td class='datosLeft'>"+data.Producto.sub_familia+"</td></tr>";
                    if(data.Producto.grupo != '' && data.Producto.categoria != 'DEFECTO'){
                        tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ grupo +":</td><td class='datosLeft'>"+data.Producto.grupo+"</td></tr>";
                    }


                     /*alert('cliente '+data.Cliente[0].nombre);
                    for(var i=0; i<data.Producto.Cliente;i++){
                        tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ precio + data.Producto.Cliente[i].nombre +":</td><td class='datosLeft'>"+data.Producto.Cliente[i].tarifa+"</td></tr>";
                        //tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ fecha_limite +":</td><td class='datosLeft'>"+data.Producto.Cliente[i].fecha_limite+"</td></tr>";

                    } */

                    jQuery("#detalleProd tbody").append(tbodyProd);

                    showTabla(true);

                }

            });
    }
    else{
                    jQuery("#detalleProd tbody").empty().append("<tr><td align='center' colspan='2'><strong>" + nombre + "</strong></td></tr>");
                }

}//fin de verDetalleProducto


function ordenarProductos(orden){
	v_OrdenarProductos	= 'SI';
	
	//solodebug	console.log('ordenarProductos:'+orden);

	if (orden=='NOMBRE')
	{
		ordenamientoAlfabet('DescripcionLinea', 'ASC');
	}
	else
	{
		ordenamientoAlfabet('ReferenciaLinea', 'ASC');
	}

	dibujaLineasPedido();
}

//	Prepara un array con los ordenes correspondientes a una columna de caracteres alfanumericos
function ordenamientoAlfabet(col, tipo){
	var temp, temp2, size, valAux;
	var arrValores = new Array();

	//solodebug	alert('ordenamientoAlfabet col:'+col+' > tipo:'+tipo);


	// Creamos un vector auxiliar con los valores que queremos ordenar (segun el vector de ordenacion)
	for(var i=0; i<totalProductos; i++){
			valAux = arrayLineasProductos[ColumnaOrdenadaProds[i]][col];
			arrValores.push(valAux);
	}

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
				
				//solodebug	console.log('ordenamientoAlfabet arrValores[left]:'+arrValores[left]+' > arrValores[right]:'+arrValores[right]);
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

function prepararTablaProductos(){
	totalProductos	= arrayLineasProductos.length;

	if(ColumnaOrdenacionProds == 'linea'){
		for(var i=0; i<totalProductos; i++){
			ColumnaOrdenadaProds[i] = i;
		}
	}

	dibujaLineasPedido();
}

//	27may17 Incluir productos desde areatext
function IncluirProductosPorReferencia()
{
	var Cambios=false, Count=0, Seleccionados=0, Modificados=0, NoEncontrados=0, RefNoEncontradas='';
	
	jQuery("#EnviarProductosPorRef").hide();
	
	//solodebug	var Control='';
	var Referencias= document.getElementById('LISTA_REFPRODUCTO').value;
	Referencias	= Referencias.replace(/(?:\r\n|\r|\n)/g, '|');
	Referencias	= Referencias.replace(/[\t:]/g, ':');	// 	Separadores admitidos para separar referencia de cantidad
	Referencias	= Referencias.replace(/ /g, ':');		// 	Separadores admitidos para separar referencia de cantidad
	
	var numRefs	= PieceCount(Referencias, '|');
	
	for (i=0;i<=numRefs;++i)
	{
		var Producto= Piece(Referencias, '|',i);
		var Ref		= Piece(Producto, ':', 0);
		var Cant	= Piece(Producto, ':', 1);
		
		//solodebug console.log("IncluirProductosPorReferencia. Procesando registro "+i+". RefCliente:"+Ref+" Cant:"+Cant);
		
		if (Ref!='')
		{
			//solodebug	Control=Control+'['+i+'/'+numRefs+'] Referencia:'+Ref+ '. Cantidad:'+Cant;

			//	Recorre el array de productos buscando la referencia
			var Encont=false;
			for (j=0;((j<arrayLineasProductos.length) && (!Encont));++j)
			{
				
				//solodebug console.log("IncluirProductosPorReferencia. Procesando registro "+i+". RefCliente:"+Ref+" Cant:"+Cant
				//solodebug 	+" Comprobando producto "+j+ " Refcliente:"+arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].RefCliente
				//solodebug 	+ " RefPrivada:"+arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].RefPrivada);
				
				if ((arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].RefCliente==Ref)||(arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].RefPrivada==Ref))
				{
					//solodebug	Control=Control+' encontrado en posicion '+j;
					//jQuery('#Cantidad_' + (arrayLineasProductos[ColumnaOrdenadaProds[j]].linea - 1)).val(Cant);
					
					if (Cant=='')
					{
						arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].Cantidad_SinFormato = arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].UdsXLote_SinFormato;
						arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].Cantidad = parseFloat(arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].UdsXLote);
					}
					else
					{
						//	5jun20 Control de las unidades por lote antes de actualizar
						var uds		= parseFloat(desformateaDivisa(Cant));
						var udsXLote	= parseInt(arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].UdsXLote_SinFormato);
						
						//solodebug	console.log("IncluirProductosPorReferencia RefCliente:"+Ref+' Unidades:'+uds+' empaquetamiento:'+udsXLote);
						
						if(uds%udsXLote!=0)
						{
							var lotes=(Math.abs(uds)-(Math.abs(uds)%udsXLote))/udsXLote+1;
							Cant=udsXLote*lotes;
							alert(uds+ strRedondeoUnidades +'\n'+ strRedondeoUnidades2 +Math.abs(lotes)+ strCajas + '. ('+Math.abs(Cant)+ strUnidades + ')');
						
							//solodebug	console.log("IncluirProductosPorReferencia RefCliente:"+Ref+' Unidades:'+uds+' empaquetamiento:'+udsXLote);
							
						}
					
						arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].Cantidad_SinFormato = Cant;
						arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].Cantidad = parseFloat(desformateaDivisa(Cant));
					}
					
					jQuery("input.cantidad[name='NuevaCantidad_" + ColumnaOrdenadaProds[j] + "']").val(Cant);

					if (!jQuery("input.SELECCION[name='SELECCION_" + ColumnaOrdenadaProds[j] + "']").attr('checked'))
					{
						jQuery("input.SELECCION[name='SELECCION_" + ColumnaOrdenadaProds[j] + "']").attr('checked', true);
						arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].Seleccionado = 'S';
						Seleccionados++;
					}
					else
					{
						Modificados++;
						console.log("IncluirProductosPorReferencia Encontrado y modificado: RefCliente:"+Ref+"="+arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].RefCliente+ 'Cant:'+Cant+" Camposeleccion:SELECCION_" + ColumnaOrdenadaProds[j]);
					}
					
					//solodebug ET 27may17 console.log("IncluirProductosPorReferencia RefCliente:"+Ref+"="+arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].RefCliente+ 'Cant:'+Cant+" Camposleccion:SELECCION_" + ColumnaOrdenadaProds[j]);

					Encont=true;
					Cambios=true;
					
					Count++;
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

	//solodebug	alert('IncluirProductosPorReferencia:'+Referencias+'\n\r'+'\n\r'+Control);

	var aviso=strAvisoProcesados.replace('[[TOTAL]]',Count).replace('[[SELECCIONADOS]]',Seleccionados).replace('[[MODIFICADOS]]',Modificados).replace('[[NO_ENCONTRADOS]]',NoEncontrados+(NoEncontrados==0?".":":"+RefNoEncontradas))

	alert(aviso);

	//	En el caso de que se estan ocultando lineas no seleccionadas, marcamos seleccion 
	if (v_OcultarNoSeleccionados=='SI')
	{
		document.getElementById("SOLO_SELECCIONADOS").checked = true;
		mostrarSeleccionados(jQuery("#SOLO_SELECCIONADOS"));
	}

	jQuery("#EnviarProductosPorRef").show();
	
	dibujaLineasPedido();
	sumar_pedidoDirecto();	//	5nov18 Faltaba sumar pedido directo
		
}



//
//	22ago18	Las sigueinte lineas estaban directamente
//

var suma=0;
var vector;
var const_decimales = 0;

// Creamos un array de num_cols posiciones
function crearArray(num_cols){
	max_cols=parseInt(num_cols);
	count=0;
	suma=0;
	vector = new Array(max_cols);
}

// Rellenamos el array con el identificador y el precio
function anadirArray(identificador,precio){
	vector[count]= new Array(2);
	vector[count][0]=identificador;
	vector[count][1]=precio;
	count++;
}


/********* AQUI EMPIEZAN LAS FUNCIONES DEL FRAME DE ABAJO (FECHAS) ***************/
//var signo='';

function obtenerSignoDelProveedor(proveedor){
	for(var i=0;i<arrayProveedores.length;i++){
		//alert('obtener: '+arrayProveedores[i][0]+' '+arrayProveedores[i][1]);

		if(arrayProveedores[i][0]==proveedor){
			//alert('obtener: '+arrayProveedores[i][0]+' '+arrayProveedores[i][1]);
			return arrayProveedores[i][1];
		}
	}
}

function setSignoDelProveedor(proveedor, elSigno){
	for(var i=0;i<arrayProveedores.length;i++){
		if(arrayProveedores[i][0]==proveedor){
			//alert('set: '+arrayProveedores[i][0]+' '+elSigno);
			arrayProveedores[i][1]=elSigno;
		}
	}
}

function resetSignoDelProveedor(){
	for(var i=0;i<arrayProveedores.length;i++){
		arrayProveedores[i][1]='';
	}
}

function insertarSiNoExiste(proveedor){
	var existe=0;
	for(var i=0;i<arrayProveedoresConDiferenteSigno.length;i++){
		if(arrayProveedoresConDiferenteSigno[i]==proveedor){
			existe=1;
		}
	}

	if(!existe)
		arrayProveedoresConDiferenteSigno[arrayProveedoresConDiferenteSigno.length]=proveedor;

	return arrayProveedoresConDiferenteSigno;
}

function comprobarTodasCantidadesMismoSigno(){
	var form;
	var id;
	var signoLocal='';

	for(var i=0;i<document.forms.length;i++){
		form=document.forms[i];

		for(var j=0;j<form.length;j++){
			if(form.elements[j].name.substring(0,14)=='NuevaCantidad_' && form.elements['SELECCION'].checked==true){
				id=obtenerId(form.elements[j].name);
				signoLocal=obtenerSignoDelProveedor(form.elements['PRODUCTOPROVEEDOR_'+id].value);

				if(parseFloat(desformateaDivisa(form.elements[j].value))<0){
					if(signoLocal=='' || signoLocal=='-'){
						setSignoDelProveedor(form.elements['PRODUCTOPROVEEDOR_'+id].value,'-');
					}else{
						arrayProveedoresConDiferenteSigno=insertarSiNoExiste(form.elements['PRODUCTOPROVEEDOR_'+id].value);
					}
				}else{
					if(signoLocal=='' || signoLocal=='+'){
						setSignoDelProveedor(form.elements['PRODUCTOPROVEEDOR_'+id].value,'+');
					}else{
						arrayProveedoresConDiferenteSigno=insertarSiNoExiste(form.elements['PRODUCTOPROVEEDOR_'+id].value);
					}
				}
			}
		}
	}

	if(arrayProveedoresConDiferenteSigno.length==0)
		return true;
	else
		return arrayProveedoresConDiferenteSigno;
}

function algunProveedorConCantidadesNegativas(msgCantidadNegativa){
	msgCantidadNegativa='';
	var existe=0;

	for(var n=0;n<arrayProveedores.length;n++){
		if(arrayProveedores[n][1]=='-' && !existe){
			existe=1;
			//2set19	msgCantidadNegativa+=document.forms['form_iddivisa'].elements['CANTIDADES_NEGATIVAS'].value;
			msgCantidadNegativa+=strCantidadesNegativas;
			//arrayProveedores[n][0]
		}
	}

	return msgCantidadNegativa;
}

function asignarMensajeProveedoresDiferenteSigno(arrayProveedoresConDiferenteSigno){
	var msgDiferenteSigno='';

	if(arrayProveedoresConDiferenteSigno.length>0){
		for(var n=0;n<arrayProveedoresConDiferenteSigno.length;n++){
			//2set19	msgDiferenteSigno+=document.forms['form_iddivisa'].elements['VERIFIQUE_CANTIDADES_ABONO'].value+' '+arrayProveedoresConDiferenteSigno[n]+' '+ document.forms['form_iddivisa'].elements['SON_TODAS_NEGATIVAS'].value+'.\n';
			msgDiferenteSigno+=strVerifiqueAbono+' '+arrayProveedoresConDiferenteSigno[n]+' '+ strTodasNegativas+'.\n';
		}
	}

	return msgDiferenteSigno;
}

function obtenerValorMinimo(objDepl){
	var minimo;

	minimo=parseInt(objDepl.options[0].value);
	for(var n=1;n<objDepl.options.length;n++){
		if(parseInt(objDepl.options[n].value)<minimo){
			minimo=parseInt(objDepl.options[n].value);
		}
	}
	return minimo;
}

function calculaFechaCalendarios(mas){
	var hoy=new Date();
	var Resultado=calcularDiasHabiles(hoy,mas);
	var elDia=Resultado.getDate();
	var elMes=Number(Resultado.getMonth())+1;
	var elAnyo=Resultado.getFullYear();
	var laFecha=elDia+'/'+elMes+'/'+elAnyo;

	return laFecha;
}

function asignarValorDesplegable(form,nombreObj,valor){
	var indiceSeleccionado=form.elements[nombreObj].length-1;

	for(var n=0;n<form.elements[nombreObj].length;n++){
		if(form.elements[nombreObj].options[n].value==valor){
			indiceSeleccionado=n;
		}
	}

	form.elements[nombreObj].selectedIndex=indiceSeleccionado;
}

function actualizarPlazo(form,nombreObj, fFechaOrigen){
	var fechaOrigen=fFechaOrigen.getDate()+'/'+(Number(fFechaOrigen.getMonth())+1)+'/'+fFechaOrigen.getFullYear();
	var fechaDestino=form.elements['FECHA_'+nombreObj].value;
	var nombreCombo;

	if(CheckDate(fechaDestino)==''){
		var fFechaDestino=new Date(formatoFecha(fechaDestino,'E','I'));

		if(nombreObj=='ENTREGA'){
			var diferencia=diferenciaDias(fFechaOrigen,fFechaDestino,'HABILES');
			nombreCombo='COMBO_'+nombreObj;
		}else{
			var diferencia=diferenciaDias(fFechaOrigen,fFechaDestino,'NATURALES');
			nombreCombo='IDPLAZOPAGO';
		}

		asignarValorDesplegable(form,nombreCombo,diferencia);
	}else{
		alert(CheckDate(fechaDestino));
	}
}
