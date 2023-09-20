//	Javascript para el primer paso del pedido
//	Ultima revision: ET 5may22 18:30 LPAnalizar2022_160222.js


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

	//solo para limpiar cache navegador
	debug('globalEvents. LP_ID:'+LP_ID);
	jQuery('#LP_ID').val(LP_ID);

	if (requiereCarga=='S')			
	{
		jQuery('#spBotones').hide();
		jQuery('#spAvance').show();
		cargaProductosAjax(0);
	}
	else
	{
		//	Prepara el pedido
		PreparaPedido();
	}
}


//	11feb21	Separamos la prepatracion del pedido para llamarla al inicio O al acabar de cargar los productos
function PreparaPedido()
{
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
	//solodebug
	debug("PreparaPedido:"+arrayLineasProductos.length+' tipoPlantilla:'+tipoPlantilla);
	
	if (arrayLineasProductos.length>cLimitePlantillaVisible)
	{
		v_OcultarNoSeleccionados='SI';
		
		aplicarFiltro('··· CADENA QUE NO DEBE SER ENCONTRADA ZZZ','','');
	}
	

	jQuery("#strFiltro").on('input propertychange', function(){
		aplicarFiltroCompleto();
	});

	// Prepara el array de ordenación para preparar los datos para dibujar la tabla
	prepararTablaProductos();

	// Validamos por si hay cantidades que no se corresponden con las UdsXLote (no son multiplo)
	//	23dic20	se validan en la base de datos, mas eficiente: validarCantidades();

	if ((document.forms['formBot'].elements['CENTROSVISIBLES'].value=='S')&&(arrayCentros.length>2))
		inicializarDesplegableCentros(-1);
	else
		inicializarDesplegableCentros(document.forms['formBot'].elements['IDCENTRO'].value);

	// Se calculan las fechas de forma automatica
	//	7feb20	calculaFecha('ENTREGA',document.forms[0].elements['COMBO_ENTREGA'].value);
	if (saltarPedMinimo=='N') inicializaDesplegablePlazoEntrega();
	calculaFecha('ENTREGA',document.forms[0].elements['PLAZOCONSULTA'].value);

}


//	10feb21 carga la matriz de productos
function cargaProductosAjax(Pag)
{
	var d= new Date(), prodCargados=Pag*lineasPorPag, TotalPag=Math.ceil(prodVisibles/lineasPorPag);
	
	//solodebug	
	debug('cargaProductos: '+prodCargados+'/'+prodVisibles+ ' Tot.Paginas:'+TotalPag);

	jQuery('#spAvance').html(prodCargados+'/'+prodVisibles);

	if (Pag>=TotalPag)
	{
		//solodebug 
		debug('cargaProductosAjax: Pag:'+Pag+ ' total:'+TotalPag+ ' => TODOS CARGADOS');
		
		jQuery('#spBotones').show();
		jQuery('#spAvance').hide();
		
		PreparaPedido();
		return;
	}
	else
	{
		//solodebug 
		debug('cargaProductosAjax: Pag:'+Pag+ ' Tot.Paginas:'+TotalPag);
		
		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Compras/Multioferta/LPProductosPlantillaAjax.xsql',
			type:	"GET",
			//async:	false,			//	Lo hacemos de forma síncrona, más lento pero más seguro, y permite informar al cliente
			data:	"LP_ID="+LP_ID+"&PAGINA="+Pag+"&LINEASPORPAGINA="+lineasPorPag+"&_="+d.getTime(),
			contentType: "application/xhtml+xml",
			error: function(objeto, quepaso, otroobj){
				alert('error'+quepaso+' '+otroobj+' '+objeto);
			},
			success: function(objeto)
			{
				//var data = eval("(" + objeto + ")");
				var data = JSON.parse(objeto);

				for (var i=0;i<data.Lineas.length;++i)
				{
					jQuery('#spAvance').html('Prueba '+(prodCargados+i).toString()+'/'+prodVisibles);
					
					var lineas			= data.Lineas[i];

					arrayLineasProductos.push(lineas);
				}
		
				//solodebug 
				debug('cargaProductosAjax: Pag:'+Pag+ ' Datos:'+JSON.stringify(data));
				cargaProductosAjax(++Pag);
				return;
			}
		});
		
		
	}
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

	//solodebug debug('inicializarDesplegableCentros IDCentro:'+IDCentro+' IDCentroDefecto:'+IDCentroDefecto);

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

	//solodebug debug('inicializarDesplegableCentros centroSeleccionado:'+centroSeleccionado+' CentroExiste:'+CentroExiste+' IDPrimerCentro:'+IDPrimerCentro);

	document.forms['formBot'].elements['IDCENTRO'].length=0;

	for(var n=0; n<arrayCentros.length; n++){
	
		//solodebug	alert(arrayCentros[n][1]);
	
		if(arrayCentros[n][0]==centroSeleccionado){
			document.forms['formBot'].elements['IDCENTRO'].options[document.forms['formBot'].elements['IDCENTRO'].length]=new Option('['+arrayCentros[n][1]+']',arrayCentros[n][0]);
			
			document.forms['formBot'].elements['IDCENTRO'].options[document.forms['formBot'].elements['IDCENTRO'].length-1].selected=true;

			//coste de transporte
			document.forms['sumaTotal'].elements['COSTE_LOGISTICA'].value =anyadirCerosDecimales(FormatoNumero(Round(desformateaDivisa(arrayCentros[n][3]),2)),2);

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

	//solodebug debug('mostrarDesplegableLugarDeEntrega IDCentroActual:'+IDCentroActual+' IDLugarEntregaActual:'+IDLugarEntregaActual);

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
			
			//solodebug debug('mostrarDesplegableLugarDeEntrega IDCentroActual:'+IDCentroActual+' Incluyendo: ('+arrayLugaresEntrega[n][0]+') '+arrayLugaresEntrega[n][2]);
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
	
			poslugarEntrega=n;
			
			form.elements['CEN_DIRECCION'].value=arrayLugaresEntrega[n][4];
			form.elements['CEN_CPOSTAL'].value=arrayLugaresEntrega[n][5];
			form.elements['CEN_POBLACION'].value=arrayLugaresEntrega[n][6];
			form.elements['CEN_PROVINCIA'].value=arrayLugaresEntrega[n][7];
			
			//	22ene21 Cambiamos el pedido minimo segun divisa
			mostrarSegunDivisa();
			
		}
	}
}// fin ActualizarTextoLugarEntrega


//	Aplica filtro por producto, categoria y tipo de negociacion
function aplicarFiltro(filtroTxt, IDCategoria, IDTipoNeg){
	var check;

	//solodebug	debug('FiltroSeleccion:'+filtroTxt+' IDCategoria:'+IDCategoria+' IDTipoNeg:'+IDTipoNeg);
	
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
		
		if( ((IDCategoria=='-1')||(linea.Productos[0].IDCategoria==IDCategoria)) &&  ((IDTipoNeg=='')||(linea.Productos[0].IDTipoNeg==IDTipoNeg)) && (!FiltroSeleccion ||linea.ContieneSeleccion == 'S') && linea.ContieneFiltroTXT == 'S'){
			linea.Mostrar = 'S';
		}else{
			linea.Mostrar = 'N';
		}
		
		//solodebug ET 26may17	
		//debug('FiltroSeleccion:'+FiltroSeleccion+' Sel:'+linea.ContieneSeleccion+' Producto:'+linea.Productos[0].stringBuscador.toLowerCase()
		//		+' IDTipoNeg:'+linea.Productos[0].IDTipoNeg+' IDCategoria:'+linea.Productos[0].IDCategoria +' Mostrar:'||linea.Mostrar);
		
	});

	dibujaLineasPedido();
}

var rowStart		= '<tr>';
var rowStartStyle	= '<tr style="#STYLE#">';
var rowStartClass	= '<tr class="#CLASS#">';
var rowStartClassStyle	= '<tr class="#CLASS#" style="#STYLE#">';
var rowStartID		= '<tr id="#ID#">';
var rowStartIDStyle	= '<tr id="#ID#" style="#STYLE#">';
var rowStartIDClassStyle= '<tr id="#ID#" class="#CLASS#" style="#STYLE#">';
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

	//solodebug	debug('dibujaLineasPedido. OcultarNoSeleccionados:'+v_OcultarNoSeleccionados);
	
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

		//solodebug	debug('dibujaLineasPedido ('+value+'):'+arrayLineasProductos[value].Mostrar);


		(arrayLineasProductos[value].Mostrar=='S') ? displayTxt='' : displayTxt='display:none;';

		jQuery.each(arrayLineasProductos[value].Productos, function(key2, producto){
			(producto.Tarifa=='') ? hayPrecio=0 : hayPrecio=1;

			// Generamos la fila con el nombre de la subfamilia y/o grupo
			if(v_OrdenarProductos == 'NO' && (lastGrupo!=producto.Grupo || lastSubfamilia!=producto.Subfamilia))
			{
				thisRow = rowStartClassStyle.replace('#CLASS#', 'subCategorias').replace('#STYLE#', displayTxt);

				thisCell = cellHColStart.replace('#COLSPAN#', '2') + '&nbsp;' + cellHEnd;
				thisRow += thisCell;

				//21dic16	thisCell = cellHAlignColStart.replace('#ALIGN#', 'left');
				
				//solodebug		debug('cellHAlignColClassStart:'+cellHAlignColClassStart);
				
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

				//solodebug		debug('thisCell:'+thisCell);

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
			
			var clase='';
			if(producto.IDDivisa!='0'){				//	11ene21	Marcamos si es divisa diferente
				clase += ' amarillo';
			}
			
			//11ene21	thisRow = rowStartIDStyle.replace('#ID#', 'posArr_' + key).replace('#STYLE#', displayTxt);
			thisRow = rowStartIDClassStyle.replace('#ID#', 'posArr_' + key).replace('#STYLE#', displayTxt).replace('#CLASS#', clase);

			// Ref.MVM si no es farmacia o Ref.Prove si es farmacia
			thisCell = cellStartAlign.replace('#ALIGN#', 'left');
			thisCell += spanClassStart.replace('#CLASS#', 'font11') + '&nbsp;';
			
			
			//solodebug	debug("RefPrivada:"+ producto.RefPrivada+ "RefCliente:"+producto.RefCliente);
			
			var avisoOrden= '';
			if (producto.Orden>1) avisoOrden=' <img src="http://www.newco.dev.br/images/bolaAmbar.gif" title="Orden:'+producto.Orden+'"/>';
			
			if(producto.RefCliente!=''){
				thisCell += '<span class="toHighlight">' + producto.RefCliente + avisoOrden+ '</span>';
			}else{
				thisCell += '<span class="toHighlight">' + producto.RefPrivada + avisoOrden+ '</span>';
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
			//	CUIDADO, UN PRODUCTO PUEDE SER PACK+CONVENIO
			//else 
			if(producto.Pack=='S'){
				thisCell += spanClassStart.replace('#CLASS#', 'amarillo') + '<b>[PACK]</b>' + spanEnd + '&nbsp;';
			}
			//else 
			if(producto.Regulado=='S'){
				thisCell += spanClassStart.replace('#CLASS#', 'amarillo') + '<b>[REG]</b>' + spanEnd + '&nbsp;';
			}
			//else 
			if(producto.Convenio=='S'){
				thisCell += spanClassStart.replace('#CLASS#', 'amarillo') + '<b>[CONV]</b>' + spanEnd + '&nbsp;';
			}
			//else 
			if(producto.Deposito=='S'){
				thisCell += spanClassStart.replace('#CLASS#', 'amarillo') + '<b>[DEP]</b>' + spanEnd + '&nbsp;';
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
					//if(producto.Categoria=='F' && usarRefProveedor=='N'){
					//	thisCell += '<span class="toHighlight">' + producto.Referencia + '</span>';
					//}else if(producto.Categoria=='N'){
						thisCell += '<span class="toHighlight">' + producto.Referencia + '</span>';
					//}
					thisCell += cellEnd;
				}
				else
				{

                    thisCell = cellStartClass.replace('#CLASS#', 'center');
					//if(producto.Categoria=='N'){
						thisCell += '<span class="toHighlight">' + producto.Referencia + '</span>';
					//}
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
			
			
			var htmlBonif='';
			
			if (producto.Bonificado=='S')
			{
				htmlBonif='<img src="http://www.newco.dev.br/images/info.gif" title="'+str_BonifCantCompra+':'+producto.CantBonif+'. '+str_BonifCantObs+':'+producto.CantGratis+'">';
				debug('Bonificado:'+htmlBonif);
			}

			if(tipoPlantilla == 'asisaBrasil' || tipoPlantilla == 'nuevoModeloViejoPedido'){
				// Precio Prov (sIVA)
				valAux	= desformateaDivisa(producto.Tarifa_SinFormat);
				/*
				if(valAux <= 10)
					valAux2	= anyadirCerosDecimales(FormatoNumero(reemplazaPuntoPorComa(Round(valAux,4))),4);
				else
					valAux2	= anyadirCerosDecimales(FormatoNumero(reemplazaPuntoPorComa(Round(valAux,2))),2);
				*/

				valAux2	= anyadirCerosDecimales(FormatoNumero(reemplazaPuntoPorComa(Round(valAux,decimalesPrecio))),decimalesPrecio);

				if(producto.IDDivisa!='0'){
					valAux2 =  producto.PrefijoDiv+'&nbsp;'+valAux2+'&nbsp;'+producto.SufijoDiv;
				}			

				thisCell = cellStartClass.replace('#CLASS#', 'center');

				thisCell += htmlBonif;

				thisMacro = macroInputText.replace('#CLASS#', 'noinput medio');
				thisMacro = thisMacro.replace('#SIZE#', '7');
				thisMacro = thisMacro.replace('#ALIGN#', 'right');
				thisMacro = thisMacro.replace('#NAME#', 'PRECIOUNITARIO_' + key);
				thisMacro = thisMacro.replace('#VALUE#', valAux2);					//	ET 3nov17 , 22ago18 volvemos a quitar divisa + sufDivisa
				thisMacro = thisMacro.replace('#ONFOCUS#', 'this.blur()');
				thisMacro = thisMacro.replace('#STYLE#', 'text-align:right;');
				thisCell += thisMacro;
				
				//	2jun21 flecha verde o roja segÃºn el cambio
				if (producto.TarAnt_Importe!='')
				{
					if (producto.TarAnt_Cambio=='SUBE')
						thisCell += '<img src="http://www.newco.dev.br/images/order_a_rojo.gif" title="'+producto.TarAnt_Fecha+':'+producto.TarAnt_Importe+'"/>';
					else if (producto.TarAnt_Cambio=='BAJA')
						thisCell += '<img src="http://www.newco.dev.br/images/order_d_verde.gif" title="'+producto.TarAnt_Fecha+':'+producto.TarAnt_Importe+'"/>';
				}

				thisCell += cellEnd;

				thisRow += thisCell;
                }

			if(tipoPlantilla == 'viamedNuevo' || tipoPlantilla == 'nuevoModeloViejoPedido'){
				// Precio Prov + IVA
				valAux	= desformateaDivisa(producto.Tarifa_SinFormat) + desformateaDivisa(producto.ImporteIVA_SinFormat);
				/*
				if(valAux <= 10)
					valAux2	= anyadirCerosDecimales(FormatoNumero(reemplazaPuntoPorComa(Round(valAux,4))),4);
				else
					valAux2	= anyadirCerosDecimales(FormatoNumero(reemplazaPuntoPorComa(Round(valAux,2))),2);
				*/
				valAux2	= anyadirCerosDecimales(FormatoNumero(reemplazaPuntoPorComa(Round(valAux,decimalesPrecio))),decimalesPrecio);
				if(producto.IDDivisa!='0'){
					valAux2 =  producto.PrefijoDiv+'&nbsp;'+valAux2+'&nbsp;'+producto.SufijoDiv;
				}			

				thisCell = cellStartClass.replace('#CLASS#', 'center');
				thisMacro = macroInputText.replace('#CLASS#', 'noinput medio');
				thisMacro = thisMacro.replace('#SIZE#', '7');
				thisMacro = thisMacro.replace('#ALIGN#', 'right');
				thisMacro = thisMacro.replace('#NAME#', 'PRECIOUNITARIOCONIVA_' + key);
				thisMacro = thisMacro.replace('#VALUE#', valAux2);				//	ET 3nov17 , 22ago18 volvemos a quitar divisa + sufDivisa
				thisMacro = thisMacro.replace('#ONFOCUS#', 'this.blur()');
				thisMacro = thisMacro.replace('#STYLE#', 'text-align:right;');
				thisCell += thisMacro;

				thisCell += htmlBonif;
				thisCell += cellEnd;

				thisRow += thisCell;
			}else if(tipoPlantilla == 'nuevoModeloNuevoPedido'){
				// Precio Prov + IVA + comision MVM
				valAux	= desformateaDivisa(producto.Tarifa_SinFormat) + desformateaDivisa(producto.ImporteIVA_SinFormat) + desformateaDivisa(producto.ComisionMVM_SinFormat);
				/*
				if(valAux <= 10)
					valAux2	= anyadirCerosDecimales(FormatoNumero(reemplazaPuntoPorComa(Round(valAux,4))),4);
				else
					valAux2	= anyadirCerosDecimales(FormatoNumero(reemplazaPuntoPorComa(Round(valAux,2))),2);
				*/
				valAux2	= anyadirCerosDecimales(FormatoNumero(reemplazaPuntoPorComa(Round(valAux,decimalesPrecio))),decimalesPrecio);
				if(producto.IDDivisa!='0'){
					valAux2 =  producto.PrefijoDiv+'&nbsp;'+valAux2+'&nbsp;'+producto.SufijoDiv;
				}			

				thisCell = cellStartClass.replace('#CLASS#', 'center');
				thisMacro = macroInputText.replace('#CLASS#', 'noinput medio');
				thisMacro = thisMacro.replace('#SIZE#', '7');
				thisMacro = thisMacro.replace('#ALIGN#', 'right');
				thisMacro = thisMacro.replace('#NAME#', 'PRECIOUNITARIOCONIVA_' + key);
				thisMacro = thisMacro.replace('#VALUE#', valAux2);				//	ET 3nov17 , 22ago18 volvemos a quitar divisa + sufDivisa
				thisMacro = thisMacro.replace('#ONFOCUS#', 'this.blur()');
				thisMacro = thisMacro.replace('#STYLE#', 'text-align:right;');
				thisCell += thisMacro;

				thisCell += htmlBonif;

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
			thisMacro = thisMacro.replace('#CLASS#', 'campopesquisa cantidad w80px');
			thisMacro = thisMacro.replace('#VALUE#', producto.Cantidad_SinFormato);
			thisMacro = thisMacro.replace('#STYLE#', 'text-align:right;');
			thisMacro = thisMacro.replace('#MAXLENGTH#', '7');								//	Aumentamos tamaño a 7 digitos, solicitado por Imbanaco
			functionJS= 'javascript:UnidadesALotes(this);';
			thisMacro = thisMacro.replace('#ONBLUR#', functionJS);
			functionJS= 'javascript:Seleccionar(this);';
			thisMacro = thisMacro.replace('#ONINPUT#', functionJS);

			//	27oct20 Deshabilitamos este campo en caso de "sin stock"
			disabled='';
			//solodebug
			if (producto.TipoSinStock!='' && producto.TextSinStock)
				 debug(producto.Nombre+'. TipoSinStock:'+producto.TipoSinStock+' TextSinStock:'+producto.TextSinStock+' indexOf:'+producto.TextSinStock.indexOf('NO SOLICITAR'));
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
					valAux2	= anyadirCerosDecimales(FormatoNumero(reemplazaPuntoPorComa(Round(valAux,decimalesTotal))),decimalesTotal);
					//	11ene21
					if(producto.IDDivisa!='0'){
						valAux2 =  producto.PrefijoDiv+'&nbsp;'+valAux2+'&nbsp;'+producto.SufijoDiv;
					}			

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
				valAux2	= anyadirCerosDecimales(FormatoNumero(reemplazaPuntoPorComa(Round(valAux,decimalesTotal))),decimalesTotal);
					//	11ene21
					if(producto.IDDivisa!='0'){
						valAux2 =  producto.PrefijoDiv+'&nbsp;'+valAux2+'&nbsp;'+producto.SufijoDiv;
					}			

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
				valAux2	= anyadirCerosDecimales(FormatoNumero(reemplazaPuntoPorComa(Round(valAux,decimalesTotal))),decimalesTotal);
					//	11ene21
					if(producto.IDDivisa!='0'){
						valAux2 =  producto.PrefijoDiv+'&nbsp;'+valAux2+'&nbsp;'+producto.SufijoDiv;
					}			

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
				valAux2	= anyadirCerosDecimales(FormatoNumero(reemplazaPuntoPorComa(Round(valAux,decimalesTotal))),decimalesTotal);
					//	11ene21
					if(producto.IDDivisa!='0'){
						valAux2 =  producto.PrefijoDiv+'&nbsp;'+valAux2+'&nbsp;'+producto.SufijoDiv;
					}			

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
				valAux2	= anyadirCerosDecimales(FormatoNumero(reemplazaPuntoPorComa(Round(valAux,decimalesTotal))),decimalesTotal);
					//	11ene21
					if(producto.IDDivisa!='0'){
						valAux2 =  producto.PrefijoDiv+'&nbsp;'+valAux2+'&nbsp;'+producto.SufijoDiv;
					}			

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
			thisCell = cellStartClass.replace('#CLASS#', 'textCenter w1px');
			thisMacro = macroCheckbox.replace('#NAME#', 'SELECCION_' + key);
			thisMacro = thisMacro.replace('#CLASS#', 'SELECCION muypeq');
			thisMacro = thisMacro.replace('#VALUE#', key);
			disabled='';
			
			//solodebug
			//solodebugif (producto.TipoSinStock!='' && producto.TextSinStock)
			//solodebug	debug(producto.Nombre+'. TipoSinStock:'+producto.TipoSinStock+' TextSinStock:'+producto.TextSinStock+' indexOf:'+producto.TextSinStock.indexOf('NO SOLICITAR'));
			
			
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


	//solodebug debug('htmlTBODY:'+htmlTBODY);


	//21dic16jQuery('table.encuesta tbody').empty().append(htmlTBODY);
	jQuery('#lineas tbody').empty().append(htmlTBODY);

	if(jQuery("#strFiltro").val().toLowerCase() != ''){
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

	//solodebug	
	debug('Seleccionar. IDDivisa:'+IDDivisa);
	
	if (!jQuery("input.SELECCION[name='SELECCION_" + posArr + "']").attr('checked'))
	{
		jQuery("input.SELECCION[name='SELECCION_" + posArr + "']").attr('checked', true);
		arrayLineasProductos[ColumnaOrdenadaProds[posArr]].Productos[0].Seleccionado = 'S';

		//solodebug	
		debug('Seleccionar. IDDivisaProducto:'+arrayLineasProductos[ColumnaOrdenadaProds[posArr]].Productos[0].IDDivisa);

		//	11ene21 Actualizamos la divisa
		if (IDDivisa!=arrayLineasProductos[ColumnaOrdenadaProds[posArr]].Productos[0].IDDivisa)
		{
			cambiaADivisaProducto(posArr);
			/*
			IDDivisa = arrayLineasProductos[ColumnaOrdenadaProds[posArr]].Productos[0].IDDivisa;	
			preDivisa = arrayLineasProductos[ColumnaOrdenadaProds[posArr]].Productos[0].PrefijoDiv;	
			sufDivisa = arrayLineasProductos[ColumnaOrdenadaProds[posArr]].Productos[0].SufijoDiv;	
			*/
			
		}

	}
}


//	22ene21 Al desmarcar un producto, revisamos cual es la divisa correcta
function revisaDivisaActiva()
{
	//solodebug	debug('revisaDivisaActiva');

	var pos=-1;
	IDDivisa=0;
	
	for (var i=0;(i<arrayLineasProductos.length)&&(IDDivisa==0);++i)
	{
		//solodebug	debug('revisaDivisaActiva arrayLineasProductos('+i+') IDDivisa:'+arrayLineasProductos[i].Productos[0].IDDivisa+' Seleccionado:'+arrayLineasProductos[i].Productos[0].Seleccionado);
		if ((arrayLineasProductos[i].Productos[0].IDDivisa!=0)&&(arrayLineasProductos[i].Productos[0].Seleccionado=='S')) cambiaADivisaProducto(i);
		else if ((arrayLineasProductos[i].Productos[0].IDDivisa==0)&&(pos==-1)) pos=i;
	}
	
	if (IDDivisa==0)
		cambiaADivisaProducto(pos);

	//solodebug	debug('revisaDivisaActiva IDDivisa:'+IDDivisa);
}


//	22ene21 Mostramos el pedido minimo y el tipo de cambio segun divisa
function mostrarSegunDivisa()
{
	//solodebug	debug('mostrarSegunDivisa IDDivisa:'+IDDivisa+' poslugarEntrega:'+poslugarEntrega+' PedMin:'+arrayLugaresEntrega[poslugarEntrega][9]);

	var form=document.forms['formBot'];
	if (IDDivisa==0)	//	22ene21 Sin pedido minimo para compras en DIVISA
	{
		form.elements['CEN_PEDIDOMINIMO'].value=arrayLugaresEntrega[poslugarEntrega][9];
		jQuery('#spDivisa').hide();
	}
	else
	{
		form.elements['CEN_PEDIDOMINIMO'].value='0';
		
		//	Prepara las divisas para mostrar
		jQuery('#NombreDiv').html(preDivisa+sufDivisa);
		jQuery('#NombreDiv2').html(preDivisaDef+sufDivisaDef);
		
		jQuery('#spDivisa').show();
	}

}

//	22ene21 Separamos el cambio de divisa
function cambiaADivisaProducto(pos)
{
	//debug('cambiaADivisaProducto pos:'+pos);

	IDDivisa = arrayLineasProductos[ColumnaOrdenadaProds[pos]].Productos[0].IDDivisa;	
	preDivisa = arrayLineasProductos[ColumnaOrdenadaProds[pos]].Productos[0].PrefijoDiv;	
	sufDivisa = arrayLineasProductos[ColumnaOrdenadaProds[pos]].Productos[0].SufijoDiv;	
	
	mostrarSegunDivisa();
}


//
// Recalculo el importe cuando cambia la cantidad
//
function Cantidad2Importe(posArr, hayPrecio)
{

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
				totalFormat	= anyadirCerosDecimales(FormatoNumero(reemplazaPuntoPorComa(Round(total,2))),2);
				
				//	11ene21
				if(arrayLineasProductos[ColumnaOrdenadaProds[posArr]].Productos[0].IDDivisa!='0'){
					totalFormat =  arrayLineasProductos[ColumnaOrdenadaProds[posArr]].Productos[0].PrefijoDiv+' '+totalFormat+' '+arrayLineasProductos[ColumnaOrdenadaProds[posArr]].Productos[0].SufijoDiv;
				}			
				
				if(jQuery("input[name='NuevoImporte_" + posArr + "']").length)
					jQuery("input[name='NuevoImporte_" + posArr + "']").val(totalFormat);
			}

			if(importe2!=''){
				total		= parseFloat(cant)*parseFloat(importe2);
				totalFormat	= anyadirCerosDecimales(FormatoNumero(reemplazaPuntoPorComa(Round(total,2))),2);

				if(arrayLineasProductos[ColumnaOrdenadaProds[posArr]].Productos[0].IDDivisa!='0'){
					totalFormat =  preDivisa+' '+totalFormat+' '+sufDivisa;
				}			

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
		document.forms['formBot'].elements['sum'].value=anyadirCerosDecimales(FormatoNumero(Round(suma,2)),2);
		document.forms['sumaTotal'].elements['sumaTotal'].value=preDivisa + ' '+anyadirCerosDecimales(document.forms['formBot'].elements['sum'].value,2) +  ' '+ sufDivisa;
		//suma brasil
		document.forms['formBot'].elements['sumBrasil'].value=preDivisa + anyadirCerosDecimales(FormatoNumero(Round(sumaBrasil,2)),2);
		document.forms['sumaTotal'].elements['sumaTotalBrasil'].value=preDivisa + ' '+ anyadirCerosDecimales(document.forms['formBot'].elements['sumBrasil'].value,2) +  ' '+ sufDivisa;
	}else{
		//2set19 Sin muestras, no debe entrar aquí: document.forms['sumaTotal'].elements['sumaTotal'].value= preDivisa + document.forms['form_iddivisa'].elements['SOL_MUESTRAS'].value + sufDivisa;
	}
}

function clickCheckbox(obj){
	var posArr	= obj.name.replace('SELECCION_', '');
	var isChecked	= jQuery(obj).is(':checked');
	var thisProd	= arrayLineasProductos[ColumnaOrdenadaProds[posArr]].Productos[0];

	// Editamos el valor del campo 'Seleccionado' en el objeto
	if(isChecked)
	{
		thisProd.Seleccionado = 'S';
		cambiaADivisaProducto(posArr);
	}
	else
	{
		thisProd.Seleccionado = 'N';
		revisaDivisaActiva();
	}

	sumar_pedidoDirecto();
}


function mostrarSeleccionados(obj){

	//debug('mostrarSeleccionados');

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
			alert(str_LimiteComprasSuperado.replace('[[TOTALPEDIDO]]', document.forms['sumaTotal'].elements['sumaTotal'].value).replace('[[TOTALANTERIOR]]', anyadirCerosDecimales(FormatoNumero(comprasPrevias))).replace('[[LIMITE]]', limiteComprasMensual));
			return;
		}
	}

	var errorPedido	= pedidoMinimo(pedMinimo, parseFloat(document.forms['sumaTotal'].elements['sumaTotal'].value.replace(/\./g,'').replace(",",".")));

	//solodebug	debug('enviarPedido. pedMinimoTipo:'+pedMinimoTipo+' pedidoMinimo:'+pedMinimo+' sumaTotal:'+parseFloat(document.forms['sumaTotal'].elements['sumaTotal'].value.replace(/\./g,'').replace(",","."))+'. errorPedido:'+errorPedido);

	if((errorPedido != '') && (errorPedido != 0) && ((pedMinimoTipo == 'E')||(pedMinimoTipo == 'S')))	//	Solo validamos en caso de pedido mínimo estricto
	{
		//solodebug		debug('enviarPedido. pedidoMinimo. errorPedido:'+errorPedido);
		
		if (saltarPedMinimo=='N')
		{
			
			//solodebug			debug('enviarPedido. errorPedido:'+errorPedido+'. alert!');
			
			//2set19	alert(errorPedido+ document.forms['form_iddivisa'].elements['POR_FAVOR_REVISE'].value);
			alert(errorPedido+ strPorFavorRevise);
			errorPedido='errr';
		}
		else
		{
			
			//solodebug		debug('enviarPedido. errorPedido:'+errorPedido+'. confirm!');
			
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
		//solodebug		debug('enviarPedido. errorPedido:'+errorPedido+'. show!');
		
		jQuery('#divContinuar').show();
	}
	else
	{
		//solodebug			debug('enviarPedido. errorPedido:'+errorPedido+'. Actua!');
		
		Actua();
	}
}//fin de control pedido minimo


// Comprobacion pedido minimo
function pedidoMinimo(pedMinimo, total){
	var msg = '';

	//solodebug	debug('pedidoMinimo('+pedMinimo+', '+total+')');

	if(total < pedMinimo){
		//2set19	msg += document.forms['form_iddivisa'].elements['PEDIDO_NO_LLEGA'].value +' '+ preDivisa + pedMinimo + sufDivisa +'.\n';
		msg += strPedidoNoLLega +' '+ preDivisa + pedMinimo + sufDivisa +'.\n';
	}

	//solodebug	debug('pedidoMinimo('+pedMinimo+', '+total+'):'+msg);
	return msg;
}//fin pedidoMinimo


//  Validaciones y envio del formulario
function Actua(){

	var	Especial='',LineaEspecial, ConvenioODeposito='', LineaConvDep, IDControlDivisa='';	//	24ene18	Control no juntar productos regulados y no regulados. 11ene21 Una unica divisa

	//anadido 11-05-12 mi si no lugar entrega se quedaba en el por defecto, ahora lo cogemos del select
	var centro = document.forms['formBot'].elements['IDCENTRO'].value;
	
	if (centro==-1)
	{
		alert(str_CentroNoSeleccionado);
		return;
	}
	
	document.forms['formBot'].elements['IDLUGARENTREGA'].value = document.forms['formBot'].elements['IDLUGARENTREGA_'+centro].value;

	
	//	17set21	Control del tipo de cambio en caso de divisa!=0, traido desde el control de pedido minimo
	//debug('enviarPedido: IDDivisa:'+IDDivisa);
			
	if (IDDivisa!=0)
	{
		var tipoCambioTxt=jQuery('#tipoCambioDiv').val();

		//debug('enviarPedido: tipoCambioTxt:'+tipoCambioTxt);

		if ((tipoCambioTxt!='')||(!isNaN(tipoCambioTxt)))
		{
			//debug('enviarPedido: tipoCambioTxt:'+tipoCambioTxt+' numerico.');
	
			var tipoCambio=parseFloat(tipoCambioTxt.replace(/\./g,'').replace(",","."));
			if (isNaN(tipoCambio))
			{
				alert(str_TipoDeCambioObligatorio);
				return;
			}
			else if (tipoCambio==1)
			{
				if (!confirm(str_TipoDeCambio1))
					return;
			}

			//debug('enviarPedido: tipoCambioTxt:'+tipoCambioTxt+' numerico. tipoCambio:'+tipoCambio);

			jQuery('#TIPOCAMBIODIVISA').val(tipoCambioTxt);	//	en formato texto
		}
		else
		{
			alert(str_TipoDeCambioObligatorio);
			return;
		}
		
	}


	var accio = 'LPAnalizarSave2022.xsql';
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
			
			//LineaEspecial=(linea.Productos[0].Pack=='S')?'Pack':((linea.Productos[0].Regulado=='S')?'Regulado':(linea.Productos[0].Convenio=='S')?'Convenio':(linea.Productos[0].Deposito=='S')?'Deposito':'Normal');
			LineaEspecial=(linea.Productos[0].Pack=='S')?'Pack':((linea.Productos[0].Regulado=='S')?'Regulado':'Normal');

			//solodebug	
			debug('Pedido Especial:'+Especial+' Regulado:'+linea.Productos[0].Regulado+' Pack:'+linea.Productos[0].Pack+' LineaEspecial:'+LineaEspecial+' error:'+mensajeError);
			
			if (Especial=='') Especial=LineaEspecial;
			else if ((Especial!=LineaEspecial)&&(Especial!='ERROR'))
			{
				
				if ((Especial=='Regulado')||(LineaEspecial=='Regulado'))
					mensajeError += str_NoMezclarReguladoYNoRegulado;
				else if ((Especial=='Pack')||(LineaEspecial=='Pack'))
					mensajeError += str_NoMezclarPackYNoPack;
				
				Especial='ERROR';
			};

			LineaConvDep=(linea.Productos[0].Convenio=='S')?'Convenio':((linea.Productos[0].Deposito=='S')?'Deposito':'Normal');
			//solodebug	
			debug('Pedido ConvenioODeposito:'+ConvenioODeposito+' Regulado:'+linea.Productos[0].Convenio+' Deposito:'+linea.Productos[0].Deposito+' LineaConvDep:'+LineaConvDep+' error:'+mensajeError);

			if (ConvenioODeposito=='') ConvenioODeposito=LineaConvDep;
			else if ((ConvenioODeposito!=LineaConvDep)&&(Especial!='ERROR'))
			{
				
				if ((ConvenioODeposito=='Convenio')||(LineaConvDep=='Convenio'))
					mensajeError += str_NoMezclarConvenioYNoConvenio;
				else if ((ConvenioODeposito=='Deposito')||(LineaConvDep=='Deposito'))
					mensajeError += str_NoMezclarDepositoYNoDeposito;
				
				Especial='ERROR';
			};
			
			//	11ene21 Control: una unica divisa por pedido
			if (IDControlDivisa=='') IDControlDivisa=linea.Productos[0].IDDivisa;
			else if ((IDControlDivisa!=linea.Productos[0].IDDivisa)&&(IDControlDivisa!='ERROR'))
			{
				mensajeError += str_NoMezclarDivisas
				IDControlDivisa='ERROR';
			}
			
			//solodebug	debug('Actua DivProducto:'+linea.Productos[0].IDDivisa+' IDControlDivisa:'+IDControlDivisa);			
			//debug('Actua .IDDivisa:'+IDDivisa);
			jQuery("#IDDIVISA").val(IDDivisa);			//	13ene21

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
	
	//solodebug	debug('Actua:['+selectCantidades+']');

	//Cadena con todas las cantidades de los productos seleccionados
	document.forms['formBot'].elements['STRING_CANTIDADES'].value	= selectCantidades;
	
	//La siguiente cadena no se utiliza, no la informamos para reducir HEADER del envío POST
	//document.forms['formBot'].elements['SELECCIONTOTAL'].value	= select;

	if(select==""){
		alert(InformaSeleccionaAlgun);
		jQuery('#divContinuar').show();
	}else{
		if(testFechas(document.forms['formBot'])){
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
				suma	= anyadirCerosDecimales(FormatoNumero(Round(desformateaDivisa(suma),2)),2);

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
	var arrStr	= jQuery("#strFiltro").val().toLowerCase().split();			//filtroTXT.split(" ");

	debug('highlightString:'+arrStr);

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
	
	//solodebug	debug('ordenarProductos:'+orden);

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
				
				//solodebug	debug('ordenamientoAlfabet arrValores[left]:'+arrValores[left]+' > arrValores[right]:'+arrValores[right]);
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
//	19ago21 Sumar las cantidades a las seleccionadas anteriormente: revisar unidaddes por lote al acabar el proceso
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
		
		//solodebug debug("IncluirProductosPorReferencia. Procesando registro "+i+". RefCliente:"+Ref+" Cant:"+Cant);
		
		if (Ref!='')
		{
			//solodebug	Control=Control+'['+i+'/'+numRefs+'] Referencia:'+Ref+ '. Cantidad:'+Cant;

			//	Recorre el array de productos buscando la referencia
			var Encont=false;
			for (j=0;((j<arrayLineasProductos.length) && (!Encont));++j)
			{
				
				//solodebug debug("IncluirProductosPorReferencia. Procesando registro "+i+". RefCliente:"+Ref+" Cant:"+Cant
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
						/*
						//	5jun20 Control de las unidades por lote antes de actualizar
						var uds		= parseFloat(desformateaDivisa(Cant));
						var udsXLote	= parseInt(arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].UdsXLote_SinFormato);
						
						//solodebug	debug("IncluirProductosPorReferencia RefCliente:"+Ref+' Unidades:'+uds+' empaquetamiento:'+udsXLote);
						
						if(uds%udsXLote!=0)
						{
							var lotes=(Math.abs(uds)-(Math.abs(uds)%udsXLote))/udsXLote+1;
							Cant=udsXLote*lotes;
							alert(uds+ strRedondeoUnidades +'\n'+ strRedondeoUnidades2 +Math.abs(lotes)+ strCajas + '. ('+Math.abs(Cant)+ strUnidades + ')');
						
							//solodebug	debug("IncluirProductosPorReferencia RefCliente:"+Ref+' Unidades:'+uds+' empaquetamiento:'+udsXLote);
							
						}
						*/
						
						//	19ago21 Si el producto ya estaba seleccionado, 
						if (arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].Seleccionado == 'S')
						{
							arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].Cantidad_SinFormato =  parseFloat(desformateaDivisa(arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].Cantidad_SinFormato))+ parseFloat(desformateaDivisa(Cant));
							arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].Cantidad = parseFloat(desformateaDivisa(arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].Cantidad_SinFormato));
							debug("IncluirProductosPorReferencia Encontrado y modificado: RefCliente:"+Ref+'. NuevaCant:'+Cant+' CantSinFOrmato:'+arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].Cantidad_SinFormato+" Cantidad:" + arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].Cantidad);
						}
						else
						{
							arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].Cantidad_SinFormato = Cant;
							arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].Cantidad = parseFloat(desformateaDivisa(Cant));							
						}
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
						debug("IncluirProductosPorReferencia Encontrado y modificado: RefCliente:"+Ref+"="+arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].RefCliente+ 'Cant:'+Cant+" Camposeleccion:SELECCION_" + ColumnaOrdenadaProds[j]);
					}
					
					//solodebug ET 27may17 debug("IncluirProductosPorReferencia RefCliente:"+Ref+"="+arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].RefCliente+ 'Cant:'+Cant+" Camposleccion:SELECCION_" + ColumnaOrdenadaProds[j]);

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

	//	19ago21 COntrol del empaquetamiento
	for (j=0;(j<arrayLineasProductos.length);++j)
	{
		var uds		= parseFloat(desformateaDivisa(arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].Cantidad_SinFormato));
		var udsXLote= parseInt(arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].UdsXLote_SinFormato);

		//solodebug	
		debug("IncluirProductosPorReferencia RefCliente:"+Ref+' Unidades:'+uds+' empaquetamiento:'+udsXLote);

		if(uds%udsXLote!=0)
		{
			var lotes=(Math.abs(uds)-(Math.abs(uds)%udsXLote))/udsXLote+1;
			Cant=udsXLote*lotes;
			alert(uds+ strRedondeoUnidades +'\n'+ strRedondeoUnidades2 +Math.abs(lotes)+ strCajas + '. ('+Math.abs(Cant)+ strUnidades + ')');

			//solodebug	
			debug("IncluirProductosPorReferencia RefCliente:"+Ref+' Unidades:'+uds+' empaquetamiento:'+udsXLote);		
			
			arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].Cantidad_SinFormato = Cant;
			arrayLineasProductos[ColumnaOrdenadaProds[j]].Productos[0].Cantidad = parseFloat(desformateaDivisa(Cant));

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
	revisaDivisaActiva();	//	5oct21 Revisa la divisa activa
		
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


//	15mar22 Aplica el filtro de categorias
function aplicarFiltroCompleto()
{
	var filtroTXT	= jQuery("#strFiltro").val().toLowerCase();
	var IDCategoria	= jQuery("#IDFILTROCATEGORIA").val();
	var	IDTipoNeg	= jQuery('#IDTIPONEGOCIACION').val();

	//solodebug	debug('jQuery("#strFiltro") filtro:'+filtroTXT);

	aplicarFiltro(filtroTXT, IDCategoria, IDTipoNeg);
}







var sepCSV			=';';		//	20ene21
var sepTextoCSV		='';		//	20ene21
var saltoLineaCSV	='\r\n';	//	20ene21

//	3may21 Exporta la seleccion del usuario a CSV
function ExportarExcel()
{
	var oForm=document.forms['frmDocumentos'], cadenaCSV='';

	debug("DescargarExcel");

	jQuery.each(arrayLineasProductos, function(key, linea){
		if(linea.Productos[0].Seleccionado == 'S'){
			var Cant= linea.Productos[0].Cantidad_SinFormato;
			var Ref	= (linea.Productos[0].RefCliente!='')?linea.Productos[0].RefCliente:linea.Productos[0].RefPrivada;

			cadenaCSV+=Ref+sepCSV+Cant+saltoLineaCSV;
		}
	});
	
	var Fecha=new Date;
	DescargaMIME(StringToISO(cadenaCSV), 'Pedido_'+Fecha.getDay()+(Fecha.getMonth()+1)+Fecha.getYear()+'.csv', 'text/csv');
}


