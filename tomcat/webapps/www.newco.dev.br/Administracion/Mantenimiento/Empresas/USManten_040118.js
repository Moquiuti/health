// JavaScript Document
//	Ultima revis�n: ET 4ene18 14:12

jQuery(document).ready(globalEvents);

function globalEvents(){

        jQuery("#opcionesAvanzadas").click (function() { if (document.getElementById('opcionesAvanzadasDiv').style.display == 'none'){
                                                                    jQuery('#opcionesAvanzadasDiv').show();
                                                                }
                                                                else  jQuery('#opcionesAvanzadasDiv').hide();
                                                        });

        jQuery("#US_CENTRALCOMPRAS").change(function() {
                                                        });


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

  //si clico que es administrador ser� tb cdc y empresa, desabilito eis semplificado mc 17-6-14
  if(document.forms[0].elements['US_USUARIOGERENTE'] && document.forms[0].elements['US_USUARIOGERENTE'].checked === true){
        document.forms[0].elements['US_CENTRALCOMPRAS'].checked = true;
        document.forms[0].elements['US_EIS_ACCESOGERENTE'].checked = true;
        document.forms[0].elements['US_EISSIMPLIFICADO'].checked = false;
        document.forms[0].elements['US_EISSIMPLIFICADO'].disabled = true;

        //28-10-14 si admin no puede ser observador ni bloq ocultos
        document.forms[0].elements['US_BLOQUEAROCULTOS'].checked = false;
        document.forms[0].elements['US_OBSERVADOR'].checked = false;
        document.forms[0].elements['US_BLOQUEAROCULTOS'].disabled = true;
        document.forms[0].elements['US_OBSERVADOR'].disabled = true;

        //28-10-14 si admin no ense�o derechos de compras de otros centros
        document.forms[0].elements['US_MULTICENTROS'].checked = false;
        jQuery("#derechosCompraOtrosCentros").hide();

        //28-10-14 si admin no ense�o derechos de compras de otros centros
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

   //si clico que es cdc, desabilito eis semplificado mc 17-6-14
  if(document.forms[0].elements['US_CENTRALCOMPRAS'] && document.forms[0].elements['US_CENTRALCOMPRAS'].checked === true){
        document.forms[0].elements['US_EIS_ACCESOGERENTE'].checked = true;
        document.forms[0].elements['US_EISSIMPLIFICADO'].checked = false;
        document.forms[0].elements['US_EISSIMPLIFICADO'].disabled = true;
        //28-10-14 si cdc no puede ser observador ni bloq ocultos
        document.forms[0].elements['US_BLOQUEAROCULTOS'].checked = false;
        document.forms[0].elements['US_OBSERVADOR'].checked = false;
        document.forms[0].elements['US_BLOQUEAROCULTOS'].disabled = true;
        document.forms[0].elements['US_OBSERVADOR'].disabled = true;

        //28-10-14 si admin no ense�o derechos de compras de otros centros
        document.forms[0].elements['US_MULTICENTROS'].checked = false;
        jQuery("#derechosCompraOtrosCentros").hide();

        //28-10-14 si admin no ense�o derechos de compras de otros centros
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

function privilegiosUsuarioOnload(){
  //si clico que es administrador ser� tb cdc y empresa, desabilito eis semplificado mc 17-6-14
  if(document.forms[0].elements['US_USUARIOGERENTE'] && document.forms[0].elements['US_USUARIOGERENTE'].checked === true){
		// DC - 19nov15 - No puedo cambiar valores al vuelo pq entonces no se como esta configurado el usuario
    //document.forms[0].elements['US_EIS_ACCESOGERENTE'].checked = true;
    //document.forms[0].elements['US_EISSIMPLIFICADO'].checked = false;
    document.forms[0].elements['US_EISSIMPLIFICADO'].disabled = true;

    //28-10-14 si admin no puede ser observador ni bloq ocultos
		// DC - 19nov15 - No puedo cambiar valores al vuelo pq entonces no se como esta configurado el usuario
    //document.forms[0].elements['US_BLOQUEAROCULTOS'].checked = false;
    //document.forms[0].elements['US_OBSERVADOR'].checked = false;
    document.forms[0].elements['US_BLOQUEAROCULTOS'].disabled = true;
    document.forms[0].elements['US_OBSERVADOR'].disabled = true;

    //28-10-14 si admin no ense�o derechos de compras de otros centros
		// DC - 19nov15 - No puedo cambiar valores al vuelo pq entonces no se como esta configurado el usuario
    //document.forms[0].elements['US_MULTICENTROS'].checked = false;
    jQuery("#derechosCompraOtrosCentros").hide();

		// DC - 19nov15 - No puedo cambiar valores al vuelo pq entonces no se como esta configurado el usuario
/*
    if (document.forms[0].elements['US_PLANTILLASNORMALES'] && document.forms[0].elements['US_PLANTILLASURGENCIAS']){
      //28-10-14 si admin no ense�o derechos de compras de otros centros
      document.forms[0].elements['US_PLANTILLASNORMALES'].checked = true;
      document.forms[0].elements['US_PLANTILLASURGENCIAS'].checked = true;
    }
*/
  }

	if(document.forms[0].elements['US_CENTRALCOMPRAS'] && document.forms[0].elements['US_CENTRALCOMPRAS'].checked === true){
		// DC - 19nov15 - No puedo cambiar valores al vuelo pq entonces no se como esta configurado el usuario
    //document.forms[0].elements['US_EIS_ACCESOGERENTE'].checked = true;
    //document.forms[0].elements['US_EISSIMPLIFICADO'].checked = false;
    document.forms[0].elements['US_EISSIMPLIFICADO'].disabled = true;

    //28-10-14 si admin no puede ser observador ni bloq ocultos
		// DC - 19nov15 - No puedo cambiar valores al vuelo pq entonces no se como esta configurado el usuario
    //document.forms[0].elements['US_BLOQUEAROCULTOS'].checked = false;
    //document.forms[0].elements['US_OBSERVADOR'].checked = false;
    document.forms[0].elements['US_BLOQUEAROCULTOS'].disabled = true;
    document.forms[0].elements['US_OBSERVADOR'].disabled = true;

    //28-10-14 si admin no ense�o derechos de compras de otros centros
		// DC - 19nov15 - No puedo cambiar valores al vuelo pq entonces no se como esta configurado el usuario
    //document.forms[0].elements['US_MULTICENTROS'].checked = false;
    jQuery("#derechosCompraOtrosCentros").hide();

		// DC - 19nov15 - No puedo cambiar valores al vuelo pq entonces no se como esta configurado el usuario
/*
    if (document.forms[0].elements['US_PLANTILLASNORMALES'] && document.forms[0].elements['US_PLANTILLASURGENCIAS']){
    	//28-10-14 si admin no ense�o derechos de compras de otros centros
      document.forms[0].elements['US_PLANTILLASNORMALES'].checked = true;
      document.forms[0].elements['US_PLANTILLASURGENCIAS'].checked = true;
    }
*/
  }
}//fin privilegiosUsuarioOnload creada nueva porqu� si no se perdian checkbox


//asignar perfil a usuario
function AsignarPerfilUsuario(perfil,us_id){
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
function CambioLogin(){
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
    else{
        if (login != loginOld){
		jQuery.ajax({
			url:"http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CambioLogin_ajax.xsql",
			data: "ID_USUARIO="+us_id+"&US_USUARIO="+login,
			type: "GET",
			contentType: "application/xhtml+xml",
			beforeSend:function(){

			},
			error:function(objeto, quepaso, otroobj){
				alert("objeto:"+objeto);
				alert("otroobj:"+otroobj);
				alert("quepaso:"+quepaso);
			},
			success:function(data){

				var doc=eval("(" + data + ")");
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

	//var enctype = 'application/x-www-form-urlencoded';
	//var action = 'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/USDerechosProductos.xsql';


	//form.encoding = enctype;
	//form.action = action;
	//form.target = target;

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
