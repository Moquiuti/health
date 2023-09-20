// JS Página de Inicio
// Ultima revisión ET: 7mar19 11:29

jQuery.noConflict();

//----------------------------------------------------------

jQuery(document).ready(globalEvents);

const Tipo="WFStatus";

const arrayCheck = ["BLOQUEADO", "NOCUMPLEPEDMIN","PED_URGENTE", "SINSTOCKS", "INCFUERAPLAZO", "TODOS12MESES", "PED_ENTREGADOOK", "PED_PEDIDONOCOINCIDE", "PED_RETRASADO", "PED_ENTREGADOPARCIAL",
		 "PED_NOINFORMADOENPLATAFORMA","PED_PRODUCTOSANYADIDOS", "PED_PRODUCTOSRETIRADO", "PED_MALAATENCIONPROV", "PED_RETRASODOCTECNICA", "BUSCAR_PACKS"];


function globalEvents(){

	//solodebug	console.log("Start OnLoad: " + (new Date()));
    
	//para cargar documentos
    	addEventListener('load', iniciar);
	
	/* 23ene17 jQuery(".cargar").click (function(e){
		cargaDoc();
	}); */
        
	jQuery(document).keypress(function(e){
		if(e.keyCode == 13){
			FiltrarBusqueda();
		}
	});

	//reclamar
	jQuery(".reclamarLink").mouseover (function(){ this.style.cursor="pointer"; });
	jQuery(".reclamarLink").mouseout (function(){ this.style.cursor="default"; });

	jQuery(".reclamarLink").click (function(){
		var k = this.id;
		var idpedido= k.split('_');
		var id = idpedido[1];
		if(document.getElementById('reclamarBox_'+id).style.display == 'none'){
			jQuery('#reclamarBox_'+id).show();
		}else{
			jQuery('#reclamarBox_'+id).hide();
		}
	});
	

//console.log("End OnLoad: " + (new Date() - start));
}//fin de globalEvent

function verCompacto(){
    var oForm = document.forms.Form1;

    if (oForm.elements.COMPACTO.checked === true)
        jQuery(".nocompacto").hide();
    else
        jQuery(".nocompacto").show();
}



function NuevoStockOferta(){
	MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/StockOferta.xsql','Nueva oferta stock',100,100,0,0);
}

function NoticiaLeida(IDNot){
	var d			= new Date();

	jQuery.ajax({
		url: 'http://www.newco.dev.br/Personal/BandejaTrabajo/NoticiaLeida.xsql',
		data: "ID_NOTICIA="+IDNot,
		type: "GET",
		contentType: "application/xhtml+xml",
		error: function(objeto, quepaso, otroobj){
			alert('error'+quepaso+' '+otroobj+''+objeto);
		},
		success: function(objeto){
			var data = eval("(" + objeto + ")");
      location.reload();
		}
	});
}

//marcar pedidos entregados MC 20-8-14
function MarcarEntregados(dias){
	jQuery.ajax({
		url:"marcarEntregados.xsql",
		data:"DIAS_ENTREGADO="+dias,
		type: "GET",
		contentType: "application/xhtml+xml",
		beforeSend:function(){
			document.getElementById('waitBoxEntregados').style.display = 'block';
			document.getElementById('waitBoxEntregados').src = 'http://www.newco.dev.br/images/loading.gif';
		},
		error:function(objeto, quepaso, otroobj){
			alert("objeto:"+objeto+" otroobj:"+otroobj+" quepaso:"+quepaso);
		},
		success:function(data){
			var doc=eval("(" + data + ")");
			document.getElementById('waitBoxEntregados').style.display = 'none';
			document.getElementById('confirmBoxEntregados').style.display = 'block';
			document.location.reload();
		}
	});
}//fin MarcarEntregados

//Reclamacion cliente 24-05-11 MC
function enviarReclamacion(id){
	var form=document.forms.Form1;
	var text= encodeURIComponent(form.elements['RECLAMAR_TEXT_'+id].value);

	jQuery.ajax({
		url:"confirmReclamacion.xsql",
		data:"ID_PEDIDO="+id+"&RECLAMAR_TEXT="+text+"&RECLAMACION=S",
		type: "GET",
		contentType: "application/xhtml+xml",
		beforeSend:function(){
			document.getElementById('waitBox_'+id).style.display = 'block';
			document.getElementById('waitBox_'+id).src = 'http://www.newco.dev.br/images/loading.gif';
		},
		error:function(objeto, quepaso, otroobj){
			alert("objeto:"+objeto+" otroobj:"+otroobj+" quepaso:"+quepaso);
		},
		success:function(data){
			var doc=eval("(" + data + ")");
			document.getElementById('waitBox_'+id).style.display = 'none';
			document.getElementById('confirmBox_'+id).style.display = 'block';
      		AplicarFiltro();
		}
	});
}//fin enviarReclamacion

//	22ene18	Enviar Comentarios 
function enviarConsulta(id){
	var form=document.forms.Form1;
	var text= encodeURIComponent(form.elements['RECLAMAR_TEXT_'+id].value);

	jQuery.ajax({
		url:"confirmReclamacion.xsql",
		data:"ID_PEDIDO="+id+"&RECLAMAR_TEXT="+text+"&RECLAMACION=N",
		type: "GET",
		contentType: "application/xhtml+xml",
		beforeSend:function(){
			document.getElementById('waitBox_'+id).style.display = 'block';
			document.getElementById('waitBox_'+id).src = 'http://www.newco.dev.br/images/loading.gif';
		},
		error:function(objeto, quepaso, otroobj){
			alert("objeto:"+objeto+" otroobj:"+otroobj+" quepaso:"+quepaso);
		},
		success:function(data){
			var doc=eval("(" + data + ")");
			document.getElementById('waitBox_'+id).style.display = 'none';
			document.getElementById('confirmComBox_'+id).style.display = 'block';
			
			
			//solodebug console.log('enviarConsulta id:'+id+ 'res:'+data);
			
      		AplicarFiltro();
		}
	});
}//fin enviarComentarios


// *************  JS WFSTATUSHTML:XSL ********************
function EnviarInfoProveedor(IDOferta){
        //id oferta es mo_id
	var form=document.forms[0];
        form.action = "WFStatusSave.xsql";
	form.enctype = "application/x-www-form-urlencoded";
	form.method = "post";
	form.target = '';
	var msg='', res='';		//para validar fecha

	form.elements.IDOFERTA.value=IDOferta;
	form.elements.FECHAPEDIDO.value=form.elements['FECHAPEDIDO_'+IDOferta].value;
	form.elements.NUEVAFECHAENTREGA.value=form.elements['NUEVAFECHAENTREGA_'+IDOferta].value;
	form.elements.IDMOTIVO.value=form.elements['IDMOTIVO_'+IDOferta].value;
	form.elements.COMENTARIOS.value=form.elements['COMENTARIOS_'+IDOferta].value;
	form.elements.ALBARAN.value=form.elements['ALBARAN_'+IDOferta].value;
    form.elements.IDALBARAN.value=form.elements['IDALBARAN_'+IDOferta].value;
	
	//solodebug alert('IDOferta:'+IDOferta+' fecha:'+form.elements['NUEVAFECHAENTREGA_'+IDOferta].value+' albaran:'+form.elements['ALBARAN_'+IDOferta].value+' idalbaran:'+form.elements['IDALBARAN_'+IDOferta].value);
       

	//	Validacion antes del envio
	//	Si no hay comentarios, hay que informar el estado del pedido
	if((form.elements.COMENTARIOS.value === '') && (form.elements.IDMOTIVO.value == 'NO_INFORMADO'))
		msg=msg+ document.forms.MensajeJS.elements.ANADIR_COMENTARIO_SITUACION.value +'\n';

	// albaran obligatorio
	if(((form.elements.IDMOTIVO.value=='ENVIADO') || (form.elements.IDMOTIVO.value=='PARCIAL')) && (form.elements.ALBARAN.value===''))
		msg=msg+document.forms.MensajeJS.elements.INFORMAR_ALBARAN.value+'\n';

	if(((form.elements.IDMOTIVO.value=='ENVIADO') || (form.elements.IDMOTIVO.value=='PARCIAL')) && (form.elements.NUEVAFECHAENTREGA.value===''))
		msg=msg+document.forms.MensajeJS.elements.FECHA_SALIDA_INFORMADA.value +'\n';

	else
	{
		//	control del formato de la fecha
		if(form.elements.NUEVAFECHAENTREGA.value!==''){
			res=CheckDate(form.elements.NUEVAFECHAENTREGA.value);

			if(res!=='') msg=msg+'- '+res;
			else{
				res=comparaFechas(form.elements.FECHAPEDIDO.value,form.elements.NUEVAFECHAENTREGA.value);
				if(res=='>') msg=msg+'- '+document.forms.MensajeJS.elements.FECHA_ENTRGA_MENOR.value +'\n';
			}

		}
	}

	if(((form.elements.IDMOTIVO.value=='ENVIADO') || (form.elements.IDMOTIVO.value=='PARCIAL')) && (form.elements.NUEVAFECHAENTREGA.value!=='') && (comparaFechas(form.elements.NUEVAFECHAENTREGA.value, form.elements.FECHAACTUAL.value )=='>'))
		msg=msg+document.forms.MensajeJS.elements.FECHA_SALIDA_DEBE_SER.value +'\n';

	if(form.elements.IDMOTIVO.value===''){
		msg=msg+document.forms.MensajeJS.elements.INFORMAR_ESTADO_PEDIDO.value +'\n';
	}

	if(msg===''){
		SubmitForm(form);
	}else{
		alert (msg);
	}
}



function ActivarBotonEnviar(IDOferta)
{
	if (isNaN(IDOferta)) IDOferta=Piece(IDOferta,'_',1);			//	20feb19 desde el control de albarán pasara una cadena IDALBARAN_IDOFERTA
	jQuery('#EnviarDatosProveedor_'+IDOferta).show();
}


function FiltrarBusqueda(){
	jQuery('#PAGINA').val('0');
	AplicarFiltro();
}


function AplicarFiltro(){
	var form=document.forms[0];
	form.action='WFStatus.xsql';

	var name = '', todosFalse = '', logChecks ='';

	for(var i=0; i< arrayCheck.length; i++){
		name=arrayCheck[i];
		logChecks+=name;
		if(form.elements[name+'_CHECK'] && form.elements[name+'_CHECK'].checked === true){
			form.elements[name].value = 'S';
			todosFalse += name +' | ';
			logChecks+='=S';
		}
		logChecks+=' ';
	}
	//solodebug	alert('AplicarFiltro:'+logChecks);

	SubmitForm(form);
}


//	9may18	Resumen situación pedidos
function ResumenPedidos(){
	var form=document.forms[0];
	form.action='ResumenPedidosActivos.xsql';
	
	var name = '', todosFalse = '', logChecks ='';

	for(var i=0; i< arrayCheck.length; i++){
		name=arrayCheck[i];
		logChecks+=name;
		if(form.elements[name+'_CHECK'] && form.elements[name+'_CHECK'].checked === true){
			form.elements[name].value = 'S';
			todosFalse += name +' | ';
			logChecks+='=S';
		}
		logChecks+=' ';
	}

	//solodebug	alert('Resumen:'+logChecks);

	SubmitForm(form);
}



function AplicarFiltroPagina(pag){
    var form=document.forms[0];
    form.elements.PAGINA.value = pag;
    AplicarFiltro();

}

function VerBuscadorAvanzado(){
    if(jQuery("#buscadorAvanzadoOne").is(":hidden")){
        jQuery(".buscadorAvanzado").show();
    }
    else{
        jQuery(".buscadorAvanzado").hide();
    }
}

function handleKeyPress(e) {
	var keyASCII;

	if(navigator.appName.match('Microsoft')) keyASCII=event.keyCode;
	else keyASCII = (e.which);

  if(keyASCII == 13)
		 AplicarFiltro();
}

function ControlPedidos(IDPedido){
	var form=document.forms[0];
	form.action='ControlPedidos.xsql?IDPEDIDO='+IDPedido;
	SubmitForm(form);
}

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

function Licitacion(ID){
	MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/Comercial/MantLicitacion.xsql?LIC_ID='+ID,'Licitaciï¿½n',100,100,0,0);
}

function AvisoPedidoBloqueado(){
	alert(document.forms.MensajeJS.elements.PEDIDO_PROB.value + '\n\r' +
		document.forms.MensajeJS.elements.PEDIDO_PROB1.value + ' \n\r' +
		document.forms.MensajeJS.elements.PEDIDO_PROB2.value);
}

function DescargarExcel(){
  var form=document.forms[0];
	var IDEmpresa='', IDCentro='', IDProveedor='', IDFiltroMotivo='', IDFiltroResponsable='', IDFiltroEstado='', IDFiltroSemaforo='';
	var IDFiltroTipoPedido='', bloqueado='', farmacia='', material='', codigoPedido='', sinStocks='', producto='', todos12meses='';
	var incFueraPlazo='', pedEntregadoOk='', pedPedidoNoCoincide='', pedRetrasado='', pedEntregadoParcial='', pedRetrasoDocTecnica='';
	var pedNoInformadoPlataforma='', pedProductosAnadidos='', pedProductosRetirados='', fechaInicio='', fechaFinal='', pedMalaAtencionProv='';
	var pagina='', lineasPorPagina='', Urgente='', buscarPacks='';

  if(form.elements.IDEMPRESA && form.elements.IDEMPRESA.value !== '') IDEmpresa = form.elements.IDEMPRESA.value;

  if(form.elements.IDCENTRO && form.elements.IDCENTRO.value !== '') IDCentro = form.elements.IDCENTRO.value;

  if(form.elements.IDPROVEEDOR && form.elements.IDPROVEEDOR.value !== '') IDProveedor = form.elements.IDPROVEEDOR.value;

  if(form.elements.IDFILTROMOTIVO && form.elements.IDFILTROMOTIVO.value !== '') IDFiltroMotivo = form.elements.IDFILTROMOTIVO.value;

  if(form.elements.IDFILTRORESPONSABLE && form.elements.IDFILTRORESPONSABLE.value !== '') IDFiltroResponsable = form.elements.IDFILTRORESPONSABLE.value;

  if(form.elements.IDFILTROESTADO && form.elements.IDFILTROESTADO.value !== '') IDFiltroEstado = form.elements.IDFILTROESTADO.value;

  if(form.elements.IDFILTROSEMAFORO && form.elements.IDFILTROSEMAFORO.value !== '') IDFiltroSemaforo = form.elements.IDFILTROSEMAFORO.value;

  if(form.elements.IDFILTROTIPOPEDIDO && form.elements.IDFILTROTIPOPEDIDO.value !== '') IDFiltroTipoPedido = form.elements.IDFILTROTIPOPEDIDO.value;

  if(form.elements.BLOQUEADO_CHECK) bloqueado = (form.elements.BLOQUEADO_CHECK.checked?'S':'N');

  //if(form.elements.FARMACIA && form.elements.FARMACIA.value !== '') farmacia = form.elements.FARMACIA.value;

  //if(form.elements.MATERIAL && form.elements.MATERIAL.value !== '') material = form.elements.MATERIAL.value;

  if(form.elements.CODIGOPEDIDO && form.elements.CODIGOPEDIDO.value !== '') codigoPedido = form.elements.CODIGOPEDIDO.value;

  if(form.elements.SINSTOCKS_CHECK) sinStocks =  (form.elements.SINSTOCKS_CHECK.checked?'S':'N');

  if(form.elements.PRODUCTO && form.elements.PRODUCTO.value !== '') producto = form.elements.PRODUCTO.value;

  if(form.elements.TODOS12MESES_CHECK) todos12meses = (form.elements.TODOS12MESES_CHECK.checked?'S':'N');

  if(form.elements.INCFUERAPLAZO_CHECK) incFueraPlazo = (form.elements.INCFUERAPLAZO_CHECK.checked?'S':'N');	

  if(form.elements.PED_ENTREGADOO_CHECKK) pedEntregadoOk = (form.elements.PED_ENTREGADOOK_CHECK.checked?'S':'N');

  if(form.elements.PED_PEDIDONOCOINCIDE_CHECK) pedPedidoNoCoincide = (form.elements.PED_PEDIDONOCOINCIDE_CHECK.checked?'S':'N');

  if(form.elements.PED_RETRASADO_CHECK) pedRetrasado = (form.elements.PED_RETRASADO_CHECK.checked?'S':'N');

  if(form.elements.PED_ENTREGADOPARCIAL_CHECK) pedEntregadoParcial = (form.elements.PED_ENTREGADOPARCIAL_CHECK.checked?'S':'N');

  if(form.elements.PED_RETRASODOCTECNICA_CHECK) pedRetrasoDocTecnica = (form.elements.PED_RETRASODOCTECNICA_CHECK.checked?'S':'N');

  if(form.elements.PED_NOINFORMADOPLATAFORMA_CHECK) pedNoInformadoPlataforma = (form.elements.PED_NOINFORMADOPLATAFORMA_CHECK.checked?'S':'N');

  if(form.elements.PED_PRODUCTOSANYADIDOS_CHECK) pedProductosAnadidos = (form.elements.PED_PRODUCTOSANYADIDOS_CHECK.checked?'S':'N');

  if(form.elements.PED_PRODUCTOSRETIRADOS) pedProductosRetirados = (form.elements.PED_PRODUCTOSRETIRADOS_CHECK.checked?'S':'N');

  if(form.elements.FECHA_INICIO && form.elements.FECHA_INICIO.value !== '') fechaInicio = form.elements.FECHA_INICIO.value;

  if(form.elements.FECHA_FINAL && form.elements.FECHA_FINAL.value !== '') fechaFinal = form.elements.FECHA_FINAL.value;

  if(form.elements.PED_MALAATENCIONPROV_CHECK) pedMalaAtencionProv = (form.elements.PED_MALAATENCIONPROV_CHECK.checked?'S':'N');

  if(form.elements.PAGINA && form.elements.PAGINA.value !== '') pagina = form.elements.PAGINA.value;

  if(form.elements.LINEA_POR_PAGINA && form.elements.LINEA_POR_PAGINA.value !== '') lineasPorPagina = form.elements.LINEA_POR_PAGINA.value;

  if(form.elements.PED_URGENTE && form.elements.PED_URGENTE.value !== '') Urgente = form.elements.PED_URGENTE.value;

  if(form.elements.BUSCAR_PACKS_CHECK) buscarPacks = (form.elements.BUSCAR_PACKS_CHECK.checked?'S':'N');
    
	var d = new Date();

	jQuery.ajax({
		url: 'http://www.newco.dev.br/Personal/BandejaTrabajo/WFStatusExcel.xsql',
		data: "IDEMPRESA="+IDEmpresa+"&IDCENTRO="+IDCentro+"&IDPROVEEDOR="+IDProveedor+"&IDFILTROMOTIVO="+IDFiltroMotivo+"&IDFILTRORESPONSABLE="+IDFiltroResponsable
					+"&IDFILTROESTADO="+IDFiltroEstado+"&IDFILTROSEMAFORO="+IDFiltroSemaforo+"&IDFILTROTIPOPEDIDO="+IDFiltroTipoPedido+"&FARMACIA="+farmacia
					+"&MATERIAL="+material+"&CODIGOPEDIDO="+codigoPedido+"&SINSTOCKS="+sinStocks+"&PRODUCTO="+producto+"&TODOS12MESES="+todos12meses
					+"&INCFUERAPLAZO="+incFueraPlazo+"&PED_ENTREGADOOK="+pedEntregadoOk+"&PED_PEDIDONOCOINCIDE="+pedPedidoNoCoincide+"&PED_RETRASADO="+pedRetrasado
					+"&PED_ENTREGADOPARCIAL="+pedEntregadoParcial+"&PED_RETRASODOCTECNICA="+pedRetrasoDocTecnica+"&PED_NOINFORMADOPLATAFORMA="+pedNoInformadoPlataforma
					+"&PED_PRODUCTOSANYADIDOS="+pedProductosAnadidos+"&FECHA_INICIO="+fechaInicio+"&FECHA_FINAL="+fechaFinal+"&PED_MALAATENCIONPROV="+pedMalaAtencionProv
					+"&PED_URGENTE="+Urgente+"&PAGINA="+pagina+"&LINEA_POR_PAGINA="+lineasPorPagina+"&BUSCAR_PACKS="+buscarPacks+"&_="+d.getTime(),
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



//	Para mostrar/ocultar la tabla de resumen
function MostrarTablaActividad()
{
	jQuery("#ResumenActividad").show();
	jQuery("#MostrarTablaActividad").hide();
	jQuery("#OcultarTablaActividad").show();
}

function OcultarTablaActividad()
{
	jQuery("#ResumenActividad").hide();
	jQuery("#MostrarTablaActividad").show();
	jQuery("#OcultarTablaActividad").hide();
}





















// *************  FIN JS WFSTATUSHTML:XSL ********************
