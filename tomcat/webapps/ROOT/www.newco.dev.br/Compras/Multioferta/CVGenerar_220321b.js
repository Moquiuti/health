//	Libreria JS para el segundo paso del pedido
//	ultima revision: ET 22mar21 15:50 CVGenerar_220321.js

var uploadFilesDoc = new Array();
var periodicTimerDoc = 0;
var form_tmp;
var MAX_WAIT_DOC = 1000;

var	numCampos=0;
var arrCampos=new Array();


var Dominio='http://www.newco.dev.br';

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
	

	//	17nov20 Corregimos el formato del comentario para tener en cuenta saltos de línea
	//	18dic20 Cuidado! Se estaba perdiendo la info extra del areatext
	//solodebug	console.log(ComentarioPorDefecto);
	ComentarioPorDefecto=ComentarioPorDefecto.replace('<COMENTARIO_JS>','').replace('</COMENTARIO_JS>','').replace(/\<br\/\>/g,'\n').replace(/\<BR\/\>/g,'\n')+'\n';
	
	//	Prepara el formulario
	numCampos=0;
	var inicioCampo=ComentarioPorDefecto.indexOf('[[');
	var finCampo=ComentarioPorDefecto.indexOf(']]');
	var Formulario='';
	while ((inicioCampo!=-1)&&(finCampo!=-1))
	{
		//	Contiene formulario
		//	Recorre la cadena, separando el formulario
		
		var Campo=[];		
		Campo["Etiqueta"]=ComentarioPorDefecto.substring(0,inicioCampo);	//.replace(/\n/g,'<BR/>');
		Campo["Nombre"]=ComentarioPorDefecto.substring(inicioCampo+2,finCampo).replace(/\b/g,'');
		arrCampos.push(Campo);
		
		ComentarioPorDefecto=ComentarioPorDefecto.substring(finCampo+2,ComentarioPorDefecto.length);
		
		Formulario+=Campo["Etiqueta"].replace(/\n/g,'<BR/>')+'<input type="text" id="Campo_'+numCampos+'" name="Campo_'+numCampos+'" value=""/><BR/>';
		
		console.log('etiCampo('+numCampos+'):'+arrCampos[numCampos].Etiqueta+'nombreCampo('+numCampos+'):'+arrCampos[numCampos].Nombre+'\n\n');
		++numCampos;
		
		inicioCampo=ComentarioPorDefecto.indexOf('[[');
		finCampo=ComentarioPorDefecto.indexOf(']]');
	}
	
	//	Quita los saltos de linea del principio
	while ((ComentarioPorDefecto.substring(0,1)=='\n')||(ComentarioPorDefecto.substring(0,1)=='\r'))
		ComentarioPorDefecto=ComentarioPorDefecto.substring(1,ComentarioPorDefecto.length);
		
	
	
	if (Param1!='')
		ComentarioDeParametros+='\nHoja de gastos: '+Param1;
		
	if (Param2!='')
		ComentarioDeParametros+='\nNombrePaciente: '+Param2;
		
	if (Param3!='')
		ComentarioDeParametros+='\nNum.Cedula: '+Param3;

	if (Param4!='')
		ComentarioDeParametros+='\nHabitacion: '+Param4+'\n\n';
		
	jQuery('#comentParametros').html('<strong>'+Formulario+'<BR/>'+ComentarioDeParametros.replace(/\n/g,'<BR/>')+'</strong>');
	
	if (ComentarioDeParametros!='') sepComentario='Comentarios:\n\n';

	jQuery('.COMENTARIO').val(ComentarioPorDefecto);
	
	
	//	7abr21	Info de tipo de pedido cuando corresponda
	if (arrTiposPedidos.length>0)
		iniTipoPedido();

	//solodebug	

	//solodebug	console.log('ComentarioPorDefecto:'+ComentarioPorDefecto+'\n\nComentarioDeParametros:'+ComentarioDeParametros);

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
				//var coste = parseFloat(desformateaDivisa(form.elements['COSTE_LOGISTICA_'+moidpedido].value));
				var iva = parseFloat(desformateaDivisa(form.elements['IVA_'+moidpedido].value));

				// Si oculto_precio_ref = N y no es nuevo modelo de negocio sumo iva, viamed nuevo y brasil
				if(form.elements['OCULTO_PRECIO_REF_'+moidpedido].value == 'N' && form.elements['NUEVO_MODELO_NEGOCIO_'+moidpedido].value == 'N'){
					var totFinal = total + costeTransporte + IvaCoste + iva; 
					totFinal = reemplazaPuntoPorComa(totFinal);
				}else{
					var totFinal = total + costeTransporte + IvaCoste; 
					totFinal = reemplazaPuntoPorComa(totFinal);
				}

				//solodebug
				console.log('inicializarImportes. total:'+total+' iva:'+iva+' costeTransporte:'+costeTransporte+' IvaCoste:'+IvaCoste+' totFinal:'+totFinal);

				// Aqui lo unico que hace es presentar el importe con 2 decimales en lugar de 4, pero no se cambia
				form.elements[n].value=anyadirCerosDecimales(formateaDivisa(Round(desformateaDivisa(form.elements[n].value),2)),2);
			}

			// Este valor sera el total + iva + coste_logistica. Si España el coste será 0; si Brasil el iva sera 0
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
// Envia Pedido: Construye string para el campo oculto COMENTARIOS_PROVEEDORES que tiene el formato siguiente |225#blabla#S#N$|213#bloblo#S#S$ 
function EnviarPedidos(formPrincipal, linka, formPedido){
	// Esconder boton de continuar para evitar doble-click
	jQuery('#botonEnviarPedido').hide();
	
	//solodebug
	//alert('EnviarPedidos CosteTransporteTxt:'+formPrincipal.elements['COSTE_LOGISTICA'].value+' IvaTransporteTxt:'+formPrincipal.elements['COSTE_LOGISTICA_IVA'].value);
	//return;

	var	IDMultioferta=formPrincipal.elements['MO_ID'].value;
	
	//	7abr21 En caso de que hayan tipos de pedidos
	if (arrTiposPedidos.length>0)
	{
		msg=controlTipoPedido();
		
		if (msg!='')
		{
			alert(msg);
			jQuery('#botonEnviarPedido').show();
			return;
		}
	}
	
	
	//	22feb21 En caso de que hayan clausulas legales
	var Clausulas='';
	if (clausulasLegales=='S')
	{
		for(var i=0; i<formPrincipal.length; i++)
		{
			var nom	= formPrincipal.elements[i].name;

			console.log('EnviarPedidos. Revisando campo: '+nom);
			
			if ((nom.substring(0,6)=='claus_')&&(formPrincipal.elements[i].checked))
			{
				var	IDClausula=Piece(nom,'_',1);
				Clausulas+=IDClausula+'|';
				console.log('EnviarPedidos. Incluyendo clausula. IDClausula: '+IDClausula);
			}
		}
		
		if (Clausulas=='')
			if (!confirm(msgSinClausulasMarcadas)) 
			{
				jQuery('#botonEnviarPedido').show();
				return;
			}
	}

	//solodebug		console.log('EnviarPedidos. Clausulas:'+Clausulas);
	//solodebug	return;
	

	//solodebug	console.log('EnviarPedidos. Campos:'+arrCampos.length);
	
	//	20ene20 En caso de formulario, revisa que todos los campos esten informados
	var comentDeFormulario='';
	if (arrCampos.length>0)
	{
		var msg='';
		for (var i=0;i<arrCampos.length;++i)
		{
			comentDeFormulario+=arrCampos[i].Etiqueta+jQuery("#Campo_"+i).val();
		
			//solodebug	console.log('EnviarPedidos. Revisando campo('+i+'):'+arrCampos[i].Nombre+':'+jQuery("#Campo_"+i).val());
			
			if (jQuery("#Campo_"+i).val()=='')
			{
				msg+=msgCampoNoInformado.replace('[[NOMBRECAMPO]]',arrCampos[i].Nombre)+'\n\r';
			}
		}
		if (msg!='')
		{
			alert(msg);
			jQuery('#botonEnviarPedido').show();
			return;
		}
	}
	
	//solodebug console.log('EnviarPedidos. comentDeFormulario:'+comentDeFormulario);
	
	
	//	27nov20 Cuando corresponda, recorre los motivos de que se haya pedido un producto "no orden 1"
	if (conMotivoPorOrdenNo1=='S')
	{
		var msg='', motivos='';
		for(var i=0; i<formPrincipal.length; i++)
		{
			var nom	= formPrincipal.elements[i].name;
			var motivo	= formPrincipal.elements[i].value;
			
			//solodebug	console.log('EnviarPedidos nom:'+nom);

			if (nom.substring(0,9)=='IDMOTIVO_')
			{
				var	LMO_ID=Piece(nom,'_',1);
				if  (motivo!='')
				{
					motivos+=LMO_ID+':'+motivo+'|';
				}
				else
				{
					var Ref=jQuery("#REF_"+LMO_ID).val();
					msg+=msgFaltaMotivo.replace('[[REFERENCIA]]', Ref)+'\n\r';
				}
			}
		}

		if (msg!='')
		{
			alert(msg);
			jQuery('#botonEnviarPedido').show();
			return;
		}
		else
			jQuery("#LISTAMOTIVOS").val(motivos);
	}	
	
	
	//solodebug	console.log('IDMultioferta:'+IDMultioferta);
	
	//	21jun18	Tratamiento de campos obligatorios para cirugia
	if (reqDatosPaciente=='S')
	{
		var msg='';
		
		if ((formPrincipal.elements['NIFPACIENTE'].value=='')||(formPrincipal.elements['PACIENTE'].value==''))
			msg+=msgDatosPacienteObligatorios+'\n\r';
			
		if (formPrincipal.elements['IDDOCUMENTO'].value=='')
			msg+=msgDocumentoCirugiaObligatorio+'\n\r';
			
		if (msg!='')
		{
			alert(msg);
			jQuery('#botonEnviarPedido').show();
			return;
		}
	}
	
	if ((formPrincipal.elements['URGENTE_'+IDMultioferta].checked)&&(formPrincipal.elements['COMENTARIO_'+IDMultioferta].value==''))
	{
		alert(msgComentariosObligatoriosParaUrgencias);
		jQuery('#botonEnviarPedido').show();
		return;
	}
	

	try{
		var idFormaPago=formPrincipal.elements['IDFORMAPAGO_'+IDMultioferta].value;
		var idPlazoPago=formPrincipal.elements['IDPLAZOPAGO_'+IDMultioferta].value;
		formPrincipal.elements['IDFORMAPAGO'].value=idFormaPago;
		formPrincipal.elements['IDPLAZOPAGO'].value=idPlazoPago;
	}
	catch(err)
	{
		console.log('Sin IDFORMAPAGO/IDPLAZOPAGO, continuando...');
	}
	
	//solodebug	console.log('IDMultioferta:'+IDMultioferta+' idFormaPago:'+idFormaPago+' idPlazoPago:'+idPlazoPago);

	var coments	= '';
	var mo_id;

	//	Por si se ha modificado el form principal al enviar documentos, reasignamos valores correctos
	formPrincipal.target = "_self";
	formPrincipal.encoding = "application/x-www-form-urlencoded";
	formPrincipal.action = "http://www.newco.dev.br/Compras/Multiofertas/CVGenerarSave.xsql";


	// Construimos el string de comentarios.
	for(var i=0; i<formPrincipal.length; i++){
		var nom	= formPrincipal.elements[i].name;

		if(nom.indexOf("COMENTARIO_") != -1){
			mo_id	= nom.substring(nom.indexOf("_")+1,nom.length);
			
			//	4abr19	Quita los caracteres problematicos de la cadena
			formPrincipal.elements['COMENTARIO_'+mo_id].value=formPrincipal.elements['COMENTARIO_'+mo_id].value.replace('/#/g','').replace('/$/g','').replace('/|/g','');
			formPrincipal.elements['NUMERO_OFERT_PED_'+mo_id].value=formPrincipal.elements['NUMERO_OFERT_PED_'+mo_id].value.replace('/#/g','').replace('/$/g','').replace('/|/g','');

			coments	+= "|" + mo_id + "#" + ComentarioDeParametros + '\n\n'+ comentDeFormulario + '\n\n'+ sepComentario + formPrincipal.elements['COMENTARIO_'+mo_id].value + "#" + formPrincipal.elements['NUMERO_OFERT_PED_'+mo_id].value + "#";

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

			if (!(formPrincipal.elements['NoComercial'+mo_id])||(formPrincipal.elements['NoComercial'+mo_id].checked)){
				coments	+= "S#";
			}else{
				coments	+= "N#";
			}
			// Urgente
			if(formPrincipal.elements['URGENTE_'+mo_id].checked){
				coments	+= "S#";
			}else{
				coments	+= "N#";
			}

			// 31mar20 Depósito
			if(formPrincipal.elements['DEPOSITO_'+mo_id].checked){
				coments	+= "S#";
			}else{
				coments	+= "N#";
			}

			// 8set20 Depósito
			if(formPrincipal.elements['BAJAPRIORIDAD_'+mo_id].checked){
				coments	+= "S#";
			}else{
				coments	+= "N#";
			}

			coments	+= Clausulas+'#';

			coments	+= cadenaTipoPedido();

			coments	+= "$";
			
		}
	}

	formPrincipal.elements['COMENTARIOS_PROVEEDORES'].value	= ScapeHTMLString(coments);

	//solodebug	alert('IDFORMAPAGO'+formPrincipal.elements['IDFORMAPAGO'].value+' IDPLAZOPAGO'+formPrincipal.elements['IDPLAZOPAGO'].value);

	if(ComprobarPedidoMinimo(formPrincipal,formPedido) == true){
	
		AsignarAccion(formPrincipal, linka);
		SubmitForm(formPrincipal, document);
	}
	
}


//	Comprobamos los pedidos con los semaforos para evaluar los pedidos que realmente vamos
//	a mandar y los pedidos que no vamos a mandar.
//	Guardamos el string en ENVIAR_OFERTAS.
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

	// Si estado NT significa que es pedido asisa bajo el pedido minimo, permitido en algunos casos, añaden productos en comentarios
	// Lo pongo aquí porqué si no para pedidos multiprov falla, string enviar se crea con mo_id y primera letra del estado, si es NT = N y no envia

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
	
	//solodebug	console.log('ProgramarPedido. '+objPedidoProgramable+':'+formPedido.elements[objPedidoProgramable].value);

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
	
	//solodebug	console.log('ProgramarPedido. Avanzando.');

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
	
	//solodebug
	console.log('GuardarComentariosProgramacion. formPrincipal:'+formPrincipal.name+' linka:'+linka+' formPedido:'+formPedido.name+' mo_idProgramar:'+mo_idProgramar);

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

			try
			{
				if((formPrincipal.elements['NoComercial'+mo_id])&&(formPrincipal.elements['NoComercial'+mo_id].checked))	//10dic20
					coments+="S$";
				else
					coments+="N$";
			}
			catch(err)
			{
				coments+="N$";
			}
			
		}
	}

	formPrincipal.elements['COMENTARIOS_PROVEEDORES'].value	= coments;

	//
	// * Ofertas: Validamos el pedido, la forma de pago y hacemos submit.
	// * Pedidos: Validamos el pedido y hacemos submit
	//
	if(PrepararPedidoAProgramar(formPrincipal,formPedido,mo_idProgramar) == true)
	{

		//solodebug
		console.log('GuardarComentariosProgramacion. AsignarAccion. formPrincipal:'+formPrincipal+' linka:'+linka);

		AsignarAccion(formPrincipal,linka);

		var miForm		= document.forms['PedidoMinimo'];
		var mensaje		= 'Los pedidos a los siguientes proveedores no se enviarán:\n';
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

		mensaje	+= '\n\nSi desea MODIFICAR los pedidos pulse en \"Aceptar\".\nEn caso contrario, sólo los pedidos con el semáforo en VERDE serán enviados.';

		//solodebug
		console.log('GuardarComentariosProgramacion. AsignarAccion. formPrincipal:'+formPrincipal.name+' linka:'+linka+ ' seEnvianTodos:'+seEnvianTodos);

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
	MostrarPagPersonalizada(Dominio+'/Compras/NuevaMultioferta/UltimosComentarios.xsql?NOMBRE_OBJETO='+nombreObjeto+'&NOMBRE_FORM='+nombreForm+'&ACCION='+accion+'&TIPO='+tipoComentario+'&COMENTARIO='+document.forms[nombreForm].elements[nombreObjeto].value.replace(/\n/g,'\\\\n'),'comentarios',100,80,0,0);
}

function volverAtras(){
/*	10feb20
	var browserName	= navigator.appName;

	if(browserName.match('Explorer'))
		history.go(-2-historia);
	else
		history.go(-1-historia);*/
		
	history.go(-1);
}

// Ver div de productos manuales
function VerProductosManuales(){
	if(document.getElementById('divProductosManuales').style.display == 'none'){
		jQuery("#divProductosManuales").show();
	}else{
		jQuery("#divProductosManuales").hide();
	}
}

// Funcion para añadir productos que no estan en los catalogos (solo VIAMED)
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
						'<img src="http://www.newco.dev.br/images/2017/trash.png"/>' +
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

//	26ene17	Permitimos cambiar el vendedor por defecto
function CambioVendedor(IDMultioferta)
{
	jQuery("#spDatosVendedor_"+IDMultioferta).show(); 
 	jQuery("#imgVendedorOK_"+IDMultioferta).hide(); 
 	jQuery("#imgVendedorKO_"+IDMultioferta).hide(); 
}

function GuardarVendedor(IDMultioferta)
{
    var form=document.forms['Principal'];
    //form.elements['IDNUEVOVendedor'].value=form.elements['IDVendedor'].value;
    //var idPedido = form.elements['IDPEDIDO'].value;
	var idVendedor=form.elements['IDVENDEDOR_'+IDMultioferta].value;
	
	var porDefecto=(form.elements['cbTodos'].checked?'S':'N');
	
	var estado='';

 	jQuery("#spDatosVendedor_"+IDMultioferta).hide(); 
	
	//solodebug	alert('GuardarVendedor idVendedor:'+idVendedor+' Todos:'+porDefecto);

	jQuery.ajax({
		cache:	false,
		url:	Dominio+'/Personal/BandejaTrabajo/CambiarVendedorAJAX.xsql',
		type:	"GET",
		data:	"IDMULTIOFERTA="+IDMultioferta+"&IDNUEVOVENDEDOR="+idVendedor+"&PORDEFECTO="+porDefecto,
		contentType: "application/xhtml+xml",
		async:false,
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			
			estado=data.estado;

		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
			estado='ERROR';
		}
	});


	if(estado == 'OK')
	{
 		jQuery("#imgVendedorOK_"+IDMultioferta).show(); 
 		jQuery("#imgVendedorKO_"+IDMultioferta).hide(); 
	}
	else
	{
 		jQuery("#imgVendedorOK_"+IDMultioferta).hide(); 
 		jQuery("#imgVendedorKO_"+IDMultioferta).show(); 
	}
}


//	27ene17	Permitimos cambiar la forma y plazo de pago
function CambioFormaPago(IDMultioferta)
{
	jQuery("#spFormaPago_"+IDMultioferta).show(); 
 	jQuery("#imgFormaPagoOK_"+IDMultioferta).hide(); 
 	jQuery("#imgFormaPagoKO_"+IDMultioferta).hide(); 
}

function GuardarFormaPago(IDMultioferta)
{
    var form=document.forms['Principal'];
    //form.elements['IDNUEVOVendedor'].value=form.elements['IDVendedor'].value;
	var idFormaPago=form.elements['IDFORMAPAGO_'+IDMultioferta].value;
	var idPlazoPago=form.elements['IDPLAZOPAGO_'+IDMultioferta].value;
	var estado='';

 	jQuery("#spFormaPago_"+IDMultioferta).hide(); 
	
	//solodebug	alert('GuardarVendedor idVendedor:'+idVendedor+' Todos:'+porDefecto);

	jQuery.ajax({
		cache:	false,
		url:	Dominio+'/Personal/BandejaTrabajo/CambiarFormaPagoAJAX.xsql',
		type:	"GET",
		data:	"IDMULTIOFERTA="+IDMultioferta+"&IDFORMAPAGO="+idFormaPago+"&IDPLAZOPAGO="+idPlazoPago,
		contentType: "application/xhtml+xml",
		async:false,
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			
			estado=data.estado;

			if(estado == 'OK')
			{
 				jQuery("#imgFormaPagoOK_"+IDMultioferta).show(); 
 				jQuery("#imgFormaPagoKO_"+IDMultioferta).hide(); 
				
				form.elements['IDFORMAPAGO'].value=idFormaPago;
				form.elements['IDPLAZOPAGO'].value=idPlazoPago;
			}
			else
			{
 				jQuery("#imgFormaPagoOK_"+IDMultioferta).hide(); 
 				jQuery("#imgFormaPagoKO_"+IDMultioferta).show(); 
			}


		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
			estado='ERROR';
		}
	});

}

//	Recuperado desde  MultiofertaFrame-13-HTML.xsl   
function copiarComentarios(nombreObjeto, texto){

  if(quitarEspacios(document.forms['Principal'].elements[nombreObjeto].value)!=''){
    document.forms['Principal'].elements[nombreObjeto].value+='\n\n';
  }
  document.forms['Principal'].elements[nombreObjeto].value+=texto;
  
} 

//	8set20 urgente y baja prioridad incompatibles
function clickPrioridad(tipo, id)
{
	//solodebug	alert('clickPrioridad: ('+tipo+','+id+')');
	
	if ((tipo=='URGENTE')&&(document.getElementById('URGENTE_'+id).checked))
		jQuery('#BAJAPRIORIDAD_'+id).prop('checked',false);
	else if ((tipo=='BAJAPRIORIDAD')&&(document.getElementById('BAJAPRIORIDAD_'+id).checked))
		jQuery('#URGENTE_'+id).prop('checked',false);
		
}

//	29dic20 Cambio del campo coste logistica
function CambioCosteLogistica(id)
{
    var form=document.forms['Principal'];
	debug('CambioCosteLogistica. Campo:COSTE_LOGISTICA_'+id);
	
	var CosteTxt=form.elements['COSTE_LOGISTICA_'+id].value;
	costeTransporte=parseFloat(desformateaDivisa(CosteTxt));
	debug('CambioCosteLogistica. costeTransporte:'+costeTransporte);
	form.elements['COSTE_LOGISTICA'].value=CosteTxt;
	inicializarImportes();
}

//	29dic20 Cambio del campo IVA coste logistica
function CambioIVACosteLogistica(id)
{
    var form=document.forms['Principal'];
	debug('CambioIVACosteLogistica. Campo:COSTE_LOGISTICA_IVA_'+id);

	var IvaTxt=form.elements['COSTE_LOGISTICA_IVA_'+id].value;
	IvaCoste=parseFloat(desformateaDivisa(IvaTxt));
	debug('CambioIVACosteLogistica. IvaCoste:'+IvaCoste);
	form.elements['COSTE_LOGISTICA_IVA'].value=IvaTxt;
	
	inicializarImportes();
}



//
//	DOCUMENTOS
//


//	29jun17	Cargar documento para adjuntarlo al pedido
function cargaDoc()
{
    var form=document.forms['Principal'];
	alert(jQuery("#inputFileDoc").val());
}



//cargar documentos
function cargaDoc(){

	//solodebug	console.log('cargaDoc: Inicio.');

    var form=document.forms['Principal'];
	var msg = '';

	/*
	if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("body")[0]){
		uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";
	}
	
	if(msg != ''){
		alert(msg);
	}else{
	*/
		if(hasFilesDoc(form)){
			var target = 'uploadFrameDoc';
			var action = Dominio+'/cgi-bin/uploadDocsMVM.pl';
			var enctype = 'multipart/form-data';

			form.target = target;
			form.encoding = enctype;
			form.action = action;
			waitDoc();
			form_tmp = form;
			man_tmp = true;
			periodicTimerDoc = 0;
			periodicUpdateDoc();

			//solodebug
			console.log('cargaDoc: submit form.');
			
			form.submit();
		}
	//}//fin else
}//fin de carga documentos js

//Search form if there is a filled file input
function hasFilesDoc(form){
	for(var i=1; i<form.length; i++){
		if(form.elements[i].type == 'file' && (form.elements[i].name == 'inputFileDoc') && form.elements[i].value != '' ){
			return true;
		}
	}
	return false;
}

//function que dice al usuario de esperar
function waitDoc(){

	//solodebug
	console.log('waitDoc.');

	jQuery('#waitBoxDoc').html ('<img src="http://www.newco.dev.br/images/loading.gif" />');
	jQuery('#waitBoxDoc').show();
	return false;
}

/**
 * Check periodically if the image upload is finished
 * @return Boolean - true if filled file input found
 */
function periodicUpdateDoc(){

	//solodebug
	console.log('periodicUpdateDoc: Inicio.');

	if(periodicTimerDoc >= MAX_WAIT_DOC){
		alert(document.forms['mensajeJS'].elements['HEMOS_ESPERADO'].value + MAX_WAIT_DOC + document.forms['mensajeJS'].elements['LA_CARGA_NO_TERMINO'].value);
		return false;
	}
	periodicTimerDoc++;

	if(uploadFrameDoc && uploadFrameDoc.document && uploadFrameDoc.document.getElementsByTagName("p")[0]){
		var tipoDocHTML	= document.forms['Principal'].elements['TIPO_DOC_HTML'].value;

		var uFrame	= uploadFrameDoc.document.getElementsByTagName("p")[0];

		document.getElementById('waitBoxDoc').style.display = 'none';

		if(uFrame.innerHTML.substr(0, 1) != '{' && uFrame.innerHTML.substr(0, 1) != '['){
			alert(document.forms['mensajeJS'].elements['ERROR_SIN_DEFINIR'].value);
			return false;
		}else{
			var response = eval('(' + uFrame.innerHTML + ')');

			//solodebug
			console.log('periodicUpdateDoc: llamando a handleFileRequestDoc.');

			handleFileRequestDoc(response);
			return true;
		}
	}else{
		window.setTimeout(periodicUpdateDoc, 1000);
		return false;
	}
	return true;
}

/**
 * handle Request after file (or image) upload
 * @param {Array} resp Hopefully JSON string array
 * @return Boolean
 */
function handleFileRequestDoc(resp){
	var lang = new String('');
				
	//solodebug	console.log('handleFileRequestDoc: Inicio.');

	if(document.getElementById('myLanguage') && document.getElementById('myLanguage').innerHTML.length > 0){
		lang = document.getElementById('myLanguage').innerHTML;
	}

	var form = form_tmp;
	var msg = '';
	var target = '_top';
	var enctype = 'application/x-www-form-urlencoded';
	var documentChain = new String('');

//	var action = 'http://' + location.hostname + '/' + lang + 'confirmCargaDocumento.xsql';

	var docNombre = '';
	var docDescri = '';
	var nombre = '';

	if(resp.documentos){
		if(resp.documentos && resp.documentos.length > 0){
			for(var i=0; i<resp.documentos.length; i++){
				if(resp.documentos[i].error && resp.documentos[i].error != ''){
					msg += resp.documentos[i].error;
				}else{
					if(resp.documentos[i].size){
					/*en lugar del elemento nombre del form cojo el nombre del fichero diretamente, si hay espacios el sistema pone ghion bajo, entonces cuento cuantos ghiones son, divido al penultimo y añado la ultima palabra, si la ultima palabra esta vacía implica que hay 2 ghiones bajos, entonces divido a los 2 ghiones bajos y cojo la primera parte.*/
						var lastWord = '';
						var sinEspacioNombre = resp.documentos[i].nombre.replace('__','_');

						var numSep = PieceCount(sinEspacioNombre,'_');
						var numSepOk = numSep -1;
						if(Piece(sinEspacioNombre,'_',numSepOk) == ''){
							if(sinEspacioNombre.search('__')){
								lastWord	= sinEspacioNombre.split('__');
								docNombre	= lastWord[0];
							}
						}else{
							lastWord	= Piece(sinEspacioNombre,'_',numSepOk);
							nombre		= sinEspacioNombre.split(lastWord);
							docNombre	= nombre[0].concat(lastWord);
						}

						documentChain += resp.documentos[i].nombre + '|'+ docNombre+'|'+ resp.documentos[i].size +'|'+ docDescri + '#';
					}
				}
			}

			if(msg == ''){
				document.getElementsByName('CADENA_DOCUMENTOS')[0].value = documentChain;
				var cadenaDoc	= document.getElementsByName('CADENA_DOCUMENTOS')[0].value;
			}
		}
	}

	//var usuario	= document.forms['Principal'].elements['ID_USUARIO'].value;
	var borrados	= document.forms['Principal'].elements['DOCUMENTOS_BORRADOS'].value;
	var borr_ante	= document.forms['Principal'].elements['BORRAR_ANTERIORES'].value;
	var tipoDocDB	= document.forms['Principal'].elements['TIPO_DOC_DB'].value;
	var tipoDocHTML	= document.forms['Principal'].elements['TIPO_DOC_HTML'].value;
	// En este caso usamos el IDEmpresa del cliente como parámetro de entrada para IDPROVEEDOR
	//var IDEmpresa	= '';
	if(document.forms['Principal'].elements['IDEMPRESA'].value != ''){
		IDEmpresa	= document.forms['Principal'].elements['IDEMPRESA'].value;
	}

	if(msg != ''){
		alert(msg);
		return false;
	}else{

//		form.encoding	= enctype;
//		form.action	= action;
//		form.target	= target;
		var d = new Date();

		jQuery.ajax({
			url:"http://www.newco.dev.br/Administracion/Mantenimiento/Productos/confirmCargaDocumento.xsql",
			data: "ID_USUARIO="+IDUsuario+"&ID_PROVEEDOR="+IDEmpresa+"&DOCUMENTOS_BORRADOS="+borrados+"&BORRAR_ANTERIORES="+borr_ante+"&TIPO_DOC="+tipoDocDB+"&CADENA_DOCUMENTOS="+cadenaDoc+"&_="+d.getTime(),
			type: "GET",
			async: false,
			contentType: "application/xhtml+xml",
			beforeSend:function(){
				document.getElementById('waitBoxDoc').src = Dominio+'/images/loading.gif';
			},
			error:function(objeto, quepaso, otroobj){
				alert("objeto:"+objeto);
				alert("otroobj:"+otroobj);
				alert("quepaso:"+quepaso);
			},
			success:function(data){
				var doc=eval("(" + data + ")");
				
				//solodebug	
				console.log('handleFileRequestDoc: OK.'+data);

				//reinicializo los campos del form
				document.forms['Principal'].elements['inputFileDoc'].value = '';

				if(document.forms['Principal'].elements['MAN_PRO'] && document.forms['Principal'].elements['MAN_PRO'].value != 'si'){
					if (document.forms['Principal'].elements['US_MVM'] && document.forms['Principal'].elements['US_MVM'].value == 'si'){
						document.forms['Principal'].elements['IDPROVEEDOR'].value = '-1';
					}
				}

				var tipo = document.forms['Principal'].elements['TIPO_DOC_HTML'].value;

				//vaciamos la carga documentos
				document.forms['Principal'].elements['inputFileDoc'+tipo] = '';
				jQuery("#carga"+tipo).hide();

				uploadFrameDoc.document.getElementsByTagName("p")[0].innerHTML = '';
				uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";

//				var proveedor = document.forms['Principal'].elements['IDPROVEEDOR'].value;

				//Informamos del IDDOC en el input hidden que toca y avisamos al usuario
				jQuery('#IDDOCUMENTO').val(doc[0].id_doc);
				//Creamos el link para acceder al archivo, link para borrarlo y ocultamos link para subir documento
				var nombreDoc	= doc[0].nombre;
				var fileDoc	= doc[0].file;
				jQuery('#docBox').empty().append('&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://www.newco.dev.br/Documentos/' + fileDoc + '" target="_blank">' + nombreDoc + '</a>').show();
				jQuery('#borraDoc').append('<a href="javascript:borrarDoc(' + doc[0].id_doc + ',\'' + tipo + '\')"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>').show();
				jQuery('#newDoc').hide();

				//reseteamos los input file, mismo que removeDoc
				var clearedInput;
				var uploadElem = document.getElementById("inputFileDoc");

				uploadElem.value = '';
				clearedInput = uploadElem.cloneNode(false);

				uploadElem.parentNode.insertBefore(clearedInput, uploadElem);
				uploadElem.parentNode.removeChild(uploadElem);
				uploadFilesDoc.splice(tipo, 1);

				return undefined;
			}
		});
	}
	return true;
}



function borrarDoc(IDDoc){
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	Dominio+'/Administracion/Mantenimiento/Productos/BorrarDocumento.xsql',
		type:	"GET",
		data:	"DOC_ID="+IDDoc+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.BorrarDocumento.estado == 'OK'){
			
				console.log('borrarDoc:'+IDDoc);
			
				jQuery("#IDDOCUMENTO").val("");
				jQuery("#borraDoc").empty().hide();
				jQuery("#docBox").empty().hide();
				jQuery("#newDoc").show();
            }else{
				alert('Error: ' + data.BorrarDocumento.message);
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}


//	Recuperado desde  MultiofertaFrame-13-HTML.xsl   
function copiarComentarios(nombreObjeto, texto){

  if(quitarEspacios(document.forms['Principal'].elements[nombreObjeto].value)!=''){
    document.forms['Principal'].elements[nombreObjeto].value+='\n\n';
  }
  document.forms['Principal'].elements[nombreObjeto].value+=texto;
  
} 

//	8set20 urgente y baja prioridad incompatibles
function clickPrioridad(tipo, id)
{
	//solodebug	alert('clickPrioridad: ('+tipo+','+id+')');
	
	if ((tipo=='URGENTE')&&(document.getElementById('URGENTE_'+id).checked))
		jQuery('#BAJAPRIORIDAD_'+id).prop('checked',false);
	else if ((tipo=='BAJAPRIORIDAD')&&(document.getElementById('BAJAPRIORIDAD_'+id).checked))
		jQuery('#URGENTE_'+id).prop('checked',false);
		
}


//	29set20 Nueva página de gestión de documentos
function AbrirGestionDocumentos()
{
	MostrarPagPersonalizada('http://www.newco.dev.br/Compras/Multioferta/MODocs.xsql?MO_ID='+IDMultioferta,'Documentos',100,80,0,0);
}


//	7abr21 Oculta los tipos de pedido
function iniTipoPedido()
{
	jQuery('.tr_TiposPedido').hide();
}

//	31mar21 Desplegable de tipo de pedido, informara los subdesplegables
function chTipoPedido()
{
	jQuery('.tr_TiposPedido').hide();
	if (jQuery('#IDTIPOPEDIDO').val()!='')
	{
		var Pos=BuscaTipo(jQuery('#IDTIPOPEDIDO').val());
		jQuery('.tr_'+arrTiposPedidos[Pos].ID).val('');
		jQuery('.tr_'+arrTiposPedidos[Pos].ID).show();
		
	}
}

//	7abr21 Desplegable de valores del tipo de pedido, informaremos variables globales
function chValorPedido(IDTitulo)
{
	var Res=jQuery('#IDTIPOPEDIDO_'+IDTitulo).val();

	var PosTipo=BuscaTipo(Piece(IDTitulo,'_',0));
	var PosTit=BuscaTitulo(PosTipo, IDTitulo);

	//solodebug	debug('chValorPedido. IDTitulo:'+IDTitulo+' PosTipo:'+PosTipo+' PosTit:'+PosTit+ ' Res:'+Res);
	
	arrTiposPedidos[PosTipo].Titulos[PosTit].Actual=Res;

	//solodebug	debug('chValorPedido. IDTitulo:'+IDTitulo+' PosTipo:'+PosTipo+' PosTit:'+PosTit+ ' Res:'+Res);
	
}

//	Busca la posicion del tipo a partir del ID
function BuscaTipo(IDTipo)
{
	var Pos=-1;
	for (var i=0;(i<arrTiposPedidos.length)&&(Pos==-1);++i)
	{
		if (arrTiposPedidos[i].ID==IDTipo) Pos=i;
	}
	return Pos;
}

//	Busca la posicion del titulo a partir de la Pos del tipo y el ID del titulo
function BuscaTitulo(PosTipo, IDTitulo)
{
	var Pos=-1;
	for (var i=0;(i<arrTiposPedidos[PosTipo].Titulos.length)&&(Pos==-1);++i)
	{
	
		//solodebug	debug('BuscaTitulo. Buscando:'+IDTitulo+' Comprobando:'+arrTiposPedidos[PosTipo].Titulos[i].ID);
	
		if (arrTiposPedidos[PosTipo].Titulos[i].ID==IDTitulo) Pos=i;
	}
	return Pos;
}

//	7abr21 comprueba si el tipo de pedido esta correctamente informado
function controlTipoPedido()
{
	var Errores='';
	var IDTipoPedido=jQuery('#IDTIPOPEDIDO').val();
	if (IDTipoPedido=='')
	{
		Errores+='Es obligatorio informar el tipo de pedido.'+'\n\r';
	}
	else
	{
		var Pos=BuscaTipo(IDTipoPedido);
		
		for (var i=0;i<arrTiposPedidos[Pos].Titulos.length;++i)
		{
			
			//solodebug	debug('chValorPedido. IDTipoPedido:'+IDTipoPedido+' Pos:'+Pos+' i:'+i+ ' Actual:'+arrTiposPedidos[Pos].Titulos[i].Actual);
			
			if (arrTiposPedidos[Pos].Titulos[i].Actual=='')
			{
				Errores+='Es obligatorio informar '+arrTiposPedidos[Pos].Titulos[i].Nombre+'.'+'\n\r';
			}
		}
	}

	return Errores;
}

//	7abr21 comprueba si el tipo de pedido esta correctamente informado
function cadenaTipoPedido()
{
	//	Devuelve cadena vacia si no esta informado
	if (arrTiposPedidos.length==0) return '';

	var IDTipoPedido=jQuery('#IDTIPOPEDIDO').val(),
		Res=IDTipoPedido;
	
	var Pos=BuscaTipo(IDTipoPedido);
	
	for (var i=0;i<arrTiposPedidos[Pos].Titulos.length;++i)
	{
		Res+='|'+arrTiposPedidos[Pos].Titulos[i].Actual;
	}
	
	return Res;
}





/*
function chTipoPedido()
{
	if (jQuery('#IDTIPOPEDIDO').val()=='')
	{
		for (var i=0;(i<arrTiposPedidos[PosTipo].Titulos.length)&&(Pos==-1);++i)
		{
			jQuery('#IDTIPOPEDIDO_'+arrTiposPedidos[PosTipo].Titulos[i].ID).val('');
			jQuery('#p_Tipo_'+arrTiposPedidos[PosTipo].Titulos[i].ID).hide();
		}
	}
	else
	{
		//	Busca el IDTIPOPEDIDO
		var PosTipo=BuscaTipo(jQuery('#IDTIPOPEDIDO').val());
		
		//	Rellena los desplegables
		
		for (var i=0;i<arrTiposPedidos[PosTipo].Titulos.length;++i)
		{
		
			var Desp=new Object;
			Desp=document.forms['Principal'].elements['IDTIPOPEDIDO_'+arrTiposPedidos[PosTipo].Titulos[i].ID];

			//	Vacia el desplegable
			while (Desp.options.length > 0) {
        		Desp.remove(0);
   			}

			//	Informa el desplegable
			for (var j=0;j<arrTiposPedidos[PosTipo].Titulos[i].length;++i)
			{
				let newOption = new Option(arrTiposPedidos[PosTipo].Titulos[i].Valor[j].Nombre,arrTiposPedidos[PosTipo].Titulos[i].Valor[j].ID)
				Desp.add(newOption,undefined);
			}

			jQuery('#IDTIPOPEDIDO_'+arrTiposPedidos[PosTipo].Titulos[i].ID).show();
		}
	}
}
*/

/*
//	31mar21 Desplegable de tipo de pedido, informara los subdesplegables
function chTituloTipoPedido()
{
	if (jQuery('#IDTITULOTIPO').val()=='')
	{
		jQuery('#IDVALORTIPO').val('');
		jQuery('#IDVALORTIPO').hide();
	}
	else
	{
		//	Busca el IDTIPOPEDIDO
		var PosTipo=BuscaTipo(jQuery('#IDTIPOPEDIDO').val());
		var PosTitulo=BuscaTitulo(jQuery('#IDTITULOTIPO').val());
	
		//	Vacia el desplegable
		while (document.forms['Principal'].elements['IDVALORTIPO'].options.length > 0) {
        	document.forms['Principal'].elements['IDVALORTIPO'].remove(0);
   		}
	
		//	Informa el desplegable
		for (var i=0;i<arrTiposPedidos[PosTipo].Titulos[PosTitulo].Valor.length;++i)
		{
			let newOption = new Option(arrTiposPedidos[PosTipo].Titulos[PosTitulo].Valor[i].Nombre,arrTiposPedidos[PosTipo].Titulos[PosTitulo].Valor[i].ID)
			document.forms['Principal'].elements['IDVALORTIPO'].add(newOption,undefined);
		}
	
		jQuery('#IDVALORTIPO').show();
	}
}
*/
