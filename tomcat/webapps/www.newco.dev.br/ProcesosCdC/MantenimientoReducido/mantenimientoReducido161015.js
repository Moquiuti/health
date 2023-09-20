//	rev.mc 30-1-14 11:30
jQuery(document).ready(globalEvents);
// JavaScript Document
function globalEvents(){
  jQuery(".menuGestion th.oneMenuGestion").mouseover(function(){this.style.cursor="pointer";});
	jQuery(".menuGestion th.oneMenuGestion").mouseout(function(){this.style.cursor="default";});
  jQuery(".menuGestion th.oneMenuGestion").click(function(){
    jQuery(".oneMenuGestion").css('background','#E3E2E2');
    jQuery(this).css('background','#C3D2E9');

    var id = jQuery(this).attr('id');
    jQuery(".grandeInicio").hide();
    jQuery("#"+id+"Box").show();
	});
}

// variable "cambiosPendientes" de tipo flag que contiene info acerca de si se ha hecho alguna modificacion en la pagina
// es util para avisar al usuario de que debe proporcionar comentarios en el caso de haber tocado algo
//	y tambien a la hora de emplantillar productos, estos no se pueden emplantillar si hay cambios pendientes
//var cambiosPendientes=0;

//ver que los datos se han guardado con exito
function datosExito(){
	if (document.getElementById('exito') && document.getElementById('exito').style.display != 'none'){
		document.getElementById('exito').style.display = 'none';
		}
}

//cambiar de cliente
function CambioCliente(IDCliente){
  var IDProducto = document.forms.form1.elements.IDPRODUCTO.value;
  location.href="http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducido.xsql?PRO_ID=" + IDProducto + "&EMP_ID=" + IDCliente;
}

//cambiar fecha limite
function cambiaFecha(){
  var form = document.forms.form1;
	form.method = 'post';
  var fechaLimite = 'FECHA_LIMITE';
  var enviarFechaLimite = 'EnviarFecha';
  var modificarFechaLimite = 'ModificaFecha';

  form.elements[fechaLimite].setAttribute('class','');
  jQuery("#"+modificarFechaLimite).hide();
  jQuery("#"+enviarFechaLimite).show();
}

//actualizarFechaLimite funcion de la pagina actualizarFechaLimite
function actualizarFechaLimite(){
	var form = document.forms['form1'];
	form.method = 'post';
	var msg = '';
	var idProd = form.elements['IDPRODUCTO'].value;
	var idCliente = form.elements['CLIENTE_ID'].value;
	var valueFechaLimite = form.elements['FECHA_LIMITE'].value;
	var errorFechaLimite = document.forms['MensajeJS'].elements['ERROR_GUARDAR_FECHA'].value;
	var fechaLimite = 'FECHA_LIMITE';
	var enviarFechaLimite = 'EnviarFecha';
	var modificarFechaLimite = 'ModificaFecha';

	if(form.elements['FECHA_LIMITE'].value == ''){ msg += document.forms['MensajeJS'].elements['FECHA_LIMITE_OBLI'].value;}

	if (msg == ''){

				jQuery.ajax({
					cache:	false,
					url:	'http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ActualizarFechaLimiteCat.xsql',
					type:	"GET",
					data:	"PRO_ID="+idProd+"&CLIENTE_ID="+idCliente+"&FECHA_LIMITE="+valueFechaLimite,
					contentType: "application/xhtml+xml",
					success: function(objeto){
						var data = eval("(" + objeto + ")");

						if(data.ActualizarFechaLimite.estado == 'OK'){
							form.elements[fechaLimite].setAttribute('class','noinput');
							//form.elements[fechaLimite].setAttribute('disabled','disabled');
							jQuery("#"+modificarFechaLimite).show();
							jQuery("#"+enviarFechaLimite).hide();
						}
					},
					error: function(xhr, errorString, exception) {
						alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
					}
				});

				//form.action = "ActualizarFechaLimite.xsql?PRO_ID="+idProd+"&CLIENTE_ID="+idCliente+"&FECHA_LIMITE="+fechaLimite;
				//SubmitForm(form);

			}
			else { alert(msg);}

		}// fin de actualizarFechaLimite

//enviar solo comentario
function enviarComentarioMantRed(){
	var form = document.forms['form1'];

/*	var prod = form.elements['IDPRODUCTO'].value;
	var prov = form.elements['IDPROVEEDOR'].value;
	var entrHistTodPro = form.elements['ENTRADA_HISTORICO_TODOSPRODUCTOS'].value;
	var entrHist = form.elements['ENTRADA_HISTORICO'].value;*/

	form.action = 'guardarComentario.xsql';
	form.method = 'post';
	SubmitForm(form);

}




//	Comprobar si hay cambios que requieran guardarlos datos antes de ejecutar una acción
function HayCambiosPendientes(form,tipo)
{
	form.method = 'post';
    var hayCambios=0;
    var incluirComentarios=0;

    if(tipo=='cancelar')
	{
      	incluirComentarios=1;
    }


    for(var n=0;n<form.length;n++)
	{
      	if(form.elements[n].name.substring(0,7)=='BACKUP_')
		{
      		var nombreElemento=form.elements[n].name.substring(7,form.elements[n].name.length);
      		var nombreElementoBackup=form.elements[n].name;

      		if(form.elements[nombreElemento].type=='checkbox')
			{
      			var valor='';
      			if(form.elements[nombreElemento].checked==true)
				{
      				valor='true';
      			}
      			else{
      				valor='false';
      			}
      			if(valor!=form.elements[nombreElementoBackup].value)
				{
					//alert('Ha cambiado '+nombreElemento+':'+form.elements[nombreElementoBackup].value)
      				hayCambios=1;
      			}
      		}
      		else
			{
      			if(tipo=='insertar')
				{
      				if(form.elements[nombreElemento].name!='DERECHOS_PLANTILLAS')
					{
      					if(form.elements[nombreElemento].value!=form.elements[nombreElementoBackup].value)
						{
							//alert('Ha cambiado '+nombreElemento+':'+form.elements[nombreElemento].value+' antes:'+form.elements[nombreElementoBackup].value)
      						hayCambios=1;
      					}
      				}
      			}
      			else
				{
      				if(form.elements[nombreElemento].value!=form.elements[nombreElementoBackup].value)
					{
						//alert('Ha cambiado '+nombreElemento+':'+form.elements[nombreElemento].value+' antes:'+form.elements[nombreElementoBackup].value)
      					hayCambios=1;
      				}
      			}
      		}
      	}
    }

    if(tipo=='guardar')
	{
      	hayCambios=0;
    }

    return hayCambios;

	return 0;
}

function esRecatalogacion(form){
    if(form.elements['REFERENCIACLIENTE'].value!=form.elements['BACKUP_REFERENCIACLIENTE'].value && form.elements['BACKUP_REFERENCIACLIENTE'].value!='' && form.elements['IDPRODUCTOESTANDAR'].value!='' && form.elements['REFERENCIACLIENTE'].value!=''){
      	return 1;
    }
    else{
      	return 0;
    }
}

function esDescatalogacion(form){
    if(form.elements['REFERENCIACLIENTE'].value!=form.elements['BACKUP_REFERENCIACLIENTE'].value && form.elements['BACKUP_REFERENCIACLIENTE'].value!='' && form.elements['IDPRODUCTOESTANDAR'].value!='' && form.elements['REFERENCIACLIENTE'].value==''){
      	return 1;
    }
    else{
      	return 0;
    }
}




function calcularTodosAhorros(form){
	form.method = 'post';
    for(var n=0;n<form.length;n++){
      	if(form.elements[n].name.substring(0,17)=='PRECIOREFERENCIA_' && form.elements[n].name.substring(0,30)!='PRECIOREFERENCIA_SINHISTORICO_'){
      		calcularAhorro(form,form.elements[n]);
      	}
    }
}

function calcularAhorro(form,obj)
{
	form.method = 'post';
    var idElemento=obtenerId(obj.name);

    if(form.elements['PRECIO'].value!='' && ValidarNumeroSinMensaje(form.elements['PRECIO'],4))
	{
      	var precio=reemplazaComaPorPunto(form.elements['PRECIO'].value);

		//form.elements['PRECIOCON20PORCIENTO'].value=anyadirCerosDecimales(reemplazaPuntoPorComa(Round(precio/0.8,4)),4);
		form.elements['PRECIOCONMARGENPORDEFECTO'].value=Convierte(CalculaPrecioConMargenPorDefecto(form, precio));

		if(obj.value!='' && ValidarNumeroSinMensaje(obj,4))
		{
      		var precioHist=reemplazaComaPorPunto(obj.value);
      		var ahorro=(precioHist-precio)/precioHist*100;

			form.elements['AHORRO_'+idElemento].value=anyadirCerosDecimales(reemplazaPuntoPorComa(Round(ahorro,2)),2);

			//	15nov10 MARGEN BRUTO
			var PrecioFinal=parseFloat(reemplazaComaPorPunto(form.elements['PRECIOFINAL_'+idElemento].value));
			var IVAprod=parseFloat(reemplazaComaPorPunto(form.elements['TIPO_IVA_PRODUCTO'].value));
			var PrecioConIVA=precio*(1+IVAprod/100);

			if (PrecioConIVA>0)
				var margenBruto=100*(PrecioFinal-PrecioConIVA)/PrecioConIVA;
			else
				var margenBruto=0;

			form.elements['MARGENBRUTO_'+idElemento].value=anyadirCerosDecimales(reemplazaPuntoPorComa(Round(margenBruto,2)),2);

      	}
      	else{
      		form.elements['AHORRO_'+idElemento].value='?';
      	}
    }
    else{
      	form.elements['AHORRO_'+idElemento].value='?';
		//form.elements['PRECIOCON20PORCIENTO'].value='';
		form.elements['PRECIOCONMARGENPORDEFECTO'].value='';
    }
}


// ---------------- I M P O R T A N T E ------------------

//eliminar de plantillas 20-07-11 MC
function QuitarDeLaPlantilla(empresa, producto){

	var form = document.forms['form1'];

	form.elements['ACTION'].value = 'BORRAR';
	form.elements['ID_PRODUCTO'].value = producto;
	form.elements['ID_EMPRESA'].value = empresa;

	form.method = 'post';
	form.action='http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducido.xsql?PRO_ID='+producto+'&ACTION=BORRAR&EMP_ID='+empresa;
    SubmitForm(form);
}


function InsertarEnLaPlantilla(form){
	form.method = 'post';

    if(form.elements['IDPRODUCTOESTANDAR'].value==''){
        alert(document.forms['MensajeJS'].elements['GUARDAR_CAMBIOS_CATALOGACION'].value);
    }
    else{
        if(HayCambiosPendientes(form,'insertar')){
        	alert(document.forms['MensajeJS'].elements['GUARDAR_CAMBIOS_CATALOGACION'].value);
        }
        else{
        	if(form.elements['ADJUDICADO'].checked==true){
        		form.action='MantenimientoReducidoPlantillasSave.xsql';
        		SubmitForm(form);
        	}
        	else{
        		alert(document.forms['MensajeJS'].elements['PROD_NO_ADJUDICADO'].value);
        	}
        }
    }
}

//mostrar catalogo privado producto empresa
function MostrarCatalogoPrivadoProductoEmpresa(form){
	form.method = 'post';
	var ref_prod = form.elements['REFERENCIACLIENTE'].value;
	var idEmpresa = form.elements['IDEMPRESA'].value;

	MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoPrivadoProductoEmpresa.xsql?IDEMPRESA='+idEmpresa+'&REFERENCIA='+ref_prod,'producto',60,50,-30,800);

}

//MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoPrivadoProductoEmpresa.xsql?IDEMPRESA={/Mantenimiento/MANTENIMIENTO/CLIENTE/IDEMPRESA}&amp;PRO_REF={/Mantenimiento/MANTENIMIENTO/CLIENTE/REFERENCIA}','producto',60,50,-30,800);">

 //function Comprobar Referencia proceso Ajax ANTES de hacer la llamada a "GuardarCambiosCatalogacion" para comprobar que la ref. sea correcta 28-1-14
 //si todo va ok llamo a GuardarCambiosCatalogacion
         function ComprobarReferencia(form){
             jQuery('#botonGuardar').hide();

     			var idEmpresa = form.elements['IDEMPRESA'].value;
				var idPro = form.elements['IDPRODUCTO'].value;
				var refMVM = form.elements['REFERENCIACLIENTE'].value;
				var idProStd = form.elements['IDPRODUCTOESTANDAR'].value;

                    jQuery.ajax({
                    cache:	false,
                    url:	'ComprobarReferencia.xsql',
                    type:	"GET",
                    data:	"EMP_ID="+idEmpresa+"&PRO_ID="+idPro+"&REF_MVM="+refMVM+"&IDPRODUCTOESTANDAR="+idProStd,
                    contentType: "application/xhtml+xml",
                    error: function(objeto, quepaso, otroobj){
                        alert('error'+quepaso+' '+otroobj+''+objeto);
                    },
                    success: function(objeto){
                        var data = eval("(" + objeto + ")");

            		    if(data.ComprobarReferencia.estado == 'OK'){
							//alert('mi '+data.ComprobarReferencia.estado);
							GuardarCambiosCatalogacion(form);
                        }else{
                            alert('Error: '+data.ComprobarReferencia.estado);
                            jQuery('#botonGuardar').show();
                        }
                    }
                    });//fin jquery

            }//fin de ComprobarReferencia


function GuardarCambiosCatalogacion(form){
	form.action = 'MantenimientoReducidoSave.xsql';
	form.method = "post";


    if(ValidarFormulario(form)){

        // preparamos los datos entes de enviarlo
        //hay que preparar la lista de precios de referencia

        var IDEmpresa=form.elements['IDEMPRESA'].value;
        var TipoAhorro=form.elements['ORIGEN_PRECIOREF'].value;
        var separadorCampos='|';
        var separadorRegistros='#';
        var lista='';

		/*	24oxt12	Ya no trabajamos con centros
        for (var n=0;n<form.elements.length;n++){
        	if(form.elements[n].name.substring(0,17)=='PRECIOREFERENCIA_' && form.elements[n].name.substring(0,30)!='PRECIOREFERENCIA_SINHISTORICO_'){

        		var idCentro=obtenerId(form.elements[n].name);
        		var precioRef=form.elements['PRECIOREFERENCIA_'+idCentro].value;
        		var idHistorico=form.elements['IDHISTORICO_'+idCentro].value;
        		var proveedorAnterior=form.elements['PROVEEDORANTERIOR_'+idCentro].value;
        		var precioRef_sinHist='';

        		if(form.elements['PRECIOREFERENCIA_SINHISTORICO_'+idCentro].checked==true){
        			precioRef_sinHist='S';
        		}
        		else{
        			precioRef_sinHist='N';
        		}


        		// formato:	idcentro|tipoAhorro|idHistorico|precioRef|precioRef_sinHist|proveedorAnterior#
        		lista+=idCentro+separadorCampos+TipoAhorro+separadorCampos+idHistorico+separadorCampos+precioRef+separadorCampos+precioRef_sinHist+separadorCampos+proveedorAnterior+separadorRegistros;
        	}
        }*/

        var precioRef=form.elements['PRECIOREFERENCIA_'+IDEmpresa].value;
		lista=IDEmpresa+separadorCampos+TipoAhorro+separadorCampos+''+separadorCampos+precioRef+separadorCampos+'S'+separadorCampos+''+separadorRegistros;


        form.elements['LISTA_PRECIOREFERENCIA'].value=lista;

		if(HayCambiosPendientes(form,'guardar')){
			alert(document.forms['MensajeJS'].elements['INTRODUZCA_COMENTARIOS'].value);
                        jQuery('#botonGuardar').show();
		}
		else{
        	// enviamos el formulario
        	if(esRecatalogacion(form)){
        		if(confirm(document.forms['MensajeJS'].elements['CAMBIOS_CATALOGACION'].value)){
        			if(form.elements['IDEMPRESA'].value==1 && form.elements['EXPANDIR'].checked==true){
        				if(confirm(document.forms['MensajeJS'].elements['EXPANSION'].value)){
        					form.action='MantenimientoReducidoSave.xsql';
        					SubmitForm(form);

                                                if (form.elements['ORIGEN'].value=='SOLICITUD'){
                                                        window.opener.location.reload();
                                                        window.close();
                                                    }
        				}
        			}
        			else{
        				form.action='MantenimientoReducidoSave.xsql';
        				SubmitForm(form);
                                        if (form.elements['ORIGEN'].value=='SOLICITUD'){
                                                        window.opener.location.reload();
                                                        window.close();
                                                    }
        			}
        		}
        	}
        	else{
        		if(esDescatalogacion(form)){
        			form.action='MantenimientoReducidoDescatalogarSave.xsql';
        			SubmitForm(form);
                                if (form.elements['ORIGEN'].value=='SOLICITUD'){
                                    if (form.elements['ORIGEN'].value=='SOLICITUD'){
                                                        window.opener.location.reload();
                                                        window.close();
                                                    }
                                }
        		}
        		else{
        			if(form.elements['IDEMPRESA'].value==1 && form.elements['EXPANDIR'].checked==true){
        				if(confirm(document.forms['MensajeJS'].elements['EXPANSION'].value)){
        					form.action='MantenimientoReducidoSave.xsql';
        					SubmitForm(form);
                                                if (form.elements['ORIGEN'].value=='SOLICITUD'){
                                                        window.opener.location.reload();
                                                        window.close();
                                                    }
        				}
        			}
        			else{
                                     //alert('5');

                                            form.action='MantenimientoReducidoSave.xsql';
                                            SubmitForm(form);
                                            if (form.elements['ORIGEN'].value=='SOLICITUD'){
                                                        window.opener.location.reload();
                                                        window.close();
                                                    }

        			}
        		}
        	}
        }
    }
}
//catalogaci�n con ajax
function catalogacionAjax(form, lista){

    var idEmpresa = form.elements['IDEMPRESA'].value;
    var idProd = form.elements['IDPRODUCTO'].value;
    var refCliente = form.elements['REFERENCIACLIENTE'].value;
    var precio = form.elements['PRECIO'].value;
    var expandir = '';
    var listaPrecioRef = lista;
    var comentarios = '';
    var derechosPlantillas = form.elements['DERECHOS_PLANTILLAS'].value;
    var precioExclusivo = '';




    jQuery.ajax({
					cache:	false,
					url:	'http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducidoSaveAJAX.xsql',
					type:	"GET",
					data:	"IDEMPRESA="+idEmpresa+"&IDPRODUCTO="+idProd+"&REFERENCIACLIENTE="+refCliente+"&PRECIO="+precio+"&EXPANDIR="+expandir+"&LISTA_PRECIOREFERENCIA="+listaPrecioRef+"&COMENTARIOS="+comentarios+"&DERECHOS_PLANTILLAS="+derechosPlantillas+"&PRECIO_EXCLUSIVO="+precioExclusivo,
					contentType: "application/xhtml+xml",
					success: function(objeto){
						var data = eval("(" + objeto + ")");

						if(data.Resultado.Estado == 'OK'){
                                                       window.opener.location.reload();
                                                       window.close();
						}
					},
					error: function(xhr, errorString, exception) {
						alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
					}
				});

}


function ValidarFormulario(form){

    var errores=0;

    // validamos la ref estandar
    if((!errores) && esNulo(form.elements['REFERENCIACLIENTE'].value)){
        if(esNulo(form.elements['IDPRODUCTOESTANDAR'].value)){
        	alert(document.forms['MensajeJS'].elements['PROPORCIONAR_REF_ESTANDAR'].value);
        	form.elements['REFERENCIACLIENTE'].focus();
        	errores++;
        }
        else{
        	if(confirm(document.forms['MensajeJS'].elements['DESCATALOGAR'].value)){
        		form.action='MantenimientoReducidoDescatalogarSave.xsql';
        		return 1;
        	}
        	else{
        		return 0;
        	}
        }
    }

    // validamos el precio (obligatorio)
    if((!errores) && esNulo(form.elements['PRECIO'].value)){
        alert(document.forms['MensajeJS'].elements['PROPORCIONAR_PRECIO'].value);
        errores++;
    }
    else{
        if((!errores) && !ValidarNumero(form.elements['PRECIO'],4)){
        	form.elements['PRECIO'].focus();
        	errores++;
        }
    }

    // validamos el precio de referencia (opcional) para cada uno que aparezca
    for (var n=0;n<form.elements.length && !errores;n++){
        if(form.elements[n].name.substring(0,17)=='PRECIOREFERENCIA_' && form.elements[n].name.substring(0,30)!='PRECIOREFERENCIA_SINHISTORICO_'){
        	if(!ValidarNumero(form.elements[n],4)){
        		form.elements[n].focus();
        		errores++;
        	}
        }
    }
    //si cambian el precio de ref avisamos que el precio de referencia viene de db 27-5-15
    var precioRef = 'PRECIOREFERENCIA_'+form.elements['IDEMPRESA'].value;
    var precioRefBackup = 'BACKUP_PRECIOREFERENCIA_'+form.elements['IDEMPRESA'].value;

    if (form.elements[precioRef].value != form.elements[precioRefBackup].value){

        if ( (form.elements['HISTORICOSPORCENTRO'].value == 'S' && form.elements['PRECIO_REFERENCIA_ORIGINAL_CLIENTE'].value == 'S') || form.elements['HISTORICOSPORCENTRO'].value == 'S'){
            if ( (confirm(document.forms['MensajeJS'].elements['PRECIO_REF_HISTORICOS_SEGURO_MODIFICAR'].value)) == true) {
                return true;
            } else {
                return false;
            }
        }
        if (form.elements['PRECIO_REFERENCIA_ORIGINAL_CLIENTE'].value == 'S'){
            if ( (confirm(document.forms['MensajeJS'].elements['PRECIO_REF_ORIGINAL_SEGURO_MODIFICAR'].value)) == true) {
                return true;
            } else {
                return false;
            }
        }
    }//fin if si precio ref modificado

    if(!errores){
        return 1;
    }
    else{
        return 0;
    }
}


function checkNumberNuloSinMensaje(valor,obj)
{

var checkString=String(valor);
var newString = "";
coma=0;
punto=0;


if(checkString==''){
	return true;
}
else{
	for (var i = 0; i < checkString.length; i++){
	ch = checkString.substring(i, i+1);
	    if (ch >= '0' && ch <= '9'){
	        newString += ch;
	    }
	    else{
	        if(ch == "."){
	        punto++;
	        if(punto==1){
	            newString += '.';
	        }
	        }
	        else{
	        if(ch == ","){
	            if(coma==0){
	            newString += '.';
	            coma=1;
	            }
	            else{
	            return false;
	            }
	        }
	        else{
	            return false;
	        }
	        }
	    }
	    }
	    if (punto>0){
	    newStringFormateado=FormateaVis(newString);
	    objeto.value=newStringFormateado;
	    return true;
	    }
	    else{
	    return true;
	    }
	}
}


function ValidarNumeroSinMensaje(obj,decimales)
{

	if(checkNumberNuloSinMensaje(obj.value,obj)){
    	if(parseFloat(reemplazaComaPorPunto(obj.value))!=0){
    	obj.value=anyadirCerosDecimales(reemplazaPuntoPorComa(Round(reemplazaComaPorPunto(obj.value),decimales)),decimales);
    	}
    	return 1;
	}
	else{
    	return 0;
	}
}

function ValidarNumero(obj,decimales)
{
	if(checkNumberNulo(obj.value,obj)){
    	if(parseFloat(reemplazaComaPorPunto(obj.value))!=0){
    	obj.value=anyadirCerosDecimales(reemplazaPuntoPorComa(Round(reemplazaComaPorPunto(obj.value),decimales)),decimales);
    	}
    	return 1;
	}
	else{
    	return 0;
	}
}

function EjecutarFuncionDelFrame(nombreFrame,nombreFuncion){
	var objFrame=new Object();
	objFrame=obtenerFrame(window.opener.top, nombreFrame);

			eval('objFrame.'+nombreFuncion);

	}

	function DerechosPlantillas(form){
			form.method = 'post';
	    	// sitodavia no hemos adjudicado, no mostramos los derechos
	    	if(form.elements['IDPRODUCTOESTANDAR'].value==''){
	    		alert(document.forms['MensajeJS'].elements['GUARDAR_CAMBIOS_CATALOGACION'].value);
	    	}
	    	else{

        	var idempresa=form.elements['IDEMPRESA'].value;
        	var separadorCampos='|';
        	var separadorRegistros='#';
        	var lista='';

        	var contPlantilla=0;

        	for (var n=0;n<form.elements.length;n++){
        		if(form.elements[n].name.substring(0,10)=='PLANTILLA_'){

        			var idPlantilla=obtenerId(form.elements[n].name);

        			// formato:	idempresa|idPlantilla#
        			lista+=idempresa+separadorCampos+idPlantilla+separadorRegistros;

        			contPlantilla++;
        		}
        	}

        	while(contPlantilla<2){
        		lista+=idempresa+separadorCampos+'-1'+separadorRegistros;
        		contPlantilla++;
        	}

        	form.elements['LISTA_PLANTILLAS'].value=lista;
        	var idProducto=form.elements['IDPRODUCTO'].value


        	MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducidoDerechos.xsql?IDPRODUCTO='+idProducto+'&LISTA_PLANTILLAS='+lista,'DerechoALasPlantillas',80,50,0,-50);
        }
	}

	function asignarDerechosPlantillas(derechos){
	    document.forms['form1'].elements['DERECHOS_PLANTILLAS'].value=derechos;
	}

	function obtenerDerechosPlantillas(){
	    return document.forms['form1'].elements['DERECHOS_PLANTILLAS'].value;
	}

	function CerrarVentana(form){
	    if(HayCambiosPendientes(form,'cancelar')){
	    	if(confirm(document.forms['MensajeJS'].elements['CAMBIOS_GUARDARLOS'].value)){
	    		GuardarCambiosCatalogacion(form);
				alert('Cambios guardados');
				window.close();
	    	}
			else{
                                window.close(); }
	    }
	    else{
	    	window.close();
	    }
	}

	function HabilitarDeshabilitarCheck(form,objText,prefijo,infijo,sufijo){
		//alert(prefijo+infijo+sufijo);
	    if(objText.value==''){
	    	form.elements[prefijo+infijo+sufijo].checked=false;
	    	form.elements[prefijo+infijo+sufijo].disabled=true;
	    }
	    else{
	    	form.elements[prefijo+infijo+sufijo].disabled=false;
	    }
	}


	function blurPrecio(){
	    document.forms['form1'].elements['PRECIO'].blur();
	}

	function ExpandirNOExpandir(form,obj,origen)
	{
		form.method = 'post';
		//alert(origen+' '+form.elements['PRECIO_MVM'].value);

		if(obj.checked==false){
			//form.elements['PRECIO'].disabled=false;
			form.elements['PRECIO'].className='normal';
	    form.elements['PRECIO'].onfocus='';
			if(origen=='MVM'){
				form.elements['PRECIO'].value=form.elements['BACKUP_PRECIO'].value;
			}
			else{
				form.elements['PRECIO'].value=form.elements['PRECIO_HISTORICO'].value;
			}
		}
		else{
			//form.elements['PRECIO'].disabled=true;
			//form.elements['PRECIO'].className='deshabilitado';
	    form.elements['PRECIO'].onfocus=blurPrecio;
			if(origen=='MVM'){
				form.elements['PRECIO'].value=form.elements['PRECIO_MVM'].value;
			}
			else{
				form.elements['PRECIO'].value=form.elements['BACKUP_PRECIO'].value;
			}
		}
	}


	/*	24oct12	Ya no trabajamos sobre el precio te�rico sino sobre el margen
	//	Copia el precio teórico como precio de referencia a todos los centros
	function CopiarPrecioTeoricoATodosLosCentros(form)
	{
		var Precio=form.elements['PRECIOCON20PORCIENTO'].value;
		var Teorico='Si';
		CopiarPrecioYTeoricoATodosLosCentros(form, Precio, Teorico);
	}


	//	Copia el precio de referencia de un centro a todos los centros
	function CopiarPrecioYTeoricoATodosLosCentros(form, Precio, Teorico)
	{
		var Msg='';
		//3jun08	Alf pide no comprobar if (confirm('Desea sustituir el precio de referencia en todos los centros por '+Precio+' y poner el campo "Precio sin históricos" a: '+Teorico))
		//{
			for (j=0;j<form.elements.length;j++)
			{
				var Cadena=form.elements[j].name;
				if(Cadena.substring(0,17)=='PRECIOREFERENCIA_')
				{
					var IDCentro=Piece(Cadena,'_',1);
					if (IDCentro!='SINHISTORICO')
					{
						form.elements['PRECIOREFERENCIA_'+IDCentro].value=Precio;
						if (Teorico=='Si')
							form.elements['PRECIOREFERENCIA_SINHISTORICO_'+IDCentro].checked=true;
						else
							form.elements['PRECIOREFERENCIA_SINHISTORICO_'+IDCentro].checked=false;
					}
				}
			}
			CalcularPrecioFinal(form);
		//}
	}
	*/

	//	Copia el precio con margen 5% como precio de referencia a todos los centros
	function CopiarPrecioConMargenPorDefecto(form)
	{
		form.method = 'post';
                var IDEmpresa=form.elements['IDEMPRESA'].value;
		var PrecioFinal=form.elements['PRECIOCONMARGENPORDEFECTO'].value;
                //alert('precio final '+PrecioFinal);

		form.elements['PRECIOFINAL_'+IDEmpresa].value=PrecioFinal;

		cambiosAPartirDePrecioFinal(form,IDEmpresa);
	}




	//	Copia el precio teórico como precio de refrencia a todos los centros
	function CopiarPrecioProducto(form, Precio)
	{
		form.method = 'post';
		//3jun08	Alf pide no comprobar if (confirm('Desea sustituir el precio de este producto para este cliente por '+Precio))
		//{
		form.elements['PRECIO'].value=Precio;

		var PrecioConMargen=reemplazaComaPorPunto(Precio)/0.8;

		//form.elements['PRECIOCON20PORCIENTO'].value=anyadirCerosDecimales(reemplazaPuntoPorComa(Round(reemplazaComaPorPunto(Precio)/0.8,4)),4);
		form.elements['PRECIOCONMARGENPORDEFECTO'].value=anyadirCerosDecimales(reemplazaPuntoPorComa(Round(PrecioConMargen,4)),4);
		//}
		CalcularPrecioFinal(form);
	}

	/*
	//	Copia el precio de referencia de un centro a todos los centros
	function CopiarATodosLosCentros(form, IDCentro)
	{
		var Teorico;
		var Precio=form.elements['PRECIOREFERENCIA_'+IDCentro].value;

		if (form.elements['PRECIOREFERENCIA_SINHISTORICO_'+IDCentro].checked)
			Teorico='Si';
		else
			Teorico='No';

		CopiarPrecioYTeoricoATodosLosCentros(form, Precio, Teorico);
	}
	*/

	//	Copia el precio de referencia de un centro a todos los centros
	function CopiarReferenciaAlProductoEstandar(form, Referencia)
	{
		form.method = 'post';
		var Sustituir='N';
		var formJS = document.forms['MensajeJS'];

		//alert('ref_cl xml '+form.elements['REFERENCIACLIENTE_XML'].value);
		//alert('ref_cl '+form.elements['REFERENCIACLIENTE'].value);
		//alert('ref '+Referencia);


		if (form.elements['REFERENCIACLIENTE'].value != Referencia){
			if (form.elements['REFERENCIACLIENTE'].value !='' ){

					if (form.elements['REFERENCIACLIENTE_XML'].value == Referencia){ Sustituir='S';}
					else{
						if (confirm(formJS.elements['DESEA_SUSTITUIR'].value+' '+form.elements['REFERENCIACLIENTE'].value+' '+formJS.elements['POR'].value+' '+Referencia)) Sustituir='S';
					}
			}
			else Sustituir='S';

			if (Sustituir=='S')
			{
				form.elements['REFERENCIACLIENTE'].value=Referencia;
			}
		}
	}

	//	3mar09	ET	Cambio estatico: una sola tabla visible, se selecciona por pesta�as
	function CambioTabla(TablaActiva)
	{
		//alert(TablaActiva);

		document.getElementById("Precios").style.display='none';
		document.getElementById("Precios_Referencia").style.display='none';
		if(jQuery("#Otras_Clinicas").length)
			document.getElementById("Otras_Clinicas").style.display='none';
		if(jQuery("#Consumo").length)
			document.getElementById("Consumo").style.display='none';
		document.getElementById("Proveedor").style.display='none';

		document.getElementById("Pestanya_Precios").style.background='#f5f5f5';
		document.getElementById("Pestanya_Precios_Referencia").style.background='#f5f5f5';
		if(jQuery("#Pestanya_Otras_Clinicas").length)
			document.getElementById("Pestanya_Otras_Clinicas").style.background='#f5f5f5';
		if(jQuery("#Pestanya_Consumo").length)
			document.getElementById("Pestanya_Consumo").style.background='#f5f5f5';
		document.getElementById("Pestanya_Proveedor").style.background='#f5f5f5';

		document.getElementById(TablaActiva).style.display='block';

		document.getElementById("Pestanya_"+TablaActiva).style.background='#c9d7f5';
	}


	//	4jun10	Calculamos el precios de referencia a partir del precio final
	function cambiosAPartirDePrecioFinal(form,IDEmpresa)
	{
		form.method = 'post';
		//	formula: Tarifa= (PrecioFinal - PrecioRef x ComAh x (1 + IVAmvm/100)/((1+ IVAprod/100)+(ComTr-ComAh)/100*(1+IVAmvm/100))
		//	formula: PrecioRef= (PrecioFinal - Tarifa* (1 + IVApr/100)-Tarifa*(ComTr-ComAh)/100*(1+IVAmvm/100))/(ComAh/100*(1+IVAmvm/100))

			/*	para debug
			alert('cambiosAPartirDePrecioFinal. IDEmpresa:'+IDEmpresa+'\n'
				+'Precio:'+form.elements['PRECIO'].value+'\n'
				+'PrecioRef:'+form.elements['PRECIOFINAL_'+IDEmpresa].value+'\n'
				+'ValidarPrecio:'+ValidarNumeroSinMensaje(form.elements['PRECIO'],4)+'\n'
				+'ValidarPrecioRef:'+ValidarNumeroSinMensaje(form.elements['PRECIOFINAL_'+IDEmpresa],4)+'\n'
				);*/
		//alert('precio '+form.elements['PRECIO'].value);
		//alert('validar num '+ValidarNumeroSinMensaje(form.elements['PRECIO'],4));

		//alert('precio final '+form.elements['PRECIOFINAL_'+IDEmpresa].value);
		//alert('validar num pr final '+ValidarNumeroSinMensaje(form.elements['PRECIOFINAL_'+IDEmpresa],4));



		if(form.elements['PRECIO'].value!='' && ValidarNumeroSinMensaje(form.elements['PRECIO'],4)
			&& form.elements['PRECIOFINAL_'+IDEmpresa].value!='' && ValidarNumeroSinMensaje(form.elements['PRECIOFINAL_'+IDEmpresa],4))
		{
			var Tarifa=parseFloat(reemplazaComaPorPunto(form.elements['PRECIO'].value));
			var PrecioFinal=parseFloat(reemplazaComaPorPunto(form.elements['PRECIOFINAL_'+IDEmpresa].value));
			var ComAh=parseFloat(reemplazaComaPorPunto(form.elements['COMISION_AHORRO'].value));
			var ComTr=parseFloat(reemplazaComaPorPunto(form.elements['COMISION_TRANSACCIONES'].value));
			var IVAmvm=parseFloat(reemplazaComaPorPunto(form.elements['TIPO_IVA_MVM'].value));
			var IVAprod=parseFloat(reemplazaComaPorPunto(form.elements['TIPO_IVA_PRODUCTO'].value));

			// para debug
			/*alert('cambiosAPartirDePrecioFinal. IDEmpresa:'+IDEmpresa+'\n'
                                 +'Tarifa:'+Tarifa+'\n'
				+'PrecioFinal:'+PrecioFinal+'\n'
				+'PrecioRef:'+PrecioRef+'\n'
				+'ComAh:'+ComAh+'\n'
				+'ComTr:'+ComTr+'\n'
				+'IVAmvm:'+IVAmvm+'\n'
				+'IVAprod:'+IVAprod+'\n');*/

			//Tarifa= (PrecioFinal - PrecioRef * ComAh/100 * (1 + IVAmvm/100))/((1+ IVAprod/100)+(ComTr-ComAh)/100*(1+IVAmvm/100));
			//form.elements['PRECIO'].value=reemplazaPuntoPorComa(Round(Tarifa,4));

			if (PrecioFinal!=0)
			{
                            //a�adido 25-6-15 si nuevo modelo de negocio pero comision a 0 =>modelo escalado opcion medica
                            if (ComAh == 0){
                                var PrecioRef = Tarifa;
                                form.elements['PRECIOREFERENCIA_'+IDEmpresa].value=reemplazaPuntoPorComa(Round(PrecioRef,4));
                            }
                            else{
				var PrecioRef= (PrecioFinal - Tarifa* (1 + IVAprod/100)-Tarifa*(ComTr-ComAh)/100*(1+IVAmvm/100))/(ComAh/100*(1+IVAmvm/100));
				form.elements['PRECIOREFERENCIA_'+IDEmpresa].value=reemplazaPuntoPorComa(Round(PrecioRef,4));
                            }
			}
			else
			{
				alert(document.forms['MensajeJS'].elements['PRECIO_FINAL_NO_0'].value);
				form.elements['PRECIOFINAL_'+IDEmpresa].focus;
			}
		}

		calcularAhorro(form);
	}

	//	4jun10	Calculamos el precio final
	function CalcularPrecioFinal(form)
	{
		form.method = 'post';
        var idempresa=form.elements['IDEMPRESA'].value;

		//	Comprobamos que sean correctos los valores

			/*	para debug
			alert('cambiosAPartirDePrecioFinal. IDEmpresa:'+idempresa+'\n'
				+'Precio:'+form.elements['PRECIO'].value+'\n'
				+'PrecioRef:'+form.elements['PRECIOREFERENCIA_'+idempresa].value+'\n'
				+'ValidarPrecio:'+ValidarNumeroSinMensaje(form.elements['PRECIO'],4)+'\n'
				+'ValidarPrecioRef:'+ValidarNumeroSinMensaje(form.elements['PRECIOREFERENCIA_'+idempresa],4)+'\n'
				);*/


		if(form.elements['PRECIO'].value!='' && ValidarNumeroSinMensaje(form.elements['PRECIO'],4)
			&& form.elements['PRECIOREFERENCIA_'+idempresa].value!='' && ValidarNumeroSinMensaje(form.elements['PRECIOREFERENCIA_'+idempresa],4))
		{
			var Precio=parseFloat(reemplazaComaPorPunto(form.elements['PRECIO'].value));
			var PrecioRef=parseFloat(reemplazaComaPorPunto(form.elements['PRECIOREFERENCIA_'+idempresa].value));
			var ComAh=parseFloat(reemplazaComaPorPunto(form.elements['COMISION_AHORRO'].value));
			var ComTr=parseFloat(reemplazaComaPorPunto(form.elements['COMISION_TRANSACCIONES'].value));
			var IVAmvm=parseFloat(reemplazaComaPorPunto(form.elements['TIPO_IVA_MVM'].value));
			var IVAprod=parseFloat(reemplazaComaPorPunto(form.elements['TIPO_IVA_PRODUCTO'].value));
			var PrecioFinal=Precio*(1+IVAprod/100)+(PrecioRef-Precio)*ComAh/100*(1+IVAmvm/100)+Precio*ComTr/100*(1+IVAmvm/100);


			/*	para debug
			var Ahorro=(PrecioRef-Precio);
			alert('cambiosAPartirDePrecioFinal. IDEmpresa:'+idempresa+'\n'
				+'Precio:'+Precio+'\n'
				+'PrecioRef:'+PrecioRef+'\n'
				+'Ahorro:'+Ahorro+'\n'
				+'ComAh:'+ComAh+'\n'
				+'ComTr:'+ComTr+'\n'
				+'IVAmvm:'+IVAmvm+'\n'
				+'IVAprod:'+IVAprod+'\n'
				+'PrecioFinal:'+PrecioFinal+'\n'
				);*/

			form.elements['PRECIOFINAL_'+idempresa].value=reemplazaPuntoPorComa(Round(PrecioFinal,4));
		}
		else
		{
			form.elements['PRECIOFINAL_'+idempresa].value='';
		}
	}

	//	Calcula el ahorro tras cambio del precio final, evita bucles infinitos
	function calcularAhorro(form)
	{
		form.method = 'post';
                var idempresa=form.elements['IDEMPRESA'].value;

                if(form.elements['PRECIO'].value!='' && ValidarNumeroSinMensaje(form.elements['PRECIO'],4)){

                        var precio=reemplazaComaPorPunto(form.elements['PRECIO'].value);
			//form.elements['PRECIOCON20PORCIENTO'].value=anyadirCerosDecimales(reemplazaPuntoPorComa(Round(precio/0.8,4)),4);
			form.elements['PRECIOCONMARGENPORDEFECTO'].value=Convierte(CalculaPrecioConMargenPorDefecto(form, precio));

			if ( form.elements['PRECIOREFERENCIA_'+idempresa].value!='' && ValidarNumeroSinMensaje(form.elements['PRECIOREFERENCIA_'+idempresa],4)){

                            var PrecioRef=parseFloat(reemplazaComaPorPunto(form.elements['PRECIOREFERENCIA_'+idempresa].value));

				if (PrecioRef!=0)
				{
      				var ahorro=(PrecioRef-precio)/PrecioRef*100;
					form.elements['AHORRO_'+idempresa].value=anyadirCerosDecimales(reemplazaPuntoPorComa(Round(ahorro,2)),2);

					//	15nov10 MARGEN BRUTO
					var PrecioFinal=parseFloat(reemplazaComaPorPunto(form.elements['PRECIOFINAL_'+idempresa].value));
					var IVAprod=parseFloat(reemplazaComaPorPunto(form.elements['TIPO_IVA_PRODUCTO'].value));
					var PrecioConIVA=precio*(1+IVAprod/100);

					if (PrecioConIVA>0)
						var margenBruto=100*(PrecioFinal-PrecioConIVA)/PrecioConIVA;
					else
						var margenBruto=0;

					form.elements['MARGENBRUTO_'+idempresa].value=anyadirCerosDecimales(reemplazaPuntoPorComa(Round(margenBruto,2)),2);

				}
				else{
					form.elements['AHORRO_'+idempresa].value=0;
					alert(document.forms['MensajeJS'].elements['PRECIO_REFERENCIA_NO_0'].value);
					form.elements['PRECIOREFERENCIA_'+idempresa].focus;
				}
			}
			else{
				form.elements['AHORRO_'+idempresa].value='?';
                         }
    	}
    	else
		{
      		form.elements['AHORRO_'+idempresa].value='?';
			//form.elements['PRECIOCON20PORCIENTO'].value='';
			form.elements['PRECIOCONMARGENPORDEFECTO'].value='';
    	}
	}

	function CalculaPrecioConMargenPorDefecto(form, precio)
	{
		form.method = 'post';
		/*var Precio=parseFloat(reemplazaComaPorPunto(form.elements['PRECIO'].value));
		var PrecioRef=parseFloat(reemplazaComaPorPunto(form.elements['PRECIOREFERENCIA_'+idempresa].value));
		var ComAh=parseFloat(reemplazaComaPorPunto(form.elements['COMISION_AHORRO'].value));
		var ComTr=parseFloat(reemplazaComaPorPunto(form.elements['COMISION_TRANSACCIONES'].value));
		var IVAmvm=parseFloat(reemplazaComaPorPunto(form.elements['TIPO_IVA_MVM'].value));
		var PrecioFinal=Precio*(1+IVAprod/100)+(PrecioRef-Precio)*ComAh/100*(1+IVAmvm/100)+Precio*ComTr/100*(1+IVAmvm/100);*/

		var	MargenBruto=form.elements['MARGENPORDEFECTO'].value;
		var IVAprod=parseFloat(reemplazaComaPorPunto(form.elements['TIPO_IVA_PRODUCTO'].value));
		var PrecioConMargen=precio*(1+IVAprod/100)*(1+MargenBruto/100);

		//alert(PrecioConMargen);

		return(PrecioConMargen);
	}

	function Convierte(importe)
	{
		return(anyadirCerosDecimales(reemplazaPuntoPorComa(Round(importe,4)),4));
	}

//funcion que ense�a en el eis los datos del centro o de la empresa segun un producto, agrupar por producto siempre
function MostrarEIS(indicador, idempresa, idcentro, refPro, anno){
	var Enlace;

	Enlace='http://www.newco.dev.br/Gestion/EIS/EISDatos2.xsql?'
		+'IDCUADROMANDO='+indicador
		+'&ANNO='+anno
		+'&IDEMPRESA='+idempresa
		+'&IDCENTRO='+idcentro
		+'&IDUSUARIO='
		+'&IDPRODUCTO=-1'
		+'&IDGRUPOCAT=-1'
		+'&IDSUBFAMILIA=-1'
		+'&IDESTADO=-1'
		+'&REFERENCIA='+refPro
		+'&CODIGO='
		+'&AGRUPARPOR=REF';

	MostrarPagPersonalizada(Enlace,'EIS',100,80,0,0);
}
