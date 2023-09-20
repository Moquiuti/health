// JavaScript Document
//	7jul11	11:13

//	Datos globales: matriz de datos del EIS, maximo 1000 lineas
var		NumLineas,					//	Numero de lineas de la tabla (la ultima contiene el total)
		IDGrupos=new Array(1000),
		NombresGrupos=new Array(1000),		//	Nombre del grupo (linea)
		IDIndicadores=new Array(1000),		//	Indicador para cada linea de la tabla
		NombresIndicadores=new Array(1000),		//	Indicador para cada linea de la tabla
		Val=new Array(13000),				//	Array de ayuda para saber que valores mostrar
		Valores=new Array(13000),			//	Matriz de valores (Grupos * Meses)
		ValoresNormV=new Array(13000),			//	Matriz de valores normalizados verticalmente
		ValoresNormH=new Array(13000),			//	Matriz de valores normalizados horizontalmente
		ComCol=new Array(13000),			//	Matriz de colores de background -- comentarios (Grupos * Meses)
		Comentarios=new Array(13000),			//	Matriz de comentarios (Grupos * Meses)
		Colores=new Array(13000),			//	Matriz de colores de fuente(Grupos * Meses)
		//Valor,
		NombresCabeceraH=new Array(NumCabeceraH),	//	Nombre de las cabeceras horizontales
		IDCabeceraH=new Array(NumCabeceraH),		//	Nombre de las cabeceras horizontales
		ColumnaTotales=new Array(1000),			//	Array que guarda el acumulado en la columna de totales
		ColumnaTotalesPercent_H=new Array(1000),
		ColumnaTotalesPercent_V=new Array(1000),
		FilaTotales=new Array(NumCabeceraH),
		FilaTotalesPercent_H=new Array(NumCabeceraH),
		FilaTotalesPercent_V=new Array(NumCabeceraH),
		//Meses=new Array(13),				//	Mes para cada columna
		//Annos=new Array(13),				//	Anno para cada columna
		Done='N',					//	Tabla ya calculada
		LineaActiva=new Array(1000),			//	Indica si la linea de la tabla esta activa (y se mostrara) u oculta
		ColumnaActiva=new Array(1000),			//	Indica si la columna de la tabla esta activa (y se mostrara) u oculta
		//Errores='',					//	Control de errores
		ColumnaOrdenacion='',				//	Columna sobre la que se ordena
		Orden='',					//	ASC o DESC
		ColumnaOrdenada=new Array(1000),		//	Indices ordenados de la columna de orden
		FilaOrdenacion='',				//	Fila sobre la que se ordena
		FOrden='',					//	ASC o DESC
		FilaOrdenada=new Array(1000),			//	Indices ordenados de la fila de orden
		tipoMatriz='A',
                Subtotal;
		 		//indicador de position

jQuery(document).ready(globalEvents);

function globalEvents(){

	if(userRol == 'COMPRADOR' && userDerechos != 'MVM' && userDerechos != 'MVMB'){
		NivelesEmpresa(null,'CAT');
	}

	// Se selecciona la pestanya 'ACUMULADO'
	jQuery("#ACUM").click(function(){
		if(lang == 'spanish'){
			jQuery("#ACUM > img").attr("src","http://www.newco.dev.br/images/botonAcumulado1.gif");
			jQuery("#POR_VERTICAL > img").attr("src","http://www.newco.dev.br/images/botonPerVertical.gif");
			jQuery("#POR_HORIZONTAL > img").attr("src","http://www.newco.dev.br/images/botonPerHorizontal.gif");
		}else{
			jQuery("#ACUM > img").attr("src","http://www.newco.dev.br/images/botonAcumulado1-BR.gif");
			jQuery("#POR_VERTICAL > img").attr("src","http://www.newco.dev.br/images/botonPerVertical-BR.gif");
			jQuery("#POR_HORIZONTAL > img").attr("src","http://www.newco.dev.br/images/botonPerHorizontal-BR.gif");
		}
	});
	// Se selecciona la pestanya 'PORCENTAJE VERTICAL'
	jQuery("#POR_VERTICAL").click(function(){
		if(lang == 'spanish'){
			jQuery("#ACUM > img").attr("src","http://www.newco.dev.br/images/botonAcumulado.gif");
			jQuery("#POR_VERTICAL > img").attr("src","http://www.newco.dev.br/images/botonPerVertical1.gif");
			jQuery("#POR_HORIZONTAL > img").attr("src","http://www.newco.dev.br/images/botonPerHorizontal.gif");
		}else{
			jQuery("#ACUM > img").attr("src","http://www.newco.dev.br/images/botonAcumulado-BR.gif");
			jQuery("#POR_VERTICAL > img").attr("src","http://www.newco.dev.br/images/botonPerVertical1-BR.gif");
			jQuery("#POR_HORIZONTAL > img").attr("src","http://www.newco.dev.br/images/botonPerHorizontal-BR.gif");
		}
	});
	// Se selecciona la pestanya 'PORCENTAJE HORIZONTAL'
	jQuery("#POR_HORIZONTAL").click(function(){
		if(lang == 'spanish'){
			jQuery("#ACUM > img").attr("src","http://www.newco.dev.br/images/botonAcumulado.gif");
			jQuery("#POR_VERTICAL > img").attr("src","http://www.newco.dev.br/images/botonPerVertical.gif");
			jQuery("#POR_HORIZONTAL > img").attr("src","http://www.newco.dev.br/images/botonPerHorizontal1.gif");
		}else{
			jQuery("#ACUM > img").attr("src","http://www.newco.dev.br/images/botonAcumulado-BR.gif");
			jQuery("#POR_VERTICAL > img").attr("src","http://www.newco.dev.br/images/botonPerVertical-BR.gif");
			jQuery("#POR_HORIZONTAL > img").attr("src","http://www.newco.dev.br/images/botonPerHorizontal1-BR.gif");
		}
	});

	// Se selecciona un valor diferente del desplegable de tolerancias => dibujamos la matriz con el nuevo valor
	jQuery("#tolerancia").change(function(){
		generarTabla('');
	});

	// Se selecciona un valor diferente del desplegable TOP Vertical => dibujamos la matriz con las nuevas filas
	jQuery("#TOP_V").change(function(){
		EvaluarTOPVertical();
		generarTabla('');
	});

	// Se selecciona un valor diferente del desplegable TOP Horizontal => dibujamos la matriz con las nuevas columnas
	jQuery("#TOP_H").change(function(){
		EvaluarTOPHorizontal();
		generarTabla('');
	});

	jQuery("#IDEMPRESA").change(function(){
		// Si se elige una empresa del desplegable=> se quita la opcion del desplegable agrupacion vertical
/*
		if(jQuery("#IDEMPRESA").val() != '-1'){
			for(var i=0; i<document.getElementById("AGRUPARPOR_HOR").length; ++i){
				if(document.getElementById("AGRUPARPOR_HOR").options[i].value == "EMP"){
					document.getElementById("AGRUPARPOR_HOR").remove(i);
				}
                        }
		}else{
			var exists = 0;
			for(var i=0; i<document.getElementById("AGRUPARPOR_HOR").length; ++i){
				if(document.getElementById("AGRUPARPOR_HOR").options[i].value == "EMP"){
					exists = 1;
				}
                        }
			if(exists != 1){
				var opt = document.createElement('option');
				opt.value = 'EMP';
				opt.innerHTML = 'Por Empresa';
				document.getElementById("AGRUPARPOR_HOR").appendChild(opt);
			}
		}
*/
		// Inhabilitamos los desplegables para los 5 niveles ya que hemos elegido una nueva empresa
		VaciaNiveles('CAT');
	});

	//evidencio una celda
	jQuery('.azul .textRight').mouseover(function(){
		var idCelda = this.id;
		//jQuery('#'+idCelda).css("background","#FFF");
		jQuery('#'+idCelda).addClass("BLANCO");
	});

	jQuery('.azul .textRight').mouseout(function(){
		var idCelda = this.id;
		//jQuery('#'+idCelda).css("background","#f2f4f6");
		jQuery('#'+idCelda).addClass("NORMAL");
	});
	//evidencio una linea
	jQuery('.azul .indicador').mouseover(function(){
		this.style.cursor="pointer";
		var row = this.id;
		jQuery('#'+row).css("background","#FFF");
		jQuery('.'+row).css("background","#FFF");
		jQuery('#'+row).addClass("BLANCO");
		jQuery('.'+row).addClass("BLANCO");
	});

	jQuery('.azul .indicador').mouseout(function(){
		this.style.cursor="default";
		var row = this.id;
		jQuery('#'+row).css("background","#f2f4f6");
		jQuery('.'+row).css("background","#f2f4f6");
		jQuery('#'+row).addClass("NORMAL");
		jQuery('.'+row).addClass("NORMAL");
	});

	//cerrar el box de comentario
	jQuery('.cerrarInsertCome').mouseover(function(){this.style.cursor="pointer";});
	jQuery('.cerrarInsertCome').mouseout(function(){this.style.cursor="default";});
	jQuery('.cerrarInsertCome').click (function(){
		document.getElementById('fade').style.display='none';
		document.getElementById('insertCome').style.display='none';
	});
	//enviar comentario
	jQuery('.envioCome').mouseover(function(){this.style.cursor="pointer";});
	jQuery('.envioCome').mouseout (function(){this.style.cursor="default";});
	jQuery('.envioCome').click (function(){
		if(matrizPrecalculada == 'S')
			EnviarComentarioPrecalc();
		else
			EnviarComentario();
        });
}//fin de globalEvents

function abrirParaComentar(idHor,idVer,linea,columna,comentario,color,valor){
    	var aux;
	var form=document.forms[0];
	var ComentFiltrado=comentario.replace(/\[SALTO\]/g, '\n');

	if(idHor != '' && idVer != '' && linea != '' && columna != ''){
		jQuery('#comeLinea').val(linea);
		jQuery('#comeCol').val(columna);

		//document.getElementById('over').style.display='block';
		jQuery('#insertCome').show();
		(typeof NombreFila[linea-1] === 'undefined') ? aux = 'Total' : aux = NombreFila[linea-1] ;
		jQuery('#filaComen').html(aux);
		jQuery('#colComen').html(ListaCabeceraH[columna-1].nombre);
		jQuery('#valComen').html(valor);

		document.getElementById('fade').style.display='block';

		form.elements['IDHOR'].value = idHor;
		form.elements['IDVER'].value = idVer;
		form.elements['LINEA'].value = linea;
		form.elements['COLUMNA'].value = columna;
		form.elements['TEXT'].value = ComentFiltrado;
		form.elements['COLOR'].value = color;
	}
}

function Enviar(){
	var formEis = document.forms[0];

	if((formEis.elements['TEXTO'].value=='')||(ComprobarCadenasLargas(formEis.elements['TEXTO'].value,2)=='S')){
		SubmitForm(formEis);
	}else{
		alert('Las cadenas para la búsqueda deben tener 2 caracteres o más. Por favor, revise "'+formEis.elements['TEXTO'].value+'"');
	}
}

// Se guarda el comentario de una celda de la matriz precalculada
function EnviarComentarioPrecalc(){
	var form=document.forms[0];

	var comment = form.elements['TEXT'].value;
	var linea = form.elements['LINEA'].value;
	var columna = form.elements['COLUMNA'].value;
	var idHor = form.elements['IDHOR'].value;
	var idVer = form.elements['IDVER'].value;
	var idpredefinida = form.elements['IDPREDEFINIDA'].value;
	var usid = form.elements['US_ID'].value;
	var color = form.elements['COLOR'].value;
	var commentColor = comment.replace(/\n/g, '[SALTO]');

	commentColor = codificacionAjax(commentColor.replace(/\r/g, '')+'|'+color);

	jQuery.ajax({
		url:"confirmComentarioMatrizPrecalc.xsql",
		data: "US_ID="+usid+"&IDPREDEFINIDA="+idpredefinida+"&IDHOR="+idHor+"&IDVER="+idVer+"&LINEA="+linea+"&COLUMNA="+columna+"&IDCOMENTARIO="+commentColor,
		type: "GET",
		contentType: "application/xhtml+xml",
		beforeSend:function(){
			jQuery('#confirmBox').hide();
			document.getElementById('waitBox').src = 'http://www.newco.dev.br/images/loading.gif';
		},
		error:function(objeto, quepaso, otroobj){
			alert("objeto:"+objeto);
			alert("otroobj:"+otroobj);
			alert("quepaso:"+quepaso);
		},
		success:function(data){
			var doc=eval("(" + data + ")");

			if(data.match('error')){
				var dataOne = data.split('error');
				var dataTwo = dataOne[1].split('}');
				var dataThree = dataTwo[0].split(':');
				var error = dataThree[1];

				jQuery('#confirmBox').text(error);
			}
			if(data.match('ok')){
				jQuery('#confirmBox').text('Datos enviados con exito');
			}
			jQuery('#waitBox').hide();
			jQuery('#confirmBox').css("color", "#FF0000");
			jQuery('#confirmBox').css("font-weight", "bold");
			jQuery('#confirmBox').show();
		}
	}); //FIN AJAX
}

// Se guarda el comentario de una celda de la matriz resultante (no precalculada)
function EnviarComentario(){
	var form=document.forms[0];
	var comment = form.elements['TEXT'].value;
	var color = form.elements['COLOR'].value;

	var IDEmpresa		= form.elements['IDEMPRESA_USU'].value;
	var idHor		= form.elements['IDHOR'].value;
	var idVer		= form.elements['IDVER'].value;
	var IDAgruparPor_Ver	= form.elements['IDAGRUPARPOR_VER'].value;
	var IDAgruparPor_Hor	= form.elements['IDAGRUPARPOR_HOR'].value;
	var Filtros		= filtrosComentarios;

	var linea		= jQuery('#comeLinea').val();
	var columna		= jQuery('#comeCol').val();

	var commentColor = comment.replace(/\n/g, '[SALTO]');
	commentColor = encodeURIComponent(commentColor.replace(/\r/g, '')+'|'+color);

	jQuery.ajax({
		url:"confirmComentarioMatriz_ajax.xsql",
		data: "IDEMPRESA="+IDEmpresa+"&IDINDICADOR="+IDIndicador+"&IDAGRUPARPOR_HOR="+IDAgruparPor_Hor+"&IDAGRUPARPOR_VER="+IDAgruparPor_Ver+"&IDHOR="+idHor+"&IDVER="+idVer+"&FILTROS="+Filtros+"&COMENTARIO="+commentColor,
		type: "GET",
		contentType: "application/xhtml+xml",
		beforeSend:function(){
			jQuery('#confirmBox').hide();
			document.getElementById('waitBox').src = 'http://www.newco.dev.br/images/loading.gif';
		},
		error:function(objeto, quepaso, otroobj){
			alert("objeto:"+objeto);
			alert("otroobj:"+otroobj);
			alert("quepaso:"+quepaso);
		},
		success:function(data){
			var doc=eval("(" + data + ")");

			if(data.match('error')){
				var dataOne = data.split('error');
				var dataTwo = dataOne[1].split('}');
				var dataThree = dataTwo[0].split(':');
				var error = dataThree[1];

				jQuery('#confirmBox').text(error);
				jQuery('#confirmBox').css("color", "#FF0000");
				jQuery('#confirmBox').css("font-weight", "bold");
				jQuery('#confirmBox').show();
			}
			if(data.match('ok')){
				jQuery('#waitBox').hide();
				jQuery('#confirmBox').text('Datos enviados con exito');
				jQuery('#confirmBox').css("color", "#FF0000");
				jQuery('#confirmBox').css("font-weight", "bold");
				jQuery('#confirmBox').show();

				generarComentarioCelda(comment.replace(/\n/g, '[SALTO]'),color,idHor,idVer,linea,columna);
				document.getElementById('fade').style.display='none';
				jQuery('#insertCome').hide();
			}

		}
	}); //FIN AJAX
}

function generarComentarioCelda(comment,color,idHor,idVer,linea,columna){
	var Val, td_id, pos,anchorClass;

	// ID de la celda
	td_id	= idHor+'x'+idVer;
	// Recupero el valor de la celda
	Val	= jQuery('td#'+td_id+' a.numeric').html();

	// Puede que la celda ya tenga algun comentario => substring
	pos	= Val.indexOf("<span "); // Buscamos el tag span donde iria el comentario
	if(pos > 0)	Val = Val.substring(0,pos);

	// Cambiamos el color de la celda
	jQuery('td#'+td_id).removeClass().addClass(color);

	// Obtenemos la class del anchor tag
	anchorClass = jQuery('td#'+td_id+' a.numeric').attr('class');
	pos	= anchorClass.indexOf('tooltip');
	if(pos < 0)	jQuery('td#'+td_id+' a.numeric').addClass('tooltip'); // Anyadimos la class 'tooltip' si no existe para el pop-up del comentario

	// Cambiamos la llamada a la funcion abrirParaComentar con los nuevos valores
	jQuery('td#'+td_id+' a.numeric').attr('href','javascript:abrirParaComentar(\'' + idHor + '\',\'' + idVer + '\',\'' + linea + '\',\'' + columna + '\',\'' + comment + '\',\'' + color + '\',\'' + Val + '\')');

	jQuery('td#'+td_id+' a.numeric').html(Val + '<span class="classic spanEIS">' + comment.replace(/\[SALTO\]/g,'<br />') + '</span>');

}

//	Ordena por una fila
function OrdenarPorFila(fila, reordenar){
	// Asignamos valor por defecto sino se pasa el parametro
	reordenar = typeof reordenar !== 'undefined' ? reordenar : true;

	if(reordenar !== false){
		if(FilaOrdenacion==fila){
			if(FOrden=='DESC')
				FOrden='ASC';
			else
				FOrden='DESC';
		}else{
			FilaOrdenacion=fila;
			FOrden='DESC';
		}
        }

	//	Ordenar sobre esta fila
	ordenamientoBurbujaFila(fila, FOrden);

	//	Redibujar tabla
	if(reordenar !== false)
		generarTabla('');
}

//	Ordena por una columna
function OrdenarPorColumna(col, reordenar){
	// Asignamos valor por defecto sino se pasa el parametro
	reordenar = typeof reordenar !== 'undefined' ? reordenar : true;

	if(reordenar !== false){
		if(ColumnaOrdenacion==col){
			if(Orden=='DESC')
				Orden='ASC';
			else
				Orden='DESC';
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
		generarTabla('');
}

//	Prepara un array con los ordenes correspondientes a una columna
//	PENDIENTE: separar ordenacion segun indicador
function ordenamientoBurbuja(col, tipo){
	var Val = new Array(13000);

	if (col == (NumCabeceraH - 1)){
		if(tipoMatriz == 'A')
			Val = ColumnaTotales;
		else if(tipoMatriz == 'V')
			Val = ColumnaTotalesPercent_V;
		else if(tipoMatriz == 'H')
			Val = ColumnaTotalesPercent_H;
	}else{
		if(tipoMatriz == 'A')
			Val = Valores;
		else if(tipoMatriz == 'V')
			Val = ValoresNormV;
		else if(tipoMatriz == 'H')
			Val = ValoresNormH;		
	}

	for(var i=0; i<NumLineas; i++)
		ColumnaOrdenada[i]=i;

	for(i=0; i<NumLineas; i++){
		for(var j=i+1; j<=NumLineas; j++){
			if(col != (NumCabeceraH - 1)){
				// En este caso necesitamos calcular la fila para ordenar
				if(Val[ColumnaOrdenada[i] * NumCabeceraH + col] > Val[ColumnaOrdenada[j] * NumCabeceraH + col]){
					temp=ColumnaOrdenada[j];
					ColumnaOrdenada[j]=ColumnaOrdenada[i];
					ColumnaOrdenada[i]=temp;
				}
                        }else{
				// En este caso ordenamos sobre el array de la columna de totales
				if(Val[ColumnaOrdenada[i]] > Val[ColumnaOrdenada[j]]){
					temp=ColumnaOrdenada[j];
					ColumnaOrdenada[j]=ColumnaOrdenada[i];
					ColumnaOrdenada[i]=temp;
				}
			}
		}
	}

	//	En caso de ordenacion descendente intercambiamos de forma simetrica el vector de ordenacion
	if(tipo=='DESC'){
		for(i=0; i<NumLineas/2; i++){
			temp=ColumnaOrdenada[(NumLineas-1)-i];
			ColumnaOrdenada[(NumLineas-1)-i]=ColumnaOrdenada[i];
			ColumnaOrdenada[i]=temp;
		}
	}
}

function ordenamientoAlfabet(tipo){
	for(var i=0; i<NumLineas; i++)
		ColumnaOrdenada[i]=i;

	for(i=0; i<NumLineas; i++){
		for(var j=i+1; j<=NumLineas; j++){
			if(NombresGrupos[i] > NombresGrupos[j]){
				temp=ColumnaOrdenada[j];
				ColumnaOrdenada[j]=ColumnaOrdenada[i];
				ColumnaOrdenada[i]=temp;
			}
		}
	}

	//	En caso de ordenacion descendente intercambiamos de forma simetrica el vector de ordenacion
	if(tipo=='DESC'){
		for(i=0; i<NumLineas/2; i++){
			temp=ColumnaOrdenada[(NumLineas-1)-i];
			ColumnaOrdenada[(NumLineas-1)-i]=ColumnaOrdenada[i];
			ColumnaOrdenada[i]=temp;
		}
	}
}
//	Prepara un array con los ordenes correspondientes a una fila
//	PENDIENTE: separar ordenacion segun indicador
function ordenamientoBurbujaFila(fila, tipo){
	var Val = new Array(13000);

	if (fila == '99999Total'){
		if(tipoMatriz == 'A')
			Val = FilaTotales;
		else if(tipoMatriz == 'V')
			Val = FilaTotalesPercent_V;
		else if(tipoMatriz == 'H')
			Val = FilaTotalesPercent_H;
	}else{
		if(tipoMatriz == 'A')
			Val = Valores;
		else if(tipoMatriz == 'V')
			Val = ValoresNormV;
		else if(tipoMatriz == 'H')
			Val = ValoresNormH;		
	}

	for(var i=0; i<NumCabeceraH; i++)
		FilaOrdenada[i]=i;

	for(i=0; i<(NumCabeceraH-1); i++){
		for(var j=i+1; j<(NumCabeceraH-1); j++){
			if(fila != '99999Total'){
				// En este caso necesitamos calcular la fila para ordenar
				if(Val[NumCabeceraH * fila + FilaOrdenada[i]] > Val[NumCabeceraH * fila + FilaOrdenada[j]]){
					temp=FilaOrdenada[j];
					FilaOrdenada[j]=FilaOrdenada[i];
					FilaOrdenada[i]=temp;
				}
			}else{
				// En este caso ordenamos sobre el array de la fila de totales
				if(Val[FilaOrdenada[i]] > Val[FilaOrdenada[j]]){
					temp=FilaOrdenada[j];
					FilaOrdenada[j]=FilaOrdenada[i];
					FilaOrdenada[i]=temp;
				}
			}
		}
	}

	//	En caso de ordenacion descendiente intercambiamos de forma simetrica el vector de ordenacion
	if(tipo=='DESC'){
		for(i=0; i<(NumCabeceraH-1)/2; i++){
			// Ordenamos a partir de (NumCabeceraH-2) para dejar la columan de totales siempre a la derecha
			temp=FilaOrdenada[(NumCabeceraH-2)-i];
			FilaOrdenada[(NumCabeceraH-2)-i]=FilaOrdenada[i];
			FilaOrdenada[i]=temp;
		}
	}

}

//	Variables con cadenas necesarias para construir el HTML de las tablas
var cellTitleStart = '<td align="center">';
var cellTitleStartClass = '<td align="center" class="selected">';
var cellTitleStartMod = '', cellTitleStartIndicMod = '';
var cellTitleStartIndic = '<td align="left">';
var cellTitleStartIndicClass = '<td align="left" class="selected">';
var rowIndStart = '<tr class="subTituloTabla">';
var cellIndStart = '<td align="left" colspan="' + parseInt(NumCabeceraH + 2) + '">&nbsp;';
var cellIndCStart = '<td align="center" colspan="' + parseInt(NumCabeceraH + 2) + '">&nbsp;';
var rowStart = '<tr class="matrizbody #CLASEPAROIMPAR#">';
var rowEnd = '</tr>';
//var cellGroupStart = '&nbsp;<input type="checkbox" name="CHECK_GRUPO|#IDINDICADOR#|#IDGRUPO#"/>&nbsp;&nbsp;';
var cellTotalStart = '<td align="left">&nbsp;&nbsp;&nbsp;&nbsp;';
var cellStart = '<td align="right" class="#CLASS#" style="padding-right:6px;" id="#ID#">';
var cellEnd = '</td>';
var macroEnlaceGrupo='<a class="grupo" href="javascript:OrdenarPorFila(\'#NUM_FILA#\');">';
var macroEnlaceNormal='<a class="numeric #CLASS#" href="javascript:abrirParaComentar(\'#IDGRUPO#\',\'#IDCABECERA_H#\',\'#LINEA#\',\'#COLUMNA#\',\'#COMENTARIO#\',\'#COM_COLOR#\',\'#VALOR#\');">';

//	Genera de forma dinamica la tabla de datos del EIS
/*
function generarTabla(){
	// Recogemos el valor de la tolerancia, si existe (para matrices precalculadas no se utiliza)
	if(matrizPrecalculada == 'N')
		var tolerancia = jQuery('#tolerancia').val();

	//debugMatriz();		//solodebug!!!!

	//si filtramos por ratio quitamos totales
	var formMatriz = document.forms[0];
	try{
		var ratio = formMatriz.elements['IDRESULTADOS'].value;
	}catch(err){
		ratio='NO_RATIO';
	}

	var linea=0;
	var pos = 0, f_pos;
	var HayOcultas='N';

	//	Total para cada indicador
	var Totales=new Array(NumCabeceraH);
	for(k=1;k<=NumCabeceraH;k++)  Totales[k]=0;

	var Clase,Imagen,Comentario;
	var cellStartThis = '';

	var cadenaHtml='';

	if(ResultadosTabla['MAX_LINEAS_'+IDIndicador] > 0 && ResultadosTabla['MAX_LINEAS_'+IDIndicador] != ''){
		var IDIndicadorActual='';

		for(var i=0;i<=NumLineas;i++){
			// Dibujamos la cabeceras horizontal cada 25 lineas
			if(i%25 == 0)	cadenaHtml = dibujarCabeceraH(cadenaHtml);

			//	Comprueba si la linea esta activa
			if(LineaActiva[ColumnaOrdenada[i]]=='S'){
				linea++;
				pos++;

				//	Comprueba cambio de Indicador
				if(IDIndicadorActual!=IDIndicadores[ColumnaOrdenada[i]]){
					//	Muestra la linea de totales correspondiente al indicador anterior
					if(IDIndicadorActual!=''){
						//si filtramos por ratio no ensenyo totales
						if(ratio == 'RATIO'){
							cadenaHtml=cadenaHtml;
						}else{
							cadenaHtml=cadenaHtml+LineaTotalesHTML(IDIndicadorActual, Totales, linea, HayOcultas);
						}

						//	Inicializa la linea de totales
						for(k=1;k<=NumCabeceraH;k++)  Totales[k]=0;
					}

					pos=1;

					cadenaHtml=cadenaHtml+rowIndStart+cellIndStart+NombresIndicadores[ColumnaOrdenada[i]]+cellEnd+rowEnd;
					IDIndicadorActual=IDIndicadores[ColumnaOrdenada[i]];
				}

				//cellStartThis=Replace(cellGroupStart,'#IDINDICADOR#',IDIndicadorActual);
				//cellStartThis=Replace(cellStartThis,'#IDGRUPO#',IDGrupos[ColumnaOrdenada[i]]);
				//cellStartThis= linea+cellStartThis;
				//cellStartThis=Replace(cellStartThis,'#CLASEPAROIMPAR#',((linea%2)==0?'par':'impar'));

				//para ensenyar
				if(pos < 10){
					f_pos = '00'+pos;
				}else if(pos<100){
					f_pos = '0'+pos;
				}else{
					f_pos = pos;
				}

				if((FilaOrdenacion==(ColumnaOrdenada[i]))&&(FOrden!=''))
					cellTitleStartIndicMod = cellTitleStartIndicClass;
				else
					cellTitleStartIndicMod = cellTitleStartIndic;

				//cadenaHtml=cadenaHtml+Replace(rowStart,'#CLASEPAROIMPAR#',((linea%2)==0?'par':'impar'))+'<td align="left">'+pos+cellStartThis+Replace(macroEnlaceGrupo,'#IDGRUPO#',IDGrupos[ColumnaOrdenada[i]])+NombresGrupos[ColumnaOrdenada[i]]+'</a>'+cellEnd;
				cadenaHtml=cadenaHtml+Replace(rowStart,'#CLASEPAROIMPAR#',((linea%2)==0?'par':'impar'))+'<td align="left">'+f_pos+cellEnd;
				cadenaHtml=cadenaHtml+cellTitleStartIndicMod+Replace(macroEnlaceGrupo,'#NUM_FILA#',ColumnaOrdenada[i])+NombresGrupos[ColumnaOrdenada[i]]+'</a>'+cellEnd;

				for(k=1;k<=NumCabeceraH;k++){
					Totales[k]=Totales[k]+Valores[ColumnaOrdenada[i] * NumCabeceraH + FilaOrdenada[k-1]];

					Clase='celdanormal';
					if(k<NumCabeceraH){
						Enlace=macroEnlaceNormal;
                                                if(matrizPrecalculada == 'S'){
							if(Colores[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]]=='Rojo')	Clase='rojo1';
							if(Colores[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]]=='Grave')	Clase='rojo2';
							if(Colores[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]]=='Verde')	Clase='verdeNormal';
							if(Colores[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]]=='Nuevo')	Clase='verdeNormal';
						}else{
							// Comparamos el valor Normalizado de la celda con el total normalizado de la fila
							if(ValoresNormV[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]] > ValoresNormV[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[NumCabeceraH-1]])
								Clase='verdeNormal';
							else if(ValoresNormV[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]] < ValoresNormV[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[NumCabeceraH-1]])
								Clase='rojo2';
						}
					}else
						Enlace=macroEnlaceNormal;

					if(Comentarios[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]] != ''){
						Clase		= Clase + ' tooltip';
						Comentario	= '<span class="classic">' + Comentarios[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]] + '</span>'
                                        }else{
						Comentario	= '';
                                        }

					Enlace=Replace(Enlace,'#CLASS#',Clase);
					Enlace=Replace(Enlace,'#IDGRUPO#',IDGrupos[ColumnaOrdenada[i]]);
					Enlace=Replace(Enlace,'#IDCABECERA_H#',IDCabeceraH[FilaOrdenada[k-1]]);
					Enlace=Replace(Enlace,'#LINEA#',ColumnaOrdenada[i]+1);
					Enlace=Replace(Enlace,'#COLUMNA#',FilaOrdenada[k-1]+1);
					Enlace=Replace(Enlace,'#COMENTARIO#',Comentarios[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]]);

                                        if(ComCol[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]] != 'NORMAL')
						Enlace=Replace(Enlace,'#COM_COLOR#',ComCol[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]]);
					else
						Enlace=Replace(Enlace,'#COM_COLOR#','');

					Clase		= ComCol[ColumnaOrdenada[i] * NumCabeceraH + FilaOrdenada[k-1]];

					cellStartThis	= Replace(cellStart,'#CLASS#',Clase);

					//formatNumbre
					//cadenaHtml=cadenaHtml+cellStart+Enlace+FormatNumber( parseFloat(Valores[ColumnaOrdenada[i]*13+k-1]),0,',','.')+'</a>'+cellEnd;
					//cadenaHtml=cadenaHtml+cellStart+Enlace+FormatNumber(Valores[ColumnaOrdenada[i]*13+k-1],0,',','.')+'</a>&nbsp;'+cellEnd;
					//cadenaHtml=cadenaHtml+cellStart+Enlace+Valores[ColumnaOrdenada[i]*13+k-1]+'</a>&nbsp;'+cellEnd;

					//Imagen	= (Comentarios[ColumnaOrdenada[i] * NumCabeceraH + FilaOrdenada[k-1]] != '') ? '<img src="http://www.newco.dev.br/images/comeMatriz.gif" title="' + Comentarios[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]] + '" />' : '';

					Valor	= (Valores[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]] != 0) ? FormatNumber(Valores[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]],4,',','.') : '.';

					if(Valores[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]] < 1 && Valores[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]] > 0){
						//cadenaHtml=cadenaHtml+cellStartThis+Enlace+FormatNumber(Valores[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]],4,',','.')+'</a>&nbsp;'+cellEnd;
						cadenaHtml=cadenaHtml+cellStartThis+Enlace+Valor+Comentario+'</a>&nbsp;'+cellEnd;
					}else{
						//cadenaHtml=cadenaHtml+cellStartThis+Enlace+FormatNumber(Valores[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]],4,',','.')+'</a>&nbsp;'+cellEnd;
						cadenaHtml=cadenaHtml+cellStartThis+Enlace+Valor+Comentario+'</a>&nbsp;'+cellEnd;
					}
				}
				cadenaHtml=cadenaHtml+rowEnd;
			}else
				HayOcultas='S';
		}
		//si filtramos por ratio no ensenyo totales
		if(ratio == 'RATIO'){
			cadenaHtml=cadenaHtml;
		}else{
			cadenaHtml=cadenaHtml+LineaTotalesHTML(IDIndicadorActual, Totales, linea);
		}
	}else{
		cadenaHtml=cadenaHtml+'<tr>'+cellIndCStart+txtSinResultados+cellEnd+rowEnd;
	}

	//cadenaHtml=cadenaHtml+'<tr class="subTituloTabla"><td colspan="14" align="left">'+BotonArribaHTML(txtTodos, 'Seleccionar', 'javascript:Seleccionar();', 50)+BotonArribaHTML(txtResultados, 'Dejar todos los seleccionados', 'javascript:Activar(true);', 50)+BotonArribaHTML(txtVolver, 'Ver todas las lineas de datos', 'javascript:TodasLineasActivas();', 50)+'</td></tr>';
	cadenaHtml=cadenaHtml+rowIndStart+cellIndStart+cellEnd+rowEnd;

	// Dibujamos cabecera horizontal al final de la tabla
	cadenaHtml = dibujarCabeceraH(cadenaHtml);

	jQuery("#TablaDatos").empty();
	jQuery("#TablaDatos").html(cadenaHtml);
	jQuery("#waitBox").hide();
	jQuery("#MostrarCuadro").show();
}
*/
function TodasLineasActivas(){
	// Valor por defecto de la tolerancia es 10%
	jQuery('#tolerancia').val('0.2');

	// Marcamos todas las filas como activas
	for(var i=0;i<=NumLineas;++i)
		LineaActiva[i]='S';

	// Marcamos todas las columnas como activas
	for(i=0;i<NumCabeceraH;++i)
		ColumnaActiva[i]='S';

	//	Recargamos los datos originales
	Done='N';
	PrepararTablaDatos();

	//redibujar tabla
	generarTabla('A');
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
		LineaActual='',
		UltimaLinea='',
		ProductoCopia='',
		IDColumnaActual;			//	16mar11

	jQuery.each(ResultadosTabla, function(key, value){
		//	Recorremos el array ResultadosTabla, sin repetir las lineas
		if((key.substring(0,4)=='RES|')&&((Piece(key,'|',1)!=IDIndicadorActual)||(Piece(key,'|',2)!=IDGrupoActual)||(Piece(key,'|',3)!=LineaActual))){
			//	Comprueba si hay cambio de indicador
			if(Piece(key,'|',1)!=IDIndicadorActual){
				IDIndicadorActual=Piece(key,'|',1);
				NombreIndicadorActual=ResultadosTabla["INDICADOR|"+IDIndicadorActual];
			}
			//	Comprueba si hay cambio de linea
			if(Piece(key,'|',3)!=LineaActual){
				UltimaLinea=LineaActual;
				LineaActual=Piece(key,'|',3);
			}
			//	Comprueba si hay cambio de grupo
			if(Piece(key,'|',2)!=IDGrupoActual || Piece(key,'|',3)!=UltimaLinea){
				// DC - 02may14
				// Control para comprobar que no nos encontramos con cambios en descripciones de productos
				//  que no se han propagado correctamente a los historicos
				if(Piece(key,'|',2)!=IDGrupoActual){
					ProductoCopia = '';
                                }else{
					ProductoCopia = '[DUPLICADO]';
				}
				IDGrupoActual=Piece(key,'|',2);
				NombreGrupoActual=ResultadosTabla["GRUPO|"+IDIndicadorActual+"|"+IDGrupoActual+'|'+LineaActual];
				if(IDGrupoActual!='-1') count=count+1;
			}
			//	Filtramos la linea de totales
			if(IDGrupoActual!='-1'){
				IDIndicadores[count]=IDIndicadorActual;
				NombresIndicadores[count]=NombreIndicadorActual;
				IDGrupos[count]=IDGrupoActual + ProductoCopia;
				NombresGrupos[count]=NombreGrupoActual;
				LineaActiva[count]='S';

				//	Recorremos todas las celdas de valores
				for(var k=1;k<=NumCabeceraH;k++){
					Valores[count*NumCabeceraH+k-1]		= ANumero(ResultadosTabla['RES|'+IDIndicadorActual+'|'+IDGrupoActual+'|'+LineaActual+'|'+k]);
					Colores[count*NumCabeceraH+k-1]		= ResultadosTabla['COLOR|'+IDIndicadorActual+'|'+IDGrupoActual+'|'+LineaActual+'|'+k];

					if(matrizPrecalculada == 'S'){
						Comentarios[count*NumCabeceraH+k-1]	= ResultadosTabla['COMENTARIO|'+IDIndicadorActual+'|'+IDGrupoActual+'|'+LineaActual+'|'+k];
						ComCol[count*NumCabeceraH+k-1]		= ResultadosTabla['COMENTARIO_COLOR|'+IDIndicadorActual+'|'+IDGrupoActual+'|'+LineaActual+'|'+k];
					}else{
						IDColumnaActual = ListaCabeceraH[k-1].id;
						if(typeof ComentariosGen[IDGrupoActual+'|'+IDColumnaActual] != 'undefined'){
							Comentarios[count*NumCabeceraH+k-1]	= Piece(ComentariosGen[IDGrupoActual+'|'+IDColumnaActual],'|',0);
							ComCol[count*NumCabeceraH+k-1]		= Piece(ComentariosGen[IDGrupoActual+'|'+IDColumnaActual],'|',1);
                                                }else{
							Comentarios[count*NumCabeceraH+k-1]	= '';
							ComCol[count*NumCabeceraH+k-1]		= '';
						}
						// Array de valores normalizados verticalmente
                                                if(ANumero(ResultadosTabla['RES|'+IDIndicadorActual+'|-1|'+ResultadosTabla['MAX_LINEAS_'+IDIndicadorActual]+'|'+k]) != 0)
							ValoresNormV[count*NumCabeceraH+k-1]	= ANumero(ResultadosTabla['RES|'+IDIndicadorActual+'|'+IDGrupoActual+'|'+LineaActual+'|'+k])/ANumero(ResultadosTabla['RES|'+IDIndicadorActual+'|-1|'+ResultadosTabla['MAX_LINEAS_'+IDIndicadorActual]+'|'+k])*100;
						else
							ValoresNormV[count*NumCabeceraH+k-1]	= 0;

						// Array de valores normalizados horizontalmente
                                                if(ANumero(ResultadosTabla['RES|'+IDIndicadorActual+'|-1|'+ResultadosTabla['MAX_LINEAS_'+IDIndicadorActual]+'|'+k]) != 0)
							ValoresNormH[count*NumCabeceraH+k-1]	= ANumero(ResultadosTabla['RES|'+IDIndicadorActual+'|'+IDGrupoActual+'|'+LineaActual+'|'+k])/ANumero(ResultadosTabla['RES|'+IDIndicadorActual+'|'+IDGrupoActual+'|'+LineaActual+'|'+NumCabeceraH])*100;
						else
							ValoresNormH[count*NumCabeceraH+k-1]	= 0;
                                        }
/*
					try{
						if(ResultadosTabla['ROW|'+IDIndicadorActual+'|'+IDGrupoActual+'|'+LineaActual+'|'+k+'|COLOR']=='ROJO')
							Colores[count*13+k-1]='R';
						if(ResultadosTabla['ROW|'+IDIndicadorActual+'|'+IDGrupoActual+'|'+LineaActual+'|'+k+'|COLOR']=='VERDE')
							Colores[count*13+k-1]='V';
						if(ResultadosTabla['ROW|'+IDIndicadorActual+'|'+IDGrupoActual+'|'+LineaActual+'|'+k+'|COLOR']=='NEGRO')
							Colores[count*13+k-1]='N';
					}
					catch(err){
						Colores[count*13+k-1]='?';
					}
*/
				}
			}
		}
	});

	// Count se inicializa a -1 pq los arrays empiezan en cero, asi que sumamos 1 al resultado final
	if(matrizPrecalculada == 'S')
		NumLineas=count;
	else
		NumLineas=count+1;

	// Montamos array de los titulos de la cabecera horizontal y aprovechamos el loop para calcular la fila de totales
	NombresCabeceraH[0]='';
	for(var j=0;j<=(NumCabeceraH-1);j++){
		NombresCabeceraH[j]=ListaCabeceraH[j].nombre;
		IDCabeceraH[j]=ListaCabeceraH[j].id;

		// Calcular La fila de totales
/*
		Subtotal = 0;
		for(var i=0;i<NumLineas;i++){
			Subtotal = Subtotal + Valores[i * NumCabeceraH + j];
		}
		FilaTotales[j] = Subtotal;
*/
	}
	NombresCabeceraH[NumCabeceraH]='Total';

/*
	// Ahora calculo el porcentaje a nivel horizontal y vertical (este siempre 100%)
	// El ultimo valor del array es el valor total, FilaTotales[NumCabeceraH-1]
	for(i=0; i<NumCabeceraH; i++){
		FilaTotalesPercent_H[i] = (FilaTotales[i] * 100) / FilaTotales[NumCabeceraH-1];
		FilaTotalesPercent_V[i] = '100';
        }

*/
	//	Ordenacion por defecto
	ColumnaOrdenacion='';
//	FilaOrdenada='';
	Orden='';
	for (i=0; i<NumLineas; i++) 
		ColumnaOrdenada[i]=i;

	for (i=0; i<NumCabeceraH; i++) 
		FilaOrdenada[i]=i;

	CalcularColumnaTotales();	// Calcula el acumulado para la columna de totales
	CalcularFilaTotales();		// Calcula el acumulado para la fila de totales

	OrdenarPorColumna(NumCabeceraH-1);
	OrdenarPorFila('99999Total');


	if(Done == 'N' && jQuery('#TOP_V').length)
		EvaluarTOPVertical();

	if(Done == 'N' && jQuery('#TOP_H').length)
		EvaluarTOPHorizontal();

	Done='S';

	if (Errores!='') alert(Errores);	//solodebug!!!!
	//debugMatriz();			//solodebug: recuperamos la matriz y la mostramos en pantalla
}

//	Genera la linea de totales
function LineaTotalesHTML(IDIndicador, Totales, linea, HayOcultas){
	var cadenaHtml,total;

	cellStartThis=Replace(cellTotalStart,'#IDINDICADOR#',IDIndicador);
	cellStartThis=Replace(cellStartThis,'#IDGRUPO#','99999Total');

	cadenaHtml=Replace(rowStart,'#CLASEPAROIMPAR#','medio')+cellStartThis+cellEnd+cellStartThis+Replace(macroEnlaceGrupo,'#NUM_FILA#','99999Total')+'Total</a>'+cellEnd;

	for(k=1;k<=NumCabeceraH;k++){
		Enlace=macroEnlaceNormal;
		Enlace=Replace(Enlace,'#CLASS#','celdanormal');
		Enlace=Replace(Enlace,'#IDINDICADOR#',IDIndicador);
		Enlace=Replace(Enlace,'#IDGRUPO#','99999Total')
		Enlace=Replace(Enlace,'#ANNOINICIO#',$('#OR_ANNO').value);

		total = FormatNumber( Totales[k],4,',','.');

		// Si es matrix porcentual => anyado % al final
		if(tipoMatriz != 'A')	total = total + '%';

		cadenaHtml=cadenaHtml+cellStart+Enlace+total+'&nbsp;</a>'+cellEnd;
	}
	cadenaHtml=cadenaHtml+rowEnd

	return cadenaHtml;
}

//	Genera la linea de totales
function LineaTotalesHTML_2(IDIndicador){
	var cadenaHtml,total,linkToEIS;

	cellStartThis=Replace(cellTotalStart,'#IDINDICADOR#',IDIndicador);
	cellStartThis=Replace(cellStartThis,'#IDGRUPO#','99999Total');

	cadenaHtml=Replace(rowStart,'#CLASEPAROIMPAR#','medio')+cellStartThis+cellEnd+cellStartThis+Replace(macroEnlaceGrupo,'#NUM_FILA#','99999Total')+'Total</a>'+cellEnd;

	for(var k=0;k<NumCabeceraH;k++){
		if(ColumnaActiva[FilaOrdenada[k]] == 'S'){
			linkToEIS = '';

			Clase		= ComCol[(NumLineas+1) * NumCabeceraH + FilaOrdenada[k]];
			cellStartAux	= Replace(cellStart,'#CLASS#',Clase);
			cellStartAux	= Replace(cellStartAux,'#ID#','99999Total'+'x'+IDCabeceraH[FilaOrdenada[k]]);

			Enlace=macroEnlaceNormal;
			Enlace=Replace(Enlace,'#CLASS#','celdanormal');
			Enlace=Replace(Enlace,'#IDINDICADOR#',IDIndicador);
			Enlace=Replace(Enlace,'#IDGRUPO#','99999Total');
			Enlace=Replace(Enlace,'#IDCABECERA_H#',IDCabeceraH[FilaOrdenada[k]]);
			Enlace=Replace(Enlace,'#LINEA#','99999Total');
			Enlace=Replace(Enlace,'#COLUMNA#',FilaOrdenada[k]+1);
			Enlace=Replace(Enlace,'#COMENTARIO#',Comentarios[(NumLineas+1)*NumCabeceraH+FilaOrdenada[k]]);
			if(ComCol[(NumLineas+1)*NumCabeceraH+FilaOrdenada[k]] != 'NORMAL')
				Enlace=Replace(Enlace,'#COM_COLOR#',ComCol[(NumLineas+1)*NumCabeceraH+FilaOrdenada[k]]);
			else
				Enlace=Replace(Enlace,'#COM_COLOR#','');

			if(tipoMatriz == 'A'){
				total = FormatNumber(FilaTotales[FilaOrdenada[k]],4,',','.');
//if(k == (NumCabeceraH-1)) total = total + ' - ' + FormatNumber(ColumnaTotales[NumLineas],4,',','.');
                        }else if(tipoMatriz == 'V')
				total = FormatNumber(FilaTotalesPercent_V[FilaOrdenada[k]],4,',','.') + '%';
			else if(tipoMatriz == 'H')
				total = FormatNumber(FilaTotalesPercent_H[FilaOrdenada[k]],4,',','.') + '%';

			Enlace=Replace(Enlace,'#VALOR#',total);

			if(matrizPrecalculada == 'N'){
				linkToEIS	= '<a href="javascript:linkToEIS(\'' + IDCabeceraH[FilaOrdenada[k]] + '\',\'H\')"><img src="http://www.newco.dev.br/images/verGrafico.gif" width="10px"/></a>';
                        }else{
				linkToEIS	= '';
			}

			if(k == (NumCabeceraH-1) && tipoMatriz != 'A')
				total = '100%';
                        else if(k == (NumCabeceraH-1))
				total = FormatNumber(ColumnaTotales[NumLineas],4,',','.');

			// Por el momento no se pueden poner comentarios en la fila de totales
			//cadenaHtml=cadenaHtml+cellStartAux+Enlace+total+'&nbsp;'+ linkToEIS +'</a>'+cellEnd;
			cadenaHtml=cadenaHtml+cellStart+'<span style="font-weight:bold;color:#3B5998;font-family: Geneva,Arial,Helvetica,sans-serif;">'+total+'</span>'+'&nbsp;'+ linkToEIS +cellEnd;
		}
	}
	cadenaHtml=cadenaHtml+rowEnd

	return cadenaHtml;
}

//	Elimina el punto de una cadena y convierte ',' a '.' para poder convertir a numero
function ANumero(Cadena){
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

	return Res;
}

function BotonArribaHTML(texto, explicacion, funcion, ancho){
/*
	//si es ultimo no pongo barra
	if(explicacion == 'Ver todas las lineas de datos'){
		var cadenaHtml='<a href="#" onclick="'+funcion+'">'+texto+'</a>';
	}else{
		var cadenaHtml='<a href="#" onclick="'+funcion+'">'+texto+'</a>&nbsp;&nbsp;|&nbsp;&nbsp;';
	}
*/
	var cadenaHtml='<table class="button" style="float:left;"  cellpadding="0" cellspacing="1" width="'+ancho+'"><tr><td align="center" valign="middle"><a href="#" onclick="'+funcion+'" >'+texto+'</a></td></tr></table>';
	return cadenaHtml;
}

// needle may be a regular expression
function Replace(haystack, needle, replacement){
	var r = new RegExp(needle, 'g');
	return haystack.replace(r, replacement);
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
	generarTabla('');
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

function todasColumnasActivas()
{
	for (var j=0;j<=NumCabeceraH;j++)
		if (ColumnaActiva[j]=='N') return 'N';
	return 'S';
}

function CompruebaLineasActivas()
{
	for (var j=0;j<=NumLineas;j++)
		if (LineaActiva[j]=='S') return 'S';
	return 'N';
}

function dibujarCabeceraH(cadenaHtml){
	var cadenaBorrarCol, mostrarCol='', hayColOculta='N';

	cadenaHtml=cadenaHtml+'<tr class="titleTablaEIS">';

	if(todasColumnasActivas()=='N'){
		mostrarCol = '<span style="float:right;"><a href="javascript:mostrarTodasCols();"><img src="http://www.newco.dev.br/images/anadir.gif"/></a></span>';
		hayColOculta='S';
	}

	// Anyadimos dos celdas vacias en las cabeceras (representan la columna de posicion y la columna de cabeceras verticales)
	cadenaHtml=cadenaHtml+cellTitleStartIndic+cellEnd;
	cadenaHtml=cadenaHtml + cellTitleStartIndic + 
            '<a href="javascript:OrdenarPorColumna(-1);">' + txtConcepto + '</a>' + mostrarCol + cellEnd;

	for(var i=0;i<NumCabeceraH;i++){
		cadenaBorrarCol = '';

		// Si la columna esta activa, la dibujamos
		if(ColumnaActiva[FilaOrdenada[i]] == 'S'){
			if((ColumnaOrdenacion==(FilaOrdenada[i]))&&(Orden!=''))
				cellTitleStartMod = cellTitleStartClass;
			else
				cellTitleStartMod = cellTitleStart;

			if(i!=(NumCabeceraH-1) && matrizPrecalculada == 'N'){
				cadenaBorrarCol = '&nbsp;<a href="javascript:esconderCol(\'' + FilaOrdenada[i] + '\')"><img src="http://www.newco.dev.br/images/contraer.gif"/></a>';
			}

			cadenaHtml=cadenaHtml+ cellTitleStartMod +'<a href="javascript:OrdenarPorColumna('+FilaOrdenada[i]+');">'+ NombresCabeceraH[FilaOrdenada[i]]+'</a>'+cadenaBorrarCol+cellEnd;
                }
	}

	cadenaHtml=cadenaHtml+'</tr>';

	return cadenaHtml;
}

// Peticion ajax que devuelve los valores de las marcas <MOSTRARCATEGORIAS> y <MOSTRARGRUPOS> para la empresa seleccionada
// De esta manera construimos los desplegables de los diferentes niveles segun corresponda
function NivelesEmpresa(IDPadre,nivel){
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

// Peticion ajax que devuelve una lista segun el nivel que se pida (Categorias, Familias, Subfamilias, Grupos o Productos Estandar)
// Se crean las filas y los menus desplegables segun corresponda
function ListaNivel(IDPadre,tipo){
	// Si elegimos alguna de las opciones guardadas de seleccion, no se lanza peticion ajax
	if(IDPadre.substr(0,4) == 'SEL_')
		return;
	// Si elegimos alguna de las opciones que agrupan varios casos de los desplegables de categorias, no avanzamos al siguiente nivel
	else if(IDPadre < -1){
		VaciaNiveles(tipo);
		return;
        }

	var sql = encodeURIComponent(' ' + FiltroSQL.replace(/\'/g, "''"));
	var IDEmpresa;

	// Si existe #IDEMPRESA => usuario MVM o MVMB 
	if(jQuery("#IDEMPRESA").length > 0){
		IDEmpresa = jQuery("#IDEMPRESA").val();
	// Si NO existe #IDEMPRESA => Cliente
        }else
		IDEmpresa = IDEmpresaDelUsuario;

	jQuery.ajax({
		cache:	false,
		url:	'EISListaNivel.xsql',
		type:	"GET",
		data:	"IDEmpresa="+IDEmpresa+"&IDPadre="+IDPadre+"&IDIndicador="+IDIndicador+"&FiltroSQL="+sql+"&Tipo="+tipo,
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
					VaciaNiveles('GRU');
					jQuery("#" + data.Field.name).empty();
					jQuery("#" + data.Field.name).removeAttr("disabled");
					jQuery("#" + data.Field.name).unbind('change').bind('change',function(){ NivelesEmpresa(this.value,'GRU'); });
				}
			}else if(tipo == 'GRU'){
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

			for(var i=0;i<data.ListaNivel.length;i++){
				jQuery("#" + data.Field.name).append("<option value='"+data.ListaNivel[i].id+"'>"+data.ListaNivel[i].nombre+"</option>");
				jQuery("#" + data.Field.name).val("-1");
			}

			// Esto se ejecuta en el caso que se haya enviado el formulario seleccionando valores del filtro de catalogo privado
			if(Parametros[data.Field.name] != null){
				jQuery("#" + data.Field.name).val(Parametros[data.Field.name]);

				// Se dispara el evento onchange recursivamente que devuelve los desplegables del catalogo privado si han sido seleccionados
				if(Parametros[data.Field.name] != -1){
					jQuery("#" + data.Field.name).trigger("change");
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





//	Genera de forma dinamica la tabla de datos del EIS (en %)
function generarTabla(tipo){
	// Redefinimos la variable tipoMatriz (se ha escogido otra presentacion de la matriz: 'A','V' o 'H')
	if(tipo != '')	tipoMatriz = tipo

	// Recogemos el valor de la tolerancia, si existe (para matrices precalculadas no se utiliza)
	if(matrizPrecalculada == 'N')
		var tolerancia = jQuery('#tolerancia').val();

	//debugMatriz();		//solodebug!!!!

	CalcularColumnaTotales();	// Calcula el acumulado para la columna de totales
	CalcularFilaTotales();		// Calcula el acumulado para la fila de totales

	// Utilizamos la variable auxiliar Val para trabajar con los valores acumulados (Valores)
        // o porcentuales (ValoresNormV o ValoresNormH) segun el tipo de matriz elegida
	if(tipoMatriz == 'V'){
		NormalizadorVertical();
		Val = ValoresNormV;
	}else if(tipoMatriz == 'H'){
		NormalizadorHorizontal();
		Val = ValoresNormH;
	}else if(tipoMatriz == 'A'){
		NormalizadorVertical();	// Para mostrar los colores segun la tolerancia
		Val = Valores;
        }

	//si filtramos por ratio quitamos totales
	var formMatriz = document.forms[0];
	try{
		var ratio = formMatriz.elements['IDRESULTADOS'].value;
	}catch(err){
		ratio='NO_RATIO';
	}

	var linea=0;
	var pos = 0, f_pos;
	var HayOcultas='N';

	//	Total para cada indicador
	var Totales=new Array(NumCabeceraH);
	for(k=1;k<=NumCabeceraH;k++)  Totales[k]=0;

	var Clase,Comentario,thisCellValNorm,TotalValNorm;
	var cellStartThis = '';

	var cadenaHtml='';

	if(ResultadosTabla['MAX_LINEAS_'+IDIndicador] > 0 && ResultadosTabla['MAX_LINEAS_'+IDIndicador] != ''){
		var IDIndicadorActual='', totalCol, linkToEIS='';

		for(var i=0;i<NumLineas;i++){
			totalCol=0;

			//	Comprueba si la linea esta activa
			if(LineaActiva[ColumnaOrdenada[i]]=='S'){
				linea++;
				pos++;

			// Dibujamos la cabeceras horizontal cada 25 lineas
			if((pos-1)%25 == 0)	cadenaHtml = dibujarCabeceraH(cadenaHtml);

				//	Comprueba cambio de Indicador
				if(IDIndicadorActual!=IDIndicadores[ColumnaOrdenada[i]]){
					//	Muestra la linea de totales correspondiente al indicador anterior
					if(IDIndicadorActual!=''){
						//si filtramos por ratio no ensenyo totales
						if(ratio == 'RATIO'){
							cadenaHtml=cadenaHtml;
						}else{
							cadenaHtml=cadenaHtml+LineaTotalesHTML(IDIndicadorActual, Totales, linea, HayOcultas);
						}

						//	Inicializa la linea de totales
						for(k=1;k<=NumCabeceraH;k++)  Totales[k]=0;
					}

					pos=1;

					cadenaHtml=cadenaHtml+rowIndStart+cellIndStart+NombresIndicadores[ColumnaOrdenada[i]]+cellEnd+rowEnd;
					IDIndicadorActual=IDIndicadores[ColumnaOrdenada[i]];
				}

				//cellStartThis=Replace(cellGroupStart,'#IDINDICADOR#',IDIndicadorActual);
				//cellStartThis=Replace(cellStartThis,'#IDGRUPO#',IDGrupos[ColumnaOrdenada[i]]);
				//cellStartThis= linea+cellStartThis;
				//cellStartThis=Replace(cellStartThis,'#CLASEPAROIMPAR#',((linea%2)==0?'par':'impar'));

				//para ensenyar
				if(pos < 10){
					f_pos = '00'+pos;
				}else if(pos<100){
					f_pos = '0'+pos;
				}else{
					f_pos = pos;
				}

				if((FilaOrdenacion==(ColumnaOrdenada[i]))&&(FOrden!=''))
					cellTitleStartIndicMod = cellTitleStartIndicClass;
				else
					cellTitleStartIndicMod = cellTitleStartIndic;

				//cadenaHtml=cadenaHtml+Replace(rowStart,'#CLASEPAROIMPAR#',((linea%2)==0?'par':'impar'))+'<td align="left">'+pos+cellStartThis+Replace(macroEnlaceGrupo,'#IDGRUPO#',IDGrupos[ColumnaOrdenada[i]])+NombresGrupos[ColumnaOrdenada[i]]+'</a>'+cellEnd;
				cadenaHtml=cadenaHtml+Replace(rowStart,'#CLASEPAROIMPAR#',((linea%2)==0?'par':'impar'))+'<td align="left">'+f_pos+cellEnd;
				cadenaHtml=cadenaHtml+cellTitleStartIndicMod+Replace(macroEnlaceGrupo,'#NUM_FILA#',ColumnaOrdenada[i])+NombresGrupos[ColumnaOrdenada[i]]+'</a>'+cellEnd;

				for(var k=1;k<=NumCabeceraH;k++){
                                    if(ColumnaActiva[FilaOrdenada[k-1]] == 'S'){

					Clase='celdanormal';
					if(k<NumCabeceraH){
						Enlace=macroEnlaceNormal;
						// Si es matriz precalculada el color de la fuente viene en el XML y se guarda en el array 'Colores'
                                                if(matrizPrecalculada == 'S'){
							if(Colores[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]]=='Rojo')	Clase='rojo1';
							if(Colores[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]]=='Grave')	Clase='rojo2';
							if(Colores[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]]=='Verde')	Clase='verdeNormal';
							if(Colores[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]]=='Nuevo')	Clase='verdeNormal';
						// Si no es precalculada, el color de la fuente se calcula segun la tolerancia respecto los valores normalizados
						}else{
							if(tipoMatriz != 'H'){
								// Valor normalizado vertical de la celda
								thisCellValNorm = ValoresNormV[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]];
								// Valor normalizado vertical de la fila (columna totales)
								TotalValNorm = ColumnaTotalesPercent_V[ColumnaOrdenada[i]];
                                                        }else{
								// Valor normalizado horizontal de la celda
								thisCellValNorm = ValoresNormH[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]];
								// Valor normalizado horizontal de la fila (fila totales)
								TotalValNorm = FilaTotalesPercent_H[FilaOrdenada[k-1]];
                                                        }

							// Ajustamos los colores de la fuente de la celda segun la tolerancia elegida
							if(thisCellValNorm > (TotalValNorm + TotalValNorm*tolerancia))
								Clase='verdeNormal';
							else if(thisCellValNorm < (TotalValNorm - TotalValNorm*tolerancia))
								Clase='rojo2';
						}
					}else{
						Enlace=macroEnlaceNormal;

					}

					if(Comentarios[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]] != ''){
						Clase		= Clase + ' tooltip';
						Comentario	= '<span class="classic spanEIS">' + Comentarios[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]].replace(/\[SALTO\]/g,'<br />') + '</span>';
                                        }else{
						Comentario	= '';
                                        }

					Enlace=Replace(Enlace,'#CLASS#',Clase);
					Enlace=Replace(Enlace,'#IDGRUPO#',IDGrupos[ColumnaOrdenada[i]]);
					Enlace=Replace(Enlace,'#IDCABECERA_H#',IDCabeceraH[FilaOrdenada[k-1]]);
					Enlace=Replace(Enlace,'#LINEA#',ColumnaOrdenada[i]+1);
					Enlace=Replace(Enlace,'#COLUMNA#',FilaOrdenada[k-1]+1);
					Enlace=Replace(Enlace,'#COMENTARIO#',Comentarios[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]]);

                                        if(ComCol[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]] != 'NORMAL')
						Enlace=Replace(Enlace,'#COM_COLOR#',ComCol[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]]);
					else
						Enlace=Replace(Enlace,'#COM_COLOR#','');

					Clase		= ComCol[ColumnaOrdenada[i] * NumCabeceraH + FilaOrdenada[k-1]];
					cellStartThis	= Replace(cellStart,'#CLASS#',Clase);
					cellStartThis	= Replace(cellStartThis,'#ID#',IDGrupos[ColumnaOrdenada[i]]+'x'+IDCabeceraH[FilaOrdenada[k-1]]);

					//formatNumbre
					//cadenaHtml=cadenaHtml+cellStart+Enlace+FormatNumber( parseFloat(Valores[ColumnaOrdenada[i]*13+k-1]),0,',','.')+'</a>'+cellEnd;
					//cadenaHtml=cadenaHtml+cellStart+Enlace+FormatNumber(Valores[ColumnaOrdenada[i]*13+k-1],0,',','.')+'</a>&nbsp;'+cellEnd;
					//cadenaHtml=cadenaHtml+cellStart+Enlace+Valores[ColumnaOrdenada[i]*13+k-1]+'</a>&nbsp;'+cellEnd;

					// Si no es matriz precalculada, la columna totales se calcula
					// Tb se muestra link hacia el EIS con los mismos parametros
					if(matrizPrecalculada=='N' && k==NumCabeceraH){
						if(tipoMatriz == 'A'){
//							Valor		= FormatNumber(totalCol,4,',','.');
							Valor = FormatNumber(ColumnaTotales[ColumnaOrdenada[i]],4,',','.');
						}else if(tipoMatriz == 'H'){
//							Valor		= FormatNumber(totalCol,4,',','.');
							Valor = FormatNumber(ColumnaTotalesPercent_H[ColumnaOrdenada[i]],4,',','.');
						}else if(tipoMatriz == 'V'){
//							Valor		= FormatNumber(totalCol,4,',','.');
							Valor = FormatNumber(ColumnaTotalesPercent_V[ColumnaOrdenada[i]],4,',','.');
						}

						linkToEIS	= '<a href="javascript:linkToEIS(\'' + IDGrupos[ColumnaOrdenada[i]] + '\',\'V\')"><img src="http://www.newco.dev.br/images/verGrafico.gif" width="10px"/></a>';
					}else{
						Valor		= (Val[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]] != 0) ? FormatNumber(Val[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]],4,',','.') : '.';
						totalCol	= totalCol + Val[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]];
						linkToEIS = '';
					}
					// Si es matriz porcentual y no tenemos un cero => anyadimos % al final
					if(tipoMatriz != 'A' && Valor != '.')	Valor = Valor + '%';

					Enlace=Replace(Enlace,'#VALOR#',Valor);

					cadenaHtml=cadenaHtml+cellStartThis+Enlace+Valor+Comentario+'</a>&nbsp;'+linkToEIS+cellEnd;
/*
					if(Val[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]] < 1 && Val[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]] > 0){
						//cadenaHtml=cadenaHtml+cellStartThis+Enlace+FormatNumber(Valores[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]],4,',','.')+'</a>&nbsp;'+cellEnd;
						//cadenaHtml=cadenaHtml+cellStartThis+Imagen+Enlace+Valor+Comentario+'</a>&nbsp;'+cellEnd;
						cadenaHtml=cadenaHtml+cellStartThis+Enlace+Valor+Comentario+'</a>&nbsp;'+cellEnd;
					}else{
						//cadenaHtml=cadenaHtml+cellStartThis+Enlace+FormatNumber(Valores[ColumnaOrdenada[i]*NumCabeceraH+FilaOrdenada[k-1]],4,',','.')+'</a>&nbsp;'+cellEnd;
						//cadenaHtml=cadenaHtml+cellStartThis+Imagen+Enlace+Valor+Comentario+'</a>&nbsp;'+cellEnd;
						cadenaHtml=cadenaHtml+cellStartThis+Enlace+Valor+Comentario+'</a>&nbsp;'+cellEnd;
					}
*/
                                }
				}
				cadenaHtml=cadenaHtml+rowEnd;
			}else
				HayOcultas='S';
		}

		//si filtramos por ratio no ensenyo totales
		if(ratio == 'RATIO'){
			cadenaHtml=cadenaHtml;
		}else{
			//cadenaHtml=cadenaHtml+LineaTotalesHTML(IDIndicadorActual, Totales, linea);
			cadenaHtml=cadenaHtml+LineaTotalesHTML_2(IDIndicadorActual, Totales, linea);
		}
	}else{
		cadenaHtml=cadenaHtml+'<tr>'+cellIndCStart+txtSinResultados+cellEnd+rowEnd;
	}

	//cadenaHtml=cadenaHtml+'<tr class="subTituloTabla"><td colspan="14" align="left">'+BotonArribaHTML(txtTodos, 'Seleccionar', 'javascript:Seleccionar();', 50)+BotonArribaHTML(txtResultados, 'Dejar todos los seleccionados', 'javascript:Activar(true);', 50)+BotonArribaHTML(txtVolver, 'Ver todas las lineas de datos', 'javascript:TodasLineasActivas();', 50)+'</td></tr>';
	cadenaHtml=cadenaHtml+rowIndStart+cellIndStart+cellEnd+rowEnd;

	// Dibujamos cabecera horizontal al final de la tabla
	cadenaHtml = dibujarCabeceraH(cadenaHtml);

	jQuery("#TablaDatos").empty();
	jQuery("#TablaDatos").html(cadenaHtml);
	jQuery("#waitBox").hide();
	jQuery("#MostrarCuadro").show();
}

function periodoAnterior(){
	var mesInicio	= jQuery('#MESINICIO').val()
	var mesFinal	= jQuery('#MESFINAL').val()
	var annoInicio	= jQuery('#ANNOINICIO').val()
	var annoFinal	= jQuery('#ANNOFINAL').val()
	var Inicio	= new Date(annoInicio, mesInicio - 1, 0);	// Months are zero-based in javascript
	var Final	= new Date(annoFinal, mesFinal, 0);		// Months are zero-based in javascript
	var diff, nuevoMesInicio, nuevoAnnoInicio, nuevoMesFinal, nuevoAnnoFinal;

	diff = monthDiff(Inicio, Final) + 1; // Numero de meses

	var nuevaFecha	= new Date(annoInicio, mesInicio - 1, 1);
	nuevaFecha.setMonth(nuevaFecha.getMonth() - diff);

	nuevoMesFinal	= mesInicio - 1;
	nuevoAnnoFinal	= annoInicio;
	if(nuevoMesFinal == 0){
		nuevoMesFinal	= 12;
		nuevoAnnoFinal	= nuevoAnnoFinal - 1;
	}

	nuevoMesInicio	= nuevaFecha.getMonth() + 1;
	nuevoAnnoInicio	= nuevaFecha.getFullYear();

	// PARAMETROS FORMULARIO
	var IDIndicador		= jQuery('#INDICADOR').val();
	var IDAgruparPor_HOR	= jQuery('#AGRUPARPOR_HOR').val();
	var IDAgruparPor_VER	= jQuery('#AGRUPARPOR_VER').val();
	var IDEmpresa;
	if(jQuery('#IDEMPRESA').length > 0)
		IDEmpresa	= jQuery('#IDEMPRESA').val();
	else
		IDEmpresa	= IDEmpresaDelUsuario;
	var IDEmpresa2		= jQuery('#IDEMPRESA2').val();
	var IDGrupo		= jQuery('#IDGRUPO').val();
	var IDSubfamilia	= jQuery('#IDSUBFAMILIA').val();
	var IDFamilia		= jQuery('#IDFAMILIA').val();
	var IDCategoria		= jQuery('#IDCATEGORIA').val();
	var IDResultados	= -1;
	var Texto		= encodeURIComponent(jQuery('#TEXTO').val());

	var url	= 'http://www.newco.dev.br/Gestion/EIS/EISMatriz.xsql?INDICADOR='+IDIndicador+'&AGRUPARPOR_HOR='+IDAgruparPor_HOR+'&AGRUPARPOR_VER='+IDAgruparPor_VER+'&MESINICIO='+nuevoMesInicio+'&ANNOINICIO='+nuevoAnnoInicio+'&MESFINAL='+nuevoMesFinal+'&ANNOFINAL='+nuevoAnnoFinal+'&IDEMPRESA='+IDEmpresa+'&IDEMPRESA2='+IDEmpresa2+'&IDGRUPO='+IDGrupo+'&IDSUBFAMILIA='+IDSubfamilia+'&IDFAMILIA='+IDFamilia+'&IDCATEGORIA='+IDCategoria+'&IDRESULTADOS='+IDResultados+'&TEXTO='+Texto;

	MostrarPagPersonalizada(url,'',100,80,0,10);
}

function monthDiff(d1, d2) {
	var months;

	months = (d2.getFullYear() - d1.getFullYear()) * 12;
	months -= d1.getMonth() + 1;
	months += d2.getMonth();

	return months <= 0 ? 0 : months;
}

function esconderCol(columna){
	ColumnaActiva[columna]='N';

	generarTabla('');
}

function mostrarTodasCols(){
	// Marcamos todas las columnas como activas
	for(i=0;i<NumCabeceraH;++i)
		ColumnaActiva[i]='S';

	generarTabla('');
}

function linkToEIS(id,tipo){
	// Nuevos parametros para el EIS
	var anno, IDCuadroMando, IDEmpresa='-1', IDEmpresa2='-1', IDAgruparPor, IDCategoria='-1', IDFamilia='-1', IDSubfamilia='-1', IDGrupo='-1', IDProdEstandar='-1', Referencia='', IDCentro='-1';

	// Inicio calculo filtro anno
	var mesFinal	= jQuery('#MESFINAL').val();
	var annoFinal	= jQuery('#ANNOFINAL').val();
	var fechaActual	= new Date();

	if(annoFinal == fechaActual.getFullYear()){
		if(mesFinal == (fechaActual.getMonth() + 1)){	// Months are zero-based in javascript
			anno = 9999;	// Periodo ultimos 12 meses en el EIS
		}else{
			anno = annoFinal;
		}
	}else{
		anno = annoFinal;
	}
	// FIN calculo filtro anno

	// Inicio relacion filtro 'Cuadro de Mando' del EIS
	var IDIndicador	= jQuery('#INDICADOR').val();
	if(IDIndicador == 'CO_PED_EUR'){
		IDCuadroMando = 'CO_Pedidos_Eur';
	}else if(IDIndicador == 'CO_PED_CANT'){
		IDCuadroMando = 'CO_Pedidos_Cant';
	}else if(IDIndicador == 'CO_PED_IVA_EUR'){
		IDCuadroMando = 'CO_Pedidos_IVA_Eur';
	}
	// FIN relacion filtro 'Cuadro de Mando' del EIS

	// Inicio relacion filtro 'Empresas' (directa)
        if(jQuery('#IDEMPRESA').length > 0)
		IDEmpresa	= jQuery('#IDEMPRESA').val();
	else
		IDEmpresa	= IDEmpresaDelUsuario;
	// FIN relacion filtro 'Empresas'

	// Inicio relacion filtro 'Proveedor' (directa)
	IDEmpresa2	= jQuery('#IDEMPRESA2').val();
	// FIN relacion filtro 'Proveedor'

	// Inicio relacion filtro 'Categoria' (directa)
	IDCategoria	= jQuery('#IDCATEGORIA').val();
	// FIN relacion filtro 'Categoria'

	// Inicio relacion filtro 'Familia' (directa)
	IDFamilia	= jQuery('#IDFAMILIA').val();
	// FIN relacion filtro 'Familia'

	// Inicio relacion filtro 'Subfamilia' (directa)
	IDSubfamilia	= jQuery('#IDSUBFAMILIA').val();
	// FIN relacion filtro 'Subfamilia'

	// Inicio relacion filtro 'Grupo' (directa)
	IDGrupo		= jQuery('#IDGRUPO').val();
	// FIN relacion filtro 'Grupo'

	// Inicio relacion filtro 'Producto Estandar' (directa)
	IDProdEstandar	= jQuery('#IDPRODUCTOESTANDAR').val();
	// FIN relacion filtro 'Producto Estandar'

	// Inicio relacion filtro 'Agrupacion Horizontal' y 'Agrupacion Vertical' (van relacionadas)
	var IDAgruparPor_HOR	= jQuery('#AGRUPARPOR_HOR').val();
	var IDAgruparPor_VER	= jQuery('#AGRUPARPOR_VER').val();
	if(tipo == 'V'){
		IDAgruparPor = IDAgruparPor_HOR;

		if(IDAgruparPor_VER == 'EMP2'){
			IDEmpresa2	= id;
		}else if(IDAgruparPor_VER == 'FAM'){
			IDFamilia	= id;
		}else if(IDAgruparPor_VER == 'SUBFAM'){
			IDSubfamilia	= id;
		}else if(IDAgruparPor_VER == 'REF'){
			Referencia	= id;
		}
	}else if(tipo == 'H'){
		IDAgruparPor = IDAgruparPor_VER;

		if(IDAgruparPor_HOR == 'EMP'){
			IDEmpresa	= id;
		}else if(IDAgruparPor_HOR == 'CEN'){
			IDCentro	= id;
		}else if(IDAgruparPor_HOR == 'EMP2'){
			IDEmpresa2	= id;
		}
	}
	// FIN relacion filtro 'Agrupacion Horizontal'

	// Se construye la cadena de parametros y se define la url
	var params	= '?IDCUADROMANDO='+IDCuadroMando+'&ANNO='+anno+'&IDEMPRESA='+IDEmpresa+'&IDCENTRO='+IDCentro+'&IDEMPRESA2='+IDEmpresa2+'&IDPRODUCTO='+IDProdEstandar+'&IDGRUPO='+IDGrupo+'&IDSUBFAMILIA='+IDSubfamilia+'&IDFAMILIA='+IDFamilia+'&IDCATEGORIA='+IDCategoria+'&REFERENCIA='+Referencia+'&AGRUPARPOR='+IDAgruparPor
	var url		= 'http://www.newco.dev.br/Gestion/EIS/EISDatos2.xsql';

	// Se hace la llamada a la nueva pagina
	MostrarPagPersonalizada(url + params,'',100,80,0,10);
}

// Funcion que recalcula la columna de totales
// No hay que tener en cuenta las columnas ocultas
function CalcularColumnaTotales(){
	var Subtotal;

	for(var j=0;j<=NumLineas;j++){
		// Calcular La columna de totales
		Subtotal = 0;
		for(var i=0;i<(NumCabeceraH-1);i++){
			if(ColumnaActiva[FilaOrdenada[i]] == 'S') // Columnas no oculta
				Subtotal = Subtotal + Valores[ColumnaOrdenada[j] * NumCabeceraH + FilaOrdenada[i]];
		}
		ColumnaTotales[ColumnaOrdenada[j]] = Subtotal;
	}
}

// Funcion que recalcula la fila de totales
function CalcularFilaTotales(){
	var Subtotal;

	for(var j=0;j<=(NumCabeceraH-1);j++){
		// Calcular La fila de totales
		Subtotal = 0;
		for(var i=0;i<NumLineas;i++){
			if(LineaActiva[ColumnaOrdenada[i]] == 'S') // Fila no oculta
				Subtotal = Subtotal + Valores[ColumnaOrdenada[i] * NumCabeceraH + FilaOrdenada[j]];
		}
		FilaTotales[FilaOrdenada[j]] = Subtotal;
	}

	// Calculamos el valor de la columna de totales para la fila de totales
	Subtotal = 0;
	for(i=0;i<(NumCabeceraH-1);i++){
		if(ColumnaActiva[FilaOrdenada[i]] == 'S'){ // Columnas no ocultas
			Subtotal = Subtotal + FilaTotales[FilaOrdenada[i]];
                }
	}
	ColumnaTotales[NumLineas] = Subtotal;
}

function NormalizadorVertical(){
	var tipo = 'V';

	for(var i=0; i<(NumCabeceraH-1); i++){
		for(var j=0; j<NumLineas; j++){
			if(Valores[ColumnaOrdenada[j] * NumCabeceraH + FilaOrdenada[i]] != 0)
				ValoresNormV[ColumnaOrdenada[j] * NumCabeceraH + FilaOrdenada[i]] = Valores[ColumnaOrdenada[j] * NumCabeceraH + FilaOrdenada[i]] * 100 / FilaTotales[FilaOrdenada[i]];
			else
				ValoresNormV[ColumnaOrdenada[j] * NumCabeceraH + FilaOrdenada[i]]	= 0;
		}
		FilaTotalesPercent_V[FilaOrdenada[i]] = '100';
	}

	for(j=0; j<NumLineas; j++){
		ColumnaTotalesPercent_V[ColumnaOrdenada[j]] = ColumnaTotales[ColumnaOrdenada[j]] * 100 / ColumnaTotales[NumLineas];
	}
	ColumnaTotalesPercent_V[NumLineas] = 100;
}

function NormalizadorHorizontal(){
	var tipo = 'H';

	for(var i=0; i<(NumCabeceraH-1); i++){
		for(var j=0; j<NumLineas; j++){
			if(Valores[ColumnaOrdenada[j] * NumCabeceraH + FilaOrdenada[i]] != 0)
				ValoresNormV[ColumnaOrdenada[j] * NumCabeceraH + FilaOrdenada[i]] = Valores[ColumnaOrdenada[j] * NumCabeceraH + FilaOrdenada[i]] * 100 / ColumnaTotales[ColumnaOrdenada[j]];
			else
				ValoresNormV[ColumnaOrdenada[j] * NumCabeceraH + FilaOrdenada[i]]	= 0;
		}
		FilaTotalesPercent_H[FilaOrdenada[i]] = FilaTotales[FilaOrdenada[i]] * 100 / ColumnaTotales[NumLineas];
	}

	for(j=0; j<NumLineas; j++){
		ColumnaTotalesPercent_H[ColumnaOrdenada[j]] = '100';
	}
	ColumnaTotalesPercent_V[NumLineas] = 100;
}

function EvaluarTOPVertical(){
	var TOP_V = jQuery('#TOP_V').val();
	var i;

	// Si no se muestran todas las filas
	if(TOP_V != -1){
		// Ordenar previamente segun columna 'total' para marcar los valores TOP correctamente segun el array LineaActiva 
//		OrdenarPorColumna(NumCabeceraH-1, false);

		for(i=0; i<TOP_V; i++){
			LineaActiva[ColumnaOrdenada[i]] = 'S';
		}
		for(i=TOP_V; i<=NumLineas; i++){
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

function EvaluarTOPHorizontal(){
	var TOP_H = jQuery('#TOP_H').val();
	var i;

	// Si no se muestran todas las filas
	if(TOP_H != -1 && TOP_H != -2){
		// Ordenar previamente segun fila 'total' para marcar los valores TOP correctamente segun el array ColumnaActiva 
//		OrdenarPorFila('99999Total', false);

		for(i=0; i<TOP_H; i++){
			ColumnaActiva[FilaOrdenada[i]] = 'S';
		}

		for(i=TOP_H; i<(NumCabeceraH-1); i++){
			ColumnaActiva[FilaOrdenada[i]] = 'N';
		}

		// Volvemos a ordenar las ColumnaActiva visibles segun el criterio seleccionado por el usuario
//		OrdenarPorFila(FilaOrdenacion, false);

	}else if(TOP_H == -2){
		for (i=0; i<(NumCabeceraH-1); i++){
			CalcularFilaTotales(); // Recalculamos fila de totales por si hay filas que no se muestran

			if(FilaTotales[i] == 0)
				ColumnaActiva[i] = 'N';
			else
				ColumnaActiva[i] = 'S';
		}
	}else{
		for (i=0; i<(NumCabeceraH-1); i++){
			ColumnaActiva[i] = 'S';
		}
        }
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
		url:	'EISListaCentrosEmpresa.xsql',
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

				if(idEmpresa != -1) // Si la eleccion del desplegable NO es 'Todas' (Empresas)
					// Cuando se termina de informar el desplegable de centros => hacemos peticion para los desplegables del catalogo privado
					NivelesEmpresa(idEmpresa,'CAT');
			}
		}
	});
}

function TablaEISMatrizAjax(){
	var d = new Date();

	guardarValoresForm();

	// Por defecto los resultados del EIS se agrupan por Empresa (excepto admins - MVM o MVMB)
//	if(userDerechos != 'MVM' && userDerechos != 'MVMB')
//		if(AgruparPor == '-1')	AgruparPor = 'EMP';

	jQuery.ajax({
		cache:	false,
		url:	'EISMatriz_ajax.xsql',
		type:	"GET",
		data:	"INDICADOR="+IDIndicador+"&MESINICIO="+MesInicio+"&ANNOINICIO="+AnyoInicio+"&MESFINAL="+MesFinal+"&ANNOFINAL="+AnyoFinal+"&IDEMPRESA="+IDEmpresa+"&IDCENTRO="+IDCentro+"&IDEMPRESA2="+IDEmpresa2+"&IDGRUPO="+IDGrupo+"&IDSUBFAMILIA="+IDSubfamilia+"&IDFAMILIA="+IDFamilia+"&IDCATEGORIA="+IDCategoria+"&TEXTO="+Texto+"&AGRUPARPOR_HOR="+AgruparPorH+"&AGRUPARPOR_VER="+AgruparPorV+"&_="+d.getTime(),
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

			Orden = '';
			FOrden = '';
			// Redefinimos el array de los meses para la cabecera de la tabla
			ListaCabeceraH		= [];
			var items;
			jQuery.each(data.DatosEISMatriz[0].ListaCabeceraH, function(arrayID, centro){
				items			= [];
				items['nombre']		= centro.nombre;
				items['id']		= centro.id;
				ListaCabeceraH.push(items);
			});
			NumCabeceraH		= ListaCabeceraH.length;

			// Colocamos el nuevo nombre del indicador en la cabecera de la pagina
			var Indicador		= data.DatosEISMatriz[1].Indicador[0].nombre;
			jQuery('span#NombreIndicador').html(Indicador);

			// Redefinimos el objeto Resultados para la tabla, la grafica, etc....
			IDIndicador		= data.DatosEISMatriz[1].Indicador[0].id;
//			ConvertirPorcentaje	= data.DatosEISMatriz[1].Indicador[0].ConvPorcent;
//			mostrarFilaTotal	= data.DatosEISMatriz[1].Indicador[0].FilaTotales;

			ResultadosTabla	= {};
			ComentariosGen	= {};
			NombreFila	= [];
			ResultadosTabla['INDICADOR|'+data.DatosEISMatriz[1].Indicador[0].id]	= data.DatosEISMatriz[1].Indicador[0].nombre;
			ResultadosTabla['MAX_LINEAS_'+data.DatosEISMatriz[1].Indicador[0].id]	= data.DatosEISMatriz[4].MaxLineas;
			if(data.DatosEISMatriz[4].MaxLineas != ''){
				jQuery.each(data.DatosEISMatriz[2].Filas, function(arrayFilaID, fila){
					NombreFila.push(fila.NombreGrupo);
					ResultadosTabla['GRUPO|'+data.DatosEISMatriz[1].Indicador[0].id+'|'+fila.IDGrupo+'|'+fila.Linea] = fila.NombreGrupo;

					jQuery.each(fila.Columnas, function(arrayColID, columna){
						ResultadosTabla['RES|'+data.DatosEISMatriz[1].Indicador[0].id+'|'+fila.IDGrupo+'|'+fila.Linea+'|'+columna.Columna] = columna.Total;
						//ResultadosTabla['ROW|'+data.DatosEISMatriz[1].Indicador[0].id+'|'+fila.IDGrupo+'|'+fila.Linea+'|'+columna.Columna+'|COLOR'] = columna.Color;
					});
				});

				jQuery.each(data.DatosEISMatriz[3].Comentarios, function(arrayID, comentario){
					ComentariosGen[comentario.IDHor+'|'+comentario.IDVer]	= comentario.Comentario+'|'+comentario.Color;
				});
			}

			//	Preparamos los datos en las variables y mostramos el cuadro
			TodasLineasActivas();
		}
	});
}

function guardarValoresForm(){
	IDIndicador		= jQuery("#INDICADOR").val();
	MesInicio		= jQuery("#MESINICIO").val();
	AnyoInicio		= jQuery("#ANNOINICIO").val();
	MesFinal		= jQuery("#MESFINAL").val();
	AnyoFinal		= jQuery("#ANNOFINAL").val();
	if(jQuery("#IDEMPRESA").length > 0){
		IDEmpresa = jQuery("#IDEMPRESA").val();

		if(IDEmpresa == -1)	IDEmpresa = '';
        }else
		IDEmpresa = IDEmpresaDelUsuario;
	if(jQuery("#IDCENTRO").length > 0){
		IDCentro = jQuery("#IDCENTRO").val();

		if(IDCentro == -1)	IDCentro = '';
        }else
		IDCentro = '';
/*
	if(jQuery("#IDUSUARIO").length > 0)
		IDUsuarioSel = jQuery("#IDUSUARIO").val();
	else
		IDUsuarioSel = -1;
*/
	if(jQuery("#IDEMPRESA2").length > 0){
		IDEmpresa2		= jQuery("#IDEMPRESA2").val();

		if(IDEmpresa2 == -1)	IDEmpresa2 = '';
        }else
		IDEmpresa2		= '';
/*
	if(jQuery("#IDCENTRO2").length > 0)
		IDCentro2 = jQuery("#IDCENTRO2").val();
	else
		IDCentro2 = -1;

	if(jQuery("#IDPRODUCTOESTANDAR").length > 0)
		IDProducto		= jQuery("#IDPRODUCTOESTANDAR").val();
	else
		IDProducto		= -1;
*/
	if(jQuery("#IDGRUPO").length > 0){
		IDGrupo = jQuery("#IDGRUPO").val();

		if(IDGrupo == -1)	IDGrupo = '';
        }else
		IDGrupo = '';

	if(jQuery("#IDSUBFAMILIA").length > 0){
		IDSubfamilia		= jQuery("#IDSUBFAMILIA").val();

		if(IDSubfamilia == -1)	IDSubfamilia = '';
        }else
		IDSubfamilia		= '';

	if(jQuery("#IDFAMILIA").length > 0){
		IDFamilia		= jQuery("#IDFAMILIA").val();

		if(IDFamilia == -1)	IDFamilia = '';
        }else
		IDFamilia		= '';

	if(jQuery("#IDCATEGORIA").length > 0){
		IDCategoria = jQuery("#IDCATEGORIA").val();

		if(IDCategoria == -1)	IDCategoria = '';
        }else
		IDCategoria = '';

	Texto			= jQuery("#TEXTO").val();
	AgruparPorH		= jQuery("#AGRUPARPOR_HOR").val();
	AgruparPorV		= jQuery("#AGRUPARPOR_VER").val();

	return;
}