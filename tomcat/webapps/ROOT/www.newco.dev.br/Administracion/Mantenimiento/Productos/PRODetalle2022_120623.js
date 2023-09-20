// JS para la ficha de producto (catálogo proveedor)
// Ultima revisión: ET 12jun23 16:21 PRODetalle2022_120623.js

jQuery(document).ready(globalEvents);

var idPestannaActiva;

function globalEvents(){
	if(IDEmpresaCompradora != '' && jQuery('#IDCLIENTE').length){
		jQuery('#IDCLIENTE').val(IDEmpresaCompradora);
	}

	jQuery(".pestannas a").click(function(){
		var id = jQuery(this).attr('id');

		//solodebug		console.log("click en pestaña:"+id);

		//solodebug		alert('click: id:'+id+ ' tabla visible actual:'+idPestannaActiva);
		//DesactivarPestanna(idPestannaActiva);

		//solodebug		alert("Escondidas tablas, preparado para mostrar:"+idPestannaActiva);
		ActivarPestanna("#"+id);
	});

	ActivarPestanna("#Tarifas");

}

//	15dic16	desactiva una pestanna y esconde la tabla
function ActivarPestanna(idPestanna)
{
	//1ago22	jQuery(".pestannas a").css('background','#E0E0E0');
	//1ago22	jQuery(".pestannas a").css('color','#555555');

	jQuery(".menuProd").attr('class', 'menuProd MenuInactivo');
	jQuery(idPestanna).attr('class', 'menuProd MenuActivo');

	jQuery(".tbDetalle").hide();
	jQuery(idPestanna+"Box").show();
	
	//1ago22	ColoresPestanna(idPestanna,'#F0F0F0','#3d5d95');
	
	idPestannaActiva=idPestanna;
}

/*1ago22
//	15dic16	desactiva una pestanna y esconde la tabla
function ColoresPestanna(idPestanna, texto, fondo)
{
	jQuery(idPestanna).css('background',fondo);
	jQuery(idPestanna).css('color',texto);
}
*/

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
	MostrarPagPersonalizada('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/MantProductosEstandar2022.xsql?CATPRIV_IDPRODUCTOESTANDAR='+idProductoEstandar+'&ACCION=CONSULTARPRODUCTOESTANDAR&TIPO=CONSULTA&VENTANA=NUEVA','prodEstandar',100,80,0,0);
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


//	19may22 Abrimos la pagina de analisis de pedidos
function AnalisisPedidos(IDProducto)
{
	document.location="http://www.newco.dev.br/Personal/BandejaTrabajo/AnalisisPedidos2022.xsql?IDPRODUCTO="+IDProducto;
}

//	12jun23 Abrimos la pagina de historico de tarifas
function HistoricoTarifas(IDProducto, IDCliente)
{
	document.location="http://www.newco.dev.br/Personal/BandejaTrabajo/HistoricoTarifasProducto2022.xsql?IDEMPRESA="+IDCliente+"&IDPRODUCTO="+IDProducto;
}



//	10jun22 Abrimos la pagina de contenido del pack
function VerPack(IDProducto)
{
	MostrarPagPersonalizada("http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROPack2022.xsql?PRO_ID="+IDProducto,'Pack del producto',100,80,0,-10);
}



