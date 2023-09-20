// JS para la ficha de producto (catálogo proveedor)
// Ultima revisión: ET 9may19 17:35

jQuery(document).ready(globalEvents);

var idPestannaActiva;

function globalEvents(){
	if(IDEmpresaCompradora != '' && jQuery('#IDCLIENTE').length){
		jQuery('#IDCLIENTE').val(IDEmpresaCompradora);
	}
/*
	jQuery("li a").click(function(){
		var id = jQuery(this).attr('id');

		//solodebug		alert('click: id:'+id+ ' tabla visible actual:'+idPestannaActiva);
		DesactivarPestanna(idPestannaActiva);

		//solodebug		alert("Escondidas tablas, preparado para mostrar:"+idPestannaActiva);
		ActivarPestanna("#"+id);
	});

	ActivarPestanna("#Tarifas");
*/
	//	12dic16	Marcamos la primera opción de menú
	jQuery("#pes_Ficha").css('background','#3b569b');
	jQuery("#pes_Ficha").css('color','#D6D6D6');

	// Se clica en pestañas
	jQuery("#pes_Documentos").click(function(){
 		//var IDProducto = document.forms['form1'].elements['IDPRODUCTO'].value;
		window.location.assign("http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PRODocs.xsql?PRO_ID="+IDProducto);
	});
	jQuery("#pes_Pack").click(function(){
 		//var IDProducto = document.forms['form1'].elements['IDPRODUCTO'].value;
		window.location.assign("http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROPack.xsql?PRO_ID="+IDProducto);
	});
	/*	Desactivamos pestaña equivalentes
	jQuery("#pes_Equiv").click(function(){
 		verPestana('EQUIV'));
	});
	*/
	jQuery("#pes_Eval").click(function(){
 		//var IDProducto = document.forms['form1'].elements['IDPRODUCTO'].value;
 		//var IDProveedor = document.forms['form1'].elements['IDPROVEEDOR'].value;
	
		window.location.assign("http://www.newco.dev.br/Gestion/Comercial/NuevaEvaluacionProducto.xsql?PRO_ID="+IDProducto+"&amp;EMP_ID="+IDProveedor);
	});


}

function abrirVentana(pag){
	window.open(pag,toolbar='no',menubar='no',status='no',scrollbars='yes',resizable='yes');
}

function MostrarProdEstandar(idProductoEstandar){
	MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantProductosEstandar.xsql?CATPRIV_IDPRODUCTOESTANDAR='+idProductoEstandar+'&ACCION=CONSULTARPRODUCTOESTANDAR&TIPO=CONSULTA&VENTANA=NUEVA','prodEstandar',100,80,0,0);
}

function Salir()
{
	window.close();
}

function Borrar(){
	var form = document.forms['Busqueda'];

	if (form.elements['PRO_ID'].value != '')
	{
		if(confirm(seguroBorrarProducto)==true)
		{
  			SubmitForm(document.forms[0]);
		}
	}
}

function verCadenaBusqueda(cadena){
	alert(cadena);
}


//funcion que enseña en el eis los datos del centro o de la empresa segun un producto, agrupar por producto siempre
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

function verTablas70(id)
{
	console.log("verTablas70:"+id);

	var k = id+"Div";

	jQuery(".tablas70").hide();
	jQuery("#PestanasInicio .catorce").css("background","#E3E2E2");
	jQuery("#"+id).css("background","#C3D2E9");
	jQuery("#"+k).show();
}

function abrirFichaCatalogacion(idProd, cliente)
{
	MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducido.xsql?PRO_ID=' + idProd +"&EMP_ID=" + cliente +"&ORIGEN=DETALLEPROD", +'Ficha de catalogación',100,70,0,40);
}




