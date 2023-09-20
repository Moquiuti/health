//	JS para el historico de datos de un producto
//	Ultima revisión ET 12jun23 12:12. HistoricoTarifasProducto2022_110623.js

//	funcion a ejecutar al cargarse la pagina
function Inicio()
{
	console.log('Inicio. 12jun23 12:32');
	
	PresentaTabla();
	PresentaGrafico(0);
}


//	Prepara la tabla correspondiente a los ultimos 2 annos
function PresentaTabla()
{
	var Precios='', Pedidos='', Cantidad='', Total='';//, Titulo='';
	
	/*if (IDProdEstandar!=-1)
	{
		Titulo='<span class="marginLeft50"><bold>('+RefEstandar+', '+RefCliente+') '+DescEstandar+'</bold></span><br/><br/>';
	}
	Titulo+='<span class="marginLeft50"><bold>'+Proveedor+': ('+refProducto+') '+Producto+'</bold></span><br/><br/><br/>';*/

	var tablaHTML='<div class="tabela tabela_redonda"><table class="tableCenter w95" cellspacing="2px" cellpadding="2px"><thead class="cabecalho_tabela"><tr>';

	//	cabecera de la tabla con las fechas
	tablaHTML+='<th class="textLeft w100px">&nbsp;&nbsp;'+txtFecha+'</th>';

	Precios+='<tr class="conhover"><td class="textLeft">&nbsp;&nbsp;<a href="javascript:PresentaGrafico(0)">'+txtPrecio+'</a></td>';
	Pedidos+='<tr class="conhover"><td class="textLeft">&nbsp;&nbsp;<a href="javascript:PresentaGrafico(1)">'+txtPedidos+'</a></td>';
	Cantidad+='<tr class="conhover"><td class="textLeft">&nbsp;&nbsp;<a href="javascript:PresentaGrafico(2)">'+txtCantidad+'</a></td>';
	Total+='<tr class="conhover"><td class="textLeft">&nbsp;&nbsp;<a href="javascript:PresentaGrafico(3)">'+txtTotal+'</a></td>';
	for (var i=0;i<arrTarifas.length;++i)
	{
		//solodebug	console.log('PresentaTabla('+i+'):'+arrTarifas[i].FechaInicio);
		
		tablaHTML+='<th class="w60px">'+arrTarifas[i].FechaInicio+'</th>';
		Precios+='<td class="textRight">'+arrTarifas[i].Importe+'</td>';
		Pedidos+='<td class="textRight">'+arrTarifas[i].NumPedidos+'</td>';
		Cantidad+='<td class="textRight">'+arrTarifas[i].Cantidad+'</td>';
		Total+='<td class="textRight">'+arrTarifas[i].ImporteTotal+'</td>';
	}
	
	tablaHTML+='</th></tr></thead><tbody class="corpo_tabela">'+Precios+'</tr>'+Pedidos+'</tr>'+Cantidad+'</tr>'+Total+'</tr></tbody></table></div>';
	
	jQuery('#divTablaDatos').html(/*Titulo+*/tablaHTML);
}


//	Cambia el centro seleccionado y genera la busqueda
function CambiaCentro(IDCentro)
{
	jQuery('#IDCENTRO').val(IDCentro);
	Buscar();
}


//
//	Declaraciones y funciones para el manejo de los graficos
//
var myChart;

//	Paleta de colores, para hasta 40 líneas
var PaletaColores=['#0932F0','#204A87','#F00923','#48DAF1','#2EF953','#F28C87','#7C8486','#8F5902','#C17D11','#E9B96E','#EDD400',
'#729FCF','#73D216','#F57900','#FCE94F','#888A85','#A40000','#8F5902','#729FCF','#5C3566','#C4A000','#8AE234',
'#555753','#AD7FA8','#F4F137','#F4373B','#74A4E1','#CE259E','#873570','#F76E0B','#80CD18','#7279A5','#4F209F',
'#2E3436','#C6C44E','#3465A4','#F5902D','#A4EC43','#939EDC','#A37FE0','#7FE0CB','#516E94','#EB090E','#E32FCF'];


//	Prepara el grafico
function PresentaGrafico(Campo)
{	
	var Datasets=[];
	var Columnas=[];
	var Labels =[];
	
	var Dataset= [];
	Dataset["data"]=[];	
	for (var i=0;i<arrTarifas.length;++i)
	{
		Labels[i]=arrTarifas[i].FechaInicio;

		switch (Campo) {
		  case 0:
    		Dataset["data"][i]=arrTarifas[i].Importe;
    		break;
		  case 1:
    		Dataset["data"][i]=arrTarifas[i].NumPedidos;
    		break;
		  case 2:
    		Dataset["data"][i]=arrTarifas[i].Cantidad;
    		break;
		  case 3:
    		Dataset["data"][i]=arrTarifas[i].ImporteTotal;
    		break;
		}
	}	
	Dataset["label"]=Label[Campo];
    Dataset["borderColor"]=PaletaColores[0];
    Dataset["backgroundColor"]=PaletaColores[0];
    Dataset["fill"]=false;
	Datasets.push(Dataset);

	if (document.getElementById("actTarifas"))
	{
    	var ctx = document.getElementById("actTarifas").getContext('2d');

		if (myChart)
        	myChart.destroy();

    	myChart = new Chart(ctx, {
        	type: 'line',
        	data: {
            	labels: Labels,
            	datasets: Datasets,
    			options: {
        			responsive: true,
        			scales: {
            			y: {
                    			beginAtZero:true
            			}
        			}
    			}

        	},
    	});
	}
}


//	Abrimos la pagina de analisis de pedidos filtrada por el producto actual
function AnalisisPedidos(IDProducto)
{
	document.location="http://www.newco.dev.br/Personal/BandejaTrabajo/AnalisisPedidos2022.xsql?IDPRODUCTO="+IDProducto;
}

//	Abrimos la pagina de historico de compras del productos
function HistoricoCompras(IDProducto, IDEmpresa)
{
	document.location="http://www.newco.dev.br/Gestion/EIS/HistoricoComprasProducto2022.xsql?IDPRODUCTO="+IDProducto+'&IDEMPRESA='+IDEmpresa;
}






