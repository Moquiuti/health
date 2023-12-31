
jQuery(document).ready(globalEvents);

function globalEvents(){
	if(isCdC == 'S'){
		inicializarDesplegableCentros(IDCentro, IDLugarEntrega, IDCentroConsumo);
	}else{
		inicializarDesplegableLugaresEntrega(IDCentro, IDLugarEntrega);
		inicializarDesplegableCentrosConsumo(IDCentro, IDCentroConsumo);
		inicializarImportes();
	}

	CrearStatus();
}

function inicializarDesplegableCentros(centroSeleccionado, idLugarSeleccionado, idCentroConsumoSeleccionado){
	var oForm	= document.forms['Principal'];
	oForm.elements['IDCENTRO'].length	= 0;

	for(var n=0; n<arrayCentros.length; n++){
		if(arrayCentros[n][0] == centroSeleccionado){
			oForm.elements['IDCENTRO'].options[oForm.elements['IDCENTRO'].length]		= new Option('['+arrayCentros[n][1]+']',arrayCentros[n][0]);
			oForm.elements['IDCENTRO'].options[oForm.elements['IDCENTRO'].length-1].selected= true;

			//coste de transporte
			oForm.elements['COSTE_LOGISTICA'].value	= anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(arrayCentros[n][3]),2)),2);

			if(arguments.length>1){
				inicializarDesplegableLugaresEntrega(centroSeleccionado,idLugarSeleccionado);
				inicializarDesplegableCentrosConsumo(centroSeleccionado,idCentroConsumoSeleccionado);
			}else{
//				if(centroSeleccionado == centroInicial){
				if(centroSeleccionado == IDCentro){
//					inicializarDesplegableLugaresEntrega(centroSeleccionado, lugarInicial);
					inicializarDesplegableLugaresEntrega(centroSeleccionado, IDLugarEntrega);
//					inicializarDesplegableCentrosConsumo(centroSeleccionado, centroConsumoInicial);
					inicializarDesplegableCentrosConsumo(centroSeleccionado, IDCentroConsumo);
				}else{
					inicializarDesplegableLugaresEntrega(centroSeleccionado);
					inicializarDesplegableCentrosConsumo(centroSeleccionado);
				}
			}

			inicializarImportes();
		}else{
			oForm.elements['IDCENTRO'].options[oForm.elements['IDCENTRO'].length]	= new Option(arrayCentros[n][1],arrayCentros[n][0]);
		}
	}
}

function inicializarDesplegableLugaresEntrega(centroSeleccionado, lugarSeleccionado){
	var oForm	= document.forms['Principal'];
	oForm.elements['IDLUGARENTREGA'].length	= 0;

	for(var n=0; n<arrayLugaresEntrega.length; n++){
		if(arrayLugaresEntrega[n][1] == centroSeleccionado){
//			if(centroSeleccionado == centroInicial){
			if(centroSeleccionado == IDCentro){
				if(arrayLugaresEntrega[n][0] == lugarSeleccionado){
					oForm.elements['IDLUGARENTREGA'].options[oForm.elements['IDLUGARENTREGA'].length]		= new Option('['+arrayLugaresEntrega[n][3]+']',arrayLugaresEntrega[n][0]);//	ET	7mar08		+' ('+arrayLugaresEntrega[n][2]
					oForm.elements['IDLUGARENTREGA'].options[oForm.elements['IDLUGARENTREGA'].length-1].selected	= true;
					ActualizarTextoLugarEntrega(arrayLugaresEntrega[n][0]);
				}else{
					oForm.elements['IDLUGARENTREGA'].options[oForm.elements['IDLUGARENTREGA'].length]		= new Option(arrayLugaresEntrega[n][3],arrayLugaresEntrega[n][0]);
				}
			}else{
				if(arrayLugaresEntrega[n][8] == 'S'){
					oForm.elements['IDLUGARENTREGA'].options[oForm.elements['IDLUGARENTREGA'].length]		= new Option('['+arrayLugaresEntrega[n][3]+']',arrayLugaresEntrega[n][0]);
					oForm.elements['IDLUGARENTREGA'].options[oForm.elements['IDLUGARENTREGA'].length-1].selected	= true;
					ActualizarTextoLugarEntrega(arrayLugaresEntrega[n][0]);
				}else{
					oForm.elements['IDLUGARENTREGA'].options[oForm.elements['IDLUGARENTREGA'].length]		= new Option(arrayLugaresEntrega[n][3],arrayLugaresEntrega[n][0]);
				}
			}
		}
	}
}

function inicializarDesplegableCentrosConsumo(centroSeleccionado, centroConsumoSeleccionado){
	var oForm	= document.forms['Principal'];
	oForm.elements['IDCENTROCONSUMO'].length	= 0;

	for(var n=0; n<arrayCentrosConsumo.length; n++){
		if(arrayCentrosConsumo[n][1] == centroSeleccionado){
//			if(centroSeleccionado == centroInicial){
			if(centroSeleccionado == IDCentro){
				if(arrayCentrosConsumo[n][0] == centroConsumoSeleccionado){
					oForm.elements['IDCENTROCONSUMO'].options[oForm.elements['IDCENTROCONSUMO'].length]		= new Option('['+arrayCentrosConsumo[n][3]+']',arrayCentrosConsumo[n][0]);
					oForm.elements['IDCENTROCONSUMO'].options[oForm.elements['IDCENTROCONSUMO'].length-1].selected	= true;
				}else{
					oForm.elements['IDCENTROCONSUMO'].options[oForm.elements['IDCENTROCONSUMO'].length]		= new Option(arrayCentrosConsumo[n][3],arrayCentrosConsumo[n][0]);
				}
			}else{
				if(arrayCentrosConsumo[n][4]=='S'){
					oForm.elements['IDCENTROCONSUMO'].options[oForm.elements['IDCENTROCONSUMO'].length]		= new Option('['+arrayCentrosConsumo[n][3]+']',arrayCentrosConsumo[n][0]);
					oForm.elements['IDCENTROCONSUMO'].options[oForm.elements['IDCENTROCONSUMO'].length-1].selected	= true;
				}else{
					oForm.elements['IDCENTROCONSUMO'].options[oForm.elements['IDCENTROCONSUMO'].length]		= new Option(arrayCentrosConsumo[n][3],arrayCentrosConsumo[n][0]);
				}
			}
		}
	}
}

/************************************************************************************************
*	CrearStatus										*
*												*
************************************************************************************************/
function CrearStatus(){
	var oForm	= document.forms['PedidoMinimo'];
	var programable		= '';
	var status, mo_id, mini, total, estricto;

	for(var i=0; i<oForm.length; i++){
		if(oForm.elements[i].name.substring(0,5) == 'Total'){
			mo_id	= oForm.elements[i].name.substring(6);
			mini	= Number(reemplazaComaPorPunto(oForm.elements['Minimo_'+mo_id].value));
			total	= Number(reemplazaComaPorPunto(oForm.elements['Total_'+mo_id].value));
			estricto= oForm.elements['Estricto_'+mo_id].value;

			// Para abonos, no tenemos en cuanta el minimo
			if(total < 0){
				estricto='N';
			}

			//estricto
			//	N -> NO (activo)
			//	S -> SI (activo, NO estricto)
			//	E -> SI (estricto)
			if(estricto == 'N'){
				status	= 'S';
				if(total < 0){
					programable	= 'A';
				}else{
					programable	= 'S';
				}
			}else{
				if(total < mini){
					if(estricto == 'S'){
// 08jun15 - DC - Ya no se tiene en cuenta la tolerancia para pedidos minimos activos pero NO estrictos
//						// controlamos el indice de tolerancia
//						if(100-((total/mini)*100) > TOLERANCIA_IMPORTE_MINIMO){
//							status		= 'NT';
//							programable	= 'N';
//						}else{
							status		= 'C';
							programable	= 'C';
//						}
					}else{
						status		= 'N';
						programable	= 'N';
					}
				}else{
					status		= 'S';
					programable	= 'S';
				}
			}

			actualizarProgramable(mo_id, programable);
			actualizarEstado(mo_id, status);
		}
	}

//	CambiarImagenStatus();
	situarEnPagina('#inicio');
}

function actualizarProgramable(mo_id, estado){
	document.forms['PedidoMinimo'].elements['PED_PROGRAMABLE_'+mo_id].value	= estado;
}

function actualizarEstado(mo_id, estado){
	document.forms['PedidoMinimo'].elements['Status_'+mo_id].value	= estado;
}
/*
function CambiarImagenStatus(){
	var formPedido = document.forms['PedidoMinimo'];

	for(var j=0; j<document.images.length; j++){
		if(document.images[j].name.substring(0,6) == 'Imagen'){
			var mo_id	= document.images[j].name.substring(7);
			var status	= formPedido.elements['Status_'+mo_id].value;

			actualizarImagen(mo_id, status);
		}
	}
}

function actualizarImagen(idMultioferta, estado){
	var imgOK	= 'http://www.newco.dev.br/images/Botones/AceptarMO.gif';
	var imgKO	= 'http://www.newco.dev.br/images/Botones/CancelarMO.gif';
	var imgConsultar= 'http://www.newco.dev.br/images/Botones/ConsultarMO.gif';

	if(estado == 'S' || estado == 'SC'){
		//document.images['Imagen_'+idMultioferta].src=imgOK;
	}else{
		if(estado == 'N' || estado == 'NI' || estado == 'NC' || estado == 'NO' || estado == 'NT'){
			document.images['Imagen_'+idMultioferta].src	= imgKO;
		}else{
			document.images['Imagen_'+idMultioferta].src	= imgConsultar;
		}
	}
}
*/
function situarEnPagina(ancla){
	document.location.hash	= ancla;
	historia++;
}

function inicializarImportes(){
	var form;

	for(var i=0; i<document.forms.length; i++){
		form	= document.forms[i];

		for(var n=0; n<form.length; n++){
			//sumo a importe_total el coste_logistica
			if(form.elements[n].name.substring(0,16)=='MO_IMPORTETOTAL_' && form.elements[n].value!='Por definir'){
				//para pedidos mltiproveedor cojo el moid solo para asisa
				var temp = form.elements[n].name.split('_');
				var moidpedido = temp[2];
				var total = parseFloat(desformateaDivisa(form.elements[n].value));
				var coste = parseFloat(desformateaDivisa(form.elements['COSTE_LOGISTICA_'+moidpedido].value));
				var iva = parseFloat(desformateaDivisa(form.elements['IVA_'+moidpedido].value));

				// Si oculto_precio_ref = N y no es nuevo modelo de negocio sumo iva, viamed nuevo y brasil
				if(form.elements['OCULTO_PRECIO_REF_'+moidpedido].value == 'N' && form.elements['NUEVO_MODELO_NEGOCIO_'+moidpedido].value == 'N'){
					var totFinal = total + coste + iva; 
					totFinal = reemplazaPuntoPorComa(totFinal);
				}else{
					var totFinal = total + coste; 
					totFinal = reemplazaPuntoPorComa(totFinal);
				}

				// Aqui lo unico que hace es presentar el importe con 2 decimales en lugar de 4, pero no se cambia
				form.elements[n].value=anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(form.elements[n].value),2)),2);
			}

			// Este valor sera el total + iva + coste_logistica. Si Espa�a el coste ser� 0; si Brasil el iva sera 0
			if(form.elements[n].name.substring(0,16)=='MO_IMPORTEFINAL_' && form.elements[n].value!='Por definir'){
				// totFinal se calcula en el if anterior
				form.elements[n].value = totFinal;
				form.elements[n].value=anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(form.elements[n].value),2)),2);
			}//fin if mo_importefinal

			// Aqui lo unico que hace es presentar el importe con 2 decimales en lugar de 4
			if(form.elements[n].name.substring(0,14)=='MO_IMPORTEIVA_' && form.elements[n].value!='Por definir'){
				form.elements[n].value=anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(form.elements[n].value),2)),2);
			}
		}
	}
}

function ActualizarTextoLugarEntrega(idlugarEntrega){
	var oForm	= document.forms['Principal'];

	for(var n=0; n<arrayLugaresEntrega.length; n++){
		if(arrayLugaresEntrega[n][0] == idlugarEntrega){
			oForm.elements['CEN_DIRECCION'].value	= arrayLugaresEntrega[n][4];
			oForm.elements['CEN_CPOSTAL'].value	= arrayLugaresEntrega[n][5];
			oForm.elements['CEN_POBLACION'].value	= arrayLugaresEntrega[n][6];
			oForm.elements['CEN_PROVINCIA'].value	= arrayLugaresEntrega[n][7];
		}
	}
}

//
// Construye una String para el campo oculto COMENTARIOS_PROVEEDORES
// que tiene el formato siguiente |225#blabla#S#N$|213#bloblo#S#S$ 
//

// nacho 28.1.2005, incorporamos el check de urgencia
function GuardarComentarios(formPrincipal, linka, formPedido){
	// Esconder boton de continuar para evitar doble-click
	jQuery('#divEnviarPedido').hide();

	var coments	= '';
	var mo_id;

	// Construimos el string de comentarios.
	for(var i=0; i<formPrincipal.length; i++){
		var nom	= formPrincipal.elements[i].name;

		if(nom.indexOf("COMENTARIO_") != -1){
			mo_id	= nom.substring(nom.indexOf("_")+1,nom.length);
			coments	+= "|" + mo_id + "#" + formPrincipal.elements['COMENTARIO_'+mo_id].value + "#" + formPrincipal.elements['NUMERO_OFERT_PED_'+mo_id].value + "#";

			if(formPrincipal.elements['SolicitaComercial'+mo_id].checked){
				coments	+= "S#";
			}else{
				coments	+= "N#";
			}

			if(formPrincipal.elements['SolicitaMuestra'+mo_id].checked){
				coments	+= "S#";
			}else{
				coments	+= "N#";
			}

			if(formPrincipal.elements['NoComercial'+mo_id].checked){
				coments	+= "S#";
			}else{
				coments	+= "N#";
			}

			// las urgencias
			if(formPrincipal.elements['URGENTE_'+mo_id].checked){
				coments	+= "S$";
			}else{
				coments	+= "N$";
			}
		}
	}

	formPrincipal.elements['COMENTARIOS_PROVEEDORES'].value	= coments;

	if(ComprobarPedidoMinimo(formPrincipal,formPedido) == true){
		AsignarAccion(formPrincipal, linka);
		SubmitForm(formPrincipal, document);
	}
}

/************************************************************************************************
*	ComprobarPedidoMinimo									
*
*	Comprobamos los pedidos con los semaforos para evaluar los pedidos que realmente vamos
*	a mandar y los pedidos que no vamos a mandar.
*	Guardamos el string en ENVIAR_OFERTAS.
*
************************************************************************************************/
function ComprobarPedidoMinimo(formu, formPedido){
	var StringEnviar	= "";
	var numPedidos		= 0;
	var numPedidosRechazados= 0;

	// Miramos el total de pedidos
	for(var i=0; i<formPedido.length; i++){
		if(formPedido.elements[i].name.substring(0,5) == 'Total'){
			numPedidos++;
		}
	}

	// Recorremos todos los pedidos
	for(i=0;i<formPedido.length;i++){
		if(formPedido.elements[i].name.substring(0,5) == 'Total'){
			var mo_id	= formPedido.elements[i].name.substring(6);
			var status	= formPedido.elements['Status_'+mo_id].value;
			var nombre	= formPedido.elements['Nombre_'+mo_id].value;
			var minimo	= formPedido.elements['Minimo_'+mo_id].value;

			StringEnviar	+= "("+mo_id+",";

			if(status == "C"){
				status	= solicitarAccion(mo_id);
				if(status == 'NC'){
					return false;
				}
			}else{
				if(numPedidos > 1){
					if(status == 'N' || status == 'NI'){
						if(solicitarAccion(mo_id) == 'N'){
							return false;
						}
					}
				}
			}

			StringEnviar	+= status.substring(0,1)+'),';

			// Para crear el estado a S o a N (= no se envia) coje el primer valor de status, si es NT =>N entonces no envia
			if(status == 'N' || status == 'NO' || status == 'NC' || status == 'NI'){
				numPedidosRechazados++;
			}
		}
	}

	// En el caso de que todos los pedidos esten rechazados volvemos
	// Volvemos a la pagina anterior para que modifique las cantidades
	if(numPedidos > 1){
		if(numPedidos == numPedidosRechazados){
			alert(msgSinElementosRedireccion);
			return false;
		}
	}else{
		if(status == 'NC'){
			if(confirm(msgMinimoFlexible_C1_Semaforo+nombre+msgMinimoFlexible_C2_Semaforo+minimo+msgMinimoFlexible_C3_Semaforo+msgMinimoFlexible_C4_ComprobacionFinal)){
				return true;
			}else{
				return false;
			}
		}else{
			if(status == 'N' || status == 'NI'){
				var totalPedidoSinIva	= formu.elements['MO_IMPORTETOTAL_'+mo_id].value;

				alert(msgMinimoEstricto_C1_Semaforo+nombre+msgMinimoEstricto_C2_Semaforo+minimo+suPedidoEs+totalPedidoSinIva+ivaNoIncluida);
				return false;
			}else{
				if(status == 'NT'){
        	    //minimo=reemplazaPuntoPorComa(Round(reemplazaComaPorPunto(minimo)-reemplazaComaPorPunto(minimo)*(TOLERANCIA_IMPORTE_MINIMO/100),2));
                //alert('minimo222 status '+minimo+ status);
        	    //quitado 30/07/2013 problemas asisa
                //alert(msgMinimoEstricto_C1_Semaforo+nombre+msgMinimoEstricto_C2_Semaforo+minimo+msgMinimoEstricto_C3_Semaforo+msgMinimoEstricto_C4_ComprobacionFinal);
        	    //return false;
				}
			}
		}
	}

	StringEnviar	= StringEnviar.substring(0,StringEnviar.length-1);

	// Si estado NT significa que es pedido asisa bajo el pedido minimo, permitido en algunos casos, a�aden productos en comentarios
	// Lo pongo aqu� porqu� si no para pedidos multiprov falla, string enviar se crea con mo_id y primera letra del estado, si es NT = N y no envia

	if(status == 'NT'){	StringEnviar	= '('+mo_id+',S)'; }

	// Enviamos si hay por lo menos una oferta o pedido a enviar
	if(StringEnviar.indexOf("S") == -1){
		alert(msgSinElemento);
		return false;
	}else{
		formu.elements['ENVIAR_OFERTAS'].value	= StringEnviar;
		return true;
	}
}

function solicitarAccion(mo_id){
	var oForm	= document.forms['PedidoMinimo'];
	var estado	= oForm.elements['Status_'+mo_id].value;
	var nombre	= oForm.elements['Nombre_'+mo_id].value;
	var minimo	= oForm.elements['Minimo_'+mo_id].value;
	var programable;

	situarEnPagina('#multioferta_'+mo_id);

	if(estado == 'C'){
		// Podemos cambiar el estado
		estado		= 'SC';
		programable	= 'C';

//		actualizarImagen(mo_id,estado);
		actualizarEstado(mo_id,estado);
		actualizarProgramable(mo_id,programable);
		return estado;
	}else{
		// No podemos cambiar el estado, pero podemos abortar el proceso
		if(estado == 'N' || estado == 'NI' || estado == 'NO'){
			if(confirm(msgMinimoEstricto_C1_Semaforo+nombre+msgMinimoEstricto_C2_Semaforo+minimo+msgMinimoEstricto_C3_ComprobacionFinal_excluir+msgMinimoEstricto_C4_ComprobacionFinal_excluir)){
				return 'S';
			}else{
				return 'N';
			}
		}
	}
}

function calculaFecha(nom, mas){ // nom:nombre del combo; mas:incremento del "delay" cf sabado, domingo...
/*
	Modificado por Nacho Garcia
	fecha: 19/8/2002

	Se calculan los dias habiles

	Modificado por Nacho Garcia
	fecha: 14/9/2001

	A la hora de calcular la fecha hay un caso especial que es que la fecha de entrega no se quiera informar.
	en ese caso la fecha es NULL

	Modificado por E.T.
	fecha: 31/12/2001

	Modificado por Nacho
	fecha: 15/01/2002

	Cambios introducidos:
	- Utiliza las funciones de suma de fechas de Javascript
	- Separar el tratamiento de los controles del tratamiento de las fechas
	- Correcci�n del error en Netscape y Mozilla que presenta la fecha 101 en lugar de 2001
	- Correcci�n del error en todas las plataformas que presenta fecha 0/mm/yyyy
*/
	var oForm	= document.forms['Principal'];

	if(nom == 'ENTREGANO' && oForm.elements['IDPLAZO'+nom].options[oForm.elements['IDPLAZO'+nom].selectedIndex].value == 0){
		oForm.elements['FECHANO_ENTREGA'].value	= '';
	}else{
		var hoy	= new Date(); 
		/*
			nacho 13/11/2002
			para la entrega y la decision se calculan dias habiles
			para el pago naturales
		*/

		if(nom == 'ENTREGA' || nom == 'DECISION'){
			if(mas == 999){
				mas	= PlazoEntregaInicial;
			}

			var Resultado	= calcularDiasHabiles(hoy,mas);
		}else{
			if(mas == 999){
				mas	= 0;
			}

			var Resultado	= sumaDiasAFecha(hoy, mas);

			// Gestion de los sabados y domingos...
			diaSemana	= Resultado.getDay();
			if(diaSemana == 0)
				Resultado	= sumaDiasAFecha(Resultado,1);
			else if(diaSemana == 6)
				Resultado	= sumaDiasAFecha(Resultado,2);
		}

		// Imprimir datos en los textbox en el formato dd/mm/aaaa....
		var elDia	= Resultado.getDate();
		var elMes	= Number(Resultado.getMonth())+1;
		var elAnyo	= Resultado.getFullYear();
		var laFecha	= elDia+'/'+elMes+'/'+elAnyo;

		if(nom == 'ENTREGANO'){
			oForm.elements['FECHANO_ENTREGA'].value = laFecha;
		}else{
			oForm.elements['FECHA_'+nom].value = laFecha;
		}
	}
}

function calculaFechaCalendarios(mas){
	var hoy		= new Date();
	var Resultado	= calcularDiasHabiles(hoy,mas);
	var elDia	= Resultado.getDate();
	var elMes	= Number(Resultado.getMonth())+1;
	var elAnyo	= Resultado.getFullYear();
	var laFecha	= elDia+'/'+elMes+'/'+elAnyo;

	return laFecha;
}

function actualizarPlazo(form,nombreObj, fFechaOrigen){
	var fechaOrigen		= fFechaOrigen.getDate()+'/'+(Number(fFechaOrigen.getMonth())+1)+'/'+fFechaOrigen.getFullYear();
	var fechaDestino	= form.elements['FECHA_'+nombreObj].value;
	var nombreCombo;

	if(CheckDate(fechaDestino) == ''){
		var fFechaDestino	= new Date(formatoFecha(fechaDestino,'E','I'));

		if(nombreObj == 'ENTREGA'){
			var diferencia	= diferenciaDias(fFechaOrigen,fFechaDestino,'HABILES');
			nombreCombo	= 'COMBO_'+nombreObj;
		}else{
			var diferencia	= diferenciaDias(fFechaOrigen,fFechaDestino,'NATURALES');
			nombreCombo	= 'IDPLAZOPAGO';
		}

		asignarValorDesplegable(form, nombreCombo, diferencia);
	}else{
		alert(CheckDate(fechaDestino));
	}
}

function asignarValorDesplegable(form, nombreObj, valor){
	var indiceSeleccionado	= form.elements[nombreObj].length-1;

	for(var n=0; n<form.elements[nombreObj].length; n++){
		if(form.elements[nombreObj].options[n].value == valor){
			indiceSeleccionado	= n;
		}
	}

	form.elements[nombreObj].selectedIndex	= indiceSeleccionado;
}

function ProgramarPedido(formPrincipal, linka, formPedido, idMultioferta, objPedidoProgramable){
	var msgProgramacion;
	var abortar	= 0;
	var nombre	= formPedido.elements['Nombre_'+idMultioferta].value;
	var minimo	= formPedido.elements['Minimo_'+idMultioferta].value;

	// Los pedidos urgentes no se pueden programar
	if(formPrincipal.elements['URGENTE_'+idMultioferta].checked == true){
		msgProgramacion	= msgPedidosUrgentasProgramacion;
		alert(msgProgramacion);
		return;
	}else if(formPedido.elements[objPedidoProgramable].value == 'N'){
		//msgProgramacion	= msgProgramacionPedidosEstrictos;

		msgProgramacion	= msgMinimoEstricto_C1_Semaforo+nombre+msgMinimoEstricto_C2_Semaforo+minimo+msgPrograma_C3_Semaforo;
		abortar		= 1;
	}else if(formPedido.elements[objPedidoProgramable].value == 'C'){
		//msgProgramacion	= msgProgramacionPedidosFexiblesInferior;

		msgProgramacion	= msgMinimoFlexible_C1_Semaforo+nombre+msgMinimoFlexible_C2_Semaforo+minimo+msgPrograma_C3_Semaforo;
		abortar		= 1;
	}else if(formPedido.elements[objPedidoProgramable].value == 'A'){
		msgProgramacion	= msgProgramacionAbonos;
		abortar		= 1;
	}

	if(abortar){
		alert(msgProgramacion);
		return;
	}

	// Miramos que no nos pasen la numeracion de la clinica.
	// en este punto no tiene sentido. el pedido que estamos preparando 
	// se utiliza como modelo
	if(formPrincipal.elements['NUMERO_OFERT_PED_'+idMultioferta].value != ''){
		if(confirm(msgNumeroPedidoClinicaParaPrograma)){
			formPrincipal.elements['NUMERO_OFERT_PED_'+idMultioferta].value	= '';
		}else{
			return;
		}
	}

	if(parseInt(NumMultiofertas) > 1){
		if(confirm(msgAvisoProgramacion)){
			formPrincipal.elements['BOTON'].value		= 'PROGRAMAR';
			formPrincipal.elements['MO_IDPROGRAMAR'].value	= idMultioferta;
			formPrincipal.elements['ESTADOPROGRAMAR'].value	= '28';
			GuardarComentariosProgramacion(formPrincipal, linka, formPedido, idMultioferta);
		}
	}else{
		formPrincipal.elements['BOTON'].value		= 'PROGRAMAR';
		formPrincipal.elements['MO_IDPROGRAMAR'].value	= idMultioferta;
		formPrincipal.elements['ESTADOPROGRAMAR'].value	= '28';
		GuardarComentariosProgramacion(formPrincipal, linka, formPedido, idMultioferta);
	}
}

/*
	Funcion para programar un pedido
	copiada de GuardarComentarios, lo tratamos de la siguiete manera:
	marcamos como enviar solo el pedido que queremos programar, los demas como no programar.
	y enviamos la marca BOTON=PROGRAMAR

	recorremos todas las ofertas y solo marcamos la adecuada como OK

	en la BD se trata, basicamente, como una oferta 
*/
function GuardarComentariosProgramacion(formPrincipal, linka, formPedido, mo_idProgramar){
	var coments	= '';
	var mo_id;

	for(var i=0; i<formPrincipal.length; i++){
		var nom	= formPrincipal.elements[i].name;
		if(nom.indexOf("COMENTARIO_") != -1){
			mo_id	= nom.substring(nom.indexOf("_")+1,nom.length);
			coments	+= "|" + mo_id + "#" + formPrincipal.elements['COMENTARIO_'+mo_id].value + "#";

			if(formPrincipal.elements['SolicitaComercial'+mo_id].checked)
				coments+="S#";
			else
				coments+="N#";

			if(formPrincipal.elements['SolicitaMuestra'+mo_id].checked)
				coments+="S#";
			else
				coments+="N#";

			if(formPrincipal.elements['NoComercial'+mo_id].checked)
				coments+="S$";
			else
				coments+="N$";
		}
	}

	formPrincipal.elements['COMENTARIOS_PROVEEDORES'].value	= coments;

	//
	// * Ofertas: Validamos el pedido, la forma de pago y hacemos submit.
	// * Pedidos: Validamos el pedido y hacemos submit
	//
	if(PrepararPedidoAProgramar(formPrincipal,formPedido,mo_idProgramar) == true){
		AsignarAccion(formPrincipal,linka);

		var miForm		= document.forms['PedidoMinimo'];
		var mensaje		= 'Los pedidos a los siguientes proveedores no se enviar�n:\n';
		var seEnvianTodos	= 'S';

		for(var n=0; n<miForm.length; n++){
			if(miForm.elements[n].name.substring(0,7) == 'Status_' && (miForm.elements[n].value != 'S' && miForm.elements[n].value != 'SC')){
				var id	= obtenerId(miForm.elements[n].name);

				// Desactivamos el aviso de pedidos que no es enviar solo se puede programar uno
				seEnvianTodos	= 'S';
				//seEnvianTodos	= 'N';
				mensaje		+= '\n* '+miForm.elements['Nombre_'+id].value;
			}
		}

		mensaje	+= '\n\nSi desea MODIFICAR los pedidos pulse en \"Aceptar\".\nEn caso contrario, s�lo los pedidos con el sem�foro en VERDE ser�n enviados.';

		if(seEnvianTodos == 'N'){
			if(confirm(mensaje)){
				parent.history.go(-2-historia);
			}else{
				SubmitForm(formPrincipal,document);
			}
		}else{
			SubmitForm(formPrincipal,document);
		}
	}
}

function PrepararPedidoAProgramar(formu, formPedido, idMultioferta){
	var StringEnviar	= "";

	for(var i=0; i<formPedido.length; i++){
		if(formPedido.elements[i].name.substring(0,5) == 'Total'){
			var mo_id	= formPedido.elements[i].name.substring(6);

			if(mo_id == idMultioferta){
				formPedido.elements['Status_'+mo_id].value	= 'S';
			}else{
				formPedido.elements['Status_'+mo_id].value	= 'N';
			}

			// Accedemos a los valores
			var status	= formPedido.elements['Status_'+mo_id].value;
			var nombre	= formPedido.elements['Nombre_'+mo_id].value;
			var divisa	= formPedido.elements['Divisa_'+mo_id].value;

			StringEnviar	+= "("+mo_id+",";
			StringEnviar	+= status.substring(0,1)+"),";
		}
	}

	StringEnviar	= StringEnviar.substring(0,StringEnviar.length-1);

	formu.elements['ENVIAR_OFERTAS'].value	= StringEnviar;
	return true;
}

function ultimosComentarios(nombreObjeto, nombreForm, tipoComentario){
	var accion	= 'CONSULTAR';
	MostrarPagPersonalizada('http://www.newco.dev.br/Compras/NuevaMultioferta/UltimosComentarios.xsql?NOMBRE_OBJETO='+nombreObjeto+'&NOMBRE_FORM='+nombreForm+'&ACCION='+accion+'&TIPO='+tipoComentario+'&COMENTARIO='+document.forms[nombreForm].elements[nombreObjeto].value.replace(/\n/g,'\\\\n'),'comentarios',100,80,0,0);
}

function volverAtras(){
	var browserName	= navigator.appName;

	if(browserName.match('Explorer'))
		history.go(-2-historia);
	else
		history.go(-1-historia);
}

// Ver div de productos manuales
function VerProductosManuales(){
	if(document.getElementById('divProductosManuales').style.display == 'none'){
		jQuery("#divProductosManuales").show();
	}else{
		jQuery("#divProductosManuales").hide();
	}
}

// Funcion para a�adir productos que no estan en los catalogos (solo VIAMED)
function AnadirProductosManuales(){
	var oForm	= document.forms['Principal'];
	var msg		= '';

	var moId	= oForm.elements['MOID'].value;
	var refProv	= encodeURIComponent(oForm.elements['REFPROVEEDOR'].value);
	var descripcion	= encodeURIComponent(oForm.elements['DESCRIPCION'].value);
	var unBasica	= encodeURIComponent(oForm.elements['UNIDADBASICA'].value);
	var cantidad	= oForm.elements['CANTIDAD'].value;

	// Si la cantidad no es numerico salimos de la funcion
	if(!checkNumber(cantidad))	return false;

	if(refProv != '' && descripcion != '' && unBasica != '' && cantidad != ''){
		jQuery.ajax({
			cache:	false,
			url:	'ProductosManualesSave_ajax.xsql',
			type:	"GET",
			data:	"MOID="+moId+"&REFPROVEEDOR="+refProv+"&DESCRIPCION="+descripcion+"&UNIDADBASICA="+unBasica+"&CANTIDAD="+cantidad,
			contentType: "application/xhtml+xml",
			error: function(objeto, quepaso, otroobj){
				alert('error'+quepaso+' '+otroobj+''+objeto);
			},
			success: function(objeto){
				var data = eval("(" + objeto + ")"); 

				if(data.ProductosManualesSave.estado == 'OK'){
					RecuperaProductosManuales(moId);
					oForm.elements['REFPROVEEDOR'].value	= '';
					oForm.elements['DESCRIPCION'].value	= '';
					oForm.elements['UNIDADBASICA'].value	= '';
					oForm.elements['CANTIDAD'].value	= '';
				}else{
					alert(oForm.elements['ERROR_INSERTAR_DATOS'].value);
				}
			}
		});
	}else{
		msg	= oForm.elements['TODOS_CAMPOS_OBLI'].value;
		alert(msg);
	}
}

// Funcion para eliminar kineas ya introducidas de productos manuales
function EliminarProductosManuales(idProdMan){
	var oForm	= document.forms['Principal'];
	var msg		= '';
	var moId	= oForm.elements['MOID'].value;

	if(idProdMan != ''){
		jQuery.ajax({
			cache:	false,
			url:	'EliminarProductosManuales.xsql',
			type:	"GET",
			data:	"ID_PRODMAN="+idProdMan,
			contentType: "application/xhtml+xml",
			error: function(objeto, quepaso, otroobj){
				alert('error'+quepaso+' '+otroobj+''+objeto);
			},
			success: function(objeto){
				var data = eval("(" + objeto + ")");

				if(data.EliminarProductosManuales.estado == 'OK'){
					RecuperaProductosManuales(moId);
				}else{
					alert(oForm.elements['ERROR_ELIMINAR_DATOS'].value);
				}
			}
		});
	}else{
		msg	= oForm.elements['ERROR_ELIMINAR_DATOS'].value; 
		alert(msg);
	}
}

// Recupera las lineas de productos manuales via ajax
function RecuperaProductosManuales(moId){
	var ACTION	= "http://www.newco.dev.br/Compras/Multioferta/ProductosManuales.xsql";
	var post	= 'MOID='+moId;

	if(moId != '')	sendRequest(ACTION, handleRequestProductosManuales, post);
}

// Handler de la peticion ajax anterior
function handleRequestProductosManuales(req){
	var response	= eval("(" + req.responseText + ")");

	if(response.ProductosManuales.length > 0){
		jQuery("#productosManuales tbody").empty();
		// Se crea la tabla de los productos manuales
		jQuery.each(response.ProductosManuales, function(key, producto){
			txtHTML = "<tr id="+producto.PMId+">" +
				"<td>" + producto.PMRefProv+"</td>" +
				"<td>" + producto.PMDescripcion+"</td>" +
				"<td>" + producto.PMUnBasica+"</td>" +
				"<td>" + producto.PMCantidad+"</td>" +
				"<td>" +
					"<a class=\"accBorrar\" href=\"javascript:EliminarProductosManuales('"+producto.PMId+"');\">" +
						"<img src='http://www.newco.dev.br/images/2017/trash.png'/>" +
					"</a>" +
				"</td>" +
				"<td>&nbsp;</td>" +
			"</tr>";

			// Escribo HTML en la tabla
//			jQuery("#productosManuales").show();
//			jQuery("#productosManuales tbody").append(txtHTML);
			jQuery("#productosManuales").show().find("tbody").append(txtHTML);
		});
	}else{
//		jQuery("#productosManuales tbody").empty();
//		jQuery("#productosManuales").hide();
		jQuery("#productosManuales").hide().find("tbody").empty();
	}
}