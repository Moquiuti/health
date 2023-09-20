//	Funciones JS para la nueva version de la licitacion. BLOQUE PROVEEDORES.
//	Ultima revisión ET 8jul22 12:20 LicV2Provs_2022_300622.js


//	tabla proveedores
var		totalProvs,			// numero total de proveedores en la licitacion
		ColumnaOrdenacionProvs='',			//	12nov19	Por defecto ordenamos por nombre corto del proveedor, antes nombrenorm
		OrdenProvs		= '',
		ColumnaOrdenadaProvs	= [];



/*

	P R O V E E D O R E S

*/
//	Prepara la tabla de ordenacion de proveedores
function prepararOrdProveedores(){
	totalProvs	= arrProveedores.length;

	for(var i=0; i<totalProvs; i++){
		ColumnaOrdenadaProvs[i] = i;
	}

	//12nov19 Es desde dibujaTablaProveedores que llamaremos a prepararTablaProveedores
	//12nov19	dibujaTablaProveedores();
}


function dibujaTablaProveedores()
{

	//solodebug debug('dibujaTablaProveedores ColumnaOrdenacionProvs:'+ColumnaOrdenacionProvs);

	//	12nov19 Si no se ha inicializado la tabla, en este punto lo hacemos
	if (ColumnaOrdenacionProvs=='')
	{
		totalProvs	= arrProveedores.length;
		prepararOrdProveedores();
		OrdenarProvsPorColumna('NombreCorto');
	}

	if(EstadoLic == 'EST' || EstadoLic == 'COMP' || EstadoLic == 'CURS' || EstadoLic == 'INF')
	{
		dibujaTablaProveedoresEST();
	}
	else
	{
		dibujaTablaProveedoresADJ();
	}
}

function dibujaTablaProveedoresADJ(){
	var htmlTBODY = '', thisRow = '', thisCell = '' , thisMacro = '', valAux, contLinea = 0;

	//solodebug debug('dibujaTablaProveedoresADJ ColumnaOrdenacionProvs:'+ColumnaOrdenacionProvs);

	// Eliminamos la fila totalConsumo por si existe
	jQuery('#lProveedores_ADJ tfoot').remove();

	if(totalProvs > 0){
		for(var i=0; i<totalProvs; i++)
		{
			if ((arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv=='INF')||(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv=='ADJ')||(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv=='FIRM')||(arrProveedores[ColumnaOrdenadaProvs[i]].NumeroLineas>0)||(SoloProvInformados=='N'))
			{
			
				//solodebug	debug('SoloProvInformados:'+SoloProvInformados+' IDEstadoProv:'+arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv);
			
				contLinea++;

				// Iniciamos la fila (tr)
				thisRow = rowStartIDStyle;
				thisRow = thisRow.replace('#ID#', arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic);
				if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv == 'SUS'){
					thisRow = thisRow.replace('#STYLE#', 'background:#fd6c85;border-bottom:1px solid #999;');
				}else if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv == 'ADJ' || arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv == 'FIRM'){
					thisRow = thisRow.replace('#STYLE#', 'background:#A8FFA8;border-bottom:1px solid #999;');
				}else{
					thisRow = thisRow.replace('#STYLE#', 'border-bottom:1px solid #999;');
				}

				// Celda/Columna numeracion
				thisCell = cellStart + '&nbsp;' + contLinea + '&nbsp;' + cellEnd;
				thisRow += thisCell;

				// Celda/Columna aviso ofertas vacias y subir contrato
				thisCell = cellStart;
				if(arrProveedores[ColumnaOrdenadaProvs[i]].OfertasVacias == 'S'){
					thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/change.png');
					thisMacro = thisMacro.replace('#TITLE#', str_provOfertasVacias);
					thisMacro = thisMacro.replace('#ALT#', str_provOfertasVacias);
					thisCell += thisMacro;
     			}
				if(arrProveedores[ColumnaOrdenadaProvs[i]].OfertasAdj > 0){
					thisCell += '&nbsp;' + spanStartID.replace('#ID#', 'contrato_' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic);
					if(arrProveedores[ColumnaOrdenadaProvs[i]].Contrato.ID){
						thisCell += spanStartID.replace('#ID#', 'docContrato_' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic);
						thisCell += macroEnlaceTarget.replace('#HREF#', 'http://www.newco.dev.br/Documentos/' + arrProveedores[ColumnaOrdenadaProvs[i]].Contrato.Url);
						thisCell += macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/contratoIcon.gif').replace('#TITLE#', str_Contrato).replace('#ALT#', str_Contrato);
						thisCell += macroEnlaceEnd + '&nbsp;';
						thisCell += spanEnd;
					}
					if(esAutor == 'S'){
						functionJS = 'javascript:abrirFormContrato(' + (arrProveedores[ColumnaOrdenadaProvs[i]].linea - 1) + ');'
						thisCell += spanStartID.replace('#ID#', 'subirContrato_' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic);
						thisCell += macroEnlace.replace('#HREF#', functionJS);
						thisCell += macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/anadirContratoIcon.gif').replace('#TITLE#', str_SubirContrato).replace('#ALT#', str_SubirContrato);
						thisCell += macroEnlaceEnd + '&nbsp;';
						thisCell += spanEnd;
					}
					thisCell += spanEnd;
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Nombre
				thisCell = cellStartClass.replace('#CLASS#', 'textLeft');
				thisCell += '&nbsp;' + macroEnlace.replace('#HREF#', "javascript:FichaEmpresa(" + arrProveedores[ColumnaOrdenadaProvs[i]].IDProveedor + ",'DOCUMENTOS');");
				thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].NombreCorto;
				thisCell += macroEnlaceEnd;

				//	30ago16 Si hay comentarios, los incluimos aqui
				if((arrProveedores[ColumnaOrdenadaProvs[i]].CommsCdC != '')||(arrProveedores[ColumnaOrdenadaProvs[i]].CommsProv != '')){
					//ET 14dic16	Cambio de estilos para los tooltips
					//ET 14dic16	thisMacro = '&nbsp;' + macroEnlaceAcc.replace('#HREF#', '#');
					thisMacro = '&nbsp;' + divStartClassStyle;	//10dic18	divStartClass;
					thisMacro = thisMacro.replace('#CLASS#', 'tooltip').replace('#STYLE#', 'display: inline-block;');
					thisCell += thisMacro;
					thisCell += '<img src="http://www.newco.dev.br/images/info.gif" class="static"/>';
					//ET 14dic16	thisCell += spanStartClass.replace('#CLASS#', 'classic spanEIS');
					thisCell += spanStartClass.replace('#CLASS#', 'tooltiptext');

					if (arrProveedores[ColumnaOrdenadaProvs[i]].CommsCdC != ''){
						thisCell += 'Com.Cli:'+arrProveedores[ColumnaOrdenadaProvs[i]].CommsCdC;
					}

					if (arrProveedores[ColumnaOrdenadaProvs[i]].CommsProv != ''){
						thisCell += 'Com.:'+arrProveedores[ColumnaOrdenadaProvs[i]].CommsProv;
					}

					thisCell += spanEnd;
					thisCell += macroEnlaceEnd;
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Usuario
				thisCell = cellStartClass.replace('#CLASS#', 'textLeft');
				thisCell += spanStartID.replace('#ID#', 'mailBox_' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic);
				// Macro Enlace
				thisMacro = macroEnlace2.replace('#HREF#', 'javascript:EnviarMailUsuarioLici(\'' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + '\',\'' + arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv + '\');');
				thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
				thisCell += thisMacro;
				// Macro Imagen
				thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/mail.gif');
				thisMacro = thisMacro.replace('#TITLE#', str_enviarCorreo);
				thisMacro = thisMacro.replace('#ALT#', str_enviarCorreo);
				thisCell += thisMacro;
				thisCell += macroEnlaceEnd;
				thisCell += spanEnd;
				thisCell += '&nbsp;' + arrProveedores[ColumnaOrdenadaProvs[i]].NombreUsuario;
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Conversacion con proveedor
				thisCell = cellStart;
				if(EstadoLic != 'CONT'){
					if(esAutor == 'S'){
	//					thisMacro = macroEnlace2.replace('#HREF#', 'javascript:conversacionProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProveedor + ', ' + IDUsuario + ', ' + arrProveedores[ColumnaOrdenadaProvs[i]].IDUsuarioProv + ', \'' + arrProveedores[ColumnaOrdenadaProvs[i]].Nombre + '\');');
						thisMacro = macroEnlace2.replace('#HREF#', 'javascript:conversacionProveedor2(' + (arrProveedores[ColumnaOrdenadaProvs[i]].linea - 1) + ');');
						thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
						thisCell += thisMacro;
						if(arrProveedores[ColumnaOrdenadaProvs[i]].HayConversa == 'S'){
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/mail-blue.png');
							thisMacro = thisMacro.replace('#TITLE#', arrProveedores[ColumnaOrdenadaProvs[i]].UltMensaje);
							thisMacro = thisMacro.replace('#ALT#', arrProveedores[ColumnaOrdenadaProvs[i]].UltMensaje);
						}else{
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/message.png');
							thisMacro = thisMacro.replace('#TITLE#', str_iniciarConversacion);
							thisMacro = thisMacro.replace('#ALT#', str_iniciarConversacion);
						}
						thisCell += thisMacro;
						thisCell += macroEnlaceEnd;
					}else if(isAdmin == 'S' && arrProveedores[ColumnaOrdenadaProvs[i]].HayConversa == 'S'){
	//					thisMacro = macroEnlace2.replace('#HREF#', 'javascript:conversacionProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProveedor + ', ' + IDUsuario + ', ' + arrProveedores[ColumnaOrdenadaProvs[i]].IDUsuarioProv + ', \'' + arrProveedores[ColumnaOrdenadaProvs[i]].Nombre + '\');');
						thisMacro = macroEnlace2.replace('#HREF#', 'javascript:conversacionProveedor2(' + (arrProveedores[ColumnaOrdenadaProvs[i]].linea - 1) + ');');
						thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
						thisCell += thisMacro;
						thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/mail-blue.png');
						thisMacro = thisMacro.replace('#TITLE#', arrProveedores[ColumnaOrdenadaProvs[i]].UltMensaje);
						thisMacro = thisMacro.replace('#ALT#', arrProveedores[ColumnaOrdenadaProvs[i]].UltMensaje);
						thisCell += thisMacro;
						thisCell += macroEnlaceEnd;
					}
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Fecha Oferta
				thisCell = cellStart + arrProveedores[ColumnaOrdenadaProvs[i]].FechaOferta + cellEnd;
				thisRow += thisCell;

				// Celda/Columna Evaluacion
				thisCell = cellStart;
				if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoEval == 'NOAPTO'){
					thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/bolaRoja.gif');
					thisMacro = thisMacro.replace('#TITLE#', str_provNoApto);
					thisMacro = thisMacro.replace('#ALT#', str_provNoApto);
				}else if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoEval == 'PEND'){
					thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/bolaAmbar.gif');
					thisMacro = thisMacro.replace('#TITLE#', str_provPendiente);
					thisMacro = thisMacro.replace('#ALT#', str_provPendiente);
				}else{
					thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/bolaVerde.gif');
					thisMacro = thisMacro.replace('#TITLE#', str_provApto);
					thisMacro = thisMacro.replace('#ALT#', str_provApto);
				}
				thisCell += thisMacro;
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Estado Ofertas
				thisCell = cellStart + arrProveedores[ColumnaOrdenadaProvs[i]].EstadoProv + cellEnd;
				thisRow += thisCell;

				// Celda/Columna Consumo
				thisCell = cellStartClass.replace('#CLASS#', 'textRight');
				if(mostrarPrecioIVA == 'S'){
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].ConsumoProvIVA + '&nbsp;';
				}else{
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].ConsumoProv + '&nbsp;';
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Adjudicado
				thisCell = cellStartClass.replace('#CLASS#', 'textRight');
				if(mostrarPrecioIVA == 'S'){
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].ConsumoAdjIVA + '&nbsp;';
				}else{
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].ConsumoAdj + '&nbsp;';
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Ahorro
				thisCell = cellStartClass.replace('#CLASS#', 'textRight');
				if(mostrarPrecioIVA == 'S'){
					valAux = arrProveedores[ColumnaOrdenadaProvs[i]].AhorroIVA.replace(',', '.');
					if(arrProveedores[ColumnaOrdenadaProvs[i]].ConsumoProvIVA != ''){
						if(valAux == 0){
							thisCell += spanStartStyle.replace('#STYLE#', 'color:orange;font-weight:bold;');
						}else if(valAux < 0){
							thisCell += spanStartStyle.replace('#STYLE#', 'color:red;font-weight:bold;');
						}else if(valAux > 0){
							thisCell += spanStartStyle.replace('#STYLE#', 'color:green;font-weight:bold;');
						}
						thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].AhorroIVA + '%';
						thisCell += spanEnd + '&nbsp;';
					}
				}else{
					valAux = arrProveedores[ColumnaOrdenadaProvs[i]].Ahorro.replace(',', '.');
					if(arrProveedores[ColumnaOrdenadaProvs[i]].ConsumoProv != ''){
						if(valAux == 0){
							thisCell += spanStartStyle.replace('#STYLE#', 'color:orange;font-weight:bold;');
						}else if(valAux < 0){
							thisCell += spanStartStyle.replace('#STYLE#', 'color:red;font-weight:bold;');
						}else if(valAux > 0){
							thisCell += spanStartStyle.replace('#STYLE#', 'color:green;font-weight:bold;');
						}
						thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].Ahorro + '%';
						thisCell += spanEnd + '&nbsp;';
					}
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Pedido Minimo
				thisCell = cellStart;
				thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].PedidoMin;
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Num. Productos
				thisCell = cellStart;
				if (arrProveedores[ColumnaOrdenadaProvs[i]].NumeroLineas!=''){	//	31ago16 Solo si está informado
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].OfertasAdj + '/' + arrProveedores[ColumnaOrdenadaProvs[i]].NumeroLineas;
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Acciones
				thisCell = cellStart;
				
				/* Botones para imprimir oferta y descargar excel (para todos los usuarios)		DESACTIVADO 29jun22
				if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv != 'CURS' && arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv != 'SUS'){
					thisMacro = macroEnlace3.replace('#CLASS#', 'accImprimir');
					thisMacro = thisMacro.replace('#HREF#', 'javascript:imprimirOferta(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ');');
					thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
					thisCell += thisMacro;
					thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/print.png');//5abr18	'http://www.newco.dev.br/images/imprimir.gif'
					thisMacro = thisMacro.replace('#ALT#', str_ImprimirOferta);
					thisMacro = thisMacro.replace('#TITLE#', str_ImprimirOferta);
					thisCell += thisMacro;
					thisCell += macroEnlaceEnd + '&nbsp;';

					thisMacro = macroEnlace3.replace('#CLASS#', 'accExcel');
					thisMacro = thisMacro.replace('#HREF#', 'javascript:listadoExcel(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ');');
					thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
					thisCell += thisMacro;
					thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/excel.png');//5abr18	'http://www.newco.dev.br/images/iconoExcel.gif'
					thisMacro = thisMacro.replace('#ALT#', str_ListadoExcel);
					thisMacro = thisMacro.replace('#TITLE#', str_ListadoExcel);
					thisCell += thisMacro;
					thisCell += macroEnlaceEnd + '&nbsp;';
				}*/
				thisCell += cellEnd;
				thisRow += thisCell;

				thisRow += rowEnd;
				htmlTBODY += thisRow;
			}
		}

		if(EstadoLic == 'ADJ' || EstadoLic == 'FIRM' || EstadoLic == 'CONT'){
			dibujarFilaConsumoProvADJ();
		}
	}else{
		htmlTBODY = "<tr><td colspan=\"16\" align=\"center\"><strong>" + str_licSinProveedores + "</strong></td></tr>";
	}

	jQuery('#lProveedores_ADJ tbody').empty().append(htmlTBODY);
}

function dibujaTablaProveedoresEST(){
	var htmlTBODY = '', thisRow = '', thisCell = '' , thisMacro = '', valAux, contLinea = 0;

	//solodebug debug('dibujaTablaProveedoresADJ ColumnaOrdenacionProvs:'+ColumnaOrdenacionProvs);

	// Eliminamos la fila totalConsumo por si existe
	jQuery('#lProveedores_EST tfoot').remove();

	if(totalProvs > 0){
		for(var i=0; i<totalProvs; i++)
		{
			if ((arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv=='INF')||(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv=='ADJ')||(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv=='FIRM')||(arrProveedores[ColumnaOrdenadaProvs[i]].NumeroLineas>0)||(SoloProvInformados=='N'))
			{
			
				//solodebug	debug('SoloProvInformados:'+SoloProvInformados+' IDEstadoProv:'+arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv);
			
		
				contLinea++;

				//solodebug	27set17	debug(arrProveedores[ColumnaOrdenadaProvs[i]].IDProveedor+':'+arrProveedores[ColumnaOrdenadaProvs[i]].NombreCorto+':'+arrProveedores[ColumnaOrdenadaProvs[i]].NivelDocumentacion);


				// Iniciamos la fila (tr)
				thisRow = rowStartClass;
				if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv == 'SUS'){
					thisRow = thisRow.replace('#CLASS#', 'fondoRojo conhover');
				}else{
					thisRow = thisRow.replace('#CLASS#', 'conhover');
				}

				// Celda/Columna numeracion
				//29ago16	Si estamos en Brasil mostramos un fondo de color en función del nivel de documentación del proveedor
				if ((IDPais==55)&&(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv != 'SUS')){
					if (arrProveedores[ColumnaOrdenadaProvs[i]].NivelDocumentacion=='R'){
						thisCell = cellStartClass.replace('#CLASS#','fondoRojo')
									 + '&nbsp;' + contLinea + '&nbsp;' + cellEnd;
					}
					else if (arrProveedores[ColumnaOrdenadaProvs[i]].NivelDocumentacion=='A'){
						thisCell = cellStartClass.replace('#CLASS#','fondoNaranja')
									 + '&nbsp;' + contLinea + '&nbsp;' + cellEnd;
					}
					else if (arrProveedores[ColumnaOrdenadaProvs[i]].NivelDocumentacion=='V'){
						thisCell = cellStartClass.replace('#CLASS#','fondoVerde')
									 + '&nbsp;' + contLinea + '&nbsp;' + cellEnd;
					}
					else{
						thisCell = cellStartClass.replace('#CLASS#','color_status')
									 + '&nbsp;' + contLinea + '&nbsp;' + cellEnd;
					}
				}
				else
				{
					thisCell = cellStart + '&nbsp;' + contLinea + '&nbsp;' + cellEnd;
				}
				thisRow += thisCell;

				// Celda/Columna aviso ofertas vacias
				thisCell = cellStart;
				if(arrProveedores[ColumnaOrdenadaProvs[i]].OfertasVacias == 'S'){
					thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/change.png');
					thisMacro = thisMacro.replace('#TITLE#', str_provOfertasVacias);
					thisMacro = thisMacro.replace('#ALT#', str_provOfertasVacias);
					thisCell += thisMacro;
                        	}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Nombre
				thisCell = cellStartClass.replace('#CLASS#', 'textLeft');
				thisCell += '&nbsp;<img src="http://www.newco.dev.br/images/StarSmall'+arrProveedores[ColumnaOrdenadaProvs[i]].Estrellas+'.png" height="18px" width="18px" class="static"/>&nbsp;'+macroEnlace.replace("#HREF#", "javascript:FichaEmpresa(" + arrProveedores[ColumnaOrdenadaProvs[i]].IDProveedor + ",'DOCUMENTOS');");
				thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].NombreCorto;
				thisCell += macroEnlaceEnd;
				if (arrProveedores[ColumnaOrdenadaProvs[i]].IDDocumento!='')
				{
					thisCell += '&nbsp;<a href="javascript:VerDocumento('+arrProveedores[ColumnaOrdenadaProvs[i]].IDDocumento+');"><img src="http://www.newco.dev.br/images/2020/Documento.png" class="static"/></a>&nbsp;';
				}

				//	30ago16 Si hay comentarios, los incluimos aqui
				if((arrProveedores[ColumnaOrdenadaProvs[i]].CommsCdC != '')||(arrProveedores[ColumnaOrdenadaProvs[i]].CommsProv != '')){
					//ET 14dic16	Cambio de estilos para los tooltips
					//ET 14dic16	thisMacro = '&nbsp;' + macroEnlaceAcc.replace('#HREF#', '#');
					thisMacro = '&nbsp;' + divStartClassStyle;	//10dic18	divStartClass;
					thisMacro = thisMacro.replace('#CLASS#', 'tooltip').replace('#STYLE#', 'display: inline-block;');
					thisCell += thisMacro;
					thisCell += '<img src="http://www.newco.dev.br/images/info.gif" class="static"/>';
					//ET 14dic16	thisCell += spanStartClass.replace('#CLASS#', 'classic spanEIS');
					thisCell += spanStartClass.replace('#CLASS#', 'tooltiptext');

					if (arrProveedores[ColumnaOrdenadaProvs[i]].CommsCdC != ''){
						thisCell += 'Com.Cli:'+arrProveedores[ColumnaOrdenadaProvs[i]].CommsCdC;
					}

					if (arrProveedores[ColumnaOrdenadaProvs[i]].CommsProv != ''){
						thisCell += 'Com.:'+arrProveedores[ColumnaOrdenadaProvs[i]].CommsProv;
					}

					thisCell += spanEnd;
					thisCell += macroEnlaceEnd;
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Usuario
				thisCell = cellStartClass.replace('#CLASS#', 'textLeft');
				thisCell += spanStartID.replace('#ID#', 'mailBox_' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic);
				// Macro Enlace
				thisMacro = macroEnlace2.replace('#HREF#', 'javascript:EnviarMailUsuarioLici(\'' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + '\',\'' + arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv + '\');');
				thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
				thisCell += thisMacro;
				// Macro Imagen
				thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/mail.gif');
				thisMacro = thisMacro.replace('#TITLE#', str_enviarCorreo);
				thisMacro = thisMacro.replace('#ALT#', str_enviarCorreo);
				thisCell += thisMacro;
				thisCell += macroEnlaceEnd;
				thisCell += spanEnd;
				thisCell += '&nbsp;' + '<span class="fuentePeq">'+arrProveedores[ColumnaOrdenadaProvs[i]].NombreUsuario+'</span>';

				if(esAutor == 'S' /*&& EstadoLic != 'EST'*/){
					thisCell += '&nbsp;' + spanStartID.replace('#ID#', 'nuevoUsu_' + (arrProveedores[ColumnaOrdenadaProvs[i]].linea - 1));
					// Macro Enlace
					thisMacro = macroEnlace2.replace('#HREF#', 'javascript:abrirBoxNuevoUsuario(' + (arrProveedores[ColumnaOrdenadaProvs[i]].linea - 1) + ');');
					thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
					thisCell += thisMacro;
					// Macro Imagen
					thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/boliIcon.gif');
					thisMacro = thisMacro.replace('#TITLE#', str_cambiarUsuario);
					thisMacro = thisMacro.replace('#ALT#', str_cambiarUsuario);
					thisCell += thisMacro;
					thisCell += macroEnlaceEnd;
					thisCell += spanEnd;
				}

				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Conversacion con proveedor
				thisCell = cellStart;
				if(EstadoLic != 'EST'){
					if(esAutor == 'S'){
	//					thisMacro = macroEnlace2.replace('#HREF#', 'javascript:conversacionProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProveedor + ', ' + IDUsuario + ', ' + arrProveedores[ColumnaOrdenadaProvs[i]].IDUsuarioProv + ', \'' + arrProveedores[ColumnaOrdenadaProvs[i]].Nombre + '\');');
						thisMacro = macroEnlace2.replace('#HREF#', 'javascript:conversacionProveedor2(' + (arrProveedores[ColumnaOrdenadaProvs[i]].linea - 1) + ');');
						thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
						thisCell += thisMacro;
						if(arrProveedores[ColumnaOrdenadaProvs[i]].HayConversa == 'S'){
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/mail-blue.png');//5abr18	'http://www.newco.dev.br/images/bocadillo.gif'
							thisMacro = thisMacro.replace('#TITLE#', arrProveedores[ColumnaOrdenadaProvs[i]].UltMensaje);
							thisMacro = thisMacro.replace('#ALT#', arrProveedores[ColumnaOrdenadaProvs[i]].UltMensaje);
						}else{
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/message.png');//5abr18	'http://www.newco.dev.br/images/bocadilloPlus.gif'
							thisMacro = thisMacro.replace('#TITLE#', str_iniciarConversacion);
							thisMacro = thisMacro.replace('#ALT#', str_iniciarConversacion);
						}
						thisCell += thisMacro;
						thisCell += macroEnlaceEnd;
					}else if(isAdmin == 'S' && arrProveedores[ColumnaOrdenadaProvs[i]].HayConversa == 'S'){
	//					thisMacro = macroEnlace2.replace('#HREF#', 'javascript:conversacionProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProveedor + ', ' + IDUsuario + ', ' + arrProveedores[ColumnaOrdenadaProvs[i]].IDUsuarioProv + ', \'' + arrProveedores[ColumnaOrdenadaProvs[i]].Nombre + '\');');
						thisMacro = macroEnlace2.replace('#HREF#', 'javascript:conversacionProveedor2(' + (arrProveedores[ColumnaOrdenadaProvs[i]].linea - 1) + ');');
						thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
						thisCell += thisMacro;
						thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/mail-blue.png');//5abr18	'http://www.newco.dev.br/images/bocadillo.gif'
						thisMacro = thisMacro.replace('#TITLE#', arrProveedores[ColumnaOrdenadaProvs[i]].UltMensaje);
						thisMacro = thisMacro.replace('#ALT#', arrProveedores[ColumnaOrdenadaProvs[i]].UltMensaje);
						thisCell += thisMacro;
						thisCell += macroEnlaceEnd;
					}
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Fecha Oferta
				thisCell = cellStart + arrProveedores[ColumnaOrdenadaProvs[i]].FechaOferta + cellEnd;
				thisRow += thisCell;

				// Celda/Columna Evaluacion
				thisCell = cellStart;
				if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoEval == 'NOAPTO'){
					thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/bolaRoja.gif');
					thisMacro = thisMacro.replace('#TITLE#', str_provNoApto);
					thisMacro = thisMacro.replace('#ALT#', str_provNoApto);
				}else if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoEval == 'PEND'){
					thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/bolaAmbar.gif');
					thisMacro = thisMacro.replace('#TITLE#', str_provPendiente);
					thisMacro = thisMacro.replace('#ALT#', str_provPendiente);
				}else{
					thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/bolaVerde.gif');
					thisMacro = thisMacro.replace('#TITLE#', str_provApto);
					thisMacro = thisMacro.replace('#ALT#', str_provApto);
				}
				thisCell += thisMacro;
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Estado Ofertas
				thisCell = cellStart + arrProveedores[ColumnaOrdenadaProvs[i]].EstadoProv + cellEnd;
				thisRow += thisCell;

				/*	30ago16	Si hay comentarios, los concatenamos junto al nombre del proveedor
				// Celda/Columna Comentarios CdC
				thisCell = cellStart;
				if(arrProveedores[ColumnaOrdenadaProvs[i]].CommsCdC != ''){
					thisMacro = macroEnlaceAcc.replace('#HREF#', '#');
					thisMacro = thisMacro.replace('#CLASS#', 'tooltip');
					thisCell += thisMacro;
					thisCell += '<img src="http://www.newco.dev.br/images/info.gif" class="static"/>';
					thisCell += spanStartClass.replace('#CLASS#', 'classic spanEIS');
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].CommsCdC;
					thisCell += spanEnd;
					thisCell += macroEnlaceEnd;
				}//else{
	//				thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].CommsCdC;
	//			}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Comentarios Proveedor
				thisCell = cellStart;
				if(arrProveedores[ColumnaOrdenadaProvs[i]].CommsProv != ''){
					thisMacro = macroEnlaceAcc.replace('#HREF#', '#');
					thisMacro = thisMacro.replace('#CLASS#', 'tooltip');
					thisCell += thisMacro;
					thisCell += '<img src="http://www.newco.dev.br/images/info.gif" class="static"/>';
					thisCell += spanStartClass.replace('#CLASS#', 'classic spanEIS');
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].CommsProv;
					thisCell += spanEnd;
					thisCell += macroEnlaceEnd;
				}//else{
	//				thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].CommsProv;
	//			}
				thisCell += cellEnd;
				thisRow += thisCell;
				*/

				// Celda/Columna Num. Productos Mejor Precio
				thisCell = cellStart;
				thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].OfeMejPrecio;
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Num. Productos Oferta Ahorro
				thisCell = cellStart;
				thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].OfeConAhorro;
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Num. Productos
				thisCell = cellStart;
				thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].NumeroLineas;
				thisCell += cellEnd;
				thisRow += thisCell;

				/*	6jul16	Quitamos estos campos que son poco útiles y añadimos la info de frete (solo Brasil) y plazo de entrega	
				// Celda/Columna Consumo Mejor Precio
				thisCell = cellStartClass.replace('#CLASS#', 'textRight');
				if(mostrarPrecioIVA == 'S'){
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].ConsMejPrecIVA + '&nbsp;';
				}else{
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].ConsMejPrecio + '&nbsp;';
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Consumo Oferta Ahorro
				thisCell = cellStartClass.replace('#CLASS#', 'textRight');
				if(mostrarPrecioIVA == 'S'){
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].ConsConAhorIVA + '&nbsp;';
				}else{
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].ConsConAhorro + '&nbsp;';
				}
				thisCell += cellEnd;
				thisRow += thisCell;
				*/

				// 6jul16	Celda/Columna Frete (solo para Brasil)
				if (IDPais==55)
				{
					thisCell = cellStart;
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].Frete;
					thisCell += cellEnd;
					thisRow += thisCell;
				}

				// Celda/Columna Plazo de entrega
				thisCell = cellStart;
				thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].PlazoEntrega;
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Consumo
				thisCell = cellStartClass.replace('#CLASS#', 'textRight');
				if(mostrarPrecioIVA == 'S'){
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].ConsumoProvIVA + '&nbsp;';
				}else{
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].ConsumoProv + '&nbsp;';
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Ahorro Mejor Precio
				thisCell = cellStartClass.replace('#CLASS#', 'textRight');
				if ( arrProveedores[ColumnaOrdenadaProvs[i]].AhorMejPrecio!=''){		//	31ago16	solo mostramos el ahorro si está informado
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].AhorMejPrecio + '%&nbsp;';
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Ahorro Oferta Ahorro
				thisCell = cellStartClass.replace('#CLASS#', 'textRight');
				if ( arrProveedores[ColumnaOrdenadaProvs[i]].AhorOfeConAhor!=''){		//	31ago16	solo mostramos el ahorro si está informado
					thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].AhorOfeConAhor + '%&nbsp;';
				}
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Ahorro
				thisCell = cellStartClass.replace('#CLASS#', 'textRight');
				if(mostrarPrecioIVA == 'S'){
					if(arrProveedores[ColumnaOrdenadaProvs[i]].ConsumoProvIVA != ''){
						thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].AhorroIVA + '%&nbsp;';
					}
				}else{
					if(arrProveedores[ColumnaOrdenadaProvs[i]].ConsumoProv != ''){
						thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].Ahorro + '%&nbsp;';
					}
				}
				thisCell += cellEnd;
				thisRow += thisCell;

	/* DC - 20mar15 - Los colores son enganyosos
				// Celda/Columna Ahorro
				thisCell = cellStartClass.replace('#CLASS#', 'textRight');
				if(mostrarPrecioIVA == 'S'){
					valAux = arrProveedores[ColumnaOrdenadaProvs[i]].AhorroIVA.replace(',', '.');
					if(arrProveedores[ColumnaOrdenadaProvs[i]].ConsumoProvIVA != ''){
						if(valAux == 0){
							thisCell += spanStartStyle.replace('#STYLE#', 'color:orange;font-weight:bold;');
						}else if(valAux < 0){
							thisCell += spanStartStyle.replace('#STYLE#', 'color:red;font-weight:bold;');
						}else if(valAux > 0){
							thisCell += spanStartStyle.replace('#STYLE#', 'color:green;font-weight:bold;');
						}
						thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].AhorroIVA + '%';
						thisCell += spanEnd + '&nbsp;';
					}
				}else{
					valAux = arrProveedores[ColumnaOrdenadaProvs[i]].Ahorro.replace(',', '.');
					if(arrProveedores[ColumnaOrdenadaProvs[i]].ConsumoProv != ''){
						if(valAux == 0){
							thisCell += spanStartStyle.replace('#STYLE#', 'color:orange;font-weight:bold;');
						}else if(valAux < 0){
							thisCell += spanStartStyle.replace('#STYLE#', 'color:red;font-weight:bold;');
						}else if(valAux > 0){
							thisCell += spanStartStyle.replace('#STYLE#', 'color:green;font-weight:bold;');
						}
						thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].Ahorro + '%';
						thisCell += spanEnd + '&nbsp;';
					}
				}
				thisCell += cellEnd;
				thisRow += thisCell;
	*/

				// Celda/Columna Pedido Minimo
				thisCell = cellStart;
				thisCell += arrProveedores[ColumnaOrdenadaProvs[i]].PedidoMin;
				thisCell += cellEnd;
				thisRow += thisCell;

				// Celda/Columna Acciones
				thisCell = cellStart;
				if(esAutor == 'S'){
					if((EstadoLic == 'EST')||(EstadoLic == 'COMP')){
						if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv == 'SUS'){
							thisMacro = macroEnlace3.replace('#CLASS#', 'accRollBack');
							thisMacro = thisMacro.replace('#HREF#', 'javascript:modificaEstadoProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ', \'CURS\');');
							thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
							thisCell += thisMacro;
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/reload.png');//'http://www.newco.dev.br/images/rollbackVerde.gif'
							thisMacro = thisMacro.replace('#ALT#', str_Activar);
							thisMacro = thisMacro.replace('#TITLE#', str_Activar);
							thisCell += thisMacro;
							thisCell += macroEnlaceEnd + '&nbsp;';
						}else{
							thisMacro = macroEnlace3.replace('#CLASS#', 'accSus');
							thisMacro = thisMacro.replace('#HREF#', 'javascript:modificaEstadoProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ', \'SUS\');');
							thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
							thisCell += thisMacro;
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2022/icones/parar.png');
							thisMacro = thisMacro.replace('#ALT#', str_SuspenderOferta);
							thisMacro = thisMacro.replace('#TITLE#', str_SuspenderOferta);
							thisCell += thisMacro;
							thisCell += macroEnlaceEnd + '&nbsp;';
						}

						thisMacro = macroEnlace3.replace('#CLASS#', 'accBorrar');
						thisMacro = thisMacro.replace('#HREF#', 'javascript:eliminarProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ', ' + arrProveedores[ColumnaOrdenadaProvs[i]].IDUsuarioProv + ');');
						thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
						thisCell += thisMacro;
						thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2022/icones/del.svg');
						thisMacro = thisMacro.replace('#ALT#', str_borrar);
						thisMacro = thisMacro.replace('#TITLE#', str_borrar);
						thisCell += thisMacro;
						thisCell += macroEnlaceEnd + '&nbsp;';
					}else if(EstadoLic == 'CURS'){
						if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv == 'SUS')
						{
							thisMacro = macroEnlace3.replace('#CLASS#', 'accRollBack');
							thisMacro = thisMacro.replace('#HREF#', 'javascript:modificaEstadoProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ', \'CURS\');');
							thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
							thisCell += thisMacro;
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/reload.png');//'http://www.newco.dev.br/images/rollbackVerde.gif'
							thisMacro = thisMacro.replace('#ALT#', str_Activar);
							thisMacro = thisMacro.replace('#TITLE#', str_Activar);
							thisCell += thisMacro;
							thisCell += macroEnlaceEnd + '&nbsp;';
						}
						else if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv == 'INF')
						{
							//	19feb20 ocultamos para licitaciones continuas, pero desde Brasil nos comentan que les reuslta útil para que aparezca en la página de INICIO del proveedor
							thisMacro = macroEnlace3.replace('#CLASS#', 'accRollBack');
							thisMacro = thisMacro.replace('#HREF#', 'javascript:modificaEstadoProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ', \'CURS\');');
							thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
							thisCell += thisMacro;
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/reload.png');//'http://www.newco.dev.br/images/rollbackVerde.gif'
							thisMacro = thisMacro.replace('#ALT#', str_Rollback);
							thisMacro = thisMacro.replace('#TITLE#', str_Rollback);
							thisCell += thisMacro;
							thisCell += macroEnlaceEnd + '&nbsp;';

							// Si no es licitacion por producto, se adjudica desde pestanya proveedores
							if(isLicPorProducto == ''){
								thisMacro = macroEnlace3.replace('#CLASS#', 'accAdjud');
								thisMacro = thisMacro.replace('#HREF#', 'javascript:modificaEstadoProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ', \'ADJ\');');
								thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
								thisCell += thisMacro;
								thisMacro = macroImagen.replace('#ALT#', str_Adjudicar);
								thisMacro = thisMacro.replace('#TITLE#', str_Adjudicar);
								if(IDPais == 55){
									thisMacro = thisMacro.replace('#SRC#', 'http://www.newco.dev.br/images/adjudicarProve-BR.gif');
                                                        	}else{
									thisMacro = thisMacro.replace('#SRC#', 'http://www.newco.dev.br/images/adjudicarProve.gif');
                                                        	}
								thisCell += thisMacro;
								thisCell += macroEnlaceEnd + '&nbsp;';
							}
						}
						else
						{
							thisMacro = macroEnlace3.replace('#CLASS#', 'accSus');
							thisMacro = thisMacro.replace('#HREF#', 'javascript:modificaEstadoProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ', \'SUS\');');
							thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
							thisCell += thisMacro;
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2022/icones/parar.png');
							thisMacro = thisMacro.replace('#ALT#', str_SuspenderOferta);
							thisMacro = thisMacro.replace('#TITLE#', str_SuspenderOferta);
							thisCell += thisMacro;
							thisCell += macroEnlaceEnd + '&nbsp;';
						}
					}else if(EstadoLic == 'INF'){
						if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv == 'SUS'){
							thisMacro = macroEnlace3.replace('#CLASS#', 'accRollBack');
							thisMacro = thisMacro.replace('#HREF#', 'javascript:modificaEstadoProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ', \'CURS\');');
							thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
							thisCell += thisMacro;
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/reload.png');//'http://www.newco.dev.br/images/rollbackVerde.gif'
							thisMacro = thisMacro.replace('#ALT#', str_Activar);
							thisMacro = thisMacro.replace('#TITLE#', str_Activar);
							thisCell += thisMacro;
							thisCell += macroEnlaceEnd + '&nbsp;';
						}else if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv == 'INF'){// Si el prov ha informado oferta, se puede volver atras para pedir otra oferta
							thisMacro = macroEnlace3.replace('#CLASS#', 'accRollBack');
							thisMacro = thisMacro.replace('#HREF#', 'javascript:modificaEstadoProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ', \'CURS\');');
							thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
							thisCell += thisMacro;
							thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/reload.png');//'http://www.newco.dev.br/images/2017/reload.png'
							thisMacro = thisMacro.replace('#ALT#', str_Rollback);
							thisMacro = thisMacro.replace('#TITLE#', str_Rollback);
							thisCell += thisMacro;
							thisCell += macroEnlaceEnd + '&nbsp;';

							// Si no es licitacion por producto, se adjudica desde pestanya proveedores
							if(isLicPorProducto == ''){
								thisMacro = macroEnlace3.replace('#CLASS#', 'accAdjud');
								thisMacro = thisMacro.replace('#HREF#', 'javascript:modificaEstadoProveedor(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ', \'ADJ\');');
								thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
								thisCell += thisMacro;
								thisMacro = macroImagen.replace('#ALT#', str_Adjudicar);
								thisMacro = thisMacro.replace('#TITLE#', str_Adjudicar);
								if(IDPais == 55){
									thisMacro = thisMacro.replace('#SRC#', 'http://www.newco.dev.br/images/adjudicarProve-BR.gif');
                                                        	}else{
									thisMacro = thisMacro.replace('#SRC#', 'http://www.newco.dev.br/images/adjudicarProve.gif');
                                                        	}
								thisCell += thisMacro;
								thisCell += macroEnlaceEnd + '&nbsp;';
							}
						}
					}
				}
				
				/* Botones para imprimir oferta y descargar excel (para todos los usuarios) 		DESACTIVADO 29jun22
				if(arrProveedores[ColumnaOrdenadaProvs[i]].IDEstadoProv == 'INF'){
					thisMacro = macroEnlace3.replace('#CLASS#', 'accImprimir');
					thisMacro = thisMacro.replace('#HREF#', 'javascript:imprimirOferta(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ');');
					thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
					thisCell += thisMacro;
					thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/print.png');//'http://www.newco.dev.br/images/imprimir.gif'
					thisMacro = thisMacro.replace('#ALT#', str_ImprimirOferta);
					thisMacro = thisMacro.replace('#TITLE#', str_ImprimirOferta);
					thisCell += thisMacro;
					thisCell += macroEnlaceEnd + '&nbsp;';

					thisMacro = macroEnlace3.replace('#CLASS#', 'accExcel');
					thisMacro = thisMacro.replace('#HREF#', 'javascript:listadoExcel(' + arrProveedores[ColumnaOrdenadaProvs[i]].IDProvLic + ');');
					thisMacro = thisMacro.replace('#STYLE#', 'text-decoration:none;');
					thisCell += thisMacro;
					thisMacro = macroImagen.replace('#SRC#', 'http://www.newco.dev.br/images/2017/excel.png');//http://www.newco.dev.br/images/iconoExcel.gif
					thisMacro = thisMacro.replace('#ALT#', str_ListadoExcel);
					thisMacro = thisMacro.replace('#TITLE#', str_ListadoExcel);
					thisCell += thisMacro;
					thisCell += macroEnlaceEnd + '&nbsp;';
				}*/
				thisCell += cellEnd;
				thisRow += thisCell;

				thisRow += rowEnd;

				htmlTBODY += thisRow;
			}
		}
		if(EstadoLic != 'EST'){
			dibujarFilaConsumoProvEST();
        }
	}else{
	
		htmlTBODY = "<tr><td colspan=\"19\" align=\"center\"><strong>" + str_licSinProveedores + "</strong></td></tr>";
	}

	jQuery('#lProveedores_EST tbody').empty().append(htmlTBODY);
}

function dibujarFilaConsumoProvADJ(){
	var htmlTFOOT = '';

	htmlTFOOT = '<tfoot class="rodape_tabela">';

	htmlTFOOT += rowStartStyle.replace('#STYLE#', 'border-top:1px solid #999;height:30px;');
	htmlTFOOT += cellStartColspan.replace('#COLSPAN#', '9');
	htmlTFOOT += cellEnd;
	htmlTFOOT += cellStartClass.replace('#CLASS#', 'textRight') + '<strong>';
	htmlTFOOT += objLicitacion['ConsumoAdj'];
	htmlTFOOT += '</strong>&nbsp;' + cellEnd;
	htmlTFOOT += cellStartClass.replace('#CLASS#', 'textRight') + '<strong>';
	htmlTFOOT += objLicitacion['AhorroAdj'];			//2ene20
	htmlTFOOT += '</strong>&nbsp;' + cellEnd;
	htmlTFOOT += cellStart + '&nbsp;' + cellEnd;
	htmlTFOOT += cellStart + '<strong>' + objLicitacion['NumProductosAdj'] +'/'+ objLicitacion['NumProductos'] + '</strong>' + cellEnd;		//2ene20
	htmlTFOOT += cellStart + cellEnd;
	htmlTFOOT += rowEnd;
	htmlTFOOT += '</tfoot>';

	jQuery('#lProveedores_ADJ').append(htmlTFOOT);
}

function dibujarFilaConsumoProvEST(){
	var htmlTFOOT = '';

	htmlTFOOT = '<tfoot class="rodape_tabela">';

	htmlTFOOT += rowStartStyle.replace('#STYLE#', 'border-top:1px solid #999;height:30px;');
	htmlTFOOT += cellStart + cellEnd;
	htmlTFOOT += cellStartColspanCls.replace('#COLSPAN#', '8').replace('#CLASS#', 'centerDiv');;
	htmlTFOOT += '<strong>' + str_PorcNegociado + ':&nbsp' + objLicitacion['PorcConsNeg'] + '&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;' + str_PorcAhorro + ':&nbsp' + objLicitacion['AhorMejPrecio'] + '&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;' + str_ProdsSinOferta + ':&nbsp' + objLicitacion['NumSinOferta'] + '&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;' + str_ProdsSinOfertaConAhorro + ':&nbsp' + objLicitacion['NumSinAhorro'] + '</strong>';
	htmlTFOOT += cellEnd;

	htmlTFOOT += cellStartColspanCls.replace('#COLSPAN#', '3').replace('#CLASS#', 'textRight') + '<strong>' + str_TotalProductos + ':</strong>' + cellEnd;
	htmlTFOOT += cellStart + '<strong>' + objLicitacion['NumProductos'] + '</strong>' + cellEnd;

	htmlTFOOT += cellStartColspanCls.replace('#COLSPAN#', '2').replace('#CLASS#', 'textRight') + '<strong>';
	if(mostrarPrecioIVA == 'S')
		htmlTFOOT += str_ConsHistIVA;
	else
		htmlTFOOT += str_ConsHist;
	htmlTFOOT += ':</strong>' + cellEnd;
	htmlTFOOT += cellStartClass.replace('#CLASS#', 'textRight') + '<strong>';
	if(mostrarPrecioIVA == 'S')
		htmlTFOOT += objLicitacion['ConsHistIVA'];
	else
		htmlTFOOT += objLicitacion['ConsHist'];
	htmlTFOOT += '</strong>' + cellEnd;
	htmlTFOOT += cellStartColspan.replace('#COLSPAN#', '5') + cellEnd;

	htmlTFOOT += rowEnd;

	htmlTFOOT += '</tfoot>';

	jQuery('#lProveedores_EST').append(htmlTFOOT);
}

//	Ordena tabla proveedores por una columna
function OrdenarProvsPorColumna(col)
{

	if(ColumnaOrdenacionProvs == col)
	{
		if(OrdenProvs == 'ASC')
		{
			OrdenProvs = 'DESC';
        }
		else
		{
			OrdenProvs = 'ASC';
        }
	}
	else
	{
		ColumnaOrdenacionProvs = col;
		if(col == 'ConsumoProv' || col == 'ConsumoProvIVA' || col == 'ConsumoAdj' || col == 'ConsumoAdjIVA' || col == 'Ahorro' ||
		   col == 'NumeroLineas' || col == 'OfeMejPrecio' || col == 'OfeConAhorro' || col == 'ConsMejPrecio' ||
		   col == 'ConsMejPrecIVA' || col == 'ConsConAhorro' || col == 'ConsConAhorIVA' || col == 'AhorMejPrecio' || col == 'AhorOfeConAhor')
			OrdenProvs = 'DESC';
		else
			OrdenProvs = 'ASC';
	}

	//	Si la columna es numerica, ordenamiento burbuja
	if(col == 'ConsumoProv' || col == 'ConsumoProvIVA' || col == 'ConsumoAdj' || col == 'ConsumoAdjIVA' || col == 'Ahorro' ||
	   col == 'PedidoMin' || col == 'NumeroLineas' || col == 'OfeMejPrecio' || col == 'OfeConAhorro' || col == 'ConsMejPrecio' ||
	   col == 'ConsMejPrecIVA' || col == 'ConsConAhorro' || col == 'ConsConAhorIVA' || col == 'AhorMejPrecio' || col == 'AhorOfeConAhor')
		ordenamientoBurbujaProvs(col, OrdenProvs);
	//	Si la columna es string, ordenamiento alfabetico
	else if(col == 'NombreCorto')
		ordenamientoAlfabetProvs(col, OrdenProvs);

	dibujaTablaProveedores();
}

//	Prepara un array con los ordenes correspondientes a una columna de numeros
function ordenamientoBurbujaProvs(col, tipo){
	var temp, temp2, size, valAux;
	var arrValores = new Array();
	
	//solodebug
	debug('ordenamientoBurbujaProvs ('+col+', '+tipo+')');
	

	// Creamos un vector auxiliar con los valores que queremos ordenar (segun el vector de ordenacion)
	for(var i=0; i<totalProvs; i++){
		valAux = ((arrProveedores[ColumnaOrdenadaProvs[i]][col]!='')&&(desformateaDivisa(arrProveedores[ColumnaOrdenadaProvs[i]][col])) != '') ? desformateaDivisa(arrProveedores[ColumnaOrdenadaProvs[i]][col]) : '0';
		
		//solodebug
		debug('ordenamientoBurbujaProvs ('+col+', '+'tipo). Proveedor('+i+')'+arrProveedores[ColumnaOrdenadaProvs[i]].NombreCorto+':'+arrProveedores[ColumnaOrdenadaProvs[i]][col]+'->'+valAux);
		
		arrValores.push(parseFloat(valAux));
	}

	size = totalProvs;
	for(var pass = 1; pass < size; pass++){ // outer loop
		for(var left = 0; left < (size - pass); left++){ // inner loop
			var right = left + 1;

			// Comparamos valores del vector auxiliar
			if(arrValores[left] > arrValores[right]){
				// Intercambiamos valores del vector auxiliar y del vector de ordenacion, ya este ultimo es el que queremos ordenar y estan relacionados
				temp=ColumnaOrdenadaProvs[left];
				temp2=arrValores[left];
				ColumnaOrdenadaProvs[left]=ColumnaOrdenadaProvs[right];
				arrValores[left]=arrValores[right];
				ColumnaOrdenadaProvs[right]=temp;
				arrValores[right]=temp2;
			}
		}
	}

	//	En caso de ordenacion descendiente intercambiamos de forma simetrica el vector de ordenacion
	if(tipo=='DESC'){
		for(i=1; i<=totalProvs/2; i++){
			temp=ColumnaOrdenadaProvs[totalProvs-i];
			ColumnaOrdenadaProvs[totalProvs-i]=ColumnaOrdenadaProvs[i-1];
			ColumnaOrdenadaProvs[i-1]=temp;
		}
	}
}

//	Prepara un array con los ordenes correspondientes a una columna de caracteres alfanumericos
function ordenamientoAlfabetProvs(col, tipo){
	var temp, temp2, size, valAux;
	var arrValores = new Array();

	// Creamos un vector auxiliar con los valores que queremos ordenar (segun el vector de ordenacion)
	for(var i=0; i<totalProvs; i++){
	
		valAux = arrProveedores[ColumnaOrdenadaProvs[i]][col];
		arrValores.push(valAux);
	}

	size = totalProvs;
	for(var pass = 1; pass < size; pass++){ // outer loop
		for(var left = 0; left < (size - pass); left++){ // inner loop
			var right = left + 1;

			// Comparamos valores del vector auxiliar
			if(arrValores[left] > arrValores[right]){
				// Intercambiamos valores del vector auxiliar y del vector de ordenacion, ya este ultimo es el que queremos ordenar y estan relacionados
				temp=ColumnaOrdenadaProvs[left];
				temp2=arrValores[left];
				ColumnaOrdenadaProvs[left]=ColumnaOrdenadaProvs[right];
				arrValores[left]=arrValores[right];
				ColumnaOrdenadaProvs[right]=temp;
				arrValores[right]=temp2;
			}
		}
	}

	//	En caso de ordenacion descendiente intercambiamos de forma simetrica el vector de ordenacion
	if(tipo=='DESC'){
		for(i=1; i<=totalProvs/2; i++){
			temp=ColumnaOrdenadaProvs[totalProvs-i];
			ColumnaOrdenadaProvs[totalProvs-i]=ColumnaOrdenadaProvs[i-1];
			ColumnaOrdenadaProvs[i-1]=temp;
		}
	}
}


function conversacionProveedor2(posArr){
	if(posArr == null){	// Comentario del proveedor
		var IDProveedor		= IDProveedorIni;
		var IDUsuClie		= IDUsuarioCliente;
		var IDUsuProv		= IDUsuario;
		var NombreProv		= NombreCliente;
	}else{			// COmentario del usuario autor
		var IDProveedor		= arrProveedores[posArr].IDProveedor;
		var IDUsuClie		= IDUsuario;
		var IDUsuProv		= arrProveedores[posArr].IDUsuarioProv;
		var NombreProv		= arrProveedores[posArr].Nombre;
	}
	var d = new Date();
	
	jQuery("#Respuesta").hide();	//	25oct17

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/ConversacionLicitacionAJAX.xsql',
		type:	"GET",
		data:	"IDLICITACION="+IDLicitacion+"&IDPROVEEDOR="+IDProveedor+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			jQuery("#convProveedor #mensError").hide();
			jQuery("#convProveedor span#NombreProv").html(NombreProv);
			jQuery("#convProveedor table#viejosComentarios tbody").empty();
			jQuery("#convProveedor table#viejosComentarios").hide();
			jQuery("#convProveedor table#nuevoComentario #LIC_MENSAJE").val("");
			jQuery("#convProveedor table#nuevoComentario").hide();
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.Estado == 'OK'){
				if(data.isAutor == 'S' || data.isProveedor == 'S'){
					jQuery("#convProveedor #IDPROVEEDOR").val(IDProveedor);
					jQuery("#convProveedor #IDUSUARIOCLIENTE").val(IDUsuClie);
					jQuery("#convProveedor #IDUSUARIOPROV").val(IDUsuProv);
					jQuery("#convProveedor table#nuevoComentario").show();
				}

				if(data.ListaComentarios.length){
					var innerHTML = '';

					for(var i=0; i<data.ListaComentarios.length; i++){
						innerHTML += '<tr><td class="dies"><strong>' + str_Autor + ':</strong></td>';
						innerHTML += '<td style="text-align:left;">';
						if(data.ListaComentarios[i].IDUsuarioAutor == data.ListaComentarios[i].IDUsuarioCliente){
							innerHTML += data.ListaComentarios[i].UsuarioCliente;
						}else if(data.ListaComentarios[i].IDUsuarioAutor == data.ListaComentarios[i].IDUsuarioProv){
							innerHTML += data.ListaComentarios[i].UsuarioProv;
						}
						innerHTML += '</td>';
						innerHTML += '<td><strong>' + str_fecha + ':</strong></td>';
						innerHTML += '<td style="text-align:left;">' + data.ListaComentarios[i].Fecha + '</td>';
						innerHTML += '<td class="dies">&nbsp;</td></tr>';

						innerHTML += '<tr><td><strong>' + str_comentario + ':</strong></td>';
						innerHTML += '<td colspan="3" style="text-align:left;">' + data.ListaComentarios[i].Mensaje + '</td>';
						innerHTML += '<td>&nbsp;</td></tr>';

						innerHTML += '<tr><td>&nbsp;</td>';
						innerHTML += '<td colspan="3" style="border-bottom:2px solid #3B5998;">&nbsp;</td>';
						innerHTML += '<td>&nbsp;</td></tr>';
					}
					jQuery("#convProveedor table#viejosComentarios tbody").append(innerHTML);
					jQuery("#convProveedor table#viejosComentarios").show();
				}
			}else{
				jQuery("#convProveedor #mensError").show();
			}
		}
	});

	showTablaByID("convProveedor");
}

function guardarConversProv(){
	var oForm	= document.forms['convProveedorForm'];
	var IDProv	= oForm.elements['IDPROVEEDOR'].value;
	var IDUsuProv	= oForm.elements['IDUSUARIOPROV'].value;
	var Mensaje	= oForm.elements['LIC_MENSAJE'].value.replace(/'/g, "''");
	var errores	= 0;
	var d = new Date();

	if((!errores) && (esNulo(Mensaje))){
		errores++;
		alert(val_faltaMensaje);
		oForm.elements['LIC_MENSAJE'].focus();
	}
	
	jQuery("#btnGuardarConv").hide();			//	25oct17

	/* si los datos son correctos enviamos el form  */
	if(!errores){
		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Gestion/Comercial/ConversacionLicitacionSaveAJAX.xsql',
			type:	"POST",
			data:	"IDLICITACION="+IDLicitacion+"&IDPROVEEDOR="+IDProv+"&IDUSUARIOCLIENTE="+IDUsuario+"&IDUSUARIOPROV="+IDUsuProv+"&LIC_MENSAJE="+encodeURIComponent(Mensaje)+"&_="+d.getTime(),
			beforeSend: function(){
				jQuery("#btnGuardarConv").hide();			//	25oct17
			},
			error: function(objeto, quepaso, otroobj){
				alert('error'+quepaso+' '+otroobj+' '+objeto);
			},
			success: function(objeto){
				var data = JSON.parse(objeto);

				if(data.Estado == 'OK'){
					jQuery("#convProveedor td#Respuesta").addClass("verde").html(str_guardarCommOK);
				}else{
					jQuery("#convProveedor td#Respuesta").addClass("rojo2").html(str_guardarCommKO);
				}
				jQuery("#convProveedor td#Respuesta").show();
			}
		});
	}

}

// modifica estado de un proveedor de la licitacion
function modificaEstadoProveedor(IDProve, IDEstado){
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/ModificaEstadoProveedor.xsql',
		type:	"GET",
		data:	"ID_PROVE="+IDProve+"&ID_ESTADO="+IDEstado+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.ModificaEstadoProveedor.estado == 'OK'){
				// Si adjudicamos una licitacion => recargamos la pagina
				if(IDEstado == 'ADJ'){
					Recarga();	//23jul19	location.reload();
					return;
				}else if(IDEstado == 'FIRM'){
					jQuery('#botonFirmarLici').hide();
					if(window.opener !== null && !window.opener.closed){
						opener.location.reload();	// Recarga de la pagina padre para actualizar el estado de la licitacion
					}
					alert(alrt_firmaProveedorOK);
					Recarga();	//23jul19	location.reload();
					return;
				}

				EstadoActualLicitacion();
				recuperaDatosProveedores();
			}else{
				if(IDestado == 'ADJ')
					alert(alrt_AdjudicarProveedorKO);
				else if(IDestado == 'SUS')
					alert(alrt_SuspenderProveedorKO);
				else if(IDestado == 'FIRM')
					alert(alrt_NuevoEstadoProveedorKO);
				else
					alert(alrt_RollBackProveedorKO);
			}
		}
	});
}


function EstadoActualLicitacion(){
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/EstadoLicitacion.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.LicID == IDLicitacion){
				estadoLicitacion = data.IDEstado;

				var EstadoNuevo	= data.Estado;
				var EstadoViejo	= jQuery("#idEstadoLic").text();

				if(EstadoNuevo != EstadoViejo){
					jQuery("#idEstadoLic").text(EstadoNuevo);
					jQuery("#idEstadoLic").addClass("amarillo");
                                }
                        }
		}
	});
}



/*!!!!!!!!!!!!!!!!!!!!!!!!!!
BLOQUE A ELIMINAR

	if(nombre == 'proveedores'){
		if(!errores && oForm.elements['LIC_IDPROVEEDOR'].value == ''){
			errores++;
			alert(val_faltaProveedor);
			oForm.elements['LIC_IDPROVEEDOR'].focus();
		}else{
			var chckUser = true;
			if(isNaN(oForm.elements['LIC_IDPROVEEDOR'].value))
				chckUser = false;
		}

		if(!errores){
			AnadirProveedor(oForm);
		}
	}

	if(nombre == 'selecciones')
	{
		AnadirSeleccionesProveedores(oForm);
	}

BLOQUE A ELIMINAR
!!!!!!!!!!!!!!!!!!!!!!!!!!!*/




// Funcion para anyadir proveedores a la licitacion
function AnadirProveedor(oForm){
	var oForm=document.forms["frmProveedores"];
	var IDProveedor	= oForm.elements['LIC_IDPROVEEDOR'].value;
	var IDUsuario	= '';
	var EstadoEval	= oForm.elements['LIC_IDESTADOEVALUACION'].value;
	var Comentarios	= oForm.elements['LIC_COMENTARIOS'].value.replace(/'/g, "''");	// Sustituimos comilla simple (') por dos comillas simples ('') para que no rompa el PL/SQL
	var BloquearAvisos = (jQuery("#BLOQUEARAVISOS").is(':checked')) ? 'S' : 'N';		// 1jul22 .attr('checked')
	var d = new Date();

	if(oForm.elements['LIC_IDPROVEEDOR'].value == '')
	{
		alert(val_faltaProveedor);
		oForm.elements['LIC_IDPROVEEDOR'].focus();
		return;
	}
    jQuery("#btnAnadirProveedores").hide();

    jQuery.ajax({
        cache:    false,
        url:    'http://www.newco.dev.br/Gestion/Comercial/NuevoProveedor.xsql',
        type:    "GET",
        data:    "PROV_ID="+IDProveedor+"&PROV_US_ID="+IDUsuario+"&LIC_ID="+IDLicitacion+"&IDESTADOEVALUACION="+EstadoEval+"&COMENTARIOS="+encodeURIComponent(Comentarios)+"&BLOQUEARAVISOS="+BloquearAvisos+"&_="+d.getTime(),
        contentType: "application/xhtml+xml",
        error: function(objeto, quepaso, otroobj){
            alert('error'+quepaso+' '+otroobj+' '+objeto);
            jQuery("#btnAnadirProveedores").show();
        },
        success: function(objeto){
			var data = JSON.parse(objeto);

            if(data.NuevoProveedor.estado == 'OK'){
                // Informamos variable de validacion de proveedores informados (si hay proveedores)
                provsInformados = 'S';

                // Si cuando anyadimos un proveedor la lic esta INF, entonces cambiamos el estado a CURS
                if(EstadoLic == 'INF'){
                    EstadoLic = 'CURS';
                    jQuery("#idEstadoLic").text(str_EnCurso);
                    jQuery("#idEstadoLic").addClass("amarillo");
                }

                recuperaDatosProveedores();
            }else{
                alert(alrt_NuevoProveedorKO);
            }
            jQuery("#btnAnadirProveedores").show();
        }
    });
}


//	30jun20 Añade un proveedor o una selección de proveedores (Sustituye a AnadirSeleccionProveedor)
function AnadirSeleccionesProveedores()
{
	var oForm=document.forms["frmProveedores"];
	var d = new Date();
	var Selecciones='';
	//	Recorre los checkboxes para detectar cambios
	for (var i=0;i<oForm.elements.length;++i)
	{
		//console.log('ProveedorOSeleccion:'+oForm.elements[i].name.substring(0,4));
		if ((oForm.elements[i].name.substring(0,5)=='PROV_')&&(oForm.elements[i].checked)&&(!oForm.elements[i].disabled))
		{
			Selecciones+=Piece(oForm.elements[i].name,'_',2)+'|';
		}
	}
	
	jQuery("#btnAnadirSelecciones").hide();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/AnnadirSeleccionesProveedoresAJAX.xsql',
		type:	"GET",
		data:	"SELECCIONES="+Selecciones+"&LIC_ID="+IDLicitacion+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
            jQuery("#btnAnadirSelecciones").show();
		},
		success: function(objeto){
			var data = JSON.parse(objeto);

			if(data.NuevaSeleccion.estado == 'OK'){
				// Informamos variable de validacion de proveedores informados (si hay proveedores)
				provsInformados = 'S';

				// Si cuando anyadimos un proveedor la lic esta INF, entonces cambiamos el estado a CURS
				if(EstadoLic == 'INF'){
					EstadoLic = 'CURS';
					jQuery("#idEstadoLic").text(str_EnCurso);
					jQuery("#idEstadoLic").addClass("amarillo");
				}
				
				// si todo ha ido bien, desactiva los checkboxes
				for (var i=0;i<oForm.elements.length;++i)
				{
					if ((oForm.elements[i].name.substring(0,5)=='PROV_')&&(oForm.elements[i].checked)&&(!oForm.elements[i].disabled))
					{
						oForm.elements[i].disabled=true;
					}
				}
				//	21dic21	El proceso de creacion de proveedores devuelve un contador, los proveedores se tienen que actualizar luego
				InicializaProveedores(0,data.NuevaSeleccion.numProveedores, 50);
				jQuery("#btnAnadirSelecciones").show();

				//	21dic21 Los datos de los proveedores se recuperaran tras inicializarlos
				//recuperaDatosProveedores();
			}else{
				alert(alrt_NuevoProveedorKO);
				jQuery("#btnAnadirSelecciones").show();
			}
            //22dic21 jQuery("#btnAnadirSelecciones").show();
		}
	});
	
}

// Inicializa proveedores insertados desde nueva seleccion. Funcion recurrente.
function InicializaProveedores(Pos, numProvs, numProvsPag)
{
	var d = new Date();

	//solodebug	console.log('InicializaProveedores. Inicio. Pos:'+Pos+' numProvs:'+numProvs+' numProvsPag:'+numProvsPag);
	
	if (Pos>=numProvs)
	{
		alert(str_IncluyendoProvs+': '+numProvs+'/'+numProvs);
		recuperaDatosProveedores();
		jQuery("#spAnSel").html('');
        jQuery("#btnAnadirSelecciones").show();
		return;
	}
	
	jQuery("#spAnSel").html(str_IncluyendoProvs+': '+Pos+'/'+numProvs);
	

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/InicializarProveedoresAJAX.xsql',
		type:	"GET",
		data:	"MAXPROVEEDORES="+numProvsPag+"&LIC_ID="+IDLicitacion+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
            jQuery("#btnAnadirSelecciones").show();
		},
		success: function(objeto){
			var data = JSON.parse(objeto);

			if(data.NuevaSeleccion.estado == 'OK'){
				
				Pos+=parseInt(data.NuevaSeleccion.numProveedores);
				
				//solodebug	console.log('InicializaProveedores. AJAX OK. Pos:'+Pos+' numProvs:'+numProvs+' numProvsPag:'+numProvsPag);
				
				//	Continua con la carga
				InicializaProveedores(Pos, numProvs, numProvsPag);

			}else{
				alert(alrt_NuevoProveedorKO);
			}
		}
	});
	
}





// Funcion para anyadir proveedores a la licitacion
function AnadirSeleccionProveedor(oForm){
	var IDSeleccion	= oForm.elements['LIC_IDPROVEEDOR'].value;
	var EstadoEval	= oForm.elements['LIC_IDESTADOEVALUACION'].value;
	var Comentarios	= oForm.elements['LIC_COMENTARIOS'].value.replace(/'/g, "''");	// Sustituimos comilla simple (') por dos comillas simples ('') para que no rompa el PL/SQL
	var BloquearAvisos = (jQuery("#BLOQUEARAVISOS").is(':checked')) ? 'S' : 'N';		// 1jul22 .attr('checked')
	var d = new Date();

	jQuery("#btnAnadirProveedores").hide();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/NuevaSeleccionProveedor.xsql',
		type:	"GET",
		data:	"SEL_ID="+IDSeleccion+"&LIC_ID="+IDLicitacion+"&IDESTADOEVALUACION="+EstadoEval+"&COMENTARIOS="+encodeURIComponent(Comentarios)+"&BLOQUEARAVISOS="+BloquearAvisos+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
            jQuery("#btnAnadirProveedores").show();
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.NuevaSeleccion.estado == 'OK'){
				// Informamos variable de validacion de proveedores informados (si hay proveedores)
				provsInformados = 'S';

				// Si cuando anyadimos un proveedor la lic esta INF, entonces cambiamos el estado a CURS
				if(EstadoLic == 'INF'){
					EstadoLic = 'CURS';
					jQuery("#idEstadoLic").text(str_EnCurso);
					jQuery("#idEstadoLic").addClass("amarillo");
				}

				recuperaDatosProveedores();
			}else{
				alert(alrt_NuevoProveedorKO);
			}
            jQuery("#btnAnadirProveedores").show();
		}
	});
}


//	1jul20 Marca las sleeciones que ya han sido utilizadas
function RevisarListaSelecciones()
{
	for (var i=0;i<PieceCount(listaSelecciones,'|');++i)
	{
		var IDSeleccion=Piece(listaSelecciones,'|',i);
		jQuery("#PROV_SEL_"+IDSeleccion).prop( "checked", true ).prop( "disabled", true );
	}
}


//	Recupera la info de proveedores tras insertar nuevos
function recuperaDatosProveedores(){
	var d = new Date();

	//solodebug debug('recuperaDatosProveedores');
	totalProvs=0;	//24ene20
	
	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/RecuperaProveedores.xsql',
		type:	"GET",
		data:	"LIC_ID="+IDLicitacion+"&IDIDIOMA="+IDIdioma+"&ROL="+rol+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);
			arrProveedores	= new Array();

			if(data.ListaProveedores.length > 0){

				jQuery.each(data.ListaProveedores, function(key, proveedor){

					var items		= [];
					items['linea']		= proveedor.Linea;
					items['IDProvLic']	= proveedor.IDPROVEEDOR_LIC;
					items['IDProveedor']	= proveedor.ID;
					items['Nombre']		= proveedor.Nombre;
					items['NombreCorto']	= proveedor.NombreCorto;
					items['FechaAlta']	= proveedor.FechaAlta;
					items['FechaOferta']	= proveedor.FechaOferta;
					items['IDEstadoProv']	= proveedor.IDEstadoProv;
					items['EstadoProv']	= proveedor.EstadoProv;
					items['CommsProv']	= proveedor.ComentariosProv;
					items['CommsCdC']	= proveedor.ComentariosCdC;
					items['IDEstadoEval']	= proveedor.IDEstadoEvaluacion;
					items['EstadoEval']	= proveedor.EstadoEvaluacion;
					items['PedidoMin']	= proveedor.PedidoMin;
					items['ConsumoProv']	= proveedor.ConsumoProv;
					items['ConsumoProvIVA']	= proveedor.ConsumoProvIVA;
					items['Ahorro']		= proveedor.Ahorro;
					items['OfertasVacias']	= proveedor.OfertasVacias;
					items['ConsumoPot']	= proveedor.ConsumoPotencial;
					items['ConsumoPotIVA']	= proveedor.ConsumoPotencialIVA;
					items['ConsumoAdj']	= proveedor.ConsumoAdjudicado;
					items['ConsumoAdjIVA']	= proveedor.ConsumoAdjudicadoIVA;
					items['AhorroIVA']	= proveedor.AhorroIVA;
					items['NumeroLineas']	= proveedor.NumeroLineas;

					items['Frete']			= proveedor.Frete;				//	12ago16
					items['PlazoEntrega']	= proveedor.PlazoEntrega;		//	12ago16

					items['OfeConAhorro']	= proveedor.OfertasConAhorro;
					items['OfeMejPrecio']	= proveedor.OfertasConMejorPrecio;
					items['ConsMejPrecio']	= proveedor.ConsConMejorPrecio;
					items['ConsMejPrecIVA']	= proveedor.ConsConMejorPrecioIVA;
					items['AhorMejPrecio']	= proveedor.AhorroEnMejorPrecio;
					items['ConsConAhorro']	= proveedor.ConsConAhorro;
					items['ConsConAhorIVA']	= proveedor.ConsConAhorroIVA;
					items['AhorOfeConAhor']	= proveedor.AhorroOfeConAhorro;
					items['OfertasAdj']	= proveedor.OfertasAdjudicadas;

					items['IDUsuarioProv']	= proveedor.UsuarioProve;
					items['NombreUsuario']	= proveedor.NombreUsuario;

					items['HayConversa']	= proveedor.HayConversacion;
					items['UltMensaje']	= proveedor.UltMensaje;
					items['Estrellas']	= proveedor.Estrellas;	
					items['BloqPedidos']	= proveedor.BloqPedidos;		//	13ene20
					
					items['IDDocumento'] = proveedor.IDDocumento;	//	19feb20

					arrProveedores.push(items);
					ColumnaOrdenadaProvs[totalProvs] = totalProvs;			//	24ene20
					++totalProvs;											//	24ene20
					
					//solodebug debug('recuperaDatosProveedores ('+totalProvs+'):'+proveedor.NombreCorto);
				});
				// Informamos variable de validacion de proveedores informados (si hay proveedores)
				provsInformados = 'S';
			}else{
				// Informamos variable de validacion de proveedores informados (no hay proveedores)
				provsInformados = 'N';
			}

			// Preparamos datos para dibujar nueva tabla
			//prepararTablaProveedores();	
			
			//totalProvs=arrProveedores.length;	//24ene20

			OrdenarProvsPorColumna('NombreCorto');	//	12nov19
			dibujaTablaProveedores();
			
		}
	});
}

// Eliminar un proveedor de la licitacion
function eliminarProveedor(IDProve,IDUsuarioProve){
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/EliminarProveedor.xsql',
		type:	"GET",
		data:	"ID_PROVE="+IDProve+"&ID_USUARIO_PROVE="+IDUsuarioProve+"&ID_ESTADO=B&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			//var data = eval("(" + objeto + ")");
			var data = JSON.parse(objeto);

			if(data.EliminarProveedor.estado == 'OK'){
				recuperaDatosProveedores();
			}else{
				alert(alrt_EliminarProveedorKO);
			}
		}
	});
}

/*	29jun22 Desactivamos provisionalmente

// Funcion para abrir las ofertas de un proveedor en pop-up para imprimir
function imprimirOferta(IDProvLic){
	MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/ImprimirOferta2022.xsql?LIC_ID='+IDLicitacion+'&LIC_PROV_ID='+IDProvLic,'',100,100,0,0);
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
*/

function abrirBoxNuevoUsuario(posArr){
	var NombreProv	= arrProveedores[posArr].Nombre;
	var IDProveedor	= arrProveedores[posArr].IDProveedor;
	var d = new Date();

	jQuery("#cambioUsuProv #NombreProv").html(NombreProv);
	jQuery("#cambioUsuProv #posArray").val(posArr);

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/UsuariosProveedor.xsql',
		type:	"GET",
		data:	"IDProveedor="+IDProveedor+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			jQuery("#IDUSUARIOPROV_NUEVO").empty();
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			jQuery("#IDUSUARIOPROV_NUEVO").append("<option value=''>" + str_Selecciona + "</option>");

			for(var i=0;i<data.ListaUsuarios.length;i++){
				jQuery("#IDUSUARIOPROV_NUEVO").append("<option value='"+data.ListaUsuarios[i].id+"'>"+data.ListaUsuarios[i].centro+":"+data.ListaUsuarios[i].nombre+"</option>");
			}
			jQuery("#IDUSUARIOPROV_NUEVO").val("");
		}
	});

	showTablaByID("cambioUsuProv");
	jQuery("#cambioUsuProv #BotonNuevoUsu").show();		//	ET	1feb17
}

function guardarNuevoUsuProv(){
	var posArr	= jQuery("#cambioUsuProv #posArray").val();
	var IDUsuProv	= jQuery("#cambioUsuProv #IDUSUARIOPROV_NUEVO").val();
	var IDProvLic	= arrProveedores[posArr].IDProvLic;
	var d = new Date();
	
	if (IDUsuProv=='')
	{
		alert(val_faltaUsuarioProv);
		return;
	}

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Gestion/Comercial/GuardarUsuarioProveedorAJAX.xsql',
		type:	"GET",
		data:	"IDPROVLIC="+IDProvLic+"&IDUSUPROV="+IDUsuProv+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			jQuery("#cambioUsuProv #BotonNuevoUsu").hide();
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+' '+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

    	if(data.Resultado.Estado == 'OK'){
				recuperaDatosProveedores();
				alert(alrt_nuevoUsuarioProvOK);
				showTabla(false);
			}else{
				alert(alrt_nuevoUsuarioProvKO);
			}
		}
	});

}

//	13ene20 Busca el índice de un proveedor por su IDProveedorLic
function IDPosicionProveedor(IDProveedorLic)
{
	var Res=-1;
	for (i=0;((i<arrProveedores.length) && (Res==-1));++i)
		if (arrProveedores[i].IDProvLic==IDProveedorLic) Res=i;
		
	return Res;
}

//	13ene20 Comprueba si un proveedor está bloqueado por pedidos
function ProveedorBloqueado(IDProveedorLic)
{
	return arrProveedores[IDPosicionProveedor(IDProveedorLic)].BloqPedidos;
}




