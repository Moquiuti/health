//	JS Buscador de productos en catalogos privados
//	Ultima revision: ET 9jun22 11:26 CatalogoPrivadoProducto2022_090622.js

function Buscar(){
	var form = document.forms['catalogo'];
	var idEmpresa = form.elements['IDEMPRESA'].value;
    var origen = form.elements['ORIGEN'].value;
    var inputSol = form.elements['INPUT_SOL'].value;
	var dataSol = "ORIGEN="+origen+"&INPUT_SOL="+inputSol;

	//si busco desde el manten reducido, catalogo de producto
	if((idEmpresa != '') && (origen != 'SOLICITUD')){
		document.forms['catalogo'].action="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoPrivadoProductoEmpresa2022.xsql?ORIGEN="+origen;
		SubmitForm(document.forms['catalogo']);
	}
    else if ((origen == 'SOLICITUD') || (origen == 'LICITACION')	|| (origen == 'PEDIDOSTEXTO'))
	{
		document.forms['catalogo'].action="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoPrivadoProductoEmpresa2022.xsql?"+dataSol;
		SubmitForm(document.forms['catalogo']);
	}
	else
	{
		document.forms['catalogo'].action="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoPrivadoProducto2022.xsql";
		SubmitForm(document.forms['catalogo']);
	}
}

function InsertarMantenimientoReducido(ref){
	var objFrameTop=new Object();
	objFrameTop=window.opener.top;
	var FrameOpenerName=window.opener.name;
	var objFrame=new Object();
	objFrame=obtenerFrame(objFrameTop,FrameOpenerName);

	//inserto ref en campo input referencia
	var formMant = objFrame.document.forms['form1'];
	formMant.elements['REFERENCIACLIENTE'].value = ref;

	window.close();
}

function InsertarPROManten(ref,precio,udba)
{
	var objFrameTop=new Object();
	objFrameTop=window.opener.top;
	var FrameOpenerName=window.opener.name;
	var objFrame=new Object();
	objFrame=obtenerFrame(objFrameTop,FrameOpenerName);

	objFrame.document.getElementById('refPrecioObjetivo').style.display = 'none';
	//inserto ref en campo input referencia
	var formMant = objFrame.document.forms['form1'];
	formMant.elements['PRO_REF_ESTANDAR'].value = ref;

	if(precio != '')
	{
		formMant.elements['PRECIO_CAT_PRIV'].value = precio;
		formMant.elements['UDBA_CAT_PRIV'].value = udba;
		objFrame.document.getElementById('refPrecioObjetivo').style.display = 'block';
	}
	else
	{
	objFrame.document.getElementById('refPrecioObjetivo').style.display = 'none';
    }

	window.close();
}

//insertar la ref producto en campo input de nueva evaluacion producto
function InsertarPROEvaluacion(ref)
{
	var objFrameTop=new Object();
	objFrameTop=window.opener.top;
	var FrameOpenerName=window.opener.name;
	var objFrame=new Object();

	objFrame=obtenerFrame(objFrameTop,FrameOpenerName);

	//inserto ref en campo input referencia
	var form = objFrame.document.forms['EvaluacionProducto'];
	form.elements['REF_PROD'].value = ref;
	objFrame.document.getElementById("botonBuscarEval").style.display = 'none';
	objFrame.document.getElementById("botonRecuperarProd").style.display = 'block';

	//llamo la funciona en evaluaciones.js
	window.opener.top.RecuperarDatosProducto();
	window.close();
}

//insertar la ref producto en campo input de nueva oferta stock
function InsertarPROStock(ref){
	var objFrameTop=new Object();
	objFrameTop=window.opener.top;
	var FrameOpenerName=window.opener.name;
	var objFrame=new Object();

	objFrame=obtenerFrame(objFrameTop,FrameOpenerName);

	//inserto ref en campo input referencia
	var form = objFrame.document.forms['frmStockOfertaID'];
	form.elements['STOCK_REF_CLIENTE'].value = ref;

	//llamo la funciona en stockoferta.js
	window.opener.top.RecuperarDatosProducto();
	window.close();
	}

//insertar la ref producto en campo input de una solicitud
function InsertarPROSolicitud(ref,inputSol)
{
	var objFrameTop=new Object();
	objFrameTop=window.opener.top;
	var FrameOpenerName=window.opener.name;
	var objFrame=new Object();

	objFrame=obtenerFrame(objFrameTop,FrameOpenerName);

	//inserto ref en campo input referencia
	var form = objFrame.document.forms['SolicitudCatalogacion'];
	form.elements[inputSol].value = ref;

	var solProdID = jQuery('#INPUT_SOL').val().replace('PROD_ESTAN_','');
	var IDEmpresa = jQuery('#IDEMPRESA').val();
	//llamo la funciona en solicitudes.js
	window.opener.top.recuperarIDProdEstandard(IDEmpresa,solProdID);

	//objFrame.document.getElementById("botonBuscarEval").style.display = 'none';
	//objFrame.document.getElementById("botonRecuperarProd").style.display = 'block';

	window.close();
}

//insertar la ref producto en campo input grande de licitacion de productos
function InsertarPROLicitacion(ref)
{
	var form;
	
	if (window.opener.top.name)
	{	
		var objFrameTop=new Object();
		objFrameTop=window.opener.top;
		//console.log('objFrameTop: '+objFrameTop.name);
		var FrameOpenerName=window.opener.name;
		//console.log('FrameOpenerName: '+FrameOpenerName);
		objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
		//console.log('objFrame: '+objFrame);
		form = objFrame.document.forms['RefProductos'];
	}
	else
	{
		var Vent=window.opener;
		console.log('Vent: '+Vent.name);
		form = Vent.document.forms['frmIncluirProductos'];
	}
	//inserto ref en campo input referencia
	console.log('form: '+form.name);
	console.log('LIC_LISTA_REFPRODUCTO: '+form.elements['LIC_LISTA_REFPRODUCTO'].value);
	
	
	//compruebo si el producto ya esta insertado
	if(form.elements['LIC_LISTA_REFPRODUCTO'].value.match(ref))
	{
		alert(document.forms['mensajeJS'].elements['REF_YA_INSERTADA'].value);
	}
	else
	{
		form.elements['LIC_LISTA_REFPRODUCTO'].value += ref+'\n';
	}
}
//-->

//insertar la ref producto en campo input grande pedidos desde fichero de texto
function InsertarPrepararPedidoTexto(ref)
{

	console.log('InsertarPrepararPedidoTexto: '+ref);

	var objFrameTop=new Object();
	objFrameTop=window.opener.top;
	console.log('objFrameTop: '+objFrameTop);

	var FrameOpenerName=window.opener.name;
	console.log('FrameOpenerName: '+FrameOpenerName);

	var objFrame=new Object();
	objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
	console.log('objFrame: '+objFrame);

	//inserto ref en campo input referencia
	var form = objFrame.document.forms['SubirDocumentos'];
	console.log('form: '+form);
	//compruebo si el producto ya esta insertado
	if(form.elements['TXT_PRODUCTOS'].value.match(ref))
	{
		alert(document.forms['mensajeJS'].elements['REF_YA_INSERTADA'].value);
	}
	else
	{
		form.elements['TXT_PRODUCTOS'].value += ref+'\n';
	}
}

//insertar la ref producto en campo input de mantenimiento de pedidos
function InsertarMantenimientoPedido(ref)
{

	console.log('InsertarMantenimientoPedido '+ref);

	var objFrameTop=new Object();
	objFrameTop=window.opener.top;
	console.log('objFrameTop: '+objFrameTop);

	//inserto ref en campo input referencia
	var form = objFrameTop.document.forms['frmMantenPedido'];
	//console.log('form: '+form);
	//compruebo si el producto ya esta insertado
	if(form.elements['NEWLINE_REFPROV'].value==ref)
	{
		alert(document.forms['mensajeJS'].elements['REF_YA_INSERTADA'].value);
	}
	else
	{
		form.elements['NEWLINE_REFPROV'].value = ref+'\n';
	}
}

//Activar el cambio de producto estandar en la ficha de producto de licitacion
function SustituirProductoLicitacion(id, ref, nombre, marca)
{

	//console.log('SustituirProductoLicitacion id:'+id+'. ref'+ref+'. nombre'+nombre);

	var objFrameTop=new Object();
	objFrameTop=window.opener.top;
	//console.log('objFrameTop: '+objFrameTop);

	//	El aviso lo mostramos desde esta pagina
	if (marca!='') nombre=nombre+' ['+marca+']';
	if (confirm(alrt_CambiarProductoEstandar.replace('[[REF]]',ref).replace('[[PRODUCTO]]',nombre)))
	{
		objFrameTop.SustituirProductoLicitacion(id, ref, nombre);
		window.close();
	}
}
//-->

//	18ago16	Funciones para paginación del listado
function Pagina0() {BuscarDesde0();}
function BuscarDesde0() {document.forms[0].elements['PAGINA'].value=0; Buscar();}
function PaginaAnterior() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)-1; Buscar();}
function PaginaSiguiente() {document.forms[0].elements['PAGINA'].value=parseInt(document.forms[0].elements['PAGINA'].value)+1; Buscar();}
