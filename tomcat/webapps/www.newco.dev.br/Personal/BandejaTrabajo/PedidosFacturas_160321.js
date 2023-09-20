// JS Página de Pedidos y facturas
// Ultima revisión ET: 16mar21 11:40 PedidosFacturas_160321.js

jQuery.noConflict();

//----------------------------------------------------------

jQuery(document).ready(globalEvents);

function globalEvents(){
}


function FiltrarBusqueda(){
	jQuery('#PAGINA').val('0');
	AplicarFiltro();
}


function AplicarFiltro(){
	var form=document.forms[0];
	form.action='PedidosFacturas.xsql';

	SubmitForm(form);
}

function ActivarGuardar(IDOferta)
{
	jQuery('#Guardar_'+IDOferta).show();
	jQuery('#OK_'+IDOferta).hide();
	jQuery('#Error_'+IDOferta).hide();
}

function Guardar(IDOferta)
{
	jQuery('#Guardar_'+IDOferta).hide();
	var Factura	= encodeURIComponent(jQuery('#Factura_'+IDOferta).val()),
		Pagado	= encodeURIComponent(jQuery('#Pagado_'+IDOferta).val()),
		d = new Date();


	jQuery.ajax({
		cache:	false,
		url:	'http://www.newco.dev.br/Personal/BandejaTrabajo/GuardarFacturaPagadoAJAX.xsql',
		type:	"GET",
		data:	"MO_ID="+IDOferta+"&FACTURA="+Factura+"&PAGADO="+Pagado+"&_="+d.getTime(),
		contentType: "application/xhtml+xml",
		beforeSend: function(){
			jQuery("#MensPedidoMinimo").hide();
		},
		error: function(objeto, quepaso, otroobj){
			jQuery('#Error_'+IDOferta).hide();
			console.log('Guardar '+IDOferta+' error:'+quepaso);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");

			if(data.Resultado.estado == 'OK'){
				jQuery('#OK_'+IDOferta).show();
			}else{
				jQuery('#Error_'+IDOferta).hide();
			}
		}
	});


}


//	16mar21 Copiado desde WFStatusHTML
function OrdenarPor(Orden){
	var form=document.forms[0];

	if(form.elements.ORDEN.value==Orden){
		if(form.elements.SENTIDO.value=='ASC') form.elements.SENTIDO.value='DESC';
		else  form.elements.SENTIDO.value='ASC';
	}else{
		form.elements.ORDEN.value=Orden;
		form.elements.SENTIDO.value='ASC';
	}
	AplicarFiltro();
}



//	16mar21 Copiado desde WFStatusHTML
function DescargarExcel(){
  var form=document.forms[0];
	var IDEmpresa='', IDCentro='', IDProveedor='', IDFiltroMotivo='', IDFiltroResponsable='', IDFiltroEstado='', IDFiltroSemaforo='';
	var IDFiltroTipoPedido='', bloqueado='', farmacia='', material='', codigoPedido='', sinStocks='', producto='', todos12meses='S';
	var incFueraPlazo='', pedEntregadoOk='', pedPedidoNoCoincide='', pedRetrasado='', pedEntregadoParcial='', pedRetrasoDocTecnica='';
	var pedNoInformadoPlataforma='', pedProductosAnadidos='', pedProductosRetirados='', fechaInicio='', fechaFinal='', pedMalaAtencionProv='';
	var pagina='', lineasPorPagina='', Urgente='', buscarPacks='',busqEspeciales='';

  if(form.elements.IDEMPRESA && form.elements.IDEMPRESA.value !== '') IDEmpresa = form.elements.IDEMPRESA.value;

  if(form.elements.IDCENTRO && form.elements.IDCENTRO.value !== '') IDCentro = form.elements.IDCENTRO.value;

  if(form.elements.IDPROVEEDOR && form.elements.IDPROVEEDOR.value !== '') IDProveedor = form.elements.IDPROVEEDOR.value;

  if(form.elements.IDFILTROMOTIVO && form.elements.IDFILTROMOTIVO.value !== '') IDFiltroMotivo = form.elements.IDFILTROMOTIVO.value;

  if(form.elements.IDFILTRORESPONSABLE && form.elements.IDFILTRORESPONSABLE.value !== '') IDFiltroResponsable = form.elements.IDFILTRORESPONSABLE.value;

  if(form.elements.IDFILTROESTADO && form.elements.IDFILTROESTADO.value !== '') IDFiltroEstado = form.elements.IDFILTROESTADO.value;

  if(form.elements.IDFILTROSEMAFORO && form.elements.IDFILTROSEMAFORO.value !== '') IDFiltroSemaforo = form.elements.IDFILTROSEMAFORO.value;

  if(form.elements.IDFILTROTIPOPEDIDO && form.elements.IDFILTROTIPOPEDIDO.value !== '') IDFiltroTipoPedido = form.elements.IDFILTROTIPOPEDIDO.value;

  if(form.elements.CODIGOPEDIDO && form.elements.CODIGOPEDIDO.value !== '') codigoPedido = form.elements.CODIGOPEDIDO.value;

  if(form.elements.PRODUCTO && form.elements.PRODUCTO.value !== '') producto = form.elements.PRODUCTO.value;

  if(form.elements.FECHA_INICIO && form.elements.FECHA_INICIO.value !== '') fechaInicio = form.elements.FECHA_INICIO.value;

  if(form.elements.FECHA_FINAL && form.elements.FECHA_FINAL.value !== '') fechaFinal = form.elements.FECHA_FINAL.value;

  if(form.elements.PAGINA && form.elements.PAGINA.value !== '') pagina = form.elements.PAGINA.value;

  if(form.elements.LINEA_POR_PAGINA && form.elements.LINEA_POR_PAGINA.value !== '') lineasPorPagina = form.elements.LINEA_POR_PAGINA.value;
    
	var d = new Date();

	jQuery.ajax({
		url: 'http://www.newco.dev.br/Personal/BandejaTrabajo/WFStatusExcel.xsql',
		data: "IDEMPRESA="+IDEmpresa+"&IDCENTRO="+IDCentro+"&IDPROVEEDOR="+IDProveedor+"&IDFILTROMOTIVO="+IDFiltroMotivo+"&IDFILTRORESPONSABLE="+IDFiltroResponsable
					+"&IDFILTROESTADO="+IDFiltroEstado+"&IDFILTROSEMAFORO="+IDFiltroSemaforo+"&IDFILTROTIPOPEDIDO="+IDFiltroTipoPedido+"&FARMACIA="+farmacia
					+"&MATERIAL="+material+"&CODIGOPEDIDO="+codigoPedido+"&SINSTOCKS="+sinStocks+"&PRODUCTO="+producto+"&TODOS12MESES="+todos12meses
					+"&INCFUERAPLAZO="+incFueraPlazo+"&PED_ENTREGADOOK="+pedEntregadoOk+"&PED_PEDIDONOCOINCIDE="+pedPedidoNoCoincide+"&PED_RETRASADO="+pedRetrasado
					+"&PED_ENTREGADOPARCIAL="+pedEntregadoParcial+"&PED_RETRASODOCTECNICA="+pedRetrasoDocTecnica+"&PED_NOINFORMADOPLATAFORMA="+pedNoInformadoPlataforma
					+"&PED_PRODUCTOSANYADIDOS="+pedProductosAnadidos+"&FECHA_INICIO="+fechaInicio+"&FECHA_FINAL="+fechaFinal+"&PED_MALAATENCIONPROV="+pedMalaAtencionProv
					+"&PED_URGENTE="+Urgente+"&PAGINA="+pagina+"&LINEA_POR_PAGINA="+lineasPorPagina+"&BUSCAR_PACKS="+buscarPacks+"&BUSQUEDASESPECIALES="+busqEspeciales+"&_="+d.getTime(),
    type: "GET",
    contentType: "application/xhtml+xml",
    error: function(objeto, quepaso, otroobj){
      alert('error'+quepaso+' '+otroobj+''+objeto);
    },
    success: function(objeto){
      var data = eval("(" + objeto + ")");

      if(data.estado == 'ok')
        window.location='http://www.newco.dev.br/Descargas/'+data.url;
      else
        alert('Se ha producido un error. No se puede descargar el fichero.');
    }
  });
}

