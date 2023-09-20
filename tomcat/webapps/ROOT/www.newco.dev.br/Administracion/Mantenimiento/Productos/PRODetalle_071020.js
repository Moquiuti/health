// JS para la ficha de producto (catálogo proveedor)
// Ultima revisión: ET 07oct20 12:30 PRODetalle_071020.js
jQuery(document).ready(globalEvents);

var idPestannaActiva;

function globalEvents(){
	if(IDEmpresaCompradora != '' && jQuery('#IDCLIENTE').length){
		jQuery('#IDCLIENTE').val(IDEmpresaCompradora);
	}

	jQuery("li a").click(function(){
		var id = jQuery(this).attr('id');

		console.log("click en pestaña:"+id);

		//solodebug		alert('click: id:'+id+ ' tabla visible actual:'+idPestannaActiva);
		DesactivarPestanna(idPestannaActiva);

		//solodebug		alert("Escondidas tablas, preparado para mostrar:"+idPestannaActiva);
		ActivarPestanna("#"+id);
	});

	ActivarPestanna("#Tarifas");

}

//	15dic16	desactiva una pestanna y esconde la tabla
function DesactivarPestanna(idPestanna)
{
	jQuery(idPestanna+"Box").hide();
	ColoresPestanna(idPestanna,'#555555','#E0E0E0');
	idPestannaActiva='';
}

//	15dic16	desactiva una pestanna y esconde la tabla
function ActivarPestanna(idPestanna)
{
	jQuery(idPestanna+"Box").show();
	ColoresPestanna(idPestanna,'#F0F0F0','#3d5d95');
	idPestannaActiva=idPestanna;
}

//	15dic16	desactiva una pestanna y esconde la tabla
function ColoresPestanna(idPestanna, texto, fondo)
{
	jQuery(idPestanna).css('background',fondo);
	jQuery(idPestanna).css('color',texto);
}

function getURLParameter(name){
	// Se ha seleccionado la pestanya 'Equivalentes' => Mostrar contenido
	if(decodeURI((RegExp(name + '=' + '(.+?)(&|$)').exec(location.search)||[,null])[1]) == 'EQUIV'){
		verPestana('EQUIV');
	}
}

function abrirVentana(pag){
	window.open(pag,toolbar='no',menubar='no',status='no',scrollbars='yes',resizable='yes');
}

function MostrarProdEstandar(idProductoEstandar){
	MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantProductosEstandar.xsql?CATPRIV_IDPRODUCTOESTANDAR='+idProductoEstandar+'&ACCION=CONSULTARPRODUCTOESTANDAR&TIPO=CONSULTA&VENTANA=NUEVA','prodEstandar',100,80,0,0);
}

function Salir(){
	window.close();
}

function Borrar(){
var form = document.forms['Busqueda'];

if (form.elements['PRO_ID'].value != ''){
if(confirm(seguroBorrarProducto)==true){
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

function verTablas70(id){
console.log

var k = id+"Div";

jQuery(".tablas70").hide();
jQuery("#PestanasInicio .catorce").css("background","#E3E2E2");
jQuery("#"+id).css("background","#C3D2E9");
jQuery("#"+k).show();
}

function abrirFichaCatalogacion(idProd, cliente){
MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/MantenimientoReducido/MantenimientoReducido.xsql?PRO_ID=' + idProd +"&EMP_ID=" + cliente +"&ORIGEN=DETALLEPROD", +'Ficha de catalogación',100,70,0,40);
}
