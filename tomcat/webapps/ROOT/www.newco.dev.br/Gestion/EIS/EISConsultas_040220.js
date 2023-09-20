//	Funciones Javascript
//	Ultima revisión ET 04feb20 EISConsultas_040220.js

jQuery(document).ready(globalEvents);

var arrayNormalizador = new Array(100);

function globalEvents(){


	//	Marcamos la primera opción de menú
	/*jQuery("#actividadMensual").css('background','#3b569b');
	jQuery("#actividadMensual").css('color','#D6D6D6');
	jQuery("#actividadMensual").css('color','#D6D6D6');*/
	jQuery("#actividadMensual").attr('class', 'MenuActivo');


	jQuery("#pestanas a").click(function(){

		var id = jQuery(this).attr('id');
		
		/*jQuery("a.MenuLic").css('background','#F0F0F0');
		jQuery("a.MenuLic").css('color','#555555');
		jQuery("#"+id).css('background','#3b569b');
		jQuery("#"+id).css('color','#D6D6D6');*/
		jQuery(".pestannas a").attr('class', 'MenuInactivo');
		jQuery("#"+id).attr('class', 'MenuActivo');
		
		jQuery(".eisBox").hide();
		jQuery("#"+id+"Box").show();
	});

	//GraficoDiarioGoogle();
	//GraficoMensualGoogle();

    //veo las varias tablas
    jQuery("#PestanasEis tr th").mouseover (function(){ this.style.cursor="pointer"; });
	jQuery("#PestanasEis tr th").mouseout (function(){ this.style.cursor="default"; });

}

/*
//en el on-load escondo el grafico diario, as? se ve la leyenda
function escondeDiario(){
	jQuery('#actividadDiariaBox').hide();
}

function expandirFilas(){
	jQuery('#expandir').hide();
	jQuery('#contraer').show();
	jQuery('.elemToogle').show();
}

function contraerFilas(){
	jQuery('#expandir').show();
	jQuery('#contraer').hide();
	jQuery('.elemToogle').hide();
}
*/
//	Presenta la pagina con el listado correspondiente a la seleccion del usuario
function MostrarConsulta(Consulta){
	var Enlace	= 'http://www.newco.dev.br/Gestion/EIS/EISBasico.xsql?'+'IDCONSULTA='+Consulta;

	MostrarPagPersonalizada(Enlace, '_blank', 100, 80, 0, 10);
}

//	Presenta la pagina con el listado correspondiente a la seleccion del usuario
function MostrarInicio(){
	var Enlace	= 'http://www.newco.dev.br/Gestion/EIS/EISInicio.xsql';

	MostrarPag(Enlace, '_blank');
}

//	Presenta la pagina con el listado correspondiente a la seleccion del usuario
function MostrarMatriz(){
	var Enlace	= 'http://www.newco.dev.br/Gestion/EIS/EISMatriz.xsql';

	MostrarPagPersonalizada(Enlace, '_blank', 100, 80, 0, 10);
}

//	Presenta la pagina con el EIS Anual
function MostrarConsultaAnual(){
	var Enlace	= 'http://www.newco.dev.br/Gestion/EIS/EISAnual.xsql';

	MostrarPagPersonalizada(Enlace, '_blank', 100, 80, 0, 10);
}

//	Presenta la pagina con las selecciones
function MostrarSelecciones(){
	var Enlace	= 'http://www.newco.dev.br/Gestion/EIS/EISSelecciones.xsql';

	MostrarPagPersonalizada(Enlace, '_blank', 100, 80, 0, 10);
}

/*
//version navegador para tele ense?o icono para babrir popup en nueva pagina
function navigador(){
	var browserName	= navigator.appName;
	var version	= navigator.appVersion;

	//tele browser Netscape version 5.0(X11;Linux i 686) AppleWebKit/534.7 (KHTML;like Gecko)
	if(version.match('X11;Linux i 686') || version.match('AppleWebKit/534.7')){
		jQuery('.newPage').show();
	}
}
*/

//info diaria + clientes seleccionados
/*
function infoDiariaClientes(){
	jQuery.ajax({
		url:"infoDiariaClientesJSON.xsql",
		data:"",
		type: "GET",
		contentType: "application/xhtml+xml",
		beforeSend:function(){
			//alert('mi');
			//document.getElementById('waitBoxEntregados').style.display = 'block';
			//document.getElementById('waitBoxEntregados').src = 'http://www.newco.dev.br/images/loading.gif';
		},
		error:function(objeto, quepaso, otroobj){
			alert("objeto:"+objeto);
			alert("otroobj:"+otroobj);
			alert("quepaso:"+quepaso);
		},
		success:function(data){
			var doc=eval("(" + data + ")");

		//alert('num ped act '+doc.infoDiaria.numPedidosDiaActual);
		jQuery("#numPedidosDiaActual").append(doc.infoDiaria.numPedidosDiaActual);
		jQuery("#importePedidosDiaActual").append(doc.infoDiaria.importePedidosDiaActual);
		jQuery("#controlPedidosDiaActual").append(doc.infoDiaria.controlPedidosDiaActual);

		jQuery("#incidenciasDiaActual").append(doc.infoDiaria.incidenciasDiaActual);
		jQuery("#evaluacionesDiaActual").append(doc.infoDiaria.evaluacionesDiaActual);
		jQuery("#licitacionesDiaActual").append(doc.infoDiaria.licitacionesDiaActual);

		jQuery("#numPedidosDiaAnterior").append(doc.infoDiaria.numPedidosDiaAnterior);
		jQuery("#importePedidosDiaAnterior").append(doc.infoDiaria.importePedidosDiaAnterior);
		jQuery("#controlPedidosDiaAnterior").append(doc.infoDiaria.controlPedidosDiaAnterior);

		jQuery("#incidenciasDiaAnterior").append(doc.infoDiaria.incidenciasDiaAnterior);
		jQuery("#evaluacionesDiaAnterior").append(doc.infoDiaria.evaluacionesDiaAnterior);
		jQuery("#licitacionesDiaAnterior").append(doc.infoDiaria.licitacionesDiaAnterior);

      if(typeof doc.Empresas != 'undefined'){
  			var lineasTabla = '';
  			var toleranciaCat = 0.9;

  			for(var i=0; i<doc.Empresas.length; i++){
  				var mediaMes = doc.Empresas[i].datosEmpresa.pedCompras12.replace(/\./g,"").replace(",",".") / 12;
  				var mediaDia = doc.Empresas[i].datosEmpresa.pedMesAnt.replace(/\./g,"").replace(",",".") / 30;

  				lineasTabla += "<tr style='line-height:30px;border-bottom:1px solid #999;'><td style='text-align:left;border-right:1px solid #999;padding-left:10px;'>";
  				lineasTabla += "<a href=\"javascript:tablaResumenEmpresa(" + doc.Empresas[i].datosEmpresa.empID + ");\"><img src=\"http://www.newco.dev.br/images/tabla.gif\"/></a>&nbsp;";
  				lineasTabla += "<a href=\"javascript:MostrarPagPersonalizada(\'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID="+doc.Empresas[i].datosEmpresa.empID+"\',\'Cliente\',100,80,0,0);\">"+doc.Empresas[i].datosEmpresa.empNombre+"</a></td>";
  				lineasTabla += "<td>"+doc.Empresas[i].datosEmpresa.empPotCatalogo+"</td>";

  				//catCatal
  				if(doc.Empresas[i].datosEmpresa.catCatal.replace(/\./g,"").replace(",",".") > (doc.Empresas[i].datosEmpresa.empPotCatalogo.replace(/\./g,"").replace(",",".") * toleranciaCat)){
  					lineasTabla += "<td class='verde'>"+doc.Empresas[i].datosEmpresa.catCatal+"</td>";
  				}else{
  					lineasTabla += "<td class='rojo2'>"+doc.Empresas[i].datosEmpresa.catCatal+"</td>";
  				}

  				//catAdj
  				if(doc.Empresas[i].datosEmpresa.catAdj.replace(/\./g,"").replace(",",".") > (doc.Empresas[i].datosEmpresa.catCatal.replace(/\./g,"").replace(",",".") * toleranciaCat)){
  					lineasTabla += "<td class='verde'>"+doc.Empresas[i].datosEmpresa.catAdj+"</td>";
  				}else{
  					lineasTabla += "<td class='rojo2'>"+doc.Empresas[i].datosEmpresa.catAdj+"</td>";
  				}

  				//catComprados12
  				if(doc.Empresas[i].datosEmpresa.catComprados12.replace(/\./g,"").replace(",",".") > (doc.Empresas[i].datosEmpresa.catAdj.replace(/\./g,"").replace(",",".") * toleranciaCat)){
  					lineasTabla += "<td class='verde' style='border-right:1px solid #999;'>"+doc.Empresas[i].datosEmpresa.catComprados12+"</td>";
  				}else{
  					lineasTabla += "<td class='rojo2' style='border-right:1px solid #999;'>"+doc.Empresas[i].datosEmpresa.catComprados12+"</td>";
  				}

  				//pedCompras12
  				if(doc.Empresas[i].datosEmpresa.pedCompras12.replace(/\./g,"").replace(",",".") > (doc.Empresas[i].datosEmpresa.empPotComprasMens.replace(/\./g,"").replace(",",".") * 12 * toleranciaCat)){
  					lineasTabla += "<td class='verde'>"+doc.Empresas[i].datosEmpresa.pedCompras12+"</td>";
  				}else{
  					lineasTabla += "<td class='rojo2'>"+doc.Empresas[i].datosEmpresa.pedCompras12+"</td>";
  				}

  				lineasTabla += "<td>"+doc.Empresas[i].datosEmpresa.empPotComprasMens+"</td>";

  				//pedMesAnt
  				if(doc.Empresas[i].datosEmpresa.pedMesAnt.replace(/\./g,"").replace(",",".") > mediaMes){
  					lineasTabla += "<td class='verde'>"+doc.Empresas[i].datosEmpresa.pedMesAnt+"</td>";
  				}else{
  					lineasTabla += "<td class='rojo2'>"+doc.Empresas[i].datosEmpresa.pedMesAnt+"</td>";
  				}

  				//ped30Dias
  				if(doc.Empresas[i].datosEmpresa.ped30Dias.replace(/\./g,"").replace(",",".") > mediaMes){
  					lineasTabla += "<td class='verde'>"+doc.Empresas[i].datosEmpresa.ped30Dias+"</td>";
  				}else{
  					lineasTabla += "<td class='rojo2'>"+doc.Empresas[i].datosEmpresa.ped30Dias+"</td>";
  				}

  				//pedUltimosDias
  				if(doc.Empresas[i].datosEmpresa.pedUltimoDia.replace(/\./g,"").replace(",",".") > mediaMes){
  					lineasTabla += "<td class='verde'>"+doc.Empresas[i].datosEmpresa.pedUltimoDia+"</td>";
  				}else{
  					lineasTabla += "<td class='rojo2'>"+doc.Empresas[i].datosEmpresa.pedUltimoDia+"</td>";
  				}

  				lineasTabla += "<td style='border-right:1px solid #999;'>"+doc.Empresas[i].datosEmpresa.pedDiaActual+"</td>";
  				lineasTabla += "<td>"+doc.Empresas[i].datosEmpresa.incPedPend+"</td>";
  				lineasTabla += "<td>"+doc.Empresas[i].datosEmpresa.incPedProbl+"</td>";
  				lineasTabla += "</tr>";
  			}

  			jQuery("#tablaEmpresas tbody").append(lineasTabla);
      }
		}
	});
}
*/

function calcularArrayNormalizador(arrayValores, arrayGrupos, lengthX){
	var max=0;

	for(var i=0; i<arrayGrupos.length; i++){
		max = 0;
		for(var j=0;j<lengthX;j++){
			if(arrayValores[i][j] > max)
				max = arrayValores[i][j];
		}

		arrayNormalizador[i] = max;
	}
}

//	18ago16 
function abrirInformes(IDEmpresa, idInforme){
    //alert('abrirInformes:'+idInforme);
	var Enlace	= 'http://www.newco.dev.br/Gestion/EIS/EISInformes.xsql?IDEMPRESA=' + IDEmpresa +'&IDINFORME='+idInforme;

	MostrarPagPersonalizada(Enlace, '_blank', 100, 80, 0, 10);
}

/*
function abrirInformes(IDEmpresa){
    var idInforme = jQuery("#IDINFORME").val();
    alert('abrirInformes2:'+idInforme);
	var Enlace	= 'http://www.newco.dev.br/Gestion/EIS/EISInformes.xsql?IDEMPRESA=' + IDEmpresa +'&amp;IDINFORME='+idInforme;

	MostrarPagPersonalizada(Enlace, '_blank', 100, 80, 0, 10);
}
*/



/*
	3feb20 Nueva librería gráfica charts.js
*/
function preparaTablaDiaria(Datasets, Labels, pos) {
    var ctx = document.getElementById("actDiaria").getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: Labels,
            datasets: [
                            {
                                label: Datasets[pos].label,
                                borderColor: Datasets[pos].borderColor,						// azul oscuro
                                backgroundColor: Datasets[pos].backgroundColor,				//	azul claro
                                data: Datasets[pos].data
                            }
                        ]

        },
    });
}

function preparaTablaMensual(Datasets, Labels, pos) {
    var ctx = document.getElementById("actMensual").getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: Labels,
            datasets: [
                            {
                                label: Datasets[pos].label,
                                borderColor: Datasets[pos].borderColor,						// azul oscuro
                                backgroundColor: Datasets[pos].backgroundColor,				//	azul claro
                                data: Datasets[pos].data
                            }
                        ]

        },
    });
}


function preparaTablas()
{
/*
	for (var j=0;j<DatasetsDiario.length;++j)
	{
		console.log('tabladiaria ('+j+')'+DatasetsDiario[j].label);
		for (var i=0;i<DatasetsDiario[j].data.length;++i)
		{
			console.log('tabladiaria ('+j+','+i+')'+DatasetsDiario[j].data[i]);
		}
	}
*/
    preparaTablaMensual(DatasetsMensual, NombresMeses, 0);
    preparaTablaDiaria(DatasetsDiario, NombresDias, 0);
}

function cargaSelect(IDSelect, Datasets){
    var despl = document.getElementById(IDSelect);
    for(var i=0;i<Datasets.length;i++)
	{ 
       despl.options[i] = new Option(Datasets[i].label,i);
    }
}

function Inicio()
{
	cargaSelect('IDINDICADORMENSUAL',DatasetsMensual);
	cargaSelect('IDINDICADORDIARIO',DatasetsDiario);
	preparaTablas();
}

//	Al cambiar el indicador se redibuja el grafico correspondiente
function CambioIndicador(Tipo)
{
	if (Tipo=='DIARIO')
	{
    	preparaTablaDiaria(DatasetsDiario, NombresDias, jQuery('#IDINDICADORDIARIO').val());
	}
	else
	{
	    preparaTablaMensual(DatasetsMensual, NombresMeses, jQuery('#IDINDICADORMENSUAL').val());	
	}
}




