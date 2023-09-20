//	JS para mantenimiento de pedidos
//	Ultima revision: ET 4abr19 09:18


var uploadFilesDoc = new Array();
var periodicTimerDoc = 0;
var form_tmp;
var MAX_WAIT_DOC = 1000;


function Enviar(Accion){
	var form=document.forms['frmMantenPedido'];
	var jsForm=document.forms['MensajeJS'];
	var MsgError='';
	var motivo	= jQuery('#MOTIVO_BORRAR').val();
	//	Validar datos introducidos
	if(form.elements['IDCLIENTE'].value =='-1')
		MsgError=MsgError + jsForm.elements['CLIENTE_OBLI'].value +'\n';
	if(form.elements['IDPROVEEDOR'].value =='-1')
		MsgError=MsgError + jsForm.elements['PROVEEDOR_OBLI'].value +'\n';
	if(form.elements['MO_ID'].value =='')
		MsgError=MsgError + jsForm.elements['MO_ID_OBLI'].value +'\n';
	// Validacion textarea 'MOTIVO_BORRAR'
	if(motivo == '' && Accion == 'BORRAR'){
		MsgError = MsgError + motivo_borrar_obligatorio;
		jQuery('#MOTIVO_BORRAR').focus();
	}else if(MsgError == '')
		form.elements['PARAMETROS'].value = motivo;
	if( MsgError!=''){
		alert(MsgError);
	}else{
		//	Realizar accion
		form.elements['ACCION'].value=Accion;
		SubmitForm(form);
	}
}

function ComprobarPedido(){
	Enviar('COMPROBAR');
}

function BorrarPedido(){
	Enviar('BORRAR');
}

/*	4abr19 Cambio del estado del pedido mediante desplegable
function RetrocederPedido(form){
    var mo_id = form.elements['MO_ID'].value;
    var cliente = form.elements['IDCLIENTE'].value;
    var provee = form.elements['IDPROVEEDOR'].value;
    form.action = 'http://www.newco.dev.br/Administracion/Mantenimiento/Pedidos/MANTPedidosSave.xsql?MO_ID='+mo_id+'&IDCLIENTE='+cliente+'&IDPROVEEDOR='+provee;
	Enviar('CAMBIAR_ESTADO');
}
*/

//	ACTUALIZAMOS DATOS PEDIDO 27-04-12 MC
function Actualizar(accion,lmo,lpe){
	var form=document.forms['frmMantenPedido'];
	var jsForm=document.forms['MensajeJS'];
	
	console.log('Actualizar accion:'+accion);

	//	4abr19 Cambio del estado del pedido
	if(accion == 'CAMBIAR_ESTADO'){
		form.elements['PARAMETROS'].value=form.elements['IDESTADO'].value;
		form.elements['ACCION'].value=accion;
		SubmitForm(form);
	}
   
    //	si cambia el IVA del pedido
	if(accion == 'ACTUALIZARIVA'){
		form.elements['ACCION'].value=accion;
		SubmitForm(form);
	}

	//	si cambia el num pedido
	if(accion == 'NUMERO_PEDIDO'){
		//	si num pedido no esta vacio
		if(document.forms['frmMantenPedido'].elements['NUM_PEDIDO'].value != ''){
			form.elements['PARAMETROS'].value=form.elements['NUM_PEDIDO'].value;
			form.elements['ACCION'].value=accion;

			SubmitForm(form);
		}else{
			alert(document.forms['MensajeJS'].elements['OBLI_NUM_PEDIDO'].value+'\n');
		}
	}

	//	si cambia el lugar de entrega
	if(accion == 'LUGAR_ENTREGA'){
		//	si num pedido no esta vacio
		if(document.forms['frmMantenPedido'].elements['IDLUGARENTREGA'].value != ''){
			form.elements['PARAMETROS'].value=form.elements['IDLUGARENTREGA'].value;
			form.elements['ACCION'].value=accion;

			SubmitForm(form);
			
		}else{
			alert(document.forms['MensajeJS'].elements['OBLI_LUGARENTREGA'].value+'\n');	//	Por aqui no puede entrar, así que no definimios esta variable. Dejamos para depuración posterior
		}
	}

	//	si cambia el centro de consumo
	if(accion == 'CENTRO_CONSUMO'){
		//	si num pedido no esta vacio
		if(document.forms['frmMantenPedido'].elements['IDCENTROCONSUMO'].value != ''){
			form.elements['PARAMETROS'].value=form.elements['IDCENTROCONSUMO'].value;
			form.elements['ACCION'].value=accion;

			SubmitForm(form);
			
		}else{
			alert(document.forms['MensajeJS'].elements['OBLI_CENTROCONSUMO'].value+'\n');	//	Por aqui no puede entrar, así que no definimios esta variable. Dejamos para depuración posterior
		}
	}

	//	si elimino una linea del pedido
	if(accion == 'BORRAR_LINEA'){
		if(!confirm(jsForm.elements['SEGURO_ELIMINAR_LINEA_PEDIDO'].value)) { }
		else{
			form.elements['PARAMETROS'].value= lpe+'|'+lmo;
			form.elements['ACCION'].value=accion;

			SubmitForm(form);
		}
	}

	//	si cambia la fecha de entrega
	if(accion == 'FECHA_ENTREGA'){
		msg=CheckDate(document.forms['frmMantenPedido'].elements['FECHA_ENTREGA'].value);

		//	si fecha no esta vacia
		if(document.forms['frmMantenPedido'].elements['FECHA_ENTREGA'].value != ''){
			if(msg!=''){
				alert(msg);
			}else{
				form.elements['PARAMETROS'].value=document.forms['frmMantenPedido'].elements['FECHA_ENTREGA'].value;
				form.elements['ACCION'].value=accion;

				SubmitForm(form);
			}
		}

		//	si fecha vacia alert
		else{alert(jsForm.elements['OBLI_FECHA_ENTREGA'].value+'\n');}
	}

	//	si cambia una linea de pedido
	if(accion == 'CAMBIAR_LINEA'){

		var mess= '';
		var udBasica = form.elements['UN_BASICA_'+lmo].value;
		var udLote = form.elements['UN_LOTE_'+lmo].value;
		var cantidad = form.elements['CANTIDAD_'+lmo].value.replace('.','');
		var precioUn = form.elements['PRECIO_'+lmo].value;
		var precioRef;

		if(form.elements['PRECIOREF_'+lmo] && form.elements['PRECIOREF_'+lmo].value!='')
			precioRef = form.elements['PRECIOREF_'+lmo].value;
		else
			precioRef = '';

		//	si algun campo vacio
		if(udBasica == '' || udLote == '' || cantidad == '' || precioUn == ''){
			if(udBasica == ''){ mess = mess + document.forms['MensajeJS'].elements['OBLI_UD_BASE'].value+'\n'; }
			if(udLote == ''){ mess = mess + document.forms['MensajeJS'].elements['OBLI_UD_LOTE'].value+'\n'; }
			if(cantidad == ''){ mess = mess + document.forms['MensajeJS'].elements['OBLI_CANTIDAD'].value+'\n'; }
			if(precioUn == ''){ mess = mess + document.forms['MensajeJS'].elements['OBLI_PRECIO'].value+'\n'; }
		}
		else
		{
			//	16feb18	Comprobar que precio, precio ref y cantidad son positivos
			if (parseFloat(precioRef.replace(',','.'))<0)
				mess = mess + document.forms['MensajeJS'].elements['OBLI_PRECIO_REF_POSITIVO'].value+'\n';

			if (parseFloat(precioUn.replace(',','.'))<0)
				mess = mess + document.forms['MensajeJS'].elements['OBLI_PRECIO_POSITIVO'].value+'\n';

			if (parseFloat(cantidad.replace(',','.'))<=0)
				mess = mess + document.forms['MensajeJS'].elements['OBLI_CANTIDAD_POSITIVA'].value+'\n';
		}
		
		
		if (mess!='')
		{
			alert(mess);
		}
		//	si todos campos informados
		else{

			//solodebug	console.log("Avanzado:"+form.elements['MANT_AVANZADO'].value+' Cant.:'+form.elements['CANTIDAD_'+lmo].value);

			if((form.elements['MANT_AVANZADO'].value=='S') && (precioRef <= precioUn) && (precioRef != '')){
				if(!confirm(document.forms['MensajeJS'].elements['PRECIO_REF_INFERIOR'].value))
					return;
			}
			
			var cantLotes=(cantidad/udLote), cantLotesInt=Math.floor(cantidad/udLote);
			
			if ((cantidad/udLote)!=cantLotesInt)
			{
				cantidad=(cantLotesInt+1)*udLote;
				form.elements['CANTIDAD_'+lmo].value=cantidad;
			}
			
			//solodebug	alert("Avanzado:"+form.elements['MANT_AVANZADO'].value+' Cant.:'+form.elements['CANTIDAD_'+lmo].value+" Nueva cantidad:"+cantidad);

			form.elements['PARAMETROS'].value= lpe+'|'+lmo+'|'+udBasica+'|'+udLote+'|'+cantidad+'|'+precioUn+'|'+precioRef;
			form.elements['ACCION'].value=accion;

			SubmitForm(form);
		}
	}

	//	si añado una linea al pedido
	if(accion == 'NUEVA_LINEA'){
		var msg = '';
		var cantidad = document.forms['frmMantenPedido'].elements['NEWLINE_CANTIDAD'].value;
		var refProv = document.forms['frmMantenPedido'].elements['NEWLINE_REFPROV'].value;
        var unLote = document.forms['frmMantenPedido'].elements['UN_LOTE_DATOS_PROD'].value;
        var idProd = document.forms['frmMantenPedido'].elements['ID_PROD'].value;

		//	comprobamos que no esten vacios
		if(cantidad == '' || cantidad == '0'){ msg += jsForm.elements['OBLI_CANTIDAD'].value +'\n'; }
		if(refProv == ''){ msg += jsForm.elements['OBLI_REF_PROVE'].value +'\n';}

		//	si not a number = true implica que no es un numero
		if(isNaN(cantidad) == true)
			{ msg += jsForm.elements['NOT_A_NUMBER'].value +'\n';}

		if (parseFloat(cantidad.replace(',','.'))<=0)
			msg += document.forms['MensajeJS'].elements['OBLI_CANTIDAD_POSITIVA'].value+'\n';

        //compruebo que la cantidad pedida es correcta respecto a la unidad lote
        if (cantidad % unLote != 0){ msg += jsForm.elements['CANTIDAD_INCORRECTA'].value +'\n';}

        //alert('mi'+cantidad % unLote);

		//	compruebo que la ref proveedor del producto no este ya en el pedido
		jQuery(".refProveedores").each(function(){
			if(refProv == jQuery(this).html()){
				msg += jsForm.elements['PRODUCTO_EXISTE_PEDIDO'].value +'\n';
			}
		});
		
		if(msg == ''){
        	//	compruebo que la ref privada del producto no este ya en el pedido
			jQuery(".refPrivada").each(function(){
				if(refProv == jQuery(this).html()){
					msg += jsForm.elements['PRODUCTO_EXISTE_PEDIDO'].value +'\n';
				}
			});
		}

		if(msg == ''){
			form.elements['PARAMETROS'].value= ' '+'|'+' '+'|'+' '+'|'+ ' ' +'|'+cantidad+'|'+' '+'|'+idProd;;
			form.elements['ACCION'].value=accion;

			SubmitForm(form);
		}else{ alert(msg);}

	}//fin if nueva linea
}//fin de actualizar


function Ocultar(IDLineaPedido, Oculto){
	var form=document.forms['frmMantenPedido'];
	form.elements['IDLINEAPEDIDO'].value=IDLineaPedido;
	form.elements['OCULTAR'].value=Oculto;

	SubmitForm(form);
}

//function recuperar datos de un producto para añadir linea pedido
function DatosProducto(){
	var form = document.forms['frmMantenPedido'];
	var jsForm = document.forms['MensajeJS'];
	var msg = '';

	var moId	= form.elements['MO_ID'].value;
	var refProd	= encodeURIComponent(form.elements['NEWLINE_REFPROV'].value);

	if(refProd != '' && moId != ''){
		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Pedidos/DatosProducto.xsql',
			type:	"GET",
			data:	"MOID="+moId+"&REF_PROD="+refProd,
			contentType: "application/xhtml+xml",
			error: function(objeto, quepaso, otroobj){
				alert('error'+quepaso+' '+otroobj+''+objeto);
			},
			success: function(objeto){
				var data = eval("(" + objeto + ")");
            	//alert(data.DatosProducto.REF);

				if (data.DatosProducto.PRO_NOMBRE!='')		//	28oct16	Control errores
				{

                	txtHTML = "<td>"+" "+"</td>" + 
                    		"<td class='datosLeft'>" + data.DatosProducto.REF_PRIVADA+"</td>" +
							"<td class='datosLeft'>" + data.DatosProducto.REF+"</td>" +
							"<td class='datosLeft'>" + data.DatosProducto.PRO_NOMBRE+"</td>" +
							"<td class='datosLeft'>" + data.DatosProducto.UN_BASICA+"</td>" +
                            "<td class='datosLeft'><input type='text' name='UN_LOTE_DATOS_PROD' id='UN_LOTE_DATOS_PROD' size='10' value='" + data.DatosProducto.UN_LOTE+"' class='noinput' /></td>" +
                            "<td class='datosLeft'><input type='text' name='NEWLINE_CANTIDAD' id='NEWLINE_CANTIDAD' size='10' value='" + data.DatosProducto.UN_LOTE+"'/></td>" +
                            "<td class='datosLeft'>" + data.DatosProducto.TARIFA+"</td>" +
                            "<td>"+'<div class="boton"><a class="btnDestacado" href="javascript:Actualizar(\'NUEVA_LINEA\');">'+jsForm.elements["ENVIAR"].value+"</a></div>"+"</td>"+
                            "<td class='datosLeft'><input type='text' name='ID_PROD' id='ID_PROD' size='10' value='" + data.DatosProducto.PRO_ID+"'  style='display:none;' /></td>" +
                            "<td colspan='6'> </td>";

            	   //escribo HTML en la linea
                	jQuery("#datosProd").empty();
					jQuery("#datosProd").show();
					jQuery("#datosProd").append(txtHTML);
				}
				else
				{
					alert('No se ha encontrado el producto.');		//PENDIENTE TRADUCIR MENSAJE
                	jQuery("#datosProd").hide();
				}

			}
		});//fin jquery
	}else{
		msg = jsForm.elements['TODOS_CAMPOS_OBLI'].value;
		alert(msg);
	}
}//fin de RECUPERAR DATOS LINEA PRODUCTO


//ver div de productos manuales, revision 11-10-2013 MC funcionante
function VerProductosManuales(){
	if(document.getElementById('InsertarProductosManuales').style.display == 'none'){
		//jQuery("#divProductosManuales").show();
		jQuery("#InsertarProductosManuales").show();
	}else{
		if(document.getElementById('InsertarProductosManuales').style.display != 'none'){
			//jQuery("#divProductosManuales").hide();
			jQuery("#InsertarProductosManuales").hide();
		}
	}
}

//function añadir productos no en plantilla
function AnadirProductosManuales(){
	var form = document.forms['frmMantenPedido'];
	var jsForm = document.forms['MensajeJS'];
	var msg = '';

	var moId	= form.elements['MOID'].value;
	var refProv	= encodeURIComponent(form.elements['REFPROVEEDOR'].value);
	var descripcion	= encodeURIComponent(form.elements['DESCRIPCION'].value);
	var unBasica	= encodeURIComponent(form.elements['UNIDADBASICA'].value);
	var cantidad	= form.elements['CANTIDAD'].value;
	//var precio	= form.elements['PRECIOUNITARIO'].value;
	//var iva	= form.elements['TIPO_IVA'].value;

	if(refProv != '' && descripcion != '' && unBasica != '' && cantidad != ''){
		jQuery.ajax({
			cache:	false,
			url:	'http://www.newco.dev.br/Compras/Multioferta/ProductosManualesSave_ajax.xsql',
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
					form.elements['REFPROVEEDOR'].value = '';
					form.elements['DESCRIPCION'].value = '';
					form.elements['UNIDADBASICA'].value = '';
					form.elements['CANTIDAD'].value = '';
					//form.elements['PRECIOUNITARIO'].value = '';
					//form.elements['TIPO_IVA'].value = '';
					//document.location.reload(true);
				}else{
					alert(jsForm.elements['ERROR_INSERTAR_DATOS'].value);
				}
			}
		});//fin jquery
	}else{
		msg = jsForm.elements['TODOS_CAMPOS_OBLI'].value;
		alert(msg);
	}
}//fin de AnadirProductosManuales

//function eliminar productos manuales
function EliminarProductosManuales(idProdMan){
	var form = document.forms['frmMantenPedido'];
	var jsForm = document.forms['MensajeJS'];

	var msg = '';
	var moId= form.elements['MOID'].value;

	if (idProdMan != ''){

    	jQuery.ajax({
    	cache:	false,
    	url:	'http://www.newco.dev.br/Compras/Multioferta/EliminarProductosManuales.xsql',
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
            	alert(jsForm.elements['ERROR_ELIMINAR_DATOS'].value);
        	}
    	}
    	});//fin jquery
	}
	else{ 
    	msg = jsForm.elements['ERROR_ELIMINAR_DATOS'].value; 
    	alert(msg);
	}
}//fin de EliminarProductosManuales


//recupero a los productos manuales
function RecuperaProductosManuales(moId){

var ACTION="http://www.newco.dev.br/Compras/Multioferta/ProductosManuales.xsql";
var post='MOID='+moId;
if (moId != '') sendRequest(ACTION,handleRequestProductosManuales,post);
}

//recupero a los productos manuales
function RecuperaProductosManuales(moId){

var ACTION="http://www.newco.dev.br/Compras/Multioferta/ProductosManuales.xsql";
var post='MOID='+moId;
if (moId != '') sendRequest(ACTION,handleRequestProductosManuales,post);
}

function handleRequestProductosManuales(req){

var response = eval("(" + req.responseText + ")");
var Resultados = new String('');

if(response.ProductosManuales.length > 0){
    jQuery("#divProductosManuales").show();

	jQuery("#productosManuales tbody").empty();

	// Se crea la tabla de los productos manuales
	jQuery.each(response.ProductosManuales, function(key, producto){

		txtHTML = "<tr id="+producto.PMId+">" +
					"<td>" + producto.PMRefProv+"</td>" +
					"<td>" + producto.PMDescripcion+"</td>" +
					"<td>" + producto.PMUnBasica+"</td>" +
					"<td>" + producto.PMCantidad+"</td>" +
                    //"<td align='center'>" + producto.PMPrecio+"</td>" +
                    //"<td align='center'>" + producto.PMIva+"</td>" +
					"<td>" +
						"<a class=\"accBorrar\" href=\"javascript:EliminarProductosManuales('"+producto.PMId+"');\">" +
							"<img src='http://www.newco.dev.br/images/2017/trash.png'/>" +
						"</a>" +
        	        "</td>" +
                    "<td>"+" "+"</td>" +
				"</tr>";

	//escribo HTML en la tabla
	jQuery("#productosManuales").show();
	jQuery("#productosManuales tbody").append(txtHTML);
    });

}
//si no hay productos
else{
    jQuery("#productosManuales tbody").empty();
    jQuery("#productosManuales").hide();

}
}//fin de recupero productos manuales

function GenerarPDF(){
var form=document.forms['frmMantenPedido'];
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

        if(data.RecargarPDF.estado == 'OK'){
            alert(jsForm.elements['PDF_ENVIADO_CON_EXITO'].value);
            //jQuery("#"+modificarFechaLimite).show();

        }
    },
    error: function(xhr, errorString, exception) {
        alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
    }
});
}//fin de generarPDF

function VerPedido(mo_id){
    window.open('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID='+mo_id, '_self');
  }//fin verPedido






//	24nov17	Actualiza el campo de comentarios del pedido
function ActualizarComentario(){
    var form=document.forms['frmMantenPedido'];
    var jsForm=document.forms['MensajeJS'];
    var mo_id = form.elements['MO_ID'].value;
    var comentario = ScapeHTMLString(form.elements['MO_COMENTARIOS'].value);

	jQuery("#btnComentario").hide();

    //alert('mi '+mo_id);
    jQuery.ajax({
        cache:	false,
        url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Pedidos/ActualizarComentarioAJAX.xsql',
        type:	"GET",
        data:	"MO_ID="+mo_id+"&COMENTARIOS="+encodeURIComponent(comentario),
        //contentType: "application/xhtml+xml",
		dataType: "text",
        success: function(objeto){
            var data = eval("(" + objeto + ")");

            if(data.estado == 'OK'){
            }
			jQuery("#btnComentario").show();
        },
        error: function(xhr, errorString, exception) {
            alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
				jQuery("#btnComentario").show();
        }
    });
}//fin de generarPDF






//
//	Carga de documento
//

var TipoCarga='';

//cargar documentos
function cargaDoc(Tipo){

	//solodebug
	console.log('cargaDoc: Inicio.');
	TipoCarga=Tipo;

    var form=document.forms['frmMantenPedido'];
	var msg = '';
	
	//	Copia el control con el fichero a subir
	jQuery("#inputFileDoc").remove()
	var x = jQuery("#inputFileDoc_"+Tipo),
    	  y = x.clone();
	y.attr("id", "inputFileDoc");
	y.attr("name", "inputFileDoc");
	y.hide();
	y.insertAfter("#inputFileDoc_"+Tipo);

		if(hasFilesDoc(form)){

			var actionAnt=form.action;		//	2oct18
			var targetAnt=form.target;		//	2oct18
			var encodingAnt=form.encoding;	//	2oct18
		
			var target = 'uploadFrameDoc';
			var action = 'http://www.newco.dev.br/cgi-bin/uploadDocsMVM.pl';
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
			
			form.action=actionAnt;		//	2oct18
			form.target=targetAnt;		//	2oct18
			form.encoding=encodingAnt;	//	2oct18
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


	jQuery('#waitBoxDoc_'+TipoCarga).html ('<img src="http://www.newco.dev.br/images/loading.gif" />');
	jQuery('#waitBoxDoc_'+TipoCarga).show();
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
		var tipoDocHTML	= document.forms['frmMantenPedido'].elements['TIPO_DOC_HTML_'+TipoCarga].value;

		var uFrame	= uploadFrameDoc.document.getElementsByTagName("p")[0];

		document.getElementById('waitBoxDoc_'+TipoCarga).style.display = 'none';

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
				
	//solodebug
	console.log('handleFileRequestDoc: Inicio.');

	if(document.getElementById('myLanguage') && document.getElementById('myLanguage').innerHTML.length > 0){
		lang = document.getElementById('myLanguage').innerHTML;
	}
/*
	var form = form_tmp;
	var target = '_top';
	var enctype = 'application/x-www-form-urlencoded';
*/
	var msg = '';
	var documentChain = new String('');


//	var action = 'http://' + location.hostname + '/' + lang + 'confirmCargaDocumentoPedido.xsql';

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

	//var usuario	= document.forms['frmMantenPedido'].elements['ID_USUARIO'].value;
	var borrados	= document.forms['frmMantenPedido'].elements['DOCUMENTOS_BORRADOS'].value;
	var borr_ante	= document.forms['frmMantenPedido'].elements['BORRAR_ANTERIORES'].value;
	var tipoDocDB	= document.forms['frmMantenPedido'].elements['TIPO_DOC_DB_'+TipoCarga].value;
	var tipoDocHTML	= document.forms['frmMantenPedido'].elements['TIPO_DOC_HTML_'+TipoCarga].value;
	// En este caso usamos el IDEmpresa del cliente como parámetro de entrada para IDPROVEEDOR
	//var IDEmpresa	= '';
	//if(document.forms['frmMantenPedido'].elements['IDEMPRESA'].value != ''){
	//	IDEmpresa	= document.forms['frmMantenPedido'].elements['IDEMPRESA'].value;
	//}

	if(msg != ''){
		alert(msg);
		return false;
	}else{

//		form.encoding	= enctype;
//		form.action	= action;
//		form.target	= target;
		var d = new Date();

		jQuery.ajax({
			url:"http://www.newco.dev.br/Compras/Multioferta/confirmCargaDocumentoPedidoAJAX.xsql",
			data: "&MO_ID="+IDMultioferta+"&IDEMPRESA="+IDEmpresa+"&TIPODOC="+tipoDocDB+"&CADENA_DOCUMENTOS="+cadenaDoc+"&_="+d.getTime(),
			type: "GET",
			async: false,
			contentType: "application/xhtml+xml",
			beforeSend:function(){
				document.getElementById('waitBoxDoc_'+TipoCarga).src = 'http://www.newco.dev.br/images/loading.gif';
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
				document.forms['frmMantenPedido'].elements['inputFileDoc'].value = '';

				if(document.forms['frmMantenPedido'].elements['MAN_PRO'] && document.forms['frmMantenPedido'].elements['MAN_PRO'].value != 'si'){
					if (document.forms['frmMantenPedido'].elements['US_MVM'] && document.forms['frmMantenPedido'].elements['US_MVM'].value == 'si'){
						document.forms['frmMantenPedido'].elements['IDPROVEEDOR'].value = '-1';
					}
				}

				var tipo = document.forms['frmMantenPedido'].elements['TIPO_DOC_HTML_'+TipoCarga].value;

				//vaciamos la carga documentos
				document.forms['frmMantenPedido'].elements['inputFileDoc'] = '';
				//jQuery("#carga"+tipo).hide();

				uploadFrameDoc.document.getElementsByTagName("p")[0].innerHTML = '';
				uploadFrameDoc.document.getElementsByTagName("body")[0].innerHTML = "";

//				var proveedor = document.forms['frmMantenPedido'].elements['IDPROVEEDOR'].value;

				//Informamos del IDDOC en el input hidden que toca y avisamos al usuario
				//jQuery('#IDDOCUMENTO').val(doc[0].id_doc);
				//Creamos el link para acceder al archivo, link para borrarlo y ocultamos link para subir documento
				var nombreDoc	= doc[0].nombre;
				var fileDoc	= doc[0].file;
				var htmlCad= '&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://www.newco.dev.br/Documentos/' + fileDoc + '" target="_blank">' + nombreDoc + '</a>'
								+'<a href="javascript:borrarDoc(\''+TipoCarga+'\','+doc[0].id_doc+');"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>';
				jQuery('#docBox_'+TipoCarga).empty().append(htmlCad).show();
				//jQuery('#borraDoc').append('<a href="javascript:borrarDoc(' + doc[0].id_doc + ',\'' + tipo + '\')"><img src="http://www.newco.dev.br/images/2017/trash.png"/></a>').show();
				//jQuery('#newDoc').hide();
				jQuery('#inputFileDoc_'+TipoCarga).hide();

				//reseteamos los input file, mismo que removeDoc
				var clearedInput;
				var uploadElem = document.getElementById("inputFileDoc_"+TipoCarga);

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



function borrarDoc(Tipo, IDDoc){
	var d = new Date();

	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/BorrarDocumento.xsql',
		type:	"GET",
		data:	"DOC_ID="+IDDoc+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.BorrarDocumento.estado == 'OK'){
				//jQuery("#IDDOCUMENTO").val("");
				//jQuery("#borraDoc").empty().hide();
				jQuery('#docBox_'+Tipo).empty().hide();
				//jQuery("#newDoc").show();
				jQuery('#inputFileDoc_'+Tipo).show();
            }else{
				alert('Error: ' + data.BorrarDocumento.message);
			}
		},
		error: function(xhr, errorString, exception) {
			alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
		}
	});
}








