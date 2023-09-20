//	Funciones Javascript

jQuery(document).ready(globalEvents);

var arrayNormalizador = new Array(100);

function globalEvents(){
	GraficoDiarioGoogle();
	GraficoMensualGoogle();
        
        //veo las varias tablas
        jQuery("#PestanasEis tr th").mouseover (function(){ this.style.cursor="pointer"; });
	jQuery("#PestanasEis tr th").mouseout (function(){ this.style.cursor="default"; });
        jQuery("#alarmas").click(function(){ 
                                    var ancho = '';
                                    var alto = '';
                                    if (screen.width<1024){
                                        ancho = '355';
                                        alto = '350';
                                    }
                                    else if (screen.width<1280){
                                        ancho = '450';
                                        alto = '350';
                                    }
                                    else if (screen.width<1366){
                                        ancho = '545';
                                        alto = '350';
                                    }
                                    else if (screen.width<1400){
                                    ancho = '620';
                                    alto = '350';
                                    }
                                    else{ 
                                        ancho = '700';
                                        alto = '350';
                                    }
                                    if (jQuery("#graficoGoogleDiario").is(':visible')){
                                        jQuery("#graficoGoogleDiario").hide();
                                        jQuery("#alarmasBox").css('width',ancho);
                                        jQuery("#alarmasBox").css('height','auto');
                                        jQuery("#alarmasBox").show();
                                    }
                                    else{
                                        jQuery("#alarmasBox").hide();
                                        jQuery("#graficoGoogleDiario").css('width',ancho);
                                        jQuery("#graficoGoogleDiario").css('height',alto);
                                        jQuery("#graficoGoogleDiario").show();
                                    }
        });
        jQuery("#cerrarAlarmas").mouseover (function(){ this.style.cursor="pointer"; });
	jQuery("#cerrarAlarmas").mouseout (function(){ this.style.cursor="default"; });
        jQuery("#cerrarAlarmas").click (function(){ jQuery("#alarmasBox").hide();
                                                    jQuery("#graficoGoogleDiario").show();
                                                });
        
        /*jQuery("#PestanasEis tr th").click (function(){
                        var k = this.id;
                        //jQuery("#PestanasEis tr th").css('background','#E3E2E2');
                        jQuery(".boxEIS").css('display','none');
                        
                        //jQuery(this).css('background','#C3D2E9');
                        jQuery("#"+k+"Box").css('display','');
                        //alert(k);
        });*/
    
        //veo las varias tablas
       
       
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

//version navegador para tele enseño icono para babrir popup en nueva pagina
function navigador(){
	var browserName	= navigator.appName;
	var version	= navigator.appVersion;

	//tele browser Netscape version 5.0(X11;Linux i 686) AppleWebKit/534.7 (KHTML;like Gecko)
	if(version.match('X11;Linux i 686') || version.match('AppleWebKit/534.7')){
		jQuery('.newPage').show();
	}
}

//info diaria + clientes seleccionados
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

			jQuery("#numPedidosDiaAnterior").append(doc.infoDiaria.numPedidosDiaAnterior);
			jQuery("#importePedidosDiaAnterior").append(doc.infoDiaria.importePedidosDiaAnterior);
			jQuery("#controlPedidosDiaAnterior").append(doc.infoDiaria.controlPedidosDiaAnterior);

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
	});
}

//	Prepara los datos para mostrar el grafico diario de la pagina
function GraficoDiarioGoogle(){
        
        var ancho = '';
        var alto = '';
        if (screen.width<1024){
            ancho = '355';
            alto = '350';
        }
        else if (screen.width<1280){
            ancho = '450';
            alto = '350';
        }
        else if (screen.width<1366){
            ancho = '545';
            alto = '350';
        }
        else if (screen.width<1400){
        ancho = '620';
        alto = '350';
        }
        else{ 
            ancho = '700';
            alto = '350';
        }
    
	calcularArrayNormalizador(ValoresGraficoDiario, GruposDiario, NumDias);

	var data = new google.visualization.DataTable();

	data.addColumn('string', 'X');
	for(var i=0; i<NumGruposDiario; i++){
		data.addColumn('number', NombresGruposDiario[i]);
		data.addColumn({type: 'number', role: 'tooltip'});
	}

	for(var j=0; j<NumDias; j++){

		var items = new Array();
		items[0]	= NombresDias[j];
                
		for(i=0; i<NumGruposDiario; i++){
//			items[i+1]	= ValoresGraficoDiario[i][j] / arrayNormalizador[i];
			items[(i*2)+1]	= ValoresGraficoDiario[i][j] / arrayNormalizador[i];
			items[(i*2)+2]	= ValoresGraficoDiario[i][j];
		}

		data.addRow(items);
        }


	var options = {
		title: tituloGraficoDiario,
		width: ancho,
		height: alto,
                'chartArea': {'width': '90%', 'height': '70%'},
                pointSize:0,
		isStacked: true,
		legend: {
			position: 'bottom',
			textStyle: {
				fontSize: 9
			}
		},
		hAxis: {
			title: tituloHAxisDiario,
			titleTextStyle: {
				fontSize: 12,
				bold: true
			},
			viewWindowMode:'explicit',
			viewWindow: {
				min: 0,
				max: NombresDias.length
			},
			textStyle: {
				fontSize: 10
			}
		},
		vAxis: {
/*			title: '%',*/
			viewWindowMode:'explicit',
			viewWindow: {
				min: 0,
				max: 1.1
			},
			textStyle: {
				fontSize: 10
			}
		}
/*
		},
		colors: ['#a52714', '#097138']
*/
	};

	var chart = new google.visualization.LineChart(document.getElementById('graficoGoogleDiario'));

	chart.draw(data, options);
}

//	Prepara los datos para mostrar el grafico mensual de la pagina
function GraficoMensualGoogle(){
    var ancho = '';
    var alto = '';
    if (screen.width<1024){
        ancho = '400';
        alto = '350';
    }
    else if (screen.width<1280){
        ancho = '500';
        alto = '350';
    }
    else if (screen.width<1366){
        ancho = '670';
        alto = '350';
    }
    else if (screen.width<1400){
        ancho = '680';
        alto = '350';
    }
    else{ 
        ancho = '700';
        alto = '350';
    }

	calcularArrayNormalizador(ValoresGraficoMensual, GruposMensual, NumMeses);

	var data = new google.visualization.DataTable();

	data.addColumn('string', 'X');
	for(var i=0; i<NumGruposMensual; i++){
		data.addColumn('number', NombresGruposMensual[i]);
		data.addColumn({type: 'number', role: 'tooltip'});
	}

	for(var j=0; j<NumMeses; j++){

		var items = new Array();
		items[0]	= NombresMeses[j];
                
		for(i=0; i<NumGruposMensual; i++){
//			items[i+1]	= ValoresGraficoMensual[i][j] / arrayNormalizador[i];
			items[(i*2)+1]	= ValoresGraficoMensual[i][j] / arrayNormalizador[i];
			items[(i*2)+2]	= ValoresGraficoMensual[i][j];
		}

		data.addRow(items);
        }

	var options = {
		title: tituloGraficoMensual,
		width: ancho,
		height: alto,
                'chartArea': {'width': '90%', 'height': '70%'},
//                enableInteractivity: false,
		isStacked: true,
		legend: {
			position: 'bottom',
			textStyle: {
				fontSize: 10
			}
		},
		hAxis: {
			title: tituloHAxisMensual,
			titleTextStyle: {
				fontSize: 11,
				bold: true
			},
			viewWindowMode:'explicit',
			viewWindow: {
				min: 0,
				max: NombresMeses.length
			},
			textStyle: {
				fontSize: 10
			}
		},
		vAxis: {
/*			title: '%',*/
			viewWindowMode:'explicit',
			viewWindow: {
				min: 0,
				max: 1.1
			},
			textStyle: {
				fontSize: 10
			}
                }
/*
		},
		series: [{
			name: 'Control Pedidos',
			marker: {
				symbol: 'square'
			},
			data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
                }]
		},
		colors: ['#a52714', '#097138']
*/
	};

	var chart = new google.visualization.LineChart(document.getElementById('graficoGoogleMensual'));

	chart.draw(data, options);
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

function abrirInformes(IDEmpresa){
	var Enlace	= 'http://www.newco.dev.br/Gestion/EIS/EISInformes.xsql?IDEMPRESA=' + IDEmpresa;

	MostrarPagPersonalizada(Enlace, '_blank', 100, 80, 0, 10);
}