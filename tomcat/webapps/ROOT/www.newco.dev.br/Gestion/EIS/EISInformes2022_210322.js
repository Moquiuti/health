//	JS correspondiente a los informes
//	ultima revisión: ET 21mar22 10:30 EISInformes2022_210322.js

jQuery(document).ready(globalEvents);

function globalEvents(){

	jQuery('#IDCENTROCLIENTE').change(function(){
		var IDEmpresa = document.forms[0].elements["IDEMPRESA"].value;
		location.href = 'http://www.newco.dev.br/Gestion/EIS/EISInformes2022.xsql?IDEMPRESA=' + IDEmpresa + '&IDINFORME=' + IDInforme + '&IDCENTRO=' + this.value;
	});

	jQuery('#IDEMPRESA').change(function(){
		var IDEmpresa = document.forms[0].elements["IDEMPRESA"].value;
		//solodebug	alert('IDEmpresa:'+IDEmpresa);
		location.href = 'http://www.newco.dev.br/Gestion/EIS/EISInformes2022.xsql?IDEMPRESA=' + IDEmpresa + '&IDINFORME=' + IDInforme;
	});
}


function inicio()
{
	//	Recorre la tabla para mostrar los gráficos correspondientes
	presentarGraficos()
}


//	Recorre la tabla para mostrar los gráficos correspondientes
function presentarGraficos()
{
	for (i=0;i<DatasetsMensual.length;++i)
	{
		presentarGrafico(i);
	}
}


//	Recorre la tabla para mostrar los gráficos correspondientes
function presentarGrafico(pos)
{
	console.log('presentarGrafico: '+pos);
	var ID=DatasetsMensual[pos].ID;
	graficoMensual('gr_'+ID, DatasetsMensual, NombresMeses, pos);
}


//	
function graficoMensual(Grafico, Datasets, Labels, pos) 
{

	console.log('graficoMensual: '+Grafico+','+pos);

    var ctx = document.getElementById(Grafico).getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'line',
		maintainAspectRatio: false,					//	1abr20 Permite cambiar el ratio ancho/largo del gráfico
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



function toggleTable(ID){
	jQuery("div#" + ID).toggle();
}


function RecuperaCSV()
{
	var Enlace,
		IDEmpresa = document.forms[0].elements["IDEMPRESA"].value,
		contenidoCSV;

	Enlace = 'http://www.newco.dev.br/Gestion/EIS/EISInformesCSV.xsql?IDEMPRESA=' + IDEmpresa + '&IDINFORME=' + IDInforme;

	if ((document.getElementById("IDCENTROCLIENTE")) && (document.forms[0].elements["IDCENTROCLIENTE"].value!=-1))
		Enlace += '&IDCENTRO=' + document.forms[0].elements["IDCENTROCLIENTE"].value;

	RecuperaCSV_Ajax(Enlace);

}
