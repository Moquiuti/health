/*
	Buscador para preparar pedidos desde catalogo privado
	Ultima revision: ET 11mar21 16:00. PedidoDesdeCatalogo_110321.js
*/

//	Inicializar botones y contador
function onLoad()
{
	numSeleccionados=0;
	numSeleccionadosPant=0;

	//	Recorre la cadena de productos seleccionados
	var Sel=jQuery('#SELECCIONADOS').val();

	if (Sel!='')
		jQuery('#IDPROVEEDOR').prop('disabled', 'disabled');

	for (var i=0;i<PieceCount(Sel,'|');++i)
	{
		++numSeleccionados;

		var IDProducto=Piece(Sel,'|',i);

		//solodebug console.log('onLoad. Marcar IDProducto:'+IDProducto);

		if (jQuery('#btnInsertar_'+IDProducto).length>0)
		{
			++numSeleccionadosPant;
			jQuery('#btnInsertar_'+IDProducto).hide();
			jQuery('#btnQuitar_'+IDProducto).show();
		}

	}

	PresentaSeleccionados();
}

// Presenta el numero de productos seleccionados y el total
function PresentaSeleccionados()
{
	jQuery('#Contador').html(numSeleccionadosPant+'/'+totProductos);

	//solodebug console.log('PresentaSeleccionados Marcar numSeleccionados:'+numSeleccionados);

	if (numSeleccionados>0)
	{
		jQuery('#btnPedido').html(strPedido.replace('[NUMPRODUCTOS]',numSeleccionados));
		jQuery('#btnPedido').show();
	}
	else
	{
		jQuery('#btnPedido').hide();
	}
}

// Buscar: envia el formulario
function Buscar()
{
	SubmitForm(document.forms['Busqueda']);
}

//	8mar21 Al seleccionar una familia, selecciona en el desplegable y aplica el filtro
function Familia(IDFamilia)
{
	jQuery('#IDFAMILIA').val(IDFamilia);
	Buscar();
}

//	cambia de pagina y envia
function Enviar(Accion)
{
	form=document.forms['Busqueda'];
	if(Accion=='ANTERIOR')
	{               //	Guarda resultados y retrocede a la pagina anterior
   		form.elements['PAGINA'].value=parseInt(form.elements['PAGINA'].value)-1;
	}
	else if (Accion=='SIGUIENTE')
	{       //	Guarda resultados y avanza a la pagina siguiente
   		form.elements['PAGINA'].value=parseInt(form.elements['PAGINA'].value)+1;
	}
	SubmitForm(form);
}

//	Ordenación de este listado
function OrdenarPor(Orden){
	var form=document.forms['Busqueda'];

	if(form.elements['ORDEN'].value==Orden){
    if(form.elements['SENTIDO'].value=='ASC') form.elements['SENTIDO'].value='DESC';
    else  form.elements['SENTIDO'].value='ASC';
  }else{
    form.elements['ORDEN'].value=Orden;
    form.elements['SENTIDO'].value='ASC';
  }

  form.elements['PAGINA'].value=0;
  SubmitForm(form);
}


//ver detalle producto
//usuario minimalista ve solo info base producto
function verDetalleProducto(idProd){
  jQuery("#detalleProd tbody").empty();

  if(idProd != ''){
    jQuery.ajax({
	    url: 'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODetalleAJAX.xsql',
	    data: "PRO_ID="+idProd,
      type: "GET",
      contentType: "application/xhtml+xml",
      beforeSend: function(){
        null;
      },
      error: function(objeto, quepaso, otroobj){
        alert('error'+quepaso+' '+otroobj+''+objeto);
      },
      success: function(objeto){
        var data = eval("(" + objeto + ")");
        var tbodyProd = "";

        tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ nombre +":</td><td class='datosLeft'>"+data.Producto.nombre+"</td></tr>";
        tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ ref_proveedor +":</td><td class='datosLeft'>"+data.Producto.ref_prove+"</td></tr>";
        tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ proveedor +":</td><td class='datosLeft'>"+data.Producto.prove+"</td>";
        if(data.Producto.imagen != ''){
          tbodyProd +=  "<td rowspan='4'><img src='http://www.newco.dev.br/Fotos/"+data.Producto.imagen+"' /></td>";
        }
        tbodyProd +="</tr>";
        tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ ref_estandar +":</td><td class='datosLeft'>"+data.Producto.ref_estandar+"</td></tr>";
        tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ marca +":</td><td class='datosLeft'>"+data.Producto.marca+"</td></tr>";
        if(data.Producto.pais != '55'){
          tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ iva +":</td><td class='datosLeft'>"+data.Producto.iva+"</td></tr>";
        }
        tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ unidad_basica +":</td><td class='datosLeft'>"+data.Producto.un_basica+"</td></tr>";
        tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ unidad_lote +":</td><td class='datosLeft'>"+data.Producto.un_lote+"</td></tr>";
        if(data.Producto.farmacia != ''){
          tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ farmacia +":</td><td class='datosLeft'>"+data.Producto.farmacia+"</td></tr>";
        }
        if(data.Producto.homologado != ''){
          tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ homologado +":</td><td class='datosLeft'>"+data.Producto.homologado+"</td></tr>";
        }
        if(data.Producto.categoria != '' && data.Producto.categoria != 'DEFECTO'){
          tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ catalogo +":</td><td class='datosLeft'>"+data.Producto.categoria+"</td></tr>";
        }
        tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ familia +":</td><td class='datosLeft'>"+data.Producto.familia+"</td></tr>";
        tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ subfamilia +":</td><td class='datosLeft'>"+data.Producto.sub_familia+"</td></tr>";
        if(data.Producto.grupo != '' && data.Producto.categoria != 'DEFECTO'){
          tbodyProd +=  "<tr><td class='labelRight grisMed'>"+ grupo +":</td><td class='datosLeft'>"+data.Producto.grupo+"</td></tr>";
        }

        jQuery("#detalleProd tbody").append(tbodyProd);
        showTabla(true);
      }
    });
  }
}//fin de verDetalleProducto

//	Inserta un producto en la lista para preparar pedido
function Insertar(IDProducto, IDProveedor)
{
	var Sel=jQuery('#SELECCIONADOS').val();

	//solodebug	
	console.log('Insertar. Sel:'+Sel+' cad:'+IDProducto+'|'+ ' IDProveedor:'+IDProveedor);

	if (Sel.indexOf(IDProducto+'|')==-1)
	{
		Sel+=IDProducto+'|';
		jQuery('#SELECCIONADOS').val(Sel);
		++numSeleccionados;
		++numSeleccionadosPant;

		jQuery('#btnInsertar_'+IDProducto).hide();
		jQuery('#btnQuitar_'+IDProducto).show();
		
		if (numSeleccionados==1) Buscar()
		else PresentaSeleccionados();
	}

	//solodebug	console.log('Insertar. Sel:'+Sel);
}

//	Inserta un producto en la lista para preparar pedido
function Quitar(IDProducto)
{
	var Sel=jQuery('#SELECCIONADOS').val();

	//solodebug	console.log('Quitar Sel:'+Sel+' cad:'+IDProducto+'|');

	Sel=Sel.replace(IDProducto+'|','');
	jQuery('#SELECCIONADOS').val(Sel);
	--numSeleccionados;
	--numSeleccionadosPant;

	jQuery('#btnInsertar_'+IDProducto).show();
	jQuery('#btnQuitar_'+IDProducto).hide();
	PresentaSeleccionados();

	//solodebug	console.log('Quitar Sel:'+Sel);
}

//	Pasa al siguiente paso del pedido
function Pedido()
{

	/*console.log('Pedido. IDCliente:'+document.forms['Busqueda'].elements['IDEMPRESA'].value
				+' IDProveedor:'+document.forms['Busqueda'].elements['IDPROVEEDOR'].value
				+' Seleccionados:'+document.forms['Busqueda'].elements['SELECCIONADOS'].value);
	*/
	var Url='http://www.newco.dev.br/Compras/Multioferta/LPAnalizarFrame.xsql?IDEMPRESA='+document.forms['Busqueda'].elements['IDEMPRESA'].value
				+'&IDPROVEEDOR='+document.forms['Busqueda'].elements['IDPROVEEDOR'].value
				+'&SELECCIONADOS='+document.forms['Busqueda'].elements['SELECCIONADOS'].value;
				
	window.location=Url;
}
