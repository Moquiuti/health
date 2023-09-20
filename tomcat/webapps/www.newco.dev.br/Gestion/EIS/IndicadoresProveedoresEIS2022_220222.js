//	JS para los indicadores de proveedores
//	Ultima revision: ET 15mar22 10:20 IndicadoresProveedoresEIS2022_220222.js

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

//	19abr21 En caso de seleccionar "Otros" mostramos los valores por defecto
function CambioPeriodo()
{
	if (jQuery('#PERIODO').val()!='OTROS')
		Recarga();
	else
	{
		jQuery('.avanzadas').show();
	}
}

function Buscar()
{
	//	Comprueba fechas
	Recarga();
}

function OtraVentana()
{
	var frmFiltro=document.forms["frmFiltro"];
	var IDCliente=frmFiltro.elements["IDCLIENTE"].value,
		IDCentro=(frmFiltro.elements["IDCENTRO"]?frmFiltro.elements["IDCENTRO"].value:-1),
		IDProveedor=frmFiltro.elements["IDPROVEEDOR"].value,
		Periodo=frmFiltro.elements["PERIODO"].value;
		
	MostrarPagPersonalizada('http://www.newco.dev.br/Gestion/EIS/IndicadoresProveedoresEIS2022.xsql?IDCLIENTE='+IDCliente+'&IDCENTRO='+IDCentro+'&IDPROVEEDOR='+IDProveedor+'&PERIODO='+Periodo,'_blank',70,70,0,0);	
}


function Graficos()
{
	var Etiquetas = [txtLicitacion, txtAprobacion, txtAceptacion, txtPreparacion, txtTransporte ];
	var DatosCompras=[TMLicitacion, TMAprobacion, TMAceptacion, TMPreparacion, TMTransporte, 0];
	GraficoBarras('cvGrafProcesoCompra', Etiquetas, DatosCompras, TitProcPedido, '#3e95cd');

	if (IDFiltroProveedor==-1)
	{
		//	Gráfico general de licitacion
		var Etiquetas = [txtEstudioPrevio, txtOfertas, txtAdjudicacion, txtPrepPedidos ];
		var DatosCompras=[TMEstudioPrevio, TMOfertas, TMAdjudicacion, TMPedidos, 0];
		GraficoBarras('cvGraficoProcesoLicitacion', Etiquetas, DatosCompras, TitProcLicitacion, '#3e95cd');
	}
	else
	{
		//	Gráfico de licitación aplicado al proveedor
		var Etiquetas = [txtOferta1dia, txtOferta2dias, txtOferta3dias, txtOferta4dias, txtOferta4diasOMas ];
		var DatosCompras=[TOferta1dia, TOferta2dias, TOferta3dias, TOferta4dias, TOferta4diasOMas, 0];
		GraficoBarras('cvGraficoProcesoLicitacion', Etiquetas, DatosCompras, TitTiempoMedioOfertas, '#3e95cd');
	}

	var Etiquetas = [TitPuntuales, TitRetrasados1dia, TitRetrasados2dias, TitRetrasados3dias, TitRetrasados4dias, TitRetrasados5diasOMas];
	var DatosRetraso=[PedPendientes, PedRetrasados1dia, PedRetrasados2dias, PedRetrasados3dias, PedRetrasados4dias, PedRetrasados5diasOMas, 0];
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
	
	
	
	//LICITACIONES
	if (IDFiltroProveedor==-1)
	{
		//	Gráfico general de licitacion
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
	else
	{
		//	Gráfico de licitación aplicado al proveedor
		var Etiquetas = [txtLicNoInformadas, txtLicInformadas ];
		var Datos=[NumLicNoInformadas, NumLicInformadas];
		GraficoTarta("cvGrafico3", Etiquetas, Datos, TitLicInfInv);

		var Etiquetas = [txtLicNoAdjudicadas, txtLicAdjudicadas];
		var Datos=[NumLicInformadas-NumLicAdjudicadas, NumLicAdjudicadas];
		GraficoTarta("cvGrafico4", Etiquetas, Datos, TitLicAdjInf);
/*
		var Etiquetas = [TitLicMenos3dias, TitRestoLic ];
		var Datos=[LicMenosDe3Dias,LicTotal-LicMenosDe3Dias];
		GraficoTarta("cvGrafico7", Etiquetas, Datos, TitLicMenos3dias);

		var Etiquetas = [TitLicMas7dias, TitRestoLic ];
		var Datos=[LicMasDe7Dias,LicTotal-LicMasDe7Dias];
		GraficoTarta("cvGrafico8", Etiquetas, Datos, TitLicMas7dias);
*/
	}	

}
	
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

	//console.log('GraficoBarras:'+Grafico+' Datos:'+Datos[0]+','+Datos[1]+','+Datos[2]);

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

//	Mantenemos el cliente seleccionado al cambiar a Indicadores
function Condiciones()
{
	window.location="http://www.newco.dev.br/Gestion/Comercial/CondicionesProveedores2022.xsql?IDCLIENTE="+document.forms["frmFiltro"].elements["IDCLIENTE"].value;
}

//	Mantenemos el cliente seleccionado al cambiar a Indicadores
function Clasificacion()
{
	window.location="http://www.newco.dev.br/Gestion/EIS/ClasificacionProveedoresEIS2022.xsql?IDCLIENTE="+document.forms["frmFiltro"].elements["IDCLIENTE"].value;
}

//	Mantenemos el cliente seleccionado al cambiar a Evaluacion proveedor
function Evaluacion()
{
	window.location="http://www.newco.dev.br/Gestion/EIS/EvaluacionProveedor2022.xsql?IDCLIENTE="+document.forms["frmFiltro"].elements["IDCLIENTE"].value
				+"&IDPROVEEDOR="+document.forms["frmFiltro"].elements["IDPROVEEDOR"].value
				+"&PERIODO="+document.forms["frmFiltro"].elements["PERIODO"].value
				+"&FECHA_INICIO="+document.forms["frmFiltro"].elements["FECHA_INICIO"].value
				+"&FECHA_FINAL="+document.forms["frmFiltro"].elements["FECHA_FINAL"].value;
}


//	Muestra la ficha de empresa para el proveedor seleccionado
function FichaEmpresa(IDEmpresa)
{
	MostrarPagPersonalizada("http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame2022.xsql?EMP_ID="+IDEmpresa+"&amp;VENTANA=NUEVA",'DetalleEmpresa',100,58,0,-50);
}

