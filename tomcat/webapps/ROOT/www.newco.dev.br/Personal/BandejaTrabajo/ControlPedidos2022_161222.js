// Funciones JS para el control de pedidos
// Ultima revision Ultima revision: ET 16dic22 10:30 ControlPedidos2022_161222.js

jQuery(document).ready(globalEvents);

const PaginaOrigen="ControlPedidos";

function globalEvents()
{
}



//	Prepara el formulario para ser enviado
function Enviar()
{
	var form=document.forms[0];
        form.action = "ControlPedidos2022.xsql";
        form.enctype = "application/x-www-form-urlencoded";
        form.method = "post";
        form.target = '';
	
	//solodebug	alert('Enviar. Accion:'+jQuery('#ACCION').val());
	
	SubmitForm(form);
}

//	Revisa todos los campos y env�a el formulario
function EnviarTodo()
{

	var form=document.forms[0];
	var msg_error='';
	var user=form.elements['IDUSUARIOCONTROL'].value;
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

	/*	1dic20 ALBARAN Opcional
	if ((confirmado=='S')&&(albaran=='')){
		msg_error=msg_error+document.forms['MensajeJS'].elements['OBLIGATORIO_ALBARAN'].value+'\n';
	}*/

	if (form.elements['INTERLOCUTOR'].value=='')
		msg_error=msg_error+document.forms['MensajeJS'].elements['INTERLOCUTOR'].value+'\n';

	if (form.elements['USUARIOSIGUIENTE'].value=='-1')
		msg_error=msg_error+document.forms['MensajeJS'].elements['OBLIGATORIO_RESP_PROXIMA_ACCION'].value+'\n';

	if (form.elements['FECHAPROXIMAACCION'].value=='-1')
		msg_error=msg_error+document.forms['MensajeJS'].elements['OBLIGATORIO_CAMPO_PROXIMA_ACCION'].value+'\n';

                    //alert('fuera plazo '+form.elements['FUERA_PLAZO'].value);

	//	4mar19 Nuevos campos
	if (form.elements['CHK_ERROR_CONDICIONES_COMERCIALES'].checked==true)
		form.elements['ERROR_CONDICIONES_COMERCIALES'].value='S';
	else
		form.elements['ERROR_CONDICIONES_COMERCIALES'].value='N';
		
	//	4mar19 Nuevos campos
	if (form.elements['CHK_ERROR_INTEGRIDAD_TODOS'].checked==true)
		form.elements['ERROR_INTEGRIDAD_PRODUCTOS'].value='T';
	else 
	{
		if (form.elements['CHK_ERROR_INTEGRIDAD_ALGUNOS'].checked==true)
			form.elements['ERROR_INTEGRIDAD_PRODUCTOS'].value='A';
		else
			form.elements['ERROR_INTEGRIDAD_PRODUCTOS'].value='N';
	}
	
	//solodebug
	//solodebug	alert('Enviar control. CHK_ERROR_CONDICIONES_COMERCIALES:'+form.elements['CHK_ERROR_CONDICIONES_COMERCIALES'].checked+' valor:'+form.elements['ERROR_CONDICIONES_COMERCIALES'].value
	//solodebug			+'. CHK_ERROR_INTEGRIDAD_TODOS:'+form.elements['CHK_ERROR_INTEGRIDAD_TODOS'].checked
	//solodebug			+' CHK_ERROR_INTEGRIDAD_ALGUNOS:'+form.elements['CHK_ERROR_INTEGRIDAD_ALGUNOS'].checked+' valor:'+form.elements['ERROR_INTEGRIDAD_PRODUCTOS'].value);

	//Semaforo

	//alert(form.elements['COMENTARIOS_PARA_CLINICA'].value);
	//alert(form.elements['SOLO_COMENTARIOS_PARA_CLINICA'].value);
	if (msg_error=='')
	{
		form.elements['SOLO_COMENTARIOS_PARA_CLINICA'].value='N';
		jQuery('#ACCION').val('GUARDARCONTROL');
		Enviar();//24oct19 SubmitForm(form);
	}
	else
	{
		alert (msg_error);
	}
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
            //var data = eval("(" + objeto + ")");
            var data = JSON.parse(objeto);

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
	var estado = Url.encode(form.elements['ESTADO'].value);

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
function RecuperoCheck(sit)
{

	//solodebug console.log('RecuperoCheck('+sit+')');

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
	else if (sit == 0){
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
	else if (sit == 1){
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
	else if (sit == 2){
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
	else if (sit == 3){
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

	//si estado S y enviado habilito check
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

	//albaran si abilito texto
	if (estado='S' && nombrecheck == 'ENTREGADOPROVEEDOR'){
		form.elements['CHK_NOENTREGADOPROVEEDOR'].checked=false;
	}
	
	//normal
	var checks = ["ENTREGADOPROVEEDOR", "FUERA_PLAZO", "PRODUCTOS_ANADIDOS", "PRODUCTOS_RETIRADOS", "NO_INFORMADO_PLATAFORMA", "RETRASO_DOC_TECNICA", "PEDIDO_NO_COINCIDE", "MALA_ATENCION_PROV",
	"ERROR_CONDICIONES_COMERCIALES"];

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
			
			

//	4mar19 Solo un check de integridad marcado
function CheckIntegridad(valor)
{
	var form=document.forms[0];
	form.elements['CHK_ERROR_INTEGRIDAD_TODOS'].checked=false;
	form.elements['CHK_ERROR_INTEGRIDAD_ALGUNOS'].checked=false;
	form.elements['CHK_ERROR_INTEGRIDAD_NINGUNO'].checked=false;

	if (valor=='T')
		form.elements['CHK_ERROR_INTEGRIDAD_TODOS'].checked=true;
	else if (valor=='A')
		form.elements['CHK_ERROR_INTEGRIDAD_ALGUNOS'].checked=true;
	else 
		form.elements['CHK_ERROR_INTEGRIDAD_NINGUNO'].checked=true;
}

function EnviarSoloComentario()
{
	var form=document.forms[0];
	var msg_error='';

	var user=form.elements['IDUSUARIOCONTROL'].value;

	if(user=='-1')
		msg_error=msg_error+document.forms['MensajeJS'].elements['INFORMAR_USUARIO_COMENTARIO'].value + '\n';

	if (form.elements['COMENTARIOS_PARA_CLINICA'].value=='-1')
		msg_error=msg_error+ document.forms['MensajeJS'].elements['OBLIGATORIO_COMENTARIO_CLINICA'].value + '\n';

	if (msg_error=='')
	{
		form.elements['SOLO_COMENTARIOS_PARA_CLINICA'].value='S';
		jQuery('#ACCION').val('GUARDARCONTROL');
		Enviar();//24oct19 SubmitForm(form);
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
		document.location='WFStatus2022.xsql?IDEMPRESA='+form.elements['IDEMPRESA'].value+'&IDCENTRO='+form.elements['IDCENTRO'].value
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
		form.elements['ACCION'].value='ELIMINARENTRADA';
		Enviar();//24oct19 SubmitForm(form);
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
		form.elements['ACCION'].value='ELIMINAR_COME_PROVE';
		Enviar();//24oct19 SubmitForm(form);
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
function ActFechaEntrega(Tipo)
{
    var formu = document.forms['Cabecera'];
   	var fecha = (Tipo=='SOLICITADA')?formu.elements['FECHA_ENTREGA'].value:formu.elements['FECHA_ENTREGA_REAL'].value;
    var idPedido = formu.elements['IDPEDIDO'].value;
    
  
	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Personal/BandejaTrabajo/ActFechaEntregaAJAX.xsql',
		type:	"GET",
		data:	"IDPEDIDO="+idPedido+"&TIPO="+Tipo+"&FECHA="+fecha,
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");
                                //alert(data.estado);
			if(data.estado == 'OK')
				alert(strFechaGuardadaCorrectamente);
			else
				alert(strFechaErrorGuardando);

		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
       
} //fin validarRefProd


//	24ene17 Nuevas funciones para cambiar el usuario comprador o vendedor
function CambioComprador()
{
 	jQuery("#btnGuardarComprador").show(); 
 	jQuery("#imgCompradorOK").hide(); 
 	jQuery("#imgCompradorKO").hide(); 
}

//	14dic20 cambio de Gestor
function CambioGestor()
{
 	jQuery("#btnGuardarGestor").show(); 
 	jQuery("#imgGestorOK").hide(); 
 	jQuery("#imgGestorKO").hide(); 
}

function CambioVendedor()
{
	jQuery("#spDatosVendedor").show(); 
 	jQuery("#imgVendedorOK").hide(); 
 	jQuery("#imgVendedorKO").hide(); 
}

function GuardarComprador()
{
    var form=document.forms['Cabecera'];
    //form.elements['IDNUEVOCOMPRADOR'].value=form.elements['IDCOMPRADOR'].value;
    var idMultioferta = form.elements['MO_ID'].value;
	var idComprador=form.elements['IDCOMPRADOR'].value;
	var estado='';

 	jQuery("#btnGuardarComprador").hide(); 

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Personal/BandejaTrabajo/CambiarCompradorAJAX.xsql',
		type:	"GET",
		data:	"IDMULTIOFERTA="+idMultioferta+"&IDNUEVOCOMPRADOR="+idComprador,
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
 		jQuery("#imgCompradorOK").show(); 
 		jQuery("#imgCompradorKO").hide(); 
	}
	else
	{
 		jQuery("#imgCompradorOK").hide(); 
 		jQuery("#imgCompradorKO").show(); 
	}

}


function GuardarGestor()
{
    var form=document.forms['Cabecera'];
    //form.elements['IDNUEVOCOMPRADOR'].value=form.elements['IDCOMPRADOR'].value;
    var idMultioferta = form.elements['MO_ID'].value;
	var idGestor=form.elements['IDGESTOR'].value;
	var estado='';

 	jQuery("#btnGuardarGestor").hide(); 

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Personal/BandejaTrabajo/CambiarGestorAJAX.xsql',
		type:	"GET",
		data:	"IDMULTIOFERTA="+idMultioferta+"&IDNUEVOGESTOR="+idGestor,
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
 		jQuery("#imgGestorOK").show(); 
 		jQuery("#imgGestorKO").hide(); 
	}
	else
	{
 		jQuery("#imgGestorOK").hide(); 
 		jQuery("#imgGestorKO").show(); 
	}
}


function GuardarVendedor()
{
    var form=document.forms['Cabecera'];
    //form.elements['IDNUEVOVendedor'].value=form.elements['IDVendedor'].value;
    var idMultioferta = form.elements['MO_ID'].value;
	var idVendedor=form.elements['IDVENDEDOR'].value;
	
	var porDefecto=(form.elements['cbTodos'].checked?'S':'N');
	
	var estado='';

 	jQuery("#spDatosVendedor").hide(); 
	
	//solodebug	alert('GuardarVendedor idVendedor:'+idVendedor+' Todos:'+porDefecto);

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Personal/BandejaTrabajo/CambiarVendedorAJAX.xsql',
		type:	"GET",
		data:	"IDMULTIOFERTA="+idMultioferta+"&IDNUEVOVENDEDOR="+idVendedor+"&PORDEFECTO="+porDefecto,
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
 		jQuery("#imgVendedorOK").show(); 
 		jQuery("#imgVendedorKO").hide(); 
	}
	else
	{
 		jQuery("#imgVendedorOK").hide(); 
 		jQuery("#imgVendedorKO").show(); 
	}
}


function CambioFormaPago()
{
	jQuery("#spFormaPago").show(); 
 	jQuery("#imgFormaPagoOK").hide(); 
 	jQuery("#imgFormaPagoKO").hide(); 
}

function GuardarFormaPago()
{
    var form=document.forms['Cabecera'];
    //form.elements['IDNUEVOVendedor'].value=form.elements['IDVendedor'].value;
    var idMultioferta = form.elements['MO_ID'].value;
	var idFormaPago=form.elements['IDFORMASPAGO'].value;
	var idPlazoPago=form.elements['IDPLAZOSPAGO'].value;
	var estado='';

 	jQuery("#spFormaPago").hide(); 
	
	//solodebug	alert('GuardarVendedor idVendedor:'+idVendedor+' Todos:'+porDefecto);

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Personal/BandejaTrabajo/CambiarFormaPagoAJAX.xsql',
		type:	"GET",
		data:	"IDMULTIOFERTA="+idMultioferta+"&IDFORMAPAGO="+idFormaPago+"&IDPLAZOPAGO="+idPlazoPago,
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
 		jQuery("#imgFormaPagoOK").show(); 
 		jQuery("#imgFormaPagoKO").hide(); 
	}
	else
	{
 		jQuery("#imgFormaPagoOK").hide(); 
 		jQuery("#imgFormaPagoKO").show(); 
	}

}

//	16nov17	Proceso de los mensajes parametrizados. Parametros: [MO_ID]
function MensajeParametrizado(IDMensaje)
{
    var form=document.forms['Cabecera'],
    	Parametros = form.elements['MO_ID'].value;

	//solodebug	alert('Mensaje parametrizado:'+IDMensaje+' Parametros:'+Parametros);

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Personal/BandejaTrabajo/EnviarMensajeParametrizadoAJAX.xsql',
		type:	"GET",
		data:	"IDMENSAJE="+IDMensaje+"&PARAMETROS="+encodeURIComponent(Parametros),
		contentType: "application/xhtml+xml",
		async:false,
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			
			estado=data.estado;
			
			if (estado=='OK')
				alert(document.forms['MensajeJS'].elements['MENSAJE_ENVIADO'].value);
			else
				alert(document.forms['MensajeJS'].elements['ERROR_ENVIANDO_MENSAJE'].value);

		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
			estado='ERROR';
		}
	});


}

//	20nov17 marca si el pedido tiene prepago
function marcarPrepago()
{

    var form=document.forms['Cabecera'],
		requierePrepago = form.elements['PED_REQUIEREPREPAGO'].value=='N'?'S':'N',
		fechaPrepago,
    	moID = form.elements['MO_ID'].value;
		

	//solodebug	alert('Mensaje parametrizado:'+IDMensaje+' Parametros:'+Parametros);

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Personal/BandejaTrabajo/MarcarPrepagoAJAX.xsql',
		type:	"GET",
		data:	"MO_ID="+moID+"&REQUIEREPREPAGO="+requierePrepago,
		contentType: "application/xhtml+xml",
		async:false,
		success: function(objeto){
			var data = eval("(" + objeto + ")");
			
			estado=data.estado;
			
			requierePrepago=Piece(estado,'|',1);
			fechaPrepago=Piece(estado,'|',2);
			
			Estado = (requierePrepago=='S')?'Si':'No';

			//solodebug	console.log('marcarPrepago. requierePrepago:'+requierePrepago+' fechaPrepago:'+fechaPrepago);
			
			if (fechaPrepago != '') Estado += ' ('+document.forms['MensajeJS'].elements['strPAGADO'].value+':'+fechaPrepago+')';
			
			if(estado != 'ERROR')
			{
				jQuery("#Prepago").text(Estado);
				form.elements['PED_REQUIEREPREPAGO'].value = requierePrepago;
				
 				jQuery("#imgPrepagoKO").hide(); 
			}
			else
			{
 				jQuery("#imgPrepagoKO").show(); 
			}


		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
			estado='ERROR';
		}
	});
}


//	Marca un pedido "recibido", vuelve a abrir la ficha de control
function PedidoRecibido()
{
	jQuery('#ACCION').val('PEDIDORECIBIDO');
	Enviar();
}


//	21feb22 Abre la pagina de mantenimiento de documentos
function VerTodosDocumentos(IDMultioferta)
{
	MostrarPagPersonalizada('http://www.newco.dev.br/Compras/Multioferta/MODocs2022.xsql?ORIGEN=CONTROL&amp;MO_ID='+IDMultioferta,'Documentos',100,80,0,0);
}


//	21feb22 Abre un documento
function VerDocumento(Url)
{
	MostrarPagPersonalizada('http://www.newco.dev.br/Documentos/'+Url,'Documento',100,80,0,0);
}

//	Vuelve a la pagina del pedido
function VerPedido(mo_id){
    MostrarPagPersonalizada('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame2022.xsql?MO_ID='+mo_id,'Multioferta',100,80,0,0);
}//fin verPedido


//	23feb22 Abre la ficha de empresa
function VerEmpresa(IDEmpresa)
{
	MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame2022.xsql?EMP_ID='+IDEmpresa,'Documentos',100,80,0,0);
}




