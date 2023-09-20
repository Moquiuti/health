//	JS. Pagina principal del EIS. CUIDADO! Este JS se utiliza tambien en WFStatusHTML2022 para mostrar el grafico de la pagina de inicio.
//	Ultima revisión ET 10mar22 12:30 EISConsultas2022_100322.js

jQuery(document).ready(globalEvents);

var arrayNormalizador = new Array(100);

function globalEvents(){


	//	Marcamos la primera opción de menú
	jQuery("#actividadMensual").attr('class', 'MenuActivo');


	jQuery("#pestannas a").click(function(){

		var id = jQuery(this).attr('id');
		
		jQuery(".pestannas a").attr('class', 'MenuInactivo');
		jQuery("#"+id).attr('class', 'MenuActivo');
		
		jQuery(".eisBox").hide();
		jQuery("#"+id+"Box").show();
	});


    //veo las varias tablas
    jQuery("#PestanasEis tr th").mouseover (function(){ this.style.cursor="pointer"; });
	jQuery("#PestanasEis tr th").mouseout (function(){ this.style.cursor="default"; });

}


//	EIS Menusal, consulta de PEDIDOS
function MostrarConsultaPedidos(){
	MostrarConsulta('COPedidosPorEmpEur');
}

//	EIS Mensual
function MostrarConsulta(Consulta){
	var Enlace	= 'http://www.newco.dev.br/Gestion/EIS/EISBasico2022.xsql?IDCONSULTA='+Consulta;

	MostrarPagPersonalizada(Enlace, '_blank', 100, 80, 0, 10);
}

//	Presenta la pagina con el listado correspondiente a la seleccion del usuario
function MostrarInicio(){
	var Enlace	= 'http://www.newco.dev.br/Gestion/EIS/EISInicio.xsql';

	MostrarPagPersonalizada(Enlace, '_blank', 100, 80, 0, 10);
}

//	Presenta la pagina con el listado correspondiente a la seleccion del usuario
function MostrarMatriz(){
	var Enlace	= 'http://www.newco.dev.br/Gestion/EIS/EISMatriz2022.xsql';

	//16mar22 Reducimos pop-ups...MostrarPagPersonalizada(Enlace, '_blank', 100, 80, 0, 10);
	window.location=Enlace;
}

//	Presenta la pagina con el EIS Anual
function MostrarConsultaAnual(){
	var Enlace	= 'http://www.newco.dev.br/Gestion/EIS/EISAnual2022.xsql';

	//16mar22 Reducimos pop-ups...MostrarPagPersonalizada(Enlace, '_blank', 100, 80, 0, 10);
	window.location=Enlace;
}

//	Presenta la pagina con los proveedores. 15mar22: en la misma página, sin Pop-Up
function Proveedores(){
	var Enlace	= 'http://www.newco.dev.br/Gestion/EIS/IndicadoresProveedoresEIS2022.xsql';
	//16mar22 Reducimos pop-ups...MostrarPagPersonalizada(Enlace, '_blank', 100, 80, 0, 10);
	window.location=Enlace;
}

//	Presenta la pagina con las condiciones de los proveedores. 15mar22: en la misma página, sin Pop-Up
function CondicionesProveedores(IDEmpresa){
	MostrarPagPersonalizada("http://www.newco.dev.br/Gestion/Comercial/CondicionesProveedores2022.xsql?IDCLIENTE="+IDEmpresa,'Condiciones proveedores',100,80,0,-50);	
}

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
	var Enlace	= 'http://www.newco.dev.br/Gestion/EIS/EISInformes2022.xsql?IDEMPRESA=' + IDEmpresa +'&IDINFORME='+idInforme;

	MostrarPagPersonalizada(Enlace, '_blank', 100, 80, 0, 10);
}



/*
	3feb20 Nueva librería gráfica charts.js
*/
function preparaTablaDiaria(Datasets, Labels, pos) {
	if (document.getElementById("actDiaria"))
	{
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
                        	],
    			options: {
        			responsive: true,
        			scales: {
            			yAxes: [{
                			ticks: {
                    			min:0
                			}
            			}]
        			}
    			}
        	},
    	});
	}
}

function preparaTablaMensual(Datasets, Labels, pos)
{	
	if (document.getElementById("actMensual"))
	{
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
                        	],
    			options: {
        			responsive: true,
        			scales: {
            			yAxes: [{
                			ticks: {
                    			min:0
                			}
            			}]
        			}
    			}

        	},
    	});
	}
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
	debug("cargaSelect:"+Datasets.length);
    var despl = document.getElementById(IDSelect);
    for(var i=0;i<Datasets.length;i++)
	{ 
	   debug("cargaSelect ("+i+"):"+Datasets[i].label);
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

//	28ene22 Incluimos noticias, se requiere la funcion para marcar "leida"
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

