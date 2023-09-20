//	JS para la subficha de gestión comercial en la ficha de empresa
//	Creado ET 20oct17 11:17

function onloadEvents(){

	//solodebug	console.log('Inicio');
	

	//	12dic16	Marcamos la primera opción de menú
	jQuery("#pes_CondicPartic").css('background','#3b569b');
	jQuery("#pes_CondicPartic").css('color','#D6D6D6');
	
	// Codigo javascript para mostrar/ocultar tablas cuando se clica en pestañas
	jQuery("#pes_CondicPartic").click(function(){
	
		console.log('jQuery("#pes_CondicPartic").click(function()');

		//	16oct17	Marcamos la pestaña seleccionada
		jQuery("a.MenuLic").css('background','#F0F0F0');
		jQuery("a.MenuLic").css('color','#555555');
		jQuery("#pes_CondicPartic").css('background','#3b569b');
		jQuery("#pes_CondicPartic").css('color','#D6D6D6');


		jQuery(".tablas70").hide();
		jQuery("#pestanaCondicParticDiv").show();
	});
	jQuery("#pes_Evaluaciones").click(function(){
	
		console.log('jQuery("#pes_Evaluaciones").click(function()');

		//	16oct17	Marcamos la pestaña seleccionada
		jQuery("a.MenuLic").css('background','#F0F0F0');
		jQuery("a.MenuLic").css('color','#555555');
		jQuery("#pes_Evaluaciones").css('background','#3b569b');
		jQuery("#pes_Evaluaciones").css('color','#D6D6D6');


		jQuery(".tablas70").hide();
		jQuery("#pestanaEvaluacionesDiv").show();
	});
	jQuery("#pes_Incidencias").click(function(){
	
		console.log('jQuery("#pes_Incidencias").click(function()');

		//	16oct17	Marcamos la pestaña seleccionada
		jQuery("a.MenuLic").css('background','#F0F0F0');
		jQuery("a.MenuLic").css('color','#555555');
		jQuery("#pes_Incidencias").css('background','#3b569b');
		jQuery("#pes_Incidencias").css('color','#D6D6D6');


		jQuery(".tablas70").hide();
		jQuery("#pestanaIncidenciasDiv").show();
	});
	jQuery("#pes_Roturas").click(function(){
	
		console.log('jQuery("#pes_Roturas").click(function()');

		//	16oct17	Marcamos la pestaña seleccionada
		jQuery("a.MenuLic").css('background','#F0F0F0');
		jQuery("a.MenuLic").css('color','#555555');
		jQuery("#pes_Roturas").css('background','#3b569b');
		jQuery("#pes_Roturas").css('color','#D6D6D6');


		jQuery(".tablas70").hide();
		jQuery("#pestanaRoturasDiv").show();
	});
	
}






function CondProveedorSend(oForm){
	var IDProv	= oForm.elements['IDPROV'].value;
	var CodProv	= oForm.elements['COP_CODIGO'].value;
	var idFormaPago	= oForm.elements['IDFORMASPAGO'].value;
	var idPlazoPago	= oForm.elements['IDPLAZOSPAGO'].value;
	var gestionCad	= encodeURIComponent(oForm.elements['GESTION_CADUCIDAD'].value);
	var otrasLic	= encodeURIComponent(oForm.elements['OTRAS_LICITACIONES'].value);
	var observaciones	= encodeURIComponent(oForm.elements['OBSERVACIONES'].value);
	var nombrebanco	= encodeURIComponent(oForm.elements['COP_NOMBREBANCO'].value);
	var codbanco	= encodeURIComponent(oForm.elements['COP_CODBANCO'].value);
	var codoficina	= encodeURIComponent(oForm.elements['COP_CODOFICINA'].value);
	var codcuenta	= encodeURIComponent(oForm.elements['COP_CODCUENTA'].value);
	var infoprivada	= encodeURIComponent(oForm.elements['COP_INFORMACIONPRIVADA'].value);
	var d		= new Date();

	jQuery('#SAVE_MSG').hide();

	var Enlace="PROV_ID="+IDProv
			+"&CODIGO="+CodProv
			+"&IDFORMAPAGO="+idFormaPago
			+"&IDPLAZOPAGO="+idPlazoPago
			+"&GESTION_CADUCIDAD="+gestionCad
			+"&OTRAS_LICITACIONES="+otrasLic
			+"&OBSERVACIONES="+observaciones
			+"&NOMBREBANCO="+nombrebanco
			+"&CODBANCO="+codbanco
			+"&CODOFICINA="+codoficina
			+"&CODCUENTA="+codcuenta
			+"&INFOPRIVADA="+infoprivada
			+"&_="+d.getTime();

	//solodebug	alert(Enlace);

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CondProvSave.xsql',
		type:	"GET",
		data:	Enlace,
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.Estado == 'OK'){
				jQuery('#SAVE_MSG_CELL').html(condProvOK);
				jQuery('#SAVE_MSG').show();

				// DC - 09/12/13 - Si venimos de Gestion >> Proveedores entonces refrescamos el frame padre
				if ((window.opener != undefined) && (String(window.opener.document.location) == 'http://www.newco.dev.br/Gestion/Comercial/CondicionesProveedores.xsql')){
					Refresh(window.opener.document);
            	}
		}else{
				jQuery('#SAVE_MSG_CELL').html(condProvERR);
				jQuery('#SAVE_MSG').show();
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}

/*
function verTablas70(id){
	var k = id+"Div";

	jQuery(".tablas70").hide();
	jQuery("#PestanasInicio .veinte").css("background","#E3E2E2");
	jQuery("#"+id).css("background","#C3D2E9");
	jQuery("#"+k).show();
}
*/

function mostrarEIS(indicador, idempresa, idcentro, refPro, anno){
	var Enlace;

	Enlace='http://www.newco.dev.br/Gestion/EIS/EISDatos2.xsql?'
			+'IDCUADROMANDO='+indicador
			+'&'+'ANNO='+anno
			+'&'+'IDEMPRESA=-1'
			+'&'+'IDCENTRO='
			+'&'+'IDUSUARIO=-1'
			+'&'+'IDEMPRESA2='+idempresa
			+'&'+'IDCENTRO=-1'
			+'&'+'IDPRODUCTO=-1'
			+'&'+'IDGRUPOCAT=-1'
			+'&'+'IDSUBFAMILIA=-1'
			+'&'+'IDESTADO=-1'
			+'&'+'REFERENCIA='+refPro
			+'&'+'CODIGO='
			+'&'+'AGRUPARPOR=EMP2';

	MostrarPagPersonalizada(Enlace,'EIS',100,80,0,0);
}
