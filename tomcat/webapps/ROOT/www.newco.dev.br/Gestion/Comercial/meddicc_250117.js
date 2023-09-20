//	ültima revisión: ET 25ene17

function replaceTextArea(){
	
	jQuery("#MeddiccTable textarea").each(function() {
					jQuery('#'+this.id).html(jQuery('#'+this.id).text().replace(/<br>/gi,'\n'));
            });
}


//	Envía el formulario
function Enviar()
{
	//alert(document.forms[0].elements["ACCION"].value+':'+document.forms[0].elements["PARAMETROS"].value);
	SubmitForm(document.forms[0]);
}


//	Mostrar otra empresa, solo llama a Enviar sin ninguna acción
function CambiarEmpresa()
{
	document.forms[0].elements["ACCION"].value='';
	document.forms[0].elements["PARAMETROS"].value='';

	Enviar();
}


//	Busca ID, asigna acción y envía formulario
function Guardar(Linea)
{
	document.forms[0].elements["ACCION"].value='GUARDAR';
	document.forms[0].elements["PARAMETROS"].value=Linea+'|'+document.forms[0].elements["TEXTO_OK_"+Linea].value
													+'|'+document.forms[0].elements["TEXTO_IN_"+Linea].value
													+'|'+document.forms[0].elements["TEXTO_KO_"+Linea].value;
													
	Enviar();
}

function GuardarTodo()
{
	var form = document.forms[0];
	
	form.elements["ACCION"].value='GUARDAR';
	
	var parametros= '';
	
	if (form.elements["ESTADO"].value == '-1' || form.elements["ESTADO"].value == ''){
		alert(form.elements["ESTADO_OBLI"].value);
		form.elements["ESTADO"].style.border = "1px solid red";
		form.elements["ESTADO"].style.background = "#FF6";
		}
		//si esta informado estado sigo y envio si no no
	else{ 
	
	parametros = form.elements["ESTADO"].value; 
	
	
	//array para los valores de las lineas

	//metrics
	var metricsOld = new Array();
	metricsOld[0] = form.elements["TEXTO_OK_1_OLD"].value;
	metricsOld[1] = form.elements["TEXTO_IN_1_OLD"].value;
	metricsOld[2] = form.elements["TEXTO_KO_1_OLD"].value;
	var metrics = new Array();
	metrics[0] = form.elements["TEXTO_OK_1"].value;
	metrics[1] = form.elements["TEXTO_IN_1"].value;
	metrics[2] = form.elements["TEXTO_KO_1"].value;
	//EB
	var EBOld = new Array();
	EBOld[0] = form.elements["TEXTO_OK_2_OLD"].value;
	EBOld[1] = form.elements["TEXTO_IN_2_OLD"].value;
	EBOld[2] = form.elements["TEXTO_KO_2_OLD"].value;
	var EB = new Array();
	EB[0] = form.elements["TEXTO_OK_2"].value;
	EB[1] = form.elements["TEXTO_IN_2"].value;
	EB[2] = form.elements["TEXTO_KO_2"].value;
	//DP
	var DPOld = new Array();
	DPOld[0] = form.elements["TEXTO_OK_3_OLD"].value;
	DPOld[1] = form.elements["TEXTO_IN_3_OLD"].value;
	DPOld[2] = form.elements["TEXTO_KO_3_OLD"].value;
	var DP = new Array();
	DP[0] = form.elements["TEXTO_OK_3"].value;
	DP[1] = form.elements["TEXTO_IN_3"].value;
	DP[2] = form.elements["TEXTO_KO_3"].value;
	//DC
	var DCOld = new Array();
	DCOld[0] = form.elements["TEXTO_OK_4_OLD"].value;
	DCOld[1] = form.elements["TEXTO_IN_4_OLD"].value;
	DCOld[2] = form.elements["TEXTO_KO_4_OLD"].value;
	var DC = new Array();
	DC[0] = form.elements["TEXTO_OK_4"].value;
	DC[1] = form.elements["TEXTO_IN_4"].value;
	DC[2] = form.elements["TEXTO_KO_4"].value;
	//PaIn
	var PaInOld = new Array();
	PaInOld[0] = form.elements["TEXTO_OK_5_OLD"].value;
	PaInOld[1] = form.elements["TEXTO_IN_5_OLD"].value;
	PaInOld[2] = form.elements["TEXTO_KO_5_OLD"].value;
	var PaIn = new Array();
	PaIn[0] = form.elements["TEXTO_OK_5"].value;
	PaIn[1] = form.elements["TEXTO_IN_5"].value;
	PaIn[2] = form.elements["TEXTO_KO_5"].value;
	//CH
	var CHOld = new Array();
	CHOld[0] = form.elements["TEXTO_OK_6_OLD"].value;
	CHOld[1] = form.elements["TEXTO_IN_6_OLD"].value;
	CHOld[2] = form.elements["TEXTO_KO_6_OLD"].value;
	var CH = new Array();
	CH[0] = form.elements["TEXTO_OK_6"].value;
	CH[1] = form.elements["TEXTO_IN_6"].value;
	CH[2] = form.elements["TEXTO_KO_6"].value;
	//CO
	var CoOld = new Array();
	CoOld[0] = form.elements["TEXTO_OK_7_OLD"].value;
	CoOld[1] = form.elements["TEXTO_IN_7_OLD"].value;
	CoOld[2] = form.elements["TEXTO_KO_7_OLD"].value;
	var Co = new Array();
	Co[0] = form.elements["TEXTO_OK_7"].value;
	Co[1] = form.elements["TEXTO_IN_7"].value;
	Co[2] = form.elements["TEXTO_KO_7"].value;
	//Comentarios
	var ComentariosOld = new Array();
	ComentariosOld[0] = form.elements["TEXTO_OK_8_OLD"].value;
	ComentariosOld[1] = form.elements["TEXTO_IN_8_OLD"].value;
	ComentariosOld[2] = form.elements["TEXTO_KO_8_OLD"].value;
	var Comentarios = new Array();
	Comentarios[0] = form.elements["TEXTO_OK_8"].value;
	Comentarios[1] = form.elements["TEXTO_IN_8"].value;
	Comentarios[2] = form.elements["TEXTO_KO_8"].value;
	//Next step
	var NextStepOld = new Array();
	NextStepOld[0] = form.elements["TEXTO_OK_9_OLD"].value;
	NextStepOld[1] = form.elements["TEXTO_IN_9_OLD"].value;
	NextStepOld[2] = form.elements["TEXTO_KO_9_OLD"].value;
	var NextStep = new Array();
	NextStep[0] = form.elements["TEXTO_OK_9"].value;
	NextStep[1] = form.elements["TEXTO_IN_9"].value;
	NextStep[2] = form.elements["TEXTO_KO_9"].value;
	
	
	//si los valores son todos iguales no envio, si no envio toda la linea
	if (metricsOld[0] == metrics[0] && metricsOld[1] == metrics[1] && metricsOld[2] == metrics[2]){}
	else { parametros = parametros + '#1|'+ metrics[0]+'|'+metrics[1]+'|'+metrics[2];   }
	
	if (EBOld[0] == EB[0] && EBOld[1] == EB[1] && EBOld[2] == EB[2]){}
	else { parametros = parametros + '#2|'+ EB[0]+'|'+EB[1]+'|'+EB[2];   }
	
	if (DPOld[0] == DP[0] && DPOld[1] == DP[1] && DPOld[2] == DP[2]){}
	else { parametros = parametros + '#3|'+ DP[0]+'|'+DP[1]+'|'+DP[2];   }
	
	if (DCOld[0] == DC[0] && DCOld[1] == DC[1] && DCOld[2] == DC[2]){}
	else { parametros = parametros + '#4|'+ DC[0]+'|'+DC[1]+'|'+DC[2];   }
	
	if (PaInOld[0] == PaIn[0] && PaInOld[1] == PaIn[1] && PaInOld[2] == PaIn[2]){}
	else { parametros = parametros + '#5|'+ PaIn[0]+'|'+PaIn[1]+'|'+PaIn[2];   }
	
	if (CHOld[0] == CH[0] && CHOld[1] == CH[1] && CHOld[2] == CH[2]){}
	else { parametros = parametros + '#6|'+ CH[0]+'|'+CH[1]+'|'+CH[2];   }
	
	if (CoOld[0] == Co[0] && CoOld[1] == Co[1] && CoOld[2] == Co[2]){}
	else { parametros = parametros + '#7|'+ Co[0]+'|'+Co[1]+'|'+Co[2];   }
	
	if (ComentariosOld[0] == Comentarios[0] && ComentariosOld[1] == Comentarios[1] && ComentariosOld[2] == Comentarios[2]){}
	else { parametros = parametros + '#8|'+ Comentarios[0]+'|'+Comentarios[1]+'|'+Comentarios[2];   }
	
	if (NextStepOld[0] == NextStep[0] && NextStepOld[1] == NextStep[1] && NextStepOld[2] == NextStep[2]){}
	else { parametros = parametros + '#9|'+ NextStep[0]+'|'+NextStep[1]+'|'+NextStep[2];   }
	
	document.forms[0].elements["PARAMETROS"].value= parametros;
	
	//alert('param '+document.forms[0].elements["PARAMETROS"].value);
													
	Enviar();
	
	}//fin de else si hay estado, si no esta informado estado no envio nada.
	
	
}












