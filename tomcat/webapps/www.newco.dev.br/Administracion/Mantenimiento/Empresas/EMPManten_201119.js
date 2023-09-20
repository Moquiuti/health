//	JS mantenimiento empresa
//	Ultima revision: ET 6nov19 10:53  EMPManten_201119.js

jQuery(document).ready(globalEvents);

function globalEvents(){
	// 07may2013 -- DC -- Checkbox "Precios con IVA" solo editable si el "Nuevo modelo de negocio" no está activo.
	jQuery("#OcultarPrecioRef_Chk").click(function(){
		if(jQuery('#OcultarPrecioRef_Chk').is(':checked')){
			jQuery("#PreciosConIVA_Chk").attr("disabled", true);
                }else{
			jQuery("#PreciosConIVA_Chk").removeAttr("disabled");
                }
	});

	jQuery("#verCargaLogo").click(function(){
		if(jQuery('#cargaLogo').is(':visible')){
			jQuery('#cargaLogo').hide();
		}
		if(jQuery('#cargaLogo').is(':hidden')){
			jQuery('#cargaLogo').show();
		}
	});

	// Recupero bien los saltos de linea de los textboxes
	if(jQuery('textarea[name="EMP_REFERENCIAS"]').length > 0)
		jQuery('textarea[name=EMP_REFERENCIAS]').val(jQuery('textarea[name=EMP_REFERENCIAS]').val().replace(/<br>/gi,'\n'));
}//fin de globalEvents


//	27nov17	Recarga los desplegables del margen izquierdo con la empresa actual si esta ha sido modificada
function recargaDesplegables()
{
	//solodebug	console.log (document.forms['MantenEmpresa'].elements['ACTUALIZADA'].value);
	
	if ((document.forms['MantenEmpresa'].elements['ACTUALIZADA'].value=='S')&&(parent.zonaEmpresa))
	{
		//solodebug	console.log('recargaDesplegables -> CambioEmpresaActual:'+document.forms['MantenEmpresa'].elements['EMP_ID'].value);
		
		parent.zonaEmpresa.CambioEmpresaActual(document.forms['MantenEmpresa'].elements['EMP_ID'].value);
	}
}

//tienePedidos para ver si empresa tiene pedidos, aviso al cambiar el nombre
function tienePedidos(){
	var form=document.forms['MantenEmpresa'];
	var tienePedidos = form.elements['TIENEPEDIDOS'].value;
	var empresa = form.elements['EMP_NOMBRE'].value;
	//alert('tiene ped '+tienePedidos);

	var formJS = document.forms['MensajeJS'];
	var AvisoTienePedidos = formJS.elements['TIENE_PEDIDOS_AVISO'].value;
	alert(empresa + AvisoTienePedidos);

}//fin de tienePedidos


//recargo select logos desp que subo uno
function SeleccionaLogos(IDPROVE,ID,ACCION){
	//alert('prove '+IDPROVE+' id '+ID);
	var ACTION="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/LogosEmpresa.xsql";;
	var post='IDPROVEEDOR='+IDPROVE;
	if (IDPROVE!=-1 && IDPROVE!=0) sendRequest(ACTION,handleRequestLogos,post,ACCION);
}

function handleRequestLogos(req,accion){

	//alert('req '+req+' accion '+accion);
	var response = eval("(" + req.responseText + ")");
	var Resultados = new String('');
	var Doc_ID_Actual = new String('');


	if (response.Filtros != ''){
		for (var i=0; i < response.Filtros.length; i++) {

			if (i==1) {
				Doc_ID_Actual=response.Filtros[i].Fitro.id;
				File_ID_Actual = response.Filtros[i].Fitro.file;
				File_URL_Actual = 'http://www.newco.dev.br/Documentos/'+File_ID_Actual;
			}

			Resultados =Resultados+' <option value="'+response.Filtros[i].Fitro.id+'">'+response.Filtros[i].Fitro.nombre+'</option>';
		}

    jQuery("#IDLOGOTIPO").show();
    jQuery("#IDLOGOTIPO").html(Resultados);
    // PS 20160913
		// $("#IDLOGOTIPO").show();
		//$("#IDLOGOTIPO").html(Resultados);

		if (accion=='lista') document.forms['MantenEmpresa'].elements['IDLOGOTIPO'].value = '-1';
		else document.forms['MantenEmpresa'].elements['IDLOGOTIPO'].value = Doc_ID_Actual;

	}
	return true;
}

//cambio de provincia si cambia pais
//4feb17	No permitimos cambio de pais
//4feb17	function selectProvincia(pais){
//4feb17	 jQuery('.provincias').hide();
//4feb17	 jQuery('#provincia_'+pais).show();
//4feb17	}


function ValidarNumero(obj,decimales){

if(checkNumber(obj.value,obj)){
  if(parseFloat(reemplazaComaPorPunto(obj.value))!=0){
    obj.value=anyadirCerosDecimales(reemplazaPuntoPorComa(Round(reemplazaComaPorPunto(obj.value),decimales)),decimales);
  }
return true;
}
return false;
}





function ModificarMinimoPorCliente(idCliente,idCentro, accion)
{
	var form=document.forms[0];

	var pedidoMinimo='N';
	var pedidoMinimoActivo;
	var pedidoMinimoEstricto;
	var pedidoMinimo;
	var descripcionPedidoMnimo;



	if(form.elements['EMP_PEDMINIMOACTIVO_CHECK'].checked==true)
	  pedidoMinimo='S';

	if(form.elements['EMP_PEDMINIMOESTRICTO_CHECK'].checked==true)
	  pedidoMinimo='E';

	  /*
    	  preparando la descripcion del pedido minimo con los saltos de linea
    	  ya que al pararlo como include-param se pierden
	  */

	  var arrAscii=new Array();

	  for(var i=0;i<form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].value.length;i++){
    	arrAscii[arrAscii.length]=form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].value.charCodeAt(i);
	  }

	  var cadenaTemp='';

	  for(var i=0;i<arrAscii.length;i++){
    	if(arrAscii[i]==13 && arrAscii[i+1]==10){
    	  cadenaTemp+='<br/>';
    	  i++;
    	}
    	else{
    	  cadenaTemp+=String.fromCharCode(arrAscii[i]);
    	}
	  }


	var opciones='?IDPROVEEDOR='                           + form.elements['EMP_ID'].value +
            	  '&NUEVO_CLIENTE='                + idCliente          +
            	  '&NUEVO_CENTRO='                + idCentro          +
            	 '&EMP_PEDMINIMO_ACTIVO='            + pedidoMinimo                                         +
            	 '&EMP_PEDMINIMO_IMPORTE='               + form.elements['EMP_PEDIDOMINIMO'].value              +
            	 '&EMP_PEDMINIMO_DETALLE='    + cadenaTemp +
            	 '&ACCION='                   + accion;

	MostrarPag('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/PedidoMinimoPorCliente.xsql'+opciones,'pedidoMinimo');
}


function PedidoMinimoPorCliente()
{
	var form=document.forms[0];

	var pedidoMinimo='N';
	var pedidoMinimoActivo;
	var pedidoMinimoEstricto;
	var integrado;
	var pedidoMinimo;
	var descripcionPedidoMnimo;



	if(form.elements['EMP_PEDMINIMOACTIVO_CHECK'].checked==true)
	  pedidoMinimo='S';

	if(form.elements['EMP_PEDMINIMOESTRICTO_CHECK'].checked==true)
	  pedidoMinimo='E';

	/*
    	  preparando la descripcion del pedido minimo con los saltos de linea
    	  ya que al pararlo como include-param se pierden
	  */

	  var arrAscii=new Array();

	  for(var i=0;i<form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].value.length;i++){
    	arrAscii[arrAscii.length]=form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].value.charCodeAt(i);
	  }

	  var cadenaTemp='';

	  for(var i=0;i<arrAscii.length;i++){
    	if(arrAscii[i]==13 && arrAscii[i+1]==10){
    	  cadenaTemp+='<br/>';
    	  i++;
    	}
    	else{
    	  cadenaTemp+=String.fromCharCode(arrAscii[i]);
    	}
	  }


	var opciones='?IDPROVEEDOR='                           + form.elements['EMP_ID'].value +
            	 '&EMP_PEDMINIMO_ACTIVO='            + pedidoMinimo                                         +
            	 '&EMP_PEDMINIMO_IMPORTE='               + form.elements['EMP_PEDIDOMINIMO'].value              +
            	 '&EMP_PEDMINIMO_DETALLE='    + cadenaTemp;


	MostrarPag('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/PedidoMinimoPorCliente.xsql'+opciones,'pedidoMinimo');
}


//abrir la pagina de coste trasporte por cliente mi-06-12
 function CosteTransportePorCliente(){
        var form=document.forms[0];

        var pedidoMinimo='N';
        var pedidoMinimoActivo;
        var pedidoMinimoEstricto;
        var integrado;
        var pedidoMinimo;
        var descripcionPedidoMnimo;



        if(form.elements['EMP_COSTETRANSPORTEACTIVO_CHECK'].checked==true)
          pedidoMinimo='S';

        if(form.elements['EMP_COSTETRANSPORTEESTRICTO_CHECK'].checked==true)
          pedidoMinimo='E';

        /*
              preparando la descripcion del pedido minimo con los saltos de linea
              ya que al pararlo como include-param se pierden
          */

          var arrAscii=new Array();

          for(var i=0;i<form.elements['EMP_DESCRIPCIONCOSTETRANSPORTE'].value.length;i++){
            arrAscii[arrAscii.length]=form.elements['EMP_DESCRIPCIONCOSTETRANSPORTE'].value.charCodeAt(i);
          }

          var cadenaTemp='';

          for(var i=0;i<arrAscii.length;i++){
            if(arrAscii[i]==13 && arrAscii[i+1]==10){
              cadenaTemp+='<br/>';
              i++;
            }
            else{
              cadenaTemp+=String.fromCharCode(arrAscii[i]);
            }
          }


        var opciones='?IDPROVEEDOR='                           + form.elements['EMP_ID'].value +
                     '&EMP_COSTETRANSPORTE_ACTIVO='            + pedidoMinimo                                         +
                     '&EMP_COSTETRANSPORTE_IMPORTE='               + form.elements['EMP_COSTETRANSPORTE'].value              +
                     '&EMP_COSTETRANSPORTE_DETALLE='    + cadenaTemp;


        MostrarPag('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CosteTransportePorCliente.xsql'+opciones,'pedidoMinimo');
      }

 function costeTransporte(nombre,form){
      if(nombre=="EMP_COSTETRANSPORTEACTIVO_CHECK"){

        if(form.elements[nombre].checked==true){
          form.elements['EMP_COSTETRANSPORTEESTRICTO_CHECK'].disabled=false;
          form.elements['EMP_COSTETRANSPORTE'].disabled=false;
          //form.elements['EMP_COSTETRANSPORTE_LOGISTICA'].disabled=false;
          form.elements['EMP_DESCRIPCIONCOSTETRANSPORTE'].disabled=false;
        }
        else{
          form.elements['EMP_COSTETRANSPORTEESTRICTO_CHECK'].checked=false;
          form.elements['EMP_COSTETRANSPORTEESTRICTO_CHECK'].disabled=true;

          form.elements['EMP_COSTETRANSPORTE'].value='';
          form.elements['EMP_COSTETRANSPORTE'].disabled=true;

         // form.elements['EMP_COSTETRANSPORTE_LOGISTICA'].value='';
          //form.elements['EMP_COSTETRANSPORTE_LOGISTICA'].disabled=true;

          form.elements['EMP_DESCRIPCIONCOSTETRANSPORTE'].value='';
          form.elements['EMP_DESCRIPCIONCOSTETRANSPORTE'].disabled=true;
        }
      }

    }
//fin functions coste de trasporte



//	13jul10	ET	Comentarios comerciales
//				PENDIENTE DE PROCESAR OPCIONES
function  Comentarios (Opciones)
{
	var form=document.forms[0],
		Parametros;


	Parametros='?IDRELACIONADO1='+form.elements['EMP_ID'].value

    MostrarPag('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/Comentarios.xsql'+Parametros,'Comentarios');
};


//msgPedidoMinimoActivo='Ha marcado el campo \"Pedido MÃ­nimo\" como \'Activo\'. Por favor, rogamos rellene el campo \"Importe MÃ­nimo\" antes de enviar el formulario.';
//msgNoAceptarOfertas='Ha marcado el campo \"Pedido MÃ­nimo\" como \'No Aceptar Ofertas\'. Por favor, rogamos rellene el campo \"Importe MÃ­nimo\" antes de enviar el formulario.';


/*
  modificado por nacho
  10.07.2002

  reemplazamos el form.action

  de
    EMPMantenComercialSave.xsql  (solo se actualiza el comercial)
  a
    EMPMantenSave.xsql           (actualizamos todo)
    el que aparece por defecto en el formulario


*/

function  GuardarComercial ( form ) {
 //form.action='EMPMantenComercialSave.xsql';
 //SubmitForm(form)
}



function esNulo(valor){
  if(valor=='')
    return true;
  else
    return false;
}

function esLetraMinuscula(caracter){
    if(caracter!=' ' && (caracter<'a' || caracter>'z'))
      return false;
    else
      return true;
}



function esLetraMayuscula(caracter){
    if(caracter!=' ' && (caracter<'A' || caracter>'Z'))
      return false;
    else
      return true;
}



function esLetra(caracter){
    if(esLetraMayuscula(caracter) || esLetraMinuscula(caracter))
      return true;
    else
      return false;
}

function esNumero(caracter){
    if(caracter<'0' || caracter>'9')
      return false;
    else
      return true;
}


function esNif(cadena){

   if(!esLetra(cadena.substring(0,1)))
     return false;

   if(cadena.substring(1,2)!='-')
     return false;

   for(var n=2;n<cadena.length;n++){
      if(!esNumero(cadena.substring(n,n+1)))
        return false;
    }
    return true;
}


function ActualizarDatos(form){
	if(validarFormulario(form)){
		//4feb17 no hay multipais multi pais => doy a provincia el valor de prov espanya o brasil
		//espanya
		//4feb17 if(document.getElementById('provincia_34').style.display != 'none' && form.elements['EMP_IDPAIS'].value == '34' && form.elements['PROVINCIA_34'].value != ''){
		//4feb17 	form.elements['EMP_PROVINCIA'].value = form.elements['PROVINCIA_34'].value;
		//4feb17 }
		//brasil
		//4feb17 if(document.getElementById('provincia_55').style.display != 'none' && form.elements['EMP_IDPAIS'].value == '55' && form.elements['PROVINCIA_55'].value != ''){
		//4feb17 	form.elements['EMP_PROVINCIA'].value = form.elements['PROVINCIA_55'].value;
		//4feb17 }
		form.elements['EMP_PROVINCIA'].value = form.elements['PROVINCIA'].value;

		form.action = "EMPMantenSave.xsql";
		form.enctype = "application/x-www-form-urlencoded";
		form.method = "post";
		form.target = '';

		if (form.elements['TIENEPEDIDOS'].value == 'S' && ( (form.elements['EMP_NOMBRE_OLD'].value != form.elements['EMP_NOMBRE'].value) || (form.elements['EMP_NOMBRE_CORTO_OLD'].value != form.elements['EMP_NOMBRE_CORTO'].value) )){
			var formJS = document.forms['MensajeJS'];
			var AvisoTienePedidos = formJS.elements['TIENE_PEDIDOS_AVISO'].value;
			alert(form.elements['EMP_NOMBRE'].value + AvisoTienePedidos)
			}
		/*alert('form action '+form.action);
		alert('form enctype '+form.enctype);
		alert('form method '+form.method);
		alert('form target '+form.target);*/
        jQuery(".boton").hide(); //cuando envio formulario que ok escondo botones
        SubmitForm(form);
	}
        //top.location.href = "http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalle.xsql?EMP_ID=9916&ESTADO=CABECERA";
        //window.reload('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=9916&ESTADO=CABECERA');
        //window.opener.location.reload();
        //window.close();
        //   top.location.reload();
        //window.opener.document.location.reload();
        //alert(top.opener.document.name);
        //Refresh(top.opener.document);

        /* var objFrameTop=new Object();
            objFrameTop=window.opener.top;
            var FrameOpenerName=window.opener.name;

            alert(FrameOpenerName);
            Refreshwindow(FrameOpenerName);

            var objFrame=new Object();

            objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
			alert (objFrameTop.name);
			alert (objFrame.name);
                        objFrame.reload();
			//inserto ref en campo input referencia
			//var formMant = objFrame.document.forms['form1'];
      */
}


function validarFormulario(form){
	var regex_cpostal	= new RegExp("^[0-9\\-()]+$","g"); // campo EMP_CPOSTAL que solo puede incluir números, guiones y parentesis (requisito MVMB)
	var regex_tlfn		= new RegExp("^[0-9\\-()]+$","g"); // campo EMP_TELEFONO que solo puede incluir números, guiones y parentesis (requisito MVMB) + Espacios
	var regex_fax		= new RegExp("^[0-9\\-()]+$","g"); // campo EMP_FAX que solo puede incluir números, guiones y parentesis (requisito MVMB) + Espacios
	var regex_nombre_pub= new RegExp("^[0-9a-zA-Z]+$","g"); // campo NOMBRE PUBLICO que solo puede incluir números y letras (requisito MVM) + Espacios
	var regex_car_raros = /([\#|\\|\'|\|])+/g;
	var regex_potcompras= new RegExp("^[0-9]+$","g"); // Expresion regular para controlar el campo EMP_POTENCIAL_COMPRAS que solo puede incluir números, puntos o comas
	var regex_potcat	= new RegExp("^[0-9]+$","g"); // Expresion regular para controlar el campo EMP_POTENCIAL_CATALOGO que solo puede incluir números, puntos o comas

	var errores=0;
    var raros=0;


	if((!errores) && (esNulo(document.forms[0].elements['EMP_NOMBRE'].value))){
		errores=1;
		alert(document.forms['MensajeJS'].elements['OBLI_NOMBRE_EMPRESA'].value);
		form.elements['EMP_NOMBRE'].focus();
		return false;
	}

	if((!errores) && (esNulo(document.forms[0].elements['EMP_NOMBRECORTOPUBLICO'].value))){
		errores=1;
		alert(document.forms['MensajeJS'].elements['OBLI_NOMBRECORTOPUBLICO'].value);
		form.elements['EMP_NOMBRECORTOPUBLICO'].focus();
		return false;
	}else /*if((!errores) && (!checkRegEx(document.forms[0].elements['EMP_NOMBRECORTOPUBLICO'].value, regex_nombre_pub))){
		errores=1;
		alert(document.forms['MensajeJS'].elements['FORMATO_NOMBRECORTOPUBLICO'].value.replace('[SALTOLINEA]','\n'));
		form.elements['EMP_NOMBRECORTOPUBLICO'].focus();
		return false;*/

        if((!errores) && checkRegEx(document.forms[0].elements['EMP_NOMBRECORTOPUBLICO'].value, regex_car_raros)){
                //si true implica que si ha encontrado caracteres raros
                alert(document.forms['MensajeJS'].elements['CAR_RAROS'].value);
                return false;
        //fin for caracteres raros

	}else if(document.forms[0].elements['EMP_NOMBRECORTOPUBLICO'].value != document.forms[0].elements['EMP_NOMBRECORTOPUBLICO_OLD'].value){


// Hacemos la peticion ajax en esta misma funcion pq sino no espera a recibir respuesta del servidor -- javascript funciona de foma asincrona
		var d = new Date();
		var NombreCortoPublico = document.forms[0].elements['EMP_NOMBRECORTOPUBLICO'].value;

		jQuery.ajax({
			url:"comprobarNombreCorto.xsql",
			data: "NOMBRE_CORTO_PUBLICO="+NombreCortoPublico+"&_="+d.getTime(),
		  	type: "GET",
			async: false,
			contentType: "application/xhtml+xml",
			beforeSend:function(){
				null;
			},
			error:function(objeto, quepaso, otroobj){
				alert("objeto:"+objeto);
				alert("otroobj:"+otroobj);
				alert("quepaso:"+quepaso);
			},
			success:function(objeto){
				var data = eval("(" + objeto + ")");

				if(data.NombreCorto.estado == 'ERROR'){
					errores=1;
					alert(document.forms['MensajeJS'].elements['YA_EXISTE_NOMBRECORTOPUBLICO'].value.replace('[SALTOLINEA]','\n'));
					form.elements['EMP_NOMBRECORTOPUBLICO'].focus();
					return false;
	                        }
			}
		});
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

	/* Cod Postal opcional
	Si es espaÃ±a paso por control Codigo postal
	if (form.elements['EMP_IDPAIS'].value == '34'){
		if((!errores) && (!checkNumber(document.forms[0].elements['EMP_CPOSTAL'].value, document.forms[0].elements['EMP_CPOSTAL']))){
			errores=1;
			form.elements['EMP_CPOSTAL'].focus();
			return false;
		}else{
			if((!errores) && (esNulo(document.forms[0].elements['EMP_CPOSTAL'].value))){
				errores=1;
				alert(document.forms['MensajeJS'].elements['OBLI_COD_POSTAL'].value);
				form.elements['EMP_CPOSTAL'].focus();
				return false;
			}
		}
	}//fin if si es espaÃ±a

	//si es Brasil paso por control CEP
	if (form.elements['EMP_IDPAIS'].value == '55'){
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
	}//fin if si es brasil
	*/

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
		if(!checkRegEx(document.forms[0].elements['EMP_TELEFONO'].value, regex_tlfn)){
			errores=1;
			alert(document.forms['MensajeJS'].elements['FORMATO_NUM_GUION_PARENT'].value);
			form.elements['EMP_TELEFONO'].focus();
			return false;
		}
	}

	if((document.forms[0].elements['EMP_POTENCIAL_COMPRAS'].value!='') && (!checkRegEx(document.forms[0].elements['EMP_POTENCIAL_COMPRAS'].value, regex_potcompras)) ){
		errores=1;
		alert(document.forms['MensajeJS'].elements['FORMATO_NUMERO'].value);
		form.elements['EMP_POTENCIAL_COMPRAS'].focus();
		return false;
	}

	if((document.forms[0].elements['EMP_POTENCIAL_CATALOGO'].value!='') && (!checkRegEx(document.forms[0].elements['EMP_POTENCIAL_CATALOGO'].value, regex_potcat)) ){
		errores=1;
		alert(document.forms['MensajeJS'].elements['FORMATO_NUMERO'].value);
		form.elements['EMP_POTENCIAL_CATALOGO'].focus();
		return false;
	}

	if((!errores) && (!checkRegEx(document.forms[0].elements['EMP_FAX'].value, regex_fax)) && (!esNulo(document.forms[0].elements['EMP_FAX'].value))){
		errores=1;
		alert(document.forms['MensajeJS'].elements['FORMATO_NUM_GUION_PARENT'].value);
		form.elements['EMP_FAX'].focus();
		return false;
	}

	if(document.forms[0].elements['TIPO_EMP'].value == 'VENDEDOR'){
		if((!errores) && (document.forms[0].elements['EMP_COMERCIAL_DEFECTO'].value<1)){
			errores=1;
			alert(document.forms['MensajeJS'].elements['OBLI_COMERCIAL'].value);
			form.elements['EMP_COMERCIAL_DEFECTO'].focus();
			return false;
		}
	}
    //usuario reclamaciones se usa en comprador y proveedor 24-3-15
    if (document.forms[0].elements['TIPO_EMP'].value == 'COMPRADOR' && document.forms[0].elements['EMP_IDUSUARIORECLAMACIONES_CLIENTE'] && document.forms[0].elements['EMP_IDUSUARIORECLAMACIONES_CLIENTE'].value>=1){
        form.elements['EMP_IDUSUARIORECLAMACIONES'].value = form.elements['EMP_IDUSUARIORECLAMACIONES_CLIENTE'].value;
    }
    else if (document.forms[0].elements['TIPO_EMP'].value != 'COMPRADOR' && document.forms[0].elements['EMP_IDUSUARIORECLAMACIONES_PROVE'] && document.forms[0].elements['EMP_IDUSUARIORECLAMACIONES_PROVE'].value>=1){
        form.elements['EMP_IDUSUARIORECLAMACIONES'].value = form.elements['EMP_IDUSUARIORECLAMACIONES_PROVE'].value;
    }

    if((!errores) && document.forms[0].elements['EMP_IDUSUARIORECLAMACIONES'].value<1 ){
		errores=1;
		alert(document.forms['MensajeJS'].elements['OBLI_US_RECLAMACIONES'].value);
		form.elements['EMP_IDUSUARIORECLAMACIONES'].focus();
		return false;
	}

	if((!errores)&& (document.forms[0].elements['ID_RESP_CAT'])){
		if((document.forms[0].elements['ID_RESP_CAT'].disabled==false) && (document.forms[0].elements['ID_RESP_CAT'].value<0)){
			errores++;
			alert(document.forms['MensajeJS'].elements['OBLI_USUARIO_CATALOGO'].value);
			document.forms[0].elements['ID_RESP_CAT'].focus();
			return false;
		}
	}

	if((!errores)&& (document.forms[0].elements['ID_RESP_EVAL'])){
		if((document.forms[0].elements['ID_RESP_EVAL'].disabled==false) && (document.forms[0].elements['ID_RESP_EVAL'].value<0)){
			errores++;
			alert(document.forms['MensajeJS'].elements['OBLI_USUARIO_EVALUAZ'].value);
			document.forms[0].elements['ID_RESP_EVAL'].focus();
			return false;
		}
	}

	if((!errores)&& (document.forms[0].elements['ID_RESP_INC'])){
		if((document.forms[0].elements['ID_RESP_INC'].disabled==false) && (document.forms[0].elements['ID_RESP_INC'].value<0)){
			errores++;
			alert(document.forms['MensajeJS'].elements['OBLI_USUARIO_INCIDEN'].value);
			document.forms[0].elements['ID_RESP_INC'].focus();
			return false;
		}
	}

		if(document.getElementById("soloCliente").style.display != 'none'){
			if((!errores) && document.forms[0].elements['EMP_IDUSUARIOLICITACIONESAUT'] && document.forms[0].elements['EMP_IDUSUARIOLICITACIONESAUT'].value <= '0'){
				errores++;
				alert(document.forms['MensajeJS'].elements['OBLI_USUARIO_LICITACION_AUTO'].value);
				return false;
			}
		}

		if((!errores)&& (document.forms[0].elements['ID_RESP_NEG'])){
			if((document.forms[0].elements['ID_RESP_NEG'].disabled==false) && (document.forms[0].elements['ID_RESP_NEG'].value<0)){
				errores++;
				alert(document.forms['MensajeJS'].elements['OBLI_USUARIO_NEGOCIA'].value);
				document.forms[0].elements['ID_RESP_NEG'].focus();
				return false;
			}
		}

		if((!errores) && (document.forms[0].elements['EMP_PEDMINIMOACTIVO_CHECK'].checked==true)){
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
					alert(document.forms['MensajeJS'].elements['PEDIDO_MINIMO_ACTIVO'].value);
				}else{
					alert(document.forms['MensajeJS'].elements['NO_ACEPTAR_OFERTAS'].value);
				}
				form.elements['EMP_PEDIDOMINIMO'].focus();
				return false;
			}else{
				//quitado remplazacomaconpunto //document.forms[0].elements['EMP_PEDIDOMINIMO'].value=reemplazaComaPorPunto(document.forms[0].elements['EMP_PEDIDOMINIMO'].value);
			}
		}else{
			if((!errores) && (document.forms[0].elements['EMP_PEDMINIMOACTIVO_CHECK'].checked==false)){
				document.forms[0].elements['EMP_PEDMINIMOACTIVO'].value='';
			}
		}

		//COSTE TRASPORTE
		//alert(document.forms[0].elements['EMP_COSTETRANSPORTEACTIVO_CHECK'].checked);
		if((!errores) && (document.forms[0].elements['EMP_COSTETRANSPORTEACTIVO_CHECK'].checked==true)){
			var queMensaje;
			if(document.forms[0].elements['EMP_COSTETRANSPORTEACTIVO_CHECK'].checked==true){
				document.forms[0].elements['EMP_COSTETRANSPORTEACTIVO'].value='S';
				queMensaje='MINIMO_ACTIVO';
				if(document.forms[0].elements['EMP_COSTETRANSPORTEESTRICTO_CHECK'].checked==true)
					document.forms[0].elements['EMP_COSTETRANSPORTEACTIVO'].value='E';
			}else{
				document.forms[0].elements['EMP_COSTETRANSPORTEACTIVO'].value='I';
				queMensaje='INTEGRADO';
			}

			if(esNulo(document.forms[0].elements['EMP_COSTETRANSPORTE'].value)){
				errores=1;
				if(queMensaje=='MINIMO_ACTIVO'){
					alert(document.forms['MensajeJS'].elements['COSTE_TRASPORTE_ACTIVO_ALERT'].value);
				}else{
					//alert(document.forms['MensajeJS'].elements['NO_ACEPTAR_OFERTAS'].value);
				}
				form.elements['EMP_COSTETRANSPORTE'].focus();
				return false;
			}else{
				//document.forms[0].elements['EMP_COSTETRANSPORTE'].value=reemplazaComaPorPunto(document.forms[0].elements['EMP_COSTETRANSPORTE'].value);
			}
		}else{
			if((!errores) && (document.forms[0].elements['EMP_COSTETRANSPORTEACTIVO_CHECK'].checked==false)){
				document.forms[0].elements['EMP_COSTETRANSPORTEACTIVO'].value='';
			}
		}
		//alert(document.forms[0].elements['EMP_COSTETRANSPORTEACTIVO'].value);
		//alert(document.forms[0].elements['EMP_COSTETRANSPORTE'].value);
		//FIN COSTE TRASPORTE CHECK

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

		//	10jul09	Navegar proveedores
		if((!errores) && (document.forms[0].elements['EMP_PROVNONAVEGAR_CHK'])){
			if(document.forms[0].elements['EMP_PROVNONAVEGAR_CHK'].checked==true)
				document.forms[0].elements['EMP_PROVNONAVEGAR'].value='on';
			else
				document.forms[0].elements['EMP_PROVNONAVEGAR'].value='';
		}

		//	25may10	Nuevo modelo de negocio
		if((!errores) && (document.forms[0].elements['EMP_OCULTARPRECIOREF_CHK'])){
			if(document.forms[0].elements['EMP_OCULTARPRECIOREF_CHK'].checked==true)
				document.forms[0].elements['EMP_OCULTARPRECIOREF'].value='on';
			else
				document.forms[0].elements['EMP_OCULTARPRECIOREF'].value='';
		}

		//	07may13	Mostrar precios con IVA
		if((!errores) && (document.forms[0].elements['EMP_PRECIOSCONIVA_CHK'])){
			if(document.forms[0].elements['EMP_PRECIOSCONIVA_CHK'].checked==true)
				document.forms[0].elements['EMP_PRECIOSCONIVA'].value='on';
			else
				document.forms[0].elements['EMP_PRECIOSCONIVA'].value='';
		}

		//	7jun10	Bloquear bandeja de proveedor
		if((!errores) && (document.forms[0].elements['EMP_BLOQUEARBANDEJA_CHK'])){
			if(document.forms[0].elements['EMP_BLOQUEARBANDEJA_CHK'].checked==true)
				document.forms[0].elements['EMP_BLOQUEARBANDEJA'].value='on';
			else
				document.forms[0].elements['EMP_BLOQUEARBANDEJA'].value='';
		}

		//	7set10	Nuevo modelo de negocio
		if((!errores) && (document.forms[0].elements['EMP_MOSTRARCOMISIONES_NM_CHK'])){
			if(document.forms[0].elements['EMP_MOSTRARCOMISIONES_NM_CHK'].checked==true)
				document.forms[0].elements['EMP_MOSTRARCOMISIONES_NM'].value='on';
			else
				document.forms[0].elements['EMP_MOSTRARCOMISIONES_NM'].value='';
		}

		//09-4-13 si es cliente cojo valor de EMP_BLOQUEARMUESTRAS_CHK cliente
		if ((!errores) && (document.forms[0].elements['EMP_BLOQUEARMUESTRAS_CHK_CL']) && document.getElementById('soloCliente').style.display != 'none'){
			if(document.forms[0].elements['EMP_BLOQUEARMUESTRAS_CHK_CL'].checked==true)
				document.forms[0].elements['EMP_BLOQUEARMUESTRAS'].value='on';
			else
				document.forms[0].elements['EMP_BLOQUEARMUESTRAS'].value='';
			//alert('bloq muestras cl'+form.elements['EMP_BLOQUEARMUESTRAS'].value);
		}

		//09-4-13 si es proveedor cojo valor de EMP_BLOQUEARMUESTRAS_CHK provee
		if ((!errores) && (document.forms[0].elements['EMP_BLOQUEARMUESTRAS_CHK_PR']) && document.getElementById('soloProveedor').style.display != 'none'){
			if(document.forms[0].elements['EMP_BLOQUEARMUESTRAS_CHK_PR'].checked==true)
				document.forms[0].elements['EMP_BLOQUEARMUESTRAS'].value='on';
			else
				document.forms[0].elements['EMP_BLOQUEARMUESTRAS'].value='';
			//alert('bloq muestras pr'+form.elements['EMP_BLOQUEARMUESTRAS'].value);
		}
        //16-4-15 si es cliente precio ref informado
		if ((!errores) && (document.forms[0].elements['EMP_PRECIOSHISTINFORMADOS_CHK']) && document.getElementById('soloCliente').style.display != 'none'){
			if(document.forms[0].elements['EMP_PRECIOSHISTINFORMADOS_CHK'].checked==true){
				document.forms[0].elements['EMP_PRECIOSHISTINFORMADOS'].value='on';
                        }
			else
				document.forms[0].elements['EMP_PRECIOSHISTINFORMADOS'].value='';
		}

        //8may17 si es cliente precio ref informado
		if ((!errores) && (document.forms[0].elements['EMP_PRECIOREFSEGUNULTPEDIDO_CHK']) && document.getElementById('soloCliente').style.display != 'none'){
			if(document.forms[0].elements['EMP_PRECIOREFSEGUNULTPEDIDO_CHK'].checked==true){
				document.forms[0].elements['EMP_PRECIOREFSEGUNULTPEDIDO'].value='on';
            }
			else
				document.forms[0].elements['EMP_PRECIOREFSEGUNULTPEDIDO'].value='';
		}

        //10oct17 Mostrar forma de pago en pedidos
		if ((!errores) && (document.forms[0].elements['EMP_PED_FORMAPAGO_CHK'])){
			if(document.forms[0].elements['EMP_PED_FORMAPAGO_CHK'].checked==true){
				document.forms[0].elements['EMP_PED_FORMAPAGO'].value='on';
            }
			else
				document.forms[0].elements['EMP_PED_FORMAPAGO'].value='';
		}

        //27nov17 Procedimiento de pedido llega hasta control de pago
		if ((!errores) && (document.forms[0].elements['EMP_PEDIDOHASTAPAGO_CHK']))
		{
			if(document.forms[0].elements['EMP_PEDIDOHASTAPAGO_CHK'].checked==true){
				document.forms[0].elements['EMP_PEDIDOHASTAPAGO'].value='on';

            }
			else
				document.forms[0].elements['EMP_PEDIDOHASTAPAGO'].value='';
		}
		
        //17ago18 Procedimiento de pedido llega hasta control de pago
		if ((!errores) && (document.forms[0].elements['EMP_OCULTARFECHAENTREGA_CHK']))
		{
			if(document.forms[0].elements['EMP_OCULTARFECHAENTREGA_CHK'].checked==true){
				document.forms[0].elements['EMP_OCULTARFECHAENTREGA'].value='on';

            }
			else
				document.forms[0].elements['EMP_OCULTARFECHAENTREGA'].value='';
		}
		
		
        //18-5-15 precio historico por centro
		if ((!errores) && (document.forms[0].elements['EMP_PRECIOSHISTPORCENTRO_CHK']) && document.getElementById('soloCliente').style.display != 'none'){
			if(document.forms[0].elements['EMP_PRECIOSHISTPORCENTRO_CHK'].checked==true){
				document.forms[0].elements['EMP_PRECIOSHISTPORCENTRO'].value='on';
            }
			else
				document.forms[0].elements['EMP_PRECIOSHISTPORCENTRO'].value='';
		}

        //10may16 Nuevo campo:EMP_PEDIDO_SINCATEGORIAS
		if ((!errores) && (document.forms[0].elements['EMP_PEDIDO_SINCATEGORIAS_CHK']) && document.getElementById('soloCliente').style.display != 'none'){
			if(document.forms[0].elements['EMP_PEDIDO_SINCATEGORIAS_CHK'].checked==true){
				document.forms[0].elements['EMP_PEDIDO_SINCATEGORIAS'].value='on';
            }
			else
				document.forms[0].elements['EMP_PEDIDO_SINCATEGORIAS'].value='';
		}

        //10may16 Nuevo campo:EMP_SINSEPARARFARMACIA
		if ((!errores) && (document.forms[0].elements['EMP_SINSEPARARFARMACIA_CHK']) && document.getElementById('soloCliente').style.display != 'none'){
			if(document.forms[0].elements['EMP_SINSEPARARFARMACIA_CHK'].checked==true){
				document.forms[0].elements['EMP_SINSEPARARFARMACIA'].value='on';
            }
			else
				document.forms[0].elements['EMP_SINSEPARARFARMACIA'].value='';
		}

        //27may16 Nuevo campo:EMP_PERMITIRCONTROLPEDIDOS
		if ((!errores) && (document.forms[0].elements['EMP_PERMITIRCONTROLPEDIDOS_CHK'])){
			if(document.forms[0].elements['EMP_PERMITIRCONTROLPEDIDOS_CHK'].checked==true){
				document.forms[0].elements['EMP_PERMITIRCONTROLPEDIDOS'].value='on';
            }
			else
				document.forms[0].elements['EMP_PERMITIRCONTROLPEDIDOS'].value='';
		}

        //20ago18 Nuevo campo:EMP_PERMITIRCONTROLPEDIDOS
		if ((!errores) && (document.forms[0].elements['EMP_SINSEGUIMIENTOPEDIDOS_CHK'])){
			if(document.forms[0].elements['EMP_SINSEGUIMIENTOPEDIDOS_CHK'].checked==true){
				document.forms[0].elements['EMP_SINSEGUIMIENTOPEDIDOS'].value='on';
            }
			else
				document.forms[0].elements['EMP_SINSEGUIMIENTOPEDIDOS'].value='';
		}

        //21dic18 Nuevo campo:EMP_REFCLIENTEPORCENTRO
		if ((!errores) && (document.forms[0].elements['EMP_REFCLIENTEPORCENTRO_CHK'])){
			if(document.forms[0].elements['EMP_REFCLIENTEPORCENTRO_CHK'].checked==true){
				document.forms[0].elements['EMP_REFCLIENTEPORCENTRO'].value='on';
            }
			else
				document.forms[0].elements['EMP_REFCLIENTEPORCENTRO'].value='';
		}

        //30oct19 Nuevo campo:EMP_REFCLIENTEPORCENTRO
		if ((!errores) && (document.forms[0].elements['EMP_DERECHOSPRODUCTOSPORCENTRO_CHK'])){
			if(document.forms[0].elements['EMP_DERECHOSPRODUCTOSPORCENTRO_CHK'].checked==true){
				document.forms[0].elements['EMP_DERECHOSPRODUCTOSPORCENTRO'].value='on';
            }
			else
				document.forms[0].elements['EMP_DERECHOSPRODUCTOSPORCENTRO'].value='';
		}

        //21dic18 Nuevo campo:EMP_CATALOGOMULTIOPCION
		if ((!errores) && (document.forms[0].elements['EMP_CATALOGOMULTIOPCION_CHK'])){
			if(document.forms[0].elements['EMP_CATALOGOMULTIOPCION_CHK'].checked==true){
				document.forms[0].elements['EMP_CATALOGOMULTIOPCION'].value='on';
            }
			else
				document.forms[0].elements['EMP_CATALOGOMULTIOPCION'].value='';
		}
		
		//console.log('EMP_CATALOGOMULTIOPCION:'+document.forms[0].elements['EMP_CATALOGOMULTIOPCION'].value);
		

        // Nuevo campo:EMP_INT_SOLOPEDIDOS
		if ((!errores) && (document.forms[0].elements['EMP_INT_SOLOPEDIDOS_CHK'])){
			if(document.forms[0].elements['EMP_INT_SOLOPEDIDOS_CHK'].checked==true){
				document.forms[0].elements['EMP_INT_SOLOPEDIDOS'].value='on';
            }
			else
				document.forms[0].elements['EMP_INT_SOLOPEDIDOS'].value='';
		}

        // Nuevo campo:EMP_INT_MANDACATALOGOERP
		if ((!errores) && (document.forms[0].elements['EMP_INT_MANDACATALOGOERP_CHK'])){
			if(document.forms[0].elements['EMP_INT_MANDACATALOGOERP_CHK'].checked==true){
				document.forms[0].elements['EMP_INT_MANDACATALOGOERP'].value='on';
            }
			else
				document.forms[0].elements['EMP_INT_MANDACATALOGOERP'].value='';
		}

        // Nuevo campo:EMP_LIC_OCULTARTITULO
		if ((!errores) && (document.forms[0].elements['EMP_LIC_OCULTARTITULO_CHK'])){
			if(document.forms[0].elements['EMP_LIC_OCULTARTITULO_CHK'].checked==true){
				document.forms[0].elements['EMP_LIC_OCULTARTITULO'].value='on';
            }
			else
				document.forms[0].elements['EMP_LIC_OCULTARTITULO'].value='';
		}

        // Nuevo campo:EMP_LIC_MOSTRARAUTOR
		if ((!errores) && (document.forms[0].elements['EMP_LIC_MOSTRARAUTOR_CHK'])){
			if(document.forms[0].elements['EMP_LIC_MOSTRARAUTOR_CHK'].checked==true){
				document.forms[0].elements['EMP_LIC_MOSTRARAUTOR'].value='on';
            }
			else
				document.forms[0].elements['EMP_LIC_MOSTRARAUTOR'].value='';
		}

        // Nuevo campo:EMP_LIC_COMPRADORINFOFERTAS
		if ((!errores) && (document.forms[0].elements['EMP_LIC_COMPRADORINFOFERTAS_CHK'])){
			if(document.forms[0].elements['EMP_LIC_COMPRADORINFOFERTAS_CHK'].checked==true){
				document.forms[0].elements['EMP_LIC_COMPRADORINFOFERTAS'].value='on';
            }
			else
				document.forms[0].elements['EMP_LIC_COMPRADORINFOFERTAS'].value='';
		}

        // Nuevo campo:EMP_LIC_ADJUDICADOSAOFERTA
		if ((!errores) && (document.forms[0].elements['EMP_LIC_ADJUDICADOSAOFERTA_CHK'])){
			if(document.forms[0].elements['EMP_LIC_ADJUDICADOSAOFERTA_CHK'].checked==true){
				document.forms[0].elements['EMP_LIC_ADJUDICADOSAOFERTA'].value='on';
            }
			else
				document.forms[0].elements['EMP_LIC_ADJUDICADOSAOFERTA'].value='';
		}

        // Nuevo campo:EMP_OBLIGARPEDIDOSCOMPLETOS
		if ((!errores) && (document.forms[0].elements['EMP_PED_SALTARPEDIDOMINIMO_CHK'])){
			if(document.forms[0].elements['EMP_PED_SALTARPEDIDOMINIMO_CHK'].checked==true){
				document.forms[0].elements['EMP_PED_SALTARPEDIDOMINIMO'].value='on';
            }
			else
				document.forms[0].elements['EMP_PED_SALTARPEDIDOMINIMO'].value='';
		}

        // Nuevo campo:EMP_OBLIGARPEDIDOSCOMPLETOS
		if ((!errores) && (document.forms[0].elements['EMP_OBLIGARPEDIDOSCOMPLETOS_CHK'])){
			if(document.forms[0].elements['EMP_OBLIGARPEDIDOSCOMPLETOS_CHK'].checked==true){
				document.forms[0].elements['EMP_OBLIGARPEDIDOSCOMPLETOS'].value='on';
            }
			else
				document.forms[0].elements['EMP_OBLIGARPEDIDOSCOMPLETOS'].value='';
		}
		
		//console.log('EMP_INT_SOLOPEDIDOS:'+document.forms[0].elements['EMP_INT_SOLOPEDIDOS'].value);
		

        //18jul16 Nuevo campo:EMP_LICITACIONESAGREGADAS
		if ((!errores) && (document.forms[0].elements['EMP_LICITACIONESAGREGADAS_CHK'])){
			if(document.forms[0].elements['EMP_LICITACIONESAGREGADAS_CHK'].checked==true){
				document.forms[0].elements['EMP_LICITACIONESAGREGADAS'].value='on';
            }
			else
				document.forms[0].elements['EMP_LICITACIONESAGREGADAS'].value='';
		}

		//	14set11	Proveedor no navegable por defecto
		if((!errores) && (document.forms[0].elements['EMP_PROVNONAVEGARPORDEFECTO_CHK'])){
			if(document.forms[0].elements['EMP_PROVNONAVEGARPORDEFECTO_CHK'].checked==true)
				document.forms[0].elements['EMP_PROVNONAVEGARPORDEFECTO'].value='on';
			else
				document.forms[0].elements['EMP_PROVNONAVEGARPORDEFECTO'].value='';
		}

                //control que no pongan caracteres raros en los textos
                //cliente
                if(document.forms[0].elements['EMP_LIC_COND_ENTREGA'] && document.forms[0].elements['EMP_LIC_COND_PAGO'] && document.forms[0].elements['EMP_LIC_OTRAS_COND'] && document.forms[0].elements['EMP_DESCRIPCIONPEDIDOMINIMO'] && document.forms[0].elements['EMP_DESCRIPCIONCOSTETRANSPORTE']){
                    var inputText = [document.forms[0].elements['EMP_NOMBRE'].value,document.forms[0].elements['EMP_NOMBRE_CORTO'].value, document.forms[0].elements['EMP_DIRECCION'].value, document.forms[0].elements['EMP_POBLACION'].value,document.forms[0].elements['EMP_REFERENCIAS'].value,document.forms[0].elements['EMP_LIC_COND_ENTREGA'].value,document.forms[0].elements['EMP_LIC_COND_PAGO'].value, document.forms[0].elements['EMP_LIC_OTRAS_COND'].value,document.forms[0].elements['EMP_DESCRIPCIONPEDIDOMINIMO'].value,document.forms[0].elements['EMP_DESCRIPCIONCOSTETRANSPORTE'].value];
                }
                //proveedor
                else{
                        var inputText = [document.forms[0].elements['EMP_NOMBRE'].value,document.forms[0].elements['EMP_NOMBRE_CORTO'].value, document.forms[0].elements['EMP_DIRECCION'].value, document.forms[0].elements['EMP_POBLACION'].value,document.forms[0].elements['EMP_REFERENCIAS'].value];
                }


                //var k=checkRegEx(document.forms[0].elements['EMP_DIRECCION'].value, regex_car_raros); alert('k '+k);

                //var j=regex.test(document.forms[0].elements['EMP_DIRECCION'].value)
                for (var i=0;i<inputText.length;i++){
                //var f=checkRegEx(inputText[i], regex_car_raros); alert ('valor f '+f);
                    if(checkRegEx(inputText[i], regex_car_raros)){
                        //si true implica que si ha encontrado caracteres raros
                        //alert(document.forms['MensajeJS'].elements['CAR_RAROS'].value);
                        errores=1;
                        raros=1;
                    }
                    else { }
                }//fin for caracteres raros
                if (raros =='1') alert(document.forms['MensajeJS'].elements['CAR_RAROS'].value);

		if(!errores)
			return true;
		else
			return false;
	}


        function pedidoMinimo(nombre,form){
          if(nombre=="EMP_PEDMINIMOACTIVO_CHECK"){
            if(form.elements[nombre].checked==true){
              form.elements['EMP_PEDMINIMOESTRICTO_CHECK'].disabled=false;
              form.elements['EMP_PEDIDOMINIMO'].disabled=false;
              form.elements['EMP_PEDMINIMO_LOGISTICA'].disabled=false;
              form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].disabled=false;
            }
            else{
              form.elements['EMP_PEDMINIMOESTRICTO_CHECK'].checked=false;
              form.elements['EMP_PEDMINIMOESTRICTO_CHECK'].disabled=true;

              form.elements['EMP_PEDIDOMINIMO'].value='';
              form.elements['EMP_PEDIDOMINIMO'].disabled=true;

              form.elements['EMP_PEDMINIMO_LOGISTICA'].value='';
              form.elements['EMP_PEDMINIMO_LOGISTICA'].disabled=true;

              form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].value='';
              form.elements['EMP_DESCRIPCIONPEDIDOMINIMO'].disabled=true;
            }
          }

        }

        function habilitarDeshabiliarDesplegables(objChk,form,arrayNombreDesplegables){

          var chequeado;

          if(objChk.checked==true){
            chequeado=1;
          }
          else{
            chequeado=0;
          }
          for(var n=0;n<arrayNombreDesplegables.length;n++){
            if(chequeado){
              form.elements[arrayNombreDesplegables[n]].disabled=false;
            }
            else{
              form.elements[arrayNombreDesplegables[n]].disabled=true;
            }
          }
        }

        function ModificarZonaComercial(idempresa, idcentro, idusuario){


        	var form=document.forms[0];


            var opciones='?IDEMPRESA='+idempresa+
                         '&IDCENTRO='+idcentro+
                         '&IDUSUARIO='+idusuario;


            MostrarPag('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/ZonasComerciales.xsql'+opciones,'zonasComerciales');


        }

        function OcultarPrecioReferencia_Click()
		{
			var form=document.forms[0];

        	if (form.elements["EMP_OCULTARPRECIOREF_CHK"].checked==true)
			{
				form.elements["EMP_MOSTRARCOMISIONES_NM_CHK"].disabled=false;
				form.elements["EMP_MOSTRARCOMISIONES_NM_CHK"].checked=true;
			}
			else
			{
				form.elements["EMP_MOSTRARCOMISIONES_NM_CHK"].disabled=true;
				form.elements["EMP_MOSTRARCOMISIONES_NM_CHK"].checked=false;
			}
		}




// IMAGE UPLOAD       ----------------------------------------------------------
var IMG_WIDTH = 200;
var IMG_HEIGHT = 200;
var IMG_SMALL_WIDTH = 50;
var IMG_SMALL_HEIGHT = 50;
var MAX_WAIT = 30;
var numImages = 0;
var uploadFiles = new Array();
var periodicTimer = 0;
var imageCarga = '';
/**
 * Add new Line with remove button
 * @param {string} id Suffix of the element id
 * @return Boolean
 * @author Martin Gangkofer gangkofer@gmail.com
 */
 function hasFiles(form) {
	for (var i = 1; i < form.length; i++) {
		if (form.elements[i].type == 'file' && form.elements[i].value != '') {
			return true;
		}
	}
	return false;
}

function addFile(id) {
	//alert(id);

	var uploadElem = document.getElementById("inputFile_" + id);
	//alert('uploadelem '+uploadElem);
	if (uploadElem.value != '') {
		uploadFiles[uploadFiles.length] = uploadElem.value;
		if (!document.getElementById("inputLink_" + id)) {
			var rmLink = document.createElement('div');
			rmLink.setAttribute("class","remove");

			jQuery('Element').append(rmLink);
			rmLink.setAttribute('id', 'inputLink_' + id);
			rmLink.innerHTML = '<a href="javascript:removeFile(\'' + id + '\');">Remove</a>'
			//alert(document.getElementById("imageLine_" + id));
			document.getElementById("imageLine_" + id).appendChild(rmLink);
		}
	}
	else {
		uploadFiles.splice(id, 1);
		document.getElementById("imageLine_" + id).removeChild(document.getElementById("inputLink_" + id));
	}

	displayFiles();
	return true;
}

/**
 * Remove line with remove button
 * @param {string} id Suffix of the element id
 * @return Boolean
 * @author Martin Gangkofer gangkofer@gmail.com
 */

function removeFile(id) {
	var clearedInput;
	var uploadElem = document.getElementById("inputFile_" + id);

	uploadElem.value = '';
	clearedInput = uploadElem.cloneNode(false);
   uploadElem.parentNode.insertBefore(clearedInput, uploadElem);
   uploadElem.parentNode.removeChild(uploadElem);
	uploadFiles.splice(id, 1);
	document.getElementById("imageLine_" + id).removeChild(document.getElementById("inputLink_" + id));
	displayFiles();
	return undefined;
}

/**
 * Prepare image for removing
 * @param {string} fileId Database-ID of the image
 * @param {int} num Number of
 * @return Boolean
 * @author Martin Gangkofer gangkofer@gmail.com
 */
function deleteFile(fileId, num) {

	var uploadElem = document.getElementById("inputFile_" + num);
	var labelElem = document.getElementById("labelFile_" + num);
	var deleteChain = document.getElementsByName('IMAGENES_BORRADAS')[0].value;
	uploadElem.style.display = '';
	labelElem.style.display = '';
	uploadElem.value = '';
	deleteChain += fileId + '|S#';
	document.getElementsByName('IMAGENES_BORRADAS')[0].value = deleteChain;
	return false;
}

/**
 * Display new line for image
 * @return Boolean
 * @author Martin Gangkofer gangkofer@gmail.com
 */
function displayFiles() {
	for (var i = 1; i < 6; i++) {
		if (document.getElementById("inputFile_" + i) && document.getElementById("inputFile_" + i).value != '' && document.getElementById("imageLine_" + (1+i))) {
			document.getElementById("imageLine_" + (1+i)).style.display = '';
		}
	}
	return true;
}
/**
 * Check periodically if the image upload is finished
 * @return Boolean - true if filled file input found
 * @author Martin Gangkofer gangkofer@gmail.com
 */

function periodicUpdate(){
	if (periodicTimer >= MAX_WAIT) {
		alert("we waited " + MAX_WAIT + " seconds and the upload still did not finish, so we suspect sth. went wrong ;-)\n\nYou should press the stop button of your browser!\n");
		return false;
	}
	periodicTimer++;

	if (window.frames['uploadFrame'] && window.frames['uploadFrame'].document && window.frames['uploadFrame'].document.getElementsByTagName("p")[0]) {

		document.getElementById('waitBox').style.display = 'none';
		var uFrame = window.frames['uploadFrame'].document.getElementsByTagName("p")[0];
		if (uFrame.innerHTML.substr(0, 1) != '{' && uFrame.innerHTML.substr(0, 1) != '[') {
			alert("An undefined error occurred, please notify the admin");
			return false;
		}
		else {
			var response = eval('(' + uFrame.innerHTML + ')');
			handleFileRequest(response);
			return true;
		}
	}
	else {
		window.setTimeout(periodicUpdate,1000);
		return false;
	}
	return true;
}

/**
 * handle Request after file (or image) upload
 * @param {Array} resp Hopefully JSON string array
 * @return Boolean
 * @author Martin Gangkofer gangkofer@gmail.com
 */
function handleFileRequest(resp) {
	var lang = new String('');

	var form = document.forms['MantenEmpresa'];
	var msg = '';
	var msgHeader = 'Se ha producido errores en el upload de imagenes!<br /><br />';
	var target = '';
	var metodo = 'post';
	var enctype = 'multipart/form-data';
	var imageChain = new String('');
	var action = 'http://' + location.hostname + '/Administracion/Mantenimiento/Empresas/confirmCargaLogo.xsql';

	if(resp instanceof Array && resp.length > 0){
		for(var i = 0; i < resp.length; i++){
			if(resp[i].big && resp[i].small){
				var lungmax = resp[i].small.length;
				var lungmin = resp[i].small.length;
			}
		}
	}

	if(resp instanceof Array && resp.length > 0){
		for(var i = 0; i < resp.length; i++){
			if(resp[i].error && resp[i].error != ''){
				msg += resp[i].error;
			}else if(resp[i].big && resp[i].small){
				imageChain += 'mvm' + '|' + resp[i].small + '|' + resp[i].big + '#';
				var img_url = 'Fotos/'+resp[i].small;
			}
		}

		if(msg == ''){
			document.getElementsByName('CADENA_IMAGENES')[0].value = imageChain;
			form.encoding = enctype;
			form.action = action;
			form.target = target;
			var img_nombre = document.forms['MantenEmpresa'].elements['IMG_NOMBRE'].value;
			var id_empresa = document.forms['MantenEmpresa'].elements['IDEMPRESA'].value;

			jQuery.ajax({
				url:"confirmCargaLogo.xsql",
				data: "IDEMPRESA="+id_empresa+"&IMG_NOMBRE="+img_nombre+"&IMG_URL="+img_url,
	  			type: "GET",
				async: false,
				contentType: "application/xhtml+xml",
				beforeSend:function(){
					document.getElementById('confirmBox').style.display = 'none';
					document.getElementById('waitBox').src = 'http://www.newco.dev.br/images/loading.gif';
				},
				error:function(objeto, quepaso, otroobj){
					alert("objeto:"+objeto);
					alert("otroobj:"+otroobj);
					alert("quepaso:"+quepaso);
				},
				success:function(objeto){
					var data = eval("(" + objeto + ")");

					if(data.CargaLogo.estado == 'OK'){
						var IDLogo = data.CargaLogo.id;
					}

					document.getElementById('confirmBox').style.display = 'block';
					//reinicializo los campos del form
					document.forms['MantenEmpresa'].elements['inputFile_1'].value = '';
					document.forms['MantenEmpresa'].elements['IMG_NOMBRE'].value = '';
					document.getElementById('inputLink_1').style.display = 'none';

					uploadFrame.document.getElementsByTagName("p")[0].innerHTML = '';
					uploadFrame.document.getElementsByTagName("body")[0].innerHTML = "";

					//recargamos los logos
					//SeleccionaLogos('lista',id_empresa);
					//Seleccionamos el logo previamente subido dejando tiempo para recargar el select de los logos
					setTimeout(function(){
						jQuery('#IDLOGOTIPO').val(IDLogo);
					},1000);
				}
			});
		}
	}else if(resp.length < 1){
		msg += "Parece que tus ficheros son demasiados grandes.<br />";
	}else{
		msg += "Se ha producido un error.<br />";
	}

	if(msg != ''){
		msg = msgHeader + msg;
		return false;
	}

	return true;
}


function wait(text) {
	//aparece el loading arriba en messageError

	jQuery('#waitBox').html ('<img src="http://www.newco.dev.br/images/loading.gif" />');
	if (jQuery('#ocultoButton')) jQuery('#ocultoButton').hide();
	jQuery('#waitBox').show();
	return false;
}

//function para cargar imagenes en proveedor, una imagen varios productos
function CargarImagen(formu){
	var msg = '';

	if(formu.elements['IMG_NOMBRE'].value != '' && formu.elements['inputFile_1'].value != ''){
		if(hasFiles(formu)){
			var target = 'uploadFrame';
			var action = 'http://' + location.hostname + '/cgi-bin/imageMVM.pl';
			var enctype = 'multipart/form-data';

			formu.target = target;
			formu.encoding = enctype;
			formu.action = action;
			wait("Please wait...");
			formu.submit();
			form_tmp = formu;
			man_tmp = true;
			periodicTimer = 0;
			periodicUpdate();
		}//fin if si hay imagenes
	}else{
		if(document.forms['MantenEmpresa'].elements['IMG_NOMBRE'].value == '') msg += document.forms['MensajeJS'].elements['NOMBRE_LOGO_OBLI'].value+'\n';
		if(document.forms['MantenEmpresa'].elements['inputFile_1'].value == '') msg += document.forms['MensajeJS'].elements['LOGO_OBLI'].value;
		alert(msg);
	}
}//fin cargarImagenes

function DesactivarEmpresaEspecial(IDEmpresa){
	var d = new Date();

	jQuery.ajax({
		url:"DesactivarEmpresaEspecialAJAX.xsql",
		data: "EMP_ID="+IDEmpresa+"&_="+d.getTime(),
		type: "GET",
		async: false,
		contentType: "application/xhtml+xml",
		beforeSend:function(){
			null;
		},
		error:function(objeto, quepaso, otroobj){
			alert("objeto:"+objeto);
			alert("otroobj:"+otroobj);
			alert("quepaso:"+quepaso);
		},
		success:function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.EmpresaEspecial.estado == 'OK'){
				jQuery("#AccionEmpEspecial").attr("href", "javascript:ActivarEmpresaEspecial("+IDEmpresa+");");
				jQuery("#AccionEmpEspecial").text(ActivarTXT);
				jQuery("#TextoEmpEspecial").html(InactivaEmpEspecialTXT + '&nbsp;');
			}else{
				alert('ERROR');
			}
		}
	});
}

function ActivarEmpresaEspecial(IDEmpresa){
	var d = new Date();

	jQuery.ajax({
		url:"ActivarEmpresaEspecialAJAX.xsql",
		data: "EMP_ID="+IDEmpresa+"&_="+d.getTime(),
		type: "GET",
		async: false,
		contentType: "application/xhtml+xml",
		beforeSend:function(){
			null;
		},
		error:function(objeto, quepaso, otroobj){
			alert("objeto:"+objeto);
			alert("otroobj:"+otroobj);
			alert("quepaso:"+quepaso);
		},
		success:function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.EmpresaEspecial.estado == 'OK'){
				jQuery("#AccionEmpEspecial").attr("href", "javascript:DesactivarEmpresaEspecial("+IDEmpresa+");");
				jQuery("#AccionEmpEspecial").text(DesactivarTXT);
				jQuery("#TextoEmpEspecial").html(ActivaEmpEspecialTXT + '&nbsp;');
			}else{
				alert('ERROR');
			}
		}
	});
}

function IncluirEmpresaEspecial(IDEmpresa){
	var d = new Date();

        //alert(document.forms['MantenEmpresa'].elements['EMP_NOMBRE_CORTO'].value);
        if (document.forms['MantenEmpresa'].elements['EMP_NOMBRE_CORTO'].value != ''){

	jQuery.ajax({
		url:"IncluirEmpresaEspecialAJAX.xsql",
		data: "EMP_ID="+IDEmpresa+"&_="+d.getTime(),
		type: "GET",
		async: false,
		contentType: "application/xhtml+xml",
		beforeSend:function(){
			null;
		},
		error:function(objeto, quepaso, otroobj){
			alert("objeto:"+objeto);
			alert("otroobj:"+otroobj);
			alert("quepaso:"+quepaso);
		},
		success:function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.EmpresaEspecial.estado == 'OK'){
				jQuery("#AccionEmpEspecial").attr("href", "javascript:DesactivarEmpresaEspecial("+IDEmpresa+");");
				jQuery("#AccionEmpEspecial").text(DesactivarTXT);
				jQuery("#TextoEmpEspecial").html(ActivaEmpEspecialTXT + '&nbsp;');
			}else{
				alert('ERROR');
			}
		}
	});
    }
    else{
        alert(document.forms['MensajeJS'].elements['RELLENAR_NOMBRE_CORTO'].value);
    }
}
