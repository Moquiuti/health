//	JS para los indicadores de proveedores
//	Ultima revision: ET 25mar20 18:30 IndicadoresProveedoresEIS_250320.js

function inicio()
{
	console.log('inicio');
	Graficos();
}

//recarga la página con los nuevos parámetros de búsqueda
function Recarga()
{
	document.forms["frmFiltro"].submit();
}

function CambioProveedorActual()
{
	Recarga();
}

function CambioCentroCliente()
{
	Recarga();
}

function CambioEmpresaActual()
{
	Recarga();
}

function CambioPeriodo()
{
	Recarga();
}

function OtraVentana()
{
	var frmFiltro=document.forms["frmFiltro"];
	var IDCliente=frmFiltro.elements["IDCLIENTE"].value,
		IDCentro=(frmFiltro.elements["IDCENTRO"]?frmFiltro.elements["IDCENTRO"].value:-1),
		IDProveedor=frmFiltro.elements["IDPROVEEDOR"].value,
		Periodo=frmFiltro.elements["PERIODO"].value;
		
	MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/EIS/IndicadoresProveedoresEIS.xsql?IDCLIENTE='+IDCliente+'&IDCENTRO='+IDCentro+'&IDPROVEEDOR='+IDProveedor+'&PERIODO='+Periodo,'_blank',70,70,0,0);	
}


function Graficos()
{
	var Etiquetas = [txtLicitacion, txtAprobacion, txtAceptacion, txtPreparacion, txtTransporte ];
	var DatosCompras=[TMLicitacion, TMAprobacion, TMAceptacion, TMPreparacion, TMTransporte, 0];
	GraficoBarras('cvGrafProcesoCompra', Etiquetas, DatosCompras, TitProcPedido, '#3e95cd');

	var Etiquetas = [txtEstudioPrevio, txtOfertas, txtAdjudicacion, txtPrepPedidos ];
	var DatosCompras=[TMEstudioPrevio, TMOfertas, TMAdjudicacion, TMPedidos, 0];
	GraficoBarras('cvGraficoA', Etiquetas, DatosCompras, TitProcLicitacion, '#3e95cd');

	var Etiquetas = [TitPuntuales, TitRetrasados1dia, TitRetrasados2dias, TitRetrasados3dias, TitRetrasados4dias, TitRetrasados5diasOMas];
	var DatosRetraso=[TotalPedidos, PedRetrasados1dia, PedRetrasados2dias, PedRetrasados3dias, PedRetrasados4dias, PedRetrasados5diasOMas, 0];
	GraficoBarras('cvGrafico1', Etiquetas, DatosRetraso, TitRetrasoPedidos, '#0E851F');

	var Etiquetas = [TitUrgentes, TitResto];
	var Datos=[PedUrgentes,TotalPedidos-PedUrgentes];
	GraficoTarta("cvGrafico2", Etiquetas, Datos, TitUrgentes);
	
	var Etiquetas = [TitParciales, TitResto ];
	var Datos=[PedParciales,TotalPedidos-PedParciales];
	GraficoTarta("cvGrafico5", Etiquetas, Datos, TitParciales);

	var Etiquetas = [TitRetrasados, TitResto ];
	var Datos=[PedRetrasados,TotalPedidos-PedRetrasados];
	GraficoTarta("cvGrafico6", Etiquetas, Datos, TitRetrasados);
	
/*	
	var Etiquetas = [TitRetrasados2dias, TitResto ];
	var Datos=[PedRetrasados2dias,TotalPedidos-PedRetrasados2dias];
	GraficoTarta("cvGrafico2", Etiquetas, Datos, TitRetrasados2dias);

	var Etiquetas = [TitRetrasados4dias, TitResto ];
	var Datos=[PedRetrasados4dias,TotalPedidos-PedRetrasados4dias];
	GraficoTarta("cvGrafico3", Etiquetas, Datos, TitRetrasados4dias);

	var Etiquetas = [TitRetrasados7dias, TitResto ];
	var Datos=[PedRetrasados7dias,TotalPedidos-PedRetrasados7dias];
	GraficoTarta("cvGrafico4", Etiquetas, Datos, TitRetrasados7dias);
*/

	var Etiquetas = [txtProvInformados, txtProvInvitados ];
	var Datos=[LicProveedoresInf,LicProveedores];
	GraficoTarta("cvGrafico3", Etiquetas, Datos, TitProvInfInv);

	var Etiquetas = [txtProvAdjudicados, txtProvInformados];
	var Datos=[LicProveedoresAdj,LicProveedoresInf];
	GraficoTarta("cvGrafico4", Etiquetas, Datos, TitProvAdjInf);

	var Etiquetas = [TitLicMenos3dias, TitRestoLic ];
	var Datos=[LicMenosDe3Dias,LicTotal-LicMenosDe3Dias];
	GraficoTarta("cvGrafico7", Etiquetas, Datos, TitLicMenos3dias);

	var Etiquetas = [TitLicMas7dias, TitRestoLic ];
	var Datos=[LicMasDe7Dias,LicTotal-LicMasDe7Dias];
	GraficoTarta("cvGrafico8", Etiquetas, Datos, TitLicMas7dias);

}
/*	24mar20
function Graficos()
{
	var Etiquetas = [txtLicitacion, txtAprobacion, txtAceptacion, txtPreparacion, txtTransporte ];
	var DatosCompras=[TMLicitacion, TMAprobacion, TMAceptacion, TMPreparacion, TMTransporte, 0];
	GraficoBarras('cvGrafProcesoCompra', Etiquetas, DatosCompras, TitProcPedido, '#3e95cd');

	var Etiquetas = [TitUrgentes, TitResto];
	var Datos=[PedUrgentes,TotalPedidos-PedUrgentes];
	GraficoTarta("cvGraficoA", Etiquetas, Datos, TitUrgentes);
	
	var Etiquetas = [TitParciales, TitResto ];
	var Datos=[PedParciales,TotalPedidos-PedParciales];
	GraficoTarta("cvGraficoB", Etiquetas, Datos, TitParciales);

	var Etiquetas = [TitRetrasados, TitResto ];
	var Datos=[PedRetrasados,TotalPedidos-PedRetrasados];
	GraficoTarta("cvGrafico1", Etiquetas, Datos, TitRetrasados);
	
	
	var Etiquetas = [TitRetrasados2dias, TitResto ];
	var Datos=[PedRetrasados2dias,TotalPedidos-PedRetrasados2dias];
	GraficoTarta("cvGrafico2", Etiquetas, Datos, TitRetrasados2dias);

	var Etiquetas = [TitRetrasados4dias, TitResto ];
	var Datos=[PedRetrasados4dias,TotalPedidos-PedRetrasados4dias];
	GraficoTarta("cvGrafico3", Etiquetas, Datos, TitRetrasados4dias);

	var Etiquetas = [TitRetrasados7dias, TitResto ];
	var Datos=[PedRetrasados7dias,TotalPedidos-PedRetrasados7dias];
	GraficoTarta("cvGrafico4", Etiquetas, Datos, TitRetrasados7dias);


	var Etiquetas = [txtProvInformados, txtProvInvitados ];
	var Datos=[LicProveedoresInf,LicProveedores];
	GraficoTarta("cvGrafico5", Etiquetas, Datos, TitProvInfInv);

	var Etiquetas = [txtProvAdjudicados, txtProvInformados];
	var Datos=[LicProveedoresAdj,LicProveedoresInf];
	GraficoTarta("cvGrafico6", Etiquetas, Datos, TitProvAdjInf);

	var Etiquetas = [TitLicMenos3dias, TitRestoLic ];
	var Datos=[LicMenosDe3Dias,LicTotal-LicMenosDe3Dias];
	GraficoTarta("cvGrafico7", Etiquetas, Datos, TitLicMenos3dias);

	var Etiquetas = [TitLicMas7dias, TitRestoLic ];
	var Datos=[LicMasDe7Dias,LicTotal-LicMasDe7Dias];
	GraficoTarta("cvGrafico8", Etiquetas, Datos, TitLicMas7dias);

}
*/	
	
function GraficoTarta(Grafico, Etiquetas, Datos, Titulo)
{	
	for (i=0;i<Etiquetas.length;++i)
		Etiquetas[i]=Etiquetas[i]+': '+Datos[i];

    var ctx = document.getElementById(Grafico).getContext('2d');
    var myChart = new Chart(ctx, {
    	type: 'pie',
    	data: {
    	  labels: Etiquetas,
    	  datasets: [{
        	//label: Titulo,
        	backgroundColor: ["#F04923", "#0E851F"],
        	data: Datos
    	  }]
    	},
    	options: {
    	  title: {
        	display: true,
        	text: Titulo
    	  }
    	}
	});
}

function GraficoBarras(Grafico, Etiquetas, Datos, Titulo, color) {

	console.log('GraficoBarras:'+Grafico+' Datos:'+Datos[0]+','+Datos[1]+','+Datos[2]);

    var ctx = document.getElementById(Grafico).getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: Etiquetas,
            datasets: [
                            {
                                label: Titulo,
                                backgroundColor: color,
                                data: Datos
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
