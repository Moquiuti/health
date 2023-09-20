//	JS para los indicadores de proveedores
//	Ultima revision: ET 22mar20 18:30 IndicadoresProveedoresEIS_220320.js

function inicio()
{
	console.log('inicio');
	PresentaGraficos();
}

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

function PresentaGraficos()
{
	var Etiquetas = [txtLicitacion, txtAprobacion, txtAceptacion, txtPreparacion, txtTransporte ];
	var DatosCompras=[TMLicitacion, TMAprobacion, TMAceptacion, TMPreparacion, TMTransporte, 0];
	preparaTablaDiaria('cvGrafProcesoCompra', Etiquetas, DatosCompras, TitProcPedido, '#3e95cd');

/*
	var TotalPedidos=<xsl:value-of select="/IndicadoresProveedores/PEDIDOS/TOTAL" />;
	var PedPendientes=<xsl:value-of select="/IndicadoresProveedores/PEDIDOS/PENDIENTES" />;
	var PedRetrasados=<xsl:value-of select="/IndicadoresProveedores/PEDIDOS/RETRASADOS" />;
	var PedParciales=<xsl:value-of select="/IndicadoresProveedores/PEDIDOS/PARCIALES" />;
	var PedUrgentes=<xsl:value-of select="/IndicadoresProveedores/PEDIDOS/URGENTES" />;
*/

	var Etiquetas = [TitUrgentes, TitResto];
	var Datos=[PedUrgentes,TotalPedidos-PedUrgentes];
	PresentaGrafico("cvGraficoA", Etiquetas, Datos, TitUrgentes);
	
	var Etiquetas = [TitParciales, TitResto ];
	var Datos=[PedParciales,TotalPedidos-PedParciales];
	PresentaGrafico("cvGraficoB", Etiquetas, Datos, TitParciales);

	var Etiquetas = [TitRetrasados, TitResto ];
	var Datos=[PedRetrasados,TotalPedidos-PedRetrasados];
	PresentaGrafico("cvGrafico1", Etiquetas, Datos, TitRetrasados);
	
	
	var Etiquetas = [TitRetrasados2dias, TitResto ];
	var Datos=[PedRetrasados2dias,TotalPedidos-PedRetrasados2dias];
	PresentaGrafico("cvGrafico2", Etiquetas, Datos, TitRetrasados2dias);

	var Etiquetas = [TitRetrasados4dias, TitResto ];
	var Datos=[PedRetrasados4dias,TotalPedidos-PedRetrasados4dias];
	PresentaGrafico("cvGrafico3", Etiquetas, Datos, TitRetrasados4dias);

	var Etiquetas = [TitRetrasados7dias, TitResto ];
	var Datos=[PedRetrasados7dias,TotalPedidos-PedRetrasados7dias];
	PresentaGrafico("cvGrafico4", Etiquetas, Datos, TitRetrasados7dias);


	var Etiquetas = [txtProvInformados, txtProvInvitados ];
	var Datos=[LicProveedoresInf,LicProveedores];
	PresentaGrafico("cvGrafico5", Etiquetas, Datos, TitProvInfInv);

	var Etiquetas = [txtProvAdjudicados, txtProvInformados];
	var Datos=[LicProveedoresAdj,LicProveedoresInf];
	PresentaGrafico("cvGrafico6", Etiquetas, Datos, TitProvAdjInf);

	var Etiquetas = [TitLicMenos3dias, TitRestoLic ];
	var Datos=[LicMenosDe3Dias,LicTotal-LicMenosDe3Dias];
	PresentaGrafico("cvGrafico7", Etiquetas, Datos, TitLicMenos3dias);

	var Etiquetas = [TitLicMas7dias, TitRestoLic ];
	var Datos=[LicMasDe7Dias,LicTotal-LicMasDe7Dias];
	PresentaGrafico("cvGrafico8", Etiquetas, Datos, TitLicMas7dias);

}
	
	
function PresentaGrafico(Grafico, Etiquetas, Datos, Titulo)
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

function preparaTablaDiaria(Grafico, Etiquetas, Datos, Titulo, color) {
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
