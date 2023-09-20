// Funciones JS para el control de pedidos
// 24ene17	Permitir cambiar comprador, vendedor o forma de pago
// Ultima revision 24ene17 10:26

jQuery(document).ready(globalEvents);


function globalEvents(){
        
	addEventListener('load', iniciar);
        
    jQuery("#verAvanzado").mouseover(function(){this.style.cursor="pointer";});
	jQuery("#verAvanzado").mouseout(function(){this.style.cursor="default";});
    jQuery("#verAvanzado").click(function(){
            if (document.getElementById("incidenciaFuera").style.display =='none'){
                 jQuery(".opcionesAvanzadas").show(); 
            }
            else  jQuery(".opcionesAvanzadas").hide();                             
        });
}

// *************   JS DE CONTROLPEDIDOSHTML.XSL **************************

 //enviarPDF a cliente o proveedor
function EnviarPDF(mo_id, tipo){

	var msgConfirm;
    if (tipo == 'CLIENTE')
		msgConfirm=jQuery("#textoConfirmPDFCliente").val();
	else
		msgConfirm=jQuery("#textoConfirmPDFProveedor").val();

	if (confirm(msgConfirm)==false) return;


  //si usuario tiene pedidos historicos o activos no se puede borrar
    jQuery.ajax({
        //cache:	false,
        url:	'http://www.newco.dev.br/Compras/Multioferta/enviarPDF.xsql',
        type:	"GET", 
        data:	"MO_ID="+mo_id+"&TIPO="+tipo,
        //contentType: "application/xhtml+xml",
        success: function(objeto){
            var data = eval("(" + objeto + ")");

            //alert('succes data '+data.enviarPDF.estado);

            //si se ha enviado ok 
            if(data.enviarPDF.estado == 'OK'){  
                if (tipo == 'CLIENTE'){
                    alert(document.forms['MensajeJS'].elements['PDF_ENVIADO_CLIENTE'].value);
                    }
                else{ alert(document.forms['MensajeJS'].elements['PDF_ENVIADO_PROVEE'].value); }
                return false;
            }
            //si no se ha enviado error
            else if(data.enviarPDF.estado == 'ERROR'){ 
                if (tipo == 'CLIENTE'){
                    alert(document.forms['MensajeJS'].elements['ERROR_PDF_ENVIADO_CLIENTE'].value);
                    }
                else{ alert(document.forms['MensajeJS'].elements['ERROR_PDF_ENVIADO_PROVEE'].value); }
                return false;
             }
        },
        error: function(xhr, errorString, exception) {
            alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
        }
    });

}//fin de enviar pdf


//COPIAR DATOS FECHA ENVIO Y ALBARAN de los controles arriba
function CopiarDatos(fecha, albaran){
	var form=document.forms[0];

	//alert(fecha+albaran);

	//enviado
	form.elements['CHK_ENVIADO'].checked = true;
	form.elements['CHK_NOENVIADO'].checked = false;
	//fecha envio
	form.elements['ENVIADO_CUANDO'].disabled=false;
	form.elements['ENVIADO_CUANDO'].value = fecha;
	form.elements['ENVIADO'].value='S';		

	if (albaran != ''){
		//albaran check, si hay albaran chk_confirmado true
		form.elements['CHK_CONFIRMADO'].disabled=false;
		form.elements['CHK_CONFIRMADO'].checked = true;

		form.elements['CHK_NOCONFIRMADO'].disabled=false;
		form.elements['CHK_NOCONFIRMADO'].checked = false;

		form.elements['ALBARAN'].disabled=false;
		form.elements['ALBARAN'].value = albaran;
		form.elements['CONFIRMADO'].value='S';
		form.elements['ENTREGADOPROVEEDOR'].value='N';

		//clinica aguanta a si si albaran y fecha enviado
		form.elements['CHK_ACEPTASOLUCION'].checked=true;
		form.elements['ACEPTASOLUCION'].value='S';

		//albaran sellado
		form.elements['CHK_ENTREGADOPROVEEDOR'].disabled=false;
		form.elements['CHK_NOENTREGADOPROVEEDOR'].disabled=false;

		//si fecha y albaran => fecha de accion a sin fecha
		form.elements['FECHAPROXIMAACCION'].value='';


	}
	else {
		form.elements['ALBARAN'].value = '';
		form.elements['CHK_CONFIRMADO'].disabled=false;
		form.elements['CHK_CONFIRMADO'].checked = false;

		form.elements['CHK_NOCONFIRMADO'].disabled=false;
		form.elements['CHK_NOCONFIRMADO'].checked = true;
		form.elements['CONFIRMADO'].value='N';
		form.elements['ENTREGADOPROVEEDOR'].value='N';

		//clinica aguanta a si si albaran y fecha enviado
		form.elements['CHK_ACEPTASOLUCION'].checked=false;
		form.elements['ACEPTASOLUCION'].value='';

	}

}

  //mail al vendedor
function MailEstimados(email, tipo){
	var form=document.forms[0];

	var numPedido = Url.encode(form.elements['NUMEROPEDIDO'].value);
	var nombreCentro = Url.encode(form.elements['NOMBRECENTRO'].value);
	var fechaEntrega = Url.encode(form.elements['FECHAENTREGA'].value);
	var estado = Url.encode(form.elements['ESTAD'].value);

	//alert(estado);

	var linea = "%0D%0A"; 
	var para = email;
	//var cc = email;
	var asunto = document.forms['MensajeJS'].elements['NUM_DE_PEDIDO'].value +" "+ numPedido +" "+ document.forms['MensajeJS'].elements['DE'].value + " " + nombreCentro + " " + fechaEntrega+ " "+ estado;

	//SI CONTACTAMOS CON EL CLIENTE
	if (tipo=='COMPRADOR'){
		var cuerpo = document.forms['MensajeJS'].elements['ESTIMADOS'].value + ": " + linea + linea;
		cuerpo += document.forms['MensajeJS'].elements['SI_PEDIDO_OS_HA_LLEGADO'].value + linea + linea;
		cuerpo += document.forms['MensajeJS'].elements['GRACIAS'].value + "!" + linea + linea;
		cuerpo += document.forms['MensajeJS'].elements['SALUDOS'].value + "," + linea + linea;
		cuerpo += document.forms['MensajeJS'].elements['RESPONSABLE_PEDIDOS'].value + linea + linea;
		cuerpo += document.forms['MensajeJS'].elements['WWW_MEDICALVM_COM'].value + linea + linea;
		cuerpo += document.forms['MensajeJS'].elements['TEL_MVM'].value + linea + linea;
		cuerpo += document.forms['MensajeJS'].elements['FAX_MVM'].value + linea + linea;/**/    
	}
	//SI CONTACTAMOS CON EL PROVEEDOR
	if (tipo=='VENDEDOR'){
		var cuerpo = document.forms['MensajeJS'].elements['BUENOS_DIAS'].value + ", " + linea + linea;
		cuerpo += document.forms['MensajeJS'].elements['ACEPTAR_PEDIDO_SISTEMA'].value + " " + linea + linea;
                    cuerpo += document.forms['MensajeJS'].elements['EL_PEDIDO'].value + " " + numPedido + " " + document.forms['MensajeJS'].elements['AGUARDA_RESCATE'].value + "." + linea + linea;
		cuerpo += document.forms['MensajeJS'].elements['GRACIAS'].value + "!" + linea + linea + linea + linea;
		cuerpo += document.forms['MensajeJS'].elements['SALUDOS'].value+"," + linea + linea;
		cuerpo += document.forms['MensajeJS'].elements['RESPONSABLE_PEDIDOS'].value + linea + linea;
		cuerpo += document.forms['MensajeJS'].elements['WWW_MEDICALVM_COM'].value + linea + linea;
		cuerpo += document.forms['MensajeJS'].elements['TEL_MVM'].value + linea + linea;
		cuerpo += document.forms['MensajeJS'].elements['FAX_MVM'].value + linea + linea;/**/ 
	}
	//SI CONTACTAMOS CON EL DELEGADO CLIENTE COMPRADOR
	if (tipo=='DELEGADO_COMP'){
		var cuerpo = document.forms['MensajeJS'].elements['ESTIMADOS'].value + ": " + linea + linea;
		cuerpo += document.forms['MensajeJS'].elements['SI_PEDIDO_OS_HA_LLEGADO'].value + linea + linea;
		cuerpo += document.forms['MensajeJS'].elements['GRACIAS'].value + "!" + linea + linea;
		cuerpo += document.forms['MensajeJS'].elements['SALUDOS'].value + "," + linea + linea;
		cuerpo += document.forms['MensajeJS'].elements['RESPONSABLE_PEDIDOS'].value + linea + linea;
		cuerpo += document.forms['MensajeJS'].elements['WWW_MEDICALVM_COM'].value + linea + linea;
		cuerpo += document.forms['MensajeJS'].elements['TEL_MVM'].value + linea + linea;
		cuerpo += document.forms['MensajeJS'].elements['FAX_MVM'].value + linea + linea;/**/    
	}
	//SI CONTACTAMOS CON EL DELEGADO PROVEEDOR VENDEDOR
	if (tipo=='DELEGADO_VEND'){
		var cuerpo = document.forms['MensajeJS'].elements['BUENOS_DIAS'].value + linea + linea;
                    cuerpo += document.forms['MensajeJS'].elements['INFORMAD_SALIDA_PEDIDO'].value + " " + numPedido + "." + linea + linea;
		cuerpo += document.forms['MensajeJS'].elements['GRACIAS'].value + "!" + linea + linea + linea + linea;
		cuerpo += document.forms['MensajeJS'].elements['SALUDOS'].value + "," + linea + linea;
		cuerpo += document.forms['MensajeJS'].elements['RESPONSABLE_PEDIDOS'].value + linea + linea;
		cuerpo += document.forms['MensajeJS'].elements['WWW_MEDICALVM_COM'].value + linea + linea;
		cuerpo += document.forms['MensajeJS'].elements['TEL_MVM'].value + linea + linea;
		cuerpo += document.forms['MensajeJS'].elements['FAX_MVM'].value + linea + linea;/**/    
	}

	var mensaje = "mailto:" + para +
	//"cc=" + cc +
	"?subject=" + asunto +
	"&body=" + cuerpo;
	//alert(mensaje);

	window.location = mensaje; 
}

	
			
//recupero valores de los check box segun la situacion
function RecuperoCheck(sit){

	var form=document.forms[0];

	//sit = -1 todo no, controles del proveedor
	if (sit == -1){
		form.elements['CHK_ENVIADO'].checked=false;
		form.elements['CHK_NOENVIADO'].checked=true;
		form.elements['ENVIADO_CUANDO'].disabled=true;
		form.elements['ENVIADO_CUANDO'].value='';

		form.elements['CHK_CONFIRMADO'].checked=false;
		form.elements['CHK_NOCONFIRMADO'].checked=true;
		form.elements['CHK_CONFIRMADO'].disabled=true;
		form.elements['CHK_NOCONFIRMADO'].disabled=true;
		form.elements['ALBARAN'].disabled=true;
		form.elements['ALBARAN'].value='';

		form.elements['CHK_ENTREGADOPROVEEDOR'].checked=false;
		form.elements['CHK_NOENTREGADOPROVEEDOR'].checked=true;
		form.elements['CHK_ENTREGADOPROVEEDOR'].disabled=true;
		form.elements['CHK_NOENTREGADOPROVEEDOR'].disabled=true;
		form.elements['ENVIADO'].value='N';
		form.elements['CONFIRMADO'].value='N';
		form.elements['ENTREGADOPROVEEDOR'].value='N';
	}
	//sit = 0 todo no
	if (sit == 0){
		form.elements['CHK_ENVIADO'].checked=false;
		form.elements['CHK_NOENVIADO'].checked=true;
		form.elements['ENVIADO_CUANDO'].disabled=true;
		form.elements['ENVIADO_CUANDO'].value='';

		form.elements['CHK_CONFIRMADO'].checked=false;
		form.elements['CHK_NOCONFIRMADO'].checked=true;

		form.elements['CHK_CONFIRMADO'].disabled=true;
		form.elements['CHK_NOCONFIRMADO'].disabled=true;
		form.elements['ALBARAN'].disabled=true;
		form.elements['ALBARAN'].value='';

		form.elements['CHK_ENTREGADOPROVEEDOR'].checked=false;
		form.elements['CHK_NOENTREGADOPROVEEDOR'].checked=true;
		form.elements['CHK_ENTREGADOPROVEEDOR'].disabled=true;
		form.elements['CHK_NOENTREGADOPROVEEDOR'].disabled=true;
		//CAMPOS QUE MANDAN
		form.elements['ENVIADO'].value='N';
		form.elements['CONFIRMADO'].value='N';
		form.elements['ENTREGADOPROVEEDOR'].value='N';
	}
	//sit = 1 fecha informada
	if (sit == 1){
		form.elements['CHK_ENVIADO'].checked=true;
		form.elements['CHK_NOENVIADO'].checked=false;
		form.elements['CHK_CONFIRMADO'].checked=false;
		form.elements['CHK_NOCONFIRMADO'].checked=true;
		form.elements['ALBARAN'].disabled=true;
		form.elements['ALBARAN'].value='';
		form.elements['CHK_ENTREGADOPROVEEDOR'].checked=false;
		form.elements['CHK_NOENTREGADOPROVEEDOR'].checked=true;
		form.elements['ENVIADO'].value='S';
		form.elements['CONFIRMADO'].value='N';
		form.elements['ENTREGADOPROVEEDOR'].value='N';
	}
	//fecha y albaran informados
		if (sit == 2){
		form.elements['CHK_ENVIADO'].checked=true;
		form.elements['CHK_NOENVIADO'].checked=false;
		form.elements['CHK_CONFIRMADO'].checked=true;
		form.elements['CHK_NOCONFIRMADO'].checked=false;
		form.elements['ALBARAN'].disabled=false;
		form.elements['CHK_ENTREGADOPROVEEDOR'].checked=false;
		form.elements['CHK_NOENTREGADOPROVEEDOR'].checked=true;
		form.elements['ENVIADO'].value='S';
		form.elements['CONFIRMADO'].value='S';
		form.elements['ENTREGADOPROVEEDOR'].value='N';

	}
	//fecha, albaran y albaran sellado informados
		if (sit == 3){
		form.elements['CHK_ENVIADO'].checked=true;
		form.elements['CHK_NOENVIADO'].checked=false;
		form.elements['CHK_CONFIRMADO'].checked=true;
		form.elements['CHK_NOCONFIRMADO'].checked=false;
		form.elements['ALBARAN'].disabled=false;
		form.elements['CHK_ENTREGADOPROVEEDOR'].checked=true;
		form.elements['CHK_NOENTREGADOPROVEEDOR'].checked=false;
		form.elements['ENVIADO'].value='S';
		form.elements['CONFIRMADO'].value='S';
		form.elements['ENTREGADOPROVEEDOR'].value='S';
	}

}
			

function ControlChecks(nombrecheck, estado)
{
	var form=document.forms[0];

	//si estado S y enviado abilito check
	if (estado=='S' && nombrecheck == 'ENVIADO'){
		form.elements['CHK_NOENVIADO'].checked=false;
		form.elements['CHK_ENVIADO'].checked=true;
		form.elements['ENVIADO'].value='S';

		form.elements['CHK_CONFIRMADO'].disabled=false;
		form.elements['CHK_NOCONFIRMADO'].disabled=false;

		form.elements['CHK_CONFIRMADO'].disabled=false;
		form.elements['CHK_NOCONFIRMADO'].disabled=false;

		form.elements['ALBARAN'].disabled=true;
		form.elements['CHK_ENTREGADOPROVEEDOR'].disabled=true;
		form.elements['CHK_NOENTREGADOPROVEEDOR'].disabled=true;

		form.elements['CONFIRMADO'].value='N';
		form.elements['ENTREGADOPROVEEDOR'].value='N';
	}
	else{
		if (estado!='S' && nombrecheck == 'ENVIADO'){
			form.elements['CHK_NOENVIADO'].checked=true;
			form.elements['CHK_ENVIADO'].checked=false;
			form.elements['ENVIADO'].value='N';

			form.elements['CHK_CONFIRMADO'].disabled=true;
			form.elements['CHK_NOCONFIRMADO'].disabled=true;
			form.elements['CHK_CONFIRMADO'].checked=false;
			form.elements['CHK_NOCONFIRMADO'].checked=true;
			form.elements['CONFIRMADO'].value='N';

			form.elements['ALBARAN'].disabled=true;
			form.elements['ALBARAN'].value='';
			form.elements['CHK_ENTREGADOPROVEEDOR'].checked=false;
			form.elements['CHK_NOENTREGADOPROVEEDOR'].checked=true;
			form.elements['CHK_ENTREGADOPROVEEDOR'].disabled=true;
			form.elements['CHK_NOENTREGADOPROVEEDOR'].disabled=true;
			form.elements['ENTREGADOPROVEEDOR'].value='N';
		}
	}
	//albaran si abilito texto
	if (estado=='S' && nombrecheck == 'CONFIRMADO'){
		form.elements['CHK_CONFIRMADO'].checked=true;
		form.elements['CHK_NOCONFIRMADO'].checked=false;

		form.elements['CONFIRMADO'].value='S';
		form.elements['ALBARAN'].disabled=false;

		form.elements['CHK_ENTREGADOPROVEEDOR'].disabled=false;
		form.elements['CHK_NOENTREGADOPROVEEDOR'].disabled=false;
		form.elements['ENTREGADOPROVEEDOR'].value='N';

	}
	//albaran si abilito texto
	if (estado!='S' && nombrecheck == 'CONFIRMADO'){
		form.elements['CHK_CONFIRMADO'].checked=false;
		form.elements['CHK_NOCONFIRMADO'].checked=true;
		form.elements['CONFIRMADO'].value='N';

		form.elements['ALBARAN'].disabled=true;
		form.elements['ALBARAN'].value='';
		form.elements['CHK_ENTREGADOPROVEEDOR'].disabled=true;
		form.elements['CHK_NOENTREGADOPROVEEDOR'].disabled=true;
		form.elements['CHK_ENTREGADOPROVEEDOR'].checked=false;
		form.elements['CHK_NOENTREGADOPROVEEDOR'].checked=true;
		form.elements['ENTREGADOPROVEEDOR'].value='N';

		//clinica aguanta a noi si no albaran y fecha enviado
		form.elements['CHK_ACEPTASOLUCION'].checked=false;
		form.elements['ACEPTASOLUCION'].value='';
	}

	//normal
	var checks = ["ENTREGADOPROVEEDOR", "FUERA_PLAZO", "PRODUCTOS_ANADIDOS", "PRODUCTOS_RETIRADOS", "NO_INFORMADO_PLATAFORMA", "RETRASO_DOC_TECNICA", "PEDIDO_NO_COINCIDE", "MALA_ATENCION_PROV"];

	for (var i=0; i<checks.length; i++){
    	if (nombrecheck == checks[i]){
        	if (form.elements['CHK_'+nombrecheck].checked == true){
            	form.elements[nombrecheck].value='S';
        	}
        	if (form.elements['CHK_'+nombrecheck].checked == false){
            	form.elements[nombrecheck].value='N';
        	}
    	}
	}
	/*
	if (estado!='S' && nombrecheck == 'ENTREGADOPROVEEDOR'){
		form.elements['CHK_'+nombrecheck].checked=false;
		form.elements['CHK_NO'+nombrecheck].checked=true;
		form.elements[nombrecheck].value='N';
	}	
                    if (estado=='S' && nombrecheck == 'FUERA_PLAZO'){
		if (form.elements['CHK_'+nombrecheck].checked == true){
                                form.elements[nombrecheck].value='S';
                            }
                            if (form.elements['CHK_'+nombrecheck].checked == false){
                                form.elements[nombrecheck].value='N';
                            }
	}
                    if (estado=='S' && nombrecheck == 'PRODUCTOS_ANADIDOS'){
		if (form.elements['CHK_'+nombrecheck].checked == true){
                                form.elements[nombrecheck].value='S';
                            }
                            if (form.elements['CHK_'+nombrecheck].checked == false){
                                form.elements[nombrecheck].value='N';
                            }
	}
                    if (estado=='S' && nombrecheck == 'PRODUCTOS_RETIRADOS'){
		if (form.elements['CHK_'+nombrecheck].checked == true){
                                form.elements[nombrecheck].value='S';
                            }
                            if (form.elements['CHK_'+nombrecheck].checked == false){
                                form.elements[nombrecheck].value='N';
                            }
	}
                    if (estado=='S' && nombrecheck == 'NO_INFORMADO_PLATAFORMA'){
		if (form.elements['CHK_'+nombrecheck].checked == true){
                                form.elements[nombrecheck].value='S';
                            }
                            if (form.elements['CHK_'+nombrecheck].checked == false){
                                form.elements[nombrecheck].value='N';
                            }
	}
                    if (estado=='S' && nombrecheck == 'RETRASO_DOC_TECNICA'){
		if (form.elements['CHK_'+nombrecheck].checked == true){
                                form.elements[nombrecheck].value='S';
                            }
                            if (form.elements['CHK_'+nombrecheck].checked == false){
                                form.elements[nombrecheck].value='N';
                            }
	}
                    if (estado=='S' && nombrecheck == 'PEDIDO_NO_COINCIDE'){
		if (form.elements['CHK_'+nombrecheck].checked == true){
                                form.elements[nombrecheck].value='S';
                            }
                            if (form.elements['CHK_'+nombrecheck].checked == false){
                                form.elements[nombrecheck].value='N';
                            }
	}*/



}

//solo para check de la clinica aguanta
function ControlAguanta(nombrecheck, estado){

	var form=document.forms[0];
	//para clinica aguanta
	if (nombrecheck == 'ACEPTASOLUCION'){
		if (estado=='S'){
			if (form.elements['CHK_ACEPTASOLUCION'].checked == true){
				form.elements['CHK_ACEPTASOLUCION'].checked=true;
				form.elements['CHK_NOACEPTASOLUCION'].checked=false;
				form.elements['CHK_AVISOACEPTASOLUCION'].checked=false;
				form.elements['ACEPTASOLUCION'].value='S';
				}
			else {
				form.elements['CHK_ACEPTASOLUCION'].checked=false;
				form.elements['CHK_NOACEPTASOLUCION'].checked=false;
				form.elements['CHK_AVISOACEPTASOLUCION'].checked=false;
				form.elements['ACEPTASOLUCION'].value='';
				}
		}

		if (estado=='N'){
			if (form.elements['CHK_NOACEPTASOLUCION'].checked == true){
				form.elements['CHK_NOACEPTASOLUCION'].checked=true;
				form.elements['CHK_ACEPTASOLUCION'].checked=false;
				form.elements['CHK_AVISOACEPTASOLUCION'].checked=false;
				form.elements['ACEPTASOLUCION'].value='N';
				}
			else {
				form.elements['CHK_NOACEPTASOLUCION'].checked=false;
				form.elements['CHK_NOACEPTASOLUCION'].checked=false;
				form.elements['CHK_AVISOACEPTASOLUCION'].checked=false;
				form.elements['ACEPTASOLUCION'].value='';
			}

		}

		if (estado=='Z'){
			if (form.elements['CHK_AVISOACEPTASOLUCION'].checked == true){
				form.elements['CHK_AVISOACEPTASOLUCION'].checked=true;
				form.elements['CHK_ACEPTASOLUCION'].checked=false;
				form.elements['CHK_NOACEPTASOLUCION'].checked=false;
				form.elements['ACEPTASOLUCION'].value='Z';
				}
			else {
				form.elements['CHK_AVISOACEPTASOLUCION'].checked=false;
				form.elements['CHK_ACEPTASOLUCION'].checked=false;
				form.elements['CHK_NOACEPTASOLUCION'].checked=false;
				form.elements['ACEPTASOLUCION'].value='';
			}


		}
	}
}//fin controlAguanta
			
			
function Enviar()
{

	var form=document.forms[0];
        form.action = "ControlPedidosSave.xsql";
        form.enctype = "application/x-www-form-urlencoded";
        form.method = "post";
        form.target = '';

	var msg_error='';
	var user=form.elements['USUARIO'].value;
	var provocli=form.elements['PROVEEDOROCLIENTE'].value;
	var enviado=form.elements['ENVIADO'].value;
	var entregado=form.elements['ENTREGADOPROVEEDOR'].value;
	var confirmado=form.elements['CONFIRMADO'].value;
	var albaran=form.elements['ALBARAN'].value;

	//alert('confirm '+confirmado+'env '+enviado+ 'entreg '+entregado);

	if (user=='-1')
		msg_error=msg_error+ document.forms['MensajeJS'].elements['OBLIGATORIO_USUARIO'].value + '\n';

	if (form.elements['COSTE'].value=='-1')
		msg_error=msg_error+document.forms['MensajeJS'].elements['OBLIGATORIO_CAMPO_TAREA'].value + '\n';

	if ((enviado=='S')&&(enviado=='N'))
		msg_error=msg_error+document.forms['MensajeJS'].elements['OBLIGATORIO_PROVE_ENVIADO'].value + '\n';

	if (enviado=='S')
	{
		msg=CheckDate(form.elements['ENVIADO_CUANDO'].value);

		if (msg!='')
			msg_error=msg_error+document.forms['MensajeJS'].elements['ERROR_FECHA_ENVIO_PEDIDO'].value +': '+msg+'\n';
	}

	if ((enviado=='S')&&(form.elements['ENVIADO_CUANDO'].value==''))
		msg_error=msg_error+document.forms['MensajeJS'].elements['OBLIGATORIO_FECHA_ENVIO'].value+'\n';

	if ((confirmado=='S')&&(albaran=='')){
		msg_error=msg_error+document.forms['MensajeJS'].elements['OBLIGATORIO_ALBARAN'].value+'\n';
	}

	if (form.elements['INTERLOCUTOR'].value=='')
		msg_error=msg_error+document.forms['MensajeJS'].elements['INTERLOCUTOR'].value+'\n';

	if (form.elements['USUARIOSIGUIENTE'].value=='-1')
		msg_error=msg_error+document.forms['MensajeJS'].elements['OBLIGATORIO_RESP_PROXIMA_ACCION'].value+'\n';

	if (form.elements['FECHAPROXIMAACCION'].value=='-1')
		msg_error=msg_error+document.forms['MensajeJS'].elements['OBLIGATORIO_CAMPO_PROXIMA_ACCION'].value+'\n';

                    //alert('fuera plazo '+form.elements['FUERA_PLAZO'].value);

	//Semaforo

	//alert(form.elements['COMENTARIOS_PARA_CLINICA'].value);
	//alert(form.elements['SOLO_COMENTARIOS_PARA_CLINICA'].value);
	if (msg_error=='')
	{
		form.elements['SOLO_COMENTARIOS_PARA_CLINICA'].value='N';
		SubmitForm(form);
	}
	else
	{
		alert (msg_error);
	}
}


function EnviarSoloComentario()
{
	var form=document.forms[0];
	var msg_error='';

	var user=form.elements['USUARIO'].value;

	if(user=='-1')
		msg_error=msg_error+document.forms['MensajeJS'].elements['INFORMAR_USUARIO_COMENTARIO'].value + '\n';

	if (form.elements['COMENTARIOS_PARA_CLINICA'].value=='-1')
		msg_error=msg_error+ document.forms['MensajeJS'].elements['OBLIGATORIO_COMENTARIO_CLINICA'].value + '\n';

	if (msg_error=='')
	{
		form.elements['SOLO_COMENTARIOS_PARA_CLINICA'].value='S';
		SubmitForm(form);
	}
	else
	{
		alert (msg_error);
	}
}
			


function Salir()
{
	var form=document.forms[0];
	var salir=false;

	if (form.elements['COMENTARIOS'].value=='')
	{
		salir=true;
	}
	else
	{
		if (confirm(document.forms['MensajeJS'].elements['DATOS_PENDIENTE_PERDERA'].value)==true) salir=true;
	}
	if (salir==true)
		document.location='WFStatus.xsql?IDEMPRESA='+form.elements['IDEMPRESA'].value+'&IDCENTRO='+form.elements['IDCENTRO'].value
													+'&IDPROVEEDOR='+form.elements['IDPROVEEDOR'].value+'&IDFILTROMOTIVO='+form.elements['IDFILTROMOTIVO'].value;
}

function Back()
{
	history.go(-1);
}

//	si se ha enviado muestra un texto
function ControlEnviado(Estado)
{
	var form=document.forms[0];
	if (Estado=='S')
	{
		document.getElementById("Texto_fecha_enviado").style.display='';
		document.getElementById("Texto_fecha_enviara").style.display='none';
		form.elements['ENVIADO_CUANDO'].disabled=false;
	}
	else
	{
		document.getElementById("Texto_fecha_enviado").style.display='none';
		document.getElementById("Texto_fecha_enviara").style.display='';
		form.elements['ENVIADO_CUANDO'].disabled=true;
		form.elements['ENVIADO_CUANDO'].value='';
	}
}
			
/*	Si no hay albaran bloquea el input y borra el contenido
function ControlAlbaran(Estado)
{
	var form=document.forms[0];
	if (Estado=='S')
	{
		form.elements['ALBARAN'].disabled=false;
	}
	else
	{
		form.elements['ALBARAN'].disabled=true;
		form.elements['ALBARAN'].value='';
	}
}*/
			
//eliminar comentario
function EliminarEntrada(Entrada)
{
	var form=document.forms[0];
	var msg='';

	if (Entrada=='TODAS') 
		msg=document.forms['MensajeJS'].elements['ELIMINAR_TODAS_ENTRADAS_MES'].value;
	else
		msg=document.forms['MensajeJS'].elements['ELIMINAR_ENTRADA_MES'].value;

	if (confirm(msg)==true)
	{
		form.elements['ELIMINAR_ENTRADA'].value=Entrada;
		SubmitForm(form);
	}
}

//eliminar comentarios para las clinicas
function EliminarComentProve(Comentario)
{
	var form=document.forms[0];
	var msg='';

	if (Comentario=='TODAS') 
		msg=document.forms['MensajeJS'].elements['ELIMINAR_TODOS_COMENTARIO_MES'].value;
	else
		msg=document.forms['MensajeJS'].elements['ELIMINAR_COMENTARIO_MES'].value;

	if (confirm(msg)==true)
	{
		form.elements['ELIMINAR_COME_PROVE'].value=Comentario;
		SubmitForm(form);
	}
}




//funcion que reenvia el pdf al vendedor del pedido, al usuario vendedor del proveedor
 function GenerarPDF(){
    var form=document.forms['Cabecera'];
    var jsForm=document.forms['MensajeJS'];
    var mo_id = form.elements['MO_ID'].value;

    //alert('mi '+mo_id);
    jQuery.ajax({
        cache:	false,
        url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Pedidos/RecargarPDF.xsql',
        type:	"GET",
        data:	"MO_ID="+mo_id,
        contentType: "application/xhtml+xml",
        success: function(objeto){
            var data = eval("(" + objeto + ")");

            /*if(data.RecargarPDF.estado == 'OK'){
                alert(jsForm.elements['PDF_ENVIADO_CON_EXITO'].value);

            }*/
        },
        error: function(xhr, errorString, exception) {
            alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
        }
    });
}//fin de generarPDF


//actualizar fecha de entrega del pedido
function ActFechaEntrega(){
    var formu = document.forms['Cabecera'];
    var fecha = formu.elements['FECHA_ENTREGA_REAL'].value;
    var idPedido = formu.elements['IDPEDIDO'].value;
    
  
			jQuery.ajax({
				cache:	false,
				url:	'http://www.newco.dev.br/Personal/BandejaTrabajo/ActFechaEntregaAJAX.xsql',
				type:	"GET",
				data:	"IDPEDIDO="+idPedido+"&FECHA="+fecha,
				contentType: "application/xhtml+xml",
				success: function(objeto){
					var data = eval("(" + objeto + ")");
                                        //alert(data.estado);
					//if(data.estado == 'OK'){}
                                           
				},
				error: function(xhr, errorString, exception) {
					alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
				}
			});
       
} //fin validarRefProd

