//	JS para mantenimiento de pedidos
//	Extraido de MANTPedidosHTML.xsl
//	Ultima revision: ET 23ago17 13:31


function Enviar(Accion){
	var form=document.forms['form1'];
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

function RetrocederPedido(form){
                var mo_id = form.elements['MO_ID'].value;
                var cliente = form.elements['IDCLIENTE'].value;
                var provee = form.elements['IDPROVEEDOR'].value;
                form.action = 'http://www.newco.dev.br/Administracion/Mantenimiento/Pedidos/MANTPedidosSave.xsql?MO_ID='+mo_id+'&IDCLIENTE='+cliente+'&IDPROVEEDOR='+provee;
	Enviar('CAMBIAR_ESTADO');
}

//	ACTUALIZAMOS DATOS PEDIDO 27-04-12 MC
function Actualizar(accion,lmo,lpe){
	var form=document.forms['form1'];
	var jsForm=document.forms['MensajeJS'];

                //	si cambia el IVA del pedido 8-1-15
	if(accion == 'ACTUALIZARIVA'){
			form.elements['ACCION'].value=accion;
			SubmitForm(form);
	}

	//	si cambia el num pedido
	if(accion == 'NUMERO_PEDIDO'){
		//	si num pedido no esta vacio
		if(document.forms['form1'].elements['NUM_PEDIDO'].value != ''){
			form.elements['PARAMETROS'].value=form.elements['NUM_PEDIDO'].value;
			form.elements['ACCION'].value=accion;

			SubmitForm(form);
		}else{
			alert(document.forms['MensajeJS'].elements['OBLI_NUM_PEDIDO'].value+'\n');
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
		msg=CheckDate(document.forms['form1'].elements['FECHA_ENTREGA'].value);

		//	si fecha no esta vacia
		if(document.forms['form1'].elements['FECHA_ENTREGA'].value != ''){
			if(msg!=''){
				alert(msg);
			}else{
				form.elements['PARAMETROS'].value=document.forms['form1'].elements['FECHA_ENTREGA'].value;
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
		var cantidad = form.elements['CANTIDAD_'+lmo].value;
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

			alert(mess);
		}

		//	si todos campos informados
		else{
			if(precioRef <= precioUn && precioRef != ''){
				if(!confirm(document.forms['MensajeJS'].elements['PRECIO_REF_INFERIOR'].value))
					return;
			}

			form.elements['PARAMETROS'].value= lpe+'|'+lmo+'|'+udBasica+'|'+udLote+'|'+cantidad+'|'+precioUn+'|'+precioRef;
			form.elements['ACCION'].value=accion;

			SubmitForm(form);
		}
	}

	//	si añado una linea al pedido
	if(accion == 'NUEVA_LINEA'){
		var msg = '';
		var cantidad = document.forms['form1'].elements['NEWLINE_CANTIDAD'].value;
		var refProv = document.forms['form1'].elements['NEWLINE_REFPROV'].value;
        var unLote = document.forms['form1'].elements['UN_LOTE_DATOS_PROD'].value;
        var idProd = document.forms['form1'].elements['ID_PROD'].value;

		//	comprobamos que no esten vacios
		if(cantidad == '' || cantidad == '0'){ msg += jsForm.elements['OBLI_CANTIDAD'].value +'\n'; }
		if(refProv == ''){ msg += jsForm.elements['OBLI_REF_PROVE'].value +'\n';}

		//	si not a number = true implica que no es un numero
		if(isNaN(cantidad) == true){ msg += jsForm.elements['NOT_A_NUMBER'].value +'\n';}

        //compruebo que la cantidad pedida es correcta respecto a la unidad lote
        if (cantidad % unLote != 0){ msg += jsForm.elements['CANTIDAD_INCORRECTA'].value +'\n';}

        //alert('mi'+cantidad % unLote);

		//	compruebo que la ref proveedor del producto no este ya en el pedido
		jQuery(".refProveedores").each(function(){
			if(refProv == jQuery(this).html()){
				msg += jsForm.elements['PRODUCTO_EXISTE_PEDIDO'].value +'\n';
			}
		});
        //	compruebo que la ref privada del producto no este ya en el pedido
		jQuery(".refPrivada").each(function(){
			if(refProv == jQuery(this).html()){
				msg += jsForm.elements['PRODUCTO_EXISTE_PEDIDO'].value +'\n';
			}
		});

		if(msg == ''){
			form.elements['PARAMETROS'].value= ' '+'|'+' '+'|'+' '+'|'+ ' ' +'|'+cantidad+'|'+' '+'|'+idProd;;
			form.elements['ACCION'].value=accion;

			SubmitForm(form);
		}else{ alert(msg);}

	}//fin if nueva linea
}//fin de actualizar


function Ocultar(IDLineaPedido, Oculto){
	var form=document.forms['form1'];
	form.elements['IDLINEAPEDIDO'].value=IDLineaPedido;
	form.elements['OCULTAR'].value=Oculto;

	SubmitForm(form);
}

//function recuperar datos de un producto para añadir linea pedido
function DatosProducto(){
	var form = document.forms['form1'];
	var jsForm = document.forms['MensajeJS'];
	var msg = '';

	var moId	= form.elements['MOID'].value;
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
                            "<td>"+"<div class='boton'><a href='javascript:Actualizar(\"NUEVA_LINEA\");'>"+jsForm.elements['ENVIAR'].value+"</a></div>"+"</td>"+
                            "<td class='datosLeft'><input type='text' name='ID_PROD' id='ID_PROD' size='10' value='" + data.DatosProducto.PRO_ID+"'  style='display:none;' /></td>" +
                            "<td colspan='3'> </td>";

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
var form = document.forms['form1'];
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
     	var form = document.forms['form1'];
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
        var form=document.forms['form1'];
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
