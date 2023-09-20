//	Funciones de Javascript utilizadas en EISAnualHTML.xsl
//	Ultima revision ET 26mar20 16:35 EISAnual_260320.js

//	Datos globales: matriz de datos del EIS Anual
var		NumLineas,						//	Numero de lineas de la tabla (la ultima contiene el total)
		IDGrupos=new Array(1000),	
		NombresGrupos=new Array(1000),	//	Nombre del grupo (linea)
		IDIndicadores=new Array(1000),	//	Indicador para cada linea de la tabla
		NombresIndicadores=new Array(1000),	//	Indicador para cada linea de la tabla
		Valores=new Array(13000),		//	Matriz de valores (Grupos * Meses)
		Colores=new Array(13000),		//	Matriz de colores (Grupos * Meses)
		Valor,
		NombresAnnos=new Array(NumColumnas),		//	Nombre de los anyos
		Meses=new Array(NumColumnas),			//	Mes para cada columna
		Annos=new Array(NumColumnas),			//	Anno para cada columna
		Done='N',				//	Tabla ya calculada
		LineaActiva=new Array(1000),	//	Indica si la linea de la tabla estï¿½ activa (y se mostrarï¿½) u oculta
		ColumnaActiva=new Array(NumColumnas),			//	Indica si la columna de la tabla esta activa (y se mostrara) u oculta
		Errores='',						//	Control de errores
		ColumnaOrdenacion='',			//	Columna sobre la que se ordena
		Orden='',						//	ASC o DESC
		ColumnaOrdenada=new Array(1000);//	Indices ordenados de la columna de orden
		 		//indicador de position

jQuery(document).ready(globalEvents);

function globalEvents()
{

	ActivarPestanna("pes_TablaDatos");

	// Se selecciona un valor diferente del desplegable de tolerancias => dibujamos el cuadro con el nuevo valor
	jQuery("#tolerancia").change(function(){
		generarTabla('');
		MarcarPestannaYVerDatos();
	});

	// Se selecciona un valor diferente del desplegable de anyo inicial => dibujamos el cuadro con diferentes columnas
	jQuery("#anyo_inicial").change(function(){
		recalculaColumnas();
		MarcarPestannaYVerDatos();
	});

	// Se selecciona un valor diferente del desplegable de anyo final => dibujamos el cuadro con diferentes columnas
	jQuery("#anyo_final").change(function(){
		recalculaColumnas();
		MarcarPestannaYVerDatos();
	});

	// Se selecciona un valor diferente del desplegable TOP => dibujamos la matriz con las nuevas filas
	jQuery("#TOP").change(function(){
		EvaluarTOP();
		generarTabla('');
		MarcarPestannaYVerDatos();
	});
	
	// Click en tabla datos
	jQuery("#pes_TablaDatos").click(function()
	{
		MarcarPestannaYVerDatos();
	});

	// Click en grafico
	jQuery("#pes_Grafico").click(function()
	{
		ActivarPestanna("pes_Grafico");
		VerGrafico();
	});

	// click en SQL
	jQuery("#pes_SQL").click(function()
	{
		ActivarPestanna("pes_SQL");
		VerSQL();
	});

}

//	Activa la pestanna de Datos y muestra la tabla
function MarcarPestannaYVerDatos()
{
	ActivarPestanna("pes_TablaDatos");
	VerDatos();
};

//	5feb20
function ActivarPestanna(pestanna)
{
	jQuery(".pestannas a").attr('class', 'MenuInactivo');
	jQuery("#"+pestanna).attr('class', 'MenuActivo');
}

function TodasLineasActivas(){
	// Valor por defecto de la tolerancia es 20%
	jQuery('#tolerancia').val('0.2');

	InformarDesplegablesAnyos();

	// Marcamos todas las filas como activas
	for(var i=0;i<=NumLineas;++i)
		LineaActiva[i]='S';

	// Marcamos todas las columnas como activas
	for(i=0;i<=NumColumnas;++i)
		ColumnaActiva[i]='S';

	//	Recargamos los datos originales
	Done='N';
	PrepararTablaDatos();

	//redibujar tabla
	generarTabla();
}

//	Prepara los datos para ser enviados a la pagina con el grafico Google correspondiente
function PrepararTablaDatos(){
	var Enlace,
		CampoIndicador,
		Len,
		count=-1,
		IDGrupoActual='',
		NombreGrupoActual='',
		IDIndicadorActual='',
		NombreIndicadorActual='',
		Errores='',
		LineaActual='';


	jQuery.each(ResultadosTabla, function(key, value){
		//	Recorremos el array ResultadosTabla, sin repetir las lineas
		if(Piece(key,'|',0) == 'COLUMNA'){
			//	Comprueba si hay cambio de grupo
			if(Piece(key,'|',1) != IDGrupoActual){
				IDGrupoActual = Piece(key,'|',1);
				NombreGrupoActual=ResultadosTabla["FILA|"+IDGrupoActual];
				count=count+1;
			}
			//	Filtramos la linea de totales
			if(IDGrupoActual!='99999Total'){
				IDIndicadores[count]=IDIndicador;
				IDGrupos[count]=IDGrupoActual;
				NombresGrupos[count]=NombreGrupoActual;
				LineaActiva[count]='S';

				//	Recorremos todas las celdas de valores
				for(var k=1;k<=NumColumnas;k++){
					Valores[count*NumColumnas+k-1]=ANumero(ResultadosTabla['COLUMNA|'+IDGrupoActual+'|'+k]);
/*
					try{
						if(ResultadosTabla['ROW|'+IDIndicadorActual+'|'+IDGrupoActual+'|'+LineaActual+'|'+k+'|COLOR']=='ROJO')
							Colores[count*NumColumnas+k-1]='R';
						if(ResultadosTabla['ROW|'+IDIndicadorActual+'|'+IDGrupoActual+'|'+LineaActual+'|'+k+'|COLOR']=='VERDE')
							Colores[count*NumColumnas+k-1]='V';
						if(ResultadosTabla['ROW|'+IDIndicadorActual+'|'+IDGrupoActual+'|'+LineaActual+'|'+k+'|COLOR']=='NEGRO')
							Colores[count*NumColumnas+k-1]='N';
					}
					catch(err){
						Colores[count*NumColumnas+k-1]='?';
					}
*/
				}
			}
		}
	});
	NumLineas=count;

	// Montamos array de meses
	NombresAnnos[0] = AnyoInicio;
	for(var j=0;j<=NumColumnas-1;j++){
		NombresAnnos[j+1] = AnyoInicio + j;
//		Meses[j+1]=Piece(ListaMeses[j].mes,'/',0);
//		Annos[j+1]=Piece(ListaMeses[j].mes,'/',1);
	}
	NombresAnnos[0] = '';
/*
	NombresMeses[NumColumnas]='Total';
	Meses[NumColumnas]='99';
	Annos[NumColumnas]=Anno;
*/
	//	Ordenacion por defecto
	ColumnaOrdenacion='';
	Orden='';
	OrdenarPorColumna(NumColumnas-1);

	// Despues de hacer la ordenacion por defecto, evaluamos el desplegable TOP para mostrar el numero de lineas seleccionadas
//	if(Done == 'N' && jQuery('#TOP').length)
//		EvaluarTOP();

	Done='S';

	if (Errores!='') alert(Errores);	//solodebug!!!!
	//debugMatriz();			//solodebug: recuperamos la matriz y la mostramos en pantalla
}

//	Variables con cadenas necesarias para construir el HTML de las tablas
var cellTitleStart = '<td align="center">';
var cellTitleStartClass = '<td align="center" class="selected">';
var cellTitleStartMod = '';
var cellTitleStartIndic = '<td align="left">';
var rowIndStart = '<tr class="subTituloTabla">';
var cellIndStart = '<td align="left" colspan="' + parseInt(NumColumnas + 1) + '">&nbsp;&nbsp;';
var rowStart = '<tr class="#CLASEPAROIMPAR#">';
var rowEnd = '</tr>';
var cellGroupStart = '&nbsp;<input type="checkbox" name="CHECK_GRUPO|#IDINDICADOR#|#IDGRUPO#"/>&nbsp;&nbsp;';
var cellTotalStart = '<td align="left">&nbsp;&nbsp;&nbsp;&nbsp;';
var cellStart = '<td align="right">';
var cellEnd = '</td>';
var macroEnlaceGrupo='<a class="grupo" href="javascript:MostrarFichaAgrupacion(\'#IDGRUPO#\');">';
var macroEnlaceNormal='<a class="#CLASS#" href="javascript:MostrarEIS(\'#IDINDICADOR#\',\'#IDGRUPO#\',\'#ANNO#\');">';
var macroEnlaceTotal='<a class="grupo" href="#">';

//	Genera de forma dinamica la tabla de datos del EIS Anual
function generarTabla(){
	var formEis = document.forms[0];
	var tolerancia = jQuery('#tolerancia').val();

	var linea=0;
	var pos = 0;
	var HayOcultas='N';

	//	Total para cada indicador
	var Totales=new Array(NumColumnas);
	for(var k=1;k<=NumColumnas;k++)  Totales[k]=0;

	var Clase;
	var cellStartThis;
	var thisCellVal,lastCellVal,thisCellValAux;
	// Variables usadas para extrapolar los datos de la ultima columna para presentar colores mas reales
	var d = new Date();
        var mes = d.getMonth();
        var dia = d.getDate();

	//var cadenaHtml='<table id="TablaDatos" width="100%" class="muyoscuro" border="0" align="center" cellspacing="1" cellpadding="3" >'
	var cadenaHtml='<tr class="titleTablaEIS">';

	//cadenaHtml=cadenaHtml+ cellTitleStartIndic + '&nbsp;&nbsp;Indicadores' +cellEnd;
	cadenaHtml=cadenaHtml+cellTitleStartIndic;
	cadenaHtml=cadenaHtml+ '<span style="float:left;padding-top:5px;">&nbsp;&nbsp;&nbsp;<a href="javascript:OrdenarPorColumna(-1);">' + txtConcepto + '</a>&nbsp;&nbsp;&nbsp;&nbsp;</span>';
	cadenaHtml=cadenaHtml+BotonArribaHTML(txtTodos, 'Seleccionar', 'javascript:Seleccionar();', 50)+BotonArribaHTML(txtResultados, 'Dejar todos los seleccionados', 'javascript:Activar(true);', 50)+BotonArribaHTML(txtVolver, 'Ver todas las lineas de datos', 'javascript:TodasLineasActivas();', 50) + cellEnd;


	for(var i=1;i<=NumColumnas;i++){
/*
		if((ColumnaOrdenacion==(i-1))&&(Orden!=''))
			if (Orden=='ASC')
				EnlaceImagen='<img src="http://www.newco.dev.br/images/order_a.gif" border="false"/>';
			else
				EnlaceImagen='<img src="http://www.newco.dev.br/images/order_d.gif" border="false"/>';
                else
			EnlaceImagen='<img src="http://www.newco.dev.br/images/ordenar.gif" border="false"/>';

		cadenaHtml=cadenaHtml+ cellTitleStart +'<a href="javascript:OrdenarPorColumna('+(i-1)+');">'+ NombresMeses[i]+'&nbsp;'+EnlaceImagen+'</a>'+cellEnd;
*/
		// Si la columna esta activa, la dibujamos
		if(ColumnaActiva[i-1] == 'S'){
			if((ColumnaOrdenacion==(i-1))&&(Orden!=''))
				cellTitleStartMod = cellTitleStartClass;
			else
				cellTitleStartMod = cellTitleStart;

			cadenaHtml=cadenaHtml+ cellTitleStartMod +'<a href="javascript:OrdenarPorColumna('+(i-1)+');">'+ NombresAnnos[i]+'</a>'+cellEnd;
		}
	}
/*
     if(ResultadosTabla['MAX_LINEAS_'+IDIndicador] > 0 && ResultadosTabla['MAX_LINEAS_'+IDIndicador] != ''){
*/

	var IDIndicadorActual='';

	for(i=0;i<=NumLineas;i++){
		//	Comprueba si la linea esta activa
		if(LineaActiva[ColumnaOrdenada[i]]=='S'){
			linea++;
			pos++;

			//	Comprueba cambio de Indicador
			if(IDIndicadorActual!=IDIndicadores[ColumnaOrdenada[i]]){
				//	Muestra la linea de totales correspondiente al indicador anterior
				if(IDIndicadorActual!=''){
					//si filtramos por ratio no ensenyo totales
					cadenaHtml=cadenaHtml;

					if(ratio == 'RATIO'){
						cadenaHtml=cadenaHtml;
					}else{
						cadenaHtml=cadenaHtml+LineaTotalesHTML(IDIndicadorActual, Totales, linea, HayOcultas);
					}

					//	Inicializa la linea de totales
					for(k=1;k<=NumColumnas;k++)  Totales[k]=0;
				}

				pos=1;
				cadenaHtml=cadenaHtml+rowIndStart+cellIndStart+NombreIndicador+cellEnd+rowEnd;
				IDIndicadorActual=IDIndicadores[ColumnaOrdenada[i]];
			}

			cellStartThis=Replace(cellGroupStart,'#IDINDICADOR#',IDIndicadorActual);
			cellStartThis=Replace(cellStartThis,'#IDGRUPO#',IDGrupos[ColumnaOrdenada[i]]);
			//cellStartThis= linea+cellStartThis;
			//cellStartThis=Replace(cellStartThis,'#CLASEPAROIMPAR#',((linea%2)==0?'par':'impar'));

			//para ensenyar
			if(pos < 10){
				pos = '0'+pos;
			}

			cadenaHtml=cadenaHtml+Replace(rowStart,'#CLASEPAROIMPAR#',((linea%2)==0?'par':'impar'))+'<td align="left">'+pos+cellStartThis+Replace(macroEnlaceGrupo,'#IDGRUPO#',IDGrupos[ColumnaOrdenada[i]])+NombresGrupos[ColumnaOrdenada[i]]+'</a>'+cellEnd;

			for(k=1;k<=NumColumnas;k++){
			if(ColumnaActiva[k-1] == 'S'){
				Totales[k]=Totales[k]+Valores[ColumnaOrdenada[i]*NumColumnas+k-1];

				Enlace=macroEnlaceNormal;
				if(k == 1){
					Clase='celdanormal';
				}else if(k == NumColumnas){ // Caso última columna => extrapolamos resultados
					thisCellVal = Valores[ColumnaOrdenada[i]*NumColumnas+k-1];
					lastCellVal = Valores[ColumnaOrdenada[i]*NumColumnas+(k-1)-1];

					thisCellValAux = (thisCellVal * 365) / ((mes * 30) + dia);

					if(mes == 0) // Enero
						Clase='celdanormal';
					else if(thisCellValAux < (lastCellVal - lastCellVal * tolerancia))
						Clase='celdaconrojo';
					else if(thisCellValAux > (lastCellVal + lastCellVal * tolerancia))
						Clase='celdaconverde';
					else
						Clase='celdanormal';
				}else{
					thisCellVal = Valores[ColumnaOrdenada[i]*NumColumnas+k-1];
					lastCellVal = Valores[ColumnaOrdenada[i]*NumColumnas+(k-1)-1];

					if(thisCellVal < (lastCellVal - lastCellVal * tolerancia))
						Clase='celdaconrojo';
					else if(thisCellVal > (lastCellVal + lastCellVal * tolerancia))
						Clase='celdaconverde';
					else
						Clase='celdanormal';
				}
/*
				if(k<NumColumnas){
					Enlace=macroEnlaceNormal;
					if(Colores[ColumnaOrdenada[i]*NumColumnas+k-1]=='R')	Clase='celdaconrojo';	//cellStart=redCellStart;
					if(Colores[ColumnaOrdenada[i]*NumColumnas+k-1]=='V')	Clase='celdaconverde';	//cellStart=greenCellStart;
				}else
					Enlace=macroEnlaceNormal;
*/
				Enlace=Replace(Enlace,'#CLASS#',Clase);
				Enlace=Replace(Enlace,'#IDINDICADOR#',IDIndicadores[ColumnaOrdenada[i]]);
				Enlace=Replace(Enlace,'#IDGRUPO#',IDGrupos[ColumnaOrdenada[i]])
				//Enlace=Replace(Enlace,'#ANNOINICIO#',$('#OR_ANNO').value);
				Enlace=Replace(Enlace,'#ANNO#',NombresAnnos[k]);
//				Enlace=Replace(Enlace,'#MES#',Meses[k]);

				//cellStartThis=Replace(cellStart,'#CLASEPAROIMPAR#',((linea%2)==0?'par':'impar'));

				//formatNumbre
				//cadenaHtml=cadenaHtml+cellStart+Enlace+FormatNumber( parseFloat(Valores[ColumnaOrdenada[i]*NumColumnas+k-1]),0,',','.')+'</a>'+cellEnd;
				//cadenaHtml=cadenaHtml+cellStart+Enlace+FormatNumber(Valores[ColumnaOrdenada[i]*NumColumnas+k-1],0,',','.')+'</a>&nbsp;'+cellEnd;
				//cadenaHtml=cadenaHtml+cellStart+Enlace+Valores[ColumnaOrdenada[i]*NumColumnas+k-1]+'</a>&nbsp;'+cellEnd;

				if(Valores[ColumnaOrdenada[i]*NumColumnas+k-1] < 1 && Valores[ColumnaOrdenada[i]*NumColumnas+k-1] > 0){
					cadenaHtml=cadenaHtml+cellStart+Enlace+FormatNumber(Valores[ColumnaOrdenada[i]*NumColumnas+k-1],4,',','.')+'</a>&nbsp;'+cellEnd;
/*
					if(ConvertirPorcentaje == 'N'){
						cadenaHtml=cadenaHtml+cellStart+Enlace+FormatNumber(Valores[ColumnaOrdenada[i]*NumColumnas+k-1],4,',','.')+'</a>&nbsp;'+cellEnd;
                                        }else{
						cadenaHtml=cadenaHtml+cellStart+Enlace+FormatNumber(Valores[ColumnaOrdenada[i]*NumColumnas+k-1]*100,4,',','.')+'%</a>&nbsp;'+cellEnd;
					}
*/
				}else{
					cadenaHtml=cadenaHtml+cellStart+Enlace+FormatNumber(Valores[ColumnaOrdenada[i]*NumColumnas+k-1],4,',','.')+'</a>&nbsp;'+cellEnd;
/*
					if(ConvertirPorcentaje == 'N'){
						cadenaHtml=cadenaHtml+cellStart+Enlace+FormatNumber(Valores[ColumnaOrdenada[i]*NumColumnas+k-1],4,',','.')+'</a>&nbsp;'+cellEnd;
                                        }else{
						cadenaHtml=cadenaHtml+cellStart+Enlace+FormatNumber(Valores[ColumnaOrdenada[i]*NumColumnas+k-1]*100,4,',','.')+'%</a>&nbsp;'+cellEnd;
					}
*/
				}

				//alert(cadenaHtml);
				//return false;
                        }
			}
			cadenaHtml=cadenaHtml+rowEnd;
		}else
			HayOcultas='S';
	}
	//si filtramos por ratio no ensenyo totales
		cadenaHtml=cadenaHtml;

//	if(ratio == 'RATIO'){
//		cadenaHtml=cadenaHtml;
//	}else{
		cadenaHtml=cadenaHtml+LineaTotalesHTML(IDIndicadorActual, Totales, linea);
//	}

/*
     }else{
	cadenaHtml=cadenaHtml+'<tr><td colspan="14" align="center">'+txtSinResultados+'</td></tr>';
     }
*/

	cadenaHtml=cadenaHtml+'<tr class="subTituloTabla"><td colspan="' + (NumColumnas + 1) + '" align="left">'+BotonArribaHTML(txtTodos, 'Seleccionar', 'javascript:Seleccionar();', 50)+BotonArribaHTML(txtResultados, 'Dejar todos los seleccionados', 'javascript:Activar(true);', 50)+BotonArribaHTML(txtVolver, 'Ver todas las lineas de datos', 'javascript:TodasLineasActivas();', 50)+'</td></tr>';

	$("#TablaDatos").html(cadenaHtml);
	jQuery("#waitBox").hide();
	jQuery("#MostrarCuadro").show();
}

//	Genera la linea de totales
function LineaTotalesHTML(IDIndicador, Totales, linea, HayOcultas){
	var cadenaHtml;

	cellStartThis=Replace(cellTotalStart,'#IDINDICADOR#',IDIndicador);
	cellStartThis=Replace(cellStartThis,'#IDGRUPO#','99999Total');

	cadenaHtml=Replace(rowStart,'#CLASEPAROIMPAR#','medio')+cellStartThis+macroEnlaceTotal+'Total</a>'+cellEnd;

	for(var k=1;k<=NumColumnas;k++){
		if(ColumnaActiva[k-1] == 'S'){
			Enlace=macroEnlaceNormal;
			Enlace=Replace(Enlace,'#CLASS#','celdanormal');
			Enlace=Replace(Enlace,'#IDINDICADOR#',IDIndicador);
			Enlace=Replace(Enlace,'#IDGRUPO#','99999Total')
			Enlace=Replace(Enlace,'#ANNOINICIO#',jQuery('#OR_ANNO').value);
			Enlace=Replace(Enlace,'#ANNO#',Annos[k]);
			Enlace=Replace(Enlace,'#MES#',Meses[k]);

			cadenaHtml=cadenaHtml+cellStart+Enlace+FormatNumber( Totales[k],4,',','.')+'&nbsp;</a>'+cellEnd;
		}
	}
	cadenaHtml=cadenaHtml+rowEnd

	return cadenaHtml;
}

//	Ordena por una columna
function OrdenarPorColumna(col, reordenar){
	// Asignamos valor por defecto sino se pasa el parametro
	reordenar = typeof reordenar !== 'undefined' ? reordenar : true;

	if(reordenar !== false){
		if(ColumnaOrdenacion==col){
			if(Orden=='ASC')
				Orden='DESC';
			else
				Orden='ASC';
		}else{
			ColumnaOrdenacion=col;
			Orden='DESC';
		}
        }

	// Ordenamos por la columna 'Concepto'
	if(col == -1)
		//	Ordenar alfabeticamente respecto el array NombresGrupos[]
		ordenamientoAlfabet(Orden);
	else
		//	Ordenar sobre esta columna
		ordenamientoBurbuja(col, Orden);

	//	Redibujar tabla
	if(reordenar !== false)
		generarTabla();
}

//	Prepara un array con los ordenes correspondientes a una columna
//	PENDIENTE: separar ordenaciï¿½n segun indicador
function ordenamientoBurbuja(col, tipo){
	var NumLineasAux;
/*
	// DC - 21/11/13 - Si hay fila totales, esta no se cuenta para ordenar
	if(mostrarFilaTotal == 'S')
		NumLineasAux = NumLineas -1;
	else
		NumLineasAux = NumLineas;
*/
	NumLineasAux = NumLineas;

	for(var i=0; i<=NumLineas; i++)
		ColumnaOrdenada[i]=i;

	for(i=0; i<=NumLineasAux; i++){
		for(var j=i+1; j<=NumLineasAux; j++){
			if(Valores[ColumnaOrdenada[i]*NumColumnas+col] > Valores[ColumnaOrdenada[j]*NumColumnas+col]){
				temp=ColumnaOrdenada[j];
				ColumnaOrdenada[j]=ColumnaOrdenada[i];
				ColumnaOrdenada[i]=temp;
			}
		}
	}

	//	En caso de ordenaciï¿½n descendente intercambiamos de forma simï¿½trica el vector de ordenacion
	if(tipo=='DESC'){
		for(i=0; i<=NumLineasAux/2; i++){
			temp=ColumnaOrdenada[NumLineasAux-i];
			ColumnaOrdenada[NumLineasAux-i]=ColumnaOrdenada[i];
			ColumnaOrdenada[i]=temp;
		}
	}

	//debug	var depurar='';
	//debug	for (i=0; i<=NumLineas; i++)
	//debug		depurar=depurar+NombresGrupos[ColumnaOrdenada[i]]+':'+Valores[ColumnaOrdenada[i]*13+col]+'\n';
	//debug
	//debug	alert('Ordenaciï¿½n:'+depurar);
}

function ordenamientoAlfabet(tipo){
	var NumLineasAux;
	// DC - 21/11/13 - Si hay fila totales, esta no se cuenta para ordenar
/*
	if(mostrarFilaTotal == 'S')
		NumLineasAux = NumLineas-1;
	else
		NumLineasAux = NumLineas;
*/
	NumLineasAux = NumLineas;

	for(var i=0; i<=NumLineas; i++)
		ColumnaOrdenada[i]=i;

	for(i=0; i<=NumLineasAux; i++){
		for(var j=i+1; j<=NumLineasAux; j++){
			if(NombresGrupos[i] > NombresGrupos[j]){
				temp=ColumnaOrdenada[j];
				ColumnaOrdenada[j]=ColumnaOrdenada[i];
				ColumnaOrdenada[i]=temp;
			}
		}
	}

	//	En caso de ordenacion descendente intercambiamos de forma simetrica el vector de ordenacion
	if(tipo=='DESC'){
		for(i=0; i<=NumLineasAux/2; i++){
			temp=ColumnaOrdenada[(NumLineasAux)-i];
			ColumnaOrdenada[(NumLineasAux)-i]=ColumnaOrdenada[i];
			ColumnaOrdenada[i]=temp;
		}
	}
}

function BotonArribaHTML(texto, explicacion, funcion, ancho){
	var cadenaHtml='<table class="button" style="float:left;"  cellpadding="0" cellspacing="1" width="'+ancho+'"><tr><td align="center" valign="middle"><a href="#" onclick="'+funcion+'" >'+texto+'</a></td></tr></table>';
	return cadenaHtml;
}

//	Elimina el punto de una cadena y convierte ',' a '.' para poder convertir a numero
function ANumero(Cadena){
	//alert(Cadena+'::'+PreparaNumero(Cadena)+'::'+parseFloat(PreparaNumero(Cadena))+'::'+parseFloat(Cadena));
	return(parseFloat(PreparaNumero(Cadena)));
}

//	Elimina el punto de una cadena y convierte ',' a '.' para poder convertir a numero
function PreparaNumero(Cadena){
	var	Res='';

	try
	{
		for (i=0;i<Cadena.length;++i)
		{
			if (Cadena.charAt(i)!='.')
			{
				if (Cadena.charAt(i)!=',')
					Res=Res+Cadena.charAt(i);
				else
					Res=Res+'.';
			}
		}
	}
	catch(err)
	{
		Errores=Errores+'PreparaNumero: parámetro vacio:'+err+'\n';
	}
	//alert(Res);
	return Res;
}

//	Da formato a un numero decimal
function FormatNumber(number, decimals, dec_point, thousands_sep){

	// 14/05/13 - DC - Calculamos los decimales a mostrar segun el valor de number
	// number = 0	=> 0 decimales
	// number < 10	=> 2 decimales
	// number < 100	=> 1 decimal
	// number > 100	=> 0 decimales
        if(number == 0)			decimals = 0;
	else if(Math.abs(number) < 10)	decimals = 2;
        else if(Math.abs(number) < 100)	decimals = 1;
        else				decimals = 0;

	var n = !isFinite(+number) ? 0 : +number,
		prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
		sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,        dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
		s = '',
		toFixedFix = function (n, prec) {
			var k = Math.pow(10, prec);
			return '' + Math.round(n * k) / k;
		};

	// Fix for IE parseFloat(0.55).toFixed(0) = 0;
	s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
	if(s[0].length > 3){
		s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
	}
	if((s[1] || '').length < prec){
		s[1] = s[1] || '';
		s[1] += new Array(prec - s[1].length + 1).join('0');
	}

	return s.join(dec);
}

// needle may be a regular expression
function Replace(haystack, needle, replacement){
	var r = new RegExp(needle, 'g');
	return haystack.replace(r, replacement);
}

// Peticion ajax que devuelve las opciones del desplegable de 'Centros' dada una Empresa (IDEMPRESA)
// Si el desplegable existe, se cambian los elementos option
// Si el desplegable no existe todavia, se crean una nueva fila en la tabla con el select correspondiente
function ListaCentrosDeEmpresa(id,idEmpresa){
	var sql = encodeURIComponent(' ' + FiltroSQL.replace(/\'/g, "''"));
//	var IDIndicadorSelec = jQuery('#IDCUADROMANDO').val();

	// Inhabilitamos los desplegables para los 5 niveles ya que hemos elegido una nueva empresa
	VaciaNiveles('CAT');

	// Si elegimos alguna de las opciones guardadas de seleccion, no se lanza peticion ajax
	if(idEmpresa.substr(0,4) == 'SEL_')
		return;

	jQuery.ajax({
		cache:	false,
		url:	'EISAnualCentrosEmpresa.xsql',
		type:	"GET",
		data:	"IDEmpresa="+idEmpresa+"&IDIndicador="+IDIndicador+"&FiltroSQL="+sql,
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.ListaCentros.length > 0){
				// Si el desplegable ya existe (a causa de una peticion previa), lo vaciamos...
				if(jQuery("select#" + data.Field.name).length > 0){
					jQuery("#" + data.Field.name).empty();
					jQuery("#" + data.Field.name).removeAttr('disabled');
				}

				for(i=0;i<data.ListaCentros.length;i++){
					jQuery("#" + data.Field.name).append("<option value='"+data.ListaCentros[i].id+"'>"+data.ListaCentros[i].nombre+"</option>");
					jQuery("#" + data.Field.name).val("-1");
				}
				// Una vez termina de informar el desplegable de centros => hacemos peticion para los desplegables del catalogo privado
				NivelesEmpresa(idEmpresa,'CAT');
			}
		}
	});
}

// Peticion ajax que devuelve los valores de las marcas <MOSTRARCATEGORIAS> y <MOSTRARGRUPOS> para la empresa seleccionada
// De esta manera construimos los desplegables de los diferentes niveles segun corresponda
function NivelesEmpresa(IDPadre,nivel){
	// Si elegimos alguna de las opciones guardadas de seleccion, no se lanza peticion ajax
	if(IDPadre !== null && IDPadre.substr(0,4) == 'SEL_')
		return;

	// Si existe #IDEMPRESA => usuario MVM o MVMB 
	if(jQuery("#IDEMPRESA").length > 0){
		var idEmpresa = jQuery("#IDEMPRESA").val();
	// Si NO existe #IDEMPRESA => Cliente
        }else
		var idEmpresa = IDEmpresaDelUsuario;

	jQuery.ajax({
		cache:	false,
		url:	'EISNivelesEmpresa.xsql',
		type:	"GET",
		data:	"IDEmpresa="+idEmpresa,
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data		= eval("(" + objeto + ")");
			var IDEmpresa		= data.NivelesEmpresa.IDEmpresa;
			var mostrarCategoria	= data.NivelesEmpresa.MostrarCategorias;
			var mostrarGrupo	= data.NivelesEmpresa.MostrarGrupos;

			if(nivel == 'CAT'){
				if(mostrarCategoria == 'S'){
					ListaNivel(IDEmpresa,'CAT');
				}else{
					ListaNivel(IDEmpresa,'FAMEMP');
				}
			}else if(nivel == 'GRU'){
				if(mostrarGrupo == 'S'){
					ListaNivel(IDPadre,'GRU');
				}else{
					ListaNivel(IDPadre,'PROSF');
				}
			}
		}
	});
}

function VaciaNiveles(nivel){
	switch(nivel){
		case 'CAT':
			jQuery("#IDCATEGORIA").attr("disabled", "disabled");
			jQuery("#IDCATEGORIA").empty().append('<option value="-1" selected="selected"> [Todas] </option>');
		case 'FAM':
			jQuery("#IDFAMILIA").attr("disabled", "disabled");
			jQuery("#IDFAMILIA").empty().append('<option value="-1" selected="selected"> [Todas] </option>');
		case 'SF':
			jQuery("#IDSUBFAMILIA").attr("disabled", "disabled");
			jQuery("#IDSUBFAMILIA").empty().append('<option value="-1" selected="selected"> [Todas] </option>');
		case 'GRU':
			jQuery("#IDGRUPO").attr("disabled", "disabled");
			jQuery("#IDGRUPO").empty().append('<option value="-1" selected="selected"> [Todas] </option>');
		case 'PRO':
			jQuery("#IDPRODUCTOESTANDAR").attr("disabled", "disabled");
			jQuery("#IDPRODUCTOESTANDAR").empty().append('<option value="-1" selected="selected"> [Todas] </option>');
			break;
	}
}

// Peticion ajax que devuelve una lista segun el nivel que se pida (Categorias, Familias, Subfamilias, Grupos o Productos Estandar)
// Se crean las filas y los menus desplegables segun corresponda
function ListaNivel(IDPadre,tipo){
	// Si elegimos alguna de las opciones guardadas de seleccion, no se lanza peticion ajax
	if(IDPadre.substr(0,4) == 'SEL_')
		return;

	var sql = encodeURIComponent(' ' + FiltroSQL.replace(/\'/g, "''"));
	var IDEmpresa;
	//var IDIndicadorSelec = jQuery('#IDCUADROMANDO').val();

	// Si existe #IDEMPRESA => usuario MVM o MVMB 
	if(jQuery("#IDEMPRESA").length > 0){
		IDEmpresa = jQuery("#IDEMPRESA").val();
	// Si NO existe #IDEMPRESA => Cliente
        }else
		IDEmpresa = IDEmpresaDelUsuario;

	jQuery.ajax({
		cache:	false,
		url:	'EISAnualListaNivel.xsql',
		type:	"GET",
		data:	"IDEmpresa="+IDEmpresa+"&IDPadre="+IDPadre+"&IDIndicador="+IDIndicador+"&FiltroSQL="+sql+"&Tipo="+tipo,
//		data:	"IDEmpresa="+IDEmpresa+"&IDPadre="+IDPadre+"&IDIndicador="+IDIndicador+"&Tipo="+tipo,
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(tipo == 'CAT'){
				if(jQuery('#' + data.Field.name).length > 0){
					VaciaNiveles('FAM');
					jQuery("#" + data.Field.name).empty();
					jQuery("#" + data.Field.name).removeAttr("disabled");
					jQuery("#" + data.Field.name).unbind('change').bind('change',function(){ ListaNivel(this.value,'FAM'); });
				}
			}else if(tipo == 'FAM'){
				if(jQuery('#' + data.Field.name).length > 0){
					VaciaNiveles('SF');
					jQuery("#" + data.Field.name).empty();
					jQuery("#" + data.Field.name).removeAttr("disabled");
					jQuery("#" + data.Field.name).unbind('change').bind('change',function(){ ListaNivel(this.value,'SF'); });
				}
			}else if(tipo == 'FAMEMP'){
				if(jQuery('#' + data.Field.name).length > 0){
					jQuery("#IDCATEGORIA").attr("disabled", "disabled");
					VaciaNiveles('SF');
					jQuery("#" + data.Field.name).empty();
					jQuery("#" + data.Field.name).removeAttr("disabled");
					jQuery("#" + data.Field.name).unbind('change').bind('change',function(){ ListaNivel(this.value,'SF'); });
				}
			}else if(tipo == 'SF'){
				if(jQuery('#' + data.Field.name).length > 0){
//					VaciaNiveles('GRU');
					jQuery("#" + data.Field.name).empty();
					jQuery("#" + data.Field.name).removeAttr("disabled");
//					jQuery("#" + data.Field.name).unbind('change').bind('change',function(){ NivelesEmpresa(this.value,'GRU'); });
				}
			}/*else if(tipo == 'GRU'){
				if(jQuery('#' + data.Field.name).length > 0){
					VaciaNiveles('PRO');
					jQuery("#" + data.Field.name).empty();
					jQuery("#" + data.Field.name).removeAttr("disabled");
					jQuery("#" + data.Field.name).unbind('change').bind('change',function(){ ListaNivel(this.value,'PRO'); });
				}
			}else if(tipo == 'PROSF'){
				if(jQuery('#' + data.Field.name).length > 0){
					jQuery("#IDGRUPO").attr("disabled", "disabled");
					jQuery("#" + data.Field.name).empty();
					jQuery("#" + data.Field.name).removeAttr("disabled");
				}
			}else if(tipo == 'PRO'){
				if(jQuery('#' + data.Field.name).length > 0){
					jQuery("#" + data.Field.name).empty();
					jQuery("#" + data.Field.name).removeAttr("disabled");
				}
			}
*/
			for(var i=0;i<data.ListaNivel.length;i++){
				jQuery("#" + data.Field.name).append("<option value='"+data.ListaNivel[i].id+"'>"+data.ListaNivel[i].nombre+"</option>");
				jQuery("#" + data.Field.name).val("-1");
			}
		}
	});
}

// Peticion ajax que devuelve las opciones del desplegable de 'Centros de Cliente' dado un Centro (IDEMPRESA2)
// Si el desplegable existe, se cambian los elementos option
// Si el desplegable no existe todavia, se crean una nueva fila en la tabla con el select correspondiente
function ListaCentrosDeCliente(id,idCliente){
	// Si elegimos alguna de las opciones guardadas de seleccion, no se lanza peticion ajax
	if(idCliente.substr(0,4) == 'SEL_')
		return;

	var sql = encodeURIComponent(' ' + FiltroSQL.replace(/\'/g, "''"));

	jQuery.ajax({
		cache:	false,
		url:	'EISAnualCentrosCliente.xsql',
		type:	"GET",
		data:	"IDEmpresa="+idCliente+"&IDCliente="+idCliente+"&IDIndicador="+IDIndicador+"&FiltroSQL="+sql,
//		data:	"IDEmpresa="+idCliente+"&IDCliente="+idCliente+"&IDIndicador="+IDIndicador,
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.ListaCentros.length > 0){
				// Si el desplegable ya existe (a causa de una peticion previa), lo vaciamos...
				if(jQuery("select#" + data.Field.name).length > 0){
					jQuery("#" + data.Field.name).empty();
					jQuery("#" + data.Field.name).removeAttr('disabled');
				}

				for(i=0;i<data.ListaCentros.length;i++){
					jQuery("#" + data.Field.name).append("<option value='"+data.ListaCentros[i].id+"'>"+data.ListaCentros[i].nombre+"</option>");
					jQuery("#" + data.Field.name).val("-1");
				}
			}
		}
	});
}

//	Recorre los controles y activa los checkboxes de los Grupos
 function Seleccionar(){
	var form=document.forms[0];
	var Estado=null;

	for(var i=0;(i<form.length)&&(Estado==null);i++){
		var k=form.elements[i].name;

		if(k.substring(0,12)=='CHECK_GRUPO|'){
			if(form.elements[i].checked == true )
				Estado=false;
			else
				Estado=true;
		}
	}

	for(var i=0;i<form.length;i++){
		var k=form.elements[i].name;

		if(k.substring(0,12)=='CHECK_GRUPO|'){
			form.elements[i].checked = Estado;
			//alert(form.elements[i].name+' vrvr '+form.elements[i].value);
		}
	}
}//fin seltodosClientes

//	Marca los Indicadores/grupos que deben dejarse y vuelve a presentar la tabla
//	Valor=true:dejar, Valor=false:quitar
function Activar(Valor){
	var form=document.forms[0];

	if(Done=='N')	PrepararTablaDatos();

	for(j=0;j<form.elements.length;j++){

		if(form.elements[j].name.substring(0,12)=='CHECK_GRUPO|'){
			var	IDIndicador=Piece(form.elements[j].name,'|',1);
			var	IDGrupo=Piece(form.elements[j].name,'|',2);
			var	Pos=BuscaPosicion(IDIndicador, IDGrupo);

			if(Valor==true)	//	DEJAR
				if(form.elements[j].checked==true){
					LineaActiva[Pos]='S';
				}else
					LineaActiva[Pos]='N';
			else				//	QUITAR
				if(form.elements[j].checked==true)
					LineaActiva[Pos]='N';
		}
	}

	//	Si no hay lineas marcadas como activas no mostramos la tabla
	if(CompruebaLineasActivas()=='N'){
		alert('Es necesario que haya alguna linea activa');
		return;
	}

	//redibujar tabla
	generarTabla();
}

//	Busca a que linea se corresponde un par Indicador/Grupo 
function BuscaPosicion(IDIndicador, IDGrupo){
	var Pos=-1;

	for(i=0;i<=NumLineas;i++){
		if((IDIndicadores[i]==IDIndicador)&&(IDGrupos[i]==IDGrupo))
			Pos=i;
	}

	return Pos;
}

function CompruebaLineasActivas()
{
	for (var j=0;j<=NumLineas;j++)
		if (LineaActiva[j]=='S') return 'S';
	return 'N';
}

function VerDatos()
{
	$("#TablaDatos").show();
	$("#Grafico").hide();
	$("#SQL").hide();
	
	//document.getElementById('datosEIS').style.display ='none';
	//document.getElementById('graficoEIS').style.display ='block';
	//document.getElementById('sqlEIS').style.display ='block';
}

function VerGrafico()
{

	//GraficoGoogle();
	datosParaGrafico();

	$("#TablaDatos").hide();
	$("#Grafico").show();
	$("#SQL").hide();
	
	//document.getElementById('datosEIS').style.display ='block';
	//document.getElementById('graficoEIS').style.display ='none';
	//document.getElementById('sqlEIS').style.display ='block';
}

/*
//	Prepara los datos para ser enviados a la pagina con el grï¿½fico Google correspondiente
function GraficoGoogle(){
	if (Done=='N')	PrepararTablaDatos();

	var arrData = new Array();	// 2D array
	var arrAux  = new Array();	// 1D array

	// Preparamos el array de clientes para la leyenda
	arrAux.push('Clientes');
	for(var i=0;i<=NumLineas;i++){
		if (LineaActiva[i]=='S')
			arrAux.push(NombresGrupos[i]);
	}
	arrData.push(arrAux);	// Se coloca en el primer campo del array de 2D

	// Preparamos los diversos arrays
	for(i=0;i<NumColumnas;i++){
		if(ColumnaActiva[i] == 'S'){
			arrAux = [];
			arrAux.push(parseInt(NombresAnnos[i+1]));

			var linea=1;	//	contamos lineas visibles
			for(var l=0;l<=NumLineas;l++){
				if(LineaActiva[l]=='S'){
					arrAux.push(Valores[l*NumColumnas+i]);
					linea++;
				}
			}
			arrData.push(arrAux);
        }
	}

	var data = google.visualization.arrayToDataTable(arrData); //	Pasamos el array de datos para que lo convierta a tabla google chart

	// Set chart options
	var options = {
		fontSize:10,
		pointSize:3,	// Para que se vean los puntos de los datos en la grafica y se visualizen con roll-over
		width:1000,
		height:550,
		vAxis:{viewWindowMode: 'maximized'},
		legend:{position: 'right', textStyle: {color: 'black', fontSize: 8}}
	};

	// Instantiate and draw our chart, passing in some options.
	var chart = new google.visualization.LineChart(document.getElementById('graficoGoogle'));
	chart.draw(data, options);
}
*/

function TablaEISAnualAjax(){
	guardarValoresForm();

	// Por defecto los resultados del EIS se agrupan por Empresa (excepto admins - MVM o MVMB)
	if(userDerechos != 'S')
		if(AgruparPor == '-1')	AgruparPor = 'EMP';

	jQuery.ajax({
		cache:	false,
		url:	'EISAnual_ajax.xsql',
		type:	"GET",
		data:	"IDEMPRESA="+IDEmpresa+"&IDCENTRO="+IDCentro+"&IDEMPRESA2="+IDEmpresa2+"&IDCENTRO2="+IDCentro2+"&IDFAMILIA="+IDFamilia+"&IDCATEGORIA="+IDCategoria+"&AGRUPARPOR="+AgruparPor,
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			jQuery("#MostrarCuadro").hide();
			jQuery("#waitBox").show();
		},
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			// Forzamos visualizar la tabla de datos
			console.log('TablaEISAnualAjax.VerDatos');
			VerDatos();
			console.log('TablaEISAnualAjax.Fin VerDatos');

			// Redefinimos las variables de los anyos para la cabecera de la tabla y para los desplegables
			AnyoInicio	= parseInt(data.DatosEIS[0].AnnoInicio);
			AnyoInicio_sel	= AnyoInicio;
			AnyoFinal	= parseInt(data.DatosEIS[0].AnnoFinal);
			AnyoFinal_sel	= AnyoFinal;
			NumColumnas	= AnyoFinal - AnyoInicio + 1;
			ColumnaActiva	= new Array(NumColumnas);

			// Colocamos el nuevo nombre del indicador en la cabecera de la pagina
			console.log('TablaEISAnualAjax.Fin NombreIndicador');
			NombreIndicador		= data.DatosEIS[1].Indicador.nombre;

			console.log('TablaEISAnualAjax.NombreIndicador');
			jQuery('span#NombreIndicador').html(NombreIndicador);

			// Redefinimos el objeto Resultados para la tabla, la grafica, etc....
			IDIndicador		= data.DatosEIS[1].Indicador.id;
			IDCuadro		= data.DatosEIS[1].Indicador.idCuadro;

			ResultadosTabla	= {};
//			ResultadosTabla['INDICADOR|'+data.DatosEIS[1].Indicador[0].id]	= data.DatosEIS[1].Indicador[0].nombre;
//			ResultadosTabla['MAX_LINEAS_'+data.DatosEIS[1].Indicador[0].id]= data.DatosEIS[3].MaxLineas;
			if(data.DatosEIS[3].MaxLineas != ''){
				jQuery.each(data.DatosEIS[2].Filas, function(arrayFilaID, fila){
					ResultadosTabla['FILA|'+fila.IDGrupo] = fila.NombreGrupo;

					jQuery.each(fila.Columnas, function(arrayColID, columna){
						ResultadosTabla['COLUMNA|'+fila.IDGrupo+'|'+columna.Columna] = columna.Total;
//						ResultadosTabla['COLUMNA|'+fila.IDGrupo+'|'+columna.Columna] = columna.Color;
					});
				});
			}

			//	Preparamos los datos en las variables y mostramos el cuadro
			console.log('TablaEISAnualAjax.TodasLineasActivas');
			TodasLineasActivas();
		}
	});
}

function guardarValoresForm(){
//	IDCuadro	= jQuery("#IDCUADROMANDO").val();
	Anno		= jQuery("#ANNO").val();
	if(jQuery("#IDEMPRESA").length > 0)
		IDEmpresa = jQuery("#IDEMPRESA").val();
	else
		IDEmpresa = IDEmpresaDelUsuario;
	if(jQuery("#IDCENTRO").length > 0)
		IDCentro = jQuery("#IDCENTRO").val();
	else
		IDCentro = -1;

	if(jQuery("#IDUSUARIO").length > 0)
		IDUsuarioSel = jQuery("#IDUSUARIO").val();
	else
		IDUsuarioSel = -1;

	if(jQuery("#IDEMPRESA2").length > 0)
		IDEmpresa2		= jQuery("#IDEMPRESA2").val();
	else
		IDEmpresa2		= -1;
	if(jQuery("#IDCENTRO2").length > 0)
		IDCentro2 = jQuery("#IDCENTRO2").val();
	else
		IDCentro2 = -1;
	if(jQuery("#IDPRODUCTOESTANDAR").length > 0)
		IDProducto		= jQuery("#IDPRODUCTOESTANDAR").val();
	else
		IDProducto		= -1;
	if(jQuery("#IDGRUPO").length > 0)
		IDGrupo = jQuery("#IDGRUPO").val();
	else
		IDGrupo = -1;
	if(jQuery("#IDSUBFAMILIA").length > 0)
		IDSubfamilia		= jQuery("#IDSUBFAMILIA").val();
	else
		IDSubfamilia		= -1;
	if(jQuery("#IDFAMILIA").length > 0)
		IDFamilia		= jQuery("#IDFAMILIA").val();
	else
		IDFamilia		= -1;
	if(jQuery("#IDCATEGORIA").length > 0)
		IDCategoria = jQuery("#IDCATEGORIA").val();
	else
		IDCategoria = -1;
	IDEstado		= jQuery("#IDESTADO").val();
	Referencia		= jQuery("#REFERENCIA").val();
	Codigo			= jQuery("#CODIGO").val();
	AgruparPor		= jQuery("#AGRUPARPOR").val();
	IDResultados		= jQuery("#IDRESULTADOS").val();
	IDRatio			= jQuery("#IDRATIO").val();

	return;
}

//	Presenta la pagina del EIS correspondiente a la seleccion del usuario
//	Si hay lineas ocultas, pasar la lista de empresas concatenada
function MostrarEIS(Indicador, Grupo, Anno)
{
	var Enlace;

	if ((Grupo=='99999Total') && (CompruebaLineasOcultas()=='S'))
		Cadena=ListaLineasActivas();
	else
		Cadena=Grupo;	

	guardarValoresForm();

	if(AgruparPor == 'EMP')
		IDEmpresa = Grupo;
	else if(AgruparPor == 'CEN')
		IDCentro = Grupo;
	else if(AgruparPor == 'EMP2')
		IDEmpresa2 = Grupo;
	else if(AgruparPor == 'CEN2')
		IDCentro2 = Grupo;
	else if(AgruparPor == 'CAT')
		IDCategoria = Grupo;
	else if(AgruparPor == 'FAM')
		IDFamilia = Grupo;

	Enlace='http://www.newco.dev.br/Gestion/EIS/EISDatos2.xsql?'
//			+'US_ID='+IDUsuario
//			+'&'+'IDINDICADOR='+Indicador
			+'IDCUADROMANDO='+IDCuadro
			+'&'+'ANNO='+Anno
			+'&'+'IDEMPRESA='+IDEmpresa
			+'&'+'IDCENTRO='+IDCentro
			+'&'+'IDUSUARIO='
			+'&'+'IDEMPRESA2='+IDEmpresa2
			+'&'+'IDCENTRO2='+IDCentro2
			+'&'+'IDPRODUCTO=-1'
			+'&'+'IDGRUPOCAT=-1'
			+'&'+'IDSUBFAMILIA=-1'
			+'&'+'IDFAMILIA='+IDFamilia
			+'&'+'IDCATEGORIA='+IDCategoria
			+'&'+'IDESTADO=-1'
			//+'&'+'IDTIPOINCIDENCIA='+form.elements['OR_IDTIPOINCIDENCIA'].value
			//+'&'+'IDGRAVEDAD='+form.elements['OR_IDGRAVEDAD'].value
			+'&'+'REFERENCIA='
			+'&'+'CODIGO='
			//+'&'+'IDNOMENCLATOR='+
			//+'&'+'URGENCIA='+
			+'&'+'AGRUPARPOR='+AgruparPor;
//			+'&'+'IDGRUPO='+Cadena;		//	Grupo;

	MostrarPagPersonalizada(Enlace,'EIS',100,100,0,0);
}

function InformarDesplegablesAnyos(){
	var num = 5;	// Cada desplegable contendra 3 opciones

	// Resetear desplegables de anyos
	jQuery('#anyo_inicial').empty();
	jQuery('#anyo_final').empty();

	// Informamos el desplegable de anyo de inicio
	for(var i=AnyoInicio; i<(AnyoInicio + num); i++){
		if(i <= AnyoFinal){
			jQuery('#anyo_inicial').append(jQuery('<option></option>').val(i).html(i));
		}
	}
	jQuery('#anyo_inicial').val(AnyoInicio_sel);

	// Informamos el desplegable de anyo final
	for(i=AnyoFinal; i>(AnyoFinal - num); i--){
		if(i >= AnyoInicio){
			jQuery('#anyo_final').append(jQuery('<option></option>').val(i).html(i));
		}
	}
	jQuery('#anyo_final').val(AnyoFinal_sel);
}

// Redibujamos la tabla escondiendo las columnas (anyos) que no estan dentro de la seleccion
function recalculaColumnas(){
	AnyoInicio_sel	= jQuery('#anyo_inicial').val();
	AnyoFinal_sel	= jQuery('#anyo_final').val();

	for(var i=0; i<=NumColumnas; i++){
		if(NombresAnnos[i+1] < AnyoInicio_sel || NombresAnnos[i+1] > AnyoFinal_sel){
			ColumnaActiva[i] = 'N';
		}else{
			ColumnaActiva[i] = 'S';
		}
	}

	generarTabla();

	// Si estamos visualizando el grafico
	if(jQuery('#Grafico').is(':visible')){
		GraficoGoogle();
	}
}

function EvaluarTOP(){
	var TOP = jQuery('#TOP').val();
	var i;

	// Si no se muestran todas las filas
	if(TOP != -1){
		// Ordenar previamente segun columna 'total' (12) para marcar los valores TOP correctamente segun el array LineaActiva 
//		OrdenarPorColumna(12, false);

		for(i=0; i<TOP; i++){
			LineaActiva[ColumnaOrdenada[i]] = 'S';
		}
		for(i=TOP; i<=NumLineas; i++){
			LineaActiva[ColumnaOrdenada[i]] = 'N';
		}

		// Volvemos a ordenar las LineaActiva visibles segun el criterio seleccionado por el usuario
//		OrdenarPorColumna(ColumnaOrdenacion, false);

	}else{
		for(i=0; i<=NumLineas; i++){
			LineaActiva[i] = 'S';
		}
	}
}


//
//	Nuevo gráfico chartjs
//

//	Paleta de colores, para hasta 40 líneas
var PaletaColores=['#0932F0','#204A87','#F00923','#48DAF1','#2EF953','#F28C87','#7C8486','#8F5902','#C17D11','#E9B96E','#EDD400',
'#729FCF','#73D216','#F57900','#FCE94F','#888A85','#A40000','#8F5902','#729FCF','#5C3566','#C4A000','#8AE234',
'#555753','#AD7FA8','#F4F137','#F4373B','#74A4E1','#CE259E','#873570','#F76E0B','#80CD18','#7279A5','#4F209F',
'#2E3436','#C6C44E','#3465A4','#F5902D','#A4EC43','#939EDC','#A37FE0','#7FE0CB','#516E94','#EB090E','#E32FCF'];

function preparaGrafico(filas, labels) 
{
	var Cadena="var ctx = document.getElementById('cvGrafico').getContext('2d');var myChart = new Chart(ctx, {type: 'line',data: {labels: labels,datasets: [";
	
	
	for (i=0;i<filas.length;++i)
	{
		Cadena+=((i==0)?'':',')+"{label: '"+filas[i].nombre+"', borderColor: \""+filas[i].color+"\", data: [";
		for  (j=0;j<filas[i].data.length;++j)
			Cadena+=((j==0)?'':',')+filas[i].data[j];
		
		Cadena+="]}";
		//solodebug console.log("PruebaRender("+i+"):"+Cadena);
	}
	//Cadena+="],options: {responsive: true,scales: {yAxes: [{ticks: {min:0, max:10000000, stepSize: 1000000,beginAtZero:true}}]}}}});"
	Cadena+="],options: {responsive: true,scales: {yAxes: [{ticks: {min:0, beginAtZero:true}}]}}}});"			//TODAVIA NO ESTA FUNCIONANDO PONER EL ORIGEN A 0
	
	//solodebug console.log("PruebaRender2:"+Cadena);
	
	return eval(Cadena);
}


//	5feb20 Preparar los datos desde los arrays JS para mostrarlos en el gráfico
function datosParaGrafico()
{
	if (Done=='N')	PrepararTablaDatos();

	var filas = new Array();	// 2D array
	var labels  = new Array();	// 1D array

	// etiquetas de meses
	for(i=0;i<NumColumnas;i++)
	{
		//	Quitar la columna activa del gráfico genera muchos problemas if(ColumnaActiva[i] == 'S'){
		labels.push(parseInt(NombresAnnos[i+1]));
	}
	
	//	Nombres de grupos y filas de datos
	for(var l=0;l<=NumLineas;l++)
	{
		if(LineaActiva[l]=='S')
		{
		
			console.log('datosParaGrafico. LineaActiva ('+l+')');
		
			var fila=[];
			var datos=[];
			var cadDatos='';
			for(i=0;i<NumColumnas;i++)
			{
				//	Quitar la columna activa del gráfico genera muchos problemas if(ColumnaActiva[i] == 'S'){
				datos[i]=Valores[l*NumColumnas+i];
	
				cadDatos+=datos[i]+'.';
				console.log('datosParaGrafico. LineaActiva, dato('+l+','+i+'):'+datos[i]);
			}
			fila["data"]=datos;
			fila["color"]=PaletaColores[l%40];
			fila["nombre"]=NombresGrupos[l];
			
			console.log('datosParaGrafico. LineaActiva ('+l+'):'+NombresGrupos[l]+':'+cadDatos);
		
			filas.push(fila);
		}
	}
	
	preparaGrafico(filas, labels);
}
/*
function GraficoGoogle(){
	if (Done=='N')	PrepararTablaDatos();

	var arrData = new Array();	// 2D array
	var arrAux  = new Array();	// 1D array

	// Preparamos el array de clientes para la leyenda
	arrAux.push('Clientes');
	for(var i=0;i<=NumLineas;i++){
		if (LineaActiva[i]=='S')
			arrAux.push(NombresGrupos[i]);
	}
	arrData.push(arrAux);	// Se coloca en el primer campo del array de 2D

	// Preparamos los diversos arrays
	for(i=0;i<NumColumnas;i++){
		if(ColumnaActiva[i] == 'S'){
			arrAux = [];
			arrAux.push(parseInt(NombresAnnos[i+1]));

			var linea=1;	//	contamos lineas visibles
			for(var l=0;l<=NumLineas;l++){
				if(LineaActiva[l]=='S'){
					arrAux.push(Valores[l*NumColumnas+i]);
					linea++;
				}
			}
			arrData.push(arrAux);
        }
	}

	var data = google.visualization.arrayToDataTable(arrData); //	Pasamos el array de datos para que lo convierta a tabla google chart

	// Set chart options
	var options = {
		fontSize:10,
		pointSize:3,	// Para que se vean los puntos de los datos en la grafica y se visualizen con roll-over
		width:1000,
		height:550,
		vAxis:{viewWindowMode: 'maximized'},
		legend:{position: 'right', textStyle: {color: 'black', fontSize: 8}}
	};

	// Instantiate and draw our chart, passing in some options.
	var chart = new google.visualization.LineChart(document.getElementById('graficoGoogle'));
	chart.draw(data, options);
}
*/
