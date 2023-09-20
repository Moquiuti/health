//	ultima revision: 04-09-15

//	Variables globales
var celdaHoy	= 13, celdaIni	= 0, celdaFin	= 52, spanCelda	= 3,
		fechaHoyD	= new Date(),																										// Objeto fecha hoy
		fechaIniD	= new Date(fechaHoyD.valueOf() - ( 91 * 24 * 60 * 60 * 1000 )),		// Objeto fecha hace tres meses
		fechaFinD	= new Date(fechaHoyD.valueOf() + ( 274 * 24 * 60 * 60 * 1000 ));	// Objeto fecha dentro de 9 meses


jQuery(document).ready(globalEvents);

function globalEvents(){
	dibujarGantt();

	jQuery('input#GRAFICO').click(function(){
			jQuery("#tblData").toggle(!this.checked);
			jQuery("#tblGantt").toggle(this.checked);
	});
}

function dibujarGantt(){
	var htmlHead = '', htmlBody = '', htmlFoot = '';
	var fechaTxtHoyD = normalizarFecha(convertirFechaATexto(fechaHoyD));
	var fechaTxtIniD = normalizarFecha(convertirFechaATexto(fechaIniD));
	var fechaTxtFinD = normalizarFecha(convertirFechaATexto(fechaFinD));
//	var fechaAltaFormat, fechaAltaTime, fechaIniFormat, fechaIniTime, fechaFinFormat, fechaFinTime;
//	var countAlta, countEst, countIni, countFin;

	// htmlHead
	htmlHead += '<tr>';
	htmlHead += '<td class="veinte">&nbsp;</td>';
	for(var i=celdaIni; i<celdaFin; i++){
		htmlHead += '<td class="uno">&nbsp;</td>';
	}
	htmlHead += '</tr>';

	htmlHead += '<tr>';
	htmlHead += '<td class="veinte">&nbsp;</td>';
	for(i=celdaIni; i<celdaFin; i++){

		if(i === celdaIni){
			htmlHead += '<td colspan="4" style="font-size:11px;">' + fechaTxtIniD + '</td>';
		}else if(i>(celdaIni + spanCelda) && i<celdaHoy){
			htmlHead += '<td>&nbsp;</td>';
		}else if(i==celdaHoy){
			htmlHead += '<td colspan="4" style="font-size:11px;">' + fechaTxtHoyD + '</td>';
		}else if(i>(celdaHoy + spanCelda) && i<(celdaFin-spanCelda)){
			htmlHead += '<td>&nbsp;</td>';
		}else if(i==(celdaFin-spanCelda)){
			htmlHead += '<td colspan="4" style="font-size:11px;text-align:right;">' + fechaTxtFinD + '</td>';
		}
	}
	htmlHead += '</tr>';

	// htmlBody
	jQuery.each(arrLicitaciones, function(key, licitacion){

//		if(licitacion.IDEstado == 'CURS'){
//			htmlBody += dibujaLicitacionCURS(licitacion);
//		}else{
			htmlBody += dibujaLicitacion(licitacion);
//		}

	});

	jQuery('#tblGantt thead').append(htmlHead);
	jQuery('#tblGantt tbody').append(htmlBody);
	jQuery('#tblGantt tfoot').append(htmlFoot);
}

function dibujaLicitacion(obj){
	var fechaAltaFormat, fechaAltaTime, fechaIniFormat, fechaIniTime, fechaFinFormat, fechaFinTime;
	var countAlta=0, countEst=0, countIni=0, colorEst;
	var htmlBody = '<tr>';
	htmlBody += '<td style="font-size:10px;">' + obj.Titulo + '</td>';

	// Fomateamos las fechas para poder trabajar con ellas
	fechaAltaFormat = new Date('20' + obtenerSubCadena(obj.FechaAlta, 3) + '/' + obtenerSubCadena(obj.FechaAlta, 2) + '/' + obtenerSubCadena(obj.FechaAlta, 1));
	fechaAltaTime		= fechaAltaFormat.valueOf();
	fechaIniFormat 	= new Date('20' + obtenerSubCadena(obj.FechaIni, 3) + '/' + obtenerSubCadena(obj.FechaIni, 2) + '/' + obtenerSubCadena(obj.FechaIni, 1));
	fechaIniTime		= fechaIniFormat.valueOf();
	fechaFinFormat 	= new Date('20' + obtenerSubCadena(obj.FechaFin, 3) + '/' + obtenerSubCadena(obj.FechaFin, 2) + '/' + obtenerSubCadena(obj.FechaFin, 1));
	fechaFinTime		= fechaFinFormat.valueOf();

	// Cuantas celdas se quedan vacías (sin color)
	for(var i=celdaIni; i<celdaFin; i++){
		if((fechaAltaTime) > (fechaIniD.valueOf() + (i * 7 * 24 * 60 * 60 * 1000 ))){
			countAlta++;
		}else{
			break;
		}
	}
	if(countAlta)		htmlBody += '<td colspan="' + countAlta + '">&nbsp;</td>';

	// Cuantas celdas se quedan para estudio (color azul)
	for(i=countAlta; i<celdaFin; i++){
		if((fechaIniTime) > (fechaIniD.valueOf() + (i * 7 * 24 * 60 * 60 * 1000 ))){
			countEst++;
		}else{
			break;
		}
	}
	(obj.IDEstado === 'CURS') ? colorEst='#F8AD52' : colorEst='#5297F8';
	if(countEst)		htmlBody += '<td colspan="' + countEst + '" style="background-color:' + colorEst + ';">&nbsp;</td>';

	// Cuantas celdas se quedan para contrato (color verde)
	for(i=(countAlta + countEst); i<celdaFin; i++){
		if((fechaFinTime) > (fechaIniD.valueOf() + (i * 7 * 24 * 60 * 60 * 1000 ))){
			countIni++;
		}else{
			break;
		}
	}
	if(countIni)		htmlBody += '<td colspan="' + countIni + '" style="background-color:#54FB7B;">&nbsp;</td>';

	// Cuantas celdas se quedan caducadas (color rojo)
	if(celdaFin - countAlta - countEst - countIni)
		htmlBody += '<td colspan="' + (celdaFin - countAlta - countEst - countIni) + '" style="background-color:#F85252;">&nbsp;</td>';

	htmlBody += '</tr>';

	return htmlBody;
}
