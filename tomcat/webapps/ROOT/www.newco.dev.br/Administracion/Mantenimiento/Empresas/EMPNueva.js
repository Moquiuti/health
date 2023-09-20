jQuery.noConflict();

//----------------------------------------------------------

jQuery(document).ready(globalEvents);


function globalEvents(){
	
	//multioferta frame			  
	//jQuery("#mirta").click (function() { alert('mi'); });
	
}//fin de globalEvents

        
        function EnviaNuevaEmpresa(formu,accion){
        //alert('mi');
        //alert(validarFormulario(formu));
	  if (validarFormulario(formu))
	    {
         //alert('mi');
	    AsignarAccion(formu,accion);
	    SubmitForm(formu);
	    }
	}
	
	function validarFormulario(form){
		var regex_cpostal	= new RegExp("^[0-9\\-()]+$","g"); // Expresion regular para controlar el campo EMP_CPOSTAL que solo puede incluir números, guiones y parentesis (requisito MVMB)
		var regex_tlfn		= new RegExp("^[0-9\\-()]+$","g"); // Expresion regular para controlar el campo EMP_TELEFONO que solo puede incluir números, guiones y parentesis (requisito MVMB)
		var regex_fax		= new RegExp("^[0-9\\-()]+$","g"); // Expresion regular para controlar el campo EMP_FAX que solo puede incluir números, guiones y parentesis (requisito MVMB)
		//var regex_tlfn_fijo	= new RegExp("^[0-9\\-()]+$","g"); // Expresion regular para controlar el campo US_TF_FIJO que solo puede incluir números, guiones y parentesis (requisito MVMB)
		// PS 19oct16 
		var regex_tlfn_fijo	= new RegExp("^\+?\d{1,3}?[- .]?\(?(?:\d{2,3})\)?[- .]?\d\d\d[- .]?\d\d\d\d$");
		var errores=0;

		if((!errores) && (esNulo(document.forms[0].elements['EMP_NOMBRE'].value))){
			errores=1;
			alert(document.forms['MensajeJS'].elements['OBLI_NOMBRE_EMPRESA'].value);
			form.elements['EMP_NOMBRE'].focus();
			return false;
		}

		if((!errores) && (esNulo(document.forms[0].elements['EMP_NIF'].value))){
			errores=1;
			alert(document.forms['MensajeJS'].elements['OBLI_NIF'].value);
			form.elements['EMP_NIF'].focus();
			return false;
		}

		if((!errores) && (esNulo(document.forms[0].elements['EMP_DIRECCION'].value))){
			errores=1;
			alert(document.forms['MensajeJS'].elements['OBLI_DIRECCION'].value);
			form.elements['EMP_DIRECCION'].focus();
			return false;
		}

		if((!errores) && (esNulo(document.forms[0].elements['EMP_CPOSTAL'].value))){
			errores=1;
			alert(document.forms['MensajeJS'].elements['OBLI_COD_POSTAL'].value);
			form.elements['EMP_CPOSTAL'].focus();
			return false;
		}else{
			if(!checkRegEx(document.forms[0].elements['EMP_CPOSTAL'].value, regex_cpostal)){
				errores=1;
				alert(document.forms['MensajeJS'].elements['FORMATO_NUM_GUION_PARENT'].value);
				form.elements['EMP_CPOSTAL'].focus();
				return false;
			}
		}

		if((!errores) && (esNulo(document.forms[0].elements['EMP_POBLACION'].value))){
			errores=1;
			alert(document.forms['MensajeJS'].elements['OBLI_POBLACION'].value);
			form.elements['EMP_POBLACION'].focus();
			return false;
		}

		if((!errores) && (esNulo(document.forms[0].elements['EMP_TELEFONO'].value))){
			errores=1;
			alert(document.forms['MensajeJS'].elements['OBLI_TELEFONO'].value);
			form.elements['EMP_TELEFONO'].focus();
			return false;
		}else{
			if((!errores) && (!checkRegEx(document.forms[0].elements['EMP_TELEFONO'].value, regex_tlfn))){
				errores=1;
				alert(document.forms['MensajeJS'].elements['FORMATO_NUM_GUION_PARENT'].value);
				form.elements['EMP_TELEFONO'].focus();
				return false;
			}
		}

		if((!errores) && (!checkRegEx(document.forms[0].elements['EMP_FAX'].value, regex_fax)) && (!esNulo(document.forms[0].elements['EMP_FAX'].value))){
			errores=1;
			alert(document.forms['MensajeJS'].elements['FORMATO_NUM_GUION_PARENT'].value);
			form.elements['EMP_FAX'].focus();
			return false;
		}

		if((!errores) && (document.forms[0].elements['EMP_IDTIPO'].value<1)){
			errores=1;
			alert(document.forms['MensajeJS'].elements['OBLI_TIPO_EMPRESA'].value);
			form.elements['EMP_IDTIPO'].focus();
			return false;
		}
/*
		if((!errores) && (esNulo(document.forms[0].elements['EMP_ESPECIALIDAD'].value))){
			errores=1;
			alert('Por favor, rogamos seleccione la \"Especialidad de la empresa\" antes de enviar el formulario.');
			form.elements['EMP_ESPECIALIDAD'].focus();
			return false;
		}
*/
		if((!errores) && (document.forms[0].elements['EMP_PEDMINIMOACTIVO_CHECK'].checked==true || document.forms[0].elements['EMP_INTEGRADO_CHECK'].checked==true)){
			var queMensaje;
			if(document.forms[0].elements['EMP_PEDMINIMOACTIVO_CHECK'].checked==true){
				document.forms[0].elements['EMP_PEDMINIMOACTIVO'].value='S';
				queMensaje='MINIMO_ACTIVO';
				if(document.forms[0].elements['EMP_PEDMINIMOESTRICTO_CHECK'].checked==true)
					document.forms[0].elements['EMP_PEDMINIMOACTIVO'].value='E';
			}else{
				document.forms[0].elements['EMP_PEDMINIMOACTIVO'].value='I';
				queMensaje='INTEGRADO';
			}

			if(esNulo(document.forms[0].elements['EMP_PEDIDOMINIMO'].value)){
				errores=1;
				if(queMensaje=='MINIMO_ACTIVO'){
					alert(msgPedidoMinimoActivo);
				}else{
					alert(msgNoAceptarOfertas);
				}
				form.elements['EMP_PEDIDOMINIMO'].focus();
				return false;
			}else{
				document.forms[0].elements['EMP_PEDIDOMINIMO'].value=reemplazaComaPorPunto(document.forms[0].elements['EMP_PEDIDOMINIMO'].value);
			}
		}else{
			if((!errores) && (document.forms[0].elements['EMP_PEDMINIMOACTIVO_CHECK'].checked==false)){
				document.forms[0].elements['EMP_PEDMINIMOACTIVO'].value='';
			}
		}

		if((!errores) && (esNulo(document.forms[0].elements['DEP_NOMBRE'].value))){
			errores=1;
			alert(document.forms['MensajeJS'].elements['OBLI_DEPARTAMENTO'].value);
			form.elements['DEP_NOMBRE'].focus();
			return false;
		}

		if((!errores) && (esNulo(document.forms[0].elements['US_TITULO'].value))){
			errores=1;
			alert(document.forms['MensajeJS'].elements['OBLI_TITULO_USUARIO'].value);
			form.elements['US_TITULO'].focus();
			return false;
		}

		if((!errores) && (esNulo(document.forms[0].elements['US_NOMBRE'].value))){
			errores=1;
			alert(document.forms['MensajeJS'].elements['OBLI_NOMBRE_USUARIO'].value);
			form.elements['US_NOMBRE'].focus();
			return false;
		}

		if((!errores) && (esNulo(document.forms[0].elements['US_APELLIDO_1'].value))){
			errores=1;
			alert(document.forms['MensajeJS'].elements['OBLI_PRIMER_APELLIDO'].value);
			form.elements['US_APELLIDO_1'].focus();
			return false;
		}

		/*if((!errores) && (esNulo(document.forms[0].elements['US_APELLIDO_2'].value))){
			errores=1;
			alert('Por favor, rogamos rellene el campo \"2Âº Apellido\" antes de enviar el formulario.');
			form.elements['US_APELLIDO_2'].focus();
			return false;
		}*/

		if((!errores) && (esNulo(document.forms[0].elements['US_EMAIL'].value))){
			errores=1;
			alert(document.forms['MensajeJS'].elements['OBLI_EMAIL_USUARIO'].value);
			form.elements['US_EMAIL'].focus();
		}

		if((!errores) && (esNulo(document.forms[0].elements['US_TF_FIJO'].value))){
			errores=1;
			alert(document.forms['MensajeJS'].elements['OBLI_TEL_USUARIO'].value);
			form.elements['US_TF_FIJO'].focus();
			return false;
		}else{
			if((!errores) && (!checkRegEx(document.forms[0].elements['US_TF_FIJO'].value, regex_tlfn_fijo))){
				errores=1;
				alert(document.forms['MensajeJS'].elements['FORMATO_NUM_GUION_PARENT'].value);
				form.elements['US_TF_FIJO'].focus();
				return false;
			}
		}

		if((!errores) && (!checkNumber(document.forms[0].elements['EMP_COMISION_AHORRO'].value, document.forms[0].elements['EMP_COMISION_AHORRO']))){
			errores=1;
			form.elements['EMP_COMISION_AHORRO'].focus();
			return false;
		}else{
			if((!errores) && (esNulo(document.forms[0].elements['EMP_COMISION_AHORRO'].value))){
				errores=1;
				alert(document.forms['MensajeJS'].elements['OBLI_COMISION_AHORRO'].value);
				form.elements['EMP_COMISION_AHORRO'].focus();
				return false;
			}
		}

		if((!errores) && (!checkNumber(document.forms[0].elements['EMP_COMISION_TRANSACCIONES'].value, document.forms[0].elements['EMP_COMISION_TRANSACCIONES']))){
			errores=1;
			form.elements['EMP_COMISION_TRANSACCIONES'].focus();
			return false;
		}else{
			if((!errores) && (esNulo(document.forms[0].elements['EMP_COMISION_TRANSACCIONES'].value))){
				errores=1;
				alert(document.forms['MensajeJS'].elements['OBLI_COMISION_TRANSAC'].value);
				form.elements['EMP_COMISION_TRANSACCIONES'].focus();
				return false;
			}
		}

/*
		empresaCdC y Empresa Externa
*/

		if((!errores) && (document.forms[0].elements['EMP_SERVICIOSCDC_CHK'])){
			if(document.forms[0].elements['EMP_SERVICIOSCDC_CHK'].checked==true)
				document.forms[0].elements['EMP_SERVICIOSCDC'].value='on';
			else
				document.forms[0].elements['EMP_SERVICIOSCDC'].value='';
		}

		if((!errores) && (document.forms[0].elements['EMP_EXTERNA_CHK'])){
			if(document.forms[0].elements['EMP_EXTERNA_CHK'].checked==true)
				document.forms[0].elements['EMP_EXTERNA'].value='on';
			else
				document.forms[0].elements['EMP_EXTERNA'].value='';
		}

		if(!errores)
			return true;
		else
			return false;
	}


        function comprobarFormulario(formu){
          var obligatorios=['EMP_NOMBRE','EMP_NIF','EMP_DIRECCION','EMP_TELEFONO','EMP_IDTIPO','US_TITULO','EMP_CPOSTAL','EMP_POBLACION','DEP_NOMBRE','US_NOMBRE','US_APELLIDO_1','US_EMAIL','US_TF_FIJO'];	//EMP_ESPECIALIDAD',
          var numericos=['EMP_CPOSTAL','US_TF_FIJO','US_TF_MOVIL','EMP_TELEFONO','EMP_FAX'];
          var messError='';
          var Error = 0;
        
          for(i=0;i<formu.length;i++){
            // Campos obligatorios
            if((obligatorios.toString()).indexOf(formu.elements[i].name)!=-1){
              if(formu.elements[i].type=='select-one'){
                if(formu.elements[i].value<1 ||formu.elements[i].value=='NULL'){
                  Error=1;
              	  messError += document.forms['MensajeJS'].elements['OBLI_CAMPOS_OBLI'].value;
              	  formu.elements[i].focus();
              	  break;
              	}
              }
              else{
                if (formu.elements[i].value==''){
                  Error=1;
              	  messError += document.forms['MensajeJS'].elements['OBLI_CAMPOS_OBLI'].value;
              	  formu.elements[i].focus();
              	  break;
                }
              }
            }
           
            // Campos numericos
            if((numericos.toString()).indexOf(formu.elements[i].name)!=-1){
              if(!checkNumber(formu.elements[i].value,formu.elements[i])){
                Error=1;
                break;
              }
            }
         }
         if (messError != '') alert(messError);
           return Error;
       }
        
        function siempreCheckeado(obj){
          if(obj.checked==false)
            obj.checked=true;
        }
        
        function pedidoMinimo(nombre,form){
          if(nombre=="EMP_PEDMINIMOACTIVO_CHECK"){
            if(form.elements[nombre].checked==true){
              form.elements['EMP_PEDMINIMOESTRICTO_CHECK'].disabled=false;
              form.elements['EMP_PEDIDOMINIMO'].disabled=false;
              form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].disabled=false;
            }
            else{
              form.elements['EMP_PEDMINIMOESTRICTO_CHECK'].checked=false;
              form.elements['EMP_PEDMINIMOESTRICTO_CHECK'].disabled=true;
              
              form.elements['EMP_PEDIDOMINIMO'].value='';
              form.elements['EMP_PEDIDOMINIMO'].disabled=true;
              
              form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].value='';
              form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].disabled=true;
            }
          }
          else{
            if(nombre=="EMP_INTEGRADO_CHECK"){
              if(form.elements['EMP_INTEGRADO_CHECK'].checked==true){
                form.elements['EMP_PEDMINIMOACTIVO_CHECK'].checked=false;
                form.elements['EMP_PEDMINIMOACTIVO_CHECK'].disabled=true;
                form.elements['EMP_PEDMINIMOESTRICTO_CHECK'].checked=false;
                form.elements['EMP_PEDMINIMOESTRICTO_CHECK'].disabled=true;
                form.elements['EMP_PEDIDOMINIMO'].disabled=false;
                form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].disabled=false;
              }
              else{
                form.elements['EMP_PEDMINIMOACTIVO_CHECK'].disabled=false;
                form.elements['EMP_PEDMINIMOESTRICTO_CHECK'].disabled=true;
                form.elements['EMP_PEDIDOMINIMO'].value='';
                form.elements['EMP_PEDIDOMINIMO'].disabled=true;
                
                form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].value='';
                form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].disabled=true;
              }
            }
          }
        }