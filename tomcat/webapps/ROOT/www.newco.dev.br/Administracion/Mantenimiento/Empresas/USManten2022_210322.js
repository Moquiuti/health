//	JS Mantenimiento de Usuarios
//	Ultima revisión: ET 24mar22 09:55 USManten2022_210322.js


jQuery(document).ready(globalEvents);

function globalEvents(){

    jQuery("#opcionesAvanzadas").click (function() 
	{ 
		if (document.getElementById('opcionesAvanzadasDiv').style.display == 'none')
		{
			jQuery('#opcionesAvanzadasDiv').show();
        }
        else  jQuery('#opcionesAvanzadasDiv').hide();
	});
/*
    jQuery("#US_CENTRALCOMPRAS").change(function() 
	{
    });
*/

}//fin de globalEvents


//	27nov17	Recarga los desplegables del margen izquierdo con la empresa actual si esta ha sido modificada
function recargaDesplegables()
{
	//solodebug	console.log (document.forms['frmDPManten'].elements['ACTUALIZADO'].value);
	
	if ((document.forms['frmDPManten'].elements['ACTUALIZADO'].value=='S')&&(parent.zonaEmpresa))
	{
		//solodebug	console.log('recargaDesplegables -> CambioCentro: IDEMpresa:'+document.forms[0].elements['EMP_ID'].value+' IDCEntro:'+document.forms[0].elements['CEN_ID'].value);
		
		parent.zonaEmpresa.CambioCentroActual(document.forms[0].elements['EMP_ID'].value, document.forms[0].elements['CEN_ID'].value);
	}
}



function privilegiosUsuario()
{
	var esAdministrador;

  //si clico que es administrador será tb cdc y empresa, desabilito eis semplificado mc 17-6-14
  if(document.forms[0].elements['US_USUARIOGERENTE'] && document.forms[0].elements['US_USUARIOGERENTE'].checked === true){
        document.forms[0].elements['US_CENTRALCOMPRAS'].checked = true;
        document.forms[0].elements['US_EIS_ACCESOGERENTE'].checked = true;
        document.forms[0].elements['US_EISSIMPLIFICADO'].checked = false;
        document.forms[0].elements['US_EISSIMPLIFICADO'].disabled = true;

        // si admin no puede ser observador ni bloq ocultos
        document.forms[0].elements['US_BLOQUEAROCULTOS'].checked = false;
        document.forms[0].elements['US_OBSERVADOR'].checked = false;
        document.forms[0].elements['US_BLOQUEAROCULTOS'].disabled = true;
        document.forms[0].elements['US_OBSERVADOR'].disabled = true;

        // si admin no enseño derechos de compras de otros centros
        document.forms[0].elements['US_MULTICENTROS'].checked = false;
        jQuery("#derechosCompraOtrosCentros").hide();

        // si admin no enseño derechos de compras de otros centros
        document.forms[0].elements['US_PLANTILLASNORMALES'].checked = true;
        document.forms[0].elements['US_PLANTILLASURGENCIAS'].checked = true;

    }
  else if(document.forms[0].elements['US_USUARIOGERENTE'] && document.forms[0].elements['US_USUARIOGERENTE'].checked === false){
        document.forms[0].elements['US_EIS_ACCESOGERENTE'].checked = false;
        document.forms[0].elements['US_EISSIMPLIFICADO'].disabled = false;

        //si sigue estando clicada cdc
        if(document.forms[0].elements['US_CENTRALCOMPRAS'].checked === true){
            document.forms[0].elements['US_BLOQUEAROCULTOS'].checked = false;
            document.forms[0].elements['US_OBSERVADOR'].checked = false;
            document.forms[0].elements['US_BLOQUEAROCULTOS'].disabled = true;
            document.forms[0].elements['US_OBSERVADOR'].disabled = true;
        }
        else{
            document.forms[0].elements['US_BLOQUEAROCULTOS'].checked = false;
            document.forms[0].elements['US_OBSERVADOR'].checked = false;
            document.forms[0].elements['US_BLOQUEAROCULTOS'].disabled = false;
            document.forms[0].elements['US_OBSERVADOR'].disabled = false;

        }
        document.forms[0].elements['US_PLANTILLASNORMALES'].checked = false;
        document.forms[0].elements['US_PLANTILLASURGENCIAS'].checked = false;

    }

   //CDC -> desmarcar eis semplificado
  if(document.forms[0].elements['US_CENTRALCOMPRAS'] && document.forms[0].elements['US_CENTRALCOMPRAS'].checked === true){
        document.forms[0].elements['US_EIS_ACCESOGERENTE'].checked = true;
        document.forms[0].elements['US_EISSIMPLIFICADO'].checked = false;
        document.forms[0].elements['US_EISSIMPLIFICADO'].disabled = true;
        // si cdc no puede ser observador ni bloq ocultos
        document.forms[0].elements['US_BLOQUEAROCULTOS'].checked = false;
        document.forms[0].elements['US_OBSERVADOR'].checked = false;
        document.forms[0].elements['US_BLOQUEAROCULTOS'].disabled = true;
        document.forms[0].elements['US_OBSERVADOR'].disabled = true;

        // si admin no enseño derechos de compras de otros centros
        document.forms[0].elements['US_MULTICENTROS'].checked = false;
        jQuery("#derechosCompraOtrosCentros").hide();

        // si admin no enseño derechos de compras de otros centros
        document.forms[0].elements['US_PLANTILLASNORMALES'].checked = true;
        document.forms[0].elements['US_PLANTILLASURGENCIAS'].checked = true;

    }
  else if(document.forms[0].elements['US_CENTRALCOMPRAS'] && document.forms[0].elements['US_CENTRALCOMPRAS'].checked === false){
         document.forms[0].elements['US_EIS_ACCESOGERENTE'].checked = false;
        document.forms[0].elements['US_EISSIMPLIFICADO'].disabled = false;

        document.forms[0].elements['US_BLOQUEAROCULTOS'].checked = false;
        document.forms[0].elements['US_OBSERVADOR'].checked = false;
        document.forms[0].elements['US_BLOQUEAROCULTOS'].disabled = false;
        document.forms[0].elements['US_OBSERVADOR'].disabled = false;

        document.forms[0].elements['US_PLANTILLASNORMALES'].checked = false;
        document.forms[0].elements['US_PLANTILLASURGENCIAS'].checked = false;
    }

}//fin privilegiosUsuario

function privilegiosUsuarioOnload()
{
	//si clico que es administrador será tb cdc y empresa, desabilito eis semplificado mc 17-6-14
	if(document.forms[0].elements['US_USUARIOGERENTE'] && document.forms[0].elements['US_USUARIOGERENTE'].checked === true)
	{
		document.forms[0].elements['US_EISSIMPLIFICADO'].disabled = true;
		document.forms[0].elements['US_BLOQUEAROCULTOS'].disabled = true;
		document.forms[0].elements['US_OBSERVADOR'].disabled = true;
		jQuery("#derechosCompraOtrosCentros").hide();
	}

	if(document.forms[0].elements['US_CENTRALCOMPRAS'] && document.forms[0].elements['US_CENTRALCOMPRAS'].checked === true)
	{
    	document.forms[0].elements['US_EISSIMPLIFICADO'].disabled = true;
    	document.forms[0].elements['US_BLOQUEAROCULTOS'].disabled = true;
    	document.forms[0].elements['US_OBSERVADOR'].disabled = true;
    	jQuery("#derechosCompraOtrosCentros").hide();
	}
}//fin privilegiosUsuarioOnload creada nueva porqué si no se perdian checkbox


//asignar perfil a usuario
function AsignarPerfilUsuario(perfil,us_id)
{
	var form = document.forms[0];
	var target = '_top';
	var enctype = 'application/x-www-form-urlencoded';
	var action = 'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/USAsignarPerfil.xsql';

	var perfilTipo = perfil.split('-');
	var tipo = perfilTipo[0];

	form.encoding = enctype;
	form.action = action;
	form.target = target;

	jQuery.ajax({
		url:"http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/USAsignarPerfil.xsql",
		data: "ID_USU="+us_id+"&PERFIL="+perfil,
		type: "GET",
		contentType: "application/xhtml+xml",
		beforeSend:function(){
			//jQuery('.boton').style.display = 'none';
			document.getElementById('confirmBoxUsuario').style.display = 'none';
			document.getElementById('waitBoxUsuario').style.display = 'block';
			document.getElementById('waitBoxUsuario').html = 'http://www.newco.dev.br/images/loading.gif';

		},
		error:function(objeto, quepaso, otroobj){
			alert("objeto:"+objeto);
			alert("otroobj:"+otroobj);
			alert("quepaso:"+quepaso);
		},
		success:function(data){

			var doc=eval("(" + data + ")");

			if (data.match('error')){
				var dataOne = data.split('error');
				var dataTwo = dataOne[1].split('}');
				var dataThree = dataTwo[0].split(':');
				var error = dataThree[1];
				//alert(error);
				jQuery('#confirmBoxUsuario').text(error);
			}
			if (data.match('OK')){
				 jQuery('#confirmBoxUsuario').html(document.forms['MensajeJS'].elements['PERFIL_USUARIO_CAMBIADO'].value);
				}

			jQuery('#waitBoxUsuario').hide();
			jQuery('#confirmBoxUsuario').css("color", "#FF0000");
			jQuery('#confirmBoxUsuario').css("font-weight", "bold");
			jQuery('#confirmBoxUsuario').show();

            location.reload();


		}
	});


}

//copiar derechos usuario
function CopiarDerechos(tipo){
        var form = document.forms[0];
        var target = '_top';
	var enctype = 'application/x-www-form-urlencoded';
	var action = 'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/USCopiarDerechos.xsql';

        if (tipo == 'COPIARDERECHOS'){
            action='COPIARDERECHOS';
        }
        if (tipo == 'COPIARMENUS'){
            action='COPIARMENUS';
        }
        if (tipo == 'COPIARPLANTILLAS'){
            action='COPIARPLANTILLAS';
        }

        var parametros=document.forms[0].elements["US_COPIA_ORIGEN"].value
		+'|'+document.forms[0].elements["US_COPIA_DESTINO"].value;


	form.encoding = enctype;
	form.action = action;
	form.target = target;

	jQuery.ajax({
		url:"http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/USCopiarDerechos.xsql",
		data: "ACCION="+action+"&PARAMETROS="+parametros,
		type: "GET",
		contentType: "application/xhtml+xml",
		beforeSend:function(){
			//jQuery('.boton').style.display = 'none';
			document.getElementById('confirmBoxCopiarDer').style.display = 'none';
			document.getElementById('waitBoxCopiarDer').style.display = 'block';
			document.getElementById('waitBoxCopiarDer').html = 'http://www.newco.dev.br/images/loading.gif';

		},
		error:function(objeto, quepaso, otroobj){
			alert("objeto:"+objeto);
			alert("otroobj:"+otroobj);
			alert("quepaso:"+quepaso);
		},
		success:function(data){

			var doc=eval("(" + data + ")");

			//alert('data '+doc.USCopiarDerechos.estado);

             jQuery('#confirmBoxCopiarDer').html(doc.USCopiarDerechos.estado);

			jQuery('#waitBoxCopiarDer').hide();
			jQuery('#confirmBoxCopiarDer').css("color", "green");
			jQuery('#confirmBoxCopiarDer').css("font-weight", "bold");
			jQuery('#confirmBoxCopiarDer').show();

        location.reload();

		}
	});

}

//enviar Destacados a un usuario
function enviarDestacados(usuario){

	var form = document.forms[0];
	//alert(form.name);
	var target = '_top';
	var enctype = 'application/x-www-form-urlencoded';
	var action = 'http://' + location.hostname + '/confirmEnvioDestacados.xsql';

	form.encoding = enctype;
	form.action = action;
	form.target = target;

	var usuarioEnvio = document.forms[0].elements['ID_USUARIO'].value;


	jQuery.ajax({
		url:"confirmEnvioDestacados.xsql",
		data: "US_ENVIA="+usuarioEnvio+"&US_DESTINO="+usuario,
		type: "GET",
		contentType: "application/xhtml+xml",
		beforeSend:function(){
			document.getElementById('botonEnviaDesta').style.display = 'none';
			document.getElementById('confirmBox').style.display = 'none';
			document.getElementById('waitBox').style.display = 'block';
			document.getElementById('waitBox').src = 'http://www.newco.dev.br/images/loading.gif';

		},
		error:function(objeto, quepaso, otroobj){
			alert("objeto:"+objeto);
			alert("otroobj:"+otroobj);
			alert("quepaso:"+quepaso);
		},
		success:function(data){

			var doc=eval("(" + data + ")");

			if (data.match('error')){
				var dataOne = data.split('error');
				var dataTwo = dataOne[1].split('}');
				var dataThree = dataTwo[0].split(':');
				var error = dataThree[1];
				//alert(error);
				jQuery('#confirmBox').text(error);
			}
			if (data.match('ok')){
				 jQuery('#confirmBox').text(document.forms['MensajeJS'].elements['DESTACADO_ENVIADO_EXITO'].value);
				}
			jQuery('#waitBox').hide();
			jQuery('#confirmBox').css("color", "green");
			jQuery('#confirmBox').css("font-weight", "bold");
			jQuery('#confirmBox').show();


		}
	});
}//fin de enviar destacados


//asignar perfil a usuario
function CambioLogin()
{
	var form = document.forms[0];
	var target = '_top';
	var enctype = 'application/x-www-form-urlencoded';
	var action = 'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CambioLogin_ajax.xsql';

	var us_id = form.elements['ID_USUARIO'].value;
	var login = form.elements['US_USUARIO'].value;
	var loginOld = form.elements['US_USUARIO_OLD'].value;

	form.encoding = enctype;
	form.action = action;
	form.target = target;

    //alert(login);
    if (login == ''){ alert(document.forms['MensajeJS'].elements['US_USUARIO_OBLI'].value); }
    else
	{
        if (login != loginOld)
		{
			jQuery.ajax
			({
				url:"http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CambioLogin_ajax.xsql",
				data: "ID_USUARIO="+us_id+"&US_USUARIO="+login,
				type: "GET",
				contentType: "application/xhtml+xml",
				error:function(objeto, quepaso, otroobj){
					alert("objeto:"+objeto);
					alert("otroobj:"+otroobj);
					alert("quepaso:"+quepaso);
				},
				success:function(data){

					//18oct21	var doc=eval("(" + data + ")");
					var doc=JSON.parse(data);
					if (doc.Estado == 'OK'){
                    	alert(document.forms['MensajeJS'].elements['US_USUARIO_CAMBIADO'].value);
                	}
                	else if(doc.Estado == 'ERROR'){
                    	alert(document.forms['MensajeJS'].elements['US_USUARIO_ERROR'].value);
                	}

                	location.reload();
				}
			});

	    }
	}
}


//	16oct21Fuerza el cambio de clave para un usuario
function CambioClave()
{
	jQuery.ajax
	({
		url:"http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CambioClaveAjax.xsql",
		data: "ID_USUARIO="+ document.forms[0].elements['ID_USUARIO'].value,
		type: "GET",
		contentType: "application/xhtml+xml",
		error:function(objeto, quepaso, otroobj){
			alert("objeto:"+objeto);
			alert("otroobj:"+otroobj);
			alert("quepaso:"+quepaso);
		},
		success:function(data){
			var doc=JSON.parse(data);
			if (doc.Estado == 'OK'){
                alert(document.forms['MensajeJS'].elements['US_CLAVE_CAMBIADA'].value);
            }
            else if(doc.Estado == 'ERROR'){
                alert(document.forms['MensajeJS'].elements['US_CLAVE_ERROR'].value);
            }
		}
	});

}


//cambio clave encriptada
function CambioClaveEncript(){
    if (jQuery("#claveEncript").is(':visible')){
        jQuery("#claveEncript").hide();
        jQuery("#US_CLAVE_MD5").show();
    }
    else{
        jQuery("#claveEncript").show();
        jQuery("#US_CLAVE_MD5").hide();
    }


}


//4ene18 Asigna derechos sobre productos/plantillas
function DerechosProductos(Accion)
{
	var form = document.forms[0];
	var target = '_top';
	var IDUsuario = form.elements['ID_USUARIO'].value;

	jQuery.ajax({
		url:"http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/USDerechosProductos.xsql",
		data: "ACCION="+Accion+"&PARAMETROS="+IDUsuario,
		type: "GET",
		contentType: "application/xhtml+xml",
		beforeSend:function(){
			//jQuery('.boton').style.display = 'none';
			document.getElementById('confirmBoxDerProductos').style.display = 'none';
			document.getElementById('waitBoxDerProductos').style.display = 'block';
			document.getElementById('waitBoxDerProductos').html = 'http://www.newco.dev.br/images/loading.gif';

		},
		error:function(objeto, quepaso, otroobj){
			alert("objeto:"+objeto);
			alert("otroobj:"+otroobj);
			alert("quepaso:"+quepaso);
		},
		success:function(data){

			var doc=eval("(" + data + ")");

			//alert('data '+doc.USCopiarDerechos.estado);

            jQuery('#confirmBoxDerProductos').html(doc.USCopiarDerechos.estado);

			jQuery('#waitBoxDerProductos').hide();
			jQuery('#confirmBoxDerProductos').css("color", "green");
			jQuery('#confirmBoxDerProductos').css("font-weight", "bold");
			jQuery('#confirmBoxDerProductos').show();

        	location.reload();

		}
	});

}



function comprobarDepartamentosDelUsuario(form){
  var algunoInformado=0;
  for(var n=0;n<form.length;n++){
    if(form.elements[n].name.substring(0,5)=='DEPT_'){
      if(form.elements[n].checked==true){
        algunoInformado++;
      }
    }
  }

  return algunoInformado;
}


function privilegiosCarpetas(obj){
  var esAdministrador;


  if(document.forms[0].elements['US_USUARIOGERENTE'].value=='on' || document.forms[0].elements['US_GERENTECENTRO'].value=='on')
    esAdministrador=1;

  if(esAdministrador){
    obj.checked=!obj.checked;
  }
}


function DerechosCARPyPL(propietario, usuario){

  var opciones='?ID_PROPIETARIO='+ propietario +'&ID_USUARIO='+ usuario;

  if(usuario>0){
    MostrarPag('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CARPyPLManten.xsql'+opciones,'carpYpl');
  }
  else{
    alert(msgSinUsuarioParaCarpYPl);
  }
}


function DerechosMenus(usuario, empresa){
  var opciones='?EMP_ID='+ empresa +'&ID_USUARIO=' + usuario;

  if(usuario>0){
    MostrarPag('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/MenusManten.xsql'+opciones,'MenusManten');
  }
  else{
    alert(msgSinUsuarioParaMenus);
  }
}

function ValidaySubmit(formu){
  var id;
  var cadenaCambios='';
  var visualizable;
  var pertenece;
  var cabecera;

  formu.action = 'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/USManten2022.xsql';
  formu.type = 'post';
  formu.target = '';

  if(validarFormulario(formu)){
    for(var i=0;i<formu.length;i++){
      if(formu.elements[i].name.substring(0,5)=='MENU_'){
        id=obtenerId(formu.elements[i].name);
        if(formu.elements[i].checked==true)
          visualizable=1;
        else
          visualizable=0;

       if(formu.elements['CABECERA_'+id].checked==true)
          cabecera='S';
        else
          cabecera='N';

        cadenaCambios+=id+'|'+visualizable+'|'+cabecera+'#';
      }
    }
    formu.elements['CAMBIOS_MENUS'].value=cadenaCambios;


    //montamos la cadena de los departamentos
    cadenaCambios='';

    for(var i=0;i<formu.length;i++){
      if(formu.elements[i].name.substring(0,5)=='DEPT_'){
        id=obtenerId(formu.elements[i].name);

        if(formu.elements[i].checked==true)
          pertenece=1;
        else
          pertenece=0;

        cadenaCambios+=id+'|'+pertenece+'#';
      }
    }
    formu.elements['CAMBIOS_DEPTS'].value=cadenaCambios;


    //         montamos la cadena de los centros autorizados
    cadenaCambios='';

    for(var i=0;i<formu.length;i++)
	{
      if(formu.elements[i].name.substring(0,17)=='CENTROAUTORIZADO_')
	  {
        id=Piece(formu.elements[i].name,'_',1);
        if(formu.elements[i].checked==true)	cadenaCambios+=id+'#'+formu.elements['LUGARENTREGA_'+id].value+'|';
      }
    }

    formu.elements['US_CENTROSAUTORIZADOS'].value=cadenaCambios;

    if (formu.elements['US_NAVEGARPROVEEDORES'] && formu.elements['US_NAVEGARPROVEEDORES'].value =='on') {
        formu.elements['US_NAVEGARPROVEEDORES'].value = 'S';
    }

    /*if (formu.elements['US_PLANTILLASNORMALES']){
        alert('pl-norm '+formu.elements['US_PLANTILLASNORMALES'].value);
        alert('pl urgen '+formu.elements['US_PLANTILLASURGENCIAS'].value);
    }*/

    if (formu.elements['TIENEPEDIDOS'].value == 'S' && ( (formu.elements['US_NOMBRE_OLD'].value != formu.elements['US_NOMBRE'].value) || (formu.elements['US_APELLIDO1_OLD'].value != formu.elements['US_APELLIDO1'].value) || (formu.elements['US_APELLIDO2_OLD'].value != formu.elements['US_APELLIDO2'].value) )){
        var formJS = document.forms['MensajeJS'];
        var AvisoTienePedidos = formJS.elements['TIENE_PEDIDOS_AVISO'].value;
        alert(formu.elements['US_NOMBRE'].value + formu.elements['US_APELLIDO1'].value + AvisoTienePedidos);
	}
    jQuery(".boton").hide(); //cuando envio formulario que ok escondo botones
	
	SubmitForm(formu);
  }
}


function validarFormulario(form)
{
	var regex_car_raros     = /([\#|\\|\'|\|])+/g; //caracteres raros que no queremos en los campos de texto (requisito MVM)
	var regex_car_usuario   = new RegExp("^[0-9a-zA-Z]+$","g"); //caracteres raros que no queremos en los campos login y usuario (requisito MVM-brasil)
	var regex_car_clave     = new RegExp("^[0-9a-zA-Z]+$","g");
	var regex_car_clave_rep = new RegExp("^[0-9a-zA-Z]+$","g");
	var regex_numeros       = new RegExp("^[0-9]+$","g");
	var errores=0;
	var raros=0;

  if((!errores) && (document.forms[0].elements['US_TITULO'].value==-1)){
    errores=1;
    alert(document.forms['MensajeJS'].elements['OBLI_TITULO_USUARIO'].value);
    form.elements['US_TITULO'].focus();
    return false;
  }

  if((!errores) && (esNulo(document.forms[0].elements['US_NOMBRE'].value))){
    errores=1;
    alert(document.forms['MensajeJS'].elements['OBLI_NOMBRE_EMPRESA'].value);
    form.elements['US_NOMBRE'].focus();
    return false;
  }

      if((!errores) && (esNulo(document.forms[0].elements['US_APELLIDO1'].value))){
    errores=1;
    alert(document.forms['MensajeJS'].elements['OBLI_PRIMER_APELLIDO'].value);
    form.elements['US_APELLIDO1'].focus();
    return false;
  }

       //control que no pongan caracteres raros en los textos
       if(document.forms[0].elements['US_CP_NOMBRE'] && document.forms[0].elements['US_CP_ID']){
            var inputText = [document.forms[0].elements['US_NOMBRE'].value,document.forms[0].elements['US_APELLIDO1'].value, document.forms[0].elements['US_APELLIDO2'].value, document.forms[0].elements['US_CP_NOMBRE'].value,document.forms[0].elements['US_CP_ID'].value,document.forms[0].elements['US_EMAIL'].value,document.forms[0].elements['US_EMAIL2'].value];
        }
        else{
            var inputText = [document.forms[0].elements['US_NOMBRE'].value,document.forms[0].elements['US_APELLIDO1'].value, document.forms[0].elements['US_APELLIDO2'].value,document.forms[0].elements['US_EMAIL'].value,document.forms[0].elements['US_EMAIL2'].value];
        }

        for (var i=0;i<inputText.length;i++){
            if(checkRegEx(inputText[i], regex_car_raros)){
                //si true implica que si ha encontrado caracteres raros
                errores=1;
                raros=1;
            }
            else { }
        }//fin for caracteres raros

        if (raros =='1') alert(document.forms['MensajeJS'].elements['CAR_RAROS'].value);


   //control caracteres raros en user y password
        if((!errores) && (!checkRegEx(document.forms[0].elements['US_USUARIO'].value, regex_car_usuario))){
            errores=1;
            alert(document.forms['MensajeJS'].elements['CAR_RAROS_USUARIO'].value);
            form.elements['US_USUARIO'].focus();
            return false;
        }

        if((!errores) && (document.forms[0].elements['US_CLAVE'].value != '') && (!checkRegEx(document.forms[0].elements['US_CLAVE'].value, regex_car_clave))){
            errores=1;
            alert(document.forms['MensajeJS'].elements['CAR_RAROS_USUARIO'].value);
            form.elements['US_CLAVE'].focus();
            return false;
        }
        if((!errores) && (document.forms[0].elements['US_CLAVE_REP'].value != '') && (!checkRegEx(document.forms[0].elements['US_CLAVE_REP'].value, regex_car_clave_rep))){
            errores=1;
            alert(document.forms['MensajeJS'].elements['CAR_RAROS_USUARIO'].value);
            form.elements['US_CLAVE_REP'].focus();
            return false;
        }

  /*if((!errores) && (esNulo(document.forms[0].elements['US_APELLIDO2'].value))){
    errores=1;
    alert(document.forms['MensajeJS'].elements['OBLI_SEGUNDO_APELLIDO'].value);
    form.elements['US_APELLIDO2'].focus();
    return false;
  }*/

  /*quitado 16-12-14 para brasil, si no no se podian guardar num tel con -
        if((!errores) && (!checkNumber(document.forms[0].elements['US_TF_FIJO'].value, document.forms[0].elements['US_TF_FIJO']))){
    errores=1;
    form.elements['US_TF_FIJO'].focus();
    return false;
  }
  else{}
    if((!errores) && (esNulo(document.forms[0].elements['US_TF_FIJO'].value))){
    errores=1;
    alert(document.forms['MensajeJS'].elements['OBLI_TELEFONO'].value);
    form.elements['US_TF_FIJO'].focus();
    return false;
  }*/

	//	Para nuevos usuarios , revuisar el campo US_USUARIO
    if((!errores)&& (document.forms[0].elements['ID_USUARIO'].value=='0')&&(esNulo(document.forms[0].elements['US_USUARIO'].value)|| esNulo(document.forms[0].elements['US_USUARIO'].value)))
	{
        errores=1;
        alert(document.forms['MensajeJS'].elements['OBLI_LOGIN'].value);
        form.elements['US_USUARIO'].focus();
        return false;
	}

  if((!errores) && (document.forms[0].elements['ID_USUARIO'].value=='0')&&(document.forms[0].elements['US_CLAVE'].value!=document.forms[0].elements['US_CLAVE_REP'].value ))
  {
    errores=1;
    alert(document.forms['MensajeJS'].elements['OBLI_PASSWORD'].value);
    form.elements['US_CLAVE'].value='';
    form.elements['US_CLAVE_REP'].value='';
    form.elements['US_CLAVE'].focus();
    return false;
  }

  if((!errores)&& (!comprobarDepartamentosDelUsuario(document.forms[0]))){
    alert(document.forms['MensajeJS'].elements['OBLI_SEL_DEPARTAMENTOS'].value);
    document.location.href='#dept';
    return false;
  }
       //control que sea númerico importe sin supervisor

        var importeSinSup = document.forms[0].elements['US_IMPORTESINSUPERVISION'].value;
        if((!errores) && (!checkNumber( importeSinSup.replace('.','') ))){
            errores=1;
            alert(document.forms['MensajeJS'].elements['IMPORTESINSUPERVISION_ERROR'].value);
            form.elements['US_IMPORTESINSUPERVISION'].focus();
            return false;
        }
        document.forms[0].elements['US_IMPORTESINSUPERVISION'].value = importeSinSup.replace('.','');
        //alert('replace . nada '+document.forms[0].elements['US_IMPORTESINSUPERVISION'].value);
        if (document.forms[0].elements['US_IMPORTESINSUPERVISION'].value.match(',')){
            var importeComa= document.forms[0].elements['US_IMPORTESINSUPERVISION'].value;
            document.forms[0].elements['US_IMPORTESINSUPERVISION'].value = importeComa.replace(',','.');
            //alert('replace 2 , . '+document.forms[0].elements['US_IMPORTESINSUPERVISION'].value);
            }

      if(!errores)
        return true;
      else
        return false;

}

		
		
/*        	function MostrarDatos(){
  MostrarPagPassord('USDatos.xsql?ID_USUARIO=]]></xsl:text><xsl:value-of select="/Mantenimiento/form/Lista/USUARIO/ID_USUARIO"/><xsl:text disable-output-escaping="yes"><![CDATA[','Password');
}
*/

function MostrarPagPassord(pag,titulo){


	if(titulo==null)
	var titulo='MedicalVM';


	if (is_nav){

		var ample = 300;
		var alcada = 100;

		var esquerra = (top.screen.availWidth-ample) / 2;
		var alt = (top.screen.availHeight-alcada) / 2;

		if (ventana && ventana.open){
		  ventana.close();
		}
		titulo=window.open(pag,titulo,'toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',screenX='+esquerra+',screenY='+alt);
		titulo.focus();

		}else{
		  var ample = 300;
		  var alcada = 100;

		  var esquerra = (top.screen.availWidth-ample) / 2;
		  var alt = (top.screen.availHeight-alcada) / 2;

		if (ventana &&  ventana.open && !ventana.closed){
    		 ventana.close();
		}
		titulo=window.open(pag,titulo,'toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',top='+alt+',left='+esquerra);
		titulo.focus();
	}
}

//	Al seleccionar multicentros, activa o desactiva los checkboxes de centros
function Multicentros()
{
	if (document.forms[0].elements['US_MULTICENTROS'].checked==true)
	{
    	for(var i=0;i<document.forms[0].length;i++)
		{
    	  if(document.forms[0].elements[i].name.substring(0,17)=='CENTROAUTORIZADO_')
		  {
        	document.forms[0].elements[i].disabled=false;
    	  }
    	}
	}
	else
	{
    	for(var i=0;i<document.forms[0].length;i++)
		{
    	  if(document.forms[0].elements[i].name.substring(0,17)=='CENTROAUTORIZADO_')
		  {
        	document.forms[0].elements[i].disabled=true;
    	  }
    	}
	}
}


//si eligo seleccionar en el perfil vuelvo a poner boton de personalizacion de derechos
function VerPersonalizacion(){
	var perfil = jQuery('#US_IDPERFIL').val();
	if(perfil == ''){
    	jQuery("#botonPersonalizacion").show();
	}
}
